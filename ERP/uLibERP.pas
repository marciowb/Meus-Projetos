unit uLibERP;

interface
    Uses MinhasClasses, uSQLERP,Comandos,Classes,
         SysUtils, Math, EditPesquisa,pFIBClientDataSet,DB,
         uDocumentoFiscal,uClassesERP;
   type
     TRotinasPesquisa = class
       class procedure ConfiguraPesquisaFuncionario(var Edit : TEditPesquisa; aDataSet : TpFIBClientDataSet; aCampoData :String = '');
     end;



    Function TipoCampoChaveToStr(Valor: TipoCampoChave): String;

    function RoundTo5(Valor: Double; Casas: Integer): Double;

    Function TipoTransporteToStr(TipoTranp: TTipoTransporte):String;
    Function StrToTipoTransporte(TipoTranp: String):TTipoTransporte;

const
   SemID: TipoCampoChave = '-1';
implementation

uses uForms, uConstantes;

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

function RoundTo5(Valor: Double; Casas: Integer): Double;
 var
   xValor, xDecimais: String;
   p, nCasas: Integer;
   nValor: Double;
 begin
   nValor := Valor;
   xValor := Trim(FloatToStr(Valor));
   p := pos(',', xValor);
   if Casas < 0 then
     nCasas := -Casas
   else
     nCasas := Casas;
   if p > 0 then
   begin
     xDecimais := Copy(xValor, p + 1, length(xValor));
     if length(xDecimais) > nCasas then
     begin
       if xDecimais[nCasas + 1] >= '5' then
         SetRoundMode(rmUP)
       else
         SetRoundMode(rmNearest);
     end;
     nValor := RoundTo(Valor, Casas);
   end;
   Result := nValor;


end;





Procedure CriaDocumentoFiscal(Const IdDocumento: TipoCampoChave ; Var Doc: IDocumentoFiscal );overload;
var
  DataSetDocumento, DataSetItens: TpFIBClientDataSet;
begin

end;

Function TipoTransporteToStr(TipoTranp: TTipoTransporte):String;
begin
  case TipoTranp of
    ttMaritima:
      Result := TipoTransporteMaritima ;
    ttFluvial:
      Result := TipoTransporteFluvial ;
    ttLacustre:
      Result := TipoTransporteLacustre ;
    ttAerea:
      Result := TipoTransporteAerea ;
    ttPostal:
       Result := TipoTransportePostal ;
    ttFerroviaria:
       Result := TipoTransporteFerroviaria ;
    ttRodoviaria:
       Result := TipoTransporteRodoviaria ;
    ttConduto_Rede_Transmissao:
       Result := TipoTransporteConduto_Rede_Transmissao ;
    ttMeios_Proprios:
      Result := TipoTransporteMeios_Proprios ;
    ttEntrada_Ou_Saida_ficta:
      Result := TipoTransporteEntrada_Saida_ficta ;
  end;
end;

Function StrToTipoTransporte(TipoTranp: String):TTipoTransporte;
begin
  if TipoTranp = TipoTransporteMaritima  then
    Result := ttMaritima
  else
  if TipoTranp = TipoTransporteFluvial  then
    Result := ttFluvial
  else
  if TipoTranp = TipoTransporteLacustre  then
    Result := ttLacustre
  else
  if TipoTranp = TipoTransporteAerea  then
    Result := ttAerea
  else
  if TipoTranp = TipoTransportePostal  then
    Result := ttPostal
  else
  if TipoTranp = TipoTransporteFerroviaria  then
    Result := ttFerroviaria
  else
  if TipoTranp = TipoTransporteRodoviaria  then
    Result := ttRodoviaria
  else
  if TipoTranp = TipoTransporteConduto_Rede_Transmissao  then
    Result := ttMaritima
  else
  if TipoTranp = TipoTransporteConduto_Rede_Transmissao  then
    Result := ttConduto_Rede_Transmissao
  else
  if TipoTranp = TipoTransporteMeios_Proprios  then
    Result := ttMeios_Proprios
  else
  if TipoTranp = TipoTransporteEntrada_Saida_ficta  then
    Result := ttEntrada_Ou_Saida_ficta;


end;

end.
