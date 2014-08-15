unit uRelServicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, cxCalendar, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TfrmRelServicos = class(TfrmdlgRelatorioPadrao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    CdsEmpresa: TpFIBClientDataSet;
    CdsPagamentos: TpFIBClientDataSet;
    CdsParametrosTexto: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelServicos: TfrmRelServicos;

implementation

uses MinhasClasses, Comandos, uSQL;

{$R *.dfm}

procedure TfrmRelServicos.btnNovoClick(Sender: TObject);
var
  StrWr,Str2,Str3,StrData: String;
begin
  GetPeriodo(edtDataIni.Text,edtDataFin.Text,StrData,'DATA');
  StrWr :=' 1=1 '+StrData;
  StrWr := StrWr+ GetFiltro(tpPetCliente,'C.IDCLIENTE');
  StrWr := StrWr+ GetFiltro(tpPetUsuario,'U.IDUSUARIO');

  StrWr := StrWr+ ' AND EXISTS(SELECT 1 '+
                  '              FROM SERVICODETALHE SD  '+
                  '             WHERE SD.IDSERVICO = S.IDSERVICO  '+
                                   GetFiltro(tpPetTipoServico,'IDTIPOSERVICO')+
                                   GetFiltro(tpPetProfissional,'IDPROFISSIONAL')+')';
  Str2 :=' 1=1 ';
  Str2 := Str2 +GetFiltro(tpPetTipoServico,'S.IDTIPOSERVICO')+
                GetFiltro(tpPetProfissional,'S.IDPROFISSIONAL');

  Str2 :=Str2+ ' AND EXISTS(SELECT 1 '+
               '              FROM SERVICO SD  '+
               '             WHERE SD.IDSERVICO = S.IDSERVICO '+ GetFiltro(tpPetCliente,'IDCLIENTE')+
                                    GetFiltro(tpPetUsuario,'IDUSUARIO')+')';

  StrWr := StrWr+ ' AND EXISTS(SELECT 1 '+
                  '              FROM SERVICODETALHE SD  '+
                  '             WHERE SD.IDSERVICO = S.IDSERVICO  '+
                                   GetFiltro(tpPetTipoServico,'IDTIPOSERVICO')+
                                   GetFiltro(tpPetProfissional,'IDPROFISSIONAL')+')';

  Str3 :=' AND EXISTS(SELECT 1 '+
         '              FROM SERVICO S  '+
         '             WHERE SF.IDSERVICO = S.IDSERVICO  '+StrData+
                          GetFiltro(tpPetCliente,'IDCLIENTE')+
                          GetFiltro(tpPetUsuario,'IDUSUARIO')+' )'+
         ' AND EXISTS(SELECT 1 '+
         '              FROM SERVICODETALHE SD  '+
         '             WHERE SF.IDSERVICO = SD.IDSERVICO  '+
                                   GetFiltro(tpPetTipoServico,'IDTIPOSERVICO')+
                                   GetFiltro(tpPetProfissional,'IDPROFISSIONAL')+') '+
         ' AND VALOR IS NOT NULL ';

  Str3 := GetSelect(tpPetServicoPagamentos,'')+Str3+ ' ORDER BY IDSERVICO ';
  Str3 := StringReplace(Str3,'SELECT','SELECT S.DATA,',[rfIgnoreCase]);
  SetCds(CdsMaster,tpPetServico,StrWr+ ' ORDER BY IDSERVICO ');
  SetCds(CdsDetalhes,tpPetServicoDetalhe,Str2+ ' ORDER BY IDSERVICO ');
  SetCds(CdsEmpresa,tpPetEmpresa,'' );
  SetCds(CdsPagamentos,Str3 );
  SetLength(DataSetExtras,1);
  DataSetExtras[0] := TpFIBClientDataSet.Create(nil);
  DataSetExtras[0] := CdsPagamentos;
  CdsParametros.Append;
  CdsParametrosTexto.AsString:=
       GetParametrosData(edtDataIni.Text, edtDataFin.Text)+
       GetParametros(tpPetCliente)+
       GetParametros(tpPetTipoServico)+
       GetParametros(tpPetProfissional)+
       GetParametros(tpPetUsuario);
  inherited;

end;

procedure TfrmRelServicos.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelServicosPet;
  CamposFiltro.Add(tpPetCliente);
  CamposFiltro.Add(tpPetTipoServico);
  CamposFiltro.Add(tpPetProfissional);
  CamposFiltro.Add(tpPetUsuario);
end;

end.
