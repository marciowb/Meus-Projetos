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



     IImpostos = interface(IInterfaceMaster)
        procedure SetAliqICMS(const Value: Currency);
        procedure SetAliqISS(const Value: Currency);
        function GetAliqICMS: Currency;
        function GetAliqISS: Currency;
        procedure SetAliqCOFINS(const Value: Currency);
        procedure SetALiqCSLL(const Value: Currency);
        procedure SetAliqICMSST(const Value: Currency);
        procedure SetAliqIPI(const Value: Currency);
        procedure SetAliqPIS(const Value: Currency);
        procedure SetBaseCSLL(const Value: Currency);
        procedure SetBaseICMS_ISS(const Value: Currency);
        procedure SetBaseICMSST(const Value: Currency);
        procedure SetBaseIPI(const Value: Currency);
        procedure SetBasePIS_COFINS(const Value: Currency);
        procedure SetMVA(const Value: Currency);
        procedure SetTipoIPI(const Value: TTIpoIPI);
        procedure SetValorCSLL(const Value: Currency);
        procedure SetValorICMS_ISS(const Value: Currency);
        procedure SetValorICMSST(const Value: Currency);
        procedure SetValorIPI(const Value: Currency);
        procedure SetValorPIS_COFINS(const Value: Currency);
        function GetAliqCOFINS: Currency;
        function GetALiqCSLL: Currency;
        function GetAliqICMSST: Currency;
        function GetAliqIPI: Currency;
        function GetAliqPIS: Currency;
        function GetBaseCSLL: Currency;
        function GetBaseICMS_ISS: Currency;
        function GetBaseICMSST: Currency;
        function GetBaseIPI: Currency;
        function GetBasePIS_COFINS: Currency;
        function GetMVA: Currency;
        function GetTipoIPI: TTIpoIPI;
        function GetValorCSLL: Currency;
        function GetValorICMS_ISS: Currency;
        function GetValorICMSST: Currency;
        function GetValorIPI: Currency;
        function GetValorPIS_COFINS: Currency;

        property AliqICMS: Currency read GetAliqICMS write SetAliqICMS;
        property AliqISS: Currency read GetAliqISS write SetAliqISS;
        property AliqPIS: Currency read GetAliqPIS write SetAliqPIS;
        property AliqCOFINS: Currency read GetAliqCOFINS write SetAliqCOFINS;
        property AliqIPI: Currency read GetAliqIPI write SetAliqIPI;
        property TipoIPI: TTIpoIPI read GetTipoIPI write SetTipoIPI;
        property MVA: Currency read GetMVA write SetMVA;
        Property AliqICMSST: Currency read GetAliqICMSST write SetAliqICMSST;
        property ALiqCSLL: Currency read GetALiqCSLL write SetALiqCSLL;

        property BaseICMS_ISS: Currency read GetBaseICMS_ISS write SetBaseICMS_ISS;
        property BaseIPI: Currency read GetBaseIPI write SetBaseIPI;
        Property BasePIS_COFINS: Currency read GetBasePIS_COFINS write SetBasePIS_COFINS;
        property BaseICMSST: Currency read GetBaseICMSST write SetBaseICMSST;
        property BaseCSLL: Currency read GetBaseCSLL write SetBaseCSLL;

        property ValorICMS_ISS: Currency read GetValorICMS_ISS write SetValorICMS_ISS;
        property ValorIPI: Currency read GetValorIPI write SetValorIPI;
        Property ValorPIS_COFINS: Currency read GetValorPIS_COFINS write SetValorPIS_COFINS;
        property ValorICMSST: Currency read GetValorICMSST write SetValorICMSST;
        property ValorCSLL: Currency read GetValorCSLL write SetValorCSLL;


      end;


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
