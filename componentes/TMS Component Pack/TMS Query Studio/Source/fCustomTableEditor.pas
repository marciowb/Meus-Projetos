unit fCustomTableEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Menus, atMetaSql, uDBUtil,
  {$IFDEF DELPHI6_LVL}
  Variants,
  {$ENDIF}
  fCustomEditor;

type
  TfmCustomTableEditor = class(TfmCustomEditor)
    pnTableName: TPanel;
    Label1: TLabel;
    edTableName: TComboBox;
    pnTableAlias: TPanel;
    Label2: TLabel;
    edTableAlias: TEdit;
    pnJoinType: TPanel;
    Label4: TLabel;
    edJoinType: TComboBox;
    pnJoinCondition: TPanel;
    Label3: TLabel;
    edJoinCondition: TEdit;
    procedure edTableNameExit(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ValidateConditionFields(ACond: TatSqlConditions);
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmCustomTableEditor: TfmCustomTableEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCustomTableEditor.edTableNameExit(Sender: TObject);
begin
   inherited;
   if edTableAlias.Text='' then
      edTableAlias.Text := PrettyText(RemoveNameExt(edTableName.Text));
end;

procedure TfmCustomTableEditor.ValidateConditionFields( ACond:TatSqlConditions );
var c: integer;

   function fieldByExpression(AField:TatSqlField):string;
   var c: integer;
   begin
      { retorna o FieldAlias correspondente ao campo dado }

      { procura pelo conteúdo do campo }
      with MetaSqlDef.MetaSQL.SqlFields do
         for c:=0 to Count-1 do
            with Items[c] do
               if SameText(TableAlias,AField.TableAlias) and
                  SameText(FieldName,AField.FieldName) and
                  (GroupFunction=AField.GroupFunction) and
                  (ExpressionType=AField.ExpressionType) and
                  ((ExpressionType<>etCustomExpr) or SameText(FieldExpression,AField.FieldExpression)) then
               begin
                  { encontrou então retorna seu FieldAlias }
                  result := Items[c].FieldAlias;
                  Exit;
               end;

      { não encontrou então cria o campo com base no campo dado }
      with MetaSqlDef.MetaSql.SqlFields.Add do
      begin
         Assign(AField);
         { evita repetição de FieldAlias }

         /// *** não implementado

         result := FieldAlias;
      end;
   end;

begin
   { raliza todos os ajustes necessários para que os campos usados
    na meta-sql auxiliar façam referência a campos da sql-principal }

   for c:=0 to ACond.Count-1 do
      with ACond[c] do
      begin
         { substitui campos e parêmtros contidos das condições }
         case ConditionType of
            ctFieldCompare:
               begin
                  FieldAlias := fieldByExpression( ACond.MetaSql.SqlFields.FindByAlias(FieldAlias) );
                  Value := fieldByExpression( ACond.MetaSql.SqlFields.FindByAlias(VarToStr(Value)) );
               end;
            ctParamCompare:
               FieldAlias := fieldByExpression( ACond.MetaSql.SqlFields.FindByAlias(FieldAlias) );
            ctValueCompare:
               FieldAlias := fieldByExpression( ACond.MetaSql.SqlFields.FindByAlias(FieldAlias) );
            ctSubConditions:
               { valida recursivamente todas as condições }
               ValidateConditionFields( SubConditions );
         end;
      end;
end;

procedure TfmCustomTableEditor.btOkClick(Sender: TObject);
var auxMetaSql : TatMetaSql;
begin
   inherited;
   with MetaSqlDef.MetaSql do
   begin
      { verifica se a tabela ainda não existe (procura pelo TableAlias) }
      ValidationError(
         edTableName.Text='',
         _str(STableNameEmpty),
         [edTableName.Text],
         edTableName );

      ValidationError(
         edTableAlias.Text='',
         _str(STableAliasEmpty),
         [edTableAlias.Text],
         edTableAlias );

      ValidationError(
         SqlTables.FindByAlias(edTableAlias.Text)<>nil,
         _str(STableAliasAlreadyIncluded),
         [edTableAlias.Text],
         edTableAlias );

      ValidationError(
         (edJoinCondition.Text='') and (edJoinType.ItemIndex>0),
         _str(SJoinConditionEmpty),
         [edJoinCondition.Text],
         edJoinCondition );

      auxMetaSql := nil;
      if edJoinCondition.Text > '' then
        { testa se a expressão de junção é uma condição válida }
        try
           auxMetaSql := ParseMetaSql('SELECT X FROM X WHERE '+edJoinCondition.Text);
        except
           on ex:Exception do
              ValidationError(
                 true,
                 _str(SJoinConditionError) + #13#10 + ex.message,
                 [edJoinCondition.Text],
                 edJoinCondition );
        end;

      try
         { inclui a nova tabela na meta-sql }
         EditedObject := MetaSqlDef.MetaSql.SqlTables.Add;
         with TatSqlTable(EditedObject) do
         begin
            TableName := edTableName.Text;
            TableAlias := edTableAlias.Text;
         end;

         if edJoinType.ItemIndex>1 then
            { inclui a expressão de junção }
            with MetaSqlDef.MetaSql.TableJoins.Add do
            begin
               PrimaryTableAlias := ''; // não é necessário
               ForeignTableAlias := edTableAlias.Text;
               LinkType := TatSQLJoinType(edJoinType.ItemIndex-1);

               { raliza todos os ajustes necessários para que os campos usados
                 na meta-sql auxiliar façam referência a campos da sql-principal }
               ValidateConditionFields( auxMetaSql.Conditions );

               JoinConditions.Assign( auxMetaSql.Conditions );
            end;

      finally
         auxMetaSql.Free;
      end;
   end;
end;

procedure TfmCustomTableEditor.FormShow(Sender: TObject);
begin
  inherited;
  LoadTableNameList( edTableName.Items );
  edJoinType.ItemIndex := 0;
end;

procedure TfmCustomTableEditor.Localize;
begin
  Self.Caption := _str('fmCustomTableEditor.Self.Caption');
  Label1.Caption := _str('fmCustomTableEditor.Label1.Caption');
  Label2.Caption := _str('fmCustomTableEditor.Label2.Caption');
  Label4.Caption := _str('fmCustomTableEditor.Label4.Caption');
  edJoinType.Items.Clear;
  edJoinType.Items.Add(_str('fmCustomTableEditor.edJoinType.Items0'));
  edJoinType.Items.Add(_str('fmCustomTableEditor.edJoinType.Items1'));
  edJoinType.Items.Add(_str('fmCustomTableEditor.edJoinType.Items2'));
  edJoinType.Items.Add(_str('fmCustomTableEditor.edJoinType.Items3'));
  Label3.Caption := _str('fmCustomTableEditor.Label3.Caption');
  lbInfo.Caption := _str('fmCustomTableEditor.lbInfo.Caption');
end;

procedure TfmCustomTableEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.
