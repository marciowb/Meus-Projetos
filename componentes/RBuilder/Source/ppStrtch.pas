{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppStrtch;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  Controls,
  
  ppComm,
  ppClass,
  ppDevice,
  ppTypes,
  ppUtils,
  ppRTTI;

type

  {@TppStretchable

    Ancestor from which all dynamically sized components descend. The standard
    dynamic classes provided with ReportBuilder are:

            - TppCustomMemo
            - TppCustomRegion
            - TppCustomRichText
            - TppSubReport}

  {@TppStretchable.BottomOffset

    Use the BottomOffset property to define the vertical space that should
    appear after the component has printed.  The BottomOffset is expressed in
    report units.

    Note: The BottomOffset acts as a margin between the stretching component and
    the components that are shifting or stretching in relation to it.}

  {@TppStretchable.CurrentPosition

    The vertical position on the page for this stretchable component.  Before
    the component is generated, this is the starting position; after the
    component is generated, this is the ending position.}

  {@TppStretchable.mmBottomOffset

    The BottomOffset in thousandths of millimeters.}

  {@TppStretchable.mmOverFlowOffset

    The OverFlowOffset in thousandths of millimeters.}

  {@TppStretchable.mmStopPosition

    The StopPosition in thousandths of millimeters.}

  {@TppStretchable.MinHeight

    Defines the minimum height of a stretchable object. MinHeight is enforced
    when an object has no data, is not visible, or shrinks to less than MinHeight.

    Use MinHeight to ensure a stretchable component always takes up a minimum
    amount of vertical space.}

  {@TppStretchable.OverFlowOffset

    Use the OverFlowOffset property to define the vertical space that should be
    above the component when it is overflowing onto an additional page.  The
    OverFlowOffset is expressed in report units.

    Note: The OverFlowOffset acts as a margin between the stretching component
    and the top of the page.}

  {@TppStretchable.PageBottom

    The limit of the useable vertical page space in thousandths of millimeters.}

  {@TppStretchable.PartialAdjustment

    When static components have printed incompletely and are broken across two
    pages, a state of PartialGeneration exists. This property contains the
    amount of negative vertical shift that will be applied to the remaining
    static components when they are printed on the next page.

    Note: This property is used by the Region only.}

  {@TppStretchable.PartialGeneration

    When static components have printed incompletely and are broken across two
    pages, a state of PartialGeneration exists.  This property is used in
    conjunction with the PartialAdjustment property to properly print the
    remaining static components on the next page.

    Note: This property is used by the Region only.}

  {@TppStretchable.ShifterCount

    The number of stretchables that are shifting relative to this stretchable.}

  {@TppStretchable.ShiftRelativeTo

    When multiple stretching components occupy the same band, use this property
    to specify how each component should be positioned relative to other
    stretching components. ShiftRelativeTo can only be used for components that
    are dynamically sized. If you have a static component, such as a label,
    which needs to shift relative to a given stretching component, then place
    the component in a region and set the Region's ShiftRelativeTo to the
    stretching component.

    Note: When stretching components are placed within a region, the
    ShiftRelativeTo property is disabled.

    You may notice that all of the stretching components in the band do not
    always appear in the ShiftRelativeTo dialog when you are assigning this
    property. This is due to validation logic which ensures that components
    which are shifting relative to one another are not involved in a circular
    reference.  In other words, if Memo1 is shifting relative to Memo2, then
    Memo2 cannot shift relative to Memo1, as this would create a situation which
    the report engine could not resolve.}

  {@TppStretchable.StopPosition

    Use the StopPosition property to define the vertical position at which the
    stretchable will stop printing.  The StopPosition is expressed in report
    units.

    Note: Together with the Top and OverFlowOffset properties, the StopPosition
    can be used to restrict a stretchable component to a certain position on the
    page.  This is often useful when you are printing on pre-printed forms and
    need to print information within a certain rectangular area on the page.

    Note: For subreports, this property applies only to subreports that have the
    PrintBehavior set to pbChild.}

  {@TppStretchable.Stretch

    The Stretch property determines whether the Height of the memo automatically
    stretches to allow the entire contents of the memo to be printed.

    Defaults to False.

    To set the Stretch property from the Report Designer, position your mouse
    cursor over the component and click the right mouse button.  The Stretch
    option should be near the bottom of the speedmenu.  If it is checked, the
    memo will stretch, overflowing to additional pages if necessary.  Selecting
    the Stretch option from this menu will toggle its value.}

  TppStretchable = class(TppComponent)
    private
      {property variables}
      FBottomOffset: Longint;
      FKeepTogether: Boolean;
      FKeptTogether: Boolean;
      FOverFlowOffset: Longint;
      FShifters: TList;
      FShiftRelativeTo: TppStretchable;
      FStopPosition: Longint;
      FStretch: Boolean;
      FMinHeight: Integer;

      {report generation variables}
      FAllObjectsPrinted: Boolean;
      FCurrentPosition: Longint;
      FDrawShifter: Boolean;
      FObjectListIndex: Integer;
      FObjectListSaved: Boolean;
      FObjectIndex: Integer;
      FObjectOverFlow: Boolean;
      FObjectSaved: Boolean;
      FPageBottom: Longint;
      FPartialAdjustment: Longint;
      FPartialGeneration: Boolean;
      FPrintQueue: TStrings;

      function  CalcPrintHeight(aTop: Longint): Longint;
      function  CalcPrintLeft: Longint;
      procedure GenerateObjects(aListIndex, aObjectIndex: Integer);
      function  GetBottomOffset: Single;
      function  GetOverFlowOffset: Single;
      function  GetShiftRelativeTo: TppStretchable;
      function  GetShifterCount: Integer;
      function  GetStopPosition: Single;
      function  GetMinHeight: Double;
      function  ParentOverFlow: Boolean;
      procedure ProcessQueue(aQueue: TList; aObjectIndex: Integer);
      procedure SetBottomOffset(Value: Single);
      procedure SetKeepTogether(Value: Boolean);
      procedure SetOverFlowOffset(Value: Single);
      procedure SetStopPosition(Value: Single);
      procedure SetStretch(Value: Boolean);
      procedure SetMinHeight(Value: Double);

      {read/write private 'fake' properties}
      procedure ReadBottomOffset(Reader: TReader);
      procedure ReadOverFlowOffset(Reader: TReader);
      procedure ReadStopPosition(Reader: TReader);
      procedure WriteBottomOffset(Writer: TWriter);
      procedure WriteOverFlowOffset(Writer: TWriter);
      procedure WriteStopPosition(Writer: TWriter);

    protected
      {overriden from TComponent}
      procedure DefineProperties(Filer: TFiler); override;

      procedure BoundsChange; override;
      procedure CalcPrintPosition; virtual;
      function  CalcPrintTop: Longint; virtual;
      procedure CalcSpaceUsed; virtual;
      function  GetDescription: String; override;
      function  GetShiftRelativeToSpaceUsed: Integer;
      function  ParentStretch: Boolean;
      function  PrintStretch: Boolean;
      procedure SetUserName(const Value: TComponentName); override;
      procedure SetRegion(aRegion: TppComponent); override;
      procedure SetReprintOnOverFlow(Value: Boolean); override;
      procedure SetShiftRelativeTo(aStretchable: TppStretchable); virtual;
      procedure SetShiftWithParent(Value: Boolean); override;
      procedure SetAnchors(const Value: TppAnchors); override;
      procedure SetStretchWithParent(Value: Boolean); override;
      function  ShouldKeepTogether: Boolean;

      property BottomOffset: Single read GetBottomOffset write SetBottomOffset stored False;
      property OverFlowOffset: Single read GetOverFlowOffset write SetOverFlowOffset stored False;
      property StopPosition: Single read GetStopPosition write SetStopPosition stored False;

      {report generation properties}
      property AllObjectsPrinted: Boolean read FAllObjectsPrinted write FAllObjectsPrinted;
      property DrawShifter: Boolean read FDrawShifter write FDrawShifter;
      property ObjectIndex: Integer read FObjectIndex write FObjectIndex;
      property ObjectListIndex: Integer read FObjectListIndex write FObjectListIndex;
      property ObjectListSaved: Boolean read FObjectListSaved write FObjectListSaved;
      property ObjectOverFlow: Boolean read FObjectOverFlow write FObjectOverFlow;
      property ObjectSaved: Boolean read FObjectSaved write FObjectSaved;
      property PrintQueue: TStrings read FPrintQueue write FPrintQueue;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure AddShifter(aStretchable: TppStretchable); virtual;
      procedure AfterPrint; override;
      procedure BeforePrint; override;
      procedure Generate; override;
      function  GetChainTop: Longint;
      procedure Init; override;
      procedure Print(aPage: TppPage); override;
      procedure RemoveShifter(aStretchable: TppStretchable); virtual;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;

      property CurrentPosition: Longint read FCurrentPosition write FCurrentPosition;
      property mmOverFlowOffset: Longint read FOverFlowOffset;
      property mmBottomOffset: Longint read FBottomOffset;
      property KeepTogether: Boolean read FKeepTogether write SetKeepTogether default False;
      property KeptTogether: Boolean read FKeptTogether write FKeptTogether;
      property PageBottom: Longint read FPageBottom write FPageBottom;
      property PartialAdjustment: Longint read FPartialAdjustment write FPartialAdjustment;
      property PartialGeneration: Boolean read FPartialGeneration write FPartialGeneration;
      property ShifterCount: Integer read GetShifterCount;
      property ShiftRelativeTo: TppStretchable read GetShiftRelativeTo write SetShiftRelativeTo;
      property mmStopPosition: Longint read FStopPosition;
      property Stretch: Boolean read FStretch write SetStretch default False;
      property MinHeight: Double read GetMinHeight write SetMinHeight;

    published

  end; {class, TppStretchable }


  {@TraTppStretchableRTTI }
  TraTppStretchableRTTI = class(TraTppComponentRTTI)
    public
      {class procedure GetPropList(aPropList: TraPropList); override;}
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      {class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList): Boolean; override;}
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppStretchableRTTI}


implementation

uses ppBands, ppCtrls, ppRegion, ppClasUt, ppSubRpt;



{******************************************************************************
 *
 ** S T R E T C H A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppStretchable.Create }

constructor TppStretchable.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  CacheRecordSize  := SizeOf(TppStretchableSaveRec);

  {properties}
  FBottomOffset := 0;
  FKeepTogether := False;
  FKeptTogether := False;
  FOverFlowOffset := 0;
  FShiftRelativeTo := nil;
  FShifters := TList.Create;
  FStopPosition := 0;
  FStretch := False;
  FMinHeight := 0;

  {print processing}
  FAllObjectsPrinted := False;
  FCurrentPosition := 0;
  FDrawShifter := False;
  FObjectListIndex := 0;
  FObjectListSaved := False;
  FObjectIndex := 0;
  FObjectOverFlow := False;
  FObjectSaved := False;
  FPageBottom := 0;
  FPartialAdjustment := 0;
  FPartialGeneration := False;
  FPrintQueue := TStringList.Create;

  {init inherited properties}
  AutoSize    := False;
  spHeight    := 89;
  spWidth     := 185;
  WordWrap    := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppStretchable.Destroy }

destructor TppStretchable.Destroy;
begin

  FPrintQueue.Free;
  FShifters.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppStretchable.ParentStretch }

function TppStretchable.ParentStretch: Boolean;
begin
  if (Parent is TppBand) then
    Result := (Band.PrintHeight = phDynamic)
  else
    Result := TppCustomRegion(Parent).Stretch and (Band.PrintHeight = phDynamic);
end; {function, ParentStretch}

{------------------------------------------------------------------------------}
{ TppStretchable.PrintStretch }

function TppStretchable.PrintStretch: Boolean;
begin
  Result := (ParentStretch and Stretch) or (StopPosition <> 0);
end; {function, PrintStretch}

{------------------------------------------------------------------------------}
{ TppStretchable.CalcSpaceUsed }

procedure TppStretchable.CalcSpaceUsed;
begin

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppStretchable.SetUserName }

procedure TppStretchable.SetUserName(const Value: TComponentName);
var
  lsOldName : String;

begin

  lsOldName := UserName;

  inherited SetUserName(Value);

  {the Value may be invalid }
  if (lsOldName = UserName) then Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) and
     not (pppcPasting in DesignState) then Exit;

  {on name change, also change caption if it is the same as the name}
  if (Caption = '') or (Caption = lsOldName) then
    Caption := Value;

end; {procedure, SetUserName}

{------------------------------------------------------------------------------}
{ TppStretchable.SetRegion }

procedure TppStretchable.SetRegion(aRegion: TppComponent);
begin

  if (aRegion <> nil) and not (aRegion is TppRegion) then Exit;


  inherited SetRegion(aRegion);

  if (FShiftRelativeTo <> nil) then
    SetShiftRelativeTo(nil);

  {do not allow region to be set to ShiftRelativeTo self}
  if (aRegion <> nil) and (TppRegion(aRegion).ShiftRelativeTo = Self) then
    TppRegion(aRegion).ShiftRelativeTo := nil;

end; {procedure, SetRegion}

{------------------------------------------------------------------------------}
{ TppStretchable.Notify}

procedure TppStretchable.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (csDestroying in ComponentState) then Exit;

  if (aOperation = ppopRemove) then
    if (aCommunicator = FShiftRelativeTo) then
      FShiftRelativeTo := nil

    else if (FShifters.IndexOf(aCommunicator) <> -1) then
      FShifters.Remove(aCommunicator);

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppStretchable.BoundsChange }

procedure TppStretchable.BoundsChange;
begin
  inherited BoundsChange;

  if not (pppcDesigning in DesignState) or (Printing) then Exit;

  if (Band = nil) then Exit;

  {note: if reading or loading and not pasting}
  if ((csReading in ComponentState) or (csLoading in ComponentState)) and not(pppcPasting in DesignState)  then Exit;

  {notify report designer}
  if (Stretch) then
    Reset;

end; {procedure, BoundsChange}

{------------------------------------------------------------------------------}
{ TppStretchable.ShouldKeepTogether }

function  TppStretchable.GetShiftRelativeToSpaceUsed: Integer;
begin
  Result := 0;

  {reursive calculate the space used by all ShiftRelativeTo objects in the chain}
  if (ShiftRelativeTo <> nil) then
    Result := ShiftRelativeTo.SpaceUsed + ShiftRelativeTo.GetShiftRelativeToSpaceUsed;

end; {procedure, GetShiftRelativeToSpaceUsed}

{------------------------------------------------------------------------------}
{ TppStretchable.ShouldKeepTogether }

function TppStretchable.ShouldKeepTogether: Boolean;
begin

  if not(FKeepTogether) then
    Result := False

  else if (FKeptTogether) then
    Result := False

  else if (ShiftRelativeTo <> nil) then
    begin
      if (GetShiftRelativeToSpaceUsed <> 0) then
        Result := True
      else
        Result := False;
    end

  else
    begin
      Result := GetMainReport.Engine.PageStarted;

      if not(Result) and (TppCustomBand(Band).SpaceUsed <> 0) then
        Result := True;
    end;

end; {procedure, ShouldKeepTogether}

{------------------------------------------------------------------------------}
{ TppStretchable.GetDescription }

function TppStretchable.GetDescription: String;
begin
  Result := UserName;
end; {function, GetDescription}

{------------------------------------------------------------------------------}
{ TppStretchable.DefineProperties }

procedure TppStretchable.DefineProperties(Filer: TFiler);
var
  lAncestor: TppStretchable;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppStretchable) then
    lAncestor := TppStretchable(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('mmBottomOffset', ReadBottomOffset, WriteBottomOffset, FBottomOffset <> lAncestor.FBottomOffset);
      Filer.DefineProperty('mmOverFlowOffset', ReadOverFlowOffset, WriteOverFlowOffset, FOverFlowOffset <> lAncestor.FOverFlowOffset);
      Filer.DefineProperty('mmStopPosition', ReadStopPosition, WriteStopPosition, FStopPosition <> lAncestor.FStopPosition);
    end
  else
    begin
      Filer.DefineProperty('mmBottomOffset', ReadBottomOffset, WriteBottomOffset, True);
      Filer.DefineProperty('mmOverFlowOffset', ReadOverFlowOffset, WriteOverFlowOffset, True);
      Filer.DefineProperty('mmStopPosition', ReadStopPosition, WriteStopPosition, True);
    end;

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppStretchable.ReadBottomOffset }

procedure TppStretchable.ReadBottomOffset(Reader: TReader);
begin
  FBottomOffset := ppReadIntegerPropValue(Reader);
end; {procedure, ReadBottomOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.WriteBottomOffset }

procedure TppStretchable.WriteBottomOffset(Writer: TWriter);
begin
  Writer.WriteInteger(FBottomOffset);
end; {procedure, WriteBottomOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.ReadOverFlowOffset }

procedure TppStretchable.ReadOverFlowOffset(Reader: TReader);
begin
  FOverFlowOffset := ppReadIntegerPropValue(Reader);
end; {procedure, ReadOverFlowOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.WriteOverFlowOffset }

procedure TppStretchable.WriteOverFlowOffset(Writer: TWriter);
begin
  Writer.WriteInteger(FOverFlowOffset);
end; {procedure, WriteOverFlowOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.ReadStopPosition }

procedure TppStretchable.ReadStopPosition(Reader: TReader);
begin
  FStopPosition := ppReadIntegerPropValue(Reader);
end; {procedure, ReadStopPosition}

{------------------------------------------------------------------------------}
{ TppStretchable.WriteStopPosition }

procedure TppStretchable.WriteStopPosition(Writer: TWriter);
begin
  Writer.WriteInteger(FStopPosition);
end; {procedure, WriteStopPosition}

{------------------------------------------------------------------------------}
{ TppStretchable.GetBottomOffset }

function TppStretchable.GetBottomOffset: Single;
begin
  Result := FromMMThousandths(FBottomOffset, Units, pprtVertical)
end; {procedure, GetBottomOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.SetBottomOffset }

procedure TppStretchable.SetBottomOffset(Value: Single);
begin

  FBottomOffset := ToMMThousandths(Value, Units, pprtVertical);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetBottomOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.GetOverFlowOffset }

function TppStretchable.GetOverFlowOffset: Single;
begin
  Result := FromMMThousandths(FOverFlowOffset, Units, pprtVertical)
end; {procedure, GetOverFlowOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.SetOverFlowOffset }

procedure TppStretchable.SetOverFlowOffset(Value: Single);
begin

  FOverFlowOffset := ToMMThousandths(Value, Units, pprtVertical);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetOverFlowOffset}

{------------------------------------------------------------------------------}
{ TppStretchable.GetStopPosition }

function TppStretchable.GetStopPosition: Single;
begin
  Result := FromMMThousandths(FStopPosition, Units, pprtVertical)
end; {procedure, GetStopPosition}

{------------------------------------------------------------------------------}
{ TppStretchable.SetStopPosition }

procedure TppStretchable.SetStopPosition(Value: Single);
begin

  FStopPosition := ToMMThousandths(Value, Units, pprtVertical);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetStopPosition}

{------------------------------------------------------------------------------}
{ TppStretchable.SetKeepTogether }

procedure TppStretchable.SetKeepTogether(Value: Boolean);
begin

  FKeepTogether := Value;

  Reset;

  PropertyChange;

end; {procedure, SetKeepTogether}

{------------------------------------------------------------------------------}
{ TppStretchable.GetMinHeight }

function TppStretchable.GetMinHeight: Double;
begin
  Result := ppFromMMThousandths(FMinHeight, Units, pprtVertical, GetPrinter);

end; {function, GetMinHeight}

{------------------------------------------------------------------------------}
{ TppStretchable.SetMinHeight }

procedure TppStretchable.SetMinHeight(Value: Double);
begin
  if Value < 0 then
    FMinHeight := 0
  else
    FMinHeight := ppToMMThousandths(Value, Units, pprtVertical, GetPrinter);

end; {procedure, SetMinHeight}

{@TppStretchable.SetReprintOnOverFlow

  For stretchable components that are not stretching, this property allows you
  to reprint the component when other stretching components in the band or
  region overflow to a new page.

  Defaults to False.

  To set the ReprintOnOverFlow property from the Report Designer, position
  your mouse cursor over the component and click the right mouse button.
  The ReprintOnOverFlow option will be displayed in the speedmenu.  If it is
  checked, ReprintOnOverFlow is on. Selecting the ReprintOnOverFlow option
  from this menu will toggle its value.}

procedure TppStretchable.SetReprintOnOverFlow(Value: Boolean);
begin

  inherited SetReprintOnOverFlow(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (ReprintOnOverFlow) then
    begin
      SetShiftRelativeTo(nil);
      SetStretch(False);
    end;

end; {procedure, SetReprintOnOverFlow}

procedure TppStretchable.SetAnchors(const Value: TppAnchors);
begin
  if (atBottom in Value) and (Stretch) then Exit;

  inherited SetAnchors(Value);

end;

{@TppStretchable.SetShiftWithParent

  For stretchable components that are not stretching, this property allows you to shift the
  component in relation to the maximum stretching component in the band or region.

  Defaults to False.

  To set the ShiftWithParent property from the Report Designer, position your
  mouse cursor over the component and click the right mouse button.  The
  ShiftWithParent option will be displayed in the speedmenu.  If it is
  checked, ShiftWithParent is on.  Selecting the ShiftWithParent option from
  this menu will toggle its value.}

procedure TppStretchable.SetShiftWithParent(Value: Boolean);
begin

  inherited SetShiftWithParent(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (ShiftWithParent) then
    begin
      SetShiftRelativeTo(nil);
      SetStretch(False);
    end;

end; {procedure, SetShiftWithParent}

{------------------------------------------------------------------------------}
{ TppStretchable.SetStretchWithParent }

procedure TppStretchable.SetStretchWithParent(Value: Boolean);
begin

  inherited SetStretchWithParent(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (StretchWithParent) then
    begin
      SetShiftRelativeTo(nil);
      SetStretch(False);
    end;

end; {procedure, SetStretchWithParent}

{------------------------------------------------------------------------------}
{ TppStretchable.SetStretch }

procedure TppStretchable.SetStretch(Value: Boolean);
begin
  FStretch := Value;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if FStretch then
    begin
      if atBottom in Anchors then
        begin
          Anchors := Anchors - [atBottom];
          Anchors := Anchors + [atTop];
        end;

      SetReprintOnOverFlow(False);
      SetStretchWithParent(False);

      {tell parent to stretch also}
      if (Region <> nil) and not TppRegion(Region).Stretch then
        TppRegion(Region).Stretch := True

      else if (Band <> nil) and (Band.PrintHeight = phStatic) then
        Band.PrintHeight := phDynamic;
    end
    
  else if (FShifters.Count > 0) then
    begin
      {if Shifter, then must also stretch}
      FStretch := True;
      Exit;
    end;

  Reset;

  PropertyChange;

end; {procedure, SetStretch}

{------------------------------------------------------------------------------}
{ TppStretchable.SetShiftRelativeTo }

procedure TppStretchable.SetShiftRelativeTo(aStretchable: TppStretchable);
begin

  if (FShiftRelativeTo <> aStretchable) then
    begin

     {make sure stretchable does not form cyclic chain}
     if not(ppIsValidStretchable(Self, aStretchable)) then
       raise EInvalidPropertyError.Create(ppLoadStr(342));

     if FShiftRelativeTo <> nil then
       FShiftRelativeTo.RemoveShifter(Self);

      FShiftRelativeTo := aStretchable;

      {notify designer}
      PropertyChange;

      {notify report engine}
      Reset;

      if FShiftRelativeTo <> nil then
        begin
          FShiftRelativeTo.AddShifter(Self);

          SetReprintOnOverFlow(False);
          SetShiftWithParent(False);
          SetStretchWithParent(False);

        end;

    end;

end; {procedure, SetShiftRelativeTo}

{------------------------------------------------------------------------------}
{ TppStretchable.AddShifter }

procedure TppStretchable.AddShifter(aStretchable: TppStretchable);
begin

  FShifters.Add(aStretchable);

  {if Shifter, then must also stretch}
  if not Stretch then
    SetStretch(True);

  {add component to notify list}
  AddNotify(aStretchable);

end; {procedure, AddShifter}

{------------------------------------------------------------------------------}
{ TppStretchable.RemoveShifter }

procedure TppStretchable.RemoveShifter(aStretchable: TppStretchable);
begin
  FShifters.Remove(aStretchable);

  {remove component from notify list}
  RemoveNotify(aStretchable);

end; {procedure, RemoveShifter}

{------------------------------------------------------------------------------}
{ TppStretchable.GetShifterCount }

function TppStretchable.GetShifterCount: Integer;
begin
  Result := FShifters.Count;
end; {function, GetShifterCount}

{------------------------------------------------------------------------------}
{ TppStretchable.GetShiftRelativeTo }

function TppStretchable.GetShiftRelativeTo: TppStretchable;
begin
  Result := FShiftRelativeTo;

  if csWriting in ComponentState then Exit;

  {make sure ShiftRelativeTo exists in this band}
  if (FShiftRelativeTo <> nil) and (Band.FindObject(FShiftRelativeTo) = -1) then
    SetShiftRelativeTo(nil);

  Result := FShiftRelativeTo;

end; {function, GetShiftRelativeTo}

{------------------------------------------------------------------------------}
{ TppStretchable.ParentOverFlow }

function TppStretchable.ParentOverFlow: Boolean;
begin
  if (Parent is TppBand) then
    Result := TppCustomBand(Parent).OverFlow
  else
    Result := TppCustomRegion(Parent).OverFlow;
end; {function, ParentOverFlow}

{------------------------------------------------------------------------------}
{ TppStretchable.RestoreFromCache }

procedure TppStretchable.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppStretchableSaveRec;

begin
  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent     := lRec.FDrawComponent;
  DrawShifter       := lRec.FDrawShifter;
  ObjectIndex       := lRec.FObjectIndex;
  OverFlow          := lRec.FOverFlow;
  PartialGeneration := lRec.FPartialGeneration;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppStretchable.SaveToCache }

procedure TppStretchable.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppStretchableSaveRec;
begin

  lRec.FDrawComponent     := DrawComponent;
  lRec.FDrawShifter       := DrawShifter;
  lRec.FObjectIndex       := ObjectIndex;
  lRec.FOverFlow          := OverFlow;
  lRec.FPartialGeneration := PartialGeneration;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppStretchable.Init }

procedure TppStretchable.Init;
begin

  inherited Init;

  FDrawShifter       := False;
  FKeptTogether      := False;
  FObjectListIndex   := 0;
  FObjectIndex       := 0;
  FPartialAdjustment := 0;
  FPartialGeneration := False;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppStretchable.BeforePrint }

procedure TppStretchable.BeforePrint;
begin
  inherited BeforePrint;

  {init printing properties}
  FAllObjectsPrinted := True;
  FCurrentPosition := 0;
  FObjectListSaved := False;
  FObjectSaved := False;
  FObjectOverFlow := False;
  FPageBottom := 0;
  FPrintQueue.Clear;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppStretchable.AfterPrint }

procedure TppStretchable.AfterPrint;
begin

  inherited AfterPrint;

  {turn drawcomponent off if reached shifters}
  if (DrawComponent) and (FDrawShifter) then
    DrawComponent := False;

  {reset draw shifter}
  if (FDrawShifter) and not(OverFlow) and not(FPartialGeneration) then
    FDrawShifter := False;

  {reset object index}
  if (FAllObjectsPrinted) then
    FObjectIndex := 0;

end; {procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppStretchable.Generate }

procedure TppStretchable.Generate;
var
  liIndex: Integer;
begin

  {reset draw component, for reprintonoverflow}
  if ReprintOnOverFlow and (ParentOverFlow) then
    RedrawOnOverFlow;

  {fire OnPrint event}
  DoOnPrint;

  {calc the print position}
  CalcPrintPosition;

  if (OutOfSpace) then Exit;

  if (DrawComponent) and not(OverFlow) and not(FDrawShifter) then
    begin
      FDrawShifter := True;

      for liIndex := 0 to FShifters.Count - 1 do
        TppStretchable(FShifters[liIndex]).DrawComponent := True;
    end;

  {allow stretchable shiftrelativeto's to generate}
  if (FDrawShifter) then
    GenerateObjects(0, FObjectIndex);

  if not(OverFlow) and not(FPartialGeneration) then
    GenerationComplete := True;

end; {procedure, Generate}

{------------------------------------------------------------------------------}
{ TppStretchable.CalcPrintPosition }

procedure TppStretchable.CalcPrintPosition;
var
  llNewLeft: Longint;
  llNewTop: Longint;
  llNewHeight: Longint;
  lRect: TppRect;
begin

  llNewLeft := CalcPrintLeft;
  llNewTop := CalcPrintTop;
  llNewHeight := CalcPrintHeight(llNewTop);

  {set the initial print position}
  if PrintStretch then
    begin
      lRect.Left   := llNewLeft;
      lRect.Top    := llNewTop;
      lRect.Right  := lRect.Left + mmWidth;
      lRect.Bottom := FPageBottom;
    end
  else
    begin
      lRect.Left   := llNewLeft;
      lRect.Top    := llNewTop;
      lRect.Right  := lRect.Left + mmWidth;
      lRect.Bottom := lRect.Top + llNewHeight;
    end;

  PrintPosRect := lRect;

  {if potential new height doesn't fit, we're outta here}
  if DrawComponent and Visible then
    begin

      if ((llNewTop + llNewHeight) > (FPageBottom + 1)) then
        begin
          OutOfSpace := True;

          Exit;
        end;
        
    end;

  {calc space used}
  if DrawComponent and Visible then
    begin

      {calc default space used}
      if not(PrintStretch) then
        SpaceUsed := llNewHeight;

      {allow component to calculate space used}
      CalcSpaceUsed;
    end;

  // enforce min height
  if (SpaceUsed < FMinHeight) then
    SpaceUsed := FMinHeight;

  {update print position based on space used}
  lRect.Left   := PrintPosRect.Left;
  lRect.Top    := PrintPosRect.Top;
  lRect.Right  := PrintPosRect.Right;
  lRect.Bottom := PrintPosRect.Top + SpaceUsed;

  PrintPosRect := lRect;

  {increment space used for bottom offset}
  if DrawComponent and Visible then
    begin
      if (SpaceUsed > 0) then
        SpaceUsed := SpaceUsed + mmBottomOffset;
    end;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppStretchable.CalcPrintLeft }

function TppStretchable.CalcPrintLeft: Longint;
var
  lBand: TppCustomBand;
begin

  lBand := TppCustomBand(Band);

  if DrawComponent and Visible then
    Result := lBand.PrintPosRect.Left + mmLeft

  else
    Result := lBand.PrintPosRect.Left;

end; {procedure, CalcPrintLeft}

{------------------------------------------------------------------------------}
{ TppStretchable.CalcPrintHeight }

function TppStretchable.CalcPrintHeight(aTop: Longint): Longint;
var
  llNewHeight: Longint;
  llCurrentPosition: Longint;
begin

  llNewHeight := 0;

  Result := llNewHeight;

  if not(DrawComponent and Visible) then Exit;

  {calculate potential new height}
  if (PrintStretch) then
    llNewHeight := 0
  else
    llNewHeight := mmHeight;

  {adjust height if stretching with parent}
  if (StretchWithParent) then
    begin

      {get current position}
      if Parent is TppBand then
        llCurrentPosition := TppCustomBand(Parent).CurrentPosition
      else
        llCurrentPosition := TppCustomRegion(Parent).CurrentPosition;

      if (aTop < llCurrentPosition) then
        llNewHeight := llCurrentPosition - aTop;

      {if stretched beyond page, adjust stretch}
      if (aTop < FPageBottom) and ((aTop + llNewHeight) > FPageBottom) then
        llNewHeight := FPageBottom - aTop;

    end;

  Result := llNewHeight;

end; {procedure, CalcPrintHeight}

{------------------------------------------------------------------------------}
{ TppStretchable.CalcPrintTop }

function TppStretchable.CalcPrintTop: Longint;
var
  lBand: TppCustomBand;
  lRegion: TppCustomRegion;
  llNewTop: Longint;
  llMinTop: Longint;
  llRelativeTop: Longint;
  lMaxStretchable: TppStretchable;
  llChange: Longint;
  lbPartialGeneration: Boolean;
  llPartialAdjustment: Longint;
  llPageBottom: Longint;
  llCurrentPosition: Longint;
  lShiftRelativeTo: TppStretchable;
begin

  lBand := TppCustomBand(Band);

  {calc max stretchable and change in parent height}
  llChange := 0;
  lMaxStretchable := nil;

  lShiftRelativeTo := GetShiftRelativeTo;

  {determine parent's position and state}
  if (lShiftRelativeTo <> nil) then
    begin
      llCurrentPosition := lShiftRelativeTo.CurrentPosition;
     { llPageBottom := lShiftRelativeTo.PageBottom;}
      llPageBottom := lBand.PageBottom;
      lbPartialGeneration := False;
      llPartialAdjustment := 0;

      llNewTop := llCurrentPosition;
      llMinTop := 0;
    end

  else if Parent is TppBand then
    begin
      {llCurrentPosition := lBand.PrintPosRect.Top;}
      llCurrentPosition := lBand.CurrentPosition;
      llPageBottom := lBand.PageBottom;
      lbPartialGeneration := lBand.PartialGeneration;
      llPartialAdjustment := lBand.PartialAdjustment;

      llNewTop := lBand.PrintPosRect.Top + mmTop;
      llMinTop := lBand.PrintPosRect.Top;

      if (lBand.SpaceUsed > 0) then
        begin
          lMaxStretchable := lBand.MaxStretchable;
          llChange := lBand.SpaceUsed - lBand.mmHeight;
        end;

    end

  else
    begin
      lRegion := TppCustomRegion(Parent);

      llCurrentPosition := lRegion.CurrentPosition;
      {llCurrentPosition := lRegion.PrintPosRect.Top;}
      llPageBottom := lRegion.PageBottom;
      lbPartialGeneration := lRegion.PartialGeneration;
      llPartialAdjustment := lRegion.PartialAdjustment;

      llNewTop := lRegion.PrintPosRect.Top + (mmTop - lRegion.mmTop);
      llMinTop := lRegion.PrintPosRect.Top;

      if (lRegion.SpaceUsed > 0) then
        begin
          lMaxStretchable := lRegion.MaxStretchable;
          llChange := lRegion.SpaceUsed - lRegion.mmHeight;
        end;

    end;

  {adjust top for special conditions}
  if lbPartialGeneration then
    llNewTop := llNewTop - llPartialAdjustment

  else if OverFlow and (FStopPosition = 0) then
    begin
      llNewTop := llCurrentPosition;

      {increment the top for the overflow offset}
      if (lShiftRelativeTo = nil) then
         llNewTop := llNewTop + FOverFlowOffset;
    end

  else if (ShiftWithParent) and (ShiftRelativeTo = nil) then
    begin

      {adjust top if shifting with parent}
      if (lMaxStretchable <> nil) then
        begin
          llRelativeTop := mmTop - (lMaxStretchable.mmTop + lMaxStretchable.mmHeight);

          llNewTop := lMaxStretchable.PrintPosRect.Top + lMaxStretchable.SpaceUsed + llRelativeTop;
        end

      else
        llNewTop := llNewTop + llChange;

    end;

  {Top Position cannot be smaller than the top position of the band.}
  if llNewTop < llMinTop then
    llNewTop := llMinTop;

  Result := llNewTop;

  {update current position and page bottom}
  FCurrentPosition := llNewTop;

  if (FStopPosition <> 0) and (FStopPosition < llPageBottom) then
    FPageBottom := FStopPosition - mmBottomOffset
  else
    FPageBottom := llPageBottom - mmBottomOffset;

end; {procedure, CalcPrintTop}

{------------------------------------------------------------------------------}
{ TppStretchable.GenerateObjects }

procedure TppStretchable.GenerateObjects(aListIndex, aObjectIndex: Integer);
begin

  {update current position}
  FCurrentPosition := PrintPosRect.Top + SpaceUsed;
  FPageBottom := FPageBottom + mmBottomOffset;

  {loop thru objects, processing each one}
  ProcessQueue(FShifters, aObjectIndex);

  {set overflow status}
  OverFlow := FObjectOverFlow;

  {set partial generation status}
  FPartialGeneration := not(FAllObjectsPrinted) and not(OverFlow);

end; {procedure, GenerateObjects}

{------------------------------------------------------------------------------}
{ TppStretchable.ProcessQueue }

procedure TppStretchable.ProcessQueue(aQueue: TList; aObjectIndex: Integer);
var
  liComponent: Integer;
  liComponents: Integer;
  lComponent: TppComponent;
  llCurrentPosition: Longint;
  llCheckPosition: Longint;
begin

  llCurrentPosition := CurrentPosition;

  liComponents := aQueue.Count;

  liComponent := aObjectIndex;

  while liComponent < liComponents do
    begin
      lComponent := TppComponent(aQueue[liComponent]);

      lComponent.Generate;

      {add the object to the print queue}
      if (lComponent.SpaceUsed > 0) then
        FPrintQueue.AddObject(Format('%8d', [lComponent.ZOrder]), lComponent);

      {indicate that object did not print completely}
      if not(lComponent.GenerationComplete) then
        begin

          {if this component was the first not to print, save it's position in the list}
          if not(FObjectSaved) then
            begin
              FObjectSaved := True;
              FObjectIndex := liComponent;

              if (lComponent is TppStretchable) and TppStretchable(lComponent).Stretch then
                FObjectOverFlow := True
              else
                FObjectOverFlow := False;
            end;

          if (lComponent.mmTop < FPartialAdjustment) then
            FPartialAdjustment := lComponent.mmTop;

          FAllObjectsPrinted := False;
        end;

      if (lComponent.SpaceUsed > 0) then
        begin
          llCheckPosition := lComponent.PrintPosRect.Top + lComponent.SpaceUsed;

          {update the band's spaceused and currentposition}
          if (llCheckPosition > llCurrentPosition) then
            llCurrentPosition := llCheckPosition;

        end;

      Inc(liComponent);

      {let the app catch up}
      ProcessMessages;

    end; {while, each object}

  if (llCurrentPosition > CurrentPosition) then
    begin
      CurrentPosition := llCurrentPosition;

      SpaceUsed := FCurrentPosition - PrintPosRect.Top;
    end;

end; {procedure, ProcessQueue}

{------------------------------------------------------------------------------}
{ TppStretchable.Print }

procedure TppStretchable.Print(aPage: TppPage);
var
  liComponent: Integer;
  liComponents: Integer;
  lComponent: TppComponent;
begin

  inherited Print(aPage);

  liComponents := FPrintQueue.Count;

  {sort objects by z-order}
  TStringList(FPrintQueue).Sort;

  for liComponent := 0 to liComponents - 1 do
    begin
      lComponent := TppComponent(FPrintQueue.Objects[liComponent]);

      lComponent.Print(aPage);

      {let the app catch up}
      ProcessMessages;
    end;

end; {procedure, Print}

{------------------------------------------------------------------------------}
{ TppStretchable.GetChainTop }

function TppStretchable.GetChainTop: Longint;
var
  lShiftRelativeTo: TppStretchable;
begin
  lShiftRelativeTo := GetShiftRelativeTo;

  if (lShiftRelativeTo = nil) then
    Result := mmTop
  else
    Result := lShiftRelativeTo.GetChainTop;

end; {function, GetChainTop}


{******************************************************************************
 *
 ** S T R E T C H A B L E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppStretchableRTTI.RefClass }

class function TraTppStretchableRTTI.RefClass: TClass;
begin
  Result := TppStretchable;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppStretchableRTTI.GetPropRec }

class function TraTppStretchableRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CurrentPosition') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'mmBottomOffset') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'mmOverFlowOffset') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'KeepTogether') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'KeptTogether') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'PageBottom') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'PartialAdjustment') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'PartialGeneration') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'ShifterCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'ShiftRelativeTo') = 0) then
    ClassPropToRec(aPropName, TppStretchable, False, aPropRec)

  else if (CompareText(aPropName, 'mmStopPosition') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'Stretch') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppStretchableRTTI.GetPropValue }

class function TraTppStretchableRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CurrentPosition') = 0) then
    Integer(aValue) := TppStretchable(aObject).CurrentPosition

  else if (CompareText(aPropName, 'mmBottomOffset') = 0) then
    Integer(aValue) := TppStretchable(aObject).mmBottomOffset

  else if (CompareText(aPropName, 'mmOverFlowOffset') = 0) then
    Integer(aValue) := TppStretchable(aObject).mmOverFlowOffset

  else if (CompareText(aPropName, 'KeepTogether') = 0) then
    Boolean(aValue) := TppStretchable(aObject).KeepTogether

  else if (CompareText(aPropName, 'KeptTogether') = 0) then
    Boolean(aValue) := TppStretchable(aObject).KeptTogether

  else if (CompareText(aPropName, 'PageBottom') = 0) then
    Integer(aValue) := TppStretchable(aObject).PageBottom

  else if (CompareText(aPropName, 'PartialAdjustment') = 0) then
    Integer(aValue) := TppStretchable(aObject).PartialAdjustment

  else if (CompareText(aPropName, 'PartialGeneration') = 0) then
    Boolean(aValue) := TppStretchable(aObject).PartialGeneration

  else if (CompareText(aPropName, 'ShifterCount') = 0) then
    Integer(aValue) := TppStretchable(aObject).ShifterCount

  else if (CompareText(aPropName, 'ShiftRelativeTo') = 0) then
    Integer(aValue) := Integer(TppStretchable(aObject).ShiftRelativeTo)

  else if (CompareText(aPropName, 'mmStopPosition') = 0) then
    Integer(aValue) := TppStretchable(aObject).mmStopPosition

  else if (CompareText(aPropName, 'Stretch') = 0) then
    Boolean(aValue) := TppStretchable(aObject).Stretch

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppStretchableRTTI.SetPropValue }

class function TraTppStretchableRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'KeepTogether') = 0) then
    TppStretchable(aObject).KeepTogether := Boolean(aValue)

  else if (CompareText(aPropName, 'ShiftRelativeTo') = 0) then
    TppStretchable(aObject).ShiftRelativeTo := TppStretchable(aValue)

  else if (CompareText(aPropName, 'Stretch') = 0) then
    TppStretchable(aObject).Stretch := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


initialization

  raRegisterRTTI(TraTppStretchableRTTI);

finalization

  raUnRegisterRTTI(TraTppStretchableRTTI);


end.
