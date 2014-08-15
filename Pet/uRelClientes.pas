unit uRelClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, cxCalendar, Mask;

type
  TfrmRelClientes = class(TfrmdlgRelatorioPadrao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataCadIni: TcxDateEdit;
    edtDataCadFin: TcxDateEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtDataNiverIni: TMaskEdit;
    edtDataNiverFin: TMaskEdit;
    CdsParametrosTexto: TStringField;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelClientes: TfrmRelClientes;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelClientes.btnNovoClick(Sender: TObject);
var
  StrWr,STrData: String;
begin
  GetPeriodo(edtDataCadIni.Text,edtDataCadFin.Text,STrData,'DATACADASTRO');
  StrWr := GetFiltro(tpPetCliente,'IDCLIENTE');
  if StrWr = '' then
    StrWr := ' 1=1 ';
  if edtDataNiverIni.Text <> '  /  ' then
    StrWr := StrWr + ' AND SUBSTRING(DATANASCIMENTO FROM 6 FOR 5) >= '+GetStr(Copy(edtDataNiverIni.Text,4,2)+'-'+Copy(edtDataNiverIni.Text,1,2));
  if edtDataNiverFin.Text <> '  /  ' then
    StrWr := StrWr + ' AND SUBSTRING(DATANASCIMENTO FROM 6 FOR 5) <= '+GetStr(Copy(edtDataNiverFin.Text,4,2)+'-'+Copy(edtDataNiverFin.Text,1,2));
  SetCds(CdsMaster,tpPetCliente,StrWr+STrData) ;
  CdsParametrosTexto.AsString :=
     GetParametrosData(edtDataCadIni.Text, edtDataCadFin.Text,'Período de cadastro')+
     GetParametrosData(edtDataNiverIni.Text, edtDataNiverFin.Text,'Nascidos ')+
     GetParametros(tpPetCliente);
  inherited;

end;

procedure TfrmRelClientes.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelClientesPet ;
  CamposFiltro.Add(tpPetCliente);
  CdsParametros.Append;
end;

end.
