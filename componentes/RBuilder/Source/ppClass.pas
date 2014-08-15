{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppClass;

interface

{$I ppIfDef.pas}

uses
   Windows,
   Classes,
   Controls,
   Forms,
   ExtCtrls,
   Graphics,
   Dialogs,
   SysUtils,
   StdCtrls,

   ppCmpReg,
   ppComm,
   ppDevice,
   ppTypes,
   ppUtils,
   ppDB,
   ppTmplat,
   ppCache,
   ppPrnabl,
   ppProd,
   ppPrintr,
   ppRelatv,
   ppRTTI,
   ppOutlineSettings,
   ppOutlineParticipant,
   ppForms;

type
  {forward declarations}
  TppBand              = class;     
  TppComponent         = class;
  TppGroup             = class;
  TppCustomReport      = class;

  TppCustomReportClass = class of TppCustomReport;
  TppBandClass         = class of TppBand;

  {@TppCustomEngine}
  TppCustomEngine = class(TppCacheable)
    private
      FAbsolutePageNo: Longint;
      FAbsolutePageCount: Longint;
      FAdvanceRecord: Boolean;
      FAllDataTraversed: Boolean;
      FCalcsOutOfSync: Boolean;
      FCheckForGroupBreaks: Boolean;
      FControlGroup: TppGroup;
      FControlKeepTogether: TppGroup;
      FCurrentColumn: Integer;
      FDrawPage: Boolean;
      FEngineState: TppEngineStates;
      FFirstDetailBandPrinted: Boolean;
      FFirstPassCompleted: Boolean;
      FGenerateCompleted: Boolean;
      FGenerateStarted: Boolean;
      FLastBandGenerated: Boolean;
      FLastPageCached: Longint;
      FPage: TppPage;
      FPrintCondition: TppPrintConditions;
      FPrintDateTime: TDateTime;
      FPrinting: Boolean;
      FPrintPosRect: TppRect;
      FPageBandCount: Integer;
      FPageStarted: Boolean;
      FReport: TppCustomReport;
      FReportBandCount: Longint;
      FSilentExceptions: Boolean;
      FSpaceUsed: Longint;
      FStopPrinting: Boolean;

      {events}
      FAfterSendPage: TNotifyEvent;
      FBeforeSendPage: TNotifyEvent;
      FOnGetLastPageCached: TppGetLastPageCachedEvent;
      FOnPageEnd: TNotifyEvent;
      FOnPageSent: TNotifyEvent;
      FOnReadCache: TNotifyEvent;
      FOnResetCache: TNotifyEvent;
      FOnWriteCache: TNotifyEvent;

      function  GetPage: TppPage;
      procedure SetReport(aReport: TppCustomReport);
      procedure SetStopPrinting(Value: Boolean);

    protected
      function GeneratingNewPage: Boolean; virtual; abstract;

      function GetColumnFinished(aColumnNo: Integer): Boolean; virtual; abstract;
      function GetColumnStarted(aColumnNo: Integer): Boolean; virtual; abstract;
      function GetCurrentBand: TppBand; virtual; abstract;
      function GetCurrentBandListIndex: Integer; virtual; abstract;
      function GetPageBottom: Longint; virtual; abstract;
      function GetPageCount: Longint; virtual;
      function GetPageNo: Longint; virtual;
      function GetPageStarted: Boolean; virtual;
      procedure SetColumnFinished(aColumnNo: Integer; aValue: Boolean); virtual; abstract;
      procedure SetColumnStarted(aColumnNo: Integer; aValue: Boolean); virtual; abstract;

      procedure DoAfterSendPage;
      procedure DoBeforeSendPage;
      procedure DoOnGetLastPageCached;
      procedure DoOnPageEnd;
      procedure DoOnPageSent;
      procedure DoOnResetCache;
      procedure DoOnReadCache;
      procedure DoOnWriteCache;

    public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;

      function CachePage: Boolean; virtual; abstract;
      procedure CloseDataPipelines; virtual; abstract;
      procedure DataTraversalCompleted; virtual;
      procedure ESExclude(aEngineStateSet: TppEngineStates);
      procedure ESInclude(aEngineStateSet: TppEngineStates);
      procedure FlushLeft;
      procedure PCInclude(aPrintConditionSet: TppPrintConditions);
      procedure PCExclude(aPrintConditionSet: TppPrintConditions);
      procedure PageLimitReached; virtual;
      procedure Init; virtual; abstract;
      procedure RequestPage(aPageRequest: TppPageRequest); virtual; abstract;
      procedure Reset; virtual; abstract;
      procedure ResetFromPageNo(aAbsolutePageNo: Longint); virtual; abstract;
      procedure RestorePipelineState; virtual; abstract;
      procedure SetPageStarted(aValue: Boolean); virtual;
      procedure SetPrintPosition(Left, Top, Right, Bottom: Longint);
      procedure SyncData; virtual; abstract;
      procedure TraverseData; virtual; abstract;

      property AbsolutePageCount: Longint read FAbsolutePageCount write FAbsolutePageCount;
      property AbsolutePageNo: Longint read FAbsolutePageNo write FAbsolutePageNo;
      property AdvanceRecord: Boolean read FAdvanceRecord write FAdvanceRecord;
      property AllDataTraversed: Boolean read FAllDataTraversed write FAllDataTraversed;
      property CalcsOutOfSync: Boolean read FCalcsOutOfSync write FCalcsOutOfSync;
      property CheckForGroupBreaks: Boolean read FCheckForGroupBreaks write FCheckForGroupBreaks;
      property ColumnFinished[Index: Integer]: Boolean read GetColumnFinished write SetColumnFinished;
      property ColumnStarted[Index: Integer]: Boolean read GetColumnStarted write SetColumnStarted;
      property ControlGroup: TppGroup read FControlGroup write FControlGroup;
      property ControlKeepTogether: TppGroup read FControlKeepTogether write FControlKeepTogether;
      property CurrentBand: TppBand read GetCurrentBand;
      property CurrentBandListIndex: Integer read GetCurrentBandListIndex;
      property CurrentColumn: Integer read FCurrentColumn write FCurrentColumn;
      property DrawPage: Boolean read FDrawPage write FDrawPage;
      property FirstDetailBandPrinted: Boolean read FFirstDetailBandPrinted write FFirstDetailBandPrinted;
      property FirstPassCompleted: Boolean read FFirstPassCompleted write FFirstPassCompleted;
      property GenerateCompleted: Boolean read FGenerateCompleted write FGenerateCompleted;
      property GenerateStarted: Boolean read FGenerateStarted write FGenerateStarted;
      property LastBandGenerated: Boolean read FLastBandGenerated write FLastBandGenerated;
      property LastPageCached: Longint read FLastPageCached;
      property Page: TppPage read GetPage;
      property PageBandCount: Integer read FPageBandCount write FPageBandCount;
      property PageBottom: Longint read GetPageBottom;
      property PageCount: Longint read GetPageCount;
      property PageNo: Longint read GetPageNo;
      property PageStarted: Boolean read GetPageStarted write SetPageStarted;
      property PrintCondition: TppPrintConditions read FPrintCondition write FPrintCondition;
      property Printing: Boolean read FPrinting write FPrinting;
      property PrintDateTime: TDateTime read FPrintDateTime write FPrintDateTime;
      property PrintPosRect: TppRect read FPrintPosRect;
      property Report: TppCustomReport read FReport write SetReport;
      property ReportBandCount: Longint read FReportBandCount write FReportBandCount;
      property SilentExceptions: Boolean read FSilentExceptions write FSilentExceptions;
      property State: TppEngineStates read FEngineState write FEngineState;
      property StopPrinting: Boolean read FStopPrinting write SetStopPrinting;
      property SpaceUsed: Longint read FSpaceUsed write FSpaceUsed;                                      

      {events}
      property AfterSendPage: TNotifyEvent read FAfterSendPage write FAfterSendPage;
      property BeforeSendPage: TNotifyEvent read FBeforeSendPage write FBeforeSendPage;
      property OnGetLastPageCached: TppGetLastPageCachedEvent read FOnGetLastPageCached write FOnGetLastPageCached;
      property OnPageEnd: TNotifyEvent read FOnPageEnd write FOnPageEnd;
      property OnPageSent: TNotifyEvent read FOnPageSent write FOnPageSent;
      property OnResetCache: TNotifyEvent read FOnResetCache write FOnResetCache;
      property OnReadCache: TNotifyEvent read FOnReadCache write FOnReadCache;
      property OnWriteCache: TNotifyEvent read FOnWriteCache write FOnWriteCache;

  end; {class, TppCustomEngine}


  {@TppCustomReport

    Ancestor from which all report classes descend. The standard report
    classes provided with ReportBuilder are:

            - TppReport
            - TppChildReport}

  {@TppCustomReport.AbsolutePageCount

    Run-time and read only.  The total number of pages in the report.

    The AbsolutePageCount always contains the total number of pages for the
    report as a whole.  This differs from the PageCount property, which
    contains a relative page count based on the last group break.  If no
    groups have been created, or no groups have the ResetPageNo property
    set to True, then the PageCount property will contain the same value as
    AbsolutePageCount.}

  {@TppCustomReport.AbsolutePageNo

    Run-time and read only.  The current page which is being printed or
    previewed.

    The AbsolutePageNo always contains the current page number for the
    report as a whole.  This differs from the PageNo property, which
    contains a relative page number based on the last group break.  If no
    groups have been created, or no groups have the ResetPageNo property
    set to True, then the PageNo property will contain the same value as
    AbsolutePageNo.

    Note: If you have coded event handlers in a version prior to 3.0 which
    expect AbsolutePage to start with zero, then you will need to change them.
    AbsolutePageNo starts with 1 as version 3.0}

  {@TppCustomReport.AutoStop

    When AutoStop is set to True, the report will print a single detail
    band and then stop.

    Defaults to True.  When the DataPipeline property is set to a non-nil
    value, AutoStop is set to False.  If the DataPipeline is set to nil,
    AutoStop is set to True.}

  {@TppCustomReport.Bands

    Run-time and read only.  The Bands property returns a specific band in
    the report.  Specify the band using the Index parameter, with the first
    band in the report having an Index of 0.

    To determine the Index for a specific band use the FindBand method.}

  {@TppCustomReport.BandCount

    Run-time and read only.  The BandCount property returns the number of
    bands in the report.}

  {@TppCustomReport.ColumnPositions

    A set of horizontal positions used to place each column of a columnar
    report. ColumnPositions are expressed in report units.

    This property is optional.  The ColumnWidth property is used to
    determine the starting location for each column when no ColumnPositions
    are specified.

    Note: ColumnPositions are absolute positions on the page.  For example, 
    if you specify a column position of 3.25", the column will start at
    exactly 3.25" from the left edge of the page.  Given a paper size, most
    printers define a smaller area which can be used for printing.  The 
    area of the page which cannot be used for printing is sometimes
    referred to as the "gutter."  You must take gutters into account when
    specifying ColumnPositions.  If your printer has a left gutter of 0.25" 
    and you specify a ColumnPosition at 0.0, 0.25" of your column is going
    to be truncated, since it is located in a non-printable area of the
    page.

    ColumnPositions is the only property treated as an absolute page
    position.  All other size and position related properties are relative
    to the report margins.}

  {@TppCustomReport.Columns

    The number of columns you want to print.

    When the columns property is set to any number greater than 1,
    ReportBuilder will print your records in columns.  You can use the
    ColumnWidth property the width of the columns.  If you need to control
    the exact position on the page where each column will start, use the
    ColumnPositions property.

    If you are creating a template to print labels, use the ColumnPositions
    and RowSpacing properties to get your template aligned perfectly over
    the labels.

    At design-time the Report Designer will automatically create column
    header and column footer bands when value of the columns property is
    set to a value greater than 1 and automatically destroy the existing
    column header and column footer bands when the value the columns
    property is set to 1.}

  {@TppCustomReport.ColumnWidth

    The horizontal space to be used for a single column of the report.
    ColumnWidth is expressed in report units.

    When printed, columns are positioned from left to right across the page
    based on the value of ColumnWidth. In order to position each column in
    a precise location use the ColumnPositions property.}

  {@TppCustomReport.CurrentColumn

    Run-time and read only. The current column being printed or previewed.

    This property is for columnar reports only.  It is useful when you need
    to do something in an OnPrint event handler based on the column which
    is currently printing.}

  {@TppCustomReport.DataPipeline

    When this is the only DataPipeline. that has been assigned, or when the
    detail band has been assigned the same data pipeline the detail band
    prints one time for each record.

    You can print master/detail reports by setting the DataPipeline
    property of the DetailBand.  When you do this, the report engine steps
    through its datapipeline one record at a time, and the detail band
    prints once for each record in its datapipeline.}

  {@TppCustomReport.DataTraversalCompleted

    Indicates to the report engine that printing is complete.

    This property is useful when you are using event handlers to take manual
    control over the printing process.  In such a case, it is up to you to tell
    the report engine when and where to stop.  DataTraversalCompleted is used
    for this purpose.

    DataTraversalCompleted is needed by both the FirstPass and SecondPass of the
    report engine.  When called during the first pass, the current page is
    completed.  Then the second pass begins, continuing until once again,
    DataTraversalCompleted is called.

    Note: DataTraversalCompleted will allow the report to continue until all
    stretching components and summary bands have completed printing - even if
    additional pages are required.  In order to stop a report dead in its
    tracks, use the PageLimitReached method.}

  {@TppCustomReport.DefaultBands

    A set of enumerated types representing the bands which will be created
    when the report is first created and displayed in the report designer.}

  {@TppCustomReport.Engine

    The object within the report which is responsible for generating pages
    when the Print or PrintToDevices methods are called.}

  {@TppCustomReport.FirstPass

    Run-time and read only.  While printing, whether the report engine is
    in the first pass.

    During the first pass the report engine calculates totals, determines
    pagination and caches the results.}

  {@TppCustomReport.GroupCount

    Run-time and read only.  The GroupCount property returns the number of
    groups in the report.}

  {@TppCustomReport.Groups

    Run-time and read only.  The Groups property returns a specific group
    in the report.  Specify the group using the Index parameter, with the
    first group in the report having an Index of 0.  To determine the Index
    for a specific group use the FindGroup method.}

  {@TppCustomReport.MainReport

    When child reports exist within the main or other child reports, this
    property is used to retrieve a handle to the main report. If the report
    is the main report, this property returns the pointer to Self.}

  {@TppCustomReport.mmColumnWidth

    The value of the ColumnWidth property in thousandths of millimeters.}

  {@TppCustomReport.Modified

    Indicates whether the report has been changed in the report designer.}

  {@TppCustomReport.NoDataBehaviors

    Determines what action should be taken when a report is connected to a
    DataPipeline that has no data available.  When this condition is
    detected by the report engine, the OnNoData event is fired, allowing
    the behavior to be further customized.

    <Table>
    Value               Meaning
    -------------       -------
    ndBlankPage         The default behavior. No page is generated or sent to the
                        devices. As a result, the standard Print Preview form will
                        display a single blank page, and status bar will read 'Page 0.'
                        If the report is a subreport, the engine will simply exit,
                        without using any page space or adding any draw commands to the
                        page.
    ndBlankReport       The report generates as it normally would and the
                        resulting page is sent to the devices. The detail band
                        generates only once, creating the effect of an 'empty'
                        report, where all the data aware components are blank
                        and all formatting components (shapes, lines, labels,
                        etc.) display as normal.
    ndMessageOnPage     A text label is centered on the output page, which reads
                        'No Data Found.' The draw command used to display this
                        message is passed via the OnNoData event so that the
                        message can be further customized if necessary.
                        MessageOnPage is only available in conjunction with
                        BlankReport.  Since no page is generated when using
                        BlankPage, it iS not possible to display text messages
                        when using this option.  Note: When this behavior is
                        used for fixed or child-type subreports, the text
                        message is centered in the space used by the subreport.
                        Because the message simply says 'No Data Found.', you
                        may want to customize it when used in the context of a
                        subreport, see OnNoData for more on this.
    ndMessageDialog     A modal dialog is displayed.  By default, this dialog
                        simply says: 'No data found for report.'.  The dialog
                        can be replaced with a customized version using the form
                        registration scheme.  The standard dialog can be found
                        in ppNoDataDlg.pas.  Note: This option is usually not
                        useful in the context of subreports, since the dialog is
                        displayed each time a subreport encounters a no data
                        situation. Depending on what you are trying to do, it
                        may make sense to customize TppNoDataDialog for use in
                        the subreport context.
    </Table>}

  {@TppCustomReport.OnEndColumn

    This event fires after a column has completed printing.}

  {@TppCustomReport.OnEndFirstPass

    This event fires after the report has complete the first pass.  You can
    save any grand totals or other calculated values at this point.}

  {@TppCustomReport.OnEndPage

    This event fires after a page has completed printing.  If you set
    DonePrinting to True in this event handler, no further pages will print.}

  {@TppCustomReport.OnEndSecondPass

    This event fires after the report engine completes the second pass.  If
    you are taking manual control of the print process, and have variables
    which are no longer needed when the report is complete, you can clear
    them here.}

  {@TppCustomReport.OnNoData

    This event fires when no data is found by the data pipeline connected
    to a report.  The behaviors indicated by the NoDataBehaviors property
    determines which parameters contain values.

    If the MessageOnPage option has been selected, then the draw text
    command which will be added to the output page is passed via the
    aDrawCommand parameter (otherwise this parameter is nil.) You can
    prevent the draw command from being added to the output page by setting
    aAddDrawCommand to False.  Doing so causes the draw command to be freed
    by the engine.  In order to get access to the draw command properties,
    add ppDrwCmd to the uses clause, and typecast this parameter as
    TppDrawText.  You can then set the value and position of the text, as
    in:

      lDrawText := TppDrawText(aDrawCommand);

      lDrawText.TextAlignment := taCentered;
      lDrawText.Text := 'No orders for ' +
    Table1.FieldByName('Company').AsString;
      lDrawText.Left := 0;
      lDrawText.Width := ppReport1.PrinterSetup.PageDef.mmPrintableWidth;

    If the MessageDialog option has been selected, then the dialog to be
    displayed is passed via the aDialog parameter, otherwise this parameter
    is nil.  You can control whether or not the dialog is displayed by
    setting the aShowDialog parameter (which defaults to True).  aDialog is
    of type TppNoDataDialog (located in ppNoDataDlg.pas.)  You can typecast
    this object in order to customize it, as in:

      lDialog := TppNoDataDialog(aDialog);

      lDialog.memMessage.Text := 'No orders for ' + 
    Table1.FieldByName('Company').AsString;

    Or you can simply replace the No Data dialog with a customized version 
    of your own, using the form registration scheme provided for all
    ReportBuilder dialogs.}

  {@TppCustomReport.OnStartColumn

    This event fires before a new column begins printing on the report.}

  {@TppCustomReport.OnStartFirstPass

    This event fires before report engine begins.  You can do any report level
    initialization in this event.}

  {@TppCustomReport.OnStartPage

    This event fires before a new page begins printing on the report.}

  {@TppCustomReport.OnStartSecondPass

    This event fires before report engine begins the second pass.  If you
    are taking manual control of the print process, you should restore any
    report variables to the values appropriate for printing the first page.}

  {@TppCustomReport.PageBandCount

    The number of bands which have printed on the current page.}

  {@TppCustomReport.PageCount

    When a group has the ResetPageNo property set to True, the PageCount 
    property contains the number of pages relative to the last break.  This 
    is useful when you want to number reports in subsets, such as printing 
    invoices for ten different customers.  If you created a group based on 
    customer name and set the ResetPageNo property to True, the PageCount 
    property would contain the total number of pages for each customer.

    If no groups exist, or no groups have ResetPageNo set to True, the 
    PageCount property contains the total number of pages for the report 
    (this is the same value as the AbsolutePageCount property.)

    You can easily add subset page numbering to any of your reports by 
    creating a TppSystemVariable component with a VarType of vtPageSetDesc.  This
    provides page numbering in the style: '1 of 4 thru 4 of 4', then '1 of 
    2 thru 2 of 2', etc. }

  {@TppCustomReport.PageLimit

    The PageLimit property sets the number of pages which will be printed.
    If a DataPipeline is specified the report will stop when all records
    have been traversed or when the page limit is reached, whichever comes
    first. When set to 0, the report will generate normally, and no page
    limit will be enforced.

    Defaults to 0.

    Note: If there is no DataPipeline specified for the report and the
    PageLimit is set to 0, pages will be generated until the
    DataTraversalCompleted or PageLimitReached methods are called.}

  {@TppCustomReport.PageNo

    The current page being printed or previewed.

    When a group has the ResetPageNo property set to True, the PageNo
    property contains the page number relative to the last group break.
    This is useful when you want to number reports in subsets, such as
    printing invoices for ten different customers.  If you created a group
    based on customer name and set the ResetPageNo property to True, the
    PageNo property would contain the page number for each invoice,
    starting at 1. 

    If no groups exist, or no groups have ResetPageNo set to True, the
    PageNo property contains the page number relative to the report as a
    whole (this is the same value as the AbsolutePageNo property.)

    You can easily add subset page numbering to any of your reports by
    creating a TppVariable component with a VarType of vtPageSetDesc.  This
    provides page numbering in the style: '1 of 4 thru 4 of 4', then '1 of
    2 thru 2 of 2', etc.}

  {@TppCustomReport.ParentReport

    Pointer to the parent report in which the child report is nested.}

  {@TppCustomReport.PassSetting

    The value of the PassSetting property determines how many times a
    report traverses the data before generating pages. These are the
    possible values:

    <Table>
    Value          Meaning
    ---------      -------
    psOnePass      The report generates the requested pages during the first
                   traversal of the data.
    psTwoPass      In the first pass the report traverses the data, calculating
                   pagination. Then in the second pass the report returns to the
                   beginning of the data and traverses the data again generating
                   the requested pages.
    </Table>}

  {@TppCustomReport.PrintDateTime

    Run-time and read only.  The current date and time when the report
    began printing.

    This property is useful when you want to print the same date time stamp
    on each page of a report.  It contains the same value as the TppSystemVariable
    component (when VarType is set to vtPrintDateTime.)  This property is
    provided so that you can customize the date time stamp when necessary.
    Use the OnPrint event handler of a TppVariable component in
    order to do this.}

  {@TppCustomReport.ReportBandCount

    Run-time and read only.  This property indicates the number of bands
    which have printed in the report so far.}

  {@TppCustomReport.SaveAsTemplate

    When set to False, the report is saved as an object embedded within the
    form or parent report (for subreports). This is the default.  When set
    to True, the report is saved based on the settings of the Template
    property.}

  {@TppCustomReport.SecondPass

    Run-time and read only.  While printing, whether the report engine is
    in the second pass.

    During the second pass the report engine prints the requested pages to
    the current device.}

  {@TppCustomReport.spColumnWidth

    The value of the ColumnWidth property in screen pixels.}

  {@TppCustomReport.Template

    This property allows you to load and save report definitions.
    Definitions can be saved in files or database BLOB fields.

    To save a report definition to a file, set the FileName property to the 
    full path and file name and call the SaveToFile procedure.  To load a
    definition set the FileName property and call LoadFromFile.

    Use the Template's DatabaseSettings object property to connect the 
    template to a database and subsequently load and save report a report
    definition to a database BLOB field. Then call the SaveToDatabase
    method to save the report.  To load a report from a database, assign 
    the same properties and call the LoadFromDatabase method.

    The Format property can be used to control the format of the report 
    definition (either binary or ASCII.)  The default format is binary,
    since this provides better performance.

    Note: When saving report definitions in ASCII format, you can save the
    definition in a Memo field instead of BLOB field.  This can be helpful
    when the database you are using does not support BLOB fields.}

  {@TppCustomReport.Units

    The Units property indicates the measuring system to be used for
    expressing the value of all size and position related properties. (i.e.
    Height, Width, BottomOffset, PrintPosition, ColumnWidth, etc.) These
    are the possible values:

    <Table>
    Value               Meaning
    ---------------     -------
    utInches            Display in inches.
    utMillimeters       Display in millimeters.
    utScreenPixels      Display in screen pixels.
    utPrinterPixels     Display in printer pixels.
    utMMThousandths     Display in thousandths of millimeters.
    </Table>}

  {@TppCustomAutoSearchDialog.Init

    This procedure is a called after OnAutoSearchDialogCreate has fired.  In
    this procedure the AutoSearchDialog creates the AutoSearchNotebook and adds
    all of the AutoSearchFields from the report to it.}

  TppCustomReport = class(TppProducer)
  private
    FAutoStop: Boolean;
    FBands: TList;
    FCacheManagers: TList;                                                                                        
    FColumns: Integer;
    FColumnPositions: TStrings;
    FColumnWidth: Longint;
    FDataPipeline: TppDataPipeline;
    FDataPipelineName: String;
    FDefaultBands: TppBandTypes;
    FEngine: TppCustomEngine;
    FmmColumnPositions: TStrings;
    FGroups: TList;
    FModified: Boolean;
    FNoDataBehaviors: TppNoDataBehaviors;
    FOnEndColumn: TNotifyEvent;
    FOnEndFirstPass: TNotifyEvent;
    FOnEndPage: TNotifyEvent;
    FOnEndSecondPass: TNotifyEvent;
    FOnNoData: TppNoDataEvent;
    FOnStartColumn: TNotifyEvent;
    FOnStartFirstPass: TNotifyEvent;
    FOnStartPage: TNotifyEvent;
    FOnStartSecondPass: TNotifyEvent;
    FPageLimit: Integer;
    FParentReport: TppCustomReport;
    FPassSetting: TppPassSettingType;
    FPrintingAsSubReport: Boolean;
    FReportDesigner: TForm;
    FSaveAsTemplate: Boolean;
    FTemplate: TppReportTemplate;
    FUnits: TppUnitType;
    FUpdateCounter: Integer;

    {used for converstion to 3.0}
    FOldColumnWidth: Single;

    FModules: TList;

    function  CheckComponentPositions(const aAction: String; aWidth: Longint): Boolean;
    procedure ColumnPositionsChange(Sender: TObject);
    function  GetAbsolutePageNo: Longint;
    function  GetAbsolutePageCount: Longint;
    function  GetBandCount: Integer;
    function  GetCodeModule: TComponent;
    function  GetColumnPositions: TStrings;
    function  GetColumnWidth: Single;
    function  GetCurrentColumn: Integer;
    function  GetDonePrinting: Boolean;
    function  GetFirstPass: Boolean;
    function  GetGroupCount: Integer;
    function  GetPageNo: Longint;
    function  GetPageCount: Longint;
    function  GetPageBandCount: Integer;
    function  GetPrintDateTime: TDateTime;
    function  GetReportBandCount: Integer;
    function  GetScreenPixelColumnWidth: Integer;
    function  GetSecondPass: Boolean;
    function  GetTheBand(Index: Integer): TppBand;
    function  GetTheGroup(Index: Integer): TppGroup;
    procedure SetBandOrder;
    procedure SetColumns(Value: Integer);
    procedure SetColumnPositions(Value: TStrings);
    procedure SetColumnWidth(Value: Single);
    procedure SetDataPipeline(aDataPipeline: TppDataPipeline); 
    procedure SetDonePrinting(Value: Boolean);
    procedure SetNoDataBehaviors(Value: TppNoDataBehaviors);
    procedure SetPageLimit(Value: Integer);
    procedure SetPassSetting(Value: TppPassSettingType);
    procedure SetParentReport(aReport: TppCustomReport);
    procedure SetReportDesigner(aReportDesigner: TForm);
    procedure SetUnits(aUnits: TppUnitType);
    procedure SetTemplate(aTemplate: TppReportTemplate);

    {read/write private 'fake' properties}
    procedure ReadColumnWidth(Reader: TReader);
    procedure ReadDataPipelineName(Reader: TReader);
    procedure ReadUserName(Reader: TReader);

    procedure WriteColumnWidth(Writer: TWriter);
    procedure WriteDataPipelineName(Writer: TWriter);

    {used for conversion to 3.0}
    procedure ReadRulerUnits(Reader: TReader);

  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoOnLoadTemplate(aReport: TppCustomReport); virtual;
    function  FireAfterPrint: Boolean; override;
    procedure ReadState(Reader: TReader); override;
    procedure SetModified(Value: Boolean); virtual;
    procedure SetName(const Value: TComponentName); override;

    procedure LayoutChanged; virtual;
    procedure PageEnded(Sender: TObject); virtual;
    procedure PageSent(Sender: TObject); virtual;
    procedure PrinterSetupChanged; override;
    procedure PageDefChanged; override;
    procedure PrinterSetupChangeQueryEvent(Sender: TObject; aNewPageDef: TObject; var CanChange: Boolean); override;
    function  GetCaption: String; virtual; abstract;
    function  GetMainReport: TppCustomReport; virtual; abstract;
    function  GetPropUserName: TComponentName; override;

    {component streaming stuff}
    procedure GetChildren(Proc: TGetChildProc;Root: TComponent); override;
    function GeneratingNewPage: Boolean;
    function HasEmailGroups: Boolean; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Loaded; override;
    
    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
    procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

    class function ClassDescription: String; virtual;
    class function ClassBitmap: THandle; virtual;
    class function GetOutlineParent(aPossibleParent: TppCommunicator; aChild: TppCommunicator): TppCommunicator;
    class function IsTemplate: Boolean; virtual;

    procedure AddBand(aBand: TppBand);
    procedure AddCacheManager(aCacheManager: TppCacheManager);
    procedure AddGroup(aGroup: TppGroup);
    procedure AddModule(aModule: TppCommunicator);
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure SendDesignMessage(aMsg, aWParam: Integer; aOParam: TObject); override;
    function  ConfirmWidthChange(aWidth: Longint; aWarningMessage: String): Boolean;
    procedure Convert(aVersionNo: Integer); override;
    procedure ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
    procedure ChangeOwner(aNewOwner: TComponent); override;
    procedure CreateDefaultBands;
    procedure DataTraversalCompleted;
    procedure DoOnEndColumn;
    procedure DoOnEndFirstPass;
    procedure DoOnEndPage;
    procedure DoOnEndSecondPass;
    procedure DoOnNoData(aDialog: TObject; var aShowDialog: Boolean; aDrawCommand: TObject; var aAddDrawCommand: Boolean);
    procedure DoOnStartColumn;
    procedure DoOnBeforeGenerate;
    procedure DoOnStartFirstPass;
    procedure DoOnStartPage;
    procedure DoOnStartSecondPass;
    procedure DSExclude(aDesignStateSet: TppDesignStates); override;
    procedure DSInclude(aDesignStateSet: TppDesignStates); override;
    procedure DumpCache;
    procedure EndOfMainReport; virtual;
    procedure ESExclude(aEngineStateSet: TppEngineStates); virtual; abstract;
    procedure ESInclude(aEngineStateSet: TppEngineStates); virtual; abstract;
    function  FindBand(aBand: TppBand): Integer;
    function  FindGroup(aGroup: TppGroup): Integer;
    procedure FinishPage;
    procedure FreeBandsAndGroups;
    procedure FreeModules;
    function  FindUserObject(aUserName: String): TppCommunicator; override;
    procedure FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
    function  GetBand(aBandType : TppBandType; aGroupIndex: Integer): TppBand;
    procedure GetCacheables(aAddCacheableProc: TppAddCacheableProc);
    procedure GetRBDataModulePipelines(aDataPipelines: TList);
    procedure GetDataPipelines(aDataPipelines: TList);
    procedure GetFirstLevelSubReports(aReportList: TStrings);
    function  GetModuleForClass(aModuleClass: TClass): TppCommunicator;
    procedure GetReportKey(var aKey: String); virtual; abstract;
    procedure GetOutlineChildren(aList: TList);
    function  GetPrintMessage: String; virtual; abstract;
    procedure GetSubReports(aReportList: TStrings);
    function  GetUniqueUserName(aComponent: TComponent): String; override;
    function  HasParentCodeModules: Boolean;
    procedure LanguageChanged; override;
    procedure MoveGroup(aCurrentPos, aNewPos: Integer);
    procedure NewNotify;
    procedure UpdateParentDataPipeline(aNewDataPipeline, aOldDataPipeline: TppDataPipeline);
    function  ObjectByName(var aBandIndex: Integer; var aComponentIndex: Integer; const aComponentName: String): Boolean;
    procedure PageLimitReached;
    function  PrintingSection: Boolean;
    procedure RaiseException(aException: Exception); override;
    procedure RemoveBand(aBand: TppBand);
    procedure RemoveCacheManager(aCacheManager: TppCacheManager);
    procedure RemoveGroup(aGroup: TppGroup);
    procedure RemoveModule(aModule: TppCommunicator);
    procedure Reset; override;
    procedure ResolvePipelineReferences; overload;
    procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); overload; virtual;
    procedure SetGroupPosition(aGroup: TppGroup; aPosition: Integer);
    procedure SetPrintMessage(const aMessage: String); virtual; abstract;
    procedure StartOfMainReport; virtual;
    procedure StartOfParentReport; virtual;                   
    procedure Stop;
    procedure TemplateChanged;
    procedure Transfer(aSource: TppCommunicator); override;
    procedure TriggerCodeModuleBeforePrint; override;
    procedure TriggerCodeModuleCreate; override;
    procedure TriggerCodeModuleDestroy; override;
    procedure ValidateBands; virtual; abstract;

    property AbsolutePage: Longint read GetAbsolutePageNo;
    property AbsolutePageNo: Longint read GetAbsolutePageNo;
    property AbsolutePageCount: Longint read GetAbsolutePageCount;
    property Bands[Index: Integer]: TppBand read GetTheBand;
    property BandCount : Integer read GetBandCount;
    property Caption: String read GetCaption;
    property CodeModule: TComponent read GetCodeModule;
    property CurrentColumn: Integer read GetCurrentColumn;
    property DefaultBands: TppBandTypes read FDefaultBands write FDefaultBands;
    property DonePrinting: Boolean read GetDonePrinting write SetDonePrinting;
    property Engine: TppCustomEngine read FEngine;
    property FirstPass: Boolean read GetFirstPass;
    property Groups[Index: Integer]: TppGroup read GetTheGroup;
    property GroupCount : Integer read GetGroupCount;
    property MainReport: TppCustomReport read GetMainReport;
    property mmColumnWidth: Longint read FColumnWidth;
    property Modified: Boolean read FModified write SetModified;
    property Page: Longint read GetPageNo;
    property PageNo: Longint read GetPageNo;
    property PageBandCount: Integer read GetPageBandCount;
    property PageCount: Longint read GetPageCount;
    property ParentReport: TppCustomReport read FParentReport write SetParentReport;
    property ReportDesigner: TForm read FReportDesigner write SetReportDesigner;
    property PrintDateTime: TDateTime read GetPrintDateTime;
    property PrintingAsSubReport: Boolean read FPrintingAsSubReport write FPrintingAsSubReport;
    property ReportBandCount: Integer read GetReportBandCount;
    property SecondPass: Boolean read GetSecondPass;
    property spColumnWidth: Integer read GetScreenPixelColumnWidth;
    property UserName;

  published
    property AutoStop: Boolean read FAutoStop write FAutoStop default True;
    property Columns: Integer read FColumns write SetColumns default 1;
    property ColumnPositions: TStrings read GetColumnPositions write SetColumnPositions;
    property ColumnWidth: Single read GetColumnWidth write SetColumnWidth stored False;
    property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline;
    property NoDataBehaviors: TppNoDataBehaviors read FNoDataBehaviors write SetNoDataBehaviors default [ndBlankPage];
    property OnEndColumn: TNotifyEvent read FOnEndColumn write FOnEndColumn;
    property OnEndFirstPass: TNotifyEvent read FOnEndFirstPass write FOnEndFirstPass;
    property OnEndPage: TNotifyEvent read FOnEndPage write FOnEndPage;
    property OnEndSecondPass: TNotifyEvent read FOnEndSecondPass write FOnEndSecondPass;
    property OnNoData: TppNoDataEvent read FOnNoData write FOnNoData;
    property OnPrintingComplete;
    property OnSaveText;
    property OnStartColumn: TNotifyEvent read FOnStartColumn write FOnStartColumn;
    property OnStartFirstPass: TNotifyEvent read FOnStartFirstPass write FOnStartFirstPass;
    property OnStartPage: TNotifyEvent read FOnStartPage write FOnStartPage;
    property OnStartSecondPass: TNotifyEvent read FOnStartSecondPass write FOnStartSecondPass;
    property PageLimit: Integer read FPageLimit write SetPageLimit default 0;
    property PassSetting: TppPassSettingType read FPassSetting write SetPassSetting default psOnePass;
    property PrinterSetup;
    property SaveAsTemplate: Boolean read FSaveAsTemplate write FSaveAsTemplate default False;
    property Template: TppReportTemplate read FTemplate write SetTemplate;
    property Units: TppUnitType read FUnits write SetUnits default utInches;

  end; {class, TppCustomReport}


  {@TppBand

    This class implements associative properties between bands and the base
    classes of other objects.}

  {@TppBand.AfterGenerate

    The AfterGenerate event fires after the band prints.  Use the AfterGenerate
    event when you want to perform actions after a band has printed.
    AfterGenerate differs from AfterPrint in that AfterPrint print fires every
    time  a band has the opportunity to print. Sometimes the band has an
    opportunity to print, but for various reasons does not (usually printing on
    the next page instead.)  In these cases, AfterPrint will fire, but
    AfterGenerate will not.}

  {@TppBand.AfterPrint

    This event fires after the band has printed.}

  {@TppBand.BeforeGenerate

    The BeforeGenerate event fires before the band prints.  Use the
    BeforeGenerate event when you want to perform actions before a band prints.
    BeforeGenerate differs from BeforePrint in that BeforePrint fires every time
    a band has the opportunity to print. Sometimes the band has an opportunity
    to print, but for various reasons does not (usually printing on the next
    page instead.)  In these cases, BeforePrint will fire, but BeforeGenerate
    will not.}

  {@TppBand.BeforePrint

    This event fires before a band begins printing.  Use this event to perform
    actions before a band prints. One action is to control the visibility of
    objects which should or shoudl not print in the band. This
    is the best event to use for setting the visibility of controls in a band.

    Note: Do not use the BeforePrint or BeforeGenerate events for calculations.
    Use a TppVariable.OnCalc for calculations instead.}

  {@TppBand.BottomOffset

    Use the BottomOffset property to define the vertical space which will
    appear after the band.  The BottomOffset is expressed in report units.}

  {@TppBand.Height

    The Height property expresses the vertical size of a band in report
    units.}

  {@TppBand.ObjectCount

    Run-time and read only.  The ObjectCount property returns the number of
    components in the band or region.  When the band contains a region, the
    value of ObjectCount includes the region and all of the components in
    the region.}

  {@TppBand.Objects

    Run-time and read only.  The Objects property returns a specific object
    in the band.  Specify the object using the Index parameter, with the
    first object in the band having an Index of 0.  To determine the Index
    for a specific object use the FindObject method.

    When a band contains a region, the region and all of the components
    contained in the region are included in the Objects property.}

  {@TppBand.PrintCount

    Use the PrintCount property to limit the number of times the detail band
    prints on each page.

    Note: In order to limit the total number of records traversed by the report,
    use the RangeEndCount property of the DataPipeline.}

  {@TppBand.PrintHeight

    The PrintHeight property determines vertical space which will be used
    when a band is printed.  These are the possible values:

    <Table>
    Value      Meaning
    ---------  ------
    phDynamic  Band height shrinks or stretches based on report
               components.
    phStatic   Band height is always the same.
    </Table>

    When PrintHeight is set to phDynamic, the band uses page space on an
    as-needed basis, shrinking or stretching the band to accommodate the
    report components.  When PrintHeight is set to phStatic, the band uses
    the exact amount of page space specified by the Height property.  Note:
    If the Visible property is set to False, the band does not use any
    space on the page, regardless of the value of PrintHeight.

    Note:  The PrintHeight for the FooterBand and ColumnFooterBand is
    always phStatic and cannot be changed.}

  {@TppBand.PrintPosition

    Use the PrintPosition property to declare the vertical position on the
    page where the band should be printed.  The PrintPosition is expressed
    in report units. If the print position of the report is beyond the
    PrintPosition of the band, then the report advances to the next page
    and attempts to print the band again.

    Note: If PrintPosition is used for a detail band, then only the first
    detail band of the page uses the position with the remaining detail
    bands printing below the first.}

  {@TppBand.Report

    Run-time only.  When dynamically creating a report at run-time, use
    this property to assign a band to a report.}

  {@TppBand.Save

    Used only when printing to a text file.  Set this property to True to
    save the contents of the current band to a text file.

    Note: You must also set the Save property of each textual component in
    the band in order to write text to the file.}

  {@TppBand.VariableCount

    Run-time and read only.  The VariableCount property returns the number
    of variables in the band.}

  {@TppBand.Variables

    Run-time and read only.  The Variables property returns a specific
    variable in the band.  Specify the variable using the Index parameter,
    with the first variable in the band having an Index of 0.  To determine
    the number of variables in the band, use the VariableCount property.}

  {@TppBand.Visible

    Defaults to True. This property determines whether the band will print.

    Note: The BeforePrint and AfterPrint events will fire regardless of the
    status of the Visible property.}
    
  TppBand = class(TppCacheable)
  private
    FBottomOffset: Longint;
    FCaption: String;
    FCaptionIndex: Longint;
    FDrawPage: Boolean;
    FHeight: Longint;
    FLastBand: Boolean;
    FObjects: TList;
    FPrevRect: TppSizeRect;
    FPrintCount: Integer;
    FPrintHeight: TppPrintHeightType;
    FPrintPosition: Longint;
    FPrintTimes: TppPrintTimesType;
    FReport: TppCustomReport;
    FSave: Boolean;
    FSaveList: TList;
    FUnits: TppUnitType;
    FVariables: TList;
    FVisible: Boolean;

    {event handling variables}
    FAfterGenerate: TNotifyEvent;
    FAfterPrint: TNotifyEvent;
    FBeforeGenerate: TNotifyEvent;
    FBeforePrint: TNotifyEvent;

    {used for conversion to 3.0}
    FOnPrint: String;

    procedure ConvertCalcs(Sender: TObject);
    procedure FixCalcOrderList;
    procedure FixSaveOrderList;
    function GetBandType: TppBandType;
    function  GetBottomOffset: Single;
    function  GetHeight: Single;
    function  GetIndex: Integer;
    function  GetPrevRect: TppSizeRect;
    function  GetPrintPosition: Single;
    function  GetSave(aIndex: TTabOrder): TppComponent;
    function  GetSaveCount: Integer;
    function  GetScreenPixelHeight: Integer;
    function  GetVariable(aIndex: TTabOrder): TppComponent;
    function  GetVariableCount: Integer;
    procedure SetBottomOffset(Value: Single);
    procedure SetHeight(Value: Single);
    procedure SetMMHeight(Value: LongInt);
    procedure SetPrevRect(const Value: TppSizeRect);
    procedure SetPrintPosition(Value: Single);
    procedure SetVisible(Value: Boolean);

    {used by report designer}
    function  GetTop: Longint;
    function  GetScreenPixelTop: Integer;
    function  GetScreenPixelWidth: Integer;
    procedure SetScreenPixelTop(Value: Integer);
    procedure SetScreenPixelHeight(Value: Integer);

    {read/write private 'fake' properties}
    procedure ReadBottomOffset(Reader: TReader);
    procedure ReadHeight(Reader: TReader);
    procedure ReadPrintPosition(Reader: TReader);
    procedure WriteBottomOffset(Writer: TWriter);
    procedure WriteHeight(Writer: TWriter);
    procedure WritePrintPosition(Writer: TWriter);

    {used for conversion to 3.0}
    procedure ReadOnPrint(Reader: TReader);
    procedure ReadOnSaveLineEnd(Reader: TReader);
    procedure ReadOnSaveLineStart(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure ReadLeft(Reader: TReader);

  protected
    {overriden from TComponent}
    procedure DefineProperties(Filer: TFiler); override;

    procedure DoAfterGenerate; virtual;
    procedure DoAfterPrint; virtual;
    procedure DoBeforeGenerate; virtual;
    procedure DoBeforePrint; virtual;
    function  GetDefaultPrintTimes: TppPrintTimesType; virtual;
    function  GetLanguageIndex: Longint;
    function  GetObject(aIndex: Integer): TppComponent;
    function  GetObjectCount: Integer;
    function  GetRank: String; virtual; abstract;
    function  GetPrintCondition: TppPrintConditions; virtual; abstract;
    function  GetWidth: LongInt;
    procedure PropertyChange; override;
    procedure SetCaption(aCaption: String); virtual;
    procedure SetPrintCount(Value: Integer);
    procedure SetPrintHeight(aPrintHeight: TppPrintHeightType); virtual;
    procedure SetReport(aReport: TppCustomReport); virtual;
    procedure SetSave(Value: Boolean);

    {component streaming stuff}
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;

    procedure GetChildren(Proc: TGetChildProc;Root: TComponent); override;
    function GeneratingNewPage: Boolean;


  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    procedure AddObject(aObject: TObject);
    procedure AddSave(aComponent: TppComponent);
    procedure AddVariable(aComponent: TppComponent);
    procedure ChangeOwner(aNewOwner: TComponent); override;
    procedure ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
    procedure DSExclude(aDesignStateSet: TppDesignStates); override;
    procedure DSInclude(aDesignStateSet: TppDesignStates); override;
    procedure EndOfMainReport; virtual;
    procedure FinishPage; virtual;
    function  FindObject(aComponent: TppComponent): Integer;
    function  FindSave(aComponent: TppComponent): Integer;
    function  FindVariable(aComponent: TppComponent): Integer;
    procedure FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String); virtual;
    function  FromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType): Single;
    procedure Generate; virtual; abstract;
    function  GetADataPipeline: TppDataPipeline; virtual;
    function  GetDescription: String; virtual; abstract;
    function  GetParentComponent: TComponent; override;
    function  GetPrinter: TppPrinter;
    function  GetPrintMessage: String;
    function  HasParent: Boolean; override;
    function  IndexOfSave(aComponent: TppComponent): TTabOrder;
    function  IndexOfVariable(aComponent: TppComponent): TTabOrder;
    procedure Init; virtual;
    procedure InsertSave(aPosition: TTabOrder; aComponent: TppComponent);
    procedure MoveSave(aCurrentPosition, aNewPosition: Integer);
    procedure InsertVariable(aPosition: TTabOrder; aComponent: TppComponent);
    function  IsColumnar: Boolean; virtual;
    function  IsDataAware: Boolean; virtual;
    function  IsValidUserName(aUserName: String): Boolean; override;
    procedure LanguageChanged; virtual;
    procedure MoveObject(aCurIndex, aNewIndex: Integer);
    function  ObjectByName(var aComponentIndex: Integer; const aComponentName: String): Boolean;
    procedure PageStart; virtual;
    function  Printing: Boolean;
    procedure RemoveObject(aObject: TObject);
    procedure RemoveSave(aComponent: TppComponent);
    procedure RemoveVariable(aComponent: TppComponent);
    procedure Reset;
    procedure Resize; virtual;
    procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); virtual;
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetPrintMessage(const aMessage: String);
    procedure SetUnits(aUnits: TppUnitType);
    procedure StartOfMainReport; virtual;
    procedure StartOfParentReport; virtual;
    procedure GetSubReports(aList: TList);

    property BottomOffset: Single read GetBottomOffset write SetBottomOffset;
    property Caption: String read FCaption write SetCaption;
    property CaptionIndex: Longint read FCaptionIndex write FCaptionIndex;
    property DrawPage: Boolean read FDrawPage write FDrawPage;
    property Index: Integer read GetIndex;
    property LastBand: Boolean read FLastBand write FLastBand;
    property LanguageIndex: Longint read GetLanguageIndex;
    property mmBottomOffset: Longint read FBottomOffset;
    property mmHeight: Longint read FHeight;
    property mmPrintPosition: Longint read FPrintPosition;
    property mmTop: Longint read GetTop;
    property mmWidth: Longint read GetWidth;
    property ObjectCount: Integer read GetObjectCount;
    property Objects[Index: Integer]: TppComponent read GetObject;
    property PrevRect: TppSizeRect read GetPrevRect write SetPrevRect;
    property PrintCondition: TppPrintConditions read GetPrintCondition;
    property PrintCount: Integer read FPrintCount write SetPrintCount default 0;
    property PrintPosition: Single read GetPrintPosition write SetPrintPosition;
    property PrintTimes: TppPrintTimesType read FPrintTimes write FPrintTimes default ptOne;
    property PrintHeight: TppPrintHeightType read FPrintHeight write SetPrintHeight default phStatic;
    property SaveCount: Integer read GetSaveCount;
    property Saves[Index: TTabOrder]: TppComponent read GetSave;
    property spHeight: Integer read GetScreenPixelHeight write SetScreenPixelHeight;
    property spTop: Integer read GetScreenPixelTop write SetScreenPixelTop;
    property spWidth: Integer read GetScreenPixelWidth;
    property Report : TppCustomReport read FReport write SetReport;
    property Rank: String read GetRank;
    function ToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType): Longint;
    property Units: TppUnitType read FUnits write SetUnits;
    property VariableCount: Integer read GetVariableCount;
    property Variables[Index: TTabOrder]: TppComponent read GetVariable;

    {used for conversion to 3.0}
    procedure Convert(aVersionNo: Integer); virtual;
    property BandType: TppBandType read GetBandType;
    property OnPrint: String read FOnPrint;

  published
    property AfterGenerate: TNotifyEvent read FAfterGenerate  write FAfterGenerate;
    property AfterPrint: TNotifyEvent read FAfterPrint  write FAfterPrint;
    property BeforePrint: TNotifyEvent read FBeforePrint  write FBeforePrint;
    property BeforeGenerate: TNotifyEvent read FBeforeGenerate  write FBeforeGenerate;
    property Height: Single read GetHeight write SetHeight stored False;
    property Save: Boolean read FSave write SetSave default False;
    property Visible: Boolean read FVisible write SetVisible default True;

  end; {class, TppBand}


  {@TppGroupFileSettings

    Use the Group File Settings to control how ReportBuilder handles creating
    and emailing a new file for each group.}

  {@TppGroupFileSettings.NewFile

    Set the NewFile property to True to export a new file each time a group
    break occurs.  By default each file will be prefixed with the defined
    file name given in the Print Dialog or TextFileName/ArchiveFileName
    properties and suffixed with the group break value.  The prefix and suffix
    are separated by an underscore.

    Example:  MyReport_100.pdf
              MyReport_200.pdf

    To customize the file suffix, implement the TppGroup.OnGetFileSuffix event.
    If a single underscore is sent to the file device as the FileName, the file
    suffix defined will represent the entire file name.}

  {@TppGroupFileSettings.EmailFile

    Set the EmailFile property to True to automatically email an exported new
    file each time a group break occurs using the email settings defined for the
    report.  The same file naming rules as the NewFile property apply.

    To customize the email settings for each group, implement the
    TppGroup.OnGetEmailSettings event.

    The TppEmailSettings.DeleteFile property controls whether the exported file
    is deleted from the hard drive after it has been sent.}

  {@TppGroupFileSettings.EmailField

    Defines the data filed containing email addresses for each group file sent.
    This field must be inside the dataset connected to the group's parent
    report.  If no email address is present, the email will be skipped.}

  TppGroupFileSettings = class(TPersistent)
  private
    FNewFile: Boolean;
    FEmailFile: Boolean;
    FEmailField: string;
    FGroup: TppGroup;

    procedure SetNewFile(aNewFile: Boolean);
    procedure SetEmailFile(aEmailFile: Boolean);
    procedure SetGroup(aGroup: TppGroup);

  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

    property Group: TppGroup read FGroup write SetGroup;

  published
    property NewFile: Boolean read FNewFile write SetNewFile;
    property EmailFile: Boolean read FEmailFile write SetEmailFile;
    property EmailField: string read FEmailField write FEmailField;

  end; {class, TppGroupFileSettings}


  {@TppGroup

    Use the group component allows to break your report into several
    sections, based on the value of the field specified in the BreakName
    property. As the report traverses the records of your data, it tracks
    the value of the field or component upon which the group is based.
    Each time this value changes, a group break occurs.

    Use the group header band TppGroupHeaderBand to print headings or
    introductory information before a group starts. Use the group footer
    band TppGroupFooterBand to print summary information after a group
    ends.

    To start a new page each time a group break occurs, use the NewPage
    property. To start a new column each time a group break occurs, use the
    NewColumn property. Use the ResetPageNo property in conjunction with
    NewPage in order to enables subset page numbering, where each group has
    its own set of page numbers.

    You can create, edit, and delete groups using the Report Designer's
    Groups dialog which can be accessed via the Report | Groups menu
    option.}

  {@TppGroup.BreakName

    Use BreakName to set the name of the field on which this group will be
    based.  As the report is generated, a group break will occur each time the
    value of this field changes.

    BreakName is used in conjunction with BreakType.  If you set BreakType to
    btCustomField, then you can specify any textual component in the report as
    the basis for the group.  This allows you to specify groups based on custom
    calculations.}

  {@TppGroup.BreakNo

    This property indicates the number of times a group break has occurred.  If
    the group never breaks during the course of report generation, the BreakNo
    will be 0.}

  {@TppGroup.BreakType

    The BreakType property determines what type of component the group can be
    based upon.

    <Table>
    Value          Meaning
    -------------  ------------
    btDataField    Group can be based on any field in the Report or
                   DetailBand DataSource
    btCustomField  Group can be based on any textual component in the
                   report
    </Table>}

  {@TppGroup.DataPipeline

    For databased groups, the DataPipeline and BreakName properties determine
    where the group obtains data when checking the break value.}

  {@TppGroup.DetailCount

    Number of detail iterations for the current group.}

  {@TppGroup.FooterBand

    Run-time and read only.  The footer band for the group.

    Use the group footer band to display group totals or special formatting,
    such as lines and shapes, to separate group breaks.}

  {@TppGroup.GroupFileSettings

    Used to control group file creation and email processing.}

  {@TppGroup.HeaderBand

    Run-time and read only.  The header band for the group.

    Use the group header band to display group totals or special formatting to
    separate group breaks.}

  {@TppGroup.HeaderForOrphanedFooter

    Defaults to True. When the group footer is orphaned (prints alone at the top
    of a page with no preceding detail bands) then this property determines
    whether the group header will be printed.}

  {@TppGroup.KeepTogether

    Defaults to True. This property indicates whether groups can break across
    pages. If the group cannot fit on the remaining space of a page, the group
    will advance to the next page and print there.  If the group advances to the
    next page and still will not fit, then the group will break across pages
    starting at the new page.}

  {@TppGroup.NewColumn

    In order to start a new column each time a group break occurs, set the
    NewColumn property to True.}

  {@TppGroup.NewColumnThreshold

    Use NewColumnThreshold to set the minimum amount of space which must exist
    below a group header band in order for it to print on the current column.
    If this amount of space is not available, the group header will print on the
    next page.

    This property is most useful when NewColumn is set to False and group breaks
    are occuring near the bottom of columns.

    NewColumnThreshold is expressed in the Units of the report. For example, if
    units are set to utInches and NewColumnThreshold is set to 3, group header
    bands will be forced to the next page when the remaining page space is less
    than 3 inches.}

  {@TppGroup.NewPage

    In order to start a new page each time a group break occurs, set the NewPage
    property to True.

    When NewPage is set to True, ResetPageNo can be used for subset page
    numbering.}

  {@TppGroup.NewPageThreshold
    Use NewPageThreshold to set the minimum amount of space which must exist
    below a group header band in order for it to print on the current page.
    If this amount of space is not available, the group header will print on
    the next page.

    This property is most useful when NewPage is set to False and group breaks
    are occuring near the bottom of pages.

    NewPageThreshold must be set based on the Units property of the report.
    For example, if the units are set to utInches and NewPageThreshold is set
    to 3, group header bands will be forced to the next page when the remaining
    page space is less than 3 inches.}

  {@TppGroup.OnGetBreakValue

    This event fires each time a group checks the break value. You can override
    the value for the group by setting the aBreakValue parameter}

  {@TppGroup.OnGetFileSuffix

    This event fires each time a new file is created when the
    TppGroup.GroupFileSettings.NewFile property is set to True.  The value of
    the file suffix can be overridden by setting the aText parameter.}

  {@TppGroup.OnGetEmailSettings

    This event fires each time a new file is created and emailed when the
    TppGroup.GroupFileSettings.EmailFile property is set to True.  The
    individual email settings can be overridden by type casting the
    aEmailSettings parameter. }

  {@TppGroup.OutlineSettings

    Controls the behavior of report outline node generation for a group. When
    enabled, an outline tree structure is dynamically generated by the report
    engine and rendered by the report previewer.

    From the report designer, select the Report|Outline Settings... menu
    option to access a dialog that enables simple visual configuration of
    outline settings for all relevant objects in the report.

    Use the CreateNode boolean property to control whether an outline node
    is created each time a group break occurs in the report.

    OutlineSettings can also be configured for the TppReport object and for
    TppSubReport objects which have a PrintBehavior of pbSection.}

  {@TppGroup.Report

    Run-time only.  When dynamically creating a group at run-time, use this
    property to assign a group to a report.

    Groups can have a group header and group footer band.  If you create a group
    header or footer at run-time, use the Group property to assign it to the
    appropriate group.  The report property of the group then links the bands to
    the report (See example.)}

  {@TppGroup.ResetPageNo

    Use ResetPageNo to enable subset page numbering.

    ResetPageNo is only available when a report group has the NewPage property
    set to True.}

  {@TppGroup.ReprintOnSubsequentColumn

    For TppGroup components, ReprintOnSubsequentColumn determines whether the
    TppGroupHeaderBand prints again when the detail bands for a specific group
    overflow onto additional columns.}

  {@TppGroup.ReprintOnSubsequentPage

    For TppGroup components, ReprintOnSubsequentPage determines whether the
    TppGroupHeaderBand prints again when the detail bands for a specific group
    overflow onto additional pages.}

  {@TppGroup.StartOnOddPage

    This property will force each group to begin on an odd page.  This can be
    helpful for duplexed reports where groups need to be started on the front
    side of the next page.}

  TppGroup = class(TppCacheable, IppOutlineParticipant)
  private
    FAfterGroupBreak: TNotifyEvent;
    FBeforeGroupBreak: TNotifyEvent;
    FBreakComponent: TppComponent;
    FBreaking: Boolean;
    FBreakNo: Integer;
    FBreakType: TppBreakType;
    FBreakName: String;
    FBreakValue: String;
    FCacheManager: TppCacheManager;
    FDataPipeline: TppDataPipeline;
    FDataPipelineName: String;
    FDetailCount: Integer;
    FFirstColumn: Integer;
    FFirstPageNo: Longint;
    FFooterBand: TppBand;
    FGroupFileSettings: TppGroupFileSettings;
    FHeaderBand: TppBand;
    FHeaderForOrphanedFooter: Boolean;
    FKeepTogether: Boolean;
    FKeptTogether: Boolean;
    FLastPageNo: Longint;
    FNewColumn: Boolean;
    FNewPage: Boolean;
    FNewColumnThreshold: Longint;
    FNewPageThreshold: Longint;
    FOnGetBreakValue: TppGetBreakValueEvent;
    FOnGetFileSuffix: TppGetTextEvent;
    FOnGetEmailSettings: TppGetEmailSettingsEvent;
    FOutlineChildren: TList;
    FOutlineSettings: TppOutlineSettings;
    FPage: TppPage;
    FPosition: Integer;
    FPriorValue: String;
    FReport: TppCustomReport;
    FReprintOnSubsequentColumn: Boolean;
    FReprintOnSubsequentPage: Boolean;
    FResetPageNo: Boolean;
    FResettingCache: Boolean;
    FSetBreakComponent: Boolean;
    FStartOnOddPage: Boolean;
    FTag: Integer;
    FUnits: TppUnitType;

    {used for conversion to 3.0}
    FFieldName: String;
    FOldThreshold: Single;
    FReprintOnSubsequent: Boolean;

    procedure DoAfterGroupBreak;
    procedure DoBeforeGroupBreak;
    function  GetBreakComponent: TppComponent;
    function  GetDescription: String;
    function  GetCurrentValue: String;
    function  GetGroupNo: Integer;
    function  GetIndex: Integer;
    function  GetNewColumnThreshold: Single;
    function  GetNewPageThreshold: Single;
    function  GetPageCount: Longint;
    function  GetPageNo: Longint;
    procedure ResetCache;
    procedure SetBreakName(const aBreakName: String);
    procedure SetBreakType(aBreakType: TppBreakType);
    procedure SetDataPipeline(aDataPipeline: TppDataPipeline);
    procedure SetFooterBand(aGroupFooterBand: TppBand);
    procedure SetGroupFileSettings(aGroupFileSettings: TppGroupFileSettings);
    procedure SetHeaderBand(aGroupHeaderBand: TppBand);
    procedure SetHeaderForOrphanedFooter(Value: Boolean);
    procedure SetKeepTogether(Value: Boolean);
    procedure SetNewColumn(Value: Boolean);
    procedure SetNewPage(Value: Boolean);
    procedure SetNewColumnThreshold(Value: Single);
    procedure SetNewPageThreshold(Value: Single);
    procedure SetOutlineSettings(aOutlineSettings: TppOutlineSettings);
    procedure SetReport(aReport: TppCustomReport);
    procedure SetReprintOnSubsequentColumn(Value: Boolean);
    procedure SetReprintOnSubsequentPage(Value: Boolean);
    procedure SetStartOnOddPage(const Value: Boolean);
    procedure UpdateCache;

    procedure ReadDataPipelineName(Reader: TReader);
    procedure ReadNewColumnThreshold(Reader: TReader);
    procedure ReadNewPageThreshold(Reader: TReader);
    procedure ReadNewFile(Reader: TReader);
    procedure WriteDataPipelineName(Writer: TWriter);
    procedure WriteNewColumnThreshold(Writer: TWriter);
    procedure WriteNewPageThreshold(Writer: TWriter);
    procedure WriteNewFile(Writer: TWriter);

    {used for conversion to 3.0}
    procedure ReadFieldName(Reader: TReader);
    procedure ReadReprintOnSubsequent(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure ReadLeft(Reader: TReader);

  protected
    procedure DefineProperties(Filer: TFiler); override; {contains temporary conversion routine}

    {component streaming stuff}
    procedure Loaded; override;
    procedure GetChildren(Proc: TGetChildProc;Root: TComponent); override;
    procedure ReadState(Reader: TReader); override;


  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
    procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

    procedure BeforeHeader;
    procedure BeforeFooter;
    procedure BreakComponentNameChanged(const aOldName, aNewName: String);
    procedure CheckForBreak;
    procedure Clear; virtual;
    procedure DetailOutOfSpace; virtual;
    procedure EndOfMainReport;
    function  FirstPage: Boolean;
    procedure FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
    procedure ForceBreak;
    procedure FreeCache(aCachePageNo: Longint); override;
    function  FromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType): Single;
    function  GetParentComponent: TComponent; override;
    function  GetPrinter: TppPrinter;
    procedure GroupFooterAfterPrint;
    procedure GroupHeaderBeforeGenerate;
    procedure GroupHeaderBeforePrint;
    function  HasParent: Boolean; override;
    procedure Init;
    procedure BandOrderChanged;
    procedure PositionChanged; virtual;
    function  Printing: Boolean;
    procedure RefreshBreakValues;
    procedure Reset;
    procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
    procedure RestoreFromCache(aCachePageNo: Longint); override;
    procedure SaveToCache(aCachePageNo: Longint); override;
    procedure SetBreakComponent;
    procedure SetParentComponent(Value: TComponent); override;
    procedure StartOfMainReport;
    procedure StartOfParentReport; virtual;
    function  ToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType): Longint;
    procedure UpdatePageCount;

    {used for conversion to 3.0}
    procedure Convert(aVersionNo: Integer); virtual;

    {IppOutlineParticipant}
    function iOutlineGetChildren: TList;
    function iOutlineGetParent: TppCommunicator;
    function iOutlineNodeCreatorClass: TComponentClass;
    function iOutlineSettings: TppOutlineSettings;
    procedure iOutlineSettingsChanged;

    property BreakComponent: TppComponent read GetBreakComponent;
    property Breaking: Boolean read FBreaking write FBreaking;
    property BreakNo: Integer read FBreakNo write FBreakNo;
    property BreakValue: String read FBreakValue write FBreakValue;
    procedure ConvertBreakValueNames(const aOldFieldName, aNewFieldName: String);
    property CurrentValue: String read GetCurrentValue;
    property Description: String read GetDescription;
    property DetailCount: Integer read FDetailCount;
    property FirstColumn: Integer read FFirstColumn write FFirstColumn;
    property FirstPageNo: Longint read FFirstPageNo write FFirstPageNo;
    property FooterBand: TppBand read FFooterBand write SetFooterBand;
    property Index: Integer read GetIndex;
    property GroupNo: Integer read GetGroupNo stored False;
    property HeaderBand: TppBand read FHeaderBand write SetHeaderBand;
    property KeptTogether: Boolean read FKeptTogether write FKeptTogether default False;
    property LastPageNo: Longint read FLastPageNo write FLastPageNo;
    property mmNewColumnThreshold: Longint read FNewColumnThreshold;
    property mmNewPageThreshold: Longint read FNewPageThreshold;
    property Position: Integer read FPosition write FPosition;
    property PageNo: Longint read GetPageNo;
    property PageCount: Longint read GetPageCount;
    property PriorValue: String read FPriorValue write FPriorValue;
    property Report: TppCustomReport read FReport write SetReport;
    property Units: TppUnitType read FUnits write FUnits;

    {used for conversion to 3.0}
    property FieldName: String read FFieldName;
    property ReprintOnSubsequent: Boolean read FReprintOnSubsequent;

  published
    property AfterGroupBreak: TNotifyEvent read FAfterGroupBreak write FAfterGroupBreak;
    property BeforeGroupBreak: TNotifyEvent read FBeforeGroupBreak write FBeforeGroupBreak;
    property BreakName: String  read FBreakName write SetBreakName;
    property BreakType: TppBreakType read FBreakType write SetBreakType default btDataField;
    property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline;
    property GroupFileSettings: TppGroupFileSettings read FGroupFileSettings write SetGroupFileSettings;
    property HeaderForOrphanedFooter: Boolean read FHeaderForOrphanedFooter write SetHeaderForOrphanedFooter default True;
    property KeepTogether: Boolean read FKeepTogether write SetKeepTogether default False;
    property OnGetBreakValue: TppGetBreakValueEvent read FOnGetBreakValue write FOnGetBreakValue;
    property OnGetFileSuffix: TppGetTextEvent read FOnGetFileSuffix write FOnGetFileSuffix;
    property OnGetEmailSettings: TppGetEmailSettingsEvent read FOnGetEmailSettings write FOnGetEmailSettings;
    property OutlineSettings: TppOutlineSettings read FOutlineSettings write SetOutlineSettings;
    property NewColumn: Boolean read FNewColumn write SetNewColumn default False;
    property NewPage: Boolean read FNewPage write SetNewPage default False;
    property NewColumnThreshold: Single read GetNewColumnThreshold write SetNewColumnThreshold stored False;
    property NewPageThreshold: Single read GetNewPageThreshold write SetNewPageThreshold stored False;
    //property NewFile: Boolean read FNewFile write SetNewFile;
    property ResetPageNo: Boolean read FResetPageNo write FResetPageNo default False;
    property ReprintOnSubsequentColumn: Boolean read FReprintOnSubsequentColumn write SetReprintOnSubsequentColumn default True;
    property ReprintOnSubsequentPage: Boolean read FReprintOnSubsequentPage write SetReprintOnSubsequentPage default True;
    property StartOnOddPage: Boolean read FStartOnOddPage write SetStartOnOddPage;
    property Tag: Integer read FTag write FTag default 0;
    property UserName;

  end; {class, TppGroup}


  {@TppComponent

    Ancestor from which all report components descend. TppComponent has two
    descendants:

            - TppCustomComponent
            - TppStretchable}

  {@TppComponent.Band

    Run-time only.  The Band property of the report component is assigned
    implicitly at design time when you use the mouse to drag the component
    to its desired band area on the report. At run-time you can explicitly
    assign a report component to a band by setting the report component's
    Band property.

    The Band is essentially the parent of the report component.}

  {@TppComponent.BringToFront

    The BringToFront method places the report control in front of all
    other report controls within the same band.

    To do this from the Report Designer, select the component and
    then click the BringToFront button on the Format Bar.}

  {@TppComponent.ParentDataPipeline

    The ParentDataPipeline property determines where a component looks for its
    datasource information. If ParentDataPipeline is True, the component uses
    its parent's datapipeline property. If ParentDataPipeline is False, the
    component uses its own DataPipeline property.

    By using ParentDataPipeline, you can ensure that all the controls on a band
    or in a report will access the same data as their parent. For example, if
    you want all the components in a report to use a new DataPipeline, you can
    set the Report's DataPipeline property. By default, all the controls in the
    report will use the new datapipeline. To specify a different datapipeline
    for a particular component, specify the desired datapipeline as the value of
    the component's DataPipeline property, and ParentDataPipeline becomes False
    automatically.

    When the ParentDataPipeline is True for a component in a DetailBand that has
    the datapipeline property specified, the component uses the value of the
    DetailBand's DataPipeline property.}

  {@TppComponent.Anchors

    Specifies how a report component is anchored to its parent.

    Use Anchors to ensure that a report component maintains its current position
    relative to an edge of its parent control (ie. Band/Region), even if the
    parent is resized. When its parent is resized, the component holds its
    position relative to the edges to which it is anchored.

    Use opposite anchors simultaneously (i.e. left and right anchor) to force
    the component to stretch relative to the new size of the parent.  For
    instance, if a memo is placed inside a region and the width of the region is
    increased, the memo will automatically increase its width as well.

    Anchors can be useful when a Report's paper size or orientation is changed
    on the fly.  For example, anchoring a TppSystemVariable at the bottom right
    corner of the footer band will keep it in that position relative to those
    sides of the footer band regardless the page size or orientation. }


  TppComponent = class(TppPrintable)
  private
    FAnchors: TppAnchors;
    FBand: TppBand;
    FBandType: TppBandType;
    FGroupNo: Integer;
    FParentDataPipeline: Boolean;
    FRegion: TppComponent;
    FResetGroup: TppGroup;

    function GetIndex: Integer;
    function GetParentIndex: Integer;

    {read/write private properties}
    procedure ReadBandType(Reader: TReader);
    procedure ReadGroupNo(Reader: TReader);
    procedure ReadShiftWithParent(Reader: TReader);
    procedure WriteBandType(Writer: TWriter);
    procedure WriteGroupNo(Writer: TWriter);

  protected
    {override from TComponent}
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadState(Reader: TReader); override;

    function GeneratingNewPage: Boolean;

    function  IsGroupBased: Boolean; virtual;
    function  GetDesigner: TForm; override;
    function  GetLanguageIndex: LongInt; override;
    function  GetMainReport: TppCustomReport;
    function  GetNextSibling: TppComponent; virtual;
    function  GetParent: TComponent; virtual;
    function  GetPrinter: TppPrinter; override;
    function  GetReport: TppCustomReport;
    function  GetShiftWithParent: Boolean; override;
    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

    procedure SetBand(aBand: TppBand); virtual;
    procedure SetDataPipeline(aDataPipeline: TppDataPipeline); override;
    procedure SetParentDataPipeline(Value: Boolean); virtual;
    procedure SetResetGroup(aGroup: TppGroup); virtual;

    procedure SetAnchors(const Value: TppAnchors); virtual;
    procedure SetParentHeight(Value: Boolean); override;
    procedure SetParentWidth(Value: Boolean); override;
    procedure SetRegion(aRegion: TppComponent); virtual;
    procedure SetShiftWithParent(Value: Boolean); override;
    procedure SetMMHeight(Value: Longint); override;
    procedure SetMMLeft(Value: Longint); override;
    procedure SetMMTop(Value: Longint); override;
    procedure SetMMWidth(Value: Longint); override;
    function  spGetClipRect: TRect; override;
    function  mmGetParentRect: TppRect; virtual;
    function  mmGetPrevRect: TppSizeRect; virtual;
    procedure SetIndex(const Value: Integer); virtual;
    procedure UpdateDesignControlBounds; override;


  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    procedure BringToFront; virtual;
    procedure BringForward; virtual;
    function  GetParentComponent: TComponent; override;
    function  GetPrintMessage: String;
    function  HasParent: Boolean; override;
    procedure mmSetBounds(aLeft, aTop, aWidth, aHeight: LongInt); override;
    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
    procedure ParentBoundsChange;
    function  Printing: Boolean; override;
    procedure ProcessMessages;
    procedure Reset; override;
    procedure SendToBack; virtual;
    procedure SendBackward; virtual;
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetPrintMessage(const aMessage: String);

    property Anchors: TppAnchors read FAnchors write SetAnchors default [atLeft, atTop];
    property Band: TppBand read FBand write SetBand stored False;
    property BandType: TppBandType read FBandType;
    property Index: Integer read GetIndex write SetIndex;
    property NextSibling: TppComponent read GetNextSibling;
    property ParentIndex: Integer read GetParentIndex;
    property GroupNo: Integer read FGroupNo;
    property Parent: TComponent read GetParent;

    property ParentDataPipeline: Boolean read FParentDataPipeline write SetParentDataPipeline default True;
    property Region: TppComponent read FRegion write SetRegion;
    property Report: TppCustomReport read GetReport;
    property ResetGroup: TppGroup read FResetGroup  write SetResetGroup;

  published
    property Name;
    property Owner;
    property Tag;
    property UserName;

  end; {class, TppComponent}


  {@TdaDataView
   Abstract ancestor class. A DataView is a container class for data access
   components used by a report. TdaDataView defines the base functionality
   common to all DataViews.

   DataViews contain one or more DataPipelines that can be accessed by using
   the DataPipelines[] array and DataPipelineCount properties.

   DataViews can optionally support the following functionality

      - design-time tools such as data designers and wizards
      - templates that autmatically create pre-defined sets of data access
        components that can be used by end-users. For example, an Invoice
        dataview template that contains linked datasets for customer/order/items
        Invoice reports.
      - linking to a master dataview

   Desendants include TdaCustomDataView.}

   {@TdaDataView.DataPipelineCount
    Returns the number of items in the DataPipelines[] array}

   {@TdaDataView.DataPipelines
    Array of DataPipeline objects contained in the DataView. Typically a
    DataView will contain a single DataPipeline of type TppDBPipeline.}

   {@TdaDataView.UserName
    A unique identifier used to refer to the DataView within the context
    of the report.}
  TdaDataView = class(TppRelative)
    private
      FAutoSearchTabOrder: Integer;
      FActive: Boolean;
      FOnDeleteLink: TNotifyEvent;
      FEditMode: TppDataEditType;
      FEditOptions: TppDataEditTypes;
      FEnabledOptions: TppDataEditTypes;
      FLanguageIndex: Longint;
      FMasterDataView: TdaDataView;
      FNew: Boolean;
      FNextAction: TppNextActionType;
      FOnLinkChange: TNotifyEvent;
      FOnEditOptionChange: TNotifyEvent;
      FOnNameChange: TNotifyEvent;
      FOnValidateName: TppValidateNameEvent;
      FReport: TppCustomReport;

      procedure ReadReport(Reader: TReader);

    protected
      procedure ConnectReportToPipelines; virtual;
      procedure DefineProperties(Filer: TFiler); override;
      procedure DoOnDeleteLink;
      procedure DoOnEditOptionChange;
      procedure DoOnLinkChange;
      procedure DoOnNameChange;
      procedure DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
      function GetDataPipelineCount: Integer; virtual; abstract;
      function GetDescription: String; virtual;
      function GetDataPipelineForIndex(aIndex: Integer): TppDataPipeline; virtual; abstract;
      function GetLinkColor: TColor; virtual; abstract;
      procedure Modification;
      procedure SetActive(aValue: Boolean); virtual;
      procedure SetAutoSearchTabOrder(aValue: Integer); virtual;
      procedure SetEditOptions(Value: TppDataEditTypes); virtual;
      procedure SetEnabledOptions(Value: TppDataEditTypes); virtual;
      procedure SetLanguageIndex(aLanguageIndex: Longint); virtual;
      procedure SetLinkColor(aColor: TColor); virtual; abstract;
      procedure SetReport(aReport: TppCustomReport); virtual;
      procedure SetMasterDataView(aDataView: TdaDataView); virtual;

    public                                                                     
      constructor Create(aOwner: TComponent); override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Convert(aVersionNo: Integer); virtual; abstract;

      class function ClassBitmap: THandle; virtual; {abstract; - removed to support CBuilder}
      class function ClassDescription: String; virtual; {abstract; - removed to support CBuilder}
      class function PreviewFormClass: TFormClass; virtual; {abstract; - removed to support CBuilder}
      class function SessionClass: TClass; virtual; {abstract; - removed to support CBuilder}
      class function IsTemplate: Boolean; virtual; {abstract; - removed to support CBuilder}

      function CreateAutoLink(aDataViews: TList; aDataDictionary: TObject): Boolean; virtual; abstract;
      procedure CreateLink(aMasterDataView: TdaDataView; aMasterFieldAlias, aDetailFieldAlias: String); virtual; abstract;
      procedure DeleteLink(aIndex: Integer); virtual; abstract;
      procedure Design; virtual; abstract;
      function GetLinkColorForField(aFieldName: String): TColor; virtual; abstract;
      function GetLinkCount: Integer; virtual; abstract;
      function GetLinkDescription: String; virtual; abstract;
      procedure GetLinkFieldNames(aIndex: Integer; var aMasterSQLFieldName, aDetailSQLFieldName: String); virtual; abstract;
      function GetMagicFieldCount: Integer; virtual; abstract;
      procedure GetMagicSQL(aSQLText: TStrings); virtual; abstract;
      function InMasterChain(aDataView: TdaDataView): Boolean; virtual; abstract;
      function IsLinkable: Boolean; virtual; abstract;
      function IsLinkableAsMaster: Boolean; virtual; abstract;
      procedure Link(aLinkableDataViews: TList); virtual; abstract;
      procedure LinkChanged; virtual; abstract;
      procedure OutOfSync; virtual; abstract;
      procedure Preview; virtual; abstract;
      procedure Sync; virtual; abstract;
      procedure UpdateEnabledOptions(aLinkableDataViews: TList); virtual; abstract;

      function AddDataPipeline(aDataPipeline: TppDataPipeline): Integer; virtual; abstract;
      function RemoveDataPipeline(aDataPipeline: TppDataPipeline): Integer; virtual; abstract;

      property Active: Boolean read FActive write SetActive;
      property AutoSearchTabOrder: Integer read FAutoSearchTabOrder write SetAutoSearchTabOrder;
      property Description: String read GetDescription;
      property DataPipelines[Index: Integer]: TppDataPipeline read GetDataPipelineForIndex;
      property DataPipelineCount: Integer read GetDataPipelineCount;
      property EditMode: TppDataEditType read FEditMode write FEditMode;
      property EditOptions: TppDataEditTypes read FEditOptions write SetEditOptions default cAllDataEditOptions;
      property EnabledOptions: TppDataEditTypes read FEnabledOptions write SetEnabledOptions default cAllDataEditOptions;
      property LanguageIndex: Longint read FLanguageIndex write SetLanguageIndex;
      property New: Boolean read FNew write FNew;
      property NextAction: TppNextActionType read FNextAction write FNextAction default ppnaNone;
      property OnDeleteLink: TNotifyEvent read FOnDeleteLink write FOnDeleteLink;
      property OnLinkChange: TNotifyEvent read FOnLinkChange write FOnLinkChange;
      property OnValidateName: TppValidateNameEvent read FOnValidateName write FOnValidateName;
      property OnNameChange: TNotifyEvent read FOnNameChange write FOnNameChange;

      property LinkColor: TColor read GetLinkColor write SetLinkColor;
      property MasterDataView: TdaDataView read FMasterDataView write SetMasterDataView;

      property Report: TppCustomReport read FReport write SetReport;

    published
      property UserName;

  end; {class TdaDataView}


{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppCustomReportRTTI }
  TraTppCustomReportRTTI = class(TraTppProducerRTTI)
    public
      class procedure GetEventList(aClass: TClass; aPropList: TraPropList); override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCustomReportRTTI}

  {@TraTppBandRTTI }
  TraTppBandRTTI = class(TraTppCacheableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppBandRTTI}

  {@TraTppGroupRTTI }
  TraTppGroupRTTI = class(TraTppCacheableRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppGroupRTTI}

  {@TraTppComponentRTTI }
  TraTppComponentRTTI = class(TraTppPrintableRTTI)
    public
      class function CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppComponentRTTI}




  { TppComponent class reference type }
  TppComponentClass = class of TppComponent;
  TdaDataViewClass = class of TdaDataView;


  procedure ppRegisterComponent(aComponentClass: TComponentClass;
                                const aToolBarName: String;
                                aToolBarPosition: Integer;
                                aHintIndex: Integer;
                                const aHint: String;
                                aHInstance: Longint);


  procedure ppUnRegisterComponent(aComponentClass: TComponentClass);

var
  ppRegisterComponentProc: procedure (aComponentClass: TComponentClass;
                                      const aToolBarName: String;
                                      aToolBarPosition: Integer;
                                      aHintIndex: Integer;
                                      const aHint: String;
                                      aHInstance: Longint) = nil;

  ppUnRegisterComponentProc: procedure (aComponentClass: TComponentClass) = nil;


implementation

uses
  ppRichTx,
  ppClasUt,
  ppEngine,
  ppBands,
  ppSubRpt,
  ppDsIntf,
  ppReport,
  ppVar,
  ppCtrls,
  ppStrtch,
  ppRegion,
  ppBarCod,
  ppBarCode2D,
  ppMemo,
  ppTmDlg,
  ppTmEDlg,
  ppModule,
  ppDisplayFormat,
  ppOutlineReportNodeCreator,
  ppOutlineGroupNodeCreator,
  ppPageBreak,
  ppPaintBox,
  ppDesignEventHub;

{******************************************************************************
 *
 ** D A T A  V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaDataView.Create }

constructor TdaDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAutoSearchTabOrder := 0;
  FEditMode := ppemAll;
  FEditOptions := cAllDataEditOptions;
  FEnabledOptions := cAllDataEditOptions;
  FLanguageIndex := 0;
  FMasterDataView := nil;
  FNew := False;
  FOnDeleteLink := nil;
  FOnEditOptionChange := nil;
  FOnLinkChange := nil;
  FOnNameChange := nil;
  FReport := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaDataView.ClassBitmap }

class function TdaDataView.ClassBitmap: THandle;
begin
  {treat as abastract - descendants must override}
  Result := 0;
end; {class function, ClassBitmap}

{------------------------------------------------------------------------------}
{ TdaDataView.ClassDescription }

class function TdaDataView.ClassDescription: String;
begin
  {treat as abastract - descendants must override}
  Result := '';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdaDataView.PreviewFormClass }

class function TdaDataView.PreviewFormClass: TFormClass;
begin
  {treat as abastract - descendants must override}
  Result := nil;
end; {class function, PreviewFormClass}

{------------------------------------------------------------------------------}
{ TdaDataView.SessionClass }

class function TdaDataView.SessionClass: TClass;
begin
  {treat as abastract - descendants must override}
  Result := nil;
end; {class function, SessionClass}

{------------------------------------------------------------------------------}
{ TdaDataView.IsTemplate }

class function TdaDataView.IsTemplate: Boolean;
begin
  {treat as abastract - descendants must override}
  Result := False;
end; {class function, IsTemplate}

{------------------------------------------------------------------------------}
{ TdaDataView.Notify }

procedure TdaDataView.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FReport) then
    SetReport(nil);

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TdaDataView.SetReport }

procedure TdaDataView.SetReport(aReport: TppCustomReport);
begin

  if (FReport <> nil) then
    FReport.RemoveEventNotify(Self);

  FReport := aReport;

  if (FReport <> nil) then
    FReport.AddEventNotify(Self);

  SendEventNotify(Self, ciDataViewReportAssigned, nil);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FReport = nil) or (pppcTemplateLoading in Report.DesignState) or
                        (csLoading in Report.ComponentState) then Exit;


  if (FReport.DataPipeline = nil) then
    ConnectReportToPipelines;


end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TdaDataView.ReadReport }

procedure TdaDataView.ReadReport(Reader: TReader);
begin

  Reader.ReadIdent;

end;

{------------------------------------------------------------------------------}
{ TdaDataView.ConnectReportToPipelines }

procedure TdaDataView.ConnectReportToPipelines;
begin

  {descendants should add code here to set the initial datapipeline for the report.
  the end-user can modify this and save the results}
  if (Report <> nil) and (DataPipelineCount > 0) then
    Report.DataPipeline := DataPipelines[0];

end; {procedure, ConnectReportToPipelines}

{------------------------------------------------------------------------------}
{ TdaDataView.DefineProperties }

procedure TdaDataView.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  {used for conversion to 6.5}
  Filer.DefineProperty('Report', ReadReport, nil, False);

end;

{------------------------------------------------------------------------------}
{ TdaDataView.GetDescription }

function TdaDataView.GetDescription: String;
begin

  if (DataPipelineCount = 1) then
    Result := DataPipelines[0].UserName
  else
    Result := ClassDescription;

end;  {procedure, GetDescription}

{------------------------------------------------------------------------------}
{ TdaDataView.SetEditOptions }

procedure TdaDataView.SetEditOptions(Value: TppDataEditTypes);
begin
  FEditOptions := Value;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  DoOnEditOptionChange;

end; {procedure, SetEditOptions}

{------------------------------------------------------------------------------}
{ TdaDataView.SetMasterDataView }

procedure TdaDataView.SetMasterDataView(aDataView: TdaDataView);
begin

  if (FMasterDataView <> nil) then
    FMasterDataView.RemoveEventNotify(Self);

  FMasterDataView := aDataView;

  if (FMasterDataView <> nil) then
    FMasterDataView.AddEventNotify(Self);

end; {procedure, SetMasterDataView}

{------------------------------------------------------------------------------}
{ TdaDataView.SetEnabledOptions }

procedure TdaDataView.SetEnabledOptions(Value: TppDataEditTypes);
begin
  FEnabledOptions := Value;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

 { DoOnEnabledOptionChange;}

end; {procedure, SetEnabledOptions}

{------------------------------------------------------------------------------}
{ TdaDataView.DoOnNameChange }

procedure TdaDataView.DoOnNameChange;
begin
  if Assigned(FOnNameChange) then FOnNameChange(Self);
end; {procedure, DoOnNameChange}

{------------------------------------------------------------------------------}
{ TdaDataView.DoOnLinkChange }

procedure TdaDataView.DoOnLinkChange;
begin
  if Assigned(FOnLinkChange) then FOnLinkChange(Self);
end; {procedure, DoOnLinkChange}

{------------------------------------------------------------------------------}
{ TdaDataView.DoOnDeleteLink }

procedure TdaDataView.DoOnDeleteLink;
begin
  if Assigned(FOnDeleteLink) then FOnDeleteLink(Self);
end; {procedure, DoOnDeleteLink}

{------------------------------------------------------------------------------}
{ TdaDataView.DoOnEditOptionChange }

procedure TdaDataView.DoOnEditOptionChange;
begin
  if Assigned(FOnEditOptionChange) then FOnEditOptionChange(Self);
end; {procedure, DoOnEditOptionChange}

{------------------------------------------------------------------------------}
{ TdaDataView.Modification }

procedure TdaDataView.Modification;
begin
  if (FReport <> nil) then
    FReport.Modified := True;
end; {procedure, Modification}

{------------------------------------------------------------------------------}
{ TdaDataView.SetActive }

procedure TdaDataView.SetActive(aValue: Boolean);
begin
  FActive := aValue;
end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdaDataView.SetAutoSearchTabOrder }

procedure TdaDataView.SetAutoSearchTabOrder(aValue: Integer);
begin
  FAutoSearchTabOrder := aValue;
end; {procedure, SetAutoSearchTabOrder}

{------------------------------------------------------------------------------}
{ TdaDataView.SetLanguage }

procedure TdaDataView.SetLanguageIndex(aLanguageIndex: Integer);
begin
  FLanguageIndex := aLanguageIndex;
end; {procedure, SetLanguageIndex}

{------------------------------------------------------------------------------}
{ TdaDataView.DoOnValidateName }

procedure TdaDataView.DoOnValidateName(Sender: TObject; const aName: String; var aNameValid: Boolean);
begin
  if Assigned(FOnValidateName) then FOnValidateName(Sender, aName, aNameValid);
end; {procedure, DoOnValidateName}

{******************************************************************************
 *
 ** C U S T O M   R E P O R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomReport.Create }

constructor TppCustomReport.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  EventNotifies := EventNotifies + [ciPipelineBeforeClose];

  FAutoStop := True;
  FBands := TList.Create;
  FCacheManagers := TList.Create;
  FColumns := 1;
  FColumnPositions := TStringList.Create;
  TStringList(FColumnPositions).OnChange := ColumnPositionsChange;
  FColumnWidth := 0;
  FDataPipeline := nil;
  FDefaultBands := cReportBands;
  FmmColumnPositions := TStringList.Create;
  FGroups := TList.Create;
  FModified := False;
  FNoDataBehaviors := [ndBlankPage];
  FOnEndColumn := nil;
  FOnEndFirstPass := nil;
  FOnEndPage := nil;
  FOnEndSecondPass := nil;
  FOnNoData := nil;
  FOnStartColumn := nil;
  FOnStartFirstPass := nil;
  FOnStartPage := nil;
  FOnStartSecondPass := nil;
  FPageLimit := 0;
  FParentReport := nil;
  FPassSetting := psOnePass;
  FPrintingAsSubReport := False;
  FReportDesigner := nil;
  FSaveAsTemplate := False;
  FUnits := utInches;

  FTemplate := TppReportTemplate.Create(Self);

  FModules := nil;

  FEngine := TppEngine.Create(Self);
  FEngine.OnPageEnd := PageEnded;
  FEngine.OnPageSent := PageSent;

  PrinterSetup.DocumentName := UserName;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomReport.Destroy }

destructor TppCustomReport.Destroy;
begin

  DumpCache;

  FCacheManagers.Free;
  FCacheManagers := nil;
  
  {showMessage('TppCustomReport.Destroy - begin');}

  {showMessage('notify pipeline');}

  {tell data pipeline that we no longer exist}
  if (FDataPipeline <> nil) then
    FDataPipeline.RemoveEventNotify(Self);


 { showMessage('notify designer');}
 {notify Report Designer, this will set FReportDesigner to nil }
  SendDesignMessage(RM_REPORTDESTROY,ppWCustomMsg, Self);

  {  showMessage('FEngine.StopPrinting := True');}
  {if engine is generating pages, tell it to stop}
  if FEngine.Printing then
    FEngine.StopPrinting := True;

  {  showMessage('FreeBandsAndGroups');}
  {free bands and groups}
  FreeBandsAndGroups;

  FreeModules;

 {    showMessage('free list objects');}
  {free list objects}
  FBands.Free;
  FGroups.Free;
  FColumnPositions.Free;
  FmmColumnPositions.Free;

    {  showMessage('FEngine.Free');}
 {free engine}
  FEngine.Free;
  FEngine := nil;

  { showMessage(' FTemplate.Free;');}

  {free TPersistent objects}
  FTemplate.Free;
  FTemplate := nil;

  {inherited Destroy}
  inherited Destroy;

 {showMessage('TppCustomReport.Destroy - end');}

end; {destructor, Destroy}



{------------------------------------------------------------------------------}
{TppCustomReport.SendDesignMessage }

procedure TppCustomReport.SendDesignMessage(aMsg, aWParam: Integer; aOParam: TObject);
begin

  if (MainReport <> nil) and MainReport.Printing then Exit;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetRBDataModulePipelines }

procedure TppCustomReport.GetRBDataModulePipelines(aDataPipelines: TList);
var
  lDataModule: TppReportModule;
  lMainReport: TppCustomReport;

begin
  lMainReport := GetMainReport;

  {get datapipelines from data module}
  if (lMainReport <> nil) then
    begin
      lDataModule := TppReportModule(lMainReport.GetModuleForClass(GetClass('TdaDataModule')));

      if lDataModule <> nil then
        lDataModule.GetDataPipelines(aDataPipelines);
    end;

end; {procedure, GetRBDataModulePipelines}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetDataPipelines }

procedure TppCustomReport.GetDataPipelines(aDataPipelines: TList);
var
  liIndex: Integer;
  liIndex2: Integer;
  lBand: TppBand;
  lDetailBand: TppDetailBand;
  lComponent: TppComponent;
begin

  if (FDataPipeline <> nil) and (aDataPipelines.IndexOf(FDataPipeline) = -1) then
    aDataPipelines.Add(FDataPipeline);

  lBand := GetBand(btDetail, 0);

  if (lBand <> nil) then
    begin
      lDetailBand := TppDetailBand(lBand);

      if (lDetailBand.DataPipeline <> nil) and (aDataPipelines.IndexOf(lDetailBand.DataPipeline) = -1) then
        aDataPipelines.Add(lDetailBand.DataPipeline);
    end;

  for liIndex := 0 to BandCount - 1 do
    begin
      lBand := Bands[liIndex];

      for liIndex2 := 0 to lBand.ObjectCount - 1 do
        begin
          lComponent := lBand.Objects[liIndex2];

          lComponent.GetDataPipelines(aDataPipelines);

        end;

    end;

end; {function, GetDataPipelines}

{------------------------------------------------------------------------------}
{ TppCustomReport.StartOfMainReport }

procedure TppCustomReport.StartOfMainReport;
var
  liIndex: Integer;
begin

  for liIndex := 0 to (BandCount - 1) do
    Bands[liIndex].StartOfMainReport;

  for liIndex := 0 to (GroupCount - 1) do
    Groups[liIndex].StartOfMainReport;

end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppCustomReport.EndOfMainReport }

procedure TppCustomReport.EndOfMainReport;
var
  liIndex: Integer;
  lPipelines: TList;
begin

  for liIndex := 0 to BandCount - 1 do
    Bands[liIndex].EndOfMainReport;

  for liIndex := 0 to GroupCount - 1 do
    Groups[liIndex].EndOfMainReport;

  lPipelines := TList.Create;

  for liIndex := 0 to lPipelines.Count - 1 do
    TppDataPipeline(lPipelines[liIndex]).EndOfMainReport(lPipelines);

  lPipelines.Free;

end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppCustomReport.FinishPage }

procedure TppCustomReport.FinishPage;
var
  liIndex: Integer;
begin

  for liIndex := 0 to BandCount - 1 do
    Bands[liIndex].FinishPage;

end; {procedure, FinishPage}

{------------------------------------------------------------------------------}
{ TppCustomReport.StartOfParentReport }

procedure TppCustomReport.StartOfParentReport;
var
  liIndex: Integer;
begin

  for liIndex := 0 to (BandCount - 1) do
    Bands[liIndex].StartOfParentReport;

  for liIndex := 0 to (GroupCount - 1) do
    Groups[liIndex].StartOfParentReport;

end; {procedure, StartOfParentReport}

{------------------------------------------------------------------------------}
{ TppCustomReport.NewNotify }

procedure TppCustomReport.NewNotify;
begin
  SendNotify(Self, ppopNew);
end; {destructor, NewNotify}

{------------------------------------------------------------------------------}
{ TppCustomReport.ClassDescription }

class function TppCustomReport.ClassDescription: String;
begin
  Result := ClassName;
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TppCustomReport.ClassBitmap }

class function TppCustomReport.ClassBitmap: THandle;
begin
  Result := ppBitmapFromResource('PPNOREPORTBITMAP');
end; {class function, ClassBitmap}

{------------------------------------------------------------------------------}
{ TppCustomReport.IsTemplate }

class function TppCustomReport.IsTemplate: Boolean;
begin
  Result := False;
end; {function, IsTemplate}


{@TppCustomReport.ChangeOwner
 Called when the owner of the report is changed.}

procedure TppCustomReport.ChangeOwner(aNewOwner: TComponent);
var
  liIndex:  Integer;

begin

  if (aNewOwner = Owner) then Exit;

  inherited ChangeOwner(aNewOwner);

  {assign new owner for groups}
  for liIndex := 0 to FGroups.Count-1 do
    Groups[liIndex].ChangeOwner(aNewOwner);

  {assign new owner for bands}
  for liIndex := 0 to (FBands.Count-1) do
    Bands[liIndex].ChangeOwner(aNewOwner);

  {assign new root for the template}
  FTemplate.Root := aNewOwner;


  if (FModules <> nil) then
    for liIndex := 0 to FModules.Count-1 do
      TppCommunicator(FModules[liIndex]).ChangeOwner(aNewOwner);

end; {procedure, ChangeOwner }

{@TppCustomReport.Transfer

 Moves the contents of aReport to the current report. The report specified in
 aReport is usually rendered useless by this procedure, as it contains no bands
 or objects.}

procedure TppCustomReport.Transfer(aSource: TppCommunicator);
var
  liBand,
  liGroup,
  liObject,
  liIndex: Integer;
  lBand: TppBand;
  lGroup: TppGroup;
  lComponent: TppComponent;
  lReportDesigner:  TForm;
  lGroupList: TList;
  lSourceReport: TppCustomReport;
  lModule: TppCommunicator;

begin

  inherited Transfer(aSource);

  if not(aSource is TppCustomReport) then Exit;


  lSourceReport := TppCustomReport(aSource);


  lGroupList := TList.Create;

  {detach report from designer }
  lReportDesigner := ReportDesigner;

  SetReportDesigner(nil);

  try
    {assign properties}
    FColumns          := lSourceReport.Columns;

    FmmColumnPositions.Assign(lSourceReport.FmmColumnPositions);
    FColumnWidth      := lSourceReport.mmColumnWidth;

    {use set prop routine here, need to fire notify logic}
    SetDataPipeline(lSourceReport.DataPipeline);

    FAutoStop := lSourceReport.AutoStop;
    FModified := lSourceReport.Modified;
    FNoDataBehaviors := lSourceReport.NoDataBehaviors;
    FPageLimit := lSourceReport.PageLimit;
    FPassSetting := lSourceReport.PassSetting;
    FSaveAsTemplate := lSourceReport.SaveAsTemplate;
    FUnits := lSourceReport.Units;

    FTemplate.Assign(lSourceReport.Template);

    {assign event handlers}
    FOnEndColumn := lSourceReport.OnEndColumn;
    FOnEndFirstPass := lSourceReport.OnEndFirstPass;
    FOnEndPage := lSourceReport.OnEndPage;
    FOnEndSecondPass := lSourceReport.OnEndSecondPass;
    FOnNoData := lSourceReport.OnNoData;
    FOnStartColumn := lSourceReport.OnStartColumn;
    FOnStartFirstPass := lSourceReport.OnStartFirstPass;
    FOnStartPage := lSourceReport.OnStartPage;
    FOnStartSecondPass := lSourceReport.OnStartSecondPass;

    {destroy current reports' bands and groups}
    FreeBandsAndGroups;

    FreeModules;

    {transfer non-group bands}
    for liBand := 0 to (lSourceReport.BandCount-1) do
      begin

        lBand := lSourceReport.Bands[lSourceReport.BandCount-1];

        if (lBand is TppGroupBand) then
          lSourceReport.RemoveBand(lBand)
        else
          (lBand as TppBasicBand).Report := Self;

        {change owner of band, this change the owner of the components}
        if (Owner <> lBand.Owner) then
          lBand.ChangeOwner(Owner);

        {set the report designer property for any subreports}
        for liObject := 0 to (lBand.ObjectCount-1) do
          begin

            lComponent := lBand.Objects[liObject];

            if (lComponent is TppSubReport) then
              TppSubReport(lComponent).Report.ParentReport   := Self;

          end;

        end;

        {transfer groups (groups will then transfer their associated bands)}
        for liGroup := 0 to (lSourceReport.GroupCount-1) do
          lGroupList.Add(lSourceReport.Groups[liGroup]);

        for liGroup := 0 to lGroupList.Count-1 do
          begin

            lGroup := lGroupList[liGroup];

            lGroup.Report := Self;

            if (Owner <> lGroup.Owner) then
              lGroup.ChangeOwner(Owner);

          end;


        if lSourceReport.FModules <> nil then
          for liIndex := lSourceReport.FModules.Count-1 downto 0 do
            begin
              lModule := lSourceReport.FModules[liIndex];
              if (Owner <> lModule.Owner) then
                lModule.ChangeOwner(Owner);
              lModule.SetParentComponent(Self);

            end;

      finally

        {re-attach designer}
        SetReportDesigner(lReportDesigner);

        Reset;

        lGroupList.Free;


      end; {try }

end; {procedure, Transfer}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetNoDataBehaviors }

procedure TppCustomReport.SetNoDataBehaviors(Value: TppNoDataBehaviors);
begin

  if (ndBlankPage in FNoDataBehaviors) and (ndBlankReport in Value) then
    Exclude(Value, ndBlankPage);

  if (ndBlankReport in FNoDataBehaviors) and (ndBlankPage in Value) then
    Exclude(Value, ndBlankReport);

  FNoDataBehaviors := Value;

  if not(ndBlankPage in FNoDataBehaviors) and not(ndBlankReport in FNoDataBehaviors) then
    Include(FNoDataBehaviors, ndBlankPage);

  if (ndBlankPage in FNoDataBehaviors) and (ndMessageOnPage in FNoDataBehaviors) then
    Exclude(FNoDataBehaviors, ndMessageOnPage);

  Reset;

end; {procedure, SetNoDataBehaviors}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetPageLimit }

procedure TppCustomReport.SetPageLimit(Value: Integer);
begin
  FPageLimit := Value;

  Reset;
end; {procedure, SetPageLimit}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetPassSetting }

procedure TppCustomReport.SetPassSetting(Value: TppPassSettingType);
begin
  FPassSetting := Value;
  
  {notify report designer}
  SetModified(True);

  Reset;
end; {procedure, SetPassSetting}

{@TppCustomReport.BeginUpdate

 When you need to make numerous changes to a report layout programatically, and
 the report is current visible in the Report Designer, call BeginUpdate to
 disable the logic which updates the Designer Window. When you have finished
 your changes, call EndUpdate and Designer will update itself.}

procedure TppCustomReport.BeginUpdate;
begin
  Inc(FUpdateCounter);

  if FUpdateCounter = 1 then
    begin
      DSInclude([pppcUpdating]);
      SendDesignMessage(RM_REPORTUPDATEBEGIN, ppWCustomMsg, Self);
    end;
end;

{@TppCustomReport.EndUpdate

 When you need to make numerous changes to a report layout programatically, and
 the report is current visible in the Report Designer, call BeginUpdate to
 disable the logic which updates the Designer Window. When you have finished
 your changes, call EndUpdate and Designer will update itself.}

procedure TppCustomReport.EndUpdate;
begin
  if (FUpdateCounter = 0) then Exit;

  Dec(FUpdateCounter);

  if (FUpdateCounter = 0) then
    begin
      DSExclude([pppcUpdating]);
      SendDesignMessage(RM_REPORTUPDATEEND, ppWCustomMsg, Self);
    end;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetCurrentColumn }

function TppCustomReport.GetCurrentColumn: Integer;
begin
  if (FEngine = nil) then
    Result := 0
  else
    Result := FEngine.CurrentColumn;
end; {function, GetCurrentColumn}

{------------------------------------------------------------------------------}
{ TppCustomReport.DSInclude }

procedure TppCustomReport.DSInclude(aDesignStateSet: TppDesignStates);
var
  liIndex: Integer;
begin

  inherited DSInclude(aDesignStateSet);

  {notify bands}
  for liIndex := 0 to FBands.Count-1 do
    Bands[liIndex].DSInclude(aDesignStateSet);

  {notify groups}
  for liIndex := 0 to FGroups.Count-1 do
    Groups[liIndex].DSInclude(aDesignStateSet);

  {notify engine}
  if FEngine <> nil then
    FEngine.DSInclude(aDesignStateSet);

  {notify report modules}
  if (FModules <> nil) then
    for liIndex := 0 to FModules.Count-1 do
      TppCommunicator(FModules[liIndex]).DSInclude(aDesignStateSet);


end; {procedure, DSInclude}

{------------------------------------------------------------------------------}
{ TppCustomReport.DSExclude }

procedure TppCustomReport.DSExclude(aDesignStateSet: TppDesignStates);
var
  liIndex: Integer;
begin

  inherited DSExclude(aDesignStateSet);

  {notify bands}
  for liIndex := 0 to FBands.Count-1 do
    Bands[liIndex].DSExclude(aDesignStateSet);

  {notify groups}
  for liIndex := 0 to FGroups.Count-1 do
    Groups[liIndex].DSExclude(aDesignStateSet);

  {notify engine}
  if FEngine <> nil then
    FEngine.DSExclude(aDesignStateSet);

  {notify report modules}
  if (FModules <> nil) then
    for liIndex := 0 to FModules.Count-1 do
      TppCommunicator(FModules[liIndex]).DSExclude(aDesignStateSet);


end; {procedure, DSExclude}

{@TppCustomReport.PrintingSection

 Indicates to the report is current generating a section type subreport.}

function TppCustomReport.PrintingSection: Boolean;
begin
  Result := (([esStartSection, esGenerateSection, esEndSection] * FEngine.State) <> []);
end; {function, PrintingSection}

{------------------------------------------------------------------------------}
{ TppCustomReport.LayoutChanged }

procedure TppCustomReport.LayoutChanged;
var
  liBand: Integer;

begin

  for liBand := 0 to FBands.Count-1 do
    Bands[liBand].Resize;

  {notify report designer}
  SendDesignMessage(RM_CalcWorkspaceWidth, ppWCustomMsg, nil);

  Modified := True;

  {notify report engine}
  Reset;



end; {procedure, LayoutChanged}


{------------------------------------------------------------------------------}
{ TppCustomReport.PrinterSetupChanged }

procedure TppCustomReport.PrinterSetupChanged;
var
  liBand: Integer;
  liObject: Integer;
  lBand: TppBand;
  lObject: TppComponent;

begin

  inherited PrinterSetupChanged;

  PrinterSetup.Units := FUnits;

  {update PrinterSetup for sub-reports with ParentPrinterSetup set to True}
  for liBand := 0 to (FBands.Count-1) do
    begin

      lBand := FBands[liBand];

      for liObject := 0 to (lBand.ObjectCount-1) do
        begin

          lObject := lBand.Objects[liObject];

          if (lObject is TppSubReport) and TppSubReport(lObject).ParentPrinterSetup then
            TppSubReport(lObject).Report.PrinterSetup := PrinterSetup;

        end;

    end;

  Modified := True;

end; {procedure, PrinterSetupChanged}

{------------------------------------------------------------------------------}
{ TppCustomReport.PrinterSetupChangeQueryEvent }

procedure TppCustomReport.PrinterSetupChangeQueryEvent(Sender: TObject; aNewPageDef: TObject; var CanChange: Boolean);
var
  lsWarningMsg: String;
begin

  inherited PrinterSetupChangeQueryEvent(Sender, aNewPageDef, CanChange);

  if (PrinterSetup.PageDef.mmPrintableWidth = TppPageDef(aNewPageDef).mmPrintableWidth) then Exit;

  lsWarningMsg := ppLoadStr(328);

  CanChange := ConfirmWidthChange(TppPageDef(aNewPageDef).mmPrintableWidth, lsWarningMsg);

end; {procedure, PrinterSetupChangeQueryEvent}

{------------------------------------------------------------------------------}
{ TppCustomReport.PageDefChanged }

procedure TppCustomReport.PageDefChanged;
begin

  inherited PageDefChanged;

  LayoutChanged;

end; {procedure, PageDefChanged}

{------------------------------------------------------------------------------}
{ TppCustomReport.LanguageChanged }

procedure TppCustomReport.LanguageChanged;
var
  liBands: Integer;
  liBand: Integer;

begin

  inherited LanguageChanged;

  liBands := BandCount;

  {notify bands}
  for liBand := 0 to liBands-1 do
    Bands[liBand].LanguageChanged;

  FTemplate.LanguageIndex := LanguageIndex;

  SendDesignMessage(RM_SETLANGUAGE,ppWCustomMsg, nil);

  {notify other objects}
  SendNotify(Self, ppopLanguageChange);

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppCustomReport.DataTraversalCompleted }

procedure TppCustomReport.DataTraversalCompleted;
begin
  FEngine.DataTraversalCompleted;
end; {procedure, DataTraversalCompleted}

{@TppCustomReport.Stop

Indicates to the report engine that printing is complete.

This method is useful when you want manually tell the report engine to stop
generating. In such a case, it is up to you to tell the report engine when and
where to stop.

Stop is needed by both the FirstPass and SecondPass of the report engine.
When called during the first pass, the current page is completed.  Then
the second pass begins, continuing until once again, Stop is called.

Note: Stop will allow the report to continue until all stretching components
and summary bands have completed printing - even if additional pages are required.
In order to stop a report dead in its tracks, use the PageLimitReached method.}


{------------------------------------------------------------------------------}
{ TppCustomReport.Stop }

procedure TppCustomReport.Stop;
begin
  DataTraversalCompleted;
end; {procedure, Stop}

{@TppCustomReport.PageLimitReached

 Indicates to the report engine that printing is complete.

 When PageLimitReached is called, the report completes the current page and
 stops, regardless of the state of any bands which may be printing. This differs
 from the DataTraversalCompleted method which allows all bands to complete
 before completing the report.}

procedure TppCustomReport.PageLimitReached;
begin
  FEngine.PageLimitReached;
end; {procedure, PageLimitReached}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetDonePrinting }

function TppCustomReport.GetDonePrinting: Boolean;
begin
  Result := FEngine.GenerateCompleted;
end; {function, GetDonePrinting}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetDonePrinting }

procedure TppCustomReport.SetDonePrinting(Value: Boolean);
begin
  if Value then
    DataTraversalCompleted;
end; {procedure, SetDonePrinting}

{------------------------------------------------------------------------------}
{ TppCustomReport.PageEnded }

procedure TppCustomReport.PageEnded(Sender: TObject);
begin
  {fire OnEndPage event - do this before we evaluate whether the report is done and
   before we send the page to the devices}
  DoOnEndPage;

  if not(ppValidDate) and (AbsolutePage >= 5) then
    FEngine.PageLimitReached

  else if ( (FPageLimit > 0) and (AbsolutePage >= FPageLimit) ) then
    FEngine.PageLimitReached;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.PageSent }

procedure TppCustomReport.PageSent(Sender: TObject);
begin

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetFirstLevelSubReports }

procedure TppCustomReport.GetFirstLevelSubReports(aReportList: TStrings);
var
  liBands: Integer;
  liBand: Integer;
  lBand: TppBand;
  liObjects: Integer;
  liObject: Integer;
  lObject: TppComponent;
begin

  liBands := BandCount;

  for liBand := 0 to liBands - 1 do
    begin
      lBand := Bands[liBand];

      liObjects := lBand.ObjectCount;

      for liObject := 0 to liObjects - 1 do
        begin
          lObject := lBand.Objects[liObject];

          if (lObject is TppSubReport) and (TppSubReport(lObject).Report <> nil) then
            aReportList.AddObject(lObject.Caption, TppSubReport(lObject).Report);

        end; {for, each component}

    end; {for, each band}

end; {procedure, GetFirstLevelSubReports}

{@TppCustomReport.GetSubReports

 Returns a list of handles to all of the TppChildReport objects within a report
 in the Objects property of the TStrings. The Caption of the TppSubReport
 component is saved in the main property of the TString.}

procedure TppCustomReport.GetSubReports(aReportList: TStrings);
var
  liBands: Integer;
  liBand: Integer;
  lBand: TppBand;
  liObjects: Integer;
  liObject: Integer;
  lObject: TppComponent;
begin

  liBands := BandCount;

  for liBand := 0 to liBands - 1 do
    begin

      lBand := Bands[liBand];

      liObjects := lBand.ObjectCount;

      for liObject := 0 to liObjects - 1 do
        begin

          lObject := lBand.Objects[liObject];

          if (lObject is TppSubReport) and (TppSubReport(lObject).Report <> nil) then
            begin
              aReportList.AddObject(lObject.Caption, TppSubReport(lObject).Report);

              TppSubReport(lObject).Report.GetSubReports(aReportList);
            end;

        end; {for, each component}

    end; {for, each band}

end; {procedure, GetSubReports}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetDataPipeline }

procedure TppCustomReport.SetDataPipeline(aDataPipeline: TppDataPipeline);
var
  lOldDataPipeline: TppDataPipeline;
  lNewDataPipeline: TppDataPipeline;
begin

  if (FDataPipeline = aDataPipeline) then Exit;

  lOldDataPipeline := FDataPipeline;
  lNewDataPipeline := aDataPipeline;

  if (lOldDataPipeline <> nil) and not(MainReport.Producing) then
    DumpCache;

  if FDataPipeline <> nil then
    FDataPipeline.RemoveEventNotify(Self);

  FDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.AddEventNotify(Self);

  if (Parent is TppSubReport) then
    TppSubreport(Parent).DataPipeline := FDataPipeline;

  Notify(FDataPipeline, ppopDataChange);

  {this causes the caption to change}
  if FReportDesigner <> nil then
    SendNotify(FDataPipeline, ppopDataChange);

  if (csReading in ComponentState) or (csLoading in ComponentState) or
     (pppcTemplateLoading in DesignState) then Exit;

  {do this AFTER FDataPipeline assigned}
  {any data-aware components with the same data pipeline need to be updated}
  UpdateParentDataPipeline(lNewDataPipeline, lOldDataPipeline);

  {set AutoStop to true, if datapipeline is nil}
  FAutoStop := (FDataPipeline = nil);

  Reset;

  {notify report designer, so it can change the tab caption}
  SendDesignMessage(RM_CAPTIONCHANGE, ppWCustomMsg, Self);

end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppCustomReport.AddCacheManager }

procedure TppCustomReport.AddCacheManager(aCacheManager: TppCacheManager);
begin

  FCacheManagers.Add(aCacheManager);

  aCacheManager.AddNotify(Self);

end; {procedure, AddCacheManager}

{------------------------------------------------------------------------------}
{ TppCustomReport.RemoveCacheManager }

procedure TppCustomReport.RemoveCacheManager(aCacheManager: TppCacheManager);
begin

  if (FCacheManagers = nil) then Exit;

  FCacheManagers.Remove(aCacheManager);

  aCacheManager.RemoveNotify(Self);

end; {procedure, RemoveCacheManager}

{------------------------------------------------------------------------------}
{ TppCustomReport.DumpCache }

procedure TppCustomReport.DumpCache;
var
  liIndex: Integer;
  lCacheManager: TppCacheManager;
begin

  if (FParentReport <> nil) then
    FParentReport.DumpCache;

  if (FCacheManagers = nil) then Exit;

  {dump cache for all cache managers}
  for liIndex := 0 to FCacheManagers.Count - 1 do
    begin
      lCacheManager := TppCacheManager(FCacheManagers[liIndex]);
      {make sure that DumpNotification is set to True}
      lCacheManager.DumpNotification := True;
      lCacheManager.DumpCache(0);
    end;

end; {procedure, DumpCache}

{------------------------------------------------------------------------------}
{ TppCustomReport.Notify }

procedure TppCustomReport.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (FDataPipeline = aCommunicator) then

    case aOperation of
      ppopRemove:
        begin
          {dump the cache, free any bookmarks}
          DumpCache;

          FDataPipeline := nil;
          FAutoStop := True;
          Reset;

          {notify report designer, so it can change the tab caption}
          SendDesignMessage(RM_CAPTIONCHANGE, ppWCustomMsg, Self);

        end;

      ppopDataChange:
        Reset;

      ppopUserNameChange:
        {notify report designer, so it can change the tab caption}
        SendDesignMessage(RM_CAPTIONCHANGE, ppWCustomMsg, Self);

    end

  else if aOperation = ppopRemove then

    if (FParentReport = aCommunicator) then
      FParentReport := nil

    else if (FTemplate <> nil) and (FTemplate.DatabaseSettings.DataPipeline = aCommunicator) then
      FTemplate.DatabaseSettings.DataPipeline := nil;


end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppCustomReport.EventNotify }

procedure TppCustomReport.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  {free any bookmarks saved using the cache manager}
  if (aEventID = ciPipelineBeforeClose) and (aCommunicator = FDataPipeline) and not(MainReport.Printing) then
    DumpCache;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetParentReport }

procedure TppCustomReport.SetParentReport(aReport: TppCustomReport);
begin

  if (FParentReport <> nil) then
    begin
      SendDesignMessage(RM_REMOVEREPORT, ppWCustomMsg, Self);
      FParentReport.RemoveNotify(Self);
    end;

  FParentReport := aReport;

  if (FParentReport <> nil) then
    begin
      SendDesignMessage(RM_ADDREPORT, ppWCustomMsg, Self);
      FParentReport.AddNotify(Self);
      SetReportDesigner(FParentReport.ReportDesigner);
    end;


end; {function, SetParentReport}

{@TppCustomReport.UpdateParentDataPipeline

 Called when the DataPipeline of the Report or DetailBand is changed.  Updates
 the datapipeline property of all objects which have ParentDataPipeline set to
 True.}

procedure TppCustomReport.UpdateParentDataPipeline(aNewDataPipeline, aOldDataPipeline: TppDataPipeline);
var
  liIndex: Integer;
  liObject: Integer;
  lBand: TppBand;
  lObject: TppComponent;
  lGroup: TppGroup;
begin

  {update datapipeline property of components}
  for liIndex := 0 to FBands.Count - 1 do
    begin
      lBand := TppBand(FBands[liIndex]);

      {skip to next band, detailband has datapipeline}
      if (lBand is TppDetailBand) and (TppDetailBand(lBand).DataPipeline <> nil) then Continue;

      for liObject := 0 to lBand.ObjectCount - 1 do
        begin
          lObject := lBand.Objects[liObject];

          if lObject.IsDataAware and lObject.ParentDataPipeline then
            begin
              if (lObject.DataPipeline <> nil) then
                begin
                  if (lObject.DataPipeline = aOldDataPipeline) then
                    lObject.DataPipeline := aNewDataPipeline;
                end

              else
                begin
                  if (aNewDataPipeline <> nil) and
                      ((lObject.DataField = '') or (aNewDataPipeline.FindField(lObject.DataField) <> -1)) then
                    lObject.DataPipeline := aNewDataPipeline;
                end;

            end; {if, object is databased}

        end; {for, each component}

    end; {for, each band}

  {update datapipeline property of groups}
  for liIndex := 0 to FGroups.Count - 1 do
    begin
      lGroup := TppGroup(FGroups[liIndex]);

      if lGroup.BreakType = btDataField then
        begin
          if (lGroup.DataPipeline <> nil) and (lGroup.DataPipeline = aOldDataPipeline) then
            lGroup.DataPipeline := aNewDataPipeline

          else if (aNewDataPipeline <> nil) and
                  ((lGroup.BreakName = '') or (aNewDataPipeline.FindField(lGroup.BreakName) <> -1)) then
            lGroup.DataPipeline := aNewDataPipeline;

        end; {if, group is databased}

    end; {for, each group}

end; {procedure, UpdateParentDataPipeline}

{------------------------------------------------------------------------------}
{ TppCustomReport.ResolvePipelineReferences }

procedure TppCustomReport.ResolvePipelineReferences;
var
  lPipelineList: TppDataPipelineList;
begin


  lPipelineList := TppDataPipelineList.Create(Self);

  try
    ResolvePipelineReferences(lPipelineList);

  finally
    lPipelineList.Free;
  end;

end;  {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppCustomReport.Loaded }

procedure TppCustomReport.Loaded;
begin

  ResolvePipelineReferences;

  {convert ColumnPositions to proper decimal separator}
  if (DecimalSeparator <> '.') then
    begin
      ppPeriodToDecimalSeparator(FmmColumnPositions);

      ppConvertMemoTabStops(Self);
    end;

  PrinterSetup.Loaded;

  {this calls convert, if necessary}
  inherited Loaded;

  {load the template for this report}
  if FSaveAsTemplate and not (pppcTemplateLoading in DesignState) then
    begin
      if MainReport <> Self then
        MainReport.DoOnLoadTemplate(Self);
        if (csDesigning in ComponentState) and (MainReport = Self) then
          {do nothing}
        else
          FTemplate.Load;
    end;


end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppCustomReport.Convert }

procedure TppCustomReport.Convert(aVersionNo: Integer);
var
  liIndex: Integer;
  lrColumnWidth: Single;
  llColumnWidth: Longint;
  liColumn: Integer;
begin

  inherited Convert(aVersionNo);

  {convert data, code modules}
  if (FModules <> nil) then
    for liIndex := 0 to FModules.Count-1 do
      TppReportModule(FModules[liIndex]).Convert(aVersionNo);

  {convert AutoStop property value}
  if (aVersionNo < 4100) then
    AutoStop := False;

  {convert column width}
  if (aVersionNo < 3000) then
    begin
      PrinterSetup.Units := FUnits;
      PrinterSetup.ConvertPrinterSetup;

      {convert column positions}
      for liColumn := 0 to FmmColumnPositions.Count - 1 do
        try
          if (FmmColumnPositions[liColumn] <> '') then
            FmmColumnPositions[liColumn] := IntToStr(ppToMMThousandths(StrToFloat(FmmColumnPositions[liColumn]),
                                                   FUnits, pprtHorizontal, nil));
        except on EConvertError do
          FmmColumnPositions[liColumn] := '';
        end;

      FColumnWidth := ppToMMThousandths(FOldColumnWidth, FUnits, pprtHorizontal, nil);

      {adjust column width if too wide}
      if (FmmColumnPositions.Count = 0) and (FColumns > 1) and
         ((FColumnWidth * FColumns) >  PrinterSetup.PageDef.mmPrintableWidth) then
        begin
          llColumnWidth := PrinterSetup.PageDef.mmPrintableWidth div FColumns;

          lrColumnWidth := ppFromMMThousandths(llColumnWidth, FUnits, pprtHorizontal, nil);

          SetColumnWidth(lrColumnWidth);
        end;

      FPassSetting := psTwoPass;
    end;

  {convert bands}
  for liIndex := 0 to BandCount - 1 do
    Bands[liIndex].Convert(VersionNo);

  {convert groups}
  for liIndex := 0 to GroupCount - 1 do
    Groups[liIndex].Convert(VersionNo);

  FModified := True;

  {indicate to form designer that this component has been modified}
  if (Owner is TForm) and (TForm(Owner).Designer <> nil) then
    TForm(Owner).Designer.Modified;

end; {procedure, Convert}


{------------------------------------------------------------------------------}
{ TppCustomReport.ConvertDataFieldNames }

procedure TppCustomReport.ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
var
  liIndex: Integer;
begin

  for liIndex := 0 to BandCount - 1 do
    Bands[liIndex].ConvertDataFieldNames(aDataPipeline, aOldFieldName, aNewFieldName);

  for liIndex := 0 to GroupCount - 1 do
    if (aDataPipeline = DataPipeline) then
      Groups[liIndex].ConvertBreakValueNames(aOldFieldName, aNewFieldName);

end; {procedure, ConvertDataFieldNames}

{------------------------------------------------------------------------------}
{ TppCustomReport.FixupPipelineReferences }

procedure TppCustomReport.FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
var
  liIndex: Integer;
begin

  if (FDataPipeline <> nil) and (FDataPipeline.UserName = aOldUserName) then
    SetDataPipeline(aDataPipeline);

  for liIndex := 0 to BandCount - 1 do
    Bands[liIndex].FixupPipelineReferences(aDataPipeline, aOldUserName);

  for liIndex := 0 to GroupCount - 1 do
      Groups[liIndex].FixupPipelineReferences(aDataPipeline, aOldUserName);

end; {procedure, FixupPipelineReferences}

{@TppCustomReport.RaiseException

 Called by any part of the report engine which has encountered an invalid
 condition.  This is the routine which raises a real Delphi exception.}

procedure TppCustomReport.RaiseException(aException: Exception);
begin
  inherited RaiseException(aException);

  if FEngine.Printing then
    FEngine.StopPrinting := True;

  {raise the exception for real}
  if not(FEngine.SilentExceptions) then
    raise EPrintError.Create(ppLoadStr(1023) + #13#10 + #13#10 + aException.Message); {'Cannot generate report.'}
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetCacheables }

procedure TppCustomReport.GetCacheables(aAddCacheableProc: TppAddCacheableProc);
var
  liIndex: Integer;
  liIndex2 : Integer;
  lCacheable: TppCacheable;
  lBand: TppBand;
  lSubReports: TList;
begin

  {add engine to cacheable list}
  lCacheable := Engine;

  if (lCacheable <> nil) then
    aAddCacheableProc(lCacheable);


  {add groups to cacheable list}
  for liIndex := 0 to GroupCount - 1 do
    begin
      lCacheable := Groups[liIndex];

      if (lCacheable <> nil) then
        aAddCacheableProc(lCacheable);
    end;

  {add bands and components to cacheable list, save any subreports}
  lSubReports := TList.Create;

  for liIndex := 0 to BandCount - 1 do
    begin
      lBand := Bands[liIndex];

      {add band to cacheable list}
      lCacheable := lBand;

      if (lCacheable <> nil) then
        aAddCacheableProc(lCacheable);


      {add components to cacheable list}
      for liIndex2 := 0 to lBand.ObjectCount - 1 do
        begin
          lCacheable := lBand.Objects[liIndex2];

          if (lCacheable <> nil) then
            aAddCacheableProc(lCacheable);

          if (lCacheable is TppSubReport) then
            lSubReports.Add(lCacheable);

        end; {for, each object}

    end; {for, each band}

  {add subreport layout to cacheable list}
  for liIndex := 0 to lSubReports.Count - 1 do
    TppSubReport(lSubReports[liIndex]).Report.GetCacheables(aAddCacheableProc);

  lSubReports.Free;

end; {procedure, GetCacheables}

{@TppCustomReport.FreeBandsAndGroups

 When the report is destroyed, this method is called to free the bands and
 groups of the report.}

procedure TppCustomReport.FreeBandsAndGroups;
var
  liBand: Integer;
  lBand: TObject;
  liGroup: Integer;
  lGroup: TObject;
begin

  {destroy non-group bands}
  for liBand := BandCount-1 downto 0 do
    begin
      lBand := Bands[liBand];

     if (lBand is TppGroupBand) then
        RemoveBand((lBand as TppBand))
      else
        lBand.Free;

    end;

  FBands.Clear;

  {destroy groups (groups will then destroy their associated bands)}
  for liGroup := GroupCount-1 downto 0 do
    begin
      lGroup := Groups[liGroup];
      lGroup.Free;
    end;

  FGroups.Clear;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.FreeModules }

procedure TppCustomReport.FreeModules;
var
  liModule: Integer;
  liModuleCount: Integer;
begin

  if (FModules = nil) then Exit;

  liModuleCount := FModules.Count;

  for liModule := liModuleCount-1 downto 0 do
    TObject(FModules[liModule]).Free;

  FModules.Free;
  FModules := nil;

end; {procedure, FreeModules}

{@TppCustomReport.CreateDefaultBands

 Create Header, Detail, Footer bands. When no bands currently exist, creates the
 bands specified in the DefaultBands property.}

procedure TppCustomReport.CreateDefaultBands;
var
  lBandType: TppBandType;
  lBandClass: TppBandClass;
  lBand: TppBand;

begin

  if FBands.Count > 0 then Exit;

  BeginUpdate;

  try
    if FColumns > 1 then
      FDefaultBands := FDefaultBands + [btColumnHeader, btColumnFooter]
    else
      FDefaultBands := FDefaultBands - [btColumnHeader, btColumnFooter];

    for lBandType := Low(TppBandType) to High(TppBandType) do
      if (lBandType in FDefaultBands) and (GetBand(lBandType, 0) = nil) then
        begin

          {get band class }
          case lBandType of
            btHeader       : lBandClass := TppHeaderBand;
            btTitle        : lBandClass := TppTitleBand;
            btColumnHeader : lBandClass := TppColumnHeaderBand;
            btDetail       : lBandClass := TppDetailBand;
            btColumnFooter : lBandClass := TppColumnFooterBand;
            btSummary      : lBandClass := TppSummaryBand;
            btFooter       : lBandClass := TppFooterBand;
            btPageStyle    : lBandClass := TppPageStyle;

          else
            lBandClass := nil

          end; {case}

          if lBandClass <> nil then
            begin
              lBand := TppBand(ppComponentCreate(Self, lBandClass));
              lBand.Report := Self;
            end;

        end;

  finally
    EndUpdate;
    Modified := True;
    
  end;

end; {procedure, CreateDefaultBands}

{@TppCustomReport.ObjectByName

 Given a componentname, returns the Index for band in which the component exists
 (use Bands[] property to get the band) and ComponentIndex within the band (use
 the Band.Objects[] property to get the component.)}

function TppCustomReport.ObjectByName(var aBandIndex: Integer; var aComponentIndex: Integer;
                                             const aComponentName: String): Boolean;
var
  liBand: Integer;
  lBand: TppBand;
  liComponent: Integer;
  lbComponentFound: Boolean;

begin
  lbComponentFound := False;
  liBand := 0;
  liComponent := 0;


  while not(lbComponentFound) and (liBand < BandCount) do
    begin
      lBand := Bands[liBand];

      if lBand.ObjectByName(liComponent, aComponentName) then
        lbComponentFound := True
      else
        Inc(liBand);

    end;

  if lbComponentFound then
    begin
      aBandIndex      := liBand;
      aComponentIndex := liComponent;
    end
  else
    begin
      aBandIndex      := 0;
      aComponentIndex := 0;
    end;

  Result := lbComponentFound;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetFirstPass }

function TppCustomReport.GetFirstPass: Boolean;
begin
  Result := (esFirstPass in FEngine.State);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetSecondPass }

function TppCustomReport.GetSecondPass: Boolean;
begin
  Result := (esSecondPass in FEngine.State);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.FireAfterPrint }

function TppCustomReport.FireAfterPrint: Boolean;
var
  lMainReport: TppCustomReport;
begin

  Result := False;

  lMainReport := GetMainReport;

  if (lMainReport.Publisher.OnlyScreenDevicesConnected) then Exit;

  {if (lMainReport.PreviewForm <> nil) and (lMainReport.PreviewForm.Visible) then Exit;}

  {if (pppcPreviewing in lMainReport.DesignState) then Exit;}

  Result := True;

end; {function, FireAfterPrint}


{------------------------------------------------------------------------------}
{ TppCustomReport.TriggerCodeModuleCreate }

procedure TppCustomReport.TriggerCodeModuleCreate;
var
  lSubReportList: TStringList;
  liIndex: Integer;
  lReport: TppCustomReport;
begin

  inherited TriggerCodeModuleCreate;

  lSubReportList := TStringList.Create;

  GetFirstLevelSubReports(lSubReportList);

  for liIndex := 0 to lSubReportList.Count - 1 do
    begin
      lReport := TppCustomReport(lSubReportList.Objects[liIndex]);

      lReport.TriggerCodeModuleCreate;
    end;

  lSubReportList.Free;

end; {procedure, TriggerCodeModuleCreate}

{------------------------------------------------------------------------------}
{ TppCustomReport.TriggerCodeModuleBeforePrint }

procedure TppCustomReport.TriggerCodeModuleBeforePrint;
var
  lSubReportList: TStringList;
  liIndex: Integer;
  lReport: TppCustomReport;
begin

  inherited;

  lSubReportList := TStringList.Create;

  GetFirstLevelSubReports(lSubReportList);

  for liIndex := 0 to lSubReportList.Count - 1 do
    begin
      lReport := TppCustomReport(lSubReportList.Objects[liIndex]);
      lReport.TriggerCodeModuleBeforePrint;
    end;

  lSubReportList.Free;

end; {procedure, TriggerCodeModuleBeforePrint}

{------------------------------------------------------------------------------}
{ TppCustomReport.TriggerCodeModuleDestroy }

procedure TppCustomReport.TriggerCodeModuleDestroy;
var
  lSubReportList: TStringList;
  lReport: TppCustomReport;
  liIndex: Integer;
begin

  lSubReportList := TStringList.Create;

  GetFirstLevelSubReports(lSubReportList);

  for liIndex := 0 to lSubReportList.Count - 1 do
    begin
      lReport := TppCustomReport(lSubReportList.Objects[liIndex]);

      lReport.TriggerCodeModuleAfterPrint;
      lReport.TriggerCodeModuleDestroy;
    end;

  lSubReportList.Free;

  
  TriggerCodeModuleAfterPrint;

  inherited TriggerCodeModuleDestroy;

end; {procedure, TriggerCodeModuleDestroy}

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnEndFirstPass }

procedure TppCustomReport.DoOnEndFirstPass;
begin
  if Assigned(FOnEndFirstPass) then FOnEndFirstPass(Self);

  SendEventNotify(Self, ciEngineEndFirstPass, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnEndSecondPass }

procedure TppCustomReport.DoOnEndSecondPass;
begin
  if Assigned(FOnEndSecondPass) then FOnEndSecondPass(Self);

  SendEventNotify(Self, ciEngineEndSecondPass, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnNoData }

procedure TppCustomReport.DoOnNoData(aDialog: TObject; var aShowDialog: Boolean; aDrawCommand: TObject; var aAddDrawCommand: Boolean);
var
  lDialog: TObject;
  lbShowDialog: Boolean;
  lDrawCommand: TObject;
  lbAddDrawCommand: Boolean;
  lParams: TraParamList;
begin
  if Assigned(FOnNoData) then FOnNoData(Self, aDialog, aShowDialog, aDrawCommand, aAddDrawCommand);

  lDialog := aDialog;
  lbShowDialog := aShowDialog;
  lDrawCommand := aDrawCommand;
  lbAddDrawCommand := aAddDrawCommand;

  lParams := TraTppCustomReportRTTI.GetParams('OnNoData');
  lParams.CreateValuePointer(0, lDialog);
  lParams.CreateValuePointer(1, lbShowDialog);
  lParams.CreateValuePointer(2, lDrawCommand);
  lParams.CreateValuePointer(3, lbAddDrawCommand);

  SendEventNotify(Self, ciEngineNoData, lParams);

  aShowDialog := lbShowDialog;
  aAddDrawCommand := lbAddDrawCommand;

  lParams.Free;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnBeforeGenerate }

procedure TppCustomReport.DoOnBeforeGenerate;
begin
  SendEventNotify(Self, ciEngineBeforeGenerate, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnStartFirstPass }

procedure TppCustomReport.DoOnStartFirstPass;
begin
  if Assigned(FOnStartFirstPass) then FOnStartFirstPass(Self);

  SendEventNotify(Self, ciEngineStartFirstPass, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnStartSecondPass }

procedure TppCustomReport.DoOnStartSecondPass;
begin
  if Assigned(FOnStartSecondPass) then FOnStartSecondPass(Self);

  SendEventNotify(Self, ciEngineStartSecondPass, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnStartColumn }

procedure TppCustomReport.DoOnStartColumn;
begin
  if Assigned(FOnStartColumn) then FOnStartColumn(Self);

  SendEventNotify(Self, ciEngineStartColumn, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnStartPage }

procedure TppCustomReport.DoOnStartPage;
begin
  if Assigned(FOnStartPage) then FOnStartPage(Self);

  SendEventNotify(Self, ciEngineStartPage, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnEndColumn }

procedure TppCustomReport.DoOnEndColumn;
begin
  if Assigned(FOnEndColumn) then FOnEndColumn(Self);

  SendEventNotify(Self, ciEngineEndColumn, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnEndPage }

procedure TppCustomReport.DoOnEndPage;
begin
  if Assigned(FOnEndPage) then FOnEndPage(Self);

  SendEventNotify(Self, ciEngineEndPage, nil);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetReportBandCount }

function TppCustomReport.GetReportBandCount: Integer;
begin
  Result := Engine.ReportBandCount;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetPageBandCount }

function TppCustomReport.GetPageBandCount: Integer;
begin
  Result := Engine.PageBandCount;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetPropUserName }

function TppCustomReport.GetPropUserName: TComponentName;
begin
  Result := 'Report'; {do not localize}
end; {function, GetPropUserName}


{------------------------------------------------------------------------------}
{ TppCustomReport.SetUnits }

procedure TppCustomReport.SetUnits(aUnits: TppUnitType);
var
  liGroup: Integer;
  liBand: Integer;
begin

  FUnits := aUnits;

  {notify printer setup object}
  PrinterSetup.Units := FUnits;

  {notify bands}
  for liGroup := 0 to FGroups.Count-1 do
    Groups[liGroup].Units := FUnits;

  {notify bands}
  for liBand := 0 to FBands.Count-1 do
    Bands[liBand].Units := FUnits;

  if not (csReading in ComponentState) and not (csLoading in ComponentState) then
    {notify report designer}
    SendDesignMessage(RM_UNITSCHANGE, ppWCustomMsg, TObject(FUnits));

  Modified := True;

end; {procedure, SetUnits}

{------------------------------------------------------------------------------}
{ TppCustomReport.ReadState }

procedure TppCustomReport.ReadState(Reader: TReader);
begin

  {this is necessary to conver reports prior to 5.6}
  FDataPipelineName := TppHReaderUtils.ExtractIdentPropValue(Reader, 'DataPipeline');

  inherited ReadState(Reader);

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppCustomReport.DefineProperties - read/write private 'fake' properties }

procedure TppCustomReport.DefineProperties(Filer: TFiler);
var
  lAncestor: TppCustomReport;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppCustomReport) then
    lAncestor := TppCustomReport(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('mmColumnWidth', ReadColumnWidth, WriteColumnWidth, FColumnWidth <> lAncestor.FColumnWidth);
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> lAncestor.FDataPipeline);
    end
  else
    begin
      Filer.DefineProperty('mmColumnWidth', ReadColumnWidth, WriteColumnWidth, True);
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> nil);

    end;

  {used for conversion to 5.1}
  Filer.DefineProperty('UserName', ReadUserName, nil, False);

  {used for conversion to 3.0}
  Filer.DefineProperty('RulerUnits', ReadRulerUnits, nil, False);

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppCustomReport.ReadDataPipelineName }

procedure TppCustomReport.ReadDataPipelineName(Reader: TReader);
begin
  FDataPipelineName := Reader.ReadString;

end; {procedure, ReadDataPipelineName}

{------------------------------------------------------------------------------}
{ TppCustomReport.WriteDataPipelineName }

procedure TppCustomReport.WriteDataPipelineName(Writer: TWriter);
begin
  if (FDataPipeline <> nil) then
    Writer.WriteString(FDataPipeline.Name)
  else
    Writer.WriteString('');

end; {procedure, WriteDataPipelineName}

{------------------------------------------------------------------------------}
{ TppCustomReport.DoOnLoadTemplate }

procedure TppCustomReport.DoOnLoadTemplate(aReport: TppCustomReport);
begin

end; {procedure, DoOnLoadTemplate}

{------------------------------------------------------------------------------}
{ TppCustomReport.ReadUserName }

procedure TppCustomReport.ReadUserName(Reader: TReader);
begin
  {conversion for 5.1 - Report.UserName is now read only and no longer published}
  Reader.ReadString;

end; {procedure, ReadUserName}

{------------------------------------------------------------------------------}
{ TppCustomReport.ReadColumnWidth }

procedure TppCustomReport.ReadColumnWidth(Reader: TReader);
begin
  FColumnWidth := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.WriteColumnWidth }

procedure TppCustomReport.WriteColumnWidth(Writer: TWriter);
begin
  Writer.WriteInteger(FColumnWidth);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.ReadRulerUnits }

procedure TppCustomReport.ReadRulerUnits(Reader: TReader);
var
  lsOldUnits: String;
begin
  lsOldUnits := Reader.ReadIdent;

  if lsOldUnits = 'utPixels' then
    FUnits := utScreenPixels

  else if lsOldUnits = 'utInches' then
    FUnits := utInches

  else if lsOldUnits = 'utMillimeters' then
    FUnits := utMillimeters


end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetTheBand }

function TppCustomReport.GetTheBand(Index: Integer): TppBand;
begin
  Result := FBands[Index];
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetGroupCount }

function TppCustomReport.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetTheGroup }

function TppCustomReport.GetTheGroup(Index: Integer): TppGroup;
begin
  Result := FGroups[Index];
end;


{@TppCustomReport.FindGroup
 Returns Index of given group.  Returns -1 if group cannot be found.}

function TppCustomReport.FindGroup(aGroup: TppGroup): Integer;
begin
  Result := FGroups.IndexOf(aGroup);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetBandCount }

function TppCustomReport.GetBandCount: Integer;
begin
  Result := FBands.Count;
end;


{@TppCustomReport.FindBand
 Returns Index of given band.  Returns -1 if band cannot be found.}

function TppCustomReport.FindBand(aBand: TppBand): Integer;
begin
  Result := FBands.IndexOf(aBand);
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetColumnPositions }

function TppCustomReport.GetColumnPositions: TStrings;
begin

  if (csWriting in ComponentState) or
     (csReading in ComponentState) or (csLoading in ComponentState) then

    Result := FmmColumnPositions

  else
    begin

      TStringList(FColumnPositions).OnChange := nil;
      FColumnPositions.Assign(FmmColumnPositions);

      ppStringsFromMMThousandths(FColumnPositions, Units, pprtHorizontal, Printer);

      TStringList(FColumnPositions).OnChange := ColumnPositionsChange;

      Result := FColumnPositions;

    end;


end; {procedure, GetColumnPositions}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetColumnPositions }

procedure TppCustomReport.SetColumnPositions(Value: TStrings);
begin

  FColumnPositions.Assign(Value);

end; {procedure, SetColumnPositions}

{------------------------------------------------------------------------------}
{ TppCustomReport.ColumnPositionsChange }

procedure TppCustomReport.ColumnPositionsChange(Sender: TObject);
begin

  FmmColumnPositions.Assign(FColumnPositions);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  ppStringsToMMThousandths(FmmColumnPositions, Units, pprtHorizontal, Printer);

  {notify report engine}
  Reset;

end; {procedure, ColumnPositionsChange}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetColumns }

procedure TppCustomReport.SetColumns(Value: Integer);
var
  liOldColumns: Integer;
  llOldColumnWidth: Longint;
  lsMessage: String;
  lbConfirmChange: Boolean;
  lColumnHeader: TppBand;
  lColumnFooter: TppBand;
begin

  liOldColumns     := FColumns;
  llOldColumnWidth := FColumnWidth;

  FColumns := Value;

  if (FColumns < 1) then
    FColumns := 1;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;


  lbConfirmChange := True;

  if (FColumns > 1) then
    begin

      {calc ColumnWidth as PageWidth/Columns}
      FColumnWidth := PrinterSetup.PageDef.mmPrintableWidth div FColumns;

      {confirm change to column based report - some ppComponents may be deleted }
      lsMessage := ppLoadStr(292);
      lbConfirmChange := ConfirmWidthChange(PrinterSetup.PageDef.mmPrintableWidth, lsMessage);

      {at run-time create columns here}
      if lbConfirmChange and not(pppcDesigning in DesignState) and (liOldColumns = 1) and (FBands.Count > 0) then
        begin
          {create column header}
          lColumnHeader        := TppColumnHeaderBand.Create(nil);
          lColumnHeader.Name   := GetValidName(lColumnHeader);
          lColumnHeader.Report := Self;

          {create column footer}
          lColumnFooter        := TppColumnFooterBand.Create(nil);
          lColumnFooter.Name   := GetValidName(lColumnFooter);
          lColumnFooter.Report := Self;
        end;

    end

  {notify report designer to CalcWorkspaceSize - if switching from column style report  }
  else if (FColumns = 1) and (ReportDesigner <> nil) then
    begin

      lColumnHeader := GetBand(btColumnHeader,0);
      lColumnFooter := GetBand(btColumnFooter,0);

      {set column width to page width }
      FColumnWidth :=  PrinterSetup.PageDef.mmPrintableWidth;

      {warn user that controls in column header/footer will be deleted}
      if (liOldColumns > 1) and (lColumnHeader <> nil) and (lColumnFooter <> nil) then
        begin
          if  (lColumnHeader.ObjectCount > 0) or (lColumnFooter.ObjectCount > 0) then
            begin
              if (lColumnHeader.ObjectCount > 0) and (lColumnFooter.ObjectCount > 0) then
                lsMessage := ppLoadStr(293)

              else if (lColumnHeader.ObjectCount > 0)  then
                lsMessage := ppLoadStr(294)

              else if  (lColumnFooter.ObjectCount > 0) then
                lsMessage := ppLoadStr(295);

              lbConfirmChange := (mrOK = (MessageDlg(lsMessage, mtWarning, mbOKCancel, 0)));
            end;

          if lbConfirmChange and not (pppcDesigning in DesignState) then
            begin
              lColumnHeader.Free;
              lColumnFooter.Free;
            end;

        end {if, old columns exist}
      else
        lbConfirmChange := True;

   end;

  if lbConfirmChange then

     {notify affected objects }
     LayoutChanged

  else
    begin
      FColumns     := liOldColumns;
      FColumnWidth := llOldColumnWidth;
    end;

end; {procedure, SetColumns}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetColumnWidth }

function TppCustomReport.GetColumnWidth: Single;
var
  lPrinter: TppPrinter;
begin

  if FUnits = utPrinterPixels then
    lPrinter := Printer
  else
    lPrinter := nil;

  Result := ppFromMMThousandths(FColumnWidth, FUnits, pprtHorizontal, lPrinter);

end; {procedure, GetColumnWidth}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetScreenPixelColumnWidth }

function TppCustomReport.GetScreenPixelColumnWidth: Integer;
var
  lPrinter: TppPrinter;
begin

  if FUnits = utPrinterPixels then
    lPrinter := Printer
  else
    lPrinter := nil;


  Result := Trunc(ppFromMMThousandths(FColumnWidth, utScreenPixels, pprtHorizontal, lPrinter));

end; {procedure, GetScreenPixelColumnWidth}


{------------------------------------------------------------------------------}
{ TppCustomReport.SetColumnWidth }

procedure TppCustomReport.SetColumnWidth(Value: Single);
var
  llOldColumnWidth: Longint;
  lsMessage: String;
  lbChangeConfirmed: Boolean;
begin

  {used for conversion to 3.0}
  if csReading in ComponentState then
    begin
      FOldColumnWidth := Value;
      Exit;
    end;

  llOldColumnWidth := FColumnWidth;

  FColumnWidth := ppToMMThousandths(Value, FUnits, pprtHorizontal, Printer);

  {note: Exit, if loading or reading - do not want to execute validation stuff }
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;



  {make sure column width is not wider than the page}
  if (FColumnWidth > PrinterSetup.PageDef.mmPrintableWidth) then
    FColumnWidth := PrinterSetup.PageDef.mmPrintableWidth;


  {if column width <= 0, then change to non-column type report}
  if (FColumnWidth <= 0) and (FColumns > 1) then
    begin
      FColumnWidth := 0;

      {set columns to 1}
      SetColumns(1);

      {determine whether columns were actually changed to 1}
      lbChangeConfirmed := (FColumns = 1);
    end
  else
    lbChangeConfirmed := True;


  {confirm change - some ppComponents may be deleted}
  if (FColumns > 1) and lbChangeConfirmed then
    begin

      lsMessage := ppLoadStr(292);

      lbChangeConfirmed := ConfirmWidthChange(PrinterSetup.PageDef.mmPrintableWidth, lsMessage);

      {make sure there is room for all columns}
      if lbChangeConfirmed and (FColumns > Trunc(PrinterSetup.PageDef.mmPrintableWidth / FColumnWidth)) then
        FColumns := Trunc(PrinterSetup.PageDef.mmPrintableWidth / FColumnWidth);

    end; {if, cols > 1}


  if lbChangeConfirmed then
     {notify affected objects }
     LayoutChanged
  else
    FColumnWidth := llOldColumnWidth;

end;


{@TppCustomReport.ConfirmWidthChange
 Called when column width property is changed.  If changing the column width
 would cause components to be deleted, a dialog box is displayed allowing the
 user to cancel the change.  If the user cancels the change, this routine
 returns False.  If the user confirms the change, or if the change would not
 cause components to be deleted, then this routine returns True.}

function TppCustomReport.ConfirmWidthChange(aWidth: Longint; aWarningMessage: String): Boolean;
var
  lbDelete: Boolean;
  lbChange: Boolean;
begin

  Result := True;

  if (FReportDesigner = nil) then Exit;

  {check for any controls that are beyond the column width}
  lbDelete := CheckComponentPositions('Check', aWidth);

  {warn user that controls will be deleted}
  if lbDelete then
    lbChange := (mrOK = MessageDlg(aWarningMessage, mtWarning, mbOKCancel, 0))
  else
    lbChange := True;

  if lbChange and lbDelete then
    CheckComponentPositions('Free', aWidth);

  Result := lbChange;

end; {procedure, ConfirmWidthChange}

{------------------------------------------------------------------------------}
{ TppCustomReport.CheckComponentPositions }

function TppCustomReport.CheckComponentPositions(const aAction: String; aWidth: Longint): Boolean;
var
  lbInvalidPositionFound: Boolean;
  liBand: Integer;
  liBands: Integer;
  liObject: Integer;
  lBand: TppBand;
  lComponent: TppComponent;
  llWidth: Longint;
  
begin
  lbInvalidPositionFound := False;

  liBand := 0;
  liBands := FBands.Count;

  while (liBand < liBands) and not(lbInvalidPositionFound) do
    begin
      lBand := TppBand(Bands[liBand]);

      if (lBand.IsColumnar) and (FColumns > 1) then
        llWidth := FColumnWidth
      else
        llWidth := aWidth;

      liObject  := lBand.ObjectCount-1;

      while (liObject >= 0) and not(lbInvalidPositionFound) do
        begin

          lComponent := lBand.Objects[liObject];

          if (lComponent.mmLeft > llWidth) and (not(atRight in lComponent.Anchors)) then

            if (aAction = 'Check') then
              lbInvalidPositionFound := True
              
            else if (aAction = 'Free') then
              lComponent.Free;

          Dec(liObject);

        end; {while, each object}

      Inc(liBand);

    end; {while, each band}

  Result := lbInvalidPositionFound;
  
end; {procedure, CheckComponentPositions}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetModified}

procedure TppCustomReport.SetModified(Value: Boolean);
begin
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (pppcUpdating in DesignState) then Exit;

  FModified := Value;
  
  {indicate to form designer that this component has been modified}
  if (FReportDesigner <> nil) and (FormDesigner <> nil) then
    FormDesigner.Modified;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.SetName }

procedure TppCustomReport.SetName(const Value: TComponentName);
var
  lppGroup     : TppGroup;
  lppBand      : TppBand;
  lppComponent : TppComponent;
  liBand,
  liGroup,
  liObject,
  liStartPos   : Integer;

  lsOldName : String;

begin

  {save value of old name}
  lsOldName := Name;

  inherited SetName(Value);

  {rename sub-components where needed}
  if (pppcDesigning in DesignState) then
    begin

      for liGroup := 0 to (GroupCount - 1) do
        begin

          lppGroup := TppGroup(Groups[liGroup]);

          {determine whether the first part of this sub-component's name is the
           old report writer name}
          liStartPos := Pos(lsOldName,lppGroup.Name);

          if liStartPos = 1 then
            begin
              {strip off old name and add new name}
              liStartPos := Length(lsOldName)+ 1;
              lppGroup.Name := Value + Copy(lppGroup.Name, liStartPos, Length(lppGroup.Name));
            end;

        end; {rename groups}


      for liBand := 0 to (BandCount - 1) do
        begin

          lppBand := TppBand(Bands[liBand]);

          {determine whether the first part of this sub-component's name is the
           old report writer name}
//          liStartPos := Pos(lsOldName,lppBand.Name);
//          if liStartPos = 1 then
//            begin
//              {strip off old name and add new name}
//              liStartPos := Length(lsOldName)+ 1;
//              lppBand.Name := Value + Copy(lppBand.Name,
//                                               liStartPos,
//                                               Length(lppBand.Name));
//            end;

          {rename this bands objects, if needed}
          for liObject := 0 to (lppBand.ObjectCount - 1) do
            begin

              lppComponent := TppComponent(lppBand.Objects[liObject]);

              {determine whether the first part of this sub-component's name is the
               old report writer name}
              liStartPos := Pos(lsOldName,lppComponent.Name);
              if liStartPos = 1 then
                begin
                  {strip off old name and add new name}
                  liStartPos := Length(lsOldName)+ 1;
                  lppComponent.Name := Value + Copy(lppComponent.Name,
                                               liStartPos,
                                               Length(lppComponent.Name));
                end;

            end; {rename ppComponents}

          end; {rename bands}

      end; {report writer in designing state}

  {remove undelete state}
  SendDesignMessage(RM_COMPONENTNAMECHANGE, ppWCustomMsg, Self);


end; {procedure, SetName}


{------------------------------------------------------------------------------}
{ TppCustomReport.SetReportDesigner }


procedure TppCustomReport.SetReportDesigner(aReportDesigner: TForm);
var
  liBands: Integer;
  liBand: Integer;
  lBand: TppBand;
  liObjects: Integer;
  liObject: Integer;
  lObject: TppComponent;
  lbDesignTimeAndSaveAsTemplate: Boolean;

begin

  if (FReportDesigner = aReportDesigner) then Exit;

  lbDesignTimeAndSaveAsTemplate :=  (csDesigning in ComponentState) and FSaveAsTemplate and
                                    not (pppcTemplateLoading in DesignState) and (MainReport = Self);

  {notify designer window to set remove its reference to this report}
  if (Self = MainReport) then
    SendDesignMessage(RM_REMOVEREPORT, ppWCustomMsg, Self);

 { if lbDesignTimeAndSaveAsTemplate and (aReportDesigner = nil) then
    FreeBandsAndGroups;}


  FReportDesigner := aReportDesigner;

  if lbDesignTimeAndSaveAsTemplate and (aReportDesigner <> nil) then
    FTemplate.Load;


  {note: keep this property updated}
  ComponentDesigner := TppComponentDesigner(aReportDesigner);


  {notify designer to add a reference to this report}
  if (Self = MainReport) then
    SendDesignMessage(RM_ADDREPORT, ppWCustomMsg, Self);


  {notify sub-reports }
  liBands := BandCount;

  for liBand := 0 to liBands - 1 do
    begin

      lBand := Bands[liBand];

      liObjects := lBand.ObjectCount;

      for liObject := 0 to liObjects - 1 do
        begin

          lObject := lBand.Objects[liObject];

          if (lObject is TppSubReport) then
               TppSubReport(lObject).Report.ReportDesigner := FReportDesigner;

        end; {for, each component}

    end; {for, each band}



end; {procedure, SetReportDesigner}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetTemplate }

procedure TppCustomReport.SetTemplate(aTemplate: TppReportTemplate);
begin
  FTemplate.Assign(aTemplate);
end;



{@TppCustomReport.AddBand
 Adds a band to the report. Do not call this method. Set the Report property of
 the band instead.}

procedure TppCustomReport.AddBand(aBand: TppBand);
begin
  FBands.Add(aBand);

  if (aBand.Owner <> Owner) and (Owner <> nil) then
    aBand.ChangeOwner(Owner);

  SetBandOrder;

  SendEventNotify(aBand, ciReportBandAdded, nil);  // add design control

 Reset;

end; {procedure, AddBand}



{@TppCustomReport.AddGroup
 Adds a group to the report. Do not call this method. Set the Report property of
 the group instead.}

procedure TppCustomReport.AddGroup(aGroup : TppGroup);
begin

  FGroups.Add(aGroup);


  if (aGroup.Owner <> Owner) and (Owner <> nil) then
    aGroup.ChangeOwner(Owner);

  Reset;

 end; {procedure, AddGroup}

{------------------------------------------------------------------------------}
{ TppCustomReport.AddModule }

procedure TppCustomReport.AddModule(aModule: TppCommunicator);
begin

  if FModules = nil then
    FModules := TList.Create;

  FModules.Add(aModule);

  aModule.AddNotify(Self);


end; {procedure, AddModule}




{@TppCustomReport.GetBand
 Returns a handle to the band indicated by the aBandType parameter.  If no band
 is found, nil is returned.  When retrieving group bands, use the aGroupIndex
 parameter to indicate the group.}

function TppCustomReport.GetBand(aBandType : TppBandType; aGroupIndex: Integer): TppBand;
var
  liBand:  Integer;
  lbFound: Boolean;
  lBand  : TppBand;

begin

  Result := nil;

  if (aBandType = btGroupHeader) or (aBandType = btGroupFooter) then
    {return group band}
    begin

      if (aGroupIndex >= 0) and (aGroupIndex < GroupCount)  then
        with TppGroup(Groups[aGroupIndex]) do
          if (aBandType = btGroupHeader) then
            Result := HeaderBand
          else
            Result := FooterBand;
    end

  else
    {get basic band}
    begin

      liBand  := 0;
      lbFound := False;

      while (not lbFound) and (liBand < BandCount) do
        begin

          lBand := TppBand(Bands[liBand]);

          if (lBand is TppBasicBand) then
            begin

              case aBandType of

                btHeader       : if (lBand is TppHeaderBand)       then lbFound := True;
                btTitle        : if (lBand is TppTitleBand)        then lbFound := True;
                btColumnHeader : if (lBand is TppColumnHeaderBand) then lbFound := True;
                btDetail       : if (lBand is TppDetailBand)       then lbFound := True;
                btColumnFooter : if (lBand is TppColumnFooterBand) then lbFound := True;
                btSummary      : if (lBand is TppSummaryBand)      then lbFound := True;
                btFooter       : if (lBand is TppFooterBand)       then lbFound := True;
                btPageStyle    : if (lBand is TppPageStyle)        then lbFound := True;


              end;
            end;

          if lbFound then
            Result := (lBand as TppBasicBand)
          else
            Inc(liBand);

        end;

  end; {get basic band}


end; {function, GetBand}

{------------------------------------------------------------------------------}
{ TppCustomReport.SetBandOrder }

procedure TppCustomReport.SetBandOrder;

var
  liBand: Integer;
  lBand: TppBand;
  lBandList : TStringList;
  liBands: Integer;

begin

  {any time BandOrder changes, template changes (i.e. add/remove band, group) }
  Reset;

  lBandList := TStringList.Create;

  liBands := FBands.Count;

  {load bands into string list}
  for liBand := 0 to (liBands - 1) do
    begin
      lBand := Bands[liBand];
      lBandList.AddObject(lBand.Rank, lBand);
    end;

  {sort bands}
  lBandList.Sort;

  {rebuild band list}
  FBands.Clear;

  for liBand := 0 to (liBands - 1) do
    FBands.Add(lBandList.Objects[liBand]);

  lBandList.Free;

end; {procedure, SetBandOrder}


{@TppCustomReport.RemoveBand
 Removes a band from the report.  Do not call this method directly. This
 procedure will be called when you free the group or set the group's Report
 property to nil.}

procedure TppCustomReport.RemoveBand(aBand: TppBand);
begin
  FBands.Remove(aBand);

  SetBandOrder;

  SendEventNotify(aBand, ciReportBandRemoved, nil);  // free design control

  Reset;

end; {procedure, RemoveBand}


{@TppCustomReport.MoveGroup
 Moves the group at aCurrentPos to aNewPos. If either position is invalid the
 routine does nothing.}

procedure TppCustomReport.MoveGroup(aCurrentPos, aNewPos: Integer);
begin
  FGroups.Move(aCurrentPos, aNewPos);

end; {procedure, MoveGroup}


{@TppCustomReport.RemoveGroup
 Removes a group from the report.  Do not call this method directly. This
 procedure will be called when you free the group or set the group's Report
 property to nil.}

procedure TppCustomReport.RemoveGroup(aGroup : TppGroup);
var
  liGroup : Integer;

begin

  FGroups.Remove(aGroup);

  for liGroup := 0 to GroupCount-1 do
    Groups[liGroup].PositionChanged;

  SetBandOrder;

  for liGroup := 0 to GroupCount-1 do
    Groups[liGroup].BandOrderChanged;

 
  Reset;
  
end; {procedure, RemoveGroup}

{------------------------------------------------------------------------------}
{ TppCustomReport.RemoveModule }

procedure TppCustomReport.RemoveModule(aModule: TppCommunicator);
begin

  if (FModules = nil) then Exit;

  {note: do not free FModules in this routine, event
         though it may now be empty}
  FModules.Remove(aModule);

  aModule.RemoveNotify(Self);

end; {procedure, RemoveModule}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetModuleForClass }

function TppCustomReport.GetModuleForClass(aModuleClass: TClass): TppCommunicator;
var
  liIndex: Integer;
  lCommunicator: TppCommunicator;
begin

  Result := nil;

  if (FModules = nil) then Exit;

  liIndex := 0;

  while (Result = nil) and (liIndex < FModules.Count) do
    begin
      lCommunicator := TppCommunicator(FModules[liIndex]);

      if (lCommunicator is aModuleClass) then
        Result := lCommunicator
      else
        Inc(liIndex);
    end;

end; {function, GetModuleForClass}

{------------------------------------------------------------------------------}
{ TppCustomReport.HasParentCodeModules }

function TppCustomReport.HasParentCodeModules: Boolean;
begin

  if (ParentReport <> nil) then
    begin
      Result := (ParentReport.CodeModule <> nil);

      if not(Result) then
        Result := ParentReport.HasParentCodeModules;
    end

  else
    Result := False;

end; {function, HasParentCodeModules}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetCodeModule }

function TppCustomReport.GetCodeModule: TComponent;
var
  liIndex: Integer;
  lComponent: TComponent;
begin

  Result := nil;

  if (FModules = nil) then Exit;

  liIndex := 0;

  while (Result = nil) and (liIndex < FModules.Count) do
    begin
      lComponent := TComponent(FModules[liIndex]);

      if (lComponent.ClassName = 'TraCodeModule') then
        Result := TComponent(FModules[liIndex])
      else
        Inc(liIndex);
    end;

end; {function, GetCodeModule}

{------------------------------------------------------------------------------}
{ TppCustomReport.GetAbsolutePageNo }

function TppCustomReport.GetAbsolutePageNo: Longint;
begin
   Result := Engine.AbsolutePageNo;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetAbsolutePageCount }

function TppCustomReport.GetAbsolutePageCount: Longint;
begin
   Result := Engine.AbsolutePageCount;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetPageNo }

function TppCustomReport.GetPageNo: Longint;
begin
   Result := Engine.PageNo;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetPageCount }

function TppCustomReport.GetPageCount: Longint;
begin
   Result := Engine.PageCount;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetPrintDateTime }

function TppCustomReport.GetPrintDateTime: TDateTime;
begin
   Result := Engine.PrintDateTime;
end;


{------------------------------------------------------------------------------}
{ TppCustomReport.SetGroupPosition }

procedure TppCustomReport.SetGroupPosition(aGroup: TppGroup; aPosition: Integer );
var
  liGroup,
  liCurrentPosition : Integer;

begin

  liCurrentPosition := FindGroup(aGroup);

  if (liCurrentPosition <> aPosition) and (liCurrentPosition >= 0) then
    begin

      MoveGroup(liCurrentPosition, aPosition);

      for liGroup := 0 to GroupCount-1 do
        Groups[liGroup].PositionChanged;


      SetBandOrder;

      for liGroup := 0 to GroupCount-1 do
        Groups[liGroup].BandOrderChanged;

    end; {move group to new position}

end; { procedure, SetGroupPosition }

{------------------------------------------------------------------------------}
{ TppCustomReport.TemplateChanged }

procedure TppCustomReport.TemplateChanged;
begin
  Reset;
end; {procedure, TemplateChanged}

{------------------------------------------------------------------------------}
{ TppCustomReport.Reset }

procedure TppCustomReport.Reset;
begin

  inherited Reset;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (Producing) then Exit;

  {notify report engine that template has changed (this will cause repagination) }
  if (FEngine <> nil) then
    FEngine.Reset;

end; {procedure, Reset}


{------------------------------------------------------------------------------}
{ TppCustomReport.GetChildren }

procedure TppCustomReport.GetChildren(Proc: TGetChildProc;Root: TComponent);
var
  liBand,
  liGroup,
  liIndex : Integer;
  lBand   : TppBand;
  lGroup  : TppGroup;
  lModule : TppReportModule;

begin

  {save non-group bands: Header, Title, Detail, Summary, Footer }
  for liBand := 0 to (BandCount - 1) do
    begin
      lBand := TppBand(Bands[liBand]);

      if not(lBand is TppGroupBand) then
        Proc(lBand);

    end; {for, each band}

  {save groups (groups then write their associated header & footer group bands) }
  for liGroup := 0 to GroupCount - 1 do
    begin
      lGroup := TppGroup(Groups[liGroup]);
      Proc(lGroup);
    end; {for, each group}

  {save code, data modules}
  if (FModules <> nil) then
    for liIndex := 0 to FModules.Count-1 do
      begin
        lModule := TppReportModule(FModules[liIndex]);
        {at run-time only save code, data modules if not empty,
          note: always save subreport code modules - they are needed when nested.}
        if (csDesigning in ComponentState) or not(Self is TppReport) or
           ((Self is TppReport) and not(lModule.IsEmpty)) then
          Proc(lModule);
      end;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetUniqueUserName }

function TppCustomReport.GetUniqueUserName(aComponent: TComponent): String;
var
  liNameNo: Integer;
  lNumberList: TStringList;
  liBands: Integer;
  liBand: Integer;
  lBand: TppBand;
  liObjects: Integer;
  liObject: Integer;
  lObject: TppComponent;
  lsNamingPrefix: String;
  lObjectList: TStrings;
  lSubReport: TppSubReport;

begin

  {the band username is assigned in its constructor}
  if aComponent is TppBand then
    begin
      Result := TppBand(aComponent).UserName;
      Exit;
    end;


  lNumberList := TStringList.Create;

  lsNamingPrefix := ppGetUserNamePrefix(aComponent);


   if (aComponent is TppSubReport) then
     begin
       lObjectList := TStringList.Create;
       GetSubReports(lObjectList);

       for liObject := 0 to lObjectList.Count-1 do
         begin
           lSubReport := TppSubReport(TppChildReport(lObjectList.Objects[liObject]).Parent);

           if ppExtractUserNamingNumber(lsNamingPrefix,  lSubReport, liNameNo) then
             lNumberList.Add(Format('%8d',[liNameNo]));
         end;

       lObjectList.Free;

     end
   else
     begin
  liBands := BandCount;

  {store currently used naming numbers to lNumberList}
  for liBand := 0 to liBands - 1 do
    begin

      lBand := Bands[liBand];

      liObjects := lBand.ObjectCount;

      for liObject := 0 to liObjects - 1 do
        begin

          lObject := lBand.Objects[liObject];

         {determine whether component is same class type}
         if (lObject is aComponent.ClassType) then
            if ppExtractUserNamingNumber(lsNamingPrefix,  lObject, liNameNo) then
              lNumberList.Add(Format('%8d',[liNameNo]));

        end; {for, each component}

    end; {for, each band}

  end;
  
  Result := lsNamingPrefix + IntToStr(ppGetUniqueNamingNumber(lNumberList));

  lNumberList.Free;

end; {function, GetUniqueUserName}


{------------------------------------------------------------------------------}
{@TppCustomReport.FindUserObject

  Searches the Report.Bands[].Objects[] composite for an object with the specifed
  UserName and returns the object.}

function TppCustomReport.FindUserObject(aUserName: String): TppCommunicator;
var
  lBand: TppBand;
  liBand: Integer;
  liBandCount: Integer;
  lObject: TppComponent;
  liObject: Integer;
  liObjectCount: Integer;
  lGroup: TppGroup;
  liGroup: Integer;
  liGroupCount: Integer;

begin

  Result := nil;

  liBand := 0;
  liBandCount := BandCount;

  if (CompareText(UserName, aUserName) = 0) then
    Result := Self;

  while (liBand < liBandCount) and (Result = nil) do
   begin
      lBand := Bands[liBand];

      if (CompareText(lBand.UserName, aUserName) = 0) then
        Result := lBand;

      liObject := 0;
      liObjectCount := lBand.ObjectCount;

      while (liObject < liObjectCount) and (Result = nil) do
        begin

          lObject := lBand.Objects[liObject];

          if (CompareText(lObject.UserName, aUserName) = 0) then
            Result := lObject;

          Inc(liObject);

        end; {for, check each component}

      Inc(liBand);

    end; {while, check each band}

  liGroup := 0;
  liGroupCount := GroupCount;

  while (liGroup < liGroupCount) and (Result = nil) do
   begin
      lGroup := Groups[liGroup];

      if (CompareText(lGroup.UserName, aUserName) = 0) then
        Result := lGroup;

     Inc(liGroup);

   end; {while, check each group}


  {band, component, group only have to be unique within the report}
  if (Result = nil) then
    begin

      Result := FindUserObjectInComponent(aUserName, Owner);

      if (Result <> nil) and ((Result is TppBand) or
                             (Result is TppComponent) or
                             (Result is TppGroup)) then
        Result := nil;
    end;


end; {function, FindUserObject}


{------------------------------------------------------------------------------}
{ TppCustomReport.GeneratingNewPage }

function TppCustomReport.GeneratingNewPage: Boolean;
begin
  Result := MainReport.Engine.GeneratingNewPage;
end;

{------------------------------------------------------------------------------}
{ TppCustomReport.GetOutlineChildren }

procedure TppCustomReport.GetOutlineChildren(aList: TList);
var
  liIndex: Integer;
  lBand: TppBand;
  lDetailBand: TppBand;
begin

  if (BandCount > 0) then
    begin

      liIndex := 0;
      lBand := Bands[0];
      lDetailBand := GetBand(btDetail, 0);

      while (lBand <> lDetailBand) do
        begin

          lBand.GetSubReports(aList);

          Inc(liIndex);

          lBand := Bands[liIndex];

        end;

      if (GroupCount > 0) then
        aList.Add(Groups[0])
      else
        lDetailBand.GetSubReports(aList);

      Inc(liIndex);

      while (liIndex < BandCount) do
        begin

          lBand := Bands[liIndex];

          lBand.GetSubReports(aList);

          Inc(liIndex);

        end;

    end;

end; { procedure, iOutlineGetChildren }

{------------------------------------------------------------------------------}
{ TppCustomReport.GetOutlineParent }

class function TppCustomReport.GetOutlineParent(aPossibleParent: TppCommunicator; aChild: TppCommunicator): TppCommunicator;
var
  liIndex: Integer;
  lChildList: TList;
  IIParticipant: IppOutlineParticipant;
begin

  aPossibleParent.GetInterface(IppOutlineParticipant, IIParticipant);
  lChildList := IIParticipant.iOutlineGetChildren;

  if (lChildList.IndexOf(aChild) > -1) then

    Result := aPossibleParent

  else
    begin

      liIndex := 0;
      Result := nil;

      while ((liIndex < lChildList.Count) and (Result = nil)) do
        begin

          Result := GetOutlineParent(TppCommunicator(lChildList[liIndex]), aChild);

          Inc(liIndex);

        end;

    end;

end; { class function, GetOutlineParent }

{------------------------------------------------------------------------------}
{ TppCustomReport.HasEmailGroups }

function TppCustomReport.HasEmailGroups: Boolean;
var
  liIndex: Integer;
begin

  Result := False;

  for liIndex := 0 to GroupCount - 1 do
    if TppGroup(Groups[liIndex]).GroupFileSettings.EmailFile then
      Result := True;

end;

{------------------------------------------------------------------------------}
{ TppCustomReport.ResolvePipelineReferences }

procedure TppCustomReport.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
begin

  {resolve DataPipeline.MasterDataPipeline references used for datapipeline linking}
  for liIndex := 0 to aPipelineList.Count-1 do
    aPipelineList.GetPipeline(liIndex).ResolvePipelineReferences(aPipelineList);

  {resolve report datapipeline reference}
  if (FDataPipeline = nil) then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FDataPipelineName);
      SetDataPipeline(lDataPipeline);
    end;

  {resolve band pipeline references}
  for liIndex := 0 to BandCount - 1 do
    Bands[liIndex].ResolvePipelineReferences(aPipelineList);

  {resolve group pipeline references}
  for liIndex := 0 to GroupCount - 1 do
    Groups[liIndex].ResolvePipelineReferences(aPipelineList);


end;  {procedure, ResolvePipelineReferences}


{******************************************************************************
 *
 ** B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBand.Create }

constructor TppBand.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAfterGenerate   := nil;
  FAfterPrint      := nil;
  FBeforeGenerate  := nil;
  FBeforePrint     := nil;
  FBottomOffset    := 0;
  FCaption         := '';
  FDrawPage        := False;
  FHeight          := 13229; {default height to 1/2 inch}
  FLastBand        := False;
  FObjects         := TList.Create;
  FReport          := nil;
  FSave            := False;
  FSaveList        := TList.Create;
  FUnits           := utInches;
  FVisible         := True;
  FVariables       := TList.Create;

  {print behavior related}
  FPrintHeight     := phStatic;
  FPrintPosition   := 0;
  FPrintCount      := 0;
  FPrintTimes      := GetDefaultPrintTimes;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBand.Destroy }

destructor TppBand.Destroy;
var
  lObject  : TObject;
  liObject : Integer;

begin

  {notify report designer}
  SendDesignMessage(RM_BANDDESTROY, ppWCustomMsg, Self);

//  SendEventNotify(Self, ciBandDestroy, nil);

  {free each report component associated with this band}
  for liObject := 0 to FObjects.Count - 1 do
    begin
      if (FObjects.Count > 0) then
        begin
          lObject := FObjects.Last;
          lObject.Free;
        end;
    end;

  {free report components list}
  FObjects.Free;

  FReport  := nil;

  FSaveList.Free;
  FVariables.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppBand.GetPrintMessage }

function TppBand.GetPrintMessage: String;
begin
  if (Report <> nil) then
    Result := Report.GetPrintMessage
  else
    Result := '';
end; {function, GetPrintMessage }

{------------------------------------------------------------------------------}
{ TppBand.SetPrintMessage }

procedure TppBand.SetPrintMessage(const aMessage: String);
begin
  if (Report <> nil) then
    Report.SetPrintMessage(aMessage);
end; {procedure, SetPrintMessage }

{------------------------------------------------------------------------------}
{ TppBand.Init }

procedure TppBand.Init;
var
  liIndex: Integer;
begin
  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].Init;
end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppBand.StartOfMainReport }

procedure TppBand.StartOfMainReport;
var
  liIndex: Integer;
begin
  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].StartOfMainReport;
end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppBand.StartOfParentReport }

procedure TppBand.StartOfParentReport;
var
  liIndex: Integer;
begin
  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].StartOfParentReport;
end; {procedure, StartOfParentReport}

{------------------------------------------------------------------------------}
{ TppBand.EndOfMainReport }

procedure TppBand.EndOfMainReport;
var
  liIndex: Integer;
begin
  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].EndOfMainReport;
end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppBand.FinishPage }

procedure TppBand.FinishPage;
begin

end; {procedure, FinishPage}

{------------------------------------------------------------------------------}
{ TppBand.Printing }

function TppBand.Printing: Boolean;
begin
  if (FReport <> nil) then
    Result := FReport.MainReport.Printing
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppBand.ChangeOwner }

procedure TppBand.ChangeOwner(aNewOwner: TComponent);
var
  liObject:  Integer;

begin

  if (aNewOwner = Owner) then Exit;

  inherited ChangeOwner(aNewOwner);

  {assign new owner for objects}
  for liObject := 0 to (FObjects.Count-1) do
    Objects[liObject].ChangeOwner(aNewOwner);

end; {procedure, ChangeOwner }

{------------------------------------------------------------------------------}
{ TppBand.Reset }

procedure TppBand.Reset;
begin
  if (FReport <> nil) then
    FReport.Reset;
end;  {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppBand.IsValidUserName }

function TppBand.IsValidUserName(aUserName: String): Boolean;
begin
  {username is assigned in the ancestor}
  Result := True;
end; {function, IsValidUserName}


{------------------------------------------------------------------------------}
{ TppBand.IsColumnar }

function TppBand.IsColumnar: Boolean;
begin
  Result := True;
end; {function, IsColumnar}

{------------------------------------------------------------------------------}
{ TppBand.IsDataAware }

function TppBand.IsDataAware: Boolean;
begin
  Result := False;
end; {function, IsDataAware}

{------------------------------------------------------------------------------}
{ TppBand.FromMMThousandths }

function TppBand.FromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType): Single;
var
  lPrinter: TppPrinter;
begin
  if (aUnits = utPrinterPixels) then
    lPrinter := GetPrinter
  else
    lPrinter := nil;

  Result := ppFromMMThousandths(Value, aUnits, aResolution, lPrinter);

end;

{------------------------------------------------------------------------------}
{ TppBand.ToMTMhousandths }

function TppBand.ToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType): Longint;
var
  lPrinter: TppPrinter;
begin
  if (aUnits = utPrinterPixels) then
    lPrinter := GetPrinter
  else
    lPrinter := nil;

  Result := ppToMMThousandths(Value, aUnits, aResolution, lPrinter);

end;


{------------------------------------------------------------------------------}
{ TppBand.Notify }

procedure TppBand.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppBand.PageStart }

procedure TppBand.PageStart;
var
  liObject: Integer;
  liObjects: Integer;
begin

  liObjects := ObjectCount;

  {notify objects }
  for liObject := 0 to liObjects - 1 do
    Objects[liObject].PageStart;

end; {procedure, PageStart}

{------------------------------------------------------------------------------}
{ TppBand.LanguageChanged }

procedure TppBand.LanguageChanged;
var
  liObject: Integer;
  liObjects: Integer;
begin

  Caption  := GetDescription;

  liObjects := ObjectCount;

  {notify objects }
  for liObject := 0 to liObjects - 1 do
    Objects[liObject].LanguageChanged;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppBand.GetLanguageIndex }

function TppBand.GetLanguageIndex: Longint;
begin
  if (FReport <> nil) then
    Result := FReport.LanguageIndex
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppBand.DSInclude }

procedure TppBand.DSInclude(aDesignStateSet: TppDesignStates);
var
  liObject: Integer;

begin

  inherited DSInclude(aDesignStateSet);

  {notify report components}
  for liObject := 0 to FObjects.Count-1 do
    Objects[liObject].DSInclude(aDesignStateSet);


end; {procedure, DSInclude}

{------------------------------------------------------------------------------}
{ TppBand.DSExclude }

procedure TppBand.DSExclude(aDesignStateSet: TppDesignStates);
var
  liObject: Integer;
begin

  {notify objects}
  for liObject := 0 to FObjects.Count-1 do
    Objects[liObject].DSExclude(aDesignStateSet);

  inherited DSExclude(aDesignStateSet);

end; {procedure, DSExclude}

{------------------------------------------------------------------------------}
{ TppBand.SetReport }

procedure TppBand.SetReport(aReport: TppCustomReport);
begin

  if (FReport <> nil) then
    FReport.RemoveBand(Self);

  FReport := aReport;

  if FReport <> nil then
    begin
      Caption := GetDescription;

      FUnits  := FReport.Units;

      FReport.AddBand(Self);

      Resize;

      if pppcDisplayData in FReport.DesignState then
        DSInclude([pppcDisplayData])
      else
        DSExclude([pppcDisplayData]);

    end;

end; {function, SetReport}

{------------------------------------------------------------------------------}
{ TppBand.GetIndex }

function TppBand.GetIndex: Integer;
begin
  if FReport <> nil then
    Result := FReport.FindBand(Self)
  else
    Result := -1;

end; {function, GetIndex}


{------------------------------------------------------------------------------}
{ TppBand.ObjectByName }

function TppBand.ObjectByName(var aComponentIndex: Integer; const aComponentName: String): Boolean;
var
  liObject: Integer;
  lbComponentFound: Boolean;
  
begin
  lbComponentFound := False;
  liObject := 0;

  while not(lbComponentFound) and (liObject < ObjectCount) do
    begin
      if (Objects[liObject].Name = aComponentName) then
        lbComponentFound := True
      else
        Inc(liObject);
    end;

  if lbComponentFound then
    aComponentIndex := liObject;

  Result := lbComponentFound;

end;

{------------------------------------------------------------------------------}
{ TppBand.HasParent - tells the form not to save this band to the .DFM
                       because this band is a sub-component of the Report object}

function TppBand.HasParent: Boolean;
begin
  Result := True;

end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppBand.GetADataPipeline }

function TppBand.GetADataPipeline: TppDataPipeline;
begin
  if (FReport <> nil) then
    Result := FReport.DataPipeline
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppBand.GetObject }
function  TppBand.GetObject(aIndex: Integer): TppComponent;
begin
  Result := FObjects[aIndex];

end; {function, GetObject}


{@TppBand.FindObject
 The FindObject method returns an Index indicating an object's position within
 the Objects array property.}

function  TppBand.FindObject(aComponent: TppComponent): Integer;
begin
  Result := FObjects.IndexOf(aComponent);
end; {function, FindObject}

{------------------------------------------------------------------------------}
{ TppBand.MoveObject }

procedure TppBand.MoveObject(aCurIndex, aNewIndex: Integer);
var
  lEventHub: TppDesignEventHub;
begin

  if (aNewIndex < 0) then
    aNewIndex := 0

  else if aNewIndex > FObjects.Count-1 then
    aNewIndex := FObjects.Count-1;

  FObjects.Move(aCurIndex, aNewIndex);

  // send ZOrder change event, this will notify the workspace view
  lEventHub := TppDesignEventHub(DesignEventHub);

  if (lEventHub <> nil) then
    lEventHub.ComponentEvents.mcZOrderChange.Notify(Objects[aNewIndex], nil);

end; {function, MoveObject}

{------------------------------------------------------------------------------}
{ TppBand.MoveSave }

procedure TppBand.MoveSave(aCurrentPosition, aNewPosition: Integer);
begin
  FSaveList.Move(aCurrentPosition, aNewPosition);

end; {function, MoveSave}

{------------------------------------------------------------------------------}
{ TppBand.GetObjectCount }

function  TppBand.GetObjectCount: Integer;
begin
  Result := FObjects.Count;
end; {function, GetObject}

{------------------------------------------------------------------------------}
{ TppBand.SetCaption }

procedure TppBand.SetCaption(aCaption: String);
begin

  FCaption := aCaption;

  if (pppcDesigning in DesignState) then
    SendEventNotify(Self, ciBandCaptionChanged, nil);

end; {procedure, SetCaption }

{------------------------------------------------------------------------------}
{ TppBand.GetDefaultPrintTimes }

function TppBand.GetDefaultPrintTimes: TppPrintTimesType;
begin
  Result := ptOne;
end;

{------------------------------------------------------------------------------}
{ TppBand.SetPrintCount }

procedure TppBand.SetPrintCount(Value: Integer);
begin

  FPrintCount := Value;

  if (FPrintCount = 0) then
    FPrintTimes := GetDefaultPrintTimes
  else
    FPrintTimes := ptCount;

  if (csReading in ComponentState) then Exit;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetPrintCount}

{------------------------------------------------------------------------------}
{ TppBand.SetVisible }

procedure TppBand.SetVisible(Value: Boolean);
begin
  FVisible := Value;

  if (csReading in ComponentState) then Exit;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetVisible}

{------------------------------------------------------------------------------}
{ TppBand.SetPrintHeight }

procedure TppBand.SetPrintHeight(aPrintHeight: TppPrintHeightType);
begin

  if FPrintHeight <> aPrintHeight then
    begin
      FPrintHeight := aPrintHeight;

      {notify report designer}
      PropertyChange;

      {notify report engine}
      Reset;
      
    end;

end;

{------------------------------------------------------------------------------}
{ TppBand.GetVariable }

function TppBand.GetVariable(aIndex: TTabOrder): TppComponent;
begin
  Result := TppComponent(FVariables[aIndex]);
end; {function, GetVariable}

{------------------------------------------------------------------------------}
{ TppBand.GetVariableCount }

function TppBand.GetVariableCount: Integer;
begin
  Result := FVariables.Count;
end; {function, GetVariableCount}

{------------------------------------------------------------------------------}
{ TppBand.FindVariable }

function TppBand.FindVariable(aComponent: TppComponent): Integer;
begin
  Result := IndexOfVariable(aComponent);
end; {function, FindVariable}

{------------------------------------------------------------------------------}
{ TppBand.IndexOfVariable }

function TppBand.IndexOfVariable(aComponent: TppComponent): TTabOrder;
begin
  Result := FVariables.IndexOf(aComponent);
end; {function, IndexOfVariable}

{------------------------------------------------------------------------------}
{ TppBand.AddVariable }

procedure TppBand.AddVariable(aComponent: TppComponent);
begin
  FVariables.Add(aComponent);
end; {function, AddVariable}

{------------------------------------------------------------------------------}
{ TppBand.InsertVariable }

procedure TppBand.InsertVariable(aPosition: TTabOrder; aComponent: TppComponent);
begin
  FVariables.Insert(aPosition, aComponent);
end; {function, InsertVariable}

{------------------------------------------------------------------------------}
{ TppBand.RemoveVariable }

procedure TppBand.RemoveVariable(aComponent: TppComponent);
var
  liIndex: Integer;
begin
  liIndex := FVariables.IndexOf(aComponent);

  if (liIndex >= 0) then
    FVariables.Delete(liIndex);
end; {function, RemoveVariable}

{------------------------------------------------------------------------------}
{ TppBand.FixCalcOrderList }

procedure TppBand.FixCalcOrderList;
var
  liVariables: Integer;
  liIndex: Integer;
  liCalcOrder: Integer;
  lList: TList;
  lVariable: TppVariable;
begin

  if (VariableCount = 0) then Exit;

  lList := TList.Create;

  try
    liVariables := VariableCount;

    lList.Count := liVariables;

    for liIndex := 0 to (liVariables - 1) do
      begin
        lVariable := TppVariable(Variables[liIndex]);

        liCalcOrder := lVariable.GetTheCalcOrder;

        if (liCalcOrder > -1) and (liCalcOrder < liVariables) then
          lList[liCalcOrder] := lVariable;
      end; {for, each variable}


      for liIndex := 0 to (liVariables - 1) do
        begin
          lVariable := TppVariable(lList[liIndex]);

          if (lVariable <> nil) then
            lVariable.UpdateCalcOrder(liIndex);
        end;

  finally
    lList.Free;
  end; {try, finally}

end; {procedure, FixCalcOrderList}

{------------------------------------------------------------------------------}
{ TppBand.SetSave }

procedure TppBand.SetSave(Value: Boolean);
begin
  FSave := Value;

  if (csReading in ComponentState) then Exit;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetSave}

{------------------------------------------------------------------------------}
{ TppBand.GetSave }

function TppBand.GetSave(aIndex: TTabOrder): TppComponent;
begin
  Result := TppComponent(FSaveList[aIndex]);
end; {function, GetSave}

{------------------------------------------------------------------------------}
{ TppBand.GetSaveCount }

function TppBand.GetSaveCount: Integer;
begin
  Result := FSaveList.Count;
end;

{------------------------------------------------------------------------------}
{ TppBand.FindSave }

function TppBand.FindSave(aComponent: TppComponent): Integer;
begin
  Result := IndexOfSave(aComponent);
end; {function, FindSave}

{------------------------------------------------------------------------------}
{ TppBand.IndexOfSave }

function TppBand.IndexOfSave(aComponent: TppComponent): TTabOrder;
begin
  Result := FSaveList.IndexOf(aComponent);
end;

{------------------------------------------------------------------------------}
{ TppBand.AddSave }

procedure TppBand.AddSave(aComponent: TppComponent);
begin
  FSaveList.Add(aComponent);
end;

{------------------------------------------------------------------------------}
{ TppBand.InsertSave }

procedure TppBand.InsertSave(aPosition: TTabOrder; aComponent: TppComponent);
begin
  FSaveList.Insert(aPosition, aComponent);
end;

{------------------------------------------------------------------------------}
{ TppBand.RemoveSave }

procedure TppBand.RemoveSave(aComponent: TppComponent);
var
  liIndex: Integer;
begin
  liIndex := FSaveList.IndexOf(aComponent);
  if (liIndex >= 0) then
    FSaveList.Delete(liIndex);
end;

{------------------------------------------------------------------------------}
{ TppBand.FixSaveOrderList }

procedure TppBand.FixSaveOrderList;
var
  liObjects: Integer;
  liObject: Integer;
  liSaveOrder: Integer;
  lList: TList;
  lObject: TObject;
  lComponent: TppComponent;
begin

  if (FObjects.Count > 0) then
  begin
    lList := TList.Create;
    try
      liObjects := FObjects.Count - 1;
      lList.Count := liObjects + 1;

      for liObject := 0 to liObjects do
        begin
          lComponent := nil;
          liSaveOrder := -1;

          lObject := FObjects[liObject];
          if (lObject is TppCustomText) then
            begin
              lComponent := TppCustomText(lObject);
              liSaveOrder := TppCustomText(lComponent).GetTheSaveOrder;
            end
          else if (lObject is TppCustomMemo) then
            begin
              lComponent := TppCustomMemo(lObject);
              liSaveOrder := TppCustomMemo(lComponent).GetTheSaveOrder;
            end;

          if (lComponent <> nil) and (liSaveOrder >= 0) and (liSaveOrder <= liObjects) then
            begin
              lList[liSaveOrder] := lComponent;
              FSaveList.Add(lComponent);
            end;
        end;

      for liObject := 0 to liObjects do
        begin
          lComponent := lList[liObject];
          if (lComponent <> nil) and (lComponent is TppCustomText) then
            TppCustomText(lComponent).UpdateSaveOrder(liObject)
          else if (lComponent <> nil) and (lComponent is TppCustomMemo) then
            TppCustomMemo(lComponent).UpdateSaveOrder(liObject);
        end;

    finally
      lList.Free;
    end; {try, finally}

  end; {if, objects exist}

end; {procedure, FixSaveOrderList}

{------------------------------------------------------------------------------}
{ TppBand.AddObject }

procedure TppBand.AddObject(aObject: TObject);
var
  lComponent: TppComponent;
begin

  if not(aObject is TppComponent) then Exit;

  lComponent := TppComponent(aObject);

  FObjects.Add(lComponent);

  lComponent.AddEventNotify(Self);

  if lComponent.Owner <> Owner then
    lComponent.ChangeOwner(Owner);

  if (lComponent is TppCustomText) and TppCustomText(lComponent).Save then
    AddSave(lComponent);

  if (lComponent is TppVariable) then
    AddVariable(lComponent);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  {if object needs to stretch, set PrintHeight to dynamic
    note: call SetPrintHeight to allow descendants to determine what to do}
  if (lComponent is TppStretchable) and
     TppStretchable(lComponent).Stretch and (FPrintHeight = phStatic) then
    SetPrintHeight(phDynamic);

  {validate object UserName}
  if (lComponent.UserName = '') then
    lComponent.UserName := GetUniqueUserName(lComponent);

  Reset;

  SendEventNotify(lComponent, ciReportComponentAdded, nil);

  {notify report designer}
  SendDesignMessage(RM_COMPONENTADDED, ppWCustomMsg, aObject);


end; {procedure, AddObject}

{------------------------------------------------------------------------------}
{ TppBand.RemoveObject }

procedure TppBand.RemoveObject(aObject: TObject);
var
  lComponent: TppComponent;
begin

  if not(aObject is TppComponent) then Exit;

  lComponent := TppComponent(aObject);

  lComponent.RemoveEventNotify(Self);

  {remove object from list}
  FObjects.Remove(lComponent);

  if (lComponent is TppCustomText) and TppCustomText(lComponent).Save then
    RemoveSave(lComponent);

  if (lComponent is TppVariable) then
    RemoveVariable(lComponent);

  Reset;

  SendEventNotify(lComponent, ciReportComponentRemoved, nil);

  SendDesignMessage(RM_COMPONENTREMOVED, ppWCustomMsg, aObject);

end; {procedure, RemoveObject}

{------------------------------------------------------------------------------}
{ TppBand.DoAfterGenerate }

procedure TppBand.DoAfterGenerate;
begin
  if Assigned(FAfterGenerate) then FAfterGenerate(Self);

  SendEventNotify(Self, ciBandAfterGenerate, nil);
end; {procedure, DoAfterGenerate}

{------------------------------------------------------------------------------}
{ TppBand.DoBeforeGenerate }

procedure TppBand.DoBeforeGenerate;
begin
  if Assigned(FBeforeGenerate) then FBeforeGenerate(Self);

  SendEventNotify(Self, ciBandBeforeGenerate, nil);
end; {procedure, DoBeforeGenerate}

{------------------------------------------------------------------------------}
{ TppBand.DoAfterPrint }

procedure TppBand.DoAfterPrint;
begin
  if Assigned(FAfterPrint) then FAfterPrint(Self);

  SendEventNotify(Self, ciBandAfterPrint, nil);
end; {procedure, DoAfterPrint}

{------------------------------------------------------------------------------}
{ TppBand.DoBeforePrint }

procedure TppBand.DoBeforePrint;
begin
  if Assigned(FBeforePrint) then FBeforePrint(Self);

  SendEventNotify(Self, ciBandBeforePrint, nil);
end; {procedure, DoBeforePrint}

{------------------------------------------------------------------------------}
{ TppBand.Loaded }

procedure TppBand.Loaded;
begin

  FPrevRect.Left := 0;
  FPrevRect.Top := 0;
  FPrevRect.Width := GetWidth;
  FPrevRect.Height := mmHeight;

  inherited Loaded;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppBand.ReadState }

procedure TppBand.ReadState(Reader: TReader);
begin

  inherited ReadState(Reader);

  {must call this after readstate}
  FixSaveOrderList;
  FixCalcOrderList;

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppBand.GetWidth }

function TppBand.GetWidth: Longint;
begin

  if (FReport <> nil) then
    begin

      if (FReport.Columns > 1) and IsColumnar then
        Result := FReport.mmColumnWidth
      else
        Result := FReport.PrinterSetup.PageDef.mmPrintableWidth;
    end
  else
    Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppBand.Resize }

procedure TppBand.Resize;
var
  liObject: Integer;

begin

  SendEventNotify(Self, ciBandResize, nil);

  for liObject := 0 to FObjects.Count-1 do
    Objects[liObject].ParentBoundsChange;

  {Update Previous Rectangle values}
  FPrevRect.Left := 0;
  FPrevRect.Top := 0;
  FPrevRect.Width := GetWidth;
  FPrevRect.Height := mmHeight;

end; {procedure, Resize}


{------------------------------------------------------------------------------}
{ TppBand.GetChildren - write report controls as subcomponents to .DFM }

procedure TppBand.GetChildren(Proc: TGetChildProc;Root: TComponent);
var
  liObject: Integer;
  lComponent: TppComponent;

begin

  for liObject := 0 to FObjects.Count - 1 do
    begin
      lComponent := FObjects.Items[liObject];
      if (lComponent.Parent = Self) then
        Proc(lComponent);
    end;

end;


{------------------------------------------------------------------------------}
{ TppBand.GetParentComponent - required method for Components with HasParent = True }

function TppBand.GetParentComponent: TComponent;
begin
  Result := FReport;

end;

{------------------------------------------------------------------------------}
{ TppBand.SetParentComponent - required method for Components with HasParent = True }

procedure TppBand.SetParentComponent(Value: TComponent);
begin

  if (Value is TppCustomReport) then
    SetReport((Value as TppCustomReport));

end;

{------------------------------------------------------------------------------}
{ TppBand.PropertyChange }

procedure TppBand.PropertyChange;
begin

  if (FReport = nil) then Exit;

  if (FReport.Printing) then Exit;

  if not(pppcDesigning in DesignState) then Exit;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppBand.Convert }

procedure TppBand.Convert(aVersionNo: Integer);
var
  liIndex: Integer;
  llMaxBottom: Longint;
  liObject: Longint;
  lObject: TppComponent;
  lTimer: TTimer;
begin

  if (FReport <> nil) and (FReport.Owner <> nil) and (aVersionNo < 1270) then
    @FBeforePrint := FReport.Owner.MethodAddress(FOnPrint);

  {convert from screen pixels to MMThousandths}
  if (FReport <> nil) and (aVersionNo < 2097) then
    FHeight := ppToMMThousandths(FHeight, utScreenPixels, pprtVertical, nil);

  {convert objects, do this before converting bottom offset}
  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].Convert(aVersionNo);

  {default bottom offset}
  if (FReport <> nil) and (aVersionNo < 3000) and (FPrintHeight = phDynamic) then
    begin

      llMaxBottom := 0;

      for liObject := 0 to FObjects.Count - 1 do
        begin
          lObject := Objects[liObject];

          if (lObject.mmTop + lObject.mmHeight) > llMaxBottom then
            llMaxBottom := lObject.mmTop + lObject.mmHeight;

        end;

      if (llMaxBottom <> 0) then
        FBottomOffset := mmHeight - llMaxBottom;

    end;

  {convert calcs to variables for Beta Build 6 or earlier}
  if (aVersionNo < 3999) then
    begin
      lTimer := TTimer.Create(Self);
      lTimer.OnTimer := ConvertCalcs;
      lTimer.Enabled := True;
    end;

end; {procedure, Convert}


{------------------------------------------------------------------------------}
{ TppBand.ConvertComponentFieldNames }

procedure TppBand.ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
var
  liIndex: Integer;
begin

  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].ConvertDataFieldNames(aDataPipeline, aOldFieldName, aNewFieldName);

end; {procedure, ConvertDataFieldNames}

{------------------------------------------------------------------------------}
{ TppBand.ResolvePipelineReferences}

procedure TppBand.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  liIndex: Integer;
begin

  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].ResolvePipelineReferences(aPipelineList);

end; {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppBand.FixupPipelineReferences }

procedure TppBand.FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
var
  liIndex: Integer;
begin

  for liIndex := 0 to ObjectCount - 1 do
    Objects[liIndex].FixupPipelineReferences(aDataPipeline, aOldUserName);

end; {procedure, FixupPipelineReferences}


{------------------------------------------------------------------------------}
{ TppBand.ConvertCalcs }

procedure TppBand.ConvertCalcs(Sender: TObject);
var
  lCalcs: TList;
  liIndex: Integer;
  lSystemVariable: TppSystemVariable;
  lVariable: TppVariable;
  lsName: String;
  lCalc: TppCalc;
begin

  TTimer(Sender).Enabled := False;
  
  TTimer(Sender).Free;

  lCalcs := TList.Create;

  for liIndex := 0 to ObjectCount - 1 do
    if (Objects[liIndex] is TppCalc) then
      lCalcs.Add(Objects[liIndex]);

  for liIndex := 0 to lCalcs.Count - 1 do
    begin
      lCalc := TppCalc(lCalcs[liIndex]);

      if (lCalc.CalcType = ctCustom) then
        begin
          lVariable := TppVariable(ppComponentCreate(lCalc.Band.Report, TppVariable));

          lVariable.Band := lCalc.Band;
          lVariable.DataType := lCalc.CustomType;

          lVariable.Top := lCalc.Top;
          lVariable.Left := lCalc.Left;
          lVariable.Width := lCalc.Width;
          lVariable.Height := lCalc.Height;

          lVariable.Alignment := lCalc.Alignment;
          lVariable.AutoSize := lCalc.AutoSize;
          lVariable.Color := lCalc.Color;
          lVariable.DisplayFormat := lCalc.DisplayFormat;
          lVariable.Font := lCalc.Font;
          lVariable.Transparent := lCalc.Transparent;
          lVariable.UserName := lCalc.UserName;
          lVariable.Visible := lCalc.Visible;
          lVariable.WordWrap := lCalc.WordWrap;

          lVariable.OldOnCalc := lCalc.OnCalc;
          lVariable.OnDrawCommandClick := lCalc.OnDrawCommandClick;
          lVariable.OnDrawCommandCreate := lCalc.OnDrawCommandCreate;
          lVariable.OnFormat := lCalc.OnFormat;
          lVariable.OnGetText := lCalc.OnGetText;
          lVariable.OnPrint := lCalc.OnPrint;

          lsName := lCalc.Name;
          lCalc.Free;
          lVariable.Name := lsName;
        end
      else
        begin
          lSystemVariable := TppSystemVariable(ppComponentCreate(lCalc.Band.Report, TppSystemVariable));

          lSystemVariable.Band := lCalc.Band;
          lSystemVariable.VarType := ppCalcTypeToVarType(lCalc.CalcType);

          lSystemVariable.Top := lCalc.Top;
          lSystemVariable.Left := lCalc.Left;
          lSystemVariable.Width := lCalc.Width;
          lSystemVariable.Height := lCalc.Height;

          lSystemVariable.Alignment := lCalc.Alignment;
          lSystemVariable.AutoSize := lCalc.AutoSize;
          lSystemVariable.Color := lCalc.Color;
          lSystemVariable.DisplayFormat := lCalc.DisplayFormat;
          lSystemVariable.Font := lCalc.Font;
          lSystemVariable.Transparent := lCalc.Transparent;
          lSystemVariable.UserName := lCalc.UserName;
          lSystemVariable.Visible := lCalc.Visible;
          lSystemVariable.WordWrap := lCalc.WordWrap;

          lSystemVariable.OnDrawCommandClick:= lCalc.OnDrawCommandClick;
          lSystemVariable.OnDrawCommandCreate:= lCalc.OnDrawCommandCreate;
          lSystemVariable.OnGetText := lCalc.OnGetText;
          lSystemVariable.OnPrint := lCalc.OnPrint;

          lsName := lCalc.Name;
          lCalc.Free;
          lSystemVariable.Name := lsName;
        end;

    end;

  lCalcs.Free;

end; {procedure, ConvertCalcs}

{------------------------------------------------------------------------------}
{ TppBand.SetUnits }

procedure TppBand.SetUnits(aUnits: TppUnitType);
var
  liObject: Integer;
begin
  FUnits := aUnits;

  for liObject := 0 to FObjects.Count - 1 do
    Objects[liObject].Units := FUnits;

end; {procedure, SetUnits}

{------------------------------------------------------------------------------}
{ TppBand.GetBottomOffset }

function TppBand.GetBottomOffset: Single;
var
  lPrinter: TppPrinter;
begin

  if (FUnits = utPrinterPixels) then
    lPrinter := GetPrinter
  else
    lPrinter := nil;

  Result := ppFromMMThousandths(FBottomOffset, FUnits, pprtVertical, lPrinter)

end; {procedure, GetBottomOffset}

{------------------------------------------------------------------------------}
{ TppBand.SetBottomOffset }

procedure TppBand.SetBottomOffset(Value: Single);
begin

  FBottomOffset := ToMMThousandths(Value, FUnits, pprtVertical);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetBottomOffset}


{------------------------------------------------------------------------------}
{ TppBand.GetPrinter }

function TppBand.GetPrinter: TppPrinter;
begin

  if FReport <> nil then
    Result := FReport.Printer
  else
    Result := ppPrinter;

end; {function, GetPrinter}

{------------------------------------------------------------------------------}
{ TppBand.GetPrevRect }

function TppBand.GetPrevRect: TppSizeRect;
begin
  Result := FPrevRect;
  
end; {function, GetPrevRect}

{------------------------------------------------------------------------------}
{ TppBand.SetPrevRect }

procedure TppBand.SetPrevRect(const Value: TppSizeRect);
begin
  FPrevRect := Value;

end; {procedure, SetPrevRect}

{------------------------------------------------------------------------------}
{ TppBand.GetPrintPosition }

function TppBand.GetPrintPosition: Single;
begin

  Result := FromMMThousandths(FPrintPosition, FUnits, pprtVertical);

end; {procedure, GetPrintPosition}

{------------------------------------------------------------------------------}
{ TppBand.SetPrintPosition }

procedure TppBand.SetPrintPosition(Value: Single);
begin

  FPrintPosition := ToMMThousandths(Value, FUnits, pprtVertical);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetPrintPosition}

{------------------------------------------------------------------------------}
{ TppBand.GetHeight }

function TppBand.GetHeight: Single;
begin

  Result := FromMMThousandths(FHeight, FUnits, pprtVertical);

end; {procedure, GetHeight}

{------------------------------------------------------------------------------}
{ TppBand.SetHeight }

procedure TppBand.SetHeight(Value: Single);
begin

  {used for converstion to 3.0}
  if (csReading in ComponentState) then
    FHeight := Trunc(Value)
  else
   SetMMHeight(ToMMThousandths(Value, FUnits, pprtVertical));

end;


{------------------------------------------------------------------------------}
{ TppBand.SetMMHeight }

procedure TppBand.SetMMHeight(Value: Longint);
var
  lParams: TraParamList;
  lbIsValid: Boolean;
  liOldHeight: Integer;

begin

  lbIsValid := True; // default
  
  lParams := TraParamList.Create;

  try
    lParams.AddParam('NewHeight', daInteger, nil, '', False, False);
    lParams.AddParam('IsValid', daBoolean, nil, '', False, True{IsVar});
    lParams.CreateValuePointer(0, Value);
    lParams.CreateValuePointer(1, lbIsValid);

    SendEventNotify(Self, ciBandBeforeHeightChange, lParams);

  finally
    lParams.Free;

  end;

  if lbIsValid then
    begin
      BeforePropertyChange('Height');

      {set the value}
      liOldHeight := FHeight;

      FHeight := Value;

      if FHeight < 0 then
        FHeight := 0;

      lParams := TraParamList.Create;

      try
        lParams.AddParam('OldHeight', daInteger, nil, '', False, False);
        lParams.CreateValuePointer(0, liOldHeight);

        SendEventNotify(Self, ciBandAfterHeightChange, lParams);

      finally
        lParams.Free;

      end;


    end;


  Resize;

  {notify report designer}
//  SendDesignMessage(RM_BANDHEIGHTCHANGE, ppWCustomMsg, LongInt(Self));

  {notify report engine}
  Reset;

  PropertyChange;

end; {procedure, SetMMHeight}

{------------------------------------------------------------------------------}
{ TppBand.SetScreenPixelTop }

procedure TppBand.SetScreenPixelTop(Value: Integer);
var
  lParams: TraParamList;
begin

  {Note: Top can only be set at Design-Time}
  if (pppcDesigning in DesignState) then
    begin

      lParams := TraParamList.Create;
      try


        lParams.AddParam('Value', daInteger, nil, '', False, False);
        lParams.CreateValuePointer(0, Value);

        SendEventNotify(Self, ciBandSetScreenPixelTop, lParams);

      finally
        lParams.Free;
      end;
    end;

end; {procedure, SetScreenPixelTop}

{------------------------------------------------------------------------------}
{ TppBand.GetScreenPixelWidth }

function TppBand.GetScreenPixelWidth: Integer;
begin

  {width is used only by the report designer, is not saved down, and
   is not stored internally}

  Result := Trunc(ppFromMMthousandths(GetWidth, utScreenPixels, pprtHorizontal, nil));

end; {procedure, GetScreenPixelWidth}

{------------------------------------------------------------------------------}
{ TppBand.GetScreenPixelTop }

function TppBand.GetScreenPixelTop: Integer;
var
  lParams: TraParamList;
  liTop: Integer;
begin

  liTop := 0;

  if (pppcDesigning in DesignState) then
    begin

      {top is used only by the report designer, is not saved down, and
       is stored internally in screen pixels}

      lParams := TraParamList.Create;

      try


        lParams.AddParam('Value', daInteger, nil, '', False, True{var});
        lParams.CreateValuePointer(0, liTop);

        SendEventNotify(Self, ciBandGetScreenPixelTop, lParams);

      finally
        lParams.Free;
      end;
      
    end;


  Result := liTop;

end; {procedure, GetScreenPixelTop}

{------------------------------------------------------------------------------}
{ TppBand.GetTop }

function TppBand.GetTop: Longint;
begin

 {top is used only by the report designer, is not saved down, and
   is stored internally in screen pixels}

 if (pppcDesigning in DesignState) then
   Result := ppToMMThousandths(GetScreenPixelTop, utScreenPixels, pprtVertical, nil)
 else
   Result := 0;


end;

{------------------------------------------------------------------------------}
{ TppBand.GetScreenPixelHeight }

function TppBand.GetScreenPixelHeight: Integer;
begin

  Result := Trunc(ppFromMMThousandths(FHeight, utScreenPixels, pprtVertical, nil));

end; {procedure, GetScreenPixelHeight}

{------------------------------------------------------------------------------}
{ TppBand.SetScreenPixelHeight }

procedure TppBand.SetScreenPixelHeight(Value: Integer);
begin

  SetMMHeight(Trunc(ppToMMThousandths(Value, utScreenPixels, pprtVertical, nil)));

end; {procedure, SetScreenPixelHeight}

{------------------------------------------------------------------------------}
{ TppBand.DefineProperties }

procedure TppBand.DefineProperties(Filer: TFiler);
var
  lAncestor: TppBand;


begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppBand) then
    lAncestor := TppBand(Filer.Ancestor)
  else
    lAncestor := nil;

  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('mmBottomOffset', ReadBottomOffset, WriteBottomOffset, FBottomOffset <> lAncestor.FBottomOffset);
      Filer.DefineProperty('mmHeight', ReadHeight, WriteHeight,  FHeight <> lAncestor.FHeight);
      Filer.DefineProperty('mmPrintPosition', ReadPrintPosition, WritePrintPosition,
                              FPrintPosition <> lAncestor.FPrintPosition);
    end
  else
    begin
      Filer.DefineProperty('mmBottomOffset', ReadBottomOffset, WriteBottomOffset, True);
      Filer.DefineProperty('mmHeight', ReadHeight, WriteHeight, True);
      Filer.DefineProperty('mmPrintPosition', ReadPrintPosition, WritePrintPosition, True);
    end;

  {used for conversion to 3.0}
  Filer.DefineProperty('OnPrint', ReadOnPrint, nil, False);
  Filer.DefineProperty('OnSaveLineEnd', ReadOnSaveLineEnd, nil, False);
  Filer.DefineProperty('OnSaveLineStart', ReadOnSaveLineStart, nil, False);
  Filer.DefineProperty('Left', ReadLeft, nil, False);
  Filer.DefineProperty('Top', ReadTop, nil, False);
end;

{------------------------------------------------------------------------------}
{ TppBand.ReadLeft }

procedure TppBand.ReadLeft(Reader: TReader);
begin
  {eat the value}
  ppReadIntegerPropValue(Reader);
end; {procedure, ReadLeft}

{------------------------------------------------------------------------------}
{ TppBand.ReadTop }

procedure TppBand.ReadTop(Reader: TReader);
begin
  {eat the value}
  ppReadIntegerPropValue(Reader);
end; {procedure, ReadTop}

{------------------------------------------------------------------------------}
{ TppBand.ReadBottomOffset }

procedure TppBand.ReadBottomOffset(Reader: TReader);
begin
  FBottomOffset := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppBand.ReadHeight }

procedure TppBand.ReadHeight(Reader: TReader);
begin
  FHeight := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppBand.ReadPrintPosition }

procedure TppBand.ReadPrintPosition(Reader: TReader);
begin
  FPrintPosition := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppBand.ReadOnPrint }

procedure TppBand.ReadOnPrint(Reader: TReader);
begin
  FOnPrint := Reader.ReadIdent;
end; {procedure, ReadOnPrint}

{------------------------------------------------------------------------------}
{ TppBand.ReadOnSaveLineEnd }

procedure TppBand.ReadOnSaveLineEnd(Reader: TReader);
begin
  {read the prop, but don't do anything with it}
  Reader.ReadIdent;
end; {procedure, ReadOnSaveLineEnd}

{------------------------------------------------------------------------------}
{ TppBand.ReadOnSaveLineStart }

procedure TppBand.ReadOnSaveLineStart(Reader: TReader);
begin
  {read the prop, but don't do anything with it}
  Reader.ReadIdent;
end; {procedure, ReadOnSaveLineStart}

{------------------------------------------------------------------------------}
{ TppBand.WriteBottomOffset }

procedure TppBand.WriteBottomOffset(Writer: TWriter);
begin
  Writer.WriteInteger(FBottomOffset);
end;

{------------------------------------------------------------------------------}
{ TppBand.WriteHeight}

procedure TppBand.WriteHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FHeight);
end;

{------------------------------------------------------------------------------}
{ TppBand.WritePrintPosition}

procedure TppBand.WritePrintPosition(Writer: TWriter);
begin
  Writer.WriteInteger(FPrintPosition);
end;

{------------------------------------------------------------------------------}
{ TppBand.GeneratingNewPage}

function TppBand.GeneratingNewPage: Boolean;
begin
  if (FReport <> nil) then
    Result := FReport.GeneratingNewPage

  else
    Result := True;
end;

function TppBand.GetBandType: TppBandType;
begin

  if ClassType = TppHeaderBand then
    Result := btHeader
  else if ClassType = TppTitleBand then
    Result := btTitle
  else if ClassType = TppDetailBand then
    Result := btDetail
  else if ClassType = TppSummaryBand then
    Result := btSummary
  else if ClassType = TppFooterBand then
    Result := btFooter
  else if ClassType = TppGroupHeaderBand then
    Result := btGroupHeader
  else if ClassType = TppGroupFooterBand then
    Result := btGroupFooter
  else if ClassType = TppColumnHeaderBand then
    Result := btColumnHeader
  else if ClassType = TppColumnFooterBand then
    Result := btColumnFooter
  else if ClassType = TppPageStyle then
    Result := btPageStyle
  else
    Result := btNotKnown;

end;


{------------------------------------------------------------------------------}
{ TppBand.GetSubReports }

procedure TppBand.GetSubReports(aList: TList);
var
  liIndex: Integer;
  lComponent: TppComponent;
begin

  for liIndex := 0 to ObjectCount - 1 do
    begin

      lComponent := Objects[liIndex];

      if (lComponent is TppSubReport) then
        aList.Add(lComponent)

    end;

end; { procedure, GetSubReports }


{******************************************************************************
 *
 ** G R O U P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGroup.Create }

constructor TppGroup.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppGroupSaveRec);

  FAfterGroupBreak := nil;
  FBeforeGroupBreak := nil;
  FBreakComponent := nil;
  FBreaking := False;
  FBreakNo := 0;
  FBreakName := '';
  FBreakValue := '';
  FBreakType := btDataField;
  FCacheManager := nil;
  FDataPipeline := nil;
  FDataPipelineName := '';
  FFirstColumn := 0;
  FFirstPageNo := 0;
  FFooterBand := nil;
  FHeaderBand := nil;
  FHeaderForOrphanedFooter := True;
  FKeepTogether := False;
  FKeptTogether := False;
  FLastPageNo := 0;
  FNewColumn := False;
  FNewPage := False;
  FNewColumnThreshold := 0;
  FNewPageThreshold := 0;
  FOnGetBreakValue := nil;
  FOnGetFileSuffix := nil;
  FPage := nil;
  FPosition := 0;
  FPriorValue := '';
  FReport := nil;
  FReprintOnSubsequentColumn := True;
  FReprintOnSubsequentPage := True;
  FResetPageNo := False;
  FResettingCache := False;
  FSetBreakComponent := False;
  FTag := 0;
  FOutlineChildren := nil;
  FOutlineSettings := TppOutlineSettings.Create(Self);
  FStartOnOddPage := False;
  FGroupFileSettings := TppGroupFileSettings.Create;
  FGroupFileSettings.Group := Self;

  EventNotifies := EventNotifies + [ciBandBeforeGenerate];

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppGroup.Destroy }

destructor TppGroup.Destroy;
begin

  {used for KeepTogether}
  FCacheManager.Free;
  FPage.Free;

  {tell data pipeline that we no longer exist}
  if (FDataPipeline <> nil) then
    FDataPipeline.RemoveEventNotify(Self);

  {remove component's reference to this Group}
  if (FBreakType = btCustomField) and (GetBreakComponent <> nil) then
    TppCustomText(GetBreakComponent).RemoveBreakFieldForGroup(Self);

  SetReport(nil);

  if Assigned(FHeaderBand) then
    FHeaderBand.Free;

  if Assigned(FFooterBand) then
    FFooterBand.Free;

  FOutlineSettings.Free;
  FGroupFileSettings.Free;

  if (FOutlineChildren <> nil) then FOutlineChildren.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppGroup.Printing }

function TppGroup.Printing: Boolean;
begin
  if (FReport <> nil) then
    Result := FReport.Printing
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppGroup.Reset }

procedure TppGroup.Reset;
begin
  if (FReport <> nil) then
    FReport.Reset;
end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppGroup.ReadState }

procedure TppGroup.ReadState(Reader: TReader);
begin

  {this is necessary to conver reports prior to 5.6}
  FDataPipelineName := TppHReaderUtils.ExtractIdentPropValue(Reader, 'DataPipeline');

  inherited ReadState(Reader);

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppGroup.Loaded }

procedure TppGroup.Loaded;
var
  lppCustomText: TppCustomText;

begin

  if (FBreakType = btCustomField) and (GetBreakComponent <> nil) then
    begin
      lppCustomText := TppCustomText(GetBreakComponent);
      lppCustomText.AddBreakFieldForGroup(Self);
    end;

  inherited Loaded;

end; {procedure, Loaded}


{------------------------------------------------------------------------------}
{ TppGroup.SetDataPipeline }

procedure TppGroup.SetDataPipeline(aDataPipeline: TppDataPipeline);
begin

  if FDataPipeline <> nil then
    FDataPipeline.RemoveEventNotify(Self);

  FDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.AddEventNotify(Self);
    
  {this causes the caption to change}
  Notify(FDataPipeline, ppopDataChange);

  Reset;

end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppGroup.Notify }

procedure TppGroup.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (FDataPipeline = aCommunicator) then
    begin
      FDataPipeline := nil;

      Reset;
    end

  else if (aOperation = ppopRemove) and (FCacheManager = aCommunicator) then
    FCacheManager := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppGroup.GetCurrentValue }

function TppGroup.GetCurrentValue: String;
var
  lsBreakValue: String;
  lParams: TraParamList;
begin

  {get the current break value}
  lsBreakValue := FBreakValue;

  if (FBreakType = btDataField)  and (FDataPipeline <> nil) then
    lsBreakValue := FDataPipeline.GetFieldAsString(BreakName)

  else if (FBreakType = btCustomField)  and (GetBreakComponent <> nil) then
    lsBreakValue := GetBreakComponent.Text;


  if Assigned(FOnGetBreakValue) then FOnGetBreakValue(Self, lsBreakValue);


  lParams := TraTppGroupRTTI.GetParams('OnGetBreakValue');
  lParams.CreateValuePointer(0, lsBreakValue);

  SendEventNotify(Self, ciGroupGetBreakValue, lParams);

  lParams.Free;


  Result := lsBreakValue;

end; {procedure, GetCurrentValue}

{------------------------------------------------------------------------------}
{ TppGroup.CheckForBreak }

procedure TppGroup.CheckForBreak;
begin

  FPriorValue := FBreakValue;

  FBreakValue := GetCurrentValue;

  if (FBreakValue <> FPriorValue) or ((DataPipeline <> nil) and (ppdaNoRecords in DataPipeline.State)) then
    ForceBreak;

end; {procedure, CheckForBreak}

{------------------------------------------------------------------------------}
{ TppGroup.ForceBreak }

procedure TppGroup.ForceBreak;
begin
  FBreaking := True;

  TppGroupBand(FHeaderBand).Generation := True;
  TppGroupBand(FFooterBand).Generation := True;

  {notify DBText/DBCalc that group is breaking}
  SendEventNotify(Self, ciGroupBreak, nil);

end; {procedure, ForceBreak}

{------------------------------------------------------------------------------}
{ TppGroup.DoAfterGroupBreak }

procedure TppGroup.DoAfterGroupBreak;
begin
  if Assigned(FAfterGroupBreak) then FAfterGroupBreak(Self);

  FDetailCount := 0;

  SendEventNotify(Self, ciGroupAfterGroupBreak, nil);
end; {procedure, DoAfterGroupBreak}

{------------------------------------------------------------------------------}
{ TppGroup.DoBeforeGroupBreak }

procedure TppGroup.DoBeforeGroupBreak;
begin
  if Assigned(FBeforeGroupBreak) then FBeforeGroupBreak(Self);

  SendEventNotify(Self, ciGroupBeforeGroupBreak, nil);
end; {procedure, DoBeforeGroupBreak}

{------------------------------------------------------------------------------}
{ TppGroup.SetHeaderForOrphanedFooter  }

procedure TppGroup.SetHeaderForOrphanedFooter(Value: Boolean);
begin

  FHeaderForOrphanedFooter := Value;

  Reset;

end; {procedure, SetHeaderForOrphanedFooter}

{------------------------------------------------------------------------------}
{ TppGroup.SetKeepTogether  }

procedure TppGroup.SetKeepTogether(Value: Boolean);
begin

  FKeepTogether := Value;

  if FKeepTogether and FNewPage then
    SetNewPage(False);

  if FKeepTogether and FNewColumn then
    SetNewColumn(False);

  Reset;

end; {procedure, SetKeepTogether}

{------------------------------------------------------------------------------}
{ TppGroup.SetNewColumn  }

procedure TppGroup.SetNewColumn(Value: Boolean);
begin

  FNewColumn := Value;

  if FNewColumn and FKeepTogether then
    SetKeepTogether(False);

  Reset;

end; {procedure, SetNewColumn}

{------------------------------------------------------------------------------}
{ TppGroup.SetNewPage  }

procedure TppGroup.SetNewPage(Value: Boolean);
begin

  FNewPage := Value;

  if FNewPage and FKeepTogether then
    SetKeepTogether(False);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  Reset;

end; {procedure, SetNewPage}

{------------------------------------------------------------------------------}
{ TppGroup.SetReprintOnSubsequentColumn  }

procedure TppGroup.SetReprintOnSubsequentColumn(Value: Boolean);
begin

  FReprintOnSubsequentColumn := Value;

  Reset;

end; {procedure, SetReprintOnSubsequentColumn}

{------------------------------------------------------------------------------}
{ TppGroup.SetReprintOnSubsequentPage  }

procedure TppGroup.SetReprintOnSubsequentPage(Value: Boolean);
begin

  FReprintOnSubsequentPage := Value;

  Reset;

end; {procedure, SetReprintOnSubsequentPage}

{------------------------------------------------------------------------------}
{ TppGroup.SetReport }

procedure TppGroup.SetReport(aReport: TppCustomReport);
var
  lDetailBand: TppBand;
begin

  {remove group from old report}
  if (FReport <> nil) then
    begin

      if FHeaderBand <> nil then
        FHeaderBand.Report := nil;

      if FFooterBand <> nil then
        FFooterBand.Report := nil;

      FReport.RemoveGroup(Self);

    end;

  FReport := aReport;

  {add group to report }
  if (FReport <> nil) then
    begin
      FReport.AddGroup(Self);

      if FHeaderBand <> nil then
        FHeaderBand.Report := FReport;

      if FFooterBand <> nil then
        FFooterBand.Report := FReport;

      FUnits := FReport.Units;

      lDetailBand := Report.GetBand(btDetail, 0);

      if (lDetailBand <> nil) then
        TppDetailBand(lDetailBand).AddEventNotify(Self);

      PositionChanged;
    end;

end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TppGroup.SetBreakType }

procedure TppGroup.SetBreakType(aBreakType: TppBreakType);
begin
  if (Report = nil) then Exit;

  if Report.Printing then Exit;

  if (FBreakType <> aBreakType) then
    begin
      FBreakType := aBreakType;

      FSetBreakComponent := True;
    end;

end; {procedure, SetBreakType}

{------------------------------------------------------------------------------}
{ TppGroup.SetBreakName }

procedure TppGroup.SetBreakName(const aBreakName: String);
var
  lComponent: TppComponent;
begin

  if (FBreakName = aBreakName) then Exit;


  if (csReading in ComponentState) or (csLoading in ComponentState) then
    FBreakName := aBreakName

        {handle reference to custom text component}
  else if (FBreakType = btCustomField) then
    begin
      lComponent := GetBreakComponent;
      
      if (lComponent <> nil) and (lComponent is TppCustomText) then
        TppCustomText(lComponent).RemoveBreakFieldForGroup(Self);

      FBreakName := aBreakName;

      lComponent := GetBreakComponent;

      if (lComponent <> nil) and (lComponent is TppCustomText) then
        TppCustomText(GetBreakComponent).AddBreakFieldForGroup(Self)
      else
        FBreakName := '';
    end
    
  else
    FBreakName := aBreakName;

  FSetBreakComponent := True;

  Reset;

  {notify header, footer bands that group attributes changed}
  if (FHeaderBand <> nil) then
    TppGroupHeaderBand(FHeaderBand).GroupChanged;

  if (FFooterBand <> nil) then
    TppGroupFooterBand(FFooterBand).GroupChanged;

end; {procedure, SetBreakName}

{------------------------------------------------------------------------------}
{ TppGroup.GetBreakComponent }

function TppGroup.GetBreakComponent: TppComponent;
begin

  if (FBreakType <> btCustomField) then
    FBreakComponent := nil

  else if FSetBreakComponent or (FBreakComponent = nil) then
    SetBreakComponent;

  Result := FBreakComponent;

end; {function, GetBreakComponent}

{------------------------------------------------------------------------------}
{ TppGroup.BreakComponentNameChanged }

procedure TppGroup.BreakComponentNameChanged(const aOldName, aNewName: String);
begin


  if (FBreakType = btCustomField) and (FBreakName = aOldName) then
    begin

      FBreakName := aNewName;

      {notify header, footer bands that group attributes changed}
      if (FHeaderBand <> nil) then
        TppGroupHeaderBand(FHeaderBand).GroupChanged;

      if (FFooterBand <> nil) then
        TppGroupFooterBand(FFooterBand).GroupChanged;

    end;

end; {procedure, BreakComponentNameChanged}

{------------------------------------------------------------------------------}
{ TppGroup.SetBreakComponent }

procedure TppGroup.SetBreakComponent;
var
  liBand: Integer;
  liComponent: Integer;
begin

  FBreakComponent := nil;

  if (csReading in ComponentState) then Exit;

  if (FReport = nil) then Exit;

  if (FBreakType <> btCustomField) then Exit;

  if FReport.ObjectByName(liBand, liComponent, FBreakName) then
    FBreakComponent := FReport.Bands[liBand].Objects[liComponent];

end; {procedure, SetBreakComponent}

{------------------------------------------------------------------------------}
{ TppGroup.GetDescription }

function TppGroup.GetDescription: String;
var
  lsBreakDescription: String;

begin

  Result := '';

  
  if FBreakType = btDataField then
    begin

     if (FDataPipeline <> nil) then
       lsBreakDescription := FDataPipeline.FieldAliasForFieldName(FBreakName)
     else
       lsBreakDescription := ''
    end
  else
    begin

      if GetBreakComponent = nil then
        lsBreakDescription := ''
      else
        lsBreakDescription := TppCustomText(GetBreakComponent).Description;
    end;

  if (FReport <> nil) then
    Result := ppLoadStr(331) + ' [' + IntToStr(GroupNo) + ']: ' + lsBreakDescription;
    

end; {function, GetDescription}


{@TppGroup.FirstPage
 Indicates whether this is the first page for the current group break.  When the
 detail bands for a single group break cannot fit on a single page, this
 function returns false for all subsequent pages on which the group prints.
 This function is often used to set the visibility of a 'Continued...' label in
 the group header band - which would indicate that the group is continuing onto
 additional pages.}

function  TppGroup.FirstPage: Boolean;
begin
  Result := (Report.AbsolutePageNo = FFirstPageNo);
end; {function, FirstPage}

{------------------------------------------------------------------------------}
{ TppGroup.GetPageNo }

function TppGroup.GetPageNo: Longint;
begin
  Result := (Report.AbsolutePageNo - FFirstPageNo) + 1;
end; {function, GetPageNo}

{------------------------------------------------------------------------------}
{ TppGroup.GetPageCount }

function  TppGroup.GetPageCount: Longint;
begin
  Result := (FLastPageNo - FFirstPageNo) + 1;
end; {function, GetPageCount}

{------------------------------------------------------------------------------}
{ TppGroup.UpdatePageCount }

procedure TppGroup.UpdatePageCount;
begin

  FLastPageNo := Report.Engine.AbsolutePageNo;

  UpdateCache;

end; {procedure, UpdatePageCount}

{------------------------------------------------------------------------------}
{ TppGroup.UpdateCache }

procedure TppGroup.UpdateCache;
var
  llAbsolutePage: Longint;
  lRec: TppGroupSaveRec;
begin

  if (CacheStream = nil) then Exit;

  {determine starting search page}
  if (CacheRecordSize > 0) and (CacheCount > 0) then
    llAbsolutePage := Round(Round(CacheStream.Size / CacheRecordSize) / CacheCount) - 1
  else
    llAbsolutePage := -1;

  {look at any prior breaks with same prior value, update page count}
  if (llAbsolutePage > -1) then
    begin

      repeat
        ReadRecordFromCache(llAbsolutePage, lRec);

        if (FBreakNo = lRec.FBreakNo) then
          begin
            lRec.FFirstPageNo := FFirstPageNo;
            lRec.FLastPageNo := FLastPageNo;

            WriteRecordToCache(llAbsolutePage, lRec);
          end;

        Dec(llAbsolutePage);

      until not(FBreakNo = lRec.FBreakNo) or (llAbsolutePage < 0);

    end; {if, their are any previous pages to search}

end; {procedure, UpdateCache}

{------------------------------------------------------------------------------}
{ TppGroup.RestoreFromCache }

procedure TppGroup.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppGroupSaveRec;
begin
  ReadRecordFromCache(aCachePageNo, lRec);

  FFirstPageNo       := lRec.FFirstPageNo;
  FLastPageNo        := lRec.FLastPageNo;
  FBreaking          := lRec.FBreaking;
  FBreakNo           := lRec.FBreakNo;
  FFirstColumn       := lRec.FFirstColumn;
  FKeptTogether      := lRec.FKeptTogether;

end; {procedure, RestoreFromCache }

{------------------------------------------------------------------------------}
{ TppGroup.SaveToCache }

procedure TppGroup.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppGroupSaveRec;
begin

  lRec.FFirstPageNo    := FFirstPageNo;
  lRec.FLastPageNo     := FLastPageNo;
  lRec.FBreaking       := FBreaking;
  lRec.FBreakNo        := FBreakNo;
  lRec.FFirstColumn    := FFirstColumn;
  lRec.FKeptTogether   := FKeptTogether;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppGroup.RefreshBreakValues }

procedure TppGroup.RefreshBreakValues;
begin
  FPriorValue        := GetCurrentValue;
  FBreakValue        := FPriorValue;
end; {procedure, RefreshBreakValues}

{------------------------------------------------------------------------------}
{ TppGroup.StartOfMainReport }

procedure TppGroup.StartOfMainReport;
begin

  if not(FKeepTogether) then Exit;

  if (FCacheManager = nil) then
    begin
      FCacheManager := TppCacheManager.Create(Report);

      FCacheManager.AddNotify(Self);
    end;

  if (FPage = nil) then
    FPage := TppPage.Create(Self);

 if FKeepTogether then
   ResetCache;

end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppGroup.StartOfParentReport }

procedure TppGroup.StartOfParentReport;
begin

end; {procedure, StartOfParentReport}

{------------------------------------------------------------------------------}
{ TppGroup.EndOfMainReport }

procedure TppGroup.EndOfMainReport;
begin

end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppGroup.EventNotify }

procedure TppGroup.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin
  if (aCommunicator is TppDetailBand) and (aEventID = ciBandBeforeGenerate) then
    FDetailCount := FDetailCount + 1;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppGroup.Init }

procedure TppGroup.Init;
begin
  FBreakNo := 0;

  FFirstPageNo := 1;
  FLastPageNo := 1;
  FFirstColumn := 1;

  FBreakValue := GetCurrentValue;
  FPriorValue := FBreakValue;

  FBreaking := False;

  {this tells DBText/DBCalc to reset, forcing their OnGroupBreak event to fire for first group}
  SendEventNotify(Self, ciGroupBreak, nil);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppGroup.ResetCache }

procedure TppGroup.ResetCache;
begin

  if (FResettingCache) or (FCacheManager = nil) then Exit;

  FResettingCache := True;

  try
    FCacheManager.ResetCache;
  finally
    FResettingCache := False;
  end;

  FKeptTogether := False;

end; {procedure, ResetCache}

{------------------------------------------------------------------------------}
{ TppGroup.FreeCache }

procedure TppGroup.FreeCache(aCachePageNo: Longint);
begin

  inherited FreeCache(aCachePageNo);

  FKeptTogether := False;

  {if (csDestroying in ComponentState) then Exit;

  if (FCacheManager <> nil) and (csDestroying in FCacheManager.ComponentState) then Exit;

  if not(FKeepTogether) then Exit;

  if (FResettingCache) then Exit;

  inherited FreeCache(aCachePageNo);

  ResetCache; }

end; {procedure, FreeCache}

{------------------------------------------------------------------------------}
{ TppGroup.DetailOutOfSpace }

procedure TppGroup.DetailOutOfSpace;
begin

  if (Report.Engine.ControlKeepTogether <> Self) then Exit;

  if FKeepTogether and not(FKeptTogether) then
    begin
      FCacheManager.ReadCache(0);
      FCacheManager.DumpNotification := False;

      Report.Engine.RestorePipelineState;

      FKeptTogether := True;

      Report.Engine.Page.Assign(FPage);
    end;

end; {procedure, DetailOutOfSpace}

{------------------------------------------------------------------------------}
{ TppGroup.BeforeHeader }

procedure TppGroup.BeforeHeader;
begin
  SendEventNotify(Self, ciGroupBeforeHeader, nil);
end; {procedure, BeforeHeader}

{------------------------------------------------------------------------------}
{ TppGroup.BeforeFooter }

procedure TppGroup.BeforeFooter;
begin
  SendEventNotify(Self, ciGroupBeforeFooter, nil);
end; {procedure, BeforeFooter}

{------------------------------------------------------------------------------}
{ TppGroup.GroupHeaderBeforeGenerate }

procedure TppGroup.GroupHeaderBeforeGenerate;
begin

  if (Report.Engine.ControlKeepTogether = Self) then
    begin

      if not(Report.Engine.PageStarted) then
        FKeptTogether := True;

      if FKeepTogether and not(FKeptTogether) then
        begin
          {must reset cache to clear any bookmarks saved by the engine, otherwise
           wrong bookmark could be cached.}
          ResetCache;

          FCacheManager.WriteCache(0);

          FCacheManager.DumpNotification := True;

          FPage.Assign(Report.Engine.Page);
        end;
    end;

end; {procedure, GroupHeaderBeforeGenerate}

{------------------------------------------------------------------------------}
{ TppGroup.GroupHeaderBeforePrint }

procedure TppGroup.GroupHeaderBeforePrint;
var
  lHeader: TppGroupHeaderBand;
begin

  lHeader := TppGroupHeaderBand(HeaderBand);

  if lHeader.Generation and not(lHeader.OverFlow) and not(lHeader.PartialGeneration) then
    DoBeforeGroupBreak;

end; {procedure, GroupHeaderBeforePrint}

{------------------------------------------------------------------------------}
{ TppGroup.GroupFooterAfterPrint }

procedure TppGroup.GroupFooterAfterPrint;
begin

  DoAfterGroupBreak;

  if (Report.Engine.ControlKeepTogether = Self) then
    FKeptTogether := False;

  Inc(FBreakNo);

end; {procedure, GroupFooterAfterPrint}

{------------------------------------------------------------------------------}
{ TppGroup.Clear }

procedure TppGroup.Clear;
begin

  FFirstPageNo := 1;
  FLastPageNo := 1;
  FFirstColumn := 1;

  FBreakValue := '';
  FPriorValue := '';

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppGroup.GetGroupNo }

function TppGroup.GetGroupNo: Integer;
begin

  if (Report <> nil) then
    Result := Report.FindGroup(Self)
  else
    Result := -1;

end; {function, GetGroupNo}

{------------------------------------------------------------------------------}
{ TppGroup.SetHeaderBand }

procedure TppGroup.SetHeaderBand(aGroupHeaderBand: TppBand);
begin

  if (FReport <> nil) and (FHeaderBand <> nil) then
    FHeaderBand.Report := nil;

  FHeaderBand := aGroupHeaderBand;

  if (FReport <> nil) and (FHeaderBand <> nil) then
    FHeaderBand.Report := FReport;

end; {procedure, SetHeaderBand}

{------------------------------------------------------------------------------}
{ TppGroup.SetFooterBand }

procedure TppGroup.SetFooterBand(aGroupFooterBand: TppBand);
begin

  if (FReport <> nil) and (FFooterBand <> nil) then
    FFooterBand.Report := nil;

  FFooterBand := aGroupFooterBand;

  if (FReport <> nil) and (FFooterBand <> nil) then
    FFooterBand.Report := FReport;

end; {procedure, SetFooterBand}

{------------------------------------------------------------------------------}
{ TppGroup.SetGroupFileSettings }

procedure TppGroup.SetGroupFileSettings(aGroupFileSettings: TppGroupFileSettings);
begin
  FGroupFileSettings.Assign(aGroupFileSettings);

end; {procedure, SetGroupFileSettings}

{------------------------------------------------------------------------------}
{ TppGroup.BandOrderChanged }

procedure TppGroup.BandOrderChanged;
begin

 if (FReport <> nil) and (FHeaderBand <> nil) then
    FReport.SendDesignMessage(RM_COMPONENTUPDATED, ppWCustomMsg, FHeaderBand);

  if (FReport <> nil) and (FFooterBand <> nil) then
    FReport.SendDesignMessage(RM_COMPONENTUPDATED, ppWCustomMsg, FFooterBand);

end; {procedure, BandOrderChanged}

{------------------------------------------------------------------------------}
{ TppGroup.PositionChanged }

procedure TppGroup.PositionChanged;
begin

  if (FHeaderBand <> nil) then
    TppGroupHeaderBand(FHeaderBand).GroupChanged;

  if (FFooterBand <> nil) then
    TppGroupFooterBand(FFooterBand).GroupChanged;

end; {procedure, PositionChanged}

{------------------------------------------------------------------------------}
{ TppGroup.GetIndex }

function TppGroup.GetIndex: Integer;
begin
  if FReport <> nil then
    Result := FReport.FindGroup(Self)
  else
    Result := -1;

end; {function, GetIndex}




{------------------------------------------------------------------------------}
{ TppGroup.HasParent - tells the form not to save this band to the .DFM
                       because this band is a sub-component of the Report object}

function TppGroup.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}


{------------------------------------------------------------------------------}
{ TppGroup.GetChildren }

procedure TppGroup.GetChildren(Proc: TGetChildProc;Root: TComponent);
begin

  if (FHeaderBand <> nil) then
    Proc(FHeaderBand);

  if (FFooterBand <> nil) then
    Proc(FFooterBand);

end;


{------------------------------------------------------------------------------}
{ TppGroup.GetParentComponent - required method for Components with HasParent = True }

function TppGroup.GetParentComponent: TComponent;
begin
  Result := Report;

end;

{------------------------------------------------------------------------------}
{ TppGroup.SetParentComponent - required method for Components with HasParent = True }

procedure TppGroup.SetParentComponent(Value: TComponent);
begin

  if (Value is TppCustomReport) then
    Report := (Value as TppCustomReport);

end;

{------------------------------------------------------------------------------}
{ TppGroup.GetNewColumnThreshold }

function TppGroup.GetNewColumnThreshold: Single;
begin

  Result := FromMMThousandths(FNewColumnThreshold, FUnits, pprtVertical);

end; {procedure, GetNewColumnThreshold}

{------------------------------------------------------------------------------}
{ TppGroup.GetPrinter }

function TppGroup.GetPrinter: TppPrinter;
begin

  if (FReport <> nil) then
    Result := FReport.Printer
  else
    Result := ppPrinter;

end;

{------------------------------------------------------------------------------}
{ TppGroup.FromMMThousandths }

function TppGroup.FromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType): Single;
var
  lPrinter: TppPrinter;
begin
  if (aUnits = utPrinterPixels) then
    lPrinter := GetPrinter
  else
    lPrinter := nil;

  Result := ppFromMMThousandths(Value, aUnits, aResolution, lPrinter);

end;

{------------------------------------------------------------------------------}
{ TppGroup.ToMMThousandths }

function TppGroup.ToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType): Longint;
var
  lPrinter: TppPrinter;
begin
  if (aUnits = utPrinterPixels) then
    lPrinter := GetPrinter
  else
    lPrinter := nil;

  Result := ppToMMThousandths(Value, aUnits, aResolution, lPrinter);

end;

{------------------------------------------------------------------------------}
{ TppGroup.SetNewColumnThreshold }

procedure TppGroup.SetNewColumnThreshold(Value: Single);
begin

  FNewColumnThreshold := ToMMThousandths(Value, FUnits, pprtVertical);

  {notify report engine}
  Reset;

end; {procedure, SetNewColumnThreshold}

{------------------------------------------------------------------------------}
{ TppGroup.GetNewPageThreshold }

function TppGroup.GetNewPageThreshold: Single;
begin

  Result := FromMMThousandths(FNewPageThreshold, FUnits, pprtVertical);

end; {procedure, GetNewPageThreshold}

{------------------------------------------------------------------------------}
{ TppGroup.SetNewPageThreshold }

procedure TppGroup.SetNewPageThreshold(Value: Single);
begin

  {used for conversion to 3.0}
  if csReading in ComponentState then
    begin
      FOldThreshold := Value;
      Exit;
    end;

  FNewPageThreshold := ToMMThousandths(Value, FUnits, pprtVertical);

  {notify report engine}
  Reset;

end; {procedure, SetNewPageThreshold}

{------------------------------------------------------------------------------}
{ TppGroup.Convert }

procedure TppGroup.Convert(aVersionNo: Integer);
begin

  if (aVersionNo < 1270) then
    FBreakName := FFieldName;

  {convert from screen pixels to MMThousandths}
  if (FReport <> nil) and (aVersionNo < 2097) then
    begin
      FNewColumn := FNewPage;
      
      FReprintOnSubsequentPage   := FReprintOnSubsequent;
      FReprintOnSubsequentColumn := FReprintOnSubsequent;

      FNewPageThreshold   := ToMMThousandths(FOldThreshold, FReport.Units, pprtVertical);
      FNewColumnThreshold := FNewPageThreshold;
    end;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppGroup.ResolvePipelineReferences }

procedure TppGroup.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  lDataPipeline: TppDataPipeline;
begin
  if (FBreakType = btDataField) and (FDataPipeline = nil) and (FDataPipelineName <> '') then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FDataPipelineName);
      SetDataPipeline(lDataPipeline);
    end;

end; {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppGroup.FixupPipelineReferences }

procedure TppGroup.FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
begin

  if (FDataPipeline <> nil) and (FDataPipeline.UserName = aOldUserName) then
    SetDataPipeline(aDataPipeline);

end; {procedure, FixupPipelineReferences}

{------------------------------------------------------------------------------}
{ TppGroup.DefineProperties }

procedure TppGroup.ConvertBreakValueNames(const aOldFieldName, aNewFieldName: String);
begin

  if (ppEqual(FBreakName, aOldFieldName)) then
    FBreakName := aNewFieldName;

end; {procedure, Convert}


{------------------------------------------------------------------------------}
{ TppGroup.DefineProperties }

procedure TppGroup.DefineProperties(Filer: TFiler);
var
  lAncestor: TppGroup;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppGroup) then
    lAncestor := TppGroup(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('mmNewColumnThreshold', ReadNewColumnThreshold,
                        WriteNewColumnThreshold, FNewColumnThreshold <> lAncestor.FNewColumnThreshold);
      Filer.DefineProperty('mmNewPageThreshold', ReadNewPageThreshold,
                        WriteNewPageThreshold, FNewPageThreshold <> lAncestor.FNewPageThreshold);
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> lAncestor.FDataPipeline);
      Filer.DefineProperty('NewFile', ReadNewFile, WriteNewFile, FGroupFileSettings.NewFile <> lAncestor.GroupFileSettings.NewFile);
    end
  else
    begin
      Filer.DefineProperty('mmNewColumnThreshold', ReadNewColumnThreshold,
                        WriteNewColumnThreshold, True);
      Filer.DefineProperty('mmNewPageThreshold', ReadNewPageThreshold,
                        WriteNewPageThreshold, True);
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, True);
      Filer.DefineProperty('NewFile', ReadNewFile, WriteNewFile, True);
    end;


  {used for conversion to 3.0}
  Filer.DefineProperty('FieldName', ReadFieldName, nil, False);
  Filer.DefineProperty('ReprintOnSubsequent', ReadReprintOnSubsequent, nil, False);
  Filer.DefineProperty('Left', ReadLeft, nil, False);
  Filer.DefineProperty('Top', ReadTop, nil, False);
  
end;

{------------------------------------------------------------------------------}
{ TppGroup.ReadDataPipelineName }

procedure TppGroup.ReadDataPipelineName(Reader: TReader);
begin
  FDataPipelineName := Reader.ReadString;

end; {procedure, ReadDataPipelineName}

{------------------------------------------------------------------------------}
{ TppGroup.WriteDataPipelineName }

procedure TppGroup.WriteDataPipelineName(Writer: TWriter);
begin
  if (FDataPipeline <> nil) then
   Writer.WriteString(FDataPipeline.Name)
  else
    Writer.WriteString('');

end; {procedure, WriteDataPipelineName}

{------------------------------------------------------------------------------}
{ TppGroup.ReadLeft }

procedure TppGroup.ReadLeft(Reader: TReader);
begin
  {eat the value}
  ppReadIntegerPropValue(Reader);
end; {procedure, ReadLeft}

{------------------------------------------------------------------------------}
{ TppGroup.ReadTop }

procedure TppGroup.ReadTop(Reader: TReader);
begin
  {eat the value}
  ppReadIntegerPropValue(Reader);
end; {procedure, ReadTop}

{------------------------------------------------------------------------------}
{ TppGroup.ReadNewColumnThreshold }

procedure TppGroup.ReadNewColumnThreshold(Reader: TReader);
begin
  FNewColumnThreshold := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppGroup.WriteNewColumnThreshold }

procedure TppGroup.WriteNewColumnThreshold(Writer: TWriter);
begin
  Writer.WriteInteger(FNewColumnThreshold);
end;

{------------------------------------------------------------------------------}
{ TppGroup.ReadNewFile }

procedure TppGroup.ReadNewFile(Reader: TReader);
begin
  FGroupFileSettings.NewFile := Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
{ TppGroup.WriteNewFile }

procedure TppGroup.WriteNewFile(Writer: TWriter);
begin
  Writer.WriteBoolean(FGroupFileSettings.NewFile);
end;

{------------------------------------------------------------------------------}
{ TppGroup.ReadNewPageThreshold }

procedure TppGroup.ReadNewPageThreshold(Reader: TReader);
begin
  FNewPageThreshold := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppGroup.WriteNewPageThreshold }

procedure TppGroup.WriteNewPageThreshold(Writer: TWriter);
begin
  Writer.WriteInteger(FNewPageThreshold);
end;

{------------------------------------------------------------------------------}
{ TppGroup.ReadFieldName }

procedure TppGroup.ReadFieldName(Reader: TReader);
begin
  FFieldName := Reader.ReadString;
end;

{------------------------------------------------------------------------------}
{ TppGroup.ReadReprintOnSubsequent }

procedure TppGroup.ReadReprintOnSubsequent(Reader: TReader);
begin
  FReprintOnSubsequent := True;
  
  FReprintOnSubsequent := Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
{ TppGroup.SetOutlineSettings }

procedure TppGroup.SetOutlineSettings(aOutlineSettings: TppOutlineSettings);
begin

  FOutlineSettings.Assign(aOutlineSettings);

end; { procedure, SetOutlineSettings }

{------------------------------------------------------------------------------}
{ TppGroup.SetStartOnOddPage }

procedure TppGroup.SetStartOnOddPage(const Value: Boolean);
begin
  FStartOnOddPage := Value;

  if not(NewPage) and (FStartOnOddPage) then
    NewPage := True;

end; { procedure, SetStartOnOddPage }

{------------------------------------------------------------------------------}
{ TppGroup.iOutlineGetChildren }

function TppGroup.iOutlineGetChildren: TList;
var
  liIndex: Integer;
  lDetailBand: TppBand;
  lNextGroup: TppGroup;
begin

  if (FOutlineChildren = nil) then
    FOutlineChildren := TList.Create
  else
    FOutlineChildren.Clear;

  liIndex := GetIndex;

  if (liIndex = Report.GroupCount - 1) then
    begin

      lDetailBand := Report.GetBand(btDetail, 0);
      lDetailBand.GetSubReports(FOutlineChildren);

    end
  else
    begin

      lNextGroup := Report.Groups[liIndex + 1];
      FOutlineChildren.Add(lNextGroup);

    end;

  Result := FOutlineChildren;

end; { function, iOutlineGetChildren }

{------------------------------------------------------------------------------}
{ TppGroup.iOutlineGetParent }

function TppGroup.iOutlineGetParent: TppCommunicator;
begin

  Result := TppCustomReport.GetOutlineParent(Report.GetMainReport, Self);

end; { function, iOutlineGetParent }

{------------------------------------------------------------------------------}
{ TppGroup.iOutlineNodeCreatorClass }

function TppGroup.iOutlineNodeCreatorClass: TComponentClass;
begin

  Result := TppOutlineGroupNodeCreator;

end; { function, iOutlineNodeCreatorClass }

{------------------------------------------------------------------------------}
{ TppGroup.iOutlineSettings }

function TppGroup.iOutlineSettings: TppOutlineSettings;
begin

  Result := FOutlineSettings;

end; { function, iOutlineSettings }

{------------------------------------------------------------------------------}
{ TppGroup.iOutlineSettingsChanged }

procedure TppGroup.iOutlineSettingsChanged;
begin

  FReport.Reset;

end; { procedure, iOutlineSettingsChanged }


{******************************************************************************
 *
 ** C O M P O N E N T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppComponent.Create }

constructor TppComponent.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  FBand               := nil;
  FBandType           := btDetail;
  FResetGroup         := nil;
  FRegion             := nil;
  FParentDataPipeline := True;
  FGroupNo            := -1;
  FAnchors            := [atLeft, atTop];

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppComponent.Destroy }

destructor TppComponent.Destroy;
begin

  Destroying;

  {notify designer - need to send message prior to SetBand(nil) call below
                     because once band is set to nil}
  SendDesignMessage(RM_COMPONENTDESTROY, ppWCustomMsg, Self);

  {tell region that we no longer exist}
  if (FRegion <> nil) then
    TppRegion(FRegion).RemoveObject(Self);

  SetBand(nil);

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppComponent.Notify}

procedure TppComponent.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FRegion) then
    FRegion := nil
    
  else if(aCommunicator = FResetGroup) then
    FResetGroup := nil;


end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppComponent.ProcessMessages }

procedure TppComponent.ProcessMessages;
begin
  if GetReport <> nil then
    GetReport.ProcessMessages;

end; {procedure, ProcessMessages}

{------------------------------------------------------------------------------}
{ TppComponent.GetPrintMessage }

function TppComponent.GetPrintMessage: String;
begin
  if (Band <> nil) then
    Result := Band.GetPrintMessage
  else
    Result := '';
end; {function, GetPrintMessage }

{------------------------------------------------------------------------------}
{ TppComponent.SetPrintMessage }

procedure TppComponent.SetPrintMessage(const aMessage: String);
begin
  if (Band <> nil) then
    Band.SetPrintMessage(aMessage);
end; {function, SetPrintMessage }

{------------------------------------------------------------------------------}
{ TppComponent.Printing }

function TppComponent.Printing: Boolean;
begin
  if (FBand <> nil) and (FBand.Report <> nil) and (FBand.Report.MainReport <> nil) then
    Result := FBand.Report.MainReport.Printing
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppComponent.GetDesigner }

function TppComponent.GetDesigner: TForm;
begin
  if (FBand <> nil) and (FBand.Report <> nil) then
    Result := FBand.Report.ReportDesigner
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppComponent.GetLanguageIndex }

function TppComponent.GetLanguageIndex: Longint;
begin

  if (FBand <> nil) then
    Result := FBand.LanguageIndex
  else
    Result := 0;

end; {function, GetLanguageIndex}

{------------------------------------------------------------------------------}
{ TppComponent.IsGroupBased }

function TppComponent.IsGroupBased: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppComponent.SetResetGroup }

procedure TppComponent.SetResetGroup(aGroup: TppGroup);
begin

  if (FResetGroup <> nil) then
    begin
      FResetGroup.RemoveEventNotify(Self);

      EventNotifies := EventNotifies - [ciGroupAfterGroupBreak];
    end;

  FResetGroup := aGroup;

  if (FResetGroup <> nil) then
    begin
      FResetGroup.AddEventNotify(Self);

      EventNotifies := EventNotifies + [ciGroupAfterGroupBreak];
    end;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetResetGroup }

{------------------------------------------------------------------------------}

{@TppComponent.BringToFront
{ The BringToFront method places the report control bein front of all other report
 controls within the same band.

 To do this from the Report Designer, select the component and then click the
 BringToFront button on the Format Bar.}

procedure TppComponent.BringToFront;
begin

  BeforePropertyChange('BringToFront');

  SetIndex(FBand.ObjectCount-1);

  PropertyChange;

end; {procedure, BringToFront }


{@TppComponent.BringForward
 The BringForward method moves the object forward one in z-order.}

procedure TppComponent.BringForward;
begin
  BeforePropertyChange('BringForward');

  SetIndex(Index+1);

  PropertyChange;

end; 

procedure TppComponent.SetIndex(const Value: Integer);
var
  liIndex: Integer;
  liValue: Integer;
begin

  if (Band = nil) then Exit;

  if (FRegion <> nil) then
    begin
      liIndex := ParentIndex;
      liValue := Value - (FRegion.Index+1);

      TppRegion(FRegion).MoveObject(liIndex, liValue);
    end
  else
    FBand.MoveObject(Index, Value);

  // notify designer}
  SendDesignMessage(RM_COMPONENTUPDATED, ppWCustomMsg,  Self);

  // notify engine
  Reset;

end;


{@TppComponent.SendToBack
 The SendToBack method places the report control behind all other report
 controls within the same band.

 To do this from the Report Designer, select the component and then click the
 SendToBack button on the Format Bar.}

procedure TppComponent.SendToBack;
begin

  BeforePropertyChange('SendToBack');

  SetIndex(0);

  PropertyChange;

end;

{@TppComponent.SendBackward
 The SendBackward method moves the object back one in z-order.}

procedure TppComponent.SendBackward;
begin

  BeforePropertyChange('SendBackward');

  SetIndex(Index-1);

  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppComponent.GetIndex }

function TppComponent.GetIndex: Integer;
begin
  if FBand <> nil then
    Result := FBand.FindObject(Self)
  else
    Result := -1;

end; {function, TppComponent}


{------------------------------------------------------------------------------}
{ TppComponent.GetParentIndex }

function TppComponent.GetParentIndex: Integer;
begin

  if (FRegion <> nil) then
    Result := TppCustomRegion(FRegion).FindObject(Self)

  else if (FBand <> nil) then
    Result := FBand.FindObject(Self)
    
  else
    Result := -1;

end; {function, GetRegionIndex}

{------------------------------------------------------------------------------}
{ TppComponent.HasParent - tells the form not to save this component to the .DFM
                       because this component is a sub-component of the Report object}

function TppComponent.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppComponent.SetAnchors }

procedure TppComponent.SetAnchors(const Value: TppAnchors);
begin
  //if ((atTop in Value) and (atBottom in Value)) or ((atLeft in Value) and (atRight in Value)) then Exit;

  BeforePropertyChange('Anchors');
  FAnchors := Value;

  PropertyChange;
  Reset;
  
end; {procedure, SetAnchors}

{------------------------------------------------------------------------------}
{ TppComponent.SetBand }

procedure TppComponent.SetBand(aBand: TppBand);
begin

  BeforePropertyChange('Band');

  if FBand <> nil then
    FBand.RemoveObject(Self);

  FBand := aBand;

  if (FBand = nil) then
    // free design control
//    SendEventNotify(Self, ciReportComponentRemoved, nil)


  else if (FBand <> nil) then
    begin

      // create design control
//      SendEventNotify(Self, ciReportComponentAdded, nil);

      SetUnits(FBand.Units);

      FBand.AddObject(Self);

      if (FBand = GetParent) then
        ParentBoundsChange
      else
        UpdateDesignControlBounds;

      if (pppcDisplayData in FBand.DesignState) then
        DSInclude([pppcDisplayData])
      else
        DSExclude([pppcDisplayData]);


      {note: band type and group no. are required to support cut & paste operations}
      FBandType := FBand.BandType;

      if FBand is TppGroupBand then
        FGroupNo := (FBand as TppGroupBand).Group.GroupNo
      else
        FGroupNo := -1;

    end;

  InvalidateDesignControl;

  Reset;

  PropertyChange;

end; {procedure, SetBand}


{------------------------------------------------------------------------------}
{ TppComponent.SetRegion }

procedure TppComponent.SetRegion(aRegion: TppComponent);
begin

  if (aRegion <> nil) and not (aRegion is TppRegion) then Exit;

  BeforePropertyChange('Region');

  if FRegion <> nil then
    TppRegion(FRegion).RemoveObject(Self);

  FRegion := aRegion;

  if FRegion <> nil then
    TppRegion(FRegion).AddObject(Self);

  {adjust bounds for new parent}
  if ParentWidth or ParentHeight then
    ParentBoundsChange
  else
    UpdateDesignControlBounds;


  InvalidateDesignControl;
  Reset;
  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppComponent.spGetClipRect }

function TppComponent.spGetClipRect: TRect;
var
  lParentBounds,
  lBounds: TRect;

begin

  if FRegion = nil then
    Result := spClientRect
  else
    begin
      lParentBounds := Region.spBoundsRect;
      lBounds := spBoundsRect;

      if lBounds.Right > lParentBounds.Right then
        lBounds.Right := lParentBounds.Right;

      if lBounds.Bottom > lParentBounds.Bottom then
        lBounds.Bottom := lParentBounds.Bottom;

       Result := Rect(0, 0, (lBounds.Right - lBounds.Left), (lBounds.Bottom - lBounds.Top) );

    end;

end;

{------------------------------------------------------------------------------}
{ TppComponent.SetParentDataPipeline }

procedure TppComponent.SetParentDataPipeline(Value: Boolean);
begin
   FParentDataPipeline := Value;

  if FBand = nil then Exit;

  if ParentDataPipeline and (DataPipeline <> FBand.GetADataPipeline) then
    DataPipeline := FBand.GetADataPipeline;
    
end;

{------------------------------------------------------------------------------}
{ TppComponent.SetDataPipeline }

procedure TppComponent.SetDataPipeline(aDataPipeline: TppDataPipeline);
begin

  inherited SetDataPipeline(aDataPipeline);

  if (csReading in ComponentState) or (csLoading in ComponentState) or
     (pppcTemplateLoading in DesignState) then Exit;

  if (FBand = nil) then Exit;

  if ParentDataPipeline and (FBand <> nil) and (DataPipeline <> FBand.GetADataPipeline) then
    ParentDataPipeline := False;


end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppComponent.Reset }

procedure TppComponent.Reset;
begin
  if (FBand <> nil) then
    FBand.Reset;
end;  {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppComponent.GetNextSibling }

function TppComponent.GetNextSibling: TppComponent;
begin
  Result := nil;

  if (FBand = nil) or (GetIndex = FBand.ObjectCount-1) then Exit;

  Result := FBand.Objects[GetIndex+1];

  if Result.Parent <> GetParent then
    Result := nil;


end;  {procedure, GetNextSibling}


{------------------------------------------------------------------------------}
{ TppComponent.GetPrinter }

function TppComponent.GetPrinter: TppPrinter;
begin

  if (FBand <> nil) then
    Result := FBand.GetPrinter
  else
    Result := ppPrinter;

end; {function, GetPrinter}

{------------------------------------------------------------------------------}
{ TppComponent.PropertiesToDrawCommand}

procedure TppComponent.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  aDrawCommand.Band := FBand;
  
end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppComponent.GetMainReport }

function TppComponent.GetMainReport: TppCustomReport;
begin

  if (FBand <> nil) and (FBand.Report <> nil) then
    Result := Band.Report.MainReport
  else
    Result := nil;

end; {function, GetMainReport}

{------------------------------------------------------------------------------}
{ TppComponent.GetReport }

function TppComponent.GetReport: TppCustomReport;
begin

  if FBand <> nil then
    Result := FBand.Report
  else
    Result := nil;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TppComponent.GetShiftWithParent }

function TppComponent.GetShiftWithParent: Boolean;
begin
  Result := (atBottom in Anchors);

end; {function, GetShiftWithParent}

{------------------------------------------------------------------------------}
{ TppComponent.SetShiftWithParent }

procedure TppComponent.SetShiftWithParent(Value: Boolean);
begin

  if Value then
    Anchors := Anchors + [atBottom] - [atTop]
  else
    Anchors := Anchors - [atBottom] + [atTop];

end; {procedure, SetShiftWithParent}

{------------------------------------------------------------------------------}
{ TppComponent.UpdateDesignControlBounds }

procedure TppComponent.UpdateDesignControlBounds;
begin
  if not (pppcDesigning in DesignState) or (Printing) or (FBand = nil) then Exit;

  {note: if reading or loading and not pasting}
  if ((csReading in ComponentState) or (csLoading in ComponentState)) and not(pppcPasting in DesignState) then Exit;

  inherited;

end; {procedure, UpdateDesignControlBounds}

{------------------------------------------------------------------------------}
{ TppComponent.ParentBoundsChange }

procedure TppComponent.ParentBoundsChange;
var
  lParentRect: TppRect;
  lPrevRect: TppSizeRect;
  liMoveLeft: Integer;
  liMoveTop: Integer;
  liMoveRight: Integer;
  liMoveBottom: Integer;
  liMoveWidth: Integer;
  liMoveHeight: Integer;
  liNewBounds: TppSizeRect;
  lbMoveWidthLeft: Boolean;
  lbMoveHeightUp: Boolean;
  lbResize: Boolean;
begin

  if ((csReading in ComponentState) or (csLoading in ComponentState)) and not(pppcPasting in DesignState) then Exit;

  if Parent = nil then Exit;

  lParentRect := mmGetParentRect;
  lPrevRect := mmGetPrevRect;

  // default new bounds to current size
  liNewBounds.Left := mmLeft;
  liNewBounds.Top := mmTop;
  liNewBounds.Width := mmWidth;
  liNewBounds.Height := mmHeight;

  // calc how much parent bounds has changed
  liMoveLeft := lParentRect.Left - lPrevRect.Left;
  liMoveTop := lParentRect.Top - lPrevRect.Top;
  liMoveRight := lParentRect.Right - (lPrevRect.Left + lPrevRect.Width);
  liMoveBottom := lParentRect.Bottom - (lPrevRect.Top + lPrevRect.Height);
  liMoveWidth := (lParentRect.Right - lParentRect.Left) - lPrevRect.Width;
  liMoveHeight := (lParentRect.Bottom - lParentRect.Top) - lPrevRect.Height;

  lbMoveWidthLeft := (liMoveWidth <> 0) and (liMoveLeft <> 0);
  lbMoveHeightUp := (liMoveHeight <> 0) and (liMoveTop <> 0);

  lbResize := (liMoveWidth <> 0) or (liMoveHeight <> 0);

  // adjust new bounds for anchors
  if ((atLeft in FAnchors) and not(lbResize)) or
     ((atLeft in FAnchors) and lbMoveWidthLeft) then
    liNewBounds.Left := mmLeft + liMoveLeft;

  if ((atTop in FAnchors) and not(lbResize)) or
     ((atTop in FAnchors) and lbMoveHeightUp) then
    liNewBounds.Top := mmTop + liMoveTop;

  if ((atRight in FAnchors) and not(lbResize)) then
    liNewBounds.Left := mmLeft + liMoveRight;

  if ((atBottom in FAnchors) and not(lbResize)) then
    liNewBounds.Top := mmTop + liMoveBottom;

  if (atLeft in FAnchors) and (atRight in FAnchors) then
    liNewBounds.Width := mmWidth + liMoveWidth;

  if (atTop in FAnchors) and (atBottom in FAnchors) then
    liNewBounds.Height := mmHeight + liMoveHeight;

  // adjust new bounds for ParentWidth and ParentHeight
  if ParentWidth then
    begin
      liNewBounds.Left := lParentRect.Left;
      liNewBounds.Width := lParentRect.Right-lParentRect.Left;
    end;

  if ParentHeight then
    begin
      liNewBounds.Top := lParentRect.Top;
      liNewBounds.Height := lParentRect.Bottom-lParentRect.Top;
    end;

  // apply new bounds
  if (FAnchors <> []) or ParentWidth or ParentHeight then
    mmSetBounds(liNewBounds.Left, liNewBounds.Top, liNewBounds.Width, liNewBounds.Height);

end;


{------------------------------------------------------------------------------}
{ TppComponent.mmGetParentRect }

function TppComponent.mmGetParentRect: TppRect;
begin

  if (FRegion <> nil) then
    Result := ppRect(FRegion.mmLeft, FRegion.mmTop, FRegion.mmLeft+FRegion.mmWidth, FRegion.mmTop+FRegion.mmHeight)
  else if (FBand <> nil) then
    Result := ppRect(0, 0, FBand.mmWidth, FBand.mmHeight)
  else
    Result := ppRect(mmLeft, mmTop, mmLeft+mmWidth, mmTop+mmHeight);

end;

{------------------------------------------------------------------------------}
{ TppComponent.mmGetPrevRect }

function TppComponent.mmGetPrevRect: TppSizeRect;
begin

  if (FRegion <> nil) then
    Result := TppRegion(FRegion).PrevRect
  else
    Result := FBand.PrevRect;
    
end;

{------------------------------------------------------------------------------}
{ TppComponent.mmSetBounds }

procedure TppComponent.mmSetBounds(aLeft, aTop, aWidth, aHeight: LongInt);
begin

  if (pppcDesigning in DesignState)  and not (Printing) then
    begin

      {make sure component is within Band}
      if aTop < 0 then
        aTop := 0

      else if (FBand <> nil) and (aTop > FBand.mmHeight) then
        aTop := FBand.mmHeight;

      {make sure component is within Band}
      if aLeft < 0 then
        aLeft := 0

      else if (FBand <> nil) and (aLeft > FBand.mmWidth) then
        aLeft := FBand.mmWidth;

    end;
    
  inherited mmSetBounds(aLeft, aTop, aWidth, aHeight);


end; {procedure, SetBounds}


{------------------------------------------------------------------------------}
{ TppComponent.SetMMLeft }

procedure TppComponent.SetMMLeft(Value: LongInt);
begin
  if ParentWidth then Exit;

  {make sure component is within Band}
  if (Value < 0) then
    Value := 0

  else if (FBand <> nil) and (Value > FBand.mmWidth) then
    Value := FBand.mmWidth;

  if (Value <> mmLeft) then
    inherited SetMMLeft(Value);


end; {procedure, SetMMLeft}


{------------------------------------------------------------------------------}
{ TppComponent.SetMMTop }

procedure TppComponent.SetMMTop(Value: Longint);
begin
  if ParentHeight then Exit;

  if Value < 0 then
    Value := 0;

  {make sure component is within Band}
  if (pppcDesigning in DesignState) and not(Printing) and
     (FBand <> nil) and (Value > FBand.mmHeight) then
    Value := FBand.mmHeight;

  if (Value <> mmTop) then
    inherited SetMMTop(Value);

end; {procedure, SetMMTop}


{------------------------------------------------------------------------------}
{ TppComponent.SetMMWidth }

procedure TppComponent.SetMMWidth(Value: Longint);
begin

  if ParentWidth then Exit;

  {make sure component is within Band}
  if (Value < 0) then
    Value := 0;

  if  (Value <> mmWidth) then
    inherited SetMMWidth(Value);

end; {procedure, SetMMWidth}

{------------------------------------------------------------------------------}
{ TppComponent.SetParentWidth }

procedure TppComponent.SetParentWidth(Value: Boolean);
begin
  BeforePropertyChange('ParentWidth');

  inherited SetParentWidth(Value);

  if ParentWidth then
    ParentBoundsChange;

  SendEventNotify(Self, ciComponentParentWidthChanged, nil);

  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppComponent.SetParentHeight }

procedure TppComponent.SetParentHeight(Value: Boolean);
begin
  BeforePropertyChange('ParentHeight');
  inherited SetParentHeight(Value);

  if ParentHeight then
    ParentBoundsChange;

  SendEventNotify(Self, ciComponentParentHeightChanged, nil);

  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppComponent.SetMMHeight }

procedure TppComponent.SetMMHeight(Value: Longint);
begin

  if ParentHeight then Exit;

  {make sure component is within Band}
  if (Value < 0) then
    Value := 0;

  if Value <> mmHeight  then
    inherited SetMMHeight(Value);

end; {procedure, SetMMHeight}


{------------------------------------------------------------------------------}
{ TppComponent.DefineProperties - read/write private 'fake' properties}

procedure TppComponent.DefineProperties(Filer: TFiler);
var
  lAncestor: TppComponent;

begin
  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppComponent) then
    lAncestor := TppComponent(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('BandType', ReadBandType, WriteBandType, FBandType <> lAncestor.FBandType);
      Filer.DefineProperty('GroupNo', ReadGroupNo, WriteGroupNo,
                                   (FGroupNo <> lAncestor.FGroupNo) and (FGroupNo >= 0) );
    end
  else
    begin
      Filer.DefineProperty('BandType', ReadBandType, WriteBandType, True);
      Filer.DefineProperty('GroupNo', ReadGroupNo, WriteGroupNo, FGroupNo >= 0);
    end;

  {Used for converstion to 9.0}
  Filer.DefineProperty('ShiftWithParent', ReadShiftWithParent, nil, False);

end;

{------------------------------------------------------------------------------}
{ TppComponent.ReadBandType }

procedure TppComponent.ReadBandType(Reader: TReader);
var
  lBandType : TppBandType;

begin
  lBandType := TppBandType(Reader.ReadInteger);

  {if band is nil then we are pasting and need the band type that was saved}
  if (FBand = nil) then
    FBandType := lBandType;

end;

{------------------------------------------------------------------------------}
{ TppComponent.ReadGroupNo }

procedure TppComponent.ReadGroupNo(Reader: TReader);
begin
  FGroupNo := Reader.ReadInteger;
end;

{------------------------------------------------------------------------------}
{ TppComponent.ReadShiftWithParent }

procedure TppComponent.ReadShiftWithParent(Reader: TReader);
begin
  if Reader.ReadBoolean then
    Anchors := Anchors + [atBottom] - [atTop];
    
end;

{------------------------------------------------------------------------------}
{ TppComponent.WriteBandType}

procedure TppComponent.WriteBandType(Writer: TWriter);
begin
  Writer.WriteInteger(Ord(FBandType));
end;


{------------------------------------------------------------------------------}
{ TppComponent.WriteGroupNo }

procedure TppComponent.WriteGroupNo(Writer: TWriter);
begin
  Writer.WriteInteger(FGroupNo);
end;

{------------------------------------------------------------------------------}
{ TppComponent.ReadState }

procedure TppComponent.ReadState(Reader: TReader);
begin

  if (Reader.Parent is TppBand) then
     SetBand(TppBand(Reader.Parent))

  else if (Reader.Parent is TppRegion) then
    SetRegion(TppRegion(Reader.Parent));

  inherited ReadState(Reader);

end;


{------------------------------------------------------------------------------}
{ TppComponent.GetParent }

function TppComponent.GetParent: TComponent;
begin

  if FRegion = nil then
    Result := FBand
  else
    Result := FRegion;

end;


{------------------------------------------------------------------------------}
{ TppComponent.GetParentComponent - required method for Components with HasParent = True }

function TppComponent.GetParentComponent: TComponent;
begin
  Result := GetParent;

end;

{------------------------------------------------------------------------------}
{ TppComponent.SetParentComponent - required method for Components with HasParent = True }

procedure TppComponent.SetParentComponent(Value: TComponent);
begin

 { if (Value is TppBand) then
    FBand := (Value as TppBand)

  else if (Value is TppRegion) then
    FRegion := (Value as TppRegion)   }

end;

{------------------------------------------------------------------------------}
{ TppComponent.GeneratingNewPage }

function TppComponent.GeneratingNewPage: Boolean;
begin
  if (Band <> nil) then
    Result := Band.GeneratingNewPage

  else
    Result := True;
end;


{******************************************************************************
 *
 ** C U S T O M   E N G I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomEngine.Create }

constructor TppCustomEngine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAfterSendPage := nil;
  FBeforeSendPage := nil;
  FOnGetLastPageCached := nil;
  FOnPageEnd := nil;
  FOnPageSent := nil;
  FOnReadCache := nil;
  FOnResetCache := nil;
  FOnWriteCache := nil;
  FPage := TppPage.Create(nil);
  FReport := TppCustomReport(aOwner);
  FSilentExceptions := False;

  Reset;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomEngine.Destroy  }

destructor TppCustomEngine.Destroy;
begin

  FPage.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomEngine.SetPrintPosition }

procedure TppCustomEngine.SetPrintPosition(Left, Top, Right, Bottom: Longint);
begin
  FPrintPosRect.Left   := Left;
  FPrintPosRect.Top    := Top;
  FPrintPosRect.Right  := Right;
  FPrintPosRect.Bottom := Bottom;
end; {procedure, SetPrintPosition}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoAfterSendPage }

procedure TppCustomEngine.DoAfterSendPage;
begin

  if Assigned(FAfterSendPage) then FAfterSendPage(Self);

  SendEventNotify(Self, ciEngineAfterSendPage, nil);

end; {procedure, DoAfterSendPage}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoBeforeSendPage }

procedure TppCustomEngine.DoBeforeSendPage;
begin
  if Assigned(FBeforeSendPage) then FBeforeSendPage(Self);
end; {procedure, DoBeforeSendPage}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoOnReadCache }

procedure TppCustomEngine.DoOnReadCache;
begin
  if Assigned(FOnReadCache) then FOnReadCache(Self);
end; {procedure, DoOnReadCache}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoOnWriteCache }

procedure TppCustomEngine.DoOnWriteCache;
begin
  if Assigned(FOnWriteCache) then FOnWriteCache(Self);
end; {procedure, DoOnWriteCache}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoOnResetCache }

procedure TppCustomEngine.DoOnResetCache;
begin
  if Assigned(FOnResetCache) then FOnResetCache(Self);
end; {procedure, DoOnResetCache}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoOnGetLastPageCached }

procedure TppCustomEngine.DoOnGetLastPageCached;
begin
  if Assigned(FOnGetLastPageCached) then FOnGetLastPageCached(Self, FLastPageCached);
end; {procedure, DoOnGetLastPageCached}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DataTraversalCompleted }

procedure TppCustomEngine.DataTraversalCompleted;
begin


end; {procedure, DataTraversalCompleted}

{------------------------------------------------------------------------------}
{ TppCustomEngine.PageLimitReached }

procedure TppCustomEngine.PageLimitReached;
begin


end; {procedure, PageLimitReached}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoOnPageEnd }

procedure TppCustomEngine.DoOnPageEnd;
begin
  if Assigned(FOnPageEnd) then FOnPageEnd(Self);
end; {procedure, DoOnPageEnd}

{------------------------------------------------------------------------------}
{ TppCustomEngine.DoOnPageSent }

procedure TppCustomEngine.DoOnPageSent;
begin
  if Assigned(FOnPageSent) then FOnPageSent(Self);
end; {procedure, DoOnPageSent}

{------------------------------------------------------------------------------}
{ TppCustomEngine.SetStopPrinting }

procedure TppCustomEngine.SetStopPrinting(Value: Boolean);
begin
  FStopPrinting := Value;
end; {procedure, SetStopPrinting}

{------------------------------------------------------------------------------}
{ TppCustomEngine.GetPageStarted }

function TppCustomEngine.GetPageStarted: Boolean;
begin
  Result := FPageStarted;
end; {function, GetPageStarted}

{------------------------------------------------------------------------------}
{ TppCustomEngine.SetPageStarted }

procedure TppCustomEngine.SetPageStarted(aValue: Boolean);
begin
  FPageStarted := aValue;
end; {function, SetPageStarted}

{------------------------------------------------------------------------------}
{ TppCustomEngine.GetPageNo }

function TppCustomEngine.GetPageNo: Longint;
begin
  Result := FAbsolutePageNo;
end; {function, GetPageNo}

{------------------------------------------------------------------------------}
{ TppCustomEngine.GetPageCount }

function TppCustomEngine.GetPageCount: Longint;
begin
  Result := FAbsolutePageCount;
end; {function, GetPageCount}

{------------------------------------------------------------------------------}
{ TppCustomEngine.GetPage }

function TppCustomEngine.GetPage: TppPage;
begin
  Result := FPage;
end; {procedure, GetPage}

{------------------------------------------------------------------------------}
{ TppCustomEngine.SetReport }

procedure TppCustomEngine.SetReport(aReport: TppCustomReport);
begin
  FReport := aReport;
end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ TppCustomEngine.ESInclude }

procedure TppCustomEngine.ESInclude(aEngineStateSet: TppEngineStates);
begin
  FEngineState := FEngineState + aEngineStateSet;
end; {procedure, ESInclude}

{------------------------------------------------------------------------------}
{ TppCustomEngine.ESExclude }

procedure TppCustomEngine.ESExclude(aEngineStateSet: TppEngineStates);
begin
  FEngineState := FEngineState - aEngineStateSet;
end; {procedure, ESExclude}

{------------------------------------------------------------------------------}
{ TppCustomEngine.FlushLeft }

procedure TppCustomEngine.FlushLeft;
begin
  FPrintPosRect.Left := FPage.PrinterSetup.PageDef.mmMarginLeft;
end; {procedure, FlushLeft}

{------------------------------------------------------------------------------}
{ TppCustomEngine.PCInclude }

procedure TppCustomEngine.PCInclude(aPrintConditionSet: TppPrintConditions);
begin
  FPrintCondition := FPrintCondition + aPrintConditionSet;
end; {procedure, PCInclude}

{------------------------------------------------------------------------------}
{ TppCustomEngine.PCExclude }

procedure TppCustomEngine.PCExclude(aPrintConditionSet: TppPrintConditions);
begin
  FPrintCondition := FPrintCondition - aPrintConditionSet;
end; {procedure, PCExclude}


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
 ** C U S T O M   R E P O R T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.RefClass }

class function TraTppCustomReportRTTI.RefClass: TClass;
begin
  Result := TppCustomReport;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.GetPropList }

class procedure TraTppCustomReportRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('AbsolutePageNo');
  aPropList.AddProp('AbsolutePageCount');
  aPropList.AddProp('Bands');
  aPropList.AddProp('BandCount');
  aPropList.AddProp('CurrentColumn');
  aPropList.AddProp('FirstPass' );
  aPropList.AddProp('Groups' );
  aPropList.AddProp('GroupCount');
  aPropList.AddProp('MainReport');
  aPropList.AddProp('PageNo');
  aPropList.AddProp('PageBandCount');
  aPropList.AddProp('PageCount');
  aPropList.AddProp('PrintDateTime');
  aPropList.AddProp('ReportBandCount');
  aPropList.AddProp('SecondPass');

  {add methods}
  aPropList.AddMethod('CreateDefaultBands');
  aPropList.AddMethod('Stop');
  aPropList.AddMethod('PageLimitReached');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.GetEventList }

class procedure TraTppCustomReportRTTI.GetEventList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetEventList(aClass, aPropList);

  aPropList.RemoveProp('OnPrintingComplete');

end; {class procedure, GetEventList}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.GetPropRec }

class function TraTppCustomReportRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if ppEqual(aPropName, 'OnEndColumn') then
    EventToRec(aPropName, ciEngineEndColumn, False, aPropRec)

  else if ppEqual(aPropName, 'OnEndFirstPass') then
    EventToRec(aPropName, ciEngineEndFirstPass, False, aPropRec)

  else if ppEqual(aPropName, 'OnEndPage') then
    EventToRec(aPropName, ciEngineEndPage, False, aPropRec)

  else if ppEqual(aPropName, 'OnEndSecondPass') then
    EventToRec(aPropName, ciEngineEndSecondPass, False, aPropRec)

  else if ppEqual(aPropName, 'OnNoData') then
    EventToRec(aPropName, ciEngineNoData, True, aPropRec)

  else if ppEqual(aPropName, 'OnStartColumn') then
    EventToRec(aPropName, ciEngineStartColumn, False, aPropRec)

  else if ppEqual(aPropName, 'OnStartFirstPass') then
    EventToRec(aPropName, ciEngineStartFirstPass, False, aPropRec)

  else if ppEqual(aPropName, 'OnStartPage') then
    EventToRec(aPropName, ciEngineStartPage, False, aPropRec)

  else if ppEqual(aPropName, 'OnStartSecondPass') then
    EventToRec(aPropName, ciEngineStartSecondPass, False, aPropRec)


  {properties & methods}
  else if ppEqual(aPropName, 'AbsolutePage')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'AbsolutePageNo')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'AbsolutePageCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'BandCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Bands')  then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'CreateDefaultBands')  then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'CurrentColumn')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Stop')  then
    PropToRec(aPropName, daMethod, True, aPropRec)

  else if ppEqual(aPropName, 'DonePrinting')  then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'Engine')  then
    ClassPropToRec(aPropName, TppCustomEngine, True, aPropRec)

  else if ppEqual(aPropName, 'FirstPass')  then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'GetBand')  then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'GroupCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Groups')  then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'MainReport')  then
    ClassPropToRec(aPropName, TppCustomReport, True, aPropRec)

  else if ppEqual(aPropName, 'mmColumnWidth')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Modified')  then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Page')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PageNo')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PageBandCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PageCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PageLimitReached')  then
    PropToRec(aPropName, daMethod, True, aPropRec)

  else if ppEqual(aPropName, 'ParentReport')  then
    ClassPropToRec(aPropName, TppCustomReport, True, aPropRec)

  else if ppEqual(aPropName, 'ReportDesigner')  then
    ClassPropToRec(aPropName, TForm, True, aPropRec)

  else if ppEqual(aPropName, 'PrintDateTime')  then
    PropToRec(aPropName, daDateTime, True, aPropRec)

  else if ppEqual(aPropName, 'PrintingAsSubReport')  then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'ReportBandCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'SecondPass')  then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'spColumnWidth')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'AutoStop')  then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Columns')  then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'ColumnPositions')  then
    ClassPropToRec(aPropName, TStrings, False, aPropRec)

  else if ppEqual(aPropName, 'ColumnWidth')  then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if ppEqual(aPropName, 'DataPipeline')  then
    ClassPropToRec(aPropName, TppDataPipeline, False, aPropRec)

  else if ppEqual(aPropName, 'PageLimit')  then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'PassSetting')  then
    EnumPropToRec(aPropName, 'TppPassSettingType', False, aPropRec)

  else if ppEqual(aPropName, 'SaveAsTemplate')  then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Template')  then
    ClassPropToRec(aPropName, TppReportTemplate, False, aPropRec)

  else if ppEqual(aPropName, 'Units')  then
    EnumPropToRec(aPropName, 'TppUnitType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.GetParams }

class function TraTppCustomReportRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'Bands')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppBand, '', False, False);
    end

  else if ppEqual(aMethodName, 'Groups')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppGroup, '', False, False);
    end

  else if ppEqual(aMethodName, 'GetBand')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('BandType', daEnum, nil, 'TppBandType', False, False);
      Result.AddParam('GroupIndex', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppBand, '', False, False);
    end

  else if ppEqual(aMethodName, 'OnNoData') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDialog', daClass, TObject, '', False, False);
      Result.AddParam('aShowDialog', daBoolean, nil, '', False, True);
      Result.AddParam('aDrawCommand', daClass, TObject, '', False, False);
      Result.AddParam('aAddDrawCommand', daBoolean, nil, '', False, True);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.CallMethod }

class function TraTppCustomReportRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lReport: TppCustomReport;
  liIndex: Integer;
  lBandType: Integer;
  lBand: TppBand;
  lGroup: TppGroup;
begin

  Result := True;
  
  lReport := TppCustomReport(aObject);

  if ppEqual(aMethodName, 'Bands')  then
    begin
      aParams.GetParamValue(0, liIndex);

      lBand := lReport.Bands[liIndex];

      aParams.SetParamValue(1, Integer(lBand));
    end

  else if ppEqual(aMethodName, 'CreateDefaultBands')    then
    begin
      lReport.CreateDefaultBands();
    end

  else if ppEqual(aMethodName, 'Groups')    then
    begin
      aParams.GetParamValue(0, liIndex);

      lGroup := lReport.Groups[liIndex];

      aParams.SetParamValue(1, Integer(lGroup));
    end

  else if ppEqual(aMethodName, 'Stop')  then
    lReport.Stop

  else if ppEqual(aMethodName, 'PageLimitReached')  then
    lReport.PageLimitReached

  else if ppEqual(aMethodName, 'GetBand')  then
    begin
      aParams.GetParamValue(0, lBandType);
      aParams.GetParamValue(1, liIndex);

      lBand := lReport.GetBand(TppBandType(lBandType), liIndex);

      aParams.SetParamValue(2, Integer(lBand));
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.GetPropValue }

class function TraTppCustomReportRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AbsolutePage')  then
    Integer(aValue) := TppCustomReport(aObject).AbsolutePage

  else if ppEqual(aPropName, 'AbsolutePageNo')  then
    Integer(aValue) := TppCustomReport(aObject).AbsolutePageNo

  else if ppEqual(aPropName, 'AbsolutePageCount')  then
    Integer(aValue) := TppCustomReport(aObject).AbsolutePageCount

  else if ppEqual(aPropName, 'BandCount')  then
    Integer(aValue) := TppCustomReport(aObject).BandCount

  else if ppEqual(aPropName, 'CurrentColumn')  then
    Integer(aValue) := TppCustomReport(aObject).CurrentColumn

  else if ppEqual(aPropName, 'DonePrinting')  then
    Boolean(aValue) := TppCustomReport(aObject).DonePrinting

  else if ppEqual(aPropName, 'Engine')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).Engine)

  else if ppEqual(aPropName, 'FirstPass')  then
    Boolean(aValue) := TppCustomReport(aObject).FirstPass

  else if ppEqual(aPropName, 'GroupCount')  then
    Integer(aValue) := TppCustomReport(aObject).GroupCount

  else if ppEqual(aPropName, 'MainReport')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).MainReport)

  else if ppEqual(aPropName, 'mmColumnWidth')  then
    Integer(aValue) := TppCustomReport(aObject).mmColumnWidth

  else if ppEqual(aPropName, 'Modified')  then
    Boolean(aValue) := TppCustomReport(aObject).Modified

  else if ppEqual(aPropName, 'Page')  then
    Integer(aValue) := TppCustomReport(aObject).Page

  else if ppEqual(aPropName, 'PageNo')  then
    Integer(aValue) := TppCustomReport(aObject).PageNo

  else if ppEqual(aPropName, 'PageBandCount')  then
    Integer(aValue) := TppCustomReport(aObject).PageBandCount

  else if ppEqual(aPropName, 'PageCount')  then
    Integer(aValue) := TppCustomReport(aObject).PageCount

  else if ppEqual(aPropName, 'ParentReport')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).ParentReport)

  else if ppEqual(aPropName, 'ReportDesigner')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).ReportDesigner)

  else if ppEqual(aPropName, 'PrintDateTime')  then
    TDateTime(aValue) := TppCustomReport(aObject).PrintDateTime

  else if ppEqual(aPropName, 'PrintingAsSubReport')  then
    Boolean(aValue) := TppCustomReport(aObject).PrintingAsSubReport

  else if ppEqual(aPropName, 'ReportBandCount')  then
    Integer(aValue) := TppCustomReport(aObject).ReportBandCount

  else if ppEqual(aPropName, 'SecondPass')  then
    Boolean(aValue) := TppCustomReport(aObject).SecondPass

  else if ppEqual(aPropName, 'spColumnWidth')  then
    Integer(aValue) := TppCustomReport(aObject).spColumnWidth

  else if ppEqual(aPropName, 'AutoStop')  then
    Boolean(aValue) := TppCustomReport(aObject).AutoStop

  else if ppEqual(aPropName, 'Columns')  then
    Integer(aValue) := TppCustomReport(aObject).Columns

  else if ppEqual(aPropName, 'ColumnPositions')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).ColumnPositions)

  else if ppEqual(aPropName, 'ColumnWidth')  then
    Single(aValue) := TppCustomReport(aObject).ColumnWidth

  else if ppEqual(aPropName, 'DataPipeline')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).DataPipeline)

  else if ppEqual(aPropName, 'PageLimit')  then
    Integer(aValue) := TppCustomReport(aObject).PageLimit

  else if ppEqual(aPropName, 'PassSetting')  then
    TppPassSettingType(aValue) := TppCustomReport(aObject).PassSetting

  else if ppEqual(aPropName, 'SaveAsTemplate')  then
    Boolean(aValue) := TppCustomReport(aObject).SaveAsTemplate

  else if ppEqual(aPropName, 'Template')  then
    Integer(aValue) := Integer(TppCustomReport(aObject).Template)

  else if ppEqual(aPropName, 'Units')  then
    TppUnitType(aValue) := TppCustomReport(aObject).Units

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.SetPropValue }

class function TraTppCustomReportRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AutoStop')  then
    TppCustomReport(aObject).AutoStop := Boolean(aValue)

  else if ppEqual(aPropName, 'Columns')  then
    TppCustomReport(aObject).Columns := Integer(aValue)

  else if ppEqual(aPropName, 'ColumnPositions')  then
    TppCustomReport(aObject).ColumnPositions := TStrings(aValue)

  else if ppEqual(aPropName, 'ColumnWidth')  then
    TppCustomReport(aObject).ColumnWidth := Single(aValue)

  else if ppEqual(aPropName, 'DataPipeline')  then
    TppCustomReport(aObject).DataPipeline := TppDataPipeline(aValue)

  else if ppEqual(aPropName, 'PageLimit')  then
    TppCustomReport(aObject).PageLimit := Integer(aValue)

  else if ppEqual(aPropName, 'PassSetting')  then
    TppCustomReport(aObject).PassSetting := TppPassSettingType(aValue)

  else if ppEqual(aPropName, 'SaveAsTemplate')  then
    TppCustomReport(aObject).SaveAsTemplate := Boolean(aValue)

  else if ppEqual(aPropName, 'Units')  then
    TppCustomReport(aObject).Units := TppUnitType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.RefClass }

class function TraTppBandRTTI.RefClass: TClass;
begin
  Result := TppBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.GetPropList }

class procedure TraTppBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Objects');
  aPropList.AddProp('ObjectCount');
  aPropList.AddProp('Report');
  aPropList.AddProp('Variables');
  aPropList.AddProp('VariableCount');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.GetPropRec }

class function TraTppBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if ppEqual(aPropName, 'AfterPrint') then
    EventToRec(aPropName, ciBandAfterPrint, False, aPropRec)

  else if ppEqual(aPropName, 'BeforePrint') then
    EventToRec(aPropName, ciBandBeforePrint, False, aPropRec)

  else if ppEqual(aPropName, 'AfterGenerate') then
    EventToRec(aPropName, ciBandAfterGenerate, False, aPropRec)

  else if ppEqual(aPropName, 'BeforeGenerate') then
    EventToRec(aPropName, ciBandBeforeGenerate, False, aPropRec)


  {properties & methods}
  else if ppEqual(aPropName, 'Caption') then
    PropToRec(aPropName, daString, False, aPropRec)

  else if ppEqual(aPropName, 'CaptionIndex') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'DrawPage') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'Height') then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if ppEqual(aPropName, 'Index') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'LastBand') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'mmBottomOffset') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'mmHeight') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'mmPrintPosition') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'mmTop') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'mmWidth') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'ObjectCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Objects') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'PrintHeight') then
    EnumPropToRec(aPropName, 'TppPrintHeightType', False, aPropRec)

  else if ppEqual(aPropName, 'Report') then
    ClassPropToRec(aPropName, TppCustomReport, False, aPropRec)

  else if ppEqual(aPropName, 'Save') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'SaveCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Saves') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'spHeight') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'spTop') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'spWidth') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'Rank') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'Units') then
    EnumPropToRec(aPropName, 'TppUnitType', False, aPropRec)

  else if ppEqual(aPropName, 'VariableCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Variables') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'Visible') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.GetParams }

class function TraTppBandRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'Objects')  or
     ppEqual(aMethodName, 'Saves')    or
     ppEqual(aMethodName, 'Variables')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppComponent, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.CallMethod }

class function TraTppBandRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lBand: TppBand;
  liIndex: Integer;
  lComponent: TppComponent;
begin

  Result := True;
  
  lBand := TppBand(aObject);

  if ppEqual(aMethodName, 'Objects')  then
    begin
      aParams.GetParamValue(0, liIndex);

      lComponent := lBand.Objects[liIndex];

      aParams.SetParamValue(1, Integer(lComponent));
    end

  else if ppEqual(aMethodName, 'Saves')    then
    begin
      aParams.GetParamValue(0, liIndex);

      lComponent := lBand.Saves[liIndex];

      aParams.SetParamValue(1, Integer(lComponent));
    end

  else if ppEqual(aMethodName, 'Variables')  then
    begin
      aParams.GetParamValue(0, liIndex);

      lComponent := lBand.Variables[liIndex];

      aParams.SetParamValue(1, Integer(lComponent));
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.GetPropValue }

class function TraTppBandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Caption') then
    String(aValue) := TppBand(aObject).Caption

  else if ppEqual(aPropName, 'CaptionIndex') then
    Integer(aValue) := TppBand(aObject).CaptionIndex

  else if ppEqual(aPropName, 'DrawPage') then
    Boolean(aValue) := TppBand(aObject).DrawPage

  else if ppEqual(aPropName, 'Height') then
    Single(aValue) := TppBand(aObject).Height

  else if ppEqual(aPropName, 'Index') then
    Integer(aValue) := TppBand(aObject).Index

  else if ppEqual(aPropName, 'LastBand') then
    Boolean(aValue) := TppBand(aObject).LastBand

  else if ppEqual(aPropName, 'mmBottomOffset') then
    Integer(aValue) := TppBand(aObject).mmBottomOffset

  else if ppEqual(aPropName, 'mmHeight') then
    Integer(aValue) := TppBand(aObject).mmHeight

  else if ppEqual(aPropName, 'mmPrintPosition') then
    Integer(aValue) := TppBand(aObject).mmPrintPosition

  else if ppEqual(aPropName, 'mmTop') then
    Integer(aValue) := TppBand(aObject).mmTop

  else if ppEqual(aPropName, 'mmWidth') then
    Integer(aValue) := TppBand(aObject).mmWidth

  else if ppEqual(aPropName, 'ObjectCount') then
    Integer(aValue) := TppBand(aObject).ObjectCount

  else if ppEqual(aPropName, 'PrintHeight') then
    Integer(aValue) := Ord(TppBand(aObject).PrintHeight)

  else if ppEqual(aPropName, 'Report') then
    Integer(aValue) := Integer(TppBand(aObject).Report)

  else if ppEqual(aPropName, 'Save') then
    Boolean(aValue) := TppBand(aObject).Save

  else if ppEqual(aPropName, 'SaveCount') then
    Integer(aValue) := TppBand(aObject).SaveCount

  else if ppEqual(aPropName, 'spHeight') then
    Integer(aValue) := TppBand(aObject).spHeight

  else if ppEqual(aPropName, 'spTop') then
    Integer(aValue) := TppBand(aObject).spTop

  else if ppEqual(aPropName, 'spWidth') then
    Integer(aValue) := TppBand(aObject).spWidth

  else if ppEqual(aPropName, 'Rank') then
    String(aValue) := TppBand(aObject).Rank

  else if ppEqual(aPropName, 'Units') then
    TppUnitType(aValue) := TppBand(aObject).Units

  else if ppEqual(aPropName, 'VariableCount') then
    Integer(aValue) := TppBand(aObject).VariableCount

  else if ppEqual(aPropName, 'Visible') then
    Boolean(aValue) := TppBand(aObject).Visible

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppBandRTTI.SetPropValue }

class function TraTppBandRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Caption') then
    TppBand(aObject).Caption := String(aValue)

  else if ppEqual(aPropName, 'CaptionIndex') then
    TppBand(aObject).CaptionIndex := Integer(aValue)

  else if ppEqual(aPropName, 'DrawPage') then
    TppBand(aObject).DrawPage := Boolean(aValue)

  else if ppEqual(aPropName, 'Height') then
    TppBand(aObject).Height := Single(aValue)

  else if ppEqual(aPropName, 'PrintHeight') then
    TppBand(aObject).PrintHeight := TppPrintHeightType(aValue)

  else if ppEqual(aPropName, 'Report') then
    TppBand(aObject).Report := TppCustomReport(aValue)

  else if ppEqual(aPropName, 'Save') then
    TppBand(aObject).Save := Boolean(aValue)

  else if ppEqual(aPropName, 'spHeight') then
    TppBand(aObject).spHeight := Integer(aValue)

  else if ppEqual(aPropName, 'spTop') then
    TppBand(aObject).spTop := Integer(aValue)

  else if ppEqual(aPropName, 'Visible') then
    TppBand(aObject).Visible := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** G R O U P   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppGroupRTTI.RefClass }

class function TraTppGroupRTTI.RefClass: TClass;
begin
  Result := TppGroup;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppGroupRTTI.GetPropList }

class procedure TraTppGroupRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('BreakNo');
  aPropList.AddProp('FirstPage');
  aPropList.AddProp('FooterBand');
  aPropList.AddProp('HeaderBand');
  aPropList.AddProp('Report');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppGroupRTTI.GetPropRec }

class function TraTppGroupRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if ppEqual(aPropName, 'AfterGroupBreak') then
    EventToRec(aPropName, ciGroupAfterGroupBreak, False, aPropRec)

  else if ppEqual(aPropName, 'BeforeGroupBreak') then
    EventToRec(aPropName, ciGroupBeforeGroupBreak, False, aPropRec)

  else if ppEqual(aPropName, 'BeforeHeader') then
    EventToRec(aPropName, ciGroupBeforeHeader, False, aPropRec)

  else if ppEqual(aPropName, 'BeforeFooter') then
    EventToRec(aPropName, ciGroupBeforeFooter, False, aPropRec)

  else if ppEqual(aPropName, 'OnGetBreakValue') then
    EventToRec(aPropName, ciGroupGetBreakValue, True, aPropRec)

  else if ppEqual(aPropName, 'OnGetFileSuffix') then
    EventToRec(aPropName, ciGroupGetFileSuffix, True, aPropRec)

  else if ppEqual(aPropName, 'OnGetEmailSettings') then
    EventToRec(aPropName, ciGroupGetEmailSettings, True, aPropRec)


  {properties & methods}
  else if ppEqual(aPropName, 'BreakComponent') then
    ClassPropToRec(aPropName, TppComponent, False, aPropRec)

  else if ppEqual(aPropName, 'Breaking') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'BreakName') then
    PropToRec(aPropName, daString, False, aPropRec)

  else if ppEqual(aPropName, 'BreakNo') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'BreakType') then
    begin
      PropToRec(aPropName, daEnum, False, aPropRec);

      aPropRec.EnumTypeName := 'TppBreakType';
    end

  else if ppEqual(aPropName, 'BreakValue') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'CurrentValue') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'DataPipeline') then
    ClassPropToRec(aPropName, TppDataPipeline, False, aPropRec)

  else if ppEqual(aPropName, 'Description') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'FirstColumn') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'FirstPage') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'FirstPageNo') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'FooterBand') then
    ClassPropToRec(aPropName, TppBand, True, aPropRec)

  else if ppEqual(aPropName, 'GroupNo') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'HeaderBand') then
    ClassPropToRec(aPropName, TppBand, True, aPropRec)

  else if ppEqual(aPropName, 'HeaderForOrphanedFooter') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Index') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'KeepTogether') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'KeptTogether') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'LastPageNo') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'mmNewColumnThreshold') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'mmNewPageThreshold') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'NewColumn') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'NewColumnThreshold') then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if ppEqual(aPropName, 'NewPage') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'NewPageThreshold') then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if ppEqual(aPropName, 'Position') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PageNo') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PageCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PriorValue') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'Report') then
    ClassPropToRec(aPropName, TppCustomReport, False, aPropRec)

  else if ppEqual(aPropName, 'ReprintOnSubsequentColumn') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'ReprintOnSubsequentPage') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'ResetPageNo') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Units') then
    EnumPropToRec(aPropName, 'TppUnitType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppGroupRTTI.GetParams }

class function TraTppGroupRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'OnGetBreakValue')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('BreakValue', daString, nil, '', False, True);
    end

  else if ppEqual(aMethodName, 'OnGetFileSuffix')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('SuffixValue', daString, nil, '', False, True);
    end

  else if ppEqual(aMethodName, 'OnGetEmailSettings')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('EmailSettings', daClass, TObject, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppGroupRTTI.GetPropValue }

class function TraTppGroupRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'BreakComponent') then
    Integer(aValue) := Integer(TppGroup(aObject).BreakComponent)

  else if ppEqual(aPropName, 'Breaking') then
    Boolean(aValue) := TppGroup(aObject).Breaking

  else if ppEqual(aPropName, 'BreakName') then
    String(aValue) := TppGroup(aObject).BreakName

  else if ppEqual(aPropName, 'BreakNo') then
    Integer(aValue) := TppGroup(aObject).BreakNo

  else if ppEqual(aPropName, 'BreakType') then
    TppBreakType(aValue) := TppGroup(aObject).BreakType

  else if ppEqual(aPropName, 'BreakValue') then
    String(aValue) := TppGroup(aObject).BreakValue

  else if ppEqual(aPropName, 'CurrentValue') then
    String(aValue) := TppGroup(aObject).CurrentValue

  else if ppEqual(aPropName, 'DataPipeline') then
    Integer(aValue) := Integer(TppGroup(aObject).DataPipeline)

  else if ppEqual(aPropName, 'Description') then
    String(aValue) := TppGroup(aObject).Description

  else if ppEqual(aPropName, 'FirstColumn') then
    Integer(aValue) := TppGroup(aObject).FirstColumn

  else if ppEqual(aPropName, 'FirstPage') then
    Boolean(aValue) := TppGroup(aObject).FirstPage

  else if ppEqual(aPropName, 'FirstPageNo') then
    Integer(aValue) := TppGroup(aObject).FirstPageNo

  else if ppEqual(aPropName, 'FooterBand') then
    Integer(aValue) := Integer(TppGroup(aObject).FooterBand)

  else if ppEqual(aPropName, 'GroupNo') then
    Integer(aValue) := TppGroup(aObject).GroupNo

  else if ppEqual(aPropName, 'HeaderBand') then
    Integer(aValue) := Integer(TppGroup(aObject).HeaderBand)

  else if ppEqual(aPropName, 'HeaderForOrphanedFooter') then
    Boolean(aValue) := TppGroup(aObject).HeaderForOrphanedFooter

  else if ppEqual(aPropName, 'Index') then
    Integer(aValue) := TppGroup(aObject).Index

  else if ppEqual(aPropName, 'KeepTogether') then
    Boolean(aValue) := TppGroup(aObject).KeepTogether

  else if ppEqual(aPropName, 'KeptTogether') then
    Boolean(aValue) := TppGroup(aObject).KeptTogether

  else if ppEqual(aPropName, 'LastPageNo') then
    Integer(aValue) := TppGroup(aObject).LastPageNo

  else if ppEqual(aPropName, 'mmNewColumnThreshold') then
    Integer(aValue) := TppGroup(aObject).mmNewColumnThreshold

  else if ppEqual(aPropName, 'mmNewPageThreshold') then
    Integer(aValue) := TppGroup(aObject).mmNewPageThreshold

  else if ppEqual(aPropName, 'NewColumn') then
    Boolean(aValue) := TppGroup(aObject).NewColumn

  else if ppEqual(aPropName, 'NewPage') then
    Boolean(aValue) := TppGroup(aObject).NewPage

  else if ppEqual(aPropName, 'NewColumnThreshold') then
    Single(aValue) := TppGroup(aObject).NewColumnThreshold

  else if ppEqual(aPropName, 'NewPageThreshold') then
    Single(aValue) := TppGroup(aObject).NewPageThreshold

  else if ppEqual(aPropName, 'Position') then
    Single(aValue) := TppGroup(aObject).Position

  else if ppEqual(aPropName, 'PageNo') then
    Integer(aValue) := TppGroup(aObject).PageNo

  else if ppEqual(aPropName, 'PageCount') then
    Integer(aValue) := TppGroup(aObject).PageCount

  else if ppEqual(aPropName, 'PriorValue') then
    String(aValue) := TppGroup(aObject).PriorValue

  else if ppEqual(aPropName, 'Report') then
    Integer(aValue) := Integer(TppGroup(aObject).Report)

  else if ppEqual(aPropName, 'ReprintOnSubsequentColumn') then
    Boolean(aValue) := TppGroup(aObject).ReprintOnSubsequentColumn

  else if ppEqual(aPropName, 'ReprintOnSubsequentPage') then
    Boolean(aValue) := TppGroup(aObject).ReprintOnSubsequentPage

  else if ppEqual(aPropName, 'ResetPageNo') then
    Boolean(aValue) := TppGroup(aObject).ResetPageNo

  else if ppEqual(aPropName, 'Units') then
    TppUnitType(aValue) := TppGroup(aObject).Units

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppGroupRTTI.SetPropValue }

class function TraTppGroupRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'BreakName') then
    TppGroup(aObject).BreakName := String(aValue)

  else if ppEqual(aPropName, 'BreakType') then
    TppGroup(aObject).BreakType := TppBreakType(aValue)

  else if ppEqual(aPropName, 'DataPipeline') then
    TppGroup(aObject).DataPipeline := TppDataPipeline(aValue)

  else if ppEqual(aPropName, 'HeaderForOrphanedFooter') then
    TppGroup(aObject).HeaderForOrphanedFooter := Boolean(aValue)

  else if ppEqual(aPropName, 'KeepTogether') then
    TppGroup(aObject).KeepTogether := Boolean(aValue)

  else if ppEqual(aPropName, 'NewColumn') then
    TppGroup(aObject).NewColumn := Boolean(aValue)

  else if ppEqual(aPropName, 'NewPage') then
    TppGroup(aObject).NewPage := Boolean(aValue)

  else if ppEqual(aPropName, 'NewColumnThreshold') then
    TppGroup(aObject).NewColumnThreshold := Single(aValue)

  else if ppEqual(aPropName, 'NewPageThreshold') then
    TppGroup(aObject).NewPageThreshold := Single(aValue)

  else if ppEqual(aPropName, 'Report') then
    TppGroup(aObject).Report := TppCustomReport(aValue)

  else if ppEqual(aPropName, 'ReprintOnSubsequentColumn') then
    TppGroup(aObject).ReprintOnSubsequentColumn := Boolean(aValue)

  else if ppEqual(aPropName, 'ReprintOnSubsequentPage') then
    TppGroup(aObject).ReprintOnSubsequentPage := Boolean(aValue)

  else if ppEqual(aPropName, 'ResetPageNo') then
    TppGroup(aObject).ResetPageNo := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{------------------------------------------------------------------------------}
{ TraTppCustomReportRTTI.CallMethod }

class function TraTppComponentRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lComponent: TppComponent;
begin

  Result := True;

  lComponent := TppComponent(aObject);

  if ppEqual(aMethodName, 'BringToFront')  then
    lComponent.BringToFront
  else  if ppEqual(aMethodName, 'SendToBack')  then
    lComponent.SendToBack
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{******************************************************************************
 *
 ** C O M P O N E N T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppComponentRTTI.RefClass }

class function TraTppComponentRTTI.RefClass: TClass;
begin
  Result := TppComponent;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppComponentRTTI.GetPropList }

class procedure TraTppComponentRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Band');
  aPropList.AddProp('AnchorNone');
  aPropList.AddProp('AnchorLeft');
  aPropList.AddProp('AnchorTop');
  aPropList.AddProp('AnchorRight');
  aPropList.AddProp('AnchorBottom');
  aPropList.AddProp('AnchorLeftTop');
  aPropList.AddProp('AnchorRightTop');
  aPropList.AddProp('AnchorLeftBottom');
  aPropList.AddProp('AnchorRightBottom');

  {add methods}
  aPropList.AddMethod('BringToFront');
  aPropList.AddMethod('SendToBack');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppComponentRTTI.GetPropRec }

class function TraTppComponentRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Band')  then
    ClassPropToRec(aPropName, TppBand, False, aPropRec)

  else if ppEqual(aPropName, 'BandType')  then
    EnumPropToRec(aPropName, 'TppBandType', True, aPropRec)

  else if ppEqual(aPropName, 'BringToFront')  then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'Index')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'NextSibling')  then
    ClassPropToRec(aPropName, TppComponent, True, aPropRec)

  else if ppEqual(aPropName, 'ParentIndex')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'GroupNo')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Parent')  then
    ClassPropToRec(aPropName, TComponent, True, aPropRec)

  else if ppEqual(aPropName, 'ParentDataPipeline')  then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Region')  then
    ClassPropToRec(aPropName, TppComponent, False, aPropRec)

  else if ppEqual(aPropName, 'ResetGroup')  then
    ClassPropToRec(aPropName, TppGroup, True, aPropRec)

  else if ppEqual(aPropName, 'SendToBack')  then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorNone') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorLeft') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorTop') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorRight') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorBottom') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorLeftTop') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorRightTop') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorLeftBottom') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'AnchorRightBottom') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppComponentRTTI.GetPropValue }

class function TraTppComponentRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Band')  then
    Integer(aValue) := Integer(TppComponent(aObject).Band)

  else if ppEqual(aPropName, 'BandType')  then
    TppBandType(aValue) := TppComponent(aObject).BandType

  else if ppEqual(aPropName, 'Index')  then
    Integer(aValue) := TppComponent(aObject).Index

  else if ppEqual(aPropName, 'NextSibling')  then
    Integer(aValue) := Integer(TppComponent(aObject).NextSibling)

  else if ppEqual(aPropName, 'ParentIndex')  then
    Integer(aValue) := TppComponent(aObject).ParentIndex

  else if ppEqual(aPropName, 'GroupNo')  then
    Integer(aValue) := TppComponent(aObject).GroupNo

  else if ppEqual(aPropName, 'Parent')  then
    Integer(aValue) := Integer(TppComponent(aObject).Parent)

  else if ppEqual(aPropName, 'ParentDataPipeline')  then
    Integer(aValue) := Ord(TppComponent(aObject).ParentDataPipeline)

  else if ppEqual(aPropName, 'Region')  then
    Integer(aValue) := Integer(TppComponent(aObject).Region)

  else if ppEqual(aPropName, 'ResetGroup')  then
    Integer(aValue) := Integer(TppComponent(aObject).ResetGroup)

  else if ppEqual(aPropName, 'AnchorNone') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [])

  else if ppEqual(aPropName, 'AnchorLeft') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atLeft])

  else if ppEqual(aPropName, 'AnchorTop') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atTop])

  else if ppEqual(aPropName, 'AnchorRight') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atRight])

  else if ppEqual(aPropName, 'AnchorBottom') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atBottom])

  else if ppEqual(aPropName, 'AnchorLeftTop') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atLeft, atTop])

  else if ppEqual(aPropName, 'AnchorRightTop') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atRight, atTop])

  else if ppEqual(aPropName, 'AnchorLeftBottom') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atLeft, atBottom])

  else if ppEqual(aPropName, 'AnchorRightBottom') then
    Boolean(aValue) := (TppComponent(aObject).Anchors = [atRight, atBottom])

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppComponentRTTI.SetPropValue }

class function TraTppComponentRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Band')  then
    TppComponent(aObject).Band := TppBand(aValue)

  else if ppEqual(aPropName, 'ParentDataPipeline')  then
    TppComponent(aObject).ParentDataPipeline := Boolean(aValue)

  else if ppEqual(aPropName, 'Region')  then
    TppComponent(aObject).Region := TppComponent(aValue)

  else if ppEqual(aPropName, 'ResetGroup')  then
    TppComponent(aObject).ResetGroup := TppGroup(aValue)

  else if ppEqual(aPropName, 'AnchorNone') then
    TppComponent(aObject).Anchors := []

  else if ppEqual(aPropName, 'AnchorLeft') then
    TppComponent(aObject).Anchors := [atLeft]

  else if ppEqual(aPropName, 'AnchorTop') then
    TppComponent(aObject).Anchors := [atTop]

  else if ppEqual(aPropName, 'AnchorRight') then
    TppComponent(aObject).Anchors := [atRight]

  else if ppEqual(aPropName, 'AnchorBottom') then
    TppComponent(aObject).Anchors := [atBottom]

  else if ppEqual(aPropName, 'AnchorLeftTop') then
    TppComponent(aObject).Anchors := [atLeft, atTop]

  else if ppEqual(aPropName, 'AnchorRightTop') then
    TppComponent(aObject).Anchors := [atRight, atTop]

  else if ppEqual(aPropName, 'AnchorLeftBottom') then
    TppComponent(aObject).Anchors := [atLeft, atBottom]

  else if ppEqual(aPropName, 'AnchorRightBottom') then
    TppComponent(aObject).Anchors := [atRight, atBottom]    

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppRegisterComponent }

procedure ppRegisterComponent(aComponentClass: TComponentClass;
                              const aToolBarName: String;
                              aToolBarPosition: Integer;
                              aHintIndex: Integer;
                              const aHint: String;
                              aHInstance: Longint);
begin

  if Assigned(ppRegisterComponentProc) then
    ppRegisterComponentProc(aComponentClass, aToolBarName, aToolBarPosition, aHintIndex, aHint, aHInstance)

  else
    raise EComponentError.Create('Unable to register component classes.');

end; {procedure, ppRegisterComponent}

{------------------------------------------------------------------------------}
{ ppUnRegisterComponent }

procedure ppUnRegisterComponent(aComponentClass: TComponentClass);
begin

  if Assigned(ppUnRegisterComponentProc) then
    ppUnRegisterComponentProc(aComponentClass)

  else
    raise EComponentError.Create('Unable to unregister component classes.');

end; {procedure, ppUnRegisterComponent}

     
 { TppGroupFileSettings }

procedure TppGroupFileSettings.Assign(Source: TPersistent);
var
  lSettings: TppGroupFileSettings;
begin

  lSettings := TppGroupFileSettings(Source);

  lSettings.NewFile := FNewFile;
  lSettings.Emailfile := FEmailFile;
  lSettings.EmailField := FEmailField;

end;

constructor TppGroupFileSettings.Create;
begin

  FNewFile := False;
  FEmailFile := False;
  FEmailField := '';

end;


procedure TppGroupFileSettings.SetEmailFile(aEmailFile: Boolean);
begin
  FEmailFile := aEmailFile;

  if not(NewFile) and (FEmailFile) then
    NewFile := True;

end;

procedure TppGroupFileSettings.SetGroup(aGroup: TppGroup);
begin
  FGroup := aGroup;
end;

procedure TppGroupFileSettings.SetNewFile(aNewFile: Boolean);
begin
  FNewFile := aNewFile;

  if not(FGroup.NewPage) and (FNewFile) then
    FGroup.NewPage := True;
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppGroup]);

  ppRegisterForm(TppCustomTemplateDialog, TppTemplateDialog);
  ppRegisterForm(TppCustomTemplateErrorDialog, TppTemplateErrorDialog);

  ppRegisterComponent(TppLabel, 'Standard Components', 0, 172, '', 0);
  ppRegisterComponent(TppMemo, 'Standard Components', 1, 175, '', 0);
  ppRegisterComponent(TppRichText, 'Standard Components', 2, 351, '', 0);
  ppRegisterComponent(TppSystemVariable, 'Standard Components', 3, 491, '', 0);
  ppRegisterComponent(TppVariable, 'Standard Components', 4, 492, '', 0);
  ppRegisterComponent(TppImage, 'Standard Components', 5, 170, '', 0);
  ppRegisterComponent(TppShape, 'Standard Components', 6, 178, '', 0);
  ppRegisterComponent(TppLine, 'Standard Components', 7, 174, '', 0);
  ppRegisterComponent(TppBarCode, 'Standard Components', 8, 460, '', 0);
  ppRegisterComponent(Tpp2DBarcode, 'Standard Components', 10, 0, '2DBarCode', 0);

  ppRegisterComponent(TppDBText, 'Data Components', 0, 167, '', 0);
  ppRegisterComponent(TppDBMemo, 'Data Components', 1, 166, '', 0);
  ppRegisterComponent(TppDBRichText, 'Data Components', 2, 352, '', 0);
  ppRegisterComponent(TppDBCalc, 'Data Components', 3, 164, '', 0);
  ppRegisterComponent(TppDBImage, 'Data Components', 4, 165, '', 0);
  ppRegisterComponent(TppDBBarCode, 'Data Components', 5, 461, '', 0);
  ppRegisterComponent(TppDB2DBarCode, 'Data Components', 10, 0, 'DB2DBarCode', 0);

  ppRegisterComponent(TppRegion, 'Advanced Components', 0, 368, '', 0);
  ppRegisterComponent(TppSubReport, 'Advanced Components', 1, 369, '', 0);
  ppRegisterComponent(TppPageBreak, 'Advanced Components', 2, 1151, '', 0);
  ppRegisterComponent(TppPaintBox, 'Advanced Components', 3, 0, 'PaintBox', 0);

  {calc is replaced by variable and system variable, but is registered for
   backward compatibility}
  RegisterClass(TppCalc);


  raRegisterRTTI(TraTppCustomReportRTTI);
  raRegisterRTTI(TraTppBandRTTI);
  raRegisterRTTI(TraTppGroupRTTI);
  raRegisterRTTI(TraTppComponentRTTI);

finalization

  UnRegisterClasses([TppGroup]);

  ppUnRegisterForm(TppCustomTemplateDialog);
  ppUnRegisterForm(TppCustomTemplateErrorDialog);

  ppUnRegisterComponent(TppLabel);
  ppUnRegisterComponent(TppMemo);
  ppUnRegisterComponent(TppRichText);
  ppUnRegisterComponent(TppSystemVariable);
  ppUnRegisterComponent(TppVariable);
  ppUnRegisterComponent(TppImage);
  ppUnRegisterComponent(TppShape);
  ppUnRegisterComponent(TppLine);
  ppUnRegisterComponent(TppBarCode);
  ppUnRegisterComponent(Tpp2DBarcode);

  ppUnRegisterComponent(TppDBText);
  ppUnRegisterComponent(TppDBMemo);
  ppUnRegisterComponent(TppDBRichText);
  ppUnRegisterComponent(TppDBCalc);
  ppUnRegisterComponent(TppDBImage);
  ppUnRegisterComponent(TppDBBarCode);
  ppUnRegisterComponent(TppDB2DBarcode);

  ppUnRegisterComponent(TppRegion);
  ppUnRegisterComponent(TppSubReport);

  UnRegisterClass(TppCalc);

  raUnRegisterRTTI(TraTppCustomReportRTTI);
  raUnRegisterRTTI(TraTppBandRTTI);
  raUnRegisterRTTI(TraTppGroupRTTI);
  raUnRegisterRTTI(TraTppComponentRTTI);

end.
