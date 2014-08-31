unit Lst_CadastroPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, JvExControls, JvEnterTab, cxControls, cxSplitter,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBClient,
  ComCtrls, ToolWin, ActnList, ImgList, StdCtrls, Buttons, Mask, DBCtrls,
  LabelDBEdit, StrUtils,Classes_Pan, cxContainer, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxDBEdit, Menus, cxMemo;

type
 
  TfrmLst_CadastroPadrao = class(TfrmPadrao)
    Panel1: TPanel;
    cxSplitter1: TcxSplitter;
    Panel2: TPanel;
    TvLista: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataCadastro: TDataSource;
    CdsCadastro: TClientDataSet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Status: TStatusBar;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    actProximo: TAction;
    actPrimeiro: TAction;
    actAnterior: TAction;
    actUltimo: TAction;
    actNovo: TAction;
    actEditar: TAction;
    actDeletar: TAction;
    actPesquisar: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Panel3: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    edtCodigo: TLabelDBEdit;
    edtDescricao: TLabelDBEdit;
    actMenu: TAction;
    PopupMenu1: TPopupMenu;
    procedure actProximoExecute(Sender: TObject);
    procedure actPrimeiroExecute(Sender: TObject);
    procedure actAnteriorExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsCadastroBeforeDelete(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actMenuExecute(Sender: TObject);
  private
    FNomeTabela: String;
    FNomeChave: String;

    FTipoPesquisa: TTipoPesquisa;
    FNovoReg: Boolean;
    FEditaReg: Boolean;
    FUsaCodigo: Boolean;
    procedure SetNomeTabela(const Value: String);
    procedure SetNomeChave(const Value: String);
    procedure SetTipoPesquisa(const Value: TTipoPesquisa);
    procedure SetNovoReg(const Value: Boolean);
    procedure SetEditaReg(const Value: Boolean);
    procedure SetUsaCodigo(const Value: Boolean);
    { Private declarations }

  public
    { Public declarations }
    property NomeTabela : String  read FNomeTabela write SetNomeTabela;
    property NomeChave : String  read FNomeChave write SetNomeChave;

    property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write SetTipoPesquisa;
    Procedure Atu_Reg;
    Property NovoReg : Boolean read FNovoReg write SetNovoReg;
    property EditaReg : Boolean read FEditaReg write SetEditaReg;
    property UsaCodigo : Boolean  read FUsaCodigo write SetUsaCodigo;
    Function VerificaDependencia  :Boolean;
  end;

var
  frmLst_CadastroPadrao: TfrmLst_CadastroPadrao;
  Alteracao : TTipoAlteracao;
implementation

uses Comandos_Pan,  uPesquisa_PAN;

{$R *.dfm}

procedure TfrmLst_CadastroPadrao.actAnteriorExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Prior;
end;

procedure TfrmLst_CadastroPadrao.actDeletarExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
     if VerificaDependencia then
     Begin
       if Pergunda('Esse registro possui dependências, as mesmas serão perdidas. Deseja continuar? ') then
       Begin
         CdsCadastro.Delete;
         Atu_Reg;
       End;
  End else
  Begin
    CdsCadastro.Delete;
    Atu_Reg;
  End;

  End;

end;

procedure TfrmLst_CadastroPadrao.actEditarExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Edit;
  Alteracao := taModifica;
  edtCodigo.SetFocus;
end;

procedure TfrmLst_CadastroPadrao.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  btnGravar.Enabled := CdsCadastro.State in [dsInsert, dsEdit];
  btnCancelar.Enabled := btnGravar.Enabled;
  actNovo.Enabled := CdsCadastro.State in [dsBrowse];
  actEditar.Enabled := actNovo.Enabled;
  actDeletar.Enabled := (CdsCadastro.State in [dsBrowse]) and ( not CdsCadastro.IsEmpty);
  actProximo.Enabled := (CdsCadastro.State = dsBrowse) and ( not CdsCadastro.IsEmpty);
  actPrimeiro.Enabled := actProximo.Enabled;
  actAnterior.Enabled := actProximo.Enabled;
  actUltimo.Enabled := actProximo.Enabled;
end;

procedure TfrmLst_CadastroPadrao.actMenuExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmLst_CadastroPadrao.actNovoExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Append;
  Alteracao := taInsere;
  edtCodigo.SetFocus;
end;

procedure TfrmLst_CadastroPadrao.actPesquisarExecute(Sender: TObject);
begin
  inherited;
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa do
    Begin
      TipoPesquisa := Self.FTipoPesquisa;
      if ShowModal = mrOk then
      Begin
        Try
          CdsCadastro.DisableControls;
          CdsCadastro.Locate(FNomeChave, CdsPesquisa.FieldByName(FNomeChave).AsString, []);
        Finally
          CdsCadastro.EnableControls;
        End;
      End;

    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TfrmLst_CadastroPadrao.actPrimeiroExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.First;
end;

procedure TfrmLst_CadastroPadrao.actProximoExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Next;
end;

procedure TfrmLst_CadastroPadrao.actUltimoExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Last;
end;

procedure TfrmLst_CadastroPadrao.Atu_Reg;
var
  StrSQL : String;
  Save : TBookmark;
begin
  try
    CdsCadastro.DisableControls;
    Save := CdsCadastro.GetBookmark;
    StrSQL :=
      'SELECT * FROM '+ FNomeTabela;
    Atu_Cds(CdsCadastro, StrSQL) ;  
    Status.Panels[0].Text := 'Registro  '+ IntToStr(CdsCadastro.RecNo)+ ' de '+ IntToStr(CdsCadastro.RecordCount);
    CdsCadastro.GotoBookmark(Save);
  finally
    CdsCadastro.FreeBookmark(Save);
    CdsCadastro.EnableControls;
  end;
end;

procedure TfrmLst_CadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  CdsCadastro.Cancel;
end;

procedure TfrmLst_CadastroPadrao.btnGravarClick(Sender: TObject);
begin
  inherited;
  VerificaEdit(CdsCadastro, edtCodigo,'O Campo  '+edtCodigo.Titulo.Caption+' já existe', 'Informe o campo '+edtCodigo.Titulo.Caption );
  if edtDescricao.CanFocus then
    VerificaEdit(CdsCadastro, edtDescricao,'O Campo  '+edtDescricao.Titulo.Caption+' já existe', 'Informe o campo '+edtDescricao.Titulo.Caption );
  CdsCadastro.Post;
  AlteraBanco(Alteracao, CdsCadastro,FNomeTabela, FNomeChave );
  Atu_Reg;
end;

procedure TfrmLst_CadastroPadrao.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;

  CdsCadastro.FieldByName(FNomeChave).ProviderFlags := [];
end;

procedure TfrmLst_CadastroPadrao.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  Status.Panels[0].Text := 'Registro  '+ IntToStr(CdsCadastro.RecNo)+ ' de '+ IntToStr(CdsCadastro.RecordCount);
end;

procedure TfrmLst_CadastroPadrao.CdsCadastroBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  AlteraBanco(taDeleta, CdsCadastro, FNomeTabela, FNomeChave); 
end;

procedure TfrmLst_CadastroPadrao.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  if UsaCodigo then
    CdsCadastro.FieldByName('CODIGO').AsString := FormatFloat('000000', StrToFloat(GetValorCds('SELECT coalesce(MAX('+FNomeChave+'),0) +1 ID FROM '+FNomeTabela)));
end;

procedure TfrmLst_CadastroPadrao.FormShow(Sender: TObject);
begin
  inherited;
  Atu_Reg;
  if FNovoReg then
    actNovoExecute(nil);
  if FEditaReg then
    actEditarExecute(nil);
end;

procedure TfrmLst_CadastroPadrao.SetEditaReg(const Value: Boolean);
begin
  FEditaReg := Value;
end;

procedure TfrmLst_CadastroPadrao.SetNomeChave(const Value: String);
begin
  FNomeChave := Value;
end;

procedure TfrmLst_CadastroPadrao.SetNomeTabela(const Value: String);
begin
  FNomeTabela := Value;
end;

procedure TfrmLst_CadastroPadrao.SetNovoReg(const Value: Boolean);
begin
  FNovoReg := Value;
end;


procedure TfrmLst_CadastroPadrao.SetTipoPesquisa(const Value: TTipoPesquisa);
begin
  FTipoPesquisa := Value;
end;

procedure TfrmLst_CadastroPadrao.SetUsaCodigo(const Value: Boolean);
begin
  FUsaCodigo := Value;
end;

function TfrmLst_CadastroPadrao.VerificaDependencia: Boolean;
var
  StrSQL : String;
begin
  StrSQL :=
     'SELECT IDSAIDA '+
     '  FROM SAIDA '+
     ' WHERE '+NomeChave +' = '+ CdsCadastro.FieldByName(NomeChave).AsString;
  Result := StrToInt(GetValorCds(StrSQL)) > 0;  

end;

end.
