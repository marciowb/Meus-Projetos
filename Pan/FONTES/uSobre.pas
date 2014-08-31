unit uSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvComponentBase, JvComputerInfoEx, ShellAPI,
  Buttons, JvExControls, JvLinkLabel, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxHyperLinkEdit, uFormPadrao_Pan, JvEnterTab, JvSysRequirements;

type
  TfrmSobre = class(TfrmPadrao)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    lblLocal: TLabel;
    lblVersao: TLabel;
    GroupBox2: TGroupBox;
    lblTel: TLabel;
    lblEmail: TLabel;
    Label2: TLabel;
    lblSistema: TLabel;
    lblHost: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmSobre: TfrmSobre;
  Computer : TJvComputerInfoEx;
implementation

uses uDMConexao_Pan, Comandos_Pan;

{$R *.dfm}

procedure TfrmSobre.FormShow(Sender: TObject);
begin
  Computer := TJvComputerInfoEx.Create(Self);
  lblLocal.Caption := 'Local do executável: '+ ExtractFilePath(Application.ExeName);
  lblVersao.Caption := 'Versão: '+GetBuildInfo(False, Application.ExeName);
  lblSistema.Caption := 'S.O. : '+Computer.OS.ProductName+'  '+ Computer.OS.VersionCSDString;
  lblHost.Caption := 'Local do banco de dados: '+DMConexao.Conexao.HostName;

end;



end.
