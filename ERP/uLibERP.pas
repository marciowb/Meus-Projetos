unit uLibERP;

interface
    Uses MinhasClasses, uSQLERP,Comandos,Classes,
         SysUtils, Math, EditPesquisa,pFIBClientDataSet,DB;
   type
     TRotinasPesquisa = class
       class procedure ConfiguraPesquisaFuncionario(var Edit : TEditPesquisa; aDataSet : TpFIBClientDataSet; aCampoData :String = '');
     end;

    TipoCampoChave = String;
    TTipoMovimento = (tmProduto,tmPatrimonio,tmEquipamento);

    TTIpoIPI = (iIPIAliq, iIPIValor);

    TTipoTransporte = (ttMaritima,ttFluvial,ttLacustre,ttAerea,ttPostal,ttFerroviaria,ttRodoviaria,ttConduto_Rede_Transmissao,ttMeios_Proprios,
                       ttEntrada_Ou_Saida_ficta);

    TTipoIntermedio= (tiImportacao_por_conta_propria,tiImportacao_por_conta_e_ordem,tiImportacao_por_encomenda);
    TTipoFrete = (tfEmitente,tfDestinatario, tfTerceiros);


     

    Function TipoCampoChaveToStr(Valor: TipoCampoChave): String;
const
   SemID: TipoCampoChave = '-1';
implementation

uses uForms;

{ TRotinasPesquisa }

class procedure TRotinasPesquisa.ConfiguraPesquisaFuncionario(
  var Edit: TEditPesquisa; aDataSet: TpFIBClientDataSet; aCampoData: String);
var
  IdFuncionario: String;
begin
   ConfiguraEditPesquisa(Edit,aDataSet,tpERPFuncionario,True,'','','CODIGO',aCampoData);
   IdFuncionario :=
      GetValorCds(tpERPFuncionario,'f.idusuario = '+IntToStr(USuarioLogado.Id),'idfuncionario');
   if aDataSet<> nil then
   begin
     if aDataSet.State in [dsEdit, dsInsert] then
       if aDataSet.FieldByName(Edit.CampoData).AsString = '' then
          aDataSet.FieldByName(Edit.CampoData).AsString := IdFuncionario;
   end else
    Edit.ValorChave := IdFuncionario;
   Edit.Localiza;
end;

Function TipoCampoChaveToStr(Valor: TipoCampoChave): String;
begin
   Result := GetStr(Valor);
end;

end.
