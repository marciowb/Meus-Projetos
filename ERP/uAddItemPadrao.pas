unit uAddItemPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDlg_CadastroERP, StdCtrls, Buttons, ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxTextEdit, cxMemo, cxDBEdit, DBCtrls, LabelDBEdit, Mask,
  EditPesquisa,DB, uLibERP;

type
  TfrmAddItemPadrao = class(TfrmDlg_CadastroERP)
    Panel3: TPanel;
    edtProduto: TEditPesquisa;
    edtQuantidade: TLabelDBEdit;
    edtValUni: TLabelDBEdit;
    edtPercDesc: TLabelDBEdit;
    edtPercAcrescimo: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    edtValorAcrescimo: TLabelDBEdit;
    edtValorDesc: TLabelDBEdit;
    LabelDBEdit9: TLabelDBEdit;
    GroupBox1: TGroupBox;
    cxDBMemo1: TcxDBMemo;
    DataItens: TDataSource;
    edtPatrimonio: TEditPesquisa;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtPercAcrescimoExit(Sender: TObject);
    procedure edtPercDescExit(Sender: TObject);
    procedure edtValorAcrescimoExit(Sender: TObject);
    procedure edtValorDescExit(Sender: TObject);
    procedure edtValUniExit(Sender: TObject);
    procedure edtProdutoRegAchado(const ValoresCamposEstra: array of Variant);
    procedure edtPatrimonioRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure FormCreate(Sender: TObject);
  private
    FIdEmpresa: TipoCampoChave;
    FIdCliente: TipoCampoChave;
    FData: TDateTime;
    FTipoMovimento: TTipoMovimento;
    { Private declarations }
    procedure SetData(const Value: TDateTime);
    procedure SetIdCliente(const Value: TipoCampoChave);
    procedure SetIdEmpresa(const Value: TipoCampoChave);
    procedure SetTipoMovimento(const Value: TTipoMovimento);
  published
    { Public declarations }
    Procedure CalculaTotal;virtual;
    property IdCliente:TipoCampoChave read FIdCliente write SetIdCliente;
    property IdEmpresa: TipoCampoChave read FIdEmpresa write SetIdEmpresa;
    Property Data: TDateTime read FData write SetData;
    property TipoMovimento : TTipoMovimento read FTipoMovimento write SetTipoMovimento;
  end;

var
  frmAddItemPadrao: TfrmAddItemPadrao;

implementation

uses Comandos, MinhasClasses, uRegras;

{$R *.dfm}

procedure TfrmAddItemPadrao.btnOkClick(Sender: TObject);
begin
  if TipoMovimento = tmProduto then
    VerificaEdit(edtProduto,'O produto/serviço deve ser informado')
  else
    VerificaEdit(edtPatrimonio,'O patrimônio deve ser informado');

  VerificaEdit(pDataSet,edtQuantidade,'','A quantidade deve ser informada');
  VerificaEdit(pDataSet,edtValUni,'','O valor deve ser informado');
  inherited;
  if TipoMovimento = tmProduto then
    edtProduto.SetFocus;
  if TipoMovimento = tmPatrimonio then
    edtPatrimonio.SetFocus;

end;

procedure TfrmAddItemPadrao.CalculaTotal;
begin
  pDataSet.FieldByName('VALORTOTAL').AsCurrency :=
          (pDataSet.FieldByName('SUBTOTAL').AsCurrency - pDataSet.FieldByName('VALORDESCONTO').AsCurrency)+
             pDataSet.FieldByName('VALORACRESCIMO').AsCurrency;
end;

procedure TfrmAddItemPadrao.edtPatrimonioRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if not (pDataSet.State in [dsEdit, dsInsert]) then
    Exit;
  pDataSet.FieldByName('CODIGO').AsString := edtPatrimonio.Text;
  pDataSet.FieldByName('NOMEPRODUTO').AsString := edtPatrimonio.Display.Text;

  if pDataSet.FindField('CONTADORPATRIMONIO') <> nil then
  begin
    pDataSet.FieldByName('CONTADORPATRIMONIO').Value := ValoresCamposEstra[0] ;
    edtQuantidade.Text := ValoresCamposEstra[0] ;
  end;

  if ((pDataSet.FieldByName('VALORUNITARIO').IsNull) or
      (pDataSet.FieldByName('VALORUNITARIO').OldValue <> pDataSet.FieldByName('VALORUNITARIO').Value))   then
     pDataSet.FieldByName('VALORUNITARIO').AsCurrency := ValoresCamposEstra[1] ;


end;

procedure TfrmAddItemPadrao.edtPercAcrescimoExit(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('VALORACRESCIMO').AsCurrency := pDataSet.FieldByName('SUBTOTAL').AsCurrency * pDataSet.FieldByName('ALIQACRESCIMO').AsCurrency/100;
  CalculaTotal;
end;

procedure TfrmAddItemPadrao.edtPercDescExit(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('VALORDESCONTO').AsCurrency := pDataSet.FieldByName('SUBTOTAL').AsCurrency * pDataSet.FieldByName('ALIQDESCONTO').AsCurrency/100;
  CalculaTotal;
end;

procedure TfrmAddItemPadrao.edtProdutoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if (pDataSet.State in [dsInsert,dsEdit]) and
     ((pDataSet.FieldByName('VALORUNITARIO').IsNull) or
      (pDataSet.FieldByName('VALORUNITARIO').OldValue <> pDataSet.FieldByName('VALORUNITARIO').Value))   then
  begin
     pDataSet.FieldByName('VALORUNITARIO').AsCurrency := TRegrasVendaProduto.PrecoVendaProduto(edtProduto.ValorChave,
                                                                   IdCliente,IdEmpresa,Data);
     pDataSet.FieldByName('CODIGO').AsString := edtProduto.Text;
     pDataSet.FieldByName('NOMEPRODUTO').AsString := edtProduto.Display.Text;
  end;

end;

procedure TfrmAddItemPadrao.edtValorAcrescimoExit(Sender: TObject);
begin
  inherited;
  if pDataSet.FieldByName('VALORACRESCIMO').AsCurrency > 0  then
  begin
    pDataSet.FieldByName('ALIQACRESCIMO').AsCurrency := (pDataSet.FieldByName('VALORACRESCIMO').AsCurrency/pDataSet.FieldByName('SUBTOTAL').AsCurrency) * 100;

  end;
  CalculaTotal;
end;

procedure TfrmAddItemPadrao.edtValorDescExit(Sender: TObject);
begin
  inherited;
  if pDataSet.FieldByName('VALORDESCONTO').AsCurrency > 0  then
  begin
    pDataSet.FieldByName('ALIQDESCONTO').AsCurrency := (pDataSet.FieldByName('VALORDESCONTO').AsCurrency/pDataSet.FieldByName('SUBTOTAL').AsCurrency) * 100;

  end;
  CalculaTotal;
end;

procedure TfrmAddItemPadrao.edtValUniExit(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('SUBTOTAL').AsCurrency := pDataSet.FieldByName('QUANTIDADE').AsCurrency *
                                                   pDataSet.FieldByName('VALORUNITARIO').AsCurrency;

    CalculaTotal;
end;

procedure TfrmAddItemPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  TipoMovimento := tmProduto;
end;

procedure TfrmAddItemPadrao.FormShow(Sender: TObject);
begin
  inherited;
  if TipoMovimento =tmProduto then
  begin
    ConfiguraEditPesquisa(edtProduto,pDataSet, tperpProduto,True);
    edtProduto.SetFocus;
  end;
  if TipoMovimento =tmPatrimonio then
  begin
    edtPatrimonio.CamposExtraPesquisa := 'CONTADOR,PRECOSAIDA';
    ConfiguraEditPesquisa(edtPatrimonio,pDataSet, tpERPPatrimonioDisponivel,True);
    edtPatrimonio.SetFocus;
  end;

  DataItens.DataSet:= pDataSet;
end;

procedure TfrmAddItemPadrao.SetData(const Value: TDateTime);
begin
  FData := Value;
end;

procedure TfrmAddItemPadrao.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

procedure TfrmAddItemPadrao.SetIdEmpresa(const Value: TipoCampoChave);
begin
  FIdEmpresa := Value;
end;

procedure TfrmAddItemPadrao.SetTipoMovimento(const Value: TTipoMovimento);
begin
  FTipoMovimento := Value;
  edtProduto.Visible := FTipoMovimento = tmProduto;
  edtPatrimonio.Visible := FTipoMovimento = tmPatrimonio;

  case Value of
    tmProduto:
    begin
      edtQuantidade.DataField := 'QUANTIDADE';
      edtQuantidade.Titulo.Caption:= 'Quantidade';
    end;
    tmPatrimonio:
    begin
      pDataSet.FieldByName('QUANTIDADE').Value := 1;
      edtQuantidade.DataField := 'CONTADORPATRIMONIO';
      edtQuantidade.Titulo.Caption:= 'Contador';
    end;

  end;

end;

end.
