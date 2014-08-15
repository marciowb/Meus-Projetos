unit uRelContas;

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
  TfrmRelContasReceber = class(TfrmdlgRelatorioPadrao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    grpVenc: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtDataIniVencimento: TcxDateEdit;
    edtDataFinVencimento: TcxDateEdit;
    grpTipo: TRadioGroup;
    grpRec: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edtDataIniRec: TcxDateEdit;
    edtDataFinRec: TcxDateEdit;
    CdsParametrosTexto: TStringField;
    procedure btnNovoClick(Sender: TObject);
    procedure grpTipoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelContasReceber: TfrmRelContasReceber;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelContasReceber.btnNovoClick(Sender: TObject);
var
  StrSQL,Data,Vec,Rec,Animal: String;
  Tp: TTipoPesquisa;
begin
  GetPeriodo(edtDataIni.Text, edtDataFin.Text,Data,'DATA',True);
  GetPeriodo(edtDataIniVencimento.Text, edtDataFinVencimento.Text,Vec,'DATAVENCIMENTO',True);
  GetPeriodo(edtDataIniRec.Text, edtDataFinRec.Text,Rec,'DATAPAGO',True);
  if grpTipo.ItemIndex = 0 then
    Tp := tpPetContasReceber
  else
    Tp := tpPetContasRecebidas;
  Animal := GetFiltro(tpPetAnimal,'A.IDANIMAL');
  Animal := ' AND EXISTS(SELECT 1 '+
            '              FROM ANIMAL A '+
            '             WHERE A.IDCLIENTE = C.IDCLIENTE '+Animal+')';
  StrSQL := ' 1=1 '+GetFiltro(tpPetCliente,'Cr.IDCLIENTE')+Data+Vec+Rec+Animal;

  SetCds(CdsMaster,Tp,StrSQL);
  StrSQL :=
    '  EXISTS ( SELECT 1'+
    '                FROM CONTARECEBER CR '+
    '               INNER JOIN CLIENTE C  '+
    '                  ON (C.IDCLIENTE = CR.IDCLIENTE)'+
    '               WHERE CR.IDCONTARECEBER = CRR.IDCONTARECEBER and '+StrSQL+')';
  SetCds(CdsDetalhes,tpPetContaReceberRec,StrSQL);
  CdsParametrosTexto.AsString := GetParametrosData(edtDataIni.Text, edtDataFin.Text,'Período')+
                                 GetParametrosData(edtDataIniVencimento.Text, edtDataFinVencimento.Text,'Vencimento')+
                                 GetParametrosData(edtDataIniRec.Text, edtDataFinRec.Text,'Recebimento')+
                                 GetParametros(tpPetCliente)+
                                 GetParametros(tpPetAnimal);

  inherited;

end;

procedure TfrmRelContasReceber.FormCreate(Sender: TObject);
begin
  inherited;
  CamposFiltro.Add(tpPetCliente);
  CamposFiltro.Add(tpPetAnimal);
  grpTipoClick(nil);
  CdsParametros.Append;
end;

Procedure TfrmRelContasReceber.grpTipoClick(Sender: TObject);
begin
  inherited;
  if grpTipo.ItemIndex = 0 then
  Begin
    IdRelatorio := IdRelContasReceber;
    grpVenc.Enabled := True;
    grpRec.Enabled := False;
    edtDataIniRec.Clear;
    edtDataFinRec.Clear;
  End else
  Begin
    grpVenc.Enabled := False;
    grpRec.Enabled := True;
    edtDataIniVencimento.Clear;
    edtDataFinVencimento.Clear;
    IdRelatorio := IdRelContasRecebidas;
  End;
  AtuLayouts;
end;

end.
