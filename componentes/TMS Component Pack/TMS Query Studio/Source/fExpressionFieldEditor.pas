unit fExpressionFieldEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls,
  DB, TypInfo, atMetaSql, fCustomFieldEditor;

type
  TfmExpressionFieldEditor = class(TfmCustomFieldEditor)
    pnAggregation: TPanel;
    Label4: TLabel;
    edAggregation: TComboBox;
    pnExpression: TPanel;
    Label6: TLabel;
    edExpression: TEdit;
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
    procedure edFieldAliasExit(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmExpressionFieldEditor: TfmExpressionFieldEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmExpressionFieldEditor.FormShow(Sender: TObject);
var c: integer;
begin
   inherited;

   { carrega os tipos de campos disponíveis }
   edDataType.Items.BeginUpdate;
   try
      edDataType.Items.Clear;
      for c:=0 to ord(high(TFieldType)) do
         if (TFieldType(c) in ftAllowedFieldTypes) then
            edDataType.Items.AddObject(GetEnumName(TypeInfo(TFieldType),c),TObject(c));
      edDataType.ItemIndex := 0;
   finally
      edDataType.Items.EndUpdate;
   end;
end;

procedure TfmExpressionFieldEditor.edFieldAliasExit(Sender: TObject);
begin
   inherited;
   if edDisplayLabel.Text='' then
      edDisplayLabel.Text:=edFieldAlias.Text;
end;

procedure TfmExpressionFieldEditor.btOkClick(Sender: TObject);
begin
   inherited;

   with MetaSqlDef.MetaSql do
   begin
      { verifica se a expressão do campo foi informada }
      ValidationError(
         (edExpression.Text=''),
         _str(SFieldExpressionNotIndicated),
         [],
         edExpression );

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
         ExpressionType := etCustomExpr;
         FieldExpression := edExpression.Text;
         if edAggregation.ItemIndex>0 then
            GroupFunction := TatSQLGroupFunction(edAggregation.ItemIndex);
         {$IFDEF TMSDOTNET}
         DataType := TFieldType(integer(edDataType.Items.Objects[edDataType.ItemIndex]));
         {$ELSE}
         DataType := TFieldType(edDataType.Items.Objects[edDataType.ItemIndex]);
         {$ENDIF}
         DisplayLabel := edDisplayLabel.Text;
         FieldAlias := edFieldAlias.Text;
         Active := True;
         Visible := True;
         Options := [foCanOrderBy, foCanUseInCondition];
     end;
   end;
end;

procedure TfmExpressionFieldEditor.Localize;
begin
  Self.Caption := _str('fmExpressionFieldEditor.Self.Caption');
  Label4.Caption := _str('fmExpressionFieldEditor.Label4.Caption');
  edAggregation.Items.Clear;
  edAggregation.Items.Add(_str('fmExpressionFieldEditor.edAggregation.Items0'));
  edAggregation.Items.Add(_str('fmExpressionFieldEditor.edAggregation.Items1'));
  edAggregation.Items.Add(_str('fmExpressionFieldEditor.edAggregation.Items2'));
  edAggregation.Items.Add(_str('fmExpressionFieldEditor.edAggregation.Items3'));
  edAggregation.Items.Add(_str('fmExpressionFieldEditor.edAggregation.Items4'));
  edAggregation.Items.Add(_str('fmExpressionFieldEditor.edAggregation.Items5'));
  Label6.Caption := _str('fmExpressionFieldEditor.Label6.Caption');
  Label3.Caption := _str('fmExpressionFieldEditor.Label3.Caption');
  Label5.Caption := _str('fmExpressionFieldEditor.Label5.Caption');
  Label7.Caption := _str('fmExpressionFieldEditor.Label7.Caption');
  edDataType.Items.Clear;
  edDataType.Items.Add(_str('fmExpressionFieldEditor.edDataType.Items0'));
  edDataType.Items.Add(_str('fmExpressionFieldEditor.edDataType.Items1'));
  edDataType.Items.Add(_str('fmExpressionFieldEditor.edDataType.Items2'));
  edDataType.Items.Add(_str('fmExpressionFieldEditor.edDataType.Items3'));
  edDataType.Items.Add(_str('fmExpressionFieldEditor.edDataType.Items4'));
  edDataType.Items.Add(_str('fmExpressionFieldEditor.edDataType.Items5'));
  lbInfo.Caption := _str('fmExpressionFieldEditor.lbInfo.Caption');
end;

procedure TfmExpressionFieldEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

