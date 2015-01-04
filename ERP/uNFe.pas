unit uNFe;

interface
    uses
       MinhasClasses, Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,DateUtils, Generics.Collections,uDocumentoFiscal,ACBrNFe,
       ACBrNFeDANFEClass, uConstantes,pcnConversao,
       uClassesERP;
   type
     TNFe = class
     Private
       FDocs: TList<IDocumentoFiscal>;
       NFe: TACBrNFe;
       fLote: String;
       FProtocolo: String;
       FCaminhoNFe: String;
       FCaminhoXml: String;
       FCaminhoLogs: String;
       FCaminhoNaoEnviado: String;
       FCaminhoRespostasWS: String;
       FCaminhoPDF: String;
       FCaminhoNotas: String;
       FCaminhoCanceladas: String;
       FCaminhoDPEC: String;
       FCaminhoInutilizadas: String;

       Function GeraArquivo: TRetorno;
       function GetLote: String;
       Function ConsultaSituacao: Boolean;
       function GetProtocolo: String;
       function GetCodigoVerificacao: String;
       procedure SetLote(const Value: String);
       function GetCaminhoLogs: String;
       function GetCaminhoNaoEnviado: String;
       function GetCaminhoNFe: String;
       function GetCaminhoPastaCidade: String;
       function GetCaminhoPDF: String;
       function GetCaminhoRespostasWS: String;
       function GetCaminhoRPS: String;
       function GetCaminhoXml: String;
       Function VerificaStatus: TRetorno;
     public
       constructor Create(Const Docs: TList<IDocumentoFiscal>; pLote: String; TipoEmissaoNFE: TTipoEmissaoNFE= tenfeNormal );
       destructor Destroy;
       property Lote: String read GetLote write SetLote;
       property Protocolo: String read GetProtocolo;
       Function Enviar: TRetorno;
       procedure Imprimir(Protocolo: String);
       property CaminhoNFe: String read GetCaminhoNFe;
       property CaminhoXml: String read GetCaminhoXml;
       property CaminhoLogs: String read GetCaminhoLogs;
       property CaminhoNaoEnviado: String read GetCaminhoNaoEnviado;
       property CaminhoRespostasWS: String read GetCaminhoRespostasWS;
       property CaminhoPDF: String read GetCaminhoPDF;
       procedure SalvaLogoEmpresa(CampoImg: TField);
     end;
implementation

{ TNFe }

function TNFe.ConsultaSituacao: Boolean;
begin

end;

constructor TNFe.Create(const Docs: TList<IDocumentoFiscal>; pLote: String; TipoEmissaoNFE: TTipoEmissaoNFE= tenfeNormal);
begin
  FDocs:= Docs;
  NFe := TACBrNFe.Create(nil);
  FCaminhoNFe := ExtractFilePath(ParamStr(0))+'NFe';
  FCaminhoNotas := FCaminhoNFe+'\Notas\'+FormatDateTime('yyyy-mm',Now)+'\'+FLote;
  FCaminhoXml :=  FCaminhoNotas+'\XML\';
  FCaminhoNaoEnviado := FCaminhoNotas+'\Saida\';
  FCaminhoLogs := FCaminhoNotas+'\Log\';
  FCaminhoRespostasWS := FCaminhoNotas+'\RespostasWS\';
  FCaminhoPDF := FCaminhoNotas+'\PDF\';
  FCaminhoCanceladas := FCaminhoXml;
  FCaminhoDPEC := FCaminhoNotas+'\DPEC\';
  FCaminhoInutilizadas := FCaminhoXml;

  NFe.Configuracoes.Geral.PathSchemas := FCaminhoNFe+'\Schemas\';
  Nfe.Configuracoes.Geral.AtualizarXMLCancelado := True;
  Nfe.Configuracoes.Geral.ExibirErroSchema      := True;
  Nfe.Configuracoes.Geral.FormaEmissao          := TpcnTipoEmissao( TTipoEmissaoNFE(TipoEmissaoNFE) );
  Nfe.Configuracoes.Geral.ModeloDF              := moNFe;
  Nfe.Configuracoes.Geral.VersaoDF              := ve310;
//  Nfe.Configuracoes.Geral.IdToken      := edtIdToken.Text;
//  Nfe.Configuracoes.Geral.Token        := edtToken.Text;
  Nfe.Configuracoes.Geral.Salvar       := True;
  Nfe.Configuracoes.Geral.PathSalvar   := FCaminhoXml;

  Nfe.Configuracoes.WebServices.UF := FDocs[0].Emitente.Endereco.Estado;
  if FDocs[0].TipoAmbiente = tabProducao then
    Nfe.Configuracoes.WebServices.Ambiente := taProducao
  else
    Nfe.Configuracoes.WebServices.Ambiente := taHomologacao;

  Nfe.Configuracoes.WebServices.AguardarConsultaRet := 0;
  Nfe.Configuracoes.WebServices.Tentativas := 5;
  Nfe.Configuracoes.WebServices.IntervaloTentativas := 0;


  Nfe.Configuracoes.Arquivos.PathNFe := FCaminhoXml;
  Nfe.Configuracoes.Arquivos.PathCan := FCaminhoCanceladas;
  Nfe.Configuracoes.Arquivos.PathInu := FCaminhoInutilizadas;
  Nfe.Configuracoes.Arquivos.PathDPEC := FCaminhoDPEC;
  Nfe.Configuracoes.Arquivos.PathEvento := FCaminhoXml;


end;

destructor TNFe.Destroy;
begin

end;

function TNFe.Enviar: TRetorno;
begin

end;

function TNFe.GeraArquivo: TRetorno;
var
  I,P: Integer;
begin
  Result := VerificaStatus;
  if Result.Erro then
     Exit;
  Nfe.NotasFiscais.Clear;

  for I := 0 to Fdocs.Count - 1 do
  begin
    {$Region 'Cria a nota'}
     with NFe.NotasFiscais.Add.NFe do
     begin
       Ide.cNF       := StrToInt(FDocs[i].NumeroNota); //Caso não seja preenchido será gerado um número aleatório pelo componente
       Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.'; { TODO : Fazer }
       Ide.indPag    := ipVista; { TODO : Fazer }
       Ide.modelo    := 55;
       Ide.serie     := StrToInt(FDocs[i].SerieNota);
       Ide.nNF       := StrToInt(FDocs[i].NumeroNota);
       Ide.dEmi      := FDocs[i].DataNota;
       Ide.dSaiEnt   := FDocs[i].DataNota;
       Ide.hSaiEnt   := Now;
       Ide.tpNF      := tnSaida; { TODO : Rever }
       Ide.tpEmis    := Nfe.Configuracoes.Geral.FormaEmissao;
       Ide.tpAmb     := Nfe.Configuracoes.WebServices.Ambiente;
       Ide.verProc   := GetVersaoAplicativo;
       Ide.cUF       := STrToInt(FDocs[i].Emitente.Endereco.CodigoIBGEEstado);
       Ide.cMunFG    := StrToInt(FDocs[i].Emitente.Endereco.CodigoMunicipio);
       Ide.finNFe    := fnNormal;
  //     Ide.dhCont := date;
  //     Ide.xJust  := 'Justificativa Contingencia';

  //Para NFe referenciada use os campos abaixo
  {     with Ide.NFref.Add do
        begin
          refNFe       := ''; //NFe Eletronica

          RefNF.cUF    := 0;  // |
          RefNF.AAMM   := ''; // |
          RefNF.CNPJ   := ''; // |
          RefNF.modelo := 1;  // |- NFe Modelo 1/1A
          RefNF.serie  := 1;  // |
          RefNF.nNF    := 0;  // |

          RefNFP.cUF     := 0;  // |
          RefNFP.AAMM    := ''; // |
          RefNFP.CNPJCPF := ''; // |
          RefNFP.IE      := ''; // |- NF produtor Rural
          RefNFP.modelo  := ''; // |
          RefNFP.serie   := 1;  // |
          RefNFP.nNF     := 0;  // |

          RefECF.modelo  := ECFModRef2B; // |
          RefECF.nECF    := '';          // |- Cupom Fiscal
          RefECF.nCOO    := '';          // |
        end;
  }
        Emit.CNPJCPF           := FDocs[i].Emitente.CPF_CNPJ;
        Emit.IE                := FDocs[i].Emitente.IE;
        Emit.xNome             := FDocs[i].Emitente.Nome_RazaoSocial;
        Emit.xFant             := FDocs[i].Emitente.NomeFantasia;

        Emit.EnderEmit.fone    := FDocs[i].Emitente.Telefone;
        Emit.EnderEmit.CEP     := StrToInt(FDocs[i].Emitente.Endereco.CEP);
        Emit.EnderEmit.xLgr    := FDocs[i].Emitente.Endereco.Endereco;
        Emit.EnderEmit.nro     := FDocs[i].Emitente.Endereco.NumeroEndereco;
        Emit.EnderEmit.xCpl    := FDocs[i].Emitente.Endereco.Complemento;
        Emit.EnderEmit.xBairro := FDocs[i].Emitente.Endereco.Bairro;
        Emit.EnderEmit.cMun    := StrToInt(FDocs[i].Emitente.Endereco.CodigoMunicipio);
        Emit.EnderEmit.xMun    := FDocs[i].Emitente.Endereco.Cidade;
        Emit.EnderEmit.UF      := FDocs[i].Emitente.Endereco.Estado;
        Emit.enderEmit.cPais   := 1058;
        Emit.enderEmit.xPais   := 'BRASIL';

        Emit.IEST              := FDocs[i].Emitente.IE_ST;
        Emit.IM                := FDocs[i].Emitente.IM;
        Emit.CNAE              := FDocs[i].Emitente.CNAE;
                                      // a inclusão de serviços na NFe
        Emit.CRT               := TpcnCRT(StrToInt(FDocs[i].Emitente.CRT));// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)

  //Para NFe Avulsa preencha os campos abaixo
  {      Avulsa.CNPJ    := '';
        Avulsa.xOrgao  := '';
        Avulsa.matr    := '';
        Avulsa.xAgente := '';
        Avulsa.fone    := '';
        Avulsa.UF      := '';
        Avulsa.nDAR    := '';
        Avulsa.dEmi    := now;
        Avulsa.vDAR    := 0;
        Avulsa.repEmi  := '';
        Avulsa.dPag    := now;             }

        Dest.CNPJCPF           := FDocs[i].Destinatario.CPF_CNPJ;
        Dest.IE                := FDocs[i].Destinatario.IE;
        Dest.ISUF              := FDocs[i].Destinatario.IdentificacaoSUFRAMA;
        Dest.xNome             := FDocs[i].Destinatario.Nome_RazaoSocial;

        Dest.EnderDest.Fone    := FDocs[i].Destinatario.Telefone;
        Dest.EnderDest.CEP     := StrToInt(FDocs[i].Destinatario.Endereco.CEP);
        Dest.EnderDest.xLgr    := FDocs[i].Destinatario.Endereco.Endereco;
        Dest.EnderDest.nro     := FDocs[i].Destinatario.Endereco.NumeroEndereco;
        Dest.EnderDest.xCpl    := FDocs[i].Destinatario.Endereco.Complemento;
        Dest.EnderDest.xBairro := FDocs[i].Destinatario.Endereco.Bairro;
        Dest.EnderDest.cMun    := StrToInt(FDocs[i].Destinatario.Endereco.CodigoMunicipio);
        Dest.EnderDest.xMun    := FDocs[i].Destinatario.Endereco.Cidade;
        Dest.EnderDest.UF      := FDocs[i].Destinatario.Endereco.Estado;
        Dest.EnderDest.cPais   := FDocs[i].Destinatario.Endereco.NumPais;
        Dest.EnderDest.xPais   := FDocs[i].Destinatario.Endereco.NomePais;


  //Use os campos abaixo para informar o endereço de retirada quando for diferente do Remetente/Destinatário
    {    Retirada.CNPJCPF := FDocs[i].Destinatario.CPF_CNPJ;
        Retirada.xLgr    := FDocs[i].EnderecoEntrega.Endereco;
        Retirada.nro     := FDocs[i].EnderecoEntrega.NumeroEndereco;
        Retirada.xCpl    := FDocs[i].EnderecoEntrega.Complemento;
        Retirada.xBairro := FDocs[i].EnderecoEntrega.Bairro;
        Retirada.cMun    := IntToStr(FDocs[i].EnderecoEntrega.CodigoMunicipio);
        Retirada.xMun    := FDocs[i].EnderecoEntrega.Cidade;
        Retirada.UF      := FDocs[i].EnderecoEntrega.Estado;  }

  //Use os campos abaixo para informar o endereço de entrega quando for diferente do Remetente/Destinatário
        Entrega.CNPJCPF := FDocs[i].Destinatario.CPF_CNPJ;
        Entrega.xLgr    := FDocs[i].EnderecoEntrega.Endereco;
        Entrega.nro     := FDocs[i].EnderecoEntrega.NumeroEndereco;
        Entrega.xCpl    := FDocs[i].EnderecoEntrega.Complemento;
        Entrega.xBairro := FDocs[i].EnderecoEntrega.Bairro;
        Entrega.cMun    := StrToInt(FDocs[i].EnderecoEntrega.CodigoMunicipio);
        Entrega.xMun    := FDocs[i].EnderecoEntrega.Cidade;
        Entrega.UF      := FDocs[i].EnderecoEntrega.Estado;

  //Adicionando Produtos
        for P := 0 to FDocs[i].Produtos.Count - 1 do
        begin
          with Det.Add do
           begin
             Prod.nItem    := 1; // Número sequencial, para cada item deve ser incrementado
             Prod.cProd    := '123456';
             Prod.cEAN     := '7896523206646';
             Prod.xProd    := 'TESTE DE PRODUTO';
             Prod.NCM      := '94051010'; // Tabela NCM disponível em  http://www.receita.fazenda.gov.br/Aliquotas/DownloadArqTIPI.htm
             Prod.EXTIPI   := '';
             Prod.CFOP     := '5101';
             Prod.uCom     := 'UN';
             Prod.qCom     := 1 ;
             Prod.vUnCom   := 100;
             Prod.vProd    := 100 ;

             Prod.cEANTrib  := '7896523206646';
             Prod.uTrib     := 'UN';
             Prod.qTrib     := 1;
             Prod.vUnTrib   := 100;

             Prod.vOutro    := 0;
             Prod.vFrete    := 0;
             Prod.vSeg      := 0;
             Prod.vDesc     := 0;

             infAdProd      := 'Informacao Adicional do Produto';

    //Declaração de Importação. Pode ser adicionada várias através do comando Prod.DI.Add
    {         with Prod.DI.Add do
              begin
                nDi         := '';
                dDi         := now;
                xLocDesemb  := '';
                UFDesemb    := '';
                dDesemb     := now;
                cExportador := '';

                with adi.Add do
                 begin
                   nAdicao     := 1;
                   nSeqAdi     := 1;
                   cFabricante := '';
                   vDescDI     := 0;
                 end;
              end;
    }
    //Campos para venda de veículos novos
    {         with Prod.veicProd do
              begin
                tpOP    := toVendaConcessionaria;
                chassi  := '';
                cCor    := '';
                xCor    := '';
                pot     := '';
                Cilin   := '';
                pesoL   := '';
                pesoB   := '';
                nSerie  := '';
                tpComb  := '';
                nMotor  := '';
                CMT     := '';
                dist    := '';
                RENAVAM := '';
                anoMod  := 0;
                anoFab  := 0;
                tpPint  := '';
                tpVeic  := 0;
                espVeic := 0;
                VIN     := '';
                condVeic := cvAcabado;
                cMod    := '';
              end;
    }
    //Campos específicos para venda de medicamentos
    {         with Prod.med.Add do
              begin
                nLote := '';
                qLote := 0 ;
                dFab  := now ;
                dVal  := now ;
                vPMC  := 0 ;
              end;  }
    //Campos específicos para venda de armamento
    {         with Prod.arma.Add do
              begin
                nSerie := 0;
                tpArma := taUsoPermitido ;
                nCano  := 0 ;
                descr  := '' ;
              end;      }
    //Campos específicos para venda de combustível(distribuidoras)
    {         with Prod.comb do
              begin
                cProdANP := 0;
                CODIF    := '';
                qTemp    := 0;
                UFcons   := '';

                CIDE.qBCprod   := 0 ;
                CIDE.vAliqProd := 0 ;
                CIDE.vCIDE     := 0 ;

                ICMS.vBCICMS   := 0 ;
                ICMS.vICMS     := 0 ;
                ICMS.vBCICMSST := 0 ;
                ICMS.vICMSST   := 0 ;

                ICMSInter.vBCICMSSTDest := 0 ;
                ICMSInter.vICMSSTDest   := 0 ;

                ICMSCons.vBCICMSSTCons := 0 ;
                ICMSCons.vICMSSTCons   := 0 ;
                ICMSCons.UFcons        := '' ;
              end;}

             with Imposto do
              begin
                // lei da transparencia nos impostos
                vTotTrib := 0;

                with ICMS do
                 begin
                   CST          := cst00;
                   ICMS.orig    := oeNacional;
                   ICMS.modBC   := dbiValorOperacao;
                   ICMS.vBC     := 100;
                   ICMS.pICMS   := 18;
                   ICMS.vICMS   := 18;
                   ICMS.modBCST := dbisMargemValorAgregado;
                   ICMS.pMVAST  := 0;
                   ICMS.pRedBCST:= 0;
                   ICMS.vBCST   := 0;
                   ICMS.pICMSST := 0;
                   ICMS.vICMSST := 0;
                   ICMS.pRedBC  := 0;
                 end;

        {        with IPI do
                 begin
                   CST      := ipi99 ;
                   clEnq    := '999';
                   CNPJProd := '';
                   cSelo    := '';
                   qSelo    := 0;
                   cEnq     := '';

                   vBC    := 100;
                   qUnid  := 0;
                   vUnid  := 0;
                   pIPI   := 5;
                   vIPI   := 5;
                 end;    }
    {
                with II do
                 begin
                   vBc      := 0;
                   vDespAdu := 0;
                   vII      := 0;
                   vIOF     := 0;
                 end;

                with PIS do
                 begin
                   CST      := pis99;
                   PIS.vBC  := 0;
                   PIS.pPIS := 0;
                   PIS.vPIS := 0;

                   PIS.qBCProd   := 0;
                   PIS.vAliqProd := 0;
                   PIS.vPIS      := 0;
                 end;

                with PISST do
                 begin
                   vBc       := 0;
                   pPis      := 0;
                   qBCProd   := 0;
                   vAliqProd := 0;
                   vPIS      := 0;
                 end;

                with COFINS do
                 begin
                   CST            := cof99;
                   COFINS.vBC     := 0;
                   COFINS.pCOFINS := 0;
                   COFINS.vCOFINS := 0;

                   COFINS.qBCProd   := 0;
                   COFINS.vAliqProd := 0;
                 end;

                with COFINSST do
                 begin
                   vBC       := 0;
                   pCOFINS   := 0;
                   qBCProd   := 0;
                   vAliqProd := 0;
                   vCOFINS   := 0;
                 end;
    }
    //Grupo para serviços
    {            with ISSQN do
                 begin
                   vBC       := 0;
                   vAliq     := 0;
                   vISSQN    := 0;
                   cMunFG    := 0;
                   cListServ := 1402; // Preencha este campo usando a tabela disponível
                                   // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
                 end;}
             end;
           end ;
        end;
   {
  //Adicionando Serviços
        with Det.Add do
         begin
           Prod.nItem    := 1; // Número sequencial, para cada item deve ser incrementado
           Prod.cProd    := '123457';
           Prod.cEAN     := '';
           Prod.xProd    := 'Descrição do Serviço';
           Prod.NCM      := '99';
           Prod.EXTIPI   := '';
           Prod.CFOP     := '5933';
           Prod.uCom     := 'UN';
           Prod.qCom     := 1 ;
           Prod.vUnCom   := 100;
           Prod.vProd    := 100 ;

           Prod.cEANTrib  := '';
           Prod.uTrib     := 'UN';
           Prod.qTrib     := 1;
           Prod.vUnTrib   := 100;

           Prod.vFrete    := 0;
           Prod.vSeg      := 0;
           Prod.vDesc     := 0;

           infAdProd      := 'Informação Adicional do Serviço';

  //Grupo para serviços
              with Imposto.ISSQN do
               begin
                 cSitTrib  := ISSQNcSitTribNORMAL;
                 vBC       := 100;
                 vAliq     := 2;
                 vISSQN    := 2;
                 cMunFG    := 3554003;
                 cListServ := '1402'; // Preencha este campo usando a tabela disponível
                                 // em http://www.planalto.gov.br/Ccivil_03/LEIS/LCP/Lcp116.htm
               end;
         end ;       }

        Total.ICMSTot.vBC     := 100;
        Total.ICMSTot.vICMS   := 18;
        Total.ICMSTot.vBCST   := 0;
        Total.ICMSTot.vST     := 0;
        Total.ICMSTot.vProd   := 100;
        Total.ICMSTot.vFrete  := 0;
        Total.ICMSTot.vSeg    := 0;
        Total.ICMSTot.vDesc   := 0;
        Total.ICMSTot.vII     := 0;
        Total.ICMSTot.vIPI    := 0;
        Total.ICMSTot.vPIS    := 0;
        Total.ICMSTot.vCOFINS := 0;
        Total.ICMSTot.vOutro  := 0;
        Total.ICMSTot.vNF     := 100;

        // lei da transparencia de impostos
        Total.ICMSTot.vTotTrib := 0;

    {    Total.ISSQNtot.vServ   := 100;
        Total.ISSQNTot.vBC     := 100;
        Total.ISSQNTot.vISS    := 2;
        Total.ISSQNTot.vPIS    := 0;
        Total.ISSQNTot.vCOFINS := 0;

  {      Total.retTrib.vRetPIS    := 0;
        Total.retTrib.vRetCOFINS := 0;
        Total.retTrib.vRetCSLL   := 0;
        Total.retTrib.vBCIRRF    := 0;
        Total.retTrib.vIRRF      := 0;
        Total.retTrib.vBCRetPrev := 0;
        Total.retTrib.vRetPrev   := 0;}

        Transp.modFrete := mfContaEmitente;
        Transp.Transporta.CNPJCPF  := '';
        Transp.Transporta.xNome    := '';
        Transp.Transporta.IE       := '';
        Transp.Transporta.xEnder   := '';
        Transp.Transporta.xMun     := '';
        Transp.Transporta.UF       := '';

  {      Transp.retTransp.vServ    := 0;
        Transp.retTransp.vBCRet   := 0;
        Transp.retTransp.pICMSRet := 0;
        Transp.retTransp.vICMSRet := 0;
        Transp.retTransp.CFOP     := '';
        Transp.retTransp.cMunFG   := 0;         }

        Transp.veicTransp.placa := '';
        Transp.veicTransp.UF    := '';
        Transp.veicTransp.RNTC  := '';
  //Dados do Reboque
  {      with Transp.Reboque.Add do
         begin
           placa := '';
           UF    := '';
           RNTC  := '';
         end;}

        with Transp.Vol.Add do
         begin
           qVol  := 1;
           esp   := 'Especie';
           marca := 'Marca';
           nVol  := 'Numero';
           pesoL := 100;
           pesoB := 110;

           //Lacres do volume. Pode ser adicionado vários
           //Lacres.Add.nLacre := '';
         end;

        Cobr.Fat.nFat  := 'Numero da Fatura';
        Cobr.Fat.vOrig := 100 ;
        Cobr.Fat.vDesc := 0 ;
        Cobr.Fat.vLiq  := 100 ;

        with Cobr.Dup.Add do
         begin
           nDup  := '1234';
           dVenc := now+10;
           vDup  := 50;
         end;

        with Cobr.Dup.Add do
         begin
           nDup  := '1235';
           dVenc := now+10;
           vDup  := 50;
         end;


        InfAdic.infCpl     :=  '';
        InfAdic.infAdFisco :=  '';

        with InfAdic.obsCont.Add do
         begin
           xCampo := 'ObsCont';
           xTexto := 'Texto';
         end;

        with InfAdic.obsFisco.Add do
         begin
           xCampo := 'ObsFisco';
           xTexto := 'Texto';
         end;
  //Processo referenciado
  {     with InfAdic.procRef.Add do
         begin
           nProc := '';
           indProc := ipSEFAZ;
         end;                 }

        exporta.UFembarq   := '';;
        exporta.xLocEmbarq := '';

        compra.xNEmp := '';
        compra.xPed  := '';
        compra.xCont := '';
     end;

    {$EndRegion}
  end;

end;

function TNFe.GetCaminhoLogs: String;
begin

end;

function TNFe.GetCaminhoNaoEnviado: String;
begin

end;

function TNFe.GetCaminhoNFe: String;
begin

end;

function TNFe.GetCaminhoPastaCidade: String;
begin

end;

function TNFe.GetCaminhoPDF: String;
begin

end;

function TNFe.GetCaminhoRespostasWS: String;
begin

end;

function TNFe.GetCaminhoRPS: String;
begin

end;

function TNFe.GetCaminhoXml: String;
begin

end;

function TNFe.GetCodigoVerificacao: String;
begin

end;

function TNFe.GetLote: String;
begin

end;

function TNFe.GetProtocolo: String;
begin

end;

procedure TNFe.Imprimir(Protocolo: String);
begin

end;

procedure TNFe.SalvaLogoEmpresa(CampoImg: TField);
begin

end;

procedure TNFe.SetLote(const Value: String);
begin

end;

Function TNFe.VerificaStatus: TRetorno;
begin
  Result.Erro := True;
  if NFe.WebServices.StatusServico.Executar Then
  begin
    Result.Erro := False;
    if NFe.WebServices.StatusServico.tpAmb <> Nfe.Configuracoes.WebServices.Ambiente  then
    begin
      Result.Erro := True;
      Result.Mensagem :=' Ambiente configurado no sistema diferente do SEFAZ';
      Exit;
    end;


  end else
    Result.Mensagem := NFe.WebServices.StatusServico.xMotivo;
end;

end.
