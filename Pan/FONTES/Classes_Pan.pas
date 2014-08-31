unit Classes_Pan;

interface
 type
   TUserLogado = record
      Login : String;
      IdLoja : Integer;
      NomeMaquina : String;
      Id : Integer;
   end;

  TTipoCampo = (tcString , tcReal, tcMoeda, tcInt, tcLogico, tcData,tcCEP, tcCNPJ, tcCPF, tcHora);
  TTipoAuditoria = (tAudIncercao, tAudExclusao, tAudModificacao);

  TTipoPesquisa=(tpProduto, tpCliente, tpSaida, tpClasse, tpTextos);
                 
  TTipoAlteracao = (taInsere, taModifica, taDeleta);
  TTipoPermissao = (ttpInclui, ttpAltera, ttpDeleta);

  TTipoCfgKimera = (tkGeral, tkCaracteresEspeciais, tkAutoEdit);

  TTipoChave = (ttcChave, ttcCodigo);

  Const
    MascaraCNPJ = '99.999.999/9999-99;0;_';
    MascaraCPF = '999.999.999-99;0;_';
    MascaraCEP = '99999-999;0;_';
    MascaraData = '!99/99/9999;1;_';
    MascaraFloat = '0000.00;0000.00';
    {$Region 'Permissões'}
 Const
   //Resultado
     pHabilitado = 0;
     pDesabilitado = 1;
     pEscondido = 2;
   //Padrão
      perAcessar = 0;
      perIncluir = 1;
      perAlterar = 2;
      perExcluir = 3;
 {$EndRegion}

 
  {$Region 'Constantes de CFG'}
    Const
       {$Region 'Geral'}
          rCodCFGGeral = '100000';
          rCodCfgGHabilitaAutoEdit = '100100';
          rCodCfgGTipoCaracteres = '100200';
          rCodGEmpresaPadrao = '100300';
       {$EndRegion}
       rcodCFGEstoque = '200000';
       rCodCFGCadastro = '300000';
       rCodCFGPontoVenda = '400000';
       rCodCFGPreVenda = '500000';
       
  {$EndRegion}



 {$Region 'IDForm'}
    Const
      idFrmPadrao = 1000000000;
      idFrmAuditoria =1000000001;
      idFrmPesquisa = 1000000002;      
      idFrmLstCadastroPai = 1000001000;
      idFrmLstSecao = 1000001001;
      idFrmLstLaboratorio = 1000001002;
      idFrmLstPrincipio = 1000001003;
      idFrmLstCfop = 1000001004;
      idFrmLstTipoPessoa = 1000001005;
      idFrmLstCampoUsuario = 1000001006;
      idFrmCadastroPai = 1000002000;
      idFrmCadastroEmpresa = 1000002001;
      idFrmCadastroPessoa = 1000002002;
      

 {$EndRegion}

 {$Region 'IDArche'}
 Const
    iaEmpresa = 1000000000;
    iaCFOP    = 1000000001;

 {$EndRegion}
 {$Region 'Entidades'}
 Const
      entProduto = 'PRODUTO';
 {$EndRegion}


implementation
   uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms;

end.
