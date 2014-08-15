unit uLebrete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, JvExControls, JvGradientHeaderPanel, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBClient, pFIBClientDataSet, ExtCtrls, cxGridCardView,
  cxGridDBCardView, cxEditRepositoryItems, cxGridBandedTableView,
  cxGridDBBandedTableView, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, StdCtrls, GradientLabel;

type
  TfraLebrete = class(TFrame)
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataLembrete: TDataSource;
    CdsLebrete: TpFIBClientDataSet;
    Timer: TTimer;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1CheckBoxItem1: TcxEditRepositoryCheckBoxItem;
    cxEditRepository1BlobItem1: TcxEditRepositoryBlobItem;
    cxGrid1DBCardView1: TcxGridDBCardView;
    cxGrid1DBCardView1DATA: TcxGridDBCardViewRow;
    cxGrid1DBCardView1OBS: TcxGridDBCardViewRow;
    cxGrid1DBCardView1FLAGCHECADO: TcxGridDBCardViewRow;
    cxGrid1DBCardView1NOMEANIMAL: TcxGridDBCardViewRow;
    cxGrid1DBCardView1CLIENTE: TcxGridDBCardViewRow;
    GradientLabel1: TGradientLabel;
    procedure TimerTimer(Sender: TObject);
    procedure CdsLebreteAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Grava;
    Procedure Atualiza;
  end;

implementation

uses UDmConexao, Comandos, MinhasClasses;

{$R *.dfm}

procedure TfraLebrete.Atualiza;
begin
  SetCds(CdsLebrete,tpPetAcompanhamentoAnimal,'DATA <= CURRENT_DATE + 7 '+
                                              ' and COALESCE(FLAGCHECADO,''N'') = ''N'' AND COALESCE(A.FLAGMONITORAR,''N'') = ''Y'' ');
  Self.Visible := not CdsLebrete.IsEmpty;

end;

procedure TfraLebrete.CdsLebreteAfterOpen(DataSet: TDataSet);
begin
  CdsLebrete.FieldByName('FLAGEDICAO').ProviderFlags := [];
  CdsLebrete.FieldByName('NOMEANIMAL').ProviderFlags := [];
  CdsLebrete.FieldByName('CODIGO').ProviderFlags := [];
  CdsLebrete.FieldByName('CLIENTE').ProviderFlags := [];
end;

procedure TfraLebrete.Grava;
begin
  if CdsLebrete.State in [dsInsert,dsEdit] then
     CdsLebrete.Post;
  Try
    StartTrans;
    CdsLebrete.First;
    while not CdsLebrete.Eof do
    Begin
      AlteraBanco(taModifica,CdsLebrete,tpPetAcompanhamentoAnimal);
      CdsLebrete.Next;
    End;
    Commit;
  Except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  End;
end;

procedure TfraLebrete.TimerTimer(Sender: TObject);
begin
  if CdsLebrete.Active  then
    Grava;
   Atualiza;
end;

end.
