{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxfmClr;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, dxBkgnd, cxLookAndFeelPainters, cxControls, cxContainer, 
  cxEdit, cxGroupBox, cxLabel, cxLookAndFeels, dxPSRes;

const
  dxPaletteColCount = 8;
  dxPaletteRowCount = 5;
  dxPaletteColors: array[0..dxPaletteColCount - 1, 0..dxPaletteRowCount - 1] of TColor =
   (($00000000, $00000484, $000004FF, $00FF04FF, $00CE9EFF),
    ($00003498, $00006AFF, $00009AFF, $0000CBFF, $0098CFFF),
    ($00003C39, $00007D7B, $0000CF9C, $0000FFFF, $0098FFFF),
    ($00003400, $00008200, $0084A242, $0000FF00, $00CEFFCE),
    ($00633400, $00848600, $00CECF39, $00FFFF00, $00FFFFCE),
    ($00840400, $00FF0400, $00FF6531, $00FFCF00, $00FFCF9C),
    ($00943431, $009C6563, $00840484, $006B349C, $00FF9ECE),
    ($00313431, $007B7D7B, $00949694, $00C6C6C7, $00FFFFFF));

  dxPaletteColorHints: array[0..dxPaletteColCount - 1, 0..dxPaletteRowCount - 1] of Pointer =
   (
    (@sdxColorBlack, @sdxColorDarkRed, @sdxColorRed, @sdxColorPink, @sdxColorRose),
    (@sdxColorBrown, @sdxColorOrange, @sdxColorLightOrange, @sdxColorGold, @sdxColorTan),
    (@sdxColorOliveGreen, @sdxColorDrakYellow, @sdxColorLime, @sdxColorYellow, @sdxColorLightYellow),
    (@sdxColorDarkGreen, @sdxColorGreen, @sdxColorSeaGreen, @sdxColorBrighthGreen, @sdxColorLightGreen),
    (@sdxColorDarkTeal, @sdxColorTeal, @sdxColorAqua, @sdxColorTurquoise, @sdxColorLightTurquoise),
    (@sdxColorDarkBlue, @sdxColorBlue, @sdxColorLightBlue, @sdxColorSkyBlue, @sdxColorPaleBlue),
    (@sdxColorIndigo, @sdxColorBlueGray, @sdxColorViolet, @sdxColorPlum, @sdxColorLavender),
    (@sdxColorGray80, @sdxColorGray50, @sdxColorGray40, @sdxColorGray25, @sdxColorWhite)
   );

type
  PdxBackgroundDlgData = ^TdxBackgroundDlgData;
  TdxBackgroundDlgData = record
    BorderStyle: TFormBorderStyle;
    FormCaption: string;
    NoBtnCaption: string;
    AutoColor: TColor;
    ShowFillEffects: Boolean;
    ShowMoreColors: Boolean;
  end;

  TdxfmColorPalette = class(TForm)
    pnlBottom: TcxGroupBox;
    sBtnMoreColors: TSpeedButton;
    sBtnFillEffects: TSpeedButton;
    pnlMiddle: TcxGroupBox;
    bvlMiddleSeparator: TcxLabel;
    pnlTop: TcxGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    bvlNoFillHolder: TBevel;
    procedure sBtnMoreColorsClick(Sender: TObject);
    procedure sBtnFillEffectsClick(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
  private
    FAutoColor: TColor;
    FBackground: TdxBackground;
    FBorderStyle: TFormBorderStyle;
    FButtons: array[0..dxPaletteColCount - 1, 0..dxPaletteRowCount - 1] of TSpeedButton;
    FColor: TColor;
    FNoBtnCaption: string;
    FResult: TModalResult;
    FShowFillEffects: Boolean;
    FShowMoreColors: Boolean;
    sbtnNoFill: TSpeedButton;
    procedure AdjustHeight;
    procedure FindButtonColor;
    procedure InitControls;
    procedure LoadStrings;
    procedure SetAutoColor(Value: TColor);
    procedure SetBackground(Value: TdxBackground);
    procedure SetBackgroundColor(AColor: TColor);
    procedure SetBorderStyle(Value: TFormBorderStyle);
    procedure SetColor(Value: TColor);
    procedure SetNoBtnCaption(const Value: string);
    procedure SetShowFillEffects(Value: Boolean);
    procedure SetShowMoreColors(Value: Boolean);
    procedure SetupButtons;
    function TagToColor(ATag: Integer): TColor;
    procedure UpButtons;
    procedure WMKillFocus(var message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCreate(var message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCDestroy(var message: TWMNCDestroy); message WM_NCDESTROY;
  protected
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Initialize(ABackground: TdxBackground; const APosition: TPoint; AData: TdxBackgroundDlgData); virtual;
    procedure Paint; override;
    
    property Color: TColor read FColor write SetColor;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean;
    
    property AutoColor: TColor read FAutoColor write SetAutoColor;
    property Background: TdxBackground read FBackground write SetBackground;
    property BorderStyle: TFormBorderStyle read FBorderStyle write SetBorderStyle;
    property NoBtnCaption: string read FNoBtnCaption write SetNoBtnCaption;
    property ShowFillEffects: Boolean read FShowFillEffects write SetShowFillEffects;
    property ShowMoreColors: Boolean read FShowMoreColors write SetShowMoreColors;
  end;

function dxChooseBackgroundDlg(ABackground: TdxBackground; APosition: TPoint;
  const AParams: TdxBackgroundDlgData): Boolean; overload;
function dxDefaultBackgroundDlgData: TdxBackgroundDlgData;
      
implementation

{$R *.DFM}

uses
  cxClasses, dxPSUtl, dxPSEngn, dxPSImgs, dxPSGlbl, cxGraphics;
  
function dxChooseBackgroundDlg(ABackground: TdxBackground; APosition: TPoint;
  const AParams: TdxBackgroundDlgData): Boolean;
begin
  with TdxfmColorPalette.Create(nil) do
  try
    Initialize(ABackground, APosition, AParams);
    Result := Execute;
  finally
    Free;
  end;
end;

function dxDefaultBackgroundDlgData: TdxBackgroundDlgData;
begin
  Result.BorderStyle := bsSingle;
  Result.FormCaption := cxGetResourceString(@sdxPageBackground);
  Result.NoBtnCaption := cxGetResourceString(@sdxBtnNoFill);
  Result.AutoColor := clBlack;
  Result.ShowFillEffects := True;
  Result.ShowMoreColors := True;
end;

{ TdxNoFillButton }

type
  TdxNoFillButton = class(TSpeedButton)
  private
    FColorGlyph: TBitmap;
    FColorValue: TColor;
    FShowColorValue: Boolean;
    procedure SetColorValue(Value: TColor);
    procedure SetShowColorValue(Value: Boolean);
    procedure ChangeColorGlyph;
    procedure CreateColorGlyph;
    procedure DestroyColorGlyph;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    property ColorValue: TColor read FColorValue write SetColorValue;
    property ShowColorValue: Boolean read FShowColorValue write SetShowColorValue;
  end;

constructor TdxNoFillButton.Create(AOwner: TComponent);
begin
  inherited;
  FColorValue := clBlack;
  ShowColorValue := False;
end;

destructor TdxNoFillButton.Destroy;
begin
  DestroyColorGlyph;
  inherited;
end;

procedure TdxNoFillButton.Paint;
var
  R: TRect;
begin
  inherited Paint;
  R := ClientRect;
  InflateRect(R, -2, -2);
  if Screen.PixelsPerInch > 96 then
    InflateRect(R, -2, -2);
  DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT or BF_FLAT);
end;

procedure TdxNoFillButton.CreateColorGlyph;
var
  R: TRect;
begin
  FColorGlyph := TBitmap.Create;
  R := ClientRect;
  InflateRect(R, -2, -2);
  OffsetRect(R, -R.Left, -R.Top);
  R.Right := R.Bottom - R.Top;
  FColorGlyph.Width := R.Right - R.Left;
  FColorGlyph.Height := R.Bottom - R.Top;
  FrameRect(FColorGlyph.Canvas.Handle, R, GetSysColorBrush(COLOR_BTNSHADOW));
  ChangeColorGlyph;
end;

procedure TdxNoFillButton.DestroyColorGlyph;
begin
  Glyph := nil;
  FreeAndNil(FColorGlyph);
end;

procedure TdxNoFillButton.ChangeColorGlyph;
var
  R: TRect;
begin
  R := Rect(0, 0, FColorGlyph.Width, FColorGlyph.Height);
  InflateRect(R, -1, -1);
  FColorGlyph.Canvas.Brush.Color := ColorToRGB(ColorValue);
  FColorGlyph.Canvas.FillRect(R);
  Glyph := FColorGlyph;
end;

procedure TdxNoFillButton.SetColorValue(Value: TColor);
begin
  if FColorValue <> Value then
  begin
    FColorValue := Value;
    if ShowColorValue then
    begin
      ChangeColorGlyph;
      Invalidate;
    end;
  end;
end;

procedure TdxNoFillButton.SetShowColorValue(Value: Boolean);
begin
  if FShowColorValue <> Value then
  begin
    FShowColorValue := Value;
    if FShowColorValue then
      CreateColorGlyph
    else
      DestroyColorGlyph;
    Invalidate;
  end;
end;

{ TdxfmColorPalette }

constructor TdxfmColorPalette.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited BorderStyle := bsNone;
  ControlStyle := ControlStyle - [csCaptureMouse];
  FShowFillEffects := True;
  FShowMoreColors := True;
  Scaled := False;
  InitControls;
  LoadStrings;
  
  sbtnNoFill := TdxNoFillButton.Create(Self);
  sbtnNoFill.BoundsRect := bvlNoFillHolder.BoundsRect;
  sbtnNoFill.Parent := pnlTop;
  sbtnNoFill.Down := True;
  sbtnNoFill.AllowAllUp := False;
  sbtnNoFill.GroupIndex := 1;
  sbtnNoFill.Tag := MakeTTag(-1);
  sbtnNoFill.Flat := True;
  sbtnNoFill.Caption := FNoBtnCaption;
  sbtnNoFill.OnClick := ButtonClick;
  SetControlLookAndFeel(Self, dxPSEngine.DialogsLookAndFeel);
  
  FormStyle := fsStayOnTop;
end;

function TdxfmColorPalette.Execute: Boolean;
begin
  FResult := mrNone;
  Show;
  while FResult = mrNone do
    Application.HandleMessage;
  Result := FResult = mrOK;
end;

procedure TdxfmColorPalette.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  if BorderStyle <> bsNone then
    InflateRect(Rect, -2, -2);
end;

procedure TdxfmColorPalette.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style or CS_SAVEBITS;
end;

procedure TdxfmColorPalette.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or (ssAlt in Shift) then
    Close
  else 
    if Key = Ord('f') then
      sBtnFillEffects.Click
    else 
      if Key = Ord('b') then
        sBtnMoreColors.Click
      else
        inherited;
end;

procedure TdxfmColorPalette.Initialize(ABackground: TdxBackground; 
  const APosition: TPoint; AData: TdxBackgroundDlgData);
var
  P: TPoint;
  R: TRect;
begin
  Background := ABackground;
    
  BorderStyle := bsSingle;
  Caption := AData.FormCaption;
  NoBtnCaption := AData.NoBtnCaption;
  AutoColor := AData.AutoColor;
  ShowFillEffects := AData.ShowFillEffects;
  ShowMoreColors := AData.ShowMoreColors;

  P := APosition;
  R := GetDesktopWorkArea(P);
  if P.X + Width > R.Right then
    P.X := R.Right - Width;
  if P.Y + Height > R.Bottom then
    P.Y := R.Bottom - Height;
  if P.X < R.Left then
    P.X := R.Left;
  SetBounds(P.X, P.Y, Width, Height);
end;

procedure TdxfmColorPalette.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  FResult := mrCancel;
  Hide;
end;

procedure TdxfmColorPalette.WMNCCreate(var Message: TWMNCCreate);
var
  SysMenu: HMENU;
begin
  inherited;
  SysMenu := GetSystemMenu(Handle, False);
  DeleteMenu(SysMenu, SC_RESTORE, MF_BYCOMMAND);
  DeleteMenu(SysMenu, SC_MINIMIZE, MF_BYCOMMAND);
  DeleteMenu(SysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
  DeleteMenu(SysMenu, SC_SIZE, MF_BYCOMMAND);
end;

procedure TdxfmColorPalette.WMNCDestroy(var Message: TWMNCDestroy);
begin
  GetSystemMenu(Handle, True);
  inherited;
end;

procedure TdxfmColorPalette.Paint;
var
  ACanvas: TcxCanvas;
begin
  inherited Paint;
  if BorderStyle <> bsNone then
  begin
    ACanvas := TcxCanvas.Create(Canvas);
    try
      dxPSEngine.DialogsLookAndFeel.Painter.DrawBorder(ACanvas, ClientRect);
    finally
      ACanvas.Free;
    end;
  end;
end;

procedure TdxfmColorPalette.SetNoBtnCaption(const Value: string);
begin
  if FNoBtnCaption <> Value then
  begin
    FNoBtnCaption := Value;
    sbtnNoFill.Caption := FNoBtnCaption;
  end;
end;

procedure TdxfmColorPalette.SetShowFillEffects(Value: Boolean);
begin
  if FShowFillEffects <> Value then
  begin
    FShowFillEffects := Value;
    pnlBottom.Visible := FShowMoreColors or FShowFillEffects;
    pnlMiddle.Visible := pnlBottom.Visible;
    AdjustHeight;
  end;
end;

procedure TdxfmColorPalette.SetShowMoreColors(Value: Boolean);
begin
  if FShowMoreColors <> Value then
  begin
    FShowMoreColors := Value;
    pnlBottom.Visible := FShowMoreColors or FShowFillEffects;
    pnlMiddle.Visible := pnlBottom.Visible;
    AdjustHeight;
  end;
end;

procedure TdxfmColorPalette.SetBorderStyle(Value: TFormBorderStyle);
begin
  FBorderStyle := Value;
  ClientWidth := 148 + 4 * Ord(BorderStyle <> bsNone);
  AdjustHeight;
end;

procedure TdxfmColorPalette.AdjustHeight;
var
  H: Integer;
begin
  H := pnlTop.Height;
  if pnlMiddle.Visible then Inc(H, pnlMiddle.Height);
  if pnlBottom.Visible then Inc(H, pnlBottom.Height);
  ClientHeight := H + 4 * Ord(BorderStyle <> bsNone);
end;

procedure TdxfmColorPalette.InitControls;

  procedure PrepareButtonGlyph(AGlyph: TBitmap; I, J: Integer);
  const
    W = 16;
    H = 16;  
  var
    R: TRect;  
  begin
    R := Rect(0, 0, W, H);
    AGlyph.Width := W;
    AGlyph.Height := H;
    with AGlyph.Canvas  do 
    begin
      Brush.Color := clBtnFace;
      FrameRect(R);
      InflateRect(R, -1, -1);        
      FrameRect(R);
      InflateRect(R, -1, -1); 
             
      Brush.Color := clBtnShadow;
      FrameRect(R);
      InflateRect(R, -1, -1);

      Brush.Color := ColorToRGB(dxPaletteColors[I, J]);
      FillRect(R);
    end;    
  end;
  

var
  I, J, Index: Integer;
  ButtonName: string;
begin
  for J := 0 to dxPaletteRowCount - 1 do
    for I := 0 to dxPaletteColCount - 1 do
    begin
      Index := J * dxPaletteColCount + I;
      ButtonName := 'SpeedButton' + Trim(IntToStr(Index + 1));
      FButtons[I, J] := TSpeedButton(Self.FindComponent(ButtonName));
      FButtons[I, J].Tag := MakeTTag(Index);
      FButtons[I, J].Hint := cxGetResourceString(dxPaletteColorHints[I, J]);
      PrepareButtonGlyph(FButtons[I, J].Glyph, I, J);
    end;
end;

procedure TdxfmColorPalette.LoadStrings;
begin
  sBtnMoreColors.Caption := cxGetResourceString(@sdxBtnMoreColors);
  sBtnFillEffects.Caption := cxGetResourceString(@sdxBtnFillEffects);
end;

procedure TdxfmColorPalette.SetColor(Value: TColor);
begin
  FColor := Value;
  FindButtonColor;
end;

procedure TdxfmColorPalette.FindButtonColor;
var
  I, J: Integer;
begin
  for I := 0 to dxPaletteColCount - 1 do
    for J := 0 to dxPaletteRowCount - 1 do
      if FColor = dxPaletteColors[I, J] then
      begin
        FButtons[I, J].Down := True;
        Exit;
      end;
  UpButtons;
end;

procedure TdxfmColorPalette.UpButtons;
var
  I, J: Integer;
begin
  for I := 0 to dxPaletteColCount - 1 do
    for J := 0 to dxPaletteRowCount - 1 do
    begin
      FButtons[I, J].AllowAllUp := True;
      FButtons[I, J].Down := False;
    end;
  sbtnNoFill.AllowAllUp := True;
  sbtnNoFill.Down := False;
end;

procedure TdxfmColorPalette.sBtnMoreColorsClick(Sender: TObject);
begin
  Hide;
  dxPSGlbl.ColorDialog.Color := FColor;
  if dxPSGlbl.ColorDialog.Execute then
  begin
    SetBackgroundColor(dxPSGlbl.ColorDialog.Color);
    FResult := mrOK;
  end
  else
    FResult := mrCancel;
end;

procedure TdxfmColorPalette.sBtnFillEffectsClick(Sender: TObject);
const
  ModalResults: array[Boolean] of TModalResult = (mrCancel, mrOK);
begin
  Hide;
  Application.ProcessMessages;
  FResult := ModalResults[Background.SetupEffects];
end;

procedure TdxfmColorPalette.SetupButtons;
begin
  if FBackground <> nil then
    case FBackground.Mode of
      bmNone:
        sbtnNoFill.Down := True;
      bmBrush:
        Color := FBackground.Brush.Color
    else // bmBrushBitmap, bmPicture
      UpButtons;
    end;
end;

procedure TdxfmColorPalette.SetAutoColor(Value: TColor);
begin
  if FAutoColor <> Value then
  begin
    FAutoColor := Value;
    TdxNoFillButton(sbtnNoFill).ColorValue := FAutoColor;
  end;
end;

procedure TdxfmColorPalette.SetBackground(Value: TdxBackground);
begin
  FBackground := Value;
  SetupButtons;
end;

function TdxfmColorPalette.TagToColor(ATag: Integer): TColor;
var
  T: Integer;
begin
  T := TTagToInt(ATag);
  Result := dxPaletteColors[T - (T div dxPaletteColCount) * dxPaletteColCount, T div dxPaletteColCount];
end;

procedure TdxfmColorPalette.SetBackgroundColor(AColor: TColor);
begin
  with Background do
  begin 
    BeginUpdate;
    try
      Mode := bmBrush;
      Brush.Style := bsSolid;
      Brush.Color := AColor;
    finally
      EndUpdate;
    end;
  end;  
end;

procedure TdxfmColorPalette.ButtonClick(Sender: TObject);
begin
  if TTagToInt(TSpeedButton(Sender).Tag) = -1 then // No Fill
    Background.Clear
  else
    SetBackgroundColor(TagToColor(TSpeedButton(Sender).Tag));
  FResult := mrOk;
end;

end.

