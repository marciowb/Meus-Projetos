{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppDesignSelection;

interface

{$I ppIfDef.pas}

uses
  Types,
  Classes,
  Controls,


  ppTypes,
  ppComm,
  ppClass,
  ppCollectionBase,
  ppDsIntf,
  ppDesignControls,
  ppDesignerWorkspace,
  ppDesignEventHub,
  ppParameter;

{ SelectionObject

  SelectionObjectCollection

  Selection
    Add(aComponent: TppComponent);
    Remove(aComponent: TppComponent);
    Contains(aComponent: TppComponent);
    Clear()
    BeginUpdate();
    EndUpdate();

    // arrays
    Components[Index: Integer]: TppComponent
    DesignControls[Index: Integer]: TppDesignControls
    SelectionObjects[]: TppSelectionObject

    // events
    OnChanged();
    BeginUpdate
    EndUpdate
    BeforeAdd
    AfterAdd
    BeforeRemove
    AfterRemove
    BeforeClear
    AfterClear


  SelectionController
    Align(aAlignAction);
    Space(aSpaceAction);
    Size(aSizeAction);
    Nugde(aNudgeAction);
    Delete();
    UnDelete()
    Move
    Show()
    ShowBoundsRects()
    ToClipBoard()
    FromClipBoard()
    ToStream(aStream)
    FromStream(aStream)
    FromRectangle(aRect)

}

type

  {TppComponentCollection}
  TppComponentCollection = class(TppComponentCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppComponent;

  public
    function IndexOf(aObject: TppComponent): Integer;
    procedure Add(aObject: TppComponent);  virtual;
    procedure Remove(aObject: TppComponent); virtual;

    property Items[Index: Integer]: TppComponent read GetItemForIndex; default;

  end;

  {TppSelectionState}
  TppSelectionState = class
  private
    FBandName: String;
    FComponentNames: TStrings;
    FOwner: TComponent;
    FReportName: String;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property BandName: String read FBandName write FBandName;
    property ComponentNames: TStrings read FComponentNames;
    property Owner: TComponent read FOwner write FOwner;
    property ReportName: String read FReportName write FReportName;

  end;

  {TppDesignSelection}
  TppDesignSelection = class(TppCommunicator)
  private
    FBand: TppBand;
    FDesignControlManager: TppDesignControlManager;
    FWorkspace: TWinControl;
    FUpdateCounter: Integer;
    FComponents: TList;
    FEventHub: TppDesignEventHub;
    FGroup: TppGroup;
    FParameter: TppParameter;
//    FParameters: TppParameterCollection;
    FReport: TppCustomReport;
    FSelectionBounds: TppBoundsRect;
    FSizingHandles: TppSizingHandles;
    FSelectionObjects: TppSelectionObjectCollection;
    FSelectionState: TppSelectionState;

    function GetComponents(Index: Integer): TppComponent;
    function GetDesignControls(Index: Integer): TppDesignControl;
    function GetSelectionObjects(Index: Integer): TppSelectionObject;
    procedure SetWorkspace(Value: TWinControl);
    procedure AddSelectionBounds(aSelectionObject: TppSelectionObject);
    procedure CalcSelectionBounds;
    procedure ehBand_Destroy(Sender, aParameters: TObject);
    procedure ehComponent_Destroy(Sender, aParameters: TObject);
    function GetCount: Integer;
    function GetIsUpdating: Boolean;
    procedure SetEventHub(aEventHub: TppDesignEventHub);
    procedure SetReport(const Value: TppCustomReport);
  protected
    procedure DoAfterAdd(aComponent: TppComponent);
    procedure DoAfterRemove(aComponent: TppComponent);
    procedure DoBeforeAdd(aComponent: TppComponent);
    procedure DoBeforeRemove(aComponent: TppComponent);
    procedure DoBeginUpdate;
    procedure DoEndUpdate;
    procedure ehComponent_AfterPropertyChange(Sender, aParameters: TObject); virtual;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    function Add(aComponent: TppComponent): TppSelectionObject;
    procedure BeginUpdate;
    procedure Clear;
    function Contains(aComponent: TppComponent): Boolean;
    procedure EndUpdate;
    function Equals(aDesignerSelection: TppDesignerSelectionList): Boolean; {$IFDEF Delphi12} reintroduce; {$ENDIF} overload;  
    function GetBoundsRect(aComponent: TppComponent): TppBoundsRect;
    function GetSelectedComponent: TComponent;
    procedure SaveState;
    function GetSelectionObject(aComponent: TppComponent): TppSelectionObject;
    function IndexOf(aComponent: TppComponent): Integer;
    procedure Remove(aComponent: TppComponent);
    procedure SelectReport(aReport: TppCustomReport);
    procedure SetSelectedComponent(aComponent: TComponent);
    procedure SetSelection(aComponent: TppComponent); overload;
    procedure SetSelection(aComponents: TppComponentCollection); overload;
    procedure SetSelection(aBand: TppBand); overload;
    procedure SetSelection(aDesignerSelection: TppDesignerSelectionList); overload;
    procedure SetSelection(aParameter: TppParameter); overload;
    procedure RestoreState;
    procedure SetSelection(aGroup: TppGroup); overload;
    procedure Show(aValue: Boolean);
    procedure ShowBoundsRects(aValue: Boolean);
    function ToDesignerSelection: TppDesignerSelectionList;

    property Band: TppBand read FBand;
    property Components[Index: Integer]: TppComponent read GetComponents; default;
    property Count: Integer read GetCount;
    property DesignControlManager: TppDesignControlManager read FDesignControlManager write FDesignControlManager;
    property DesignControls[Index: Integer]: TppDesignControl read GetDesignControls;
    property Group: TppGroup read FGroup;
    property Report: TppCustomReport read FReport write SetReport;
    property SelectionObjects[Index: Integer]: TppSelectionObject read GetSelectionObjects;
    property SizingHandles: TppSizingHandles read FSizingHandles;
    property SelectionBounds: TppBoundsRect read FSelectionBounds;
    property Workspace: TWinControl read FWorkspace write SetWorkspace;
    property IsUpdating: Boolean read GetIsUpdating;
//    property Parameters: TppParameterCollection read FParameters;

  published
  
  end;





implementation

uses
  ppReport;

constructor TppDesignSelection.Create(aOwner: TComponent);
begin
  inherited;

  FSelectionObjects := TppSelectionObjectCollection.Create;
  FComponents := TList.Create;

end;

destructor TppDesignSelection.Destroy;
begin

  FSelectionState.Free;
  FSelectionState := nil;
  
  FSelectionBounds.Free;
  FSelectionBounds := nil;

  FSelectionObjects.Free;
  FSelectionObjects := nil;

  FComponents.Free;
  FComponents := nil;
  
  inherited;

end;

procedure TppDesignSelection.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aCommunicator = FReport) and (aOperation = ppopRemove) then
    SetReport(nil)

  else if (aCommunicator = FEventHub) and (aOperation = ppopRemove) then
    SetEventHub(nil);

  inherited;

end;

function TppDesignSelection.Add(aComponent: TppComponent): TppSelectionObject;
var
  lSelectionObject: TppSelectionObject;
  lDesignControl: TppDesignControl;
begin

  if (FDesignControlManager = nil) then
    raise EDesignError.Create('TppDesignerSelection.Add: DesignControlManager is nil');

  if (FWorkspace = nil) then
    raise EDesignError.Create('TppDesignerSelection.Add: DesignControlManager is nil');

  Result := nil;
  
  if (aComponent.Report <> Report) then Exit;
  

  // notify observers
  DoBeforeAdd(aComponent);

  FComponents.Add(aComponent);

  lSelectionObject := TppSelectionObject.Create(nil);
  lSelectionObject.Parent := FWorkspace;

  lDesignControl := FDesignControlManager.DesignControls[aComponent];

  if (lDesignControl = nil)  then
    raise EDesignError.Create('TppDesignerWindow.AddSelection: DesignControl is nil');

  lSelectionObject.DesignControl := lDesignControl;

  FSelectionObjects.Add(lSelectionObject);

  // single & multi-selection modes
  if (Count = 1) then
    lSelectionObject.SizingHandles := FSizingHandles

  else if (Count = 2) then
    SelectionObjects[0].SizingHandles := nil;

  lSelectionObject.ShowSelection(True);

  // calc selection bounds
  if (Count = 1) then
    CalcSelectionBounds()
  else
    AddSelectionBounds(lSelectionObject);

  FDesignControlManager.SelectionObjects.Add(lSelectionObject);

  Result := lSelectionObject;

   // notify observers
  DoAfterAdd(aComponent);

end;

procedure TppDesignSelection.BeginUpdate;
begin

  Inc(FUpdateCounter);

  // notify observers
  if (FUpdateCounter = 1) then
    DoBeginUpdate();

end;

procedure TppDesignSelection.Clear;
begin

  BeginUpdate();

  try

    FGroup := nil;
    FBand := nil;
    FParameter := nil;

    if (FSizingHandles <> nil) then
      FSizingHandles.Hide;
    FSelectionObjects.ClearList;
    FComponents.Clear;
    if (FSelectionBounds <> nil) then
      FSelectionBounds.SetObjectBounds(0, 0, 0, 0);
    if (DesignControlManager <> nil) then
      DesignControlManager.SelectionObjects.Clear;


  finally
    EndUpdate();

  end;


end;

function TppDesignSelection.Contains(aComponent: TppComponent): Boolean;
begin
  Result := FComponents.IndexOf(aComponent) >= 0;

end;

procedure TppDesignSelection.EndUpdate;
begin

  if (FUpdateCounter > 0) then
    begin
      Dec(FUpdateCounter);

      // notify observers
      if (FUpdateCounter = 0) then
        begin
          CalcSelectionBounds();
          DoEndUpdate();
        end;

    end;

end;

function TppDesignSelection.GetComponents(Index: Integer): TppComponent;
begin
  Result := TppComponent(FComponents[Index]);

end;

function TppDesignSelection.GetDesignControls(Index: Integer): TppDesignControl;
begin
  Result :=  TppDesignControl(FSelectionObjects.ItemsByIndex[Index].DesignControl);
end;

function TppDesignSelection.GetSelectionObjects(Index: Integer): TppSelectionObject;
begin
  Result := FSelectionObjects.ItemsByIndex[Index];
end;

function TppDesignSelection.IndexOf(aComponent: TppComponent): Integer;
begin
  Result := FComponents.IndexOf(aComponent);

end;

procedure TppDesignSelection.Remove(aComponent: TppComponent);
var
  liIndex: Integer;
  lSelectionObject: TppSelectionObject;
begin

  if (FDesignControlManager = nil) then
    raise EDesignError.Create('TppDesignerSelection.Remove: DesignControlManager is nil');

  // notify observers
  DoBeforeRemove(aComponent);

  liIndex := FComponents.Remove(aComponent);

  FDesignControlManager.SelectionObjects.Remove(SelectionObjects[liIndex]);

  lSelectionObject := FSelectionObjects.ItemsByIndex[liIndex];
  FSelectionObjects.Delete(liIndex);
  lSelectionObject.Free;

  if (Count = 1) then
    SelectionObjects[0].SizingHandles := FSizingHandles;

  CalcSelectionBounds();

  // notify observers
  DoAfterRemove(aComponent);

end;

{------------------------------------------------------------------------------}
{ TppDesigner.AddSelectionBounds}

procedure TppDesignSelection.AddSelectionBounds(aSelectionObject: TppSelectionObject);
var
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
  liComponentTop: Integer;
  lComponent: TppComponent;

begin

  liLeft   := FSelectionBounds.ObjectLeft;
  liTop    := FSelectionBounds.ObjectTop;
  liRight  := FSelectionBounds.ObjectLeft + FSelectionBounds.ObjectWidth;
  liBottom := FSelectionBounds.ObjectTop  + FSelectionBounds.ObjectHeight;

  lComponent := aSelectionObject.Component;

  liComponentTop :=  lComponent.Band.mmTop + lComponent.mmTop;

  {compute bounds in native units}
  if liComponentTop < FSelectionBounds.ObjectTop then
    liTop := liComponentTop;

  if (lComponent.mmLeft < FSelectionBounds.ObjectLeft) then
    liLeft := lComponent.mmLeft;

  if (lComponent.mmLeft + lComponent.mmWidth) > (FSelectionBounds.ObjectLeft + FSelectionBounds.ObjectWidth) then
    liRight := (lComponent.mmLeft + lComponent.mmWidth);

  if (liComponentTop + lComponent.mmHeight) > (FSelectionBounds.ObjectTop + FSelectionBounds.ObjectHeight) then
    liBottom := (liComponentTop + lComponent.mmHeight);

  {set bounds }
  FSelectionBounds.SetObjectBounds(liLeft, liTop, liRight-liLeft, liBottom-liTop);

  {compute bounds locks }
  FSelectionBounds.BoundsLocks :=  FSelectionBounds.BoundsLocks + aSelectionObject.BoundsLocks;


end; {procedure, AddSelectionBounds}


procedure TppDesignSelection.CalcSelectionBounds;
var
  liIndex: Integer;
  lComponent: TppComponent;
  lSelectionObject: TppSelectionObject;
begin

  if (FSelectionBounds = nil) then Exit;

  if IsUpdating then Exit;

  FSelectionBounds.BoundsLocks := [];

  if (Count = 0) then Exit;

  lComponent := Components[0];
  lSelectionObject := SelectionObjects[0];

  {initialize selection bounds to the first object}
  FSelectionBounds.SetObjectBounds(lComponent.mmLeft, (lComponent.Band.mmTop + lComponent.mmTop), lComponent.mmWidth, lComponent.mmHeight);
  FSelectionBounds.BoundsLocks := FSelectionBounds.BoundsLocks + lSelectionObject.BoundsLocks;

   {incrementally compute the rest}
  for liIndex := 1 to (Count - 1) do
    AddSelectionBounds(SelectionObjects[liIndex]);

end;

procedure TppDesignSelection.DoAfterAdd(aComponent: TppComponent);
begin

  if IsUpdating then Exit;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcAfterAdd.Notify(Self, aComponent);
      FEventHub.SelectionEvents.mcAfterChange.Notify(Self, aComponent);
      if (Count = 1) then
        FEventHub.SelectionEvents.mcSelectComponent.Notify(Self, aComponent);
    end;

end;

procedure TppDesignSelection.DoAfterRemove(aComponent: TppComponent);
begin

  if IsUpdating then Exit;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcAfterRemove.Notify(Self, aComponent);
      FEventHub.SelectionEvents.mcAfterChange.Notify(Self, aComponent);
    end;

end;

procedure TppDesignSelection.DoBeforeAdd(aComponent: TppComponent);
begin

  if IsUpdating then Exit;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcBeforeAdd.Notify(Self, aComponent);
      FEventHub.SelectionEvents.mcBeforeChange.Notify(Self, aComponent);
    end;

end;

procedure TppDesignSelection.DoBeforeRemove(aComponent: TppComponent);
begin

  if IsUpdating then Exit;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcBeforeRemove.Notify(Self, aComponent);
      FEventHub.SelectionEvents.mcBeforeChange.Notify(Self, aComponent);
    end;

end;

procedure TppDesignSelection.DoBeginUpdate;
begin

  if IsUpdating then Exit;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcBeginUpdate.Notify(Self, nil);
      FEventHub.SelectionEvents.mcBeforeChange.Notify(Self, nil);
    end;

end;

procedure TppDesignSelection.DoEndUpdate;
begin

  if IsUpdating then Exit;

  if (FEventHub <> nil) then
    begin
      FEventHub.SelectionEvents.mcEndUpdate.Notify(Self, nil);
      FEventHub.SelectionEvents.mcAfterChange.Notify(Self, nil);
    end;

end;

procedure TppDesignSelection.ehBand_Destroy(Sender, aParameters: TObject);
begin
  if (FBand = aParameters) then
    begin
      SelectReport(FReport);

    end;
    
end;

procedure TppDesignSelection.ehComponent_Destroy(Sender, aParameters: TObject);
var
  lComponent: TppComponent;
begin
  if (aParameters is TppComponent) then
    begin
      lComponent := TppComponent(aParameters);

      if Contains(lComponent) then
        Remove(lComponent);

    end;
end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.ehComponent_PropertyChange}

procedure TppDesignSelection.ehComponent_AfterPropertyChange(Sender, aParameters: TObject);
begin
  if IsUpdating then Exit;
  CalcSelectionBounds();
end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.Equals}

function TppDesignSelection.Equals(aDesignerSelection: TppDesignerSelectionList): Boolean;
var
  liIndex :Integer;
begin

  Result := True;

  {compare length of ComponentList to length of Selection list}
  if aDesignerSelection.Count <> Count then
    Result := False;

  liIndex := 0;

  while(Result) and (liIndex < aDesignerSelection.Count) do
    if (aDesignerSelection[liIndex] <> Components[liIndex]) then
      Result := False
    else
      Inc(liIndex);

end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.GetBoundsRect}

function TppDesignSelection.GetBoundsRect(aComponent: TppComponent): TppBoundsRect;
var
  liIndex: Integer;
begin

  liIndex :=  IndexOf(aComponent);

  if (liIndex >= 0) then
    Result := SelectionObjects[liIndex].BoundsRect
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.GetCount}

function TppDesignSelection.GetCount: Integer;
begin
  Result := FSelectionObjects.Count;
end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.GetSelectedComponent }

function TppDesignSelection.GetSelectedComponent: TComponent;
begin

  if (Count > 0) then
    Result := Components[0]
  else if (FGroup <> nil) then
    Result := FGroup
  else if (FBand <> nil) then
    Result := FBand
  else if (FParameter <> nil) then
    Result := FParameter
  else
    Result := Report;

end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.GetSelectionObject }

function TppDesignSelection.GetSelectionObject(aComponent: TppComponent): TppSelectionObject;
var
  liIndex: Integer;
begin

  liIndex :=  IndexOf(aComponent);

  if (liIndex >= 0) then
    Result := SelectionObjects[liIndex]
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.GetUpdating }

function TppDesignSelection.GetIsUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.SaveState }

procedure TppDesignSelection.SaveState;
var
  lComponent: TComponent;
  liIndex: Integer;
begin

  if (Report = nil) then Exit;

  FSelectionState.Free;

  FSelectionState := TppSelectionState.Create;

  FSelectionState.Owner := Report.Owner;
  FSelectionState.ReportName := Report.Name;

  lComponent := GetSelectedComponent;

  if (lComponent is TppBand) then
    FSelectionState.BandName := lComponent.Name
  else
    FSelectionState.BandName := '';

  if (Count > 0) then
    for liIndex := 0 to Count-1 do
      FSelectionState.ComponentNames.Add(Components[liIndex].Name);

end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.SelectReport }

procedure TppDesignSelection.SelectReport(aReport: TppCustomReport);
begin

  // make sure we select a report/child in the same main report
  if (aReport <> nil) and (FReport <> nil) and (aReport.MainReport <> FReport.MainReport) then
    // do nothing
  else if (FReport <> aReport) then
    SetReport(aReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.SetEventHub }

procedure TppDesignSelection.SetEventHub(aEventHub: TppDesignEventHub);
begin

  if (FEventHub <> nil) then
    begin
      FEventHub.RemoveNotify(Self);
      FEventHub.ComponentEvents.mcDestroy.RemoveNotify(ehComponent_Destroy);
      FEventHub.BandEvents.mcDestroy.RemoveNotify(ehBand_Destroy);
      FEventHub.ComponentEvents.mcAfterPropertyChange.RemoveNotify(ehComponent_AfterPropertyChange);
//      FEventHub.WorkspaceEvents.mcMouseDown.RemoveNotify(ehWorkspace_MouseDown);
//      FEventHub.WorkspaceEvents.mcMouseMove.RemoveNotify(ehWorkspace_MouseMove);
//      FEventHub.WorkspaceEvents.mcMouseUp.RemoveNotify(ehWorkspace_MouseUp);
    end;

  FEventHub := aEventHub;

  if (FEventHub <> nil) then
    begin
      FEventHub.AddNotify(Self);
      FEventHub.ComponentEvents.mcDestroy.AddNotify(ehComponent_Destroy);
      FEventHub.BandEvents.mcDestroy.AddNotify(ehBand_Destroy);
      FEventHub.ComponentEvents.mcAfterPropertyChange.PrependNotify(ehComponent_AfterPropertyChange);
//      FEventHub.WorkspaceEvents.mcMouseDown.AddNotify(ehWorkspace_MouseDown);
//      FEventHub.WorkspaceEvents.mcMouseMove.AddNotify(ehWorkspace_MouseMove);
//      FEventHub.WorkspaceEvents.mcMouseUp.AddNotify(ehWorkspace_MouseUp);
    end;


end;

{------------------------------------------------------------------------------}
{ TppDesignSelection.SetReport }

procedure TppDesignSelection.SetReport(const Value: TppCustomReport);
begin

  if FReport <> Value then
    begin

      Clear();
      
      if (FReport <> nil) then
        FReport.RemoveNotify(Self);

      FReport := Value;

      if (FReport <> nil) then
        FReport.AddNotify(Self);

      // assign event hub
      if (FReport <> nil) and (FReport.MainReport <> nil) and (FReport.MainReport.DesignEventHub <> nil) then
        SetEventHub(TppDesignEventHub(FReport.MainReport.DesignEventHub));

      // broadcast to observers
      if (FEventHub <> nil) and (FEventHub.SelectionEvents <> nil) then
        FEventHub.SelectionEvents.mcSelectReport.Notify(Self, FReport);

      if (FEventHub <> nil) then
        FEventHub.EndUserEvents.mcReportSelected.Notify(Self, FReport);

      if (FReport = nil) or (FReport.MainReport = nil) or (FReport.MainReport.DesignEventHub = nil) then
        SetEventHub(nil);


    end;

end;

procedure TppDesignSelection.SetSelectedComponent(aComponent: TComponent);
begin

  if (aComponent is TppComponent) then
    SetSelection(TppComponent(aComponent))
  else if (aComponent is TppGroup) then
    SetSelection(TppGroup(aComponent))
  else if (aComponent is TppBand) then
    SetSelection(TppBand(aComponent))
  else if (aComponent is TppParameter) then
    SetSelection(TppParameter(aComponent))
  else if (aComponent is TppCustomReport) then
    SelectReport(TppCustomReport(aComponent));

end;


procedure TppDesignSelection.Show(aValue: Boolean);
var
  liIndex: Integer;
begin
  for liIndex := 0 to Count-1 do
    SelectionObjects[liIndex].ShowSelection(aValue);

end;


procedure TppDesignSelection.ShowBoundsRects(aValue: Boolean);
var
  liIndex: Integer;
begin
  for liIndex := 0 to Count-1 do
    SelectionObjects[liIndex].ShowBoundsRect(aValue);

end;


procedure TppDesignSelection.SetSelection(aComponent: TppComponent);
begin

  if (Count = 1) and (aComponent = Components[0]) then Exit;

  if (aComponent.Report <> Report) then Exit;
  
  BeginUpdate;

  try
    Clear;

    Add(aComponent);
    
  finally
    EndUpdate;
  end;

end;

procedure TppDesignSelection.SetSelection(aComponents: TppComponentCollection);
var
  liIndex: Integer;
begin

  BeginUpdate;

  try
    Clear;

    for liIndex := 0 to aComponents.Count-1 do
      Add(aComponents[liIndex]);

  finally
    EndUpdate;
  end;

end;

procedure TppDesignSelection.SetSelection(aBand: TppBand);
begin

  // check whether band is in the selected report
  if (aBand.Report <> Report) then Exit;

  BeginUpdate;

  try
    Clear();
    FBand := aBand;

    // broadcast to observers
    if (FEventHub <> nil) and (FEventHub.SelectionEvents <> nil) then
      FEventHub.SelectionEvents.mcSelectBand.Notify(Self, aBand);

  finally
    EndUpdate;
  end;

end;

procedure TppDesignSelection.SetSelection(aParameter: TppParameter);
begin

  // check whether parameter is in the selected report
  if not(Report is TppReport) or (aParameter.Parent <> TppReport(Report).Parameters) then Exit;

  BeginUpdate;

  try
    Clear();
    FParameter := aParameter;

    // broadcast to observers
//    if (FEventHub <> nil) and (FEventHub.SelectionEvents <> nil) then
//      FEventHub.SelectionEvents.mcSelectBand.Notify(Self, aBand);

  finally
    EndUpdate;
  end;

end;


procedure TppDesignSelection.SetSelection(aDesignerSelection: TppDesignerSelectionList);
var
  liIndex: Integer;
  lComponent: TppComponent;
  lFirstComponent: TComponent;
begin

  if (Report = nil) then Exit;
  
  if IsUpdating then Exit;

  if Equals(aDesignerSelection) then Exit;

  BeginUpdate;

  try
    Clear;

    lFirstComponent := nil;

    for liIndex := 0 to aDesignerSelection.Count-1 do
      if (aDesignerSelection[liIndex] is TppComponent) then
        begin
          lComponent := TppComponent(aDesignerSelection[liIndex]);

          {make sure TppComponent is in this report!}
          if (lComponent.Band <> nil) and (lComponent.Band.Report = Report) then
            Add(lComponent)
        end
      else if (aDesignerSelection[liIndex] is TComponent) and (lFirstComponent = nil) then
        lFirstComponent := TComponent(aDesignerSelection[liIndex]);

    if (FComponents.Count = 0) and (lFirstComponent <> nil) then
      SetSelectedComponent(lFirstComponent);

  finally
    EndUpdate;
  end;

end;

procedure TppDesignSelection.RestoreState;
var
  liIndex: Integer;
  lOwner: TComponent;
  lComponent: TComponent;
  lReport: TComponent;
  lBand: TComponent;
begin

  if (FSelectionState = nil) or (FSelectionState.Owner = nil) then Exit;


  lOwner := FSelectionState.Owner;

  lReport := lOwner.FindComponent(FSelectionState.ReportName);

  if (lReport is TppCustomReport) then
    SelectReport(TppCustomReport(lReport));

  if (FSelectionState.BandName <> '') then
    begin
      lBand := lOwner.FindComponent(FSelectionState.BandName);

      if (lBand is TppBand) then
        SetSelection(TppBand(lBand));

    end;

  if (FSelectionState.ComponentNames.Count > 0) then
    try

      BeginUpdate();

      Clear();
      for liIndex := 0 to FSelectionState.ComponentNames.Count - 1 do
        begin
          lComponent := lOwner.FindComponent(FSelectionState.ComponentNames[liIndex]);

          if (lComponent is TppComponent) then
            Add(TppComponent(lComponent));

        end;


    finally
      EndUpdate();
    end;


end;

procedure TppDesignSelection.SetSelection(aGroup: TppGroup);
begin

  // check whether parameter is in the selected report
  if not(Report is TppReport) or (aGroup.Report <> TppReport(Report)) then Exit;

  BeginUpdate;

  try
    Clear();
    FGroup := aGroup;

    // broadcast to observers
//    if (FEventHub <> nil) and (FEventHub.SelectionEvents <> nil) then
//      FEventHub.SelectionEvents.mcSelectBand.Notify(Self, aBand);

  finally
    EndUpdate;
  end;

end;


procedure TppDesignSelection.SetWorkspace(Value: TWinControl);
begin

  Clear();
  FSizingHandles.Free;
  FSizingHandles := nil;
  FSelectionBounds.Free;
  FSelectionBounds := nil;

  FWorkspace := Value;

  if (FWorkspace <> nil) then
    begin
      FSizingHandles := TppSizingHandles.Create(FWorkspace.Owner);
      FSizingHandles.Parent := FWorkspace;
      FSelectionBounds := TppBoundsRect.Create(FWorkspace.Owner);
      FSelectionBounds.Parent := FWorkspace;
    end;

end;

function TppDesignSelection.ToDesignerSelection: TppDesignerSelectionList;
var
  liIndex : Integer;
begin

  Result := TppDesignerSelectionList.Create;

  {build component list}
  if (Count <= 1) then
    Result.Add(GetSelectedComponent)

  else if (Count > 1) then

    for liIndex := 0 to Count-1 do
      Result.Add(Components[liIndex]);


end;


{ TppComponentCollection }

procedure TppComponentCollection.Add(aObject: TppComponent);
begin
  InnerList.Add(aObject);
end;

function TppComponentCollection.GetItemForIndex(aIndex: Integer): TppComponent;
begin
  Result := TppComponent(InnerList[aIndex]);

end;

function TppComponentCollection.IndexOf(aObject: TppComponent): Integer;
begin
  Result := InnerList.IndexOf(aObject);
end;

procedure TppComponentCollection.Remove(aObject: TppComponent);
begin
  InnerList.Remove(aObject);
end;

constructor TppSelectionState.Create;
begin
  inherited;

  FComponentNames := TStringList.Create;

end;

destructor TppSelectionState.Destroy;
begin
  FComponentNames.Free;
  FComponentNames := nil;
  inherited;
end;







end.
