unit fCustomParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atVisualQuery, atMetaSQL,
  fCustomEditor;

type
  TfmCustomParamEditor = class(TfmCustomEditor)
    pnCaption: TPanel;
    Label5: TLabel;
    edCaption: TEdit;
    procedure btOkClick(Sender: TObject);
  private
    FParamType : TatParamType;
    procedure Localize;
  protected
    procedure Loaded; override;
    procedure DefaultCaptionFromParamName(AParamName: TComboBox);
    function ValidateParamName( combo: TComboBox ): boolean;
    property ParamType: TatParamType read FParamType write FParamType;
  public
  end;

var
  fmCustomParamEditor: TfmCustomParamEditor;

implementation

uses
  fCompareConditionEditor, qsRes;

{$R *.DFM}

{ TfmCustomParamEditor }

function TfmCustomParamEditor.ValidateParamName(combo: TComboBox): boolean;
begin
  { verifica se o nome do parâmetro foi informado }
  ValidationError(
     (combo.Text=''),
     _str(SParamNameNotIndicated),
     [combo.Text],
     combo );

  { verifica se o nome do parâmetro é válido }
  ValidationError(
     not IsValidIdent(combo.Text),
     _str(SParamNameNotValid),
     [combo.Text],
     combo );

  { se o parâmetro ainda não existia então permite criar uma condição do
    tipo ParamCompare associada a este novo parâmetro }
  if MetaSql.Params.FindParam( combo.Text )=nil then
  begin
    { inclui uma condição com o assistente de inclusão }
    with TfmCompareConditionEditor.Create(Application) do
    try
      { tenta ajustar as cordenadas da nova janela de modo a ficar
        lado-a-lado com a janela corrente }
      if Self.Left+Self.Width+Width<Screen.Width then
      begin
        Left := Self.Left + Self.Width - 3;
        Top := Self.Top;
      end
      else
      begin
        Left := Self.Left;
        Top := Self.Top + Self.Height - 3;
      end;
      VisualQuery := Self.VisualQuery;
      MetaSqlDef := Self.MetaSqlDef;
      EditedObject := Self.MetaSql.Conditions;

      { customize the interface to new ParamCondition }
      PreSelectedValue := ':'+combo.Text;
      edValue.Enabled := false;

      if (combo.ItemIndex>-1) and
         (combo.Items.Objects[combo.ItemIndex] is TatSqlField) then
      begin
        PreSelectedField := combo.Text;
        edField.Enabled := false;
      end;

      result := (ShowModal<>mrCancel);
    finally
      { reload param name combo, because addresses may be changed }
      LoadParamNameCombo(combo);
      Release;
    end;
  end
  else
    result := true;
end;

procedure TfmCustomParamEditor.btOkClick(Sender: TObject);
begin
  inherited;
  { verifica se a legenda do campo foi informada }
  ValidationError(
     (edCaption.Text=''),
     _str(SParamCaptionNotSpecified),
     [edCaption.Text],
     edCaption );
end;

procedure TfmCustomParamEditor.DefaultCaptionFromParamName(AParamName: TComboBox);
var cond : TatSqlCondition;
    fld : TatSqlField;
begin
  { se o parâmetro se referir a um campo então trás o nome do campo como
    descritivo senão tras o próprio nome do parâmetro }
  if (edCaption.Text='') and (AParamName.Text>'') then
  begin
    if AParamName.ItemIndex>-1 then
      with AParamName do
        if Items.Objects[ItemIndex] is TatSqlField then
          { é campo então pega sua legenda }
          edCaption.Text := TatSqlField(Items.Objects[ItemIndex]).DisplayLabel
        else
        begin
          edCaption.Text := AParamName.Text;

          { é parâmetro então encontra a condição que usou este parâmetro,
            se ela for uma comparação então pega a legenda do campo comparado,
            senão deixa o próprio nome do parâmetro }
          cond := MetaSql.FindConditionByParamName( AParamName.Text );
          if Assigned(cond) then
          begin
            fld := cond.Field;
            if Assigned(fld) then
              edCaption.Text := fld.DisplayLabel
            else
              { estava na condição, mas a condição não era uma comparação,
                então usa o Text da condição como legenda }
              edCaption.Text := cond.Text;
          end;
        end
    else
      edCaption.Text := AParamName.Text;
  end;
end;

procedure TfmCustomParamEditor.Localize;
begin
  Self.Caption := _str('fmCustomParamEditor.Self.Caption');
  Label5.Caption := _str('fmCustomParamEditor.Label5.Caption');
end;

procedure TfmCustomParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

