unit uLst_OS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadraoERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, DBClient,
  pFIBClientDataSet, ActnList, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  StdCtrls, Buttons, dxStatusBar, ExtCtrls, Menus,uLibERP;

type
  TfrmLst_OS = class(TfrmListagemPadraoERP)
    actBaixaOS: TAction;
    BitBtn11: TBitBtn;
    actReabrirOS: TAction;
    PopOperacoes: TPopupMenu;
    BaixarOS1: TMenuItem;
    Reabrir1: TMenuItem;
    actFaturarOS: TAction;
    actFaturarOS1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actBaixaOSExecute(Sender: TObject);
    procedure TvListagemStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
    procedure actReabrirOSExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actFaturarOSExecute(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
  private
    FIdCompetenciaContrato: TipoCampoChave;
    procedure SetIdCompetenciaContrato(const Value: TipoCampoChave);
    { Private declarations }
  public
    { Public declarations }
    property IdCompetenciaContrato: TipoCampoChave read FIdCompetenciaContrato write SetIdCompetenciaContrato;
  end;

var
  frmLst_OS: TfrmLst_OS;

implementation

uses MinhasClasses, uCad_OS, Comandos, uRegras, uSaida;

{$R *.dfm}

procedure TfrmLst_OS.actBaixaOSExecute(Sender: TObject);
VAR
  StrSQL: String;
begin
  inherited;
  if Pergunta('Deseja realmente baixar essa O.S. ?') then
  begin
    StrSQL :=
      'SELECT LIST(C.DESCRICAOEQUIPAMENTO||''(''||C.IDENTIFICADOR||'')'','', '')'+
      '  FROM EQUIPAMENTOSOS E'+
      ' INNER JOIN CLIENTEEQUIPAMENTOS C'+
      '    ON (C.IDCLIENTEEQUIPAMENTOS = E.IDEQUIPAMENTOCLIENTE)'+
      ' WHERE E.IDOS = '+TipoCampoChaveToStr(CdsListagem.FieldByName('IDOS').AsString) +
      '   AND E.SOLUCAO IS NULL';

    StrSQL:= GetValorCds(StrSQL);

    if StrSQL <> '' then
    begin
      Avisa('Esta O.S. não possui laudo no(s) equipamento(s): '+StrSQL);
      Exit;
    end;
    if TRegrasOS.BaixaOS(CdsListagem.FieldByName('IDOS').AsString) then
    begin
      Avisa('Os baixada com sucesso');
      AtuDados;
    end;
  end;

end;

procedure TfrmLst_OS.actFaturarOSExecute(Sender: TObject);
var
  frmFaturamento: TfrmSaida;
begin
  inherited;
  if (CdsListagem.FieldByName('FLAGBAIXADA').AsString <> 'Y') then
  begin
    Avisa('A O.S. deve estar baixada para fazer o faturamento.');
    Exit;
  end;
  if (CdsListagem.FieldByName('FLAGFATURADA').AsString = 'Y') then
  begin
    Avisa('A O.S. já foi faturada.');
    Exit;
  end;
  Try
    frmFaturamento := TfrmSaida.Create(nil);
    frmFaturamento.IDOS:= CdsListagem.FieldByName('IDOS').AsString;
    frmFaturamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmFaturamento);
  End;
end;

procedure TfrmLst_OS.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actReabrirOS.Enabled :=  (CdsListagem.Active) and (CdsListagem.FieldByName('FLAGBAIXADA').AsString = 'Y');
  actBaixaOS.Enabled := not actReabrirOS.Enabled;
  actBaixaOS.Visible := actBaixaOS.Enabled;
  actReabrirOS.Visible := actReabrirOS.Enabled;

end;

procedure TfrmLst_OS.actReabrirOSExecute(Sender: TObject);
begin
  inherited;
  if Pergunta('Tem certeza que deseja reabrir essa O.S.') then
  begin
     if TRegrasOS.ReabrirOS(CdsListagem.FieldByName('IDOS').AsString) then
     begin
       Avisa('O.S. reaberta com sucesso!');
       AtuDados;
     end;
  end;

end;

procedure TfrmLst_OS.BitBtn11Click(Sender: TObject);
begin
  inherited;
  PopOperacoes.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmLst_OS.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPOS;
  CriaColuna('NUMEROOS','N° O.S.',100,tcString);
  CriaColuna('DATA','Data',100,tcCampoData);
  CriaColuna('CODIGOCLIENTE','Codigo cliente',80,tcString);
  CriaColuna('NOMECLIENTE','Cliente',300,tcString);
  CriaColuna('NOMETIPOOS','Tipo',100,tcString);
  CriaColuna('NOMESTATUSOS','Status',100,tcString);
  CriaColuna('VALORTOTAL','Valor',100,tcMoeda);
  with CriaColuna('COR','COR',100,tcString) do
  begin
   Visible := False;
   VisibleForCustomization := False;
  end;
  CampoOrdem := 'NUMEROOS desc';
  AtuDados;
  FIdCompetenciaContrato := SemID;
end;

procedure TfrmLst_OS.FormShow(Sender: TObject);
begin
  inherited;
  Self.FormCadastro :=  frmCad_OS;
  Self.ClasseCadPai := TfrmCad_OS;
  if FIdCompetenciaContrato <> SemID then
  begin
    Filtros := 'o.IDCONTRATOCOMPETENCIA = '+TipoCampoChaveToStr(FIdCompetenciaContrato);
    AtuDados;
  end;

end;

procedure TfrmLst_OS.SetIdCompetenciaContrato(const Value: TipoCampoChave);
begin
  FIdCompetenciaContrato := Value;
end;

procedure TfrmLst_OS.TvListagemStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  V: Variant;
  C: TcxGridDBColumn;
begin
  inherited;
  C := (Sender as TcxGridDBTableView).GetColumnByFieldName('COR');
  V := ARecord.Values[C.Index];
  if not VarIsNull(v) then
  begin
    AStyle := TcxStyle.Create(Sender);
    AStyle.Color :=TColor(V);
  end;

end;

end.
