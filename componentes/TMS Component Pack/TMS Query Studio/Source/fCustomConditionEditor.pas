unit fCustomConditionEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atMetaSql,
  fCustomEditor;

type
  TLogicalOper = (loNone,loNot,loAnd,loAndNot,loOr,loOrNot);

  TfmCustomConditionEditor = class(TfmCustomEditor)
    pnOperator: TPanel;
    Label3: TLabel;
    edLogicOper: TComboBox;
    procedure FormShow(Sender: TObject);
  private
    FConditions : TatSqlConditions;
    procedure SetConditions(const Value: TatSqlConditions);
    procedure Localize;
  protected
    procedure Loaded; override;
    procedure SetEditedObject(const Value: TObject); override;
    procedure AdjustConditionOperator(ACond: TatSqlCondition;lo:TLogicalOper);
  public
    property Conditions : TatSqlConditions read FConditions write SetConditions;
  end;

var
  fmCustomConditionEditor: TfmCustomConditionEditor;

implementation

uses
  qsRes;

{$R *.DFM}

procedure TfmCustomConditionEditor.FormShow(Sender: TObject);
begin
   inherited;

   { prepare available operators for a new condition (into Conditions) }
   edLogicOper.Items.BeginUpdate;
   try
      edLogicOper.Items.Clear;

      { control aplicable operator to current Conditions }
      if Conditions.Count=0 then
      begin
        { none subconditions, then allow just negation }
        edLogicOper.Items.AddObject( '', TObject(loNone) );
        edLogicOper.Items.AddObject( 'NOT', TObject(loNot) );
      end
      else
        if Conditions.Count=1 then
        begin
          { one subcondition, then allow any operator }
          edLogicOper.Items.AddObject( 'AND', TObject(loAnd) );
          edLogicOper.Items.AddObject( 'AND NOT', TObject(loAndNot) );
          edLogicOper.Items.AddObject( 'OR', TObject(loOr) );
          edLogicOper.Items.AddObject( 'OR NOT', TObject(loOrNot) );
        end
        else
        begin
          { more than one subconditions, then allow just the same operator or his negation }
          if Conditions.LogicalOperator=lgAND then
          begin
            edLogicOper.Items.AddObject( 'AND', TObject(loAnd) );
            edLogicOper.Items.AddObject( 'AND NOT', TObject(loAndNot) );
          end
          else
          begin
            edLogicOper.Items.AddObject( 'OR', TObject(loOr) );
            edLogicOper.Items.AddObject( 'OR NOT', TObject(loOrNot) );
          end;
        end;

     AdjustDefaultItems;
   finally
      edLogicOper.Items.EndUpdate;
   end;
end;

procedure TfmCustomConditionEditor.SetConditions(
  const Value: TatSqlConditions);
begin
  FConditions := Value;
end;

procedure TfmCustomConditionEditor.SetEditedObject(const Value: TObject);
begin
  inherited;
  { argument EditedObj should refer to target Conditions }
  if Assigned(Value) and (Value is TatSqlConditions) then
    Conditions := TatSqlConditions(EditedObject);
end;

procedure TfmCustomConditionEditor.AdjustConditionOperator(ACond:TatSqlCondition;lo:TLogicalOper);
begin
  with ACond do
  begin
    if lo in [loOr,loOrNot] then
      TatSqlConditions(Collection).LogicalOperator := lgOr
    else
      if lo in [loAnd,loAndNot] then
        TatSqlConditions(Collection).LogicalOperator := lgAnd;
    Negate := lo in [loNot,loAndNot,loOrNot];
  end;
end;

procedure TfmCustomConditionEditor.Localize;
begin
  Self.Caption := _str('fmCustomConditionEditor.Self.Caption');
  Label3.Caption := _str('fmCustomConditionEditor.Label3.Caption');
  edLogicOper.Items.Clear;
  edLogicOper.Items.Add(_str('fmCustomConditionEditor.edLogicOper.Items0'));
  edLogicOper.Items.Add(_str('fmCustomConditionEditor.edLogicOper.Items1'));
  edLogicOper.Items.Add(_str('fmCustomConditionEditor.edLogicOper.Items2'));
end;

procedure TfmCustomConditionEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

