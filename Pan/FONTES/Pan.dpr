program Pan;

uses
  Forms,
  Classes_Pan in 'Classes_Pan.pas',
  uDMConexao_Pan in 'uDMConexao_Pan.pas' {DMConexao: TDataModule},
  Cad_Saida in 'Cad_Saida.pas' {frmCad_Saida},
  Comandos_Pan in 'Comandos_Pan.pas',
  uSobre in 'uSobre.pas' {frmSobre},
  uLincenca in 'uLincenca.pas' {frmLincenca},
  Cadastro_Pai_PAN in 'Cadastro_Pai_PAN.pas' {frmCadastro_Pai_Pan},
  uPesquisa_PAN in 'uPesquisa_PAN.pas' {frmPesquisa},
  Cad_Produto in 'Cad_Produto.pas' {frmCad_Produto},
  uPrincipal_Pan in 'uPrincipal_Pan.pas' {frmPrincipal},
  Lst_Cadastro in 'Lst_Cadastro.pas' {frmLst_Cadastro},
  Lst_Textos in 'Lst_Textos.pas' {frmLst_Textos},
  Lst_CadastroPadrao in 'Lst_CadastroPadrao.pas' {frmLst_CadastroPadrao},
  Dlg_Regiao in 'Dlg_Regiao.pas' {frmDlgRegiao},
  uFormPadrao_Pan in 'uFormPadrao_Pan.pas' {frmPadrao},
  uSplash in 'uSplash.pas' {frmSplash},
  SQLConsole in 'SQLConsole.pas' {frmSQLConsole};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PAN';
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
