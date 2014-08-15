unit fFreeEditParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons,
  ExtCtrls, fCustomParamEditor;

type
  TfmFreeEditParamEditor = class(TfmCustomParamEditor)
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
  fmFreeEditParamEditor: TfmFreeEditParamEditor;

implementation

uses
  atVisualQuery, atMetaSql, qsRes;

{$R *.DFM}

procedure TfmFreeEditParamEditor.FormShow(Sender: TObject);
begin
  inherited;
  LoadParamNameCombo(edParamName);
end;

procedure TfmFreeEditParamEditor.btOkClick(Sender: TObject);
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
      ParamType := ptFreeEdit;
    end;
  end;
end;

procedure TfmFreeEditParamEditor.edCaptionEnter(Sender: TObject);
begin
  inherited;
  DefaultCaptionFromParamName(edParamName);
end;

procedure TfmFreeEditParamEditor.Localize;
begin
  Self.Caption := _str('fmFreeEditParamEditor.Self.Caption');
  Label2.Caption := _str('fmFreeEditParamEditor.Label2.Caption');
  lbInfo.Caption := _str('fmFreeEditParamEditor.lbInfo.Caption');
end;

procedure TfmFreeEditParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

