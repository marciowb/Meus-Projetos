unit uRegras;

interface
  Uses MinhasClasses, uSQLERP,Comandos,Classes,SysUtils, Math,DB,pFIBClientDataSet,
       StrUtils,ulibERP, DateUtils,uDocumentoFiscal,Generics.Collections,uClassesERP,
       TypInfo;
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
      class function GetDataFinal(DataInicial: TDate;IdPeriodiciadade: TipoCampoChave): TDateTime;
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
      class function GetNumeroNota(TipoDocumento: TTipoDocumento; IdEmpresa:TipoCampoChave; Serie: String ): String;
      class function GetNumeroNotaDocumento(TipoDocumento: TTipoDocumento; IdEmpresa,IdSaida:TipoCampoChave; Serie: String ): String;
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
      class Procedure GetAliqImpostos(IdCliente,IdProduto, IdEmpresa:TipoCampoChave;UFOrigem: String;
                                            Out Imposto: TImpostos;
                                            out ValorMinimoTributosFederais: Currency;
                                            out ValorMinimoIR: Currency;
                                            Out TipoProduto:String;MsgSemConfiguracao: Boolean = True );
      class Function VerificaFormaTributacao(IdCFOP: TipoCampoChave;  CST: String; CSOSN: String): TFormaTributacao;
    public
      class function CalculaImpostos(IdCliente, IdProduto,IdCFOP, IdEmpresa: TipoCampoChave; CST: String; CSOSN: String;
                                     ValorOperacao: Currency; Frete,Seguro,OutrasDespesas: Currency;
                                     TipoFrete: TTipoFrete; DataOperacao: TDate): IImpostos;
      class function GetCRT(IdEmpresa: TipoCampoChave; Data: TDate): String;


   end;

   TRegrasDocumentos = class
     class Procedure CriaDocumentoFiscal(Const DataSetNota, DataSetItens, DataSetCobranca: TDataSet; Var Doc: IDocumentoFiscal );overload;
     class Procedure CriaDocumentoFiscal(Const IdDocumento: TipoCampoChave ; Var Doc: IDocumentoFiscal );overload;
     class Procedure CriaDocumentoFiscal(Const IdSaida: TipoCampoChave ; TipoDocumento: String; Var Doc: IDocumentoFiscal );overload;
     class procedure GravaDocumento(Doc: IDocumentoFiscal);
   end;

   TRegrasLotesDocumentosFiscais = class
     class procedure NovoLote;
     class procedure AtualizaStatusLote(IdLote: TipoCampoChave; StatusNFE,StatusNFSE: String);
     class procedure GeraDocumentosFiscais(IdLote:TipoCampoChave; NumeroLote: String; Out RespostaNFSe: TRetorno; Out RespostaNFe: TRetorno);
     class Procedure ProcessaLote(IdLote:TipoCampoChave; NumeroLote: String );
     class Procedure ImprimeNFSe(IdSaida: TipoCampoChave);
     class Procedure CancelaNFSe(IdSaida: TipoCampoChave; TipoCancelamento: TTipoCancelamento; Motivo: String);
   end;

   TRegrasCFOP = class
     class Procedure ObtemCFOP(Const IdOperacao,IdProduto,IdEmpresa,IdPessoa: TipoCampoChave;
                               Out IdCFOP: TipoCampoChave; out CST,CSOSN: String; const OperacaoParaCliente: Boolean = True);
   end;



implementation

uses uConstantes, uConfiguracaoOS, uConfiguracaoFinanceiro, uNFSe, uSQL;

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
      '   AND IDSAIDA = '+TipoCampoChaveToStr(IdVenda)+
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


class function TRegrasSaidaProduto.GetNumeroNota(
  TipoDocumento: TTipoDocumento; IdEmpresa:TipoCampoChave; Serie: String ): String;
var
  Flag, StrSQL: String;
begin
   if TipoDocumento =  tdNFSe  then
     Flag := NumeracaoNotaSaidaNFSe;
   if TipoDocumento =  tdNFe  then
     Flag := NumeracaoNotaSaidaNFe;

   Result := GetValorCds(tpERPNumeracaoNotaSaida,'idempresa = '+TipoCampoChaveToStr(IdEmpresa)+
                                                 ' and FLAGTIPODOCUMENTO = '+QuotedStr(Flag)+
                                                 ' and serie = '+QuotedStr(Serie),'NUMEROATUAL' );
   Result :=  FormatFloat('000000', StrToIntDef(Result,0)+1);
   StrSQL:=
     'UPDATE NUMERACAONOTASAIDA '+
     '   SET NUMEROATUAL = ' +QuotedStr(Result)+
     ' WHERE idempresa = '+TipoCampoChaveToStr(IdEmpresa)+
     '   and FLAGTIPODOCUMENTO = '+QuotedStr(Flag)+
     '   and serie = '+QuotedStr(Serie);
   try
     StartTrans();
     Exec_SQL(StrSQL);
     Commit();
   except
     on E: Exception do
     begin
       RollBack();
       Raise;
     end;
   end;

end;


class function TRegrasSaidaProduto.GetNumeroNotaDocumento(
  TipoDocumento: TTipoDocumento; IdEmpresa,IdSaida: TipoCampoChave;
  Serie: String): String;
var
  StrSQL, Flag: String;
begin
  if TipoDocumento =  tdNFSe  then
     Flag := NumeracaoNotaSaidaNFSe;
  if TipoDocumento =  tdNFe  then
     Flag := NumeracaoNotaSaidaNFe;
  StrSQL :=
     'SELECT FIRST 1 NUMERO '+
     '  FROM DOCUMENTO D '+
     ' WHERE IDSAIDA = '+TipoCampoChaveToStr(IdSaida)+
     '   AND TipoDocumento = '+ QuotedStr(Flag)+
     '   AND SERIE = '+QuotedStr(Serie)+
     '   AND COALESCE(FLAGCANCELADO,''N'') = ''N''  '+
     '   AND NOT EXISTS(SELECT 1 '+
     '                    FROM DOCUMENTO DD' +
     '                   WHERE DD.IDSAIDA = D.IDSAIDA ' +
     '                     AND DD.IDSAIDA = '+TipoCampoChaveToStr(IdSaida)+
     '                     AND DD.TipoDocumento = '+ QuotedStr(Flag)+
     '                     AND DD.SERIE = '+QuotedStr(Serie)+
     '                     AND DD.PROTOCOLO IS NOT  NULL )';

  Result := GetValorCds(StrSQL);
  if Result = '' then
    Result := TRegrasSaidaProduto.GetNumeroNota(TipoDocumento,IdEmpresa,Serie);
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
  ValorOperacao: Currency; Frete,Seguro,OutrasDespesas: Currency; TipoFrete: TTipoFrete; DataOperacao: TDate): IImpostos;
var
  DataSetEmpresa, DataSetCliente,DataSetCFOP: TpFIBClientDataSet;
  ValorMinimoTributosFederais: Currency;
  ValorMinimoIR,Despesas, ValorVendas: Currency;
  Impostos: TImpostos;
  TipoProduto, StrSQL: String;
  DataIni, DataFim: TDate;
  FormaTributar: TFormaTributacao;
begin
  Impostos := Timpostos.Create;
  Try
    DataSetEmpresa := GetCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa));
    DataSetCliente := GetCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdCliente));
    DataSetCFOP     := GetCds(tpERPCFOP,'idcfop = '+TipoCampoChaveToStr(IdCFOP));

    TRegrasImpostos.GetAliqImpostos(IdCliente,IdProduto,IdEmpresa, DataSetEmpresa.FieldByName('uf').AsString,Impostos,
                                    ValorMinimoTributosFederais, ValorMinimoIR,TipoProduto);





    FormaTributar := TRegrasImpostos.VerificaFormaTributacao(IdCFOP,CST,CSOSN);

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
      if FormaTributar.TributaIPI then
      begin
        if (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaDentroEstado) or
           (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaForaEstado) or
           (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoExportacao)  then
        begin
          if TipoFrete = tfEmitente then
            Despesas := 0
          else
            Despesas := Frete;
          Impostos.BaseIPI := ValorOperacao+Despesas;
          Impostos.ValorIPI := Impostos.BaseIPI * Impostos.AliqIPI /100;
        end;
      end;

    end;

    {$EndRegion}

    {$Region 'Calcula ICMS'}

     if TipoProduto <> TipoProdutoServico then
    begin
      Impostos.TipoTributacaoICMS := FormaTributar.TipoTributacaoICMS;

      if FormaTributar.TipoTributacaoICMS <> ttICMSNaoTributado then
      begin
        if (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaDentroEstado) or
           (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaForaEstado) or
           (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoExportacao)  then
        begin
          if TipoFrete = tfEmitente then
           Despesas := 0
          else
           Despesas := Frete;

          Despesas := Despesas + OutrasDespesas+Seguro;

          Impostos.BaseICMS := ValorOperacao+Despesas;

          if (DataSetCliente.FieldByName('flagtipopessoa').AsString = 'J') and
             (FormaTributar.TributaIPI ) then
            Impostos.BaseICMS := Impostos.BaseICMS + Impostos.ValorIPI;

          if FormaTributar.ReduzBaseICMS   then
            Impostos.BaseICMS := Impostos.BaseICMS  - ((Impostos.BaseICMS * Impostos.AliqReducaoBaseICMS)/100);

          Impostos.ValorICMS := Impostos.BaseICMS * Impostos.AliqICMS /100;
        end;
      end;

    end;

    {$EndRegion}

    {$Region 'ICMS ST'}
     if TipoProduto <> TipoProdutoServico then
     begin
        if FormaTributar.TributaST then
        begin
          if (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaDentroEstado) or
             (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaForaEstado) or
             (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoExportacao)  then
          begin
            { TODO : fazer }
          end;
        end;
     end;


    {$EndRegion}


    {$Region 'Calcula PIS/COFINS'}
     if TipoProduto = TipoProdutoServico then
     begin
       if (DataSetCliente.FieldByName('FLAGTIPOPESSOA').AsString ='J') and
          (DataSetEmpresa.FieldByName('REGIMEEMPRESA').AsString <> RegimeEmpresaSimples) then
       begin
         Impostos.BasePIS_COFINS := ValorOperacao;
         DataIni := FirstDay(DataOperacao);
         if DataOperacao < StrToDate(GetDataServidor) then
           DataFim := DataOperacao
         else
           DataFim := LastDay(DataOperacao);
         StrSQL :=
           'SELECT SUM(VALORTOTAL) VALORTOTAL '+
           '  FROM SAIDAPRODUTO SP '+
           ' WHERE EXISTS(SELECT 1' +
           '                FROM SAIDA S' +
           '               WHERE S.IDSAIDA  = SP. IDSAIDA '+
           '                 AND DATA >= '+GetData(DataIni)+' and DATA <= '+GetData(DataFim)+
           '                 AND S.IDCLIENTE= '+TipoCampoChaveToStr(IdCliente)+')'+
           '   AND TIPOPRODUTO = '+QuotedStr(TipoProdutoServico);
         ValorVendas := StrToCurrDef(GetValorCds(StrSQL),0);
         ValorVendas := ValorVendas + ValorOperacao;

         if ValorVendas >= ValorMinimoTributosFederais then
         begin
           Impostos.ValorPIS := (Impostos.BasePIS_COFINS * Impostos.AliqPIS )/100.00;
           Impostos.ValorCOFINS := (Impostos.BasePIS_COFINS * Impostos.AliqCOFINS )/100.00;
         end else
         begin
           Impostos.ValorPIS := 0 ;
           Impostos.ValorCOFINS := 0 ;
         end;

       end;

     end ELSE
     begin
        if TipoProduto <> TipoProdutoServico then
        begin
          if FormaTributar.TributaPIS_COFINS then
          begin
            if (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaDentroEstado) or
               (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoSaidaForaEstado) or
               (DataSetCFOP.FieldByName('FLAGTIPOOPERACAO').AsString = CFOPTipoOperacaoExportacao)  then
            begin
              if TipoFrete = tfEmitente then
                Despesas := 0
              else
                Despesas := Frete;

              Despesas := Despesas + OutrasDespesas+Seguro;
              if DataSetCFOP.FieldByName('CST_PIS_COFINS').AsString = CST_PIS_COFINS_Operacao_Tributavel_a_Aliquota_Zero then
              begin
                Impostos.AliqPIS := 0;
                Impostos.AliqCOFINS := 0;
              end else
              if DataSetCFOP.FieldByName('CST_PIS_COFINS').AsString = CST_PIS_COFINS_Operacao_Isenta_da_Contribuicao then
              begin
                Impostos.ValorCOFINS := 0;
                Impostos.ValorPIS := 0;
              end else
              begin
                Impostos.BasePIS_COFINS := ValorOperacao+Despesas+Impostos.ValorIPI+Impostos.ValorICMSST;
                Impostos.ValorPIS := Impostos.BasePIS_COFINS* Impostos.AliqPIS /100;
                Impostos.ValorCOFINS := Impostos.BasePIS_COFINS* Impostos.AliqCOFINS /100;
              end;

            end;
          end;
        end;


     end;


    {$EndRegion}


    Result := Impostos;

  Finally
    FreeAndNil(DataSetEmpresa);
    FreeAndNil(DataSetCliente);
    FreeAndNil(DataSetCFOP);
  End;
end;



class procedure TRegrasImpostos.GetAliqImpostos(IdCliente,IdProduto, IdEmpresa:TipoCampoChave; UFOrigem: String;
                                            Out Imposto: TImpostos;
                                            out ValorMinimoTributosFederais: Currency;
                                            out ValorMinimoIR: Currency;
                                            Out TipoProduto:String;MsgSemConfiguracao: Boolean = True );
var
  StrSQL, IdMunicipio,UF,
  NomeMunicipio, CodigoCliente, NomeCliente:String;
begin
  with GetCds(tpERPCliente, 'IDCLIENTE = '+TipoCampoChaveToStr(IdCliente)) do
  begin
    Uf := FieldByName('UF').AsString;
    IdMunicipio := FieldByName('IdMunicipio').AsString;
    NomeMunicipio := FieldByName('MUNICIPIO').AsString;
    CodigoCliente := FieldByName('codigo').AsString;
    NomeCliente := FieldByName('NOMECLIENTE').AsString;
    Free;
  end;
  StrSQL :=
    'SELECT COALESCE(N.ALIQIPI, N.IPIVALOR) ALIQ_IPI,'+
    '       CASE WHEN (N.ALIQIPI IS NULL ) AND (N.IPIVALOR IS NOT NULL ) THEN ''V'''+
    '            ELSE ''A'' END TIPO_ALIQIPI, NCM.CODIGO NCM, '+
    '       COALESCE(COALESCE(N.ALIQPIS,ISS.ALIQPIS),E.ALIQPIS) ALIQPIS, COALESCE(COALESCE(N.ALIQCOFINS,ISS.ALIQCOFINS),E.ALIQPIS) ALIQCOFINS, '+
    '       N.ALIQII, N.VALOR_LI, COALESCE(ISS.ALIQCSLL,E.ALIQCSLL)ALIQCSLL, COALESCE(ISS.ALIQIR,E.ALIQIR)ALIQIR, ISS.VALORMINIMOTRIBFEDERAL,ISS.VALORMINIMOIR,ISS.ALIQISS, '+
    '       COALESCE(N.ALIQICMS, ICMS.ALIQICMS) ALIQICMS,P.TIPOPRODUTO,COALESCE(N.ALIQREDUCAOBASEICMS,0)ALIQREDUCAOBASEICMS  '+
    '  FROM PRODUTO P'+
    '  LEFT JOIN NCMESTADO N'+
    '    ON (P.IDNCM = N.IDNCM and N.UF = '+QuotedStr(UF)+')'+
    '  LEFT JOIN NCM '+
    '    ON (NCM.IDNCM = P.IDNCM) '+
    '  LEFT JOIN ISS '+
    '    ON (P.IDCODIGOMUNICIPALSERVICO = ISS.IDCODIGOMUNICIPALSERVICO AND ISS.IDMUNICIPIO = '+TipoCampoChaveToStr(IdMunicipio)+') '+
    '  LEFT JOIN ICMS '+
    '    ON (ICMS.UFORIGEM ='+QuotedStr(UFOrigem)+' AND ICMS.UFDESTINO = N.UF) '+
    '  LEFT JOIN EMPRESA E '+
    '    ON (E.IDEMPRESA = '+TipoCampoChaveToStr(IdEmpresa)+') '+
    ' WHERE P.IDPRODUTO = '+TipoCampoChaveToStr(IdProduto);

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
    Imposto.AliqReducaoBaseICMS := FieldByName('ALIQREDUCAOBASEICMS').AsCurrency;

    ValorMinimoTributosFederais := FieldByName('VALORMINIMOTRIBFEDERAL').AsCurrency;
    ValorMinimoIR := FieldByName('VALORMINIMOIR').AsCurrency;
    TipoProduto := FieldByName('TIPOPRODUTO').AsString;


    if MsgSemConfiguracao then
    begin
      if (FieldByName('ALIQISS').IsNull) and (FieldByName('ALIQICMS').IsNull)  then
      begin
        if TipoProduto = TipoProdutoServico then
        begin
           Avisa('Não foi encontrado configuração de calculo de ISS para o cliente '+CodigoCliente+'-'+NomeCliente+'.'+sLineBreak+
                 ' Por favor configurar em: Menu Cadastros => Fiscal=> ISS . Para o município: '+NomeMunicipio+'('+UF+')' );

        end else
        begin
           Avisa('Não foi encontrado configuração de calculo de ICMS para o cliente '+CodigoCliente+'-'+NomeCliente+'.'+sLineBreak+
                 ' Por favor configurar em: Menu Cadastros => Fiscal=> ICMS . Para os estados: '+UFOrigem+' X '+UF+
                 '. Verifique também o cadastro do NCM '+FieldByName('NCM').AsString+' para o estado '+UF  );

        end;

      end;

    end;

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

class function TRegrasImpostos.VerificaFormaTributacao(IdCFOP: TipoCampoChave;
  CST, CSOSN: String): TFormaTributacao;
var
  DataSetCFOP, DataSetCST, DataSetCSOSN: TpFIBClientDataSet;
  UsaCST: Boolean;
begin
  Try
    DataSetCFOP := TpFIBClientDataSet.Create(nil);
    DataSetCST := TpFIBClientDataSet.Create(nil);
    DataSetCSOSN := TpFIBClientDataSet.Create(nil);
    DataSetCFOP := GetCds(tpERPCFOP, 'idCFOP = '+TipoCampoChaveToStr(IdCFOP));
    DataSetCST := GetCds(tpERPCST, 'CST = '+QuotedStr(CST));
    DataSetCSOSN := GetCds(tpERPCSOSN, 'CSOSN = '+QuotedStr(CSOSN));

    UsaCST:= CST<> '';
    Result.TributaIPI := DataSetCFOP.FieldByName('flagtributaIPI').AsString = 'Y';
    Result.TributaPIS_COFINS := DataSetCFOP.FieldByName('FLAGTRIBUTAPIS_COFINS').AsString = 'Y';
    Result.TributaST := DataSetCFOP.FieldByName('FLAGTRIBUTAST').AsString = 'Y';
    if DataSetCFOP.FieldByName('FLAGTRIBUTAICMS').AsString = 'N' then
        Result.TipoTributacaoICMS := ttICMSNaoTributado
    else
    begin
      if UsaCST then
      begin
        if DataSetCST.FieldByName('TIPO_TRIBUTACAO_ICMS').AsString = 'N' then
          Result.TipoTributacaoICMS := ttICMSNaoTributado
        else
        if DataSetCST.FieldByName('TIPO_TRIBUTACAO_ICMS').AsString = 'T' then
          Result.TipoTributacaoICMS := ttICMSTributado
        else
        if DataSetCST.FieldByName('TIPO_TRIBUTACAO_ICMS').AsString = 'I' then
          Result.TipoTributacaoICMS := ttICMSISento;

        Result.ReduzBaseICMS :=  DataSetCST.FieldByName('REDUZ_BASE_ICMS').AsString = 'Y' ;

        if Result.TributaST  then
          Result.TributaST :=  DataSetCST.FieldByName('TRIBUTA_ST').AsString = 'Y' ;

      end else
      begin
        if DataSetCSOSN.FieldByName('TIPO_TRIBUTACAO_ICMS').AsString = 'N' then
          Result.TipoTributacaoICMS := ttICMSNaoTributado
        else
        if DataSetCSOSN.FieldByName('TIPO_TRIBUTACAO_ICMS').AsString = 'T' then
          Result.TipoTributacaoICMS := ttICMSTributado
        else
        if DataSetCSOSN.FieldByName('TIPO_TRIBUTACAO_ICMS').AsString = 'I' then
          Result.TipoTributacaoICMS := ttICMSISento;

        Result.ReduzBaseICMS :=  DataSetCSOSN.FieldByName('REDUZ_BASE_ICMS').AsString = 'Y' ;

        if Result.TributaST  then
          Result.TributaST :=  DataSetCSOSN.FieldByName('TRIBUTA_ST').AsString = 'Y' ;

      end;

    end;


  Finally
    FreeAndNil(DataSetCFOP);
    FreeAndNil(DataSetCST);
    FreeAndNil(DataSetCSOSN);
  End;
end;

{ TRegrasLotesDocumentosFiscais }

class procedure TRegrasLotesDocumentosFiscais.AtualizaStatusLote(
  IdLote: TipoCampoChave;StatusNFE,StatusNFSE: String);
var
  StrSQL:String;
begin
  Try
    StartTrans();
    StrSQL :=
        'UPDATE '+GetTabela(tpERPLotesNota)+
        '   SET FLAGSTATUSNFE = '+QuotedStr( StatusNFE)+','+
        '       MSGERRONFE = null,'+
        '       DATAHORARESPOSTANFE = null ,'+
        '       FLAGSTATUSNFSE = '+QuotedStr(StatusNFSE)+','+
        '       MSGERRONFSE = null, '+
        '       DATAHORARESPOSTANFSE = null'+
        ' WHERE '+GetCampoChave(tpERPLotesNota)+' = '+TipoCampoChaveToStr(IdLote);
    Exec_SQL(StrSQL);
    Commit();
  Except
    on e: Exception do
    begin
      RollBack();
      Raise;
    end;
  End;

end;

class procedure TRegrasLotesDocumentosFiscais.CancelaNFSe(
  IdSaida: TipoCampoChave; TipoCancelamento: TTipoCancelamento; Motivo: String);
var
  StrSQL: String;
  Nfse : TNFSe;
  Doc: IDocumentoFiscal;
  DocsNFSe: TList<IDocumentoFiscal>;
  DataSetNota, DataSetItens, DataSetCobranca: TpFIBClientDataSet;
begin
  Try
    DocsNFSe := TList<IDocumentoFiscal>.Create;
    DataSetNota := TpFIBClientDataSet.Create(nil);
    DataSetItens := TpFIBClientDataSet.Create(nil);
    DataSetCobranca := TpFIBClientDataSet.Create(nil);

    SetCds(DataSetNota,tpERPSaida,'idsaida = '+TipoCampoChaveToStr(IdSaida));
    SetCds(DataSetItens,tpERPSaidaProduto,'idsaida = '+TipoCampoChaveToStr(IdSaida));
    SetCds(DataSetCobranca,tpERPSaidaCondicaoPagamento,'idsaida = '+TipoCampoChaveToStr(IdSaida));
    TRegrasDocumentos.CriaDocumentoFiscal(DataSetNota,DataSetItens,DataSetCobranca, Doc);
    DocsNFSe.Add(Doc);
    StrSQL:=
      'SELECT FIRST 1  D.PROTOCOLO, D.LOTE,D.SERIE , D.NUMERO'+
      '  FROM DOCUMENTO D '+
      '  WHERE D.IDSAIDA = '+TipoCampoChaveToStr(IdSaida)+
      '    AND D.TIPODOCUMENTO = '+QuotedStr(NumeracaoNotaSaidaNFSe)+
      '  ORDER BY D.REVISAO DESC ';

    WITH GetCds(StrSQL) do
    begin
      DocsNFSe[0].NumeroNota := FieldByName('NUMERO').AsString;
      DocsNFSe[0].SerieNota := FieldByName('SERIE').AsString;

      Nfse := TNFSe.Create(DocsNFSe,FieldByName('LOTE').AsString);
      with NFSe.CancelarNota(FieldByName('PROTOCOLO').AsString, TipoCancelamento) do
      begin
        if not Erro then
        begin
          Doc.TipoCancelamento := TipoCancelamento;
          Doc.MotivoCancelamento := Motivo;
          Doc.Cancecelado := True;
          TRegrasDocumentos.GravaDocumento(Doc);
        end else
          AvisaErro(Mensagem);
      end;

      Free;
    end;



  Finally
    FreeAndNil(Nfse);
    FreeAndNil(DataSetNota);
    FreeAndNil(DataSetItens);
    FreeAndNil(DataSetCobranca);
    FreeAndNil(DocsNFSe);
    if Assigned(Doc) then
      Doc._Release;
  End;
end;

class procedure TRegrasLotesDocumentosFiscais.GeraDocumentosFiscais(
  IdLote: TipoCampoChave; NumeroLote: String; Out RespostaNFSe: TRetorno; Out RespostaNFe: TRetorno);
var
  Doc: IDocumentoFiscal;
  DocsNFe, DocsNFSe: TList<IDocumentoFiscal>;
  TipoDocumento: TTiposDocumento;
  FlagDoc: Integer;
  Nfse: TNFSe;
  DataSetNota, DataSetItens, DataSetCobranca: TpFIBClientDataSet;
  I: Integer;
begin
  Try
    DocsNFe := TList<IDocumentoFiscal>.Create;
    DocsNFSe := TList<IDocumentoFiscal>.Create;
    DataSetNota := TpFIBClientDataSet.Create(nil);
    DataSetItens := TpFIBClientDataSet.Create(nil);
    DataSetCobranca := TpFIBClientDataSet.Create(nil);
    TRegrasLotesDocumentosFiscais.AtualizaStatusLote(IdLote,StatusLoteDocumentosFiscaisIniciado,StatusLoteDocumentosFiscaisIniciado);
    with GetCds(tpERPItensLotesNota,'idlotedocumento = '+TipoCampoChaveToStr(IdLote)+' and FLAGSTATUS <> '+QuotedStr(StatusItemLoteDocumentosFiscaisSucesso)) do
    begin
      First;
      while not Eof do
      begin
        SetCds(DataSetNota,tpERPSaida,'idsaida = '+TipoCampoChaveToStr(FieldByName('idsaida').AsString));
        SetCds(DataSetItens,tpERPSaidaProduto,'idsaida = '+TipoCampoChaveToStr(FieldByName('idsaida').AsString));
        SetCds(DataSetCobranca,tpERPSaidaCondicaoPagamento,'idsaida = '+TipoCampoChaveToStr(FieldByName('idsaida').AsString));



        FlagDoc := StrToIntDef(GetValorCds(tpERPOperacao,'idoperacaoestoque = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idoperacaoestoque').Value),'FLAGDOCUMENTO'),OPeracaoestoqueDocumentoNada) ;
        TipoDocumento := [];
        if (FlagDoc = OPeracaoestoqueDocumentoNFe)or (FlagDoc = OPeracaoestoqueDocumentoNFSeNfe) then
          TipoDocumento := TipoDocumento + [tdNFe];
        if (FlagDoc = OPeracaoestoqueDocumentoNFSe)or (FlagDoc = OPeracaoestoqueDocumentoNFSeNfe) then
          TipoDocumento := TipoDocumento + [tdNFSe];
        if (FlagDoc = OPeracaoestoqueDocumentoComprovante) then
          TipoDocumento := TipoDocumento + [tdComprovante];

        if tdNFSe in TipoDocumento then
        begin
          TRegrasDocumentos.CriaDocumentoFiscal(DataSetNota,DataSetItens,DataSetCobranca, Doc);
          Doc.IdSaida := FieldByName('idsaida').AsString  ;
          Doc.IdEmpresa := DataSetNota.FieldByName('idempresa').AsString  ;

          Doc.SerieNota := DataSetNota.FieldByName('SerieNFSE').AsString;
          Doc.NumeroNota := TRegrasSaidaProduto.GetNumeroNotaDocumento(tdNFSe,DataSetNota.FieldByName('idempresa').AsString,DataSetNota.FieldByName('idsaida').AsString,Doc.SerieNota);
          Doc.TipoDocumento := tdNFSe;
          if GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idempresa').AsString),'ambientenfse')= 'P' then
            Doc.TipoAmbiente := tabProducao
          else
            Doc.TipoAmbiente := tabHomologacao ;
          DocsNFSe.Add(Doc);
          TRegrasDocumentos.GravaDocumento(Doc);
        end;

         if tdNFe in TipoDocumento then
        begin
          TRegrasDocumentos.CriaDocumentoFiscal(DataSetNota,DataSetItens,DataSetCobranca, Doc);
          Doc.IdSaida := FieldByName('idsaida').AsString  ;
          Doc.IdEmpresa := DataSetNota.FieldByName('idempresa').AsString  ;

          Doc.SerieNota := DataSetNota.FieldByName('SerieNFE').AsString;
          Doc.NumeroNota := TRegrasSaidaProduto.GetNumeroNotaDocumento(tdNFe,DataSetNota.FieldByName('idempresa').AsString,DataSetNota.FieldByName('idsaida').AsString, Doc.SerieNota);
          Doc.TipoDocumento := tdNFe;
          if GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idempresa').AsString),'ambientenfe')= 'P' then
            Doc.TipoAmbiente := tabProducao
          else
            Doc.TipoAmbiente := tabHomologacao ;

          DocsNFe.Add(Doc);
          TRegrasDocumentos.GravaDocumento(Doc);

        end;


        Next;
      end;


      Free;
    end;
    if DocsNFSe.Count > 0 then
    begin
      Try
        TRegrasLotesDocumentosFiscais.AtualizaStatusLote(IdLote,StatusLoteDocumentosFiscaisIniciado,StatusLoteDocumentosFiscaisEnviado);
        Nfse := TNFSe.Create(DocsNFSe,NumeroLote);
        RespostaNFSe := Nfse.Enviar;
        if not RespostaNFSe.Erro then
        begin
          for I := 0 to DocsNFSe.Count - 1 do
          begin
            DocsNFSe.Items[i].LoteSistema := NumeroLote;
            DocsNFSe.Items[i].Protocolo := Nfse.Protocolo;
            DocsNFSe.Items[i].ChaveAcesso := Nfse.DocumentosProcessados[i].ChaveAcesso;
            DocsNFSe.Items[i].XML := Nfse.DocumentosProcessados[i].XML;
            TRegrasDocumentos.GravaDocumento(DocsNFSe.Items[i]);
          end;

        end;
      Finally
        FreeAndNil(Nfse);
      End;
    end;

    if DocsNFe.Count > 0 then
    begin
      TRegrasLotesDocumentosFiscais.AtualizaStatusLote(IdLote,StatusLoteDocumentosFiscaisEnviado,StatusLoteDocumentosFiscaisEnviado);
//      Try
//        Nfse := TNFSe.Create(DocsNFSe);
//        RespostaNFe := Nfse.Enviar;
//      Finally
//        FreeAndNil(Nfse);
//      End;
    end;


  Finally
    FreeAndNil(DataSetNota);
    FreeAndNil(DataSetItens);
    FreeAndNil(DataSetCobranca);
    FreeAndNil(DocsNFe);
    FreeAndNil(DocsNFSe);
    if Assigned(Doc) then
      Doc._Release;
  End;
end;

class procedure TRegrasDocumentos.GravaDocumento(
  Doc: IDocumentoFiscal);
var
  StrSQL, ID: String;
  I: Integer;
begin
  ID := GetValorCds('select result from gerachave(''seq_IDDOCUMENTO'')');
  Try
    StartTrans;
    {$Region 'Documento'}
    StrSQL :=
      'INSERT INTO DOCUMENTO (IDDOCUMENTO, '+
      '                       DATANOTA, '+
      '                       HORANOTA, '+
      '                       REVISAO, '+
      '                       SERIE, '+
      '                       NUMERO, '+
      '                       NOMEEMITENTE, '+
      '                       NOMEFANTASIAEMITENTE, '+
      '                       CNPJ_CPFEMITENTE, '+
      '                       TELEFONEEMITENTE, '+
      '                       IEEMITENTE, '+
      '                       IE_STEMITENTE, '+
      '                       SUFRAMAEMITENTE, '+
      '                       IDENDIFICACAOSUFRAMAEMITENTE, '+
      '                       IMEMITENTE, '+
      '                       CNAEEMITENTE, '+
      '                       CRTEMITENTE, '+
      '                       ENDERECOEMITENTE, '+
      '                       NUMEROEMITENTE, '+
      '                       COMPLEMENTOEMITENTE, '+
      '                       CEPEMITENTE, '+
      '                       BAIRROEMITENTE, '+
      '                       CIDADEEMITENTE, '+
      '                       UFEMITENTE, '+
      '                       CODIGOIBGEEMITENTE, '+
      '                       NOMEDESTINATARIO, '+
      '                       NOMEFANTASIADESTINATARIO, '+
      '                       CNPJ_CPFDESTINATARIO, '+
      '                       TELEFONEDESTINATARIO, '+
      '                       IEDESTINATARIO, '+
      '                       IE_STDESTINATARIO, '+
      '                       SUFRAMADESTINATARIO, '+
      '                       IDENDIFICACAOSUFRAMADEST, '+
      '                       IMDESTINATARIO, '+
      '                       CNAEDESTINATARIO, '+
      '                       CRTDESTINATARIO, '+
      '                       ENDERECODESTINATARIO, '+
      '                       NUMERODESTINATARIO, '+
      '                       COMPLEMENTODEST, '+
      '                       CEPDESTINATARIO, '+
      '                       BAIRRODESTINATARIO, '+
      '                       CIDADEDESTINATARIO, '+
      '                       UFDESTINATARIO, '+
      '                       CODIGOIBGEDEST, '+
      '                       TOTALPRODUTOS, '+
      '                       TOTALSERVICOS, '+
      '                       BASEICMS, '+
      '                       BASEISS ,   '+
      '                       BASEIPI   ,   '+
      '                       BASEPIS_COFINS , '+
      '                       BASEICMSST ,      '+
      '                       BASECSLL ,'+
      '                       BASEIR ,    '+
      '                       VALORICMS ,   '+
      '                       VALORISS ,      '+
      '                       VALORIPI ,      '+
      '                       VALORPIS ,        '+
      '                       VALORCOFINS ,   '+
      '                       VALORICMSST ,   '+
      '                       VALORCSLL ,     '+
      '                       VALORIR ,       '+
      '                       SEGURO, '+
      '                       FRETE, '+
      '                       OUTRASDESPESAS, '+
      '                       TOTALDOCUMENTO, '+
      '                       TIPOFRETE, '+
      '                       TIPOTRANSPORTE, '+
      '                       PLACA, '+
      '                       UFPLACA, '+
      '                       ANTT, '+
      '                       VOLUME, '+
      '                       ESPECIE, '+
      '                       MARCA, '+
      '                       PESOLIQ, '+
      '                       PESOBRUTO, '+
      '                       XMLDOCUMENTO, '+
      '                       DATAGERACAO, '+
      '                       HORAGERACAO, '+
      '                       IDSAIDA, '+
      '                       TIPODOCUMENTO, '+
      '                       IDENTRADA,'+
      '                       IDEMPRESA,  '+
      '                       PROTOCOLO,'+
      '                       CHAVEACESSO,'+
      '                       LOTE,' +
      '                       XML,'+
      '                       FLAGCANCELADO,'+
      '                       TIPOCANCELAMENTO,'+
      '                       MOTIVOCANCELAMENTO,'+
      '                       DATAHORACANCELAMENTO      ) '+
      'VALUES ( '+QuotedStr(Id)+','+
                GetData(Doc.DataNota)+','+
                'current_time,'+ //Hora Nota
      '        (select coalesce(max(revisao),0)+1 '+
      '           from documento '+
      '          where (idsaida = '+QuotedStr(Doc.IdSaida)+') or (identrada = '+QuotedStr(Doc.IdEntrada)+') '+
      '            and  TIPODOCUMENTO = '+ GetStr(IfThen(Doc.TipoDocumento = tdNFSe, NumeracaoNotaSaidaNFSe,
                         IfThen(Doc.TipoDocumento = tdNFe, NumeracaoNotaSaidaNFe,'C')))+' ), '+
               GetStr(Doc.SerieNota)+','+
               GetStr(Doc.NumeroNota)+','+
               GetStr(Doc.Emitente.Nome_RazaoSocial)+','+
               GetStr(Doc.Emitente.NomeFantasia)+','+
               GetStr(Doc.Emitente.CPF_CNPJ)+','+
               GetStr(Doc.Emitente.Telefone)+','+
               GetStr(Doc.Emitente.IE)+','+
               GetStr(Doc.Emitente.IE_ST)+','+
               GetStr(Doc.Emitente.SUFRAMA)+','+
               GetStr(Doc.Emitente.IdentificacaoSUFRAMA)+','+
               GetStr(Doc.Emitente.IM)+','+
               GetStr(Doc.Emitente.CNAE)+','+
               GetStr(Doc.Emitente.CRT)+','+
               GetStr(Doc.Emitente.Endereco.Endereco)+','+
               GetStr(Doc.Emitente.Endereco.NumeroEndereco)+','+
               GetStr(Doc.Emitente.Endereco.Complemento)+','+
               GetStr(Doc.Emitente.Endereco.CEP)+','+
               GetStr(Doc.Emitente.Endereco.Bairro)+','+
               GetStr(Doc.Emitente.Endereco.Cidade)+','+
               GetStr(Doc.Emitente.Endereco.Estado)+','+
               GetStr(Doc.Emitente.Endereco.CodigoMunicipio)+','+
               GetStr(Doc.Destinatario.Nome_RazaoSocial)+','+
               GetStr(Doc.Destinatario.NomeFantasia)+','+
               GetStr(Doc.Destinatario.CPF_CNPJ)+','+
               GetStr(Doc.Destinatario.Telefone)+','+
               GetStr(Doc.Destinatario.IE)+','+
               GetStr(Doc.Destinatario.IE_ST)+','+
               GetStr(Doc.Destinatario.SUFRAMA)+','+
               GetStr(Doc.Destinatario.IdentificacaoSUFRAMA)+','+
               GetStr(Doc.Destinatario.IM)+','+
               GetStr(Doc.Destinatario.CNAE)+','+
               GetStr(Doc.Destinatario.CRT)+','+
               GetStr(Doc.Destinatario.Endereco.Endereco)+','+
               GetStr(Doc.Destinatario.Endereco.NumeroEndereco)+','+
               GetStr(Doc.Destinatario.Endereco.Complemento)+','+
               GetStr(Doc.Destinatario.Endereco.CEP)+','+
               GetStr(Doc.Destinatario.Endereco.Bairro)+','+
               GetStr(Doc.Destinatario.Endereco.Cidade)+','+
               GetStr(Doc.Destinatario.Endereco.Estado)+','+
               GetStr(Doc.Destinatario.Endereco.CodigoMunicipio)+','+
               GetNumber(Doc.TotalProdutos)+','+
               GetNumber(Doc.TotalServicos)+','+
               GetNumber(Doc.TotalImpostos.BaseICMS)+','+
               GetNumber(Doc.TotalImpostos.BaseISS)+','+
               GetNumber(Doc.TotalImpostos.BaseIPI)+','+
               GetNumber(Doc.TotalImpostos.BasePIS_COFINS)+','+
               GetNumber(Doc.TotalImpostos.BaseICMSST)+','+
               GetNumber(Doc.TotalImpostos.BaseCSLL)+','+
               GetNumber(Doc.TotalImpostos.BaseIR)+','+
               GetNumber(Doc.TotalImpostos.ValorICMS)+','+
               GetNumber(Doc.TotalImpostos.ValorISS)+','+
               GetNumber(Doc.TotalImpostos.ValorIPI)+','+
               GetNumber(Doc.TotalImpostos.ValorPIS)+','+
               GetNumber(Doc.TotalImpostos.ValorCOFINS)+','+
               GetNumber(Doc.TotalImpostos.ValorICMSST)+','+
               GetNumber(Doc.TotalImpostos.ValorCSLL)+','+
               GetNumber(Doc.TotalImpostos.ValorIR)+','+
               GetNumber(Doc.Seguro)+','+
               GetNumber(Doc.Frete)+','+
               GetNumber(Doc.OutrasDespesas)+','+
               GetNumber(Doc.TotalDocumento)+','+
               GetStr(ifThen(Doc.TipoFrete = tfEmitente, ModalidadeFreteEmitente,
                       IfThen(Doc.TipoFrete= tfTerceiros, ModalidadeFreteTerceiros,ModalidadeFreteDestinatario)))+','+
               GetStr(TipoTransporteToStr(Doc.TipoTransporte))+','+
               GetStr(Doc.Placa)+','+
               GetStr(Doc.UfPlaca)+','+
               GetStr(Doc.ANTT)+','+
               GetInteger(Doc.Volume)+','+
               GetStr(Doc.Especie)+','+
               GetStr(Doc.Marca)+','+
               GetNumber(Doc.PesoLiquido)+','+
               GetNumber(Doc.PesoBruto)+','+
      '        null,'+ //XMLDOCUMENTO,
      '        current_date, '+
      '        current_time, '+
               TipoCampoChaveToStr(Doc.IdSaida)+','+
               GetStr(IfThen(Doc.TipoDocumento = tdNFSe, NumeracaoNotaSaidaNFSe,
                         IfThen(Doc.TipoDocumento = tdNFe, NumeracaoNotaSaidaNFe,'C')))+','+
               TipoCampoChaveToStr(Doc.IdEntrada)+','+
               TipoCampoChaveToStr(Doc.IdEmpresa)+','+
               GetStr(Doc.Protocolo)+','+
               GetStr(Doc.ChaveAcesso)+','+
               GetStr(Doc.LoteSistema)+','+
               GetStr(Doc.XML)+','+
               GetStr(IfThen(Doc.Cancecelado,'Y','N'))+','+
               GetStr(IfThen(Doc.TipoCancelamento = tcErro_De_Emissao, 'E','O' ))+','+
               GetStr(Doc.MotivoCancelamento)+','+
               IfThen(Doc.Cancecelado,'current_timestamp','null')+  ');';


    Exec_SQL(StrSQL);
    {$EndRegion}

    {$Region 'Produtos'}
    for I := 0 to Doc.Produtos.Count -1 do
    begin
      StrSQL :=
        '  INSERT INTO ITENSDOCUMENTO (IDITENSDOCUMENTO, '+
        '                              IDDOCUMENTO, '+
        '                              CODIGOPRODUTO, '+
        '                              NOMEPRODUTO, '+
        '                              EAN, '+
        '                              VALORUNITARIO, '+
        '                              QUANTIDADE, '+
        '                              TOTAL, '+
        '                              NCM, '+
        '                              CST, '+
        '                              CSOSN, '+
        '                              CODIGOMUNICIPALSERVICO, '+
        '                              CODIGOFEDERALSERVICO, '+
        '                              OBS, '+
        '                              UNIDADE, '+
        '                              CFOP, '+
        '                              ALIQICMS, '+
        '                              ALIQISS, '+
        '                              ALIQPIS, '+
        '                              ALIQCOFINS, '+
        '                              ALIQIPI, '+
        '                              ALIQICMSST, '+
        '                              ALIQCSLL, '+
        '                              ALIQIR, '+
        '                              BASEICMS, '+
        '                              BASEISS, '+
        '                              BASEIPI, '+
        '                              BASEPIS_COFINS, '+
        '                              BASEICMSST, '+
        '                              BASECSLL, '+
        '                              BASEIR, '+
        '                              VALORICMS, '+
        '                              VALORISS, '+
        '                              VALORIPI, '+
        '                              VALORPIS, '+
        '                              VALORCOFINS, '+
        '                              VALORICMSST, '+
        '                              VALORCSLL, '+
        '                              VALORIR, '+
        '                              TIPOIPI, '+
        '                              MVA,     '+
        '                              VALORTOTAL )'+
        '  VALUES ((select result from gerachave(''seq_IDITENSDOCUMENTO'')), '+
                   QuotedStr(ID)+','+
                   GetStr(Doc.Produtos.Items[i].Codigo)+','+
                   GetStr(Doc.Produtos.Items[i].Nome)+','+
                   GetStr(Doc.Produtos.Items[i].EAN13)+','+
                   GetNumber(Doc.Produtos.Items[i].ValorUnitario)+','+
                   GetNumber(Doc.Produtos.Items[i].Quantidade)+','+
                   GetNumber(Doc.Produtos.Items[i].TotalBruto)+','+
                   GetStr(Doc.Produtos.Items[i].NCM)+','+
                   GetStr(Doc.Produtos.Items[i].CST)+','+
                   GetStr(Doc.Produtos.Items[i].CSOSN)+','+
                   GetStr(Doc.Produtos.Items[i].CodigoMunicipalServico)+','+
                   GetStr(Doc.Produtos.Items[i].CodigoFederalServico)+','+
                   GetStr(Doc.Produtos.Items[i].Observacao)+','+
                   GetStr(Doc.Produtos.Items[i].Unidade)+','+
                   GetStr(Doc.Produtos.Items[i].CFOP)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.AliqICMS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.AliqISS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.AliqPIS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.AliqCOFINS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.AliqIPI)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.AliqICMSST)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ALiqCSLL)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ALiqIR)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BaseICMS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BaseISS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BaseIPI)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BasePIS_COFINS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BaseICMSST)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BaseCSLL)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.BaseIR)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorICMS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorISS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorIPI)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorPIS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorCOFINS)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorICMSST)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorCSLL)+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.ValorIR)+','+
                   GetStr(IfThen(Doc.Produtos.Items[i].Impostos.TipoIPI = iIPIAliq,'A','V') )+','+
                   GetNumber(Doc.Produtos.Items[i].Impostos.MVA)+','+
                   GetNumber(Doc.Produtos.Items[i].ValorTotalLiquido)+')';


     Exec_SQL(StrSQL);
    end;

   {$EndRegion}

    {$Region 'Serviços'}
    for I := 0 to Doc.Servicos.Count -1 do
    begin
      StrSQL :=
        '  INSERT INTO ITENSDOCUMENTO (IDITENSDOCUMENTO, '+
        '                              IDDOCUMENTO, '+
        '                              CODIGOPRODUTO, '+
        '                              NOMEPRODUTO, '+
        '                              EAN, '+
        '                              VALORUNITARIO, '+
        '                              QUANTIDADE, '+
        '                              TOTAL, '+
        '                              NCM, '+
        '                              CST, '+
        '                              CSOSN, '+
        '                              CODIGOMUNICIPALSERVICO, '+
        '                              CODIGOFEDERALSERVICO, '+
        '                              OBS, '+
        '                              UNIDADE, '+
        '                              CFOP, '+
        '                              ALIQICMS, '+
        '                              ALIQISS, '+
        '                              ALIQPIS, '+
        '                              ALIQCOFINS, '+
        '                              ALIQIPI, '+
        '                              ALIQICMSST, '+
        '                              ALIQCSLL, '+
        '                              ALIQIR, '+
        '                              BASEICMS, '+
        '                              BASEISS, '+
        '                              BASEIPI, '+
        '                              BASEPIS_COFINS, '+
        '                              BASEICMSST, '+
        '                              BASECSLL, '+
        '                              BASEIR, '+
        '                              VALORICMS, '+
        '                              VALORISS, '+
        '                              VALORIPI, '+
        '                              VALORPIS, '+
        '                              VALORCOFINS, '+
        '                              VALORICMSST, '+
        '                              VALORCSLL, '+
        '                              VALORIR, '+
        '                              TIPOIPI, '+
        '                              MVA,     '+
        '                              VALORTOTAL )'+
        '  VALUES ((select result from gerachave(''seq_IDITENSDOCUMENTO'')), '+
                   QuotedStr(ID)+','+
                   GetStr(Doc.Servicos.Items[i].Codigo)+','+
                   GetStr(Doc.Servicos.Items[i].Nome)+','+
                   GetStr(Doc.Servicos.Items[i].EAN13)+','+
                   GetNumber(Doc.Servicos.Items[i].ValorUnitario)+','+
                   GetNumber(Doc.Servicos.Items[i].Quantidade)+','+
                   GetNumber(Doc.Servicos.Items[i].TotalBruto)+','+
                   GetStr(Doc.Servicos.Items[i].NCM)+','+
                   GetStr(Doc.Servicos.Items[i].CST)+','+
                   GetStr(Doc.Servicos.Items[i].CSOSN)+','+
                   GetStr(Doc.Servicos.Items[i].CodigoMunicipalServico)+','+
                   GetStr(Doc.Servicos.Items[i].CodigoFederalServico)+','+
                   GetStr(Doc.Servicos.Items[i].Observacao)+','+
                   GetStr(Doc.Servicos.Items[i].Unidade)+','+
                   GetStr(Doc.Servicos.Items[i].CFOP)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.AliqICMS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.AliqISS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.AliqPIS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.AliqCOFINS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.AliqIPI)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.AliqICMSST)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ALiqCSLL)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ALiqIR)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BaseICMS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BaseISS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BaseIPI)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BasePIS_COFINS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BaseICMSST)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BaseCSLL)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.BaseIR)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorICMS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorISS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorIPI)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorPIS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorCOFINS)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorICMSST)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorCSLL)+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.ValorIR)+','+
                   GetStr(IfThen(Doc.Servicos.Items[i].Impostos.TipoIPI = iIPIAliq,'A','V') )+','+
                   GetNumber(Doc.Servicos.Items[i].Impostos.MVA)+','+
                   GetNumber(Doc.Servicos.Items[i].ValorTotalLiquido)+')';


     Exec_SQL(StrSQL);
    end;

   {$EndRegion}

    Commit;
  Except
    on e:Exception do
    begin
      RollBack;
      Raise;
    end;

  End;
end;

class procedure TRegrasLotesDocumentosFiscais.ImprimeNFSe(
  IdSaida: TipoCampoChave);
var
  StrSQL: String;
  Nfse : TNFSe;
  Doc: IDocumentoFiscal;
  DocsNFSe: TList<IDocumentoFiscal>;
  DataSetNota, DataSetItens, DataSetCobranca: TpFIBClientDataSet;
begin
  Try
    DocsNFSe := TList<IDocumentoFiscal>.Create;
    DataSetNota := TpFIBClientDataSet.Create(nil);
    DataSetItens := TpFIBClientDataSet.Create(nil);
    DataSetCobranca := TpFIBClientDataSet.Create(nil);

    SetCds(DataSetNota,tpERPSaida,'idsaida = '+TipoCampoChaveToStr(IdSaida));
    SetCds(DataSetItens,tpERPSaidaProduto,'idsaida = '+TipoCampoChaveToStr(IdSaida));
    SetCds(DataSetCobranca,tpERPSaidaCondicaoPagamento,'idsaida = '+TipoCampoChaveToStr(IdSaida));
    TRegrasDocumentos.CriaDocumentoFiscal(DataSetNota,DataSetItens,DataSetCobranca, Doc);
    DocsNFSe.Add(Doc);
    StrSQL:=
      'SELECT FIRST 1  D.PROTOCOLO, D.LOTE, NUMERO'+
      '  FROM DOCUMENTO D '+
      '  WHERE D.IDSAIDA = '+TipoCampoChaveToStr(IdSaida)+
      '    AND D.TIPODOCUMENTO = '+QuotedStr(NumeracaoNotaSaidaNFSe)+
      '  ORDER BY D.REVISAO DESC ';

    WITH GetCds(StrSQL) do
    begin
      Nfse := TNFSe.Create(DocsNFSe,FieldByName('LOTE').AsString);
      with GetCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(DataSetNota.FieldByName('idempresa').AsString)) do
      begin
        Nfse.SalvaLogoEmpresa(FieldByName('LOGOMARCA'));
        Free;
      end;

      NFSe.Imprimir(FieldByName('PROTOCOLO').AsString,FieldByName('NUMERO').AsString);
      Free;
    end;
  Finally
    FreeAndNil(Nfse);
    FreeAndNil(DataSetNota);
    FreeAndNil(DataSetItens);
    FreeAndNil(DataSetCobranca);
    FreeAndNil(DocsNFSe);
    if Assigned(Doc) then
      Doc._Release;
  End;
end;

class procedure TRegrasLotesDocumentosFiscais.NovoLote;
var
  StrSQL,Id: String;
begin
  Try
    Id := GetCodigo(tpERPLotesNota);
    StartTrans;
    StrSQL :=
      'INSERT INTO LOTEDOCUMENTO (IDLOTEDOCUMENTO, FLAGSTATUSNFE,  '+
      '                           FLAGSTATUSNFSE) '+
      '  VALUES ('+TipoCampoChaveToStr(Id)+',''N'', ''N'') ';
    Exec_SQL(StrSQL);
    StrSQL:=
      'INSERT INTO ITENSLOTEDOCUMENTO (IDLOTEDOCUMENTO, IDITENSLOTEDOCUMENTO, IDSAIDA, FLAGSTATUS)'+
      ' SELECT '+TipoCampoChaveToStr(Id)+' IDLOTE,(SELECT RESULT FROM GERACHAVE(''SEQ_IDITENSLOTEDOCUMENTO''))IDLOTEDOCUMENTO,'+
      '        S.IDSAIDA ,''A'' STATUS'+
      '   FROM SAIDA S'+
      '  WHERE NOT EXISTS(SELECT 1 '+
      '                     FROM ITENSLOTEDOCUMENTO I'+
      '                    WHERE I.IDSAIDA = S.IDSAIDA '+
      '                      AND COALESCE(I.FLAGSTATUS,''A'') <> ''S'' ) '+
      '    AND NOT EXISTS(SELECT 1 '+
      '                     FROM ITENSLOTEDOCUMENTO I'+
      '                    INNER JOIN LOTEDOCUMENTO L  '+
      '                       ON (L.IDLOTEDOCUMENTO = I.IDLOTEDOCUMENTO)'+
      '                    WHERE I.IDSAIDA = S.IDSAIDA '+
      '                      AND COALESCE(I.FLAGSTATUS,''A'') <> ''S'' '+
      '                      AND COALESCE(L.FLAGSTATUSNFE,''X'') IN (''R'',''X'') '+
      '                      AND COALESCE(L.FLAGSTATUSNFSE,''X'') IN (''R'',''X'')'+
      '                      )';
    Exec_SQL(StrSQL);

    StrSQL :=
      'DELETE FROM LOTEDOCUMENTO L'+
      ' WHERE NOT EXISTS (SELECT 1 '+
      '                     FROM ITENSLOTEDOCUMENTO I    '+
      '                    WHERE L.IDLOTEDOCUMENTO = I.IDLOTEDOCUMENTO)';
    Exec_SQL(StrSQL);
    Commit;
  Except
    on e: Exception do
    begin
      RollBack;
      Raise;
    end;

  End;
end;

class procedure TRegrasLotesDocumentosFiscais.ProcessaLote(
  IdLote: TipoCampoChave; NumeroLote: String );
var
  RetNFSe,RetNFe: TRetorno;
  StrSQL: String;
begin
  TRegrasLotesDocumentosFiscais.GeraDocumentosFiscais(IdLote,NumeroLote,RetNFSe,RetNFe);
  Try
    StartTrans();
    StrSQL :=
      'UPDATE '+GetTabela(tpERPLotesNota)+
      '   SET FLAGSTATUSNFE = '+QuotedStr( IfThen(RetNFe.Erro, StatusLoteDocumentosFiscaisEnviado,StatusLoteDocumentosFiscaisSucesso))+','+
      '       MSGERRONFE = '+QuotedStr(IfThen(RetNFe.Erro, RetNFe.Mensagem))+','+
      '       DATAHORARESPOSTANFE = CURRENT_DATE'+','+
      '       FLAGSTATUSNFSE = '+QuotedStr(IfThen(RetNFSe.Erro, StatusLoteDocumentosFiscaisEnviado,StatusLoteDocumentosFiscaisSucesso))+','+
      '       MSGERRONFSE = '+QuotedStr(IfThen(RetNFSe.Erro, RetNFSe.Mensagem))+','+
      '       DATAHORARESPOSTANFSE = CURRENT_DATE'+
      '  WHERE '+GetCampoChave(tpERPLotesNota)+' = '+TipoCampoChaveToStr(IdLote);
    Exec_SQL(StrSQL);

    StrSQL :=
      'UPDATE '+GetTabela(tpERPItensLotesNota)+
      '   SET FLAGSTATUS = '+QuotedStr(IfThen(RetNFe.Erro or RetNFSe.Erro, StatusItemLoteDocumentosFiscaisErro,StatusItemLoteDocumentosFiscaisSucesso))+
      '  WHERE '+GetCampoChave(tpERPLotesNota)+' = '+TipoCampoChaveToStr(IdLote);
    Exec_SQL(StrSQL);


    Commit();
  Except
    on e: Exception do
    begin
      RollBack();
      Raise;
    end;
  End;

end;

{ TRegrasDocumentos }

class procedure TRegrasDocumentos.CriaDocumentoFiscal(const DataSetNota,
  DataSetItens, DataSetCobranca: TDataSet; var Doc: IDocumentoFiscal);
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

class procedure TRegrasDocumentos.CriaDocumentoFiscal(
  const IdDocumento: TipoCampoChave; var Doc: IDocumentoFiscal);
var
  DataSetNota,
  DataSetItens, DataSetCobranca: TpFIBClientDataSet;
  StrSQL: String;
  Item: IItemDocumento;
begin
  Try
  { TODO : Rever }
    DataSetNota := TpFIBClientDataSet.Create(nil);
    DataSetItens := TpFIBClientDataSet.Create(nil);

    StrSQL:=
      'select * from documento where IdDocumento = '+TipoCampoChaveToStr(IdDocumento);
    SetCds(DataSetNota,StrSQL);
    StrSQL:=
      'select * from ITENSDOCUMENTO where IdDocumento = '+TipoCampoChaveToStr(IdDocumento);
    SetCds(DataSetItens,StrSQL);

     Doc := TDocumentoFiscal.Create;

  {$Region 'Cria Emitente'}
    Doc.Emitente.Nome_RazaoSocial := DataSetNota.FieldByName('RAZAOSOCIALEmitente').AsString;
    Doc.Emitente.NomeFantasia := DataSetNota.FieldByName('FANTASIAEmitente').AsString;
    Doc.Emitente.CPF_CNPJ := DataSetNota.FieldByName('CNPJEmitente').AsString;
    Doc.Emitente.Telefone := DataSetNota.FieldByName('TELEFONEEmitente').AsString;
    Doc.Emitente.IE := DataSetNota.FieldByName('IEEmitente').AsString;
    Doc.Emitente.IE_ST :='';
    Doc.Emitente.SUFRAMA :='';
    Doc.Emitente.IdentificacaoSUFRAMA := '';
    Doc.Emitente.IM := DataSetNota.FieldByName('IMEmitente').AsString;
    Doc.Emitente.Email :='';
    Doc.Emitente.CNAE :=  DataSetNota.FieldByName('CNAEEmitente').AsString;
//    Doc.Emitente.CRT := TRegrasImpostos.GetCRT(DataSetNota.FieldByName('idempresa').AsString,DataSetNota.FieldByName('data').AsDateTime);
    Doc.Emitente.Endereco.Endereco := DataSetNota.FieldByName('LOGRADOUROEmitente').AsString;
    Doc.Emitente.Endereco.NumeroEndereco := DataSetNota.FieldByName('NUMEROEmitente').AsString;
    Doc.Emitente.Endereco.Complemento := DataSetNota.FieldByName('COMPLEMENTOEmitente').AsString;
    Doc.Emitente.Endereco.Bairro := DataSetNota.FieldByName('BAIRROEmitente').AsString;
    Doc.Emitente.Endereco.Cidade := DataSetNota.FieldByName('CIDADEEmitente').AsString;
    Doc.Emitente.Endereco.Estado := DataSetNota.FieldByName('UFEmitente').AsString;
    Doc.Emitente.Endereco.CodigoIBGEEstado :=  DataSetNota.FieldByName('CODIGOIBGEESTADOEmitente').AsString;
    Doc.Emitente.Endereco.CodigoMunicipio :=  DataSetNota.FieldByName('ibgeEmitente').AsString;
    Doc.Emitente.Endereco.CEP := DataSetNota.FieldByName('CEPEmitente').AsString;
    Doc.Emitente.Endereco.NumPais := 1058;
    Doc.Emitente.Endereco.NomePais := 'BRASIL';
    Doc.Emitente.RegimeTributacao :=  DataSetNota.FieldByName('REGIMEEMPRESAEmitente').AsString;

  {$EndRegion}

  {$Region 'Cria Destinatario'}

      Doc.Destinatario.Nome_RazaoSocial := DataSetNota.FieldByName('NOMECLIENTEDestinatario').AsString;
      Doc.Destinatario.NomeFantasia := DataSetNota.FieldByName('FANTASIADestinatario').AsString;
      if DataSetNota.FieldByName('CNPJ').AsString <> '' then
        Doc.Destinatario.CPF_CNPJ := DataSetNota.FieldByName('CNPJDestinatario').AsString
      else
      if DataSetNota.FieldByName('CPF').AsString <> '' then
        Doc.Destinatario.CPF_CNPJ := DataSetNota.FieldByName('CPFDestinatario').AsString;


      Doc.Destinatario.Telefone := DataSetNota.FieldByName('TELEFONEDestinatario').AsString;
      Doc.Destinatario.IE := DataSetNota.FieldByName('IEDestinatario').AsString;
      Doc.Destinatario.IE_ST :='';
      Doc.Destinatario.SUFRAMA :='';
      Doc.Destinatario.IdentificacaoSUFRAMA := '';
      Doc.Destinatario.IM := DataSetNota.FieldByName('IMDestinatario').AsString;
      Doc.Destinatario.Email :=  DataSetNota.FieldByName('emailDestinatario').AsString;
      Doc.Destinatario.Endereco.Endereco := DataSetNota.FieldByName('LOGRADOURODestinatario').AsString;
      Doc.Destinatario.Endereco.NumeroEndereco := DataSetNota.FieldByName('NUMERODestinatario').AsString;
      Doc.Destinatario.Endereco.Complemento := DataSetNota.FieldByName('COMPLEMENTODest').AsString;
      Doc.Destinatario.Endereco.Bairro := DataSetNota.FieldByName('BAIRRODestinatario').AsString;
      Doc.Destinatario.Endereco.Cidade := DataSetNota.FieldByName('CIDADEDestinatario').AsString;
      Doc.Destinatario.Endereco.Estado := DataSetNota.FieldByName('UFDestinatario').AsString;
      Doc.Destinatario.Endereco.CodigoMunicipio :=  DataSetNota.FieldByName('CODIGOIBGEDest').AsString;
      Doc.Destinatario.Endereco.CEP := DataSetNota.FieldByName('CEPDestinatario').AsString;
      Doc.Destinatario.Endereco.NumPais := 1058;     { TODO : Rever }
      Doc.Destinatario.Endereco.NomePais := 'BRASIL'; { TODO : Rever }



  {$EndRegion}

  {$Region 'Cria Transportadora'}
    Doc.Transportadora.Nome_RazaoSocial := DataSetNota.FieldByName('RAZAOSOCIALTRASP').AsString;
    Doc.Transportadora.NomeFantasia := DataSetNota.FieldByName('NOMEFANTASIATRASP').AsString;
    Doc.Transportadora.CPF_CNPJ := DataSetNota.FieldByName('CNPJTRASP').AsString;

    Doc.Transportadora.Telefone :='';//FieldByName('TELEFONE').AsString;
    Doc.Transportadora.IE := DataSetNota.FieldByName('IETRASP').AsString;
    Doc.Transportadora.IE_ST :='';
    Doc.Transportadora.SUFRAMA :='';
    Doc.Transportadora.IdentificacaoSUFRAMA := '';
    Doc.Transportadora.IM :='';
    Doc.Transportadora.Email := '';
    Doc.Transportadora.Endereco.Endereco := DataSetNota.FieldByName('LOGRADOUROTRASP').AsString;
    Doc.Transportadora.Endereco.NumeroEndereco := DataSetNota.FieldByName('NUMEROTRASP').AsString;
    Doc.Transportadora.Endereco.Complemento := DataSetNota.FieldByName('COMPLEMENTOTRASP').AsString;
    Doc.Transportadora.Endereco.Bairro := DataSetNota.FieldByName('BAIRROTRASP').AsString;
    Doc.Transportadora.Endereco.Cidade := DataSetNota.FieldByName('CIDADETRASP').AsString;
    Doc.Transportadora.Endereco.Estado := DataSetNota.FieldByName('UFTRASP').AsString;
    Doc.Transportadora.Endereco.CodigoMunicipio :=  DataSetNota.FieldByName('IBGETRASP').AsString;
    Doc.Transportadora.Endereco.CEP := DataSetNota.FieldByName('CEPTRASP').AsString;
    Doc.Transportadora.Endereco.NumPais := 1058;
    Doc.Transportadora.Endereco.NomePais := 'BRASIL';


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


  Finally
    FreeAndNil(DataSetNota);
    FreeAndNil(DataSetItens);
  End;


end;

class procedure TRegrasDocumentos.CriaDocumentoFiscal(
  const IdSaida: TipoCampoChave; TipoDocumento: String;
  var Doc: IDocumentoFiscal);
var
  DataSetNota,
  DataSetItens, DataSetCobranca: TpFIBClientDataSet;
begin
  Try
    DataSetNota := TpFIBClientDataSet.Create(nil);
    DataSetItens := TpFIBClientDataSet.Create(nil);
    DataSetCobranca := TpFIBClientDataSet.Create(nil);


    SetCds(DataSetNota,tpERPSaida,'idsaida = '+TipoCampoChaveToStr(idsaida));
    SetCds(DataSetItens,tpERPSaidaProduto,'idsaida = '+TipoCampoChaveToStr(idsaida));
    SetCds(DataSetCobranca,tpERPSaidaCondicaoPagamento,'idsaida = '+TipoCampoChaveToStr(idsaida));

    TRegrasDocumentos.CriaDocumentoFiscal(DataSetNota, DataSetItens, DataSetCobranca,Doc);

  Finally
    FreeAndNil(DataSetNota);
    FreeAndNil(DataSetItens);
    FreeAndNil(DataSetCobranca);
  End;
end;

{ TRegrasCFOP }

class procedure TRegrasCFOP.ObtemCFOP(Const IdOperacao,IdProduto,IdEmpresa,IdPessoa: TipoCampoChave;
                               Out IdCFOP: TipoCampoChave; out CST,CSOSN: String; const OperacaoParaCliente: Boolean = True);
var
  TipoOperacao,TipoCFOP,  UFOrigem, UFDestino,PrefixoCFOP: String;
  IPI,ST:Boolean;
  IdNCM: TipoCampoChave;
begin
  TipoOperacao :=GetValorCds(tpERPOperacao,'IdOperacao = '+TipoCampoChaveToStr(IdOperacao),'FLAGTIPOOPERACAO');
  IdNCM := GetValorCds(tpERPProduto,'Idproduto = '+TipoCampoChaveToStr(IdProduto),'IDNCM');
  {$Region 'Obtem as Ufs e tipo de CFOP'}
  if (TipoOperacao = OperacaoEntrada)  then
  begin
    UFDestino := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');
    if OperacaoParaCliente then
      UFOrigem := GetValorCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdPessoa),'UF')
    else
      UFOrigem := GetValorCds(tpERPFornecedor,'idfornecedor = '+TipoCampoChaveToStr(IdPessoa),'UF');

    if UFOrigem <> UFDestino then
    begin
      PrefixoCFOP := '2';
      TipoCFOP := CFOPTipoOperacaoEntradaForaEstado;
    end else
    begin
      PrefixoCFOP := '1';
      TipoCFOP := CFOPTipoOperacaoEntradaDentroEstado;
    end;

  end;
  if (TipoOperacao = OperacaoDevolucao) then
  begin
    UFDestino := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');
    if OperacaoParaCliente then
      UFOrigem := GetValorCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdPessoa),'UF')
    else
      UFOrigem := GetValorCds(tpERPFornecedor,'idfornecedor = '+TipoCampoChaveToStr(IdPessoa),'UF');

    if UFOrigem <> UFDestino then
    begin
      PrefixoCFOP := '2';
      TipoCFOP := CFOPTipoOperacaoEntradaForaEstado;
    end else
    begin
      PrefixoCFOP := '1';
      TipoCFOP := CFOPTipoOperacaoEntradaDentroEstado;
    end;

  end;
  if (TipoOperacao = OperacaoImportacao)  then
  begin
    UFDestino := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');
    if OperacaoParaCliente then
      UFOrigem := GetValorCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdPessoa),'UF')
    else
      UFOrigem := GetValorCds(tpERPFornecedor,'idfornecedor = '+TipoCampoChaveToStr(IdPessoa),'UF');

    PrefixoCFOP := '3';
    TipoCFOP := CFOPTipoOperacaoImportacao;

  end;

  if (TipoOperacao = OperacaoSaida)  then
  begin
    UFOrigem := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');
    if OperacaoParaCliente then
      UFDestino := GetValorCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdPessoa),'UF')
    else
      UFDestino := GetValorCds(tpERPFornecedor,'idfornecedor = '+TipoCampoChaveToStr(IdPessoa),'UF');

    if UFOrigem <> UFDestino then
    begin
      PrefixoCFOP := '6';
      TipoCFOP := CFOPTipoOperacaoSaidaForaEstado;
    end else
    begin
      PrefixoCFOP := '5';
      TipoCFOP := CFOPTipoOperacaoSaidaDentroEstado;
    end;

  end;

  if (TipoOperacao = OperacaoExportacao)  then
  begin
    UFOrigem := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');
    if OperacaoParaCliente then
      UFDestino := GetValorCds(tpERPCliente,'idcliente = '+TipoCampoChaveToStr(IdPessoa),'UF')
    else
      UFDestino := GetValorCds(tpERPFornecedor,'idfornecedor = '+TipoCampoChaveToStr(IdPessoa),'UF');

    PrefixoCFOP := '7';
    TipoCFOP := CFOPTipoOperacaoExportacao;
  end;


  if (TipoOperacao = OperacaoTransferencia)  then
  begin
    UFOrigem := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');
    UFDestino := GetValorCds(tpERPEmpresa,'idempresa = '+TipoCampoChaveToStr(IdEmpresa),'UF');

    if UFOrigem <> UFDestino then           { TODO : melhorar }
    begin
      PrefixoCFOP := '2';
      TipoCFOP := CFOPTipoOperacaoSaidaForaEstado;
    end else
    begin
      PrefixoCFOP := '1';
      TipoCFOP := CFOPTipoOperacaoSaidaDentroEstado;
    end;

  end;



  {$EndRegion}

  with GetCds(tpERPNCMTributacao,'idncm = '+TipoCampoChaveToStr(IdNCM)+' UF = '+QuotedStr(UFDestino)) do
  begin
    if FieldByName('ALIQIPI').IsNull or  FieldByName('IPIVALOR').IsNull  then
      IPI := False
    else
      IPI := True;

    if FieldByName('ALIQICMSST').IsNull   then
      ST := False
    else
      ST := True;

    Free;
  end;

  IdCFOP := GetValorCds(tpERPCFOPVisivel,' FLAGTIPOOPERACAO= '+QuotedStr(TipoCFOP)+
                                         ' and FLAGTRIBUTAIPI = '+QuotedStr(IfThen(IPI,'Y','N'))+
                                         ' and FLAGTRIBUTAST = '+QuotedStr(IfThen(IPI,'Y','N') )   );



end;

end.
