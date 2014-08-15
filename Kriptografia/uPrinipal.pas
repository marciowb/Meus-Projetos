unit uPrinipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,StrUtils;

type
  TfrmPrincipal = class(TForm)
    edtKrip: TEdit;
    Button1: TButton;
    Button2: TButton;
    edtDekrip: TEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    mmResultado: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Comandos;

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  mmResultado.Text := KriptaStr(edtKrip.Text)
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  mmResultado.Text := DeKriptaStr(edtDekrip.Text);
end;

end.
