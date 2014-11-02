unit uDocumentoFiscal;

interface
    uses
       MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,ulibERP, DateUtils;
    type


     

      IEndereco = interface(IInterfaceMaster)

        procedure SetBairro(const Value: String);
        procedure SetCEP(const Value: String);
        procedure SetCidade(const Value: String);
        procedure SetCodigoMunicipio(const Value: String);
        procedure SetComplemento(const Value: String);
        procedure SetEndereco(const Value: String);
        procedure SetEstado(const Value: String);
        procedure SetNomePais(const Value: String);
        procedure SetNumeroEndereco(const Value: String);
        procedure SetNumPais(const Value: Integer);
        function GetBairro: String;
        function GetCEP: String;
        function GetCidade: String;
        function GetCodigoMunicipio: String;
        function GetComplemento: String;
        function GetEndereco: String;
        function GetEstado: String;
        function GetNomePais: String;
        function GetNumeroEndereco: String;
        function GetNumPais: Integer;
        property Endereco: String read GetEndereco write SetEndereco;
        property NumeroEndereco: String read GetNumeroEndereco write SetNumeroEndereco;
        property Complemento:String read GetComplemento write SetComplemento;
        property Bairro: String read GetBairro write SetBairro;
        property Cidade: String read GetCidade write SetCidade;
        Property Estado: String read GetEstado write SetEstado;
        property CodigoMunicipio: String read GetCodigoMunicipio write SetCodigoMunicipio;
        property CEP: String read GetCEP write SetCEP;
        property NumPais: Integer read GetNumPais write SetNumPais;
        property NomePais:String read GetNomePais write SetNomePais;
      End;

      IPessoa = interface(IInterfaceMaster)

        procedure SetCNAE(const Value: String);
        procedure SetCPF_CNPJ(const Value: String);
        procedure SetCRT(const Value: String);
        procedure SetEmail(const Value: String);
        procedure SetEndereco(const Value: IEndereco);
        procedure SetIdentificacaoSUFRAMA(const Value: String);
        procedure SetIE(const Value: String);
        procedure SetIE_ST(const Value: String);
        procedure SetIM(const Value: String);
        procedure SetNome_RazaoSocial(const Value: String);
        procedure SetNomeFantasia(const Value: String);
        procedure SetSUFRAMA(const Value: String);
        procedure SetTelefone(const Value: String);
        function GetCNAE: String;
        function GetCPF_CNPJ: String;
        function GetCRT: String;
        function GetEmail: String;
        function GetEndereco: IEndereco;
        function GetIdentificacaoSUFRAMA: String;
        function GetIE: String;
        function GetIE_ST: String;
        function GetIM: String;
        function GetNome_RazaoSocial: String;
        function GetNomeFantasia: String;
        function GetSUFRAMA: String;
        function GetTelefone: String;
        property Nome_RazaoSocial: String read GetNome_RazaoSocial write SetNome_RazaoSocial;
        property NomeFantasia: String read GetNomeFantasia write SetNomeFantasia;
        property CPF_CNPJ: String read GetCPF_CNPJ write SetCPF_CNPJ;
        property Endereco: IEndereco read GetEndereco write SetEndereco;
        Property Telefone: String read GetTelefone write SetTelefone;
        property IE: String read GetIE write SetIE;
        property IE_ST: String read GetIE_ST write SetIE_ST;
        property SUFRAMA: String read GetSUFRAMA write SetSUFRAMA;
        Property IdentificacaoSUFRAMA: String read GetIdentificacaoSUFRAMA write SetIdentificacaoSUFRAMA;
        property IM: String read GetIM write SetIM;
        property Email: String read GetEmail write SetEmail;
        property CNAE: String read GetCNAE write SetCNAE;
        property CRT: String read GetCRT write SetCRT;
      end;

      IItemDocumento = interface(IInterfaceMaster)

        procedure SetAliqAcrescimo(const Value: Currency);
        procedure SetAliqDesconto(const Value: Currency);
        procedure SetCFOP(const Value: String);
        procedure SetCNPJ_Adquerente(const Value: String);
        procedure SetCodigo(const Value: String);
        procedure SetCodigoDoProdutoNoFabricante(const Value: String);
        procedure SetCodigoExportador(const Value: String);

        procedure SetCST_CSOSN(const Value: String);
        procedure SetDataDesembaraco(const Value: TDate);
        procedure SetDataDI(const Value: TDate);

        procedure SetLocalDesembaraco(const Value: String);

        procedure SetNumAdicao(const Value: Integer);
        procedure SetNumDI(const Value: String);
        procedure SetNumeroItemPedidoCompra(const Value: Integer);
        procedure SetNumeroPedidoCompra(const Value: String);
        procedure SetNumItemAdicao(const Value: Integer);
        procedure SetObservacao(const Value: String);
        procedure SetQuantidade(const Value: Double);
        procedure SetTipoIntermedio(const Value: TTipoIntermedio);
        procedure SetTipoTransporte(const Value: TTipoTransporte);

        procedure SetUF_Terceiro(const Value: String);
        procedure SetUFDesenbaraco(const Value: String);
        procedure SetUnidade(const Value: String);
        procedure SetValorAcrescimo(const Value: Currency);
        procedure SetValorAFRMM(const Value: Currency);
        procedure SetValorDesconto(const Value: Currency);
        procedure SetValorFrete(const Value: Currency);
        procedure SetValorOutrasDespesas(const Value: Currency);
        procedure SetValorSeguro(const Value: Currency);

        procedure SetValorUnitario(const Value: Currency);
        function GetAliqAcrescimo: Currency;
        function GetAliqDesconto: Currency;
        function GetCFOP: String;
        function GetCNPJ_Adquerente: String;
        function GetCodigo: String;
        function GetCodigoDoProdutoNoFabricante: String;
        function GetCodigoExportador: String;
        function GetCodigoFederalServico: String;
        function GetCodigoMunicipalServico: String;
        function GetCST_CSOSN: String;
        function GetDataDesembaraco: TDate;
        function GetDataDI: TDate;
        function GetEAN13: String;
        function GetEX_TIPI: String;
        function GetImpostos: IImpostos;
        function GetLocalDesembaraco: String;
        function GetNCM: String;
        function GetNome: String;
        function GetNumAdicao: Integer;
        function GetNumDI: String;
        function GetNumeroItemPedidoCompra: Integer;
        function GetNumeroPedidoCompra: String;
        function GetNumItemAdicao: Integer;
        function GetObservacao: String;
        function GetQuantidade: Double;
        function GetTipoIntermedio: TTipoIntermedio;
        function GetTipoTransporte: TTipoTransporte;
        function GetTotalBruto: Currency;
        function GetUF_Terceiro: String;
        function GetUFDesenbaraco: String;
        function GetUnidade: String;
        function GetValorAcrescimo: Currency;
        function GetValorAFRMM: Currency;
        function GetValorDesconto: Currency;
        function GetValorFrete: Currency;
        function GetValorOutrasDespesas: Currency;
        function GetValorSeguro: Currency;
        function GetValorTotalLiquido: Currency;
        function GetValorUnitario: Currency;

        property Codigo: String read GetCodigo write SetCodigo;
        Property EAN13: String read GetEAN13 ;
        property Nome:String read GetNome ;
        property Observacao:String read GetObservacao write SetObservacao;
        property Unidade: String read GetUnidade write SetUnidade;

        property Quantidade: Double read GetQuantidade write SetQuantidade;
        property ValorUnitario: Currency read GetValorUnitario write SetValorUnitario;
        property TotalBruto: Currency read GetTotalBruto ;
        Property ValorDesconto: Currency read GetValorDesconto write SetValorDesconto;
        Property ValorAcrescimo: Currency read GetValorAcrescimo write SetValorAcrescimo;
        Property AliqDesconto: Currency read GetAliqDesconto write SetAliqDesconto;
        Property AliqAcrescimo: Currency read GetAliqAcrescimo write SetAliqAcrescimo;

        property ValorFrete: Currency read GetValorFrete write SetValorFrete;
        Property ValorSeguro: Currency read GetValorSeguro write SetValorSeguro;
        Property ValorOutrasDespesas: Currency read GetValorOutrasDespesas write SetValorOutrasDespesas;

        Property ValorTotalLiquido: Currency read GetValorTotalLiquido ;

        Property CFOP:String read GetCFOP write SetCFOP;
        Property CST_CSOSN: String read GetCST_CSOSN write SetCST_CSOSN;
        Property NCM: String read GetNCM ;
        Property CodigoMunicipalServico: String read GetCodigoMunicipalServico ;
        Property CodigoFederalServico: String read GetCodigoFederalServico ;
        Property EX_TIPI: String read GetEX_TIPI ;

        Property NumDI: String read GetNumDI write SetNumDI;
        Property DataDI: TDate read GetDataDI write SetDataDI;
        Property LocalDesembaraco: String read GetLocalDesembaraco write SetLocalDesembaraco;
        Property UFDesenbaraco: String read GetUFDesenbaraco write SetUFDesenbaraco;
        Property DataDesembaraco: TDate read GetDataDesembaraco write SetDataDesembaraco;
        property TipoTransporte: TTipoTransporte read GetTipoTransporte write SetTipoTransporte;
        property ValorAFRMM: Currency read GetValorAFRMM write SetValorAFRMM;
        property TipoIntermedio: TTipoIntermedio read GetTipoIntermedio write SetTipoIntermedio;
        property CNPJ_Adquerente: String read GetCNPJ_Adquerente write SetCNPJ_Adquerente;
        property UF_Terceiro:String read GetUF_Terceiro write SetUF_Terceiro;
        property CodigoExportador:String read GetCodigoExportador write SetCodigoExportador;
        property NumAdicao: Integer read GetNumAdicao write SetNumAdicao;
        property NumItemAdicao:Integer read GetNumItemAdicao write SetNumItemAdicao;// Numero do Item na adição
        property CodigoDoProdutoNoFabricante: String read GetCodigoDoProdutoNoFabricante write SetCodigoDoProdutoNoFabricante;

        property NumeroPedidoCompra:String read GetNumeroPedidoCompra write SetNumeroPedidoCompra;
        property NumeroItemPedidoCompra:Integer read GetNumeroItemPedidoCompra write SetNumeroItemPedidoCompra;

        Property Impostos: IImpostos read GetImpostos ;


      end;


      TImpostos = class(TInterfacedObject,IImpostos)
      private
        FAliqICMS: Currency;
        FAliqISS: Currency;
        FValorPIS_COFINS: Currency;
        FBaseCSLL: Currency;
        FValorICMSST: Currency;
        FValorIPI: Currency;
        FBaseICMS_ISS: Currency;
        FAliqICMSST: Currency;
        FAliqIPI: Currency;
        FMVA: Currency;
        FValorCSLL: Currency;
        FBasePIS_COFINS: Currency;
        FValorICMS_ISS: Currency;
        FBaseICMSST: Currency;
        FBaseIPI: Currency;
        FALiqCSLL: Currency;
        FTipoIPI: TTIpoIPI;
        FAliqPIS: Currency;
        FAliqCOFINS: Currency;
        procedure SetAliqICMS(const Value: Currency);
        procedure SetAliqISS(const Value: Currency);
        function GetAliqICMS: Currency;
        function GetAliqISS: Currency;
        procedure SetAliqCOFINS(const Value: Currency);
        procedure SetALiqCSLL(const Value: Currency);
        procedure SetAliqICMSST(const Value: Currency);
        procedure SetAliqIPI(const Value: Currency);
        procedure SetAliqPIS(const Value: Currency);
        procedure SetBaseCSLL(const Value: Currency);
        procedure SetBaseICMS_ISS(const Value: Currency);
        procedure SetBaseICMSST(const Value: Currency);
        procedure SetBaseIPI(const Value: Currency);
        procedure SetBasePIS_COFINS(const Value: Currency);
        procedure SetMVA(const Value: Currency);
        procedure SetTipoIPI(const Value: TTIpoIPI);
        procedure SetValorCSLL(const Value: Currency);
        procedure SetValorICMS_ISS(const Value: Currency);
        procedure SetValorICMSST(const Value: Currency);
        procedure SetValorIPI(const Value: Currency);
        procedure SetValorPIS_COFINS(const Value: Currency);
        function GetAliqCOFINS: Currency;
        function GetALiqCSLL: Currency;
        function GetAliqICMSST: Currency;
        function GetAliqIPI: Currency;
        function GetAliqPIS: Currency;
        function GetBaseCSLL: Currency;
        function GetBaseICMS_ISS: Currency;
        function GetBaseICMSST: Currency;
        function GetBaseIPI: Currency;
        function GetBasePIS_COFINS: Currency;
        function GetMVA: Currency;
        function GetTipoIPI: TTIpoIPI;
        function GetValorCSLL: Currency;
        function GetValorICMS_ISS: Currency;
        function GetValorICMSST: Currency;
        function GetValorIPI: Currency;
        function GetValorPIS_COFINS: Currency;
      published
        property AliqICMS: Currency read GetAliqICMS write SetAliqICMS;
        property AliqISS: Currency read GetAliqISS write SetAliqISS;
        property AliqPIS: Currency read GetAliqPIS write SetAliqPIS;
        property AliqCOFINS: Currency read GetAliqCOFINS write SetAliqCOFINS;
        property AliqIPI: Currency read GetAliqIPI write SetAliqIPI;
        property TipoIPI: TTIpoIPI read GetTipoIPI write SetTipoIPI;
        property MVA: Currency read GetMVA write SetMVA;
        Property AliqICMSST: Currency read GetAliqICMSST write SetAliqICMSST;
        property ALiqCSLL: Currency read GetALiqCSLL write SetALiqCSLL;

        property BaseICMS_ISS: Currency read GetBaseICMS_ISS write SetBaseICMS_ISS;
        property BaseIPI: Currency read GetBaseIPI write SetBaseIPI;
        Property BasePIS_COFINS: Currency read GetBasePIS_COFINS write SetBasePIS_COFINS;
        property BaseICMSST: Currency read GetBaseICMSST write SetBaseICMSST;
        property BaseCSLL: Currency read GetBaseCSLL write SetBaseCSLL;

        property ValorICMS_ISS: Currency read GetValorICMS_ISS write SetValorICMS_ISS;
        property ValorIPI: Currency read GetValorIPI write SetValorIPI;
        Property ValorPIS_COFINS: Currency read GetValorPIS_COFINS write SetValorPIS_COFINS;
        property ValorICMSST: Currency read GetValorICMSST write SetValorICMSST;
        property ValorCSLL: Currency read GetValorCSLL write SetValorCSLL;


      end;


      TEndereco = Class(TInterfacedObject, IEndereco)
      private
        FNumPais: Integer;
        FBairro: String;
        FNumeroEndereco: String;
        FCEP: String;
        FComplemento: String;
        FNomePais: String;
        FCidade: String;
        FCodigoMunicipio: String;
        FEndereco: String;
        FEstado: String;
        procedure SetBairro(const Value: String);
        procedure SetCEP(const Value: String);
        procedure SetCidade(const Value: String);
        procedure SetCodigoMunicipio(const Value: String);
        procedure SetComplemento(const Value: String);
        procedure SetEndereco(const Value: String);
        procedure SetEstado(const Value: String);
        procedure SetNomePais(const Value: String);
        procedure SetNumeroEndereco(const Value: String);
        procedure SetNumPais(const Value: Integer);
        function GetBairro: String;
        function GetCEP: String;
        function GetCidade: String;
        function GetCodigoMunicipio: String;
        function GetComplemento: String;
        function GetEndereco: String;
        function GetEstado: String;
        function GetNomePais: String;
        function GetNumeroEndereco: String;
        function GetNumPais: Integer;
      published
        property Endereco: String read GetEndereco write SetEndereco;
        property NumeroEndereco: String read GetNumeroEndereco write SetNumeroEndereco;
        property Complemento:String read GetComplemento write SetComplemento;
        property Bairro: String read GetBairro write SetBairro;
        property Cidade: String read GetCidade write SetCidade;
        Property Estado: String read GetEstado write SetEstado;
        property CodigoMunicipio: String read GetCodigoMunicipio write SetCodigoMunicipio;
        property CEP: String read GetCEP write SetCEP;
        property NumPais: Integer read GetNumPais write SetNumPais;
        property NomePais:String read GetNomePais write SetNomePais;
      End;

      TPessoa = Class(TInterfacedObject, IPessoa)
      private
        FNome_RazaoSocial: String;
        FCNAE: String;
        FCPF_CNPJ: String;
        FEmail: String;
        FIdentificacaoSUFRAMA: String;
        FIM: String;
        FIE: String;
        FSUFRAMA: String;
        FIE_ST: String;
        FCRT: String;
        FEndereco: IEndereco;
        FTelefone: String;
        FNomeFantasia: String;
        procedure SetCNAE(const Value: String);
        procedure SetCPF_CNPJ(const Value: String);
        procedure SetCRT(const Value: String);
        procedure SetEmail(const Value: String);
        procedure SetEndereco(const Value: IEndereco);
        procedure SetIdentificacaoSUFRAMA(const Value: String);
        procedure SetIE(const Value: String);
        procedure SetIE_ST(const Value: String);
        procedure SetIM(const Value: String);
        procedure SetNome_RazaoSocial(const Value: String);
        procedure SetNomeFantasia(const Value: String);
        procedure SetSUFRAMA(const Value: String);
        procedure SetTelefone(const Value: String);
        function GetCNAE: String;
        function GetCPF_CNPJ: String;
        function GetCRT: String;
        function GetEmail: String;
        function GetEndereco: IEndereco;
        function GetIdentificacaoSUFRAMA: String;
        function GetIE: String;
        function GetIE_ST: String;
        function GetIM: String;
        function GetNome_RazaoSocial: String;
        function GetNomeFantasia: String;
        function GetSUFRAMA: String;
        function GetTelefone: String;
      published
        property Nome_RazaoSocial: String read GetNome_RazaoSocial write SetNome_RazaoSocial;
        property NomeFantasia: String read GetNomeFantasia write SetNomeFantasia;
        property CPF_CNPJ: String read GetCPF_CNPJ write SetCPF_CNPJ;
        property Endereco: IEndereco read GetEndereco write SetEndereco;
        Property Telefone: String read GetTelefone write SetTelefone;
        property IE: String read GetIE write SetIE;
        property IE_ST: String read GetIE_ST write SetIE_ST;
        property SUFRAMA: String read GetSUFRAMA write SetSUFRAMA;
        Property IdentificacaoSUFRAMA: String read GetIdentificacaoSUFRAMA write SetIdentificacaoSUFRAMA;
        property IM: String read GetIM write SetIM;
        property Email: String read GetEmail write SetEmail;
        property CNAE: String read GetCNAE write SetCNAE;
        property CRT: String read GetCRT write SetCRT;
      end;


      TItemDocumento = Class(TInterfacedObject, IItemDocumento)
      private
        FValorFrete: Currency;
        FNumeroPedidoCompra: String;
        FDataDesembaraco: TDate;
        FObservacao: String;
        FValorTotalLiquido: Currency;
        FLocalDesembaraco: String;
        FCNPJ_Adquerente: String;
        FValorAcrescimo: Currency;
        FValorDesconto: Currency;
        FNumItemAdicao: Integer;
        FTipoIntermedio: TTipoIntermedio;
        FTotalBruto: Currency;
        FUFDesenbaraco: String;
        FCodigoFederalServico: String;
        FCodigo: String;
        FCodigoMunicipalServico: String;
        FValorUnitario: Currency;
        FCodigoExportador: String;
        FDataDI: TDate;
        FEX_TIPI: String;
        FEAN13: String;
        FAliqAcrescimo: Currency;
        FAliqDesconto: Currency;
        FCST_CSOSN: String;
        FCFOP: String;
        FValorSeguro: Currency;
        FNCM: String;
        FValorOutrasDespesas: Currency;
        FUF_Terceiro: String;
        FTipoTransporte: TTipoTransporte;
        FUnidade: String;
        FImpostos: IImpostos;
        FNumeroItemPedidoCompra: Integer;
        FNumAdicao: Integer;
        FNumDI: String;
        FQuantidade: Double;
        FCodigoDoProdutoNoFabricante: String;
        FNome: String;
        FValorAFRMM: Currency;
        FIdProduto : TipoCampoChave;
    FIdCliente: TipoCampoChave;
        procedure SetAliqAcrescimo(const Value: Currency);
        procedure SetAliqDesconto(const Value: Currency);
        procedure SetCFOP(const Value: String);
        procedure SetCNPJ_Adquerente(const Value: String);
        procedure SetCodigo(const Value: String);
        procedure SetCodigoDoProdutoNoFabricante(const Value: String);
        procedure SetCodigoExportador(const Value: String);
        procedure SetCST_CSOSN(const Value: String);
        procedure SetDataDesembaraco(const Value: TDate);
        procedure SetDataDI(const Value: TDate);
        procedure SetLocalDesembaraco(const Value: String);
        procedure SetNumAdicao(const Value: Integer);
        procedure SetNumDI(const Value: String);
        procedure SetNumeroItemPedidoCompra(const Value: Integer);
        procedure SetNumeroPedidoCompra(const Value: String);
        procedure SetNumItemAdicao(const Value: Integer);
        procedure SetObservacao(const Value: String);
        procedure SetQuantidade(const Value: Double);
        procedure SetTipoIntermedio(const Value: TTipoIntermedio);
        procedure SetTipoTransporte(const Value: TTipoTransporte);
        procedure SetUF_Terceiro(const Value: String);
        procedure SetUFDesenbaraco(const Value: String);
        procedure SetUnidade(const Value: String);
        procedure SetValorAcrescimo(const Value: Currency);
        procedure SetValorAFRMM(const Value: Currency);
        procedure SetValorDesconto(const Value: Currency);
        procedure SetValorFrete(const Value: Currency);
        procedure SetValorOutrasDespesas(const Value: Currency);
        procedure SetValorSeguro(const Value: Currency);
        procedure SetValorUnitario(const Value: Currency);
        function GetAliqAcrescimo: Currency;
        function GetAliqDesconto: Currency;
        function GetCFOP: String;
        function GetCNPJ_Adquerente: String;
        function GetCodigo: String;
        function GetCodigoDoProdutoNoFabricante: String;
        function GetCodigoExportador: String;
        function GetCodigoFederalServico: String;
        function GetCodigoMunicipalServico: String;
        function GetCST_CSOSN: String;
        function GetDataDesembaraco: TDate;
        function GetDataDI: TDate;
        function GetEAN13: String;
        function GetEX_TIPI: String;
        function GetImpostos: IImpostos;
        function GetLocalDesembaraco: String;
        function GetNCM: String;
        function GetNome: String;
        function GetNumAdicao: Integer;
        function GetNumDI: String;
        function GetNumeroItemPedidoCompra: Integer;
        function GetNumeroPedidoCompra: String;
        function GetNumItemAdicao: Integer;
        function GetObservacao: String;
        function GetQuantidade: Double;
        function GetTipoIntermedio: TTipoIntermedio;
        function GetTipoTransporte: TTipoTransporte;
        function GetTotalBruto: Currency;
        function GetUF_Terceiro: String;
        function GetUFDesenbaraco: String;
        function GetUnidade: String;
        function GetValorAcrescimo: Currency;
        function GetValorAFRMM: Currency;
        function GetValorDesconto: Currency;
        function GetValorFrete: Currency;
        function GetValorOutrasDespesas: Currency;
        function GetValorSeguro: Currency;
        function GetValorTotalLiquido: Currency;
        function GetValorUnitario: Currency;
        procedure SetTotalBruto(const Value: Currency);
        procedure SetValorTotalLiquido(const Value: Currency);
        procedure SetIdCliente(const Value: TipoCampoChave);

      published
        property Codigo: String read GetCodigo write SetCodigo;
        Property EAN13: String read GetEAN13 ;
        property Nome:String read GetNome ;
        property Observacao:String read GetObservacao write SetObservacao;
        property Unidade: String read GetUnidade write SetUnidade;

        property Quantidade: Double read GetQuantidade write SetQuantidade;
        property ValorUnitario: Currency read GetValorUnitario write SetValorUnitario;
        property TotalBruto: Currency read GetTotalBruto write SetTotalBruto;
        Property ValorDesconto: Currency read GetValorDesconto write SetValorDesconto;
        Property ValorAcrescimo: Currency read GetValorAcrescimo write SetValorAcrescimo;
        Property AliqDesconto: Currency read GetAliqDesconto write SetAliqDesconto;
        Property AliqAcrescimo: Currency read GetAliqAcrescimo write SetAliqAcrescimo;

        property ValorFrete: Currency read GetValorFrete write SetValorFrete;
        Property ValorSeguro: Currency read GetValorSeguro write SetValorSeguro;
        Property ValorOutrasDespesas: Currency read GetValorOutrasDespesas write SetValorOutrasDespesas;

        Property ValorTotalLiquido: Currency read GetValorTotalLiquido write SetValorTotalLiquido;

        Property CFOP:String read GetCFOP write SetCFOP;
        Property CST_CSOSN: String read GetCST_CSOSN write SetCST_CSOSN;
        Property NCM: String read GetNCM ;
        Property CodigoMunicipalServico: String read GetCodigoMunicipalServico ;
        Property CodigoFederalServico: String read GetCodigoFederalServico ;
        Property EX_TIPI: String read GetEX_TIPI ;

        Property NumDI: String read GetNumDI write SetNumDI;
        Property DataDI: TDate read GetDataDI write SetDataDI;
        Property LocalDesembaraco: String read GetLocalDesembaraco write SetLocalDesembaraco;
        Property UFDesenbaraco: String read GetUFDesenbaraco write SetUFDesenbaraco;
        Property DataDesembaraco: TDate read GetDataDesembaraco write SetDataDesembaraco;
        property TipoTransporte: TTipoTransporte read GetTipoTransporte write SetTipoTransporte;
        property ValorAFRMM: Currency read GetValorAFRMM write SetValorAFRMM;
        property TipoIntermedio: TTipoIntermedio read GetTipoIntermedio write SetTipoIntermedio;
        property CNPJ_Adquerente: String read GetCNPJ_Adquerente write SetCNPJ_Adquerente;
        property UF_Terceiro:String read GetUF_Terceiro write SetUF_Terceiro;
        property CodigoExportador:String read GetCodigoExportador write SetCodigoExportador;
        property NumAdicao: Integer read GetNumAdicao write SetNumAdicao;
        property NumItemAdicao:Integer read GetNumItemAdicao write SetNumItemAdicao;// Numero do Item na adição
        property CodigoDoProdutoNoFabricante: String read GetCodigoDoProdutoNoFabricante write SetCodigoDoProdutoNoFabricante;

        property NumeroPedidoCompra:String read GetNumeroPedidoCompra write SetNumeroPedidoCompra;
        property NumeroItemPedidoCompra:Integer read GetNumeroItemPedidoCompra write SetNumeroItemPedidoCompra;

        Property Impostos: IImpostos read GetImpostos ;
        property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;

      end;



implementation

uses uRegras;

{ IImpostos }

function TImpostos.GetAliqCOFINS: Currency;
begin
  Result := FAliqICMSST;
end;

function TImpostos.GetALiqCSLL: Currency;
begin
  Result := FALiqCSLL;
end;

function TImpostos.GetAliqICMS: Currency;
begin
  Result := FAliqICMS;
end;

function TImpostos.GetAliqICMSST: Currency;
begin
  Result := FAliqICMSST;
end;

function TImpostos.GetAliqIPI: Currency;
begin
  Result := FAliqIPI;
end;

function TImpostos.GetAliqISS: Currency;
begin
  Result := FAliqISS;
end;

function TImpostos.GetAliqPIS: Currency;
begin
  Result := FAliqPIS;
end;

function TImpostos.GetBaseCSLL: Currency;
begin
  Result := FBaseCSLL;
end;

function TImpostos.GetBaseICMSST: Currency;
begin
  Result := FBaseICMSST;
end;

function TImpostos.GetBaseICMS_ISS: Currency;
begin
  Result := FBaseICMS_ISS;
end;

function TImpostos.GetBaseIPI: Currency;
begin
  Result := FBaseIPI;
end;

function TImpostos.GetBasePIS_COFINS: Currency;
begin
  Result := FBasePIS_COFINS;
end;

function TImpostos.GetMVA: Currency;
begin
  Result := FMVA;
end;

function TImpostos.GetTipoIPI: TTIpoIPI;
begin
  Result := FTipoIPI;
end;

function TImpostos.GetValorCSLL: Currency;
begin
  Result := FValorCSLL;
end;

function TImpostos.GetValorICMSST: Currency;
begin
  Result := FValorICMSST;
end;

function TImpostos.GetValorICMS_ISS: Currency;
begin
  Result := FValorICMS_ISS;
end;

function TImpostos.GetValorIPI: Currency;
begin
  Result := FValorIPI;
end;

function TImpostos.GetValorPIS_COFINS: Currency;
begin
  Result := FValorPIS_COFINS;
end;

procedure TImpostos.SetAliqCOFINS(const Value: Currency);
begin
  FAliqCOFINS := Value;
end;

procedure TImpostos.SetALiqCSLL(const Value: Currency);
begin
  FALiqCSLL := Value;
end;

procedure TImpostos.SetAliqICMS(const Value: Currency);
begin
  FAliqICMS := Value;
end;

procedure TImpostos.SetAliqICMSST(const Value: Currency);
begin
  FAliqICMSST := Value;
end;

procedure TImpostos.SetAliqIPI(const Value: Currency);
begin
  FAliqIPI := Value;
end;

procedure TImpostos.SetAliqISS(const Value: Currency);
begin
  FAliqISS := Value;
end;

procedure TImpostos.SetAliqPIS(const Value: Currency);
begin
  FAliqPIS := Value;
end;

procedure TImpostos.SetBaseCSLL(const Value: Currency);
begin
  FBaseCSLL := Value;
end;

procedure TImpostos.SetBaseICMSST(const Value: Currency);
begin
  FBaseICMSST := Value;
end;

procedure TImpostos.SetBaseICMS_ISS(const Value: Currency);
begin
  FBaseICMS_ISS := Value;
end;

procedure TImpostos.SetBaseIPI(const Value: Currency);
begin
  FBaseIPI := Value;
end;

procedure TImpostos.SetBasePIS_COFINS(const Value: Currency);
begin
  FBasePIS_COFINS := Value;
end;

procedure TImpostos.SetMVA(const Value: Currency);
begin
  FMVA := Value;
end;

procedure TImpostos.SetTipoIPI(const Value: TTIpoIPI);
begin
  FTipoIPI := Value;
end;

procedure TImpostos.SetValorCSLL(const Value: Currency);
begin
  FValorCSLL := Value;
end;

procedure TImpostos.SetValorICMSST(const Value: Currency);
begin
  FValorICMSST := Value;
end;

procedure TImpostos.SetValorICMS_ISS(const Value: Currency);
begin
  FValorICMS_ISS := Value;
end;

procedure TImpostos.SetValorIPI(const Value: Currency);
begin
  FValorIPI := Value;
end;

procedure TImpostos.SetValorPIS_COFINS(const Value: Currency);
begin
  FValorPIS_COFINS := Value;
end;

{ IEndereco }

function TEndereco.GetBairro: String;
begin
  Result := FBairro;
end;

function TEndereco.GetCEP: String;
begin
  Result := FCEP;
end;

function TEndereco.GetCidade: String;
begin
  Result := FCidade;
end;

function TEndereco.GetCodigoMunicipio: String;
begin
  Result := FCodigoMunicipio;
end;

function TEndereco.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TEndereco.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TEndereco.GetEstado: String;
begin
  Result := FEstado;
end;

function TEndereco.GetNomePais: String;
begin
  Result := FNomePais;
end;

function TEndereco.GetNumeroEndereco: String;
begin
  Result := FNumeroEndereco;
end;

function TEndereco.GetNumPais: Integer;
begin
  Result := FNumPais;
end;

procedure TEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TEndereco.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TEndereco.SetCodigoMunicipio(const Value: String);
begin
  FCodigoMunicipio := Value;
end;

procedure TEndereco.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TEndereco.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TEndereco.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TEndereco.SetNomePais(const Value: String);
begin
  FNomePais := Value;
end;

procedure TEndereco.SetNumeroEndereco(const Value: String);
begin
  FNumeroEndereco := Value;
end;

procedure TEndereco.SetNumPais(const Value: Integer);
begin
  FNumPais := Value;
end;

{ IIPessoa }

function TPessoa.GetCNAE: String;
begin
  Result := FCNAE;
end;

function TPessoa.GetCPF_CNPJ: String;
begin
  Result := FCPF_CNPJ;
end;

function TPessoa.GetCRT: String;
begin
  Result := FCRT;
end;

function TPessoa.GetEmail: String;
begin
  Result := FEmail;
end;

function TPessoa.GetEndereco: IEndereco;
begin
  Result := FEndereco;
end;

function TPessoa.GetIdentificacaoSUFRAMA: String;
begin
  Result := FIdentificacaoSUFRAMA;
end;

function TPessoa.GetIE: String;
begin
  Result := FIE;
end;

function TPessoa.GetIE_ST: String;
begin
  Result := FIE_ST;
end;

function TPessoa.GetIM: String;
begin
  Result := FIM;
end;

function TPessoa.GetNomeFantasia: String;
begin
  Result := FNomeFantasia;
end;

function TPessoa.GetNome_RazaoSocial: String;
begin
  Result := FNome_RazaoSocial;
end;

function TPessoa.GetSUFRAMA: String;
begin
  Result := FSUFRAMA;
end;

function TPessoa.GetTelefone: String;
begin
  Result := FTelefone;
end;

procedure TPessoa.SetCNAE(const Value: String);
begin
  FCNAE := Value;
end;

procedure TPessoa.SetCPF_CNPJ(const Value: String);
begin
  FCPF_CNPJ := Value;
end;

procedure TPessoa.SetCRT(const Value: String);
begin
  FCRT := Value;
end;

procedure TPessoa.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TPessoa.SetEndereco(const Value: IEndereco);
begin
  FEndereco := Value;
end;

procedure TPessoa.SetIdentificacaoSUFRAMA(const Value: String);
begin
  FIdentificacaoSUFRAMA := Value;
end;

procedure TPessoa.SetIE(const Value: String);
begin
  FIE := Value;
end;

procedure TPessoa.SetIE_ST(const Value: String);
begin
  FIE_ST := Value;
end;

procedure TPessoa.SetIM(const Value: String);
begin
  FIM := Value;
end;

procedure TPessoa.SetNomeFantasia(const Value: String);
begin
  FNomeFantasia := Value;
end;

procedure TPessoa.SetNome_RazaoSocial(const Value: String);
begin
  FNome_RazaoSocial := Value;
end;

procedure TPessoa.SetSUFRAMA(const Value: String);
begin
  FSUFRAMA := Value;
end;

procedure TPessoa.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

{ IItemDocumento }

function TItemDocumento.GetAliqAcrescimo: Currency;
begin
  Result := FAliqAcrescimo;
end;

function TItemDocumento.GetAliqDesconto: Currency;
begin
  Result := FAliqDesconto;
end;

function TItemDocumento.GetCFOP: String;
begin
  Result := FCFOP;
end;

function TItemDocumento.GetCNPJ_Adquerente: String;
begin
  Result := FCNPJ_Adquerente;
end;

function TItemDocumento.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TItemDocumento.GetCodigoDoProdutoNoFabricante: String;
begin
  Result := FCodigoDoProdutoNoFabricante;
end;

function TItemDocumento.GetCodigoExportador: String;
begin
  Result := FCodigoExportador;
end;

function TItemDocumento.GetCodigoFederalServico: String;
begin
  Result := FCodigoFederalServico;
end;

function TItemDocumento.GetCodigoMunicipalServico: String;
begin
  Result := FCodigoMunicipalServico;
end;

function TItemDocumento.GetCST_CSOSN: String;
begin
  Result := FCST_CSOSN;
end;

function TItemDocumento.GetDataDesembaraco: TDate;
begin
  Result := FDataDesembaraco;
end;

function TItemDocumento.GetDataDI: TDate;
begin
  Result := FDataDI;
end;

function TItemDocumento.GetEAN13: String;
begin
  Result := FEAN13;
end;

function TItemDocumento.GetEX_TIPI: String;
begin
  Result := FEX_TIPI;
end;

function TItemDocumento.GetImpostos: IImpostos;
begin
  FImpostos := TRegrasImpostos.CalculaImpostos(FIdCliente,FIdProduto,'',FCST_CSOSN, FValorTotalLiquido, FValorFrete,
                                               FValorSeguro,FValorOutrasDespesas );
  Result := FImpostos;
end;

function TItemDocumento.GetLocalDesembaraco: String;
begin
  Result := FLocalDesembaraco;
end;

function TItemDocumento.GetNCM: String;
begin
  Result := FNCM;
end;

function TItemDocumento.GetNome: String;
begin
  Result := FNome;
end;

function TItemDocumento.GetNumAdicao: Integer;
begin
  Result := FNumAdicao;
end;

function TItemDocumento.GetNumDI: String;
begin
  Result := FNumDI;
end;

function TItemDocumento.GetNumeroItemPedidoCompra: Integer;
begin
  Result := FNumeroItemPedidoCompra;
end;

function TItemDocumento.GetNumeroPedidoCompra: String;
begin
  Result := FNumeroPedidoCompra;
end;

function TItemDocumento.GetNumItemAdicao: Integer;
begin
  Result := FNumAdicao;
end;

function TItemDocumento.GetObservacao: String;
begin
  Result := FObservacao;
end;

function TItemDocumento.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

function TItemDocumento.GetTipoIntermedio: TTipoIntermedio;
begin
  Result := FTipoIntermedio;
end;

function TItemDocumento.GetTipoTransporte: TTipoTransporte;
begin
  Result := FTipoTransporte;
end;

function TItemDocumento.GetTotalBruto: Currency;
begin
  Result := FTotalBruto;
end;

function TItemDocumento.GetUFDesenbaraco: String;
begin
  Result := FUFDesenbaraco;
end;

function TItemDocumento.GetUF_Terceiro: String;
begin
  Result := FUF_Terceiro;
end;

function TItemDocumento.GetUnidade: String;
begin
  Result := FUnidade;
end;

function TItemDocumento.GetValorAcrescimo: Currency;
begin
  Result := FValorAcrescimo;
end;

function TItemDocumento.GetValorAFRMM: Currency;
begin
  Result := FValorAFRMM;
end;

function TItemDocumento.GetValorDesconto: Currency;
begin
  Result := FValorDesconto;
end;

function TItemDocumento.GetValorFrete: Currency;
begin
  Result := FValorFrete;
end;

function TItemDocumento.GetValorOutrasDespesas: Currency;
begin
  Result := FValorOutrasDespesas;
end;

function TItemDocumento.GetValorSeguro: Currency;
begin
  Result := FValorSeguro;
end;

function TItemDocumento.GetValorTotalLiquido: Currency;
begin
  Result := FValorTotalLiquido;
end;

function TItemDocumento.GetValorUnitario: Currency;
begin
  Result := FValorUnitario;
end;

procedure TItemDocumento.SetAliqAcrescimo(const Value: Currency);
begin
  FAliqAcrescimo := Value;
end;

procedure TItemDocumento.SetAliqDesconto(const Value: Currency);
begin
  FAliqDesconto := Value;
end;

procedure TItemDocumento.SetCFOP(const Value: String);
begin
  FCFOP := Value;
end;

procedure TItemDocumento.SetCNPJ_Adquerente(const Value: String);
begin
  FCNPJ_Adquerente := Value;
end;

procedure TItemDocumento.SetCodigo(const Value: String);
begin
  if FCodigo <> Value then
  begin
     FCodigo := Value;
     with GetCds(tpERPProduto,'codigo = '+QuotedStr(Value)) do
     begin
       Self.FNome := FieldByName('NOMEPRODUTO').AsString;
       Self.FEAN13 := FieldByName('CODIGOBARRAS').AsString;
       Self.FNCM :=   FieldByName('NCM').AsString;
       Self.FIdProduto :=   FieldByName('IDPRODUTO').Value;
       Self.FEX_TIPI :=   '';

       Free;
     end;

  end;



end;

procedure TItemDocumento.SetCodigoDoProdutoNoFabricante(const Value: String);
begin
  FCodigoDoProdutoNoFabricante := Value;
end;

procedure TItemDocumento.SetCodigoExportador(const Value: String);
begin
  FCodigoExportador := Value;
end;


procedure TItemDocumento.SetCST_CSOSN(const Value: String);
begin
  FCST_CSOSN := Value;
end;

procedure TItemDocumento.SetDataDesembaraco(const Value: TDate);
begin
  FDataDesembaraco := Value;
end;

procedure TItemDocumento.SetDataDI(const Value: TDate);
begin
  FDataDI := Value;
end;


procedure TItemDocumento.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

procedure TItemDocumento.SetLocalDesembaraco(const Value: String);
begin
  FLocalDesembaraco := Value;
end;


procedure TItemDocumento.SetNumAdicao(const Value: Integer);
begin
  FNumAdicao := Value;
end;

procedure TItemDocumento.SetNumDI(const Value: String);
begin
  FNumDI := Value;
end;

procedure TItemDocumento.SetNumeroItemPedidoCompra(const Value: Integer);
begin
  FNumeroItemPedidoCompra := Value;
end;

procedure TItemDocumento.SetNumeroPedidoCompra(const Value: String);
begin
  FNumeroPedidoCompra := Value;
end;

procedure TItemDocumento.SetNumItemAdicao(const Value: Integer);
begin
  FNumItemAdicao := Value;
end;

procedure TItemDocumento.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TItemDocumento.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TItemDocumento.SetTipoIntermedio(const Value: TTipoIntermedio);
begin
  FTipoIntermedio := Value;
end;

procedure TItemDocumento.SetTipoTransporte(const Value: TTipoTransporte);
begin
  FTipoTransporte := Value;
end;


procedure TItemDocumento.SetTotalBruto(const Value: Currency);
begin
  FTotalBruto := Value;
end;

procedure TItemDocumento.SetUFDesenbaraco(const Value: String);
begin
  FUFDesenbaraco := Value;
end;

procedure TItemDocumento.SetUF_Terceiro(const Value: String);
begin
  FUF_Terceiro := Value;
end;

procedure TItemDocumento.SetUnidade(const Value: String);
begin
  FUnidade := Value;
end;

procedure TItemDocumento.SetValorAcrescimo(const Value: Currency);
begin
  FValorAcrescimo := Value;
end;

procedure TItemDocumento.SetValorAFRMM(const Value: Currency);
begin
  FValorAFRMM := Value;
end;

procedure TItemDocumento.SetValorDesconto(const Value: Currency);
begin
  FValorDesconto := Value;
end;

procedure TItemDocumento.SetValorFrete(const Value: Currency);
begin
  FValorFrete := Value;
end;

procedure TItemDocumento.SetValorOutrasDespesas(const Value: Currency);
begin
  FValorOutrasDespesas := Value;
end;

procedure TItemDocumento.SetValorSeguro(const Value: Currency);
begin
  FValorSeguro := Value;
end;


procedure TItemDocumento.SetValorTotalLiquido(const Value: Currency);
begin
  FValorTotalLiquido := Value;
end;

procedure TItemDocumento.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
