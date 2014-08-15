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

unit cxSSPainters;

{$I cxVer.inc}

interface

uses
  Classes, Windows, Graphics, SysUtils, cxSSViewInfo,
  cxSSTypes, cxSSStyles, cxSSUtils, cxExcelConst, cxSSPainterWrapper;

type
  TcxSheetPainterClass = class of TcxSheetPainter;
  TcxPageCaptionPainterClass = class of TcxPageCaptionPainter;

  { TcxPageCaptionPainter }
  TcxPageCaptionPainter = class
  private
    FCanvas: TcxCanvasWrapper;
    FViewInfo: TcxSSBookCaptionViewInfo;
  protected
    procedure DrawCaptions; virtual;
    procedure DrawNavigatorBtn; virtual;
    property Canvas: TcxCanvasWrapper read FCanvas;
    property ViewInfo: TcxSSBookCaptionViewInfo read FViewInfo;
  public
    procedure Paint(ACanvas: TcxCanvasWrapper; AViewInfo: TcxSSBookCaptionViewInfo); virtual;
  end;

  { TcxSheetPainter }
  TcxSheetPainter = class
  private
    FHideSelection: Boolean;
    FPalette: Pointer;
    FViewInfo: TcxSSViewInfoData;
    FCanvas: TcxCanvasWrapper;
    function GetPalette: PcxExcelPalette;
  protected
    procedure DrawCells; virtual;
    procedure DrawHeaderBrick(I, J: Integer); virtual;
    procedure DrawSelection; virtual;
    property Canvas: TcxCanvasWrapper read FCanvas;
    property Palette: PcxExcelPalette read GetPalette;
    property ViewInfo: TcxSSViewInfoData read FViewInfo;
  public
    destructor Destroy; override; 
    procedure Paint(ACanvas: TcxCanvasWrapper; const AInfoData: TcxSSViewInfoData); virtual;
    property HideSelection: Boolean read FHideSelection write FHideSelection;
  end;

  { TcxXPPainter }
  TcxXPPainter = class(TcxSheetPainter)
  protected
    procedure DrawHeaderBrick(I, J: Integer); override;
  end;

implementation
{ TcxPageCaptionPainter }
procedure TcxPageCaptionPainter.Paint(ACanvas: TcxCanvasWrapper;
  AViewInfo: TcxSSBookCaptionViewInfo);
begin
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
  FCanvas.FillRect(AViewInfo.Bounds, fsSolid, AViewInfo.FillColor, AViewInfo.FillColor);
  DrawCaptions;
  DrawNavigatorBtn;
end;

procedure TcxPageCaptionPainter.DrawCaptions;

  procedure DrawCaption(ALeft, ATop, ARight, ABottom: Integer;
                        const ACaption: string; IsCurrent: Boolean);
  var
    AVertex: array[0..3] of TPoint;
    AControlCanvas: TCanvas;
  const
    SheetBrushColor: array[Boolean] of TColor = (clBtnFace, clWindow);
  begin
    AControlCanvas := Canvas.Canvas;
    AVertex[0] := Point(ALeft, ATop);
    AVertex[1] := Point(ALeft + 10, ABottom);
    AVertex[2] := Point(ARight - 10, ABottom);
    AVertex[3] := Point(ARight, ATop);
    if IsCurrent then
      Canvas.Polygon(AVertex, Canvas.WindowColor)
    else
      Canvas.Polygon(AVertex, ViewInfo.FillColor);
    AControlCanvas.Pen.Style := psSolid;
    if not IsCurrent then
      with AControlCanvas do
      begin
        Pen.Color := clBtnHighLight;
        MoveTo(ALeft + 2, ATop + 1);
        LineTo(ALeft + 11, ABottom);
        Pen.Color := clBtnShadow;
        MoveTo(ALeft + 11, ABottom - 1);
        LineTo(ARight - 10, ABottom - 1);
        MoveTo(ARight - 11, ABottom);
        LineTo(ARight - 1, ATop);
        LineTo(ALeft + 1, ATop);
      end;
    AControlCanvas.Pen.Color := clBlack;
    AControlCanvas.PolyLine(AVertex);
    Canvas.SetTextColor(Canvas.TextColor);
    Canvas.SelectFont(ViewInfo.Font);
    Canvas.DrawText(ACaption, Rect(ALeft + 10 , ATop, ARight - 10, ABottom - 2));
  end;

var
  I, ACurrent: SmallInt;
begin
  ACurrent := -1;
  for I := Length(FViewInfo.Bricks) - 1 downto FViewInfo.FirstVisibleCaption do
    with FViewInfo.Bricks[I] do
    begin
      if csHidden in State then
        Continue
      else
        begin
          if csCurrent in State then
          begin
            ACurrent := I;
            Continue;
          end;
          with BoundsRect do
            DrawCaption(Left, Top,
              Right, Bottom, DisplayText, False)
        end;
    end;
    if (ACurrent >= 0) and (ACurrent >= ViewInfo.FirstVisibleCaption) then
      with FViewInfo.Bricks[ACurrent].BoundsRect do
        DrawCaption(Left, Top, Right, Bottom, FViewInfo.Bricks[ACurrent].DisplayText, True);
end;

procedure TcxPageCaptionPainter.DrawNavigatorBtn;

   procedure DrawBtn(ARect: TRect; AHeight: Integer;
     ButtonType: TcxSSNavigatorBtn; IsDown: Boolean);
   var
     AShadowColor: TColor;
   begin
     AShadowColor := cxBtnShadowColor;
     Canvas.FrameRect(ARect, AShadowColor);              
     OffsetRect(ARect, 1, 1);
     Dec(ARect.Bottom);
     if IsDown then
       Canvas.FrameRect(ARect, AShadowColor, cxBtnHighLightColor)
     else
       Canvas.FrameRect(ARect, cxBtnHighLightColor, AShadowColor);
     InflateRect(ARect, -1, -1);
     Canvas.FillRect(ARect, fsSolid, ViewInfo.FillColor, ViewInfo.FillColor);
     OffsetRect(ARect, 1, 0);
     if IsDown then
       OffsetRect(ARect, 1, 1);
     Canvas.DrawTriangleGlyph(ARect, Canvas.TextColor,
        ButtonType in [nbNext, nbEnd], ButtonType in [nbStart, nbEnd]);
   end;

var
  I: TcxSSNavigatorBtn;

begin
  with FViewInfo do
    for I := nbStart to nbEnd do
      DrawBtn(BtnBricks[I], 15, I, IsButtonDown and (Integer(I) = BtnDown));
end;

{ TcxSheetPainter }
destructor TcxSheetPainter.Destroy; 
begin
  FViewInfo.Bricks := nil;
  inherited Destroy; 
end; 

procedure TcxSheetPainter.Paint(ACanvas: TcxCanvasWrapper; const AInfoData: TcxSSViewInfoData);
begin
  FViewInfo := AInfoData;
  FCanvas := ACanvas;
  if Length(AInfoData.Bricks) > 0 then
  begin
    DrawSelection;
    DrawCells;
  end;
  FCanvas := nil;
end;

procedure TcxSheetPainter.DrawCells;
var
  I, J: Integer;
  ARect: TRect;

  procedure DrawBrickEdges(var ABrick: TcxSSInfoBrick);
  begin
    with ABrick do
    begin
      if Edges[eTop].Style = lsDefault then
        Canvas.Line(TopEdgeVertex, lsDefault, oHorz, 56, 56,
          IsSelected and not FHideSelection)
      else
        if Edges[eTop].Style <> lsNone then
        Canvas.Line(TopEdgeVertex, Edges[eTop].Style, oHorz, BrushBkColor,
          Edges[eTop].Color,  IsSelected and not FHideSelection);
      if Edges[eLeft].Style = lsDefault then
        Canvas.Line(LeftEdgeVertex, lsDefault, oVert, 56, 56,
          IsSelected and not FHideSelection)
      else
        if Edges[eLeft].Style <> lsNone then
        Canvas.Line(LeftEdgeVertex, Edges[eLeft].Style, oVert, BrushBkColor,
          Edges[eLeft].Color,  IsSelected and not FHideSelection);
    end;
  end;

begin
  with FViewInfo do
  begin
    for I := 0 to Length(UnionBricks) - 1 do
    begin
      with UnionBricks[I] do
      begin
        ARect := DisplayRect;
        InflateRect(ARect, -3, -3);
        Canvas.FillRect(ARect, BrushStyle, BrushBkColor, BrushFgColor,
          IsSelected and not FHideSelection);
        Canvas.ExDrawText(TextRect, TextSettings);
        Canvas.ExcludeClipRect(ARect);
      end;
    end;
    for J := 0 to Length(Bricks[0]) - 1 do
    begin
      for I := 0 to Length(Bricks) - 1 do
      begin
        if I = 0 then
        begin
          if DrawHeaders then
            DrawHeaderBrick(I, J)
        end
        else
        begin
          if J = 0 then
          begin
            if DrawHeaders then
              DrawHeaderBrick(I, J)
          end
          else
          begin
            with Bricks[I, J] do
              if BrushStyle <> fsSolid then
                Canvas.FillRect(DisplayRect, BrushStyle, BrushBkColor, BrushFgColor,
                  IsSelected and not FHideSelection)
              else
                Canvas.FillRect(DisplayRect, BrushStyle, BrushBkColor, BrushFgColor,
                  IsSelected and not FHideSelection);
            if J > 1 then
              DrawBrickEdges(Bricks[I, J - 1]);
            if J = (Length(Bricks[0]) - 1) then
              DrawBrickEdges(Bricks[I, J]);
          end;
        end;
      end;
      if J > 0 then
        for I := 1 to Length(Bricks) - 1 do
        with Bricks[I, J] do
         if not IsMerge then
           Canvas.ExDrawText(TextRect, TextSettings);
    end;
  end;
end;

procedure TcxSheetPainter.DrawHeaderBrick(I, J: Integer);

  procedure SetColors(var AColors; const AValues: array of TColor);
  begin
    PIntArray(@AColors)^[0] := AValues[0];
    PIntArray(@AColors)^[1] := AValues[1];
  end;

var
  ARect: TRect;
  AOuterColor,
  AInnerColor: array[Boolean] of TColor;

begin
  SetColors(AOuterColor, [cxBtnShadowColor, cxBlackColor]);
  SetColors(AInnerColor, [cxBtnFaceColor, cxBtnShadowColor]);
  with FViewInfo.Bricks[I, J] do
  begin
    ARect := DisplayRect;
    Canvas.FrameRect(ARect, AOuterColor[IsSelected and not FHideSelection]);
    InflateRect(ARect, -1, -1);
    FCanvas.FrameRect(ARect, cxBtnHighLightColor,
      AInnerColor[IsSelected and not FHideSelection]);
    InflateRect(ARect, -1, -1);
    FCanvas.FillRect(ARect, fsSolid, FViewInfo.HeaderColor, FViewInfo.HeaderColor);
    InflateRect(ARect, 2, 2);
    if (I <> 0) or (J <> 0) then
    begin
      OffsetRect(ARect, 0, 2);
      FCanvas.SetTextColor(FViewInfo.HeaderFontColor);
      FCanvas.ExDrawText(ARect, TextSettings);
    end;
    FCanvas.ExcludeClipRect(DisplayRect);
  end;
end;

procedure TcxSheetPainter.DrawSelection;
var
  ARect: TRect;
  ASelRect: TRect;
  AEdgeRects: array[0..3] of TRect;
  I: Integer;
begin
  if FHideSelection then Exit;
  ASelRect := FViewInfo.SelectedBricks;
  if not FViewInfo.IsSelectionVisible then Exit; 
  if ASelRect.Left < 0 then
    ASelRect.Left := 0;
  if ASelRect.Top  < 0 then
    ASelRect.Top := 0;
  if (ASelRect.Right >= Length(FViewInfo.Bricks)) or (ASelRect.Right < 0) then
    ASelRect.Right := Length(FViewInfo.Bricks) - 1;
  if (ASelRect.Bottom >= Length(FViewInfo.Bricks[0])) or (ASelRect.Bottom < 0) then
    ASelRect.Bottom := Length(FViewInfo.Bricks[0]) - 1;
  if (ASelRect.Right < ASelRect.Left) or (ASelRect.Bottom < ASelRect.Top) then Exit;
  ARect.Left := FViewInfo.Bricks[ASelRect.Left, 0].DisplayRect.Left;
  ARect.Top := FViewInfo.Bricks[0, ASelRect.Top].DisplayRect.Top;
  ARect.Right := FViewInfo.Bricks[ASelRect.Right, 0].DisplayRect.Right;
  ARect.Bottom := FViewInfo.Bricks[0, ASelRect.Bottom].DisplayRect.Bottom;
  with ARect do
  begin
    AEdgeRects[0] := Rect(Left - 1 , Top - 1, Left + 2, Bottom - 1);
    AEdgeRects[1] := Rect(Left + 2, Top - 1, Right - 1, Top + 2);
    AEdgeRects[2] := Rect(Right - 2, Top - 1, Right + 1, Bottom - 1);
    AEdgeRects[3] := Rect(Left - 1, Bottom - 2 , Right + 1, Bottom + 1);
  end;
  Canvas.SetBkColor(clBlack);
  for I := 0 to 3 do
  begin
    if AEdgeRects[I].Bottom <= FViewInfo.Bricks[0, 0].DisplayRect.Bottom then
      Continue
    else
      if AEdgeRects[I].Right <= FViewInfo.Bricks[0, 0].DisplayRect.Right then
        Continue;
    if AEdgeRects[I].Left < FViewInfo.Bricks[0, 0].DisplayRect.Right then
      AEdgeRects[I].Left := FViewInfo.Bricks[0, 0].DisplayRect.Right;
    if AEdgeRects[I].Top < FViewInfo.Bricks[0, 0].DisplayRect.Bottom then
      AEdgeRects[I].Top := FViewInfo.Bricks[0, 0].DisplayRect.Bottom;
    Canvas.FillRect(AEdgeRects[I], fsSolid, clBlack, clBlack);
    Canvas.ExcludeClipRect(AEdgeRects[I]);
  end;
end;

function TcxSheetPainter.GetPalette: PcxExcelPalette;
begin
  Result := FPalette; 
end;

{ TcxXPPainter }
procedure TcxXPPainter.DrawHeaderBrick(I, J: Integer);
var
  ARect: TRect;
  AColor: TColor;
begin
  with FViewInfo.Bricks[I, J] do
  begin
    ARect := DisplayRect;
    if (I = 1) and (J = 0) then Dec(ARect.Left);
    if (J = 1) and (I = 0) then Dec(ARect.Top);
    if IsSelected and not FHideSelection then
      AColor := FCanvas.MixColors(FCanvas.SelectionColor, clWindow)
    else
      AColor := FViewInfo.HeaderColor;
    FCanvas.FillRect(ARect, fsSolid, AColor, AColor);
    FCanvas.FrameRect(ARect, cxBtnShadowColor, IsSelected and not HideSelection);
    if  (I <> 0) or (J <> 0) then
    begin
      OffsetRect(ARect, 0, 2);
      FCanvas.SetTextColor(FViewInfo.HeaderFontColor);
      FCanvas.ExDrawText(ARect, TextSettings);
    end;
    FCanvas.ExcludeClipRect(DisplayRect);
  end;
end;

end.

