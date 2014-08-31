unit Cadastro_Pai_Pan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExControls, JvEnterTab, Buttons,
  JvgSpeedButton, ImgList, cxGraphics, ActnList, Menus, cxLookAndFeelPainters,
  StdCtrls, cxButtons, DB, DBClient,  JvButton,
  JvTransparentButton, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZSqlUpdate, Mask, DBCtrls, StrUtils, JvMenus, ComCtrls, ToolWin,
  uFormPadrao_Pan,Classes_Pan;

type
  TTipoPasso=(ttpPrimeiro, ttpUltimo, ttpProximo, ttpAnterior);
  TfrmCadastro_Pai_Pan = class(TfrmPadrao)
    ActionList1: TActionList;
    actPrimeiro: TAction;
    actAnterior: TAction;
    actProximo: TAction;
    cxImageList1: TcxImageList;
    actUltimo: TAction;
    actNovo: TAction;
    actEditar: TAction;
    actGravar: TAction;
    actCancelar: TAction;
    actDeletar: TAction;
    actImprimir: TAction;
    actPesquisar: TAction;
    actSair: TAction;
    DataCadastro: TDataSource;
    CdsCadastro: TClientDataSet;
    PopupMenu1: TPopupMenu;
    ToolBar2: TToolBar;
    ToolButton4: TToolButton;
    actMenu: TAction;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    cxImageList3: TcxImageList;
    Novo1: TMenuItem;
    Editar1: TMenuItem;
    Gravar1: TMenuItem;
    Cancelar1: TMenuItem;
    Pesquisar1: TMenuItem;
    Excluir1: TMenuItem;
    Imprimir1: TMenuItem;
    Sair1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure actPrimeiroExecute(Sender: TObject);
    procedure actAnteriorExecute(Sender: TObject);
    procedure actProximoExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actMenuExecute(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
  private
    FNomeTabela: String;
    FNomeChave: String;
    FTipoPesquisa: TTipoPesquisa;
    TipoAlteracao : TTipoAlteracao;
    FValorChave: String;
    FNovoReg: Boolean;
    FEditaReg: Boolean;
    procedure SetValorChave(const Value: String);
    procedure SetNovoReg(const Value: Boolean);
    procedure SetEditaReg(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    Property NomeTabela : String read FNomeTabela write FNomeTabela;
    Property NomeChave : String read FNomeChave write FNomeChave;
    Property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write FTipoPesquisa;
    Procedure ExcutaPasso(TipoPasso : TTipoPasso);
    Property ValorChave : String read FValorChave write SetValorChave;
    Procedure AtuReg;
    property NovoReg : Boolean read FNovoReg write SetNovoReg;
    property EditaReg: Boolean read FEditaReg write SetEditaReg;
  end;

var
  frmCadastro_Pai_Pan: TfrmCadastro_Pai_Pan;

implementation

uses  Comandos_Pan, uDMConexao_Pan, uPesquisa_PAN;



{$R *.dfm}

procedure TfrmCadastro_Pai_Pan.actAnteriorExecute(Sender: TObject);
begin
  ExcutaPasso(ttpAnterior);
end;

procedure TfrmCadastro_Pai_Pan.actCancelarExecute(Sender: TObject);
begin
  CdsCadastro.Cancel;
end;

procedure TfrmCadastro_Pai_Pan.actDeletarExecute(Sender: TObject);
begin
  if ConfirmaDel then
  Begin
    TipoAlteracao := taDeleta;
    Try
      StartTrans;
      AlteraBanco(taDeleta, CdsCadastro, FNomeTabela, FNomeChave);
      Commit;
      CdsCadastro.Delete;
    Except
      on e : Exception do
      Begin
        RollBack;
        Raise;
      End;
    End;
  End;
end;

procedure TfrmCadastro_Pai_Pan.actEditarExecute(Sender: TObject);
begin
  CdsCadastro.Edit;
  TipoAlteracao := taModifica;
end;

procedure TfrmCadastro_Pai_Pan.actGravarExecute(Sender: TObject);
begin
  inherited;
  CdsCadastro.Post;
  AlteraBanco(TipoAlteracao, CdsCadastro, FNomeTabela, FNomeChave);
end;

procedure TfrmCadastro_Pai_Pan.actImprimirExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmCadastro_Pai_Pan.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actPrimeiro.Enabled := (CdsCadastro.Active) and
                         (CdsCadastro.RecordCount > 0 ) and
                         (CdsCadastro.State = dsBrowse);

  actAnterior.Enabled := (CdsCadastro.Active) and
                         (CdsCadastro.State = dsBrowse);


  actProximo.Enabled := actAnterior.Enabled;
  actUltimo.Enabled := actPrimeiro.Enabled;
  actNovo.Enabled :=  (CdsCadastro.Active) and
                      (CdsCadastro.State = dsBrowse);

  actEditar.Enabled := actPrimeiro.Enabled;
  actDeletar.Enabled := actPrimeiro.Enabled;
  actPesquisar.Enabled := actPrimeiro.Enabled;
  actImprimir.Enabled := actPrimeiro.Enabled;
  actGravar.Enabled := (CdsCadastro.Active) and
                       (CdsCadastro.State in [dsEdit, dsInsert]);

  actCancelar.Enabled := actGravar.Enabled;

end;

procedure TfrmCadastro_Pai_Pan.actMenuExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCadastro_Pai_Pan.actNovoExecute(Sender: TObject);
begin
  CdsCadastro.Append;
  TipoAlteracao := taInsere;
end;

procedure TfrmCadastro_Pai_Pan.actPesquisarExecute(Sender: TObject);
var
  vAfter : TDataSetNotifyEvent;
begin
  frmPesquisa := TfrmPesquisa.Create(Self);
  Try
    with frmPesquisa do
    Begin
      TipoPesquisa := FTipoPesquisa;
      if ShowModal = mrOk then
      Begin
        vAfter := CdsCadastro.AfterScroll;
        CdsCadastro.DisableControls;
        CdsCadastro.AfterScroll := nil;
        CdsCadastro.Locate(NomeChave, CdsPesquisa.FieldByName(NomeChave).Value , [] );
        if Assigned(vAfter) then
           vAfter(CdsCadastro);
        CdsCadastro.EnableControls;
      End;
      
    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;
end;

procedure TfrmCadastro_Pai_Pan.actPrimeiroExecute(Sender: TObject);
begin
  inherited;
  ExcutaPasso(ttpPrimeiro);
end;

procedure TfrmCadastro_Pai_Pan.actProximoExecute(Sender: TObject);
begin
  ExcutaPasso(ttpProximo);
end;

procedure TfrmCadastro_Pai_Pan.actSairExecute(Sender: TObject);
begin
 if CdsCadastro.State in [dsInsert, dsEdit] then
 Begin
   Avisa('Grave ou cancele as alterações.');
   Exit;
 End;
 Close;
end;

procedure TfrmCadastro_Pai_Pan.actUltimoExecute(Sender: TObject);
begin
  inherited;
  ExcutaPasso(ttpUltimo);
end;

procedure TfrmCadastro_Pai_Pan.AtuReg;
var
  Str : String;
begin
  Str := FNomeChave + ' = '+ FValorChave;
//  Atu_Cds(CdsCadastro, GetSQLPesquisa(TipoPesquisa, Str) );
end;

procedure TfrmCadastro_Pai_Pan.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
//  CdsCadastro.FieldByName(NomeChave).AsString := GetCodigo(NomeTabela, NomeChave, ttcChave);
end;

procedure TfrmCadastro_Pai_Pan.ExcutaPasso(TipoPasso: TTipoPasso);
var
  StrSQL : String;
begin
  case TipoPasso of
     ttpPrimeiro :
       Begin
         StrSQl :=
           'select MIN('+FNomeChave+') CHAVE'+
           '   from '+FNomeTabela +
           '   limit 1'   ;

       End;
     ttpUltimo :
       Begin
         StrSQl :=
           'select MAX('+FNomeChave+') CHAVE'+
           '   from '+FNomeTabela +
           '   limit 1'   ;
       End;

     ttpProximo:
       Begin
         StrSQL :=
           'select '+FNomeChave+ ' CHAVE '+
           '   from '+FNomeTabela +
           '   Where '+FNomeChave +' > '+CdsCadastro.FieldByName(FNomeChave).AsString   +
           '   limit 1 ';


       End;
     ttpAnterior:
       Begin
         StrSQL :=
           'select '+FNomeChave+ ' CHAVE '+
           '   from '+FNomeTabela +
           '   Where '+FNomeChave +' < '+CdsCadastro.FieldByName(FNomeChave).AsString   +
           '   limit 1 ';
       End;
  end;
  FValorChave := GetValorCds(StrSQL);
  FValorChave := IfThen(Trim(FValorChave) <> '', FValorChave, '0');
  AtuReg;

end;

procedure TfrmCadastro_Pai_Pan.FormShow(Sender: TObject);
begin
  inherited;   

  actPrimeiroExecute(nil);
end;

procedure TfrmCadastro_Pai_Pan.SetEditaReg(const Value: Boolean);
begin
  FEditaReg := Value;
end;

procedure TfrmCadastro_Pai_Pan.SetNovoReg(const Value: Boolean);
begin
  FNovoReg := Value;
end;

procedure TfrmCadastro_Pai_Pan.SetValorChave(const Value: String);
begin
  FValorChave := Value;
end;

end.
