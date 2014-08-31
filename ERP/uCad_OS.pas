unit uCad_OS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, DB, DBClient,
  pFIBClientDataSet, ActnList, cxPC, cxContainer, cxEdit, cxTreeView, Buttons,
  ExtCtrls, DBCtrls, LabelDBEdit, StdCtrls, Mask, EditPesquisa, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxMemo,ulibERP;

type
  TfrmCad_OS = class(TfrmCad_CadastroPaiERP)
    Panel2: TPanel;
    Label1: TLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    edtEmpresa: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    edtTipoOS: TEditPesquisa;
    edtStatusOS: TEditPesquisa;
    edtCliente: TEditPesquisa;
    LabelDBEdit2: TLabelDBEdit;
    PageControlOpcoes: TcxPageControl;
    tsEquipamento: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    CdsEquipamento: TpFIBClientDataSet;
    CdsServicoEquipamento: TpFIBClientDataSet;
    CdsProdutoServicoEquipamento: TpFIBClientDataSet;
    DataEquipamento: TDataSource;
    DataServicoEquipamento: TDataSource;
    DataProdutoServicoEquipamento: TDataSource;
    cxGrid1: TcxGrid;
    tvItens: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    tvItensColumn1: TcxGridDBColumn;
    tvItensColumn2: TcxGridDBColumn;
    cxDBMemo1: TcxDBMemo;
    actIncluirEquipamento: TAction;
    actAlterarEquipamento: TAction;
    actExcluirEquipamento: TAction;
    DataSerialOS: TDataSource;
    CdsSerialOS: TpFIBClientDataSet;
    EdtCompetenciaContrato: TEditPesquisa;
    procedure actIncluirEquipamentoExecute(Sender: TObject);
    procedure actAlterarEquipamentoExecute(Sender: TObject);
    procedure actExcluirEquipamentoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsEquipamentoNewRecord(DataSet: TDataSet);
    procedure CdsServicoEquipamentoAfterScroll(DataSet: TDataSet);
    procedure CdsServicoEquipamentoNewRecord(DataSet: TDataSet);
    procedure CdsProdutoServicoEquipamentoNewRecord(DataSet: TDataSet);
    procedure CdsProdutoServicoEquipamentoBeforePost(DataSet: TDataSet);
    procedure CdsProdutoServicoEquipamentoBeforeDelete(DataSet: TDataSet);
    procedure CdsEquipamentoAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsServicoEquipamentoBeforePost(DataSet: TDataSet);
    procedure CdsEquipamentoBeforePost(DataSet: TDataSet);
    procedure actGravarExecute(Sender: TObject);
    procedure CdsProdutoServicoEquipamentoAfterScroll(DataSet: TDataSet);
    procedure CdsProdutoServicoEquipamentoAfterOpen(DataSet: TDataSet);
    procedure CdsServicoEquipamentoAfterOpen(DataSet: TDataSet);
    procedure CdsProdutoServicoEquipamentoAfterPost(DataSet: TDataSet);
    procedure CdsProdutoServicoEquipamentoAfterEdit(DataSet: TDataSet);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsCadastroBeforePost(DataSet: TDataSet);
    procedure edtClienteRegAchado(const ValoresCamposEstra: array of Variant);
    procedure EdtCompetenciaContratoRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    FIdProposta: TipoCampoChave;
    FIdContrato: TipoCampoChave;

    { Private declarations }
    Procedure AddSerial;
    procedure SetIdProposta(const Value: TipoCampoChave);
    procedure SetIdContrato(const Value: TipoCampoChave);
    procedure ImportaContrato;

  public
    { Public declarations }
    property IdProposta: TipoCampoChave read FIdProposta write SetIdProposta;
    property IdContrato: TipoCampoChave read FIdContrato write SetIdContrato;

  end;

var
  frmCad_OS: TfrmCad_OS;

implementation

uses UDmConexao, MinhasClasses, Comandos, uDlg_EquipamentoOS,
  uDlg_ExecucaoOSEquipamento, uPesquisa_kimera, uRegras, udlg_SaidaSerial,
  uConstantes, uConfiguracaoOS;

{$R *.dfm}

procedure TfrmCad_OS.actAlterarEquipamentoExecute(Sender: TObject);
var
  NaoIniciou: Boolean;
begin
  inherited;
  if  (NovoReg) and (IdContrato = SemID) then
  begin
    Try
      frmDlg_EquipamentoOS := TfrmDlg_EquipamentoOS.Create(nil);
      frmDlg_EquipamentoOS.pDataSet := Self.CdsEquipamento;
      frmDlg_EquipamentoOS.FechaEGrava := True;
      frmDlg_EquipamentoOS.pDataSet.Edit;
      frmDlg_EquipamentoOS.IdCliente := CdsCadastro.FieldByName('IDCLIENTE').Value;
      frmDlg_EquipamentoOS.ShowModal;
    Finally
      FreeAndNil(frmDlg_EquipamentoOS);
    End;
  end else
  begin
     Try
      frmDlg_ExecucaoOSEquipamento := TfrmDlg_ExecucaoOSEquipamento.Create(nil);
      frmDlg_ExecucaoOSEquipamento.pDataSet := Self.CdsEquipamento;
      frmDlg_ExecucaoOSEquipamento.FechaEGrava := True;
      frmDlg_ExecucaoOSEquipamento.IdCliente := CdsCadastro.FieldByName('IDCLIENTE').Value;
      frmDlg_ExecucaoOSEquipamento.IdEmpresa := CdsCadastro.FieldByName('IdEmpresa').Value;
      frmDlg_ExecucaoOSEquipamento.Data := CdsCadastro.FieldByName('Data').AsDateTime;
      frmDlg_ExecucaoOSEquipamento.pDataSetServico := Self.CdsServicoEquipamento;
      frmDlg_ExecucaoOSEquipamento.DataSetProdutos := Self.CdsProdutoServicoEquipamento;
      frmDlg_ExecucaoOSEquipamento.DataSetProdutosSerial := Self.CdsSerialOS;
      frmDlg_ExecucaoOSEquipamento.pDataSet.Edit;
      NaoIniciou := Self.CdsServicoEquipamento.RecordCount = 0;
      if frmDlg_ExecucaoOSEquipamento.ShowModal = mrOK Then
      begin
         Self.CdsCadastro.FieldByName('VALORTOTAL').Value := frmDlg_ExecucaoOSEquipamento.tvItens.DataController.Summary.FooterSummaryValues[0];
         if NaoIniciou then
         begin
           Self.CdsCadastro.FieldByName('DATAINICIO').Value := GetDataServidor;
           Self.CdsCadastro.FieldByName('HORAINICIO').Value := GetHoraServidor;
         end;
      end;

    Finally
      FreeAndNil(frmDlg_ExecucaoOSEquipamento);
    End;
  end;

end;

procedure TfrmCad_OS.actExcluirEquipamentoExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    CdsEquipamento.Edit ;
    CdsEquipamento.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsEquipamento.Post ;
  end;

end;

procedure TfrmCad_OS.actGravarExecute(Sender: TObject);
begin
  VerificaEdit(edtEmpresa,'Informe a empresa');
  VerificaEdit(edtCliente,'Informe o cliente');
  VerificaEdit(edtTipoOS,'Informe o tipo de O.S.');
  VerificaEdit(edtStatusOS,'Informe o status dessa O.S.');
  if CdsEquipamento.IsEmpty then
  begin
    Avisa('Informe ao menos umequipamento');
    Exit;
  end;

  if CdsCadastro.FieldByName('FLAGBAIXADA').AsString = 'Y' then
  Begin
    Avisa('Essa O.S.Já foi baixada, por isso não pode ser alterada.');
    Exit;
  End;

  Try
    CdsEquipamento.DisableControls;

    CdsEquipamento.First;
    while not CdsEquipamento.Eof do
    begin
      if Trim(CdsEquipamento.FieldByName('DETALHEDEFEITO').AsString) = '' Then
      Begin
        Avisa('O equipamento '+CdsEquipamento.FieldByName('IDENTIFICADOR').AsString+' não possui detalhes da ocorrência' );
        Exit;
        Break;
      End;
      CdsEquipamento.Next;
    end;
  Finally
    CdsEquipamento.EnableControls;
  End;


  inherited;

end;

procedure TfrmCad_OS.actIncluirEquipamentoExecute(Sender: TObject);
var
  NaoIniciou: Boolean;
begin
  inherited;
  if (NovoReg) and (IdContrato = SemID)  then
  begin
    Try
      frmDlg_EquipamentoOS := TfrmDlg_EquipamentoOS.Create(nil);
      frmDlg_EquipamentoOS.pDataSet := Self.CdsEquipamento;
      frmDlg_EquipamentoOS.FechaEGrava := False;
      frmDlg_EquipamentoOS.IdCliente := CdsCadastro.FieldByName('IDCLIENTE').Value;
      frmDlg_EquipamentoOS.pDataSet.Append;
      frmDlg_EquipamentoOS.ShowModal;
    Finally
      FreeAndNil(frmDlg_EquipamentoOS);
    End;

  end else
  begin
    Try
      frmDlg_ExecucaoOSEquipamento := TfrmDlg_ExecucaoOSEquipamento.Create(nil);
      frmDlg_ExecucaoOSEquipamento.pDataSet := Self.CdsEquipamento;
      frmDlg_ExecucaoOSEquipamento.FechaEGrava := True;
      frmDlg_ExecucaoOSEquipamento.IdCliente := CdsCadastro.FieldByName('IDCLIENTE').Value;
      frmDlg_ExecucaoOSEquipamento.IdEmpresa := CdsCadastro.FieldByName('IdEmpresa').Value;
      frmDlg_ExecucaoOSEquipamento.Data := CdsCadastro.FieldByName('Data').AsDateTime;
      frmDlg_ExecucaoOSEquipamento.pDataSetServico := CdsServicoEquipamento;
      frmDlg_ExecucaoOSEquipamento.DataSetProdutos := Self.CdsProdutoServicoEquipamento;
      frmDlg_ExecucaoOSEquipamento.DataSetProdutosSerial := Self.CdsSerialOS;
      frmDlg_ExecucaoOSEquipamento.pDataSet.Append;
      NaoIniciou := Self.CdsServicoEquipamento.RecordCount = 0;
      if frmDlg_ExecucaoOSEquipamento.ShowModal = mrOK Then
      begin
         Self.CdsCadastro.FieldByName('VALORTOTAL').Value := frmDlg_ExecucaoOSEquipamento.tvItens.DataController.Summary.FooterSummaryValues[0];
         if NaoIniciou then
         begin
           Self.CdsCadastro.FieldByName('DATAINICIO').Value := GetDataServidor;
           Self.CdsCadastro.FieldByName('HORAINICIO').Value := GetHoraServidor;
         end;
      end;
    Finally
      FreeAndNil(frmDlg_ExecucaoOSEquipamento);
    End;

  end;

end;

procedure TfrmCad_OS.AddSerial;
var
  I: Integer;
begin
   Try
        frmDlg_SaidaSerial := TfrmDlg_SaidaSerial.Create(nil);
        frmDlg_SaidaSerial.IdProduto := CdsProdutoServicoEquipamento.FieldByName('IDPRODUTO').Value;
        if frmDlg_SaidaSerial.CdsSeriais.IsEmpty then
          Exit;
        Self.CdsSerialOS.First;
        while not Self.CdsSerialOS.Eof do
        begin
          if frmDlg_SaidaSerial.CdsSeriais.Locate('serial',Self.CdsSerialOS.FieldByName('serial').AsString,[]) Then
          Begin
            frmDlg_SaidaSerial.CdsSeriais.Edit;
            frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').AsString := 'U';
            frmDlg_SaidaSerial.CdsSeriais.Post;
          end;
          Self.CdsSerialOS.Next;
        end;
        if frmDlg_SaidaSerial.ShowModal = mrOK Then
        begin
          frmDlg_SaidaSerial.CdsSeriais.First;
          I:= 0;
          while not frmDlg_SaidaSerial.CdsSeriais.Eof do
          begin
            if  frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').Value = 'N' then
            begin
               frmDlg_SaidaSerial.CdsSeriais.Next;
               Continue;
            end;
            if Self.CdsSerialOS.Locate('IDPRODUTOSSERVICOOS;Serial',
                       VarArrayOf([CdsProdutoServicoEquipamento.FieldByName('IDPRODUTOSSERVICOOS').Value,
                                   frmDlg_SaidaSerial.CdsSeriais.FieldByName('serial').AsString]),[]) then
              Self.CdsSerialOS.Edit
            else
            begin
              Self.CdsSerialOS.Append;
              Self.CdsSerialOS.FieldByName('IDSERIALPRODUTOOS').Value := GetCodigo(tpERPSerialProdutoOS);
            end;
            Self.CdsSerialOS.FieldByName('SERIAL').Value :=  frmDlg_SaidaSerial.CdsSeriais.FieldByName('SERIAL').Value;
            Self.CdsSerialOS.FieldByName('IDSERIALPRODUTO').Value :=  frmDlg_SaidaSerial.CdsSeriais.FieldByName('IDSERIALPRODUTO').Value;
            Self.CdsSerialOS.FieldByName('FLAGEDICAO').Value :=  frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').Value;
            Self.CdsSerialOS.FieldByName('IDPRODUTOSSERVICOOS').Value := CdsProdutoServicoEquipamento.FieldByName('IDPRODUTOSSERVICOOS').AsString;

            Self.CdsSerialOS.Post;
            if  frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').Value = 'U' then
              Inc(I);
            frmDlg_SaidaSerial.CdsSeriais.Next;
          end;
          CdsProdutoServicoEquipamento.FieldByName('quantidade').Value := I;
//          CdsProdutoServicoEquipamento.Post;
//          Self.CdsSerialOS.Filtered := True;
//          CdsProdutoServicoEquipamento.AfterEdit := nil;
//          CdsProdutoServicoEquipamento.Edit;
//          CdsProdutoServicoEquipamento.AfterEdit := CdsProdutoServicoEquipamentoAfterEdit;
        end;
      Finally
        FreeAndNil(frmDlg_SaidaSerial);
      End;

end;

procedure TfrmCad_OS.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsEquipamento,tpERPEquipamentoOS);
  SetRegistros(CdsServicoEquipamento,tpERPServicoEquipamentoOS);
  SetRegistros(CdsProdutoServicoEquipamento,tpERPProdutoServicoOS);
  SetRegistros(CdsSerialOS,tpERPSerialProdutoOS);

end;

procedure TfrmCad_OS.CdsCadastroAfterScroll(DataSet: TDataSet);
var
  StrSQL: String;
begin
  inherited;
  Try
    Self.CdsEquipamento.AfterScroll := nil;
    SetCds(Self.CdsEquipamento,tpERPEquipamentoOS,' IDOS = '+TipoCampoChaveToStr(ValorChave));

    StrSQL:=
       '  EXISTS(SELECT 1  '+
       '           FROM EQUIPAMENTOSOS E  '+
       '          WHERE E.IDOS =   '+TipoCampoChaveToStr(ValorChave)+
       '            AND E.IDEQUIPAMENTOSOS = S.IDEQUIPAMENTOSOS) ';

    SetCds(Self.CdsServicoEquipamento,tpERPServicoEquipamentoOS,StrSQL);

    SetCds(Self.CdsSerialOS,tpERPSerialProdutoOS,'os.idos = '+TipoCampoChaveToStr(ValorChave));
    StrSQL:=
       ' EXISTS(SELECT 1   '+
       '         FROM SERVICOOS S  '+
       '        WHERE S.IDSERVICOOS =PS.IDSERVICOOS  '+
       '          AND EXISTS(SELECT 1  '+
       '                       FROM EQUIPAMENTOSOS E  '+
       '                      WHERE E.IDOS =   '+TipoCampoChaveToStr(ValorChave)+
       '                        AND E.IDEQUIPAMENTOSOS = S.IDEQUIPAMENTOSOS) '+
       '                         ) ';
    SetCds(Self.CdsProdutoServicoEquipamento,tpERPProdutoServicoOS,StrSQL);






  Finally
    Self.CdsEquipamento.AfterScroll := CdsEquipamentoAfterScroll;
    CdsEquipamentoAfterScroll(Self.CdsEquipamento);
  End;

end;

procedure TfrmCad_OS.CdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (not NovoReg) and (CdsCadastro.FieldByName('IDSTATUSOS').AsString = COnfiguracaoOS.GetConfiguracao(tpcERPStatusOSAberta)) then
   CdsCadastro.FieldByName('IDSTATUSOS').AsString := COnfiguracaoOS.GetConfiguracao(tpcERPStatusOSExecucao);

end;

procedure TfrmCad_OS.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  if NovoReg then
   CdsCadastro.FieldByName('IDSTATUSOS').AsString := COnfiguracaoOS.GetConfiguracao(tpcERPStatusOSAberta);
end;

procedure TfrmCad_OS.CdsEquipamentoAfterScroll(DataSet: TDataSet);
var
  IdEquipamento: TipoCampoChave;
begin
  inherited;
  if CdsEquipamento.FieldByName('IDEQUIPAMENTOSOS').AsString <> '' then
    IdEquipamento := CdsEquipamento.FieldByName('IDEQUIPAMENTOSOS').AsString
  else
    IdEquipamento := SemID;

  CdsServicoEquipamento.Filter := '(FLAGEDICAO <>''D'') and IDEQUIPAMENTOSOS = '+TipoCampoChaveToStr(IdEquipamento);
  CdsServicoEquipamento.Filtered := True;

end;

procedure TfrmCad_OS.CdsEquipamentoBeforePost(DataSet: TDataSet);
begin
  inherited;
 if CdsEquipamento.FieldByName('FLAGEDICAO').AsString = 'N' then
    CdsEquipamento.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_OS.CdsEquipamentoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsEquipamento.FieldByName('IDEQUIPAMENTOSOS').AsString:= GetCodigo(tpERPEquipamentoOS);
  CdsEquipamento.FieldByName('IDOS').AsString:= ValorChave;
  CdsEquipamento.FieldByName('FLAGEDICAO').AsString:= 'I';
end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoAfterEdit(DataSet: TDataSet);
begin
  inherited;
  AddSerial;
end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    if DataSet.Fields[i].DataType in [ftFloat,ftCurrency,ftBCD] then
       FormataMascara(DataSet.Fields[i],tcReal);
  end;

end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoAfterPost(DataSet: TDataSet);
begin
  inherited;
  CdsServicoEquipamentoAfterScroll(CdsServicoEquipamento);
end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoAfterScroll(DataSet: TDataSet);
var
  IdServico: TipoCampoChave;
begin
  inherited;
  if CdsProdutoServicoEquipamento.FieldByName('IDPRODUTOSSERVICOOS').AsString<> '' Then
    IdServico := CdsProdutoServicoEquipamento.FieldByName('IDPRODUTOSSERVICOOS').AsString
  else
    IdServico := SemID;

  CdsSerialOS.Filter :=' (FLAGEDICAO <> ''D'')  and (IDPRODUTOSSERVICOOS = '+TipoCampoChaveToStr(IdServico)+  ')';

  CdsSerialOS.Filtered := True;

end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoBeforeDelete(
  DataSet: TDataSet);
begin
  inherited;
  CdsProdutoServicoEquipamento.Edit;
  CdsProdutoServicoEquipamento.FieldByName('FLAGEDICAO').AsString := 'D';
  CdsProdutoServicoEquipamento.Post;
  Abort;
end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsProdutoServicoEquipamento.FieldByName('quantidade').AsCurrency <= 0 then
    AvisaErro('Informe a quantidade ');
  if CdsProdutoServicoEquipamento.FieldByName('VALORUNITARIO').AsCurrency <= 0 then
    AvisaErro('Informe o valor unitario ');

  CdsProdutoServicoEquipamento.FieldByName('TOTAL').AsCurrency :=
      CdsProdutoServicoEquipamento.FieldByName('VALORUNITARIO').AsCurrency *
      CdsProdutoServicoEquipamento.FieldByName('quantidade').AsCurrency;
  if CdsProdutoServicoEquipamento.FieldByName('FLAGEDICAO').AsString = 'N' Then
    CdsProdutoServicoEquipamento.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_OS.CdsProdutoServicoEquipamentoNewRecord(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  CdsProdutoServicoEquipamento.FieldByName('IDSERVICOOS').AsString := CdsServicoEquipamento.FieldByName('IDSERVICOOS').AsString;
  CdsProdutoServicoEquipamento.FieldByName('IDALMOXARIFADO').AsString := CdsServicoEquipamento.FieldByName('IDALMOXARIFADO').AsString;
  CdsProdutoServicoEquipamento.FieldByName('IDPRODUTOSSERVICOOS').AsString := GetCodigo(tpERPProdutoServicoOS);
  CdsProdutoServicoEquipamento.FieldByName('FLAGEDICAO').AsString := 'I';


  frmPesquisa := TfrmPesquisa.Create(nil);
  Try
    frmPesquisa.TipoPesquisa := tpERPProduto;
    frmPesquisa.Where := 'TIPOPRODUTO not in('+QuotedStr(TipoProdutoServico)+','+QuotedStr(TipoProdutoUsoInternoEVenda)+') ';
    if frmPesquisa.ShowModal = mrOK Then
    begin
      CdsProdutoServicoEquipamento.FieldByName('IDPRODUTO').Value := frmPesquisa.cdsPesquisa.FieldByName('IDPRODUTO').Value;
      CdsProdutoServicoEquipamento.FieldByName('CODIGO').Value := frmPesquisa.cdsPesquisa.FieldByName('CODIGO').Value;
      CdsProdutoServicoEquipamento.FieldByName('DESCRICAO').Value := frmPesquisa.cdsPesquisa.FieldByName('NOMEPRODUTO').Value;
      CdsProdutoServicoEquipamento.FieldByName('VALORUNITARIO').Value :=
           TRegrasVendaProduto.PrecoVendaProduto(CdsProdutoServicoEquipamento.FieldByName('IDPRODUTO').Value,
                                                 CdsCadastro.FieldByName('IDCLIENTE').Value,
                                                 CdsCadastro.FieldByName('IDEMPRESA').Value,
                                                 CdsCadastro.FieldByName('DATA').AsDateTime );
     AddSerial;
    end;

  Finally
    FreeAndNil(frmPesquisa);
  End;

end;

procedure TfrmCad_OS.CdsServicoEquipamentoAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    if DataSet.Fields[i].DataType in [ftFloat,ftCurrency,ftBCD] then
       FormataMascara(DataSet.Fields[i],tcReal);
  end;

end;

procedure TfrmCad_OS.CdsServicoEquipamentoAfterScroll(DataSet: TDataSet);
var
  IdServico : TipoCampoChave;
begin
  inherited;
  if CdsServicoEquipamento.FieldByName('IDSERVICOOS').AsString <> '' then
    IdServico := CdsServicoEquipamento.FieldByName('IDSERVICOOS').AsString
  else
    IdServico := SemID;
  CdsProdutoServicoEquipamento.Filter := '(FLAGEDICAO <>''D'') and IDSERVICOOS = '+TipoCampoChaveToStr(IdServico);
  CdsProdutoServicoEquipamento.Filtered := True;
  
end;

procedure TfrmCad_OS.CdsServicoEquipamentoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsServicoEquipamento.FieldByName('FLAGEDICAO').AsString = 'N' then
    CdsServicoEquipamento.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_OS.CdsServicoEquipamentoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsServicoEquipamento.FieldByName('IDEQUIPAMENTOSOS').AsString := CdsEquipamento.FieldByName('IDEQUIPAMENTOSOS').AsString;
  CdsServicoEquipamento.FieldByName('IDSERVICOOS').AsString := GetCodigo(tpERPServicoEquipamentoOS) ;
  CdsServicoEquipamento.FieldByName('FLAGEDICAO').AsString := 'I';
  CdsServicoEquipamento.FieldByName('DATAINICIO').AsString := GetDataServidor;
  CdsServicoEquipamento.FieldByName('HORAINICIO').AsString := GetHoraServidor;
end;

procedure TfrmCad_OS.edtClienteRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  EdtCompetenciaContrato.SQLComp := '  exists (select 1 '+
                                    '               from contrato c '+
                                    '              where c.idcontrato =contratocompetencia.idcontrato '+
                                    '                and c.idcliente = '+TipoCampoChaveToStr(edtCliente.ValorChaveString)+')';
end;

procedure TfrmCad_OS.EdtCompetenciaContratoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  EdtCompetenciaContrato.Display.Text :=
      GetValorCds(tpERPCompetenciaContrato,
                  'idcontratocompetencia = '+TipoCampoChaveToStr(EdtCompetenciaContrato.ValorChaveString),
                  'COMPETENCIA');
end;

procedure TfrmCad_OS.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPOS;
  IdContrato:=SemID;
  IdProposta := SemID;
end;

procedure TfrmCad_OS.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtEmpresa, CdsCadastro, tpERPEmpresa,True);
  ConfiguraEditPesquisa(edtTipoOS, CdsCadastro, tpERPTipoOS,True);
  ConfiguraEditPesquisa(edtStatusOS, CdsCadastro, tpERPStatusOS,True);
  ConfiguraEditPesquisa(edtCliente, CdsCadastro, tpERPCliente,True);
  EdtCompetenciaContrato.Join:= ' INNER JOIN CONTRATO C ON (C.IDCONTRATO = CONTRATOCOMPETENCIA.IDCONTRATO) ';
  ConfiguraEditPesquisa(EdtCompetenciaContrato, CdsCadastro, tpERPCompetenciaContrato);

  if FIdProposta <> SemID then
  begin
    with GetCds(tpERPProposta,'idproposta = '+TipoCampoChaveToStr(FIdProposta)) do
    begin
      Self.CdsCadastro.FieldByName('IDEMPRESA').Value := FieldByName('IDEMPRESA').Value;
      Self.CdsCadastro.FieldByName('IDCLIENTE').Value := FieldByName('IDCLIENTE').Value;
      Self.CdsCadastro.FieldByName('IDPROPOSTA').Value := FIdProposta;
      Free;
    end;
  end;

  if IdContrato <> SemID then
  begin
   if TRegrasOS.ImportaContrato(IdContrato,CdsCadastro,CdsEquipamento,CdsServicoEquipamento) Then
     ModalResult := mrOK;
  end;

end;

procedure TfrmCad_OS.ImportaContrato;
var
  CdsCOntrato,CdsServicosContrato,
  CdsEquipamentoContrato: TpFIBClientDataSet;
begin
  Try
    CdsCOntrato := TpFIBClientDataSet.Create(nil);
    CdsServicosContrato := TpFIBClientDataSet.Create(nil);
    CdsEquipamentoContrato := TpFIBClientDataSet.Create(nil);
    SetCds(CdsCOntrato,tpERPContrato,'idcontrato= '+IdContrato);
//    SetCds(CdsEquipamentoContrato,tpERPClienteEquipamentoContrato,'idcontrato= '+IdContrato);
                                  { TODO : rever }
//    CdsCadastro.Append;
    CdsCadastro.FieldByName('idcliente').Value := CdsCOntrato.FieldByName('idcliente').Value;
    CdsCadastro.FieldByName('idempresa').Value := CdsCOntrato.FieldByName('idempresa').Value;

    CdsEquipamentoContrato.First;
    while not CdsEquipamentoContrato.Eof do
    begin
      CdsEquipamento.Append;
      CdsEquipamento.FieldByName('IDEQUIPAMENTOCLIENTE').Value := CdsEquipamentoContrato.FieldByName('IDCLIENTEEQUIPAMENTOS').Value;
      CdsEquipamento.FieldByName('DESCRICAOEQUIPAMENTO').Value := CdsEquipamentoContrato.FieldByName('DESCRICAOEQUIPAMENTO').Value;
      CdsEquipamento.FieldByName('IDENTIFICADOR').Value := CdsEquipamentoContrato.FieldByName('IDENTIFICADOR').Value;
      CdsEquipamento.Post;

      SetCds(CdsServicosContrato,tpERPServicoContrato,'IDCONTRATOEQUIPAMENTOCLIENTE= '+CdsEquipamentoContrato.FieldByName('IDCONTRATOEQUIPAMENTOCLIENTE').AsString);

      CdsServicosContrato.First;
      while not CdsServicosContrato.Eof do
      begin
        CdsServicoEquipamento.Append;
        CdsServicoEquipamento.FieldByName('IDPRODUTO').Value := CdsServicosContrato.FieldByName('IDPRODUTO').Value;
        CdsServicoEquipamento.FieldByName('CODIGOSERVICO').Value := CdsServicosContrato.FieldByName('CODIGO').Value;
        CdsServicoEquipamento.FieldByName('DESCRICAOSERVICO').Value := CdsServicosContrato.FieldByName('NOMEPRODUTO').Value;
//        CdsServicoEquipamento.FieldByName('QUANTIDADE').Value := CdsServicosContrato.FieldByName('QUANTIDADE').Value;

        CdsServicoEquipamento.FieldByName('VALORSERVICO').Value := CdsServicosContrato.FieldByName('VALORUNITARIO').Value;
//        CdsServicoEquipamento.FieldByName('VALORDESCONTO').Value := CdsServicosContrato.FieldByName('VALORDESCONTO').Value;
//        CdsServicoEquipamento.FieldByName('VALORACRESCIMO').Value := CdsServicosContrato.FieldByName('VALORACRESCIMO').Value;
//        CdsServicoEquipamento.FieldByName('VALORTOTAL').Value := CdsServicosContrato.FieldByName('VALORTOTAL').Value;
//        CdsServicoEquipamento.FieldByName('OBS').Value := CdsServicosContrato.FieldByName('OBS').Value;
//        CdsServicoEquipamento.FieldByName('ALIQDESCONTO').Value := CdsServicosContrato.FieldByName('ALIQDESCONTO').Value;
//        CdsServicoEquipamento.FieldByName('ALIQACRESCIMO').Value := CdsServicosContrato.FieldByName('ALIQACRESCIMO').Value;
        CdsServicoEquipamento.FieldByName('VALORSERVICO').Value := CdsServicosContrato.FieldByName('SUBTOTAL').Value;
        CdsServicoEquipamento.FieldByName('VALORTOTAL').Value := CdsServicosContrato.FieldByName('SUBTOTAL').Value;

        CdsServicoEquipamento.Post;
        CdsServicosContrato.Next
      end;

      CdsEquipamentoContrato.Next;
    end;


  Finally
    FreeAndNil(CdsCOntrato);
    FreeAndNil(CdsServicosContrato);
    FreeAndNil(CdsEquipamentoContrato);
  End;


end;


procedure TfrmCad_OS.SetIdContrato(const Value: TipoCampoChave);
begin
  FIdContrato := Value;

end;

procedure TfrmCad_OS.SetIdProposta(const Value: TipoCampoChave);
begin
  FIdProposta := Value;

end;

end.
