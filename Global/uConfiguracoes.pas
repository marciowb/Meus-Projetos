unit uConfiguracoes;

interface
   uses SysUtils, Classes, Windows, MinhasClasses,
        Comandos, Db, DBClient, pFIBClientDataSet, Variants, Generics.Collections;
   Type
     TRegistroConfiguracao = Packed Record
        NomeConfiguracao :AnsiString;
        Secao :AnsiString;
        Valor :AnsiString;
        TipoCampo : TTipoCampo;
        ValorPadrao :AnsiString;
        Descricao : AnsiString;
     End;

     TConfiguracao = Class
     private
//       FDataSetConfiguracao: TpFIBClientDataSet;
       FMapConfiguracao : TDictionary<String,AnsiString>;
     published
       Constructor Create;virtual;
       Procedure PopulaDataSet;virtual;
//       Property DataSetConfiguracao : TpFIBClientDataSet read FDataSetConfiguracao write FDataSetConfiguracao;
       Procedure SetConfiguracao(Cfg: TTipoConfiguracao; Valor : AnsiString);virtual;
       Function GetRegistroConfiguracao(Cfg: TTipoConfiguracao): TRegistroConfiguracao;virtual;abstract;
       Function GetConfiguracao(Cfg: TTipoConfiguracao): AnsiString;virtual;
     End;

     
implementation

{ TConfiguracao }

constructor TConfiguracao.Create;
begin
   inherited;
//   DataSetConfiguracao := TpFIBClientDataSet.Create(nil);
  FMapConfiguracao := TDictionary<String,AnsiString>.Create;
end;

function TConfiguracao.GetConfiguracao(Cfg: TTipoConfiguracao): AnsiString;
var
  Reg : TRegistroConfiguracao;
begin
  if FMapConfiguracao.Count = 0 then
    PopulaDataSet;
  Reg := GetRegistroConfiguracao(Cfg);
//  if not DataSetConfiguracao.Locate('SECAO;NOMECONFIGURACAO', VarArrayOf([Reg.Secao, Reg.NomeConfiguracao]), []) then
//    Result := Reg.ValorPadrao
//  else
//    Result := DataSetConfiguracao.FieldByName('VALOR').AsString;



   if not FMapConfiguracao.TryGetValue(Reg.Secao+'-'+ Reg.NomeConfiguracao, Result) then
    Result := Reg.ValorPadrao;

end;


procedure TConfiguracao.PopulaDataSet;
var
  StrSQL : String;
  DataSetConfiguracao: TpFIBClientDataSet;
begin
  Try
    DataSetConfiguracao := TpFIBClientDataSet.Create(nil);
    StrSQL :=
      'SELECT NOMECONFIGURACAO,  VALOR, DESCRICAO, SECAO '+
      '  FROM CONFIGURACAO ';
    SetCds(DataSetConfiguracao, StrSQL);
    DataSetConfiguracao.First;
    FMapConfiguracao.Clear;
    while not DataSetConfiguracao.Eof do
    begin
      FMapConfiguracao.Add(DataSetConfiguracao.FieldByName('SECAO').AsString+'-'+
                           DataSetConfiguracao.FieldByName('NOMECONFIGURACAO').AsString,
                           DataSetConfiguracao.FieldByName('VALOR').Value);
      DataSetConfiguracao.Next;
    end;
  Finally
    FreeAndNil(DataSetConfiguracao);
  End;
end;

procedure TConfiguracao.SetConfiguracao(Cfg: TTipoConfiguracao;
  Valor: AnsiString);
var
  Reg : TRegistroConfiguracao;
  StrSQL : String;
begin
  Reg := GetRegistroConfiguracao(Cfg);
  Reg.Valor := Valor;
  try
    StartTrans;
    StrSQL :=
      'UPDATE OR INSERT INTO CONFIGURACAO (NOMECONFIGURACAO,  VALOR, DESCRICAO, SECAO) '+
      '  VALUES ('+GetStr(Reg.NomeConfiguracao)+', '+GetStr(Reg.Valor)+', '+GetStr(Reg.Descricao)+', '+GetStr(Reg.Secao)+') '+
      ' MATCHING(NOMECONFIGURACAO, SECAO)';
    Exec_SQL(StrSQL);
    Commit;
    PopulaDataSet;
  except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  end;
end;


end.
