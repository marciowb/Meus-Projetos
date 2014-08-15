unit uObs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, StdCtrls, Buttons;

type
  TfrmOBS = class(TfrmPadrao)
    mmObs: TMemo;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOBS: TfrmOBS;

implementation

{$R *.dfm}

procedure TfrmOBS.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmOBS.btnOkClick(Sender: TObject);
begin
  inherited;
  ModalResult :=mrOk;
end;

end.
