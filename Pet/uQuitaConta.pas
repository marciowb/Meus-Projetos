unit uQuitaConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, LabelDBEdit,
  DB, DBClient, pFIBClientDataSet, EditPesquisa;

type
  TfrmDlg_QuitaConta = class(TfrmDlg_Cadastro)
    LabelDBEdit1: TLabelDBEdit;
    DataRec: TDataSource;
    LabelDBEdit2: TLabelDBEdit;
    CdsRec: TpFIBClientDataSet;
    edtFP: TEditPesquisa;
    procedure CdsRecAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure CdsRecAfterPost(DataSet: TDataSet);
    procedure CdsRecNewRecord(DataSet: TDataSet);
  private
    FIdContaReceber: Integer;
    FDivida: Currency;
    procedure SetIdContaReceber(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    Procedure AtuDados;
    Property IdContaReceber: Integer read FIdContaReceber write SetIdContaReceber;
    property Divida: Currency read FDivida write FDivida;
  end;

var
  frmDlg_QuitaConta: TfrmDlg_QuitaConta;

implementation

uses Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmDlg_QuitaConta.AtuDados;
begin
  SetCds(CdsRec,tpPetContaReceberRec,'CRR.IDCONTARECEBER = '+GetInteger(IdContaReceber));
end;

procedure TfrmDlg_QuitaConta.btnOkClick(Sender: TObject);
begin
  VerificaLabelDbEdit(Self,CdsRec);
  VerificaEdit(edtFP,'Informe a forma de pagamento');
  inherited;

end;

procedure TfrmDlg_QuitaConta.CdsRecAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsRec.FieldByName('DATA'),tcCampoData);
  FormataMascara(CdsRec.FieldByName('VALOR'),tcMoeda);
  CdsRec.FieldByName('NOMEFORMAPAGAMENTO').ProviderFlags := [];

end;

procedure TfrmDlg_QuitaConta.CdsRecAfterPost(DataSet: TDataSet);
var
  Quita: Boolean;
begin
  inherited;
  if pDataSet.FieldByName('VALOR').AsCurrency >= Divida then
    Quita := True
  else
    Quita := Pergunta('O valor é menor que a dívida deseja arquivar a conta?');
  Try
    StartTrans;
    AlteraBanco(taInsere,CdsRec,'CONTARECEBERREC','IDCONTARECEBERREC');
    Exec_SQL('UPDATE CONTARECEBER '+
             '   SET VALORPAGO =COALESCE(VALORPAGO,0)+ '+GetNumber(pDataSet.FieldByName('VALOR').AsCurrency )+
             ' WHERE IDCONTARECEBER = '+GetInteger(IdContaReceber));
    if Quita then
      Exec_SQL('UPDATE CONTARECEBER SET FLAGPAGO = ''Y'', DATAPAGO = '+GetData(pDataSet.FieldByName('DATA').AsDateTime)+
               ' WHERE IDCONTARECEBER = '+GetInteger(IdContaReceber));
    Commit;
  Except
    on e: Exception do
    Begin
      RollBack;
      Raise;
    End;
  End;
end;

procedure TfrmDlg_QuitaConta.CdsRecNewRecord(DataSet: TDataSet);
begin
  inherited;
  pDataSet.FieldByName('DATA').AsString := GetDataServidor;
  pDataSet.FieldByName('IDCONTARECEBERREC').AsInteger := GetValSeq('SEQ_IDCONTARECEBERREC');
  pDataSet.FieldByName('IDCONTARECEBER').AsInteger := IdContaReceber;
  pDataSet.FieldByName('IDUSUARIO').AsInteger := UsuarioLogado.Id;
end;

procedure TfrmDlg_QuitaConta.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
  pDataSet := CdsRec;
  pDataSet.Append;
  pDataSet.FieldByName('VALOR').AsCurrency := Divida;
  ConfiguraEditPesquisa(edtFP,pDataSet,tpPetFormaPagamento);
end;

procedure TfrmDlg_QuitaConta.SetIdContaReceber(const Value: Integer);
begin
  FIdContaReceber := Value;
end;

ENd.
