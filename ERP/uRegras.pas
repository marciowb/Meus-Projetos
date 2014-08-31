unit uRegras;

interface
  Uses MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet, StrUtils,ulibERP;
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


implementation

uses uConstantes, uConfiguracaoOS;

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
               '       HORATERMINO = null '+
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

end.
