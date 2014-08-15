{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daJoinPanel;

interface

{$I ppIfDef.pas}

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus,
  ppComm, ppTypes, ppUtils, ppTreeVw, daSQL, daDataManager,
  daDB, ppDB, ppDsgnDB;


type

  TdaTableSelectionType = (tsAllTables, tsSelectedTables, tsOneTable);

  { TdaJoinPanel }
  TdaJoinPanel = class(TppCommunicator)
  private
    FCreatingControls: Boolean;
    FDestroying: Boolean;
    FFreeingTableJoins: Boolean;
    FInitialized: Boolean;
    FModified: Boolean;
    FOnModify: TNotifyEvent;
    FParent: TWinControl;
    FSQL: TdaSQL;
    FTable1: TdaTable;
    FTable1Original: TdaTable;
    FTable1SelectionSetting: TdaTableSelectionType;
    FTable2: TdaTable;
    FTable2Original: TdaTable;
    FTable2SelectionSetting: TdaTableSelectionType;

    {controls}
    FbtnAdd: TButton;
    FbtnRemove: TButton;
    FcbxJoinTypes: TComboBox;
    FcbxOperators: TComboBox;
    FcbxTables1: TComboBox;
    FcbxTables2: TComboBox;
    FlblJoinFields: TLabel;
    FlblJoinTypes: TLabel;
    FlblTable1: TLabel;
    FlblTable1Fields: TLabel;
    FlblTable2: TLabel;
    FlblTable2Fields: TLabel;
    FlvwJoins: TppListView;
    FlvwTable1Fields: TppListView;
    FlvwTable2Fields: TppListView;

    procedure AddJoin(const aField1, aField2: String; aOperator: TdaJoinOperatorType);
    procedure CreateControls;
    procedure FreeFields(aListView: TListView);
    procedure FreeJoins;
    function  GetJoinCount: Integer;
    procedure JoinsToSQL;
    procedure LoadFieldsForTable(aListView: TListView; aTable: TdaTable);
    procedure LoadJoins;
    procedure LoadTableList(aComboBox: TComboBox; aTable: TdaTable; aSelectionType: TdaTableSelectionType);
    procedure MatchJoinFields;
    procedure Modification;
    procedure SelectTable(var aCurrentTable: TdaTable; aListView: TListView; aNewTable: TdaTable);
    procedure SetTable1Strings;
    procedure SetTable2Strings;
    procedure TablesToControls;
    procedure UpdateButtons;

    procedure btnAddClickEvent(Sender: TObject);
    procedure btnRemoveClickEvent(Sender: TObject);
    procedure cbxJoinTypesChangeEvent(Sender: TObject);
    procedure cbxOperatorsChangeEvent(Sender: TObject);
    procedure cbxTables1ChangeEvent(Sender: TObject);
    procedure cbxTables2ChangeEvent(Sender: TObject);
    procedure lvwFieldsSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvwJoinsClickEvent(Sender: TObject);
    procedure lvwJoinsDblClickEvent(Sender: TObject);
    procedure lvwJoinsColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
    procedure lvwJoinsScrollEvent(Sender: TObject);
    procedure lvwJoinsSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);

  public
    constructor CreatePanel(aComponent: TComponent; aParent: TWinControl; aTable1, aTable2: TdaTable; aSQL: TdaSQL);
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    function  Finalize: Boolean;
    procedure Initialize;
    procedure Update;
    procedure Clear;

    property JoinCount: Integer read GetJoinCount;
    property Modified: Boolean read FModified;
    property OnModify: TNotifyEvent read FOnModify write FOnModify;
    property SQL: TdaSQL read FSQL write FSQL;
    property Table1: TdaTable read FTable1 write FTable1;
    property Table1SelectionSetting: TdaTableSelectionType read FTable1SelectionSetting write FTable1SelectionSetting;
    property Table2: TdaTable read FTable2 write FTable2;
    property Table2SelectionSetting: TdaTableSelectionType read FTable2SelectionSetting write FTable2SelectionSetting;

  end; {class, TdaJoinPanel}


implementation

uses
  daMetaDataManager;

{******************************************************************************
 *
 ** J O I N   P A N E L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.CreatePanel }

constructor TdaJoinPanel.CreatePanel(aComponent: TComponent; aParent: TWinControl; aTable1, aTable2: TdaTable; aSQL: TdaSQL);
begin

  inherited Create(aComponent);

  FCreatingControls := False;
  FDestroying := False;
  FFreeingTableJoins := False;
  FModified := False;
  FParent := aParent;
  FTable1 := aTable1;
  FTable1Original := nil;
  FTable1SelectionSetting := tsAllTables;
  FTable2 := aTable2;
  FTable2Original := nil;
  FTable2SelectionSetting := tsAllTables;
  FSQL := aSQL;

  {controls}
  FbtnAdd := nil;
  FbtnRemove := nil;
  FcbxJoinTypes := nil;
  FcbxOperators := nil;
  FcbxTables1 := nil;
  FcbxTables2 := nil;
  FlblJoinFields := nil;
  FlblJoinTypes := nil;
  FlblTable1 := nil;
  FlblTable1Fields := nil;
  FlblTable2 := nil;
  FlblTable2Fields := nil;
  FlvwJoins := nil;
  FlvwTable1Fields := nil;
  FlvwTable2Fields := nil;

end; {constructor, CreatePanel}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Destroy }

destructor TdaJoinPanel.Destroy;
begin

  FDestroying := True;

  Clear;

  {controls}
  FbtnAdd.Free;
  FbtnRemove.Free;
  FcbxJoinTypes.Free;
  FcbxOperators.Free;
  FcbxTables1.Free;
  FcbxTables2.Free;
  FlblJoinFields.Free;
  FlblJoinTypes.Free;
  FlblTable1.Free;
  FlblTable1Fields.Free;
  FlblTable2.Free;
  FlblTable2Fields.Free;
  FlvwJoins.Free;
  FlvwTable1Fields.Free;
  FlvwTable2Fields.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Notify }

procedure TdaJoinPanel.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  lItem: TListItem;
begin

  inherited Notify(aCommunicator, aOperation);

  if (FFreeingTableJoins) then Exit;

  if (aOperation = ppopRemove) and (aCommunicator is TdaTableJoin) then
    begin
      lItem := FlvwJoins.FindData(0, aCommunicator, True, False);

      if (lItem <> nil) then
        lItem.Free;
    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Initialize }

procedure TdaJoinPanel.Initialize;
begin

  CreateControls;

  TablesToControls;

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Finalize }

function TdaJoinPanel.Finalize: Boolean;
begin

  if (FlvwJoins.Items.Count = 0) then
    begin
      ShowMessage(ppLoadStr(780)); {Join fields have not been selected.}

      Result := False;
    end
  else
    begin
      JoinsToSQL;

      Result := True;
    end;

  Clear;

end; {procedure, Finalize}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Modification }

procedure TdaJoinPanel.Modification;
begin

  FModified := True;

  if Assigned(FOnModify) then FOnModify(Self);

end; {procedure, Modification}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Clear }

procedure TdaJoinPanel.Clear;
begin

  FcbxTables1.Items.Clear;
  FcbxTables2.Items.Clear;
  
  FreeFields(FlvwTable1Fields);
  FreeFields(FlvwTable2Fields);

  FTable1.Free;
  FTable1 := nil;

  FTable2.Free;
  FTable2 := nil;

  FreeJoins;

  FInitialized := False;
  FModified := False;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.FreeFields }

procedure TdaJoinPanel.FreeFields(aListView: TListView);
var
  liIndex: Integer;
begin

  for liIndex := 0 to aListView.Items.Count - 1 do
    TdaField(aListView.Items[liIndex].Data).Free;

  aListView.Items.Clear;
    
end; {procedure, FreeFields}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.FreeJoins }

procedure TdaJoinPanel.FreeJoins;
var
  lItem: TListItem;
  liIndex: Integer;
begin

  if (FlvwJoins.Items.Count = 0) then Exit;

  FFreeingTableJoins := True;

  FlvwJoins.Items.BeginUpdate;

  for liIndex := 0 to FlvwJoins.Items.Count - 1 do
    begin
      lItem := FlvwJoins.Items[liIndex];

      if (lItem.Data <> nil) then
        TdaTableJoin(lItem.Data).Free;
    end;

  FlvwJoins.Items.Clear;
  
  FlvwJoins.Items.EndUpdate;

  FFreeingTableJoins := False;

end; {procedure, FreeJoins}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.JoinsToSQL }

procedure TdaJoinPanel.JoinsToSQL;
var
  lItem: TListItem;
  liIndex: Integer;
begin

  if not(FModified) then Exit;
  
  for liIndex := 0 to FlvwJoins.Items.Count - 1 do
    begin
      lItem := FlvwJoins.Items[liIndex];

      TdaTableJoin(lItem.Data).Parent := FTable2;

      lItem.Data := nil;
    end;

  if (FTable1Original <> nil) then
    FTable1Original.Assign(FTable1);

  if (FTable2Original <> nil) then
    FTable2Original.Assign(FTable2);

end; {procedure, JoinsToSQL}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.GetJoinCount }

function TdaJoinPanel.GetJoinCount: Integer;
begin
  Result := FlvwJoins.Items.Count;
end; {procedure, GetJoinCount}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.CreateControls }

procedure TdaJoinPanel.CreateControls;
var
  lColumn: TListColumn;
  liJoin: Integer;
  lOperator: TdaJoinOperatorType;
begin

  if (FParent = nil) then Exit;

  FCreatingControls := True;

  {create table selection controls}
  FlblTable1 := TLabel.Create(Self);
  FlblTable1.Parent := FParent;
  FlblTable1.Caption := 'Select Table 1';
  FlblTable1.Left := 7;
  FlblTable1.Top := 6;

  FcbxTables1 := TComboBox.Create(Self);
  FcbxTables1.Parent := FParent;
  FcbxTables1.Style := csDropDownList;
  FcbxTables1.DropDownCount := 16;
  FcbxTables1.Left := 7;
  FcbxTables1.Top := 24;
  FcbxTables1.Width := 200;
  FcbxTables1.OnChange := cbxTables1ChangeEvent;
  FcbxTables1.Sorted := True;

  FcbxTables1.Enabled := (FTable1SelectionSetting = tsAllTables);

  FlblTable2 := TLabel.Create(Self);
  FlblTable2.Parent := FParent;
  FlblTable2.Caption := 'Select Table 2';
  FlblTable2.Left := 309;
  FlblTable2.Top := 6;

  FcbxTables2 := TComboBox.Create(Self);
  FcbxTables2.Parent := FParent;
  FcbxTables2.Style := csDropDownList;
  FcbxTables2.DropDownCount := 16;
  FcbxTables2.Left := 309;
  FcbxTables2.Top := 24;
  FcbxTables2.Width := 200;
  FcbxTables2.OnChange := cbxTables2ChangeEvent;
  FcbxTables2.Sorted := True;

  FlblJoinTypes := TLabel.Create(Self);
  FlblJoinTypes.Parent := FParent;
  FlblJoinTypes.Caption := ppLoadStr(782); {Join Type}
  FlblJoinTypes.Left := 220;
  FlblJoinTypes.Top := 6;

  FcbxJoinTypes := TComboBox.Create(Self);
  FcbxJoinTypes.Parent := FParent;
  FcbxJoinTypes.Style := csDropDownList;
  FcbxJoinTypes.Left := 220;
  FcbxJoinTypes.Top := 24;
  FcbxJoinTypes.Width := 75;
  FcbxJoinTypes.OnChange := cbxJoinTypesChangeEvent;

  {create field selection controls}
  FlblTable1Fields := TLabel.Create(Self);
  FlblTable1Fields.Parent := FParent;
  FlblTable1Fields.Caption := 'Table1 Fields';
  FlblTable1Fields.Left := 7;
  FlblTable1Fields.Top := 58;

  FlvwTable1Fields := TppListView.Create(Self);
  FlvwTable1Fields.Parent := FParent;
  FlvwTable1Fields.ReadOnly := True;
  FlvwTable1Fields.RowSelect := True;
  FlvwTable1Fields.HideSelection := False;
  FlvwTable1Fields.ColumnClick := False;
  FlvwTable1Fields.ViewStyle := vsReport;
  FlvwTable1Fields.Left := 7;
  FlvwTable1Fields.Top := 75;
  FlvwTable1Fields.Width := 200;
  FlvwTable1Fields.Height := 148;
  FlvwTable1Fields.SmallImages := TImageList.Create(Self);
  FlvwTable1Fields.SmallImages.Width := 0;
  FlvwTable1Fields.SmallImages.Height := 16;

  lColumn := FlvwTable1Fields.Columns.Add;
  lColumn.Caption := 'Field Name';
  lColumn.Width := 134;

  lColumn := FlvwTable1Fields.Columns.Add;
  lColumn.Caption := 'Type';
  lColumn.Width := 46;

  FlvwTable1Fields.OnSelectItem := lvwFieldsSelectItemEvent;

  FlblTable2Fields := TLabel.Create(Self);
  FlblTable2Fields.Parent := FParent;
  FlblTable2Fields.Caption := 'Table2 Fields';
  FlblTable2Fields.Left := 309;
  FlblTable2Fields.Top := 58;

  FlvwTable2Fields := TppListView.Create(Self);
  FlvwTable2Fields.Parent := FParent;
  FlvwTable2Fields.ReadOnly := True;
  FlvwTable2Fields.RowSelect := True;
  FlvwTable2Fields.HideSelection := False;
  FlvwTable2Fields.ColumnClick := False;
  FlvwTable2Fields.ViewStyle := vsReport;
  FlvwTable2Fields.Left := 309;
  FlvwTable2Fields.Top := 75;
  FlvwTable2Fields.Width := 200;
  FlvwTable2Fields.Height := 148;
  FlvwTable2Fields.SmallImages := TImageList.Create(Self);
  FlvwTable2Fields.SmallImages.Width := 0;
  FlvwTable2Fields.SmallImages.Height := 16;

  lColumn := FlvwTable2Fields.Columns.Add;
  lColumn.Width := 134;
  lColumn.Caption := 'Field Name';

  lColumn := FlvwTable2Fields.Columns.Add;
  lColumn.Width := 46;
  lColumn.Caption := 'Type';

  FlvwTable2Fields.OnSelectItem := lvwFieldsSelectItemEvent;

  FbtnAdd := TButton.Create(Self);
  FbtnAdd.Parent := FParent;
  FbtnAdd.Caption := ppLoadStr(713); {Add}
  FbtnAdd.Left := 220;
  FbtnAdd.Top := 122;
  FbtnAdd.Width := 75;
  FbtnAdd.OnClick := btnAddClickEvent;

  FbtnRemove := TButton.Create(Self);
  FbtnRemove.Parent := FParent;
  FbtnRemove.Caption := ppLoadStr(813); {Remove}
  FbtnRemove.Left := 220;
  FbtnRemove.Top := 154;
  FbtnRemove.Width := 75;
  FbtnRemove.OnClick := btnRemoveClickEvent;

  {create join controls}
  FlblJoinFields := TLabel.Create(Self);
  FlblJoinFields.Parent := FParent;
  FlblJoinFields.Caption := ppLoadStr(783); {Joined Fields}
  FlblJoinFields.Left := 7;
  FlblJoinFields.Top := 235;

  FlvwJoins := TppListView.Create(Self);
  FlvwJoins.Parent := FParent;
  FlvwJoins.ReadOnly := True;
  FlvwJoins.RowSelect := True;
  FlvwJoins.MultiSelect := True;
  FlvwJoins.ColumnClick := False;
  FlvwJoins.ViewStyle := vsReport;
  FlvwJoins.Left := 7;
  FlvwJoins.Top := 254;
  FlvwJoins.Width := 504;
  FlvwJoins.Height := 112;
  FlvwJoins.SmallImages := TImageList.Create(Self);
  FlvwJoins.SmallImages.Width := 0;
  FlvwJoins.SmallImages.Height := 16;

  lColumn := FlvwJoins.Columns.Add;
  lColumn.Width := 208;
  lColumn.Caption := 'Table1 Fields';

  lColumn := FlvwJoins.Columns.Add;
  lColumn.Caption := ppLoadStr(802); {Operator}
  lColumn.Width := 83;

  lColumn := FlvwJoins.Columns.Add;
  lColumn.Width := 208;
  lColumn.Caption := 'Table2  Fields';

  FlvwJoins.OnClick := lvwJoinsClickEvent;
  FlvwJoins.OnDblClick := lvwJoinsDblClickEvent;
  FlvwJoins.OnColumnResize := lvwJoinsColumnResizeEvent;
  FlvwJoins.OnScroll := lvwJoinsScrollEvent;
  FlvwJoins.OnSelectItem := lvwJoinsSelectItemEvent;

  FcbxOperators := TComboBox.Create(Self);
  FcbxOperators.Parent := FParent;
  FcbxOperators.Style := csDropDownList;
  FcbxOperators.Visible := False;
  FcbxOperators.OnChange := cbxOperatorsChangeEvent;
  FcbxOperators.BringToFront;

  SetTable1Strings;
  SetTable2Strings;

  {populate join types drop-down list}
  FcbxJoinTypes.Items.Clear;

  for liJoin := Ord(dajtInner) to Ord(dajtRightOuter) do
    FcbxJoinTypes.Items.Add(daGetJoinDesc(TdaJoinType(liJoin)));

  {populate operators drop-down list}
  FcbxOperators.Items.Clear;

  for lOperator := Low(TdaJoinOperatorType) to High(TdaJoinOperatorType) do
    FcbxOperators.Items.Add(daJoinOperatorToString(lOperator));


  FCreatingControls := False;

end; {procedure, CreateControls}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.Update }

procedure TdaJoinPanel.Update;
begin

  gMetaDataManager.Clear;

  Clear;

  if (FSQL.SelectTableCount >= 2) then
    begin
      FTable1 := FSQL.SelectTables[0];
      FTable2 := FSQL.SelectTables[1];
    end
  else 
    begin
      FTable1 := FSQL.AddTable('');
      FTable2 := FSQL.AddTable('');
    end;

  TablesToControls;

end; {procedure, Update}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.TablesToControls }

procedure TdaJoinPanel.TablesToControls;
begin

  if (FTable1 = nil) then Exit;

  {create copy of original tables}
  if (FTable1 <> nil) then
    begin
      FTable1Original := FTable1;

      FTable1 := TdaTable.Create(SQL);
      FTable1.Assign(FTable1Original);
    end
  else
    FTable1Original := nil;

  if (FTable2 <> nil) then
    begin
      FTable2Original := FTable2;

      FTable2 := TdaTable.Create(SQL);
      FTable2.Assign(FTable2Original);
    end
  else
    FTable2Original := nil;


  {load Table1 list}
  LoadTableList(FcbxTables1, FTable1, FTable1SelectionSetting);

  {default Table1}
  FcbxTables1.ItemIndex := FcbxTables1.Items.IndexOf(FTable1.RawTableName);

  SetTable1Strings;

  {load fields for Table1}
  LoadFieldsForTable(FlvwTable1Fields, FTable1);

  {load Table2 list}
  LoadTableList(FcbxTables2, FTable2, FTable2SelectionSetting);

  {default Table2}
  FcbxTables2.ItemIndex := FcbxTables2.Items.IndexOf(FTable2.RawTableName);

  SetTable2Strings;
  
  {load fields for Table2}
  LoadFieldsForTable(FlvwTable2Fields, FTable2);

  {default join type}
  FcbxJoinTypes.ItemIndex := Ord(FTable2.JoinType) - 1;

  {load joins}
  LoadJoins;

  {match join fields}
  MatchJoinFields;

  {enable/disable button}
  UpdateButtons;

  FInitialized := True;
  FModified := False;

end; {procedure, TablesToControls}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.LoadJoins }

procedure TdaJoinPanel.LoadJoins;
var
  liIndex: Integer;
  lItem: TListItem;
  lTableJoin: TdaTableJoin;
begin

  FreeJoins;

  for liIndex := 0 to FTable2.TableJoinCount - 1 do
    begin
      lItem := FlvwJoins.Items.Add;

      lTableJoin := FTable2.TableJoins[liIndex];

      lTableJoin.AddNotify(Self);
      
      lItem.Caption := lTableJoin.ForeignField.FieldName;
      lItem.SubItems.Add(daJoinOperatorToString(lTableJoin.Operator));
      lItem.SubItems.Add(lTableJoin.LocalField.FieldName);

      lItem.Data := lTableJoin;
    end;
    
end; {procedure, LoadJoins}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.LoadTableList }

procedure TdaJoinPanel.LoadTableList(aComboBox: TComboBox; aTable: TdaTable; aSelectionType: TdaTableSelectionType);
var
  liIndex: Integer;
  lTable: TdaTable;
begin

  aComboBox.Items.Clear;

  case aSelectionType of

    tsSelectedTables:
      for liIndex := 0 to FSQL.SelectTableCount - 1 do
        begin
          lTable := FSQL.SelectTables[liIndex];

          aComboBox.Items.AddObject(lTable.RawTableName, lTable);
        end;

    tsAllTables:
      for liIndex := 0 to FSQL.AvailableTableCount - 1 do
        begin
          lTable := FSQL.AvailableTables[liIndex];

          aComboBox.Items.AddObject(lTable.RawTableName, lTable);
        end;

    tsOneTable:
      if (aTable <> nil) then
        aComboBox.Items.AddObject(aTable.RawTableName, aTable);

  end;

end; {procedure, LoadTableList}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.LoadFieldsForTable }

procedure TdaJoinPanel.LoadFieldsForTable(aListView: TListView; aTable: TdaTable);
var
  liIndex: Integer;
  lFields: TList;
  lItem: TListItem;
  lField: TppField;
  lsDataType: String;
  lDataSet: TdaDataSet; 
  ldaField: TdaField;
begin

  if (aTable.TableName = '') then Exit;

  aListView.Items.BeginUpdate;

  FreeFields(aListView);

  lFields := TList.Create;

  lDataSet := FSQL.Session.CreateDataSet(Self, FSQL.DatabaseName);
  lDataSet.DataName := aTable.DataName{SQLText};

  try
    lDataSet.Open;

    for liIndex := 0 to lDataSet.FieldCount - 1 do
      begin
        lField := lDataSet.Fields[liIndex];

        ldaField := TdaField.Create(nil);

        FSQL.ppFieldTodaField(lField, ldaField);

        lItem := aListView.Items.Add;

        lItem.Caption := ldaField.FieldName;

        lsDataType := daDataTypeToString(ldaField.DataType);
        lsDataType := Copy(lsDataType, 3, Length(lsDataType));

        lItem.SubItems.Add(lsDataType);

        lItem.Data := ldaField;
      end;

  finally
    lFields.Free;
    lDataSet.Free;
  end;

  aListView.Selected := nil;

  aListView.Items.EndUpdate;

end; {procedure, LoadFieldsForTable}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.SelectTable }

procedure TdaJoinPanel.SelectTable(var aCurrentTable: TdaTable; aListView: TListView; aNewTable: TdaTable);
begin

  if (aCurrentTable <> nil) and (aNewTable <> nil) and (aCurrentTable.TableAlias = aNewTable.TableAlias) then Exit;

  aListView.Items.BeginUpdate;

  FreeFields(aListView);

  aCurrentTable.Assign(aNewTable);

  LoadFieldsForTable(aListView, aCurrentTable);

  MatchJoinFields;

  aListView.Items.EndUpdate;

end; {procedure, SelectTable}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.AddJoin }

procedure TdaJoinPanel.AddJoin(const aField1, aField2: String; aOperator: TdaJoinOperatorType);
var
  lItem: TListItem;
  lTableJoin: TdaTableJoin;
  lField1: TdaField;
  lField2: TdaField;
begin

  {create join}
  lTableJoin := TdaTableJoin.Create(Self);

  lTableJoin.AddNotify(Self);

  lTableJoin.Operator := aOperator;

  lField1 := FSQL.CreateFieldForTable(FTable1, aField1);
  lField1.ChildType := Ord(dactForeignField);
  lField1.Parent := lTableJoin;

  lField2 := FSQL.CreateFieldForTable(FTable2, aField2);
  lField2.ChildType := Ord(dactLocalField);
  lField2.Parent := lTableJoin;

  {create item}
  lItem := FlvwJoins.Items.Add;

  lItem.Caption := lTableJoin.ForeignField.FieldName;
  lItem.SubItems.Add(daJoinOperatorToString(lTableJoin.Operator));
  lItem.SubItems.Add(lTableJoin.LocalField.FieldName);

  lItem.Data := lTableJoin;

  FlvwTable1Fields.Selected := nil;
  FlvwTable2Fields.Selected := nil;

  UpdateButtons;

end; {procedure, AddJoin}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.UpdateButtons }

procedure TdaJoinPanel.UpdateButtons;
begin
  FbtnAdd.Enabled := (FlvwTable1Fields.Selected <> nil) and (FlvwTable2Fields.Selected <> nil);
  FbtnRemove.Enabled := (FlvwJoins.Selected <> nil);
end; {procedure, UpdateButtons}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.MatchJoinFields }

procedure TdaJoinPanel.MatchJoinFields;
var
  lSaveDataDictionary: TppDataDictionary;
begin

  if (FTable2.TableJoinCount > 0) then Exit;

  lSaveDataDictionary := FSQL.DataDictionary;

  try
    FSQL.DataDictionary := nil;

    FSQL.MatchJoinFieldsByName(FTable1, FTable2);
  finally
    FSQL.DataDictionary := lSaveDataDictionary;
  end;

  LoadJoins;

end; {procedure, MatchJoinFields}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.SetTable1Strings }

procedure TdaJoinPanel.SetTable1Strings;
begin

  if (FTable1 <> nil) then
    begin
      FlblTable1.Caption := 'Join ' + FTable1.TableAlias + ' Table';
      FlblTable1Fields.Caption := FTable1.TableAlias + ' ' + ppLoadStr(763); {Fields}
      FlvwJoins.Columns[0].Caption := FTable1.TableAlias + ' ' + ppLoadStr(760) {Field}
    end

  else
    begin
      FlblTable1.Caption := 'Select Table 1';
      FlblTable1Fields.Caption := 'Table 1' +  ' ' + ppLoadStr(763); {Fields}
      FlvwJoins.Columns[0].Caption := 'Table 1' +  ' ' + ppLoadStr(760) {Field}
    end;

end; {procedure, SetTable1Strings}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.SetTable2Strings }

procedure TdaJoinPanel.SetTable2Strings;
begin

  if (FTable2 <> nil) then
    begin
      FlblTable2.Caption := 'with ' + FTable2.TableAlias + ' Table';
      FlblTable2Fields.Caption := FTable2.TableAlias + ' ' + ppLoadStr(763); {Fields}
      FlvwJoins.Columns[2].Caption := FTable2.TableAlias + ' ' + ppLoadStr(760) {Field}
    end

  else
    begin
      FlblTable2.Caption := 'Select Table 2';
      FlblTable2Fields.Caption := 'Table 2' +  ' ' + ppLoadStr(763); {Fields}
      FlvwJoins.Columns[2].Caption := 'Table 2' +  ' ' + ppLoadStr(760) {Field}
    end;

end; {procedure, SetTable2Strings}

{******************************************************************************
 *
 ** E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.lvwJoinsScrollEvent }

procedure TdaJoinPanel.lvwJoinsScrollEvent(Sender: TObject);
begin
  if (FCreatingControls) or (FDestroying) then Exit;

  FcbxOperators.Visible := False;
end; {procedure, lvwJoinsScrollEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.lvwJoinsColumnResizeEvent }

procedure TdaJoinPanel.lvwJoinsColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
begin
  if (FCreatingControls) or (FDestroying) then Exit;

  if (FlvwJoins.Selected <> nil) then
    begin
      FcbxOperators.Left := FlvwJoins.Left + FlvwJoins.Columns[0].Width + 8;
      FcbxOperators.Top := FlvwJoins.Selected.Top + FlvwJoins.Selected.Top;
      FcbxOperators.Width := FlvwJoins.Columns[1].Width;
    end;
end; {procedure, lvwJoinsColumnResizeEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.lvwJoinsDblClickEvent }

procedure TdaJoinPanel.lvwJoinsDblClickEvent(Sender: TObject);
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  if (FlvwJoins.Selected <> nil) then
    btnRemoveClickEvent(Self);

end; {procedure, lvwJoinsDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.lvwJoinsClickEvent }

procedure TdaJoinPanel.lvwJoinsClickEvent(Sender: TObject);
var
  lPoint: TPoint;
  lItem: TListItem;
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  GetCursorPos(lPoint);

  lPoint := FlvwJoins.ScreenToClient(lPoint);

  lItem := FlvwJoins.GetItemAt(2, lPoint.Y);

  if (FlvwJoins.Selected <> lItem) then
    FlvwJoins.Selected := lItem;

end; {procedure, lvwJoinsClickEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.lvwJoinsSelectItemEvent }

procedure TdaJoinPanel.lvwJoinsSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  if (Item = nil) or not(Selected) or (FlvwJoins.SelCount > 1) then
    begin
      FcbxOperators.Visible := False;

      if (FlvwJoins.SelCount > 0) then
        FbtnRemove.Enabled := True
      else
        FbtnRemove.Enabled := False;
    end
  else
    begin
      FcbxOperators.ItemIndex := Ord(TdaTableJoin(Item.Data).Operator);

      FcbxOperators.Left := FlvwJoins.Columns[0].Width + 8;
      FcbxOperators.Top := FlvwJoins.Top + Item.Top;
      FcbxOperators.Width := FlvwJoins.Columns[1].Width;
      FcbxOperators.Visible := True;

      FbtnRemove.Enabled := True;
    end;

end; {procedure, lvwJoinsSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.btnAddClickEvent }

procedure TdaJoinPanel.btnAddClickEvent(Sender: TObject);
var
  lField1: TdaField;
  lField2: TdaField;
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  lField1 := TdaField(FlvwTable1Fields.Selected.Data);
  lField2 := TdaField(FlvwTable2Fields.Selected.Data);

  AddJoin(lField1.FieldName, lField2.FieldName, dajoEqual);

  Modification;

end; {procedure, btnAddClickEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.lvwSelectItemEvent }

procedure TdaJoinPanel.lvwFieldsSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  UpdateButtons;

end; {procedure, lvwSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.cbxTables1ChangeEvent }

procedure TdaJoinPanel.cbxTables1ChangeEvent(Sender: TObject);
var
  lTable: TdaTable;
begin

  if (FCreatingControls) or (FDestroying) or (FcbxTables1.ItemIndex = -1) then Exit;

  lTable := TdaTable(FcbxTables1.Items.Objects[FcbxTables1.ItemIndex]);

  FreeJoins;
    
  SelectTable(FTable1, FlvwTable1Fields, lTable);

  SetTable1Strings;

  Modification;

end; {procedure, cbxTables1ChangeEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.cbxTables2ChangeEvent }

procedure TdaJoinPanel.cbxTables2ChangeEvent(Sender: TObject);
var
  lTable: TdaTable;
begin

  if (FCreatingControls) or (FDestroying) or (FcbxTables2.ItemIndex = -1)  then Exit;

  lTable := TdaTable(FcbxTables2.Items.Objects[FcbxTables2.ItemIndex]);

  if (FTable2.TableAlias <> lTable.TableAlias) then
    FreeJoins;
    
  SelectTable(FTable2, FlvwTable2Fields, lTable);

  FTable2.JoinType := TdaJoinType(FcbxJoinTypes.ItemIndex + 1);

  SetTable2Strings;

  Modification;

end; {procedure, cbxTables2ChangeEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.cbxJoinTypesChangeEvent }

procedure TdaJoinPanel.cbxJoinTypesChangeEvent(Sender: TObject);
begin
  if (FCreatingControls) or (FDestroying) then Exit;

  FTable2.JoinType := TdaJoinType(FcbxJoinTypes.ItemIndex + 1);

  Modification;
end; {procedure, cbxJoinTypesChangeEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.cbxOperatorsChangeEvent }

procedure TdaJoinPanel.cbxOperatorsChangeEvent(Sender: TObject);
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  if (FlvwJoins.Selected = nil) then Exit;

  TdaTableJoin(FlvwJoins.Selected.Data).Operator := TdaJoinOperatorType(FcbxOperators.ItemIndex);

  FlvwJoins.Selected.SubItems[0] := FcbxOperators.Items[FcbxOperators.ItemIndex];

  Modification;

end; {procedure, cbxOperatorsChangeEvent}

{------------------------------------------------------------------------------}
{ TdaJoinPanel.btnRemoveClickEvent }

procedure TdaJoinPanel.btnRemoveClickEvent(Sender: TObject);
var
  liIndex: Integer;
  lList: TList;
  lItem: TListItem;
begin

  if (FCreatingControls) or (FDestroying) then Exit;

  lItem := FlvwJoins.Selected;

  if (lItem = nil) then Exit;

  lList := TList.Create;

  while (lItem <> nil) do
    begin
      lList.Add(lItem);

      lItem := FlvwJoins.GetNextItem(lItem, sdAll, [isSelected]);
    end;

  FlvwJoins.Items.BeginUpdate;

  for liIndex := 0 to lList.Count - 1 do
    begin
      lItem := TListItem(lList[liIndex]);

      TdaTableJoin(lItem.Data).Free;
    end;

  lList.Free;

  FlvwJoins.Items.EndUpdate;

  Modification;

end; {procedure, btnRemoveClickEvent}



end.
