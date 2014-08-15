unit uLst_ContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, pFIBClientDataSet, ActnList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, StdCtrls, Buttons,
  dxStatusBar, ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter;

type
  TTipoForm = (tfReceber,tfRecebida);
  TfrmLstContasReceber = class(TfrmListagemPadrao)
    BitBtn11: TBitBtn;
    actQuitar: TAction;
    actEstornar: TAction;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure CdsListagemAfterOpen(DataSet: TDataSet);
    procedure CdsListagemNewRecord(DataSet: TDataSet);
    procedure CdsListagemBeforePost(DataSet: TDataSet);
    procedure actExcluirExecute(Sender: TObject);
    procedure CdsListagemAfterPost(DataSet: TDataSet);
    procedure actImprimirExecute(Sender: TObject);
    procedure actQuitarExecute(Sender: TObject);
    procedure actEstornarExecute(Sender: TObject);
  private
    FTipoForm: TTipoForm;
    procedure SetTipoForm(const Value: TTipoForm);
    { Private declarations }
  public
    { Public declarations }
    Property TipoForm: TTipoForm read FTipoForm write SetTipoForm;
  end;

var
  frmLstContasReceber,frmLstContasRecebidas: TfrmLstContasReceber;

implementation

uses MinhasClasses, Comandos, Cad_ContaReceber, uLibPet, uQuitaConta;

{$R *.dfm}

procedure TfrmLstContasReceber.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_ContaReceber := TfrmCad_ContaReceber.Create(nil);
  Try
    with frmCad_ContaReceber do
    Begin
      pDataSet := Self.CdsListagem;
      pDataSet.Edit;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmCad_ContaReceber);
  End;
end;

procedure TfrmLstContasReceber.actEstornarExecute(Sender: TObject);
var
  StrSQL: String;
begin
  inherited;
  if not Pergunta('Confirma estorno?') then
    Exit;
  try
    StartTrans;
    StrSQL :=
      'UPDATE CONTARECEBER '+
      '   SET FLAGPAGO = ''N'' '+
      '      ,VALORPAGO = 0 '+
      ' WHERE IDCONTARECEBER = '+CdsListagem.FieldByName('IDCONTARECEBER').AsString;
    Exec_SQL(StrSQL);
    StrSQL :=
      'INSERT INTO CAIXA (IDCAIXA, DATA, FLAGOPERACAO, VALOR, IDUSUARIO, IDSERVICO, HISTORICO, IDCONTARECEBERREC) '+
      '            SELECT GEN_ID(SEQ_IDCAIXA,1),CURRENT_DATE,''D'', SUM(VALOR), '+GetInteger(USuarioLogado.Id)+',NULL,'+GetStr('ESTORNO DE CONTA ')+
      '                   ,IDCONTARECEBERREC '+
      '              FROM CONTARECEBERREC CRR'+
      '             INNER JOIN FORMAPAGAMENTO FP '+
      '                ON (FP.IDFORMAPAGAMENTO = CRR.IDFORMAPAGAMENTO) '+
      '             WHERE FP.TIPOFORMAPAGAMENTO = ''D'' AND  IDCONTARECEBER = '+CdsListagem.FieldByName('IDCONTARECEBER').AsString+
      '             GROUP BY 1,2,8 ';
    Exec_SQL(StrSQL);
    StrSQL :=
      'DELETE FROM CONTARECEBERREC '+
      ' WHERE IDCONTARECEBER = '+CdsListagem.FieldByName('IDCONTARECEBER').AsString;
    Exec_SQL(StrSQL);

    Commit;
    AtuDados;
  except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  end;

end;

procedure TfrmLstContasReceber.actExcluirExecute(Sender: TObject);
begin
  if (not PodeExcluir)or
     (GetTableCount('SERVICO','*','IDSERVICO = '+CdsListagem.FieldByName('idservico').AsString)>0) then
    Avisa('Essa conta possui dependências, por isso, não pode ser excluída!')
  else
    inherited;

end;

procedure TfrmLstContasReceber.actImprimirExecute(Sender: TObject);
begin
  inherited;
  AbreRelContasReceber;
end;

procedure TfrmLstContasReceber.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_ContaReceber := TfrmCad_ContaReceber.Create(nil);
  Try
    with frmCad_ContaReceber do
    Begin
      pDataSet := Self.CdsListagem;
      pDataSet.Append;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmCad_ContaReceber);
  End;
end;

procedure TfrmLstContasReceber.actQuitarExecute(Sender: TObject);
begin
  inherited;
  Try
    frmDlg_QuitaConta := TfrmDlg_QuitaConta.Create(nil);
    with frmDlg_QuitaConta do
    Begin
      IdContaReceber := Self.CdsListagem.FieldByName('IDCONTARECEBER').AsInteger;
      Divida := Self.CdsListagem.FieldByName('DIVIDA').AsCurrency;
      ShowModal;
      Self.AtuDados;
    End;
  Finally
    FreeAndNil(frmDlg_QuitaConta);
  End;
end;

procedure TfrmLstContasReceber.BitBtn11Click(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

procedure TfrmLstContasReceber.CdsListagemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsListagem.FieldByName('NOMECLIENTE').ProviderFlags := [];
  CdsListagem.FieldByName('CODIGO').ProviderFlags := [];
  CdsListagem.FieldByName('DIVIDA').ProviderFlags := [];
  CdsListagem.FieldByName('ANIMAIS').ProviderFlags := [];
end;

procedure TfrmLstContasReceber.CdsListagemAfterPost(DataSet: TDataSet);
begin
  inherited;
  AtuDados;
end;

procedure TfrmLstContasReceber.CdsListagemBeforePost(DataSet: TDataSet);
var
  Ta : TTipoAlteracao;
begin
  inherited;
  if CdsListagem.State = dsEdit then
    Ta := taModifica
  else
    Ta := taInsere;
  Try
    StartTrans;
    AlteraBanco(Ta,CdsListagem,'CONTARECEBER','IDCONTARECEBER');
    Commit;
  Except
    On E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  End;
end;

procedure TfrmLstContasReceber.CdsListagemNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsListagem.FieldByName('IDCONTARECEBER').AsString := GetCodigo(tpPetContasReceber);
  CdsListagem.FieldByName('IDUSUARIO').AsInteger := USuarioLogado.Id;
  CdsListagem.FieldByName('DATACRIACAO').AsString  :=GetDataServidor;
  CdsListagem.FieldByName('DATA').AsString  :=GetDataServidor;
end;

procedure TfrmLstContasReceber.FormCreate(Sender: TObject);
begin
  inherited;
  CriaColuna('DATA','Data',80,tcCampoData);
  CriaColuna('DATAVENCIMENTO','Vencimento',90,tcCampoData);
  CriaColuna('NOMECLIENTE','Cliente',300,tcString);
  CriaColuna('VALOR','Valor',100,tcMoeda);
  CriaColuna('DIVIDA','Dívida',100,tcMoeda);
end;

procedure TfrmLstContasReceber.SetTipoForm(const Value: TTipoForm);
begin
  FTipoForm := Value;
  if TipoForm = tfReceber then
    TipoPesquisa := tpPetContasReceber
  else
  Begin
    TipoPesquisa := tpPetContasRecebidas;
    CriaColuna('DATAPAGO','Data recebido',120,tcCampoData);
    Self.Caption := 'Contas recebidas';
    actNovo.Visible := False;
  End;
  actQuitar.Visible := TipoForm = tfReceber;
  actEstornar.Visible := TipoForm = tfRecebida;
  AtuDados;
end;

end.
