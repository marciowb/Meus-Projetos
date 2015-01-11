unit ACBrValidadorTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,
  ACBrValidador;

type

  { TTestCaseACBrValidadorCPF }

  TTestCaseACBrValidadorCPF = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroCPF: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Valido;
    procedure ValidoComSeparadores;
    procedure Invalido;
    procedure NumerosSequenciais;
    procedure MenorOnzeDigitos;
    procedure MaiorOnzeDigitos;
    procedure ComLetras;
    procedure Formatar;
  end;

  { TTestCaseACBrValidadorCNPJ }

  TTestCaseACBrValidadorCNPJ = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroCNPJ: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Valido;
    procedure ValidoComSeparadores;
    procedure Invalido;
    procedure NumeroComZeros;
    procedure MenorQuatorzeDigitos;
    procedure MaiorQuatorzeDigitos;
    procedure ComLetras;
    procedure Formatar;
  end;

  { TTestCaseACBrValidadorUF }

  TTestCaseACBrValidadorUF = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Validos;
    procedure Invalido;
  end;

  { TTestCaseACBrValidadorIE }

  TTestCaseACBrValidadorIE = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroIE: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ValidoAC ;
    procedure InvalidoAC ;
    procedure FormatarAC;
    procedure ValidoAL ;
    procedure InvalidoAL ;
    procedure FormatarAL;
    procedure ValidoAP ;
    procedure InvalidoAP ;
    procedure FormatarAP;
    procedure ValidoAM ;
    procedure InvalidoAM ;
    procedure FormatarAM;
    procedure ValidoBA ;
    procedure InvalidoBA ;
    procedure FormatarBA;
    procedure ValidoCE ;
    procedure InvalidoCE ;
    procedure FormatarCE;
    procedure ValidoDF ;
    procedure InvalidoDF ;
    procedure FormatarDF;
    procedure ValidoES ;
    procedure InvalidoES ;
    procedure FormatarES;
    procedure ValidoGO ;
    procedure InvalidoGO ;
    procedure FormatarGO;
    procedure ValidoMA ;
    procedure InvalidoMA ;
    procedure FormatarMA;
    procedure ValidoMT ;
    procedure InvalidoMT ;
    procedure FormatarMT;
    procedure ValidoMS ;
    procedure InvalidoMS ;
    procedure FormatarMS;
    procedure ValidoMG ;
    procedure InvalidoMG ;
    procedure FormatarMG;
    procedure ValidoPA ;
    procedure InvalidoPA ;
    procedure FormatarPA;
    procedure ValidoPB ;
    procedure InvalidoPB ;
    procedure FormatarPB;
    procedure ValidoPR ;
    procedure InvalidoPR ;
    procedure FormatarPR;
    procedure ValidoPE ;
    procedure InvalidoPE ;
    procedure FormatarPE;
    procedure ValidoPI ;
    procedure InvalidoPI ;
    procedure FormatarPI;
    procedure ValidoRJ ;
    procedure InvalidoRJ ;
    procedure FormatarRJ;
    procedure ValidoRN ;
    procedure InvalidoRN ;
    procedure FormatarRN;
    procedure ValidoRS ;
    procedure InvalidoRS ;
    procedure FormatarRS;
    procedure ValidoRO ;
    procedure InvalidoRO ;
    procedure FormatarRO;
    procedure ValidoRR ;
    procedure InvalidoRR ;
    procedure FormatarRR;
    procedure ValidoSC ;
    procedure InvalidoSC ;
    procedure FormatarSC;
    procedure ValidoSP ;
    procedure InvalidoSP ;
    procedure FormatarSP;
    procedure ValidoSE ;
    procedure InvalidoSE ;
    procedure FormatarSE;
    procedure ValidoTO ;
    procedure InvalidoTO ;
    procedure FormatarTO;
  end;

implementation

{ TTestCaseACBrValidadorIE }

function TTestCaseACBrValidadorIE.MsgErroIE: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TTestCaseACBrValidadorIE.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docInscEst;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TTestCaseACBrValidadorIE.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TTestCaseACBrValidadorIE.ValidoAC;
begin
  fACBrValidador.Complemento := 'AC';
  fACBrValidador.Documento := '01.004.823/001-12';  // 13 dígitos
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '013456784';          // 9 dígitos
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoAC;
begin
  fACBrValidador.Complemento := 'AC';
  fACBrValidador.Documento := '';             // Testando Vazio apenas 1 vez
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '99999';        // Testando menos dígitos apenas 1 vez
  fACBrValidador.AjustarTamanho := True;
  AssertFalse(MsgErroIE , fACBrValidador.Validar);
  fACBrValidador.Documento := '01.004.823/001-99';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarAC;
begin
  fACBrValidador.Complemento := 'AC';
  fACBrValidador.Documento := '0100482300112';
  AssertEquals('01.004.823/001-12', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoAL;
begin
  fACBrValidador.Complemento := 'AL';
  fACBrValidador.Documento := '240123450';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoAL;
begin
  fACBrValidador.Complemento := 'AL';
  fACBrValidador.Documento := '240123456';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarAL;
begin
  fACBrValidador.Complemento := 'AL';
  fACBrValidador.Documento := '240123450';
  AssertEquals('240123450', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoAP;
begin
  fACBrValidador.Complemento := 'AP';
  fACBrValidador.Documento := '030123459';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '030170011';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '030190225';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '030190231';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoAP;
begin
  fACBrValidador.Complemento := 'AP';
  fACBrValidador.Documento := '123456789';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarAP;
begin
  fACBrValidador.Complemento := 'AP';
  fACBrValidador.Documento := '030123459';
  AssertEquals('030123459', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoAM;
begin
  fACBrValidador.Complemento := 'AM';
  fACBrValidador.Documento := '123123127';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoAM;
begin
  fACBrValidador.Complemento := 'AM';
  fACBrValidador.Documento := '123123123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarAM;
begin
  fACBrValidador.Complemento := 'AM';
  fACBrValidador.Documento := '123123127';
  AssertEquals('12.312.312-7', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoBA;
begin
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '123456-63';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '173456-13';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoBA;
begin
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '123456-78';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarBA;
begin
  fACBrValidador.Complemento := 'BA';
  fACBrValidador.Documento := '12345663';
  AssertEquals('0123456-63', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoCE;
begin
  fACBrValidador.Complemento := 'CE';
  fACBrValidador.Documento := '023456787';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoCE;
begin
  fACBrValidador.Complemento := 'CE';
  fACBrValidador.Documento := '123456789';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarCE;
begin
  fACBrValidador.Complemento := 'CE';
  fACBrValidador.Documento := '023456787';
  AssertEquals('02345678-7', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoDF;
begin
  fACBrValidador.Complemento := 'DF';
  fACBrValidador.Documento := '0734567890103';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoDF;
begin
  fACBrValidador.Complemento := 'DF';
  fACBrValidador.Documento := '12345678901';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);  // Tamanho inválido
  fACBrValidador.Documento := '1234567890123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarDF;
begin
  fACBrValidador.Complemento := 'DF';
  fACBrValidador.Documento := '0734567890103';
  AssertEquals('07345678901-03', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoES;
begin
  fACBrValidador.Complemento := 'ES';
  fACBrValidador.Documento := '123123127';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoES;
begin
  fACBrValidador.Complemento := 'ES';
  fACBrValidador.Documento := '123123123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarES;
begin
  fACBrValidador.Complemento := 'ES';
  fACBrValidador.Documento := '123123127';
  AssertEquals('123123127', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoGO;
begin
  fACBrValidador.Complemento := 'GO';
  fACBrValidador.Documento := '10.987.654-7';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoGO;
begin
  fACBrValidador.Complemento := 'GO';
  fACBrValidador.Documento := '12.312.312-3';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarGO;
begin
  fACBrValidador.Complemento := 'GO';
  fACBrValidador.Documento := '109876547';
  AssertEquals('10.987.654-7', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoMA;
begin
  fACBrValidador.Complemento := 'MA';
  fACBrValidador.Documento := '120000385';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoMA;
begin
  fACBrValidador.Complemento := 'MA';
  fACBrValidador.Documento := '123123123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarMA;
begin
  fACBrValidador.Complemento := 'MA';
  fACBrValidador.Documento := '120000385';
  AssertEquals('120000385', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoMT;
begin
  fACBrValidador.Complemento := 'MT';
  fACBrValidador.Documento := '0013000001-9';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoMT;
begin
  fACBrValidador.Complemento := 'MT';
  fACBrValidador.Documento := '1234567890-1';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarMT;
begin
  fACBrValidador.Complemento := 'MT';
  fACBrValidador.Documento := '130000019';
  AssertEquals('0013000001-9', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoMS;
begin
  fACBrValidador.Complemento := 'MS';
  fACBrValidador.Documento := '28.312.312-5';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoMS;
begin
  fACBrValidador.Complemento := 'MS';
  fACBrValidador.Documento := '123123123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarMS;
begin
  fACBrValidador.Complemento := 'MS';
  fACBrValidador.Documento := '283123125';
  AssertEquals('28.312.312-5', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoMG;
begin
  fACBrValidador.Complemento := 'MG';
  fACBrValidador.Documento := '062.307.904/0081';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoMG;
begin
  fACBrValidador.Complemento := 'MG';
  fACBrValidador.Documento := '123.123.123/9999';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarMG;
begin
  fACBrValidador.Complemento := 'MG';
  fACBrValidador.Documento := '0623079040081';
  AssertEquals('062.307.904/0081', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoPA;
begin
  fACBrValidador.Complemento := 'PA';
  fACBrValidador.Documento := '15999999-5';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoPA;
begin
  fACBrValidador.Complemento := 'PA';
  fACBrValidador.Documento := '15999999-9';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarPA;
begin
  fACBrValidador.Complemento := 'PA';
  fACBrValidador.Documento := '159999995';
  AssertEquals('15-999999-5', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoPB;
begin
  fACBrValidador.Complemento := 'PB';
  fACBrValidador.Documento := '16000001-7';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoPB;
begin
  fACBrValidador.Complemento := 'PB';
  fACBrValidador.Documento := '06000001-9';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarPB;
begin
  fACBrValidador.Complemento := 'PB';
  fACBrValidador.Documento := '160000017';
  AssertEquals('16000001-7', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoPR;
begin
  fACBrValidador.Complemento := 'PR';
  fACBrValidador.Documento := '123.45678-50';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoPR;
begin
  fACBrValidador.Complemento := 'PR';
  fACBrValidador.Documento := '123.45678-99';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarPR;
begin
  fACBrValidador.Complemento := 'PR';
  fACBrValidador.Documento := '1234567850';
  AssertEquals('123.45678-50', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoPE;
begin
  fACBrValidador.Complemento := 'PE';
  fACBrValidador.Documento := '0321418-40';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '18.1.001.0000004-9';    // Antigo formato
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoPE;
begin
  fACBrValidador.Complemento := 'PE';
  fACBrValidador.Documento := '0321418-99';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '18.1.001.0000004-0';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarPE;
begin
  fACBrValidador.Complemento := 'PE';
  fACBrValidador.Documento := '032141899';
  AssertEquals('0321418-99', fACBrValidador.Formatar);
  fACBrValidador.Documento := '18100100000040';
  AssertEquals('18.1.001.0000004-0', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoPI;
begin
  fACBrValidador.Complemento := 'PI';
  fACBrValidador.Documento := '192345672';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoPI;
begin
  fACBrValidador.Complemento := 'PI';
  fACBrValidador.Documento := '012345678';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarPI;
begin
  fACBrValidador.Complemento := 'PI';
  fACBrValidador.Documento := '192345672';
  AssertEquals('192345672', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoRJ;
begin
  fACBrValidador.Complemento := 'RJ';
  fACBrValidador.Documento := '12.123.12-4';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoRJ;
begin
  fACBrValidador.Complemento := 'RJ';
  fACBrValidador.Documento := '12.123.12-9';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarRJ;
begin
  fACBrValidador.Complemento := 'RJ';
  fACBrValidador.Documento := '12123124';
  AssertEquals('12.123.12-4', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoRN;
begin
  fACBrValidador.Complemento := 'RN';
  fACBrValidador.Documento := '20.040.040-1';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '20.0.040.040-0';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoRN;
begin
  fACBrValidador.Complemento := 'RN';
  fACBrValidador.Documento := '20.040.040-9';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '20.0.040.040-9';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarRN;
begin
  fACBrValidador.Complemento := 'RN';
  fACBrValidador.Documento := '200400401';
  AssertEquals('20.040.040-1', fACBrValidador.Formatar);
  fACBrValidador.Documento := '2000400400';
  AssertEquals('20.0.040.040-0', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoRS;
begin
  fACBrValidador.Complemento := 'RS';
  fACBrValidador.Documento := '224/3658792';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoRS;
begin
  fACBrValidador.Complemento := 'RS';
  fACBrValidador.Documento := '224/1234567';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarRS;
begin
  fACBrValidador.Complemento := 'RS';
  fACBrValidador.Documento := '2243658792';
  AssertEquals('224/3658792', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoRO;
begin
  fACBrValidador.Complemento := 'RO';
  fACBrValidador.Documento := '101.62521-3';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '0000000062521-3';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoRO;
begin
  fACBrValidador.Complemento := 'RO';
  fACBrValidador.Documento := '101.12345-6';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '1234567890521-3';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarRO;
begin
  fACBrValidador.Complemento := 'RO';
  fACBrValidador.Documento := '101625213';
  AssertEquals('101.62521-3', fACBrValidador.Formatar);
  fACBrValidador.Documento := '0000000062521-3';
  AssertEquals('0000000062521-3', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoRR;
begin
  fACBrValidador.Complemento := 'RR';
  fACBrValidador.Documento := '24008266-8';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoRR;
begin
  fACBrValidador.Complemento := 'RR';
  fACBrValidador.Documento := '12345678-8';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarRR;
begin
  fACBrValidador.Complemento := 'RR';
  fACBrValidador.Documento := '240082668';
  AssertEquals('24008266-8', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoSC;
begin
  fACBrValidador.Complemento := 'SC';
  fACBrValidador.Documento := '251.040.852';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoSC;
begin
  fACBrValidador.Complemento := 'SC';
  fACBrValidador.Documento := '123.123.123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarSC;
begin
  fACBrValidador.Complemento := 'SC';
  fACBrValidador.Documento := '251040852';
  AssertEquals('251.040.852', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoSP;
begin
  fACBrValidador.Complemento := 'SP';
  fACBrValidador.Documento := '110.042.490.114';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := 'P-01100424.3/002';  // Produtor Rural
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoSP;
begin
  fACBrValidador.Complemento := 'SP';
  fACBrValidador.Documento := '123.123.123.123';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := 'P-12345678.9/002';  // Produtor Rural
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarSP;
begin
  fACBrValidador.Complemento := 'SP';
  fACBrValidador.Documento := '110042490114';
  AssertEquals('110.042.490.114', fACBrValidador.Formatar);
  fACBrValidador.Documento := 'P011004243123';
  AssertEquals('P-01100424.3/123', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoSE;
begin
  fACBrValidador.Complemento := 'SE';
  fACBrValidador.Documento := '27123456-3';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoSE;
begin
  fACBrValidador.Complemento := 'SE';
  fACBrValidador.Documento := '12312312-3';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarSE;
begin
  fACBrValidador.Complemento := 'SE';
  fACBrValidador.Documento := '271234563';
  AssertEquals('27.123.456-3', fACBrValidador.Formatar);
end;

procedure TTestCaseACBrValidadorIE.ValidoTO;
begin
  fACBrValidador.Complemento := 'TO';
  fACBrValidador.Documento := '01.022.783-0';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '29.01.022783-6';
  AssertTrue(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.InvalidoTO;
begin
  fACBrValidador.Complemento := 'TO';
  fACBrValidador.Documento := '12.123.123-9';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
  fACBrValidador.Documento := '12.34.567890-6';
  AssertFalse(MsgErroIE, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorIE.FormatarTO;
begin
  fACBrValidador.Complemento := 'TO';
  fACBrValidador.Documento := '010227830';
  AssertEquals('01.022.783-0', fACBrValidador.Formatar);
  fACBrValidador.Documento := '29010227836';
  AssertEquals('29.01.022783-6', fACBrValidador.Formatar);
end;

{ TTestCaseACBrValidadorCPF }

function TTestCaseACBrValidadorCPF.MsgErroCPF: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TTestCaseACBrValidadorCPF.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docCPF;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TTestCaseACBrValidadorCPF.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TTestCaseACBrValidadorCPF.Valido;
begin
  fACBrValidador.Documento := '12345678909';
  AssertTrue(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.ValidoComSeparadores;
begin
  fACBrValidador.Documento := '123.456.789-09';
  AssertTrue(MsgErroCPF , fACBrValidador.Validar);
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertTrue(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.Invalido;
begin
  fACBrValidador.Documento := '12345678901';
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.NumerosSequenciais;
var
  I: Char;
begin
  For I := '1' to '9' do
  begin
    fACBrValidador.Documento := StringOfChar(I,11);
    AssertFalse( MsgErroCPF, fACBrValidador.Validar );
  end;
end;

procedure TTestCaseACBrValidadorCPF.MenorOnzeDigitos;
begin
  fACBrValidador.Documento := '123456789';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.MaiorOnzeDigitos;
begin
  fACBrValidador.Documento := '1234567890123';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.ComLetras;
begin
  fACBrValidador.Documento := '123456789AB';
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.Formatar;
begin
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertEquals('000.000.001-91', fACBrValidador.Formatar);
  fACBrValidador.Documento := '12345678909';
  AssertEquals('123.456.789-09', fACBrValidador.Formatar);
end;


{ TTestCaseACBrValidadorCNPJ }

function TTestCaseACBrValidadorCNPJ.MsgErroCNPJ: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TTestCaseACBrValidadorCNPJ.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docCNPJ;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TTestCaseACBrValidadorCNPJ.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TTestCaseACBrValidadorCNPJ.Valido;
begin
  fACBrValidador.Documento := '12345678000195';
  AssertTrue(MsgErroCNPJ, fACBrValidador.Validar);
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertTrue(MsgErroCNPJ , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.ValidoComSeparadores;
begin
  fACBrValidador.Documento := '12.345.678/0001-95';
  AssertTrue(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.Invalido;
begin
  fACBrValidador.Documento := '12345678901234';
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.NumeroComZeros;
begin
  fACBrValidador.Documento := StringOfChar('0',14);
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.MenorQuatorzeDigitos;
begin
  fACBrValidador.Documento := '1234567890';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.MaiorQuatorzeDigitos;
begin
  fACBrValidador.Documento := '123456789012345';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.ComLetras;
begin
  fACBrValidador.Documento := '1234567890ABCD';
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.Formatar;
begin
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertEquals('00.000.000/0001-91', fACBrValidador.Formatar);
  fACBrValidador.Documento := '12345678000195';
  AssertEquals('12.345.678/0001-95', fACBrValidador.Formatar);
end;

{ TTestCaseACBrValidadorUF }

procedure TTestCaseACBrValidadorUF.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docUF;
end;

procedure TTestCaseACBrValidadorUF.TearDown;
begin
  FreeAndNil(fACBrValidador);
end;

procedure TTestCaseACBrValidadorUF.Validos;
var
  SL: TStringList;
  I: Integer;
  aUF: String;
begin
  SL := TStringList.Create;
  try
    SL.Delimiter := ',';
    SL.DelimitedText := cUFsValidas;

    For I := 0 to SL.Count-1 do
    begin
      aUF := Trim(SL[I]);
      if aUF <> '' then
      begin
        fACBrValidador.Documento := aUF;
        AssertTrue(fACBrValidador.MsgErro, fACBrValidador.Validar);
      end;
    end;
  finally
    SL.Free;
  end;
end;

procedure TTestCaseACBrValidadorUF.Invalido;
begin
  fACBrValidador.Documento := '';
  AssertFalse(fACBrValidador.MsgErro, fACBrValidador.Validar);
  fACBrValidador.Documento := 'X';
  AssertFalse(fACBrValidador.MsgErro, fACBrValidador.Validar);
  fACBrValidador.Documento := 'XX';
  AssertFalse(fACBrValidador.MsgErro, fACBrValidador.Validar);
  fACBrValidador.Documento := 'XXX';
  AssertFalse(fACBrValidador.MsgErro, fACBrValidador.Validar);
end;

initialization

  RegisterTest(TTestCaseACBrValidadorCPF);
  RegisterTest(TTestCaseACBrValidadorCNPJ);
  RegisterTest(TTestCaseACBrValidadorUF);
  RegisterTest(TTestCaseACBrValidadorIE);
end.

