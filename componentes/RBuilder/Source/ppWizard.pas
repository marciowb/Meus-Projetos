{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppWizard;

interface

{$I ppIfDef.pas}

uses
  Windows, Controls, Classes,
  ppComm, ppTypes, ppUtils, ppIniStorage;

type

  TppWizardClass = class of TppWizard;
  TppReportWizardClass = class of TppCustomReportWizard;

  {@TppWizard }
  TppWizard = class(TppCommunicator)
    public
      constructor Create(aOwner: TComponent); override;

      function Execute: Boolean; virtual; abstract;

      class function ClassDescription: String; virtual;
      class function ClassBitmap: THandle; virtual;

  end; {class, TppWizard}

  {@TppCustomWizard }
  TppCustomWizard = class(TppWizard)
    private
      FAskForName: Boolean;
      FCaption: String;
      //FLanguageIndex: Longint;
      FOnGetDataNames: TppGetDataNamesEvent;
      FOnGetFields: TppGetFieldsEvent;
      FOnValidateName: TppValidateNameEvent;
      FNextAction: TppNextActionType;

    protected
      procedure DoOnGetDataNames(aDataNameList: TStrings);
      procedure DoOnGetFields(const aDataName: String; aFieldList: TStrings);
      procedure DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);

      procedure LoadStateInfo(aIniStorage: TppIniStorage); virtual;
      procedure SaveStateInfo(aIniStorage: TppIniStorage); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function DisplaysDialog: Boolean; virtual;

      procedure LoadState;
      procedure SaveState;
      
      property AskForName: Boolean read FAskForName write FAskForName default True;
      property Caption: String read FCaption write FCaption;
      //property LanguageIndex: Longint read FLanguageIndex;
      property OnGetDataNames: TppGetDataNamesEvent read FOnGetDataNames write FOnGetDataNames;
      property OnGetFields: TppGetFieldsEvent read FOnGetFields write FOnGetFields;
      property OnValidateName: TppValidateNameEvent read FOnValidateName write FOnValidateName;
      property NextAction: TppNextActionType read FNextAction write FNextAction default ppnaNone;


  end; {class, TppCustomWizard}



  {@TppCustomReportWizard }
  TppCustomReportWizard = class(TppCustomWizard)
    private
      FDataName: String;
      FOnCreateReport: TppCreateReportEvent;

    protected
      procedure DoOnCreateReport(const aDataName: String; var aReport: TObject);
      function  GetReport: TObject; virtual; abstract;
      function  GetReportName: String; virtual; abstract;
      procedure SetDataName(aDataName: String); virtual;

    public
      constructor Create(aOwner: TComponent); override;

      property DataName: String read FDataName write SetDataName;
      property OnCreateReport: TppCreateReportEvent read FOnCreateReport write FOnCreateReport;
      property Report: TObject read GetReport;
      property ReportName: String read GetReportName;

  end; {class, TppCustomReportWizard}


  procedure ppRegisterWizard(aWizardClass: TppWizardClass);
  procedure ppUnRegisterWizard(aWizardClass: TppWizardClass);

  procedure ppGetReportWizardClasses(aList: TStrings);
  procedure ppGetWizardClasses(aList: TStrings; aWizardClass: TppWizardClass);

  function  ppDefaultBlankReportWizard: TppReportWizardClass;
  function  ppDefaultReportWizard: TppReportWizardClass;
  procedure ppRegisterDefaultReportWizard(aReportWizardClass: TppReportWizardClass);
  procedure ppRegisterDefaultBlankReportWizard(aReportWizardClass: TppReportWizardClass);


implementation

var
  FWizardClassList: TList = nil;
  FDefaultBlankReportWizard: TppReportWizardClass = nil;
  FDefaultReportWizard: TppReportWizardClass = nil;

{******************************************************************************
 *
 ** W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppWizard.Create }

constructor TppWizard.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppWizard.ClassDescription }

class function TppWizard.ClassDescription: String;
begin
  Result := ClassName;
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TppWizard.ClassBitmap }

class function TppWizard.ClassBitmap: THandle;
begin
  Result := ppBitmapFromResource('PPNOWIZARDBITMAP');
end; {class function, ClassBitmap}


{******************************************************************************
 *
 ** C U S T O M   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomWizard.Create }

constructor TppCustomWizard.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FAskForName := True;
  FNextAction := ppnaNone;
  FOnGetFields := nil;
  FOnGetDataNames := nil;
  FOnValidateName := nil;

  FCaption := ClassDescription;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppCustomWizard.Destroy }

destructor TppCustomWizard.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppCustomWizard.LoadState }

procedure TppCustomWizard.LoadState;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try
    LoadStateInfo(lIniStorage);
  finally
    lIniStorage.Free;
  end;

end; {procedure, LoadState}


{------------------------------------------------------------------------------}
{ TppCustomWizard.SaveState }

procedure TppCustomWizard.SaveState;
var
  lIniStorage: TppIniStorage;
begin

  lIniStorage := TppIniStoragePlugIn.CreateInstance;

  try
    SaveStateInfo(lIniStorage);
  finally
    lIniStorage.Free;
  end;

end; {procedure, SaveState}


{------------------------------------------------------------------------------}
{ TppCustomWizard.LoadStateInfo }

procedure TppCustomWizard.LoadStateInfo(aIniStorage: TppIniStorage);
begin

end; {procedure, LoadStateInfo}


{------------------------------------------------------------------------------}
{ TppCustomWizard.SaveStateInfo }

procedure TppCustomWizard.SaveStateInfo(aIniStorage: TppIniStorage);
begin

end; {procedure, SaveStateInfo}


{------------------------------------------------------------------------------}
{ TppCustomWizard.DisplaysDialog }

class function TppCustomWizard.DisplaysDialog: Boolean;
begin
  Result := True;
end; {class function, DisplaysDialog}

{------------------------------------------------------------------------------}
{ TppCustomWizard.DoOnGetFields }

procedure TppCustomWizard.DoOnGetFields(const aDataName: String; aFieldList: TStrings);
begin
  if Assigned(FOnGetFields) then FOnGetFields(Self, aDataName, aFieldList);
end; {procedure, DoOnGetFields}

{------------------------------------------------------------------------------}
{ TppCustomWizard.DoOnGetDataNames }

procedure TppCustomWizard.DoOnGetDataNames(aDataNameList: TStrings);
begin
  if Assigned(FOnGetDataNames) then FOnGetDataNames(Self, aDataNameList);
end; {procedure, DoOnGetDataNames}

{------------------------------------------------------------------------------}
{ TppCustomWizard.DoOnValidateName }

procedure TppCustomWizard.DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
begin
  if Assigned(FOnValidateName) then FOnValidateName(Sender, aName, aNameValid);
end; {procedure, DoOnValidateName}

{******************************************************************************
 *
 ** C U S T O M   R E P O R T   W I Z A R D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomReportWizard.Create }

constructor TppCustomReportWizard.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FDataName := '';
  FOnCreateReport := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomReportWizard.DoOnCreateReport }

procedure TppCustomReportWizard.DoOnCreateReport(const aDataName: String; var aReport: TObject);
begin
  if Assigned(FOnCreateReport) then FOnCreateReport(Self, aDataName, aReport);
end; {constructor, DoOnCreateReport}

{------------------------------------------------------------------------------}
{ TppCustomReportWizard.SetDataName }

procedure TppCustomReportWizard.SetDataName(aDataName: String);
begin
  FDataName := aDataName;
end; {procedure, SetDataName}

{******************************************************************************
 *
 ** W I Z A R D   R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetWizardClassList }

function ppGetWizardClassList: TList;
begin

  if (FWizardClassList = nil) then
    FWizardClassList := TList.Create;

  Result := FWizardClassList;

end; {function, ppGetWizardClassList}

{------------------------------------------------------------------------------}
{ ppRegisterDefaultBlankReportWizard }

procedure ppRegisterDefaultBlankReportWizard(aReportWizardClass: TppReportWizardClass);
begin
  if (FDefaultBlankReportWizard <> nil) then
    ppUnRegisterWizard(FDefaultBlankReportWizard);

  FDefaultBlankReportWizard := aReportWizardClass;

  ppRegisterWizard(aReportWizardClass);

end; {function, ppRegisterDefaultBlankReportWizard}

{------------------------------------------------------------------------------}
{ ppRegisterDefaultReportWizard }

procedure ppRegisterDefaultReportWizard(aReportWizardClass: TppReportWizardClass);
var
  liCount: Integer;
  lClassList: TList;
begin

  if (FDefaultReportWizard <> nil) then
    ppUnRegisterWizard(FDefaultReportWizard);

  FDefaultReportWizard := aReportWizardClass;

  ppRegisterWizard(aReportWizardClass);

  lClassList := ppGetWizardClassList;

  {move the new default wizard to the front of the list}
  liCount := lClassList.Count;

  if (liCount > 1) then
    lClassList.Move(liCount - 1, 0);

end; {function, ppRegisterDefaultReportWizard}

{------------------------------------------------------------------------------}
{ ppDefaultBlankReportWizard }

function ppDefaultBlankReportWizard: TppReportWizardClass;
begin
  Result := FDefaultBlankReportWizard;
end; {function, ppDefaultBlankReportWizard}

{------------------------------------------------------------------------------}
{ ppDefaultReportWizard }

function ppDefaultReportWizard: TppReportWizardClass;
begin
  Result := FDefaultReportWizard;
end; {function, ppDefaultReportWizard}

{------------------------------------------------------------------------------}
{ ppGetWizardClasses }

procedure ppGetWizardClasses(aList: TStrings; aWizardClass: TppWizardClass);
var
  lClassList: TList;
  lWizardClass: TppWizardClass;
  liIndex: Integer;
begin

  lClassList := ppGetWizardClassList;

  for liIndex := 0 to lClassList.Count - 1 do
    begin
      lWizardClass := TppWizardClass(lClassList[liIndex]);

      if lWizardClass.InheritsFrom(aWizardClass) then
        aList.AddObject(lWizardClass.ClassDescription, TObject(lWizardClass));

    end;

end; {procedure, ppGetWizardClasses}


{------------------------------------------------------------------------------}
{ ppGetReportWizardClasses }

procedure ppGetReportWizardClasses(aList: TStrings);
begin
  ppGetWizardClasses(aList, TppCustomReportWizard);
end; {procedure, ppGetReportWizardClasses}

{------------------------------------------------------------------------------}
{ ppRegisterWizard }

procedure ppRegisterWizard(aWizardClass: TppWizardClass);
var
  lClassList: TList;
  liIndex: Integer;
begin

  if (aWizardClass = nil) then Exit;

  lClassList := ppGetWizardClassList;

  liIndex :=  lClassList.IndexOf(aWizardClass);

  if (liIndex = -1) then
    begin
      RegisterClass(aWizardClass);

      lClassList.Add(aWizardClass);
    end;

end; {procedure, ppRegisterWizard}

{------------------------------------------------------------------------------}
{ ppUnRegisterWizard }

procedure ppUnRegisterWizard(aWizardClass: TppWizardClass);
var
  lClassList: TList;
  liIndex: Integer;
begin

  if (aWizardClass = nil) then Exit;
  
  UnRegisterClass(aWizardClass);

  if (FWizardClassList = nil) then Exit;

  lClassList := ppGetWizardClassList;

  liIndex := lClassList.IndexOf(aWizardClass);

  if (liIndex <> -1) then
    begin
      lClassList.Delete(liIndex);

      if (aWizardClass = FDefaultReportWizard) then
        FDefaultReportWizard := nil;

      if (aWizardClass = FDefaultBlankReportWizard) then
        FDefaultBlankReportWizard := nil;

    end;

end; {procedure, ppUnRegisterWizard}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

finalization

  FWizardClassList.Free;
  FWizardClassList := nil;

end.
