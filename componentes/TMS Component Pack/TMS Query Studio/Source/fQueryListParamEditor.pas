unit fQueryListParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Buttons, ExtCtrls, ComCtrls, fCustomParamEditor;

type
  TfmQueryListParamEditor = class(TfmCustomParamEditor)
    pnParamName: TPanel;
    Label2: TLabel;
    edParamName: TComboBox;
    pnMetaSql: TPanel;
    Label1: TLabel;
    edMetaSql: TRichEdit;
    btMetaSql: TBitBtn;
    Bevel1: TBevel;
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
  fmQueryListParamEditor: TfmQueryListParamEditor;

implementation

uses
  atVisualQuery, atMetaSql, qsRes;

{$R *.DFM}

procedure TfmQueryListParamEditor.FormShow(Sender: TObject);
begin
  inherited;
  LoadParamNameCombo(edParamName);
end;

procedure TfmQueryListParamEditor.btOkClick(Sender: TObject);
begin
  inherited;

  if not ValidateParamName( edParamName ) then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  with MetaSql do
  begin
    { inclui o novo parâmetro no VisualQuery }
    EditedObject := MetaSqlDef.ParamDefs.Add;
    with TatParamDef(EditedObject) do
    begin
      Name := edParamName.Text;
      Caption := edCaption.Text;
      ParamType := ptQueryList;
      MetaSqlStr := edMetaSql.Text;
      { testa se a consulta é meta-sql válida }
      try
        SQLStringToMetaSQL(MetaSqlStr,MetaSql);
      except
        on ex:Exception do
        begin
          EditedObject.Free;
          ValidationError(
            True,
            _str(SInvalidMetaSQL) + #13#10+ex.message,
            [],
            edMetaSql );
        end;
      end;
      if MetaSql.SqlFields.Count<2 then
      begin
        EditedObject.Free;
        ValidationError(
          True,
          _str(SInvalidQueryFirstSecondFields),
          [],
          edMetaSql );
      end;
    end;
  end;
end;

procedure TfmQueryListParamEditor.edCaptionEnter(Sender: TObject);
begin
  inherited;
  DefaultCaptionFromParamName(edParamName);
end;

procedure TfmQueryListParamEditor.Localize;
begin
  Self.Caption := _str('fmQueryListParamEditor.Self.Caption');
  Label2.Caption := _str('fmQueryListParamEditor.Label2.Caption');
  Label1.Caption := _str('fmQueryListParamEditor.Label1.Caption');
  btMetaSql.Caption := _str('fmQueryListParamEditor.btMetaSql.Caption');
  lbInfo.Caption := _str('fmQueryListParamEditor.lbInfo.Caption');
end;

procedure TfmQueryListParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

