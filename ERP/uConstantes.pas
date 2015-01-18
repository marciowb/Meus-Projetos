unit uConstantes;

interface
    uses SysUtils,MinhasClasses,StrUtils;

 Const
   FormaPagamentoDinheiro: Integer = 0;
   FormaPagamentoCheque: Integer = 1;
   FormaPagamentoBoleto: Integer = 2;
   FormaPagamentoDeposito: Integer = 3;
   FormaPagamentoCartao: Integer = 4;
   FormaPagamentoNaoGeraFinanceiro: Integer = 5;

   TipoProdutoVenda:String = 'V';
   TipoProdutoServico:String = 'S';
   TipoProdutoFabricado:String = 'F';
   TipoProdutoComposto:String = 'C';
   TipoProdutoUsoInterno:String = 'I';
   TipoProdutoUsoInternoEVenda:String = 'X';

   RegimeEmpresaSimples: String = 'S';
   RegimeEmpresaLucroReal: String = 'L';
   RegimeEmpresaLucroPresumido: String = 'P';
   RegimeEmpresaMei: String = 'M';

   CfgOSBloqueiaFaturamentoParaOSNaoBaixadaNaoPermite: Integer = 0;
   CfgOSBloqueiaFaturamentoParaOSNaoBaixadaPergunta: Integer = 1;
   CfgOSBloqueiaFaturamentoParaOSNaoBaixadaPermite: Integer = 2;

   OPeracaoestoqueDocumentoNada = 0;
   OPeracaoestoqueDocumentoNFe = 1;
   OPeracaoestoqueDocumentoNFSe = 2;
   OPeracaoestoqueDocumentoNFSeNfe = 3;
   OPeracaoestoqueDocumentoComprovante = 4;

   NumeracaoNotaSaidaNFe = 'N';
   NumeracaoNotaSaidaNFSe = 'S';

   StatusLoteDocumentosFiscaisNaoIniciado = 'N';
   StatusLoteDocumentosFiscaisIniciado = 'I';
   StatusLoteDocumentosFiscaisEnviado = 'E';
   StatusLoteDocumentosFiscaisErro = 'R';
   StatusLoteDocumentosFiscaisSucesso = 'S';

   StatusItemLoteDocumentosFiscaisAguardando = 'A';
   StatusItemLoteDocumentosFiscaisErro = 'E';
   StatusItemLoteDocumentosFiscaisSucesso = 'S';

   ModalidadeFreteEmitente = 'E';
   ModalidadeFreteDestinatario = 'D';
   ModalidadeFreteTerceiros = 'T';

   TipoTransporteMaritima = '1';
   TipoTransporteFluvial  = '2';
   TipoTransporteLacustre = '3';
   TipoTransporteAerea    = '4';
   TipoTransportePostal   = '5';
   TipoTransporteFerroviaria = '6';
   TipoTransporteRodoviaria = '7';
   TipoTransporteConduto_Rede_Transmissao = '8';
   TipoTransporteMeios_Proprios = '9';
   TipoTransporteEntrada_Saida_ficta = '10';

   CFOPTipoOperacaoEntradaDentroEstado: String = '0';
   CFOPTipoOperacaoEntradaForaEstado: String = '1';
   CFOPTipoOperacaoSaidaDentroEstado: String = '2';
   CFOPTipoOperacaoSaidaForaEstado: String = '3';
   CFOPTipoOperacaoImportacao: String = '4';
   CFOPTipoOperacaoExportacao: String = '5';


   OperacaoEntrada: String = 'E';
   OperacaoSaida: String = 'S';
   OperacaoImportacao: String = 'I';
   OperacaoExportacao: String = 'X';
   OperacaoDevolucao: String = 'D';
   OperacaoTransferencia: String = 'T';



   {$Region 'CST de PIS/COFINS'}
    CST_PIS_COFINS_Operacao_Tributavel_com_Aliquota_Basica:String = '01';
    CST_PIS_COFINS_Operacao_Tributavel_com_Aliquota_Diferenciada:String = '02';
    CST_PIS_COFINS_Operacao_Tributavel_com_Aliquota_por_Unidade_de_Medida_de_Produto:String = '03';
    CST_PIS_COFINS_Operacao_Tributavel_Monofasica_–_Revenda_a_Aliquota_Zero:String = '04';
    CST_PIS_COFINS_Operacao_Tributavel_por_Substituicao_Tributaria:String = '05';
    CST_PIS_COFINS_Operacao_Tributavel_a_Aliquota_Zero:String = '06';
    CST_PIS_COFINS_Operacao_Isenta_da_Contribuicao:String = '07';
    CST_PIS_COFINS_Operacao_sem_Incidencia_da_Contribuicao:String = '08';
    CST_PIS_COFINS_Operacao_com_Suspensao_da_Contribuicao:String = '09';
    CST_PIS_COFINS_Outras_Operacoes_de_Saida:String = '49';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_Exclusivamente_a_Receita_Tributada_no_Mercado_Interno:String = '50';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_Exclusivamente_a_Receita_Nao_Tributada_no_Mercado_Interno:String = '51';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_Exclusivamente_a_Receita_de_Exportacao:String = '52';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_a_Receitas_Tributadas_e_Nao_Tributadas_no_Mercado_Interno:String = '53';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_a_Receitas_Tributadas_no_Mercado_Interno_e_de_Exportacao:String = '54';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_a_Receitas_Nao_Tributadas_no_Mercado_Interno_e_de_Exportacao:String = '55';
    CST_PIS_COFINS_Operacao_com_Direito_a_Credito_–_Vinculada_a_Receitas_Tributadas_e_Nao_Tributadas_no_Mercado_Interno_e_de_Exportacao:String = '56';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_Exclusivamente_a_Receita_Tributada_no_Mercado_Interno:String = '60';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_Exclusivamente_a_Receita_Nao_Tributada_no_Mercado_Interno:String = '61';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_Exclusivamente_a_Receita_de_Exportacao:String = '62';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_a_Receitas_Tributadas_e_Nao_Tributadas_no_Mercado_Interno:String = '63';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_a_Receitas_Tributadas_no_Mercado_Interno_e_de_Exportacao:String = '64';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_a_Receitas_Nao_Tributadas_no_Mercado_Interno_e_de_Exportacao:String = '65';
    CST_PIS_COFINS_Credito_Presumido_–_Operacao_de_Aquisicao_Vinculada_a_Receitas_Tributadas_e_Nao_Tributadas_no_Mercado_Interno_e_de_Exportacao:String = '66';
    CST_PIS_COFINS_Credito_Presumido_–_Outras_Operacoes:String = '67';
    CST_PIS_COFINS_Operacao_de_Aquisicao_sem_Direito_a_Credito:String = '70';
    CST_PIS_COFINS_Operacao_de_Aquisicao_com_Isencao:String = '71';
    CST_PIS_COFINS_Operacao_de_Aquisicao_com_Suspensao:String = '72';
    CST_PIS_COFINS_Operacao_de_Aquisicao_a_Aliquota_Zero:String = '73';
    CST_PIS_COFINS_Operacao_de_Aquisicao_sem_Incidencia_da_Contribuicao:String = '74';
    CST_PIS_COFINS_Operacao_de_Aquisicao_por_Substituicao_Tributaria:String = '75';
    CST_PIS_COFINS_Outras_Operacoes_de_Entrada:String = '98';
    CST_PIS_COFINS_Outras_Operacoes:String = '99';



   {$EndRegion}


implementation
end.
