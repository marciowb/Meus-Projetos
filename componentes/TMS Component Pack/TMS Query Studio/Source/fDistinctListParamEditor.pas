unit fDistinctListParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, fCustomParamEditor, atMetaSql;

type
  TfmDistinctListParamEditor = class(TfmCustomParamEditor)
    pnParamName: TPanel;
    Label2: TLabel;
    edParamName: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edCaptionEnter(Sender: TObject);
  private
    procedure Localize;
  protected
    procedure Loaded; override;
  public
  end;

var
  fmDistinctListParamEditor: TfmDistinctListParamEditor;

implementation

uses
  atVisualQuery, qsRes;

{$R *.DFM}

procedure TfmDistinctListParamEditor.FormShow(Sender: TObject);
begin
  inherited;
  LoadParamNameCombo(edParamName);
end;

procedure TfmDistinctListParamEditor.btOkClick(Sender: TObject);
var fld : TatSqlField;
begin
  inherited;
  if not ValidateParamName( edParamName ) then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  { tenta encontrar o campo associado ao parâmetro dado }
  fld := MetaSql.FindFieldByParamName( edParamName.Text );
  ValidationError(
     not Assigned(fld),
     _str(SParamNameNotReferFieldComparingCondition),
     [edParamName.Text],
     edParamName );

  with MetaSql do
  begin
    { inclui o novo parâmetro no VisualQuery }
    EditedObject := MetaSqlDef.ParamDefs.Add;
    with TatParamDef(EditedObject) do
    begin
      Name := edParamName.Text;
      Caption := edCaption.Text;
      ParamType := ptDistinctList;
      Field := fld;
    end;
  end;
end;

procedure TfmDistinctListParamEditor.edCaptionEnter(Sender: TObject);
begin
  inherited;
  DefaultCaptionFromParamName(edParamName);
end;

procedure TfmDistinctListParamEditor.Localize;
begin
  Self.Caption := _str('fmDistinctListParamEditor.Self.Caption');
  Label2.Caption := _str('fmDistinctListParamEditor.Label2.Caption');
  lbInfo.Caption := _str('fmDistinctListParamEditor.lbInfo.Caption');
end;

procedure TfmDistinctListParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

