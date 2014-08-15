unit uRelCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, cxCalendar;

type
  TfrmRelCaixa = class(TfrmdlgRelatorioPadrao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCaixa: TfrmRelCaixa;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelCaixa.btnNovoClick(Sender: TObject);
var
  StrData,StrWr:String;
begin
  StrWR := ' 1=1 ';
  StrWR := StrWR +GetFiltro(tpPetUsuario,'IDUSUARIO');
  GetPeriodo(edtDataIni.Text,edtDataFin.Text,StrData,'DATA');
  SetCds(CdsMaster,tpPetCaixa,StrWr+StrData+' ORDER BY DATA');
  inherited;

end;

procedure TfrmRelCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelCaixaPet;
  CamposFiltro.Add(tpPetUsuario);
  edtDataIni.Date := StrToDate(GetDataServidor);
  edtDataFin.Date := StrToDate(GetDataServidor);

end;

end.
