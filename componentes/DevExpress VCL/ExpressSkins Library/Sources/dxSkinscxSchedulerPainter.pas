{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{                    ExpressSkins Library                            }
{                                                                    }
{           Copyright (c) 2006-2010 Developer Express Inc.           }
{                     ALL RIGHTS RESERVED                            }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSKINS AND ALL ACCOMPANYING     }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxSkinscxSchedulerPainter;

interface

uses
  Windows, SysUtils, Classes, cxSchedulerCustomResourceView, cxDateUtils,
  cxSchedulerCustomControls, dxSkinsCore, dxSkinsLookAndFeelPainter,
  cxLookAndFeels, cxLookAndFeelPainters, cxGraphics, Graphics, cxGeometry,
  cxSchedulerUtils, Math, cxScheduler, cxClasses;

type

  { TcxSchedulerSkinViewItemsPainter }

  TcxSchedulerSkinViewItemsPainter = class(TcxSchedulerExternalPainter)
  private
    procedure DrawClippedElement(ACanvas: TcxCanvas; AElement: TdxSkinElement;
      ABorders: TcxBorders; R: TRect);
    function IsSkinAvalaible: Boolean;
    function SkinInfo: TdxSkinLookAndFeelPainterInfo;
  public
    procedure DoCustomDrawButton(
      AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean); override;
    //
    function NeedDrawSelection: Boolean; override;
    function DrawCurrentTimeFirst: Boolean; override;
    //
    procedure DrawAllDayArea(ACanvas: TcxCanvas; const ARect: TRect;
      ABorderColor: TColor; ABorders: TcxBorders; AViewParams: TcxViewParams;
      ASelected: Boolean; ATransparent: Boolean); override;
    procedure DrawCurrentTime(ACanvas: TcxCanvas; AColor: TColor; AStart: TDateTime;
      ABounds: TRect); override;
    procedure DrawEvent(AViewInfo: TcxSchedulerEventCellViewInfo); override;
    procedure DrawTimeGridHeader(ACanvas: TcxCanvas; ABorderColor: TColor;
      AViewInfo: TcxSchedulerCustomViewInfoItem; ABorders: TcxBorders;
      ASelected: Boolean); override;
    procedure DrawTimeLine(ACanvas: TcxCanvas; const ARect: TRect;
      AViewParams: TcxViewParams; ABorders: TcxBorders;
      ABorderColor: TColor); override;
    procedure DrawTimeRulerBackground(ACanvas: TcxCanvas; const ARect: TRect;
      ABorders: TcxBorders; AViewParams: TcxViewParams; ATransparent: Boolean); override;
    procedure DrawShadow(ACanvas: TcxCanvas; const ARect, AVisibleRect: TRect;
      ABuffer: TBitmap); override;
    function MoreButtonSize(ASize: TSize): TSize; override;
  end;

implementation

uses Types;

type
  TcxCustomSchedulerAccess = class(TcxCustomScheduler);

const
  cxHeaderStateToButtonState: array[Boolean] of TcxButtonState =
    (cxbsNormal, cxbsHot);

{ TcxSchedulerSkinViewItemsPainter }

procedure TcxSchedulerSkinViewItemsPainter.DrawClippedElement(ACanvas: TcxCanvas;
  AElement: TdxSkinElement; ABorders: TcxBorders; R: TRect);
begin
  ACanvas.SaveClipRegion;
  ACanvas.SetClipRegion(TcxRegion.Create(R), roIntersect);
  try
    with AElement.Image.Margins.Rect do
    begin
      if not (bLeft in ABorders) then
        Dec(R.Left, Left);
      if not (bTop in ABorders) then
        Dec(R.Top, Top);
      if not (bRight in ABorders) then
        Inc(R.Right, Right);
      if not (bBottom in ABorders) then
        Inc(R.Bottom, Bottom);
    end;
    AElement.Draw(ACanvas.Handle, R);
  finally
    ACanvas.RestoreClipRegion;
  end;
end;

function TcxSchedulerSkinViewItemsPainter.IsSkinAvalaible: Boolean;
begin
  Result := Painter.InheritsFrom(TdxSkinLookAndFeelPainter);
end;

function TcxSchedulerSkinViewItemsPainter.SkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  GetExtendedStylePainters.GetPainterData(Painter, Result);
end;

function TcxSchedulerSkinViewItemsPainter.MoreButtonSize(ASize: TSize): TSize;
begin
  if IsSkinAvalaible and (SkinInfo.SchedulerMoreButton <> nil) then
    Result := SkinInfo.SchedulerMoreButton.Size
  else
    Result := ASize;
end;

procedure TcxSchedulerSkinViewItemsPainter.DoCustomDrawButton(
  AViewInfo: TcxSchedulerMoreEventsButtonViewInfo; var ADone: Boolean);
begin
  inherited DoCustomDrawButton(AViewInfo, ADone);
  if not ADone and IsSkinAvalaible then
  begin
    ADone := SkinInfo.SchedulerMoreButton <> nil;
    if ADone then
    begin
      with AViewInfo do
        SkinInfo.SchedulerMoreButton.Draw(Canvas.Handle, Bounds, Byte(IsDown));
    end;
  end;
end;

procedure TcxSchedulerSkinViewItemsPainter.DrawAllDayArea(ACanvas: TcxCanvas;
  const ARect: TRect; ABorderColor: TColor; ABorders: TcxBorders;
  AViewParams: TcxViewParams; ASelected: Boolean; ATransparent: Boolean);  
var
  ADoCustomDraw: Boolean;
  AElement: TdxSkinElement;
begin
  if IsSkinAvalaible then
  begin
    AElement := SkinInfo.SchedulerAllDayArea[ASelected];
    ADoCustomDraw := AElement = nil;
    if not ADoCustomDraw then
      DrawClippedElement(ACanvas, AElement, ABorders, ARect);
  end
  else
    ADoCustomDraw := True;

  if ADoCustomDraw then
    inherited DrawAllDayArea(ACanvas, ARect, ABorderColor, ABorders, AViewParams,
      ASelected, ATransparent);
end;  

procedure TcxSchedulerSkinViewItemsPainter.DrawCurrentTime(ACanvas: TcxCanvas;
  AColor: TColor; AStart: TDateTime; ABounds: TRect);
var
  ADoCustomDraw: Boolean;
  AElement: TdxSkinElement;
  ANow: TDateTime;
  Y, I: Integer;
begin
  if IsSkinAvalaible then
  begin
    AElement := SkinInfo.SchedulerCurrentTimeIndicator;
    ADoCustomDraw := AElement = nil;
    if not ADoCustomDraw then
    begin
      ANow := TimeOf(Now) - TimeOf(AStart);
      if (ANow < 0) or (ANow >= HourToTime) then Exit;
      Y := Trunc(ABounds.Top + (ANow * cxRectHeight(ABounds)) / HourToTime);
      Dec(ABounds.Right);
      Inc(ABounds.Left, 5);
      with AElement.Image.Size do
        ABounds := cxRectSetTop(ABounds, Y - cy div 2, cy);
      for I := 0 to 1 do
        AElement.Draw(ACanvas.Handle, ABounds, I);
    end;
  end
  else
    ADoCustomDraw := True;

  if ADoCustomDraw then
    inherited DrawCurrentTime(ACanvas, AColor, AStart, ABounds);
end;

function TcxSchedulerSkinViewItemsPainter.NeedDrawSelection: Boolean;
begin
  Result := not IsSkinAvalaible;
end;

function TcxSchedulerSkinViewItemsPainter.DrawCurrentTimeFirst: Boolean;
begin
  Result := True;
end;

procedure TcxSchedulerSkinViewItemsPainter.DrawEvent(
  AViewInfo: TcxSchedulerEventCellViewInfo);
const
  AShadowSize = 4;
  ASelectedFlags: array[Boolean] of TdxSkinElementState = (esNormal, esHot);
var
  ADone: Boolean;
  AElement: TdxSkinElement;
  AMask: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;

  function CheckRect(const ARect: TRect): TRect;
  begin
    if AViewInfo.Selected and (ASkinInfo.SchedulerAppointmentBorderSize <> nil) then
    begin
      with ASkinInfo.SchedulerAppointmentBorderSize do
      begin
        Result := Rect(ARect.Left, ARect.Top - Value, ARect.Right + Value,
          ARect.Bottom + Value);          
        if IsRectEmpty(AViewInfo.TimeLineRect) then
          Dec(Result.Left, Value)
        else
          Dec(Result.Left, cxTimeLineWidth);
      end;
    end
    else
      Result := ARect;
  end;

  procedure DrawShadowLine(const AShadow: TdxSkinElement; const ARect: TRect);
  begin
    if AShadow <> nil then
      AShadow.Draw(AViewInfo.Canvas.Handle, ARect);
  end;

  procedure DrawShadows(ASkinInfo: TdxSkinLookAndFeelPainterInfo);
  begin
    with AViewInfo do
      if EventViewData.DrawShadows and (EventViewData.Bitmap <> nil) and
        not Hidden and not Selected and ShowTimeLine then
      begin
        DrawShadowLine(ASkinInfo.SchedulerAppointmentShadow[False],
          Rect(Bounds.Left + AShadowSize, Bounds.Bottom - AShadowSize,
            Bounds.Right + AShadowSize, Bounds.Bottom + AShadowSize));
        DrawShadowLine(ASkinInfo.SchedulerAppointmentShadow[True],
          Rect(Bounds.Right - AShadowSize, Bounds.Top + AShadowSize,
            Bounds.Right + AShadowSize, Bounds.Bottom - AShadowSize));
      end;
  end;

  procedure DrawLabeledEvent(ALabelColor: TColor);
  const
    AImageIndexs: array[Boolean] of Integer = (1, 0);
  var
    ABitmap, AMaskBmp, ASourceBmp: TcxBitmap;
    R: TRect;
  begin
    if AMask = nil then Exit;
    R := AViewInfo.Bounds;
    OffsetRect(R, -R.Left, -R.Top);
    AMaskBmp := TcxBitmap.CreateSize(R, pf32bit);
    ASourceBmp := TcxBitmap.CreateSize(R, pf32bit);
    try
      ASourceBmp.Canvas.Brush.Color := ALabelColor;
      ASourceBmp.Canvas.FillRect(R);
      AMask.Draw(AMaskBmp.Canvas.Handle, R, AImageIndexs[IsRectEmpty(AViewInfo.TimeLineRect)]);
      ABitmap := TcxBitmap.CreateSize(R, pf32bit);
      try
        cxBitBlt(AMaskBmp.Canvas.Handle, AMaskBmp.Canvas.Handle, AMaskBmp.ClientRect, cxNullPoint, NOTSRCCOPY);
        cxBitBlt(ABitmap.Canvas.Handle, AMaskBmp.Canvas.Handle, ABitmap.ClientRect, cxNullPoint, SRCCOPY);
        cxBitBlt(ABitmap.Canvas.Handle, ASourceBmp.Canvas.Handle, ABitmap.ClientRect, cxNullPoint, SRCERASE);
        cxBitBlt(AViewInfo.Canvas.Handle,  AMaskBmp.Canvas.Handle, AViewInfo.Bounds, cxNullPoint, SRCAND);
        cxBitBlt(AViewInfo.Canvas.Handle, ABitmap.Canvas.Handle, AViewInfo.Bounds, cxNullPoint, SRCINVERT);
      finally
        ABitmap.Free;
      end;
    finally
      AMaskBmp.Free;
      ASourceBmp.Free;
    end;
  end;

  function GetSeparatorColor(ABorderColor: TdxSkinColor): TColor;
  begin
    Result := clDefault;
    if ABorderColor <> nil then
      Result := ABorderColor.Value;
    if (Result = clNone) or (Result = clDefault) then
      Result := AViewInfo.SeparatorColor;
  end;

begin
  ASkinInfo := SkinInfo;
  ADone := ASkinInfo <> nil;
  if ADone then
  begin
    with ASkinInfo do
    begin
      AElement := SchedulerAppointment[IsRectEmpty(AViewInfo.TimeLineRect)];
      AMask := SchedulerAppointmentMask;
    end;                   
    ADone := (AElement <> nil) and (AMask <> nil);
    if ADone then
      with AViewInfo do
      begin
        Canvas.SaveClipRegion;
        try
          Canvas.SetClipRegion(TcxRegion.Create(
            cxRectInflate(CheckRect(ClipRect), 0, 0, AShadowSize, AShadowSize)),
            roSet);
          Canvas.ExcludeClipRect(TimeLineRect);
          DrawShadows(ASkinInfo);
          SeparatorColor := GetSeparatorColor(ASkinInfo.SchedulerAppointmentBorder);
          AElement.Draw(Canvas.Handle, CheckRect(Bounds), 0, ASelectedFlags[Selected]);
          if Event.LabelColor <> clDefault then
            DrawLabeledEvent(Event.LabelColor);
          Transparent := True;
        finally
          Canvas.RestoreClipRegion;
        end;
      end;
  end;   

  if not ADone then
    inherited DrawEvent(AViewInfo);
end;

procedure TcxSchedulerSkinViewItemsPainter.DrawTimeGridHeader(ACanvas: TcxCanvas;
  ABorderColor: TColor; AViewInfo: TcxSchedulerCustomViewInfoItem;
  ABorders: TcxBorders; ASelected: Boolean);
var
  ADoCustomDraw: Boolean;
  AElement: TdxSkinElement;
begin
  ADoCustomDraw := True;
  if IsSkinAvalaible then
  begin
    AElement := SkinInfo.SchedulerTimeGridHeader[ASelected];
    ADoCustomDraw := AElement = nil;
    if not ADoCustomDraw then
      with AViewInfo do
        DrawClippedElement(ACanvas, AElement, ABorders, Bounds);
  end;
  if ADoCustomDraw then                    
    inherited DrawTimeGridHeader(ACanvas, ABorderColor, AViewInfo, ABorders,
      ASelected);
end;

procedure TcxSchedulerSkinViewItemsPainter.DrawTimeLine(ACanvas: TcxCanvas;
  const ARect: TRect; AViewParams: TcxViewParams; ABorders: TcxBorders;
  ABorderColor: TColor);
var
  ADoCustomDraw: Boolean;
  AElement: TdxSkinElement;
begin
  ADoCustomDraw := True;
  if IsSkinAvalaible then
  begin
    AElement := SkinInfo.SchedulerTimeLine;
    ADoCustomDraw := AElement = nil;
    if not ADoCustomDraw then
      DrawClippedElement(ACanvas, AElement, ABorders, ARect);
  end;
  if ADoCustomDraw then
    inherited DrawTimeLine(ACanvas, ARect, AViewParams, ABorders, ABorderColor); 
end;

procedure TcxSchedulerSkinViewItemsPainter.DrawTimeRulerBackground(
  ACanvas: TcxCanvas; const ARect: TRect; ABorders: TcxBorders;
  AViewParams: TcxViewParams; ATransparent: Boolean);
var
  ADoCustomDraw: Boolean;
  AElement: TdxSkinElement;
begin
  ADoCustomDraw := True;
  if IsSkinAvalaible then
  begin
    AElement := SkinInfo.SchedulerTimeRuler;
    ADoCustomDraw := AElement = nil;
    if not ADoCustomDraw then
      DrawClippedElement(ACanvas, AElement, ABorders, ARect);
  end;
  if ADoCustomDraw then
    inherited DrawTimeRulerBackground(ACanvas, ARect, ABorders, AViewParams,
      ATransparent);
end;

procedure TcxSchedulerSkinViewItemsPainter.DrawShadow(ACanvas: TcxCanvas;
  const ARect, AVisibleRect: TRect; ABuffer: TBitmap);
begin
  if not IsSkinAvalaible then
    inherited DrawShadow(ACanvas, ARect, AVisibleRect, ABuffer);
end;

initialization
  ExternalPainterClass := TcxSchedulerSkinViewItemsPainter;

finalization
  ExternalPainterClass := TcxSchedulerExternalPainter;

end.
