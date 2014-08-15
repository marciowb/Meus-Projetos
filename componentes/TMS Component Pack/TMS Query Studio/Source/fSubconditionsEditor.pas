unit fSubconditionsEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atMetaSql, fCustomConditionEditor;

type
  TfmSubconditionsEditor = class(TfmCustomConditionEditor)
    procedure btOkClick(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmSubconditionsEditor: TfmSubconditionsEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmSubconditionsEditor.btOkClick(Sender: TObject);
begin
  inherited;
  with MetaSql do
  begin
     { create a new condition collection }
     EditedObject := Self.Conditions.Add;
     with TatSqlCondition(EditedObject) do
     begin
       ConditionType := ctSubconditions;
     end;
     { adjust the condition operator }
     AdjustConditionOperator(
       TatSqlCondition(EditedObject),
       TLogicalOper(edLogicOper.Items.Objects[edLogicOper.ItemIndex]) );
  end;
end;

procedure TfmSubconditionsEditor.Loaded;
begin
  inherited;
  Localize;
end;

procedure TfmSubconditionsEditor.Localize;
begin
  Self.Caption := _str('fmSubconditionsEditor.Self.Caption');
  lbInfo.Caption := _str('fmSubconditionsEditor.lbInfo.Caption');
end;

end.

