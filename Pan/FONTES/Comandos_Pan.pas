unit Comandos_Pan;

interface
  uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_pan, Menus, ExtCtrls,ZConnection, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, DBClient, Provider, cxSchedulerStrs, cxEditConsts, cxFilterConsts,Classes_Pan,
  cxGridStrs, cxClasses,PesquisaMaskEdit_Pan,
  cxFilterControlStrs, cxGridDBTableView, cxGridTableView, cxDataStorage,  uDmConexao_Pan,
  StrUtils, cxTreeView, Mask, DBCtrls, cxGridCustomTableView, StdCtrls,  ZDbcIntfs, HD,
  JvComponentBase, JvComputerInfoEx, JvSerialMaker, LabelDBEdit;



  Procedure GravaQry(Qry : TZQuery; NomeTabela :String;CampoChave : String ;TipoAlteracao : TTipoAlteracao);
  function GetDataServidor : String;
  Function GetHoraServidor : String;

  function Atu_Cds(Cds: TClientDataSet; StrSQL: String): Boolean;
  procedure StartTrans;
  procedure Commit;
  procedure RollBack;
  procedure Exec_SQL(StrSQL: String);
  function MontaGrid(TV: TcxGridDBTableView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo; Largura: Integer = 65):TcxGridDBColumn;

  Function GetProximoCodigo(Tabela, Chave : String) : String;

  Procedure GravaArvore(Lote : Int64; Descricao : String; Flag : String = 'C');
  Procedure MontaArvore(Arvore : TcxTreeView; Flag : String); //Rever
//  Procedure IncAuditoria(TipoAuditoria : TTipoAuditoria;  Tela : String; Texto : String;NomeTabela: String ; ValorChave: String);

  Procedure InsereBLob(Qry : TZQuery; Campo : String; FileName : String) ;

  Procedure SetRegistros(CdsDestino, CdsOrigem :TClientDataSet ;NomeTabela,TabelaRelacionamento ,
  ChaveRelacionamento,NomeChave : String; CampoCodigoOrigem : String= 'CODIGO');





  Function GetValorCFG(Const ID : String) : Variant;
  Procedure SetConfiguracao(Const aID : String; aNomeCFg : String ;
                           aDescricao : String ;aNomeSecao : String ;
                         aLote : String;aValorPadrao : String; aValor : String;
                         aNumerico : boolean = False;
                         aValorPadraoNumerico : Currency = 0.00 );
  Function Atu_Qry(Qry : TZQuery ; StrSQL : String) : Boolean;




  Procedure AlteraBanco(TipoAlteracao : TTipoAlteracao; Cds : TClientDataSet;
                      NomeTabela : String;
                      CampoChave : String;GravaTodos : Boolean = False);



function VerificaSerial(pSerial : String): Boolean;
Function GetNovoSerial : String;
Function GetValorCds(StrSQL : String) : String;

//  Function GetCodigo(NomeTabela , NomeCampo : String; TipoChave : TTipoChave): String;
  procedure AcertaPadroesData;
   Procedure AvisaErro(msg: String; Abortar : Boolean = True);
  Procedure AvisaOK(msg: String);
  Procedure Avisa(msg: String);
  Function ConfirmaDel : Boolean;
  Function Pergunda(Msg : String) : Boolean;
  Function RetornaData(Data : TDateTime; UsaAspas : Boolean = True) : String;
  Procedure FormataMascara(Edit : TMaskEdit ;TipoCampo : TTipoCampo);overload;
  Procedure FormataMascara(Field : TField ;TipoCampo : TTipoCampo);overload;
  Procedure FormataMascara(PesquisaEdit : TaqPesquisaMaskEdit_Pan ;TipoCampo : TTipoCampo);overload;
  Procedure VerificaEdit(Edit : TaqPesquisaMaskEdit_Pan;  MsgVazio : String) ;overload;
  Procedure VerificaEdit(Cds : TClientDataSet ;Edit : TDBEdit; MsgExiste, MsgVazio : String) ;overload;
  Procedure VerificaEdit(Cds : TClientDataSet ;Edit : TLabelDBEdit; MsgExiste, MsgVazio : String) ;overload;
  Procedure VerificaEdit(Edit : TEdit;  MsgVazio : String) ;overload;

  Function GetData(Data : TDate ; Aspas : Boolean = True) : String; Overload;
  Function GetData(Data : String ; Aspas : Boolean = True) : String; Overload;
  Function GetTime(Hora : String; Aspas : Boolean = True): String;overload;
  Function GetTime(Hora : TTime; Aspas : Boolean = True): String;overload;
  Function Verifica_CPF(Cpf : String ) : Boolean ;
  Function Verifica_CNPJ(CNPJ : String ) : Boolean ;
  Function ExisteRegistroCds(CdsOrigem, CdsDestino: TClientDataSet  ;NomeCampo : String ) : Boolean;
  Function GetNumber(Valor : Currency ): String;
  Function GetBuildInfo(formata: Boolean; Exe: String): string;


implementation



  function GetDataServidor : String;
  Begin
    Result := 'SELECT cast(CURRENT_DATE() as date)data'  ;
    Result := getValorCds(Result);
  End;

  Function GetHoraServidor : String;
  Begin
    Result := 'SELECT CURRENT_TIME ';
    Result := getValorCds(Result);
  End;


  function Atu_Cds(Cds: TClientDataSet; StrSQL: String): Boolean;
  var
  Provider : TDataSetProvider;
  Qry : TZQuery;
  I : Integer;
begin
   Qry := TZQuery.Create(nil);
  Provider := TDataSetProvider.Create(nil);
  Try
    Qry.Close;
    Cds.Close;

    Qry.Connection := DmConexao.Conexao;
    Qry.UpdateMode := umUpdateChanged;
    Qry.WhereMode := wmWhereKeyOnly;

    Provider.Constraints := True;
    Provider.Options := Provider.Options + [poRetainServerOrder];
    Provider.UpdateMode := upWhereAll;

    Provider.DataSet := Qry;
    Qry.CachedUpdates := True;
    Qry.SQL.Clear;
    Qry.SQL.Text :=  StrSQL;
    Qry.Open;


    Qry.ReadOnly := True;
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

    Cds.Data := Provider.Data;

//    Cds.ReadOnly := False;
//    for I := 0 to Cds.Fields.Count -1  do
//    Begin
//      Cds.Fields[i].FieldName;
//      Cds.Fields[i].ReadOnly := False;
//      Cds.Fields[i].Required := False;
//    End;
//
//    for I := 0 to Cds.FieldDefs.Count -1 do
//    Begin
//      Cds.FieldDefs[i].Attributes := [];
//    End;
//
//    Cds.FieldDefs.Clear;


    Qry.Close;

    Result := not Cds.IsEmpty;

  Finally
    FreeAndNil(Qry);
    FreeAndNil(Provider);
  End;
end;

function MontaGrid(TV: TcxGridDBTableView; NomeCampo, Titulo: String;
                      TipoCampo: TTipoCampo; Largura: Integer = 65):TcxGridDBColumn;

begin

  with TV do
  begin
    Result := CreateColumn as TcxGridDBColumn;
    with Result do
    begin
      Caption := Titulo;
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
        tcData:
          DataBinding.ValueTypeClass := TcxDateTimeValueType;
        else
          FormataMascara(Result.DataBinding.Field,TipoCampo);
      end;
      DataBinding.FieldName := NomeCampo;
//      if Assigned(OnGetText) then
//        OnGetDisplayText := OnGetText;
      Width := Largura;
    end;
  end;
  
end;

procedure StartTrans;
begin
  with dmconexao do
  Begin
    Conexao.StartTransaction;
  End;
end;
procedure Commit;
begin
  with dmconexao do
  Begin
    Conexao.Commit;
  End;
end;
procedure RollBack;
begin
    with dmconexao do
  Begin
    Conexao.Rollback;
  End;
end;

procedure Exec_SQL(StrSQL: String);
var
  Qry : TZQuery;
begin
   Qry := TZQuery.Create(nil);
   Try
     Qry.Connection := DMConexao.Conexao;
     Qry.Close;
     Qry.SQL.Clear;
     Qry.SQL.Text := StrSQL ;
     Qry.ExecSQL;
   Finally
     FreeAndNil(Qry);
   End;
end;

Function GetProximoCodigo(Tabela, Chave : String ) : String;
Begin
//  Result := GetCodigo(Tabela, Chave, ttcCodigo);
End;

Procedure FormataMascara(PesquisaEdit : TaqPesquisaMaskEdit_Pan ;TipoCampo : TTipoCampo);
Begin
    case TipoCampo  of
    tcData:
      PesquisaEdit.EditMask := MascaraData;
    tcCEP :
      PesquisaEdit.EditMask := MascaraCEP;
    tcCNPJ :
      PesquisaEdit.EditMask := MascaraCNPJ;
    tcCPF :
      PesquisaEdit.EditMask := MascaraCPF;
  end;

End;


Procedure VerificaEdit(Edit : TaqPesquisaMaskEdit_Pan;  MsgVazio : String) ;
Begin
  if EDit.ValorChave < 0  then
  Begin
    if MsgVazio = '' then
       Abort;
    Avisa(MsgVazio);
    Edit.SetFocus;
    Abort;
  End;
End;


Procedure GravaArvore(Lote : Int64; Descricao : String; Flag : String = 'C');
var
  StrSQL : String;
  uk : TTipoAlteracao;
Begin
   StrSQL :=
      'SELECT LOTE FROM ARVORE WHERE LOTE = '+ IntToStr(Lote);
   if GetValorCds(StrSQL)= '' then
   Begin
     StrSQL :=
        'INSERT '+
        '  INTO ARVORE (LOTE, DESCRICAO, FLAG) '+
        '       VALUES ('+IntToStr(Lote)+', '+ QuotedStr(Descricao)+', '+QuotedStr(Flag);

   End else
   Begin
     StrSQL :=
       'UPDATE ARVORE '+
       '   SET DESCRICAO = '+QuotedStr(Descricao)+', '+
       '       FLAG = '+  QuotedStr(Flag)+
       ' WHERE LOTE = '+ IntToStr(Lote);
   End;
   try
     StartTrans;
     Exec_SQL(StrSQL);
     Commit;
   except
     on E: Exception do
     Begin
       RollBack;
       Raise;
     End;
   end;
End;

Procedure  MontaArvore(Arvore : TcxTreeView; Flag : String);
var
  StrSQL : String;
Begin

End;
//
//Procedure IncAuditoria(TipoAuditoria : TTipoAuditoria;  Tela : String; Texto : String;NomeTabela: String ; ValorChave: String);
//var
//  StrSQL, SQL : String;
//Begin
//   case TipoAuditoria of
//     tAudIncercao:
//         SQL := 'INSERÇÃO';
//     tAudExclusao :
//         sql := 'EXCLUSÃO';
//     tAudModificacao :
//         SQL := 'ALTERAÇÃO';
//   end;
//   Sql :=
//      'SELECT IDTIPOAUDITORIA FROM TIPOAUDITORIA WHERE DESCRICAO = '+ QuotedStr(sql) ;
//
//   StrSQL := GetValorCds(sql);
//
//   StrSQL :=
//      'INSERT  '+
//      '  INTO '+
//      '      auditoria '+
//      '        (IDTIPOAUDITORIA, IDUSER,  NOMEMAQUINA, '+
//      '         DATA, HORA, TELA, TEXTO, NOMETABELA, IDTABELA) VALUES ( '+
//                StrSQL+' , '+IntToStr(UserLogado.id)+ ', '+
//                QuotedStr(USerLogado.NomeMaquina)+',  CURRENT_DATE, CURRENT_TIME, '+
//                QuotedStr(Tela) +', '+ QuotedStr(Texto)+','+QuotedStr(NomeTabela)+','+
//                IfThen(ValorChave <> '',  ValorChave, 'null')+')';
//
//   try
//     StartTrans;
//     Exec_SQL(StrSQL);
//     Commit;
//   except
//     on E: Exception do
//     Begin
//       RollBack;
//       Raise;
//       E.Create(e.Message+#13+ 'Não foi possível criar auditoria. Entre em contato com o administrador.');
//     End;
//   end;
//End;


Procedure InsereBLob(Qry : TZQuery; Campo : String; FileName : String) ;
var
  BlobStream: TStream;
  FileStream: TStream;
begin
  BlobStream := Qry.CreateBlobStream(Qry.FieldByName(Campo), bmWrite);
  try
    FileStream := TFileStream.Create(FileName, fmOpenRead);
    try
      BlobStream.CopyFrom(FileStream, FileStream.Size);
    finally
      FileStream.Free;
    end;

  finally
    BlobStream.Free;
  end;
end;


Procedure SetRegistros(CdsDestino, CdsOrigem :TClientDataSet;NomeTabela,TabelaRelacionamento ,
          ChaveRelacionamento ,NomeChave : String; CampoCodigoOrigem : String= 'CODIGO' );
var
  uk : TTipoAlteracao;
  CdsQry : TZQuery;
  StrSQL : String;
Begin
 CdsDestino.RecordCount;
  CdsDestino.First;
  while not CdsDestino.Eof do
  Begin
    if CdsDestino.FieldByName('FLAGEDICAO').AsString = 'N' then
    Begin
      CdsDestino.Next;
      Continue;
    End;
    if CdsDestino.FieldByName('FLAGEDICAO').AsString = 'I' then
    Begin
      uk := taInsere;
      StrSQL := 'SELECT ' +ChaveRelacionamento+
                '  FROM '+TabelaRelacionamento +
                ' WHERE  '+CampoCodigoOrigem+ '= '+ QuotedStr(CdsOrigem.FieldByName(CampoCodigoOrigem).AsString);
      CdsDestino.Edit;
      CdsDestino.FieldByName(ChaveRelacionamento).AsString := GetValorCds(StrSQL);
      CdsDestino.Post;
    End;
    if CdsDestino.FieldByName('FLAGEDICAO').AsString = 'E' then
    Begin
      uk := taModifica;
    End;
    if CdsDestino.FieldByName('FLAGEDICAO').AsString = 'D' then
    Begin
      uk := taDeleta;
    End;
    CdsDestino.FieldByName('FLAGEDICAO').ProviderFlags := [];
    AlteraBanco(uk,CdsDestino,NomeTabela, NomeChave);
    CdsDestino.Next;
  End;

End  ;





Function GetValorCFG(Const ID : String) : Variant;
Begin
  with DMCOnexao do
  Begin
//    if CdsConfiguracao.Locate('IDCONFIGURACAO', ID, []) then
//      Result := CdsConfiguracao.FieldByName('VALOR').Value;
  End;
End;

Procedure SetConfiguracao(Const aID : String; aNomeCFg : String ;
                           aDescricao : String ;aNomeSecao : String ;
                         aLote : String;aValorPadrao : String; aValor : String;
                         aNumerico : boolean = False;
                         aValorPadraoNumerico : Currency = 0.00 );
var
  uk : TTipoAlteracao;
Begin
//  with DMCOnexao do
//  Begin
//    if CdsConfiguracao.Locate('IDCONFIGURACAO', AID, []) then
//    Begin
//      uk := taGrava;;
//      CdsConfiguracao.Edit;
//    End ELSE
//    Begin
//      uk := taGrava;;
//      CdsConfiguracao.Append;
//    End;
//    CdsConfiguracao.FieldByName('NOMECONFIGURACAO').AsString := aNomeCFg;
//    CdsConfiguracao.FieldByName('DESCRICAO').AsString := aDescricao;
//    CdsConfiguracao.FieldByName('SECAO').AsString := aNomeSecao;
//    CdsConfiguracao.FieldByName('LOTE').AsString := aLote;
//    CdsConfiguracao.FieldByName('VALORPADRAO').AsString := aValorPadrao;
//    CdsConfiguracao.FieldByName('VALOR').AsString := aValor;
//    CdsConfiguracao.FieldByName('NUMERICO').AsString := IfThen(aNumerico, 'Y','N');
//    CdsConfiguracao.FieldByName('VALORNUMERICOPADRAO').Value := aValorPadraoNumerico;
//    CdsConfiguracao.Post;
//    AlteraBanco(uk, CdsConfiguracao, 'CONFIGURACAO', 'IDCONFIGURACAO');
//
//
//  End;
//

End;

Function Atu_Qry(Qry : TZQuery ; StrSQL : String) : Boolean;
Begin
 Qry.Connection := DMCOnexao.Conexao;
 Qry.CachedUpdates := True;
 Qry.Close;
 Qry.SQL.Clear;
 Qry.SQL.Add(StrSQL);
 Qry.Open;
 Result := not Qry.IsEmpty;
End;

Procedure GravaQry(Qry : TZQuery; NomeTabela : String; CampoChave : String; TipoAlteracao : TTipoAlteracao);
var
  vSep, vCampo,vValores, Sql, StrSQL : String;
  i : Integer;
  ListaCampo : TStringList;

LABEL
  Grava;

  Function GetValorCampo(Campo : TField): String;
  Begin
    case Campo.DataType of
      ftString, ftMemo, ftFmtMemo, ftWideString, ftWideMemo :
      Begin
         Result := QuotedStr(Campo.AsString);
      End;
      ftSmallint, ftInteger :
      Begin
        Result := Campo.AsString;
      End;
      ftCurrency, ftFloat :
      Begin
        Result := GetNumber(Campo.AsCurrency);
      End;
      ftDate, ftDateTime :
      Begin
        Result := GetData(Campo.AsDateTime, True);
      End;
      { TODO 2 : Fazer para blob }
    end;
  End;

Begin
   if TipoAlteracao = taDeleta then
   Begin
     StrSQL := 'DELETE FROM '+NomeTabela +' WHERE ' + CampoChave +' = '+ GetValorCampo(Qry.FieldByName(CampoChave));
     goto Grava;
     Exit;
   End;

   ListaCampo := TStringList.Create;
   ListaCampo.Delimiter := ',';

   for I := 0 to Qry.Fields.Count - 1 do
   Begin
     if Qry.Fields[i].ProviderFlags <> [] then
       ListaCampo.Add(Qry.Fields[i].FieldName);
   End;


   Qry.First;
   while not Qry.Eof do
   Begin
     for I := 0 to ListaCampo.Count - 1 do
     Begin
       if (vValores <> '')and ( not Qry.Eof)  then
         vSep := ','
       ELSE
         vSep := ' ';
       if Qry.FieldByName(ListaCampo.Strings[i]).ProviderFlags = [] then
       Begin
         Continue;
       End;

//       if TipoAlteracao = taInsere then
//       Begin
//         vValores := vValores + vSep + GetValorCampo(Qry.FieldByName(ListaCampo.Strings[i])) ;
//       end;
//       if TipoAlteracao = taModifica then
//       Begin
//         vValores := vValores + vSep +ListaCampo.Strings[i] + ' = '+ GetValorCampo(Qry.FieldByName(ListaCampo.Strings[i]));
//       End;
//
//     end;
//     case TipoAlteracao of
//       taInsere :
//         Begin
//           StrSQL := ' INSERT INTO '+ NomeTabela + '(' +ListaCampo.DelimitedText+') Values ('+vValores+ ')';
//         End;
//       taModifica :
//         Begin
//           StrSQL :=
//             ' UPDATE '+NomeTabela+' SET '+ vValores +
//             ' WHERE '+ CampoChave +' = ' + GetValorCampo(Qry.FieldByName(CampoChave));
//         End;

     end;
     Grava :
     try
       StartTrans;
       Exec_SQL(StrSQL);
       Commit;
     except
       on E: Exception do
       Begin
         RollBack;
         Raise;
       End;
     end;

     Qry.Next;
   end;



End;



Procedure AlteraBanco(TipoAlteracao : TTipoAlteracao; Cds : TClientDataSet;
                      NomeTabela : String;
                      CampoChave : String;GravaTodos : Boolean = False);
var
  StrSQL, vWr, Campos,
  vSep, StrParam, Valor, updCampo : String;
  Q : TZQuery;
  i, r: Integer;
Begin
  Q := TZQuery.Create(nil);
  Q.Connection := DMCOnexao.Conexao;
  Q.Close;
  
  for I := 0 to Cds.Fields.Count - 1 do
  Begin
    if cds.Fields[i].ProviderFlags <> [] then
    Begin
      if Trim(Campos) = '' then
          vSep := ''
      else
          vSep := ', ';

      StrParam := StrParam + vSep +':'+ Cds.Fields[i].FieldName;
      if NOT Cds.Fields[i].IsNull then
      Begin
        case Cds.Fields[i].DataType of
          ftString, ftMemo , ftWideMemo :
          Begin
            vWr := vWr  +vSep + QuotedStr(Cds.Fields[i].AsString);
            Valor := QuotedStr(Cds.Fields[i].AsString);
          End;
          ftBlob:
          Begin
            Q.ParamByName(StrParam).Assign(Cds.FieldByName(StrParam));
          End;
          ftDate, ftDateTime :
          Begin
            vWr := vWr + vSep + GetData(Cds.Fields[i].AsDateTime);
            Valor :=  GetData(Cds.Fields[i].AsDateTime);
          End;
          ftTime, ftTimeStamp:
          Begin
            vWr := vWr + vSep + GetTime(Cds.Fields[i].AsDateTime);
            Valor :=  GetTime(Cds.Fields[i].AsDateTime);
          End;
          ftInteger, ftLargeint, ftSmallint:
          Begin
            vWr := vWr  +vSep + Cds.Fields[i].AsString;
            Valor := Cds.Fields[i].AsString;
          End;
        end;
      End else
      Begin
        vWr := vWr + vSep + 'null';
        Valor := 'Null';
      End;
      updCampo := updCampo + vSep + Cds.Fields[i].FieldName +' = ' + Valor;
      Campos := Campos + vSep + Cds.Fields[i].FieldName ;


    End;
  End;

  StartTrans;
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
             ' WHERE '+CampoChave + ' = '+ Cds.FieldByName(CampoChave).AsString;
         End;
      taModifica:
        Begin
          StrSQL :=
            'UPDATE '+NomeTabela+' SET '+ updCampo+
            ' WHERE '+CampoChave +' = ' + Cds.FieldByName(CampoChave).AsString; 
        End;

    end;
    Q.ParamCheck := True;
    Q.SQL.Text := StrSQL;
    for I := 0 to Q.Params.Count   - 1 do
    Begin
      for r := 0 to Cds.Fields.Count - 1 do
      Begin
         if Q.Params[i].Name = Cds.Fields[r].FieldName then
         Begin
           if Cds.Fields[r].ProviderFlags = [] then
              Break;
           if NOT Cds.Fields[r].IsNull then
           Begin
            case Cds.Fields[r].DataType of
               ftString :
                Q.Params[i].AsString := Cds.Fields[r].AsString;
              ftInteger, ftLargeint, ftSmallint:
                Q.Params[i].AsInteger := Cds.Fields[r].AsInteger;
              ftBlob, ftGraphic, ftMemo, ftFmtMemo, ftWideMemo:
                Begin
                  Q.Params[i].Assign(Cds.Fields[r]);
                End;
              ftDate, ftDateTime, ftTime, ftTimeStamp :
                Begin
                  Q.Params[i].AsDateTime := Cds.Fields[r].AsDateTime;
                End;
              ftFloat, ftCurrency, ftBCD :
                Begin
                  Q.Params[i].Value := Cds.Fields[r].Value;
                End;
            end;
           End else
            Q.Params[i].Clear;
            Break;
         End;
      End;  
    End;  
    Q.ExecSQL;
    Commit;
  Except
    on e: Exception do
    Begin
      RollBack;
      Raise;
    End;
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
//  Application.UpdateFormatSettings := False;
//  NegCurrFormat := 14;
//  SysUtils.ShortDateFormat :=FormatoData;
//  DateSeparator := Separador;
//  for ii := 1 to 7 do
//  begin
//    ShortDayNames[ii] := arrShortDayNames[ii];
//    LongDayNames[ii] := arrLongDayNames[ii];
//  end;
//  for ii := 1 to 12 do
//  begin
//    ShortMonthNames[ii] := arrShortMonthNames[ii];
//    LongMonthNames[ii] := arrLongMonthNames[ii];
//  end;
//   Application.UpdateFormatSettings := True;
end;




//Function GetCodigo(NomeTabela , NomeCampo : String; TipoChave : TTipoChave): String;
//var
//  StrSQL, vCod : String;
//  Cds : TClientDataSet;
//label
//  Volta;
// Function GetValCodigo : String;
// var
//   SQl : String;
// Begin
//   SQL :=
//     'SELECT COALESCE(MAX(X.'+NomeCampo+'),0) CHAVE '+
//     '  FROM (  '+
//     '         SELECT '+ NomeCampo +
//     '           FROM '+NomeTabela+' ) X  ';
//   Result :=  GetValorCds(SQl);
//   Result := IntToStr(  StrToInt(Result  )+ 1 ) ;
// End;
//
// Procedure Insere;
// Begin
//   Try
//     StartTrans;
//     vCod := GetValCodigo;
//     vCod := FormatFloat('000000', StrToInt(vCod))  ;
//     StrSQl :=
//       'INSERT INTO codigo '+
//       '          (NOMETABELA, NOMECAMPO, ORDEM, IDUSUARIO, IDLOJA, CODIGO,CHAVE,   '+
//       '           DATA, HORA, FLAGDISPONIVEL) '+
//       '       VALUES ('+QuotedStr(NomeTabela) +', '+ QuotedStr(NomeCampo)+', 1,'+
//       IntToStr(UserLogado.Id)+', '+IntToStr(UserLogado.IdLoja)+', '+
//       IfThen(TipoChave =ttcCodigo, QuotedStr(vCod), 'null') +','+
//       IfThen(TipoChave =ttcChave, QuotedStr(vCod), 'null') +
//       ', CURRENT_DATE, CURRENT_TIME, ''Y'')' ;
//     Exec_SQL(StrSQL);
//     Commit;
//     Result := vCod;
//     Exit;
//   except
//     on  E :Exception do
//     Begin
//       RollBack;
//       Raise;
//     end;
//   end;
// End;
//
// Procedure Grava;
// Begin
//   Try
//     StartTrans;
//     StrSQL :=
//       'UPDATE CODIGO '+
//       '   SET FLAGDISPONIVEL = ''N'', '+
//       IfThen(TipoChave = ttcChave, 'CHAVE = ' + Result, ' CODIGO = '+ QuotedStr(Result)  )+
//       ' WHERE NOMETABELA = '+ QuotedStr(NomeTabela)+
//       '   AND NOMECAMPO = '+ QuotedStr(NomeCampo);
//     Exec_Sql(StrSQL);
//     Commit;  
//   except
//     on e : Exception do
//     Begin
//        RollBack;
//        Raise;
//     End;
//   End;
// End;
//
// Begin
//  try
//    Cds := TClientDataSet.Create(nil);
//    Volta:
//    StrSQL :=
//      'SELECT NOMETABELA, NOMECAMPO, ORDEM, IDUSUARIO, IDLOJA, CODIGO, CHAVE,  DATA, '+
//      '       HORA, COALESCE(FLAGDISPONIVEL,''Y'') FLAGDISPONIVEL'+
//      '  FROM codigo '+
//      ' WHERE NOMETABELA = '+ QuotedStr(NomeTabela)+
//      '   AND NOMECAMPO = '+ QuotedStr(NomeCampo);
//    if Atu_Cds(Cds, StrSQL) then
//    Begin
//      case TipoChave of
//        ttcChave: 
//          Begin
//            Result := IntToStr(Cds.FieldByName('CHAVE').AsInteger + 1);
//            Result := IntToStr(StrToInt(FormatFloat('00', UserLogado.IdLoja) + FormatFloat('00', UserLogado.Id) + Result ));
//            Grava;
//            Exit;
//          End;
//        ttcCodigo: 
//          Begin
//           Result := IntToStr(Cds.FieldByName('CODIGO').AsInteger +1);
//           Grava;
//           Exit;
//          end;
//      end;
//
//    end else
//    Begin
//      Insere;      
//      goto Volta;
//    end;  
//
//  finally
//    FreeAndNil(Cds);
//  end;

//End;

function VerificaSerial(pSerial : String): Boolean;
var
  Computer : TJvComputerInfoEx;
  Serial : TJvSerialMaker;
  Sn: String;
begin
  Try
    Computer := TJvComputerInfoEx.Create(nil);
    Sn := GetNovoSerial;
    Result := Serial.SerialIsCorrect(10, Sn, pSerial);
  Finally
    FreeAndNil(Computer);
  End;
end;

Function GetNovoSerial : String;
var
  Computer : TJvComputerInfoEx;
  Serial : TJvSerialMaker;
  Sn : String;
Begin
  Try
    Computer := TJvComputerInfoEx.Create(nil);
    Sn := Computer.OS.ProductID+  Computer.Identification.DomainName;
    Result := Serial.GiveSerial(10,Sn);
  Finally
    FreeAndNil(Computer);
  End;
End;
Function GetValorCds(StrSQL : String) : String;
var
  Cds : TZQuery;
Begin
  Cds := TZQuery.Create(nil);
  Try
    Atu_Qry(Cds, StrSQL );
    Result := CDs.Fields[0].AsString;
  Finally
    FreeAndNil(Cds);
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

procedure AvisaOK(msg: String);
begin
  Application.MessageBox(PChar(msg), 'OK',MB_ICONINFORMATION + MB_OK);
end;

Function Pergunda(Msg : String) : Boolean;
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
Procedure FormataMascara(Edit : TMaskEdit ;TipoCampo : TTipoCampo);overload;
Begin
  case TipoCampo  of
    tcData:
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
    tcData:
      (Field as TStringField).EditMask :=MascaraData;
    tcCEP :
      (Field as TStringField).EditMask := MascaraCEP;
    tcCNPJ :
      (Field as TStringField).EditMask := MascaraCNPJ;
    tcCPF :
      (Field as TStringField).EditMask :=  MascaraCPF;
    tcReal :
      (Field as TStringField).EditMask :=  MascaraFloat;
  end;
End;
//

Procedure VerificaEdit(Cds : TClientDataSet ;Edit : TDBEdit; MsgExiste, MsgVazio : String) ;
function ExisteRegistro : Boolean;
  var
    vCdsClone : TClientDataSet;
  Begin
    Try
      vCdsClone := TClientDataSet.Create(nil);
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

Procedure VerificaEdit(Cds : TClientDataSet ;Edit : TLabelDBEdit; MsgExiste, MsgVazio : String) ;overload;
function ExisteRegistro : Boolean;
  var
    vCdsClone : TClientDataSet;
  Begin
    Try
      vCdsClone := TClientDataSet.Create(nil);
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
  Result := FormatDateTime('yyyy-mm-dd',Data);
  if Aspas  then
    Result := QuotedStr(Result );
End;

Function GetData(Data : String ; Aspas : Boolean = True) : String; Overload;
Begin
  Result := FormatDateTime('yyyy-mm-dd',StrToDateTime(Data));
  if Aspas  then
    Result := QuotedStr(Result );
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

Function ExisteRegistroCds(CdsOrigem, CdsDestino : TClientDataSet  ;NomeCampo : String ) : Boolean;
var
  CdsClone : TClientDataSet;
begin
//   if TipoALteracao = taModifica then
//      Exit;
   CdsClone := TClientDataSet.Create(nil);
   Try
     CdsClone.CloneCursor(CdsDestino, True);
     Result := CdsClone.Locate(NomeCampo, CdsOrigem.FieldByName(NomeCampo).AsString, []);
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

Function GetBuildInfo(formata: Boolean; Exe: String): string;
var
   VerInfoSize: DWORD;
   VerInfo: Pointer;
   VerValueSize: DWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: DWORD;
   V1, V2, V3, V4: Word;
   Prog : string;
begin
   if Exe = '' then
     Prog := Application.Exename
   else
     Prog := Exe;
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
  if formata then
    result := FormatFloat('00',v1) + FormatFloat('00',v2) +
              FormatFloat('00',v3) + FormatFloat('00',v4)
  else
    result := IntToStr (v1) + '.' + IntToStr (v2) + '.' +
              IntToStr (v3) + '.' + IntToStr (v4);

End;

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
