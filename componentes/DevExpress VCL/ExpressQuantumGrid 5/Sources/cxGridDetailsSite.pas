{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxGridDetailsSite;

{$I cxVer.inc}

interface

uses
  Windows,
  Classes, Graphics, Controls,
  cxClasses, cxGraphics, cxControls, cxLookAndFeelPainters,
  cxGridCommon, cxGridLevel, cxGridCustomView, cxGridCustomTableView;

const
  htTab = 50;

  cxGridTabsRootSize: Integer = 1 + 3;

type
  TcxCustomGridDetailsSiteTabViewInfo = class;
  TcxCustomGridDetailsSiteTabsViewInfo = class;
  TcxCustomGridDetailsSiteViewInfo = class;

  { hit tests }

  TcxGridDetailsSiteTabHitTestClass = class of TcxGridDetailsSiteTabHitTest;

  TcxGridDetailsSiteTabHitTest = class(TcxCustomGridHitTest)
  private
    FLevel: TcxGridLevel;
    FOwner: TObject;
  protected
    class function GetHitTestCode: Integer; override;
  public
    property Level: TcxGridLevel read FLevel write FLevel;
    property Owner: TObject read FOwner write FOwner;
  end;

  { painters }

  TcxGridDetailsSiteTabPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridDetailsSiteTabViewInfo;
  protected
    procedure DrawBorder(ABorder: TcxBorder); override;
    procedure DrawContent; override;
    property ViewInfo: TcxCustomGridDetailsSiteTabViewInfo read GetViewInfo;
  end;

  TcxGridDetailsSiteTabsPainterClass = class of TcxGridDetailsSiteTabsPainter;

  TcxGridDetailsSiteTabsPainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TcxCustomGridDetailsSiteTabsViewInfo;
  protected
    procedure DrawBackground; virtual;
    procedure DrawItems; virtual;
    procedure DrawRoot; virtual;
    procedure Paint; virtual;
    property Canvas: TcxCanvas read FCanvas;
    property ViewInfo: TcxCustomGridDetailsSiteTabsViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridDetailsSiteTabsViewInfo); virtual;
    procedure MainPaint;
  end;

  TcxGridDetailsSitePainterClass = class of TcxGridDetailsSitePainter;

  TcxGridDetailsSitePainter = class
  private
    FCanvas: TcxCanvas;
    FViewInfo: TcxCustomGridDetailsSiteViewInfo;
  protected
    procedure DrawBackground; virtual;
    procedure DrawFrame; virtual;
    procedure DrawTabs; virtual;
    property Canvas: TcxCanvas read FCanvas;
    property ViewInfo: TcxCustomGridDetailsSiteViewInfo read FViewInfo;
  public
    constructor Create(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridDetailsSiteViewInfo); virtual;
    procedure Paint; virtual;
  end;

  { view infos }

  // custom tabs

  TcxCustomGridDetailsSiteTabViewInfoClass = class of TcxCustomGridDetailsSiteTabViewInfo;

  TcxCustomGridDetailsSiteTabViewInfo = class(TcxCustomGridCellViewInfo)
  private
    FIndex: Integer;
    FLevel: TcxGridLevel;
    FTabsViewInfo: TcxCustomGridDetailsSiteTabsViewInfo;
    function GetActive: Boolean;
    function GetCaption: string;
    function GetGrid: TcxControl;
    function GetIsVertical: Boolean;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetSiteViewInfo: TcxCustomGridDetailsSiteViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetCanvas: TcxCanvas; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetIsDesignSelected: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetStateForPaint: TcxGridCellState; virtual;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    function GetTextAttributes(AForPainting: Boolean): Integer; override;
    function GetTextForPainting: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasFirstBorder: Boolean;
    function HasLastBorder: Boolean;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    property Grid: TcxControl read GetGrid;
    property Index: Integer read FIndex;
    property IsVertical: Boolean read GetIsVertical;
    property Level: TcxGridLevel read FLevel;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property SiteViewInfo: TcxCustomGridDetailsSiteViewInfo read GetSiteViewInfo;
    property TabsViewInfo: TcxCustomGridDetailsSiteTabsViewInfo read FTabsViewInfo;
  public
    constructor Create(ATabsViewInfo: TcxCustomGridDetailsSiteTabsViewInfo;
      ALevel: TcxGridLevel); virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function ProcessDialogChar(ACharCode: Word): Boolean; virtual;
    property Active: Boolean read GetActive;
    property Caption: string read GetCaption;
    property StateForPaint: TcxGridCellState read GetStateForPaint;
  end;

  TcxCustomGridDetailsSiteTabsViewInfoClass = class of TcxCustomGridDetailsSiteTabsViewInfo;

  TcxCustomGridDetailsSiteTabsViewInfo = class
  private
    FHeight: Integer;
    FItems: TList;
    FSiteViewInfo: TcxCustomGridDetailsSiteViewInfo;
    FWidth: Integer;
    function GetActiveLevel: TcxGridLevel;
    function GetCanvas: TcxCanvas;
    function GetCount: Integer;
    function GetHeight: Integer;
    function GetItem(Index: Integer): TcxCustomGridDetailsSiteTabViewInfo;
    function GetLevel: TcxGridLevel;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetMainSize: Integer;
    function GetTabSize: Integer;
    function GetWidth: Integer;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    function CalculateHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;
    procedure CheckSiteViewInfoHeight(var AHeight: Integer); virtual;
    procedure CheckSiteViewInfoWidth(var AWidth: Integer); virtual;
    function GetActiveTabOffset: Integer; virtual; abstract;
    function GetBkColor: TColor; virtual;
    function GetIsVertical: Boolean; virtual; abstract;
    function GetItemClass: TcxCustomGridDetailsSiteTabViewInfoClass; virtual; abstract;
    function GetItemHeight(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer; virtual;
    function GetItemWidth(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer; virtual;
    function GetPainterClass: TcxGridDetailsSiteTabsPainterClass; virtual;
    function GetRootBorders: TcxBorders; virtual; abstract;
    function GetRootBounds: TRect; virtual; abstract;

    property ActiveTabOffset: Integer read GetActiveTabOffset;
    property Canvas: TcxCanvas read GetCanvas;
    property IsVertical: Boolean read GetIsVertical;
    property Level: TcxGridLevel read GetLevel;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property MainSize: Integer read GetMainSize;
    property SiteViewInfo: TcxCustomGridDetailsSiteViewInfo read FSiteViewInfo;
    property TabSize: Integer read GetTabSize;
  public
    Bounds: TRect;
    constructor Create(ASiteViewInfo: TcxCustomGridDetailsSiteViewInfo); virtual;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); virtual;
    procedure GetClientBounds(var AClientBounds: TRect); virtual; abstract;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function ProcessDialogChar(ACharCode: Word): Boolean; virtual;

    property ActiveLevel: TcxGridLevel read GetActiveLevel;
    property BkColor: TColor read GetBkColor;
    property Count: Integer read GetCount;
    property Height: Integer read GetHeight;
    property Items[Index: Integer]: TcxCustomGridDetailsSiteTabViewInfo read GetItem;
    property RootBorders: TcxBorders read GetRootBorders;
    property RootBounds: TRect read GetRootBounds;
    property Width: Integer read GetWidth;
  end;

  // left tabs

  TcxGridDetailsSiteLeftTabsViewInfo = class;

  TcxGridDetailsSiteLeftTabViewInfo = class(TcxCustomGridDetailsSiteTabViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetBorders: TcxBorders; override;
  public
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
  end;

  TcxGridDetailsSiteLeftTabsViewInfo = class(TcxCustomGridDetailsSiteTabsViewInfo)
  protected
    procedure CheckSiteViewInfoHeight(var AHeight: Integer); override;
    function GetActiveTabOffset: Integer; override;
    function GetIsVertical: Boolean; override;
    function GetItemClass: TcxCustomGridDetailsSiteTabViewInfoClass; override;
    function GetRootBorders: TcxBorders; override;
    function GetRootBounds: TRect; override;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure GetClientBounds(var AClientBounds: TRect); override;
  end;

  // top tabs

  TcxGridDetailsSiteTopTabsViewInfo = class;

  TcxGridDetailsSiteTopTabViewInfo = class(TcxCustomGridDetailsSiteTabViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetBorders: TcxBorders; override;
  public
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
  end;

  TcxGridDetailsSiteTopTabsViewInfo = class(TcxCustomGridDetailsSiteTabsViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure CheckSiteViewInfoWidth(var AWidth: Integer); override;
    function GetActiveTabOffset: Integer; override;
    function GetIsVertical: Boolean; override;
    function GetItemClass: TcxCustomGridDetailsSiteTabViewInfoClass; override;
    function GetItemHeight(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer; override;
    function GetItemWidth(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer; override;
    function GetRootBorders: TcxBorders; override;
    function GetRootBounds: TRect; override;
  public
    procedure Calculate(const ABounds: TRect); override;
    procedure GetClientBounds(var AClientBounds: TRect); override;
  end;

  // custom details site

  TcxCustomGridDetailsSiteViewInfo = class(TcxComponent)
  private
    FActiveGridView: TcxCustomGridView;
    FFullyVisible: Boolean;
    FLevel: TcxGridLevel;
    FNormalHeight: Integer;
    FTabsViewInfo: TcxCustomGridDetailsSiteTabsViewInfo;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    function GetFrameBounds: TRect;
    function GetInternalHeight: Integer;
    function GetInternalWidth: Integer;
    function GetIsActiveGridViewDestroying: Boolean;
    function GetMaxDetailHeight: Integer;
    function GetMaxDetailSize: TPoint;
    function GetMaxDetailWidth: Integer;
    function GetNonClientHeight: Integer;
    function GetNonClientWidth: Integer;
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;

    function CalculateHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;
    function GetBkColor: TColor; virtual;
    function GetCanvas: TcxCanvas; virtual; abstract;
    function GetClientBounds: TRect; virtual;
    function GetEmptyClientHeight: Integer; virtual;
    function GetEmptyClientWidth: Integer; virtual;
    function GetFrameColor: TColor; virtual;
    function GetFrameWidth: Integer; virtual;
    function GetFullyVisible: Boolean; virtual;
    function GetHeight: Integer; virtual;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass; virtual; abstract;
    function GetMasterRecord: TcxCustomGridRecord; virtual; abstract;
    function GetMaxHeight: Integer; virtual; abstract;
    function GetMaxNormalHeight: Integer; virtual;
    function GetMaxWidth: Integer; virtual; abstract;
    function GetMinWidth: Integer; virtual;
    function GetNormalHeight: Integer; virtual;
    function GetWidth: Integer; virtual;

    function GetPainterClass: TcxGridDetailsSitePainterClass; virtual;
    function GetTabsViewInfoClass: TcxCustomGridDetailsSiteTabsViewInfoClass; virtual;

    function GetActiveGridView: TcxCustomGridView; virtual; abstract;
    function GetActiveGridViewExists: Boolean; virtual;
    function GetActiveGridViewValue: TcxCustomGridView; virtual;
    function GetActiveLevel: TcxGridLevel; virtual; abstract;
    function GetVisible: Boolean; virtual;

    procedure InitTabHitTest(AHitTest: TcxGridDetailsSiteTabHitTest); virtual; abstract;

    property ActiveGridView: TcxCustomGridView read GetActiveGridViewValue;
    property ActiveGridViewExists: Boolean read GetActiveGridViewExists;
    property Canvas: TcxCanvas read GetCanvas;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    property EmptyClientHeight: Integer read GetEmptyClientHeight;
    property EmptyClientWidth: Integer read GetEmptyClientWidth;
    property InternalHeight: Integer read GetInternalHeight;
    property InternalWidth: Integer read GetInternalWidth;
    property IsActiveGridViewDestroying: Boolean read GetIsActiveGridViewDestroying;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property MaxDetailHeight: Integer read GetMaxDetailHeight;
    property MaxDetailSize: TPoint read GetMaxDetailSize;
    property MaxDetailWidth: Integer read GetMaxDetailWidth;
    property MaxHeight: Integer read GetMaxHeight;
    property MaxNormalHeight: Integer read GetMaxNormalHeight;
    property MaxWidth: Integer read GetMaxWidth;
    property MinWidth: Integer read GetMinWidth;
    property NonClientHeight: Integer read GetNonClientHeight;
    property NonClientWidth: Integer read GetNonClientWidth;
  public
    Bounds: TRect;
    constructor Create(ALevel: TcxGridLevel); reintroduce; virtual;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer); virtual;
    procedure ChangeActiveTab(ALevel: TcxGridLevel; AFocusView: Boolean = False); virtual; abstract;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    procedure Paint(ACanvas: TcxCanvas);
    function ProcessDialogChar(ACharCode: Word): Boolean;
    function SupportsTabAccelerators: Boolean; virtual;
    procedure VisibilityChanged(AVisible: Boolean); virtual;

    property ActiveLevel: TcxGridLevel read GetActiveLevel;
    property BkColor: TColor read GetBkColor;
    property ClientBounds: TRect read GetClientBounds;
    property FrameBounds: TRect read GetFrameBounds;
    property FrameColor: TColor read GetFrameColor;
    property FrameWidth: Integer read GetFrameWidth;
    property FullyVisible: Boolean read GetFullyVisible;
    property Height: Integer read GetHeight;
    property Level: TcxGridLevel read FLevel;
    property MasterRecord: TcxCustomGridRecord read GetMasterRecord;
    property NormalHeight: Integer read GetNormalHeight;
    property TabsViewInfo: TcxCustomGridDetailsSiteTabsViewInfo read FTabsViewInfo;
    property Visible: Boolean read GetVisible;
    property Width: Integer read GetWidth;
  end;

implementation

uses
  SysUtils, Forms, Menus, cxGrid;

const
  ActiveLeftTabOffset = 3;
  ActiveTopTabOffset = 2;
  TabsAreaOffset = 2;
  TabTextOffset = 5;

type
  TcxControlAccess = class(TcxControl);

{ TcxGridDetailsSiteTabHitTest }

class function TcxGridDetailsSiteTabHitTest.GetHitTestCode: Integer;
begin
  Result := htTab;
end;

{ TcxGridDetailsSiteTabPainter }

function TcxGridDetailsSiteTabPainter.GetViewInfo: TcxCustomGridDetailsSiteTabViewInfo;
begin
  Result := TcxCustomGridDetailsSiteTabViewInfo(inherited ViewInfo);
end;

procedure TcxGridDetailsSiteTabPainter.DrawBorder(ABorder: TcxBorder);
begin
  with ViewInfo do
    LookAndFeelPainter.DrawTabBorder(Self.Canvas, BorderBounds[ABorder], ABorder,
      Borders, IsVertical);
end;

procedure TcxGridDetailsSiteTabPainter.DrawContent;
begin
  with ViewInfo do
    if LookAndFeelPainter.IsDrawTabImplemented(IsVertical) then
      LookAndFeelPainter.DrawTab(Self.Canvas, Bounds, Borders,
        TextForPainting, GridCellStateToButtonState(StateForPaint), IsVertical, Params.Font,
        Params.TextColor, Params.Color, cxGridTabAccelSupport and SiteViewInfo.SupportsTabAccelerators)
    else
      inherited;
end;

{ TcxGridDetailsSiteTabsPainter }

constructor TcxGridDetailsSiteTabsPainter.Create(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridDetailsSiteTabsViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

procedure TcxGridDetailsSiteTabsPainter.DrawBackground;
begin
  Canvas.Brush.Color := ViewInfo.BkColor;
  Canvas.FillRect(ViewInfo.Bounds);
end;

procedure TcxGridDetailsSiteTabsPainter.DrawItems;
var
  I: Integer;
begin
  for I := 0 to FViewInfo.Count - 1 do
    FViewInfo.Items[I].Paint;
end;

procedure TcxGridDetailsSiteTabsPainter.DrawRoot;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawTabsRoot(Self.Canvas, RootBounds, RootBorders, IsVertical);
end;

procedure TcxGridDetailsSiteTabsPainter.Paint;
begin
  DrawBackground;
  DrawRoot;
  DrawItems;
end;

procedure TcxGridDetailsSiteTabsPainter.MainPaint;
var
  AClipRegion, ARegion: TcxRegion;
begin
  AClipRegion := Canvas.GetClipRegion;
  ARegion := TcxRegion.Create(ViewInfo.Bounds);
  Canvas.SetClipRegion(ARegion, roIntersect);
  try
    Paint;
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);
  end;
end;

{ TcxGridDetailsSitePainter }

constructor TcxGridDetailsSitePainter.Create(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridDetailsSiteViewInfo);
begin
  inherited Create;
  FCanvas := ACanvas;
  FViewInfo := AViewInfo;
end;

procedure TcxGridDetailsSitePainter.DrawBackground;
begin
  Canvas.Brush.Color := ViewInfo.BkColor;
  Canvas.FillRect(ViewInfo.ClientBounds);
end;

procedure TcxGridDetailsSitePainter.DrawFrame;
begin
  with ViewInfo do
    Self.Canvas.FrameRect(FrameBounds, FrameColor, FrameWidth);
end;

procedure TcxGridDetailsSitePainter.DrawTabs;
var
  AViewInfo: TcxCustomGridDetailsSiteTabsViewInfo;
begin
  AViewInfo := ViewInfo.TabsViewInfo;
  if AViewInfo <> nil then
    with AViewInfo.GetPainterClass.Create(Canvas, AViewInfo) do
      try
        MainPaint;
      finally
        Free;
      end;
end;

procedure TcxGridDetailsSitePainter.Paint;
begin
  if ViewInfo.FrameWidth <> 0 then
    DrawFrame;
  DrawTabs;
  DrawBackground;
  Canvas.ExcludeClipRect(ViewInfo.Bounds);
end;

{ TcxCustomGridDetailsSiteTabViewInfo }

constructor TcxCustomGridDetailsSiteTabViewInfo.Create(ATabsViewInfo: TcxCustomGridDetailsSiteTabsViewInfo;
  ALevel: TcxGridLevel);
begin
  inherited Create;
  FTabsViewInfo := ATabsViewInfo;
  FLevel := ALevel;
  FIndex := FLevel.VisibleIndex;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetActive: Boolean;
begin
  Result := FTabsViewInfo.ActiveLevel = FLevel;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetCaption: string;
begin
  Result := FLevel.Caption;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetGrid: TcxControl;
begin
  Result := FLevel.Control;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetIsVertical: Boolean;
begin
  Result := FTabsViewInfo.IsVertical;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FTabsViewInfo.LookAndFeelPainter;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetSiteViewInfo: TcxCustomGridDetailsSiteViewInfo;
begin
  Result := FTabsViewInfo.SiteViewInfo;
end;

function TcxCustomGridDetailsSiteTabViewInfo.CalculateHeight: Integer;
begin
  Result := TextHeightWithOffset;
end;

function TcxCustomGridDetailsSiteTabViewInfo.CalculateWidth: Integer;
begin
  Result := 2 * TabTextOffset + TextWidthWithOffset;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.TabBorderSize(IsVertical);
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FTabsViewInfo.Canvas;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridDetailsSiteTabHitTest;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetHotTrack: Boolean;
begin
  Result := LookAndFeelPainter.IsTabHotTrack(IsVertical);
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := Grid.IsDesigning and
    TcxCustomGrid(Grid).StructureNavigator.IsObjectSelected(FLevel);
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridDetailsSiteTabPainter;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetStateForPaint: TcxGridCellState;
begin
  if Active then
    Result := gcsPressed
  else
    Result := State;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetText: string;
begin
  Result := Caption;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  InflateRect(Result, -TabTextOffset, 0);
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetTextAttributes(AForPainting: Boolean): Integer;
begin
  Result := inherited GetTextAttributes(AForPainting);
  if cxGridTabAccelSupport and SiteViewInfo.SupportsTabAccelerators then
    Result := Result or cxShowPrefix;
end;

function TcxCustomGridDetailsSiteTabViewInfo.GetTextForPainting: string;
begin
  if cxGridTabAccelSupport and not SiteViewInfo.SupportsTabAccelerators then
    Result := FLevel.DisplayCaption
  else
    Result := inherited GetTextForPainting;
end;

procedure TcxCustomGridDetailsSiteTabViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FTabsViewInfo.Level.Styles.GetTabParams(SiteViewInfo.MasterRecord, Level, AParams);
end;

function TcxCustomGridDetailsSiteTabViewInfo.HasFirstBorder: Boolean;
begin
  Result := (Index = 0) or not TabsViewInfo.Items[Index - 1].Active;
end;

function TcxCustomGridDetailsSiteTabViewInfo.HasLastBorder: Boolean;
begin
  Result := (Index = TabsViewInfo.Count - 1) or not TabsViewInfo.Items[Index + 1].Active;
end;

procedure TcxCustomGridDetailsSiteTabViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridDetailsSiteTabHitTest(AHitTest).Level := FLevel;
  SiteViewInfo.InitTabHitTest(TcxGridDetailsSiteTabHitTest(AHitTest));
end;

function TcxCustomGridDetailsSiteTabViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and not (ssDouble in AShift) and Grid.IsDesigning then
    TcxCustomGrid(Grid).StructureNavigator.SelectObject(FLevel, not (ssShift in AShift));
  SiteViewInfo.ChangeActiveTab(FLevel, False);
  Result := True;
end;

function TcxCustomGridDetailsSiteTabViewInfo.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result := cxGridTabAccelSupport and SiteViewInfo.SupportsTabAccelerators and
    IsAccel(ACharCode, Caption);
  if Result then
    SiteViewInfo.ChangeActiveTab(FLevel, True);
end;

{ TcxCustomGridDetailsSiteTabsViewInfo }

constructor TcxCustomGridDetailsSiteTabsViewInfo.Create(ASiteViewInfo: TcxCustomGridDetailsSiteViewInfo);
begin
  inherited Create;
  FSiteViewInfo := ASiteViewInfo;
  CreateItems;
end;

destructor TcxCustomGridDetailsSiteTabsViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetActiveLevel: TcxGridLevel;
begin
  Result := FSiteViewInfo.ActiveLevel;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FSiteViewInfo.Canvas;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetHeight: Integer;
begin
  if FHeight = 0 then
    FHeight := CalculateHeight;
  Result := FHeight;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetItem(Index: Integer): TcxCustomGridDetailsSiteTabViewInfo;
begin
  Result := TcxCustomGridDetailsSiteTabViewInfo(FItems[Index]);
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetLevel: TcxGridLevel;
begin
  Result := FSiteViewInfo.Level;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FSiteViewInfo.LookAndFeelPainter;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetMainSize: Integer;
begin
  if IsVertical then
    Result := Width
  else
    Result := Height;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetTabSize: Integer;
begin
  Result := MainSize - TabsAreaOffset - (cxGridTabsRootSize - 1);
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetWidth: Integer;
begin
  if FWidth = 0 then
    FWidth := CalculateWidth;
  Result := FWidth;
end;

procedure TcxCustomGridDetailsSiteTabsViewInfo.CreateItems;
var
  I: Integer;
begin
  FItems := TList.Create;
  for I := 0 to Level.VisibleCount - 1 do
    FItems.Add(GetItemClass.Create(Self, Level.VisibleItems[I]));
end;

procedure TcxCustomGridDetailsSiteTabsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Free;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.CalculateHeight: Integer;
var
  I: Integer;
begin
  Result := 2 * TabsAreaOffset;
  for I := 0 to Count - 1 do
    Inc(Result, GetItemHeight(Items[I]));
end;

function TcxCustomGridDetailsSiteTabsViewInfo.CalculateWidth: Integer;
var
  I, AItemWidth: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
  begin
    AItemWidth := GetItemWidth(Items[I]);
    if AItemWidth > Result then Result := AItemWidth;
  end;
  if Count > 1 then Inc(Result, ActiveTabOffset);
  Inc(Result, TabsAreaOffset + cxGridTabsRootSize - 1);
end;

procedure TcxCustomGridDetailsSiteTabsViewInfo.CheckSiteViewInfoHeight(var AHeight: Integer);
begin
end;

procedure TcxCustomGridDetailsSiteTabsViewInfo.CheckSiteViewInfoWidth(var AWidth: Integer);
begin
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetBkColor: TColor;
var
  AParams: TcxViewParams;
begin
  Level.Styles.GetViewParams(lsTabsBackground, nil, nil, AParams);
  Result := AParams.Color;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetItemHeight(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer;
begin
  Result := AItem.CalculateHeight;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetItemWidth(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer;
begin
  Result := AItem.CalculateWidth;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetPainterClass: TcxGridDetailsSiteTabsPainterClass;
begin
  Result := TcxGridDetailsSiteTabsPainter;
end;

procedure TcxCustomGridDetailsSiteTabsViewInfo.Calculate(const ABounds: TRect);
var
  ATabLeft, ATabTop, ATabSize, I: Integer;

  procedure CalculateFirstTabPos;
  begin
    ATabLeft := Bounds.Left + TabsAreaOffset;
    ATabTop := Bounds.Top + TabsAreaOffset;
    if (Count <> 0) and Items[0].Active then
      if IsVertical then
        Dec(ATabTop, Items[0].BorderWidth[bTop])
      else
        Dec(ATabLeft, Items[0].BorderWidth[bLeft]);
  end;

  function GetTabWidth: Integer;
  begin
    if IsVertical then
      Result := ATabSize
    else
      Result := -1;
  end;

  function GetTabHeight: Integer;
  begin
    if IsVertical then
      Result := -1
    else
      Result := ATabSize;
  end;

  procedure CalculateNextTabPos;
  begin
    if IsVertical then
      Inc(ATabTop, Items[I].Height)
    else
      Inc(ATabLeft, Items[I].Width);
  end;

begin
  Bounds := ABounds;
  CalculateFirstTabPos;
  ATabSize := TabSize;
  for I := 0 to Count - 1 do
  begin
    Items[I].Calculate(ATabLeft, ATabTop, GetTabWidth, GetTabHeight);
    CalculateNextTabPos;
  end;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Break;
  end;
end;

function TcxCustomGridDetailsSiteTabsViewInfo.ProcessDialogChar(ACharCode: Word): Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].Visible and Items[I].ProcessDialogChar(ACharCode);
    if Result then Exit;
  end;
  Result := False;
end;

{ TcxGridDetailsSiteLeftTabViewInfo }

function TcxGridDetailsSiteLeftTabViewInfo.CalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
  if Active then Inc(Result, BorderWidth[bTop] + BorderWidth[bBottom]);
  Inc(Result, BorderSize[bTop] + BorderSize[bBottom]);
end;

function TcxGridDetailsSiteLeftTabViewInfo.CalculateWidth: Integer;
begin
  Result := inherited CalculateWidth;
  Inc(Result, BorderWidth[bLeft] + BorderWidth[bRight]);
end;

function TcxGridDetailsSiteLeftTabViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridDetailsSiteLeftTabViewInfo.GetBorders: TcxBorders;
begin
  Result := [bLeft];
  if Active then
    Result := Result + [bTop, bBottom]
  else
  begin
    Include(Result, bRight);
    if HasFirstBorder then Include(Result, bTop);
    if HasLastBorder then Include(Result, bBottom);
  end;
end;

procedure TcxGridDetailsSiteLeftTabViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  if not Active then
  begin
    Inc(ALeftBound, TabsViewInfo.ActiveTabOffset);
    if AWidth <> -1 then Dec(AWidth, TabsViewInfo.ActiveTabOffset);
  end;
  inherited;
end;

{ TcxGridDetailsSiteLeftTabsViewInfo }

procedure TcxGridDetailsSiteLeftTabsViewInfo.CheckSiteViewInfoHeight(var AHeight: Integer);
begin
  inherited;
  if AHeight < Height then AHeight := Height;
end;

function TcxGridDetailsSiteLeftTabsViewInfo.GetActiveTabOffset: Integer;
begin
  Result := ActiveLeftTabOffset;
end;

function TcxGridDetailsSiteLeftTabsViewInfo.GetIsVertical: Boolean;
begin
  Result := True;
end;

function TcxGridDetailsSiteLeftTabsViewInfo.GetItemClass: TcxCustomGridDetailsSiteTabViewInfoClass;
begin
  Result := TcxGridDetailsSiteLeftTabViewInfo;
end;

function TcxGridDetailsSiteLeftTabsViewInfo.GetRootBorders: TcxBorders;
begin
  Result := [bLeft, bTop, bBottom];
end;

function TcxGridDetailsSiteLeftTabsViewInfo.GetRootBounds: TRect;
begin
  Result := Bounds;
  Result.Left := Result.Right - cxGridTabsRootSize;
end;

procedure TcxGridDetailsSiteLeftTabsViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  Bounds.Right := Bounds.Left + Width;
end;

procedure TcxGridDetailsSiteLeftTabsViewInfo.GetClientBounds(var AClientBounds: TRect);
begin
  Inc(AClientBounds.Left, Width);
end;

{ TcxGridDetailsSiteTopTabViewInfo }

function TcxGridDetailsSiteTopTabViewInfo.CalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
  Inc(Result, BorderWidth[bTop] + BorderWidth[bBottom]);
end;

function TcxGridDetailsSiteTopTabViewInfo.CalculateWidth: Integer;
begin
  Result := inherited CalculateWidth;
  if Active then Inc(Result, BorderWidth[bLeft] + BorderWidth[bRight]);
  Inc(Result, BorderSize[bLeft] + BorderSize[bRight]);
end;

function TcxGridDetailsSiteTopTabViewInfo.GetBorders: TcxBorders;
begin               
  Result := [bTop];
  if Active then
    Result := Result + [bLeft, bRight]
  else
  begin
    Include(Result, bBottom);
    if HasFirstBorder then Include(Result, bLeft);
    if HasLastBorder then Include(Result, bRight);
  end;
end;

procedure TcxGridDetailsSiteTopTabViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  if not Active then
  begin
    Inc(ATopBound, TabsViewInfo.ActiveTabOffset);
    if AHeight <> -1 then Dec(AHeight, TabsViewInfo.ActiveTabOffset);
  end;
  inherited;
end;

{ TcxGridDetailsSiteTopTabsViewInfo }

function TcxGridDetailsSiteTopTabsViewInfo.CalculateHeight: Integer;
begin
  Result := inherited CalculateWidth;
end;

function TcxGridDetailsSiteTopTabsViewInfo.CalculateWidth: Integer;
begin
  Result := inherited CalculateHeight;
end;

procedure TcxGridDetailsSiteTopTabsViewInfo.CheckSiteViewInfoWidth(var AWidth: Integer);
begin
  inherited;
  if AWidth < Width then AWidth := Width;
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetActiveTabOffset: Integer;
begin
  Result := ActiveTopTabOffset;
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetIsVertical: Boolean;
begin
  Result := False;
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetItemClass: TcxCustomGridDetailsSiteTabViewInfoClass;
begin
  Result := TcxGridDetailsSiteTopTabViewInfo;
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetItemHeight(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer;
begin
  Result := inherited GetItemWidth(AItem);
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetItemWidth(AItem: TcxCustomGridDetailsSiteTabViewInfo): Integer;
begin
  Result := inherited GetItemHeight(AItem);
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetRootBorders: TcxBorders;
begin
  Result := [bLeft, bTop, bRight];
end;

function TcxGridDetailsSiteTopTabsViewInfo.GetRootBounds: TRect;
begin
  Result := Bounds;
  Result.Top := Result.Bottom - cxGridTabsRootSize;
end;

procedure TcxGridDetailsSiteTopTabsViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  Bounds.Bottom := Bounds.Top + Height;
end;

procedure TcxGridDetailsSiteTopTabsViewInfo.GetClientBounds(var AClientBounds: TRect);
begin
  Inc(AClientBounds.Top, Height);
end;

{ TcxCustomGridDetailsSiteViewInfo }

constructor TcxCustomGridDetailsSiteViewInfo.Create(ALevel: TcxGridLevel);
begin
  inherited Create(nil);
  FLevel := ALevel;
  if GetTabsViewInfoClass <> nil then
    FTabsViewInfo := GetTabsViewInfoClass.Create(Self);
end;

destructor TcxCustomGridDetailsSiteViewInfo.Destroy;
begin
  VisibilityChanged(False);
  FTabsViewInfo.Free;
  inherited;
end;

function TcxCustomGridDetailsSiteViewInfo.GetClientHeight: Integer;
begin
  with ClientBounds do
    Result := Bottom - Top;
end;

function TcxCustomGridDetailsSiteViewInfo.GetClientWidth: Integer;
begin
  with ClientBounds do
    Result := Right - Left;
end;

function TcxCustomGridDetailsSiteViewInfo.GetFrameBounds: TRect;
begin
  Result := ClientBounds;
  InflateRect(Result, FrameWidth, FrameWidth);
end;

function TcxCustomGridDetailsSiteViewInfo.GetInternalHeight: Integer;
begin
  with Bounds do
    Result := Bottom - Top;
end;

function TcxCustomGridDetailsSiteViewInfo.GetInternalWidth: Integer;
begin
  with Bounds do
    Result := Right - Left;
end;

function TcxCustomGridDetailsSiteViewInfo.GetIsActiveGridViewDestroying: Boolean;
begin
  Result := (FActiveGridView <> nil) and FActiveGridView.IsDestroying;
end;

function TcxCustomGridDetailsSiteViewInfo.GetMaxDetailHeight: Integer;
begin
  Result := MaxHeight - NonClientHeight;
end;

function TcxCustomGridDetailsSiteViewInfo.GetMaxDetailSize: TPoint;
begin
  Result := Point(MaxDetailWidth, MaxDetailHeight);
end;

function TcxCustomGridDetailsSiteViewInfo.GetMaxDetailWidth: Integer;
begin
  Result := MaxWidth - NonClientWidth;
end;

function TcxCustomGridDetailsSiteViewInfo.GetNonClientHeight: Integer;
begin
  Result := InternalHeight - ClientHeight;
end;

function TcxCustomGridDetailsSiteViewInfo.GetNonClientWidth: Integer;
begin
  Result := InternalWidth - ClientWidth;
end;

procedure TcxCustomGridDetailsSiteViewInfo.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = FActiveGridView) then
    FActiveGridView := nil;
end;

function TcxCustomGridDetailsSiteViewInfo.CalculateHeight: Integer;
begin
  if ActiveGridView = nil then
  begin
    FFullyVisible := True;
    Result := EmptyClientHeight;
  end
  else
  begin
    Result := 0;
    FFullyVisible := False;
    ActiveGridView.ViewInfo.GetHeight(MaxDetailSize, Result, FFullyVisible);
  end;
  Inc(Result, NonClientHeight);
  if FTabsViewInfo <> nil then
    FTabsViewInfo.CheckSiteViewInfoHeight(Result);
  FNormalHeight := Result;
  if FNormalHeight > MaxNormalHeight then FNormalHeight := MaxNormalHeight;
  if not FullyVisible then
    Result := MaxHeight
  else
  begin
    if Result > MaxHeight then Result := MaxHeight;
    if Result < 0 then Result := 0;
  end;
  if FNormalHeight < Result then FNormalHeight := Result;
end;

function TcxCustomGridDetailsSiteViewInfo.CalculateWidth: Integer;
begin
  if ActiveGridView = nil then
    Result := EmptyClientWidth
  else
    ActiveGridView.ViewInfo.GetWidth(MaxDetailSize, Result);
  Inc(Result, NonClientWidth);
  if FTabsViewInfo <> nil then
    FTabsViewInfo.CheckSiteViewInfoWidth(Result);
  if Result < MinWidth then Result := MinWidth;  
  if Result > MaxWidth then Result := MaxWidth;
end;

function TcxCustomGridDetailsSiteViewInfo.GetBkColor: TColor;
begin
  Result := TcxControlAccess(FLevel.Control).Color;
end;

function TcxCustomGridDetailsSiteViewInfo.GetClientBounds: TRect;
begin
  Result := Bounds;
  if FTabsViewInfo <> nil then
    FTabsViewInfo.GetClientBounds(Result);
  InflateRect(Result, -FrameWidth, -FrameWidth);
end;

function TcxCustomGridDetailsSiteViewInfo.GetEmptyClientHeight: Integer;
begin
  Result := 100;
end;

function TcxCustomGridDetailsSiteViewInfo.GetEmptyClientWidth: Integer;
begin
  Result := 200;
end;

function TcxCustomGridDetailsSiteViewInfo.GetFrameColor: TColor;
begin
  Result := FLevel.Options.GetDetailFrameColor;
end;

function TcxCustomGridDetailsSiteViewInfo.GetFrameWidth: Integer;
begin
  Result := Level.Options.DetailFrameWidth;
end;

function TcxCustomGridDetailsSiteViewInfo.GetFullyVisible: Boolean;
begin
  Result := FFullyVisible;
end;

function TcxCustomGridDetailsSiteViewInfo.GetHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TcxCustomGridDetailsSiteViewInfo.GetMaxNormalHeight: Integer;
begin
  Result := MaxInt;
end;

function TcxCustomGridDetailsSiteViewInfo.GetMinWidth: Integer;
begin                           
  Result := MaxWidth;
end;

function TcxCustomGridDetailsSiteViewInfo.GetNormalHeight: Integer;
begin
  Result := FNormalHeight;
end;

function TcxCustomGridDetailsSiteViewInfo.GetWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TcxCustomGridDetailsSiteViewInfo.GetPainterClass: TcxGridDetailsSitePainterClass;
begin
  Result := TcxGridDetailsSitePainter;
end;

function TcxCustomGridDetailsSiteViewInfo.GetTabsViewInfoClass: TcxCustomGridDetailsSiteTabsViewInfoClass;
begin
  case FLevel.Options.DetailTabsPosition of
    dtpLeft:
      Result := TcxGridDetailsSiteLeftTabsViewInfo;
    dtpTop:
      Result := TcxGridDetailsSiteTopTabsViewInfo;
  else
    Result := nil;
  end;
end;

function TcxCustomGridDetailsSiteViewInfo.GetActiveGridViewExists: Boolean;
begin
  Result := (FActiveGridView <> nil) and not IsActiveGridViewDestroying;
end;

function TcxCustomGridDetailsSiteViewInfo.GetActiveGridViewValue: TcxCustomGridView;
begin
  if FActiveGridView = nil then
  begin
    FActiveGridView := GetActiveGridView;
    if FActiveGridView <> nil then
      FActiveGridView.FreeNotification(Self);
  end;
  Result := FActiveGridView;
  if IsActiveGridViewDestroying then
    Result := nil;
end;

function TcxCustomGridDetailsSiteViewInfo.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TcxCustomGridDetailsSiteViewInfo.Calculate(ALeftBound, ATopBound: Integer);
begin
  Bounds.Left := ALeftBound;
  Bounds.Top := ATopBound;
  Bounds.Right := Bounds.Left + Width;
  Bounds.Bottom := Bounds.Top + Height;

  if FTabsViewInfo <> nil then
    FTabsViewInfo.Calculate(Bounds);

  if ActiveGridView <> nil then
    ActiveGridView.ViewInfo.MainCalculate(ClientBounds);
end;

function TcxCustomGridDetailsSiteViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;

  function GetDetailP: TPoint;
  begin
    with ActiveGridView.Site do
    begin
      Result.X := P.X - Left;
      Result.Y := P.Y - Top;
    end;
  end;

begin
  if FTabsViewInfo <> nil then
    Result := FTabsViewInfo.GetHitTest(P)
  else
    Result := nil;
  if (Result = nil) and (ActiveGridView <> nil) then
    Result := ActiveGridView.ViewInfo.GetHitTest(GetDetailP);
end;

procedure TcxCustomGridDetailsSiteViewInfo.Paint(ACanvas: TcxCanvas);
begin
  with GetPainterClass.Create(ACanvas, Self) do
    try
      Paint;
    finally
      Free;
    end;
end;

function TcxCustomGridDetailsSiteViewInfo.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result := (FTabsViewInfo <> nil) and FTabsViewInfo.ProcessDialogChar(ACharCode);
end;

function TcxCustomGridDetailsSiteViewInfo.SupportsTabAccelerators: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridDetailsSiteViewInfo.VisibilityChanged(AVisible: Boolean);
begin
  if ActiveGridViewExists then
    ActiveGridView.ViewInfo.DoVisibilityChanged(AVisible);
end;

end.
