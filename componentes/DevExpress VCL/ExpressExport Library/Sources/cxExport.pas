
{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressExport                                               }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEXPORT AND ALL                }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxExport;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, Math, Graphics, dxCore,
  Variants, {$IFNDEF NONDB} FMTBcd, SqlTimSt, {$ENDIF} cxExportStrs;

type
  EcxExportData = class(EdxException);
  TcxExportProviderClass = class of TcxCustomExportProvider;
  TcxCustomExportProvider = class;
  IcxCellInternalCache = interface;

  PWord =^Word;
  PInteger =^Integer;
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;

  { Define  CX  style items }
  TcxAlignText = (catLeft, catCenter, catRight);
  TcxBrushStyle = (cbsClear, cbsSolid);
  TcxFontStyle = (cfsBold, cfsItalic, cfsUnderline, cfsStrikeOut);
  TcxFontStyles = set of TcxFontStyle;

  { TcxCellBorders }
  TcxCellBorders = packed record
    IsDefault: Boolean;
    Width: Integer;
    Color: Integer;
  end;

  { TcxCacheCellStyle }
  PcxCacheCellStyle = ^TcxCacheCellStyle;
  TcxCacheCellStyle = packed record
    AlignText: TcxAlignText;
    FontName: array[0..64 - 1] of Byte;
    FontStyle: TcxFontStyles;
    FontColor: Integer;
    FontSize: Integer;
    FontCharset: Integer;
    Borders: array[0..3] of TcxCellBorders;
    BrushStyle: TcxBrushStyle;
    BrushBkColor: Integer;
    BrushFgColor: Integer;
    Format: Integer;
    HashCode: Integer;
  end;

  { TcxCellInternalCache }
  TcxCellInternalCache = record
    Cache: IcxCellInternalCache;
    Index: Integer;
  end;

  { TcxCacheItem }
  TcxCacheItem = record
    InternalCache: TcxCellInternalCache;
    Data: Pointer;
    DataSize: Integer;
    DataType: Integer;
    StyleIndex: Integer;
    IsHidden: Boolean;
    case IsUnion: Boolean of
      False:();
      True: (Width, Height: Integer);
  end;

  TcxEnumExportTypes = procedure(const AExportType: Integer; const AExportName: string);
  TcxEnumTypes = procedure(const AExportType: Integer);

  { IcxCellInternalCache }
  IcxCellInternalCache = interface
  ['{DEF62C25-0B11-4BD0-AE25-BABF7EDD7883}']
    procedure CommitCache(AStream: TStream; AParam: Pointer);
    procedure CommitStyle(AStream: TStream; AParam: Pointer);
    procedure DeleteCacheFromCell(const ACol, ARow: Integer);
    procedure SetCacheIntoCell(const ACol, ARow: Integer; ACache: IcxCellInternalCache);
  end;

  { TcxExportProvider }
  IcxExportProvider = interface
  ['{442A08A8-CDDA-4FD6-8E15-9D8BD34554F6}']
    procedure Commit;
    function GetCellStyle(const ACol, ARow: Integer): PcxCacheCellStyle;
    function GetStyle(AStyleIndex: Integer): PcxCacheCellStyle;
    function RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
    procedure SetCellDataBoolean(const ACol, ARow: Integer; const AValue: Boolean);
    procedure SetCellDataCurrency(const ACol, ARow: Integer; const AValue: Currency);
    procedure SetCellDataDouble(const ACol, ARow: Integer; const AValue: Double);
    procedure SetCellDataDateTime(const ACol, ARow: Integer; const AValue: TDateTime);
    procedure SetCellDataInteger(const ACol, ARow: Integer; const AValue: Integer);
    procedure SetCellDataString(const ACol, ARow: Integer; const AText: string);
    procedure SetCellDataWideString(const ACol, ARow: Integer; const AText: Widestring);
    procedure SetCellStyle(const ACol, ARow, AStyleIndex: Integer); overload;
    procedure SetCellStyle(const ACol, ARow, AExampleCol, AExampleRow: Integer); overload;
    procedure SetCellStyle(const ACol, ARow: Integer; const AStyle: TcxCacheCellStyle); overload;
    procedure SetCellStyleEx(const ACol, ARow, H, W: Integer; const AStyleIndex: Integer);
    procedure SetCellUnion(const ACol, ARow: Integer; H, W: Integer);
    procedure SetCellValue(const ACol, ARow: Integer; const AValue: Variant);
    procedure SetColumnWidth(const ACol, AWidth: Integer);
    procedure SetDefaultStyle(const AStyle: TcxCacheCellStyle);
    procedure SetRange(const AColCount, ARowCount: Integer; IsVisible: Boolean = True);
    procedure SetRowHeight(const ARow, AHeight: Integer);
    // export graphic extension
    procedure SetCellDataGraphic(const ACol, ARow: Integer; var AGraphic: TGraphic);
    function SupportGraphic: Boolean;
  end;

  { IcxExportWithSeparators }
  IcxExportWithSeparators = interface
  ['{0E2919A6-8B49-49D7-B55B-B44B6DECF2E5}']
    procedure AddSeparator(const ASeparator: string);
  end;

  IcxNameExportProvider = interface
  ['{FC69194E-E3C7-41F4-98AE-5948813210AE}']
    procedure SetName(const AName: string);
    procedure SetRangeName(const AName: AnsiString; const ARange: TRect);
  end;

  { TcxCustomExportProvider }
  TcxCustomExportProvider = class(TInterfacedObject)
  private
    FFileName: WideString;
  protected
    procedure Clear; dynamic;
    property FileName: WideString read FFileName;
  public
    constructor Create(const AFileName: string); virtual;
    procedure BeforeDestruction; override;
    class function ExportType: Integer; virtual;
    class function ExportName: string; virtual;
  end;

  { TcxExport }
  TcxExport = class
  protected
    class function GetExportClassByType(
      AExportType: Integer): TcxExportProviderClass; virtual;
  public
    class function Provider(AExportType: Integer;
      const AFileName: string): TcxCustomExportProvider;
    class procedure SupportExportTypes(EnumSupportTypes: TcxEnumExportTypes);
    class procedure SupportTypes(EnumFunc: TcxEnumTypes);
    class function RegisterProviderClass(AProviderClass: TcxExportProviderClass): Boolean;
  end;

  { TcxExportStyleManager }
  TcxExportStyleManager = class
  private
    FRefCount: Integer;
    FStyles: TList;
    FFileName: string;
    constructor CreateInstance(const AFileName: string);
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TcxCacheCellStyle;
    function StyleCompare(const AStyle1, AStyle2: PcxCacheCellStyle): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    class function GetInstance(const AFileName: string): TcxExportStyleManager;
    function GetStyle(const AIndex: Integer): PcxCacheCellStyle;
    function RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
    property Items[AIndex: Integer]: TcxCacheCellStyle read GetItem; default;
    property Count: Integer read GetCount;
  end;

  { TFileStreamEx }

  TFileStreamEx = class(TFileStream)
  public
    constructor Create(const FileName: string; Mode: Word); overload;
  end;

  TFileStreamClass = class of TFileStream;

  { TcxExportIntList }

  TcxExportIntList = class(TList)
  private
    function GetItem(AIndex: Integer): Integer;
    procedure SetItem(AIndex, AValue: Integer);
  public
    procedure Add(AValue: Integer);
    procedure AddPairs(AValue1, AValue2: Integer);
    function Last: Integer;
    function First: Integer;

    property Items[Index: Integer]: Integer read GetItem write SetItem; default;
  end;

  { TcxExportScale }

  TcxExportScale = class(TcxExportIntList)
  private
    function GetVisibleCount: Integer;
    function GetDelta(AIndex: Integer): Integer;
  public
    procedure Arrange;
    function IndexOf(AItem: Integer): Integer;
    function IndexOfEx(AValue, AFirstIndex, ALastIndex: Integer): Integer;
    procedure GetPosition(AValue1, AValue2: Integer; out AIndex1, AIndex2: Integer);
    procedure GetPositionEx(AValue1, AValue2, AFirstIndex, ALastIndex: Integer; out AIndex1, AIndex2: Integer);

    property Delta[Index: Integer]: Integer read GetDelta;
    property VisibleCount: Integer read GetVisibleCount;
  end;

  TcxColorToRgbProc = function(AColor: Integer): Integer;
  TcxGetResourceStringProc = function(const ResString: Pointer): string;

// unicode supported function prototypes

function cxUnicodeToStr(const AText: WideString; ACharset: Integer = 0): string;
function cxStrToUnicode(const AText: string; ACharset: Integer = 0): Widestring;
function cxStrUnicodeNeeded(const AText: string; ACheckNormal: Boolean = False): Boolean;

function cxChangeFileExtExW(const AFileName: WideString; const ANewExt: string): WideString;
function cxExtractFileNameEx(const AFileName: string): WideString;
function cxExtractFileNameExW(const AFileName: WideString): WideString;
function cxExtractFilePathExW(const AFileName: WideString): WideString;
function cxValidateFileName(const AFileName: string): WideString;
function cxValidateFileNameW(const AFileName: WideString): WideString;

{$IFNDEF DELPHI5}
procedure FreeAndNil(var Obj);
function Supports(Instance: TObject; const Intf: TGUID; out Inst): Boolean;
{$ENDIF}

function cxColorToRGB(const AColor: Integer): Integer;
function cxValidateStr(const AValue: string): string;
function GetHashCode(const Buffer; Count: Integer): Integer;

procedure cxSetCellNativeValue(const ACol, ARow: Integer;
  const AValue: Variant; AProvider: IcxExportProvider);

function SupportGraphic(AGraphic: TGraphic): Boolean; overload;
function SupportGraphic(AGraphicClass: TGraphicClass): Boolean; overload;

procedure GetGraphicAsText(const AFileName: string;
  var AGraphic: TGraphic; var AGraphicText: AnsiString);
procedure GetTextAsGraphicStream(const AText: AnsiString;
  var AFileName: string; var AStream: AnsiString);

procedure cxExportInit(AGetResString: TcxGetResourceStringProc;
  AColorProc: Pointer; AIsNativeColor: Boolean);

procedure UseGraphicImages(AUse: Boolean);

var
  DefaultCellStyle: TcxCacheCellStyle;
  cxFileStreamClass: TFileStreamClass = TFileStreamEx;
  cxBlackColor: Integer;
  cxWindowColor: Integer;
  cxBtnTextColor: Integer;
  cxBtnShadowColor: Integer;
  cxBtnFaceColor: Integer;
  cxGetResString: TcxGetResourceStringProc;
  cxUnicodeSupported: Boolean;

const
  cxExportGraphicClass: TGraphicClass = TBitmap;
  cxExportToBinary = Integer($FFFFFFFF);
  cxExportToHtml   = Integer($00000002);
  cxExportToXml    = Integer($00000003);
  cxExportToText   = Integer($00000004);
  cxExportToExcel  = Integer($00000001);
  cxExportToXlsx   = Integer($00000008);

  cxExportCurrencyFormat: string = '';
  cxDataTypeAnsiString = Integer($00000001);
  cxDataTypeWideString = Integer($00000002);
  cxDataTypeDouble     = Integer($00000003);
  cxDataTypeInteger    = Integer($00000004);
  cxDataTypeGraphic    = Integer($00000005);

  cxDataTypeString     = cxDataTypeAnsiString;

resourcestring
  cxExportListIndexError = 'List index out of bounds (%d)';
implementation

var
  StylesCache: TStringList;
  RegisteredClasses: array of TcxExportProviderClass;
  cxGetRgbColor: TcxColorToRgbProc;
  IsNativeColor: Boolean;
  GraphicCount: Integer;
  GraphicRef: Integer;

function CopyEx(const ASource: WideString; AFrom: Integer; ACount: Integer = MaxInt): WideString;
begin
  Result := '';
  ACount := Min(Length(ASource) - AFrom + 1, ACount);
  if ACount <= 0 then Exit;
  SetLength(Result, ACount);
  Move(ASource[AFrom], Result[1], ACount * SizeOf(WideChar));
end;

function GetLastDelimiterPos(const AFileName: WideString; ADelimiter: WideChar): Integer;
begin
  Result := Length(AFileName);
  if Result = 0 then Exit;
  while (Result > 1) and (AFileName[Result] <> ADelimiter) do
    Dec(Result);
  if AFileName[Result] = ADelimiter then
    Inc(Result);
end;

function cxChangeFileExtExW(const AFileName: WideString; const ANewExt: string): WideString;
var
  APos: Integer;
begin
  APos := GetLastDelimiterPos(AFileName, '.');
  if APos <= 1 then
    Result := AFileName
  else
    Result := CopyEx(AFileName, 1, APos - 2);
  Result := Result + cxStrToUnicode(ANewExt);
end;

function cxExtractFileNameEx(const AFileName: string): Widestring;
begin
  Result := cxExtractFileNameExW(cxStrToUnicode(AFileName));
end;

function cxExtractFileNameExW(const AFileName: WideString): WideString;
begin
  Result := CopyEx(AFileName, GetLastDelimiterPos(AFileName, '\'));
end;

function cxExtractFilePathExW(const AFileName: WideString): WideString;
begin
  Result := CopyEx(AFileName, 1, GetLastDelimiterPos(AFileName, '\') - 1);
end;

function cxValidateFileName(const AFileName: string): WideString;
begin
  Result := cxValidateFileNameW(cxStrToUnicode(AFileName));
end;

function cxValidateFileNameW(const AFileName: WideString): WideString;
begin
  Result := AFileName;
  while Pos('/', Result) <> 0 do
    Result[Pos('/', Result)] := '\';
end;

procedure UseGraphicImages(AUse: Boolean);
begin
  if AUse then
    Inc(GraphicRef)
  else
    Dec(GraphicRef);
  if GraphicRef = 0 then
    GraphicCount := 0;
end;

function CreateDefaultCellStyle: TcxCacheCellStyle;
var
  I: Integer;
begin
  with Result do
  begin
    AlignText := catCenter;
    FillChar(FontName, SizeOf(FontName), 0);
    dxStringToBytes('Tahoma', FontName);
    FontStyle := [];
    FontColor := cxBtnTextColor;
    FontSize := 8;
    FontCharSet := 0;
    for I := 0 to 3 do
    begin
      Borders[I].IsDefault := False;
      Borders[I].Width := 1;
      Borders[I].Color := cxBtnShadowColor;
    end;
    BrushStyle := cbsSolid;
    BrushBkColor := cxWindowColor;
    BrushFgColor := cxBlackColor;
  end;
end;

function cxColorToRGB(const AColor: Integer): Integer;
type
  TRGB = packed record
    R, G, B, A: Byte;
  end;

begin
  Result := cxGetRgbColor(AColor);
  if IsNativeColor then Exit;
  with TRGB(cxGetRgbColor(AColor)) do
  begin
    if AColor < 0 then
      Result := R shl 16 + G shl 8 + B;
  end;
end;

function cxValidateStr(const AValue: string): string;
var
   I: Integer;
begin
  Result := AValue;
  I := 1;
  while I <= Length(Result) do
  begin
    if Result[I] = #13 then
      Delete(Result, I, 1)
    else
      Inc(I)
  end;
end;

procedure cxSetCellNativeValue(const ACol, ARow: Integer; const AValue: Variant;
  AProvider: IcxExportProvider);
var
  ACurr: Currency;
begin
  case TVarData(AValue).VType of
    VarInt64, varSingle, varDouble:
      AProvider.SetCellDataDouble(ACol, ARow, AValue);
    varCurrency:
      AProvider.SetCellDataCurrency(ACol, ARow, AValue);
    varDate:
      AProvider.SetCellDataDateTime(ACol, ARow, AValue);
  {$IFDEF DELPHI12}
    varUString,
  {$ENDIF}
    varOleStr:
      AProvider.SetCellDataWideString(ACol, ARow, AValue);
    varSmallInt, varInteger,
    varWord, varShortInt, varLongWord, varByte:
      AProvider.SetCellDataInteger(ACol, ARow, AValue);
    varBoolean:
      AProvider.SetCellDataBoolean(ACol, ARow, AValue);
    varString:
      AProvider.SetCellDataString(ACol, ARow, cxValidateStr(AValue));
{$IFNDEF NONDB}
  else
    if TVarData(AValue).VType = VarSQLTimeStamp then
      AProvider.SetCellDataDateTime(ACol, ARow, AValue)
    else
      if TVarData(AValue).VType = VarFMTBcd then
      begin
        if BcdToCurr(VarToBcd(AValue), ACurr) then
          cxSetCellNativeValue(ACol, ARow, Currency(ACurr), AProvider)
        else
          cxSetCellNativeValue(ACol, ARow, Double(BcdToDouble(VarToBcd(AValue))), AProvider);
      end;
{$ENDIF}
  end;
end;

{$IFDEF WIN32}
function cxUnicodeToStr(const AText: WideString; ACharset: Integer = 0): string;
begin
  Result := dxWideStringToString(AText, dxGetCodePageFromCharset(ACharset));
end;

function cxStrToUnicode(const AText: string; ACharset: Integer = 0): Widestring;
begin
  Result := dxStringToWideString(AText, dxGetCodePageFromCharset(ACharset));
end;
{$ELSE}
function cxStrToUnicode(const AText: string; ACharset: Integer = 0): Widestring;
begin
  Result := AText;
end;
{$ENDIF}

function cxStrUnicodeNeeded(const AText: string; ACheckNormal: Boolean = False): Boolean;
var
  I: Integer;
const
  ANormal = ['0'..'9', ':', ';', '*', '+', ',', '-', '.', '/', '!', ' ',
    'A'..'Z', 'a'..'z', '_', '(', ')'];
begin
  Result := False;
  for I := 1 to Length(AText) do
    if (Ord(AText[I]) > $7F) or (ACheckNormal and not dxCharInSet(AText[I], ANormal)) then
    begin
      Result := True;
      Break;
    end
end;

function GetHashCode(const Buffer; Count: Integer): Integer; assembler;
asm
        MOV     ECX, EDX
        MOV     EDX, EAX
        XOR     EAX, EAX
@@1:    ROL     EAX, 5
        XOR     AL, [EDX]
        INC     EDX
        DEC     ECX
        JNE     @@1
end;

function GetGraphicFileName(const AFileName, AExt: string): string;
begin
  Result := ChangeFileExt(AFileName, '.images') + '\' + ChangeFileExt(
    ExtractFileName(AFileName), '') + '_' + IntToStr(GraphicCount) + '.' + AExt;
  Inc(GraphicCount);
end;

function PrepareGraphic(AGraphic: TGraphic): TGraphic;
begin
  Result := AGraphic;
  if not SupportGraphic(cxExportGraphicClass) then
  begin
    Result := cxExportGraphicClass.Create;
    try
      try
        Result.Assign(AGraphic);
      except
        Result.Free;
        Result := AGraphic;
      end;
    finally
      if Result <> AGraphic then
        AGraphic.Free;
    end;
  end;
end;

function SupportGraphic(AGraphic: TGraphic): Boolean;
begin
  Result := SupportGraphic(TGraphicClass(AGraphic.ClassType));
end;

function SupportGraphic(AGraphicClass: TGraphicClass): Boolean;
begin
  Result := (AGraphicClass <> nil) and
   (AGraphicClass.InheritsFrom(TBitmap) or
    AGraphicClass.InheritsFrom(TMetaFile));
end;

procedure GetGraphicAsText(const AFileName: string;
  var AGraphic: TGraphic; var AGraphicText: AnsiString);
var
  L: Integer;
  AName: AnsiString;
  AMemStream: TMemoryStream;
begin
  AGraphic := PrepareGraphic(AGraphic);
  AName := dxStringToAnsiString(GetGraphicFileName(AFileName,
    GraphicExtension(TGraphicClass(AGraphic.ClassType))));
  AMemStream := TMemoryStream.Create;
  try
    AGraphic.SaveToStream(AMemStream);
    L := Length(AName);
    SetLength(AGraphicText, AMemStream.Size + L + SizeOf(L));
    Move(L, AGraphicText[1], SizeOf(L) * SizeOf(Char));
    Move(AName[1], AGraphicText[1 + SizeOf(L)], L);
    Move(AMemStream.Memory^, AGraphicText[1 + SizeOf(L) + L], AMemStream.Size);
  finally
    AMemStream.Free;
  end;
end;

procedure GetTextAsGraphicStream(const AText: AnsiString;
  var AFileName: string; var AStream: AnsiString);
var
  L: Integer;
  AFileNameA: AnsiString;
begin
  Move(AText[1], L, SizeOf(L));
  SetLength(AFileNameA, L);
  Move(AText[1 + SizeOf(L)], AFileNameA[1], L);
  SetLength(AStream, Length(AText) - SizeOf(L) - L);
  Move(AText[1 + SizeOf(L) + L], AStream[1], Length(AStream));
  AFileName := dxAnsiStringToString(AFileNameA);
end;

{$IFNDEF DELPHI5}
procedure FreeAndNil(var Obj);
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;

function Supports(Instance: TObject; const Intf: TGUID; out Inst): Boolean;
begin
  Result := (Instance <> nil) and Instance.GetInterface(Intf, Inst);
end;
{$ENDIF}

{ TcxExport }
class function TcxExport.Provider(AExportType: Integer;
  const AFileName: string): TcxCustomExportProvider;
begin
  Result := GetExportClassByType(AExportType).Create(AFileName);
end;

class procedure TcxExport.SupportExportTypes(
  EnumSupportTypes: TcxEnumExportTypes);
var
  I: Integer;
begin
  for I := 0 to Length(RegisteredClasses) - 1  do
  begin
    with RegisteredClasses[I] do
      EnumSupportTypes(ExportType, ExportName);
  end;
end;

class procedure TcxExport.SupportTypes(EnumFunc: TcxEnumTypes);
var
  I: Integer;
begin
  for I := 0 to Length(RegisteredClasses) - 1 do
    EnumFunc(RegisteredClasses[I].ExportType);
end;

class function TcxExport.RegisterProviderClass(AProviderClass: TcxExportProviderClass): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AProviderClass = nil then
    Exit;
  for I := 0 to Length(RegisteredClasses) - 1 do
  begin
    if (AProviderClass.ExportType = RegisteredClasses[I].ExportType) or
      (AProviderClass = RegisteredClasses[I]) then Exit;
  end;
  I := Length(RegisteredClasses);
  SetLength(RegisteredClasses, I + 1);
  RegisteredClasses[I] := AProviderClass;
  Result := True;
end;

class function TcxExport.GetExportClassByType(
  AExportType: Integer): TcxExportProviderClass;
var
  I: Integer;
begin
  for I := 0 to Length(RegisteredClasses) - 1 do
  begin
    if RegisteredClasses[I].ExportType = AExportType then
    begin
      Result := RegisteredClasses[I];
      Exit;
    end;
  end;
  raise EcxExportData.CreateFmt(cxGetResString(@scxUnsupportedExport), [AExportType]);
end;

{ TcxCustomExportProvider }
constructor TcxCustomExportProvider.Create(const AFileName: string);
begin
  FFileName := cxValidateFileName(AFileName);
end;

procedure TcxCustomExportProvider.BeforeDestruction;
begin
  Clear;
end;

class function TcxCustomExportProvider.ExportType: Integer;
begin
  Result := -1;
end;

class function TcxCustomExportProvider.ExportName: string;
begin
  Result := '';
end;

procedure TcxCustomExportProvider.Clear;
begin
end;

{ TcxExportStyleManager }
constructor TcxExportStyleManager.Create;
begin
  raise EcxExportData.Create(cxGetResString(@scxStyleManagerCreate));
end;

destructor TcxExportStyleManager.Destroy;
begin
  if FRefCount <> 0 then
    raise EcxExportData.Create(cxGetResString(@scxStyleManagerKill));
  inherited Destroy;
end;

procedure TcxExportStyleManager.Clear;
var
  I: Integer;
begin
  Dec(FRefCount);
  if FRefCount = 0 then
  begin
    try
      for I := 0 to FStyles.Count - 1 do
        FreeMem(PcxCacheCellStyle(FStyles[I]));
      if StylesCache.Find(FFileName, I) then
        StylesCache.Delete(I);
    finally
      FStyles.Free;
      Destroy;
    end;
  end;
end;

class function TcxExportStyleManager.GetInstance(
  const AFileName: string): TcxExportStyleManager;
var
  AIndex: Integer;
begin
  if StylesCache.Find(AFileName, AIndex) then
  begin
    Result := TcxExportStyleManager(StylesCache.Objects[AIndex]);
    Result.RegisterStyle(DefaultCellStyle);
    Inc(Result.FRefCount);
  end
  else
    Result := CreateInstance(AFileName);
end;

function TcxExportStyleManager.GetStyle(const AIndex: Integer): PcxCacheCellStyle;
begin
  Result := FStyles[AIndex];
end;

function TcxExportStyleManager.RegisterStyle(
  const AStyle: TcxCacheCellStyle): Integer;
var
  I: Integer;
  NewStyleItem, AStylePtr: PcxCacheCellStyle;
begin
  AStylePtr := @AStyle;
  AStylePtr^.HashCode :=
    cxExport.GetHashCode(AStyle, SizeOf(TcxCacheCellStyle) - SizeOf(Integer));
  for I := 0 to FStyles.Count - 1 do
    if StyleCompare(FStyles[I], @AStyle) then
    begin
      Result := I;
      Exit;
    end;
  New(NewStyleItem);
  NewStyleItem^ := AStylePtr^;
  Result := FStyles.Add(NewStyleItem);
end;

function TcxExportStyleManager.GetCount: Integer;
begin
  Result := FStyles.Count;
end;

function TcxExportStyleManager.GetItem(AIndex: Integer): TcxCacheCellStyle;
begin
  Result := GetStyle(AIndex)^;
end;

constructor TcxExportStyleManager.CreateInstance(const AFileName: string);
begin
  FStyles := TList.Create;
  StylesCache.AddObject(AFileName, Self);
  FFileName := AFileName;
  FRefCount := 1;
end;

function TcxExportStyleManager.StyleCompare(
  const AStyle1, AStyle2: PcxCacheCellStyle): Boolean;
begin
  Result := (AStyle1.HashCode = AStyle2.HashCode) and
    CompareMem(AStyle1, AStyle2, SizeOf(TcxCacheCellStyle) - SizeOf(Integer));
end;

constructor TFileStreamEx.Create(const FileName: string; Mode: Word);
{$IFDEF DELPHI6}
var
  AName: WideString;
{$ENDIF}
begin
{$IFDEF DELPHI6}
  if cxUnicodeSupported then
  begin
    AName := cxStrToUnicode(FileName);
    FHandle := Integer(CreateFileW(PWideChar(AName), GENERIC_READ or GENERIC_WRITE,
      0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
  end
  else
{$ENDIF}
    inherited Create(FileName, Mode);
end;

function CompareValues(AItem1, AItem2: Pointer): Integer;
begin
  Result := Integer(AItem1) - Integer(AItem2);
end;

{ TcxExportIntList }

procedure TcxExportIntList.Add(AValue: Integer);
begin
  if Capacity - Count < 2 then
    if Count * 2 < 1024 then
      Capacity := 1024
    else
      Capacity := Count  * 2;
  inherited Add(Pointer(AValue));
end;

procedure TcxExportIntList.AddPairs(AValue1, AValue2: Integer);
begin
  if Capacity - Count < 2 then
    if Count * 2 < 1024 then
      Capacity := 1024
    else
      Capacity := Count  * 2;
  inherited Add(Pointer(AValue1));
  inherited Add(Pointer(AValue2));
end;

function TcxExportIntList.Last: Integer;
begin
  Result := Integer(inherited Last);
end;

function TcxExportIntList.First: Integer;
begin
  Result := Integer(inherited First);
end;

function TcxExportIntList.GetItem(AIndex: Integer): Integer;
begin
  Result := Integer(List^[AIndex]);
end;

procedure TcxExportIntList.SetItem(AIndex, AValue: Integer);
begin
  Integer(List^[AIndex]) := AValue
end;

{ TcxExportScale }

procedure TcxExportScale.Arrange;
var
  AIndex, I: Integer;
begin
  Sort(@CompareValues);
  AIndex := 0;
  for I := 1 to Count - 1 do
  begin
    if List^[AIndex] <> List^[I] then
      Inc(AIndex);
    List^[AIndex] := List^[I];
  end;
  if Count > 0 then
    Count := AIndex + 1;
end;

function TcxExportScale.IndexOf(AItem: Integer): Integer;
begin
  Result := IndexOfEx(AItem, 0, VisibleCount);
end;

function TcxExportScale.IndexOfEx(AValue, AFirstIndex, ALastIndex: Integer): Integer;
var
  L, H, I, C: Integer;
begin
  Result := -1;
  // binary search
  L := AFirstIndex;
  H := ALastIndex;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Integer(List^[I]) - AValue;
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
  if Result = - 1 then
    Error(@cxExportListIndexError, AValue);
end;

procedure TcxExportScale.GetPosition(
  AValue1, AValue2: Integer; out AIndex1, AIndex2: Integer);
begin
  AIndex1 := IndexOf(AValue1);
  AIndex2 := IndexOfEx(AValue2, AIndex1, Count - 1);
end;

procedure TcxExportScale.GetPositionEx(AValue1, AValue2,
  AFirstIndex, ALastIndex: Integer; out AIndex1, AIndex2: Integer);
begin
  AIndex1 := IndexOfEx(AValue1, AFirstIndex, ALastIndex);
  AIndex2 := IndexOfEx(AValue2, AIndex1, ALastIndex);
end;

function TcxExportScale.GetVisibleCount: Integer;
begin
  Result := Count;
  Dec(Result);
end;

function TcxExportScale.GetDelta(AIndex: Integer): Integer;
begin
  Result := Integer(List^[AIndex + 1]) - Integer(List^[AIndex]);
end;

function GetCurrencyFormat: string;

  function GetCharString(C: Char; ACount: Integer): string;
  var
    I: Integer;
  begin
    Result := '';
    for I := 1 to ACount do
      Result := Result + C;
  end;

  function GetPositiveCurrencyFormat(const AFormat, ACurrStr: string): string;
  begin
    if Length(ACurrStr) > 0 then
      case dxFormatSettings.CurrencyFormat of
        0: Result := ACurrStr + AFormat; { '$1' }
        1: Result := AFormat + ACurrStr; { '1$' }
        2: Result := ACurrStr + ' ' + AFormat; { '$ 1' }
        3: Result := AFormat + ' ' + ACurrStr; { '1 $' }
      end;
  end;

  function GetNegativeCurrencyFormat(const AFormat, ACurrStr: string): string;
  begin
    case dxFormatSettings.NegCurrFormat of
      0: Result := '(' + ACurrStr + AFormat + ')';
      1: Result := '-' + ACurrStr + AFormat;
      2: Result := ACurrStr + '-' + AFormat;
      3: Result := ACurrStr + AFormat + '-';
      4: Result := '(' + AFormat + ACurrStr + ')';
      5: Result := '-' + AFormat + ACurrStr;
      6: Result := AFormat + '-' + ACurrStr;
      7: Result := AFormat + ACurrStr + '-';
      8: Result := '-' + AFormat + ' ' + ACurrStr;
      9: Result := '-' + ACurrStr + ' ' + AFormat;
      10: Result := AFormat + ' ' + ACurrStr + '-';
      11: Result := ACurrStr + ' ' + AFormat + '-';
      12: Result := ACurrStr + ' ' + '-' + AFormat;
      13: Result := AFormat + '-' + ' ' + ACurrStr;
      14: Result := '(' + ACurrStr + ' ' + AFormat + ')';
      15: Result := '(' + AFormat + ' ' + ACurrStr + ')';
    end;
  end;

var
  ACurrStr: string;
  I: Integer;
  C: Char;
begin
  if dxFormatSettings.CurrencyDecimals > 0 then
    Result := GetCharString('0', dxFormatSettings.CurrencyDecimals)
  else
    Result := '';
  Result := ',0.' + Result;
  ACurrStr := '';
  for I := 1 to Length(dxFormatSettings.CurrencyString) do
  begin
    C := dxFormatSettings.CurrencyString[I];
    if (C = ',') or (C = '.') then
      ACurrStr := ACurrStr + '''' + C + ''''
    else
      ACurrStr := ACurrStr + C;
  end;
  Result := GetPositiveCurrencyFormat(Result, ACurrStr) + ';' +
    GetNegativeCurrencyFormat(Result, ACurrStr);
end;

procedure cxExportInit(AGetResString: TcxGetResourceStringProc;
  AColorProc: Pointer; AIsNativeColor: Boolean);
begin
  cxGetResString := AGetResString;
  cxGetRgbColor := AColorProc;
  IsNativeColor := AIsNativeColor;
  cxUnicodeSupported := IsWin2KOrLater;
{$IFDEF WIN32}
  cxWindowColor := Windows.GetSysColor(COLOR_WINDOW);
  cxBtnTextColor := Windows.GetSysColor(COLOR_BTNTEXT);
  cxBtnFaceColor := Windows.GetSysColor(COLOR_BTNFACE);
  cxBtnShadowColor := Windows.GetSysColor(COLOR_BTNSHADOW);
{$ELSE}
  cxWindowColor := cxColorToRGB(clWindow);
  cxBtnTextColor := cxColorToRGB(clBtnText);
  cxBtnFaceColor := cxColorToRGB(clBtnFace);
  cxBtnShadowColor := ColorToRGB(clBtnShadow);
{$ENDIF}
  FreeAndNil(StylesCache);
  StylesCache := TStringList.Create;
  DefaultCellStyle := CreateDefaultCellStyle;
  cxExportCurrencyFormat := GetCurrencyFormat;
end;

initialization
  StylesCache := nil;

finalization
  FreeAndNil(StylesCache);

end.
