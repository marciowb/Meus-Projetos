unit Comandos;

interface
  uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
        Dialogs,  DB,  DBClient, Provider,  cxGridStrs, cxClasses,
        cxFilterControlStrs, cxGridDBTableView, cxGridTableView, cxDataStorage,
        StrUtils, cxTreeView, Mask, DBCtrls, cxGridCustomTableView, StdCtrls,
        JvComponentBase,  JvSerialMaker, LabelDBEdit,
        EditPesquisa,  cxDBTL, cxGridDBCardView, cxGridDBBandedTableView,
        TypInfo, cxGrid, cxCustomData, cxTL, MinhasClasses,
        pFIBClientDataSet,  FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery,
        Printers,pFIBDatabase, pFIBProps, ppTypes, cxFilterConsts,cxEditConsts,
        UDmConexao, ShellAPI,ppDBPipe,cxSchedulerStrs, IdBaseComponent, IdComponent,
        IdTCPConnection, IdTCPClient, IdHTTP, DateUtils,cxPC,ExtCtrls,cxDBEdit,
        cxCustomPivotGrid, cxDBPivotGrid;

  function GetDataServidor : String;
  Function GetHoraServidor : String;
  function SetCds(Cds: TpFIBClientDataSet; StrSQL: String;Trans: TpFIBTransaction = nil): Boolean; overload;
  function SetCds(Cds: TpFIBClientDataSet; TipoPesquisa : TTipoPesquisa; Wr : String;Trans: TpFIBTransaction = nil;Join: String = ''): Boolean; overload;
  procedure Exec_SQL(StrSQL: String);
  function MontaGrid(TV: TcxGridDBTableView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo; Largura: Integer = 65):TcxGridDBColumn;
  function MontaCard(Tv : TcxGridDBCardView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo) : TcxGridDBCardViewRow;
  Function MontaBanded(Tv : TcxGridDBBandedTableView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo; Largura: Integer = 65):TcxGridDBBandedColumn;


  Procedure SetRegistros(Cds :TDataSet; TipoPesquisa : TTipoPesquisa);

  Procedure AlteraBanco(TipoAlteracao : TTipoAlteracao; Cds : TDataSet;
                      NomeTabela : String;
                      CampoChave : String;GravaTodos : Boolean = False);Overload;
  Procedure AlteraBanco(TipoAlteracao : TTipoAlteracao; Cds : TDataSet;TipoPesquisa: TTipoPesquisa);Overload;

  Function GetValorCds(StrSQL : String; IndexField : Integer = 0) : String;overload;
  Function GetValorCds(StrSQL : String; FieldName : String) : String;overload;
  Function GetValorCds(TipoPesquisa: TTipoPesquisa; Wr : String; FieldName : String = '') : String;overload;
  Function GetCds(StrSQL: String): TpFIBClientDataSet;overload;
  Function GetCds(TipoPesquisa: TTipoPesquisa; Wr: String): TpFIBClientDataSet;overload;
  Function GetCodigo(TipoPesquisa : TTipoPesquisa; TipoChave : TTipoChave = ttcChave;UsaMaxParaCodigo: Boolean = False): String;
  procedure AcertaPadroesData;
  Procedure AvisaErro(msg: String; Abortar : Boolean = True);
  Procedure Avisa(msg: String);
  Function ConfirmaDel : Boolean;
  Function Pergunta(Msg : String) : Boolean;
  Function RetornaData(Data : TDateTime; UsaAspas : Boolean = True) : String;
  Procedure FormataMascara(var Edit : TMaskEdit ;TipoCampo : TTipoCampo);overload;
  Procedure FormataMascara(Field : TField ;TipoCampo : TTipoCampo);overload;
//  Procedure FormataMascara(PesquisaEdit : TaqPesquisaMaskEdit_Pan ;TipoCampo : TTipoCampo);overload;
  Procedure VerificaEdit(Edit : TEditPesquisa;  MsgVazio : String) ;overload;
  Procedure VerificaEdit(Cds : TpFIBClientDataSet ;Edit : TDBEdit; MsgExiste, MsgVazio : String) ;overload;
  Procedure VerificaEdit(Cds : TpFIBClientDataSet ;Edit : TLabelDBEdit; MsgExiste, MsgVazio : String) ;overload;
  Procedure VerificaEdit(Edit : TEdit;  MsgVazio : String) ;overload;
  Procedure VerificaEditPreenchido(Edit : TEditPesquisa;  MsgPreenchido : String) ;

  Function GetData(Data : TDate ; Aspas : Boolean = True) : String; Overload;
  Function GetData(Data : String ; Aspas : Boolean = True) : String; Overload;
  Function GetTime(Hora : String; Aspas : Boolean = True): String;overload;
  Function GetTime(Hora : TTime; Aspas : Boolean = True): String;overload;
  Function Verifica_CPF(Cpf : String ) : Boolean ;
  Function Verifica_CNPJ(CNPJ : String ) : Boolean ;
  Function Verifica_Inscricao_Estadual(IE, UF : String ) : Boolean ;
  Function ExisteRegistroCds(CdsOrigem, CdsDestino: TpFIBClientDataSet  ;NomeCampoOrigem, NomeCampoDestino : String ) : Boolean;
  Function GetNumber(Valor : Currency ): String;
  Function VerificaLabelDbEdit(Form : TForm; CDs :TpFIBClientDataSet; TipoPesquisa: TTipoPesquisa): Boolean;
  Function ExisteRegistro(Cds : TpFIBClientDataSet;NomeCampo : String; VerificaEmEdicao : Boolean = False; VerificaFiltro: Boolean = False) : Boolean;overload;
  Function ExisteRegistro(TipoPesquisa : TTipoPesquisa; NomeCampo : String; Valor : String) : Boolean;overload;
  Function GetVersaoAplicativo: Ansistring;

  Procedure AbrePesquisa(Sender : TObject;ADataSet : TDataSet; aTipoPesquisa: Integer; Titulo : String; Out Resultado : Variant);
  Procedure ConfiguraEditPesquisa(var Edit : TEditPesquisa; aDataSet : TpFIBClientDataSet; aTipoPesquisa : TTipoPesquisa;
                                  aObrigatorio: Boolean = False;
                                  aCampoDisplay : String = ''; aTitulo : String = '';
                                  aCampoCodigo: String = 'CODIGO';aCampoData :String = '' ;
                                  aTamanhoCodigo : Integer = 6; FuncaoButaoNovo : TOnClick = nil; FuncaoButaoEdit : TOnClick = nil);

  procedure SetEditCliente(Var Edit: TEditPesquisa; DataSet : TpFIBClientDataSet; Campodata : String = 'idCliente');
  Procedure SetEditEmpresa(Var Edit: TEditPesquisa; DataSet : TpFibClientDataSet);

  Function IsInteger(Value : Variant): Boolean;
  Function IsString(Value : Variant): Boolean;
  Function IsDate(Value : Variant): Boolean;
  Function IsFloat(Value : Variant): Boolean;
  procedure MontaTree(Tree: TcxDBTreeList;Campo, Titulo: String;  Tamanho: Integer = 90);
  function GetTableCount(Tabela : String; Campo : String ='*'; Where : String = '1=1' ) : Integer;
  Function GetPeriodo(DataIni, DataFin : String; var Variavel : String; CampoBanco : String; UsaDataFinal:Boolean = True; UsaAnd : Boolean = True): Boolean;
  Procedure ConfiguraCx(Sender : TComponent);
  function IsNumericDBControl(Controle: TComponent): Boolean;
  procedure StartTrans(pTrans : TpFIBTransaction = nil);
  procedure Commit(pTrans : TpFIBTransaction = nil);
  procedure RollBack(pTrans : TpFIBTransaction = nil);
  Function GetValSeq(Const NomeSec: String; Inc :Integer = 1) : Integer;

  function GetStr(Valor : String): String;
  function GetInteger(Valor : Integer): String;
  procedure ImprimeRelatorio(IdRelatorio: Integer; CdsMaster,CdsDetalhe,CdsInformacoes : TpFIBClientDataSet;
                             TipoTratamento : TTratamentoLayout; pCdsExtras : Array of TpFIBClientDataSet;
                             Copias : Integer = 1; IdLayout : Integer = -1  );

  Function GetLayoutPadrao(IdRelatorio: Integer): Integer;
  Function CriaRodapeTableView(Coluna : TcxGridDBColumn; FooterKind: TcxSummaryKind; GroupKind : TcxSummaryKind = skNone):TcxGridDBColumn ;
  Function  CriaRodapeBanded(Coluna : TcxGridDBBandedColumn; FooterKind: TcxSummaryKind = skSum; GroupKind : TcxSummaryKind = skNone): TcxGridDBBandedColumn ;
  Function GetImpressoraPadrao: AnsiString;
  Function ExisteTabela(Tabela: String): Boolean;
  Function GetDescricaoLayout(IdLayout: Integer): String;
  Procedure AbrirArquivo(pFileName : String);
  Function GetDataSet(StrSQL: String): TpFIBClientDataSet;
  Procedure AdicionaListaPesquisa(Var Cds: TpFIBClientDataSet; aTipoPesquisa: TTipoPesquisa;MsgExistente : String; Filtro: String = '');
  Function PadL(aStr: AnsiString; Tamanho : Integer; Caracter : AnsiChar): AnsiString;
  Function PadR(aStr: AnsiString; Tamanho : Integer; Caracter : AnsiChar): AnsiString;
  Procedure ApagarArquivo(vFileName: AnsiString);
  Function FirstDay(Mes,Ano: Integer): TDate;overload;
  Function LastDay(Mes,Ano: Integer): TDate; overload;
  Function FirstDay(Data: TDate): TDate;overload;
  Function LastDay(Data: TDate): TDate;overload;
  Function AddDay(Dia: Integer; DataBase: Tdate): TDate;
  Procedure GravaRelatorio(Id: Integer;Nome: String);
  Procedure GetCepOnline(Const Cep: String; Var Uf: String; Var Cidade: String; Var Bairro : String; Var Logradouro: String);
  Function PodeAlterarDataSet(DataSet: TDataSet): Boolean;
  Procedure PreencheCamposValorPadraoBD(Cds: TpFIBClientDataSet; TipoPesquisa: TTipoPesquisa);
  Function KriptaStr(aStr: String): String;
  Function DeKriptaStr(aStr: String): String;
  function GetNomePC: String;
  function IdConexaoBd: Integer;
  Procedure GetValorCelulaSelecionadaPivotGrid(PivotGrid: TcxDBPivotGrid; FieldNameLinha,FieldNameColuna: String; Out Res: Array of Variant );
  const
    VersaoAcesso = 7;
implementation

uses  uPesquisa_kimera, uSQL, uDmRelatorio, uLista_Layouts;



  function GetDataServidor : String;
  var
    StrSQL : String;
  Begin
    StrSQL :=
      'SELECT CURRENT_DATE '+
      '  FROM RDB$DATABASE ';
    Result := GetValorCds(StrSQL);
  End;

  Function GetHoraServidor : String;
  var
    StrSQL : String;
  Begin
    StrSQL :=
      'SELECT CURRENT_TIME '+
      '  FROM RDB$DATABASE ';
    Result := GetValorCds(StrSQL);
  End;


function SetCds(Cds: TpFIBClientDataSet; StrSQL: String;Trans: TpFIBTransaction = nil): Boolean;
var
  Provider : TpFIBDataSetProvider;
  TransAux : TpFIBTransaction;
  Qry : TpFIBDataSet;
  I : Integer;
begin
  Try
    Try
      Qry := TpFIBDataSet.Create(nil);
      Provider := TpFIBDataSetProvider.Create(nil);
      Qry.Close;
      Cds.Close;
      Qry.Database := DMConexao.Conexao;
//      Starttrans;
      if Trans = nil then
      Begin
        TransAux := TpFIBTransaction.Create(nil);
        TransAux.DefaultDatabase := DMCOnexao.Conexao;
        TransAux.TPBMode := tpbReadCommitted;
        Qry.Transaction := TransAux;
      End  else
        Qry.Transaction := Trans;


      Qry.UpdateTransaction := Qry.Transaction;
      //TransAux.StartTransaction;
      Qry.PrepareOptions := Qry.PrepareOptions+[ psCanEditComputedFields,
                                                psSetEmptyStrToNull,
                                                psUseLargeIntField, psSQLINT64ToBCD,
                                                psApplyRepositary, psUseBooleanField]  ;
      Qry.PrepareOptions := Qry.PrepareOptions - [pfImportDefaultValues];
      Provider.Constraints := True;
      Provider.Options := Provider.Options + [poRetainServerOrder];
      Provider.UpdateMode := upWhereAll;

      Qry.SQLs.SelectSQL.Text := StrSQL ;
      Qry.Open;

      for I := 0 to Qry.Fields.Count -1  do
      Begin
        Qry.Fields[i].ReadOnly := False;
        Qry.Fields[i].Required := False;
      End;

      for I := 0 to Qry.FieldDefs.Count -1 do
      Begin
        Qry.FieldDefs[i].Attributes := [];
      End;
      Qry.FieldDefs.Clear;

      Provider.DataSet := Qry;

      Cds.Data := Provider.Data;
      Qry.Close;
      //TransAux.Rollback;
    except
      on e: Exception do
      Begin
//        Rollback(nil);
        raise;
      End;
    End;
  Finally
    FreeAndNil(Qry);
    FreeAndNil(Provider);
    if TransAux <> nil then
      FreeAndNil(TransAux);
  End;

  Result := not Cds.IsEmpty;
end;


function SetCds(Cds: TpFIBClientDataSet; TipoPesquisa : TTipoPesquisa; Wr : String;Trans: TpFIBTransaction = nil;Join: String = ''): Boolean;
var
  I: Integer;
  Lst: TStringList;
begin
  Result := SetCds(Cds, GetSelect(TipoPesquisa, Wr,'',Join), Trans);

  {Try
    Lst := TStringList.Create;
    Lst.Delimiter := ';';
    Lst.DelimitedText := InfoSistema.SQLs.GetMySQL(TipoPesquisa, '').DesconsiderarCampos;
    for I := 0 to Lst.Count - 1 do
    Begin
      if Cds.FindField(Lst[i])<> nil then
        Cds.FieldByName(Lst[i]).ProviderFlags := [];
    End;
  Finally
    FreeAndNil(Lst);
  End;   }


End;

function MontaGrid(TV: TcxGridDBTableView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo; Largura: Integer = 65):TcxGridDBColumn;

begin

  with TV do
  begin
    Result := CreateColumn as TcxGridDBColumn;
    with Result do
    begin
      Caption := Titulo;
      DataBinding.FieldName := NomeCampo;
      case TipoCampo of
        tcString:
          Begin
            DataBinding.ValueTypeClass := TcxStringValueType;
          End;
        tcInt:
           DataBinding.ValueTypeClass := TcxIntegerValueType;
        tcReal:
          Begin
            DataBinding.ValueTypeClass := TcxFloatValueType;
          End;
        tcCampoData:
          DataBinding.ValueTypeClass := TcxDateTimeValueType;
        else
          DataBinding.ValueTypeClass := TcxStringValueType;
      end;

//      if Assigned(OnGetText) then
//        OnGetDisplayText := OnGetText;
      Width := Largura;
    end;
  end;
  
end;
function MontaCard(Tv : TcxGridDBCardView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo) : TcxGridDBCardViewRow;
Begin
  Result := Tv.CreateRow as TcxGridDBCardViewRow;
  with Result do
  Begin
    Caption := Titulo;
    DataBinding.FieldName := NomeCampo;
    case TipoCampo of
        tcString:
          Begin
            DataBinding.ValueTypeClass := TcxStringValueType;
          End;
        tcInt:
           DataBinding.ValueTypeClass := TcxIntegerValueType;
        tcReal:
          Begin
            DataBinding.ValueTypeClass := TcxFloatValueType;
          End;
        tcCampoData:
          DataBinding.ValueTypeClass := TcxDateTimeValueType;
        else
          DataBinding.ValueTypeClass := TcxStringValueType;
      end;
  End;
End;

Function MontaBanded(Tv : TcxGridDBBandedTableView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo; Largura: Integer = 65):TcxGridDBBandedColumn;
Begin
  Result := Tv.CreateColumn as TcxGridDBBandedColumn;
  with Result do
  Begin
    Caption := Titulo;
    Width := Largura;
    DataBinding.FieldName := NomeCampo;
     case TipoCampo of
        tcString:
          Begin
            DataBinding.ValueTypeClass := TcxStringValueType;
          End;
        tcInt:
           DataBinding.ValueTypeClass := TcxIntegerValueType;
        tcReal:
          Begin
            DataBinding.ValueTypeClass := TcxFloatValueType;
          End;
        tcCampoData:
          DataBinding.ValueTypeClass := TcxDateTimeValueType;
        else
          DataBinding.ValueTypeClass := TcxStringValueType;
      end;
  
  End;
End;



procedure Exec_SQL(StrSQL: String);
var
  Qry : TpFIBQuery;
  i : Integer;
Begin
  Try
    Qry := TpFIBQuery.Create(nil);
    Qry.Database := DMConexao.Conexao;
    Qry.Transaction := DMConexao.Trans;
    Qry.ParamCheck := True;
    Qry.SQL.Clear;
    Qry.SQL.Add(StrSQL);
    Qry.ExecQuery;
  Finally
    FreeAndNil(Qry);
  End;

end;


//Procedure FormataMascara(PesquisaEdit : TaqPesquisaMaskEdit_Pan ;TipoCampo : TTipoCampo);
//Begin
//    case TipoCampo  of
//    tcData:
//      PesquisaEdit.EditMask := MascaraData;
//    tcCEP :
//      PesquisaEdit.EditMask := MascaraCEP;
//    tcCNPJ :
//      PesquisaEdit.EditMask := MascaraCNPJ;
//    tcCPF :
//      PesquisaEdit.EditMask := MascaraCPF;
//  end;
//
//End;


//Procedure VerificaEdit(Edit : TaqPesquisaMaskEdit_Pan;  MsgVazio : String) ;
//Begin
//  if EDit.ValorChave < 0  then
//  Begin
//    if MsgVazio = '' then
//       Abort;
//    Avisa(MsgVazio);
//    Edit.SetFocus;
//    Abort;
//  End;
//End;


Procedure SetRegistros(Cds :TDataSet; TipoPesquisa : TTipoPesquisa );
var
  uk : TTipoAlteracao;
  CampoChave , Tabela, Filtro : String;
  UsaFiltro : Boolean;
  vAfter : TDataSetNotifyEvent;
  Lst : TStringList;
  I: Integer;
Begin
  Try
    Try
      Lst := TStringList.Create;
      Lst.Delimiter := ';';
      Lst.DelimitedText := InfoSistema.SQLs.GetMySQL(TipoPesquisa, '').DesconsiderarCampos;
      for I := 0 to Lst.Count - 1 do
      Begin
        if Cds.FindField(Lst[i])<> nil then
          Cds.FieldByName(Lst[i]).ProviderFlags := [];
      End;
    Finally
      FreeAndNil(Lst);
    End;

    CampoChave := GetCampoChave(TipoPesquisa);
    Tabela := GetTabela(TipoPesquisa);
    UsaFiltro := cds.Filtered;
    Filtro := Cds.Filter;
    vAfter  := Cds.AfterScroll ;
    Cds.AfterScroll := nil;
    Cds.DisableControls;
    Cds.Filtered := False;
    Cds.Filter := 'FLAGEDICAO IN (''I'', ''E'' , ''D'',''U'')';
    Cds.Filtered := True;
    Cds.First;
    while not Cds.Eof do
    Begin
      if Cds.FieldByName('flagedicao').AsString = 'N' then
      Begin
        Cds.Next;
        Continue;
      End;
      if Cds.FieldByName('flagedicao').AsString = 'I' then
        uk := taInsere;
      if Cds.FieldByName('flagedicao').AsString = 'E' then
        uk := taModifica;
      if Cds.FieldByName('flagedicao').AsString = 'D' then
        uk := taDeleta;
      if Cds.FieldByName('flagedicao').AsString = 'U' then
        uk := taInsertOrUpdate;
      AlteraBanco(uk,Cds, Tabela, CampoChave);
      Cds.Next;
    End;
  Finally
    Cds.Filtered := False;
    Cds.Filter := Filtro;
    Cds.Filtered := UsaFiltro;
    Cds.AfterScroll := vAfter;
    Cds.EnableControls;
  End;
  

End  ;

Procedure AlteraBanco(TipoAlteracao : TTipoAlteracao; Cds : TDataSet;
                      NomeTabela : String;
                      CampoChave : String;GravaTodos : Boolean = False);
var
  StrSQL,  Campos,
  vSep, StrParam , StrParam2: String;
  Q : TpFIBQuery;
  i, r: Integer;
  Stream : TMemoryStream;
Begin
  Try
    Q := TpFIBQuery.Create(nil);
    Q.Database := DMConexao.Conexao;
    Q.Transaction := DMCOnexao.Trans;
    Q.Close;
    for I := 0 to Cds.Fields.Count - 1 do
    Begin
      if cds.Fields[i].ProviderFlags <> [] then
      Begin
        if (UpperCase(cds.Fields[i].FieldName) <> UpperCase(CampoChave) ) then
        Begin
           StrParam2 := StrParam2 +IfThen(StrParam2 <> '',  ',', '')+':'+ Cds.Fields[i].FieldName;
           Campos := Campos + IfThen(Campos <> '',  ',', '') + Cds.Fields[i].FieldName;
           StrParam := StrParam + IfThen(StrParam <> '',  ',', '')+IfThen(TipoAlteracao = taModifica,Cds.Fields[i].FieldName+'=','') +':'+ Cds.Fields[i].FieldName;
        End else
          if TipoAlteracao in [taInsere, taInsertOrUpdate] then
          Begin
             Campos := Campos + IfThen(Campos <> '',  ',', '') + Cds.Fields[i].FieldName ;
             StrParam := StrParam + IfThen(StrParam <> '',  ',', '')+IfThen(TipoAlteracao = taModifica ,Cds.Fields[i].FieldName+'=','') +':'+ Cds.Fields[i].FieldName;
          End;

      End;
    End;
    Try
      case TipoAlteracao of
        taInsere:
           Begin
             STrSQL := 'Insert into ' + NomeTabela +
                       '('+Campos+')  Values ('+
                         StrParam+ ') ';
           End;
        taDeleta:
           Begin
             StrSQL :=
               'DELETE FROM '+NomeTabela+
               ' WHERE '+CampoChave + ' = '+ IfThen(InfoSistema.UsaGuidChave,QuotedStr(Cds.FieldByName(CampoChave).AsString),Cds.FieldByName(CampoChave).AsString);
           End;
        taModifica:
          Begin
            StrSQL :=
              'UPDATE '+NomeTabela+' SET '+ StrParam+
              ' WHERE '+CampoChave +' = ' + IfThen(InfoSistema.UsaGuidChave,QuotedStr(Cds.FieldByName(CampoChave).AsString),Cds.FieldByName(CampoChave).AsString);
          End;
        taInsertOrUpdate :
          Begin
            StrSQL :=
              'update or insert into '+ NomeTabela+'('+Campos+') values ('+ StrParam+')'+
              ' MATCHING ('+ CampoChave+')';
          End;


      end;
      Q.SQL.Text := StrSQL;
      Q.ParamCheck := True;
      Q.Prepare;
        for I := 0 to Q.Params.Count   - 1 do
        Begin
          if Cds.FieldByName(Q.Params[i].Name).ProviderFlags = [] then
            Continue;
          if Cds.FieldByName(Q.Params[i].Name).IsNull then
            Q.Params[i].Clear
          else
          Begin
//            if Cds.FieldByName(Q.Params[i].Name).DataType in [ftBlob, ftGraphic, ftMemo, ftFmtMemo, ftWideMemo] then
//            Begin
//              Stream := TMemoryStream.Create;
//              TBlobField(Cds.FieldByName(Q.Params[i].Name)).SaveToStream(Stream);
//              TBlobField(Q.Params[i]).LoadFromStream(Stream);
//              Stream.Free;
//            End
//            ELSE
              Q.Params[i].Value := Cds.FieldByName(Q.Params[i].Name).Value;
          End;

        End;

       Q.ExecQuery;

    Except
      on e: Exception do
      Begin
        Raise;
      End;
    End;
  Finally
    FreeAndNil(Q);
  End;

End;
procedure AcertaPadroesData;
const
  arrShortDayNames: array[1..7] of string[3] = ('Dom','Seg','Ter','Qua', 'Qui','Sex','Sab');
  arrLongDayNames: array[1..7] of string[15] = ('Domingo','Segunda-Feira','Terça-Feira', 'Quarta-Feira','Quinta-Feira','Sexta-Feira', 'Sábado');
  arrShortMonthNames: array[1..12] of string[3] = ('Jan','Fev','Mar','Abr', 'Mai','Jun','Jul','Ago','Set','Out','Nov','Dez');
  arrLongMonthNames: array[1..12] of string[15] = ('Janeiro','Fevereiro', 'Março','Abril','Maio', 'Junho','Julho','Agosto', 'Setembro','Outubro', 'Novembro','Dezembro');
var ii: integer;
begin
  Application.UpdateFormatSettings := False;
  NegCurrFormat := 14;
  SysUtils.ShortDateFormat := 'dd/mm/yyyy';
  DateSeparator := '/';
  for ii := 1 to 7 do
  begin
    ShortDayNames[ii] := arrShortDayNames[ii];
    LongDayNames[ii] := arrLongDayNames[ii];
  end;
  for ii := 1 to 12 do
  begin
    ShortMonthNames[ii] := arrShortMonthNames[ii];
    LongMonthNames[ii] := arrLongMonthNames[ii];
  end;
   Application.UpdateFormatSettings := True;
end;



//
//Function GetCodigo(NomeTabela , NomeCampo : String; TipoChave : TTipoChave = ttcChave): String;
//var
//  StrSQL, vCod : String;
//
// Function GetValCodigo : String;
// var
//   SQl : String;
// Begin
//   SQL :=
//     'select coalesce(max(c.valor),0)+1 valor  '+
//     '  from codigo c  '+
//     ' where c.nometabela = '+ QuotedStr(NomeTabela)+
//     '   and c.nomecampo = '+ QuotedStr(NomeCampo) ;
//   Result :=  GetValorCds(SQl);
// End;
//begin
//  vCod := GetValCodigo;
//  if vCod = '1' then
//  Begin
//   vCod := GetValorCds(
//                        'select coalesce(max('+NomeCampo+'),1) Valor'+
//                        '  from '+NomeTabela);
//
//
//    StrSQL :=
//      'INSERT INTO Codigo  '+
//      '       (nomecampo, nometabela, valor) '+
//      'VALUES ('+QuotedStr(nomecampo)+', '+QuotedStr(nometabela)+', '+vCod+')';
//  End else
//    StrSQL :=
//      'update codigo '+
//      '   set valor = '+vCod+
//      ' where nomecampo = '+QuotedStr(nomecampo)+
//      '   and nometabela = '+ QuotedStr(NomeTabela);
//  Try
//    if TipoChave = ttcCodigo then
//       vCod := FormatFloat('000000',StrToInt(vCod) );
//    DMConexao.Conexao.Conexoes[UsuarioLogado.Conexao].StartTrans;
//    Exec_SQL(StrSQL);
//    DMConexao.Conexao.Conexoes[UsuarioLogado.Conexao].Commit;
//    Result := vCod;
//  except
//    on e: Exception do
//    Begin
//      DMConexao.Conexao.Conexoes[UsuarioLogado.Conexao].RollBack;
//      raise;
//    End;
//
//  End;
//
//End;

Function GetCodigo(TipoPesquisa : TTipoPesquisa; TipoChave : TTipoChave = ttcChave;UsaMaxParaCodigo: Boolean = False): String;overload;
var
  StrSQL, NomeSEQ : String;
  R, Inc : Integer;
Begin
  NomeSEQ := UpperCase('SEQ_'+Copy(GetCampoChave(TipoPesquisa),1,27));
  if TipoChave = ttcChave then
  begin
    Inc := 1;
    if InfoSistema.UsaGuidChave then
    begin
      StrSQL :=
        'SELECT RESULT '+
        '  FROM GERACHAVE('+QuotedStr(NomeSEQ)+')';
      Result :=  GetValorCds(StrSQL);
      Exit;
    end;
  end else
  begin
      Inc := 0;
  end;
  R := GetValSeq(NomeSEQ, Inc);
  Result := IntToStr(R);
  if UsaMaxParaCodigo then
  Begin
    try
      StrSQL :=
         'SELECT MAX(CAST('+GetCampoCodigo(TipoPesquisa)+' AS INTEGER) )CAMPO '+
         '  FROM '+GetTabela(TipoPesquisa);
      NomeSEQ := GetValorCds(StrSQL);
      R := StrToIntDef(NomeSEQ,0)+1;;
    except
      //R := Result;
    end;
  End;

  if TipoChave = ttcCodigo then
     Result := FormatFloat('000000', R);

End;


Function GetValorCds(StrSQL : String; IndexField : Integer = 0) : String;
begin
  with GetCds(StrSQL) do
  Begin
    Result := Fields[0].AsString;
    Free;
  end;
End;
Function GetValorCds(StrSQL : String; FieldName : String) : String;
Begin
  with GetCds(StrSQL) do
  Begin
    Result := FieldByName(FieldName).AsString;
    Free;
  End;

End;

procedure Avisa(msg: String);
begin
  Application.MessageBox(PChar(msg), 'Atenção',MB_ICONEXCLAMATION+ MB_OK);
end;

procedure AvisaErro(msg: String; Abortar : Boolean = True);
begin
  Application.MessageBox(PChar(msg), 'Erro',MB_IconError + MB_OK);
  if Abortar then
   Abort;
end;


Function Pergunta(Msg : String) : Boolean;
Begin
  Result := Application.MessageBox(Pchar(Msg),'Atenção', 4) = 6 ;
End;
Function ConfirmaDel : Boolean;
Begin
  Result := Application.MessageBox('Confirma exclusão ? ','Atenção', 4) = 6 ;
End;
Function RetornaData(Data : TDateTime; UsaAspas : Boolean = True) : String;
Begin
  Result := IfThen(UsaAspas , QuotedStr(FormatDateTime('dd.mm.yyyy', Data)),FormatDateTime('dd.mm.yyyy', Data)) ;
End;
Procedure FormataMascara(var Edit : TMaskEdit ;TipoCampo : TTipoCampo);overload;
Begin
  case TipoCampo  of
    tcCampoData:
      Edit.EditMask := MascaraData;
    tcCEP :
      Edit.EditMask := MascaraCEP;
    tcCNPJ :
      Edit.EditMask := MascaraCNPJ;
    tcCPF :
      Edit.EditMask := MascaraCPF;
  end;

End;

Procedure FormataMascara(Field : TField ;TipoCampo : TTipoCampo);overload;
Begin
  case TipoCampo  of
    tcCampoData:
      (Field as TDateField).EditMask :=MascaraData;
    tcCEP :
      (Field as TStringField).EditMask := MascaraCEP;
    tcCNPJ :
    Begin
      (Field as TStringField).EditMask := MascaraCNPJ;
    End;
    tcCPF :
      (Field as TStringField).EditMask :=   MascaraCPF;
    tcReal :
    begin
      Try
        (Field as TBCDField).DisplayFormat :=  MascaraFloat;
        (Field as TBCDField).EditFormat :=  '';
      Except
        (Field as TFloatField).DisplayFormat :=  MascaraFloat;
        (Field as TFloatField).EditFormat :=  '';
      End;
    end;
    tcMoeda :
      Begin
        (Field as TBCDField).DisplayFormat :=  MascaraMoeda;
        (Field as TBCDField).EditFormat :=  '';//MascaraFloat;
      End;
    tcPercent:
      Begin
        Try
          (Field as TBCDField).EditFormat :=  '';
          (Field as TBCDField).DisplayFormat := MascaraFloatPercentual;
        except
          (Field as TFloatField).DisplayFormat := MascaraFloatPercentual;
          (Field as TFloatField).EditFormat :=  '';
        End;
      End;
  end;

End;

Procedure VerificaEdit(Edit : TEditPesquisa;  MsgVazio : String) ;overload;
 procedure AtivaTabSeet;
 var
   Tab: TcxTabSheet;
   Parent: TWinControl;
 begin
    Parent := Edit.Parent;
    while (not (Parent is  TcxTabSheet))   do
    begin
      if not Assigned(Parent.Parent) then
      begin
        Parent := nil;
        Break;
      end else
        Parent := Parent.Parent;


    end;
    if Parent <> nil then
      (Parent as TcxTabSheet).PageControl.ActivePage := (Parent as TcxTabSheet);
 end;

Begin
  if Edit.IsNull  then
  Begin
    Avisa(MsgVazio);
    AtivaTabSeet;
    if Edit.CanFocus then
       Edit.SetFocus;
    abort;
  End;

End;

Procedure VerificaEdit(Cds : TpFIBClientDataSet ;Edit : TDBEdit; MsgExiste, MsgVazio : String) ;
function ExisteRegistro : Boolean;
  var
    vCdsClone : TpFIBClientDataSet;
  Begin
    Try
      vCdsClone := TpFIBClientDataSet.Create(nil);
      vCdsClone.CloneCursor(CDs, True);
      Result := vCdsClone.Locate(Edit.DataField, cds.FieldByName(Edit.DataField).Value , []);
    Finally
      FreeAndNil(vCdsClone);
    End;
  End;
Begin
  if Trim(EDit.Text) = '' then
  Begin
    if MsgVazio = '' then
       Exit;
    Avisa(MsgVazio);
    Edit.SetFocus;
    Abort;
  End;
  if MsgExiste <> '' then
  Begin
   if Cds.State = dsInsert then
      if ExisteRegistro then
      Begin
        Avisa(MsgExiste);
        Edit.SetFocus;
        Abort;
      End;
  End;
end;

Procedure VerificaEdit(Cds : TpFIBClientDataSet ;Edit : TLabelDBEdit; MsgExiste, MsgVazio : String) ;overload;
function ExisteRegistro : Boolean;
  var
    vCdsClone : TpFIBClientDataSet;
  Begin
    Try
      vCdsClone := TpFIBClientDataSet.Create(nil);
      vCdsClone.CloneCursor(CDs, True);
      Result := vCdsClone.Locate(Edit.DataField, cds.FieldByName(Edit.DataField).Value , []);
    Finally
      FreeAndNil(vCdsClone);
    End;
  End;
Begin
  if Trim(EDit.Text) = '' then
  Begin
    if MsgVazio = '' then
       Exit;
    Avisa(MsgVazio);
    Edit.SetFocus;
    Abort;
  End;
  if MsgExiste <> '' then
  Begin
   if Cds.State = dsInsert then
      if ExisteRegistro then
      Begin
        Avisa(MsgExiste);
        Edit.SetFocus;
        Abort;
      End;
  End;

End;

Procedure VerificaEdit(Edit : TEdit;  MsgVazio : String) ;
Begin
  if Trim(EDit.Text) = '' then
  Begin
    if MsgVazio = '' then
       Abort;
    Avisa(MsgVazio);
    Edit.SetFocus;
    Abort;
  End;
End;
Function GetData(Data : TDate ; Aspas : Boolean = True) : String; Overload;
Begin
  Result := FormatDateTime('dd.mm.yyyy',Data);
  if Aspas  then
    Result := QuotedStr(Result );
End;

Function GetData(Data : String ; Aspas : Boolean = True) : String; Overload;
Begin
  if IsDate(Data) then
    Result := FormatDateTime('dd.mm.yyyy',StrToDateTime(Data));
  if Aspas  then
    Result := GetStr(Result );
End;

Function GetTime(Hora : String; Aspas : Boolean = True): String;overload;
Begin
   Result := GetTime(StrToTime(Hora), Aspas) ;
End;
Function GetTime(Hora : TTime; Aspas : Boolean = True): String;overload;
Begin
  Result := FormatDateTime('HH:MM:SS', Hora) ;
  if Aspas then
    Result := QuotedStr(Result);
End;

Function Verifica_CPF(Cpf : String ) : Boolean ;
const
  _len_max = 11;
var
  Digitos: array[1.._len_max] of Byte;
  i, DV1, DV2: Short;
  Calculo: Integer;
  tmp: String[_len_max];
begin
  Result := True;
  if Trim(CPF) = '' then
    Exit;
  tmp := CPF;
  try
    while Length(tmp) < _len_max do
      tmp := tmp + '0';
    for i := 1 to _len_max do
      Digitos[i] := StrToInt(tmp[i]);
  except
    Result := False;
  end;

  // obtém o primeiro dígito verificador
  Calculo := (10 * Digitos[1]) + (9 * Digitos[2]) + (8 * Digitos[3]) +
    (7 * Digitos[4]) + (6 * Digitos[5]) + (5 * Digitos[6]) +
    (4 * Digitos[7]) + (3 * Digitos[8]) + (2 * Digitos[9]);
  DV1 := 11 - (Calculo mod 11);
  if (DV1 >= 10) then DV1 := 0;

  // obtém o segundo dígito verificador
  Calculo := (11 * Digitos[1]) + (10 * Digitos[2]) + (9 * Digitos[3]) +
    (8 * Digitos[4]) + (7 * Digitos[5]) + (6 * Digitos[6]) +
    (5 * Digitos[7]) + (4 * Digitos[8]) + (3 * Digitos[9]) + (2 * DV1);
  DV2 := 11 - (Calculo mod 11);
  if (DV2 >= 10) then DV2 := 0;

  // compara os dígitos
  Result := (Digitos[10] = DV1) and (Digitos[11] = DV2);

End;


Function Verifica_CNPJ(CNPJ : String ) : Boolean ;
var
  Digitos: array[1..14] of Byte;
  i, Resto, DV1, DV2: ShortInt;
  Calculo: Integer;
  tmp: String[14];

begin
  Result := True;
  if Trim(CNPJ) = '' then
    Exit;
  tmp := CNPJ;
  try
    while Length(tmp) < 14 do
      tmp := tmp + '0';
    for i := 1 to 14 do
      Digitos[i] := StrToInt(tmp[i]);
  except
    Result := False;
  end;
  // obtém o primeiro dígito verificador
  Calculo := (5 * Digitos[1]) + (4 * Digitos[2] ) +
    (3 * Digitos[3]) + (2 * Digitos[4]) + (9 * Digitos[5]) +
    (8 * Digitos[6]) + (7 * Digitos[7]) + (6 * Digitos[8]) +
    (5 * Digitos[9]) + (4 * Digitos[10]) + (3 * Digitos[11]) +
    (2 * Digitos[12]);
  Resto := Calculo mod 11;
  if (Resto = 0) or (Resto = 1) then
    DV1 := 0
  else
    DV1 := 11 - Resto;

  // obtém o segundo dígito verificador
  Calculo := (6 * Digitos[1]) + (5 * Digitos[2]) + (4 * Digitos[3]) +
    (3 * Digitos[4]) + (2 * Digitos[5]) + (9 * Digitos[6]) +
    (8 * Digitos[7]) + (7 * Digitos[8]) + (6 * Digitos[9]) +
    (5 * Digitos[10]) + (4 * Digitos[11]) + (3 * Digitos[12]) +
    (2 * DV1);
  Resto := Calculo mod 11;
  if (Resto = 0) or (Resto = 1) then
    DV2 := 0
  else
    DV2 := 11 - Resto;

  // compara os dígitos
  Result := (Digitos[13] = DV1) and (Digitos[14] = DV2);

End;

Function Verifica_Inscricao_Estadual(IE,UF : String ) : Boolean ;
var
  IRet, IOk, IErro, IPar    : Integer;

  LibHandle                 : THandle;
  ConsisteInscricaoEstadual : function (const Insc, UF: String): Integer; stdcall;
begin

  try
    LibHandle :=  LoadLibrary (PChar (Trim ('DllInscE32.Dll')));
    if  LibHandle <=  HINSTANCE_ERROR then
      raise Exception.Create ('Dll não carregada');

    @ConsisteInscricaoEstadual  :=  GetProcAddress (LibHandle, 'ConsisteInscricaoEstadual');
    if  @ConsisteInscricaoEstadual  = nil then
      raise Exception.Create('Entrypoint Download não encontrado na Dll');



    IRet := ConsisteInscricaoEstadual (IE,UF);
    Result := Iret = 0 ;


  finally
    FreeLibrary (LibHandle);
  end;

end;

Function ExisteRegistroCds(CdsOrigem, CdsDestino : TpFIBClientDataSet  ;NomeCampoOrigem, NomeCampoDestino : String ) : Boolean;
var
  CdsClone : TpFIBClientDataSet;
begin
   CdsClone := TpFIBClientDataSet.Create(nil);
   Try
     CdsClone.CloneCursor(CdsDestino, False);
     Result := CdsClone.Locate(NomeCampoDestino, CdsOrigem.FieldByName(NomeCampoOrigem).AsString, []);
   Finally
     FreeAndNil(CdsClone);
   End;
End;

Function GetNumber(Valor : Currency ): String;
var
  D : Char;
Begin
  Try
    D := DecimalSeparator;
    DecimalSeparator := '.';
    Result := FormatFloat('0.00', Valor) ;
  Finally
    DecimalSeparator := d;
  End;
End;

Function GetVersaoAplicativo: Ansistring;
var
   VerInfoSize: DWORD;
   VerInfo: Pointer;
   VerValueSize: DWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: DWORD;
   V1, V2, V3, V4: Word;
   Prog : string;
begin
   Try
     Prog := Application.Exename;
     VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);
     GetMem(VerInfo, VerInfoSize);
     GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
     VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
     with VerValue^ do
     begin
       V1 := dwFileVersionMS shr 16;
       V2 := dwFileVersionMS and $FFFF;
       V3 := dwFileVersionLS shr 16;
       V4 := dwFileVersionLS and $FFFF;
    end;
    FreeMem(VerInfo, VerInfoSize);
  //  if formata then
  //    result := FormatFloat('00',v1) + FormatFloat('00',v2) +
  //              FormatFloat('00',v3) + FormatFloat('00',v4)
  //  else
      result := IntToStr (v1) + '.' + IntToStr (v2) + '.' +
                IntToStr (v3) + '.' + IntToStr (v4);

   Except
     Result := '1.0.0.0';
   End;
End;

Function VerificaLabelDbEdit(Form : TForm; CDs :TpFIBClientDataSet; TipoPesquisa: TTipoPesquisa): Boolean;
var
  i : Integer;
  StrSQL: String;
Begin
  Result := True;
  StrSQL:=
    'SELECT RDB$FIELD_NAME campo'+
    '  FROM RDB$RELATION_FIELDS F2 '+
    ' WHERE F2.RDB$RELATION_NAME = '+QuotedStr(GetTabela(TipoPesquisa))+
    '   AND RDB$NULL_FLAG = 1 ';
  with getcds(StrSQL) do
  begin
    for I := 0 to Form.ComponentCount - 1 do
    begin
      if (Form.Components[I] is TEditPesquisa) then
       begin
         if Locate('Campo',(Form.Components[I] as TEditPesquisa).CampoData,[]) and ((Form.Components[I] as TEditPesquisa).IsNull) then
         begin
            AvisaErro('O campo '+LowerCase((Form.Components[I] as TEditPesquisa).lblTitulo.Caption)+' não pode ficar vazio!',False);
           (Form.Components[I] as TEditPesquisa).SetFocus;
           Result := False;
           Break;
         end;
      end;
     if (Form.Components[I] is TcxDBDateEdit) then
       begin
         if Locate('Campo',(Form.Components[I] as TcxDBDateEdit).DataBinding.DataField,[]) and ((Form.Components[I] as TcxDBDateEdit).Text = '') then
         begin
            AvisaErro('Este campo não pode ficar vazio!',False);
           (Form.Components[I] as TcxDBDateEdit).SetFocus;
           Result := False;
           Break;
         end;
      end;


     if (Form.Components[I] is TLabelDBEdit) then
     begin
       if Locate('Campo',(Form.Components[I] as TLabelDBEdit).DataField,[]) and (Trim((Form.Components[I] as TLabelDBEdit).Text) = '')and
          (not (Form.Components[I] as TLabelDBEdit).IsNull)  then
       begin
         if (Form.Components[I] as TLabelDBEdit).MsgNull = '' then
           AvisaErro('O campo '+LowerCase((Form.Components[I] as TLabelDBEdit).Titulo.Caption)+' não pode ficar vazio!',False)
         else
           AvisaErro((Form.Components[I] as TLabelDBEdit).MsgNull);
         (Form.Components[I] as TLabelDBEdit).SetFocus;
         Result := False;
         Break;
       end;

       //Vazio
       if (((Form.Components[I] as TLabelDBEdit).Text) = '') and
         not((Form.Components[I] as TLabelDBEdit).IsNull) and
         ((Form.Components[I] as TLabelDBEdit).CanFocus ) and
         (Form.Components[I] as TLabelDBEdit).Visible then
       begin
         if (Form.Components[I] as TLabelDBEdit).MsgNull = '' then
           AvisaErro('O campo '+LowerCase((Form.Components[I] as TLabelDBEdit).Titulo.Caption)+' não pode ficar vazio!',False)
         else
           AvisaErro((Form.Components[I] as TLabelDBEdit).MsgNull);
         (Form.Components[I] as TLabelDBEdit).SetFocus;
         Result := False;
         Break;
       end else //Repetido
       if not(Form.Components[I] as TLabelDBEdit).PodeRepetir then
       begin
         if ((Form.Components[I] as TLabelDBEdit).Visible ) and
            ((Form.Components[I] as TLabelDBEdit).Text <> '') and
            (ExisteRegistro(Cds,(Form.Components[I] as TLabelDBEdit).DataField))  then
         begin
           AvisaErro('Já existe um registro este valor para o campo '+(Form.Components[I] as TLabelDBEdit).Titulo.Caption+'!',False);
           (Form.Components[I] as TLabelDBEdit).SetFocus;
           Result := False;
           Break;
         end;
       end;
     end;
    end;
    Free;
  end;

End;

Function ExisteRegistro(Cds : TpFIBClientDataSet;NomeCampo : String; VerificaEmEdicao : Boolean = False; VerificaFiltro: Boolean = False) : Boolean;
var
  CdsClone : TpFIBClientDataSet;
  List : TStringList;
  Valor : String;
  MyArray : Array of AnsiString;
  Procedure GetValores;
  var
    I: Integer;
  Begin
    SetLength(MyArray,List.Count );
    for I := 0 to List.Count - 1 do
    Begin
      MyArray[i] := Cds.FieldByName(List[i]).AsString;
    End;
  End;
begin
    Result :=  False;
   if not VerificaEmEdicao then
     if Cds.State in [dsEdit] then
       Exit;
   CdsClone := TpFIBClientDataSet.Create(nil);
   List := TStringList.Create;
   List.Delimiter := ';';
   List.StrictDelimiter := True;
   List.DelimitedText := NomeCampo;
   Try
     CdsClone.CloneCursor(Cds, True);
     GetValores;
     if VerificaFiltro then
     begin
       CdsClone.Filter := Cds.Filter;
       CdsClone.Filtered := Cds.Filtered;
     end;

     Result := CdsClone.Locate(NomeCampo, MyArray, [loCaseInsensitive]);
   Finally
     FreeAndNil(List);
     FreeAndNil(CdsClone);
   End;

End;
Function ExisteRegistro(TipoPesquisa : TTipoPesquisa; NomeCampo : String; Valor : String) : Boolean;overload;
var
  Cds : TpFIBClientDataSet;
  StrSQL :String;
Begin
  Try
    Cds := TpFIBClientDataSet.Create(nil);
    StrSQL :=
      ' select '+GetCampoChave(TipoPesquisa)+
      '   from '+ GetTabela(TipoPesquisa)+
      '  where '+NomeCampo +' = '+ QuotedStr(Valor);
    Setcds(Cds, StrSQL);
    Result := not Cds.IsEmpty;
  Finally
    FreeAndNil(Cds);
  End;
End;

Procedure AbrePesquisa(Sender : TObject;ADataSet : TDataSet; aTipoPesquisa: Integer; Titulo : String; Out Resultado : Variant);
var
  Texto: String;
Begin
  Try
    Texto := '';
    if (Sender as TEditPesquisa).DataSet <> nil Then
    Begin
      if not ((Sender as TEditPesquisa).DataSet.State in [dsInsert, dsEdit] )then
      Begin
        if (Sender as TEditPesquisa).DataSet.IsEmpty Then
          (Sender as TEditPesquisa).DataSet.Append
        else
          (Sender as TEditPesquisa).DataSet.Edit;
      End;
    End;
    Texto := (Sender as TEditPesquisa).Text;
    frmPesquisa := TfrmPesquisa.Create(nil);
    with frmPesquisa do
    Begin
      TipoPesquisa := TTipoPesquisa(aTipoPesquisa);
      Where := (Sender as TEditPesquisa).SQLComp;
      Titulo := Titulo;
      edtPesquisa.Text := Texto;
      //if edtPesquisa.Text <> '' then
      //   btnPesquisarClick(nil);
      if ShowModal = mrOk then
      Begin        
        Resultado := CdsPesquisa.FieldByName(GetCampoChave(TipoPesquisa)).AsVariant
      End  else
        Resultado := '';
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
End;

Procedure ConfiguraEditPesquisa(var Edit : TEditPesquisa; aDataSet : TpFIBClientDataSet; aTipoPesquisa : TTipoPesquisa;
                                  aObrigatorio: Boolean = False;
                                  aCampoDisplay : String = ''; aTitulo : String = '';
                                  aCampoCodigo: String = 'CODIGO';aCampoData :String = '' ;
                                  aTamanhoCodigo : Integer = 6; FuncaoButaoNovo : TOnClick = nil;
                                  FuncaoButaoEdit : TOnClick = nil);
Begin
  Edit.Conexao := DMConexao.Conexao;
  WITH InfoSistema.SQLs.GetMySQL(aTipoPesquisa, '') do
  Begin
    if aCampoDisplay = '' then
     aCampoDisplay := CampoDisplay;
    if aTitulo = '' then
      aTitulo := Edit.LblTitulo.Caption;
    if aCampoCodigo <> CampoCodigo then
      aCampoCodigo := CampoCodigo;
    if (aTipoPesquisa = tpImoCEP) OR (aTipoPesquisa = tpERPCEP) then
      Edit.EditMask := MascaraCEP;
    Edit.Configurar(aDataSet, CampoChave, NomeTabela+' '+AliasTabela, aCampoDisplay, aTitulo,
                    StrToInt(VarToStr(aTipoPesquisa)), aCampoCodigo,aCampoData, aTamanhoCodigo,aObrigatorio );

    Edit.FuncaoBotaoNovo := FuncaoButaoNovo;
    Edit.FuncaoBotaoEditar := FuncaoButaoEdit;
  End;
End;


procedure SetEditCliente(Var Edit: TEditPesquisa; DataSet : TpFIBClientDataSet; Campodata : String = 'idCliente');
Begin
  ConfiguraEditPesquisa(Edit, DataSet, tpLKimeraCliente, False,'nomecliente', 'Cliente', 'CODIGO', Campodata);
End;

Procedure SetEditEmpresa(Var Edit: TEditPesquisa; DataSet : TpFibClientDataSet);
Begin
  ConfiguraEditPesquisa(Edit, DataSet, tpFlexEmpresa, False,'nomeempresa', 'Loja', 'idempresa', 'idempresa');
End;



Function IsInteger(Value : Variant): Boolean;
Begin
  Try
    Result := True;
    StrToInt(VarToStr(Value));
  Except
    Result := False;
  End;
End;
Function IsString(Value : Variant): Boolean;
Begin
  Try
    Result := True;
    VarToStr(Value);
  Except
    Result := False;
  End;
End;
Function IsDate(Value : Variant): Boolean;
Begin
  Try
    Result := True;
    StrToDate(VarToStr(Value));
  Except
    Result := False;
  End;
End;
Function IsFloat(Value : Variant): Boolean;
Begin
  Try
    Result := True;
    StrToFloat(VarToStr(Value));
  Except
    Result := False;          
  End;
End;
procedure MontaTree(Tree: TcxDBTreeList;Campo, Titulo: String;  Tamanho: Integer = 90);
var
  Col : TcxDBTreeListColumn;
Begin
  if Tree.Bands.Count = 0 then
    Tree.Bands.Create(Tree);
  Col := Tree.CreateColumn as TcxDBTreeListColumn;
  with Col do
  Begin
    Width := Tamanho;
    Caption.Text := Titulo;
    DataBinding.FieldName := Campo;
  End;
 
End;

function GetTableCount(Tabela : String; Campo : String ='*'; Where : String = '1=1' ) : Integer;
var
  Cds : TpFIBClientDataSet;
  StrSQL : String;
Begin
  Try
    Cds := TpFIBClientDataSet.Create(nil);
    StrSQL :=
      'select count('+Campo+')'+
      '  from '+ tabela+
      ' where '+Where;
    SetCds(Cds, StrSQL);
    Result := cds.Fields[0].AsInteger;  
  Finally
    FreeAndNil(Cds);
  End;
End;

Function GetPeriodo(DataIni, DataFin : String; var Variavel : String; CampoBanco : String; UsaDataFinal:Boolean = True; UsaAnd : Boolean = True): Boolean;
Begin
  Result := False;
  if ((DataIni <> '  /  /    ') and (DataIni <> '') ) and (not IsDate(DataIni)) then
    AvisaErro('Data inicial inválida', True);
  if ((DataFin <> '  /  /    ') and (DataFin <> '') )and (not IsDate(DataFin)) then
    AvisaErro('Data final inválida', True);
  Result := True;

  if (((DataIni = '  /  /    ') and (DataFin = '  /  /    ')) or
      ((DataIni = '') and (DataFin = '') )   ) then
    Variavel := ''
  else
    Variavel := IfThen(UsaAnd, ' and ', '')+
                IfThen( ((DataIni <> '  /  /    ') and ( IsDate(DataIni))),  CampoBanco+'>= '+GetData(DataIni)+
                        IfThen((UsaDataFinal) and (DataFin <> '  /  /    '), ' and ',''), '')+
                IfThen((UsaDataFinal) and (DataFin <> '  /  /    '), CampoBanco+' <= '+GetData(DataFin), '');
  

End;

Procedure ConfiguraCx(Sender : TComponent);
Begin
  if Sender is TcxGridDBCardView then
  Begin
      if Sender.Tag <> 99 then
      Begin
       (Sender as TcxGridDBCardView).OptionsSelection.CellSelect := False;
       (Sender as TcxGridDBCardView).OptionsBehavior.GoToNextCellOnEnter := True;
       (Sender as TcxGridDBCardView).OptionsData.Appending := False;
       (Sender as TcxGridDBCardView).OptionsData.CancelOnExit := False;
       (Sender as TcxGridDBCardView).OptionsData.Deleting := False;
       (Sender as TcxGridDBCardView).OptionsData.DeletingConfirmation := False;
       (Sender as TcxGridDBCardView).OptionsData.Editing := False;
       (Sender as TcxGridDBCardView).OptionsData.Inserting := False;
       (Sender as TcxGridDBCardView).OptionsView.CardAutoWidth := True;
      End;
      if DMConexao <> nil then
       (Sender as TcxGridDBCardView).Styles.StyleSheet := DMConexao.StiloCard;
  End else
  if Sender is TcxGridDBTableView then
  Begin
      if Sender.Tag <> 99 then
      Begin
       (Sender as TcxGridDBTableView).OptionsSelection.CellSelect := False;
       (Sender as TcxGridDBTableView).OptionsBehavior.GoToNextCellOnEnter := True;
       (Sender as TcxGridDBTableView).OptionsData.Appending := False;
       (Sender as TcxGridDBTableView).OptionsData.CancelOnExit := False;
       (Sender as TcxGridDBTableView).OptionsData.Deleting := False;
       (Sender as TcxGridDBTableView).OptionsData.DeletingConfirmation := False;
       (Sender as TcxGridDBTableView).OptionsData.Editing := False;
       (Sender as TcxGridDBTableView).OptionsData.Inserting := False;
       (Sender as TcxGridDBTableView).OptionsView.GroupByBox := False;
       (Sender as TcxGridDBTableView).DataController.Options := (Sender as TcxGridDBTableView).DataController.Options+ [dcoGroupsAlwaysExpanded];
      End;
     if DMConexao <> nil then
       (Sender as TcxGridDBTableView).Styles.StyleSheet := DMConexao.StiloGrid;
  End else
  if Sender is TcxGridDBBandedTableView then
  Begin
     if Sender.Tag <> 99 then
     Begin
       (Sender as TcxGridDBBandedTableView).OptionsSelection.CellSelect := False;
       (Sender as TcxGridDBBandedTableView).OptionsBehavior.GoToNextCellOnEnter := True;
       (Sender as TcxGridDBBandedTableView).OptionsData.Appending := False;
       (Sender as TcxGridDBBandedTableView).OptionsData.CancelOnExit := False;
       (Sender as TcxGridDBBandedTableView).OptionsData.Deleting := False;
       (Sender as TcxGridDBBandedTableView).OptionsData.DeletingConfirmation := False;
       (Sender as TcxGridDBBandedTableView).OptionsData.Editing := False;
       (Sender as TcxGridDBBandedTableView).OptionsData.Inserting := False;
       (Sender as TcxGridDBBandedTableView).OptionsView.GroupByBox := False;
     End;
     if DMConexao <> nil then
       (Sender as TcxGridDBBandedTableView).Styles.StyleSheet := DMConexao.StiloBandled;
  End else
  if Sender is TcxDBTreeList then
  Begin
     if Sender.Tag <> 99 then
     Begin
       (Sender as TcxDBTreeList).OptionsSelection.CellSelect := False;
       (Sender as TcxDBTreeList).OptionsBehavior.GoToNextCellOnEnter := True;
       (Sender as TcxDBTreeList).OptionsData.CancelOnExit := False;
       (Sender as TcxDBTreeList).OptionsData.Deleting := False;
       (Sender as TcxDBTreeList).OptionsData.Editing := False;
       (Sender as TcxDBTreeList).OptionsData.Inserting := False;
     End;
     if DMConexao <> nil then
       (Sender as TcxDBTreeList).Styles.StyleSheet := DMConexao.StiloTreeView;
  End ;

End;


function IsNumericDBControl(Controle: TComponent): Boolean;
var
  p : PPropInfo;
  vDataSource: TDataSource;
  vFieldName: String;
begin
  Result := False;
  p := GetPropInfo (Controle.ClassInfo,'DataSource');
  if Assigned(p) then
    vDataSource := (GetObjectProp(Controle,'DataSource') as TDataSource);
  p := GetPropInfo (Controle.ClassInfo,'DataField');
  if Assigned(p) or (vFieldName <> '') then
  Begin
    if vFieldName = '' then    
      vFieldName := GetStrProp(Controle,'DataField');
    if (vDataSource<>nil) and
       (vDataSource.DataSet <> nil) and
       (vDataSource.DataSet.FindField(vFieldName) <> nil) then
    Case vDataSource.DataSet.FieldByName(vFieldName).DataType of
    ftFloat, ftCurrency, ftBCD, ftFMTBcd:
      Result := True
    else
      Result := False;
    End;
  End;

end;

procedure StartTrans(pTrans : TpFIBTransaction = nil);
Begin
  if pTrans = nil then
    pTrans := DMConexao.Trans;
  if not pTrans.InTransaction then
    pTrans.StartTransaction;
End;
procedure Commit(pTrans : TpFIBTransaction = nil);
Begin
  if pTrans = nil then
    pTrans := DMConexao.Trans;
  pTrans.Commit;
End;

procedure RollBack(pTrans : TpFIBTransaction = nil);
Begin
  if pTrans = nil then
    pTrans := DMConexao.Trans;
  if pTrans.InTransaction then
   pTrans.Rollback;
End;

Function GetValSeq(Const NomeSec: String; Inc :Integer = 1) : Integer;
var
  StrSQL : String;
  Qry : TpFIBDataSet;
  TransAux : TpFIBTransaction;
Begin
  Try
    TransAux := TpFIBTransaction.Create(nil);
    TransAux.DefaultDatabase := DMCOnexao.Conexao;
    TransAux.TPBMode := tpbReadCommitted;
    Qry := TpFIBDataSet.Create(Nil);
    Qry.Database := DMConexao.Conexao;
    Qry.Transaction := TransAux;
    Try
      StartTrans(TransAux);
      Qry.Close;
      Qry.SQLs.SelectSQL.Text := 'SELECT GEN_ID('+NomeSec+', '+IntToStr(Inc)+') VALOR  FROM RDB$DATABASE';
      Qry.Open;
      Result := Qry.FieldByName('VALOR').AsInteger;
      Commit(TransAux);
    Except
      on E: Exception do
      Begin
        RollBack(TransAux);
        Raise;
      End;
    End;
  Finally
    FreeAndNil(TransAux);
    FreeAndNil(Qry);
  End;
End;


function GetStr(Valor : String): String;
Begin
  Result := IfThen(Valor = '', ' null ', QuotedStr(Valor));
End;

procedure ImprimeRelatorio(IdRelatorio: Integer; CdsMaster,CdsDetalhe,CdsInformacoes : TpFIBClientDataSet;
                            TipoTratamento : TTratamentoLayout;pCdsExtras : Array of TpFIBClientDataSet;
                           Copias : Integer = 1; IdLayout : Integer = -1);
 var
    Lista:  TStringList;
    vImpressoraPadrao : AnsiString;
  I, Extras, X: Integer;
  ppDataSource: array of TppDBPipeline;
  DataSource : Array of TDataSource;
 Procedure ImprimeList(Lista : TStringList);
 var
   i : Integer;
 Begin
   for I := Lista.Count - 1 downto 0 do
   Begin
     if Trim(Lista.Strings[i]) = '' then
       Lista.Delete(i);
   End;

   for I := 0 to Lista.Count - 1 do
     DmRelatorio.RDprint.Imp(i,0,Lista.Strings[i]);

 End;
Begin
  Try
    DmRelatorio := TDmRelatorio.Create(nil);
    with DmRelatorio do
    Begin
       if IdLayout = -1 then
         SetCds(CdsLayout, GetSelect(tpLayout, ' L.IDRELATORIO = '+IntToStr(IdRelatorio)+ ' AND COALESCE(L.FLAGPADRAO,''N'') = ''Y'' '))
       else
         SetCds(CdsLayout, GetSelect(tpLayout, ' L.IDLAYOUT = '+IntToStr(IdLayout)));

       ppDBLayout.DataSource.DataSet := CdsLayout;
       DataMaster.DataSet := CdsMaster;
       DataDetalhes.DataSet := CdsDetalhe;
       DataInformacoes.DataSet := CdsInformacoes;
       Extras := 0;
       X := Length(pCdsExtras)-1;
       for I := Low(pCdsExtras) to x do
       Begin
        if Assigned(pCdsExtras[i])  then
          Inc(Extras);
       End;
        if Extras > 0 then
        Begin
          SetLength(DataSource, Extras);
          SetLength(ppDataSource, Extras);
        End;
       Report.BeginUpdate;
       for I := 0 to Extras -1 do
       Begin
         DataSource[i] := TDataSource.Create(DmRelatorio);
         ppDataSource[i] := TppDBPipeline.Create(DmRelatorio);
         DataSource[i].DataSet := pCdsExtras[i];
         ppDataSource[i].DataSource := DataSource[i];
         ppDataSource[i].Visible := True;
         if pCdsExtras[i].Name <> '' then
         Begin
           ppDataSource[i].UserName := pCdsExtras[i].Name;
           ppDataSource[i].Name := pCdsExtras[i].Name;
         End;
       End;

       Report.EndUpdate;
       pIdRelatorio := IdRelatorio;
       Report.Template.DatabaseSettings.DataPipeline := ppDBLayout;
       Report.Template.DatabaseSettings.NameField := 'NOMELAYOUT';
       Report.Template.DatabaseSettings.TemplateField := 'TEMPLATE';
       Report.Template.DatabaseSettings.Name := CdsLayout.FieldByName('NOMELAYOUT').AsString;
       Report.Template.SaveTo :=  stDatabase;


       if not (TipoTratamento in [tlNovo,tlLista])  then
         Report.Template.LoadFromDatabase;
       Report.DeviceType := 'Screen';
       case TipoTratamento of
         tlTela:
           Begin
             Report.Device := dvScreen;
             Report.Print;
           End;
         tlImpressora:
           Begin
              if CdsLayout.FieldByName('IMPRESSORAPADRAO').AsString <> '' then
                vImpressoraPadrao := CdsLayout.FieldByName('IMPRESSORAPADRAO').AsString;

             if CdsLayout.FieldByName('FLAGTIPOLAYOUT').AsString = 'G' then
             Begin
               Report.Device := dvPrinter;
               Report.DeviceType := 'Printer';
               if vImpressoraPadrao <> '' then
               Begin
                 Report.ShowPrintDialog := False;
                 Report.Printer.PrinterName := vImpressoraPadrao;
               end else
                 Report.ShowPrintDialog := True;
               Report.Print;
             End else
             Begin
               if vImpressoraPadrao = '' then
                 vImpressoraPadrao := GetImpressoraPadrao;

               RDprint.SetPrinterbyName(vImpressoraPadrao);
               RDprint.MostrarProgresso := False;
               RDprint.NumerodeCopias := Copias;
               Try
                 Lista := TStringList.Create;
//                 gtRB.Engine := gtText;
//                 IgtDocumentEngine(gtRB.Engine).FileName := 'C:\teste.txt';
//                 IgtDocumentEngine(gtRB.Engine).Preferences.UseImagesAsResources := False;
//                 IgtDocumentEngine(gtRB.Engine).Preferences.ProcessAfterEachPage := True;
//                 gtRB.RenderDocument(Report);
                 if FileExists('C:\teste.txt') then
                 Begin
                   RDprint.Imprimindo('C:\teste.txt');
  //                 Lista.LoadFromFile('C:\teste.txt');
  //                 RDprint.Abrir;
  //                 ImprimeList(Lista);
                   DeleteFile('C:\teste.txt');
                 end;

               finally
                 if RDprint.EstaAberto Then
                   RDprint.Fechar;
                 FreeAndNil(Lista);
               end;
             End;
           End;
         tlNovo:
           Begin
             Report.Template.New;
             Designer.ShowModal;
           end;
         tlEditar:
           Begin
             Designer.ShowModal;
           end;
         tlLista:
         Begin
           frmLista_Layouts := TfrmLista_Layouts.Create(nil);
           Try
             frmLista_Layouts.CdsMaster := CdsMaster;
             frmLista_Layouts.CdsDetalhe := CdsDetalhe;
             frmLista_Layouts.IdRelatorio := IdRelatorio;
             SetLength(frmLista_Layouts.CdsExtras,Length(pCdsExtras));
             for I := 0 to Length(pCdsExtras) -1 do
             Begin
               frmLista_Layouts.CdsExtras[i] := pCdsExtras[i];
             End;
             frmLista_Layouts.ShowModal;
           Finally
             FreeAndNil(frmLista_Layouts);
           End;
         End;
       end;
    End;
  Finally
    FreeAndNil(DmRelatorio);
  End;

End;

Function GetLayoutPadrao(IdRelatorio: Integer): Integer;
Begin
  Result :=  StrToIntDef(GetValorCds(GetSelect(tpLayout, ' L.IDRELATORIO = '+IntToStr(IdRelatorio)+ ' AND COALESCE(L.FLAGPADRAO,''N'') = ''Y'' ')),-1);
End;

Function CriaRodapeTableView(Coluna : TcxGridDBColumn; FooterKind: TcxSummaryKind; GroupKind : TcxSummaryKind = skNone) :TcxGridDBColumn;
Begin
  Coluna.Summary.FooterKind := FooterKind;
  Coluna.Summary.GroupKind := GroupKind;
  Coluna.Summary.FooterFormat := MascaraFloat;
  Coluna.Summary.GroupFormat := MascaraFloat;

  Result := Coluna;
End;

Function GetImpressoraPadrao: AnsiString;
var
  Lista : TStringList;
Begin
  Try
    Lista := TStringList.Create;
    Lista.Assign(Printer.Printers);
    Result := Lista.Strings[Printer.PrinterIndex];
  Finally
    FreeAndNil(Lista);
  End;
End;

Function  CriaRodapeBanded(Coluna : TcxGridDBBandedColumn; FooterKind: TcxSummaryKind = skSum; GroupKind : TcxSummaryKind = skNone): TcxGridDBBandedColumn ;
Begin
  Coluna.Summary.FooterKind := FooterKind;
  Coluna.Summary.GroupKind := GroupKind;
  Coluna.Summary.FooterFormat := MascaraFloat;
  Coluna.Summary.GroupFormat := MascaraFloat;
  Result := Coluna;
End;

Function ExisteTabela(Tabela: String): Boolean;
var
  StrSQL : String;
Begin
  StrSQL :=
    'SELECT RDB$RELATION_NAME  '+
    '   FROM RDB$RELATIONS '+
    '  WHERE (RDB$VIEW_BLR IS NULL) '+
    '   AND NOT (SUBSTRING(RDB$RELATION_NAME FROM 1 FOR 4) IN (''MON$'', ''RDB$''))  '+
    '   AND RDB$RELATION_NAME = '+GetStr(Tabela) +
    '  ORDER BY RDB$RELATION_NAME';
  Result := GetValorCds(StrSQL)<> '';
End;

Function GetDescricaoLayout(IdLayout: Integer): String;
var
  StrSQL : String;
Begin
   StrSQL := GetSelect(tpLayout, 'IDLAYOUT = '+IntToStr(IdLayout));
   Result := GetValorCds(StrSQL, 'NOMELAYOUT');
End;

Procedure AbrirArquivo(pFileName : String);
Begin
  if (fileExists(pFileName)) then
    ShellExecute(Application.Handle, nil, Pchar(pFileName), nil, nil, SW_SHOWNORMAL)
  else
    AvisaErro('Arquivo não existe', False);

End;

Function GetDataSet(StrSQL: String): TpFIBClientDataSet;
Begin
  Result := TpFIBClientDataSet.Create(nil);
  SetCds(Result, StrSQL);
End;


Procedure AdicionaListaPesquisa(Var Cds: TpFIBClientDataSet; aTipoPesquisa: TTipoPesquisa;MsgExistente : String; Filtro: String = '');
var
  ID : Variant;
begin
  frmPesquisa := TfrmPesquisa.Create(nil);
  Try
    with frmPesquisa do
    Begin
      TipoPesquisa := aTipoPesquisa;
      Where := Filtro;
      AbreListando := Filtro <> '' ;
      if ShowModal = mrOk then
      Begin
        Id := CdsPesquisa.FieldByName(GetCampoChave(aTipoPesquisa)).Value;
        if Cds.Locate(GetCampoChave(aTipoPesquisa), id, []) then
        Begin
          Avisa(MsgExistente);
          Exit;
        End;
        Cds.Append;
        with InfoSistema.SQLs.GetMySQL(aTipoPesquisa, '')do
        Begin
          Cds.FieldByName(CampoChave).Value := Id;
          Cds.FieldByName(GetCampoCodigo(aTipoPesquisa)).Value := CdsPesquisa.FieldByName(CampoCodigo).Value;
          Cds.FieldByName(CampoDisplay).Value := CdsPesquisa.FieldByName(CampoDisplay).Value;
        End;
        Cds.Post;

      End;
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;

 End;

 Function PadL(aStr: AnsiString; Tamanho : Integer; Caracter : AnsiChar): AnsiString;
 Begin
   if Length(aStr) < Tamanho then
   Begin
     Result := StringOfChar(Caracter, Tamanho- Length(aStr))+aStr;
   End;
 End;

 Function PadR(aStr: AnsiString; Tamanho : Integer; Caracter : AnsiChar): AnsiString;
 Begin
   if Length(aStr) < Tamanho then
   Begin
     Result := aStr+StringOfChar(Caracter, Tamanho- Length(aStr));
   End;
 End;

 Procedure ApagarArquivo(vFileName: AnsiString);
 var
   Sr: TSearchRec;
   Achou: Integer;
 Begin
   Achou := FindFirst(vFileName, faAnyFile, Sr);
   while Achou = 0  do
   Begin
     DeleteFile(ExtractFilePath(vFileName)+Sr.Name);
     Achou := FindNext(Sr);
   End;
 End;

 function GetInteger(Valor : Integer): String;
 Begin
   Result := IfThen(Valor <> -1, IntToStr(Valor), 'null');
 End;

 Function GetCds(StrSQL: String): TpFIBClientDataSet;
 Begin
   Result := TpFIBClientDataSet.Create(nil);
   SetCds(Result,StrSQL);
 End;
 Function GetCds(TipoPesquisa: TTipoPesquisa; Wr: String): TpFIBClientDataSet;overload;
 Begin
   Result := GetCds( GetSelect(TipoPesquisa,Wr));
 End;

 Function GetValorCds(TipoPesquisa: TTipoPesquisa; Wr : String; FieldName : String = '') : String;overload;
 Begin
   Result := GetValorCds(GetSelect(TipoPesquisa,Wr),FieldName);
 End;

 Function FirstDay(Mes,Ano: Integer): TDate;
 var
   Temp: String;
 Begin
    Temp :='01/'+FormatCurr('00',mes)+'/'+IntToStr(ano);
    Result := StrToDate(Temp)-1;
 End;

 Function LastDay(Mes,Ano: Integer): TDate;
 var
   MesAux,AnoAux:Integer;
 Begin
  MesAux:= Mes;
  AnoAux:= Ano;
  //se ja estivesse em dezembro
  MesAux:= MesAux+1;
  if MesAux = 13 then
  begin
    MesAux:= 1;
    AnoAux:= AnoAux+1;
  end;//if MesAux = 13 then

  Result := StrToDAte('01/'+IntToStr(MesAux)+'/'+IntToStr(AnoAux));

 End;

 Function FirstDay(Data: TDate): TDate;overload;
 var
   Dia,Mes,Ano: Word;
 Begin
   DecodeDate(Data,Ano,Mes,Dia);
   Result := FirstDay(Mes,Ano)+1;
 End;
 Function LastDay(Data: TDate): TDate;overload;
 var
   Dia,Mes,Ano: Word;
 Begin
   DecodeDate(Data,Ano,Mes,Dia);
   Result := LastDay(Mes,Ano)-1;
 End;

 Function AddDay(Dia: Integer; DataBase: Tdate): TDate;
 var
   pDia,Mes,Ano: Word;
 Begin
//   DecodeDate(DataBase,Ano,Mes,pDia);
   //Result := EncodeDate(Ano,Mes+1,Dia);
   Result := IncDay(DataBase,Dia);
 End;

 Procedure AlteraBanco(TipoAlteracao : TTipoAlteracao; Cds : TDataSet;TipoPesquisa: TTipoPesquisa);Overload;
 var
   aCampoChave,Tabela, Desconsiderar: String;
   I: Integer;
 Begin
   with InfoSistema.SQLs.GetMySQL(TipoPesquisa,'') do
   begin
      aCampoChave := CampoChave;
      Tabela := NomeTabela;
      Desconsiderar := DesconsiderarCampos;
   end;
   with TStringList.Create do
   begin
     Delimiter :=';';
     DelimitedText := Desconsiderar;
     for I := 0 to Count - 1 do
     begin
       Cds.FieldByName(Strings[i]).ProviderFlags := [];
     end;

     Free;
   end;
   AlteraBanco(TipoAlteracao,Cds,Tabela,aCampoChave);
 End;

 Procedure GravaRelatorio(Id: Integer;Nome: String);
 var
   StrSQL: String;
 Begin
     StrSQL :=
        'UPDATE OR INSERT INTO RELATORIO (IDRELATORIO, DESCRICAO) '+
        '               VALUES ('+IntToStr(Id)+', '+QuotedStr(Nome)+') MATCHING(IDRELATORIO) ';
     try
       StartTrans;
       Exec_SQL(StrSQL);
       Commit;
      except
        on E: Exception do
        Begin
          RollBack;
          raise;
        End;
     end;


 End;

Procedure GetCepOnline(Const Cep: String; Var Uf: String; Var Cidade: String; Var Bairro : String; Var Logradouro: String);
var
  IdHTTP : TIdHTTP;
  Url,Temp, Resultado: String;
  I,X: Integer;
  Stream: TMemoryStream;
  Lst:  TStringList;
Begin
  Try
    IdHTTP := TIdHTTP.Create(Application);
    Stream:= TMemoryStream.Create;
    Lst :=  TStringList.Create;
    Url := 'http://webservice.kinghost.net/web_cep.php?auth=fa82324ea8a52df8de8f4a36b4355727&formato=xml&cep='+cep;
    IdHTTP.Get(Url,Stream);
    Stream.Position := 0;
    Lst.LoadFromStream(Stream);
    Temp := Lst.Text;
    I := Pos('<resultado>',Temp)+11;
    Resultado := Copy(Temp,i,1);
    if Resultado = '0' then
    Begin
      I := Pos('<resultado_txt>',Temp)+15;
      X := Pos('</resultado_txt>',Temp)-i;
      Resultado := Copy(Temp,i,x);
      I:= Pos('-',Resultado);
      Resultado := Copy(Resultado,i+1,30);
      if Resultado <> '' then
      Begin
        Avisa(Resultado);
        Exit;
      End;

    End;
    I := Pos('<uf>',Temp);
    Uf := Copy(Temp,I+4,2);
    I := Pos('<cidade>',Temp);
    x := Pos('</cidade>',Temp)-i-8;
    Cidade := Copy(Temp,I+8,x);
    I := Pos('<bairro>',Temp);
    x := Pos('</bairro>',Temp)-i-8;
    bairro := Copy(Temp,I+8,x);
    I := Pos('<tipo_logradouro>',Temp);
    x := Pos('</tipo_logradouro>',Temp)-i-17;
    Logradouro := Copy(Temp,I+17,x);
    I := Pos('<logradouro>',Temp);
    x := Pos('</logradouro>',Temp)-i-12;
    Logradouro :=Logradouro+ '  '+ Copy(Temp,I+12,x);


  Finally
    FreeAndNil(IdHTTP);
    FreeAndNil(Stream);
    FreeAndNil(Lst);
  End;
End;

Function PodeAlterarDataSet(DataSet: TDataSet): Boolean;
Begin
  Result := DataSet.State in [dsEdit, dsInsert];
End;

Procedure VerificaEditPreenchido(Edit : TEditPesquisa;  MsgPreenchido : String) ;
begin
  if Edit.ValorChave > 0 then
  Begin
    Avisa(MsgPreenchido);
    Edit.SetFocus;
    abort;
  End;

end;

Procedure PreencheCamposValorPadraoBD(Cds: TpFIBClientDataSet; TipoPesquisa: TTipoPesquisa);
var
  StrSQL: String;
  CdsTemp: TpFIBClientDataSet;
begin
  StrSQL:=
    'SELECT RDB$FIELD_NAME CAMPO,TRIM(REPLACE(REPLACE(RDB$DEFAULT_SOURCE,''DEFAULT'',''''),ASCII_CHAR(39),'''')) VALOR_PADRAO'+
    '  FROM RDB$RELATION_FIELDS F2'+
    ' WHERE (F2.RDB$RELATION_NAME = '+QuotedStr(GetTabela(TipoPesquisa))+')'+
    '   AND F2.RDB$DEFAULT_VALUE IS NOT NULL';

  Try
    CdsTemp := TpFIBClientDataSet.Create(nil);
    SetCds(CdsTemp,StrSQL);
    CdsTemp.First;
    while not CdsTemp.Eof do
    begin
      if Cds.FindField(CdsTemp.FieldByName('CAMPO').AsString) <> nil then
      BEGIN
        if StringReplace(LowerCase(CdsTemp.FieldByName('VALOR_PADRAO').AsString),sLineBreak,'',[rfReplaceAll]) = 'current_date' then
          Cds.FieldByName(CdsTemp.FieldByName('CAMPO').AsString).Value := GetDataServidor
        else
        if StringReplace(LowerCase(CdsTemp.FieldByName('VALOR_PADRAO').AsString),sLineBreak,'',[rfReplaceAll]) = 'current_time' then
          Cds.FieldByName(CdsTemp.FieldByName('CAMPO').AsString).Value := GetHoraServidor
        else
          Cds.FieldByName(CdsTemp.FieldByName('CAMPO').AsString).Value := CdsTemp.FieldByName('VALOR_PADRAO').Value;
      CdsTemp.Next;
    end;

  end;
  Finally
    FreeAndNil(CdsTemp);
  End;
end;

Function KriptaStr(aStr: String): String;
var
  A, I: Integer;
  Temp: String;
begin
  Result := '';
  for I := 1 to Length(aStr) do
  begin
     A := Ord(aStr[i]);
     if A = 32 then
       A:= 30;
     if A = 126 then
       A := 32;
     Inc(A);
     A := Trunc(Sqr(A));
     Temp := IntToHex(A,1);
     Temp := StringOfChar('0', 4- Length(Temp))+Temp;
     Result := Result+Temp;
  end;
  Temp := DeKriptaStr(Result);
  if Temp <> aStr then
    Avisa('O resultado está diferente da entrada');

end;
Function DeKriptaStr(aStr: String): String;
var
  A, I: Integer;
  Temp: String;
begin
  Result := '';
  I:= 0;
  while I < Length(aStr) do
  begin
    Temp := '$'+Copy(aStr,i+1,4);
    A := StrToInt(Temp);
    A:= Trunc(Sqrt(A));
    Dec(A);
    if A = 32 then
      A:= 126;
    if A= 30 then
     A:= 32;
    Temp := Chr(A);
    Result := Result+Temp;
    I := +I+4;
  end;

end;

function GetNomePC: String;
begin
  Result := DMCOnexao.InfoPC.Identification.LocalComputerName;
end;

function IdConexaoBd: Integer;
var
  StrSQL: String;
begin
  StrSQL :=
    'SELECT CURRENT_CONNECTION '+
    '  FROM RDB$DATABASE ';
  Result := StrToInt(GetValorCds(StrSQL));
end;

 Procedure GetValorCelulaSelecionadaPivotGrid(PivotGrid: TcxDBPivotGrid; FieldNameLinha,FieldNameColuna: String; Out Res: Array of Variant );
 var
   cvInfo : TcxPivotGridDataCellViewInfo;
   IDidx,Idx: Integer;
   ARow : TcxPivotGridGroupItem;
   AColumn : TcxPivotGridGroupItem;
 begin

    if PivotGrid.HitTest.HitAtDataCell then
    begin
        cvInfo := TcxPivotGridDataCellViewInfo(PivotGrid.HitTest.HitObject);
        IDidx      := TcxDBPivotGridField(PivotGrid.DataController.GetItemByFieldName(FieldNameLinha)).Index;

        ARow   := cvInfo.CrossCell.Row;
        if ARow <> nil then
        begin
          Idx    := ARow.RecordIndex; // probably index of first record having row header like for selected cell
          Res[0] := PivotGrid.DataController.Values[Idx, IDidx];
        end;
        AColumn := cvInfo.CrossCell.Column;
        if AColumn <> nil then
        begin
          Idx     := AColumn.RecordIndex; // probably index of first record having column header like for selected cell
          IDidx      := TcxDBPivotGridField(PivotGrid.DataController.GetItemByFieldName(FieldNameColuna)).Index;
          Res[1] := PivotGrid.DataController.Values[Idx, IDidx];
        end;

    end;

 end;

 initialization
 {$Region 'Traduz o Developer Express'}
  cxSetResourceString(@ScxGridGroupByBoxCaption,'Para agrupar, arraste o título da coluna para este painel.');
  cxSetResourceString(@scxGridNoDataInfoText,'Nenhum registro a ser exibido.');
  cxSetResourceString(@scxGridFilterRowInfoText,'Clique aqui para definir o filtro.');
  cxSetResourceString(@scxGridFilterIsEmpty,'<O Filtro está vazio>');
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption,'Personalizar filtro...');
  cxSetResourceString(@scxGridFilterApplyButtonCaption,'Aplicar filtro');
  cxSetResourceString(@scxGridColumnsQuickCustomizationHint,'Clique aqui para mostrar/ocultar/mover colunas');

  cxSetResourceString(@scxGridYesterday,'Ontem');
  cxSetResourceString(@scxGridToday, 'Hoje');
  cxSetResourceString(@scxGridTomorrow, 'Amanhã');
  cxSetResourceString(@scxGridLast30Days, 'Últimos 30 dias');
  cxSetResourceString(@scxGridLast14Days, 'Últimos 14 dias');
  cxSetResourceString(@scxGridLast7Days, 'Últimos 7 dias');
  cxSetResourceString(@scxGridNext7Days, 'Próximos 7 dias');
  cxSetResourceString(@scxGridNext14Days, 'Próximos 14 dias');
  cxSetResourceString(@scxGridNext30Days, 'Próximos 30 dias');
  cxSetResourceString(@scxGridLastTwoWeeks, 'Últimas duas semanas');
  cxSetResourceString(@scxGridLastWeek, 'Semana passada');
  cxSetResourceString(@scxGridThisWeek, 'Essa semana');
  cxSetResourceString(@scxGridNextWeek, 'Próxima semana');
  cxSetResourceString(@scxGridNextTwoWeeks, 'Próximas 2 semanas');
  cxSetResourceString(@scxGridLastMonth, 'Mês passado');
  cxSetResourceString(@scxGridThisMonth, 'Este mês');
  cxSetResourceString(@scxGridNextMonth, 'Próximo mês');
  cxSetResourceString(@scxGridLastYear, 'Ano passado');
  cxSetResourceString(@scxGridThisYear, 'Este ano');
  cxSetResourceString(@scxGridNextYear, 'Próximo ano');
  cxSetResourceString(@scxGridFuture, 'Futuro');


  cxSetResourceString(@cxSFilterOperatorEqual,'igual a');
  cxSetResourceString(@cxSFilterOperatorNotEqual,'diferente de');
  cxSetResourceString(@cxSFilterOperatorLess,'é menor que');
  cxSetResourceString(@cxSFilterOperatorLessEqual,'é menor ou igual a');
  cxSetResourceString(@cxSFilterOperatorGreater,'é maior que');
  cxSetResourceString(@cxSFilterOperatorGreaterEqual,'é maior ou igual a');
  cxSetResourceString(@cxSFilterOperatorLike,'contêm');
  cxSetResourceString(@cxSFilterOperatorNotLike,'não contêm');
  cxSetResourceString(@cxSFilterOperatorBetween,'está entre');
  cxSetResourceString(@cxSFilterOperatorNotBetween,'não está entre');
  cxSetResourceString(@cxSFilterOperatorInList,'está na lista');
  cxSetResourceString(@cxSFilterOperatorNotInList,'não está na lista');

  cxSetResourceString(@cxSFilterOperatorYesterday,'foi ontem');
  cxSetResourceString(@cxSFilterOperatorToday,'é hoje');
  cxSetResourceString(@cxSFilterOperatorTomorrow,'é amanhã');

  cxSetResourceString(@cxSFilterOperatorLast7Days,'is last 7 days');
  cxSetResourceString(@cxSFilterOperatorLastWeek,'is last week');
  cxSetResourceString(@cxSFilterOperatorLast14Days,'is last 14 days');
  cxSetResourceString(@cxSFilterOperatorLastTwoWeeks,'is last two weeks');
  cxSetResourceString(@cxSFilterOperatorLast30Days,'is last 30 days');
  cxSetResourceString(@cxSFilterOperatorLastMonth,'is last month');
  cxSetResourceString(@cxSFilterOperatorLastYear,'is last year');
  cxSetResourceString(@cxSFilterOperatorPast,'is past');

  cxSetResourceString(@cxSFilterOperatorThisWeek,'is this week');
  cxSetResourceString(@cxSFilterOperatorThisMonth,'is this month');
  cxSetResourceString(@cxSFilterOperatorThisYear,'is this year');
  cxSetResourceString(@cxSFilterOperatorNext7Days,'is next 7 days');
  cxSetResourceString(@cxSFilterOperatorNextWeek,'is next week');
  cxSetResourceString(@cxSFilterOperatorNext14Days,'is next 14 days');
  cxSetResourceString(@cxSFilterOperatorNextTwoWeeks,'is next two weeks');
  cxSetResourceString(@cxSFilterOperatorNext30Days,'is next 30 days');
  cxSetResourceString(@cxSFilterOperatorNextMonth,'is next month');
  cxSetResourceString(@cxSFilterOperatorNextYear,'is next year');
  cxSetResourceString(@cxSFilterOperatorFuture,'é futuro');

  cxSetResourceString(@cxSFilterAndCaption,'e');
  cxSetResourceString(@cxSFilterOrCaption,'ou');
  cxSetResourceString(@cxSFilterNotCaption,'não');
  cxSetResourceString(@cxSFilterBlankCaption,'vazio');

  // derived
  cxSetResourceString(@cxSFilterOperatorIsNull,'é vazio');
  cxSetResourceString(@cxSFilterOperatorIsNotNull,'não é vazio');
  cxSetResourceString(@cxSFilterOperatorBeginsWith,'inicia com');
  cxSetResourceString(@cxSFilterOperatorDoesNotBeginWith,'não inicia com');
  cxSetResourceString(@cxSFilterOperatorEndsWith,'termina com');
  cxSetResourceString(@cxSFilterOperatorDoesNotEndWith,'não termina com');
  cxSetResourceString(@cxSFilterOperatorContains,'contêm');
  cxSetResourceString(@cxSFilterOperatorDoesNotContain,'não contêm');
  // filter listbox's values
  cxSetResourceString(@cxSFilterBoxAllCaption,'(Todos)');
  cxSetResourceString(@cxSFilterBoxCustomCaption,'(Filtro...)');
  cxSetResourceString(@cxSFilterBoxBlanksCaption,'(Vazios)');
  cxSetResourceString(@cxSFilterBoxNonBlanksCaption,'(Não Vazios)');

  // cxFilterBoolOperator
  cxSetResourceString(@cxSFilterBoolOperatorAnd,'E');        // all
  cxSetResourceString(@cxSFilterBoolOperatorOr,'OU');          // any
  cxSetResourceString(@cxSFilterBoolOperatorNotAnd,'E NAO'); // not all
  cxSetResourceString(@cxSFilterBoolOperatorNotOr,'OU NAO');   // not any

  cxSetResourceString(@cxSFilterRootButtonCaption,'Filtro');
  cxSetResourceString(@cxSFilterAddCondition,'Adicionar &Condição');
  cxSetResourceString(@cxSFilterAddGroup,'Adicionar &Grupo');
  cxSetResourceString(@cxSFilterRemoveRow,'&Remover Linha');
  cxSetResourceString(@cxSFilterClearAll,'Limp&ar tudo');
  cxSetResourceString(@cxSFilterFooterAddCondition,'clique aqui para adicionar uma nova condição');

  cxSetResourceString(@cxSFilterGroupCaption,'aplicar as seguintes condições');
  cxSetResourceString(@cxSFilterRootGroupCaption,'<root>');
  cxSetResourceString(@cxSFilterControlNullString,'<vazio>');

  cxSetResourceString(@cxSFilterErrorBuilding,'Impossível construir filtro a partir desta fonte');
  //FilterDialog
  cxSetResourceString(@cxSFilterDialogCaption,'Filtro personalizado');
  cxSetResourceString(@cxSFilterDialogInvalidValue,'Valor inválido');
  cxSetResourceString(@cxSFilterDialogUse,'Use');
  cxSetResourceString(@cxSFilterDialogSingleCharacter,'para representar qualquer caracter único');
  cxSetResourceString(@cxSFilterDialogCharactersSeries,'para representar qualquer série de caracteres');
  cxSetResourceString(@cxSFilterDialogOperationAnd,'E');
  cxSetResourceString(@cxSFilterDialogOperationOr,'OU');
  cxSetResourceString(@cxSFilterDialogRows,'Mostrar registros onde:');
  // FilterControlDialog
  cxSetResourceString(@cxSFilterControlDialogCaption,'Construtor de filtros');
  cxSetResourceString(@cxSFilterControlDialogNewFile,'semtitulo.flt');
  cxSetResourceString(@cxSFilterControlDialogOpenDialogCaption,'Abrir um filtro existente');
  cxSetResourceString(@cxSFilterControlDialogSaveDialogCaption,'Salvar o filtro atual em arquivo');
  cxSetResourceString(@cxSFilterControlDialogActionSaveCaption,'&Salvar como...');
  cxSetResourceString(@cxSFilterControlDialogActionOpenCaption,'A&brir...');
  cxSetResourceString(@cxSFilterControlDialogActionApplyCaption,'&Aplicar');
  cxSetResourceString(@cxSFilterControlDialogActionOkCaption,'OK');
  cxSetResourceString(@cxSFilterControlDialogActionCancelCaption,'Cancelar');
  cxSetResourceString(@cxSFilterControlDialogFileExt,'flt');
  cxSetResourceString(@cxSFilterControlDialogFileFilter,'Filtros (*.flt)|*.flt');

  //Tradução do Scheduler
  cxSetResourceString(@scxMinute,'Minuto');
  cxSetResourceString(@scxMinutes,'Minutos');
  cxSetResourceString(@scxHour,'');
  cxSetResourceString(@scxHours,'');
  cxSetResourceString(@scxOneDay,'');

  cxSetResourceString(@scxUntitledEvent,'Criação de evento');

  //Dialogos Scheduler
  cxSetResourceString(@scxGoToDateDialogCaption,'Ir até a data');
  cxSetResourceString(@scxDate,'Data');
  cxSetResourceString(@scxShowIn,'Mostrar o');
  cxSetResourceString(@scxDayCalendar,'Dia');
  cxSetResourceString(@scxWeekCalendar,'Semana');
  cxSetResourceString(@scxMonthCalendar,'Mês');
  cxSetResourceString(@scxWorkWeekCalendar,'Semana de trabalho');
  cxSetResourceString(@scxOk,'OK');
  cxSetResourceString(@scxCancel,'Cancelar');
  cxSetResourceString(@scxClose,'Fechar');
  cxSetResourceString(@scxDown,'Abaixo');
  cxSetResourceString(@scxUp,'Acima');
  cxSetResourceString(@scxResourceLayoutCaption,'Editor de layout');

  cxSetResourceString(@scxpmToday,'Hoje');
  cxSetResourceString(@scxpmGotoThisDay,'Ir até data de hoje');
  cxSetResourceString(@scxpmGoToDate,'Ir até a Data...');
  cxSetResourceString(@scxpmResourcesLayout,'Editor de layout...');

  cxSetResourceString(@scxFirstButtonHint,'Primeiro');
  cxSetResourceString(@scxPrevPageButtonHint,'Página anterior');
  cxSetResourceString(@scxPrevButtonHint,'Anterior');
  cxSetResourceString(@scxNextButtonHint,'Próximo');
  cxSetResourceString(@scxNextPageButtonHint,'Próxima página');
  cxSetResourceString(@scxLastButtonHint,'Último');

  cxSetResourceString(@secxYes,'Sim');
  cxSetResourceString(@secxNo,'Não');

  cxSetResourceString(@scxpm60Minutes,'60 minutos');
  cxSetResourceString(@scxpm30Minutes,'30 minutos');
  cxSetResourceString(@scxpm15Minutes,'15 minutos');
  cxSetResourceString(@scxpm10Minutes,'10 minutos');
  cxSetResourceString(@scxpm6Minutes,'6 minutos');
  cxSetResourceString(@scxpm5Minutes,'5 minutos');

  cxSetResourceString(@scxTime0m,'0 minutos');
  cxSetResourceString(@scxTime5m,'5 minutos');
  cxSetResourceString(@scxTime10m,'10 minutos');
  cxSetResourceString(@scxTime15m,'15 minutos');
  cxSetResourceString(@scxTime20m,'20 minutos');
  cxSetResourceString(@scxTime30m,'30 minutos');
  cxSetResourceString(@scxTime1h,'1 hora');
  cxSetResourceString(@scxTime2h,'2 hora');
  cxSetResourceString(@scxTime3h,'3 hora');
  cxSetResourceString(@scxTime4h,'4 hora');
  cxSetResourceString(@scxTime5h,'5 hora');
  cxSetResourceString(@scxTime6h,'6 hora');

  //Edit Controls

  cxSetResourceString(@cxSDatePopupToday,'Hoje');
  cxSetResourceString(@cxSDatePopupToday,'Hoje');
  {$EndRegion}

end.
