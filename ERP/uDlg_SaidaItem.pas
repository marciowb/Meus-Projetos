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
  ExtCtrls, DBClient, pFIBClientDataSet, uLibERP,uClassesERP;

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
    edtCFOP: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    LabelDBEdit10: TLabelDBEdit;
    edtCST: TEditPesquisa;
    edtCSOSN: TEditPesquisa;
    procedure FormShow(Sender: TObject);
    procedure btnSeriaisClick(Sender: TObject);
    procedure edtProdutoRegAchado(const ValoresCamposEstra: array of Variant);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure edtPatrimonioRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    UsaSerial: Boolean;
    FDataSetSeriais: TpFIBClientDataSet;
    FIdCLiente: TipoCampoChave;
    FIdEmpresa: TipoCampoChave;
    procedure SetDataSetSeriais(const Value: TpFIBClientDataSet);
    Procedure CalculaTotal;override;
    procedure SetIdCLiente(const Value: TipoCampoChave);
    procedure SetIdEmpresa(const Value: TipoCampoChave);
    { Private declarations }
  public
    { Public declarations }
    property DataSetSeriais: TpFIBClientDataSet read FDataSetSeriais write SetDataSetSeriais;
    property IdCLiente: TipoCampoChave read FIdCLiente write SetIdCLiente;
    property IdEmpresa: TipoCampoChave  read FIdEmpresa write SetIdEmpresa;
  end;

var
  frmDlg_SaidaItem: TfrmDlg_SaidaItem;

implementation

uses Comandos, MinhasClasses, udlg_SaidaSerial, uRegras;

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

procedure TfrmDlg_SaidaItem.CalculaTotal;
begin
  inherited;
  with TRegrasImpostos.CalculaImpostos(IdCLiente,pDataSet.FieldByName('idproduto').AsString,
                                  pDataSet.FieldByName('idcfop').AsString,IdEmpresa,
                                  pDataSet.FieldByName('cst').AsString,
                                  pDataSet.FieldByName('csosn').AsString,
                                  pDataSet.FieldByName('valortotal').AsCurrency,
                                  pDataSet.FieldByName('VALORFRETERATEADO').AsCurrency,
                                  pDataSet.FieldByName('VALORSEGURORATEADO').AsCurrency,
                                  pDataSet.FieldByName('VALOROUTRASDESPESASRATEADO').AsCurrency ) do
   begin
     pDataSet.FieldByName('BASEICMS').AsCurrency := BaseICMS;
     pDataSet.FieldByName('ALIQICMS').AsCurrency := AliqICMS;
     pDataSet.FieldByName('VALORICMS').AsCurrency := ValorICMS;
     pDataSet.FieldByName('BASEIPI').AsCurrency := BaseIPI;
     pDataSet.FieldByName('ALIQIPI').AsCurrency := AliqIPI;
     pDataSet.FieldByName('VALORIPI').AsCurrency := ValorIPI;
     pDataSet.FieldByName('BASEICMSST').AsCurrency := BaseICMSST;
     pDataSet.FieldByName('ALIQST').AsCurrency := AliqICMSST;
     pDataSet.FieldByName('MVA').AsCurrency := MVA;
     pDataSet.FieldByName('VALORST').AsCurrency := ValorICMSST;
     pDataSet.FieldByName('BASEPISCOFINS').AsCurrency := BasePIS_COFINS;
     pDataSet.FieldByName('ALIQPIS').AsCurrency := AliqPIS;
     pDataSet.FieldByName('ALIQCOFINS').AsCurrency := AliqCOFINS;
     pDataSet.FieldByName('VALORPIS').AsCurrency := ValorPIS;
     pDataSet.FieldByName('VALORCOFINS').AsCurrency := ValorCOFINS;
     pDataSet.FieldByName('BASEISS').AsCurrency := BaseISS;
     pDataSet.FieldByName('ALIQISS').AsCurrency := AliqISS;
     pDataSet.FieldByName('VALORISS').AsCurrency := ValorISS;
     pDataSet.FieldByName('BASECSLL').AsCurrency := BaseCSLL;
     pDataSet.FieldByName('ALIQCSLL').AsCurrency := ALiqCSLL;
     pDataSet.FieldByName('VALORCSLL').AsCurrency := ValorCSLL;
     pDataSet.FieldByName('BaseIRRF').AsCurrency := BaseIR;
     pDataSet.FieldByName('ALIQIRRF').AsCurrency := ALiqIR;
     pDataSet.FieldByName('ValorIRRF').AsCurrency := ValorIR;
   end;


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
  if pDataSet.State in [dsEdit,dsInsert] then
  begin
    pDataSet.FieldByName('IDCODIGOMUNICIPAL').Value := ValoresCamposEstra[2];
    pDataSet.FieldByName('VALORUNITARIOORIGINAL').Value := pDataSet.FieldByName('VALORUNITARIO').Value;
  end;

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
  ConfiguraEditPesquisa(edtCFOP,pDataSet,tpERPCFOPVisivel);
  ConfiguraEditPesquisa(edtCST,pDataSet,tpERPCST);
  ConfiguraEditPesquisa(edtCSOSN,pDataSet,tpERPCSOSN);
  edtCST.TamanhoCodigo :=3;
  edtCST.AutoCompletar := False;
  edtCST.Enabled := pDataSet.FieldByName('CRT').Value = 3;

  edtCSOSN.TamanhoCodigo := 4;
  edtCSOSN.AutoCompletar := False;
  edtCSOSN.Enabled := pDataSet.FieldByName('CRT').Value <> 3;

  edtCFOP.TamanhoCodigo := 4;
  edtCFOP.AutoCompletar := False;


end;

procedure TfrmDlg_SaidaItem.SetDataSetSeriais(const Value: TpFIBClientDataSet);
begin
  FDataSetSeriais := Value;
end;

procedure TfrmDlg_SaidaItem.SetIdCLiente(const Value: TipoCampoChave);
begin
  FIdCLiente := Value;
end;

procedure TfrmDlg_SaidaItem.SetIdEmpresa(const Value: TipoCampoChave);
begin
  FIdEmpresa := Value;
end;

end.
