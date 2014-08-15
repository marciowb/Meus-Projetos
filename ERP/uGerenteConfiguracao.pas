unit uGerenteConfiguracao;

interface
   uses SysUtils, Classes, Windows, MinhasClasses,
        Comandos, Db, DBClient, pFIBClientDataSet, Variants, Generics.Collections;
   Type
     IRegistroConfiguracao = interface
        function GetDescricao: AnsiString;
        function GetNomeConfiguracao: AnsiString;
        function GetSecao: AnsiString;
        function GetTipoCampo: TTipoCampo;
        function GetValor: Variant;
        function GetValorPadrao: Variant;
        procedure SetDescricao(const Value: AnsiString);
        procedure SetNomeConfiguracao(const Value: AnsiString);
        procedure SetSecao(const Value: AnsiString);
        procedure SetTipoCampo(const Value: TTipoCampo);
        procedure SetValor(const Value: Variant);
        procedure SetValorPadrao(const Value: Variant);
        property NomeConfiguracao :AnsiString read GetNomeConfiguracao write SetNomeConfiguracao;
        property Secao :AnsiString read GetSecao write SetSecao;
        property Valor :Variant read GetValor write SetValor;
        property TipoCampo : TTipoCampo read GetTipoCampo write SetTipoCampo;
        property ValorPadrao :Variant read GetValorPadrao write SetValorPadrao;
        property Descricao : AnsiString read GetDescricao write SetDescricao;
     End;

     TRegistroConfiguracao = class(TInterfacedObject,IRegistroConfiguracao)
     private
        fDescricao: AnsiString;
        fNomeConfiguracao: AnsiString;
        fSecao: AnsiString;
        fTipoCampo: TTipoCampo;
        fValor: Variant;
        fValorPadrao: Variant;

        function GetDescricao: AnsiString;
        function GetNomeConfiguracao: AnsiString;
        function GetSecao: AnsiString;
        function GetTipoCampo: TTipoCampo;
        function GetValor: Variant;
        function GetValorPadrao: Variant;
        procedure SetDescricao(const Value: AnsiString);
        procedure SetNomeConfiguracao(const Value: AnsiString);
        procedure SetSecao(const Value: AnsiString);
        procedure SetTipoCampo(const Value: TTipoCampo);
        procedure SetValor(const Value: Variant);
        procedure SetValorPadrao(const Value: Variant);
      published
        property NomeConfiguracao :AnsiString read GetNomeConfiguracao write SetNomeConfiguracao;
        property Secao :AnsiString read GetSecao write SetSecao;
        property Valor :Variant read GetValor write SetValor;
        property TipoCampo : TTipoCampo read GetTipoCampo write SetTipoCampo;
        property ValorPadrao :Variant read GetValorPadrao write SetValorPadrao;
        property Descricao : AnsiString read GetDescricao write SetDescricao;
     End;


     TConfiguracao = Class
     private
       FMapConfiguracao : TDictionary<String,variant>;
     published
       Constructor Create;virtual;
       Procedure PopulaDataSet;virtual;
       Procedure SetConfiguracao(Cfg: TTipoConfiguracao; Valor : variant);virtual;
       Function GetRegistroConfiguracao(Cfg: TTipoConfiguracao): IRegistroConfiguracao;virtual;abstract;
       Function GetConfiguracao(Cfg: TTipoConfiguracao): variant;virtual;
     End;

     ClasseConfiguracao = class of TConfiguracao;

var
   Configuracao: TConfiguracao;
implementation

{ TConfiguracao }

constructor TConfiguracao.Create;
begin
   inherited;
  FMapConfiguracao := TDictionary<String,Variant>.Create;
end;

function TConfiguracao.GetConfiguracao(Cfg: TTipoConfiguracao): variant;
var
  Reg : IRegistroConfiguracao;
begin
  if FMapConfiguracao.Count = 0 then
    PopulaDataSet;
  Reg := GetRegistroConfiguracao(Cfg);

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
      'SELECT NOMECONFIGURACAO,  VALOR, DESCRICAO, NOMESECAO '+
      '  FROM CONFIGURACOES ';
    SetCds(DataSetConfiguracao, StrSQL);
    DataSetConfiguracao.First;
    FMapConfiguracao.Clear;
    while not DataSetConfiguracao.Eof do
    begin
      FMapConfiguracao.Add(DataSetConfiguracao.FieldByName('NOMESECAO').AsString+'-'+
                           DataSetConfiguracao.FieldByName('NOMECONFIGURACAO').AsString,
                           DataSetConfiguracao.FieldByName('VALOR').Value);
      DataSetConfiguracao.Next;
    end;
  Finally
    FreeAndNil(DataSetConfiguracao);
  End;
end;

procedure TConfiguracao.SetConfiguracao(Cfg: TTipoConfiguracao;
  Valor: variant);
var
  Reg : IRegistroConfiguracao;
  StrSQL : String;
begin
  Reg := GetRegistroConfiguracao(Cfg);
  Reg.Valor := Valor;
  try
    StartTrans;
    StrSQL :=
      'UPDATE OR INSERT INTO CONFIGURACOES (NOMECONFIGURACAO,  VALOR, DESCRICAO, NOMESECAO) '+
      '  VALUES ('+GetStr(Reg.NomeConfiguracao)+', '+GetStr(Reg.Valor)+', '+GetStr(Reg.Descricao)+', '+GetStr(Reg.Secao)+') '+
      ' MATCHING(NOMECONFIGURACAO, NOMESECAO)';
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

{ TRegistroConfiguracao }

function TRegistroConfiguracao.GetDescricao: AnsiString;
begin
  Result := fDescricao;
end;

function TRegistroConfiguracao.GetNomeConfiguracao: AnsiString;
begin
 Result := fNomeConfiguracao;
end;

function TRegistroConfiguracao.GetSecao: AnsiString;
begin
  Result := fSecao;
end;

function TRegistroConfiguracao.GetTipoCampo: TTipoCampo;
begin
  Result :=  fTipoCampo;
end;

function TRegistroConfiguracao.GetValor: Variant;
begin
  Result := fValor;
end;

function TRegistroConfiguracao.GetValorPadrao: Variant;
begin
  result := fValorPadrao;
end;

procedure TRegistroConfiguracao.SetDescricao(const Value: AnsiString);
begin
  fDescricao:= Value;
end;

procedure TRegistroConfiguracao.SetNomeConfiguracao(const Value: AnsiString);
begin
  fNomeConfiguracao := Value;
end;

procedure TRegistroConfiguracao.SetSecao(const Value: AnsiString);
begin
  fSecao := Value;
end;

procedure TRegistroConfiguracao.SetTipoCampo(const Value: TTipoCampo);
begin
   fTipoCampo:= Value;
end;

procedure TRegistroConfiguracao.SetValor(const Value: Variant);
begin
  fValor := Value;
end;

procedure TRegistroConfiguracao.SetValorPadrao(const Value: Variant);
begin
  fValorPadrao := Value;
end;

initialization
   Configuracao := TConfiguracao.Create;

end.
