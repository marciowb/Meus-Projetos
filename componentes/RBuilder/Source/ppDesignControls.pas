{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppDesignControls;

interface

{$I ppIfDef.pas}


uses
  Windows,
  Variants,
  Classes,
  Controls,
  Graphics,
  ExtCtrls,
  Forms,
  Dialogs,
  Types,

  ppCollectionBase,
  ppTypes,
  ppUtils,
  ppRTTI,
  ppClass,
  ppComm,
  ppRuler,
  ppPrintr,
  ppDesignEventHub,
  ppDesignerWorkspace;

type

  TppDesignControl = class;
  TppBandControl = class;

  {TppDesignControlRegistryItem}
  TppDesignControlRegistryItem = class
    private
      FDesignControlClass: TClass;
      FComponentClass: TClass;

    public
      constructor Create(aComponentClass, aDesignControlClass: TClass); virtual;

      property ComponentClass: TClass read FComponentClass;
      property DesignControlClass: TClass read FDesignControlClass write FDesignControlClass;

    end;

  {TppDesignControlRegistry}
  TppDesignControlRegistry = class(TppCollectionBase)
    private
      function  GetItemForClass(aComponentClass: TClass): TppDesignControlRegistryItem;
      function GetItemForIndex(aIndex: Integer): TppDesignControlRegistryItem;

    public
      constructor Create; override;

      function IndexOf(aComponentClass: TClass): Integer;

      procedure Add(aComponentClass, aDesignControlClass: TClass);
      procedure Remove(aComponentClass: TClass);

      property Items[ComponentClass: TClass]: TppDesignControlRegistryItem read GetItemForClass; default;

    end;

  {TppDesignControlFactory}
  TppDesignControlFactory = class
    private

     class procedure ClassCreate;
     class procedure ClassDestroy;

    public
      class procedure RegisterDesignControlClass(aComponentClass: TClass; aDesignControlClass: TClass);
      class procedure UnRegisterDesignControlClass(aComponentClass: TClass);

      class function CreateInstance(aComponent: TppComponent): TppDesignControl;

  end;

  {TppDesignControlCollection}
  TppDesignControlCollection = class(TppCollectionBase)
    private
      function GetItemForComponent(aComponent: TppComponent): TppDesignControl;
      function GetItemForIndex(aIndex: Integer): TppDesignControl;

    public

      function IndexOf(aComponent: TppComponent): Integer;

      procedure Add(aDesignControl: TppDesignControl);
      procedure Remove(aDesignControl: TppDesignControl);

      property Items[Component: TppComponent]: TppDesignControl read GetItemForComponent; default;

    end;

  {TppBandControlCollection}
  TppBandControlCollection = class(TppCollectionBase)
    private
      function GetItemForBand(aBand: TppBand): TppBandControl;
      function GetItemForIndex(aIndex: Integer): TppBandControl;

    public

      function IndexOf(aBand: TppBand): Integer;

      procedure Add(aBandControl: TppBandControl);
      procedure Remove(aBandControl: TppBandControl);

      property ItemsByIndex[Index: Integer]: TppBandControl read GetItemForIndex;
      property Items[Band: TppBand]: TppBandControl read GetItemForBand; default;

    end;

 
  {TppDesignControlManager}
  TppDesignControlManager = class(TppCommunicator)
    private
      FReport: TppCustomReport;
      FDesignControls: TppDesignControlCollection;
      FBandControls: TppBandControlCollection;
      FSelectionObjects: TppSelectionObjectCollection;

      function GetBandControlForBand(aBand: TppBand): TppBandControl;
      function GetDesignControlForComponent(aComponent: TppComponent): TppDesignControl;
      procedure SetReport(aReport: TppCustomReport);

      procedure CreateDesignControls;
      procedure FreeDesignControls;

      {event notify handlers}
      procedure enReportComponentAdded(aComponent: TppComponent);
      procedure enReportComponentRemoved(aComponent: TppComponent);
      function GetBandControlByIndex(Index: Integer): TppBandControl;
      function GetBandControlCount: Integer;

      function GetDesignControlCount: Integer;
      function GetDesignControlForIndex(Index: Integer): TppDesignControl;

    protected
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;


    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure SendDesignMessage(aMsg, aWParam: Integer; aOParam: TObject); override;

      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      function CreateDesignControl(aBand: TppBand): TppBandControl; overload;
      function CreateDesignControl(aComponent: TppComponent): TppDesignControl; overload;

      procedure FreeDesignControl(aBand: TppBand); overload;
      procedure FreeDesignControl(aComponent: TppComponent); overload;

      property BandControlsByIndex[Index: Integer]: TppBandControl read GetBandControlByIndex;
      property BandControlCount: Integer read GetBandControlCount;
      property DesignControlCount: Integer read GetDesignControlCount;
      property DesignControlsByIndex[Index: Integer]: TppDesignControl read GetDesignControlForIndex;
      property BandControls[Band: TppBand]: TppBandControl read GetBandControlForBand;
      property DesignControls[Component: TppComponent]: TppDesignControl read GetDesignControlForComponent;
      property SelectionObjects: TppSelectionObjectCollection read FSelectionObjects;
      property Report: TppCustomReport read FReport write SetReport;

  end;


  {TppDesignControl}
  TppDesignControl = class(TGraphicControl)
  private
    FComponent: TppComponent;
    FFrameStyle: TppFrameStyleType;
    FOnPaint: TppPaintEvent;
    FBoundsLocks: TppBoundsLockStates;
    FOffScreenBitmap: TBitmap;
    FValidImage: Boolean;
    FWalkieTalkie: TppCommunicator;
    FDesignControlManager: TppDesignControlManager;
    FDragDropEventParams: TppDragDropEventParams;
    FDragOverEventParams: TppDragOverEventParams;
    FMouseEventParams: TppMouseEventParams;

    function GetEventHub: TppDesignEventHub;
    function GetOffScreenCanvas: TCanvas;
    function GetRTTIClass: TraRTTIClass;
    
  protected
    function  AdjustObject(aBorder: TppBorder; aClientRect: TRect; aAlignment: TppTextAlignment): TRect;
    function  AlignmentToTextAlignment(aAlignment: TAlignment): TppTextAlignment;
    procedure BoundsLocksChanged; virtual;
    function  CanOptimizeDesignPainting: Boolean; virtual;
    procedure ComponentBoundsChanged; virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    function  GetColor: TColor;
    function  IsTransparent: Boolean; virtual;
    procedure PaintBackground(aCanvas: TCanvas; aClientRect: TRect; aBorder: TppBorder; aColor: TColor);
    procedure PaintBorder(aCanvas: TCanvas; aBorder: TppBorder); virtual;
    procedure Paint; override;
    procedure PaintDesignControl(aCanvas: TCanvas); virtual;
    procedure PaintFrame(aCanvas: TCanvas); virtual;
    procedure SendDesignMessage(aMsg: Integer; aWParam: Integer; aLParam: TObject);

    procedure SetComponent(aComponent: TppComponent); virtual;
    function  GetComponent: TppCommunicator; virtual;

    function IsValidPropName(const aPropName: String): Boolean;
    function GetPropValue(const aPropName: String; var aValue): Boolean;
    function SetPropValue(const aPropName: String; var aValue): Boolean;

    procedure ehWalkieTalkieEventNotify(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); virtual;
    procedure ehWalkieTalkieNotify(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property Canvas;
    property EventHub: TppDesignEventHub read GetEventHub;
    property FrameStyle: TppFrameStyleType read FFrameStyle write FFrameStyle;
    property OffScreenCanvas: TCanvas read GetOffScreenCanvas;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;

   // TControl overrides
    procedure SetBounds(aLeft, aTop, aWidth, aHeight: Integer); override;
    procedure Invalidate; override;

    property DesignControlManager: TppDesignControlManager read FDesignControlManager write FDesignControlManager;
    property BoundsLocks: TppBoundsLockStates read FBoundsLocks write FBoundsLocks;
    property Color;
    property Component: TppComponent read FComponent write SetComponent;
    property PopupMenu;
    property WalkieTalkie: TppCommunicator read FWalkieTalkie;

    // events used by TppDesignerWindow
    property OnDragDrop;
    property OnDragOver;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

  end; {class, TppDesignControl}


  
  {@TppBandControl}
  TppBandControl = class(TPanel)
    private
      FBand: TppBand;
      FRuler: TppRuler;
      FOnPaint: TNotifyEvent;
      FWalkieTalkie: TppCommunicator;
      FDesignControlManager: TppDesignControlManager;
      FMouseEventParams: TppMouseEventParams;

      procedure CreateRuler;
      function GetBottomOfControls: Integer;

      procedure SetBand(aBand: TppBand);

      {event notify handlers}
      procedure enAfterBandHeightChange(aParams: TraParamList);
      procedure enBeforeBandHeightChange(aParams: TraParamList);
      procedure enBandResize(aParams: TraParamList);
      procedure enSetBandTop(aParams: TraParamList);
      procedure enGetBandTop(aParams: TraParamList);
      function GetEventHub: TppDesignEventHub;

    protected
      procedure Notification(aComponent: TComponent; Operation: TOperation); override;
      procedure Paint; override;
      property EventHub: TppDesignEventHub read GetEventHub;
      property WalkieTalkie: TppCommunicator read FWalkieTalkie;

      procedure ehWalkieTalkieEventNotify(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); virtual;
      procedure ehWalkieTalkieNotify(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType); virtual;
      procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
      procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
      procedure SendDesignMessage(aMsg: Integer; aWParam: Integer; aLParam: TObject);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      class function PanelHeight: Integer;

      property DesignControlManager: TppDesignControlManager read FDesignControlManager write FDesignControlManager;
      property Band: TppBand read FBand write SetBand;
      property BottomOfControls: Integer read GetBottomOfControls;
      property Ruler: TppRuler read FRuler;
      property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;

  end; {class, TppBandControl}


implementation

uses
  ppDesignControlsEx,
  ppCtrls,
  ppMemo,
  ppVar,
  ppBarCod,
  ppBarCode2D,
  ppBarCode2DDesign,
  ppRichTx,
  ppRegion,
  ppSubRpt,
  ppPageBreak,
  ppPaintBox,
  ppPaintBoxDesign,
  ppPopupMenus;

var
  uDesignControlRegistry: TppDesignControlRegistry;


{******************************************************************************
 *
 ** D E S I G N   C O N T R O L   F A C T O R Y
 *
{******************************************************************************}

{TppDesignControlFactory.ClassCreate }

class procedure TppDesignControlFactory.ClassCreate;
begin
  if uDesignControlRegistry <> nil then Exit;

  uDesignControlRegistry := TppDesignControlRegistry.Create;

  TppDesignControlFactory.RegisterDesignControlClass(TppComponent, TppDesignControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppLabel, TppLabelControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDBText, TppDBTextControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppMemo, TppMemoControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDBMemo, TppDBMemoControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppRichText, TppRichTextControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDBRichText, TppDBRichTextControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppVariable, TppVariableControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppSystemVariable, TppSystemVariableControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDBCalc, TppDBCalcControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppImage, TppImageControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDBImage, TppDBImageControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppShape, TppShapeControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppLine, TppLineControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppBarCode, TppBarCodeControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDBBarCode, TppDBBarCodeControl);
  TppDesignControlFactory.RegisterDesignControlClass(Tpp2DBarCode, Tpp2DBarCodeControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppDB2DBarCode, Tpp2DBarCodeControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppRegion, TppRegionControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppSubreport, TppSubreportControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppPageBreak, TppPageBreakControl);
  TppDesignControlFactory.RegisterDesignControlClass(TppPaintBox, TppPaintBoxControl);

end;

{TppDesignControlFactory.ClassDestroy }

class procedure TppDesignControlFactory.ClassDestroy;
begin
  uDesignControlRegistry.Free;
  uDesignControlRegistry := nil;

end;


{TppDesignControlFactory.CreateInstance }

class function TppDesignControlFactory.CreateInstance(aComponent: TppComponent): TppDesignControl;
var
  lRegistryItem: TppDesignControlRegistryItem;
  lClassType: TClass;
begin

  if (aComponent = nil) then
    raise EDesignError.Create('TppDesignControlFactory.CreateInstance: aComponent is nil');

  lRegistryItem := nil;
  lClassType := aComponent.ClassType;

  while ((lRegistryItem = nil) and (lClassType <> nil)) do
    begin
      lRegistryItem := uDesignControlRegistry.Items[lClassType];

      if (lRegistryItem = nil) then
        lClassType := lClassType.ClassParent;

    end;

  if (lRegistryItem = nil) then
    raise EDesignError.Create('TppDesignControlFactory.CreateInstance: No design control registered for ' + aComponent.ClassName);

  Result := TppDesignControl(TComponentClass(lRegistryItem.DesignControlClass).Create(nil));

end;

{TppDesignControlFactory.RegisterDesignControlClass }

class procedure TppDesignControlFactory.RegisterDesignControlClass(aComponentClass: TClass; aDesignControlClass: TClass);
begin
  if (uDesignControlRegistry = nil) then
    TppDesignControlFactory.ClassCreate;
  
  uDesignControlRegistry.Add(aComponentClass, aDesignControlClass);

end;

{TppDesignControlFactory.UnRegisterDesignControlClass }
class procedure TppDesignControlFactory.UnRegisterDesignControlClass(aComponentClass: TClass);
begin
  if uDesignControlRegistry = nil then Exit;

  uDesignControlRegistry.Remove(aComponentClass);

end;


{******************************************************************************
 *
 ** D E S I G N   C O N T R O L   R E G I S T R Y   I T E M
 *
{******************************************************************************}

{TppDesignControlRegistryItem.Create }

constructor TppDesignControlRegistryItem.Create(aComponentClass, aDesignControlClass: TClass);
begin

  inherited Create;

  FComponentClass := aComponentClass;
  FDesignControlClass := aDesignControlClass;

end;

{******************************************************************************
 *
 ** D E S I G N   C O N T R O L   R E G I S T R Y
 *
{******************************************************************************}

{TppDesignControlRegistry.Create }

constructor TppDesignControlRegistry.Create;
begin
  inherited;

  InnerList.OwnsObjects := True;

end;

{TppDesignControlRegistry.Add }

procedure TppDesignControlRegistry.Add(aComponentClass, aDesignControlClass: TClass);
var
  lRegistryItem: TppDesignControlRegistryItem;
  liIndex: Integer;
begin

  liIndex := IndexOf(aComponentClass);

  if (liIndex < 0) then
    begin
      lRegistryItem := TppDesignControlRegistryItem.Create(aComponentClass, aDesignControlClass);

      InnerList.Add(lRegistryItem);
    end
  else
    GetItemForIndex(liIndex).DesignControlClass := aDesignControlClass;

end;

{TppDesignControlRegistry.IndexOf }

function TppDesignControlRegistry.IndexOf(aComponentClass: TClass): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lRegistryItem: TppDesignControlRegistryItem;
begin

  liIndex := 0;
  lbFound := False;

  while (not(lbFound) and (liIndex < InnerList.Count)) do
    begin
      lRegistryItem := GetItemForIndex(liIndex);

      if (lRegistryItem.ComponentClass = aComponentClass) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if (lbFound) then
    Result := liIndex
  else
    Result := -1;

end;

{TppDesignControlRegistry.Remove }

procedure TppDesignControlRegistry.Remove(aComponentClass: TClass);
var
  lRegistryItem: TppDesignControlRegistryItem;
begin
  lRegistryItem := GetItemForClass(aComponentClass);

  if (lRegistryItem <> nil) then
    InnerList.Remove(lRegistryItem);

end;

{TppDesignControlRegistry.GetItemForIndex }

function TppDesignControlRegistry.GetItemForIndex(aIndex: Integer): TppDesignControlRegistryItem;
begin
  Result := TppDesignControlRegistryItem(InnerList[aIndex]);

end;

{TppDesignControlRegistry.GetItemForClass }

function TppDesignControlRegistry.GetItemForClass(aComponentClass: TClass): TppDesignControlRegistryItem;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aComponentClass);

  if (liIndex >= 0) then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;




{******************************************************************************
 *
 ** D e s i g n C o n t r o l
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDesignControl.Create }

constructor TppDesignControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FFrameStyle  := fsSolid;
  ControlStyle := ControlStyle + [csReplicatable];
  FBoundsLocks := [];

  FDragDropEventParams := TppDragDropEventParams.Create;
  FDragOverEventParams := TppDragOverEventParams.Create;
  FMouseEventParams := TppMouseEventParams.Create(mbLeft, [], 0, 0);

  FWalkieTalkie := TppCommunicator.Create(nil);
  
  FWalkieTalkie.OnEventNotify := ehWalkieTalkieEventNotify;
  FWalkieTalkie.OnNotify := ehWalkieTalkieNotify;

  FWalkieTalkie.EventNotifies := [ciComponentBoundsChanged,
                                  ciComponentInvalidateDesignControl,
                                  ciComponentParentWidthChanged,
                                  ciComponentParentHeightChanged];

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.Destroy }

destructor TppDesignControl.Destroy;
begin

  SetComponent(nil);

  FDragDropEventParams.Free;
  FDragDropEventParams := nil;

  FDragOverEventParams.Free;
  FDragOverEventParams := nil;

  FMouseEventParams.Free;
  FMouseEventParams := nil;
  
  FWalkieTalkie.Free;
  FWalkieTalkie := nil;

  FOffScreenBitmap.Free;
  FOffScreenBitmap := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.ehWalkieTalkieNotify }

procedure TppDesignControl.ehWalkieTalkieNotify(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType); 
begin

  if (aCommunicator = FComponent) and (aOperation = ppopRemove) then
    if not(csDestroying in ComponentState) then
      Free;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.ehWalkieTalkieEventNotify }

procedure TppDesignControl.ehWalkieTalkieEventNotify(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer;  aParams: TraParamList);
begin

  if (aCommunicator = FComponent) then
    if (aEventID = ciComponentBoundsChanged) then
      ComponentBoundsChanged
    else if (aEventID = ciComponentInvalidateDesignControl) then
      Invalidate
    else if ((aEventID = ciComponentParentWidthChanged) or (aEventID = ciComponentParentHeightChanged)) then
      BoundsLocksChanged;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.SendDesignMessage}

procedure TppDesignControl.SendDesignMessage(aMsg, aWParam: Integer; aLParam: TObject);
begin

  if (FComponent <> nil) then
    FComponent.SendDesignMessage(aMsg, aWParam, aLParam);

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.ComponentBoundsChanged }

procedure TppDesignControl.ComponentBoundsChanged;
var
  lClipRect: TRect;
  lClientRect: TRect;
begin

  {update design control bounds}
  lClipRect := FComponent.spClipRect;

  Visible := (lClipRect.Right > 0) and (lClipRect.Bottom > 0);

  if  Visible then
    begin

      lClientRect := FComponent.spClientRect;

      if FComponent.Region <> nil then
        begin

          if lClipRect.Right < lClientRect.Right then
            Dec(lClipRect.Right, 3);

          if lClipRect.Bottom < lClientRect.Bottom then
            Dec(lClipRect.Bottom, 3);

        end;

      // TODO: change this to use BandControl.Top??
      SetBounds(FComponent.spLeft, (FComponent.spTop + FComponent.Band.spTop), lClipRect.Right, lClipRect.Bottom);

    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignControl.BoundsLocksChanged }

procedure TppDesignControl.BoundsLocksChanged;
begin
  BoundsLocks := [];

  if (FComponent.ParentWidth) then
    BoundsLocks := [ppblLeft, ppblWidth];

  if (FComponent.ParentHeight) then
    BoundsLocks := BoundsLocks + [ppblTop, ppblHeight];

  SendDesignMessage(RM_BOUNDSLOCKCHANGE, ppWCustomMsg, FComponent);

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.BandMoved }

{procedure TppDesignControl.BandMoved;
begin

  Top := Component.spTop + Component.Band.spTop;

end; }

{------------------------------------------------------------------------------}
{ TppDesignControl.GetColor }

function TppDesignControl.GetColor: TColor;
var
  lColor: TColor;
  lbIsClear: Boolean;
begin

  FComponent.GetBackGroundColor(lColor, lbIsClear);

  Result := lColor;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.GetOffScreenCanvas }

function TppDesignControl.GetOffScreenCanvas: TCanvas;
begin

  {create on deman}
  if (FOffscreenBitmap = nil) then
    FOffscreenBitmap := TBitmap.Create;

  {set the size}
  if (FOffscreenBitmap.Width <> FComponent.spWidth) then
    FOffscreenBitmap.Width := FComponent.spWidth;

  if (FOffscreenBitmap.Height <> FComponent.spHeight) then
    FOffscreenBitmap.Height := FComponent.spHeight;

  Result := FOffscreenBitmap.Canvas;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.IsTransparent }

function TppDesignControl.IsTransparent: Boolean;
var
  lColor: TColor;
  lbIsClear: Boolean;
begin
  FComponent.GetBackGroundColor(lColor, lbIsClear);

  Result := lbIsClear;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.Paint }

procedure TppDesignControl.Paint;
begin

  if not(CanOptimizeDesignPainting) then
    PaintDesignControl(Canvas)

  else
    begin

      if not(FValidImage) then
        begin
          {render to offscreen canvas}
          PatBlt(OffScreenCanvas.Handle, 0, 0, FComponent.spWidth, FComponent.spHeight, WHITENESS);
          PaintDesignControl(OffScreenCanvas);
        end;

      {render to the real canvas}
      if IsTransparent then
        Canvas.CopyMode := cmSrcAnd
      else
        Canvas.CopyMode := cmSrcCopy;

       Canvas.CopyRect(Canvas.ClipRect, OffScreenCanvas, Canvas.ClipRect);

       FValidImage := True;

    end;

  if Assigned(FOnPaint) then FOnPaint(Canvas);

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.PaintBorder }

procedure TppDesignControl.PaintBorder(aCanvas: TCanvas; aBorder: TppBorder);
var
  liOffset: Integer;
  liLineWidth: Integer;
  lBorderPositions: TppBorderPositions;
  liBuffer: Integer;
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
begin

  liLineWidth := aBorder.SPWeight;
  liBuffer := 1;
  lBorderPositions := aBorder.BorderPositions;

  liLeft := liBuffer;
  liTop := liBuffer;
  liRight := Width - liBuffer;
  liBottom := Height - liBuffer;

  aCanvas.Pen.Style := aBorder.Style;
  aCanvas.Pen.Width := 1;
  aCanvas.Pen.Color := aBorder.Color;

  for liOffset := 0 to liLineWidth - 1 do
    begin
      if bpLeft in lBorderPositions then
        begin
          aCanvas.MoveTo(liLeft + liOffset, liTop);
          aCanvas.LineTo(liLeft + liOffset, liBottom);
        end;

      if bpTop in lBorderPositions then
        begin
          aCanvas.MoveTo(liLeft, liTop + liOffset);
          aCanvas.LineTo(liRight, liTop + liOffset);
        end;

      if bpRight in lBorderPositions then
        begin
          aCanvas.MoveTo(liRight - liOffset, liTop);
          aCanvas.LineTo(liRight - liOffset, liBottom + 1);
        end;

      if bpBottom in lBorderPositions then
        begin
          aCanvas.MoveTo(liLeft, liBottom - liOffset);
          aCanvas.LineTo(liRight, liBottom - liOffset);
        end;

    end;

end; {procedure, PaintBorder}

{------------------------------------------------------------------------------}
{ TppDesignControl.PaintBackground }

procedure TppDesignControl.PaintBackground(aCanvas: TCanvas; aClientRect: TRect; aBorder: TppBorder; aColor: TColor);
var
  lClientRect: TRect;
  liBufferWidth: Integer;
begin

  liBufferWidth := 1;

  lClientRect := aClientRect;
  aCanvas.Brush.Color := aColor;
  aCanvas.Brush.Style := bsSolid;

  if (aBorder <> nil) and aBorder.Visible then
    begin
      if bpLeft in aBorder.BorderPositions then
        lClientRect.Left := lClientRect.Left + liBufferWidth;

      if bpTop in aBorder.BorderPositions then
        lClientRect.Top := lClientRect.Top + liBufferWidth;

      if bpRight in aBorder.BorderPositions then
        lClientRect.Right := lClientRect.Right + liBufferWidth;

      if bpBottom in aBorder.BorderPositions then
        lClientRect.Bottom := lClientRect.Bottom + liBufferWidth;
    end;

  aCanvas.FillRect(lClientRect);

end; {procedure, PaintBackground}

{@RBuilder.Vcl.DesignControls.TppDesignControl.PaintDesignControl
 Called each time the DesignControl for the component needs to be painted.  This
 method is overriden by the descendant so that the appropriate visual
 representation of the component can be made in the Report Designer.}

procedure TppDesignControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lColor: TColor;
  lbIsClear: Boolean;
  lBorder: TppBorder;
begin

  lBorder := nil;
  
  GetPropValue('Border', lBorder);

  lClientRect := FComponent.spClientRect;

  FComponent.GetBackGroundColor(lColor, lbIsClear);

  {draw the background}
  if not(lbIsClear) then
    PaintBackground(aCanvas, lClientRect, lBorder, lColor);

  aCanvas.Font := FComponent.Font;

  {draw the caption}
  aCanvas.TextRect(lClientRect, lClientRect.Left, lClientRect.Top, FComponent.Caption);

  {draw a framerect}
  PaintFrame(aCanvas);

end; {procedure, PaintDesignControl}

{------------------------------------------------------------------------------}
{ TppDesignControl.PaintFrame }

procedure TppDesignControl.PaintFrame(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lSaveBrushStyle: TBrushStyle;
  lSavePenColor: TColor;
  lSavePenStyle: TPenStyle;
  lBorder: TppBorder;
  lBorderPositions: TppBorderPositions;
begin

  lClientRect := FComponent.spClientRect;
  lBorderPositions := [];

  {draw border}
  if (GetPropValue('Border', lBorder)) and (lBorder.Visible) then
    begin
      PaintBorder(aCanvas, lBorder);
      lBorderPositions := lBorder.BorderPositions;
    end;

  {draw frame}
  lSaveBrushStyle := aCanvas.Brush.Style;
  lSavePenColor := aCanvas.Pen.Color;
  lSavePenStyle := aCanvas.Pen.Style;

  aCanvas.Brush.Style := bsClear;
  aCanvas.Pen.Color := clDkGray;
  aCanvas.Pen.Style := psDot;

  if not(bpLeft in lBorderPositions) then
    begin
      aCanvas.MoveTo(lClientRect.Left, lClientRect.Top);
      aCanvas.LineTo(lClientRect.Left, lClientRect.Bottom);
    end;

  if not(bpTop in lBorderPositions) then
    begin
      aCanvas.MoveTo(lClientRect.Left, lClientRect.Top);
      aCanvas.LineTo(lClientRect.Right, lClientRect.Top);
    end;

  if not(bpRight in lBorderPositions) then
    begin
      aCanvas.MoveTo(lClientRect.Right - 1, lClientRect.Top);
      aCanvas.LineTo(lClientRect.Right - 1, lClientRect.Bottom);
    end;

  if not(bpBottom in lBorderPositions) then
    begin
      aCanvas.MoveTo(lClientRect.Left, lClientRect.Bottom - 1);
      aCanvas.LineTo(lClientRect.Right, lClientRect.Bottom - 1);
    end;

  aCanvas.Brush.Style := lSaveBrushStyle;
  aCanvas.Pen.Color := lSavePenColor;
  aCanvas.Pen.Style := lSavePenStyle;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.AdjustObject }

function TppDesignControl.AdjustObject(aBorder: TppBorder; aClientRect: TRect; aAlignment: TppTextAlignment): TRect;
var
  liBorderWidth: Integer;
  liBuffer: Integer;
  lBorderPositions: TppBorderPositions;
begin

  Result := aClientRect;

  liBorderWidth := aBorder.SPWeight;
  lBorderPositions := aBorder.BorderPositions;
  liBuffer := 2;

  if bpTop in lBorderPositions then
    begin
      Result.Top := Result.Top + liBorderWidth;
    end;

  if (bpLeft in lBorderPositions) and ((aAlignment = taLeftJustified) or (aAlignment = taFullJustified)) then
    begin
      Result.Left := Result.Left + liBorderWidth + liBuffer;
    end;

  if (bpRight in lBorderPositions) and ((aAlignment = taRightJustified) or (aAlignment = taFullJustified)) then
    begin
      Result.Right := Result.Right - liBorderWidth - liBuffer;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.AlignmentToTextAlignment }

function TppDesignControl.AlignmentToTextAlignment(aAlignment: TAlignment): TppTextAlignment;
begin
  if aAlignment = taLeftJustify then
    Result := taLeftJustified
  else if aAlignment = taRightJustify then
    Result := taRightJustified
  else
    Result := taCentered;
end;

{------------------------------------------------------------------------------}
{ TppDesignControl.GetComponent }

function TppDesignControl.GetComponent: TppCommunicator;
begin
  Result := FComponent;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.SetComponent }

procedure TppDesignControl.SetComponent(aComponent: TppComponent);
begin

  {remove event notification}
  if (FComponent <> nil) then
    begin
      FComponent.RemoveEventNotify(FWalkieTalkie);
      FComponent.DSExclude([pppcDesigning, pppcDisplayData]);
    end;

  FComponent := aComponent;

  {add event notification}
  if (FComponent <> nil) then
    begin
      {notify report designer}
      SendDesignMessage(RM_INSTANTIATECOMPONENTDC, ppWCustomMsg, Self);

      {initialize}
      FComponent.AddEventNotify(FWalkieTalkie);
      FComponent.DSInclude([pppcDesigning]);
      Tag := Integer(FComponent); // backward compatability

      if FComponent.IsDataAware then
        FComponent.Notify(FComponent.DataPipeline, ppopDataChange);

      ComponentBoundsChanged;
      BoundsLocksChanged;
      Invalidate;
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignControl.GetRTTIClass }
function TppDesignControl.GetRTTIClass: TraRTTIClass;
begin
  Result := TraRTTIClassRegistry.GetRTTIClass(GetComponent.ClassType);
end;

{------------------------------------------------------------------------------}
{ TppDesignControl.GetPropValue }

function TppDesignControl.IsValidPropName(const aPropName: String): Boolean;
begin
  Result := GetRTTIClass.IsValidPropName(GetComponent, aPropName);
end;


{------------------------------------------------------------------------------}
{ TppDesignControl.GetPropValue }

function TppDesignControl.GetPropValue(const aPropName: String; var aValue): Boolean;
begin
  Result := GetRTTIClass.GetPropValue(GetComponent, aPropName, aValue);
end;

{------------------------------------------------------------------------------}
{ TppDesignControl.SetPropValue }

function TppDesignControl.SetPropValue(const aPropName: String; var aValue): Boolean;
begin
  Result := GetRTTIClass.SetPropValue(GetComponent, aPropName, aValue);
end;

{------------------------------------------------------------------------------}
{ TppDesignControl.Invalidate }

procedure TppDesignControl.Invalidate;
begin

  FValidImage := False;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.CanOptimizeDesignPainting }

function TppDesignControl.CanOptimizeDesignPainting: Boolean;
begin
  Result := True;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignControl.DragDrop }

procedure TppDesignControl.DragDrop(Source: TObject; X, Y: Integer);
begin

  inherited;

  if (EventHub <> nil) then
    begin
      FDragDropEventParams.Update(Source, X, Y);
      EventHub.WorkspaceEvents.mcDragDrop.Notify(Self, FDragDropEventParams);
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignControl.DragOver }

procedure TppDesignControl.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

  inherited;

  if (EventHub <> nil) then
    begin
      Accept := True;
      FDragOverEventParams.Update(Source, X, Y, State, Accept);
      EventHub.WorkspaceEvents.mcDragOver.Notify(Self, FDragOverEventParams);
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignControl.GetEventHub }

function TppDesignControl.GetEventHub: TppDesignEventHub;
begin

  if (Component <> nil) and (Component.Report <> nil) then
    Result := TppDesignEventHub(Component.Report.MainReport.DesignEventHub)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseDown }

procedure TppDesignControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (EventHub <> nil) then
    begin
      FMouseEventParams.Update(Button, Shift, X, Y);
      EventHub.ComponentEvents.mcDesignControlMouseDown.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseMove }

procedure TppDesignControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin

  if (EventHub <> nil) then
    begin
      FMouseEventParams.Update(mbLeft, Shift, X, Y);
      EventHub.ComponentEvents.mcDesignControlMouseMove.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseUp }

procedure TppDesignControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (EventHub <> nil) then
    begin
      FMouseEventParams.Update(Button, Shift, X, Y);
      EventHub.ComponentEvents.mcDesignControlMouseUp.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignControl.SetBounds }

procedure TppDesignControl.SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin

 inherited;

 FWalkieTalkie.SendEventNotify(FWalkieTalkie, ciComponentBoundsChanged, nil);

end;


{******************************************************************************
 *
 ** D e s i g n   C o n t r o l   C o l l e c t i o n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppDesignControlCollection.Add }

procedure TppDesignControlCollection.Add(aDesignControl: TppDesignControl);
begin
  InnerList.Add(aDesignControl);
end;


{------------------------------------------------------------------------------}
{TppDesignControlCollection.GetItemForComponent }

function TppDesignControlCollection.GetItemForComponent(aComponent: TppComponent): TppDesignControl;
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
{TppDesignControlCollection.GetItemForIndex }

function TppDesignControlCollection.GetItemForIndex(aIndex: Integer): TppDesignControl;
begin

  Result := TppDesignControl(InnerList[aIndex]);

end;

{------------------------------------------------------------------------------}
{TppDesignControlCollection.IndexOf }

function TppDesignControlCollection.IndexOf(aComponent: TppComponent): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lDesignControl: TppDesignControl;
begin

  liIndex := 0;
  lbFound := False;

  while (not(lbFound) and (liIndex < InnerList.Count)) do
    begin
      lDesignControl := GetItemForIndex(liIndex);

      if (lDesignControl.Component = aComponent) then
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
{TppDesignControlCollection.Remove }

procedure TppDesignControlCollection.Remove(aDesignControl: TppDesignControl);
begin
  InnerList.Remove(aDesignControl);

end;

{******************************************************************************
 *
 ** B a n d   C o n t r o l   C o l l e c t i o n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppBandControlCollection.Add }

procedure TppBandControlCollection.Add(aBandControl: TppBandControl);
begin
  InnerList.Add(aBandControl);
end;


{------------------------------------------------------------------------------}
{TppBandControlCollection.GetItemForBand }

function TppBandControlCollection.GetItemForBand(aBand: TppBand): TppBandControl;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aBand);

  if (liIndex >= 0) then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{TppBandControlCollection.GetItemForIndex }

function TppBandControlCollection.GetItemForIndex(aIndex: Integer): TppBandControl;
begin

  Result := TppBandControl(InnerList[aIndex]);

end;

{------------------------------------------------------------------------------}
{TppBandControlCollection.IndexOf }

function TppBandControlCollection.IndexOf(aBand: TppBand): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lBandControl: TppBandControl;
begin

  liIndex := 0;
  lbFound := False;

  while (not(lbFound) and (liIndex < InnerList.Count)) do
    begin
      lBandControl := GetItemForIndex(liIndex);

      if (lBandControl.Band = aBand) then
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
{TppBandControlCollection.Remove }

procedure TppBandControlCollection.Remove(aBandControl: TppBandControl);
begin
  InnerList.Remove(aBandControl);

end;


{******************************************************************************
 *
 ** D e s i g n  C o n t r o l  M a n a g e r
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{TppDesignControlManager.Create }

constructor TppDesignControlManager.Create(aOwner: TComponent);
begin

  inherited;

  FDesignControls := TppDesignControlCollection.Create;
  FBandControls := TppBandControlCollection.Create;
  FSelectionObjects := TppSelectionObjectCollection.Create;

  EventNotifies := [ciReportBandAdded, ciReportBandRemoved,
                    ciReportComponentAdded, ciReportComponentRemoved];

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.Destroy }

destructor TppDesignControlManager.Destroy;
begin

  FDesignControls.Free;
  FDesignControls := nil;

  FBandControls.Free;
  FBandControls := nil;
  
  FSelectionObjects.Free;
  FSelectionObjects := nil;
  
  inherited;
end;

{------------------------------------------------------------------------------}
{ TppDesignControlManager.SendDesignMessage}

procedure TppDesignControlManager.SendDesignMessage(aMsg, aWParam: Integer; aOParam: TObject);
begin

  if (FReport <> nil) then
    FReport.SendDesignMessage(aMsg, aWParam, aOParam);

end;  {procedure, SendMessageToDesigner}


{------------------------------------------------------------------------------}
{ TppDesignControlManager.Notification }

procedure TppDesignControlManager.Notification(aComponent: TComponent; Operation: TOperation);
begin

  inherited;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.Notify }

procedure TppDesignControlManager.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if ((aCommunicator is TppComponent) and (aOperation = ppopRemove)) then
    begin
      FreeDesignControl(TppComponent(aCommunicator));
    end
  else if ((aCommunicator is TppBand) and (aOperation = ppopRemove)) then
    begin
      FreeDesignControl(TppBand(aCommunicator));
    end
  else if ((aCommunicator = FReport) and (aOperation = ppopRemove)) then
    FReport := nil; // just set to nil, do not call SetReport(nil)

  inherited;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.EventNotify }

procedure TppDesignControlManager.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lBand: TppBand;
  lComponent: TppComponent;
begin

  if (aCommunicator is TppBand) then
    begin
      lBand := TppBand(aCommunicator);

      if (aEventID = ciReportBandAdded) then
        CreateDesignControl(lBand)

      else if (aEventID = ciReportBandRemoved) then
        FreeDesignControl(lBand);

    end
  else if (aCommunicator is TppComponent) then
    begin
      lComponent := TppComponent(aCommunicator);

      if (aEventID = ciReportComponentAdded) then
        enReportComponentAdded(lComponent)

      else if (aEventID = ciReportComponentRemoved) then
        enReportComponentRemoved(lComponent);

    end;


  inherited;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.enReportComponentAdded }

procedure TppDesignControlManager.enReportComponentAdded(aComponent: TppComponent);
begin

  {create design control, if needed}
  if (FDesignControls[aComponent] = nil) then
    CreateDesignControl(aComponent);

end;


{------------------------------------------------------------------------------}
{TppDesignControlManager.enReportComponentRemoved }

procedure TppDesignControlManager.enReportComponentRemoved(aComponent: TppComponent);
begin

  {check whether component is already part of a selection,
    in this case do not free the design control}
  if (FSelectionObjects[aComponent] = nil) then
    FreeDesignControl(aComponent);

end;


{------------------------------------------------------------------------------}
{TppDesignControlManager.FreeDesignControls }

procedure TppDesignControlManager.FreeDesignControls;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FReport.BandCount-1 do
    FreeDesignControl(FReport.Bands[liIndex]);

  FBandControls.Clear;
  FDesignControls.Clear;

  if (FReport <> nil) then
    FReport.DSExclude([pppcDesigning, pppcDisplayData]);

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.FreeDesignControl }

procedure TppDesignControlManager.FreeDesignControl(aBand: TppBand);
var
  liIndex: Integer;
  lBandControl: TppBandControl;
begin

  SendDesignMessage(RM_BANDREMOVED, ppWCustomMsg, aBand);

  aBand.RemoveEventNotify(Self);

  lBandControl := FBandControls[aBand];

  if (lBandControl <> nil) then
    begin
      FBandControls.Remove(lBandControl);
      lBandControl.Free;
    end;


  for liIndex := 0 to aBand.ObjectCount-1 do
    FreeDesignControl(aBand.Objects[liIndex]);

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.FreeDesignControl }

procedure TppDesignControlManager.FreeDesignControl(aComponent: TppComponent);
var
  lDesignControl: TppDesignControl;
begin

  lDesignControl := FDesignControls[aComponent];

  FDesignControls.Remove(lDesignControl);

  lDesignControl.Free;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.GetDesignControlForComponent }

function TppDesignControlManager.GetDesignControlForComponent(aComponent: TppComponent): TppDesignControl;
begin
  Result := FDesignControls[aComponent];

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.GetBandControlForBand }

function TppDesignControlManager.GetBandControlForBand(aBand: TppBand): TppBandControl;
begin
  Result := FBandControls[aBand];

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.GetDesignControlCount }


function TppDesignControlManager.GetDesignControlCount: Integer;
begin
  Result := FDesignControls.Count;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.GetDesignControlForIndex }

function TppDesignControlManager.GetDesignControlForIndex(Index: Integer): TppDesignControl;
begin
  Result := FDesignControls.GetItemForIndex(Index);

end;


{------------------------------------------------------------------------------}
{TppDesignControlManager.CreateDesignControls }

procedure TppDesignControlManager.CreateDesignControls;
var
  liIndex: Integer;
begin

  FReport.DSInclude([pppcDesigning, pppcLoading]);

  try

    for liIndex := 0 to FReport.BandCount-1 do
      CreateDesignControl(FReport.Bands[liIndex]);

  finally
    FReport.DSExclude([pppcLoading]);

  end;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.CreateDesignControl }

function TppDesignControlManager.CreateDesignControl(aBand: TppBand): TppBandControl;
var
  liIndex: Integer;
  lBandControl: TppBandControl;
begin

  aBand.DSInclude([pppcDesigning]);

  aBand.AddEventNotify(Self);

  lBandControl := TppBandControl.Create(nil);
  lBandControl.DesignControlManager := Self;
  lBandControl.PopupMenu := TppPopupMenuManager.GetPopupMenu(aBand);
  lBandControl.Band := aBand;

  {setup notification relationship}
  aBand.AddNotify(Self);

  {add to collection}
  FBandControls.Add(lBandControl);

  if not(csReading in aBand.ComponentState) and not(csLoading in aBand.ComponentState) then
    SendDesignMessage(RM_BANDADDED, ppWCustomMsg, aBand);

  {add design controls for components}
  for liIndex := 0 to aBand.ObjectCount-1 do
    CreateDesignControl(aBand.Objects[liIndex]);

  Result := lBandControl;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.CreateDesignControl }

function TppDesignControlManager.CreateDesignControl(aComponent: TppComponent): TppDesignControl;
var
  lDesignControl: TppDesignControl;
begin

  lDesignControl := TppDesignControlFactory.CreateInstance(aComponent);
  lDesignControl.DesignControlManager := Self;
  lDesignControl.PopupMenu := TppPopupMenuManager.GetPopupMenu(aComponent);
  lDesignControl.Component := aComponent;

  {setup notifcation relationship}
  aComponent.AddNotify(Self);

  {add to collection}
  FDesignControls.Add(lDesignControl);

  Result := lDesignControl;

end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.GetBandControlByIndex }

function TppDesignControlManager.GetBandControlByIndex(Index: Integer): TppBandControl;
begin
  Result := FBandControls.ItemsByIndex[Index];
  
end;

{------------------------------------------------------------------------------}
{TppDesignControlManager.GetBandControlCount }

function TppDesignControlManager.GetBandControlCount: Integer;
begin
  Result := FBandControls.Count;
end;


{------------------------------------------------------------------------------}
{TppDesignControlManager.SetReport }

procedure TppDesignControlManager.SetReport(aReport: TppCustomReport);
begin

  if (FReport <> aReport) then
    begin
    
      if (FReport <> nil) then
        begin
          FreeDesignControls;
          FReport.RemoveEventNotify(Self);
        end;

      FReport := aReport;

      if (FReport <> nil) then
        begin
          CreateDesignControls;
          FReport.AddEventNotify(Self);
        end;

    end;


end;

{******************************************************************************
 *
 ** B A N D   C O N T R O L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBandControl.Create}

constructor TppBandControl.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FOnPaint := nil;

  Cursor      := crSizeNS;
  DragCursor  := crSizeNS;
  Left        := 0;
  Height      := TppBandControl.PanelHeight;

  Alignment   := taLeftJustify;
  BorderStyle := bsSingle;
  Font.Size   := 8;

  BevelOuter  := bvNone;
  BorderStyle := bsNone;

  FMouseEventParams := TppMouseEventParams.Create(mbLeft, [], 0, 0);


  {$IFDEF Delphi7}
    ParentBackground := False;
  {$ENDIF}

  FWalkieTalkie := TppCommunicator.Create(nil);
  
  FWalkieTalkie.OnEventNotify := ehWalkieTalkieEventNotify;
  FWalkieTalkie.OnNotify := ehWalkieTalkieNotify;

  FWalkieTalkie.EventNotifies := [ciBandBeforeHeightChange,
                                  ciBandAfterHeightChange,
                                  ciBandSetScreenPixelTop,
                                  ciBandGetScreenPixelTop,
                                  ciBandResize,
                                  ciBandCaptionChanged];

end;

{------------------------------------------------------------------------------}
{ TppBandControl.Destroy }

destructor TppBandControl.Destroy;
begin

  FWalkieTalkie.Free;
  FWalkieTalkie := nil;

  FRuler.Free;
  FRuler := nil;

  FMouseEventParams.Free;
  FMouseEventParams := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.Destroy }

procedure TppBandControl.Notification(aComponent: TComponent; Operation: TOperation);
begin

  if ((aComponent = FRuler) and (Operation = opRemove)) then
    FRuler := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.ehWalkieTalkieNotify}

procedure TppBandControl.ehWalkieTalkieNotify(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin
  if (aCommunicator = FBand) and (aOperation = ppopRemove) then
    if not(csDestroying in ComponentState) then
      Free;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.ehWalkieTalkieEventNotify}

procedure TppBandControl.ehWalkieTalkieEventNotify(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  if (aCommunicator = FBand) then
    if (aEventID = ciBandBeforeHeightChange) then
      enBeforeBandHeightChange(aParams)
    else if (aEventID = ciBandAfterHeightChange) then
      enAfterBandHeightChange(aParams)
    else if (aEventID = ciBandGetScreenPixelTop) then
        enGetBandTop(aParams)
    else if (aEventID = ciBandSetScreenPixelTop) then
      enSetBandTop(aParams)
    else if (aEventID = ciBandResize) then
      enBandResize(aParams)
    else if (aEventID = ciBandCaptionChanged) then
      Caption      := '  ^  ' + FBand.Caption;


end;

{------------------------------------------------------------------------------}
{ TppBandControl.enBandResize}

procedure TppBandControl.enBandResize(aParams: TraParamList);
begin

  if (pppcDesigning in Band.DesignState) then

    if (FBand.Report.Columns > 1) and FBand.IsColumnar then
      Width := FBand.Report.spColumnWidth
    else
      Width := FBand.Report.PrinterSetup.PageDef.spPrintableWidth + 1;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.enBeforeBandHeightChange}

procedure TppBandControl.enBeforeBandHeightChange(aParams: TraParamList);
var
  liNewHeight: Integer;
  liPageHeight: Integer;
  lbValid: Boolean;
begin

  aParams.GetParamValue(0, liNewHeight);
  lbValid := True;

  {do not allow band height to be set to 0, if band contains components}
  if (liNewHeight <= 0) and (FBand.ObjectCount > 0) and (Band.Report <> nil) then
    begin
      MessageDlg(ppLoadStr(296), mtWarning, [mbOK], 0);
      lbValid := False;
    end
  {do not allow band height to exceed page height for a static height band }
  else if (liNewHeight <> FBand.mmHeight) and (FBand.PrintHeight = phStatic) and (Band.Report <> nil) then
    begin
      liPageHeight := Band.Report.PrinterSetup.PageDef.mmPrintableHeight;

      {note: only validate when page height > 0, because page height may not yet
             be initialized - for instance when the component is first read up}
      if (liNewHeight > liPageHeight) and (liPageHeight > 0) then
        begin
          MessageDlg(ppLoadStr(297), mtWarning, [mbOK], 0);
          lbValid := False;
        end;
        
    end;
    
  aParams.SetParamValue(1, lbValid);

end;

{ TppBandControl.enAfterBandHeightChange}

procedure TppBandControl.enAfterBandHeightChange(aParams: TraParamList);
var
  liIndex: Integer;
  liOldHeight: Integer;
  liChange: Integer;
  liScreenPixelChange: Integer;
  lComponent: TppComponent;
  liObjectBottom: Integer;
  lPrinter: TppPrinter;
begin

  aParams.GetParamValue(0, liOldHeight);

  {calc the change in height }
  liChange := FBand.mmHeight - liOldHeight;

  {adjust top, based on change in height}
  liScreenPixelChange := Trunc(ppFromMMThousandths(liChange, utScreenPixels, pprtVertical, nil));
  Top := Top + liScreenPixelChange;
  FRuler.Height := FBand.spHeight;


  {move components, if not still within the band height}
  if ((FBand.Units = utPrinterPixels) and (FBand.Report <> nil)) then
    lPrinter := FBand.Report.Printer
  else
    lPrinter := nil;

  for liIndex := 0 to FBand.ObjectCount-1 do
    begin
      lComponent := FBand.Objects[liIndex];

      liObjectBottom := lComponent.mmTop + lComponent.mmHeight;

      if (liObjectBottom > FBand.mmHeight) then
        if lComponent.mmHeight > FBand.mmHeight then
          lComponent.Top := 0
        else
          lComponent.Top := ppFromMMThousandths((FBand.mmHeight - lComponent.mmHeight), FBand.Units, pprtVertical, lPrinter);

    end;


  {notify report designer}
  SendDesignMessage(RM_BANDHEIGHTCHANGE, ppWCustomMsg, FBand);

end;

{------------------------------------------------------------------------------}
{ TppBandControl.enSetBandTop }

procedure TppBandControl.enSetBandTop(aParams: TraParamList);
var
  liBandTop: Integer;
  lPoint: TPoint;
  liObject: Integer;
  lComponent: TppComponent;
  lDesignControl: TppDesignControl;
begin

  aParams.GetParamValue(0, liBandTop);

  {design control for a band is drawn at the bottom of the band}
  Top := liBandTop + FBand.spHeight;

  lPoint.X := 0;
  lPoint.Y := liBandTop;

  {convert from Workspace to VerticalRuler panel coords}
  {note: make sure ReportDesigner is visible or get an AV}
  if (FRuler <> nil) and (Parent<> nil) and (Parent.Owner <> nil) and TForm(Parent.Owner).Visible and Parent.HandleAllocated then
    begin
      lPoint := Parent.ClientToScreen(lPoint);

      if (FRuler <> nil) and (FRuler.Parent <> nil) then
        lPoint := FRuler.Parent.ScreenToClient(lPoint);
    end;

  if (FRuler <> nil) then
    FRuler.Top := lPoint.Y;

  {move all design controls associated with this band,
    note: when bandcontrol top changes, the component.top is still the same,
          but the component.designcontrol top needs updating}
  for liObject := 0 to (FBand.ObjectCount - 1) do
    begin
      lComponent := FBand.Objects[liObject];

      // get design control for component
      lDesignControl := FDesignControlManager.DesignControls[lComponent];

      if (lDesignControl <> nil) then
          lDesignControl.Top := lComponent.spTop + liBandTop;

    end;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.enGetBandTop }

procedure TppBandControl.enGetBandTop(aParams: TraParamList);
var
  liTop: Integer;
begin

  {band top is the design control top minus the band height}
  liTop := Top - FBand.spHeight;

  aParams.SetParamValue(0, liTop);

end;

{------------------------------------------------------------------------------}
{ TppBandControl.GetBottomOfControls }

function TppBandControl.GetBottomOfControls: Integer;
var
  liIndex: Integer;
  liDesignControlBottom: Integer;
  liBottomOfControls: Integer;
  lComponent: TppComponent;
  lDesignControl: TppDesignControl;
begin

  liBottomOfControls := -1;
  
  for liIndex := 0 to FBand.ObjectCount-1 do
    begin
      lComponent := FBand.Objects[liIndex];

      // when parent height true, ommit the control from consideration
      if not(lComponent.ParentHeight) then
        begin
          lDesignControl := FDesignControlManager.DesignControls[lComponent];

          liDesignControlBottom := lDesignControl.Top + lDesignControl.Height;

          if (liDesignControlBottom > liBottomOfControls) then
            liBottomOfControls := liDesignControlBottom;

        end;


    end;

  Result := liBottomOfControls;

end;


{------------------------------------------------------------------------------}
{ TppBandControl.Paint - used to trigger ruler scrolling}

procedure TppBandControl.Paint;
begin

  inherited Paint;

  if Assigned(FOnPaint) then FOnPaint(Self);
end;

{------------------------------------------------------------------------------}
{ TppBandControl.SetBand}

procedure TppBandControl.SetBand(aBand: TppBand);
begin

  if (FBand <> nil) then
    FBand.RemoveEventNotify(FWalkieTalkie);

  FBand := aBand;

  if (FBand <> nil) then
    begin
      FBand.AddEventNotify(FWalkieTalkie);
      
      Name := FBand.Name;
      Font.Size    := 8;
      Caption      := '  ^  ' + FBand.Caption;
      Tag          := Integer(FBand);
      Top          := FBand.spHeight; {must initialize to FHeight, gets reset later}
      Width        := FBand.spWidth;
      Visible      := True;

      CreateRuler;

      SendDesignMessage(RM_INSTANTIATEBANDDC, ppWCustomMsg, Self);

    end;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.CreateRuler}

procedure TppBandControl.CreateRuler;
begin

  FRuler := TppRuler.Create(Owner);
  FRuler.FreeNotification(Self);

  FRuler.Orientation := roVertical;
  FRuler.Top         := 0;
  FRuler.Left        := 0;
  FRuler.Height      := FBand.spHeight;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.GetEventHub }

function TppBandControl.GetEventHub: TppDesignEventHub;
begin

  if (FBand <> nil) and (FBand.Report <> nil) then
    Result := TppDesignEventHub(FBand.Report.MainReport.DesignEventHub)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseDown }

procedure TppBandControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (EventHub <> nil) then
    begin
      FMouseEventParams.Update(Button, Shift, X, Y);
      EventHub.BandEvents.mcDesignControlMouseDown.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseMove }

procedure TppBandControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin

  if (EventHub <> nil) then
    begin
      FMouseEventParams.Update(mbLeft, Shift, X, Y);
      EventHub.BandEvents.mcDesignControlMouseMove.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppWorkspace.MouseUp }

procedure TppBandControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (EventHub <> nil) then
    begin
      FMouseEventParams.Update(Button, Shift, X, Y);
      EventHub.BandEvents.mcDesignControlMouseUp.Notify(Self, FMouseEventParams);
    end;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppBandControl.PanelHeight}

class function TppBandControl.PanelHeight: Integer;
begin
  Result := 16;
end;


{------------------------------------------------------------------------------}
{ TppBandControl.SendDesignMessage}

procedure TppBandControl.SendDesignMessage(aMsg, aWParam: Integer; aLParam: TObject);
begin

  if (FBand <> nil) then
    FBand.SendDesignMessage(aMsg, aWParam, aLParam);

end;






initialization
  TppDesignControlFactory.ClassCreate;

finalization
  TppDesignControlFactory.ClassDestroy;



end.
