{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Common functions                                        }
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
unit cxWebUtils;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
  {$IFDEF VCL}
  Windows, 
  {$ELSE}
  Types,
  {$ENDIF}
  cxWebTypes, cxWebGraphics;

const
{ Additional parser special tokens }
  toBOF = Char(6);

type
  TcxDirection = (dBack = -1, dForward = 1);

  TcxParser = class
  private
    FBuffer: PChar;
    FOutBuffer: PChar;
    FOutSize: Integer;
    FOutIndex: Integer;

    FIndex: Integer;
    FLength: Integer;
    FSourceLine: Integer;
    FStream: TStream;
    FToken: Char;

    procedure Init;
    function GetOutString: string;
    function GetOutStringLength: Integer;
  protected
    procedure SkipBlanks(Direction: TcxDirection); virtual;
    procedure SkipToToken(Direction: TcxDirection); virtual;
    procedure SkipUntilToken(const AToken: Char; Direction: TcxDirection); virtual;
    procedure UpdateOutput(const S: PChar; ALength: Integer); virtual;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
    function IsBOF: Boolean;
    function IsEOF: Boolean;
    function IsSymbol: Boolean;
    function NextToken: Char;
    function SkipUntilNextToken(const AToken: Char): Char;
    function SkipUntilPrevToken(const AToken: Char): Char;
    function Position: Integer;
    function PrevToken: Char;
    procedure ResetOutput;
    function TokenString: string;
    property OutString: string read GetOutString;
    property OutStringLength: Integer read GetOutStringLength;
    property SourceLine: Integer read FSourceLine;
    property Token: Char read FToken;
  end;

function IsBlank(const S: string): Boolean;

procedure ListAdd(var AList: TList; AnItem: Pointer);
function ListCount(AList: TList): Integer;
function ListIndexOf(AList: TList; AnItem: Pointer): Integer;
function ListItem(AList: TList; Index: Integer): Pointer;
procedure ListRemove(var AList: TList; AnItem: Pointer);

function BoolToStr(B: Boolean): string;

{$IFDEF LINUX}
procedure SetRect(var ARect: TRect; ALeft, ATop, ARight, ABottom: Integer);
{$ENDIF}

function GetActionParameter(Parameters: string; Index: Integer): string;

function cxGetApplicationFilePath: string;
function cxWebExpandFileName(const AFileName: string): string;
function QualifyFileName(const AFileName: string): string;
function QualifyJSFileName(const AFileName: string): string;
function QualifyImageFileName(const AFileName: string): string;

function GetComponentByInterface(AInterface: IInterface): TComponent;
function StringIsGuid(const Str: string): Boolean;

type
  TcxAbstractWebMetricsUtils = class
  protected
    function GetCheckWidth: Integer; virtual; abstract;
    function GetCheckHeight: Integer; virtual; abstract;
  public
    function CalcEditHeight(AFont: TcxWebFont): Integer; virtual; abstract;
    function GetTextHeight(const AText: string; AWebFont: TcxWebFont): Integer; virtual; abstract;
    function GetTextWidth(const AText: string; AWebFont: TcxWebFont): Integer; virtual; abstract;
    function GetAweCharWidth(AWebFont: TcxWebFont): Integer; virtual; abstract;

    property CheckWidth: Integer read GetCheckWidth;
    property CheckHeight: Integer read GetCheckHeight;
  end;

  TcxAbstractWebImageUtils = class
  public
    constructor Create; virtual; abstract;
    function GetErrMessage: string; virtual; abstract;
    function GetHeight: Integer; virtual; abstract;
    function GetWidth: Integer; virtual; abstract;
    function IsEmpty: Boolean; virtual; abstract;
    procedure SetPath(const APath: string); virtual; abstract;
    procedure SetImage(Value: Variant); virtual; abstract;
  end;
  TcxWebImageUtilsClass = class of TcxAbstractWebImageUtils;

var
  cxWebMetricsUtils: TcxAbstractWebMetricsUtils = nil;
  cxWebImageUtilsClass: TcxWebImageUtilsClass = nil;
  
implementation

uses
  StrUtils, HTTPProd, WebCntxt,
  {$IFDEF VCL}
  cxWebMetrics,
  {$ELSE}
  Libc,
  {$ENDIF}
  cxWebPathConst, cxWebIntf;

{ TcxParser }

constructor TcxParser.Create(AStream: TStream);
begin
  FStream := AStream;
  FLength := FStream.Size;
  GetMem(FBuffer, FLength);
  FStream.Position := 0;
  FStream.ReadBuffer(FBuffer^, FLength);
  Init;
end;

destructor TcxParser.Destroy;
begin
  ResetOutput;
  if FBuffer <> nil  then
    FreeMem(FBuffer, FLength);
  inherited;
end;

function TcxParser.IsBOF: Boolean;
begin
  Result := (FToken = toBOF);
end;

function TcxParser.IsEOF: Boolean;
begin
  Result := (FToken = toEOF);
end;

function TcxParser.IsSymbol: Boolean;
begin
  Result := (FToken = toSymbol);
end;

function TcxParser.NextToken: Char;
begin
  if not IsEOF then SkipToToken(dForward);
  Result := Token;
end;

function TcxParser.Position: Integer;
begin
  Result := FIndex + 1;
end;

function TcxParser.PrevToken: Char;
begin
  if not IsBOF then SkipToToken(dBack);
  Result := Token;
end;

function TcxParser.SkipUntilNextToken(const AToken: Char): Char;
begin
  if not IsEOF then SkipUntilToken(AToken, dForward);
  Result := Token;
end;

function TcxParser.SkipUntilPrevToken(const AToken: Char): Char;
begin
  if not IsBOF then SkipUntilToken(AToken, dBack);
  Result := Token;
end;

procedure TcxParser.ResetOutput;
begin
  if FOutBuffer <> nil then
    FreeMem(FOutBuffer, FOutSize + 1);
  FOutBuffer := nil;
  FOutSize := 0;
  FOutIndex := 0;

end;

function TcxParser.TokenString: string;
var
  PStr, P: PChar;
begin
  if (FIndex >= FLength) or (FIndex < 0) then Exit;
  if (FToken = toSymbol) or (FToken = toInteger) then
  begin
    PStr := FBuffer + FIndex;
    P := FBuffer + FIndex;
    while True do
    begin
      P := FBuffer + FIndex;
      case P^ of
        'A'..'Z', 'a'..'z', '_', '0'..'9':
          Inc(FIndex);
      else
        Dec(FIndex);
        break;
      end;
      if FIndex >= FLength then break;
      if FIndex < 0 then break;
    end;
    SetString(Result, PStr, P - PStr);
    UpdateOutput((PStr + 1), P - PStr - 1); //TODO
    P := FBuffer + FIndex;
    FToken := P^;
  end
  else Result := '';
end;

procedure TcxParser.SkipBlanks(Direction: TcxDirection);
var
  P: PChar;
begin
  if Direction = dBack then
  begin
    if FIndex < 0 then exit;
  end
  else if FIndex >= FLength then exit;

  while True do
  begin
    Inc(FIndex, Ord(Direction));
    if FIndex >= FLength then break;
    if FIndex < 0 then break;

    P := FBuffer + FIndex;
    case P^ of
      #10:
        Inc(FSourceLine, Ord(Direction));
      #33..#255:
        begin
          Dec(FIndex, Ord(Direction));
          break;
        end;
    end;
    UpdateOutput(P, Ord(Direction))
  end;
end;

procedure TcxParser.SkipToToken(Direction: TcxDirection);
var
  P: PChar;
begin
  SkipBlanks(Direction);
  if Direction = dBack then
  begin
    if FIndex > -1 then
      Dec(FIndex);
  end
  else
    if FIndex < FLength then
      Inc(FIndex);
  if FIndex >= FLength then
    FToken := toEOF
  else
    if FIndex < 0 then
    begin
      FToken := toBOF;
      UpdateOutput(nil, -1);
    end
    else
    begin
      P := FBuffer + FIndex;
      if P^ in ['A'..'Z', 'a'..'z', '_'] then
        FToken := toSymbol
      else if P^ in ['0'..'9'] then
        FToken := toInteger
      else FToken := P^;
      if Direction = dBack then
      begin
        if not (FIndex = FLength - 1) then
          UpdateOutput(P, -1);
      end
      else
        UpdateOutput(P, 1);
    end;
end;

procedure TcxParser.SkipUntilToken(const AToken: Char; Direction: TcxDirection);
var
  AOldIndex, ALen: Integer;
  P: PChar;
begin
  if ((FIndex = -1) and (Direction = dForward))
  or ((FIndex >= FLength) and (Direction = dBack)) then
    FToken := toSymbol;
  AOldIndex := FIndex;
  while not ((Token in [toBOF, toEOF]) or (Token = AToken)) do
  begin
    if Direction = dBack then
    begin
      if FIndex > -1 then
        Dec(FIndex);
    end
    else
      if FIndex < FLength then
        Inc(FIndex);
    if FIndex >= FLength then
      FToken := toEOF
    else
      if FIndex < 0 then
      begin
        FToken := toBOF;
        UpdateOutput(nil, -1);
      end
      else
      begin
        P := FBuffer + FIndex;
        if P^ in ['A'..'Z', 'a'..'z', '_'] then
          FToken := toSymbol
        else if P^ in ['0'..'9'] then
          FToken := toInteger
        else FToken := P^;
      end;
  end;
  if AOldIndex <> FIndex then
  begin
    if Direction = dBack then
    begin
      if not (FIndex = FLength - 1) then
        UpdateOutput(nil, AOldIndex - FIndex);
    end
    else
    begin
      P := FBuffer + AOldIndex + 1;
      ALen := FIndex - AOldIndex;
      if Token = toEOF then
        Dec(ALen);
      UpdateOutput(P, ALen);
    end;
  end;
end;


procedure TcxParser.UpdateOutput(const S: PChar; ALength: Integer);
var
  ANewSize: Integer;
begin
  ANewSize := FOutIndex + ALength;

  if ALength > 0 then
  begin
    if ANewSize > FOutSize then
    begin
      FOutSize := ((ANewSize div 1024) + 1) * 1024 - 1;
      ReallocMem(FOutBuffer, FOutSize + 1);
    end;  
    Move(S^, (FOutBuffer + FOutIndex)^, ALength);
    FOutIndex := ANewSize;
    FOutBuffer[FOutIndex] := #0;
  end else
  begin
    if ANewSize > 0 then
      FOutIndex := ANewSize
    else FOutIndex := 0;
    if FOutBuffer <> nil then
      FOutBuffer[FOutIndex] := #0;
  end;
end;

procedure TcxParser.Init;
begin
  FIndex := -1;
  FToken := toBOF;
  FSourceLine := 1;
  ResetOutput;
end;

function TcxParser.GetOutString: string;
begin
  if FOutBuffer = nil then
    Result := ''
  else Result := FOutBuffer;
end;

function TcxParser.GetOutStringLength: Integer;
begin
  if FOutBuffer = nil then
    Result := 0
  else Result := FOutIndex;
end;

function IsBlank(const S: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(S) do
    if not (S[I] in [' ', #13, #10]) then
    begin
      Result := False;
      break;
    end;
end;

function cxGetApplicationFileName: string;
var
  ModuleName: array[0..MAX_PATH-1] of Char;
begin
  SetString(Result, ModuleName,
    GetModuleFileName(LibModuleList.Instance, ModuleName, SizeOf(ModuleName)));
end;

function cxGetApplicationFilePath: string;
begin
  Result := ExtractFilePath(cxGetApplicationFileName);
end;

function cxWebExpandFileName(const AFileName: string): string;
var
  CurDir: string;
begin
  Result := ExtractFilePath(cxGetApplicationFileName) + AFileName;
  Exit;
  Result := AFileName;
  { TODO: DT FileService }
  if AFileName <> '' then
  begin
    CurDir := GetCurrentDir;
    SetCurrentDir(ExtractFilePath(cxGetApplicationFileName));
    Result := ExpandFileName(AFileName);
    SetCurrentDir(CurDir);
  end;
end;

type
  TcxWebFullFileName = class
  private
    FSourceFileName: string;
    FFileName: string;
    FDrive: string;

    function GetFullName: string;

    procedure PrepareDrive;
    function GetModulePath: string;  
  protected
    property Drive: string read FDrive;
    property FileName: string read FFileName;
  public
    constructor Create(const AFileName: string);
    property FullName: string read GetFullName;
  end;

{ TcxWebFullFileName }
constructor TcxWebFullFileName.Create(const AFileName: string);
begin
  FSourceFileName := AFileName;
  FFileName := AFileName;
  PrepareDrive;
end;

procedure TcxWebFullFileName.PrepareDrive;
begin
  FDrive := ExtractFileDrive(FileName);
  if (Drive = '') then
  begin
    FDrive := ExtractFilePath(GetModulePath);
    FFileName := Copy(GetModulePath, Length(Drive) + 1, MaxInt) + PathDelim + FileName;
  end
  else  FFileName := Copy(FileName, Length(Drive) + 1, MaxInt);
end;

function TcxWebFullFileName.GetModulePath: string;
begin
  if Assigned(GetModuleFileNameProc) then
    Result := ExtractFilePath(GetModuleFileNameProc)
  else Result := '';
end;


//TODO - refactoring this code
function TcxWebFullFileName.GetFullName: string;
var
  I, J: Integer;
  LastWasPathDelim: Boolean;
begin
  Result := FSourceFileName;
  if FileName = '' then exit;

  I := 1;
  J := 1;

  LastWasPathDelim := False;

  Result := '';
  while I <= Length(FileName) do
  begin
    case FileName[I] of
      PathDelim:
        if J < I then
        begin
          // Check for consecutive 'PathDelim' characters and skip them if present
          if (I = 1) or (FileName[I - 1] <> PathDelim) then
            Result := Result + Copy(FileName, J, I - J);
          J := I;
          // Set a flag indicating that we just processed a path delimiter
          LastWasPathDelim := True;
        end;
      '.':
        begin
          // If the last character was a path delimiter then this '.' is
          // possibly a relative path modifier
          if LastWasPathDelim then
          begin
            // Check if the path ends in a '.'
            if I < Length(FileName) then
            begin
              // If the next character is another '.' then this may be a relative path
              // except if there is another '.' after that one.  In this case simply
              // treat this as just another filename.
              if (FileName[I + 1] = '.') and
                ((I + 1 >= Length(FileName)) or (FileName[I + 2] <> '.')) then
              begin
                // Don't attempt to backup past the Root dir
                if Length(Result) > 1 then
                  // For the purpose of this excercise, treat the last dir as a
                  // filename so we can use this function to remove it
                  Result := ExtractFilePath(ExcludeTrailingPathDelimiter(Result));
                J := I;
              end
              // Simply skip over and ignore any 'current dir' constrcucts, './'
              // or the remaining './' from a ../ constrcut.
              else if FileName[I + 1] = PathDelim then
              begin
                Result := IncludeTrailingPathDelimiter(Result);
                Inc(I);
                J := I + 1;
              end else
                // If any of the above tests fail, then this is not a 'current dir' or
                // 'parent dir' construct so just clear the state and continue.
                LastWasPathDelim := False;
            end else
            begin
              // Don't let the expanded path end in a 'PathDelim' character
              Result := ExcludeTrailingPathDelimiter(Result);
              J := I + 1;
            end;
          end;
        end;
    else
      LastWasPathDelim := False;
    end;
    Inc(I);
  end;
  
  if (I - J > 1) or (FileName[I] <> PathDelim) then
    Result := Result + Copy(FileName, J, I - J);
  if (Drive <> '') and (Drive[Length(Drive)] = PathDelim) and
    (Result <> '') and (Result[1] = PathDelim) then
    Result := Copy(Result, 2, Length(Result));
  Result := Drive + Result;
end;

function QualifyFileName(const AFileName: string): string;
var
  AFileFullName: TcxWebFullFileName;
begin
  if (DesignerFileManager <> nil)
    and not Supports(DesignerFileManager, IcxWebDebugDesignerFileManager) then
    Result := DesignerFileManager.QualifyFileName(AFileName)
  else
  begin
    AFileFullName := TcxWebFullFileName.Create(AFileName);
    Result := AFileFullName.FullName;
    AFileFullName.Free;
  end;
end;

function QualifyJSFileName(const AFileName: string): string;
begin
  if (DesignerFileManager <> nil)
    and not Supports(DesignerFileManager, IcxWebDebugDesignerFileManager) then
    Result := DesignerFileManager.QualifyFileName(AFileName)
  else Result := cxWebJSScriptPath + AFileName;
end;

function QualifyImageFileName(const AFileName: string): string;
begin
  if (DesignerFileManager <> nil)
    and not Supports(DesignerFileManager, IcxWebDebugDesignerFileManager) then
    Result := DesignerFileManager.QualifyFileName(AFileName)
  else Result := cxWebImagePath + AFileName;
end;

{ List helpers }

procedure ListAdd(var AList: TList; AnItem: Pointer);
begin
  if AList = nil then
    AList := TList.Create;
  AList.Add(AnItem);
end;

function ListCount(AList: TList): Integer;
begin
  if AList = nil then 
    Result := 0
  else
    Result := AList.Count;
end;

function ListIndexOf(AList: TList; AnItem: Pointer): Integer;
begin
  if AList = nil then 
    Result := -1
  else
    Result := AList.IndexOf(AnItem);
end;

function ListItem(AList: TList; Index: Integer): Pointer;
begin
  if AList = nil then
    Result := nil
  else
    Result := AList[Index];
end;

procedure ListRemove(var AList: TList; AnItem: Pointer);
begin
  if AList <> nil then
  begin
    AList.Remove(AnItem);
    if AList.Count = 0 then
      FreeAndNil(AList)
  end;
end;

function BoolToStr(B: Boolean): string;
const
  TextBoolStrs: array [Boolean] of string = ('false', 'true');
begin
  Result := TextBoolStrs[B];
end;

{$IFDEF LINUX}
procedure SetRect(var ARect: TRect; ALeft, ATop, ARight, ABottom: Integer);
begin
  ARect.Left := ALeft;
  ARect.Top := ATop;
  ARect.Right := ARight;
  ARect.Bottom := ABottom;
end;
{$ENDIF}

function GetActionParameter(Parameters: string; Index: Integer): string;
var
  I, APos: Integer;
  S: string;
begin
  Result := '';
  if Index >= 0 then
  begin
    S := Parameters;
    APos := 0;
    for I := 0 to Index do
    begin
      APos := Pos(':', S);
      if I < Index then
      begin
        if APos = 0 then
        begin
          S := '';
          break;
        end;
        S := RightStr(S, Length(S) - APos)
      end;
    end;
    if APos <> 0 then
      Result := LeftStr(S, APos - 1)
    else Result := S;
  end;
end;

function GetComponentByInterface(AInterface: IInterface): TComponent;
var
  AComponentRefrence: IInterfaceComponentReference;
begin
  if (AInterface <> nil) and
    Supports(AInterface, IInterfaceComponentReference, AComponentRefrence) then
    Result := AComponentRefrence.GetComponent
  else Result := nil;  
end;

function StringIsGuid(const Str: string): Boolean;
  function StringIsHex(const S: string): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 1 to Length(S) do
      if not (S[I] in ['0'..'9', 'a'..'f', 'A'..'F']) then
      begin
        Result := False;
        break;
      end;
  end;
begin
  Result := (Length(Str) = 38) and
    (Str[1] = '{') and (Str[38] = '}') and
    StringIsHex(Copy(Str, 2, 8)) and
    (Str[10] = '-') and StringIsHex(Copy(Str, 11, 4)) and
    (Str[15] = '-') and StringIsHex(Copy(Str, 16, 4)) and
    (Str[20] = '-') and StringIsHex(Copy(Str, 21, 4)) and
    (Str[25] = '-') and StringIsHex(Copy(Str, 26, 12));
end;

end.
