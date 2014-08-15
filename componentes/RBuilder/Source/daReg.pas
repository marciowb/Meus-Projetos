{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daReg;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}DesignIntf, DesignEditors,  {$ELSE} DsgnIntf, {$ENDIF}
  SysUtils, Classes, TypInfo,
  ppCmpReg, ppUtils, ppWizard, ppDB, ppDsgnDB,  ppDBPipe, ppTxPipe, ppDBJIT,
  ppDsIntf,
  daSQL, daDataModule, daQueryWizard, daDB, daDataView, daDataDictionaryBuilder, daIDE;


type


  {@TdaStringFromListProperty}
  TdaStringFromListProperty = class(TStringProperty)
    public
      function GetAttributes: TPropertyAttributes; override;
      procedure GetValueList(List: TStrings); virtual; abstract;
      procedure GetValues(Proc: TGetStrProc); override;
  end; {class, TdaStringFromListProperty}


  {@TdaDatabaseNameProperty}
  TdaDatabaseNameProperty = class(TdaStringFromListProperty)
    private
      FList: TStrings;

      procedure GetDataItemsCallback(const S: string);

    public

      procedure GetValueList(List: TStrings); override;

  end; {class, TdaDatabaseNameProperty}

  {@TdaSessionTypeProperty}
  TdaSessionTypeProperty = class(TdaStringFromListProperty)
    public
      procedure GetValueList(List: TStrings); override;
  end; {class, TdaSessionTypeProperty}



procedure Register;

implementation


{******************************************************************************
 *
 ** S T R I N G   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaStringFromListProperty.GetAttributes }

function TdaStringFromListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end; {function, GetAttributes}

{------------------------------------------------------------------------------}
{ TdaStringFromListProperty.GetValues }

procedure TdaStringFromListProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end; {procedure, GetValues}


{******************************************************************************
 *
 ** D A T A B A S E N A M E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDatabaseNameProperty.GetValueList }

procedure TdaDatabaseNameProperty.GetValueList(List: TStrings);
var
  lPersistent: TPersistent;
  lDataSettings: TppBasicDataSettings;
  lSessionClass: TdaSessionClass;

begin

  lPersistent := GetComponent(0);

  if not (lPersistent is TppBasicDataSettings) then Exit;

  lDataSettings := TppBasicDataSettings(lPersistent);

  lSessionClass := daGetSessionClass(lDataSettings.SessionType);

  if (lSessionClass = nil) then Exit;

  {get list of available database names}
  daGetDatabaseNames(lSessionClass, List, nil);

  {get list of any available database objects also}
  if lSessionClass.DatabaseClass <> nil then
    begin
      {for the callback routine we need a pointer to the list}
      FList := List;
      Designer.GetComponentNames(GetTypeData(lSessionClass.DatabaseClass.ClassInfo), GetDataItemsCallback);
      FList := nil;
    end;
end; {procedure, GetValueList}


{------------------------------------------------------------------------------}
{ TdaDatabaseNameProperty.GetDataItemsCallback }

procedure TdaDatabaseNameProperty.GetDataItemsCallback(const S: string);
var
  lComponent: TComponent;
begin

  {add database name to list}
  lComponent := Designer.GetComponent(S);

  if lComponent <> nil then
    FList.Add(lComponent.Name);

end; {procedure, GetDataItemsCallback}




{******************************************************************************
 *
 ** S E S S I O N   T Y P E   P R O P E R T Y   E D I T O R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSessionTypeProperty.GetValueList }

procedure TdaSessionTypeProperty.GetValueList(List: TStrings);
begin
  {get list of supported sessions}
  daGetDataViewSessionClasses(List);

end; {procedure, GetValueList}



{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}




procedure Register;
begin
{$IFDEF Delphi9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  {data module}
  RegisterNoIcon([TdaDataModule]);

  {child pipelines}
  RegisterNoIcon([TppChildDBPipeline, TppChildTextPipeline, TppChildJITPipeline]);

  {child data access component descendants}
  RegisterNoIcon([TppChildDataSource]);

  {query def components}
  RegisterNoIcon([TdaTable, TdaField, TdaCalculation, TdaTableJoin, TdaCriteria, TdaNumericValue, TdaSQL, TdaSQLLink]);

  {component designers - data dictionary builder }
  ppRegisterComponentDesigner(TdaDataDictionaryBuilderForm, TppDataDictionary);


  RegisterPropertyEditor(TypeInfo(TFileName), TppBasicDataSettings, 'DatabaseName', TdaDatabaseNameProperty);
  RegisterPropertyEditor(TypeInfo(String), TppBasicDataSettings, 'SessionType', TdaSessionTypeProperty);

  

end; {procedure, Register}

initialization

finalization

  {component designers - data dictionary builder }
  ppUnRegisterComponentDesigner(TdaDataDictionaryBuilderForm, TppDataDictionary);


end. 
