{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppSubRpt;

interface

{$I ppIfDef.pas}

uses
  SysUtils,
  Classes,

  ppComm,
  ppClass,
  ppDevice,
  ppStrtch,
  ppTypes,
  ppUtils,
  ppCtrls,
  ppReport,
  ppPrintr,
  ppPrnDev,
  ppDrwCmd,
  ppDB,
  ppRTTI,
  ppOutlineSettings,
  ppOutlineParticipant,
  ppOutlineReportNodeCreator;

type

  {@TppSubReport

    This component provides three different capabilities based on the value of
    the PrintBehavior property.

    When PrintBehavior is set to pbFixed, the dimensions of the SubReport
    component are used as the page size of the report.  The report generates a
    single page fitted to these dimensions. This setting is most often used when
    a report of fixed size, such as a table, needs to be printed at a
    pre-defined location on the page.

    When PrintBehavior is set to pbChild, the width of the SubReport component
    is used as the page width and the page height of the parent report is used
    (as specified in the parent report's PrinterSetup property).  The report
    begins printing at the first available location on the page and then
    'stretches' across as many pages as are necessary to complete the report.
    SubReports set to pbChild behave like stretching memos and are well-suited
    for most 'multiple detail band' requirements. Because child reports use the
    width of the SubReport component as the page width, they are also useful for
    some side-by-side reporting effects. Note:When creating child type
    subreports, you must set the parent band PrintHeight to phDynamic;
    otherwise, the report will not print.

    When PrintBehavior is set to pbSection, the SubReport uses its own
    PrinterSetup property to determine the page dimensions. When the report
    completes printing, the last page is completed and control is returned to
    the parent report at the beginning of the next page. When several
    independent reports need to be 'chained' together, pbSection SubReports are
    generally the best choice. (Note: In order to link several reports together,
    place each subsequent SubReport in the SummaryBand of the preceding report.)

    Section type SubReports also have the capacity to change the printer
    settings for the portion of the report in which they generate.  Use the
    SubReport's PrinterSetup property to specify the different settings, just as
    you would a normal report.  If you specify a different printer in
    PrinterSetup than that of the parent report, then a NewPrintJob will be
    started on that printer when the report generates.  This means that
    different sections of a report can not only use different printer settings,
    but that they can also be sent to different printers.

    Tip: In order to keep section type SubReports from taking up any space in
     the parent report, place the SubReport in a band by itself and set the
     Band's PrintHeight property to phDynamic.}

  {@TppSubReport.DrillDownComponent

    This property applies to subreports that have the PrintBehavior set to
    pbChild. When assigned, this property indicates the 'hot' component which,
    when clicked, causes the current page in the Print Preview form to be
    regenerated with the subreport expanded.  This creates the effect of a
    'drill-down' subreport.  This technique is shown in demo 152.}

  {@TppSubReport.ExpandAll

    This property applies to subreports that have the PrintBehavior set to
    pbChild and the DrillDownComponent assigned. When set to True, all instances
    of the subreport print expanded.  The drill-down component is no longer
    'hot' in the print preview window.  In order to set the ExpandAll property
    for all subreports in a report, call the Report.ExpandDrillDowns procedure.
    A drill-down subreport is shown in demo 152.}

  {@TppSubReport.KeepTogether

    Defaults to False. The KeepTogether property controls the pagination of a
    ChildType SubReport when the contents cannot fit on the current page.
    Normally the contents are printed to the bottom of the available page space
    and then continued on subsequent pages until complete.  If KeepTogether is
    True, the SubReport will advance to the next page when the contents do not
    fit.}

  {@TppSubReport.NewPrintJob

    When the PrintBehavior property is set to pbSection, then this property
    determines whether a new print job is started when the subreport is sent to
    the printer.  This property can be used when a portion of a report needs to
    be printed to a separate printer. If you need to change printer settings for
    a certain section, you can do so without starting a new print job. Simply
    set the value of the appropriate PrinterSetup properties (Orientation,
    PaperName, BinName, etc.) and these settings will be applied as the report
    prints.}

  {@TppSubReport.OutlineSettings

    Controls the behavior of outline node generation for a SubReport that
    has print behavior of pbSection. When enabled, an outline tree structure is
    dynamically generated by the report engine and rendered by the report
    previewer.

    From the report designer, select the Report|Outline Settings... menu
    option to access a dialog that enables simple visual configuration of
    outline settings for all relevant objects in the report.

    Use the CreateNode boolean property to control whether an outline node
    is created each time a section prints on a page. OutlineSettings can also
    be configured for the TppReport and TppGroup objects.}

  {@TppSubReport.ParentPrinterSetup

    Determines whether the values for the PrinterSetup property should be copied
    from the parent report.  If ParentPrinterSetup is False, then one or more of
    the PrinterSetup properties differ from the parent report.}

  {@TppSubReport.PrintBehavior

    The value of the PrintBehavior property determines how a subreport prints
    within the master report. These are the possible values:

    <Table>
    Value		        Meaning
    ----------      -----------
    pbFixed	        A single page prints based on the dimensions and
                    position of the subreport component.
    pbChild	        The report prints to completion, using the subreport
                    components width as the page width and stretching over
                    several pages until printing is complete.
    pbSection	      The report prints as a separate section, starting a new
                    page when it begins and finishing the last page when it
                    ends. The PrinterSetup property is used to determine the
                    page size and printer settings.
    </Table>

    Note: When creating child type subreports you must set the parent band
    PrintHeight to phDynamic; otherwise, the report will not print.}

  {@TppSubReport.Report

    Pointer to the report object contained within the component.}

  {@TppSubReport.ResetPageNo

    Use ResetPageNo to enable subset page numbering. In subset page numbers, the
    page numbers and page count of the subreport are displayed instead of the
    master report page numbers.

    ResetPageNo is only available in Section style subreports.}

  {@TppSubReport.TraverseAllData

    This property applies to subreports that have the PrintBehavior set to
    pbFixed. When set to True, this property indicates that the subreport will
    continue to print (print on additional pages in the same exact position)
    until all data is traversed.  By default the fixed type subreport truncates
    the data (i.e. prints once per band, but does not overflow if all data can't
    fit in the space of the subreport).}

  TppSubReport = class(TppStretchable, IppOutlineParticipant)
    private
      FAlreadyPageBreak: Boolean;
      FExpandAll: Boolean;
      FFirstPassCompleted: Boolean;
      FCount: Longint;
      FDrillDownComponent: TppComponent;
      FExpansions: TStrings;
      FLastPageCached: Longint;
      FMainSection: Boolean;
      FNewPage: Boolean;
      FNewPrintJob: Boolean;
      FOutlineChildren: TList;
      FOutlineSettings: TppOutlineSettings;
      FPageGenerated: Boolean;
      FParentPrinterSetup: Boolean;
      FPrintBehavior: TppPrintBehaviorType;
      FPrinterDevice: TppPrinterDevice;
      FReport: TppCustomReport;
      FReportAbsolutePageCount: Longint;
      FReportCompleted: Boolean;
      FReportGenerated: Boolean;
      FReportPageNo: Longint;
      FResetPageNo: Boolean;
      FRetainExpansions: Boolean;
      FSaveStopPosition: Longint;
      FSectionSubReportsOnly: Boolean;
      FStartReport: Boolean;
      FTraverseAllData: Boolean;

{$IFDEF CacheTrack}
      FCaches: TStringList;
{$ENDIF}

      procedure CaptionChange;
      procedure GenerateReport;
      function  GetReportKey: String;
      function  GetExpansion(aIndex: Integer): String;
      function  GetExpansionCount: Integer;
      function  GetChildReport: TppCustomReport;
      function  GetDrillDownComponent: TppComponent;
      procedure SetDrillDownComponent(aComponent: TppComponent);
      procedure SetExpandAll(Value: Boolean);
      procedure SetNewPage(Value: Boolean);
      procedure SetNewPrintJob(Value: Boolean);
      procedure SetOutlineSettings(aOutlineSettings: TppOutlineSettings);
      procedure SetParentPrinterSetup(Value: Boolean);
      procedure SetPrintBehavior(aPrintBehavior: TppPrintBehaviorType);
      procedure SetResetPageNo(Value: Boolean);
      procedure SetTraverseAllData(Value: Boolean);
      procedure UpdateCache;
      procedure UpdateDefaultBands;

      {child/fixed related}
      procedure GenerateChild;
      procedure GenerateFixed;
      procedure GetLastPageCachedEvent(Sender: TObject; var aPageNo: Longint);
      procedure InitChild;

      {drill down related}
      procedure DrillDownDrawCommandClickEvent(Sender: TObject; aDrawCommand: TObject);
      procedure DrillDownDrawCommandCreateEvent(Sender: TObject; aDrawCommand: TObject);
      procedure FreeExpansions;

      {section related}
      procedure CreatePrinterDevice;
      procedure FreePrinterDevice;
      procedure GenerateSection;
      procedure InitSection;
      procedure SectionAfterSendPageEvent;

      {conversion for 5.10}
      procedure ReadCaption(Reader: TReader);

    protected
      procedure DefineProperties(Filer: TFiler); override;
      function  CalcPrintTop: Longint; override;
      procedure CalcSpaceUsed; override;
      procedure CreateDrawCommand(aPage: TppPage); override;
      function  GetCaption: String; override;
      procedure SetBand(aBand: TppBand); override;
      procedure SetDataPipeline(aDataPipeline: TppDataPipeline); override;
      procedure SetParentWidth(Value: Boolean); override;
      procedure SetRegion(aComponent: TppComponent); override;
      procedure SetShiftRelativeTo(aStretchable: TppStretchable); override;
      procedure SetUserName(const Value: TComponentName); override;

      property NewPage: Boolean read FNewPage write SetNewPage default False;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      procedure AddExpansion(const aExpansionKey: String);
      procedure AfterDesignerCreate; override;
      procedure AfterPrint; override;
      procedure BeforePrint; override;
      procedure ChangeOwner(aNewOwner: TComponent); override;
      procedure ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String); override;
      procedure CreateReport(aMainReport: TppReport);
      function  DrillDownExpanded: Boolean;
      function  FindExpansion(const aExpansionKey: String): Integer;
      procedure FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String); override;
      procedure GetDataPipelines(aDataPipelines: TList); override;
      function  GetExpansionKey: String;
      function  HasColor: Boolean; override;
      function  HasFont: Boolean; override;
      function  IsDrillDown: Boolean;
      procedure Init; override;
      function  IsClickable: Boolean; override;
      procedure LanguageChanged; override;
      procedure RemoveExpansion(const aExpansionKey: String);
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      procedure SetReportProperty(aReport: TppCustomReport);
      procedure StartOfMainReport; override;
      procedure StartOfParentReport; override;

      {IppOutlineParticipant}
      function iOutlineGetChildren: TList;
      function iOutlineGetParent: TppCommunicator;
      function iOutlineNodeCreatorClass: TComponentClass;
      function iOutlineSettings: TppOutlineSettings;
      procedure iOutlineSettingsChanged;

      property Count: Integer read FCount;
      property CurrentReportKey: String read GetReportKey;
      property CurrentExpansionKey: String read GetExpansionKey;
      property Expansions[Index: Integer]: String read GetExpansion;
      property ExpansionCount: Integer read GetExpansionCount;
      property Report: TppCustomReport read GetChildReport;

    published
      property Anchors;
      property BottomOffset;
      property DataPipeline stored False;
      property DrillDownComponent: TppComponent read GetDrillDownComponent write SetDrillDownComponent;
      property ExpandAll: Boolean read FExpandAll write SetExpandAll;
      property KeepTogether;
      property Height;
      property Left;
      property MinHeight;
      property NewPrintJob: Boolean read FNewPrintJob write SetNewPrintJob;
      property OverFlowOffset;
      property OutlineSettings: TppOutlineSettings read FOutlineSettings write SetOutlineSettings;
      property ParentPrinterSetup: Boolean read FParentPrinterSetup write SetParentPrinterSetup default True;
      property ParentWidth default True;
      property PrintBehavior: TppPrintBehaviorType read FPrintBehavior write SetPrintBehavior default pbChild;
      property ResetPageNo: Boolean read FResetPageNo write SetResetPageNo default True;
      property ShiftRelativeTo;
      property StopPosition;
      property TraverseAllData: Boolean read FTraverseAllData write SetTraverseAllData;
      property Top;
      property Visible;
      property Width;

  end; {class, TppSubReport}

  {@TppDrillDownExpansion }
  TppDrillDownExpansion = class
    private
      FCount: Longint;

    public
      property Count: Longint read FCount write FCount;

  end; {class, TppDrillDownExpansion}

  { TppSubReportSaveRec }
  TppSubReportSaveRec = record
    FDrawComponent: Boolean;
    FDrawShifter: Boolean;
    FKeptTogether: Boolean;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;

    FAlreadyPageBreak: Boolean;
    FCount: Longint;
    FStartReport: Boolean;
    FFirstCachePageNo: Longint;
    FLastPageCached: Longint;
    FReportCompleted: Boolean;
    FReportPageNo: Longint;
    FReportAbsolutePageCount: Longint;
    FFirstPassCompleted: Boolean;
    FMasterPageNo: Longint;
  end; {record, TppSubReportSaveRec}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppSubReportRTTI }
  TraTppSubReportRTTI = class(TraTppStretchableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppSubReportRTTI}


implementation

uses
  ppClasUt, ppBands;

{******************************************************************************
 *
 ** S U B R E P O R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubReport.Create }

constructor TppSubReport.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);
           
  EventNotifies := EventNotifies + [ciEngineAfterSendPage];

  FAlreadyPageBreak     := False;
  FCount                := 0;
  FDrillDownComponent   := nil;
  FExpansions           := TStringList.Create;
  FExpandAll            := False;
  FFirstPassCompleted   := False;
  FLastPageCached       := 0;
  FMainSection          := False;
  FNewPage              := False;
  FNewPrintJob          := False;                         
  FPageGenerated        := False;
  FParentPrinterSetup   := True;
  FPrintBehavior        := pbChild;
  FReport               := nil;
  FReportAbsolutePageCount := 0;
  FReportPageNo         := 0;
  FReportCompleted      := False;
  FResetPageNo          := True;
  FRetainExpansions     := False;
  FSaveStopPosition     := 0;
  FStartReport          := False;
  FTraverseAllData      := False;

{$IFDEF CacheTrack}
  FCaches := TStringList.Create;
{$ENDIF}

  {set inherited properties}
  CacheRecordSize := SizeOf(TppSubReportSaveRec);
  ParentWidth := True;
  spHeight := 19;
  Stretch := True;

  {properties inherited from TppPrintable}
  DefaultPropName     := 'DataPipeline';
  DefaultPropEditType := etDataPipelineList;

  FOutlineChildren := nil;
  FOutlineSettings := TppOutlineSettings.Create(Self);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppSubReport.Destroy }

destructor TppSubReport.Destroy;
begin

{$IFDEF CacheTrack}
  FCaches.Free;
{$ENDIF}

  FreeExpansions;

  FExpansions.Free;

  FPrinterDevice.Free;

  FReport.Free;
  FOutlineSettings.Free;

  if (FOutlineChildren <> nil) then FOutlineChildren.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppSubReport.Notify}

procedure TppSubReport.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  {note: notification logic is ommitted because it causes an AV while streaming}
{ if (aCommunicator = FReport) and (aOperation = ppopRemove) then
    FReport := nil;}

  if (aCommunicator = FDrillDownComponent) and (aOperation = ppopRemove) then
    FDrillDownComponent := nil

  else if (aCommunicator = DataPipeline) and (aOperation = ppopRemove) and (pppcDesigning in DesignState) then
    CaptionChange

  else if not(Printing) and (pppcDesigning in DesignState) and
     (aOperation in [ppopUserNameChange, ppopDataChange]) then
    CaptionChange;


end; {procedure, Notify}
        
{------------------------------------------------------------------------------}
{ TppSubReport.EventNotify}

procedure TppSubReport.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aEventID = ciEngineAfterSendPage) then
    SectionAfterSendPageEvent;

end;

{------------------------------------------------------------------------------}
{ TppSubReport.CaptionChange }

procedure TppSubReport.CaptionChange;
begin

  {when datapipeline changes, update the design control caption}
  InvalidateDesignControl;

  {notify report designer, so it can change the tab caption}
  SendDesignMessage(RM_CAPTIONCHANGE, ppWCustomMsg, Self);

end; {procedure, CaptionChange}

{------------------------------------------------------------------------------}
{ TppSubReport.DefineProperties }

procedure TppSubReport.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  {used for conversion to 5.10}
  Filer.DefineProperty('Caption', ReadCaption, nil, False);
  
end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppSubReport.ReadCaption }

procedure TppSubReport.ReadCaption(Reader: TReader);
begin
  Reader.ReadString;
end; {procedure, ReadCaption}

{------------------------------------------------------------------------------}
{ TppSubReport.AfterDesignerCreate }

procedure TppSubReport.AfterDesignerCreate;
begin

  {this method is called by the report designer}
  if (Band = nil) or (Band.Report = nil) then
    CreateReport(nil)
  else
    CreateReport(TppReport(Band.Report.MainReport));

end; {procedure, AfterDesignerCreate}


{@TppSubReport.CreateReport
 Creates the report component contained in the subreport.  This method is only
 called when dynamically creating a report in code.}

procedure  TppSubReport.CreateReport(aMainReport: TppReport);
var
  lDataPipeline: TppDataPipeline;
begin

  if (aMainReport = nil) or (FReport <> nil) then Exit;

  {get the pipe before the report is created}
  lDataPipeline := GetDataPipeline;

  FReport := TppChildReport(ppComponentCreate(aMainReport, TppChildReport));

  TppChildReport(FReport).Parent := Self;
  FReport.PrinterSetup.Assign(aMainReport.PrinterSetup);
  FReport.ReportDesigner := aMainReport.ReportDesigner;
  FReport.Units := Units;
  FReport.DataPipeline := lDataPipeline;

  UpdateDefaultBands;

end; {procedure, CreateReport}

{------------------------------------------------------------------------------}
{ TppSubReport.ChangeOwner }

procedure TppSubReport.ChangeOwner(aNewOwner: TComponent);
begin

  if (aNewOwner = Owner) then Exit;

  {update the child report's owner, if it is the same}
  if (FReport <> nil) and (FReport.Owner = Owner) then
    FReport.ChangeOwner(aNewOwner);

  inherited ChangeOwner(aNewOwner);

end; {procedure, ChangeOwner}

{------------------------------------------------------------------------------}
{ TppSubReport.ConvertDataFieldNames }

procedure TppSubReport.ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
begin

  if (FReport <> nil) then
    FReport.ConvertDataFieldNames(aDataPipeline, aOldFieldName, aNewFieldName);

end; {procedure, ConvertDataFieldNames}

{------------------------------------------------------------------------------}
{ TppSubReport.FixupPipelineReferences }

procedure TppSubReport.FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
begin

  if (FReport <> nil) then
    FReport.FixupPipelineReferences(aDataPipeline, aOldUserName);

end; {procedure, FixupPipelineReferences}

{------------------------------------------------------------------------------}
{ TppSubReport.UpdateDefaultBands }

procedure TppSubReport.UpdateDefaultBands;
begin

 if (FReport = nil) then Exit;

 if FPrintBehavior = pbChild then
   FReport.DefaultBands := cChildReportBands
 else
   FReport.DefaultBands := cReportBands;

end; {procedure, UpdateDefaultBands}

{------------------------------------------------------------------------------}
{ TppSubReport.SetDataPipeline }

procedure TppSubReport.SetDataPipeline(aDataPipeline: TppDataPipeline);
begin

  if (GetDataPipeline = aDataPipeline) then Exit;

  inherited SetDataPipeline(aDataPipeline);

  CaptionChange;

  if (FReport <> nil) then
    FReport.DataPipeline := aDataPipeline;

end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppSubReport.SetBand }

procedure TppSubReport.SetBand(aBand: TppBand);
var
  lMainReport: TppCustomReport;

begin

  inherited SetBand(aBand);

  if (FReport = nil) or (aBand = nil) then  Exit;

  if (FReport <> nil) and (FReport.ParentReport <> aBand.Report) then
    FReport.ParentReport := aBand.Report;

  lMainReport := FReport.MainReport;

  if (lMainReport <> nil) then
    FReport.ReportDesigner := lMainReport.ReportDesigner
  else
    FReport.ReportDesigner := nil;

end; {procedure, SetBand}

{------------------------------------------------------------------------------}
{ TppSubReport.GetCaption }

function TppSubReport.GetCaption: String;
begin

  if (GetDataPipeline = nil) then
    Result := UserName + ': ' + ppLoadStr(1134) {'No Data Pipeline assigned.'}
  else
    Result := UserName + ': ' + GetDataPipeline.UserName;
    
end; {function, GetCaption}

{------------------------------------------------------------------------------}
{ TppSubReport.SetUserName }

procedure TppSubReport.SetUserName(const Value: TComponentName);
begin

  inherited SetUserName(Value);

  {notify report designer, so it can change the tab caption}
  SendDesignMessage(RM_CAPTIONCHANGE, ppWCustomMsg, Self);

end; {procedure, SetUserName}

{------------------------------------------------------------------------------}
{ TppSubReport.GetChildReport }

function  TppSubReport.GetChildReport: TppCustomReport;
begin
  Result := FReport;
end; {function, GetChildReport}

{------------------------------------------------------------------------------}
{ TppSubReport.GetDataPipelines }

procedure TppSubReport.GetDataPipelines(aDataPipelines: TList);
begin
  if (FReport <> nil) then
    FReport.GetDataPipelines(aDataPipelines)

end;  {procedure, GetDataPipelines}

{------------------------------------------------------------------------------}
{ TppSubReport.HasColor }

function  TppSubReport.HasColor: Boolean;
begin
  Result := False;
end; {function, HasColor}

{------------------------------------------------------------------------------}
{ TppSubReport.HasFont }

function  TppSubReport.HasFont: Boolean;
begin
  Result := False;
end; {function, HasFont}

{------------------------------------------------------------------------------}
{ TppSubReport.LanguageChanged}

procedure TppSubReport.LanguageChanged;
begin

  if (Band = nil) or (Band.Report = nil) or (FReport = nil) then Exit;

  FReport.Language := Band.Report.Language;

  FReport.LanguageChanged;

end; {function, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppSubReport.IsClickable}

function TppSubReport.IsClickable: Boolean;
begin
  Result := False;
end; {procedure, IsClickable}

{------------------------------------------------------------------------------}
{ TppSubReport.SetReportProperty }

procedure TppSubReport.SetReportProperty(aReport: TppCustomReport);
begin

  if (FReport <> nil) then
    begin
      { reset the report.engine - this fixes bug when using reference style subreports }
      if (FReport.Engine <> nil) then
        begin
          FReport.Engine.Printing := False;
          FReport.Engine.Reset;
        end;
      FReport.RemoveNotify(Self);
      FReport.ParentReport := nil;
      FReport.PrintingAsSubReport := False;
    end;

  FReport := aReport;

  if (FReport <> nil) then
    begin
      if  (Band <> nil) then
        FReport.ParentReport := Band.Report;
      FReport.AddNotify(Self);
    end;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  LanguageChanged;

end; {procedure, SetReportProperty}

{------------------------------------------------------------------------------}
{ TppSubReport.SetParentPrinterSetup }

procedure TppSubReport.SetParentPrinterSetup(Value: Boolean);
var
  lParentReport: TppCustomReport;
begin

  FParentPrinterSetup := Value;

  PropertyChange;

  if not Value then Exit;

  lParentReport := GetReport;

  if (FReport <> nil) and (lParentReport <> nil) then
    FReport.PrinterSetup.Assign(lParentReport.PrinterSetup);

end; {procedure, SetParentPrinterSetup}

{------------------------------------------------------------------------------}
{ TppSubReport.GetDrillDownComponent }

function TppSubReport.GetDrillDownComponent: TppComponent;
begin

  Result := FDrillDownComponent;

  if (csWriting in ComponentState) then Exit;

  {make sure DrillDownComponent exists in this band}
  if (FDrillDownComponent <> nil) and (Band.FindObject(FDrillDownComponent) = -1) then
    SetDrillDownComponent(nil);

  Result := FDrillDownComponent;

end; {function, GetDrillDownComponent}

{------------------------------------------------------------------------------}
{ TppSubReport.SetDrillDownComponent }

procedure TppSubReport.SetDrillDownComponent(aComponent: TppComponent);
var
  lbFound: Boolean;
  liIndex: Integer;
  lComponent: TppComponent;
begin

  if (aComponent <> nil) and (FPrintBehavior <> pbChild) then Exit;

  if (FDrillDownComponent <> nil) then
    begin

      if (aComponent = nil) then
        FDrillDownComponent.OnDrawCommandClick := nil;

      {remove component from notify list}
      RemoveNotify(FDrillDownComponent);
    end;

  FDrillDownComponent := aComponent;

  {add component to notify list}
  if (FDrillDownComponent <> nil) then
    begin
      AddNotify(FDrillDownComponent);

      {make sure component is assigned only to this subreport}
      lbFound := False;
      liIndex := 0;

      while (liIndex < Band.ObjectCount) and not(lbFound) do
        begin
          lComponent := Band.Objects[liIndex];

          if (lComponent <> Self) and (lComponent is TppSubReport) and
             (FDrillDownComponent = TppSubReport(lComponent).FDrillDownComponent) then
              TppSubReport(lComponent).DrillDownComponent := nil;

          Inc(liIndex);
        end;

    end;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetDrillDownComponent}

{------------------------------------------------------------------------------}
{ TppSubReport.SetExpandAll }

procedure TppSubReport.SetExpandAll(Value: Boolean);
begin

  FExpandAll := Value;


  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  FreeExpansions;

  if FExpandAll then
    begin
      if (FDrillDownComponent <> nil) then
        begin
          FDrillDownComponent.OnDrawCommandCreate := nil;
          FDrillDownComponent.OnDrawCommandClick := nil;
        end;
    end
  else
    begin
      if (FDrillDownComponent <> nil) then
        begin
          FDrillDownComponent.OnDrawCommandCreate := DrillDownDrawCommandCreateEvent;
          FDrillDownComponent.OnDrawCommandClick := DrillDownDrawCommandClickEvent;
        end;
    end;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetExpandAll}

{------------------------------------------------------------------------------}
{ TppSubReport.SetNewPage }

procedure TppSubReport.SetNewPage(Value: Boolean);
begin

  FNewPage := Value;

  {if not NewPage then NewPrintJob must also be False}
  if not FNewPage and FNewPrintJob then
    FNewPrintJob := False;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetNewPage}

{------------------------------------------------------------------------------}
{ TppSubReport.SetRegion }

procedure TppSubReport.SetRegion(aComponent: TppComponent);
begin

  inherited SetRegion(aComponent);

  if (Region <> nil) and (FPrintBehavior = pbSection) then
    SetPrintBehavior(pbFixed);

end; {procedure, SetRegion}

{------------------------------------------------------------------------------}
{ TppSubReport.SetShiftRelativeTo }

procedure TppSubReport.SetShiftRelativeTo(aStretchable: TppStretchable);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    inherited SetShiftRelativeTo(aStretchable)

  else if (FPrintBehavior <> pbSection) or (aStretchable = nil) then
    inherited SetShiftRelativeTo(aStretchable);

end; {procedure, SetShiftRelativeTo}

{------------------------------------------------------------------------------}
{ TppSubReport.SetParentWidth }

procedure TppSubReport.SetParentWidth(Value: Boolean);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      inherited SetParentWidth(Value);

      Exit;
    end;

  if (FPrintBehavior = pbSection) and not(Value) then Exit;

  inherited SetParentWidth(Value);

end; {procedure, SetParentWidth}

{------------------------------------------------------------------------------}
{ TppSubReport.SetNewPrintJob }

procedure TppSubReport.SetNewPrintJob(Value: Boolean);
begin

  FNewPrintJob := Value;

  {if NewPrintJob then NewPage must also be True}
  if FNewPrintJob and not(FPrintBehavior = pbSection) then
    FPrintBehavior := pbSection;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetNewPrintJob}

{------------------------------------------------------------------------------}
{ TppSubReport.SetPrintBehavior }

procedure TppSubReport.SetPrintBehavior(aPrintBehavior: TppPrintBehaviorType);
begin
  if (Region <> nil) and (aPrintBehavior = pbSection) then Exit;

  BeforePropertyChange('PrintBehavior');
  
  FPrintBehavior := aPrintBehavior;

  {set stretch property based upon PrintBehavior}
  if (FPrintBehavior = pbChild) then
    Stretch := True
  else
    Stretch := False;

  {set stretch property based upon PrintBehavior}
  if (FPrintBehavior = pbFixed) then
    KeepTogether := False;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FPrintBehavior = pbFixed) then
    StopPosition := 0;

  if (GetDrillDownComponent <> nil) and (FPrintBehavior = pbSection) then
    SetDrillDownComponent(nil);

  if (FPrintBehavior = pbSection) and not(ParentWidth) then
    ParentWidth := True;

  {clear ShiftRelativeTo for sections}
  if (ShiftRelativeTo <> nil) and (FPrintBehavior = pbSection) then
    ShiftRelativeTo := nil;

  UpdateDefaultBands;
  
  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetPrintBehavior}

{------------------------------------------------------------------------------}
{ TppSubReport.SetResetPageNo }

procedure TppSubReport.SetResetPageNo(Value: Boolean);
begin

  if (FPrintBehavior <> pbSection) then Exit;

  FResetPageNo := Value;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetResetPageNo}

{------------------------------------------------------------------------------}
{ TppSubReport.CalcPrintTop }

function TppSubReport.CalcPrintTop: Longint;
var
  lTop: Single;
  lbFixedAndTraverseAll: Boolean;
begin

  lbFixedAndTraverseAll := (FPrintBehavior = pbFixed) and (FTraverseAllData);

  // when FixedAndTraverseAll, need to override OverFlow here
  // to prevent CalcPrintTop from adjusting the Top position
  if lbFixedAndTraverseAll and Overflow then
    OverFlow := False;

  Result := inherited CalcPrintTop;

  // override StopPosition, when Fixed and TraverseAllData
  if lbFixedAndTraverseAll then
    begin
      FSaveStopPosition := mmStopPosition;

      lTop := FromMMThousandths(Result, Units, pprtVertical);

      StopPosition := lTop + Height;

      if (mmStopPosition <> 0) and (mmStopPosition < PageBottom) then
        PageBottom := mmStopPosition - mmBottomOffset;


    end;

end;

{------------------------------------------------------------------------------}
{ TppSubReport.CalcSpaceUsed }

procedure TppSubReport.CalcSpaceUsed;
var
 lReport: TppCustomReport;
begin

  {indicate that report had opportunity to print}
  FReportGenerated := True;

  {save active report}
  lReport := TppReport(FReport.MainReport).ActiveReport;

  {set active report}
  TppReport(FReport.MainReport).ActiveReport := FReport;

  {generate report}
  case FPrintBehavior of

    pbChild:
      GenerateChild;

    pbFixed:
      begin
        if FTraverseAllData then
          GenerateChild
        else
          GenerateFixed;
      end;

    pbSection:
      GenerateSection;

  end; {case, print behavior type}

  {clear active report}
  TppReport(FReport.MainReport).ActiveReport := lReport;

end; {function, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppSubReport.RestoreFromCache }

procedure TppSubReport.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppSubReportSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent     := lRec.FDrawComponent;
  DrawShifter       := lRec.FDrawShifter;
  KeptTogether      := lRec.FKeptTogether;
  ObjectIndex       := lRec.FObjectIndex;
  OverFlow          := lRec.FOverFlow;
  PartialGeneration := lRec.FPartialGeneration;

  FAlreadyPageBreak        := lRec.FAlreadyPageBreak;
  FCount                   := lRec.FCount;
  FStartReport             := lRec.FStartReport;
  FLastPageCached          := lRec.FLastPageCached;
  FReportCompleted         := lRec.FReportCompleted;
  FReportPageNo            := lRec.FReportPageNo;
  FFirstPassCompleted      := lRec.FFirstPassCompleted;
  FReportAbsolutePageCount := lRec.FReportAbsolutePageCount;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppSubReport.SaveToCache }

procedure TppSubReport.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppSubReportSaveRec;
begin

  lRec.FDrawComponent     := DrawComponent;
  lRec.FDrawShifter       := DrawShifter;
  lRec.FKeptTogether      := KeptTogether;
  lRec.FObjectIndex       := ObjectIndex;
  lRec.FOverFlow          := OverFlow;
  lRec.FPartialGeneration := PartialGeneration;

  lRec.FAlreadyPageBreak     := FAlreadyPageBreak;
  lRec.FCount                := FCount;
  lRec.FStartReport          := FStartReport;
  lRec.FLastPageCached       := FLastPageCached;
  lRec.FReportCompleted      := FReportCompleted;
  lRec.FReportPageNo         := FReportPageNo;
  lRec.FFirstPassCompleted   := FFirstPassCompleted;
  lRec.FReportAbsolutePageCount := FReportAbsolutePageCount;

  WriteRecordToCache(aCachePageNo, lRec);

{$IFDEF CacheTrack}
  FCaches.Add('--------' + Format('%4d', [aCachePageNo]) + '   ---------');
  FCaches.Add('FCount: ' + Format('%4d', [FCount]) );
  FCaches.Add('CacheRecordSize: ' + Format('%4d', [CacheRecordSize]) );
  FCaches.Add('CacheStream.Size: ' + Format('%4d', [CacheStream.Size]) );

  if FStartReport then
    FCaches.Add('FStartReport: True')
  else
    FCaches.Add('FStartReport: False');


  if FFirstPassCompleted then
    FCaches.Add('FFirstPassCompleted: True')
  else
    FCaches.Add('FFirstPassCompleted: False');

  FCaches.Add('');

  FCaches.SaveToFile('c:\' + Name + '.txt');
{$ENDIF}

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppSubReport.UpdateCache }

procedure TppSubReport.UpdateCache;
var
  llCachePage: Longint;
  lRec: TppSubReportSaveRec;
begin

  if not(FReportGenerated) then Exit;

  {we've already cached the page, there's no need to update}
  if (FReport.MainReport.AbsolutePageNo < FReport.MainReport.AbsolutePageCount) then Exit;

  {determine starting search page}
  if (CacheRecordSize > 0) and (CacheCount > 0) then
    llCachePage := Round(Round(CacheStream.Size / CacheRecordSize) / CacheCount) - 1
  else
    llCachePage := -1;

  {look at any prior cache pages with same first cache page, update last page cached}
  if (llCachePage > -1) then
    begin

      repeat

        ReadRecordFromCache(llCachePage, lRec);

        if (FCount = lRec.FCount) then
          begin
            lRec.FStartReport := FStartReport;
            lRec.FFirstPassCompleted := FFirstPassCompleted;
            lRec.FLastPageCached := FLastPageCached;
            lRec.FReportAbsolutePageCount := FReport.AbsolutePageCount;

            WriteRecordToCache(llCachePage, lRec);
          end;

        Dec(llCachePage);

      until (FCount <> lRec.FCount) or (llCachePage < 0);

    end; {if, their are any previous pages to search}

end; {procedure, UpdateCache}

{------------------------------------------------------------------------------}
{ TppSubReport.StartOfMainReport }

procedure TppSubReport.StartOfMainReport;
var
  lSavePrintHeight: TppPrintHeightType;
begin

  inherited StartOfMainReport;

{$IFDEF CacheTrack}
  FCaches.Clear;
  FCaches.SaveToFile('c:\' + Name + '.txt');
{$ENDIF}

  {initialize counter}
  FLastPageCached := 0;

  FReport.PrintingAsSubReport := True;

  if (FReport.PassSetting = psTwoPass) then
    FReport.PassSetting := psOnePass;

  case FPrintBehavior of

    pbSection:
      FMainSection := (Band.Report = Band.Report.MainReport);

    pbChild, pbFixed:
      begin

        {header and footer bands not valid in child subreports}
        if (PrintBehavior = pbChild) then
          begin
            if (FReport.GetBand(btHeader, 0) <> nil) then
              FReport.GetBand(btHeader, 0).Visible := False;

            if (FReport.GetBand(btFooter, 0) <> nil) then
              FReport.GetBand(btFooter, 0).Visible := False;
          end;

        if (IsDrillDown) then
          begin
            FRetainExpansions := False;
            {FreeExpansions;}

            if not(FExpandAll) then
              begin
                FDrillDownComponent.OnDrawCommandCreate := DrillDownDrawCommandCreateEvent;
                FDrillDownComponent.OnDrawCommandClick := DrillDownDrawCommandClickEvent;
              end;
          end;

        if (FPrintBehavior = pbFixed) and (FTraverseAllData) then
          begin
            lSavePrintHeight := Band.PrintHeight;

            try
              Stretch := True;
            finally
              Band.PrintHeight := lSavePrintHeight;
            end;
          end;
          
      end;

  end; {case, print behavior type}

  {initialize report - 4.2}
  FReport.Engine.State := []; 
  FReport.Engine.Init;

  {this initializes any nested subreports}
  FReport.StartOfMainReport;

end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppSubReport.StartOfParentReport }

procedure TppSubReport.StartOfParentReport;
begin

  {initialize counter}
  FCount := 0;

end; {procedure, StartOfParentReport}

{------------------------------------------------------------------------------}
{ TppSubReport.Init }

procedure TppSubReport.Init;
begin

  inherited Init;

  case FPrintBehavior of

    pbChild, pbFixed:
      InitChild;

    pbSection:
      InitSection;

  end; {case, print behavior type}

  {init all subreports}
  FReport.Engine.Init;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppSubReport.GenerateReport }

procedure TppSubReport.GenerateReport;
var
  lPageRequest: TppPageRequest;
  lSaveOnResetCache: TMethod;
  lSaveOnReadCache: TMethod;
  lSaveOnWriteCache : TMethod;
  lSaveOnGetLastPageCached: TMethod;
begin

  {save cache event-handlers}
  lSaveOnResetCache := TMethod(FReport.Engine.OnResetCache);
  lSaveOnReadCache  := TMethod(FReport.Engine.OnReadCache);
  lSaveOnWriteCache := TMethod(FReport.Engine.OnWriteCache);
  lSaveOnGetLastPageCached := TMethod(FReport.Engine.OnGetLastPageCached);

  {set up communication with engine}
  FReport.Engine.OnGetLastPageCached := GetLastPageCachedEvent;

  {clear any other event handlers}
  FReport.Engine.OnResetCache := nil;
  FReport.Engine.OnReadCache := nil;
  FReport.Engine.OnWriteCache := nil;

  lPageRequest := TppPageRequest.Create;
  lPageRequest.PageSetting := psSinglePage;
  lPageRequest.PageRequested := FReportPageNo;

  try

    FReport.Engine.Printing := False;

    FReport.Engine.RequestPage(lPageRequest);

  finally

    {if report cancelled or exception raised, reset generator}
    if FReport.Engine.StopPrinting then
      FReport.Engine.Reset
    else
      FReport.Engine.Printing := True;

    lPageRequest.Free;

    {restore original event-handlers}
    FReport.Engine.OnResetCache := TNotifyEvent(lSaveOnResetCache);
    FReport.Engine.OnReadCache := TNotifyEvent(lSaveOnReadCache);
    FReport.Engine.OnWriteCache := TNotifyEvent(lSaveOnWriteCache);
    FReport.Engine.OnGetLastPageCached := TppGetLastPageCachedEvent(lSaveOnGetLastPageCached);

  end; {try, finally}


end; {procedure, GenerateReport}

{------------------------------------------------------------------------------}
{ TppSubReport.CreateDrawCommand}

procedure TppSubReport.CreateDrawCommand(aPage: TppPage);
var
  lSourcePage: TppPage;
  lTargetPage: TppPage;
  llLeftOffset: Longint;
  llTopOffset: Longint;
  llLeft: Longint;
  llTop: Longint;
  llRight: Longint;
  llBottom: Longint;
  lPageDef: TppPageDef;
  lClipRect: TppRect;

  procedure TransferDrawCommands;
    var
      liDrawCommand: Integer;
      liDrawCommands: Integer;
      lDrawCommand: TppDrawCommand;
    begin

      liDrawCommands := lSourcePage.DrawCommandCount;

      {transfer draw commands from child page to parent report}
      for liDrawCommand := 0 to liDrawCommands - 1 do
        begin
          lDrawCommand := lSourcePage[0];

          {adjust commands for sub-report position}
          lDrawCommand.Left := lDrawCommand.Left + llLeftOffset;
          lDrawCommand.Top := lDrawCommand.Top + llTopOffset;

          lDrawCommand.ClipRect := lClipRect;

          lDrawCommand.Page := lTargetPage;

          TppCustomBand(Self.Band).DrawCommands.Add(lDrawCommand);
        end;
    end;

begin

  {draw drill down shape}
  if IsDrillDown and not(DrillDownExpanded) then Exit;

  {get target page}
  lTargetPage := aPage;

  {get sub-reports page}
  lSourcePage := FReport.Engine.Page;

  lPageDef := FReport.Engine.Page.PageDef;

  llLeftOffset := 0;
  llTopOffset := 0;

  case FPrintBehavior of

    pbChild:
      begin
        llLeftOffset := PrintPosRect.Left;
        llTopOffset := PrintPosRect.Top;

        llLeft := PrintPosRect.Left + lPageDef.mmMarginLeft;
        llTop := PrintPosRect.Top + lPageDef.mmMarginTop;
        llRight := PrintPosRect.Right - lPageDef.mmMarginRight;
        llBottom := PrintPosRect.Bottom - lPageDef.mmMarginBottom;

        lClipRect := ppRect(llLeft, llTop, llRight, llBottom);

        TransferDrawCommands;
      end;

    pbFixed:
      begin
        llLeftOffset := PrintPosRect.Left;
        llTopOffset := PrintPosRect.Top;

        llLeft := PrintPosRect.Left + lPageDef.mmMarginLeft;
        llTop := PrintPosRect.Top + lPageDef.mmMarginTop;
        llRight := mmWidth - lPageDef.mmMarginRight;
        llBottom := mmHeight - lPageDef.mmMarginBottom;

        lClipRect := ppRect(llLeft, llTop, llRight, llBottom);

        TransferDrawCommands;
      end;

  end; {case, print behavior type}

end; {procedure, CreateDrawCommand}

{******************************************************************************
 *
 ** S U B  R E P O R T  -  C H I L D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubReport.InitChild}

procedure TppSubReport.InitChild;
begin

  FAlreadyPageBreak    := False;
  FFirstPassCompleted  := False;
  FPageGenerated       := False;
  FReportCompleted     := False;
  FReportPageNo        := 1;
  FReportAbsolutePageCount := 0;
  FStartReport         := False;

end; {procedure, InitChild}

{------------------------------------------------------------------------------}
{ TppSubReport.BeforePrint}

procedure TppSubReport.BeforePrint;
begin

  inherited BeforePrint;

  FReportGenerated := False;

{$IFDEF CacheTrack}
  FCaches.LoadFromFile('c:\' + Name + '.txt');
{$ENDIF}

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppSubReport.AfterPrint}

procedure TppSubReport.AfterPrint;
begin

  inherited AfterPrint;

  {after band has completed printing, increment counter, must increment here, otherwise
   drill-down create event can assign wrong counter value to draw command}
  if (FPrintBehavior <> pbSection) and (FReportGenerated) and (FReportCompleted) then
    Inc(FCount);

  if (FPrintBehavior = pbFixed) and (FTraverseAllData) then
    StopPosition := ppFromMMThousandths(FSaveStopPosition, Band.Report.Units, pprtVertical, GetPrinter);

end; {procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppSubReport.GenerateChild}

procedure TppSubReport.GenerateChild;
var
  lbShouldKeepTogether: Boolean;
begin

  {child report linked to shiftrelativeto chain,
   skip generation and goto next stretchable in chain}
  if not(FStartReport) and OverFlow and not(KeptTogether) then Exit;

  {update drilldown expansion}
  if (IsDrillDown) then
    begin

      if not(DrillDownExpanded) then
        begin
          FReport.Engine.Reset;

          FReportCompleted := True;
          OverFlow := False;
          SpaceUsed := 0;

          Exit;
        end;

    end;

  {set page size}
  FReport.PrinterSetup := Band.Report.PrinterSetup;
  FReport.Engine.Page.PrinterSetup := Band.Report.PrinterSetup;

  FReport.Engine.Page.PageDef.mmHeight := PrintPosRect.Bottom - PrintPosRect.Top;
  FReport.Engine.Page.PageDef.mmWidth := PrintPosRect.Right - PrintPosRect.Left;

  FReport.Engine.Page.PageDef.mmMarginLeft := 0;
  FReport.Engine.Page.PageDef.mmMarginTop := 0;
  FReport.Engine.Page.PageDef.mmMarginRight := 0;
  FReport.Engine.Page.PageDef.mmMarginBottom := 0;

  {reset the report for the next run}
  if not(FStartReport) then
    begin
      FStartReport := True;

      FFirstPassCompleted  := False;
      FReportCompleted := False;
      FReportPageNo := 1;
      FReportAbsolutePageCount := 1;
      FLastPageCached := 0;

      FReport.Engine.Printing := False;
      FReport.Engine.Reset;
    end
  else
    begin
      FReport.Engine.FirstPassCompleted := FFirstPassCompleted;
      FReport.Engine.AbsolutePageCount := FReportAbsolutePageCount;
    end;


  {determine if keeptogether is in play before generating report}
  lbShouldKeepTogether := ShouldKeepTogether and (PrintBehavior <> pbFixed);

  {generate the report}
  GenerateReport;


  {set overflow and space used}
  if PrintStretch then
    begin
      FReportCompleted := FReport.Engine.LastBandGenerated;

      OverFlow := not(FReportCompleted);

      SpaceUsed := FReport.Engine.SpaceUsed;
    end
  else
    begin
      FReportCompleted := True;

      OverFlow := False;

      SpaceUsed := mmHeight;
    end;

  if (SpaceUsed > 0) then
    begin
      if OverFlow then
        begin
          if lbShouldKeepTogether then
            begin
              KeptTogether := True;

              SpaceUsed := 0;
              FStartReport := False;
              
              Exit;
            end
          else
            begin
              Inc(FReportPageNo);
              FLastPageCached := FReport.AbsolutePageNo;
            end;
        end;

      FReportAbsolutePageCount := FReport.AbsolutePageCount;
    end
  else
    FLastPageCached := 0;

  FFirstPassCompleted := (FReport.Engine.AllDataTraversed) and (FReport.Engine.LastBandGenerated);

  {reset for next report}
  if FReportCompleted then
    FStartReport := False;

  if not(OverFlow) and (KeepTogether) and (KeptTogether) then
    KeptTogether := False;

end; {procedure, GenerateChild}

{------------------------------------------------------------------------------}
{ TppSubReport.GenerateFixed}

procedure TppSubReport.GenerateFixed;
var
  llSpaceAvailable: Longint;
begin

  {set page size}
  FReport.Engine.Page.PrinterSetup := Band.Report.PrinterSetup;

  llSpaceAvailable := PrintPosRect.Bottom - PrintPosRect.Top;

  if (llSpaceAvailable < mmHeight) then
    begin
      OverFlow := True;

      Exit;
    end;

  FReport.Engine.Page.PageDef.mmHeight := mmHeight;
  FReport.Engine.Page.PageDef.mmWidth := mmWidth;

  FReport.Engine.Page.PageDef.mmMarginLeft := 0;
  FReport.Engine.Page.PageDef.mmMarginTop := 0;
  FReport.Engine.Page.PageDef.mmMarginRight := 0;
  FReport.Engine.Page.PageDef.mmMarginBottom := 0;


  {reset the report for a new run}
  FReportPageNo := 1;
  FLastPageCached := 0;
  FReportAbsolutePageCount := 1;

  FReport.Engine.Printing := False;
  FReport.Engine.Reset;

  {generate the report}
  GenerateReport;

  {set overflow and space used}
  FReportCompleted := True;
  OverFlow := False;
  SpaceUsed := mmHeight;

  FFirstPassCompleted := (FReport.Engine.AllDataTraversed) and (FReport.Engine.LastBandGenerated);

end; {procedure, GenerateFixed}

{------------------------------------------------------------------------------}
{ TppSubReport.SetTraverseAllData }

procedure TppSubReport.SetTraverseAllData(Value: Boolean);
begin

  FTraverseAllData := Value;

  if (csReading in ComponentState) or (csLoading in ComponentState) then

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetTraverseAllData}

{------------------------------------------------------------------------------}
{ TppSubReport.GetLastPageCachedEvent }

procedure TppSubReport.GetLastPageCachedEvent(Sender: TObject; var aPageNo: Longint);
begin
  aPageNo := FLastPageCached;
end;

{******************************************************************************
 *
 ** S U B  R E P O R T  -  D R I L L  D O W N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubReport.GetReportKey }

function TppSubReport.GetReportKey: String;
var
  lsKey: String;
begin

  if (Band.Report <> Band.Report.MainReport) then
    begin
      lsKey := '';

      Band.Report.GetReportKey(lsKey);

      Result := lsKey;
    end
  else
    Result := '';

end; {procedure, GetReportKey}

{------------------------------------------------------------------------------}
{ TppSubReport.GetExpansionKey }

function TppSubReport.GetExpansionKey: String;
begin
  Result := GetReportKey + Format('%8d', [FCount]);
end; {function, GetExpansionKey}

{------------------------------------------------------------------------------}
{ TppSubReport.GetExpansion }

function TppSubReport.GetExpansion(aIndex: Integer): String;
begin
  Result := FExpansions[aIndex];
end; {function, GetExpansion

{------------------------------------------------------------------------------}
{ TppSubReport.GetExpansionCount }

function TppSubReport.GetExpansionCount: Integer;
begin
  Result := FExpansions.Count;
end; {function, GetExpansionCount

{------------------------------------------------------------------------------}
{ TppSubReport.IsDrillDown }

function TppSubReport.IsDrillDown: Boolean;
begin
  Result := (GetDrillDownComponent <> nil) and (FPrintBehavior <> pbSection);
end; {function, IsDrillDown}

{------------------------------------------------------------------------------}
{ TppSubReport.FindExpansion}

function TppSubReport.FindExpansion(const aExpansionKey: String): Integer;
begin
  Result := FExpansions.IndexOf(aExpansionKey);
end; {function, FindExpansion}

{------------------------------------------------------------------------------}
{ TppSubReport.AddExpansion}

procedure TppSubReport.AddExpansion(const aExpansionKey: String);
begin
  FExpansions.Add(aExpansionKey);
end; {procedure, AddExpansion}

{------------------------------------------------------------------------------}
{ TppSubReport.RemoveExpansion}

procedure TppSubReport.RemoveExpansion(const aExpansionKey: String);
var
  liPosition: Integer;
begin

  liPosition := FExpansions.IndexOf(aExpansionKey);

  if (liPosition <> -1) then
    FExpansions.Delete(liPosition);

end; {procedure, RemoveExpansion}

{------------------------------------------------------------------------------}
{ TppSubReport.FreeExpansions}

procedure TppSubReport.FreeExpansions;
begin
  FExpansions.Clear;
end; {procedure, FreeExpansions}

{------------------------------------------------------------------------------}
{ TppSubReport.DrillDownExpanded }

function TppSubReport.DrillDownExpanded: Boolean;
begin

  Result := False;

  if not(IsDrillDown) then Exit;

  {determine whether subreport should expand}
  if (FExpandAll) then
    Result := True

  else if (FindExpansion(GetExpansionKey) <> -1) then
    Result := True;

end; {function, DrillDownExpanded}

{------------------------------------------------------------------------------}
{ TppSubReport.DrillDownDrawCommandCreateEvent }

procedure TppSubReport.DrillDownDrawCommandCreateEvent(Sender: TObject; aDrawCommand: TObject);
begin

  {assign tag to track subreport associated with command}
  TppDrawCommand(aDrawCommand).ExpansionKey := GetExpansionKey;

end; {procedure, DrillDownDrawCommandCreateEvent}

{------------------------------------------------------------------------------}
{ TppSubReport.DrillDownDrawCommandClickEvent}

procedure TppSubReport.DrillDownDrawCommandClickEvent(Sender: TObject; aDrawCommand: TObject);
var
  lsExpansionKey: String;
  liPosition: Integer;
  lDrawCommand: TppDrawCommand;
  lReport: TppReport;
begin

  if (Printing) then Exit;

  lDrawCommand := TppDrawCommand(aDrawCommand);

  lsExpansionKey := lDrawCommand.ExpansionKey;

  liPosition := FindExpansion(lsExpansionKey);

  if (liPosition = -1) then
    AddExpansion(lsExpansionKey)
  else
    RemoveExpansion(lsExpansionKey);

  {force report to regenerate}
  lDrawCommand.RedrawPage := True;

  {dump main cache}
  lReport := TppReport(FReport.MainReport);

  if (lReport.PassSetting = psTwoPass) then
    begin
      lReport.DumpCache;

      lReport.Engine.Reset;
    end
  else
    lReport.ResetFromPageNo(lDrawCommand.Page.AbsolutePageNo);


  FRetainExpansions := True;

end; {procedure, DrillDownDrawCommandClickEvent}

{******************************************************************************
 *
 ** S U B  R E P O R T  -  S E C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSubReport.InitSection }

procedure TppSubReport.InitSection;
var
  liIndex: Integer;
  lObject: TppComponent;
begin

  FAlreadyPageBreak    := False;
  FFirstPassCompleted  := False;
  FPageGenerated       := False;
  FReportCompleted     := False;
  FReportPageNo        := 1;
  FReportAbsolutePageCount := 0;
  FStartReport         := False;

  FSectionSubReportsOnly := True;
  liIndex := 0;

  while (liIndex < Band.ObjectCount) and FSectionSubReportsOnly do
    begin
      lObject := Band.Objects[liIndex];

      if not(lObject is TppSubreport) or (TppSubReport(lObject).PrintBehavior <> pbSection) then
        FSectionSubReportsOnly := False;

      Inc(liIndex);
    end;

end; {procedure, InitSection}

{------------------------------------------------------------------------------}
{ TppSubReport.GenerateSection}

procedure TppSubReport.GenerateSection;
var
  lMainEngine: TppCustomEngine;
  liIndex: Integer;
  lPage: TppPage;
begin

  SpaceUsed := 0;

  if not(FAlreadyPageBreak) then
    begin
      FAlreadyPageBreak := True;

      OverFlow := True;

      {5.52 - set AlreadyPageBreak to true, for any StartNewPage groups}
      for liIndex := 0 to Report.GroupCount - 1 do
        begin
          if FReport.Groups[liIndex].NewPage then
            TppGroupHeaderBand(FReport.Groups[liIndex].HeaderBand).AlreadyPageBreak := True;
        end;

      {force next generate to start report}
      lMainEngine := FReport.MainReport.Engine;

      if ((lMainEngine.AbsolutePageNo = 0) or (lMainEngine.AbsolutePageNo > lMainEngine.LastPageCached)) then
        FStartReport := True;

      FReportCompleted := False;

      {indicate to master that we're starting a section}
      Band.Report.ESInclude([esStartSection]);

      TppCustomBand(Band).PrintingSection := True;

      {Check for no data}
      if (FReport.DataPipeline <> nil) and (FReport.DataPipeline.BOF and FReport.DataPipeline.EOF) and (ndBlankPage in FReport.NoDataBehaviors) then
        // no data and blank page - do nothing
      else if (TppCustomBand(Band).SpaceUsed > 0) or (Band.Report.Engine.SpaceUsed > 0) then
        Exit

      else if not(FSectionSubReportsOnly) then
        Exit;

      {special case, section appears on first page}
      if (FReport.MainReport.AbsolutePageNo = 1) and ((FReport.MainReport.AbsolutePageCount > 1)) then
        FStartReport := False;
    end;

  {start report}
  if FStartReport then
    begin
      FStartReport := False;

      {reset report}
      FReportPageNo := 1;
      FReportAbsolutePageCount := 0;
      FLastPageCached := 0;
      FFirstPassCompleted := False;
      FReportCompleted  := False;
      FReport.Engine.Printing := False;
      FReport.Engine.Reset;
    end
  else
    begin
      FReport.Engine.FirstPassCompleted := FFirstPassCompleted;
      FReport.Engine.AbsolutePageCount := FReportAbsolutePageCount;
    end;

  {remove start section from state}
  if (esStartSection in Band.Report.Engine.State) then
    begin
      if FMainSection then
        Band.Report.ESExclude([esStartSection])
      else
        Band.Report.Engine.ESExclude([esStartSection]);
    end;

  {add generate section to state}
  if not(esGenerateSection in Band.Report.Engine.State) then
    begin
      if FMainSection then
        Band.Report.ESInclude([esGenerateSection])
      else
        Band.Report.Engine.ESInclude([esGenerateSection]);
    end;


  TppCustomBand(Band).PrintingSection := True;

  {set page size}
  if not(FReport.Engine.Page.PrinterSetup.IsEqual(FReport.PrinterSetup)) then
    FReport.Engine.Page.PrinterSetup := FReport.PrinterSetup;

  FReport.Engine.Page.Producer := FReport;

  {generate the report}
  GenerateReport;

  FPageGenerated := (FReport.Engine.Page.DrawCommandCount > 0);


  {set overflow indicator}
  OverFlow := not(FReport.Engine.LastBandGenerated);

  SpaceUsed := FReport.Engine.SpaceUsed;

  FReportCompleted := not(OverFlow);


  {check for end of section}
  if not(OverFlow) then
    begin

       if (FMainSection) then
          begin
            Band.Report.ESExclude([esGenerateSection]);
            Band.Report.ESInclude([esEndSection]);
          end
        else
          begin
            Band.Report.Engine.ESExclude([esGenerateSection]);
            Band.Report.Engine.ESInclude([esEndSection]);
          end;

      end;

  {update requested page no, last page cached & page count}
  if (SpaceUsed > 0) then
    begin
      if OverFlow then
        Inc(FReportPageNo);

      FLastPageCached := FReport.AbsolutePageNo;
      FReportAbsolutePageCount := FReport.AbsolutePageCount;
    end
  else
    FLastPageCached := 0;

  FFirstPassCompleted := (FReport.Engine.AllDataTraversed) and (FReport.Engine.LastBandGenerated);

  {update cache with absolutepagecount, lastpagecached and firstpasscompleted}
  UpdateCache;

  {set up communication with parent engine,
   must do this, even if page is not generated by this subreport}
  Band.Report.Engine.AddEventNotify(Self);

  {transfer completed page to parent report}
  if FPageGenerated then
    begin
      {assign page to main report
        - a patch to 5.56 changed this code from Band.Report.Engine...
          this enables a section within a child report to control the printersetup}
      FReport.MainReport.Engine.Page.Assign(FReport.Engine.Page);

      {create a printer device}
      if (FNewPrintJob) and (TppReport(FReport.MainReport).DeviceType = dtPrinter) and FReport.MainReport.Engine.DrawPage then
        CreatePrinterDevice;
    end;

  {restore parent page numbers on completed page,
   must do this, even if page is not generated by this subreport}
  if not(FResetPageNo) then
    begin

      // update the main report's page,
      // generated pages always get assigned to the main report (see above)
      lPage :=  FReport.MainReport.Engine.Page;

      lPage.PageNo := Band.Report.Engine.PageNo;
      lPage.PageCount := Band.Report.Engine.PageCount;

      lPage.Update(nil);

{     Band.Report.Engine.Page.PageNo := Band.Report.Engine.PageNo;
      Band.Report.Engine.Page.PageCount := Band.Report.Engine.PageCount;

      Band.Report.Engine.Page.Update(nil);
}
    end;

  {goto next report}
  if (FReportCompleted) then
    begin
      Inc(FCount);

      FAlreadyPageBreak := False;

      {reset report}
      FReportPageNo := 1;
      FReportAbsolutePageCount := 0;
      FLastPageCached := 0;
      FFirstPassCompleted := False;
      FReport.Engine.Printing := False;
      FReport.Engine.Reset;
      FReport.Engine.Init;
    end;

end; {procedure, GenerateSection}

{------------------------------------------------------------------------------}
{ TppSubReport.SectionAfterSendPageEvent }

procedure TppSubReport.SectionAfterSendPageEvent;
begin

  {section printing complete}
  if FReportCompleted then
    begin
      if (FMainSection) then
        Band.Report.ESExclude([esEndSection])
      else
        Band.Report.Engine.ESExclude([esEndSection]);

    end;

  if (FPageGenerated) then
    begin
      FPageGenerated := False;

      {free printer device}
      if ((FReportCompleted or FReport.MainReport.Engine.GenerateCompleted)) and (FPrinterDevice <> nil) then
        FreePrinterDevice;

      {restore for subsequent pages of parent report}
      if (FMainSection) then
        begin
          Band.Report.Engine.Page.PrinterSetup := Band.Report.PrinterSetup;
          Band.Report.Engine.Page.Producer := Band.Report;
        end;
    end;

end; {procedure, SectionAfterSendPageEvent}

{------------------------------------------------------------------------------}
{ TppSubReport.CreatePrinterDevice}

procedure TppSubReport.CreatePrinterDevice;
var
  lMasterReport: TppReport;
begin

  if (FPrinterDevice <> nil) then Exit;

  if (FReport = nil) then Exit;

  lMasterReport := TppReport(FReport.MainReport);

  if (lMasterReport = nil) then Exit;

  {create a printer device}
  FPrinterDevice := TppPrinterDevice.Create(Self);
  FPrinterDevice.Stackable := True;
  FPrinterDevice.Printer.PrinterSetup := FReport.PrinterSetup;

  FPrinterDevice.Publisher := lMasterReport.Publisher;

  FPrinterDevice.StartJob;

end; {procedure, CreatePrinterDevice}

{------------------------------------------------------------------------------}
{ TppSubReport.FreePrinterDevice}

procedure TppSubReport.FreePrinterDevice;
begin

  if (FPrinterDevice <> nil) then
    FPrinterDevice.EndJob;

  FPrinterDevice.Free;

  FPrinterDevice := nil;

end; {procedure, FreePrinterDevice}

{------------------------------------------------------------------------------}
{ TppSubReport.SetOutlineSettings }

procedure TppSubReport.SetOutlineSettings(aOutlineSettings: TppOutlineSettings);
begin

  FOutlineSettings.Assign(aOutlineSettings);

end; { procedure, SetOutlineSettings }

{------------------------------------------------------------------------------}
{ TppSubReport.iOutlineGetChildren }

function TppSubReport.iOutlineGetChildren: TList;
begin

  if (FOutlineChildren = nil) then
    FOutlineChildren := TList.Create
  else
    FOutlineChildren.Clear;

  Report.GetOutlineChildren(FOutlineChildren);

  Result := FOutlineChildren;

end; { function, iOutlineGetChildren }

{------------------------------------------------------------------------------}
{ TppSubReport.iOutlineGetParent }

function TppSubReport.iOutlineGetParent: TppCommunicator;
begin

  Result := TppCustomReport.GetOutlineParent(Report.MainReport, Self);

end; { function, iOutlineGetParent }

{------------------------------------------------------------------------------}
{ TppSubReport.iOutlineNodeCreatorClass }

function TppSubReport.iOutlineNodeCreatorClass: TComponentClass;
begin

  Result := TppOutlineReportNodeCreator;

end; { function, iOutlineSettings }

{------------------------------------------------------------------------------}
{ TppSubReport.iOutlineSettings }

function TppSubReport.iOutlineSettings: TppOutlineSettings;
begin

  Result := OutlineSettings;

end; { function, iOutlineSettings }

{------------------------------------------------------------------------------}
{ TppSubReport.iOutlineSettingsChanged }

procedure TppSubReport.iOutlineSettingsChanged;
begin

  FReport.Reset;

end; { procedure, iOutlineSettingsChanged }

{******************************************************************************
 *
 *
 *
 ** R T T I
 *
 *
 *
{******************************************************************************}

{******************************************************************************
 *
 ** S U B R E P O R T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.RefClass }

class function TraTppSubReportRTTI.RefClass: TClass;
begin
  Result := TppSubReport;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.GetPropList }

class procedure TraTppSubReportRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Report');
  aPropList.AddProp('CreateReport');
  aPropList.AddProp('DrillDownExpanded');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.GetPropRec }

class function TraTppSubReportRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Count') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'CreateReport') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'CurrentExpansionKey') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'CurrentReportKey') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'DrillDownExpanded') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'DrillDownComponent') = 0) then
    ClassPropToRec(aPropName, TppComponent, False, aPropRec)

  else if (CompareText(aPropName, 'ExpandAll') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Expansions') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'ExpansionCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'NewPrintJob') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'ParentPrinterSetup') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'PrintBehavior') = 0) then
    EnumPropToRec(aPropName, 'TppPrintBehaviorType', False, aPropRec)

  else if (CompareText(aPropName, 'Report') = 0) then
    ClassPropToRec(aPropName, TppCustomReport, True, aPropRec)

  else if (CompareText(aPropName, 'ResetPageNo') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'TraverseAllData') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.GetParams }

class function TraTppSubReportRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Expansions') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daString, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'CreateReport') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('MasterReport', daClass, TppReport, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.CallMethod }

class function TraTppSubReportRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lSubReport: TppSubReport;
  liIndex: Integer;
  lsExpansionKey: String;
  lReport: Integer;
begin

  Result := True;
  
  lSubReport := TppSubReport(aObject);

  if (CompareText(aMethodName, 'Expansions') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lsExpansionKey := lSubReport.Expansions[liIndex];

      aParams.SetParamValue(1, lsExpansionKey);
    end

  else if (CompareText(aMethodName, 'CreateReport') = 0) then
    begin
      aParams.GetParamValue(0, lReport);

      lSubReport.CreateReport(TppReport(lReport));
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.GetPropValue }

class function TraTppSubReportRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Count') = 0) then
    Integer(aValue) := TppSubReport(aObject).Count

  else if (CompareText(aPropName, 'CurrentExpansionKey') = 0) then
    String(aValue) := TppSubReport(aObject).CurrentExpansionKey

  else if (CompareText(aPropName, 'CurrentReportKey') = 0) then
    String(aValue) := TppSubReport(aObject).CurrentReportKey

  else if (CompareText(aPropName, 'DrillDownComponent') = 0) then
    Integer(aValue) := Integer(TppSubReport(aObject).DrillDownComponent)

  else if (CompareText(aPropName, 'DrillDownExpanded') = 0) then
    Boolean(aValue) := TppSubReport(aObject).DrillDownExpanded

  else if (CompareText(aPropName, 'ExpandAll') = 0) then
    Boolean(aValue) := TppSubReport(aObject).ExpandAll

  else if (CompareText(aPropName, 'ExpansionCount') = 0) then
    Integer(aValue) := TppSubReport(aObject).ExpansionCount

  else if (CompareText(aPropName, 'NewPrintJob') = 0) then
    Boolean(aValue) := TppSubReport(aObject).NewPrintJob

  else if (CompareText(aPropName, 'ParentPrinterSetup') = 0) then
    Boolean(aValue) := TppSubReport(aObject).ParentPrinterSetup

  else if (CompareText(aPropName, 'PrintBehavior') = 0) then
    TppPrintBehaviorType(aValue) := TppSubReport(aObject).PrintBehavior

  else if (CompareText(aPropName, 'Report') = 0) then
    Integer(aValue) := Integer(TppSubReport(aObject).Report)

  else if (CompareText(aPropName, 'ResetPageNo') = 0) then
    Boolean(aValue) := TppSubReport(aObject).ResetPageNo

  else if (CompareText(aPropName, 'TraverseAllData') = 0) then
    Boolean(aValue) := TppSubReport(aObject).TraverseAllData

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppSubReportRTTI.SetPropValue }

class function TraTppSubReportRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'DrillDownComponent') = 0) then
    TppSubReport(aObject).DrillDownComponent := TppComponent(aValue)

  else if (CompareText(aPropName, 'ExpandAll') = 0) then
    TppSubReport(aObject).ExpandAll := Boolean(aValue)

  else if (CompareText(aPropName, 'NewPrintJob') = 0) then
    TppSubReport(aObject).NewPrintJob := Boolean(aValue)

  else if (CompareText(aPropName, 'ParentPrinterSetup') = 0) then
    TppSubReport(aObject).ParentPrinterSetup := Boolean(aValue)

  else if (CompareText(aPropName, 'PrintBehavior') = 0) then
    TppSubReport(aObject).PrintBehavior := TppPrintBehaviorType(aValue)

  else if (CompareText(aPropName, 'ResetPageNo') = 0) then
    TppSubReport(aObject).ResetPageNo := Boolean(aValue)

  else if (CompareText(aPropName, 'TraverseAllData') = 0) then
    TppSubReport(aObject).TraverseAllData := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization

  raRegisterRTTI(TraTppSubReportRTTI);

finalization

  raUnRegisterRTTI(TraTppSubReportRTTI);

end.
