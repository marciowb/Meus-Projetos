unit fSingleFieldEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls,
  DB, TypInfo, atMetaSql, fCustomFieldEditor, uDBUtil;

type
  TfmSingleFieldEditor = class(TfmCustomFieldEditor)
    pnTableName: TPanel;
    Label1: TLabel;
    edTable: TComboBox;
    pnFieldName: TPanel;
    Label2: TLabel;
    edFieldName: TComboBox;
    pnAggregation: TPanel;
    Label4: TLabel;
    edAggregation: TComboBox;
    pnFieldAlias: TPanel;
    Label3: TLabel;
    edFieldAlias: TEdit;
    pnDisplayLabel: TPanel;
    Label5: TLabel;
    edDisplayLabel: TEdit;
    pnDataType: TPanel;
    Label7: TLabel;
    edDataType: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure edFieldNameExit(Sender: TObject);
    procedure edFieldAliasExit(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edTableChange(Sender: TObject);
    procedure edFieldNameChange(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmSingleFieldEditor: TfmSingleFieldEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmSingleFieldEditor.FormShow(Sender: TObject);
var c: integer;
begin
   inherited;

   { carrega a lista de tabelas disponíveis }
   edTable.Items.BeginUpDate;
   try
      edTable.Items.Clear;
      with MetaSqlDef.MetaSql.SqlTables do
         for c:=0 to Count-1 do
            with Items[c] do
               edTable.Items.AddObject(Format('%s (%s)',[TableName,TableAlias]),Items[c]);
   finally
      edTable.Items.EndUpdate;
   end;

   { carrega os tipos de campos disponíveis }
   edDataType.Items.BeginUpdate;
   try
      edDataType.Items.Clear;
      for c:=0 to ord(high(TFieldType)) do
         if (TFieldType(c) in ftAllowedFieldTypes) then
            edDataType.Items.AddObject(GetEnumName(TypeInfo(TFieldType),c), TObject(c));
      edDataType.ItemIndex := 0;
   finally
      edDataType.Items.EndUpdate;
   end;
end;

procedure TfmSingleFieldEditor.edFieldNameExit(Sender: TObject);
begin
   inherited;
   if edFieldAlias.Text='' then
      edFieldAlias.Text := edFieldName.Text;
end;

procedure TfmSingleFieldEditor.edFieldAliasExit(Sender: TObject);
begin
   inherited;
   if edDisplayLabel.Text='' then
      edDisplayLabel.Text := edFieldAlias.Text;
end;

procedure TfmSingleFieldEditor.btOkClick(Sender: TObject);
begin
   inherited;

   with MetaSqlDef.MetaSql do
   begin
      { verifica se a tabela foi informada }
      ValidationError(
         (edTable.ItemIndex=-1),
         _str(STableNotIndicated),
         [edTable.Text],
         edTable );

      { verifica se o nome do campo foi informado quando for campo simples }
      ValidationError(
         (edFieldName.Text=''),
         _str(SFieldNameNotIndicated),
         [edFieldName.Text],
         edFieldName );

      { verifica se o tipo de dados foi fornecido }
      ValidationError(
         (edDataType.ItemIndex=-1),
         _str(SDataTypeNotIndicated),
         [edDataType.Text],
         edDataType );

      { verifica se o tipo de função de agregação é válido }
      ValidationError(
         (edAggregation.ItemIndex>1) and not(TFieldType(edDataType.Items.Objects[edDataType.ItemIndex]) in ftAggregFieldTypes),
         _str(SAggregationFunctionNotAllowed),
         [edAggregation.Text, edDataType.Text],
         edAggregation );

      { verifica se o nome do campo foi informado }
      ValidationError(
         edFieldAlias.Text='',
         _str(SFieldAliasNotIndicated),
         [edFieldAlias.Text],
         edFieldAlias );

      { verifica se o nome do campo não está repetido }
      ValidationError(
         MetaSqlDef.MetaSql.SqlFields.FindByAlias(edFieldAlias.Text)<>nil,
         _str(SFieldAliasNotUnique),
         [edFieldAlias.Text],
         edFieldAlias );

      { inclui o novo campo na meta-sql }
      EditedObject := MetaSqlDef.MetaSql.SqlFields.Add;
      with TatSqlField(EditedObject) do
      begin
         ExpressionType := etStandard;
         TableAlias := TatSqlTable(edTable.Items.Objects[edTable.ItemIndex]).TableAlias;
         FieldName := edFieldName.Text;
         if edAggregation.ItemIndex>0 then
            GroupFunction := TatSQLGroupFunction(edAggregation.ItemIndex);
         {$IFDEF TMSDOTNET}
         DataType := TFieldType(integer(edDataType.Items.Objects[edDataType.ItemIndex]));
         {$ELSE}
         DataType := TFieldType(edDataType.Items.Objects[edDataType.ItemIndex]);
         {$ENDIF}
         FieldAlias := edFieldAlias.Text;
         DisplayLabel := edDisplayLabel.Text;
         Active := True;
         Visible := True;
         Options := [foCanOrderBy, foCanUseInCondition];
     end;
   end;
end;

procedure TfmSingleFieldEditor.edTableChange(Sender: TObject);
begin
  inherited;
  with edTable do
    if ItemIndex>-1 then
      LoadFieldNameList( TatSqlTable(Items.Objects[ItemIndex]).TableName, edFieldName.Items )
    else
      edFieldName.Clear;
end;

procedure TfmSingleFieldEditor.edFieldNameChange(Sender: TObject);
begin
  inherited;
  with edFieldName do
    if ItemIndex>-1 then
      edDataType.ItemIndex := edDataType.Items.IndexOf( GetEnumName( TypeInfo(TFieldType), integer(Items.Objects[ItemIndex]) ));
end;

procedure TfmSingleFieldEditor.Localize;
begin
  Self.Caption := _str('fmSingleFieldEditor.Self.Caption');
  Label1.Caption := _str('fmSingleFieldEditor.Label1.Caption');
  Label2.Caption := _str('fmSingleFieldEditor.Label2.Caption');
  Label4.Caption := _str('fmSingleFieldEditor.Label4.Caption');
  edAggregation.Items.Clear;
  edAggregation.Items.Add(_str('fmSingleFieldEditor.edAggregation.Items0'));
  edAggregation.Items.Add(('fmSingleFieldEditor.edAggregation.Items1'));
  edAggregation.Items.Add(_str('fmSingleFieldEditor.edAggregation.Items2'));
  edAggregation.Items.Add(_str('fmSingleFieldEditor.edAggregation.Items3'));
  edAggregation.Items.Add(_str('fmSingleFieldEditor.edAggregation.Items4'));
  edAggregation.Items.Add(_str('fmSingleFieldEditor.edAggregation.Items5'));
  Label3.Caption := _str('fmSingleFieldEditor.Label3.Caption');
  Label5.Caption := _str('fmSingleFieldEditor.Label5.Caption');
  Label7.Caption := _str('fmSingleFieldEditor.Label7.Caption');
  edDataType.Items.Clear;
  edDataType.Items.Add(_str('fmSingleFieldEditor.edDataType.Items0'));
  edDataType.Items.Add(_str('fmSingleFieldEditor.edDataType.Items1'));
  edDataType.Items.Add(_str('fmSingleFieldEditor.edDataType.Items2'));
  edDataType.Items.Add(_str('fmSingleFieldEditor.edDataType.Items3'));
  edDataType.Items.Add(_str('fmSingleFieldEditor.edDataType.Items4'));
  edDataType.Items.Add(_str('fmSingleFieldEditor.edDataType.Items5'));
  lbInfo.Caption := _str('fmSingleFieldEditor.lbInfo.Caption');
end;

procedure TfmSingleFieldEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
