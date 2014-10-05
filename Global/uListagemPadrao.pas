unit uListagemPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, StdCtrls, Buttons, ActnList, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxStatusBar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxContainer, cxGroupBox,
  cxCheckGroup, DBClient, pFIBClientDataSet, MinhasClasses, cxPC, Mask, DBCtrls,
  LabelDBEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter,
  Cad_CadastroPai;

type
  TClasseCadPai = class of TfrmCad_CadastroPai;

  TfrmListagemPadrao = class(TfrmPadrao)
    pnlFiltros: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Bevel1: TBevel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Bevel2: TBevel;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    actPrimeiro: TAction;
    actProximo: TAction;
    actAnterior: TAction;
    actUltimo: TAction;
    actNovo: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    actPesquisar: TAction;
    actImprimir: TAction;
    actSair: TAction;
    Status: TdxStatusBar;
    DataListagem: TDataSource;
    CdsListagem: TpFIBClientDataSet;
    pnlCaption: TPanel;
    Panel4: TPanel;
    chkMostrarGrupo: TCheckBox;
    chkRodape: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    PageControl: TcxPageControl;
    tsListagem: TcxTabSheet;
    cxGrid1: TcxGrid;
    TvListagem: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    procedure actPrimeiroExecute(Sender: TObject);
    procedure actProximoExecute(Sender: TObject);
    procedure actAnteriorExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure chkRodapeClick(Sender: TObject);
    procedure chkMostrarGrupoClick(Sender: TObject);
    procedure CdsListagemAfterScroll(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure CdsListagemAfterOpen(DataSet: TDataSet);
    procedure TvListagemDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    
  private
    FTipoPesquisa: TTipoPesquisa;
    FFiltros: WideString;
    FWr: String;
    FCampoOrdem: String;
//    FFormCadastro: TfrmCad_CadastroPai;
    FClasseCadPai: TClasseCadPai;
    procedure SetTipoPesquisa(const Value: TTipoPesquisa);
    procedure SetFormCadastro(const Value: TfrmCad_CadastroPai);
    procedure SetClasseCadPai(const Value: TClasseCadPai);
    { Private declarations }
  public
    Tabela, CampoChave :String;
    FormCadastro: TfrmCad_CadastroPai;
  published
    { Public declarations }

    property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write SetTipoPesquisa;
    property Filtros : WideString read FFiltros write FFiltros;
    property Wr : String read FWr write FWr;
    property CampoOrdem: String read FCampoOrdem write FCampoOrdem;
    Procedure AtuDados;
    Function CriaColuna(NomeCampo, Titulo: String; Tamanho: Integer; TipoCampo: TTipoCampo): TcxGridDBColumn;
    Function PodeExcluir : Boolean;
//    property  read FFormCadastro write SetFormCadastro;
    property ClasseCadPai : TClasseCadPai read FClasseCadPai write SetClasseCadPai;
  end;

var
  frmListagemPadrao: TfrmListagemPadrao;

implementation

uses UDmConexao,  Comandos, uSQL, uPesquisa_kimera;

{$R *.dfm}

procedure TfrmListagemPadrao.actAnteriorExecute(Sender: TObject);
begin
  inherited;
  CdsListagem.Prior;
end;

procedure TfrmListagemPadrao.actEditarExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ClasseCadPai)  then
  begin
    Try
      FormCadastro := ClasseCadPai.Create(Self);
      FormCadastro.TipoPesquisa  := Self.TipoPesquisa;
      FormCadastro.EditReg := True;
      FormCadastro.ValorChave := Self.CdsListagem.FieldByName(CampoChave).AsString;
      FormCadastro.ShowModal;
      Self.AtuDados;
    Finally
      FormCadastro.Free;
    End;
  end;
end;

procedure TfrmListagemPadrao.actExcluirExecute(Sender: TObject);
Var
  StrSQL, ID : String;
begin
  inherited;

  if not PodeExcluir then
    Avisa('Esse registro possui dependências.  '+#13+#10+
          ' Ao excluir esse registros outros registros poderão ser excluídos!');
  if (ConfirmaDel) then
  Begin
    try
//      if InfoSistema.UsaGuidChave then
//        ID := CdsListagem.FieldByName(CampoChave).AsString
//      else
//        ID:= CdsListagem.FieldByName(CampoChave).AsString;
//      StartTrans;
//      StrSQL :=
//        'EXECUTE BLOCK AS '+
//        ' DECLARE VARIABLE TABELA VARCHAR(40); '+
//        'BEGIN'+
//        '  FOR' +
//        '    SELECT X.TABELA'+
//        '      FROM VW_DEPENDENCIAS('+GetStr(Tabela)+','+ID+') X'+
//        '      INTO :TABELA'+
//        '    DO'+
//        '    BEGIN'+
//        '      EXECUTE STATEMENT' +
//        '        ''DELETE FROM ''||:TABELA||' +
//        '        '' WHERE ''||'+GetStr(CampoChave)+'||'' = ''||ascii_chr(39)||'+ID+'||ascii_chr(39);'+
//        '    END '+
//        'END';
//      Exec_SQL(StrSQL);
      StartTrans;
      AlteraBanco(taDeleta, CdsListagem, Tabela, CampoChave);
      Commit;
      AtuDados;
    except
      on E: Exception do
      Begin
        RollBack;
        raise;
      End;
    end;

  End;
end;

procedure TfrmListagemPadrao.actImprimirExecute(Sender: TObject);
begin
  inherited;
  //
end;


procedure TfrmListagemPadrao.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actNovo.Enabled := CdsListagem.Active;
  actEditar.Enabled := (CdsListagem.Active) and (CdsListagem.RecordCount > 0);
  actExcluir.Enabled := actEditar.Enabled;
  actPrimeiro.Enabled := actEditar.Enabled;
  actProximo.Enabled := actEditar.Enabled;
  actAnterior.Enabled := actEditar.Enabled;
  actUltimo.Enabled := actEditar.Enabled;

end;

procedure TfrmListagemPadrao.actNovoExecute(Sender: TObject);
begin
  inherited;
  if Assigned(ClasseCadPai) then
  begin
    Try
      FormCadastro := ClasseCadPai.Create(Self);
      FormCadastro.TipoPesquisa := Self.TipoPesquisa;
      FormCadastro.NovoReg := True;
      FormCadastro.ShowModal;
      Self.AtuDados;
    Finally
      FormCadastro.Free;
    End;

  end;
end;

procedure TfrmListagemPadrao.actPesquisarExecute(Sender: TObject);
var
  CampoPesquisa : String;
begin
  inherited;
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa do
    Begin
      TipoPesquisa := Self.TipoPesquisa;
      if ShowModal = mrOk Then
      Begin
        CampoPesquisa := GetApelido(Self.TipoPesquisa);
        if CampoPesquisa = '' then
           CampoPesquisa := CampoChave;
        //Filtros := CampoPesquisa + ' = '+ CdsPesquisa.FieldByName(CampoChave).AsString; 31/05/2012 alterei para locate
        //AtuDados;

        Self.CdsListagem.Locate(CampoChave,CdsPesquisa.FieldByName(CampoChave).AsString,[] );  //31/05/2012
      End;
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TfrmListagemPadrao.actPrimeiroExecute(Sender: TObject);
begin
  inherited;
  CdsListagem.First;
end;

procedure TfrmListagemPadrao.actProximoExecute(Sender: TObject);
begin
  inherited;
  CdsListagem.Next;
end;

procedure TfrmListagemPadrao.actSairExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmListagemPadrao.actUltimoExecute(Sender: TObject);
begin
  inherited;
  CdsListagem.Last;
end;

procedure TfrmListagemPadrao.AtuDados;
var
  StrSQL : String;
  vAfterScroll: TDataSetNotifyEvent;
begin
  if Filtros = '' then
    Filtros := '1=1';
  if Wr = '' then
    Wr := '1=1';
  if UpperCase(Copy(TrimLeft(wr),1,3)) <> 'AND' then
    Wr := ' AND '+WR;
  if FCampoOrdem = '' then
     FCampoOrdem := CampoChave;
  StrSQL := GetSelect(TipoPesquisa, Filtros+Wr,FCampoOrdem);
  Try
    CdsListagem.DisableControls;
    vAfterScroll := CdsListagem.AfterScroll;
    CdsListagem.AfterScroll := nil;
    SetCds(CdsListagem, StrSQL);
  Finally
    CdsListagem.EnableControls;
    CdsListagem.AfterScroll := vAfterScroll;
    if Assigned(vAfterScroll) then
      vAfterScroll(CdsListagem);
  End;
end;

procedure TfrmListagemPadrao.CdsListagemAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to CdsListagem.FieldCount -1 do
  Begin
    if CdsListagem.Fields[i].DataType in [ftFloat, ftCurrency,ftBCD,ftFMTBcd] then
      FormataMascara(CdsListagem.Fields[i],tcReal);
    if CdsListagem.Fields[i].DataType in [ftDate] then
      FormataMascara(CdsListagem.Fields[i],tcCampoData);

  End;

end;

procedure TfrmListagemPadrao.CdsListagemAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (CdsListagem.Active) and (CdsListagem.RecNo > 0) then
    Status.Panels[0].Text := 'Registro '+IntToStr(CdsListagem.RecNo)+ ' de '+IntToStr(CdsListagem.RecordCount)
  else
    Status.Panels[0].Text := '';
end;

procedure TfrmListagemPadrao.chkMostrarGrupoClick(Sender: TObject);
begin
  inherited;
  TvListagem.OptionsView.GroupByBox := chkMostrarGrupo.Checked;
end;

procedure TfrmListagemPadrao.chkRodapeClick(Sender: TObject);
begin
  inherited;
  TvListagem.OptionsView.Footer := chkRodape.Checked;
end;

function TfrmListagemPadrao.CriaColuna(NomeCampo, Titulo: String;
  Tamanho: Integer; TipoCampo: TTipoCampo): TcxGridDBColumn;
begin
  Result := MontaGrid(TvListagem, NomeCampo, Titulo, TipoCampo, Tamanho) ;
  if TipoCampo in [tcReal, tcMoeda] then
    CriaRodapeTableView(Result,  skSum, skSum)
  else
  if TipoCampo in [tcInt] then
    CriaRodapeTableView(Result,  skCount, skCount);

end;

procedure TfrmListagemPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if Assigned(FormCadastro) then
//  begin
//    FormCadastro.Free;
//    FormCadastro := nil;
//  end;
end;

procedure TfrmListagemPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.HideTabs := True;
  FormCadastro:= nil;
end;

procedure TfrmListagemPadrao.FormShow(Sender: TObject);
begin
  inherited;
  pnlCaption.Caption := Self.Caption;
end;

function TfrmListagemPadrao.PodeExcluir: Boolean;
Var
  StrSQL,ID : String;
begin
  if InfoSistema.UsaGuidChave then
    ID := GetStr(CdsListagem.FieldByName(CampoChave).AsString)
  else
    ID:= CdsListagem.FieldByName(CampoChave).AsString;
  StrSQL :=
    'SELECT SUM(QTD) QTD  '+
    '  FROM VW_DEPENDENCIAS('+QuotedStr(Tabela)+', '+ID+')';
  Result := StrToIntDef(GetValorCds(StrSQL),0) = 0;

end;

procedure TfrmListagemPadrao.SetClasseCadPai(const Value: TClasseCadPai);
begin
  FClasseCadPai := Value;
end;

procedure TfrmListagemPadrao.SetFormCadastro(const Value: TfrmCad_CadastroPai);
begin
  FormCadastro := Value;
end;

procedure TfrmListagemPadrao.SetTipoPesquisa(const Value: TTipoPesquisa);
begin
  FTipoPesquisa := Value;
  Tabela := GetTabela(Value);
  CampoChave := GetCampoChave(Value);
end;

procedure TfrmListagemPadrao.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  TvListagem.ViewData.Collapse(False)
end;

procedure TfrmListagemPadrao.SpeedButton2Click(Sender: TObject);
begin
  inherited;
   TvListagem.ViewData.Expand(False)
end;



procedure TfrmListagemPadrao.TvListagemDblClick(Sender: TObject);
begin
  inherited;
  actEditar.Execute;
end;

end.
