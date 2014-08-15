{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
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

unit cxSSStyles;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,  Windows, Graphics, 
  dxCore, cxGraphics, cxClasses, cxControls, cxExcelConst, cxSSTypes,
  cxSSPainterWrapper, cxSSIntf, cxSSRes;

type
  TcxSSStyleCacheClass = class of TcxSSStyleCache;

  EStyleError = class(EdxException);

  TcxSSStyleInfoType = (siAlign, siMerge, siReadOnly, siTextColor,
    siBrush, siBorder, siFont, siFormat, siAll);

  TcxSSCellStyle = class;
  TcxSSDefaultStyle = class;

  TChangeStyleEvent = procedure (Sender: TObject; AStyleType: TcxSSStyleInfoType) of object;

  { TcxSSStyleCache }
  TcxSSStyleCache = class
  private
    FDefCellStyle: TcxSSDefaultStyle;
    FFontList: TList;
    FIsChangeBorders: Boolean;
    FOwner: TObject;
    FStyles: TList;
    FLockCount: Integer;
    function GetListener: TObject;
    function GetLock: Boolean;
    function GetPalette: PcxExcelPalette;
    function GetStyleFromList(AIndex: Integer): PcxSSCellStyleRec;
    procedure SetLock(const Value: Boolean);
  protected
    function AddCellStyleRec(const ACellStyle: TcxSSCellStyleRec): PcxSSCellStyleRec;
    procedure DoOnChange(Sender: TObject; AStyleType: TcxSSStyleInfoType); virtual;
    function GetCellStyleRecFromCellStyle(ACellStyle: TcxSSCellStyle): TcxSSCellStyleRec;
    function IndexOf(const ACellStyle: TcxSSCellStyleRec): Integer;
    property Listener: TObject read GetListener;
    property Palette: PcxExcelPalette read GetPalette;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;
    function AddFont(const AName: string; AStyle: TFontStyles;
      ACharSet: TFontCharset; ASize: SmallInt; AColor: Byte): PcxSSFontRec; virtual;
    function AddFontClone(AFont: PcxSSFontRec): PcxSSFontRec; virtual;
    procedure Clear;
    function Clone(AStyle: PcxSSCellStyleRec): PcxSSCellStyleRec; virtual;
    function GetCellStyle(ADataStorage: TObject; ACol, ARow: Integer): TcxSSCellStyle;
    procedure ReleaseRefCount(const AIndex: Integer);
    property Styles[AIndex: Integer]: PcxSSCellStyleRec read GetStyleFromList; default;
    property DefaultStyle: TcxSSDefaultStyle read FDefCellStyle;
    property Owner: TObject read FOwner;
    property StyleList: TList read FStyles;
    property Fonts: TList read FFontList;
    property Lock: Boolean read GetLock write SetLock;
  end;

  { TcxSSStyle }
  TcxSSStyle = class(TPersistent)
  private
    FInfoType: TcxSSStyleInfoType;
    FLockUpdate: Integer;
    FOnChange: TNotifyEvent;
    FOwner: TcxSSCellStyle;
    function  GetUpdate: Boolean;
    procedure SetUpdate(const Value: Boolean);
  protected
    procedure DoOnChange(Sender: TObject); virtual;
    function GetOwner: TPersistent; override;
    function ValidateColor(AColor: Word; ADefault: Word): Word;
    property InfoType: TcxSSStyleInfoType read FInfoType write FInfoType;
    property LockUpdate: Boolean read GetUpdate write SetUpdate;
    property Owner: TcxSSCellStyle read FOwner write FOwner;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    procedure AfterConstruction; override;
  end;

  { TcxSSFont }
  TcxSSFont = class(TcxSSStyle)
  private
    function GetCharset: TFontCharset;
    function GetColor: TcxSSColor;
    function GetName: TFontName;
    function GetSize: Integer;
    function GetStyle: TFontStyles;
    procedure SetCharset(const Value: TFontCharset);
    procedure SetColor(const Value: TcxSSColor);
    procedure SetName(const Value: TFontName);
    procedure SetSize(const Value: Integer);
    procedure SetStyle(const Value: TFontStyles);
  public
    procedure AfterConstruction; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignInfo(const AName: string; ASize: Integer; AStyle: TFontStyles;
      ACharset: TFontCharset; AFontColor: Word); virtual;
    procedure AssignTo(Dest: TPersistent); override;
  published
    property Name: TFontName read GetName write SetName;
    property Size: Integer read GetSize write SetSize default 8;
    property Style: TFontStyles read GetStyle write SetStyle default [];
    property Charset: TFontCharset read GetCharset write SetCharset default DEFAULT_CHARSET;
    property FontColor: TcxSSColor read GetColor write SetColor default clBlack;
  end;

  { TcxSSBrush }
  TcxSSBrush = class(TcxSSStyle)
  private
    function GetBkColor: TcxSSColor;
    function GetFgColor: TcxSSColor;
    function GetStyle: TcxSSFillStyle;
    procedure SetBkColor(const Value: TcxSSColor);
    procedure SetFgColor(const Value: TcxSSColor);
    procedure SetStyle(const Value: TcxSSFillStyle);
  public
    procedure AfterConstruction; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignInfo(AStyle: TcxSSFillStyle; const ABackgroundColor,
      AForegroundColor: Word); virtual;
  published
    property Style: TcxSSFillStyle read GetStyle write SetStyle default fsSolid;
    property BackgroundColor: TcxSSColor read GetBkColor write SetBkColor default 56;
    property ForegroundColor: TcxSSColor read GetFgColor write SetFgColor default 56;
  end;

  { TcxSSEdgeStyle }
  TcxSSEdgeStyle = class(TcxSSStyle)
  private
    FKind: TcxSSEdgeBorder;
    function GetColor: TcxSSColor;
    function GetStyle: TcxSSEdgeLineStyle;
    procedure SetColor(const Value: TcxSSColor);
    procedure SetStyle(const Value: TcxSSEdgeLineStyle);
  protected
    function GetOwner: TPersistent; override;
  public
    procedure AfterConstruction; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignRec(AData: TcxSSEdgeStyleRec); virtual;
    procedure AssignInfo(AStyle: TcxSSEdgeLineStyle; AColor: Word); virtual;
    property Kind: TcxSSEdgeBorder read FKind;
  published
    property Color: TcxSSColor read GetColor write SetColor default cxSSDefaultColorValue;
    property Style: TcxSSEdgeLineStyle read GetStyle write SetStyle default lsDefault;
  end;

  { TcxSSBorderStyle }
  TcxSSBorderStyle = class(TcxSSStyle)
  private
    FEdges: array[TcxSSEdgeBorder] of TcxSSEdgeStyle;
    function GetEdgeStyle(Index: TcxSSEdgeBorder): TcxSSEdgeStyle;
    function GetEdgeStyleByIndex(Index: Integer): TcxSSEdgeStyle;
    procedure SetEdgeStyleByIndex(Index: Integer; Value: TcxSSEdgeStyle);
  protected
    function GetOwner: TPersistent; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure BeforeDestruction; override;
    property Edges[Index: TcxSSEdgeBorder]: TcxSSEdgeStyle read GetEdgeStyle; default;
  published
    property Left: TcxSSEdgeStyle index 0 read GetEdgeStyleByIndex write SetEdgeStyleByIndex;
    property Top: TcxSSEdgeStyle index 1 read GetEdgeStyleByIndex write SetEdgeStyleByIndex;
    property Right: TcxSSEdgeStyle index 2 read GetEdgeStyleByIndex write SetEdgeStyleByIndex;
    property Bottom: TcxSSEdgeStyle index 3 read GetEdgeStyleByIndex write SetEdgeStyleByIndex;
  end;

  { TcxSSCellStyle }
  TcxSSCellStyle = class(TcxInterfacedPersistent, IcxSpreadSheetCellStyle)
  private
    FBorderStyle: TcxSSBorderStyle;
    FBrush: TcxSSBrush;
    FCol: Integer;
    FFont: TcxSSFont;
    FLockCount: Integer;
    FParent: TcxSSStyleCache;
    FOnChangeStyle: TChangeStyleEvent;
    FOwner: TObject;
    FRow: Integer;
    FStylePtr: PcxSSCellStyleRec;
    function GetBorderStyle: TcxSSBorderStyle;
    function GetBrush: TcxSSBrush;
    function GetFont: TcxSSFont;
    function GetFormat: TxlsDataFormat;
    function GetIsMain: Boolean;
    function GetLockUpdate: Boolean;
    function GetLocked: Boolean;
    function GetMerge: Boolean;
    function GetReadOnly: Boolean;
    function GetStyleInfoPtr: PcxSSCellStyleRec;
    function GetTextHAlign: TcxHorzTextAlign;
    function GetTextVAlign: TcxVertTextAlign;
    function GetWordBreak: Boolean;
    procedure SetBorderStyle(const ASide: TcxSSEdgeBorder;
        AStyle: TcxSSEdgeLineStyle; AColor: Byte);
    procedure SetCellStyle(const AStyle: PcxSSCellStyleRec;
      ASetDefaultBorders: Boolean = False);
    procedure SetBordersProperty(Value: TcxSSBorderStyle);
    procedure SetBrushProperty(Value: TcxSSBrush);
    procedure SetFont(const AFont: TcxSSFontRec);
    procedure SetFontProperty(Value: TcxSSFont);
    procedure SetFillStyle(const AStyle: TcxSSFillStyle; AFgColor, ABkColor: Byte);
    procedure SetFormatStyle(const Value: TxlsDataFormat);
    procedure SetLockUpdate(const Value: Boolean);
    procedure SetLocked(const Value: Boolean); 
    procedure SetMerge(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetStylePtr(const Value: PcxSSCellStyleRec);
    procedure SetTextHAlign(const Value: TcxHorzTextAlign);
    procedure SetTextVAlign(const Value: TcxVertTextAlign);
    procedure SetWordBreak(const Value: Boolean);
  protected
    StyleInfo: TcxSSCellStyleRec;
    procedure DoOnChange(Sender: TObject; AStyleType: TcxSSStyleInfoType); virtual;
    function GetOwner: TPersistent; override;
    procedure ResizeExtents(const AExtent, ANewExtent: TSize); virtual;
    procedure SetState(AState: TcxSSCellStates);
    property LockUpdate: Boolean read GetLockUpdate write SetLockUpdate;
    property Merge: Boolean read GetMerge write SetMerge;
    property Owner: TObject read FOwner;
    property Parent: TcxSSStyleCache read FParent;
    property StylePtr: PcxSSCellStyleRec read FStylePtr write SetStylePtr;
    property StyleInfoPtr: PcxSSCellStyleRec read GetStyleInfoPtr;
  public
    constructor Create(AParent: TcxSSStyleCache; AOwner: TObject = nil;
      ACol: Integer = -1; ARow: Integer = -1); reintroduce; overload;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property IsMain: Boolean read GetIsMain;
    property IsMerge: Boolean read GetMerge;
    property Col: Integer read FCol;
    property Row: Integer read FRow;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  published
    property Locked: Boolean read GetLocked write SetLocked default True; 
    property Borders: TcxSSBorderStyle read GetBorderStyle write SetBordersProperty;
    property Brush: TcxSSBrush read GetBrush write SetBrushProperty;
    property Font: TcxSSFont read GetFont write SetFontProperty;
    property Format: TxlsDataFormat read GetFormat write SetFormatStyle default 0;
    property HorzTextAlign: TcxHorzTextAlign read GetTextHAlign write SetTextHAlign default haGeneral;
    property VertTextAlign: TcxVertTextAlign read GetTextVAlign write SetTextVAlign default vaCenter;
    property WordBreak: Boolean read GetWordBreak write SetWordBreak default False;
  end;

  { TcxSSDefaultBorders }
  TcxSSDefaultBorders = class(TcxSSStyle)
  private
    FBorders: array[0..1] of TcxSSEdgeStyle;
    function GetEdgeStyleByIndex(Index: Integer): TcxSSEdgeStyle;
    procedure SetEdgeStyleByIndex(Index: Integer; Value: TcxSSEdgeStyle);
  protected
    function GetOwner: TPersistent; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure BeforeDestruction; override;
  published
    property HorizontalBorders: TcxSSEdgeStyle index 1 read GetEdgeStyleByIndex write SetEdgeStyleByIndex;
    property VerticalBorders: TcxSSEdgeStyle index 0 read GetEdgeStyleByIndex write SetEdgeStyleByIndex;
  end;

  { TcxSSDefaultStyle }
  TcxSSDefaultStyle = class(TcxSSCellStyle)
  private
    FBorders: TcxSSDefaultBorders;
    function GetBordersProperty: TcxSSDefaultBorders;
    procedure SetBordersProperty(Value: TcxSSDefaultBorders);
  published
    destructor Destroy; override;
    property Borders: TcxSSDefaultBorders read GetBordersProperty write SetBordersProperty;
  end;

function CreateFontHandle(AFontRec: PcxSSFontRec): TcxFontHandle;

implementation
uses
  cxSSheet, cxSSData, cxSSHeaders;

type
  TcxSheetAccess = class(TcxSSBookSheet);
  TcxDataStorageAccess = class (TcxSSDataStorage);
  TcxBookAccess = class(TcxCustomSpreadSheetBook);
  TcxListenerAccess = class(TcxSSListener);
  TcxHeaderAccess = class(TcxSSHeader);

{$IFDEF WIN32}
const
  ScreenPixelsPerInch: Integer = 96;
{$ENDIF}

function TextExtents(AFont: PcxSSFontRec): TSize;
var
  ACanvas: TcxScreenCanvas;
begin
  ACanvas := TcxScreenCanvas.Create();
  try
    with AFont^ do
    begin
      ACanvas.Font.Name := Name;
      ACanvas.Font.Style := Style;
      ACanvas.Font.Charset := Charset;
      ACanvas.Font.Size := Size;
    end;
    Result := ACanvas.TextExtent('Wg');
  finally
    ACanvas.Free;
  end;
end;

function CreateFontHandle(AFontRec: PcxSSFontRec): TcxFontHandle;
var
  ALogFont: TLogFont;
begin
  with AFontRec^ do
  begin
    FillChar(ALogFont, SizeOf(ALogFont), 0);
    with ALogFont do
    begin
      lfHeight := -MulDiv(Size, ScreenPixelsPerInch, 72);
      if fsBold in Style then
        lfWeight := FW_BOLD
      else
        lfWeight := FW_NORMAL;
      lfItalic := Byte(fsItalic in Style);
      lfUnderline := Byte(fsUnderline in Style);
      lfStrikeOut := Byte(fsStrikeOut in Style);
      lfCharSet := Byte(Charset);
      if AnsiCompareText(Name, 'Default') = 0 then
        lfFaceName := cxDefaultFontName
      else
        StrPCopy(lfFaceName, Name);
    end;
  end;
  Result := CreateFontIndirect(ALogFont);
end;

{ TcxFormatCache }
constructor TcxSSStyleCache.Create(AOwner: TObject);
var
  APStyle: PcxSSCellStyleRec;
  I: TcxSSEdgeBorder;
  AFont: TFont;
begin
  FOwner := AOwner;
  FLockCount := 0;
  AFont := TcxBookAccess(AOwner).Font;
  FFontList := TList.Create;
  FStyles := TList.Create;
  New(PcxSSCellStyleRec(APStyle));
  FStyles.Add(APStyle);
  with APStyle^ do
  begin
    CellState := [cLocked];
    FormatIndex := 0;
    BrushBkColor := 56;
    BrushFgColor := 56;
    HorzAlign := haGeneral;
    VertAlign := vaCenter;
    BrushStyle := fsSolid;
    FontPtr := AddFont(AFont.Name, AFont.Style, AFont.Charset, AFont.Size,
      xlsSetColor(AFont.Color, Palette, cxSSDefaultColorValue));
    WordBreak := False;
    for I := eLeft to eBottom do
    begin
      Borders[I].Style := lsDefault;
      Borders[I].Color := cxSSDefaultColorValue;
    end;
    RefCount := 1;
  end;
  FDefCellStyle := TcxSSDefaultStyle.Create(Self, nil, -1, -1);
  FIsChangeBorders := False;
end;

destructor TcxSSStyleCache.Destroy;
var
  I: Integer;
begin
  Clear;
  for I := 0 to FFontList.Count - 1 do
  begin
    if PcxSSFontRec(FFontList[I])^.FontHandle <> 0 then
      DeleteObject(PcxSSFontRec(FFontList[I])^.FontHandle);
    Dispose(PcxSSFontRec(FFontList[I]));
  end;
  for I := 0 to FStyles.Count - 1 do
    Dispose(PcxSSCellStyleRec(FStyles[I]));
  FFontList.Free;
  FDefCellStyle.Free;
  FStyles.Free;
  inherited Destroy;
end;

function TcxSSStyleCache.AddFont(const AName: string; AStyle: TFontStyles;
 ACharset: TFontCharset; ASize: SmallInt; AColor: Byte): PcxSSFontRec;

  function FontRecToIndex: SmallInt;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to FFontList.Count -1 do
      with PcxSSFontRec(FFontList[I])^ do
      if (Name = AName) and (Size = ASize) and (Charset = ACharset) and
        (Style = AStyle) and (FontColor = AColor) then
      begin
        Result := I;
        Break;
      end;
  end;

var
  AIndex: Integer;
begin
  AIndex := FontRecToIndex;
  if  AIndex = -1 then
  begin
    New(Result);
    with Result^ do
    begin
      Name := AName;
      Style := AStyle;
      Charset := ACharset;
      FontColor := AColor;
      Size := ASize;
      FontHandle := CreateFontHandle(Result);
      if FontHandle = 0 then
        FontHandle := 0;
    end;
    Result^.Extents := TextExtents(Result);
    FFontList.Add(Result);
  end
  else
    Result := FFontList[AIndex];
end;

function TcxSSStyleCache.AddFontClone(AFont: PcxSSFontRec): PcxSSFontRec;
begin
  if AFont <> nil then
  begin
    with AFont^ do
      Result := AddFont(Name, Style, Charset, Size, FontColor);
  end
  else
    Result := nil;
end;

procedure TcxSSStyleCache.Clear;
var
  I: Integer;
begin
  if Lock then Exit;
  FStyles.Exchange(FStyles.IndexOf(FDefCellStyle.StylePtr), 0);
  with PcxSSCellStyleRec(FStyles[0])^ do
  begin
    if FFontList.IndexOf(FontPtr) > 0 then
      FFontList.Exchange(FFontList.IndexOf(FontPtr), 0);
    for I := FFontList.Count - 1 downto 1 do
    begin
      DeleteObject(PcxSSFontRec(FFontList[I])^.FontHandle);
      Dispose(PcxSSFontRec(FFontList[I]));
      FFontList.Delete(I);
    end;
    FontPtr := FFontList[0];
    RefCount := 1;
  end;
  for I := FStyles.Count - 1 downto 1 do
  begin
    Dispose(PcxSSCellStyleRec(FStyles[I]));
    FStyles.Delete(I);
  end;
end;

function TcxSSStyleCache.Clone(AStyle: PcxSSCellStyleRec): PcxSSCellStyleRec;
var
  I: Integer;
  ARec: TcxSSCellStyleRec;
begin
  if AStyle <> nil then
  begin
    ARec := AStyle^;
    ARec.FontPtr := AddFontClone(ARec.FontPtr);
    ARec.RefCount := 1;
    I := IndexOf(ARec);
    if I < 0 then
    begin
      New(Result);
      FStyles.Add(Result);
      Result^ := ARec;
    end
    else
    begin
      Result := FStyles[I];
      Inc(Result^.RefCount);
    end;
  end
  else
    Result := nil;
end;

function TcxSSStyleCache.GetCellStyle(ADataStorage: TObject;
  ACol, ARow: Integer): TcxSSCellStyle;
begin
  if (ACol >= 0) and (ARow >= 0) then
    Result := TcxSSCellStyle.Create(Self, ADataStorage, ACol, ARow)
  else
    raise EStyleError.Create(cxGetResourceString(@scxStyleInvalidCellStyle));
end;

function TcxSSStyleCache.AddCellStyleRec(const ACellStyle: TcxSSCellStyleRec): PcxSSCellStyleRec;
var
  APRec: PcxSSCellStyleRec;
  AIndex: Integer;
begin
  AIndex := IndexOf(ACellStyle);
  if ACellStyle.RefCount = AIndex then
  begin
    Result := FStyles[AIndex];
    Exit;
  end;
  if AIndex = -1 then
  begin
    New(PcxSSCellStyleRec(APRec));
    APRec^ := ACellStyle;
    APRec^.RefCount := 1;
    Result := APRec;
    FStyles.Add(APRec);
  end
  else
    begin
      Inc(PcxSSCellStyleRec(FStyles[AIndex])^.RefCount);
      Result := PcxSSCellStyleRec(FStyles[AIndex]);
    end;
end;

procedure TcxSSStyleCache.ReleaseRefCount(const AIndex: Integer);
begin
  if AIndex < 0 then Exit;
  Dec(PcxSSCellStyleRec(FStyles[AIndex])^.RefCount);
  if (AIndex > 0) and (PcxSSCellStyleRec(FStyles[AIndex])^.RefCount <= 0) then
  begin
   Dispose(PcxSSCellStyleRec(FStyles[AIndex]));
   FStyles.Delete(AIndex);
  end
end;

procedure TcxSSStyleCache.DoOnChange(Sender: TObject; AStyleType: TcxSSStyleInfoType);
var
  ACellStyle: TcxSSCellStyleRec;
  AIndex: Integer;
  AOldStyle: TcxSSCellStyleRec;
  ANewStylePtr: PcxSSCellStyleRec;
  ACellStyleObj: TcxSSCellStyle;
  ACol, ARow: Integer;
  AKind: TcxSSEdgeBorder;
const
  AInvertBorders: array[TcxSSEdgeBorder] of TcxSSEdgeBorder = (eRight, eBottom, eLeft, eTop);
begin
  if AStyleType = siBorder then
    ACellStyleObj := TcxSSStyle(Sender).Owner
  else
    ACellStyleObj := TcxSSCellStyle(Sender);
  ACellStyle := GetCellStyleRecFromCellStyle(ACellStyleObj);
  AOldStyle := ACellStyleObj.StylePtr^;
  if ACellStyleObj = FDefCellStyle then
  begin
    AOldStyle.RefCount := PcxSSCellStyleRec(StyleList[0])^.RefCount;
    FDefCellStyle.FStylePtr^ := ACellStyle;
    for AKind := eLeft to eTop do
      FDefCellStyle.FStylePtr^.Borders[TcxSSEdgeBorder(Byte(AKind) + 2)] := ACellStyle.Borders[AKind];
    FDefCellStyle.FStylePtr^.RefCount := AOldStyle.RefCount;
    TcxListenerAccess(Listener).OnChangeDefaultStyle(AOldStyle, ACellStyle);
    Exit;
  end;
  TcxBookAccess(Owner).SetModified;
  AIndex := ACellStyle.RefCount;
  ANewStylePtr := AddCellStyleRec(ACellStyle);
  if ANewStylePtr = ACellStyleObj.StylePtr then
    Exit
  else
  begin
    ACellStyleObj.StylePtr := ANewStylePtr;
    ReleaseRefCount(AIndex);
  end;
  if (AStyleType = siBorder) and (ACellStyleObj.Owner <> nil) then
  begin
    ACol := ACellStyleObj.Col;
    ARow := ACellStyleObj.Row;
    AKind := TcxSSEdgeStyle(Sender).Kind;
    case AKind of
      eLeft: Dec(ACol);
      eTop: Dec(ARow);
      eRight: Inc(ACol);
      eBottom: Inc(ARow);
    end;
    if FIsChangeBorders then Exit;
    try
      FIsChangeBorders := True;
       if (ACol >= 0) and (ARow >= 0) then
         with TcxSSCellStyle.Create(Self, ACellStyleObj.Owner, ACol, ARow) do
         try
           with ACellStyleObj.StyleInfo.Borders[AKind] do
             Borders[AInvertBorders[TcxSSEdgeStyle(Sender).Kind]].AssignInfo(Style, Color);
         finally
           Free;
         end;
    finally
      FIsChangeBorders := False;
    end;
  end;
end;

function TcxSSStyleCache.GetCellStyleRecFromCellStyle(ACellStyle: TcxSSCellStyle): TcxSSCellStyleRec;
begin
  Result := ACellStyle.StyleInfo;
  Result.RefCount := FStyles.IndexOf(ACellStyle.StylePtr);
end;

function TcxSSStyleCache.IndexOf(const ACellStyle: TcxSSCellStyleRec): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FStyles.Count - 1 do
  begin
    if CompareMem(FStyles[I], @ACellStyle, SizeOf(TcxSSCellStyleRec) - 4) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TcxSSStyleCache.GetListener: TObject;
begin
  Result := TcxBookAccess(Owner).Listener;
end;

function TcxSSStyleCache.GetLock: Boolean;
begin
  Result := FLockCount > 0
end;

function TcxSSStyleCache.GetPalette: PcxExcelPalette;
begin
  Result := TcxBookAccess(Owner).Palette;
end;

function TcxSSStyleCache.GetStyleFromList(AIndex: Integer): PcxSSCellStyleRec;
begin
  if AIndex >= FStyles.Count then
    raise EStyleError.Create(cxGetResourceString(@scxStyleInvalidCellStyle))
  else
    Result := FStyles[AIndex];
end;

procedure TcxSSStyleCache.SetLock(const Value: Boolean);
begin
  if Value then
    Inc(FLockCount)
  else
    Dec(FLockCount)
end;

{ TcxStyle }
procedure TcxSSStyle.AfterConstruction;
begin
  FLockUpdate := 0;
  inherited AfterConstruction;
end;

function TcxSSStyle.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxSSStyle.DoOnChange(Sender: TObject);
begin
  if LockUpdate then Exit;
  if Assigned(FOnChange) then
    FOnChange(Self);
  FOwner.DoOnChange(Self, InfoType);
end;

function TcxSSStyle.ValidateColor(AColor: Word; ADefault: Word): Word;
begin
  if AColor > High(TcxExcelPalette) then
    Result := ADefault
  else
    Result := AColor;
end;

function TcxSSStyle.GetUpdate: Boolean;
begin
  Result := FLockUpdate > 0;
end;

procedure TcxSSStyle.SetUpdate(const Value: Boolean);
begin
  if Value then
    Inc(FLockUpdate)
  else
    if FLockUpdate > 0 then Dec(FLockUpdate);
end;

{ TcxFont }

procedure TcxSSFont.AfterConstruction;
begin
  InfoType := siFont;
  inherited AfterConstruction;
end;

procedure TcxSSFont.Assign(Source: TPersistent);
var
  AFont: TcxSSFont;
begin
  if (Source <> nil) and (Source is TcxSSFont) then
  begin
    AFont := TcxSSFont(Source);
    AssignInfo(AFont.Name, AFont.Size, AFont.Style, AFont.Charset, AFont.FontColor);
  end;
end;

procedure TcxSSFont.AssignInfo(const AName: string; ASize: Integer; AStyle: TFontStyles;
  ACharset: TFontCharset; AFontColor: Word);
var
  AExtents: TSize;
begin
  if Owner.ReadOnly then Exit;
  AFontColor := ValidateColor(AFontColor,  cxSSDefaultColorValue);
  AExtents := Owner.StyleInfo.FontPtr^.Extents;
  Owner.StyleInfo.FontPtr :=
    Owner.Parent.AddFont(AName, AStyle, ACharset, ASize, AFontColor);
  Owner.ResizeExtents(AExtents, Owner.StyleInfo.FontPtr^.Extents);
  DoOnChange(Self);
end;

procedure TcxSSFont.AssignTo(Dest: TPersistent);
var
  AFont: TFont;
begin
  if Dest is TFont then
  begin
    AFont := TFont(Dest);
    AFont.Name := Name;
    AFont.Style := Style;
    AFont.Size := Size;
    if FontColor > 55 then
      AFont.Color := clBlack
    else
      AFont.Color := Owner.Parent.Palette^[FontColor];
  end
  else
    if Dest is TcxSSFont then
      TcxSSFont(Dest).Assign(Self);
end;

function TcxSSFont.GetCharset: TFontCharset;
begin
  Result := TFontCharset(Owner.StyleInfo.FontPtr^.Charset);
end;

function TcxSSFont.GetColor: TcxSSColor;
begin
  Result := Owner.StyleInfo.FontPtr^.FontColor;
end;

function TcxSSFont.GetName: TFontName;
begin
  Result := Owner.StyleInfo.FontPtr^.Name;
end;

function TcxSSFont.GetSize: Integer;
begin
  Result := Owner.StyleInfo.FontPtr^.Size;
end;

function TcxSSFont.GetStyle: TFontStyles;
begin
  Result := TFontStyles(Owner.StyleInfo.FontPtr^.Style);
end;

procedure TcxSSFont.SetCharset(const Value: TFontCharset);
begin
  with Owner.StyleInfo.FontPtr^ do
    AssignInfo(Name, Size, TFontStyles(Style),
      Value, FontColor);
end;

procedure TcxSSFont.SetColor(const Value: TcxSSColor);
begin
  with Owner.StyleInfo.FontPtr^ do
    AssignInfo(Name, Size, TFontStyles(Style), TFontCharset(Charset), Value);
end;

procedure TcxSSFont.SetName(const Value: TFontName);
begin
  with Owner.StyleInfo.FontPtr^ do
    AssignInfo(Value, Size, TFontStyles(Style), TFontCharset(Charset), FontColor);
end;

procedure TcxSSFont.SetSize(const Value: Integer);
begin
  with Owner.StyleInfo.FontPtr^ do
    AssignInfo(Name, Value, TFontStyles(Style), TFontCharset(Charset), FontColor);
end;

procedure TcxSSFont.SetStyle(const Value: TFontStyles);
begin
  with Owner.StyleInfo.FontPtr^ do
    AssignInfo(Name, Size, TFontStyles(Value), TFontCharset(Charset), FontColor);
end;

{ TcxBrush }
procedure TcxSSBrush.AfterConstruction;
begin
  InfoType := siBrush;
  inherited AfterConstruction;
end;

procedure TcxSSBrush.Assign(Source: TPersistent);
var
  ABrush: TcxSSBrush;
begin
  if Source <> nil then
  begin
    ABrush := TcxSSBrush(Source);
    AssignInfo(ABrush.Style, ABrush.BackgroundColor, ABrush.ForegroundColor);
  end;
end;

procedure TcxSSBrush.AssignInfo(AStyle: TcxSSFillStyle;
  const ABackgroundColor, AForegroundColor: Word);
begin
  if Owner.ReadOnly then Exit;
  Owner.StyleInfo.BrushBkColor :=
    ValidateColor(ABackgroundColor, cxSSDefaultColorValue);
  Owner.StyleInfo.BrushFgColor :=
    ValidateColor(AForegroundColor, cxSSDefaultColorValue);
  Owner.StyleInfo.BrushStyle := AStyle;
  DoOnChange(Self);
end;

function TcxSSBrush.GetBkColor: TcxSSColor;
begin
  Result := Owner.StyleInfo.BrushBkColor;
end;

function TcxSSBrush.GetFgColor: TcxSSColor;
begin
  Result := Owner.StyleInfo.BrushFgColor;
end;

function TcxSSBrush.GetStyle: TcxSSFillStyle;
begin
  Result := Owner.StyleInfo.BrushStyle;
end;

procedure TcxSSBrush.SetBkColor(const Value: TcxSSColor);
begin
  AssignInfo(Style, Value, ForegroundColor);
end;

procedure TcxSSBrush.SetFgColor(const Value: TcxSSColor);
begin
  AssignInfo(Style, BackgroundColor, Value);
end;

procedure TcxSSBrush.SetStyle(const Value: TcxSSFillStyle);
begin
  AssignInfo(Value, Backgroundcolor, ForegroundColor);
end;

{ TcxEdgeStyle }
procedure TcxSSEdgeStyle.AfterConstruction;
begin
  InfoType := siBorder;
  inherited AfterConstruction;
end;

procedure TcxSSEdgeStyle.Assign(Source: TPersistent);
var
  AEdgeStyle: TcxSSEdgeStyleRec;
begin
  if Source <> nil then
  begin
    AEdgeStyle := TcxSSEdgeStyle(Source).Owner.StyleInfo.Borders[TcxSSEdgeStyle(Source).Kind];
    AssignRec(AEdgeStyle);
  end;
end;

procedure TcxSSEdgeStyle.AssignRec(AData: TcxSSEdgeStyleRec);
var
  AStyle: TcxSSEdgeStyleRec;
begin
  if Owner.ReadOnly then Exit;
  AStyle := Owner.StyleInfo.Borders[FKind];
  if (AStyle.Color = AData.Color) and (AStyle.Style = AData.Style) then Exit;
  Owner.StyleInfo.Borders[FKind] := AData;
  DoOnChange(Self);
end;

procedure TcxSSEdgeStyle.AssignInfo(AStyle: TcxSSEdgeLineStyle; AColor: Word);
var
  ABorderStyle: TcxSSEdgeStyleRec;
begin
  if Owner.ReadOnly then Exit;
  AColor := ValidateColor(AColor, cxSSDefaultColorValue);
  ABorderStyle := Owner.StyleInfo.Borders[FKind];
  if (ABorderStyle.Color = AColor) and (ABorderStyle.Style = AStyle) then Exit;
  Owner.StyleInfo.Borders[FKind].Color := AColor;
  Owner.StyleInfo.Borders[FKind].Style := AStyle;
  DoOnChange(Self);
end;

function TcxSSEdgeStyle.GetOwner: TPersistent;
begin
  Result := Owner.Borders;
end;

function TcxSSEdgeStyle.GetColor: TcxSSColor;
begin
  with Owner.StyleInfo do
  begin
    if Style <> lsDefault then
      Result := Borders[FKind].Color
    else
      Result := cxSSDefaultColorValue
  end;
end;

function TcxSSEdgeStyle.GetStyle: TcxSSEdgeLineStyle;
var
  ACol, ARow: Integer;
  ARect: TRect;
begin
  Result := Owner.StyleInfo.Borders[FKind].Style;
  if cMerge in Owner.StyleInfo.CellState then
  begin
    ACol := Owner.Col;
    ARow := Owner.Row;
    if (ACol >= 0) and (ARow >= 0) and
      TcxSSDataStorage(Owner.Owner).CheckInMergeRange(Point(ACol, ARow), ARect) then
    begin
      case Kind of
        eLeft:
          if ACol <> ARect.Left then
            Result := lsNone;
        eTop:
          if ARow <> ARect.Top then
            Result := lsNone;
        eRight:
          if ACol <> ARect.Right then
            Result := lsNone;
        eBottom:
          if ARow <> ARect.Bottom then
            Result := lsNone;
      end;
    end;
  end;
  if (Result = lsDefault) and (Owner <> Owner.Parent.DefaultStyle) then
  begin
    with Owner do
      if (Brush.Style <> fsSolid) or (Brush.BackgroundColor <= 55) then
        Result := lsNone;
  end;
end;

procedure TcxSSEdgeStyle.SetColor(const Value: TcxSSColor);
begin
  AssignInfo(Style, Value);
end;

procedure TcxSSEdgeStyle.SetStyle(const Value: TcxSSEdgeLineStyle);
begin
  AssignInfo(Value, Color);
end;

{ TcxSSBorderStyle }
procedure TcxSSBorderStyle.BeforeDestruction;
var
  I: TcxSSEdgeBorder;
begin
  try
    for I := eLeft to eBottom do
      if FEdges[I] <> nil then FEdges[I].Free;
  finally
    inherited BeforeDestruction;
  end;
end;

procedure TcxSSBorderStyle.Assign(Source: TPersistent);
var
  ASide: TcxSSEdgeBorder;
begin
  if Source <> nil then
  begin
    for ASide := eLeft to eBottom do
      Edges[ASide].Assign(TcxSSBorderStyle(Source).Edges[ASide]);
  end;
end;

function TcxSSBorderStyle.GetOwner: TPersistent;
begin
  Result := Owner;
end;

function TcxSSBorderStyle.GetEdgeStyle(Index: TcxSSEdgeBorder): TcxSSEdgeStyle;
begin
  if (Byte(Index) > 1) and (Owner.Parent.DefaultStyle = Owner) then
    Result := GetEdgeStyle(TcxSSEdgeBorder(Byte(Index) - 2))
  else
  begin
    if not Assigned(FEdges[Index]) then
    begin
      FEdges[Index] := TcxSSEdgeStyle.Create;
      FEdges[Index].FOwner := Owner;
      FEdges[Index].FKind := Index;
    end;
    Result := FEdges[Index];
  end;
end;

function TcxSSBorderStyle.GetEdgeStyleByIndex(Index: Integer): TcxSSEdgeStyle;
begin
  Result := GetEdgeStyle(TcxSSEdgeBorder(Index));
end;

procedure TcxSSBorderStyle.SetEdgeStyleByIndex(Index: Integer; Value: TcxSSEdgeStyle);
begin
  if Value <> nil then
    Edges[TcxSSEdgeBorder(Index)].Assign(Value);
end;

{ TcxSSCellStyle }
constructor TcxSSCellStyle.Create(AParent: TcxSSStyleCache; AOwner: TObject = nil;
  ACol: Integer = -1; ARow: Integer = -1);
begin
  FOwner := AOwner;
  FParent := AParent;
  FCol := ACol;
  FRow := ARow;
  if (ACol = -1) and (ARow = -1) or (Owner = nil) then
    FStylePtr := AParent.StyleList[0]
  else
    FStylePtr := TcxSSDataStorage(AOwner)[ACol, ARow].StylePtr;
  StyleInfo := FStylePtr^;
  if  (Parent.StyleList.IndexOf(StylePtr) = 0) and (FOwner <> nil) then
    Inc(StylePtr^.RefCount);
end;

destructor TcxSSCellStyle.Destroy;
begin
  if FBorderStyle <> nil then FBorderStyle.Free;
  if FBrush <> nil then FBrush.Free;
  if FFont <> nil then FFont.Free;
  if Owner <> nil then
    if TcxSSDataStorage(Owner)[FCol, FRow].StylePtr <> FStylePtr then
      TcxSSDataStorage(Owner).CellStylePtr[FCol, FRow] := FStylePtr;
  inherited;
end;

procedure TcxSSCellStyle.Assign(Source: TPersistent);
var
  ASide: TcxSSEdgeBorder;
  AStyle: TcxSSCellStyle;
begin
  if (Source is TcxSSCellStyle) then
  begin
    if ReadOnly then Exit;
    AStyle := TcxSSCellStyle(Source);
    HorzTextAlign := AStyle.HorzTextAlign;
    VertTextAlign := AStyle.VertTextAlign;
    Format := AStyle.Format;
    WordBreak := AStyle.WordBreak;
    for ASide := eLeft to eBottom do
      Borders[ASide].Assign(AStyle.Borders[ASide]);
    with AStyle.Font do
      Font.AssignInfo(Name, Size, Style, Charset, FontColor);
    Brush.Assign(AStyle.Brush);
    ReadOnly := AStyle.ReadOnly;
    if Owner is TcxSSDataStorage then
    begin
      if TcxSSDataStorage(Owner)[AStyle.Col, AStyle.Row].StylePtr <> AStyle.StylePtr then
        AStyle.StylePtr := TcxSSDataStorage(Owner)[AStyle.Col, AStyle.Row].StylePtr
    end
    else
      AStyle.StylePtr := TcxSSCellStyle(Source).StylePtr;
    AStyle.StyleInfo := AStyle.StylePtr^;
  end;
end;

procedure TcxSSCellStyle.DoOnChange(Sender: TObject; AStyleType: TcxSSStyleInfoType);
begin
  if LockUpdate then Exit;
  if Assigned(FOnChangeStyle) then
    FOnChangeStyle(self, AStyleType);
  if AStyleType = siBorder then
    FParent.DoOnChange(Sender, AStyleType)
  else
    FParent.DoOnChange(Self, AStyleType);
end;

function TcxSSCellStyle.GetOwner: TPersistent;
begin
  Result := TPersistent(FParent.Owner);
end;

procedure TcxSSCellStyle.ResizeExtents(const AExtent, ANewExtent: TSize);
var
  ASheet: TcxSheetAccess;
begin
  if Owner = nil then Exit; 
  ASheet := TcxSheetAccess(TcxDataStorageAccess(Owner).Owner);
  if ASheet.IsLoaded then Exit; 
  if (Int64(AExtent) <> Int64(ANewExtent)) and ((Col >= 0) and (Row >=0)) then
  with AExtent do
  begin
//      This code need for automatic with adjust after font changing
//    with TcxHeaderAccess(TcxSheetAccess(ASheet).Cols) do
//    begin
//      if (Cx <> ANewExtent.Cx) and (Cx > 0) and (ANewExtent.Cx > 0) then
//        SetScaledSize(Col, Cx, ANewExtent.Cx);
//    end;
    with TcxHeaderAccess(TcxSheetAccess(ASheet).Rows) do
    begin
      if (Cy <> ANewExtent.Cy) and (Cy > 0) and (ANewExtent.Cy > 0)  then
        SetScaledSize(Row, Cy, ANewExtent.Cy);
    end;
  end;
end;

procedure TcxSSCellStyle.SetState(AState: TcxSSCellStates);
begin
  if StyleInfo.CellState <> AState then
  begin
   StyleInfo.CellState  := AState;
   FParent.DoOnChange(Self, siReadOnly)
  end;
end;

function TcxSSCellStyle.GetBorderStyle: TcxSSBorderStyle;
begin
  if FBorderStyle = nil then
  begin
    FBorderStyle := TcxSSBorderStyle.Create;
    FBorderStyle.FOwner := Self;
  end;
  Result := FBorderStyle;
end;

function TcxSSCellStyle.GetBrush: TcxSSBrush;
begin
  if FBrush = nil then
  begin
    FBrush := TcxSSBrush.Create; 
    FBrush.FOwner := Self;
  end;
  Result := FBrush;
end;

function TcxSSCellStyle.GetFont: TcxSSFont;
begin
  if FFont = nil then
  begin
    FFont := TcxSSFont.Create;
    FFont.FOwner := Self;
  end; 
  Result := FFont;
end;

function TcxSSCellStyle.GetFormat: TxlsDataFormat;
begin
  Result := Word(StyleInfo.FormatIndex);
  case Word(Result) of
    $A4:
      Result := $32;
    $A5:
      Result := $33;
  end;
  if Result > $16 then
    Dec(Result, $0E);
end;

function TcxSSCellStyle.GetIsMain: Boolean;
var
  ARect: TRect;
begin
  Result := not Merge;
  if not Result then
  begin
    TcxSSDataStorage(FOwner).CheckInMergeRange(Point(FCol, FRow), ARect);
    Result := (FCol = ARect.Left) and (FRow = ARect.Top);
  end;
end;

function TcxSSCellStyle.GetLockUpdate: Boolean;
begin
  Result := FLockCount > 0;
end;

function TcxSSCellStyle.GetReadOnly: Boolean;
begin
  Result := (cReadOnly in StyleInfo.CellState) or (not (Self = Parent.DefaultStyle) and
   (TcxBookAccess(Parent.Owner).ReadOnly or
    TcxSheetAccess(TcxDataStorageAccess(Owner).Owner).ReadOnly));
end;

function TcxSSCellStyle.GetLocked: Boolean;
begin
  Result := cLocked in StyleInfo.CellState;
end;

function TcxSSCellStyle.GetMerge: Boolean;
begin
  Result := cMerge in StyleInfo.CellState;
end;

function TcxSSCellStyle.GetStyleInfoPtr: PcxSSCellStyleRec;
begin
  Result := @StyleInfo;
end;

function TcxSSCellStyle.GetTextHAlign: TcxHorzTextAlign;
begin
  Result := StyleInfo.HorzAlign;
end;

function TcxSSCellStyle.GetTextVAlign: TcxVertTextAlign;
begin
  Result := StyleInfo.VertAlign;
end;

function TcxSSCellStyle.GetWordBreak: Boolean;
begin
  Result := StyleInfo.WordBreak;
end;

procedure TcxSSCellStyle.SetBorderStyle(const ASide: TcxSSEdgeBorder;
  AStyle: TcxSSEdgeLineStyle; AColor: Byte);
begin
  Borders[ASide].AssignInfo(AStyle, AColor);
end;

procedure TcxSSCellStyle.SetBordersProperty(Value: TcxSSBorderStyle);
begin
  if Value <> nil then
    Borders.Assign(Value)
end;

procedure TcxSSCellStyle.SetBrushProperty(Value: TcxSSBrush);
begin
  if Value <> nil then
    Brush.Assign(Value)
end;

procedure TcxSSCellStyle.SetFont(const AFont: TcxSSFontRec);
begin
  with AFont do
    Font.AssignInfo(Name, Size, TFontStyles(Style), TFontCharset(Charset), FontColor);
end;

procedure TcxSSCellStyle.SetFontProperty(Value: TcxSSFont);
begin
  if Value <> nil then
    Font.Assign(Value)
end;

procedure TcxSSCellStyle.SetCellStyle(const AStyle: PcxSSCellStyleRec;
 ASetDefaultBorders: Boolean = False);
var
  ASide: TcxSSEdgeBorder;
begin
  Brush.AssignInfo(AStyle^.BrushStyle, AStyle^.BrushBkColor, AStyle^.BrushFgColor);
  SetFont(AStyle^.FontPtr^);
  for ASide := eLeft to eBottom do
    if (AStyle^.Borders[ASide].Style <> lsDefault) or ASetDefaultBorders then
       SetBorderStyle(ASide, AStyle^.Borders[ASide].Style, AStyle^.Borders[ASide].Color);
  StyleInfo.FormatIndex := AStyle^.FormatIndex;
//  if (AStyle^.HorzAlign = haGeneral) and  (Row > 0) and (Col >= 0) then
//    with TcxSSDataStorage(Owner)[Col, Row - 1] do
//    begin
//      StyleInfo.HorzAlign := StylePtr^.HorzAlign;
//    end
//  else
    StyleInfo.HorzAlign := AStyle^.HorzAlign;
  StyleInfo.VertAlign := AStyle^.VertAlign;
  StyleInfo.WordBreak := AStyle^.WordBreak;
  StyleInfo.CellState := AStyle^.CellState - [cMerge];
  DoOnChange(Self, siAll);
end;

procedure TcxSSCellStyle.SetFillStyle(const AStyle: TcxSSFillStyle;
  AFgColor, ABkColor: Byte);
begin
  Brush.AssignInfo(AStyle, ABkColor, AFgColor);
end;

procedure TcxSSCellStyle.SetFormatStyle(const Value: TxlsDataFormat);
var
  AFormat: TxlsDataFormat;
begin
  if ReadOnly then Exit;
  if Value > $33 then
    AFormat := 0
  else
    AFormat := Value;
  if AFormat > $16 then
    Inc(AFormat, $E);
  case AFormat of
    $32:
      AFormat := $A4;
    $33:
      AFormat := $A5
  end;
  if AFormat <> StyleInfo.FormatIndex then
  begin
    StyleInfo.FormatIndex := AFormat;
    DoOnChange(Self, siFormat);
  end;
end;

procedure TcxSSCellStyle.SetLockUpdate(const Value: Boolean);
begin
  if Value then
   Inc(FLockCount)
  else
    if FLockCount > 0 then Dec(FLockCount);
end;

procedure TcxSSCellStyle.SetLocked(const Value: Boolean);
begin
  if Value then
    Include(StyleInfo.CellState, cLocked)
  else
    Exclude(StyleInfo.CellState, cLocked);
  DoOnChange(Self, siReadOnly);
end;

procedure TcxSSCellStyle.SetMerge(const Value: Boolean);
begin
  if Value <> (cMerge in StyleInfo.CellState) then
  begin
    if Value then
      Include(StyleInfo.CellState, cMerge)
    else
      Exclude(StyleInfo.CellState, cMerge);
    DoOnChange(Self, siMerge);
  end;
end;

procedure TcxSSCellStyle.SetReadOnly(const Value: Boolean);
begin
  if Value then
    Include(StyleInfo.CellState, cReadOnly)
  else
    Exclude(StyleInfo.CellState, cReadOnly);
  DoOnChange(Self, siReadOnly);
end;

procedure TcxSSCellStyle.SetStylePtr(const Value: PcxSSCellStyleRec);
begin
  FStylePtr := Value;
  StyleInfo := FStylePtr^;
  if (FCol >= 0) and (FRow >= 0) and Assigned(FOwner) then
    TcxSSDataStorage(FOwner).CellStylePtr[FCol, FRow] := Value;
end;

procedure TcxSSCellStyle.SetTextHAlign(const Value: TcxHorzTextAlign);
begin
  if not ReadOnly and (Value <> StyleInfo.HorzAlign) then
  begin
    StyleInfo.HorzAlign := Value;
    DoOnChange(Self, siAlign);
  end;
end;

procedure TcxSSCellStyle.SetTextVAlign(const Value: TcxVertTextAlign);
begin
  if not ReadOnly and (Value <> StyleInfo.VertAlign) then
  begin
    StyleInfo.VertAlign := Value;
    DoOnChange(Self, siAlign);
  end;
end;

procedure TcxSSCellStyle.SetWordBreak(const Value: Boolean);
begin
  if not ReadOnly and (StyleInfo.WordBreak <> Value) then
  begin
    StyleInfo.WordBreak := Value;
    DoOnChange(Self, siAlign);
  end;
end;

{ TcxSSDefaultBorders }
procedure TcxSSDefaultBorders.Assign(Source: TPersistent);
begin
  VerticalBorders.Assign(TcxSSDefaultBorders(Source).VerticalBorders);
  HorizontalBorders.Assign(TcxSSDefaultBorders(Source).VerticalBorders);
end;

procedure TcxSSDefaultBorders.BeforeDestruction;
begin
  FBorders[0].Free;
  FBorders[1].Free;
  inherited BeforeDestruction;
end;

function TcxSSDefaultBorders.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxSSDefaultBorders.GetEdgeStyleByIndex(Index: Integer): TcxSSEdgeStyle;
begin
  if not Assigned(FBorders[Index]) then
  begin
    FBorders[Index] := TcxSSEdgeStyle.Create;
    FBorders[Index].FOwner := Owner;
    FBorders[Index].FKind := TcxSSEdgeBorder(Index);
  end;
  Result := FBorders[Index];
end;

procedure TcxSSDefaultBorders.SetEdgeStyleByIndex(Index: Integer; Value: TcxSSEdgeStyle);
begin
  if Value <> nil then
    FBorders[Index].Assign(Value);
end;

{ TcxSSDefaultStyle }
destructor TcxSSDefaultStyle.Destroy;
begin
  FreeAndNil(FBorders);
  inherited Destroy;
end;

function TcxSSDefaultStyle.GetBordersProperty: TcxSSDefaultBorders;
begin
  if FBorders = nil then
  begin
    FBorders := TcxSSDefaultBorders.Create;
    FBorders.FOwner := Self;
  end;
  Result := FBorders;
end;

procedure TcxSSDefaultStyle.SetBordersProperty(Value: TcxSSDefaultBorders);
begin
  if Value <> nil then
    Borders.Assign(Value);
end;

{$IFDEF WIN32}
var
  ScreenDC: Integer;
{$ENDIF}

initialization
{$IFDEF WIN32}
  ScreenDC := GetDC(0);
  try
    ScreenPixelsPerInch := GetDeviceCaps(ScreenDC, LOGPIXELSY);
  finally
    ReleaseDC(0, ScreenDC)
  end;
{$ENDIF}

end.
