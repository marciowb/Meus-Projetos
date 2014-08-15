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
  Classes, Controls, Windows, Graphics,
  cxClasses, cxControls, cxGraphics, dxLayoutControl;

type
  TdxLayoutDragSource = (dsControl, dsCustomizeFormAvailableItems, dsCustomizeFormTreeViewItems);

  { TdxLayoutDragAndDropObject }

  TdxLayoutCustomDragAndDropObject = class(TcxDragAndDropObject)
  private
    FSourceItem: TdxCustomLayoutItem;
    FStartDragPoint: TPoint;
    function GetSourceControl: TdxCustomLayoutControl;
  protected
    procedure Modified;
    property SourceControl: TdxCustomLayoutControl read GetSourceControl;
  public
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); virtual;
    property SourceItem: TdxCustomLayoutItem read FSourceItem write FSourceItem;
  end;

  TdxLayoutDragAndDropObject = class(TdxLayoutCustomDragAndDropObject)
  private
    FAreaPart: TdxLayoutAreaPart;
    FDragImage: TcxDragImage;
    FDragImageOffset: TPoint;
    FDragImagePoint: TPoint;
    FDestinationControl: TdxCustomLayoutControl;
    FDestinationGroup: TdxLayoutGroup;
    FDestinationImage: TcxDragImage;
    FDestinationItem: TdxCustomLayoutItem;
    FHitTest: TdxCustomLayoutHitTest;
    FNeedRepaintDestinationImage: Boolean;
    FSource: TdxLayoutDragSource;
    FSourceItemBounds: TRect;

    procedure ResetDragAndDropObjects;
    procedure SetAreaPart(Value: TdxLayoutAreaPart);
    procedure SetDestinationControl(Value: TdxCustomLayoutControl);
    procedure SetDestinationGroup(Value: TdxLayoutGroup);
    procedure SetDestinationItem(Value: TdxCustomLayoutItem);
  protected
    procedure CreateDragImage;
    procedure CreateDestinationImage;
    procedure DirtyChanged; override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;

    procedure PaintDestinationImage;
    procedure PaintDragImage;
    procedure RefreshDestinationImage;
    procedure ShowDragImage;

    procedure UpdateStates;

    property AreaPart: TdxLayoutAreaPart read FAreaPart write SetAreaPart;
    property DestinationControl: TdxCustomLayoutControl read FDestinationControl write SetDestinationControl;
    property DestinationGroup: TdxLayoutGroup read FDestinationGroup write SetDestinationGroup;
    property DestinationItem: TdxCustomLayoutItem read FDestinationItem write SetDestinationItem;
    property Source: TdxLayoutDragSource read FSource write FSource;
    property SourceItemBounds: TRect read FSourceItemBounds;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;

    function CanDrop: Boolean;
    function CanRemove: Boolean;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); override;
  end;

  { TdxLayoutDragAndDropObject }

  TdxLayoutCustomSizingDragAndDropObject = class(TdxLayoutCustomDragAndDropObject)
  protected
    procedure RestoreSize; virtual;
  public
    procedure EndDragAndDrop(Accepted: Boolean); override;
  end;

  TdxLayoutSizingDragAndDropObject = class(TdxLayoutCustomSizingDragAndDropObject) // cxinplaceContainer.TcxSizingDragAndDropObject
  private
    FOriginalBounds: TRect;
    FOriginalSize: TSize;
    FMarkerIndex: Integer;
  protected
    procedure RestoreSize; override;
  public
    constructor Create(AControl: TcxControl); override;
    destructor Destroy; override;

    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint); override;
  end;

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

  TdxLayoutHSplitterDragAndDropObject = class(TdxLayoutSplitterDragAndDropObject)
  protected
    function GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; override;
    function GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetSignificantValue(const P: TPoint): Integer; override;
    procedure SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer); override;
  end;

  TdxLayoutVSplitterDragAndDropObject = class(TdxLayoutSplitterDragAndDropObject)
  protected
    function GetWorkAlign(AViewInfo: TdxCustomLayoutItemViewInfo): TdxLayoutAlignHorz; override;
    function GetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo): Integer; override;
    function GetSignificantValue(const P: TPoint): Integer; override;
    procedure SetItemSize(AViewInfo: TdxCustomLayoutItemViewInfo; ASize: Integer); override;
  end;

  { TdxLayoutDragAndDropHelper }

  TdxLayoutDragAndDropHelper = class(TdxLayoutControlPersistent)
  private
    FDragItem: TdxCustomLayoutItem;
    FMouseDownPos: TPoint;
    procedure BeginDragAndDrop(ASource: TdxLayoutDragSource);
    function CanBeginDragAndDrop(X, Y: Integer): Boolean;
    function GetDragAndDropObject: TdxLayoutDragAndDropObject;
  protected
    property DragAndDropObject: TdxLayoutDragAndDropObject read GetDragAndDropObject;
  public
    constructor Create(AControl: TdxCustomLayoutControl); override;

    procedure InitializeDragItem(AItem: TdxCustomLayoutItem; X, Y: Integer);
    procedure Reset;
    procedure TryBeginDragAndDrop(X, Y: Integer; ASource: TdxLayoutDragSource);

    property DragItem: TdxCustomLayoutItem read FDragItem;
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
  TdxCustomLayoutControlAccess = class(TdxCustomLayoutControl);
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxLayoutSizeOptionsAccess = class(TdxLayoutSizeOptions);
  TdxLayoutGroupAccess = class(TdxLayoutGroup);
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxLayoutGroupViewInfoAccess = class(TdxLayoutGroupViewInfo);
  TdxLayoutControlViewInfoAccess = class(TdxLayoutControlViewInfo);
  TdxCustomLayoutItemPainterAccess = class(TdxCustomLayoutItemPainter);
  TdxUndoRedoManagerAccess = class(TdxUndoRedoManager);

function dxLayoutDragAndDropObject: TdxLayoutDragAndDropObject;
begin
  Result := FLayoutDragAndDropObject;
end;

function dxLayoutSizingDragAndDropObject: TdxLayoutSizingDragAndDropObject;
begin
  Result := FLayoutSizingDragAndDropObject;
end;

{ TdxLayoutCustomDragAndDropObject }

procedure TdxLayoutCustomDragAndDropObject.Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint);
begin
  FSourceItem := ASourceItem;
  FStartDragPoint := P;
end;

procedure TdxLayoutCustomDragAndDropObject.Modified;
begin
  TdxCustomLayoutControlAccess(SourceControl).Modified;
end;

function TdxLayoutCustomDragAndDropObject.GetSourceControl: TdxCustomLayoutControl;
begin
  Result := inherited Control as TdxCustomLayoutControl;
end;

{ TdxLayoutDragAndDropObject }

constructor TdxLayoutDragAndDropObject.Create(AControl: TcxControl);
begin
  inherited;
  FLayoutDragAndDropObject := Self;
end;

destructor TdxLayoutDragAndDropObject.Destroy;
begin
  FLayoutDragAndDropObject := nil;
  inherited;
end;

function TdxLayoutDragAndDropObject.CanDrop: Boolean;
begin
  Result := (DestinationGroup <> nil) and SourceItem.CanMoveTo(DestinationGroup) and
    not TdxLayoutGroupAccess(DestinationGroup).IsLocked;

//  (DestinationItem <> nil) or (FHitTest.HitTestCode in
  //  [htClientArea, htGroup, htItem]);
end;

function TdxLayoutDragAndDropObject.CanRemove: Boolean;
begin
  Result := (FHitTest.HitTestCode in [htAvailableItems, htNone]) and
    TdxCustomLayoutItemAccess(SourceItem).CanRemove and (SourceItem.Parent <> nil);
end;

procedure TdxLayoutDragAndDropObject.ResetDragAndDropObjects;
begin
  SourceItem := nil;
  DestinationItem := nil;
  DestinationGroup := nil;
  FHitTest := nil;
  TdxCustomLayoutControlAccess(SourceControl).CustomizeFormPostUpdate([cfutDragAndDropState]);
end;

procedure TdxLayoutDragAndDropObject.SetAreaPart(Value: TdxLayoutAreaPart);
begin
  if FAreaPart <> Value then
  begin
    FAreaPart := Value;
    Dirty := True;
  end;
end;

procedure TdxLayoutDragAndDropObject.SetDestinationControl(Value: TdxCustomLayoutControl);
begin
  if FDestinationControl <> Value then
  begin
    FDestinationControl := Value;
    Dirty := True;
  end;
end;

procedure TdxLayoutDragAndDropObject.SetDestinationGroup(Value: TdxLayoutGroup);
begin
  if FDestinationGroup <> Value then
  begin
    if FDestinationGroup <> nil then
      FreeAndNil(FDestinationImage);
    FDestinationGroup := Value;
    if FDestinationGroup <> nil then
      CreateDestinationImage;
    Dirty := True;
  end;
end;

procedure TdxLayoutDragAndDropObject.SetDestinationItem(Value: TdxCustomLayoutItem);
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
    Dirty := True;
  end;
end;


procedure TdxLayoutDragAndDropObject.CreateDragImage;
begin
  FDragImage := TcxDragImage.Create;
  PaintDragImage;
end;

procedure TdxLayoutDragAndDropObject.CreateDestinationImage;
var
  R: TRect;
begin
  if (DestinationItem = nil) or TdxCustomLayoutItemAccess(DestinationItem).IsAvailable or
      not TdxCustomLayoutItemAccess(DestinationItem).GetVisible or not DestinationGroup.ActuallyVisible then
    Exit;
  FDestinationImage := TcxDragImage.Create;
  FDestinationImage.PopupParent := GetParentForm(DestinationControl);
  R := DestinationGroup.ViewInfo.SelectionArea;
  cxRectIntersect(R, R, DestinationControl.ClientRect);
  OffsetRect(R, -R.Left, -R.Top);
  FDestinationImage.SetBounds(R.Left, R.Top, R.Right, R.Bottom);
end;

procedure TdxLayoutDragAndDropObject.DirtyChanged;
begin
  inherited DirtyChanged;
  FNeedRepaintDestinationImage := True;
end;

function TdxLayoutDragAndDropObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if CanDrop then
    Result := crDefault
  else
    if CanRemove then
      Result := crdxLayoutControlRemove
    else
      Result := crdxLayoutControlNoDrop;
end;

procedure TdxLayoutDragAndDropObject.PaintDestinationImage;
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
    cxRectIntersect(R, DestinationGroup.ViewInfo.SelectionArea, DestinationControl.ClientRect);
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
  FNeedRepaintDestinationImage := False;
end;

procedure TdxLayoutDragAndDropObject.PaintDragImage;
var
  AViewInfo: TdxCustomLayoutItemViewInfo;

  function GetItemDragBounds: TRect;
  begin
    Result := AViewInfo.SelectionBorderRect;
  end;

  procedure CalculateDragImageOffset;
  begin
{#DG
    if Source = dsControl then
      FDragImageOffset := cxPointOffset(GetItemDragBounds.TopLeft,
        SourceControl.ScreenToClient(FStartDragPoint), False)
    else
    }
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
    AViewInfo := TdxCustomLayoutItemAccess(SourceItem).GetViewInfoClass.Create(SourceControl.ViewInfo, nil, SourceItem);
    ANeedDestroyViewInfo := True;
  end
  else
  begin
    AViewInfo := SourceItem.ViewInfo;
    ANeedDestroyViewInfo := False;
    APrevBounds := AViewInfo.Bounds;
  end;
  try
    APrevHasBorder := TdxCustomLayoutItemViewInfoAccess(SourceItem.ViewInfo).HasBorder;
    TdxLayoutControlViewInfoAccess(SourceControl.ViewInfo).IsDragImagePainted := True;
    try
      AViewInfo.Calculate(GetViewInfoBounds(TdxCustomLayoutItemViewInfoAccess(SourceItem.ViewInfo).HasBorder <> APrevHasBorder));

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
      TdxLayoutControlViewInfoAccess(SourceControl.ViewInfo).IsDragImagePainted := False;
    end;
  finally
    if ANeedDestroyViewInfo then
      AViewInfo.Destroy
    else
      AViewInfo.Calculate(APrevBounds);
  end;
end;

procedure TdxLayoutDragAndDropObject.RefreshDestinationImage;
var
  P: TPoint;
begin
  if (DestinationGroup = nil) or (DestinationItem = nil) or (AreaPart = apNone) or (FHitTest.HitTestCode in dxCustomizeFormHitTestCodes) then
    Exit;
  PaintDestinationImage;
  if FDestinationImage.Visible then
    FDestinationImage.Invalidate
  else
  begin
    P := DestinationGroup.ViewInfo.SelectionArea.TopLeft;
    P.X := Max(P.X, DestinationControl.ClientRect.Left);
    P.Y := Max(P.Y, DestinationControl.ClientRect.Top);
    P := DestinationControl.ClientToScreen(P);

    FDestinationImage.MoveTo(P);
    FDestinationImage.Show(SW_SHOWNOACTIVATE);
  end;
end;

procedure TdxLayoutDragAndDropObject.ShowDragImage;
begin
  if FDragImage <> nil then
  begin
    FDragImage.MoveTo(FDragImagePoint);
    FDragImage.Show;
  end;
end;

procedure TdxLayoutDragAndDropObject.UpdateStates;

  function FindDestLayoutControl(const P: TPoint): TdxCustomLayoutControl;
  var
    AControl: TWinControl;
    AWnd: THandle;
  begin
    Result := nil;
    if SourceControl.IsDesigning then
    begin
      AWnd := cxWindowFromPoint(P);
      while (Result = nil) and (AWnd <> 0) do
      begin
        AControl := FindControl(AWnd);
        if (AControl is TdxCustomLayoutControl) and (AControl.Owner = SourceControl.Owner) and
          TdxCustomLayoutControlAccess(AControl).AllowDrop then
          Result := TdxLayoutControl(AControl);
        AWnd := GetAncestor(AWnd, GA_PARENT);
      end;
    end;
    if Result = nil then
      Result := SourceControl;
  end;

  procedure DetermineDestinationControl(AHitControl: TdxCustomLayoutControl);
  begin
    if DestinationItem = nil then
      DestinationControl := AHitControl
    else
      DestinationControl := DestinationItem.Container;
  end;

  procedure DetermineDestinationItem;
  var
    ADestinationItem: TdxCustomLayoutItem;
  begin
    // DetermineDestinationItems(ADestItems);
    // UpdatedestinationPlaces(AScreenPoint, ADestItems, ADestinationItem);

    ADestinationItem := FHitTest.GetDestinationItem;
    if (ADestinationItem = SourceItem) or
        ((ADestinationItem is TdxLayoutGroup) and not SourceItem.CanMoveTo(ADestinationItem)) then
      ADestinationItem := nil;
    DestinationItem := ADestinationItem;

    if (DestinationItem <> nil) and (DestinationItem.Container <> DestinationControl) then
      DestinationControl := DestinationItem.Container;
  end;

  procedure DetermineAreaPart(const P: TPoint);
  const
    CustomizeFormTreeViewItemAreaPart: array [TdxLayoutDirection] of TdxLayoutAreaPart = (apRight, apBottom, apBottom);
  var
    AAreaPart: TdxLayoutAreaPart;
  begin
    AAreaPart := apNone;
    if FHitTest.IsDeterminedAreaPart then
      AAreaPart := FHitTest.GetAreaPart
    else
      if (DestinationItem <> nil) then
        AAreaPart := TdxCustomLayoutItemViewInfoAccess(DestinationItem.ViewInfo).GetAreaPart(P);
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

  procedure DetermineHitTest(AHitControl: TdxCustomLayoutControl; const P: TPoint);
  begin
    FHitTest := AHitControl.GetHitTest(AHitControl.ScreenToClient(P));
  end;

var
  AScreenPoint, ADestPoint: TPoint;
  AHitControl: TdxCustomLayoutControl;
begin
  AScreenPoint := GetMouseCursorPos;
  AHitControl := FindDestLayoutControl(AScreenPoint);
  FDragImagePoint := cxPointOffset(AScreenPoint, FDragImageOffset);

  DetermineHitTest(AHitControl, AScreenPoint);
  DetermineDestinationItem;
  DetermineDestinationControl(AHitControl);
  ADestPoint := DestinationControl.ScreenToClient(AScreenPoint);
  DetermineAreaPart(ADestPoint);
  DetermineDestinationGroup;
end;

procedure TdxLayoutDragAndDropObject.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
//#DG  SourceItem.SelectComponent([]);
  TdxCustomLayoutControlAccess(SourceControl).DragAndDropBegan;
  CreateDragImage;
end;

procedure TdxLayoutDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);

  procedure UpdateDestinationImageState;
  begin
    if FNeedRepaintDestinationImage then
      RefreshDestinationImage;
  end;

begin
  UpdateStates;
  ShowDragImage;
  Accepted := AreaPart <> apNone;
  UpdateDestinationImageState;
  inherited;
end;

procedure TdxLayoutDragAndDropObject.EndDragAndDrop(Accepted: Boolean);

  function GetDestPosition: Integer;
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

  function GetLayoutDirection: TdxLayoutDirection;
  begin
    Result := DestinationGroup.LayoutDirection;
  end;

  function GetOrthogonalDirection: TdxLayoutDirection;
  begin
    Result := TdxLayoutGroupAccess(DestinationItem.Parent).GetHelperClass.GetOrthogonalDirection;
  end;

  function IsHorizontalAreaPart: Boolean;
  begin
    Result := AreaPart in [apLeft, apRight, apAfter, apBefore];
  end;

  function IsVerticalAreaPart: Boolean;
  begin
    Result := AreaPart in [apTop, apBottom, apAfter, apBefore];
  end;

  procedure DoInsert;
  begin
    SourceItem.Move(DestinationGroup, GetDestPosition, True);
  end;

  procedure DoCreateGroup;
  const
    LayoutDirections: array[Boolean] of TdxLayoutDirection =
      (ldVertical, ldHorizontal);
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
    SourceItem.Move(AParentGroup, GetDestPosition, True);
  end;

  procedure DoContentInsert;
  begin
    DestinationGroup.PutChildrenIntoHiddenGroup;
    DestinationGroup.LayoutDirection := GetOrthogonalDirection;
    SourceItem.Move(DestinationGroup, GetDestPosition, True);
  end;

  function CanProcessDrop: Boolean;
  begin
    Result := Accepted and (DestinationControl <> nil) and ((CanDrop and (DestinationItem <> nil)) or CanRemove);
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
  Dirty := True;
  if CanProcessDrop then
  begin
    TdxCustomLayoutControlAccess(DestinationControl).SaveToUndo;
    DestinationControl.BeginUpdate;
    TdxCustomLayoutControlAccess(SourceControl).SaveToUndo;
    SourceControl.BeginUpdate;
    try
      if CanDrop and (DestinationGroup <> nil) then
        case GetActionType(AreaPart) of
          atInsert:
            DoInsert;
          atCreateGroup:
            DoCreateGroup;
          atContentInsert:
            DoContentInsert;
        end
      else
        if CanRemove then
          SourceItem.Parent := nil;
    finally
      ALinkSelf := cxAddObjectLink(SourceItem);
      try
        ResetDragAndDropObjects;
        SourceControl.EndUpdate;
        DestinationControl.EndUpdate;
        if ALinkSelf.Ref <> nil then
          (ALinkSelf.Ref as TdxCustomLayoutItem).MakeVisible;
      finally
        cxRemoveObjectLink(ALinkSelf);
      end;
    end;
    SourceControl.Update;
    if DestinationControl <> SourceControl then
      DestinationControl.Update;
    Modified;
  end
  else
    ResetDragAndDropObjects;
  inherited;
end;

procedure TdxLayoutDragAndDropObject.Init(ASource: TdxLayoutDragSource; ASourceItem: TdxCustomLayoutItem; const P: TPoint);
begin
  inherited;
  SourceControl.Update;
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
  inherited;
  FLayoutSizingDragAndDropObject := Self;
end;

destructor TdxLayoutSizingDragAndDropObject.Destroy;
begin
  FLayoutSizingDragAndDropObject := nil;
  inherited;
end;

procedure TdxLayoutSizingDragAndDropObject.BeginDragAndDrop;
begin
  inherited;
  if not Control.IsDesigning then
    TdxCustomLayoutControlAccess(Control).SaveToUndo;
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

  if FMarkerIndex in [0, 6, 7] then
    SourceItem.Width := cxRectWidth(FOriginalBounds) + XC * (FStartDragPoint.X - P.X);
  if FMarkerIndex in [2, 3, 4] then
    SourceItem.Width := cxRectWidth(FOriginalBounds) + XC * (P.X - FStartDragPoint.X);
  if FMarkerIndex in [0, 1, 2] then
    SourceItem.Height := cxRectHeight(FOriginalBounds) + YC * (FStartDragPoint.Y - P.Y);
  if FMarkerIndex in [4, 5, 6] then
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
    TdxCustomLayoutControlAccess(Control).CancelLastUndo;
end;

{ TdxLayoutSplitterDragAndDropObject }

procedure TdxLayoutSplitterDragAndDropObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
var
  ANewLeftItemSize, ANewRightItemSize: Integer;
begin
  if not cxPointIsEqual(FPrevPoint, P) then
  begin
    FPrevPoint := P;
    ANewLeftItemSize := FLeftItemSize + (GetSignificantValue(P) - GetSignificantValue(FStartDragPoint));
    ANewRightItemSize := FRightItemSize + (GetSignificantValue(FStartDragPoint) - GetSignificantValue(P));
    case FSizingStrategy of
      lssLeft:
        if ANewLeftItemSize > 0 then
        begin
          SetItemSize(FLeftItem.ViewInfo, ANewLeftItemSize);
          SourceControl.Update;
        end;
      lssRight:
        if ANewRightItemSize > 0 then
        begin
          SetItemSize(FRightItem.ViewInfo, ANewRightItemSize);
          SourceControl.Update;
        end;
      lssClient:
        if (ANewLeftItemSize > 0) and (ANewRightItemSize > 0) then
        begin
          SourceControl.BeginUpdate;
          try
            SetItemSize(FLeftItem.ViewInfo, ANewLeftItemSize);
            SetItemSize(FRightItem.ViewInfo, ANewRightItemSize);
          finally
            SourceControl.CancelUpdate;
          end;
          TdxLayoutSizeOptionsAccess(FLeftItem.SizeOptions).Changed;
          SourceControl.Update;
        end;
    end;
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
    SourceControl.BeginUpdate;
    try
      for I := 0 to FParentItem.VisibleCount - 1 do
        if GetWorkAlign(FParentItem.VisibleItems[I].ViewInfo) = ahClient then
          SetItemSize(FParentItem.VisibleItems[I].ViewInfo, GetItemSize(FParentItem.VisibleItems[I].ViewInfo));
    finally
      SourceControl.CancelUpdate;
    end;
  end;

  FPrevPoint := P;
end;

procedure TdxLayoutSplitterDragAndDropObject.RestoreSize;
var
  I: Integer;
begin
  SourceControl.BeginUpdate;
  try
    for I := 0 to FParentItem.VisibleCount - 1 do
      SetItemSize(FParentItem.VisibleItems[I].ViewInfo, GetSignificantValue(FOriginalSizes[I]));
  finally
    SourceControl.EndUpdate(False);
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

constructor TdxLayoutDragAndDropHelper.Create(
  AControl: TdxCustomLayoutControl);
begin
  inherited Create(AControl);
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
  Result := TdxCustomLayoutControlAccess(Control).CanDragAndDrop and (Control.DragAndDropState = ddsNone) and
    not cxPointIsEqual(FMouseDownPos, cxInvalidPoint) and not IsPointInDragDetectArea(FMouseDownPos, X, Y) and
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

initialization
  Screen.Cursors[crdxLayoutControlNoDrop] := LoadCursor(HInstance, 'DXLAYOUTCONTROLNODROP');
  Screen.Cursors[crdxLayoutControlRemove] := LoadCursor(HInstance, 'DXLAYOUTCONTROLREMOVE');

end.
