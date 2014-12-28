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




implementation
end.
