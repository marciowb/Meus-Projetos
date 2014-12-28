unit uNFSe;

interface
   uses
       MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,ulibERP, DateUtils, Generics.Collections,uDocumentoFiscal,ACBrNFSe,
       ACBrNFSeDANFSeClass, pnfsNFSe,pcnConversao, pnfsConversao,uConstantes,uClassesERP;
   type
     TNFSe = class
     Private
       FDocs: TList<IDocumentoFiscal>;
       NFSe: TACBrNFSe;
       fLote: String;
       FProtocolo: String;
       FCaminhoNFSe: String;
       FCaminhoXml: String;
       FCaminhoLogs: String;
       fCodigoVerificacao: String;

       Function GeraArquivo: TRetorno;
       function GetLote: String;
       Function ConsultaSituacao: Boolean;
       function GetProtocolo: String;
       function GetCodigoVerificacao: String;
       procedure SetLote(const Value: String);
     public
       constructor Create(Const Docs: TList<IDocumentoFiscal>);
       destructor Destroy;
       property Lote: String read GetLote write SetLote;
       property Protocolo: String read GetProtocolo;
       property CodigoVerificacao: String read GetCodigoVerificacao;
       Function Enviar: TRetorno;
     end;


implementation
  Const
    PastaRioDeJaneiro: String = 'Rio de Janeiro';
    SituacaoRioDeJaneiroNaoRecebido: String ='1';
    SituacaoRioDeJaneiroNaoProcessado: String ='2';
    SituacaoRioDeJaneiroProcessadoComErro: String ='3';
    SituacaoRioDeJaneiroProcessadoComSucesso: String ='4';


{ TNFSe }

function TNFSe.ConsultaSituacao: Boolean;
begin

end;

constructor TNFSe.Create(Const Docs: TList<IDocumentoFiscal>);
var
 PathMensal: String;
begin
  FDocs := Docs;
  NFSe := TACBrNFSe.Create(nil);

  FCaminhoNFSe := ExtractFilePath(ParamStr(0))+'NFSe';
  FCaminhoXml :=FCaminhoNFSe+'\XML';
  FCaminhoLogs :=FCaminhoNFSe+'\Log';

  ForceDirectories(FCaminhoNFSe);
  ForceDirectories(FCaminhoXml);
  ForceDirectories(FCaminhoLogs);


  NFSe.Configuracoes.Certificados.SelecionarCertificado;

  NFSe.Configuracoes.Arquivos.AdicionarLiteral:=True;
  NFSe.Configuracoes.Arquivos.EmissaoPathNFSe:=True;
  NFSe.Configuracoes.Arquivos.PastaMensal:=True;
  NFSe.Configuracoes.Arquivos.PathCan:= FCaminhoLogs;
  NFSe.Configuracoes.Arquivos.PathNFSe:= FCaminhoXml;
  NFSe.Configuracoes.Arquivos.Salvar:=True;

  PathMensal:= NFSe.Configuracoes.Arquivos.GetPathNFSe(0);

  NFSe.Configuracoes.Geral.PathSchemas := FCaminhoNFSe+'\'+PastaRioDeJaneiro+'\Schemas\';
  NFSe.Configuracoes.Geral.Salvar      := True;
  NFSe.Configuracoes.Geral.PathSalvar  := FCaminhoLogs;

  NFSe.Configuracoes.WebServices.CodigoMunicipio := StrToIntDef(FDocs[0].Emitente.Endereco.CodigoMunicipio, 0);
  if FDocs[0].TipoAmbiente = uClassesERP.tabHomologacao Then
    NFSe.Configuracoes.WebServices.Ambiente := taHomologacao
  else
    NFSe.Configuracoes.WebServices.Ambiente := taProducao;

  NFSe.Configuracoes.WebServices.Visualizar      := True;
  NFSe.Configuracoes.WebServices.SenhaWeb        := '';
  NFSe.Configuracoes.WebServices.UserWeb         := '';
  NFSe.Configuracoes.WebServices.Salvar          := True;

  NFSe.Configuracoes.WebServices.ProxyHost := '';
  NFSe.Configuracoes.WebServices.ProxyPort := '';
  NFSe.Configuracoes.WebServices.ProxyUser := '';
  NFSe.Configuracoes.WebServices.ProxyPass := '';

  NFSe.Configuracoes.WebServices.SetConfigMunicipio(NFSe.Configuracoes.Geral.PathSchemas);

  if NFSe.DANFSe <> nil then
  begin
  NFSe.DANFSe.Logo       := '';
  NFSe.DANFSe.PrestLogo  := '';
  NFSe.DANFSe.Prefeitura := '';
  NFSe.DANFSe.PathPDF    := FCaminhoLogs;
  end;



end;

destructor TNFSe.Destroy;
begin
  FreeAndNil(NFSe);
  FreeAndNil(FDocs);
end;

function TNFSe.Enviar: TRetorno;
var
  Enviado: Boolean;
begin
   Result := GeraArquivo;
   if not Result.Erro then
   begin
     Try
       Try
         Enviado := NFSe.Enviar(fLote);
       Except
         on e:Exception do
         begin
           Result.Erro := True;
           Result.Mensagem := 'Erro ao enviar lote. |'+e.Message;
           Exit;
         end;
       End;
       if Enviado Then
       begin
         FProtocolo :=  NFSe.WebServices.ConsLote.Protocolo;

         Try
           fCodigoVerificacao := NFSe.WebServices.Enviar.NFSeRetorno.Leitor.rCampo(tcStr,'CodigoVerificacao');{ TODO : testar }
         except
           on e:Exception do
           begin
             Result.Erro := True;
             Result.Mensagem := 'Erro ao ler retorno lote. |' +NFSe.WebServices.Enviar.NFSeRetorno.Leitor.Arquivo+'|'+e.Message;
             Exit;
           end;
         End;


         { TODO : Fazer case por cidade }
         Result.Erro := NFSe.WebServices.ConsSitLote.Situacao = SituacaoRioDeJaneiroProcessadoComErro;
         if Result.Erro then
         begin
            Result.Mensagem := NFSe.WebServices.ConsSitLote.Msg+'|'+NFSe.WebServices.ConsSitLote.RetWS;
            Exit;
         end;
       end;
     Except
       on e:Exception do
       begin
         Result.Erro := True;
         Result.Mensagem := 'Erro ao enviar lote NFSe. |'+e.Message;
         Exit;
       end;
     End;
   end;
end;

function TNFSe.GeraArquivo: TRetorno;
var
  I,x:Integer;
  Arquivo: String;
  G: TGuid;
begin
   Try
     Result.Erro := False;
  
     {$Region 'Adiciona Notas'}
     NFSe.NotasFiscais.Clear;
     NFSe.NotasFiscais.NumeroLote := Lote;
     NFSe.NotasFiscais.Transacao := True;
     for I := 0 to FDocs.Count - 1 do
     begin
       for X := 0 to FDocs[i].Servicos.Count - 1 do
       begin
         with NFSe.NotasFiscais.Add.NFSe do
         begin
            {$Region 'Sobre a nota'}
            IdentificacaoRps.Numero := FormatFloat('#########0', StrToInt(FDocs[i].NumeroNota));
            IdentificacaoRps.Serie := FDocs[i].SerieNota;
            IdentificacaoRps.Tipo := trRPS;
            DataEmissao := FDocs[i].DataNota;
            // TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune, noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo );
            NaturezaOperacao := noTributacaoNoMunicipio;

            // TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
            //  RegimeEspecialTributacao := retNenhum;
            if FDocs[i].Emitente.RegimeTributacao = RegimeEmpresaLucroReal Then
              RegimeEspecialTributacao := retLucroReal
            else
            if FDocs[i].Emitente.RegimeTributacao = RegimeEmpresaLucroPresumido Then
              RegimeEspecialTributacao := retLucroPresumido
            else
            if FDocs[i].Emitente.RegimeTributacao = RegimeEmpresaMei Then
              RegimeEspecialTributacao := retMicroempresarioIndividual
            else
              RegimeEspecialTributacao := retNenhum;


            // TnfseSimNao = ( snSim, snNao );
            if FDocs[i].Emitente.RegimeTributacao = RegimeEmpresaSimples then
            OptanteSimplesNacional := snSim
            else
            OptanteSimplesNacional := snNao;

            // TnfseSimNao = ( snSim, snNao );
            IncentivadorCultural := snNao;

            // TnfseSimNao = ( snSim, snNao );
            // snSim = Ambiente de Produção
            // snNao = Ambiente de Homologação
            if FDocs[i].TipoAmbiente =uClassesERP.tabHomologacao then
            Producao := snNao
            else
            if FDocs[i].TipoAmbiente = uClassesERP.tabProducao then
            Producao := snSim;

            // TnfseStatusRPS = ( srNormal, srCancelado );
            Status := srNormal;

            // Somente Os provedores Betha, FISSLex e SimplISS permitem incluir no RPS
            // a TAG: OutrasInformacoes os demais essa TAG é gerada e preenchida pelo
            // WebService do provedor.
            OutrasInformacoes := '';
            {$EndRegion}

            {$Region 'Totais'}
            Servico.Valores.ValorServicos          := FDocs[i].TotalServicos;
            Servico.Valores.ValorDeducoes          := 0.00;
            Servico.Valores.ValorPis               := FDocs[i].TotalImpostos.ValorPIS;
            Servico.Valores.ValorCofins            := FDocs[i].TotalImpostos.ValorCOFINS;
            Servico.Valores.ValorInss              := 0.00;
            Servico.Valores.ValorIr                := FDocs[i].TotalImpostos.ValorIR;
            Servico.Valores.ValorCsll              := FDocs[i].TotalImpostos.ValorCSLL;

            // TnfseSituacaoTributaria = ( stRetencao, stNormal, stSubstituicao );
            // stRetencao = snSim
            // stNormal   = snNao

            // Neste exemplo não temos ISS Retido ( stNormal = Não )
            // Logo o valor do ISS Retido é igual a zero.
            Servico.Valores.IssRetido              := stNormal;
            Servico.Valores.ValorIssRetido         := 0.00;

            Servico.Valores.OutrasRetencoes        := 0.00;
            Servico.Valores.DescontoIncondicionado := 0.00;
            Servico.Valores.DescontoCondicionado   := 0.00;

            Servico.Valores.BaseCalculo := Servico.Valores.ValorServicos -
                                       Servico.Valores.ValorDeducoes -
                                       Servico.Valores.DescontoIncondicionado;
            // No caso do provedor Ginfes devemos informar a aliquota já dividida por 100
            // para outros provedores devemos informar por exemplo 3, mas ao fazer o calculo
            // do valor do ISS devemos dividir por 100
            Servico.Valores.Aliquota    := FDocs[i].Servicos[X].Impostos.AliqISS/100;

            // Valor do ISS calculado multiplicando-se a base de calculo pela aliquota
            //        ValorISS := Servico.Valores.BaseCalculo * Servico.Valores.Aliquota;

            // A função RoundTo5 é usada para arredondar valores, sendo que o segundo
            // parametro se refere ao numero de casas decimais.
            // exemplos: RoundTo5(50.532, -2) ==> 50.53
            // exemplos: RoundTo5(50.535, -2) ==> 50.54
            // exemplos: RoundTo5(50.536, -2) ==> 50.54

            Servico.Valores.ValorIss       := RoundTo5(FDocs[i].Servicos[X].Impostos.ValorISS, -2);

            Servico.Valores.ValorLiquidoNfse := Servico.Valores.ValorServicos -
                                           Servico.Valores.ValorPis -
                                           Servico.Valores.ValorCofins -
                                           Servico.Valores.ValorInss -
                                           Servico.Valores.ValorIr -
                                           Servico.Valores.ValorCsll -
                                           Servico.Valores.OutrasRetencoes -
                                           Servico.Valores.ValorIssRetido -
                                           Servico.Valores.DescontoIncondicionado -
                                           Servico.Valores.DescontoCondicionado;

            Servico.ItemListaServico         := FDocs[i].Servicos[X].CodigoFederalServico;
            {$EndRegion}

            {$Region 'Sobre o serviço'}
          // Para o provedor ISS.NET em ambiente de Homologação
          // o Codigo CNAE tem que ser '6511102'
          // Servico.CodigoCnae                := '123'; // Informação Opcional

            Servico.CodigoTributacaoMunicipio :=FDocs[i].Servicos[X].CodigoMunicipalServico;
            Servico.Discriminacao             := FDocs[i].Servicos[x].DescricaoCodigoServico;

//          if FDocs[i].Servicos[X].CodigoDeBeneficio <> '' then
//          begin
//            Servico.CodigoTributacaoMunicipio :=FDocs[i].Servicos[X].CodigoDeBeneficio+StringReplace(FDocs[i].Servicos[X].CodigoMunicipalServico,'.','',[rfReplaceAll]) ;
//            Servico.Discriminacao             := FDocs[i].Servicos[x].DesciminacaoCodigoDeBeneficio;
//          end else
//          begin
//            if FDocs[i].TipoAmbiente = uClassesERP.tabHomologacao then
//            begin
//              Servico.CodigoTributacaoMunicipio := '118879';
//              Servico.Discriminacao             := 'discriminacao I;discriminacao II';
//            end;
//
//          end;

          // Para o provedor ISS.NET em ambiente de Homologação
          // o Codigo do Municipio tem que ser '999'
          if FDocs[i].TipoAmbiente = uClassesERP.tabHomologacao then
            Servico.CodigoMunicipio := '999'
          else
            Servico.CodigoMunicipio := FDocs[i].Emitente.Endereco.CodigoMunicipio;

          // Informar A Exigibilidade ISS para fintelISS [1/2/3/4/5/6/7]
          Servico.ExigibilidadeISS := exiExigivel;

          // Informar para Saatri
          Servico.CodigoPais := 1058; // Brasil
          Servico.MunicipioIncidencia := StrToInt64(FDocs[i].Destinatario.Endereco.CodigoMunicipio);
          // Somente o provedor SimplISS permite infomar mais de 1 serviço
          with Servico.ItemServico.Add do
          begin
            Descricao     := FDocs[i].Servicos[x].Nome;
            Quantidade    := 1;
            ValorUnitario := FDocs[i].Servicos[x].ValorUnitario;
          end;

          {$EndRegion}

            {$Region 'Emitente'}
             Prestador.Cnpj               := FDocs[i].Emitente.CPF_CNPJ;
             Prestador.InscricaoMunicipal := FDocs[i].Emitente.IM;

             // Para o provedor ISSDigital deve-se informar também:
  //           Prestador.Senha        := 'senha';
  //           Prestador.FraseSecreta := 'frase secreta';

             Prestador.cUF          := StrToInt(FDocs[i].Emitente.Endereco.CodigoIBGEEstado);

             PrestadorServico.Endereco.CodigoMunicipio := FDocs[i].Emitente.Endereco.CodigoMunicipio;
             PrestadorServico.RazaoSocial := FDocs[i].Emitente.Nome_RazaoSocial;
            {$EndRegion}

            {$Region 'Destinatario'}
             Tomador.IdentificacaoTomador.CpfCnpj            := FDocs[i].Destinatario.CPF_CNPJ;
             Tomador.IdentificacaoTomador.InscricaoMunicipal := FDocs[i].Destinatario.IM;

             Tomador.RazaoSocial := FDocs[i].Destinatario.Nome_RazaoSocial;

             Tomador.Endereco.Endereco        := FDocs[i].Destinatario.Endereco.Endereco;
             Tomador.Endereco.Numero          := FDocs[i].Destinatario.Endereco.NumeroEndereco;
             Tomador.Endereco.Complemento     := FDocs[i].Destinatario.Endereco.Complemento;
             Tomador.Endereco.Bairro          := FDocs[i].Destinatario.Endereco.Bairro;
             Tomador.Endereco.CodigoMunicipio := FDocs[i].Destinatario.Endereco.CodigoMunicipio;
             Tomador.Endereco.UF              := FDocs[i].Destinatario.Endereco.Estado;
             Tomador.Endereco.CEP             := FDocs[i].Destinatario.Endereco.CEP;
           //Provedor Equiplano é obrigatório o pais e IE
             Tomador.Endereco.xPais           := 'BRASIL';
             Tomador.IdentificacaoTomador.InscricaoEstadual := FDocs[i].Destinatario.IE;

             Tomador.Contato.Telefone := FDocs[i].Destinatario.Telefone;
             Tomador.Contato.Email    := FDocs[i].Destinatario.Email;

             (* Usando quando houver um intermediario na prestação do serviço
             IntermediarioServico.RazaoSocial        := 'razao';
             IntermediarioServico.CpfCnpj            := '00000000000';
             IntermediarioServico.InscricaoMunicipal := '12547478';
             *)

             (* Usando quando o serviço for uma obra
             ConstrucaoCivil.CodigoObra := '88888';
             ConstrucaoCivil.Art        := '433';
             *)
            {$EndRegion}

            CreateGUID(G);
            Arquivo := GUIDToString(G);
            Arquivo := StringReplace(Arquivo,'{','',[rfReplaceAll]);
            Arquivo := StringReplace(Arquivo,'}','',[rfReplaceAll]);
            Arquivo := StringReplace(Arquivo,'-','',[rfReplaceAll]);

            Arquivo := FormatFloat('#########0', StrToInt(FDocs[i].NumeroNota))+'_'+Arquivo+'.xml';
            //NFSe.NotasFiscais.Items[X+I].SaveToFile(FCaminhoXml+'\'+Arquivo);
         end;

       end;
     end;
     {$EndRegion}


     NFSe.GerarLote(Lote);
     NFSe.NotasFiscais.SaveToFile(FCaminhoXml+'\.');
   Except
     on e: Exception do
     begin
       result.Erro := True;
       Result.Mensagem := 'Erro ao gerar arquivos. '+E.Message;
     end;
   End;
end;



function TNFSe.GetCodigoVerificacao: String;
begin
   Result := fCodigoVerificacao;
end;

function TNFSe.GetLote: String;
var
  Guid: TGUID;
  Temp: Integer;
begin
//   if FLote = '' then
//   begin
////     CreateGUID(Guid);
////     FLote := GUIDToString(Guid);
////     FLote := Copy(FLote,1,10);
////     FLote := StringReplace(fLote,'{','',[rfReplaceAll]);
////     FLote := StringReplace(fLote,'}','',[rfReplaceAll]);
////     FLote := StringReplace(fLote,'-','',[rfReplaceAll]);
//      Temp :=  Random(9999999999);
//      fLote := IntToStr(Temp);
//   end;
   Result := FLote;

end;

function TNFSe.GetProtocolo: String;
begin
   Result := FProtocolo;
end;

procedure TNFSe.SetLote(const Value: String);
begin
   fLote := Value;
end;

end.
