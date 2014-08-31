unit Cad_Produto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, ImgList, cxGraphics, ActnList, ToolWin, ComCtrls,
  JvExControls, JvEnterTab, ExtCtrls, StdCtrls, Mask, DBCtrls, LabelDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, cxDBEdit;

type
  TfrmCad_Produto = class(TfrmPadrao)
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Panel1: TPanel;
    edtCodigo: TLabelDBEdit;
    edtProduto: TLabelDBEdit;
    edtDias: TcxDBSpinEdit;
    Label1: TLabel;
    edtNumOnu: TLabelDBEdit;
    edtUN: TLabelDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Produto: TfrmCad_Produto;

implementation

{$R *.dfm}

end.
