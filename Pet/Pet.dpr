program Pet;

{$R 'DevExpress.res'}

uses
  Forms,
  uPrincipalPet in 'uPrincipalPet.pas' {frmPrincipalPet},
  MinhasClasses in '..\Global\MinhasClasses.pas',
  uFormPadrao in '..\Global\uFormPadrao.pas' {frmPadrao},
  Comandos in '..\Global\Comandos.pas',
  uSQL in '..\Global\uSQL.pas',
  Cad_CadastroPai in '..\Global\Cad_CadastroPai.pas' {frmCad_CadastroPai},
  Dlg_Cadastro in '..\Global\Dlg_Cadastro.pas' {frmDlg_Cadastro},
  Lst_CadastroSimples in '..\Global\Lst_CadastroSimples.pas' {frmLstCadastroSimples},
  uCad_Licenca in '..\Global\uCad_Licenca.pas' {frmCad_Licenca},
  UCfgPadrao in '..\Global\UCfgPadrao.pas',
  uConfiguracoes in '..\Global\uConfiguracoes.pas',
  UdlgRelatorioPadrao in '..\Global\UdlgRelatorioPadrao.pas' {frmdlgRelatorioPadrao},
  UDmConexao in '..\Global\UDmConexao.pas' {DMConexao: TDataModule},
  uDmRelatorio in '..\Global\uDmRelatorio.pas' {DmRelatorio: TDataModule},
  uLibLicenca in '..\Global\uLibLicenca.pas',
  uLista_Layouts in '..\Global\uLista_Layouts.pas' {frmLista_Layouts},
  uListagemPadrao in '..\Global\uListagemPadrao.pas' {frmListagemPadrao},
  uPesquisa_kimera in '..\Global\uPesquisa_kimera.pas' {frmPesquisa},
  uPrincipalPadrao in '..\Global\uPrincipalPadrao.pas' {frmPrincipalPadrao},
  uLibPet in 'uLibPet.pas',
  Cad_CEP in 'Cad_CEP.pas' {frmCad_CEP},
  uSQLPet in 'uSQLPet.pas',
  Lst_CategoriaAnimal in 'Lst_CategoriaAnimal.pas' {frmLst_CategoriaAnimal},
  Lst_FormaPagamento in 'Lst_FormaPagamento.pas' {frmLst_FormaPagamento},
  Lst_Profissional in 'Lst_Profissional.pas' {frmLst_Profissional},
  Lst_Raca in 'Lst_Raca.pas' {frmLst_Raca},
  Lst_Empresa in 'Lst_Empresa.pas' {frmLst_Empresa},
  Lst_Usuario in 'Lst_Usuario.pas' {frmLst_Usuario},
  uTabelaPreco in 'uTabelaPreco.pas' {frmTabelaPreco},
  Cad_Cliente in 'Cad_Cliente.pas' {frmCad_Cliente},
  Cad_Animal in 'Cad_Animal.pas' {frmCad_Animal},
  uAgenda in 'uAgenda.pas' {frmAgenda},
  Cad_Agenda in 'Cad_Agenda.pas' {frmCad_Agenda},
  uVenda in 'uVenda.pas' {frmVenda},
  uFechamento in 'uFechamento.pas' {frmFechamento},
  uObs in '..\Global\uObs.pas' {frmOBS},
  uLst_Servicos in 'uLst_Servicos.pas' {frmLst_Servicos},
  Cad_Servico in 'Cad_Servico.pas' {frmCad_Servico},
  Cad_Item in 'Cad_Item.pas' {frmCad_Itens},
  Lst_Caixa in 'Lst_Caixa.pas' {frmLst_Caixa},
  Cad_Caixa in 'Cad_Caixa.pas' {frmCad_Caixa},
  uLogin in 'uLogin.pas' {frmLogin},
  uRelServicos in 'uRelServicos.pas' {frmRelServicos},
  uRelClientes in 'uRelClientes.pas' {frmRelClientes},
  uRelCaixa in 'uRelCaixa.pas' {frmRelCaixa},
  uPesquisaAnimal in 'uPesquisaAnimal.pas' {frmPesquisaAnimal},
  uLst_ContasReceber in 'uLst_ContasReceber.pas' {frmLstContasReceber},
  Cad_ContaReceber in 'Cad_ContaReceber.pas' {frmCad_ContaReceber},
  uLebrete in 'uLebrete.pas' {fraLebrete: TFrame},
  uMetodosRB in '..\Global\uMetodosRB.pas',
  uRelContas in 'uRelContas.pas' {frmRelContasReceber},
  uQuitaConta in 'uQuitaConta.pas' {frmDlg_QuitaConta},
  uLstFechamentoDia in 'uLstFechamentoDia.pas' {frmLst_FechamentoDia};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Pet';
  InfoSistema.LocalBancoDados := 'D:\Meus Projetos\Bancos\Pet.fdb';
  InfoSistema.NomeBanco :='Pet.fdb';
  InfoSistema.UsaBancoDados := True;
  InfoSistema.Sistema := sPet;
  InfoSistema.VerificaLicenca := True; { TODO : Mudar antes de implantar }
  InfoSistema.SQLs := TSQLPet.Create;


  if Entra then
  Begin
    Application.CreateForm(TfrmPrincipalPet, frmPrincipalPet);
  Application.Run;
  End else
  Begin
    Application.ProcessMessages;
    DMConexao.Free;
    DMConexao := nil;
    Application.Terminate;
  End;
end.
