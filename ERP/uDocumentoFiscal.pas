unit uDocumentoFiscal;

interface
    uses
       MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils, DateUtils, Generics.Collections,uClassesERP;
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
        procedure SetCodigoIBGEEstado(const Value: String);

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
        function GetCodigoIBGEEstado: String;

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
        property CodigoIBGEEstado : String read GetCodigoIBGEEstado write SetCodigoIBGEEstado;
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
        procedure SetAliqReducaoBaseICMS(const Value: Currency);

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
        function GetAliqReducaoBaseICMS: Currency;

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

        property AliqReducaoBaseICMS: Currency read GetAliqReducaoBaseICMS write SetAliqReducaoBaseICMS;

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
        procedure SetCodigoDeBeneficio(const Value: String);
        procedure SetDesciminacaoCodigoDeBeneficio(const Value: String);
        Procedure SetValorTotalLiquido(Const Value: Currency);

        function GetCodigoDeBeneficio: String;
        function GetDesciminacaoCodigoDeBeneficio: String;
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
        function GetDescricaoCodigoServico: String;

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

        Property ValorTotalLiquido: Currency read GetValorTotalLiquido write SetValorTotalLiquido;

        Property CFOP:String read GetCFOP write SetCFOP;
        Property CST: String read GetCST write SetCST;
        Property CSOSN: String read GetCSOSN write SetCSOSN;
        Property CRT: String read GetCRT write SetCRT;
        Property NCM: String read GetNCM ;
        Property CodigoMunicipalServico: String read GetCodigoMunicipalServico  ;
        Property CodigoFederalServico: String read GetCodigoFederalServico ;
        Property DescricaoCodigoServico: String read GetDescricaoCodigoServico;
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

        property CodigoDeBeneficio : String  read GetCodigoDeBeneficio write SetCodigoDeBeneficio;
        property DesciminacaoCodigoDeBeneficio : String  read GetDesciminacaoCodigoDeBeneficio write SetDesciminacaoCodigoDeBeneficio;

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

      IEmitente = interface(IPessoa)
        function GetRegimeTributacao: String;
        procedure SetRegimeTributacao(const Value: String);
        property RegimeTributacao: String read GetRegimeTributacao write SetRegimeTributacao;
      end;


      IDocumentoFiscal = Interface(IInterfaceMaster)
        procedure SetANTT(const Value: String);
        procedure SetCobranca(const Value: TList<ICobranca>);
        procedure SetDestinatario(const Value: IPessoa);
        procedure SetEmitente(const Value: IEmitente);
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
        procedure SetDataNota(const Value: TDate);
        procedure SetNumeroNota(const Value: String);
        Procedure SetSerieNota (Const Value: String);
        procedure SetTipoAmbiente(const Value: uClassesERP.TTipoAmbiente);
        procedure SetIdSaida(const Value:  TipoCampoChave);
        procedure SetIdEntrada(const Value: TipoCampoChave);
        procedure SetIdEmpresa(const Value: TipoCampoChave);
        Procedure SetTipoDocumento(const Value: TTipoDocumento);
        Procedure SetLoteSistema(const Value: String );
        Procedure SetProtocolo(const Value:  String);
        Procedure SetChaveAcesso(const Value: String);

        function GetANTT: String;
        function GetCobranca: TList<ICobranca>;
        function GetDestinatario: IPessoa;
        function GetEmitente: IEmitente;
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
        function GetDataNota: TDate;
        function GetNumeroNota: String;
        function GetSerieNota: String;
        function GetTipoAmbiente: uClassesERP.TTipoAmbiente;
        function GetIdSaida: TipoCampoChave;
        function GetIdEntrada: TipoCampoChave;
        function GetIdEmpresa: TipoCampoChave;
        function GetTipoDocumento: TTipoDocumento;
        Function GetLoteSistema : String;
        Function GetProtocolo :String ;
        Function GetChaveAcesso: String;

        property Emitente: IEmitente read GetEmitente write SetEmitente;
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

        property DataNota: TDate read GetDataNota write SetDataNota;
        property NumeroNota: String read GetNumeroNota write SetNumeroNota;
        property SerieNota:String  read GetSerieNota write SetSerieNota;




        property TipoAmbiente: uClassesERP.TTipoAmbiente read GetTipoAmbiente write SetTipoAmbiente;

        Property Cobranca: TList<ICobranca> read GetCobranca write SetCobranca;

        property IdSaida: TipoCampoChave read GetIdSaida write SetIdSaida;
        property IdEntrada: TipoCampoChave read GetIdEntrada write SetIdEntrada;
        property IdEmpresa: TipoCampoChave read GetIdEmpresa write SetIdEmpresa;
        property TipoDocumento: TTipoDocumento read GetTipoDocumento write SetTipoDocumento;
        property LoteSistema:String read GetLoteSistema write SetLoteSistema;
        property Protocolo: String read GetProtocolo write SetProtocolo;
        property ChaveAcesso: String read GetChaveAcesso write SetChaveAcesso;



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
        FAliqReducaoBaseICMS: Currency;

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
        Function GetAliqReducaoBaseICMS: Currency;
        procedure SetALiqIR(const Value: Currency);
        procedure SetBaseIR(const Value: Currency);
        procedure SetValorIR(const Value: Currency);
        Procedure SetAliqReducaoBaseICMS(const Value: Currency);

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

        property AliqReducaoBaseICMS: Currency read GetAliqReducaoBaseICMS write SetAliqReducaoBaseICMS;


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
        FCodigoIBGEEstado: String;
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
        procedure SetCodigoIBGEEstado(const Value: String);
        function GetCodigoIBGEEstado: String;

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
        property CodigoIBGEEstado : String read GetCodigoIBGEEstado write SetCodigoIBGEEstado;
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
        Constructor Create;
        destructor Destroy;
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

      TEmitente = class(TPessoa, iEmitente)
      private
        FRegimeTributacao: String;
        function GetRegimeTributacao: String;
        procedure SetRegimeTributacao(const Value: String);
      published
        property RegimeTributacao: String read GetRegimeTributacao write SetRegimeTributacao;
        constructor Create;
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
        FCRT: String;
        fCodigoDeBeneficio: String;
        fDesciminacaoCodigoDeBeneficio: String;
        fDescricaoCodigoServico: String;

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
        procedure SetCodigoDeBeneficio(const Value: String);
        procedure SetDesciminacaoCodigoDeBeneficio(const Value: String);

        function GetCodigoDeBeneficio: String;
        function GetDesciminacaoCodigoDeBeneficio: String;
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
        procedure SetImpostos(const Value: IImpostos);
        function GetCSOSN: String;
        procedure SetCSOSN(const Value: String);
        function GetCRT: String;
        procedure SetCRT(const Value: String);
        function GetDescricaoCodigoServico: String;

      published
        Constructor Create;
        destructor Destroy;
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
        Property DescricaoCodigoServico: String read GetDescricaoCodigoServico;
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

        property CodigoDeBeneficio : String  read GetCodigoDeBeneficio write SetCodigoDeBeneficio;
        property DesciminacaoCodigoDeBeneficio : String  read GetDesciminacaoCodigoDeBeneficio write SetDesciminacaoCodigoDeBeneficio;


        Property Impostos: IImpostos read GetImpostos write SetImpostos;


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
        FEmitente: IEmitente;
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
        FOpcoesDeVerificacao: TVerificacoes;
        FDataNota : TDate;
        FNumeroNota: String;
        FSerieNota: String;
        FTipoAmbiente: uClassesERP.TTipoAmbiente;
        fIdEntrada: TipoCampoChave;
        fIdSaida: TipoCampoChave;
        fTipoDocumento: TTipoDocumento;
        fChaveAcesso: String;
        fLoteSistema: String;
        fProtocolo: String;
        fIdEmpresa: TipoCampoChave;


        procedure SetANTT(const Value: String);
        procedure SetCobranca(const Value: TList<ICobranca>);
        procedure SetDestinatario(const Value: IPessoa);
        procedure SetEmitente(const Value: IEmitente);
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
        function GetEmitente: IEmitente;
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
        procedure SetVerificacoes(const Value: TVerificacoes);
        function GetDataNota: TDate;
        procedure SetDataNota(const Value: TDate);
        function GetNumeroNota: String;
        procedure SetNumeroNota(const Value: String);
        function GetSerieNota: String;
        procedure SetSerieNota(const Value: String);
        procedure SetTipoAmbiente(const Value: uClassesERP.TTipoAmbiente);
        function GetTipoAmbiente: uClassesERP.TTipoAmbiente;
        function GetIdEntrada: TipoCampoChave;
        function GetIdSaida: TipoCampoChave;
        function GetTipoDocumento: TTipoDocumento;
        procedure SetIdEntrada(const Value: TipoCampoChave);
        procedure SetIdSaida(const Value: TipoCampoChave);
        procedure SetTipoDocumento(const Value: TTipoDocumento);
        function GetChaveAcesso: String;
        function GetLoteSistema: String;
        function GetProtocolo: String;
        procedure SetChaveAcesso(const Value: String);
        procedure SetLoteSistema(const Value: String);
        procedure SetProtocolo(const Value: String);
        function GetIdEmpresa: TipoCampoChave;
        procedure SetIdEmpresa(const Value: TipoCampoChave);


      published
        property Emitente: IEmitente read GetEmitente write SetEmitente;
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

        property DataNota: TDate read GetDataNota write SetDataNota;
        property NumeroNota: String read GetNumeroNota write SetNumeroNota;
        property SerieNota:String  read GetSerieNota write SetSerieNota;



        property TipoAmbiente: uClassesERP.TTipoAmbiente read GetTipoAmbiente write SetTipoAmbiente;

        property IdSaida: TipoCampoChave read GetIdSaida write SetIdSaida;
        property IdEntrada: TipoCampoChave read GetIdEntrada write SetIdEntrada;
        property IdEmpresa: TipoCampoChave read GetIdEmpresa write SetIdEmpresa;
        property TipoDocumento: TTipoDocumento read GetTipoDocumento write SetTipoDocumento;
        property LoteSistema:String read GetLoteSistema write SetLoteSistema;
        property Protocolo: String read GetProtocolo write SetProtocolo;
        property ChaveAcesso: String read GetChaveAcesso write SetChaveAcesso;


        Property Cobranca: TList<ICobranca> read GetCobranca write SetCobranca;
        property OpcoesDeVerificacao: TVerificacoes read FOpcoesDeVerificacao write SetVerificacoes;
        Function VerificaDados: TStringList ;virtual;
        constructor Create;virtual;


      end;



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

function TImpostos.GetAliqReducaoBaseICMS: Currency;
begin
  Result := FAliqReducaoBaseICMS;
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

procedure TImpostos.SetAliqReducaoBaseICMS(const Value: Currency);
begin
  FAliqReducaoBaseICMS := Value;
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

function TEndereco.GetCodigoIBGEEstado: String;
begin
  Result := FCodigoIBGEEstado;
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

procedure TEndereco.SetCodigoIBGEEstado(const Value: String);
begin
  FCodigoIBGEEstado := Value;
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

constructor TPessoa.Create;
begin
   Self.Endereco := TEndereco.Create;
end;

destructor TPessoa.Destroy;
begin
  FreeAndNil(FEndereco);
end;

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

constructor TItemDocumento.Create;
begin
   Inherited;
   Self.Impostos := Timpostos.Create;
end;

destructor TItemDocumento.Destroy;
begin
  FreeAndNil(FImpostos);
end;

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
     with GetCds(tpERPProduto,'p.codigo = '+QuotedStr(Value)) do
     begin
       Self.FNome := FieldByName('NOMEPRODUTO').AsString;
       Self.FEAN13 := FieldByName('CODIGOBARRAS').AsString;
       Self.FNCM :=   SomenteNumero( FieldByName('NCM').AsString);
       Self.FIdProduto :=   FieldByName('IDPRODUTO').AsString;
       Self.FCodigoFederalServico := SomenteNumero(FieldByName('CODIGOSERVFEDERAL').AsString);
       Self.FCodigoMunicipalServico := SomenteNumero(FieldByName('CODIGOMUNICIPALSERVICO').AsString);
       Self.fDescricaoCodigoServico := FieldByName('DESCRICAOCODIGOSERVICO').AsString;
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
    PesoBruto:= 0;
    UfPlaca:= '';
    Especie:= '' ;
    FTotalProdutos:= 0;
    ANTT := '';
    Seguro:= 0;
    FTotalServicos:= 0;
    OutrasDespesas:= 0;
    TipoTransporte:= ttRodoviaria;
    PesoLiquido:= 0;
    Volume:= 1;
    TipoFrete:= tfDestinatario;
    Marca:= '';
    Placa:= '';
    Frete:= 0;
    TotalDocumento:= 0;
    OpcoesDeVerificacao := [tvCPF_CNPJ,tvIE,tvCEP,tvCFOP, tvUF];

    EnderecoCobranca:= TEndereco.Create;
    EnderecoEntrega:= TEndereco.Create;
    Transportadora:= TPessoa.Create;
    FTotalImpostos:= TImpostos.Create;
    Destinatario:= TPessoa.Create;
    Cobranca:= TList<ICobranca>.Create;
    Emitente:= TEmitente.Create;
    Servicos:= TList<IItemDocumento>.Create;
    Produtos:=  TList<IItemDocumento>.Create;


end;


function TDocumentoFiscal.GetANTT: String;
begin
  Result := FANTT;
end;

function TDocumentoFiscal.GetChaveAcesso: String;
begin
  Result := fChaveAcesso;
end;

function TDocumentoFiscal.GetCobranca: TList<ICobranca>;
begin
  Result := FCobranca;
end;

function TDocumentoFiscal.GetDataNota: TDate;
begin
  Result := FDataNota;
end;


function TDocumentoFiscal.GetDestinatario: IPessoa;
begin
  Result := FDestinatario;
end;

function TDocumentoFiscal.GetEmitente: IEmitente;
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
function TDocumentoFiscal.GetIdEmpresa: TipoCampoChave;
begin
  Result := fIdEmpresa;
end;

function TDocumentoFiscal.GetIdEntrada: TipoCampoChave;
begin
  Result := fIdEntrada;
end;

function TDocumentoFiscal.GetIdSaida: TipoCampoChave;
begin
  Result := fIdSaida;
end;

function TDocumentoFiscal.GetLoteSistema: String;
begin
  Result := fLoteSistema;
end;

function TDocumentoFiscal.GetMarca: String;
begin
  Result := FMarca;
end;

function TDocumentoFiscal.GetNumeroNota: String;
begin
   Result := FNumeroNota;
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


function TDocumentoFiscal.GetProtocolo: String;
begin
  Result := fProtocolo;
end;

function TDocumentoFiscal.GetSeguro: Currency;
begin
  Result := FSeguro;
end;

function TDocumentoFiscal.GetSerieNota: String;
begin
   Result := FSerieNota ;
end;

function TDocumentoFiscal.GetServicos: TList<IItemDocumento>;
begin
  Result := FServicos;
end;

function TDocumentoFiscal.GetTipoAmbiente: uClassesERP.TTipoAmbiente;
begin
  Result := FTipoAmbiente;
end;

function TDocumentoFiscal.GetTipoDocumento: TTipoDocumento;
begin
  Result := fTipoDocumento;
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
    FTotalImpostos.ValorISS := FTotalImpostos.ValorISS + Servicos[i].Impostos.ValorISS;
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
  FTotalServicos:= 0 ;
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

procedure TDocumentoFiscal.SetChaveAcesso(const Value: String);
begin
  fChaveAcesso := Value;
end;

procedure TDocumentoFiscal.SetCobranca(const Value: TList<ICobranca>);
begin
  FCobranca := Value;
end;


procedure TDocumentoFiscal.SetDataNota(const Value: TDate);
begin
  FDataNota := Value;
end;


procedure TDocumentoFiscal.SetDestinatario(const Value: IPessoa);
begin
  FDestinatario := Value;
end;

procedure TDocumentoFiscal.SetEmitente(const Value: IEmitente);
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

procedure TDocumentoFiscal.SetIdEmpresa(const Value: TipoCampoChave);
begin
   fIdEmpresa := Value;
end;

procedure TDocumentoFiscal.SetIdEntrada(const Value: TipoCampoChave);
begin
  fIdEntrada := Value;
end;

procedure TDocumentoFiscal.SetIdSaida(const Value: TipoCampoChave);
begin
  fIdSaida := Value;
end;

procedure TDocumentoFiscal.SetLoteSistema(const Value: String);
begin
   fLoteSistema := Value;
end;

procedure TDocumentoFiscal.SetMarca(const Value: String);
begin
  FMarca := Value;
end;

procedure TDocumentoFiscal.SetNumeroNota(const Value: String);
begin
   FNumeroNota := Value;
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


procedure TDocumentoFiscal.SetProtocolo(const Value: String);
begin
   fProtocolo := Value;
end;

procedure TDocumentoFiscal.SetSeguro(const Value: Currency);
begin
  FSeguro := Value;
end;

procedure TDocumentoFiscal.SetSerieNota(const Value: String);
begin
  FSerieNota := Value;
end;

procedure TDocumentoFiscal.SetServicos(const Value: TList<IItemDocumento>);
begin
  FServicos := Value;
end;

procedure TDocumentoFiscal.SetTipoAmbiente(const Value: uClassesERP.TTipoAmbiente);
begin
  FTipoAmbiente := Value;
end;

procedure TDocumentoFiscal.SetTipoDocumento(const Value: TTipoDocumento);
begin
  fTipoDocumento := Value;
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

procedure TDocumentoFiscal.SetVerificacoes(const Value: TVerificacoes);
begin
  FOpcoesDeVerificacao := Value;
end;

procedure TDocumentoFiscal.SetVolume(const Value: Integer);
begin
  FVolume := Value;
end;


Function TDocumentoFiscal.VerificaDados: TStringList;
var
  I: Integer;
begin
   Result := TStringList.Create;

   if tvCPF_CNPJ in FOpcoesDeVerificacao then
   begin
     {$Region 'Emitente'}
     if Trim(Self.Emitente.CPF_CNPJ) = '' then
       Result.Add('CPF/CNPJ do emitente não informado')
     else
     if Length(Self.Emitente.CPF_CNPJ) = 11 then //CPF
     begin
       if not Verifica_CPF(Self.Emitente.CPF_CNPJ) then
         Result.Add('CPF do emitente inválido')
     end else //CNPJ
     if not Verifica_CNPJ(Self.Emitente.CPF_CNPJ) then
       Result.Add('CNPJ do emitente inválido');
     {$EndRegion}


     {$Region 'Destinatario'}
     if Trim(Self.Destinatario.CPF_CNPJ) = '' then
       Result.Add('CPF/CNPJ do destinatário não informado')
     else
     if Length(Self.Destinatario.CPF_CNPJ) = 11 then //CPF
     begin
       if not Verifica_CPF(Self.Destinatario.CPF_CNPJ) then
         Result.Add('CPF do destinatário inválido')
     end else //CNPJ
     if not Verifica_CNPJ(Self.Destinatario.CPF_CNPJ) then
       Result.Add('CNPJ do destinatário inválido');
     {$EndRegion}

     {$Region 'Transportadora'}
     if Self.Transportadora.Nome_RazaoSocial<> '' then
     begin
       if Trim(Self.Transportadora.CPF_CNPJ) = '' then
         Result.Add('CPF/CNPJ do transportadora não informado')
       else
       if Length(Self.Transportadora.CPF_CNPJ) = 11 then //CPF
       begin
         if not Verifica_CPF(Self.Transportadora.CPF_CNPJ) then
           Result.Add('CPF do transportadora inválido')
       end else //CNPJ
       if not Verifica_CNPJ(Self.Transportadora.CPF_CNPJ) then
         Result.Add('CNPJ do transportadora inválido');
     end;
     {$EndRegion}

   end;

    if tvUF in FOpcoesDeVerificacao then
   begin
      {$Region 'Emitente'}
     if GetTableCount('VW_UF','*','UF = '+QuotedStr(Self.Emitente.Endereco.Estado)) = 0 then
       Result.Add('UF do emitente inválido');
     {$EndRegion}

     {$Region 'Destinatario'}
     if GetTableCount('VW_UF','*','UF = '+QuotedStr(Self.Destinatario.Endereco.Estado)) = 0 then
       Result.Add('UF do destinatário inválido');
     {$EndRegion}

     {$Region 'Transportadora'}
     if Self.Transportadora.Nome_RazaoSocial<> '' then
     begin
       if GetTableCount('VW_UF','*','UF = '+QuotedStr(Self.Transportadora.Endereco.Estado)) = 0 then
         Result.Add('UF do transportadora inválido');
     end;
     {$EndRegion}


   end;


   if tvIE in FOpcoesDeVerificacao then
   begin
     {$Region 'Emitente'}
     if not Verifica_Inscricao_Estadual(Self.Emitente.IE, Self.Emitente.Endereco.Estado) then
       Result.Add('Inscrição Estadual do emitente inválido');
     {$EndRegion}


     {$Region 'Destinatario'}
     if not Verifica_Inscricao_Estadual(Self.Destinatario.IE, Self.Destinatario.Endereco.Estado) then
       Result.Add('Inscrição Estadual  do destinatário inválido');
     {$EndRegion}

     {$Region 'Transportadora'}
     if Self.Transportadora.Nome_RazaoSocial<> '' then
     begin
       if not Verifica_Inscricao_Estadual(Self.Transportadora.IE, Self.Transportadora.Endereco.Estado) then
         Result.Add('Inscrição Estadual do transportadora inválido');
     end;
     {$EndRegion}

   end;

   if tvCEP in FOpcoesDeVerificacao then
   begin
      {$Region 'Emitente'}
     if not Verifica_CEP(Self.Emitente.Endereco.CEP, Self.Emitente.Endereco.Estado) then
       Result.Add('CEP do emitente inválido');
     {$EndRegion}

     {$Region 'Destinatario'}
     if not Verifica_CEP(Self.Destinatario.Endereco.CEP, Self.Destinatario.Endereco.Estado) then
       Result.Add('CEP do destinatário inválido');
     {$EndRegion}

     {$Region 'Transportadora'}
     if Self.Transportadora.Nome_RazaoSocial<> '' then
     begin
       if not Verifica_CEP(Self.Transportadora.Endereco.CEP,  Self.Transportadora.Endereco.Estado) then
         Result.Add('CEP do transportadora inválido');
     end;
     {$EndRegion}


   end;

   if tvIBGE in FOpcoesDeVerificacao then
   begin
     {$Region 'Emitente'}
     if Self.Emitente.Endereco.CodigoMunicipio = '' then
       Result.Add('Código do município do emitente não preenchido. Informe esse código no cadastro de CEP');
     {$EndRegion}

     {$Region 'Destinatario'}
     if Self.Destinatario.Endereco.CodigoMunicipio = '' then
       Result.Add('Código do município do destinatario não preenchido. Informe esse código no cadastro de CEP');
     {$EndRegion}

   end;


   if tvCFOP in FOpcoesDeVerificacao then
   begin
      for I := 0 to Self.Produtos.Count -1 do
      begin
        if Self.Destinatario.Endereco.Estado = 'EX' then
        begin
           if not (Self.Produtos.Items[i].CFOP[1] in ['3','7']) then
             Result.Add('O CFOP['+Self.Produtos.Items[i].CFOP+'] do item '+FormatFloat('00',I)+' é inválido pra operações de comércio exterior. ' );
        end else
        if Self.Emitente.Endereco.Estado <> Self.Destinatario.Endereco.Estado then
        begin
           if not (Self.Produtos.Items[i].CFOP[1] in ['2','3','6','7']) then
             Result.Add('O CFOP['+Self.Produtos.Items[i].CFOP+'] do item '+FormatFloat('00',I)+' é inválido pra operações fora do seu estado. Estado do emitente: '+Self.Emitente.Endereco.Estado+
                        ' Estado do destinatário: '+Self.Destinatario.Endereco.Estado );
        end else
        if Self.Emitente.Endereco.Estado = Self.Destinatario.Endereco.Estado then
        begin
           if  (Self.Produtos.Items[i].CFOP[1] in ['2','3','6','7']) then
             Result.Add('O CFOP['+Self.Produtos.Items[i].CFOP+'] do item '+FormatFloat('00',I)+' é inválido pra operações no seu estado.' );
        end ;

      end;

   end;



end;


{ TEmitente }

constructor TEmitente.Create;
begin
  inherited;
  //Self.Endereco := TEndereco.Create;
end;

function TEmitente.GetRegimeTributacao: String;
begin
  Result := FRegimeTributacao;
end;

procedure TEmitente.SetRegimeTributacao(const Value: String);
begin
  FRegimeTributacao :=Value;
end;

{ TServico }

function TItemDocumento.GetCodigoDeBeneficio: String;
begin
  Result := fCodigoDeBeneficio;
end;

function TItemDocumento.GetDesciminacaoCodigoDeBeneficio: String;
begin
  Result := fDesciminacaoCodigoDeBeneficio;
end;

function TItemDocumento.GetDescricaoCodigoServico: String;
begin
  Result := fDescricaoCodigoServico;
end;

procedure TItemDocumento.SetCodigoDeBeneficio(const Value: String);
begin
  fCodigoDeBeneficio := Value;
end;

procedure TItemDocumento.SetDesciminacaoCodigoDeBeneficio(const Value: String);
begin
  fDesciminacaoCodigoDeBeneficio := Value;
end;

end.

