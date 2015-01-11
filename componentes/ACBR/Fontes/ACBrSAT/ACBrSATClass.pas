{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrSATClass ;

interface

uses
  Classes, SysUtils, pcnConversao ;

const
  cACBrSAT_Versao      = '0.1.1' ;
  cLIBSAT              = 'SAT.DLL';
  cversaoDadosEnt      = 0.05;

  cACBrSATClassCreateException = 'Essa Classe deve ser instanciada por TACBrSAT' ;
  cACBrSATSetModeloException   = 'Não é possível mudar o Modelo com o SAT Inicializado' ;
  cACBrSATModeloNaoDefinido    = 'Modelo de SAT não definido' ;
  cACBrSATNaoInicializado      = 'ACBrSAT não foi inicializado corretamente' ;
  cACBrSATFuncaoNaoEncontrada  = 'Erro ao carregar a função: %s na Biblioteca: %s' ;
  cACBrSATCMDInvalidoException = 'Procedure: %s '+ sLineBreak +
                                 ' não implementada para o SAT: %s'+sLineBreak + sLineBreak +
                                 'Ajude no desenvolvimento do ACBrSAT. '+ sLineBreak+
                                 'Acesse nosso Forum em: http://projetoacbr.com.br/' ;
type

  TACBrSATModelo = ( satNenhum, satDinamico_cdecl, satDinamico_stdcall ) ;

  { EACBrSATErro }

  EACBrSATErro = class(Exception)
  public
    constructor Create(const msg : string);
  end ;

  { Eventos do componente }
  TACBrSATGetChave = procedure(var Chave: AnsiString) of object ;
  TACBrSATDoLog = procedure(const AString: String) of object ;

  { TACBrSATConfig }

  TACBrSATConfig = Class(TPersistent)
  private
    fsemit_CNPJ : String ;
    fsemit_cRegTrib : TpcnRegTrib ;
    fsemit_cRegTribISSQN : TpcnRegTribISSQN ;
    fsemit_IE : String ;
    fsemit_IM : String ;
    fsemit_indRatISSQN : TpcnindRatISSQN ;
    fside_CNPJ : String ;
    fside_numeroCaixa : Integer ;
    fsinfCFe_versaoDadosEnt : Real ;
    fside_tpAmb : TpcnTipoAmbiente ;
    fsPaginaDeCodigo: Word;
    function GetEhUTF8: Boolean;
    procedure SetEhUTF8(AValue: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
  published
    property infCFe_versaoDadosEnt : Real read fsinfCFe_versaoDadosEnt
        write fsinfCFe_versaoDadosEnt ;
    property ide_CNPJ : String  read fside_CNPJ write fside_CNPJ;
    property ide_numeroCaixa : Integer read fside_numeroCaixa
       write fside_numeroCaixa ;
    property ide_tpAmb : TpcnTipoAmbiente read fside_tpAmb write fside_tpAmb;

    property emit_CNPJ : String read fsemit_CNPJ write fsemit_CNPJ;
    property emit_IE   : String read fsemit_IE   write fsemit_IE;
    property emit_IM   : String read fsemit_IM   write fsemit_IM;
    property emit_cRegTrib: TpcnRegTrib read fsemit_cRegTrib
       write fsemit_cRegTrib ;
    property emit_cRegTribISSQN: TpcnRegTribISSQN read fsemit_cRegTribISSQN
       write fsemit_cRegTribISSQN ;
    property emit_indRatISSQN: TpcnindRatISSQN read fsemit_indRatISSQN
       write fsemit_indRatISSQN;
    property EhUTF8: Boolean read GetEhUTF8 write SetEhUTF8;
    property PaginaDeCodigo : Word read fsPaginaDeCodigo write fsPaginaDeCodigo;
  end;

  { TACBrSATRespostaClass }

  TACBrSATResposta = class
  private
    fcodigoDeRetorno : Integer ;
    fnumeroSessao : Integer ;
    fRetornoLst : TStringList ;
    fRetornoStr : String ;
    procedure SetRetornoStr(AValue : String) ;
  public
    constructor Create ;
    Destructor Destroy ; override ;
    procedure Clear ;

    property numeroSessao : Integer read fnumeroSessao ;
    property codigoDeRetorno : Integer read  fcodigoDeRetorno;
    property RetornoLst : TStringList read fRetornoLst ;
    property RetornoStr : String read fRetornoStr write SetRetornoStr ;
  end ;

  { TACBrSATClass }

   TACBrSATClass = class( TComponent )
   private
     function GetcodigoDeAtivacao : AnsiString ;
     function GetnumeroSessao : Integer ;
     function GetNomeDLL : string ;

     procedure ErroAbstract( NomeProcedure : String ) ;
     function GetsignAC : AnsiString ;
   protected
     fpOwner : TComponent ;   { Componente ACBrSAT }
     fpModeloStr: String;

     function GetModeloStr: String; virtual ;

     property NomeDLL: String read GetNomeDLL ;

     property codigoDeAtivacao : AnsiString read GetcodigoDeAtivacao ;
     property signAC : AnsiString read GetsignAC ;
     property numeroSessao : Integer read GetnumeroSessao ;

     procedure LoadDLLFunctions ; virtual ;
     procedure UnLoadDLLFunctions ; virtual ;
     procedure FunctionDetectLibSAT(FuncName : String ;
       var LibPointer : Pointer) ; virtual ;
   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar; virtual ;
     procedure DesInicializar ; virtual ;

     Property ModeloStr: String read GetModeloStr ;

     function AssociarAssinatura( CNPJvalue, assinaturaCNPJs : AnsiString ):
       String ; virtual;
     function AtivarSAT( subComando : Integer; CNPJ: AnsiString; cUF : Integer )
       : String ; virtual;
     function AtualizarSoftwareSAT : String ; virtual;
     function BloquearSAT : String ; virtual;
     function CancelarUltimaVenda( chave, dadosCancelamento : AnsiString ) :
       String ; virtual;
     function ComunicarCertificadoICPBRASIL( certificado : AnsiString ) :
       String ; virtual;
     function ConfigurarInterfaceDeRede( dadosConfiguracao : AnsiString ) :
       String ; virtual;
     function ConsultarNumeroSessao( cNumeroDeSessao : Integer) : String ;
       virtual;
     function ConsultarSAT : String ; virtual;
     function ConsultarStatusOperacional : String ; virtual;
     function DesbloquearSAT : String ; virtual;
     function EnviarDadosVenda( dadosVenda : AnsiString ) : String ; virtual;
     function ExtrairLogs : String ; virtual;
     function TesteFimAFim( dadosVenda : AnsiString) : String ; virtual;
     function TrocarCodigoDeAtivacao( codigoDeAtivacaoOuEmergencia: AnsiString;
       opcao : Integer; novoCodigo: AnsiString ) : String ; virtual;

   end;

implementation

Uses ACBrSAT, ACBrUtil, ACBrConsts ;

{ TACBrSATRespostaClass }

procedure TACBrSATResposta.SetRetornoStr(AValue : String) ;
var
  Buffer:String;
begin
  fRetornoStr := AValue;

  // Ajuste para Respostas do SAT com CR ou LF antes do Pipe
  Buffer := StringReplace( AValue, CRLF+'|', '|', [rfReplaceAll] );
  Buffer := StringReplace( Buffer, LF+'|', '|', [rfReplaceAll] );

  Clear;
  fRetornoLst.Text := StringReplace( Buffer, '|', sLineBreak, [rfReplaceAll] );

  if fRetornoLst.Count > 1 then
  begin
    fnumeroSessao    := StrToIntDef( fRetornoLst[0], 0);
    fcodigoDeRetorno := StrToIntDef( fRetornoLst[1], 0);
  end ;
end;

constructor TACBrSATResposta.Create ;
begin
  inherited Create;
  fRetornoLst := TStringList.Create;
  Clear;
end ;

destructor TACBrSATResposta.Destroy ;
begin
  fRetornoLst.Free;
  inherited Destroy;
end ;

procedure TACBrSATResposta.Clear ;
begin
  fRetornoLst.Clear;
  fRetornoStr      := '';
  fnumeroSessao    := 0;
  fcodigoDeRetorno := 0;
end ;

{ TACBrSATConfig }

function TACBrSATConfig.GetEhUTF8: Boolean;
begin
  Result := (fsPaginaDeCodigo = 65001);
end;

procedure TACBrSATConfig.SetEhUTF8(AValue: Boolean);
begin
   if AValue then
     fsPaginaDeCodigo := 65001
   else
   begin
     if fsPaginaDeCodigo = 65001 then
       fsPaginaDeCodigo := 0;
   end ;

end;

constructor TACBrSATConfig.Create ;
begin
  inherited Create;
  Clear;
end ;

destructor TACBrSATConfig.Destroy ;
begin
  inherited Destroy ;
end ;

procedure TACBrSATConfig.Clear ;
begin
  fsemit_CNPJ             := '' ;
  fsemit_cRegTrib         := RTSimplesNacional;
  fsemit_cRegTribISSQN    := RTISSMicroempresaMunicipal;
  fsemit_IE               := '' ;
  fsemit_IM               := '' ;
  fsemit_indRatISSQN      := irSim ;
  fside_CNPJ              := '' ;
  fside_numeroCaixa       := 0 ;
  fside_tpAmb             := taHomologacao ;
  fsinfCFe_versaoDadosEnt := cversaoDadosEnt ;
end ;

{ EACBrSATErro }

constructor EACBrSATErro.Create(const msg : string) ;
begin
  inherited Create( ACBrStr(msg) );
end ;

{ TACBrSATClass }

constructor TACBrSATClass.Create(AOwner : TComponent) ;
begin
  if not (AOwner is TACBrSAT) then
     raise EACBrSATErro.create( cACBrSATClassCreateException );

  inherited Create(AOwner) ;

  fpOwner := AOwner ;
  fpModeloStr := 'Não Definido' ;
end ;

destructor TACBrSATClass.Destroy ;
begin
  UnLoadDLLFunctions;
  inherited Destroy ;
end ;

procedure TACBrSATClass.Inicializar ;
begin
  LoadDLLFunctions;
end ;

procedure TACBrSATClass.DesInicializar ;
begin
  UnLoadDLLFunctions;
end ;

function TACBrSATClass.GetNomeDLL : string ;
begin
  Result := TACBrSAT(fpOwner).NomeDLL;
end;

procedure TACBrSATClass.ErroAbstract(NomeProcedure : String) ;
begin
  raise EACBrSATErro.create( Format( cACBrSATCMDInvalidoException,
                                     [NomeProcedure, ModeloStr] )) ;
end ;

function TACBrSATClass.GetsignAC : AnsiString ;
begin
  Result := TACBrSAT(fpOwner).signAC;
end;

function TACBrSATClass.GetcodigoDeAtivacao : AnsiString ;
begin
  Result := TACBrSAT(fpOwner).codigoDeAtivacao;
end;

function TACBrSATClass.GetnumeroSessao : Integer ;
begin
  Result := TACBrSAT(fpOwner).numeroSessao;
end;

procedure TACBrSATClass.LoadDLLFunctions;
begin
  ErroAbstract('LoadDLLFunctions');
end;

procedure TACBrSATClass.UnLoadDLLFunctions ;
begin
  UnLoadLibrary( NomeDLL );
end ;

function TACBrSATClass.AssociarAssinatura(CNPJvalue,
  assinaturaCNPJs : AnsiString) : String ;
begin
  ErroAbstract('AssociarAssinatura');
  Result := '';
end ;

function TACBrSATClass.AtivarSAT(subComando : Integer ; CNPJ : AnsiString ;
  cUF : Integer) : String ;
begin
  ErroAbstract('AtivarSAT');
  Result := '';
end ;

function TACBrSATClass.AtualizarSoftwareSAT : String ;
begin
  ErroAbstract('AtualizarSoftwareSAT');
  Result := '';
end ;

function TACBrSATClass.BloquearSAT : String ;
begin
  ErroAbstract('BloquearSAT');
  Result := '';
end ;

function TACBrSATClass.CancelarUltimaVenda(chave, dadosCancelamento : AnsiString
  ) : String ;
begin
  ErroAbstract('CancelarUltimaVenda');
  Result := '';
end ;

function TACBrSATClass.ComunicarCertificadoICPBRASIL(certificado : AnsiString
  ) : String ;
begin
  ErroAbstract('ComunicarCertificadoICPBRASIL');
  Result := '';
end ;

function TACBrSATClass.ConfigurarInterfaceDeRede(dadosConfiguracao : AnsiString
  ) : String ;
begin
  ErroAbstract('ConfigurarInterfaceDeRede');
  Result := '';
end ;

function TACBrSATClass.ConsultarNumeroSessao(cNumeroDeSessao : Integer
  ) : String ;
begin
  ErroAbstract('ConsultarNumeroSessao');
  Result := '';
end ;

function TACBrSATClass.ConsultarSAT : String ;
begin
  ErroAbstract('ConsultarSAT');
  Result := '';
end ;

function TACBrSATClass.ConsultarStatusOperacional : String ;
begin
  ErroAbstract('ConsultarStatusOperacional');
  Result := '';
end ;

function TACBrSATClass.DesbloquearSAT : String ;
begin
  ErroAbstract('DesbloquearSAT');
  Result := '';
end ;

function TACBrSATClass.EnviarDadosVenda(dadosVenda : AnsiString) : String ;
begin
  ErroAbstract('EnviarDadosVenda');
  Result := '';
end ;

function TACBrSATClass.ExtrairLogs : String ;
begin
  ErroAbstract('ExtrairLogs');
  Result := '';
end ;

function TACBrSATClass.TesteFimAFim(dadosVenda : AnsiString) : String ;
begin
  ErroAbstract('TesteFimAFim');
  Result := '';
end ;

function TACBrSATClass.TrocarCodigoDeAtivacao(
  codigoDeAtivacaoOuEmergencia: AnsiString; opcao: Integer; novoCodigo: AnsiString
  ): String;
begin
  ErroAbstract('TrocarCodigoDeAtivacao');
  Result := '';
end ;

function TACBrSATClass.GetModeloStr : String ;
begin
  Result := fpModeloStr;
end ;

procedure TACBrSATClass.FunctionDetectLibSAT(FuncName : String ;
  var LibPointer : Pointer) ;
var
  sLibName: String;
begin
  if not Assigned( LibPointer )  then
  begin
    sLibName := NomeDLL;
    if not FileExists(sLibName) then
      raise EACBrSATErro.Create( 'Arquivo não encontrado: '+sLibName );

    if not FunctionDetect( sLibName, FuncName, LibPointer) then
    begin
       LibPointer := NIL ;
       raise EACBrSATErro.Create( Format(cACBrSATFuncaoNaoEncontrada, [FuncName,sLibName]) ) ;
    end ;
  end ;
end ;

end.

