unit UCfgPadrao;

interface
   uses SysUtils, Classes, Db, StrUtils, Windows, MinhasClasses,
       comandos, UDmConexao, pFIBClientDataSet;
  Type
    TResultado = packed Record
      NomeConfiguracao : String;
      NomeSecao : String;
      ValorPadrao : String;
      TipoCampo : TTipoCampo;
    End;

    TConfiguracao = Class
      Function GetValorConfiguracao(Cfg: TTipoConfiguracao): TResultado;virtual;
     public
      Procedure SetConfiguracao(Cfg: TTipoConfiguracao; Valor : String);
      Function GetConfiguracao(Cfg: TTipoConfiguracao):String;
    End;
implementation

{ TConfiguracao }

function TConfiguracao.GetConfiguracao(Cfg: TTipoConfiguracao): String;
var
  StrSQL : String;
  Cds : TpFIBClientDataSet;
begin
   if DMCOnexao = nil then
     Exit;
   with GetValorConfiguracao(cfg) do
   Begin
     StrSQL :=
       'SELECT IDCONFIGURACAO, NOMSECAO, NOMECONFIGURACAO, VALORNUMERICO, VALORSTRING '+
       '  FROM CONFIGURACAO '+
       ' WHERE NOMSECAO = '+GetStr(NomeSecao)+
       '   AND NOMECONFIGURACAO = '+GetStr(NomeConfiguracao);
    Try
      Cds := TpFIBClientDataSet.Create(nil);
      SetCds(Cds, StrSQL);
      if TipoCampo = tcString then
         Result := Cds.FieldByName('VALORSTRING').AsString
      else
        Result := Cds.FieldByName('VALORNUMERICO').AsString;
      if Result = '' then
        Result := ValorPadrao;
    Finally
      FreeAndNil(Cds);
    End;
   End;

end;

function TConfiguracao.GetValorConfiguracao(Cfg: TTipoConfiguracao): TResultado;
begin

end;

procedure TConfiguracao.SetConfiguracao(Cfg: TTipoConfiguracao; Valor: String);
var
  StrSQL : String;
begin
  try
    StartTrans;
    with GetValorConfiguracao(Cfg) do
    Begin
      if valor = '' then
        Valor := ValorPadrao;
      StrSQL :=
        'UPDATE OR INSERT INTO CONFIGURACAO (NOMSECAO, NOMECONFIGURACAO, VALORNUMERICO, VALORSTRING) '+
         '   VALUES ('+
         GetStr(NomeSecao)+' , '+
         GetStr(NomeConfiguracao)+', '+
         IfThen(TipoCampo = tcReal, Valor, 'null')+', '+
         IfThen(TipoCampo = tcString, GetStr(Valor), 'null')+') MATCHING(NOMSECAO, NOMECONFIGURACAO)';
    End;
    Exec_SQL(StrSQL);
    Commit;
  except
    on E: Exception do
    Begin
      RollBack;
      raise;
    End;
  end;
end;


end.
