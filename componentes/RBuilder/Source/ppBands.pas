{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppBands;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes,
  SysUtils,
  Graphics,
                                       
  ppComm,
  ppClass,
  ppTypes,
  ppDevice,
  ppDB,
  ppStrtch,
  ppRTTI,
  ppEnum,
  ppUtils;

type

  TppDetailBand = class;
  TppBandBackgroundSettings = class;
  TppColumnTraversalType = (ctTopToBottom, ctLeftToRight);

  {@TppCustomBand
  
    This class implements the basic printing behavior of a band.}

  {@TppCustomBand.Count

    Counts the number of times the band has appeared on the current page.  For
    the detail band, this property resets to zero each time any group in the
    report breaks.}

  {@TppCustomBand.OverFlow

    Run-time and read-only. Indicates that a stretching component (Memo,
    RichText, SubReport, etc) contained within the band has started printing and
    is out of vertical space.

    Note: If you are performing calculations or manually traversing data in the
    BeforePrint or AfterPrint event of a band, it is usually best to check the
    value of the OverFlow property, otherwise calculations can become overstated
    and data can be skipped.}

  TppCustomBand = class(TppBand)
    private
      FAllObjectsPrinted: Boolean;
      FCalcList: TList;
      FCount: Integer;
      FCurrentPartialAdjustment: Integer;
      FCurrentPosition: Integer;
      FDrawCommands: TList;
      FGenerating: Boolean;
      FGenerationComplete: Boolean;
      FMaxStretchable: TppStretchable;
      FObjectListIndex: Integer;
      FObjectLists: TStringList;
      FObjectListSaved: Boolean;
      FObjectIndex: Integer;
      FObjectOverFlow: Boolean;
      FObjectSaved: Boolean;
      FOverFlow: Boolean;
      FOutOfSpace: Boolean;
      FPageBottom: Integer;
      FPartialGeneration: Boolean;
      FPartialAdjustment: Integer;
      FPrintingSection: Boolean;
      FPrintPosRect: TppRect;
      FPrintPositionBreak: Boolean;
      FSpaceUsed: Integer;
      FStartingPosition: Integer;

      FCumulativeCurrentPosition: Integer;
      FMaxStretchablePosition: Integer;

      FStatics: TList;
      FStretchables: TList;
      FStretchers: TList;
      FShifters: TList;
      FPrintQueue: TStringList;

      {print routines}
      procedure BuildCalcList;
      function  GetCurrentObject: TppComponent;
      procedure CategorizeObjects;
      function  CheckForEndOfGeneration: Boolean;
      procedure FreeLists;
      procedure GenerateObjects(aListIndex, aObjectIndex: Integer);
      procedure ProcessQueue(aQueue: TList; aObjectIndex: Integer);
      procedure Print(aPage: TppPage);
      procedure ResetObjects;

      procedure IncrementCurrentPosition(aObject: TppComponent);
      procedure SaveOverFlowObject(aObject: TppComponent; aObjectIndex: Integer);
      procedure CompleteSection(aObject: TppComponent; aObjectIndex: Integer; aQueue: TList);

    protected
      function GetPropUserName: TComponentName; override;
      
      procedure AdjustStartingPosition; virtual;
      procedure AfterGenerate; virtual;
      procedure AfterPrint; virtual;
      procedure AfterObjectGenerate; virtual;
      procedure BeforeGenerate; virtual;
      procedure BeforeObjectGenerate; virtual;
      procedure BeforePrint; virtual;
      procedure CalcPrintPosition; virtual;
      procedure CreateDrawCommand(aPage: TppPage); virtual;
      function  CanAdvanceData: Boolean; virtual;
      procedure UpdatePrintPosition; virtual;

      function GetAllObjectsPrinted: Boolean; virtual;
      function GetCount: Integer; virtual;
      function GetCurrentPosition: Integer; virtual;
      function GetCumulativeCurrentPosition: Integer; virtual;
      function GetDrawCommands: TList; virtual;
      function GetGenerating: Boolean; virtual;
      function GetGenerationComplete: Boolean; virtual;
      function GetMaxStretchable: TppStretchable; virtual;
      function GetObjectListIndex: Integer; virtual;
      function GetObjectIndex: Integer; virtual;
      function GetOutOfSpace: Boolean; virtual;
      function GetOverFlow: Boolean; virtual;
      function GetPageBottom: Integer; virtual;
      function GetPartialGeneration: Boolean; virtual;
      function GetPartialAdjustment: Integer; virtual;
      function GetPrintingSection: Boolean; virtual;
      function GetPrintPositionBreak: Boolean; virtual;
      function GetPrintPosRect: TppRect; virtual;
      function GetSpaceUsed: Integer; virtual;
      function GetStartingPosition: Integer; virtual;

      procedure SetAllObjectsPrinted(aValue: Boolean); virtual;
      procedure SetCount(aValue: Integer); virtual;
      procedure SetCurrentPosition(aValue: Integer); virtual;
      procedure SetCumulativeCurrentPosition(aValue: Integer); virtual;
      procedure SetDrawCommands(aValue: TList); virtual;
      procedure SetGenerating(aValue: Boolean); virtual;
      procedure SetGenerationComplete(aValue: Boolean); virtual;
      procedure SetMaxStretchable(aStretchable: TppStretchable); virtual;
      procedure SetObjectListIndex(aValue: Integer); virtual;
      procedure SetObjectIndex(aValue: Integer); virtual;
      procedure SetOutOfSpace(aValue: Boolean); virtual;
      procedure SetOverFlow(aValue: Boolean); virtual;
      procedure SetPageBottom(aValue: Integer); virtual;
      procedure SetPartialGeneration(aValue: Boolean); virtual;
      procedure SetPartialAdjustment(aValue: Integer); virtual;
      procedure SetPrintingSection(aValue: Boolean); virtual;
      procedure SetPrintPositionBreak(aValue: Boolean); virtual;
      procedure SetPrintPosRect(aRect: TppRect); virtual;
      procedure SetSpaceUsed(aValue: Integer); virtual;
      procedure SetStartingPosition(aValue: Integer); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure Generate; override;
      procedure Init; override;
      procedure PageStart; override;
      procedure RestoreFromCache(aAbsolutePageNo: Integer); override;
      procedure SaveToCache(aAbsolutePageNo: Integer); override;

      property AllObjectsPrinted: Boolean read GetAllObjectsPrinted write SetAllObjectsPrinted;
      property Count: Integer read GetCount write SetCount;
      property CurrentObject: TppComponent read GetCurrentObject;
      property CurrentPosition: Integer read GetCurrentPosition write SetCurrentPosition;
      property CumulativeCurrentPosition: Integer read GetCumulativeCurrentPosition write SetCumulativeCurrentPosition;
      property DrawCommands: TList read GetDrawCommands write SetDrawCommands;
      property Generating: Boolean read GetGenerating write SetGenerating;
      property GenerationComplete: Boolean read GetGenerationComplete write SetGenerationComplete;
      property MaxStretchable: TppStretchable read GetMaxStretchable write SetMaxStretchable;
      property ObjectListIndex: Integer read GetObjectListIndex write SetObjectListIndex;
      property ObjectIndex: Integer read GetObjectIndex write SetObjectIndex;
      property OutOfSpace: Boolean read GetOutOfSpace write SetOutOfSpace;
      property OverFlow: Boolean read GetOverFlow write SetOverFlow;
      property PageBottom: Integer read GetPageBottom write SetPageBottom;
      property PartialGeneration: Boolean read GetPartialGeneration write SetPartialGeneration;
      property PartialAdjustment: Integer read GetPartialAdjustment write SetPartialAdjustment;
      property PrintingSection: Boolean read GetPrintingSection write SetPrintingSection;
      property PrintPositionBreak: Boolean read GetPrintPositionBreak write SetPrintPositionBreak;
      property PrintPosRect: TppRect read GetPrintPosRect write SetPrintPosRect;
      property SpaceUsed: Integer read GetSpaceUsed write SetSpaceUsed;
      property StartingPosition: Integer read GetStartingPosition write SetStartingPosition;

  end; {class, TppCustomBand}


  {@TppBasicBand

    The base class for bands which are assigned to reports via a Report
    property.}

  TppBasicBand = class(TppCustomBand)
    public
      destructor Destroy; override;

      function GetDescription: String; override;

  end; {class, TppBasicBand}

  
  {@TppDetailBand

    The detail band prints multiple times on the page until all page space
    is utilized or an ending condition is detected.  The most common ending
    condition is that the last record of the DataPipeline has been reached.
    Tip: When manually traversing data, call the DataTraversalCompleted
    method of a report to force an ending condition.}

  {@TppDetailBand.BandsPerRecord

    When utilizing the BandsPerRecord property, this property indicates the
    number of times the detail band has printed for the current record.}

  {@TppDetailBand.BandsPerRecordCount

    When utilizing the BandsPerRecord property, this property indicates the
    number of times the detail band has printed for the current record.}

  {@TppDetailBand.ColumnTraversal

    When the Columns property of the report has been set to more than one, then
    ColumnTraversal determines how the detail band will print on the page.  The
    possible value are:

    <Table>
    Value	              Meaning
    ----------------------------
    ctTopToBottom	      This is the default. The detail band prints column one
                        to the bottom of the page, then begins at the top of
                        column two and prints to the bottom of the page,
                        continuing until all columns have been printed or all
                        records have been traversed.
    ctLeftToRight	      The detail band prints the first record in column one,
                        the second in column two, the third in column three and
                        so on, until all columns have been printed. It then
                        proceeds to the next 'row' in column one, continuing
                        until the page is completed or all records have been
                        traversed.
    </Table>

    Note: When you use the ctLeftToRightSetting, the DetailBand will
    automatically switch to a PrintHeight of phStatic. DynamicHeight detail
    bands cannot be used with this setting.}

  {@TppDetailBand.Background1

    Background settings for each odd detail band printed.  Use this property in
    conjunction with Background2 to easily display alternating background colors
    for each detail band printed.}

  {@TppDetailBand.Background2

    Background settings for each even detail band printed.  Use this property in
    conjunction with Background1 to easily display alternating background colors
    for each detail band printed.}

  TppDetailBand = class(TppBasicBand)
    private
      FBackground1: TppBandBackgroundSettings;
      FBackground2: TppBandBackgroundSettings;
      FBandEngine: TppCommunicator;
      FBandsPerRecord: Integer;
      FColumnTraversal: TppColumnTraversalType;

      {retained for backward compatibility (deprecated as of 5.02)}
      FDataPipeline: TppDataPipeline;
      FDataPipelineName: String;

      {used for conversion to 3.0}
      FDataSource: String;

      {retained for backward compatibility (deprecated as of 5.02)}
      procedure ReadDataPipeline(Reader: TReader);
      procedure WriteDataPipeline(Writer: TWriter);

      {used for conversion to 3.0}
      procedure ReadDataSource(Reader: TReader);
      procedure ReadNoRecordsAction(Reader: TReader);
      procedure ReadSkipWhenNoRecords(Reader: TReader);

      procedure DumpCache;
      function  GetBandsPerRecordCount: Integer;
      function  CreateBGDrawCommand(aCount: Integer): TppDrawCommand;
      procedure UpdateParentDataPipeline(aNewDataPipeline, aOldDataPipeline: TppDataPipeline);
      procedure SetBandsPerRecord(aValue: Integer);
      procedure SetColumnTraversal(aValue: TppColumnTraversalType);
      procedure SetDataPipeline(aDataPipeline: TppDataPipeline);
      procedure SetBackground1(aBackground1: TppBandBackgroundSettings);
      procedure SetBackground2(aBackground2: TppBandBackgroundSettings);

      procedure BandEngineBeforePrintEvent(Sender: TObject);
      procedure BandEngineAfterPrintEvent(Sender: TObject);
      procedure BandEngineBeforeGenerateEvent(Sender: TObject);
      procedure BandEngineAfterGenerateEvent(Sender: TObject);
      procedure BandEngineOnCreateDrawCommand(Sender: TObject);


    protected
      procedure DefineProperties(Filer: TFiler); override;
      procedure ReadState(Reader: TReader); override;

      function  GetDefaultPrintTimes: TppPrintTimesType; override;
      function  GetPrintCondition: TppPrintConditions; override;
      function  GetRank: String; override;
      function  GetPropUserName: TComponentName; override;
      procedure SetPrintHeight(aPrintHeight: TppPrintHeightType); override;

      function GetAllObjectsPrinted: Boolean; override;
      function GetCount: Integer; override;
      function GetCurrentPosition: Integer; override;
      function GetCumulativeCurrentPosition: Integer; override;
      function GetGenerating: Boolean; override;
      function GetGenerationComplete: Boolean; override;
      function GetMaxStretchable: TppStretchable; override;
      function GetObjectListIndex: Integer; override;
      function GetObjectIndex: Integer; override;
      function GetOutOfSpace: Boolean; override;
      function GetOverFlow: Boolean; override;
      function GetPageBottom: Integer; override;
      function GetPartialGeneration: Boolean; override;
      function GetPartialAdjustment: Integer; override;
      function GetPrintingSection: Boolean; override;
      function GetPrintPositionBreak: Boolean; override;
      function GetPrintPosRect: TppRect; override;
      function GetSpaceUsed: Integer; override;
      function GetStartingPosition: Integer; override;

      procedure SetAllObjectsPrinted(aValue: Boolean); override;
      procedure SetCount(aValue: Integer); override;
      procedure SetCurrentPosition(aValue: Integer); override;
      procedure SetCumulativeCurrentPosition(aValue: Integer); override;
      procedure SetGenerating(aValue: Boolean); override;
      procedure SetGenerationComplete(aValue: Boolean); override;
      procedure SetMaxStretchable(aStretchable: TppStretchable); override;
      procedure SetObjectListIndex(aValue: Integer); override;
      procedure SetObjectIndex(aValue: Integer); override;
      procedure SetOutOfSpace(aValue: Boolean); override;
      procedure SetOverFlow(aValue: Boolean); override;
      procedure SetPageBottom(aValue: Integer); override;
      procedure SetPartialGeneration(aValue: Boolean); override;
      procedure SetPartialAdjustment(aValue: Integer); override;
      procedure SetPrintingSection(aValue: Boolean); override;
      procedure SetPrintPositionBreak(aValue: Boolean); override;
      procedure SetPrintPosRect(aRect: TppRect); override;
      procedure SetSpaceUsed(aValue: Integer); override;
      procedure SetStartingPosition(aValue: Integer); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String); override;
      procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); override;

      function GetADataPipeline: TppDataPipeline; override;
      function IsDataAware: Boolean; override;

      { Band }
      procedure FinishPage; override;

      { CustomBand }
      procedure Generate; override;
      procedure Init; override;
      procedure RestoreFromCache(aAbsolutePageNo: Integer); override;
      procedure SaveToCache(aAbsolutePageNo: Integer); override;

      property BandsPerRecordCount: Integer read GetBandsPerRecordCount;

      {retained for backward compatibility (deprecated as of 5.02)}
      property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline;

      {used for conversion to 3.0}
      procedure Convert(aVersionNo: Integer); override;
      property DataSource: String read FDataSource;

    published
      property Background1: TppBandBackgroundSettings read FBackground1 write SetBackground1;
      property Background2: TppBandBackgroundSettings read FBackground2 write SetBackground2;
      property BandsPerRecord: Integer read FBandsPerRecord write SetBandsPerRecord default 1;
      property BottomOffset stored False;
      property ColumnTraversal: TppColumnTraversalType read FColumnTraversal write SetColumnTraversal default ctTopToBottom;
      property PrintCount;
      property PrintHeight;
      property PrintPosition stored False;

  end; {class, TppDetailBand}

  {@TppPageBand

    Base class for bands that appear once per page.}

  {@TppPageBand.PrintOnFirstPage

    Determines whether the header or footer band is printed on the first page of
    the report.}

  {@TppPageBand.PrintOnLastPage

    Determines whether the header or footer band is printed on the last page of
    the report.}

  TppPageBand = class(TppBasicBand)
  private
    FPrintOnFirstPage: Boolean;
    FPrintOnLastPage: Boolean;

    procedure SetPrintOnFirstPage(Value: Boolean);
    procedure SetPrintOnLastPage(Value: Boolean);

  protected
    procedure BeforeGenerate; override;

  public
    constructor Create(aOwner: TComponent); override;

    function  IsColumnar: Boolean; override;

    property PrintOnFirstPage: Boolean read FPrintOnFirstPage write SetPrintOnFirstPage default True;
    property PrintOnLastPage: Boolean read FPrintOnLastPage write SetPrintOnLastPage default True;

  end; {class, TppPageBand}


  {@TppHeaderBand

    If you need the first page of a report to contain additional information,
    create a TppTitleBand.}

  TppHeaderBand = class(TppPageBand)
  protected
    function  GetPrintCondition: TppPrintConditions; override;

  protected
    function  CanAdvanceData: Boolean; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;

  public
    constructor Create(aOwner: TComponent); override;

  published
     property BottomOffset stored False;
     property PrintHeight;
     property PrintOnFirstPage;
     property PrintOnLastPage;
     property PrintPosition stored False;

  end; {class, TppHeaderBand}


  {@TppFooterBand

    The footer band prints at the bottom of each page.

    If you need the last page of a report to contain additional information,
    create a TppSummaryBand.}

  TppFooterBand = class(TppPageBand)
  private

  protected
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;
    procedure SetPrintHeight(aPrintHeight: TppPrintHeightType); override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure CalcPrintPosition; override;

  published
     property PrintHeight default phStatic; {footers are always static}
     property PrintOnFirstPage;
     property PrintOnLastPage;

  end; {class, TppFooterBand}


  {@TppReportBand

    Base class for bands that appear once per report.}

  {@TppReportBand.NewPage

    Use this property when you want to print the summary or title band on a
    separate page.}

  TppReportBand = class(TppBasicBand)
  private
    FAlreadyPageBreak: Boolean;
    FNewPage: Boolean;
    procedure SetNewPage(Value: Boolean);

  protected

    property AlreadyPageBreak: Boolean read FAlreadyPageBreak write FAlreadyPageBreak;

  public
    constructor Create(aOwner: TComponent); override;
                                  
    procedure Init; override;
    function  IsColumnar: Boolean; override;
    procedure RestoreFromCache(aAbsolutePageNo: Integer); override;
    procedure SaveToCache(aAbsolutePageNo: Integer); override;

  published
    property BottomOffset stored False;
    property NewPage: Boolean read FNewPage write SetNewPage default False;
    property PrintHeight;
    property PrintPosition stored False;

  end; {class, TppReportBand}


  {@TppTitleBand

    The title band prints at once at the beginning of the report.}

  TppTitleBand = class(TppReportBand)
  private

  protected
    procedure AfterGenerate; override;
    procedure BeforeGenerate; override;
    function  CanAdvanceData: Boolean; override;
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;

  public
    constructor Create(aOwner: TComponent); override;

  end; {class, TppTitleBand}


  {@TppSummaryBand

    The summary band prints at once at the end of the report.}

  {@TppSummaryBand.AlignToBottom

    Determines whether the summary is aligned to the bottom of the page.

    When FooterBand.Visible and PrintOnLastPage are true, setting AlignToBottom
    to true, results in the summary appearing just above the footer. Otherwise,
    when no footer is present, the summary will apear at the bottom of the page.

    Defaults to False.}


  TppSummaryBand = class(TppReportBand)
  private
    FAlignToBottom: Boolean;

    procedure SetAlignToBottom(aAlignToBottom: Boolean);

  protected
    procedure AfterPrint; override;
    procedure BeforeGenerate; override;
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure CalcPrintPosition; override;
    procedure FinishPage; override;

  published
    property AlignToBottom: Boolean read FAlignToBottom write SetAlignToBottom;

  end; {class, TppSummaryBand}


  {@TppColumnHeaderBand

    The column header band prints at the top of each column.

    Column headers and column footers are automatically created by the
    Report Designer when a  TppReport component's columns property is set
    to a value greater than 1.}

  TppColumnHeaderBand = class(TppBasicBand)
  private

  protected
    function  CanAdvanceData: Boolean; override;
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;

  public
    constructor Create(aOwner: TComponent); override;

  published
    property BottomOffset stored False;
    property PrintPosition stored False;
    property PrintHeight;

  end; {class, TppColumnHeaderBand}


  {@TppColumnFooterBand

    The column footer band prints at the bottom of each column.

    Column headers and column footers are automatically created by the
    Report Designer when a TppReport component's columns property is set to
    a value greater than 1.}

  TppColumnFooterBand = class(TppBasicBand)
  private

  protected
    procedure AfterObjectGenerate; override;
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;
    procedure SetPrintHeight(aPrintHeight: TppPrintHeightType); override;

  public
    constructor Create(aOwner: TComponent); override;

    procedure CalcPrintPosition; override;

  published
     property PrintHeight default phStatic; {footers are always static}

  end; {class, TppColumnFooterBand}


  {@TppGroupBand

    This base class implements functionality required to attach a band to a
    group.}

  {@TppGroupBand.Group

    Run-time only.  The Group property of a group band is assigned implicitly
    at design time when you create a group. At run-time you can explicitly
    assign a group component to a group band by setting the band's Group
    property.}

  TppGroupBand = class(TppCustomBand)
  private
    FGeneration: Boolean;
    FSaveGeneration: Boolean;
    FGroup: TppGroup;

  protected
    procedure SetGroup(aGroup: TppGroup); virtual;

    procedure PropertyChange; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function  GetParentComponent: TComponent; override;
    function  GetDescription: String; override;
    procedure GroupChanged; virtual;
    procedure Init; override;
    procedure RestoreFromCache(aAbsolutePageNo: Integer); override;
    procedure SaveToCache(aAbsolutePageNo: Integer); override;
    procedure SetParentComponent(Value: TComponent); override;

    property Description: String read GetDescription;
    property Generation: Boolean read FGeneration write FGeneration stored False;
    property Group: TppGroup read FGroup write SetGroup stored False;
    property SaveGeneration: Boolean read FSaveGeneration write FSaveGeneration;

  published
    property BottomOffset stored False;
    property PrintHeight;
    property PrintPosition stored False;

  end; {class, TppGroupBand}

  
  {@TppGroupHeaderBand

    The group header band prints before a group break occurs.}

  TppGroupHeaderBand = class(TppGroupBand)
  private
    FAlreadyColumnBreak: Boolean;
    FAlreadyPageBreak: Boolean;
    FPageFooterVisible: Boolean;
    FPageHeaderVisible: Boolean;
    FPageStyleVisible: Boolean;

  private
    procedure ProcessNewFile;
    procedure ProcessEmailFile(aBreakvalue: string);

  protected
    procedure AfterPrint; override;
    procedure BeforePrint; override;
    procedure BeforeGenerate; override;
    procedure BeforeObjectGenerate; override;
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    procedure SavePageBandState;
    procedure RestorePageBandState;
    procedure SetPageBandVisible(aValue: Boolean);

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Init; override;
    procedure PageStart; override;
    procedure RestoreFromCache(aAbsolutePageNo: Integer); override;
    procedure SaveToCache(aAbsolutePageNo: Integer); override;
    procedure SetGroup(aGroup: TppGroup); override;

    property AlreadyPageBreak: Boolean read FAlreadyPageBreak write FAlreadyPageBreak;

  end; {class, TppGroupHeaderBand}


  {@TppGroupFooterBand

    The group footer band prints after a group break occurs.}

  {@TppGroupFooterBand.HideWhenOneDetail

    Set this property to True to hide the GroupFooterBand if there are one or
    less detail records associated with the generating group.  This can be
    helpful if a total is being calculated in the GroupFooterBand and duplicate
    or 0 values are unnecessary.}

  TppGroupFooterBand = class(TppGroupBand)
    private
      FHideWhenOneDetail: Boolean;

    protected
      procedure AfterGenerate; override;
      procedure AfterPrint; override;
      procedure BeforeGenerate; override;
      procedure BeforeObjectGenerate; override;
      procedure BeforePrint; override;
      function  GetPrintCondition: TppPrintConditions; override;
      function  GetRank: String; override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;

      procedure SetGroup(aGroup: TppGroup); override;

  published
      property HideWhenOneDetail: Boolean read FHideWhenOneDetail write FHideWhenOneDetail;

  end; {class, TppGroupFooterBand}


  {@TppPageStyle

    The page style prints once for each page. The PageStyle is always
    printed as the bottomost layer of the page and does not use any space
    on the page (as do the other band types).  Page styles are usually
    sized to the printable area of the page and filled with components that
    represent formatting to appear on each page.  This is usually done in
    order to emulate forms.}

  {@TppPageStyle.EndPage

    When the PageSetting is set on PageRange, the page style will print only on
    the pages in the range defined by the StartPage and EndPage properties.}

  {@TppPageStyle.PageList

    When the PageSetting is set on PageList, the page style will print only
    on the pages that appear in this list.}

  {@TppPageStyle.PageSetting

    The PageSetting property determines which pages the page style will appear
    on. These are the possible values:

    <Table>
    Value	         Meaning
    ------------   --------
    psAll	         The page style appears on all pages.
    psFirst	       The page style appears on the first page only.
    psLast	       The page style appears on the last page only.
    psPageList	   The page style appears on the pages listed in the PageList or ValidPages properties.
    psPageRange	   The page style appears on the pages in the range specified by the StartPage and EndPage properties.
    psSinglePage   The page style appears on the page specified in the SinglePage property.
    </Table>}

  {@TppPageStyle.SinglePage

    When the PageSetting is set on SinglePage, the page style will print 
    only on the page specified in the SinglePage property.}

  {@TppPageStyle.StartPage

    When the PageSetting is set on PageRange, the page style will print 
    only on the pages in the range defined by the StartPage and EndPage
    properties.}

  {@TppPageStyle.ValidPages

    When the PageSetting is set on PageList, the page style will print only 
    on the pages that appear in this list.  This list can take a more
    flexible and user-friendly format than the PageList property (i.e. you
    can specify the pages as 1, 2, 3-5, 7 in Valid Pages, whereas PageList
    requires a single page number in each line).}

  TppPageStyle = class(TppBasicBand)
  private
    FDataPipeline: TppDataPipeline;
    FEndPage: Integer;
    FPageList: TStrings;
    FPageSetting: TppPageSettingType;
    FSavePrintPos: TppRect;
    FSinglePage: Integer;
    FStartPage: Integer;
    FTraverseData: Boolean;
    FValidPages: String;

    function  GetPageList: TStrings;
    procedure SetEndPage(aPageNo: Integer);
    procedure SetPageList(aPageList: TStrings);
    procedure SetPageSetting(aPageSetting: TppPageSettingType);
    procedure SetSinglePage(aPageNo: Integer);
    procedure SetStartPage(aPageNo: Integer);
    procedure SetValidPages(Value: String);
    procedure UpdateParentDataPipeline(aNewDataPipeline, aOldDataPipeline: TppDataPipeline);

  protected
    procedure AdjustStartingPosition; override;
    procedure AfterPrint; override;
    procedure AfterObjectGenerate; override;
    procedure BeforeObjectGenerate; override;
    procedure BeforePrint; override;
    function  CanAdvanceData: Boolean; override;
    function  GetDefaultPrintTimes: TppPrintTimesType; override;
    function  GetPrintCondition: TppPrintConditions; override;
    function  GetRank: String; override;
    function  GetPropUserName: TComponentName; override;
    procedure SetDataPipeline(aDataPipeline: TppDataPipeline);

    property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    procedure CalcPrintPosition; override;
    function  GetADataPipeline: TppDataPipeline; override;
    procedure Init; override;
    function  IsColumnar: Boolean; override;
    function  IsDataAware: Boolean; override;

    function  IsActive: Boolean;
    
  published
    property EndPage: Integer read FEndPage write SetEndPage;
    property PageList: TStrings read GetPageList write SetPageList;
    property PageSetting: TppPageSettingType read FPageSetting write SetPageSetting default psAll;
    property SinglePage: Integer read FSinglePage write SetSinglePage;
    property StartPage: Integer read FStartPage write SetStartPage;
    property ValidPages: String read FValidPages write SetValidPages;

  end; {class, TppPageStyle}

  {@TppBandBackgroundSettings

    The TppBandBackgroundSettings object defines the background color or
    gradient fill effect of an entire report band.}

  {@TppBandBackgroundSettings.Brush

    TBrush object to be used to fill the background of an entire band.}

  {@TppBandBackgroundSettings.Gradient

    TppGradient object to be used to fill the background of an entire band with
    a gradient effect.  If the Gradient.Style is not gsNone, the Brush property
    is ignored.}

  TppBandBackgroundSettings = class(TPersistent)
  private
    FBrush: TBrush;
    FGradient: TppGradient;
    FOwner: TComponent;

    procedure SetBrush(const Value: TBrush);
    procedure SetGradient(const Value: TppGradient);

  public
    constructor Create(aOwner: TComponent); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property Brush: TBrush read FBrush write SetBrush;
    property Gradient: TppGradient read FGradient write SetGradient;

  end;

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppCustomBandRTTI }
  TraTppCustomBandRTTI = class(TraTppBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppCustomBandRTTI}

  {@TraTppPageBandRTTI }
  TraTppPageBandRTTI = class(TraTppCustomBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppPageBandRTTI}

  {@TraTppReportBandRTTI }
  TraTppReportBandRTTI = class(TraTppCustomBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppPageBandRTTI}

  {@TraTppFooterBandRTTI }
  TraTppFooterBandRTTI = class(TraTppPageBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppFooterBandRTTI}

  {@TraTppDetailBandRTTI }
  TraTppDetailBandRTTI = class(TraTppCustomBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDetailBandRTTI}

  {@TraTppColumnFooterBandRTTI }
  TraTppColumnFooterBandRTTI = class(TraTppCustomBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppColumnFooterBandRTTI}

  {@TraTppGroupBandRTTI }
  TraTppGroupBandRTTI = class(TraTppCustomBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppGroupBandRTTI}

  {@TraTppGroupHeaderBandRTTI }
  TraTppGroupHeaderBandRTTI = class(TraTppGroupBandRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppGroupHeaderBandRTTI}


implementation

uses
  ExtCtrls,
  ppCtrls, ppReport, ppSubRpt, ppEmailSettings, ppDrwCmd,
  ppBandEngine, ppDetailBandEngine, ppVerticalBandEngine, ppHorizontalBandEngine;


{******************************************************************************
 *
 **  B A S I C  B A N D
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppBasicBand.Destroy}

destructor TppBasicBand.Destroy;
begin

  {remove band from associated report}
  if (Report <> nil) then
    Report.RemoveBand(Self);

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppBasicBand.GetDescription }

function TppBasicBand.GetDescription: String;
begin

  Result := ppLoadStr(CaptionIndex);

end; {function, GetDescription}

{******************************************************************************
 *
 **  P A G E  B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageBand.Create }

constructor TppPageBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  FPrintOnFirstPage := True;
  FPrintOnLastPage := True;

end; {constructor, TppPageBand}

{------------------------------------------------------------------------------}
{ TppPageBand.IsColumnar }

function TppPageBand.IsColumnar: Boolean;
begin
  Result := False;
end; {function, IsColumnar}

{------------------------------------------------------------------------------}
{ TppPageBand.BeforeGenerate }

procedure TppPageBand.BeforeGenerate;
begin

  if (Report = nil) or (Report.Engine = nil) then
    GenerationComplete := True

  else if not(FPrintOnFirstPage) and (Report.Engine.AbsolutePageNo = 1) then
    GenerationComplete := True

  else if not(FPrintOnLastPage) and (esFirstPass in Report.Engine.State) and
         ((Report.Engine.LastBandGenerated) or (esPrintingSummary in Report.Engine.State)) then
    GenerationComplete := True

  else if not(FPrintOnLastPage) and (esSecondPass in Report.Engine.State) and
         (Report.Engine.AbsolutePageNo = Report.Engine.AbsolutePageCount) then
    GenerationComplete := True;

end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppPageBand.SetPrintOnFirstPage }

procedure TppPageBand.SetPrintOnFirstPage(Value: Boolean);
begin

  if (Report <> nil) and (FPrintOnFirstPage <> Value) then
    begin
      FPrintOnFirstPage := Value;
      Report.Reset;
      PropertyChange;
    end;

end; {procedure, SetPrintOnFirstPage}

{------------------------------------------------------------------------------}
{ TppPageBand.SetPrintOnLastPage }

procedure TppPageBand.SetPrintOnLastPage(Value: Boolean);
begin

  if (Report <> nil) and (FPrintOnLastPage <> Value) then
    begin
      FPrintOnLastPage := Value;
      Report.Reset;
      PropertyChange;
    end;

end; {procedure, SetPrintOnLastPage}


{******************************************************************************
 *
 **  H E A D E R   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppHeaderBand.Create }

constructor TppHeaderBand.Create(aOwner : TComponent);
begin

  inherited Create(aOwner);

  CaptionIndex := 193;

end; {constructor, TppHeaderBand}

{------------------------------------------------------------------------------}
{ TppHeaderBand.GetPropUserName }

function TppHeaderBand.GetPropUserName: TComponentName;
begin
  Result := 'Header'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppHeaderBand.GetRank }

function TppHeaderBand.GetRank: String;
begin
  Result := Format('%8d',[2]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppHeaderBand.GetPrintCondition }

function TppHeaderBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcStartOfPage];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppHeaderBand.CanAdvanceData }

function TppHeaderBand.CanAdvanceData: Boolean;
begin
  Result := True;
end; {function, CanAdvanceData}

{******************************************************************************
 *
 **  F O O T E R   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFooterBand.Create}

constructor TppFooterBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  CaptionIndex := 190;
  
  {footers are always static}
  PrintHeight := phStatic;

end; {constructor, TppFooterBand}

{------------------------------------------------------------------------------}
{ TppFooterBand.GetPropUserName }

function TppFooterBand.GetPropUserName: TComponentName;
begin
  Result := 'Footer'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppFooterBand.GetRank }

function TppFooterBand.GetRank: String;
begin
  Result := Format('%8d',[8]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppFooterBand.GetPrintCondition }

function TppFooterBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcEndOfPage];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppFooterBand.CalcPrintPosition }

procedure TppFooterBand.CalcPrintPosition;
var
  lRect: TppRect;
begin

  PageBottom :=  Report.Engine.Page.PageDef.mmHeight - Report.Engine.Page.PageDef.mmMarginBottom;
  StartingPosition := PageBottom - mmHeight;

  lRect.Left := Report.Engine.PrintPosRect.Left;
  lRect.Top := StartingPosition;
  lRect.Right := Report.Engine.PrintPosRect.Right;
  lRect.Bottom := StartingPosition + mmHeight;

  PrintPosRect := lRect;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppFooterBand.SetPrintHeight}

procedure TppFooterBand.SetPrintHeight(aPrintHeight: TppPrintHeightType);
begin
 {do nothing, footer is always static}
end;

{******************************************************************************
 *
 **  R E P O R T   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportBand.Create}

constructor TppReportBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppReportBandSaveRec);

  FAlreadyPageBreak := False;
  FNewPage := False;

end; {constructor, TppReportBand}

{------------------------------------------------------------------------------}
{ TppReportBand.IsColumnar }

function TppReportBand.IsColumnar: Boolean;
begin
  Result := False;
end; {function, IsColumnar}

{------------------------------------------------------------------------------}
{ TppReportBand.RestoreFromCache }

procedure TppReportBand.RestoreFromCache(aAbsolutePageNo: Integer);
var
  lRec: TppReportBandSaveRec;
begin

  ReadRecordFromCache(aAbsolutePageNo, lRec);

  FObjectIndex       := lRec.FObjectIndex;
  FObjectListIndex   := lRec.FObjectListIndex;
  FOverFlow          := lRec.FOverFlow;
  FPartialGeneration := lRec.FPartialGeneration;
  FPartialAdjustment := lRec.FPartialAdjustment;

  FAlreadyPageBreak    := lRec.FAlreadyPageBreak;
  FPrintPositionBreak  := lRec.FPrintPositionBreak;
  FPrintingSection     := lRec.FPrintingSection;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppReportBand.SaveToCache }

procedure TppReportBand.SaveToCache(aAbsolutePageNo: Integer);
var
  lRec: TppReportBandSaveRec;
begin

  lRec.FObjectIndex       := FObjectIndex;
  lRec.FObjectListIndex   := FObjectListIndex;
  lRec.FOverFlow          := FOverFlow;
  lRec.FPartialGeneration := FPartialGeneration;
  lRec.FPartialAdjustment := FPartialAdjustment;

  lRec.FAlreadyPageBreak    := FAlreadyPageBreak;
  lRec.FPrintPositionBreak  := FPrintPositionBreak;
  lRec.FPrintingSection     := FPrintingSection;

  WriteRecordToCache(aAbsolutePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppReportBand.Init }

procedure TppReportBand.Init;
begin
  inherited Init;

  FAlreadyPageBreak := False;
end; {procedure, Init}


{------------------------------------------------------------------------------}
{ TppReportBand.SetNewPage }

procedure TppReportBand.SetNewPage(Value: Boolean);
begin

  if (Report <> nil) and (FNewPage <> Value) then
    begin
      FNewPage := Value;

      {notify report designer}
      PropertyChange;

      {notify report engine}
      Report.Reset;
    end;

end; {procedure, SetNewPage}


{******************************************************************************
 *
 **  T I T L E   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTitleBand.Create}

constructor TppTitleBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  CaptionIndex := 195;

end; {constructor, TppTitleBand}

{------------------------------------------------------------------------------}
{ TppTitleBand.GetPropUserName }

function TppTitleBand.GetPropUserName: TComponentName;
begin
  Result := 'Title'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppTitleBand.GetRank }

function TppTitleBand.GetRank: String;
begin
  Result := Format('%8d',[1]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppTitleBand.GetPrintCondition }

function TppTitleBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcStartOfReport];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppTitleBand.CanAdvanceData }

function TppTitleBand.CanAdvanceData: Boolean;
begin
  Result := True;
end; {function, CanAdvanceData}

{------------------------------------------------------------------------------}
{ TppTitleBand.BeforeGenerate }

procedure TppTitleBand.BeforeGenerate;
begin

  if NewPage and Visible then
    begin

      if AlreadyPageBreak then
        begin
          GenerationComplete := True;

          Report.Engine.ESExclude([esPrintingTitle]);
        end

      else
        Report.Engine.ESInclude([esPrintingTitle]);

    end

  else
    Report.Engine.ESInclude([esPrintingTitle]);

end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppTitleBand.AfterGenerate }

procedure TppTitleBand.AfterGenerate;
begin

  if NewPage and Visible then
    begin
    
      if not(AlreadyPageBreak) then
        begin
          AlreadyPageBreak := True;

          if Visible then
            OutOfSpace := True;
        end

      else
        Report.Engine.ESExclude([esPrintingTitle]);

    end

  else
    Report.Engine.ESExclude([esPrintingTitle]);

  inherited AfterGenerate;

end; {procedure, AfterGenerate}

{******************************************************************************
 *
 **  S U M M A R Y   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSummaryBand.Create }

constructor TppSummaryBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  CaptionIndex := 194;
  AlignToBottom := False;

end; {constructor, TppSummaryBand}

{------------------------------------------------------------------------------}
{ TppSummaryBand.GetPropUserName }

function TppSummaryBand.GetPropUserName: TComponentName;
begin
  Result := 'Summary'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppSummaryBand.GetRank }

function TppSummaryBand.GetRank: String;
begin
  Result := Format('%8d',[9]);
end;  {function, GetRank}

{------------------------------------------------------------------------------}
{ TppSummaryBand.SetAlignToBottom }

procedure TppSummaryBand.SetAlignToBottom(aAlignToBottom: Boolean);
begin

  if (Report is TppChildReport) and (Report.Parent <> nil) and
     (TppSubreport(TppChildReport(Report).Parent).PrintBehavior <> pbSection) then
    aAlignToBottom := False;

  if (FAlignToBottom <> aAlignToBottom)  then
    begin

      FAlignToBottom := aAlignToBottom;

      {notify report designer}
      PropertyChange;

      {notify report engine}
      if (Report <> nil) then
        Report.Reset;
    end;

end; {function, SetAlignToBottom}


{------------------------------------------------------------------------------}
{ TppSummaryBand.GetPrintCondition }

function TppSummaryBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcEndOfReport];
end; {function, GetPrintCondition}

procedure TppSummaryBand.CalcPrintPosition;
begin

  if (NewPage) and not(AlreadyPageBreak) then
    begin
      AlreadyPageBreak := True;

      if Visible then
        OutOfSpace := True;
    end

  else if (Report.Columns = 1) then
    begin
      inherited CalcPrintPosition
    end

  else if (TppBandedReport(Report).Detail.ColumnTraversal = ctLeftToRight) then
    begin
      Report.Engine.FlushLeft;
      inherited CalcPrintPosition;
    end

  else if (TppBandedReport(Report).Detail.ColumnTraversal = ctTopToBottom) then
    if (Report.Engine.PrintPosRect.Left = Report.Engine.Page.PrinterSetup.PageDef.mmMarginLeft) then
      inherited CalcPrintPosition
    else
      OutOfSpace := True;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppSummaryBand.BeforeGenerate }

procedure TppSummaryBand.AfterPrint;
var
  liSummaryTop: Integer;
  liNewSummaryTop: Integer;
  liIndex: Integer;
  lDrawCommand: TppDrawCommand;
begin
  inherited;

  if AlignToBottom then
    begin

      if Overflow then Exit;

      liSummaryTop := PrintPosRect.Top;

      liNewSummaryTop := Report.Engine.PageBottom - SpaceUsed;

      for liIndex := 0 to DrawCommands.Count - 1 do
        begin
          lDrawCommand := TppDrawCommand(DrawCommands[liIndex]);

          lDrawCommand.Top := (lDrawCommand.Top - liSummaryTop) + liNewSummaryTop;
        end;

    end;

end;

procedure TppSummaryBand.BeforeGenerate;
var
  lbDecrement: Boolean;
begin

  DrawCommands.Clear;

  Report.Engine.ESInclude([esPrintingSummary]);

  {reduce last group footers break no, so page numbers update properly}
  if (NewPage) and not(AlreadyPageBreak) then
    lbDecrement := True
  else if (NewPage) and (AlreadyPageBreak) then
    lbDecrement := False
  else
    lbDecrement := True;

  if lbDecrement and (Report.Engine.ControlGroup <> nil) and not(OverFlow) and not(PartialGeneration) then
    Report.Engine.ControlGroup.BreakNo := (Report.Engine.ControlGroup.BreakNo - 1);

end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppSummaryBand.FinishPage }

procedure TppSummaryBand.FinishPage;
begin

  Report.Engine.ESExclude([esPrintingSummary]);

  inherited AfterGenerate;

end; {procedure, AfterGenerate}



{******************************************************************************
 *
 **  C O L U M N   H E A D E R   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppColumnHeaderBand.Create }

constructor TppColumnHeaderBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  Height  := 0;
  CaptionIndex := 188;

end; {constructor, TppColumnHeaderBand}

{------------------------------------------------------------------------------}
{ TppColumnHeaderBand.GetRank }

function TppColumnHeaderBand.GetRank: String;
begin
  Result := Format('%8d',[3]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppColumnHeaderBand.GetPropUserName }

function TppColumnHeaderBand.GetPropUserName: TComponentName;
begin
  Result := 'ColumnHeader'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppColumnHeaderBand.GetPrintCondition }

function TppColumnHeaderBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcStartOfColumn];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppColumnHeaderBand.CanAdvanceData }

function TppColumnHeaderBand.CanAdvanceData: Boolean;
begin
  Result := True;
end; {function, CanAdvanceData}

{******************************************************************************
 *
 **  C O L U M N   F O O T E R   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.Create }

constructor TppColumnFooterBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  Height  := 0;
  CaptionIndex := 187;

  {footers are always static}
  PrintHeight := phStatic;

end; {constructor, TppColumnFooterBand}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.GetPropUserName }

function TppColumnFooterBand.GetPropUserName: TComponentName;
begin
  Result := 'ColumnFooter'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.GetPrintCondition }

function TppColumnFooterBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcEndOfColumn];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.GetRank }

function TppColumnFooterBand.GetRank: String;
begin
  Result := Format('%8d',[7]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.CalcPrintPosition }

procedure TppColumnFooterBand.CalcPrintPosition;
var
  lRect: TppRect;
begin

  {calc the actual page bottom}
  PageBottom :=  Report.Engine.Page.PageDef.mmHeight - Report.Engine.Page.PageDef.mmMarginBottom;

  {start at engine page bottom (pagebottom - footerheight - columnfooterheight}
  StartingPosition := Report.Engine.PageBottom;

  lRect.Left := Report.Engine.PrintPosRect.Left;
  lRect.Top := StartingPosition;
  lRect.Right := Report.Engine.PrintPosRect.Right;
  lRect.Bottom := StartingPosition + mmHeight;

  PrintPosRect := lRect;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.AfterObjectGenerate }

procedure TppColumnFooterBand.AfterObjectGenerate;
var
  lRect: TppRect;
begin

  {if printing in subreport, and no space used, don't use the space, reset to original print position}
  if (SpaceUsed = 0) and ((Report is TppChildReport) or (Report.PrintingAsSubReport)) then
    begin
      lRect.Left := Report.Engine.PrintPosRect.Left;
      lRect.Top := Report.Engine.PrintPosRect.Top;
      lRect.Right := Report.Engine.PrintPosRect.Right;
      lRect.Bottom := Report.Engine.PrintPosRect.Bottom;

      PrintPosRect := lRect;
    end;

end; {procedure, AfterObjectGenerate}

{------------------------------------------------------------------------------}
{ TppColumnFooterBand.SetPrintHeight }

procedure TppColumnFooterBand.SetPrintHeight(aPrintHeight: TppPrintHeightType);
begin
 {do nothing, footer is always static}
end;


{******************************************************************************
 *
 ** D E T A I L   B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDetailBand.Create}

constructor TppDetailBand.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppDetailBandSaveRec);

  CaptionIndex := 189;

  FBandEngine := nil;
  FBandsPerRecord := 1;
  FColumnTraversal := ctTopToBottom;
  FDataPipeline := nil;

  FBackground1 := TppBandBackgroundSettings.Create(aOwner);
  FBackground2 := TppBandBackgroundSettings.Create(aOwner);

end; {constructor, TppDetailBand}

{------------------------------------------------------------------------------}
{ TppDetailBand.Destroy }

destructor TppDetailBand.Destroy;
begin

  FBandEngine.Free;
  FBackground1.Free;
  FBackground2.Free;

  DumpCache;

  inherited Destroy;

end; {destructor, TppDetailBand}

{------------------------------------------------------------------------------}
{ TppDetailBand.Notify }

procedure TppDetailBand.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (FDataPipeline = aCommunicator) then
    begin

      case aOperation of

        ppopRemove:
          begin
            DumpCache;

            FDataPipeline := nil;

            Reset;
          end;

        ppopDataChange:
          Reset;

      end;

    end

  else if (aCommunicator = FBandEngine) and (aOperation = ppopRemove) then
    FBandEngine := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDetailBand.FinishPage}

procedure TppDetailBand.FinishPage;
begin
  TppBandEngine(FBandEngine).FinishPage;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetBandsPerRecordCount}

function TppDetailBand.GetBandsPerRecordCount: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).BandsPerRecordCount
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetAllObjectsPrinted }

function TppDetailBand.GetAllObjectsPrinted: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).AllObjectsPrinted
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetCount }

function TppDetailBand.GetCount: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).Count
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetCurrentPosition }

function TppDetailBand.GetCurrentPosition: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).CurrentPosition
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetCumulativeCurrentPosition }

function TppDetailBand.GetCumulativeCurrentPosition: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).CumulativeCurrentPosition
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetGenerating }

function TppDetailBand.GetGenerating: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).Generating
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetGenerationComplete }

function TppDetailBand.GetGenerationComplete: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).GenerationComplete
  else
    Result := True;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetMaxStretchable }

function TppDetailBand.GetMaxStretchable: TppStretchable;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).MaxStretchable
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetObjectListIndex }

function TppDetailBand.GetObjectListIndex: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).ObjectListIndex
  else
    Result := -1;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetObjectIndex }

function TppDetailBand.GetObjectIndex: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).ObjectIndex
  else
    Result := -1;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetOutOfSpace }

function TppDetailBand.GetOutOfSpace: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).OutOfSpace
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetOverFlow }

function TppDetailBand.GetOverFlow: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).OverFlow
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPageBottom }

function TppDetailBand.GetPageBottom: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).PageBottom
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPartialGeneration }

function TppDetailBand.GetPartialGeneration: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).PartialGeneration
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPartialAdjustment }

function TppDetailBand.GetPartialAdjustment: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).PartialAdjustment
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPrintingSection }

function TppDetailBand.GetPrintingSection: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).PrintingSection
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPrintPositionBreak }

function TppDetailBand.GetPrintPositionBreak: Boolean;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).PrintPositionBreak
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPrintPosRect }

function TppDetailBand.GetPrintPosRect: TppRect;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).PrintPosRect;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetSpaceUsed }

function TppDetailBand.GetSpaceUsed: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).SpaceUsed
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.GetStartingPosition }

function TppDetailBand.GetStartingPosition: Integer;
begin
  if (FBandEngine <> nil) then
    Result := TppDetailBandEngine(FBandEngine).StartingPosition
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetAllObjectsPrinted }

procedure TppDetailBand.SetAllObjectsPrinted(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).AllObjectsPrinted := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetCount }

procedure TppDetailBand.SetCount(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).Count := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetCurrentPosition }

procedure TppDetailBand.SetCurrentPosition(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).CurrentPosition := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetCumulativeCurrentPosition }

procedure TppDetailBand.SetCumulativeCurrentPosition(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).CumulativeCurrentPosition := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetGenerating }

procedure TppDetailBand.SetGenerating(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).Generating := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetGenerationComplete }

procedure TppDetailBand.SetGenerationComplete(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).GenerationComplete := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetMaxStretchable }

procedure TppDetailBand.SetMaxStretchable(aStretchable: TppStretchable);
begin
  TppDetailBandEngine(FBandEngine).MaxStretchable := aStretchable;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetObjectListIndex }

procedure TppDetailBand.SetObjectListIndex(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).ObjectListIndex := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetObjectIndex }

procedure TppDetailBand.SetObjectIndex(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).ObjectIndex := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetOutOfSpace }

procedure TppDetailBand.SetOutOfSpace(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).OutOfSpace := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetOverFlow }

procedure TppDetailBand.SetOverFlow(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).OverFlow := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPageBottom }

procedure TppDetailBand.SetPageBottom(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).PageBottom := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPartialGeneration }

procedure TppDetailBand.SetPartialGeneration(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).PartialGeneration := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPartialAdjustment }

procedure TppDetailBand.SetPartialAdjustment(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).PartialAdjustment := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPrintingSection }

procedure TppDetailBand.SetPrintingSection(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).PrintingSection := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPrintPositionBreak }

procedure TppDetailBand.SetPrintPositionBreak(aValue: Boolean);
begin
  TppDetailBandEngine(FBandEngine).PrintPositionBreak := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPrintPosRect }

procedure TppDetailBand.SetPrintPosRect(aRect: TppRect);
begin
  TppDetailBandEngine(FBandEngine).PrintPosRect := aRect;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetSpaceUsed }

procedure TppDetailBand.SetSpaceUsed(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).SpaceUsed := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.SetStartingPosition }

procedure TppDetailBand.SetStartingPosition(aValue: Integer);
begin
  TppDetailBandEngine(FBandEngine).StartingPosition := aValue;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.ResolvePipelineReferences}

procedure TppDetailBand.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  lDataPipeline: TppDataPipeline;
begin

  if (FDataPipeline = nil) and (FDataPipelineName <> '') then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FDataPipelineName);
      SetDataPipeline(lDataPipeline);
    end;

  inherited ResolvePipelineReferences(aPipelineList);

end; {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppDetailBand.FixupPipelineReferences }

procedure TppDetailBand.FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
begin

  if (FDataPipeline <> nil) and (FDataPipeline.UserName = aOldUserName) then
    SetDataPipeline(aDataPipeline);

  inherited FixupPipelineReferences(aDataPipeline, aOldUserName);

end; {procedure, FixupPipelineReferences}

{------------------------------------------------------------------------------}
{ TppDetailBand.ReadState }

procedure TppDetailBand.ReadState(Reader: TReader);
begin

  {this is necessary to conver reports prior to 5.6}
  FDataPipelineName := TppHReaderUtils.ExtractIdentPropValue(Reader, 'DataPipeline');

  inherited ReadState(Reader);

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppDetailBand.DumpCache }

procedure TppDetailBand.DumpCache;
begin
   if (FDataPipeline <> nil) and (Report <> nil) then
    Report.DumpCache;

end; {function, DumpCache}

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPropUserName }

function TppDetailBand.GetPropUserName: TComponentName;
begin
  Result := 'Detail'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppDetailBand.GetPrintCondition }

function TppDetailBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcOnTraversal];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppDetailBand.GetRank }

function TppDetailBand.GetRank: String;
begin
  Result := Format('%8d',[5]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppDetailBand.Convert }

procedure TppDetailBand.Convert(aVersionNo: Integer);
begin
  inherited Convert(aVersionNo);

  if (Report <> nil) and (aVersionNo < 3000) and (TppReport(Report).RowSpacing <> 0) then
    BottomOffset := TppReport(Report).RowSpacing;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppDetailBand.Init }

procedure TppDetailBand.Init;
var
  lBandEngine: TppBandEngine;
  lColumnTraversal: TppColumnTraversalType;
begin

  if (FBandEngine <> nil) then
    FBandEngine.Free;

  lColumnTraversal := FColumnTraversal;

  if (lColumnTraversal = ctLeftToRight) and (Report.Columns < 2) then
    lColumnTraversal := ctTopToBottom;

  case lColumnTraversal of
    ctTopToBottom: lBandEngine := TppVerticalBandEngine.Create(nil);
    ctLeftToRight: lBandEngine := TppHorizontalBandEngine.Create(nil);
    else
      lBandEngine := nil;
  end;

  FBandEngine := lBandEngine;

  lBandEngine.Band := Self;
  lBandEngine.Init;

  lBandEngine.BeforePrintEvent := BandEngineBeforePrintEvent;
  lBandEngine.AfterPrintEvent := BandEngineAfterPrintEvent;
  lBandEngine.BeforeGenerateEvent := BandEngineBeforeGenerateEvent;
  lBandEngine.AfterGenerateEvent := BandEngineAfterGenerateEvent;
  lBandEngine.OnCreateDrawCommand := BandEngineOnCreateDrawCommand;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppDetailBand.Generate }

procedure TppDetailBand.Generate;
begin
  TppBandEngine(FBandEngine).Generate;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.BandEngineBeforePrintEvent }

procedure TppDetailBand.BandEngineBeforePrintEvent(Sender: TObject);
begin
  DoBeforePrint;
end;

procedure TppDetailBand.BandEngineOnCreateDrawCommand(Sender: TObject);
var
  lPage: TppPage;
  lDrawCommand: TppDrawCommand;
begin

  lPage := Report.Engine.Page;
  lDrawCommand := CreateBGDrawCommand(Count);

  if lDrawCommand <> nil then
    lDrawCommand.Page := lPage;

end;

{------------------------------------------------------------------------------}
{ TppDetailBand.BandEngineAfterPrintEvent }

procedure TppDetailBand.BandEngineAfterPrintEvent(Sender: TObject);
begin
  DoAfterPrint;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.BandEngineBeforeGenerateEvent }

procedure TppDetailBand.BandEngineBeforeGenerateEvent(Sender: TObject);
begin
  DoBeforeGenerate;
end;

{------------------------------------------------------------------------------}
{ TppDetailBand.BandEngineAfterGenerateEvent }

procedure TppDetailBand.BandEngineAfterGenerateEvent(Sender: TObject);
begin
  DoAfterGenerate;
end;

function TppDetailBand.CreateBGDrawCommand(aCount: Integer): TppDrawCommand;
var
  lDrawShape: TppDrawShape;
  lBackgroundSettings: TppBandBackgroundSettings;
begin

  Result := nil;

  if (aCount mod 2 = 0) then
    lBackgroundSettings := Background2
  else
    lBackgroundSettings := Background1;

  if (lBackgroundSettings.Brush.Style = bsSolid) or (lBackgroundSettings.Gradient.Style <> gsNone) then
    begin

      lDrawShape := TppDrawShape.Create(nil);
      lDrawShape.ShapeType := stRectangle;
      lDrawShape.Brush.Assign(lBackgroundSettings.Brush);
      lDrawShape.Pen.Style := psClear;
      lDrawShape.Left := 0;
      lDrawShape.Top := PrintPosRect.Top;
      lDrawShape.Left := PrintPosRect.Left;
      lDrawShape.Width := mmWidth;
      lDrawShape.Height := PrintPosRect.Bottom - PrintPosRect.Top;
      lDrawShape.Gradient.Assign(lBackgroundSettings.Gradient);

      Result := lDrawShape;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDetailBand.RestoreFromCache }

procedure TppDetailBand.RestoreFromCache(aAbsolutePageNo: Integer);
var
  lRec: TppDetailBandSaveRec;
  lDetailBandEngine: TppDetailBandEngine;
begin

  if (FBandEngine = nil) then Exit;

  ReadRecordFromCache(aAbsolutePageNo, lRec);

  lDetailBandEngine := TppDetailBandEngine(FBandEngine);

  lDetailBandEngine.ObjectIndex := lRec.FObjectIndex;
  lDetailBandEngine.ObjectListIndex := lRec.FObjectListIndex;
  lDetailBandEngine.OverFlow := lRec.FOverFlow;
  lDetailBandEngine.PartialGeneration := lRec.FPartialGeneration;
  lDetailBandEngine.PartialAdjustment := lRec.FPartialAdjustment;
  lDetailBandEngine.PrintPositionBreak := lRec.FPrintPositionBreak;
  lDetailBandEngine.PrintingSection := lRec.FPrintingSection;
  lDetailBandEngine.BandsPerRecordCount := lRec.FBandsPerRecordCount;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppDetailBand.SaveToCache }

procedure TppDetailBand.SaveToCache(aAbsolutePageNo: Integer);
var
  lRec: TppDetailBandSaveRec;
  lDetailBandEngine: TppDetailBandEngine;
begin

  if (FBandEngine = nil) then Exit;

  lDetailBandEngine := TppDetailBandEngine(FBandEngine);

  lRec.FObjectIndex := lDetailBandEngine.ObjectIndex;
  lRec.FObjectListIndex := lDetailBandEngine.ObjectListIndex;
  lRec.FOverFlow := lDetailBandEngine.OverFlow;
  lRec.FPartialGeneration := lDetailBandEngine.PartialGeneration;
  lRec.FPartialAdjustment := lDetailBandEngine.PartialAdjustment;
  lRec.FPrintPositionBreak := lDetailBandEngine.PrintPositionBreak;
  lRec.FPrintingSection := lDetailBandEngine.PrintingSection;
  lRec.FBandsPerRecordCount := lDetailBandEngine.BandsPerRecordCount;

  WriteRecordToCache(aAbsolutePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppDetailBand.SetPrintHeight }

procedure TppDetailBand.SetPrintHeight(aPrintHeight: TppPrintHeightType);
begin

  if (aPrintHeight = phDynamic) and (FColumnTraversal = ctLeftToRight) then Exit;

  inherited SetPrintHeight(aPrintHeight);

end; {procedure, SetPrintHeight}

{------------------------------------------------------------------------------}
{ TppDetailBand.SetColumnTraversal }

procedure TppDetailBand.SetColumnTraversal(aValue: TppColumnTraversalType);
begin

  FColumnTraversal := aValue;

  Reset;

  if (PrintHeight = phDynamic) and (FColumnTraversal = ctLeftToRight) then
    SetPrintHeight(phStatic);

end; {procedure, SetColumnTraversal}

{------------------------------------------------------------------------------}
{ TppDetailBand.SetBandsPerRecord }

procedure TppDetailBand.SetBandsPerRecord(aValue: Integer);
begin

  if (aValue < 1) then
    FBandsPerRecord := 1
  else
    FBandsPerRecord := aValue;

  Reset;

end; {procedure, SetBandsPerRecord}

{------------------------------------------------------------------------------}
{ TppDetailBand.SetDataPipeline }

procedure TppDetailBand.SetDataPipeline(aDataPipeline: TppDataPipeline);
var
  lOldDataPipeline: TppDataPipeline;
  lNewDataPipeline: TppDataPipeline;
begin

  if (Report <> nil) and (aDataPipeline = Report.DataPipeline) then Exit;

  lOldDataPipeline := FDataPipeline;
  lNewDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.RemoveNotify(Self);

  FDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.AddNotify(Self);

  {this causes the caption to change}
  Notify(FDataPipeline, ppopDataChange);

  if (csReading in ComponentState) or (csLoading in ComponentState) or
     (pppcTemplateLoading in DesignState) then Exit;

  {save data pipeline name}
  if (FDataPipeline <> nil) then
    FDataPipelineName := FDataPipeline.Name
  else
    FDataPipelineName := '';

  Reset;

  {do this AFTER FDataPipeline assigned}
  {any data-aware components with the same datapipeline need to be updated}
  UpdateParentDataPipeline(lNewDataPipeline, lOldDataPipeline);

end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppDetailBand.UpdateParentDataPipeline }

procedure TppDetailBand.UpdateParentDataPipeline(aNewDataPipeline, aOldDataPipeline: TppDataPipeline);
var
  liObject: Integer;
  lObject: TppComponent;
begin

  {update datapipeline property of components}
  for liObject := 0 to ObjectCount - 1 do
    begin
      lObject := Objects[liObject];

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

end; {procedure, UpdateParentDataPipeline}

{------------------------------------------------------------------------------}
{ TppDetailBand.IsDataAware }

function TppDetailBand.IsDataAware: Boolean;
begin
  Result := True;
end; {function, IsDataAware}

{------------------------------------------------------------------------------}
{ TppDetailBand.GetDefaultPrintTimes }

function TppDetailBand.GetDefaultPrintTimes: TppPrintTimesType;
begin
  Result := ptRepeat;
end; {function, GetDefaultPrintTimes}

{------------------------------------------------------------------------------}
{ TppDetailBand.GetADataPipeline }

function TppDetailBand.GetADataPipeline: TppDataPipeline;
begin
  {find the best DataPipeline}
  if (FDataPipeline <> nil) then
    Result := FDataPipeline
  else
    Result := Report.DataPipeline;
end; {function, GetADataPipeline}

{------------------------------------------------------------------------------}
{ TppDetailBand.DefineProperties }

procedure TppDetailBand.DefineProperties(Filer: TFiler);
var
  lbWrite: Boolean;
begin

  inherited DefineProperties(Filer);

  Filer.DefineProperty('DataSource', ReadDataSource, nil, False);
  Filer.DefineProperty('NoRecordsAction', ReadNoRecordsAction, nil, False);
  Filer.DefineProperty('SkipWhenNoRecords', ReadSkipWhenNoRecords, nil, False);

  {if no ancestor, then write it, if it exists}
  if (Filer.Ancestor = nil) or (TppDetailBand(Filer.Ancestor).DataPipeline = nil) then
    lbWrite := (FDataPipeline <> nil)

  {if ancestor, then write it, if it is different than ancestor}
  else if (FDataPipeline <> nil) and (TppDetailBand(Filer.Ancestor).DataPipeline.Name <> FDataPipeline.Name) then
    lbWrite := True

  else
    lbWrite := False;

  Filer.DefineProperty('DataPipeline', ReadDataPipeline, WriteDataPipeline, lbWrite);

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppDetailBand.ReadDataPipeline }

procedure TppDetailBand.ReadDataPipeline(Reader: TReader);
begin
  FDataPipelineName := Reader.ReadIdent;
end; {procedure, ReadDataPipeline}

{------------------------------------------------------------------------------}
{ TppDetailBand.WriteDataPipeline }

procedure TppDetailBand.WriteDataPipeline(Writer: TWriter);
begin
  Writer.WriteIdent(FDataPipelineName);
end; {procedure, WriteDataPipeline}

{------------------------------------------------------------------------------}
{ TppDetailBand.ReadDataSource }

procedure TppDetailBand.ReadDataSource(Reader: TReader);
begin
  {read the value into a string}
  FDataSource := Reader.ReadIdent;
end; {procedure, ReadDataSource}

{------------------------------------------------------------------------------}
{ TppDetailBand.ReadSkipWhenNoRecords }

procedure TppDetailBand.ReadSkipWhenNoRecords(Reader: TReader);
begin
  {eat the value}
  Reader.ReadBoolean;
end; {procedure, ReadSkipWhenNoRecords}

{------------------------------------------------------------------------------}
{ TppDetailBand.ReadNoRecordsAction }

procedure TppDetailBand.ReadNoRecordsAction(Reader: TReader);
begin
  {eat the value}
  Reader.ReadIdent;
end; {procedure, ReadNoRecordsAction}

procedure TppDetailBand.SetBackground1(aBackground1: TppBandBackgroundSettings);
begin
  FBackground1.Assign(aBackground1);

end;

procedure TppDetailBand.SetBackground2(aBackground2: TppBandBackgroundSettings);
begin
  FBackground2.Assign(aBackground2);

end;

{******************************************************************************
 *
 **  G R O U P  B A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGroupBand.Create }

constructor TppGroupBand.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppGroupBandSaveRec);

  FGeneration := False;
  FGroup := nil;
  FSaveGeneration := False;

end; {constructor, Create

{------------------------------------------------------------------------------}
{ TppGroupBand.Destroy }

destructor TppGroupBand.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppGroupBand.RestoreFromCache }

procedure TppGroupBand.RestoreFromCache(aAbsolutePageNo: Integer);
var
  lRec: TppGroupBandSaveRec;
begin

  ReadRecordFromCache(aAbsolutePageNo, lRec);

  FObjectIndex         := lRec.FObjectIndex;
  FObjectListIndex     := lRec.FObjectListIndex;
  FOverFlow            := lRec.FOverFlow;
  FPartialGeneration   := lRec.FPartialGeneration;
  FPartialAdjustment   := lRec.FPartialAdjustment;
  FPrintPositionBreak  := lRec.FPrintPositionBreak;
  FPrintingSection     := lRec.FPrintingSection;

  FGeneration        := lRec.FGeneration;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppGroupBand.SaveToCache }

procedure TppGroupBand.SaveToCache(aAbsolutePageNo: Integer);
var
  lRec: TppGroupBandSaveRec;
begin

  lRec.FObjectIndex       := FObjectIndex;
  lRec.FObjectListIndex   := FObjectListIndex;
  lRec.FOverFlow          := FOverFlow;
  lRec.FPartialGeneration := FPartialGeneration;
  lRec.FPartialAdjustment := FPartialAdjustment;
  lRec.FPrintPositionBreak  := FPrintPositionBreak;
  lRec.FPrintingSection     := FPrintingSection;

  lRec.FGeneration  := FGeneration;

  WriteRecordToCache(aAbsolutePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppGroupBand.Init}

procedure TppGroupBand.Init;
begin
  inherited Init;

  FGeneration := False;
  FSaveGeneration := False;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppGroupBand.GetDescription }

function TppGroupBand.GetDescription: String;
var
  lsBreakName: String;
begin

  if (FGroup = nil) or (Report = nil) then Exit;

  if (FGroup.BreakName = '') then
    begin

      if FGroup.BreakType = btCustomField then
        lsBreakName := ppLoadStr(300)
      else
        lsBreakName := ppLoadStr(301);
    end

  else if (FGroup.DataPipeline <> nil) then
    lsBreakName := FGroup.DataPipeline.FieldAliasForFieldName(FGroup.BreakName)

  else
    lsBreakName := FGroup.BreakName;

  {example: GroupHeader[0]: CompanyName }
  Result := ppLoadStr(CaptionIndex) +
            '[' +  IntToStr(FGroup.GroupNo) + ']: ' + lsBreakName;

end; {procedure, GetDescription}



{------------------------------------------------------------------------------}
{ TppGroupBand.GetParentComponent - required method for Components with HasParent = True }

function TppGroupBand.GetParentComponent: TComponent;
begin
  Result := Group;

end;

{------------------------------------------------------------------------------}
{ TppGroupBand.SetParentComponent - required method for Components with HasParent = True }

procedure TppGroupBand.SetParentComponent(Value: TComponent);
begin

  if (Value is TppGroup) then
    Group := (Value as TppGroup);

end;

{------------------------------------------------------------------------------}
{ TppGroupBand.PropertyChange }

procedure TppGroupBand.PropertyChange;
begin
  if (FGroup = nil) then Exit;

  inherited PropertyChange;

end; {procedure, PropertyChange}

{------------------------------------------------------------------------------}
{ TppGroupBand.SetGroup property routine }

procedure TppGroupBand.SetGroup(aGroup: TppGroup);
begin

  FGroup := aGroup;

   if (FGroup <> nil) then
    Caption := ppLoadStr(CaptionIndex);

  GroupChanged;

end; {procedure, SetGroup}

{------------------------------------------------------------------------------}
{ TppGroupBand.GroupChanged - called by Group to keep group band attributes in sync }

procedure TppGroupBand.GroupChanged;
begin

 if  csDestroying in ComponentState then exit;

 if Assigned(FGroup) then
   begin

      Caption := GetDescription;

   end;

end; {procedure, GroupChanged}


{******************************************************************************}
{*
{**  G R O U P   H E A D E R   B A N D
{*
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.Create }

constructor TppGroupHeaderBand.Create(aOwner : TComponent);
begin

  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppGroupHeaderBandSaveRec);

  CaptionIndex := 192; {default, gets changed later}

  Height  := 0;

  FAlreadyColumnBreak := False;
  FAlreadyPageBreak := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.Destroy }

destructor TppGroupHeaderBand.Destroy;
begin

  if (Group <> nil) then
    Group.HeaderBand := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.GetPrintCondition }

procedure TppGroupHeaderBand.Init;
var
  lbPageStarted: Boolean;
begin

  inherited Init;

  {default these so group header does not force new page at beginning of report}
  lbPageStarted := Report.Engine.PageStarted;

  FAlreadyPageBreak := not(lbPageStarted);
  FAlreadyColumnBreak := True;

  {default these to true, so group header prints at beginning of report}
  Generation := True;
  SaveGeneration := True;

  SavePageBandState;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.PageStart }

procedure TppGroupHeaderBand.PageStart;
begin

  inherited;

  //Be sure NewJob for the current page is reset to False each time a page starts.
  Report.Engine.Page.NewJob := False;

  // when group.StartOnOddPage is True, need to hide/restore page bands
  if Generation and Group.NewPage and Group.StartOnOddPage then
    if (Report.AbsolutePageNo mod 2 = 0) then
      SetPageBandVisible(False)
    else
      RestorePageBandState;

end; {procedure, PageStart}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.ProcessNewFile }

procedure TppGroupHeaderBand.ProcessNewFile;
var
  lParams: TraParamList;
  lsBreakValue: string;
begin

  lsBreakValue := Group.BreakValue;

  //Fire OnGetFileSuffix Event
  if Assigned(Group.OnGetFileSuffix) then Group.OnGetFileSuffix(Self, lsBreakValue);

  lParams := TraTppGroupRTTI.GetParams('OnGetFileSuffix');
  lParams.CreateValuePointer(0, lsBreakValue);
  Group.SendEventNotify(Self, ciGroupGetFileSuffix, lParams);
  lParams.Free;

  if Group.GroupFileSettings.EmailFile then
    ProcessEmailFile(lsBreakValue);

  //Notify the file device that the current job should end and a new job should be started.
  Report.Engine.Page.NewJob := True;
  Report.Engine.Page.FileSuffix := lsBreakValue;

end; {function, ProcessNewFile}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.ProcessEmailFile }

procedure TppGroupHeaderBand.ProcessEmailFile(aBreakValue: string);
var
  lParams: TraParamList;
  lEmailSettings: TppEmailSettings;
begin

  lEmailSettings := TppEmailSettings.Create;

  try
    lEmailSettings.Assign(Report.EmailSettings);

    if Group.GroupFileSettings.EmailField <> '' then
      lEmailSettings.Recipients.Add(Report.DataPipeline[Group.GroupFileSettings.EmailField]);

    lEmailSettings.Subject := lEmailSettings.Subject + ' ' + aBreakValue;

    //Fire OnGetEmailAddress Event
    if Assigned(Group.OnGetEmailSettings) then Group.OnGetEmailSettings(Group, lEmailSettings);

    lParams := TraTppGroupRTTI.GetParams('OnGetEmailSettings');
    lParams.CreateValuePointer(0, lEmailSettings);
    Group.SendEventNotify(Self, ciGroupGetEmailSettings, lParams);
    lParams.Free;

    Report.Engine.Page.EmailSettings := lEmailSettings;

  finally
    lEmailSettings.Free;
  end;

end; {function, ProcessEmailFile}


{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.GetPrintCondition }

function TppGroupHeaderBand.GetPrintCondition: TppPrintConditions;
begin

  Result := [pppcStartOfGroup];

  if (Group <> nil) and (Group.ReprintOnSubsequentPage) then
    Include(Result, pppcStartOfPage);

  if (Group <> nil) and (Report.Columns > 1) and (Group.ReprintOnSubsequentColumn) then
    Include(Result, pppcStartOfColumn);

end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.SetGroup }

procedure TppGroupHeaderBand.SetGroup(aGroup: TppGroup);
begin

  if (Group <> nil) then
    Group.HeaderBand := nil;

  inherited SetGroup(aGroup);

  if Assigned(aGroup) then
    aGroup.HeaderBand := Self;

end; {procedure, SetGroup}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.GetRank }

function TppGroupHeaderBand.GetRank: String;
begin

  if (Group <> nil) then
    Result := Format('%8d',[4]) + Format('%8d',[Group.GroupNo]);

end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.RestoreFromCache }

procedure TppGroupHeaderBand.RestoreFromCache(aAbsolutePageNo: Integer);
var
  lRec: TppGroupHeaderBandSaveRec;
begin

  ReadRecordFromCache(aAbsolutePageNo, lRec);

  FObjectIndex        := lRec.FObjectIndex;
  FObjectListIndex    := lRec.FObjectListIndex;
  FOverFlow           := lRec.FOverFlow;
  FPartialGeneration  := lRec.FPartialGeneration;
  FPartialAdjustment  := lRec.FPartialAdjustment;
  FPrintPositionBreak := lRec.FPrintPositionBreak;
  FPrintingSection    := lRec.FPrintingSection;

  FGeneration        := lRec.FGeneration;

  FAlreadyPageBreak := lRec.FAlreadyPageBreak;
  FAlreadyColumnBreak := lRec.FAlreadyColumnBreak;

  FPageHeaderVisible := lRec.FPageHeaderVisible;
  FPageFooterVisible := lRec.FPageFooterVisible;
  FPageStyleVisible :=  lRec.FPageStyleVisible;


end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.SaveToCache }

procedure TppGroupHeaderBand.SaveToCache(aAbsolutePageNo: Integer);
var
  lRec: TppGroupHeaderBandSaveRec;
begin

  lRec.FObjectIndex        := FObjectIndex;
  lRec.FObjectListIndex    := FObjectListIndex;
  lRec.FOverFlow           := FOverFlow;
  lRec.FPartialGeneration  := FPartialGeneration;
  lRec.FPartialAdjustment  := FPartialAdjustment;
  lRec.FPrintPositionBreak := FPrintPositionBreak;
  lRec.FPrintingSection    := FPrintingSection;

  lRec.FGeneration  := FGeneration;

  lRec.FAlreadyPageBreak := FAlreadyPageBreak;
  lRec.FAlreadyColumnBreak := FAlreadyColumnBreak;

  lRec.FPageHeaderVisible := FPageHeaderVisible;
  lRec.FPageFooterVisible := FPageFooterVisible;
  lRec.FPageStyleVisible  := FPageStyleVisible;

  WriteRecordToCache(aAbsolutePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.BeforePrint }

procedure TppGroupHeaderBand.BeforePrint;
begin

  Group.GroupHeaderBeforePrint;

  inherited BeforePrint;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.BeforeGenerate }

procedure TppGroupHeaderBand.BeforeGenerate;
var
  llSpaceAvailable: Integer;
begin

  {must take cache snapshot only if this band is supposed to generate}
  if Generation then
    Group.GroupHeaderBeforeGenerate;

  {subsequent page of same group?}
  if not(Generation) and
     (pppcStartOfPage in Report.Engine.PrintCondition) and
     (Group.ReprintOnSubsequentPage) and
     (Report.Engine.AbsolutePageNo >= Group.FirstPageNo) then
    GenerationComplete := False

  {subsequent column of same group?}
  else if not(Generation) and
     (pppcStartOfColumn in Report.Engine.PrintCondition) and
     (Group.ReprintOnSubsequentColumn) and
     ((Report.Engine.AbsolutePageNo > Group.FirstPageNo) or
      ((Report.Engine.AbsolutePageNo = Group.FirstPageNo) and
       (Report.Engine.CurrentColumn > Group.FirstColumn))) then
    GenerationComplete := False

  {printing the title or summary band?}
  else if (esPrintingTitle in Report.Engine.State) or
     (esPrintingSummary in Report.Engine.State) then
    GenerationComplete := True

  else if not(Generation) and not(OverFlow) then
    GenerationComplete := True;

  if (GenerationComplete) then Exit;

  inherited CalcPrintPosition;

  llSpaceAvailable := PageBottom - StartingPosition;

  if (FAlreadyPageBreak) or ((Report.Columns > 1) and (FAlreadyColumnBreak)) then
    begin
      if Generation and (Group.GroupFileSettings.NewFile) then
        ProcessNewFile;
    end
  else if (Report.Columns > 1) and Generation and Group.NewColumn then
    begin
      FAlreadyColumnBreak := True;
      OutOfSpace := True;
    end

  else if Generation and Group.NewPage then
    begin
      if (Group.StartOnOddPage) and (Report.AbsolutePageNo mod 2 = 1) then
        FAlreadyPageBreak := False
      else
        FAlreadyPageBreak := True;

      OutOfSpace := True;
    end

  else if (Report.Columns > 1) and (Group.mmNewColumnThreshold > llSpaceAvailable) then
    begin
      FAlreadyColumnBreak := True;
      OutOfSpace := True;
    end

  else if (Group.mmNewPageThreshold > llSpaceAvailable) then
    begin
      FAlreadyPageBreak := True;
      OutOfSpace := True;
    end;


  {save first page and column on which this group appears}
  if not(OutOfSpace) and
    ((Generation) or (pppcStartOfReport in Report.Engine.PrintCondition)) and not(OverFlow) then
    begin
      Group.FirstPageNo := Report.Engine.AbsolutePageNo;

      Group.FirstColumn := Report.Engine.CurrentColumn;

      Report.Engine.SyncData;
    end;


end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.BeforeObjectGenerate }

procedure TppGroupHeaderBand.BeforeObjectGenerate;
begin
  {if Generation and not(OverFlow) and not(PartialGeneration) then}  {4.25}
  if not(OverFlow) and not(PartialGeneration) then
    Group.BeforeHeader;

  inherited BeforeObjectGenerate;

end; {procedure, BeforeObjectGenerate}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.AfterPrint }

procedure TppGroupHeaderBand.AfterPrint;
begin

  inherited AfterPrint;

  {if group break occured, reset generation flags}
  if Generation and not(OverFlow) and not(OutOfSpace) then
    begin
      Generation := False;

      Group.Breaking := False;

      {clear page break indicator}
      if FAlreadyPageBreak then
        FAlreadyPageBreak := False;

      {clear column break indicator}
      if FAlreadyColumnBreak then
        FAlreadyColumnBreak := False;

    end;

end; {procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.SavePageBandState }

procedure TppGroupHeaderBand.SavePageBandState;
var
  lReport: TppBandedReport;
begin
  if Report = nil then Exit;

  lReport := TppBandedReport(Report);

  FPageHeaderVisible := (lReport.HeaderBand <> nil) and lReport.HeaderBand.Visible;
  FPageFooterVisible := (lReport.FooterBand <> nil) and lReport.FooterBand.Visible;
  FPageStyleVisible  := (lReport.PageStyle <> nil) and lReport.PageStyle.Visible;

end;

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.RestorePageBandState }

procedure TppGroupHeaderBand.RestorePageBandState;
var
  lReport: TppBandedReport;
begin
  if Report = nil then Exit;

  lReport := TppBandedReport(Report);

  if (lReport.Header <> nil) then
    lReport.Header.Visible := FPageHeaderVisible;

  if (lReport.Footer <> nil) then
    lReport.Footer.Visible := FPageFooterVisible;

  if (lReport.PageStyle <> nil) then
    lReport.PageStyle.Visible := FPageStyleVisible;

end;

{------------------------------------------------------------------------------}
{ TppGroupHeaderBand.SetPageBandVisible }

procedure TppGroupHeaderBand.SetPageBandVisible(aValue: Boolean);
var
  lReport: TppBandedReport;
begin

  if Report = nil then Exit;

  lReport := TppBandedReport(Report);

  if (lReport.Header <> nil) then
    lReport.Header.Visible := aValue;

  if (lReport.Footer <> nil) then
    lReport.Footer.Visible := aValue;

  if (lReport.PageStyle <> nil) then
    lReport.PageStyle.Visible := aValue;

end;

{******************************************************************************}
{*
{**  G R O U P   F O O T E R    B A N D
{*
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.Create }

constructor TppGroupFooterBand.Create(aOwner : TComponent);
begin

  inherited Create(aOwner);

  CaptionIndex := 191; {default, gets changed later}
  Height  := 0;

end; {constructor, TppGroupFooterBand}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.Destroy }

destructor TppGroupFooterBand.Destroy;
begin

  if (Group <> nil) then
    Group.FooterBand := nil;

  inherited Destroy;

end; {destructor, TppGroupFooterBand}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.GetPrintCondition }

function TppGroupFooterBand.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcEndOfGroup];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.SetGroup }

procedure TppGroupFooterBand.SetGroup(aGroup: TppGroup);
begin

  if (Group <> nil) then
    Group.FooterBand := nil;

  inherited SetGroup(aGroup);

  if Assigned(aGroup) then
    aGroup.FooterBand := Self;

end; {procedure, SetGroup}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.GetRank }

function TppGroupFooterBand.GetRank: String;
var
  llGroupNo: Integer;
begin

  {set footer sort id using 9's complement of group number}
  if (Group <> nil)  then
    begin
      llGroupNo := 99999999 - (Group.GroupNo + 1);

      Result := Format('%8d',[6]) + Format('%8d',[llGroupNo]);
    end;

end; {procedure, GetRank}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.BeforeObjectGenerate }

procedure TppGroupFooterBand.BeforeObjectGenerate;
begin

  {if Generation and not(OverFlow) and not(PartialGeneration) then} {4.24}
  if not(OverFlow) and not(PartialGeneration) then
    Group.BeforeFooter;

  inherited BeforeObjectGenerate;

end; {procedure, BeforeObjectGenerate}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.BeforePrint }

procedure TppGroupFooterBand.BeforePrint;
begin

  inherited BeforePrint;

  if HideWhenOneDetail then
    Visible := Group.DetailCount > 1;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.BeforeGenerate }

procedure TppGroupFooterBand.BeforeGenerate;
begin

  if not(Generation) and
     (pppcEndOfReport in Report.Engine.PrintCondition) then
    GenerationComplete := False

  else if not(Generation) and not(OverFlow) then
    GenerationComplete := True;

end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.AfterPrint }

procedure TppGroupFooterBand.AfterPrint;
begin

  inherited AfterPrint;

  {if group break occured, reset generation flags}
  if Generation and not(OverFlow) and not(OutOfSpace) then
    begin
      Generation := False;

      Group.GroupFooterAfterPrint;
    end;

end; {procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppGroupFooterBand.AfterGenerate }

procedure TppGroupFooterBand.AfterGenerate;
begin

  {advance record to the appropriate position}
  if (Group <> nil) and (Group.GroupNo = 0) and not(OutOfSpace) and
     not(Report.Engine.AllDataTraversed) and (pppcEndOfGroup in Report.Engine.PrintCondition) then
    Report.Engine.AdvanceRecord := True;

  inherited AfterGenerate;

end; {procedure, AfterGenerate}


{******************************************************************************}
{*
{**  C U S T O M    B A N D
{*
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomBand.Create }

constructor TppCustomBand.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppBandSaveRec);

  FAllObjectsPrinted := False;
  FCalcList := nil;
  FCumulativeCurrentPosition := 0;
  FCurrentPosition := 0;
  FDrawCommands := TList.Create;
  FGenerating := False;
  FGenerationComplete := False;
  FMaxStretchablePosition := 0;
  FObjectListIndex := 0;
  FObjectListSaved := False;
  FObjectIndex := 0;
  FObjectSaved := False;
  FOverFlow := False;
  FPrintingSection := False;
  FPrintPositionBreak := False;
  FPageBottom := 0;
  FSpaceUsed := 0;
  FStartingPosition := 0;

  FStretchables := nil;
  FShifters := nil;
  FStretchers := nil;
  FStatics := nil;
  FPrintQueue := TStringList.Create;

  {build list of object lists}
  FObjectLists := TStringList.Create;

  EventNotifies := EventNotifies + [ciPrintableDrawCommandCreate];

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomBand.Destroy }

destructor TppCustomBand.Destroy;
begin
  {free print processing lists}
  FreeLists;

  FCalcList.Free;
  FObjectLists.Free;
  FPrintQueue.Free;

  FDrawCommands.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomBand.GetAllObjectsPrinted }

function TppCustomBand.GetAllObjectsPrinted: Boolean;
begin
  Result := FAllObjectsPrinted;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetCount }

function TppCustomBand.GetCount: Integer;
begin
  Result := FCount;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetCurrentPosition }

function TppCustomBand.GetCurrentPosition: Integer;
begin
  Result := FCurrentPosition;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetDrawCommands }

function TppCustomBand.GetDrawCommands: TList;
begin
  Result := FDrawCommands;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetCumulativeCurrentPosition }

function TppCustomBand.GetCumulativeCurrentPosition: Integer;
begin
  Result := FCumulativeCurrentPosition;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetGenerating }

function TppCustomBand.GetGenerating: Boolean;
begin
  Result := FGenerating;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetGenerationComplete }

function TppCustomBand.GetGenerationComplete: Boolean;
begin
  Result := FGenerationComplete;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetMaxStretchable }

function TppCustomBand.GetMaxStretchable: TppStretchable;
begin
  Result := FMaxStretchable;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetObjectListIndex }

function TppCustomBand.GetObjectListIndex: Integer;
begin
  Result := FObjectListIndex;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetObjectIndex }

function TppCustomBand.GetObjectIndex: Integer;
begin
  Result := FObjectIndex;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetOutOfSpace }

function TppCustomBand.GetOutOfSpace: Boolean;
begin
  Result := FOutOfSpace;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetOverFlow }

function TppCustomBand.GetOverFlow: Boolean;
begin
  Result := FOverFlow;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPageBottom }

function TppCustomBand.GetPageBottom: Integer;
begin
  Result := FPageBottom;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPartialGeneration }

function TppCustomBand.GetPartialGeneration: Boolean;
begin
  Result := FPartialGeneration;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPartialAdjustment }

function TppCustomBand.GetPartialAdjustment: Integer;
begin
  Result := FPartialAdjustment;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPrintingSection }

function TppCustomBand.GetPrintingSection: Boolean;
begin
  Result := FPrintingSection;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPrintPositionBreak }

function TppCustomBand.GetPrintPositionBreak: Boolean;
begin
  Result := FPrintPositionBreak;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPrintPosRect }

function TppCustomBand.GetPrintPosRect: TppRect;
begin
  Result := FPrintPosRect;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetSpaceUsed }

function TppCustomBand.GetSpaceUsed: Integer;
begin
  Result := FSpaceUsed;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.GetStartingPosition }

function TppCustomBand.GetStartingPosition: Integer;
begin
  Result := FStartingPosition;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetAllObjectsPrinted }

procedure TppCustomBand.SetAllObjectsPrinted(aValue: Boolean);
begin
  FAllObjectsPrinted := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetCount }

procedure TppCustomBand.SetCount(aValue: Integer);
begin
  FCount := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetCurrentPosition }

procedure TppCustomBand.SetCurrentPosition(aValue: Integer);
begin
  FCurrentPosition := aValue;
end;

procedure TppCustomBand.SetDrawCommands(aValue: TList);
begin
  FDrawCommands.Assign(aValue);
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetCumulativeCurrentPosition }

procedure TppCustomBand.SetCumulativeCurrentPosition(aValue: Integer);
begin
  FCumulativeCurrentPosition := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetGenerating }

procedure TppCustomBand.SetGenerating(aValue: Boolean);
begin
  FGenerating := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetGenerationComplete }

procedure TppCustomBand.SetGenerationComplete(aValue: Boolean);
begin
  FGenerationComplete := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetMaxStretchable }

procedure TppCustomBand.SetMaxStretchable(aStretchable: TppStretchable);
begin
  FMaxStretchable := aStretchable;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetObjectListIndex }

procedure TppCustomBand.SetObjectListIndex(aValue: Integer);
begin
  FObjectListIndex := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetObjectIndex }

procedure TppCustomBand.SetObjectIndex(aValue: Integer);
begin
  FObjectIndex := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetOutOfSpace }

procedure TppCustomBand.SetOutOfSpace(aValue: Boolean);
begin
  FOutOfSpace := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetOverFlow }

procedure TppCustomBand.SetOverFlow(aValue: Boolean);
begin
  FOverFlow := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetPageBottom }

procedure TppCustomBand.SetPageBottom(aValue: Integer);
begin
  FPageBottom := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetPartialGeneration }

procedure TppCustomBand.SetPartialGeneration(aValue: Boolean);
begin
  FPartialGeneration := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetPartialAdjustment }

procedure TppCustomBand.SetPartialAdjustment(aValue: Integer);
begin
  FPartialAdjustment := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetPrintingSection }

procedure TppCustomBand.SetPrintingSection(aValue: Boolean);
begin
  FPrintingSection := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetPrintPositionBreak }

procedure TppCustomBand.SetPrintPositionBreak(aValue: Boolean);
begin
  FPrintPositionBreak := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetPrintPosRect }

procedure TppCustomBand.SetPrintPosRect(aRect: TppRect);
begin
  FPrintPosRect := aRect;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetSpaceUsed }

procedure TppCustomBand.SetSpaceUsed(aValue: Integer);
begin
  FSpaceUsed := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.SetStartingPosition }

procedure TppCustomBand.SetStartingPosition(aValue: Integer);
begin
  FStartingPosition := aValue;
end;

{------------------------------------------------------------------------------}
{ TppCustomBand.FreeLists }

procedure TppCustomBand.FreeLists;
var
  liList: Integer;
begin

  for liList := 0 to FObjectLists.Count - 1 do
    TList(FObjectLists.Objects[liList]).Free;

  FStretchables := nil;
  FStretchers := nil;
  FShifters := nil;
  FStatics := nil;

  FObjectLists.Clear;

end; {procedure, FreeLists}

{------------------------------------------------------------------------------}
{ TppCustomBand.RestoreFromCache }

procedure TppCustomBand.RestoreFromCache(aAbsolutePageNo: Integer);
var
  lRec: TppBandSaveRec;
begin

  ReadRecordFromCache(aAbsolutePageNo, lRec);

  FObjectIndex        := lRec.FObjectIndex;
  FObjectListIndex    := lRec.FObjectListIndex;
  FOverFlow           := lRec.FOverFlow;
  FPartialGeneration  := lRec.FPartialGeneration;
  FPartialAdjustment  := lRec.FPartialAdjustment;
  FPrintPositionBreak := lRec.FPrintPositionBreak;
  FPrintingSection    := lRec.FPrintingSection;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppCustomBand.SaveToCache }

procedure TppCustomBand.SaveToCache(aAbsolutePageNo: Integer);
var
  lRec: TppBandSaveRec;
begin

  lRec.FObjectIndex        := FObjectIndex;
  lRec.FObjectListIndex    := FObjectListIndex;
  lRec.FOverFlow           := FOverFlow;
  lRec.FPartialGeneration  := FPartialGeneration;
  lRec.FPartialAdjustment  := FPartialAdjustment;
  lRec.FPrintPositionBreak := FPrintPositionBreak;
  lRec.FPrintingSection    := FPrintingSection;

  WriteRecordToCache(aAbsolutePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppCustomBand.Init }

procedure TppCustomBand.Init;
begin

  inherited Init;

  FObjectIndex       := 0;
  FObjectListIndex   := 0;
  FOverFlow          := False;
  FPartialGeneration := False;
  FPartialAdjustment := mmHeight;

  FreeLists;

  CategorizeObjects;

  BuildCalcList;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppCustomBand.BuildCalcList }

procedure TppCustomBand.BuildCalcList;
var
  liObject: Integer;
  liObjects: Integer;
begin

  FCalcList.Free;
  FCalcList := nil;

  liObjects := ObjectCount;

  for liObject := 0 to liObjects - 1 do
    if Objects[liObject].IsCalc then
      begin
        if FCalcList = nil then
          FCalcList := TList.Create;

        FCalcList.Add(Objects[liObject]);
      end;

end; {procedure, BuildCalcList}

{------------------------------------------------------------------------------}
{ TppCustomBand.GetCurrentObject }

function TppCustomBand.GetCurrentObject: TppComponent;
var
  lList: TList;
begin

  Result := nil;

  if not(Printing) then Exit;

  if (FObjectLists.Count = 0) then Exit;

  if (FObjectListIndex < 0) or (FObjectListIndex >= FObjectLists.Count) then Exit;

  lList := TList(FObjectLists.Objects[FObjectListIndex]);

  if (FObjectIndex < 0) or (FObjectIndex >= lList.Count) then Exit;

  Result := TppComponent(lList[FObjectIndex]);

end; {procedure, function}

{------------------------------------------------------------------------------}
{ TppCustomBand.CategorizeObjects }

procedure TppCustomBand.CategorizeObjects;
var
  liObjects: Integer;
  liObject: Integer;
  lObject: TppComponent;

  procedure AddObjectToList(var aList: TList; aObject: TObject; aListRank: Integer);
  begin

    if (aList = nil) then
      begin
        aList := TList.Create;

        FObjectLists.AddObject(IntToStr(aListRank), aList);
      end;

    aList.Add(lObject);

  end; {procedure, AddObjectToList}

  
begin

  {get number of objects}
  liObjects := ObjectCount;

  {categorize objects}
  for liObject := 0 to liObjects - 1 do
    begin
      lObject := Objects[liObject];

      {save object's z-order}
      lObject.ZOrder := liObject;

      if (lObject is TppStretchable) then
        begin
          if (TppStretchable(lObject).ShiftRelativeTo = nil) and
             (TppStretchable(lObject).Region = nil) then
             begin
               if TppStretchable(lObject).Stretch then
                 AddObjectToList(FStretchables, lObject, 2)

               else if lObject.StretchWithParent then
                 AddObjectToList(FStretchers, lObject, 3)

               else if lObject.ShiftWithParent then
                 AddObjectToList(FShifters, lObject, 4)

               else
                 AddObjectToList(FStatics, lObject, 1);

             end;
        end

      else if (lObject.Region = nil) then
        begin

          if lObject.StretchWithParent then
            AddObjectToList(FStretchers, lObject, 3)

          else if lObject.ShiftWithParent then
            AddObjectToList(FShifters, lObject, 4)

          else
            AddObjectToList(FStatics, lObject, 1);

      end; {if, object is stretchable}
      
    end; {for, each object}

  FObjectLists.Sort;

end; {procedure, CategorizeObjects}

{------------------------------------------------------------------------------}
{ TppCustomBand.Generate }

procedure TppCustomBand.Generate;
begin

  FGenerating := True;
  FGenerationComplete := False;
  FOutOfSpace := False;
  FCount := 0;

  {allow descendant's to do something}
  BeforeGenerate;

  {added 6.04 - must initialize space used here in case band does not generate
   at all.}
  FSpaceUsed := 0;

  while not(CheckForEndOfGeneration) do

    begin
      {init printing properties}
      FAllObjectsPrinted := True;
      FMaxStretchable := nil;
      FObjectSaved := False;
      FObjectListSaved := False;
      FObjectOverFlow := False;
      FPrintQueue.Clear;
      FSpaceUsed := 0;

      ResetObjects;

      {fire BeforePrint event}
      BeforePrint;

      {calculate the height used by the band}
      CalcPrintPosition;

      if (Visible) then
        begin

          {allow objects to generate}
          if not(FOutOfSpace) then
            begin
              {increment band counters}
              if not(OverFlow) and not(PartialGeneration) then
                Report.Engine.ReportBandCount := Report.Engine.ReportBandCount + 1;
                
              Report.Engine.PageBandCount := Report.Engine.PageBandCount + 1;
              FCount := FCount + 1;

              {allow descendant's to do something}
              BeforeObjectGenerate;

              GenerateObjects(FObjectListIndex, FObjectIndex);

              {allow descendant's to do something}
              AfterObjectGenerate;

              {update print position}
              UpdatePrintPosition;
            end;

          {allow objects to create print commands}
          Print(Report.Engine.Page);

      end; {if, band is visible}

      {end generation if band not visible}
      GenerationComplete := not(Visible);

      {fire AfterPrint event}
      AfterPrint;

      {let the app catch up}
      Report.ProcessMessages;

    end; {while, not end of generation}

  {allow descendants to do something here}
  AfterGenerate;

  FGenerating := False;

end; {procedure, Generate}

{------------------------------------------------------------------------------}
{ TppCustomBand.ResetObjects }

procedure TppCustomBand.ResetObjects;
var
  liObject: Integer;
  liObjects: Integer;
begin
  if FOverFlow or FPartialGeneration then Exit;

  liObjects := ObjectCount;

  for liObject := 0 to liObjects - 1 do
    Objects[liObject].DrawComponent := True;

end; {procedure, ResetObjects}

{------------------------------------------------------------------------------}
{ TppCustomBand.CheckForEndofGeneration }

function TppCustomBand.CheckForEndofGeneration: Boolean;
begin

  Result := False;

  if GenerationComplete then
    Result := True

  else if Report.Engine.StopPrinting then
    Result := True

  else if FOutOfSpace then
    Result := True

  else if (PrintTimes = ptOne) and (FCount = 1) then
    Result := True

  else if (PrintTimes = ptCount) and (FCount = PrintCount) then
    Result := True

  else if ((PrintCondition * Report.Engine.PrintCondition) = []) then
    Result := True;

end; {function, CheckForEndofGeneration}

{------------------------------------------------------------------------------}
{ TppCustomBand.CalcPrintPosition }

procedure TppCustomBand.CalcPrintPosition;
var
  lRect: TppRect;
  llHeight: Integer;
begin

  {set page bottom}
  FPageBottom := Report.Engine.PageBottom - mmBottomOffset;

  {set starting position}
  FStartingPosition := Report.Engine.PrintPosRect.Top;

  {adjust starting position to support PrintPosition property}
  AdjustStartingPosition;

  {determine if band can fit on page}
  if (PrintHeight = phStatic) then
    llHeight := mmHeight
  else
    llHeight := 0;

  if Visible and ((FStartingPosition + llHeight) > FPageBottom) then
    begin
      FOutOfSpace := True;

      Exit;
    end;

  {set print position}
  lRect.Left   := Report.Engine.PrintPosRect.Left;
  lRect.Top    := FStartingPosition;
  lRect.Right  := Report.Engine.PrintPosRect.Right;

  if (PrintHeight = phStatic) then
    lRect.Bottom := lRect.Top + mmHeight
  else
    lRect.Bottom := FPageBottom;

  FPrintPosRect := lRect;

  FCurrentPosition := PrintPosRect.Top;

  FMaxStretchablePosition := 0;

  FCurrentPartialAdjustment := FPartialAdjustment;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppCustomBand.AdjustStartingPosition }

procedure TppCustomBand.AdjustStartingPosition;
var
  lsMessage: String;
begin

  if (mmPrintPosition <> 0) then
    begin

      if (mmPrintPosition >= FPageBottom) then
        begin
          lsMessage := ppLoadStr(415);
          Report.RaiseException(EPrintError.Create(lsMessage + '.'));
        end

      else if (mmPrintPosition < FStartingPosition) or
              ((PrintHeight = phStatic) and ((mmPrintPosition + mmHeight) > FPageBottom) ) then
        begin
          if (FPrintPositionBreak) then
            FPrintPositionBreak := False
          else
            begin
              FOutOfSpace := True;

              FPrintPositionBreak := True;
            end;
        end
      else
        begin
          if (FPrintPositionBreak) then
            FPrintPositionBreak := False;

          FStartingPosition := mmPrintPosition;
        end;

    end;

end; {procedure, AdjustStartingPosition}

{------------------------------------------------------------------------------}
{ TppCustomBand.UpdatePrintPosition }

procedure TppCustomBand.UpdatePrintPosition;
var
  lRect: TppRect;
begin
  lRect := PrintPosRect;

  if (PrintHeight = phStatic) then
    FSpaceUsed := mmHeight
  else
    FSpaceUsed := FSpaceUsed;

  FSpaceUsed := FSpaceUsed + mmBottomOffset;

  lRect.Top := lRect.Top + FSpaceUsed;
  lRect.Bottom := lRect.Top;

  Report.Engine.SetPrintPosition(lRect.Left, lRect.Top, lRect.Right, lRect.Top);

  Report.Engine.SpaceUsed := Report.Engine.SpaceUsed + FSpaceUsed;

end;{procedure, UpdatePrintPosition}

{------------------------------------------------------------------------------}
{ TppCustomBand.Print }

procedure TppCustomBand.Print(aPage: TppPage);
var
  liComponent: Integer;
  liComponents: Integer;
  lComponent: TppComponent;
begin

  if not DrawPage then Exit;

  CreateDrawCommand(aPage);

  liComponents := FPrintQueue.Count;

  {sort objects by z-order}
  FPrintQueue.Sort;

  for liComponent := 0 to liComponents - 1 do
    begin
      lComponent := TppComponent(FPrintQueue.Objects[liComponent]);

      lComponent.Print(aPage);

      {let the app catch up}
      Report.ProcessMessages;
    end;

end; {procedure, Print}

{------------------------------------------------------------------------------}
{ TppCustomBand.GenerateObjects }

procedure TppCustomBand.GenerateObjects(aListIndex, aObjectIndex: Integer);
var
  liListIndex: Integer;
  liLists: Integer;
  lList: TList;
  liObjectIndex: Integer;
begin

  {generate any reprintonoverflow statics first}
  if OverFlow and (FStatics <> nil) and not(PrintingSection) and (aListIndex <> 0) and not(PartialGeneration) then
    ProcessQueue(FStatics, 0);

  {loop thru object lists, processing each one}
  liListIndex := aListIndex;
  liObjectIndex := aObjectIndex;

  liLists := FObjectLists.Count;

  while (liListIndex < liLists) do
    begin
      lList := TList(FObjectLists.Objects[liListIndex]);

      ProcessQueue(lList, liObjectIndex);

      if not(AllObjectsPrinted) and not(FObjectListSaved) then
        begin
          FObjectListSaved := True;
          FObjectListIndex := liListIndex;
        end;

      {go to next list}
      if not(FPrintingSection) then
        begin
          Inc(liListIndex);

          liObjectIndex := 0;

          {if stretchables don't fit, we're done}
          if (FStretchables <> nil) and (lList = FStretchables) and (SpaceUsed = 0) then
            liListIndex := liLists;
        end
      else
        liListIndex := liLists;

      {let the app catch up}
      Report.ProcessMessages;

    end; {while, each object list}

  {set overflow status}
  FOverFlow := FObjectOverFlow;

  if (FOverFlow) and (FPrintQueue.Count = 0) then
    FOverFlow := False;

  {set partial generation status}
  FPartialGeneration := not(FAllObjectsPrinted) and not(FOverFlow);

  FPartialAdjustment := FCurrentPartialAdjustment;

  if (FPartialGeneration) and (FPrintQueue.Count = 0) then
    FPartialAdjustment := 0

  else if not(FPartialGeneration) then
    FPartialAdjustment := mmHeight;

  {reset object indexes}
  if (FAllObjectsPrinted) then
    begin
      FObjectListIndex := 0;
      FObjectIndex := 0;
    end;

  {set out of space status}
  if (FPartialGeneration) or (FOverFlow) then
    FOutOfSpace := True;

end; {procedure, GenerateObjects}

{------------------------------------------------------------------------------}
{ TppCustomBand.ProcessQueue }

procedure TppCustomBand.ProcessQueue(aQueue: TList; aObjectIndex: Integer);
var
  liComponent: Integer;
  lComponent: TppComponent;
  lbContinuingPartialGen: Boolean;
  lbAllObjectsPrinted: Boolean;
begin

  liComponent := aObjectIndex;

  lbContinuingPartialGen := FPartialGeneration;
  lbAllObjectsPrinted := FAllObjectsPrinted;

  FCumulativeCurrentPosition := FCurrentPosition;

  while (liComponent < aQueue.Count) and not(GenerationComplete) do
    begin
      lComponent := TppComponent(aQueue[liComponent]);

      lComponent.Generate;

      {add the object to the print queue}
      if (lComponent.SpaceUsed > 0) then
        FPrintQueue.AddObject(Format('%8d', [lComponent.ZOrder]), lComponent);

      {indicate that object did not print completely}
      SaveOverFlowObject(lComponent, liComponent);

      {add to current position}
      IncrementCurrentPosition(lComponent);

      {finish the section}
      if (FPrintingSection) then
        CompleteSection(lComponent, liComponent, aQueue);

      {goto next component}
      Inc(liComponent);

      {let the app catch up}
      Report.ProcessMessages;

    end; {while, each object}

  if (FCumulativeCurrentPosition <> FCurrentPosition) then
    begin
      FCurrentPosition := FCumulativeCurrentPosition;
      FSpaceUsed := FCurrentPosition - PrintPosRect.Top;
    end;

  if lbContinuingPartialGen and not(FAllObjectsPrinted) and (lbAllObjectsPrinted) and (FObjectIndex < aQueue.Count) then
    FCurrentPartialAdjustment :=  TppComponent(aQueue[FObjectIndex]).mmTop;

end; {procedure, ProcessQueue}

{------------------------------------------------------------------------------}
{ TppCustomBand.SaveOverFlowObject }

procedure TppCustomBand.SaveOverFlowObject(aObject: TppComponent; aObjectIndex: Integer);
begin

  if (aObject.GenerationComplete) then Exit;

  {if this component was the first not to print, save it's position in the list}
  if not(FObjectSaved) then
    begin
      FObjectSaved := True;
      FObjectIndex := aObjectIndex;

      if (aObject is TppStretchable) and TppStretchable(aObject).Stretch then
        FObjectOverFlow := True
      else
        FObjectOverFlow := False;

      FAllObjectsPrinted := False;
    end;

  {4.22, enables Stretchable.KeepTogether to work when ShiftWithParent is orphaned}
  {if (FPartialAdjustment = -1) then
    FPartialAdjustment := mmHeight;}

  if (FCurrentPartialAdjustment = 0) then
    FCurrentPartialAdjustment := mmHeight;

  if (aObject.mmTop < FCurrentPartialAdjustment) then
    FCurrentPartialAdjustment := aObject.mmTop;

end; {procedure, SaveOverFlowObject}

{------------------------------------------------------------------------------}
{ TppCustomBand.IncrementCurrentPosition }

procedure TppCustomBand.IncrementCurrentPosition(aObject: TppComponent);
var
  llCheckPosition: Integer;
begin

  if (PrintHeight = phStatic) or (FPrintingSection) then Exit;

  {default max stretchable, if possible}
  if (aObject is TppStretchable) and (FMaxStretchable = nil) then
    FMaxStretchable := TppStretchable(aObject);

  if (aObject.SpaceUsed = 0) then Exit;

  llCheckPosition := aObject.PrintPosRect.Top + aObject.SpaceUsed;

  if (llCheckPosition > FCumulativeCurrentPosition) then
    FCumulativeCurrentPosition := llCheckPosition;

  if (aObject is TppStretchable) and (llCheckPosition > FMaxStretchablePosition) then
    begin
      FMaxStretchablePosition := llCheckPosition;
      FMaxStretchable := TppStretchable(aObject);
    end;

end; {procedure, IncrementCurrentPosition}

{------------------------------------------------------------------------------}
{ TppCustomBand.CompleteSection }

procedure TppCustomBand.CompleteSection(aObject: TppComponent; aObjectIndex: Integer; aQueue: TList);
var
  lRect: TppRect;
  lNextObject: TppComponent;
begin

  if not(FPrintingSection) then Exit;

  if not(aObject.GenerationComplete) then
    begin
      GenerationComplete := True;

      Exit;
    end;

  if (aObjectIndex + 1 < aQueue.Count) then
    lNextObject := TppComponent(aQueue[aObjectIndex + 1])
  else
    lNextObject := nil;

  if (lNextObject <> nil) and (lNextObject is TppSubReport) and
     (TppSubReport(lNextObject).PrintBehavior = pbSection) then
    begin
      {indicate to next section that space has been used}
      if aObject.Visible and (aObject.SpaceUsed > 0) then
        FSpaceUsed := aObject.SpaceUsed;
    end
  else
    begin
      {use up remaining space}
      FCurrentPosition := PageBottom;
      FCumulativeCurrentPosition := FCurrentPosition;
      FSpaceUsed := FCurrentPosition - PrintPosRect.Top;

      lRect := PrintPosRect;
      lRect.Top := PageBottom;
      lRect.Bottom := PageBottom;
      PrintPosRect := lRect;

      FPrintingSection := False;
      FPartialGeneration := False;
      
      if (PrintHeight = phDynamic) then
        FPartialAdjustment := -1;
        
    end;

end; {procedure, CompleteSection}

{------------------------------------------------------------------------------}
{ TppCustomBand.AfterGenerate }

procedure TppCustomBand.AfterGenerate;
begin

end; {procedure, AfterGenerate}

{------------------------------------------------------------------------------}
{ TppCustomBand.BeforeObjectGenerate }

procedure TppCustomBand.BeforeObjectGenerate;
begin
  DoBeforeGenerate;
end; {procedure, BeforeObjectGenerate}

{------------------------------------------------------------------------------}
{ TppCustomBand.AfterObjectGenerate }

procedure TppCustomBand.AfterObjectGenerate;
begin
  DoAfterGenerate;
end; {procedure, AfterObjectGenerate}

{------------------------------------------------------------------------------}
{ TppCustomBand.AfterPrint }

procedure TppCustomBand.AfterPrint;
var
  liObject: Integer;
begin

  {notify objects}
  for liObject := 0 to ObjectCount - 1 do
    Objects[liObject].AfterPrint;

  {fire event}
  if not(OutOfSpace) or (OverFlow) then
    DoAfterPrint;

end; {procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppCustomBand.BeforeGenerate }

procedure TppCustomBand.BeforeGenerate;
begin

end; {procedure, BeforeGenerate}

{------------------------------------------------------------------------------}
{ TppCustomBand.CanAdvanceData }

function TppCustomBand.CanAdvanceData: Boolean;
begin
  Result := False;
end; {function, IsFooterBand}

{------------------------------------------------------------------------------}
{ TppCustomBand.BeforePrint }

procedure TppCustomBand.BeforePrint;
var
  liObject: Integer;
begin

  if (CanAdvanceData) then
    Report.Engine.SyncData;

  {notify objects}
  for liObject := 0 to ObjectCount - 1 do
    Objects[liObject].BeforePrint;

  {fire event}
  DoBeforePrint;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppCustomBand.CreateDrawCommand }

procedure TppCustomBand.CreateDrawCommand(aPage: TppPage);
begin

end; {procedure, CreateDrawCommand}

{@TppCustomBand.EventNotify}

procedure TppCustomBand.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
var
  lDrawCommand: TppDrawCommand;
begin

  if aEventID = ciPrintableDrawCommandCreate then
    begin
      aParams.GetParamValue(0, lDrawCommand);

      FDrawCommands.Add(lDrawCommand);
    end;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppCustomBand.GetPropUserName }

function TppCustomBand.GetPropUserName: TComponentName;
begin

  Result := inherited GetPropUserName;

  if Result = '' then
    Result := GetDefaultUserName

end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppCustomBand.PageStart }

procedure TppCustomBand.PageStart;
begin

  inherited;

  FSpaceUsed := 0;

end; {procedure, PageStart}

{******************************************************************************
 *
 **  P A G E   S T Y L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageStyle.Create}

constructor TppPageStyle.Create(aOwner : TComponent);
begin
  inherited Create(aOwner);

  CaptionIndex := 691;

  FTraverseData := False;
  FDataPipeline := nil;
  FEndPage := 0;
  FPageList := nil;
  FPageSetting := psAll;
  FSinglePage := 0;
  FStartPage := 0;
  FValidPages := '';

end; {constructor, TppPageStyle}

{------------------------------------------------------------------------------}
{ TppPageStyle.Destroy }

destructor TppPageStyle.Destroy;
begin

  FPageList.Free;

  inherited Destroy;

end; {destructor, TppPageStyle}

{------------------------------------------------------------------------------}
{ TppPageStyle.GetPropUserName }

function TppPageStyle.GetPropUserName: TComponentName;
begin
  Result := 'PageStyle'; {do not localize}
end; {function, GetPropUserName}

{------------------------------------------------------------------------------}
{ TppPageStyle.GetDefaultPrintTimes }

function TppPageStyle.GetDefaultPrintTimes: TppPrintTimesType;
begin
  Result := ptOne;
end; {function, GetDefaultPrintTimes}

{------------------------------------------------------------------------------}
{ TppPageStyle.GetPrintCondition }

function TppPageStyle.GetPrintCondition: TppPrintConditions;
begin
  Result := [pppcStartOfPage];
end; {function, GetPrintCondition}

{------------------------------------------------------------------------------}
{ TppPageStyle.GetRank }

function TppPageStyle.GetRank: String;
begin
  {if designing, list page style last, if printing, put it before header}
  if Report.Printing then
    Result := Format('%8d',[0])
  else
    Result := Format('%8d',[10]);
end; {function, GetRank}

{------------------------------------------------------------------------------}
{ TppPageStyle.IsColumnar }

function TppPageStyle.IsColumnar: Boolean;
begin
  Result := False;
end; {function, IsColumnar}

{------------------------------------------------------------------------------}
{ TppPageStyle.IsDataAware }

function TppPageStyle.IsDataAware: Boolean;
begin
  Result := True;
end; {function, IsDataAware}

{------------------------------------------------------------------------------}
{ TppPageStyle.Init}

procedure TppPageStyle.Init;
begin

  inherited Init;

  FTraverseData := False;

  if (Report = nil) then Exit;

  FTraverseData := (FDataPipeline <> nil) and (Report.DataPipeline = nil);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppPageStyle.CanAdvanceData }

function TppPageStyle.CanAdvanceData: Boolean;
begin
  Result := True;
end; {function, CanAdvanceData}

{------------------------------------------------------------------------------}
{ TppPageStyle.GetPageList }

function TppPageStyle.GetPageList: TStrings;
begin

  if (FPageList = nil) then
    FPageList := TStringList.Create;

  Result := FPageList;

end; {function, GetPageList}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetEndPage }

procedure TppPageStyle.SetEndPage(aPageNo: Integer);
begin

  if (Report <> nil) and (Report.Printing) then Exit;

  if (FEndPage <> aPageNo) then
    begin
      FEndPage := aPageNo;

      {notify report designer}
      PropertyChange;

      Reset;
    end;

end; {procedure, SetEndPage}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetPageList }

procedure TppPageStyle.SetPageList(aPageList: TStrings);
begin

  if (Report <> nil) and (Report.Printing) then Exit;

  GetPageList.Assign(aPageList);

  {notify report designer}
  PropertyChange;

  Reset;

end; {procedure, SetPageList}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetPageSetting }

procedure TppPageStyle.SetPageSetting(aPageSetting: TppPageSettingType);
begin

  if (Report <> nil) and (Report.Printing) then Exit;

  if (FPageSetting <> aPageSetting) then
    begin
      FPageSetting := aPageSetting;

      {notify report designer}
      PropertyChange;

      Reset;
    end;

end; {procedure, SetPageSetting}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetSinglePage }

procedure TppPageStyle.SetSinglePage(aPageNo: Integer);
begin

  if (Report <> nil) and (Report.Printing) then Exit;

  if (FSinglePage <> aPageNo) then
    begin
      FSinglePage := aPageNo;

      {notify report designer}
      PropertyChange;

      Reset;
    end;

end; {procedure, SetSinglePage}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetStartPage }

procedure TppPageStyle.SetStartPage(aPageNo: Integer);
begin

  if (Report <> nil) and (Report.Printing) then Exit;

  if (FStartPage <> aPageNo) then
    begin
      FStartPage := aPageNo;

      {notify report designer}
      PropertyChange;

      Reset;
    end;

end; {procedure, SetStartPage}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetValidPages }

procedure TppPageStyle.SetValidPages(Value: String);
begin

  if (Report <> nil) and (Report.Printing) then Exit;

  if (FValidPages <> Value) then
    begin
      FValidPages := Value;

      {parse pages}
      ppTextToPageList(FValidPages, PageList, True);

      SetPageSetting(psPageList);

      {notify report designer}
      PropertyChange;

      Reset;
    end;

end; {procedure, SetValidPages}

{------------------------------------------------------------------------------}
{ TppPageStyle.IsActive }

function TppPageStyle.IsActive: Boolean;
var
  llPageNo: Integer;
  lsPageNo: String;
begin

  llPageNo := Report.MainReport.AbsolutePageNo;

  case FPageSetting of

    psAll:
      Result := Visible;

    psPageList:
      begin
        lsPageNo := IntToStr(llPageNo);

        Result := (PageList.IndexOf(lsPageNo) <> -1)
      end;

    psSinglePage:
      Result := (llPageNo = FSinglePage);

    psFirstPage:
      Result := (llPageNo = 1);

    psLastPage:
      Result := Report.MainReport.Engine.FirstPassCompleted and (llPageNo = Report.MainReport.AbsolutePageCount);

    psPageRange:
      Result := ((llPageNo >= FStartPage) and (llPageNo >= FEndPage));

    else
      Result := False;

  end; {case}

end; {function, IsActive}

{------------------------------------------------------------------------------}
{ TppPageStyle.SetDataPipeline }

procedure TppPageStyle.SetDataPipeline(aDataPipeline: TppDataPipeline);
var
  lOldDataPipeline: TppDataPipeline;
  lNewDataPipeline: TppDataPipeline;
begin

  lOldDataPipeline := FDataPipeline;
  lNewDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.RemoveNotify(Self);

  FDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.AddNotify(Self);

  {this causes the caption to change}
  Notify(FDataPipeline, ppopDataChange);

  if (csReading in ComponentState) or (csLoading in ComponentState) or
     (pppcTemplateLoading in DesignState) then Exit;

  Reset;

  {do this AFTER FDataPipeline assigned}
  {any data-aware components with the same datapipeline need to be updated}
  UpdateParentDataPipeline(lNewDataPipeline, lOldDataPipeline);

end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppPageStyle.UpdateParentDataPipeline }

procedure TppPageStyle.UpdateParentDataPipeline(aNewDataPipeline, aOldDataPipeline: TppDataPipeline);
var
  liObject: Integer;
  lObject: TppComponent;
begin

  {update datapipeline property of components}
  for liObject := 0 to ObjectCount - 1 do
    begin
      lObject := Objects[liObject];

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

end; {procedure, UpdateParentDataPipeline}

{------------------------------------------------------------------------------}
{ TppPageStyle.Notify }

procedure TppPageStyle.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (aCommunicator = FDataPipeline) then
    begin
      FDataPipeline := nil;

      Report.Reset;
    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppPageStyle.AdjustStartingPosition }

procedure TppPageStyle.AdjustStartingPosition;
begin

  inherited AdjustStartingPosition;

end; {procedure, AdjustStartingPosition}

{------------------------------------------------------------------------------}
{ TppPageStyle.GetADataPipeline }

function TppPageStyle.GetADataPipeline: TppDataPipeline;
begin
  Result := FDataPipeline
end; {function, GetADataPipeline}

{------------------------------------------------------------------------------}
{ TppPageStyle.BeforePrint }

procedure TppPageStyle.BeforePrint;
begin

  {determine whether page style should print on this page}
  Visible := IsActive;

  inherited BeforePrint;
  
end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppPageStyle.BeforeObjectGenerate }

procedure TppPageStyle.BeforeObjectGenerate;
begin

  {Report.Engine.SyncData;}

  inherited BeforeObjectGenerate;

end; {procedure, BeforeObjectGenerate}

{------------------------------------------------------------------------------}
{ TppPageStyle.CalcPrintPosition }

procedure TppPageStyle.CalcPrintPosition;
var
  lRect: TppRect;
begin

  FSavePrintPos := Report.Engine.PrintPosRect;

  PageBottom :=  Report.Engine.Page.PageDef.mmHeight - Report.Engine.Page.PageDef.mmMarginBottom;
  StartingPosition := Report.Engine.Page.PageDef.mmMarginTop;

  lRect.Left := Report.Engine.PrintPosRect.Left;
  lRect.Top := StartingPosition;
  lRect.Right := Report.Engine.PrintPosRect.Right;
  lRect.Bottom := StartingPosition + mmHeight;

  PrintPosRect := lRect;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppPageStyle.AfterPrint }

procedure TppPageStyle.AfterPrint;
begin

  inherited AfterPrint;

  if not(OverFlow) then
    begin
      GenerationComplete := True;

      if (FTraverseData) then
        begin
          FDataPipeline.Next;

          if FDataPipeline.EOF then
            Report.DataTraversalCompleted;
        end;
    end;

  {record space utilization, in case this is the only band}
  Report.Engine.SpaceUsed := PrintPosRect.Bottom;

  {undo any space utilization}
  Report.Engine.SetPrintPosition(FSavePrintPos.Left, FSavePrintPos.Top, FSavePrintPos.Right, FSavePrintPos.Top);

end;{procedure, AfterPrint}

{------------------------------------------------------------------------------}
{ TppPageStyle.AfterObjectGenerate }

procedure TppPageStyle.AfterObjectGenerate;
begin

  inherited AfterObjectGenerate;

end; {procedure, AfterObjectGenerate}

{*******************************************************************************
*
** B A N D B A C K G R O U N D
*
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBandBackgroundSettings.Create }

constructor TppBandBackgroundSettings.Create(aOwner: TComponent);
begin
  inherited Create;

  FBrush := TBrush.Create;
  FBrush.Style := bsClear;

  FOwner := aOwner;

  FGradient := TppGradient.Create(FOwner);

end;

{------------------------------------------------------------------------------}
{ TppBandBackgroundSettings.Destroy }

destructor TppBandBackgroundSettings.Destroy;
begin
  FGradient.Free;
  FGradient := nil;

  FBrush.Free;
  FBrush := nil;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppBandBackgroundSettings.Assign }

procedure TppBandBackgroundSettings.Assign(Source: TPersistent);
var
  lBandBackgroundSettings: TppBandBackgroundSettings;
begin

  lBandBackgroundSettings := TppBandBackgroundSettings(Source);

  FBrush.Assign(lBandBackgroundSettings.Brush);
  FGradient.Assign(lBandBackgroundSettings.Gradient);

end;

{------------------------------------------------------------------------------}
{ TppBandBackgroundSettings.SetBrush }

procedure TppBandBackgroundSettings.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);

end;

{------------------------------------------------------------------------------}
{ TppBandBackgroundSettings.SetGradient }

procedure TppBandBackgroundSettings.SetGradient(const Value: TppGradient);
begin
  FGradient.Assign(Value);

end;

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
 ** C U S T O M   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomBandRTTI.RefClass }

class function TraTppCustomBandRTTI.RefClass: TClass;
begin
  Result := TppCustomBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomBandRTTI.GetPropList }

class procedure TraTppCustomBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Count');
  aPropList.AddProp('OverFlow');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomBandRTTI.GetPropRec }

class function TraTppCustomBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AllObjectsPrinted') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'Count') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'CurrentObject') then
    ClassPropToRec(aPropName, TppComponent, True, aPropRec)

  else if ppEqual(aPropName, 'CurrentPosition') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'CumulativeCurrentPosition') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'Generating') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'GenerationComplete') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'MaxStretchable') then
    ClassPropToRec(aPropName, TppStretchable, True, aPropRec)

  else if ppEqual(aPropName, 'OutOfSpace') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'OverFlow') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'PageBottom') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PartialGeneration') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'PartialAdjustment') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'PrintingSection') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'PrintPositionBreak') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'SpaceUsed') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'StartingPosition') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomBandRTTI.GetPropValue }

class function TraTppCustomBandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AllObjectsPrinted') then
    Boolean(aValue) := TppCustomBand(aObject).AllObjectsPrinted

  else if ppEqual(aPropName, 'Count') then
    Integer(aValue) := TppCustomBand(aObject).Count

  else if ppEqual(aPropName, 'CurrentObject') then
    Integer(aValue) := Integer(TppCustomBand(aObject).CurrentObject)

  else if ppEqual(aPropName, 'CurrentPosition') then
    Integer(aValue) := TppCustomBand(aObject).CurrentPosition

  else if ppEqual(aPropName, 'CumulativeCurrentPosition') then
    Integer(aValue) := TppCustomBand(aObject).CumulativeCurrentPosition

  else if ppEqual(aPropName, 'Generating') then
    Boolean(aValue) := TppCustomBand(aObject).Generating

  else if ppEqual(aPropName, 'GenerationComplete') then
    Boolean(aValue) := TppCustomBand(aObject).GenerationComplete

  else if ppEqual(aPropName, 'MaxStretchable') then
    Integer(aValue) := Integer(TppCustomBand(aObject).MaxStretchable)

  else if ppEqual(aPropName, 'OutOfSpace') then
    Boolean(aValue) := TppCustomBand(aObject).OutOfSpace

  else if ppEqual(aPropName, 'OverFlow') then
    Boolean(aValue) := TppCustomBand(aObject).OverFlow

  else if ppEqual(aPropName, 'PageBottom') then
    Integer(aValue) := TppCustomBand(aObject).PageBottom

  else if ppEqual(aPropName, 'PartialGeneration') then
    Boolean(aValue) := TppCustomBand(aObject).PartialGeneration

  else if ppEqual(aPropName, 'PartialAdjustment') then
    Integer(aValue) := TppCustomBand(aObject).PartialAdjustment

  else if ppEqual(aPropName, 'PrintingSection') then
    Boolean(aValue) := TppCustomBand(aObject).PrintingSection

  else if ppEqual(aPropName, 'PrintPositionBreak') then
    Boolean(aValue) := TppCustomBand(aObject).PrintPositionBreak

  else if ppEqual(aPropName, 'SpaceUsed') then
    Integer(aValue) := TppCustomBand(aObject).SpaceUsed

  else if ppEqual(aPropName, 'StartingPosition') then
    Integer(aValue) := TppCustomBand(aObject).StartingPosition

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{******************************************************************************
 *
 ** P A G E   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppPageBandRTTI.RefClass }

class function TraTppPageBandRTTI.RefClass: TClass;
begin
  Result := TppPageBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppPageBandRTTI.GetPropList }

class procedure TraTppPageBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppPageBandRTTI.GetPropRec }

class function TraTppPageBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'PrintHeight') then
    EnumPropToRec(aPropName, 'TppPrintHeightType', True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}


{******************************************************************************
 *
 ** R E P O R T   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppReportBandRTTI.RefClass }

class function TraTppReportBandRTTI.RefClass: TClass;
begin
  Result := TppReportBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppReportBandRTTI.GetPropList }

class procedure TraTppReportBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppReportBandRTTI.GetPropRec }

class function TraTppReportBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'NewPage') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppReportBandRTTI.GetPropValue }

class function TraTppReportBandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'NewPage') then
    Boolean(aValue) := TppReportBand(aObject).NewPage

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppReportBandRTTI.SetPropValue }

class function TraTppReportBandRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'NewPage') then
    TppReportBand(aObject).NewPage := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** F O O T E R   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppFooterBandRTTI.RefClass }

class function TraTppFooterBandRTTI.RefClass: TClass;
begin
  Result := TppFooterBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppFooterBandRTTI.GetPropList }

class procedure TraTppFooterBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppFooterBandRTTI.GetPropRec }

class function TraTppFooterBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'PrintHeight') then
    EnumPropToRec(aPropName, 'TppPrintHeightType', True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}


{******************************************************************************
 *
 ** D E T A I L   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDetailBandRTTI.RefClass }

class function TraTppDetailBandRTTI.RefClass: TClass;
begin
  Result := TppDetailBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDetailBandRTTI.GetPropList }

class procedure TraTppDetailBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('BandsPerRecordCount');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDetailBandRTTI.GetPropRec }

class function TraTppDetailBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'BandsPerRecord') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if ppEqual(aPropName, 'BandsPerRecordCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'DataPipeline') then
    ClassPropToRec(aPropName, TppDataPipeline, False, aPropRec)

  else if ppEqual(aPropName, 'PrintCount') then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDetailBandRTTI.GetPropValue }

class function TraTppDetailBandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'BandsPerRecord') then
    Integer(aValue) := TppDetailBand(aObject).BandsPerRecord

  else if ppEqual(aPropName, 'BandsPerRecordCount') then
    Integer(aValue) := TppDetailBand(aObject).BandsPerRecordCount

  else if ppEqual(aPropName, 'DataPipeline') then
    Integer(aValue) := Integer(TppDetailBand(aObject).DataPipeline)

  else if ppEqual(aPropName, 'PrintCount') then
    Integer(aValue) := TppDetailBand(aObject).PrintCount

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDetailBandRTTI.SetPropValue }

class function TraTppDetailBandRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'BandsPerRecord') then
    TppDetailBand(aObject).BandsPerRecord := Integer(aValue)

  else if ppEqual(aPropName, 'DataPipeline') then
    TppDetailBand(aObject).DataPipeline := TppDataPipeline(aValue)

  else if ppEqual(aPropName, 'PrintCount') then
    TppDetailBand(aObject).PrintCount := Integer(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** C O L U M N   F O O T E R   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppColumnFooterBandRTTI.RefClass }

class function TraTppColumnFooterBandRTTI.RefClass: TClass;
begin
  Result := TppColumnFooterBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppColumnFooterBandRTTI.GetPropList }

class procedure TraTppColumnFooterBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppColumnFooterBandRTTI.GetPropRec }

class function TraTppColumnFooterBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'PrintHeight') then
    EnumPropToRec(aPropName, 'TppPrintHeightType', True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}


{******************************************************************************
 *
 ** G R O U P   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppGroupBandRTTI.RefClass }

class function TraTppGroupBandRTTI.RefClass: TClass;
begin
  Result := TppGroupBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppGroupBandRTTI.GetPropList }

class procedure TraTppGroupBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('Group');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppGroupBandRTTI.GetPropRec }

class function TraTppGroupBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Description') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'Generation') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if ppEqual(aPropName, 'Group') then
    ClassPropToRec(aPropName, TppGroup, False, aPropRec)

  else if ppEqual(aPropName, 'SaveGeneration') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppGroupBandRTTI.GetPropValue }

class function TraTppGroupBandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Description') then
    String(aValue) := TppGroupBand(aObject).Description

  else if ppEqual(aPropName, 'Generation') then
    Boolean(aValue) := TppGroupBand(aObject).Generation

  else if ppEqual(aPropName, 'Group') then
    Integer(aValue) := Integer(TppGroupBand(aObject).Group)

  else if ppEqual(aPropName, 'SaveGeneration') then
    Boolean(aValue) := TppGroupBand(aObject).SaveGeneration

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppGroupBandRTTI.SetPropValue }

class function TraTppGroupBandRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Group') then
    TppGroupBand(aObject).Group := TppGroup(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** G R O U P   H E A D E R   B A N D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppGroupHeaderBandRTTI.RefClass }

class function TraTppGroupHeaderBandRTTI.RefClass: TClass;
begin
  Result := TppGroupHeaderBand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppGroupHeaderBandRTTI.GetPropList }

class procedure TraTppGroupHeaderBandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('AlreadyPageBreak');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppGroupHeaderBandRTTI.GetPropRec }

class function TraTppGroupHeaderBandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AlreadyPageBreak') then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppGroupHeaderBandRTTI.GetPropValue }

class function TraTppGroupHeaderBandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'AlreadyPageBreak') then
    Boolean(aValue) := TppGroupHeaderBand(aObject).AlreadyPageBreak

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppHeaderBand, TppTitleBand, TppDetailBand, TppSummaryBand, TppFooterBand,
                   TppGroupHeaderBand, TppGroupFooterBand,
                   TppColumnHeaderBand, TppColumnFooterBand,
                   TppPageStyle]);

  raRegisterRTTI(TraTppCustomBandRTTI);
  raRegisterRTTI(TraTppPageBandRTTI);
  raRegisterRTTI(TraTppReportBandRTTI);
  raRegisterRTTI(TraTppFooterBandRTTI);
  raRegisterRTTI(TraTppDetailBandRTTI);
  raRegisterRTTI(TraTppColumnFooterBandRTTI);
  raRegisterRTTI(TraTppGroupBandRTTI);
  raRegisterRTTI(TraTppGroupHeaderBandRTTI);

  raRegisterEnum('TppColumnTraversalType', TypeInfo(TppColumnTraversalType));

finalization

  UnRegisterClasses([TppHeaderBand, TppTitleBand, TppDetailBand, TppSummaryBand, TppFooterBand,
                     TppGroupHeaderBand, TppGroupFooterBand,
                     TppColumnHeaderBand, TppColumnFooterBand,
                     TppPageStyle]);

  raUnRegisterRTTI(TraTppCustomBandRTTI);
  raUnRegisterRTTI(TraTppPageBandRTTI);
  raUnRegisterRTTI(TraTppReportBandRTTI);
  raUnRegisterRTTI(TraTppFooterBandRTTI);
  raUnRegisterRTTI(TraTppDetailBandRTTI);
  raUnRegisterRTTI(TraTppColumnFooterBandRTTI);
  raUnRegisterRTTI(TraTppGroupBandRTTI);
  raUnRegisterRTTI(TraTppGroupHeaderBandRTTI);

  raUnRegisterEnum('TppColumnTraversalType');

end.
