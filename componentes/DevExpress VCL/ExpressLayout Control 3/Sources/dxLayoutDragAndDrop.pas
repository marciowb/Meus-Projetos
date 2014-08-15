{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl common routines                     }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxLayoutDragAndDrop;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Classes, Controls, Graphics,
  cxClasses, cxControls, cxGraphics, dxLayoutControl, dxLayoutContainer;

type
  TdxLayoutDragSource = (dsControl, dsCustomizeFormAvailableItems, dsCustomizeFormTreeViewItems);

  TdxLayoutCustomDragAndDropController = class;

  { TdxLayoutCustomDragAndDropObject }

  TdxLayoutCustomDragAndDropObject = class(TcxDragAndDropObject)
  private
    FContainer: TdxLayoutContainer;
    FSourceItem: TdxCustomLayoutItem;
    FStartDragPoint: TPoint;
  protected
    procedure Modified;
    //
    property Container: TdxLayoutContainer read FContainer;
  public
    constructor Create(AControl: TcxControl); override;
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); virtual;
    //
    property SourceItem: TdxCustomLayoutItem read FSourceItem write FSourceItem;
  end;

  { TdxLayoutDragAndDropObject }

  TdxLayoutDragAndDropObject = class(TdxLayoutCustomDragAndDropObject)
  private
    FController: TdxLayoutCustomDragAndDropController;
    FSource: TdxLayoutDragSource;
    FSourceItemBounds: TRect;
    function GetDestinationItem: TdxCustomLayoutItem;
  protected
    function CreateController: TdxLayoutCustomDragAndDropController; virtual;
    procedure DirtyChanged; override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;

    property Controller: TdxLayoutCustomDragAndDropController read FController;
    property Source: TdxLayoutDragSource read FSource write FSource;
    property SourceItemBounds: TRect read FSourceItemBounds;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;
    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); override;

    function CanDrop: Boolean;
    property DestinationItem: TdxCustomLayoutItem read GetDestinationItem;
  end;

  { TdxLayoutCustomSizingDragAndDropObject }

  TdxLayoutCustomSizingDragAndDropObject = class(TdxLayoutCustomDragAndDropObject)
  protected
    procedure RestoreSize; virtual;
  public
    procedure EndDragAndDrop(Accepted: Boolean); override;
  end;

  { TdxLayoutSizingDragAndDropObject }

  TdxLayoutSizingDragAndDropObject = class(TdxLayoutCustomSizingDragAndDropObject)
  private
    FOriginalBounds: TRect;
    FOriginalSize: TSize;
    FMarkerIndex: Integer;
  protected
    procedure RestoreSize; override;

    property MarkerIndex: Integer read FMarkerIndex;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); override;
  end;

  { TdxLayoutSplitterDragAndDropObject }

  TdxLayoutSizingStrategy = (lssLeft, lssRight, lssClient, lssNone);

  TdxLayoutSplitterDragAndDropObject = class(TdxLayoutCustomSizingDragAndDropObject)
  private
    FParentItem: TdxLayoutGroup;
    FLeftItem: TdxCustomLayoutItem;
    FRightItem: TdxCustomLayoutItem;
    FOriginalSizes: array of TPoint;
    FSizingStrategy: TdxLayoutSizingStrategy;
    FLeftItemSize: Integer;
    FRightItemSize: Integer;
    FPrevPoint: TPoint;
  protected
    procedure RestoreSize; override;

    function GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; virtual; abstract;
    function GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; virtual; abstract;
    function GetSignificantValue(const P: TPoint): Integer; virtual; abstract;
    procedure SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer); virtual; abstract;
  public
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); override;
  end;

  { TdxLayoutHSplitterDragAndDropObject }

  TdxLayoutHSplitterDragAndDropObject = class(TdxLayoutSplitterDragAndDropObject)
  protected
    function GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; override;
    function GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetSignificantValue(const P: TPoint): Integer; override;
    procedure SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer); override;
  end;

  { TdxLayoutVSplitterDragAndDropObject }

  TdxLayoutVSplitterDragAndDropObject = class(TdxLayoutSplitterDragAndDropObject)
  protected
    function GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; override;
    function GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetSignificantValue(const P: TPoint): Integer; override;
    procedure SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer); override;
  end;

  { TdxLayoutDragAndDropHelper }

  TdxLayoutDragAndDropHelper = class(TObject)
  private
    FContainer: TdxLayoutContainer;
    FDragItem: TdxCustomLayoutItem;
    FMouseDownPos: TPoint;
    procedure BeginDragAndDrop(ASource: TdxLayoutDragSource);
    function CanBeginDragAndDrop(X, Y: Integer): Boolean;
    function GetControl: TcxControl;
    function GetDragAndDropObject: TdxLayoutDragAndDropObject;
  protected
    property Control: TcxControl read GetControl;
    property DragAndDropObject: TdxLayoutDragAndDropObject read GetDragAndDropObject;
  public
    constructor Create(AContainer: TdxLayoutContainer); virtual;

    procedure InitializeDragItem(AItem: TdxCustomLayoutItem; X, Y: Integer);
    procedure Reset;
    procedure TryBeginDragAndDrop(X, Y: Integer; ASource: TdxLayoutDragSource);

    property Container: TdxLayoutContainer read FContainer;
    property DragItem: TdxCustomLayoutItem read FDragItem;
  end;

  TdxLayoutItemInsertionKind = (ikNone, ikLeft, ikTop, ikRight, ikBottom, ikInside);

//    public static class LayoutItemInsertionKindExtensions {
//        public static Side? GetSide(this LayoutItemInsertionKind kind) {
//            switch (kind) {
//                case LayoutItemInsertionKind.Left:
//                    return Side.Left;
//                case LayoutItemInsertionKind.Top:
//                    return Side.Top;
//                case LayoutItemInsertionKind.Right:
//                    return Side.Right;
//                case LayoutItemInsertionKind.Bottom:
//                    return Side.Bottom;
//                default:
//                    return null;
//            }
//        }
//    }

  TdxLayoutItemInsertionPoint = class
  private
    FItem: TdxCustomLayoutItem;
    FIsInternalInsertion: Boolean;
  public
    constructor Create(AItem: TdxCustomLayoutItem; AIsInternalInsertion: Boolean);
    function Equals(AValue: TdxLayoutItemInsertionPoint): Boolean; reintroduce;

    property Item: TdxCustomLayoutItem read FItem;
    property IsInternalInsertion: Boolean read FIsInternalInsertion;
  end;

  TdxLayoutItemInsertionPoints = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxLayoutItemInsertionPoint;
  public
    function Find(AItem: TdxCustomLayoutItem): TdxLayoutItemInsertionPoint;

    property Items[Index: Integer]: TdxLayoutItemInsertionPoint read GetItem; default;
  end;

  TdxLayoutItemInsertionInfo = class
  private
    FDestinationItem: TdxCustomLayoutItem;
    FInsertionKind: TdxLayoutItemInsertionKind;
    FInsertionPoint: TdxLayoutItemInsertionPoint;
  public
    constructor Create(ADestinationItem: TdxCustomLayoutItem;
      AInsertionKind: TdxLayoutItemInsertionKind;
      AInsertionPoint: TdxLayoutItemInsertionPoint); overload;
    function Equals(AValue: TdxLayoutItemInsertionInfo): Boolean; reintroduce;

    property DestinationItem: TdxCustomLayoutItem read FDestinationItem write FDestinationItem;
    property InsertionKind: TdxLayoutItemInsertionKind read FInsertionKind write FInsertionKind;
    property InsertionPoint: TdxLayoutItemInsertionPoint read FInsertionPoint write FInsertionPoint;
  end;

  TdxLayoutItems = class(TList)
  private
    function GetItem(Index: Integer): TdxCustomLayoutItem;
  public
    property Items[Index: Integer]: TdxCustomLayoutItem read GetItem; default;
  end;

  TdxItemAlignment = (iaStart, iaCenter, iaEnd, iaStretch);

  TdxLayoutItemInsertionCalculator = class
  private
    //FHorizontal: Boolean;
    FController: TdxLayoutCustomDragAndDropController;
    function GetItemAlignment(AItem: TdxCustomLayoutItem): TdxItemAlignment;
    function GetHorizontal: Boolean;
  protected
    property Controller: TdxLayoutCustomDragAndDropController read FController;
    property Horizontal: Boolean read GetHorizontal;
  public
    constructor Create(AController: TdxLayoutCustomDragAndDropController);
    procedure ArrangeItems(AItems: TdxLayoutItems);
    procedure CalculateInsertionInfoForEmptyArea(AGroup: TdxLayoutGroup;
      const ABounds: TRect; const P: TPoint; AItems: TdxLayoutItems;
      out AInsertionKind: TdxLayoutItemInsertionKind; out AInsertionPlace: TdxCustomLayoutItem);
    function GetInsertionInfo(const P: TPoint): TdxLayoutItemInsertionInfo;
    function GetInsertionInfoForEmptyArea(AGroup: TdxLayoutGroup; const P: TPoint): TdxLayoutItemInsertionInfo;
    function GetInsertionKind(AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem; const P: TPoint): TdxLayoutItemInsertionKind;
    function GetInsertionKindForEmptyArea(const ABounds: TRect; const P: TPoint): TdxLayoutItemInsertionKind;
    function GetInsertionPoint(AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem;
			AInsertionKind: TdxLayoutItemInsertionKind; const P: TPoint): TdxLayoutItemInsertionPoint;
    function GetInsertionPoints(AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem;
			AInsertionKind: TdxLayoutItemInsertionKind; AInsertionPoints: TdxLayoutItemInsertionPoints): TdxLayoutItemInsertionPoint;
    function GetInsertionZoneBounds(ABounds, AContentBounds: TRect; AInsertionKind: TdxLayoutItemInsertionKind): TRect; overload;
    function GetInsertionZoneBounds(AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem; AInsertionKind: TdxLayoutItemInsertionKind): TRect; overload;
    function IsInsertionPoint(AControl: TdxLayoutControl;
      AItem, ADestinationItem, AOriginalDestinationItem: TdxCustomLayoutItem;
      AInsertionKind: TdxLayoutItemInsertionKind): Boolean;
  end;

  { TdxLayoutCustomDragAndDropController }

  TdxLayoutCustomDragAndDropController = class
  private
    FAreaPart: TdxLayoutAreaPart;
    FDragImage: TcxDragImage;
    FDragImageOffset: TPoint;
    FDragImagePoint: TPoint;
    FDestinationContainer: TdxLayoutContainer;
    FDestinationGroup: TdxLayoutGroup;
    FDestinationItem: TdxCustomLayoutItem;
    FHitTest: TdxCustomLayoutHitTest;
    FNeedUpdateDestinationImage: Boolean;
    FOwner: TdxLayoutDragAndDropObject;
    FSource: TdxLayoutDragSource;
    FSourceItemBounds: TRect;
    function GetContainer: TdxLayoutContainer;
    function GetSourceItem: TdxCustomLayoutItem;
    procedure SetAreaPart(Value: TdxLayoutAreaPart);
    procedure SetDestinationContainer(Value: TdxLayoutContainer);
    procedure SetDestinationGroup(Value: TdxLayoutGroup);
    procedure SetDestinationItem(Value: TdxCustomLayoutItem);
  protected
    procedure Changed;
    procedure CreateDragImage;
    procedure CreateDestinationImage; virtual;
    procedure DestroyDestinationImage; virtual;
    procedure DoDrop(ALayoutAction: TdxLayoutActionType); virtual;
    function FindDestLayoutContainer(const P: TPoint): TdxLayoutContainer;
    procedure PaintDragImage;
    procedure UpdateDestinationImage; virtual;
    procedure ResetDragAndDropObjects;
    procedure ShowDragImage;
    procedure UpdateStates; virtual;

    property AreaPart: TdxLayoutAreaPart read FAreaPart write SetAreaPart;
    property Container: TdxLayoutContainer read GetContainer;
    property DestinationContainer: TdxLayoutContainer read FDestinationContainer write SetDestinationContainer;
    property DestinationGroup: TdxLayoutGroup read FDestinationGroup write SetDestinationGroup;
    property DestinationItem: TdxCustomLayoutItem read FDestinationItem write SetDestinationItem;
    property Owner: TdxLayoutDragAndDropObject read FOwner;
    property Source: TdxLayoutDragSource read FSource write FSource;
    property SourceItem: TdxCustomLayoutItem read GetSourceItem;
    property SourceItemBounds: TRect read FSourceItemBounds;
  public
    constructor Create(AOwner: TdxLayoutDragAndDropObject); virtual;
    procedure Calculate(const P: TPoint; var Accepted: Boolean);
    function CanDrop: Boolean;
    function CanRemove: Boolean;
    procedure Drop(Accepted: Boolean);
    function GetCursor(Accepted: Boolean): TCursor;
    procedure Invalidate;
  end;

  { TdxLayoutDragAndDropController }

  TdxLayoutDragAndDropController = class(TdxLayoutCustomDragAndDropController)
  private
    FDestinationImage: TcxDragImage;
    function GetDestinationPosition: Integer;
  protected
    procedure CreateDestinationImage; override;
    procedure DestroyDestinationImage; override;
    procedure DoDrop(ALayoutAction: TdxLayoutActionType); override;
    procedure PaintDestinationImage; virtual;
    procedure UpdateDestinationImage; override;
  end;

  { TdxLayoutItemDropPlaceWindow }

  TdxLayoutItemDropPlaceWindow = class(TCustomControl)
  private
    FInControl: Boolean;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetInControl(const Value: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure Paint; override;

    property InControl: Boolean read FInControl write SetInControl;
  end;

  { TdxLayoutItemDropPlaceWindows }

  TdxLayoutItemDropPlaceWindows = class(TcxObjectList)
  private
    FVisible: Boolean;
    function GetItem(Index: Integer): TdxLayoutItemDropPlaceWindow;
    procedure SetVisible(const Value: Boolean);
  public
    procedure Add(const R: TRect);
    procedure Clear; override;

    property Items[Index: Integer]: TdxLayoutItemDropPlaceWindow read GetItem; default;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  { TdxLayoutDragAndDropControllerEx }

  TdxLayoutDragAndDropControllerEx = class(TdxLayoutCustomDragAndDropController)
  private
    FDropPlaces: TdxLayoutItemDropPlaceWindows;
  protected
    procedure CreateDestinationImage; override;
    procedure DestroyDestinationImage; override;
    procedure DoDrop(ALayoutAction: TdxLayoutActionType); override;
    function GetRect(const ABounds: TRect): TRect;
    function GetScreenRect(const R: TRect): TRect;
    procedure UpdateDestinationImage; override;

    property DropPlaces: TdxLayoutItemDropPlaceWindows read FDropPlaces;
  public
    //constructor Create(AOwner: TdxLayoutDragAndDropObject); override;
  end;

function dxLayoutDragAndDropObject: TdxLayoutDragAndDropObject;
function dxLayoutSizingDragAndDropObject: TdxLayoutSizingDragAndDropObject;

implementation

uses
  Types, SysUtils, Forms, Math, cxLibraryConsts, cxGeometry;

const
  dxLayoutSelectionBorderDefaultColor: TColor = $BD8753;
  dxLayoutDestinationColor = $D0D0EE;
  dxLayoutDestinationBorderColor = $000059;

  dxCustomizeFormHitTestCodes = [htCustomizeForm, htAvailableItems, htTreeViewItems];

var
  FLayoutDragAndDropObject: TdxLayoutDragAndDropObject;
  FLayoutSizingDragAndDropObject: TdxLayoutSizingDragAndDropObject;

type
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxLayoutContainerAccess = class(TdxLayoutContainer);
  TdxLayoutGroupAccess = class(TdxLayoutGroup);
  TdxLayoutGroupViewInfoAccess = class(TdxLayoutGroupViewInfo);
  TdxLayoutSizeOptionsAccess = class(TdxLayoutSizeOptions);

function dxLayoutDragAndDropObject: TdxLayoutDragAndDropObject;
begin
  Result := FLayoutDragAndDropObject;
end;

function dxLayoutSizingDragAndDropObject: TdxLayoutSizingDragAndDropObject;
begin
  Result := FLayoutSizingDragAndDropObject;
end;

{ TdxLayoutCustomDragAndDropObject }

constructor TdxLayoutCustomDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited Create(AControl);
  FContainer := (AControl as IdxLayoutContainer).GetContainer;
end;

procedure TdxLayoutCustomDragAndDropObject.Init(ASource: TdxLayoutDragSource;
  ASourceItem: TdxCustomLayoutItem; const P: TPoint);
begin
  FSourceItem := ASourceItem;
  FStartDragPoint := P;
end;

procedure TdxLayoutCustomDragAndDropObject.Modified;
begin
  Container.Modified;
end;

{ TdxLayoutDragAndDropObject }

function TdxLayoutDragAndDropObject.CanDrop: Boolean;
begin
  Result := Controller.CanDrop;
end;

constructor TdxLayoutDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited Create(AControl);
  FLayoutDragAndDropObject := Self;
  FController := CreateController;
end;

destructor TdxLayoutDragAndDropObject.Destroy;
begin
  FLayoutDragAndDropObject := nil;
  FreeAndNil(FController);
  inherited Destroy;
end;


function TdxLayoutDragAndDropObject.CreateController: TdxLayoutCustomDragAndDropController;
begin
  Result := TdxLayoutDragAndDropController.Create(Self);
  //Result := TdxLayoutDragAndDropControllerEx.Create(Self);
end;

procedure TdxLayoutDragAndDropObject.DirtyChanged;
begin
  inherited DirtyChanged;
  Controller.Invalidate;
end;

function TdxLayoutDragAndDropObject.GetDestinationItem: TdxCustomLayoutItem;
begin
  Result := Controller.DestinationItem;
end;

function TdxLayoutDragAndDropObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  Result := Controller.GetCursor(Accepted);
end;

procedure TdxLayoutDragAndDropObject.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
  Controller.CreateDragImage;
end;

procedure TdxLayoutDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  Controller.Calculate(P, Accepted);
  inherited DragAndDrop(P, Accepted);
end;

procedure TdxLayoutDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
begin
  Controller.Drop(Accepted);
  inherited EndDragAndDrop(Accepted);
end;

procedure TdxLayoutDragAndDropObject.Init(ASource: TdxLayoutDragSource;
  ASourceItem: TdxCustomLayoutItem; const P: TPoint);
begin
  inherited;
  Container.Update;
  Source := ASource;
end;

{ TdxLayoutCustomSizingDragAndDropObject }

procedure TdxLayoutCustomSizingDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
begin
  if Accepted then
    Modified
  else
    RestoreSize;
end;

procedure TdxLayoutCustomSizingDragAndDropObject.RestoreSize;
begin
// do nothing
end;

{ TdxLayoutSizingDragAndDropObject }

constructor TdxLayoutSizingDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited Create(AControl);
  FLayoutSizingDragAndDropObject := Self;
end;

destructor TdxLayoutSizingDragAndDropObject.Destroy;
begin
  FLayoutSizingDragAndDropObject := nil;
  inherited Destroy;
end;

procedure TdxLayoutSizingDragAndDropObject.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
  if not Container.IsDesigning then
    Container.SaveToUndo;
end;

procedure TdxLayoutSizingDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
var
  XC, YC: Integer;
begin
  if SourceItem.AlignHorz in [ahCenter] then
    XC := 2
  else
    XC := 1;

  if SourceItem.AlignVert in [avCenter] then
    YC := 2
  else
    YC := 1;

  if MarkerIndex in [0, 6, 7] then
    SourceItem.Width := cxRectWidth(FOriginalBounds) + XC * (FStartDragPoint.X - P.X);
  if MarkerIndex in [2, 3, 4] then
    SourceItem.Width := cxRectWidth(FOriginalBounds) + XC * (P.X - FStartDragPoint.X);
  if MarkerIndex in [0, 1, 2] then
    SourceItem.Height := cxRectHeight(FOriginalBounds) + YC * (FStartDragPoint.Y - P.Y);
  if MarkerIndex in [4, 5, 6] then
    SourceItem.Height := cxRectHeight(FOriginalBounds) + YC * (P.Y - FStartDragPoint.Y);
end;

procedure TdxLayoutSizingDragAndDropObject.Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint);
begin
  inherited;
  FOriginalSize := cxSize(ASourceItem.Width, ASourceItem.Height);
  FOriginalBounds := ASourceItem.ViewInfo.Bounds;
  FMarkerIndex := TdxCustomLayoutItemViewInfoAccess(ASourceItem.ViewInfo).GetMarkerIndex(P);
end;

procedure TdxLayoutSizingDragAndDropObject.RestoreSize;
begin
  if Control.IsDesigning then
  begin
    SourceItem.Width := FOriginalSize.cx;
    SourceItem.Height := FOriginalSize.cy;
  end
  else
    Container.CancelLastUndo;
end;

{ TdxLayoutSplitterDragAndDropObject }

procedure TdxLayoutSplitterDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  if not cxPointIsEqual(FPrevPoint, P) then
  begin
    FPrevPoint := P;
    case FSizingStrategy of
      lssLeft:
        SetItemSize(FLeftItem.ViewInfo, FLeftItemSize + (GetSignificantValue(P) - GetSignificantValue(FStartDragPoint)));
      lssRight:
        SetItemSize(FRightItem.ViewInfo, FRightItemSize + (GetSignificantValue(FStartDragPoint) - GetSignificantValue(P)));
      lssClient:
        begin
          Container.BeginUpdate;
          try
            SetItemSize(FLeftItem.ViewInfo, FLeftItemSize + (GetSignificantValue(P) - GetSignificantValue(FStartDragPoint)));
            SetItemSize(FRightItem.ViewInfo, FRightItemSize + (GetSignificantValue(FStartDragPoint) - GetSignificantValue(P)));
          finally
            Container.CancelUpdate;
            TdxLayoutSizeOptionsAccess(FLeftItem.SizeOptions).Changed;
          end;
        end;
    end;
    Container.Update;
  end;
end;

procedure TdxLayoutSplitterDragAndDropObject.Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint);

  function GetLeftItem: TdxCustomLayoutItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := ASourceItem.VisibleIndex - 1 downto 0 do
      if GetWorkAlign(FParentItem.VisibleItems[I].ViewInfo) in [GetWorkAlign(FSourceItem.ViewInfo), ahClient] then
      begin
        Result := FParentItem.VisibleItems[I];
        Break;
      end;
  end;

  function GetRightItem: TdxCustomLayoutItem;
  var
    I: Integer;
  begin
    Result := nil;
    for I := ASourceItem.VisibleIndex + 1 to FParentItem.VisibleCount - 1 do
      if GetWorkAlign(FParentItem.VisibleItems[I].ViewInfo) in [GetWorkAlign(FSourceItem.ViewInfo), ahClient] then
      begin
        Result := FParentItem.VisibleItems[I];
        Break;
      end;
  end;

  function GetSimpleStrategy(AAlign: TdxLayoutAlignHorz): TdxLayoutSizingStrategy;
  begin
    case AAlign of
      ahLeft:
        if (FLeftItem <> nil) and not TdxCustomLayoutItemAccess(FLeftItem).IsLocked then
          Result := lssLeft
        else
          Result := lssNone;
      ahRight:
        if (FRightItem <> nil) and not TdxCustomLayoutItemAccess(FRightItem).IsLocked then
          Result := lssRight
        else
          Result := lssNone;
    else
      Result := lssNone;
    end;
    if (Result in [lssRight, lssLeft]) and (FLeftItem <> nil) and (FRightItem <> nil) and
      (GetWorkAlign(FLeftItem.ViewInfo) = ahClient) and (GetWorkAlign(FRightItem.ViewInfo) = ahClient) then
      Result := lssClient;
  end;

var
  I: Integer;
begin
  inherited;

  FParentItem := ASourceItem.Parent;

  SetLength(FOriginalSizes, FParentItem.VisibleCount);
  for I := 0 to FParentItem.VisibleCount - 1 do
    FOriginalSizes[I] := Point(FParentItem.VisibleItems[I].Width, FParentItem.VisibleItems[I].Height);

  FLeftItem := GetLeftItem;
  FRightItem := GetRightItem;
  if FLeftItem <> nil then
    FLeftItemSize := GetItemSize(FLeftItem.ViewInfo);
  if FRightItem <> nil then
    FRightItemSize := GetItemSize(FRightItem.ViewInfo);

  case GetWorkAlign(FSourceItem.ViewInfo) of
    ahLeft:
      if (FLeftItem <> nil) and (GetWorkAlign(FLeftItem.ViewInfo) = ahClient) then
        FSizingStrategy := GetSimpleStrategy(ahRight)
      else
        FSizingStrategy := GetSimpleStrategy(ahLeft);
    ahRight:
      if (FRightItem <> nil) and (GetWorkAlign(FRightItem.ViewInfo) = ahClient) then
        FSizingStrategy := GetSimpleStrategy(ahLeft)
      else
        FSizingStrategy := GetSimpleStrategy(ahRight);
  else
    FSizingStrategy := lssNone;
  end;

  if FSizingStrategy = lssClient then
  begin
    Container.BeginUpdate;
    try
      for I := 0 to FParentItem.VisibleCount - 1 do
        if GetWorkAlign(FParentItem.VisibleItems[I].ViewInfo) = ahClient then
          SetItemSize(FParentItem.VisibleItems[I].ViewInfo, GetItemSize(FParentItem.VisibleItems[I].ViewInfo));
    finally
      Container.CancelUpdate;
    end;
  end;

  FPrevPoint := P;
end;

procedure TdxLayoutSplitterDragAndDropObject.RestoreSize;
var
  I: Integer;
begin
  Container.BeginUpdate;
  try
    for I := 0 to FParentItem.VisibleCount - 1 do
      SetItemSize(FParentItem.VisibleItems[I].ViewInfo, GetSignificantValue(FOriginalSizes[I]));
  finally
    Container.EndUpdate(False);
  end;
end;

{ TdxLayoutHSplitterDragAndDropObject }

function TdxLayoutHSplitterDragAndDropObject.GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz;
begin
  Result := AViewInfo.AlignHorz;
end;

function TdxLayoutHSplitterDragAndDropObject.GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := cxRectWidth(AViewInfo.Bounds);
end;

function TdxLayoutHSplitterDragAndDropObject.GetSignificantValue(const P: TPoint): Integer;
begin
  Result := P.X;
end;

procedure TdxLayoutHSplitterDragAndDropObject.SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer);
begin
  TdxCustomLayoutItemViewInfoAccess(AViewInfo).Item.Width := ASize;
end;

{ TdxLayoutHSplitterDragAndDropObject }

function TdxLayoutVSplitterDragAndDropObject.GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz;
begin
  Result := TdxLayoutAlignHorz(AViewInfo.AlignVert);
end;

function TdxLayoutVSplitterDragAndDropObject.GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer;
begin
  Result := cxRectHeight(AViewInfo.Bounds);
end;

function TdxLayoutVSplitterDragAndDropObject.GetSignificantValue(const P: TPoint): Integer;
begin
  Result := P.Y;
end;

procedure TdxLayoutVSplitterDragAndDropObject.SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer);
begin
  TdxCustomLayoutItemViewInfoAccess(AViewInfo).Item.Height := ASize;
end;

{ TdxLayoutDragAndDropHelper }

constructor TdxLayoutDragAndDropHelper.Create(AContainer: TdxLayoutContainer);
begin
  inherited Create;
  FContainer := AContainer;
  Reset;
end;

procedure TdxLayoutDragAndDropHelper.InitializeDragItem(AItem: TdxCustomLayoutItem;
  X, Y: Integer);
begin
  FMouseDownPos := Point(X, Y);
  FDragItem := AItem;
end;

procedure TdxLayoutDragAndDropHelper.Reset;
begin
  FDragItem := nil;
  FMouseDownPos := cxInvalidPoint;
end;

procedure TdxLayoutDragAndDropHelper.TryBeginDragAndDrop(X, Y: Integer;
  ASource: TdxLayoutDragSource);
begin
  if CanBeginDragAndDrop(X, Y) then
    BeginDragAndDrop(ASource);
end;

function TdxLayoutDragAndDropHelper.CanBeginDragAndDrop(X, Y: Integer): Boolean;
begin
  Result := Container.CanDragAndDrop and (Control.DragAndDropState = ddsNone) and not
    (cxPointIsEqual(FMouseDownPos, cxInvalidPoint) or IsPointInDragDetectArea(FMouseDownPos, X, Y)) and
    (DragItem <> nil) and TdxCustomLayoutItemAccess(DragItem).CanDragAndDrop;
end;

procedure TdxLayoutDragAndDropHelper.BeginDragAndDrop(ASource: TdxLayoutDragSource);
begin
  DragAndDropObject.Init(ASource, DragItem, GetMouseCursorPos);
  Control.BeginDragAndDrop;
end;

function TdxLayoutDragAndDropHelper.GetDragAndDropObject: TdxLayoutDragAndDropObject;
begin
  Result := TdxLayoutDragAndDropObject(Control.DragAndDropObject);
end;

function TdxLayoutDragAndDropHelper.GetControl: TcxControl;
begin
  Result := Container.ItemsParent;
end;

{ TdxLayoutItemDropPlaceWindow }

procedure TdxLayoutItemDropPlaceWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  end;
end;

procedure TdxLayoutItemDropPlaceWindow.CreateWindowHandle(
  const Params: TCreateParams);
begin
  inherited;
  cxSetLayeredWindowAttributes(Handle, 153);
end;

procedure TdxLayoutItemDropPlaceWindow.Paint;
var
  ARgn: HRGN;
begin
  Canvas.Brush.Color := $8080FF;
  Canvas.FillRect(ClientRect);
  ARgn := CreateRectRgn(0, 0, 0, 0);
  GetWindowRgn(Handle, ARgn);
  Canvas.Brush.Color := clRed;
  FrameRgn(Canvas.Handle, ARgn, Canvas.Brush.Handle, 1, 1);
  DeleteObject(ARgn);
end;

procedure TdxLayoutItemDropPlaceWindow.SetInControl(const Value: Boolean);
begin
  FInControl := Value;
  Invalidate;
end;

procedure TdxLayoutItemDropPlaceWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
//  if Message.Result = HTMo then
//    InControl := True;
  Message.Result := HTTRANSPARENT;
end;

{ TdxLayoutItemDropPlaceWindows }

procedure TdxLayoutItemDropPlaceWindows.Add(const R: TRect);
var
  AWindow: TdxLayoutItemDropPlaceWindow;
begin
  AWindow := TdxLayoutItemDropPlaceWindow.Create(nil);
  AWindow.BoundsRect := R;
  SetWindowRgn(AWindow.Handle, CreateRoundRectRgn(0, 0, AWindow.Width, AWindow.Height, 3, 3), False);
  inherited Add(AWindow);
end;

procedure TdxLayoutItemDropPlaceWindows.Clear;
begin
  Visible := False;
  inherited Clear;
end;

function TdxLayoutItemDropPlaceWindows.GetItem(Index: Integer): TdxLayoutItemDropPlaceWindow;
begin
  Result := TdxLayoutItemDropPlaceWindow(inherited Items[Index]);
end;

procedure TdxLayoutItemDropPlaceWindows.SetVisible(const Value: Boolean);
var
  I: Integer;
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    for I := 0 to Count - 1 do
      if Visible then
        ShowWindow(Items[I].Handle, SW_SHOWNA)
      else
        ShowWindow(Items[I].Handle, SW_HIDE);
  end;
end;

{ TdxLayoutCustomDragAndDropController }

constructor TdxLayoutCustomDragAndDropController.Create(AOwner: TdxLayoutDragAndDropObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TdxLayoutCustomDragAndDropController.Drop(Accepted: Boolean);

  function CanProcessDrop: Boolean;
  begin
    Result := Accepted and (DestinationContainer <> nil) and ((CanDrop and (DestinationItem <> nil)) or CanRemove);
  end;

  function GetActionType(AAreaPart: TdxLayoutAreaPart): TdxLayoutActionType;
  begin
    if AAreaPart in [apBefore, apAfter, apFirstChild, apLastChild] then
      Result := atInsert
    else
      Result := TdxLayoutGroupViewInfoAccess(DestinationGroup.ViewInfo).GetActionType(AAreaPart);
  end;

var
  ALinkSelf: TcxObjectLink;
begin
  FreeAndNil(FDragImage);
  UpdateStates;
  Changed;
  if CanProcessDrop then
  begin
    DestinationContainer.SaveToUndo;
    DestinationContainer.BeginUpdate;
    Container.SaveToUndo;
    Container.BeginUpdate;
    try
      if CanDrop and (DestinationGroup <> nil) then
        DoDrop(GetActionType(AreaPart))
      else
        if CanRemove then
          SourceItem.Parent := nil;
    finally
      ALinkSelf := cxAddObjectLink(SourceItem);
      try
        ResetDragAndDropObjects;
        Container.EndUpdate;
        DestinationContainer.EndUpdate;
        if ALinkSelf.Ref <> nil then
          (ALinkSelf.Ref as TdxCustomLayoutItem).MakeVisible;
      finally
        cxRemoveObjectLink(ALinkSelf);
      end;
    end;
    Container.Update;
    if DestinationContainer <> Container then
      DestinationContainer.Update;
    Owner.Modified;
  end
  else
    ResetDragAndDropObjects;
end;

procedure TdxLayoutCustomDragAndDropController.Calculate(const P: TPoint;
  var Accepted: Boolean);
begin
  UpdateStates;
  ShowDragImage;
  Accepted := AreaPart <> apNone;
  if FNeedUpdateDestinationImage then
  begin
    UpdateDestinationImage;
    FNeedUpdateDestinationImage := False;
  end;
end;

function TdxLayoutCustomDragAndDropController.CanDrop: Boolean;
begin
  Result := (DestinationGroup <> nil) and SourceItem.CanMoveTo(DestinationGroup) and
    not TdxLayoutGroupAccess(DestinationGroup).IsLocked;
end;

function TdxLayoutCustomDragAndDropController.CanRemove: Boolean;
begin
  Result := (FHitTest.HitTestCode in [htAvailableItems, htNone]) and
    TdxCustomLayoutItemAccess(SourceItem).CanRemove and (SourceItem.Parent <> nil);
end;

procedure TdxLayoutCustomDragAndDropController.Changed;
begin
  Owner.Dirty := True;
end;

procedure TdxLayoutCustomDragAndDropController.CreateDestinationImage;
begin
end;

procedure TdxLayoutCustomDragAndDropController.DoDrop(ALayoutAction: TdxLayoutActionType);

  function GetDestinationPosition: Integer;
  begin
    case AreaPart of
      apRight, apBottom, apAfter:
        if DestinationItem = DestinationGroup then
          Result := DestinationGroup.Count
        else
          Result := DestinationItem.Index + 1;
      apLeft, apTop, apBefore:
        if DestinationItem = DestinationGroup then
          Result := 0
        else
          Result := DestinationItem.Index;
      apLastChild:
        Result := DestinationGroup.Count;
    else
      Result := 0;
    end;
    if (SourceItem.Parent = DestinationGroup) and (SourceItem.Index < Result) then
      Dec(Result);
  end;

  function GetOrthogonalDirection: TdxLayoutDirection;
  begin
    Result := TdxLayoutGroupAccess(DestinationItem.Parent).GetHelperClass.GetOrthogonalDirection;
  end;

  function IsHorizontalAreaPart: Boolean;
  begin
    Result := AreaPart in [apLeft, apRight, apAfter, apBefore];
  end;

  procedure DoInsert;
  begin
    SourceItem.Move(DestinationGroup, GetDestinationPosition, True);
  end;

  procedure DoCreateGroup;
  const
    LayoutDirections: array[Boolean] of TdxLayoutDirection = (ldVertical, ldHorizontal);
  var
    AParentGroup: TdxLayoutGroup;
  begin
    if DestinationItem.IsRoot then
    begin
      DestinationGroup.PutChildrenIntoHiddenGroup;
      DestinationGroup.LayoutDirection := LayoutDirections[IsHorizontalAreaPart];
      AParentGroup := DestinationGroup;
    end
    else
      AParentGroup := DestinationItem.PutIntoHiddenGroup(GetOrthogonalDirection);
    TdxLayoutGroupAccess(AParentGroup).BuildVisibleItemsList;
    SourceItem.Move(AParentGroup, GetDestinationPosition, True);
  end;

  procedure DoContentInsert;
  begin
    DestinationGroup.PutChildrenIntoHiddenGroup;
    DestinationGroup.LayoutDirection := GetOrthogonalDirection;
    SourceItem.Move(DestinationGroup, GetDestinationPosition, True);
  end;

begin
  case ALayoutAction of
    atInsert:
      DoInsert;
    atCreateGroup:
      DoCreateGroup;
    atContentInsert:
      DoContentInsert;
  end;
end;

function TdxLayoutCustomDragAndDropController.FindDestLayoutContainer(const P: TPoint): TdxLayoutContainer;
var
  AContainer: IdxLayoutContainer;
  AControl: TWinControl;
  AParentForm: TCustomForm;
  AWnd: THandle;
begin
  Result := nil;
  if Container.IsDesigning then
  begin
    AWnd := cxWindowFromPoint(P);
    while (Result = nil) and (AWnd <> 0) do
    begin
      AControl := FindControl(AWnd);
      if Supports(AControl, IdxLayoutContainer, AContainer) then
      begin
        AParentForm := GetParentForm(AControl);
        if AParentForm is TdxLayoutControlCustomCustomizeForm then
          Result := TdxLayoutControlCustomCustomizeForm(AParentForm).Container
        else
        begin
          if (AControl.Owner = Container.ItemsParent.Owner) then
            Result := AContainer.GetContainer;
        end;
      end;
      AWnd := GetAncestor(AWnd, GA_PARENT);
    end;
  end;
  if Result = nil then
    Result := Container;
end;

procedure TdxLayoutCustomDragAndDropController.Invalidate;
begin
  FNeedUpdateDestinationImage := True;
end;

function TdxLayoutCustomDragAndDropController.GetCursor(Accepted: Boolean): TCursor;
begin
 if CanDrop then
    Result := crDefault
  else
    if CanRemove then
      Result := crdxLayoutControlRemove
    else
      Result := crdxLayoutControlNoDrop;
end;

procedure TdxLayoutCustomDragAndDropController.CreateDragImage;
begin
  FDragImage := TcxDragImage.Create;
  PaintDragImage;
end;

procedure TdxLayoutCustomDragAndDropController.DestroyDestinationImage;
begin
end;

function TdxLayoutCustomDragAndDropController.GetContainer: TdxLayoutContainer;
begin
  Result := Owner.Container;
end;

function TdxLayoutCustomDragAndDropController.GetSourceItem: TdxCustomLayoutItem;
begin
  Result := Owner.SourceItem;
end;

procedure TdxLayoutCustomDragAndDropController.PaintDragImage;
var
  AViewInfo: TdxCustomLayoutItemViewInfo;

  function GetItemDragBounds: TRect;
  begin
    Result := AViewInfo.SelectionBorderRect;
  end;

  procedure CalculateDragImageOffset;
  begin
      FDragImageOffset := cxNullPoint;
  end;

  function GetViewInfoBounds(AHasBorderChanged: Boolean): TRect;
  begin
    if TdxCustomLayoutItemAccess(SourceItem).IsAvailable or not TdxCustomLayoutItemViewInfoAccess(AViewInfo).ActuallyVisible then
      Result := Rect(-TdxCustomLayoutItemViewInfoAccess(AViewInfo).CalculateWidth, -TdxCustomLayoutItemViewInfoAccess(AViewInfo).CalculateHeight, 0, 0)
    else
    begin
      Result := TdxCustomLayoutItemViewInfoAccess(AViewInfo).OriginalBounds;
      if AHasBorderChanged then
        Result := TdxLayoutGroupViewInfoAccess(AViewInfo).GetItemAreaBounds(Result);
   end;
  end;

var
  ANeedDestroyViewInfo: Boolean;
  APrevHasBorder: Boolean;
  APrevBounds: TRect;
begin
  if not TdxCustomLayoutItemAccess(SourceItem).ActuallyVisible then
  begin
    AViewInfo := TdxCustomLayoutItemAccess(SourceItem).GetViewInfoClass.Create(Container.ViewInfo, nil, SourceItem);
    ANeedDestroyViewInfo := True;
  end
  else
  begin
    AViewInfo := SourceItem.ViewInfo;
    ANeedDestroyViewInfo := False;
    APrevBounds := AViewInfo.Bounds;
  end;
  try
    APrevHasBorder := TdxCustomLayoutItemViewInfoAccess(AViewInfo).HasBorder;
    Container.ViewInfo.StartDragImagePainted;
    try
      AViewInfo.Calculate(GetViewInfoBounds(TdxCustomLayoutItemViewInfoAccess(AViewInfo).HasBorder <> APrevHasBorder));

      FDragImage.SetBounds(0, 0, cxRectWidth(GetItemDragBounds), cxRectHeight(GetItemDragBounds));
      FDragImage.Canvas.WindowOrg := GetItemDragBounds.TopLeft;
      try
        with TdxCustomLayoutItemViewInfoAccess(AViewInfo).GetPainterClass.Create(FDragImage.Canvas, AViewInfo) do
          try
            PaintDragImage;
          finally
            Free;
          end;
      finally
        FDragImage.Canvas.WindowOrg := cxNullPoint;
      end;
      CalculateDragImageOffset;
    finally
      Container.ViewInfo.StopDragImagePainted;
    end;
  finally
    if ANeedDestroyViewInfo then
      AViewInfo.Destroy
    else
      AViewInfo.Calculate(APrevBounds);
  end;
end;

procedure TdxLayoutCustomDragAndDropController.UpdateDestinationImage;
begin
end;

procedure TdxLayoutCustomDragAndDropController.ResetDragAndDropObjects;
begin
  Owner.SourceItem := nil;
  DestinationItem := nil;
  DestinationGroup := nil;
  FHitTest := nil;
  TdxLayoutContainerAccess(Container).CustomizeFormPostUpdate([cfutDragAndDropState]);
end;

procedure TdxLayoutCustomDragAndDropController.SetAreaPart(
  Value: TdxLayoutAreaPart);
begin
  if FAreaPart <> Value then
  begin
    FAreaPart := Value;
    Changed;
  end;
end;

procedure TdxLayoutCustomDragAndDropController.SetDestinationContainer(Value: TdxLayoutContainer);
begin
  if FDestinationContainer <> Value then
  begin
    FDestinationContainer := Value;
    Changed;
  end;
end;

procedure TdxLayoutCustomDragAndDropController.SetDestinationGroup(
  Value: TdxLayoutGroup);
begin
  if FDestinationGroup <> Value then
  begin
    if FDestinationGroup <> nil then
      DestroyDestinationImage;
    FDestinationGroup := Value;
    if FDestinationGroup <> nil then
      CreateDestinationImage;
    Changed;
  end;
end;

procedure TdxLayoutCustomDragAndDropController.SetDestinationItem(
  Value: TdxCustomLayoutItem);
begin
  if FDestinationItem <> Value then
  begin
    if FDestinationItem <> nil then
    begin
      if FHitTest.HitTestCode in dxCustomizeFormHitTestCodes then
        DestinationItem.Container.CustomizeForm.ToggleHotTrackState(DestinationItem);
    end;
    FDestinationItem := Value;
    if FDestinationItem <> nil then
    begin
      if FHitTest.HitTestCode in dxCustomizeFormHitTestCodes then
        DestinationItem.Container.CustomizeForm.ToggleHotTrackState(DestinationItem);
    end;
    Changed;
  end;
end;

procedure TdxLayoutCustomDragAndDropController.ShowDragImage;
begin
  if FDragImage <> nil then
  begin
    FDragImage.MoveTo(FDragImagePoint);
    FDragImage.Show;
  end;
end;

procedure TdxLayoutCustomDragAndDropController.UpdateStates;

  procedure DetermineDestinationContainer(AHitContainer: TdxLayoutContainer);
  begin
    if DestinationItem = nil then
      DestinationContainer := AHitContainer
    else
      DestinationContainer := DestinationItem.Container;
  end;

  procedure DetermineDestinationItem;
  var
    ADestinationItem: TdxCustomLayoutItem;
  begin
    ADestinationItem := FHitTest.GetDestinationItem;
    if (ADestinationItem = SourceItem) or
        ((ADestinationItem is TdxLayoutGroup) and not SourceItem.CanMoveTo(ADestinationItem)) then
      ADestinationItem := nil;

    DestinationItem := ADestinationItem;
    if (DestinationItem <> nil) and (DestinationItem.Container <> DestinationContainer) then
      DestinationContainer := DestinationItem.Container;
  end;

  procedure DetermineAreaPart(const P: TPoint);
  const
    CustomizeFormTreeViewItemAreaPart: array [TdxLayoutDirection] of TdxLayoutAreaPart = (apRight, apBottom, apBottom);
  var
    AAreaPart: TdxLayoutAreaPart;
  begin
    if FHitTest.IsDeterminedAreaPart then
      AAreaPart := FHitTest.GetAreaPart
    else
      if DestinationItem <> nil then
        AAreaPart := TdxCustomLayoutItemViewInfoAccess(DestinationItem.ViewInfo).GetAreaPart(P)
      else
        AAreaPart := apNone;

    AreaPart := AAreaPart;
  end;

  procedure DetermineDestinationGroup;
  begin
    if DestinationItem = nil then
      DestinationGroup := nil
    else
    begin
      if DestinationItem.IsRoot or (AreaPart in [apCenter, apFirstChild, apLastChild]) then
        DestinationGroup := TdxLayoutGroup(DestinationItem)
      else
        DestinationGroup := DestinationItem.Parent;
    end;
  end;

  procedure DetermineHitTest(AHitContainer: TdxLayoutContainer; const P: TPoint);
  begin
    FHitTest := AHitContainer.GetHitTest(AHitContainer.ScreenToClient(P));
  end;

var
  AHitContainer: TdxLayoutContainer;
//  AInfo: TdxLayoutItemInsertionInfo;
//  AKind: TdxLayoutItemInsertionKind;
  AScreenPoint, ADestPoint: TPoint;
//  S: string;
begin
  AScreenPoint := GetMouseCursorPos;
  AHitContainer := FindDestLayoutContainer(AScreenPoint);
  FDragImagePoint := cxPointOffset(AScreenPoint, FDragImageOffset);

  DetermineHitTest(AHitContainer, AScreenPoint);
  DetermineDestinationItem;
  DetermineDestinationContainer(AHitContainer);

  ADestPoint := AHitContainer.ScreenToClient(AScreenPoint);
  DetermineAreaPart(ADestPoint);
  DetermineDestinationGroup;

(*
  if DestinationItem = nil then
    S := 'DestinationItem = nil; '
  else
    S := Format('DestinationItem = %s ($s); ', [DestinationItem.Name, DestinationItem.ClassName]);

  if DestinationGroup = nil then
    S := S + 'DestinationGroup = nil'
  else
    S := S + Format('DestinationGroup = %s ($s); ', [DestinationGroup.Name, DestinationGroup.ClassName]);

  if (DestinationItem is TdxLayoutGroup) and not TdxLayoutGroup(DestinationItem).IsRoot then
    FDestinationGroup := FDestinationGroup;

  with TdxLayoutItemInsertionCalculator.Create(Self{DestinationGroup}) do
  try
    AInfo := GetInsertionInfo(ADestPoint);
    AKind := AInfo.InsertionKind;
    AInfo.Free;
    //AKind := GetInsertionKind(AHitControl, DestinationItem, ADestPoint);

    //AInfo := GetInsertionInfoForEmptyArea(AHitControl, DestinationItem, AScreenPoint);
  finally
    Free;
  end;

  case AKind of
    ikNone: S := S + '; InsertionKind: ikNone';
    ikLeft: S := S + '; InsertionKind: ikLeft';
    ikTop: S := S + '; InsertionKind: ikTop';
    ikRight: S := S + '; InsertionKind: ikRight';
    ikBottom: S := S + '; InsertionKind: ikBottom';
    ikInside: S := S + '; InsertionKind: ikInside';
  end;
  Application.MainForm.Caption := S;
*)

end;

{ TdxLayoutDragAndDropController }

procedure TdxLayoutDragAndDropController.CreateDestinationImage;
var
  R: TRect;
begin
  if (DestinationItem = nil) or TdxCustomLayoutItemAccess(DestinationItem).IsAvailable or
      not TdxCustomLayoutItemAccess(DestinationItem).GetVisible or not DestinationGroup.ActuallyVisible then
    Exit;
  FDestinationImage := TcxDragImage.Create;
  FDestinationImage.PopupParent := GetParentForm(DestinationContainer.ItemsParent);
  R := DestinationGroup.ViewInfo.SelectionArea;
  cxRectIntersect(R, R, DestinationContainer.ClientRect);
  OffsetRect(R, -R.Left, -R.Top);
  FDestinationImage.SetBounds(R.Left, R.Top, R.Right, R.Bottom);
end;

procedure TdxLayoutDragAndDropController.DestroyDestinationImage;
begin
  FreeAndNil(FDestinationImage);
end;

procedure TdxLayoutDragAndDropController.DoDrop(ALayoutAction: TdxLayoutActionType);

  function GetOrthogonalDirection: TdxLayoutDirection;
  begin
    Result := TdxLayoutGroupAccess(DestinationItem.Parent).GetHelperClass.GetOrthogonalDirection;
  end;

  function IsHorizontalAreaPart: Boolean;
  begin
    Result := AreaPart in [apLeft, apRight, apAfter, apBefore];
  end;

  procedure DoInsert;
  begin
    SourceItem.Move(DestinationGroup, GetDestinationPosition, True);
  end;

  procedure DoCreateGroup;
  const
    LayoutDirections: array[Boolean] of TdxLayoutDirection = (ldVertical, ldHorizontal);
  var
    AParentGroup: TdxLayoutGroup;
  begin
    if DestinationItem.IsRoot then
    begin
      DestinationGroup.PutChildrenIntoHiddenGroup;
      DestinationGroup.LayoutDirection := LayoutDirections[IsHorizontalAreaPart];
      AParentGroup := DestinationGroup;
    end
    else
      AParentGroup := DestinationItem.PutIntoHiddenGroup(GetOrthogonalDirection);
    TdxLayoutGroupAccess(AParentGroup).BuildVisibleItemsList;
    SourceItem.Move(AParentGroup, GetDestinationPosition, True);
  end;

  procedure DoContentInsert;
  begin
    DestinationGroup.PutChildrenIntoHiddenGroup;
    DestinationGroup.LayoutDirection := GetOrthogonalDirection;
    SourceItem.Move(DestinationGroup, GetDestinationPosition, True);
  end;

begin
  case ALayoutAction of
    atInsert:
      DoInsert;
    atCreateGroup:
      DoCreateGroup;
    atContentInsert:
      DoContentInsert;
  end;
end;

function TdxLayoutDragAndDropController.GetDestinationPosition: Integer;
begin
  case AreaPart of
    apRight, apBottom, apAfter:
      if DestinationItem = DestinationGroup then
        Result := DestinationGroup.Count
      else
        Result := DestinationItem.Index + 1;
    apLeft, apTop, apBefore:
      if DestinationItem = DestinationGroup then
        Result := 0
      else
        Result := DestinationItem.Index;
    apLastChild:
      Result := DestinationGroup.Count;
  else
    Result := 0;
  end;
  if (SourceItem.Parent = DestinationGroup) and (SourceItem.Index < Result) then
    Dec(Result);
end;

procedure TdxLayoutDragAndDropController.PaintDestinationImage;
const
  ABorderWidth = 1;
var
  R: TRect;
  ATargetRect: TRect;
  AOffset: Integer;
begin
  FDestinationImage.Canvas.SaveState;
  try
    R := FDestinationImage.ClientRect;
    FDestinationImage.Canvas.FrameRect(R, dxLayoutDestinationBorderColor);
    InflateRect(R, -ABorderWidth, -ABorderWidth);
    FDestinationImage.Canvas.FillRect(R, dxLayoutDestinationColor);

    ATargetRect := TdxLayoutGroupViewInfoAccess(DestinationGroup.ViewInfo).GetAreaPartBounds(AreaPart, DestinationItem.ViewInfo);
    cxRectIntersect(R, DestinationGroup.ViewInfo.SelectionArea, DestinationContainer.ClientRect);
    with R do
      ATargetRect := cxRectOffset(ATargetRect, -Left, -Top);
    R := FDestinationImage.ClientRect;
    AOffset := ABorderWidth + 1;
    R := cxRectInflate(R, -AOffset, -AOffset);
    if cxRectWidth(ATargetRect) < cxRectHeight(ATargetRect) then
    begin
      if ATargetRect.Left < R.Left then
        ATargetRect := cxRectOffset(ATargetRect, R.Left - ATargetRect.Left, 0);
      if ATargetRect.Right > R.Right then
        ATargetRect := cxRectOffset(ATargetRect, R.Right - ATargetRect.Right, 0);
    end
    else
    begin
      if ATargetRect.Top < R.Top then
        ATargetRect := cxRectOffset(ATargetRect, 0, R.Top - ATargetRect.Top);
      if ATargetRect.Bottom > R.Bottom then
        ATargetRect := cxRectOffset(ATargetRect, 0, R.Bottom - ATargetRect.Bottom);
    end;

    FDestinationImage.Canvas.FrameRect(ATargetRect, dxLayoutDestinationBorderColor);
  finally
    FDestinationImage.Canvas.RestoreState;
  end;
  FNeedUpdateDestinationImage := False;
end;

procedure TdxLayoutDragAndDropController.UpdateDestinationImage;
var
  P: TPoint;
begin
  if (DestinationGroup = nil) or (DestinationItem = nil) then Exit;
  if (AreaPart = apNone) or (FHitTest.HitTestCode in dxCustomizeFormHitTestCodes) then Exit;

  PaintDestinationImage;
  if FDestinationImage.Visible then
    FDestinationImage.Invalidate
  else
  begin
    P := DestinationGroup.ViewInfo.SelectionArea.TopLeft;
    P.X := Max(P.X, DestinationContainer.ClientRect.Left);
    P.Y := Max(P.Y, DestinationContainer.ClientRect.Top);
    P := DestinationContainer.ClientToScreen(P);
    FDestinationImage.MoveTo(P);
    FDestinationImage.Show(SW_SHOWNOACTIVATE);
  end;
end;

{ TdxLayoutDragAndDropControllerEx }

procedure TdxLayoutDragAndDropControllerEx.CreateDestinationImage;
begin
  FDropPlaces := TdxLayoutItemDropPlaceWindows.Create;
end;

procedure TdxLayoutDragAndDropControllerEx.DestroyDestinationImage;
begin
  FreeAndNil(FDropPlaces);
end;

procedure TdxLayoutDragAndDropControllerEx.DoDrop(
  ALayoutAction: TdxLayoutActionType);
begin
  inherited;

end;

function TdxLayoutDragAndDropControllerEx.GetRect(const ABounds: TRect): TRect;
const
  ABorderWidth = 1;
var
  R: TRect;
  AOffset: Integer;
begin
  R := ABounds;
  InflateRect(R, -ABorderWidth, -ABorderWidth);
  Result := TdxLayoutGroupViewInfoAccess(DestinationGroup.ViewInfo).GetAreaPartBounds(AreaPart, DestinationItem.ViewInfo);
  cxRectIntersect(R, DestinationGroup.ViewInfo.SelectionArea, DestinationContainer.ClientRect);
  with R do
    Result := cxRectOffset(Result, -Left, -Top);
  R := ABounds;
  AOffset := ABorderWidth + 1;
  R := cxRectInflate(R, -AOffset, -AOffset);
  if cxRectWidth(Result) < cxRectHeight(Result) then
  begin
    if Result.Left < R.Left then
      Result := cxRectOffset(Result, R.Left - Result.Left, 0);
    if Result.Right > R.Right then
      Result := cxRectOffset(Result, R.Right - Result.Right, 0);
  end
  else
  begin
    if Result.Top < R.Top then
      Result := cxRectOffset(Result, 0, R.Top - Result.Top);
    if Result.Bottom > R.Bottom then
      Result := cxRectOffset(Result, 0, R.Bottom - Result.Bottom);
  end;
end;

function TdxLayoutDragAndDropControllerEx.GetScreenRect(const R: TRect): TRect;
begin
  Result.Left := Max(R.Left, DestinationContainer.ClientRect.Left);
  Result.Top := Max(R.Top, DestinationContainer.ClientRect.Top);
  Result.Right := Min(R.Right, DestinationContainer.ClientRect.Right);
  Result.Bottom := Min(R.Bottom, DestinationContainer.ClientRect.Bottom);
  Result.TopLeft := DestinationContainer.ClientToScreen(R.TopLeft);
  Result.BottomRight := DestinationContainer.ClientToScreen(R.BottomRight);
end;

procedure TdxLayoutDragAndDropControllerEx.UpdateDestinationImage;
const
  ABorderWidth = 1;
var
  ATargetRect, R: TRect;
//  AOffset: Integer;
  AGroup: TdxLayoutGroup;
  AItem: TdxCustomLayoutItem;
begin
  if (DestinationGroup = nil) or (DestinationItem = nil) or (AreaPart = apNone) or (FHitTest.HitTestCode in dxCustomizeFormHitTestCodes) then
    Exit;

    R := DestinationGroup.ViewInfo.Bounds;
    OffsetRect(R, -R.Left, -R.Top);

{
    FDestinationImage.Canvas.FrameRect(R, dxLayoutDestinationBorderColor);
    InflateRect(R, -ABorderWidth, -ABorderWidth);
    FDestinationImage.Canvas.FillRect(R, dxLayoutDestinationColor);

    ATargetRect := TdxLayoutGroupViewInfoAccess(DestinationGroup.ViewInfo).GetAreaPartBounds(AreaPart, DestinationItem.ViewInfo);
    cxRectIntersect(R, DestinationGroup.ViewInfo.SelectionArea, DestinationContainer.ClientRect);
    with R do
      ATargetRect := cxRectOffset(ATargetRect, -Left, -Top);
    R := FDestinationImage.ClientRect;
    AOffset := ABorderWidth + 1;
    R := cxRectInflate(R, -AOffset, -AOffset);
    if cxRectWidth(ATargetRect) < cxRectHeight(ATargetRect) then
    begin
      if ATargetRect.Left < R.Left then
        ATargetRect := cxRectOffset(ATargetRect, R.Left - ATargetRect.Left, 0);
      if ATargetRect.Right > R.Right then
        ATargetRect := cxRectOffset(ATargetRect, R.Right - ATargetRect.Right, 0);
    end
    else
    begin
      if ATargetRect.Top < R.Top then
        ATargetRect := cxRectOffset(ATargetRect, 0, R.Top - ATargetRect.Top);
      if ATargetRect.Bottom > R.Bottom then
        ATargetRect := cxRectOffset(ATargetRect, 0, R.Bottom - ATargetRect.Bottom);
    end;

}
    ATargetRect := TdxLayoutGroupViewInfoAccess(DestinationGroup.ViewInfo).GetAreaPartBounds(AreaPart, DestinationItem.ViewInfo);
//    cxRectIntersect(R, DestinationGroup.ViewInfo.SelectionArea, DestinationContainer.ClientRect);
//    with R do
//      ATargetRect := cxRectOffset(ATargetRect, -Left, -Top);
//
//    //R := FDestinationImage.ClientRect;
//    R := DestinationGroup.ViewInfo.Bounds;
//    OffsetRect(R, -R.Left, -R.Top);
//
//    AOffset := ABorderWidth + 1;
//    R := cxRectInflate(R, -AOffset, -AOffset);
//    if cxRectWidth(ATargetRect) < cxRectHeight(ATargetRect) then
//    begin
//      if ATargetRect.Left < R.Left then
//        ATargetRect := cxRectOffset(ATargetRect, R.Left - ATargetRect.Left, 0);
//      if ATargetRect.Right > R.Right then
//        ATargetRect := cxRectOffset(ATargetRect, R.Right - ATargetRect.Right, 0);
//    end
//    else
//    begin
//      if ATargetRect.Top < R.Top then
//        ATargetRect := cxRectOffset(ATargetRect, 0, R.Top - ATargetRect.Top);
//      if ATargetRect.Bottom > R.Bottom then
//        ATargetRect := cxRectOffset(ATargetRect, 0, R.Bottom - ATargetRect.Bottom);
//    end;


  FDropPlaces.Clear;
  AItem := DestinationItem;
  AGroup := DestinationGroup;
  while AGroup <> nil do
  begin
    ATargetRect := TdxLayoutGroupViewInfoAccess(AGroup.ViewInfo).GetAreaPartBounds(AreaPart, AItem.ViewInfo);
    ATargetRect := GetScreenRect(ATargetRect);
    FDropPlaces.Add(ATargetRect);
    AItem := AGroup;
    AGroup := AGroup.Parent;
  end;
  FDropPlaces.Visible := True;
end;

{ TdxLayoutItemInsertionPoint }

constructor TdxLayoutItemInsertionPoint.Create(AItem: TdxCustomLayoutItem;
  AIsInternalInsertion: Boolean);
begin
  inherited Create;
  FItem := AItem;
  FIsInternalInsertion := AIsInternalInsertion;
end;

function TdxLayoutItemInsertionPoint.Equals(AValue: TdxLayoutItemInsertionPoint): Boolean;
begin
  Result := (AValue <> nil) and
    (AValue.Item = Item) and (AValue.IsInternalInsertion = IsInternalInsertion);
end;

{ TdxLayoutItemInsertions }

function TdxLayoutItemInsertionPoints.Find(
  AItem: TdxCustomLayoutItem): TdxLayoutItemInsertionPoint;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Item = AItem then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxLayoutItemInsertionPoints.GetItem(Index: Integer): TdxLayoutItemInsertionPoint;
begin
  Result := TdxLayoutItemInsertionPoint(inherited Items[Index]);
end;

{ TdxLayoutItemInsertionInfo }

constructor TdxLayoutItemInsertionInfo.Create(
  ADestinationItem: TdxCustomLayoutItem;
  AInsertionKind: TdxLayoutItemInsertionKind;
  AInsertionPoint: TdxLayoutItemInsertionPoint);
begin
  inherited Create;
  FDestinationItem := ADestinationItem;
  FInsertionKind := AInsertionKind;
  FInsertionPoint := AInsertionPoint;
end;

function TdxLayoutItemInsertionInfo.Equals(
  AValue: TdxLayoutItemInsertionInfo): Boolean;
begin
  Result := (AValue <> nil) and (DestinationItem = AValue.DestinationItem) and
    (InsertionKind = AValue.InsertionKind) and (
    ((InsertionPoint = nil) and (AValue.InsertionPoint = nil)) or
    ((InsertionPoint <> nil) and (InsertionPoint.Equals(AValue.InsertionPoint))));
end;

{ TdxLayoutItemInsertionCalculator }


constructor TdxLayoutItemInsertionCalculator.Create(AController: TdxLayoutCustomDragAndDropController);
begin
  FController := AController;
//  FHorizontal := (AGroup = nil) or (AGroup.LayoutDirection = ldHorizontal);
end;

function TdxLayoutItemInsertionCalculator.GetItemAlignment(AItem: TdxCustomLayoutItem): TdxItemAlignment;
begin
  Result := iaStart;
  if Horizontal then
  begin
    case AItem.ViewInfo.AlignHorz of
      ahLeft:
        Result := iaStart;
      ahRight:
        Result := iaEnd;
      ahCenter:
        Result := iaCenter;
      ahClient:
        Result := iaStretch;
    end;
  end
  else
  begin
    case AItem.ViewInfo.AlignVert of
      avTop:
        Result := iaStart;
      avBottom:
        Result := iaEnd;
      avCenter:
        Result := iaCenter;
      avClient:
        Result := iaStretch;
    end;
  end;
end;

procedure TdxLayoutItemInsertionCalculator.ArrangeItems(AItems: TdxLayoutItems);
var
  ACenterAlignedItemCount, AEndAlignedItemCount, I: Integer;
  AItem: TdxCustomLayoutItem;
begin
  ACenterAlignedItemCount := 0;
  AEndAlignedItemCount := 0;
  I := 0;
  while I < AItems.Count - (ACenterAlignedItemCount + AEndAlignedItemCount)  do
  begin
     AItem := AItems[I];
     case GetItemAlignment(AItem) of
       iaCenter:
         begin
           AItems.Delete(I);
           AItems.Insert(AItems.Count - AEndAlignedItemCount, AItem);
           Inc(ACenterAlignedItemCount);
         end;
       iaEnd:
         begin
           AItems.Delete(I);
           AItems.Insert(AItems.Count, AItem);
           Inc(AEndAlignedItemCount);
         end
     else
       Inc(I);
     end;
  end;
end;

procedure TdxLayoutItemInsertionCalculator.CalculateInsertionInfoForEmptyArea(
  AGroup: TdxLayoutGroup; const ABounds: TRect; const P: TPoint;
  AItems: TdxLayoutItems; out AInsertionKind: TdxLayoutItemInsertionKind;
  out AInsertionPlace: TdxCustomLayoutItem);
var
  AItemAreaBounds, AItemBounds: TRect;
  I: Integer;
begin
  if (AItems.Count = 0) and cxRectPtIn(ABounds, P) then
  begin
    AInsertionKind := ikInside;
    AInsertionPlace := AGroup;
    Exit;
  end;
  ArrangeItems(AItems);
  AItemAreaBounds := ABounds;
  for I := 0 to AItems.Count - 1 do
  begin
    AItemBounds := AItems[I].ViewInfo.Bounds;
    if I < AItems.Count - 1 then
      if Horizontal then
        AItemAreaBounds.Right := AItemAreaBounds.Left + Max(0, (AItemBounds.Right + AItems[I + 1].ViewInfo.Bounds.Left) div 2)
      else
        AItemAreaBounds.Bottom := AItemAreaBounds.Top + Max(0, (AItemBounds.Bottom + AItems[I + 1].ViewInfo.Bounds.Top) div 2)
    else
      if Horizontal then
        AItemAreaBounds.Right := ABounds.Right
      else
        AItemAreaBounds.Bottom := ABounds.Bottom;
    if cxRectPtIn(AItemAreaBounds, P) then
    begin
      AInsertionPlace := AItems[I];
      AInsertionKind := GetInsertionKindForEmptyArea(AItemBounds, P);
      Exit;
    end;
    if Horizontal then
      AItemAreaBounds.Left := AItemAreaBounds.Right
    else
      AItemAreaBounds.Top := AItemAreaBounds.Bottom;
  end;
  AInsertionKind := ikNone;
  AInsertionPlace := nil;
end;

function TdxLayoutItemInsertionCalculator.GetHorizontal: Boolean;
begin
  Result := (Controller.DestinationItem is TdxLayoutGroup) and
    (TdxLayoutGroup(Controller.DestinationItem).LayoutDirection = ldHorizontal);
end;

function TdxLayoutItemInsertionCalculator.GetInsertionInfo(const P: TPoint): TdxLayoutItemInsertionInfo;
var
  AInsertionKind: TdxLayoutItemInsertionKind;
	ADestinationGroup, AParentGroup: TdxLayoutGroup;
begin
  if (Controller.DestinationItem = nil) then
  begin
    Result := TdxLayoutItemInsertionInfo.Create;
    Exit;
  end;

  AParentGroup := Controller.DestinationItem.Parent;
  if Controller.DestinationItem is TdxLayoutGroup then
    ADestinationGroup := TdxLayoutGroup(Controller.DestinationItem)
  else
    ADestinationGroup := nil;

  if AParentGroup = nil then
		AInsertionKind := ikNone
	else
		AInsertionKind := GetInsertionKind(AParentGroup, Controller.DestinationItem, P);

  if (Controller.DestinationItem = ADestinationGroup) or
    ((ADestinationGroup <> nil) and (AInsertionKind = ikNone)) then
    Result := GetInsertionInfoForEmptyArea(ADestinationGroup, P)
  else
  begin
//    LayoutItemInsertionPoint insertionPoint = parentGroup.GetInsertionPoint(element, destinationItem, insertionKind, p);
//    return new LayoutItemInsertionInfo(destinationItem, insertionKind, insertionPoint);
    Result := TdxLayoutItemInsertionInfo.Create();
//    Result := TdxLayoutItemInsertionInfo.Create(Controller.DestinationItem, AInsertionKind, Ai;

    Result.FInsertionKind := AInsertionKind;
  end;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionInfoForEmptyArea(
  AGroup: TdxLayoutGroup;
  const P: TPoint): TdxLayoutItemInsertionInfo;
var
  AInsertionPointElement: TdxCustomLayoutItem;
  AInsertionPoints: TdxLayoutItemInsertionPoints;
  AInsertionPoint: TdxLayoutItemInsertionPoint;
  AItems: TdxLayoutItems;
  I: Integer;
  R: TRect;
begin
  Result := TdxLayoutItemInsertionInfo.Create;
  AItems := TdxLayoutItems.Create;
  try
    for I := 0 to AGroup.Count - 1 do
      AItems.Add(AGroup.Items[I]);
    if AGroup.IsRoot then
      R := AGroup.Container.ILayout.GetClientBounds
    else
      R := AGroup.ViewInfo.ClientBounds;
    CalculateInsertionInfoForEmptyArea(AGroup, R, P,
      AItems, Result.FInsertionKind, AInsertionPointElement);
    Result.DestinationItem := AInsertionPointElement;
  finally
    AItems.Free;
  end;

  AInsertionPoints := TdxLayoutItemInsertionPoints.Create;
//  GetInsertionPoints(AControl, AItem, Result.DestinationItem, Result.DestinationItem,
//    Result.InsertionKind, AInsertionPoints);

  AInsertionPoint := AInsertionPoints.Find(AInsertionPointElement);
  if (AInsertionPoint = nil) and (AInsertionPoints.Count > 0) then
      AInsertionPoint := AInsertionPoints[AinsertionPoints.Count - 1];
  Result.InsertionPoint := AInsertionPoint;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionKind(AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem; const P: TPoint): TdxLayoutItemInsertionKind;
begin
  Result := ikNone;
  if ADestinationItem = AGroup then
    Exit;
  for Result := ikLeft to ikBottom do
    if cxRectPtIn(GetInsertionZoneBounds(AGroup, ADestinationItem, Result), P) then
      Break;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionKindForEmptyArea(
  const ABounds: TRect; const P: TPoint): TdxLayoutItemInsertionKind;

  procedure CheckHorizontalInsertionKinds(var AInsertionKind: TdxLayoutItemInsertionKind);
  begin
    if P.X < ABounds.Left then
      AInsertionKind := ikLeft;
    if P.X >= ABounds.Right then
      AInsertionKind := ikRight;
  end;

  procedure CheckVerticalInsertionKinds(var AInsertionKind: TdxLayoutItemInsertionKind);
  begin
    if P.Y < ABounds.Top then
      AInsertionKind := ikTop;
    if P.Y >= ABounds.Bottom then
      AInsertionKind := ikBottom;
  end;

begin
  Result := ikNone;
  if Horizontal then
  begin
    CheckVerticalInsertionKinds(Result);
    CheckHorizontalInsertionKinds(Result);
  end
  else
  begin
    CheckHorizontalInsertionKinds(Result);
    CheckVerticalInsertionKinds(Result);
  end;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionPoint(
  AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem;
  AInsertionKind: TdxLayoutItemInsertionKind;
  const P: TPoint): TdxLayoutItemInsertionPoint;
var
  AInsertionPoints: TdxLayoutItemInsertionPoints;
  I: Integer;
begin
  Result := nil;
  AInsertionPoints := TdxLayoutItemInsertionPoints.Create;
  GetInsertionPoints(AGroup, ADestinationItem, AInsertionKind, AInsertionPoints);
  for I := 0 to AInsertionPoints.Count - 1 do
//    if cxRectPtIn(GetInsertionPointZoneBounds(ADestinationItem, AInsertionKind, I,
//      AInsertionPoints.Count), P) then
//   begin
//     Result := AInsertionPoints[I];
//     Break;
//   end;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionPoints(
  AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem;
  AInsertionKind: TdxLayoutItemInsertionKind;
  AInsertionPoints: TdxLayoutItemInsertionPoints): TdxLayoutItemInsertionPoint;
begin
  Result := nil;
end;

function TdxLayoutItemInsertionCalculator.IsInsertionPoint(
  AControl: TdxLayoutControl; AItem, ADestinationItem,
  AOriginalDestinationItem: TdxCustomLayoutItem;
  AInsertionKind: TdxLayoutItemInsertionKind): Boolean;
begin
  if ADestinationItem = AItem then
  begin
    Result := False;
    Exit;
  end;
  if (AInsertionKind = ikInside) and (ADestinationItem is TdxLayoutGroup) then
  begin
    Result := True;
    Exit;
  end;
//  if (control.CollapseMode != LayoutGroupCollapseMode.None)
//      return true;
  if AInsertionKind in [ikNone, ikInside] then
  begin
    Result := False;
    Exit;
  end;

  Result := True;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionZoneBounds(ABounds, AContentBounds: TRect; AInsertionKind: TdxLayoutItemInsertionKind): TRect;
const
  dxRelativeZoneWidth = 0.25;
var
  AZoneWidth: Integer;
begin
  if AInsertionKind = ikInside then
  begin
    if cxRectIsEmpty(AContentBounds) then
      Result := ABounds
    else
      Result := AContentBounds;
    Exit;
  end;
  if AInsertionKind in [ikNone, ikInside] then
  begin
    Result := cxNullRect;
    Exit;
  end;

  Result := ABounds;
  if cxRectWidth(Result) > cxRectHeight(Result) then
  begin
    if cxRectIsEmpty(AContentBounds) then
    begin
      AZoneWidth := Trunc(dxRelativeZoneWidth * cxRectWidth(ABounds));
      AContentBounds := cxRectBounds(ABounds.Left + AZoneWidth,
        Trunc((ABounds.Top + ABounds.Bottom) / 2),
        cxRectWidth(ABounds) - 2 * AZoneWidth,
        0);
    end;
    if AInsertionKind = ikLeft then
      Result.Right := Max(Result.Left, AContentBounds.Left)
    else
      if AInsertionKind = ikRight then
        Result.Left := Min(Result.Right, AContentBounds.Right)
      else
      begin
        Result.Left := AContentBounds.Left;
        Result := cxRectSetWidth(Result, cxRectWidth(AContentBounds));
        if AInsertionKind = ikTop then
          Result.Bottom := Max(Result.Top, AContentBounds.Top)
        else
          Result.Top := Min(Result.Bottom, AContentBounds.Bottom);
      end;
  end
  else
  begin
    if cxRectIsEmpty(AContentBounds) then
    begin
      AZoneWidth := Trunc(dxRelativeZoneWidth * cxRectHeight(ABounds));
      AContentBounds := cxRectBounds(Trunc((ABounds.Left + ABounds.Right) / 2),
        ABounds.Top + AZoneWidth,
        0,
        cxRectHeight(ABounds) - 2 * AZoneWidth);
    end;
    if AInsertionKind = ikTop then
      Result.Bottom := Max(Result.Top, AContentBounds.Top)
    else
      if AInsertionKind = ikBottom then
        Result.Top := Min(Result.Bottom, AContentBounds.Bottom)
      else
      begin
        Result.Top := AContentBounds.Top;
        Result := cxRectSetHeight(Result, cxRectHeight(AContentBounds));
        if AInsertionKind = ikLeft then
          Result.Right := Max(Result.Left, AContentBounds.Left)
        else
          Result.Left := Min(Result.Right, AContentBounds.Right);
      end;
  end;
end;

function TdxLayoutItemInsertionCalculator.GetInsertionZoneBounds(
  AGroup: TdxLayoutGroup; ADestinationItem: TdxCustomLayoutItem;
  AInsertionKind: TdxLayoutItemInsertionKind): TRect;
var
  ABounds, AContentBounds: TRect;
begin
  AContentBounds := cxNullRect;
  if (AGroup <> nil) and (AGroup = ADestinationItem) then
  begin
    if AGroup.IsRoot then
      AContentBounds := AGroup.Container.ILayout.GetClientBounds
    else
      AContentBounds := TdxLayoutGroupViewInfo(AGroup.ViewInfo).ClientBounds;
  end;
  ABounds := ADestinationItem.ViewInfo.Bounds;
  Result := GetInsertionZoneBounds(ABounds, AContentBounds, AInsertionKind);
end;

{ TdxLayoutItems }

function TdxLayoutItems.GetItem(Index: Integer): TdxCustomLayoutItem;
begin
  Result := TdxCustomLayoutItem(inherited Items[Index]);
end;

initialization
  Screen.Cursors[crdxLayoutControlNoDrop] := LoadCursor(HInstance, 'DXLAYOUTCONTROLNODROP');
  Screen.Cursors[crdxLayoutControlRemove] := LoadCursor(HInstance, 'DXLAYOUTCONTROLREMOVE');

end.
