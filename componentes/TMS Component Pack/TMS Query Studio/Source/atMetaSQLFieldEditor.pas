unit atMetaSQLFieldEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  atMetaSQLCustomEditor, ActnList, ComCtrls, StdCtrls, ExtCtrls, atPanel,
  atMetaSQL, DB, atListBoxDlg, Menus, atCheckListEdit;

type
  TfmMetaSQLFieldEditor = class(TfmMetaSQLCustomEditor)
    edDisplayLabel: TEdit;
    Label1: TLabel;
    cbTableAlias: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    cbFieldName: TComboBox;
    Label4: TLabel;
    cbGroupFunction: TComboBox;
    Label5: TLabel;
    cbDataType: TComboBox;
    edFieldAlias: TEdit;
    Label6: TLabel;
    btLoad: TButton;
    ldPickDataset: TatListBoxDlg;
    acAppendDataset: TAction;
    Button1: TButton;
    acAppendTable: TAction;
    acTableAlias: TAction;
    Settablealias1: TMenuItem;
    Label7: TLabel;
    edFieldExpression: TEdit;
    Label8: TLabel;
    cbExpressionType: TComboBox;
    Label10: TLabel;
    cbVisible: TComboBox;
    ceOptions: TatCheckListEdit;
    lbOptions: TLabel;
    procedure cbTableAliasEnter(Sender: TObject);
    procedure cbTableAliasExit(Sender: TObject);
    procedure cbFieldNameExit(Sender: TObject);
    procedure cbFieldNameEnter(Sender: TObject);
    procedure edFieldAliasEnter(Sender: TObject);
    procedure acAppendDatasetExecute(Sender: TObject);
    procedure acAppendDatasetUpdate(Sender: TObject);
    procedure acAppendTableUpdate(Sender: TObject);
    procedure acAppendTableExecute(Sender: TObject);
    procedure acTableAliasUpdate(Sender: TObject);
    procedure acTableAliasExecute(Sender: TObject);
    procedure cbExpressionTypeClick(Sender: TObject);
    procedure edFieldAliasExit(Sender: TObject);
  private
    FOldTableName: string;
    FOldFieldName: string;
    FOldFieldAlias: string;
    procedure UpdateFieldExpressionEditor;
    procedure FillItemOptions;
    procedure LoadOptionsInEditor(AField: TatSQLField);
    procedure SaveEditorInOptions(AField: TatSQLField);
    procedure Localize;
  protected
    procedure FocusFirstEditor; override;
    procedure AssociateItems; override;
    procedure ClearEditors; override;
    function GetMainCaption(AItem: TCollectionItem):string; override;
    function GetSubItems(AItem: TCollectionItem; ASubItems: TStrings):string; override;
    procedure SaveEditorsInItem(AItem: TCollectionItem); override;
    procedure LoadItemInEditors(AItem: TCollectionItem); override;
    procedure Loaded; override;
  public
    procedure ActivateEditor; override;
  end;

implementation

uses
  TypInfo, qsRes;

{$R *.DFM}

{ TfmMetaSQLCustomEditor1 }

procedure TfmMetaSQLFieldEditor.ActivateEditor;
begin
   inherited;
   FillTableAliasList(cbTableAlias.Items);
   FillItemOptions;
end;

procedure TfmMetaSQLFieldEditor.FillItemOptions;
var c: TatSQLFieldOption;
begin
   if ceOptions.Items.Count=0 then
      for c:=Low(TatSQLFieldOption) to High(TatSQLFieldOption) do
         ceOptions.Items.Add(GetEnumName(TypeInfo(TatSQLFieldOption),Ord(c)));
end;

procedure TfmMetaSQLFieldEditor.LoadOptionsInEditor(AField: TatSQLField);
var c: TatSQLFieldOption;
begin
   FillItemOptions;
   for c:=Low(TatSQLFieldOption) to High(TatSQLFieldOption) do
      if c in AField.Options then
         ceOptions.Checked[Ord(c)]:=true
      else
         ceOptions.Checked[Ord(c)]:=false;
end;

procedure TfmMetaSQLFieldEditor.SaveEditorInOptions(AField: TatSQLField);
var c: TatSQLFieldOption;
begin
   FillItemOptions;
   AField.Options:=[];
   for c:=Low(TatSQLFieldOption) to High(TatSQLFieldOption) do
      if ceOptions.Checked[Ord(c)] then
         AField.Options:=AField.Options + [c];
end;

procedure TfmMetaSQLFieldEditor.AssociateItems;
begin
   Items:=MetaSQL.SQLFields;
end;

procedure TfmMetaSQLFieldEditor.ClearEditors;
begin
   cbTableAlias.Text:='';
   cbFieldName.Text:='';
   edFieldAlias.Text:='';
   edDisplayLabel.Text:='';
   cbDataType.Text:='';
   edFieldExpression.Text:='';
   cbGroupFunction.ItemIndex:=0;
   cbVisible.ItemIndex:=0;
   cbExpressionType.ItemIndex:=0;
end;

procedure TfmMetaSQLFieldEditor.FocusFirstEditor;
begin
   cbTableAlias.SetFocus;
end;

function TfmMetaSQLFieldEditor.GetMainCaption(
  AItem: TCollectionItem): string;
begin
   result:=TatSQLField(AItem).FieldAlias;
end;

function TfmMetaSQLFieldEditor.GetSubItems(AItem: TCollectionItem;
  ASubItems: TStrings): string;
begin
   With TatSQLField(AItem) do
   begin
      ASubItems.Add(BuildTableID(TableAlias));
      ASubItems.Add(FieldName);
      ASubItems.Add(GetEnumName(TypeInfo(TFieldType),Ord(DataType)));
      ASubItems.Add(DisplayLabel);
      ASubItems.Add(cbGroupFunction.Items[Ord(GroupFunction)]);
      ASubItems.Add(GetEnumName(TypeInfo(TatSQLFieldExprType),Ord(ExpressionType)));
      ASubItems.Add(FieldExpression);
      ASubItems.Add(GetEnumName(TypeInfo(boolean),Ord(Visible)));

      ASubItems.Add(GetEnumName(TypeInfo(boolean),ord(foHiddenFromuser in Options)));
      ASubItems.Add(GetEnumName(TypeInfo(boolean),ord(foAlwaysInSelect in Options)));
      ASubItems.Add(GetEnumName(TypeInfo(boolean),ord(foCanOrderBy in Options)));
      ASubItems.Add(GetEnumName(TypeInfo(boolean),ord(foCanUseInCondition in Options)));
   end;
end;

procedure TfmMetaSQLFieldEditor.LoadItemInEditors(
  AItem: TCollectionItem);
begin
  With TatSQLField(AItem) do
  begin
     edFieldAlias.Text:=FieldAlias;
     cbTableAlias.Text:=BuildTableID(TableAlias);
     cbFieldName.Text:=FieldName;
     edDisplayLabel.Text:=DisplayLabel;
     cbDataType.Text:=GetEnumName(TypeInfo(TFieldType),Ord(DataType));
     cbGroupFunction.ItemIndex:=Ord(GroupFunction);
     cbExpressionType.ItemIndex:=Ord(ExpressionType);
     edFieldExpression.Text:=FieldExpression;
     cbVisible.ItemIndex:=Ord(Visible);
     LoadOptionsInEditor(TatSQLField(AItem));
     UpdateFieldExpressionEditor;
  end;
end;

procedure TfmMetaSQLFieldEditor.SaveEditorsInItem(
  AItem: TCollectionItem);
var EnumValue: integer;
begin
  With TatSQLField(AItem) do
  begin
     FieldAlias:=edFieldAlias.Text;
     TableAlias:=AliasFromTableID(cbTableAlias.Text);
     FieldName:=cbFieldName.Text;
     DisplayLabel:=edDisplayLabel.Text;
     EnumValue:=GetEnumValue(TypeInfo(TFieldType),cbDataType.Text);
     if EnumValue<0 then
        raise EPropertyConvertError.Create(_str(SInvalidFieldType));
     DataType:=TFieldType(EnumValue);
     GroupFunction:=TatSQLGroupFunction(cbGroupFunction.ItemIndex);
     ExpressionType:=TatSQLFieldExprType(cbExpressionType.ItemIndex);
     Visible:=cbVisible.ItemIndex<>0;
     FieldExpression:=edFieldExpression.Text;
     SaveEditorInOptions(TatSQLField(AItem));
  end;
end;

procedure TfmMetaSQLFieldEditor.cbTableAliasEnter(Sender: TObject);
begin
  inherited;
  FOldTableName:=TableNameFromAlias(AliasFromTableID(cbTableAlias.Text));
end;

procedure TfmMetaSQLFieldEditor.cbTableAliasExit(Sender: TObject);
Var NewTableName: string;
begin
  NewTableName:=TableNameFromAlias(AliasFromTableID(cbTableAlias.Text));
  if AnsiCompareText(NewTableName,FOldTableName)<>0 then
     FillFieldNameList(NewTableName,cbFieldName.Items);
end;

procedure TfmMetaSQLFieldEditor.UpdateFieldExpressionEditor;
begin
   edFieldExpression.ReadOnly:=
      (cbExpressionType.ItemIndex<>Ord(etCustomExpr));
end;

procedure TfmMetaSQLFieldEditor.cbFieldNameExit(Sender: TObject);
Var i: integer;
begin
  inherited;
  if (edFieldAlias.Text=FOldFieldName) or (edFieldAlias.Text='') then
     edFieldAlias.Text:=cbFieldName.Text;
  if (edDisplayLabel.Text=FOldFieldName) or (edDisplayLabel.Text='') then
     edDisplayLabel.Text:=cbFieldName.Text;

  i:=cbFieldName.Items.IndexOf(cbFieldName.Text);
  if i>=0 then
  begin
     i:=Integer(cbFieldName.Items.Objects[i]);
     cbDataType.Text:=GetEnumName(TypeInfo(TFieldType),i);
  end;
end;

procedure TfmMetaSQLFieldEditor.cbFieldNameEnter(Sender: TObject);
begin
  inherited;
  FOldFieldName:=cbFieldName.Text;
end;

procedure TfmMetaSQLFieldEditor.edFieldAliasEnter(Sender: TObject);
begin
  inherited;
  FOldFieldAlias:=edFieldAlias.Text;
end;

procedure TfmMetaSQLFieldEditor.edFieldAliasExit(Sender: TObject);
begin
  inherited;
  if (edDisplayLabel.Text=FOldFieldAlias) or (edDisplayLabel.Text='') then
     edDisplayLabel.Text:=edFieldAlias.Text;
end;

procedure TfmMetaSQLFieldEditor.acAppendDatasetExecute(Sender: TObject);

   procedure FillDatasetList(AItems: TStrings);
   var c, d: integer;
   begin
      for c:=0 to Screen.FormCount-1 do
         With Screen.Forms[c] do
            for d:=0 to ComponentCount-1 do
               if Components[d] is TDataset then
                  if (Trim(Screen.Forms[c].Name)<>'') and
                     (Screen.Forms[c]<>MetaSQLOwner) then
                     AItems.AddObject(Format('%s.%s',[Screen.Forms[c].Name,
                        Components[d].Name]),Components[d])
                  else
                     AItems.AddObject(Components[d].Name,Components[d]);
      for c:=0 to Screen.DataModuleCount-1 do
         With Screen.DataModules[c] do
            for d:=0 to ComponentCount-1 do
               if Components[d] is TDataset then
                  if (Trim(Screen.DataModules[c].Name)<>'') and
                     (Screen.Datamodules[c]<>MetaSQLOwner) then
                     AItems.AddObject(Format('%s.%s',[Screen.Datamodules[c].Name,
                        Components[d].Name]),Components[d])
                  else
                     AItems.AddObject(Components[d].Name,Components[d]);
   end;

begin
   ldPickDataset.Items.Clear;
   FillDatasetList(ldPickDataset.Items);
   if ldPickDataset.Execute then
   begin
      if ldPickDataset.ItemIndex>=0 then
      begin
         MetaSQL.SQLFields.AddFromFields(TDataset(
            ldPickDataset.Items.Objects[ldPickDataset.ItemIndex]).Fields);
         UpdateList;
      end;
   end;
end;

procedure TfmMetaSQLFieldEditor.acAppendDatasetUpdate(Sender: TObject);
begin
  inherited;
  acAppendDataset.Enabled:=acNew.Enabled;
end;

procedure TfmMetaSQLFieldEditor.acAppendTableUpdate(Sender: TObject);
begin
  inherited;
  acAppendTable.Enabled:=acNew.Enabled;
end;

procedure TfmMetaSQLFieldEditor.acAppendTableExecute(Sender: TObject);
Var c: integer;
    AFields: TStrings;
begin
   ldPickDataset.Items.Clear;
   FillTableNames(ldPickDataset.Items);
   if ldPickDataset.Execute then
   begin
      if ldPickDataset.ItemIndex>=0 then
      begin
         AFields:=TStringList.Create;
         try
            FillFieldNameList(ldPickDataset.Items[ldPickDataset.ItemIndex],AFields);
            for c:=0 to AFields.Count-1 do
            begin
               With MetaSQL.SQLFields.Add do
               begin
                  DataType:=TFieldType(Integer(AFields.Objects[c]));
                  FieldName:=AFields[c];
                  FieldAlias:=AFields[c];
                  TableAlias:='';
                  GroupFunction:=agfNone;
                  DisplayLabel:=AFields[c];
               end;
            end;
            UpdateList;
         finally
             AFields.Free;
         end;
      end;
   end;
end;

procedure TfmMetaSQLFieldEditor.acTableAliasUpdate(Sender: TObject);
begin
  inherited;
  acTableAlias.Enabled:=acNew.Enabled;
end;

procedure TfmMetaSQLFieldEditor.acTableAliasExecute(Sender: TObject);
var c: integer;
    ATableAlias: string;
begin
   if InputQuery(_str(SSetTableAlias),_str(SEnterTableAlias),ATableAlias) then
   begin
      for c:=0 to lvItems.Items.Count-1 do
         if lvItems.Items[c].Selected then
         begin
            With TatSQLField(lvItems.Items[c].Data) do
            begin
               TableAlias:=ATableAlias;
            end;
         end;
      UpdateList;
   end;
end;

procedure TfmMetaSQLFieldEditor.cbExpressionTypeClick(Sender: TObject);
begin
   UpdateFieldExpressionEditor;
end;

procedure TfmMetaSQLFieldEditor.Localize;
begin
  Label1.Caption := _str('fmMetaSQLFieldEditor.Label1.Caption');
  Label2.Caption := _str('fmMetaSQLFieldEditor.Label2.Caption');
  Label3.Caption := _str('fmMetaSQLFieldEditor.Label3.Caption');
  Label4.Caption := _str('fmMetaSQLFieldEditor.Label4.Caption');
  Label5.Caption := _str('fmMetaSQLFieldEditor.Label5.Caption');
  Label6.Caption := _str('fmMetaSQLFieldEditor.Label6.Caption');
  Label7.Caption := _str('fmMetaSQLFieldEditor.Label7.Caption');
  Label8.Caption := _str('fmMetaSQLFieldEditor.Label8.Caption');
  Label10.Caption := _str('fmMetaSQLFieldEditor.Label10.Caption');
  lbOptions.Caption := _str('fmMetaSQLFieldEditor.lbOptions.Caption');
  lvItems.Items[0].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items0.Caption');
  lvItems.Items[1].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items1.Caption');
  lvItems.Items[2].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items2.Caption');
  lvItems.Items[3].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items3.Caption');
  lvItems.Items[4].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items4.Caption');
  lvItems.Items[5].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items5.Caption');
  lvItems.Items[6].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items6.Caption');
  lvItems.Items[7].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items7.Caption');
  lvItems.Items[8].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items8.Caption');
  lvItems.Items[9].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items9.Caption');
  lvItems.Items[10].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items10.Caption');
  lvItems.Items[11].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items11.Caption');
  lvItems.Items[12].Caption := _str('fmMetaSQLFieldEditor.lvItems.Items12.Caption');
  acAppendDataset.Caption := _str('fmMetaSQLFieldEditor.acAppendDataset.Caption');
  acAppendTable.Caption := _str('fmMetaSQLFieldEditor.acAppendTable.Caption');
  acTableAlias.Caption := _str('fmMetaSQLFieldEditor.acTableAlias.Caption');
  ldPickDataset.CancelCaption := _str('fmMetaSQLFieldEditor.ldPickDataset.CancelCaption');
  ldPickDataset.OkCaption := _str('fmMetaSQLFieldEditor.ldPickDataset.OkCaption');
  ldPickDataset.Title := _str('fmMetaSQLFieldEditor.ldPickDataset.Title');
end;

procedure TfmMetaSQLFieldEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

