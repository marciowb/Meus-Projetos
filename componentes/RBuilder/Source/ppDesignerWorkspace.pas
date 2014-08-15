{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                    BBBBB   }                                              

unit ppDesignerWorkspace;

interface

{$I ppIfDef.pas}

{x$DEFINE CodeSite}

uses
{$IFDEF CodeSite}
  csIntf,
{$ENDIF}
  Windows,
  Messages,

  Classes,
  Controls,
  ExtCtrls,
  Graphics,
  Menus,
  Types,
  Variants,
  SysUtils,

  ppCollectionBase,
  ppTypes,
  ppUtils,
  ppClass,
  ppRTTI,
  ppComm,
  ppIniStorage,
  ppDesignEventHub;

type

  TppWorkspace = class;

  TppDesignGuideType = (dgLeft, dgRight, dgTop, dgBottom);
  TppDesignGuideTypes = set of TppDesignGuideType;

  {TppDesignGuide }
  TppDesignGuide = class
  private
    FBeginPoint: TPoint;
    FCanvas: TCanvas;
    FEndPoint: TPoint;
    FVisible: Boolean;
    FBackImage: TBitmap;
    FUpdateCounter: Integer;

    procedure SetBeginPoint(const Value: TPoint);
    procedure SetEndPoint(const Value: TPoint);
    procedure SetVisible(const Value: Boolean);
    
  protected
    procedure RestoreBackgroundImage;
    procedure SaveBackgroundImage;

  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;

    procedure Erase;
    procedure Paint;

    property BeginPoint: TPoint read FBeginPoint write SetBeginPoint;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property EndPoint: TPoint read FEndPoint write SetEndPoint;
    property Visible: Boolean read FVisible write SetVisible;
  end;


  {TppDesignGuideCollection}
  TppDesignGuideCollection = class(TppCollectionBase)
  private
    FLeft: TppDesignGuide;
    FBottom: TppDesignGuide;
    FTop: TppDesignGuide;
    FRight: TppDesignGuide;
    FCanvas: TCanvas;

    procedure SetCanvas(const Value: TCanvas);

  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Erase;
    procedure Paint;

    property Left: TppDesignGuide read FLeft;
    property Bottom: TppDesignGuide read FBottom;
    property Top: TppDesignGuide read FTop;
    property Right: TppDesignGuide read FRight;
    property Canvas: TCanvas read FCanvas write SetCanvas;

  end;


  {TppBoundsRect }
  TppBoundsRect = class(TObject)
  private
    FBoundsLocks: TppBoundsLockStates;
    FOldSize: TppSizeRect;
    FCanvas: TCanvas;
    FVisible: Boolean;
    FObjectHeight: Longint;
    FObjectLeft: Longint;
    FObjectWidth: Longint;
    FObjectTop: Longint;
    FSize: TppSizeRect;
    FParent: TWinControl;
    FBeginDrag: Boolean;
    FStartDragPos: TPoint;
    FBackImage: TBitmap;
    FZOrder: Integer;

    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;

    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetVisible(const Value: Boolean);

    procedure UpdateOldSize;
    function GetBoundsRect: TRect;
    procedure RestoreBackgroundImage;

  protected
    procedure SetParent(aParent: TWinControl); virtual;

  public
    constructor Create(aOwner: TComponent); virtual;
    destructor Destroy; override;

    procedure Assign(Source: TObject);
    procedure Paint; virtual;
    procedure Erase;
    procedure Redraw;
    procedure SaveBackgroundImage;

    procedure SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
    procedure SetObjectBounds(aLeft, aTop, aWidth, aHeight: Integer);
    procedure Move(aX, aY: Integer);
    procedure MoveBy(aX, aY: Integer);

    procedure BeginDrag;
    procedure EndDrag;


    property Parent: TWinControl read FParent write SetParent;

    property Size: TppSizeRect read FSize write FSize;
    property BoundsRect: TRect read GetBoundsRect;

    property Canvas: TCanvas read FCanvas write FCanvas;
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property Visible: Boolean read FVisible write SetVisible;
    property ZOrder: Integer read FZOrder write FZOrder;

    property BoundsLocks: TppBoundsLockStates read FBoundsLocks write FBoundsLocks;
    property ObjectLeft: Longint read FObjectLeft write FObjectLeft;
    property ObjectTop: Longint read FObjectTop write FObjectTop;
    property ObjectWidth: Longint read FObjectWidth write FObjectWidth;
    property ObjectHeight: Longint read FObjectHeight write FObjectHeight;

  end;


  {TppBoundsRectCollection }
  TppBoundsRectCollection = class(TppCollectionBase)
    private
      function GetItemForIndex(aIndex: Integer): TppBoundsRect;
    public

      destructor Destroy; override;
      function IndexOf(aBoundsRect: TppBoundsRect): Integer;

      procedure Erase;
      procedure Redraw;
      procedure Sort;
      procedure ClearList;
      procedure Add(aBoundsRect: TppBoundsRect);
      procedure Remove(aBoundsRect: TppBoundsRect);

      property Items[Index: Integer]: TppBoundsRect read GetItemForIndex; default;

  end;
  {enumerated type to track selection handles}
  TppSelectionHandleType = (slTopLeft, slTopRight, slBottomLeft, slBottomRight);

  TppSelectionHandle = class(TShape);


  {@TppSelectionHandles}
  TppSelectionHandles = class(TComponent)
  private
    FaHandles: array [slTopLeft..slBottomRight] of TppSelectionHandle;
    FParent: TWinControl;
    function GetVisible: Boolean;

  protected
    procedure SetParent(aParent: TWinControl); virtual;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Show(aBoundsRect: TppBoundsRect);
    procedure Hide;

    property Parent: TWinControl read FParent write SetParent;
    property Visible: Boolean read GetVisible;

  published
  end;  {class, TppSelectionHandles}


  {enumerated type to track sizing handles}
  TppSizingHandleType = (shTopLeft, shTopMiddle, shTopRight,
                       shLeftMiddle, shRightMiddle,
                       shBottomLeft, shBottomMiddle, shBottomRight);

  TppSizingHandle = class(TShape);

  {@TppSizingHandles}
  TppSizingHandles = class(TComponent)
  private
    FColor: TColor;
    FOnDragOver: TDragOverEvent;
    FOnEndDrag: TEndDragEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseUp: TMouseEvent;
    FParent: TWinControl;
    FaHandles: array [shTopLeft..shBottomRight] of TppSizingHandle;
    FOnMouseMove: TMouseMoveEvent;

    function GetVisible: Boolean;
    procedure SetColor(aColor: TColor);
    procedure SetDragOver(aDragOverEvent: TDragOverEvent);
    procedure SetEndDrag(aEndDragEvent: TEndDragEvent);
    procedure SetMouseDown(aMouseEvent: TMouseEvent);
    procedure SetMouseUp(aMouseEvent: TMouseEvent);
    procedure SetOnMouseMove(const Value: TMouseMoveEvent);

  protected
    procedure SetParent(aParent: TWinControl); virtual;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Show(aBoundsRect: TppBoundsRect);
    procedure Hide;

    property Color: TColor read FColor write SetColor;
    property OnDragOver: TDragOverEvent read FOnDragOver write SetDragOver;
    property OnEndDrag: TEndDragEvent read FOnEndDrag write SetEndDrag;
    property OnMouseDown: TMouseEvent read FOnMouseDown write SetMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write SetOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write SetMouseUp;
    property Parent: TWinControl read FParent write SetParent;
    property Visible: Boolean read GetVisible;

  end;  {class, SizingHandles}


  {TppSelectionObject}
  TppSelectionObject = class(TppCommunicator)
  private
    FActive: Boolean;
    FBoundsRect: TppBoundsRect;
    FbrDragOver: TDragOverEvent;
    FbrEndDrag: TEndDragEvent;
    FbrMouseUp: TMouseEvent;
    FSizingHandles : TppSizingHandles;
    FSelectionHandles: TppSelectionHandles;
    FParent: TWinControl;
    FComponent: TppComponent;
    FDesignControl: TGraphicControl;

    function GetBoundsLocks:TppBoundsLockStates;

    procedure SetDesignControl(aDesignControl: TGraphicControl);
    procedure SetSizingHandles(aSizingHandles: TppSizingHandles);
    procedure SetSizingHandlesColor;

    procedure enComponentBoundsChanged;
    function GetVisible: Boolean;

  protected
    procedure SetParent(aParent: TWinControl); virtual;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
    procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

    procedure ShowSelection(Value: Boolean);
    procedure ShowBoundsRect(Value: Boolean);
    procedure SetComponentBounds;

    property  Active: Boolean read FActive write FActive;
    property  BoundsLocks: TppBoundsLockStates read GetBoundsLocks;
    property  DesignControl: TGraphicControl read FDesignControl write SetDesignControl;
    property  Component: TppComponent read FComponent;
    property  BoundsRect: TppBoundsRect read FBoundsRect;
    property  Parent: TWinControl read FParent write SetParent;
    property  SizingHandles: TppSizingHandles read FSizingHandles write SetSizingHandles;
    property Visible: Boolean read GetVisible;

  end;  {class, SelectionObject}


  {TppSelectionObjectCollection}
  TppSelectionObjectCollection = class(TppCollectionBase)
    private
      function GetItemForIndex(aIndex: Integer): TppSelectionObject;
      function GetItemsByIndex(Index: Integer): TppSelectionObject;

    public

      function IndexOf(aComponent: TppComponent): Integer;

      function GetItemForComponent(aComponent: TppComponent): TppSelectionObject;
      procedure ClearList;
      procedure Add(aSelectionObject: TppSelectionObject);
      procedure Delete(aIndex: Integer);
      procedure Remove(aSelectionObject: TppSelectionObject);

      property Items[Component: TppComponent]: TppSelectionObject read GetItemForComponent; default;
      property ItemsByIndex[Index: Integer]: TppSelectionObject read GetItemsByIndex;

    end;


  {TppWorkspaceGridOptions}
  TppWorkspaceGridOptions = class(TPersistent)
  private
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    FSnapToGrid: Boolean;
    FSpacingX: Integer;
    FSpacingY: Integer;

    procedure SetVisible(const Value: Boolean);
    procedure SetSpacingX(const Value: Integer);
    procedure SetSpacingY(const Value: Integer);

  protected
    procedure DoOnChange;
    
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

    property Visible: Boolean read FVisible write SetVisible;
    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid;
    property SpacingX: Integer read FSpacingX write SetSpacingX;
    property SpacingY: Integer read FSpacingY write SetSpacingY;

  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end;

  {TppWorkspaceGridPainter}
  TppWorkspaceGridPainter = class
  private
    FGridImage: TBitmap;
    FReport: TppCustomReport;
    FWorkspace: TppWorkspace;

    procedure DrawEmptyGrid(aCanvas: TCanvas);
    procedure DrawGridRow(aCanvas: TCanvas; aPosY, aFromPosX, aToPosX: Integer);
    function GetGridImage: TBitmap;
    procedure DrawGridImage(aCanvas: TCanvas);
    procedure DrawReportGrid(aCanvas: TCanvas);
    function IsValidGridImage(aGridImage: TBitmap): Boolean;
    procedure SetReport(const Value: TppCustomReport);

  public
    constructor Create(aWorkspace: TppWorkspace);
    destructor Destroy; override;
    
    procedure Paint;
    procedure Reset;
    property Report: TppCustomReport read FReport write SetReport;

  end;

  {@TppWorkspace}
  TppWorkspace = class(TPanel)
    private
      FBounding: Boolean;
      FOnPaint: TNotifyEvent;
      FColumnBackgroundRect: TRect;
      FBoundsRects: TppBoundsRectCollection;
      FDesignGuides: TppDesignGuideCollection;
      FDragDropEventParams: TppDragDropEventParams;
      FDragOverEventParams: TppDragOverEventParams;
      FEventHub: TppDesignEventHub;
      FGridOptions: TppWorkspaceGridOptions;
      FGridPainter: TppWorkspaceGridPainter;
      FKeyEventParams: TppKeyboardEventParams;
      FMouseEventParams: TppMouseEventParams;
      FReport: TppCustomReport;
      FRubberBand: TRect;

      procedure ehBand_DesignControlCreate(Sender, aParameters: TObject);
      procedure ehBand_HeightChange(Sender, aParameters: TObject);
      procedure ehComponent_DesignControlCreate(Sender, aParameters: TObject);
      procedure ehGridOptions_Change(Sender: TObject);
      procedure ehReport_LayoutChange(Sender, aParameterList: TObject);
      function GetBottom: Integer;
      function GetColumnBackground: Boolean;
      procedure SetColumnBackgroundRect(const Value: TRect);
      procedure SetEventHub(aEventHub: TppDesignEventHub);
      procedure SetGridOptions(const Value: TppWorkspaceGridOptions);
      procedure SetReport(const Value: TppCustomReport);
      procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;

    protected
      procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure Paint; override;

      procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
      procedure CalcHeight;
      procedure CalcSize;
      procedure CalcWidth;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;
      procedure UpdateColumnBackground;


    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      
      procedure BoundingBegin;
      procedure BoundingEnd;
      procedure BoundingUpdate(aPoint: TPoint);

      function CalcSnapToGridPosition(aPosition: TPoint): TPoint;
      procedure DragDrop(Source: TObject; X, Y: Integer); override;
      function IndexOfControl(aControl: TControl): Integer;
      procedure UpdateZOrder(aControl: TControl; aOrder: Integer);

      property BoundsRects: TppBoundsRectCollection read FBoundsRects;
      property Canvas;
      property ColumnBackground: Boolean read GetColumnBackground;
      property ColumnBackgroundRect: TRect read FColumnBackgroundRect write SetColumnBackgroundRect;
      property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
      property Bottom: Integer read GetBottom;
      property Bounding: Boolean read FBounding;
      property DesignGuides: TppDesignGuideCollection read FDesignGuides;
      property GridOptions: TppWorkspaceGridOptions read FGridOptions write SetGridOptions;
      property Report: TppCustomReport read FReport write SetReport;
      property RubberBand: TRect read FRubberBand;

  end; {class, TppWorkspace}


 {@TppDocHistory }
  TppDocHistory = class(TPersistent)
    private
      FHistory: TStringList;
      FHistoryData: TStringList;
      FSeparatorMenuItem: TMenuItem;
      FOwner: TComponent;
      FParentMenu: TMenuItem;
      FHistoryMax: Integer;
      FOnMenuItemClick: TNotifyEvent;

      procedure AddItem(aName: String; aData: TStrings);
      procedure DeleteItem(aIndex: Integer);
      procedure LoadStateInfo;
      procedure SaveStateInfo;
      procedure SetMenuItemCaptions;
      procedure SetMenuItemClick(aNotifyEvent: TNotifyEvent);

      function ItemDataFromString(aString: String): TStrings;
      function ItemDataToString(aData: TStrings): String;

      function GetDataForItemName(aName: String): TStrings;
      function GetItemCount: Integer;
      function GetMenuItemForIndex(aIndex: Integer): TMenuItem;

    public
      constructor Create(aOwner: TComponent; aParentMenu: TMenuItem);
      destructor Destroy; override;

      function GetItemName(aMenuItem: TMenuItem): String;
      function GetItemData(aMenuItem: TMenuItem): TStrings;
      procedure UpdateItem(aName: String; aData: TStrings);

      property ItemCount: Integer read GetItemCount;
      property MenuItems[Index: Integer]: TMenuItem read GetMenuItemForIndex;
      property OnMenuItemClick: TNotifyEvent read FOnMenuItemClick write SetMenuItemClick;

  end; {class TppDocHistory }


implementation

uses
  ppDesignControls;

{******************************************************************************
 *
 **  B O U N D S  R E C T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBoundsRect.Create}

constructor TppBoundsRect.Create(aOwner: TComponent);
begin
  inherited Create;

  FBackImage := TBitmap.Create;

  SetBounds(10, 10, 100, 100);

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Destroy}

destructor TppBoundsRect.Destroy;
begin
  SetParent(nil);

  FBackImage.Free;
  FBackImage := nil;
  
  inherited;
end;


{------------------------------------------------------------------------------}
{ TppBoundsRect.SetParent}

procedure TppBoundsRect.SetParent(aParent: TWinControl);
begin

  if (aParent <> nil) and not(aParent is TppWorkspace) then
    raise Exception.Create('TppBoundsRect.SetParent: Parent must be of type TppWorkspace');

  if (aParent = nil) and (FParent <> nil) then
    TppWorkspace(FParent).BoundsRects.Remove(Self);

  FParent := aParent;

  if FParent <> nil then
    TppWorkspace(FParent).BoundsRects.Add(Self);

  if (aParent <> nil) and (aParent is TppWorkspace) then
    FCanvas := TppWorkspace(aParent).Canvas
  else
    FCanvas := nil

end;


{------------------------------------------------------------------------------}
{ TppBoundsRect.Paint}

procedure TppBoundsRect.Paint;
begin
  if not(FVisible) or (FCanvas = nil) then Exit;

  FCanvas.Brush.Style := bsClear;

  FCanvas.Pen.Color := clBlack;
  FCanvas.Pen.Style := psDot;
  FCanvas.Pen.Width := 1;

  FCanvas.Rectangle(FSize.Left, FSize.Top, FSize.Left+FSize.Width, FSize.Top+FSize.Height);

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Erase}

procedure TppBoundsRect.Erase;
begin

  if not(FVisible) or (FCanvas = nil) then Exit;

  RestoreBackgroundImage;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Redraw}

procedure TppBoundsRect.Redraw;
begin
  if not(FVisible) or (FCanvas = nil) then Exit;

  SaveBackgroundImage;

  Paint;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SaveBackgroundImage}

procedure TppBoundsRect.SaveBackgroundImage;
var
  lDestRect: TRect;
  lSrcRect: TRect;
begin

{$IFDEF CodeSite}
  CodeSite.Send('TppBoundsRect.SaveBackgroundImage');
{$ENDIF}
  if FCanvas = nil then Exit;

  FBackImage.Width := FSize.Width;
  FBackImage.Height := FSize.Height;

  lDestRect := Rect(0, 0, FBackImage.Width, FBackImage.Height);
  lSrcRect  := Rect(FSize.Left, FSize.Top, FSize.Left + FBackImage.Width, FSize.Top+ FBackImage.Height);

  FBackImage.Canvas.CopyRect(lDestRect, FCanvas, lSrcRect);

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.RestoreBackgroundImage}

procedure TppBoundsRect.RestoreBackgroundImage;
var
  lDestRect: TRect;
  lSrcRect: TRect;
begin

{$IFDEF CodeSite}
  CodeSite.Send('TppBoundsRect.RestoreBackgroundImage');
{$ENDIF}

  if FCanvas = nil then Exit;

  lSrcRect  := Rect(0, 0, FBackImage.Width, FBackImage.Height);
  lDestRect := Rect(FSize.Left, FSize.Top, FSize.Left+FBackImage.Width, FSize.Top+FBackImage.Height);

  FCanvas.CopyRect(lDestRect, FBackImage.Canvas, lSrcRect);

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetBounds}

procedure TppBoundsRect.SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin

  UpdateOldSize;

  FSize.Left := aLeft;
  FSize.Top := aTop;
  FSize.Width := aWidth;
  FSize.Height := aHeight;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.BeginDrag}

procedure TppBoundsRect.BeginDrag;
begin
  FBeginDrag := True;
  FStartDragPos := Point(FSize.Left, FSize.Top);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.EndDrag}

procedure TppBoundsRect.EndDrag;
begin
  FBeginDrag := False;
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Move}

procedure TppBoundsRect.Move(aX, aY: Integer);
begin

  SetBounds(aX, aY, FSize.Width, FSize.Height);

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.MoveBy}

procedure TppBoundsRect.MoveBy(aX, aY: Integer);
begin
  Move(Size.Left + aX, Size.Top + aY);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetVisible}

procedure TppBoundsRect.SetVisible(const Value: Boolean);
begin

  if (FVisible <> Value) then
    begin
      FVisible := Value;
      if Value then
       SaveBackgroundImage;
    end;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.UpdateOldSize}

procedure TppBoundsRect.UpdateOldSize;
begin

  FOldSize.Left := FSize.Left;
  FOldSize.Top := FSize.Top;
  FOldSize.Width := FSize.Width;
  FOldSize.Height := FSize.Height;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.GetBoundsRect}

function TppBoundsRect.GetBoundsRect: TRect;
begin
  Result := Rect(FSize.Left, FSize.Top, FSize.Left + FSize.Width, FSize.Top + FSize.Height);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.GetHeight}

function TppBoundsRect.GetHeight: Integer;
begin
  Result := FSize.Height;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.GetLeft}

function TppBoundsRect.GetLeft: Integer;
begin
  Result := FSize.Left;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.GetTop}

function TppBoundsRect.GetTop: Integer;
begin
  Result := FSize.Top;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.GetWidth}

function TppBoundsRect.GetWidth: Integer;
begin
  Result := FSize.Width;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetHeight}

procedure TppBoundsRect.SetHeight(const Value: Integer);
begin
  SetBounds(FSize.Left, FSize.Top, FSize.Width, Value);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetLeft}

procedure TppBoundsRect.SetLeft(const Value: Integer);
begin
  SetBounds(Value, FSize.Top, FSize.Width, FSize.Height);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetTop}

procedure TppBoundsRect.SetTop(const Value: Integer);
begin
  SetBounds(FSize.Left, Value, FSize.Width, FSize.Height);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetWidth}

procedure TppBoundsRect.SetWidth(const Value: Integer);
begin
  SetBounds(FSize.Left, FSize.Top, Value, FSize.Height);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.SetObjectBounds}

procedure TppBoundsRect.SetObjectBounds(aLeft, aTop, aWidth, aHeight: Longint);
var
  liSpLeft,
  liSpTop,
  liSpWidth,
  liSpHeight : Integer;

begin

  FObjectLeft   := aLeft;
  FObjectTop    := aTop;
  FObjectWidth  := aWidth;
  FObjectHeight := aHeight;

  // set in screen pixels also
  liSpLeft   := Trunc(ppFromMMThousandths(aLeft,   utScreenPixels, pprtHorizontal, nil));
  liSpTop    := Trunc(ppFromMMThousandths(aTop,    utScreenPixels, pprtVertical,   nil));
  liSpWidth  := Trunc(ppFromMMThousandths(aWidth,  utScreenPixels, pprtHorizontal, nil));
  liSpHeight := Trunc(ppFromMMThousandths(aHeight, utScreenPixels, pprtVertical,   nil));

   SetBounds(liSpLeft, liSpTop, liSpWidth, liSpHeight);

end; {procedure, SetObjectBounds}

{------------------------------------------------------------------------------}
{ TppBoundsRect.Assign}

procedure TppBoundsRect.Assign(Source: TObject);
var
  lSource: TppBoundsRect;
begin

 if (Source is TppBoundsRect) then
   begin
     lSource := TppBoundsRect(Source);

     FObjectLeft   := lSource.ObjectLeft;
     FObjectTop    := lSource.ObjectTop ;
     FObjectWidth  := lSource.ObjectWidth;
     FObjectHeight := lSource.ObjectHeight;

     SetBounds(lSource.Left, lSource.Top, lSource.Width, lSource.Height);

   end;

end;

{******************************************************************************
 *
 **  B O U N D S  R E C T   C O L L E C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBoundsRect.Add}

procedure TppBoundsRectCollection.Add(aBoundsRect: TppBoundsRect);
begin
  InnerList.Add(aBoundsRect);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.ClearList}

procedure TppBoundsRectCollection.ClearList;
var
  liIndex: Integer;
begin

  for liIndex := Count-1 downto 0 do
    InnerList[liIndex].Free;

  InnerList.Clear;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Sort}

function BoundsRectCompareItem(Item1, Item2: Pointer): Integer;
var
  lItem1: TppBoundsRect;
  lItem2: TppBoundsRect;
begin
  lItem1 := TppBoundsRect(Item1);
  lItem2 := TppBoundsRect(Item2);

  if lItem1.ZOrder < lItem2.ZOrder then
    Result := 1
  else if lItem1.ZOrder > lItem2.ZOrder then
    Result := -1
  else
    Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Destroy}

destructor TppBoundsRectCollection.Destroy;
begin

//  ClearList;

  inherited;

end;

procedure TppBoundsRectCollection.Sort;
begin
  InnerList.Sort(BoundsRectCompareItem);

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.GetItemForIndex}

function TppBoundsRectCollection.GetItemForIndex(aIndex: Integer): TppBoundsRect;
begin
  Result := TppBoundsRect(InnerList[aIndex]);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.IndexOf}

function TppBoundsRectCollection.IndexOf(aBoundsRect: TppBoundsRect): Integer;
begin
  Result := InnerList.IndexOf(aBoundsRect);
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Remove}

procedure TppBoundsRectCollection.Remove(aBoundsRect: TppBoundsRect);
begin
  InnerList.Remove(aBoundsRect)
end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Erase}

procedure TppBoundsRectCollection.Erase;
var
  liIndex: Integer;
begin

  Sort;

  for liIndex := 0 to Count-1 do
    Items[liIndex].Erase;

end;

{------------------------------------------------------------------------------}
{ TppBoundsRect.Redraw}

procedure TppBoundsRectCollection.Redraw;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count-1 do
    Items[liIndex].SaveBackgroundImage;

  for liIndex := 0 to Count-1 do
    Items[liIndex].Paint;

end;

{******************************************************************************
 *
 **  S I Z I N G   H A N D L E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSizingHandles.Create}

constructor TppSizingHandles.Create(aOwner: TComponent);
var
  lshHandle : TppSizingHandleType;

begin

  inherited Create(aOwner);

  FColor := clBlack;
  FParent:= nil;

  FOnDragOver  := nil;
  FOnEndDrag   := nil;
  FOnMouseDown := nil;
  FOnMouseUp   := nil;

  {create sizing handles}
  for lshHandle := shTopLeft to shBottomRight do
    begin
      FaHandles[lshHandle]             := TppSizingHandle.Create(aOwner);
      FaHandles[lshHandle].Tag         := Variant(lshHandle);
      FaHandles[lshHandle].Shape       := stCircle;
      FaHandles[lshHandle].Height      := 7;
      FaHandles[lshHandle].Width       := 7;
      FaHandles[lshHandle].Brush.Color := clWhite;
      FaHandles[lshHandle].Pen.Color   := clBlack;
      FaHandles[lshHandle].Visible     := False;
      FaHandles[lshHandle].FreeNotification(Self);

    end;

  {assign appropriate cursors for each handle}

  FaHandles[shTopLeft].Cursor          := crSizeNWSE;
  FaHandles[shTopMiddle].Cursor        := crSizeNS;
  FaHandles[shTopRight].Cursor         := crSizeNESW;
  FaHandles[shLeftMiddle].Cursor       := crSizeWE;
  FaHandles[shRightMiddle].Cursor      := crSizeWE;
  FaHandles[shBottomLeft].Cursor       := crSizeNESW;
  FaHandles[shBottomMiddle].Cursor     := crSizeNS;
  FaHandles[shBottomRight].Cursor      := crSizeNWSE;

  FaHandles[shTopLeft].DragCursor      := crSizeNWSE;
  FaHandles[shTopMiddle].DragCursor    := crSizeNS;
  FaHandles[shTopRight].DragCursor     := crSizeNESW;
  FaHandles[shLeftMiddle].DragCursor   := crSizeWE;
  FaHandles[shRightMiddle].DragCursor  := crSizeWE;
  FaHandles[shBottomLeft].DragCursor   := crSizeNESW;
  FaHandles[shBottomMiddle].DragCursor := crSizeNS;
  FaHandles[shBottomRight].DragCursor  := crSizeNWSE;

end;



{------------------------------------------------------------------------------}
{ TppSizingHandles.Destroy}

destructor TppSizingHandles.Destroy;
var
  lshHandle: TppSizingHandleType;

begin

  {free sizing handles}
  if (FaHandles[shTopLeft] <> nil) then
    for lshHandle := shTopLeft to shBottomRight do
      FaHandles[lshHandle].Free;

  inherited Destroy;

end;

function TppSizingHandles.GetVisible: Boolean;
begin
  Result := FaHandles[shTopLeft].Visible
end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.Notification }

procedure TppSizingHandles.Notification(aComponent: TComponent; Operation: TOperation);
var
  lshHandle: TppSizingHandleType;
  liEnum: Integer;
begin

  if (aComponent is TppSizingHandle) and (Operation = opRemove) then
    begin
      liEnum := aComponent.Tag;
      lshHandle := TppSizingHandleType(liEnum);
      
      if (FaHandles[lshHandle] = aComponent) then
        FaHandles[lshHandle] := nil;

    end;


  inherited;

end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.SetColor}

procedure TppSizingHandles.SetColor(aColor: TColor);
var
  lshHandle : TppSizingHandleType;

begin
  FColor := aColor;

  for lshHandle := shTopLeft to shBottomRight do
    begin
      FaHandles[lshHandle].Brush.Color := FColor;
      FaHandles[lshHandle].Pen.Color   := FColor;
    end;

end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.SetParent}

procedure TppSizingHandles.SetParent(aParent: TWinControl);
var
  lshHandle : TppSizingHandleType;

begin

  FParent := aParent;

  if FParent <> nil then
    for lshHandle := shTopLeft to shBottomRight do
      FaHandles[lshHandle].Parent := FParent;
      

end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.SetDragOver}

procedure TppSizingHandles.SetDragOver(aDragOverEvent: TDragOverEvent);
var
  lshHandle : TppSizingHandleType;

begin
  if (FaHandles[shTopLeft] = nil) then Exit;

  FOnDragOver := aDragOverEvent;

  for lshHandle := shTopLeft to shBottomRight do
    FaHandles[lshHandle].OnDragOver := FOnDragOver;

end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.SetEndDrag}

procedure TppSizingHandles.SetEndDrag(aEndDragEvent: TEndDragEvent);
var
  lshHandle : TppSizingHandleType;

begin

  if (FaHandles[shTopLeft] = nil) then Exit;

  FOnEndDrag := aEndDragEvent;

  for lshHandle := shTopLeft to shBottomRight do
    FaHandles[lshHandle].OnEndDrag := FOnEndDrag;

end;


{------------------------------------------------------------------------------}
{ TppSizingHandles.SetMouseDown}

procedure TppSizingHandles.SetMouseDown(aMouseEvent: TMouseEvent);
var
  lshHandle : TppSizingHandleType;

begin

  if (FaHandles[shTopLeft] = nil) then Exit;

  FOnMouseDown := aMouseEvent;

  for lshHandle := shTopLeft to shBottomRight do
    FaHandles[lshHandle].OnMouseDown := FOnMouseDown;

end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.SetMouseUp}

procedure TppSizingHandles.SetMouseUp(aMouseEvent: TMouseEvent);
var
  lshHandle : TppSizingHandleType;

begin

  if (FaHandles[shTopLeft] = nil) then Exit;

  FOnMouseUp := aMouseEvent;

  for lshHandle := shTopLeft to shBottomRight do
    FaHandles[lshHandle].OnMouseUp := FOnMouseUp;

end;

{------------------------------------------------------------------------------}
{ TppSizingHandles.SetOnMouseMove}

procedure TppSizingHandles.SetOnMouseMove(const Value: TMouseMoveEvent);
var
  lshHandle : TppSizingHandleType;
begin

  if (FaHandles[shTopLeft] = nil) then Exit;

  FOnMouseMove := Value;

  for lshHandle := shTopLeft to shBottomRight do
    FaHandles[lshHandle].OnMouseMove := FOnMouseMove;
    
end;


{------------------------------------------------------------------------------}
{ TppSizingHandles.Show}

procedure TppSizingHandles.Show(aBoundsRect: TppBoundsRect);
var
  lshHandle:    TppSizingHandleType;
  liLeft,
  liTop: Integer;
begin

  if (FaHandles[shTopLeft] = nil) then Exit;

  liLeft := 0;
  liTop  := 0;

  if (aBoundsRect <> nil) then
    for lshHandle := shTopLeft to shBottomRight do
      begin
          case lshHandle of
            shTopLeft:
              begin
                liLeft   := aBoundsRect.Left - 5;
                liTop    := aBoundsRect.Top  - 5;
              end;

            shTopMiddle:
              begin
                liLeft   := aBoundsRect.Left + (aBoundsRect.Width div 2) - 3 ;
                liTop    := aBoundsRect.Top - 5;
              end;

            shTopRight:
              begin
                liLeft   := aBoundsRect.Left + aBoundsRect.Width - 1 ;
                liTop    := aBoundsRect.Top - 5;
              end;

            shLeftMiddle:
              begin
                liLeft   := aBoundsRect.Left - 5;
                liTop    := aBoundsRect.Top + (aBoundsRect.Height div 2) - 3 ;
              end;

            shRightMiddle:
              begin
                liLeft   := aBoundsRect.Left - 1 + aBoundsRect.Width;
                liTop    := aBoundsRect.Top + (aBoundsRect.Height div 2) - 3 ;
              end;

           shBottomLeft:
              begin
                liLeft   := aBoundsRect.Left - 5;
                liTop    := aBoundsRect.Top  - 1 + aBoundsRect.Height;
              end;

            shBottomMiddle:
              begin
                liLeft   := aBoundsRect.Left + (aBoundsRect.Width div 2) - 3 ;
                liTop    := aBoundsRect.Top - 1 + aBoundsRect.Height;
              end;

            shBottomRight:
              begin
                liLeft   := aBoundsRect.Left + aBoundsRect.Width - 1 ;
                liTop    := aBoundsRect.Top - 1 + aBoundsRect.Height;
              end;

          end; {case, sizing handle type}


          {calculate sizing handle coordinates within object}
          FaHandles[lshHandle].Left         := liLeft;
          FaHandles[lshHandle].Top          := liTop;
          FaHandles[lshHandle].BringToFront;
          FaHandles[lshHandle].Visible      := True;


      end; {for, each handle}

end; {procedure, Show}


{------------------------------------------------------------------------------}
{ TppSizingHandles.Hide}

procedure TppSizingHandles.Hide;
var
  lshHandle: TppSizingHandleType;
begin

  if (FaHandles[shTopLeft] = nil) then Exit;

  for lshHandle := shTopLeft to shBottomRight do
    if FaHandles[lshHandle].Visible then
      FaHandles[lshHandle].Visible  := False;

end; {procedure, Hide}



{******************************************************************************
 *
 **  S E L E C T I O N  H A N D L E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSelectionHandles.Create}

constructor TppSelectionHandles.Create(aOwner: TComponent);
var
  lslHandle: TppSelectionHandleType;

begin

  inherited Create(aOwner);

  FParent:= nil;

  {create selection handles}
  for lslHandle := slTopLeft to slBottomRight do
    begin
      FaHandles[lslHandle]             := TppSelectionHandle.Create(AOwner);
      FaHandles[lslHandle].FreeNotification(Self);

      FaHandles[lslHandle].Tag         := Variant(lslHandle);
      FaHandles[lslHandle].Height      := 7;
      FaHandles[lslHandle].Width       := 7;
      FaHandles[lslHandle].Shape       := stCircle;
      FaHandles[lslHandle].Pen.Color   := clSilver;
      FaHandles[lslHandle].Brush.Color := clSilver;
      FaHandles[lslHandle].Visible     := False;
    end;

end;

{------------------------------------------------------------------------------}
{ TppSelectionHandles.Destroy}

destructor TppSelectionHandles.Destroy;
var
  lslHandle: TppSelectionHandleType;
begin

  {free sizing handles}
  if (FaHandles[slTopLeft] <> nil) then
    for lslHandle := slTopLeft to slBottomRight do
      FaHandles[lslHandle].Free;

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppSelectionHandles.GetVisible}

function TppSelectionHandles.GetVisible: Boolean;
begin
  Result := FaHandles[slTopLeft].Visible;
end;

{------------------------------------------------------------------------------}
{ TppSelectionHandles.Notification }

procedure TppSelectionHandles.Notification(aComponent: TComponent; Operation: TOperation);
var
  lslHandle: TppSelectionHandleType;
  liEnum: Integer;
begin

  if (aComponent is TppSelectionHandle) and (Operation = opRemove) then
    begin
      liEnum := aComponent.Tag;
      lslHandle := TppSelectionHandleType(liEnum);
      
      if (FaHandles[lslHandle] = aComponent) then
        FaHandles[lslHandle] := nil;

    end;


  inherited;

end;

{------------------------------------------------------------------------------}
{ TppSelectionHandles.SetParent}

procedure TppSelectionHandles.SetParent(aParent: TWinControl);
var
  lslHandle: TppSelectionHandleType;

begin
  if FParent = aParent then Exit;

  FParent := aParent;

  {create selection handles}
  if (FParent <> nil) then
    for lslHandle := slTopLeft to slBottomRight do
      FaHandles[lslHandle].Parent := FParent;

end;


{------------------------------------------------------------------------------}
{ TppSelectionHandles.Show}

procedure TppSelectionHandles.Show(aBoundsRect: TppBoundsRect);

var
  lslHandle:    TppSelectionHandleType;
  liLeft,
  liTop: Integer;

begin

  if (FaHandles[slTopLeft] = nil) then Exit;
  
  liLeft := 0;
  liTop  := 0;

  if (aBoundsRect <> nil) then
    for lslHandle := slTopLeft to slBottomRight do
      begin

          case lslHandle of
            slTopLeft:
              begin
                liLeft   := aBoundsRect.Left - 4;
                liTop    := aBoundsRect.Top - 4;
              end;

            slTopRight:
              begin
                liLeft   := aBoundsRect.Left + aBoundsRect.Width - 2;
                liTop    := aBoundsRect.Top - 4;
              end;

            slBottomLeft:
              begin
                liLeft   := aBoundsRect.Left - 4;
                liTop    := aBoundsRect.Top + aBoundsRect.Height - 2;
              end;

            slBottomRight:
              begin
                liLeft   := aBoundsRect.Left + aBoundsRect.Width - 2;
                liTop    := aBoundsRect.Top  + aBoundsRect.Height - 2;
              end;

          end; {case, sizing handle type}

          {calculate sizing handle coordinates within object}
          FaHandles[lslHandle].Left         := liLeft;
          FaHandles[lslHandle].Top          := liTop;
          FaHandles[lslHandle].BringToFront;
          FaHandles[lslHandle].Visible      := True;

      end; {for, selection handles}

end; {procedure, Show}


{------------------------------------------------------------------------------}
{ TppSelectionHandles.Hide}

procedure TppSelectionHandles.Hide;

var
  lslHandle: TppSelectionHandleType;
begin

  if (FaHandles[slTopLeft] = nil) then Exit;

  for lslHandle := slTopLeft to slBottomRight do
    begin

      FaHandles[lslHandle].Visible  := False;

    end;

end; {procedure, Hide}

{******************************************************************************
 *
 **  S E L E C T I O N   O B J E C T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSelectionObject.Create}

constructor TppSelectionObject.Create(aOwner: TComponent);

begin

  inherited Create(aOwner);


  FActive     := True;
  FBoundsRect := TppBoundsRect.Create(aOwner);

  {pointers to event handlers }
  FbrDragOver := nil;
  FbrEndDrag  := nil;
  FbrMouseUp  := nil;

  FSelectionHandles := TppSelectionHandles.Create(aOwner);
  FSelectionHandles.FreeNotification(Self);

  {these are used as object references (i.e. not created/destroyed by this object}
  FParent         :=  nil;
  FComponent    := nil;
  FDesignControl  := nil;
  FSizingHandles  := nil;

  EventNotifies := [ciComponentBoundsChanged];


end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.Destroy}

destructor TppSelectionObject.Destroy;
begin

  {2.0}
  if Assigned(FSizingHandles) and Parent.Visible then
    FSizingHandles.Hide;

  FComponent := nil;
  FSizingHandles := nil;

  FSelectionHandles.Free;

  FBoundsRect.Free;

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.Notification }

procedure TppSelectionObject.Notification(AComponent: TComponent; Operation: TOperation);
begin

  if (Operation = opRemove) then
    begin

      if (aComponent = FSizingHandles) then
        FSizingHandles := nil
      else if (aComponent = FSelectionHandles) then
        FSelectionHandles := nil
      else if (aComponent = Parent) then
        FBoundsRect := nil;


    end;
    
 inherited;

end;

{------------------------------------------------------------------------------}
{TppSelectionObject.Notify }

procedure TppSelectionObject.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aOperation = ppopRemove) then
    if (aCommunicator = FComponent) then
      Free
    else if (FDesignControl <> nil) and (aCommunicator = TppDesignControl(FDesignControl).WalkieTalkie) then
      DesignControl := nil;

  inherited;

end;

{TppSelectionObject.EventNotify }

procedure TppSelectionObject.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  if (aEventID = ciComponentBoundsChanged) then
    if (FDesignControl <> nil) and (aCommunicator = TppDesignControl(FDesignControl).WalkieTalkie) then
      enComponentBoundsChanged;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.GetBoundsLocks}

function TppSelectionObject.GetBoundsLocks: TppBoundsLockStates;
begin

  if DesignControl <> nil then
    begin
    Result := TppDesignControl(DesignControl).BoundsLocks;
    end
  else
    Result := [];
end;


{------------------------------------------------------------------------------}
{ TppSelectionObject.SetParent}

procedure TppSelectionObject.SetParent(aParent: TWinControl);
begin

  FParent := aParent;
  FBoundsRect.Parent := FParent;
  FSelectionHandles.Parent := FParent;

  if (FParent <> nil) then
    FParent.FreeNotification(Self);

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.SetDesignControl - set property routine}

procedure TppSelectionObject.SetDesignControl(aDesignControl: TGraphicControl);
begin

  if (FDesignControl <> nil) and (TppDesignControl(FDesignControl).WalkieTalkie <> nil) then
    begin
      TppDesignControl(FDesignControl).WalkieTalkie.RemoveNotify(Self);
      FComponent.RemoveNotify(Self);
    end;


  FDesignControl := aDesignControl;

  if (FDesignControl <> nil) then
    begin
      TppDesignControl(FDesignControl).WalkieTalkie.AddEventNotify(Self);
      FComponent := TppDesignControl(FDesignControl).Component;
      FComponent.AddEventNotify(Self);

      FBoundsRect.ZOrder := TppComponent(FComponent).Index;
      FBoundsRect.SetBounds(FDesignControl.Left, FDesignControl.Top, TppComponent(FComponent).spWidth,
                            TppComponent(FComponent).spHeight);
    end;

end;



{------------------------------------------------------------------------------}
{ TppSelectionObject.SetSizingHandles - set property routine}

procedure TppSelectionObject.SetSizingHandles(aSizingHandles: TppSizingHandles);
begin

  if not Assigned(aSizingHandles) and Assigned(FSizingHandles) then
    {hide sizing handles and show selection handles}
    begin
      FSizingHandles.Hide;
      FSizinghandles := nil;
      ShowSelection(True);
    end
  else if Assigned(aSizingHandles) and not Assigned(FSizingHandles) then
    {hide selection handles and show sizing handles}
    begin
      FSelectionHandles.Hide;
      FSizingHandles := aSizingHandles;
      FSizingHandles.FreeNotification(Self);
      SetSizingHandlesColor;
      FSizingHandles.Show(FBoundsRect);
    end;

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.ShowSelection}

procedure TppSelectionObject.ShowSelection(Value: Boolean);

begin

  if not(FActive) or (FComponent = nil) then Exit;

 if (FComponent <> nil) then
   if Value then
     begin
       FBoundsRect.Visible := False;

       {show sizing/selection handles}
       if Assigned(FSizingHandles) then
         begin
           SetSizingHandlesColor;
           FSizingHandles.Show(FBoundsRect);

         end
       else
         FSelectionHandles.Show(FBoundsRect);

     end

   else
     {hide sizing/selection handles}
     if Assigned(FSizingHandles) then
       FSizingHandles.Hide
     else
       FSelectionHandles.Hide;

end; {procedure, ShowSelection}


{------------------------------------------------------------------------------}
{ TppSelectionObject.SetSizingHandlesColor}

procedure TppSelectionObject.SetSizingHandlesColor;
var
  lColor: TColor;
  lDesignControl: TppDesignControl;

begin

  if Assigned(FSizingHandles) then
    begin

      {default to black}
      lColor := clBlack;

      lDesignControl := TppDesignControl(FDesignControl);

      if (lDesignControl <> nil) and
         ( (lDesignControl.Color = clBlack) or (lDesignControl.Color = clNavy) ) then
            lColor := clWhite;

      if FSizingHandles.Color <> lColor then
        FSizingHandles.Color := lColor;

    end;

end; {procedure, SetSizingHandlesColor}

{------------------------------------------------------------------------------}
{ TppSelectionObject.ShowBoundsRect}

procedure TppSelectionObject.ShowBoundsRect(Value: Boolean);
begin
 if Assigned(FComponent) then
   if Value then
     begin
{//nfm if Assigned(FSizingHandles) then
         FSizingHandles.Hide;
        else
         FSelectionHandles.Hide;

       Parent.Repaint; }
       
       FBoundsRect.Visible := True;

     end
   else
       FBoundsRect.Visible := False;

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.SetComponentBounds}

procedure TppSelectionObject.SetComponentBounds;
var
  lComponent: TppComponent;

begin

  if not(FActive) or (FComponent = nil) then Exit;

  lComponent := TppComponent(FComponent);

  {set component size based upon size of bounds rect}
  lComponent.spSetBounds(FBoundsRect.Left, FBoundsRect.Top - lComponent.Band.spTop,
                FBoundsRect.Width, FBoundsRect.Height);

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.enComponentBoundsChanged}

procedure TppSelectionObject.enComponentBoundsChanged;
var
  lComponent: TppComponent;
begin

  if not(FActive) or (FComponent = nil) then Exit;

  lComponent := TppComponent(FComponent);

  {set bounds rect size based upone size of component's design control}

  if (FDesignControl <> nil) then
    FBoundsRect.SetBounds(FDesignControl.Left,  FDesignControl.Top,
                              lComponent.spWidth, lComponent.spHeight);

  // update selection handles
  if (Visible) then
    ShowSelection(True);

end;

{------------------------------------------------------------------------------}
{ TppSelectionObject.GetVisible}

function TppSelectionObject.GetVisible: Boolean;
begin
  if (FSizingHandles <>nil) then
    Result := FSizingHandles.Visible
  else
    Result := FSelectionHandles.Visible;

end;


{******************************************************************************
 *
 ** S E L E C T I O N  O B J E C T  C O L L E C T I O N
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{TppSelectionObjectCollection.ClearList }

procedure TppSelectionObjectCollection.ClearList;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count-1 do
    InnerList[liIndex].Free;

  InnerList.Clear;


end;

{------------------------------------------------------------------------------}
{TppSelectionObjectCollection.Add }

procedure TppSelectionObjectCollection.Add(aSelectionObject: TppSelectionObject);
begin
  InnerList.Add(aSelectionObject);
end;

procedure TppSelectionObjectCollection.Delete(aIndex: Integer);
begin
  InnerList.Delete(aIndex);
end;


{------------------------------------------------------------------------------}
{TppSelectionObjectCollection.GetItemForComponent }

function TppSelectionObjectCollection.GetItemForComponent(aComponent: TppComponent): TppSelectionObject;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aComponent);

  if (liIndex >= 0) then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{TppSelectionObjectCollection.GetItemForIndex }

function TppSelectionObjectCollection.GetItemForIndex(aIndex: Integer): TppSelectionObject;
begin

  Result := TppSelectionObject(InnerList[aIndex]);

end;

function TppSelectionObjectCollection.GetItemsByIndex(Index: Integer): TppSelectionObject;
begin
  Result := TppSelectionObject(InnerList[Index]);
end;

{------------------------------------------------------------------------------}
{TppSelectionObjectCollection.IndexOf }

function TppSelectionObjectCollection.IndexOf(aComponent: TppComponent): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lSelectionObject: TppSelectionObject;
begin

  liIndex := 0;
  lbFound := False;

  while (not(lbFound) and (liIndex < InnerList.Count)) do
    begin
      lSelectionObject := GetItemForIndex(liIndex);

      if (lSelectionObject.Component = aComponent) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if (lbFound) then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{TppSelectionObjectCollection.Remove }

procedure TppSelectionObjectCollection.Remove(aSelectionObject: TppSelectionObject);
var
  liIndex: Integer;
begin
  liIndex := InnerList.IndexOf(aSelectionObject);

  if (liIndex >= 0) then
    InnerList.Delete(liIndex);

end;



{******************************************************************************
 *
 ** W O R K S P A C E  S T U F F
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppWorkspace.Create }

constructor TppWorkspace.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  ControlStyle := ControlStyle - [csNoStdEvents] + [csClickEvents];

  DoubleBuffered := True;
  Color      := clWindow;
  BevelOuter := bvNone;
  Caption    := '';
  Ctl3D      := False;
  Left       := 0;
  Top        := 0;

  {$IFDEF Delphi7}
    ParentBackground := False;
  {$ENDIF}
  
  FOnPaint := nil;

  FBoundsRects := TppBoundsRectCollection.Create;
  FDesignGuides := TppDesignGuideCollection.Create;
  FDesignGuides.Canvas := Canvas;

  FGridOptions := TppWorkspaceGridOptions.Create;
  FGridOptions.OnChange := ehGridOptions_Change;

  FGridPainter := TppWorkspaceGridPainter.Create(Self);

  FMouseEventParams := TppMouseEventParams.Create(mbLeft, [], 0, 0);
  FKeyEventParams := TppKeyboardEventParams.Create;
  FDragDropEventParams := TppDragDropEventParams.Create;
  FDragOverEventParams := TppDragOverEventParams.Create;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.Destroy }

destructor TppWorkspace.Destroy;
begin

  FGridOptions.Free;
  FGridOptions := nil;
  
  FGridPainter.Free;
  FGridPainter := nil;

  FMouseEventParams.Free;
  FMouseEventParams := nil;

  FKeyEventParams.Free;
  FKeyEventParams := nil;

  FDragDropEventParams.Free;
  FDragDropEventParams := nil;

  FDragOverEventParams.Free;
  FDragOverEventParams := nil;
  
  inherited Destroy;

  FBoundsRects.Free;
  FBoundsRects := nil;

  FDesignGuides.Free;
  FDesignGuides := nil;

end;

procedure TppWorkspace.BoundingBegin;
var
  lMousePos: TPoint;
begin
{$IFDEF CodeSite}
  CodeSite.Send('BoundingBegin');
{$ENDIF}
  FBounding := True;

  lMousePos := ScreenToClient(Mouse.CursorPos);

  FRubberBand := Rect(lMousePos.X, lMousePos.Y, lMousePos.X, lMousePos.Y);

{$IFDEF CodeSite}
  CodeSite.Send('MousePos', Mouse.CursorPos);
{$ENDIF}

end;

procedure TppWorkspace.BoundingEnd;
begin
{$IFDEF CodeSite}
  CodeSite.Send('BoundingEnd');
{$ENDIF}

  // erase
  if (FBounding) then
    Canvas.Rectangle(FRubberBand.Left, FRubberBand.Top, FRubberBand.Right, FRubberBand.Bottom);

  FBounding := False;


end;

procedure TppWorkspace.BoundingUpdate(aPoint: TPoint);
begin

  if not FBounding then Exit;

  Canvas.Pen.Mode := pmNotXor;
  Canvas.Pen.Width := 1;
  Canvas.Pen.Style := psDot;
  Canvas.Brush.Style := bsClear;

  // erase
  Canvas.Rectangle(FRubberBand.Left, FRubberBand.Top, FRubberBand.Right, FRubberBand.Bottom);

  FRubberBand.Right  := aPoint.X;
  FRubberBand.Bottom := aPoint.Y;

  // redraw
  Canvas.Rectangle(FRubberBand.Left, FRubberBand.Top, FRubberBand.Right, FRubberBand.Bottom);

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.CalcSnapToGridPosition }

function TppWorkspace.CalcSnapToGridPosition(aPosition: TPoint): TPoint;
var
  liMod: Integer;
  liHalfway: Integer;
  lSnapPoint: TPoint;
begin

  // x snap pos
  liHalfway := Round(FGridOptions.SpacingX / 2);
  liMod := aPosition.X mod FGridOptions.SpacingX;

  if (liMod <= liHalfway) then
    lSnapPoint.X := aPosition.X - liMod
  else
    lSnapPoint.X := (aPosition.X - liMod) + FGridOptions.SpacingX;

  // y snap pos
  liHalfway := Round(FGridOptions.SpacingY / 2);
  liMod := aPosition.Y mod FGridOptions.SpacingY;

  if (liMod <= liHalfway) then
    lSnapPoint.Y := aPosition.Y - liMod
  else
    lSnapPoint.Y := (aPosition.Y - liMod) + FGridOptions.SpacingY;

  Result := lSnapPoint;

end;


{------------------------------------------------------------------------------}
{ TppDesignWorkArea.CalcHeight }

procedure TppWorkspace.CalcHeight;
var
  liTop: Integer;
  liIndex: Integer;
  lBand: TppBand;
begin

  if (FReport = nil) then Exit;

  {initialize}
  liTop := 0;
  lBand := nil;

  {update band tops}
  for liIndex := 0 to FReport.BandCount-1 do
    begin
      lBand := FReport.Bands[liIndex];
      lBand.spTop := liTop;
      liTop := liTop + lBand.spHeight + TppBandControl.PanelHeight;
    end;

  {set workspace height
    note: workspace resize will adjust scroll box range}
  if (lBand <> nil) then
    Height := liTop;


end;

{------------------------------------------------------------------------------}
{ TppDesignWorkArea.CalcWorkspaceSize }

procedure TppWorkspace.CalcSize;
begin

  CalcWidth;
  CalcHeight;
  UpdateColumnBackground;
  FGridPainter.Reset;
  Invalidate;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkArea.CalcWorkspaceWidth }

procedure TppWorkspace.CalcWidth;
begin

  if (FReport = nil) then Exit;

  {set width to printable width }
  if (Width <> FReport.PrinterSetup.PageDef.spPrintableWidth + 1) then
     Width := FReport.PrinterSetup.PageDef.spPrintableWidth + 1;

  Invalidate;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.ehBand_DesignControlCreate }

procedure TppWorkspace.ehBand_DesignControlCreate(Sender, aParameters: TObject);
begin

  TppBandControl(aParameters).Parent := Self;

  CalcSize;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.ehBand_HeightChange }

procedure TppWorkspace.ehBand_HeightChange(Sender, aParameters: TObject);
begin
  CalcHeight;
  UpdateColumnBackground;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.ehComponent_DesignControlCreate }

procedure TppWorkspace.ehComponent_DesignControlCreate(Sender, aParameters: TObject);
begin

  TppDesignControl(aParameters).Parent := Self;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.DragDrop }

procedure TppWorkspace.DragDrop(Source: TObject; X, Y: Integer);
begin

  inherited;

  if (FEventHub <> nil) then
    begin
      FDragDropEventParams.Update(Source, X, Y);
      FEventHub.WorkspaceEvents.mcDragDrop.Notify(Self, FDragDropEventParams);
    end;


end;

{------------------------------------------------------------------------------}
{ TppWorkspace.DragOver }

procedure TppWorkspace.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

  inherited;

  if (FEventHub <> nil) then
    begin
      Accept := True;
      FDragOverEventParams.Update(Source, X, Y, State, Accept);
      FEventHub.WorkspaceEvents.mcDragOver.Notify(Self, FDragOverEventParams);
    end;


end;

{------------------------------------------------------------------------------}
{ TppWorkspace.KeyDown }

procedure TppWorkspace.KeyDown(var Key: Word; Shift: TShiftState);
begin

  if (FEventHub <> nil) then
    begin
      FKeyEventParams.Update(Key, Shift);
      FEventHub.WorkspaceEvents.mcKeyDown.Notify(Self, FKeyEventParams);
      Key := FKeyEventParams.Key;
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.KeyUp }

procedure TppWorkspace.KeyUp(var Key: Word; Shift: TShiftState);
begin

  if (FEventHub <> nil) then
    begin
      FKeyEventParams.Update(Key, Shift);
      FEventHub.WorkspaceEvents.mcKeyUp.Notify(Self, FKeyEventParams);
      Key := FKeyEventParams.Key;
    end;

 inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseDown }

procedure TppWorkspace.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if not(Focused) then
    SetFocus();

  if (FEventHub <> nil) then
    begin
      FMouseEventParams.Update(Button, Shift, X, Y);
      FEventHub.WorkspaceEvents.mcMouseDown.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseMove }

procedure TppWorkspace.MouseMove(Shift: TShiftState; X, Y: Integer);
begin

  if (FEventHub <> nil) then
    begin
      FMouseEventParams.Update(mbLeft, Shift, X, Y);
      FEventHub.WorkspaceEvents.mcMouseMove.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;


{------------------------------------------------------------------------------}
{ TppWorkspace.MouseUp }

procedure TppWorkspace.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (FEventHub <> nil) then
    begin
      FMouseEventParams.Update(Button, Shift, X, Y);
      FEventHub.WorkspaceEvents.mcMouseUp.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.Paint }

procedure TppWorkspace.Paint;
var
  liIndex: Integer;
begin

  inherited Paint;

  {paint the grid}
  if FGridOptions.Visible then
    FGridPainter.Paint();

  {paint column background, if needed}
  if (FReport <> nil) and (FReport.Columns > 1) then
    begin

      {draw gray rectangle for column background }
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := clBtnShadow;
      Canvas.FillRect(FColumnBackgroundRect);
      
    end;

  // paint bounds rects
  FBoundsRects.Sort;
  for liIndex := 0 to FBoundsRects.Count-1 do
    FBoundsRects[liIndex].Paint;

  // paint design guides
//  FDesignGuides.Paint;

  if Assigned(FOnPaint) then FOnPaint(Self);

  if (FEventHub <> nil) then
    FEventHub.WorkspaceEvents.mcPaint.Notify(Self, nil);


end;

{------------------------------------------------------------------------------}
{ TppWorkspace.ehGridOptions_Change }

procedure TppWorkspace.ehGridOptions_Change(Sender: TObject);
begin
  FGridPainter.Reset;

  Invalidate;

end;

{------------------------------------------------------------------------------}
{ TppDesignWorkArea.ehReport_LayoutChange }

procedure TppWorkspace.ehReport_LayoutChange(Sender, aParameterList: TObject);
begin

  CalcSize;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.GetBottom}

function TppWorkspace.GetBottom: Integer;
begin

  Result := Height - TppBandControl.PanelHeight;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.GetColumnBackground}

function TppWorkspace.GetColumnBackground: Boolean;
begin

  if (FReport <> nil) then
    Result := (FReport.Columns > 1)
  else
    Result := False;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.SetColumnBackgroundRect}

procedure TppWorkspace.SetColumnBackgroundRect(const Value: TRect);
begin
  FColumnBackgroundRect := Value;
  Invalidate;
end;

{------------------------------------------------------------------------------}
{ TppDesignWorkArea.SetEventHub }

procedure TppWorkspace.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub <> nil) then
    begin
//      FEventHub.ReportEvents.mcUnitsChange.RemoveNotify(ehReport_UnitsChange);
      FEventHub.ReportEvents.mcLayoutChange.RemoveNotify(ehReport_LayoutChange);
      FEventHub.BandEvents.mcDesignControlCreate.RemoveNotify(ehBand_DesignControlCreate);
      FEventHub.BandEvents.mcHeightChange.RemoveNotify(ehBand_HeightChange);
      FEventHub.BandEvents.mcDestroy.RemoveNotify(ehBand_HeightChange);
      FEventHub.ComponentEvents.mcDesignControlCreate.RemoveNotify(ehComponent_DesignControlCreate);
    end;

  FEventHub := aEventHub;

  if (FEventHub <> nil) then
    begin
//      FEventHub.ReportEvents.mcUnitsChange.AddNotify(ehReport_UnitsChange);
      FEventHub.ReportEvents.mcLayoutChange.AddNotify(ehReport_LayoutChange);
      FEventHub.BandEvents.mcDesignControlCreate.AddNotify(ehBand_DesignControlCreate);
      FEventHub.BandEvents.mcDestroy.AddNotify(ehBand_HeightChange);
      FEventHub.BandEvents.mcHeightChange.AddNotify(ehBand_HeightChange);
      FEventHub.ComponentEvents.mcDesignControlCreate.AddNotify(ehComponent_DesignControlCreate);
    end;


end;

{------------------------------------------------------------------------------}
{ TppWorkspace.SetGridOptions}

procedure TppWorkspace.SetGridOptions(const Value: TppWorkspaceGridOptions);
begin

  if FGridOptions <> Value then
    begin
      FGridOptions.Assign(Value);
      Invalidate;
    end;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.SetReport }

procedure TppWorkspace.SetReport(const Value: TppCustomReport);
begin

  if FReport <> Value then
    begin
      FReport := Value;
      FGridPainter.Report := Value;

      if (FReport <> nil) then
        CalcSize();

      if (FReport <> nil) and (FReport.MainReport <> nil) and (FReport.MainReport.DesignEventHub <> nil) then
        SetEventHub(TppDesignEventHub(FReport.MainReport.DesignEventHub))
      else
        SetEventHub(nil);

      Invalidate;

    end;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.UpdateColumnBackground }

procedure TppWorkspace.UpdateColumnBackground;
var
  lColHeaderBand: TppBand;
  lColFooterBand: TppBand;
  lRect: TRect;
begin

  if (FReport <> nil) and (FReport.Columns > 1) then
    begin
      lRect := FColumnBackgroundRect;

      lRect.Left  := FReport.spColumnWidth;
      lRect.Right := Width;

      {calc column background top, height}
      lColHeaderBand  := FReport.GetBand(btColumnHeader,0);
      lColFooterBand := FReport.GetBand(btColumnFooter,0);

      if (lColHeaderBand <> nil) and (lColFooterBand <> nil) then
        begin
          lRect.Top    := lColHeaderBand.spTop;
          lRect.Bottom := lColFooterBand.spTop + lColFooterBand.spHeight + TppBandControl.PanelHeight - 1;

          FColumnBackgroundRect := lRect;
        end;
    end;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.UpdateColumnBackground }

procedure TppWorkspace.CMMouseLeave(var Message: TMessage);
begin

  if (FEventHub <> nil) then
    FEventHub.WorkspaceEvents.mcMouseLeave.Notify(Self, nil);

end;

function TppWorkspace.IndexOfControl(aControl: TControl): Integer;
var
  lbFound: Boolean;
  liIndex: Integer;
begin
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < ControlCount) do
    if (Controls[liIndex] = aControl) then
      lbFound := True
    else
      Inc(liIndex);

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;



procedure TppWorkspace.UpdateZOrder(aControl: TControl; aOrder: Integer);
begin
  SetChildOrder(aControl, aOrder);
end;

procedure TppWorkspace.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  // want arrow keys
  Message.Result := Message.Result or DLGC_WANTARROWS;

end;

{******************************************************************************
*
*  TppDocHistory
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDocHistory.Create }

constructor TppDocHistory.Create(aOwner: TComponent; aParentMenu: TMenuItem);
begin
  inherited Create;

  FHistory     := TStringList.Create;
  FHistoryData := TStringList.Create;

  FOwner       := aOwner;
  FParentMenu  := aParentMenu;

  FSeparatorMenuItem := nil;
  FOnMenuItemClick   := nil;

  LoadStateInfo;

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.Destroy }

destructor TppDocHistory.Destroy;
var
  liData: Integer;

begin

  SaveStateInfo;

  FHistory.Free;

  {free the TStringlist objects store in FHistoryData}
  for liData := 0 to FHistoryData.Count-1 do
    FHistoryData.Objects[liData].Free;

  FHistoryData.Free;

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.SetMenuItemClick }

procedure TppDocHistory.SetMenuItemClick(aNotifyEvent: TNotifyEvent);
var
  liMenuItem: Integer;

begin
  FOnMenuItemClick := aNotifyEvent;

  for liMenuItem := 0 to FHistory.Count-1 do
    MenuItems[liMenuItem].OnClick := FOnMenuItemClick;

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.LoadStateInfo }

procedure TppDocHistory.LoadStateInfo;
var
  liItem: Integer;
  lsItemData: String;
  lItemData: TStrings;
  lHistory: TStringList;
  lIniStorage: TppIniStorage;

begin
  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lHistory := TStringList.Create;

  FHistory.Clear;

  FHistoryMax := lIniStorage.ReadInteger('Last Reports Accessed', 'Max', 5);

  for liItem := 0 to FHistoryMax do
    begin

      lsItemData := lIniStorage.ReadString('Last Reports Accessed','R'+IntToStr(liItem),'');

      if (lsItemData <> '') then
        begin
          lItemData := ItemDataFromString(lsItemData);
          lHistory.AddObject(lItemData[0], lItemData);
        end;

    end;

  {note: items get added to the front of the list }
  for liItem := lHistory.Count-1 downto 0 do
    AddItem(lHistory[liItem], TStrings(lHistory.Objects[liItem]));

  SetMenuItemCaptions;

  lHistory.Free;
  lIniStorage.Free;

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.SaveStateInfo }

procedure TppDocHistory.SaveStateInfo;
var
  liReport: Integer;
  lsItemData: String;
  lIniStorage: TppIniStorage;

begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  lIniStorage.EraseSection('Last Reports Accessed');

  lIniStorage.WriteInteger('Last Reports Accessed', 'Max', FHistoryMax);

  for liReport := 0 to (FHistory.Count-1) do
    begin
      lsItemData := ItemDataToString(GetDataForItemName(FHistory[liReport]));

      lIniStorage.WriteString('Last Reports Accessed','R'+IntToStr(liReport),lsItemData);
    end;

  lIniStorage.Free;

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.GetItemData}

function TppDocHistory.GetItemData(aMenuItem: TMenuItem): TStrings;
var
  lsName: String;

begin

  lsName := GetItemName(aMenuItem);

  Result := GetDataForItemName(lsName);

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.GetMenuItemForIndex}

function TppDocHistory.GetMenuItemForIndex(aIndex: Integer): TMenuItem;
begin
  Result := TMenuItem(FHistory.Objects[aIndex]);
end;

{------------------------------------------------------------------------------}
{ TppDocHistory.GetItemCount}

function TppDocHistory.GetItemCount: Integer;
begin
  Result := FHistory.Count;
end;

{------------------------------------------------------------------------------}
{ TppDocHistory.GetDataForItemName}

function TppDocHistory.GetDataForItemName(aName: String): TStrings;
var
  liItemData: Integer;

begin
  liItemData := FHistoryData.IndexOf(aName);
  Result := TStrings(FHistoryData.Objects[liItemData]);
end;

{------------------------------------------------------------------------------}
{ TppDocHistory.GetItemName}

function TppDocHistory.GetItemName(aMenuItem: TMenuItem): String;
begin
  Result := FHistory[FHistory.IndexOfObject(aMenuItem)];

end;


{------------------------------------------------------------------------------}
{ TppDocHistory.ItemDataFromString}

function TppDocHistory.ItemDataFromString(aString: String): TStrings;
var
  liComma: Integer;
  liCount: Integer;
  lsString: String;
begin

  Result := TStringList.Create;

  lsString := aString;

  while Length(lsString) > 0 do
    begin

      liComma := Pos( ',', lsString);

      if liComma = 0 then
        liCount := Length(lsString)
      else
        liCount := liComma-1;

      Result.Add(Copy(lsString,0, liCount));

      lsString := Copy(lsString, liCount+2,Length(lsString));

    end;

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.ItemDataToString}

function TppDocHistory.ItemDataToString(aData: TStrings): String;
var
  liItem: Integer;

begin

  Result := '';

  for liItem := 0 to aData.Count-1 do
    if liItem = 0 then
      Result := aData[liItem]
    else
      Result := Result + ',' + aData[liItem];

end;

{------------------------------------------------------------------------------}
{ TppDocHistory.UpdateItem}

procedure TppDocHistory.UpdateItem(aName: String; aData: TStrings);
var
  liHistory: Integer;
  lItemData: TStrings;

begin

  {determine whether this item already in history}
  liHistory := FHistory.IndexOf(aName);

  if liHistory = 0 then Exit;

  {delete item from history, if needed}
  if liHistory > 0 then
    DeleteItem(liHistory);

  {add item to front of history}
  lItemData := TStringList.Create;
  lItemData.Assign(aData);
  AddItem(aName, lItemData);

  {delete last item in history list, if too many items }
  if (FHistory.Count > FHistoryMax) then
    DeleteItem(FHistory.Count-1);

  {update menu item captions}
  SetMenuItemCaptions;


end;


{------------------------------------------------------------------------------}
{ TppDocHistory.AddItem}

procedure TppDocHistory.AddItem(aName: String; aData: TStrings);
var
  liMenuIndex: Integer;
  lMenuItem: TMenuItem;

begin

  {create new menu item}
  lMenuItem := TMenuItem.Create(FOwner);
  lMenuItem.OnClick := FOnMenuItemClick;

  {add new item to menu}
  if (FSeparatorMenuItem = nil) then
    begin
      {add separator menu item, this is the line on the menu}
      FSeparatorMenuItem := TMenuItem.Create(FOwner);
      FSeparatorMenuItem.Caption := '-';
      FParentMenu.Add(FSeparatorMenuItem);

      FParentMenu.Add(lMenuItem)
    end
  else
    begin
      liMenuIndex := FParentMenu.IndexOf(MenuItems[0]);
      FParentMenu.Insert(liMenuIndex, lMenuItem);
    end;

  {add item to front of history list }
  FHistory.InsertObject(0, aName, lMenuItem);
  FHistoryData.InsertObject(0, aName, aData);

end;


{------------------------------------------------------------------------------}
{ TppDocHistory.DeleteItem}

procedure TppDocHistory.DeleteItem(aIndex: Integer);
var
  liMenuIndex: Integer;
  liDataIndex: Integer;

begin

  liMenuIndex := FParentMenu.IndexOf(MenuItems[aIndex]);

  if liMenuIndex >= 0 then
    FParentMenu.Delete(liMenuIndex);

  {delete item data}
  liDataIndex := FHistoryData.IndexOf(FHistory[aIndex]);
  if liDataIndex >= 0 then
    begin
      FHistoryData.Objects[liDataIndex].Free;
      FHistoryData.Delete(liDataIndex);
    end;

  FHistory.Delete(aIndex);

end;


{------------------------------------------------------------------------------}
{ TppDocHistory.SetMenuItemCaptions}

procedure TppDocHistory.SetMenuItemCaptions;
var
  liHistory: Integer;

begin
  for liHistory := 0 to FHistory.Count-1 do
    MenuItems[liHistory].Caption := '&' + IntToStr(liHistory+1) +
                                          ' ' + FHistory[liHistory];
end;


{******************************************************************************
*
*  Workspace Grid Options
*
******************************************************************************}

constructor TppWorkspaceGridOptions.Create;
begin

  FSpacingX := 8;
  FSpacingY := 8;

  FVisible := True;
  FSnapToGrid := True;

  inherited;

end;

procedure TppWorkspaceGridOptions.Assign(Source: TPersistent);
var
  lSource: TppWorkspaceGridOptions;
begin

  if (Source is TppWorkspaceGridOptions) then
    begin
      lSource := TppWorkspaceGridOptions(Source);
      FSnapToGrid := lSource.SnapToGrid;
      FVisible := lSource.Visible;
      FSpacingX := lSource.SpacingX;
      FSpacingY := lSource.SpacingY;
    end;

  inherited;
  
end;

procedure TppWorkspaceGridOptions.DoOnChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
  
end;

procedure TppWorkspaceGridOptions.SetVisible(const Value: Boolean);
begin

  if FVisible <> Value then
    begin
      FVisible := Value;
      DoOnChange;
    end;

end;

procedure TppWorkspaceGridOptions.SetSpacingX(const Value: Integer);
begin
  if FSpacingX <> Value then
  begin
    FSpacingX := Value;
    DoOnChange;
  end;
end;

procedure TppWorkspaceGridOptions.SetSpacingY(const Value: Integer);
begin
  if FSpacingY <> Value then
  begin
    FSpacingY := Value;
    DoOnChange;
  end;
end;


{******************************************************************************
*
*  Workspace Grid Painter
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.Create}

constructor TppWorkspaceGridPainter.Create(aWorkspace: TppWorkspace);
begin

  inherited Create;

  FWorkspace := aWorkspace;

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.Destroy}

destructor TppWorkspaceGridPainter.Destroy;
begin

  FGridImage.Free;
  FGridImage := nil;
  
  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.DrawEmptyGrid}

procedure TppWorkspaceGridPainter.DrawEmptyGrid(aCanvas: TCanvas);
var
  liTop: Integer;
begin

  liTop := 0;

  aCanvas.Pen.Color := clDkGray;

  while (liTop <= FWorkspace.Height) do
    begin
      // draw grid dots
      DrawGridRow(aCanvas, liTop, 0, FWorkspace.Width);

      Inc(liTop, FWorkspace.GridOptions.SpacingY);

    end;


end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.DrawGridDots}

procedure TppWorkspaceGridPainter.DrawGridRow(aCanvas: TCanvas; aPosY, aFromPosX, aToPosX: Integer);
begin

  while (aFromPosX <= aToPosX) do
    begin
      aCanvas.MoveTo(aFromPosX, aPosY);
      aCanvas.LineTo(aFromPosX, aPosY + 1);

      Inc(aFromPosX, FWorkspace.GridOptions.SpacingX);
    end;

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.DrawGridImage}

procedure TppWorkspaceGridPainter.DrawGridImage(aCanvas: TCanvas);
begin


  if (FReport = nil) then
    DrawEmptyGrid(aCanvas)

  else
    DrawReportGrid(aCanvas);

end; {procedure, DrawGridImage}


{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.DrawReportGrid}

procedure TppWorkspaceGridPainter.DrawReportGrid(aCanvas: TCanvas);
var
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liBand: Integer;
  liHeight: Integer;
begin

  if (FReport = nil) then Exit;

  aCanvas.Pen.Color := clDkGray;

  liTop := 0;
  liHeight := 0;

  for liBand := 0 to FReport.BandCount - 1 do
    begin

      liHeight := liHeight + FReport.Bands[liBand].spHeight;

      while (liTop <= liHeight) do
        begin

          liLeft := 0;

          if FWorkspace.ColumnBackground and
             (liTop >= FWorkspace.ColumnBackgroundRect.Top) and
             (liTop <= FWorkspace.ColumnBackgroundRect.Bottom) then

            liWidth := FWorkspace.Width - (FWorkspace.ColumnBackgroundRect.Right - FWorkspace.ColumnBackgroundRect.Left) - 1

          else
            liWidth := FWorkspace.Width;

          // draw grid dots
          DrawGridRow(aCanvas, liTop, liLeft, liWidth);

          Inc(liTop, FWorkspace.GridOptions.SpacingY);

        end; {draw dots top to bottom}

      {move height beyond band control}
      liHeight := liHeight + TppBandControl.PanelHeight;

      {set to top of next band}
      liTop := liHeight;

    end; {for each band}

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.GetGridImage}

function TppWorkspaceGridPainter.GetGridImage: TBitmap;
begin

  if not IsValidGridImage(FGridImage) then
    begin    
      FGridImage.Free;

      FGridImage := TBitmap.Create;
      FGridImage.Width := FWorkspace.Width;
      FGridImage.Height := FWorkspace.Height;

      DrawGridImage(FGridImage.Canvas);
    end;

  Result := FGridImage;

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.IsValidGridImage}

function TppWorkspaceGridPainter.IsValidGridImage(aGridImage: TBitmap): Boolean;
begin

  Result :=  (aGridImage <> nil) and
             (aGridImage.Width  = FWorkspace.Width) and
             (aGridImage.Height = FWorkspace.Height);

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.Paint}

procedure TppWorkspaceGridPainter.Paint;
begin

  if (FWorkspace.GridOptions.Visible) then
    FWorkspace.Canvas.CopyRect(FWorkspace.Canvas.ClipRect, GetGridImage.Canvas, FWorkspace.Canvas.ClipRect);

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.Reset}

procedure TppWorkspaceGridPainter.Reset;
begin

  FGridImage.Free;
  FGridImage := nil;

end;

{------------------------------------------------------------------------------}
{ TppWorkspaceGridPainter.SetReport}

procedure TppWorkspaceGridPainter.SetReport(const Value: TppCustomReport);
begin

  if FReport <> Value then
    begin
      FReport := Value;
      Reset();
    end;

end;

{******************************************************************************
*
*  D e s i g n   G  u i d e
*
******************************************************************************}

constructor TppDesignGuide.Create;
begin
  inherited;
  FBackImage := TBitmap.Create;

end;

destructor TppDesignGuide.Destroy;
begin
  FBackImage.Free;
  FBackImage := nil;

  inherited;
end;

procedure TppDesignGuide.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

procedure TppDesignGuide.EndUpdate;
begin

  if FUpdateCounter <= 0 then Exit;

  Dec(FUpdateCounter);

  if (FUpdateCounter = 0) then
    if FVisible then
      begin
        SaveBackgroundImage();
        Paint();
      end

end;

procedure TppDesignGuide.Erase;
begin
  SetVisible(False);
end;

procedure TppDesignGuide.Paint;
begin
  if not Visible then Exit;

  FCanvas.Pen.Color := clHighlight; //clBlue;
  FCanvas.Pen.Style := psSolid;
  FCanvas.Pen.Mode := pmCopy;
  FCanvas.Pen.Width := 1;
  FCanvas.MoveTo(FBeginPoint.X, FBeginPoint.Y);
  FCanvas.LineTo(FEndPoint.X, FEndPoint.Y);

end;

procedure TppDesignGuide.RestoreBackgroundImage;
var
  lDestRect: TRect;
  lSrcRect: TRect;
begin
{.$IFDEF CodeSite}
//  CodeSite.Send('TppDesignGuide.RestoreBackgroundImage');
{.$ENDIF}

  lDestRect:= Rect(FBeginPoint.X-1, FBeginPoint.Y-1,  FBeginPoint.X-1 + FBackImage.Width,  FBeginPoint.Y-1 + FBackImage.Height);
  lSrcRect := Rect(0, 0, FBackImage.Width, FBackImage.Height);

  FCanvas.CopyMode := cmSrcCopy;

  FCanvas.CopyRect(lDestRect, FBackImage.Canvas, lSrcRect);

end;

procedure TppDesignGuide.SaveBackgroundImage;
var
  lDestRect: TRect;
  lSrcRect: TRect;
begin
{.$IFDEF CodeSite}
//  CodeSite.Send('TppDesignGuide.SaveBackgroundImage');
{.$ENDIF}


  if (FEndPoint.X = FBeginPoint.X) then
    FBackImage.Width := 2
  else
    FBackImage.Width := FEndPoint.X - FBeginPoint.X + 2;

  if (FEndPoint.Y = FBeginPoint.Y) then
    FBackImage.Height := 2
  else
    FBackImage.Height := FEndPoint.Y - FBeginPoint.Y + 2;

  lDestRect := Rect(0, 0, FBackImage.Width, FBackImage.Height);
  lSrcRect := Rect(FBeginPoint.X-1, FBeginPoint.Y-1, FBeginPoint.X-1 + FBackImage.Width, FBeginPoint.Y-1 + FBackImage.Height);

  FBackImage.Canvas.CopyRect(lDestRect, FCanvas, lSrcRect);

end;

procedure TppDesignGuide.SetBeginPoint(const Value: TPoint);
begin
  FBeginPoint := Value;

end;

procedure TppDesignGuide.SetEndPoint(const Value: TPoint);
begin
  FEndPoint := Value;

end;

procedure TppDesignGuide.SetVisible(const Value: Boolean);
begin

  if (FVisible <> Value) then
    begin
      FVisible := Value;

      if FUpdateCounter > 0 then Exit;

      if FVisible then
        begin
          SaveBackgroundImage();
          Paint();
        end
      else
        RestoreBackgroundImage();
    end;

end;

{******************************************************************************
*
*  D e s i g n   G u i d e  C o l l e c t i o n
*
******************************************************************************}

constructor TppDesignGuideCollection.Create;
begin

  inherited;

  FLeft := TppDesignGuide.Create;
  FTop := TppDesignGuide.Create;
  FRight := TppDesignGuide.Create;
  FBottom := TppDesignGuide.Create;

end;

destructor TppDesignGuideCollection.Destroy;
begin

  FLeft.Free;
  FLeft := nil;

  FTop.Free;
  FTop := nil;

  FRight.Free;
  FRight := nil;
  
  FBottom.Free;
  FBottom := nil;

  inherited;
end;

procedure TppDesignGuideCollection.Erase;
begin
  FLeft.Erase;
  FTop.Erase;
  FRight.Erase;
  FBottom.Erase;
end;

procedure TppDesignGuideCollection.Paint;
begin
  FLeft.Paint;
  FTop.Paint;
  FRight.Paint;
  FBottom.Paint;
end;

procedure TppDesignGuideCollection.SetCanvas(const Value: TCanvas);
begin

  if (FLeft = nil) then Exit;

  FCanvas := Value;
  FLeft.Canvas := Value;
  FTop.Canvas := Value;
  FRight.Canvas := Value;
  FBottom.Canvas := Value;

end;






end.
