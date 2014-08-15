unit fCompareConditionEditor;

{$I tmsdefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atMetaSql,
  {$IFDEF DELPHI6_LVL}
  Variants,
  {$ENDIF}
  fCustomConditionEditor;

type
  TfmCompareConditionEditor = class(TfmCustomConditionEditor)
    pnExpression: TPanel;
    Label1: TLabel;
    edField: TComboBox;
    edOperator: TComboBox;
    edValue: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    FPreSelectedField : string;
    FPreSelectedValue : string;
    FPreSelectedOper  : string;
    procedure SetPreSelectedField(const Value: string);
    procedure SetPreSelectedOper(const Value: string);
    procedure SetPreSelectedValue(const Value: string);
    procedure Localize;
  protected
    procedure Loaded; override;
  public
    property PreSelectedField : string read FPreSelectedField write SetPreSelectedField;
    property PreSelectedValue : string read FPreSelectedValue write SetPreSelectedValue;
    property PreSelectedOper  : string read FPreSelectedOper write SetPreSelectedOper;
  end;

var
  fmCompareConditionEditor: TfmCompareConditionEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCompareConditionEditor.FormShow(Sender: TObject);
var c: integer;
begin
  inherited;
  { load expression component combo boxes }

  with MetaSql do
  begin
    { available Fields }
    edField.Items.Clear;
    edValue.Items.Clear;
    for c:=0 to SqlFields.Count-1 do
    begin
      edField.Items.AddObject( SqlFields[c].DisplayLabel, SqlFields[c] );
      edValue.Items.AddObject( SqlFields[c].DisplayLabel, SqlFields[c] );
      edValue.Items.AddObject( ':'+SqlFields[c].FieldAlias, nil );
      if SameText(SqlFields[c].FieldAlias,PreSelectedField) then
        edField.ItemIndex := c;
    end;
    if PreSelectedValue>'' then
      edValue.Text := PreSelectedValue;

    { available operators }
    edOperator.Items.Clear;
    edOperator.Items.Add('=');
    edOperator.Items.Add('<>');
    edOperator.Items.Add('>');
    edOperator.Items.Add('>=');
    edOperator.Items.Add('<');
    edOperator.Items.Add('<=');
    edOperator.Items.Add('Like');
    if PreSelectedOper > '' then
      edOperator.ItemIndex := edOperator.Items.IndexOf(PreSelectedOper)
    else
      edOperator.ItemIndex := 0;

    // it would also include Starting, Ending and Containing operator (applicable to strings)
  end;
end;

procedure TfmCompareConditionEditor.btOkClick(Sender: TObject);
begin
  inherited;
  with MetaSql do
  begin
    { verifica se o campo foi especificado }
    ValidationError(
      edField.Text='',
      _str(SExpressionFieldNotSpecified),
      [edField.Text],
      edField );

    { verifica se o operador foi especificado }
    ValidationError(
      edOperator.Text='',
      _str(SExpressionOperatorNotSpecified),
      [edOperator.Text],
      edOperator );

    { verifica se o valor foi especificado }
    ValidationError(
      edValue.Text='',
      _str(SConditionRightSideNotSpecified),
      [edValue.Text],
      edValue );

    { create a new condition collection }
    EditedObject := Self.Conditions.Add;
    with TatSqlCondition(EditedObject) do
    begin
      { pull condition type, according to the edValue content }
      if (edValue.ItemIndex > -1) and (edValue.Items.Objects[edValue.ItemIndex] is TatSQLField) then
      begin
        ConditionType := ctFieldCompare;
        Value := VarToStr(TatSqlField(edValue.Items.Objects[edValue.ItemIndex]).FieldAlias);
      end
      else
        if Copy(edValue.Text,1,1)=':' then
        begin
          ConditionType := ctParamCompare;
          Value := Copy(edValue.Text,2,MaxInt);
        end
        else
        begin
          ConditionType := ctValueCompare;
          Value := edValue.Text;
        end;

      FieldAlias := TatSqlField(edField.Items.Objects[edField.ItemIndex]).FieldAlias;
      Operator := edOperator.Text;
      Text := Format('%s %s %s',[edField.Text,edOperator.Text,edValue.Text]);
    end;

    { adjust the condition operator }
    AdjustConditionOperator(
      TatSqlCondition(EditedObject),
      TLogicalOper(edLogicOper.Items.Objects[edLogicOper.ItemIndex]) );
  end;
end;

procedure TfmCompareConditionEditor.SetPreSelectedField(
  const Value: string);
begin
  FPreSelectedField := Value;
end;

procedure TfmCompareConditionEditor.SetPreSelectedOper(
  const Value: string);
begin
  FPreSelectedOper := Value;
end;

procedure TfmCompareConditionEditor.SetPreSelectedValue(
  const Value: string);
begin
  FPreSelectedValue := Value;
end;

procedure TfmCompareConditionEditor.Localize;
begin
  Self.Caption := _str('fmCompareConditionEditor.Self.Caption');
  Label1.Caption := _str('fmCompareConditionEditor.Label1.Caption');
  lbInfo.Caption := _str('fmCompareConditionEditor.lbInfo.Caption');
end;

procedure TfmCompareConditionEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

