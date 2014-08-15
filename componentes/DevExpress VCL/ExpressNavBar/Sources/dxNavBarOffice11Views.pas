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

unit dxNavBarOffice11Views;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Graphics, Controls, Menus, ImgList,
  dxNavBar, dxNavBarBase, dxNavBarStyles, dxNavBarBaseViews,
  dxNavBarOfficeViews, dxNavBarExplorerViews, dxNavBarCollns;

type
  TdxNavBarOffice11LinkViewInfo = class(TdxNavBarLinkViewInfo)
  public
    function FontColor: TColor; override;
  end;

  TdxNavBarOffice11GroupViewInfo = class(TdxNavBarGroupViewInfo)
  private
    function IsDefaultBgColor: Boolean;
    function IsDefaultCaptionColor: Boolean;
  public
    function BorderColor: TColor; override;
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
    function CaptionFontColor: TColor; override;
  end;

  TdxNavBarOffice11ViewInfo = class(TdxNavBarExplorerBarViewInfo)
  private
    function IsDefaultBgColor: Boolean;
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;
  public
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;

    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultGroupHeaderActiveStyle; override;
    procedure AssignDefaultItemStyle; override;
  end;

  TdxNavBarOffice11Painter = class(TdxNavBarExplorerBarPainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
      ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; override;
    function CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
      ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo; override;

    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
    class function SignPainterClass: TdxBaseSignPainterClass; override;
  end;

  TdxNavBarOffice11NavPaneGroupViewInfo = class(TdxNavBarGroupViewInfo)
  private
    function IsDefaultCaptionColor: Boolean;
  public
    function CaptionBorderColor: TColor; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
  end;

  PdxNavBarOverflowPanelViewInfoItem = ^TdxNavBarOverflowPanelViewInfoItem;
  TdxNavBarOverflowPanelViewInfoItem = record
    Group: TdxNavBarGroup;
    Rect: TRect;
    SelectionRect: TRect;
  end;

  TdxNavBarOffice11NavPaneViewInfo = class(TdxNavBarOffice3ViewInfo)
  private
    FHeaderRect: TRect;
    FOverflowPanelItems: TList;
    FOverflowPanelRect: TRect;
    FOverflowPanelSignRect: TRect;
    FOverflowPanelVisibleItemCount: Integer;
    FSplitterRect: TRect;
    FPopupMenu: TPopupMenu;
    FImageList: TImageList;

    procedure ClearOverflowPanelItems;
    function GetOverflowPanelItemCount: Integer;
    function GetOverflowPanelItems(Index: Integer): PdxNavBarOverflowPanelViewInfoItem;
    function GetSmallImagesCount: Integer;
    function IsDefaultHeaderColor: Boolean;
    function IsDefaultOverflowPanelColor: Boolean;
    function IsDefaultBottomScrollButtonColor: Boolean;
    function IsDefaultTopScrollButtonColor: Boolean;
    procedure RecreateImageList;
    // Menu items
    procedure DoMoreButtonsClick(Sender: TObject);
    procedure DoFewerButtonsClick(Sender: TObject);
    procedure DoAddRemoveButtonsClick(Sender: TObject);
    procedure DoHiddenGroupClick(Sender: TObject);
    procedure DoMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure DoDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;

    function GetOverflowPanelImageWidthAddon: Integer; virtual;
    function GetOverflowPanelSignWidth: Integer; virtual;
    class function GetGroupHorizontalEdge: Integer; override;
    class function GetGroupSeparatorWidth: Integer; override;
    class function GetGroupCaptionImageIndent: Integer; override;
    class function GetGroupCaptionHeightAddon: Integer; override;
    class function GetOverflowPanelHeightAddon: Integer; virtual;
    class function GetOverflowPanelPopupMenuImageIndent: Integer; virtual;
    class function GetOverflowPanelPopupMenuTextIndent: Integer; virtual;
    class function GetOverflowPanelSeparator: Integer; virtual;

    function CanHasGroupViewAsIconView: Boolean; override;
    function CanHasImageInGroupCaption: Boolean; override;
    function CanGroupCaptionBoundsByImage: Boolean; override;

    function GetHintRect: TRect; override;
    function GetHintText: string; override;
    function GetOverflowPanelHintRect: TRect; virtual;
    function GetOverflowPanelHintText: string; virtual;

    function GetBoundsUpdateType: TdxNavBarChangeType; override;
    function GetOverflowPanelClientOffset: TRect; virtual;
  public
    constructor Create(APainter: TdxNavBarPainter); override;
    destructor Destroy; override;

    procedure CreateInfo; override;
    procedure CreateGroupsInfo; virtual;
    procedure CreateOverflowPanelInfo(AItemCount: Integer; AClearOld: Boolean); virtual;
    procedure CalculateBounds; override;
    procedure CalculateHeaderBounds(X, Y: Integer); virtual;
    procedure CalculateOverflowPanelBounds(X, Y: Integer); virtual;
    procedure CalculateSplitterBounds(X, Y: Integer); virtual;
    procedure ClearRects; override;
    procedure CorrectBounds; override;
    procedure CorrectBoundsWithNoGroups;

    function GetHeaderHeight: Integer; virtual;
    function GetOverflowPanelHeight: Integer; virtual;
    function GetOverflowPanelImageHeight: Integer; virtual;
    function GetOverflowPanelImageWidth: Integer; virtual;
    function GetOverflowPanelImageList: TCustomImageList; virtual;
    function GetOverflowPanelImageIndex(AGroup: TdxNavBarGroup): Integer; virtual;
    function GetSplitterHeight: Integer; virtual;

    function GetGroupViewInfoAtItemsPos(pt: TPoint): TdxNavBarGroupViewInfo; override;
    function GetViewInfoAtDragPosition(pt: TPoint; var ItemGroup: TdxNavBarGroupViewInfo;
        var Item1, Item2: TdxNavBarLinkViewInfo): Integer; override;
    function IsPtNavigationPaneHeader(pt: TPoint): Boolean; override;
    function IsPtNavigationPaneSplitter(pt: TPoint): Boolean; override;
    function IsPtNavigationPaneOverflowPanel(pt: TPoint): Boolean; override;
    function IsPtIncNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean; override;
    function IsPtDecNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean; override;
    function IsPtNavigationPaneOverflowPanelSign(pt: TPoint): Boolean; override;
    function GetNavigationPaneOverflowPanelItemIndexAtPos(pt: TPoint): Integer; override;
    function GetNavigationPaneOverflowPanelGroupAtPos(pt: TPoint): TdxNavBarGroup; override;

    function BorderColor: TColor; override;
    function BottomScrollButtonBackColor: TColor; override;
    function BottomScrollButtonBackColor2: TColor; override;
    function BottomScrollButtonAlphaBlend: Byte; override;
    function BottomScrollButtonAlphaBlend2: Byte; override;
    function BottomScrollButtonGradientMode: TdxBarStyleGradientMode; override;
    function TopScrollButtonBackColor: TColor; override;
    function TopScrollButtonBackColor2: TColor; override;
    function TopScrollButtonAlphaBlend: Byte; override;
    function TopScrollButtonAlphaBlend2: Byte; override;
    function TopScrollButtonGradientMode: TdxBarStyleGradientMode; override;
    function HeaderBackColor: TColor; override;
    function HeaderBackColor2: TColor; override;
    function HeaderAlphaBlend: Byte; override;
    function HeaderAlphaBlend2: Byte; override;
    function HeaderGradientMode: TdxBarStyleGradientMode; override;
    function HeaderFontColor: TColor; override;
    function OverflowPanelBackColor: TColor; override;
    function OverflowPanelBackColor2: TColor; override;
    function OverflowPanelAlphaBlend: Byte; override;
    function OverflowPanelAlphaBlend2: Byte; override;
    function OverflowPanelGradientMode: TdxBarStyleGradientMode; override;
    function SplitterBackColor: TColor; override;
    function SplitterBackColor2: TColor; override;
    function SplitterGradientMode: TdxBarStyleGradientMode; override;

    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultButtonStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
    procedure AssignDefaultNavigationPaneHeaderStyle; override;

    procedure DoShowPopupMenu(X, Y: Integer); override;
    procedure DoUpdatePopupMenu; virtual;

    property HeaderRect: TRect read FHeaderRect;
    property OverflowPanelItemCount: Integer read GetOverflowPanelItemCount;
    property OverflowPanelItems[Index: Integer]: PdxNavBarOverflowPanelViewInfoItem read GetOverflowPanelItems;
    property OverflowPanelRect: TRect read FOverflowPanelRect;
    property OverflowPanelSignRect: TRect read FOverflowPanelSignRect;
    property OverflowPanelVisibleItemCount: Integer read FOverflowPanelVisibleItemCount;

    property SplitterRect: TRect read FSplitterRect;

    property ImageList: TImageList read FImageList;
    property PopupMenu: TPopupMenu read FPopupMenu;
  end;

  TdxNavBarOffice11NavPanePainter = class(TdxNavBarOffice3Painter)
  private
    function GetViewInfo: TdxNavBarOffice11NavPaneViewInfo;
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
      ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; override;

    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
  public
    procedure DrawNavBarControl; override;
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawHintWindow; override;
    procedure DrawBorder; virtual;
    procedure DrawHeader; virtual;
    procedure DrawHeaderText; virtual;
    procedure DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawOverflowPanel; virtual;
    procedure DrawOverflowPanelSign; virtual;
    procedure DrawOverflowPanelItems; virtual;
    procedure DrawOverflowPanelHintWindow; virtual;
    procedure DrawSplitter; virtual;
    procedure DrawSplitterSign; virtual;
    procedure DrawPopupMenuItem(ACanvas: TCanvas; ARect: TRect; AImageList: TCustomImageList;
      AImageIndex: Integer; AText: string; State: TdxNavBarObjectStates); virtual;

    property ViewInfo: TdxNavBarOffice11NavPaneViewInfo read GetViewInfo;
  end;

implementation

uses
{$IFDEF DELPHI6}
   Types,
{$ENDIF}
  SysUtils, CommCtrl, Math, cxClasses, cxGraphics, cxGeometry, cxLookAndFeels, dxOffice11,
  dxNavBarConsts, dxNavBarGraphics, dxNavBarViewsFact, dxThemeManager, dxUxTheme;

{ TdxNavBarOffice11LinkViewInfo }

function TdxNavBarOffice11LinkViewInfo.FontColor: TColor;
begin
  Result := Font.Color;
  if Result = clNone then Result := dxOffice11LinkFontColor;
end;

{ TdxNavBarOffice11GroupViewInfo }

function TdxNavBarOffice11GroupViewInfo.BorderColor: TColor;
begin
  if IsDefaultCaptionColor then
    Result := dxOffice11GroupBorderColor
  else Result := inherited BorderColor;
end;

function TdxNavBarOffice11GroupViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarOffice11GroupViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarOffice11GroupViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11GroupBackgroundColor1
  else Result := inherited BgBackColor;
end;

function TdxNavBarOffice11GroupViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11GroupBackgroundColor2
  else Result := inherited BgBackColor2;
end;

function TdxNavBarOffice11GroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmVertical
  else Result := inherited BgGradientMode;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else Result := inherited CaptionAlphaBlend;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else Result := inherited CaptionAlphaBlend2;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionBackColor: TColor;
begin
  if IsDefaultCaptionColor then
    Result := dxOffice11GroupCaptionColor1
  else Result := inherited CaptionBackColor;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionBackColor2: TColor;
begin
  if IsDefaultCaptionColor then
    Result := dxOffice11GroupCaptionColor2
  else Result := inherited CaptionBackColor2;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultCaptionColor then
    Result := gmHorizontal
  else Result := inherited CaptionGradientMode;
end;

function TdxNavBarOffice11GroupViewInfo.CaptionFontColor: TColor;
begin
  Result := CaptionFont.Color;
  if Result = clNone then Result := dxOffice11GroupFontColor;
end;

function TdxNavBarOffice11GroupViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone);
end;

function TdxNavBarOffice11GroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavBarOffice11ViewInfo }

function TdxNavBarOffice11ViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarOffice11ViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarOffice11ViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11BackgroundColor1
  else Result := inherited BgBackColor;
end;

function TdxNavBarOffice11ViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := dxOffice11BackgroundColor2
  else Result := inherited BgBackColor2;
end;

function TdxNavBarOffice11ViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmVertical
  else Result := inherited BgGradientMode;
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clNone;
  NavBar.DefaultStyles.Background.BackColor2 := clNone;
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clNone;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clNone;
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Size := 10;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActive.Assign(NavBar.DefaultStyles.GroupHeader);
end;

procedure TdxNavBarOffice11ViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clNone;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarOffice11ViewInfo.CreateColors;
begin
  dxNavBarGraphics.CreateOffice11Colors;
end;

procedure TdxNavBarOffice11ViewInfo.RefreshColors;
begin
  dxNavBarGraphics.RefreshOffice11Colors;
end;

procedure TdxNavBarOffice11ViewInfo.ReleaseColors;
begin
  dxNavBarGraphics.ReleaseOffice11Colors;
end;

function TdxNavBarOffice11ViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone)
end;

{ TdxNavBarOffice11Painter }

class function TdxNavBarOffice11Painter.SignPainterClass: TdxBaseSignPainterClass;
begin
  Result := TdxNavBarOffice11SignPainter;
end;

function TdxNavBarOffice11Painter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarOffice11GroupViewInfo.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

function TdxNavBarOffice11Painter.CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarOffice11LinkViewInfo.Create(AViewInfo, ALink, ACaptionVisible, AImageVisisble);
end;

function TdxNavBarOffice11Painter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarOffice11ViewInfo.Create(Self);
end;

class function TdxNavBarOffice11Painter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarOffice11ButtonPainter;
end;

{ TdxNavBarOffice11NavPaneGroupViewInfo }

function TdxNavBarOffice11NavPaneGroupViewInfo.CaptionBorderColor: TColor;
begin
  Result := dxOffice11NavPaneBorder;
end;

function TdxNavBarOffice11NavPaneGroupViewInfo.CaptionBackColor: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor
  else
    if sActive in State then
    begin
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionPressedHotColor1
      else
        Result := dxOffice11NavPaneGroupCaptionPressedColor1;
    end
    else
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionHotColor1
      else
        Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarOffice11NavPaneGroupViewInfo.CaptionBackColor2: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor2
  else
    if sActive in State then
    begin
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionPressedHotColor2
      else
        Result := dxOffice11NavPaneGroupCaptionPressedColor2;
    end
    else
      if sHotTracked in State then
        Result := dxOffice11NavPaneGroupCaptionHotColor2
      else
        Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarOffice11NavPaneGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionAlphaBlend
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionAlphaBlend2
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionGradientMode
  else Result := gmVertical;
end;

function TdxNavBarOffice11NavPaneGroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavBarOffice11NavPanelViewInfo }

constructor TdxNavBarOffice11NavPaneViewInfo.Create(APainter: TdxNavBarPainter);
begin
  inherited;
  FOverflowPanelItems := TList.Create;
  FImageList := TImageList.Create(NavBar);
  FPopupMenu := TPopupMenu.Create(NavBar);
end;

destructor TdxNavBarOffice11NavPaneViewInfo.Destroy;
begin
  FPopupMenu.Free;
  FImageList.Free;
  ClearOverflowPanelItems;
  FOverflowPanelItems.Free;
  inherited;
end;

function TdxNavBarOffice11NavPaneViewInfo.BorderColor: TColor;
begin
  Result := dxOffice11NavPaneBorder;
end;

function TdxNavBarOffice11NavPaneViewInfo.BottomScrollButtonBackColor: TColor;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonBackColor
  else if sPressed in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sActive in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sHotTracked in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor1
  else Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarOffice11NavPaneViewInfo.BottomScrollButtonBackColor2: TColor;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonBackColor2
  else if sPressed in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sActive in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sHotTracked in BottomScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor2
  else Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarOffice11NavPaneViewInfo.BottomScrollButtonAlphaBlend: Byte;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonAlphaBlend
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.BottomScrollButtonAlphaBlend2: Byte;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonAlphaBlend2
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.BottomScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultBottomScrollButtonColor then
    Result := inherited BottomScrollButtonGradientMode
  else Result := gmVertical;
end;

function TdxNavBarOffice11NavPaneViewInfo.TopScrollButtonBackColor: TColor;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonBackColor
  else if sPressed in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sActive in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sHotTracked in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor1
  else Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarOffice11NavPaneViewInfo.TopScrollButtonBackColor2: TColor;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonBackColor2
  else if sPressed in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor2
  else if sActive in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionPressedColor1
  else if sHotTracked in TopScrollButtonState then
    Result := dxOffice11NavPaneGroupCaptionHotColor2
  else Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarOffice11NavPaneViewInfo.TopScrollButtonAlphaBlend: Byte;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonAlphaBlend
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.TopScrollButtonAlphaBlend2: Byte;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonAlphaBlend2
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.TopScrollButtonGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultTopScrollButtonColor then
    Result := inherited TopScrollButtonGradientMode
  else Result := gmVertical;
end;

function TdxNavBarOffice11NavPaneViewInfo.HeaderBackColor: TColor;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderBackColor
  else Result := dxOffice11NavPaneHeaderColor1;
end;

function TdxNavBarOffice11NavPaneViewInfo.HeaderBackColor2: TColor;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderBackColor2
  else Result := dxOffice11NavPaneHeaderColor2;
end;

function TdxNavBarOffice11NavPaneViewInfo.HeaderAlphaBlend: Byte;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderAlphaBlend
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.HeaderAlphaBlend2: Byte;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderAlphaBlend2
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.HeaderGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultHeaderColor then
    Result := inherited HeaderGradientMode
  else Result := gmVertical;
end;

function TdxNavBarOffice11NavPaneViewInfo.HeaderFontColor: TColor;
begin
  Result := inherited HeaderFontColor;
  if Result = clNone then
    Result := dxOffice11NavPaneHeaderFontColor;
end;

function TdxNavBarOffice11NavPaneViewInfo.OverflowPanelBackColor: TColor;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelBackColor
  else Result := dxOffice11NavPaneGroupCaptionColor1;
end;

function TdxNavBarOffice11NavPaneViewInfo.OverflowPanelBackColor2: TColor;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelBackColor2
  else Result := dxOffice11NavPaneGroupCaptionColor2;
end;

function TdxNavBarOffice11NavPaneViewInfo.OverflowPanelAlphaBlend: Byte;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelAlphaBlend
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.OverflowPanelAlphaBlend2: Byte;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelAlphaBlend2
  else Result := 255;
end;

function TdxNavBarOffice11NavPaneViewInfo.OverflowPanelGradientMode: TdxBarStyleGradientMode;
begin
  if not IsDefaultOverflowPanelColor then
    Result := inherited OverflowPanelGradientMode
  else Result := gmVertical;
end;

function TdxNavBarOffice11NavPaneViewInfo.SplitterBackColor: TColor;
begin
  if XPScheme = schUnknown then
    Result := dxOffice11NavPaneSplitterColor1
  else
    Result := inherited SplitterBackColor;
end;

function TdxNavBarOffice11NavPaneViewInfo.SplitterBackColor2: TColor;
begin
  if XPScheme = schUnknown then
    Result := dxOffice11NavPaneSplitterColor2
  else
    Result := inherited SplitterBackColor2;
end;

function TdxNavBarOffice11NavPaneViewInfo.SplitterGradientMode: TdxBarStyleGradientMode;
begin
  if XPScheme = schUnknown then
    Result := gmVertical
  else
    Result := inherited SplitterGradientMode;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clWindow;
  NavBar.DefaultStyles.Background.BackColor2 := clWindow;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultButtonStyle;
begin
  NavBar.DefaultStyles.Button.ResetValues;
  NavBar.DefaultStyles.Button.BackColor := clNone;
  NavBar.DefaultStyles.Button.BackColor2 := clNone;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clWindow;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clWindow;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clWindowText;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clGrayText;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.AssignDefaultNavigationPaneHeaderStyle;
begin
  NavBar.DefaultStyles.NavigationPaneHeader.ResetValues;
  NavBar.DefaultStyles.NavigationPaneHeader.BackColor := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Color := clNone;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Name := 'Arial';
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Size := 11;
  NavBar.DefaultStyles.NavigationPaneHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoShowPopupMenu(X, Y: Integer);
begin
  DoUpdatePopupMenu;
  PopupMenu.Popup(X, Y);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoUpdatePopupMenu;

  function AddItem(AParentItem: TMenuItem; ACaption: string;
    AEnabled: Boolean = True; AOnClick: TNotifyEvent = nil;
    AImageIndex: Integer = -1; AChecked: Boolean = False): TMenuItem;
  begin
    Result := TMenuItem.Create(PopupMenu);
    Result.Caption := ACaption;
    Result.OnDrawItem := DoDrawItem;
    if ACaption <> '-' then
    begin
      Result.OnMeasureItem := DoMeasureItem;
      Result.OnClick := AOnClick;
      Result.Checked := AChecked;
      Result.Enabled := AEnabled;
      Result.ImageIndex := AImageIndex;
    end;
    AParentItem.Add(Result);
  end;

  procedure AssignImage(AImageList: TImageList; ASourceBitmap: TBitmap);
  var
    ABitmap: TBitmap;
    ASideSize: Integer;
    AStretchRect: TRect;
    AMaskColor: TColor;
  begin
    if AImageList.BkColor = clNone then
      AMaskColor := clFuchsia
    else
      AMaskColor := AImageList.BkColor;
    ABitmap := cxCreateBitmap(AImageList.Width, AImageList.Height);
    try
      ASideSize := Min(ABitmap.Width, ABitmap.Height);
      AStretchRect.Left := (ABitmap.Width - ASideSize) div 2;
      AStretchRect.Right := AStretchRect.Left + ASideSize;
      AStretchRect.Top := (ABitmap.Height - ASideSize) div 2;
      AStretchRect.Bottom := AStretchRect.Top + ASideSize;
      ABitmap.Canvas.Brush.Color := AMaskColor;
      ABitmap.Canvas.FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height));
      ABitmap.Canvas.StretchDraw(AStretchRect, ASourceBitmap);
      AImageList.AddMasked(ABitmap, AMaskColor);
    finally
      ABitmap.Free;
    end;
  end;

  function GetImageIndex(AGroup: TdxNavBarGroup; ADefaultImageIndex: Integer): Integer;
  begin
    if IsImageAssigned(NavBar.SmallImages, AGroup.SmallImageIndex) then
      Result := AGroup.SmallImageIndex
    else
      Result := ADefaultImageIndex;
  end;

  procedure CreateGroupList(AParentMenuItem: TMenuItem; ADefaultImageIndex: Integer);
  var
    I: Integer;
  begin
    for I := 0 to NavBar.Groups.Count - 1 do
    begin
      AddItem(AParentMenuItem, NavBar.Groups[I].Caption, True, DoAddRemoveButtonsClick,
        GetImageIndex(NavBar.Groups[I], ADefaultImageIndex), NavBar.Groups[I].Visible){$IFDEF DELPHI6}.AutoCheck := True{$ENDIF};
    end;
  end;

  procedure CreateHiddenGroupList(AParentMenuItem: TMenuItem; ADefaultImageIndex: Integer);
  var
    I: Integer;
  begin
    AddItem(AParentMenuItem, '-');
    for I := FOverflowPanelVisibleItemCount to OverflowPanelItemCount - 1 do
      AddItem(AParentMenuItem, OverflowPanelItems[I].Group.Caption, True, DoHiddenGroupClick,
        GetImageIndex(OverflowPanelItems[I].Group, ADefaultImageIndex),
        NavBar.ActiveGroup = OverflowPanelItems[I].Group).Tag := Integer(OverflowPanelItems[I].Group);
  end;

var
  AImageCount: Integer;
  AParentMenuItem: TMenuItem;
begin
  RecreateImageList;

  if NavBar.SmallImages <> nil then
  begin
    ImageList.Width := NavBar.SmallImages.Width;
    ImageList.Height := NavBar.SmallImages.Height;
  end;

  AImageCount := GetSmallImagesCount;
  AssignImage(ImageList, dxOffice11NavPaneArrowUpBitmap);
  AssignImage(ImageList, dxOffice11NavPaneArrowDownBitmap);
  AssignImage(ImageList, dxOffice11NavPaneDefaultSmallBitmap);

  PopupMenu.Items.Clear;
  PopupMenu.Images := ImageList;

  AddItem(PopupMenu.Items, cxGetResourceString(@sdxNavBarOffice11ShowMoreButtons),
    NavBar.CanDecNavigationPaneOverflowPanelItemCount, DoMoreButtonsClick, AImageCount);
  AddItem(PopupMenu.Items, cxGetResourceString(@sdxNavBarOffice11ShowFewerButtons),
    NavBar.CanIncNavigationPaneOverflowPanelItemCount, DoFewerButtonsClick, AImageCount + 1);
  AParentMenuItem := AddItem(PopupMenu.Items,
    cxGetResourceString(@sdxNavBarOffice11AddRemoveButtons), NavBar.Groups.Count > 0);
  CreateGroupList(AParentMenuItem, AImageCount + 2);
  CreateHiddenGroupList(PopupMenu.Items, AImageCount + 2);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CreateColors;
begin
  CreateOffice11NavPaneColors;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.RefreshColors;
begin
  RefreshOffice11NavPaneColors;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.ReleaseColors;
begin
  ReleaseOffice11NavPaneColors;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetGroupHorizontalEdge: Integer;
begin
  Result := 1;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 0;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetGroupCaptionImageIndent: Integer;
begin
  Result := 4;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 4;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelHeightAddon: Integer;
begin
  Result := 8;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelSignWidth: Integer;
begin
  Result := 20;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelSeparator: Integer;
begin
  Result := 0;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelImageWidthAddon: Integer;
begin
  Result := 2;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelPopupMenuImageIndent: Integer;
begin
  Result := 3;
end;

class function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelPopupMenuTextIndent: Integer;
begin
  Result := 4;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetHeaderHeight: Integer;
begin
  Result := GetHeaderHeightAddon;
  Inc(Result, GetFontHeight(HeaderFont));
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelHeight: Integer;
begin
  with GetOverflowPanelClientOffset do
    Result := GetOverflowPanelImageHeight + GetOverflowPanelHeightAddon +
      Top + Bottom;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelImageHeight: Integer;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := GetSmallImageHeight
  else
    Result := GetLargeImageHeight;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelImageWidth: Integer;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := GetSmallImageWidth
  else
    Result := GetLargeImageWidth;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelImageList: TCustomImageList;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := NavBar.SmallImages
  else
    Result := NavBar.LargeImages;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelImageIndex(AGroup: TdxNavBarGroup): Integer;
begin
  if NavBar.NavigationPaneOverflowPanelUseSmallImages then
    Result := AGroup.SmallImageIndex
  else Result := AGroup.LargeImageIndex;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetSplitterHeight: Integer;
begin
  Result := 7;
end;

function TdxNavBarOffice11NavPaneViewInfo.CanHasGroupViewAsIconView: Boolean;
begin
  Result := False;
end;

function TdxNavBarOffice11NavPaneViewInfo.CanHasImageInGroupCaption: Boolean;
begin
  Result := True;
end;

function TdxNavBarOffice11NavPaneViewInfo.CanGroupCaptionBoundsByImage: Boolean;
begin
  Result := True;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelHintRect: TRect;
var
  pt: TPoint;
  AGroup: TdxNavBarGroup;
begin
  if NavBar.NavigationPaneOverflowPanelHotTrackedIndex > -1 then
    AGroup := OverflowPanelItems[NavBar.NavigationPaneOverflowPanelHotTrackedIndex].Group
  else AGroup := nil;
  Painter.HintWindowCanvas.Font := HintFont;
  Result := Rect(0, 0, ClientWidth, 0);
  cxDrawText(Painter.HintWindowDC, HintText, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX);
  Inc(Result.Right, dxNavBarHintWindowSizeCorrection);
  Inc(Result.Bottom, dxNavBarHintWindowSizeCorrection);
  if Assigned(NavBar.OnCalcNavigationPaneOverflowPanelHintRect) then
    NavBar.OnCalcNavigationPaneOverflowPanelHintRect(NavBar, AGroup, Self, Result);
  pt := NavBar.ClientToScreen(NavBar.TargetPoint);
  OffsetRect(Result, pt.X + 20, pt.Y);
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelHintText: string;
var
  AIndex: Integer;
begin
  Result := '';
  if IsPtNavigationPaneOverflowPanelSign(NavBar.TargetPoint) then
    Result := cxGetResourceString(@sdxNavigationPaneOverflowPanelCustomizeHint)
  else
  begin
    AIndex := GetNavigationPaneOverflowPanelItemIndexAtPos(NavBar.TargetPoint);
    if AIndex > -1 then
      Result := OverflowPanelItems[AIndex].Group.Caption;
  end;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetHintRect: TRect;
begin
  if IsPtNavigationPaneOverflowPanel(NavBar.TargetPoint) then
    Result := GetOverflowPanelHintRect
  else Result := inherited GetHintRect;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetHintText: string;
begin
  if IsPtNavigationPaneOverflowPanel(NavBar.TargetPoint) then
    Result := GetOverflowPanelHintText
  else Result := inherited GetHintText;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetBoundsUpdateType: TdxNavBarChangeType;
begin
  Result := doRecreate;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelClientOffset: TRect;
begin
  Result := cxNullRect;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CreateInfo;
var
  AOverflowPanelItemCount: Integer;
begin
  CreateGroupsInfo;
  if NavBar.ShowGroupCaptions then
    AOverflowPanelItemCount := NavBar.NavigationPaneOverflowPanelItemCount
  else AOverflowPanelItemCount := 0;
  CreateOverflowPanelInfo(AOverflowPanelItemCount, True);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CreateGroupsInfo;
var
  I: Integer;
begin
  ClearGroups;
  if (NavBar.ActiveGroup <> nil) and NavBar.ActiveGroup.Visible then
    AddGroup(Self, NavBar.ActiveGroup, False, True);
  for I := 0 to NavBar.Groups.Count - 1 do
    if NavBar.Groups[I].Visible then
      AddGroup(Self, NavBar.Groups[I], True, False);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CreateOverflowPanelInfo(AItemCount: Integer; AClearOld: Boolean);
var
  I: Integer;
  AItem: PdxNavBarOverflowPanelViewInfoItem;
begin
  if AClearOld then ClearOverflowPanelItems;
  for I := GroupCount - 1 downto 0 do
  begin
    if OverflowPanelItemCount >= AItemCount then break;
    New(AItem);
    FOverflowPanelItems.Insert(0, AItem);
    AItem.Group := Groups[I].Group;
    if Groups[I] <> ActiveGroupViewInfo then
    begin
      Groups[I].Free;
      RemoveGroup(Groups[I]);
    end;
  end;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CalculateBounds;
var
  I, Y: Integer;
begin
  ClearRects;
  Y := GetSpaceBetweenGroups;
  CalculateHeaderBounds(GetGroupHorizontalEdge, Y);
  Y := HeaderRect.Bottom + GetSpaceBetweenGroups;
  if GroupCount = 0 then
  begin
    CalculateSplitterBounds(GetGroupHorizontalEdge, Y);
    Y := SplitterRect.Bottom + GetSpaceBetweenGroups;
  end
  else for I := 0 to GroupCount - 1 do
  begin
    Groups[I].CalculateBounds(GetGroupHorizontalEdge, Y);
    Y := Groups[I].Rect.Bottom + GetSpaceBetweenGroups;
    if I = 0 then
    begin
      CalculateSplitterBounds(GetGroupHorizontalEdge, Y);
      Y := SplitterRect.Bottom + GetSpaceBetweenGroups;
    end;
  end;
  CalculateOverflowPanelBounds(GetGroupHorizontalEdge, Y);
  CalculateScrollButtonsBounds;

  CorrectBounds;
  AdjustControlsBounds;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CalculateHeaderBounds(X, Y: Integer);
begin
  FHeaderRect.Left := X;
  FHeaderRect.Right := ClientWidth - X;
  FHeaderRect.Top := Y;
  FHeaderRect.Bottom := Y + GetHeaderHeight;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CalculateOverflowPanelBounds(X, Y: Integer);

  procedure CalculateOverflowPanelItemRects(const AItemsRect: TRect);
  var
    I, AStartPos, AEndPos, ASelectionWidth: Integer;
    APlaceCount: Integer;
    ASelectionRect, AItemRect: TRect;
    AClientOffset: TRect;
  begin
    AClientOffset := GetOverflowPanelClientOffset;

    ASelectionWidth := GetOverflowPanelImageWidth + 2 * GetOverflowPanelImageWidthAddon;
    with AClientOffset do
      APlaceCount := (cxRectWidth(AItemsRect) - Left - Right) div ASelectionWidth;
    FOverflowPanelVisibleItemCount := Min(APlaceCount, OverflowPanelItemCount);

    AEndPos := AItemsRect.Right - AClientOffset.Right;
    AStartPos := AEndPos - FOverflowPanelVisibleItemCount * ASelectionWidth;

    with AClientOffset do
      ASelectionRect := Rect(0, 0, ASelectionWidth,
        cxRectHeight(FOverflowPanelRect) - Top - Bottom);
    OffsetRect(ASelectionRect, AStartPos, FOverflowPanelRect.Top + AClientOffset.Top);
    InflateRect(ASelectionRect, 0, -1);

    AItemRect := Rect(0, 0, ASelectionWidth, GetOverflowPanelImageHeight);
    OffsetRect(AItemRect, AStartPos, FOverflowPanelRect.Top +
      (cxRectHeight(FOverflowPanelRect) - GetOverflowPanelImageHeight) div 2);
    InflateRect(AItemRect, -GetOverflowPanelImageWidthAddon, 0);

    for I := 0 to FOverflowPanelVisibleItemCount - 1 do
    begin
      OverflowPanelItems[I].SelectionRect := ASelectionRect;
      OffsetRect(OverflowPanelItems[I].SelectionRect, ASelectionWidth * I, 0);
      OverflowPanelItems[I].Rect := AItemRect;
      OffsetRect(OverflowPanelItems[I].Rect, ASelectionWidth * I, 0);
    end;
  end;

var
  AItemsRect: TRect;
begin
  FOverflowPanelRect.Left := X;
  FOverflowPanelRect.Right := ClientWidth - X;
  FOverflowPanelRect.Top := Y;
  FOverflowPanelRect.Bottom := FOverflowPanelRect.Top + GetOverflowPanelHeight;

  FOverflowPanelSignRect := FOverflowPanelRect;
  with GetOverflowPanelClientOffset do
  begin
    FOverflowPanelSignRect.Left := FOverflowPanelSignRect.Right -
      GetOverflowPanelSignWidth - Right;
    Dec(FOverflowPanelSignRect.Right, Right);
    Dec(FOverflowPanelSignRect.Bottom, Bottom);
    Inc(FOverflowPanelSignRect.Top, Top);
  end;
  InflateRect(FOverflowPanelSignRect, 0, -1);
  
  AItemsRect := FOverflowPanelRect;
  AItemsRect.Right := FOverflowPanelSignRect.Left - GetOverflowPanelSeparator;
  CalculateOverflowPanelItemRects(AItemsRect);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CalculateSplitterBounds(X, Y: Integer);
begin
  FSplitterRect.Left := X;
  FSplitterRect.Right := ClientWidth - X;
  FSplitterRect.Top := Y;
  FSplitterRect.Bottom := Y + GetSplitterHeight;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.ClearRects;
begin
  inherited;
  SetRectEmpty(FHeaderRect);
  SetRectEmpty(FSplitterRect);
  SetRectEmpty(FOverflowPanelRect);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CorrectBounds;

  procedure CalcHeightDifference(out AShortage, AHeightDifference: Integer);
  var
    AAvailableHeight, ARequiredHeight, AMinHeight: Integer;
  begin
    AAvailableHeight := ClientHeight - GetOverflowPanelHeight;
    if GroupCount = 1 then
      Dec(AAvailableHeight, GetSplitterHeight);
    ARequiredHeight := Groups[GroupCount - 1].Rect.Bottom;
    AHeightDifference := AAvailableHeight - ARequiredHeight;

    AMinHeight := GetActiveGroupMinHeight;
    if cxRectHeight(ActiveGroupViewInfo.Rect) + AHeightDifference < AMinHeight then // if AHeightDifference < 0
    begin
      AShortage := AMinHeight - cxRectHeight(ActiveGroupViewInfo.Rect) - AHeightDifference;
      AHeightDifference := AMinHeight - cxRectHeight(ActiveGroupViewInfo.Rect);
    end
    else
      AShortage := 0;
  end;

  procedure CorrectOverflowPanel(AShortage: Integer; var AHeightDifference: Integer);

    procedure CorrectOverflowPanelBounds;
    var
      X, Y: Integer;
    begin
      X := Groups[GroupCount - 1].Rect.Left;
      if (GroupCount = 1) or not NavBar.ShowGroupCaptions then
        Y := SplitterRect.Bottom
      else
        Y := Groups[GroupCount - 1].Rect.Bottom;
      CalculateOverflowPanelBounds(X, Y);
    end;

    procedure RemoveExcessGroups(var AOverflowPanelGroupCount: Integer);
    var
      I: Integer;
    begin
      for I := GroupCount - 1 downto 1 do
      begin
        if AShortage <= 0 then
          Break;
        Dec(AShortage, cxRectHeight(Groups[I].Rect));
        Inc(AOverflowPanelGroupCount);
      end;
      Inc(AHeightDifference, -AShortage);
    end;

  var
    AGroupCount: Integer;
  begin
    AGroupCount := NavBar.NavigationPaneOverflowPanelItemCount;
    if not NavBar.ShowGroupCaptions then
      AGroupCount := GroupCount - 1
    else
      if AShortage > 0 then
        RemoveExcessGroups(AGroupCount);

    CreateOverflowPanelInfo(AGroupCount, False);
    CorrectOverflowPanelBounds;
  end;

  procedure CorrectActiveGroupBounds(AHeightDifference: Integer);
  begin
    ActiveGroupViewInfo.CorrectActiveGroupBounds(0, AHeightDifference);
  end;

  procedure OffsetElements(AHeightDifference: Integer);
  var
    I: Integer;
  begin
    OffsetRect(FSplitterRect, 0, AHeightDifference);
    for I := 1 to GroupCount - 1 do
      Groups[I].CorrectBounds(0, AHeightDifference);
    OffsetRect(FOverflowPanelRect, 0, AHeightDifference);
    OffsetRect(FOverflowPanelSignRect, 0, AHeightDifference);
    for I := 0 to FOverflowPanelVisibleItemCount - 1 do
    begin
      OffsetRect(OverflowPanelItems[I].Rect, 0, AHeightDifference);
      OffsetRect(OverflowPanelItems[I].SelectionRect, 0, AHeightDifference);
    end;
  end;

var
  AHeightDifference, AShortage: Integer;
begin
  if (GroupCount > 0) and (ActiveGroupViewInfo <> nil) then
  begin
    CalcHeightDifference(AShortage, AHeightDifference);
    CorrectOverflowPanel(AShortage, AHeightDifference);
    CorrectActiveGroupBounds(AHeightDifference);
    OffsetElements(AHeightDifference);
  end
  else
    CorrectBoundsWithNoGroups;
  CalculateScrollButtonsBounds;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.CorrectBoundsWithNoGroups;
var
  OffsetY: Integer;
begin
  OffsetY := ClientHeight - HeaderRect.Bottom;
  Dec(OffsetY, GetOverflowPanelHeight);
  Dec(OffsetY, GetSplitterHeight);
  if (SplitterRect.Top + OffsetY < HeaderRect.Bottom) then
    OffsetY := HeaderRect.Bottom - SplitterRect.Top;
  OffsetRect(FSplitterRect, 0, OffsetY);
  OffsetRect(FOverflowPanelRect, 0, OffsetY);
  OffsetRect(FOverflowPanelSignRect, 0, OffsetY);
end;

function TdxNavBarOffice11NavPaneViewInfo.GetGroupViewInfoAtItemsPos(pt: TPoint): TdxNavBarGroupViewInfo;
begin
  Result := inherited GetGroupViewInfoAtItemsPos(pt);
  if (Result = ActiveGroupViewInfo) and (NavBar.SourceGroup <> nil) then
    Result := nil;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetViewInfoAtDragPosition(pt: TPoint;
  var ItemGroup: TdxNavBarGroupViewInfo; var Item1, Item2: TdxNavBarLinkViewInfo): Integer;
begin
  Result := inherited GetViewInfoAtDragPosition(pt, ItemGroup, Item1, Item2);
  if (ItemGroup <> nil) and (GroupCount > 0) and (ItemGroup <> Groups[0]) and
    (NavBar.ActiveGroup = ItemGroup.Group) then
  begin
    ItemGroup := Groups[0];
    Item1 := nil;
    if ItemGroup.ItemCount > 0 then
      Item2 := ItemGroup.Items[0]
    else Item2 := nil;
    Result := 0;
  end;
end;

function TdxNavBarOffice11NavPaneViewInfo.IsPtNavigationPaneHeader(pt: TPoint): Boolean;
begin
  Result := PtInRect(FHeaderRect, pt);
end;

function TdxNavBarOffice11NavPaneViewInfo.IsPtNavigationPaneSplitter(pt: TPoint): Boolean;
begin
  Result := PtInRect(FSplitterRect, pt);
end;

function TdxNavBarOffice11NavPaneViewInfo.IsPtNavigationPaneOverflowPanel(pt: TPoint): Boolean;
begin
  Result := PtInRect(OverflowPanelRect, pt);
end;

function TdxNavBarOffice11NavPaneViewInfo.IsPtIncNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean;
begin
  if GroupCount > 1 then
    Result := pt.Y > SplitterRect.Top + cxRectHeight(SplitterRect) div 2 + cxRectHeight(Groups[1].Rect)
  else
    Result := False;
end;

function TdxNavBarOffice11NavPaneViewInfo.IsPtDecNavigationPaneOverflowPanelItemCount(pt: TPoint): Boolean;
begin
  if GroupCount > 1 then
    Result := pt.Y < SplitterRect.Top + cxRectHeight(SplitterRect) div 2 - cxRectHeight(Groups[1].Rect)
  else
    Result := pt.Y < SplitterRect.Top + cxRectHeight(SplitterRect) div 2 - 20;
end;

function TdxNavBarOffice11NavPaneViewInfo.IsPtNavigationPaneOverflowPanelSign(pt: TPoint): Boolean;
begin
  Result := PtInRect(FOverflowPanelSignRect, pt);
end;

function TdxNavBarOffice11NavPaneViewInfo.GetNavigationPaneOverflowPanelItemIndexAtPos(pt: TPoint): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FOverflowPanelVisibleItemCount - 1 do
    if PtInRect(OverflowPanelItems[I].SelectionRect, pt) then
    begin
      Result := I;
      break;
    end;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetNavigationPaneOverflowPanelGroupAtPos(pt: TPoint): TdxNavBarGroup;
var
  AIndex: Integer;
begin
  AIndex := GetNavigationPaneOverflowPanelItemIndexAtPos(pt);
  if (AIndex >= 0 ) then
  begin
    Result := OverflowPanelItems[AIndex].Group;
    if (Result <> nil) and (csDestroying in Result.ComponentState) then
      Result := nil;
  end
  else
    Result := nil;
end;

function TdxNavBarOffice11NavPaneViewInfo.IsDefaultHeaderColor: Boolean;
begin
  Result := (inherited HeaderBackColor = clNone) or (inherited HeaderBackColor2 = clNone);
end;

function TdxNavBarOffice11NavPaneViewInfo.IsDefaultOverflowPanelColor: Boolean;
begin
  Result := (inherited OverflowPanelBackColor = clNone) or (inherited OverflowPanelBackColor2 = clNone);
end;

function TdxNavBarOffice11NavPaneViewInfo.IsDefaultBottomScrollButtonColor: Boolean;
begin
  Result := (inherited BottomScrollButtonBackColor = clNone) or (inherited BottomScrollButtonBackColor2 = clNone);
end;

function TdxNavBarOffice11NavPaneViewInfo.IsDefaultTopScrollButtonColor: Boolean;
begin
  Result := (inherited TopScrollButtonBackColor = clNone) or (inherited TopScrollButtonBackColor2 = clNone);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.RecreateImageList;
begin
  FImageList.Free;
  FImageList := TImageList.Create(NavBar);
end;

{ TdxNavBarOffice11NavPanelPainter }

procedure TdxNavBarOffice11NavPanePainter.DrawNavBarControl;
begin
  inherited DrawNavBarControl;
  DrawHeader;
  DrawOverflowPanel;
  DrawSplitter;
  DrawBorder;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  with AGroupViewInfo do
    TdxNavBarOffice11NavPaneGroupButtonPainter.DrawButton(Canvas, CaptionRect, CaptionImage,
      CaptionBackColor, CaptionBackColor2, CaptionAlphaBlend, CaptionAlphaBlend2,
      CaptionGradientMode, CaptionBorderColor, State);
end;

procedure TdxNavBarOffice11NavPanePainter.DrawHintWindow;
begin
  if (NavBar.NavigationPaneOverflowPanelHotTrackedIndex > -1) or NavBar.NavigationPaneOverflowPanelSignHotTracked then
    DrawOverflowPanelHintWindow
  else inherited DrawHintWindow;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawBorder;
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := ColorToRGB(ViewInfo.BorderColor);
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 1;
  Canvas.Rectangle(0, 0, ViewInfo.ClientWidth, ViewInfo.ClientHeight);
end;

procedure TdxNavBarOffice11NavPanePainter.DrawHeader;
var
  AHandled: Boolean;
  R: TRect;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneHeader) then
    NavBar.OnCustomDrawNavigationPaneHeader(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then
  begin
    R := ViewInfo.HeaderRect;
    Inc(R.Top);
    with ViewInfo do
      BackgroundPainterClass.DrawBackground(Canvas, R, HeaderImage, False, clNone,
        HeaderBackColor, HeaderBackColor2, HeaderAlphaBlend, HeaderAlphaBlend2,
        OverflowPanelGradientMode);
    DrawHeaderText;
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawHeaderText;
var
  R: TRect;
  AText: string;
begin
  with ViewInfo do
  begin
    R := HeaderRect;
    Inc(R.Left, ViewInfo.GetGroupCaptionTextIndent);
    if (NavBar.ActiveGroup <> nil) and NavBar.ActiveGroup.Visible then
      AText := NavBar.ActiveGroup.Caption
    else AText := '';
    Canvas.Brush.Style := bsClear;
    Canvas.Font := HeaderFont;
    Canvas.Font.Color := HeaderFontColor;
    cxDrawText(DC, AText, R, HeaderDrawEdgeFlag);
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawItemsRect(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if not AGroupViewInfo.IsCaptionVisible then
    inherited;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawOverflowPanel;
var
  AHandled: Boolean;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneOverflowPanel) then
    NavBar.OnCustomDrawNavigationPaneOverflowPanel(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then
  begin
    with ViewInfo do
      TdxNavBarOffice11NavPaneGroupButtonPainter.DrawButton(Canvas, OverflowPanelRect, OverflowPanelImage,
        OverflowPanelBackColor, OverflowPanelBackColor2, OverflowPanelAlphaBlend,
        OverflowPanelAlphaBlend2, OverflowPanelGradientMode, BorderColor, []);
    DrawOverflowPanelSign;
    DrawOverflowPanelItems;
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawOverflowPanelSign;
var
  R: TRect;
  X, Y: Integer;
begin
  if dxOffice11NavPaneOverflowPanelBitmap <> nil then
  begin
    R := ViewInfo.OverflowPanelSignRect;
    if R.Left > ViewInfo.OverflowPanelRect.Left then
    begin
      if NavBar.NavigationPaneOverflowPanelSignPressed then
        BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
          dxOffice11NavPaneGroupCaptionPressedHotColor1, dxOffice11NavPaneGroupCaptionPressedHotColor2,
          255, 255, gmVertical)
      else if NavBar.NavigationPaneOverflowPanelSignHotTracked then
        BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
          dxOffice11NavPaneGroupCaptionHotColor1, dxOffice11NavPaneGroupCaptionHotColor2,
          255, 255, gmVertical);
      X := ((R.Right - R.Left) - dxOffice11NavPaneOverflowPanelBitmap.Width) div 2 + R.Left;
      Y := ((R.Bottom - R.Top) - dxOffice11NavPaneOverflowPanelBitmap.Height) div 2 + R.Top;
      Canvas.Draw(X, Y, dxOffice11NavPaneOverflowPanelBitmap);
    end;
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawOverflowPanelItems;
var
  I: Integer;
  AGroup: TdxNavBarGroup;
  R: TRect;
begin
  for I := 0 to ViewInfo.FOverflowPanelVisibleItemCount - 1 do
  begin
    R := ViewInfo.OverflowPanelItems[I].SelectionRect;
    AGroup := ViewInfo.OverflowPanelItems[I].Group;
    if (NavBar.NavigationPaneOverflowPanelPressedIndex = I) or (AGroup = NavBar.ActiveGroup) then
    begin
      if NavBar.NavigationPaneOverflowPanelHotTrackedIndex = I then
        BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
          dxOffice11NavPaneGroupCaptionPressedHotColor1,
          dxOffice11NavPaneGroupCaptionPressedHotColor2,
          255, 255, gmVertical)
      else
        BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
          dxOffice11NavPaneGroupCaptionPressedColor1, dxOffice11NavPaneGroupCaptionPressedColor2,
          255, 255, gmVertical);
    end
    else if NavBar.NavigationPaneOverflowPanelHotTrackedIndex = I then
      BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
        dxOffice11NavPaneGroupCaptionHotColor1, dxOffice11NavPaneGroupCaptionHotColor2,
        255, 255, gmVertical);
    R := ViewInfo.OverflowPanelItems[I].Rect;
    if ImagePainterClass.IsValidImage(ViewInfo.GetOverflowPanelImageList, ViewInfo.GetOverflowPanelImageIndex(AGroup)) then
      ImagePainterClass.DrawImage(Canvas, ViewInfo.GetOverflowPanelImageList, ViewInfo.GetOverflowPanelImageIndex(AGroup), R)
    else if NavBar.NavigationPaneOverflowPanelUseSmallImages then
      Canvas.Draw(R.Left, R.Top, dxOffice11NavPaneDefaultSmallBitmap)
    else Canvas.Draw(R.Left, R.Top, dxOffice11NavPaneDefaultLargeBitmap);
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawOverflowPanelHintWindow;
var
  AHandled: Boolean;
  AGroup: TdxNavBarGroup;
begin
  if NavBar.NavigationPaneOverflowPanelHotTrackedIndex > -1 then
    AGroup := ViewInfo.OverflowPanelItems[NavBar.NavigationPaneOverflowPanelHotTrackedIndex].Group
  else AGroup := nil;
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneOverflowPanelHint) then
    NavBar.OnCustomDrawNavigationPaneOverflowPanelHint(NavBar, HintWindowCanvas, AGroup,
      NavBar.ViewInfo.HintText, NavBar.HintWindow.ClientRect, AHandled);
  if not AHandled then
    with ViewInfo do
      TdxNavBarHintPainter.DrawHint(HintWindowCanvas, NavBar.HintWindow.ClientRect,
          ViewInfo.HintText, HintImage, HintBackColor, HintBackColor2,
          HintAlphaBlend, HintAlphaBlend2, HintGradientMode, HintFont);
end;

procedure TdxNavBarOffice11NavPanePainter.DrawSplitter;
var
  AHandled: Boolean;
  R: TRect;
begin
  AHandled := False;
  if Assigned(NavBar.OnCustomDrawNavigationPaneSplitter) then
    NavBar.OnCustomDrawNavigationPaneSplitter(NavBar, Canvas, ViewInfo, AHandled);
  if not AHandled then
  begin
    with ViewInfo do
    begin
      Canvas.Brush.Color := clWhite;
      R := SplitterRect;
      Canvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Top + 1));
      Inc(R.Top);
      BackgroundPainterClass.DrawBackground(Canvas, R, nil, False, clNone,
        SplitterBackColor, SplitterBackColor2, SplitterAlphaBlend, SplitterAlphaBlend2,
        SplitterGradientMode);
    end;
    DrawSplitterSign;
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawSplitterSign;
var
  X, Y: Integer;
begin
  if dxOffice11NavPaneSplitterBitmap <> nil then
  begin
    X := ((ViewInfo.SplitterRect.Right - ViewInfo.SplitterRect.Left) - dxOffice11NavPaneSplitterBitmap.Width) div 2 +
      ViewInfo.SplitterRect.Left;
    if X > ViewInfo.OverflowPanelRect.Left then
    begin
      Y := ((ViewInfo.SplitterRect.Bottom - ViewInfo.SplitterRect.Top) - dxOffice11NavPaneSplitterBitmap.Height) div 2 +
        ViewInfo.SplitterRect.Top;
      Canvas.Draw(X, Y, dxOffice11NavPaneSplitterBitmap);
    end;
  end;
end;

procedure TdxNavBarOffice11NavPanePainter.DrawPopupMenuItem(ACanvas: TCanvas; ARect: TRect; AImageList: TCustomImageList;
  AImageIndex: Integer; AText: string; State: TdxNavBarObjectStates);
var
  R: TRect;
begin
  BackgroundPainterClass.DrawBackground(ACanvas, ARect, nil, False, clNone,
    clMenu, clMenu, 255, 255, gmVertical);
  R := ARect;
  R.Right := R.Left + 2 * ViewInfo.GetOverflowPanelPopupMenuImageIndent + ViewInfo.GetSmallImageWidth;
  BackgroundPainterClass.DrawBackground(ACanvas, R, nil, False, clNone, dxOffice11NavPaneGroupCaptionColor1,
    dxOffice11NavPaneGroupCaptionColor2, 255, 255, gmHorizontal);

  if AText <> '-' then
  begin
    InflateRect(R, -1, -1);
    if sSelected in State then
    begin
      ButtonPainterClass.DrawButton(ACanvas, ARect, nil, dxOffice11NavPaneGroupCaptionHotColor1,
        dxOffice11NavPaneGroupCaptionHotColor2, 255, 255, gmVertical, dxOffice11NavPaneBorder, []);
      if sActive in State then
        ButtonPainterClass.DrawButton(ACanvas, R, nil, dxOffice11NavPaneGroupCaptionPressedColor1,
          dxOffice11NavPaneGroupCaptionPressedColor2, 255, 255, gmVertical, dxOffice11NavPaneBorder, []);
    end
    else if sActive in State then
      ButtonPainterClass.DrawButton(ACanvas, R, nil, dxOffice11NavPaneGroupCaptionHotColor1,
        dxOffice11NavPaneGroupCaptionHotColor1, 255, 255, gmVertical, dxOffice11NavPaneBorder, []);

    InflateRect(R,  1 - ViewInfo.GetOverflowPanelPopupMenuImageIndent, 1 - ViewInfo.GetOverflowPanelPopupMenuImageIndent);
    AImageList.Draw(ACanvas, R.Left, R.Top, AImageIndex, not (sDisabled in State));

    R := ARect;
    R.Left := R.Left + 2 * ViewInfo.GetOverflowPanelPopupMenuImageIndent + ViewInfo.GetSmallImageWidth + ViewInfo.GetOverflowPanelPopupMenuTextIndent;
    if sDisabled in State then
      ACanvas.Font.Color := clGrayText
    else ACanvas.Font.Color := clMenuText;
    ACanvas.Brush.Style := bsClear;
    cxDrawText(ACanvas.Handle, AText, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  end
  else
  begin
    ACanvas.Pen.Color := Dark(dxOffice11NavPaneGroupCaptionColor2, 80);
    ACanvas.MoveTo(R.Right + cxRectWidth(R) div 2, R.Top + cxRectHeight(ARect) div 2);
    ACanvas.LineTo(ARect.Right, R.Top + cxRectHeight(ARect) div 2);
  end;
end;

function TdxNavBarOffice11NavPanePainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarOffice11NavPaneViewInfo.Create(Self);
end;

function TdxNavBarOffice11NavPanePainter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarOffice11NavPaneGroupViewInfo.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

class function TdxNavBarOffice11NavPanePainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarOffice11NavPaneButtonPainter;
end;

function TdxNavBarOffice11NavPanePainter.GetViewInfo: TdxNavBarOffice11NavPaneViewInfo;
begin
  if inherited ViewInfo is TdxNavBarOffice11NavPaneViewInfo then
    Result := inherited ViewInfo as TdxNavBarOffice11NavPaneViewInfo
  else Result := nil;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.ClearOverflowPanelItems;
var
  I: Integer;
begin
  for I := 0 to OverflowPanelItemCount - 1 do
    Dispose(OverflowPanelItems[I]);
  FOverflowPanelItems.Clear;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoMoreButtonsClick(Sender: TObject);
begin
  NavBar.DoDecNavigationPaneOverflowPanelItemCount;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoFewerButtonsClick(Sender: TObject);
begin
  NavBar.DoIncNavigationPaneOverflowPanelItemCount;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoAddRemoveButtonsClick(Sender: TObject);
var
  AMenuItem: TMenuItem;
  AGroup: TdxNavBarGroup;
begin
  AMenuItem := Sender as TMenuItem;
{$IFNDEF DELPHI6}
  AMenuItem.Checked := not AMenuItem.Checked;
{$ENDIF}
  AGroup := NavBar.Groups[AMenuItem.MenuIndex];
  AGroup.Visible := AMenuItem.Checked;
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoHiddenGroupClick(Sender: TObject);
begin
  NavBar.ActiveGroup := TdxNavBarGroup(TMenuItem(Sender).Tag);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
var
  AMenuItem: TMenuItem;
  AState: TdxNavBarObjectStates;
  AImageList: TCustomImageList;
  AImageIndex: Integer;
begin
  AMenuItem := Sender as TMenuItem;
  AState := [];
  if Selected then
    Include(AState, sSelected);
  if AMenuItem.Checked then
    Include(AState, sActive);
  if not AMenuItem.Enabled then
    Include(AState, sDisabled);

  AImageIndex := AMenuItem.ImageIndex;
  if IsImageAssigned(NavBar.SmallImages, AImageIndex) then
    AImageList := NavBar.SmallImages
  else
  begin
    AImageList := ImageList;
    Dec(AImageIndex, GetSmallImagesCount);
  end;
  (Painter as TdxNavBarOffice11NavPanePainter).DrawPopupMenuItem(ACanvas, ARect,
    AImageList, AImageIndex, AMenuItem.Caption, AState);
end;

procedure TdxNavBarOffice11NavPaneViewInfo.DoMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  Height := 2 * GetOverflowPanelPopupMenuImageIndent + GetSmallImageHeight;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelItemCount: Integer;
begin
  Result := FOverflowPanelItems.Count;
end;

function TdxNavBarOffice11NavPaneViewInfo.GetOverflowPanelItems(Index: Integer): PdxNavBarOverflowPanelViewInfoItem;
begin
  Result := FOverflowPanelItems[Index];
end;

function TdxNavBarOffice11NavPaneViewInfo.GetSmallImagesCount: Integer;
begin
  if NavBar.SmallImages <> nil then
    Result := NavBar.SmallImages.Count
  else
    Result := 0;
end;

initialization
  RegisterView(dxNavBarOffice11TaskPaneView, 'Office11TaskPaneView', TdxNavBarOffice11Painter);
  RegisterView(dxNavBarOffice11NavigatorPaneView, 'Office11NavigationPaneView', TdxNavBarOffice11NavPanePainter);

finalization
  UnRegisterView(dxNavBarOffice11TaskPaneView);
  UnRegisterView(dxNavBarOffice11NavigatorPaneView);
  
end.
