unit Lst_Textos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroPadrao, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, Menus, ImgList, ActnList,
  DBClient, StdCtrls, Mask, DBCtrls, LabelDBEdit, Buttons, cxSplitter, ComCtrls,
  ToolWin, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls,
  JvExControls, JvEnterTab, cxContainer, cxTextEdit, cxMemo, cxDBEdit,
  JvExForms, JvScrollBox;

type
  TfrmLst_Textos = class(TfrmLst_CadastroPadrao)
    JvScrollBox1: TJvScrollBox;
    GroupBox1: TGroupBox;
    edtTitulo1: TLabelDBEdit;
    GroupBox2: TGroupBox;
    Texto1: TcxDBMemo;
    GroupBox3: TGroupBox;
    LabelDBEdit1: TLabelDBEdit;
    GroupBox4: TGroupBox;
    cxDBMemo1: TcxDBMemo;
    GroupBox5: TGroupBox;
    LabelDBEdit2: TLabelDBEdit;
    GroupBox6: TGroupBox;
    cxDBMemo2: TcxDBMemo;
    GroupBox7: TGroupBox;
    LabelDBEdit3: TLabelDBEdit;
    GroupBox8: TGroupBox;
    cxDBMemo3: TcxDBMemo;
    GroupBox9: TGroupBox;
    LabelDBEdit4: TLabelDBEdit;
    GroupBox10: TGroupBox;
    cxDBMemo4: TcxDBMemo;
    GroupBox11: TGroupBox;
    LabelDBEdit5: TLabelDBEdit;
    GroupBox12: TGroupBox;
    cxDBMemo5: TcxDBMemo;
    vListaColumn1: TcxGridDBColumn;
    vListaColumn2: TcxGridDBColumn;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Textos: TfrmLst_Textos;

implementation

uses uDMConexao_Pan, Comandos_Pan, Classes_Pan;

{$R *.dfm}

procedure TfrmLst_Textos.btnGravarClick(Sender: TObject);
begin
  VerificaEdit(CdsCadastro, edtCodigo, 'Esse código já existe', 'Infome o código');
  VerificaEdit(CdsCadastro, edtDescricao, 'Essa descrição já existe', 'Infome a descrição');
  inherited;

end;

procedure TfrmLst_Textos.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa :=  tpTextos;
  UsaCodigo := True;
end;

end.
