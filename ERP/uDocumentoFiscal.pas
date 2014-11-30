unit uDocumentoFiscal;

interface
    uses
       MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,ulibERP, DateUtils, Generics.Collections;
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

      IImpostos = interface(IInterfaceMaster)
        procedure SetAliqICMS(const Value: Currency);
        procedure SetAliqISS(const Value: Currency);
        function GetAliqICMS: Currency;
        function GetAliqISS: Currency;
        function GetAliqIR: Currency;
        procedure SetAliqCOFINS(const Value: Currency);
        procedure SetAliqIR(const Value: Currency);
        procedure SetALiqCSLL(const Value: Currency);
        procedure SetAliqICMSST(const Value: Currency);
        procedure SetAliqIPI(const Value: Currency);
        procedure SetAliqPIS(const Value: Currency);
        procedure SetBaseCSLL(const Value: Currency);
        procedure SetBaseICMS(const Value: Currency);
        procedure SetBaseISS(const Value: Currency);
        procedure SetBaseICMSST(const Value: Currency);
        procedure SetBaseIPI(const Value: Currency);
        procedure SetBasePIS_COFINS(const Value: Currency);
        procedure SetBaseIR(const Value: Currency);
        procedure SetMVA(const Value: Currency);
        procedure SetTipoIPI(const Value: TTIpoIPI);
        procedure SetValorCSLL(const Value: Currency);
        procedure SetValorICMS(const Value: Currency);
        procedure SetValorISS(const Value: Currency);
        procedure SetValorICMSST(const Value: Currency);
        procedure SetValorIPI(const Value: Currency);
        procedure SetValorPIS(const Value: Currency);
        procedure SetValorCOFINS(const Value: Currency);
        procedure SetValorIR(const Value: Currency);

        function GetAliqCOFINS: Currency;
        function GetALiqCSLL: Currency;
        function GetAliqICMSST: Currency;
        function GetAliqIPI: Currency;
        function GetAliqPIS: Currency;
        function GetBaseCSLL: Currency;
        function GetBaseICMS: Currency;
        function GetBaseISS: Currency;
        function GetBaseICMSST: Currency;
        function GetBaseIPI: Currency;
        function GetBasePIS_COFINS: Currency;
        function GetBaseIR: Currency;
        function GetMVA: Currency;
        function GetTipoIPI: TTIpoIPI;
        function GetValorCSLL: Currency;
        function GetValorICMS: Currency;
        function GetValorISS: Currency;
        function GetValorICMSST: Currency;
        function GetValorIPI: Currency;
        function GetValorPIS: Currency;
        function GetValorCOFINS: Currency;
        function GetValorIR: Currency;

        property AliqICMS: Currency read GetAliqICMS write SetAliqICMS;
        property AliqISS: Currency read GetAliqISS write SetAliqISS;
        property AliqPIS: Currency read GetAliqPIS write SetAliqPIS;
        property AliqCOFINS: Currency read GetAliqCOFINS write SetAliqCOFINS;
        property AliqIPI: Currency read GetAliqIPI write SetAliqIPI;
        property TipoIPI: TTIpoIPI read GetTipoIPI write SetTipoIPI;
        property MVA: Currency read GetMVA write SetMVA;
        Property AliqICMSST: Currency read GetAliqICMSST write SetAliqICMSST;
        property ALiqCSLL: Currency read GetALiqCSLL write SetALiqCSLL;
        property ALiqIR: Currency read GetALiqIR write SetALiqIR;

        property BaseICMS: Currency read GetBaseICMS write SetBaseICMS;
        property BaseISS: Currency read GetBaseISS write SetBaseISS;
        property BaseIPI: Currency read GetBaseIPI write SetBaseIPI;
        Property BasePIS_COFINS: Currency read GetBasePIS_COFINS write SetBasePIS_COFINS;
        property BaseICMSST: Currency read GetBaseICMSST write SetBaseICMSST;
        property BaseCSLL: Currency read GetBaseCSLL write SetBaseCSLL;
        property BaseIR: Currency read GetBaseIR write SetBaseIR;

        property ValorICMS: Currency read GetValorICMS write SetValorICMS;
        property ValorISS: Currency read GetValorISS write SetValorISS;
        property ValorIPI: Currency read GetValorIPI write SetValorIPI;
        Property ValorPIS: Currency read GetValorPIS write SetValorPIS;
        Property ValorCOFINS: Currency read GetValorCOFINS write SetValorCOFINS;
        property ValorICMSST: Currency read GetValorICMSST write SetValorICMSST;
        property ValorCSLL: Currency read GetValorCSLL write SetValorCSLL;
        property ValorIR: Currency read GetValorIR write SetValorIR;


      end;


      IItemDocumento = interface(IInterfaceMaster)

        procedure SetAliqAcrescimo(const Value: Currency);
        procedure SetAliqDesconto(const Value: Currency);
        procedure SetCFOP(const Value: String);
        procedure SetCNPJ_Adquerente(const Value: String);
        procedure SetCodigo(const Value: String);
        procedure SetCodigoDoProdutoNoFabricante(const Value: String);
        procedure SetCodigoExportador(const Value: String);

        procedure SetCST(const Value: String);
        procedure SetCSOSN(const Value: String);
        procedure SetCRT(const Value: String);
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
        function GetCST: String;
        function GetCSOSN: String;
        function GetCRT: String;
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
        Property CST: String read GetCST write SetCST;
        Property CSOSN: String read GetCSOSN write SetCSOSN;
        Property CRT: String read GetCRT write SetCRT;
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

      ICobranca = interface(IInterfaceMaster)
        procedure SetNumeroDocumento(const Value: String);
        procedure SetValorDocumento(const Value: Currency);
        procedure SetVencimento(const Value: TDate);

        function GetNumeroDocumento: String;
        function GetValorDocumento: Currency;
        function GetVencimento: TDate;

        property NumeroDocumento: String read GetNumeroDocumento write SetNumeroDocumento;
        property ValorDocumento: Currency read GetValorDocumento write SetValorDocumento;
        property Vencimento: TDate read GetVencimento write SetVencimento;
      end;

      IDocumentoFiscal = Interface(IInterfaceMaster)
        procedure SetANTT(const Value: String);
        procedure SetCobranca(const Value: TList<ICobranca>);
        procedure SetDestinatario(const Value: IPessoa);
        procedure SetEmitente(const Value: IPessoa);
        procedure SetEnderecoCobranca(const Value: IEndereco);
        procedure SetEnderecoEntrega(const Value: IEndereco);
        procedure SetEspecie(const Value: String);
        procedure SetFrete(const Value: Currency);
        procedure SetMarca(const Value: String);
        procedure SetOutrasDespesas(const Value: Currency);
        procedure SetPesoBruto(const Value: Double);
        procedure SetPesoLiquido(const Value: Double);
        procedure SetPlaca(const Value: String);
        procedure SetProdutos(const Value: TList<IItemDocumento>);
        procedure SetSeguro(const Value: Currency);
        procedure SetServicos(const Value: TList<IItemDocumento>);
        procedure SetTipoFrete(const Value: TTipoFrete);
        procedure SetTipoTransporte(const Value: TTipoTransporte);
        procedure SetTotalDocumento(const Value: Currency);
        procedure SetTotalImpostos(const Value: IImpostos);
        procedure SetTotalProdutos(const Value: Currency);
        procedure SetTotalServicos(const Value: Currency);
        procedure SetTransportadora(const Value: IPessoa);
        procedure SetUfPlaca(const Value: String);
        procedure SetVolume(const Value: Integer);
        function GetANTT: String;
        function GetCobranca: TList<ICobranca>;
        function GetDestinatario: IPessoa;
        function GetEmitente: IPessoa;
        function GetEnderecoCobranca: IEndereco;
        function GetEnderecoEntrega: IEndereco;
        function GetEspecie: String;
        function GetFrete: Currency;
        function GetMarca: String;
        function GetOutrasDespesas: Currency;
        function GetPesoBruto: Double;
        function GetPesoLiquido: Double;
        function GetPlaca: String;
        function GetProdutos: TList<IItemDocumento>;
        function GetSeguro: Currency;
        function GetServicos: TList<IItemDocumento>;
        function GetTipoFrete: TTipoFrete;
        function GetTipoTransporte: TTipoTransporte;
        function GetTotalDocumento: Currency;
        function GetTotalImpostos: IImpostos;
        function GetTotalProdutos: Currency;
        function GetTotalServicos: Currency;
        function GetTransportadora: IPessoa;
        function GetUfPlaca: String;
        function GetVolume: Integer;

        property Emitente: IPessoa read GetEmitente write SetEmitente;
        property Destinatario: IPessoa read GetDestinatario write SetDestinatario;
        property Transportadora: IPessoa read GetTransportadora write SetTransportadora;
        property EnderecoEntrega: IEndereco read GetEnderecoEntrega write SetEnderecoEntrega;
        property EnderecoCobranca: IEndereco read GetEnderecoCobranca write SetEnderecoCobranca;

        property Produtos:  TList<IItemDocumento> read GetProdutos write SetProdutos;
        property Servicos:  TList<IItemDocumento> read GetServicos write SetServicos;

        Property TotalImpostos: IImpostos read GetTotalImpostos write SetTotalImpostos;
        property TotalProdutos: Currency read GetTotalProdutos write SetTotalProdutos;
        Property TotalServicos: Currency read GetTotalServicos write SetTotalServicos;
        property Seguro: Currency read GetSeguro write SetSeguro;
        property Frete: Currency read GetFrete write SetFrete;
        property OutrasDespesas: Currency read GetOutrasDespesas write SetOutrasDespesas;
        property TotalDocumento: Currency read GetTotalDocumento write SetTotalDocumento;

        property TipoTransporte: TTipoTransporte read GetTipoTransporte write SetTipoTransporte;
        property TipoFrete: TTipoFrete read GetTipoFrete write SetTipoFrete;
        property Placa: String read GetPlaca write SetPlaca;
        Property UfPlaca: String read GetUfPlaca write SetUfPlaca;
        property ANTT: String read GetANTT write SetANTT;
        Property Volume: Integer read GetVolume write SetVolume;
        property Especie: String read GetEspecie write SetEspecie;
        property Marca: String read GetMarca write SetMarca;
        property PesoBruto: Double read GetPesoBruto write SetPesoBruto;
        property PesoLiquido: Double read GetPesoLiquido write SetPesoLiquido;

        Property Cobranca: TList<ICobranca> read GetCobranca write SetCobranca;


      end;

      TImpostos = class(TInterfacedObject,IImpostos)
      private
        FAliqICMS: Currency;
        FAliqISS: Currency;
        FValorPIS: Currency;
        FValorCOFINS: Currency;
        FBaseCSLL: Currency;
        FValorICMSST: Currency;
        FValorIPI: Currency;
        FBaseICMS: Currency;
        FBaseISS: Currency;
        FAliqICMSST: Currency;
        FAliqIPI: Currency;
        FMVA: Currency;
        FValorCSLL: Currency;
        FBasePIS_COFINS: Currency;
        FValorICMS: Currency;
        FValorISS: Currency;
        FBaseICMSST: Currency;
        FBaseIPI: Currency;
        FALiqCSLL: Currency;
        FTipoIPI: TTIpoIPI;
        FAliqPIS: Currency;
        FAliqCOFINS: Currency;
        FALiqIR: Currency;
        FBaseIR: Currency;
        FValorIR: Currency;
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
        procedure SetBaseICMS(const Value: Currency);
        procedure SetBaseISS(const Value: Currency);
        procedure SetBaseICMSST(const Value: Currency);
        procedure SetBaseIPI(const Value: Currency);
        procedure SetBasePIS_COFINS(const Value: Currency);
        procedure SetMVA(const Value: Currency);
        procedure SetTipoIPI(const Value: TTIpoIPI);
        procedure SetValorCSLL(const Value: Currency);
        procedure SetValorICMS(const Value: Currency);
        procedure SetValorISS(const Value: Currency);
        procedure SetValorICMSST(const Value: Currency);
        procedure SetValorIPI(const Value: Currency);
        procedure SetValorPIS(const Value: Currency);
        procedure SetValorCOFINS(const Value: Currency);
        function GetAliqCOFINS: Currency;
        function GetALiqCSLL: Currency;
        function GetAliqICMSST: Currency;
        function GetAliqIPI: Currency;
        function GetAliqPIS: Currency;
        function GetBaseCSLL: Currency;
        function GetBaseICMS: Currency;
        function GetBaseISS: Currency;
        function GetBaseICMSST: Currency;
        function GetBaseIPI: Currency;
        function GetBasePIS_COFINS: Currency;
        function GetMVA: Currency;
        function GetTipoIPI: TTIpoIPI;
        function GetValorCSLL: Currency;
        function GetValorICMS: Currency;
        function GetValorISS: Currency;
        function GetValorICMSST: Currency;
        function GetValorIPI: Currency;
        function GetValorPIS: Currency;
        function GetValorCOFINS: Currency;
        function GetALiqIR: Currency;
        function GetBaseIR: Currency;
        function GetValorIR: Currency;
        procedure SetALiqIR(const Value: Currency);
        procedure SetBaseIR(const Value: Currency);
        procedure SetValorIR(const Value: Currency);


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
        property ALiqIR: Currency read GetALiqIR write SetALiqIR;

        property BaseICMS: Currency read GetBaseICMS write SetBaseICMS;
        property BaseISS: Currency read GetBaseISS write SetBaseISS;
        property BaseIPI: Currency read GetBaseIPI write SetBaseIPI;
        Property BasePIS_COFINS: Currency read GetBasePIS_COFINS write SetBasePIS_COFINS;
        property BaseICMSST: Currency read GetBaseICMSST write SetBaseICMSST;
        property BaseCSLL: Currency read GetBaseCSLL write SetBaseCSLL;
        property BaseIR: Currency read GetBaseIR write SetBaseIR;

        property ValorICMS: Currency read GetValorICMS write SetValorICMS;
        property ValorISS: Currency read GetValorISS write SetValorISS;
        property ValorIPI: Currency read GetValorIPI write SetValorIPI;
        Property ValorPIS: Currency read GetValorPIS write SetValorPIS;
        Property ValorCOFINS: Currency read GetValorCOFINS write SetValorCOFINS;
        property ValorICMSST: Currency read GetValorICMSST write SetValorICMSST;
        property ValorCSLL: Currency read GetValorCSLL write SetValorCSLL;
        property ValorIR: Currency read GetValorIR write SetValorIR;


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
        FCST: String;
        FCSOSN: String;
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
        FCRT: String;
        procedure SetAliqAcrescimo(const Value: Currency);
        procedure SetAliqDesconto(const Value: Currency);
        procedure SetCFOP(const Value: String);
        procedure SetCNPJ_Adquerente(const Value: String);
        procedure SetCodigo(const Value: String);
        procedure SetCodigoDoProdutoNoFabricante(const Value: String);
        procedure SetCodigoExportador(const Value: String);
        procedure SetCST(const Value: String);
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
        function GetCST: String;
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
        procedure SetImpostos(const Value: IImpostos);
        function GetCSOSN: String;
        procedure SetCSOSN(const Value: String);
        function GetCRT: String;
        procedure SetCRT(const Value: String);

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
        Property CST: String read GetCST write SetCST;
        Property CSOSN: String read GetCSOSN write SetCSOSN;
        Property CRT: String read GetCRT write SetCRT;
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

        Property Impostos: IImpostos read GetImpostos write SetImpostos;
        property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;

      end;

      TCobranca = class(TInterfacedObject, ICobranca)
        FVencimento: TDate;
        FValorDocumento: Currency;
        FNumeroDocumento: String;
        procedure SetNumeroDocumento(const Value: String);
        procedure SetValorDocumento(const Value: Currency);
        procedure SetVencimento(const Value: TDate);
        function GetNumeroDocumento: String;
        function GetValorDocumento: Currency;
        function GetVencimento: TDate;
        property NumeroDocumento: String read GetNumeroDocumento write SetNumeroDocumento;
        property ValorDocumento: Currency read GetValorDocumento write SetValorDocumento;
        property Vencimento: TDate read GetVencimento write SetVencimento;
      end;

      TDocumentoFiscal = class(TInterfacedObject,IDocumentoFiscal)
      private
        FPesoBruto: Double;
        FUfPlaca: String;
        FTotalImpostos: IImpostos;
        FDestinatario: IPessoa;
        FEspecie: String;
        FTotalProdutos: Currency;
        FEnderecoCobranca: IEndereco;
        FEnderecoEntrega: IEndereco;
        FTransportadora: IPessoa;
        FANTT: String;
        FCobranca: TList<ICobranca>;
        FSeguro: Currency;
        FTotalServicos: Currency;
        FOutrasDespesas: Currency;
        FEmitente: IPessoa;
        FTipoTransporte: TTipoTransporte;
        FPesoLiquido: Double;
        FVolume: Integer;
        FTipoFrete: TTipoFrete;
        FProdutos: TList<IItemDocumento>;
        FMarca: String;
        FPlaca: String;
        FFrete: Currency;
        FTotalDocumento: Currency;
        FServicos: TList<IItemDocumento>;
        procedure SetANTT(const Value: String);
        procedure SetCobranca(const Value: TList<ICobranca>);
        procedure SetDestinatario(const Value: IPessoa);
        procedure SetEmitente(const Value: IPessoa);
        procedure SetEnderecoCobranca(const Value: IEndereco);
        procedure SetEnderecoEntrega(const Value: IEndereco);
        procedure SetEspecie(const Value: String);
        procedure SetFrete(const Value: Currency);
        procedure SetMarca(const Value: String);
        procedure SetOutrasDespesas(const Value: Currency);
        procedure SetPesoBruto(const Value: Double);
        procedure SetPesoLiquido(const Value: Double);
        procedure SetPlaca(const Value: String);
        procedure SetProdutos(const Value: TList<IItemDocumento>);
        procedure SetSeguro(const Value: Currency);
        procedure SetServicos(const Value: TList<IItemDocumento>);
        procedure SetTipoFrete(const Value: TTipoFrete);
        procedure SetTipoTransporte(const Value: TTipoTransporte);
        procedure SetTotalDocumento(const Value: Currency);
        procedure SetTotalImpostos(const Value: IImpostos);
        procedure SetTotalProdutos(const Value: Currency);
        procedure SetTotalServicos(const Value: Currency);
        procedure SetTransportadora(const Value: IPessoa);
        procedure SetUfPlaca(const Value: String);
        procedure SetVolume(const Value: Integer);
        function GetANTT: String;
        function GetCobranca: TList<ICobranca>;
        function GetDestinatario: IPessoa;
        function GetEmitente: IPessoa;
        function GetEnderecoCobranca: IEndereco;
        function GetEnderecoEntrega: IEndereco;
        function GetEspecie: String;
        function GetFrete: Currency;
        function GetMarca: String;
        function GetOutrasDespesas: Currency;
        function GetPesoBruto: Double;
        function GetPesoLiquido: Double;
        function GetPlaca: String;
        function GetProdutos: TList<IItemDocumento>;
        function GetSeguro: Currency;
        function GetServicos: TList<IItemDocumento>;
        function GetTipoFrete: TTipoFrete;
        function GetTipoTransporte: TTipoTransporte;
        function GetTotalDocumento: Currency;
        function GetTotalImpostos: IImpostos;
        function GetTotalProdutos: Currency;
        function GetTotalServicos: Currency;
        function GetTransportadora: IPessoa;
        function GetUfPlaca: String;
        function GetVolume: Integer;
      published
        property Emitente: IPessoa read GetEmitente write SetEmitente;
        property Destinatario: IPessoa read GetDestinatario write SetDestinatario;
        property Transportadora: IPessoa read GetTransportadora write SetTransportadora;
        property EnderecoEntrega: IEndereco read GetEnderecoEntrega write SetEnderecoEntrega;
        property EnderecoCobranca: IEndereco read GetEnderecoCobranca write SetEnderecoCobranca;

        property Produtos:  TList<IItemDocumento> read GetProdutos write SetProdutos;
        property Servicos:  TList<IItemDocumento> read GetServicos write SetServicos;

        Property TotalImpostos: IImpostos read GetTotalImpostos ;
        property TotalProdutos: Currency read GetTotalProdutos ;
        Property TotalServicos: Currency read GetTotalServicos ;
        property Seguro: Currency read GetSeguro write SetSeguro;
        property Frete: Currency read GetFrete write SetFrete;
        property OutrasDespesas: Currency read GetOutrasDespesas write SetOutrasDespesas;
        property TotalDocumento: Currency read GetTotalDocumento write SetTotalDocumento;

        property TipoTransporte: TTipoTransporte read GetTipoTransporte write SetTipoTransporte;
        property TipoFrete: TTipoFrete read GetTipoFrete write SetTipoFrete;
        property Placa: String read GetPlaca write SetPlaca;
        Property UfPlaca: String read GetUfPlaca write SetUfPlaca;
        property ANTT: String read GetANTT write SetANTT;
        Property Volume: Integer read GetVolume write SetVolume;
        property Especie: String read GetEspecie write SetEspecie;
        property Marca: String read GetMarca write SetMarca;
        property PesoBruto: Double read GetPesoBruto write SetPesoBruto;
        property PesoLiquido: Double read GetPesoLiquido write SetPesoLiquido;

        Property Cobranca: TList<ICobranca> read GetCobranca write SetCobranca;
        constructor Create;virtual;

      end;

      Procedure CriaDocumentoFiscal(Const DataSetNota, DataSetItens, DataSetCobranca: TDataSet; Var Doc: IDocumentoFiscal );

implementation

uses uRegras;

{ IImpostos }

function TImpostos.GetAliqCOFINS: Currency;
begin
  Result := FAliqCOFINS;
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

function TImpostos.GetALiqIR: Currency;
begin
  Result := FALiqIR;
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

function TImpostos.GetBaseICMS: Currency;
begin
  Result := FBaseICMS;
end;

function TImpostos.GetBaseISS: Currency;
begin
  Result := FBaseISS;
end;

function TImpostos.GetBaseIPI: Currency;
begin
  Result := FBaseIPI;
end;

function TImpostos.GetBaseIR: Currency;
begin
  Result := FBaseIR;
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

function TImpostos.GetValorCOFINS: Currency;
begin
  Result := FValorCOFINS;
end;

function TImpostos.GetValorCSLL: Currency;
begin
  Result := FValorCSLL;
end;

function TImpostos.GetValorICMSST: Currency;
begin
  Result := FValorICMSST;
end;

function TImpostos.GetValorICMS: Currency;
begin
  Result := FValorICMS;
end;

function TImpostos.GetValorISS: Currency;
begin
  Result := FValorISS;
end;


function TImpostos.GetValorIPI: Currency;
begin
  Result := FValorIPI;
end;


function TImpostos.GetValorIR: Currency;
begin
  Result := FValorIR;
end;

function TImpostos.GetValorPIS: Currency;
begin
  Result := FValorPIS;
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

procedure TImpostos.SetALiqIR(const Value: Currency);
begin
  FALiqIR := Value;
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

procedure TImpostos.SetBaseICMS(const Value: Currency);
begin
  FBaseICMS := Value;
end;

procedure TImpostos.SetBaseISS(const Value: Currency);
begin
  FBaseISS := Value;
end;


procedure TImpostos.SetBaseIPI(const Value: Currency);
begin
  FBaseIPI := Value;
end;

procedure TImpostos.SetBaseIR(const Value: Currency);
begin
  FBaseIR := Value;
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

procedure TImpostos.SetValorCOFINS(const Value: Currency);
begin
   FValorCOFINS := Value;
end;

procedure TImpostos.SetValorCSLL(const Value: Currency);
begin
  FValorCSLL := Value;
end;

procedure TImpostos.SetValorICMSST(const Value: Currency);
begin
  FValorICMSST := Value;
end;

procedure TImpostos.SetValorICMS(const Value: Currency);
begin
  FValorICMS := Value;
end;

procedure TImpostos.SetValorISS(const Value: Currency);
begin
  FValorISS := Value;
end;


procedure TImpostos.SetValorIPI(const Value: Currency);
begin
  FValorIPI := Value;
end;

procedure TImpostos.SetValorIR(const Value: Currency);
begin
   FValorIR :=Value;
end;

procedure TImpostos.SetValorPIS(const Value: Currency);
begin
  FValorPIS := Value;
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

function TItemDocumento.GetCRT: String;
begin
  Result := fCRT;
end;

function TItemDocumento.GetCSOSN: String;
begin
   Result := FCSOSN;
end;


function TItemDocumento.GetCST: String;
begin
  Result := FCST;
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
//  if FImpostos = nil then
//  begin
//    FImpostos := TImpostos.Create;
//    FImpostos := TRegrasImpostos.CalculaImpostos(FIdCliente,FIdProduto,'',FCST_CSOSN, FValorTotalLiquido, FValorFrete,
//                                                 FValorSeguro,FValorOutrasDespesas );
//  end;
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
       FreeAndNil(Self.FImpostos);
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


procedure TItemDocumento.SetCRT(const Value: String);
begin
  FCRT := Value;
end;

procedure TItemDocumento.SetCSOSN(const Value: String);
begin
  FCSOSN := Value;
end;


procedure TItemDocumento.SetCST(const Value: String);
begin
  FCST := Value;
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

procedure TItemDocumento.SetImpostos(const Value: IImpostos);
begin
  FImpostos := Value;
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

{ ICobranca }

function TCobranca.GetNumeroDocumento: String;
begin
  Result := FNumeroDocumento;
end;

function TCobranca.GetValorDocumento: Currency;
begin
  Result := FValorDocumento;
end;

function TCobranca.GetVencimento: TDate;
begin
  Result := FVencimento;
end;

procedure TCobranca.SetNumeroDocumento(const Value: String);
begin
  FNumeroDocumento := Value;
end;

procedure TCobranca.SetValorDocumento(const Value: Currency);
begin
  FValorDocumento := Value;
end;

procedure TCobranca.SetVencimento(const Value: TDate);
begin
  FVencimento := Value;
end;

{ IDocumentoFiscal }

constructor TDocumentoFiscal.Create;
begin
    FPesoBruto:= 0;
    FUfPlaca:= '';
    FTotalImpostos:= TImpostos.Create;
    FDestinatario:= TPessoa.Create;
    FEspecie:= '' ;
    FTotalProdutos:= 0;
    FEnderecoCobranca:= TEndereco.Create;
    FEnderecoEntrega:= TEndereco.Create;
    FTransportadora:= TPessoa.Create;
    FANTT := '';
    FCobranca:= TList<ICobranca>.Create;
    FSeguro:= 0;
    FTotalServicos:= 0;
    FOutrasDespesas:= 0;
    FEmitente:= TPessoa.Create;
    FTipoTransporte:= ttRodoviaria;
    FPesoLiquido:= 0;
    FVolume:= 1;
    FTipoFrete:= tfDestinatario;
    FProdutos:=  TList<IItemDocumento>.Create;
    FMarca:= '';
    FPlaca:= '';
    FFrete:= 0;
    FTotalDocumento:= 0;
    FServicos:= TList<IItemDocumento>.Create;
end;

function TDocumentoFiscal.GetANTT: String;
begin
  Result := FANTT;
end;

function TDocumentoFiscal.GetCobranca: TList<ICobranca>;
begin
  Result := FCobranca;
end;

function TDocumentoFiscal.GetDestinatario: IPessoa;
begin
  Result := FDestinatario;
end;

function TDocumentoFiscal.GetEmitente: IPessoa;
begin
  Result := FEmitente;
end;

function TDocumentoFiscal.GetEnderecoCobranca: IEndereco;
begin
  Result := FEnderecoCobranca;
end;

function TDocumentoFiscal.GetEnderecoEntrega: IEndereco;
begin
  Result := FEnderecoEntrega;
end;

function TDocumentoFiscal.GetEspecie: String;
begin
  Result := FEspecie;
end;

function TDocumentoFiscal.GetFrete: Currency;
begin
  Result := FFrete;
end;

function TDocumentoFiscal.GetMarca: String;
begin
  Result := FMarca;
end;

function TDocumentoFiscal.GetOutrasDespesas: Currency;
begin
  Result := FOutrasDespesas;
end;

function TDocumentoFiscal.GetPesoBruto: Double;
begin
  Result := FPesoBruto;
end;

function TDocumentoFiscal.GetPesoLiquido: Double;
begin
  Result := FPesoLiquido;
end;

function TDocumentoFiscal.GetPlaca: String;
begin
  Result := FPlaca;
end;

function TDocumentoFiscal.GetProdutos: TList<IItemDocumento>;
begin
  Result := FProdutos;
end;

function TDocumentoFiscal.GetSeguro: Currency;
begin
  Result := FSeguro;
end;

function TDocumentoFiscal.GetServicos: TList<IItemDocumento>;
begin
  Result := FServicos;
end;

function TDocumentoFiscal.GetTipoFrete: TTipoFrete;
begin
  Result := FTipoFrete;
end;

function TDocumentoFiscal.GetTipoTransporte: TTipoTransporte;
begin
  Result := FTipoTransporte;
end;

function TDocumentoFiscal.GetTotalDocumento: Currency;
begin
  Result := FTotalDocumento;
end;

function TDocumentoFiscal.GetTotalImpostos: IImpostos;
var
  I: Integer;
begin
  FTotalImpostos.AliqICMS := 0;
  FTotalImpostos.AliqISS := 0;
  FTotalImpostos.AliqPIS := 0;
  FTotalImpostos.AliqCOFINS := 0;
  FTotalImpostos.AliqIPI := 0;
  FTotalImpostos.MVA := 0;
  FTotalImpostos.AliqICMSST := 0;
  FTotalImpostos.ALiqCSLL := 0;
  FTotalImpostos.ValorICMS := 0;
  FTotalImpostos.ValorISS := 0;
  FTotalImpostos.ValorIPI := 0;
  FTotalImpostos.ValorPIS := 0;
  FTotalImpostos.ValorCOFINS := 0;
  FTotalImpostos.ValorICMSST := 0;
  FTotalImpostos.ValorCSLL := 0;

  for I := 0 to Produtos.Count - 1 do
  begin
    FTotalImpostos.ValorICMS := FTotalImpostos.ValorICMS + Produtos[i].Impostos.ValorICMS;
    FTotalImpostos.ValorIPI   := FTotalImpostos.ValorIPI + Produtos[i].Impostos.ValorIPI;
    FTotalImpostos.ValorPIS  := FTotalImpostos.ValorPIS + Produtos[i].Impostos.ValorPIS;
    FTotalImpostos.ValorCOFINS  := FTotalImpostos.ValorCOFINS + Produtos[i].Impostos.ValorCOFINS;
    FTotalImpostos.ValorICMSST  := FTotalImpostos.ValorICMSST + Produtos[i].Impostos.ValorICMSST;
    FTotalImpostos.ValorCSLL  := FTotalImpostos.ValorCSLL + Produtos[i].Impostos.ValorCSLL;
  end;

  for I := 0 to Servicos.Count - 1 do
  begin
    FTotalImpostos.ValorISS := FTotalImpostos.ValorISS + Produtos[i].Impostos.ValorISS;
    FTotalImpostos.ValorIPI   := FTotalImpostos.ValorIPI + Servicos[i].Impostos.ValorIPI;
    FTotalImpostos.ValorPIS  := FTotalImpostos.ValorPIS + Servicos[i].Impostos.ValorPIS;
    FTotalImpostos.ValorCOFINS  := FTotalImpostos.ValorCOFINS + Servicos[i].Impostos.ValorCOFINS;
    FTotalImpostos.ValorICMSST  := FTotalImpostos.ValorICMSST + Servicos[i].Impostos.ValorICMSST;
    FTotalImpostos.ValorCSLL  := FTotalImpostos.ValorCSLL + Servicos[i].Impostos.ValorCSLL;
  end;

  Result := FTotalImpostos;
end;

function TDocumentoFiscal.GetTotalProdutos: Currency;
var
  I:Integer;
begin
  FTotalProdutos:= 0 ;
  for I := 0 to FProdutos.Count - 1 do
    FTotalProdutos:= FTotalProdutos+ FProdutos.Items[i].ValorTotalLiquido;

  Result := FTotalProdutos;
end;

function TDocumentoFiscal.GetTotalServicos: Currency;
var
  I:Integer;
begin
  for I := 0 to FServicos.Count - 1 do
    FTotalServicos:= FTotalServicos+ FServicos.Items[i].ValorTotalLiquido;

  Result := FTotalServicos;
end;

function TDocumentoFiscal.GetTransportadora: IPessoa;
begin
  Result := FTransportadora;
end;

function TDocumentoFiscal.GetUfPlaca: String;
begin
  Result := FUfPlaca;
end;

function TDocumentoFiscal.GetVolume: Integer;
begin
  Result := FVolume;
end;

procedure TDocumentoFiscal.SetANTT(const Value: String);
begin
  FANTT := Value;
end;

procedure TDocumentoFiscal.SetCobranca(const Value: TList<ICobranca>);
begin
  FCobranca := Value;
end;

procedure TDocumentoFiscal.SetDestinatario(const Value: IPessoa);
begin
  FDestinatario := Value;
end;

procedure TDocumentoFiscal.SetEmitente(const Value: IPessoa);
begin
  FEmitente := Value;
end;

procedure TDocumentoFiscal.SetEnderecoCobranca(const Value: IEndereco);
begin
  FEnderecoCobranca := Value;
end;

procedure TDocumentoFiscal.SetEnderecoEntrega(const Value: IEndereco);
begin
  FEnderecoEntrega := Value;
end;

procedure TDocumentoFiscal.SetEspecie(const Value: String);
begin
  FEspecie := Value;
end;

procedure TDocumentoFiscal.SetFrete(const Value: Currency);
begin
  FFrete := Value;
end;

procedure TDocumentoFiscal.SetMarca(const Value: String);
begin
  FMarca := Value;
end;

procedure TDocumentoFiscal.SetOutrasDespesas(const Value: Currency);
begin
  FOutrasDespesas := Value;
end;

procedure TDocumentoFiscal.SetPesoBruto(const Value: Double);
begin
  FPesoBruto := Value;
end;

procedure TDocumentoFiscal.SetPesoLiquido(const Value: Double);
begin
  FPesoLiquido := Value;
end;

procedure TDocumentoFiscal.SetPlaca(const Value: String);
begin
  FPlaca := Value;
end;

procedure TDocumentoFiscal.SetProdutos(const Value: TList<IItemDocumento>);
begin
  FProdutos := Value;
end;

procedure TDocumentoFiscal.SetSeguro(const Value: Currency);
begin
  FSeguro := Value;
end;

procedure TDocumentoFiscal.SetServicos(const Value: TList<IItemDocumento>);
begin
  FServicos := Value;
end;

procedure TDocumentoFiscal.SetTipoFrete(const Value: TTipoFrete);
begin
  FTipoFrete := Value;
end;

procedure TDocumentoFiscal.SetTipoTransporte(const Value: TTipoTransporte);
begin
  FTipoTransporte := Value;
end;

procedure TDocumentoFiscal.SetTotalDocumento(const Value: Currency);
begin
  FTotalDocumento := Value;
end;

procedure TDocumentoFiscal.SetTotalImpostos(const Value: IImpostos);
begin
  FTotalImpostos := Value;
end;

procedure TDocumentoFiscal.SetTotalProdutos(const Value: Currency);
begin
  FTotalProdutos := Value;
end;

procedure TDocumentoFiscal.SetTotalServicos(const Value: Currency);
begin
  FTotalServicos := Value;
end;

procedure TDocumentoFiscal.SetTransportadora(const Value: IPessoa);
begin
  FTransportadora := Value;
end;

procedure TDocumentoFiscal.SetUfPlaca(const Value: String);
begin
  FUfPlaca := Value;
end;

procedure TDocumentoFiscal.SetVolume(const Value: Integer);
begin
  FVolume := Value;
end;


Procedure CriaDocumentoFiscal(Const DataSetNota, DataSetItens, DataSetCobranca: TDataSet; Var Doc: IDocumentoFiscal );
var
  Item: IItemDocumento;
  Cob: TCobranca;
begin
  if not Assigned(Doc) then
    Doc := TDocumentoFiscal.Create;

  {$Region 'Cria Emitente'}
  with GetCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idempresa').Value)) do
  begin
    Doc.Emitente.Nome_RazaoSocial :=FieldByName('RAZAOSOCIAL').AsString;
    Doc.Emitente.NomeFantasia :=FieldByName('FANTASIA').AsString;
    Doc.Emitente.CPF_CNPJ :=FieldByName('CNPJ').AsString;
    Doc.Emitente.Telefone :=FieldByName('TELEFONE').AsString;
    Doc.Emitente.IE :=FieldByName('IE').AsString;
    Doc.Emitente.IE_ST :='';
    Doc.Emitente.SUFRAMA :='';
    Doc.Emitente.IdentificacaoSUFRAMA := '';
    Doc.Emitente.IM :=FieldByName('IM').AsString;
    Doc.Emitente.Email :='';
    Doc.Emitente.CNAE :='';  { TODO : Rever }
    Doc.Emitente.CRT :=''; { TODO : Rever }
    Doc.Emitente.Endereco.Endereco :=FieldByName('LOGRADOURO').AsString;
    Doc.Emitente.Endereco.NumeroEndereco :=FieldByName('NUMERO').AsString;
    Doc.Emitente.Endereco.Complemento :=FieldByName('COMPLEMENTO').AsString;
    Doc.Emitente.Endereco.Bairro :=FieldByName('BAIRRO').AsString;
    Doc.Emitente.Endereco.Cidade :=FieldByName('CIDADE').AsString;
    Doc.Emitente.Endereco.Estado :=FieldByName('UF').AsString;
    Doc.Emitente.Endereco.CodigoMunicipio := '';{ TODO : Rever }
    Doc.Emitente.Endereco.CEP :=FieldByName('CEP').AsString;
    Doc.Emitente.Endereco.NumPais := 1058;
    Doc.Emitente.Endereco.NomePais := 'BRASIL';

    Free;
  end;
  {$EndRegion}

  {$Region 'Cria Destinatario'}
  if (DataSetNota.FindField('IDCliente') <> nil) and
     (not DataSetNota.FieldByName('IDCliente').IsNull) then
  begin
    with GetCds(tpERPCliente,'IDCliente = '+TipoCampoChaveToStr(DataSetNota.FieldByName('IDCliente').Value)) do
    begin
      Doc.Destinatario.Nome_RazaoSocial :=FieldByName('NOMECLIENTE').AsString;
      Doc.Destinatario.NomeFantasia :=FieldByName('FANTASIA').AsString;
      if FieldByName('CNPJ').AsString = '' then
        Doc.Destinatario.CPF_CNPJ :=FieldByName('CNPJ').AsString
      else
      if FieldByName('CPF').AsString = '' then
        Doc.Destinatario.CPF_CNPJ :=FieldByName('CPF').AsString
      else
      begin
        Free;
        AvisaErro('O CPF/CNPJ do destinatário deve estar preenchido');
      end;


      Doc.Destinatario.Telefone :=FieldByName('TELEFONE').AsString;
      Doc.Destinatario.IE :=FieldByName('IE').AsString;
      Doc.Destinatario.IE_ST :='';
      Doc.Destinatario.SUFRAMA :='';
      Doc.Destinatario.IdentificacaoSUFRAMA := '';
      Doc.Destinatario.IM :=FieldByName('IM').AsString;
      Doc.Destinatario.Email := FieldByName('email').AsString;
      Doc.Destinatario.Endereco.Endereco :=FieldByName('LOGRADOURO').AsString;
      Doc.Destinatario.Endereco.NumeroEndereco :=FieldByName('NUMERO').AsString;
      Doc.Destinatario.Endereco.Complemento :=FieldByName('COMPLEMENTO').AsString;
      Doc.Destinatario.Endereco.Bairro :=FieldByName('BAIRRO').AsString;
      Doc.Destinatario.Endereco.Cidade :=FieldByName('CIDADE').AsString;
      Doc.Destinatario.Endereco.Estado :=FieldByName('UF').AsString;
      Doc.Destinatario.Endereco.CodigoMunicipio := '';{ TODO : Rever }
      Doc.Destinatario.Endereco.CEP :=FieldByName('CEP').AsString;
      Doc.Destinatario.Endereco.NumPais := 1058;     { TODO : Rever }
      Doc.Destinatario.Endereco.NomePais := 'BRASIL'; { TODO : Rever }

      Free;
    end;
  end;
  if (DataSetNota.FindField('idfornecedor') <> nil) and
     (not DataSetNota.FieldByName('idfornecedor').IsNull) then
  begin
    with GetCds(tpERPFornecedor,'IDCliente = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idfornecedor').Value)) do
    begin
      Doc.Destinatario.Nome_RazaoSocial :=FieldByName('RAZAOSOCIAL').AsString;
      Doc.Destinatario.NomeFantasia :=FieldByName('FANTASIA').AsString;
      if FieldByName('CNPJ').AsString = '' then
        Doc.Destinatario.CPF_CNPJ :=FieldByName('CNPJ').AsString
      else
      begin
        Free;
        AvisaErro('O CPF/CNPJ do destinatário deve estar preenchido');
      end;


      Doc.Destinatario.Telefone :=FieldByName('TELEFONE').AsString;
      Doc.Destinatario.IE :='';
      Doc.Destinatario.IE_ST :='';
      Doc.Destinatario.SUFRAMA :='';
      Doc.Destinatario.IdentificacaoSUFRAMA := '';
      Doc.Destinatario.IM :='';
      Doc.Destinatario.Email := FieldByName('email').AsString;
      Doc.Destinatario.Endereco.Endereco :=FieldByName('LOGRADOURO').AsString;
      Doc.Destinatario.Endereco.NumeroEndereco :=FieldByName('NUMERO').AsString;
      Doc.Destinatario.Endereco.Complemento :=FieldByName('COMPLEMENTO').AsString;
      Doc.Destinatario.Endereco.Bairro :=FieldByName('BAIRRO').AsString;
      Doc.Destinatario.Endereco.Cidade :=FieldByName('CIDADE').AsString;
      Doc.Destinatario.Endereco.Estado :=FieldByName('UF').AsString;
      Doc.Destinatario.Endereco.CodigoMunicipio := '';{ TODO : Rever }
      Doc.Destinatario.Endereco.CEP :=FieldByName('CEP').AsString;
      Doc.Destinatario.Endereco.NumPais := 1058;     { TODO : Rever }
      Doc.Destinatario.Endereco.NomePais := 'BRASIL'; { TODO : Rever }

      Free;
    end;
  end;

  {$EndRegion}

  {$Region 'Cria Transportadora'}
  with GetCds(tpERPCliente,'IDCliente = '+TipoCampoChaveToStr(DataSetNota.FieldByName('IDCliente').Value)) do
    begin
      Doc.Emitente.Nome_RazaoSocial :=FieldByName('NOMECLIENTE').AsString;
      Doc.Emitente.NomeFantasia :=FieldByName('FANTASIA').AsString;
      if FieldByName('CNPJ').AsString = '' then
        Doc.Emitente.CPF_CNPJ :=FieldByName('CNPJ').AsString
     else
      begin
        Free;
        AvisaErro('O CPF/CNPJ da transportadora deve estar preenchido');
      end;


      Doc.Transportadora.Telefone :=FieldByName('TELEFONE').AsString;
      Doc.Transportadora.IE :=FieldByName('IE').AsString;
      Doc.Transportadora.IE_ST :='';
      Doc.Transportadora.SUFRAMA :='';
      Doc.Transportadora.IdentificacaoSUFRAMA := '';
      Doc.Transportadora.IM :='';
      Doc.Transportadora.Email := '';
      Doc.Transportadora.Endereco.Endereco :=FieldByName('LOGRADOURO').AsString;
      Doc.Transportadora.Endereco.NumeroEndereco :=FieldByName('NUMERO').AsString;
      Doc.Transportadora.Endereco.Complemento :=FieldByName('COMPLEMENTO').AsString;
      Doc.Transportadora.Endereco.Bairro :=FieldByName('BAIRRO').AsString;
      Doc.Transportadora.Endereco.Cidade :=FieldByName('CIDADE').AsString;
      Doc.Transportadora.Endereco.Estado :=FieldByName('UF').AsString;
      Doc.Transportadora.Endereco.CodigoMunicipio := '';{ TODO : Rever }
      Doc.Transportadora.Endereco.CEP :=FieldByName('CEP').AsString;
      Doc.Transportadora.Endereco.NumPais := 1058;     { TODO : Rever }
      Doc.Transportadora.Endereco.NomePais := 'BRASIL'; { TODO : Rever }

      Free;
    end;

  {$EndRegion}

  {$Region 'Corpo da nota '}
  Doc.EnderecoEntrega := Doc.Destinatario.Endereco;
  Doc.EnderecoCobranca := Doc.Destinatario.Endereco;


  Doc.Seguro := DataSetNota.FieldByName('VALORSEGURO').Value;
  Doc.Frete := DataSetNota.FieldByName('VALORFRETE').Value;
  Doc.OutrasDespesas := DataSetNota.FieldByName('VALOROUTRASDESPESAS').Value;
  Doc.TotalDocumento := DataSetNota.FieldByName('VALORTOTALNOTA').Value;

  case DataSetNota.FieldByName('TIPOTRANSPORTE').AsInteger of
    1: Doc.TipoTransporte := ttMaritima;
    2: Doc.TipoTransporte := ttFluvial;
    3: Doc.TipoTransporte := ttLacustre;
    4: Doc.TipoTransporte := ttAerea;
    5: Doc.TipoTransporte := ttPostal;
    6: Doc.TipoTransporte := ttFerroviaria;
    7: Doc.TipoTransporte := ttRodoviaria;
    8: Doc.TipoTransporte := ttConduto_Rede_Transmissao;
    9: Doc.TipoTransporte := ttMeios_Proprios;
   10: Doc.TipoTransporte := ttEntrada_Ou_Saida_ficta;
  end;

  if DataSetNota.FieldByName('FLAGMODALIDADEFRETE').Value  = 'D' then
    Doc.TipoFrete := tfDestinatario
  else
  if DataSetNota.FieldByName('FLAGMODALIDADEFRETE').Value  = 'E' then
    Doc.TipoFrete := tfEmitente
  else
    Doc.TipoFrete := tfTerceiros;

  Doc.Placa := DataSetNota.FieldByName('PLACAVEICULO').Value;
  Doc.UfPlaca := DataSetNota.FieldByName('UFPLACAVEICULO').Value;
  Doc.ANTT := '';
  Doc.Volume := DataSetNota.FieldByName('VOLUME').Value;
  Doc.Especie := DataSetNota.FieldByName('ESPECIE').Value;
  Doc.Marca := '';
  Doc.PesoBruto := DataSetNota.FieldByName('PESOBRUTO').Value;
  Doc.PesoLiquido := DataSetNota.FieldByName('PESOLIQ').Value;
  {$EndRegion}

  {$Region 'Itens'}
  DataSetItens.First;
  while not DataSetItens.Eof do
  begin
    Item := TItemDocumento.Create;
    Item.Codigo := DataSetItens.FieldByName('CODIGO_PRODUTO').AsString;
    Item.Unidade := DataSetItens.FieldByName('UNIDADE').Value;
    Item.Quantidade := DataSetItens.FieldByName('QUANTIDADE').Value;
    Item.ValorUnitario := DataSetItens.FieldByName('VALORUNITARIO').Value;
    Item.ValorDesconto := DataSetItens.FieldByName('VALORDESCONTO').Value;
    Item.ValorAcrescimo := DataSetItens.FieldByName('VALORACRESCIMO').Value;
    Item.AliqDesconto := DataSetItens.FieldByName('ALIQDESCONTO').Value;
    Item.AliqAcrescimo := DataSetItens.FieldByName('ALIQACRESCIMO').Value;
    Item.ValorFrete := DataSetItens.FieldByName('VALORFRETERATEADO').Value;
    Item.ValorSeguro := DataSetItens.FieldByName('VALORSEGURORATEADO').Value;
    Item.ValorOutrasDespesas := DataSetItens.FieldByName('VALOROUTRASDESPESASRATEADO').Value;
    Item.CFOP := DataSetItens.FieldByName('CFOP').Value;
    Item.CST := DataSetItens.FieldByName('CST').Value;
    Item.CSOSN := DataSetItens.FieldByName('CSOSN').Value;
    Item.CRT := DataSetItens.FieldByName('CRT').Value;

    Item.NumDI := '';
    Item.DataDI :=0;
    Item.LocalDesembaraco := '';
    Item.UFDesenbaraco:= '';
    Item.DataDesembaraco := 0;
    Item.TipoTransporte := Doc.TipoTransporte;
    Item.ValorAFRMM := 0;
    Item.TipoIntermedio := tiImportacao_por_conta_propria;
    Item.CNPJ_Adquerente := DataSetNota.FieldByName('CNPJ').AsString;
    Item.UF_Terceiro :='';
    Item.CodigoExportador := '';
    Item.NumAdicao := 0;
    Item.CodigoDoProdutoNoFabricante := '';

    Item.NumeroPedidoCompra:= '';
    Item.NumeroItemPedidoCompra := 0;

    Item.Impostos.AliqICMS := DataSetItens.FieldByName('ALIQICMS').Value;
    Item.Impostos.AliqISS := DataSetItens.FieldByName('ALIQISS').Value;
    Item.Impostos.AliqCOFINS := DataSetItens.FieldByName('ALIQCOFINS').Value;
    Item.Impostos.AliqPIS := DataSetItens.FieldByName('ALIQPIS').Value;
    Item.Impostos.AliqIPI := DataSetItens.FieldByName('ALIQIPI').Value;
    Item.Impostos.TipoIPI := iIPIAliq;
    Item.Impostos.MVA := DataSetItens.FieldByName('MVA').Value;
    Item.Impostos.AliqICMSST := DataSetItens.FieldByName('ALIQST').Value;
    Item.Impostos.ALiqCSLL := DataSetItens.FieldByName('ALIQCSLL').Value;
    if DataSetItens.FieldByName('BASEISS').AsCurrency >0  then
    begin
      Item.Impostos.BaseISS := DataSetItens.FieldByName('BASEISS').Value  ;
      Item.Impostos.ValorISS := DataSetItens.FieldByName('VALORISS').Value;
    end else
    begin
      Item.Impostos.BaseICMS := DataSetItens.FieldByName('BASEICMS').Value;
      Item.Impostos.ValorICMS := DataSetItens.FieldByName('VALORICMS').Value;
    end;

    Item.Impostos.BaseIPI := DataSetItens.FieldByName('BASEIPI').Value;
    Item.Impostos.BasePIS_COFINS := DataSetItens.FieldByName('BASEPISCOFINS').Value;
    Item.Impostos.BaseICMSST := DataSetItens.FieldByName('BASEICMSST').Value;
    Item.Impostos.BaseCSLL := DataSetItens.FieldByName('BASECSLL').Value;

    Item.Impostos.ValorIPI := DataSetItens.FieldByName('VALORIPI').Value;
    Item.Impostos.ValorPIS := DataSetItens.FieldByName('VALORPIS').Value;
    Item.Impostos.ValorCOFINS := DataSetItens.FieldByName('VALORCOFINS').Value;
    Item.Impostos.ValorICMSST := DataSetItens.FieldByName('VALORST').Value;
    Item.Impostos.ValorCSLL := DataSetItens.FieldByName('VALORCSLL').Value;

    if DataSetItens.FieldByName('TIPO_ITEM').AsString = 'S' then
      Doc.Servicos.Add(Item)
    else
      Doc.Produtos.Add(Item);

    DataSetItens.Next;
  end;
  {$EndRegion}

  DataSetCobranca.First;
  while not DataSetCobranca.Eof do
  begin
    Cob := TCobranca.Create;
    Cob.NumeroDocumento := '';
    Cob.Vencimento := 0;
    Cob.ValorDocumento := DataSetCobranca.FieldByName('VALOR').Value;

    DataSetCobranca.Next;
  end;




end;


end.

