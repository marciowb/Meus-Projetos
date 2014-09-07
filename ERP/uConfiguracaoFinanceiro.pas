unit uConfiguracaoFinanceiro;

interface
   uses SysUtils, Classes, Windows, MinhasClasses,
         uGerenteConfiguracao;
    type
      TConfiguracaoFinanceiro =class(TConfiguracao)
        Function GetRegistroConfiguracao(Cfg: TTipoConfiguracao): IRegistroConfiguracao;override;
      end;
var
  ConfiguracaoFinanceiro: TConfiguracaoFinanceiro;
implementation

{ TConfiguracaoFinanceiro }

function TConfiguracaoFinanceiro.GetRegistroConfiguracao(
  Cfg: TTipoConfiguracao): IRegistroConfiguracao;
begin
  Result := TRegistroConfiguracao.Create;
  Result.Secao :='Financeiro';
  Result.ValorPadrao := -1;
  Result.TipoCampo := tcReal;

  case Cfg of
    tpcERPAliqJurosDia:
    begin
      Result.NomeConfiguracao :='AliqJurosDia';
      Result.Descricao := 'Alíquota de juros por dia'
    end ;
    tpcERPAliqMoraDia:
    begin
      Result.NomeConfiguracao :='AliqMoraDia';
      Result.Descricao := 'Alíquota de mora por dia'
    end ;
    tpcERPAliqMoraMax:
    begin
      Result.NomeConfiguracao :='AliqMoraMax';
      Result.Descricao := 'Alíquota máxima de mora ' ;
      Result.ValorPadrao := 20;
    end ;
    tpcERPPlanoContasFaturamentoDireto:
    begin
      Result.NomeConfiguracao :='PlanoContasFaturamentoDireto';
      Result.Descricao := 'Plano De Contas para faturamento direto' ;
      Result.TipoCampo := tcString;
    end ;
    tpcERPPlanoContasFaturamentoDeOS:
    begin
      Result.NomeConfiguracao :='PlanoContasFaturamentoDeOS';
      Result.Descricao := 'Plano De Contas para faturamento oriundo de O.S.' ;
      Result.TipoCampo := tcString;
    end ;
   tpcERPPlanoContasFaturamentoContrato:
    begin
      Result.NomeConfiguracao :='PlanoContasFaturamentoContrato';
      Result.Descricao := 'Plano De Contas para faturamento oriundo de contrato' ;
      Result.TipoCampo := tcString;
    end ;

  end;


end;

initialization
  ConfiguracaoFinanceiro := TConfiguracaoFinanceiro.Create;
end.
