unit uPesquisaAnimal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPesquisa_kimera, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu,
  cxEditRepositoryItems, cxExtEditRepositoryItems, FIBDataSet, pFIBDataSet,
  cxPropertiesStore, cxInplaceContainer, cxTLData, cxDBTL, Buttons, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, JvExControls, JvLabel, StdCtrls, Mask,
  ExtCtrls, cxContainer, cxListBox, DBClient, pFIBClientDataSet, Grids, DBGrids,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TfrmPesquisaAnimal = class(TfrmPesquisa)
    Panel7: TPanel;
    DataGrupo: TDataSource;
    CdsGrupo: TpFIBClientDataSet;
    GroupBox3: TGroupBox;
    GridGrupo: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure GridGrupoCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FWr: String;
    { Private declarations }
  public
    { Public declarations }
    Procedure ProcuraPorGrupo;
    Property Wr: String read FWr write FWr;
  end;

var
  frmPesquisaAnimal: TfrmPesquisaAnimal;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmPesquisaAnimal.GridGrupoCellClick(Column: TColumn);
begin
  inherited;
  ProcuraPorGrupo
end;

procedure TfrmPesquisaAnimal.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpPetAnimal;
  CdsGrupo.AfterScroll := nil;
  SetCds(CdsGrupo,tpPetGrupo,'');
  CdsGrupo.Append;
  CdsGrupo.FieldByName('NOMEGRUPO').AsString := ' Todos';
  CdsGrupo.Post;
  CdsGrupo.IndexFieldNames := 'NOMEGRUPO';

end;

procedure TfrmPesquisaAnimal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ActiveControl = GridGrupo then
  Begin
    if Key = Vk_Up then
      CdsGrupo.Prior;
    if Key = VK_DOWN then
      CdsGrupo.Next;
    ProcuraPorGrupo;
  End;
  inherited;

end;

procedure TfrmPesquisaAnimal.FormShow(Sender: TObject);
begin
  inherited;
  if Wr = '' then
    Wr := ' 1=1 ';
  Self.Where :=Wr;
end;

procedure TfrmPesquisaAnimal.ProcuraPorGrupo;
begin
  if CdsGrupo.FieldByName('IDGRUPO').AsString = '' then
    Self.Where :=Wr
  else
    Self.Where :=Wr+ ' and  EXISTS(SELECT 1'+
                  '             FROM GRUPOANIMAL AG '+
                  '            WHERE AG.IDANIMAL = A.IDANIMAL '+
                  '              AND AG.IDGRUPO = '+CdsGrupo.FieldByName('IDGRUPO').AsString+')';
  btnPesquisarClick(nil);
end;

end.
