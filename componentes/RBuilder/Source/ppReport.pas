{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppReport;

interface

{$I ppIfDef.pas}

uses
   Windows, Messages, Classes, Controls, Forms, ExtCtrls, Menus, Graphics,
   Printers, Dialogs, SysUtils, StdCtrls, TypInfo,                                                                    
   ppComm, ppDevice, ppRuler, ppTypes, ppUtils, ppPrintr, ppDB, ppTmplat,
   ppCache, ppClass, ppForms, ppProd, ppBands, ppRelatv,
   ppRTTI,  ppASDlg, ppASField, ppOutlineReportSettings,  ppOutline,
   ppOutlineNode, ppOutlineSettings, ppOutlineParticipant,
   ppOutlineReportNodeCreator,
   ppParameter;

type


  {@TppBandedReport

    TppBandedReport introduces properties that provide convenient access to
    a TppCustomReport's bands. This enables band references to be coded as
    Report.Header, Report.Detail, Report.Footer, etc.}

  {@TppBandedReport.ColumnFooter

    Returns the column footer band, if one exists within the report layout.}

  {@TppBandedReport.ColumnHeader

    Returns the column header band, if one exists within the report layout.}

  {@TppBandedReport.Detail

    Returns the detail band for the given report.}

  {@TppBandedReport.Footer

    Returns the footer band, if one exists within the report layout.}

  {@TppBandedReport.GroupFooter

    Returns the group footer band, as indicated by the Index parameter.
    Groups are numbered from the outermost group to the innermost group,
    starting with zero.  Thus, if you have three groups in a report, the
    innermost group would be accessed via an index of two.}

  {@TppBandedReport.GroupHeader

    Returns the group header band, as indicated by the Index parameter.
    Groups are numbered from the outermost group to the innermost group,
    starting with zero.  Thus, if you have three groups in a report, the
    innermost group would be accessed via an index of two.}

  {@TppBandedReport.Header

    Returns the header band, if one exists within the report layout.}

  {@TppBandedReport.Summary

    Returns the summary band, if one exists within the report layout.}

  {@TppBandedReport.Title

    Returns the title band, if one exists within the report layout.}

  TppBandedReport = class(TppCustomReport)
    private
      function  GetColumnHeader: TppColumnHeaderBand;
      function  GetColumnFooter: TppColumnFooterBand;
      function  GetTitle: TppTitleBand;
      function  GetHeader: TppHeaderBand;
      function  GetDetail: TppDetailBand;
      function  GetFooter: TppFooterBand;
      function  GetPageStyle: TppPageStyle;
      function  GetSummary: TppSummaryBand;
      function  GetGroupHeader(aIndex: Integer): TppGroupHeaderBand;
      function  GetGroupFooter(aIndex: Integer): TppGroupFooterBand;

    protected
      procedure InitializeReport; override;

    public
      function AddBand(aBandType: TppBandType; aIndex: Integer): TppBand;
      procedure ValidateBands; override;

      {backward compatibilty}
      property ColumnHeaderBand: TppColumnHeaderBand read GetColumnHeader;
      property ColumnFooterBand: TppColumnFooterBand read GetColumnFooter;
      property DetailBand: TppDetailBand read GetDetail;
      property FooterBand: TppFooterBand read GetFooter;
      property GroupHeaderBand[Index: Integer]: TppGroupHeaderBand  read GetGroupHeader;
      property GroupFooterBand[Index: Integer]: TppGroupFooterBand  read GetGroupFooter;
      property HeaderBand: TppHeaderBand read GetHeader;
      property SummaryBand: TppSummaryBand read GetSummary;
      property TitleBand: TppTitleBand read GetTitle;

      property ColumnHeader: TppColumnHeaderBand read GetColumnHeader;
      property ColumnFooter: TppColumnFooterBand read GetColumnFooter;
      property Detail: TppDetailBand read GetDetail;
      property Footer: TppFooterBand read GetFooter;
      property GroupHeader[Index: Integer]: TppGroupHeaderBand  read GetGroupHeader;
      property GroupFooter[Index: Integer]: TppGroupFooterBand  read GetGroupFooter;
      property Header: TppHeaderBand read GetHeader;
      property PageStyle: TppPageStyle read GetPageStyle;
      property Summary: TppSummaryBand read GetSummary;
      property Title: TppTitleBand read GetTitle;

  end; {class, TppBandedReport}


  {@TppReport

   The report component contains the definition of your report. You create this
   definition by dropping a TppReport component on a form and double-clicking
   it. This will display the Report Designer where you can design a report
   template. The Template property can be used to save and load report
   definitions from files or from a database. (See TppTemplate for more on
   saving report definitions.)

   Use the PrinterSetup properties to specify the printer, paper size and
   orientation for your report

   To print the report to the screen or to the printer, set the Device property
   and then call the Print method. When a report is printed to the screen, the
   built-in Print Preview Form appears, allowing you to view any page of the
   report.

   To print to an ASCII text file, access the Print to File Setup dialog from
   the Report Designer's main menu and select the bands and text-based '
   components which should exported to file.  Select the file name and file
   format.  Select the report component in the Object Inspector and set
   AllowPrintToFile to True.  You can then print the report to an ASCII text
   file at either run-time or design-time.

   To print to an Report Emulation text file, simply set AllowPrintToFile to
   true, and select the device when the Print Dialog is displayed.

   To make the Report component the currently selected component in the Object
   Inspector, click in the rectangular area to the left of the horizontal
   rulers in the Report Designer.}

  {@TppReport.AfterAutoSearchDialogCreate

    This event fires after the AutoSearchDialog has been created, but before it
    has been configured to reflect the AutoSearchFields.  Changes made to the
    AutoSearchFields from this event will be reflected in the dialog.}

  {@TppReport.AutoSearchDialog

    When the ShowAutoSearchDialog property is set to True and the
    AutoSearchFields property has been populated with TppAutoSearchField
    components, the AutoSearchDialog is displayed.  The contents of the
    AutoSearchDialog are dynamically created based on the fields in the
    AutoSearchFields property.

    Pictured below is the AutoSearch dialog.

    <IMAGE AutoSearchDialog>


    In this example, the Report.AutoSearchFields property contains two fields:
    Company and Zip Code.  The SearchOperator of the Company field has been set
    to 'Like' and the SearchOperator of the ZipCode field has been set to
    'InList'.  Once search criteria have been entered and the AutoSearch dialog
    has been closed, the criteria values can be retrieved from the
    AutoSearchField components.  This is usually done in the
    OnAutoSearchDialogClose event.

    In ReportBuilder Professional and Enterprise, the AutoSearch dialog is used
    to support the AutoSearch feature of query-based dataviews.  Thus,
    AutoSearch is a built-in capability when using DADE.  However, the
    AutoSearch dialog is not bound to DADE in any way, and can be used with the
    standard version of ReportBuilder.  For an example of how to use the
    AutoSearch dialog with the standard version of ReportBuilder, see the
    example projects in the ...RBuilder\\Demos\\AutoSearch directory.

    If you wish to customize the behavior of the AutoSearch dialog, you can do
    so by replacing it with your own custom descendant.  For an example of how
    to do this, see the example in ...RBuilder\\Demos\\5. AutoSearch\\4. Custom
    AutoSearch Dialog.}

  {@TppReport.AutoSearchFieldCount

    Run-time and read only.  The AutoSearchFieldCount property returns the
    number of AutoSearch fields in the report.}

  {@TppReport.AutoSearchFields

    When ShowAutoSearchDialog is True, the AutoSearchFields are used to
    configure the AutoSearchDialog and to store the results of the search
    criteria entered into this dialog. In ReportBuilder Professional and
    Enterprise, query-based dataviews in the data workspace utilize this
    capability to provide a built-in way for developers and end users to specify
    search criteria to be displayed before a report is generated.

    When ShowAutoSearchDialog is False, you can use AutoSearchFields to manually
    assign the search criteria values to be used by the report.  In this
    scenario, the values are assigned before calling the Report.Print method.
    If you have used the data workspace in ReportBuilder to create the
    AutoSearchFields, then the search criteria values will automatically be used
    by the query-based dataview.  If you are using ReportBuilder, then it is up
    to you to assign the search criteria values to the actual data access
    components being used by the report.  This can be done in the
    OnGetAutoSearchValues, an event which fires whenever AutoSearchFields exist,
    regardless of whether the AutoSearchDialog was displayed.

    For instance, let's say you want to display the AutoSearchDialog for one
    user, but for another you want hide the dialog and need to assign the search
    criteria values 'under the covers'.  In order to do this, first create an
    OnGetAutoSearchValues event handler. This event handler should assign the
    search criteria values from the AutoSearchFields to the appropriate data
    access components for the report. Next, code an event handler that will
    create the AutoSearchFields. You can use either the OnCreate event of the
    form containing the report or simply place the code before the call to the
    Print method.  This event handler should create the AutoSearchField
    components (the easiest way to do this is to call the
    Report.CreateAutoSearchField method).

    Once you have completed these steps, you have an implementation that can
    work two ways depending on the value of the ShowAutoSearchDialog property.
    If you set ShowAutoSearchDialog to True, the dialog will be displayed when
    the Report.Print method is called and the values entered into the dialog
    will then be assigned to the appropriate data access components via the
    OnGetAutoSearchValues event handler.  If you set ShowAutoSearchDialog
    to False, manually set the AutoSearchField values in code and then call
    Print, then the dialog will not be displayed, but the values will still be
    transferred to the data access components via OnGetAutoSearchValues.  This
    allows you to write one procedure for transferring the AutoSearchField
    values to the data access components, while providing for multiple sources
    for the actual search criteria values.

    For an example of how to use the AutoSearch dialog, see the example projects
    in the...RBuilder\\Demos\\AutoSearch directory.}

  {@TppReport.BeforeAutoSearchDialogCreate

    This event fires before the AutoSearchDialog has been created.  If
    ShowAutoSearchDialog is set to False in this event, the dialog is not
    created or displayed.}

  {@TppReport.CachePages

    Defaults to False. When you call the Print or PrintToDevices methods to run
    a report, the report engine generates pages in the form of TppPage objects.
    Normally only one page object exists at any given time (i.e. the page which
    has just been generated).  This page is passed to each of the connected
    devices and is then overwritten when the next page is generated.  In certain
    situations it is useful to save the page objects as they are generated
    so that subsequent requests by the devices for the page can be provided
    without requesting the page from the report engine.  Setting CachePages to
    True will cause all pages generated by the report engine to be saved.  This
    is useful for reports that traverse a great deal of data in order to
    generate a single page of the report.  If CachePages is set to True and the
    report is sent to the Print Preview form, the engine will not reaccess the
    database and regenerate the pages if the report is subsequently sent to the
    printer.

    While CachePages can be great for data intensive reports, it comes at a
    price. Depending on the number of objects on the pages or the number of
    pages in the report, page caching can take up a great deal of memory. It is
    therefore recommended that this capability be used only when necessary and
    with due regard for the resources that may be required.}

  {@TppReport.OnAutoSearchDialogClose

    This event fires after the AutoSearchDialog has been closed.}

  {@TppReport.OnGetAutoSearchValues

    This event fires whenever the report is generated via a call to the Print
    method and AutoSearchFields exist.  The event fires regardless of the state
    of the ShowAutoSearchDialog property.  This event is usually used to
    transfer search criteria values to data access components when you are
    taking manual control over the AutoSearchFields.  For a further discussion
    of how and when to manually control AutoSearch fields, see AutoSearchFields.

    Note:  If ShowAutoSearchDialog is True and the AutoSearch dialog has been
    displayed, but the user clicked 'Cancel' to exit the dialog, then this event
    will not fire.}

  {@TppReport.OnInitializeParameters

    This event fires whenever a report is generated via a call to the Print method.
    This event occurs prior to the AutoSearch events. Use this event to

      - Define Report.Parameters[] and Report.AutoSearchFields[]
      - Set Parameter and AutoSearchField values.
      - Display a custom dialog that enables a user to enter parameter values. This
        is useful when not using the built-in AutoSearch feature.
      - Generate custom SQL that adds autosearch criteria.

    Set the Cancel parameter to True to cancel the report generation process.}

  {@TppReport.BeforeOpenDataPipelines

    This event fires prior to the report engine opening the datapipelines
    associated with the report, child reports, and data-aware controls. Use
    this event to

      - apply custom parameter values to SQL
      - generate custom SQL
   }

  {@TppReport.AfterOpenDataPipelines

    This event fires after the report engine opens all of the datapipelines
    associated with the report, child reports, and data-aware controls.
   }

  {@TppReport.OnOutlineNodeCreate

    This event fires whenever an outline node is created during the report
    generation process. When enabled, an outline tree structure is
    dynamically generated by the report engine and rendered
    by the report previewer.

    The OutlineSettings property is used to control the behavior of report outline
    generation. The OnOutlineNodeCreate event can be used to further customize
    the outline as it is being generated.

    The aNode parameter is the node being created. Set the aNode.Caption
    property to modify the default caption assigned to the node.

    The aAccept parameter defaults to True. Set aAccept to False to prevent the
    node from being included in the report.}

  {@TppReport.OutlineSettings

    Controls the behavior of report outline generation. When enabled, an outline
    tree structure is dynamically generated by the report engine and rendered
    by the report previewer.

    From the report designer, select the Report|Outline Settings... menu
    option to access a dialog that enables simple visual configuration of
    outline settings for all relevant objects in the report.

    Use the Enabled property to control whether an outline is created. Use the
    CreateNode boolean property to control whether a node is created for the
    report object. Use the CreatePageNodes boolean property to control whether
    nodes are created for each page in the report.

    OutlineSettings can also be configured for TppGroup objects
    and for TppSubReport objects that have a PrintBehavior of pbSection.

    The OnOutlineNodeCreate event can be used to further customize
    the outline as it is being generated.}

   {@TppReport.Parameters

    Use the Parameters property to manage a list of custom parameters that
    can be saved as part of the report definition.

    In a standard reporting application, parameters can be used to to facilitate
    any type of custom processing. In a report server application, Parameters
    can be sent between the client and the report server.

    At design-time, you can access the Parameters Editor via the TppReport
    component's context menu or via the object inspector (see ParametersEditor).

    At run-time, use the methods of TppParameterList to programmtically access
    the custom parameter items. The Delphi code syntax for accessing a parameter
    value is

       myReport.Parameters['ParameterName'].Value

    RAP code supports the above syntax, plus the following shorthand syntax

       myReport.Parameters['ParameterName']}

   {@TppReport.ParametersEditor

    Provides design-time access to the Parameters Editor.

    At design-time, you can access the Parameters Editor by selecting the report
    in the Delphi object inspector and then clicking on the button that appears
    next to the ParametersEditor property.}

  TppReport = class(TppBandedReport, IppOutlineParticipant, IppAutosearchFields)
    private
      FActiveReport: TppCustomReport;
      FAutoSearchDialog: TppCustomAutoSearchDialog;
      FAutoSearchFields: TList;
      FCacheManager: TppCacheManager;
      FCachePages: Boolean;
      FOutline: TppOutline;
      FOutlineChildren: TList;
      FOnOutlineNodeCreate: TppOutlineNodeCreateEvent;
      FOutlineSettings: TppOutlineReportSettings;
      FPrintCalled: Boolean;
      FParameters: TppParameterList;
      FParametersEditor: String;

      {events}
      FAfterAutoSearchDialogCreate: TNotifyEvent;
      FAfterOpenDataPipelines: TNotifyEvent;
      FAvailableDataPipelines: TppDataPipelineList;
      FBeforeAutoSearchDialogCreate: TNotifyEvent;
      FBeforeOpenDataPipelines: TNotifyEvent;
      FOnLoadTemplate: TNotifyEvent;
      FOnAutoSearchDialogClose: TNotifyEvent;
      FOnGetAutoSearchValues: TNotifyEvent;
      FOnInitializeParameters: TppReportInitializeEvent;

      {used for conversion to 3.0}
      FDataSource: String;
      FRowSpacing: Single;
      FOldOrientation: TPrinterOrientation;
      FOnPrintingComplete: String;

      function ShowAutoSearchDialogBeforePrinting: Boolean;

      function  GetAutoSearchField(aIndex: Integer): TppAutoSearchField;
      function  GetAutoSearchFieldCount: Integer;
      function  GetAutoSearchDescriptionAsString: String;
      function  GetOutline: TppOutline;

      procedure CloseSubReportDataPipelines;
      procedure ResetSubReports;
      procedure SetCachePages(Value: Boolean);
      procedure TakeSubReportAction(aAction: TppSubReportActionType);

      {cache manager related routines}
      procedure GetLastPageCached(Sender: TObject; var aPageNo: Longint);
      procedure ResetCache(Sender: TObject);
      procedure ReadCache(Sender: TObject);
      procedure WriteCache(Sender: TObject);

      {used for conversion to 3.0}
      procedure ReadAllowPrintCancel(Reader: TReader);
      procedure ReadDataSource(Reader: TReader);
      procedure ReadOnPrintingComplete(Reader: TReader);
      procedure ReadOrientation(Reader: TReader);
      procedure ReadNoDataPages(Reader: TReader);
      procedure ReadPreviewPages(Reader: TReader);
      procedure ReadRowSpacing(Reader: TReader);
      procedure ReadSuppressFormFeed(Reader: TReader);
      procedure ReadViewer(Reader: TReader);

      procedure ReadOnAutoSearchDialogCreate(Reader: TReader);
      procedure SetOutlineSettings(aOutlineSettings: TppOutlineReportSettings);

      function CreateParameterList: TppParameterList;
      function GetParameters: TppParameterList;
      procedure SetParameters(aParameters: TppParameterList);

    protected
      {defines 'fake' properties}
      procedure DefineProperties(Filer: TFiler); override; {contains temporary conversion routine}

      procedure DoOnLoadTemplate(aReport: TppCustomReport); override;
      function  GetCaption: String; override;
      function  GetMainReport: TppCustomReport; override;
      procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
      procedure SetLanguage(aLanguageType: TppLanguageType); override;
      procedure SetLanguageID(aLanguageID: String); override;

      procedure AutoSearchDialogCloseEvent(Sender: TObject); virtual;
      procedure DoAfterOpenDataPipelines; virtual;
      procedure DoBeforeOpenDataPipelines; virtual;
      procedure DoAfterAutoSearchDialogCreate; virtual;
      procedure DoBeforeAutoSearchDialogCreate; virtual;
      procedure DoOnAutoSearchDialogClose; virtual;
      procedure DoOnGetAutoSearchValues; virtual;

      procedure OutlineNodeCreateEvent(Sender: TObject; aNode: TppOutlineNode; var aAccept: Boolean);
      procedure CreateOutline;
      function CreatePrintDialog: TppCustomPrintDialog; override;
      procedure DoParamValueChanged(Sender: TppCommunicator); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;

      procedure Cancel; override;
      procedure CloseDataPipelines;
      procedure CollapseDrillDowns;
      procedure Convert(aVersionNo: Integer); override;
      procedure ESExclude(aEngineStateSet: TppEngineStates); override;
      procedure ESInclude(aEngineStateSet: TppEngineStates); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure ExpandDrillDowns;
      function  GetPrintMessage: String; override;
      procedure GetReportKey(var aKey: String); override;
      function  HasEmailGroups: Boolean; override;
      function  InitializeParameters: Boolean; virtual;
      function  IsCached: Boolean;
      procedure Loaded; override;
      procedure PrintToDevices; override;
      function  PrintDateTime: TDateTime;
      procedure Print; override;
      procedure PageSent(Sender: TObject); override;
      procedure RequestPage(Sender: TObject; aPageRequest: TObject); override;
      procedure Reset; override;
      procedure ResetFromPageNo(aAbsolutePageNo: Longint);
      procedure SetPrintMessage(const aMessage: String); override;
      procedure StartOfMainReport; override;
      procedure Transfer(aSource: TppCommunicator); override;


      {backward compatibility}
      procedure PrintReport;
      procedure PrintPage(aPageNo: Integer);
      procedure PrintPageList(aPageList: TStrings);

      {overridden from communicator}
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      {overridden from relative}
      procedure AddChild(aChild: TppRelative); override;
      function  AutoSearchFieldByName(const aName: String): TppAutoSearchField;
      function  AutoSearchCriteriaByName(const aDataPipelineName, aFieldName: String): TppAutoSearchField;
      procedure ChangeOwner(aNewOwner: TComponent); override;
      function  CreateAutoSearchField(const aTableName, aFieldName, aFieldAlias: String; aDataType: TppDataType; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
      function  CreateAutoSearchCriteria(const aDataPipelineName, aFieldName: String; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
      function  DisplayAutoSearchDialog: Boolean; override;
      procedure FreeAutoSearchFields;
      function  HasParent: Boolean; override;
      procedure InsertChild(aPosition: Integer; aChild: TppRelative); override;
      function  IndexOfChild(aChild: TppRelative): Integer; override;
      procedure MoveChild(aChild: TppRelative; aCurrentIndex, aNewIndex: Integer);
      function  RemoveChild(aChild: TppRelative): Integer; override;
      procedure GenerateOutlineDrawCommand;
      procedure GetAutoSearchDescriptionLines(aLines: TStrings);
      function  GetDataPipeline(aUserName: String): TppDataPipeline;

      {IppOutlineParticipant}
      function iOutlineGetChildren: TList;
      function iOutlineGetParent: TppCommunicator;
      function iOutlineNodeCreatorClass: TComponentClass;
      function iOutlineSettings: TppOutlineSettings;
      procedure iOutlineSettingsChanged;

      {IppAutosearchFields}
      function iAutoSearchFieldCount: Integer;
      function iAutosearchFieldForIndex(aIndex: Integer): TppAutosearchField;
      function iCreateAutoSearchCriteria(const aDataPipelineName, aFieldName: String; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
      function iCreateAutoSearchField(const aTableName, aFieldName, aFieldAlias: String; aDataType: TppDataType; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
      procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); overload; override;

      property ActiveReport: TppCustomReport read FActiveReport write FActiveReport;
      property CacheManager: TppCacheManager read FCacheManager;
      property CancelDialog;
      property PreviewForm;

      property OnLoadTemplate: TNotifyEvent read FOnLoadTemplate write FOnLoadTemplate;

      property AutoSearchDescription: String read GetAutoSearchDescriptionAsString;
      property AutoSearchFields[Index: Integer]: TppAutoSearchField read GetAutoSearchField;
      property AutoSearchFieldCount: Integer read GetAutoSearchFieldCount;
      property AutoSearchDialog: TppCustomAutoSearchDialog read FAutoSearchDialog;
      property Outline: TppOutline read GetOutline;
      property Language;
      property Parameters: TppParameterList read GetParameters write SetParameters;

      {used for conversion to 3.0}
      property DataSource: String read FDataSource;
      property RowSpacing: Single read FRowSpacing;

    published
      property AfterAutoSearchDialogCreate: TNotifyEvent read FAfterAutoSearchDialogCreate write FAfterAutoSearchDialogCreate;
      property AfterOpenDataPipelines: TNotifyEvent read FAfterOpenDataPipelines write FAfterOpenDataPipelines;
      property AfterPrint;
      property AfterEmail;
      property AllowPrintToArchive;
      property AllowPrintToFile;
      property ArchiveFileName;
      property BackgroundPrintSettings;
      property BeforeAutoSearchDialogCreate: TNotifyEvent read FBeforeAutoSearchDialogCreate write FBeforeAutoSearchDialogCreate;
      property BeforeOpenDataPipelines: TNotifyEvent read FBeforeOpenDataPipelines write FBeforeOpenDataPipelines;
      property BeforePrint;
      property BeforeEmail;
      property CachePages: Boolean read FCachePages write SetCachePages default False;
      property DeviceType;
      property DefaultFileDeviceType;
      property EmailSettings;
      property Icon;
      property LanguageID;
      property ModalCancelDialog;
      property ModalPreview;
      property OnAutoSearchDialogClose: TNotifyEvent read FOnAutoSearchDialogClose write FOnAutoSearchDialogClose;
      property OnCancel;
      property OnCancelDialogClose;
      property OnCancelDialogCreate;
      property OnGetAutoSearchValues: TNotifyEvent read FOnGetAutoSearchValues write FOnGetAutoSearchValues;
      property OnOutlineNodeCreate: TppOutlineNodeCreateEvent read FOnOutlineNodeCreate write FOnOutlineNodeCreate;
      property OnPageRequest;
      property OnAssignPreviewFormSettings;
      property OnInitializeParameters: TppReportInitializeEvent read FOnInitializeParameters write FOnInitializeParameters;
      property OnPreviewFormClose;
      property OnPreviewFormCreate;
      property OnPrintingComplete;
      property OnPrintDialogClose;
      property OnPrintDialogCreate;
      property OutlineSettings: TppOutlineReportSettings read FOutlineSettings write SetOutlineSettings;
      property ParametersEditor: String read FParametersEditor write FParametersEditor stored False;
      property PDFSettings;
      property PreviewFormSettings;
      property RTFSettings;
      property SavePrinterSetup;
      property ShowAutoSearchDialog;
      property ShowCancelDialog;
      property ShowPrintDialog;
      property TextFileName;
      property TextFileType;
      property TextSearchSettings;
      property XLSSettings;

  end; {class, TppReport}


  {@TppChildReport

    This type of report is contained inside the TppSubReport component. The
    main difference between a child report and standard report is the
    printing behavior. The child report generates when the subreport
    component generates. The child report does not contain a cache manager
    or publisher object, but relies on the subreport component to handle
    the communications which these objects normally provide.}

  TppChildReport = class(TppBandedReport)
    private
      FResetting: Boolean;

      procedure CheckParentPrinterSetup;

    protected
      function  GetCaption: String; override;
      function  GetMainReport: TppCustomReport; override;
      procedure PrinterSetupChanged; override;
      procedure SetModified(Value: Boolean); override;
      procedure SetParent(aParent: TppRelative); override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure Cancel; override;
      function  GetPrintMessage: String; override;
      procedure GetReportKey(var aKey: String); override;
      function  GetUniqueUserName(aComponent: TComponent): String; override;
      procedure ESExclude(aEngineStateSet: TppEngineStates); override;
      procedure ESInclude(aEngineStateSet: TppEngineStates); override;
      procedure ProcessMessages; override;
      procedure Reset; override;
      procedure SetPrintMessage(const aMessage: String); override;
      procedure Transfer(aSource: TppCommunicator); override;

  end; {class, TppChildReport}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppBandedReportRTTI }
  TraTppBandedReportRTTI = class(TraTppCustomReportRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppBandedReportRTTI}

  {@TraTppReportRTTI }
  TraTppReportRTTI = class(TraTppBandedReportRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppReportRTTI}

implementation

uses ppEngine, ppCtrls, ppViewr, ppSubRpt,
     ppPrvDlg, ppPDlg, ppCDlg, ppRegion, ppPrnDev, ppFilDev, ppDsIntf, ppClasUt;

{******************************************************************************
 *
 ** B A N D E D   R E P O R T
 *
{******************************************************************************}
const

  {TppBandType = (btHeader,  btTitle, btColumnHeader, btGroupHeader, btDetail,
                 btGroupFooter, btColumnFooter, btSummary, btFooter, btPageStyle, btNotKnown); }

  cBandTypeClassMap: array[TppBandType] of TppBandClass =
                 (TppHeaderBand, TppTitleBand, TppColumnHeaderBand, TppGroupHeaderBand, TppDetailBand,
                  TppGroupFooterBand, TppColumnFooterBand, TppSummaryBand, TppFooterBand, TppPageStyle, nil);

{------------------------------------------------------------------------------}
{ TppBandedReport.AddBand}

function TppBandedReport.AddBand(aBandType: TppBandType; aIndex: Integer): TppBand;
begin
  Result := nil;

  if (GetBand(aBandType, aIndex) = nil) then
    begin
      Result := TppBand(ppComponentCreate(Self, cBandTypeClassMap[aBandType]));

      if Result.InheritsFrom(TppGroupBand) then
        TppGroupBand(Result).Group := Groups[aIndex]
      else
        Result.Report := Self;
    end;

end; {function, AddBand}

{------------------------------------------------------------------------------}
{ TppBandedReport.InitializeReport }

procedure TppBandedReport.InitializeReport;
begin
  ValidateBands;

  inherited InitializeReport;

end; {procedure, InitializeReport}


{------------------------------------------------------------------------------}
{ TppBandedReport.ValidateBands}

procedure TppBandedReport.ValidateBands;
var
  liIndex: Integer;
begin
  if BandCount = 0 then
    CreateDefaultBands;

  {must have a detail band}
  if (GetDetail = nil) then
    AddBand(btDetail, 0);

  {each group must have a group header and group footer}
  for liIndex := 0 to GroupCount-1 do
    begin
      if (GetGroupHeader(liIndex) = nil) then
        AddBand(btGroupHeader, liIndex);

      if (GetGroupFooter(liIndex) = nil) then
        AddBand(btGroupFooter, liIndex);

    end;

end; {procedure, ValidateBands}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetColumnHeader }

function TppBandedReport.GetColumnHeader: TppColumnHeaderBand;
begin
  Result := TppColumnHeaderBand(GetBand(btColumnHeader, 0));
end; {function, GetColumnHeader}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetColumnFooter }

function TppBandedReport.GetColumnFooter: TppColumnFooterBand;
begin
  Result := TppColumnFooterBand(GetBand(btColumnFooter, 0));
end; {function, GetColumnFooter}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetTitle }

function TppBandedReport.GetTitle: TppTitleBand;
begin
  Result := TppTitleBand(GetBand(btTitle, 0));
end; {function, GetTitle}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetHeader }

function TppBandedReport.GetHeader: TppHeaderBand;
begin
  Result := TppHeaderBand(GetBand(btHeader, 0));
end; {function, GetHeader}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetDetail }

function TppBandedReport.GetDetail: TppDetailBand;
begin
  Result := TppDetailBand(GetBand(btDetail, 0));

  {detail band is never nil}
  if (Result = nil) then
    Result := TppDetailBand(AddBand(btDetail, 0));

end; {function, GetDetail}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetFooter }

function TppBandedReport.GetFooter: TppFooterBand;
begin
  Result := TppFooterBand(GetBand(btFooter, 0));
end; {function, GetFooter}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetSummary }

function TppBandedReport.GetSummary: TppSummaryBand;
begin
  Result := TppSummaryBand(GetBand(btSummary, 0));
end; {function, GetSummary}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetGroupHeader }

function TppBandedReport.GetGroupHeader(aIndex: Integer): TppGroupHeaderBand;
begin
  Result := TppGroupHeaderBand(GetBand(btGroupHeader, aIndex));
end; {function, GetGroupHeader}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetGroupFooter }

function TppBandedReport.GetGroupFooter(aIndex: Integer): TppGroupFooterBand;
begin
  Result := TppGroupFooterBand(GetBand(btGroupFooter, aIndex));
end; {function, GetGroupFooter}

{------------------------------------------------------------------------------}
{ TppBandedReport.GetPageStyle }

function TppBandedReport.GetPageStyle: TppPageStyle;
begin
  Result := TppPageStyle(GetBand(btPageStyle, 0));
end; {function, GetPageStyle}



{******************************************************************************
 *
 ** R E P O R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReport.Create }

constructor TppReport.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FActiveReport := nil;
  FAfterAutoSearchDialogCreate := nil;
  FAutoSearchDialog := nil;
  FAutoSearchFields := TList.Create;
  FBeforeAutoSearchDialogCreate := nil;
  FCacheManager := TppCacheManager.Create(Self);
  FCachePages := False;
  FOnLoadTemplate := nil;
  FOnAutoSearchDialogClose := nil;

  FOnGetAutoSearchValues := nil;
  FPrintCalled := False;
  FOnOutlineNodeCreate := nil;
  FOutlineChildren := nil;
  FOutlineSettings := TppOutlineReportSettings.Create(Self);

  {assign cache manager routines to engine}
  if (Engine <> nil) then
    begin
      Engine.OnResetCache := ResetCache;
      Engine.OnReadCache := ReadCache;
      Engine.OnWriteCache := WriteCache;
      Engine.OnGetLastPageCached := GetLastPageCached;
      Engine.AddEventNotify(Self);
      EventNotifies := EventNotifies + [ciReportBeforeOpenDataPipelines, ciReportAfterOpenDataPipelines, ciParamValueChange]
    end;

  FParameters := nil;

end; {constructor, TppReport}

{------------------------------------------------------------------------------}
{ TppReport.Destroy }

destructor TppReport.Destroy;
begin

  TriggerCodeModuleDestroy; 

  FreeAutoSearchFields;

  FAutoSearchFields.Free;
  FAutoSearchFields := nil;

 { showMessage('TppReport.Destroy - begin');}

 {showMessage('free cache manager');}
  {free cache manager before all others}
  FCacheManager.Free;
  FOutlineSettings.Free;

  if (FOutlineChildren <> nil) then
    FOutlineChildren.Free;

  FParameters.Free;

  FAvailableDataPipelines.Free;
  FAvailableDataPipelines := nil;

  inherited Destroy;
 {showMessage('TppReport.Destroy - end');}

end; {destructor, Destroy}


{@TppReport.FreeAutoSearchFields
 Frees all of the AutoSearchField components.}

procedure TppReport.FreeAutoSearchFields;
var
  liIndex: Integer;
begin
  if FAutoSearchFields = nil then Exit;

  for liIndex := FAutoSearchFields.Count - 1 downto 0 do
    TppRelative(FAutoSearchFields[liIndex]).Free;

  FAutoSearchFields.Clear;

end; {procedure, FreeAutoSearchFields}

{------------------------------------------------------------------------------}
{ TppReport.EventNotify }

procedure TppReport.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  {this code enables an external entity, such as the report server,
   to trigger auto search events}
  case aEventID of
    ciReportBeforeAutoSearchDialogCreate: DoBeforeAutoSearchDialogCreate;
    ciReportGetAutoSearchValues: DoOnGetAutoSearchValues;
  end;

  // engine events
  if (aCommunicator = Engine) then
    case aEventID of
       ciReportBeforeOpenDataPipelines: DoBeforeOpenDataPipelines;
       ciReportAfterOpenDataPipelines: DoAfterOpenDataPipelines;
    end
  else if (aCommunicator is TppParameter) and (aEventID = ciParamValueChange) then
    DoParamValueChanged(aCommunicator);
       

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppReport.Convert }

procedure TppReport.Convert(aVersionNo: Integer);
begin

  inherited Convert(aVersionNo);
  
  {move orientation to printersetup.orientation}
  if (aVersionNo < 1270) then
    PrinterSetup.Orientation := FOldOrientation;

  {turn off outline for old reports}
  if (aVersionNo < 6100) then
    OutlineSettings.Enabled := False;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppReport.ChangeOwner }

procedure TppReport.ChangeOwner(aNewOwner: TComponent);
begin

  if (aNewOwner = Owner) then Exit;

  inherited ChangeOwner(aNewOwner);

  if (FParameters <> nil) then
    FParameters.ChangeOwner(aNewOwner);

end;

{------------------------------------------------------------------------------}
{ TppReport.GetCaption }

function TppReport.GetCaption: String;
begin
  {default caption is 'main'}
  Result := ppLoadStr(374);

  if (DataPipeline = nil) then
    Result := Result + ': ' + ppLoadStr(1134) {'No Data Pipeline assigned.'}
  else
    Result := Result + ': ' + DataPipeline.UserName;

end; {function, GetCaption }

{------------------------------------------------------------------------------}
{ TppReport.GetPrintMessage }

function TppReport.GetPrintMessage: String;
begin

  if (Publisher <> nil) then
    Result := Publisher.GetPrintMessage
  else
    Result := '';

end; {function, GetPrintMessage }

{------------------------------------------------------------------------------}
{ TppReport.SetPrintMessage }

procedure TppReport.SetPrintMessage(const aMessage: String);
begin
  if (Publisher <> nil) then
    Publisher.SetPrintMessage(aMessage);
end; {function, SetPrintMessage }

{------------------------------------------------------------------------------}
{ TppReport.CloseDataPipelines }

procedure TppReport.CloseDataPipelines;
begin
  if Printing then Exit;
  
  Engine.CloseDataPipelines;

  CloseSubReportDataPipelines;
end; {procedure, CloseDataPipelines}


{@TppReport.Print }

procedure TppReport.Print;
begin

  if not InitializeParameters then Exit;

  if (ShowAutoSearchDialogBeforePrinting) then
    inherited Print;

end;

{@TppReport.InitializeParameters }

function TppReport.InitializeParameters: Boolean;
var
  lbCancel: Boolean;
  lParams: TraParamList;
begin

  // create autosearch fields for parameters
  GetParameters.InitializeForReport(Self);

  ShowAutoSearchDialog := ShowAutoSearchDialog or (GetParameters.ContainsAutoSearch);

  TriggerCodeModuleCreate; // fire RAP global OnCreate


  lbCancel := False;

  if Assigned(FOnInitializeParameters) then FOnInitializeParameters(Self, lbCancel);

  lParams := TraTppReportRTTI.GetParams('OnInitializeParameters');
  lParams.CreateValuePointer(0, lbCancel);

  SendEventNotify(Self, ciReportInitializeParameters, lParams);

  lParams.Free;

  Result := not lbCancel;

end;

{@TppReport.ShowAutoSearchDialogBeforePrinting }

function TppReport.ShowAutoSearchDialogBeforePrinting: Boolean;
begin

  FPrintCalled := True;

  Result := DisplayAutoSearchDialog;

  if (Result) then
    begin
      {4.21, add engine check so when report has already been previewed, printing to printer won't cause autosearch values to be reassigned.}
      if not(esInitialized in Engine.State) and (AutoSearchFieldCount > 0) then
        DoOnGetAutoSearchValues;
    end;

  if (FAutoSearchDialog <> nil) then
    begin
      FAutoSearchDialog.Free;
      FAutoSearchDialog := nil;
    end;

  FPrintCalled := False;

end;

{------------------------------------------------------------------------------}
{ TppReport.DisplayAutoSearchDialog }

function TppReport.DisplayAutoSearchDialog: Boolean;
var
  lFormClass: TFormClass;
begin

  Result := True;

  DoBeforeAutoSearchDialogCreate;

  if not ShowAutoSearchDialog then Exit;

  lFormClass := ppGetFormClass(TppCustomAutoSearchDialog);


  FAutoSearchDialog := TppCustomAutoSearchDialog(lFormClass.Create(Application));
  FAutoSearchDialog.Report := Self;
  FAutoSearchDialog.LanguageIndex := LanguageIndex;

  DoAfterAutoSearchDialogCreate;

  if (FAutoSearchFields.Count) = 0 then
    begin
      FAutoSearchDialog.Free;
      FAutoSearchDialog := nil;

      Exit;
    end;

  FAutoSearchDialog.AssignAutoSearchFields(FAutoSearchFields);
  FAutoSearchDialog.ppOnClose := AutoSearchDialogCloseEvent;

  FAutoSearchDialog.Init;

  if (FAutoSearchDialog.ShowModal <> mrOK) then
    Result := False;

  if (Result) then
    begin
      {call reset to re-initialize report, then call Engine.Reset to force
       the engine to re-inititalize}
      Reset;
      Engine.Reset;

      if not(FPrintCalled) then
        DoOnGetAutoSearchValues;
    end;

  {do this after triggering event}
  if not(FPrintCalled) then
    begin
      FAutoSearchDialog.Free;
      FAutoSearchDialog := nil;
    end;

end; {function, DisplayAutoSearchDialog}

{------------------------------------------------------------------------------}
{ TppReport.DoOnGetAutoSearchValues }

procedure TppReport.DoOnGetAutoSearchValues;
begin

  {let event handler modify values first}
  if Assigned(FOnGetAutoSearchValues) then FOnGetAutoSearchValues(Self);

  {then notify dataview}
  SendEventNotify(Self, ciReportGetAutoSearchValues, nil);

end; {procedure, DoOnGetAutoSearchValues}

{------------------------------------------------------------------------------}
{ TppReport.DoBeforeAutoSearchDialogCreate }

procedure TppReport.DoBeforeAutoSearchDialogCreate;
var
  liIndex: Integer;
begin

  if Assigned(FBeforeAutoSearchDialogCreate) then FBeforeAutoSearchDialogCreate(Self);

  SendEventNotify(Self, ciReportBeforeAutoSearchDialogCreate, nil);

  // allow autosearch fields initialize (i.e. build a pick list)
  for liIndex := 0 to FAutoSearchFields.Count - 1 do
    AutoSearchFields[liIndex].Initialize;

end; {procedure, DoBeforeAutoSearchDialogCreate}

{------------------------------------------------------------------------------}
{ TppReport.DoAfterAutoSearchDialogCreate }

procedure TppReport.DoAfterAutoSearchDialogCreate;
begin
  if Assigned(FAfterAutoSearchDialogCreate) then FAfterAutoSearchDialogCreate(Self);

  SendEventNotify(Self, ciReportAfterAutoSearchDialogCreate, nil);
end; {procedure, DoAfterAutoSearchDialogCreate}


{------------------------------------------------------------------------------}
{ TppReport.AutoSearchDialogCloseEvent }

procedure TppReport.AutoSearchDialogCloseEvent(Sender: TObject);
begin
  DoOnAutoSearchDialogClose;
end; {procedure, AutoSearchDialogCloseEvent}

{------------------------------------------------------------------------------}
{ TppReport.DoOnAutoSearchDialogClose }

procedure TppReport.DoOnAutoSearchDialogClose;
begin
  if Assigned(FOnAutoSearchDialogClose) then FOnAutoSearchDialogClose(Self);

  SendEventNotify(Self, ciReportAutoSearchDialogClose, nil);

end; {procedure, DoOnAutoSearchDialogClose}

{------------------------------------------------------------------------------}
{ TppReport.DoBeforeOpenDataPipelines }

procedure TppReport.DoBeforeOpenDataPipelines;
begin

  if Assigned(FBeforeOpenDataPipelines) then FBeforeOpenDataPipelines(Self);

  SendEventNotify(Self, ciReportBeforeOpenDataPipelines, nil);

end;

{------------------------------------------------------------------------------}
{ TppReport.DoAfterOpenDataPipelines }

procedure TppReport.DoAfterOpenDataPipelines;
begin

  if Assigned(FAfterOpenDataPipelines) then FAfterOpenDataPipelines(Self);

  SendEventNotify(Self, ciReportAfterOpenDataPipelines, nil);

end;

{------------------------------------------------------------------------------}
{ TppReport.HasParent }

function TppReport.HasParent: Boolean;
begin
  Result := False;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppReport.Notify }

procedure TppReport.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator is TppAutoSearchField) and (IndexOfChild(TppRelative(aCommunicator)) <> -1) then
    RemoveChild(TppRelative(aCommunicator));

  if (aCommunicator is TppParameterList) then
    FParameters := nil;    

end; {procedure, Notify}


{@TppReport.AutoSearchFieldByName
 Given the field name, returns the AutoSearch field with that name.  If a
 matching field is not found, nil is returned.}

function TppReport.AutoSearchFieldByName(const aName: String): TppAutoSearchField;
var
  liIndex: Integer;
  lAutoSearchField: TppAutoSearchField;
begin

  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < FAutoSearchFields.Count) do
    begin
      lAutoSearchField := AutoSearchFields[liIndex];

      if (CompareText(aName, lAutoSearchField.FieldName) = 0) then
        Result := lAutoSearchField;

      Inc(liIndex);
    end;

end; {procedure, AutoSearchFieldByName}


{@TppReport.AutoSearchCriteriaByName

 Given the data pipeline name and field name, returns the AutoSearch field with
 that name.  If a matching field is not found, nil is returned.
 This function is accessible via RAP and can be used to check whether or not an
 autosearch criteria has been created for a given field. The data pipeline name
 must be passed in order to differentiate between fields which may exist in
 separate dataviews. In order to create autosearch criteria from RAP, use
 CreateAutoSearchCriteria.}

function TppReport.AutoSearchCriteriaByName(const aDataPipelineName, aFieldName: String): TppAutoSearchField;
var
  liIndex: Integer;
  lAutoSearchField: TppAutoSearchField;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < FAutoSearchFields.Count) do
    begin
      lAutoSearchField := AutoSearchFields[liIndex];

      if (CompareText(aDataPipelineName, lAutoSearchField.DataPipelineName) = 0) and (CompareText(aFieldName, lAutoSearchField.FieldName) = 0) then
        Result := lAutoSearchField
      else
        Inc(liIndex);
    end;

end; {procedure, AutoSearchCriteriaByName}

{@TppReport.CreateAutoSearchCriteria

 Creates an AutoSearchField and a corresponding Search Criteria item in the DADE
 dataview.  Call this method when you want to add new criteria to a report
 created using the end-user reporting solution.  For an example of how to
 manipulate AutoSearchFields in the context of the end-user reporting solution,
 see the demo in ...RBuilder\\Demos\\AutoSearch\\7. Create End-User AutoSearch
 Fields.

 You can also call this function from the Global OnCreate event provided in the
 Calc workspace. AutoSearch criteria are automatically freed by the report, so
 you don't need to worry about freeing the criteria you create.  You should
 check to make sure that a given criteria has not already been added, though,
 otherwise the criteria will get added each time the AutoSearch dialog is
 displayed. You can check for existing criteria using AutoSearchCriteriaByName.}

function TppReport.CreateAutoSearchCriteria(const aDataPipelineName, aFieldName: String; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
var
  lParams: TraParamList;
begin

  Result := TppAutoSearchField.Create(Self);
  Result.Name := Result.GetValidName(Result);

  Result.DataPipelineName := aDataPipelineName;
  Result.FieldName := aFieldName;
  Result.SearchOperator := aOperator;
  Result.SearchExpression := aExpression;
  Result.Mandatory := aMandatory;

  Result.Parent := Self;

  {notify any attached dataview that field has been created}
  lParams := TraParamList.Create;
  lParams.AddParam('aAutoSearchField', daClass, TppAutoSearchField, '', False, False);
  lParams.CreateValuePointer(0, Result);

  SendEventNotify(Self, ciReportCreateAutoSearchCriteria, lParams);

  lParams.Free;
  
end; {procedure, CreateAutoSearchCriteria}


{@TppReport.CreateAutoSearchField
 Creates an AutoSearchField component and adds it to the AutoSearchFields array
 property.}

function TppReport.CreateAutoSearchField(const aTableName, aFieldName, aFieldAlias: String; aDataType: TppDataType;
                                         aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
begin

  Result := TppAutoSearchField.Create(Self);
  Result.Name := Result.GetValidName(Result);

  Result.TableName := aTableName;
  Result.FieldName := aFieldName;
  Result.FieldAlias := aFieldAlias;
  Result.DataType := aDataType;
  Result.SearchOperator := aOperator;
  Result.SearchExpression := aExpression;
  Result.Mandatory := aMandatory;

  Result.Parent := Self;

end; {procedure, CreateAutoSearchField}

{------------------------------------------------------------------------------}
{ TppReport.AddChild }

procedure TppReport.AddChild(aChild: TppRelative);
begin

  if (aChild is TppAutoSearchField) then
    begin
      aChild.AddNotify(Self);

      FAutoSearchFields.Add(aChild);

      Reset;
    end
  else if (aChild is TppParameterList) then
    begin
      FParameters.Free;
      FParameters := TppParameterList(aChild);
      FParameters.AddEventNotify(Self);
    end
  else
    inherited AddChild(aChild);

end; {procedure, AddChild}

{------------------------------------------------------------------------------}
{ TppReport.MoveChild }

procedure TppReport.MoveChild(aChild: TppRelative; aCurrentIndex, aNewIndex: Integer);
begin

  if (aChild is TppAutoSearchField) then
    begin
      FAutoSearchFields.Move(aCurrentIndex, aNewIndex);

      Reset;
    end;

end; {procedure, MoveChild}

{------------------------------------------------------------------------------}
{ TppReport.InsertChild }

procedure TppReport.InsertChild(aPosition: Integer; aChild: TppRelative);
begin

  if (aChild is TppAutoSearchField) then
    begin
      aChild.AddNotify(Self);

      FAutoSearchFields.Insert(aPosition, aChild);

      Reset;
    end
  else if (aChild is TppParameterList) then
    begin
      FParameters.Free;
      FParameters := TppParameterList(aChild);
      FParameters.AddEventNotify(Self);

    end
  else
    inherited InsertChild(aPosition, aChild);


end; {procedure, InsertChild}

{------------------------------------------------------------------------------}
{ TppReport.IndexOfChild }

function TppReport.IndexOfChild(aChild: TppRelative): Integer;
begin

  if (aChild is TppAutoSearchField) then
    Result := FAutoSearchFields.IndexOf(aChild)

  else if (aChild is TppParameterList) then
    Result := 0
  else
    Result := inherited IndexOfChild(aChild);

end; {procedure, IndexOfChild}

{------------------------------------------------------------------------------}
{ TppReport.RemoveChild }

function TppReport.RemoveChild(aChild: TppRelative): Integer;
var
  liIndex: Integer;
begin

  liIndex := IndexOfChild(aChild);

  Result := liIndex;

  if (liIndex = -1) then Exit;

  if (aChild is TppAutoSearchField) then
    begin
      aChild.RemoveNotify(Self);

      FAutoSearchFields.Delete(liIndex);

      Reset;
    end
  else if (aChild = FParameters) then
    begin
      FParameters.RemoveEventNotify(Self);
      FParameters := nil;
    end

  else
    Result := inherited RemoveChild(aChild);

end; {procedure, RemoveChild}

{------------------------------------------------------------------------------}
{ TppReport.GetAutoSearchField }

function  TppReport.GetAutoSearchField(aIndex: Integer): TppAutoSearchField;
begin
  if FAutoSearchFields <> nil then
    Result := TppAutoSearchField(FAutoSearchFields[aIndex])
  else
    Result := nil;

end; {procedure, GetAutoSearchField}

{------------------------------------------------------------------------------}
{ TppReport.GetAutoSearchFieldCount }

function  TppReport.GetAutoSearchFieldCount: Integer;
begin
  if FAutoSearchFields <> nil then
    Result := FAutoSearchFields.Count
  else
    Result := 0;

end; {procedure, GetAutoSearchFieldCount}

{------------------------------------------------------------------------------}
{ TppReport.GetAutoSearchDescriptionAsString }

function  TppReport.GetAutoSearchDescriptionAsString: String;
var
  lStringList: TStringList;
begin

  lStringList := TStringList.Create;

  try
    GetAutoSearchDescriptionLines(lStringList);

    Result := lStringList.Text;

  finally
    lStringList.Free;

  end;


end; {procedure, GetAutoSearchDescriptionAsString}

{@TppReport.GetAutoSearchDescriptionLines

  Retrieves the autosearch criteria descriptions in a TStrings object in order
  to display them in a report memo. Please reference the autosearch demos in
  the RBuilder installation for an example.}

procedure  TppReport.GetAutoSearchDescriptionLines(aLines: TStrings);
var
  liIndex: Integer;
  lbFirstField: Boolean;
  lAsField: TppAutoSearchField;
begin

  aLines.Clear;
  lbFirstField := False;

  for liIndex := 0 to AutoSearchFieldCount - 1 do
    begin
      lAsField := AutoSearchFields[liIndex];

      // skip, when search expression is blank
      if (lAsField.SearchExpression = '') {or lAsField.ShowAllValues)}  then
        Continue;

      if not(lbFirstField) then
        begin
          AutoSearchFields[liIndex].FirstField := True;
          lbFirstField := True;
        end;

       aLines.Add(AutoSearchFields[liIndex].Description);

    end;

end; {procedure, GetAutoSearchDescriptionLines}

{------------------------------------------------------------------------------}
{ TppReport.CloseSubReportDataPipelines }

procedure TppReport.CloseSubReportDataPipelines;
var
  lReports: TStringList;
  lReport: TppCustomReport;
  liReport: Integer;
begin
  lReports := TStringList.Create;

  {get list of all sub-reports}
  GetSubReports(lReports);

  for liReport := 0 to lReports.Count - 1 do
    begin
      lReport := TppCustomReport(lReports.Objects[liReport]);

      if (lReport.Engine <> nil) then
        lReport.Engine.CloseDataPipelines;
    end;

  lReports.Free;

end; {procedure, CloseSubReportDataPipelines}


{------------------------------------------------------------------------------}
{ TppReport.Transfer }

procedure TppReport.Transfer(aSource: TppCommunicator);
var
  lSourceReport: TppReport;
begin

  if (aSource is TppReport) then
    begin
      lSourceReport := TppReport(aSource);

      {transfer the parameters}
      if (lSourceReport.Parameters.Count > 0) then
        begin
          lSourceReport.Parameters.Parent := Self;

          if (Owner <> GetParameters.Owner) then
            FParameters.ChangeOwner(Owner);
        end;

    end;

  // must transfer params above first, then call inherited
  inherited Transfer(aSource);

  if not(aSource is TppReport) then Exit;

  FCacheManager.ResetCache;

  lSourceReport := TppReport(aSource);

  FCachePages := lSourceReport.CachePages;

  ShowAutoSearchDialog := lSourceReport.ShowAutoSearchDialog;

  {4.25 - allow DADE dataview to create the autosearch fields, don't transfer them}
  {for liIndex := 0 to lSourceReport.AutoSearchFieldCount - 1 do
    lSourceReport.AutoSearchFields[0].Parent := Self; }

  {note: this event is public, but needs to be assigned}
  FOnLoadTemplate := lSourceReport.OnLoadTemplate;

  {used for conversion to 3.0}
  FDataSource := lSourceReport.DataSource;

  FOutlineSettings.Assign(lSourceReport.OutlineSettings);


end; {procedure, Transfer}

{------------------------------------------------------------------------------}
{ TppReport.ESInclude }

procedure TppReport.ESInclude(aEngineStateSet: TppEngineStates);
begin

  Engine.ESInclude(aEngineStateSet);

end; {function, ESInclude}

{------------------------------------------------------------------------------}
{ TppReport.ESExclude }

procedure TppReport.ESExclude(aEngineStateSet: TppEngineStates);
begin

  Engine.ESExclude(aEngineStateSet);

end; {function, ESExclude}

{------------------------------------------------------------------------------}
{ TppReport.Loaded }

procedure TppReport.Loaded;
begin

  inherited Loaded;

  LanguageChanged;

end; {function, Loaded}

{------------------------------------------------------------------------------}
{ TppReport.SetLanguage }

procedure TppReport.SetLanguage(aLanguageType: TppLanguageType);
var
  lbLanguageChanged: Boolean;
begin

  {optimize}
  lbLanguageChanged := (Language <> aLanguageType);

  inherited SetLanguage(aLanguageType);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if lbLanguageChanged then
    LanguageChanged;

end; {procedure, SetLanguage}

{------------------------------------------------------------------------------}
{ TppReport.SetLanguageID }

procedure TppReport.SetLanguageID(aLanguageID: String);
var
  lbLanguageChanged: Boolean;
begin
  {optimize}
  lbLanguageChanged := (LanguageID <> aLanguageID);

  inherited SetLanguageID(aLanguageID);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if lbLanguageChanged then
    LanguageChanged;

end; {procedure, SetLanguageID}

{------------------------------------------------------------------------------}
{ TppReport.DoOnLoadTemplate }

procedure TppReport.DoOnLoadTemplate(aReport: TppCustomReport);
begin

  if Assigned(FOnLoadTemplate) then FOnLoadTemplate(aReport);

end; {function, DoOnLoadTemplate}

{------------------------------------------------------------------------------}
{ TppReport.PrintDateTime }

function TppReport.PrintDateTime: TDateTime;
begin
  Result := Engine.PrintDateTime;
end; {function, PrintDateTime}

{------------------------------------------------------------------------------}
{ TppReport.GetMainReport }

function TppReport.GetMainReport: TppCustomReport;
begin

  if (ParentReport = nil) then
    Result := Self
  else
    Result := ParentReport.MainReport;

end; {function, GetMainReport}

{------------------------------------------------------------------------------}
{ TppReport.StartOfMainReport }

procedure TppReport.StartOfMainReport;
var
  liIndex: Integer;
  lPipelines: TList;
begin

  lPipelines := TList.Create;

  GetDataPipelines(lPipelines);

  for liIndex := 0 to lPipelines.Count - 1 do
    TppDataPipeline(lPipelines[liIndex]).StartOfMainReport(lPipelines);

  lPipelines.Free;

  inherited StartOfMainReport;

  {required for linked DataPipelines to ensure DataPipeline.State is accurate}
  if (DataPipeline <> nil) and (DataPipeline.Active) then
    begin
      DataPipeline.State := [];
      DataPipeline.First;
    end;


end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppReport.GetReportKey }

procedure TppReport.GetReportKey(var aKey: String);
var
  lSubReport: TppSubReport;
begin

  if (Parent is TppSubReport) then
    begin
      lSubReport := TppSubReport(Parent);

      aKey := aKey + Format('%8d', [lSubReport.Count]) + '|';

      if (lSubReport.Band <> nil) and (lSubReport.Band.Report <> nil) then
       lSubReport.Band.Report.GetReportKey(aKey);
    end;

end; {function, GetReportKey}

{------------------------------------------------------------------------------}
{ TppReport.ResetFromPageNo }

procedure TppReport.ResetFromPageNo(aAbsolutePageNo: Longint);
begin

  FCacheManager.DumpCache(aAbsolutePageNo);

  if (Engine <> nil) then
    Engine.ResetFromPageNo(aAbsolutePageNo);

end; {procedure, ResetFromPageNo}

{------------------------------------------------------------------------------}
{ TppReport.GetLastPageCached }

procedure TppReport.GetLastPageCached(Sender: TObject; var aPageNo: Longint);
begin
  aPageNo := FCacheManager.CachePageCount;
end;

{------------------------------------------------------------------------------}
{ TppReport.ResetCache }

procedure TppReport.ResetCache(Sender: TObject);
begin

  {clear any previously created bookmarks, this also clears the streams}
  FCacheManager.ResetCache;

end; {procedure, ResetCache}

{------------------------------------------------------------------------------}
{ TppReport.ReadCache }

procedure TppReport.ReadCache(Sender: TObject);
begin

  {restore engine state}
  FCacheManager.ReadCache(AbsolutePageNo - 1);

end; {procedure, ReadCache}

{------------------------------------------------------------------------------}
{ TppReport.WriteCache }

procedure TppReport.WriteCache(Sender: TObject);
begin

  {save engine state}
  FCacheManager.WriteCache(AbsolutePageNo);

end; {procedure, WriteCache}

{------------------------------------------------------------------------------}
{ TppReport.SetCachePages }

procedure TppReport.SetCachePages(Value: Boolean);
begin
  if Printing then Exit;

  if (FCachePages <> Value) then
    begin
      FCachePages := Value;

      {notify report designer}
      SetModified(True);

      Reset;
    end;

end; {procedure, SetCachePages}

{------------------------------------------------------------------------------}
{ TppReport.PrintReport - backward compatibility }

procedure TppReport.PrintReport;
begin
  Print;
end; {procedure, PrintReport}

{------------------------------------------------------------------------------}
{ TppReport.PrintPageList - backward compatibility }

procedure TppReport.PrintPageList(aPageList: TStrings);
begin

  {RequestPage(Self, psPageList, 0, aPageList);}

end; {procedure, PrintPageList}

{------------------------------------------------------------------------------}
{ TppReport.PrintPage - backward compatibility }

procedure TppReport.PrintPage(aPageNo: Integer);
begin

  {RequestPage(Self, psSinglePage, aPageNo, nil);}

end; {procedure, PrintPage}

{------------------------------------------------------------------------------}
{ TppReport.PrintToDevices }

procedure TppReport.PrintToDevices;
var
  lbDesigning: Boolean;
begin

  lbDesigning := (ReportDesigner <> nil);

  try

    if lbDesigning then
      SendDesignMessage(RM_REPORTPRINTING, ppWCustomMsg, TObject(1));

    if not(esInitialized in Engine.State) and not(Engine.StopPrinting) then
      begin
        Publisher.CachePages := FCachePages;

        ResetSubReports;
      end;

    inherited PrintToDevices;

  finally

    if lbDesigning then
      SendDesignMessage(RM_REPORTPRINTING, ppWCustomMsg, TObject(0));

  end;

end; {procedure, PrintToDevices}

{------------------------------------------------------------------------------}
{ TppReport.RequestPage }

procedure TppReport.RequestPage(Sender: TObject; aPageRequest: TObject);
begin

  inherited RequestPage(Sender, aPageRequest);

    if not(esInitialized in Engine.State) then
      GetOutline.Initialize;

  {generate the pages}
  try

      Printing := True;

    try

      Engine.Page.PrinterSetup := PrinterSetup;
      Engine.Page.Producer := Self;

      {set page size}
      if not(Engine.Page.PrinterSetup.IsPrinterDefEqual(PrinterSetup)) then
        begin
          Publisher.Clear;

          Engine.Reset;
        end;

      Engine.RequestPage(TppPageRequest(aPageRequest));

    except
      Engine.Printing := False;
      Engine.Reset;

      raise;

    end; {try, except}

  finally

    Printing := False;

  end; {try, finally}

  {if the user cancels the job, notify devices, reset engine}
  if Engine.StopPrinting then
    Engine.Reset;

  {cancel the job if no page was sent to the device}
  if DonePrinting and (AbsolutePageCount = 0) and (ndBlankPage in NoDataBehaviors) then
    begin
      Cancel;
//      Reset;
    end;

end; {procedure, RequestPage}

{------------------------------------------------------------------------------}
{ TppReport.Reset }

procedure TppReport.Reset;
begin

  inherited Reset;

  if (Printing) then Exit;

  FOutline.Free;
  FOutline := nil;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppReport.Cancel }

procedure TppReport.Cancel;
begin

  inherited Cancel;

  if (FActiveReport <> nil) and (FActiveReport <> Self) then
    FActiveReport.Cancel;

  if (Engine <> nil) then
    Engine.StopPrinting := True;

end; {procedure, Cancel}

{------------------------------------------------------------------------------}
{ TppReport.IsCached }

function TppReport.IsCached: Boolean;
begin

  Result := (esInitialized in Engine.State);

end; {function, IsCached}

{------------------------------------------------------------------------------}
{ TppReport.PageSent }

procedure TppReport.PageSent(Sender: TObject);
begin

  Publisher.ReceivePage(Engine.Page);

end; {procedure, PageSent}


{@TppReport.ExpandDrillDowns
 Sets the ExpandAll property of all drill-down subreports in the report (and in
 all nested subreports) to True.  Also, resets the report.  A call to
 ExpandDrillDowns must be followed by a call to Print or PrintToDevices in order
 to see the results of the newly configured report.}

procedure TppReport.ExpandDrillDowns;
begin
  TakeSubReportAction(ppsrExpandDrillDowns);

  ResetFromPageNo(1);

  Publisher.ResetDevices;
end; {procedure, ExpandDrillDowns}


{@TppReport.CollapseDrillDowns
 Sets the ExpandAll property of all drill-down subreports in the report (and in
 all nested subreports) to False.  Also, resets the report.  A call to
 CollapseDrillDowns must be followed by a call to Print or PrintToDevices in
 order to see the results of the newly configured report.}

procedure TppReport.CollapseDrillDowns;
begin
  TakeSubReportAction(ppsrCollapseDrillDowns);

  ResetFromPageNo(1);
  
  Publisher.ResetDevices;
end; {procedure, ExpandDrillDowns}

{------------------------------------------------------------------------------}
{ TppReport.ResetSubReports }

procedure TppReport.ResetSubReports;
begin
  TakeSubReportAction(ppsrReset);
end; {procedure, ResetSubReports}

{------------------------------------------------------------------------------}
{ TppReport.TakeSubReportAction }

procedure TppReport.TakeSubReportAction(aAction: TppSubReportActionType);
var
  lReports: TStringList;
  lReport: TppCustomReport;
  liReport: Integer;
begin
  lReports := TStringList.Create;

  {get list of all sub-reports}
  GetSubReports(lReports);

  for liReport := 0 to lReports.Count - 1 do
    begin
      lReport := TppCustomReport(lReports.Objects[liReport]);

      case aAction of
         ppsrReset:
           begin
             if (lReport.Engine <> nil) then
               lReport.Engine.Reset;
           end;

         ppsrExpandDrillDowns:
           begin
             if (lReport is TppChildReport) and (TppChildReport(lReport).Parent is TppSubReport) then
               TppSubReport(TppChildReport(lReport).Parent).ExpandAll := True;
           end;

         ppsrCollapseDrillDowns:
           begin
             if (lReport is TppChildReport) and (TppChildReport(lReport).Parent is TppSubReport) then
               TppSubReport(TppChildReport(lReport).Parent).ExpandAll := False;
           end;

      end;

    end;

  lReports.Free;

end; {procedure, TakeSubReportAction}

{------------------------------------------------------------------------------}
{ TppReport.SetOutlineSettings }

procedure TppReport.SetOutlineSettings(aOutlineSettings: TppOutlineReportSettings);
begin

  FOutlineSettings.Assign(aOutlineSettings);

end; { procedure, SetOutlineSettings }

{@TppReport.GetOutline }

function TppReport.GetOutline: TppOutline;
begin

  if (FOutline = nil) then
    begin
      CreateOutline;

      FOutline.Initialize;
    end;

  Result := FOutline;

end; { function, GetOutline }

{@TppReport.CreateOutline }

procedure TppReport.CreateOutline;
begin

  if (FOutline = nil) then
    begin
      FOutline := TppOutline.Create(Self);
      FOutline.Report := Self;
      FOutline.OnOutlineNodeCreate := OutlineNodeCreateEvent;
    end;

end;

{@TppReport.GenerateOutlineDrawCommand }

procedure TppReport.GenerateOutlineDrawCommand;
begin
  if FOutlineSettings.Enabled then
    GetOutline.GenerateDrawCommand;
end;  

{------------------------------------------------------------------------------}
{ TppReport.OutlineNodeCreateEvent }

procedure TppReport.OutlineNodeCreateEvent(Sender: TObject; aNode: TppOutlineNode; var aAccept: Boolean);
var
  lParams: TraParamList;
begin

  lParams := TraTppReportRTTI.GetParams('OnOutlineNodeCreate');

  lParams.CreateValuePointer(0, Sender);
  lParams.CreateValuePointer(1, aNode);
  lParams.CreateValuePointer(2, aAccept);

  SendEventNotify(Self, ciReportOutlineNodeCreate, lParams);

  lParams.Free;

  if Assigned(FOnOutlineNodeCreate) then FOnOutlineNodeCreate(Sender, aNode, aAccept);

end;

{------------------------------------------------------------------------------}
{ TppReport.iOutlineGetChildren }

function TppReport.iOutlineGetChildren: TList;
begin

  if (FOutlineChildren = nil) then
    FOutlineChildren := TList.Create
  else
    FOutlineChildren.Clear;

  GetOutlineChildren(FOutlineChildren);

  Result := FOutlineChildren;

end; { function, iOutlineGetChildren }

{------------------------------------------------------------------------------}
{ TppReport.iOutlineGetParent }

function TppReport.iOutlineGetParent: TppCommunicator;
begin

  Result := nil;

end; { function, iOutlineGetParent }

{------------------------------------------------------------------------------}
{ TppReport.iOutlineSettings }

function TppReport.iOutlineSettings: TppOutlineSettings;
begin

  Result := FOutlineSettings;

end; { function, iOutlineSettings }

{------------------------------------------------------------------------------}
{ TppReport.iOutlineNodeCreatorClass }

function TppReport.iOutlineNodeCreatorClass: TComponentClass;
begin

  Result := TppOutlineReportNodeCreator;

end; { function, iOutlineNodeCreatorClass }

{------------------------------------------------------------------------------}
{ TppReport.iOutlineSettingsChanged }

procedure TppReport.iOutlineSettingsChanged;
begin

  {notify report designer}
  SetModified(True);

  Reset;

end; { procedure, iOutlineSettingsChanged }

{@TppReport.iAutoSearchFieldCount }

function TppReport.iAutoSearchFieldCount: Integer;
begin
  Result := GetAutoSearchFieldCount;
end;

{@TppReport.iAutosearchFieldForIndex }

function TppReport.iAutosearchFieldForIndex(aIndex: Integer): TppAutosearchField;
begin
  Result := GetAutoSearchField(aIndex);
end;

{@TppReport.iCreateAutoSearchField }

function TppReport.iCreateAutoSearchField(const aTableName, aFieldName, aFieldAlias: String; aDataType: TppDataType; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
begin
  Result := CreateAutoSearchField(aTableName, aFieldName, aFieldAlias, aDataType, aOperator, aExpression, aMandatory);
end;

{@TppReport.iCreateAutoSearchCriteria }

function TppReport.iCreateAutoSearchCriteria(const aDataPipelineName, aFieldName: String; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
begin
  Result := CreateAutoSearchCriteria(aDataPipelineName, aFieldName, aOperator, aExpression, aMandatory);
end;
        
{------------------------------------------------------------------------------}
{TppReport.CreateParameterList}

function TppReport.CreateParameterList: TppParameterList;
begin

  Result := TppParameterList.Create(Owner);
  Result.Parent := Self;
  Result.Name := Result.GetValidName(Result);
  Result.AddEventNotify(Self);

end;

{------------------------------------------------------------------------------}
{TppReport.CreatePrintDialog}

function TppReport.CreatePrintDialog: TppCustomPrintDialog;
begin
  Result := inherited CreatePrintDialog;

  if Result <> nil then
    Result.AllowEmail := HasEmailGroups;

end;

{------------------------------------------------------------------------------}
{TppReport.GetParameters}

function TppReport.GetParameters: TppParameterList;
begin
  if (FParameters = nil) then
    FParameters := CreateParameterList;

  Result := FParameters;

end;

{------------------------------------------------------------------------------}
{TppReport.SetParameters}

procedure TppReport.SetParameters(aParameters: TppParameterList);
begin

  GetParameters.Assign(aParameters);

end;

{------------------------------------------------------------------------------}
{TppReport.GetChildren}

procedure TppReport.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin

  inherited;

  {save the parameters}
  if (FParameters <> nil) then
    Proc(FParameters);

end;

{******************************************************************************
 *
 ** R E P O R T  -  DISCONTINUED PROPERTIES
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReport.DefineProperties - read/write private 'fake' properties }

procedure TppReport.DefineProperties(Filer: TFiler);
begin

  inherited DefineProperties(Filer);

  {conversion to 3.0}
  Filer.DefineProperty('AllowPrintCancel', ReadAllowPrintCancel, nil, False);
  Filer.DefineProperty('DataSource', ReadDataSource, nil, False);
  Filer.DefineProperty('OnPrintingComplete', ReadOnPrintingComplete, nil, False);
  Filer.DefineProperty('Orientation', ReadOrientation, nil, False);
  Filer.DefineProperty('NoDataPages', ReadNoDataPages, nil, False);
  Filer.DefineProperty('PreviewPages', ReadPreviewPages, nil, False);
  Filer.DefineProperty('RowSpacing', ReadRowSpacing, nil, False);
  Filer.DefineProperty('SuppressFormFeed', ReadSuppressFormFeed, nil, False);
  Filer.DefineProperty('Viewer', ReadViewer, nil, False);

  {conversion to 5.x}
  Filer.DefineProperty('OnAutoSearchDialogCreate', ReadOnAutoSearchDialogCreate, nil, False);

end;

procedure TppReport.DoParamValueChanged(Sender: TppCommunicator);
begin
  SendEventNotify(Sender, ciParamValueChange, nil);
end;

{------------------------------------------------------------------------------}
{@TppReport.GetDataPipeline

  Returns the datapipeline for the specified user name.

  This method provides a convenient way to retrieve datapipelines, including
  datapipeline associated with queries created via the Data Workspace (i.e. DADE)}

function TppReport.GetDataPipeline(aUserName: String): TppDataPipeline;
begin
  if (FAvailableDataPipelines = nil) then
    FAvailableDataPipelines := TppDataPipelineList.Create(Self)
  else
    FAvailableDataPipelines.Refresh;

  Result := FAvailableDataPipelines.Pipelines[aUserName];
end;

{------------------------------------------------------------------------------}
{ TppReport.HasEmailGroups }

function TppReport.HasEmailGroups: Boolean;
var
  lSubreportList: TStringList;
  liSubreportIndex: Integer;
  liGroupIndex: Integer;
  lReport: TppCustomReport;
begin

  lSubreportList := TStringList.Create;

  try

    Result := inherited HasEmailGroups;

    if not(Result) then
      begin
        GetSubReports(lSubreportList);

        for liSubreportIndex := 0 to lSubreportList.Count - 1 do
          begin
            lReport := TppCustomReport(lSubreportList.Objects[liSubreportIndex]);

            for liGroupIndex := 0 to lReport.GroupCount - 1 do
              if lReport.Groups[liGroupIndex].GroupFileSettings.EmailFile then
                Result := True;
          end;

      end;

  finally
    lSubreportList.Free;
  end;


end;

{------------------------------------------------------------------------------}
{ TppReport.ReadOnAutoSearchDialogCreate }

procedure TppReport.ReadOnAutoSearchDialogCreate(Reader: TReader);
var
  lsMethodName: String;
  lMethod: TMethod;
  lPropInfo: PPropInfo;
  lbError: Boolean;
begin
  {convert version 5.0 OnAutoSearchDialogCreate event handlers to use BeforeAutoSearchDialogCreate event}
  lsMethodName := Reader.ReadIdent;

  if (Reader.Root = nil) then Exit;

  lMethod.Data := Reader.Root;
  lMethod.Code := Reader.Root.MethodAddress(lsMethodName);

  if (lMethod.Code = nil) and Assigned(Reader.OnFindMethod) then
    Reader.OnFindMethod(Reader, lsMethodName, lMethod.Code, lbError);

  if (lMethod.Code <> nil) then
    begin
      lPropInfo := GetPropInfo(ClassInfo, 'BeforeAutoSearchDialogCreate');
      SetMethodProp(Self, lPropInfo, lMethod);
    end;

end; {procedure, ReadOnAutoSearchDialogCreate}

{------------------------------------------------------------------------------}
{ TppReport.ReadDataSource }

procedure TppReport.ReadDataSource(Reader: TReader);
begin
  {read the datasource name, but don't do anything with it}
  FDataSource := Reader.ReadIdent;
end; {procedure, ReadDataSource}

{------------------------------------------------------------------------------}
{ TppReport.ReadNoDataPages }

procedure TppReport.ReadNoDataPages(Reader: TReader);
begin
  {convert nodatapages to pagelimit}
  PageLimit := Reader.ReadInteger;
end; {procedure, ReadNoDataPages}

{------------------------------------------------------------------------------}
{ TppReport.ReadPreviewPages}

procedure TppReport.ReadPreviewPages(Reader: TReader);
begin
  {read the preview pages prop, but don't do anything with it}
  Reader.ReadInteger;
end; {procedure, ReadPreviewPages}

{------------------------------------------------------------------------------}
{ TppBand.ReadOnPrintingComplete }

procedure TppReport.ReadOnPrintingComplete(Reader: TReader);
begin
  FOnPrintingComplete := Reader.ReadIdent;
end; {procedure, ReadOnPrintingComplete}

{------------------------------------------------------------------------------}
{ TppReport.ReadOrientation }

procedure TppReport.ReadOrientation(Reader: TReader);
var
  lsOldOrientation: String;
begin
  lsOldOrientation := Reader.ReadIdent;

  if lsOldOrientation = 'poLandscape' then
    FOldOrientation := poLandscape
  else
    FOldOrientation := poPortrait;

end;

{------------------------------------------------------------------------------}
{ TppReport.ReadRowSpacing }

procedure TppReport.ReadRowSpacing(Reader: TReader);
begin
  FRowSpacing := Reader.ReadFloat;
end;

{------------------------------------------------------------------------------}
{ TppReport.ReadSuppressFormFeed }

procedure TppReport.ReadSuppressFormFeed(Reader: TReader);
begin
  {read the property out of the stream, but don't do anything with it}
  Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
{ TppReport.ReadAllowPrintCancel }

procedure TppReport.ReadAllowPrintCancel(Reader: TReader);
begin
  {read the property out of the stream, but don't do anything with it}
  Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
{ TppReport.ReadViewer }

procedure TppReport.ReadViewer(Reader: TReader);
begin
  {read the datasource name, but don't do anything with it}
  Reader.ReadIdent;
end; {procedure, ReadViewer}

{------------------------------------------------------------------------------}
{ TppCustomReport.ResolvePipelineReferences }

procedure TppReport.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  liIndex: Integer;
begin
  inherited;

  {resolve band pipeline references}
  for liIndex := 0 to Parameters.Count - 1 do
    Parameters.ItemsByIndex[liIndex].ResolvePipelineReferences(aPipelineList);


end;  {procedure, ResolvePipelineReferences}

{******************************************************************************
 *
 ** C H I L D  R E P O R T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppChildReport.Create }

constructor TppChildReport.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FResetting := False;

end;  {constructor, Create}

{------------------------------------------------------------------------------}
{ TppChildReport.Transfer }

procedure TppChildReport.Transfer(aSource: TppCommunicator);
begin

  inherited Transfer(aSource);

  {for a child report, do not allow save as template to load}
  SaveAsTemplate := False;

  if (aSource is TppChildReport) then
    CheckParentPrinterSetup;

end; {procedure, Transfer}

{------------------------------------------------------------------------------}
{ TppChildReport.GetCaption }

function TppChildReport.GetCaption: String;
begin
  if (Parent is TppSubReport) then
    Result := TppSubReport(Parent).Caption
  else
    Result := '';

end; {function, GetCaption }

{------------------------------------------------------------------------------}
{ TppChildReport.GetMainReport }

function TppChildReport.GetMainReport: TppCustomReport;
begin
  if (Parent is TppSubReport) and (TppSubReport(Parent).Band <> nil) and (TppSubReport(Parent).Band.Report <> nil) then
    Result := TppSubReport(Parent).Band.Report.MainReport
  else
    Result := nil;
end; {function, GetMainReport}


{------------------------------------------------------------------------------}
{ TppChildReport.GetReportKey }

procedure TppChildReport.GetReportKey(var aKey: String);
var
  lSubReport: TppSubReport;
begin

  if (Parent is TppSubReport) then
    begin
      lSubReport := TppSubReport(Parent);

      aKey := aKey + Format('%8d', [lSubReport.Count]) + '|';

      if (lSubReport.Band <> nil) and (lSubReport.Band.Report <> nil) then
       lSubReport.Band.Report.GetReportKey(aKey);
    end;

end; {function, GetReportKey}

{------------------------------------------------------------------------------}
{ TppChildReport.GetUniqueUserName }

function  TppChildReport.GetUniqueUserName(aComponent: TComponent): String;
begin
  if aComponent is TppSubReport then
    Result := GetMainReport.GetUniqueUserName(aComponent)
  else
    Result := inherited GetUniqueUserName(aComponent)
end; {function, GetUniqueUserName}

{------------------------------------------------------------------------------}
{ TppChildReport.GetPrintMessage }

function TppChildReport.GetPrintMessage: String;
begin
  if (MainReport <> nil) then
    Result := MainReport.GetPrintMessage;
end; {function, GetPrintMessage }

{------------------------------------------------------------------------------}
{ TppChildReport.SetPrintMessage }

procedure TppChildReport.SetPrintMessage(const aMessage: String);
begin
  if (MainReport <> nil) then
    MainReport.SetPrintMessage(aMessage);
end; {function, SetPrintMessage }

{------------------------------------------------------------------------------}
{ TppChildReport.CheckParentPrinterSetup }

procedure TppChildReport.CheckParentPrinterSetup;
var
  lSubReport: TppSubReport;

begin

  if (ParentReport = nil) or not (Parent is TppSubReport) then Exit;

  lSubReport := TppSubReport(Parent);

  {set ParentPrinterSetup to False if no longer in sync}
  if lSubReport.ParentPrinterSetup and not PrinterSetup.IsEqual(ParentReport.PrinterSetup) then
    lSubReport.ParentPrinterSetup := False;

end; {procedure, CheckParentPrinterSetup}

{------------------------------------------------------------------------------}
{ TppChildReport.PrinterSetupChanged }

procedure TppChildReport.PrinterSetupChanged;
begin

  inherited PrinterSetupChanged;

  CheckParentPrinterSetup;

end; {procedure, PrinterSetupChanged}

{------------------------------------------------------------------------------}
{ TppChildReport.Reset }

procedure TppChildReport.Reset;
begin

  {notify master report, who will then reset all child reports}
  if (MainReport <> nil) then
    MainReport.Reset;

end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppChildReport.Cancel }

procedure TppChildReport.Cancel;
begin

  inherited Cancel;

  Engine.StopPrinting := True;

  if (ParentReport <> nil) and not(ParentReport is TppReport) then
    ParentReport.Cancel;

end; {procedure, Cancel}

{------------------------------------------------------------------------------}
{ TppChildReport.ESInclude }

procedure TppChildReport.ESInclude(aEngineStateSet: TppEngineStates);
begin

  Engine.ESInclude(aEngineStateSet);

  if (ParentReport <> nil) then
    ParentReport.ESInclude(aEngineStateSet);

end; {function, ESInclude}

{------------------------------------------------------------------------------}
{ TppChildReport.ESExclude }

procedure TppChildReport.ESExclude(aEngineStateSet: TppEngineStates);
begin

  Engine.ESExclude(aEngineStateSet);

  if (ParentReport <> nil) then
    ParentReport.ESExclude(aEngineStateSet);

end; {function, ESExclude}

{------------------------------------------------------------------------------}
{ TppChildReport.ProcessMessages }

procedure TppChildReport.ProcessMessages;
var
  lMainReport: TppCustomReport;
begin
  lMainReport := GetMainReport;

  if (lMainReport <> Self) then
    GetMainReport.ProcessMessages
  else
    inherited;

end; {procedure, ProcessMessages}

{------------------------------------------------------------------------------}
{ TppChildReport.SetModified }

procedure TppChildReport.SetModified(Value: Boolean);
var
  lReport: TppCustomReport;
begin

  inherited SetModified(Value);

  if not SaveAsTemplate then
    begin
      lReport := ParentReport;

      if lReport <> nil then
        lReport.Modified := Value;
    end;

end; {function, SetModified}

{@TppChildReport.SetParent

 Pointer to the parent component which owns the child report. This is
 always the TppSubReport component.}

procedure TppChildReport.SetParent(aParent: TppRelative);
begin

  if (Parent <> nil) and (Parent is TppSubReport) then
    TppSubReport(Parent).SetReportProperty(nil);

  inherited SetParent(aParent);

  if (Parent <> nil) and (Parent is TppSubReport) then
    TppSubReport(aParent).SetReportProperty(Self);

end; {function, SetParent}


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
 ** B A N D E D   R E P O R T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppBandedReportRTTI.RefClass }

class function TraTppBandedReportRTTI.RefClass: TClass;
begin
  Result := TppBandedReport;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppBandedReportRTTI.GetPropList }

class procedure TraTppBandedReportRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('ColumnHeader');
  aPropList.AddProp('ColumnFooter');
  aPropList.AddProp('Title');
  aPropList.AddProp('Header');
  aPropList.AddProp('Detail');
  aPropList.AddProp('Footer');
  aPropList.AddProp('Summary');
  aPropList.AddProp('GroupHeader');
  aPropList.AddProp('GroupFooter');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppBandedReportRTTI.GetPropRec }

class function TraTppBandedReportRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'ColumnHeader') or ppEqual(aPropName, 'ColumnHeaderBand') then
    ClassPropToRec(aPropName, TppColumnHeaderBand, True, aPropRec)

  else if ppEqual(aPropName, 'ColumnFooter') or ppEqual(aPropName, 'ColumnFooterBand') then
    ClassPropToRec(aPropName, TppColumnFooterBand, True, aPropRec)

  else if ppEqual(aPropName, 'Title') or ppEqual(aPropName, 'TitleBand') then
    ClassPropToRec(aPropName, TppTitleBand, True, aPropRec)

  else if ppEqual(aPropName, 'Header') or ppEqual(aPropName, 'HeaderBand') then
    ClassPropToRec(aPropName, TppHeaderBand, True, aPropRec)

  else if ppEqual(aPropName, 'Detail') or ppEqual(aPropName, 'DetailBand') then
    ClassPropToRec(aPropName, TppDetailBand, True, aPropRec)

  else if ppEqual(aPropName, 'Footer') or ppEqual(aPropName, 'FooterBand') then
    ClassPropToRec(aPropName, TppFooterBand, True, aPropRec)

  else if ppEqual(aPropName, 'Summary') or ppEqual(aPropName, 'SummaryBand') then
    ClassPropToRec(aPropName, TppSummaryBand, True, aPropRec)

  else if ppEqual(aPropName, 'GroupHeader') or ppEqual(aPropName, 'GroupHeaderBand') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'GroupFooter') or ppEqual(aPropName, 'GroupFooterBand') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppBandedReportRTTI.GetParams }

class function TraTppBandedReportRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'GroupHeader') or ppEqual(aMethodName, 'GroupHeaderBand') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppGroupHeaderBand, '', False, False);
    end

  else if ppEqual(aMethodName, 'GroupFooter') or ppEqual(aMethodName, 'GroupFooterBand') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppGroupFooterBand, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppBandedReportRTTI.CallMethod }

class function TraTppBandedReportRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lReport: TppBandedReport;
  liIndex: Integer;
  lBand: TppBand;
begin

  Result := True;
  
  lReport := TppBandedReport(aObject);

  if ppEqual(aMethodName, 'GroupHeader') or ppEqual(aMethodName, 'GroupHeaderBand') then
    begin
      aParams.GetParamValue(0, liIndex);

      lBand := lReport.GroupHeaderBand[liIndex];

      aParams.SetParamValue(1, Integer(lBand));
    end

  else if ppEqual(aMethodName, 'GroupFooter') or ppEqual(aMethodName, 'GroupFooterBand') then
    begin
      aParams.GetParamValue(0, liIndex);

      lBand := lReport.GroupFooterBand[liIndex];

      aParams.SetParamValue(1, Integer(lBand));
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppBandedReportRTTI.GetPropValue }

class function TraTppBandedReportRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Title') or ppEqual(aPropName, 'TitleBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).TitleBand)

  else if ppEqual(aPropName, 'Header') or ppEqual(aPropName, 'HeaderBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).HeaderBand)

  else if ppEqual(aPropName, 'Detail') or ppEqual(aPropName, 'DetailBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).DetailBand)

  else if ppEqual(aPropName, 'Footer') or ppEqual(aPropName, 'FooterBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).FooterBand)

  else if ppEqual(aPropName, 'Summary') or ppEqual(aPropName, 'SummaryBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).SummaryBand)

  else if ppEqual(aPropName, 'ColumnHeader') or ppEqual(aPropName, 'ColumnHeaderBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).ColumnHeaderBand)

  else if ppEqual(aPropName, 'ColumnFooter') or ppEqual(aPropName, 'ColumnFooterBand') then
    Integer(aValue) := Integer(TppBandedReport(aObject).ColumnFooterBand)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{******************************************************************************
 *
 ** R E P O R T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.RefClass }

class function TraTppReportRTTI.RefClass: TClass;
begin
  Result := TppReport;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.GetPropList }

class procedure TraTppReportRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('PreviewForm');
  aPropList.AddProp('Parameters');

  {add public methods}
  aPropList.AddMethod('AutoSearchCriteriaByName');
  aPropList.AddMethod('CreateAutoSearchCriteria');
  aPropList.AddMethod('GetAutoSearchDescriptionLines');
  aPropList.AddMethod('DisplayAutoSearchDialog');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.GetPropRec }

class function TraTppReportRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if CompareText(aPropName, 'AfterOpenDataPipelines') = 0 then
    EventToRec(aPropName, ciReportAfterOpenDataPipelines, False, aPropRec)

  else if CompareText(aPropName, 'BeforeOpenDataPipelines') = 0 then
    EventToRec(aPropName, ciReportBeforeOpenDataPipelines, False, aPropRec)

  else if CompareText(aPropName, 'BeforeAutoSearchDialogCreate') = 0 then
    EventToRec(aPropName, ciReportBeforeAutoSearchDialogCreate, False, aPropRec)

  else if CompareText(aPropName, 'AfterAutoSearchDialogCreate') = 0 then
    EventToRec(aPropName, ciReportAfterAutoSearchDialogCreate, False, aPropRec)

  else if CompareText(aPropName, 'OnAutoSearchDialogClose') = 0 then
    EventToRec(aPropName, ciReportAutoSearchDialogClose, False, aPropRec)

  else if CompareText(aPropName, 'OnGetAutoSearchValues') = 0 then
    EventToRec(aPropName, ciReportGetAutoSearchValues, False, aPropRec)

  else if CompareText(aPropName, 'OnInitializeParameters') = 0 then
    EventToRec(aPropName, ciReportInitializeParameters, True, aPropRec)

  else if CompareText(aPropName, 'OnOutlineNodeCreate') = 0 then
    EventToRec(aPropName, ciReportOutlineNodeCreate, True, aPropRec)


  {properties & methods}
  else if (CompareText(aPropName, 'ActiveReport') = 0) then
    ClassPropToRec(aPropName, TppCustomReport, True, aPropRec)

  else if (CompareText(aPropName, 'AutoSearchCriteriaByName') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'AutoSearchDialog') = 0) then
    ClassPropToRec(aPropName, TppCustomAutoSearchDialog, True, aPropRec)

  else if (CompareText(aPropName, 'AutoSearchFields') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'AutoSearchDescription') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'AutoSearchFieldCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'CacheManager') = 0) then
    ClassPropToRec(aPropName, TppCacheManager, True, aPropRec)

  else if (CompareText(aPropName, 'CachePages') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Parameters') = 0) then
    ClassPropToRec(aPropName, TppParameterList, False, aPropRec)

  else if (CompareText(aPropName, 'CreateAutoSearchCriteria') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'DisplayAutoSearchDialog') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetAutoSearchDescriptionLines') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.GetParams }

class function TraTppReportRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'AutoSearchFields') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppAutoSearchField, '', False, False);
    end

  else if (CompareText(aMethodName, 'CreateAutoSearchCriteria') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDataPipelineName', daString, nil, '', True, False);
      Result.AddParam('aFieldName', daString, nil, '', True, False);
      Result.AddParam('aOperator', daEnum, nil, 'TppSearchOperatorType', False, False);
      Result.AddParam('aExpression', daString, nil, '', True, False);
      Result.AddParam('aMandatory', daBoolean, nil, '', False, False);
      Result.AddParam('Result', daClass, TppAutoSearchField, '', False, False);
    end

  else if (CompareText(aMethodName, 'AutoSearchCriteriaByName') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDataPipelineName', daString, nil, '', True, False);
      Result.AddParam('aFieldName', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TppAutoSearchField, '', False, False);
    end

  else if (CompareText(aMethodName, 'DisplayAutoSearchDialog') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end

  else if (CompareText(aMethodName, 'GetAutoSearchDescriptionLines') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aLines', daClass, TStrings, '', False, False);
    end
  else if (CompareText(aMethodName, 'OnInitializeParameters') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aCancel', daBoolean, nil, '', False, True);
    end
  else if (CompareText(aMethodName, 'OnOutlineNodeCreate') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('NodeCreator', daClass, TObject, '', False, False);
      Result.AddParam('Node', daClass, TppOutlineNode, '', False, False);
      Result.AddParam('Accept', daBoolean, nil, '', False, True);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.CallMethod }

class function TraTppReportRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lReport: TppReport;
  liIndex: Integer;
  lField: TppAutoSearchField;
  lsDataPipeName: String;
  lsFieldName: String;
  liOperator: Integer;
  lOperator: TppSearchOperatorType;
  lbMandatory: Boolean;
  lsExpression: String;
  lStringList: TStringList;
  lbResult: Boolean;
begin

  Result := True;
  
  lReport := TppReport(aObject);

  if (CompareText(aMethodName, 'AutoSearchFields') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lField := lReport.AutoSearchFields[liIndex];

      aParams.SetParamValue(1, Integer(lField));
    end

  else if (CompareText(aMethodName, 'AutoSearchCriteriaByName') = 0) then
    begin
      aParams.GetParamValue(0, lsDataPipeName);
      aParams.GetParamValue(1, lsFieldName);

      lField := lReport.AutoSearchCriteriaByName(lsDataPipeName, lsFieldName);

      aParams.SetParamValue(2, Integer(lField));
    end

  else if (CompareText(aMethodName, 'CreateAutoSearchCriteria') = 0) then
    begin
      aParams.GetParamValue(0, lsDataPipeName);
      aParams.GetParamValue(1, lsFieldName);
      aParams.GetParamValue(2, liOperator);
      aParams.GetParamValue(3, lsExpression);
      aParams.GetParamValue(4, lbMandatory);

      lOperator := TppSearchOperatorType(liOperator);

      lField := lReport.CreateAutoSearchCriteria(lsDataPipeName, lsFieldName, lOperator, lsExpression, lbMandatory);

      aParams.SetParamValue(5, Integer(lField));
    end
  else if (CompareText(aMethodName, 'DisplayAutoSearchDialog') = 0) then
    begin
      lbResult := lReport.DisplayAutoSearchDialog;

      aParams.SetParamValue(0, lbResult);
    end

  else if (CompareText(aMethodName, 'GetAutoSearchDescriptionLines') = 0) then
    begin
      aParams.GetParamValue(0, lStringList);

      lReport.GetAutoSearchDescriptionLines(lStringList);

      aParams.SetParamValue(0, lStringList);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.GetPropValue }

class function TraTppReportRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'ActiveReport') = 0) then
    Integer(aValue) := Integer(TppReport(aObject).PreviewForm)

  else if (CompareText(aPropName, 'AutoSearchDescription') = 0) then
    String(aValue) := TppReport(aObject).AutoSearchDescription

  else if (CompareText(aPropName, 'GetAutoSearchDescriptionAsString') = 0) then
    Integer(aValue) := Integer(TppReport(aObject).GetAutoSearchDescriptionAsString)

  else if (CompareText(aPropName, 'AutoSearchDialog') = 0) then
    Integer(aValue) := Integer(TppReport(aObject).AutoSearchDialog)

  else if (CompareText(aPropName, 'AutoSearchFieldCount') = 0) then
    Integer(aValue) := TppReport(aObject).AutoSearchFieldCount

  else if (CompareText(aPropName, 'CacheManager') = 0) then
    Integer(aValue) := Integer(TppReport(aObject).CacheManager)

  else if (CompareText(aPropName, 'CachePages') = 0) then
    Boolean(aValue) := TppReport(aObject).CachePages

  else if ppEqual(aPropName, 'Parameters')  then
    Integer(aValue) := Integer(TppReport(aObject).Parameters)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppReportRTTI.SetPropValue }

class function TraTppReportRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'CachePages') = 0) then
    TppReport(aObject).CachePages := Boolean(aValue)

  else if ppEqual(aPropName, 'Parameters')  then
    TppReport(aObject).Parameters := TppParameterList(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization

  RegisterClasses([TppChildReport, TppReport, TppReportTemplate]);

  raRegisterRTTI(TraTppBandedReportRTTI);
  raRegisterRTTI(TraTppReportRTTI);

finalization

  UnRegisterClasses([TppChildReport, TppReport, TppReportTemplate]);

  raUnRegisterRTTI(TraTppBandedReportRTTI);
  raUnRegisterRTTI(TraTppReportRTTI);

end.


