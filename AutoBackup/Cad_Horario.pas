unit Cad_Horario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxSpinEdit,
  cxTimeEdit, DB, uPrincipal_AutoBackup;

type
  TfrmCad_Horario = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cmbDiaSemana: TDBComboBox;
    cxDBTimeEdit1: TcxDBTimeEdit;
    Label2: TLabel;
    Label1: TLabel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Horario: TfrmCad_Horario;

implementation

{$R *.dfm}

procedure TfrmCad_Horario.btnCancelarClick(Sender: TObject);
begin
  frmPrincipal_AutoBackup.CdsHorarios.Cancel;
  ModalResult := mrCancel;
end;

procedure TfrmCad_Horario.btnGravarClick(Sender: TObject);
begin
  frmPrincipal_AutoBackup.CdsHorarios.FieldByName('DIASEMANA').AsInteger := cmbDiaSemana.ItemIndex+1;
  frmPrincipal_AutoBackup.CdsHorarios.Post;
  ModalResult := mrOk
end;

end.
