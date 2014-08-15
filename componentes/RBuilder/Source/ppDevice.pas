{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppDevice;

interface

{$I ppIfDef.pas}

{.$DEFINE CodeSite}

uses
 {$IFDEF CodeSite} csIntf, {$ENDIF}
  Windows,
  Classes,
  SysUtils,
  SyncObjs,

  ppTypes,
  ppUtils,
  ppRTTI,
  ppComm,
  ppCollectionBase,
  ppForms,
  ppPrintr,
  ppRelatv,
  ppEmailSettings;


type

  {forward declarations}
  TppPage = class;
  TppPageRequest = class;
  TppDrawCommand = class;
  TppDevice = class;

  TppDrawCommandClass = class of TppDrawCommand;

  {@TppPublisher

    This class manages the communications between the report and the currently
    connected devices. When the Print or PrintToDevices method of the report is
    called, the publisher polls the connected devices, asking each one for the
    pages it would like to receive. The publisher then retrieves the pages,
    either from a cache of pages it has created from a previous run of the
    report or by requesting the pages from the report engine.  Once the pages
    are retrieved, they are sent to each of the devices, which render them
    appropriately. The publisher will only cache page output from the report
    when the report's CachePages property is set to true. If CachePages is set
    to false, the publisher will request the pages from the report engine each
    time it receives a request. It is easy to confuse the publisher's page
    caching with report engine caching.  The report engine always caches report
    progress so that it can quickly generate additional pages when they are
    requested.  This type of caching cannot be turned off and uses minimal
    resources. Publisher page caching saves the entire page image in the form of
    a TppPage object as each page is received from the report engine.  If the
    page contains large memo, richtext or image data, it can take up
    considerable resources. Page caching should be used with this limitation in
    mind.}

  TppPublisher = class(TppCommunicator)
  private
    FAbsolutePageCount: Longint;
    FCachePages: Boolean;
    FDevices: TList;
    FFirstPageRequest: Boolean;
    FStacks: TStringList;
    FOnPageRequest: TppPageRequestEvent;
    FPageCache: TStringlist;
    FPageRequest: TppPageRequest;
    FPageRequestsGranted: Boolean;
    FReadingCache: Boolean;
    FReportCompleted: Boolean;
    FRequestingPages: Boolean;
    FGeneratingPages: Boolean;
    FLock: TCriticalSection;

    procedure AddDevice(aDevice: TppDevice);
    procedure AddPageToCache(aPage: TppPage);
    procedure AddStackableDevice(aDevice: TppDevice);
    procedure CheckPagesRequested(aPage: TppPage);
    procedure ClearPageCache;
    procedure ClearPageRequests;
    procedure DoOnPageRequest;
    procedure FreeStacks;
    function  GetDevice(aIndex: Integer): TppDevice;
    function  GetDeviceCount: Integer;
    function  GetPage(aIndex: Integer): TppPage;
    function  GetPageCount: Integer;
    function  GetPagesFromCache: Boolean;
    function  IsValidDevice(aDevice: TppDevice): Boolean;
    procedure RemoveDevice(aDevice: TppDevice);
    procedure RemoveStackableDevice(aDevice: TppDevice);
    procedure RequestPage(aPageRequest: TppPageRequest);
    procedure ResolvePageRequest(aPageRequest: TppPageRequest);
    procedure SetCachePages(Value: Boolean);
    procedure TakeDeviceAction(aAction: TppDeviceActionType; aPage: TppPage; const aMessage: String);
    procedure UpdateCachedPages(aPage: TppPage);

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    procedure CancelJob;
    procedure Clear;
    function  GetPageFromCache(aPageNo: Longint): TppPage;
    function  GetPrintMessage: String;
    procedure EndJob;
    function  OnlyScreenDevicesConnected: Boolean;
    procedure Publish;
    procedure ReceivePage(aPage: TppPage);
    procedure Reset;
    procedure ResetDevices;
    procedure SetPrintMessage(const aMessage: String);
    procedure StartJob;
    function PagesEqual(aPublisher: TppPublisher): Boolean;

    property CachePages: Boolean read FCachePages write SetCachePages default False;
    property Devices[Index: Integer]: TppDevice read GetDevice;
    property DeviceCount: Integer read GetDeviceCount;
    property OnPageRequest: TppPageRequestEvent read FOnPageRequest write FOnPageRequest;
    property Pages[Index: Integer]: TppPage read GetPage;
    property PageCount: Integer read GetPageCount;
    property PageRequestsGranted: Boolean read FPageRequestsGranted;
    property ReportCompleted: Boolean read FReportCompleted;

  end; {class, TppPublisher}

  {@TppDevice

    Ancestor from which all devices descend. The standard devices provided
    with ReportBuilder are:

            - TppArchiveDevice
            - TppPrinterDevice
            - TppScreenDevice
            - TppPDFDevice
            - TppRTFDevice, TppDocDevice,
            - TppXLSDataDevice, TppXLSReportDevice
            - TppImageDevice and it's descendants
            - TppTextFileDevice
            - TppReportTextFileDevice

    The main job of a device component is to receive TppPage objects generated by
    the report engine and convert them to a format appropriate for the device. The
    ScreenDevice converts each page to a bitmap and scales it for display in the
    Viewer component. The PrinterDevice converts each page to printer pixel
    resolution and then draws it on the printer canvas. The TextFileDevice saves the
    text-based portions of the page to a file. Regardless of the eventual data
    format, each device component is completing the same basic task.

    Device components receive pages from the Publisher component. The main report
    contains a Publisher, which can be accessed via the Publisher property. When the
    Print method of a report is called, the Publisher calls the SendPageRequest
    method of every connected device. The Publisher consolidates the requests of all
    of the devices and then calls the StartJob method of each device. The Publisher
    then makes a single page generation request to the Report. The Report calls the
    engine which begins generating pages. As the pages are generated, the Publisher
    calls the ReceivePage method of every device, passing the generated page. The
    device then decides whether to ignore or render the page so received. Once the
    report is complete, the Publisher calls the EndJob method of each device.  If
    the user cancels the report while it is generating, the generation process stops
    and the CancelJob method of each device is called.

    Each time a device receives a page, the value of IsRequestedPage indicates
    whether that page was actually requested by the device. If IsMessagePage is
    true, then the page contains no draw commands and is simply providing an
    indication of generation progress.  The ScreenDevice uses IsMessagePage pages to
    display report generation progress in the Print Preview form status bar.

    When IsRequestedPage is True, and IsMessagePage is False, then the device should
    convert the page to a format appropriate for the device. This is usually
    accomplished by writing a method or methods which loop through the draw commands
    and convert each one.

    Note: ReportBuilder will create devices automatically when the Print method is
    called. In order to take manual control of devices, create the device and assign
    the Publisher property to the report's publisher. Then call the PrintToDevices
    method of the report. Calling the PrintToDevices method causes any pages
    generated by the report to be sent to the currently connected devices.}

  {@TppDevice.Busy

    Whether or not the device is currently receiving pages from the report.}

  {@TppDevice.DeviceName

    The DeviceName will automatically appear in the list of Devices displayed
    when assigning the Report.DeviceType or ArchiveReader.DeviceType
    properties.}

  {@TppDevice.IsMessagePage

    Whether or not the most recently received page is a for message purposes
    only.}

  {@TppDevice.IsRequestedPage

    Whether or not the most recently received page was requested by the device.}

  {@TppDevice.PageList

    The list of page nos. which will be requested when the Publisher polls the
    device.}

  {@TppDevice.PageRequested

    The absolute page no. of the page which will be requested when the Publisher
    polls the device.}

  {@TppDevice.PageSetting

    The type of page request which will be made when the Publisher polls the
    device.}

  {@TppDevice.Publisher

    The Publisher to which the device is assigned.}

  {@TppDevice.Stackable

    Whether or not the device is a stackable. Stackable devices replace any
    currently active device in the stack when assigned to the Publisher. Stacks
    are created by the Publisher based on the value of the StackName property
    when the stackable device is first assigned. Stackable printer devices are
    used to implement section type subreports.}

  {@TppDevice.StackName

    The name of the stack on which the device should be placed. Stackable
    devices replace any currently active device in the stack when assigned to
    the Publisher. Stacks are created by the Publisher based on the value of
    this property when the stackable device is first assigned to the Publisher.
    Stackable printer devices are used to implement section type subreports.}

  TppDevice = class(TppCommunicator)
    private
      FActive: Boolean;
      FBusy: Boolean;
      FCancelled: Boolean;
      FCancelDialog: TppCustomCancelDialog;
      FIsMessagePage: Boolean;
      FIsRequestedPage: Boolean;
      FLanguageIndex: Longint;
      FOnCancelJob: TNotifyEvent;
      FOnPageRequest: TNotifyEvent;
      FOnPageReceive: TppPageEvent;
      FOnStartJob: TNotifyEvent;
      FOnEndJob: TNotifyEvent;
      FOnSetPublisher: TNotifyEvent;
      FPageRequest: TppPageRequest;
      FPublisher: TppPublisher;
      FStackable: Boolean;
      FStackName: String;
      FStatus: String;
      FWaitingForPage: Boolean;

      procedure CheckPagesRequested(aPage: TppPage);
      procedure DoOnSetPublisher;
      function  GetPageList: TStrings;
      function  GetPageRequested: Integer;
      function  GetPageSetting: TppPageSettingType;
      procedure SetActive(aValue: Boolean);
      procedure SetPageList(aPageList: TStrings);
      procedure SetPageRequested(Value: Integer);
      procedure SetPageRequest(aPageRequest: TppPageRequest);
      procedure SetPageSetting(aPageSetting: TppPageSettingType);
      procedure SetPublisher(aPublisher: TppPublisher);

    protected
      procedure AfterProcessDrawCommand; virtual;
      procedure BeforeProcessDrawCommand(aDrawCommand: TppDrawCommand); virtual;
      procedure DrawPage(aPage: TppPage);                                                                   

      procedure SetStackable(Value: Boolean); virtual;
      procedure SetStackName(aName: String); virtual;
      procedure SetStatus(const aValue: String); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function DeviceName: String; virtual;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure CancelJob; virtual;
      procedure DoOnPageRequest;
      function  Draw(aDrawCommand: TppDrawCommand): Boolean; virtual;
      function  DrawUpdateable(aDrawCommand: TppDrawCommand): Boolean; virtual;
      procedure EndJob; virtual;
      function  FinalPagesOnly: Boolean; virtual;
      procedure MakePageRequest;
      procedure ReceivePage(aPage: TppPage); virtual;
      procedure Reset; virtual;
      procedure StartJob; virtual;

      property Active: Boolean read FActive write SetActive;
      property Busy: Boolean read FBusy;
      property Cancelled: Boolean read FCancelled;
      property CancelDialog: TppCustomCancelDialog read FCancelDialog write FCancelDialog;
      property IsMessagePage: Boolean read FIsMessagePage write FIsMessagePage;
      property IsRequestedPage: Boolean read FIsRequestedPage write FIsRequestedPage;
      property LanguageIndex: Longint read FLanguageIndex write FLanguageIndex;
      property OnSetPublisher: TNotifyEvent read FOnSetPublisher write FOnSetPublisher;
      property PageList: TStrings read GetPageList write SetPageList;
      property PageRequested: Integer read GetPageRequested write SetPageRequested;
      property PageSetting: TppPageSettingType read GetPageSetting write SetPageSetting;
      property PageRequest: TppPageRequest read FPageRequest write SetPageRequest;
      property Publisher: TppPublisher read FPublisher write SetPublisher;
      property Stackable: Boolean read FStackable write SetStackable;
      property StackName: String read FStackName write SetStackName;
      property Status: String read FStatus write SetStatus;
      property WaitingForPage: Boolean read FWaitingForPage write FWaitingForPage;

      {these events allow run-time communication with device}
      property OnCancelJob: TNotifyEvent read FOnCancelJob write FOnCancelJob;
      property OnEndJob: TNotifyEvent read FOnEndJob write FOnEndJob;
      property OnPageReceive: TppPageEvent read FOnPageReceive write FOnPageReceive;
      property OnPageRequest: TNotifyEvent read FOnPageRequest write FOnPageRequest;
      property OnStartJob: TNotifyEvent read FOnStartJob write FOnStartJob;

  end; {class TppDevice}

  {@TppRasterDevice
  
  Encapsulates functionality common to raster devices.}

  TppRasterDevice = class(TppDevice)
  end;


{******************************************************************************
 *
 ** P A G E   &   P A G E   C O M M A N D S
 *
{******************************************************************************}

  {@TppPage

    The Page object contains the visual representation for a single page of a
    report. This representation is composed of draw commands that are contained
    within the page.

    Page objects, and the draw commands they contain, are the native report
    output of ReportBuilder. As such they contain a rich set of information
    regarding exactly how the page should be rendered.  It is the job of the
    ReportBuilder device to receive page objects and convert them to a format
    appropriate for the device.  The device always receives pages from the
    Publisher, an object inside the report which acts as a liason between the
    report engine and the currently connected devices.

    When a device receives a page object from the Publisher, and the device has
    requested the page, the device loops through the draw commands in the page,
    and converts each one to a format appropriate for the device. This
    conversion is accomplished by a draw method located either in the device or
    in the draw command itself.  The standard devices that are provided with
    ReportBuilder (TppScreenDevice, TppPrinterDevice, TppTextFileDevice) contain
    draw methods that handle this conversion process.  The screen and printer
    devices have draw methods for each type of draw command (i.e. drawtext,
    drawshape, drawimage, drawline, etc.)  The text file device contains only
    one draw method, which writes drawtext commands to a file.

    If you are coding a new device, it is up to you to code draw methods that
    can handle any of the drawcommand types. These draw methods will be the most
    important part of your device,as they will determine how successfully the
    device converts native report output to the data format or formats you
    intend to support.  In order to see an example of a device, check the
    ppViewr unit for the screen device, the ppPrnDev unit for the printer
    device, or the ppFilDev unit for text file device.}

  {@TppPage.AbsolutePageCount

    The total number of pages in the report at the time the page was generated.
    If the engine is generating a one-pass report, then this property will be
    updated by the screen device as additional pages of the report are
    generated.

    The AbsolutePageCount always contains the total number of pages for the
    report as a whole.  This differs from the PageCount property, which contains
    a relative page count based on the last group break.  If no groups have been
    created, or no groups have the ResetPageNo property set to True, then the
    PageCount property will contain the same value as AbsolutePageCount.}

  {@TppPage.AbsolutePageNo

    The current page which is being printed or previewed.

    The AbsolutePageNo always contains the current page number for the report as
    a whole. This differs from the PageNo property, which contains a relative
    page number based on the last group break.  If no groups have been created,
    or no groups have the ResetPageNo property set to True, then the PageNo
    property will contain the same value as AbsolutePageNo.}

  {@TppPage.Calculation

    This property is set by the report engine before the page is sent to the
    devices. When True, this property indicates that the page does not contain
    any DrawCommands and is simply being sent as an indication of generation
    progress.  When False, this property indicates that the page contains
    DrawCommands and can be rendered if the receiving device so desires.}

  {@TppPage.ControlGroupBreakNo

    This property is set by the report engine before the page is sent to the
    devices. When a report has groups, the first group that has both the
    StartNewPage and ResetPageNo properties set to True is considered the
    control group.  It is this group that will control subset page numbering and
    will cause the PageNo and PageCount properties of the report to reflect the
    pages within the group as opposed to the pages within the report as a whole.
    Each time the control group breaks, the BreakNo property of the group is
    incremented. Each BreakNo represents a set of pages for the particular
    occurance of a group.  The report engine assigns the BreakNo of the control
    group to the Page so that the screen device can properly update the
    PageCount property when additional pages of the group are generated.}

  {@TppPage.Description

    Run-time and read-only. This property describes the page number of the page
    in the format 'Page \<pageno\> of \<pagecount\>.'}

  {@TppPage.DocumentName

    This property is the name of the document as specified in the 
    PrinterSetup.DocumentName property of the master report.}

  {@TppPage.DrawCommandCount

    Run-time and read-only. Use this property to determine the number of draw
    commands in the page.}

  {@TppPage.DrawCommands

    Run-time and read-only. Use this property to access the draw commands of a
    page.}

  {@TppPage.Final

    Run-time and read-only. Use this property to determine whether the page
    contains draw commands.}

  {@TppPage.FirstPage

    Run-time and read-only. Use this property to determine whether this is the
    first page of the report.}

  {@TppPage.LanguageIndex

    Run-time and read-only. Indicates the language setting when the page was
    generated.}

  {@TppPage.LastPage

    Run-time and read-only. Use this property to determine whether this is the
    last page of the report.}

  {@TppPage.PageCount

    When a group has the ResetPageNo property set to True, the PageCount
    property contains the number of pages relative to the last break.  This is
    useful when you want to number reports in subsets, such as printing invoices
    for ten different customers.  If you created a group based on the customer
    name and set the ResetPageNo property to True, the PageCount property would
    contain the total number of pages for each customer.

    If no groups exist, or no groups have ResetPageNo set to True, the PageCount
    property contains the total number of pages for the report (this is the same
    value as the AbsolutePageCount property).

    You can easily add subset page numbering to any of your reports by creating
    a TppCalc component with a CalcType of ctPageSetDesc.  This provides page
    numbering in the style: '1 of 4 thru 4 of 4', then '1 of 2 thru 2 of 2',
    etc.}

  {@TppPage.PageDef

    Run-time and read-only. It is the pass-through property to the PageDef
    object of the page's PrinterSetup object.}

  {@TppPage.PageNo

    The current page being printed or previewed.

    When a group has the ResetPageNo property set to True, the PageNo property
    contains the page number relative to the last group break.  This is useful
    when you want to number reports in subsets, such as printing invoices for
    ten different customers.  If you created a group based on customer name and
    set the ResetPageNo property to True, the PageNo property would contain the
    page number for each invoice, starting at 1.

    If no groups exist, or no groups have ResetPageNo set to True, the PageNo
    property contains the page number relative to the report as a whole (this is
    the same value as the AbsolutePageNo property).

    You can easily add subset page numbering to any of your reports by creating
    a TppCalc component with a CalcType of ctPageSetDesc.  This provides page
    numbering in the style: '1 of 4 through 4 of 4', then '1 of 2 through 2 of
    2', etc.}

  {@TppPage.PassSetting

    Run-time and read-only. The PassSetting of the report at the time the page
    was generated.}

  {@TppPage.PrintDateTime

    This property is set by the report engine before the page is sent to the
    devices and contains the date and time as of the start of report
    generation.}

  {@TppPage.PrinterSetup

    Run-time and read-only. Full description of printer settings to be used when
    generating this page.}

  TppPage = class(TppRelative)
    private
      FAbsolutePageNo: Longint;
      FAbsolutePageCount: Longint;
      FCalculation: Boolean;
      FClickables: TList;
      FColor: Integer;
      FControlGroupBreakNo: Longint;
      FCopyNo: Integer;
      FDocumentName: String;
      FEmailSettings: TppEmailSettings;
      FFileSuffix: string;
      FFirstFileSuffix: String;
      FFinal: Boolean;
      FFirstPage: Boolean;
      FLanguageIndex: Longint;
      FLastPage: Boolean;
      FNewJob: Boolean;
      FPageNo: Longint;
      FPageCount: Longint;
      FPassSetting: TppPassSettingType;
      FPrintDateTime: TDateTime;
      FPrinterSetup: TppPrinterSetup;
      FUpdateables: TList;
      FProducer: TComponent;

      procedure AddClickable(aDrawCommand: TppDrawCommand);
      procedure AddUpdateable(aDrawCommand: TppDrawCommand);
      function  GetClickable(aIndex: Integer): TppDrawCommand;
      function  GetClickableCount: Integer;
      function  GetDrawCommandForIndex(aIndex: Integer): TppDrawCommand;
      function  GetDrawCommandCount: Integer;
      function  GetPageDef: TppPageDef;
      function  GetPageNoDescription: String;
      function  GetPageSetDescription: String;
      procedure RemoveClickable(aDrawCommand: TppDrawCommand);
      procedure RemoveUpdateable(aDrawCommand: TppDrawCommand);
      procedure SetPrinterSetup(aPrinterSetup: TppPrinterSetup);
      procedure SetEmailSettings(aEmailSettings: TppEmailSettings);
      function  StoreEmailSettings: Boolean;

    public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;

      procedure Assign(Source: TPersistent); override;

      procedure AddDrawCommand(aDrawCommand: TppDrawCommand);
      procedure Clear;
      function  EqualTo(aPage: TppPage): Boolean; overload;
      function  EqualTo(aPage: TppPage; var aMessage: String): Boolean; overload;
      procedure FreeDrawCommands;
      function  GetDrawCommandForClass(aDrawCommandClass: TppDrawCommandClass): TppDrawCommand;
      function GetDrawCommandForExpansionKey(aExpansionKey: String): TppDrawCommand;
      function  GetOutlineDrawCommand: TppDrawCommand;
      function  HasClickables: Boolean;
      function  HasUpdateables: Boolean;
      function  IndexOfDrawCommand(aDrawCommand: TppDrawCommand): Integer;
      procedure Loaded; override;
      procedure RemoveDrawCommand(aDrawCommand: TppDrawCommand);
      procedure Update(aDevice: TppDevice);
      function  GetScaledWidth(aScalePercentage: Integer; aUnits: TppUnitType): Integer;
      function  GetScaledHeight(aScalePercentage: Integer; aUnits: TppUnitType): Integer;

      property Description: String read GetPageSetDescription;
      property DrawCommands[Index: Integer]: TppDrawCommand read GetDrawCommandForIndex; default;
      property DrawCommandCount: Integer read GetDrawCommandCount;
      property Clickables[Index: Integer]: TppDrawCommand read GetClickable;
      property ClickableCount: Integer read GetClickableCount;
      property CopyNo: Integer read FCopyNo write FCopyNo;
      property NewJob: Boolean read FNewJob write FNewJob;
      property PageNoDescription: String read GetPageNoDescription;
      property PageSetDescription: String read GetPageSetDescription;
      property Producer: TComponent read FProducer write FProducer;

    published
      property AbsolutePageNo: Longint read FAbsolutePageNo write FAbsolutePageNo;
      property AbsolutePageCount: Longint read FAbsolutePageCount write FAbsolutePageCount;
      property Calculation: Boolean read FCalculation write FCalculation;
      property Color: Integer read FColor write FColor default 167772155;
      property ControlGroupBreakNo: Longint read FControlGroupBreakNo write FControlGroupBreakNo;
      property DocumentName: String read FDocumentName write FDocumentName;
      property EmailSettings: TppEmailSettings read FEmailSettings write SetEmailSettings stored StoreEmailSettings;
      property FirstPage: Boolean read FFirstPage write FFirstPage;
      property FileSuffix: string read FFileSuffix write FFileSuffix;
      property FirstFileSuffix: String read FFirstFileSuffix write FFirstFileSuffix;
      property Final: Boolean read FFinal write FFinal;
      property LanguageIndex: Longint read FLanguageIndex write FLanguageIndex;
      property LastPage: Boolean read FLastPage write FLastPage;
      property PageDef: TppPageDef read GetPageDef;
      property PageNo: Longint read FPageNo write FPageNo;
      property PageCount: Longint read FPageCount write FPageCount;
      property PassSetting: TppPassSettingType read FPassSetting write FPassSetting;
      property PrintDateTime: TDateTime read FPrintDateTime write FPrintDateTime;
      property PrinterSetup: TppPrinterSetup read FPrinterSetup write SetPrinterSetup;

  end; {class TppPage}
                                                                          
  {@TppDrawCommand
  
    Ancestor from which all draw command classes descend. The standard draw
    commands provided with ReportBuilder are:

            - TppDrawCalc
            - TppDrawImage
            - TppDrawLine
            - TppDrawRichText
            - TppDrawShape
            - TppDrawText

    A draw command contains the minimum amount of information necessary to
    render the visual representation of a report component to any device.  As
    the report engine generates pages, the Print method of each report component
    is called.  In this method, the report component creates a draw command and
    assigns it to the report engine page object. The report engine generates
    draw commands until all page space has been used or the data has been
    exhausted.  The resulting page object is then sent to all devices which
    convert them to a format appropriate for that device.

    Draw commands make up the native report output of ReportBuilder. They are
    useful because they exist at a higher level of abstraction than say, a
    windows metafile. Draw commands indicate what text, shapes, lines etc.
    should be drawn, but leave the interpretation of how these should be drawn
    to the device.}

  {@TppDrawCommand.ClipRect

    The rectangle which represents the valid area in which the component should
    be rendered, given the height and and width of the parent region or band.}

  {@TppDrawCommand.DataType

   If the draw command was created by a data aware component, then the data type
   reflects the supplying field's data type.}

  {@TppDrawCommand.DrawBottom

    This property is used by the device to store the bottom position of the
    command in the unit of measure preferred by the device.}

  {@TppDrawCommand.DrawLeft

    This property is used by the device to store the left position of the
    command in the unit of measure preferred by the device.}

  {@TppDrawCommand.DrawRight

    This property is used by the device to store the right position of the
    command in the unit of measure preferred by the device.}

  {@TppDrawCommand.DrawTop

    This property is used by the device to store the top position of the command
    in the unit of measure preferred by the device.}

  {@TppDrawCommand.Height

    The height of the component as generated by the report engine (always in
    thousandths of millimeters.)}

  {@TppDrawCommand.Left

    The left position of the component as generated by the report engine (always
    in thousandths of millimeters.)}

  {@TppDrawCommand.Page

    The page in which the drawcommand is contained.

    The page is like a parent to a windowed component. Draw commands are added
    to a page by setting this property.}

  {@TppDrawCommand.Top

    The top position of the component as generated by the report engine (always
    in thousandths of millimeters.)}

  {@TppDrawCommand.Width

    The width of the component as generated by the report engine (always in
    thousandths of millimeters.)}

  TppDrawCommand = class(TppRelative)
    private
      FBand: TComponent;
      FBorder: TppBorder;
      FClickable: Boolean;
      FClipRect: TppRect;
      FDataType: TppDataType;
      FDisplayFormat: string;
      FDrawLeft: Longint;
      FDrawRight: Longint;
      FDrawTop: Longint;
      FDrawBottom: Longint;
      FExpansionKey: String;
      FLeft: Longint;
      FHeight: Longint;
      FOnClick: TNotifyEvent;
      FPage: TppPage;
      FRedrawPage: Boolean;
      FTop: Longint;
      FValue: Variant;
      FWidth: Longint;

      function GetDrawHeight: LongInt;
      function GetDrawRect: TRect;
      function GetDrawWidth: LongInt;
      procedure SetPage(aPage: TppPage);
      procedure SetBorder(aBorder: TppBorder);
      function StoreBorder: Boolean;

    protected
      procedure SetParent(aParent: TppRelative); override;
      function GetValue: Variant; virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      procedure DoOnClick;

      function Draw(aDevice: TppDevice): Boolean; virtual;
      function EqualTo(aDrawCommand: TppDrawCommand): Boolean; virtual;
      function IsUpdateable: Boolean; virtual;
      function Update: Boolean; virtual;

      property Band: TComponent read FBand write FBand;
      property ClipRect: TppRect read FClipRect write FClipRect;
      property DrawLeft: Longint read FDrawLeft write FDrawLeft;
      property DrawRight: Longint read FDrawRight write FDrawRight;
      property DrawTop: Longint read FDrawTop write FDrawTop;
      property DrawBottom: Longint read FDrawBottom write FDrawBottom;
      property DrawRect: TRect read GetDrawRect;
      property OnClick: TNotifyEvent read FOnClick write FOnClick;
      property DrawHeight: LongInt read GetDrawHeight;
      property DrawWidth: LongInt read GetDrawWidth;
      property Page: TppPage read FPage write SetPage;
      property RedrawPage: Boolean read FRedrawPage write FRedrawPage;

    published
      property Border: TppBorder read FBorder write SetBorder stored StoreBorder;
      property Clickable: Boolean read FClickable write FClickable default False;
      property DataType: TppDataType read FDataType write FDataType default dtString;
      property DisplayFormat: string read FDisplayFormat write FDisplayFormat;
      property ExpansionKey: String read FExpansionKey write FExpansionKey;
      property Left: Longint read FLeft write FLeft;
      property Height: Longint read FHeight write FHeight;
      property Top: Longint read FTop write FTop;
      property Value: Variant read GetValue write FValue;
      property Width: Longint read FWidth write FWidth;


  end; {class, TppDrawCommand}

  {TppDrawCommandCollection}
  TppDrawCommandCollection = class(TppCollectionBase)
  private
    function GetItems(Index: Integer): TppDrawCommand;
  public
    function Add(aDrawCommand: TppDrawCommand): Integer;
    function Remove(aDrawCommand: TppDrawCommand): Integer;
    property Items[Index: Integer]: TppDrawCommand read GetItems; default;
  end;


  {@TppPageRequest }
  TppPageRequest = class(TPersistent)
    private
      FDrawCommandClickIndex: Integer;
      FExpansionKey: string;
      FPageList: TStrings;
      FPageRequested: Longint;
      FPageSetting: TppPageSettingType;
      FPageRange: TppPageRangeType;

      procedure SetPageList(aPageList: TStrings);

    public
      constructor Create;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      procedure AddPageRequest(aPageRequest: TppPageRequest);
      function  AllPagesReceived(aPage: TppPage): Boolean;
      function  IsRequestedPage(aPage: TppPage): Boolean;
      procedure Reset;

    published
      property DrawCommandClickIndex: Integer read FDrawCommandClickIndex write FDrawCommandClickIndex;
      property ExpansionKey: string read FExpansionKey write FExpansionKey;
      property PageList: TStrings read FPageList write SetPageList;
      property PageRequested: Integer read FPageRequested write FPageRequested;
      property PageSetting: TppPageSettingType read FPageSetting write FPageSetting;
      property PageRange: TppPageRangeType read FPageRange write FPageRange;

  end; {class, TppPageRequest}

  TppDeviceClass = class of TppDevice;


  {TppDeviceSubstitutions}

  TppDeviceSubstitutions = class
    public
      class function SubstituteFont(aFontName: String): String;
    end;


{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppDrawCommandRTTI }
  TraTppDrawCommandRTTI = class(TraTppRelativeRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDrawCommandRTTI}

  {@TraTppPageRTTI }
  TraTppPageRTTI = class(TraTComponentRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
  end; {class, TraTppPageRTTI}




  {register procedures}
  function  ppDeviceClassForName(const aDeviceName: String): TppDeviceClass;
  procedure ppGetDeviceClasses(aList: TStrings);
  procedure ppRegisterDevice(aDeviceClass: TppDeviceClass);
  procedure ppUnRegisterDevice(aDeviceClass: TppDeviceClass);

implementation

uses
  ppDrwCmd,
  ppProd, ppOutlineDrawCommand;

var
  FDeviceClassList: TList = nil;

{******************************************************************************
 *
 ** P U B L I S H E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPublisher.Create }

constructor TppPublisher.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAbsolutePageCount := 0;
  FCachePages := False;
  FFirstPageRequest := False;
  FOnPageRequest := nil;
  FPageRequest := TppPageRequest.Create;
  FPageRequestsGranted := False;
  FReadingCache := False;
  FReportCompleted := False;
  FRequestingPages := False;
  FGeneratingPages := False;

  FLock := TCriticalSection.Create;

  FDevices := TList.Create;
  FPageCache := TStringlist.Create;
  FStacks := TStringList.Create;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPublisher.Destroy }

destructor TppPublisher.Destroy;
begin

  ClearPageCache;
  FreeStacks;

  FDevices.Free;
  FPageCache.Free;
  FPageRequest.Free;
  FStacks.Free;

  FLock.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppPublisher.FreeStacks }

procedure TppPublisher.FreeStacks;
var
  liStack: Integer;
begin

  for liStack :=  0 to FStacks.Count-1 do
   FStacks.Objects[liStack].Free;

end; {procedure, FreeStacks}

{------------------------------------------------------------------------------}
{ TppPublisher.Notify }

procedure TppPublisher.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin
  inherited Notify(aCommunicator, aOperation);

  if (aCommunicator is TppDevice) and (aOperation = ppopRemove) then
    RemoveDevice(TppDevice(aCommunicator));

end; {procedure, Notify}


{------------------------------------------------------------------------------}
{ TppPublisher.TakeDeviceAction }

procedure TppPublisher.TakeDeviceAction(aAction: TppDeviceActionType; aPage: TppPage; const aMessage: String);
var
  liDevice: Integer;
  liDevices: Integer;
  lDevice: TppDevice;
begin

  FLock.Acquire;

  try

    liDevices := FDevices.Count;

    for liDevice := 0 to (liDevices - 1) do
      begin
        lDevice := Devices[liDevice];

        if not(lDevice.Active) then Continue;

        case aAction of

          ppdvGetPageRequest:
            if lDevice.WaitingForPage then
              begin
                lDevice.DoOnPageRequest;

                RequestPage(lDevice.PageRequest);
              end;

          ppdvReceivePage:
            if lDevice.WaitingForPage then
              lDevice.ReceivePage(aPage);

          ppdvStartJob:
            lDevice.StartJob;

          ppdvEndJob:
            lDevice.EndJob;

          ppdvCancelJob:
            if lDevice.WaitingForPage then
              lDevice.CancelJob;

          ppdvReset:
            lDevice.Reset;


        end; {case, action type}

      end;

  finally
    FLock.Release;
  end;

end; {procedure, TakeDeviceAction}

{------------------------------------------------------------------------------}
{ TppPublisher.ResetDevices }

procedure TppPublisher.ResetDevices;
begin
  TakeDeviceAction(ppdvReset, nil, '');
end; {procedure, ResetDevices}

{------------------------------------------------------------------------------}
{ TppPublisher.Clear }

procedure TppPublisher.Clear;
begin
  {called from the report to clear everything but the page requests}
  FReportCompleted := False;

  FAbsolutePageCount := 0;

  FPageRequestsGranted := False;

  ClearPageCache;
end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppPublisher.OnlyScreenDevicesConnected }

function TppPublisher.OnlyScreenDevicesConnected: Boolean;
var
  liIndex: Integer;
  lDevice: TppDevice;
begin

  Result := True;

  liIndex := 0;

  while (liIndex < FDevices.Count) and (Result) do
    begin
      lDevice := Devices[liIndex];

      if (CompareText(lDevice.ClassName, 'TppScreenDevice') <> 0) then
        Result := False
      else
        Inc(liIndex);
    end;

end; {function, OnlyScreenDevicesConnected}

{------------------------------------------------------------------------------}
{ TppPublisher.Reset }

procedure TppPublisher.Reset;
begin
  FReportCompleted := False;
  
  FAbsolutePageCount := 0;

  FPageRequestsGranted := False;

  ClearPageRequests;

  ClearPageCache;

  SendEventNotify(Self, ciPublisherReset, nil);
end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppPublisher.Publish }

procedure TppPublisher.Publish;
begin

  {gather page requests from devices}
  try
    FRequestingPages := True;
    FFirstPageRequest := True;

    TakeDeviceAction(ppdvGetPageRequest, nil, '');
  finally
    FRequestingPages := False;
  end; {try, finally}


  {generate pages from report, or read pages from cache}
   FGeneratingPages := True;

   DoOnPageRequest;

end; {procedure, Publish}

{------------------------------------------------------------------------------}
{ TppPublisher.PagesEqual }

function TppPublisher.PagesEqual(aPublisher: TppPublisher): Boolean;
var
  liIndex: Integer;
begin

  if not(FCachePages) or not(aPublisher.FCachePages) then
    raise EPrintError.Create('TppPublisher.PagesEqual: Cache pages must be set to true.');

  Result := False;

  if (GetPageCount = aPublisher.GetPageCount) then
    begin

      liIndex := 0;

      Result := True;

      while Result and (liIndex < GetPageCount) do
        begin

          Result := Pages[liIndex].EqualTo(aPublisher.Pages[liIndex]);

          Inc(liIndex);

        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppPublisher.StartJob}

procedure TppPublisher.StartJob;
begin
  TakeDeviceAction(ppdvStartJob, nil, '');

end; {procedure, StartJob}

{------------------------------------------------------------------------------}
{ TppPublisher.CancelJob}

procedure TppPublisher.CancelJob;
begin
  TakeDeviceAction(ppdvCancelJob, nil, '');
end; {procedure, CancelJob}

{------------------------------------------------------------------------------}
{ TppPublisher.EndJob }

procedure TppPublisher.EndJob;
begin

  FGeneratingPages := False;

  TakeDeviceAction(ppdvEndJob, nil, '');

  ClearPageRequests;

end;  {procedure, EndJob}

{------------------------------------------------------------------------------}
{ TppPublisher.GetPrintMessage }

function TppPublisher.GetPrintMessage: String;
var
  liIndex: Integer;
begin

  Result := '';
  liIndex := 0;

  while (Result = '') and (liIndex < FDevices.Count) do
    begin
      Result := Devices[liIndex].Status;

      Inc(liIndex);
    end;

end;  {procedure, GetPrintMessage}

{------------------------------------------------------------------------------}
{ TppPublisher.SetPrintMessage }

procedure TppPublisher.SetPrintMessage(const aMessage: String);
var
  liIndex: Integer;
begin

  for liIndex := 0 to (FDevices.Count - 1) do
    Devices[liIndex].Status := aMessage;

end;  {procedure, SetPrintMessage}

{------------------------------------------------------------------------------}
{ TppPublisher.ReceivePage }

procedure TppPublisher.ReceivePage(aPage: TppPage);
var
  lParams: TraParamList;
begin

  {add page to cache}
  AddPageToCache(aPage);

  {send page to all devices}
  TakeDeviceAction(ppdvReceivePage, aPage, '');

  {check to see if all page requests have been granted}
  CheckPagesRequested(aPage);

  {if not(FReportCompleted) and aPage.LastPage and aPage.Final and not(aPage.Calculation) then}
  if not(FReportCompleted) and aPage.LastPage then
    begin
      FReportCompleted := True;

      FAbsolutePageCount := aPage.AbsolutePageNo;
    end;

  lParams := TraParamList.Create;
  lParams.AddParam('Page', daObject, TppPage, '', True, False);
  lParams.SetValuePointer(0, aPage);

  SendEventNotify(Self, ciPublisherReceivePage, lParams);

  lParams.Free;

end; {procedure, ReceivePage}

{------------------------------------------------------------------------------}
{ TppPublisher.RequestPage }

procedure TppPublisher.RequestPage(aPageRequest: TppPageRequest);
begin

  if not(FFirstPageRequest) and not(FRequestingPages) and not(FGeneratingPages) then
    FFirstPageRequest := True;

  {indicate that all page requests have not been granted}
  FPageRequestsGranted := False;

  ResolvePageRequest(aPageRequest);

end; {procedure, RequestPage}

{------------------------------------------------------------------------------}
{ TppPublisher.ResolvePageRequest }

procedure TppPublisher.ResolvePageRequest(aPageRequest: TppPageRequest);
begin


  if not(ppValidDate) and (aPageRequest.PageRequested > 5) then
    aPageRequest.PageRequested := 5;


  if (FFirstPageRequest) then
    begin
      FFirstPageRequest := False;

      FPageRequest.Assign(aPageRequest);
    end

  else if (FPageRequest.PageSetting <> psAll) then
    FPageRequest.AddPageRequest(aPageRequest);

end; {procedure, ResolvePageRequest}

{------------------------------------------------------------------------------}
{ TppPublisher.DoOnPageRequest }

procedure TppPublisher.DoOnPageRequest;
begin

  if FRequestingPages or FPageRequestsGranted then Exit;

  {if we have a page cache, return any pages found to device}
  FPageRequestsGranted := GetPagesFromCache;


  if FPageRequestsGranted then Exit;

  {generate more pages}
  if Assigned(FOnPageRequest) then FOnPageRequest(Self, FPageRequest);

  SendEventNotify(Self, ciPublisherAfterPageRequest, nil);

end; {procedure, DoOnPageRequest}

{------------------------------------------------------------------------------}
{ TppPublisher.CheckPagesRequested }

procedure TppPublisher.CheckPagesRequested(aPage: TppPage);
begin
  FPageRequestsGranted := FPageRequest.AllPagesReceived(aPage);
end; {procedure, CheckPagesRequested}

{------------------------------------------------------------------------------}
{ TppPublisher.ClearPageRequests }

procedure TppPublisher.ClearPageRequests;
begin

  FFirstPageRequest := True;

  FPageRequest.Reset;

end; {procedure, ClearPageRequests}

{------------------------------------------------------------------------------}
{ TppPublisher.SetCachePages }

procedure TppPublisher.SetCachePages(Value: Boolean);
begin

  FCachePages := Value;

end; {procedure, SetCachePages}

{------------------------------------------------------------------------------}
{ TppPublisher.ClearPageCache}

procedure TppPublisher.ClearPageCache;
var
  liPage: Integer;
  liPages: Integer;
  lPage: TppPage;
begin

  liPages := FPageCache.Count;

  for liPage := 0 to (liPages - 1) do
    begin
      lPage := Pages[liPage];

      lPage.Free;
    end;

  FPageCache.Clear;

end; {procedure, ClearPageCache}

{------------------------------------------------------------------------------}
{ TppPublisher.AddPageToCache }

procedure TppPublisher.AddPageToCache(aPage: TppPage);
var
  lsPage: String;
  liIndex: Integer;
  lPage: TppPage;
begin
  if not(FCachePages) then Exit;

  if FReadingCache then Exit;

  if not(aPage.Final) then Exit;

  if aPage.Calculation then Exit;

  lsPage := Format('%8d',[aPage.AbsolutePageNo]);

  liIndex := FPageCache.IndexOf(lsPage);

  if liIndex <> -1 then
    begin
      lPage := Pages[liIndex];
      FPageCache.Delete(liIndex);
      lPage.Free;

    end;

  lPage := TppPage.Create(nil);

  lPage.Assign(aPage);

  {turn calculation switch off, this allows the page to be rendered as a real page when
   it is read from the cache.}
  lPage.Calculation := False;

  FPageCache.AddObject(lsPage, lPage);

  FPageCache.Sort;

  if (FPageCache.Count > 1) then
    UpdateCachedPages(aPage);

end; {procedure, AddPageToCache}

{------------------------------------------------------------------------------}
{ TppPublisher.UpdateCachedPages }

procedure TppPublisher.UpdateCachedPages(aPage: TppPage);
var
  liPage: Longint;
  liPages: Longint;
  lPage: TppPage;
begin

  liPages := FPageCache.Count;
  
  for liPage := 0 to liPages - 1 do
    begin

      lPage := TppPage(FPageCache.Objects[liPage]);

      {update current page}
      if (lPage.AbsolutePageCount < aPage.AbsolutePageCount) then
        begin
          lPage.AbsolutePageCount := aPage.AbsolutePageCount;

          if (lPage.ControlGroupBreakNo = aPage.ControlGroupBreakNo) and
             (lPage.PageCount < aPage.PageCount) then
            lPage.PageCount := aPage.PageCount;

          if lPage.HasUpdateables then
            lPage.Update(nil);

        end;

    end; {for, each page}

end; {procedure, UpdateCachedPages}

{------------------------------------------------------------------------------}
{ TppPublisher.GetPageFromCache }

function TppPublisher.GetPageFromCache(aPageNo: Longint): TppPage;
var
  liIndex: Integer;
  lsPage: String;
begin

  lsPage := Format('%8d',[aPageNo]);

  liIndex := FPageCache.IndexOf(lsPage);

  {return page object based on the position in the cache}
  if (liIndex <> -1) then
    Result := TppPage(FPageCache.Objects[liIndex])
  else
    Result := nil;

end; {function, GetPageFromCache}

{------------------------------------------------------------------------------}
{ TppPublisher.GetPagesFromCache }

function TppPublisher.GetPagesFromCache: Boolean;
var
  liPage: Integer;
  lsPage: String;
  lPage: TppPage;
  lPageList: TStringList;
begin

  Result := False;

  if not(FCachePages) then Exit;

  FReadingCache := True;

  case FPageRequest.PageSetting of
    psAll:
      begin

        if FReportCompleted then
          begin

            if (FPageCache.Count > 0) then
              begin
                lPage := GetPageFromCache(1);

                if (lPage.AbsolutePageCount <> FPageCache.Count) then
                  Result := False
                else
                  Result := True;
              end;

            if (Result) then
              for liPage := 1 to FPageCache.Count do
                begin
                  lPage := GetPageFromCache(liPage);

                  ReceivePage(lPage);
                end;

          end;

      end;

    psSinglePage:
      begin
        lPage := GetPageFromCache(FPageRequest.PageRequested);

        if (lPage <> nil) then
          begin
            ReceivePage(lPage);

            Result := True;
          end;

      end;

    psFirstPage:
      begin
        lPage := GetPageFromCache(1);

        if (lPage <> nil) then
          begin
            ReceivePage(lPage);

            Result := True;
          end;

      end;

    psLastPage:
      begin
        if FReportCompleted then
          begin
            lPage := GetPageFromCache(FAbsolutePageCount);

            if (lPage <> nil) then
              begin
                ReceivePage(lPage);

                Result := True;
              end;

          end;

      end;

    psPageList:
      begin

        Result := True;

        lPageList := TStringList.Create;

        try
          lPageList.Assign(FPageRequest.PageList);

          liPage := 0;

          while (liPage < lPageList.Count) do
            begin
              lsPage := lPageList[liPage];

              lPage := GetPageFromCache(StrToInt(lsPage));

              if (lPage <> nil) then
                begin
                  lPageList.Delete(liPage);

                  ReceivePage(lPage);
                end

              else
                Inc(liPage);

              if (lPage = nil) then
                Result := False;
            end;

          finally

            lPageList.free;
          end;

      end;

  end; {case, PageSetting}

  FReadingCache := False;

end; {procedure, GetPagesFromCache}

{------------------------------------------------------------------------------}
{ TppPublisher.AddDevice }

procedure TppPublisher.AddDevice(aDevice: TppDevice);
begin

  if not IsValidDevice(aDevice) then Exit;

  if aDevice.Stackable then
    AddStackableDevice(aDevice);

  FDevices.Add(aDevice);

  {add device to own notify list}
  AddNotify(aDevice);

end; {procedure, AddDevice}

{------------------------------------------------------------------------------}
{ TppPublisher.RemoveDevice }

procedure TppPublisher.RemoveDevice(aDevice: TppDevice);
begin

  {remove device from list}
  if (aDevice <> nil) and (FDevices.IndexOf(aDevice) <> -1) then
    FDevices.Remove(aDevice);

  {remove device from stackable list}
  if aDevice.Stackable then
    RemoveStackableDevice(aDevice);

  {remove device from own notify list}
  RemoveNotify(aDevice);

end; {procedure, RemoveDevice}

{------------------------------------------------------------------------------}
{ TppPublisher.AddStackableDevice }

procedure TppPublisher.AddStackableDevice(aDevice: TppDevice);
var
  liStack: Integer;
  lStack: TList;

begin

  {check whether a stack with the given name already exists}
  liStack := FStacks.IndexOf(aDevice.StackName);

  {get the stack or create a new one if needed}
  if liStack >= 0 then
    lStack := TList(FStacks.Objects[liStack])
  else
    begin
      lStack  := TList.Create;
      FStacks.AddObject(aDevice.StackName, lStack);
    end;

  {remove the device at the front of the stack from the active Device list}
  if lStack.Count > 0 then
    FDevices.Remove(TppDevice(lStack[0]));

  {add new device to the front of the stack}
  lStack.Insert(0, aDevice);

end; {procedure, AddStackableDevice}

{------------------------------------------------------------------------------}
{ TppPublisher.IsValidDevice }

function TppPublisher.IsValidDevice(aDevice: TppDevice): Boolean;
var
  lStack: TList;
  liStack: Integer;

begin

  Result := False;

  {check if device is already in Device list}
  if (aDevice = nil) or (FDevices.IndexOf(aDevice) >= 0) then Exit;

  {check if device is already in Stack list}
  for liStack := 0 to FStacks.Count-1  do
    begin
      lStack := TList(FStacks.Objects[liStack]);
      if lStack.IndexOf(aDevice) >= 0 then Exit;
    end;

  Result := True;

end; {procedure, IsValidDevice}

{------------------------------------------------------------------------------}
{ TppPublisher.GetDevice }

function TppPublisher.GetDevice(aIndex: Integer): TppDevice;
begin
  Result := TppDevice(FDevices[aIndex]);
end; {function, GetDevice}

{------------------------------------------------------------------------------}
{ TppPublisher.GetDeviceCount }

function  TppPublisher.GetDeviceCount: Integer;
begin
  Result := FDevices.Count;
end; {function, GetDeviceCount}

{------------------------------------------------------------------------------}
{ TppPublisher.GetPage }

function TppPublisher.GetPage(aIndex: Integer): TppPage;
begin
  Result := TppPage(FPageCache.Objects[aIndex]);
end; {function, GetPage}

{------------------------------------------------------------------------------}
{ TppPublisher.GetPageCount }

function  TppPublisher.GetPageCount: Integer;
begin
  Result := FPageCache.Count;
end; {function, GetPageCount}

{------------------------------------------------------------------------------}
{ TppPublisher.RemoveStackableDevice }

procedure TppPublisher.RemoveStackableDevice(aDevice: TppDevice);
var
  liStack: Integer;
  lStack: TList;

begin

  {find the stack}
  liStack := FStacks.IndexOf(aDevice.StackName);

  if liStack < 0 then Exit;

  lStack := TList(FStacks.Objects[liStack]);

  {remove device from stack and if this device in on top of stack then...}
  if (lStack.Remove(aDevice) = 0) then

    {add next device in stack to list of active devices}
    if (lStack.Count > 0) then
      FDevices.Add(lStack[0]);

end; {procedure, RemoveStackableDevice}


{******************************************************************************
 *
 ** D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDevice.Create }

constructor TppDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FActive := True;
  FBusy := False;
  FCancelDialog := nil;
  FIsRequestedPage := False;
  FIsMessagePage := False;
  FLanguageIndex := 0;
  FOnSetPublisher := nil;
  FPageRequest := TppPageRequest.Create;
  FStackable := False;
  FStackName := '';
  FStatus :=  '';
  FPublisher := nil;
  FWaitingForPage := True;

  FOnCancelJob := nil;
  FOnEndJob := nil;
  FOnPageReceive := nil;
  FOnPageRequest := nil;
  FOnStartJob := nil;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDevice.Destroy }

destructor TppDevice.Destroy;
begin

  FPageRequest.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDevice.AfterProcessDrawCommand }

procedure TppDevice.AfterProcessDrawCommand;
begin
  // descendants can override
end;

{------------------------------------------------------------------------------}
{ TppDevice.BeforeProcessDrawCommand }

procedure TppDevice.BeforeProcessDrawCommand(aDrawCommand: TppDrawCommand);
begin
  // descendants can override
end;

{------------------------------------------------------------------------------}
{ TppDevice.SetPageRequest }

procedure TppDevice.SetPageRequest(aPageRequest: TppPageRequest);
begin
  FPageRequest.Assign(aPageRequest);
end; {function, SetPageRequest}

{------------------------------------------------------------------------------}
{ TppDevice.GetPageList }

function TppDevice.GetPageList: TStrings;
begin
  Result := FPageRequest.PageList;
end; {function, GetPageList}

{------------------------------------------------------------------------------}
{ TppDevice.GetPageRequested }

function TppDevice.GetPageRequested: Integer;
begin
  Result := FPageRequest.PageRequested;
end; {function, GetPageRequested}

{------------------------------------------------------------------------------}
{ TppDevice.GetPageSetting }

function TppDevice.GetPageSetting: TppPageSettingType;
begin
  Result := FPageRequest.PageSetting;
end; {function, GetPageSetting}

{------------------------------------------------------------------------------}
{ TppDevice.SetPageList }

procedure TppDevice.SetPageList(aPageList: TStrings);
begin
  FPageRequest.PageList := aPageList;
end; {procedure, SetPageList}

{------------------------------------------------------------------------------}
{ TppDevice.SetPageRequested }

procedure TppDevice.SetPageRequested(Value: Integer);
begin
  FPageRequest.PageRequested := Value;
end; {procedure, SetPageRequested}

{------------------------------------------------------------------------------}
{ TppDevice.SetPageSetting }

procedure TppDevice.SetPageSetting(aPageSetting: TppPageSettingType);
begin
  FPageRequest.PageSetting := aPageSetting;
end; {procedure, SetPageSetting}


{@TppDevice.DeviceName
 The DeviceName will automatically appear in the list of Devices displayed when
 assigning the Report.DeviceType or ArchiveReader.DeviceType properties.}

class function TppDevice.DeviceName: String;
begin
  Result := ClassName;
end; {class function, DeviceName}

{------------------------------------------------------------------------------}
{ TppDevice.SetStatus }

procedure TppDevice.SetStatus(const aValue: String);
begin
  FStatus := aValue;
end; {procedure, SetStatus}

{------------------------------------------------------------------------------}
{ TppDevice.SetActive }

procedure TppDevice.SetActive(aValue: Boolean);
begin
  if FBusy then Exit;

  FActive := aValue;
end; {procedure, SetActive}


{@TppDevice.Reset
 Returns the device to the state it was in before any pages were requested or
 received.}

procedure TppDevice.Reset;
begin
  FPageRequest.Reset;

  FCancelled := False; 

  FWaitingForPage := True;
end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppDevice.SetPublisher}

procedure TppDevice.SetPublisher(aPublisher: TppPublisher);
begin
  if (FPublisher <> nil) then
    FPublisher.RemoveDevice(Self);

  FPublisher := aPublisher;

  if (FPublisher <> nil) then
    FPublisher.AddDevice(Self);

  DoOnSetPublisher;
end; {procedure, SetPublisher}


{@TppDevice.Notify
 Whether or not the device is currently receiving pages from the report.}

procedure TppDevice.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aCommunicator = FPublisher) and (aOperation = ppopRemove) then
    begin
      FPublisher := nil;

      DoOnSetPublisher;
    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDevice.DoOnSetPublisher }

procedure TppDevice.DoOnSetPublisher;
begin
  if Assigned(FOnSetPublisher) then FOnSetPublisher(Self);
end; {procedure, DoOnSetPublisher}


{@TppDevice.FinalPagesOnly
 When this function returns True, only pages which have the Final property set
 to True will be sent to the device's ReceivePage method.}

function TppDevice.FinalPagesOnly: Boolean;
begin
  Result := True;
end; {function, FinalPagesOnly}


{@TppDevice.DrawUpdateable
 When a page is received, and the device is updating the page, this routine is
 called by updateable draw commands in order to convert the command to a format
 appropriate for the device.}

function TppDevice.DrawUpdateable(aDrawCommand: TppDrawCommand): Boolean;
begin
  Result := False;
end; {function, DrawUpdateable}


{@TppDevice.Draw
 When a page is received, and the device is rendering the page, this routine is
 called by draw command when the draw command does implement the draw method.}

function TppDevice.Draw(aDrawCommand: TppDrawCommand): Boolean;
begin
  Result := False;
end; {function, Draw}

{------------------------------------------------------------------------------}
{ TppDevice.DrawPage}

procedure TppDevice.DrawPage(aPage: TppPage);
var
  liCommand: Integer;
  liCommands: Integer;
  lDrawCommand: TppDrawCommand;

begin

  {loop through objects, drawing each one on the canvas}
  liCommand  := 0;
  liCommands := aPage.DrawCommandCount;

  while (liCommand <= liCommands - 1) do
    begin
      lDrawCommand := aPage.DrawCommands[liCommand];

      if (lDrawCommand.Left <= aPage.PageDef.mmWidth)  and
         (lDrawCommand.Top  <= aPage.PageDef.mmHeight) then
        begin

          try
            BeforeProcessDrawCommand(lDrawCommand);

            lDrawCommand.Draw(Self);

          finally
            AfterProcessDrawCommand;
          end;

        end;


      Inc(liCommand);
    end; {while, each print object}



end; {procedure, DrawPage}

{------------------------------------------------------------------------------}
{ TppDevice.DoOnPageRequest }

procedure TppDevice.DoOnPageRequest;
begin
  if Assigned(FOnPageRequest) then FOnPageRequest(Self);
end; {procedure, DoOnPageRequest}


{@TppDevice.StartJob
 Before the report begins generation, the StartJob method of all connected
 devices is called.}

procedure TppDevice.StartJob;
begin
  if FBusy then Exit;

  FBusy := True;
  FCancelled := False;

  if Assigned(FOnStartJob) then FOnStartJob(Self);
end; {procedure, StartJob}


{@TppDevice.EndJob
 When the report completes generation, the EndJob method of all connected
 devices is called.}

procedure TppDevice.EndJob;
begin
  if not FBusy then Exit;

  FBusy := False;

  FWaitingForPage := True;

  if Assigned(FOnEndJob) then FOnEndJob(Self);
end; {procedure, EndJob}


{@TppDevice.CancelJob
 If the report generation process is cancelled, the Publisher calls the
 CancelJob method of each connected device.}

procedure TppDevice.CancelJob;
begin
  FBusy := False;

  FCancelled := True;

  if Assigned(FOnCancelJob) then FOnCancelJob(Self);
end; {procedure, CancelJob}


{@TppDevice.MakePageRequest
 When this routine is called, the device requests pages from the publisher based
 on the value of the PageSetting, PageRequested, and PageList properties.}

procedure TppDevice.MakePageRequest;
begin
  if (FPublisher = nil) then Exit;

  FWaitingForPage := True;

  try
    FPublisher.StartJob;
    FPublisher.Publish;
  finally
    if not(FWaitingForPage) then
      FPublisher.EndJob;
  end;

end; {procedure, MakePageRequest}


{@TppDevice.ReceivePage

 Whether or not the device is currently receiving pages from the report.}

procedure TppDevice.ReceivePage(aPage: TppPage);
var
  lParams: TraParamList;
begin

  FIsMessagePage := False;

  FIsRequestedPage := FPageRequest.IsRequestedPage(aPage);

  {if calculation, page doesn't count}
  if aPage.Calculation then
    FIsMessagePage := True;

  {if device wants finals only, page doesn't count}
  if not(aPage.Final) and (FinalPagesOnly) then
    FIsMessagePage := True;

  {trigger the event}
  if Assigned(FOnPageReceive) then FOnPageReceive(Self, aPage);

  lParams := TraParamList.Create;

  lParams.AddParam('Page', daObject, TppPage, '', True, False);
  lParams.SetValuePointer(0, aPage);

  SendEventNotify(Self, ciDevicePageReceive, lParams);

  CheckPagesRequested(aPage);

  lParams.Free;

end; {procedure, ReceivePage}

{------------------------------------------------------------------------------}
{ TppDevice.CheckPagesRequested }

procedure TppDevice.CheckPagesRequested(aPage: TppPage);
begin

  if not(FWaitingForPage) then Exit;
  
  if not(aPage.Final) then Exit;

  if aPage.Calculation then Exit;

  FWaitingForPage := not(FPageRequest.AllPagesReceived(aPage));

end; {procedure, CheckPagesRequested}

{------------------------------------------------------------------------------}
{ TppDevice.SetStackable }

procedure TppDevice.SetStackable(Value: Boolean);
begin

  {do not assign this property if device is already registered with a publisher }
  if (FPublisher = nil) and not(FBusy) then
    FStackable := Value;

end; {procedure, SetStackable}

{------------------------------------------------------------------------------}
{ TppDevice.SetStackName }

procedure TppDevice.SetStackName(aName: String);
begin
  {do not assign this property if device is already registered with a publisher }
  if (FPublisher = nil) and not(FBusy) then
    FStackName := aName;

end; {procedure, SetStackName}

{******************************************************************************
 *
 ** P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPage.Create }

constructor TppPage.Create(aOwner: TComponent);

begin
  inherited Create(aOwner);

  FAbsolutePageNo := 0;
  FAbsolutePageCount := 0;
  FCalculation := False;
  FClickables := nil;
  FControlGroupBreakNo := 0;
  FColor := 16777215; {White}
  FDocumentName := '';
  FFinal := False;
  FLanguageIndex := 0;
  FLastPage := False;
  FPageCount := 0;
  FPageNo := 0;
  FPrinterSetup := TppPrinterSetup.Create(Self);
  FProducer := nil;
  FUpdateables := nil;
  FFileSuffix := '';
  FFirstFileSuffix := '';
  FNewJob := False;
  FEmailSettings := TppEmailSettings.Create;

end; {constructor, TppPage}

{------------------------------------------------------------------------------}
{ TppPage.Destroy }

destructor TppPage.Destroy;
begin
  FreeDrawCommands;

  FClickables.Free;
  FUpdateables.Free;

  FPrinterSetup.Free;
  FEmailSettings.Free;

  inherited Destroy;

end; {destructor, TppPage}


{@TppPage.Assign
 Assigns the contents from one page to another. Assign creates draw commands
 based on the ones contained in the page passed in the Source parameter, and
 calls Assign for each draw command.}

procedure TppPage.Assign(Source: TPersistent);
var
  liCommands: Integer;
  liCommand: Integer;
  lPage: TppPage;
  lDrawCommandClass: TppDrawCommandClass;
  lSourceDrawCommand: TppDrawCommand;
  lTargetDrawCommand: TppDrawCommand;
begin

  if not(Source is TppPage) then
    inherited Assign(Source);

  lPage := TppPage(Source);

  FAbsolutePageNo      := lPage.AbsolutePageNo;
  FAbsolutePageCount   := lPage.AbsolutePageCount;
  FCalculation         := lPage.Calculation;
  FColor := lPage.Color;
  FControlGroupBreakNo := lPage.ControlGroupBreakNo;
  FDocumentName        := lPage.DocumentName;
  FFinal               := lPage.Final;
  FFirstPage           := lPage.FirstPage;
  FLanguageIndex       := lPage.LanguageIndex;
  FLastPage            := lPage.LastPage;
  FPassSetting         := lPage.PassSetting;
  FPageCount           := lPage.PageCount;
  FPageNo              := lPage.PageNo;
  FPrintDateTime       := lPage.PrintDateTime;
  FProducer            := lPage.Producer;
  FNewJob              := lPage.NewJob;
  FFileSuffix          := lPage.FileSuffix;
  FFirstFileSuffix     := lPage.FirstFileSuffix;

  FEmailSettings.Assign(lPage.EmailSettings);
  FPrinterSetup.Assign(lPage.PrinterSetup);

  {copy draw commands}
  FreeDrawCommands;

  liCommands := lPage.DrawCommandCount;

  for liCommand := 0 to liCommands - 1 do
    begin
      lSourceDrawCommand := lPage.DrawCommands[liCommand];

      {get an instance of the class}
      lDrawCommandClass := TppDrawCommandClass(lSourceDrawCommand.ClassType);

      {instantiate a draw command of the selected type}
      if (lDrawCommandClass <> nil) then
        begin
          lTargetDrawCommand := lDrawCommandClass.Create(nil);
          lTargetDrawCommand.Assign(lSourceDrawCommand);
          lTargetDrawCommand.Page := Self;
        end;

    end; {each draw command}

end; {procedure, Assign}
  
{------------------------------------------------------------------------------}
{ TppPage.IndexOfDrawCommand }

function TppPage.IndexOfDrawCommand(aDrawCommand: TppDrawCommand): Integer;
begin
  Result := IndexOfChild(aDrawCommand);
end;  {function, IndexOfDrawCommand}

{------------------------------------------------------------------------------}
{ TppPage.Loaded }

procedure TppPage.Loaded;
begin

  FPrinterSetup.Loaded;

  inherited Loaded;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TppPage.Clear}

procedure TppPage.Clear;
begin

  FreeDrawCommands;

  FAbsolutePageNo := 0;
  FAbsolutePageCount := 0;
  FCalculation := False;
  FControlGroupBreakNo := 0;
  FDocumentName := '';
  FFinal := False;
  FLanguageIndex := 0;
  FLastPage := False;
  FPageCount := 0;
  FPageNo := 0;
  
end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppPage.EqualTo}

function TppPage.EqualTo(aPage: TppPage): Boolean;
var
  lsMessage: String;
begin

  lsMessage := '';
  Result := EqualTo(aPage, lsMessage);

end;

{------------------------------------------------------------------------------}
{ TppPage.EqualTo}

function TppPage.EqualTo(aPage: TppPage; var aMessage: String): Boolean;
var
  liIndex: Integer;
  liCount: Integer;
  lDrawCommand1: TppDrawCommand;
  lDrawCommand2: TppDrawCommand;
begin

  Result := GetDrawCommandCount = aPage.DrawCommandCount;

  if (Result) then
    begin

      liIndex := 0;
      liCount := GetDrawCommandCount;

      while Result and (liIndex < liCount) do
        begin
          lDrawCommand1 := GetDrawCommandForIndex(liIndex);
          lDrawCommand2 := aPage.DrawCommands[liIndex];

          Result := lDrawCommand1.EqualTo(lDrawCommand2);

          if not(Result) then
            aMessage := 'Error: ' + lDrawCommand1.ClassName + '(' + IntToStr(liIndex) + ')';

{$IFDEF CodeSite}
  if not(Result) then
    begin
      CodeSite.Send('TppPage.EqualTo: Page ' + IntToStr(aPage.AbsolutePageNo) + ' is not equal');
      CodeSite.Send('liIndex is ' + IntToStr(liIndex));

    end;
{$ENDIF}
          Inc(liIndex);
        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppPage.GetPageSetDescription}

function TppPage.GetPageSetDescription: String;
begin
  {'Page 1 of 10'}
  Result := ppLoadStr(18) + ' ' + IntToStr(FAbsolutePageNo) + ' ' + ppLoadStr(16) + ' ' + IntToStr(FAbsolutePageCount);
end; {function, GetPageSetDescription}

{------------------------------------------------------------------------------}
{ TppPage.GetPageNoDescription}

function TppPage.GetPageNoDescription: String;
begin
  {'Page 1'}
  Result := ppLoadStr(18) + ' ' + IntToStr(FAbsolutePageNo);
end; {function, GetPageNoDescription}

{------------------------------------------------------------------------------}
{ TppPage.SetEmailSettings}

procedure TppPage.SetEmailSettings(aEmailSettings: TppEmailSettings);
begin
  FEmailSettings.Assign(aEmailSettings);

end;

{------------------------------------------------------------------------------}
{ TppPage.SetPrinterSetup}

procedure TppPage.SetPrinterSetup(aPrinterSetup: TppPrinterSetup);
begin

  if (aPrinterSetup <> nil) then
    FPrinterSetup.Assign(aPrinterSetup);

end; {procedure, SetPrinterSetup}

{------------------------------------------------------------------------------}
{ TppPage.StoreEmailSettings}

function TppPage.StoreEmailSettings: Boolean;
begin
  Result := FEmailSettings.Recipients.Count > 0;

end; {procedure, StoreEmailSettings}

{@TppPage.FreeDrawCommands
 Frees all draw commands in the page.}

procedure TppPage.FreeDrawCommands;
begin
  FreeChildren;

end; {procedure, FreeDrawCommands}

{------------------------------------------------------------------------------}
{ TppPage.GetDrawCommandForIndex }

function TppPage.GetDrawCommandForIndex(aIndex: Integer): TppDrawCommand;
begin
  Result := TppDrawCommand(Children[aIndex]);
end; {procedure, GetDrawCommandForIndex}

{------------------------------------------------------------------------------}
{ TppPage.GetDrawCommandCount }

function TppPage.GetDrawCommandCount: Integer;
begin
  Result := ChildCount;
end; {procedure, GetDrawCommandCount}

{------------------------------------------------------------------------------}
{ TppPage.GetClickable }

function TppPage.GetClickable(aIndex: Integer): TppDrawCommand;
begin
  if (FClickables <> nil) then
    Result := TppDrawCommand(FClickables[aIndex])
  else
    Result := nil;
end; {procedure, GetClickable}

{------------------------------------------------------------------------------}
{ TppPage.GetClickableCount }

function TppPage.GetClickableCount: Integer;
begin
  if (FClickables <> nil) then
    Result := FClickables.Count
  else
    Result := 0;
end; {procedure, GetClickableCount}

{------------------------------------------------------------------------------}
{ TppPage.GetPageDef }

function TppPage.GetPageDef: TppPageDef;
begin
  Result := FPrinterSetup.PageDef;
end; {procedure, GetPageDef}


{@TppPage.AddDrawCommand

 When the Page property of a draw command is set, this method is called in order
 to add the DrawCommand to the page.}

procedure TppPage.AddDrawCommand(aDrawCommand: TppDrawCommand);
var
  liIndex: Integer;
  lDrawCommand: TppDrawCommand;
begin

  if (aDrawCommand is TppOutlineDrawCommand) then
    begin
      for liIndex := 0 to GetDrawCommandCount - 1 do
        begin

          lDrawCommand := GetDrawCommandForIndex(liIndex);

          if (lDrawCommand is TppOutlineDrawCommand) then
            raise EOutlineError.Create('TppPage.AddDrawCommand: Cannot add more than one draw outline command per page.');

        end;

    end;

  AddChild(aDrawCommand);

  if aDrawCommand.IsUpdateable then
    AddUpdateable(aDrawCommand);

  if aDrawCommand.Clickable then
    AddClickable(aDrawCommand);

  if aDrawCommand.Owner <> Self then
    begin
      if aDrawCommand.Owner <> nil then
        aDrawCommand.Owner.RemoveComponent(aDrawCommand);

//      InsertComponent(aDrawCommand);
    end;

end; {procedure, AddDrawCommand}


{@TppPage.RemoveDrawCommand

  Removes the draw command specified in the aDrawCommand parameter from the
  page.}

procedure TppPage.RemoveDrawCommand(aDrawCommand: TppDrawCommand);
begin

  RemoveChild(aDrawCommand);

  if aDrawCommand.Clickable then
    RemoveClickable(aDrawCommand);
    
  if aDrawCommand.IsUpdateable then
    RemoveUpdateable(aDrawCommand);

  if (aDrawCommand.Owner = Self) and not(csDestroying in ComponentState) then
    RemoveComponent(aDrawCommand);

end; {procedure, RemoveDrawCommand}

{------------------------------------------------------------------------------}
{ TppPage.AddUpdateable }

procedure TppPage.AddUpdateable(aDrawCommand: TppDrawCommand);
begin
  if (FUpdateables = nil) then
    FUpdateables := TList.Create;

  FUpdateables.Add(aDrawCommand);

end; {procedure, AddUpdateables}

{------------------------------------------------------------------------------}
{ TppPage.RemoveUpdateable }

procedure TppPage.RemoveUpdateable(aDrawCommand: TppDrawCommand);
begin

  FUpdateables.Remove(aDrawCommand);

  if (FUpdateables.Count = 0) then
    begin
      FUpdateables.Free;

      FUpdateables := nil;
    end;

end; {procedure, RemoveUpdateable}

{------------------------------------------------------------------------------}
{ TppPage.AddClickable }

procedure TppPage.AddClickable(aDrawCommand: TppDrawCommand);
begin
  if (FClickables = nil) then
    FClickables := TList.Create;

  FClickables.Add(aDrawCommand);

  {this property tracks the clickable state when archiving}
  aDrawCommand.Clickable := True;

end; {procedure, AddClickables}

{------------------------------------------------------------------------------}
{ TppPage.RemoveClickable }

procedure TppPage.RemoveClickable(aDrawCommand: TppDrawCommand);
begin

  if (FClickables <> nil) then
    begin

      FClickables.Remove(aDrawCommand);

      if (FClickables.Count = 0) then
        begin
          FClickables.Free;

          FClickables := nil;
        end;
        
    end;

end; {procedure, RemoveClickable}

{------------------------------------------------------------------------------}
{ TppPage.HasClickables }

function TppPage.HasClickables: Boolean;
begin
  Result := (FClickables <> nil);
end; {procedure, HasClickables}


{@TppPage.HasUpdateables
 Indicates whether any of the draw commands contained in the page are
 updateable.  Updateable draw commands can change their value to reflect
 additional information generated by the report engine.  The PageCount and
 AbsolutePageCount properties of the page are used by draw commands that have
 been generated from PageSet or PageSetDesc TppCalc components in order to
 update and redraw the draw commands as the report engine generates pages
 during the first pass.}

function TppPage.HasUpdateables: Boolean;
begin
  Result := (FUpdateables <> nil);
end; {procedure, HasUpdateables}


{@TppPage.Update
 Notifies any updateable draw commands contained within the page that new
 information is available. The draw command usually responds by updating the
 Text property and, when the aDevice parameter is not nil, redrawing to the
 specified device.

 Updateable draw commands can change their value to reflect additional
 information generated by the report engine.  The PageCount and
 AbsolutePageCount properties of the page are used by draw commands that have
 been generated from PageSet or PageSetDesc TppCalc components in order to
 update and redraw the draw commands as the report engine generates pages
 during the first pass.}


procedure TppPage.Update(aDevice: TppDevice);
var
  liDrawCommand: Integer;
  liDrawCommands: Integer;
  lDrawCommand: TppDrawCommand;
  lbDataChanged: Boolean;
begin

  if not(HasUpdateables) then Exit;
  
  liDrawCommands := FUpdateables.Count;

  for liDrawCommand := 0 to (liDrawCommands - 1) do
    begin
      lDrawCommand := TppDrawCommand(FUpdateables[liDrawCommand]);

      lbDataChanged := lDrawCommand.Update;

      if (aDevice <> nil) and lbDataChanged then
        aDevice.DrawUpdateable(lDrawCommand);
    end;

end; {procedure, Update}

{------------------------------------------------------------------------------}
{ TppPage.GetScaledWidth }

function TppPage.GetScaledWidth(aScalePercentage: Integer; aUnits: TppUnitType): Integer;
begin

  Result := Round(ppFromMMThousandths(PrinterSetup.PageDef.mmWidth, aUnits, pprtVertical, nil));
  Result := Round(Result * aScalePercentage / 100.0);

end; { function, GetScaledWidth }

{------------------------------------------------------------------------------}
{ TppPage.GetScaledHeight }

function TppPage.GetScaledHeight(aScalePercentage: Integer; aUnits: TppUnitType): Integer;
begin

  Result := Round(ppFromMMThousandths(PrinterSetup.PageDef.mmHeight, aUnits, pprtVertical, nil));
  Result := Round(Result * aScalePercentage / 100.0);

end; { function, GetScaledHeight }

{------------------------------------------------------------------------------}
{ TppPage.GetDrawCommandForClass }

function TppPage.GetDrawCommandForClass(aDrawCommandClass: TppDrawCommandClass): TppDrawCommand;
var
  liIndex: Integer;
begin

  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < GetDrawCommandCount) do
    if (DrawCommands[liIndex] is aDrawCommandClass) then
      Result :=  DrawCommands[liIndex]
    else
      Inc(liIndex);

end;  {procedure, GetDrawCommandForClass}

function TppPage.GetDrawCommandForExpansionKey(aExpansionKey: String): TppDrawCommand;
var
  liIndex: Integer;
  lsKey: String;
begin

  Result := nil;

  lsKey := Trim(aExpansionKey);

  for liIndex := 0 to DrawCommandCount-1 do
    if Trim(DrawCommands[liIndex].ExpansionKey) = lsKey then
      begin
        Result := DrawCommands[liIndex];
        Exit;
      end;

end;

{------------------------------------------------------------------------------}
{ TppPage.GetOutlineDrawCommand }

function TppPage.GetOutlineDrawCommand: TppDrawCommand;
var
  lOutlineDrawCommandClass: TppDrawCommandClass;
begin

  lOutlineDrawCommandClass :=  TppDrawCommandClass(GetClass('TppOutlineDrawCommand'));

  Result := GetDrawCommandForClass(lOutlineDrawCommandClass);

end;  {procedure, GetOutlineDrawCommand}


{******************************************************************************
 *
 ** D R A W   C O M M A N D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDrawCommand.Create }

constructor TppDrawCommand.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FBand := nil;
  FBorder := TppBorder.Create(nil);
  FClickable := False;
  FDataType := dtString;
  FDrawLeft := 0;
  FDrawRight := 0;
  FDrawTop := 0;
  FDrawBottom := 0;
  FExpansionKey := '';
  FLeft := 0;
  FHeight := 0;
  FOnClick := nil;
  FPage := nil;
  FRedrawPage := False;
  FTop := 0;
  FWidth := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDrawCommand.Destroy }

destructor TppDrawCommand.Destroy;
begin

  SetPage(nil);
  FBorder.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDrawCommand.EqualTo }

function TppDrawCommand.EqualTo(aDrawCommand: TppDrawCommand): Boolean;
begin

  Result := (FLeft = aDrawCommand.Left) and
            (FHeight = aDrawCommand.Height) and
            (FTop = aDrawCommand.Top) and
            (FWidth = aDrawCommand.Width) and
            (FDisplayFormat = aDrawCommand.FDisplayFormat) and
            (FDataType = aDrawCommand.FDataType) and
            (FValue = aDrawCommand.FValue);

end; {function, EqualTo}

{------------------------------------------------------------------------------}
{ TppDrawCommand.SetPage }

procedure TppDrawCommand.SetPage(aPage: TppPage);
begin
  if (FPage <> nil) then
    FPage.RemoveDrawCommand(Self);

  FPage := aPage;

  if (FPage <> nil) then
    FPage.AddDrawCommand(Self);


end; {procedure, SetPage}

{------------------------------------------------------------------------------}
{ TppDrawCommand.SetBorder }

procedure TppDrawCommand.SetBorder(aBorder: TppBorder);
begin
  FBorder.Assign(aBorder);

end;  {procedure, SetBorder}

{------------------------------------------------------------------------------}
{ TppDrawCommand.StoreBorder }

function TppDrawCommand.StoreBorder: Boolean;
begin
  Result := FBorder.Visible;

end; {procedure, StoreBorder}

{------------------------------------------------------------------------------}
{ TppDrawCommand.DoOnClick }

procedure TppDrawCommand.DoOnClick;
begin
  if Assigned(FOnClick) then FOnClick(Self);
end; {function, DoOnClick}


{@TppDrawCommand.IsUpdateable
 Indicates whether the command should be notified as the report engine generates
 pages.  This is used by draw commands which represent page counts in order to
 update their values as the report generates.  Each time the screen device
 receives a message page the Update method of the page is called.  This method
 loops thru the updateable draw commands calling the Update method.}

function TppDrawCommand.IsUpdateable;
begin
  Result := False;
end; {function, IsUpdateable}


{@TppDrawCommand.Assign
 When the Source is a draw command, copies the property values of the source
 draw command to itself.

 Assign is overriden by descendants so that they can copy the property values
 which they implement.}

procedure TppDrawCommand.Assign(Source: TPersistent);
var
  lDrawCommand: TppDrawCommand;
begin

  if not(Source is TppDrawCommand) then
    inherited Assign(Source);

  lDrawCommand := TppDrawCommand(Source);

  FBand := lDrawCommand.Band;
  FClickable := lDrawCommand.Clickable;
  FDataType := lDrawCommand.DataType;
  FDrawLeft := lDrawCommand.DrawLeft;
  FDrawRight := lDrawCommand.DrawRight;
  FDrawTop := lDrawCommand.DrawTop;
  FDrawBottom := lDrawCommand.DrawBottom;
  FExpansionKey := lDrawCommand.ExpansionKey;
  FHeight := lDrawCommand.Height;
  FLeft := lDrawCommand.Left;
  FOnClick := lDrawCommand.OnClick;
  Tag := lDrawCommand.Tag;
  FTop := lDrawCommand.Top;
  FWidth := lDrawCommand.Width;
  SetBorder(lDrawCommand.Border);

  FDisplayFormat := lDrawCommand.FDisplayFormat;
  FDataType := lDrawCommand.FDataType;
  FValue := lDrawCommand.FValue;


end; {procedure, Assign}


{@TppDrawCommand.Draw
 When a device does not recognize a draw command, it will call this method,
 passing itself as the parameter, in order to convert the command to a format
 useable by the device. The standard draw commands which are provided with
 ReportBuilder, are rendered by methods within the device.  The one exception is
 TppDrawRichText, which implements the draw methods for the printer and screen
 device within itself.

 The ability to place draw methods in either the draw command or device provides
 flexibility necessary when a new device class or a new draw command class must
 be created.  When creating a new draw command class, you can override this
 method and implement the code necessary to render the command for all devices
 you choose to support.  If you choose not to render for a particular device
 (the TppTextFileDevice for instance) then simply return false when the device
 calls this method.}

function TppDrawCommand.Draw(aDevice: TppDevice): Boolean;
begin
  Result := aDevice.Draw(Self);
end; {procedure, Draw}

function TppDrawCommand.GetDrawHeight: LongInt;
begin
  Result := DrawBottom - DrawTop;
end;


{@TppDrawCommand.Update
 This method allows updateable draw commands to reaccess and reformat data based
 on new information received from the report engine. If the data was changed,
 the routine returns true, else the routine returns false.

 When a draw command is an updateable, this procedure will be called as the
 report generates additional pages. This allows draw commands which represent
 page counts to update as the report is generating.}

function TppDrawCommand.Update: Boolean;
begin
  Result := False;
end; {procedure, Update}

{------------------------------------------------------------------------------}
{ TppDrawCommand.GetDrawRect }

function TppDrawCommand.GetDrawRect: TRect;
begin
  Result := Rect(FDrawLeft, FDrawTop, FDrawRight, FDrawBottom);
end; {procedure, GetDrawRect}

function TppDrawCommand.GetDrawWidth: LongInt;
begin
  Result := DrawRight - DrawLeft;
end;

function TppDrawCommand.GetValue: Variant;
begin
  Result := FValue;
end;

{------------------------------------------------------------------------------}
{ TppDrawCommand.SetParent }

procedure TppDrawCommand.SetParent(aParent: TppRelative);
begin

//  if (aParent is TppPage) then
//    SetPage(TppPage(aParent))
//  else
    inherited SetParent(aParent);

end; {procedure, SetParent}


{******************************************************************************
 *
 ** R E G I S T E R   P R O C E D U R E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGetDeviceClassList }

function ppGetDeviceClassList: TList;
begin

  if FDeviceClassList = nil then
    FDeviceClassList := TList.Create;

  Result := FDeviceClassList;

end; {function, ppGetDeviceClassList}

{------------------------------------------------------------------------------}
{ ppDeviceClassForName }

function ppDeviceClassForName(const aDeviceName: String): TppDeviceClass;
var
  lList: TStringList;
  liPosition: Integer;
begin

  lList := TStringList.Create;

  ppGetDeviceClasses(lList);

  liPosition := lList.IndexOf(aDeviceName);

  if (liPosition <> -1) then
    Result := TppDeviceClass(lList.Objects[liPosition])
  else
    Result := nil;

  lList.Free;

end; {function, ppDeviceClassForName}

{------------------------------------------------------------------------------}
{ ppGetDeviceClasses }

procedure ppGetDeviceClasses(aList: TStrings);
var
  lClassList: TList;
  liIndex: Integer;
  lClass: TppDeviceClass;
begin

  lClassList := ppGetDeviceClassList;

  for liIndex := 0 to lClassList.Count - 1 do
    begin
      lClass := TppDeviceClass(lClassList[liIndex]);

      aList.AddObject(lClass.DeviceName, TObject(lClass));
    end;

end; {procedure, GetDeviceClasses}

{------------------------------------------------------------------------------}
{ ppRegisterDevice }

procedure ppRegisterDevice(aDeviceClass: TppDeviceClass);
var
  lClassList: TList;
  liIndex: Integer;
begin

  if (aDeviceClass = nil) then Exit;

  lClassList := ppGetDeviceClassList;

  liIndex :=  lClassList.IndexOf(aDeviceClass);

  if (liIndex = -1) then
    begin
      RegisterClass(aDeviceClass);

      lClassList.Add(aDeviceClass);
    end;

end; {procedure, ppRegisterDevice}

{------------------------------------------------------------------------------}
{ ppUnRegisterDevice }

procedure ppUnRegisterDevice(aDeviceClass: TppDeviceClass);
var
  lClassList: TList;
  liIndex: Integer;
begin

  if (aDeviceClass = nil) then Exit;

  UnRegisterClass(aDeviceClass);

  if (FDeviceClassList = nil) then Exit;

  lClassList := ppGetDeviceClassList;

  liIndex := lClassList.IndexOf(aDeviceClass);

  if (liIndex > -1) then
    lClassList.Delete(liIndex);

end; {procedure, ppUnRegisterDevice}

{******************************************************************************
 *
 ** P A G E   R E Q U E S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPageRequest.Create }

constructor TppPageRequest.Create;
begin

  inherited Create;

  FPageList := TStringList.Create;
  FPageRange := prAll;
  FPageRequested := 1;
  FPageSetting := psAll;
  FDrawCommandClickIndex := -1;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPageRequest.Destroy }

destructor TppPageRequest.Destroy;
begin

  FPageList.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppPageRequest.Assign }

procedure TppPageRequest.Assign(Source: TPersistent);
var
  lSource: TppPageRequest;
begin

  if not(Source is TppPageRequest) then Exit;

  lSource := TppPageRequest(Source);

  FPageList.Assign(lSource.PageList);
  FPageRequested := lSource.PageRequested;
  FPageSetting := lSource.PageSetting;
  FPageRange := lSource.PageRange;
  FDrawCommandClickIndex := lSource.DrawCommandClickIndex;
  FExpansionKey  := lSource.ExpansionKey;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppPageRequest.Reset }

procedure TppPageRequest.Reset;
begin
  FPageList.Clear;
  FPageRange := prAll;
  FPageRequested := 1;
  FPageSetting := psAll;
  FDrawCommandClickIndex := -1;
  FExpansionKey  := '';

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppPageRequest.SetPageList }

procedure TppPageRequest.SetPageList(aPageList: TStrings);
begin
  FPageList.Assign(aPageList);
end; {procedure, SetPageList}

{------------------------------------------------------------------------------}
{ TppPageRequest.IsRequestedPage }

function TppPageRequest.IsRequestedPage(aPage: TppPage): Boolean;
begin

  Result := False;

  case FPageSetting of

    psAll:
      Result := True;

    psPageList:
      Result := FPageList.IndexOf(IntToStr(aPage.AbsolutePageNo)) >= 0;

    psSinglePage:
      begin
        if (FPageRequested > aPage.AbsolutePageCount) and (aPage.LastPage) then
          FPageRequested := aPage.AbsolutePageCount

        else if (FPageRequested < 1) and (aPage.AbsolutePageNo = 1) then
          FPageRequested := 1;

        Result := (aPage.AbsolutePageNo = FPageRequested);
      end;

    psFirstPage:
      Result := aPage.FirstPage;

    psLastPage:
      Result := aPage.LastPage;

  end; {case, page setting type}

  case FPageRange of

    prAll:
      begin
        {do nothing}
      end;

    prOddPages:
      Result := Result and ((aPage.AbsolutePageNo mod 2) <> 0);

    prEvenPages:
      Result := Result and ((aPage.AbsolutePageNo mod 2) = 0);

  end;

end; {procedure, IsRequestedPage}

{------------------------------------------------------------------------------}
{ TppPageRequest.AllPagesReceived }

function TppPageRequest.AllPagesReceived(aPage: TppPage): Boolean;
var
  lsPage: String;
  liIndex: Integer;
begin

  Result := False;


  {check to see if all page requests have been granted}
  case FPageSetting of
    psAll:
      if aPage.LastPage then
        Result := True;

    psFirstPage:
      if (aPage.FirstPage) then
        Result := True;

    psSinglePage:
      if (aPage.AbsolutePageNo = FPageRequested) then
        Result := True;

    psLastPage:
      if aPage.LastPage then
        Result := True;

    psPageList:
      begin
        lsPage := IntToStr(aPage.AbsolutePageNo);
        
        liIndex := FPageList.IndexOf(lsPage);

        if (liIndex = FPageList.Count-1) then
          Result := True;

      end;

  end; {case, page setting type}

end; {procedure, AllPagesReceived}

{------------------------------------------------------------------------------}
{ TppPageRequest.AddPageRequest }

procedure TppPageRequest.AddPageRequest(aPageRequest: TppPageRequest);
begin

  case aPageRequest.PageSetting of

    psSinglePage, psFirstPage:
      begin

        if ((FPageSetting = psSinglePage) and (FPageRequested <> aPageRequest.PageRequested)) or
           ((FPageSetting = psFirstPage) and (aPageRequest.PageRequested <> 1)) then
          begin
            FPageSetting := psPageList;

            if (FPageList = nil) then
              FPageList := TStringList.Create;

            FPageList.Add(IntToStr(FPageRequested));
            FPageList.Add(IntToStr(aPageRequest.PageRequested));
          end

        else if (FPageSetting = psPageList) and (FPageList.IndexOf(IntToStr(aPageRequest.PageRequested)) = -1) then
          FPageList.Add(IntToStr(aPageRequest.PageRequested));

      end;

    else
      begin
        FPageSetting := psAll;
      end; {single page not requested}

  end; {case, page requested}

end; {procedure, AddPageRequest}
 
{TppDeviceSubstitutions.SubstituteFont

  The screen device needs to be able to scale fonts and replaces them for the
  screen in order to have the best appearance.}

class function TppDeviceSubstitutions.SubstituteFont(aFontName: String): String;
begin

  if aFontName = 'Courier' then
    Result := 'Courier New'

  else if aFontName = 'Fixedsys' then
    Result := 'Arial'

  else if aFontName = 'Modern' then
    Result := 'Arial'

  else if aFontName = 'MS Sans Serif' then
    Result := 'Arial'

  else if aFontName = 'MS Serif' then
    Result := 'Courier New'

  else if aFontName = 'Small Fonts' then
    Result := 'Arial'

  else if aFontName = 'System' then
    Result := 'Arial'

  else if aFontName = 'Terminal' then
    Result := 'Arial'

  else
    Result := aFontName;

end;

{******************************************************************************
 *
 ** D R A W C O M M A N D   R T T I
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TraTppDrawCommandRTTI.CallMethod }

class function TraTppDrawCommandRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
begin

  Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppDrawCommandRTTI.GetPropList }

class procedure TraTppDrawCommandRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('Page');
  aPropList.AddProp('Clickable');
  aPropList.AddProp('RedrawPage');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDrawCommandRTTI.GetPropRec }

class function TraTppDrawCommandRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'Clickable')) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (ppEqual(aPropName, 'Page')) then
    ClassPropToRec(aPropName, TppPage, False, aPropRec)

  else if (ppEqual(aPropName, 'RedrawPage')) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDrawCommandRTTI.GetPropValue }

class function TraTppDrawCommandRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'Clickable')) then
    Boolean(aValue) := TppDrawCommand(aObject).Clickable

  else if (ppEqual(aPropName, 'Page')) then
    Integer(aValue) := Integer(TppDrawCommand(aObject).Page)

  else if (ppEqual(aPropName, 'RedrawPage')) then
    Boolean(aValue) := TppDrawCommand(aObject).RedrawPage

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDrawCommandRTTI.RefClass }

class function TraTppDrawCommandRTTI.RefClass: TClass;
begin
  Result := TppDrawCommand;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDrawCommandRTTI.SetPropValue }

class function TraTppDrawCommandRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (ppEqual(aPropName, 'Page')) then
    TppDrawCommand(aObject).Page := TppPage(aValue)

  else if (ppEqual(aPropName, 'RedrawPage')) then
    TppDrawCommand(aObject).RedrawPage := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** P A G E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppPageRTTI.RefClass }

class function TraTppPageRTTI.RefClass: TClass;
begin
  Result := TppPage;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppPageRTTI.GetPropList }

class procedure TraTppPageRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddProp('DrawCommandCount');
  aPropList.AddProp('DrawCommands');

  {add public methods}
  aPropList.AddMethod('RemoveDrawCommand');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppPageRTTI.GetPropRec }

class function TraTppPageRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'DrawCommandCount')  then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'DrawCommands')  then
    AccessSpecifierToRec(aPropName, aPropRec)


  else if (ppEqual(aPropName, 'RemoveDrawCommand')) then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppPageRTTI.CallMethod }

class function TraTppPageRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lDrawCommand: TppDrawCommand;
  lPage: TppPage;
  liIndex: Integer;
begin

  Result := True;

  lPage := TppPage(aObject);

  if ppEqual(aMethodName, 'DrawCommands')  then
    begin
      aParams.GetParamValue(0, liIndex);

      lDrawCommand := lPage.DrawCommands[liIndex];

      aParams.SetParamValue(1, Integer(lDrawCommand));
    end
 else if ppEqual(aMethodName, 'RemoveDrawCommand')  then
    begin
      aParams.GetParamValue(0, lDrawCommand);
      lPage := TppPage(aObject);

      lPage.RemoveDrawCommand(lDrawCommand);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}



{------------------------------------------------------------------------------}
{ TraTppPageRTTI.GetPropValue }

class function TraTppPageRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'DrawCommandCount')  then
    Integer(aValue) := TppPage(aObject).DrawCommandCount

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}




{------------------------------------------------------------------------------}
{ TraTppPageRTTI.GetParams }

class function TraTppPageRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'DrawCommands')  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppDrawCommand, '', False, False);
    end
 else if (ppEqual(aMethodName, 'RemoveDrawCommand')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDrawCommand', daClass, TObject, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class procedure, GetParams}


function TppDrawCommandCollection.Add(aDrawCommand: TppDrawCommand): Integer;
begin
  Result := InnerList.Add(aDrawCommand);
end;

function TppDrawCommandCollection.GetItems(Index: Integer): TppDrawCommand;
begin
  Result := TppDrawCommand(InnerList[Index]);
end;

function TppDrawCommandCollection.Remove(aDrawCommand: TppDrawCommand): Integer;
begin
  Result := InnerList.Remove(aDrawCommand);
end;




{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppPage, TppPageRequest]);
  raRegisterRTTI(TraTppDrawCommandRTTI);
  raRegisterRTTI(TraTppPageRTTI);

finalization

  UnRegisterClasses([TppPage, TppPageRequest]);
  raUnRegisterRTTI(TraTppDrawCommandRTTI);
  raUnRegisterRTTI(TraTppPageRTTI);

  FDeviceClassList.Free;
  FDeviceClassList := nil;

end.
