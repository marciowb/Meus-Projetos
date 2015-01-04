unit uLibERP;

interface
    Uses MinhasClasses, uSQLERP,Comandos,Classes,
         SysUtils, Math, EditPesquisa,pFIBClientDataSet,DB,
         uDocumentoFiscal,uClassesERP;
   type
     TRotinasPesquisa = class
       class procedure ConfiguraPesquisaFuncionario(var Edit : TEditPesquisa; aDataSet : TpFIBClientDataSet; aCampoData :String = '');
     end;



    Function TipoCampoChaveToStr(Valor: TipoCampoChave): String;

    function RoundTo5(Valor: Double; Casas: Integer): Double;
    Procedure CriaDocumentoFiscal(Const DataSetNota, DataSetItens, DataSetCobranca: TDataSet; Var Doc: IDocumentoFiscal );

    Function TipoTransporteToStr(TipoTranp: TTipoTransporte):String;
    Function StrToTipoTransporte(TipoTranp: String):TTipoTransporte;

const
   SemID: TipoCampoChave = '-1';
implementation

uses uForms, uConstantes;

{ TRotinasPesquisa }

class procedure TRotinasPesquisa.ConfiguraPesquisaFuncionario(
  var Edit: TEditPesquisa; aDataSet: TpFIBClientDataSet; aCampoData: String);
var
  IdFuncionario: String;
begin
   ConfiguraEditPesquisa(Edit,aDataSet,tpERPFuncionario,True,'','','CODIGO',aCampoData);
   IdFuncionario :=
      GetValorCds(tpERPFuncionario,'f.idusuario = '+IntToStr(USuarioLogado.Id),'idfuncionario');
   if aDataSet<> nil then
   begin
     if aDataSet.State in [dsEdit, dsInsert] then
       if aDataSet.FieldByName(Edit.CampoData).AsString = '' then
          aDataSet.FieldByName(Edit.CampoData).AsString := IdFuncionario;
   end else
    Edit.ValorChave := IdFuncionario;
   Edit.Localiza;
end;

Function TipoCampoChaveToStr(Valor: TipoCampoChave): String;
begin
   Result := GetStr(Valor);
end;

function RoundTo5(Valor: Double; Casas: Integer): Double;
 var
   xValor, xDecimais: String;
   p, nCasas: Integer;
   nValor: Double;
 begin
   nValor := Valor;
   xValor := Trim(FloatToStr(Valor));
   p := pos(',', xValor);
   if Casas < 0 then
     nCasas := -Casas
   else
     nCasas := Casas;
   if p > 0 then
   begin
     xDecimais := Copy(xValor, p + 1, length(xValor));
     if length(xDecimais) > nCasas then
     begin
       if xDecimais[nCasas + 1] >= '5' then
         SetRoundMode(rmUP)
       else
         SetRoundMode(rmNearest);
     end;
     nValor := RoundTo(Valor, Casas);
   end;
   Result := nValor;


end;



Procedure CriaDocumentoFiscal(Const DataSetNota, DataSetItens, DataSetCobranca: TDataSet; Var Doc: IDocumentoFiscal );
var
  Item: IItemDocumento;
  Cob: TCobranca;
begin
//  if  Assigned(Doc) then
//    Doc._Release;
  Doc := TDocumentoFiscal.Create;

  {$Region 'Cria Emitente'}
  with GetCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idempresa').AsString)) do
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
    Doc.Emitente.CNAE := FieldByName('CNAE').AsString;
//    Doc.Emitente.CRT := TRegrasImpostos.GetCRT(DataSetNota.FieldByName('idempresa').AsString,DataSetNota.FieldByName('data').AsDateTime);
    Doc.Emitente.Endereco.Endereco :=FieldByName('LOGRADOURO').AsString;
    Doc.Emitente.Endereco.NumeroEndereco :=FieldByName('NUMERO').AsString;
    Doc.Emitente.Endereco.Complemento :=FieldByName('COMPLEMENTO').AsString;
    Doc.Emitente.Endereco.Bairro :=FieldByName('BAIRRO').AsString;
    Doc.Emitente.Endereco.Cidade :=FieldByName('CIDADE').AsString;
    Doc.Emitente.Endereco.Estado :=FieldByName('UF').AsString;
    Doc.Emitente.Endereco.CodigoIBGEEstado := FieldByName('CODIGOIBGEESTADO').AsString;
    Doc.Emitente.Endereco.CodigoMunicipio := FieldByName('ibge').AsString;
    Doc.Emitente.Endereco.CEP :=FieldByName('CEP').AsString;
    Doc.Emitente.Endereco.NumPais := 1058;
    Doc.Emitente.Endereco.NomePais := 'BRASIL';
    Doc.Emitente.RegimeTributacao := FieldByName('REGIMEEMPRESA').AsString;
    Free;
  end;
  {$EndRegion}

  {$Region 'Cria Destinatario'}
  if (DataSetNota.FindField('IDCliente') <> nil) and
     (not DataSetNota.FieldByName('IDCliente').IsNull) then
  begin
    with GetCds(tpERPCliente,'IDCliente = '+TipoCampoChaveToStr(DataSetNota.FieldByName('IDCliente').AsString)) do
    begin
      Doc.Destinatario.Nome_RazaoSocial :=FieldByName('NOMECLIENTE').AsString;
      Doc.Destinatario.NomeFantasia :=FieldByName('FANTASIA').AsString;
      if FieldByName('CNPJ').AsString <> '' then
        Doc.Destinatario.CPF_CNPJ :=FieldByName('CNPJ').AsString
      else
      if FieldByName('CPF').AsString <> '' then
        Doc.Destinatario.CPF_CNPJ :=FieldByName('CPF').AsString;


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
      Doc.Destinatario.Endereco.CodigoMunicipio := FieldByName('IBGE').AsString;
      Doc.Destinatario.Endereco.CEP :=FieldByName('CEP').AsString;
      Doc.Destinatario.Endereco.NumPais := 1058;     { TODO : Rever }
      Doc.Destinatario.Endereco.NomePais := 'BRASIL'; { TODO : Rever }

      Free;
    end;
  end;
  if (DataSetNota.FindField('idfornecedor') <> nil) and
     (not DataSetNota.FieldByName('idfornecedor').IsNull) then
  begin
    with GetCds(tpERPFornecedor,'IDCliente = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idfornecedor').AsString)) do
    begin
      Doc.Destinatario.Nome_RazaoSocial :=FieldByName('RAZAOSOCIAL').AsString;
      Doc.Destinatario.NomeFantasia :=FieldByName('FANTASIA').AsString;
      Doc.Destinatario.CPF_CNPJ :=FieldByName('CNPJ').AsString;
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
  with GetCds(tpERPTransportadora,'IDTRANSPORTADORA = '+TipoCampoChaveToStr(DataSetNota.FieldByName('IDTRANSPORTADORA').AsString)) do
    begin
      if NOT IsEmpty then
      begin
        Doc.Emitente.Nome_RazaoSocial :=FieldByName('RAZAOSOCIAL').AsString;
        Doc.Emitente.NomeFantasia :=FieldByName('NOMEFANTASIA').AsString;
        Doc.Emitente.CPF_CNPJ :=FieldByName('CNPJ').AsString;


        Doc.Transportadora.Telefone :='';//FieldByName('TELEFONE').AsString;
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
        Doc.Transportadora.Endereco.CodigoMunicipio := FieldByName('IBGE').AsString;
        Doc.Transportadora.Endereco.CEP :=FieldByName('CEP').AsString;
        Doc.Transportadora.Endereco.NumPais := 1058;
        Doc.Transportadora.Endereco.NomePais := 'BRASIL';
      end;
      Free;
    end;

  {$EndRegion}

  {$Region 'Corpo da nota '}
  Doc.EnderecoEntrega := Doc.Destinatario.Endereco;
  Doc.EnderecoCobranca := Doc.Destinatario.Endereco;


  Doc.Seguro := DataSetNota.FieldByName('VALORSEGURO').AsCurrency;
  Doc.Frete := DataSetNota.FieldByName('VALORFRETE').AsCurrency;
  Doc.OutrasDespesas := DataSetNota.FieldByName('VALOROUTRASDESPESAS').AsCurrency;
  Doc.TotalDocumento := DataSetNota.FieldByName('VALORTOTALNOTA').AsCurrency;

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

  if DataSetNota.FieldByName('FLAGMODALIDADEFRETE').AsString  = 'D' then
    Doc.TipoFrete := tfDestinatario
  else
  if DataSetNota.FieldByName('FLAGMODALIDADEFRETE').AsString  = 'E' then
    Doc.TipoFrete := tfEmitente
  else
    Doc.TipoFrete := tfTerceiros;

  Doc.Placa := DataSetNota.FieldByName('PLACAVEICULO').AsString;
  Doc.UfPlaca := DataSetNota.FieldByName('UFPLACAVEICULO').AsString;
  Doc.ANTT := '';
  Doc.Volume := DataSetNota.FieldByName('VOLUME').AsInteger;
  Doc.Especie := DataSetNota.FieldByName('ESPECIE').AsString;
  Doc.Marca := '';
  Doc.PesoBruto := DataSetNota.FieldByName('PESOBRUTO').AsFloat;
  Doc.PesoLiquido := DataSetNota.FieldByName('PESOLIQ').AsFloat;

  Doc.DataNota := DataSetNota.FieldByName('DATA').AsDateTime;

  {$EndRegion}

  {$Region 'Itens'}
  DataSetItens.First;
  while not DataSetItens.Eof do
  begin
    Item := TItemDocumento.Create;
    Item.Codigo := DataSetItens.FieldByName('CODIGO').AsString;
    Item.Unidade := DataSetItens.FieldByName('UNIDADE').AsString;
    Item.Quantidade := DataSetItens.FieldByName('QUANTIDADE').AsCurrency;
    Item.ValorUnitario := DataSetItens.FieldByName('VALORUNITARIO').AsCurrency;
    Item.ValorDesconto := DataSetItens.FieldByName('VALORDESCONTO').AsCurrency;
    Item.ValorAcrescimo := DataSetItens.FieldByName('VALORACRESCIMO').AsCurrency;
    Item.AliqDesconto := DataSetItens.FieldByName('ALIQDESCONTO').AsCurrency;
    Item.AliqAcrescimo := DataSetItens.FieldByName('ALIQACRESCIMO').AsCurrency;
    Item.ValorFrete := DataSetItens.FieldByName('VALORFRETERATEADO').AsCurrency;
    Item.ValorSeguro := DataSetItens.FieldByName('VALORSEGURORATEADO').AsCurrency;
    Item.ValorOutrasDespesas := DataSetItens.FieldByName('VALOROUTRASDESPESASRATEADO').AsCurrency;
    Item.ValorTotalLiquido := DataSetItens.FieldByName('VALORTOTAL').AsCurrency;

    Item.CFOP := DataSetItens.FieldByName('CFOP').AsString;
    Item.CST := DataSetItens.FieldByName('CST').AsString;
    Item.CSOSN := DataSetItens.FieldByName('CSOSN').AsString;
    Item.CRT := DataSetItens.FieldByName('CRT').AsString;
    if Doc.Emitente.CRT  = '' then
      Doc.Emitente.CRT  := Item.CRT;

    Item.NumDI := '';
    Item.DataDI :=0;
    Item.LocalDesembaraco := '';
    Item.UFDesenbaraco:= '';
    Item.DataDesembaraco := 0;
    Item.TipoTransporte := Doc.TipoTransporte;
    Item.ValorAFRMM := 0;
    Item.TipoIntermedio := tiImportacao_por_conta_propria;
    Item.CNPJ_Adquerente := Doc.Emitente.CPF_CNPJ;
    Item.UF_Terceiro :='';
    Item.CodigoExportador := '';
    Item.NumAdicao := 0;
    Item.CodigoDoProdutoNoFabricante := '';

    Item.NumeroPedidoCompra:= '';
    Item.NumeroItemPedidoCompra := 0;

    Item.Impostos.AliqICMS := DataSetItens.FieldByName('ALIQICMS').AsCurrency;
    Item.Impostos.AliqISS := DataSetItens.FieldByName('ALIQISS').AsCurrency;
    Item.Impostos.AliqCOFINS := DataSetItens.FieldByName('ALIQCOFINS').AsCurrency;
    Item.Impostos.AliqPIS := DataSetItens.FieldByName('ALIQPIS').AsCurrency;
    Item.Impostos.AliqIPI := DataSetItens.FieldByName('ALIQIPI').AsCurrency;
    Item.Impostos.TipoIPI := iIPIAliq;
    Item.Impostos.MVA := DataSetItens.FieldByName('MVA').AsCurrency;
    Item.Impostos.AliqICMSST := DataSetItens.FieldByName('ALIQST').AsCurrency;
    Item.Impostos.ALiqCSLL := DataSetItens.FieldByName('ALIQCSLL').AsCurrency;
    if DataSetItens.FieldByName('BASEISS').AsCurrency >0  then
    begin
      Item.Impostos.BaseISS := DataSetItens.FieldByName('BASEISS').AsCurrency  ;
      Item.Impostos.ValorISS := DataSetItens.FieldByName('VALORISS').AsCurrency;
    end else
    begin
      Item.Impostos.BaseICMS := DataSetItens.FieldByName('BASEICMS').AsCurrency;
      Item.Impostos.ValorICMS := DataSetItens.FieldByName('VALORICMS').AsCurrency;
    end;

    Item.Impostos.BaseIPI := DataSetItens.FieldByName('BASEIPI').AsCurrency;
    Item.Impostos.BasePIS_COFINS := DataSetItens.FieldByName('BASEPISCOFINS').AsCurrency;
    Item.Impostos.BaseICMSST := DataSetItens.FieldByName('BASEICMSST').AsCurrency;
    Item.Impostos.BaseCSLL := DataSetItens.FieldByName('BASECSLL').AsCurrency;

    Item.Impostos.ValorIPI := DataSetItens.FieldByName('VALORIPI').AsCurrency;
    Item.Impostos.ValorPIS := DataSetItens.FieldByName('VALORPIS').AsCurrency;
    Item.Impostos.ValorCOFINS := DataSetItens.FieldByName('VALORCOFINS').AsCurrency;
    Item.Impostos.ValorICMSST := DataSetItens.FieldByName('VALORST').AsCurrency;
    Item.Impostos.ValorCSLL := DataSetItens.FieldByName('VALORCSLL').AsCurrency;

    if DataSetItens.FieldByName('TIPO_ITEM').AsString = 'S' then
    begin
      Doc.Servicos.Add(Item);
    end else
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
    Cob.ValorDocumento := DataSetCobranca.FieldByName('VALOR').AsCurrency;

    DataSetCobranca.Next;
  end;

  with (Doc as TDocumentoFiscal).VerificaDados do
  begin
    if Count > 0 then
    begin
      AvisaErro('Erros encontrados: '+sLineBreak+ Text);
    end;
    Free;
  end;



end;

Function TipoTransporteToStr(TipoTranp: TTipoTransporte):String;
begin
  case TipoTranp of
    ttMaritima:
      Result := TipoTransporteMaritima ;
    ttFluvial:
      Result := TipoTransporteFluvial ;
    ttLacustre:
      Result := TipoTransporteLacustre ;
    ttAerea:
      Result := TipoTransporteAerea ;
    ttPostal:
       Result := TipoTransportePostal ;
    ttFerroviaria:
       Result := TipoTransporteFerroviaria ;
    ttRodoviaria:
       Result := TipoTransporteRodoviaria ;
    ttConduto_Rede_Transmissao:
       Result := TipoTransporteConduto_Rede_Transmissao ;
    ttMeios_Proprios:
      Result := TipoTransporteMeios_Proprios ;
    ttEntrada_Ou_Saida_ficta:
      Result := TipoTransporteEntrada_Saida_ficta ;
  end;
end;

Function StrToTipoTransporte(TipoTranp: String):TTipoTransporte;
begin
  if TipoTranp = TipoTransporteMaritima  then
    Result := ttMaritima
  else
  if TipoTranp = TipoTransporteFluvial  then
    Result := ttFluvial
  else
  if TipoTranp = TipoTransporteLacustre  then
    Result := ttLacustre
  else
  if TipoTranp = TipoTransporteAerea  then
    Result := ttAerea
  else
  if TipoTranp = TipoTransportePostal  then
    Result := ttPostal
  else
  if TipoTranp = TipoTransporteFerroviaria  then
    Result := ttFerroviaria
  else
  if TipoTranp = TipoTransporteRodoviaria  then
    Result := ttRodoviaria
  else
  if TipoTranp = TipoTransporteConduto_Rede_Transmissao  then
    Result := ttMaritima
  else
  if TipoTranp = TipoTransporteConduto_Rede_Transmissao  then
    Result := ttConduto_Rede_Transmissao
  else
  if TipoTranp = TipoTransporteMeios_Proprios  then
    Result := ttMeios_Proprios
  else
  if TipoTranp = TipoTransporteEntrada_Saida_ficta  then
    Result := ttEntrada_Ou_Saida_ficta;


end;

end.
