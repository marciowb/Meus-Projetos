unit Lst_CadastroSimples;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ComCtrls, ExtCtrls, cxControls, cxSplitter, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ToolWin, ImgList, ActnList,
  DBClient, Menus, StdCtrls, Mask, DBCtrls, LabelDBEdit, Buttons, MinhasClasses,
  cxPC, cxTL, cxInplaceContainer, cxTLData, cxDBTL,
  cxMaskEdit, pFIBClientDataSet, cxTLdxBarBuiltInMenu, cxLookAndFeels,
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

  TfrmLstCadastroSimples = class(TfrmPadrao)
    Status: TStatusBar;
    Panel1: TPanel;
    cxSplitter1: TcxSplitter;
    Panel3: TPanel;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    DataCadastro: TDataSource;
    PopupMenu1: TPopupMenu;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    btnNovo: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    actMenu: TAction;
    actPrimeiro: TAction;
    actAnterior: TAction;
    actProximo: TAction;
    actUltimo: TAction;
    actNovo: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    actPesquisar: TAction;
    Novo1: TMenuItem;
    Editar1: TMenuItem;
    Pesquisar1: TMenuItem;
    Excluir1: TMenuItem;
    edtCodigo: TLabelDBEdit;
    Panel4: TPanel;
    actGravar: TAction;
    actCancelar: TAction;
    Panel2: TPanel;
    PageControl: TcxPageControl;
    tsGrid: TcxTabSheet;
    tsTree: TcxTabSheet;
    pnlGrid: TPanel;
    TvCadastro: TcxGrid;
    TvCadastroDBTableView1: TcxGridDBTableView;
    TvCadastroLevel1: TcxGridLevel;
    pnlTree: TPanel;
    TvTree: TcxDBTreeList;
    PopNovoTree: TPopupMenu;
    Filho1: TMenuItem;
    Pai1: TMenuItem;
    ActNovoPai: TAction;
    actNovoFilho: TAction;
    CdsCadastro: TpFIBClientDataSet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure actMenuExecute(Sender: TObject);
    procedure actPrimeiroExecute(Sender: TObject);
    procedure actAnteriorExecute(Sender: TObject);
    procedure actProximoExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actPesquisarExecute(Sender: TObject);
    procedure CdsCadastroBeforeEdit(DataSet: TDataSet);
    procedure CdsCadastroAfterCancel(DataSet: TDataSet);
    procedure actNovoFilhoExecute(Sender: TObject);
    procedure ActNovoPaiExecute(Sender: TObject);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroBeforePost(DataSet: TDataSet);
  private
    { Private declarations }

    ValorAtual, ValorAnterior : TStringList;
    FUsaCampoCodigo: Boolean;
    FNomeTabela: String;
    FCampoChave: string;
    FTipoPesquisa: TTipoPesquisa;
    FVerificaEdits: boolean;
    FNovoReg: Boolean;
    FEditReg: Boolean;
    FTipoForm: TTipoFormBasico;
    FCampoCodigo: String;
    FUsaChave: Boolean;
    procedure SetUsaCampoCodigo(const Value: Boolean);
    Procedure AtualizaDados;
    procedure SetTipoForm(const Value: TTipoFormBasico);
    procedure CriaNovo(Filho : Boolean);
    procedure SetCampoCodigo(const Value: String);
    Function PodeExcluir : Boolean;
    Procedure CriaObjsVerso20;
    function GetValorChave: String;
    function GetAlterando: Boolean;
  public
    { Public declarations }
    MyCaption : String;
    TipoAlteracao : TTipoAlteracao;
    pUsaMaxParaCodigo: Boolean;
    Function ExisteRegistro(NomeCampo : String) : Boolean;
    property UsaCampoCodigo : Boolean read FUsaCampoCodigo write SetUsaCampoCodigo;
    property CampoChave : string read FCampoChave write FCampoChave;
    property NomeTabela : String read FNomeTabela write FNomeTabela;
    property TipoPesquisa :TTipoPesquisa read FTipoPesquisa write FTipoPesquisa;
    Function CriaColuna(NomeCampo, Descricao : String; Tamanho : Integer = 70): TcxGridDBColumn;
    property VerificaEdits : boolean  read FVerificaEdits write FVerificaEdits;
    property NovoReg : Boolean read FNovoReg write FNovoReg;
    property EditReg : Boolean read FEditReg write FEditReg;
    property TipoForm : TTipoFormBasico read FTipoForm write SetTipoForm;
    procedure CriaColunaTree(Campo, Titulo: String;Tamanho: Integer);
    property CampoCodigo: String read FCampoCodigo write SetCampoCodigo;
    property UsaChave: Boolean read FUsaChave write FUsaChave;
    property ValorChave: String read GetValorChave;
    Property Alterando : Boolean read  GetAlterando;
    Procedure MudaEstado;Virtual;
  end;

var
  frmLstCadastroSimples: TfrmLstCadastroSimples;

implementation

uses uDMConexao, Comandos, uPesquisa_kimera, uSQL;

{$R *.dfm}

procedure TfrmLstCadastroSimples.actAnteriorExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Prior;
end;

procedure TfrmLstCadastroSimples.actCancelarExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Cancel;
  TipoAlteracao := taParado;
  Self.Caption := MyCaption;
end;

procedure TfrmLstCadastroSimples.actEditarExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Edit;
  TipoAlteracao := taModifica;
  if edtCodigo.CanFocus then
    edtCodigo.SetFocus;
  Self.Caption := MyCaption + ' (Alteração)';
end;

procedure TfrmLstCadastroSimples.actExcluirExecute(Sender: TObject);
var
  StrSQL: String;
begin
  inherited;
  if not PodeExcluir then
  Begin
    Avisa('Esse registro não pode ser excluído porque possui dependências.');
    Exit;
  End;
  if TipoForm = tfGrid then
  Begin
    if ConfirmaDel then
    Begin
      try
        StartTrans;
        TipoAlteracao := taDeleta;
        AlteraBanco(TipoAlteracao, CdsCadastro, NomeTabela, CampoChave);
        CdsCadastro.Delete;
        Commit;
      except
        on E: Exception do
        Begin
           RollBack;
          raise;
        End;
      end;
    End;
  End else
  Begin
    if Pergunta('Se esse registro for excluído todos os seus dependentes serão apagados também. '+#13+#10+
                'Deseja realmente excluir esse registro?') then
     Begin
        StrSQL :=
          'delete from '+NomeTabela+
          ' where classificacao like '+QuotedStr(CdsCadastro.FieldByName('classificacao').AsString+'%');
        Exec_SQL(StrSQL);
        AtualizaDados;
     End;           
    

  End;
end;

procedure TfrmLstCadastroSimples.actGravarExecute(Sender: TObject);
var
  vAfterScroll : TDataSetNotifyEvent;
begin
  inherited;
  Try
    vAfterScroll := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
    Try
      if VerificaEdits then
      Begin
        if not VerificaLabelDbEdit(Self, CdsCadastro) Then
        Begin
          CdsCadastro.AfterScroll := CdsCadastro.AfterScroll;
          Abort;
        End;
      End;
      StartTrans;
      CdsCadastro.Post;
      if UsaChave then
        GetCodigo(TipoPesquisa);//Incrementa 1 no generator
      Commit;

      AtualizaDados;
      TipoAlteracao := taParado;
    Except
      on e: exception do
      Begin
        RollBack;
        Raise;
      End;
    End;
  Finally
    Self.Caption := MyCaption;
    CdsCadastro.AfterScroll := vAfterScroll;
    if Assigned(vAfterScroll) then
       vAfterScroll(nil);
  End;
  if NovoReg or EditReg then
     ModalResult := mrOk;

end;

procedure TfrmLstCadastroSimples.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actEditar.Enabled := (CdsCadastro.Active) and (CdsCadastro.State in [dsBrowse]) and (CdsCadastro.RecordCount >0);
  actExcluir.Enabled := actEditar.Enabled;
  actPesquisar.Enabled := actEditar.Enabled;
  actPrimeiro.Enabled := actEditar.Enabled;
  actAnterior.Enabled := actEditar.Enabled;
  actUltimo.Enabled := actEditar.Enabled;
  actProximo.Enabled := actEditar.Enabled;
  actNovo.Enabled := (CdsCadastro.Active) and (CdsCadastro.State in [dsBrowse]);
  actGravar.Enabled := (CdsCadastro.Active) and (CdsCadastro.State in [dsEdit, dsInsert]);
  actCancelar.Enabled := actGravar.Enabled;
  actNovoFilho.Enabled := (CdsCadastro.Active) and (CdsCadastro.RecordCount > 0)
  
end;

procedure TfrmLstCadastroSimples.actMenuExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmLstCadastroSimples.actNovoExecute(Sender: TObject);
begin
  inherited;
  if TipoForm = tfGrid then
  Begin
    ActiveControl := nil;
    CdsCadastro.Append;
    TipoAlteracao := taInsere;
    if edtCodigo.CanFocus then
      edtCodigo.SetFocus;
    Self.Caption := MyCaption + ' (Inclusão)';
  End;
end;

procedure TfrmLstCadastroSimples.actNovoFilhoExecute(Sender: TObject);
begin
  inherited;
  CriaNovo(True);
end;

procedure TfrmLstCadastroSimples.ActNovoPaiExecute(Sender: TObject);
begin
  inherited;
  CriaNovo(False);
end;

procedure TfrmLstCadastroSimples.actPesquisarExecute(Sender: TObject);
var
  vAfterScroll : TDataSetNotifyEvent;
begin
  inherited;
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa  do
    Begin
      vAfterScroll := CdsCadastro.AfterScroll;
      frmPesquisa.TipoPesquisa := Self.TipoPesquisa;
      CdsCadastro.AfterScroll := nil;
      if ShowModal = mrOk then
        CdsCadastro.Locate(CampoChave, CdsPesquisa.FieldByName(CampoChave).Value, []) ;      
    End;
  Finally
    CdsCadastro.AfterScroll := vAfterScroll;
    if Assigned(vAfterScroll) then
      vAfterScroll(nil);
    FreeAndNil(frmPesquisa );
  End; 
end;

procedure TfrmLstCadastroSimples.actPrimeiroExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.First;
end;

procedure TfrmLstCadastroSimples.actProximoExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Next;
end;

procedure TfrmLstCadastroSimples.actUltimoExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Last;
end;

procedure TfrmLstCadastroSimples.AtualizaDados;
var
  Scroll : TDataSetNotifyEvent;
begin
  Try
    Scroll := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
    SetCds(CdsCadastro, GetSelect(TipoPesquisa));
  Finally
    CdsCadastro.AfterScroll := Scroll;
     if Assigned(scroll) then
        Scroll(nil);
  End;
  if TipoForm = tfTree then
  Begin
    TvTree.BeginUpdate;
    TvTree.FullExpand;
    TvTree.EndUpdate;
  End;
   
end;

procedure TfrmLstCadastroSimples.CdsCadastroAfterCancel(DataSet: TDataSet);
begin
  inherited;
  Self.Caption := MyCaption;
end;

procedure TfrmLstCadastroSimples.CdsCadastroAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ComponentCount - 1 do
  Begin
    if Components[i] is TLabelDBEdit then
    Begin
     if not (Components[i] as TLabelDBEdit).GravaEsteCampo then
     Begin
       if (Components[i] as TLabelDBEdit).DataSource = nil then
         AvisaErro('DataSorce não configurado '+(Components[i] as TLabelDBEdit).Name);
       (Components[i] as TLabelDBEdit).DataSource.DataSet.FieldByName((Components[i] as TLabelDBEdit).DataField).ProviderFlags := [];
     End;
    End;
  End;
  if CdsCadastro.FindField('FLAGEDICAO') <> NIL then
    CdsCadastro.FindField('FLAGEDICAO').ProviderFlags := [];
end;

procedure TfrmLstCadastroSimples.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  AlteraBanco(TipoAlteracao, CdsCadastro, NomeTabela, CampoChave);

end;

procedure TfrmLstCadastroSimples.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Status.SimpleText := 'Registro '+ IntToStr(CdsCadastro.RecNo)+' de '+IntToStr(CdsCadastro.RecordCount);
  if TipoForm = tfTree then
  Begin
    Try
      TvTree.BeginUpdate;
      TvTree.FullExpand;
    Finally
      TvTree.EndUpdate;
    End;
  End;

end;

procedure TfrmLstCadastroSimples.CdsCadastroBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if TipoAlteracao = taParado then
    TipoAlteracao := taModifica;
end;

procedure TfrmLstCadastroSimples.CdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not DMCOnexao.Trans.InTransaction then
  Begin
     if Pergunta('Existem informações ainda não gravadas. Gostaria de cancelar?') then
     Begin
       actCancelarExecute(nil);
       Abort;
     end else
      Abort;
  End else;

end;

procedure TfrmLstCadastroSimples.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  TipoAlteracao := taInsere;
  if UsaChave then
  begin
    if InfoSistema.UsaGuidChave then
      CdsCadastro.FieldByName(CampoChave).AsString := GetCodigo(TipoPesquisa, ttcChave)
    else
      CdsCadastro.FieldByName(CampoChave).AsString := GetCodigo(TipoPesquisa, ttcCodigo); //Não incrementar
  end;
  if UsaCampoCodigo then
     CdsCadastro.FieldByName(CampoCodigo).AsString := GetCodigo(TipoPesquisa, ttcCodigo,pUsaMaxParaCodigo);
end;

function TfrmLstCadastroSimples.CriaColuna(NomeCampo,
  Descricao: String; Tamanho : Integer = 70): TcxGridDBColumn;
begin
  Result := MontaGrid(TvCadastroDBTableView1, NomeCampo, Descricao, tcString, Tamanho);
end;

procedure TfrmLstCadastroSimples.CriaColunaTree(Campo, Titulo: String;
  Tamanho: Integer);
begin
  MontaTree(TvTree,Campo, Titulo,Tamanho);
end;

procedure TfrmLstCadastroSimples.CriaNovo(Filho: Boolean);
var
  StrSQL, CodPai, Classificacao : String;
  po,i : Integer;
  Function GetPos(Const StValue : String): Integer;
  var
    r : Integer;
  Begin
    Result := 0;
    for R := Length(StValue) downto 0  do
      if StValue[R] = '.' then
      Begin
        Result := R;
        Break;
      End;
  End;

  Function GetClassificacao(Whr : String): String;
  var
    SQL : String;
  Begin
    SQL :=
        'select coalesce(max(s.classificacao),0) maximo'+
        '   from '+NomeTabela+' s '+
        '  where s.classificacao like '+QuotedStr(whr+'.%');
    Result := GetValorCds(SQL);
  End;

begin
  Try
    CdsCadastro.DisableControls;
    CodPai := CdsCadastro.FieldByName(CampoChave).AsString;
    StrSQL := CdsCadastro.FieldByName('classificacao').AsString;
    if Filho then
    Begin
      Po := GetPos(StrSQL);
//      StrSQL := GetClassificacao(Po+1,Length(CdsCadastro.FieldByName('classificacao').AsString)-Po, Copy(StrSQL, po+1, length(CdsCadastro.FieldByName('classificacao').AsString)-Po));
      StrSQL := GetClassificacao(CdsCadastro.FieldByName('classificacao').AsString);
      Classificacao := CdsCadastro.FieldByName('classificacao').AsString;
      Po := GetPos(StrSQL);
      StrSQL :=Copy(StrSQL, po+1, length(StrSQL)-Po);
      StrSQL := FormatFloat('00',StrToIntDef(StrSQL,0)+1);
      Classificacao := Classificacao+'.'+StrSQL; 
      StartTrans;
      StrSQL:=
        'update '+NomeTabela+  { TODO : Fazer esse tratamento no momento de gravar }
        '    set flagtipo = ''S'' '+
        '  where '+CampoChave+' = '+QuotedStr(CdsCadastro.FieldByName(CampoChave).AsString);
      Exec_SQL(StrSQL);
      Commit;
      CdsCadastro.Append;
      CdsCadastro.FieldByName('codpai').AsString := CodPai;
      CdsCadastro.FieldByName('Classificacao').AsString := Classificacao;
      CdsCadastro.FieldByName('flagtipo').AsString := 'A';
    End else
    Begin
       StrSQL:=
         'select max(classificacao) classificacao' +
         '  from '+NomeTabela+
         ' where CHARACTER_LENGTH(classificacao) = 3 ';

       Classificacao := GetValorCds(StrSQL);
       Classificacao := FormatFloat('000', StrToIntDef(Classificacao,0)+1);
       CdsCadastro.Append;
       CdsCadastro.FieldByName('Classificacao').AsString := Classificacao;
       CdsCadastro.FieldByName('flagtipo').AsString := 'S';       
    End;
    TipoAlteracao := taInsere;
    Self.Caption := MyCaption + ' (Inclusão)';
    if edtCodigo.CanFocus then
      edtCodigo.SetFocus;
  Finally
    CdsCadastro.EnableControls;
  End;

end;

procedure TfrmLstCadastroSimples.CriaObjsVerso20;
var
  EdtNome: TLabelDBEdit;
begin
  Self.Caption := 'Cadastro  '+InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').DescricaoTabela;
  MyCaption := Self.Caption;
  if InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').DescricaoCampoDisplay = '' then
    Exit;
  EdtNome := TLabelDBEdit.Create(Self);
  EdtNome.Parent := Panel3;
  EdtNome.Top := edtCodigo.Top+edtCodigo.Height+edtCodigo.Titulo.Height+5;
  EdtNome.Left := edtCodigo.Left;
  EdtNome.DataSource := DataCadastro;
  EdtNome.Width := 300;
  EdtNome.TabOrder :=edtCodigo.TabOrder +1;
  with InfoSistema.SQLs.GetMySQL(TipoPesquisa,'') do
  Begin
    EdtNome.DataField := CampoDisplay;
    EdtNome.Titulo.Caption := DescricaoCampoDisplay;
    Self.Caption :=  'Cadastro de  '+DescricaoTabela;
    if TipoForm = tfGrid then
    Begin
      CriaColuna(CampoCodigo,'Código');
      CriaColuna(CampoDisplay,DescricaoCampoDisplay,120);
    End else
    Begin
      CriaColunaTree(CampoCodigo,'Código',70);
      CriaColunaTree(CampoDisplay,DescricaoCampoDisplay,120);
    End;
  End;

end;

function TfrmLstCadastroSimples.ExisteRegistro(NomeCampo: String): Boolean;
var
  CdsClone : TClientDataSet;
begin
   if TipoALteracao = taModifica then
      Exit;
   CdsClone := TClientDataSet.Create(Self);
   Try
     CdsClone.CloneCursor(CdsCadastro, True);
     Result := CdsClone.Locate(NomeCampo, CdsCadastro.FieldByName(NomeCampo).AsString, []);
   Finally
     FreeAndNil(CdsClone);
   End;
end;

procedure TfrmLstCadastroSimples.FormCreate(Sender: TObject);
begin
  inherited;
  VerificaEdits := True;
  NovoReg := False;
  EditReg := False;
  TipoForm := tfGrid;
  PageControl.HideTabs := True;
  FUsaCampoCodigo := True;
  UsaChave := True;
end;

procedure TfrmLstCadastroSimples.FormShow(Sender: TObject);
begin
  inherited;
  with InfoSistema.SQLs.GetMySQL(FTipoPesquisa, '') do
  Begin
    FNomeTabela := NomeTabela;
    FCampoChave := CampoChave;
    FCampoCodigo := CampoCodigo;
    pUsaMaxParaCodigo := UsaMaxParaCodigo;
    Self.UsaCampoCodigo := CampoCodigo <> '';
    Self.TipoForm := TipoForm;
  End;
  AtualizaDados;
  TipoAlteracao := taParado;
  MyCaption := Self.Caption;

//  AuditoriaClientLst.DataSet := CdsCadastro;
//  AuditoriaClientLst.GravaAutomatico := True;
//  AuditoriaClientLst.UsuarioSistema := UsuarioLogado.Login;
//  AuditoriaClientLst.Tabela := NomeTabela;
//
//  if UsaCampoCodigo then
//  Begin
//    AuditoriaClientLst.CampoCodigo := CampoCodigo;
//  End else
//    AuditoriaClientLst.CampoCodigo := CampoChave;
    
//  AuditoriaClientLst.NomeModulo := MyCaption;
//  AuditoriaClientLst.Server := DMConexao.AuditoriaServer;
//  AuditoriaClientLst.Tabela := NomeTabela;
  case TipoForm of
    tfGrid:
    Begin
      TvTree.DataController.DataSource := nil;
      TvTree.DataController.KeyField := '';
      TvTree.DataController.ParentField := '';
    End;
    tfTree:
    Begin
      TvTree.DataController.DataSource := DataCadastro;
      TvTree.DataController.KeyField := CampoChave;
      TvTree.DataController.ParentField := 'codpai';
    End;
  end;
  if InfoSistema.SQLs.GetMySQL(TipoPesquisa,'').Versao20 then
    CriaObjsVerso20;
   if NovoReg   then
     actNovoExecute(nil);
   if EditReg  then
     actEditarExecute(nil); 

  
   
end;

function TfrmLstCadastroSimples.GetAlterando: Boolean;
begin
  Result := CdsCadastro.State in [dsEdit, dsInsert] ;
end;

function TfrmLstCadastroSimples.GetValorChave: String;
begin
  Result := CdsCadastro.FieldByName(CampoChave).AsString;
end;

procedure TfrmLstCadastroSimples.MudaEstado;
begin
  if not Alterando then
    CdsCadastro.Edit;
end;

function TfrmLstCadastroSimples.PodeExcluir: Boolean;
Var
  StrSQL : String;
begin
  StrSQL :=
    'SELECT SUM(QTD) QTD  '+
    '  FROM VW_DEPENDENCIAS('+QuotedStr(NomeTabela)+', '+CdsCadastro.FieldByName(CampoChave).AsString+')';
  Result := StrToIntDef(GetValorCds(StrSQL),0) = 0;
end;

procedure TfrmLstCadastroSimples.SetCampoCodigo(const Value: String);
begin
  FCampoCodigo := Value;
end;

procedure TfrmLstCadastroSimples.SetTipoForm(const Value: TTipoFormBasico);
begin
  FTipoForm := Value;
  case Value of
    tfGrid:
    Begin
      PageControl.ActivePage := tsGrid;
      btnNovo.DropdownMenu := nil;
      btnNovo.Style := tbsButton;
    End;
    tfTree:
    Begin
      PageControl.ActivePage := tsTree;
      btnNovo.DropdownMenu := PopNovoTree;
      btnNovo.Style := tbsDropDown;
    End;
  end;
end;

procedure TfrmLstCadastroSimples.SetUsaCampoCodigo(const Value: Boolean);
begin
  FUsaCampoCodigo := Value;
  edtCodigo.Visible := Value;
  if Value then
    edtCodigo.DataField :=CampoCodigo
  else
    edtCodigo.DataField := '';

end;


end.

