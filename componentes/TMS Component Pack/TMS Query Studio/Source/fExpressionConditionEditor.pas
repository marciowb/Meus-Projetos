unit fExpressionConditionEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atMetaSql, fCustomConditionEditor;

type
  TfmExpressionConditionEditor = class(TfmCustomConditionEditor)
    pnCustomExpr: TPanel;
    Label5: TLabel;
    edExpression: TEdit;
    procedure btOkClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmExpressionConditionEditor: TfmExpressionConditionEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmExpressionConditionEditor.btOkClick(Sender: TObject);
begin
  inherited;
  with MetaSql do
  begin
    { verifica se a expressão foi especificada }
    ValidationError(
      edExpression.Text='',
      _str(SConditionExpressionNotSpecified),
      [edExpression.Text],
      edExpression );

     { create a new condition collection }
     EditedObject := Self.Conditions.Add;
     with TatSqlCondition(EditedObject) do
     begin
       ConditionType := ctCustomExpr;
       Expression := edExpression.Text;
       Text := edExpression.Text;
     end;

     { adjust the condition operator }
     AdjustConditionOperator(
       TatSqlCondition(EditedObject),
       TLogicalOper(edLogicOper.Items.Objects[edLogicOper.ItemIndex]) );
  end;
end;

procedure TfmExpressionConditionEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmExpressionConditionEditor.Localize;
begin
  Self.Caption := _str('fmExpressionConditionEditor.Self.Caption');
  Label5.Caption := _str('fmExpressionConditionEditor.Label5.Caption');
  lbInfo.Caption := _str('fmExpressionConditionEditor.lbInfo.Caption');
end;

end.

