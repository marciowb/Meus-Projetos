{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppRegion;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes,
  Graphics,
  SysUtils,
  ExtCtrls,

  ppClass,
  ppComm,
  ppTypes,
  ppStrtch,
  ppDevice,
  ppPrnabl,
  ppDrwCmd,
  ppCache,
  ppRTTI;

type

  {@TppCustomRegion

    Ancestor from which all region components descend. The standard region
    components provided with ReportBuilder are:

            - TppRegion}

  {@TppCustomRegion.Brush

    The Brush property determines the fill color and pattern of a TppShape
    report control.

    To set the Brush.Color from the Report Designer, select the Graphics
    Palette option on the Tools menu, then click the right mouse button on
    the desired color.  This will set the Brush Color (BC) for all selected
    components.}

  {@TppCustomRegion.KeepTogether

    Defaults to False. The KeepTogether property controls the pagination of
    the region when the contents cannot fit on the current page.  Normally
    the contents are printed to the bottom of the available page space and
    then continued on subsequents pages until complete.  If KeepTogether is
    True, the Region will advance to the next page when the contents do not
    fit.}

  {@TppCustomRegion.ObjectCount

    Run-time and read only.  The ObjectCount property returns the number of
    components in the band or region.  When the band contains a region, the
    value of ObjectCount includes the region and all of the components in
    the region.}

  {@TppCustomRegion.Objects

    Run-time and read only.  The Objects property returns a specific object
    in the band.  Specify the object using the Index parameter, with the
    first object in the band having an Index of 0.  To determine the Index
    for a specific object use the FindObject method.

    When a band contains a region, the region and all of the components
    contained in the region are included in the Objects property.}

  {@TppCustomRegion.Pen

    The Pen property determines the frame color and frame width the of a
    TppShape report control.

    Use the Report Designer's Color Palette to set the Pen's Color and
    Width.

    Note: When set to zero, Pen.Width behaves differently than in Delphi.
    The zero value is used as an indicator for hairlines.  If you want a
    shape or line to draw with the thinnest line your printer is capable
    of, set Pen.Width to zero.  In print preview, the shape or line will
    look the same as a one-pixel width line, however, when printed it will
    look thinner (how much thinner depends on the capabilities of your
    printer.)  This feature can be used to considerably improve the
    appearance of reports where one-pixel width lines are looking too
    heavy.}

  TppCustomRegion = class(TppStretchable)
    private
      FBrush: TBrush;
      FCacheManager: TppCacheManager;
      FMaxStretchable: TppStretchable;
      FObjectLists: TStringList;
      FObjects: TList;
      FPage: TppPage;
      FPen: TPen;
      FPrevRect: TppSizeRect;
      FShapeType: TShapeType;
      FShifters: TList;
      FStatics: TList;
      FStretchables: TList;
      FStretchers: TList;

      function  GetObject(aIndex: Integer): TppComponent;
      function  GetObjectCount: Integer;
      function  GetPrevRect: TppSizeRect;
      procedure FreeObjects;
      procedure SetBrush(aBrush: TBrush); virtual;
      procedure SetPen(aPen: TPen); virtual;
      procedure SetPrevRect(const Value: TppSizeRect);

      {print routines}
      procedure CategorizeObjects;
      procedure FreeLists;
      procedure GenerateObjects(aListIndex, aObjectIndex: Integer);
      function  PrintingSection: Boolean;
      procedure ProcessQueue(aQueue: TList; aObjectIndex: Integer);
      procedure ResetObjects;

      procedure RestorePage;
      procedure SavePage;

    protected
      procedure CalcSpaceUsed; override;
      procedure BoundsChange; override;
      function  GetNextSibling: TppComponent; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure RedrawOnOverFlow; override;
      procedure SetBand(aBand: TppBand); override;
      procedure SetRegion(aRegion: TppComponent); override;
      procedure SetTransparent(Value: Boolean); override;
      procedure StyleChanged(Sender: TObject); virtual;
      procedure UpdateDesignControlBounds; override;
      procedure UpdateChildControlBounds;
      procedure Loaded; override;
      procedure GetChildren(Proc: TGetChildProc;Root: TComponent); override;
      procedure SetIndex(const Value: Integer); override;

      property ShapeType: TShapeType read FShapeType write FShapeType;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      {overridden from communicator}
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure AddObject(aObject: TObject);
      function  FindObject(appComponent: TppComponent): Integer;
      procedure FreeCache(aCachePageNo: Longint); override;
      function  HasFont: Boolean; override;
      procedure Init; override;
      procedure MoveObject(aCurIndex, aNewIndex: Integer);
      procedure RemoveObject(aObject: TObject);
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      procedure SetBackgroundColor(aColor: TColor; aIsClear: Boolean); override;
      procedure SetForegroundColor(aColor: TColor; aIsClear: Boolean); override;
      procedure SetPenWidth(aWidth: Integer); override;

      property Brush: TBrush read FBrush write SetBrush;
      property CurrentPosition;
      property ObjectCount: Integer read GetObjectCount;
      property Objects[Index: Integer]: TppComponent read GetObject;
      property MaxStretchable: TppStretchable read FMaxStretchable;
      property PageBottom;
      property Pen: TPen read FPen write SetPen;
      property PrevRect: TppSizeRect read GetPrevRect write SetPrevRect;

    published
      property KeepTogether; {needed to be published in this class so that DocOMatic can parse the topic comment}

  end; {class, TppCustomRegion}

  {@TppRegion

    Use regions to group components together into printable units. A region
    serves as a parent to the components inside it. This means that when
    components are contained within a region, the ShiftWithParent and
    StretchWithParent properties of those components refer to the region.
    Both static and stretchable components may be contained within regions.
    When stretchable components, such as TppMemo or TppSubReport, are 
    placed inside regions, their ShiftRelativeTo property is disabled. Only
    side-by-side stretching is allowed within regions. If multiple 
    ShiftRelativeTo relationships are needed, and each stretching component
    has its own related static components, it is usually best to place each
    stretchable component (along with the corresponding static components) 
    in their own region, utilizing the region's ShiftRelativeTo property to
    dynamically position the components.

    Regions can also be used to accomplish forms emulation.  Simply create a
    region and set the ParentWidth and ParentHeight properties to True. Then
    place the layout for the form in the region. Create an additional region and
    place data-aware components, which 'fill-out' the form, inside it. Make the
    region Transparent. The form below should now be visible. Finally, align the
    data-aware components over the form.

    Layers of regions can also be used to change the layout for an entire band
    while the report is printing. Simply place an event handler in the
    BeforePrint event of the band and use the Visible property to control which
    regions appear in any given situation.

    You can control the 'look and feel' of a region by setting the Pen and Brush
    properties. When regions contain stretchable components, you can sometimes
    improve the results of dynamic positioning by specifying a BottomOffset for
    the region.

    Note: Regions cannot be placed within other regions.}

  TppRegion = class(TppCustomRegion)
    public
     constructor Create(aOwner: TComponent); override;

    published
      property Anchors;
      property Brush;
      property Caption;
      property KeepTogether;
      property MinHeight;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property ParentHeight;
      property ParentWidth;
      property Pen;
      property ReprintOnOverFlow;
      property ShiftRelativeTo;
      property Stretch;
      property StretchWithParent;
      property Transparent;
      property UserName;
      property Visible;

      {these properties saved in 'fake' properties}
      property BottomOffset stored False;
      property Height stored False;
      property Left stored False;
      property OverFlowOffset stored False;
      property Top stored False;
      property Width stored False;

   end; {class, TppRegion}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppCustomRegionRTTI }
  TraTppCustomRegionRTTI = class(TraTppStretchableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCustomRegionRTTI}


implementation

uses
  ppCtrls;

{******************************************************************************
 *
 **  C U S T O M    R E G I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomRegion.Create }

constructor TppCustomRegion.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppRegionSaveRec);

  DrawCommandClass := TppDrawShape;

  FBrush             := TBrush.Create;
  FCacheManager      := nil;
  FObjectLists       := TStringList.Create;
  FObjects           := TList.Create;
  FPage              := nil;
  FPen               := TPen.Create;
  FPrevRect.Left     := 0;
  FPrevRect.Top      := 0;
  FPrevRect.Width    := 0;
  FPrevRect.Height   := 0;
  FShapeType         := stRectangle;
  FStretchables      := nil;
  FShifters          := nil;
  FStretchers        := nil;
  FStatics           := nil;

  {if pen or brush changed - notify design control}
  FPen.OnChange   := StyleChanged;
  FBrush.OnChange := StyleChanged;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomRegion.Destroy }

destructor TppCustomRegion.Destroy;
begin

  {used for KeepTogether}
  FCacheManager.Free;
  FPage.Free;

  {free print processing lists}
  FreeLists;

  FObjectLists.Free;

  FreeObjects;

  FBrush.Free;
  FPen.Free;

  FObjects.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomRegion.Notify }

procedure TppCustomRegion.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (FCacheManager = aCommunicator) then
    FCacheManager := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppCustomRegion.FreeObjects }

procedure TppCustomRegion.FreeObjects;
var
  liObject: Integer;
  lObject: TObject;

begin

  {ppDebugMessage('TppBand', 'Destroy', 'free each report component associated with this band', True);}
  for liObject := 0 to FObjects.Count - 1 do
    begin
      lObject := FObjects.Last;
      lObject.Free;
    end;

  FObjects.Clear;

end; {procedure, FreeObjects}

{------------------------------------------------------------------------------}
{ TppCustomRegion.Loaded }

procedure TppCustomRegion.Loaded;
begin

  inherited Loaded;

  FPrevRect.Left := mmLeft;
  FPrevRect.Top := mmTop;

  FPrevRect.Width := mmWidth;
  FPrevRect.Height := mmHeight;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppCustomRegion.BoundsChange }

procedure TppCustomRegion.BoundsChange;
begin

  inherited BoundsChange;

  {if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;}
  if not (pppcDesigning in DesignState) or (Printing) then
    UpdateChildControlBounds;

  FPrevRect.Left := mmLeft;
  FPrevRect.Top := mmTop;

  FPrevRect.Width := mmWidth;
  FPrevRect.Height := mmHeight;

end; {procedure, BoundsChange}

{------------------------------------------------------------------------------}
{ TppCustomRegion.UpdateDesignControlBounds }

procedure TppCustomRegion.UpdateDesignControlBounds;
begin
  inherited UpdateDesignControlBounds;

  UpdateChildControlBounds;


end; {procedure, UpdateDesignControlBounds }

{------------------------------------------------------------------------------}
{ TppCustomRegion.UpdateChildControlBounds }

procedure TppCustomRegion.UpdateChildControlBounds;
var
  liObject: Integer;
  lComponent: TppComponent;

begin

  if (FObjects = nil) then Exit;

  if ((csReading in ComponentState) or (csLoading in ComponentState)) and not(pppcPasting in DesignState) then Exit;

  if ((FPrevRect.Width = 0) or (FPrevRect.Height = 0)) and (pppcPasting in DesignState) then
    begin
      FPrevRect.Left := mmLeft;
      FPrevRect.Top := mmTop;

      FPrevRect.Width := mmWidth;
      FPrevRect.Height := mmHeight;

    end;

  if (FPrevRect.Left <> mmLeft)   or (FPrevRect.Top <> mmTop) or
     (FPrevRect.Width <> mmWidth) or (FPrevRect.Height <> mmHeight) then
    begin

      {move objects in region }
      for liObject := 0 to FObjects.Count - 1 do
        begin
          lComponent := Objects[liObject];

          lComponent.ParentBoundsChange
        end;

    end;

end; {procedure, UpdateChildControlBounds }

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetPen }

procedure TppCustomRegion.SetPen(aPen: TPen);
begin

  FPen.Assign(aPen);

  StyleChanged(Self);

end; {procedure, SetPen }

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetBrush }

procedure TppCustomRegion.SetBrush(aBrush: TBrush);
begin

  FBrush.Assign(aBrush);

  StyleChanged(Self);

end; {procedure, SetBrush }

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetPrevRect }

procedure TppCustomRegion.SetPrevRect(const Value: TppSizeRect);
begin
  FPrevRect := Value;

end; {procedure, SetPrevRect }

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetBackgroundColor }

procedure TppCustomRegion.SetBackgroundColor(aColor: TColor; aIsClear: Boolean);
var
  lbBrushStyleChange: Boolean;
  lbBrushColorChange: Boolean;
begin

  lbBrushColorChange := (FBrush.Color <> aColor) and not(aIsClear);

  if (aIsClear) then
    lbBrushStyleChange := (FBrush.Style <> bsClear)
  else
    lbBrushStyleChange := (FBrush.Style <> bsSolid);

  if lbBrushColorChange then
    begin
      BeforePropertyChange('Brush.Color');
      FBrush.Color := aColor;
      PropertyChange;
    end;

  if lbBrushStyleChange then
    begin
      BeforePropertyChange('Brush.Style');
      if aIsClear then
        FBrush.Style := bsClear
      else
        FBrush.Style := bsSolid;
      PropertyChange;
    end;

end; {procedure, SetBackgroundColor }

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetForegroundColor }

procedure TppCustomRegion.SetForegroundColor(aColor: TColor; aIsClear: Boolean);
var
  lbPenStyleChange: Boolean;
  lbPenColorChange: Boolean;
begin

  lbPenColorChange := (FPen.Color <> aColor) and not(aIsClear);

  if (aIsClear) then
    lbPenStyleChange := (FPen.Style <> psClear)
  else
    lbPenStyleChange := (FPen.Style <> psSolid);

  if lbPenColorChange then
    begin
      BeforePropertyChange('Pen.Color');
      FPen.Color := aColor;
      PropertyChange;
    end;

  if lbPenStyleChange then
    begin
      BeforePropertyChange('Pen.Style');
      if aIsClear then
        FPen.Style := psClear
      else
        FPen.Style := psSolid;
      PropertyChange;
    end;

end; {procedure, SetForegroundColor }

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetPenWidth }

procedure TppCustomRegion.SetPenWidth(aWidth: Integer);
begin
  FPen.Width := aWidth;
end; {procedure, SetPenWidth }

{------------------------------------------------------------------------------}
{ TppCustomRegion.StyleChanged }

procedure TppCustomRegion.StyleChanged(Sender: TObject);
var
  lbTransparent: Boolean;
begin

  {need to set transparent based upon brush stype}
  lbTransparent := (FBrush.Style = bsClear);

  if (lbTransparent <> Transparent) then
    inherited SetTransparent(FBrush.Style = bsClear);
  
  InvalidateDesignControl;

  PropertyChange;
  
end; {procedure, StyleChanged }

{------------------------------------------------------------------------------}
{ TppCustomRegion.AddObject }

procedure TppCustomRegion.AddObject(aObject: TObject);
var
  lComponent: TppComponent;

begin

  if not (aObject is TppComponent) then Exit;

  lComponent := TppComponent(aObject);

  if (lComponent.Band <> Band) then
    lComponent.Band := Band;

  FObjects.Add(lComponent);

  AddNotify(lComponent);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  lComponent.Index := Self.Index + FObjects.Count + 1;

  {if object needs to stretch, then set Stretch property to true
    note: call SetPrintHeight to allow descendants to determine what to do}
  if (lComponent is TppStretchable) and TppStretchable(lComponent).Stretch and
                                        not Stretch then
    Stretch := True;

end; {procedure, AddObject}

{------------------------------------------------------------------------------}
{ TppCustomRegion.RemoveObject }

procedure TppCustomRegion.RemoveObject(aObject: TObject);
var
  lComponent: TppComponent;

begin

  if not (aObject is TppComponent) then Exit;

  lComponent := TppComponent(aObject);

  {remove object from list by setting its position to nil}
  FObjects.Remove(lComponent);

  {this will trigger a lComponent.RemoveNotify}
  if not (csDestroying in lComponent.ComponentState) then
    lComponent.Notify(Self, ppopRemove);

  RemoveNotify(lComponent);

  Reset;

  if not (csDestroying in lComponent.ComponentState) and (Band <> nil) then
    SendDesignMessage(RM_COMPONENTUPDATED, ppWCustomMsg, lComponent);

end; {procedure, RemoveObject}

{------------------------------------------------------------------------------}
{ TppCustomRegion.GetObject }

function  TppCustomRegion.GetObject(aIndex: Integer): TppComponent;
begin
  Result := FObjects[aIndex];
end; {function, GetObject}

{------------------------------------------------------------------------------}
{ TppCustomRegion.FindObject }

function TppCustomRegion.FindObject(appComponent: TppComponent): Integer;
begin
  Result := FObjects.IndexOf(appComponent);

end; {function, FindObject}

{------------------------------------------------------------------------------}
{ TppCustomRegion.GetObjectCount }

function  TppCustomRegion.GetObjectCount: Integer;
begin
  Result := FObjects.Count;
end; {function, GetObject}


{------------------------------------------------------------------------------}
{ TppCustomRegion.GetNextSibling }

function  TppCustomRegion.GetNextSibling: TppComponent;
var
  liIndex: Integer;
  lComponent: TppComponent;
begin
  Result := nil;

  liIndex := Index + 1;

  while (Result = nil) and (liIndex < Band.ObjectCount) do
    begin
      lComponent := Band.Objects[liIndex];

      if FindObject(lComponent) < 0 then
        Result := lComponent;

      Inc(liIndex);

    end;

end; {function, GetNextSibling}

{------------------------------------------------------------------------------}
{ TppCustomRegion.GetPrevRect }

function TppCustomRegion.GetPrevRect: TppSizeRect;
begin
  Result := FPrevRect;

end; {function, GetPrevRect}

{------------------------------------------------------------------------------}
{ TppCustomRegion.HasFont }

function  TppCustomRegion.HasFont: Boolean;
begin
  Result := False;
end; {function, HasFont}


{------------------------------------------------------------------------------}
{ TppCustomRegion.SetIndex }

procedure TppCustomRegion.SetIndex(const Value: Integer);
var
  liIndex: Integer;
begin

  inherited;

  // for each child, update the Index property - this will cause the child to
  // notify the design control, undaoable, etc. 
  for liIndex := 0 to FObjects.Count-1  do
    Objects[liIndex].Index := Self.Index + liIndex + 1;

end;

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetBand }

procedure TppCustomRegion.SetBand(aBand: TppBand);
var
  liObject: Integer;

begin

  inherited SetBand(aBand);

  if csDestroying in ComponentState then Exit;

  for liObject := 0 to FObjects.Count - 1 do
    Objects[liObject].Band := aBand;

end; {function, SetBand}

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetRegion }

procedure TppCustomRegion.SetRegion(aRegion: TppComponent);
begin
 {do nothing: regions cannot be assigned to regions }
end; {function, SetRegion}

{------------------------------------------------------------------------------}
{ TppCustomRegion.SetTransparent }

procedure TppCustomRegion.SetTransparent(Value: Boolean);
begin

  inherited SetTransparent(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if Value and (FBrush.Style <> bsClear) then
    FBrush.Style := bsClear

  else if not Value and (FBrush.Style = bsClear) then
    FBrush.Style := bsSolid;

end; {procedure, SetTransparent}

{------------------------------------------------------------------------------}
{ TppCustomRegion.FreeLists }

procedure TppCustomRegion.FreeLists;
var
  liList: Integer;
begin

  for liList := 0 to FObjectLists.Count - 1 do
    TList(FObjectLists.Objects[liList]).Free;

  FStretchables := nil;
  FStretchers := nil;
  FShifters := nil;
  FStatics := nil;

  FObjectLists.Clear;

end; {procedure, FreeLists}

{------------------------------------------------------------------------------}
{ TppCustomRegion.RestoreFromCache }

procedure TppCustomRegion.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppRegionSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent     := lRec.FDrawComponent;
  DrawShifter       := lRec.FDrawShifter;
  KeptTogether      := lRec.FKeptTogether;
  OverFlow          := lRec.FOverFlow;
  ObjectIndex       := lRec.FObjectIndex;
  PartialGeneration := lRec.FPartialGeneration;

  ObjectListIndex   := lRec.FObjectListIndex;
  PartialAdjustment := lRec.FPartialAdjustment;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppCustomRegion.SaveToCache }

procedure TppCustomRegion.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppRegionSaveRec;
begin

  lRec.FDrawComponent     := DrawComponent;
  lRec.FDrawShifter       := DrawShifter;
  lRec.FKeptTogether      := KeptTogether;
  lRec.FOverFlow          := OverFlow;
  lRec.FObjectIndex       := ObjectIndex;
  lRec.FPartialGeneration := PartialGeneration;

  lRec.FObjectListIndex   := ObjectListIndex;
  lRec.FPartialAdjustment := PartialAdjustment;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppCustomRegion.CategorizeObjects }

procedure TppCustomRegion.CategorizeObjects;
var
  liObjects: Integer;
  liObject: Integer;
  lObject: TppComponent;

  procedure AddObjectToList(var aList: TList; aObject: TObject; aListRank: Integer);
  begin

    if (aList = nil) then
      begin
        aList := TList.Create;

        FObjectLists.AddObject(IntToStr(aListRank), aList);
      end;

    aList.Add(lObject);

  end; {procedure, AddObjectToList}


begin

  {get number of objects}
  liObjects := ObjectCount;

  {categorize objects}
  for liObject := 0 to liObjects - 1 do
    begin
      lObject := Objects[liObject];

      {save object's z-order}
      lObject.ZOrder := liObject;

      if (lObject is TppStretchable) and (TppStretchable(lObject).ShiftRelativeTo = nil) then
        begin
          if TppStretchable(lObject).Stretch then
            AddObjectToList(FStretchables, lObject, 2)

          else if lObject.StretchWithParent then
            AddObjectToList(FStretchers, lObject, 3)

          else if lObject.ShiftWithParent then
            AddObjectToList(FShifters, lObject, 4)

          else
            AddObjectToList(FStatics, lObject, 1);
            
        end

      else if (lObject is TppCustomComponent) then
        begin

          if lObject.StretchWithParent then
            AddObjectToList(FStretchers, lObject, 3)

          else if lObject.ShiftWithParent then
            AddObjectToList(FShifters, lObject, 4)

          else
            AddObjectToList(FStatics, lObject, 1);

      end; {if, object is stretchable}
      
    end; {for, each object}

  FObjectLists.Sort;

end; {procedure, CategorizeObjects}

{------------------------------------------------------------------------------}
{ TppCustomRegion.Init }

procedure TppCustomRegion.Init;
var
  liIndex: Integer;
begin

  inherited Init;

  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].Init;
    
  {region dictates total print height}
  PartialAdjustment := mmHeight;

  FreeLists;

  CategorizeObjects;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppCustomRegion.RedrawOnOverFlow }

procedure TppCustomRegion.RedrawOnOverFlow;
var
  liObject: Integer;
begin
  inherited RedrawOnOverFlow;

  for liObject := 0 to FObjects.Count - 1 do
    Objects[liObject].DrawComponent := True;

end; {procedure, RedrawOnOverFlow}

{------------------------------------------------------------------------------}
{ TppCustomRegion.FreeCache }

procedure TppCustomRegion.FreeCache(aCachePageNo: Longint);
begin

  inherited FreeCache(aCachePageNo);

  KeptTogether := False;

 { if (FCacheManager = nil) then Exit;

  FPage.Free;
  FPage := nil;

  FCacheManager.Free;
  FCacheManager := nil;}

end; {procedure, FreeCache}

{------------------------------------------------------------------------------}
{ TppCustomRegion.SavePage }

procedure TppCustomRegion.SavePage;
var
  lObjects: TList;
  liIndex: Integer;
begin

  if (FPage = nil) then
    FPage := TppPage.Create(Self);

  FPage.Assign(Band.Report.Engine.Page);


  if (FCacheManager = nil) then
    begin
      FCacheManager := TppCacheManager.Create(Band.Report);
      FCacheManager.AddNotify(Self);

      lObjects := TList.Create;

      for liIndex := 0 to ObjectCount - 1 do
        lObjects.Add(Objects[liIndex]);

      FCacheManager.ResetCacheWithObjectList(lObjects);

      lObjects.Free;
    end;

  FCacheManager.WriteCache(0);

end; {procedure, SavePage}

{------------------------------------------------------------------------------}
{ TppCustomRegion.RestorePage }

procedure TppCustomRegion.RestorePage;
begin

  if FCacheManager = nil then Exit;

  FCacheManager.ReadCache(0);

  Band.Report.Engine.RestorePipelineState;

  Band.Report.Engine.Page.Assign(FPage);

end; {procedure, RestorePage}

{------------------------------------------------------------------------------}
{ TppCustomRegion.CalcSpaceUsed }

procedure TppCustomRegion.CalcSpaceUsed;
var
  lbShouldKeepTogether: Boolean;
begin

  {save the current state of ShouldKeepTogether,
    this value may be modified when GenerateObjects is called below}
  lbShouldKeepTogether := ShouldKeepTogether;

  if lbShouldKeepTogether then
    SavePage;

  GenerateObjects(ObjectListIndex, ObjectIndex);

  if lbShouldKeepTogether and OverFlow then
    begin
      RestorePage;

      SpaceUsed := 0;
      KeptTogether := True;

      ResetObjects;

      ObjectListIndex := 0;
      ObjectIndex := 0;
      PartialGeneration := False;
      PartialAdjustment := mmHeight;
    end;

  if (KeptTogether) and not(OverFlow) then
    KeptTogether := False;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCustomRegion.ResetObjects }

procedure TppCustomRegion.ResetObjects;
var
  liIndex: Integer;
  lComponent: TppComponent;
begin

  for liIndex := 0 to ObjectCount - 1 do
    begin
      lComponent := Objects[liIndex];

      lComponent.DrawComponent := True;
      lComponent.GenerationComplete := False;
    end;

end; {procedure, ResetObjects}

{------------------------------------------------------------------------------}
{ TppCustomRegion.PrintingSection }

function TppCustomRegion.PrintingSection: Boolean;
begin
  Result := (([esStartSection, esGenerateSection, esEndSection] * Band.Report.Engine.State) <> []);
end; {function, PrintingSection}

{------------------------------------------------------------------------------}
{ TppCustomRegion.GenerateObjects }

procedure TppCustomRegion.GenerateObjects(aListIndex, aObjectIndex: Integer);
var
  liListIndex: Integer;
  liLists: Integer;
  lList: TList;
  liObjectIndex: Integer;
begin

  {init printing properties}
  FMaxStretchable := nil;

  {generate any reprintonoverflow statics first}
  if OverFlow and not(PartialGeneration) and (FStatics <> nil) and (aListIndex <> 0) then
    ProcessQueue(FStatics, 0);

  {loop thru object lists, processing each one}
  liListIndex := aListIndex;
  liObjectIndex := aObjectIndex;

  liLists := FObjectLists.Count;

  while (liListIndex < liLists) do
    begin
      lList := TList(FObjectLists.Objects[liListIndex]);

      ProcessQueue(lList, liObjectIndex);

      if not(AllObjectsPrinted) and not(ObjectListSaved) then
        begin
          ObjectListSaved := True;
          ObjectListIndex := liListIndex;
        end;

      {go to next list}
      if not(PrintingSection) then
        begin
          Inc(liListIndex);

          liObjectIndex := 0;

          {if stretchables don't fit, we're done}
          if (FStretchables <> nil) and (lList = FStretchables) and (SpaceUsed = 0) then
            liListIndex := liLists;
        end
      else
        liListIndex := liLists;

      {let the app catch up}
      ProcessMessages;

    end; {while, each object list}

  {set overflow status}
  OverFlow := ObjectOverFlow;

  {set partial generation status}
  PartialGeneration := not(AllObjectsPrinted) and not(OverFlow);

  if (PartialGeneration) and (PrintQueue.Count = 0) then
    PartialAdjustment := 0

  else if not(PartialGeneration) then
    PartialAdjustment := mmHeight;

  {reset object indexes}
  if (AllObjectsPrinted) then
    begin
      ObjectListIndex := 0;
      ObjectIndex := 0;
    end;

  {set out of space status}
  if (PartialGeneration) then
    OverFlow := True;

end; {procedure, GenerateObjects}

{------------------------------------------------------------------------------}
{ TppCustomRegion.ProcessQueue }

procedure TppCustomRegion.ProcessQueue(aQueue: TList; aObjectIndex: Integer);
var
  liComponent: Integer;
  liComponents: Integer;
  lComponent: TppComponent;
  llCurrentPosition: Longint;
  llCheckPosition: Longint;
  llMaxStretchablePosition: Longint;
begin

  llCurrentPosition := CurrentPosition;

  llMaxStretchablePosition := 0;

  liComponents := aQueue.Count;

  liComponent := aObjectIndex;

  while liComponent < liComponents do
    begin
      lComponent := TppComponent(aQueue[liComponent]);

      lComponent.Generate;

      {add the object to the print queue}
      if (lComponent.SpaceUsed > 0) then
        PrintQueue.AddObject(Format('%8d', [lComponent.ZOrder]), lComponent);

      {indicate that object did not print completely}
      if not(lComponent.GenerationComplete) then
        begin

          {if this component was the first not to print, save it's position in the list}
          if not(ObjectSaved) then
            begin
              ObjectSaved := True;
              ObjectIndex := liComponent;

              if (lComponent is TppStretchable) and TppStretchable(lComponent).Stretch then
                ObjectOverFlow := True
              else
                ObjectOverFlow := False;
            end;

          if ((lComponent.mmTop - mmTop) < PartialAdjustment) then
            PartialAdjustment := lComponent.mmTop - mmTop;

          AllObjectsPrinted := False;
        end;

      {default max stretchable, whenever possible}
      if (lComponent is TppStretchable) and (FMaxStretchable = nil) then
        FMaxStretchable := TppStretchable(lComponent);

      if (ParentStretch and Stretch) and (lComponent.SpaceUsed > 0) then
        begin
          llCheckPosition := lComponent.PrintPosRect.Top + lComponent.SpaceUsed;

          {update the band's spaceused and currentposition}
          if (llCheckPosition > llCurrentPosition) then
            begin
              llCurrentPosition := llCheckPosition;

              {assign new max stretchable, based on max stretchable position}
              if (lComponent is TppStretchable) and (llCheckPosition > llMaxStretchablePosition) then
                begin
                  FMaxStretchable := TppStretchable(lComponent);
                  llMaxStretchablePosition := llCheckPosition;
                end;
            end;
        end;

      {go to next component}
      if not(PrintingSection) then
        Inc(liComponent)
      else
        begin
          if not(lComponent.GenerationComplete) and (liComponent <> (liComponents - 1)) then
            begin
              liComponent := liComponents;

              GenerationComplete := True;
            end
          else
            Inc(liComponent);
        end;

      {let the app catch up}
      ProcessMessages;

    end; {while, each object}

  if (llCurrentPosition > CurrentPosition) then
    begin
      CurrentPosition := llCurrentPosition;
      SpaceUsed := CurrentPosition - PrintPosRect.Top;
    end;

end; {procedure, ProcessQueue}

{------------------------------------------------------------------------------}
{ TppCustomRegion.PropertiesToDrawCommand }

procedure TppCustomRegion.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawShape;
  llSide: Longint;
  llXCornerRound: Longint;
  llYCornerRound: Longint;
  llHeight: Longint;
  llWidth: Longint;
  llLeft: Longint;
  llTop: Longint;
  llRight: Longint;
  llBottom: Longint;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawShape) then Exit;

  lDrawCommand := TppDrawShape(aDrawCommand);

  llLeft   := PrintPosRect.Left;
  llTop    := PrintPosRect.Top;
  llHeight := PrintPosRect.Bottom - PrintPosRect.Top;
  llWidth  := PrintPosRect.Right - PrintPosRect.Left;

  {calculate position of shape on canvas}
  llLeft   := llLeft + (FPen.Width div 2);
  llTop    := llTop + (FPen.Width div 2);
  llRight  := (llLeft + llWidth) - ((FPen.Width div 2) * 2);
  llBottom := (llTop + llHeight) - ((FPen.Width div 2) * 2);

  {determine length of the shortest side, use for circles, squares and corner rounding}
  if (llWidth < llHeight) then
    llSide := llWidth
  else
    llSide := llHeight;

  {if shape is square or circle, make 'sides' of shape equal}
  if FShapeType in [stSquare, stRoundSquare, stCircle] then
    begin

      {recalc top & left drawing positions based on centered side}
      Inc(llLeft, (llWidth  - llSide) div 2);
      Inc(llTop,  (llHeight - llSide) div 2);

      {set width and height to side}
      Dec(llRight, (llWidth  - llSide) div 2);
      Dec(llBottom,  (llHeight - llSide) div 2);
    end; {if shape has equal 'sides'}

  {use integer division to calc corner rounding}
  llXCornerRound := llSide div 4;
  llYCornerRound := llSide div 4;

  {transfer properties to draw command}
  lDrawCommand.Brush        := FBrush;
  lDrawCommand.Pen          := FPen;
  lDrawCommand.Left         := llLeft;
  lDrawCommand.Top          := llTop;
  lDrawCommand.Height       := llBottom - llTop;
  lDrawCommand.Width        := llRight - llLeft;
  lDrawCommand.ShapeType    := FShapeType;
  lDrawCommand.XCornerRound := llXCornerRound;
  lDrawCommand.YCornerRound := llYCornerRound;

  {set draw command type}
  if (FShapeType = stSquare) then
    lDrawCommand.ShapeType := stRectangle

  else if (FShapeType = stCircle) then
    lDrawCommand.ShapeType := stEllipse

  else if (FShapeType = stRoundSquare) then
    lDrawCommand.ShapeType := stRoundRect;

end; {procedure, PropertiesToDrawCommand}


{------------------------------------------------------------------------------}
{ TppCustomRegion.GetChildren - write report controls as subcomponents to .DFM }

procedure TppCustomRegion.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  liObject: Integer;

begin

  for liObject := 0 to FObjects.Count - 1 do
     Proc(Objects[liObject]);

end;

{------------------------------------------------------------------------------}
{ TppCustomRegion.MoveObject }

procedure TppCustomRegion.MoveObject(aCurIndex, aNewIndex: Integer);
begin

  if (aNewIndex < 0) then
    aNewIndex := 0

  else if aNewIndex > FObjects.Count-1 then
    aNewIndex := FObjects.Count-1;

  // move object in child list
  FObjects.Move(aCurIndex, aNewIndex);

  // move object in band list
  Band.MoveObject(Objects[aNewIndex].Index, aNewIndex+Index+1);


end; {function, MoveObject}

{******************************************************************************
 *
 **  R E G I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRegion.Create }

constructor TppRegion.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  DefaultPropName     := 'Caption';
  DefaultPropEditType := etAutoEdit;

end;


{******************************************************************************
 *
 *
 *
 ** R T T I
 *
 *
 *
{******************************************************************************}

{******************************************************************************
 *
 ** C U S T O M   R E G I O N   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.RefClass }

class function TraTppCustomRegionRTTI.RefClass: TClass;
begin
  Result := TppCustomRegion;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.GetPropList }

class procedure TraTppCustomRegionRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.GetPropRec }

class function TraTppCustomRegionRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Brush') = 0) then
    ClassPropToRec(aPropName, TBrush, False, aPropRec)

  else if (CompareText(aPropName, 'ObjectCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'Objects') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'MaxStretchable') = 0) then
    ClassPropToRec(aPropName, TppStretchable, True, aPropRec)

  else if (CompareText(aPropName, 'ParentWidth') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Pen') = 0) then
    ClassPropToRec(aPropName, TPen, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.GetParams }

class function TraTppCustomRegionRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Objects') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppComponent, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.CallMethod }

class function TraTppCustomRegionRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lRegion: TppCustomRegion;
  liIndex: Integer;
  lComponent: TppComponent;
begin

  Result := True;
  
  lRegion := TppCustomRegion(aObject);

  if (CompareText(aMethodName, 'Objects') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lComponent := lRegion.Objects[liIndex];

      aParams.SetParamValue(1, Integer(lComponent));
    end
    
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.GetPropValue }

class function TraTppCustomRegionRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Brush') = 0) then
    Integer(aValue) := Integer(TppCustomRegion(aObject).Brush)

  else if (CompareText(aPropName, 'ObjectCount') = 0) then
    Integer(aValue) := TppCustomRegion(aObject).ObjectCount

  else if (CompareText(aPropName, 'MaxStretchable') = 0) then
    Integer(aValue) := Integer(TppCustomRegion(aObject).MaxStretchable)

  else if (CompareText(aPropName, 'ParentWidth') = 0) then
    Boolean(aValue) := TppCustomRegion(aObject).ParentWidth

  else if (CompareText(aPropName, 'Pen') = 0) then
    Integer(aValue) := Integer(TppCustomRegion(aObject).Pen)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCustomRegionRTTI.SetPropValue }

class function TraTppCustomRegionRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Brush') = 0) then
    TppCustomRegion(aObject).Brush := TBrush(aValue)

  else if (CompareText(aPropName, 'Pen') = 0) then
    TppCustomRegion(aObject).Pen := TPen(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  raRegisterRTTI(TraTppCustomRegionRTTI);

finalization

  raUnRegisterRTTI(TraTppCustomRegionRTTI);

end.
