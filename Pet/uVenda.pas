unit uVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, DB, DBClient, pFIBClientDataSet, Grids,
  DBGrids, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, Mask, EditPesquisa, Buttons,
  cxCurrencyEdit, DBCtrls, LabelDBEdit, cxPC, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TfrmVenda = class(TfrmPadrao)
    Panel1: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    DataItens: TDataSource;
    DataServico: TDataSource;
    CdsServico: TpFIBClientDataSet;
    CdsItens: TpFIBClientDataSet;
    Label1: TLabel;
    edtData: TcxDBDateEdit;
    lblTotal: TLabel;
    Panel4: TPanel;
    edtProfissional: TEditPesquisa;
    btnAdd: TBitBtn;
    edtTipoServico: TEditPesquisa;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    chkClienteCadastrado: TCheckBox;
    PageControl: TcxPageControl;
    tsClienteCadastrado: TcxTabSheet;
    tsClienteNaoCadastrado: TcxTabSheet;
    edtCliente: TEditPesquisa;
    edtAnimal: TEditPesquisa;
    edtCategoria: TEditPesquisa;
    edtEspecie: TEditPesquisa;
    Label3: TLabel;
    lblServico: TLabel;
    CdsProfissional: TpFIBClientDataSet;
    edtValor: TcxCurrencyEdit;
    edtNomeCliente: TLabeledEdit;
    edtNomeAnimal: TLabeledEdit;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    procedure chkClienteCadastradoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtClienteBtnNovoClick(Sender: TObject);
    procedure edtAnimalBtnNovoClick(Sender: TObject);
    procedure CdsServicoNewRecord(DataSet: TDataSet);
    procedure edtClienteRegAchado(ADataSet: TDataSet);
    procedure edtClienteRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
    procedure edtAnimalRegAchado(ADataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure edtProfissionalRegAchado(ADataSet: TDataSet);
    procedure edtTipoServicoRegAchado(ADataSet: TDataSet);
    procedure btnAddClick(Sender: TObject);
    procedure edtEspecieRegAchado(ADataSet: TDataSet);
    procedure edtCategoriaEnter(Sender: TObject);
    procedure CdsItensAfterOpen(DataSet: TDataSet);
    procedure CdsServicoAfterOpen(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtClienteBtnEditarClick(Sender: TObject);
    procedure edtAnimalBtnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FValorTotal: Currency;
    ValorOriginal: Currency;
    FIdAgenda: Integer;
    procedure SetValorTotal(const Value: Currency);
    procedure SetIdAgenda(const Value: Integer);

    { Private declarations }
  public
    { Public declarations }
    Property ValorTotal: Currency read FValorTotal write SetValorTotal;
    Property IdAgenda: Integer read FIdAgenda write SetIdAgenda;
  end;

var
  frmVenda: TfrmVenda;

implementation

uses Comandos, MinhasClasses, uLibPet, uFechamento, uObs;

{$R *.dfm}


procedure TfrmVenda.btnAddClick(Sender: TObject);
begin
  inherited;
  VerificaEdit(edtCliente,'Informe o cliente');
  VerificaEdit(edtAnimal,'Informe o animal');
  VerificaEdit(edtProfissional,'Informe o profissional');
  VerificaEdit(edtTipoServico,'Informe o tipo de serviço');

  if edtValor.Value <= 0  then
  Begin
    Avisa('Informe um valor maior que zero!');
    edtValor.SetFocus;
    Abort;
  End;
  CdsItens.Append;
  if chkClienteCadastrado.Checked then
  Begin
    CdsItens.FieldByName('IDANIMAL').AsString := edtAnimal.ValorChaveString;
    CdsItens.FieldByName('NOMEANIMAL').AsString := edtAnimal.Display.Text;
  End else
  Begin
    CdsItens.FieldByName('NOMEANIMAL').AsString := edtNomeAnimal.Text;
    CdsItens.FieldByName('IDANIMAL').Clear;
  End;

  CdsItens.FieldByName('IDPROFISSIONAL').AsString := edtProfissional.ValorChaveString;
  CdsItens.FieldByName('IDTIPOSERVICO').AsString := edtTipoServico.ValorChaveString;
  CdsItens.FieldByName('IDTIPOANIMAL').AsString := edtEspecie.ValorChaveString;
  CdsItens.FieldByName('IDCATEGORIAANIMAL').AsString := edtCategoria.ValorChaveString;

  CdsItens.FieldByName('NOMETIPOSERVICO').AsString := edtTipoServico.Display.Text;
  CdsItens.FieldByName('NOMETIPOANIMAL').AsString := edtEspecie.Display.Text;
  if CdsProfissional.FieldByName('FLAGPEDIRNOME').AsString = 'Y' then
    CdsItens.FieldByName('NOMEPROFISSIONAL').AsString := CdsProfissional.FieldByName('NOMEPROFISSIONAL').AsString
  else
    CdsItens.FieldByName('NOMEPROFISSIONAL').AsString := edtProfissional.Display.Text;

  CdsItens.FieldByName('VALORORIGINAL').AsCurrency := ValorOriginal;
  CdsItens.FieldByName('VALOR').AsCurrency := edtValor.Value;

  CdsItens.FieldByName('ALIQCOMISSAO').AsCurrency := CdsProfissional.FieldByName('ALIQCOMISSAO').AsCurrency;
  CdsItens.FieldByName('VALORCOMISSAO').AsCurrency := (edtValor.Value * CdsProfissional.FieldByName('ALIQCOMISSAO').AsCurrency)/100;

  ValorTotal:= ValorTotal + edtValor.Value;
  CdsItens.Post;

  edtTipoServico.Limpa;
  edtAnimal.Limpa;
  edtCategoria.Limpa;
  edtEspecie.Limpa;
  edtValor.Clear;
  edtNomeAnimal.Clear;
  if chkClienteCadastrado.Checked then
    edtAnimal.SetFocus
  else
    edtNomeAnimal.SetFocus;

end;

procedure TfrmVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  CdsServico.Cancel;
  CdsItens.Cancel;
  if CdsProfissional.Active then
   CdsProfissional.EmptyDataSet;
  CdsServico.EmptyDataSet;
  CdsItens.EmptyDataSet;

  edtProfissional.Limpa;
  edtNomeCliente.Clear;
  edtTipoServico.Limpa;
  edtTipoServico.Limpa;
  edtCliente.Limpa;
  edtAnimal.Limpa;
  edtCategoria.Limpa;
  edtEspecie.Limpa;
  edtValor.Clear;
  edtNomeAnimal.Clear;
  if chkClienteCadastrado.Checked then
    edtCliente.SetFocus
  else
    edtNomeCliente.SetFocus;
  CdsServico.Append;

end;

procedure TfrmVenda.btnGravarClick(Sender: TObject);
var
  TotalCaixa : Currency;
  Dia: Integer;
  DataVencimento: TDate;
begin
  inherited;
  if (CdsServico.FieldByName('DATA').AsDateTime = 0) OR
     (CdsServico.FieldByName('DATA').AsDateTime <= StrToDate('01/01/1990')) or
     (CdsServico.FieldByName('DATA').AsDateTime >= StrToDate('01/01/2020')) Then
  Begin
    edtData.SetFocus;
    Avisa('Data inválida');
    Exit;
  End;
  if CdsItens.IsEmpty then
  Begin
    Avisa('Não existe itens para vender!');
    Abort;
  End;
  try
    Try
      frmOBS := TfrmOBS.Create(nil);
      frmFechamento := TfrmFechamento.Create(Self);
      frmFechamento.TotalVenda := Self.ValorTotal;
      frmFechamento.IdServico := CdsServico.FieldByName('IDSERVICO').AsInteger;
      if CdsServico.FieldByName('IDSERVICO').AsString <> '' then
      Begin
        if frmFechamento.CdsPagamentos.Locate('TIPOFORMAPAGAMENTO','F',[]) Then
        Begin
           frmFechamento.CdsPagamentos.Edit;
           frmFechamento.CdsPagamentos.FieldByName('VALOR').AsCurrency := ValorTotal;
           frmFechamento.CalculaTotal;
        End;

      End;
      if frmFechamento.ShowModal = mrCancel then
        Exit;

      frmOBS.mmObs.Text := CdsServico.FieldByName('OBS').AsString;

      frmOBS.ShowModal;
      StartTrans;
      CdsServico.FieldByName('OBS').AsString := frmOBS.mmObs.Text;
      CdsServico.FieldByName('VALORACRESCIMO').AsCurrency := frmFechamento.edtValAcres.Value;
      CdsServico.FieldByName('VALORDESCONTO').AsCurrency :=  frmFechamento.edtValDesc.Value;
      CdsServico.FieldByName('VALORTOTAL').AsCurrency := ValorTotal;
      CdsServico.FieldByName('VALORTOTALLIQUIDO').AsCurrency :=
          (ValorTotal+CdsServico.FieldByName('VALORACRESCIMO').AsCurrency) -
          CdsServico.FieldByName('VALORDESCONTO').AsCurrency;
      CdsServico.FieldByName('HORA').AsString := GetHoraServidor;
      if not chkClienteCadastrado.Checked then
      Begin
        CdsServico.FieldByName('NOMECLIENTE').AsString := edtNomeCliente.Text;
        CdsServico.FieldByName('IDCLIENTE').Clear;
      End;
      CdsServico.Post;
      AlteraBanco(taInsere, CdsServico,'SERVICO','IDSERVICO');
      CdsItens.First;
      while not CdsItens.Eof do
      Begin
        AlteraBanco(taInsere, CdsItens,'SERVICODETALHE','IDSERVICODETALHE');
        CdsItens.Next;
      End;
      frmFechamento.CdsPagamentos.Filter := 'VALOR IS NOT NULL';
      frmFechamento.CdsPagamentos.Filtered := True;
      frmFechamento.CdsPagamentos.First;
      TotalCaixa := 0;
      while not frmFechamento.CdsPagamentos.Eof do
      Begin
        AlteraBanco(taInsere, frmFechamento.CdsPagamentos,'SERVICOFORMAPAGAMENTO','IDSERVICOFORMAPAGAMENTO');
        if frmFechamento.CdsPagamentos.FieldByName('TIPOFORMAPAGAMENTO').AsString = 'D' then
          TotalCaixa := TotalCaixa + frmFechamento.CdsPagamentos.FieldByName('VALOR').AsCurrency;
        if frmFechamento.CdsPagamentos.FieldByName('TIPOFORMAPAGAMENTO').AsString = 'F' then
        Begin
          Dia := StrToInt(GetValorCds('SELECT COALESCE(DIAPAGAMENTO,5) '+
                                      '  FROM CLIENTE '+
                                      ' WHERE IDCLIENTE = '+edtCliente.ValorChaveString));
          DataVencimento := AddDay(Dia, edtData.Date);
          Exec_SQL('INSERT INTO CONTARECEBER (IDCONTARECEBER, DATACRIACAO, DATA, DATAVENCIMENTO, VALOR, IDUSUARIO, FLAGCANCELADA,'+
                   '                          DATACANCELADA, IDUSUARIOCANCELADA, FLAGPAGO, VALORPAGO, DATAPAGO, IDSERVICO, IDCLIENTE,HISTORICO)'+
                   ' VALUES (GEN_ID(SEQ_IDCONTARECEBER,1), CURRENT_DATE, '+GetData(edtData.Date)+', '+GetData(DataVencimento)+', '+
                            GetNumber(frmFechamento.CdsPagamentos.FieldByName('VALOR').AsCurrency)+','+
                            GetInteger(CdsServico.FieldByName('idusuario').AsInteger)+', ''N'', NULL,'+
                   '        NULL, ''N'', NULL, NULL, '+GetInteger(CdsServico.FieldByName('IDSERVICO').AsInteger)+', '+
                   GetInteger(CdsServico.FieldByName('idcliente').AsInteger)+','+GetStr('Referente à venda '+lblServico.Caption)+')');

        End;
        frmFechamento.CdsPagamentos.Next;
      End;
      GetCodigo(tpPetServico);
      if TotalCaixa > 0 then
      Begin
        Exec_SQL('INSERT INTO CAIXA (IDCAIXA, DATA, FLAGOPERACAO, VALOR, IDUSUARIO, IDSERVICO, HISTORICO) '+
                 '           VALUES (GEN_ID(SEQ_IDCAIXA,1), '+GetData(edtData.Date)+', ''C'', '+GetNumber(TotalCaixa)+', '+
                             GetInteger(CdsServico.FieldByName('IDUSUARIO').AsInteger)+','+
                             GetInteger(CdsServico.FieldByName('IDSERVICO').AsInteger)+','+
                             GetStr('Referente à venda '+lblServico.Caption)+')');
      End;
      Exec_SQL('UPDATE EMPRESA SET NUMSERVICO = COALESCE(NUMSERVICO,0)+1 WHERE IDEMPRESA = '+CdsServico.FieldByName('idempresa').AsString);
      if IdAgenda <> -1 then
        Exec_SQL('UPDATE AGENDA SET FLAGBAIXADA = ''Y'' WHERE IDAGENDA = '+GetInteger(IdAgenda));
      Commit;
      Imp_ReciboPet(CdsServico.FieldByName('idempresa').AsInteger,CdsServico.FieldByName('IDSERVICO').AsInteger);
      btnCancelarClick(nil);
    Finally
      FreeAndNil(frmFechamento);
      FreeAndNil(frmOBS);
    End;
  except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  end;
end;

procedure TfrmVenda.CdsItensAfterOpen(DataSet: TDataSet);
begin
  inherited;
 CdsItens.FieldByName('NOMETIPOSERVICO').ProviderFlags := [];
 CdsItens.FieldByName('NOMETIPOANIMAL').ProviderFlags := [] ;
 //CdsItens.FieldByName('NOMEPROFISSIONAL').ProviderFlags := [] ;
 FormataMascara(CdsItens.FieldByName('VALOR'),tcMoeda);
end;

procedure TfrmVenda.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItens.FieldByName('IDSERVICO').AsString := CdsServico.FieldByName('IDSERVICO').AsString ;
  CdsItens.FieldByName('IDSERVICODETALHE').AsString := GetCodigo(tpPetServicoDetalhe);

end;

procedure TfrmVenda.CdsServicoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsServico.FieldByName('LOGIN').ProviderFlags := [] ;
end;

procedure TfrmVenda.CdsServicoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsServico.FieldByName('DATA').AsString := GetDataServidor;
  CdsServico.FieldByName('IDUSUARIO').AsInteger := USuarioLogado.Id;
  CdsServico.FieldByName('IDEMPRESA').AsInteger := USuarioLogado.IdLoja;
  CdsServico.FieldByName('IDSERVICO').AsString := GetCodigo(tpPetServico,ttcCodigo);
  CdsServico.FieldByName('NUMSERVICO').AsString := GetValorCds(tpPetEmpresa,'IDEMPRESA = '+CdsServico.FieldByName('IDEMPRESA').AsString,'NUMSERVICO');
  if CdsServico.FieldByName('NUMSERVICO').AsString = '' then
    CdsServico.FieldByName('NUMSERVICO').AsString := '1';
  CdsServico.FieldByName('NUMSERVICO').AsString := PadL(CdsServico.FieldByName('NUMSERVICO').AsString,6,'0');

  ValorTotal := 0;
  lblServico.Caption := CdsServico.FieldByName('NUMSERVICO').AsString;

end;

procedure TfrmVenda.chkClienteCadastradoClick(Sender: TObject);
begin
  inherited;
  if chkClienteCadastrado.Checked then
    PageControl.ActivePage := tsClienteCadastrado
  else
    PageControl.ActivePage := tsClienteNaoCadastrado;

end;

procedure TfrmVenda.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = Vk_Delete then
    if ConfirmaDel then
       CdsItens.Delete;
end;

procedure TfrmVenda.edtAnimalBtnEditarClick(Sender: TObject);
begin
  inherited;
  AbreCadastroAnimal(False,True,-1,edtAnimal.ValorChaveInteger) ;
end;

procedure TfrmVenda.edtAnimalBtnNovoClick(Sender: TObject);
begin
  inherited;
  VerificaEdit(edtCliente,'Informe o cliente primeiro');
  edtAnimal.ValorChave := AbreCadastroAnimal(True,False,edtCliente.ValorChaveInteger);
  edtAnimal.Localiza;
end;

procedure TfrmVenda.edtAnimalRegAchado(ADataSet: TDataSet);
begin
  inherited;
  with GetCds(tpPetAnimal,'IDANIMAL = '+edtAnimal.ValorChaveString) DO
  Begin
    edtEspecie.ValorChave := FieldByName('IDTIPOANIMAL').AsInteger;
    edtCategoria.ValorChave := FieldByName('IDCATEGORIAANIMAL').AsInteger;
    edtEspecie.Localiza;
    edtCategoria.Localiza;
    Free;
  End;
end;

procedure TfrmVenda.edtCategoriaEnter(Sender: TObject);
begin
  inherited;
  VerificaEdit(edtEspecie,'Informe a espécie');
end;

procedure TfrmVenda.edtClienteBtnEditarClick(Sender: TObject);
begin
  inherited;
  AbreCadastroCliente(False,True, edtCliente.ValorChaveInteger);
end;

procedure TfrmVenda.edtClienteBtnNovoClick(Sender: TObject);
begin
  inherited;
  CdsServico.FieldByName('IDCLIENTE').AsInteger := AbreCadastroCliente(True);
  edtCliente.Localiza;
end;

procedure TfrmVenda.edtClienteRegAchado(ADataSet: TDataSet);
begin
  inherited;
  edtAnimal.SQLComp := 'A.idcliente = '+edtCliente.ValorChaveString;
end;

procedure TfrmVenda.edtClienteRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
begin
  inherited;
  edtAnimal.SQLComp := '';
end;

procedure TfrmVenda.edtEspecieRegAchado(ADataSet: TDataSet);
begin
  inherited;
  edtCategoria.SQLComp := ' IDTIPOANIMAL = '+edtEspecie.ValorChaveString;
end;

procedure TfrmVenda.edtProfissionalRegAchado(ADataSet: TDataSet);
var
  Nome: String;
begin
  inherited;
  SetCds(CdsProfissional,tpPetProfissional,'IDPROFISSIONAL = '+edtProfissional.ValorChaveString);
  if CdsProfissional.FieldByName('FLAGPEDIRNOME').AsString = 'Y' then
  Begin
    if InputQuery(Application.Title,'Informe o nome do profissional: ',Nome) then
    Begin
      CdsProfissional.Edit;
      CdsProfissional.FieldByName('NOMEPROFISSIONAL').AsString := Nome;
      CdsProfissional.Post;
    End else
    Begin
      edtProfissional.SetFocus;
      Abort;
    End;
  End;


end;

procedure TfrmVenda.edtTipoServicoRegAchado(ADataSet: TDataSet);
var
  StrWh: String;
begin
  inherited;
  StrWh :=
     ' idtiposervico = '+edtTipoServico.ValorChaveString+
     ' AND IDCATEGORIAANIMAL = '+ edtCategoria.ValorChaveString;
  with GetCds(tpPetPrecoServico,StrWh) do
  Begin
    edtValor.Value := FieldByName('PRECO').AsCurrency;
    ValorOriginal := FieldByName('PRECO').AsCurrency;
    Free;
  End;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.HideTabs := True;
  PageControl.ActivePageIndex := 0;
  SetCds(CdsServico,tpPetServico,'1<>1');
  SetCds(CdsItens,tpPetServicoDetalhe,'1<>1');
  CdsServico.EmptyDataSet;
  CdsServico.Append;
  ConfiguraEditPesquisa(edtCliente,CdsServico,tpPetCliente);
  ConfiguraEditPesquisa(edtAnimal,nil,tpPetAnimal);
  edtAnimal.OnAbrePesquisa := vPesq.AbreEditPesquisaAimal;
  edtAnimal.NomeTabela := 'ANIMAL A';
  ConfiguraEditPesquisa(edtEspecie,nil,tpPetTipoAnimal);
  ConfiguraEditPesquisa(edtTipoServico,nil,tpPetTipoServico);
  ConfiguraEditPesquisa(edtProfissional,nil,tpPetProfissional);
  ConfiguraEditPesquisa(edtCategoria,nil,tpPetCategoriaAnimal);

  {edtCliente.AutoCompletar := False;
  edtEspecie.AutoCompletar := False;
  edtTipoServico.AutoCompletar := False;
  edtProfissional.AutoCompletar := False;
  edtCategoria.AutoCompletar := False;}

end;

procedure TfrmVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if KEY = VK_F9 then
    btnGravarClick(nil);
end;

procedure TfrmVenda.FormShow(Sender: TObject);
begin
  inherited;
  if IdAgenda <> -1 then
    edtProfissional.SetFocus;
end;

procedure TfrmVenda.SetIdAgenda(const Value: Integer);
var
  StrSQL: String;
begin
  FIdAgenda := Value;
  if FIdAgenda <> -1 then
  Begin
    StrSQL:=
      'SELECT A.IDANIMAL, A.IDPROFISSIONAL,'+
      '       A.OBS,A.IDTIPOSERVICO, AN.IDCLIENTE '+
      '  FROM AGENDA A'+
      '  LEFT JOIN ANIMAL AN'+
      '    ON (AN.IDANIMAL = A.IDANIMAL)'+
      ' WHERE A.IDAGENDA = '+GetInteger(FIdAgenda);
    with GetCds(StrSQL) do
    Begin
      CdsServico.FieldByName('IDAGENDA').AsInteger := FIdAgenda;
      CdsServico.FieldByName('IDCLIENTE').AsString := FieldByName('IDCLIENTE').AsString;
      CdsServico.FieldByName('obs').AsString := FieldByName('OBS').AsString;
      edtTipoServico.ValorChave := FieldByName('IDTIPOSERVICO').AsString;
      edtAnimal.ValorChave := FieldByName('IDANIMAL').AsString;
      edtCliente.Localiza;
      edtAnimal.Localiza;
      edtTipoServico.Localiza;
      Free;
    End;
  End;


end;

procedure TfrmVenda.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
  lblTotal.Caption := FormatFloat(MascaraMoeda,Value);
end;

end.
