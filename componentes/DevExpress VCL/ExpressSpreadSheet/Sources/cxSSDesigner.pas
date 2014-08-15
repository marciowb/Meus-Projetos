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

unit cxSSDesigner;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Windows, Messages, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, ComCtrls, cxSSheet,
  cxSSStyles, cxControls, cxClasses, cxGraphics, cxSSCtrls, cxSSColorBox,
  cxSSRes, cxSSPainterWrapper, cxSSTypes, cxExcelConst;

type
  { TChangeStyleItemType }
  TChangeStyleItemType = (itHorzAlign, itVertAlign, itWordWrap,
    itFont, itBorderNone, itBorderOutline, itBorderInside, itBorderTop,
    itBorderVCenter, itBorderBottom, itBorderLeft, itBorderHCenter,
    itBorderRight, itPatternColor, itPatternStyle, itStyle);

  { TChangeStyleItemsType }
  TChangeStyleItemsType = set of TChangeStyleItemType;

  { TfrmDesigner }
  TcxSSStyleDesigner = class(TcxSSFormatDialog)
    btnOk: TButton;
    btnCancel: TButton;
    btnFont: TButton;
    btnTop: TBitBtn;
    btnVMiddle: TBitBtn;
    btnDown: TBitBtn;
    btnRight: TBitBtn;
    btnMiddle: TBitBtn;
    btnLeft: TBitBtn;
    btnNone: TBitBtn;
    btnOuter: TBitBtn;
    btnInner: TBitBtn;
    bvlBorders: TcxLabelBevel;
    bvlTextAlignment: TcxLabelBevel;
    bvlTextControl: TcxLabelBevel;
    bvlItems: TcxLabelBevel;
    bvlCellShading: TcxLabelBevel;
    cbxBorderColor: TcxSSColorComboBox;
    cbxPattern: TcxSSColorComboBox;
    cbxHorzAlign: TComboBox;
    cbxVertAlign: TComboBox;
    chxWordWrap: TCheckBox;
    cplPatColor: TcxSSColorPanel;
    drwgLineStyle: TDrawGrid;
    gbPatSample: TGroupBox;
    gbFontSample: TGroupBox;
    gbBorderStyle: TGroupBox;
    lbNone: TLabel;
    lbOuter: TLabel;
    lbInner: TLabel;
    lbPatColor: TLabel;
    lbPattern: TLabel;
    lbStyle: TLabel;
    lbColor: TLabel;
    lbHorzAlign: TLabel;
    lbVertAlign: TLabel;
    pcSheets: TPageControl;
    ppFontPaint: TcxPaintPanel;
    ppPaintBorders: TcxPaintPanel;
    ppPattern: TcxPaintPanel;
    tbsCellStyle: TTabSheet;
    tbsAlign: TTabSheet;
    tbsBorder: TTabSheet;
    tbsPatterns: TTabSheet;
    FontDialog: TFontDialog;
    rbNumber: TRadioButton;
    rbDateTime: TRadioButton;
    rbText: TRadioButton;
    gbStyleSet: TGroupBox;
    rbCurrency: TRadioButton;
    lbStyleDescription: TLabel;
    lbStyleTypes: TcxSSStyleListBox;
    gbStyle: TGroupBox;
    rbGeneral: TRadioButton;
    procedure OnbtnFontClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnClickBorderButtons(Sender: TObject);
    procedure ppPaintBordersPaint(Sender: TcxPaintPanel);
    procedure ppPaintBordersMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnAlignmentChange(Sender: TObject);
    procedure ppFontPaintPaint(Sender: TcxPaintPanel);
    procedure drwgLineStyleDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ppPatternPaint(Sender: TcxPaintPanel);
    procedure OnPatternChange(Sender: TObject);
    procedure drwgLineStyleSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure rbStyleTypeClick(Sender: TObject);
  private
    FCanvasWrapper: TcxCanvasWrapper;
    FCells: TRect;
    FChangeItems: TChangeStyleItemsType;
    FCurrentLineStyle: TcxSSEdgeLineStyle;
    FCurrentStyle: Integer;
    FIsLoaded: Boolean;
    FHeightCellSize: Integer;
    FHorzBorders: array[0..2] of TcxSSEdgeStyleRec;
    FHorzCount: Byte;
    FHorzVertex: array[0..2] of TRect;
    FSheet: TcxSSBookSheet;
    FVertBorders: array[0..2] of TcxSSEdgeStyleRec;
    FVertCount: Byte;
    FVertVertex: array[0..2] of TRect;
    FWidthCellSize: Integer;
    function GetIsChange(AItem: TChangeStyleItemType): Boolean;
    procedure SetStyleInfo(AStyle: TcxSSCellStyle);
    procedure SetVertexInfo;
  protected
    procedure AssignStyle(AStyle, AStyle2: TcxSSCellStyle);
    procedure Change(Sender: TObject);
    procedure CheckChanges;
    procedure CloseDesigner;
    procedure FormatChanged(Sender: TObject; StyleValue: Integer);
    procedure InitializeInformation(AStyle: TcxSSCellStyle);
    procedure OnKeyDownHandler(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure SetBorderStyle(AVertex: TRect; var ABorder: TcxSSEdgeStyleRec;
     AStyle: TcxSSEdgeLineStyle; AColor: Word; SetAlways: Boolean = False);
    procedure SetButtonState(IsMultiRow, IsMultiCol: Boolean);
    property IsChange[AItem: TChangeStyleItemType]: Boolean read GetIsChange;
    property IsLoaded: boolean read FIsLoaded write FIsLoaded;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(ADefaultStyle: TcxSSCellStyle): Boolean; reintroduce; overload;
    function Execute(const ACells: TRect; ASheet: TcxSSBookSheet): Boolean; overload; override;
  end;

implementation
  {$R *.dfm}

type
  TBookAccess = class(TcxCustomSpreadSheetBook);
  TCanvasWrapperAccess = class(TcxCanvasWrapper);
  TColorBoxAccess = class(TcxSSColorComboBox);
  TColorPanelAccess = class(TcxSSColorPanel);
  TSheetAccess = class(TcxSSBookSheet);
  TStyleAccess = class(TcxSSCellStyle);

const
  AStyles: array[0..14] of TcxSSEdgeLineStyle =
    (lsDefault, lsHair, lsDotted, lsDashDotDot, lsDashDot, lsDashed,
     lsThin, lsMediumDashDotDot, lsSlantedDashDot, lsMediumDashDot,
     lsMediumDashed, lsMedium, lsThick, lsDouble, lsNone);

  DateTimeFormats: array[0..13] of TcxSSStyleListBoxItem =
   ((Value: 'm/d/yy'; ValueType: $0E),
    (Value: 'dd/mm/yy'; ValueType: $A4),
    (Value: 'dd.mmmm.yy'; ValueType: $A5),
    (Value: 'd-mmm-y'; ValueType: $0F),
    (Value: 'd-mmm'; ValueType: $10),
    (Value: 'mmmm-yy'; ValueType: $11),
    (Value: 'h:mm AM/PM'; ValueType: $12),
    (Value: 'h:mm:ss AM/PM'; ValueType: $13),
    (Value: 'h:mm'; ValueType: $14),
    (Value: 'h:mm:ss'; ValueType: $15),
    (Value: 'm/d/yy h:mm'; ValueType: $16),
    (Value: 'mm:ss'; ValueType: $2D),
    (Value: '[h]:mm:ss'; ValueType: $2E),
    (Value: 'mm:ss.ms'; ValueType: $2F));

  CurrencyFormats: array[0..6] of TcxSSStyleListBoxItem =
   ((Value: '_($#,##0_);($#,##0)'; ValueType: $5),
    (Value: '_($#,##0_);[Red]($#,##0)'; ValueType: $6),
    (Value: '_($#,##0.00_);($#,##0.00)'; ValueType: $7),
    (Value: '_($#,##0.00_);[Red]($#,##0.00)'; ValueType: $8),
    (Value: '_($* #,##0_);_($* (#,##0);_($* "-"_);_(@_)'; ValueType: $2A),
    (Value: '_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)'; ValueType: $2B),
    (Value:  '_($* #,##0.00_);_($* (#,##0.00);_($* "-"??_);_(@_)'; ValueType: $2C));

  NumberFormats: array[0..14] of TcxSSStyleListBoxItem =
   ((Value: '0'; ValueType: $1),
    (Value: '0.00'; ValueType: $2),
    (Value: '#,##0'; ValueType: $3),
    (Value: '#,##0.00'; ValueType: $4),
    (Value: '0%'; ValueType: $9),
    (Value: '0.00%'; ValueType: $A),
    (Value: '0.00E+00'; ValueType: $B),
    (Value: '# ?/?'; ValueType: $C),
    (Value: '# ??/??'; ValueType: $D),
    (Value: '(#,##0_);(#,##0)'; ValueType: $25),
    (Value: '(#,##0_);[Red](#,##0)'; ValueType: $26),
    (Value: '(#,##0.00_);(#,##0.00)'; ValueType: $27),
    (Value: '(#,##0.00_);[Red](#,##0.00)'; ValueType: $28),
    (Value: '_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)'; ValueType: $29),
    (Value: '# #0.0E+0'; ValueType: $30));

constructor TcxSSStyleDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  lbStyleTypes.OnStyleChanged := FormatChanged;
  FCanvasWrapper := TcxCanvasWrapper.Create(@cxExcelStdColors);
  FCanvasWrapper.WindowColor := FCanvasWrapper.GetNativeColor(clWindow);
  OnKeyDown := OnKeyDownHandler; 
end;

destructor TcxSSStyleDesigner.Destroy;
begin
  FCanvasWrapper.Free;
  inherited Destroy;
end;

function TcxSSStyleDesigner.Execute(ADefaultStyle: TcxSSCellStyle): Boolean;
begin
  FChangeItems := [];
  IsLoaded := True;
  FHorzCount := 2;
  FVertCount := 2;
  SetVertexInfo;
  AssignStyle(ADefaultStyle, ADefaultStyle);
  IsLoaded := False;
  SetButtonState(FVertCount > 1, FHorzCount > 1);
  Result := ShowModal = mrOk;
  if Result then
    CheckChanges;
  if Result and (FChangeItems <> []) and (ADefaultStyle <> nil) then
  begin
    SetStyleInfo(ADefaultStyle);
    if IsChange[itBorderHCenter] then
      ADefaultStyle.Borders[eLeft].AssignRec(FVertBorders[1]);
    if IsChange[itBorderVCenter] then
      ADefaultStyle.Borders[eTop].AssignRec(FHorzBorders[1]);
  end;
end;

function TcxSSStyleDesigner.Execute(const ACells: TRect; ASheet: TcxSSBookSheet): Boolean;
var
  APalette: Pointer;
  AStyle: TcxSSCellStyle;
begin
  FChangeItems := [];
  IsLoaded := True;
  FCells := ACells;
  FSheet := ASheet;
  FHorzCount := ACells.Right - ACells.Left + 1;
  if FHorzCount > 2 then FHorzCount := 2;
  FVertCount := ACells.Bottom - ACells.Top + 1;
  if FVertCount > 2 then FVertCount := 2;
  APalette := TBookAccess(TSheetAccess(ASheet).Owner).Palette;
  TColorBoxAccess(cbxBorderColor).ColorPalette := APalette;
  TColorBoxAccess(cbxPattern).ColorPalette := APalette;
  TColorPanelAccess(cplPatColor).ColorPalette := APalette;
  SetButtonState(FVertCount > 1, FHorzCount > 1);
  SetVertexInfo;
  if ASheet <> nil then
    TCanvasWrapperAccess(FCanvasWrapper).Palette :=
      TBookAccess(TSheetAccess(ASheet).Owner).Palette;
  with ASheet.GetCellObject(ACells.Left, ACells.Top) do
  try
    InitializeInformation(Style);
    AStyle := Style;
    with ASheet.GetCellObject(ACells.Right, ACells.Bottom) do
    try
      AssignStyle(AStyle, Style);
    finally
      Free;
    end;
  finally
    Free;
  end;
  IsLoaded := False;
  Result := ShowModal = mrOk;
  if Result then
    CloseDesigner;
end;

procedure TcxSSStyleDesigner.AssignStyle(AStyle, AStyle2: TcxSSCellStyle);

  function GetValue(const Value, MaxValue, DefValue: Integer): Integer;
  begin
    if Value > MaxValue then
      Result := DefValue
    else
      Result := Value;
  end;

  procedure SetBorderStyle(var ABorder: TcxSSEdgeStyleRec; ABorderStyle: TcxSSEdgeStyle);
  begin
    if ABorderStyle.Style = lsNone then
      ABorder.Style := lsDefault
    else
      ABorder.Style := ABorderStyle.Style;
    ABorder.Color := ABorderStyle.Color;
  end;

begin
  with AStyle do
  begin
    SetBorderStyle(FHorzBorders[0], Borders[eTop]);
    SetBorderStyle(FVertBorders[0], Borders[eLeft]);
    SetBorderStyle(FHorzBorders[1], Borders[eBottom]);
    SetBorderStyle(FVertBorders[1], Borders[eRight]);
    SetBorderStyle(FHorzBorders[FVertCount], AStyle2.Borders[eBottom]);
    SetBorderStyle(FVertBorders[FHorzCount], AStyle2.Borders[eRight]);
    chxWordWrap.Checked := WordBreak;
    cbxHorzAlign.ItemIndex := Integer(HorzTextAlign);
    cbxVertAlign.ItemIndex := Integer(VertTextAlign);
    with FontDialog.Font do
    begin
      Name := AStyle.Font.Name;
      Size := AStyle.Font.Size;
      Style := AStyle.Font.Style;
      Charset := AStyle.Font.Charset;
      if AStyle.Font.FontColor > 55 then
        Color := clBlack
      else
        Color := TCanvasWrapperAccess(FCanvasWrapper).Palette^[AStyle.Font.FontColor];
    end;
    cbxPattern.SelectedBrush := Brush.Style;
    cplPatColor.SelectedColor := GetValue(Brush.BackgroundColor, 55, 57);
    cbxPattern.AutomaticColor := 0;
    cbxPattern.SelectedColor := GetValue(Brush.ForegroundColor, 55, 0);
  end;
end;

procedure TcxSSStyleDesigner.Change(Sender: TObject);
var
  I: Byte;
  AItem: TChangeStyleItemType;
  AKey: Byte;
begin
  if IsLoaded then
    Exit
  else
  begin
    AKey := (Sender as TControl).Tag;
    AItem := TChangeStyleItemType(AKey);
    Include(FChangeItems, AItem);
    case AItem of
      itHorzAlign, itVertAlign, itWordWrap, itFont:
        ppFontPaint.Invalidate;
      itPatternColor, itPatternStyle:
        ppPattern.Invalidate;
      itBorderNone:
      begin
        for I := 0 to 2 do
          SetBorderStyle(FHorzVertex[I], FHorzBorders[I], lsNone, 56);
        for I := 0 to 2 do
          SetBorderStyle(FVertVertex[I], FVertBorders[I], lsNone, 56);
      end;
      itBorderOutline:
      begin
        for I := 0 to 2 do
          if I in [0, FHorzCount] then
            SetBorderStyle(FVertVertex[I], FVertBorders[I], FCurrentLineStyle,
              cbxBorderColor.SelectedColor, True);
        for I := 0 to 2 do
          if I in [0, FVertCount] then
            SetBorderStyle(FHorzVertex[I], FHorzBorders[I], FCurrentLineStyle,
              cbxBorderColor.SelectedColor, True);
      end;
      itBorderInside:
      begin
        if FVertCount = 2 then
          SetBorderStyle(FHorzVertex[1], FHorzBorders[1], FCurrentLineStyle,
            cbxBorderColor.SelectedColor, True);
        if FHorzCount = 2 then
          SetBorderStyle(FVertVertex[1], FVertBorders[1], FCurrentLineStyle,
            cbxBorderColor.SelectedColor, True);
      end;
      itBorderTop:
        SetBorderStyle(FHorzVertex[0], FHorzBorders[0],
          FCurrentLineStyle, cbxBorderColor.SelectedColor);
      itBorderVCenter:
        SetBorderStyle(FHorzVertex[1], FHorzBorders[1],
          FCurrentLineStyle, cbxBorderColor.SelectedColor);
      itBorderBottom:
        SetBorderStyle(FHorzVertex[FVertCount], FHorzBorders[FVertCount],
          FCurrentLineStyle,  cbxBorderColor.SelectedColor);
      itBorderLeft:
        SetBorderStyle(FVertVertex[0], FVertBorders[0],
          FCurrentLineStyle, cbxBorderColor.SelectedColor);
      itBorderHCenter:
        SetBorderStyle(FVertVertex[1], FVertBorders[1],
          FCurrentLineStyle, cbxBorderColor.SelectedColor);
      itBorderRight:
        SetBorderStyle(FVertVertex[FHorzCount], FVertBorders[FHorzCount],
          FCurrentLineStyle, cbxBorderColor.SelectedColor);
    end;
  end;
end;

procedure TcxSSStyleDesigner.CheckChanges;
begin
  if IsChange[itBorderNone] then
    FChangeItems := FChangeItems + [itBorderOutline, itBorderInside];
  if IsChange[itBorderOutline] then
    FChangeItems := FChangeItems + [itBorderTop, itBorderBottom,
      itBorderLeft, itBorderRight];
  if IsChange[itBorderInside] then
    FChangeItems := FChangeItems + [itBorderVCenter, itBorderHCenter];
end;

procedure TcxSSStyleDesigner.CloseDesigner;
var
  I, J: Integer;
begin
  if (ModalResult <> mrOk) or (FChangeItems = []) or (FSheet = nil) then Exit;
  CheckChanges;
  TSheetAccess(FSheet).Owner.BeginUpdate;
  try
    for I := FCells.Left to FCells.Right + 1 do
      for J := FCells.Top to FCells.Bottom + 1 do
      with FSheet.GetCellObject(I, J) do
      try
        if (I <> FCells.Right + 1) and (J <> FCells.Bottom + 1) then
          SetStyleInfo(Style);
        with Style do
        begin
          if J <> (FCells.Bottom + 1) then
          begin
            if (I = FCells.Left) and IsChange[itBorderLeft] then
              Borders[eLeft].AssignRec(FVertBorders[0])
            else
              if (I = FCells.Right + 1) and IsChange[itBorderRight] then
              begin
                if FHorzCount <> 1 then
                  Borders[eLeft].AssignRec(FVertBorders[2])
                else
                  Borders[eLeft].AssignRec(FVertBorders[1])
              end
              else
                if IsChange[itBorderHCenter] and (I <> FCells.Right + 1) and
                  (I <> FCells.Left) then Borders[eLeft].AssignRec(FVertBorders[1]);
          end;
          if I <> (FCells.Right + 1) then
          begin
            if (J = FCells.Top) and IsChange[itBorderTop] then
                Borders[eTop].AssignRec(FHorzBorders[0])
            else
              if (J = FCells.Bottom + 1)and IsChange[itBorderBottom] then
              begin
                if FVertCount <> 1 then
                  Borders[eTop].AssignRec(FHorzBorders[2])
                else
                  Borders[eTop].AssignRec(FHorzBorders[1])
              end
              else
                if IsChange[itBorderVCenter] and (J <> FCells.Bottom + 1)
                  and (J <> FCells.Top) then Borders[eTop].AssignRec(FHorzBorders[1]);
          end;
        end;
      finally
        Free;
      end;
  finally
    TSheetAccess(FSheet).Owner.EndUpdate;
  end;
end;

procedure TcxSSStyleDesigner.FormatChanged(Sender: TObject; StyleValue: Integer);
begin
  if not IsLoaded then
  begin
    Include(FChangeItems, itStyle);
    FCurrentStyle := StyleValue;
  end;
end;

procedure TcxSSStyleDesigner.InitializeInformation(AStyle: TcxSSCellStyle);

  function PosByValue(const AValues: array of TcxSSStyleListBoxItem; Value: Integer): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to Length(AValues) - 1 do
      if AValues[I].ValueType = Value then
      begin
        Result := I;
        Break;
      end;
  end;

begin
  if AStyle <> nil then
  begin
    cbxBorderColor.CanvasWrapper.WindowColor := clBlack;
    cbxBorderColor.AutomaticColor := cxSSDefaultColorValue;
    cbxBorderColor.SelectedColor := AStyle.Borders[eLeft].Color;
    cbxPattern.SelectedBrush := AStyle.Brush.Style;
    cbxPattern.SelectedColor := AStyle.Brush.BackgroundColor;
    cplPatColor.SelectedColor := AStyle.Brush.ForegroundColor;
    cbxHorzAlign.ItemIndex := Byte(AStyle.HorzTextAlign);
    cbxVertAlign.ItemIndex := Byte(AStyle.VertTextAlign);
    chxWordWrap.Checked := AStyle.WordBreak;
    FontDialog.Font.Name := AStyle.Font.Name;
    FontDialog.Font.Charset := AStyle.Font.Charset;
    FontDialog.Font.Style := AStyle.Font.Style;
    FCurrentStyle := TStyleAccess(AStyle).StyleInfo.FormatIndex;
    if FormatIsCurrency(FCurrentStyle) then
    begin
      rbCurrency.Checked := True;
      lbStyleTypes.ItemIndex := PosByValue(CurrencyFormats, FCurrentStyle);
    end
    else
      if FormatIsDateTime(FCurrentStyle) then
      begin
        rbDateTime.Checked := True;
        lbStyleTypes.ItemIndex := PosByValue(DateTimeFormats, FCurrentStyle);
      end
      else
        if FormatIsNumber(FCurrentStyle) then
        begin
          rbNumber.Checked := True;
          lbStyleTypes.ItemIndex := PosByValue(NumberFormats, FCurrentStyle);
        end
        else
          if FCurrentStyle = $0 then
            rbGeneral.Checked := True
          else
            rbText.Checked := True
  end;
end;

procedure TcxSSStyleDesigner.OnKeyDownHandler(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel; 
end;

procedure TcxSSStyleDesigner.SetBorderStyle(AVertex: TRect; var ABorder: TcxSSEdgeStyleRec;
  AStyle: TcxSSEdgeLineStyle; AColor: Word;  SetAlways: Boolean = False);
begin
  InflateRect(AVertex, 5, 5);
  if (AColor = ABorder.Color) and (AStyle = ABorder.Style) and not SetAlways then
    AStyle := lsNone;
  ABorder.Style := AStyle;
  if AStyle <> lsDefault then
    ABorder.Color := AColor
  else
    ABorder.Color := 56;
  ppPaintBorders.InvalidateRect(AVertex, False);
end;

procedure TcxSSStyleDesigner.SetButtonState(IsMultiRow, IsMultiCol: Boolean);
begin
  btnVMiddle.Enabled := IsMultiRow;
  btnMiddle.Enabled := IsMultiCol;
  btnInner.Enabled := IsMultiRow or IsMultiCol;
end;

function TcxSSStyleDesigner.GetIsChange(AItem: TChangeStyleItemType): Boolean;
begin
  Result := AItem in FChangeItems
end;

procedure TcxSSStyleDesigner.SetStyleInfo(AStyle: TcxSSCellStyle);
begin
  with AStyle do
  begin
    if IsChange[itHorzAlign] then
      HorzTextAlign := TcxHorzTextAlign(cbxHorzAlign.ItemIndex);
    if IsChange[itVertAlign] then
      VertTextAlign := TcxVertTextAlign(cbxVertAlign.ItemIndex);
    if IsChange[itWordWrap] then
      WordBreak := chxWordWrap.Checked;
    if IsChange[itFont] then
      with FontDialog.Font do
        Font.AssignInfo(Name, Size, Style, Charset,
          xlsSetColor(Color, TCanvasWrapperAccess(FCanvasWrapper).Palette, 56));
    if IsChange[itPatternStyle] or IsChange[itPatternColor] then
      Brush.AssignInfo(cbxPattern.SelectedBrush,
        cplPatColor.SelectedColor,  cbxPattern.SelectedColor);
    if IsChange[itStyle] then
    begin
      if TStyleAccess(AStyle).StyleInfo.FormatIndex <> FCurrentStyle then
      begin
        TStyleAccess(AStyle).StyleInfo.FormatIndex := FCurrentStyle;
        TStyleAccess(AStyle).DoOnChange(AStyle, siFormat);
      end;
    end;
  end;
end;

procedure TcxSSStyleDesigner.SetVertexInfo;
var
  I: Integer;
begin
  FHeightCellSize := Round((ppPaintBorders.Height - 40) / FVertCount);
  FHorzVertex[0] := Rect(20, 20, ppPaintBorders.Width - 20 - 1, 20);
  for I := 1 to FVertCount do
  begin
    FHorzVertex[I] := FHorzVertex[I - 1];
    OffsetRect(FHorzVertex[I], 0, FHeightCellSize);
  end;
  FWidthCellSize := Round((ppPaintBorders.Width - 40) / FHorzCount);
  FVertVertex[0] := Rect(20, 20, 20, ppPaintBorders.Height - 20);
  for I := 1 to FHorzCount do
  begin
    FVertVertex[I] := FVertVertex[I - 1];
    OffsetRect(FVertVertex[I], FWidthCellSize, 0);
  end;
end;

procedure TcxSSStyleDesigner.drwgLineStyleDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  ALineStyle: TcxSSEdgeLineStyle;
  AVertex: TRect;
begin
  with FCanvasWrapper do
  begin
    BeginPaint((Sender as TDrawGrid).Canvas);
    FillRect(Rect, fsSolid, GetNativeColor(clWindow), GetNativeColor(clWindow));
    if (gdSelected in State) and not (Sender as TWinControl).Focused  then
    begin
      InflateRect(Rect, -1, -1);
      FrameRect(Rect, clBlack);
      InflateRect(Rect, 1, 1);
    end;
    ALineStyle := AStyles[ACol*7 + ARow];
    InflateRect(Rect, -5, -3);
    AVertex.TopLeft := Point(Rect.Left, (Rect.Top + Rect.Bottom) shr 1);
    AVertex.BottomRight := Point(Rect.Right, AVertex.Top + cxPenWidth[ALineStyle] - 1);
    if ALineStyle = lsDefault then
    begin
      SetTextColor(clBlack);
      DrawText(cxGetResourceString(@scxFormatDialogNone2), Rect);
    end
    else
      Line(AVertex, ALineStyle, oHorz, GetNativeColor(clWindow), clBlack);
    EndPaint;
  end;
end;

procedure TcxSSStyleDesigner.FormCreate(Sender: TObject);
begin
  cplPatColor.AutomaticColor := 57;
  cplPatColor.SelectedColor := 57;
  SetItems(cbxHorzAlign, [cxGetResourceString(@scxFormatDialogGeneral), cxGetResourceString(@scxFormatDialogLeft),
    cxGetResourceString(@scxFormatDialogCenter), cxGetResourceString(@scxFormatDialogRight), cxGetResourceString(@scxFormatDialogFill),
    cxGetResourceString(@scxFormatDialogJustify)]);
  SetItems(cbxVertAlign, [cxGetResourceString(@scxFormatDialogTop), cxGetResourceString(@scxFormatDialogCenter),
    cxGetResourceString(@scxFormatDialogBottom), cxGetResourceString(@scxFormatDialogJustify)]);
  SetCaptions([Self, tbsCellStyle, gbStyle, gbStyleSet, lbStyleDescription, rbGeneral,
    rbNumber, rbCurrency, rbDateTime, rbText, btnOk, btnCancel, btnFont,
    bvlBorders, bvlTextAlignment, bvlTextControl,
    bvlItems, bvlCellShading,  chxWordWrap, gbPatSample, gbFontSample,
    gbBorderStyle, lbNone, lbOuter, lbInner, lbPatColor, lbPattern, lbStyle, lbColor,
    lbHorzAlign, lbVertAlign, tbsAlign, tbsBorder, tbsPatterns],
    [cxGetResourceString(@scxFormatDialogFormatCaption), cxGetResourceString(@scxFormatCellStyle), cxGetResourceString(@scxFormatCellStyleType),
    cxGetResourceString(@scxFormatStyleStyleSettings), cxGetResourceString(@scxGeneralStyleDescription),
    cxGetResourceString(@scxFormatStyleGeneral), cxGetResourceString(@scxFormatStyleNumber), cxGetResourceString(@scxFormatStyleCurrency),
    cxGetResourceString(@scxFormatStyleDateTime), cxGetResourceString(@scxFormatStyleText), cxGetResourceString(@scxFormOk),
    cxGetResourceString(@scxFormCancel), cxGetResourceString(@scxFormatDialogFont), cxGetResourceString(@scxFormatDialogAllBorder),
    cxGetResourceString(@scxFormatDialogTextAlignment), cxGetResourceString(@scxFormatDialogTextControl), cxGetResourceString(@scxFormatDialogItems),
    cxGetResourceString(@scxFormatDialogCellShading), cxGetResourceString(@scxFormatDialogWrap), cxGetResourceString(@scxFormatDialogSample),
    cxGetResourceString(@scxFormatDialogSample), cxGetResourceString(@scxFormatDialogLine), cxGetResourceString(@scxFormatDialogNone),
    cxGetResourceString(@scxFormatDialogOutline), cxGetResourceString(@scxFormatDialogInside), cxGetResourceString(@scxFormatDialogColor),
    cxGetResourceString(@scxFormatDialogPattern), cxGetResourceString(@scxFormatDialogStyle), cxGetResourceString(@scxFormatDialogColor),
    cxGetResourceString(@scxFormatDialogHorzAlign), cxGetResourceString(@scxFormatDialogVertAlign), cxGetResourceString(@scxFormatDialogText),
    cxGetResourceString(@scxFormatDialogBorder), cxGetResourceString(@scxFormatDialogPatterns)]);
end;

procedure TcxSSStyleDesigner.OnAlignmentChange(Sender: TObject);
begin
  Change(Sender);
end;

procedure TcxSSStyleDesigner.OnbtnFontClick(Sender: TObject);
begin
  if FontDialog.Execute then
  begin
    ppFontPaint.Font.Assign(FontDialog.Font);
    OnAlignmentChange(Sender)
  end;
end;

procedure TcxSSStyleDesigner.OnClickBorderButtons(Sender: TObject);
begin
  Change(Sender);
end;

procedure TcxSSStyleDesigner.OnPatternChange(Sender: TObject);
begin
  Change(Sender);
end;

procedure TcxSSStyleDesigner.ppPaintBordersPaint(Sender: TcxPaintPanel);

  function InflateVertex(const ARect: TRect; AStyle: TcxSSEdgeLineStyle;
    IsHorz: Boolean): TRect;
  begin
     Result := ARect;
     if IsHorz then
     begin
       OffsetRect(Result, 0, -(cxPenWidth[AStyle] - 1));
       if cxPenWidth[FVertBorders[0].Style] = 3 then
         Dec(Result.Left);
       if cxPenWidth[FVertBorders[FHorzCount].Style] = 3 then
         Inc(Result.Right);
       Result.Bottom := Result.Top + cxPenWidth[AStyle] - 1;
     end
     else
     begin
       OffsetRect(Result, -(cxPenWidth[AStyle] - 1), 0);
       if cxPenWidth[FHorzBorders[0].Style] = 3 then
         Dec(Result.Top);
       if cxPenWidth[FHorzBorders[FVertCount].Style] = 3 then
         Inc(Result.Bottom);
       Result.Right := Result.Left + cxPenWidth[AStyle] - 1;
     end;
  end;

var
  I, J: Integer;
  ARect: TRect;
begin
  FCanvasWrapper.BeginPaint(Sender.Canvas);
  try
    FCanvasWrapper.FillRect(Sender.ClientRect, cbxPattern.SelectedBrush,
      cplPatColor.SelectedColor, cbxPattern.SelectedColor, False);
    FCanvasWrapper.SelectFont(Font);
    FCanvasWrapper.SetTextColor(clBlack);
    for I := 0 to FHorzCount - 1 do
      for J := 0 to FVertCount - 1 do
      begin
        ARect := Rect(I * FWidthCellSize, J * FHeightCellSize,
          (I + 1) * FWidthCellSize, J * FHeightCellSize  + FHeightCellSize);
        OffsetRect(ARect, 20, 20);
        FCanvasWrapper.DrawText(cxGetResourceString(@scxFormatDialogTextStr), ARect);
      end;
     for I := 0 to FVertCount do
     with FHorzBorders[I] do
     begin
       ARect := InflateVertex(FHorzVertex[I], Style, True);
       FCanvasWrapper.Line(ARect, Style, oHorz,
         cplPatColor.SelectedColor, Color, False);
       ARect.Bottom := ARect.Top;
       OffsetRect(ARect, 0, 2);
       if cxPenWidth[Style] = 3 then
       begin
         Inc(ARect.Left);
         if I = 0 then
           Dec(ARect.Top)
         else
           if I = FVertCount then
             Inc(ARect.Bottom);
         FCanvasWrapper.ExcludeClipRect(ARect);
       end;
     end;
    for I := 0 to FHorzCount do
     with FVertBorders[I] do
       FCanvasWrapper.Line([InflateVertex(FVertVertex[I], Style, False)], Style,
         oVert, cplPatColor.SelectedColor, Color, False);
  finally
    FCanvasWrapper.EndPaint;
  end;
end;

procedure TcxSSStyleDesigner.ppPaintBordersMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function HitOnBorder(ARect: TRect; IsHorizontal: Boolean): Boolean;
  begin
    if IsHorizontal then
      InflateRect(ARect, 0, 5)
    else
      InflateRect(ARect, 5, 1);
    Result := PtInRect(ARect, Point(X, Y));
  end;

var
  I: Integer;
  AChange: TChangeStyleItemsType;
begin
  AChange := [];
  for I := 0 to FVertCount do
   if HitOnBorder(FHorzVertex[I], True) then
   begin
     SetBorderStyle(FHorzVertex[I], FHorzBorders[I],
       FCurrentLineStyle, cbxBorderColor.SelectedColor);
     if I = 0 then
       Include(AChange, itBorderTop)
     else
       if I = FVertCount then
         Include(AChange, itBorderBottom)
       else
         Include(AChange, itBorderVCenter)
   end;
  for I := 0 to FHorzCount do
   if HitOnBorder(FVertVertex[I], False) then
   begin
     SetBorderStyle(FVertVertex[I], FVertBorders[I],
       FCurrentLineStyle, cbxBorderColor.SelectedColor);
     if I = 0 then
       Include(AChange, itBorderLeft)
     else
       if I = FHorzCount then
         Include(AChange, itBorderRight)
       else
         Include(AChange, itBorderHCenter);
   end;
   if AChange <> [] then
     FChangeItems := FChangeItems + AChange;
end;

procedure TcxSSStyleDesigner.ppFontPaintPaint(Sender: TcxPaintPanel);
var
  ATextParams: TcxTextParameters;
begin
  with FCanvasWrapper do
  begin
    BeginPaint(Sender.Canvas);
    cxDrawThemeParentBackground(Sender, Sender.Canvas, Sender.ClientRect);
    SelectFont(FontDialog.Font);
    SetTextColor(clBlack);
    CalculateTextExtents(cxGetResourceString(@scxFormatDialogSampleText), Sender.ClientRect,
      TcxHorzTextAlign(cbxHorzAlign.ItemIndex), TcxVertTextAlign(cbxVertAlign.ItemIndex),
      chxWordWrap.Enabled, ATextParams);
    ExDrawText(Sender.ClientRect, ATextParams);
    EndPaint;
  end;
end;

procedure TcxSSStyleDesigner.ppPatternPaint(Sender: TcxPaintPanel);
begin
  FCanvasWrapper.BeginPaint(Sender.Canvas);
  try
    FCanvasWrapper.FillRect(Sender.ClientRect, cbxPattern.SelectedBrush,
      cplPatColor.SelectedColor, cbxPattern.SelectedColor, False);
  finally
    FCanvasWrapper.EndPaint;
  end;
end;

procedure TcxSSStyleDesigner.drwgLineStyleSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := True;
  FCurrentLineStyle := AStyles[ACol*7 + ARow];
end;

procedure TcxSSStyleDesigner.rbStyleTypeClick(Sender: TObject);
var
  AKey: Integer;
begin
  AKey := (Sender as TControl).Tag;
  if not IsLoaded then
    Include(FChangeItems, itStyle);
  if AKey in [0, 4] then
    lbStyleTypes.AssignItems([]);
  case AKey of
    0:
      begin
        FCurrentStyle := 0;
        lbStyleDescription.Caption := cxGetResourceString(@scxGeneralStyleDescription);
      end;
    1:
      begin
        lbStyleTypes.AssignItems(NumberFormats);
        lbStyleDescription.Caption := cxGetResourceString(@scxNumberStyleDescription);
      end;
    2:
      begin
        lbStyleTypes.AssignItems(CurrencyFormats);
        lbStyleDescription.Caption := cxGetResourceString(@scxCurrencyStyleDescription);
      end;
    3:
      begin
        lbStyleTypes.AssignItems(DateTimeFormats);
        lbStyleDescription.Caption := cxGetResourceString(@scxDateTimeStyleDescription);
      end;
    4:
      begin
        FCurrentStyle := $31;
        lbStyleDescription.Caption := cxGetResourceString(@scxTextStyleDescription);
      end;
  end;
end;

end.
 
