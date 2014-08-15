unit uLst_Servicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, pFIBClientDataSet, ActnList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, StdCtrls, Buttons,
  dxStatusBar, ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter;

type
  TfrmLst_Servicos = class(TfrmListagemPadrao)
    BitBtn11: TBitBtn;
    actImpComprovante: TAction;
    BitBtn12: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure CdsListagemAfterOpen(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actImpComprovanteExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Servicos: TfrmLst_Servicos;

implementation

uses MinhasClasses, Comandos, Cad_Servico, uLibPet;

{$R *.dfm}

procedure TfrmLst_Servicos.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_Servico := TfrmCad_Servico.Create(nil);
  Try
    frmCad_Servico.TipoPesquisa := Self.TipoPesquisa;
    frmCad_Servico.ValorChave := Self.CdsListagem.FieldByName('IDSERVICO').AsString;
    frmCad_Servico.EditReg := True;
    frmCad_Servico.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_Servico);
  End;
end;

procedure TfrmLst_Servicos.actImpComprovanteExecute(Sender: TObject);
begin
  Imp_ReciboPet(CdsListagem.FieldByName('IDEMPRESA').AsInteger,CdsListagem.FieldByName('IDSERVICO').AsInteger,tlTela);
end;

procedure TfrmLst_Servicos.actImprimirExecute(Sender: TObject);
begin
  inherited;
  ABreRelServico;
end;

procedure TfrmLst_Servicos.actNovoExecute(Sender: TObject);
begin
  inherited;
  ABreVenda();
end;

procedure TfrmLst_Servicos.BitBtn11Click(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

procedure TfrmLst_Servicos.CdsListagemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsListagem.FieldByName('VALORTOTALLIQUIDO'), tcMoeda);
end;

procedure TfrmLst_Servicos.FormCreate(Sender: TObject);
begin
  inherited;
  CriaColuna('NUMSERVICO','Nº Serviço', 60,tcString);
  CriaColuna('DATA','Data', 80,tcCampoData);
  CriaColuna('HORA','Hora', 80,tcHora);
  CriaColuna('LOGIN','Usuário', 80,tcString);
  CriaColuna('NOMECLIENTE','Cliente', 200,tcString);
  CriaColuna('VALORTOTALLIQUIDO','Total', 100,tcMoeda);
  TipoPesquisa := tpPetServico;
end;

procedure TfrmLst_Servicos.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.
