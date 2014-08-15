{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Cache manager                                           }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxWebFileCacheManager;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils, WebCntxt, HTTPApp;

type
  TcxWebFileCacheType = (cmtMemory, cmtFile);
  TcxWebFileCacheManagerItemType = (mitCustom, mitGif, mitJS, mitJPEG);

  TcxWebFileCacheManager = class
  private
    FList: TList;
    FCacheType: TcxWebFileCacheType;
    FDesignerCount: Integer;
    FInternalImagePath: string;
    FInternalJSPath: string;

    function GetInternalEWFFiles(AID: string): string;
    function InternalAdd(AID: string; AStream: TStream;  AItemType: TcxWebFileCacheManagerItemType): Pointer;
    function GetItem(AID: string): Pointer;
    function GetCacheType: TcxWebFileCacheType;
    procedure Clear;
    procedure LoadFromResources;
  protected
    constructor CreateInstance(ADummy: Boolean = True);
    class function AccessInstance(Request: Integer): TcxWebFileCacheManager;

    property DesignerCount: Integer read FDesignerCount write FDesignerCount;
    property CacheType: TcxWebFileCacheType read GetCacheType write FCacheType;
    property InternalImagePath: string read FInternalImagePath write FInternalImagePath;
    property InternalJSPath: string read FInternalJSPath write FInternalJSPath;
  public
    constructor Create;
    destructor Destroy; override;
    function HandleRequest(ARequest: TWebRequest; AResponse: TWebResponse): Boolean;
    class function Instance: TcxWebFileCacheManager;
    class procedure ReleaseInstance;

    function Add(AID: string; AStream: TStream; AItemType: TcxWebFileCacheManagerItemType = mitJPEG): string;
    function GetEWFImage(AID: string): string;
    function GetEWFJS(AID: string): string;
    procedure GetContent(AID: string; AStream: TStream; ADateTime: TDateTime;
        var AContentType: string; var AStatusCode: Integer);
    procedure IncDesignerCount;
    procedure DecDesignerCount;
  end;


implementation

uses
  {$IFDEF VCL}
  Windows, ComObj,
  {$ELSE}
  Libc, Types,
  {$ENDIF}
  cxWebUtils;

const
  cxWebFileCachePath = 'ewffilecache_id_';
  DefaultContentType = 'image/jpeg';
  GifContentType = 'image/gif';
  JSContentType = 'text/plain';
  cxWebEWFImageSign = 'EWFIMAGES_';
  cxWebEWFJSSign = 'EWFJS_';
  EWFInternalImagePath = 'EWFClient/Images';
  EWFInternalJSPath = 'EWFClient/JS';  


var
  FApplicationFileName: string = '';
  
function GetApplicationFileName: string;
var
  ABuffer: PChar;
begin
  if FApplicationFileName = '' then
  begin
    ABuffer := StrAlloc(MAX_PATH + 1);
    GetModuleFileName(HInstance, ABuffer, MAX_PATH);
    FApplicationFileName := ABuffer;
    StrDispose(ABuffer);
  end;
  Result := FApplicationFileName;
end;

var
  FInternalResourceModifiedDate: TDateTime = 0;

function GetInternalResourceModifiedDate: TDateTime;
var
  AFileAge: Integer;
begin
  if FInternalResourceModifiedDate = 0 then
  begin
    AFileAge := FileAge(GetApplicationFileName);
    if AFileAge > 0 then
      FInternalResourceModifiedDate := FileDateToDateTime(AFileAge)
    else FInternalResourceModifiedDate := Now;
  end;
  Result := FInternalResourceModifiedDate;
end;


type
  TcxWebFileCacheManagerItem = class
  private
    FRefCount: Integer;
    FCacheType: TcxWebFileCacheType;
    FStream: TMemoryStream;
    FId: string;
    FItemType: TcxWebFileCacheManagerItemType;
    FHasSavedIntoFile: Boolean;

    procedure SaveToFile(AStream: TStream);
    procedure LoadFromFile(AStream: TStream);
    function GetFileExtention: string;
    function GetFileName: string;
    function GetContentType: string;
  public
    constructor Create(ACacheType: TcxWebFileCacheType; AID: string;
        AStream: TStream; AItemType: TcxWebFileCacheManagerItemType);
    destructor Destroy; override;

    procedure GetData(AStream: TStream);
    procedure Update(AStream: TStream);

    property CacheType: TcxWebFileCacheType read FCacheType;
    property ContentType: string read GetContentType;
    property ID: string read FID;
    property ItemType: TcxWebFileCacheManagerItemType read FItemType write FItemType;
    property RefCount: Integer read FRefCount;
  end;

{ TcxWebFileCacheManagerItem }

var
  FileCacheLock: TRTLCriticalSection;

constructor TcxWebFileCacheManagerItem.Create(ACacheType: TcxWebFileCacheType;
        AID: string; AStream: TStream; AItemType: TcxWebFileCacheManagerItemType);
begin
  FRefCount := 0;
  FID := AID;
  FCacheType := ACacheType;
  FItemType := AItemType;
  if ACacheType = cmtMemory then
    FStream := TMemoryStream.Create;
  Update(AStream);
end;

destructor TcxWebFileCacheManagerItem.Destroy;
begin
  if FStream <> nil then
    FStream.Free
  else SysUtils.DeleteFile(GetFileName);
  inherited Destroy;
end;

procedure TcxWebFileCacheManagerItem.GetData(AStream: TStream);
begin
  Dec(FRefCount);
  if FStream <> nil then
    FStream.SaveToStream(AStream)
  else LoadFromFile(AStream);
end;

procedure TcxWebFileCacheManagerItem.Update(AStream: TStream);
begin
  Inc(FRefCount);
  if FStream <> nil then
  begin
    FStream.Clear;
    FStream.LoadFromStream(AStream)
  end else SaveToFile(AStream);
end;

function TcxWebFileCacheManagerItem.GetFileExtention: string;
const
  Extentions: Array[TcxWebFileCacheManagerItemType] of string = ('ewf', 'gif', 'js', 'jpg');
begin
  Result := Extentions[ItemType];
end;


function TcxWebFileCacheManagerItem.GetFileName: string;
var
{$IFDEF MSWINDOWS}
  ABuf: PChar;
{$ENDIF}
  I: Integer;
  ATempDir: string;
begin
  Result := ID;
  for I := 1 to Length(Result) do
    if Result[I] in [PathDelim, '.'] then
      Result[I] := '_';
  {$IFDEF MSWINDOWS}
  ABuf := StrAlloc(256);
  GetTempPath(255, ABuf);
  ATempDir := ABuf;
  StrDispose(ABuf);
  {$ENDIF}
  {$IFDEF LINUX}
  ATempDir := '/tmp';
  {$ENDIF}
  if (ATempDir <> '') and (ATempDir[Length(ATempDir)] <> PathDelim) then
    ATempDir := ATempDir + PathDelim;
  Result := ATempDir + Result + '.' + GetFileExtention;
end;

function TcxWebFileCacheManagerItem.GetContentType: string;
const
  Contents: Array[TcxWebFileCacheManagerItemType] of string =
        ('image/jpeg', 'image/gif', 'text/plain', 'image/jpeg');
begin
  Result := Contents[ItemType];
end;

procedure TcxWebFileCacheManagerItem.SaveToFile(AStream: TStream);
var
  AMemoryStream: TMemoryStream;
begin
  if AStream = nil then
  begin
    if not FHasSavedIntoFile or not FileExists(GetFileName) then
      FStream.SaveToFile(GetFileName);
  end else
  begin
    AMemoryStream := TMemoryStream.Create;
    try
      AMemoryStream.LoadFromStream(AStream);
      AMemoryStream.SaveToFile(GetFileName);
    finally
      AMemoryStream.Free;
    end;
  end;
  FHasSavedIntoFile := True;
end;

procedure TcxWebFileCacheManagerItem.LoadFromFile(AStream: TStream);
var
  AMemoryStream: TMemoryStream;
begin
  AMemoryStream := TMemoryStream.Create;
  try
    AMemoryStream.LoadFromFile(GetFileName);
    AMemoryStream.SaveToStream(AStream);
  finally
    AMemoryStream.Free;
  end;
end;

{ TcxWebFileCacheManager }
constructor TcxWebFileCacheManager.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TcxWebFileCacheManager.CreateInstance(ADummy: Boolean = True);
begin
  inherited;
  FList := TList.Create;
  FCacheType := cmtMemory;
  FDesignerCount := 0;
//  FInternalImagePath := EWFInternalImagePath;
//  FInternalJSPath := EWFInternalJSPath;
  LoadFromResources;
end;

destructor TcxWebFileCacheManager.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

function TcxWebFileCacheManager.HandleRequest(ARequest: TWebRequest; AResponse: TWebResponse): Boolean;
var
  APos: Integer;
  AID: string;
  AContentType, AQuerySt: string;
  AStatusCode: Integer;
begin
  AQuerySt := ARequest.Query;
  APos := Pos(cxWebFileCachePath, AQuerySt);
  Result := APos > 0;
  if Result then
  begin
    AID := Copy(AQuerySt, APos + Length(cxWebFileCachePath),
                Length(AQuerySt));
    if AResponse.ContentStream = nil then
      AResponse.ContentStream := TMemoryStream.Create;
    AStatusCode := -1;
    GetContent(AID, AResponse.ContentStream, ARequest.Date, AContentType, AStatusCode);
    if AStatusCode > 0 then
      AResponse.StatusCode := AStatusCode;
    AResponse.ContentStream.Seek(0, soFromBeginning);
    AResponse.ContentType := AContentType;
    AResponse.ContentLength := AResponse.ContentStream.Size;
  end;
end;


var
  FFileCacheManager: TcxWebFileCacheManager = nil;

class function TcxWebFileCacheManager.AccessInstance(Request: Integer): TcxWebFileCacheManager;
begin
  case Request of
    0 : ;
    1 : if not Assigned(FFileCacheManager) then FFileCacheManager := CreateInstance;
    2 : FFileCacheManager := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance',
      [Request]);
  end;
  Result := FFileCacheManager;
end;

class function TcxWebFileCacheManager.Instance: TcxWebFileCacheManager;
begin
  Result := AccessInstance(1);
end;

class procedure TcxWebFileCacheManager.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

function TcxWebFileCacheManager.GetItem(AID: string): Pointer;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FList.Count - 1 do
    if CompareText(TcxWebFileCacheManagerItem(FList[I]).ID,  AID) = 0 then
    begin
      Result := FList[I];
      break;
    end;
end;

function TcxWebFileCacheManager.GetCacheType: TcxWebFileCacheType;
begin
  if DesignerCount > 0 then
    Result := cmtFile
  else Result := FCacheType;
end;

function TcxWebFileCacheManager.InternalAdd(AID: string; AStream: TStream;
        AItemType: TcxWebFileCacheManagerItemType): Pointer;
var
  AItem: TcxWebFileCacheManagerItem;
begin
  EnterCriticalSection(FileCacheLock);
  try
    AItem := TcxWebFileCacheManagerItem(GetItem(AID));
    if AItem = nil then
    begin
      AItem := TcxWebFileCacheManagerItem.Create(CacheType, AID, AStream, AItemType);
      FList.Add(AItem);
    end else AItem.Update(AStream);
  finally
    LeaveCriticalSection(FileCacheLock);
  end;
  Result := AItem;
end;

function TcxWebFileCacheManager.Add(AID: string; AStream: TStream;
        AItemType: TcxWebFileCacheManagerItemType): string;
var
{$IFDEF VCL}
  hr: HResult;
{$ENDIF}
  AGUID: TGUID;
  AItem: TcxWebFileCacheManagerItem;
begin
  if AID = '' then
  begin
    {$IFDEF VCL}
    hr := CreateGUID(AGUID);
    OLECHECK(hr);
    {$ELSE}
    CreateGUID(AGUID);
    {$ENDIF}
    AID := GUIDToString(AGUID);
  end;
  AItem := TcxWebFileCacheManagerItem(InternalAdd(AID, AStream, AItemType));
  if CacheType = cmtMemory then
    Result := '?' + cxWebFileCachePath + AID
  else Result := AItem.GetFileName;
end;

function TcxWebFileCacheManager.GetInternalEWFFiles(AID: string): string;
var
  AItem: TcxWebFileCacheManagerItem;

  function GetEWFPath: string;
  begin
    if AItem.ItemType = mitGif then
      Result := InternalImagePath
    else Result := InternalJSPath;
  end;

  function CreateDirs(AName: string): Boolean;

    procedure RemoveLastDir;
    begin
      while (AName <> '') and (AName[Length(AName)] <> PathDelim) do
        AName := Copy(AName, 1, Length(AName) - 1);
      if AName <> '' then
        AName := Copy(AName, 1, Length(AName) - 1);
    end;

  var
    AStrings: TStrings;
    I : Integer;
  begin
    Result := DirectoryExists(AName);
    if not Result then
    begin
      AStrings := TStringList.Create;
      AStrings.Add(AName);
      try
        RemoveLastDir;
        while (AName <> '') and not DirectoryExists(AName) do
        begin
          AStrings.Add(AName);
          RemoveLastDir;
        end;
        for I := AStrings.Count - 1  downto 0 do
        begin
          Result := CreateDir(AStrings[I]);
          if not Result then
            break;
        end;
      finally
        AStrings.Free;
      end;
    end;

  end;

var
  AFileName: string;
  I: Integer;
begin
  AItem := TcxWebFileCacheManagerItem(GetItem(AID));
  if AItem <> nil then
  begin
    if DesignerCount = 0 then
    begin
      if GetEWFPath <> '' then
      begin
        AFileName := GetEWFPath;
        for I := 1 to Length(AFileName) do
          if AFileName[I] = '/' then
            AFileName[I] := PathDelim;
        AFileName := ExtractFilePath(GetApplicationFileName) + AFileName;
        try
          if CreateDirs(AFileName) then
          begin
            AFileName := AFileName + PathDelim + AID + '.' + AItem.GetFileExtention;
            if not AItem.FHasSavedIntoFile or not FileExists(AFileName) then
              AItem.FStream.SaveToFile(AFileName);
            with WebContext.Request do
            Result := '/' + GetEWFPath + '/' + AID + '.' + AItem.GetFileExtention;
          end;
        except
        end;
      end;
      if Result = '' then
        Result := '?' + cxWebFileCachePath + AItem.ID
    end else
    begin
      AItem.SaveToFile(nil);
      Result := AItem.GetFileName;
    end;
  end else Result := '';
end;

function TcxWebFileCacheManager.GetEWFImage(AID: string): string;
begin
  Result := GetInternalEWFFiles(cxWebEWFImageSign + AID);
end;

function TcxWebFileCacheManager.GetEWFJS(AID: string): string;
begin
  Result := GetInternalEWFFiles(cxWebEWFJSSign + AID);
end;

procedure TcxWebFileCacheManager.GetContent(AID: string; AStream: TStream;
                ADateTime: TDateTime;
                var AContentType: string; var AStatusCode: Integer);
var
  AItem: TcxWebFileCacheManagerItem;
begin
  EnterCriticalSection(FileCacheLock);
  try
    AItem := TcxWebFileCacheManagerItem(GetItem(AID));
    if AItem <> nil then
    begin
      if (AItem.ItemType = mitCustom) then
      begin
        AItem.GetData(AStream);
        AContentType := AItem.ContentType;
        if (AItem.RefCount = 0) then
        begin
          FList.Remove(AItem);
          AItem.Free;
        end;
      end else
      begin
        AContentType := AItem.ContentType;
        if (ADateTime >= GetInternalResourceModifiedDate) then
          AStatusCode := 304
        else begin
          AItem.GetData(AStream);
        end;
      end;
    end;
  finally
    LeaveCriticalSection(FileCacheLock);
  end;
end;

procedure TcxWebFileCacheManager.IncDesignerCount;
begin
  Inc(FDesignerCount);
end;

procedure TcxWebFileCacheManager.DecDesignerCount;
begin
  Dec(FDesignerCount);
end;


procedure TcxWebFileCacheManager.Clear;
var
  I: Integer;
begin
  EnterCriticalSection(FileCacheLock);
  try
    for I := 0 to FList.Count - 1 do
      TcxWebFileCacheManagerItem(FList[I]).Free;
    FList.Clear;
  finally
    LeaveCriticalSection(FileCacheLock);
  end;
end;

function EnumResNameProc(hModule: HMODULE; lpType, lpName: PChar;  lParam: LongInt): Boolean; stdcall;

  procedure AddItem(AContentType: string; AItemType: TcxWebFileCacheManagerItemType);
  var
    AManager: TcxWebFileCacheManager;
    AItem: TcxWebFileCacheManagerItem;
    AStream: TResourceStream;
  begin
    AManager := TcxWebFileCacheManager(lParam);
    AStream := TResourceStream.Create(HInstance, lpName, RT_RCDATA);
    try
      AItem := TcxWebFileCacheManagerItem(AManager.InternalAdd(lpName,
        AStream, AItemType));
      AItem.ItemType := AItemType;
    finally
      AStream.Free;
    end;
  end;

begin
  if Pos(cxWebEWFImageSign, UpperCase(lpName)) > 0 then
    AddItem(GifContentType, mitGif)
  else
    if Pos(cxWebEWFJSSign, UpperCase(lpName)) > 0 then
      AddItem(JSContentType, mitJS);
  Result := True;
end;

procedure TcxWebFileCacheManager.LoadFromResources;
begin
  {$IFDEF VCL}
  EnumResourceNames(HInstance, RT_RCDATA, @EnumResNameProc, Integer(self));
  {$ELSE}
     //TODO LINUX_NOT_IMPL
  {$ENDIF}
end;

initialization
  InitializeCriticalSection(FileCacheLock);

finalization
  TcxWebFileCacheManager.ReleaseInstance;
  DeleteCriticalSection(FileCacheLock);

end.
