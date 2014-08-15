{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daDataWizardManager;

interface

uses
  Classes, Forms,
  ppComm, ppDsgnDB, ppTypes, ppWizard,
  daDB, daDataModule, daDataView, ppDB,
  ppReport;

type

  { TdaDataWizardManager

    Handles the creation of new dataviews when the user selects File | New
    from within the Data workspace.  Displays the New Items dialog and allows
    the user to select the Query Wizard, Query Designer or any other data
    wizards which have been registered via daRegisterWizard.  The New Items
    dialog may also display a Templates tab, which contains icons for any
    dataview templates registered via daRegisterDataView. }

  TdaDataWizardManager = class(TppCommunicator)
    private
      FDataManager: TComponent;
      FDataModule: TdaDataModule;
      FDataSettings: TppDataSettings;
      FDataView: TdaCustomDataView;
      FDataWizards: TList;
      FLanguageIndex: Longint;

      function CreateDataView(aDataViewClass: TClass): TdaCustomDataView;
      procedure DataViewValidateNameEvent(Sender: TObject; const aName: String; var aNameValid: Boolean);
      procedure DataWizardCreateDataViewEvent(Sender: TObject; var aDataView: TObject);
      procedure SetDataModule(aDataModule: TdaDataModule);
      procedure SetDataSettings(aDataSettings: TppDataSettings);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure AddWizard(aWizard: TppWizard);
      function CreateWizard(aWizardClass: TClass): TppWizard;
      function DesignDataView(aDataView: TdaCustomDataView): Boolean;
      function FindWizard(aWizardClass: TClass): TppWizard;
      procedure FreeWizard(aWizard: TppWizard);
      function GetSessionClass: TdaSessionClass;
      function NewDataView(var aDataView: TdaCustomDataView): Boolean;

      property DataManager: TComponent read FDataManager write FDataManager;
      property DataModule: TdaDataModule read FDataModule write SetDataModule;
      property DataSettings: TppDataSettings read FDataSettings write SetDataSettings;
      property DataView: TdaCustomDataView read FDataView write FDataView;
      property LanguageIndex: Longint read FLanguageIndex write FLanguageIndex;

    end; {class, TdaDataWizardManager}


implementation

uses
  Controls,
  ppForms, ppDesignerForms, ppClass, daDataManager, daDataWizard;

{******************************************************************************
 *
 ** D A T A   W I Z A R D   M A N A G E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.Create }

constructor TdaDataWizardManager.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FDataManager := nil;
  FDataModule := nil;
  FDataSettings := TppDataSettings.Create(Self);
  FDataView := nil;
  FDataWizards := TList.Create;
  FLanguageIndex := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.Destroy }

destructor TdaDataWizardManager.Destroy;
begin

  FDataSettings.Free;
  FDataWizards.Free;

  inherited Destroy;

end; {constructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.Notify }

procedure TdaDataWizardManager.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FDataView) then
    FDataView := nil

  else if (aCommunicator = FDataModule) then
    FDataModule := nil

  else if (aCommunicator = FDataSettings.DataDictionary) then
    FDataSettings.DataDictionary := nil

  else if (FDataWizards.IndexOf(aCommunicator) <> -1) then
    FDataWizards.Remove(aCommunicator);

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.SetDataModule }

procedure TdaDataWizardManager.SetDataModule(aDataModule: TdaDataModule);
begin

  if FDataModule <> nil then
    FDataModule.RemoveNotify(Self);

  FDataModule := aDataModule;

  if FDataModule <> nil then
    FDataModule.AddNotify(Self);

end; {procedure, SetDataModule}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.SetDataSettings }

procedure TdaDataWizardManager.SetDataSettings(aDataSettings: TppDataSettings);
begin
  FDataSettings.Assign(aDataSettings);
end; {procedure, SetDataSettings}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.GetSessionClass }

function TdaDataWizardManager.GetSessionClass: TdaSessionClass;
begin
  Result := daGetSessionClass(FDataSettings.SessionType);
end; {function, GetSessionClass}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.NewDataView }

function TdaDataWizardManager.NewDataView(var aDataView: TdaCustomDataView): Boolean;
var
  lFormClass: TFormClass;
  lNewDialog: TppCustomNewDialog;
  lNextAction: TppNextActionType;
  lCreateClass: TdaDataViewClass;
  lWizard: TdaCustomDataWizard;

begin

   Result := False;

  {get the registered dialog class}
  lFormClass := ppGetFormClass(TppCustomNewDialog);

  {create the dialog}
  lNewDialog := TppCustomNewDialog(lFormClass.Create(Application));
  lNewDialog.LanguageIndex := FLanguageIndex;

  daGetDataViewTemplates(lNewDialog.TemplateClasses);
  daGetDataWizardClasses(daGetSessionClass(FDataSettings.SessionType), lNewDialog.WizardClasses);

  {show dialog}
  if (lNewDialog.ShowModal <> mrOK) or (lNewDialog.CreateClass = nil) then
    begin
      lNewDialog.Free;

      Exit;
    end;

  {try to get the wizard from the dialog (may be nil if not a persistent wizard}
  lCreateClass := TdaDataViewClass(lNewDialog.CreateClass);


  lNextAction := ppnaNone;

  {create the data view via a wizard}
  if (lCreateClass.InheritsFrom(TdaCustomDataWizard)) then
    begin
      {create the wizard, if needed}
      lWizard := TdaCustomDataWizard(CreateWizard(TppWizardClass(lCreateClass)));
      lWizard.EditMode := ppemAll;
      lWizard.LanguageIndex := FLanguageIndex;
      lWizard.OnCreateDataView := DataWizardCreateDataViewEvent;
      lWizard.OnValidateName   := DataViewValidateNameEvent;
      lWizard.SessionClass     := GetSessionClass;
      lWizard.DataSettings     := FDataSettings;

      if (FDataModule <> nil) and (FDataModule.Report <> nil) then
        lWizard.Report := TppReport(FDataModule.Report.MainReport);

      try
        if lWizard.Execute then
          begin
            FDataView.Template.DatabaseSettings.Name := lWizard.DataViewName;

            lNextAction := lWizard.NextAction;
          end
        else
          FDataView.Free;
          
      except
        FDataView.Free;
        raise;

      end;


      FreeWizard(lWizard);
    end

  {create the data view directly and call design}
  else if (lCreateClass.InheritsFrom(TdaCustomDataView)) then
    begin
      FDataView := CreateDataView(lCreateClass);

      FDataView.LanguageIndex := FLanguageIndex;
      FDataView.OnValidateName := DataViewValidateNameEvent;
      FDataView.Init;

      FDataView.Design;

      lNextAction := FDataView.NextAction;
    end;

  {allow the data view to be previewed}
  if (FDataView <> nil) then
    begin

      Result := True;
      aDataView := FDataView;

      if (FDataView <> nil) then

         case lNextAction of

           ppnaPreview:
             begin
               FDataView.Preview;

               FDataView.RemoveNotify(Self);
             end;

           ppnaDesign:
             DesignDataView(FDataView);

         end;

    end;

  FDataView := nil;
  
  lNewDialog.Free;

end; {procedure, NewDataView}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.DesignDataView }

function TdaDataWizardManager.DesignDataView(aDataView: TdaCustomDataView): Boolean;
var
  lWizard: TdaCustomDataWizard;
  lNextAction: TppNextActionType;

begin
  Result := False;

  lNextAction := ppnaNone;

  FDataView := aDataView;

  if (FDataView.DataDesignerClass <> nil) then
    lWizard := TdaCustomDataWizard(CreateWizard(FDataView.DataDesignerClass))
  else
    lWizard := nil;


  if (lWizard <> nil) then
    begin
      lWizard.LanguageIndex := FLanguageIndex;
      lWizard.OnCreateDataView := DataWizardCreateDataViewEvent;
      lWizard.OnValidateName   := DataViewValidateNameEvent;
      lWizard.EditMode := FDataView.EditMode;
      lWizard.SessionClass := GetSessionClass;
      lWizard.DataSettings := FDataSettings;

      if lWizard.Execute then
        begin
          FDataView.Template.DatabaseSettings.Name := lWizard.DataViewName;

          Result := True;
          lNextAction := lWizard.NextAction;
        end;

      FreeWizard(lWizard);
    end

  else
    begin
      FDataView.LanguageIndex := FLanguageIndex;
      FDataView.OnValidateName := DataViewValidateNameEvent;

      FDataView.Design;
      Result := True;

      lNextAction := FDataView.NextAction;
    end;

  {preview the data}
  if (FDataView <> nil) then
    begin

      if (lNextAction = ppnaPreview) then
        FDataView.Preview;
    end;


  FDataView := nil;

end;  {procedure, DesignDataView}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.AddWizard }

procedure TdaDataWizardManager.AddWizard(aWizard: TppWizard);
begin

  if (FDataWizards.IndexOf(aWizard) = -1) then
    begin
      FDataWizards.Add(aWizard);

      aWizard.AddNotify(Self);
    end;

end; {procedure, AddWizard}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.CreateWizard }

function TdaDataWizardManager.CreateWizard(aWizardClass: TClass): TppWizard;
var
  liIndex: Integer;
  lWizards: TStringList;

begin

  Result := nil;

  {validate WizardClass}
  if (aWizardClass = nil) or not aWizardClass.InheritsFrom(TppWizard) then Exit;

  {try to find the wizard in the existing list}
  Result := FindWizard(aWizardClass);

  if (Result <> nil) then Exit;

  {search the owner and add any new wizards}
  lWizards := TppCommunicatorPickList.Create(FDataModule, TdaCustomDataWizard);

  for liIndex := 0 to lWizards.Count-1 do
    if FDataWizards.IndexOf(lWizards.Objects[liIndex]) < 0 then
      AddWizard(TppWizard(lWizards.Objects[liIndex]));

  {try to find the wizard in the updated list}
  Result := FindWizard(aWizardClass);

  if (Result <> nil) then Exit;

  {create a new wizard}
  Result := TppWizardClass(aWizardClass).Create(Self);

  AddWizard(Result);

  lWizards.Free;

end; {procedure, CreateWizard}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.FindWizard }

function TdaDataWizardManager.FindWizard(aWizardClass: TClass): TppWizard;
var
  liIndex: Integer;
  lbFound: Boolean;
  lWizard: TppWizard;
begin

  Result := nil;

  lbFound := False;
  liIndex := 0;

  while (liIndex < FDataWizards.Count) and not(lbFound) do
    begin
      lWizard := TppWizard(FDataWizards[liIndex]);

      if (lWizard.ClassType = aWizardClass) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if (lbFound) then
    Result := TppWizard(FDataWizards[liIndex]);

end; {procedure, FindWizard}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.FreeWizard }

procedure TdaDataWizardManager.FreeWizard(aWizard: TppWizard);
var
  liPosition: Integer;
begin

  if (aWizard = nil) then Exit;

  liPosition := FDataWizards.IndexOf(aWizard);

  if (liPosition = -1) then
    aWizard.Free;

end; {procedure, FreeWizard}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.DataWizardCreateDataViewEvent }

procedure TdaDataWizardManager.DataWizardCreateDataViewEvent(Sender: TObject; var aDataView: TObject);
var
  lDataViewClass: TComponentClass;
begin

  if (FDataView = nil) then
    begin

      if not(Sender is TdaCustomDataWizard) then Exit;

      lDataViewClass := daGetDataViewClassForWizardClass(GetSessionClass, Sender.ClassType);

      if (lDataViewClass = nil) then Exit;

      FDataView := CreateDataView(lDataViewClass);


    end;

  aDataView := FDataView;

end; {procedure, DataWizardCreateDataViewEvent}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.CreateDataView }

function TdaDataWizardManager.CreateDataView(aDataViewClass: TClass): TdaCustomDataView;
begin

  Result := TdaCustomDataViewClass(aDataViewClass).Create(FDataModule.Owner);
  Result.Name := Result.GetValidName(Result);

  Result.Parent := FDataModule;

  Result.AddNotify(Self);

  Result.New := True;

end; {procedure, CreateDataView}

{------------------------------------------------------------------------------}
{ TdaDataWizardManager.DataViewValidateNameEvent }

procedure TdaDataWizardManager.DataViewValidateNameEvent(Sender: TObject; const aName: String; var aNameValid: Boolean);
var
  lDataPipeline: TppDataPipeline;
begin
  aNameValid := True;

  if FDataView.DataPipelineCount > 0 then
    lDataPipeline := FDataView.DataPipelines[0]
  else
    lDataPipeline := nil;

  if (lDataPipeline <> nil) and (lDataPipeline.UserName <> aName) then
    aNameValid := FDataModule.IsValidDataPipelineUserName(aName);

end; {procedure, DataViewValidateNameEvent}


end.
