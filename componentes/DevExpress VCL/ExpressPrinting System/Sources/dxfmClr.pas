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
  ExtCtrls, Buttons, dxBkgnd;

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
    pnlTop: TPanel;
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
    pnlBottom: TPanel;
    sBtnMoreColors: TSpeedButton;
    sBtnFillEffects: TSpeedButton;
    bvlNoFillHolder: TBevel;
    pnlMiddle: TPanel;
    Bevel1: TBevel;
    procedure sBtnMoreColorsClick(Sender: TObject);
    procedure sBtnFillEffectsClick(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
  private
    FAutoColor: TColor;
    FBackground: TdxBackground;
    FButtons: array[0..dxPaletteColCount - 1, 0..dxPaletteRowCount - 1] of TSpeedButton;
    FColor: TColor;
    FNoBtnCaption: string;
    FResult: TModalResult;
    FShowFillEffects: Boolean;
    FShowMoreColors: Boolean;
    sbtnNoFill: TSpeedButton;
    procedure AdjustHeight;
    function GetBorderStyle: TFormBorderStyle;
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
    procedure WMNCCalcSize(var message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCCreate(var message: TWMNCCreate); message WM_NCCREATE;
    procedure WMNCDestroy(var message: TWMNCDestroy); message WM_NCDESTROY;
    procedure WMNCPaint(var message: TWMNCPaint); message WM_NCPAINT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    
    procedure Initialize(ABackground: TdxBackground; const APosition: TPoint; AData: TdxBackgroundDlgData); virtual;
    property Color: TColor read FColor write SetColor;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean;
    
    property AutoColor: TColor read FAutoColor write SetAutoColor;
    property Background: TdxBackground read FBackground write SetBackground;
    property BorderStyle: TFormBorderStyle read GetBorderStyle write SetBorderStyle;
    property NoBtnCaption: string read FNoBtnCaption write SetNoBtnCaption;
    property ShowFillEffects: Boolean read FShowFillEffects write SetShowFillEffects;
    property ShowMoreColors: Boolean read FShowMoreColors write SetShowMoreColors;
  end;

function dxChooseBackgroundDlg(ABackground: TdxBackground; APosition: TPoint;
  const AParams: PdxBackgroundDlgData): Boolean; overload; {$IFDEF DELPHI6} deprecated; {$ENDIF}
function dxChooseBackgroundDlg(ABackground: TdxBackground; APosition: TPoint;
  const AParams: TdxBackgroundDlgData): Boolean; overload;
function dxDefaultBackgroundDlgData: TdxBackgroundDlgData;
      
implementation

{$R *.DFM}

uses
  cxClasses, dxPSRes, dxPSUtl, dxPSEngn, dxPSImgs, dxPSGlbl;

function dxChooseBackgroundDlg(ABackground: TdxBackground; APosition: TPoint;
  const AParams: PdxBackgroundDlgData): Boolean;
var
  Params: TdxBackgroundDlgData;
begin
  if AParams = nil then 
    Params := dxDefaultBackgroundDlgData
  else  
    Params := AParams^;
  Result := dxChooseBackgroundDlg(ABackground, APosition, Params); 
end;
  
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
//const
//  BorderStyleMap: array[TdxPSLookAndFeel] of TBorderStyle = 
begin
  with Result do 
   begin           
    BorderStyle := Forms.bsNone;
    FormCaption := cxGetResourceString(@sdxPageBackground);
    NoBtnCaption := cxGetResourceString(@sdxBtnNoFill);
    AutoColor := clBlack;
    ShowFillEffects := True;
    ShowMoreColors := True;  
  end;  
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
  inherited;
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
  R := MakeRect(0, 0, FColorGlyph.Width, FColorGlyph.Height);
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
  inherited;
  ControlStyle := ControlStyle - [csCaptureMouse];
  FShowFillEffects := True;
  FShowMoreColors := True;
  InitControls;
  LoadStrings;
  
  sbtnNoFill := TdxNoFillButton.Create(Self);
  with sbtnNoFill do
  begin
    BoundsRect := bvlNoFillHolder.BoundsRect;
    Parent := pnlTop;
    Down := True;
    AllowAllUp := False;
    GroupIndex := 1;
    Tag := MakeTTag(-1);
    Flat := True;
    Caption := FNoBtnCaption;
    OnClick := ButtonClick;
  end;
  FormStyle := fsStayOnTop;
end;

function TdxfmColorPalette.Execute: Boolean;
begin
  FResult := mrNone;
  Show;
  while FResult = mrNone do Application.HandleMessage;
  Result := FResult = mrOK;
end;

procedure TdxfmColorPalette.CreateParams(var Params: TCreateParams);
begin
  inherited;
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
  R: TRect;
begin
  Background := ABackground;
    
  BorderStyle := AData.BorderStyle;
  Caption := AData.FormCaption;
  NoBtnCaption := AData.NoBtnCaption;
  AutoColor := AData.AutoColor;
  ShowFillEffects := AData.ShowFillEffects;
  ShowMoreColors := AData.ShowMoreColors;

  Left := APosition.X;
  Top := APosition.Y;
  R := GetDesktopWorkArea;
  
  if Left + Width > R.Right then
    Left := R.Right - Width;
  if Left < R.Left then
    Left := R.Left;
  if Top + Height > R.Bottom then 
    Top := R.Bottom - Height;
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

procedure TdxfmColorPalette.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if BorderStyle = bsNone then
    InflateRect(TWMNCCalcSize(Message).CalcSize_Params^.rgrc[0], -2, -2)
  else
    inherited;
end;

procedure TdxfmColorPalette.WMNCPaint(var message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  if BorderStyle = bsNone then
  begin
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    DC := GetWindowDC(Handle);
    try
      DrawEdge(DC, R, EDGE_RAISED, BF_ADJUST or BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end
  else
    inherited;
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

function TdxfmColorPalette.GetBorderStyle: TFormBorderStyle;
begin
  Result := inherited BorderStyle;
end;

procedure TdxfmColorPalette.SetBorderStyle(Value: TFormBorderStyle);
begin
  inherited BorderStyle := Value;
  AdjustHeight;
end;

procedure TdxfmColorPalette.AdjustHeight;
var
  H: Integer;
begin
  H := pnlTop.Height;
  if pnlMiddle.Visible then Inc(H, pnlMiddle.Height);
  if pnlBottom.Visible then Inc(H, pnlBottom.Height);
  ClientHeight := H;
end;

procedure TdxfmColorPalette.InitControls;

  procedure PrepareButtonGlyph(AGlyph: TBitmap; I, J: Integer);
  const
    W = 16;
    H = 16;  
  var
    R: TRect;  
  begin
    R := MakeRect(0, 0, W, H);
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
      PrepareButtonGlyph(FButtons[I, J].Glyph, I, J);
    end;
end;

procedure TdxfmColorPalette.LoadStrings;
begin
  sBtnMoreColors.Caption := cxGetResourceString(@sdxBtnMoreColors);
  sBtnFillEffects.Caption := cxGetResourceString(@sdxBtnFillEffects);
  
  SpeedButton1.Hint := cxGetResourceString(@sdxColorBlack);
  SpeedButton9.Hint := cxGetResourceString(@sdxColorDarkRed);
  SpeedButton17.Hint := cxGetResourceString(@sdxColorRed);
  SpeedButton25.Hint := cxGetResourceString(@sdxColorPink);
  SpeedButton33.Hint := cxGetResourceString(@sdxColorRose);
  SpeedButton2.Hint := cxGetResourceString(@sdxColorBrown);
  SpeedButton10.Hint := cxGetResourceString(@sdxColorOrange);
  SpeedButton18.Hint := cxGetResourceString(@sdxColorLightOrange);
  SpeedButton26.Hint := cxGetResourceString(@sdxColorGold);
  SpeedButton34.Hint := cxGetResourceString(@sdxColorTan);
  SpeedButton3.Hint := cxGetResourceString(@sdxColorOliveGreen);
  SpeedButton11.Hint := cxGetResourceString(@sdxColorDrakYellow);
  SpeedButton19.Hint := cxGetResourceString(@sdxColorLime);
  SpeedButton27.Hint := cxGetResourceString(@sdxColorYellow);
  SpeedButton35.Hint := cxGetResourceString(@sdxColorLightYellow);
  SpeedButton4.Hint := cxGetResourceString(@sdxColorDarkGreen);
  SpeedButton12.Hint := cxGetResourceString(@sdxColorGreen);
  SpeedButton20.Hint := cxGetResourceString(@sdxColorSeaGreen);
  SpeedButton28.Hint := cxGetResourceString(@sdxColorBrighthGreen);
  SpeedButton36.Hint := cxGetResourceString(@sdxColorLightGreen);
  SpeedButton5.Hint := cxGetResourceString(@sdxColorDarkTeal);
  SpeedButton13.Hint := cxGetResourceString(@sdxColorTeal);
  SpeedButton21.Hint := cxGetResourceString(@sdxColorAqua);
  SpeedButton29.Hint := cxGetResourceString(@sdxColorTurquoise);
  SpeedButton37.Hint := cxGetResourceString(@sdxColorLightTurquoise);
  SpeedButton6.Hint := cxGetResourceString(@sdxColorDarkBlue);
  SpeedButton14.Hint := cxGetResourceString(@sdxColorBlue);
  SpeedButton22.Hint := cxGetResourceString(@sdxColorLightBlue);
  SpeedButton30.Hint := cxGetResourceString(@sdxColorSkyBlue);
  SpeedButton38.Hint := cxGetResourceString(@sdxColorPaleBlue);
  SpeedButton7.Hint := cxGetResourceString(@sdxColorIndigo);
  SpeedButton15.Hint := cxGetResourceString(@sdxColorBlueGray);
  SpeedButton23.Hint := cxGetResourceString(@sdxColorViolet);
  SpeedButton31.Hint := cxGetResourceString(@sdxColorPlum);
  SpeedButton39.Hint := cxGetResourceString(@sdxColorLavender);
  SpeedButton8.Hint := cxGetResourceString(@sdxColorGray80);
  SpeedButton16.Hint := cxGetResourceString(@sdxColorGray50);
  SpeedButton24.Hint := cxGetResourceString(@sdxColorGray40);
  SpeedButton32.Hint := cxGetResourceString(@sdxColorGray25);
  SpeedButton40.Hint := cxGetResourceString(@sdxColorWhite);
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

