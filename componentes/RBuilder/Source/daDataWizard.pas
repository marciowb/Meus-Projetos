{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daDataWizard;

interface

{$I ppIfDef.pas}

uses
  Classes,
  ppComm, ppWizard, ppTypes, ppClass, ppDsgnDB,
  daDB, daDataView, ppReport;

type

  TdaDataWizardClass = class of TdaCustomDataWizard;

  TdaCreateDataViewEvent = procedure(Sender: TObject; var aDataView: TObject) of object;


  { TdaCustomDataWizard }
  TdaCustomDataWizard = class(TppCustomWizard)
    private
      FEditMode: TppDataEditType;
      FOnCreateDataView: TdaCreateDataViewEvent;
      FSessionClass: TdaSessionClass;
      FDataSettings: TppDataSettings;
      FLanguageIndex: Longint;
      FReport: TppReport;

    protected
      procedure DoOnCreateDataView(var aDataView: TObject);
      function  GetDataView: TObject; virtual; abstract;
      function  GetDataViewName: String; virtual; abstract;
      function GetDataSetClass: TdaDataSetClass; virtual;
      procedure SetDataSettings(aDataSettings: TppDataSettings);  virtual;
      procedure SetReport(const Value: TppReport);  virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function DataViewClass: TdaDataViewClass; virtual; {abstract - keyword removed to support CBuilder}

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      property SessionClass: TdaSessionClass read FSessionClass write FSessionClass;
      property DataSetClass: TdaDataSetClass read GetDataSetClass;

      property DataSettings: TppDataSettings read FDataSettings write SetDataSettings;

      property LanguageIndex: Longint read FLanguageIndex write FLanguageIndex;

      property DataViewName: String read GetDataViewName;
      property DataView: TObject read GetDataView;
      property EditMode: TppDataEditType read FEditMode write FEditMode;
      property Report: TppReport read FReport write SetReport;
      property OnCreateDataView: TdaCreateDataViewEvent read FOnCreateDataView write FOnCreateDataView;

    published
      property Caption;

  end; {class, TdaCustomDataWizard}


  procedure daRegisterWizard(aWizardClass: TdaDataWizardClass);
  procedure daUnRegisterWizard(aWizardClass: TdaDataWizardClass);
  
  procedure daGetDataWizardClasses(aSessionClass: TClass; aList: TStrings);
  function daGetDataViewClassForWizardClass(aSessionClass: TClass; aWizardClass: TClass): TdaDataViewClass;


implementation


{******************************************************************************
 *
 ** C U S T O M   D A T A   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.Create }

constructor TdaCustomDataWizard.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FOnCreateDataView := nil;

  FDataSettings := TppDataSettings.Create(Self);
  FSessionClass := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.Destroy }

destructor TdaCustomDataWizard.Destroy;
begin

  FDataSettings.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.DataViewClass }

class function TdaCustomDataWizard.DataViewClass: TdaDataViewClass;
begin
  {descendants should override this method and return a dataview class}
  Result := nil;

end; {class function, DataViewClass}

{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.Notify }

procedure TdaCustomDataWizard.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if not(aOperation = ppopRemove) then Exit;

  if (FDataSettings <> nil) and (aCommunicator = FDataSettings.DataDictionary) then
    FDataSettings.DataDictionary := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.DoOnCreateDataView }

procedure TdaCustomDataWizard.DoOnCreateDataView(var aDataView: TObject);
begin
  if Assigned(FOnCreateDataView) then FOnCreateDataView(Self, aDataView);
end; {constructor, DoOnCreateDataView}


{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.GetDataSetClass }

function TdaCustomDataWizard.GetDataSetClass: TdaDataSetClass;
begin

  if (FSessionClass <> nil) then
    Result := FSessionClass.DataSetClass
  else
    Result := nil;

end; {function, GetDataSetClass}


{------------------------------------------------------------------------------}
{ TdaCustomDataWizard.SetDataSettings }

procedure TdaCustomDataWizard.SetDataSettings(aDataSettings: TppDataSettings);
begin

  FDataSettings.Assign(aDataSettings);

end; {procedure, SetDataSettings}

procedure TdaCustomDataWizard.SetReport(const Value: TppReport);
begin
  FReport := Value;
end;


{******************************************************************************
 *
 ** W I Z A R D   R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ daRegisterWizard }

procedure daRegisterWizard(aWizardClass: TdaDataWizardClass);
begin
  ppRegisterWizard(aWizardClass);
end; {procedure, daRegisterWizard}

{------------------------------------------------------------------------------}
{ daUnRegisterWizard }

procedure daUnRegisterWizard(aWizardClass: TdaDataWizardClass);
begin

  ppUnRegisterWizard(aWizardClass);

end; {procedure, daUnRegisterWizard}


{------------------------------------------------------------------------------}
{ daGetDataViewClassForWizardClass }

function daGetDataViewClassForWizardClass(aSessionClass: TClass; aWizardClass: TClass): TdaDataViewClass;
var
  lDataViewClasses: TStringList;
  liDataView: Integer;
  lDataViewClass: TdaDataViewClass;

begin

  lDataViewClasses := TStringList.Create;

  daGetDataViewWizardClasses(aSessionClass, lDataViewClasses);

  liDataView := 0;
  Result := nil;

  while (liDataView < lDataViewClasses.Count) and (Result = nil) do
    begin
      lDataViewClass := TdaDataViewClass(lDataViewClasses.Objects[liDataView]);

      if lDataViewClass.InheritsFrom(TdaDataWizardClass(aWizardClass).DataViewClass) then
        Result := lDataViewClass
      else
        Inc(liDataView);

      end;


  lDataViewClasses.Free;

end;  {procedure, daGetDataViewClassForWizardClass}





{------------------------------------------------------------------------------}
{ daGetDataWizardClasses }

procedure daGetDataWizardClasses(aSessionClass: TClass; aList: TStrings);
var
  lWizardClasses: TStringList;
  liWizard: Integer;
  lDataViewClass: TdaDataViewClass;
  lWizardClass: TdaDataWizardClass;

begin


  lWizardClasses   := TStringList.Create;

  ppGetWizardClasses(lWizardClasses, TdaCustomDataWizard);

  aList.Clear;

  for liWizard := 0 to lWizardClasses.Count-1 do
    begin

      lWizardClass   := TdaDataWizardClass(lWizardClasses.Objects[liWizard]);
      lDataViewClass := daGetDataViewClassForWizardClass(aSessionClass, lWizardClass);

      if lDataViewClass <> nil then
          aList.AddObject(lWizardClass.ClassDescription, TObject(lWizardClass));

    end;

  lWizardClasses.Free;


end; {procedure, daGetDataWizardClasses}








end.
