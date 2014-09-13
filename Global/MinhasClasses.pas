unit MinhasClasses;

interface
   USes StrUtils, SysUtils, Classes;

  Type

    TTipoCaracter = (ttcMaiusculo, ttcNormal);
    TUserLogado = packed record
      Login : String;
      Senha : String;
      IdLoja : Variant;
      NomeMaquina : String;
      Id : variant;
      Conexao : Integer;
      IdPerfil : Variant;
      TipoCaracter :TTipoCaracter;
      Administrador: Boolean;
   end;

    TTipoCampo = (tcString , tcReal, tcMoeda, tcInt, tcLogico, tcCampoData,
                tcCEP, tcCNPJ, tcCPF, tcHora, tcVariant, tcBoleano, tcPercent);

    TTipoChave = (ttcChave, ttcCodigo);
    TTipoFormBasico = (TfGrid, tfTree);


    TTipoPesquisa = (
                     tpUsuario,
                     {$Region 'L-Kimera'}
                     tpLKimeraCliente, tpLKimeraProduto, tpLKimeraCompra, tpLKimeraVenda, tpLKimeraContaReceber,
                     tpLKimeraContaRecebida, tpLKimeraHistoricoPreco, tpLKimeraRecebimento, tpLKimeraCEP,
                     tpLKimeraProdutosMovimento, tpLKimeraRecebimentoMovimentoRecebimento,
                     tpRelatorio, tpLayout, tpLKimeraProdutoAtivo
                     {$EndRegion}
                     {$Region 'Flex'}
                     ,tpFlexUsuario, tpFlexEmpresa, tpFlexPerfilUsuario, tpFlexAcesso, tpFlexPerfilacesso, tpFlexCargo,
                     tpFlexCep, tpFlexFuncionario, tpFlexCaracteristica, tpFlexCliente, tpFlexCaracteristicaRef,
                     tpFlexCamposPersonalizados, tpFlexCampoPersonalizadoRef, tpFlexFornecedor, tpFlexCFOP,
                     tpFlexSecao, tpFlexFabricante, tpFlexUnidade, tpFlexLocalizacao, tpFlexPlanoConta,
                     tpFlexConfiguracao, tpFlexProduto, tpFlexProdutoFoto, tpFlexProdutoLocalizacao,
                     tpFlexProdutoFornecedor,tpFlexEstoque, tpFlexProdutoCodigo,tpFlexProdutoPreco, tpFlexPreco,
                     tpFlexSetorEstoque, tpFlexTransportadora, tpFlexCalculoICMS, tpFlexCalculoICMSEstados, tpFlexCST,
                     tpFlexOperacao, tpFlexProdutoCustoCampo, tpFlexProdutoCusto, tpFlexProdutoLinhaTempo, tpFlexCalculoIss,
                     tpFlexClassificacaoFiscal, tpFlexProdutoRelacionado, tpFlexProdutoComposto, tpFlexGrade, tpFlexGradeItens,
                     tpFlexProdutoGrade, tpFlexTipoCodigo, tpFlexProdutoPrecoLucro,tpFlexContaReceber, tpFlexContaReceberPagamentos ,
                     tpFlexAnexo, tpFlexContaPagar, tpFlexHistoricoContaReceber , tpFlexReceitaFixa, tpFlexDespesaFixa
                     {$EndRegion}

                    {$Region 'Imovel'}
                     ,tpImoStatus, tpImoImposto, tpImoTipoImovel,
                     tpImoBanco,tpImoFiador, tpImoCEP, tpImoInquilino,
                     tpImoLocatario,tpImoLocatarioBanco,tpImoImovel,
                     tpImoContaPagar,tpImoContaReceber,tpImoContaPagas,
                     tpImoContaRecebidas, tpImoImovelImposto, tpImoCheque,
                     tpImoChequeDepositado, tpImoTipoConta, tpImoTipoContaR,
                     tpImoTipoContaP, tpImoRecibo,tpImoCaixa, tpImoReciboContas,
                     tpImoChequeEmitido,tpImoChequeEmitidoDepositado ,
                     tpImoFaixaIRRF

                     {$EndRegion}
                     {$Region 'Alpha'}
                     ,tpAlphaCaracteristica
                     ,tpAlphaUnidade
                     ,tpAlphaFabricante
                     ,tpAlphaSecao
                     ,tpAlphaProduto
                     ,tpAlphaFornecedor
                     ,tpAlphaEmpresa
                     ,tpAlphaCFOP
                     ,tpAlphaTerminal
                     ,tpAlphaUsuario
                     ,tpAlphaModelo
                     ,tpAlphaOperacao
                     ,tpAlphaOperacaoEntrada
                     ,tpAlphaOperacaoSaida
                     ,tpAlphaOperacaoVenda
                     ,tpAlphaNCM
                     ,tpAlphaEntrada
                     ,tpAlphaEntradaProduto
                     ,tpAlphaCaracteristicaProduto
                     ,tpAlphaProdutoComposto
                     ,tpAlphaUF
                     ,tpAlphaPerfilUsuario
                     ,tpAlphaSaidaProduto
                     ,tpAlphaSaida
                     ,tpAlphaSaidaRecebimento
                     ,tpAlphaPerfilAcesso
                     ,tpAlphaDespesa
                     ,tpAlphaProducao
                     ,tpAlphaProducaoItem
                     ,tpAlphaArvore
                     {$EndRegion}

                     {$Region 'Dragon'}
                     ,tpDragonCEP
                     ,tpDragonEmpresa
                     ,tpDragonPerfilUsuario
                     ,tpDragonUsuario
                     ,tpDragonProfissionais
                     ,tpDragonCategoria
                     ,tpDragonCor
                     ,tpDragonFormaPag
                     ,tpDragonPlanoConta
                     ,tpDragonCliente
                     ,tpDragonTipoServico
                     ,tpDragonVenda
                     ,tpDragonVendaProduto
                     ,tpDragonVendaPagamento
                     ,tpDragonContaReceber
                     ,tpDragonContaRecebida
                     ,tpDragonContaPagar
                     ,tpDragonContaPaga
                     ,tpDragonCaixa
                     ,tpDragonTipoCaixa
                     ,tpDragonContaPagarPagamentos
                     ,tpDragonContaReceberRecebimentos
                     ,tpDragonClienteImagem
                     ,tpDragonGaleria
                     {$EndRegion}

                     {$Region 'Pet'}
                      ,tpPetCategoriaAnimal
                      ,tpPetTipoServico
                      ,tpPetTipoAnimal
                      ,tpPetFormaPagamento
                      ,tpPetProfissional
                      ,tpPetRacaAnimal
                      ,tpPetEmpresa
                      ,tpPetUsuario
                      ,tpPetPrecoServico
                      ,tpPetCliente
                      ,tpPetAnimal
                      ,tpPetServico
                      ,tpPetServicoDetalhe
                      ,tpPetServicoPagamentos
                      ,tpPetCaixa
                      ,tpPetGrupo
                      ,tpPetGrupoAnimal
                      ,tpPetAcompanhamentoAnimal
                      ,tpPetContasReceber
                      ,tpPetContasRecebidas
                      ,tpPetContaReceberRec
                     {$EndRegion}

                     {$Region  'Aquarios2'}
                      ,tpAquariosStatus,tpAquariosTipoImovel,tpAquariosBanco
                      ,tpAquariosEmpresa,tpAquariosEncargos,tpAquariosEncargosValores
                      ,tpAquariosFormaPagamento,tpAquariosFiador,tpAquariosInquilino,
                      tpAquariosProprietario,tpAquariosProprietarioBanco,
                      tpAquariosImovel,tpAquariosImovelImagens,tpAquariosTipoContrato
                      ,tpAquariosPerfilUsuario,tpAquariosPerfilUsuarioAcesso,tpAquariosContratos,tpAquariosContratosVW
                      ,tpAquariosContratosInquilino,tpAquariosContratosFiador,tpAquariosContratosEncargo,
                      tpAquariosProprietarioRepresentante,tpAquariosContratosReajuste,
                      tpAquariosContasReceber,tpAquariosContasRecebidas,
                      tpAquariosContasPagar,tpAquariosContasPagas,
                      tpAquariosContaReceberEncargo

                     {$EndRegion}

                     {$Region 'Militour'}
                     ,tpMilitourCliente
                     {$EndRegion}

                     {$Region 'Controle de Importação'}
                      ,tpCICor,tpCIPais, tpCITamanho, tpCILocalEmbarque
                      ,tpCIFornecedor, tpCINCM, tpCIProduto,tpCIStatusPedido
                      ,tpCIMoeda,tpCIMoedaCotacao,tpCIGrade,tpCIEmbalagem,
                      tpCINCMTributacao,tpCIPedidoCompra,tpCIProdutosPedido,
                      tpCIPagamentoPedido,tpCIHistoricoPedido,tpCIPagamentoPedidoPag,
                      tpCICotacao,tpCICotacaoProduto,tpCICotacaoProdutoFornecedor

                     {$EndRegion}

                     {$Region 'Controle de Serviços'}
                     ,tpCSEmpresa,tpCsCliente, tpCSProdutos,tpCsServicos,tpCsServicosDetalhe,
                     tpCSCFOP,tpCSMarca,tpCSUnidade,tpCSBanco,tpCSConta,tpCSAgenda,tpCSDocumento,
                     tpCSUsuario,tpCSUsuarioAcesso,tpCSCombustivel,tpCSStatusEquipamento,tpCSFornecedor,
                     tpCSGrupoEquipamento,tpCSMaterial,tpCSTipoMaterial,tpCSEquipamento,tpCSEquipamentoEspecificacao ,
                     tpCSEquipamentoArvore, tpCSGrupoEquipamentoEspecificacao,tpCSCompraEquipamento,tpCSCompraEquipamentoItens,
                     tpCSSaidaEquipamento,tpCSEntradaEquipamento,tpCSEntradaEquipamentoItens,tpCSLocalEstoque,tpCSManutencao,tpCSEntradaMaterial,
                     tpCSEntradaMaterialItem,tpCSManutencaoPecas,tpCSTabelaPrecoEquipamento


                     {$EndRegion}

                     {$Region 'ProjetoX'}
                     ,tpTipoContato, tpEmpresa, tpGrupo, tpSecao,tpFabricante
                     {$EndRegion}

                     ,tpERPEmpresa,tpERPCFOP,tpERPUnidade,tpERPAgenda,tpERPNCM,tpERPNCMTributacao,
                     tpERPCliente,tpERPGrupoCliente,tpERPCargo,tpERPUsuario,tpERPFuncionario,tpERPDepartamento,tpERPFornecedor,
                     tpERPGrupo, tpERPLinha, tpERPLocalizacao,tpERPProduto,tpERPFabricante,tpERPCodigoMunicipalServico,
                     tpERPProcessosservico,tpERPProdutoProcessosservico,tpERPPeridicidade,tpERPBanco,tpERPContaBancaria,tpERPCondicaoPagamento,
                     tpERPProposta,tpERPItemProposta,tpERPCondicaoPagamentoProposta,tpERPParcelaCondicaoPagamentoProposta,tpERPTipoContrato,
                     tpERPContrato,tpERPServicoContrato,tpERPClienteEquipamento,{tpERPClienteEquipamentoContrato,}tpERPTipoOS,tpERPStatusOS,
                     tpERPOS,tpERPEquipamentoOS,tpERPServicoEquipamentoOS,tpERPProdutoServicoOS,tpERPEntrada,
                     tpERPEntradaProduto,tpERPModeloNota, tpERPOperacao,tpERPOperacaoEntrada,tpERPOperacaoSaida,tpERPSerialProduto,
                     tpERPSerialProdutoEntrada,tpERPSerialProdutoAtivo,tpERPSerialProdutoOS,tpERPSaida,tpERPSaidaProduto,tpERPSaidaCondicaoPagamento,
                     tpERPSaidaCondicaoPagamentoParcelas,tpERPTransportadora,tpERPAlmoxarifado,tpERPSaidaSerialProduto,tpERPCEP,tpERPCompetenciaContrato,
                     tpERPContasReceber,tpERPPlanoContas,tpERPContasReceberRecebimentos,tpERPEstoque,tpERPMovimentacaoEstoque


                     );
    
    TSQL = packed Record
      Select : WideString ;
      NomeTabela : String ;
      CampoChave : String ;
      Apelido : String ;
      CampoDisplay : String ;
      CampoCodigo : String ;
      CampoSintetico: String;
      Versao20: Boolean ;
      DescricaoCampoDisplay: String;
      DescricaoTabela: String;
      UsaMaxParaCodigo: Boolean;
      DesconsiderarCampos: String;
      AliasTabela: String;
      TipoForm: TTipoFormBasico;
    end;

    IInterfaceMaster = Interface(IUnknown)
       ['{69D7580F-8547-4AF7-A44D-776D4F5F18E2}']
    End;

    TSQLs = class
      Function GetMySQL(TipoPesquisa : TTipoPesquisa ; Complemento : String; Join: String = '') :TSQL;Virtual;
    end;

   TInformacoesSistema = packed record
     Serial : AnsiString;
     Sistema : Integer;
     ChaveInstalacao : AnsiString;
     UsuariosMax : Integer;
     DataLimite : AnsiString;
     UltimaData : TDate;
     LocalBancoDados : AnsiString;
     NomeBanco : AnsiString;
     UsuarioBanco:AnsiString;
     SenhaBanco: Ansistring;
     PortaBanco:Integer;
     Host : AnsiString;
     Usuario : AnsiString;
     Senha : AnsiString;
     VerificaLicenca : Boolean ;
     UsaBancoDados : Boolean ;
     Versao : AnsiString;
     SQLs : TSQLs;
     UsaGuidChave: Boolean  ;
   end;


    TTipoAlteracao = (taInsere, taModifica, taDeleta, taInsertOrUpdate, taParado);

    TTratamentoLayout = (tlTela, tlImpressora, tlNovo, tlEditar, tlLista);

    TTipoPermissao = (ttpInclui, ttpAltera, ttpDeleta);

    TTipoAcesso = (taPermitido, taBloqueado);

    TTipoConfiguracao = (tpcGeralTipoCaracter, tpcClienteObrigatorioCPF, tpcFornrecedorObrigatorioCNPJ,
                         {$Region 'Imoveis'}
                         tpImovContaIdRecibo,
                         tpImovContaPagarLocatario,
                         tpImovContaRecebimentoImposto,
                         tpImovContaPagamentoImposto,
                         tpImovContaTipoContaFaturamento,
                         tpImovContaStatusFaturamento,
                         tpImovContaTipoContaComissao,
                         tpImovContaTipoContaReceberEmprestimo,
                         tpImovContaTipoContaPagarEmprestimo,
                         tpImovEmManutencao, tpImovSerial, tpImovChave
                         {$EndRegion}

                         {$Region 'Alpha'}
                           ,tpcAlphaCaracteristicaBarrani
                           ,tpcAlphaCFOPVenda
                           ,tpcAlphaOperacaoVenda
                           ,tpcAlphaOperacaoEntradaAcerto
                           ,tpcAlphaOperacaoSaidaAcerto
                           ,tpcAlphaOperacaoEntradaProducao
                           ,tpcAlphaOperacaoSaidaQuebra
                           ,tpcAlphaLayoutOP
                         {$EndRegion}

                         {$Region 'Dragon'}
                          ,tpcDragonPlanoContaComissao
                          ,tpcDragonPlanoContaCartaoCred
                          ,tpcDragonPlanoContaCartaoDeb
                          ,tpcDragonDiasVencimentoComissao
                          ,tpcDragonCaixaVendaDinheiro

                         {$EndRegion}

                         {$Region 'ERP'}
                          ,tpcERPStatusOSAberta
                          ,tpcERPStatusOSFinalizada
                          ,tpcERPStatusOSExecucao
                          ,tpcERPStatusOSFaturada
                          ,tpcERPOperacaoFaturarOS
                          ,tpcERPAliqJurosDia
                          ,tpcERPAliqMoraDia
                          ,tpcERPAliqMoraMax
                          ,tpcERPPlanoContasFaturamentoDireto
                          ,tpcERPPlanoContasFaturamentoDeOS
                          ,tpcERPPlanoContasFaturamentoContrato

                         {$EndRegion}


                              );

    TTipoPasso= (psPrimeiro, psProximo, psUltimo, psAnterior,psIgual);

    TTipoOperacaoForm = (toLogin, toLogoff, toIncluir, toEditar, toDeletar, toImprimir, toAbrir, toErro,toNada);

  Const
    MascaraCNPJ  :AnsiString = '99.999.999/9999-99;0;_';
    MascaraCPF   :AnsiString = '999.999.999-99;0;_';
    MascaraCEP   :AnsiString =  '99999-999;0;_';
    MascaraData  :AnsiString = '!99/99/9999;1;_';
    MascaraFloat :AnsiString = '#,##0.00';
    MascaraMoeda :AnsiString ='R$ #,##0.00;R$ -#,##0.00';
    MascaraFloatPercentual :AnsiString = '#,##0.00%';


    //NomeConfiguracao
      cfgLKimeraLayoutComprovanteVenda : AnsiString = 'LayoutComprovanteVenda';
      cfgLKimeraLicenca : AnsiString = 'Licenca';
      cfgLKimeraSerial :  AnsiString = 'Serial';


    // IdRelatorio
    idRelLKimeraInventario = 1;
    idRelLKimeraComprovanteVenda = 2;


    idRelImoCheque = 1;
    idRelImoContasReber = 2;
    idRelImoContasPagar = 3;
    idRelImoContasMovimentacao = 4;
    idRelImoContasEncargo = 5;
    idRelImoRecibo = 6;
    idRelImoLocatario = 7;
    idRelImoContasRebida = 8;
    idRelImoContasPaga = 9;
    idRelImoChequeDepositado = 10;
    idRelImoIRRF = 11;
    idRelImoLstProprietario = 12;

    idRelAlphaVenda = 1;
    idRelAlphaDespesas = 2;
    idRelAlphaOP = 3;
    idRelAlphaProducao = 4;

    IdRelReciboDragon = 1;

    IdRelServicosPet = 1;
    IdRelCaixaPet = 2;
    IdRelClientesPet = 3;
    IdRelAniaisPet = 4;
    IdRelComprovanteVendaPet = 5;
    IdRelContasReceber = 6;
    IdRelContasRecebidas = 7;
    IdRelResumoFinanceiro = 8;

    IdRelComprovanteVendaCS = 1;
    IdRelServicosCS = 2;
    IdRelEquipamentos = 3;
    IdRelCliente = 4;
    IdRelRecDesp = 5;
    IdRelMovimentacaoEquipamento = 6;
    IdRelDivergenciaManutencao = 7;
    IdRelManutencao = 8;
    IdRelMateriais = 9;

    //Sistemas
    sL_Kimera : Integer = 1;
    sFlex : Integer = 2;
    sALuguel : Integer = 3;
    sImoveis : Integer = 4;
    sAlpha : Integer = 5;
    sDragon : Integer = 6;
    sPet : Integer = 7;
    sAquarios2 : Integer = 8;
    sMilitour : Integer = 9;
    sControleImportacao : Integer = 10;
    sControleServico : Integer = 11;
    sProjetoX : Integer = 12;
    sERP = 13;
var
  USuarioLogado : TUserLogado;
  InfoSistema : TInformacoesSistema;
implementation


{ TSQLs }

function TSQLs.GetMySQL(TipoPesquisa: TTipoPesquisa; Complemento: String; Join: String = ''): TSQL;
begin
  Result.Versao20 := False;
  with Result do
      case TipoPesquisa of
       {$Region 'L-Kimera'}
        tpLKimeraCEP,  tpImoCEP:
          Begin
            NomeTabela := 'CEP';
            CampoChave := 'IDCEP';
            CampoCodigo := 'CEP';
            Select :=
              'EXECUTE BLOCK RETURNS (IDCEP INTEGER, CEP CHAR(8),LOGRADOURO VARCHAR(200),'+
              '                       BAIRRO VARCHAR(100),CIDADE VARCHAR(100),UF CHAR(2)) AS '+
              'BEGIN '+
              '  FOR'+
              '    SELECT IDCEP, CEP, LOGRADOURO, BAIRRO, CIDADE, ''RJ'' UF'+
              '      FROM CEP'+
              '     WHERE 1=1 '+Complemento+
              '      INTO IDCEP,:CEP, :LOGRADOURO, :BAIRRO, :CIDADE, :UF'+
              '   DO'+
              '    BEGIN'+
              '      SUSPEND;'+
              '    END '+
              'END';

          End;
        tpLayout :
          Begin
            NomeTabela := 'LAYOUT';
            CampoChave := 'IDLAYOUT';
            Select :=
              'SELECT L.IDLAYOUT, L.IDRELATORIO, L.NOMELAYOUT, L.FLAGTIPOLAYOUT,'+
              '       L.TEMPLATE, L.DATACRIACAO, L.DATAMODIFICACAO, L.FLAGPADRAO,'+
              '       R.IMPRESSORAPADRAO'+
              '  FROM LAYOUT L'+
              ' INNER JOIN RELATORIO R'+
              '    ON (R.IDRELATORIO = L.IDRELATORIO)'+
              ' WHERE 1=1 '+Complemento;
          End;
        tpRelatorio :
          Begin
            NomeTabela := 'RELATORIO';
            CampoChave := 'IDRELATORIO';
            Select :=
              'SELECT IDRELATORIO, DESCRICAO, IMPRESSORAPADRAO, FLAGTIPOIMPRESSAO '+
              '  FROM RELATORIO '+
              ' WHERE 1=1 '+Complemento;
          End;

          {$EndRegion}


        tpUsuario:
        Begin
          CampoChave := 'IDUSUARIO';
          NomeTabela := 'USUARIO';
          CampoDisplay := 'NOMEUSUARIO';
          Select :=
             'SELECT U.IDUSUARIO, U.CODIGO, U.NOMEUSUARIO, '+
             '       U.LOGIN, U.SENHA, U.IDPERFILUSUARIO '+
             '  FROM USUARIO U '+
             ' WHERE 1=1 '+Complemento;
        End;
      end;

end;

initialization
  InfoSistema.UsaBancoDados := True;
  InfoSistema.VerificaLicenca := True;
  InfoSistema.UsaGuidChave := False;
end.
