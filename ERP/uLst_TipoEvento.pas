unit uLst_TipoEvento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu,
  StdCtrls, ExtCtrls, DBCtrls, DBClient, pFIBClientDataSet, Menus, ActnList,
  cxInplaceContainer, cxTLData, cxDBTL, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, ComCtrls, ToolWin, Buttons, Mask, LabelDBEdit, cxSplitter,
  EditPesquisa;

type
  TftmLst_TipoEvento = class(TfrmLstCadastroSimplesERP)
    LabelDBEdit1: TLabelDBEdit;
    grpControle: TDBRadioGroup;
    edtPeriodo: TEditPesquisa;
    edtIntervalo: TLabelDBEdit;
    edtProduto: TEditPesquisa;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    procedure actGravarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpControleChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftmLst_TipoEvento: TftmLst_TipoEvento;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TftmLst_TipoEvento.actGravarExecute(Sender: TObject);
begin
  case grpControle.ItemIndex of
   -1:
      begin
        Avisa('Informe uma forma de controle');
        Exit;
      end;
   0:
     begin
       VerificaEdit(edtPeriodo,'Infomre o período');
     end;
   1:
    begin
       VerificaEdit(CdsCadastro, edtIntervalo,'','Infomre o intervalo');
     end;
   2:
    begin
      VerificaEdit(edtPeriodo,'Infomre o período');
      VerificaEdit(CdsCadastro, edtIntervalo,'','Infomre o intervalo');
    end;
  end;
  inherited;

end;

procedure TftmLst_TipoEvento.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPTipoEventos;
  CriaColuna('CODIGO','Código');
  CriaColuna('NOMETIPOEVENTOPATRIMONIO', 'Nome do evento', 150);
end;

procedure TftmLst_TipoEvento.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtPeriodo, CdsCadastro, tpERPPeridicidade);
  ConfiguraEditPesquisa(edtProduto, CdsCadastro, tpERPProduto);
end;

procedure TftmLst_TipoEvento.grpControleChange(Sender: TObject);
begin
  inherited;
  edtPeriodo.Enabled := grpControle.ItemIndex in[ 0,2];
  edtIntervalo.Enabled := grpControle.ItemIndex in[ 1,2];
end;

end.
