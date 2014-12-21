unit udlg_ItensProposta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAddItemPadrao, StdCtrls, Buttons, ExtCtrls, Mask, EditPesquisa,
  DBCtrls, LabelDBEdit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMemo, cxDBEdit,DB, uDlg_CadastroERP,ulibERP,uClassesERP;

type
  TFinalidadeProposta = (tfContrato,tfOS,tfVenda);
  TfrmDlg_ItensProposta = class(TfrmAddItemPadrao)
    edtEquipamentoCliente: TEditPesquisa;
    procedure FormShow(Sender: TObject);
    procedure edtEquipamentoClienteBtnNovoClick(Sender: TObject);
    procedure edtEquipamentoClienteBtnEditarClick(Sender: TObject);
  private
    FIdEmpresa: Integer;
    FCdsProposta: TDataSet;
    FFinalidadeProposta: TFinalidadeProposta;
    FIdCliente: TipoCampoChave;
    procedure SetFinalidadeProposta(const Value: TFinalidadeProposta);
    procedure SetIdCliente(const Value: TipoCampoChave);
    { Private declarations }
  public
    { Public declarations }
     property FinalidadeProposta: TFinalidadeProposta read FFinalidadeProposta write SetFinalidadeProposta;
     property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;
  end;

var
  frmDlg_ItensProposta: TfrmDlg_ItensProposta;

implementation

uses uCad_proposta, Comandos, MinhasClasses, uRegras, uConstantes, uForms;

{$R *.dfm}


{ TfrmDlg_ItensProposta }

procedure TfrmDlg_ItensProposta.edtEquipamentoClienteBtnEditarClick(
  Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.ValorChave := TrotinasForms.AbreManutencaoEquipamentoCliente(IdCliente,toEditar);
  edtEquipamentoCliente.Localiza;
end;

procedure TfrmDlg_ItensProposta.edtEquipamentoClienteBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.ValorChave := TrotinasForms.AbreManutencaoEquipamentoCliente(IdCliente,toIncluir);
  edtEquipamentoCliente.Localiza;
end;


procedure TfrmDlg_ItensProposta.FormShow(Sender: TObject);
begin
  inherited;
  if  self.FinalidadeProposta in [tfContrato,tfOS] then
    edtProduto.SQLComp := 'TIPOPRODUTO = '+QuotedStr(TipoProdutoServico);

  edtEquipamentoCliente.SQLComp := 'idcliente = '+TipoCampoChaveToStr(IdCliente);
  ConfiguraEditPesquisa(edtEquipamentoCliente,pDataSet,tpERPClienteEquipamento);

end;

procedure TfrmDlg_ItensProposta.SetFinalidadeProposta(
  const Value: TFinalidadeProposta);
begin
  FFinalidadeProposta := Value;
  edtEquipamentoCliente.Enabled := Value in [tfContrato,tfOS];
  edtEquipamentoCliente.Obrigatorio := Value in [tfContrato];


end;


procedure TfrmDlg_ItensProposta.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

end.
