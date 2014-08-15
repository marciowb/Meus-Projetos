{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarBaseViews;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Types, Graphics, ImgList,
  dxNavBar, dxNavBarBase, dxNavBarCollns, dxNavBarStyles, dxNavBarCustomPainters;

type
  TdxNavBarBaseViewInfo = class(TdxNavBarViewInfo)
  protected
    procedure CorrectBounds; override;
    function GetActiveGroupMinHeight: Integer; virtual;
  public
    procedure DoGroupActivate(AGroup: TdxNavBarGroup); override;
    procedure DoGroupDeactivate(AGroup: TdxNavBarGroup); override;
    function IsGroupActive(AGroup: TdxNavBarGroup): Boolean; override;
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink; ATop: Boolean = True); override;
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup;
      AExpandGroup: Boolean = True; ATop: Boolean = True); override;
  end;

  { TdxNavBarNavigationBarController }

  TdxNavBarNavigationBarController = class(TdxNavBarController)
  end;

  TdxNavBarBasePainter = class(TdxNavBarElementPainter)
  protected
    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    function GetControllerClass: TdxNavBarControllerClass; override;

    class function ButtonPainterClass: TdxNavBarCustomButtonPainterClass; override;
    class function ScrollButtonsPainterClass: TdxNavBarCustomScrollButtonsPainterClass; override;
    class function SelectionPainterClass: TdxNavBarCustomSelectionPainterClass; override;
  end;

  TdxNavBarBaseSelectionPainter = class(TdxNavBarCustomSelectionPainter)
  protected
    class procedure GetColors(AState: TdxNavBarObjectStates; ABackColor: TColor; out AFillColor,
      ATopLeftOuterColor, ABottomRightOuterColor, ATopLeftInnerColor, ABottomRightInnerColor: TColor); override;
  end;

  TdxNavBarBaseButtonPainter = class(TdxNavBarCustomButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
      AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarBaseScrollButtonsPainter = class(TdxNavBarCustomScrollButtonsPainter)
  protected
    class procedure InternalDrawBottomButton(ACanvas: TCanvas; ARect: TRect;
      AButtonPainterClass: TdxNavBarCustomButtonPainterClass; AColor1, AColor2: TColor;
      AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
      ABorderColor: TColor; AState: TdxNavBarObjectStates); override;
    class procedure InternalDrawTopButton(ACanvas: TCanvas; ARect: TRect;
      AButtonPainterClass: TdxNavBarCustomButtonPainterClass; AColor1, AColor2: TColor;
      AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
      ABorderColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarFlatPainter = class(TdxNavBarBasePainter)
  protected
    class function ButtonPainterClass: TdxNavBarCustomButtonPainterClass; override;
  end;

  TdxNavBarFlatButtonPainter = class(TdxNavBarCustomButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
      AState: TdxNavBarObjectStates); override;
  end;  

implementation

uses
  Math, cxGraphics, dxOffice11, cxGeometry,
  dxNavBarViewsFact, dxNavBarGraphics, dxNavBarConsts;

{ TdxNavBarBaseViewInfo }

procedure TdxNavBarBaseViewInfo.CorrectBounds;
var
  I, ActiveGroupViewInfoIndex: Integer;
  OffsetY, MinHeight: Integer;
begin
  if (GroupCount = 0) or (ActiveGroupViewInfo = nil) then exit;

  ActiveGroupViewInfoIndex := IndexOfGroupViewInfo(ActiveGroupViewInfo);
  OffsetY := ClientHeight - Groups[GroupCount - 1].Rect.Bottom;
  MinHeight := GetActiveGroupMinHeight;
  if (ActiveGroupViewInfo.ItemsRect.Bottom + OffsetY < ActiveGroupViewInfo.ItemsRect.Top + MinHeight) then
    OffsetY := ActiveGroupViewInfo.ItemsRect.Top + MinHeight - ActiveGroupViewInfo.ItemsRect.Bottom;
  ActiveGroupViewInfo.CorrectActiveGroupBounds(0, OffsetY);
  for I := ActiveGroupViewInfoIndex + 1 to GroupCount - 1 do
    Groups[I].CorrectBounds(0, OffsetY);
  CalculateScrollButtonsBounds;
end;

function TdxNavBarBaseViewInfo.GetActiveGroupMinHeight: Integer;
var
  ATopVisibleLinkViewInfo: TdxNavBarLinkViewInfo;
begin
  if ActiveGroupViewInfo <> nil then
  begin
    Result := 2 * GetScrollButtonVerticalSize + 3 * GetScrollButtonVerticalEdge;
    if ActiveGroupViewInfo.ItemCount > ActiveGroupViewInfo.Group.TopVisibleLinkIndex then
    begin
      ATopVisibleLinkViewInfo := ActiveGroupViewInfo.Items[ActiveGroupViewInfo.Group.TopVisibleLinkIndex];
      Result := Max(Result, cxRectHeight(ATopVisibleLinkViewInfo.Rect) + GetGroupCaptionSeparatorWidth);
    end;
  end
  else Result := 0;
end;

procedure TdxNavBarBaseViewInfo.DoGroupActivate(AGroup: TdxNavBarGroup);
begin
  if NavBar.ActiveGroupIndex <> AGroup.Index then
  begin
    NavBar.ActiveGroup := AGroup;
    NavBar.DesignerModified;
  end;
end;

procedure TdxNavBarBaseViewInfo.DoGroupDeactivate(AGroup: TdxNavBarGroup);
begin
end;

function TdxNavBarBaseViewInfo.IsGroupActive(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := AGroup = NavBar.ActiveGroup;
end;

procedure TdxNavBarBaseViewInfo.MakeLinkVisible(ALink: TdxNavBarItemLink; ATop: Boolean = True);
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  if NavBar.ActiveGroup <> ALink.Group then
  begin
    NavBar.ActiveGroup := ALink.Group;
    CreateInfo;
    CalculateBounds;
  end;
  AGroupViewInfo := GetGroupViewInfoByGroup(ALink.Group);
  if AGroupViewInfo <> nil then
  begin
    ALinkViewInfo := AGroupViewInfo.GetLinkViewInfoByLink(ALink);
    if ALinkViewInfo <> nil then
    begin
      if ATop or (ALinkViewInfo.Rect.Top <= AGroupViewInfo.ItemsRect.Top) or
        (cxRectHeight(ALinkViewInfo.Rect) > cxRectHeight(AGroupViewInfo.ItemsRect)) then
        ALink.Group.TopVisibleLinkIndex := AGroupViewInfo.IndexOfLinkViewInfo(ALinkViewInfo)
      else
        while (ALinkViewInfo.Rect.Bottom > AGroupViewInfo.ItemsRect.Bottom) do
        begin
          ALink.Group.TopVisibleLinkIndex := ALink.Group.TopVisibleLinkIndex + 1;
          CalculateBounds;
        end;
      NavBar.InvalidateAll(doRecreate);
    end;
  end;
end;

procedure TdxNavBarBaseViewInfo.MakeGroupVisible(AGroup: TdxNavBarGroup;
  AExpandGroup: Boolean = True; ATop: Boolean = True);
begin
  NavBar.ActiveGroup := AGroup;
end;

{ TdxNavBarCustomPainter }

class function TdxNavBarBasePainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarBaseViewInfo;
end;

function TdxNavBarBasePainter.GetControllerClass: TdxNavBarControllerClass;
begin
  Result := TdxNavBarNavigationBarController;
end;

class function TdxNavBarBasePainter.ButtonPainterClass: TdxNavBarCustomButtonPainterClass;
begin
  Result := TdxNavBarBaseButtonPainter;
end;

class function TdxNavBarBasePainter.ScrollButtonsPainterClass: TdxNavBarCustomScrollButtonsPainterClass;
begin
  Result := TdxNavBarBaseScrollButtonsPainter;
end;

class function TdxNavBarBasePainter.SelectionPainterClass: TdxNavBarCustomSelectionPainterClass;
begin
  Result := TdxNavBarBaseSelectionPainter;
end;

{ TdxNavBarBaseSelectionPainter }

class procedure TdxNavBarBaseSelectionPainter.GetColors(AState: TdxNavBarObjectStates; ABackColor: TColor;
  out AFillColor, ATopLeftOuterColor, ABottomRightOuterColor, ATopLeftInnerColor, ABottomRightInnerColor: TColor);
begin
  inherited;
  if IsPressed(AState) then
  begin
    ATopLeftOuterColor := DarkDarkBorderColor(ABackColor);
    ABottomRightOuterColor := LightLightBorderColor(ABackColor);
  end
  else
  begin
    ATopLeftOuterColor := LightLightBorderColor(ABackColor);
    ABottomRightOuterColor := DarkDarkBorderColor(ABackColor);
  end;
end;

{ TdxNavBarBaseButtonPainter }

class procedure TdxNavBarBaseButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  inherited;
  if sPressed in AState then
    dxNavBarDrawSelectedFrame(ACanvas, ARect, DarkDarkBorderColor(AColor1), DarkDarkBorderColor(AColor1),
      DarkBorderColor(AColor1), DarkBorderColor(AColor1))
  else
    dxNavBarDrawSelectedFrame(ACanvas, ARect, LightLightBorderColor(AColor1), DarkDarkBorderColor(AColor1),
      LightBorderColor(AColor1), DarkBorderColor(AColor1));
  if sActive in AState then
    FillRectByColor(ACanvas.Handle, cxRectSetBottom(ARect, ARect.Bottom, 1), clBlack);
end;

{ TdxNavBarBaseScrollButtonsPainter }

class procedure TdxNavBarBaseScrollButtonsPainter.InternalDrawBottomButton(ACanvas: TCanvas;
  ARect: TRect; AButtonPainterClass: TdxNavBarCustomButtonPainterClass;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  pt1, pt2, pt3: TPoint;
  AArrowHeight, AArrowWidth: Integer;
begin
  AButtonPainterClass.DrawButton(ACanvas, ARect, nil, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, ABorderColor, AState);

  AArrowHeight := (ARect.Bottom - ARect.Top) div 4;
  AArrowWidth := 2 * AArrowHeight - 1;
  pt1.X := ARect.Left + (ARect.Right - ARect.Left) div 2 - 1;
  pt1.Y := ARect.Top + (ARect.Bottom - ARect.Top) div 2 + (AArrowHeight div 2) - 1;
  pt2.X := pt1.X - AArrowWidth div 2;
  pt2.Y := pt1.Y - AArrowHeight + 1;
  pt3.X := pt2.X + AArrowWidth - 1;
  pt3.Y := pt2.Y;
  if sDisabled in AState then
  begin
    ACanvas.Brush.Color := clGrayText;
    ACanvas.Pen.Color := clGrayText;
  end
  else
  begin
    ACanvas.Brush.Color := clBlack;
    ACanvas.Pen.Color := clBlack;
  end;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Polygon([pt1, pt2, pt3]);
end;

class procedure TdxNavBarBaseScrollButtonsPainter.InternalDrawTopButton(ACanvas: TCanvas;
  ARect: TRect; AButtonPainterClass: TdxNavBarCustomButtonPainterClass;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  pt1, pt2, pt3: TPoint;
  AArrowHeight, AArrowWidth: Integer;
begin
  AButtonPainterClass.DrawButton(ACanvas, ARect, nil, AColor1, AColor2,
    AAlphaBlend2, AAlphaBlend2, AGradientMode, ABorderColor, AState);

  AArrowHeight := (ARect.Bottom - ARect.Top) div 4;
  AArrowWidth := 2 * AArrowHeight - 1;
  pt1.X := ARect.Left + (ARect.Right - ARect.Left) div 2 - 1;
  pt1.Y := ARect.Top + (ARect.Bottom - ARect.Top) div 2 - (AArrowHeight div 2) - 1;
  pt2.X := pt1.X - AArrowWidth div 2;
  pt2.Y := pt1.Y + AArrowHeight - 1;
  pt3.X := pt2.X + AArrowWidth - 1;
  pt3.Y := pt2.Y;
  if sDisabled in AState then
  begin
    ACanvas.Brush.Color := clGrayText;
    ACanvas.Pen.Color := clGrayText;
  end
  else
  begin
    ACanvas.Brush.Color := clBlack;
    ACanvas.Pen.Color := clBlack;
  end;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Polygon([pt1, pt2, pt3]);
end;

{ TdxNavBarFlatPainter }

class function TdxNavBarFlatPainter.ButtonPainterClass: TdxNavBarCustomButtonPainterClass;
begin
  Result := TdxNavBarFlatButtonPainter;
end;

{ TdxNavBarFlatButtonPainter }

class procedure TdxNavBarFlatButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  inherited;
  if sPressed in AState then
    dxNavBarDrawSelectedFrame(ACanvas, ARect, DarkDarkBorderColor(AColor1), LightLightBorderColor(AColor1),
      DarkBorderColor(AColor1), clNone)
  else
    if sHotTracked in AState then
      dxNavBarDrawSelectedFrame(ACanvas, ARect, LightLightBorderColor(AColor1), DarkDarkBorderColor(AColor1),
        clNone, DarkBorderColor(AColor1))
    else
      dxNavBarDrawSelectedFrame(ACanvas, ARect, LightLightBorderColor(AColor1), DarkBorderColor(AColor1),
        clNone, clNone);
  if sActive in AState then
    FillRectByColor(ACanvas.Handle, cxRectSetBottom(ARect, ARect.Bottom, 1), clBlack);
end;

initialization
  RegisterView(dxNavBarBaseView, 'BaseView', TdxNavBarBasePainter);
  RegisterView(dxNavBarFlatView, 'FlatView', TdxNavBarFlatPainter);

finalization
  UnRegisterView(dxNavBarBaseView);
  UnRegisterView(dxNavBarFlatView);

end.
