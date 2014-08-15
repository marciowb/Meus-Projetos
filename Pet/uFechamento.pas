unit uFechamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, DB, Grids, DBGrids,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxCurrencyEdit, DBClient, pFIBClientDataSet,uFormPadrao,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue;

type
  TfrmFechamento = class(TfrmPadrao)
    DataFP: TDataSource;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtValDesc: TcxCurrencyEdit;
    edtValAcres: TcxCurrencyEdit;
    lblRecebido: TLabel;
    lblCapTotalRecebido: TLabel;
    lblTotal: TLabel;
    Label5: TLabel;
    CdsPagamentos: TpFIBClientDataSet;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    Panel4: TPanel;
    GridFP: TDBGrid;
    procedure CdsPagamentosAfterOpen(DataSet: TDataSet);
    procedure CdsPagamentosBeforePost(DataSet: TDataSet);
    procedure CdsPagamentosAfterPost(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtValDescExit(Sender: TObject);
    procedure edtValAcresExit(Sender: TObject);
    procedure GridFPColEnter(Sender: TObject);
    procedure GridFPColExit(Sender: TObject);
    procedure CdsPagamentosNewRecord(DataSet: TDataSet);
    procedure GridFPEnter(Sender: TObject);
    procedure GridFPExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridFPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FTotalVenda: Currency;
    FIdServico: Integer;
    procedure SetTotalVenda(const Value: Currency);
    { Private declarations }
  public
    { Public declarations }
    Property TotalVenda: Currency read FTotalVenda write SetTotalVenda;
    property IdServico: Integer read FIdServico write FIdServico;
    Procedure CalculaTotal;
  end;

var
  frmFechamento: TfrmFechamento;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmFechamento.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmFechamento.btnOkClick(Sender: TObject);
begin
  inherited;
  //

  ModalResult := mrOk;
end;

procedure TfrmFechamento.CalculaTotal;
var
  CdsClone: TpFIBClientDataSet;
  Tot,Res: Currency;
begin
  Try
    CdsClone := TpFIBClientDataSet.Create(nil);
    CdsClone.CloneCursor(CdsPagamentos,True);
    CdsClone.First;
    Tot := 0;
    btnOk.Enabled := False;
    while not CdsClone.Eof do
    Begin
      Tot := Tot + CdsClone.FieldByName('VALOR').AsCurrency;
      CdsClone.Next;
    End;
    Res := (TotalVenda - Tot)+edtValAcres.Value - edtValDesc.Value;
    if TotalVenda > Tot then
      lblCapTotalRecebido.Caption := 'Falta receber: '
    else
    if Res < 0 then
      lblCapTotalRecebido.Caption := 'Troco: '
    else
    if TotalVenda = Tot then
      lblCapTotalRecebido.Caption := 'Total recebido: ';

    if Res <= 0 then
      btnOk.Enabled := True;


    lblRecebido.Caption := FormatFloat(MascaraMoeda,Res);
  Finally
    FreeAndNil(CdsClone);
  End;
end;

procedure TfrmFechamento.CdsPagamentosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsPagamentos.FieldByName('NOMEFORMAPAGAMENTO').ProviderFlags := [];
  CdsPagamentos.FieldByName('TIPOFORMAPAGAMENTO').ProviderFlags := [];

end;

procedure TfrmFechamento.CdsPagamentosAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalculaTotal;
end;

procedure TfrmFechamento.CdsPagamentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsPagamentos.FieldByName('IDSERVICOFORMAPAGAMENTO').IsNull then
  Begin
    CdsPagamentos.FieldByName('IDSERVICOFORMAPAGAMENTO').AsString := GetCodigo(tpPetServicoPagamentos);
    CdsPagamentos.FieldByName('IDSERVICO').AsInteger := IdServico;
  End;

end;

procedure TfrmFechamento.CdsPagamentosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsPagamentos.Cancel;
  Abort;
end;

procedure TfrmFechamento.GridFPColEnter(Sender: TObject);
begin
  inherited;
  if GridFP.SelectedField.FieldName <> 'VALOR' then
    GridFP.SelectedIndex := 1;
end;

procedure TfrmFechamento.GridFPColExit(Sender: TObject);
begin
  inherited;
  if CdsPagamentos.State in [dsInsert, dsEdit] then
    CdsPagamentos.Post;
end;

procedure TfrmFechamento.GridFPEnter(Sender: TObject);
begin
  inherited;
  if GridFP.SelectedField.FieldName <> 'VALOR' then
    GridFP.SelectedIndex := 1;
end;

procedure TfrmFechamento.GridFPExit(Sender: TObject);
begin
  inherited;
  if CdsPagamentos.State in [dsInsert, dsEdit] then
    CdsPagamentos.Post;
end;

procedure TfrmFechamento.GridFPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
  Begin
    if not (CdsPagamentos.State in [dsInsert, dsEdit]) then
      CdsPagamentos.Edit;
    CdsPagamentos.FieldByName('VALOR').Clear;
  End;
end;

procedure TfrmFechamento.edtValAcresExit(Sender: TObject);
begin
  inherited;
  CalculaTotal;
end;

procedure TfrmFechamento.edtValDescExit(Sender: TObject);
begin
  inherited;
  CalculaTotal;
end;

procedure TfrmFechamento.FormCreate(Sender: TObject);
begin
  inherited;
  SetCds(CdsPagamentos,tpPetServicoPagamentos,'IDSERVICO = -1');
end;

procedure TfrmFechamento.SetTotalVenda(const Value: Currency);
begin
  FTotalVenda := Value;
  lblTotal.Caption := FormatFloat(MascaraMoeda, Value);
end;

end.
