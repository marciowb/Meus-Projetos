unit uLibPet;

interface
   Uses
     SysUtils, Windows,Classes,Controls,IniFiles, MinhasClasses,Forms,
     Lst_CadastroSimples,DB,DBClient, pFIBClientDataSet,USQL, EditPesquisa;
  type
    TClassePadrao = class
       Procedure AbreEditPesquisaAimal(Sender : TObject;ADataSet : TDataSet; aTipoPesquisa: Integer; Titulo : String; Out Resultado : Variant);
    end;
   Function CriaCadastroSimples(aTipoPesquisa: TTipoPesquisa; Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroEspecie(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroTipoServico(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroCategoriaAnimal(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroFormaPagamento(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroProfissional(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroRaca(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroEmpresa(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroUSuario(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbreCadastroCliente(Inclui: Boolean = False; Edita: Boolean = False;IdCliente: Integer = -1): Integer;
   Function AbreCadastroAnimal(Inclui: Boolean = False; Edita: Boolean = False; pIdCliente: Integer = -1;IdAnimal: Integer = -1): Integer;
   Procedure ABreVenda(idAgenda: Integer =-1);
   Procedure AbreLstServico(IdServico :INteger = -1);
   Procedure ABreCaixa(IdServico :Integer = -1);
   Procedure ABreRelServico;
   Function Entra: Boolean;
   Function Imp_ReciboPet(IdEmpresa,IdServico: Integer; Tratamento: TTratamentoLayout = tlImpressora): Integer;
   Function AbreCadastroGrupo(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Function AbrePesquisaAnimal(pWr : String =''): Integer;
   Procedure AbreRelContasReceber;
var
  vPesq : TClassePadrao;

implementation

uses Lst_CategoriaAnimal, Lst_FormaPagamento, Lst_Profissional, Lst_Raca,
  Lst_Empresa, Lst_Usuario, Cad_Cliente, Cad_Animal, uVenda, uLst_Servicos,
  Lst_Caixa, uLogin, UDmConexao, uRelServicos, uLista_Layouts, Comandos,
  uPesquisaAnimal, uRelContas;


   Function CriaCadastroSimples(aTipoPesquisa: TTipoPesquisa; Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := -1;
     with TfrmLstCadastroSimples.Create(Application) do
     Begin
       TipoPesquisa := aTipoPesquisa;
       NovoReg := Inclui;
       EditReg := Edita;
       if ShowModal = mrOk Then
         Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
     End;
   End;

   Function AbreCadastroEspecie(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := CriaCadastroSimples(tpPetTipoAnimal,Inclui,Edita);
   End;

   Function AbreCadastroTipoServico(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := CriaCadastroSimples(tpPetTipoServico,Inclui,Edita);
   End;

   Function AbreCadastroCategoriaAnimal(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := -1;
     frmLst_CategoriaAnimal := TfrmLst_CategoriaAnimal.Create(nil);
     Try
       with frmLst_CategoriaAnimal do
       begin
         NovoReg := Inclui;
         EditReg := Edita;
         if ShowModal = mrOk then
           Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
       end;

     Finally
       FreeAndNil(frmLst_CategoriaAnimal);
     End;
   End;

   Function AbreCadastroFormaPagamento(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := -1;
     frmLst_FormaPagamento := TfrmLst_FormaPagamento.Create(nil);
     Try
       with frmLst_FormaPagamento do
       begin
         NovoReg := Inclui;
         EditReg := Edita;
         if ShowModal = mrOk then
           Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
       end;

     Finally
       FreeAndNil(frmLst_FormaPagamento);
     End;

   End;

   Function AbreCadastroProfissional(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := -1;
     frmLst_Profissional := TfrmLst_Profissional.Create(nil);
     Try
       with frmLst_Profissional do
       begin
         NovoReg := Inclui;
         EditReg := Edita;
         if ShowModal = mrOk then
           Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
       end;

     Finally
       FreeAndNil(frmLst_Profissional);
     End;

   End;

   Function AbreCadastroRaca(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     frmLst_Raca := TfrmLst_Raca.Create(nil);
     Try
       with frmLst_Raca do
       begin
         NovoReg := Inclui;
         EditReg := Edita;
         if ShowModal = mrOk then
           Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
       end;

     Finally
       FreeAndNil(frmLst_Raca);
     End;

   End;

   Function AbreCadastroEmpresa(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     frmLst_Empresa := TfrmLst_Empresa.Create(nil);
     Try
       with frmLst_Empresa do
       begin
         NovoReg := Inclui;
         EditReg := Edita;
         if ShowModal = mrOk then
           Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
       end;

     Finally
       FreeAndNil(frmLst_Empresa);
     End;

   End;

   Function AbreCadastroUSuario(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     frmLst_Usuario := TfrmLst_Usuario.Create(nil);
     Try
       with frmLst_Usuario do
       begin
         NovoReg := Inclui;
         EditReg := Edita;
         if ShowModal = mrOk then
           Result := CdsCadastro.FieldByName(CampoChave).AsInteger;
       end;

     Finally
       FreeAndNil(frmLst_Usuario);
     End;

   End;

   Function AbreCadastroCliente(Inclui: Boolean = False; Edita: Boolean = False;IdCliente: Integer = -1): Integer;
   Begin
     if frmCad_Cliente = nil then
        frmCad_Cliente := TfrmCad_Cliente.Create(nil);

     if frmCad_Cliente.Showing then
       frmCad_Cliente.BringToFront
     else
     Begin
       frmCad_Cliente.NovoReg := Inclui;
       if IdCliente <> -1 then
         frmCad_Cliente.ValorChave :=IntToStr(IdCliente);
       frmCad_Cliente.EditReg := Edita;
       if Inclui or Edita then
       Begin
         frmCad_Cliente.ShowModal;
         Result := StrToInt(frmCad_Cliente.ValorChave);
       End else
         frmCad_Cliente.Show;


     End;

   End;

   Function AbreCadastroAnimal(Inclui: Boolean = False; Edita: Boolean = False; pIdCliente: Integer = -1;IdAnimal: Integer = -1): Integer;
   Begin
     if frmCad_Animal = nil Then
       frmCad_Animal := TfrmCad_Animal.Create(nil);
     if frmCad_Animal.Showing then
       frmCad_Animal.BringToFront
     else
     Begin
       frmCad_Animal.NovoReg := Inclui;
       if IdAnimal = -1 then
         frmCad_Animal.ValorChave := IntToStr(IdAnimal);
       frmCad_Animal.EditReg := Edita;
       frmCad_Animal.IdCliente := pIdCliente;
       if Inclui or Edita then
       Begin
         frmCad_Animal.ShowModal;
         Result := StrToInt(frmCad_Animal.ValorChave);
       End else
         frmCad_Animal.Show;

     End;

   End;

   Procedure ABreVenda(idAgenda: Integer =-1);
   Begin
     if frmVenda = nil then
       frmVenda := TfrmVenda.Create(nil);

     if frmVenda.Showing then
       frmVenda.BringToFront
     else
     Begin
       frmVenda.idAgenda := idAgenda;
       frmVenda.Show;
     End;


   End;

   Procedure AbreLstServico(IdServico :INteger = -1);
   Begin
     if frmLst_Servicos = nil Then
       frmLst_Servicos := TfrmLst_Servicos.Create(nil);
     if frmLst_Servicos.Showing then
       frmLst_Servicos.BringToFront
     else
       frmLst_Servicos.Show;
   End;

   Procedure ABreCaixa(IdServico :Integer = -1);
   Begin
     if frmLst_Caixa = nil then
       frmLst_Caixa := TfrmLst_Caixa.Create(nil);

     frmLst_Caixa.IdServico := IdServico;

     if frmLst_Caixa.Showing then
       frmLst_Caixa.BringToFront
     else
       frmLst_Caixa.Show;

   End;

   Function Entra: Boolean;
   var
     Ini: TIniFile;
     vFile: String;
   Begin
     frmLogin := TfrmLogin.Create(nil);
     Try
       vFile := ExtractFilePath(Application.ExeName)+'ConexaoPet.ini';
       Ini := TIniFile.Create(vFile);
       if not FileExists(vFile) then
       Begin
         Ini.WriteString('Conexao','Local', ExtractFilePath(Application.ExeName));
         Ini.WriteString('Conexao','Host', '127.0.0.1');
         Ini.UpdateFile;
       End;

       InfoSistema.LocalBancoDados :=  Ini.ReadString('Conexao','Local', ExtractFilePath(Application.ExeName));
       if InfoSistema.LocalBancoDados[Length(InfoSistema.LocalBancoDados)] <> '\' then
         InfoSistema.LocalBancoDados := InfoSistema.LocalBancoDados+'\';

       InfoSistema.LocalBancoDados :=InfoSistema.LocalBancoDados +'Pet.fdb';
       InfoSistema.Host :=  Ini.ReadString('Conexao','Host', '127.0.0.1');
       Application.CreateForm(TDMConexao, DMConexao);

       DMCOnexao.Conexao.Connected := False;

       DMCOnexao.Conexao.DBName := InfoSistema.Host+'/3050:'+InfoSistema.LocalBancoDados;
       DMCOnexao.Conexao.Connected := True;
     Finally
       Ini.Free;
     End;
     //DMCOnexao := TDMConexao.Create(nil);
     Result := False;
     if not frmLogin.AutoLogin then
     Begin
       if frmLogin.ShowModal = mrOk then
         Result := True;
     End else
       Result := True;
   End;

   Procedure ABreRelServico;
   Begin
     frmRelServicos := TfrmRelServicos.Create(nil);
     Try
       frmRelServicos.ShowModal;
     Finally
       FreeAndNil(frmRelServicos);
     End;
   End;

   Function Imp_ReciboPet(IdEmpresa,IdServico: Integer; Tratamento: TTratamentoLayout = tlImpressora): Integer;
  var
     CdsRecibo, CdsTabalhos, CdsEmpresa,CdsFP: TpFIBClientDataSet;
     StrSQL : String;
   Begin
     GravaRelatorio(IdRelComprovanteVendaPet,'Comprovante de venda');
     Result := -1;
     Try
       CdsRecibo := TpFIBClientDataSet.Create(nil);
       CdsTabalhos := TpFIBClientDataSet.Create(nil);
       CdsEmpresa := TpFIBClientDataSet.Create(nil);
       CdsFP     := TpFIBClientDataSet.Create(nil);
       SetCds(CdsRecibo, tpPetServico, 'S.IDSERVICO = '+IntToStr(IdServico));
       SetCds(CdsTabalhos, tpPetServicoDetalhe, 'S.IDSERVICO = '+IntToStr(IdServico));
       SetCds(CdsFP, GetSelect(tpPetServicoPagamentos)+'AND VALOR IS NOT NULL AND  SF.IDSERVICO  = '+IntToStr(IdServico));
       SetCds(CdsEmpresa,  GetSelect(tpPetEmpresa,' IDEMPRESA = '+IntToStr(IdEmpresa))) ;
       CdsFP.Name :='Recebimentos';
       CdsEmpresa.Name :='Empresa';
       if Tratamento <> tlLista  then
         ImprimeRelatorio(IdRelComprovanteVendaPet, CdsRecibo, CdsTabalhos, CdsEmpresa, Tratamento, [CdsFP,CdsEmpresa])
       else
       Begin
         frmLista_Layouts := TfrmLista_Layouts.Create(nil);
         Try
           with frmLista_Layouts do
           Begin
             CdsMaster := CdsRecibo;
             CdsDetalhe := CdsTabalhos;
             IdRelatorio := IdRelComprovanteVendaPet;
             SetLength(CdsExtras,2);
             CdsExtras[0] := CdsFP;
             CdsExtras[1] := CdsEmpresa;
             if ShowModal = mrOk Then
               Result := CdsLayout.FieldByName('IDLAYOUT').AsInteger;
           End;
         Finally
           FreeAndNil(frmLista_Layouts);
         End;
       End;
     Finally
       FreeAndNil(CdsRecibo);
       FreeAndNil(CdsTabalhos);
       FreeAndNil(CdsEmpresa);
       FreeAndNil(CdsFP);
     End;
   End;

   Function AbreCadastroGrupo(Inclui: Boolean = False; Edita: Boolean = False): Integer;
   Begin
     Result := CriaCadastroSimples(tpPetGrupo, Inclui, Edita);
   End;

   Function AbrePesquisaAnimal(pWr : String= ''): Integer;
   Begin
     frmPesquisaAnimal := TfrmPesquisaAnimal.Create(nil);
     Result := -1;
     Try
       with frmPesquisaAnimal do
       Begin
         wr := pwr;
         if ShowModal = mrOk then
           Result := cdsPesquisa.FieldByName('IDANIMAL').AsInteger;
       End;
     Finally
       FreeAndNil(frmPesquisaAnimal);
     End;
   End;
   Procedure TClassePadrao.AbreEditPesquisaAimal(Sender : TObject;ADataSet : TDataSet; aTipoPesquisa: Integer; Titulo : String; Out Resultado : Variant);
   Begin
      if (Sender as TEditPesquisa).DataSet <> nil Then
      Begin
        if not ((Sender as TEditPesquisa).DataSet.State in [dsInsert, dsEdit] )then
        Begin
          if (Sender as TEditPesquisa).DataSet.IsEmpty Then
            (Sender as TEditPesquisa).DataSet.Append
          else
            (Sender as TEditPesquisa).DataSet.Edit;
        End;
      End;

      Resultado := AbrePesquisaAnimal((Sender as TEditPesquisa).SQLComp);
   End;

   Procedure AbreRelContasReceber;
   Begin
      frmRelContasReceber := TfrmRelContasReceber.Create(nil);
      Try
        frmRelContasReceber.ShowModal;
      Finally
        FreeAndNil(frmRelContasReceber);
      End;
   End;

initialization
  vPesq := TClassePadrao.Create;

end.
