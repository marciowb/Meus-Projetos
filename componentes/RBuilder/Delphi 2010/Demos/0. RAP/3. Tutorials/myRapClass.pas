{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myRapClass;

interface

uses
  Classes, Forms, raFunc, ppRTTI, db, dbTables, ppUtils;

type
  { TmyTDataBaseRTTI }
  TmyTDataBaseRTTI = class (TraTComponentRTTI)
  public
    class function CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function GetParams(const aMethodName: String): TraParamList; override;
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
    class function RefClass: TClass; override;
    class function SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end;

  { TmyDevelopersFunction }
  TmyDevelopersFunction = class (TraSystemFunction)
  public
    class function Category: string; override;
  end;

  { TmyGetDelphiComponentFunction }
  TmyGetDelphiComponentFunction = class (TmyDevelopersFunction)
  public
    procedure ExecuteFunction(aParams: TraParamList); override;
    class function GetSignature: string; override;
  end;

implementation


{------------------------------------------------------------------------------}
{ TmyDevelopersFunction.Category}

class function TmyDevelopersFunction.Category: string;
begin

  Result := 'Developer';

end;{ class function, Category }


{------------------------------------------------------------------------------}
{ TmyGetDelphiComponentFunction.ExecuteFunction}

procedure TmyGetDelphiComponentFunction.ExecuteFunction(aParams: TraParamList);
var
  lsString: string;
  lResult: TComponent;
begin

  GetParamValue(0, lsString);

  lResult := Application.MainForm.FindComponent(lsString);

  SetParamValue(1, lResult);

end;{ procedure, ExecuteFunction }


{------------------------------------------------------------------------------}
{ TmyGetDelphiComponentFunction.GetSignature}

class function TmyGetDelphiComponentFunction.GetSignature: string;
begin

  Result := 'function GetDelphiComponent(const aComponentName: String): TComponent;';

end;{ class function, GetSignature }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.CallMethod}

class function TmyTDataBaseRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lsName: string;
  lbResult: Boolean;
  lDataBase: TDataBase;
begin

  Result := True;

  lDataBase := TDataBase(aObject);

  if ppEqual(aMethodName, 'ValidateName') then
    begin
      aParams.GetParamValue(0, lsName);

      try
        lDataBase.ValidateName(lsName);
        lbResult := True;

      except
        On EDatabaseError do
          lbResult := False;
      end;

      aParams.SetParamValue(1, lbResult);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;{ class function, CallMethod }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.GetParams}

class function TmyTDataBaseRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'ValidateName') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;{ class function, GetParams }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.GetPropList}

class procedure TmyTDataBaseRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);
  aPropList.AddProp('Directory');
  aPropList.AddMethod('ValidateName');

end;{ class procedure, GetPropList }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.GetPropRec}

class function TmyTDataBaseRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Directory') then
    PropToRec(aPropName, daString, False, aPropRec)

  else if ppEqual(aPropName, 'ValidateName') then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;{ class function, GetPropRec }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.GetPropValue}

class function TmyTDataBaseRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Directory') then
    String(aValue) := TDataBase(aObject).Directory

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end;{ class function, GetPropValue }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.RefClass}

class function TmyTDataBaseRTTI.RefClass: TClass;
begin

  Result := TDataBase;

end;{ class function RefClass() }


{------------------------------------------------------------------------------}
{ TmyTDataBaseRTTI.SetPropValue}

class function TmyTDataBaseRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Directory') then
    TDataBase(aObject).Directory := String(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end;{ class function, SetPropValue }


initialization

  raRegisterFunction('GetDelphiComponent', TmyGetDelphiComponentFunction);
  raRegisterRTTI(TmyTDataBaseRTTI);

finalization

  raUnRegisterFunction('GetDelphiComponent');
  raUnregisterRTTI(TmyTDataBaseRTTI);


end.
