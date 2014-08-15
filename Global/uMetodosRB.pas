unit uMetodosRB;

interface
 Uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,Db,DBClient, pFIBClientDataSet,  ppDBPipe,
  {declares TraSystemFunction and raRegisterFunction} raFunc,
  ppRTTI;
 type
  {raFunc declares the following:

     TraSystemFunction
       |
        -- TraStringFunction
       |
        -- TraConversionFunction
       |
        -- TraFormatFunction
       |
        -- TraDateTimeFunction
       |
        -- TraMathFunction

   These descendants of TraSystemFunction override the Catagory class function
   to return a value that will become a category under the Function node in
   the Language tab of the Code Toolbox.

   You can either declare new subclasses under one of the existing categories:

     TMyNewStringFunction = class(TraStringFunction)

     this function would appear in the String category -

   or you can declare a new category subclass, then descend a new function class
   from that one:

     TMyNewCategoryFunction = class(TraSystemFunction)

     TMyNewFunction = class(TMyNewCategoryFunction)


   This second method is what we are doing in this unit. We have declared a new
   descendant of TraSystemFunction to create a new category of "Filename" then
   we descend a new function class from it. This new function will appear in the
   Code Toolbox in the Langauge tab under Functions|Filename.}
  TMetodosHRM = class (TraSystemFunction)
  public
    {Override Category to return a new category string}
    class function Category: String; override;
  end;

  {Descendants of TmyFilenameFunction will appear in the Filename category}
  TOrdenaDataSet = class (TMetodosHRM)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function IsFunction: Boolean; override;
  end;
  TExtenso = class (TMetodosHRM)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: String; override;
    class function IsFunction: Boolean; override;
  end;

implementation

uses {$IfDef FZP}uDMReport {$Else} uDmRelatorio {$EndIF} , uExtenso;



{ TOrdenaDataSet }

procedure TOrdenaDataSet.ExecuteFunction(aParams: TraParamList);
var
  DataSet: TppDBPipeline;
  Campos,StrDataSet,UserName: String;
  I: Integer;
begin
  inherited;
  GetParamValue(0, StrDataSet);
  GetParamValue(1, Campos);
  DataSet := nil ;
  for I := 0 to DmRelatorio.ComponentCount - 1 do
  Begin
    if DmRelatorio.Components[i] is TppDBPipeline then
    Begin
      UserName := (DmRelatorio.Components[i] as TppDBPipeline).UserName;
      if UpperCase(UserName) = UpperCase(StrDataSet) then
      Begin
        DataSet := DmRelatorio.Components[i] as TppDBPipeline;
        Break;
      End;
    End;
  End;
  if DataSet <> nil then
    (DataSet.DataSource.DataSet as TpFIBClientDataSet).IndexFieldNames := Campos;
end;

class function TOrdenaDataSet.GetSignature: String;
begin
 Result := 'Procedure OrdenaDataSet(DataSet,Campos:String );';
end;

class function TOrdenaDataSet.IsFunction: Boolean;
begin
  Result := False;
end;

{ TMetodosHRM }

class function TMetodosHRM.Category: String;
begin
  Result := 'HRM';
end;

{ TExtenso }

procedure TExtenso.ExecuteFunction(aParams: TraParamList);
var
  Valor: Currency;
  Temp: String;
begin
  inherited;
  GetParamValue(0, Valor);
  Temp := valorPorExtenso(Valor);
  SetParamValue(1, Temp);
end;

class function TExtenso.GetSignature: String;
begin
  Result := 'function Extenso(Valor: Currency ): String;';
end;

class function TExtenso.IsFunction: Boolean;
begin
  Result := True;
end;

initialization
  raRegisterFunction('OrdenaDataSet', TOrdenaDataSet);
  raRegisterFunction('Extenso', TExtenso);

finalization

 raUnRegisterFunction('OrdenaDataSet');
 raUnRegisterFunction('Extenso');

end.
