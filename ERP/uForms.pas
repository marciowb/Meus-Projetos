unit uForms;

interface
  uses
     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs,Lst_CadastroERP, MinhasClasses,uCad_CadastroPaiERP,uListagemPadraoERP,
     Generics.Collections,cxPC,TypInfo,ulibERP;


  type
    TClasseCadastroSimples = class of TfrmLstCadastroSimplesERP;
    TClasseCadastroPai = class of TfrmCad_CadastroPaiERP;
    CampoChave = Variant;


    TrotinasForms = class
      class Procedure AbreFormCadastroPai<MyForm: TfrmCad_CadastroPaiERP  >(TipoOperacaoForm: TTipoOperacaoForm);
      class Procedure AbreFormListagemPadrao<MyForm: TfrmListagemPadraoERP >;
      class procedure AbreFormSimples(aForm: TfrmLstCadastroSimplesERP; aClasse: TClasseCadastroSimples;TipoOperacao: TTipoOperacaoForm = toNada);
      class Function AbreFormSimplesPeloTipoPesquisa(aTipoPesquisa: TTipoPesquisa;TipoOperacaoForm: TTipoOperacaoForm = toNada): TipoCampoChave;
      class Function AbreCadastroNCM(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class Function AbreCadastroEmpresa(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class Function AbreCadastroCliente(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class Function AbreCadastroGrupoCliente(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class Function AbreCadastroCargos(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class Function AbreCadastroUsuario(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroDepartamento(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroFuncionarios(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroFornecedor(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroLinha(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroGrupo(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroLocalizacao(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroProduto(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroFabricante(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroUnidade(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroCodigoMunicipalServico(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroProcessoServico(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroPeridicidade(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroBanco(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroContaBancaria(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroCondicaoPagamento(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreProposta(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroTipoContrato(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreContratos(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreManutencaoEquipamentoCliente(pIdCliente: TipoCampoChave;TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroTipoOS(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroStatusOS(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreInclusaoOS(pIdProposta: TipoCampoChave = '-1'): CampoChave;
      class function AbreCentralOS(IdCliente: TipoCampoChave = '-1'): CampoChave;
      class procedure AbreEntradaProduto;
      class procedure AbreAgenda(IdAgenda: TipoCampoChave = '-1';IdConratoCOmpetencia: TipoCampoChave = '-1');
      class function AbreCadastroOperacaoEstoque(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class Procedure AbreListagemEntrada;
      CLASS procedure AbreVenda(IdVenda: TipoCampoChave = '-1');
      class function AbreCadastroTransportadora(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroAlmoxarifado(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class procedure AbreListagemSaida(IDCLiente:TipoCampoChave =  '-1'; IdOs:TipoCampoChave =  '-1' );
      class Procedure AbreConfiguracoes;
      class procedure AbreContasReceber(IdCliente: TipoCampoChave = '-1'; IdSaida: TipoCampoChave = '-1'; IdContratoCompetencia: TipoCampoChave = '-1');
      class function AbreCadastroPlanoContas(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
      class function AbreCadastroTipoPatrimonio(TipoOperacao: TTipoOperacaoForm =toNada): CampoChave;
      class function AbreCadastroTipoEvento(TipoOperacao: TTipoOperacaoForm =toNada): CampoChave;
      class function AbreCadastroPatrimonio(TipoOperacao: TTipoOperacaoForm =toNada): CampoChave;
      class function AbreManutencaoPatrimonio(TipoOperacao: TTipoOperacaoForm = toNada; pIdPatrimonio: TipoCampoChave = '-1'):CampoChave;
  private

    end;



implementation

uses uCadNCM, Lst_Empresa, Cad_Cliente, Cad_usuario, uCad_Funcionario,
  uCad_Fornecedor, uCad_Produto, uLst_Periodicidade, uLst_ContaBancaria,
  uLst_CondicaoPagamento, uLst_Proposta, uLst_TipoContrato, uLst_Contratos,
  uDlg_EquipamentoCliente, uLst_TipoOS, uLst_StatusOS, uLst_OS, uCad_OS,
  uAgenda, uPrincipal, uEntrada, Lst_OperacaoEstoque, uLst_Entrada, uSaida,
  uCad_Transportadora, uLst_Saidas, uCadConfiguracoes, uLst_ContasReceber,
  uLst_TipoPatrimonio, uLst_TipoEvento, uCad_Patrimonio,
  uLst_ManutencaoPatrimonio;

class procedure TrotinasForms.AbreAgenda(IdAgenda: TipoCampoChave = '-1';IdConratoCOmpetencia: TipoCampoChave = '-1');
begin
  Try
    frmAgenda := TfrmAgenda.Create(nil);
    frmAgenda.IdAgenda := IdAgenda;
    frmAgenda.IdCOmpetenciaContrato := IdConratoCOmpetencia;
    frmAgenda.ShowModal;
  Finally
    FreeAndNil(frmAgenda);
  End;
end;

class function TrotinasForms.AbreCadastroAlmoxarifado(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPAlmoxarifado,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroBanco(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPBanco,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroCargos(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPCargo,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroCliente(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormCadastroPai<TfrmCad_Cliente>(TipoOperacao);
end;

class function TrotinasForms.AbreCadastroCodigoMunicipalServico(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPCodigoMunicipalServico,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroCondicaoPagamento(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimples(frmLst_CondicaoPagamento, TfrmLst_CondicaoPagamento,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroContaBancaria(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimples(frmLst_ContaBancaria, TfrmLst_ContaBancaria,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroDepartamento(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPDepartamento,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroEmpresa(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimples(frmLst_Empresa, TfrmLst_Empresa,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroFabricante(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPFabricante,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroFornecedor(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormCadastroPai<TfrmCad_Fornecedor>(TipoOperacao);
end;

class function TrotinasForms.AbreCadastroFuncionarios(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormCadastroPai<TfrmCadFuncionario>(TipoOperacao);
end;

class function TrotinasForms.AbreCadastroGrupo(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPGrupo,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroGrupoCliente(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
   AbreFormSimplesPeloTipoPesquisa(tpERPGrupoCliente,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroLinha(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPLinha,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroLocalizacao(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPLocalizacao,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroNCM(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormCadastroPai<TfrmCad_NCM>(TipoOperacao);
end;

class function TrotinasForms.AbreCadastroOperacaoEstoque(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormSimples(frmLst_OperacaoEstoque,TfrmLst_OperacaoEstoque,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroPatrimonio(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
   if frmCad_Patrimonio = nil then
     frmCad_Patrimonio:= TfrmCad_Patrimonio.Create(nil);
  if frmCad_Patrimonio.Showing then
    frmCad_Patrimonio.BringToFront
  else
    frmCad_Patrimonio.Show;
end;

class function TrotinasForms.AbreCadastroPeridicidade(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimples(frmLst_Periodicidade,TfrmLst_Periodicidade,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroPlanoContas(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  Result := AbreFormSimplesPeloTipoPesquisa(tpERPPlanoContas,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroProcessoServico(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimplesPeloTipoPesquisa(tpERPProcessosservico,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroProduto(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
   AbreFormCadastroPai<TfrmCad_Produto>(TipoOperacao);
end;

class function TrotinasForms.AbreCadastroStatusOS(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormSimples(frmLst_StatusOS,TfrmLst_StatusOS,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroTipoContrato(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormSimples(frmLst_TipoContrato, TfrmLst_TipoContrato,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroTipoEvento(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormSimples(ftmLst_TipoEvento,TftmLst_TipoEvento,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroTipoOS(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormSimples(frmLst_TipoOS,TfrmLst_TipoOS,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroTipoPatrimonio(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormSimples(frmLst_TipoPatrimonio,TfrmLst_TipoPatrimonio,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroTransportadora(
  TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  AbreFormCadastroPai<TfrmCad_Transportadora>(TipoOperacao);
end;

class function TrotinasForms.AbreCadastroUnidade(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
   AbreFormSimplesPeloTipoPesquisa(tpERPUnidade,TipoOperacao);
end;

class function TrotinasForms.AbreCadastroUsuario(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormCadastroPai<TfrmCad_usuario>(TipoOperacao);
end;

class function TrotinasForms.AbreCentralOS(IdCliente: TipoCampoChave = '-1'): CampoChave;
begin
   if frmLst_OS = nil then
    frmLst_OS := TfrmLst_OS.Create(nil);
  frmLst_OS.IdCliente := IdCliente;

  if frmLst_OS.Showing then
    frmLst_OS.BringToFront
  else
    frmLst_OS.Show ;

end;

class procedure TrotinasForms.AbreConfiguracoes;
begin
  Try
    frmCadConfiguracao:= TfrmCadConfiguracao.Create(nil);
    frmCadConfiguracao.ShowModal;
  Finally
    FreeAndNil(frmCadConfiguracao);
  End;
end;

class procedure TrotinasForms.AbreContasReceber(IdCliente: TipoCampoChave = '-1'; IdSaida: TipoCampoChave = '-1'; IdContratoCompetencia: TipoCampoChave = '-1');
begin
  if frmLst_ContasReceber = nil then
    frmLst_ContasReceber := TfrmLst_ContasReceber.Create(nil);
  frmLst_ContasReceber.IdCliente := IdCliente;
  frmLst_ContasReceber.IdSaida := IdSaida;
  frmLst_ContasReceber.IdContratoCompetencia := IdContratoCompetencia;
  if frmLst_ContasReceber.Showing then
    frmLst_ContasReceber.BringToFront
  else
    frmLst_ContasReceber.Show ;
end;

class function TrotinasForms.AbreContratos(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
   AbreFormListagemPadrao<TfrmLst_Contratos>
end;

class procedure TrotinasForms.AbreEntradaProduto;
begin
  if not Assigned(frmEntradaEstoque) then
    frmEntradaEstoque := TfrmEntradaEstoque.Create(nil);
  if frmEntradaEstoque.Showing then
    frmEntradaEstoque.BringToFront
  else
    frmEntradaEstoque.Show;
end;

class procedure TrotinasForms. AbreFormSimples(aForm: TfrmLstCadastroSimplesERP; aClasse: TClasseCadastroSimples;TipoOperacao: TTipoOperacaoForm = toNada);
  begin
    Try
      Application.CreateForm(aClasse, aform);
      case TipoOperacao of
        toNada: ;
        toEditar:
          aForm.EditReg := True;
        toIncluir:
          aForm.NovoReg := True ;
      end;
      aForm.ShowModal;
    Finally
      FreeAndNil(aForm);
    End;
  end;

class Function TrotinasForms.AbreFormSimplesPeloTipoPesquisa(aTipoPesquisa: TTipoPesquisa;TipoOperacaoForm: TTipoOperacaoForm): TipoCampoChave;
  var
    aForm : TfrmLstCadastroSimplesERP;
  begin
    Try
      Application.CreateForm(TfrmLstCadastroSimplesERP, aform);
      aForm.TipoPesquisa := aTipoPesquisa;
        case TipoOperacaoForm of
        toNada: ;
        toEditar:
          aForm.EditReg := True;
        toIncluir:
          aForm.NovoReg := True ;
      end;
      if aForm.ShowModal = mrOK Then
       result := aForm.ValorChave

    Finally
      FreeAndNil(aForm);
    End;
  end;


class function TrotinasForms.AbreInclusaoOS(pIdProposta: TipoCampoChave = '-1'): CampoChave;
begin
   frmCad_OS := TfrmCad_OS.Create(nil);
   Try
     frmCad_OS.NovoReg := True;
     frmCad_OS.IdProposta := pIdProposta;
     frmCad_OS.ShowModal;
   Finally
     FreeAndNil(frmCad_OS);
   End;
end;

class procedure TrotinasForms.AbreListagemEntrada;
begin
  AbreFormListagemPadrao<TfrmLst_Entrada>;
end;

class procedure TrotinasForms.AbreListagemSaida(IDCLiente:TipoCampoChave =  '-1'; IdOs:TipoCampoChave =  '-1');
begin
  if frmLst_Saidas = nil Then
    frmLst_Saidas := TfrmLst_Saidas.Create(nil);
  frmLst_Saidas.idCliente  := IDCliente;
  frmLst_Saidas.IdOS  := IdOS;
  if frmLst_Saidas.showing Then
    frmLst_Saidas.BringToFront
  else
    frmLst_Saidas.Show;
end;

class function TrotinasForms.AbreManutencaoEquipamentoCliente(pIdCliente: TipoCampoChave;TipoOperacao: TTipoOperacaoForm): CampoChave;
begin
  Try
    frmDlg_EquipamentoCliente := TfrmDlg_EquipamentoCliente.Create(nil);
    frmDlg_EquipamentoCliente.IdCliente := pIdCliente;
    case TipoOperacao of
      toNada: ;
      toEditar:
        frmDlg_EquipamentoCliente.EditReg := True;
      toIncluir:
        frmDlg_EquipamentoCliente.NovoReg := True;
    end;
    if frmDlg_EquipamentoCliente.ShowModal= mrOk Then
      Result := frmDlg_EquipamentoCliente.pDataSet.FieldByName('IDCLIENTEEQUIPAMENTOS').Value;
  Finally
    FreeAndNil(frmDlg_EquipamentoCliente);
  End;
end;

class function TrotinasForms.AbreManutencaoPatrimonio(
  TipoOperacao: TTipoOperacaoForm; pIdPatrimonio: TipoCampoChave): CampoChave;
begin
   frmLst_ManutencaoPatrimonio := TfrmLst_ManutencaoPatrimonio.Create(Nil);
   Try
     frmLst_ManutencaoPatrimonio.ShowModal;
   Finally
     FreeAndNil(frmLst_ManutencaoPatrimonio);
   End;
end;

class function TrotinasForms.AbreProposta(TipoOperacao: TTipoOperacaoForm = toNada): CampoChave;
begin
  AbreFormListagemPadrao<TfrmLst_Proposta>;
end;


class procedure TrotinasForms.AbreVenda(IdVenda: TipoCampoChave);
begin
  if not Assigned(frmSaida) Then
    frmSaida := TfrmSaida.Create(nil);
  if IdVenda <> SemID then
    frmSaida.AbreVenda(IdVenda);
  if frmSaida.Showing Then
    frmSaida.BringToFront
  else
    frmSaida.Show;
end;

{ TTelas }

class procedure TrotinasForms.AbreFormCadastroPai<MyForm>(TipoOperacaoForm: TTipoOperacaoForm);
var
  aForm: MyForm;
begin
  Try
    Application.CreateForm(MyForm, aform);
    case TipoOperacaoForm of
      toNada:;
      toEditar:
        aForm.EditReg := True;
      toIncluir:
        aForm.NovoReg := True;
    end;

    aForm.ShowModal;
  Finally
    FreeAndNil(aForm);
  End;

end;

class procedure TrotinasForms.AbreFormListagemPadrao<MyForm>;
var
  aForm: MyForm;
begin
  Try
    Application.CreateForm(MyForm, aform);
    aForm.ShowModal;
  Finally
    FreeAndNil(aForm);
  End;
end;

end.
