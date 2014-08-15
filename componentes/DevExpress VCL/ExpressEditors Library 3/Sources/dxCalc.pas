
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express Calculator                                          }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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

unit dxCalc;

interface

{$I dxEdVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Clipbrd, dxCntner;

const
  dxDefCalcPrecision     = 13;
  // Size
  dxMinCalcFontSize      = 8;
  dxCalcMinBoldFontSize  = 10;
  dxMinCalcBtnWidth      = 28;
  dxMinCalcBtnHeight     = 22;
  dxMinCalcLargeBtnWidth = Integer(Trunc(1.7*dxMinCalcBtnWidth));
  dxMinCalcXOfs          = 4;
  dxMinCalcYOfs          = 4;
  dxMinCalcWidth         = (dxMinCalcXOfs+dxMinCalcBtnWidth)*6+dxMinCalcXOfs*3+3;
  dxMinCalcHeight        = (dxMinCalcYOfs+dxMinCalcBtnHeight)*5+dxMinCalcYOfs+3;
  // String resource
  dx_Error               = 38951;

var
  sdxCalcError: string;  // 'Error'

type
TdxCalcState = (csFirst, csValid, csError);
TdxButtonStyle = (bsStandard, bsFlat, bsExtraFlat);
TdxCalcButtonKind =
   (cbBack, cbCancel, cbClear,
    cbMC, cbMR, cbMS, cbMP,
    cbNum0, cbNum1, cbNum2, cbNum3, cbNum4, cbNum5, cbNum6, cbNum7, cbNum8, cbNum9,
    cbSign, cbDecimal,
    cbDiv, cbMul, cbSub, cbAdd,
    cbSqrt, cbPercent, cbRev, cbEqual, cbNone);

TdxButtonInfo = record
  Kind : TdxCalcButtonKind;
  Text : String[4];
  FontColor : TColor;
  BtnRect : TRect;
  Down : Boolean;
  Grayed : Boolean;
end;

TCalcButtons = array [TdxCalcButtonKind] of TdxButtonInfo;

TdxCalcButtonClick = procedure(Sender: TObject; var ButtonKind : TdxCalcButtonKind) of object;
TdxCalcGetEditValue = procedure(Sender: TObject; var Value : String) of object;
TdxCalcSetEditValue = procedure(Sender: TObject; const Value : String) of object;

TCustomdxCalculator = class(TdxInplacePopupControl)
private
  {calc style}
  FAutoFontSize : Boolean;
  FBeepOnError: Boolean;
  FButtonStyle : TdxButtonStyle;
  FBorderStyle : TBorderStyle;
  FButtonFrameVisible : Boolean;
  FFocusRectVisible : Boolean;
  {calc size}
  FCalcFontSize      : Integer;
  FCalcBtnWidth      : Integer;
  FCalcBtnHeight     : Integer;
  FCalcLargeBtnWidth : Integer;
  FCalcXOfs          : Integer;
  FCalcYOfs          : Integer;
  FCalcWidth         : Integer;
  FCalcHeight        : Integer;
  {math}
  FMemory : Extended;
  FOperator: TdxCalcButtonKind;
  FOperand: Extended;
  FPrecision: Byte;
  FStatus: TdxCalcState;
  {control}
  FButtons : TCalcButtons;
  FActiveButton : TdxCalcButtonKind;
  FDownButton : TdxCalcButtonKind;
  FPressedButton : TdxCalcButtonKind;
  FTracking: Boolean;
  // events
  FOnDisplayChange: TNotifyEvent;
  FOnButtonClick: TdxCalcButtonClick;
  FOnError: TNotifyEvent;
  FOnResult: TNotifyEvent;

  function GetDisplay: Extended;
  procedure SetDisplay(Value: Extended);
  function GetMemory: Extended;

  procedure SetAutoFontSize(Value : Boolean);
  procedure SetBorderStyle(Value: TBorderStyle);
  procedure SetButtonStyle(Value: TdxButtonStyle);
  procedure SetButtonFrameVisible(Value: Boolean);
  procedure SetFocusRectVisible(Value : Boolean);
  procedure FontChanged(Sender: TObject);

  procedure StopTracking;
  procedure TrackButton(X,Y: Integer);
  procedure InvalidateButton(ButtonKind : TdxCalcButtonKind);
  procedure DoButtonDown(ButtonKind : TdxCalcButtonKind);
  procedure DoButtonUp(ButtonKind : TdxCalcButtonKind);
  procedure Error;
  procedure CheckFirst;
  procedure Clear;
  procedure CalcSize(AWidth, AHeight : Integer);
  procedure UpdateMemoryButtons;
  procedure InvalidateMemoryButtons;
  procedure ResetOperands;

  // messages
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
  procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  procedure WMSize(var Msg: TWMSize); message WM_SIZE;
  procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
  procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
protected
  IsPopup : Boolean;
  procedure Paint; override;
  procedure CreateParams(var Params: TCreateParams); override;
  procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
  procedure KeyUp(var Key: Word; Shift: TShiftState); override;

  procedure CreateLayout;
  procedure ButtonClick(ButtonKind : TdxCalcButtonKind);
  // for link with EditControl
  function GetEditValue: String; virtual;
  procedure SetEditValue(const Value: String); virtual;

  property Color default clBtnFace;
  property ParentColor default False;
  property Ctl3D default False;
  property ParentCtl3D default False;
  property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;

  property AutoFontSize : Boolean read FAutoFontSize write SetAutoFontSize default True;
  property BeepOnError: Boolean read FBeepOnError write FBeepOnError default True;
  property ButtonStyle : TdxButtonStyle read FButtonStyle write SetButtonStyle default bsStandard;
  property ShowButtonFrame : Boolean read FButtonFrameVisible write SetButtonFrameVisible default False;
  property ShowFocusRect : Boolean read FFocusRectVisible write SetFocusRectVisible default True;

  property Precision: Byte read FPrecision write FPrecision default dxDefCalcPrecision;
  property EditValue : String read GetEditValue write SetEditValue;

  property OnDisplayChange: TNotifyEvent read FOnDisplayChange write FOnDisplayChange;
  property OnButtonClick: TdxCalcButtonClick read FOnButtonClick write FOnButtonClick;
  property OnError: TNotifyEvent read FOnError write FOnError;
  property OnResult: TNotifyEvent read FOnResult write FOnResult;
public
  constructor Create(AOwner: TComponent); override;

  function GetButtonKindAt(X, Y : Integer) : TdxCalcButtonKind;
  function GetButtonKindChar(Ch : Char) : TdxCalcbuttonKind;
  function GetButtonKindKey(Key: Word; Shift: TShiftState) : TdxCalcbuttonKind;
  procedure CopyToClipboard;
  procedure PasteFromClipboard;

  property Memory: Extended read GetMemory;
  property Value: Extended read GetDisplay write SetDisplay;
published
  property TabStop default True;
end;

TdxCalculator = class(TCustomdxCalculator)
private
  FAssociate : TWinControl;
  FOnGetEditValue : TdxCalcGetEditValue;
  FOnSetEditValue : TdxCalcSetEditValue;
  procedure SetAssociate(Value : TWinControl);
protected
  procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  function GetEditValue: String; override;
  procedure SetEditValue(const Value: String); override;
published
  property BorderStyle;
  property Ctl3D;
  property DragCursor;
  property DragMode;
  property Enabled;
  property Font;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property ShowHint;
  property TabOrder;
  property TabStop;
  property Visible;

  property OnClick;
  property OnEnter;
  property OnExit;
  property OnKeyDown;
  property OnKeyPress;
  property OnKeyUp;
  property OnMouseDown;
  property OnMouseMove;
  property OnMouseUp;
  property OnStartDrag;
  property OnDragDrop;
  property OnDragOver;
  property OnEndDrag;

  property Associate : TWinControl read FAssociate write SetAssociate;
  property AutoFontSize;
  property BeepOnError;
  property ButtonStyle;
  property ShowButtonFrame;
  property ShowFocusRect;
  property Precision;

  property OnDisplayChange;
  property OnButtonClick;
  property OnError;
  property OnResult;
  property OnGetEditValue : TdxCalcGetEditValue read FOnGetEditValue write FOnGetEditValue;
  property OnSetEditValue : TdxCalcSetEditValue read FOnSetEditValue write FOnSetEditValue;
end;

{TdxCalcDisplay}
TdxCalcDisplay = class(TCustomControl)
private
  procedure AdjustHeight;
  procedure WMSize(var Msg: TWMSize); message WM_SIZE;
  procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
protected
  procedure CreateParams(var Params: TCreateParams); override;
  procedure Paint; override;
public
  constructor Create(AOwner: TComponent); override;
published
  property Color default clWindow;
  property Font;
  property ParentColor default False;
  property TabStop default True;
  property Text;
end;

implementation

{$R dxClcStr.res}

const
  DrawBitmap : TBitmap = nil;
  ResultButtons    = [cbEqual, cbPercent];
  RepeatButtons    = [cbBack];
  OperationButtons = [cbAdd, cbSub, cbMul, cbDiv];
  BorderWidth = 4;

function Max(X, Y: Integer): Integer;
begin
  Result := Y;
  if X > Y then Result := X;
end;

procedure DrawButton(ACanvas : TCanvas; ARect : TRect; const AText : String;
   AButtonStyle: TdxButtonStyle; AFlat : Boolean; AFontColor : TColor;
   ADown : Boolean; AFrame : Boolean; AEnabled : Boolean; AFocused : Boolean;
   AGrayed : Boolean);
const AlignFlag : Integer = DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX or
                            DT_VCENTER or DT_SINGLELINE;
      DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
      FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var R, B : TRect;
    DrawFlags: Integer;
    Ofs : Integer;
begin
  with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
  begin                     { brush origin tics in painting / scrolling.    }
    Width := Max(Width, Right - Left);
    Height := Max(Height, Bottom - Top);
    R := Rect(2, 2, Right - Left - 2, Bottom - Top - 2);
    B := Rect(0, 0, Right - Left, Bottom - Top);
  end;
  with DrawBitmap.Canvas do
  begin
    Font := ACanvas.Font;
    if AGrayed then
    begin
      AFontColor := clBtnShadow;
      ADown := False;
    end;
    Font.Color := AFontColor;
    Brush := ACanvas.Brush;
    Brush.Style := bsSolid;
    FillRect(B);
    {Edge}
    if AButtonStyle = bsStandard then
    begin
      DrawFlags := DFCS_BUTTONPUSH;
      if ADown then
        DrawFlags := DrawFlags or DFCS_PUSHED;
      DrawFrameControl(Handle, B, DFC_BUTTON, DrawFlags);
    end
    else
    begin
      if not AFlat or ADown then
        DrawEdge(Handle, B, DownStyles[ADown], BF_RECT);
    end;
    {Text}
    SetBkMode(Handle, TRANSPARENT);
    if ADown then Ofs := 2 else Ofs := 0;
    R.Left := R.Left + Ofs;
    R.Top := R.Top + Ofs;
    if not AEnabled then
    begin
      Font.Color := clBtnHighlight;
      OffsetRect(R, 1, 1);
      DrawText(Handle, PChar(AText), Length(AText), R, AlignFlag);
      OffsetRect(R, -1, -1);
      Font.Color := clBtnShadow;
      DrawText(Handle, PChar(AText), Length(AText), R, AlignFlag);
    end
    else
      DrawText(Handle, PChar(AText), Length(AText), R, AlignFlag);
    {Frame}
    R := B;
    InflateRect(R, -3, -3);
    Pen.Color := clBtnShadow;
    if AFrame then
    with R do
    begin
      OffsetRect(R, Ofs div 2, Ofs div 2);
      Brush.Style := bsClear;
      RoundRect(Left, Top , Right, Bottom, (Bottom-Top)-4, (Bottom-Top)-4);
    end;
  end;
  ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
  if AFocused then
  begin
    InflateRect(ARect, -3, -3);
    ACanvas.Brush.Style := bsSolid;
    ACanvas.DrawFocusRect(ARect);
  end;
end;

{TCustomdxCalculator}
constructor TCustomdxCalculator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {init size variables}
  FCalcFontSize      := dxMinCalcFontSize;
  FCalcBtnWidth      := dxMinCalcBtnWidth;
  FCalcBtnHeight     := dxMinCalcBtnHeight;
  FCalcLargeBtnWidth := dxMinCalcLargeBtnWidth;
  FCalcXOfs          := dxMinCalcXOfs;
  FCalcYOfs          := dxMinCalcYOfs;
  FCalcWidth         := dxMinCalcWidth;
  FCalcHeight        := dxMinCalcHeight;
  {default size}
  Width := FCalcWidth;
  Height := FCalcHeight;
  {style}
  ControlStyle := [csCaptureMouse, csOpaque];
  if NewStyleControls then
    ControlStyle := ControlStyle else
    ControlStyle := ControlStyle + [csFramed];
  Color := clBtnFace;
  Ctl3d := False;
  ParentColor := False;
  ParentCtl3d := False;
  TabStop := True;
  FAutoFontSize := True;
  FBorderStyle := bsNone;
  FBeepOnError := True;
  FDownButton := cbNone;
  FActiveButton := cbNone;
  FPressedButton := cbNone;
  FFocusRectVisible := True;
  FOperator := cbEqual;
  FPrecision := dxDefCalcPrecision;
  Font.OnChange := FontChanged;
  CreateLayout;
end;

function TCustomdxCalculator.GetButtonKindAt(X, Y : Integer) : TdxCalcButtonKind;
var i : TdxCalcButtonKind;
begin
  Result := cbNone;
  for i := cbBack to cbEqual do
    if PtInRect(FButtons[i].BtnRect, Point(X, Y)) then
    begin
      Result := i;
      Exit;
    end;
end;

// protected
procedure TCustomdxCalculator.Paint;
var CRect : TRect;
    i : TdxCalcButtonKind;
    AFocused : Boolean;
    Rgn: HRGN;

  procedure ExcludeRect(var MainRgn: HRGN; R: TRect);
  var
    TmpRgn: HRGN;
  begin
    TmpRgn := CreateRectRgnIndirect(R);
    CombineRgn(MainRgn, TmpRgn, MainRgn, RGN_XOR);
    DeleteObject(TmpRgn);
  end;
begin
  if not HandleAllocated then Exit;
  CRect := ClientRect;
  Rgn := CreateRectRgnIndirect(CRect);
  AFocused := Windows.GetFocus = Handle;
  {Draw buttons}
  with Canvas do
  begin
    Font := Self.Font;
    if AutoFontSize then
    begin
      Font.Size := FCalcFontSize;
      if Font.Size >= dxCalcMinBoldFontSize then Font.Style := [fsBold]
      else Font.Style := [];
    end;
    Brush.Color := Self.Color;
  end;
  for i := cbBack to cbEqual do
    with FButtons[i] do
    if RectVisible(Canvas.Handle, BtnRect) then
    begin
      DrawButton(Canvas, BtnRect, Text, ButtonStyle,
        (ButtonStyle = bsExtraFlat) and (FActiveButton <> i) {AFlat},
        FontColor, Down, ShowButtonFrame, Enabled,
        ShowFocusRect and AFocused and (i=cbEqual),
        Grayed);
      ExcludeRect(Rgn, BtnRect);
    end;
  {Fill Background}
  Canvas.Brush.Color := Self.Color;
  PaintRgn(Canvas.Handle, Rgn);
  DeleteObject(Rgn);
end;

procedure TCustomdxCalculator.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP or WS_CLIPCHILDREN;
    WindowClass.Style := WindowClass.Style and not CS_DBLCLKS;
    if FIsPopupControl then
      Style := Style and not WS_BORDER
    else  
      if FBorderStyle = bsSingle then
        if NewStyleControls and Ctl3D then
        begin
          Style := Style and not WS_BORDER;
          ExStyle := ExStyle or WS_EX_CLIENTEDGE;
        end
        else
          Style := Style or WS_BORDER;
  end;
end;

procedure TCustomdxCalculator.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ButtonKind : TdxCalcButtonkind;
begin
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) and
    not IsPopup then SetFocus;

  ButtonKind := GetButtonKindAt(X, Y);
  if (Button = mbLeft) and
     (ButtonKind <> cbNone) then
  begin
    MouseCapture := True;
    FTracking := True;
    FDownButton := ButtonKind;
    TrackButton(X, Y);
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomdxCalculator.MouseMove(Shift: TShiftState; X, Y: Integer);
var OldButton : TdxCalcButtonKind;
begin
  if FTracking then
    TrackButton(X, Y)
  else
  if (ButtonStyle = bsExtraFlat) and Enabled and not Dragging then
  begin
    OldButton := FActiveButton;
    FActiveButton := GetButtonKindAt(X, Y);
    if FActiveButton <> OldButton then
    begin
      InvalidateButton(OldButton);
      InvalidateButton(FActiveButton);
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomdxCalculator.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := (FDownButton <> cbNone) and FButtons[FDownButton].Down;
  StopTracking;
  if (Button = mbLeft) and WasPressed then ButtonClick(FDownButton);
  FDownButton := cbNone;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomdxCalculator.KeyDown(var Key: Word; Shift: TShiftState);
var NewButton, OldButton : TdxCalcButtonKind;
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_INSERT) then
    if (Shift = [ssShift]) then PasteFromClipboard
    else if (Shift = [ssCtrl]) then CopyToClipboard;

  OldButton := FPressedButton;
  NewButton := GetButtonKindKey(Key, Shift);
  if NewButton <> cbNone then
  if OldButton <> NewButton then
  begin
    DoButtonUp(OldButton);
    FPressedButton := NewButton;
    DoButtonDown(FPressedButton);
  end;
end;

procedure TCustomdxCalculator.KeyPress(var Key: Char);
var NewButton, OldButton : TdxCalcButtonKind;
begin
  inherited KeyPress(Key);
  if (Key = ^V) then PasteFromClipboard
  else if (Key = ^C) then CopyToClipboard;

  OldButton := FPressedButton;
  NewButton := GetButtonKindChar(Key);
  if NewButton <> cbNone then
  if OldButton <> NewButton then
  begin
    DoButtonUp(OldButton);
    FPressedButton := NewButton;
    DoButtonDown(FPressedButton);
  end;
  if FPressedButton in RepeatButtons {cbBack} then ButtonClick(FPressedButton);
end;

procedure TCustomdxCalculator.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  DoButtonUp(FPressedButton);
end;

procedure TCustomdxCalculator.DoButtonDown(ButtonKind : TdxCalcButtonKind);
begin
  if ButtonKind <> cbNone then
  begin
    FButtons[ButtonKind].Down := True;
    InvalidateButton(ButtonKind);
    Update;
    if not (ButtonKind in RepeatButtons) {cbBack} then ButtonClick(ButtonKind);
  end;
end;

procedure TCustomdxCalculator.DoButtonUp(ButtonKind : TdxCalcButtonKind);
begin
  if ButtonKind <> cbNone then
  begin
    FButtons[ButtonKind].Down := False;
    InvalidateButton(ButtonKind);
    FPressedButton := cbNone;
    Update;
  end;
end;

function TCustomdxCalculator.GetEditValue: String;
begin
  Result := '';
end;

procedure TCustomdxCalculator.SetEditValue(const Value: String);
begin
end;

procedure TCustomdxCalculator.CreateLayout;
const
  BtnCaptions : array [cbBack..cbEqual] of String[4] = ('Back', 'CE', 'C',
    'MC', 'MR', 'MS', 'M+',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '+/-', ',',
    '/', '*', '-', '+',
    'sqrt', '%', '1/x', '=');
  BtnColors : array [cbBack..cbEqual] of TColor = (clMaroon, clMaroon, clMaroon,
    clRed, clRed, clRed, clRed,
    clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue, clBlue,
    clBlue, clBlue,
    clRed, clRed, clRed, clRed,
    clNavy, clNavy, clNavy, clRed);
var i : TdxCalcButtonKind;
    X : Integer;
begin
  for i := cbBack to cbEqual do
  begin
    FButtons[i].Kind := i;
    FButtons[i].Text := BtnCaptions[i];
    if i = cbDecimal then FButtons[i].Text := SysUtils.DecimalSeparator
    else  FButtons[i].Text := BtnCaptions[i];
    FButtons[i].FontColor := BtnColors[i];
    FButtons[i].BtnRect := Rect(0, 0, 0, 0);
    FButtons[i].Down := False;
    FButtons[i].Grayed := False;
  end;
  {coord buttons}
  FButtons[cbMC].BtnRect := Rect(FCalcXOfs,
                                 (FCalcYOfs+FCalcBtnHeight)+FCalcYOfs,
                                 FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*2);
  FButtons[cbMR].BtnRect := Rect(FCalcXOfs,
                                 (FCalcYOfs+FCalcBtnHeight)*2+FCalcYOfs,
                                 FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*3);
  FButtons[cbMS].BtnRect := Rect(FCalcXOfs,
                                 (FCalcYOfs+FCalcBtnHeight)*3+FCalcYOfs,
                                 FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*4);
  FButtons[cbMP].BtnRect := Rect(FCalcXOfs,
                                 (FCalcYOfs+FCalcBtnHeight)*4+FCalcYOfs,
                                 FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*5);
  X := FCalcXOfs+FCalcBtnWidth + FCalcXOfs + 4;
  {7, 8, 9, /, sqrt}
  FButtons[cbNum7].BtnRect := Rect(X+FCalcXOfs,
                                   (FCalcYOfs+FCalcBtnHeight)+FCalcYOfs,
                                   X+FCalcXOfs+FCalcBtnWidth,
                                   (FCalcYOfs+FCalcBtnHeight)*2);
  FButtons[cbNum8].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth),
                                   (FCalcYOfs+FCalcBtnHeight)+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*2,
                                   (FCalcYOfs+FCalcBtnHeight)*2);
  FButtons[cbNum9].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*2,
                                   (FCalcYOfs+FCalcBtnHeight)+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*3,
                                   (FCalcYOfs+FCalcBtnHeight)*2);
  FButtons[cbDiv].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*3,
                                   (FCalcYOfs+FCalcBtnHeight)+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*4,
                                   (FCalcYOfs+FCalcBtnHeight)*2);
  FButtons[cbSqrt].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*4,
                                   (FCalcYOfs+FCalcBtnHeight)+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*5,
                                   (FCalcYOfs+FCalcBtnHeight)*2);

  {4, 5, 6, *, %}
  FButtons[cbNum4].BtnRect := Rect(X+FCalcXOfs,
                                  (FCalcYOfs+FCalcBtnHeight)*2+FCalcYOfs,
                                   X+FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*3);
  FButtons[cbNum5].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth),
                                  (FCalcYOfs+FCalcBtnHeight)*2+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*2,
                                 (FCalcYOfs+FCalcBtnHeight)*3);
  FButtons[cbNum6].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*2,
                                  (FCalcYOfs+FCalcBtnHeight)*2+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*3,
                                 (FCalcYOfs+FCalcBtnHeight)*3);
  FButtons[cbMul].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*3,
                                  (FCalcYOfs+FCalcBtnHeight)*2+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*4,
                                 (FCalcYOfs+FCalcBtnHeight)*3);
  FButtons[cbPercent].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*4,
                                  (FCalcYOfs+FCalcBtnHeight)*2+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*5,
                                 (FCalcYOfs+FCalcBtnHeight)*3);

  {1, 2, 3, -, 1/x}
  FButtons[cbNum1].BtnRect := Rect(X+FCalcXOfs,
                                  (FCalcYOfs+FCalcBtnHeight)*3+FCalcYOfs,
                                   X+FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*4);
  FButtons[cbNum2].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth),
                                  (FCalcYOfs+FCalcBtnHeight)*3+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*2,
                                 (FCalcYOfs+FCalcBtnHeight)*4);
  FButtons[cbNum3].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*2,
                                  (FCalcYOfs+FCalcBtnHeight)*3+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*3,
                                 (FCalcYOfs+FCalcBtnHeight)*4);
  FButtons[cbSub].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*3,
                                  (FCalcYOfs+FCalcBtnHeight)*3+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*4,
                                 (FCalcYOfs+FCalcBtnHeight)*4);
  FButtons[cbRev].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*4,
                                  (FCalcYOfs+FCalcBtnHeight)*3+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*5,
                                 (FCalcYOfs+FCalcBtnHeight)*4);

  {0, +/-, ., +, =}
  FButtons[cbNum0].BtnRect := Rect(X+FCalcXOfs,
                                  (FCalcYOfs+FCalcBtnHeight)*4+FCalcYOfs,
                                   X+FCalcXOfs+FCalcBtnWidth,
                                 (FCalcYOfs+FCalcBtnHeight)*5);
  FButtons[cbSign].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth),
                                  (FCalcYOfs+FCalcBtnHeight)*4+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*2,
                                 (FCalcYOfs+FCalcBtnHeight)*5);
  FButtons[cbDecimal].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*2,
                                  (FCalcYOfs+FCalcBtnHeight)*4+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*3,
                                 (FCalcYOfs+FCalcBtnHeight)*5);
  FButtons[cbAdd].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*3,
                                  (FCalcYOfs+FCalcBtnHeight)*4+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*4,
                                 (FCalcYOfs+FCalcBtnHeight)*5);
  FButtons[cbEqual].BtnRect := Rect(X+FCalcXOfs+(FCalcXOfs+FCalcBtnWidth)*4,
                                  (FCalcYOfs+FCalcBtnHeight)*4+FCalcYOfs,
                                   X+(FCalcXOfs+FCalcBtnWidth)*5,
                                 (FCalcYOfs+FCalcBtnHeight)*5);
  {C}
  FButtons[cbClear].BtnRect := FButtons[cbEqual].BtnRect;
  FButtons[cbClear].BtnRect.Left := FButtons[cbClear].BtnRect.Right - FCalcLargeBtnWidth;
  FButtons[cbClear].BtnRect.Top := FCalcYOfs;
  FButtons[cbClear].BtnRect.Bottom := FCalcYOfs + FCalcBtnHeight;
  {CE}
  FButtons[cbCancel].BtnRect := FButtons[cbClear].BtnRect;
  FButtons[cbCancel].BtnRect.Right := FButtons[cbClear].BtnRect.Left - FCalcYOfs;
  FButtons[cbCancel].BtnRect.Left := FButtons[cbCancel].BtnRect.Right - FCalcLargeBtnWidth;
  {Back}
  FButtons[cbBack].BtnRect := FButtons[cbCancel].BtnRect;
  FButtons[cbBack].BtnRect.Right := FButtons[cbBack].BtnRect.Left - FCalcYOfs;
  FButtons[cbBack].BtnRect.Left := FButtons[cbBack].BtnRect.Right - FCalcLargeBtnWidth;
  // ResetOperands;
  ResetOperands;
  // Update Memory display
  UpdateMemoryButtons;
end;

//private
procedure TCustomdxCalculator.ResetOperands;
begin
  FOperator := cbEqual;
  FStatus := csFirst;
  FMemory := 0.0;
end;

procedure TCustomdxCalculator.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxCalculator.SetButtonStyle(Value: TdxButtonStyle);
begin
  if FButtonStyle <> Value then
  begin
    FButtonStyle := Value;
    Invalidate;
  end;
end;

procedure TCustomdxCalculator.SetButtonFrameVisible(Value : Boolean);
begin
  if FButtonFrameVisible <> Value then
  begin
    FButtonFrameVisible := Value;
    Invalidate;
  end;
end;

procedure TCustomdxCalculator.SetFocusRectVisible(Value : Boolean);
begin
  if FFocusRectVisible <> Value then
  begin
    FFocusRectVisible := Value;
    Invalidate;
  end;
end;

procedure TCustomdxCalculator.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  inherited;
  Message.Result := 1;
end;

procedure TCustomdxCalculator.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TCustomdxCalculator.CalcSize(AWidth, AHeight : Integer);
var
  h, NearHeight, d, dMin : Integer;

  function CalcHeight(ABtnHeight:Integer):Integer;
  var FYOfs : Integer;
  begin
    FYOfs := MulDiv(ABtnHeight, dxMinCalcYOfs, dxMinCalcBtnHeight);
    Result := (FYOfs+ABtnHeight)*5+FYOfs;
  end;
begin
  h := MulDiv(AWidth, dxMinCalcHeight, dxMinCalcWidth);
  if AHeight > h then AHeight := h;
  {Calculate nearest FCalcHeight }
  h := dxMinCalcBtnHeight;
  NearHeight := h;
  dMin := AHeight;
  while True do
  begin
    d := abs(CalcHeight(h) - AHeight);
    if d < dMin then
    begin
      dMin := d;
      NearHeight := h;
    end
    else
      Break;
    inc(h);
  end;

  FCalcBtnHeight     := NearHeight;
  FCalcBtnWidth      := MulDiv(FCalcBtnHeight, dxMinCalcBtnWidth, dxMinCalcBtnHeight);
  FCalcYOfs          := MulDiv(FCalcBtnHeight, dxMinCalcYOfs, dxMinCalcBtnHeight);
  FCalcXOfs          := FCalcYOfs;
  FCalcLargeBtnWidth := MulDiv(FCalcBtnWidth, 17, 10);
  FCalcFontSize      := MulDiv(FCalcBtnHeight, dxMinCalcFontSize, dxMinCalcBtnHeight);
  FCalcHeight        := (FCalcYOfs+FCalcBtnHeight)*5+FCalcYOfs;
  FCalcWidth         := (FCalcXOfs+FCalcBtnWidth)*6+FCalcXOfs*2+4;
  // reCalc rect buttons
  CreateLayout;
end;

procedure TCustomdxCalculator.WMSize(var Msg: TWMSize);
begin
  inherited;
  CalcSize(ClientWidth, ClientHeight);
  ClientWidth := FCalcWidth;
  ClientHeight := FCalcHeight;
end;

procedure TCustomdxCalculator.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  InvalidateButton(cbEqual);
end;

procedure TCustomdxCalculator.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  InvalidateButton(cbEqual);
end;

procedure TCustomdxCalculator.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if FBorderStyle = bsSingle then RecreateWnd;
end;

procedure TCustomdxCalculator.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomdxCalculator.FontChanged(Sender: TObject);
begin
  if not (csLoading in ComponentState) then ParentFont := False;
  Invalidate;
end;

procedure TCustomdxCalculator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomdxCalculator.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
    if FDownButton <> cbNone then
       FButtons[FDownButton].Down := False;
  end;
end;

procedure TCustomdxCalculator.TrackButton(X,Y: Integer);
var
  FlagRepaint : Boolean;
begin
  if FDownButton <> cbNone then
  begin
    FlagRepaint := (GetButtonKindAt(X, Y)=FDownButton) <> FButtons[FDownButton].Down;
    FButtons[FDownButton].Down := (GetButtonKindAt(X, Y)=FDownButton);
    if FlagRepaint then
    begin
      InvalidateButton(FDownButton);
    end;
  end;
end;

procedure TCustomdxCalculator.InvalidateButton(ButtonKind : TdxCalcButtonKind);
var
  R: TRect;
begin
  if ButtonKind <> cbNone then
  begin
    R := FButtons[ButtonKind].BtnRect;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TCustomdxCalculator.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (ButtonStyle = bsExtraFlat) and Enabled and
     not Dragging and (FActiveButton <> cbNone) then
  begin
    InvalidateButton(FActiveButton);
    FActiveButton := cbNone;
  end;
end;

function TCustomdxCalculator.GetButtonKindChar(Ch : Char) : TdxCalcbuttonKind;
begin
  Result := cbNone;
  case Ch of
  '0'..'9' : Result := TdxCalcbuttonKind(Ord(cbNum0)+Ord(Ch)-Ord('0'));
  '+' : Result := cbAdd;
  '-' : Result := cbSub;
  '*' : Result := cbMul;
  '/' : Result := cbDiv;
  '%' : Result := cbPercent;
  {#13,} '=' : Result := cbEqual;
  #8 : Result := cbBack;
//  #27 : Result := cbClear;
  '@' : Result := cbSqrt;
  else
    if DecimalSeparator = Ch then Result := cbDecimal;
  end;
end;

function TCustomdxCalculator.GetButtonKindKey(Key: Word; Shift: TShiftState) : TdxCalcbuttonKind;
begin
  Result := cbNone;
  case Key of
  VK_RETURN : Result := cbEqual;
  VK_ESCAPE : Result := cbClear;
  VK_F9 : Result := cbSign;
  VK_DELETE : Result := cbCancel;
  Ord('C'){VK_C} : if not (ssCtrl in Shift) then Result := cbClear;
  Ord('P'){VK_P} : if ssCtrl in Shift then Result := cbMP;
  Ord('L'){VK_L} : if ssCtrl in Shift then Result := cbMC;
  Ord('R'){VK_R} : if ssCtrl in Shift then Result := cbMR
                   else Result := cbRev;
  Ord('M'){VK_M} : if ssCtrl in Shift then Result := cbMS;
  end;
end;

procedure TCustomdxCalculator.CopyToClipboard;
begin
  Clipboard.AsText := GetEditValue;
end;

procedure TCustomdxCalculator.PasteFromClipboard;
var S, S1 : String;
  i : Integer;
begin
  if Clipboard.HasFormat(CF_TEXT) then
    try
      S := Clipboard.AsText;
      S1 := '';
      repeat
        i := Pos(CurrencyString, S);
        if i > 0 then
        begin
          S1 := S1 + Copy(S, 1, i - 1);
          S := Copy(S, i + Length(CurrencyString), MaxInt);
        end
        else
          S1 := S1 + S;
      until i <= 0;
      SetDisplay(StrToFloat(Trim(S1)));
      FStatus := csValid;
    except
      SetDisplay(0.0);
    end;
end;

procedure TCustomdxCalculator.SetAutoFontSize(Value : Boolean);
begin
  if AutoFontSize <> Value then
  begin
    FAutoFontSize := Value;
    Font.OnChange(Nil);
  end;
end;

// math routines
procedure TCustomdxCalculator.Error;
begin
  FStatus := csError;
  SetEditValue(sdxCalcError{LoadStr(dx_Error)});
  if FBeepOnError then MessageBeep(0);
  if Assigned(FOnError) then FOnError(Self);
end;

procedure TCustomdxCalculator.CheckFirst;
begin
  if FStatus = csFirst then
  begin
    FStatus := csValid;
    SetEditValue('0');
  end;
end;

procedure TCustomdxCalculator.Clear;
begin
  FStatus := csFirst;
  SetDisplay(0.0);
  FOperator := cbEqual;
end;

procedure TCustomdxCalculator.ButtonClick(ButtonKind : TdxCalcButtonKind);
var Value : Extended;
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self, ButtonKind);
  if (FStatus = csError) and not (ButtonKind in [cbClear, cbCancel]) then
  begin
    Error;
    Exit;
  end;
  if ButtonKind = cbDecimal then
  begin
    CheckFirst;
    if Pos(DecimalSeparator, EditValue) = 0 then
      SetEditValue(EditValue + DecimalSeparator);
    Exit;
  end;
  case ButtonKind of
    cbRev:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        if FOperator in OperationButtons then
           FStatus := csValid;
        if GetDisplay = 0 then Error else SetDisplay(1.0 / GetDisplay);
      end;
    cbSqrt:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        if FOperator in OperationButtons then
           FStatus := csValid;
        if GetDisplay < 0 then Error else SetDisplay(Sqrt(GetDisplay));
      end;
    cbNum0..cbNum9:
      begin
        CheckFirst;
        if EditValue = '0' then SetEditValue('');
        if Length(EditValue) < Max(2, FPrecision) + Ord(Boolean(Pos('-', EditValue))) then
           SetEditvalue(EditValue + Char(Ord('0')+Byte(ButtonKind)-Byte(cbNum0)))
        else if FBeepOnError then MessageBeep(0);
      end;
    cbBack:
      begin
        CheckFirst;
        if (Length(EditValue) = 1) or ((Length(EditValue) = 2) and (EditValue[1] = '-')) then
          SetEditValue('0')
        else
          SetEditValue(System.Copy(EditValue, 1, Length(EditValue) - 1));
      end;
    cbSign: SetDisplay(-GetDisplay);
    cbAdd, cbSub, cbMul, cbDiv, cbEqual, cbPercent :
      begin
        if FStatus = csValid then
        begin
          FStatus := csFirst;
          Value := GetDisplay;
          if ButtonKind = cbPercent then
            case FOperator of
              cbAdd, cbSub : Value := FOperand * Value / 100.0;
              cbMul, cbDiv : Value := Value / 100.0;
            end;
          case FOperator of
            cbAdd : SetDisplay(FOperand + Value);
            cbSub : SetDisplay(FOperand - Value);
            cbMul : SetDisplay(FOperand * Value);
            cbDiv : if Value = 0 then Error else SetDisplay(FOperand / Value);
          end;
        end;
        FOperator := ButtonKind;
        FOperand := GetDisplay;
        if (ButtonKind in ResultButtons) and Assigned(FOnResult) then FOnResult(Self);
      end;
    cbClear, cbCancel: Clear;
    cbMP:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        FMemory := FMemory + GetDisplay;
        UpdateMemoryButtons;
        InvalidateMemoryButtons;
      end;
    cbMS:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        FMemory := GetDisplay;
        UpdateMemoryButtons;
        InvalidateMemoryButtons;
      end;
    cbMR:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        CheckFirst;
        SetDisplay(FMemory);
      end;
    cbMC:
      begin
        FMemory := 0.0;
        UpdateMemoryButtons;
        InvalidateMemoryButtons;
      end;
  end;
end;

procedure TCustomdxCalculator.UpdateMemoryButtons;
begin
  // Disable buttons
  if FMemory <> 0.0 then
  begin
    FButtons[cbMC].Grayed := False;
    FButtons[cbMR].Grayed := False;
  end
  else
  begin
    FButtons[cbMC].Grayed := True;
    FButtons[cbMR].Grayed := True;
  end;
end;

procedure TCustomdxCalculator.InvalidateMemoryButtons;
begin
  InvalidateButton(cbMC);
  InvalidateButton(cbMR);
end;

function TCustomdxCalculator.GetDisplay: Extended;
var
  S: string;
begin
  if FStatus = csError then Result := 0.0
  else
  begin
    S := Trim(GetEditValue);
    if S = '' then S := '0';  
    Result := StrToFloat(S);
  end;                             
end;

procedure TCustomdxCalculator.SetDisplay(Value: Extended);
var
  S: string;
begin
  S := FloatToStrF(Value, ffGeneral, Max(2, FPrecision), 0); {TODO e-+!}
  if GetEditValue <> S then
  begin
    SetEditValue(S);
    if Assigned(FOnDisplayChange) then FOnDisplayChange(Self);
  end;
end;

function TCustomdxCalculator.GetMemory: Extended;
begin
  Result := FMemory;
end;

{TdxCalculator}
procedure TdxCalculator.SetAssociate(Value : TWinControl);
begin
  FAssociate := Value;
  if Value <> Nil then
     Value.FreeNotification(Self);
  try
    StrToFloat(GetEditValue);
  except
    SetEditValue('0');
  end;
end;

procedure TdxCalculator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FAssociate then Associate := nil;
end;

type
TWinControlCracker = class(TWinControl)
public
  property Text;
end;

function TdxCalculator.GetEditValue: String;
begin
  if Assigned(Associate) then Result := TWinControlCracker(Associate).Text
  else Result := '0';
  if Assigned(FOnGetEditValue) then FOnGetEditValue(Self, Result);
end;

procedure TdxCalculator.SetEditValue(const Value: String);
begin
  if Assigned(Associate) then
    TWinControlCracker(Associate).Text := Value;
  if Assigned(FOnSetEditValue) then FOnSetEditValue(Self, Value);
end;

{TdxCalcDisplay}
constructor TdxCalcDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csOpaque];
  if not NewStyleControls then
    ControlStyle := ControlStyle + [csFramed];
  ParentColor := False;
  ParentCtl3d := False;
  Color := clWindow;
  Ctl3d := True;
  Width := 100;
  Text := '0';
  AdjustHeight;
end;

procedure TdxCalcDisplay.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.Style := WindowClass.Style and not CS_DBLCLKS;
    if NewStyleControls and Ctl3D then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end
    else
      Style := Style or WS_BORDER;
  end;
end;

procedure TdxCalcDisplay.Paint;
const AlignFlag : Integer = DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX or
                            DT_VCENTER or DT_SINGLELINE;
var R : TRect;
begin
  if not HandleAllocated then Exit;
  R := ClientRect;
  with Canvas do
  begin
    Font := Self.Font;
    Brush.Color := Self.Color;
    FillRect(R);
    InflateRect(R, -BorderWidth, -BorderWidth);
    DrawText(Handle, PChar(Text), Length(Text), R, AlignFlag);
  end;
end;

procedure TdxCalcDisplay.WMSize(var Msg: TWMSize);
begin
  inherited;
  AdjustHeight;
end;

procedure TdxCalcDisplay.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustHeight;
end;

procedure TdxCalcDisplay.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TdxCalcDisplay.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  if NewStyleControls then
  begin
    if Ctl3D then I := 8 else I := 6;
    I := GetSystemMetrics(SM_CYBORDER) * I;
  end else
  begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;
  Height := Metrics.tmHeight + I + BorderWidth;
end;

initialization
  DrawBitmap := TBitmap.Create;
  sdxCalcError := LoadStr(dx_Error);

finalization
  if DrawBitmap <> nil then
  begin
    DrawBitmap.Free;
    DrawBitmap := nil;
  end;

end.
