{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit daJoinTableDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  ppTypes, ppUtils, ppTreeVw, daSQL;

type

  { TdaJoinTableDialog }
  TdaJoinTableDialog = class(TForm)
    cbxOperators: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    lblJoinType: TLabel;
    cbxJoinTypes: TComboBox;
    cbxTables: TComboBox;
    lbxFields: TListBox;
    lbxJoinFields: TListBox;
    lblForeignTable: TLabel;
    lblLocalTable: TLabel;
    btnAdd: TButton;
    lblJoinTable: TLabel;
    lblJoinedFields: TLabel;
    btnRemove: TButton;
    edtExpression: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxFieldsClick(Sender: TObject);
    procedure cbxTablesChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cbxOperatorsChange(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure cbxJoinTypesChange(Sender: TObject);
    procedure edtExpressionExit(Sender: TObject);
    procedure edtExpressionKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);

  private
    FlvwJoins: TppListView;
    FModifyTable: TdaTable;
    FSQL: TdaSQL;
    FTable1: TdaTable;
    FTable2: TdaTable;

    procedure AddJoin(const aField1, aField2: String; aOperator: TdaJoinOperatorType);
    procedure EditExpressionEnd;
    procedure EnableAddButton;
    function  GetJoinCount: Integer;
    procedure LoadJoinFields;
    procedure SetForeignTableStrings;
    procedure SetStrings;

    procedure JoinsClickEvent(Sender: TObject);
    procedure JoinsDblClickEvent(Sender: TObject);
    procedure JoinsColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
    procedure JoinsScrollEvent(Sender: TObject);
    procedure JoinsSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);

  public
    procedure Initialize;
    procedure Finalize;

    property JoinCount: Integer read GetJoinCount;
    property SQL: TdaSQL read FSQL write FSQL;
    property Table1: TdaTable read FTable1 write FTable1;
    property Table2: TdaTable read FTable2 write FTable2;

  end; {class, TdaJoinTableDialog}

var
  daJoinTableDialog: TdaJoinTableDialog;

implementation

{$R *.DFM}

{******************************************************************************
 *
 ** F O R M   E V E N T   H A N D L E R S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.FormCreate }

procedure TdaJoinTableDialog.FormCreate(Sender: TObject);
var
  lColumn: TListColumn;
begin

  ParentFont := True;

  FTable2 := nil;
  FTable1 := nil;
  FSQL := nil;

  FlvwJoins := TppListView.Create(Self);
  FlvwJoins.Parent := Self;

  lColumn := FlvwJoins.Columns.Add;
  lColumn.Width := 200;

  lColumn := FlvwJoins.Columns.Add;
  lColumn.Width := 83;

  lColumn := FlvwJoins.Columns.Add;
  lColumn.Width := 196;

  {in Delphi3, must set ReadOnly after columns have been added}
  FlvwJoins.ReadOnly := True;
  FlvwJoins.RowSelect := True;
  FlvwJoins.MultiSelect := True;
  FlvwJoins.ColumnClick := False;
  FlvwJoins.ViewStyle := vsReport;
  FlvwJoins.SmallImages := TImageList.Create(Self);
  FlvwJoins.SmallImages.Width := 0;
  FlvwJoins.SmallImages.Height := 16;

  FlvwJoins.OnClick := JoinsClickEvent;
  FlvwJoins.OnDblClick := JoinsDblClickEvent;
  FlvwJoins.OnColumnResize := JoinsColumnResizeEvent;
  FlvwJoins.OnScroll := JoinsScrollEvent;
  FlvwJoins.OnSelectItem := JoinsSelectItemEvent;

  cbxOperators.BringToFront;
  edtExpression.BringToFront;
  
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.FormActivate }

procedure TdaJoinTableDialog.FormActivate(Sender: TObject);
begin
  FlvwJoins.Left := 4;
  FlvwJoins.Top := lblJoinedFields.Top + lblJoinedFields.Height;
  FlvwJoins.Width := 483;
  FlvwJoins.Height := 112;
end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.Initialize }

procedure TdaJoinTableDialog.Initialize;
var
  liIndex: Integer;
  lItem: TListItem;
  lTable: TdaTable;
  lTableJoin: TdaTableJoin;
begin

  SetStrings;

  {if modifying, create copy of original table}
  if (FTable2.TableJoinCount > 0) then
    begin
      FModifyTable := FTable2;

      FTable2 := TdaTable.Create(SQL);
      FTable2.Assign(FModifyTable);
    end
  else
    FModifyTable := nil;

  {load fields from table}
  FSQL.CreateFieldAliasesForTable(FTable2, lbxFields.Items);

  cbxTables.Items.Clear;
  
  {load tables}
  for liIndex := 0 to FSQL.SelectTableCount - 1 do
    begin
      lTable := FSQL.SelectTables[liIndex];

      if (lTable.SQLAlias <> FTable2.SQLAlias) then
        cbxTables.Items.AddObject(lTable.TableAlias, lTable);
    end;

  {default table}
  if (FTable1 <> nil) then
    cbxTables.ItemIndex := cbxTables.Items.IndexOf(FTable1.TableAlias);

  {load fields for default table}
  LoadJoinFields;

  {default join type}
  cbxJoinTypes.ItemIndex := Ord(FTable2.JoinType) - 1;

  {load joins}
  for liIndex := 0 to FTable2.TableJoinCount - 1 do
    begin
      lItem := FlvwJoins.Items.Add;

      lTableJoin := FTable2.TableJoins[liIndex];

      lItem.Caption := lTableJoin.LocalField.Description;
      lItem.SubItems.Add(daJoinOperatorToString(lTableJoin.Operator));
      lItem.SubItems.Add(lTableJoin.Expression);

      lItem.Data := lTableJoin;
    end;

  lbxFields.ItemIndex := -1;
  lbxJoinFields.ItemIndex := -1;

  EnableAddButton;

end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.Finalize }

procedure TdaJoinTableDialog.Finalize;
var
  lItem: TListItem;
  liIndex: Integer;
begin

  for liIndex := 0 to FlvwJoins.Items.Count - 1 do
    begin
      lItem := FlvwJoins.Items[liIndex];

      TdaTableJoin(lItem.Data).Parent := FTable2;
    end;

  if (FModifyTable <> nil) then
    FModifyTable.Assign(FTable2);

end; {procedure, Finalize}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.GetJoinCount }

function TdaJoinTableDialog.GetJoinCount: Integer;
begin
  Result := FlvwJoins.Items.Count;
end; {procedure, GetJoinCount}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.FormDestroy }

procedure TdaJoinTableDialog.FormDestroy(Sender: TObject);
begin

  {if modifying free copy of original table}
  if (FModifyTable <> nil) and (FTable2 <> nil) then
    FTable2.Free;

  daFreeChildrenInStrings(lbxFields.Items);
  daFreeChildrenInStrings(lbxJoinFields.Items);

end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.btnOKClick }

procedure TdaJoinTableDialog.btnOKClick(Sender: TObject);
begin

  if (FlvwJoins.Items.Count = 0) then
    begin
      ShowMessage(ppLoadStr(780)); {'Join fields have not been selected.'}

      Exit;
    end;

  Finalize;

  ModalResult := mrOK;

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.btnAddClick }

procedure TdaJoinTableDialog.btnAddClick(Sender: TObject);
var
  lField1: TdaField;
  lField2: TdaField;
begin

  lField1 := TdaField(lbxJoinFields.Items.Objects[lbxJoinFields.ItemIndex]);
  lField2 := TdaField(lbxFields.Items.Objects[lbxFields.ItemIndex]);

  AddJoin(lField1.FieldName, lField2.FieldName, dajoEqual);

end; {procedure, btnAddClick}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.lbxFieldsClick }

procedure TdaJoinTableDialog.lbxFieldsClick(Sender: TObject);
begin
  EnableAddButton;
end; {procedure, lbxFieldsClick}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.cbxTablesChange }

procedure TdaJoinTableDialog.cbxTablesChange(Sender: TObject);
var
  lTable: TdaTable;
begin

  {if table changed, clear join field list and joins}
  lTable := TdaTable(cbxTables.Items.Objects[cbxTables.ItemIndex]);

  if (CompareText(lTable.TableAlias, FTable1.TableAlias) <> 0) then
    begin

      FTable1 := FSQL.GetTableForSQLAlias(lTable.SQLAlias);

      SetForeignTableStrings;
      
      LoadJoinFields;
    end;

end; {procedure, cbxTablesChange}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.JoinsDblClickEvent }

procedure TdaJoinTableDialog.JoinsDblClickEvent(Sender: TObject);
begin
  if (FlvwJoins.Selected <> nil) then
    btnRemoveClick(Self);
end; {procedure, JoinsDblClickEvent}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.JoinsScrollEvent }

procedure TdaJoinTableDialog.JoinsScrollEvent(Sender: TObject);
begin
  cbxOperators.Visible := False;
  edtExpression.Visible := False;
end; {procedure, JoinsScrollEvent}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.JoinsColumnResizeEvent }

procedure TdaJoinTableDialog.JoinsColumnResizeEvent(aListView: TListView; aColumn: TListColumn);
begin
  if (FlvwJoins.Selected <> nil) then
    begin
      cbxOperators.Left := FlvwJoins.Columns[0].Width + 4;
      cbxOperators.Top := FlvwJoins.Top + FlvwJoins.Selected.Top;
      cbxOperators.Width := FlvwJoins.Columns[1].Width + 4;

      edtExpression.Left := cbxOperators.Left + cbxOperators.Width;
      edtExpression.Top := FlvwJoins.Top + FlvwJoins.Selected.Top;
      edtExpression.Width := FlvwJoins.Columns[2].Width - 2;

    end;
end; {procedure, JoinsColumnResizeEvent}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.JoinsClickEvent }

procedure TdaJoinTableDialog.JoinsClickEvent(Sender: TObject);
var
  lPoint: TPoint;
  lItem: TListItem;
begin

  GetCursorPos(lPoint);

  lPoint := FlvwJoins.ScreenToClient(lPoint);

  lItem := FlvwJoins.GetItemAt(2, lPoint.Y);

  if (FlvwJoins.Selected <> lItem) then
    FlvwJoins.Selected := lItem;

end; {procedure, JoinsClickEvent}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.JoinsSelectItemEvent }

procedure TdaJoinTableDialog.JoinsSelectItemEvent(Sender: TObject; Item: TListItem; Selected: Boolean);
begin

  if (Item = nil) or not(Selected) or (FlvwJoins.SelCount > 1) then
    begin
      cbxOperators.Visible := False;
      edtExpression.Visible := False;

      if (FlvwJoins.SelCount > 0) then
        btnRemove.Enabled := True
      else
        btnRemove.Enabled := False;
    end
  else
    begin
      cbxOperators.ItemIndex := Ord(TdaTableJoin(Item.Data).Operator);

      cbxOperators.Left := FlvwJoins.Columns[0].Width + 4;
      cbxOperators.Top := FlvwJoins.Top + Item.Top;
      cbxOperators.Width := FlvwJoins.Columns[1].Width + 4;
      cbxOperators.Visible := True;

      edtExpression.Left := cbxOperators.Left + cbxOperators.Width;
      edtExpression.Top := FlvwJoins.Top + Item.Top;
      edtExpression.Width := FlvwJoins.Columns[2].Width-2;
      edtExpression.Visible := True;

      edtExpression.Text := Item.SubItems[1];

      btnRemove.Enabled := True;
    end;

end; {procedure, JoinsSelectItemEvent}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.cbxJoinTypesChange }

procedure TdaJoinTableDialog.cbxJoinTypesChange(Sender: TObject);
begin
  FTable2.JoinType := TdaJoinType(cbxJoinTypes.ItemIndex + 1);
end; {procedure, cbxJoinTypesChange}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.cbxOperatorsChange }

procedure TdaJoinTableDialog.cbxOperatorsChange(Sender: TObject);
begin

  if (FlvwJoins.Selected = nil) then Exit;

  TdaTableJoin(FlvwJoins.Selected.Data).Operator := TdaJoinOperatorType(cbxOperators.ItemIndex);

  FlvwJoins.Selected.SubItems[0] := cbxOperators.Items[cbxOperators.ItemIndex];

end; {procedure, cbxOperatorsChange}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.btnRemoveClick }

procedure TdaJoinTableDialog.btnRemoveClick(Sender: TObject);
var
  liIndex: Integer;
  lList: TList;
  lItem: TListItem;
begin

  lItem := FlvwJoins.Selected;

  if (lItem = nil) then Exit;

  FlvwJoins.Items.BeginUpdate;

  lList := TList.Create;

  while (lItem <> nil) do
    begin
      lList.Add(lItem);

      lItem := FlvwJoins.GetNextItem(lItem, sdAll, [isSelected]);
    end;

  for liIndex := 0 to lList.Count - 1 do
    begin
      lItem := TListItem(lList[liIndex]);

      TdaTableJoin(lItem.Data).Free;

      lItem.Free;
    end;

  lList.Free;

  FlvwJoins.Items.EndUpdate;

end; {procedure, btnRemoveClick}

{******************************************************************************
 *
 ** R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.AddJoin }

procedure TdaJoinTableDialog.AddJoin(const aField1, aField2: String; aOperator: TdaJoinOperatorType);
var
  lItem: TListItem;
  lTableJoin: TdaTableJoin;
begin
  lTableJoin := FTable2.AddTableJoin(FTable1, aField1, aField2, aOperator);

  lTableJoin.Parent := nil;

  lItem := FlvwJoins.Items.Add;

  lItem.Caption := lTableJoin.LocalField.Description;
  lItem.SubItems.Add(daJoinOperatorToString(lTableJoin.Operator));
  lItem.SubItems.Add(lTableJoin.ForeignField.Description);

  lItem.Data := lTableJoin;

  lbxFields.ItemIndex := -1;
  lbxJoinFields.ItemIndex := -1;

  EnableAddButton;

end; {procedure, AddJoin}

procedure TdaJoinTableDialog.EditExpressionEnd;
var
  lTableJoin: TdaTableJoin;
begin
  if (FlvwJoins.Selected = nil) then Exit;

  lTableJoin := TdaTableJoin(FlvwJoins.Selected.Data);

  if (edtExpression.Text <> lTableJoin.Expression) then
    begin
      lTableJoin.Expression := edtExpression.Text;
      FlvwJoins.Selected.SubItems[1] := edtExpression.Text;
    end;

end;

procedure TdaJoinTableDialog.edtExpressionExit(Sender: TObject);
begin
  EditExpressionEnd;
end;

procedure TdaJoinTableDialog.edtExpressionKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    begin
      Key := #0;
      EditExpressionEnd;
    end;

end;


{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.LoadJoinFields }

procedure TdaJoinTableDialog.LoadJoinFields;
begin
  daFreeChildrenInStrings(lbxJoinFields.Items);

  FSQL.CreateFieldAliasesForTable(FTable1, lbxJoinFields.Items);
end; {procedure, LoadJoinFields}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.EnableAddButton }

procedure TdaJoinTableDialog.EnableAddButton;
begin
  btnAdd.Enabled := (lbxFields.ItemIndex >= 0) and (lbxJoinFields.ItemIndex >= 0) and
                    (lbxFields.Selected[lbxFields.ItemIndex]) and
                    (lbxJoinFields.Selected[lbxJoinFields.ItemIndex]);
end; {procedure, EnableAddButton}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.SetStrings }

procedure TdaJoinTableDialog.SetStrings;
var
  liJoin: Integer;
  lOperator: TdaJoinOperatorType;
  lsMessage: String;
begin

  Caption := ppLoadStr(781); {Join Table}

  btnAdd.Caption := ppLoadStr(713); {Add}
  btnRemove.Caption := ppLoadStr(813); {Add}

  btnOK.Caption := ppLoadStr(ppMsgOK); {OK}
  btnCancel.Caption := ppLoadStr(ppMsgCancel); {Cancel}

  lblLocalTable.Caption := FTable2.TableAlias + ' ' + ppLoadStr(763); {Fields}

  SetForeignTableStrings;

  {Join <name> with}
  lsMessage := ppLoadStr(779);
  lsMessage := ppSetMessageParameters(lsMessage);
  lsMessage := Format(lsMessage, [FTable2.TableAlias]);
  lblJoinTable.Caption := lsMessage;

  lblJoinType.Caption := ppLoadStr(782); {Join Type}

  lblJoinedFields.Caption := ppLoadStr(783); {Joined Fields}

  FlvwJoins.Columns[0].Caption := FTable2.TableAlias + ' ' + ppLoadStr(760); {Field}
  FlvwJoins.Columns[1].Caption := ppLoadStr(802); {Operator}

  cbxJoinTypes.Items.Clear;

  for liJoin := Ord(dajtInner) to Ord(dajtRightOuter) do
    cbxJoinTypes.Items.Add(daGetJoinDesc(TdaJoinType(liJoin)));

  cbxOperators.Items.Clear;

  for lOperator := Low(TdaJoinOperatorType) to High(TdaJoinOperatorType) do
    cbxOperators.Items.Add(daJoinOperatorToString(lOperator));

end; {procedure, SetStrings}

{------------------------------------------------------------------------------}
{ TdaJoinTableDialog.SetForeignTableStrings }

procedure TdaJoinTableDialog.SetForeignTableStrings;
begin

  if (FTable1 <> nil) then
    lblForeignTable.Caption := FTable1.TableAlias + ' ' + ppLoadStr(763) {Fields}
  else
    lblForeignTable.Caption := ppLoadStr(763); {Fields}

{ // removed old caption that displayed field, could add a caption like this
  FlvwJoins.Columns[2].Caption := 'Expression';
}

end; {procedure, SetForeignTableStrings}


end.
