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

unit dxSkinsLookAndFeelPainter;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Graphics, SysUtils, ImgList, 
  cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, cxGraphics, cxGeometry, cxClasses, dxGdiPlusApi,
  dxSkinsCore, dxSkinInfo, dxSkinsStrs;

type
  { TdxSkinLookAndFeelPainterInfo }

  TdxSkinLookAndFeelPainterInfo = class(TdxSkinInfo);

  { TcxSkinLookAndFeelPainter }

  TdxSkinLookAndFeelPainter = class(TcxOffice11LookAndFeelPainter)
  protected
    class function CacheData: TdxSkinLookAndFeelPainterInfo; virtual;
    class procedure DrawContent(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect; AState: Integer;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False); override;
    class procedure DrawFooterBorderEx(ACanvas: TcxCanvas; const R: TRect;
      ABorders: TcxBorders); override;
    class procedure DrawSchedulerNavigationButtonContent(ACanvas: TcxCanvas;
      const ARect: TRect; const AArrowRect: TRect; AIsNextButton: Boolean;
      AState: TcxButtonState); override;
    class function IsColorAssigned(AColor: TColor): Boolean;
    class function IsColorPropertyAssigned(AColor: TdxSkinColor): Boolean;
  public
    // colors
    class function DefaultContentColor: TColor; override;
    class function DefaultContentEvenColor: TColor; override;
    class function DefaultContentOddColor: TColor; override;
    class function DefaultContentTextColor: TColor; override;
    class function DefaultEditorBackgroundColorEx(AKind: TcxEditStateColorKind): TColor; override;
    class function DefaultEditorTextColorEx(AKind: TcxEditStateColorKind): TColor; override;
    class function DefaultFilterBoxTextColor: TColor; override;
    class function DefaultFixedSeparatorColor: TColor; override;
    class function DefaultFooterColor: TColor; override;
    class function DefaultGridDetailsSiteColor: TColor; override;
    class function DefaultGridLineColor: TColor; override;
    class function DefaultGroupByBoxTextColor: TColor; override;
    class function DefaultGroupColor: TColor; override;
    class function DefaultGroupTextColor: TColor; override;
    class function DefaultHeaderBackgroundColor: TColor; override;
    class function DefaultHeaderBackgroundTextColor: TColor; override;
    class function DefaultHeaderColor: TColor; override;
    class function DefaultHeaderTextColor: TColor; override;
    class function DefaultHyperlinkTextColor: TColor; override;
    class function DefaultPreviewTextColor: TColor; override;
    class function DefaultRecordSeparatorColor: TColor; override;
    class function DefaultSchedulerBackgroundColor: TColor; override;
    class function DefaultSchedulerBorderColor: TColor; override;
    class function DefaultSchedulerControlColor: TColor; override;
    class function DefaultSchedulerNavigatorColor: TColor; override;
    class function DefaultSchedulerTimeRulerColor: TColor; override;
    class function DefaultSchedulerTimeRulerTextColor: TColor; override;
    class function DefaultSchedulerViewSelectedTextColor: TColor; override;
    class function DefaultSchedulerViewTextColor: TColor; override;
    class function DefaultSelectionColor: TColor; override;
    class function DefaultSelectionTextColor: TColor; override;
    class function DefaultSeparatorColor: TColor; override;
    class function DefaultSizeGripAreaColor: TColor; override;
    class function DefaultTimeGridMajorScaleTextColor: TColor; override;
    class function DefaultTimeGridMinorScaleTextColor: TColor; override;

    class function DefaultDateNavigatorHeaderColor: TColor; override;
    class function DefaultDateNavigatorHeaderTextColor(AIsHighlight: Boolean): TColor; override;
    class function DefaultDateNavigatorHolydayTextColor: TColor; override;
    class function DefaultDateNavigatorInactiveTextColor: TColor; override;
    class function DefaultDateNavigatorSelectionColor: TColor; override;
    class function DefaultDateNavigatorSelectionTextColor: TColor; override;
    class function DefaultDateNavigatorSeparator1Color: TColor; override;
    class function DefaultDateNavigatorSeparator2Color: TColor; override;
    class function DefaultDateNavigatorTextColor: TColor; override;
    class function DefaultDateNavigatorTodayFrameColor: TColor; override;
    class function DefaultDateNavigatorTodayTextColor: TColor; override;

    class function DefaultVGridBandLineColor: TColor; override;
    class function DefaultVGridCategoryColor: TColor; override;
    class function DefaultVGridCategoryTextColor: TColor; override;
    class function DefaultVGridHeaderColor: TColor; override;
    class function DefaultVGridHeaderTextColor: TColor; override;
    class function DefaultVGridLineColor: TColor; override;
    // borders
    class procedure DrawBorder(ACanvas: TcxCanvas; R: TRect); override;
  {$IFDEF EXPRESSLIBRARY7}
    class procedure DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
      AWidth: Integer; AColor: TColor; ABorders: TcxBorders); override;
  {$ENDIF}
    class procedure DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean); override;
    // buttons
    class function AdjustGroupButtonDisplayRect(const R: TRect; AButtonCount, AButtonIndex: Integer): TRect; override;
    class function ButtonBorderSize(AState: TcxButtonState = cxbsNormal): Integer; override;
    class function ButtonColor(AState: TcxButtonState): TColor; override;
    class function ButtonFocusRect(ACanvas: TcxCanvas; R: TRect): TRect; override;
    class function ButtonGroupBorderSizes(AButtonCount, AButtonIndex: Integer): TRect; override;
    class function ButtonSymbolColor(AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor; override;
    class function ButtonTextOffset: Integer; override;
    class function ButtonTextShift: Integer; override;
    class procedure DrawButton(ACanvas: TcxCanvas; R: TRect; const ACaption: string;
      AState: TcxButtonState; ADrawBorder: Boolean = True;
      AColor: TColor = clDefault; ATextColor: TColor = clDefault;
      AWordWrap: Boolean = False; AIsToolButton: Boolean = False); override;
    class procedure DrawButtonGroupBorder(ACanvas: TcxCanvas; R: TRect; AInplace, ASelected: Boolean); override;
    class procedure DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
      ABackgroundColor: TColor); override;
    class procedure DrawExpandButton(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AColor: TColor = clDefault); override;
    class procedure DrawExpandButtonEx(ACanvas: TcxCanvas; const R: TRect;
      AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0); override;
    class function DrawExpandButtonFirst: Boolean; override;
    class procedure DrawGroupExpandButton(ACanvas: TcxCanvas; const R: TRect;
      AExpanded: Boolean; AState: TcxButtonState); override;
    class procedure DrawSmallExpandButton(ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
      ABorderColor: TColor; AColor: TColor = clDefault); override;
    class function ExpandButtonSize: Integer; override;
    class function GroupExpandButtonSize: Integer; override;
    class function SmallExpandButtonSize: Integer; override;
    class function IsButtonHotTrack: Boolean; override;
    class function IsPointOverGroupExpandButton(const R: TRect; const P: TPoint): Boolean; override;
    // scroll bars
    class function ScrollBarMinimalThumbSize(AVertical: Boolean): Integer; override;
    class procedure DrawScrollBarBackground(ACanvas: TcxCanvas; const R: TRect;
      AHorizontal: Boolean); override;
    class procedure DrawScrollBarPart(ACanvas: TcxCanvas; AHorizontal: Boolean;
      R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState); override;
    // label line
    class procedure DrawLabelLine(ACanvas: TcxCanvas; const R: TRect;
      AOuterColor, AInnerColor: TColor; AIsVertical: Boolean); override;
    class function LabelLineHeight: Integer; override;
    // size grip
    class function SizeGripSize: TSize; override;
    class procedure DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect); override;
    // SmallCloseButton
    class function SmallCloseButtonSize: TSize; override;
    class procedure DrawSmallCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    // RadioGroup
    class procedure DrawRadioButton(ACanvas: TcxCanvas; X, Y: Integer;
      AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
      ABrushColor: TColor;  AIsDesigning: Boolean = False); override;
    class function RadioButtonSize: TSize; override;
    // Checkbox
    class function CheckButtonSize: TSize; override;
    class procedure DrawCheckButton(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState; ACheckState: TcxCheckBoxState); override;
    // Editors
    class procedure DrawClock(ACanvas: TcxCanvas; const ARect: TRect;
      ADateTime: TDateTime; ABackgroundColor: TColor); override;
    class procedure DrawEditorButton(ACanvas: TcxCanvas; const ARect: TRect;
      AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
      APosition: TcxEditBtnPosition = cxbpRight); override;
    class function EditButtonTextOffset: Integer; override;
    class function EditButtonSize: TSize; override;
    class function EditButtonTextColor: TColor; override;
    class function GetContainerBorderColor(AIsHighlightBorder: Boolean): TColor; override;
  {$IFDEF EXPRESSLIBRARY7}
    class function GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer; override;
  {$ENDIF}
    // Navigator
    class procedure DrawNavigatorGlyph(ACanvas: TcxCanvas;
      AImageList: TCustomImageList; AImageIndex: {$IFDEF DELPHI5}TImageIndex{$ELSE}Integer{$ENDIF};
      AButtonIndex: Integer; const AGlyphRect: TRect; AEnabled: Boolean; AUserGlyphs: Boolean); override;
    class function NavigatorGlyphSize: TSize; override;
    // ProgressBar
    class procedure DrawProgressBarBorder(ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean); override;
    class procedure DrawProgressBarChunk(ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean); override;
    class function ProgressBarBorderSize(AVertical: Boolean): TRect; override;
    class function ProgressBarTextColorEx(AIsFilledArea: Boolean): TColor; override;
    // GroupBox
    class procedure DrawGroupBoxBackground(ACanvas: TcxCanvas; ABounds: TRect;
      ARect: TRect); override;
    class procedure DrawGroupBoxCaption(ACanvas: TcxCanvas; ACaptionRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition); override;
    class procedure DrawGroupBoxContent(ACanvas: TcxCanvas; ABorderRect: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    class procedure DrawGroupBoxExpandButton(ACanvas: TcxCanvas;
      const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0); override;
    class function GroupBoxBorderSize(ACaption: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition): TRect; override;
    class procedure DrawGroupBoxFrame(ACanvas: TcxCanvas; R: TRect; AEnabled: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition; ABorders: TcxBorders = cxBordersAll); override;
    class function GroupBoxTextColor(AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor; override;
    class function IsGroupBoxTransparent(AIsCaption: Boolean;
      ACaptionPosition: TcxGroupBoxCaptionPosition): Boolean; override;
    class function PanelTextColor: TColor; override;
    // Header
    class procedure DrawHeader(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
      AIsGroup: Boolean = False); override;
    class procedure DrawHeaderEx(ACanvas: TcxCanvas; const ABounds, ATextAreaBounds: TRect;
      ANeighbors: TcxNeighbors; ABorders: TcxBorders; AState: TcxButtonState;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawHeaderSeparator(ACanvas: TcxCanvas; const ABounds: TRect;
      AIndentSize: Integer; AColor: TColor; AViewParams: TcxViewParams); override;
    class function HeaderBorders(ANeighbors: TcxNeighbors): TcxBorders; override;
    class function HeaderDrawCellsFirst: Boolean; override;
    // Grid
    class procedure DrawGroupByBox(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); override;
    class function GridDrawHeaderCellsFirst: Boolean; override;
    class function GridGroupRowStyleOffice11ContentColor(AHasData: Boolean): TColor; override;
    class function GridGroupRowStyleOffice11SeparatorColor: TColor; override;
    class function GridGroupRowStyleOffice11TextColor: TColor; override;
    class function PivotGridHeadersAreaColor: TColor; override;
    class function PivotGridHeadersAreaTextColor: TColor; override;
    // Layout View
    class procedure LayoutViewDrawRecordCaption(ACanvas: TcxCanvas; const ABounds: TRect;
      APosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState); override;
    class procedure LayoutViewDrawRecordContent(ACanvas: TcxCanvas; const ABounds: TRect;
      ACaptionPosition: TcxGroupBoxCaptionPosition; AState: TcxButtonState; ABorders: TcxBorders = cxBordersAll); override;
    class procedure LayoutViewDrawRecordExpandButton(ACanvas: TcxCanvas;
      const ABounds: TRect; AState: TcxButtonState; AExpanded: Boolean); override;
    class procedure LayoutViewDrawItem(ACanvas: TcxCanvas; const ABounds: TRect;
      AState: TcxButtonState; ABorders: TcxBorders = []); override;
    class function LayoutViewGetPadding(AElement: TcxLayoutElement): TRect; override;
    class function LayoutViewGetSpacing(AElement: TcxLayoutElement): TRect; override;
    // Footer
    class procedure DrawFooterBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawFooterCellContent(ACanvas: TcxCanvas; const ABounds: TRect;
      AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert; AMultiLine: Boolean;
      const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
      AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawFooterContent(ACanvas: TcxCanvas; const ARect: TRect;
      const AViewParams: TcxViewParams); override;
    class function FooterCellBorderSize: Integer; override;
    class function FooterDrawCellsFirst: Boolean; override;
    class function FooterSeparatorColor: TColor; override;
    // filter
    class function FilterCloseButtonSize: TPoint; override;
    class procedure DrawFilterCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState); override;
    class procedure DrawFilterDropDownButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean); override;
    class procedure DrawFilterPanel(ACanvas: TcxCanvas; const ARect: TRect;
      ATransparent: Boolean; ABackgroundColor: TColor; const ABackgroundBitmap: TBitmap); override;
    // Panel
    class procedure DrawPanelBorders(ACanvas: TcxCanvas; const ABorderRect: TRect); override;
    class procedure DrawPanelContent(ACanvas: TcxCanvas; const ABorderRect: TRect; ABorder: Boolean); override;
    // TrackBar
    class procedure DrawTrackBarTrack(ACanvas: TcxCanvas; const ARect, ASelection: TRect;
      AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor); override;
    class procedure DrawTrackBarThumb(ACanvas: TcxCanvas; const ARect: TRect;
      AState: TcxButtonState; AHorizontal: Boolean;
      ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor); override;
    class function TrackBarThumbSize(AHorizontal: Boolean): TSize; override;
    class function TrackBarTrackSize: Integer; override;
    // Splitter
    class procedure DrawSplitter(ACanvas: TcxCanvas; const ARect: TRect;
      AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean); override;
    class function GetSplitterSize(AHorizontal: Boolean): TSize; override;
    // Indicator
    class procedure DrawIndicatorCustomizationMark(ACanvas: TcxCanvas;
      const R: TRect; AColor: TColor); override;
    class procedure DrawIndicatorImage(ACanvas: TcxCanvas; const R: TRect; AKind: TcxIndicatorKind); override;
    class procedure DrawIndicatorItem(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawIndicatorItemEx(ACanvas: TcxCanvas; const R: TRect;
      AKind: TcxIndicatorKind; AColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class function IndicatorDrawItemsFirst: Boolean; override;
    // ms outlook
    class procedure DrawMonthHeader(ACanvas: TcxCanvas; const ABounds: TRect;
      const AText: string; ANeighbors: TcxNeighbors; const AViewParams: TcxViewParams;
      AArrows: TcxHeaderArrows; ASideWidth: Integer; AOnDrawBackground: TcxDrawBackgroundEvent = nil); override;
    class procedure DrawSchedulerEventProgress(ACanvas: TcxCanvas;
      const ABounds, AProgress: TRect; AViewParams: TcxViewParams; ATransparent: Boolean); override;
    class function SchedulerEventProgressOffsets: TRect; override;
    class function SchedulerNavigationButtonTextColor(AIsNextButton: Boolean;
      AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor; override;
    // Scheduler
    class procedure CalculateSchedulerNavigationButtonRects(AIsNextButton: Boolean;
      ACollapsed: Boolean; APrevButtonTextSize: TSize; ANextButtonTextSize: TSize;
      var ABounds: TRect; out ATextRect: TRect; out AArrowRect: TRect); override;
    class procedure DrawSchedulerNavigatorButton(ACanvas: TcxCanvas; R: TRect;
      AState: TcxButtonState); override;
    class procedure SchedulerNavigationButtonSizes(AIsNextButton: Boolean;
      var ABorders: TRect; var AArrowSize: TSize; var AHasTextArea: Boolean); override;
    // Layout Control
    class function LayoutControlEmptyAreaColor: TColor; override;
    class procedure DrawLayoutControlBackground(ACanvas: TcxCanvas; const R: TRect); override;
    // Popup
  {$IFDEF EXPRESSLIBRARY7}
    class procedure DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
      ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean); override;
    class function GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer; override;
    class function GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer; override;
  {$ENDIF}
    class procedure DrawWindowContent(ACanvas: TcxCanvas; const ARect: TRect); override;
    // Printing System
    class function PrintPreviewPageBordersWidth: TRect; override;
    class procedure DrawPrintPreviewBackground(ACanvas: TcxCanvas; const R: TRect); override;
    class procedure DrawPrintPreviewPageBackground(ACanvas: TcxCanvas;
      const ABorderRect, AContentRect: TRect; ASelected, ADrawContent: Boolean); override;
    // DateNavigator
    class procedure DrawDateNavigatorDateHeader(ACanvas: TcxCanvas; var R: TRect); override;
    // CalcEdit
    class function CalcEditButtonTextColor(AButtonKind: TcxCalcButtonKind): TColor; override;
    // Customization Form
    class function GetCustomizationFormListBackgroundColor: TColor; override;
    //
    class function InternalUnitName: string; virtual;
  end;

  TdxSkinLookAndFeelPainterClass = class of TdxSkinLookAndFeelPainter;

  procedure RegisterSkin(ASkin: TdxSkin; APainter: TdxSkinLookAndFeelPainterClass); overload;
  procedure RegisterSkin(const ASkinName: string; APainter: TdxSkinLookAndFeelPainterClass;
    ALoadFromResource: Boolean; AInstance: THandle); overload;
  procedure UnregisterSkin(const ASkinName: string);

implementation

uses
  Math, dxSkinsDefaultPainters;

const
  ButtonStateToSkinState: array[TcxButtonState] of TdxSkinElementState = (
    esActive, esNormal, esHot, esPressed, esDisabled
  );

var
  PaintersManager: TcxExtendedStylePainters;

function cxRectExclude(const R, ABordersWidth: TRect; ABorders: TcxBorders): TRect;
begin
  Result := R;
  if not (bLeft in ABorders) then
    Dec(Result.Left, ABordersWidth.Left);
  if not (bTop in ABorders) then
    Dec(Result.Top, ABordersWidth.Top);
  if not (bRight in ABorders) then
    Inc(Result.Right, ABordersWidth.Right);
  if not (bBottom in ABorders) then
    Inc(Result.Bottom, ABordersWidth.Bottom);
end;

procedure dxSkinElementMakeDisable(ABitmap: TcxBitmap32);
var
  AColor: TRGBQuad;
  AColors: TRGBColors;
  I, AGray: Integer;
begin
  ABitmap.GetBitmapColors(AColors);
  try
    for I := 0 to Length(AColors) - 1 do
    begin
      AColor := AColors[I];
      AGray := (2 * AColor.rgbReserved + AColor.rgbBlue + AColor.rgbGreen + AColor.rgbRed) div 5;
      AColor.rgbBlue := AGray;
      AColor.rgbGreen := AGray;
      AColor.rgbRed := AGray;
      AColors[I] := AColor;
    end;
  finally
    ABitmap.SetBitmapColors(AColors);
  end;
end;

{ TdxSkinLookAndFeelPainter }

class function TdxSkinLookAndFeelPainter.InternalUnitName: string; 
begin
  Result := 'dxSkinsLookAndFeelPainter';
end;

class function TdxSkinLookAndFeelPainter.DefaultContentColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ContentColor) then
      Result := ContentColor.Value
    else
      Result := inherited DefaultContentColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultContentEvenColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ContentEvenColor) then
      Result := ContentEvenColor.Value
    else
      Result := inherited DefaultContentEvenColor
end;

class function TdxSkinLookAndFeelPainter.DefaultContentOddColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ContentOddColor) then
      Result := ContentOddColor.Value
    else
      Result := inherited DefaultContentOddColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultContentTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ContentTextColor) then
      Result := ContentTextColor.Value
    else
      Result := inherited DefaultContentTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultEditorBackgroundColorEx(
  AKind: TcxEditStateColorKind): TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(EditorBackgroundColors[AKind]) then
      Result := EditorBackgroundColors[AKind].Value
    else
      if AKind in [esckReadOnly, esckInactive] then
        Result := DefaultEditorBackgroundColorEx(esckNormal)
      else
        Result := inherited DefaultEditorBackgroundColorEx(AKind);
end;

class function TdxSkinLookAndFeelPainter.DefaultEditorTextColorEx(
  AKind: TcxEditStateColorKind): TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(EditorTextColors[AKind]) then
      Result := EditorTextColors[AKind].Value
    else
      if AKind in [esckReadOnly, esckInactive] then
        Result := DefaultEditorTextColorEx(esckNormal)
      else
        Result := inherited DefaultEditorTextColorEx(AKind);
end;

class function TdxSkinLookAndFeelPainter.DefaultFilterBoxTextColor: TColor;
begin
  with CacheData do
    if FilterPanel = nil then
      Result := inherited DefaultFilterBoxTextColor
    else
      Result := FilterPanel.TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultFixedSeparatorColor: TColor;
begin
  with CacheData do
    if GridFixedLine = nil then
      Result := inherited DefaultFixedSeparatorColor
    else
      Result := GridFixedLine.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultFooterColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultGridDetailsSiteColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ContentColor) then
      Result := ContentColor.Value
    else
      Result := inherited DefaultGridDetailsSiteColor
end;

class function TdxSkinLookAndFeelPainter.DefaultGridLineColor: TColor;
begin
  with CacheData do
    if GridLine = nil then
      Result := inherited DefaultGridLineColor
    else
      Result := GridLine.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultGroupColor: TColor;
begin
  with CacheData do
    if GridGroupRow = nil then
      Result := inherited DefaultGroupColor
    else
      Result := GridGroupRow.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultGroupByBoxTextColor: TColor;
begin
  with CacheData do
    if GridGroupByBox = nil then
      Result := inherited DefaultGroupByBoxTextColor
    else
      Result := GridGroupByBox.TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultGroupTextColor: TColor;
begin
  with CacheData do
    if GridGroupRow = nil then
      Result := inherited DefaultGroupTextColor
    else
      Result := GridGroupRow.TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultHeaderBackgroundColor: TColor;
begin
  with CacheData do
    if HeaderBackgroundColor = nil then
      Result := inherited DefaultHeaderBackgroundColor
    else
      Result := HeaderBackgroundColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultHeaderBackgroundTextColor: TColor;
begin
  with CacheData do
    if HeaderBackgroundTextColor = nil then
      Result := inherited DefaultHeaderBackgroundTextColor
    else
      Result := HeaderBackgroundTextColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultHeaderColor: TColor;
begin
  with CacheData do
    if Header = nil then
      Result := inherited DefaultHeaderColor
    else
      Result := Header.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultHeaderTextColor: TColor;
begin
  with CacheData do
    if Header = nil then
      Result := inherited DefaultHeaderTextColor
    else
      Result := Header.TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultHyperlinkTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(HyperLinkTextColor) then
      Result := HyperLinkTextColor.Value
    else
      Result := inherited DefaultHyperlinkTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultPreviewTextColor: TColor;
begin
  Result := DefaultHyperlinkTextColor;
end;

class function TdxSkinLookAndFeelPainter.LayoutControlEmptyAreaColor: TColor;
begin
  with CacheData do
    if LayoutControlColor = nil then
      Result := inherited LayoutControlEmptyAreaColor
    else
      Result := LayoutControlColor.Value;
end;

class procedure TdxSkinLookAndFeelPainter.DrawLayoutControlBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  ACanvas.FillRect(R, LayoutControlEmptyAreaColor);
end;

{$IFDEF EXPRESSLIBRARY7}
class procedure TdxSkinLookAndFeelPainter.DrawEditPopupWindowBorder(ACanvas: TcxCanvas; var R: TRect;
  ABorderStyle: TcxEditPopupBorderStyle; AClientEdge: Boolean);
begin
  ACanvas.FrameRect(R, GetContainerBorderColor(False));
  InflateRect(R, -1, -1);
end;

class function TdxSkinLookAndFeelPainter.GetEditPopupWindowBorderWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := 1;
end;

class function TdxSkinLookAndFeelPainter.GetEditPopupWindowClientEdgeWidth(AStyle: TcxEditPopupBorderStyle): Integer;
begin
  Result := 2;
end;
{$ENDIF}

class function TdxSkinLookAndFeelPainter.DefaultSelectionColor: TColor;
begin
  with CacheData do
    if SelectionColor = nil then
      Result := inherited DefaultSelectionColor
    else
      Result := SelectionColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerTimeRulerColor: TColor;
begin
  with CacheData do
    if Assigned(SchedulerTimeRuler) and IsColorAssigned(SchedulerTimeRuler.Color) then
      Result := SchedulerTimeRuler.Color
    else
      Result := inherited DefaultSchedulerTimeRulerColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerTimeRulerTextColor: TColor;
begin
  with CacheData do
    if Assigned(SchedulerTimeRuler) and IsColorAssigned(SchedulerTimeRuler.TextColor) then
      Result := SchedulerTimeRuler.TextColor
    else
      Result := inherited DefaultSchedulerTimeRulerTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultSelectionTextColor: TColor;
begin
  with CacheData do
    if SelectionTextColor = nil then
      Result := inherited DefaultSelectionTextColor
    else
      Result := SelectionTextColor.Value;  
end;

class function TdxSkinLookAndFeelPainter.DefaultSeparatorColor: TColor;
begin
  with CacheData do
    if CardViewSeparator = nil then
      Result := inherited DefaultSeparatorColor
    else
      Result := CardViewSeparator.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerBackgroundColor: TColor;
begin
  with CacheData do
    if ContentColor = nil then
      Result := inherited DefaultSchedulerBackgroundColor
    else
      Result := ContentColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerBorderColor: TColor;
begin
  with CacheData do
    if ContainerBorderColor = nil then
      Result := inherited DefaultSchedulerBorderColor
    else
      Result := ContainerBorderColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerControlColor: TColor;
begin
  with CacheData do
    if ContentColor = nil then
      Result := inherited DefaultSchedulerControlColor
    else
      Result := ContentColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerNavigatorColor: TColor;
begin
  with CacheData do
    if SchedulerNavigatorColor = nil then
      Result := inherited DefaultSchedulerNavigatorColor
    else
      Result := SchedulerNavigatorColor.Value;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerViewSelectedTextColor: TColor;
begin
  Result := DefaultSchedulerViewTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultSchedulerViewTextColor: TColor;
begin
  with CacheData do
    if SchedulerAppointment[True] = nil then
      Result := inherited DefaultSchedulerViewTextColor
    else
      Result := SchedulerAppointment[True].TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultSizeGripAreaColor: TColor;
begin
  Result := clDefault;
  with CacheData do
    if FormContent <> nil then
      Result := FormContent.Color;
  if Result = clDefault then
    Result := inherited DefaultSizeGripAreaColor; 
end;

class function TdxSkinLookAndFeelPainter.DefaultTimeGridMajorScaleTextColor: TColor;
begin
  with CacheData do
    if (SchedulerTimeGridHeader[False] <> nil) and
      IsColorAssigned(SchedulerTimeGridHeader[False].TextColor)
    then
      Result := SchedulerTimeGridHeader[False].TextColor
    else
      Result := inherited DefaultTimeGridMajorScaleTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultTimeGridMinorScaleTextColor: TColor;
begin
  Result := DefaultTimeGridMajorScaleTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultRecordSeparatorColor: TColor;
begin
  with CacheData do
    if GridFixedLine = nil then
      Result := inherited DefaultRecordSeparatorColor
    else
      Result := GridFixedLine.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorHeaderColor: TColor;
begin
  Result := DefaultHeaderColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorHeaderTextColor(
  AIsHighlight: Boolean): TColor;
begin
  Result := DefaultHeaderTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarDayTextColor) then
      Result := CalendarDayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorHolydayTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarHolidayTextColor) then
      Result := CalendarHolidayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorHolydayTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorInactiveTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarInactiveDayTextColor) then
      Result := CalendarInactiveDayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorInactiveTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSelectionColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarSelectedDayColor) then
      Result := CalendarSelectedDayColor.Value
    else
      Result := inherited DefaultDateNavigatorSelectionColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSelectionTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarSelectedDayTextColor) then
      Result := CalendarSelectedDayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorSelectionTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSeparator1Color: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarSeparatorColor) then
      Result := CalendarSeparatorColor.Value
    else
      Result := inherited DefaultDateNavigatorSeparator1Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorSeparator2Color: TColor;
begin
  Result := clNone;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorTodayFrameColor: TColor;
begin
  with CacheData do 
    if IsColorPropertyAssigned(CalendarTodayFrameColor) then
      Result := CalendarTodayFrameColor.Value
    else
      Result := inherited DefaultDateNavigatorTodayFrameColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultDateNavigatorTodayTextColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalendarTodayTextColor) then
      Result := CalendarTodayTextColor.Value
    else
      Result := inherited DefaultDateNavigatorTodayTextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultVGridBandLineColor: TColor;
begin
  with CacheData do
  begin
    if VGridLine[True] = nil then
      Result := inherited DefaultVGridBandLineColor
    else
      Result := VGridLine[True].Color;
  end;
end;

class function TdxSkinLookAndFeelPainter.DefaultVGridCategoryColor: TColor;
begin
  with CacheData do
    if VGridCategory = nil then
      Result := inherited DefaultVGridCategoryColor
    else
      Result := VGridCategory.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultVGridCategoryTextColor: TColor;
begin
  with CacheData do
    if VGridCategory = nil then
      Result := inherited DefaultVGridCategoryTextColor
    else
      Result := VGridCategory.TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultVGridHeaderColor: TColor;
begin
  with CacheData do
    if VGridRowHeader = nil then
      Result := inherited DefaultVGridHeaderColor
    else
      Result := VGridRowHeader.Color;
end;

class function TdxSkinLookAndFeelPainter.DefaultVGridHeaderTextColor: TColor;
begin
  with CacheData do
    if VGridRowHeader = nil then
      Result := inherited DefaultVGridHeaderTextColor
    else
      Result := VGridRowHeader.TextColor;
end;

class function TdxSkinLookAndFeelPainter.DefaultVGridLineColor: TColor;
begin
  with CacheData do
  begin
    if VGridLine[False] = nil then
      Result := inherited DefaultVGridLineColor
    else
      Result := VGridLine[False].Color;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawBorder(ACanvas: TcxCanvas; R: TRect);
begin
  if CacheData.ContainerBorderColor = nil then
    inherited DrawBorder(ACanvas, R)
  else
    ACanvas.FrameRect(R, CacheData.ContainerBorderColor.Value);
end;

{$IFDEF EXPRESSLIBRARY7}
class procedure TdxSkinLookAndFeelPainter.DrawContainerBorder(ACanvas: TcxCanvas; const R: TRect; AStyle: TcxContainerBorderStyle;
  AWidth: Integer; AColor: TColor; ABorders: TcxBorders);
begin
  inherited DrawContainerBorder(ACanvas, R, cbsSingle, AWidth, AColor, ABorders);
end;
{$ENDIF}

class procedure TdxSkinLookAndFeelPainter.DrawSeparator(ACanvas: TcxCanvas; const R: TRect; AIsVertical: Boolean);
begin
  DrawLabelLine(ACanvas, GetSeparatorBounds(R, 2, AIsVertical), clDefault, clDefault, AIsVertical);
end;

class function TdxSkinLookAndFeelPainter.AdjustGroupButtonDisplayRect(
  const R: TRect; AButtonCount, AButtonIndex: Integer): TRect;
begin
  Result := inherited AdjustGroupButtonDisplayRect(R, AButtonCount, AButtonIndex);
end;

class function TdxSkinLookAndFeelPainter.ButtonBorderSize(
  AState: TcxButtonState = cxbsNormal): Integer;
begin
  if CacheData.ButtonElements <> nil then
    Result := 0
  else
    Result := inherited ButtonBorderSize(AState);
end;

class function TdxSkinLookAndFeelPainter.ButtonColor(
  AState: TcxButtonState): TColor;
begin
  Result := inherited ButtonColor(AState);
end;

class function TdxSkinLookAndFeelPainter.ButtonFocusRect(
  ACanvas: TcxCanvas; R: TRect): TRect;
begin
  Result := inherited ButtonFocusRect(ACanvas, R);
end;

class function TdxSkinLookAndFeelPainter.ButtonGroupBorderSizes(
  AButtonCount, AButtonIndex: Integer): TRect;
var
  AGlyphSize: TSize;
  AXOffset: Integer;
  AYOffset: Integer;
begin
  with CacheData do
  begin
    if EditButtonElements[False] <> nil then
    begin
      AGlyphSize := NavigatorGlyphSize;
      AXOffset := (EditButtonElements[False].Size.cx - AGlyphSize.cx) div 2;
      AYOffset := (EditButtonElements[False].Size.cy - AGlyphSize.cy) div 2;
      Result := Rect(AXOffset, AYOffset, AXOffset, AYOffset);
    end
    else
      Result := inherited ButtonGroupBorderSizes(AButtonCount, AButtonIndex);
  end;
end;

class function TdxSkinLookAndFeelPainter.ButtonSymbolColor(
  AState: TcxButtonState; ADefaultColor: TColor = clDefault): TColor;
begin
  with CacheData do
    if ButtonElements = nil then
      Result := inherited ButtonSymbolColor(AState, ADefaultColor)
    else
      if (AState = cxbsDisabled) and (ButtonDisabled <> nil) then
        Result := ButtonDisabled.Value
      else
        Result := ButtonElements.TextColor;
end;

class function TdxSkinLookAndFeelPainter.ButtonTextOffset: Integer;
begin
  Result := inherited ButtonTextOffset;
end;

class function TdxSkinLookAndFeelPainter.ButtonTextShift: Integer;
begin
  Result := inherited ButtonTextShift;
end;

class procedure TdxSkinLookAndFeelPainter.DrawButton(ACanvas: TcxCanvas;
  R: TRect; const ACaption: string; AState: TcxButtonState; ADrawBorder: Boolean = True;
  AColor: TColor = clDefault; ATextColor: TColor = clDefault;
  AWordWrap: Boolean = False; AIsToolButton: Boolean = False);
var
  AFlags: Integer;
begin
  with ACanvas, CacheData do
    if ButtonElements <> nil then
    begin
      ButtonElements.Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
      R := cxRectContent(R, ButtonElements.ContentOffset.Rect);
      if ATextColor = clDefault then
        Font.Color := ButtonSymbolColor(AState)
      else
        Font.Color := ATextColor;
      Brush.Style := bsClear;
      with R do // for compatible with standard buttons
      begin
        Dec(Bottom, Ord(Odd(Bottom - Top)));
        if (Bottom - Top) < 18 then Dec(Top);
      end;
      if AState = cxbsPressed then
        OffsetRect(R, ButtonTextShift, ButtonTextShift);
      if Length(ACaption) > 0 then
      begin
        AFlags := cxAlignVCenter or cxShowPrefix or cxAlignHCenter;
        if AWordWrap then
          AFlags := AFlags or cxWordBreak
        else
          AFlags := AFlags or cxSingleLine;
        DrawText(ACaption, R, AFlags, AState <> cxbsDisabled);
      end;
      Brush.Style := bsSolid;
    end
    else
      inherited DrawButton(ACanvas, R, ACaption, AState, ADrawBorder, AColor,
        ATextColor, AWordWrap);
end;

class procedure TdxSkinLookAndFeelPainter.DrawButtonGroupBorder(ACanvas: TcxCanvas;
  R: TRect; AInplace, ASelected: Boolean);
begin
end;

class procedure TdxSkinLookAndFeelPainter.DrawButtonInGroup(ACanvas: TcxCanvas; R: TRect;
  AState: TcxButtonState; AButtonCount, AButtonIndex: Integer;
  ABackgroundColor: TColor);
begin
  DrawEditorButton(ACanvas, R, cxbkEditorBtn, AState);
end;

class procedure TdxSkinLookAndFeelPainter.DrawExpandButton(ACanvas: TcxCanvas;
  const R: TRect; AExpanded: Boolean; AColor: TColor = clDefault);
begin
  with CacheData do
  begin
    if ExpandButton = nil then
      inherited DrawExpandButton(ACanvas, R, AExpanded, AColor)
    else
      ExpandButton.Draw(ACanvas.Handle, R, Byte(AExpanded));
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawExpandButtonEx(
  ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0);
begin
  DrawExpandButton(ACanvas, R, AExpanded);
end;

class function TdxSkinLookAndFeelPainter.DrawExpandButtonFirst: Boolean;
begin
  Result := inherited DrawExpandButtonFirst;
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupExpandButton(
  ACanvas: TcxCanvas; const R: TRect; AExpanded: Boolean; AState: TcxButtonState);
begin
  inherited DrawGroupExpandButton(ACanvas,R, AExpanded, AState);
end;

class procedure TdxSkinLookAndFeelPainter.DrawSmallExpandButton(
  ACanvas: TcxCanvas; R: TRect; AExpanded: Boolean;
  ABorderColor: TColor; AColor: TColor = clDefault);
begin
  with CacheData do
  begin
    if ExpandButton = nil then
      inherited DrawSmallExpandButton(ACanvas, R, AExpanded, ABorderColor, AColor)
    else
      ExpandButton.Draw(ACanvas.Handle, R, Byte(AExpanded));
  end; 
end;

class function TdxSkinLookAndFeelPainter.ExpandButtonSize: Integer;
begin
  with CacheData do
  begin
    if ExpandButton = nil then
      Result := inherited ExpandButtonSize
    else
      Result := ExpandButton.Size.cy;  
  end;
end;

class function TdxSkinLookAndFeelPainter.GroupExpandButtonSize: Integer;
begin
  Result := inherited GroupExpandButtonSize;
end;

class function TdxSkinLookAndFeelPainter.SmallExpandButtonSize: Integer;
begin
  Result := inherited SmallExpandButtonSize;
end;

class function TdxSkinLookAndFeelPainter.IsButtonHotTrack: Boolean;
begin
  Result := inherited IsButtonHotTrack;
end;

class function TdxSkinLookAndFeelPainter.IsPointOverGroupExpandButton(
  const R: TRect; const P: TPoint): Boolean;
begin
  Result := inherited IsPointOverGroupExpandButton(R, P);
end;

class function TdxSkinLookAndFeelPainter.ScrollBarMinimalThumbSize(AVertical: Boolean): Integer;
var
  AInfo: TdxSkinScrollInfo;
begin
  AInfo := CacheData.ScrollBar_Elements[not AVertical, sbpThumbnail];
  if (AInfo = nil) or (AInfo.Element = nil) then
    Result := inherited ScrollBarMinimalThumbSize(AVertical)
  else
    if AVertical then
      Result := AInfo.Element.Size.cy
    else
      Result := AInfo.Element.Size.cx;
end;

class procedure TdxSkinLookAndFeelPainter.DrawScrollBarBackground(
  ACanvas: TcxCanvas; const R: TRect; AHorizontal: Boolean);
var
  AScrollInfoElement: TdxSkinScrollInfo;
begin
  AScrollInfoElement := CacheData.ScrollBar_Elements[AHorizontal, sbpPageUp];
  if (AScrollInfoElement = nil) or (AScrollInfoElement.Element = nil) then
    inherited DrawScrollBarBackground(ACanvas, R, AHorizontal)
  else
  begin
    AScrollInfoElement.Element.UseCache := True;
    AScrollInfoElement.Element.Draw(ACanvas.Handle, R);
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawScrollBarPart(ACanvas: TcxCanvas;
  AHorizontal: Boolean; R: TRect; APart: TcxScrollBarPart; AState: TcxButtonState);
var
  AScrollPartInfo: TdxSkinScrollInfo;
begin
  AScrollPartInfo := CacheData.ScrollBar_Elements[AHorizontal, APart];
  if (AScrollPartInfo = nil) or (AScrollPartInfo.Element = nil) then
    inherited DrawScrollBarPart(ACanvas, AHorizontal, R, APart, AState)
  else
    if not ((APart in [sbpPageUp, sbpPageDown]) and (AState = cxbsNormal)) then
      AScrollPartInfo.Draw(ACanvas.Handle, R, ButtonStateToSkinState[AState]);
end;

class procedure TdxSkinLookAndFeelPainter.DrawLabelLine(ACanvas: TcxCanvas;
  const R: TRect; AOuterColor, AInnerColor: TColor; AIsVertical: Boolean);
begin
  with CacheData do
    if LabelLine[AIsVertical] = nil then
      inherited DrawLabelLine(ACanvas, R, AOuterColor, AInnerColor, AIsVertical)
    else
      LabelLine[AIsVertical].Draw(ACanvas.Handle, R);
end;

class function TdxSkinLookAndFeelPainter.LabelLineHeight: Integer;
begin
  with CacheData do
    if LabelLine[False] = nil then
      Result := inherited LabelLineHeight
    else
      Result := LabelLine[False].MinSize.Height;
end;

class function TdxSkinLookAndFeelPainter.SizeGripSize: TSize;
begin
  with CacheData do
    if SizeGrip = nil then
      Result := inherited SizeGripSize
    else
      Result := SizeGrip.Size
end;

class procedure TdxSkinLookAndFeelPainter.DoDrawSizeGrip(ACanvas: TcxCanvas; const ARect: TRect);
begin
  with CacheData do
    if SizeGrip = nil then
      inherited DoDrawSizeGrip(ACanvas, ARect)
    else
      SizeGrip.Draw(ACanvas.Handle, ARect);
end;

class function TdxSkinLookAndFeelPainter.SmallCloseButtonSize: TSize;
begin
  with CacheData do
    if PageControlCloseButton = nil then
      Result := inherited SmallCloseButtonSize
    else
      Result := PageControlCloseButton.MinSize.Size;
end;

class procedure TdxSkinLookAndFeelPainter.DrawSmallCloseButton(ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  with CacheData do
    if PageControlCloseButton = nil then
      inherited DrawSmallCloseButton(ACanvas, R, AState)
    else
      PageControlCloseButton.Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
end;

class procedure TdxSkinLookAndFeelPainter.DrawRadioButton(ACanvas: TcxCanvas;
  X, Y: Integer; AButtonState: TcxButtonState; AChecked, AFocused: Boolean;
  ABrushColor: TColor;  AIsDesigning: Boolean = False);
var
  ADestRect: TRect;
begin
  with CacheData do
  begin
    if RadioGroupButton <> nil then
    begin
      ADestRect := Rect(X, Y, X + RadioGroupButton.Size.cX, Y + RadioGroupButton.Size.cy);
      if ABrushColor <> clDefault then
        ACanvas.FillRect(ADestRect, ABrushColor);
      RadioGroupButton.Draw(ACanvas.Handle, ADestRect, Byte(AChecked),
        ButtonStateToSkinState[AButtonState]);
    end
    else
      inherited DrawRadioButton(ACanvas, X, Y, AButtonState, AChecked, AFocused,
        ABrushColor, AIsDesigning);
  end;      
end;

class function TdxSkinLookAndFeelPainter.RadioButtonSize: TSize;
begin
  with CacheData do
    if RadioGroupButton <> nil then
      Result := RadioGroupButton.Size
    else
      Result := inherited RadioButtonSize;
end;

class function TdxSkinLookAndFeelPainter.CheckButtonSize: TSize;
begin
  with CacheData do
    if CheckboxElement <> nil then
      Result := CheckboxElement.Size
    else
      Result := inherited CheckButtonSize;
end;

class function TdxSkinLookAndFeelPainter.CalcEditButtonTextColor(
  AButtonKind: TcxCalcButtonKind): TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(CalcEditButtonTextColors[AButtonKind]) then
      Result := CalcEditButtonTextColors[AButtonKind].Value
    else
      Result := inherited CalcEditButtonTextColor(AButtonKind);
end;

class function TdxSkinLookAndFeelPainter.GetCustomizationFormListBackgroundColor: TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ContentColor) then
      Result := ContentColor.Value
    else
      Result := inherited GetCustomizationFormListBackgroundColor;
end;

class procedure TdxSkinLookAndFeelPainter.DrawCheckButton(ACanvas: TcxCanvas;
  R: TRect; AState: TcxButtonState; ACheckState: TcxCheckBoxState);
const
  ImageIndexMap: array[TcxCheckBoxState] of Integer = (0, 1, 2);
begin
  with CacheData do
    if CheckboxElement = nil then
      inherited DrawCheckButton(ACanvas, R, AState, ACheckState)
    else
      CheckboxElement.Draw(ACanvas.Handle, R, ImageIndexMap[ACheckState],
        ButtonStateToSkinState[AState]);
end;

class procedure TdxSkinLookAndFeelPainter.DrawClock(ACanvas: TcxCanvas;
  const ARect: TRect; ADateTime: TDateTime; ABackgroundColor: TColor);

  procedure DrawHand(ACanvas: TCanvas; ACenter: TPoint;
    AAngle, L1X, L1Y, L2X, L2Y, L3: Extended; AHandColor: TColor);
  begin
    with ACanvas do
    begin
      Brush.Color := AHandColor;
      BeginPath(Handle);
      Pixels[Round(ACenter.X + L1X * cos(AAngle)),
        Round(ACenter.Y + L1Y * sin(AAngle))] := clTeal;
      Pen.Color := clTeal;
      MoveTo(Round(ACenter.X + L1X * cos(AAngle)),
        Round(ACenter.Y + L1Y * sin(AAngle)));
      LineTo(Round(ACenter.X + L3 / 2 * cos(AAngle + Pi / 2)),
        Round(ACenter.Y + L3 / 2 * sin(AAngle + Pi / 2)));
      LineTo(Round(ACenter.X + L2X * cos(AAngle + Pi)),
        Round(ACenter.Y + L2Y * sin(AAngle + Pi)));
      LineTo(Round(ACenter.X + L3 / 2 * cos(AAngle + Pi * 3 / 2)),
        Round(ACenter.Y + L3 / 2 * sin(AAngle + Pi * 3 / 2)));
      LineTo(Round(ACenter.X + L1X * cos(AAngle)),
        Round(ACenter.Y + L1Y * sin(AAngle)));
      EndPath(Handle);
      FillPath(Handle);
    end;
  end;

  procedure DrawHands(ACanvas: TCanvas; AHandColor: TColor);
  var
    AAngle: Extended;
    ACenter: TPoint;
    AHandRadiusX, AHandRadiusY: Extended;
    AHour, AMin, AMSec, ASec: Word;
  begin
    DecodeTime(ADateTime, AHour, AMin, ASec, AMSec);
    ACenter.X := (ARect.Right + ARect.Left) div 2;
    ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
    AHandRadiusX := (ARect.Right - ARect.Left) / 2 - 2;
    AHandRadiusY := (ARect.Bottom - ARect.Top) / 2 - 2;
    with ACanvas do
    begin
      AAngle := Pi * 2 * ((AHour mod 12) * 60 * 60 + AMin * 60 + ASec - 3 * 60 * 60) / 12 / 60 / 60;
      DrawHand(ACanvas, ACenter, AAngle, AHandRadiusX * 0.75, AHandRadiusY * 0.75,
        AHandRadiusX * 0.15, AHandRadiusY * 0.15, 9, AHandColor);

      AAngle := Pi * 2 * (AMin * 60 + ASec - 15 * 60) / 60 / 60;
      DrawHand(ACanvas, ACenter, AAngle, AHandRadiusX * 0.85, AHandRadiusY * 0.85,
        AHandRadiusX * 0.2, AHandRadiusY * 0.2, 7, AHandColor);

      Pen.Color := AHandColor;
      MoveTo(ACenter.X, ACenter.Y);
      AAngle := Pi * 2 * (ASec - 15) / 60;
      LineTo(Round(ACenter.X + AHandRadiusX * 0.9 * cos(AAngle)),
        Round(ACenter.Y + AHandRadiusY * 0.9 * sin(AAngle)));
    end;
  end;

var
  ABitmap: TBitmap;  
begin
  with CacheData do
    if (ClockElements[False] = nil) or (ClockElements[True] = nil) then
      inherited DrawClock(ACanvas, ARect, ADateTime, ABackgroundColor)
    else
      begin
        ABitmap := TBitmap.Create;
        try
          ABitmap.Width := ARect.Right - ARect.Left;
          ABitmap.Height := ARect.Bottom - ARect.Top;
          ABitmap.Canvas.Brush.Color := ABackgroundColor;
          ABitmap.Canvas.FillRect(ARect);
          ClockElements[False].Draw(ABitmap.Canvas.Handle, ARect);
          DrawHands(ABitmap.Canvas, ClockElements[False].TextColor);
          ClockElements[True].Draw(ABitmap.Canvas.Handle, ARect);
          with ARect do
            BitBlt(ACanvas.Handle, Left, Top, Right - Left, Bottom - Top,
              ABitmap.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          ABitmap.Free;
        end;
      end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawEditorButton(ACanvas: TcxCanvas;
  const ARect: TRect; AButtonKind: TcxEditBtnKind; AState: TcxButtonState;
  APosition: TcxEditBtnPosition = cxbpRight);

  procedure DrawEllipsis(R: TRect; ASize: Integer);
  var
    AColor: TColor;
  begin
    R := cxRectCenter(R, 3 * ASize + 4, ASize);
    AColor := CacheData.EditButtonElements[False].TextColor;
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Left + ASize, R.Top + ASize), AColor);
    ACanvas.FillRect(Rect(R.Left + ASize + 2, R.Top, R.Left + ASize * 2 + 2, R.Top + ASize), AColor);
    ACanvas.FillRect(Rect(R.Left + ASize * 2 + 4, R.Top, R.Left + ASize * 3 + 4, R.Top + ASize), AColor);
  end;

  function GetGlyphRect(const R: TRect; AElement: TdxSkinElement): TRect;
  begin
    Result := cxRectContent(R, AElement.ContentOffset.Rect);
    if CacheData.EditButtonMergeBorders then
    begin
      if APosition = cxbpLeft then
        Dec(Result.Left, AElement.ContentOffset.Left - 1)
      else
        Inc(Result.Right, AElement.ContentOffset.Right - 1);
    end;
  end;

const
  EllipseSizeMap: array[Boolean] of Integer = (1, 2);
var
  AElement: TdxSkinElement;
  R: TRect;
begin
  if (CacheData.EditButtonElements[True] = nil) or (CacheData.EditButtonElements[False] = nil) then
    inherited DrawEditorButton(ACanvas, ARect, AButtonKind, AState, APosition)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      R := ARect;
      ACanvas.IntersectClipRect(ARect);
      AElement := CacheData.EditButtonElements[AButtonKind = cxbkCloseBtn];
      if CacheData.EditButtonMergeBorders then
      begin
        InflateRect(R, 0, 1);
        if APosition = cxbpLeft then
          Dec(R.Left)
        else
          Inc(R.Right);
      end;
      AElement.Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);

      R := GetGlyphRect(R, AElement);
      if AButtonKind = cxbkEllipsisBtn then
        DrawEllipsis(R, EllipseSizeMap[cxRectWidth(R) >= 12])
      else
        if CacheData.EditButtonGlyphs[AButtonKind] <> nil then
          CacheData.EditButtonGlyphs[AButtonKind].Glyph.Draw(ACanvas.Handle, R);
   finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

class function TdxSkinLookAndFeelPainter.EditButtonTextOffset: Integer;
begin
  Result := 1;
end;

class function TdxSkinLookAndFeelPainter.EditButtonSize: TSize;
begin
  if CacheData.EditButtonElements[False] = nil then
    Result := inherited EditButtonSize
  else
    Result := CacheData.EditButtonElements[False].Size;
end;

class function TdxSkinLookAndFeelPainter.EditButtonTextColor: TColor;
begin
  with CacheData do
    if EditButtonElements[False] = nil then
      Result := inherited EditButtonTextColor
    else
      Result := EditButtonElements[False].TextColor;
end;

class function TdxSkinLookAndFeelPainter.GetContainerBorderColor(
  AIsHighlightBorder: Boolean): TColor;
var
  ASkinColor: TdxSkinColor;
begin
  with CacheData do
  begin
    if AIsHighlightBorder then
      ASkinColor := ContainerHighlightBorderColor
    else
      ASkinColor := ContainerBorderColor;
    if ASkinColor = nil then
      Result := inherited GetContainerBorderColor(AIsHighlightBorder)
    else
      Result := ASkinColor.Value;
  end;
end;

{$IFDEF EXPRESSLIBRARY7}
class function TdxSkinLookAndFeelPainter.GetContainerBorderWidth(ABorderStyle: TcxContainerBorderStyle): Integer;
const
  BordersWidthMap: array [Boolean] of Integer = (1, cxContainerMaxBorderWidth);
begin
  if ABorderStyle = cbsNone then
    Result := inherited GetContainerBorderWidth(ABorderStyle)
  else
    Result := BordersWidthMap[ABorderStyle = cbsThick];
end;
{$ENDIF}

class procedure TdxSkinLookAndFeelPainter.DrawNavigatorGlyph(ACanvas: TcxCanvas;
  AImageList: TCustomImageList; AImageIndex: {$IFDEF DELPHI5}TImageIndex{$ELSE}Integer{$ENDIF};
  AButtonIndex: Integer; const AGlyphRect: TRect; AEnabled: Boolean;
  AUserGlyphs: Boolean);
var
  ABitmap: TcxAlphaBitmap;
  AElement: TdxSkinElement;
begin
  with CacheData do
    if (NavigatorGlyphs = nil) or (NavigatorGlyphsVert = nil) or AUserGlyphs then
      inherited DrawNavigatorGlyph(ACanvas, AImageList, AImageIndex,
        AButtonIndex, AGlyphRect, AEnabled, AUserGlyphs)
    else
      if not IsRectEmpty(AGlyphRect) then
      begin
        AElement := NavigatorGlyphs;
        if NavigatorGlyphs.ImageCount <= AImageIndex then
        begin
          AElement := NavigatorGlyphsVert;
          Dec(AImageIndex, NavigatorGlyphs.ImageCount);
        end;

        if AEnabled then
          AElement.Draw(ACanvas.Handle, AGlyphRect, AImageIndex)
        else
        begin
          ABitmap := TcxAlphaBitmap.CreateSize(AGlyphRect, True);
          try
            AElement.Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect, AImageIndex);
            dxSkinElementMakeDisable(ABitmap);
            cxAlphaBlend(ACanvas.Handle, ABitmap, AGlyphRect, ABitmap.ClientRect);
          finally
            ABitmap.Free;
          end;
        end;
      end;
end;

class function TdxSkinLookAndFeelPainter.NavigatorGlyphSize: TSize;
begin
  with CacheData do
    if NavigatorGlyphs = nil then
      Result := inherited NavigatorGlyphSize
    else
      Result := NavigatorGlyphs.Size;
end;

class procedure TdxSkinLookAndFeelPainter.DrawProgressBarBorder(ACanvas: TcxCanvas;
  ARect: TRect; AVertical: Boolean);
begin
  with CacheData do
    if ProgressBarElements[False, AVertical] <> nil then
      ProgressBarElements[False, AVertical].Draw(ACanvas.Handle, ARect)
    else
      inherited DrawProgressBarBorder(ACanvas, ARect, AVertical);
end;

class procedure TdxSkinLookAndFeelPainter.DrawProgressBarChunk(
  ACanvas: TcxCanvas; ARect: TRect; AVertical: Boolean);
begin
  with CacheData do
    if ProgressBarElements[True, AVertical] <> nil then
      ProgressBarElements[True, AVertical].Draw(ACanvas.Handle, ARect)
    else
      inherited DrawProgressBarChunk(ACanvas, ARect, AVertical);
end;

class function TdxSkinLookAndFeelPainter.ProgressBarBorderSize(AVertical: Boolean): TRect;
begin
  with CacheData do
    if ProgressBarElements[False, AVertical] <> nil then
      Result := ProgressBarElements[False, AVertical].ContentOffset.Rect
    else
      Result := inherited ProgressBarBorderSize(AVertical);
end;

class function TdxSkinLookAndFeelPainter.ProgressBarTextColorEx(AIsFilledArea: Boolean): TColor;
begin
  with CacheData do
    if IsColorPropertyAssigned(ProgressBarTextColors[AIsFilledArea]) then
      Result := ProgressBarTextColors[AIsFilledArea].Value
    else
      Result := inherited ProgressBarTextColorEx(AIsFilledArea);
end;

class function TdxSkinLookAndFeelPainter.GroupBoxBorderSize(
  ACaption: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TRect;
var
  AGroupBoxInfo: TdxSkinElement;
begin
  with CacheData do
    if ACaption then
      AGroupBoxInfo := GroupBoxCaptionElements[ACaptionPosition]
    else
      AGroupBoxInfo := GroupBoxElements[ACaptionPosition];

  if AGroupBoxInfo = nil then
    Result := inherited GroupBoxBorderSize(ACaption, ACaptionPosition)
  else
    Result := AGroupBoxInfo.ContentOffset.Rect;
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupBoxFrame(ACanvas: TcxCanvas;
  R: TRect; AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll); 
begin
  DrawGroupBoxContent(ACanvas, R, ACaptionPosition, ABorders);
end;

class function TdxSkinLookAndFeelPainter.GroupBoxTextColor(
  AEnabled: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): TColor;
var
  AGroupBoxCaption: TdxSkinElement;
begin
  if ACaptionPosition = cxgpCenter then
    Result := PanelTextColor
  else
  begin
    AGroupBoxCaption := CacheData.GroupBoxCaptionElements[ACaptionPosition];
    if AGroupBoxCaption = nil then
      Result := inherited GroupBoxTextColor(AEnabled, ACaptionPosition)
    else
      Result := AGroupBoxCaption.TextColor;
  end;
end;

class function TdxSkinLookAndFeelPainter.PanelTextColor: TColor;
begin
  with CacheData do
    if GroupBoxClient = nil then
      Result := inherited PanelTextColor
    else
      Result := GroupBoxClient.TextColor;
end;

class function TdxSkinLookAndFeelPainter.IsGroupBoxTransparent(
  AIsCaption: Boolean; ACaptionPosition: TcxGroupBoxCaptionPosition): Boolean;
var
  AGroupBoxInfo: TdxSkinElement;
begin
  with CacheData do
    if AIsCaption then
      AGroupBoxInfo := GroupBoxCaptionElements[ACaptionPosition]
    else
      AGroupBoxInfo := GroupBoxElements[ACaptionPosition];

  if AGroupBoxInfo = nil then
    Result := inherited IsGroupBoxTransparent(AIsCaption, ACaptionPosition)
  else
    Result := AGroupBoxInfo.IsAlphaUsed;
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupBoxCaption(ACanvas: TcxCanvas;
  ACaptionRect: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition);
begin
  with CacheData do
    if GroupBoxCaptionElements[ACaptionPosition] = nil then
      inherited DrawGroupBoxCaption(ACanvas, ACaptionRect, ACaptionPosition)
    else
      GroupBoxCaptionElements[ACaptionPosition].Draw(ACanvas.Handle, ACaptionRect);
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupBoxContent(ACanvas: TcxCanvas;
  ABorderRect: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition;
  ABorders: TcxBorders = cxBordersAll);
var
  ARect: TRect;
begin
  with CacheData do
    if (GroupBoxElements[ACaptionPosition] = nil) or (GroupBoxClient = nil) then
      inherited DrawGroupBoxContent(ACanvas, ABorderRect, ACaptionPosition)
    else
      if not IsRectEmpty(ABorderRect) then
      begin
        ARect := ABorderRect;
        ACanvas.SaveClipRegion;
        try
          ACanvas.IntersectClipRect(ABorderRect);
          with GroupBoxElements[ACaptionPosition] do
          begin
            if bLeft in ABorders then
              Inc(ARect.Left, ContentOffset.Left + Borders[bLeft].Thin);
            if bTop in ABorders then
              Inc(ARect.Top, ContentOffset.Top + Borders[bTop].Thin);
            if bRight in ABorders then
              Dec(ARect.Right, ContentOffset.Right + Borders[bRight].Thin);
            if bBottom in ABorders then
              Dec(ARect.Bottom, ContentOffset.Bottom + Borders[bBottom].Thin);
          end;
          GroupBoxClient.Draw(ACanvas.Handle, ARect);
          ACanvas.ExcludeClipRect(ARect);
          GroupBoxElements[ACaptionPosition].Draw(ACanvas.Handle, ABorderRect);
        finally
          ACanvas.RestoreClipRegion;
        end;
      end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupBoxExpandButton(
  ACanvas: TcxCanvas; const R: TRect; AState: TcxButtonState; AExpanded: Boolean; ARotationAngle: TcxRotationAngle = ra0);

  procedure DoDrawGroupBoxExpandButton(ACanvas: TcxCanvas; const R: TRect);
  begin
    with CacheData do
      if GroupExpandButton = nil then
        inherited DrawGroupBoxExpandButton(ACanvas, R, AState, AExpanded)
      else
        GroupExpandButton.Draw(ACanvas.Handle, R, Ord(not AExpanded), ButtonStateToSkinState[AState]);
  end;

var
  ABitmap: TcxAlphaBitmap;
  ARect: TRect;
begin
  if ARotationAngle = ra0 then
    DoDrawGroupBoxExpandButton(ACanvas, R)
  else
  begin
    if ARotationAngle in [raPlus90, raMinus90] then
      ARect := cxRectRotate(R)
    else
      ARect := R;
    ABitmap := TcxAlphaBitmap.CreateSize(ARect);
    try
      ABitmap.Clear;
      DoDrawGroupBoxExpandButton(ABitmap.cxCanvas, ABitmap.ClientRect);
      ACanvas.RotateBitmap(ABitmap, ARotationAngle);
      cxDrawImage(ACanvas.Handle, R, R, ABitmap, nil, -1, idmNormal);
    finally
      ABitmap.Free;
    end;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupBoxBackground(ACanvas: TcxCanvas;
  ABounds: TRect; ARect: TRect);
begin
  with CacheData do
    if GroupBoxClient = nil then
      inherited DrawGroupBoxBackground(ACanvas, ABounds, ARect)
    else
      GroupBoxClient.Draw(ACanvas.Handle, ARect);
end;

class procedure TdxSkinLookAndFeelPainter.DrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState;  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont; ATextColor,
  ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsLast: Boolean = False;
  AIsGroup: Boolean = False);

  function AdjustHeaderBounds(const ABounds: TRect; ABorders: TcxBorders): TRect;
  begin
    Result := cxRectExclude(ABounds, cxRect(1, 1, 1, 1), ABorders);
  end;

var
  AHeader: TdxSkinElement;
begin
  with CacheData do
    if AIsGroup then
      AHeader := HeaderSpecial
    else
      AHeader := Header;

  if AHeader = nil then
    inherited DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
      AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackGround, AIsLast, AIsGroup)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.SetClipRegion(TcxRegion.Create(ABounds), roIntersect);
      AHeader.Draw(ACanvas.Handle, AdjustHeaderBounds(ABounds, ABorders), 0,
        ButtonStateToSkinState[AState]);
      DrawContent(ACanvas, HeaderContentBounds(ABounds, ABorders), ATextAreaBounds,
        Integer(AState), AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis,
        AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawHeaderEx(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors;
  ABorders: TcxBorders; AState: TcxButtonState;  AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders, AState,
    AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText, AFont,
    ATextColor, ABkColor, AOnDrawBackground);
end;

class procedure TdxSkinLookAndFeelPainter.DrawHeaderSeparator(ACanvas: TcxCanvas;
  const ABounds: TRect; AIndentSize: Integer; AColor: TColor; AViewParams: TcxViewParams);
begin
  with CacheData do
    if HeaderBackgroundColor = nil then
      inherited DrawHeaderSeparator(ACanvas, ABounds, AIndentSize, AColor, AViewParams)
    else
      ACanvas.FillRect(cxRectInflate(ABounds, -AIndentSize, 0), HeaderBackgroundColor.Value);
end;

class function TdxSkinLookAndFeelPainter.HeaderBorders(
  ANeighbors: TcxNeighbors): TcxBorders;
begin
  Result := inherited HeaderBorders(ANeighbors);
  if nLeft in ANeighbors then Exclude(Result, bLeft);
  if nTop in ANeighbors then Exclude(Result, bTop);
end;

class function TdxSkinLookAndFeelPainter.HeaderDrawCellsFirst: Boolean;
begin
  Result := False;
end;

class procedure TdxSkinLookAndFeelPainter.DrawGroupByBox(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  with CacheData do
    if GridGroupByBox = nil then
      inherited DrawGroupByBox(ACanvas, ARect, ATransparent, ABackgroundColor,
        ABackgroundBitmap)
    else
      GridGroupByBox.Draw(ACanvas.Handle, ARect);
end;

class function TdxSkinLookAndFeelPainter.GridDrawHeaderCellsFirst: Boolean;
begin
  with CacheData do
  begin
    if Header = nil then
      Result := inherited GridDrawHeaderCellsFirst
    else
      Result := not Header.IsAlphaUsed;
  end;
end;

class function TdxSkinLookAndFeelPainter.GridGroupRowStyleOffice11ContentColor(AHasData: Boolean): TColor;
begin
  if CacheData.GridGroupRowStyleOffice11ContentColor = nil then
    Result := inherited GridGroupRowStyleOffice11ContentColor(AHasData)
  else
    Result := CacheData.GridGroupRowStyleOffice11ContentColor.Value;
end;

class function TdxSkinLookAndFeelPainter.GridGroupRowStyleOffice11SeparatorColor: TColor;
begin
  if CacheData.GridGroupRowStyleOffice11SeparatorColor = nil then
    Result := inherited GridGroupRowStyleOffice11SeparatorColor
  else
    Result := CacheData.GridGroupRowStyleOffice11SeparatorColor.Value;
end;

class function TdxSkinLookAndFeelPainter.GridGroupRowStyleOffice11TextColor: TColor;
begin
  if CacheData.GridGroupRowStyleOffice11TextColor = nil then
    Result := inherited GridGroupRowStyleOffice11TextColor
  else
    Result := CacheData.GridGroupRowStyleOffice11TextColor.Value;
end;

class procedure TdxSkinLookAndFeelPainter.LayoutViewDrawRecordCaption(
  ACanvas: TcxCanvas; const ABounds: TRect; APosition: TcxGroupBoxCaptionPosition;
  AState: TcxButtonState);
const
  LayoutViewRecordState: array[TcxButtonState] of TdxSkinElementState =
    (esNormal, esNormal, esActive, esActive, esDisabled);
begin
  with CacheData do
    if LayoutViewRecordCaptionElements[APosition] = nil then
      inherited LayoutViewDrawRecordCaption(ACanvas, ABounds, APosition, AState)
    else
      LayoutViewRecordCaptionElements[APosition].Draw(
        ACanvas.Handle, ABounds, 0, LayoutViewRecordState[AState]);
end;

class procedure TdxSkinLookAndFeelPainter.LayoutViewDrawRecordContent(
  ACanvas: TcxCanvas; const ABounds: TRect; ACaptionPosition: TcxGroupBoxCaptionPosition;
  AState: TcxButtonState; ABorders: TcxBorders = cxBordersAll);
begin
  with CacheData do
    if LayoutViewRecordElements[ACaptionPosition] = nil then
      inherited LayoutViewDrawRecordContent(ACanvas, ABounds, ACaptionPosition, AState, ABorders)
    else
      LayoutViewRecordElements[ACaptionPosition].Draw(ACanvas.Handle, ABounds);
end;

class procedure TdxSkinLookAndFeelPainter.LayoutViewDrawRecordExpandButton(
  ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState; AExpanded: Boolean);
begin
  with CacheData do
    if LayoutViewRecordExpandButton = nil then
      inherited LayoutViewDrawRecordExpandButton(ACanvas, ABounds, AState, AExpanded)
    else
      LayoutViewRecordExpandButton.Draw(ACanvas.Handle,
        ABounds, Ord(not AExpanded), ButtonStateToSkinState[AState]);
end;

class procedure TdxSkinLookAndFeelPainter.LayoutViewDrawItem(
  ACanvas: TcxCanvas; const ABounds: TRect; AState: TcxButtonState; ABorders: TcxBorders = []);
begin
  if CacheData.LayoutViewItem = nil then
    inherited LayoutViewDrawItem(ACanvas, ABounds, AState, ABorders)
  else
    if AState <> cxbsNormal then
      CacheData.LayoutViewItem.Draw(ACanvas.Handle, ABounds, 0, ButtonStateToSkinState[AState])
    else
      if ABorders <> [] then
      begin
        ACanvas.SaveClipRegion;
        try
          ACanvas.IntersectClipRect(ABounds);
          CacheData.LayoutViewItem.Draw(ACanvas.Handle,
            cxRectExclude(ABounds, CacheData.LayoutViewItem.Image.Margins.Rect, ABorders), 0,
            ButtonStateToSkinState[AState]);
        finally
          ACanvas.RestoreClipRegion;
        end;
      end;
end;

class function TdxSkinLookAndFeelPainter.LayoutViewGetPadding(AElement: TcxLayoutElement): TRect;
begin
  if CacheData.LayoutViewElementPadding[AElement] = nil then
    Result := inherited LayoutViewGetPadding(AElement)
  else
    Result := CacheData.LayoutViewElementPadding[AElement].Value.Rect;
end;

class function TdxSkinLookAndFeelPainter.LayoutViewGetSpacing(AElement: TcxLayoutElement): TRect;
begin
  if CacheData.LayoutViewElementSpacing[AElement] = nil then
    Result := inherited LayoutViewGetSpacing(AElement)
  else
    Result := CacheData.LayoutViewElementSpacing[AElement].Value.Rect;
end;

class function TdxSkinLookAndFeelPainter.PivotGridHeadersAreaColor: TColor;
begin
  with CacheData do
    if (GridGroupByBox = nil) or not IsColorAssigned(GridGroupByBox.Color) then
      Result := inherited PivotGridHeadersAreaColor
    else
      Result := GridGroupByBox.Color;
end;

class function TdxSkinLookAndFeelPainter.PivotGridHeadersAreaTextColor: TColor;
begin
  with CacheData do
    if (GridGroupByBox = nil) or not IsColorAssigned(GridGroupByBox.TextColor) then
      Result := inherited PivotGridHeadersAreaColor
    else
      Result := GridGroupByBox.TextColor;
end;

class procedure TdxSkinLookAndFeelPainter.DrawFooterBorder(
  ACanvas: TcxCanvas; const R: TRect);
var
  ABounds: TRect;
begin
  with CacheData do
    if FooterPanel = nil then
      inherited DrawFooterBorder(ACanvas, R)
    else
    begin
      ACanvas.SaveClipRegion;
      with FooterPanel.ContentOffset.Rect do
        ACanvas.ExcludeClipRect(Rect(R.Left, R.Top, R.Right - Right,
          R.Bottom - Bottom));
      ACanvas.ExcludeClipRect(Rect(R.Left, R.Top - 1, R.Right, R.Top));
      try
        ABounds := R;
        Dec(ABounds.Top);
        Dec(ABounds.Left, FooterPanel.ContentOffset.Left);
        FooterPanel.Draw(ACanvas.Handle, ABounds);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawFooterCellBorder(ACanvas: TcxCanvas; const R: TRect);
begin
  if CacheData.FooterCell = nil then
    inherited DrawFooterCellBorder(ACanvas, R);
end;

class procedure TdxSkinLookAndFeelPainter.DrawFooterCellContent(ACanvas: TcxCanvas;
  const ABounds: TRect; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine: Boolean; const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  if CacheData.FooterCell <> nil then
    CacheData.FooterCell.Draw(ACanvas.Handle, ABounds);
  inherited DrawFooterCellContent(ACanvas, ABounds, AAlignmentHorz, AAlignmentVert,
    AMultiLine, AText, AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

class procedure TdxSkinLookAndFeelPainter.DrawFooterContent(ACanvas: TcxCanvas;
  const ARect: TRect; const AViewParams: TcxViewParams);
var
  R: TRect;
begin
  with CacheData do
  begin
    if (FooterPanel = nil) or (AViewParams.Bitmap <> nil) and
      not AViewParams.Bitmap.Empty
    then
      inherited DrawFooterContent(ACanvas, ARect, AViewParams)
    else
    begin
      with FooterPanel.ContentOffset do
        R := Classes.Rect(ARect.Left - Left, ARect.Top - FooterSeparatorSize,
          ARect.Right + Right, ARect.Bottom + Bottom);
      FooterPanel.Draw(ACanvas.Handle, R);
    end;
  end;
end;

class function TdxSkinLookAndFeelPainter.FooterCellBorderSize: Integer;
begin
  with CacheData do
    if FooterCell = nil then
      Result := inherited FooterCellBorderSize
    else
      with FooterCell.ContentOffset do
        Result := Max(Max(Left, Top), Max(Right, Bottom));
end;

class function TdxSkinLookAndFeelPainter.FooterDrawCellsFirst: Boolean;
begin
  Result := False;
end;

class function TdxSkinLookAndFeelPainter.FooterSeparatorColor: TColor;
begin
  Result := DefaultGridLineColor;
end;

class procedure TdxSkinLookAndFeelPainter.DrawFilterDropDownButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState; AIsFilterActive: Boolean);
begin
  with CacheData do
    if FilterButtons[AIsFilterActive] <> nil then
      FilterButtons[AIsFilterActive].Draw(ACanvas.Handle, R, 0,
        ButtonStateToSkinState[AState])
    else
      inherited DrawFilterDropDownButton(ACanvas, R, AState, AIsFilterActive);
end;

class procedure TdxSkinLookAndFeelPainter.DrawFilterCloseButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  with CacheData do
  begin
    if EditButtonElements[True] = nil then
      inherited DrawFilterCloseButton(ACanvas, R, AState)
    else
      EditButtonElements[True].Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawFilterPanel(ACanvas: TcxCanvas;
  const ARect: TRect; ATransparent: Boolean; ABackgroundColor: TColor;
  const ABackgroundBitmap: TBitmap);
begin
  with CacheData do
  begin
    if FilterPanel = nil then
      inherited DrawFilterPanel(ACanvas, ARect, ATransparent, ABackgroundColor,
        ABackgroundBitmap)
    else
      FilterPanel.Draw(ACanvas.Handle, ARect);
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawPanelBorders(ACanvas: TcxCanvas;
  const ABorderRect: TRect);
var
  AElement: TdxSkinElement;
begin
  AElement := CacheData.GroupBoxElements[cxgpCenter];
  if AElement = nil then
    DrawPanelBorders(ACanvas, ABorderRect)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.ExcludeClipRect(cxRectContent(ABorderRect, AElement.ContentOffset.Rect));
      AElement.Draw(ACanvas.Handle, ABorderRect);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawPanelContent(ACanvas: TcxCanvas;
  const ABorderRect: TRect; ABorder: Boolean);
begin
  with CacheData do
    if (GroupBoxClient = nil) then
      inherited DrawPanelContent(ACanvas, ABorderRect, ABorder)
    else
    begin
      GroupBoxClient.Draw(ACanvas.Handle, ABorderRect);
      if ABorder then
        DrawPanelBorders(ACanvas, ABorderRect);
    end;
end;

class function TdxSkinLookAndFeelPainter.FilterCloseButtonSize: TPoint;
begin
  with CacheData do
    if EditButtonElements[True] = nil then
      Result := inherited FilterCloseButtonSize
    else
      Result := cxPoint(EditButtonElements[True].Size);
end;

class procedure TdxSkinLookAndFeelPainter.DrawTrackBarTrack(ACanvas: TcxCanvas;
  const ARect, ASelection: TRect; AShowSelection, AEnabled, AHorizontal: Boolean; ATrackColor: TColor);
begin
  with CacheData do
    if TrackBarTrack[AHorizontal] = nil then
      inherited
    else
    begin
      TrackBarTrack[AHorizontal].Draw(ACanvas.Handle, ARect, 2 * Byte(not AEnabled));
      if AShowSelection then
        TrackBarTrack[AHorizontal].Draw(ACanvas.Handle, ASelection, 2 * Byte(not AEnabled) + 1);
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawTrackBarThumb(ACanvas: TcxCanvas;
  const ARect: TRect; AState: TcxButtonState; AHorizontal: Boolean;
  ATicks: TcxTrackBarTicksAlign; AThumbColor: TColor);
begin
  with CacheData do
  begin
    if TrackBarThumb[AHorizontal, ATicks] <> nil then
      TrackBarThumb[AHorizontal, ATicks].Draw(
        ACanvas.Handle, ARect, 0, ButtonStateToSkinState[AState])
    else
      inherited
  end;
end;

class function TdxSkinLookAndFeelPainter.TrackBarThumbSize(AHorizontal: Boolean): TSize;
begin
  with CacheData do
  begin
    if TrackBarThumb[AHorizontal, tbtaDown] <> nil then
      Result := TrackBarThumb[AHorizontal, tbtaDown].Size
    else
      Result := inherited TrackBarThumbSize(AHorizontal);
  end;
end;

class function TdxSkinLookAndFeelPainter.TrackBarTrackSize: Integer;
begin
  with CacheData do
  begin
    if TrackBarTrack[True] <> nil then
      Result := TrackBarTrack[True].Size.cy
    else
      Result := inherited TrackBarTrackSize;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawContent(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; AState: Integer; AAlignmentHorz: TAlignment;
  AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean;
  const AText: string; AFont: TFont; ATextColor, ABkColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil; AIsFooter: Boolean = False);
const
  AlignmentsHorz: array[TAlignment] of Integer =
    (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  AlignmentsVert: array[TcxAlignmentVert] of Integer =
    (cxAlignTop, cxAlignBottom, cxAlignVCenter);
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  with ACanvas do
  begin
    if AText <> '' then
    begin
      Brush.Style := bsClear;
      Font := AFont;
      Font.Color := ATextColor;
      DrawText(AText, ATextAreaBounds, AlignmentsHorz[AAlignmentHorz] or
        AlignmentsVert[AAlignmentVert] or MultiLines[AMultiLine] or
        ShowEndEllipsises[AShowEndEllipsis]);
      Brush.Style := bsSolid;
    end;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawSplitter(ACanvas: TcxCanvas;
  const ARect: TRect; AHighlighted: Boolean; AClicked: Boolean; AHorizontal: Boolean);
const
  StateMap: array[Boolean] of TdxSkinElementState = (esNormal, esHot);
begin
  with CacheData do
  begin
    if Splitter[AHorizontal] = nil then
      inherited DrawSplitter(ACanvas, ARect, AHighlighted, AClicked, AHorizontal)
    else
      Splitter[AHorizontal].Draw(ACanvas.Handle , ARect, 0, StateMap[AHighlighted]);
  end;
end;

class function TdxSkinLookAndFeelPainter.GetSplitterSize(AHorizontal: Boolean): TSize;
var
  AElement: TdxSkinElement;
begin
  AElement := CacheData.Splitter[AHorizontal];
  if AElement = nil then
    Result := inherited GetSplitterSize(AHorizontal)
  else
  begin
    Result.cx := Max(AElement.MinSize.Width, AElement.Size.cx);
    Result.cy := Max(AElement.MinSize.Height, AElement.Size.cy);
  end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawIndicatorCustomizationMark(
  ACanvas: TcxCanvas; const R: TRect; AColor: TColor);
const
  AIndicatorCustomizationMarkID = 2;
var
  ARect: TRect;  
begin
  with CacheData do
    if IndicatorImages = nil then
      inherited DrawIndicatorCustomizationMark(ACanvas, R, AColor)
    else
    begin
      with IndicatorImages.Image.Size, R do
      begin
        ARect := Rect(0, 0, cx, cy);
        OffsetRect(ARect, (Left + Right - cx) div 2, (Top + Bottom - cy) div 2);
      end;
      IndicatorImages.Draw(ACanvas.Handle, ARect, AIndicatorCustomizationMarkID);
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawIndicatorImage(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind);
const
  AIndicatorImagesMap: array[TcxIndicatorKind] of integer = (0, 0, 1, 2, 0, 0, 8);
var
  ARect: TRect;
begin
  with CacheData do
    if IndicatorImages = nil then
      inherited DrawIndicatorImage(ACanvas, R, AKind)
    else
      if AKind <> ikNone then
      begin
        with IndicatorImages.Image.Size, R do
        begin
          ARect := Rect(0, 0, cx, cy);
          OffsetRect(ARect, (Left + Right - cx) div 2, (Top + Bottom - cy) div 2);
        end;  
        IndicatorImages.Draw(ACanvas.Handle, ARect, AIndicatorImagesMap[AKind]);
      end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawIndicatorItem(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
var
  ARect: TRect;
begin
  with R do
    ARect := Rect(Left, Top - HeaderBorderSize, Right, Bottom);
  DrawHeader(ACanvas, ARect, ARect, [], HeaderBorders([nTop, nBottom]), cxbsNormal,
    taLeftJustify, vaTop, False, False, '', nil, clNone, AColor, AOnDrawBackground);
  DrawIndicatorImage(ACanvas, R, AKind);
end;

class procedure TdxSkinLookAndFeelPainter.DrawIndicatorItemEx(ACanvas: TcxCanvas;
  const R: TRect; AKind: TcxIndicatorKind; AColor: TColor;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawIndicatorItem(ACanvas, R, AKind, AColor, AOnDrawBackground);
end;

class procedure TdxSkinLookAndFeelPainter.DrawMonthHeader(ACanvas: TcxCanvas;
  const ABounds: TRect; const AText: string; ANeighbors: TcxNeighbors;
  const AViewParams: TcxViewParams; AArrows: TcxHeaderArrows; ASideWidth: Integer;
  AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  DrawHeader(ACanvas, ABounds, ABounds, ANeighbors, HeaderBorders(ANeighbors),
    cxbsNormal, taCenter, vaCenter, False, False, AText, AViewParams.Font,
    AViewParams.TextColor, AViewParams.Color, AOnDrawBackground);
  DrawMonthHeaderArrows(ACanvas, ABounds, AArrows, ASideWidth,
    DefaultDateNavigatorHeaderTextColor(False));
end;

class procedure TdxSkinLookAndFeelPainter.DrawSchedulerEventProgress(
  ACanvas: TcxCanvas; const ABounds, AProgress: TRect;
  AViewParams: TcxViewParams; ATransparent: Boolean);
var
  AProgressBar: TdxSkinElement;
  AProgressChunk: TdxSkinElement;
begin
  with CacheData do
  begin
    AProgressBar := ProgressBarElements[False, False];
    AProgressChunk := ProgressBarElements[True, False];
  end;
  if (AProgressBar = nil) or (AProgressChunk = nil) then
    inherited DrawSchedulerEventProgress(ACanvas, ABounds, AProgress, AViewParams,
      ATransparent)
  else
  begin
    AProgressBar.Draw(ACanvas.Handle, ABounds);
    AProgressChunk.Draw(ACanvas.Handle, AProgress);
  end;
end;

class function TdxSkinLookAndFeelPainter.SchedulerEventProgressOffsets: TRect;
var
  AProgressBar: TdxSkinElement;
begin
  with CacheData do
    AProgressBar := ProgressBarElements[False, False];
  if AProgressBar = nil then
    Result := SchedulerEventProgressOffsets
  else
    Result := AProgressBar.ContentOffset.Rect
end;

class function TdxSkinLookAndFeelPainter.SchedulerNavigationButtonTextColor(
  AIsNextButton: Boolean; AState: TcxButtonState;
  ADefaultColor: TColor = clDefault): TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := CacheData.SchedulerNavigationButtons[AIsNextButton];
  if AElement = nil then
    Result := inherited SchedulerNavigationButtonTextColor(AIsNextButton, AState, ADefaultColor)
  else
  begin
    Result := AElement.GetTextColor(AState);
    if Result = clDefault then
      Result := ADefaultColor;
  end;
end;

class procedure TdxSkinLookAndFeelPainter.CalculateSchedulerNavigationButtonRects(
  AIsNextButton: Boolean; ACollapsed: Boolean; APrevButtonTextSize: TSize;
  ANextButtonTextSize: TSize; var ABounds: TRect; out ATextRect: TRect;
  out AArrowRect: TRect);
var
  AMinSize: TSize;
begin
  with CacheData do
    if SchedulerNavigationButtons[AIsNextButton] = nil then
      AMinSize := cxNullSize
    else
      AMinSize := SchedulerNavigationButtons[AIsNextButton].MinSize.Size;

  if (AMinSize.cx > 0) and (ABounds.Right - ABounds.Left < AMinSize.cx) then
    if AIsNextButton then
      ABounds.Left := ABounds.Right - AMinSize.cx
    else
      ABounds.Right := ABounds.Left + AMinSize.cx;
                                              
  inherited CalculateSchedulerNavigationButtonRects(AIsNextButton, ACollapsed,
    APrevButtonTextSize, ANextButtonTextSize, ABounds, ATextRect, AArrowRect);
end;

class procedure TdxSkinLookAndFeelPainter.DrawFooterBorderEx(ACanvas: TcxCanvas;
  const R: TRect; ABorders: TcxBorders);
var
  ABounds: TRect;
begin
  with CacheData do
    if FooterPanel = nil then
      inherited DrawFooterBorder(ACanvas, R)
    else
    begin
      ACanvas.SaveClipRegion;
      try
        with FooterPanel.ContentOffset.Rect do
        begin
          ACanvas.ExcludeClipRect(Rect(R.Left + Left, R.Top + FooterSeparatorSize, R.Right - Right,
            R.Bottom - Bottom));
          ABounds := R;
          if not (bTop in ABorders) then
            Dec(ABounds.Top, FooterSeparatorSize);
          if not (bBottom in ABorders) then
            Inc(ABounds.Bottom, Bottom);
          if not (bLeft in ABorders) then
            Dec(ABounds.Left, Left);
          if not (bRight in ABorders) then
            Inc(ABounds.Right, Right);
        end;
        FooterPanel.Draw(ACanvas.Handle, ABounds);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawSchedulerNavigationButtonContent(
  ACanvas: TcxCanvas; const ARect: TRect; const AArrowRect: TRect;
  AIsNextButton: Boolean; AState: TcxButtonState);
var
  R: TRect;
begin
  with CacheData do
    if SchedulerNavigationButtons[AIsNextButton] = nil then
      inherited DrawSchedulerNavigationButtonContent(ACanvas, ARect, AArrowRect,
        AIsNextButton, AState)
    else
    begin
      R := ARect;
      if AIsNextButton then
        Inc(R.Right)
      else
        Dec(R.Left);

      ACanvas.SaveClipRegion;
      try
        ACanvas.SetClipRegion(TcxRegion.Create(ARect), roIntersect);
        SchedulerNavigationButtons[AIsNextButton].Draw(ACanvas.Handle, R, 0,
          ButtonStateToSkinState[AState]);
        if SchedulerNavigationButtonsArrow[AIsNextButton] <> nil then
          SchedulerNavigationButtonsArrow[AIsNextButton].Draw(ACanvas.Handle,
            AArrowRect, 0, ButtonStateToSkinState[AState]);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

class function TdxSkinLookAndFeelPainter.IsColorAssigned(AColor: TColor): Boolean;
begin
  Result := (AColor <> clNone) and (AColor <> clDefault);
end;

class function TdxSkinLookAndFeelPainter.IsColorPropertyAssigned(
  AColor: TdxSkinColor): Boolean;
begin
  Result := Assigned(AColor) and IsColorAssigned(AColor.Value);
end;

class procedure TdxSkinLookAndFeelPainter.SchedulerNavigationButtonSizes(
  AIsNextButton: Boolean; var ABorders: TRect; var AArrowSize: TSize;
  var AHasTextArea: Boolean);
begin
  with CacheData do
    if (SchedulerNavigationButtons[AIsNextButton] = nil) or
       (SchedulerNavigationButtonsArrow[AIsNextButton] = nil)
    then
      inherited SchedulerNavigationButtonSizes(
        AIsNextButton, ABorders, AArrowSize, AHasTextArea)
    else
    begin
      ABorders := SchedulerNavigationButtons[AIsNextButton].ContentOffset.Rect;
      AArrowSize := SchedulerNavigationButtonsArrow[AIsNextButton].Size;
      AHasTextArea := not SchedulerNavigationButtons[AIsNextButton].Image.Empty;
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawSchedulerNavigatorButton(
  ACanvas: TcxCanvas; R: TRect; AState: TcxButtonState);
begin
  if CacheData.EditButtonElements[False] = nil then
    inherited DrawSchedulerNavigatorButton(ACanvas, R, AState)
  else
    CacheData.EditButtonElements[False].Draw(ACanvas.Handle, R, 0, ButtonStateToSkinState[AState]);
end;

class procedure TdxSkinLookAndFeelPainter.DrawWindowContent(
  ACanvas: TcxCanvas; const ARect: TRect);
begin
  with CacheData do
    if FormContent = nil then
      inherited DrawWindowContent(ACanvas, ARect)
    else
      ACanvas.FillRect(ARect, FormContent.Color);
end;

class function TdxSkinLookAndFeelPainter.PrintPreviewPageBordersWidth: TRect;
begin
  with CacheData do
    if PrintingPageBorder =  nil then
      Result := inherited PrintPreviewPageBordersWidth
    else
      Result := PrintingPageBorder.ContentOffset.Rect;
end;

class procedure TdxSkinLookAndFeelPainter.DrawPrintPreviewBackground(
  ACanvas: TcxCanvas; const R: TRect);
begin
  with CacheData do
    if PrintingPreviewBackground =  nil then
      inherited DrawPrintPreviewBackground(ACanvas, R)
    else
    begin
      PrintingPreviewBackground.UseCache := True;
      PrintingPreviewBackground.Draw(ACanvas.Handle, R);
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawPrintPreviewPageBackground(
  ACanvas: TcxCanvas; const ABorderRect, AContentRect: TRect;
  ASelected, ADrawContent: Boolean);
const
  StateMap: array[Boolean] of TdxSkinElementState = (esNormal, esActive);
begin
  with CacheData do
    if PrintingPageBorder =  nil then
      inherited DrawPrintPreviewPageBackground(
        ACanvas, ABorderRect, AContentRect, ASelected, ADrawContent)
    else
    begin
      ACanvas.SaveClipRegion;
      try
        if ADrawContent then
          ACanvas.FillRect(AContentRect, clWhite);
        ACanvas.ExcludeClipRect(AContentRect);
        PrintingPageBorder.Draw(ACanvas.Handle, ABorderRect, 0, StateMap[ASelected]);
      finally
        ACanvas.RestoreClipRegion;
      end;
    end;
end;

class procedure TdxSkinLookAndFeelPainter.DrawDateNavigatorDateHeader(
  ACanvas: TcxCanvas; var R: TRect);
begin
  InflateRect(R, 1, 0);
  DrawHeader(ACanvas, R, cxEmptyRect, [], [], cxbsNormal,
    taCenter, vaCenter, False, False, '', nil, 0, 0);
end;

class function TdxSkinLookAndFeelPainter.IndicatorDrawItemsFirst: Boolean;
begin
  Result := True;
end;

class function TdxSkinLookAndFeelPainter.CacheData: TdxSkinLookAndFeelPainterInfo;
begin
  PaintersManager.GetPainterData(Self, Result);
end;

//
procedure RegisterSkin(ASkin: TdxSkin; APainter: TdxSkinLookAndFeelPainterClass);
begin
  if not CheckGdiPlus then Exit;
  PaintersManager.Register(ASkin.Name, TdxSkinLookAndFeelPainter,
    TdxSkinLookAndFeelPainterInfo.Create(ASkin));
end;

procedure RegisterSkin(const ASkinName: string;
  APainter: TdxSkinLookAndFeelPainterClass; ALoadFromResource: Boolean; AInstance: THandle);
var
  ASkin: TdxSkin;
  AData: TdxSkinLookAndFeelPainterInfo;
begin
  if not CheckGdiPlus then Exit;
  if ALoadFromResource then
    ASkin := TdxSkin.Create(ASkinName, ALoadFromResource, AInstance)
  else
    ASkin := nil;
  AData := APainter.CacheData;
  if AData = nil then
    AData := TdxSkinLookAndFeelPainterInfo.Create(ASkin);
  PaintersManager.Register(ASkinName, APainter, AData);
end;

procedure UnregisterSkin(const ASkinName: string);
begin
  PaintersManager.Unregister(ASkinName);
end;

initialization
  PaintersManager := GetExtendedStylePainters;

finalization
  PaintersManager := nil;

end.
