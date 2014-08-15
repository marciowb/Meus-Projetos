program EXEMPLO;

{%TogetherDiagram 'ModelSupport_EXEMPLO\default.txaPackage'}

uses
  Forms,
  Recursos in 'Recursos.pas' {DFM_Recursos},
  Boletos in 'Boletos.pas' {DFM_Boletos},
  Etiquetas in 'Etiquetas.pas' {DFM_Etiquetas},
  ClientesSimples in 'ClientesSimples.pas' {DFM_ClientesSimples},
  ClientesQuebra in 'ClientesQuebra.pas' {DFM_ClientesQuebra},
  CupomNaoFiscal in 'CupomNaoFiscal.pas' {DFM_CupomNaoFiscal},
  Menu in 'Menu.pas' {DFM_Menu},
  Daruma in 'Daruma.pas' {DFM_DARUMA},
  NotaFiscal in 'NotaFiscal.pas' {DFM_NotaFiscal},
  Regua in 'Regua.pas' {DFM_Regua};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'RDprint 4 - Demonstração';
  Application.CreateForm(TDFM_Menu, DFM_Menu);
  Application.CreateForm(TDFM_Recursos, DFM_Recursos);
  Application.CreateForm(TDFM_CupomNaoFiscal, DFM_CupomNaoFiscal);
  Application.CreateForm(TDFM_ClientesQuebra, DFM_ClientesQuebra);
  Application.CreateForm(TDFM_ClientesSimples, DFM_ClientesSimples);
  Application.CreateForm(TDFM_Etiquetas, DFM_Etiquetas);
  Application.CreateForm(TDFM_Boletos, DFM_Boletos);
  Application.CreateForm(TDFM_DARUMA, DFM_DARUMA);
  Application.CreateForm(TDFM_NotaFiscal, DFM_NotaFiscal);
  Application.CreateForm(TDFM_Regua, DFM_Regua);
  Application.Run;
end.
