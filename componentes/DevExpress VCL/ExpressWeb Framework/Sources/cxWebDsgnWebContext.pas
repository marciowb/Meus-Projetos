{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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

unit cxWebDsgnWebContext;

interface

{$I cxVer.inc}

uses SysUtils, Classes, DesignIntf,
  {$IFDEF VCL}
  Windows;
  {$ELSE}
  Qt;
  {$ENDIF}


function cxGetDesignWebContent(ADesigner: IDesigner): string;

implementation

uses
  TypInfo, HTTPApp, HTTPProd, WebCntxt,
  cxWebIntf, cxWebSess, cxWebDsgnBaseModules, cxWebDsgnHTMLSource,
  cxWebDsgnUtils, cxWebFileCacheManager, cxWebPathConst;

var
  FWebContext: TAbstractWebContext;

function cxGetWebContext: TAbstractWebContext;
begin
  Result := FWebContext;
end;

procedure cxSetWebContext(AWebContext: TAbstractWebContext);
begin
  FWebContext := AWebContext;
end;

type
  TcxWebDesignPageInfo = class(TAbstractWebPageInfo)
  private
    FPageModule: TComponent;
    FDesigner: IDesigner;
  protected
    constructor Create(const APageModule: TComponent; ADesigner: IDesigner);
    function GetPageFile: string; override;
    function GetPageName: string; override;
  end;

constructor TcxWebDesignPageInfo.Create(const APageModule: TComponent; ADesigner: IDesigner);
begin
  FPageModule := APageModule;
  FDesigner := ADesigner;
end;

function TcxWebDesignPageInfo.GetPageFile: string;
var
  AHTMLSource: TcxWebDsgnHTMLSource;
begin
  AHTMLSource := TcxWebDsgnHTMLSource.Create('', FDesigner);
  if AHTMLSource.HasHTMLFile then
    Result := FPageModule.Name + '.html'
  else Result := '';
  AHTMLSource.Free; 
end;

function TcxWebDesignPageInfo.GetPageName: string;
begin
  Result := FPageModule.Name;
end;

type
TcxWebDesignModuleFactory = class(TAbstractWebPageModuleFactory)
private
  FPageModule: TComponent;
  FPageInfo: TcxWebDesignPageInfo;
protected
  function GetModuleName: string; override;
  function GetIsAppModule: Boolean; override;
  function GetCreateMode: TWebModuleCreateMode; override;
  function GetCacheMode: TWebModuleCacheMode; override;
  function GetComponentClass: TComponentClass; override;
  function GetWebPageInfo: TAbstractWebPageInfo; override;
public
  constructor Create(APageModule: TComponent; ADesigner: IDesigner);
  destructor Destroy; override;

  function GetModule: TComponent; override;
  procedure PreventDestruction; override;
end;

constructor TcxWebDesignModuleFactory.Create(APageModule: TComponent; ADesigner: IDesigner);
begin
  FPageModule := APageModule;
  FPageInfo := TcxWebDesignPageInfo.Create(APageModule, ADesigner);
  FPageInfo.SetFactory(self);
end;

destructor TcxWebDesignModuleFactory.Destroy;
begin
  FPageInfo.Free;
  inherited Destroy;
end;

function TcxWebDesignModuleFactory.GetModule: TComponent;
begin
  Result := FPageModule;
end;

procedure TcxWebDesignModuleFactory.PreventDestruction;
begin
end;

function TcxWebDesignModuleFactory.GetModuleName: string;
begin
  Result := FPageModule.ClassName;
end;

function TcxWebDesignModuleFactory.GetIsAppModule: Boolean;
begin
  Result := False;
end;

function TcxWebDesignModuleFactory.GetCreateMode: TWebModuleCreateMode;
begin
  Result := crOnDemand;
end;

function TcxWebDesignModuleFactory.GetCacheMode: TWebModuleCacheMode;
begin
  Result := caDestroy;
end;

function TcxWebDesignModuleFactory.GetComponentClass: TComponentClass;
begin
  Result := TComponentClass(FPageModule.ClassInfo)
end;

function TcxWebDesignModuleFactory.GetWebPageInfo: TAbstractWebPageInfo;
begin
  Result := FPageInfo;
end;

type
TcxWebDesignModuleList = class(TAbstractWebModuleList)
private
  FPageModule: TComponent;
  FModuleFactory: TcxWebDesignModuleFactory;
protected
  function GetItem(I: Integer): TComponent; override;
  function GetItemCount: Integer; override;
  function GetOnModuleAdded: TModuleAddedProc; override;
  function GetFactoryCount: Integer; override;
  function GetFactory(I: Integer): TAbstractWebModuleFactory; override;
  procedure SetOnModuleAdded(AProc: TModuleAddedProc); override;
public
  constructor Create(const APageModule: TComponent; ADesigner: IDesigner);
  destructor Destroy; override;

  function FindModuleClass(AClass: TComponentClass): TComponent; override;
  function FindModuleName(const AName: string): TComponent; override;
  function AddModuleClass(AClass: TComponentClass): TComponent; override;
  function AddModuleName(const AName: string): TComponent; override;
end;

constructor TcxWebDesignModuleList.Create(const APageModule: TComponent; ADesigner: IDesigner);
begin
  FPageModule := APageModule;
  FModuleFactory := TcxWebDesignModuleFactory.Create(APageModule, ADesigner);
end;

destructor TcxWebDesignModuleList.Destroy;
begin
  FModuleFactory.Free;
  inherited Destroy;
end;

function TcxWebDesignModuleList.FindModuleClass(AClass: TComponentClass): TComponent;
begin
  if AClass = TComponentClass(FPageModule.ClassType) then
    Result := FPageModule
  else Result := nil;  
end;

function TcxWebDesignModuleList.FindModuleName(const AName: string): TComponent;
begin
  if CompareText(AName, FPageModule.Name) = 0 then
    Result := FPageModule
  else Result := nil;  
end;

function TcxWebDesignModuleList.AddModuleClass(AClass: TComponentClass): TComponent;
begin
  Result := nil;
end;

function TcxWebDesignModuleList.AddModuleName(const AName: string): TComponent;
begin
  Result := nil;
end;

function TcxWebDesignModuleList.GetItem(I: Integer): TComponent;
begin
  if I = 0 then
    Result := FPageModule
  else Result := nil;  
end;

function TcxWebDesignModuleList.GetItemCount: Integer;
begin
  Result := 1;
end;

function TcxWebDesignModuleList.GetOnModuleAdded: TModuleAddedProc;
begin
end;

function TcxWebDesignModuleList.GetFactoryCount: Integer;
begin
  Result := 1;
end;

function TcxWebDesignModuleList.GetFactory(I: Integer): TAbstractWebModuleFactory;
begin
  if I = 0 then
    Result := FModuleFactory
  else Result := nil;  
end;

procedure TcxWebDesignModuleList.SetOnModuleAdded(AProc: TModuleAddedProc);
begin
end;

type
TcxWebDesignRequest = class(TWebRequest)
protected
  function GetStringVariable(Index: Integer): string; override;
  function GetDateVariable(Index: Integer): TDateTime; override;
  function GetIntegerVariable(Index: Integer): Integer; override;
  function GetInternalPathInfo: string; override;
  function GetInternalScriptName: string; override;
public
  function GetFieldByName(const Name: string): string; override;
  function ReadClient(var Buffer; Count: Integer): Integer; override;
  function ReadString(Count: Integer): string; override;
  function TranslateURI(const URI: string): string; override;
  function WriteClient(var Buffer; Count: Integer): Integer; override;
  function WriteString(const AString: string): Boolean; override;
  function WriteHeaders(StatusCode: Integer; const StatusString, Headers: string): Boolean; override;
end;

function TcxWebDesignRequest.GetFieldByName(const Name: string): string;
begin
  Result := '';
end;

function TcxWebDesignRequest.ReadClient(var Buffer; Count: Integer): Integer;
begin
  Result := 0;
end;

function TcxWebDesignRequest.ReadString(Count: Integer): string;
begin
  Result := '';
end;

function TcxWebDesignRequest.TranslateURI(const URI: string): string;
begin
  Result := '';
end;

function TcxWebDesignRequest.WriteClient(var Buffer; Count: Integer): Integer;
begin
  Result := 0;
end;

function TcxWebDesignRequest.WriteString(const AString: string): Boolean;
begin
  Result := False;
end;

function TcxWebDesignRequest.WriteHeaders(StatusCode: Integer; const StatusString, Headers: string): Boolean;
begin
  Result := False;
end;

function TcxWebDesignRequest.GetStringVariable(Index: Integer): string;
begin
  Result := '';
end;

function TcxWebDesignRequest.GetDateVariable(Index: Integer): TDateTime;
begin
  Result := Date;
end;

function TcxWebDesignRequest.GetIntegerVariable(Index: Integer): Integer;
begin
  Result := 0;
end;

function TcxWebDesignRequest.GetInternalPathInfo: string;
begin
  Result := '';
end;

function TcxWebDesignRequest.GetInternalScriptName: string;
begin
  Result := '';
end;

type
TcxWebDesignResponse = class(TWebResponse)
private
  FContent: string;
protected
  function GetContent: string; override;
  function GetDateVariable(Index: Integer): TDateTime; override;
  function GetIntegerVariable(Index: Integer): Integer; override;
  function GetLogMessage: string; override;
  function GetStatusCode: Integer; override;
  function GetStringVariable(Index: Integer): string; override;
  procedure SetContent(const Value: string); override;
  procedure SetDateVariable(Index: Integer; const Value: TDateTime); override;
  procedure SetIntegerVariable(Index: Integer; Value: Integer); override;
  procedure SetLogMessage(const Value: string); override;
  procedure SetStatusCode(Value: Integer); override;
  procedure SetStringVariable(Index: Integer; const Value: string); override;
public
  procedure SendResponse; override;
  procedure SendRedirect(const URI: string); override;
  procedure SendStream(AStream: TStream); override;
  function Sent: Boolean; override;
end;

procedure TcxWebDesignResponse.SendResponse;
begin
end;

procedure TcxWebDesignResponse.SendRedirect(const URI: string);
begin
end;

procedure TcxWebDesignResponse.SendStream(AStream: TStream);
begin
end;

function TcxWebDesignResponse.Sent: Boolean;
begin
  Result := False;
end;

function TcxWebDesignResponse.GetContent: string;
begin
  Result := FContent;
end;

function TcxWebDesignResponse.GetDateVariable(Index: Integer): TDateTime;
begin
  Result := Date;
end;

function TcxWebDesignResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  Result := 0;
end;

function TcxWebDesignResponse.GetLogMessage: string;
begin
  Result := '';
end;

function TcxWebDesignResponse.GetStatusCode: Integer;
begin
  Result := 0;
end;

function TcxWebDesignResponse.GetStringVariable(Index: Integer): string;
begin
  Result := '';
end;

procedure TcxWebDesignResponse.SetContent(const Value: string);
begin
  FContent := Value;
end;

procedure TcxWebDesignResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
begin
end;

procedure TcxWebDesignResponse.SetIntegerVariable(Index: Integer; Value: Integer);
begin
end;

procedure TcxWebDesignResponse.SetLogMessage(const Value: string);
begin
end;

procedure TcxWebDesignResponse.SetStatusCode(Value: Integer);
begin
end;

procedure TcxWebDesignResponse.SetStringVariable(Index: Integer; const Value: string);
begin
end;

type
TcxWebDesignerFileManager = class(TInterfacedObject, IDesignerFileManager)
private
  FRoot: TComponent;
  FDesigner: IDesigner;

  function GetGlobalPath: string;
  function GetJSScriptPath: string;
  function GetImagePath: string;
protected
  function QualifyFileName(const AFileName: string): string;
  function GetStream(const AFileName: string; var AOwned: Boolean): TStream;
  constructor Create(ARoot: TComponent; ADesigner: IDesigner);
end;

constructor TcxWebDesignerFileManager.Create(ARoot: TComponent; ADesigner: IDesigner);
begin
  FRoot := ARoot;
  FDesigner := ADesigner;
end;

function TcxWebDesignerFileManager.GetGlobalPath: string;
begin
  Result := ExcludeTrailingPathDelimiter(ExtractFilePath(cxGetDesignerApplicationFileName));
  if ExtractFileName(Result) = 'Lib' then
    Result := ExtractFilePath(Result)  // old installation
  else
    Result := ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(Result)));  // new installation
end;

function TcxWebDesignerFileManager.GetJSScriptPath: string;
begin
  Result := GetGlobalPath + cxWebJScriptDTPath + PathDelim;
end;

function TcxWebDesignerFileManager.GetImagePath: string;
begin
  Result := GetGlobalPath + cxWebImageDTPath + PathDelim;
end;

function TcxWebDesignerFileManager.QualifyFileName(const AFileName: string): string;
var
  AExt: string;
begin
  AExt := UpperCase(ExtractFileExt(AFileName));
  if (AExt <> '') and (AExt[1] = '.') then
    AExt := Copy(AExt, 2, Length(AExt));
  if AExt = 'JS' then
    Result := GetJSScriptPath  + AFileName
  else
    if (AExt = 'GIF') or (AExt = 'JPEG') or (AExt = 'BMP') or
      (AExt =  'JPG') then
      Result := GetImagePath  + AFileName
    else  Result := AFileName;
  Result := StringReplace(Result, '\', '/', [rfReplaceAll, rfIgnoreCase]);  
end;


function TcxWebDesignerFileManager.GetStream(const AFileName: string; var AOwned: Boolean): TStream;
var
  AHTMLSource: TcxWebDsgnHTMLSource;
  AFile: string;
  AFileStream: TFileStream;
begin
  AHTMLSource := TcxWebDsgnHTMLSource.Create('', FDesigner);
  try
    if (Pos(FRoot.Name, AFileName) = 1) and
      (Length(AFileName) > Length(FRoot.Name)) and
      (AFileName[Length(FRoot.Name) + 1] = '.') then
      Result := TStringStream.Create(AHTMLSource.HTML)
    else
    begin
      AFile := ExtractFilePath(AHTMLSource.SourceEditor.FileName) + AFileName;
      if FileExists(AFile) then
      begin
        AFileStream := TFileStream.Create(AFile, fmOpenRead, fmShareDenyNone);
        Result := TMemoryStream.Create;
        Result.CopyFrom(AFileStream, AFileStream.Size);
        AFileStream.Free;
        if Result.Size > 0 then
          Result.Position := 0;
      end else Result := TStringStream.Create('');
    end;
  finally
    AHTMLSource.Free;
  end;
end;

type
TRootReader = class(TReader)
private
  FRoot: TComponent;
  
  procedure DoFindMethodEvent(Reader: TReader; const MethodName: string;
    var Address: Pointer; var Error: Boolean);
  procedure DoFindComponentClassEvent(Reader: TReader; const ClassName: string;
    var ComponentClass: TComponentClass);
public
  constructor Create(ARoot: TComponent; AStream: TStream);
end;

constructor TRootReader.Create(ARoot: TComponent; AStream: TStream);
begin
  inherited Create(AStream, 4096);
  FRoot := ARoot;
  OnFindMethod := DoFindMethodEvent;
  OnFindComponentClass := DoFindComponentClassEvent;
end;

procedure TRootReader.DoFindMethodEvent(Reader: TReader; const MethodName: string;
    var Address: Pointer; var Error: Boolean);
begin
  Error := False;
end;

procedure TRootReader.DoFindComponentClassEvent(Reader: TReader; const ClassName: string;
  var ComponentClass: TComponentClass);
var
  I: Integer;
begin
  if ComponentClass <> nil then exit;
  for I := 0 to FRoot.ComponentCount - 1 do
    if CompareText(ClassName, FRoot.Components[I].ClassName) = 0 then
    begin
      ComponentClass := TComponentClass(FRoot.Components[I].ClassType);
      break;
    end;
end;

type
TComponentAccess = class(TComponent);


function cxGetDesignWebContent(ADesigner: IDesigner): string;
var
  AModuleList: TcxWebDesignModuleList;
  ARequest: TcxWebDesignRequest;
  AResponse: TcxWebDesignResponse;
  ASession: TAbstractWebSession;
  ASaveDesignerFileManager: IDesignerFileManager;
  ASaveWebContext: TAbstractWebContext;
  ASaveGetWebContextProc: TGetWebContextProc;
  ASaveSetWebContextProc: TSetWebContextProc;
  ADummyRoot: TComponent;


  function CreateDummyRootComponent: TComponent;
  var
    AStream: TMemoryStream;
    AReader: TRootReader;
    ATypeData: PTypeData;
    ADesignerModule: IcxWebDesignerModule;
  begin
    ATypeData := GetTypeData(ADesigner.Root.ClassInfo);
    Result := nil;
    while (ATypeData <> nil) and not cxWebIsBasePageModule(ATypeData.ClassType) and
    (ATypeData.ParentInfo <> nil) do
      ATypeData := GetTypeData(ATypeData.ParentInfo^);
    if (ATypeData = nil) or (ATypeData.ParentInfo = nil) then exit;

    AStream := TMemoryStream.Create;
    try
      AStream.WriteComponent(ADesigner.Root);
      AStream.Seek(0, soFromBeginning);

      Result := TComponentClass(ATypeData.ClassType).Create(nil);
      AReader := TRootReader.Create(ADesigner.Root, AStream);
      try
        Result := AReader.ReadRootComponent(Result);
        TComponentAccess(Result).SetDesigning(True, False);
      finally
        AReader.Free;
      end;
      Result.Name := ADesigner.Root.Name;
      if Supports(Result, IcxWebDesignerModule, ADesignerModule) then
        ADesignerModule.SetIsDesignerPreviewModule(True);
    finally
      AStream.Free;
    end;
  end;

  procedure InitWebContext;
  begin
    AModuleList := TcxWebDesignModuleList.Create(ADummyRoot, ADesigner);
    ARequest := TcxWebDesignRequest.Create;
    AResponse := TcxWebDesignResponse.Create(nil);
    ASession := TcxWebSession.Create;
    ASaveWebContext := WebContext;
    ASaveSetWebContextProc := SetWebContextProc;
    ASaveGetWebContextProc := GetWebContextProc;
    SetWebContextProc := cxSetWebContext;
    GetWebContextProc := cxGetWebContext;
    TWebContext.Create(AModuleList, ARequest, AResponse, ASession);
    WebContext.DispatchedPageName := ADummyRoot.Name;
    ASaveDesignerFileManager := DesignerFileManager;
    DesignerFileManager := TcxWebDesignerFileManager.Create(ADummyRoot, ADesigner);
    TcxWebFileCacheManager.Instance.IncDesignerCount;
  end;

  procedure DestroyWebContext;
  begin
    TcxWebFileCacheManager.Instance.DecDesignerCount;
    DesignerFileManager := ASaveDesignerFileManager;
    WebContext.Free;
    GetWebContextProc := ASaveGetWebContextProc;
    SetWebContextProc := ASaveSetWebContextProc;
    if Assigned(SetWebContextProc) then
      SetWebContextProc(ASaveWebContext);
    ARequest.Free;
    AResponse.Free;
    ASession.Free;
    AModuleList.Free;
  end;

var
  AWebPage: IcxWebPage;
begin
  if Supports(ADesigner.Root, IcxWebPage) then
  begin
    if Supports(ADesigner.Root, IcxWebPageModule) then // TODO
    begin
      Classes.RegisterClass(TComponentClass(ADesigner.Root.ClassType));
      ADummyRoot := CreateDummyRootComponent;
    end else ADummyRoot := ADesigner.Root;
    if (ADummyRoot <> nil) and Supports(ADummyRoot, IcxWebPage, AWebPage) then
    begin
      try
        InitWebContext;
        try
          if AWebPage.DispatchPage(ADummyRoot.Name, AResponse) then
            Result := AResponse.Content
          else Result := '';
        except
         on E: Exception do
           if Result = '' then Result := E.Message;
        end;
      finally
        if Supports(ADesigner.Root, IcxWebPageModule) then
          ADummyRoot.Free;
        DestroyWebContext;
      end;
    end else Result := '';
    if Supports(ADesigner.Root, IcxWebPageModule) then
      Classes.UnregisterClass(TComponentClass(ADesigner.Root.ClassType));
  end else Result := '';
end;

end.
