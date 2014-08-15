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

unit dxSkinscxPC3Painter;

{$I cxVer.inc}

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics,
  dxCore, cxGraphics, cxGeometry, cxControls, cxLookAndFeels, dxSkinsCore,
  cxLookAndFeelPainters, cxPCPainters, cxPC, dxSkinsLookAndFeelPainter,
  cxPCPaintersFactory;

const
  cxNullPCDistance: TcxPCDistance = (dw: 0; dh: 0);

type
  { TcxPCSkinPainter }

  TcxPCSkinIndents = (siFar, siNear, siSelectedDownGrow, siHorzGrow, siVertGrow,
    siDownGrow, siDownGrowBottomRight, siSelectedDownGrowBottomRight);

  TcxPCSkinPainter = class(TcxPCTabsPainter)
  private
    FFrameContentCache: TdxSkinElementCache;
    function GetButtonHorz: TdxSkinElement;
    function GetButtonVert: TdxSkinElement;
    function GetFrameContent: TdxSkinElement;
    function GetHeader: TdxSkinElement;
    function GetIndentByIndex(AType: TcxPCSkinIndents): Integer;
    function GetNeedDrawTabBitmapBackground: Boolean;
    function GetSkinPainterData(var AData: TdxSkinLookAndFeelPainterInfo): Boolean;
    function GetTabState(ATabViewInfo: TcxTabViewInfo): TdxSkinElementState;
    procedure InternalCorrectCustomTabRect(APosition: TcxTabPosition; var ARect: TRect);
    procedure InternalCorrectMainTabRect(APosition: TcxTabPosition; var ARect: TRect);
  protected
    function CalculateTabNormalWidth(ATabViewInfo: TcxTabViewInfo): Integer; override;
    procedure CorrectTabNormalWidth(var AValue: Integer); override;
    function GetTabCorrection(ATabVisibleIndex: Integer): TcxPCRectCorrection; override;
    function GetTabClipRgn(ACanvas: TcxCanvas; ATabVisibleIndex: Integer): TcxRegion; override;
    procedure DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet); override;
    procedure FillTabPaneContent(ACanvas: TcxCanvas); override;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; override;
    function GetFreeSpaceColor: TColor; override;
    function GetLookAndFeelPainterClass: TcxCustomLookAndFeelPainterClass; override;
    function GetNativeContentOffset: TRect; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabFocusRect(const ATabBounds: TRect): TRect; override;
    function GetTabNormalContentOffset(ATabVisibleIndex: Integer): Integer; override;
    function GetTabsNormalDistance: TcxPCDistance; override;
    function GetTabsPosition(NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition; override;
    function GetTabTextNormalWidth(ATabVisibleIndex: Integer): Integer; override;
    function GetTextColor(ATabVisibleIndex: Integer): TColor; override;
    procedure InternalDrawText(ACanvas: TcxCanvas; const ACaption: string;
      ARect: TRect; ATabVisibleIndex: Integer); override;
    procedure InternalPaintFrame(ACanvas: TcxCanvas); override;
    function IsEnableHotTrack: Boolean; override;
    function IsNativePainting: Boolean; override;
    function IsSkinAvailable: Boolean;
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; override;
    function NeedDisabledTextShadow: Boolean; override;
    function NeedDoubleBuffer: Boolean; override;

    procedure DrawParentBackground(ACanvas: TcxCanvas; const R: TRect);
    procedure PaintButton(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxPCNavigatorButtonState; AType: TcxPCNavigatorButton); override;
    procedure PaintNativeTabBackground(DC: HDC; ATabVisibleIndex: Integer; const ABounds: TRect); override;
    procedure PaintTabsRegion(ACanvas: TcxCanvas); override;
    procedure PrepareTabBitmapBackground(ABitmap: TcxBitmap; const ARect: TRect; ATabViewInfo: TcxTabViewInfo); override;

    property ButtonHorz: TdxSkinElement read GetButtonHorz;
    property ButtonVert: TdxSkinElement read GetButtonVert;
    property FrameContent: TdxSkinElement read GetFrameContent;
    property FrameContentCache: TdxSkinElementCache read FFrameContentCache;
    property Header: TdxSkinElement read GetHeader;
    property Indents[AType: TcxPCSkinIndents]: Integer read GetIndentByIndex;
    property NeedDrawTabBitmapBackground: Boolean read GetNeedDrawTabBitmapBackground;
  public
    constructor Create(AViewInfo: TcxCustomTabControlViewInfo); override;
    destructor Destroy; override;
    function CalculateTabNormalHeight: Integer; override;
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

implementation

{$IFDEF DELPHI6}

uses
  Types, Math, dxSkinInfo;

{$ENDIF}

const
  TabPosition2cxBorder: array[TcxTabPosition] of TcxBorder = (
    bTop, bBottom, bLeft, bRight);

{ TcxPCSkinPainter }

constructor TcxPCSkinPainter.Create(AViewInfo: TcxCustomTabControlViewInfo);
begin
  inherited;
  FFrameContentCache := TdxSkinElementCache.Create;
end;

destructor TcxPCSkinPainter.Destroy;
begin
  FreeAndNil(FFrameContentCache);
  inherited Destroy;
end;

function TcxPCSkinPainter.CalculateTabNormalHeight: Integer;
begin
  if Header = nil then
    Result := inherited CalculateTabNormalHeight
  else
    with Header.ContentOffset do
      Result := Top + Bottom + inherited CalculateTabNormalHeight - 2;
end;

class function TcxPCSkinPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCSkinStyle;
end;

class function TcxPCSkinPainter.GetStyleName: TCaption;
begin
  Result := 'Skin';
end;

class function TcxPCSkinPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := ALookAndFeel.SkinPainter <> nil;
end;

function TcxPCSkinPainter.CalculateTabNormalWidth(ATabViewInfo: TcxTabViewInfo): Integer;
begin
  Result := inherited CalculateTabNormalWidth(ATabViewInfo);
  if ATabViewInfo.GetDefinedWidth > 0 then
    Inc(Result, GetTabNormalContentOffset(ATabViewInfo.VisibleIndex));
end;

procedure TcxPCSkinPainter.CorrectTabNormalWidth(var AValue: Integer);
begin
//do nothing
end;

procedure TcxPCSkinPainter.InternalCorrectCustomTabRect(APosition: TcxTabPosition; var ARect: TRect);
begin
  case APosition of
    tpTop:
      ARect.Bottom := Indents[siDownGrow] + 1;
    tpBottom:
      ARect.Top := -Indents[siDownGrowBottomRight] - 1;
    tpLeft:
      ARect.Right := Indents[siDownGrow] + 1;
    tpRight:
      ARect.Left := -Indents[siDownGrowBottomRight] - 1;
  end;
end;

procedure TcxPCSkinPainter.InternalCorrectMainTabRect(APosition: TcxTabPosition; var ARect: TRect);
begin
  case APosition of
    tpTop:
      ARect := Rect(-Indents[siHorzGrow], -Indents[siVertGrow],
        Indents[siHorzGrow], Indents[siSelectedDownGrow]);
    tpBottom:
      ARect := Rect(-Indents[siHorzGrow], -Indents[siSelectedDownGrowBottomRight],
        Indents[siHorzGrow], Indents[siVertGrow]);
    tpLeft:
      ARect := Rect(-Indents[siVertGrow], -Indents[siHorzGrow],
        Indents[siSelectedDownGrow], Indents[siHorzGrow]);
    tpRight:
      ARect := Rect(-Indents[siSelectedDownGrowBottomRight],
        -Indents[siHorzGrow], Indents[siVertGrow], Indents[siHorzGrow]);
  end;
end;

function TcxPCSkinPainter.GetTabCorrection(ATabVisibleIndex: Integer): TcxPCRectCorrection;
var
  ATabViewInfo: TcxTabViewInfo;
  ARect: TRect;
begin
  if IsSkinAvailable then
  begin
    ARect := cxNullRect;
    ATabViewInfo := TabViewInfo[ATabVisibleIndex];
    if ATabViewInfo.IsMainTab then
      InternalCorrectMainTabRect(ATabViewInfo.PaintingPosition, ARect)
    else
      InternalCorrectCustomTabRect(ATabViewInfo.PaintingPosition, ARect);
    Result := TcxPCRectCorrection(ARect);
  end
  else
    Result := inherited GetTabCorrection(ATabVisibleIndex);
end;

function TcxPCSkinPainter.GetTabClipRgn(ACanvas: TcxCanvas; ATabVisibleIndex: Integer): TcxRegion;
var
  ATabViewInfo: TcxTabViewInfo;
  ATabRect: TRect;
begin
  ATabViewInfo := TabViewInfo[ATabVisibleIndex];
  IntersectRect(ATabRect, ATabViewInfo.VisibleRect, ATabViewInfo.NormalRect);
  CorrectRect(ATabRect, GetTabCorrection(ATabVisibleIndex));
  Result := TcxRegion.Create(ATabRect);
end;

procedure TcxPCSkinPainter.FillTabPaneContent(ACanvas: TcxCanvas);
var
  AFrameContent: TdxSkinElement;
begin
  AFrameContent := FrameContent;
  if AFrameContent = nil then
    inherited
  else
    AFrameContent.Draw(ACanvas.Handle, GetPageFrameRect);
end;

procedure TcxPCSkinPainter.DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet);
var
  AFrameContent: TdxSkinElement;
  R: TRect;
begin
  AFrameContent := FrameContent;
  if AFrameContent = nil then
    inherited DrawNativeTabBackground(DC, ATab)
  else
  begin
    R := GetPageFrameRect;
    OffsetRect(R, -ATab.Left, -ATab.Top);
    AFrameContent.Draw(DC, R);
  end;
end;

function TcxPCSkinPainter.GetButtonWidth(Button: TcxPCNavigatorButton): Integer;
begin
  Result := 0;
  if ButtonHorz <> nil then
    Result := ButtonHorz.Image.Size.cx;
  if Result = 0 then
    Result := inherited GetButtonWidth(Button);
end;

function TcxPCSkinPainter.GetFreeSpaceColor: TColor;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinPainterData(ASkinInfo) and (ASkinInfo.ContentColor <> nil)  then
    Result := ASkinInfo.ContentColor.Value
  else
    Result := inherited GetFreeSpaceColor;
end;

function TcxPCSkinPainter.GetLookAndFeelPainterClass: TcxCustomLookAndFeelPainterClass;
begin
  if ViewInfo.GetLookAndFeel.SkinPainter <> nil then
    Result := ViewInfo.GetLookAndFeel.SkinPainter
  else
    Result := inherited GetLookAndFeelPainterClass;
end;

function TcxPCSkinPainter.GetNativeContentOffset: TRect;
begin
  if FrameContent = nil then
    Result := cxNullRect
  else
    Result := cxRectTransform(FrameContent.ContentOffset.Rect, 1, 1, 1, 1);
end;

function TcxPCSkinPainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  if Header <> nil then
  begin
    Result.Left := Header.ContentOffset.Left;
    Result.Right := Header.ContentOffset.Right;
  end
  else
    Result := inherited GetTabContentWOffset(ATabVisibleIndex);
end;

function TcxPCSkinPainter.GetTabFocusRect(const ATabBounds: TRect): TRect;
begin
  if Header = nil then
    Result := inherited GetTabFocusRect(ATabBounds)
  else
  begin
    Result := cxRectContent(ATabBounds, Header.ContentOffset.Rect);
    Dec(Result.Bottom, Indents[siSelectedDownGrow]);
    InflateRect(Result, 1, 1);
  end;
end;

function TcxPCSkinPainter.GetTabNormalContentOffset(ATabVisibleIndex: Integer): Integer;
begin
  if Header <> nil then
    Result := Header.ContentOffset.Left + Header.ContentOffset.Right
  else
    Result := inherited GetTabNormalContentOffset(ATabVisibleIndex);
end;

function TcxPCSkinPainter.GetTabsNormalDistance: TcxPCDistance;
begin
  Result := cxNullPCDistance;
  if ViewInfo.ActuallyRotate then
    Result.dw := Indents[siVertGrow]
  else
    Result.dh := Indents[siVertGrow];
end;

function TcxPCSkinPainter.GetTabsPosition(
  NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition;
var
  AddX: Integer;
  NormalTabsRectCorrection: TRect;

  procedure DoHardCalculation;
  var
    AButtonsWidth: Integer;
    ATabsContainerOffset: TRect;
  begin
    AButtonsWidth := CalculateButtonsRegionWidth(NavigatorButtons);
    if AButtonsWidth <> 0 then
      Inc(AButtonsWidth);
    ATabsContainerOffset := cxEmptyRect;
    if ViewInfo.IsTabsContainer then
      ATabsContainerOffset := GetTabsContainerOffsets;

    NormalTabsRectCorrection := RotateRect(Rect(0, Indents[siVertGrow] + ATabsContainerOffset.Top, 0, 0), ViewInfo.TabPosition);
    ExtendRect(Result.ExtendedTabsRect, RotateRect(Rect(0, ATabsContainerOffset.Top, 0, 0), ViewInfo.TabPosition));
    with ViewInfo do
    begin
      if TabPosition in [tpTop, tpBottom] then
      begin
        if MultiLine or (NavigatorButtons = []) then
        begin
          Result.ExtendedTabsRect.Left := ATabsContainerOffset.Left + Indents[siNear];
          Result.ExtendedTabsRect.Right := Width - ATabsContainerOffset.Left - Indents[siFar];
        end
        else
        begin
          if NavigatorPosition in [npLeftTop, npLeftBottom] then
          begin
            Result.ExtendedTabsRect.Left := AButtonsWidth;
            Result.ExtendedTabsRect.Right := Width - ATabsContainerOffset.Left - Indents[siFar];
          end
          else
          begin
            Result.ExtendedTabsRect.Left := ATabsContainerOffset.Left + Indents[siNear];
            Result.ExtendedTabsRect.Right := Width - AButtonsWidth;
          end;
        end;
        Result.NormalTabsRect.Left := Result.ExtendedTabsRect.Left + AddX;
        Result.NormalTabsRect.Right := Result.ExtendedTabsRect.Right - AddX;
        Result.NormalRowWidth := Result.NormalTabsRect.Right - Result.NormalTabsRect.Left;
      end
      else
      begin
        if MultiLine or (NavigatorButtons = []) then
        begin
          Result.ExtendedTabsRect.Top := ATabsContainerOffset.Left + Indents[siNear];
          Result.ExtendedTabsRect.Bottom := Height - ATabsContainerOffset.Left - Indents[siFar];
        end
        else
        begin
          if NavigatorPosition in [npLeftTop, npRightTop] then
          begin
            Result.ExtendedTabsRect.Top := AButtonsWidth;
            Result.ExtendedTabsRect.Bottom := Height - ATabsContainerOffset.Left - Indents[siFar];
          end
          else
          begin
            Result.ExtendedTabsRect.Top := ATabsContainerOffset.Left + Indents[siNear];
            Result.ExtendedTabsRect.Bottom := Height - AButtonsWidth;
          end;
        end;
        Result.NormalTabsRect.Top := Result.ExtendedTabsRect.Top + AddX;
        Result.NormalTabsRect.Bottom := Result.ExtendedTabsRect.Bottom - AddX;
        Result.NormalRowWidth := Result.NormalTabsRect.Bottom - Result.NormalTabsRect.Top;
      end;
    end;
  end;

begin
  if IsSkinAvailable then
  begin
    AddX := Indents[siHorzGrow];
    with Result do
    begin
      ExtendedTabsRect := Rect(0, 0, ViewInfo.Width, ViewInfo.Height);
      NormalTabsRect := ExtendedTabsRect;
      DoHardCalculation;
      cxGraphics.ExtendRect(NormalTabsRect, NormalTabsRectCorrection);
      ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 0;
      ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := 0;
      if ViewInfo.TabPosition in [tpTop, tpLeft] then
        ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 1
      else
        ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := -1;
      MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects := 0;
    end;
    CalculateButtonsRegion(NavigatorButtons);
  end
  else
    Result := inherited GetTabsPosition(NavigatorButtons);
end;

function TcxPCSkinPainter.GetTabTextNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  Result := inherited GetTabTextNormalWidth(ATabVisibleIndex) + 2;
end;

function TcxPCSkinPainter.GetTextColor(ATabVisibleIndex: Integer): TColor;
var
  ASkinColor: TdxSkinColor;
  ASkinPainterInfo: TdxSkinLookAndFeelPainterInfo;
  ATabViewInfo: TcxTabViewInfo;
begin
  ATabViewInfo := ViewInfo.TabsViewInfo[ATabVisibleIndex];
  ASkinColor := nil;
  if GetSkinPainterData(ASkinPainterInfo) then
  begin
    if not ATabViewInfo.Enabled then
      ASkinColor := ASkinPainterInfo.TabTextColorDisabled
    else
      if ATabViewInfo.IsMainTab then
        ASkinColor := ASkinPainterInfo.TabTextColorActive
      else
        if ATabViewInfo.IsHotTrack then
          ASkinColor := ASkinPainterInfo.TabTextColorHot
        else
          ASkinColor := ASkinPainterInfo.TabTextColor;
  end;
  if ASkinColor = nil then
    Result := inherited GetTextColor(ATabVisibleIndex)
  else
    Result := ASkinColor.Value;
end;

procedure TcxPCSkinPainter.InternalDrawText(ACanvas: TcxCanvas; const ACaption: string;
  ARect: TRect; ATabVisibleIndex: Integer);
begin
  ACanvas.Font.Color := GetTextColor(ATabVisibleIndex);
  cxDrawText(ACanvas.Handle, ACaption, ARect, DT_SINGLELINE or DT_END_ELLIPSIS);
end;

procedure TcxPCSkinPainter.InternalPaintFrame(ACanvas: TcxCanvas);

  procedure ValidateFrameRect(var R: TRect; const AOffsets: TRect);
  begin
    if ViewInfo.IsTabsContainer then
    begin
      if ViewInfo.TabPosition in [tpTop, tpBottom] then
        InflateRect(R, Max(AOffsets.Left, AOffsets.Right), 0)
      else
        InflateRect(R, 0, Max(AOffsets.Top, AOffsets.Bottom));
    end;

    if ViewInfo.TabPosition = tpBottom then
      R.Top := Min(R.Top, R.Bottom - (AOffsets.Top + AOffsets.Bottom))
    else
      R.Bottom := Max(R.Bottom, R.Top + AOffsets.Top + AOffsets.Bottom);

    if ViewInfo.TabPosition = tpRight then
      R.Left := Min(R.Left, R.Right - (AOffsets.Left + AOffsets.Right))
    else
      R.Right := Max(R.Right, R.Left + AOffsets.Left + AOffsets.Right);
  end;

var
  ARect, ADrawRect: TRect;
begin
  if FrameContent = nil then
    inherited InternalPaintFrame(ACanvas)
  else
  begin
    ARect := GetPageFrameRect;
    ADrawRect := GetDrawFrameRect;
    if FrameContent.IsAlphaUsed then
      DrawParentBackground(ACanvas, ViewInfo.ClientRect);

    cxPaintCanvas.BeginPaint(ACanvas.Canvas);
    try
      cxPaintCanvas.SetClipRegion(TcxRegion.Create(ARect), roIntersect);
      ValidateFrameRect(ADrawRect, GetNativeContentOffset);
      if FrameContent.Image.GradientBeginColor = clNone then
        FrameContentCache.DrawEx(ACanvas.Handle, FrameContent, ADrawRect)
      else
        FrameContent.Draw(ACanvas.Handle, ADrawRect);
    finally
      cxPaintCanvas.EndPaint;
    end;
    if ACanvas.Handle = ViewInfo.Canvas.Handle then
      ViewInfo.Canvas.ExcludeClipRect(ARect);
  end;
end;

function TcxPCSkinPainter.IsEnableHotTrack: Boolean;
begin
  Result := True;
end;

function TcxPCSkinPainter.IsNativePainting: Boolean;
begin
  if IsSkinAvailable then
    Result := True
  else
    Result := inherited IsNativePainting;
end;

function TcxPCSkinPainter.IsSkinAvailable: Boolean;
begin
  Result := ViewInfo.GetLookAndFeel.SkinPainter <> nil;
end;

function TcxPCSkinPainter.IsTabBorderThick(ATabVisibleIndex: Integer): Boolean;
begin
  Result := False;
end;

function TcxPCSkinPainter.NeedDisabledTextShadow: Boolean;
begin
  Result := False;
end;

function TcxPCSkinPainter.NeedDoubleBuffer: Boolean;
begin
  Result := False;//#AI: not IsWinVistaOrLater; LC2
end;

procedure TcxPCSkinPainter.DrawParentBackground(ACanvas: TcxCanvas; const R: TRect);
begin
  if ViewInfo.CanDrawParentBackground then
    cxDrawTransparentControlBackground(ViewInfo.IControl.GetControl, ACanvas, R, False)
  else
    FillFreeSpaceArea(ACanvas, R);
end;

procedure TcxPCSkinPainter.PaintButton(ACanvas: TcxCanvas; const ARect: TRect;
  AState: TcxPCNavigatorButtonState; AType: TcxPCNavigatorButton);
const
  ButtonKindVert: array[TcxPCNavigatorButton] of Integer = (2, 1, 3, 0);
  ButtonKindHorz: array[TcxPCNavigatorButton] of Integer = (1, 2, 3, 0);
  ButtonStates: array[TcxPCNavigatorButtonState] of TdxSkinElementState = (
    esNormal, esPressed, esHot, esDisabled);
var
  AElement: TdxSkinElement;
  AImageIndex: Integer;
begin
  if (ButtonHorz = nil) or (ButtonVert = nil) then
    inherited
  else
  begin
    if ViewInfo.TabPosition in [tpTop, tpBottom] then
    begin
      AElement := ButtonHorz;
      AImageIndex := ButtonKindHorz[AType];
    end
    else
    begin
      AElement := ButtonVert;
      AImageIndex := ButtonKindVert[AType];
    end;
    if AElement.IsAlphaUsed then
      DrawParentBackground(ACanvas, ARect);
    AElement.Draw(ACanvas.Handle, ARect, AImageIndex,
      ButtonStates[AState]);
  end;
end;

procedure TcxPCSkinPainter.PaintNativeTabBackground(DC: HDC;
  ATabVisibleIndex: Integer; const ABounds: TRect);
begin
  if Header = nil then
    inherited PaintNativeTabBackground(DC, ATabVisibleIndex, ABounds)
  else
    Header.Draw(DC, ABounds, 0, GetTabState(ViewInfo.TabsViewInfo[ATabVisibleIndex]));
end;

procedure TcxPCSkinPainter.PaintTabsRegion(ACanvas: TcxCanvas);

  procedure PaintLine(ATabIndexInterval: TcxPCIndexInterval; AIsUpperLine, AIsLowerLine: Boolean);
  var
    I: Integer;
  begin
    for I := ATabIndexInterval.Left to ATabIndexInterval.Right do
      if I <> ViewInfo.MainTabVisibleIndex then
        PaintTab(ACanvas, I);
  end;

var
  J: Integer;
  ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  AFirstIndex, AlastIndex: Integer;
begin
  if IsSkinAvailable then
  begin
    ViewInfo.InitializeVisibleTabRange(AFirstIndex, AlastIndex);

    if (ViewInfo.MainTabVisibleIndex <> -1) and
      (AFirstIndex <= ViewInfo.MainTabVisibleIndex) and
      (ViewInfo.MainTabVisibleIndex <= AlastIndex) then
      PaintTab(ACanvas, ViewInfo.MainTabVisibleIndex);

    ViewInfo.InitializeLineBoundsArray(ALineIndexBoundsA);

    for J := ViewInfo.TopOrLeftPartRowCount - 1 downto 0 do
      PaintLine(ALineIndexBoundsA[J], J = 0, J = ViewInfo.TopOrLeftPartRowCount - 1);

    for J := ViewInfo.TopOrLeftPartRowCount to ViewInfo.RowCount - 1 do
      PaintLine(ALineIndexBoundsA[J], J = ViewInfo.RowCount - 1, J = ViewInfo.TopOrLeftPartRowCount);
  end
  else
    inherited PaintTabsRegion(ACanvas);
end;

procedure TcxPCSkinPainter.PrepareTabBitmapBackground(ABitmap: TcxBitmap; 
  const ARect: TRect; ATabViewInfo: TcxTabViewInfo);
var
  R: TRect;
begin
  inherited PrepareTabBitmapBackground(ABitmap, ARect, ATabViewInfo);
  if (FrameContent <> nil) and NeedDrawTabBitmapBackground then
  begin
    R := GetPageFrameRect;
    OffsetRect(R, -ATabViewInfo.FullRect.Left, -ATabViewInfo.FullRect.Top);
    if ATabViewInfo.IsMainTab then
    begin
      case ATabViewInfo.PaintingPosition of
        tpBottom:
          OffsetRect(R, 0, 1);
        tpRight:
          OffsetRect(R, 1, 0);
      end;
    end;
    FrameContent.Draw(ABitmap.Canvas.Handle, R);
  end;
end;

function TcxPCSkinPainter.GetButtonHorz: TdxSkinElement;
var
  ASkinPainterInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinPainterInfo) then
    Result := ASkinPainterInfo.PageControlButtonHorz;
end;

function TcxPCSkinPainter.GetButtonVert: TdxSkinElement;
var
  ASkinPainterInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinPainterInfo) then
    Result := ASkinPainterInfo.PageControlButtonVert;
end;

function TcxPCSkinPainter.GetFrameContent: TdxSkinElement;
var
  ASkinPainterInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinPainterInfo) then
    if ViewInfo.HideTabs then
    begin
      if ViewInfo.ShowFrame then
        Result := ASkinPainterInfo.GroupBoxElements[cxgpCenter]
      else
        Result := ASkinPainterInfo.FormContent;
    end
    else
      Result := ASkinPainterInfo.PageControlPane;
end;

function TcxPCSkinPainter.GetHeader: TdxSkinElement;
var
  ASkinPainterInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinPainterInfo) then
    Result := ASkinPainterInfo.PageControlHeader;
end;

function TcxPCSkinPainter.GetIndentByIndex(AType: TcxPCSkinIndents): Integer;
var
  ASkinPainterInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := 0;
  if GetSkinPainterData(ASkinPainterInfo) then
    Result := ASkinPainterInfo.PageControlIndents[Integer(AType)];
end;

function TcxPCSkinPainter.GetNeedDrawTabBitmapBackground: Boolean;
begin
  Result := {(Indents[siDownGrow] > 1) and} (Header <> nil) and Header.IsAlphaUsed;
end;

function TcxPCSkinPainter.GetSkinPainterData(var AData: TdxSkinLookAndFeelPainterInfo): Boolean;
begin
  Result := GetExtendedStylePainters.GetPainterData(
    ViewInfo.GetLookAndFeel.SkinPainter, AData);
end;

function TcxPCSkinPainter.GetTabState(ATabViewInfo: TcxTabViewInfo): TdxSkinElementState;
begin
  if not ATabViewInfo.Enabled then
    Result := esDisabled
  else
    if ATabViewInfo.IsMainTab then
      Result := esPressed
    else
      if ATabViewInfo.IsHotTrack or ATabViewInfo.IsHighlighted then
        Result := esHot
      else
        Result := esNormal;
end;

initialization
  RegisterPCPainterClass(TcxPCSkinPainter);

finalization
  UnregisterPCPainterClass(TcxPCSkinPainter);

end.
