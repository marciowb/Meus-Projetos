unit uRegras;

interface
  Uses MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,ulibERP, DateUtils,uDocumentoFiscal;
  Type
    TParcela = record
      NumParcela: Integer;
      Valor: Currency;
    end;
    Tparcelas = array of Tparcela;

    TRegreasProdutos = class
       class Function CalculaPrecoVenda(Custo, Marckup: Currency):Currency;
       class Function CalculaMarkupPeloPrecoVenda(Custo, PrecoVenda: Currency):Currency;
     end;

    TRegrasCondicaoPagamento = class
      class function MaxParcela(idCondicao: TipoCampoChave): Integer;
      class function GeraParcela(idCondicao: TipoCampoChave; Valor: Currency; NumParcelas: Integer): TParcelas;
      class function PodeParcelar(idCondicao: TipoCampoChave): boolean;
    end;

    TRegrasVendaProduto = class
      class function PrecoVendaProduto(IdProduto,IdCliente,IdEmpresa: TipoCampoChave; Data: TDate; IdCor:TipoCampoChave = '-1' ;IdTamanho: TipoCampoChave = '-1'): Currency;
      class function DescontoMaxProduto(IdProduto,IdCliente,IdEmpresa: TipoCampoChave; Data: TDate;IdTabelaPreco: TipoCampoChave = '-1' ;IdCor:TipoCampoChave =  '-1';IdTamanho: TipoCampoChave = '-1'): Currency;

    end;

    TRegrasPeriodo = class
      CLASS function GetDataFinal(DataInicial: TDate;IdPeriodiciadade: TipoCampoChave): TDateTime;
    end;
    TRegrasEntradaMercadoria = class
      class Procedure CalculaTotalNotaEntrada(var DataSetMaster: TpFIBClientDataSet; var DataSetProdutos: TpFIBClientDataSet);
      class procedure CalculaValoresItens(var CampoAtual: TField);
    end;

    TRegrasSaidaProduto = class
      class procedure BloqueiaQuantidadeProduto(IdVenda,idProduto, IdEmpresa, IdCor, IDTamanho,NumItem,IdAlmoxarifado:TipoCampoChave; Quantidade: Double);
      class procedure DesbloqueiaQuantidadeProduto(IdVenda,IdEmpresa: TipoCampoChave; NumItem:Integer);
      class function GravaSaida(const DataSetSaida, DataSetProdutos, DataSetPagamentos, DataSetParcelamento,DataSetSeriais: TpFIBClientDataSet): Boolean;
      class procedure DesbloqueiaProdutosVenda(IdVenda,IdEmpresa:TipoCampoChave);
    end;

    TRegrasOS = class
      class function BaixaOS(IdOS: String): Boolean;
      class function ReabrirOS(IdOS: String): Boolean;
      class function ImportaContrato(Const IdContratoCompetencia: TipoCampoChave; var DataSetOS,DataSetEquipamentos,DataSetServicos: TpFIBClientDataSet): Boolean;
    end;
   TRegrasAgenda =class
     class Procedure BaixaCompromisso(IdAgenda: TipoCampoChave);
   end;

   TRegrasContasReceber = class
      class function DiasAtraso(DataRecebimento,DataVencimento: TDate): SmallInt;
      class function CalculaMora(Valor: Currency; DataRecebimento,DataVencimento: TDate): Currency;
      class function CalculaJuros(Valor: Currency; DataRecebimento,DataVencimento: TDate): Currency;
      class function CalculaAliqJuros(DataRecebimento,DataVencimento: TDate): Currency;
      class Function GeraContaReceberDeSaida(IdSaida : TipoCampoChave;UsaTrancaoPropria: Boolean = False ): Boolean;
   end;

   TRegrasPatrimonio = class
     class Procedure GetListagemPatrimoniosAlerta(var CdsAlerta: TpFIBClientDataSet);
     class function VerificaPatrimonioPermitidoParaMovimentar(IdPatrimonio: TipoCampoChave;DataMov: TDate): Boolean;
   end;


   TRegrasImpostos = class
    private
      class Procedure GetAliqImpostos(IdCliente,IdProduto:TipoCampoChave;UFOrigem: String;
                                            Out Imposto: TImpostos;
                                            out ValorMinimoTributosFederais: Currency;
                                            out ValorMinimoIR: Currency;
                                            Out TipoProduto:String );
    public
      class function CalculaImpostos(IdCliente, IdProduto,IdCFOP, IdEmpresa: TipoCampoChave; CST: String; CSOSN: String;
                                     ValorOperacao: Currency; Frete,Seguro,OutrasDespesas: Currency): IImpostos;
      class function GetCRT(IdEmpresa: TipoCampoChave; Data: TDate): String;

   end;


implementation

uses uConstantes, uConfiguracaoOS, uConfiguracaoFinanceiro;

{ TRegrasCondicaoPagamento }

class function TRegrasCondicaoPagamento.GeraParcela(
  idCondicao: TipoCampoChave; Valor: Currency; NumParcelas: Integer): TParcelas;
var
  vMaxParcela: Integer;
  ValorMinimo, Total, ValorPorPacela, Dif: Currency;
  PermiteParcelado: Boolean;
  NomeForma: String;
  I: Integer;
begin
//   Result := [nil];
   {$Region 'Obtem informações'}
   vMaxParcela := MaxParcela(idCondicao);
   with GetCds(tpERPCondicaoPagamento,'idcondicaopagamento = '+TipoCampoChaveToStr(idCondicao)) do
   begin
     ValorMinimo :=  FieldByName('VALORMINIMO').AsCurrency;
     PermiteParcelado := FieldByName('FLAGTIPOPAGAMENTO').AsInteger in [FormaPagamentoCartao, FormaPagamentoCheque];
     NomeForma := FieldByName('NOMECONDICAOPAGAMENTO').AsString;

     Free;
   end;
   {$Endregion}


   {$Region 'Vaz validações' }
   if (not PermiteParcelado) and (NumParcelas > 0) then
     AvisaErro('A forma de pagamento "'+NomeForma+'" não permite parcelamento. ');

   if (vMaxParcela < NumParcelas) and (vMaxParcela > 0) then
      AvisaErro('O número de parcelas da forma de pagamento "'+NomeForma+'" é maior que o máximo permitido('+IntToStr(vMaxParcela)+')');


   {$Endregion}

   if NumParcelas= 0  then
     NumParcelas := 1;

   ValorPorPacela := Valor / NumParcelas;
   ValorPorPacela := RoundTo(ValorPorPacela,-2);
   Total := ValorPorPacela * NumParcelas;
   Dif := Valor - Total;
   SetLength(Result,NumParcelas);
   for I := 0 to NumParcelas -1 do
   begin
     Result[i].NumParcela := I+1;
     Result[i].Valor := ValorPorPacela;
   end;
   Result[NumParcelas -1].Valor := Result[NumParcelas -1].Valor + Dif;


end;

class function TRegrasCondicaoPagamento.MaxParcela(
  idCondicao: TipoCampoChave): Integer;
begin
  Result := StrToIntDef( GetValorCds(tpERPCondicaoPagamento,'idcondicaopagamento = '+TipoCampoChaveToStr(idCondicao),'MAXPARCELAS'), -1);

end;

class function TRegrasCondicaoPagamento.PodeParcelar(
  idCondicao: TipoCampoChave): boolean;
begin
  Result := StrToIntDef( GetValorCds(tpERPCondicaoPagamento,'idcondicaopagamento = '+TipoCampoChaveToStr(idCondicao),'FLAGTIPOPAGAMENTO'),-1) in [FormaPagamentoCartao, FormaPagamentoCheque];
end;

{ TRegreasProdutos }

class function TRegreasProdutos.CalculaMarkupPeloPrecoVenda(Custo,
  PrecoVenda: Currency): Currency;
begin
 if Custo <= 0 then
    Result := 0
  else
    Result :=  ((PrecoVenda /Custo) -1) * 100;

end;

class function TRegreasProdutos.CalculaPrecoVenda(Custo,
  Marckup: Currency): Currency;
begin
   Result := Custo+ (Custo * Marckup/100);
end;

{ TRegrasVendaProduto }

class function TRegrasVendaProduto.DescontoMaxProduto(IdProduto, IdCliente,
  IdEmpresa: TipoCampoChave; Data: TDate; IdTabelaPreco, IdCor,
  IdTamanho: TipoCampoChave): Currency;
begin
  Result := 0;
//  USuarioLogado.Id; verificar por usuario

  { TODO : Fazer depois pq a prioridade é o contrato e a OS }
end;

class function TRegrasVendaProduto.PrecoVendaProduto(IdProduto,IdCliente,IdEmpresa: TipoCampoChave; Data: TDate; IdCor:TipoCampoChave = '-1' ;IdTamanho: TipoCampoChave = '-1'): Currency;
var
  Temp: String;
begin
  Result := 0;
  Temp := GetValorCds(tpERPProduto,'idproduto = '+TipoCampoChaveToStr(IdProduto),'PRECO');
  Result := StrToCurrDef(Temp,0);
end;

{ TRegrasPeriodo }

class function TRegrasPeriodo.GetDataFinal(DataInicial: TDate;
  IdPeriodiciadade: TipoCampoChave): TDateTime;
var
  NumDias: Integer;
begin
  NumDias := StrToInt(GetValorCds(tpERPPeridicidade,'IDPERIODICIDADE = '+TipoCampoChaveToStr(IdPeriodiciadade),'NUMDIAS'));
  Result := AddDay(NumDias,DataInicial);
end;

{ TRegrasEntradaMercadoria }

class procedure TRegrasEntradaMercadoria.CalculaTotalNotaEntrada(
  var DataSetMaster, DataSetProdutos: TpFIBClientDataSet);
var
  CdsClone : TpFIBClientDataSet;
  vValorTotal,vValorICMS, vValorIPI,vValorICMSST : Currency;
begin
  inherited;
  Try
    CdsClone := TpFIBClientDataSet.Create(nil);
    CdsClone.CloneCursor(DataSetProdutos, True);

    CdsClone.First;
    vValorTotal := 0;
    vValorICMS := 0;
    vValorIPI := 0;
    vValorICMSST := 0;
    while not CdsClone.Eof do
    Begin
      vValorTotal := vValorTotal + CdsClone.FieldByName('VALORTOTALBRUTO').AsCurrency;
      vValorICMS := vValorICMS + CdsClone.FieldByName('VALORICMS').AsCurrency;
      vValorIPI := vValorIPI + CdsClone.FieldByName('VALORIPI').AsCurrency;
      vValorICMSST := vValorICMSST+CdsClone.FieldByName('VALORST').AsCurrency;
      CdsClone.Next;
    End;
    DataSetMaster.FieldByName('VALORTOTALPRODUTOS').AsCurrency := vValorTotal;
    DataSetMaster.FieldByName('BASEICMS').AsCurrency := DataSetMaster.FieldByName('VALORTOTALPRODUTOS').AsCurrency ;
    DataSetMaster.FieldByName('VALORIPI').AsCurrency := vValorIPI;
    DataSetMaster.FieldByName('VALORICMS').AsCurrency := vValorICMS;
    DataSetMaster.FieldByName('VALORTOTALNOTA').AsCurrency :=
        (vValorIPI+vValorTotal+vValorICMSST+DataSetMaster.FieldByName('VALORSEGURO').AsCurrency +
         DataSetMaster.FieldByName('VALOROUTRAS').AsCurrency+
         IfThen(DataSetMaster.FieldByName('freteporconta').AsString ='D',DataSetMaster.FieldByName('VALORFRETE').AsCurrency,0)
         )-DataSetMaster.FieldByName('VALORDESCONTO').AsCurrency  ;
  Finally
    FreeAndNil(CdsClone);
  End;

end;

class procedure TRegrasEntradaMercadoria.CalculaValoresItens(
  var CampoAtual: TField);
Var
  MVA : Currency;
  StrSQL : String;
begin
  inherited;
  { TODO : Rever }
//  StrSQL :=
//     'SELECT CASE WHEN '+GetStr(UfEmpresa)+' = '+GetStr(UfFornecedor)+' THEN NCM.MVADENTROUF ELSE NCM.MVAFORAUF END MVA '+
//     '  FROM NCM '+
//     ' WHERE NCM.IDNCM = '+GetStr(CdsProdutos.FieldByName('IDNCM').AsString);
  MVA := 0;///StrToCurrDef(StrSQL, 0);
  if (UpperCase(CampoAtual.FieldName) = 'QUANTIDADERECEBIDA') or
     (UpperCase(CampoAtual.FieldName) = 'FATORMULTIPLICADOR') Then
  begin
    CampoAtual.DataSet.FieldByName('QUANTIDADE').AsCurrency :=
       CampoAtual.DataSet.FieldByName('QUANTIDADERECEBIDA').AsCurrency *
       CampoAtual.DataSet.FieldByName('FATORMULTIPLICADOR').AsCurrency;

  end;
  if (UpperCase(CampoAtual.FieldName) = 'QUANTIDADERECEBIDA') OR
     (UpperCase(CampoAtual.FieldName) = 'VALORUNITARIO')  then
  Begin
    CampoAtual.DataSet.FieldByName('VALORTOTAL').AsCurrency :=
      (CampoAtual.DataSet.FieldByName('QUANTIDADERECEBIDA').AsCurrency *
       CampoAtual.DataSet.FieldByName('VALORUNITARIO').AsCurrency);
    CampoAtual.DataSet.FieldByName('BASEICMS').AsCurrency :=
      CampoAtual.DataSet.FieldByName('VALORTOTAL').AsCurrency ;
   if CampoAtual.DataSet.FieldByName('REDUCAOBASE').AsCurrency > 0 then
     CampoAtual.DataSet.FieldByName('BASEICMS').AsCurrency :=
       (CampoAtual.DataSet.FieldByName('BASEICMS').AsCurrency *
       CampoAtual.DataSet.FieldByName('REDUCAOBASE').AsCurrency) / 100  ;
  End;

  if (UpperCase(CampoAtual.FieldName) = 'ALIQIPI')   then
  Begin
    CampoAtual.DataSet.FieldByName('VALORIPI').AsCurrency :=
      (CampoAtual.DataSet.FieldByName('VALORTOTAL').AsCurrency *
       CampoAtual.DataSet.FieldByName('ALIQIPI').AsCurrency) / 100.00;

    CampoAtual.DataSet.FieldByName('VALORTOTAL').AsCurrency :=
      (CampoAtual.DataSet.FieldByName('QUANTIDADERECEBIDA').AsCurrency *
       CampoAtual.DataSet.FieldByName('VALORUNITARIO').AsCurrency)+
      CampoAtual.DataSet.FieldByName('VALORIPI').AsCurrency;
  End;

  if (UpperCase(CampoAtual.FieldName) = 'ALIQICMS')   then
  Begin
    CampoAtual.DataSet.FieldByName('VALORICMS').AsCurrency :=
      (CampoAtual.DataSet.FieldByName('BASEICMS').AsCurrency *
       CampoAtual.DataSet.FieldByName('ALIQICMS').AsCurrency) / 100.00;
    if MVA > 0 then
    Begin
//      CampoAtual.DataSet.FieldByName('BASEST').AsCurrency :=
//        (CampoAtual.DataSet.FieldByName('BASEICMS').AsCurrency +
//         CampoAtual.DataSet.FieldByName('VALORIPI').AsCurrency );
//
//      CampoAtual.DataSet.FieldByName('VALORST').AsCurrency :=
//         (CampoAtual.DataSet.FieldByName('BASEST').AsCurrency * MVA)/ 100;
//      CampoAtual.DataSet.FieldByName('VALORST').AsCurrency :=
//        CampoAtual.DataSet.FieldByName('VALORST').AsCurrency -
//        ((CampoAtual.DataSet.FieldByName('BASEICMS').AsCurrency * AliqICMSInterno) / 100);
    End;

  End;

end;

{ TRegrasSaidaProduto }

class procedure TRegrasSaidaProduto.BloqueiaQuantidadeProduto(IdVenda,
  idProduto, IdEmpresa, IdCor, IDTamanho,NumItem,IdAlmoxarifado: TipoCampoChave; Quantidade: Double);
var
  StrSQL: String;
begin
  Try
    StartTrans;
    StrSQL :=
     'insert into RESERVAVENDAANDAMENTO (IDRESERVAVENDAANDAMENTO, IDSAIDA,IDEMPRESA, NUMITEM, IDPRODUTO, IDCOR, IDTAMANHO,IDALMOXARIFADO, QUANTIDADE,MON$ATTACHMENT_ID,DATA) '+
     ' values (gen_id(seq_IDRESERVAVENDAANDAMENTO,1), '+TipoCampoChaveToStr(IdVenda)+', '+TipoCampoChaveToStr(IdEmpresa)+', '+GetInteger(StrToInt(NumItem))+', '+TipoCampoChaveToStr(idProduto)+', '+IfThen(TipoCampoChaveToStr(IdCor)='0','null',TipoCampoChaveToStr(IdCor))+', '+
     IfThen(TipoCampoChaveToStr(IDTamanho)='0','null',TipoCampoChaveToStr(IDTamanho))+', '+IfThen(TipoCampoChaveToStr(IdAlmoxarifado)='0','null',TipoCampoChaveToStr(IdAlmoxarifado))+', '+GetNumber(Quantidade)+','+GetInteger(IdConexaoBd) +',CURRENT_DATE) ';
    Exec_SQL(StrSQL);
    Commit;
  Except
    on e:Exception do
    begin
      RollBack;
      Raise;
    end;
  End;
end;

class procedure TRegrasSaidaProduto.DesbloqueiaProdutosVenda(IdVenda,
  IdEmpresa: TipoCampoChave);
var
  StrSQL: String;
begin
  Try
    StartTrans;
    StrSQL :=
      'delete from RESERVAVENDAANDAMENTO '+
      ' where IDEMPRESA = '+TipoCampoChaveToStr(IdEmpresa)+
      '   AND IDSAIDA = '+TipoCampoChaveToStr(IdVenda);
    Exec_SQL(StrSQL);
    Commit;
  Except
    on e:Exception do
    begin
      RollBack;
      Raise;
    end;
  End;

end;

class procedure TRegrasSaidaProduto.DesbloqueiaQuantidadeProduto(IdVenda,IdEmpresa: TipoCampoChave; NumItem:Integer);
var
  StrSQL: String;
begin
  Try
    StartTrans;
    StrSQL :=
      'delete from RESERVAVENDAANDAMENTO '+
      ' where IDEMPRESA = '+TipoCampoChaveToStr(IdEmpresa)+
      '   AND IDVENDA = '+TipoCampoChaveToStr(IdVenda)+
      '   and NUMITEM = '+IntToStr(NumItem);
    Exec_SQL(StrSQL);
    Commit;
  Except
    on e:Exception do
    begin
      RollBack;
      Raise;
    end;
  End;
end;

class function TRegrasSaidaProduto.GravaSaida(const DataSetSaida,
  DataSetProdutos, DataSetPagamentos, DataSetParcelamento,DataSetSeriais: TpFIBClientDataSet): Boolean;
var
  StrSQL : String;
begin
  Result := False;
  Try
    StartTrans;
    AlteraBanco(taInsertOrUpdate,DataSetSaida,tpERPSaida);
    SetRegistros(DataSetProdutos,tpERPSaidaProduto);
    SetRegistros(DataSetSeriais,tpERPSaidaSerialProduto);
    SetRegistros(DataSetPagamentos,tpERPSaidaCondicaoPagamento);
    SetRegistros(DataSetParcelamento,tpERPSaidaCondicaoPagamentoParcelas);
    StrSQL :=
      'delete from RESERVAVENDAANDAMENTO '+
      ' where idsaida = '+TipoCampoChaveToStr(DataSetSaida.FieldByName('idsaida').Value);
    Exec_SQL(StrSQL);
    if not DataSetSaida.FieldByName('idOS').IsNull then
    begin
      StrSQL:=
       'update os '+
       '   set IDSTATUSOS = ' +TipoCampoChaveToStr( COnfiguracaoOS.GetConfiguracao(tpcERPStatusOSFaturada))+
       ' where idos = '+TipoCampoChaveToStr(DataSetSaida.FieldByName('idOS').AsString)  ;
      Exec_SQL(StrSQL);
    end;
    TRegrasContasReceber.GeraContaReceberDeSaida(DataSetSaida.FieldByName('idsaida').Value, False);
    Commit;
    Result := True;
  Except
    on E: Exception do
    begin
      RollBack;
      raise;
    end;

  End;
end;

{ TRegrasOS }
{ TRegrasOS }

class function TRegrasOS.BaixaOS(IdOS: String): Boolean;
begin
  Try
      Result := True;
      StartTrans;
      Exec_SQL('UPDATE OS SET '+
               '       FLAGBAIXADA= ''Y'', '+
               '       DATATERMINO = CURRENT_DATE, '+
               '       HORATERMINO = CURRENT_TIME, '+
               '       IDSTATUSOS = '+ TipoCampoChaveToStr(COnfiguracaoOS.GetConfiguracao(tpcERPStatusOSFinalizada))+
               ' WHERE IDOS = '+TipoCampoChaveToStr(IDOS));

      Exec_SQL('UPDATE SERVICOOS S SET '+
               '       DATATERMINO = CURRENT_DATE, '+
               '       HORATERMINO = CURRENT_TIME '+
               ' WHERE EXISTS(SELECT 1  '+
               '                FROM EQUIPAMENTOSOS E  '+
               '               WHERE E.IDOS =   '+TipoCampoChaveToStr(IDOS)+
               '                 AND E.IDEQUIPAMENTOSOS = S.IDEQUIPAMENTOSOS) '+
               '   AND ((DATATERMINO IS NULL) OR (HORATERMINO IS NULL)) ');
      Commit;
    except
      on e:Exception do
      begin
        Result := False;
        RollBack;
        raise;
      end;

    End;

end;

class function TRegrasOS.ImportaContrato(Const IdContratoCompetencia: TipoCampoChave;
               var DataSetOS,DataSetEquipamentos,DataSetServicos: TpFIBClientDataSet): Boolean;
var
  StrSQL:String;
  CdsTemp,CdsServicosOS: TpFIBClientDataSet;
begin
  Result := True;
  Try
    CdsTemp := TpFIBClientDataSet.Create(nil);
    CdsServicosOS := TpFIBClientDataSet.Create(nil);
    StrSQL :=
      'SELECT DISTINCT C.IDEMPRESA,C.IDCLIENTE, CP.IDEQUIPAMENTOCLIENTE,CE.DESCRICAOEQUIPAMENTO,CE.IDENTIFICADOR'+
      '  FROM CONTRATOCOMPETENCIA CC'+
      ' INNER JOIN CONTRATO C'+
      '    ON (C.IDCONTRATO = CC.IDCONTRATO)'+
      ' INNER JOIN CONTRATOPRODUTOS CP'+
      '    ON (CP.IDCONTRATO= C.IDCONTRATO)'+
      ' INNER JOIN CLIENTEEQUIPAMENTOS CE '+
      '    ON (CE.IDCLIENTEEQUIPAMENTOS = CP.IDEQUIPAMENTOCLIENTE) '+
      ' WHERE CC.IDCONTRATOCOMPETENCIA = '+TipoCampoChaveToStr(IdContratoCompetencia);
    SetCds(CdsTemp,StrSQL);
    CdsTemp.First;

    DataSetOS.FieldByName('IDEMPRESA').Value := CdsTemp.FieldByName('IDEMPRESA').Value;
    DataSetOS.FieldByName('IDCLIENTE').Value := CdsTemp.FieldByName('IDCLIENTE').Value;
    DataSetOS.FieldByName('IDCONTRATOCOMPETENCIA').Value := IdContratoCompetencia;

    while not CdsTemp.Eof do
    begin
      DataSetEquipamentos.Append;
      DataSetEquipamentos.FieldByName('IDEQUIPAMENTOCLIENTE').Value := CdsTemp.FieldByName('IDEQUIPAMENTOCLIENTE').Value ;
      DataSetEquipamentos.FieldByName('DESCRICAOEQUIPAMENTO').Value := CdsTemp.FieldByName('DESCRICAOEQUIPAMENTO').Value ;
      DataSetEquipamentos.FieldByName('IDENTIFICADOR').Value := CdsTemp.FieldByName('IDENTIFICADOR').Value ;
      StrSQL :=
        'SELECT CP.IDPRODUTO, CP.VALORUNITARIO, CP.SUBTOTAL, P.CODIGO, P.NOMEPRODUTO'+
        '  FROM CONTRATOCOMPETENCIA CC'+
        ' INNER JOIN CONTRATO C'+
        '    ON (C.IDCONTRATO = CC.IDCONTRATO)'+
        ' INNER JOIN CONTRATOPRODUTOS CP'+
        '    ON (CP.IDCONTRATO= C.IDCONTRATO)'+
        ' INNER JOIN PRODUTO P'+
        '    ON (P.IDPRODUTO  = CP.IDPRODUTO) '+
        ' WHERE CC.IDCONTRATOCOMPETENCIA =  '+TipoCampoChaveToStr(IdContratoCompetencia)+
        '   AND CP.IDEQUIPAMENTOCLIENTE= '+TipoCampoChaveToStr(CdsTemp.FieldByName('IDEQUIPAMENTOCLIENTE').Value);
      SetCds(CdsServicosOS,StrSQL);
      CdsServicosOS.First;
      while not CdsServicosOS.Eof do
      begin
        DataSetServicos.Append;
        DataSetServicos.FieldByName('IDPRODUTO').Value := CdsServicosOS.FieldByName('IDPRODUTO').Value;
        DataSetServicos.FieldByName('VALORSERVICO').Value := CdsServicosOS.FieldByName('VALORUNITARIO').Value;
        DataSetServicos.FieldByName('VALORTOTAL').Value := CdsServicosOS.FieldByName('SUBTOTAL').Value;
        DataSetServicos.FieldByName('CODIGOSERVICO').Value := CdsServicosOS.FieldByName('CODIGO').Value;
        DataSetServicos.FieldByName('DESCRICAOSERVICO').Value := CdsServicosOS.FieldByName('NOMEPRODUTO').Value;
        DataSetServicos.Post;
        CdsServicosOS.Next;
      end;


      DataSetEquipamentos.Post;
      CdsTemp.Next;
    end;


  Finally
    FreeAndNil(CdsTemp);
    FreeAndNil(CdsServicosOS);
  End;
end;

class function TRegrasOS.ReabrirOS(IdOS: String): Boolean;
begin
  Try
      Result := True;
      StartTrans;
      Exec_SQL('UPDATE OS SET '+
               '       FLAGBAIXADA= ''N'', '+
               '       DATATERMINO = null, '+
               '       HORATERMINO = null, '+
               '       IDSTATUSOS = '+TipoCampoChaveToStr(COnfiguracaoOS.GetConfiguracao(tpcERPStatusOSExecucao))+
               ' WHERE IDOS = '+TipoCampoChaveToStr(IDOS));
      Commit;
    except
      on e:Exception do
      begin
        Result := False;
        RollBack;
        raise;
      end;

    End;

end;

{ TRegrasAgenda }

class procedure TRegrasAgenda.BaixaCompromisso(IdAgenda: TipoCampoChave);
var
  StrSQL: String;
begin
  StrSQL :=
    'update agenda '+
    '   set flagbaixado = ''Y'' '+
    ' where idagenda = '+TipoCampoChaveToStr(IdAgenda);
  Try
    StartTrans;
    Exec_SQL(StrSQL);
    Commit;
  Except
    on E: Exception do
    begin
      RollBack();
      Raise;
    end;
  End;
end;

{ TRegrasContasReceber }

class function TRegrasContasReceber.CalculaAliqJuros(DataRecebimento,
  DataVencimento: TDate): Currency;
var
  Dias: Integer;
  JurosDia: Currency;
begin
  Result := 0;
  Dias :=  TRegrasContasReceber.DiasAtraso(DataRecebimento,DataVencimento);
  if Dias <= 0 then
    Exit;

  JurosDia := ConfiguracaoFinanceiro.GetConfiguracao(tpcERPAliqJurosDia);
  Result := JurosDia * Dias;

end;

class function TRegrasContasReceber.CalculaJuros(Valor: Currency;
  DataRecebimento, DataVencimento: TDate): Currency;
begin
  Result := (Valor * TRegrasContasReceber.CalculaAliqJuros(DataRecebimento, DataVencimento) )/ 100;
end;

class function TRegrasContasReceber.CalculaMora(Valor: Currency;
  DataRecebimento, DataVencimento: TDate): Currency;
var
  Dias: Integer;
  MoraDia,MoraMax,ValorMora: Currency;
begin
  Result := 0;
  Dias :=  TRegrasContasReceber.DiasAtraso(DataRecebimento, DataVencimento);
  if Dias <= 0 then
    Exit;

  MoraDia := ConfiguracaoFinanceiro.GetConfiguracao(tpcERPAliqMoraDia);
  MoraMax := ConfiguracaoFinanceiro.GetConfiguracao(tpcERPAliqMoraMax);

  MoraDia := MoraDia * Dias;
  if MoraDia > MoraMax then
    MoraDia := MoraMax;

  ValorMora := (Valor * MoraDia)/ 100;
  Result := ValorMora;

end;

class function TRegrasContasReceber.DiasAtraso(DataRecebimento,
  DataVencimento: TDate): SmallInt;
begin
  Result :=  DaysBetween(DataVencimento,DataRecebimento);
  if DataVencimento > DataRecebimento then
    Result := Result * -1;
end;

class function TRegrasContasReceber.GeraContaReceberDeSaida(IdSaida : TipoCampoChave;UsaTrancaoPropria: Boolean = False ): Boolean;
var
  StrSQL : String;
begin
  StrSQL :=
    'EXECUTE BLOCK AS'+
    '    DECLARE VARIABLE IDVENDA CHAVE;'+
    '    DECLARE VARIABLE DATA DATE;'+
    '    DECLARE VARIABLE IDEMPRESA CHAVE;'+
    '    DECLARE VARIABLE IDCLIENTE CHAVE;'+
    '    DECLARE VARIABLE NUMEROSAIDA VARCHAR(10);'+
    '    DECLARE VARIABLE IDUSUARIO CHAVE;'+
    '    DECLARE VARIABLE VALOR VALOR;'+
    '    DECLARE VARIABLE NUMTOTALPARCELAS INTEGER;'+
    '    DECLARE VARIABLE PARCELA INTEGER;'+
    '    DECLARE VARIABLE IDCONTARECEBER CHAVE;'+
    '    DECLARE VARIABLE VENCIMENTO DATE;'+
    '    DECLARE VARIABLE TIPOPAGAMENTO SMALLINT ;'+
    '    DECLARE VARIABLE STRPARCELA VARCHAR(7);'+
    '    DECLARE VARIABLE IDCONTABANCARIA CHAVE;'+
    '    DECLARE VARIABLE IDCONDICAOPAGAMENTO CHAVE;'+
    '    DECLARE VARIABLE SEQ INTEGER;'+
    '    DECLARE VARIABLE IDPLANOCONTA CHAVE;'+
    'BEGIN'+
    '  IDVENDA = '+TipoCampoChaveToStr(IdSaida)+';'+
    '  SEQ = 0;'+
    ''+
    '  FOR'+
    '      SELECT S.DATA,S.IDEMPRESA, S.IDCLIENTE,S.NUMEROSAIDA,S.IDUSUARIO,'+
    '             SC.VALOR, COALESCE(SC.NUMTOTALPARCELAS,1) NUMTOTALPARCELAS,'+
    '             CP.FLAGTIPOPAGAMENTO, CP.IDCONTABANCARIA,CP.IDCONDICAOPAGAMENTO,'+
    '             CASE WHEN S.IDOS IS NULL THEN (SELECT VALOR   FROM CONFIGURACOES WHERE NOMESECAO = ''FINANCEIRO'' AND NOMECONFIGURACAO = ''PLANOCONTASFATURAMENTODEOS'')'+
    '                  WHEN OS.IDCONTRATOCOMPETENCIA IS NOT NULL THEN (SELECT VALOR   FROM CONFIGURACOES WHERE NOMESECAO = ''FINANCEIRO'' AND NOMECONFIGURACAO = ''PLANOCONTASFATURAMENTOCONTRATO'')'+
    '                  WHEN OS.IDCONTRATOCOMPETENCIA IS NULL THEN (SELECT VALOR   FROM CONFIGURACOES WHERE NOMESECAO = ''FINANCEIRO'' AND NOMECONFIGURACAO = ''PLANOCONTASFATURAMENTODEOS'') END IDPLANOCONTAS'+
    '        FROM SAIDA S'+
    '       INNER JOIN SAIDACONDICAOPAGAMENTO SC'+
    '          ON (SC.IDSAIDA = S.IDSAIDA)'+
    '       INNER JOIN OPERACAOESTOQUE O'+
    '          ON (O.IDOPERACAOESTOQUE = S.IDOPERACAOESTOQUE)'+
    '       INNER JOIN CONDICAOPAGAMENTO CP'+
    '          ON (CP.IDCONDICAOPAGAMENTO = SC.IDCONDICAOPAGAMENTO)'+
    '        LEFT JOIN OS'+
    '          ON (OS.IDOS= S.IDOS)'+
    '       WHERE S.IDSAIDA = :IDVENDA'+
    '         AND COALESCE(O.FLAGGERAFINANCEIRO,''N'') = ''Y'''+
    '         AND CP.FLAGTIPOPAGAMENTO <> 5'+
    '        INTO :DATA, :IDEMPRESA,:IDCLIENTE,:NUMEROSAIDA,:IDUSUARIO,'+
    '             :VALOR, :NUMTOTALPARCELAS, :TIPOPAGAMENTO,:IDCONTABANCARIA,'+
    '             :IDCONDICAOPAGAMENTO, :IDPLANOCONTA'+
    '   DO'+
    '   BEGIN'+
    '     PARCELA = 1;'+
    ''+
    '     WHILE (PARCELA <= :NUMTOTALPARCELAS) DO'+
    '     BEGIN'+
    '        SEQ = :SEQ +1;'+
    '        SELECT RESULT'+
    '          FROM GERACHAVE(''SEQ_IDCONTARECEBER'')'+
    '          INTO :IDCONTARECEBER;'+
    ''+
    '       VENCIMENTO = DATEADD( :PARCELA MONTH TO :DATA);'+
    '       STRPARCELA = LPAD(:PARCELA,3,''0'')||''/''||LPAD(:NUMTOTALPARCELAS,3,''0'');'+
    ''+
    ''+
    ''+
    '       UPDATE OR  INSERT INTO CONTARECEBER (IDCONTARECEBER, DATAGERACAO, HORAGERACAO, NUMERODOCUMENTO, DATA, DATAVENCIMENTO, IDCLIENTE,'+
    '                           IDSAIDA, VALOR, VALORPAGO, FLAGSTATUS, IDPLANOCONTA, VALORJUROSTOTAL, VALORMORA,'+
    '                           VALORORIGINAL, ALIQJUROS, IDUSUARIO, IDUSUARIOCANCELAMENTO, DATACANCELAMENTO, IDEMPRESA, OBS,'+
    '                           DESCONTOFINANCEIRO, VALORRESTANTE, PARCELA, IDCONTABANCARIA, IDCONDICAOPAGAMENTO)'+
    '       VALUES (:IDCONTARECEBER, CURRENT_DATE, CURRENT_TIME, :NUMEROSAIDA||''-''||LPAD(:SEQ,3,''0''), :DATA,'+
    '               CASE WHEN :TIPOPAGAMENTO = 0 THEN :DATA ELSE :VENCIMENTO END , :IDCLIENTE, :IDVENDA,'+
    '                 :VALOR, CASE WHEN :TIPOPAGAMENTO = 0 THEN :VALOR ELSE NULL END , CASE WHEN :TIPOPAGAMENTO = 0 THEN ''F'' ELSE ''A'' END,'+
    '                 :IDPLANOCONTA, NULL, NULL, :VALOR, NULL,'+
    '                 :IDUSUARIO, NULL, NULL, :IDEMPRESA, NULL, NULL, NULL,'+
    '                 :STRPARCELA, :IDCONTABANCARIA, :IDCONDICAOPAGAMENTO) MATCHING(IDEMPRESA,NUMERODOCUMENTO, IDCLIENTE ) ;'+
    ''+
    '      IF (:TIPOPAGAMENTO = 0) THEN'+
    '      BEGIN'+
    '          DELETE FROM CONTARECEBERRECIMENTOS'+
    '           WHERE IDCONTARECEBER = :IDCONTARECEBER;'+
    ''+
    '          INSERT INTO CONTARECEBERRECIMENTOS (IDCONTARECEBERRECIMENTOS, IDCONTARECEBER, ALIQJUROS, VALORJUROS, VALORMORA,'+
    '                                                              VALORRECEBIDO, DATARECEBIDO, DESCONTOFINANCEIRO, IDUSUARIO)'+
    '                          VALUES ((SELECT RESULT FROM GERACHAVE(''SEQ_IDCONTARECEBERRECIMENTOS'')), :IDCONTARECEBER, NULL,'+
    '                                  NULL, NULL, :VALOR, :DATA,'+
    '                                  NULL, :IDUSUARIO) ;'+
    '      END'+
    ''+
    '       PARCELA = :PARCELA+ 1;'+
    ''+
    '     END'+
    ''+
    '   END  '+
    ''+
    'END';



  try
    Result := True;
    if UsaTrancaoPropria then
      StartTrans;
     Exec_SQL(StrSQL);
    if UsaTrancaoPropria then
     Commit();

  except
    on E: Exception do
    begin
      if UsaTrancaoPropria then
      begin
        RollBack;
      end;
      Result := False;
      raise;


    end;
  end;

end;

{ TRegrasPatrimonio }

class procedure TRegrasPatrimonio.GetListagemPatrimoniosAlerta(
  var CdsAlerta: TpFIBClientDataSet);
begin
  SetCds(CdsAlerta,tpERPAlertaPatrimonio,' (DATAALERTA >= DATEADD(-7 DAY TO CURRENT_DATE) ) '+
                                         ' AND (DATAALERTA <= DATEADD(7 DAY TO CURRENT_DATE))');
end;

class function TRegrasPatrimonio.VerificaPatrimonioPermitidoParaMovimentar(
  IdPatrimonio: TipoCampoChave;DataMov: TDate): Boolean;
var
  DataBloq: TDate;
begin
   Result := True;
   DataBloq := StrToDateDef(GetValorCds(tpERPAlertaPatrimonio,'idpatrimonio= '+TipoCampoChaveToStr(IdPatrimonio), 'DATALIMITE'),0);
   if DataBloq > 0 then
     Result := DataMov < DataBloq;


end;

{ TRegrasImpostos }

class function TRegrasImpostos.CalculaImpostos(IdCliente, IdProduto,
  IdCFOP,IdEmpresa: TipoCampoChave; CST: String ;CSOSN: String;
  ValorOperacao: Currency; Frete,Seguro,OutrasDespesas: Currency): IImpostos;
var
  DataSetEmpresa, DataSetCliente: TpFIBClientDataSet;
  ValorMinimoTributosFederais: Currency;
  ValorMinimoIR: Currency;
  Impostos: TImpostos;
  TipoProduto: String;
begin
  Impostos := Timpostos.Create;
  Try
    DataSetEmpresa := GetCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa));
    DataSetCliente := GetCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdCliente));

    TRegrasImpostos.GetAliqImpostos(IdCliente,IdProduto, DataSetEmpresa.FieldByName('uf').AsString,Impostos,
                                    ValorMinimoTributosFederais, ValorMinimoIR,TipoProduto);




    {$Region 'Calcula ISS'}
    if TipoProduto =TipoProdutoServico then
    begin
     Impostos.BaseISS := ValorOperacao;
     Impostos.ValorISS := (Impostos.BaseISS * Impostos.AliqISS )/100.00;
    end;
    {$EndRegion}

    {$Region 'Calcula CSLL'}
     if TipoProduto =TipoProdutoServico then
     begin
       if (DataSetCliente.FieldByName('FLAGTIPOPESSOA').AsString ='J') and
          (DataSetEmpresa.FieldByName('REGIMEEMPRESA').AsString <> RegimeEmpresaSimples) then
       begin
         Impostos.BaseCSLL := ValorOperacao;
         if ValorOperacao >= ValorMinimoTributosFederais then
           Impostos.ValorCSLL := (Impostos.BaseCSLL * Impostos.ALiqCSLL )/100.00
         else
           Impostos.ValorCSLL := 0 ;
       end;
     end;
    {$EndRegion}

    {$Region 'Calcula IR'}
     if (TipoProduto =TipoProdutoServico) and (DataSetCliente.FieldByName('FLAGTIPOPESSOA').AsString ='J' ) and
        (DataSetEmpresa.FieldByName('REGIMEEMPRESA').AsString <> RegimeEmpresaSimples) then
     begin
       Impostos.BaseIR := ValorOperacao;
       Impostos.ValorIR := (Impostos.BaseIR * Impostos.ALiqIR )/100.00;
       if ValorOperacao <= ValorMinimoIR then
         Impostos.ValorIR := 0 ;
     end;
    {$EndRegion}


    {$Region 'Calcula IPI'}
    if TipoProduto <> TipoProdutoServico then
    begin


    end;

    {$EndRegion}

    {$Region 'Calcula ICMS'}
    {$EndRegion}


    {$Region 'Calcula PIS/COFINS'}
     if TipoProduto = TipoProdutoServico then
     begin
       if (DataSetCliente.FieldByName('FLAGTIPOPESSOA').AsString ='J') and
          (DataSetEmpresa.FieldByName('REGIMEEMPRESA').AsString <> RegimeEmpresaSimples) then
       begin
         Impostos.BasePIS_COFINS := ValorOperacao;
         if ValorOperacao >= ValorMinimoTributosFederais then
         begin
           Impostos.ValorPIS := (Impostos.BasePIS_COFINS * Impostos.AliqPIS )/100.00;
           Impostos.ValorCOFINS := (Impostos.BasePIS_COFINS * Impostos.AliqCOFINS )/100.00;
         end else
         begin
           Impostos.ValorPIS := 0 ;
           Impostos.ValorCOFINS := 0 ;
         end;

       end;

     end;

    {$EndRegion}



    Result := Impostos;

  Finally
    FreeAndNil(DataSetEmpresa);
    FreeAndNil(DataSetCliente);
  End;
end;



class procedure TRegrasImpostos.GetAliqImpostos(IdCliente,IdProduto:TipoCampoChave; UFOrigem: String;
                                            Out Imposto: TImpostos;
                                            out ValorMinimoTributosFederais: Currency;
                                            out ValorMinimoIR: Currency;
                                            Out TipoProduto:String );
var
  StrSQL:String;
begin
  StrSQL :=
    'SELECT COALESCE(N.ALIQIPI, N.IPIVALOR) ALIQ_IPI,'+
    '       CASE WHEN (N.ALIQIPI IS NULL ) AND (N.IPIVALOR IS NOT NULL ) THEN ''V'''+
    '            ELSE ''A'' END TIPO_ALIQIPI,'+
    '       COALESCE(N.ALIQPIS,ISS.ALIQPIS) ALIQPIS, COALESCE(N.ALIQCOFINS,ISS.ALIQCOFINS) ALIQCOFINS, '+
    '       N.ALIQII, N.VALOR_LI, ISS.ALIQCSLL,ISS.ALIQIR,ISS.VALORMINIMOTRIBFEDERAL,ISS.VALORMINIMOIR,ISS.ALIQISS, '+
    '       COALESCE(N.ALIQICMS, ICMS.ALIQICMS) ALIQICMS,P.TIPOPRODUTO  '+
    '  FROM PRODUTO P'+
    '  LEFT JOIN NCMESTADO N'+
    '    ON (P.IDNCM = N.IDNCM)'+
    '  LEFT JOIN ISS '+
    '    ON (P.IDCODIGOMUNICIPALSERVICO = ISS.IDCODIGOMUNICIPALSERVICO) '+
    '  LEFT JOIN ICMS '+
    '    ON (ICMS.UFORIGEM ='+QuotedStr(UFOrigem)+' AND ICMS.UFDESTINO = N.UF) '+
    ' WHERE P.IDPRODUTO = '+TipoCampoChaveToStr(IdProduto)+
    '   AND EXISTS(SELECT 1'+
    '                FROM CLIENTE C'+
    '               WHERE C.IDCLIENTE = '+TipoCampoChaveToStr(IdCliente)+
    '                 AND ((C.UF = N.UF) OR (C.IDMUNICIPIO = ISS.IDMUNICIPIO)))';

  with GetCds(StrSQL) do
  begin
    Imposto.AliqPIS := FieldByName('ALIQPIS').AsCurrency;
    Imposto.AliqCOFINS := FieldByName('ALIQCOFINS').AsCurrency;
    Imposto.AliqIPI := FieldByName('ALIQ_IPI').AsCurrency;
    if FieldByName('TIPO_ALIQIPI').AsString = 'V' Then
      Imposto.TipoIPI := iIPIValor
    else
      Imposto.TipoIPI := iIPIAliq;

    Imposto.AliqCSLL := FieldByName('ALIQCSLL').AsCurrency;
    Imposto.ALiqIR := FieldByName('ALIQIR').AsCurrency;
    Imposto.AliqICMS := FieldByName('ALIQICMS').AsCurrency;
    Imposto.AliqISS := FieldByName('ALIQISS').AsCurrency;

    ValorMinimoTributosFederais := FieldByName('VALORMINIMOTRIBFEDERAL').AsCurrency;
    ValorMinimoIR := FieldByName('VALORMINIMOIR').AsCurrency;
    TipoProduto := FieldByName('TIPOPRODUTO').AsString;

    Free;
  end;
end;

class function TRegrasImpostos.GetCRT(IdEmpresa: TipoCampoChave; Data: TDate): String;
var
  DataSetEmpresa: TpFIBClientDataSet;
  Mes, Ano,Dia: Word;
  ReceitaAtual,LimiteFaturamento: Currency;
  StrSQL: String;
begin
  Try
    DataSetEmpresa := GetCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa));
    DecodeDate(Data,Ano,Mes,Dia);
    if DataSetEmpresa.FieldByName('regimeempresa').AsString <> RegimeEmpresaSimples then
    begin
      Result := '3';
      Exit;
    end;
    StrSQL := GetValorCds(tpERPLimiteReceitaBruta,'idempresa = '+TipoCampoChaveToStr(IdEmpresa)+' and ano = '+IntToStr(Ano),'Valor');
    LimiteFaturamento := StrToCurrDef(StrSQL,0);
    if LimiteFaturamento <= 0 then
      Result := '1'
    else
    begin
      StrSQL :=
        'SELECT SUM(VALOR_MES_ANO) VALOR '+
        '  FROM VW_RECEITA_BRUTA_MES_ANO '+
        ' WHERE IDEMPRESA =  '+TipoCampoChaveToStr(IdEmpresa)+
        '   AND ANO  = '+IntToStr(Ano);
      ReceitaAtual:= StrToCurrDef( GetValorCds(StrSQL) ,0);

      if LimiteFaturamento > ReceitaAtual then
        Result := '1'
      else
       Result := '2';
    end;

  Finally
    FreeAndNil(DataSetEmpresa);
  End;

end;

end.
