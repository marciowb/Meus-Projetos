unit Lst_Cadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroPadrao, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxContainer, cxTextEdit,
  cxMaskEdit, cxSpinEdit, cxDBEdit, StdCtrls, Menus, ImgList, ActnList,
  DBClient, Mask, DBCtrls, LabelDBEdit, Buttons, cxSplitter, ComCtrls, ToolWin,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, JvExControls, JvEnterTab,
  cxDropDownEdit, cxCalc, cxMemo;

type
  TTipoForm = (tfCliente, tfProduto, tfClasse);
  TfrmLst_Cadastro = class(TfrmLst_CadastroPadrao)
    pnlDIas: TPanel;
    Label1: TLabel;
    edtDias: TcxDBSpinEdit;
    edtNumOnu: TLabelDBEdit;
    edtUN: TLabelDBEdit;
    actCalc: TAction;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    procedure actCalcExecute(Sender: TObject);
  private
    FTipoForm: TTipoForm;
    procedure SetTipoForm(const Value: TTipoForm);
    { Private declarations }
  public
    { Public declarations }
    property TipoForm : TTipoForm read FTipoForm write SetTipoForm;
  end;

var
  frmLst_Cadastro: TfrmLst_Cadastro;

implementation

uses Classes_Pan, uPesquisa_PAN, Comandos_Pan;

{$R *.dfm}

{ TfrmLst_CadastroPadrao1 }


procedure TfrmLst_Cadastro.actCalcExecute(Sender: TObject);
begin
  inherited;
  winexec('calc.exe', SW_NORMAL);
end;

procedure TfrmLst_Cadastro.SetTipoForm(const Value: TTipoForm);
begin
  FTipoForm := Value;
  edtCodigo.DataField := 'CODIGO';
  UsaCodigo := True;
  case Value of
   tfCliente:
     Begin
       Self.Caption := 'Cadastro de cliente';
       edtDescricao.Titulo.Caption := 'Nome do cliente';
       edtDescricao.DataField := 'NOMECLIENTE';
       TipoPesquisa := tpCliente;
       MontaGrid(TvLista, 'CODIGO', 'Código', tcString, 80);
       MontaGrid(TvLista, 'NOMECLIENTE', 'Cliente', tcString, 250);
     End;
   tfProduto:
     Begin
       Self.Caption := 'Cadastro de produtos';
       edtDescricao.Titulo.Caption := 'Nome do produto';
       edtDescricao.DataField := 'NOMEPRODUTO';
       edtDescricao.CharCase := ecUpperCase;
       edtNumOnu.DataField := 'NUMONU';
       edtUN.DataField := 'UNIDADE';
       TipoPesquisa := tpProduto;
       pnlDIas.Visible := True;
       edtDias.DataBinding.DataField := 'DIASVALIDADE';
       MontaGrid(TvLista, 'CODIGO', 'Código', tcString, 80);
       MontaGrid(TvLista, 'NOMEPRODUTO', 'Produto', tcString, 250);
       actCalc.Enabled := True;
       actCalc.Visible := True;
     End;
   tfClasse :
     Begin
       UsaCodigo := False;
       Self.Caption := 'Classe de risco';
       edtCodigo.Titulo.Caption := 'Classe';
       edtCodigo.DataField := 'CLASSE';
       edtDescricao.Visible := False;
       edtDescricao.Titulo.Visible := False;
       TipoPesquisa := tpClasse;
       MontaGrid(TvLista, 'CLASSE', 'Classe', tcString, 80);
     End;
  end;
end;



end.
