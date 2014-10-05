unit uDlg_SaidaItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAddItemPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, DB, cxTextEdit,
  cxMemo, cxDBEdit, StdCtrls, DBCtrls, LabelDBEdit, Mask, EditPesquisa, Buttons,
  ExtCtrls, DBClient, pFIBClientDataSet;

type
  TfrmDlg_SaidaItem = class(TfrmAddItemPadrao)
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit17: TLabelDBEdit;
    LabelDBEdit19: TLabelDBEdit;
    LabelDBEdit20: TLabelDBEdit;
    LabelDBEdit21: TLabelDBEdit;
    LabelDBEdit22: TLabelDBEdit;
    LabelDBEdit25: TLabelDBEdit;
    LabelDBEdit24: TLabelDBEdit;
    LabelDBEdit23: TLabelDBEdit;
    LabelDBEdit28: TLabelDBEdit;
    LabelDBEdit27: TLabelDBEdit;
    LabelDBEdit26: TLabelDBEdit;
    LabelDBEdit29: TLabelDBEdit;
    LabelDBEdit30: TLabelDBEdit;
    LabelDBEdit31: TLabelDBEdit;
    LabelDBEdit32: TLabelDBEdit;
    LabelDBEdit33: TLabelDBEdit;
    LabelDBEdit34: TLabelDBEdit;
    edtAlmoxarifado: TEditPesquisa;
    btnSeriais: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnSeriaisClick(Sender: TObject);
    procedure edtProdutoRegAchado(const ValoresCamposEstra: array of Variant);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure edtPatrimonioRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    UsaSerial: Boolean;
    FDataSetSeriais: TpFIBClientDataSet;
    procedure SetDataSetSeriais(const Value: TpFIBClientDataSet);
    { Private declarations }
  public
    { Public declarations }
    property DataSetSeriais: TpFIBClientDataSet read FDataSetSeriais write SetDataSetSeriais;
  end;

var
  frmDlg_SaidaItem: TfrmDlg_SaidaItem;

implementation

uses Comandos, MinhasClasses, udlg_SaidaSerial;

{$R *.dfm}

procedure TfrmDlg_SaidaItem.btnSeriaisClick(Sender: TObject);
var
  I: Integer;
begin
   Try
        frmDlg_SaidaSerial := TfrmDlg_SaidaSerial.Create(nil);
        frmDlg_SaidaSerial.IdProduto := pDataSet.FieldByName('IDPRODUTO').Value;
        if frmDlg_SaidaSerial.CdsSeriais.IsEmpty then
          Exit;
        Self.FDataSetSeriais.First;
        while not Self.FDataSetSeriais.Eof do
        begin
          if frmDlg_SaidaSerial.CdsSeriais.Locate('serial',Self.FDataSetSeriais.FieldByName('serial').AsString,[]) Then
          Begin
            frmDlg_SaidaSerial.CdsSeriais.Edit;
            frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').AsString := 'U';
            frmDlg_SaidaSerial.CdsSeriais.Post;
          end;
          Self.FDataSetSeriais.Next;
        end;
        if frmDlg_SaidaSerial.ShowModal = mrOK Then
        begin
          frmDlg_SaidaSerial.CdsSeriais.First;
          I:= 0;
          while not frmDlg_SaidaSerial.CdsSeriais.Eof do
          begin
            if  frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').Value = 'N' then
            begin
               frmDlg_SaidaSerial.CdsSeriais.Next;
               Continue;
            end;
            if Self.FDataSetSeriais.Locate('IDSAIDAPRODUTO;Serial',
                       VarArrayOf([pDataSet.FieldByName('IDSAIDAPRODUTO').Value,
                                   frmDlg_SaidaSerial.CdsSeriais.FieldByName('serial').AsString]),[]) then
              Self.FDataSetSeriais.Edit
            else
            begin
              Self.FDataSetSeriais.Append;
              Self.FDataSetSeriais.FieldByName('IDSAIDASERIALPRODUTO').Value := GetCodigo(tpERPSaidaSerialProduto);
            end;
            Self.FDataSetSeriais.FieldByName('SERIAL').Value :=  frmDlg_SaidaSerial.CdsSeriais.FieldByName('SERIAL').Value;
            Self.FDataSetSeriais.FieldByName('IDSERIALPRODUTO').Value :=  frmDlg_SaidaSerial.CdsSeriais.FieldByName('IDSERIALPRODUTO').Value;
            Self.FDataSetSeriais.FieldByName('FLAGEDICAO').Value :=  frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').Value;
            Self.FDataSetSeriais.FieldByName('IDSAIDAPRODUTO').Value := pDataSet.FieldByName('IDSAIDAPRODUTO').AsString;

            Self.FDataSetSeriais.Post;
            if  frmDlg_SaidaSerial.CdsSeriais.FieldByName('FLAGEDICAO').Value = 'U' then
              Inc(I);
            frmDlg_SaidaSerial.CdsSeriais.Next;
          end;
          pDataSet.FieldByName('quantidade').Value := I;

        end;
      Finally
        FreeAndNil(frmDlg_SaidaSerial);
      End;


end;

procedure TfrmDlg_SaidaItem.edtPatrimonioRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
 //
end;

procedure TfrmDlg_SaidaItem.edtProdutoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  UsaSerial:= ValoresCamposEstra[10] = 'Y' ;

end;

procedure TfrmDlg_SaidaItem.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  if UsaSerial then
    btnSeriaisClick(nil);
end;

procedure TfrmDlg_SaidaItem.FormShow(Sender: TObject);
begin
    edtProduto.CamposExtraPesquisa := 'IDUNIDADE,IDNCM,IDCODIGOMUNICIPALSERVICO,'+
                          'CST,CSOSN,CUSTOMEDIO,CUSTOATUAL,CUSTOCONTABIL,CODIGOBARRAS,MARKUP,FLAGSERIAL';
  inherited;
  edtProduto.UsaBtnNovo := false;
  edtProduto.UsaBtnEditar := false;
  ConfiguraEditPesquisa(EdtAlmoxarifado,pDataSet,tpERPAlmoxarifado);

end;

procedure TfrmDlg_SaidaItem.SetDataSetSeriais(const Value: TpFIBClientDataSet);
begin
  FDataSetSeriais := Value;
end;

end.
