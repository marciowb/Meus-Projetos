{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppParametersEd;

interface

{$I ppIfDef.pas}

uses
  Windows,
  SysUtils,
  Classes,
  StdCtrls,
  Controls,
  ExtCtrls,
  Forms,
  Dialogs,
  Buttons,
  Typinfo,

  ppRTTI,
  ppDsIntf,
  ppComm,
  ppTypes,
  ppUtils,
  ppParameter,
  ppInspector,
  ppDesignSelectionController,
  ppJvInspector,
  ppForms,
  ppDesignerForms;

type

  {@TppParameterEditor }
  TppParameterEditor = class(TppComponentDesigner)
    pnlListBox: TPanel;
    lbxParameter: TListBox;
    pnlButtons: TPanel;
    btnAdd: TButton;
    btnDelete: TButton;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbxParameterClick(Sender: TObject);
    procedure lbxParameterDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbxParameterEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure lbxParameterMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);

    private
      FChangingSelection: Boolean;
      FDragging: Boolean;
      FStartDragIndex: Integer;
      FParameterList: TppParameterList;
      FCreatingForm: Boolean;
      FInspector: TppJvCustomInspector;
      FObserver: TppCommunicator;
      FSelectionController: TppDesignSelectionController;
      procedure AddItem;
      procedure ClearSelection;
      procedure DeleteItems;
      procedure ParametersToListBox;
      function  FindIndexForParameter(aParameter: TppParameter): Integer;
      procedure MoveSelectedItems(aDirection: Integer);
      procedure SetObjectInspectorToSelection(aSelectParameters: Boolean);

      function CheckParameterAdd: Boolean;
      function CheckParameterDelete: Boolean;
      procedure ParameterNameChanged(aParameter: TppParameter);
      procedure ParameterDeleted(aParameter: TppParameter);

    protected
      procedure Initialize;
      procedure SetComponent(aComponent: TComponent); override;
      procedure ParameterEventNotificationHandler(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
      procedure ParameterNotificationHandler(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
      procedure SelectReport;

    public
      {called by TppDesignWindow}
      procedure ComponentChanged; override;
      property Inspector: TppJvCustomInspector read FInspector write FInspector;
      procedure SelectionChanged(aSelection: TppDesignerSelectionList); override;
      property SelectionController: TppDesignSelectionController read FSelectionController write FSelectionController;

  end; {class, TppParameterEditor}

var
  ppParameterEditor: TppParameterEditor;

implementation

uses
  ppReport;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppParameterEditor.FormCreate }

procedure TppParameterEditor.FormCreate(Sender: TObject);
var
  lPropertCategory: TppPropertyCategory;
  liIndex: Integer;
begin

  FChangingSelection := False;
  FParameterList := nil;
  FDragging := False;
  FStartDragIndex := 0;
  FCreatingForm := True;

  FObserver := TppCommunicator.Create(nil);
  FObserver.EventNotifies := [ciNameChanged];
  FObserver.OnEventNotify := ParameterEventNotificationHandler;
  FObserver.OnNotify := ParameterNotificationHandler;

  if not(ppUtils.gbDesignTime) then
    begin
      lPropertCategory := TppPropertyCategoryManager.PropertyCategories.ItemByName['Ignore'];

      liIndex := lPropertCategory.PropertyNames.IndexOf('Name');

      if (liIndex >= 0) then
        TppPropertyCategoryManager.PropertyCategories.ItemByName['Ignore'].PropertyNames.Delete(liIndex);
    end;


end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppParameterEditor.FormDestroy }

procedure TppParameterEditor.FormDestroy(Sender: TObject);
var
  lPropertCategory: TppPropertyCategory;
  liIndex: Integer;
begin

  if not(ppUtils.gbDesignTime) then
    begin
      lPropertCategory := TppPropertyCategoryManager.PropertyCategories.ItemByName['Ignore'];

      liIndex := lPropertCategory.PropertyNames.IndexOf('Name');

      if (liIndex < 0) then
        TppPropertyCategoryManager.PropertyCategories.ItemByName['Ignore'].PropertyNames.Add('Name');
    end;


  FObserver.Free;
  FObserver := nil;

end;

{------------------------------------------------------------------------------}
{ TppParameterEditor.FormClose }

procedure TppParameterEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  SelectReport();

  if (Inspector <> nil) then
    Action := caFree;

end;


{------------------------------------------------------------------------------}
{ TppParameterEditor.ParameterNotificationHandler }

procedure TppParameterEditor.ParameterNotificationHandler(Sender: TObject; aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  lParameter: TppParameter;
begin

  if (aCommunicator is TppParameter) and (aOperation = ppOpRemove) then
    begin
      lParameter := TppParameter(aCommunicator);

      ParameterDeleted(lParameter);

    end;

end;

{------------------------------------------------------------------------------}
{TppParameterEditor.ParameterEventNotificationHandler}

procedure TppParameterEditor.ParameterEventNotificationHandler(Sender: TObject; aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lParameter: TppParameter;
begin

  if (aCommunicator is TppParameter) then
    begin
      lParameter := TppParameter(aCommunicator);

      if (aEventID = ciNameChanged) then
        ParameterNameChanged(lParameter);
    end;

end;

{------------------------------------------------------------------------------}
{TppParameterEditor.ParameterDeleted}

procedure TppParameterEditor.ParameterDeleted(aParameter: TppParameter);
var
  liIndex: Integer;
begin

  liIndex := FindIndexForParameter(aParameter);

  if (liIndex >= 0) then
    lbxParameter.Items.Delete(liIndex);

end;
{------------------------------------------------------------------------------}
{ TppParameterEditor.ParameterNameChanged }

procedure TppParameterEditor.ParameterNameChanged(aParameter: TppParameter);
var
  liIndex: Integer;
begin

  liIndex := FindIndexForParameter(aParameter);

  if (liIndex >= 0) then
    lbxParameter.Items[liIndex] := aParameter.Name;
    
end;

{------------------------------------------------------------------------------}
{ TppParameterEditor.FormActivate }

procedure TppParameterEditor.FormActivate(Sender: TObject);
begin

  Initialize();

end;  {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TppParameterEditor.SetComponent }

procedure TppParameterEditor.SetComponent(aComponent: TComponent);
begin

  inherited SetComponent(aComponent);

  if (aComponent = nil) then
    raise EDesignError.Create('TppParametersProperty.Edit: Component is nil');

  if not(aComponent is TppParameterList) then
    raise EDesignError.CreateFmt('TppParameterEditor.SetComponent: %s is not of type TppParameterList', [aComponent.ClassName]);

  FParameterList := TppParameterList(aComponent);

  Height := 250;

  Initialize();

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TppParameterEditor.ParametersToListBox }

procedure TppParameterEditor.ParametersToListBox;
var
  liIndex: Integer;
  lParameter: TppParameter;
begin
  lbxParameter.Items.Clear;
  
  for liIndex := 0 to FParameterList.Count - 1 do
    begin
      lParameter := FParameterList.ItemsByIndex[liIndex];
      lParameter.AddEventNotify(FObserver);

      lbxParameter.Items.AddObject(lParameter.Name, lParameter);
    end;

  if (lbxParameter.Items.Count > 0) then
    lbxParameter.ItemIndex := 0;

end; {procedure, ParametersListBox}

{------------------------------------------------------------------------------}
{ TppParameterEditor.lbxParameterClick }

procedure TppParameterEditor.lbxParameterClick(Sender: TObject);
begin

  SetObjectInspectorToSelection(True);

end; {procedure, lbxParameterClick}


{------------------------------------------------------------------------------}
{ TppParameterEditor.CheckParameterAdd }

function TppParameterEditor.CheckParameterAdd: Boolean;
var
  lsMsg: String;
begin

  Result := False;

  if (FParameterList = nil) or (FParameterList.Owner = nil) then Exit;

  {check whether this component resides in a nested frame}
  Result := not (csInline in FParameterList.Owner.ComponentState);

  if not Result then
    begin
      lsMsg := 'New components cannot be added to frame instances';
      MessageDlg(lsMsg, mtWarning, [mbOK], 0);

    end;

end; {function, CheckParameterAdd}


{------------------------------------------------------------------------------}
{ TppParameterEditor.CheckParameterDelete }

function TppParameterEditor.CheckParameterDelete: Boolean;
var
  liIndex: Integer;
  lParameter: TppParameter;
  lsMsg: String;
begin

  liIndex := 0;
  Result  := True;

  while Result and (liIndex < lbxParameter.Items.Count) do
    begin

      lParameter := TppParameter(lbxParameter.Items.Objects[liIndex]);

      {check whether this component resides in an ancestor}
      Result := not (csAncestor in lParameter.ComponentState);

      Inc(liIndex);

    end;

  if not Result then
    begin
      lsMsg := 'Selection contains a component introduced in an ancestor and cannot be deleted.';
      MessageDlg(lsMsg, mtWarning, [mbOK], 0);

    end;

end; {function, CheckParameterDelete}

{------------------------------------------------------------------------------}
{ TppParameterEditor.btnAddClick }

procedure TppParameterEditor.btnAddClick(Sender: TObject);
begin

  if not CheckParameterAdd then Exit;

  AddItem;

  SetObjectInspectorToSelection(True);
end; {procedure, btnAddClick}

{------------------------------------------------------------------------------}
{ TppParameterEditor.btnDeleteClick }

procedure TppParameterEditor.btnDeleteClick(Sender: TObject);
var
  lbItemSelected: Boolean;
begin

  if not CheckParameterDelete then Exit;

  DeleteItems;

  lbItemSelected := (lbxParameter.ItemIndex >= 0) and (lbxParameter.Items.Count > 0);

  SetObjectInspectorToSelection(lbItemSelected)

end; {procedure, btnDeleteClick}

{------------------------------------------------------------------------------}
{ TppParameterEditor.btnMoveUpClick }

procedure TppParameterEditor.btnMoveUpClick(Sender: TObject);
begin
  MoveSelectedItems(-1);

  SetObjectInspectorToSelection(True);

end;

{------------------------------------------------------------------------------}
{ TppParameterEditor.btnMoveDownClick }

procedure TppParameterEditor.btnMoveDownClick(Sender: TObject);
begin
  MoveSelectedItems(1);

  SetObjectInspectorToSelection(True);
end;

{------------------------------------------------------------------------------}
{ TppParameterEditor.AddItem }

procedure TppParameterEditor.AddItem;
var
  lParameter: TppParameter;
begin

  lParameter := TppParameter.Create(FParameterList.Owner);
  lParameter.Name := lParameter.GetValidName(lParameter);
  lParameter.Parent := FParameterList;
  lParameter.AddEventNotify(FObserver);

  lbxParameter.Items.AddObject(lParameter.Name, lParameter);

  ClearSelection;

  if not(lbxParameter.Enabled) then
    lbxParameter.Enabled := True;

  lbxParameter.SetFocus;
  lbxParameter.Selected[lbxParameter.Items.Count - 1] := True;

end; {procedure, AddItem}

{------------------------------------------------------------------------------}
{ TppParameterEditor.ClearSelection }

procedure TppParameterEditor.ClearSelection;
var
  liIndex: Integer;
begin
  for liIndex := 0 to lbxParameter.Items.Count - 1 do
    lbxParameter.Selected[liIndex] := False;
end; {procedure, ClearSelection}

{------------------------------------------------------------------------------}
{ TppParameterEditor.MoveSelectedItems }

procedure TppParameterEditor.MoveSelectedItems(aDirection: Integer);
var
  liIndex: Integer;
  lSelected: TList;
  liFocus: Integer;
  liEnd: Integer;
  liIncrement: Integer;
  liNewIndex: Integer;
begin

  if (lbxParameter.Items.Count = 0) then Exit;

  lbxParameter.SetFocus;

  if (lbxParameter.Selected[0] = True) and (aDirection = -1) then Exit;

  if (lbxParameter.Selected[lbxParameter.Items.Count - 1] = True) and (aDirection = 1) then Exit;

  lSelected := TList.Create;
  liFocus := lbxParameter.ItemIndex + aDirection;

  if aDirection = 1 then
    begin
      liIndex := lbxParameter.Items.Count - 1;
      liIncrement := -1;
      liEnd := -1;
    end
  else
    begin
       liIndex := 0;
       liIncrement := 1;
       liEnd := lbxParameter.Items.Count;
    end;

  while liIndex <> liEnd do
    begin
      if (lbxParameter.Selected[liIndex] = True) then
        begin
          lbxParameter.Items.Move(liIndex, liIndex + aDirection);

          lSelected.Add(TObject(liIndex + aDirection));
        end;

      liIndex := liIndex + liIncrement;
    end;

  if (lSelected.Count > 0) then
    begin
      ClearSelection;

      for liIndex := 0 to lSelected.Count - 1 do
        begin
          liNewIndex := Integer(lSelected[liIndex]);

          TppParameter(lbxParameter.Items.Objects[liNewIndex]).Position := liNewIndex;

          lbxParameter.Selected[liNewIndex] := True;
        end;

      lbxParameter.Selected[liFocus] := True;
    end;

  lSelected.Free;

end; {procedure, MoveSelectedItems}

{------------------------------------------------------------------------------}
{ TppParameterEditor.DeleteItems }

procedure TppParameterEditor.DeleteItems;
var
  liIndex: Integer;
  lParameter: TppParameter;
  liFirstSelected: Integer;
begin

  if (lbxParameter.Items.Count = 0) then Exit;

  liFirstSelected := -1;
  liIndex := 0;

  while liIndex < lbxParameter.Items.Count do
    begin

      if (lbxParameter.Selected[liIndex]) then
        begin
          liFirstSelected := liIndex;

          lParameter := TppParameter(lbxParameter.Items.Objects[liIndex]);
          lParameter.RemoveEventNotify(FObserver);
          lParameter.Free;

          lbxParameter.Items.Delete(liIndex);
        end
      else
        Inc(liIndex);

    end;

  if (lbxParameter.Enabled) and (lbxParameter.Items.Count = 0) then
    lbxParameter.Enabled := False
  else
    begin

      if (liFirstSelected >= lbxParameter.Items.Count) then
          liFirstSelected := lbxParameter.Items.Count - 1;

      if (liFirstSelected <> -1) then
        if (lbxParameter.MultiSelect) then
          lbxParameter.Selected[liFirstSelected] := True
        else
          lbxParameter.ItemIndex := liFirstSelected;

      if (liFirstSelected <> -1) then
        lbxParameter.SetFocus;
        
    end;

end; {procedure, DeleteItems}

{------------------------------------------------------------------------------}
{ TppParameterEditor.ComponentChanged }

procedure TppParameterEditor.ComponentChanged;
var
  liIndex: Integer;
  lParameter: TppParameter;
  lSelected: TList;
  lFocusParameter: TppParameter;
begin

  lSelected := TList.Create;

  if (lbxParameter.Items.Count > 0) then
    lFocusParameter := TppParameter(lbxParameter.Items.Objects[lbxParameter.ItemIndex])
  else
    lFocusParameter := nil;

  for liIndex := 0 to lbxParameter.Items.Count - 1 do
    begin
      if (lbxParameter.Selected[liIndex]) then
        begin
          lParameter := TppParameter(lbxParameter.Items.Objects[liIndex]);

          lbxParameter.Items[liIndex] := lParameter.Name;

          lSelected.Add(lParameter);
        end;
    end;

  if (lSelected.Count > 0) then
    begin
      lbxParameter.Items.Clear;

      ParametersToListBox;

      for liIndex := 0 to lSelected.Count - 1 do
        begin
          lParameter := TppParameter(lSelected[liIndex]);
          
          lbxParameter.Selected[FParameterList.IndexOfChild(lParameter)] := True;
        end;

      lbxParameter.Selected[FParameterList.IndexOfChild(lFocusParameter)] := True;
    end;

  lSelected.Free;

  ComponentModified;

end; {procedure, ComponentChanged}

{------------------------------------------------------------------------------}
{ TppParameterEditor.SelectionChanged }


procedure TppParameterEditor.SelectionChanged(aSelection: TppDesignerSelectionList);
var
  liSelection : Integer;
  lParameter: TppParameter;
  liParameterIndex: Integer;
  lbParametersSelected: Boolean;
begin

  if (Component = nil) then Exit;

  if (csDestroying in Component.ComponentState) then Exit;

  if (csReading in Component.ComponentState) or (csLoading in Component.ComponentState) then Exit;

  if not(Self.Visible) then Exit;

  FChangingSelection := True;

  lbParametersSelected := False;

  ClearSelection;

  {filter the selection}
  for liSelection := 0 to aSelection.Count - 1 do

    if (aSelection[liSelection] is TppParameter) then
      begin
        lParameter := TppParameter(aSelection[liSelection]);

        {make sure Parameter belongs to this parameter list}
        if (lParameter.Parent = FParameterList) then
          begin
            liParameterIndex := FindIndexForParameter(lParameter);

            if (liParameterIndex <> -1) then
              begin
                lbxParameter.Selected[liParameterIndex] := True;
                lbParametersSelected := True;
              end;
          end;

      end;

  if not(lbParametersSelected) then
    lbxParameter.ItemIndex := -1;

  FChangingSelection := False;

end; {procedure, SelectionChanged}

{------------------------------------------------------------------------------}
{ TppParameterEditor.SetObjectInspectorToSelection }

procedure TppParameterEditor.SetObjectInspectorToSelection(aSelectParameters: Boolean);
var
  lComponentList: TppDesignerSelectionList;
  lParameter: TppParameter;
  liIndex: Integer;
begin

  if (Component = nil) then Exit;

//  if not(csDesigning in Component.ComponentState) then Exit;

  if (csDestroying in Component.ComponentState) then Exit;

  {note: if FChangingSelection then no need to notify Object Inspector,
         because the Object Inspector initiated the change (prevents a stack fault)}
  if (FChangingSelection) then Exit;


  lComponentList := TppDesignerSelectionList.Create;

  {build component list}
  if aSelectParameters then
    begin
      for liIndex := 0 to lbxParameter.Items.Count - 1 do
        if lbxParameter.Selected[liIndex] then
          begin
            lParameter := TppParameter(lbxParameter.Items.Objects[liIndex]);

            lComponentList.Add(lParameter);
          end;
    end
  else
    begin
      lbxParameter.ItemIndex := -1;
      lbxParameter.Refresh;

      if (lbxParameter.Items.Count = 0) then
        lComponentList.Add(FParameterList.Parent);  // Report
    end;

  {call TDesignWindow.SetSelection method to notify Object Inspector}
  if (lComponentList.Count = 0) then
    lComponentList.Free
  else
    DoOnSetSelection(lComponentList);

  if (Inspector <> nil) and (lComponentList.Count > 0) then
    begin
      if (SelectionController <> nil) then
        SelectionController.Selection.SetSelectedComponent(TComponent(lComponentList[0]));
  //    TppInspector(Inspector).SelectObject(TComponent(lComponentList[0]));
    end;


end; {procedure, SetObjectInspectorToSelection}

{------------------------------------------------------------------------------}
{ TppParameterEditor.FindIndexForParameter }

function TppParameterEditor.FindIndexForParameter(aParameter: TppParameter): Integer;
begin

  Result := lbxParameter.Items.IndexOfObject(aParameter);

end; {function, FindIndexForParameter}

procedure TppParameterEditor.Initialize;
begin

  if FCreatingForm then
    begin
      FCreatingForm := False;

      ParametersToListBox;

      SetObjectInspectorToSelection(True);

      if not(lbxParameter.Enabled) and (FParameterList <> nil) and (FParameterList.Count > 0) then
        begin
          lbxParameter.Enabled := True;
          lbxParameter.Selected[0] := True;

        end;

    end;
    
end;


{------------------------------------------------------------------------------}
{ TppParameterEditor.lbxParametersSelectedMouseDown }

procedure TppParameterEditor.lbxParameterMouseDown(Sender: TObject; Button: TMouseButton;
                                                  Shift: TShiftState; X, Y: Integer);
var
  lPoint   : TPoint;
  liIndex  : Integer;
  lbExists : Boolean;

begin
  if ([ssShift, ssCtrl] * Shift <> []) then Exit;

  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;

  liIndex  := lbxParameter.ItemAtPos(lPoint, lbExists);

  {start dragging}
  if (liIndex <> -1) then
    begin
      FStartDragIndex := liIndex;

      lbxParameter.BeginDrag(False);
    end;

end; {procedure, lbxParameterMouseDown}

{------------------------------------------------------------------------------}
{ TppParameterEditor.lbxParametersSelectedDragOver }

procedure TppParameterEditor.lbxParameterDragOver(Sender, Source: TObject; X, Y: Integer;
                                                   State: TDragState; var Accept: Boolean);
var
  lPoint     : TPoint;
  liIndex    : Integer;
  lbSelected : Boolean;
  lbExists   : Boolean;

begin
  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;

  FDragging := True;

  liIndex := lbxParameter.ItemAtPos(lPoint, lbExists);

  {determine which cursor to show}
  if (liIndex <> -1) then
    begin
      lbSelected := lbxParameter.Selected[liIndex];

      if not(lbSelected) then
        Accept := True
      else
        Accept := False;
    end
  else
    Accept := False;

end; {procedure, lbxParametersSelectedDragOver}

{------------------------------------------------------------------------------}
{ TppParameterEditor.lbxParametersSelectedEndDrag }

procedure TppParameterEditor.lbxParameterEndDrag(Sender, Target: TObject; X, Y: Integer);
var
  lPoint : TPoint;
  lbExists : Boolean;
  liIndex : Integer;
begin

  if not(FDragging) then Exit;

  FDragging := False;

  if not(Target = lbxParameter) then Exit;

  {move selection to new position}
  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;

  liIndex := lbxParameter.ItemAtPos(lPoint, lbExists);

  if (liIndex <> FStartDragIndex) then
    begin
      MoveSelectedItems(liIndex - FStartDragIndex);

      SetObjectInspectorToSelection(True);
    end;

end;  {procedure, lbxParametersSelectedEndDrag}

procedure TppParameterEditor.SelectReport;
begin

  if (SelectionController <> nil) then
    SelectionController.Selection.Clear;

end;






end.
