unit uDlg_ServicoContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDlg_CadastroERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMemo, cxDBEdit, StdCtrls, DBCtrls, LabelDBEdit, Mask, EditPesquisa, Buttons,
  ExtCtrls,uAddItemPadrao, DB;

type
  TfrmDlg_ServicoContrato = class(TfrmAddItemPadrao)
    edtEquipamentoCliente: TEditPesquisa;
    procedure FormCreate(Sender: TObject);
    procedure edtEquipamentoClienteBtnEditarClick(Sender: TObject);
    procedure edtEquipamentoClienteBtnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtEquipamentoClienteRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDlg_ServicoContrato: TfrmDlg_ServicoContrato;

implementation

uses uForms, MinhasClasses, Comandos, uLibERP;

{$R *.dfm}

procedure TfrmDlg_ServicoContrato.btnOkClick(Sender: TObject);
begin
  if ExisteRegistro(pDataSet,'IDPRODUTO;IDEQUIPAMENTOCLIENTE',False,True) Then
  begin
    Avisa('Já existe o serviço '+edtProduto.Display.Text+' para esse equipamento.' );
    Exit;
  end;

  inherited;

end;

procedure TfrmDlg_ServicoContrato.edtEquipamentoClienteBtnEditarClick(
  Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.ValorChave := TrotinasForms.AbreManutencaoEquipamentoCliente(IdCliente,toEditar);
  edtEquipamentoCliente.Localiza;
end;

procedure TfrmDlg_ServicoContrato.edtEquipamentoClienteBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.ValorChave := TrotinasForms.AbreManutencaoEquipamentoCliente(IdCliente,toIncluir);
  edtEquipamentoCliente.Localiza;
end;

procedure TfrmDlg_ServicoContrato.edtEquipamentoClienteRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if pDataSet.State in [dsInsert,dsEdit] then
  begin
    pDataSet.FieldByName('identificador').AsString := edtEquipamentoCliente.Text;
  end;
end;

procedure TfrmDlg_ServicoContrato.FormCreate(Sender: TObject);
begin
  inherited;
  edtProduto.SQLComp := 'TIPOPRODUTO = ''S'' ';

end;

procedure TfrmDlg_ServicoContrato.FormShow(Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.SQLComp := 'idcliente = '+TipoCampoChaveToStr(IdCliente);
  ConfiguraEditPesquisa(edtEquipamentoCliente,pDataSet,tpERPClienteEquipamento,false,'','','codigo','IDEQUIPAMENTOCLIENTE');

end;

end.
