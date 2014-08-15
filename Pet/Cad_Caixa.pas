unit Cad_Caixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, LabelDBEdit,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit;

type
  TfrmCad_Caixa = class(TfrmDlg_Cadastro)
    LabelDBEdit1: TLabelDBEdit;
    Label1: TLabel;
    edtData: TcxDBDateEdit;
    LabelDBEdit2: TLabelDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Caixa: TfrmCad_Caixa;

implementation

uses  Lst_Caixa, Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmCad_Caixa.btnOkClick(Sender: TObject);
begin
  VerificaLabelDbEdit(Self, pDataSet);
  if edtData.Text = '' then
  Begin
    edtData.SetFocus;
    Avisa('Informe a data');
    Exit;
  End;
  pDataSet.FieldByName('VALOR_CALC').AsCurrency := pDataSet.FieldByName('VALOR').AsCurrency ;
  Try
    StartTrans;
    inherited;
    AlteraBanco(taInsertOrUpdate, pDataSet, 'CAIXA', 'IDCAIXA');
    Commit;
  EXCEPT
    on e: Exception do
    Begin
      RollBack;
      raise;
    End;
  End;

end;

end.
