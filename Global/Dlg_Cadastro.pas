unit Dlg_Cadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  pFIBClientDataSet, Mask, DBCtrls, LabelDBEdit;

type
  TfrmDlg_Cadastro = class(TfrmPadrao)
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    Panel2: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FFechaEGrava: Boolean;
    FpDataSet: TpFIBClientDataSet;
    { Private declarations }
  public
    { Public declarations }
    property FechaEGrava: Boolean read FFechaEGrava write FFechaEGrava;
    property pDataSet : TpFIBClientDataSet read FpDataSet write FpDataSet;
  end;

var
  frmDlg_Cadastro: TfrmDlg_Cadastro;

implementation

{$R *.dfm}

procedure TfrmDlg_Cadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ActiveControl := nil;
  if (pDataSet <> nil) and (pDataSet.State in [dsInsert, dsEdit]) then
   pDataSet.Cancel;
  ModalResult := mrCancel;


end;

procedure TfrmDlg_Cadastro.btnOkClick(Sender: TObject);
begin
  if (pDataSet <> nil) and (pDataSet.State in [dsInsert, dsEdit]) then
    pDataSet.Post;

  if FechaEGrava then
    ModalResult := mrOk
  else Begin
    ModalResult := mrNone;
    pDataSet.Append;
    SelectFirst ;
  End;
end;

procedure TfrmDlg_Cadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if (pDataSet <> nil) and (pDataSet.State in [dsInsert, dsEdit]) then
   pDataSet.Cancel;
end;

procedure TfrmDlg_Cadastro.FormCreate(Sender: TObject);
begin
  inherited;
  FechaEGrava := True;
//  FDataSet := TClientDataSet.Create(nil);
end;

end.
