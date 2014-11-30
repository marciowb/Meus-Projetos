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
implementation
end.
