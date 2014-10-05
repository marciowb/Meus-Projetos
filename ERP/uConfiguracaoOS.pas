unit uConfiguracaoOS;

interface
    uses SysUtils, Classes, Windows, MinhasClasses,
         uGerenteConfiguracao;
    type
      TCOnfiguracaoOS =class(TConfiguracao)
      private
        Function GetRegistroConfiguracao(Cfg: TTipoConfiguracao): IRegistroConfiguracao;override;
      end;
var
  COnfiguracaoOS: TCOnfiguracaoOS;
implementation

uses uConstantes;

{ TCOnfiguracaoOS }

function TCOnfiguracaoOS.GetRegistroConfiguracao(
  Cfg: TTipoConfiguracao): IRegistroConfiguracao;
begin
  Result := TRegistroConfiguracao.Create;
  Result.Secao :='OS';
  Result.ValorPadrao := -1;
  Result.TipoCampo := tcString;
  case Cfg of
    tpcERPStatusOSAberta:
    begin
      Result.NomeConfiguracao :='StatusOSAberta';
      Result.Descricao := 'Status das O.S. Abertas'
    end ;
    tpcERPStatusOSFinalizada:
    begin
      Result.NomeConfiguracao :='StatusOSFinalizada';
      Result.Descricao := 'Status das O.S. Finalizada'
    end ;
    tpcERPStatusOSExecucao:
    begin
      Result.NomeConfiguracao :='StatusOSExecucao';
      Result.Descricao := 'Status das O.S. Execucao'
    end ;
    tpcERPStatusOSFaturada:
     begin
      Result.NomeConfiguracao :='StatusOSFaturada';
      Result.Descricao := 'Status das O.S. Faturada'
    end ;
    tpcERPOperacaoFaturarOS:
    begin
      Result.NomeConfiguracao :='OperacaoFaturarOS';
      Result.Descricao := 'Operação para faturar O.S.'
    end ;
    tpcERPBloqueiaFaturamentoParaOSNaoBaixada:
    begin
      Result.NomeConfiguracao :='BloqueiaFaturamentoParaOSNaoBaixada';
      Result.Descricao := 'Bloqueia o faturamento para O.S. não baixada';
      Result.TipoCampo := tcInt;
      Result.ValorPadrao := CfgOSBloqueiaFaturamentoParaOSNaoBaixadaNaoPermite;
    end ;


  end;
end;

initialization
  COnfiguracaoOS := TCOnfiguracaoOS.Create;

end.
