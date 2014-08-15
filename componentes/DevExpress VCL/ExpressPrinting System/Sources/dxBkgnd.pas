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

unit dxBkGnd;

interface

{$I cxVer.inc}

uses                                                                  
  Windows, Classes, SysUtils, Controls, Graphics, dxBase, dxPSGlbl, dxPSUtl;
                                                                      
type
  TdxPicturePaintMode = (ppmCenter, ppmStretch, ppmTile, ppmProportional);
  TdxBackgroundMode = (bmNone, bmBrush, bmBrushBitmap, bmPicture);
  TdxBackgroundParam = (bpBkColor, bpBrush, bpMode, bpPictureMode, bpPicture);
  TdxBackgroundParams = set of TdxBackgroundParam;
  TdxPaintSequence = (psBefore, psAfter);
  
  TdxBackgroundChangeEvent = procedure(Sender: TObject; AChangeWhat: TdxBackgroundParams) of object;
    
  TCustomdxBackgroundPaintEvent = procedure(Sender: TObject; Canvas: TCanvas;
    Rect: TRect; ASequence: TdxPaintSequence; var ADone: Boolean) of object;
    
  TCustomdxBackgroundPaintExEvent = procedure(Sender: TObject; Canvas: TCanvas;
    Rect: TRect; ASequence: TdxPaintSequence; PixelsNumerator,
    PixelsDenominator: Integer; var ADone: Boolean) of object;

  TdxBackgroundClass = class of TdxBackground;
  
  TdxBackground = class(TdxBaseObject)
  private
    FBkColor: TColor;
    FBrush: TBrush;
    FIsRepaintNeeded: Boolean;
    FMode: TdxBackgroundMode;
    FPicture: TGraphic;
    FPictureMode: TdxPicturePaintMode;
    FOnApply: TNotifyEvent;
    FOnChange: TdxBackgroundChangeEvent;
    FOnPaint: TCustomdxBackgroundPaintEvent;
    FOnPaintEx: TCustomdxBackgroundPaintExEvent;
    function GetPicture: TGraphic;
    procedure SetBkColor(Value: tColor);
    procedure SetBrush(Value: TBrush);
    procedure SetMode(Value: TdxBackgroundMode);
    procedure SetPicture(Value: TGraphic);
    procedure SetPictureMode(Value: TdxPicturePaintMode);

    procedure BrushChanged(Sender: TObject);
    procedure PictureChanged(Sender: TObject);
  protected   
    procedure DoAssign(Source: TdxBaseObject); override;
    procedure DoRestoreDefaults; override;
    
    procedure DoApply; dynamic;
    procedure DoChange(AChangeWhats: TdxBackgroundParams); dynamic;
    procedure DoPaint(ACanvas: TCanvas; Rect: TRect; Sequence: TdxPaintSequence;
      var ADone: Boolean); virtual;
    procedure DoPaintEx(ACanvas: TCanvas; Rect: TRect; Sequence: TdxPaintSequence;
      PixelsNumerator, PixelsDenominator: Integer; var ADone: Boolean); virtual;
    procedure LockUpdate(ALockState : TdxLockState); override;
    function RepaintNeeded(AChangeWhats: TdxBackgroundParams): Boolean; virtual;

    property OnApply: TNotifyEvent read FOnApply write FOnApply;
  public
    constructor Create; override;
    destructor Destroy; override;
    
    procedure Clear; virtual;
    function IsEmpty: Boolean; override;
    function IsEqual(ABaseObject: TdxBaseObject): Boolean; override;
        
    procedure Paint(ACanvas: TCanvas; const R: TRect); virtual;
    procedure PaintEx(ACanvas: TCanvas; const R: TRect;
      PixelsNumerator, PixelsDenominator: Integer); virtual;
      
    function SetupEffects: Boolean;

    property IsRepaintNeeded: Boolean read FIsRepaintNeeded;
    property OnChange: TdxBackgroundChangeEvent read FOnChange write FOnChange;
    property OnPaint: TCustomdxBackgroundPaintEvent read FOnPaint write FOnPaint;
    property OnPaintEx: TCustomdxBackgroundPaintExEvent read FOnPaintEx write FOnPaintEx;
  published
    property BkColor: TColor read FBkColor write SetBkColor default clWhite;
    property Brush: TBrush read FBrush write SetBrush;
    property Mode: TdxBackgroundMode read FMode write SetMode default bmNone;
    property Picture: TGraphic read GetPicture write SetPicture;
    property PictureMode: TdxPicturePaintMode read FPictureMode write SetPictureMode default ppmCenter;
  end;

procedure DrawPicture(APicture: TGraphic; ACanvas: TCanvas; const ARect: TRect;
  APictureMode: TdxPicturePaintMode; PixelsNumerator, PixelsDenominator: Integer; 
  AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);

const
  cwAll: TdxBackgroundParams = [bpBkColor..bpPicture];
  
implementation

uses
  dxFEFDlg;
  
constructor TdxBackground.Create;
begin
  inherited;
  FBkColor := clWhite;
  FBrush := TBrush.Create;
  FBrush.OnChange := BrushChanged;
  FMode := bmNone;
  FPictureMode := ppmCenter;
  FPicture := TBitmap.Create;
  FPicture.OnChange := PictureChanged;
end;

destructor TdxBackground.Destroy;
begin
  FreeAndNil(FPicture);
  FreeAndNil(FBrush);
  inherited;
end;

procedure TdxBackground.Clear;
begin
  Brush.Color := clWhite;
  Mode := bmNone;
  Picture := nil;
end;

function TdxBackground.IsEmpty: Boolean;
begin
  case Mode of
   bmBrush:
     Result := Brush.Style = bsClear;
   bmBrushBitmap,
   bmPicture:
     Result := (Picture = nil) or Picture.Empty;
  else //bmNone
    Result := True;  
  end;
end;

function TdxBackground.IsEqual(ABaseObject: TdxBaseObject): Boolean;
begin
  Result := inherited IsEqual(ABaseObject);
  if Result then
    with TdxBackground(ABaseObject) do     
     Result := 
       (Self.BkColor = BkColor) and 
       (Self.Mode = Mode) and 
       (Self.PictureMode = PictureMode) and 
       dxAreBrushesEqual(Self.Brush, Brush) and 
       dxAreGraphicsEqual(Self.Picture, Picture);
end;

procedure TdxBackground.Paint(ACanvas: TCanvas; const R: TRect);
begin
  PaintEx(ACanvas, R, 1, 1);
end;

procedure TdxBackground.PaintEx(ACanvas: TCanvas; const R: TRect;
  PixelsNumerator, PixelsDenominator: Integer);
var
  PrevColor: COLORREF;
  PrevBkMode: Integer;
  PrevBrush: TBrush;
  Done: Boolean;
  DC: HDC;
  Pattern: TBitmap;
begin
  Done := False;
  DoPaintEx(ACanvas, R, psBefore, PixelsNumerator, PixelsDenominator, Done);
  if Done then Exit;
  
  DC := ACanvas.Handle;
  case Mode of
    bmNone: ;
    bmBrush:
      if Brush.Style <> bsClear then
      begin
        if Brush.Style > bsClear then  {hatched brush}
        begin
          PrevBkMode := SetBkMode(DC, Windows.TRANSPARENT);
          PrevColor := Windows.SetBkColor(DC, ColorToRGB(BkColor));
        end
        else {bsSolid}
        begin
          PrevBkMode := GetBkMode(DC);
          PrevColor := COLORREF(0);
        end;
        if (Brush.Style > bsClear) and IsPrinterDC(DC) then {hatched Brush} 
        begin
          Pattern := TBitmap.Create;
          with Pattern do
          try
            Width := 8;
            Height := 8;
            Canvas.Brush := Self.Brush;
            SetBkMode(DC, Windows.TRANSPARENT);
            Windows.SetBkColor(DC, ColorToRGB(BkColor));
            Canvas.FillRect(Rect(0, 0, Width, Height));
            DrawPicture(Pattern, ACanvas, R, ppmTile, PixelsNumerator, PixelsDenominator);
          finally
            Free;
          end;
        end
        else
          FillRect(DC, R, Brush.Handle);
        if Brush.Style > bsClear then
        begin
          Windows.SetBkColor(DC, PrevColor);
          SetBkMode(DC, PrevBkMode);
        end;
      end;

    bmBrushBitmap:
      if Picture <> nil then
        if (Picture.Width <= 8) and (Picture.Height <= 8) and not IsPrinterDC(DC) then 
        begin
          PrevBrush := TBrush.Create;
          try
            PrevBrush.Assign(ACanvas.Brush);
            ACanvas.Brush.Bitmap := TBitmap(Picture);
            ACanvas.FillRect(R);
            ACanvas.Brush.Bitmap := nil;
            ACanvas.Brush := PrevBrush;
          finally
            PrevBrush.Free;
          end;
        end
        else
          DrawPicture(Picture, ACanvas, R, ppmTile, PixelsNumerator, PixelsDenominator);

    bmPicture:
      if Picture <> nil then
        if (PictureMode = ppmTile) and (Picture.Width <= 8) and (Picture.Height <= 8) and not IsPrinterDC(DC) then 
        begin
          PrevBrush := TBrush.Create;
          try
            PrevBrush.Assign(ACanvas.Brush);
            ACanvas.Brush.Bitmap := TBitmap(Picture);
            ACanvas.FillRect(R);
            ACanvas.Brush.Bitmap := nil;
            ACanvas.Brush := PrevBrush;
          finally
            PrevBrush.Free;
          end;
        end
        else
          DrawPicture(Picture, ACanvas, R, PictureMode, PixelsNumerator, PixelsDenominator);
  end;
  
  DoPaintEx(ACanvas, R, psAfter, PixelsNumerator, PixelsDenominator, Done);
end;

function TdxBackground.SetupEffects: Boolean;
begin
  Result := dxFEFDialog(Self);
end;

procedure TdxBackground.DoAssign(Source: TdxBaseObject);
begin
  inherited;
  with Source as TdxBackground do
  begin
    Self.BkColor := BkColor;
    Self.Brush := Brush;
    Self.Mode := Mode;
    Self.PictureMode := PictureMode;
    Self.Picture := Picture;
  end;
end;                   

procedure TdxBackground.DoRestoreDefaults;
begin
  inherited;
  FBkColor := clWhite;
  FMode := bmNone;
  FPictureMode := ppmCenter;
end;

procedure TdxBackground.DoApply;
begin
  if Assigned(FOnApply) then FOnApply(Self);
end;

procedure TdxBackground.DoChange(AChangeWhats: TdxBackgroundParams);
begin
  if not IsLocked then 
  begin
    FIsRepaintNeeded := RepaintNeeded(AChangeWhats);
    if Assigned(FOnChange) then FOnChange(Self, AChangeWhats);
  end;  
end;

procedure TdxBackground.DoPaint(ACanvas: TCanvas; Rect: TRect;
  Sequence: TdxPaintSequence; var ADone: Boolean);
begin
  if Assigned(FOnPaint) then FOnPaint(Self, ACanvas, Rect, Sequence, ADone);
end;

procedure TdxBackground.DoPaintEx(ACanvas: TCanvas; Rect: TRect;
  Sequence: TdxPaintSequence; PixelsNumerator, PixelsDenominator: Integer;
  var ADone: Boolean);
begin
  if Assigned(FOnPaintEx) then
    FOnPaintEx(Self, ACanvas, Rect, Sequence, PixelsNumerator, PixelsDenominator, ADone);
  if not ADone then
    DoPaint(ACanvas, Rect, Sequence, ADone);
end;

procedure TdxBackground.LockUpdate(ALockState : TdxLockState);
begin  
  if ALockState = lsUnLock then DoChange(cwAll);
  inherited LockUpdate(ALockState);
end;

function TdxBackground.RepaintNeeded(AChangeWhats: TdxBackgroundParams): Boolean;
begin
  if bpMode in AChangeWhats then 
    Result := True
  else
    case Mode of
      bmBrush: 
        Result := (bpBrush in AChangeWhats) or ((bpBkColor in AChangeWhats) and (Brush.Style > bsClear));
      bmBrushBitmap:
        Result := bpPicture in AChangeWhats;
      bmPicture:
        Result := [bpPicture, bpPictureMode] * AChangeWhats <> [];
    else
      Result := False;
    end;    
end;

procedure TdxBackground.BrushChanged(Sender: TObject);
begin
  DoChange([bpBrush]);
end;                                                                        

procedure TdxBackground.PictureChanged(Sender: TObject);
begin
  DoChange([bpPicture]);
end;

procedure TdxBackground.SetBkColor(Value: tColor);
begin
  if FBkColor <> Value then
  begin
    FBkColor := Value;
    DoChange([bpBkColor]);
  end;
end;

procedure TdxBackground.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TdxBackground.SetMode(Value: TdxBackgroundMode);
begin
  if FMode <> Value then
  begin
    FMode := Value;
    DoChange([bpMode]);
  end;
end;

function TdxBackground.GetPicture: TGraphic;
begin
  if FPicture = nil then FPicture := TBitmap.Create;
  Result := FPicture;
end;

procedure TdxBackground.SetPicture(Value: TGraphic);
begin
  if Value <> nil then
  begin
    Picture.Assign(Value);
    TBitmap(Picture).HandleType := bmDIB;
  end
  else 
    if FPicture <> nil then
    begin
      TBitmap(FPicture).FreeImage;
      TBitmap(FPicture).ReleaseHandle;
    end;
end;

procedure TdxBackground.SetPictureMode(Value: TdxPicturePaintMode);
begin
  if FPictureMode <> Value then
  begin
    FPictureMode := Value;
    DoChange([bpPictureMode]);
  end;
end;

{ utility routines }

function IsGraphicVisible(DC: HDC; const R: TRect): Boolean;
begin
  Result := IsPrinterDC(DC) or IsMetafileDC(DC) or RectVisible(DC, R);
end;

procedure DrawGraphicCenter(AGraphic: TGraphic; ACanvas: TCanvas; const ARect: TRect;
  PixelsNumerator, PixelsDenominator: Integer);
var
  DC: HDC;  
  W, H: Integer;
  R: TRect;
begin
  DC := ACanvas.Handle;
  with ARect, AGraphic do
  begin
    W := MulDiv(Width, PixelsNumerator, PixelsDenominator);
    H := MulDiv(Height, PixelsNumerator, PixelsDenominator);
    R := Bounds(Left + (Right - Left - W) div 2, Top + (Bottom - Top - H) div 2, W, H);
    if IsGraphicVisible(DC, R) then
      if (W <> Width) or (H <> Height) then
        ACanvas.StretchDraw(R, AGraphic)
      else
        ACanvas.Draw(R.Left, R.Top, AGraphic);
  end;
end;

procedure DrawGraphicStretch(AGraphic: TGraphic; ACanvas: TCanvas; const ARect: TRect;
  PixelsNumerator, PixelsDenominator: Integer);
begin
  if IsGraphicVisible(ACanvas.Handle, ARect) then
    ACanvas.StretchDraw(ARect, AGraphic);
end;

procedure DrawGraphicTile(AGraphic: TGraphic; ACanvas: TCanvas; const ARect: TRect;
  PixelsNumerator, PixelsDenominator: Integer; AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);
var
  DC: HDC;  
  I, J, W, H: Integer;
  Rgn: HRGN;
  R: TRect;
begin
  DC := ACanvas.Handle;

  with ARect, AGraphic do
  begin
    W := MulDiv(Width, PixelsNumerator, PixelsDenominator);
    H := MulDiv(Height, PixelsNumerator, PixelsDenominator);
    AnOffsetX := AnOffsetX mod W;
    AnOffsetY := AnOffsetY mod H;
    
    Rgn := dxPSUtl.IntersectClipRect(DC, ARect);

    for I := 0 to (Right - Left - AnOffsetX) div W do
      for J := 0 to (Bottom - Top - AnOffsetX) div H do
      begin
        R := Bounds(Left + I * W + AnOffsetX, Top + J * H + AnOffsetY, W, H);
        if IsGraphicVisible(DC, R) then        
          if (W <> Width) or (H <> Height) then
            ACanvas.StretchDraw(R, AGraphic)
          else
            ACanvas.Draw(R.Left, R.Top, AGraphic);
      end;
      
    dxPSUtl.RestoreClipRgn(DC, Rgn);  
  end;
end;

procedure DrawGraphicStretchProportional(AGraphic: TGraphic; ACanvas: TCanvas; const ARect: TRect;
  PixelsNumerator, PixelsDenominator: Integer);
var
  DC: HDC;  
  W, H, V: Integer;
  R: TRect;
begin  
  DC := ACanvas.Handle;
  with ARect, AGraphic do
  begin
    W := Right - Left;
    H := Bottom - Top;
    if Width / Height > W / H then
    begin
      V := MulDiv(Height, W, Width);
      R := Bounds(Left, Top + (H - V) div 2, W, V);
    end
    else
    begin
      V := MulDiv(Width, H, Height);
      R := Bounds(Left + (W - V) div 2, Top, V, H);
    end;
    if IsGraphicVisible(DC, R) then
      ACanvas.StretchDraw(R, AGraphic);
  end;
end;
                     
procedure DrawPicture(APicture: TGraphic; ACanvas: TCanvas; const ARect: TRect;
  APictureMode: TdxPicturePaintMode; PixelsNumerator, PixelsDenominator: Integer; 
  AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);
begin
  if APicture.Empty or (APicture.Width = 0) or (APicture.Height = 0) then Exit;
  case APictureMode of
    ppmCenter:
      DrawGraphicCenter(APicture, ACanvas, ARect, PixelsNumerator, PixelsDenominator);
    ppmStretch:
      DrawGraphicStretch(APicture, ACanvas, ARect, PixelsNumerator, PixelsDenominator);
    ppmTile:
      DrawGraphicTile(APicture, ACanvas, ARect, PixelsNumerator, PixelsDenominator, AnOffsetX, AnOffsetY);
    ppmProportional:
      DrawGraphicStretchProportional(APicture, ACanvas, ARect, PixelsNumerator, PixelsDenominator);
  end;
end;

initialization
  RegisterClass(TBitmap); 
  
end.

