unit uLista_Layouts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, pFIBClientDataSet, ActnList, StdCtrls,
  Buttons, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit,
  JvComponentBase, JvPrint, DBCtrls, Printers, MinhasClasses, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TfrmLista_Layouts = class(TfrmPadrao)
    pnlButtom: TPanel;
    DataLayout: TDataSource;
    CdsLayout: TpFIBClientDataSet;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    cxGrid1: TcxGrid;
    TvLayouts: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    CategoryPanel2: TCategoryPanel;
    ActionList1: TActionList;
    actNovo: TAction;
    actEditar: TAction;
    actVisualizar: TAction;
    actDeletar: TAction;
    actRenomear: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label1: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    CategoryPanel3: TCategoryPanel;
    DBRadioGroup2: TDBRadioGroup;
    vLayoutsColumn1: TcxGridDBColumn;
    vLayoutsColumn2: TcxGridDBColumn;
    btnSelecionar: TBitBtn;
    btnCancelar: TBitBtn;
    actSelecionar: TAction;
    CdsRelatorio: TpFIBClientDataSet;
    DataRelatorio: TDataSource;
    cmbImpressoras: TDBComboBox;
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actVisualizarExecute(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure actRenomearExecute(Sender: TObject);
    procedure actSelecionarExecute(Sender: TObject);
    procedure CdsRelatorioAfterPost(DataSet: TDataSet);
    procedure CdsLayoutAfterPost(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
    procedure CdsLayoutAfterOpen(DataSet: TDataSet);
  private
    FIdRelatorio: Integer;
    FCdsDetalhe: TpFIBClientDataSet;
    FCdsMaster: TpFIBClientDataSet;
    FCdsInformacao: TpFIBClientDataSet;
    FCdsExtras: array of TpFIBClientDataSet;
    procedure SetIdRelatorio(const Value: Integer);
    { Private declarations }
    Procedure OpenReport(Tratamento : TTratamentoLayout);
  public
    { Public declarations }
    CdsExtras: Array of TpFIBClientDataSet;
    property IdRelatorio : Integer read FIdRelatorio write SetIdRelatorio;
    property CdsMaster :TpFIBClientDataSet read FCdsMaster write FCdsMaster;
    property CdsDetalhe :TpFIBClientDataSet read FCdsDetalhe write FCdsDetalhe;
    property CdsInformacao :TpFIBClientDataSet read FCdsInformacao write FCdsInformacao;
    Procedure AtuLayouts;
  end;

var
  frmLista_Layouts: TfrmLista_Layouts;

implementation

uses UDmConexao, Comandos, uSQL;

{$R *.dfm}

{ TfrmLista_Layouts }

procedure TfrmLista_Layouts.actDeletarExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    try
      StartTrans;
      AlteraBanco(taDeleta, CdsLayout, 'LAYOUT', 'IDLAYOUT');
      AtuLayouts;
      Commit;
    except
       on E: Exception do
       Begin
         RollBack;
         raise;
       End;
    end;
  End;
end;

procedure TfrmLista_Layouts.actEditarExecute(Sender: TObject);
begin
  inherited;
  OpenReport(tlEditar);
end;

procedure TfrmLista_Layouts.actNovoExecute(Sender: TObject);
begin
  inherited;
  OpenReport(tlNovo);
end;

procedure TfrmLista_Layouts.actRenomearExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmLista_Layouts.actSelecionarExecute(Sender: TObject);
Var
 StrSQL : String;
begin
  inherited;
   if CdsRelatorio.State in [dsEdit, dsInsert] then
   Begin
     CdsRelatorio.FieldByName('IMPRESSORAPADRAO').AsString := cmbImpressoras.Text;
     CdsRelatorio.Post;
   End;

   if CdsLayout.State in [dsEdit, dsInsert] then
     CdsLayout.Post;

   try
     StartTrans;
     StrSQL :=
       ' UPDATE LAYOUT ' +
       '    SET FLAGPADRAO = ''Y'' '+
       '  WHERE IDLAYOUT = '+CdsLayout.FieldByName('IDLAYOUT').AsString;
     Exec_SQL(StrSQL);
     StrSQL :=
       ' UPDATE LAYOUT ' +
       '    SET FLAGPADRAO = ''N'' '+
       '  WHERE IDLAYOUT <> '+CdsLayout.FieldByName('IDLAYOUT').AsString+
       '    AND IDRELATORIO = '+IntToStr(IdRelatorio);
     Exec_SQL(StrSQL);
     Commit;
     MoDalResult := mrOk;
   except
     on E: Exception do
     Begin
       RollBack;
       Raise;
     end;
   end;
end;

procedure TfrmLista_Layouts.actVisualizarExecute(Sender: TObject);
begin
  inherited;
  OpenReport(tlTela);
end;

procedure TfrmLista_Layouts.AtuLayouts;
begin
  cmbImpressoras.Items.Assign(Printer.Printers);
  SetCds(Self.CdsRelatorio,GetSelect(tpRelatorio, 'IDRELATORIO = '+IntToStr(IdRelatorio)) );
  SetCds(Self.CdsLayout, GetSelect(tpLayout, ' L.IDRELATORIO = '+IntToStr(IdRelatorio)));
  Self.Caption := 'Layouts de '+CdsRelatorio.FieldByName('DESCRICAO').AsString;
  cmbImpressoras.ItemIndex := cmbImpressoras.Items.IndexOf(CdsRelatorio.FieldByName('IMPRESSORAPADRAO').AsString);
//  DmRelatorio.pIdRelatorio :=IdRelatorio;
end;

procedure TfrmLista_Layouts.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmLista_Layouts.CdsLayoutAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsLayout.FieldByName('IMPRESSORAPADRAO').ProviderFlags := [];
end;

procedure TfrmLista_Layouts.CdsLayoutAfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    StartTrans;
    AlteraBanco(taInsertOrUpdate, CdsLayout, 'LAYOUT', 'IDLAYOUT');
    Commit;
  except
    on E: Exception do
    Begin
      RollBack;
      raise;
    End;
  end;

end;

procedure TfrmLista_Layouts.CdsRelatorioAfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    StartTrans;
    AlteraBanco(taInsertOrUpdate, CdsRelatorio, 'RELATORIO', 'IDRELATORIO');
    Commit;
    AtuLayouts;
  except
    on E: Exception do
    Begin
      RollBack;
      raise;
    End;
  end;
end;

procedure TfrmLista_Layouts.OpenReport(Tratamento: TTratamentoLayout);
begin
  ImprimeRelatorio(IdRelatorio, CdsMaster, CdsDetalhe, CdsInformacao, Tratamento,CdsExtras);
  AtuLayouts;
end;

procedure TfrmLista_Layouts.SetIdRelatorio(const Value: Integer);
begin
  FIdRelatorio := Value;
  AtuLayouts;
end;

end.
