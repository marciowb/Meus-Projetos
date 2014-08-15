{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppModule;

interface

{$I ppIfDef.pas}

uses
  Classes,
  ppClass, ppTypes, ppComm, ppRelatv, ppTmplat;

type

  TppReportModule          = class;
  TppReportModuleTemplate  = class;
  TppReportModuleClass     = class of TppReportModule;
  TppReportModuleTemplateClass = class of TppReportModuleTemplate;

  {@TppReportModule
   Abstract ancestor class that defines properties and methods common to modules
   that extend the functionality of a report. Report's typically contain layout
   elements such as Bands, Labels, DBTexts, Subreports, etc. Reports can also
   contain modules that contain elements such as data access components
   and run-time code.

   Descendants include TdaDataModule and TraCodeModule.}
  TppReportModule = class(TppRelative)
    private
      FModified: Boolean;
      FReport: TppCustomReport;
      FTemplate: TppReportModuleTemplate;
      FOnAddChild: TNotifyEvent;
      FOnRemoveChild: TNotifyEvent;
      FOnLanguageChanged: TNotifyEvent;

    protected
      procedure NewReport; virtual;
      procedure SetModified(aValue: Boolean); virtual;
      procedure SetReport(aReport: TppCustomReport); virtual;
      procedure SetTemplate(aTemplate: TppReportModuleTemplate); virtual;
      procedure LanguageChanged; virtual;

      class function TemplateClass: TppReportModuleTemplateClass; virtual;

    public
      constructor Create(aOwner: TComponent); override;
      constructor CreateForReport(aReport: TppCustomReport); virtual;
      destructor  Destroy; override;

      function HasParent: Boolean; override;
      function  GetParentComponent: TComponent; override;
      procedure SetParentComponent(Value: TComponent); override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure Transfer(aSource: TppCommunicator); override;

      procedure Convert(aVersionNo: Integer); virtual;
      procedure GetDataPipelines(aList: TList); virtual;

      procedure AddChild(aChild: TppRelative);  override;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); override;
      function IsEmpty: Boolean; virtual;
      function RemoveChild(aChild: TppRelative): Integer; override;

      property Modified: Boolean read FModified write SetModified;
      property Template: TppReportModuleTemplate read FTemplate write SetTemplate;

      property Report: TppCustomReport read FReport write SetReport;

      property OnAddChild: TNotifyEvent read FOnAddChild write FOnAddChild;
      property OnRemoveChild: TNotifyEvent read FOnRemoveChild write FOnRemoveChild;
      property OnLanguageChanged: TNotifyEvent read FOnLanguageChanged write FOnLanguageChanged;

    end; {class, TppReportModule}


  {@TppReportModuleTemplate }
  TppReportModuleTemplate = class(TppTemplate)
    private
      FReportModule: TppReportModule;
      FNewReportModule: TppReportModule;
      FSaveOwner: TComponent;
      FSaveReport: TppCustomReport;
      FSaveReportModule: TppReportModule;

    protected

      {functions used by Reader during load }
      procedure LoadCallback(Component: TComponent); override;
      procedure LoadSetName(Reader: TReader; Component: TComponent; var Name: string); override;

      function LoadStart: Boolean; override;
      procedure LoadEnd(aLoaded: Boolean); override;

      property NewReportModule: TppReportModule read FNewReportModule;
      property ReportModule: TppReportModule read FReportModule;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure New; override;



  end; {class, TppReportModuleTemplate }


implementation

{******************************************************************************
 *
 ** R E P O R T   M O D U L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportModule.Create }

constructor TppReportModule.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FReport   := nil;
  FTemplate := TemplateClass.Create(Self);
  FOnRemoveChild := nil;
  FOnAddChild := nil;


  DsInclude([pppcEmpty]);

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppReportModule.CreateForReport }

constructor TppReportModule.CreateForReport(aReport: TppCustomReport);
begin

  Create(aReport.Owner);

  // do this before SetReport() to avoice Report.Modified being set to True
  Name := aReport.GetValidName(Self);

  SetReport(aReport);

end; {constructor, CreateForReport}

{------------------------------------------------------------------------------}
{ TppReportModule.Destroy }

destructor TppReportModule.Destroy;
begin

  Destroying;

  SetReport(nil);

  FTemplate.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportModule.Convert }

procedure TppReportModule.Convert(aVersionNo: Integer);
begin
  {make sure modules have a name}
  if aVersionNo < 5600 then
    begin
      if Name = '' then
        Name := GetValidName(Self);
    end;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppReportModule.GetDataPipelines }

procedure TppReportModule.GetDataPipelines(aList: TList);
begin

end; {procedure, GetDataPipelines}

{------------------------------------------------------------------------------}
{ TppReportModule.TemplateClass }

class function TppReportModule.TemplateClass: TppReportModuleTemplateClass;
begin

  Result := TppReportModuleTemplate;

end; {procedure, TemplateClass}

{------------------------------------------------------------------------------}
{ TppReportModule.Notify }

procedure TppReportModule.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aCommunicator = FReport) then
    case aOperation of
      ppopRemove: SetReport(nil);
      ppopNew: NewReport;
      ppopLanguageChange: LanguageChanged;
    end;

end; {procedure, Notify}


{------------------------------------------------------------------------------}
{ TppReportModule.Transfer }

procedure TppReportModule.Transfer(aSource: TppCommunicator);
var
  lReportModule: TppReportModule;

begin

  {note: ancestor, TppRelative, will transfer the children}

  inherited Transfer(aSource);

  if not (aSource is TppReportModule) then Exit;

  lReportModule := TppReportModule(aSource);

  SetReport(lReportModule.Report);

end;  {procedure, Transfer}


{------------------------------------------------------------------------------}
{ TppReportModule.AddChild }

procedure TppReportModule.AddChild(aChild: TppRelative);

begin

 if IsEmpty then
    DsExclude([pppcEmpty]);

  inherited AddChild(aChild);

  SetModified(True);

  if Assigned(FOnAddChild) then FOnAddChild(aChild);

end; {procedure, AddChild}


{------------------------------------------------------------------------------}
{ TppReportModule.InsertChild }

procedure TppReportModule.InsertChild(aPosition: Integer; aChild: TppRelative);
begin

  if IsEmpty then
    DsExclude([pppcEmpty]);

  inherited InsertChild(aPosition, aChild);

  SetModified(True);

  if Assigned(FOnAddChild) then FOnAddChild(aChild);


end; {procedure, InsertChild}

{------------------------------------------------------------------------------}
{ TppReportModule.RemoveChild }

function TppReportModule.RemoveChild(aChild: TppRelative): Integer;
begin
  if Assigned(FOnRemoveChild) then FOnRemoveChild(aChild);

  Result := inherited RemoveChild(aChild);

  if IsEmpty then
    DsInclude([pppcEmpty]);

  SetModified(True);


end; {function, RemoveChild}


{------------------------------------------------------------------------------}
{ TppReportModule.NewReport }

procedure TppReportModule.NewReport;
begin

end; {procedure, NewReport}

{------------------------------------------------------------------------------}
{ TppReportModule.LanguageChanged }

procedure TppReportModule.LanguageChanged;
begin
  if Assigned(FOnLanguageChanged) then FOnLanguageChanged(Self);


end; {procedure, LanguageChanged}


{------------------------------------------------------------------------------}
{ TppReportModule.SetReport }

procedure TppReportModule.SetReport(aReport: TppCustomReport);
begin

  {remove reference from old report}
  if (FReport <> nil) then
    FReport.RemoveModule(Self);

  FReport := aReport;

  {add reference to new report}
  if (FReport <> nil) then
    FReport.AddModule(Self);

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TppReportModule.SetModified }

procedure TppReportModule.SetModified(aValue: Boolean);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) or
     (csDestroying in ComponentState) then Exit;


  FModified := aValue;

  if FModified and (FReport <> nil) then
    begin
      FReport.Modified := FModified;
      FReport.Reset;
    end;

end; {procedure, SetModified}


{------------------------------------------------------------------------------}
{ TppReportModule.SetTemplate }

procedure TppReportModule.SetTemplate(aTemplate: TppReportModuleTemplate);
begin

  FTemplate.Assign(aTemplate);

end; {procedure, SetTemplate}



{------------------------------------------------------------------------------}
{ TppReportModule.HasParent }

function TppReportModule.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppReportModule.GetParentComponent - required method for Components with HasParent = True }

function TppReportModule.GetParentComponent: TComponent;
begin

  Result := FReport;

end; {procedure, GetParentComponent}

{------------------------------------------------------------------------------}
{ TppReportModule.SetParentComponent - required method for Components with HasParent = True }

procedure TppReportModule.SetParentComponent(Value: TComponent);
begin

  if (Value is TppCustomReport) or (Value = nil) then
    SetReport(TppCustomReport(Value));

end; {procedure, SetParentComponent}

{------------------------------------------------------------------------------}
{ TppReportModule.IsEmpty }

function TppReportModule.IsEmpty: Boolean;
begin
  Result := (ChildCount = 0) or (pppcEmpty in DesignState);

end; {procedure, IsEmpty}


{******************************************************************************
 *
 ** R E P O R T   M O D U L E   T E M P L A T E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.Create }

constructor TppReportModuleTemplate.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FReportModule   := TppReportModule(aOwner);

  if (FReportModule <> nil) then
    Root := FReportModule.Owner;

  FNewReportModule  := nil;
  FSaveReportModule := nil;

  FSaveOwner      := nil;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.Destroy }

destructor TppReportModuleTemplate.Destroy;
begin
  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.New }

procedure TppReportModuleTemplate.New;
var
  lNewReportModule: TppReportModule;
  lReportModuleClass: TComponentClass;

begin
  {create and assign new report}
  lReportModuleClass := TComponentClass(FReportModule.ClassType);
  lNewReportModule := TppReportModule(lReportModuleClass.Create(nil));

  FReportModule.Transfer(lNewReportModule);

  lNewReportModule.Free;

  inherited New;

end; {procedure, New}

{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.LoadStart }

function TppReportModuleTemplate.LoadStart: Boolean;
begin

  inherited LoadStart;

  Result := False;

  if FReportModule = nil then Exit;

  FSaveReport := FReportModule.Report;

  FSaveReportModule := TppReportModuleClass(FReportModule.ClassType).Create(nil);
  FSaveReportModule.DSInclude([pppcTemplateLoading]);

  FSaveReportModule.Transfer(FReportModule);
  FReportModule.DSInclude([pppcTemplateLoading]);

  Result := True;

end; {procedure, LoadStart}


{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.LoadEnd }

procedure TppReportModuleTemplate.LoadEnd(aLoaded: Boolean);
begin

  if aLoaded then
    begin
      {assign new template }
      FReportModule.Transfer(FNewReportModule);
    end
  else
    {restore original ReportModule}
    FReportModule.Transfer(FSaveReportModule);

  FSaveReportModule.Free;

  if FNewReportModule <> nil then
    begin
      FNewReportModule.Free;
      FNewReportModule := nil;
    end;


  FReportModule.Report := FSaveReport;

  {remove template loading to design state}
  FReportModule.DSExclude([pppcTemplateLoading]);

  inherited LoadEnd(aLoaded);


end; {procedure, LoadEnd}

{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.LoadCallback }

procedure TppReportModuleTemplate.LoadCallback(Component: TComponent);
begin

  if (Component is TppReportModule) then
    FNewReportModule := TppReportModule(Component);

end; {procedure, LoadCallback}

{------------------------------------------------------------------------------}
{ TppReportModuleTemplate.LoadSetName }

procedure TppReportModuleTemplate.LoadSetName(Reader: TReader; Component: TComponent; var Name: string);
begin

  inherited LoadSetName(Reader, Component, Name);

  if FReportModule = nil then Exit;

  if (Reader.Root = FReportModule.Owner) and (FReportModule.Owner.FindComponent(Name) <> nil) then
    Name := FReportModule.GetValidName(Component);

end; {procedure, LoadSetName}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppReportModuleTemplate]);

finalization

  UnRegisterClasses([TppReportModuleTemplate]);

end.
