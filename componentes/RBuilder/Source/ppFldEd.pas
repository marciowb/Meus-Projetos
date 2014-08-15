{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppFldEd;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  ppForms, ppDB, ppDsIntf, Grids, ppTypes, ppTxPipe, ExtCtrls;

type

  {@TppFieldEditor }
  TppFieldEditor = class(TppComponentDesigner)
    pnlListBox: TPanel;
    lbxField: TListBox;
    pnlButtons: TPanel;
    btnSelectPipeline: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    spbViewData: TSpeedButton;
    pnlFileGrid: TPanel;
    Panel2: TPanel;
    lblFile: TLabel;
    Panel3: TPanel;
    sgdFile: TStringGrid;

    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbxFieldClick(Sender: TObject);
    procedure lbxFieldDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbxFieldEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure lbxFieldMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure spbViewDataClick(Sender: TObject);
    procedure btnSelectPipelineClick(Sender: TObject);

    private
      FChangingSelection: Boolean;
      FDragging: Boolean;
      FUseFileControls: Boolean;
      FStartDragIndex: Integer;
      FDataPipeline: TppCustomDataPipeline;
      FCreatingForm: Boolean;

      procedure AddItem;
      procedure ClearSelection;
      procedure DeleteItems;
      procedure FieldsToListBox;
      function  FindIndexForField(aField: TppField): Integer;
      procedure LoadFileData;
      procedure MoveSelectedItems(aDirection: Integer);
      procedure SetObjectInspectorToSelection(aSelectFields: Boolean);
      procedure ShowFileControls;
      procedure UpdateFileControls;

      function CheckFieldAdd: Boolean;
      function CheckFieldDelete: Boolean;

    protected
      procedure SetComponent(aComponent: TComponent); override;

    public
      {called by TppDesignWindow}
      procedure ComponentChanged; override;
      procedure SelectionChanged(aSelection: TppDesignerSelectionList); override;

      property UseFileControls: Boolean read FUseFileControls write FUseFileControls;

  end; {class, TppFieldEditor}

var
  ppFieldEditor: TppFieldEditor;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppFieldEditor.FormCreate }

procedure TppFieldEditor.FormCreate(Sender: TObject);
begin
  FChangingSelection := False;
  FDataPipeline := nil;
  FDragging := False;
  FStartDragIndex := 0;
  FUseFileControls := False;
  FCreatingForm := True;

  sgdFile.RowCount := 0;
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppFieldEditor.FormActivate }

procedure TppFieldEditor.FormActivate(Sender: TObject);
begin

  if FCreatingForm then
    begin

      UpdateFileControls;

      FieldsToListBox;

      if not(lbxField.Enabled) and (FDataPipeline <> nil) and (FDataPipeline.FieldCount > 0) then
        begin
          lbxField.Enabled := True;
          lbxField.Selected[0] := True;

          SetObjectInspectorToSelection(True);
        end;

      FCreatingForm := False;

    end;

end;  {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TppFieldEditor.SetComponent }

procedure TppFieldEditor.SetComponent(aComponent: TComponent);
begin
  inherited SetComponent(aComponent);

  if not(aComponent is TppCustomDataPipeline) then Exit;

  FDataPipeline := TppCustomDataPipeline(aComponent);

  if (FDataPipeline <> nil) and (FDataPipeline is TppTextPipeline) then
    FUseFileControls := True;

end; {procedure, SetComponent}

{------------------------------------------------------------------------------}
{ TppFieldEditor.spbSelectPipelineClick }

procedure TppFieldEditor.btnSelectPipelineClick(Sender: TObject);
begin
  ClearSelection;
  
  SetObjectInspectorToSelection(False);
end; {procedure, spbSelectPipelineClick}

{------------------------------------------------------------------------------}
{ TppFieldEditor.FieldsToListBox }

procedure TppFieldEditor.FieldsToListBox;
var
  liIndex: Integer;
  lField: TppField;
begin
  lbxField.Items.Clear;
  
  for liIndex := 0 to FDataPipeline.FieldCount - 1 do
    begin
      lField := FDataPipeline.Fields[liIndex];

      lbxField.Items.AddObject(lField.FieldName, lField);
    end;

end; {procedure, FieldsListBox}

{------------------------------------------------------------------------------}
{ TppFieldEditor.lbxFieldClick }

procedure TppFieldEditor.lbxFieldClick(Sender: TObject);
begin
  SetObjectInspectorToSelection(True);
end; {procedure, lbxFieldClick}


{$IFDEF Delphi5}

{------------------------------------------------------------------------------}
{ TppFieldEditor.CheckFieldAdd }

function TppFieldEditor.CheckFieldAdd: Boolean;
var
  lsMsg: String;

begin

  Result := False;

  if (FDataPipeline = nil) or (FDataPipeline.Owner = nil) then Exit;

  {check whether this component resides in a nested frame}
  Result := not (csInline in FDataPipeline.Owner.ComponentState);

  if not Result then
    begin
      lsMsg := 'New components cannot be added to frame instances';
      MessageDlg(lsMsg, mtWarning, [mbOK], 0);

    end;


end; {function, CheckFieldAdd}

{$ELSE}

{------------------------------------------------------------------------------}
{ TppFieldEditor.CheckFieldAdd }

function TppFieldEditor.CheckFieldAdd: Boolean;
begin

  Result := True;

end; {function, CheckFieldAdd}

{$ENDIF}


{------------------------------------------------------------------------------}
{ TppFieldEditor.CheckFieldDelete }

function TppFieldEditor.CheckFieldDelete: Boolean;
var
  liIndex: Integer;
  lField: TppField;
  lsMsg: String;
begin

  liIndex := 0;
  Result  := True;

  while Result and (liIndex < lbxField.Items.Count) do
      begin

        lField := TppField(lbxField.Items.Objects[liIndex]);

        {check whether this component resides in an ancestor}
        if lbxField.Selected[liIndex] then
          Result :=  not (csAncestor in lField.ComponentState);

        Inc(liIndex);

      end;

  if not Result then
    begin
      lsMsg := 'Selection contains a component introduced in an ancestor and cannot be deleted.';
      MessageDlg(lsMsg, mtWarning, [mbOK], 0);

    end;

end; {function, CheckFieldDelete}



{------------------------------------------------------------------------------}
{ TppFieldEditor.btnAddClick }

procedure TppFieldEditor.btnAddClick(Sender: TObject);
begin

  if not CheckFieldAdd then Exit;

  AddItem;

  SetObjectInspectorToSelection(True);
end; {procedure, btnAddClick}

{------------------------------------------------------------------------------}
{ TppFieldEditor.btnDeleteClick }

procedure TppFieldEditor.btnDeleteClick(Sender: TObject);
begin

  if not CheckFieldDelete then Exit;

  DeleteItems;

  if (lbxField.SelCount > 0) and (lbxField.Items.Count > 0) then
    SetObjectInspectorToSelection(True)
  else
    SetObjectInspectorToSelection(False);

end; {procedure, btnDeleteClick}

{------------------------------------------------------------------------------}
{ TppFieldEditor.btnMoveUpClick }

procedure TppFieldEditor.btnMoveUpClick(Sender: TObject);
begin
  MoveSelectedItems(-1);

  SetObjectInspectorToSelection(True);
end;

{------------------------------------------------------------------------------}
{ TppFieldEditor.btnMoveDownClick }

procedure TppFieldEditor.btnMoveDownClick(Sender: TObject);
begin
  MoveSelectedItems(1);

  SetObjectInspectorToSelection(True);
end;

{------------------------------------------------------------------------------}
{ TppFieldEditor.AddItem }

procedure TppFieldEditor.AddItem;
var
  lField: TppField;
begin

  lField := TppField.Create(FDataPipeline.Owner);
  lField.Name := FDataPipeline.GetValidName(lField);
  lField.FieldName := Copy(lField.Name, 3, Length(lField.Name));
  lField.FieldAlias := lField.FieldName;
  lField.DataPipeline := FDataPipeline;

  lbxField.Items.AddObject(lField.FieldName, lField);

  ClearSelection;

  if not(lbxField.Enabled) then
    lbxField.Enabled := True;

  lbxField.SetFocus;
  lbxField.Selected[lbxField.Items.Count - 1] := True;

end; {procedure, AddItem}

{------------------------------------------------------------------------------}
{ TppFieldEditor.ClearSelection }

procedure TppFieldEditor.ClearSelection;
var
  liIndex: Integer;
begin
  for liIndex := 0 to lbxField.Items.Count - 1 do
    lbxField.Selected[liIndex] := False;
end; {procedure, ClearSelection}

{------------------------------------------------------------------------------}
{ TppFieldEditor.MoveSelectedItems }

procedure TppFieldEditor.MoveSelectedItems(aDirection: Integer);
var
  liIndex: Integer;
  lSelected: TList;
  liFocus: Integer;
  liEnd: Integer;
  liIncrement: Integer;
  liNewIndex: Integer;
begin

  if (lbxField.Items.Count = 0) then Exit;

  lbxField.SetFocus;

  if (lbxField.Selected[0] = True) and (aDirection = -1) then Exit;

  if (lbxField.Selected[lbxField.Items.Count - 1] = True) and (aDirection = 1) then Exit;

  lSelected := TList.Create;
  liFocus := lbxField.ItemIndex + aDirection;

  if aDirection = 1 then
    begin
      liIndex := lbxField.Items.Count - 1;
      liIncrement := -1;
      liEnd := -1;
    end
  else
    begin
       liIndex := 0;
       liIncrement := 1;
       liEnd := lbxField.Items.Count;
    end;

  while liIndex <> liEnd do
    begin
      if (lbxField.Selected[liIndex] = True) then
        begin
          lbxField.Items.Move(liIndex, liIndex + aDirection);

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

          TppField(lbxField.Items.Objects[liNewIndex]).Position := liNewIndex;

          lbxField.Selected[liNewIndex] := True;
        end;

      lbxField.Selected[liFocus] := True;
    end;

  lSelected.Free;

end; {procedure, MoveSelectedItems}

{------------------------------------------------------------------------------}
{ TppFieldEditor.DeleteItems }

procedure TppFieldEditor.DeleteItems;
var
  liIndex: Integer;
  lField: TppField;
  liFirstSelected: Integer;
begin
  if (lbxField.Items.Count = 0) then Exit;

  liFirstSelected := -1;
  liIndex := 0;

  while liIndex < lbxField.Items.Count do
    begin

      if (lbxField.Selected[liIndex]) then
        begin
          liFirstSelected := liIndex;

          lField := TppField(lbxField.Items.Objects[liIndex]);
          lField.Free;

          lbxField.Items.Delete(liIndex);
        end
      else
        Inc(liIndex);

    end;

  if (lbxField.Enabled) and (lbxField.Items.Count = 0) then
    lbxField.Enabled := False
  else
    begin
      if (liFirstSelected >= lbxField.Items.Count) then
        liFirstSelected := lbxField.Items.Count - 1;

      if (liFirstSelected <> -1) then
        lbxField.Selected[liFirstSelected] := True;

      if (liFirstSelected <> -1) then
        lbxField.SetFocus;
    end;

end; {procedure, DeleteItems}

{------------------------------------------------------------------------------}
{ TppFieldEditor.ComponentChanged }

procedure TppFieldEditor.ComponentChanged;
var
  liIndex: Integer;
  lField: TppField;
  lSelected: TList;
  lFocusField: TppField;
begin

  lSelected := TList.Create;

  if (lbxField.ItemIndex >= 0) and(lbxField.Items.Count > 0) then
    lFocusField := TppField(lbxField.Items.Objects[lbxField.ItemIndex])
  else
    lFocusField := nil;

  for liIndex := 0 to lbxField.Items.Count - 1 do
    begin
      if (lbxField.Selected[liIndex]) then
        begin
          lField := TppField(lbxField.Items.Objects[liIndex]);

          lbxField.Items[liIndex] := lField.FieldName;

          lSelected.Add(lField);
        end;
    end;

  if (lSelected.Count > 0) then
    begin
      lbxField.Items.Clear;

      FieldsToListBox;

      for liIndex := 0 to lSelected.Count - 1 do
        begin
          lField := TppField(lSelected[liIndex]);
          
          lbxField.Selected[FDataPipeline.IndexOfField(lField)] := True;
        end;

      if lFocusField <> nil then
        lbxField.Selected[FDataPipeline.IndexOfField(lFocusField)] := True;
    end;

  lSelected.Free;


  if spbViewData.Down and (lblFile.Caption <> TppTextPipeline(FDataPipeline).FileName) then
    begin
      UpdateFileControls;
      LoadFileData;
    end;

  ComponentModified;

end; {procedure, ComponentChanged}

{------------------------------------------------------------------------------}
{ TppFieldEditor.SelectionChanged }


procedure TppFieldEditor.SelectionChanged(aSelection: TppDesignerSelectionList);
var
  liSelection : Integer;
  lField: TppField;
  liFieldIndex: Integer;
  lbFieldsSelected: Boolean;
begin

  if (Component = nil) then Exit;

  if (csDestroying in Component.ComponentState) then Exit;

  if (csReading in Component.ComponentState) or (csLoading in Component.ComponentState) then Exit;

  if not(Self.Visible) then Exit;

  FChangingSelection := True;

  lbFieldsSelected := False;

  ClearSelection;

  {filter the selection}
  for liSelection := 0 to aSelection.Count - 1 do

    if (aSelection[liSelection] is TppField) then
      begin
        lField := TppField(aSelection[liSelection]);

        {make sure field belongs to this text pipeline}
        if (lField.DataPipeline = FDataPipeline) then
          begin
            liFieldIndex := FindIndexForField(lField);

            if (liFieldIndex <> -1) then
              begin
                lbxField.Selected[liFieldIndex] := True;
                lbFieldsSelected := True;
              end;
          end;

      end;

  if not(lbFieldsSelected) then
    lbxField.ItemIndex := -1;

  FChangingSelection := False;

end; {procedure, SelectionChanged}

{------------------------------------------------------------------------------}
{ TppFieldEditor.SetObjectInspectorToSelection }

procedure TppFieldEditor.SetObjectInspectorToSelection(aSelectFields: Boolean);
var
  lComponentList: TppDesignerSelectionList;
  lField: TppField;
  liIndex: Integer;
begin

  if (Component = nil) then Exit;

  if not(csDesigning in Component.ComponentState) then Exit;

  if (csDestroying in Component.ComponentState) then Exit;

  {note: if FChangingSelection then no need to notify Object Inspector,
         because the Object Inspector initiated the change (prevents a stack fault)}
  if (FChangingSelection) then Exit;


  lComponentList := TppDesignerSelectionList.Create;

  {build component list}
  if aSelectFields then
    begin
      for liIndex := 0 to lbxField.Items.Count - 1 do
        if lbxField.Selected[liIndex] then
          begin
            lField := TppField(lbxField.Items.Objects[liIndex]);

            lComponentList.Add(lField);
          end;
    end
  else
    begin
      lbxField.ItemIndex := -1;
      lbxField.Refresh;
      
      lComponentList.Add(Component);
    end;

  {call TDesignWindow.SetSelection method to notify Object Inspector}
  if (lComponentList.Count = 0) then
    lComponentList.Free
  else
    DoOnSetSelection(lComponentList);

end; {procedure, SetObjectInspectorToSelection}

{------------------------------------------------------------------------------}
{ TppFieldEditor.FindIndexForField }

function TppFieldEditor.FindIndexForField(aField: TppField): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
  lField: TppField;
begin

  lbFound := False;
  liIndex := 0;

  while (liIndex < lbxField.Items.Count) and not(lbFound) do
    begin
      lField := TppField(lbxField.Items.Objects[liIndex]);

      if (aField = lField) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end; {function, FindIndexForField}


{------------------------------------------------------------------------------}
{ TppFieldEditor.lbxFieldsSelectedMouseDown }

procedure TppFieldEditor.lbxFieldMouseDown(Sender: TObject; Button: TMouseButton;
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

  liIndex  := lbxField.ItemAtPos(lPoint, lbExists);

  {start dragging}
  if (liIndex <> -1) then
    begin
      FStartDragIndex := liIndex;

      lbxField.BeginDrag(False);
    end;

end; {procedure, lbxFieldMouseDown}

{------------------------------------------------------------------------------}
{ TppFieldEditor.lbxFieldsSelectedDragOver }

procedure TppFieldEditor.lbxFieldDragOver(Sender, Source: TObject; X, Y: Integer;
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

  liIndex := lbxField.ItemAtPos(lPoint, lbExists);

  {determine which cursor to show}
  if (liIndex <> -1) then
    begin
      lbSelected := lbxField.Selected[liIndex];

      if not(lbSelected) then
        Accept := True
      else
        Accept := False;
    end
  else
    Accept := False;

end; {procedure, lbxFieldsSelectedDragOver}

{------------------------------------------------------------------------------}
{ TppFieldEditor.lbxFieldsSelectedEndDrag }

procedure TppFieldEditor.lbxFieldEndDrag(Sender, Target: TObject; X, Y: Integer);
var
  lPoint : TPoint;
  lbExists : Boolean;
  liIndex : Integer;
begin

  if not(FDragging) then Exit;

  FDragging := False;

  if not(Target = lbxField) then Exit;

  {move selection to new position}
  lPoint.X := X;
  lPoint.Y := Y;
  lbExists := True;

  liIndex := lbxField.ItemAtPos(lPoint, lbExists);

  if (liIndex <> FStartDragIndex) then
    begin
      MoveSelectedItems(liIndex - FStartDragIndex);

      SetObjectInspectorToSelection(True);
    end;

end;  {procedure, lbxFieldsSelectedEndDrag}

{------------------------------------------------------------------------------}
{ TppFieldEditor.UpdateFileControls }

procedure TppFieldEditor.UpdateFileControls;
begin

  if not(FUseFileControls) then
    begin
      lblFile.Caption := '';
      spbViewData.Down := False;
      spbViewData.Visible := False;
      if not FCreatingForm then Exit;
    end

  else if (TppTextPipeline(FDataPipeline).FileName <> '') then
    begin
      lblFile.Caption := TppTextPipeline(FDataPipeline).FileName;
      lblFile.Enabled := True;
      sgdFile.Enabled := True;
      sgdFile.Color := clWindow;
    end

  else
    begin
      lblFile.Caption := 'File';
      lblFile.Enabled := False;
      sgdFile.Enabled := False;
      sgdFile.Color := clBtnFace;
    end;

  ShowFileControls;

end; {procedure, UpdateFileControls}

{------------------------------------------------------------------------------}
{ TppFieldEditor.ShowFileControls }

procedure TppFieldEditor.ShowFileControls;
begin

  if not(Visible) then Exit;

  if (spbViewData.Down) then
    begin
      Width := Round(6.667 * Screen.PixelsPerInch);
      Height := Round(3.9583 * Screen.PixelsPerInch);
      pnlFileGrid.Visible := True;
    end

  else
    begin
      pnlFileGrid.Visible := False;
      Width := Round(2.8334 * Screen.PixelsPerInch);
      Height := Round(2.6771 * Screen.PixelsPerInch);
    end;

end; {procedure, ShowFileControls}

{------------------------------------------------------------------------------}
{ TppFieldEditor.spbViewDataClick }

procedure TppFieldEditor.spbViewDataClick(Sender: TObject);
begin
  ShowFileControls;

  LoadFileData;
end; {procedure, spbViewDataClick}

{------------------------------------------------------------------------------}
{ TppFieldEditor.LoadFileData }

procedure TppFieldEditor.LoadFileData;
var
  lLines: TStringList;
  liLine: Integer;
  liTextWidth: Integer;
  liMaxTextWidth: Integer;
  lsRuler: String;

  procedure BuildCharacterRuler;
  var
    liChar: Integer;
    liNumChars: Integer;
    liCharLength: Integer;
    liSkipCount: Integer;
  begin

    liCharLength := sgdFile.Canvas.TextWidth('0');
    liNumChars := liMaxTextWidth div liCharLength;
    lsRuler := '0';
    liSkipCount := 0;

    for liChar := 2 to liNumChars do
      begin

        if (liSkipCount <> 0) then
          Dec(liSkipCount)

        else if ((liChar mod 10) = 0) then
          begin
            lsRuler := lsRuler + '|' + IntToStr(liChar);
            liSkipCount := Length(IntToStr(liChar));
          end

        else if ((liChar mod 5) = 0) then
          lsRuler := lsRuler + ''''

        else
          lsRuler := lsRuler + ' ';

      end;

  end; {procedure, BuildCharacterRuler}

begin

  sgdFile.Cols[0].Clear;
  sgdFile.RowCount := 0;
  sgdFile.DefaultColWidth := -1;
  
  if (FDataPipeline = nil) then Exit;

  if (TppTextPipeline(FDataPipeline).FileName = '') then Exit;

  if not(spbViewData.Down) then Exit;

  lLines := nil;

  try
    lLines := TStringList.Create;

    lLines.LoadFromFile(TppTextPipeline(FDataPipeline).FileName);

    if (lLines.Count > 5) then
      sgdFile.RowCount := 5
    else
      sgdFile.RowCount := lLines.Count;

    if (TppTextPipeline(FDataPipeline).FileType = ftFixedLength) then
      begin
        if (sgdFile.RowCount < 5) then
          sgdFile.RowCount := sgdFile.RowCount + 1;

        sgdFile.FixedRows := 1;
      end
    else
      sgdFile.FixedRows := 0;

    liLine := 0;
    liMaxTextWidth := -1;

    while (liLine < lLines.Count) and (liLine < 5) do
      begin
        liTextWidth := sgdFile.Canvas.TextWidth(lLines[liLine]);

        if (liTextWidth > liMaxTextWidth) then
          liMaxTextWidth := liTextWidth;

        Inc(liLine);
      end;

    if (TppTextPipeline(FDataPipeline).FileType = ftFixedLength) then
       begin
         BuildCharacterRuler;

        lLines.Insert(0, lsRuler);
      end;

    sgdFile.Cols[0].Assign(lLines);

    sgdFile.DefaultColWidth := liMaxTextWidth;

  finally
    lLines.Free;
  end; {try, finally}

end; {procedure, LoadFileData}


end.
