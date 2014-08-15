{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                   BBBBB   }

unit ppDesignDocumentController;

interface

uses
  SysUtils,
  Forms,
  Classes,
  Controls,
  Dialogs,

  ppTypes,
  ppUtils,
  ppComm,
  ppClass,
  ppReport,
  ppDB,
  ppTmplat,
  ppCollectionBase,

  ppWizard,
  ppForms,
  ppUndo,
  ppDesignerForms,
  ppDesignSelection,
  ppDesignEventHub,
  ppDesignerWorkspace,
  ppDesignWorkspaceView,
  ppDesignControllerBase;

type

  TppMRUTemplateItem = class;


  {TppDesignDocumentController}
  TppDesignDocumentController = class(TppDesignControllerBase)
  private
    FPipelineList: TppDataPipelineList;
    FWizardReport: TppCustomReport;
    FOriginalSaveTo: TppSaveToType;
    procedure ehWizard_CreateReport(Sender: TObject; const aDataName: String; var aReport: TObject);
    procedure ehWizard_GetDataNames(Sender: TObject; aDataNameList: TStrings);
    procedure ehWizard_GetFields(Sender: TObject; const aDataName: String; aFieldList: TStrings);
    procedure GetFieldsForPipeline(aDataPipeline: TppDataPipeline; aFields: TStrings);

  protected
    function SaveQuery(aReport: TppCustomReport): Boolean;
    procedure UpdateWindowCaption;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    
    function CloseQuery: Boolean;

    procedure LoadTemplate(aReport: TppCustomReport);
    procedure SaveTemplate(aReport: TppCustomReport);
    procedure New; overload;
    procedure New(aWizardClass: TppReportWizardClass); overload;
    procedure New(aDisplayDialog: Boolean); overload;
    procedure Open; overload;
    procedure Open(aReport: TppCustomReport); overload;
    procedure Open(aMRUItem: TppMRUTemplateItem); overload;
    procedure OpenFile; overload;
    procedure OpenFile(aReport: TppCustomReport); overload;
    procedure Preview;
    procedure Print;
    function Save: Boolean; overload;
    function Save(aReport: TppCustomReport): Boolean; overload;
    function SaveAs: Boolean; overload;
    function SaveAs(aReport: TppCustomReport): Boolean; overload;
    procedure SaveFile; overload;
    procedure SaveFile(aReport: TppCustomReport); overload;
    procedure UpdateMRU(aTemplate: TppTemplate);

  end;


  {TppMRUTemplateItem}
  TppMRUTemplateItem = class
  private
    FDescription: String;
    FFolderId: Integer;
    FOffset: Integer;
    FSaveTo: TppSaveToType;
    
    function GetAsCommaText: String;
    
  public
    class function FromCommaText(aCommaText: String): TppMRUTemplateItem;
    class function FromTemplate(aTemplate: TppTemplate): TppMRUTemplateItem;

    procedure AssignFrom(aTemplate: TppTemplate); overload;
    procedure AssignFrom(aCommaText: String); overload;
    procedure AssignFrom(aStrings: TStrings); overload;
    procedure AssignTo(aTemplate: TppTemplate); overload;

    property AsCommaText: String read GetAsCommaText;
    property Description: String read FDescription write FDescription;
    property FolderId: Integer read FFolderId write FFolderId;
    property Offset: Integer read FOffset write FOffset;
    property SaveTo: TppSaveToType read FSaveTo write FSaveTo;

  end;


  {TppMRUTemplateItemCollection}
  TppMRUTemplateItemCollection = class(TppCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppMRUTemplateItem;
    function GetItemForName(aName: String): TppMRUTemplateItem;

  public
    constructor Create; override;
    procedure Delete(aIndex: Integer);

    function IndexOf(const aName: String): Integer;
    procedure Insert(aObject: TppMRUTemplateItem);
    procedure MoveToFirst(aCurIndex: Integer);
    procedure RemoveLast;

    property ItemsByNames[Name: String]: TppMRUTemplateItem read GetItemForName;
    property Items[Index: Integer]: TppMRUTemplateItem read GetItemForIndex; default;

  end;



implementation

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Create}

constructor TppDesignDocumentController.Create(aOwner: TComponent);
begin
  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Destroy}

destructor TppDesignDocumentController.Destroy;
begin

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.CloseQuery}

function TppDesignDocumentController.CloseQuery: Boolean;
var
  lReports: TStringList;
  liIndex: Integer;
  lReport: TppCustomReport;
begin

  Result := True;

  if (MainReport = nil) then Exit;

  lReports := TStringList.Create;

  try

    {get list of all sub-reports - order is important here }
    MainReport.GetSubReports(lReports);

    lReports.InsertObject(0,'Main', MainReport);

    liIndex := lReports.Count-1;

    while Result and (liIndex >= 0) do
      begin
        lReport := TppCustomReport(lReports.Objects[liIndex]);
        Result := SaveQuery(lReport);
        Dec(liIndex);
      end;

  finally
    lReports.Free;
    
  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.WizardCreateReportEvent}

procedure TppDesignDocumentController.ehWizard_CreateReport(Sender: TObject; const aDataName: String; var aReport: TObject);
var
  lReport: TppBandedReport;
  lEventParams: TppCreatReportEventParams;

begin
  lReport := TppBandedReport(FWizardReport);

  if not(EventHub.EndUserEvents.mcCreateReport.Empty) then
    begin
      lEventParams := TppCreatReportEventParams.Create;
      lEventParams.DataName := aDataName;
      lEventParams.Report := lReport;

      EventHub.EndUserEvents.mcCreateReport.Notify(Sender, lEventParams);

      aReport := lEventParams.Report;

      lEventParams.Free;

    end

  else
    begin
      {note: cannot use FCurrentReport here, for optimization the report has been
             temporarily disconnected}
      if (lReport <> nil) then
        begin
          lReport.FreeBandsAndGroups;
          lReport.CreateDefaultBands;
        end;

      if (aDataName <> '') then
        lReport.DataPipeline := FPipelineList.Pipelines[aDataName];

      aReport := lReport;


    end;

end; {procedure, WizardCreateReportEvent}

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.WizardGetDataNamesEvent}

procedure TppDesignDocumentController.ehWizard_GetDataNames(Sender: TObject; aDataNameList: TStrings);
begin

  if not(EventHub.EndUserEvents.mcGetDataNames.Empty) then
    EventHub.EndUserEvents.mcGetDataNames.Notify(Sender, aDataNameList)
  else
    aDataNameList.Assign(FPipelineList);

end; {procedure, WizardGetDataNamesEvent}

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.WizardGetFieldsEvent}

procedure TppDesignDocumentController.ehWizard_GetFields(Sender: TObject; const aDataName: String; aFieldList: TStrings);
var
  lEventParams: TppGetFieldsEventParams;
begin

  if not(EventHub.EndUserEvents.mcGetFields.Empty) then
    begin
      lEventParams := TppGetFieldsEventParams.Create;
      lEventParams.DataName := aDataName;
      lEventParams.FieldList := aFieldList;
      EventHub.EndUserEvents.mcGetFields.Notify(Sender, lEventParams);

      lEventParams.Free;
    end
  else
    GetFieldsForPipeline(FPipelineList.Pipelines[aDataName], aFieldList);



end; {procedure, WizardGetFieldsEvent}

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.GetFieldsForPipeline }

procedure TppDesignDocumentController.GetFieldsForPipeline(aDataPipeline: TppDataPipeline; aFields: TStrings);
var
 liField: Integer;
 lField: TppField;
begin

  if (aDataPipeline = nil) then Exit;
  
  aFields.Clear;

  for liField := 0 to aDataPipeline.FieldCount - 1 do
    begin
      lField := aDataPipeline.Fields[liField];
      if lField.Selectable then
        aFields.AddObject(lField.FieldAlias, lField);
    end;

  if (aFields is TStringList) then
    TStringList(aFields).Sort;

end; {procedure, GetFieldsForPipeline}

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.LoadTemplate }

procedure TppDesignDocumentController.LoadTemplate(aReport: TppCustomReport);
begin

  if not CheckReportDelete or not CheckComponentAdd then Exit;

  if (aReport = nil) then Exit;

  if (Selection <> nil) then
    Selection.Clear();

  try
    // load template
    if not(EventHub.EndUserEvents.mcCustomOpenDoc.Empty) then
      EventHub.EndUserEvents.mcCustomOpenDoc.Notify(aReport, aReport)
    else
      aReport.Template.Load;

    // update MRU, if main report
    if (aReport = MainReport) and (FOriginalSaveTo = aReport.Template.SaveTo) then
      UpdateMRU(aReport.Template);

  finally
    if (csDesigning in aReport.ComponentState) and not aReport.SaveAsTemplate then
      aReport.Modified := True;

    if aReport.SaveAsTemplate and (FOriginalSaveTo = aReport.Template.SaveTo) then
      UpdateWindowCaption;

    UndoManager.Clear;

  end;
  
end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.New}

procedure TppDesignDocumentController.New;
begin

  if not CheckReportDelete or not CheckComponentAdd then Exit;

  if (Report = nil) then Exit;

  {ask user whether to save changes for current template}
  if not SaveQuery(Report) then Exit;

  New(ppDefaultBlankReportWizard);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.New(aWizardClass) }

procedure TppDesignDocumentController.New(aWizardClass: TppReportWizardClass);
var
  lWizard: TppCustomReportWizard;
  lbPreview: Boolean;
  lbWizardResult: Boolean;
begin

  if (aWizardClass = nil) then Exit;

  FWizardReport := Report;

  {clear selection}
  Selection.Clear;

  UndoManager.Clear;
  UndoManager.Active := False;

  lWizard := aWizardClass.Create(Self);
  lWizard.AskForName := False;

  if (Report.DataPipeline <> nil) then
    lWizard.DataName := FWizardReport.DataPipeline.UserName;

  lWizard.OnGetDataNames := ehWizard_GetDataNames;
  lWizard.OnGetFields := ehWizard_GetFields;
  lWizard.OnCreateReport := ehWizard_CreateReport;

  FPipelineList := TppDataPipelineList.Create(FWizardReport);

  FWizardReport.BeginUpdate;

  try
    lbWizardResult := lWizard.Execute;
    lbPreview := lbWizardResult and (lWizard.NextAction = ppnaPreview);

  finally
     FWizardReport.EndUpdate;
     UndoManager.Active := True;

  end;

  if lbWizardResult then
    FWizardReport.Modified := True;

  EventHub.ReportEvents.mcNewEnd.Notify(Self, nil);


  if lbPreview and (EventHub <> nil) then
    EventHub.EndUserEvents.mcPreview.Notify(Self, nil);

  lWizard.Free;

  FPipelineList.Free;
  FPipelineList := nil;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.New }

procedure TppDesignDocumentController.New(aDisplayDialog: Boolean);
var
  lNewDialog: TppCustomNewDialog;
  lFormClass: TFormClass;
begin

  if (Report = nil) then Exit;

  if aDisplayDialog then
    begin

      {get the registered dialog class}
      lFormClass := ppGetFormClass(TppCustomNewDialog);

      {create the dialog}
      lNewDialog := TppCustomNewDialog(lFormClass.Create(Self));
      lNewDialog.Report := Report;
      lNewDialog.LanguageIndex := Report.LanguageIndex;
      ppGetReportWizardClasses(lNewDialog.WizardClasses);

      {show dialog, should return a valid wizard class}
      if lNewDialog.ShowModal = mrOK then
        New(TppReportWizardClass(lNewDialog.CreateClass));

      lNewDialog.Free;
    end
  else
    New();


end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Open }

procedure TppDesignDocumentController.Open;
begin

  Open(MainReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Open(aReport)}

procedure TppDesignDocumentController.Open(aReport: TppCustomReport);
var
  lsSaveTemplateName: String;
  lSaveTemplateProps: TppMRUTemplateItem;
begin

  if not CheckReportDelete or not CheckComponentAdd then Exit;

  if (aReport = nil) then Exit;

  {ask user whether to save changes for current template}
  if not SaveQuery(aReport) then Exit;

  FOriginalSaveTo := MainReport.Template.SaveTo;

  lSaveTemplateProps := TppMRUTemplateItem.FromTemplate(aReport.Template);

  try
    if aReport.Template.ShowOpenDialog then
      try
        LoadTemplate(aReport);
      except
        aReport.Template.Description := lsSaveTemplateName;
        lSaveTemplateProps.AssignTo(aReport.Template);

        raise;

      end; {try except, load template }

  finally
    lSaveTemplateProps.Free;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Open}

procedure TppDesignDocumentController.Open(aMRUItem: TppMRUTemplateItem);
var
  lSaveTemplateProps: TppMRUTemplateItem;
begin

  {check whether this template is already loaded}
  if (aMRUItem.Description = MainReport.Template.Description) then Exit;

  {ask user whether to save changes for current template}
  if not SaveQuery(MainReport) then Exit;

  {save current template props}
  FOriginalSaveTo := MainReport.Template.SaveTo;

  lSaveTemplateProps := TppMRUTemplateItem.FromTemplate(MainReport.Template);

  {assign MRU template props}
  aMRUItem.AssignTo(MainReport.Template);

  {load template}
  try
    try
      LoadTemplate(MainReport);
    except
      lSaveTemplateProps.AssignTo(MainReport.Template);
      raise;
    end;

  finally
    {restore template props}
    if (FOriginalSaveTo <> MainReport.Template.SaveTo) then
      lSaveTemplateProps.AssignTo(MainReport.Template);

    lSaveTemplateProps.Free;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.OpenFile}

procedure TppDesignDocumentController.OpenFile;
begin

  OpenFile(MainReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.OpenFile}

procedure TppDesignDocumentController.OpenFile(aReport: TppCustomReport);
var
  lsSaveTemplateName: String;
  liOffset: Integer;
  lSaveTo: TppSaveToType;
  lbSaveAsTemplate: Boolean;
  lFormat: TppFormatType;
begin

  if not CheckReportDelete or not CheckComponentAdd then Exit;

  if (aReport = nil) then Exit;

  {ask user whether to save changes for current template}
  if not SaveQuery(aReport) then Exit;

  {save current settings}
  FOriginalSaveTo  := MainReport.Template.SaveTo;;
  lSaveTo  := aReport.Template.SaveTo;;
  lsSaveTemplateName := aReport.Template.Description;
  liOffset := aReport.Template.Offset;
  lbSaveAsTemplate := aReport.SaveAsTemplate;
  lFormat := aReport.Template.Format;

  if not aReport.Template.ShowFileOpenDialog then Exit;

  {modify settings}
  aReport.Template.SaveTo := stFile;

  {load template}
  try
    LoadTemplate(aReport);
  finally
    if (aReport.Template.SaveTo <> lSaveTo) then
      begin
        aReport.Modified := True;
        aReport.SaveAsTemplate := lbSaveAsTemplate;
        aReport.Template.Format := lFormat;
      end;

    
    aReport.Template.SaveTo := lSaveTo;
    aReport.Template.OffSet := liOffset;
    aReport.Template.Description := lsSaveTemplateName;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Preview}

procedure TppDesignDocumentController.Preview;
begin

  // the designer handles this event by selecting the preview tab 
  if (EventHub <> nil) then
    EventHub.EndUserEvents.mcPreview.Notify(MainReport, nil);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Print}

procedure TppDesignDocumentController.Print;
var
  lsSaveDeviceType: String;
begin

  if (MainReport <> nil) then
    begin
      lsSaveDeviceType := MainReport.DeviceType;

      MainReport.DeviceType := dtPrinter;
      MainReport.DSInclude([pppcDesignPrinting]);


      try
        MainReport.Print;
        
      finally
        MainReport.DeviceType := lsSaveDeviceType;
      MainReport.DSExclude([pppcDesignPrinting]);

      end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Save}

function TppDesignDocumentController.Save: Boolean;
begin

  Result := Save(MainReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Save(aReport) }

function TppDesignDocumentController.Save(aReport: TppCustomReport): Boolean;
begin

  {default result is true}
  Result := True;

  if aReport = nil then Exit;

  if (aReport.Template.Description = '') or
     (Pos(ppLoadStr(571), aReport.Template.Description) > 0) then
     
     Result := SaveAs(aReport)

  else if (aReport.Template.SaveTo = stFile) and
          (aReport.Template.ReadOnly) then
    begin
      MessageDlg(ppLoadStr(51), mtWarning,[mbOK], 0); {'File is read-only.'}

      Result := SaveAs(aReport);
    end

  else
    SaveTemplate(aReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.Save }

function TppDesignDocumentController.SaveAs: Boolean;
begin

  Result := SaveAs(MainReport);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.SaveAs(aReport) }

function TppDesignDocumentController.SaveAs(aReport: TppCustomReport): Boolean;
begin

  Result := False;

  if aReport = nil then Exit;

  if aReport.Template.ShowSaveDialog then
    begin
      SaveTemplate(aReport);

      if (aReport = MainReport) then
        UpdateMRU(aReport.Template);

      Result := True;

    end;

end;


{------------------------------------------------------------------------------}
{ TppDesignDocumentController.SaveQuery }

function TppDesignDocumentController.SaveQuery(aReport: TppCustomReport): Boolean;
var
  lsMessage: String;
  lsName: String;
begin

  {default result is true}
  Result := True;

  if (aReport = nil) or not(aReport.SaveAsTemplate) or not(aReport.Modified) then Exit;

  {ask user whether to save changes }
  lsMessage := ppLoadStr(357); {'Save changes to <filename>?'}
  lsMessage := ppSetMessageParameters(lsMessage);

  if aReport.Template.Description = '' then
    aReport.Template.Description := ppLoadStr(571); {'New Report'};

  lsName := aReport.Caption + ': ' + aReport.Template.Description;

  lsMessage := Format(lsMessage, [lsName]);

  case MessageDlg(lsMessage, mtConfirmation,[mbYes, mbNo, mbCancel], 0) of

     mrYes:     Result := Save(aReport);

     mrCancel:  Result :=  False;

  end;

end;


{------------------------------------------------------------------------------}
{ TppDesignDocumentController.SaveTemplate}

procedure TppDesignDocumentController.SaveTemplate(aReport: TppCustomReport);
begin

  if aReport = nil then Exit;

  if not(EventHub.EndUserEvents.mcCustomSaveDoc.Empty) then
    EventHub.EndUserEvents.mcCustomSaveDoc.Notify(aReport, aReport)
  else
    aReport.Template.Save;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.SaveToFile}

procedure TppDesignDocumentController.SaveFile;
var
  lSaveFormat: TppFormatType;
begin

  if MainReport = nil then Exit;

  {export as ASCII}
  lSaveFormat := MainReport.Template.Format;

  MainReport.Template.Format := ftASCII;

  try
    SaveFile(MainReport);
  finally
    MainReport.Template.Format := lSaveFormat;

  end;

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.SaveToFile}

procedure TppDesignDocumentController.SaveFile(aReport: TppCustomReport);
var
  lSaveTo: TppSaveToType;
  lsSaveTemplateName: String;
begin

  if (aReport = nil) then Exit;

  lSaveTo  := aReport.Template.SaveTo;
  lsSaveTemplateName := aReport.Template.Description;

  {modify settings}
  aReport.Template.SaveTo := stFile;

  try

    if aReport.Template.ShowFileSaveDialog then
      SaveTemplate(aReport);

   finally
    aReport.Template.SaveTo := lSaveTo;
    aReport.Template.Description := lsSaveTemplateName;
    UpdateWindowCaption;

  end;


end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.UpdateMRU}

procedure TppDesignDocumentController.UpdateMRU(aTemplate: TppTemplate);
begin

  if (aTemplate = nil) or (EventHub = nil) then Exit;

  EventHub.EndUserEvents.mcUpdateMRU.Notify(Self, aTemplate);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.UpdateWindowCaption}

procedure TppDesignDocumentController.UpdateWindowCaption;
begin

  EventHub.EndUserEvents.mcUpdateWindowCaption.Notify(Self, nil);

end;

{------------------------------------------------------------------------------}
{ TppDesignDocumentController.AssignFrom}

procedure TppMRUTemplateItem.AssignFrom(aCommaText: String);
var
  lStrings: TStringList;
begin

  lStrings := TStringList.Create;

  try
  lStrings.CommaText := aCommaText;

  AssignFrom(lStrings);

  finally
    lStrings.Free;
  end;

end;


{******************************************************************************
 *
 **  MRU Template Item
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMRUTemplateItem.AssignFrom}

procedure TppMRUTemplateItem.AssignFrom(aTemplate: TppTemplate);
begin

  FDescription := aTemplate.Description;
  FSaveTo := aTemplate.SaveTo;
  FOffSet := aTemplate.Offset;
  FFolderID := aTemplate.DatabaseSettings.FolderId;

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItem.AssignFrom}

procedure TppMRUTemplateItem.AssignFrom(aStrings: TStrings);
begin

  FDescription := aStrings[0];

  {set new template props}
  if aStrings.Count > 1 then
    FSaveTo := TppSaveToType(StrToInt(aStrings[1]));

  if aStrings.Count > 2 then
    FOffSet := StrToInt(aStrings[2])
  else
    FOffSet := 0;

  if aStrings.Count > 3 then
    FFolderId := StrToInt(aStrings[3])
  else
    FFolderId := 0;

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItem.AssignTo}

procedure TppMRUTemplateItem.AssignTo(aTemplate: TppTemplate);
begin

  aTemplate.SaveTo := FSaveTo;
  aTemplate.Offset := FOffset;
  aTemplate.Description := FDescription;
  aTemplate.DatabaseSettings.FolderId := FFolderID;

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItem.FromCommaText}

class function TppMRUTemplateItem.FromCommaText(aCommaText: String): TppMRUTemplateItem;
begin

  Result := Create;
  Result.AssignFrom(aCommaText);

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItem.FromTemplate}

class function TppMRUTemplateItem.FromTemplate(aTemplate: TppTemplate): TppMRUTemplateItem;
begin

  Result := Create;
  Result.AssignFrom(aTemplate);

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItem.GetAsCommaText}

function TppMRUTemplateItem.GetAsCommaText: String;
var
  lStrings: TStringList;
begin

  lStrings := TStringList.Create;

  try
    lStrings.Add(FDescription);
    lStrings.Add(IntToStr(Ord(FSaveTo)));
    lStrings.Add(IntToStr(FOffset));
    lStrings.Add(IntToStr(FFolderId));

    Result := lStrings.CommaText;
  finally
   lStrings.Free;

  end;

end;


{******************************************************************************
 *
 **  MRU Template Item Collection
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.Create}

constructor TppMRUTemplateItemCollection.Create;
begin

  inherited;

  InnerList.OwnsObjects := True;

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.Delete}

procedure TppMRUTemplateItemCollection.Delete(aIndex: Integer);
begin
  InnerList.Delete(aIndex);
end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.GetItemForIndex}

function TppMRUTemplateItemCollection.GetItemForIndex(aIndex: Integer): TppMRUTemplateItem;
begin
  Result := TppMRUTemplateItem(InnerList[aIndex]);

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.GetItemForName}

function TppMRUTemplateItemCollection.GetItemForName(aName: String): TppMRUTemplateItem;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aName);

  if (liIndex >= 0) then
    Result := GetItemForIndex(liIndex)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.IndexOf}

function TppMRUTemplateItemCollection.IndexOf(const aName: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < InnerList.Count) do
    begin
      if (GetItemForIndex(liIndex).Description = aName) then
        lbFound := True
      else
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex
  else
    Result := -1;

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.Insert}

procedure TppMRUTemplateItemCollection.Insert(aObject: TppMRUTemplateItem);
begin
  InnerList.Insert(0, aObject);
end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.MoveToFirst}

procedure TppMRUTemplateItemCollection.MoveToFirst(aCurIndex: Integer);
begin
  InnerList.Move(aCurIndex, 0);

end;

{------------------------------------------------------------------------------}
{ TppMRUTemplateItemCollection.RemoveLast}

procedure TppMRUTemplateItemCollection.RemoveLast;
begin

  InnerList.Delete(InnerList.Count-1);

end;



end.
