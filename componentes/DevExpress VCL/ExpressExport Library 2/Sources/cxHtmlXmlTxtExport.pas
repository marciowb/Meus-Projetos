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
unit cxHtmlXmlTxtExport;

{$I cxVer.inc}

interface
uses
  SysUtils, Math, Classes,
  Windows,
{$IFDEF DELPHI6} Variants, {$IFNDEF NONDB} FMTBcd, SqlTimSt, {$ENDIF} {$ENDIF}
  cxExport, cxExportStrs, Graphics;

const
  CharsetTag: string = {$IFDEF DELPHI12}' charset=utf-8' {$ELSE} '' {$ENDIF};
  EncodingTag: string = '';

type
  { TcxCustomHtmlXmlTXTExportProvider }
  TcxCustomHtmlXmlTXTExportProvider = class(TcxCustomExportProvider, IcxExportProvider)
  private
    FCache: array of array of TcxCacheItem;
    FColumns: array of Integer;
    FDefaultStyle: TcxCacheCellStyle;
    FInternalCacheList: TInterfaceList;
    FName: string;
    FRows: array of Integer;
    FStyleManager: TcxExportStyleManager;
    function GetCacheItem(ACol, ARow: Integer): TcxCacheItem;
    function GetCellHeight(ACol, ARow: Integer): Integer;
    function GetCellWidth(ACol, ARow: Integer): Integer;
    function GetColumns(ACol: Integer): Integer;
    function GetDefaultStyle: PcxCacheCellStyle;
    function GetHeight: Integer;
    function GetInternalCacheCount: Integer;
    function GetInternalCacheItems(AIndex: Integer): IcxCellInternalCache;
    function GetRows(ARow: Integer): Integer;
    function GetStyleCount: Integer;
    function GetWidth: Integer;
    procedure TestIndex(ACol, ARow: Integer);
    procedure TestCol(ACol: Integer);
    procedure TestRow(ARow: Integer);
    procedure TestStyleIndex(AStyleIndex: Integer);
  protected
    procedure Clear; override;
    function GetCellData(const ACol, ARow: Integer; var AData): Boolean;
    procedure SetData(const ACol, ARow, ADataSize, ADataType: Integer; const AData);
    procedure SetEmptyData(const ACol, ARow, ADataType: Integer);
    procedure Commit; dynamic;
    function GetCacheName: string;
    function GetCellStyle(const ACol, ARow: Integer): PcxCacheCellStyle;
    function GetExportType: Integer;
    function GetExportName: string;
    function GetStyle(AStyleIndex: Integer): PcxCacheCellStyle;
    function RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
    procedure SetCellDataString(const ACol, ARow: Integer; const AText: string); virtual;
    procedure SetCellDataAnsiString(const ACol, ARow: Integer; const AText: AnsiString); virtual;
    procedure SetCellDataBoolean(const ACol, ARow: Integer; const AValue: Boolean);
    procedure SetCellDataCurrency(const ACol, ARow: Integer; const AValue: Currency);
    procedure SetCellDataDateTime(const ACol, ARow: Integer; const AValue: TDateTime);
    procedure SetCellDataWideString(const ACol, ARow: Integer; const AText: WideString); virtual;
    procedure SetCellDataDouble(const ACol, ARow: Integer; const AValue: Double); virtual;
    procedure SetCellDataInteger(const ACol, ARow: Integer; const AValue: Integer); virtual;
    procedure SetCellStyle(const ACol, ARow, AStyleIndex: Integer); overload; virtual;
    procedure SetCellStyle(const ACol, ARow, AExampleCol, AExampleRow: Integer); overload; virtual;
    procedure SetCellStyle(const ACol, ARow: Integer; const AStyle: TcxCacheCellStyle); overload; virtual;
    procedure SetCellStyleEx(const ACol, ARow, H, W: Integer; const AStyleIndex: Integer);
    procedure SetCellUnion(const ACol, ARow: Integer; H, W: Integer);
    procedure SetCellValue(const ACol, ARow: Integer; const AValue: Variant);
    procedure SetColumnWidth(const ACol, AWidth: Integer);
    procedure SetDefaultStyle(const AStyle: TcxCacheCellStyle);
    procedure SetRange(const AColCount, ARowCount: Integer; IsVisible: Boolean = True);
    procedure SetRowHeight(const ARow, AHeight: Integer);
    // export graphic extension
    procedure SetCellDataGraphic(const ACol, ARow: Integer; var AGraphic: TGraphic);
    procedure SetCellPNGImage(const ACol, ARow: Integer; APNGImage: TObject);
    function SupportGraphic: Boolean; virtual;

    property Cache[ACol, ARow: Integer]: TcxCacheItem read GetCacheItem;
    property Columns[ACol: Integer]: Integer read GetColumns;
    property DefaultStyle: PcxCacheCellStyle read GetDefaultStyle;
    property RowCount: Integer read GetHeight;
    property InternalCacheCount: Integer read GetInternalCacheCount;
    property InternalCacheItems[AIndex: Integer]: IcxCellInternalCache read GetInternalCacheItems;
    property Name: string read FName write FName;
    property Rows[ARow: Integer]: Integer read GetRows;
    property StyleCount: Integer read GetStyleCount;
    property Styles[AIndex: Integer]: PcxCacheCellStyle read GetStyle;
    property CellHeight[ACol, ARow: Integer]: Integer read GetCellHeight;
    property CellWidth[ACol, ARow: Integer]: Integer read GetCellWidth;
    property ColCount: Integer read GetWidth;
  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;
  end;

  { TcxCustomExportProviderSupportedCellInternalChache }
  TcxCustomExportProviderSupportedCellInternalChache = class(TcxCustomHtmlXmlTXTExportProvider, IcxCellInternalCache)
  protected
    procedure CommitCache(AStream: TStream; AParam: Pointer); virtual;
    procedure CommitStyle(AStream: TStream; AParam: Pointer); virtual;
    procedure DeleteCacheFromCell(const ACol, ARow: Integer);
    procedure SetCacheIntoCell(const ACol, ARow: Integer; ACache: IcxCellInternalCache);
    procedure SetEmptyCellsStyle;
  end;

  { TcxHTMLExportProvider }
  TcxHTMLExportProvider = class(TcxCustomExportProviderSupportedCellInternalChache)
  private
    procedure CommitHTML(AStream: TStream);
    function GetStyle(AStyle: TcxCacheCellStyle): string;
    function GetScaleRow: string;
  protected
    procedure CommitCache(AStream: TStream; AParam: Pointer); override;
    procedure CommitStyle(AStream: TStream; AParam: Pointer); override;
    function GetContentWidth: Integer;
  public
    procedure Commit; override;
    class function ExportType: Integer; override;
    class function ExportName: string; override;
  end;

  { TcxXMLExportProvider }
  TcxXMLExportProvider = class(TcxCustomExportProviderSupportedCellInternalChache)
  private
    FHideDotsOn: Boolean;
    FXSLFileName: WideString;
    procedure CommitXML(AStream: TStream);
    procedure CommitXSL(AStream: TStream);
    function ConvertTextToXML(const AText: string; ACol, ARow: Integer): string;
    function GetBorderStyle(AStyle: TcxCacheCellStyle): string;
    function GetCellParams(ACol, ARow: Integer): string;
    function GetData(ACol, ARow: Integer): string;
    function GetStyle(AStyle: TcxCacheCellStyle): string;
    procedure HideDots;
    function GetScaleLine: string;
  protected
    procedure CommitCache(AStream: TStream; AParam: Pointer); override;
    procedure CommitStyle(AStream: TStream; AParam: Pointer); override;
  public
    constructor Create(const AFileName: string); override;
    procedure Commit; override;
    class function ExportType: Integer; override;
    class function ExportName: string; override;
  end;

  { TcxTXTExportProvider }
  TcxTXTExportProvider = class(TcxCustomExportProviderSupportedCellInternalChache, IcxExportWithSeparators)
  private
    FBeginString: string;
    FColMaxWidth: array of Integer;
    FEndString: string;
    FIndex: Integer;
    FSeparator: string;
    procedure CalculateColMaxWidth;
    function GetData(ACol, ARow: Integer): string;
  protected
    procedure AddSeparator(const ASeparator: string);
    procedure CommitCache(AStream: TStream; AParam: Pointer); override;
    function SupportGraphic: Boolean; override;
  public
    constructor Create(const AFileName: string); override;
    procedure Commit; override;
    class function ExportType: Integer; override;
    class function ExportName: string; override;
  end;

const
  cxXMLEmptyChar = '.';
  cxExportDefaultEmptyString: string = '&nbsp';

implementation

uses
  dxCore;

function HasBorders(ACellStyle: PcxCacheCellStyle): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to 3 do
    Result := Result or (ACellStyle.Borders[I].Width > 0);
end;

function DirExist(const ADirectory: string): Boolean;
{$IFNDEF DELPHI6}
var
  ACode: Integer;
{$ENDIF}
begin
{$IFDEF DELPHI6}
  Result := DirectoryExists(ADirectory);
{$ELSE}
  ACode := GetFileAttributes(PChar(ADirectory));
  Result := (ACode <> -1) and (FILE_ATTRIBUTE_DIRECTORY and ACode <> 0);
{$ENDIF}
end;

function GraphicNeeded(const ADir, AGraphicData: AnsiString; AddTags: Boolean = True): string;
var
  F: File;
  AGraphicStream: AnsiString;
begin
  GetTextAsGraphicStream(AGraphicData, Result, AGraphicStream);
  if not DirExist(ExtractFileDir(Result)) then
    CreateDir(ExtractFileDir(Result));
  AssignFile(F, Result);
  Rewrite(F, 1);
  try
    BlockWrite(F, AGraphicStream[1], Length(AGraphicStream));
  finally
    CloseFile(F);
  end;
  Delete(Result, 1, Length(ADir));
  while Pos('\', Result) <> 0 do
    Result[Pos('\', Result)] := '/';
  if AddTags then
    Result := '<img src="' + Result + '"></img>';
end;

function GetHTMLColor(AColor: Integer): string;
begin
  Result := Format('rgb(%d,%d,%d)', [GetRValue(AColor), GetGValue(AColor), GetBValue(AColor)]);
end;

function ConvertCRLFSymbols(const AString: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AString) do
  begin
    if AString[I] = #13 then
    begin
      if I < Length(AString) then
        if AString[I + 1] = #10 then
        begin
          Result := Result + '<BR>';
          Continue;
        end;
    end
    else if AString[I] = #10 then
    begin
      if I > 1 then
      begin
        if AString[I - 1] <> #13 then
          Result := Result + '<BR>';
      end
      else
        Result := Result + '<BR>';
      Continue;
    end;
    Result := Result + AString[I];
  end;
end;

function ConvertSpecialCharacters(const AString: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AString) do
  begin
   if AString[I] = '<' then
     Result := Result + '&lt;'
   else if AString[I] = '>' then
     Result := Result + '&gt;'
   else if AString[I] = '&' then
     Result := Result + '&amp;'
   else if AString[I] = '"' then
     Result := Result + '&quot;'
   else
     Result := Result + AString[I];
  end;
end;

function CheckedUnicodeString(const S: string; ACharset: Integer = 0): string;
var
  I: Integer;
  W: WideString;
begin
  if cxStrUnicodeNeeded(S, True) then
  begin
    W := cxStrToUnicode(S, ACharset);
    Result := '';
    for I := 1 to Length(W) do
      Result := Result + '&#' + IntToStr(Integer(W[I])) + ';';
  end
  else
    Result := S;
end;

function CheckedUnicodeStringW(const S: WideString): string;
var
  I: Integer;
begin
  if cxUnicodeSupported then
  begin
    Result := '';
    for I := 1 to Length(S) do
      Result := Result + '&#' + IntToStr(Integer(S[I])) + ';';
  end
  else
    Result := cxUnicodeToStr(S);
end;

{ TcxCustomHtmlXmlTXTExportProvider }
constructor TcxCustomHtmlXmlTXTExportProvider.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FDefaultStyle := DefaultCellStyle;
  FInternalCacheList := TInterfaceList.Create;
  FStyleManager := TcxExportStyleManager.GetInstance(AFileName);
  FName := '';
  UseGraphicImages(True);
end;

destructor TcxCustomHtmlXmlTXTExportProvider.Destroy;
begin
  UseGraphicImages(False);
  FInternalCacheList.Free;
  FStyleManager.Clear;
  inherited Destroy;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.Clear;
var
  I, J: Integer;
begin
  for I := 0 to Length(FCache) - 1 do
    for J := 0 to Length(FCache[I]) - 1 do
    try
      with FCache[I, J] do
        ReallocMem(FCache[I, J].Data, 0);
    finally
      FCache[I, J].Data := nil;
      FCache[I, J].InternalCache.Cache := nil;
      FCache[I, J].InternalCache.Index := -1;
    end;

  FInternalCacheList.Clear;
  SetLength(FCache, 0, 0);
  SetLength(FColumns, 0);
  SetLength(FRows, 0);
end;

function TcxCustomHtmlXmlTXTExportProvider.GetCacheName: string;
begin
  Result := FName;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetCellData(const ACol, ARow: Integer; var AData): Boolean;
begin
  TestIndex(ACol, ARow);

  with FCache[ACol, ARow] do
  begin
    Result := Data <> nil;
    if Result then
      Move(Data^, AData, DataSize);
  end;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetCellStyle(const ACol,
  ARow: Integer): PcxCacheCellStyle;
begin
  TestIndex(ACol, ARow);
  with FCache[ACol, ARow] do
  begin
    if StyleIndex < 0 then
      Result := @FDefaultStyle
    else
      Result := FStyleManager.GetStyle(StyleIndex);
  end;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetExportType: Integer;
begin
  Result := ExportType;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetExportName: string;
begin
  Result := ExportName;
end;

function TcxCustomHtmlXmlTXTExportProvider.RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
begin
  Result := FStyleManager.RegisterStyle(AStyle)
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataString(const ACol, ARow: Integer; const AText: string);
const
  ADataTypeMap: array[Boolean] of Integer = (cxDataTypeString, cxDataTypeWideString);
var
  ADataType: Integer;
begin
  ADataType := ADataTypeMap[SizeOf(Char) > 1];

  if AText <> '' then
    SetData(ACol, ARow, dxStringSize(AText), ADataType, AText[1])
  else
    SetEmptyData(ACol, ARow, ADataType);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataAnsiString(const ACol, ARow: Integer; const AText: AnsiString);
begin
  if AText <> '' then
    SetData(ACol, ARow, Length(AText), cxDataTypeString, AText[1])
  else
    SetEmptyData(ACol, ARow, cxDataTypeString);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataBoolean(
 const ACol, ARow: Integer; const AValue: Boolean);
begin
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataCurrency(
  const ACol, ARow: Integer; const AValue: Currency);
begin
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataDateTime(
  const ACol, ARow: Integer; const AValue: TDateTime);
begin
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataWideString(const ACol, ARow: Integer; const AText: WideString);
begin
  if AText <> '' then
    SetData(ACol, ARow, Length(AText) * SizeOf(Char), cxDataTypeWideString, AText[1])
  else
    SetEmptyData(ACol, ARow, cxDataTypeWideString);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataDouble(const ACol, ARow: Integer; const AValue: Double);
begin
  SetData(ACol, ARow, Sizeof(Double), cxDataTypeDouble, AValue);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataInteger(const ACol, ARow: Integer; const AValue: Integer);
begin
  SetData(ACol, ARow, Sizeof(Integer), cxDataTypeInteger, AValue);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellStyle(const ACol, ARow, AStyleIndex: Integer);
begin
  TestIndex(ACol, ARow);
  TestStyleIndex(AStyleIndex);

  FCache[ACol, ARow].StyleIndex := AStyleIndex;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellStyle(const ACol, ARow, AExampleCol,
  AExampleRow: Integer);
begin
  TestIndex(ACol, ARow);
  TestIndex(AExampleCol, AExampleRow);

  FCache[ACol, ARow].StyleIndex := FCache[AExampleCol, AExampleRow].StyleIndex;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellStyle(const ACol, ARow: Integer;
  const AStyle: TcxCacheCellStyle);
begin
  TestIndex(ACol, ARow);

  FCache[ACol, ARow].StyleIndex := RegisterStyle(AStyle);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellStyleEx(
  const ACol, ARow, H, W: Integer; const AStyleIndex: Integer);
begin
  SetCellStyle(ACol, ARow, AStyleIndex);
  SetCellUnion(ACol, ARow, H, W);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellUnion(const ACol, ARow: Integer;
  H, W: Integer);
var
  I, J: Integer;
begin
  TestIndex(ACol, ARow);
  W := Min(W, Length(FCache) - ACol);
  if W < 1 then
    W := 1;
  H := Min(H, Length(FCache[ACol]) - ARow);
  if H < 1 then
    H := 1;
  with FCache[ACol, ARow] do
  begin
    IsUnion := True;
    Height := H;
    Width := W;
    for I := ACol to ACol + Width - 1 do
      for J := ARow to ARow + Height - 1 do
        FCache[I, J].IsHidden := not ((I = ACol) and (J = ARow));
  end;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellValue(const ACol,
  ARow: Integer; const AValue: Variant);
var
{$IFDEF DELPHI6}
  {$IFNDEF NONDB}
  ACurr: Currency;
  {$ENDIF}
{$ENDIF}
  AText: string;
begin
  if VarIsNull(AValue) then
    AText := ''
  else
    if TVarData(AValue).VType = varCurrency then
      AText := FormatFloat(cxExportCurrencyFormat, Currency(AValue))
    else
{$IFDEF DELPHI6}
  {$IFNDEF NONDB}
    if TVarData(AValue).VType = VarSQLTimeStamp then
      AText := DateTimeToStr(AValue)
    else
      if TVarData(AValue).VType = VarFMTBcd then
      begin
        if BcdToCurr(VarToBcd(AValue), ACurr) then
          AText := FormatFloat(cxExportCurrencyFormat, ACurr)
        else
          AText := FloatToStr(Double(BcdToDouble(VarToBcd(AValue))));
      end
      else
  {$ENDIF}
{$ENDIF}
  AText := AValue;
  SetCellDataString(ACol, ARow, AText);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetColumnWidth(const ACol, AWidth: Integer);
begin
  TestCol(ACol);
  if AWidth < 0 then
    raise EcxExportData.Create(cxGetResString(@scxIllegalWidth));
  FColumns[ACol] := Abs(AWidth);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetDefaultStyle(const AStyle: TcxCacheCellStyle);
begin
  FDefaultStyle := AStyle;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetData(const ACol, ARow, ADataSize,
    ADataType: Integer; const AData);
begin
  TestIndex(ACol, ARow);

  with FCache[ACol, ARow] do
  begin
    ReallocMem(Data, ADataSize);
    Move(AData, Data^, ADataSize);
    DataSize := ADataSize;
    DataType := ADataType;
  end;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetEmptyData(const ACol, ARow, ADataType: Integer);
begin
  TestIndex(ACol, ARow);

  with FCache[ACol, ARow] do
  begin
    ReallocMem(Data, 0);
    Data := nil;
    DataSize := 0;
    DataType := ADataType;
  end;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.Commit;
begin
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetRange(const AColCount, ARowCount: Integer;
    IsVisible: Boolean);
var
  I, J, K: Integer;
  ABorderWidth: Integer;
begin
  if (AColCount <= 0) or (ARowCount <= 0) then
    raise EcxExportData.Create(cxGetResString(@scxInvalidColumnRowCount));

  SetLength(FCache, AColCount, ARowCount);
  SetLength(FColumns, AColCount);
  SetLength(FRows, ARowCount);
  for I := 0 to ColCount - 1 do
  begin
    FColumns[I] := 0;
    for J := 0 to RowCount - 1 do
    begin
      with FCache[I, J] do
      begin
        IsHidden := False;
        IsUnion := False;
        Height := 1;
        Width := 1;
        Data := nil;
        InternalCache.Cache := nil;
        InternalCache.Index := -1;
        SetCellStyle(I, J, -1);
      end;
    end;
  end;
  if IsVisible then
    ABorderWidth := 1
  else
    ABorderWidth := 0;
  for K := 0 to 3 do
    FDefaultStyle.Borders[K].Width := ABorderWidth;
  for I := 0 to RowCount - 1 do
    FRows[I] := 0;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetRowHeight(const ARow, AHeight: Integer);
begin
  TestRow(ARow);
  if AHeight < 0 then
    raise EcxExportData.Create(cxGetResString(@scxIllegalHeight));

  FRows[ARow] := AHeight;
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellDataGraphic(
  const ACol, ARow: Integer; var AGraphic: TGraphic);
var
  AGraphicText: AnsiString;
begin
  GetGraphicAsText(cxUnicodeToStr(FileName), AGraphic, AGraphicText);
  SetData(ACol, ARow, Length(AGraphicText), cxDataTypeGraphic, AGraphicText[1]);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.SetCellPNGImage(
  const ACol, ARow: Integer; APNGImage: TObject);
begin
  SetCellDataGraphic(ACol, ARow, TGraphic(APNGImage));
end;

function TcxCustomHtmlXmlTXTExportProvider.SupportGraphic: Boolean;
begin
  Result := True;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetCacheItem(ACol, ARow: Integer): TcxCacheItem;
begin
  TestIndex(ACol, ARow);

  Result := FCache[ACol, ARow];
end;

function TcxCustomHtmlXmlTXTExportProvider.GetCellHeight(ACol, ARow: Integer): Integer;
var
  I: Integer;
begin
  TestIndex(ACol, ARow);

  if FCache[ACol, ARow].IsUnion then
  begin
    Result := 0;
    for I := 0 to FCache[ACol, ARow].Height - 1 do
      Inc(Result, Rows[ARow + I]);
  end
  else
    Result := Rows[ARow];
end;

function TcxCustomHtmlXmlTXTExportProvider.GetCellWidth(ACol, ARow: Integer): Integer;
var
  I: Integer;
begin
  TestIndex(ACol, ARow);

  if FCache[ACol, ARow].IsUnion then
  begin
    Result := 0;
    for I := 0 to FCache[ACol, ARow].Width - 1 do
      Inc(Result, Columns[ACol + I]);
  end
  else
    Result := Columns[ACol];
end;

function TcxCustomHtmlXmlTXTExportProvider.GetColumns(ACol: Integer): Integer;
begin
  TestCol(ACol);

  Result := FColumns[ACol];
end;

function TcxCustomHtmlXmlTXTExportProvider.GetDefaultStyle: PcxCacheCellStyle;
begin
  Result := @FDefaultStyle;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetHeight: Integer;
begin
  Result := Length(FRows);
end;

function TcxCustomHtmlXmlTXTExportProvider.GetInternalCacheCount: Integer;
begin
  Result := FInternalCacheList.Count;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetInternalCacheItems(
  AIndex: Integer): IcxCellInternalCache;
begin
  Result := FInternalCacheList[AIndex] as IcxCellInternalCache;
end;

function TcxCustomHtmlXmlTXTExportProvider.GetRows(ARow: Integer): Integer;
begin
  TestRow(ARow);

  Result := FRows[ARow];
end;

function TcxCustomHtmlXmlTXTExportProvider.GetStyle(AStyleIndex: Integer): PcxCacheCellStyle;
begin
  TestStyleIndex(AStyleIndex);
  if AStyleIndex < 0 then
    Result := @FDefaultStyle
  else
    Result := FStyleManager.GetStyle(AStyleIndex);
end;

function TcxCustomHtmlXmlTXTExportProvider.GetWidth: Integer;
begin
  Result := Length(FColumns);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.TestIndex(ACol, ARow: Integer);
begin
  TestCol(ACol);
  TestRow(ARow);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.TestCol(ACol: Integer);
begin
  if (ACol < 0) or (ACol >= Length(FCache)) then
    raise EcxExportData.CreateFmt(cxGetResString(@scxInvalidColumnIndex), [ACol]);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.TestRow(ARow: Integer);
begin
  if (ARow < 0) or (ARow >= Length(FCache[0])) then
    raise EcxExportData.CreateFmt(cxGetResString(@scxInvalidRowIndex), [ARow]);
end;

procedure TcxCustomHtmlXmlTXTExportProvider.TestStyleIndex(AStyleIndex: Integer);
begin
  if AStyleIndex >= FStyleManager.Count then
    raise EcxExportData.CreateFmt(cxGetResString(@scxInvalidStyleIndex), [AStyleIndex]);
end;

function TcxCustomHtmlXmlTXTExportProvider.GetStyleCount: Integer;
begin
  Result := FStyleManager.Count;
end;

{ TcxCustomExportProviderSupportedCellInternalChache }

procedure TcxCustomExportProviderSupportedCellInternalChache.CommitCache(
  AStream: TStream; AParam: Pointer);
begin
  SetEmptyCellsStyle;
end;

procedure TcxCustomExportProviderSupportedCellInternalChache.CommitStyle(
  AStream: TStream; AParam: Pointer);
begin
end;

procedure TcxCustomExportProviderSupportedCellInternalChache.DeleteCacheFromCell(
  const ACol, ARow: Integer);
begin
  SetCacheIntoCell(ACol, ARow, nil);
end;

procedure TcxCustomExportProviderSupportedCellInternalChache.SetCacheIntoCell(
  const ACol, ARow: Integer; ACache: IcxCellInternalCache);
begin
  TestIndex(ACol, ARow);
  if ACache <> nil then
  begin
    if FCache[ACol, ARow].InternalCache.Cache <> nil then
      SetCacheIntoCell(ACol, ARow, nil);
    FCache[ACol, ARow].InternalCache.Cache := ACache;
    FCache[ACol, ARow].InternalCache.Index := FInternalCacheList.Add(ACache);
  end
  else
  begin
    if FCache[ACol, ARow].InternalCache.Cache <> nil then
    begin
      FCache[ACol, ARow].InternalCache.Cache := nil;
      FInternalCacheList.Delete(FCache[ACol, ARow].InternalCache.Index);
      FCache[ACol, ARow].InternalCache.Index := -1;
    end;
  end;
end;

procedure TcxCustomExportProviderSupportedCellInternalChache.SetEmptyCellsStyle;
var
  I, J: Integer;
  ACell: TcxCacheItem;
  ANewStyle: TcxCacheCellStyle;
begin
  for I := 0 to RowCount - 1 do
    for J := 0 to ColCount - 1 do
    begin
      ACell := Cache[J, I];
      if not (ACell.DataType in [0,1]) or (ACell.DataSize <> 0) or (GetCellStyle(J, I) = nil) then Continue;
      begin
        ANewStyle := GetCellStyle(J, I)^;
        ANewStyle.FontSize := 1;
        SetCellStyle(J, I, ANewStyle);
      end;
    end;
end;

{ TcxHTMLExportProvider }
procedure TcxHTMLExportProvider.Commit;
var
  AStream: TFileStream;
begin
  AStream := cxFileStreamClass.Create(cxUnicodeToStr(FileName), fmCreate);
  try
    CommitHTML(AStream);
  finally
    AStream.Free;
  end;
end;

class function TcxHTMLExportProvider.ExportType: Integer;
begin
  Result := cxExportToHTML;
end;

class function TcxHTMLExportProvider.ExportName: string;
begin
  Result := cxGetResString(@scxExportToHTML);
end;

procedure TcxHTMLExportProvider.CommitCache(AStream: TStream; AParam: Pointer);
var
  ABuffer: string;
  ADisplayValue: string;
  AStringValue: AnsiString;
  AWideStringValue: WideString;
  ADoubleValue: Double;
  AIntegerValue: Integer;
  I, J: Integer;
  ACellStyle: PcxCacheCellStyle;
begin
  inherited CommitCache(AStream, AParam);
  ABuffer := ABuffer + Format('<TABLE BORDER="0" CELLSPACING="0" WIDTH="%d">'#13#10, [GetContentWidth]);
  ABuffer := ABuffer + GetScaleRow + #13#10;
  for I := 0 to RowCount - 1 do
  begin
    ABuffer := ABuffer + '<TR>'#13#10;
    for J := 0 to ColCount - 1 do
    begin
      ACellStyle := GetCellStyle(J, I);
      ADisplayValue := '';
      with Cache[J, I] do
      begin
        if IsHidden then
          Continue;

        if IsUnion then
        begin
          ABuffer := ABuffer + '<TD';
          if Width > 1 then
            ABuffer := ABuffer + ' COLSPAN=' + IntToStr(Width);
          if Height > 1 then
            ABuffer := ABuffer + ' ROWSPAN=' + IntToStr(Height);
        end
        else
          ABuffer := ABuffer + '<TD';
      end;
//      ABuffer := ABuffer + ' NOWRAP';

      with ACellStyle^ do
      begin
        ABuffer := ABuffer + ' ALIGN=';
        case AlignText of
          catLeft:
            ABuffer := ABuffer + '"LEFT"';
          catCenter:
            ABuffer := ABuffer + '"CENTER"';
          catRight:
            ABuffer := ABuffer + '"RIGHT"';
        end;
        ABuffer := ABuffer + ' CLASS="Style' + IntToStr(FCache[J, I].StyleIndex) + '"';
        ABuffer := ABuffer + ' HEIGHT="' + IntToStr(Rows[I])+'px"';
        ABuffer := ABuffer + '>';

        if Cache[J, I].InternalCache.Cache <> nil then
        begin
          AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
          ABuffer := '';
          ADisplayValue := '';
          Cache[J, I].InternalCache.Cache.CommitCache(AStream, nil);
        end
        else
        begin
          if Cache[J, I].DataType = cxDataTypeGraphic then
          begin
            SetLength(AStringValue, Cache[J, I].DataSize);
            GetCellData(J, I, AStringValue[1]);
            ADisplayValue := GraphicNeeded(dxStringToAnsiString(ExtractFilePath(FileName)), AStringValue);
          end
          else
          if Cache[J, I].DataType = cxDataTypeString then
          begin
            if Cache[J, I].DataSize > 0 then
            begin
              SetLength(AStringValue, Cache[J, I].DataSize);
              if GetCellData(J, I, AStringValue[1]) then
                ADisplayValue := ConvertCRLFSymbols(ConvertSpecialCharacters(dxAnsiStringToString(AStringValue)))
            end
          end
          else if Cache[J, I].DataType = cxDataTypeWideString then
          begin
            if Cache[J, I].DataSize > 0 then
            begin
              SetLength(AWideStringValue, Cache[J, I].DataSize div SizeOf(Char));
              if GetCellData(J, I, AWideStringValue[1]) then
                ADisplayValue := ConvertCRLFSymbols(ConvertSpecialCharacters(AWideStringValue))
            end
          end
          else if Cache[J, I].DataType = cxDataTypeDouble then
          begin
            if GetCellData(J, I, ADoubleValue) then
              ADisplayValue := FloatToStr(ADoubleValue)
          end
          else if Cache[J, I].DataType = cxDataTypeInteger then
          begin
            if GetCellData(J, I, AIntegerValue) then
              ADisplayValue := IntToStr(AIntegerValue)
          end
        end;
      end;
     if ADisplayValue = '' then
        ADisplayValue := cxExportDefaultEmptyString;
      ABuffer := ABuffer + ADisplayValue + '</TD>'#13#10;
      AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
      ABuffer := '';
    end;
    ABuffer := ABuffer + '</TR>'#13#10;

    AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
    ABuffer := '';
  end;
  ABuffer := ABuffer + '</TABLE>'#13#10;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
end;

procedure TcxHTMLExportProvider.CommitStyle(AStream: TStream; AParam: Pointer);
var
  ABuffer: string;
  I: Integer;
begin
  SetEmptyCellsStyle;
  for I := 0 to FStyleManager.Count - 1 do
  begin
    ABuffer := ABuffer + '.Style' + IntToStr(I) + ' {' +
    GetStyle(FStyleManager[I]) + '}' + #13#10#13#10 ;
  end;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
end;

function TcxHTMLExportProvider.GetContentWidth: Integer;
var
  J: Integer;
begin
  Result := 0;
  for J := 0 to ColCount - 1 do
    Inc(Result, Columns[J]);
end;

procedure TcxHTMLExportProvider.CommitHTML(AStream: TStream);
var
  ABuffer: string;
begin
  dxWriteStandardEncodingSignature(AStream);
  ABuffer := '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
  ABuffer := ABuffer + #13#10 + '<HTML>'#13#10 +
  '<HEAD>'#13#10 + '<TITLE>' + cxExtractFileNameExW(cxChangeFileExtExW(FileName, '')) + '</TITLE>'#13#10 +
  '<META http-equiv="content-type" content="text/html"' + CharsetTag + '>' + #13#10 +
  '<STYLE TYPE="text/css"><!--'#13#10;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
  ABuffer := '';

  CommitStyle(AStream, nil);

  ABuffer := ABuffer + '--></STYLE>'#13#10 +
  '</HEAD>'#13#10 + '<BODY>'#13#10;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
  ABuffer := '';

  CommitCache(AStream, nil);

  ABuffer := ABuffer + '</BODY>'#13#10 + '</HTML>';
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
end;

function TcxHTMLExportProvider.GetStyle(AStyle: TcxCacheCellStyle): string;
var
  ABorderWidth: array[0..3] of Integer;
  ABorderColor: array[0..3] of Integer;
  I: Integer;
begin
  Result := '';
  with AStyle do
  begin
    for I := 0 to 3 do
    begin
      if Borders[I].IsDefault then
      begin
        ABorderWidth[I] := 0;
        ABorderColor[I] := 0;
      end
      else
      begin
        ABorderWidth[I] := Borders[I].Width;
        ABorderColor[I] := Borders[I].Color;
      end;
    end;
    Result := Result + ' border-style: solid;';
    if FontSize = 1 then
      Result := Result + 'padding:0px;'
    else
      Result := Result + ' padding:3;';
    Result := Result + ' border-left-width: ' + IntToStr(ABorderWidth[0]) + ';';
    Result := Result + ' border-top-width: ' + IntToStr(ABorderWidth[1]) + ';';
    Result := Result + ' border-right-width: ' + IntToStr(ABorderWidth[2]) + ';';
    Result := Result + ' border-bottom-width: ' + IntToStr(ABorderWidth[3]) + ';';
    Result := Result + ' border-left-color: ' + GetHTMLColor(ABorderColor[0]) + ';';
    Result := Result + ' border-top-color: ' + GetHTMLColor(ABorderColor[1]) + ';';
    Result := Result + ' border-right-color: ' + GetHTMLColor(ABorderColor[2]) + ';';
    Result := Result + ' border-bottom-color: ' + GetHTMLColor(ABorderColor[3]) + ';';
    Result := Result + ' font-family: ''' + PChar(@FontName) + ''';';
    Result := Result + ' mso-font-charset: ' + IntToStr(FontCharset) + ';';
    if cfsBold in FontStyle then
      Result := Result + ' font-weight: bold;';
    if cfsItalic in FontStyle then
      Result := Result + ' font-style: italic;';
    if cfsUnderline in FontStyle then
      Result := Result + ' text-decoration: underline;'
    else if cfsStrikeOut in FontStyle then
      Result := Result + ' text-decoration: line-through;';
    Result := Result + ' font-size: ' + IntToStr(FontSize) + 'pt;';
    Result := Result + ' color: ' + GetHTMLColor(FontColor) + ';';
    Result := Result + ' background-color: ' + GetHTMLColor(BrushBkColor);
  end;
end;

function TcxHTMLExportProvider.GetScaleRow: string;
var
  J: Integer;
begin
  Result := '<TR>'#13#10;
  for J := 0 to ColCount - 1 do
  begin
    Result := Result + '<TD';
    Result := Result + ' WIDTH="' + IntToStr(Columns[J]) + '"';
    Result := Result + ' HEIGHT="0">';
    Result := Result + '</TD>'#13#10;
  end;
  Result := Result + '</TR>';
end;

{ TcxXMLExportProvider }

constructor TcxXMLExportProvider.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FHideDotsOn := True;
  FXSLFileName := '_';
end;

procedure TcxXMLExportProvider.Commit;
var
  AXMLStream: TFileStream;
  AXSLStream: TFileStream;
begin
  AXMLStream := cxFileStreamClass.Create(cxUnicodeToStr(FileName), fmCreate);
  FXSLFileName := cxChangeFileExtExW(FileName, '.xsl');
  AXSlStream := cxFileStreamClass.Create(cxUnicodeToStr(FXSLFileName), fmCreate);
  try
    CommitXML(AXMLStream);
    CommitXSL(AXSLStream);
  finally
    AXSlStream.Free;
    AXMLStream.Free;
  end;
end;

class function TcxXMLExportProvider.ExportType: Integer;
begin
  Result := cxExportToXML;
end;

class function TcxXMLExportProvider.ExportName: string;
begin
  Result := cxGetResString(@scxExportToXML);
end;

procedure TcxXMLExportProvider.CommitCache(AStream: TStream; AParam: Pointer);
var
  ABuffer: string;
  I, J: Integer;
  AValue: AnsiString;
begin
  inherited CommitCache(AStream, AParam);
  if FHideDotsOn then
  begin
    HideDots;
    FHideDotsOn := False;
    Exit;
  end;

  ABuffer := '<LINES ColCount="' + IntToStr(ColCount) +
      '" RowCount="' + IntToStr(RowCount) + '">'#13#10;

  ABuffer := ABuffer + GetScaleLine;
  for I := 0 to RowCount - 1 do
  begin
    AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
    ABuffer :=  '<LINE>'#13#10;
    for J := 0 to ColCount - 1 do
    begin
      if Cache[J, I].IsHidden then
        Continue;

      ABuffer := ABuffer + '<CELL' + GetCellParams(J, I);
      ABuffer := ABuffer + '>';

      with Cache[J, I] do
      begin
        if DataType = cxDataTypeGraphic then
        begin
          SetLength(AValue, DataSize);
          GetCellData(J, I, AValue[1]);
          AValue := dxStringToAnsiString(GraphicNeeded(
            dxStringToAnsiString(ExtractFilePath(FileName)), AValue, False));
          ABuffer := ABuffer + '<IMAGE Src="' + dxAnsiStringToString(AValue) + '"></IMAGE>';
        end;
      end;

      if Cache[J, I].InternalCache.Cache <> nil then
      begin
        AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
        ABuffer := '';
        Cache[J, I].InternalCache.Cache.CommitCache(AStream, nil);
      end
      else
        ABuffer := ABuffer + {'<![CDATA[' + }ConvertTextToXml({ConvertCRLFSymbols(}GetData(J, I){)}, J, I){ + ']]>'};
      ABuffer := ABuffer + '</CELL>'#13#10;
    end;
    ABuffer := ABuffer + '</LINE>';
  end;

  ABuffer := ABuffer + '</LINES>';
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
end;

procedure TcxXMLExportProvider.CommitStyle(AStream: TStream; AParam: Pointer);
var
  I: Integer;
  ABuffer: string;
begin
  SetEmptyCellsStyle;
  ABuffer := '<STYLES>'#13#10;

  for I := 0 to FStyleManager.Count - 1 do
  begin
    AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
    ABuffer := '<STYLE Id="' + IntToStr(I) + '" ' +
        GetStyle(FStyleManager[I]) + '>'#13#10 + GetBorderStyle(FStyleManager[I]);
    ABuffer := ABuffer + '</STYLE>'#13#10
  end;

  ABuffer := ABuffer + '</STYLES>'#13#10;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer))
end;

procedure TcxXMLExportProvider.CommitXML(AStream: TStream);
var
  ABuffer: string;
  AFileExt: string;
  AFileName: string;
begin
  AFileName := FileName;
  AFileExt := ExtractFileExt(AFileName);
  if AFileExt <> '' then
    Delete(AFileName, Length(AFileName) - Length(AFileExt) + 1, Length(AFileExt));
  dxWriteStandardEncodingSignature(AStream);
  ABuffer := '<?xml version="1.0"' + EncodingTag + '?>'#13#10;
  ABuffer := ABuffer + '<?xml-stylesheet type="text/xsl" href="' +
    CheckedUnicodeStringW(cxExtractFileNameExW(FXSLFileName)) + '"?>'#13#10;
  ABuffer := ABuffer + '<CACHE>'#13#10;
  ABuffer := ABuffer + '<TITLE>' +
    CheckedUnicodeStringW(cxExtractFileNameExW(cxChangeFileExtExW(FXSLFileName, ''))) + '</TITLE>'#13#10;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));

  CommitCache(nil, nil);
  CommitStyle(AStream, nil);
  CommitCache(AStream, nil);

  ABuffer := '</CACHE>';
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
end;

procedure TcxXMLExportProvider.CommitXSL(AStream: TStream);
var
  ABuffer: string;
begin
  dxWriteStandardEncodingSignature(AStream);
  ABuffer := '<?xml version="1.0"' + EncodingTag + '?>'#13#10;
  ABuffer := ABuffer + '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">'#13#10;
  ABuffer := ABuffer + '<xsl:template match="/">'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="CACHE" />'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="CACHE">'#13#10;
  ABuffer := ABuffer + '<html>'#13#10;
  ABuffer := ABuffer + '<head>'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="TITLE" />'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="STYLES" />'#13#10;
  ABuffer := ABuffer + '</head>'#13#10;
  ABuffer := ABuffer + '<body>'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="LINES" />'#13#10;
  ABuffer := ABuffer + '</body>'#13#10;
  ABuffer := ABuffer + '</html>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="TITLE">'#13#10;
  ABuffer := ABuffer + '<title>'#13#10;
  ABuffer := ABuffer + '<xsl:value-of select="." />'#13#10;
  ABuffer := ABuffer + '</title>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="STYLES">'#13#10;
  ABuffer := ABuffer + '<style type="text/css">'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="STYLE" />'#13#10;
  ABuffer := ABuffer + '</style>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="STYLE">'#13#10;
  ABuffer := ABuffer + '.Style<xsl:value-of select="@Id" />'#13#10;
  ABuffer := ABuffer + '{ border-style: solid;'#13#10;
  ABuffer := ABuffer + '  padding: <xsl:value-of select="@CellPadding" />;'#13#10;
  ABuffer := ABuffer + '  font-family: <xsl:value-of select="@FontName" />;'#13#10;
  ABuffer := ABuffer + '  mso-font-charset: <xsl:value-of select="@FontCharset" />;'#13#10;
  ABuffer := ABuffer + '  font-size: <xsl:value-of select="@FontSize" />pt;'#13#10;
  ABuffer := ABuffer + '  color: <xsl:value-of select="@FontColor" />;'#13#10;
  ABuffer := ABuffer + '  background-color: <xsl:value-of select="@BrushBkColor" />;'#13#10;
  ABuffer := ABuffer + '<xsl:if test="@Bold=''True''">'#13#10;
  ABuffer := ABuffer + '  font-weight: bold;'#13#10;
  ABuffer := ABuffer + '</xsl:if>'#13#10;
  ABuffer := ABuffer + '<xsl:if test="@Italic=''True''">'#13#10;
  ABuffer := ABuffer + '  font-style: italic;'#13#10;
  ABuffer := ABuffer + '</xsl:if>'#13#10;
  ABuffer := ABuffer + '<xsl:if test="@Underline=''True''">'#13#10;
  ABuffer := ABuffer + '  text-decoration: underline;'#13#10;
  ABuffer := ABuffer + '</xsl:if>'#13#10;
  ABuffer := ABuffer + '<xsl:if test="@StrikeOut=''True''">'#13#10;
  ABuffer := ABuffer + '  text-decoration: line-through;'#13#10;
  ABuffer := ABuffer + '</xsl:if>'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="BORDER_LEFT" />'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="BORDER_UP" />'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="BORDER_RIGHT" />'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="BORDER_DOWN" />'#13#10;
  ABuffer := ABuffer + '}'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="BORDER_LEFT">'#13#10;
  ABuffer := ABuffer + 'border-left-width: <xsl:value-of select="@Width" />px;'#13#10;
  ABuffer := ABuffer + 'border-left-color: <xsl:value-of select="@Color" />;'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="BORDER_UP">'#13#10;
  ABuffer := ABuffer + 'border-top-width: <xsl:value-of select="@Width" />px;'#13#10;
  ABuffer := ABuffer + 'border-top-color: <xsl:value-of select="@Color" />;'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="BORDER_RIGHT">'#13#10;
  ABuffer := ABuffer + 'border-right-width: <xsl:value-of select="@Width" />px;'#13#10;
  ABuffer := ABuffer + 'border-right-color: <xsl:value-of select="@Color" />;'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="BORDER_DOWN">'#13#10;
  ABuffer := ABuffer + 'border-bottom-width: <xsl:value-of select="@Width" />px;'#13#10;
  ABuffer := ABuffer + 'border-bottom-color: <xsl:value-of select="@Color" />;'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="LINES">'#13#10;
  ABuffer := ABuffer + '<table border="0" cellspacing="0">'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="LINE" />'#13#10;
  ABuffer := ABuffer + '</table>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="LINE">'#13#10;
  ABuffer := ABuffer + '<tr>'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="CELL" />'#13#10;
  ABuffer := ABuffer + '</tr>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="CELL">'#13#10;
  ABuffer := ABuffer + '<td>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="nowrap"></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="width"><xsl:value-of select="@Width" /></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="height"><xsl:value-of select="@Height" /></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="align"><xsl:value-of select="@Align" /></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="colspan"><xsl:value-of select="@ColSpan" /></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="rowspan"><xsl:value-of select="@RowSpan" /></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="class">Style<xsl:value-of select="@StyleClass" /></xsl:attribute>'#13#10;

  ABuffer := ABuffer + '<xsl:choose>'#13#10;
  ABuffer := ABuffer + '<xsl:when test="LINES">'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="LINES" />'#13#10;
  ABuffer := ABuffer + '</xsl:when>'#13#10;

  ABuffer := ABuffer + '<xsl:when test="IMAGE">'#13#10;
  ABuffer := ABuffer + '<xsl:apply-templates select="IMAGE" />'#13#10;
  ABuffer := ABuffer + '</xsl:when>'#13#10;

  ABuffer := ABuffer + '<xsl:otherwise>'#13#10;
  ABuffer := ABuffer + '<xsl:value-of select="." />'#13#10;
  ABuffer := ABuffer + '</xsl:otherwise>'#13#10;
  ABuffer := ABuffer + '</xsl:choose>'#13#10;
  ABuffer := ABuffer + '</td>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '<xsl:template match="IMAGE">'#13#10;
  ABuffer := ABuffer + '<img>'#13#10;
  ABuffer := ABuffer + '<xsl:attribute name="src"><xsl:value-of select="@Src" /></xsl:attribute>'#13#10;
  ABuffer := ABuffer + '</img>'#13#10;
  ABuffer := ABuffer + '</xsl:template>'#13#10#13#10;

  ABuffer := ABuffer + '</xsl:stylesheet>'#13#10;
  AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
end;

function TcxXMLExportProvider.ConvertTextToXML(const AText: string; ACol, ARow: Integer): string;
var
  I: Integer;
  W: WideString;
begin
  Result := '';
  if not cxStrUnicodeNeeded(AText, True) then
    Result := AText
  else
  begin
    W := cxStrToUnicode(AText, GetCellStyle(ACol, ARow)^.FontCharset);
    for I := 1 to Length(W) do
      Result := Result + '&#' + IntToStr(Integer(W[I])) + ';';
  end;
end;

function TcxXMLExportProvider.GetBorderStyle(AStyle: TcxCacheCellStyle): string;

  function GetBorderStyle(AIndex: Integer): string;
  begin
    with AStyle.Borders[AIndex] do
    begin
      Result := '';
      if IsDefault then
        Result := Result + ' IsDefault="True"'
      else
        Result := Result + ' IsDefault="False"';
      Result := Result + ' Width="' + IntToStr(Width) + '"';
      Result := Result + ' Color="' + GetHTMLColor(Color) + '"';
    end;
  end;

begin
  Result := '<BORDER_LEFT' + GetBorderStyle(0) + '/>'#13#10;
  Result := Result + '<BORDER_UP' + GetBorderStyle(1) + '/>'#13#10;
  Result := Result + '<BORDER_RIGHT' + GetBorderStyle(2) + '/>'#13#10;
  Result := Result + '<BORDER_DOWN' + GetBorderStyle(3) + '/>'#13#10;
end;

function TcxXMLExportProvider.GetCellParams(ACol, ARow: Integer): string;
var
  ACellWidth: Integer;
  ACellStyle: PcxCacheCellStyle;
begin
  Result := '';

  with Cache[ACol, ARow] do
  begin
    ACellWidth := CellWidth[ACol, ARow];
    if ACellWidth > 0 then
      Result := Result + ' Width="' + IntToStr(ACellWidth) + '"';
    ACellStyle := GetCellStyle(ACol, ARow);
    Result := Result + ' Align="';
    case ACellStyle^.AlignText of
      catLeft:
        Result := Result + 'left"';
      catCenter:
        Result := Result + 'center"';
      catRight:
        Result := Result + 'right"';
    end;
    if IsUnion then
    begin
      if Width > 1 then
        Result := Result + ' ColSpan="' + IntToStr(Width) + '"';
      if Height > 1 then
        Result := Result + ' RowSpan="' + IntToStr(Height) + '"';
    end;
    Result := Result + ' StyleClass="' + IntToStr(StyleIndex) + '"';
  end;
end;

function TcxXMLExportProvider.GetData(ACol, ARow: Integer): string;
var
  AAnsiStringValue: AnsiString;
  AWideStringValue: WideString;
  ADoubleValue: Double;
  AIntegerValue: Integer;
begin
  if Cache[ACol, ARow].InternalCache.Cache <> nil then
    Result := ''
  else
  begin
    if Cache[ACol, ARow].DataType = cxDataTypeGraphic then
    begin
      Result := cxXMLEmptyChar;
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeAnsiString then
    begin
      if Cache[ACol, ARow].DataSize > 0 then
      begin
        SetLength(AAnsiStringValue, Cache[ACol, ARow].DataSize);
        if GetCellData(ACol, ARow, AAnsiStringValue[1]) then
          Result := dxAnsiStringToString(AAnsiStringValue)
        else
          Result := cxXMLEmptyChar;
      end
      else
        Result := cxXMLEmptyChar;
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeWideString then
    begin
      if Cache[ACol, ARow].DataSize > 0 then
      begin
        SetLength(AWideStringValue, Cache[ACol, ARow].DataSize div SizeOf(Char));
        if GetCellData(ACol, ARow, AWideStringValue[1]) then
          Result := AWideStringValue
        else
          Result := cxXMLEmptyChar;
      end
      else
        Result := cxXMLEmptyChar;
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeDouble then
    begin
      if GetCellData(ACol, ARow, ADoubleValue) then
        Result := FloatToStr(ADoubleValue)
      else
        Result := cxXMLEmptyChar;
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeInteger then
    begin
      if GetCellData(ACol, ARow, AIntegerValue) then
        Result := IntToStr(AIntegerValue)
      else
        Result := cxXMLEmptyChar;
    end
    else
      Result := cxXMLEmptyChar;
  end;
end;

function TcxXMLExportProvider.GetStyle(AStyle: TcxCacheCellStyle): string;
  function GetAlignText(AAlign: TcxAlignText): string;
  begin
    case AAlign of
      catLeft:
        Result := 'Left';
      catCenter:
        Result := 'Center';
      catRight:
        Result := 'Right';
    end;
  end;

  function GetFontStyles(AStyles: TcxFontStyles): string;
  begin
    Result := '';

    if cfsBold in AStyles then
      Result := Result + ' Bold="True"'
    else
      Result := Result + ' Bold="False"';

    if cfsItalic in AStyles then
      Result := Result + ' Italic="True"'
    else
      Result := Result + ' Italic="False"';

    if cfsUnderline in AStyles then
      Result := Result + ' Underline="True"'
    else
      Result := Result + ' Underline="False"';

    if cfsStrikeOut in AStyles then
      Result := Result + ' StrikeOut="True"'
    else
      Result := Result + ' StrikeOut="False"';
  end;

  function GetBrushStyle(AStyle: TcxBrushStyle): string;
  begin
    case AStyle of
      cbsSolid:
        Result := 'Solid';
      cbsClear:
        Result := 'Clear';
    end;
  end;

begin
  with AStyle do
  begin
    Result := 'AlignText="' + GetAlignText(AlignText) + '"';
    if FontSize = 1 then
      Result := Result + ' CellPadding="0px"'
    else
      Result := Result + ' CellPadding=" 3"';
    Result := Result + ' FontName="' + CheckedUnicodeString(PChar(@FontName), AStyle.FontCharset) + '"';
    Result := Result + ' FontCharset="' + IntToStr(FontCharset) + '"';
    Result := Result + GetFontStyles(FontStyle);
    Result := Result + ' FontColor="' + GetHTMLColor(FontColor) + '"';
    Result := Result + ' FontSize="' + IntToStr(FontSize) + '"';
    Result := Result + ' BrushStyle="' + GetBrushStyle(BrushStyle) + '"';
    Result := Result + ' BrushBkColor="' + GetHTMLColor(BrushBkColor) + '"';
    Result := Result + ' BrushFgColor="' + GetHTMLColor(BrushFgColor) + '"';
  end;
end;

procedure TcxXMLExportProvider.HideDots;
var
  I, J: Integer;
  AData: string;
  AStyle: TcxCacheCellStyle;
begin
  for J := 0 to RowCount - 1 do
  begin
    for I := 0 to ColCount - 1 do
    begin
      if Cache[I, J].InternalCache.Cache <> nil then
        Cache[I, J].InternalCache.Cache.CommitCache(nil, nil)
      else
      begin
        AData := GetData(I, J);
        if AData = cxXMLEmptyChar then
        begin
          AStyle := GetCellStyle(I, J)^;
          AStyle.FontColor := AStyle.BrushBkColor;
          SetCellStyle(I, J, AStyle);
        end;
      end;
    end;
  end;
end;

function TcxXMLExportProvider.GetScaleLine: string;
var
  J: Integer;
begin
  Result :=  '<LINE>'#13#10;
  for J := 0 to ColCount - 1 do
  begin
    Result := Result + '<CELL Width="' + IntToStr(Columns[J]) + '"';
    Result := Result + ' Height="0"';
    Result := Result + '>'#13#10;
    Result := Result + '</CELL>'#13#10;
  end;
  Result := Result + '</LINE>'#13#10;
end;

{ TcxTXTExportProvider }

constructor TcxTXTExportProvider.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FSeparator := '';
  FBeginString := '';
  FEndString := '';
  FIndex := 0;
end;

procedure TcxTXTExportProvider.CommitCache(AStream: TStream; AParam: Pointer);
var
  I, J, K: Integer;
  ABuffer: string;
  ASpace: string;
  AData: string;
begin
  dxWriteStandardEncodingSignature(AStream);
  SetLength(FColMaxWidth, ColCount);

  CalculateColMaxWidth;
  for J := 0 to RowCount - 1 do
  begin
    ABuffer := '';
    for I := 0 to ColCount - 1 do
    begin
      AData := GetData(I, J);
      ASpace := '  ';
      for K := 1 to FColMaxWidth[I] - Length(AData) do
        ASpace := ASpace + ' ';
      if FSeparator <> '' then
        ASpace := '';
      if I < (ColCount - 1) then
        ABuffer := ABuffer + FBeginString + AData + FEndString + FSeparator + ASpace
      else
        ABuffer := ABuffer + FBeginString + AData + FEndString + ASpace;
    end;
    ABuffer := ABuffer + #13#10;
    AStream.WriteBuffer(ABuffer[1], dxStringSize(ABuffer));
  end;

  SetLength(FColMaxWidth, 0);
end;

function TcxTXTExportProvider.SupportGraphic: Boolean;
begin
  Result := False;
end;

procedure TcxTXTExportProvider.AddSeparator(const ASeparator: string);
begin
  case FIndex of
    0:
      FSeparator := ASeparator;
    1:
      FBeginString := ASeparator;
    2:
      FEndString := ASeparator;
  end;
  Inc(FIndex);
end;

class function TcxTXTExportProvider.ExportType: Integer;
begin
  Result := cxExportToText;
end;

class function TcxTXTExportProvider.ExportName: string;
begin
  Result := cxGetResString(@scxExportToText);
end;

procedure TcxTXTExportProvider.Commit;
var
  AStream: TFileStream;
begin
  AStream := cxFileStreamClass.Create(cxUnicodeToStr(FileName), fmCreate);
  try
    CommitCache(AStream, Pointer(0));
  finally
    AStream.Free;
  end;
end;

procedure TcxTXTExportProvider.CalculateColMaxWidth;
var
  I, J, K: Integer;
  AMaxWidth: Integer;
  ACurrentWidth: Integer;
begin
  for I := 0 to ColCount - 1 do
  begin
    AMaxWidth := 0;
    for J := 0 to RowCount - 1 do
      if Cache[I, J].IsUnion then
      begin
        ACurrentWidth := Length(GetData(I, J)) div Cache[I, J].Width;
        for K := 1 to Cache[I, J].Width - 1 do
          FColMaxWidth[I + K] := Max(FColMaxWidth[I + K], ACurrentWidth);
        AMaxWidth := Max(AMaxWidth, ACurrentWidth);
      end
      else
        AMaxWidth := Max(AMaxWidth, Length(GetData(I, J)));

    FColMaxWidth[I] := AMaxWidth;
  end;
end;

function TcxTXTExportProvider.GetData(ACol, ARow: Integer): string;
var
  AAnsiStringValue: AnsiString;
  AWideStringValue: WideString;
  ADoubleValue: Double;
  AIntegerValue: Integer;
begin
  if Cache[ACol, ARow].InternalCache.Cache <> nil then
    Result := ''
  else
  begin
    if Cache[ACol, ARow].DataType = cxDataTypeAnsiString then
    begin
      if Cache[ACol, ARow].DataSize > 0 then
      begin
        SetLength(AAnsiStringValue, Cache[ACol, ARow].DataSize);
        if GetCellData(ACol, ARow, AAnsiStringValue[1]) then
          Result := dxAnsiStringToString(AAnsiStringValue)
        else
          Result := '';
      end
      else
        Result := '';
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeWideString then
    begin
      if Cache[ACol, ARow].DataSize > 0 then
      begin
        SetLength(AWideStringValue, Cache[ACol, ARow].DataSize div SizeOf(Char));
        if GetCellData(ACol, ARow, AWideStringValue[1]) then
          Result := AWideStringValue
        else
          Result := '';
      end
      else
        Result := '';
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeDouble then
    begin
      if GetCellData(ACol, ARow, ADoubleValue) then
        Result := FloatToStr(ADoubleValue)
      else
        Result := '';
    end
    else if Cache[ACol, ARow].DataType = cxDataTypeInteger then
    begin
      if GetCellData(ACol, ARow, AIntegerValue) then
        Result := IntToStr(AIntegerValue)
      else
        Result := '';
    end
    else
      Result := '';
  end;
end;

initialization
  TcxExport.RegisterProviderClass(TcxHTMLExportProvider);
  TcxExport.RegisterProviderClass(TcxTXTExportProvider);
  TcxExport.RegisterProviderClass(TcxXMLExportProvider);

end.
