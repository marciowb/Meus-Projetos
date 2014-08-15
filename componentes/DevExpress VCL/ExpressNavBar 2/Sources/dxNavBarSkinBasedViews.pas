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

unit dxNavBarSkinBasedViews;

interface

uses
  Types, Windows, Graphics, Classes, SysUtils, ImgList, cxGraphics, cxClasses,
  dxNavBar, dxNavBarBase, dxNavBarCollns, dxNavBarStyles, dxNavBarExplorerViews,
  dxNavBarConsts, dxNavBarOffice11Views, dxNavBarOfficeViews, dxSkinsStrs,
  dxSkinsCore, dxSkinInfo, cxLookAndFeelPainters;

type
  IdxNavBarColorSchemes = interface
    ['{C49F9017-0A09-4C8E-BF28-BA5BE0614580}']
    function GetCount: Integer;
    function GetNames(AIndex: Integer): TdxSkinName;
    function GetName: TdxSkinName;
    procedure SetName(AValue: TdxSkinName);
  end;

  TdxNavBarSkin = class(TdxSkin)
    procedure LoadFromResource(hInst: THandle); override;
  end;

  TdxNavBarSkinInfo = class(TdxSkinInfo)
  protected
    procedure InitializeAdditionalNavBarElements; virtual;
    procedure InitializeSkinInfo; override;
  public
    NavBarDragDropItemTarget: TdxSkinElement;
    NavBarSeparator: TdxSkinElement;
  end;

  TdxNavBarSkinBasedPainterHelper = class(TcxIUnknownObject, IdxNavBarColorSchemes)
  private
    FCachedPainterData: TdxSkinInfo;
    FSkinName: TdxSkinName;
    FOnChanged: TNotifyEvent;
  protected
    { IdxNavBarColorSchemes }
    function IdxNavBarColorSchemes.GetCount = GetSkinsCount;
    function IdxNavBarColorSchemes.GetNames = GetSkinNames;
    function IdxNavBarColorSchemes.GetName = GetSkinName;
    procedure IdxNavBarColorSchemes.SetName = SetSkinName;

    procedure DoChanged; virtual;
    function GetFullSkinName: TdxSkinName; virtual;
    function GetSkinsCount: Integer; virtual;
    function GetSkinNames(AIndex: Integer): TdxSkinName; virtual;
    function GetSkinInfoClass: TdxSkinInfoClass; virtual;
    function GetSkinName: TdxSkinName; virtual;
    function GetSkinPainterData(var AData: TdxSkinInfo): Boolean; virtual;
    function IsSkinAvailable: Boolean; virtual;
    procedure SetSkinName(AValue: TdxSkinName); virtual;
  public
    constructor Create(ASkinName: TdxSkinName); virtual;
    destructor Destroy; override;
    // Skin elements and properties
    function NavBarBackground: TdxSkinElement; virtual;
    function NavBarDragDropItemTarget: TdxSkinElement; virtual;
    function NavBarGroupButtonCaption: TdxSkinElement; virtual;
    function NavBarGroupClient: TdxSkinElement; virtual;
    function NavBarGroupSigns (AIsClose: Boolean): TdxSkinElement; virtual;
    function NavBarItem: TdxSkinElement; virtual;
    function NavBarScrollBarElements(AIsHorizontal: Boolean; APart: TcxScrollBarPart): TdxSkinScrollInfo; virtual;
    function NavBarSeparator: TdxSkinElement; virtual;
    function NavPaneCaptionFontSize: TdxSkinIntegerProperty; virtual;
    function NavPaneCaptionHeight: TdxSkinIntegerProperty; virtual;
    function NavPaneDoesGroupCaptionButtonRequireOffset: Boolean; virtual;
    function NavPaneGroupButtonCaption(AIsSelected: Boolean): TdxSkinElement; virtual;
    function NavPaneGroupClient: TdxSkinElement; virtual;
    function NavPaneHeader: TdxSkinElement; virtual;
    function NavePaneHeaderSign(ACollapse: Boolean): TdxSkinElement; virtual;
    function NavPaneItem(AIsSelected: Boolean): TdxSkinElement; virtual;
    function NavPaneItemPanel: TdxSkinElement; virtual;
    function NavPaneOverflowPanel: TdxSkinElement; virtual;
    function NavPaneOverflowPanelSign: TdxSkinElement; virtual;
    function NavPaneOverflowPanelItem: TdxSkinElement; virtual;
    function NavPanePopupControl: TdxSkinElement; virtual;
    function NavPanePopupMenu: TdxSkinElement; virtual;
    function NavPanePopupMenuSelection: TdxSkinElement; virtual;
    function NavPanePopupMenuSeparator: TdxSkinElement; virtual;
    function NavPanePopupMenuSideStrip: TdxSkinElement; virtual;
    function NavPaneScrollButtons(AIsDown: Boolean): TdxSkinElement; virtual;
    function NavPaneSplitter: TdxSkinElement; virtual;
    function NavPaneSizeGrip: TdxSkinElement; virtual;

    property SkinName: TdxSkinName read GetSkinName write SetSkinName;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

  TdxNavBarSkinBasedPainterHelperClass = class of TdxNavBarSkinBasedPainterHelper;

  { TdxNavBarSkinNavPaneLinkViewInfo }

  TdxNavBarSkinBasedNavPaneLinkViewInfo = class(TdxNavBarLinkViewInfo)
  protected
    function GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
  public
    function FontColor: TColor; override;
    function SelectionRect: TRect; override;
  end;

  { TdxNavBarSkinNavPaneGroupViewInfo }

  TdxNavBarSkinBasedNavPaneGroupViewInfo = class(TdxNavBarNavigationPaneGroupViewInfo)
  protected
    function GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
  public
    function CaptionFontColor: TColor; override;
  end;

  { TdxNavBarSkinBasedOverflowPanelViewInfo }

  TdxNavBarSkinBasedOverflowPanelViewInfo = class(TdxNavBarOverflowPanelViewInfo)
  protected
    function GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
    function IsSkinAvailable: Boolean;

    function GetClientOffset: TRect; override;
    function GetSignWidth: Integer; override;
  end;

  { TdxNavBarSkinBasedNavPaneViewInfo }

  TdxNavBarSkinBasedNavPaneViewInfo = class(TdxNavBarNavigationPaneViewInfo)
  protected
    function GetSkinHelper: TdxNavBarSkinBasedPainterHelper; virtual;
    function IsSkinAvailable: Boolean;

    function GetDragDropItemTargetHeight: Integer;
    function GetGroupBorderOffsets: TRect; override;
    function GetGroupEdges: TPoint; override;
    function GetGroupHeaderTextIndent: Integer; override;
    function GetOverflowPanelViewInfoClass: TdxNavBarOverflowPanelViewInfoClass; override;
  public
    procedure AssignDefaultNavigationPaneHeaderStyle; override;
    function BorderColor: TColor; override;
    function CollapseBarFontColor: TColor; override;
    function GetHeaderHeight: Integer; override;
    function GetSplitterHeight: Integer; override;
    function HeaderFontColor: TColor; override;
  end;

  TdxNavBarSkinBasedPopupControlViewInfo = class(TdxNavBarPopupControlViewInfo)
  protected
    function GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
    function GetBorderOffsets: TRect; override;
  end;

  { TdxNavBarSkinBasedNavPanePainter }

  TdxNavBarSkinBasedNavPanePainter = class(TdxNavBarNavigationPanePainter, IdxNavBarColorSchemes)
  private
    function GetGroupCaptionButtonDrawOffsets: TRect;
    function GetOverflowPanelViewInfo: TdxNavBarSkinBasedOverflowPanelViewInfo;
    function InternalDrawScrollButton(ADownButton: Boolean; const ARect: TRect;
      AState: TdxNavBarObjectStates): Boolean;
  protected
    FSkinBasedPainterHelper: TdxNavBarSkinBasedPainterHelper;

    function CreateSkinHelper: TdxNavBarSkinBasedPainterHelper; virtual;

    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    class function GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass; override;
    class function GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass; virtual;
    class function GetPopupControlViewInfoClass: TdxNavBarPopupControlViewInfoClass; override;

    procedure ColorSchemeChanged(ASender: TObject); virtual;
    function GetColorSchemeHelper: IdxNavBarColorSchemes; virtual;
    function GetDefaultColorSchemeName: TdxSkinName; virtual;
    function GetColorSchemeName: TdxSkinName; virtual;
    function IsSkinAvailable: Boolean; virtual;
    procedure SetColorSchemeName(const AValue: TdxSkinName); virtual;

    function GetNavPaneElementState(const APart: TdxNavBarPart): TdxSkinElementState;
    function GetSplitterType: Integer; virtual;
      // Drawing
    procedure DoDrawDropTargetLinkSelection(AItemGroup: TdxNavBarGroupViewInfo; AItem1, AItem2: TdxNavBarLinkViewInfo); override;
    procedure DoDrawSplitter; override;

    property ColorSchemeHelper: IdxNavBarColorSchemes read GetColorSchemeHelper implements IdxNavBarColorSchemes;
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    destructor Destroy; override;
      // Drawing
    procedure DrawBottomScrollButton; override;
    procedure DrawCollapseElementBackground(const ARect: TRect; AState: TdxNavBarNavPanePartState); override;
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawHeaderBackground; override;
    procedure DrawHeaderSign; override;
    procedure DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo); override;
    procedure DrawOverflowPanelBackground; override;
    procedure DrawOverflowPanelItems; override;
    procedure DrawOverflowPanelSign; override;
    procedure DrawPopupControl(ACanvas: TcxCanvas; AViewInfo: TdxNavBarPopupControlViewInfo); override;
    procedure DrawPopupMenuItem(ACanvas: TCanvas; ARect: TRect;
      AImageList: TCustomImageList; AImageIndex: Integer; AText: String;
      State: TdxNavBarObjectStates); override;
    procedure DrawSeparator(ALinkViewInfo: TdxNavBarLinkViewInfo); override;
    procedure DrawTopScrollButton; override;

    property OverflowPanelViewInfo: TdxNavBarSkinBasedOverflowPanelViewInfo read GetOverflowPanelViewInfo;
    property ColorSchemeName: TdxSkinName read GetColorSchemeName write SetColorSchemeName;
  end;

  { TdxNavBarSkinBasedExplorerBarViewInfo }

  TdxNavBarSkinBasedExplorerBarViewInfo = class(TdxNavBarOffice11ExplorerBarViewInfo)
  protected
    function GetSkinHelper: TdxNavBarSkinBasedPainterHelper;

    function GetDragDropItemTargetHeight: Integer;
    function GetGroupBorderOffsets: TRect; override;
  end;

  { TdxNavBarSkinExplorerBarPainter }

  TdxNavBarSkinBasedExplorerBarPainter = class(TdxNavBarOffice11ExplorerBarPainter, IdxNavBarColorSchemes)
  protected
    FSkinBasedPainterHelper: TdxNavBarSkinBasedPainterHelper;

    function CreateSkinHelper: TdxNavBarSkinBasedPainterHelper; virtual;

    class function GetViewInfoClass: TdxNavBarViewInfoClass; override;
    class function GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass; override;
    class function GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass; override;
    class function GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass; virtual;

    procedure ColorSchemeChanged(ASender: TObject); virtual;
    function GetColorSchemeName: TdxSkinName; virtual;
    function GetColorSchemeHelper: IdxNavBarColorSchemes; virtual;
    function GetDefaultColorSchemeName: TdxSkinName; virtual;
    function IsSkinAvailable: Boolean; virtual;
    procedure SetColorSchemeName(const AValue: TdxSkinName); virtual;

    procedure DoDrawDropTargetLinkSelection(AItemGroup: TdxNavBarGroupViewInfo; AItem1, AItem2: TdxNavBarLinkViewInfo); override;
    function IsGroupCaptionButtonCompositeDraw(AGroupViewInfo: TdxNavBarGroupViewInfo): Boolean; virtual;

    property ColorSchemeHelper: IdxNavBarColorSchemes read GetColorSchemeHelper implements IdxNavBarColorSchemes;
  public
    constructor Create(ANavBar: TdxCustomNavBar); override;
    destructor Destroy; override;

    procedure DrawGroupBorder(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawGroupCaptionSign(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
    procedure DrawGroupControlSplitter(AGroupViewInfo: TdxNavBarExplorerBarGroupViewInfo); override;
    procedure DrawSeparator(ALinkViewInfo: TdxNavBarLinkViewInfo); override;

    property ColorSchemeName: TdxSkinName read GetColorSchemeName write SetColorSchemeName;
  end;

  { TdxNavBarSkinExplorerBarLinkViewInfo }

  TdxNavBarSkinBasedExplorerBarLinkViewInfo = class(TdxNavBarOffice3LinkViewInfo)
  public
    function FontColor: TColor; override;
  end;

  { TdxNavBarSkinExplorerBarGroupViewInfo }

  TdxNavBarSkinBasedExplorerBarGroupViewInfo = class(TdxNavBarExplorerBarGroupViewInfo)
  public
    function CaptionFontColor: TColor; override;
    procedure CalculateBounds(var X, Y: Integer); override;
  end;

function GetNavBarColorSchemes(APainter: TdxNavBarPainter): IdxNavBarColorSchemes;

function NavBarObjectStateToSkinState(AState: TdxNavBarObjectStates): TdxSkinElementState;
function GetSkinElementOffsets(AElement: TdxSkinElement): TRect;
function DrawSkinElement(AElement: TdxSkinElement; ACanvas: TCanvas; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal; ADrawContentOnly: Boolean = False): Boolean;

implementation

uses
  Math, cxGeometry, dxNavBarGraphics;

const
  //Additional NavBar elements
  sdxNavBarDragDropItemTarget = 'DragDropItemTarget';
  sdxNavBarSeparator = 'Separator';

type
  TdxNavBarNavigationPaneControllerAccess = class(TdxNavBarNavigationPaneController);

function GetNavBarColorSchemes(APainter: TdxNavBarPainter): IdxNavBarColorSchemes;
begin
  Supports(APainter, IdxNavBarColorSchemes, Result);
end;

function NavBarObjectStateToSkinState(AState: TdxNavBarObjectStates): TdxSkinElementState;
begin
  Result := esNormal;
  if sPressed in AState then
    Result := esPressed
  else
    if sHotTracked in AState then
      Result := esHot
    else
      if sDisabled in AState then
        Result := esDisabled
      else
        if sSelected in AState then
          Result := esPressed;
end;

function GetSkinElementOffsets(AElement: TdxSkinElement): TRect;
begin
  if AElement <> nil then
  begin
    Result := AElement.ContentOffset.Rect;
    if cxRectIsNull(Result) then
      with AElement.Borders do
        Result := cxRect(Left.Thin, Top.Thin, Right.Thin, Bottom.Thin);
  end
  else
    Result := cxNullRect;
end;

function DrawSkinElement(AElement: TdxSkinElement; ACanvas: TCanvas; const ARect: TRect;
  AImageIndex: Integer = 0; AState: TdxSkinElementState = esNormal; ADrawContentOnly: Boolean = False): Boolean;
var
  AcxCanvas: TcxCanvas;
  ADrawRect: TRect;
begin
  if AElement <> nil then
  begin
    Result := True;
    AcxCanvas := TcxCanvas.Create(ACanvas);
    AcxCanvas.SaveClipRegion;
    try
      AcxCanvas.SetClipRegion(TcxRegion.Create(ARect), roIntersect);
      if ADrawContentOnly then
        ADrawRect := cxRectContent(ARect, cxRectInvert(GetSkinElementOffsets(AElement)))
      else
        ADrawRect := ARect;
      AElement.Draw(AcxCanvas.Handle, ADrawRect, AImageIndex, AState);
    finally
      AcxCanvas.RestoreClipRegion;
      AcxCanvas.Free;
    end;
  end
  else
    Result := False;
end;

{ TdxNavBarSkin}

procedure TdxNavBarSkin.LoadFromResource(hInst: THandle);
var
  AStream: TStream;
begin
  AStream := TResourceStream.Create(hInst, Name, PChar(sdxNavBarResourceType));
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

{ TdxNavBarSkinInfo }

procedure TdxNavBarSkinInfo.InitializeAdditionalNavBarElements;
begin
  NavBarDragDropItemTarget := GetElementByName(Group_NavBar, sdxNavBarDragDropItemTarget);
  NavBarSeparator := GetElementByName(Group_NavBar, sdxNavBarSeparator);
end;

procedure TdxNavBarSkinInfo.InitializeSkinInfo;
begin
  inherited;
  InitializeAdditionalNavBarElements;
end;

{ TdxNavBarSkinBasedPainterHelper }

constructor TdxNavBarSkinBasedPainterHelper.Create(ASkinName: TdxSkinName);
begin
  inherited Create;
  FSkinName := ASkinName;
end;

destructor TdxNavBarSkinBasedPainterHelper.Destroy;
begin
  FreeAndNil(FCachedPainterData);
  inherited;
end;

procedure TdxNavBarSkinBasedPainterHelper.DoChanged;
begin
  CallNotify(OnChanged, Self);
end;

function TdxNavBarSkinBasedPainterHelper.GetFullSkinName: TdxSkinName;
begin
  Result := SkinName;
end;

function TdxNavBarSkinBasedPainterHelper.GetSkinsCount: Integer;
begin
  Result := 0;
end;

function TdxNavBarSkinBasedPainterHelper.GetSkinNames(AIndex: Integer): TdxSkinName;
begin
  Result := '';
end;

function TdxNavBarSkinBasedPainterHelper.GetSkinInfoClass: TdxSkinInfoClass;
begin
  Result := TdxNavBarSkinInfo;
end;

function TdxNavBarSkinBasedPainterHelper.GetSkinName: TdxSkinName;
begin
  Result := FSkinName;
end;

function TdxNavBarSkinBasedPainterHelper.GetSkinPainterData(var AData: TdxSkinInfo): Boolean;
begin
  if (FCachedPainterData = nil) and IsGdiPlusAvailable then
    FCachedPainterData := GetSkinInfoClass.Create(
      TdxNavBarSkin.Create(GetFullSkinName, True, HInstance));
  AData := FCachedPainterData;
  Result := AData <> nil;
end;

function TdxNavBarSkinBasedPainterHelper.IsSkinAvailable: Boolean;
var
  AData: TdxSkinInfo;
begin
  Result := GetSkinPainterData(AData);
end;

procedure TdxNavBarSkinBasedPainterHelper.SetSkinName(AValue: TdxSkinName);
begin
  if FSkinName <> AValue then
  begin
    FreeAndNil(FCachedPainterData);
    FSkinName := AValue;
    DoChanged;
  end;
end;

function TdxNavBarSkinBasedPainterHelper.NavBarBackground: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavBarBackgroundColor;
end;

function TdxNavBarSkinBasedPainterHelper.NavBarDragDropItemTarget: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := TdxNavBarSkinInfo(ASkinInfo).NavBarDragDropItemTarget;
end;

function TdxNavBarSkinBasedPainterHelper.NavBarGroupButtonCaption: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavBarGroupHeader;
end;

function TdxNavBarSkinBasedPainterHelper.NavBarGroupClient: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavBarGroupClient;
end;

function TdxNavBarSkinBasedPainterHelper.NavBarGroupSigns(
  AIsClose: Boolean): TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavBarGroupButtons[AIsClose];
end;

function TdxNavBarSkinBasedPainterHelper.NavBarItem: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavBarItem;
end;

function TdxNavBarSkinBasedPainterHelper.NavBarScrollBarElements(
  AIsHorizontal: Boolean; APart: TcxScrollBarPart): TdxSkinScrollInfo;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.ScrollBar_Elements[AIsHorizontal, APart];
end;

function TdxNavBarSkinBasedPainterHelper.NavBarSeparator: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := TdxNavBarSkinInfo(ASkinInfo).NavBarSeparator;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneCaptionFontSize: TdxSkinIntegerProperty;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneCaptionFontSize;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneCaptionHeight: TdxSkinIntegerProperty;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneCaptionHeight;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneDoesGroupCaptionButtonRequireOffset: Boolean;
begin
  Result := True;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneGroupButtonCaption(
  AIsSelected: Boolean): TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneGroupButton[AIsSelected];
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneGroupClient: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneGroupClient;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneHeader: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneGroupCaption;
end;

function TdxNavBarSkinBasedPainterHelper.NavePaneHeaderSign(ACollapse: Boolean): TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    if ACollapse then
      Result := ASkinInfo.NavPaneCollapseButton
    else
      Result := ASkinInfo.NavPaneExpandButton;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneItem(
  AIsSelected: Boolean): TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    if AIsSelected then
      Result := ASkinInfo.NavPaneSelectedItem
    else
      Result := ASkinInfo.NavPaneItem;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneItemPanel: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneCollapsedGroupClient;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneOverflowPanel: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneOverflowPanel;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneOverflowPanelSign: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneOverflowPanelExpandedItem;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneOverflowPanelItem: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneOverflowPanelItem;
end;

function TdxNavBarSkinBasedPainterHelper.NavPanePopupControl: TdxSkinElement;
begin
  Result := NavBarBackground;
end;

function TdxNavBarSkinBasedPainterHelper.NavPanePopupMenu: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.PopupMenu;
end;

function TdxNavBarSkinBasedPainterHelper.NavPanePopupMenuSelection: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.PopupMenuLinkSelected;
end;

function TdxNavBarSkinBasedPainterHelper.NavPanePopupMenuSeparator: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.PopupMenuSeparator;
end;

function TdxNavBarSkinBasedPainterHelper.NavPanePopupMenuSideStrip: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.PopupMenuSideStrip;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneScrollButtons(
  AIsDown: Boolean): TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneScrollButtons[AIsDown];
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneSplitter: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneSplitter;
end;

function TdxNavBarSkinBasedPainterHelper.NavPaneSizeGrip: TdxSkinElement;
var
  ASkinInfo: TdxSkinInfo;
begin
  Result := nil;
  if GetSkinPainterData(ASkinInfo) then
    Result := ASkinInfo.NavPaneFormSizeGrip;
end;

  { TdxNavBarSkinBasedNavPaneGroupViewInfo }

function TdxNavBarSkinBasedNavPaneGroupViewInfo.CaptionFontColor: TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavPaneGroupButtonCaption(IsSelected);
  if (AElement = nil) or (AElement.TextColor = clDefault) then
    AElement := GetSkinHelper.NavPaneGroupButtonCaption(False);
  if AElement <> nil then
    Result := AElement.TextColor
  else
    Result := inherited CaptionFontColor;
end;

function TdxNavBarSkinBasedNavPaneGroupViewInfo.GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).FSkinBasedPainterHelper;
end;

{ TdxNavBarSkinBasedNavPaneLinkViewInfo }

function TdxNavBarSkinBasedNavPaneLinkViewInfo.FontColor: TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavPaneItem(False);
  if (AElement <> nil) and (Item.Enabled) then
    Result := AElement.TextColor
  else
    Result := inherited FontColor;
end;

function TdxNavBarSkinBasedNavPaneLinkViewInfo.SelectionRect: TRect;
begin
  Result := Rect;
  InflateRect(Result, -2, 0);
end;

function TdxNavBarSkinBasedNavPaneLinkViewInfo.GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).FSkinBasedPainterHelper;
end;

{ TdxNavBarSkinBasedOverflowPanelViewInfo }

function TdxNavBarSkinBasedOverflowPanelViewInfo.GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).FSkinBasedPainterHelper;
end;

function TdxNavBarSkinBasedOverflowPanelViewInfo.IsSkinAvailable: Boolean;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).IsSkinAvailable;
end;

function TdxNavBarSkinBasedOverflowPanelViewInfo.GetClientOffset: TRect;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavPaneOverflowPanel;
  if AElement = nil then
    Result := inherited GetClientOffset
  else
    Result := AElement.ContentOffset.Rect;
end;

function TdxNavBarSkinBasedOverflowPanelViewInfo.GetSignWidth: Integer;
var
  AElement: TdxSkinElement;
begin
  Result := inherited GetSignWidth;
  if Result <> 0 then
  begin
    AElement := GetSkinHelper.NavPaneOverflowPanelSign;
    if AElement <> nil then
      Result := AElement.Size.cx;
  end;
end;

{ TdxNavBarSkinBasedNavPaneViewInfo }

procedure TdxNavBarSkinBasedNavPaneViewInfo.AssignDefaultNavigationPaneHeaderStyle;
var
  AElement: TdxSkinIntegerProperty;
begin
  inherited;
  AElement := GetSkinHelper.NavPaneCaptionFontSize;
  if AElement <> nil then
    NavBar.DefaultStyles.NavigationPaneHeader.Font.Size := AElement.Value;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.BorderColor: TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavBarBackground;
  if AElement <> nil then
    Result := AElement.Borders.Left.Color
  else
    Result := inherited BorderColor;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.CollapseBarFontColor: TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavPaneItemPanel;
  if AElement <> nil then
    Result := AElement.TextColor
  else
    Result := inherited CollapseBarFontColor;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.HeaderFontColor: TColor;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavPaneHeader;
  if AElement <> nil then
    Result := AElement.TextColor
  else
    Result := inherited HeaderFontColor;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetHeaderHeight: Integer;
var
  AElement: TdxSkinIntegerProperty;
begin
  Result := inherited GetHeaderHeight;
  if Result <> 0 then
  begin
    AElement := GetSkinHelper.NavPaneCaptionHeight;
    if AElement <> nil then
      Result := Max(AElement.Value, Result);
  end;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetSplitterHeight: Integer;
begin
  Result := inherited GetSplitterHeight;
  if IsSkinAvailable and (Result <> 0) then
    Result := 8;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).FSkinBasedPainterHelper;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.IsSkinAvailable: Boolean;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).IsSkinAvailable;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetDragDropItemTargetHeight: Integer;
var
  AElement: TdxSkinElement;
begin
  Result := 0;
  AElement := GetSkinHelper.NavBarDragDropItemTarget;
  if AElement <> nil then
    Result := AElement.Size.cy;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetGroupBorderOffsets: TRect;
begin
  Result := inherited GetGroupBorderOffsets;
  Inc(Result.Left, BorderWidth);
  Inc(Result.Right, BorderWidth);
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetGroupEdges: TPoint;
begin
  if IsSkinAvailable then
    Result := cxNullPoint
  else
    Result := inherited GetGroupEdges;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetGroupHeaderTextIndent: Integer;
begin
  if IsSkinAvailable then
    Result := 8
  else
    Result := inherited GetGroupHeaderTextIndent;
end;

function TdxNavBarSkinBasedNavPaneViewInfo.GetOverflowPanelViewInfoClass: TdxNavBarOverflowPanelViewInfoClass;
begin
  Result := TdxNavBarSkinBasedOverflowPanelViewInfo;
end;

{ TdxNavBarSkinBasedPopupControlViewInfo }

function TdxNavBarSkinBasedPopupControlViewInfo.GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := TdxNavBarSkinBasedNavPanePainter(Painter).FSkinBasedPainterHelper;
end;

function TdxNavBarSkinBasedPopupControlViewInfo.GetBorderOffsets: TRect;
var
  AElement: TdxSkinElement;
begin
  AElement := GetSkinHelper.NavPanePopupControl;
  if AElement <> nil then
    Result := AElement.ContentOffset.Rect
  else
    Result := inherited GetBorderOffsets;
end;

{ TdxNavBarSkinBasedNavPanePainter }

constructor TdxNavBarSkinBasedNavPanePainter.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create(ANavBar);
  FSkinBasedPainterHelper := CreateSkinHelper;
  FSkinBasedPainterHelper.OnChanged := ColorSchemeChanged;
end;

destructor TdxNavBarSkinBasedNavPanePainter.Destroy;
begin
  FSkinBasedPainterHelper.OnChanged := nil;
  FreeAndNil(FSkinBasedPainterHelper);
  inherited Destroy;
end;

function TdxNavBarSkinBasedNavPanePainter.CreateSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := GetSkinPainterHelperClass.Create(GetDefaultColorSchemeName);
end;

class function TdxNavBarSkinBasedNavPanePainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarSkinBasedNavPaneViewInfo;
end;

class function TdxNavBarSkinBasedNavPanePainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarSkinBasedNavPaneGroupViewInfo;
end;

class function TdxNavBarSkinBasedNavPanePainter.GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass;
begin
  Result := TdxNavBarSkinBasedNavPaneLinkViewInfo;
end;

class function TdxNavBarSkinBasedNavPanePainter.GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass;
begin
  Result := TdxNavBarSkinBasedPainterHelper;
end;

class function TdxNavBarSkinBasedNavPanePainter.GetPopupControlViewInfoClass: TdxNavBarPopupControlViewInfoClass;
begin
  Result := TdxNavBarSkinBasedPopupControlViewInfo;
end;

procedure TdxNavBarSkinBasedNavPanePainter.ColorSchemeChanged(ASender: TObject);
begin
  NavBar.InvalidateAll(doRecreate);
end;

function TdxNavBarSkinBasedNavPanePainter.GetColorSchemeHelper: IdxNavBarColorSchemes;
begin
  Supports(FSkinBasedPainterHelper, IdxNavBarColorSchemes, Result);
end;

function TdxNavBarSkinBasedNavPanePainter.GetDefaultColorSchemeName: TdxSkinName;
begin
  Result := '';
end;

function TdxNavBarSkinBasedNavPanePainter.GetColorSchemeName: TdxSkinName;
begin
  Result := FSkinBasedPainterHelper.SkinName;
end;

function TdxNavBarSkinBasedNavPanePainter.IsSkinAvailable: Boolean;
begin
  Result := FSkinBasedPainterHelper.IsSkinAvailable;
end;

procedure TdxNavBarSkinBasedNavPanePainter.SetColorSchemeName(const AValue: TdxSkinName);
begin
  FSkinBasedPainterHelper.SkinName := AValue;
end;

function TdxNavBarSkinBasedNavPanePainter.GetNavPaneElementState(const APart: TdxNavBarPart): TdxSkinElementState;
const
  AElementMap: array[TdxNavBarNavPanePartState] of TdxSkinElementState =
    (esNormal, esHot, esPressed, esChecked, esHotCheck, esDroppedDown);
begin
  Result := AElementMap[GetNavPanePartState(APart)];
end;

function TdxNavBarSkinBasedNavPanePainter.GetSplitterType: Integer;
begin
  Result := Byte(not TdxNavBarNavigationPaneControllerAccess(Controller).Collapsed);
end;

procedure TdxNavBarSkinBasedNavPanePainter.DoDrawDropTargetLinkSelection(AItemGroup: TdxNavBarGroupViewInfo; AItem1, AItem2: TdxNavBarLinkViewInfo);
var
  ARect: TRect;
  AHeight: Integer;
begin
  AHeight := TdxNavBarSkinBasedNavPaneViewInfo(ViewInfo).GetDragDropItemTargetHeight;
  if AItem1 <> nil then
    ARect := cxRectSetBottom(AItem1.Rect, AItem1.Rect.Bottom, AHeight)
  else
    ARect := cxRectSetTop(AItem2.Rect, AItem2.Rect.Top, AHeight);
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarDragDropItemTarget, Canvas, ARect) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DoDrawSplitter;
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneSplitter, Canvas, ViewInfo.SplitterRect,
    GetSplitterType) then
    inherited;
end;

function TdxNavBarSkinBasedNavPanePainter.GetGroupCaptionButtonDrawOffsets: TRect;
begin
  Result := cxNullRect;
  if FSkinBasedPainterHelper.NavPaneDoesGroupCaptionButtonRequireOffset then
    Inc(Result.Top, 1);
end;

function TdxNavBarSkinBasedNavPanePainter.GetOverflowPanelViewInfo: TdxNavBarSkinBasedOverflowPanelViewInfo;
begin
  Result := TdxNavBarSkinBasedOverflowPanelViewInfo(inherited OverflowPanelViewInfo);
end;

function TdxNavBarSkinBasedNavPanePainter.InternalDrawScrollButton(ADownButton: Boolean;
  const ARect: TRect; AState: TdxNavBarObjectStates): Boolean;
begin
  Result := DrawSkinElement(FSkinBasedPainterHelper.NavPaneScrollButtons(ADownButton), Canvas, ARect,
    0, NavBarObjectStateToSkinState(AState));
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawBottomScrollButton;
begin
  with ViewInfo do
    if not InternalDrawScrollButton(True, BottomScrollButtonRect,
      BottomScrollButtonState)
    then
      inherited DrawBottomScrollButton;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawCollapseElementBackground(const ARect: TRect; AState: TdxNavBarNavPanePartState);
const
  AElementMap: array[TdxNavBarNavPanePartState] of TdxSkinElementState =
    (esNormal, esHot, esPressed, esChecked, esHotCheck, esDroppedDown);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneItemPanel, Canvas, ARect, 0, AElementMap[AState]) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawHeaderBackground;
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneHeader, Canvas, ViewInfo.HeaderRect) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawHeaderSign;
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavePaneHeaderSign(not NavBar.OptionsBehavior.NavigationPane.Collapsed),
    Canvas, ViewInfo.HeaderSignRect, 0, GetNavPaneElementState(dxNavBarPart(nbHeaderSign))) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawGroupCaptionButton(
  AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneGroupButtonCaption(sActive in AGroupViewInfo.State),
    Canvas, cxRectInflate(AGroupViewInfo.CaptionRect, GetGroupCaptionButtonDrawOffsets), 0, NavBarObjectStateToSkinState(AGroupViewInfo.State)) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawItemSelection(
  ALinkViewInfo: TdxNavBarLinkViewInfo);
var
  AState: TdxSkinElementState;
begin
  AState := NavBarObjectStateToSkinState(ALinkViewInfo.State);
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneItem((AState = esNormal) and (sSelected in ALinkViewInfo.State)),
    Canvas, ALinkViewInfo.SelectionRect, 0, AState) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawOverflowPanelBackground;
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneOverflowPanel, Canvas, ViewInfo.OverflowPanelRect) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawOverflowPanelItems;

  function GetOverflowPanelItemElementState(AIndex: Integer): TdxSkinElementState;
  begin
    Result := GetNavPaneElementState(dxNavBarPart(nbOverflowPanelItem, AIndex));
    case Result of
      esChecked:
        Result := esNormal;
      esHotCheck:
        Result := esHot;
    end;
  end;

var
  ASkinElement: TdxSkinElement;
  AElementState: TdxSkinElementState;
  AGroup: TdxNavBarGroup;
  I: Integer;
  R: TRect;
begin
  ASkinElement := FSkinBasedPainterHelper.NavPaneOverflowPanelItem;
  if ASkinElement = nil then
    inherited DrawOverflowPanelItems
  else
    with ViewInfo do
      for I := 0 to OverflowPanelVisibleItemCount - 1 do
      begin
        R := OverflowPanelItems[I].SelectionRect;
        AGroup := OverflowPanelItems[I].Group;
        AElementState := GetOverflowPanelItemElementState(I);
        ASkinElement.Draw(Canvas.Handle, R, Byte(AGroup = NavBar.ActiveGroup),
          AElementState);
        R := ViewInfo.OverflowPanelItems[I].Rect;
        with ImagePainterClass do
          if IsValidImage(OverflowPanelViewInfo.GetImageList, OverflowPanelViewInfo.GetImageIndex(AGroup)) then
            DrawImage(Canvas, OverflowPanelViewInfo.GetImageList, OverflowPanelViewInfo.GetImageIndex(AGroup), R)
          else
            if NavBar.NavigationPaneOverflowPanelUseSmallImages then
              Canvas.Draw(R.Left, R.Top, dxOffice11NavPaneDefaultSmallBitmap)
            else
              Canvas.Draw(R.Left, R.Top, dxOffice11NavPaneDefaultLargeBitmap);
      end;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawOverflowPanelSign;
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneOverflowPanelSign, Canvas, ViewInfo.OverflowPanelSignRect,
    0, GetNavPaneElementState(dxNavBarPart(nbOverflowPanelSign))) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawPopupControl(ACanvas: TcxCanvas; AViewInfo: TdxNavBarPopupControlViewInfo);
var
  AElement: TdxSkinElement;
begin
  AElement := FSkinBasedPainterHelper.NavPanePopupControl;
  if AElement = nil then
    inherited DrawPopupControl(ACanvas, AViewInfo)
  else
  begin
    ACanvas.SaveClipRegion;
    try
      ACanvas.ExcludeClipRect(AViewInfo.ClientRect);
      AElement.Draw(ACanvas.Handle, AViewInfo.Rect);
    finally
      ACanvas.RestoreClipRegion;
    end;
  end;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawPopupMenuItem(ACanvas: TCanvas; ARect: TRect;
  AImageList: TCustomImageList; AImageIndex: Integer; AText: String;
  State: TdxNavBarObjectStates);
var
  ABuf: TcxBitmap;
  APopupMenu: TdxSkinElement;
  ASelected: TdxSkinElement;
  ASeparator: TdxSkinElement;
  ASideStrip: TdxSkinElement;
  AImageAreaWidth: Integer;
  R: TRect;

  function InitializeElements: Boolean;
  begin
    APopupMenu := FSkinBasedPainterHelper.NavPanePopupMenu;
    ASelected := FSkinBasedPainterHelper.NavPanePopupMenuSelection;
    ASeparator := FSkinBasedPainterHelper.NavPanePopupMenuSeparator;
    ASideStrip := FSkinBasedPainterHelper.NavPanePopupMenuSideStrip;
    Result := (APopupMenu <> nil) and (ASelected <> nil) and (ASeparator <> nil) and
      (ASideStrip <> nil);
  end;

  procedure DrawImage(ACanvas: TCanvas; AIsActive: Boolean; AImageAreaWidth: Integer);
  var
    R: TRect;
  begin
    R := ARect;
    OffsetRect(R, -R.Left, -R.Top);
    R.Right := R.Left + AImageAreaWidth;

    if AIsActive then
      ASelected.Draw(ACanvas.Handle, R);

    with TdxNavBarSkinBasedNavPaneViewInfo(ViewInfo) do
      InflateRect(R, -OverflowPanelViewInfo.GetPopupMenuImageIndent,
        -OverflowPanelViewInfo.GetPopupMenuImageIndent);
    AImageList.Draw(ACanvas, R.Left, R.Top, AImageIndex, not (sDisabled in State));
  end;

  procedure DrawItemText(ACanvas: TCanvas; AImageAreaWidth: Integer);
  var
    R: TRect;
  begin
    R := ARect;
    OffsetRect(R, -R.Left, -R.Top);

    with TdxNavBarSkinBasedNavPaneViewInfo(ViewInfo) do
      R.Left := AImageAreaWidth + OverflowPanelViewInfo.GetPopupMenuTextIndent;

    if sDisabled in State then
      ACanvas.Font.Color := clGrayText
    else
      ACanvas.Font.Color := clMenuText;

    cxDrawText(ACanvas, AText, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  end;

  procedure DrawMenuBackground(ACanvas: TCanvas; AImageAreaWidth: Integer);
  var
    R: TRect;
  begin
    R := ARect;
    OffsetRect(R, -R.Left, -R.Top);
    with APopupMenu.Borders do
    begin
      Dec(R.Left, Left.Thin);
      Dec(R.Top, Top.Thin);
      Inc(R.Right, Right.Thin);
      Inc(R.Bottom, Bottom.Thin);
    end;
    APopupMenu.Draw(ABuf.Canvas.Handle, R);

    R := ARect;
    OffsetRect(R, -R.Left, -R.Top);
    R.Right := R.Left + AImageAreaWidth + 2;
    ASideStrip.Draw(ABuf.Canvas.Handle, R);
  end;

begin
  if not InitializeElements then
    inherited DrawPopupMenuItem(ACanvas, ARect, AImageList, AImageIndex, AText, State)
  else
  begin
    with TdxNavBarSkinBasedNavPaneViewInfo(ViewInfo) do
      AImageAreaWidth := 2 * OverflowPanelViewInfo.GetPopupMenuImageIndent + GetSmallImageWidth;

    ABuf := TcxBitmap.CreateSize(ARect, pf32bit);
    try
      ABuf.Canvas.Font := ACanvas.Font;
      DrawMenuBackground(ABuf.Canvas, AImageAreaWidth);
      if AText = '-' then
        ASeparator.Draw(ABuf.Canvas.Handle, Rect(AImageAreaWidth + 4,
          cxRectHeight(ARect) div 2, ABuf.Width, cxRectHeight(ARect) div 2 + 1))
      else
      begin
        if sSelected in State then
        begin
          R := ARect;
          OffsetRect(R, -R.Left, -R.Top);
          ASelected.Draw(ABuf.Canvas.Handle, R);
        end;
        DrawImage(ABuf.Canvas, sActive in State, AImageAreaWidth);
        DrawItemText(ABuf.Canvas, AImageAreaWidth);
      end;
      cxBitBlt(ACanvas.Handle, ABuf.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
    finally
      ABuf.Free;
    end;
  end; 
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawSeparator(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarSeparator, Canvas, ALinkViewInfo.Rect) then
    inherited;
end;

procedure TdxNavBarSkinBasedNavPanePainter.DrawTopScrollButton;
begin
  with ViewInfo do
    if not InternalDrawScrollButton(False, TopScrollButtonRect,
      TopScrollButtonState)
    then
      inherited DrawTopScrollButton;
end;

{ TdxNavBarSkinBasedExplorerBarViewInfo }

function TdxNavBarSkinBasedExplorerBarViewInfo.GetSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := TdxNavBarSkinBasedExplorerBarPainter(Painter).FSkinBasedPainterHelper;
end;

function TdxNavBarSkinBasedExplorerBarViewInfo.GetDragDropItemTargetHeight: Integer;
var
  AElement: TdxSkinElement;
begin
  Result := 0;
  AElement := GetSkinHelper.NavBarDragDropItemTarget;
  if AElement <> nil then
    Result := AElement.Size.cy;
end;

function TdxNavBarSkinBasedExplorerBarViewInfo.GetGroupBorderOffsets: TRect;
begin
  Result := GetSkinElementOffsets(GetSkinHelper.NavBarGroupClient);
end;

{ TdxNavBarSkinBasedExplorerBarPainter }

constructor TdxNavBarSkinBasedExplorerBarPainter.Create(ANavBar: TdxCustomNavBar);
begin
  inherited Create(ANavBar);
  FSkinBasedPainterHelper := CreateSkinHelper;
  FSkinBasedPainterHelper.OnChanged := ColorSchemeChanged;
end;

destructor TdxNavBarSkinBasedExplorerBarPainter.Destroy;
begin
  FSkinBasedPainterHelper.OnChanged := nil;
  FreeAndNil(FSkinBasedPainterHelper);
  inherited Destroy;
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.DrawGroupBorder(AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarGroupClient, Canvas, AGroupViewInfo.ItemsRect) then
    inherited;  
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.DrawGroupCaptionButton(
  AGroupViewInfo: TdxNavBarGroupViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarGroupButtonCaption, Canvas, AGroupViewInfo.CaptionRect,
    0, NavBarObjectStateToSkinState(AGroupViewInfo.State), IsGroupCaptionButtonCompositeDraw(AGroupViewInfo)) then
    inherited;
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.DrawGroupCaptionSign(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  AElement: TdxSkinElement;
begin
  AElement := FSkinBasedPainterHelper.NavBarGroupSigns(sExpanded in AGroupViewInfo.State);
  if AElement = nil then
    inherited DrawGroupCaptionSign(AGroupViewInfo)
  else
    if AGroupViewInfo.Group.ShowExpandButton then
      AElement.Draw(Canvas.Handle, AGroupViewInfo.CaptionSignRect, 0,
        NavBarObjectStateToSkinState(AGroupViewInfo.State));
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.DrawGroupControlSplitter(AGroupViewInfo: TdxNavBarExplorerBarGroupViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavPaneSplitter, Canvas, AGroupViewInfo.SplitterRect, 0, esNormal, True) then
    inherited;
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.DrawSeparator(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarSeparator, Canvas, ALinkViewInfo.Rect) then
    inherited;
end;

function TdxNavBarSkinBasedExplorerBarPainter.CreateSkinHelper: TdxNavBarSkinBasedPainterHelper;
begin
  Result := GetSkinPainterHelperClass.Create(GetDefaultColorSchemeName);
end;

class function TdxNavBarSkinBasedExplorerBarPainter.GetViewInfoClass: TdxNavBarViewInfoClass;
begin
  Result := TdxNavBarSkinBasedExplorerBarViewInfo;
end;

class function TdxNavBarSkinBasedExplorerBarPainter.GetGroupViewInfoClass: TdxNavBarGroupViewInfoClass;
begin
  Result := TdxNavBarSkinBasedExplorerBarGroupViewInfo;
end;

class function TdxNavBarSkinBasedExplorerBarPainter.GetLinkViewInfoClass: TdxNavBarLinkViewInfoClass;
begin
  Result := TdxNavBarSkinBasedExplorerBarLinkViewInfo;
end;

class function TdxNavBarSkinBasedExplorerBarPainter.GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass;
begin
  Result := TdxNavBarSkinBasedPainterHelper;
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.ColorSchemeChanged(ASender: TObject);
begin
  NavBar.InvalidateAll(doRecreate);
end;

function TdxNavBarSkinBasedExplorerBarPainter.GetColorSchemeName: TdxSkinName;
begin
  Result := FSkinBasedPainterHelper.SkinName;
end;

function TdxNavBarSkinBasedExplorerBarPainter.GetColorSchemeHelper: IdxNavBarColorSchemes;
begin
  Supports(FSkinBasedPainterHelper, IdxNavBarColorSchemes, Result);
end;

function TdxNavBarSkinBasedExplorerBarPainter.GetDefaultColorSchemeName: TdxSkinName;
begin
  Result := '';
end;

function TdxNavBarSkinBasedExplorerBarPainter.IsSkinAvailable: Boolean;
begin
  Result := FSkinBasedPainterHelper.IsSkinAvailable;
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.SetColorSchemeName(const AValue: TdxSkinName);
begin
  FSkinBasedPainterHelper.SkinName := AValue;
end;

procedure TdxNavBarSkinBasedExplorerBarPainter.DoDrawDropTargetLinkSelection(
  AItemGroup: TdxNavBarGroupViewInfo; AItem1, AItem2: TdxNavBarLinkViewInfo);
var
  ARect: TRect;
  AHeight: Integer;
begin
  AHeight := TdxNavBarSkinBasedExplorerBarViewInfo(ViewInfo).GetDragDropItemTargetHeight;
  if AItem1 <> nil then
    ARect := cxRectSetBottom(AItem1.Rect, AItem1.Rect.Bottom, AHeight)
  else
    ARect := cxRectSetTop(AItem2.Rect, AItem2.Rect.Top, AHeight);
  if not DrawSkinElement(FSkinBasedPainterHelper.NavBarDragDropItemTarget, Canvas, ARect) then
    inherited;
end;

function TdxNavBarSkinBasedExplorerBarPainter.IsGroupCaptionButtonCompositeDraw(
  AGroupViewInfo: TdxNavBarGroupViewInfo): Boolean;
begin
  Result := False;
end;

{ TdxNavBarSkinBasedExplorerBarGroupViewInfo }

function TdxNavBarSkinBasedExplorerBarGroupViewInfo.CaptionFontColor: TColor;
var
  AElement: TdxSkinElement;
begin
  with TdxNavBarSkinBasedExplorerBarPainter(Painter) do
  begin
    AElement := FSkinBasedPainterHelper.NavBarGroupButtonCaption;
    if AElement <> nil then
      Result := AElement.TextColor
    else
      Result := inherited CaptionFontColor;
  end;
end;

procedure TdxNavBarSkinBasedExplorerBarGroupViewInfo.CalculateBounds(var X, Y: Integer);
var
  AElement: TdxSkinElement;
begin
  inherited CalculateBounds(X, Y);
  with TdxNavBarSkinBasedExplorerBarPainter(Painter) do
  begin
    AElement := FSkinBasedPainterHelper.NavBarGroupButtonCaption;
    if (AElement <> nil) and IsCaptionVisible and not IsRectEmpty(FImageRect) then
    begin
      OffsetRect(FImageRect, AElement.ContentOffset.Left, 0);
      Inc(FCaptionTextRect.Left, AElement.ContentOffset.Left);
    end;
  end;
end;

{ TdxNavBarSkinBasedExplorerBarLinkViewInfo }

function TdxNavBarSkinBasedExplorerBarLinkViewInfo.FontColor: TColor;
var
  AElement: TdxSkinElement;
begin
  with TdxNavBarSkinBasedExplorerBarPainter(Painter) do
  begin
    AElement := FSkinBasedPainterHelper.NavBarItem;
    if (AElement <> nil) and (Item.Enabled) then
      Result := AElement.TextColor
    else
      Result := inherited FontColor;
  end;
end;

end.
 
