unit uAuxConexao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, ExtCtrls, Spin, Buttons;

type
  TfrmAuxCOnexao = class(TfrmPadrao)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtHost: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    edtPorta: TSpinEdit;
    Label1: TLabel;
    edtSenha: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAuxCOnexao: TfrmAuxCOnexao;

implementation

{$R *.dfm}

end.
