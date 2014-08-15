unit uPrincipalPet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,uPrincipalPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ActnList, Menus, dxBar, dxStatusBar, dxRibbonStatusBar,
  cxClasses, dxRibbon, uLebrete, dxDockControl, dxDockPanel, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinsdxBarPainter, dxSkinsdxDockControlPainter, cxSplitter, ExtCtrls;

type
  TfrmPrincipalPet = class(TfrmPrincipalPadrao)
    dxRibbon1Tab1: TdxRibbonTab;
    Ribbon: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxRibbon1Tab2: TdxRibbonTab;
    actCadCep: TAction;
    dxBarButton1: TdxBarButton;
    actCadEspecie: TAction;
    dxBarButton2: TdxBarButton;
    actCadTipoServico: TAction;
    dxBarButton3: TdxBarButton;
    actCadCategoriaAnimal: TAction;
    dxBarButton4: TdxBarButton;
    actCadFormaPagamento: TAction;
    dxBarButton5: TdxBarButton;
    actCadProfissional: TAction;
    dxBarButton6: TdxBarButton;
    actCadRaca: TAction;
    dxBarButton7: TdxBarButton;
    actCadEmpresa: TAction;
    dxBarButton8: TdxBarButton;
    actCadUsuario: TAction;
    dxBarButton9: TdxBarButton;
    actTabPreco: TAction;
    dxBarButton10: TdxBarButton;
    actCadCliente: TAction;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    actCadAnimal: TAction;
    dxBarButton13: TdxBarButton;
    actAgenda: TAction;
    dxBarManager1Bar3: TdxBar;
    dxRibbon1Tab3: TdxRibbonTab;
    dxBarButton14: TdxBarButton;
    actVenda: TAction;
    dxBarButton15: TdxBarButton;
    actServListagemServico: TAction;
    dxBarButton16: TdxBarButton;
    dxBarButton17: TdxBarButton;
    actCaixa: TAction;
    dxBarButton18: TdxBarButton;
    dxBarButton19: TdxBarButton;
    dxBarButton20: TdxBarButton;
    dxBarButton21: TdxBarButton;
    dxBarButton22: TdxBarButton;
    dxBarButton23: TdxBarButton;
    dxBarButton24: TdxBarButton;
    actCadGrupo: TAction;
    dxBarButton25: TdxBarButton;
    actFinContasReceber: TAction;
    actFinContasRecebidas: TAction;
    dxBarButton26: TdxBarButton;
    dxBarButton27: TdxBarButton;
    dxBarButton28: TdxBarButton;
    dxBarButton29: TdxBarButton;
    Panel1: TPanel;
    cxSplitter1: TcxSplitter;
    fraLebrete1: TfraLebrete;
    actFinFechamento: TAction;
    dxBarButton30: TdxBarButton;
    dxBarButton31: TdxBarButton;
    procedure actCadCepExecute(Sender: TObject);
    procedure actCadEspecieExecute(Sender: TObject);
    procedure actCadTipoServicoExecute(Sender: TObject);
    procedure actCadCategoriaAnimalExecute(Sender: TObject);
    procedure actCadFormaPagamentoExecute(Sender: TObject);
    procedure actCadProfissionalExecute(Sender: TObject);
    procedure actCadRacaExecute(Sender: TObject);
    procedure actCadEmpresaExecute(Sender: TObject);
    procedure actCadUsuarioExecute(Sender: TObject);
    procedure actTabPrecoExecute(Sender: TObject);
    procedure actCadClienteExecute(Sender: TObject);
    procedure actCadAnimalExecute(Sender: TObject);
    procedure actAgendaExecute(Sender: TObject);
    procedure actVendaExecute(Sender: TObject);
    procedure actServListagemServicoExecute(Sender: TObject);
    procedure actCaixaExecute(Sender: TObject);
    procedure actCadGrupoExecute(Sender: TObject);
    procedure actFinContasReceberExecute(Sender: TObject);
    procedure actFinContasRecebidasExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFinFechamentoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipalPet: TfrmPrincipalPet;

implementation

uses Cad_CEP, uLibPet, uTabelaPreco, uAgenda, uLst_ContasReceber,
  uLstFechamentoDia;

{$R *.dfm}

procedure TfrmPrincipalPet.actAgendaExecute(Sender: TObject);
begin
  inherited;
  frmAgenda := TfrmAgenda.Create(Self);
  Try
    frmAgenda.ShowModal;
  Finally
    FreeAndNil(frmAgenda);
  End;
end;

procedure TfrmPrincipalPet.actCadAnimalExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroAnimal;
end;

procedure TfrmPrincipalPet.actCadGrupoExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroGrupo;
end;

procedure TfrmPrincipalPet.actCadCategoriaAnimalExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroCategoriaAnimal;
end;

procedure TfrmPrincipalPet.actCadCepExecute(Sender: TObject);
begin
  inherited;
  frmCad_CEP := TfrmCad_CEP.Create(Self);
  Try
    frmCad_CEP.ShowModal;
  Finally
    FreeAndNil(frmCad_CEP);
  End;
end;

procedure TfrmPrincipalPet.actCadClienteExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroCliente;
end;

procedure TfrmPrincipalPet.actCadEmpresaExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroEmpresa;
end;

procedure TfrmPrincipalPet.actCadEspecieExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroEspecie;
end;

procedure TfrmPrincipalPet.actCadFormaPagamentoExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroFormaPagamento;
end;

procedure TfrmPrincipalPet.actCadProfissionalExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroProfissional;
end;

procedure TfrmPrincipalPet.actCadRacaExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroRaca;
end;

procedure TfrmPrincipalPet.actCadTipoServicoExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroTipoServico;
end;

procedure TfrmPrincipalPet.actCadUsuarioExecute(Sender: TObject);
begin
  inherited;
  AbreCadastroUSuario;
end;

procedure TfrmPrincipalPet.actCaixaExecute(Sender: TObject);
begin
  inherited;
  ABreCaixa;
end;

procedure TfrmPrincipalPet.actFinContasReceberExecute(Sender: TObject);
begin
  inherited;
  if frmLstContasReceber = nil Then
  Begin
    frmLstContasReceber := TfrmLstContasReceber.Create(Self);
    frmLstContasReceber.TipoForm := tfReceber;
  End;
  if frmLstContasReceber.Showing then
    frmLstContasReceber.BringToFront
  else
    frmLstContasReceber.Show;
end;

procedure TfrmPrincipalPet.actFinContasRecebidasExecute(Sender: TObject);
begin
  inherited;
  if frmLstContasRecebidas = nil Then
  Begin
    frmLstContasRecebidas := TfrmLstContasReceber.Create(Self);
    frmLstContasRecebidas.TipoForm := tfRecebida;
  End;
  if frmLstContasRecebidas.Showing then
    frmLstContasRecebidas.BringToFront
  else
    frmLstContasRecebidas.Show;
end;

procedure TfrmPrincipalPet.actFinFechamentoExecute(Sender: TObject);
begin
  inherited;
  frmLst_FechamentoDia := TfrmLst_FechamentoDia.Create(nil);
  Try
    frmLst_FechamentoDia.ShowModal;
  Finally
    FreeAndNil(frmLst_FechamentoDia);
  End;
end;

procedure TfrmPrincipalPet.actServListagemServicoExecute(Sender: TObject);
begin
  inherited;
  AbreLstServico;
end;

procedure TfrmPrincipalPet.actTabPrecoExecute(Sender: TObject);
begin
  inherited;
  frmTabelaPreco := TfrmTabelaPreco.Create(nil);
  Try
    frmTabelaPreco.ShowModal;
  Finally
    FreeAndNil(frmTabelaPreco);
  End;
end;

procedure TfrmPrincipalPet.actVendaExecute(Sender: TObject);
begin
  inherited;
  ABreVenda;
end;

procedure TfrmPrincipalPet.FormCreate(Sender: TObject);
begin
  inherited;
  Ribbon.ActiveTab := dxRibbon1Tab1;
end;

procedure TfrmPrincipalPet.FormShow(Sender: TObject);
begin
  inherited;
  fraLebrete1.Atualiza;
end;

end.
