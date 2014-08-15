/// This unit contains the base TCustomFlexCelReport definition.

unit UCustomFlexCelReport;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}
{******************************************************************
 Component to automate reporting to Excel

// The original code is Excel.pas, released January 23, 2002.
//
// The initial developer of the original code is Adrian Gallero,
// written by Adrian Gallero (agallero@netscape.net).
//
// Portions created by Adrian Gallero are Copyright
// (C) 2002-2008 Adrian Gallero. All Rights Reserved.
******************************************************************** }
interface
uses
  SysUtils, Classes,
  Contnrs, UXlsDB,
  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}
  StrUtils, 
  typinfo, UExcelAdapter, UFlxMessages, UFlxFullDataSets, UFlxFormats, UFlxUtils, UFlexCelBands;

type
  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnAfterGenerateWorkbook" /> and <see cref="TCustomFlexCelReport.OnBeforeGenerateWorkbook" />.
  /// 
  /// </summary>                                                                                                                                         
  TOnGenerateEvent = procedure (Sender: TObject; const ExcelApp: TExcelFile) of object;
  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnAfterGeneratePage" /> and <see cref="TCustomFlexCelReport.OnBeforeGeneratePage" />.
  /// 
  /// </summary>                                                                                                                                 
  TOnGeneratePageEvent = procedure (Sender: TObject; const ExcelApp: TExcelFile) of object;
  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnGetCellValue" />.
  /// </summary>                                                               
  TOnGetCellValue = procedure (Sender: TObject; const FieldName: WideString; var FieldValue: variant) of object;
  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnGetCellValueX" />.
  /// </summary>                                                                
  TOnGetCellValueX = procedure (Sender: TObject; const ExcelApp: TExcelFile; const FieldName: WideString; var FieldValue:variant; var XF: integer) of object;
  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnGetCellValueXRow" />.
  /// </summary>                                                                   
  TOnGetCellValueXRow = procedure (Sender: TObject; const ExcelApp: TExcelFile; const FieldName: WideString; var FieldValue:variant; var XF: integer; const Row,Col:Integer) of object;
  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnGetImageSize" />.
  /// </summary>                                                               
  TOnGetImageSize  = procedure (Sender: TObject; const ExcelApp: TExcelFile; const FieldName: WideString; const FieldType: TXlsImgTypes; const ImageData: TStream; var Row ,Col:integer; var Height, Width: extended) of object;

  //TFlxImageResize=(fli_ResizeNone, fli_KeepHeight, fli_KeepWidth, fli_ResizeBoth);

  /// <summary>
  /// How rows will be inserted when running the report.
  /// </summary>
  TFlxReportMode=(
    /// <summary>
    /// Normal mode. Rows will be inserted and existing data moved down.
    /// </summary>
    frm_FullCopyAndInsert,

    /// <summary>
    /// Rows will be copied but will overwrite exsting rows.
    /// </summary>
    frm_OnlyCopy,

    /// <summary>
    /// Rows will be not be copied at all. The report will just overwrite the existing cells.
    /// </summary>
    frm_DontCopyAndDontInsert);

  /// <summary>
  /// Phase of the report we are in.
  /// </summary>
  TFlxProgressPhase=(
    /// <summary>
    /// Report is inactive.
    /// </summary>
    fps_NotRunning,

        /// <summary>
        /// Reading and parsing the template.
        /// </summary>
        fps_ReadTemplate,

        /// <summary>
        /// Organizing the data on the template.
        /// </summary>
        fps_OrganizeData,

        /// <summary>
        /// Inserting the needed rows/ranges for the report.
        /// </summary>
        fps_CopyStructure,

        /// <summary>
        /// Replacing the tags with the new values.
        /// </summary>
        fps_FillData,

        /// <summary>
        /// Fixing pagebreak or delete rows tags.
        /// </summary>
        fps_FinalCleanup,

        /// <summary>
        /// Report has finished.
        /// </summary>
        fps_Done);

  TCustomFlexCelReport=class;

  /// <summary>
  /// Contains the progress information of the report.
  /// </summary>
  /// <remarks>
  /// The information in this structure is not really accurate because there is a compromise between
  /// creating the report as fast as possible and spending time updating the progress information.<para></para>
  /// Even so, it can give an idea to the user of what the report is actually doing at a given time.
  /// </remarks>                                                                                               
  TFlxProgress= class
  private
    FPhase: TFlxProgressPhase;
    FCounter: integer;
    FSheet: integer;

    FlexCelReport: TCustomFlexCelReport;


    procedure SetPhase(const Value: TFlxProgressPhase);
    procedure SetSheet(const Value: integer);

    property xPhase: TFlxProgressPhase read FPhase write SetPhase;
    property xSheet: integer read FSheet write SetSheet;
  public
    constructor Create(const aFlexCelReport: TCustomFlexCelReport);

    /// <summary>
    /// Phase of the report. (reading the template, inserting rows, etc.).
    /// </summary>
    property Phase: TFlxProgressPhase read FPhase;

    /// <summary>
    /// A counter that is increased from time to time.
    /// </summary>
    /// <remarks>
    /// This value has no real meaning, but you can display it to the user as a way to know how much time is
    /// still pending for the report.
    /// </remarks>
    property Counter: integer read FCounter;

    /// <summary>
    /// Sheet that is being generated.
    /// </summary>
    property Sheet: integer read FSheet;
  end;

  /// <summary>
  /// Event associated with <see cref="TCustomFlexCelReport.OnProgress" />
  /// </summary>                                                          
  TOnFlxProgressEvent = procedure (Sender: TObject; const Progress: TFlxProgress; var Cancel: boolean) of object;

  /// <summary>
  /// This class if for internal use.<para></para>
  ///
  /// </summary>
  TFlxProp=class
  public
    /// <summary>
    /// Name of the property.
    /// </summary>
    Name: string;

    /// <summary>
    /// Value of the property.
    /// </summary>
    Value: variant;
    constructor Create(const aName: string; const aValue: variant);
  end;

  /// <summary>
  /// A collection of TFlxProp classes. This class is for internal use.
  /// </summary>
  TFlxPropList= class(TObjectList)  //Items are TFlxProp
  {$Include TFlxPropListHdr.inc}
  end;

  /// <summary>
  /// Base class for all specialized TFlexCelReport descendants.
  /// </summary>
  /// <remarks>
  /// This class implements the code functionality needed for a FlexCel Report, without any specifics like
  /// the Data access layer, so their children can implement it as they want.<para></para>
  /// <para></para>
  /// Its descendants include TFlexCelReport and TFlexCelReportNoDB. The first one uses a standard TDataSet
  /// data layer, while the second uses a &quot;no db&quot; layer.<para></para>
  /// <para></para>
  /// Do not create instances of TCustomFlexCelReport. Use it as a base to derive your own components, or
  /// use the derived components supplied.
  /// </remarks>                                                                                           
  TCustomFlexCelReport = class(TComponent)
  private
    Workbook: TExcelFile;
    FullDataSets: TFullDataSetList;
    ValueCache: TBandValueList;
    LazyDbList: TExcelDbList;

    FTemplate: TFileName;
    FAdapter: TExcelAdapter;

    FAutoClose: boolean;
    FFileName: TFileName;
    FPagesDataField: string;

    FValues: TFlxPropList;

    FOnBeforeGenerateWorkbook: TOnGenerateEvent;
    FOnAfterGenerateWorkbook: TOnGenerateEvent;
    FOnAfterGeneratePage: TOnGeneratePageEvent;
    FOnBeforeGeneratePage: TOnGeneratePageEvent;
    FOnGetFileName: TOnGetFileNameEvent;
    FOnGetOutStream: TOnGetOutStreamEvent;
    FOnGetCellValue: TOnGetCellValue;
    FDateTimeFormat: string;
    FOnGetCellValueX: TOnGetCellValueX;
    FOnGetCellValueXRow: TOnGetCellValueXRow;
    FDeleteEmptyRows: boolean;
    FOnGetImageSize: TOnGetImageSize;
    FReportModeRows: TFlxReportMode;
    FReportModeCols: TFlxReportMode;
    FProgress: TFlxProgress;
    FOnProgress: TOnFlxProgressEvent;
    FKeepEmptyPictures: boolean;
    //FImageResize: TFlxImageResize;

    procedure SetTemplate(const Value: TFileName);
    procedure SetPagesDataField(const Value: string);
    procedure SetAdapter(const Value: TExcelAdapter);

    procedure InsertSheets(const FirstPage: integer);
    function ExportFieldData: boolean;
    procedure ReadTemplate(out MainBand: TExcelBand);
    function FindBands(const StartRow, EndRow: integer): TExcelBand;
    function IsDBName(s: UTF16String): boolean;
    function GetDataSetFromName(s: UTF16String): WideStringArray;
    function FindSubBands(const StartRow, EndRow: integer): TExcelBandList;
    procedure CopyStructure(const Band: TExcelBand; var RowOffset: integer);
    procedure FillBandData(const Band: TExcelBand; var RowOffset: integer; const MainBandRow: integer);
    function GetValue(const BandValue: TBandValue; const RowOffset, col: integer; out RTFRuns: TRTFRunList): variant;
    function GetOneValue(const BandValue: TBandValue; const RowOffset, col: integer; const i: integer; var RTFRuns: TRTFRunList; const RTFLen: integer): variant;
    procedure ReplaceValues(const Band: TExcelBand;const Rof: integer; var RowOffset: integer);
    procedure ReplacePictures(var RowOffset: integer);
    procedure ReplaceComments(var RowOffset: integer);
    procedure FillFullDatasets;
    function SupressCR(const s: UTF16String): UTF16String;
    procedure GetOneDimArray(var v: variant; PropIndex: string; const VarName: string);
    procedure GetMultiDimArray(var v: variant; PropIndex: string; const VarName: string);

    procedure FillBandValueList(const RangePos: integer);
    function GetBandValue(const v: Variant;const ColOffset: integer; const XF: integer; const RTFRuns: TRTFRunList): TBandValue;
    function GetOneBandValue(const v:Variant; const ColOffset: integer; const XF: integer; const RTFRuns: TRTFRunList; const RTFOfs: integer): TOneBandValue;
    function BandEof(const Ds: TDataSetArray; var FirstRecord: boolean): boolean;
    procedure BandMoveFirst(const Ds: TDataSetArray);
    procedure BandMoveNext(const Ds: TDataSetArray);
    function BandIsNil(const Ds: TDataSetArray): boolean;
    procedure Execute(const InStream: TStream = nil; const OutStream: TStream=nil);
    function ParseParams(const Arguments: string): ArrayOfVariant;
    { Private declarations }

  protected
    /// <summary>
    /// Read this field in a descendant class to know if the user has selected UseDisplayNames property.
    /// </summary>                                                                                      
    FUseDisplayNames: boolean;

    /// <summary>
    /// Read this field in a descendant class to know if the user selected to use hidden fields.<para></para>
    /// 
    /// </summary>                                                                                           
    FUseHiddenFields: boolean;

    /// <summary>
    /// Read this field on a descendant class to know if the report has been canceled by the user. If it has,
    /// you should stop doing whaat you are doing and exit as fast as possible.
    /// </summary>                                                                                           
    Canceled: boolean;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    /// <summary>
    /// This method returns the PPropInfo information for a given published property.
    /// </summary>
    /// <remarks>
    /// FlexCelReport uses this method to search for published properties in the datamodule.<para></para>
    /// You will not probably need to override this method when creating a descendant class.
    /// </remarks>
    /// <param name="PropName">Published property name.</param>
    function GetPropertyInfo(const PropName: string): PPropInfo;virtual;

    /// <summary>
    /// Evaluates a published property from a PPropInfo structure returned by GetPropertyInfo.
    /// </summary>
    /// <remarks>
    /// This method is used internally by TCustomFlexCelReport to evaluate the published properties in the
    /// report. You will normally not need to call or override this method.
    /// </remarks>
    /// <param name="PropInfo">a PPropInfo structure returned by GetPropertyInfo.</param>
    /// <returns>
    /// The result from the property as a variant value.
    /// </returns>
    function GetVariantProperty(const PropInfo: PPropInfo): variant;virtual;

    /// <summary>
    /// This method returns the MethodInfo information for a given published method.
    /// </summary>
    /// <remarks>
    /// FlexCelReport uses this method to search for published user defined functions. Take a look at the PDF
    /// documentation or the &quot;PseudoCalculatedFields&quot; demo to see how to use published user defined
    /// functions.<para></para>
    /// You will not probably need to override this method when creating a descendant class.
    /// </remarks>
    /// <param name="MethodName">Method we want to get its MethodInfo.</param>
    function GetMethodInfo(const MethodName: string): Pointer; virtual;

    /// <summary>
    /// Evaluates a published method from a MethodInfo structure returned by GetMethodInfo.
    /// </summary>
    /// <remarks>
    /// This method is used internally by TCustomFlexCelReport to evaluate the user defined functions in the
    /// report. You will normally not need to call or override this method.
    /// </remarks>
    /// <param name="MethodInfo">a MethodInfo structure returned by GetMethodInfo.</param>
    /// <param name="Arguments">A list of arguments to pass to the method we want to evaluate.</param>
    /// <returns>
    /// The result from the method as a variant value.
    /// </returns>
    function GetVariantMethod(const MethodInfo: pointer; const Arguments: string): variant; virtual;

  public
    /// <summary>
    /// \Returns the picture type associated with a given string.
    /// </summary>
    /// <remarks>
    /// FlexCelReport uses this method to find out the type of an image writenn like ##db##field##imgtype.<para></para>
    /// You shouldn't need t call this method.
    /// </remarks>
    /// <param name="s">String with the image type. Might be &quot;WMF&quot;, &quot;EMF&quot;, &quot;PNG&quot;
    ///                 or JPEG&quot;</param>                                                                          
    function GetPictureType(const s: UTF16String): TXlsImgTypes;

    /// <summary>
    /// This method should return the IXlsDataSet associated to a given name.
    /// </summary>
    /// <remarks>
    /// This method is abstract in TCustomFlexCelReport. Descendants should override this method and supply
    /// the correct dataset associated with a name, by looking for it in the DesignDataModule.
    /// </remarks>
    /// <param name="DataSetName">Name of the dataset FlexCel needs. This will be one of the names theuser
    ///                           wrote in &quot;__&quot; ranges or in ##dataset##field tags.</param>      
    function GetDataSet(const DataSetName: string): IXlsDataSet; virtual; abstract;

    /// <summary>
    /// This method should return the IXlsDataSet associated to the PagesDataSet property.
    /// </summary>
    /// <remarks>
    /// This method is abstract in TCustomFlexCelReport. Descendants should override this method and supply
    /// the correct dataset associated with PagesDataSet, by looking for it in the DesignDataModule.
    /// </remarks>
    function GetPagesDataSet: IXlsDataSet; virtual; abstract;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    /// <summary>
    /// Creates a report, using the template defined in the Template property, and outputting it to the file
    /// specified in FileName property.
    /// </summary>
    procedure Run; overload;

    /// <summary>
    /// Creates a report, using the template defined in InStream, and outputting it to the stream specified
    /// in OutStream.
    /// </summary>
    /// <remarks>
    /// This overload of the method is more flexible than the parameter-less one, in that it allows you to
    /// specify a stream for the template and for the generated file. This means you can run the report
    /// directly from a template stored in a database directly to another field in the database without any
    /// temporary file.<para></para>
    /// <para></para>
    /// The values contained in Template or FileName properties are ignored when using this method.
    /// </remarks>
    /// <param name="InStream">Stream containing the template for the report.</param>
    /// <param name="OutStream">Stream where the result will be written.</param>                           
    procedure Run(const InStream, OutStream: TStream); overload;

    /// <summary>
    /// This is equivalent to the &quot;Run&quot; method, but saves the results to a generic stream while
    /// reading the template from the Template property. Use it if you are saving the results to a database,
    /// streaming them to a client or whenever you don't want to generate a physical file.
    /// </summary>
    /// <remarks>
    /// As an alternative, you can use the method <see cref="TCustomFlexCelReport.Run" text="Run" /> without
    /// \parameters and set the OnGetOutStream event, or call the method <see cref="TCustomFlexCelReport.Run@TStream@TStream" text="Run (TStream\, TStream)" />.
    /// </remarks>
    /// <param name="DataStream">Stream where we want to save the report.</param>                                                                               
    procedure SaveToStream(const DataStream: TStream);

    /// <summary>
    /// Cancels a running report.
    /// </summary>
    /// <remarks>
    /// This method is useful when running the report on a thread, to implement a "Cancel" button.<para></para>
    /// For using it, you have to run the report on another thread.<para></para>
    /// See Thread demo for details.
    /// </remarks>
    procedure Cancel;

    /// <summary>
    /// Component containing the databases used for the report.
    /// </summary>
    /// <remarks>
    /// This returns the DataModule or Form containing the TQuery/TTables FlexCel is going to use to create
    /// the report.<para></para>
    /// It is ReadOnly and Abstract on TCustomFlexCelReport. Descendants should override this method and
    /// return the correct value.
    /// Even when the name says &quot;DataModule&quot;, and even when it usually is, it really can be any
    /// component.
    /// </remarks>                                                                                         
    function DesignDataModule: TComponent; virtual;abstract;

    /// <summary>
    /// List of custom values to replace at runtime.
    /// </summary>
    /// <remarks>
    /// This property allows you an easy way to pass values from your code to the report. For example, the
    /// line
    /// 
    /// <code lang="delphi">
    /// FlxReport.Values['Current_Date']:=now;
    /// </code>
    /// 
    /// will replace the tag &quot;#.Current_Date&quot; in the template with today's date.<para></para>
    /// <para></para>
    /// \Note that this property does the same as a published property. If you define both a published
    /// property &quot;Current_date&quot; and a Value['Current_Date'], the Value will be used.<para></para>
    /// <para></para>
    /// You can use this property always that you can use a published property, even with array of variants.<para></para>
    /// 
    /// </remarks>                                                                                                       
    property Values: TFlxPropList read FValues write FValues;

    /// <summary>
    /// Resets the values reported by the Progress property.
    /// </summary>
    /// <remarks>
    /// You shouldn't need to call this method, as it is normally called automatically by the component when
    /// it is needed.
    /// </remarks>
    procedure ClearProgress;

    /// <summary>
    /// \Returns the Progress of the report.
    /// </summary>
    /// <remarks>
    /// In order to use this property you need to run the report i a thread, and update your user interface
    /// with the values reported here.<para></para>
    /// Look at the Treads demo for more information.
    /// </remarks>
    property Progress: TFlxProgress read FProgress;
    { Public declarations }

  published
    /// <summary>
    /// Template that will be used to create the report.
    /// </summary>
    /// <remarks>
    /// When calling <see cref="TCustomFlexCelReport.Run@TStream@TStream" text="TCustomFlexCelReport.Run (TStream\, TStream)" />
    /// this value is not used.<para></para>
    /// <para></para>
    /// Path can (and normally should) be relative. For example, if you set Template:= 'templ\\t1.xls', and
    /// your exe is at c:\\myApp, it will search for the template at 'c:\\myApp\\templ\\t1.xls'.<para></para>
    /// <para></para>
    /// The order in which FlexCel searches for templates is:<para></para>
    /// 1) If the path is an absolute path, it will use it.<para></para>
    /// 2) If Adapter.BasePathToOpen is set, it will use it.
    /// 3) If the path is relative and Adapter.BasePathToOpen is not set, it will first search for it in the folder where the application is.<para></para>
    /// 4) If it couldn't find it, it will search for the template in the folder where the package is, if
    /// FlexCel is in a package. This might be useful if you are running for example in IIS where the the
    /// path for the Application is the path for IIS and not for your dll.<para></para>
    /// <para></para>
    /// The method that does the actual searching is <see cref="SearchPathStr@String" text="SearchPathStr" />,
    /// you can use this method also also when using the API.<para></para>
    /// <para></para>
    /// Using relative paths is very useful for deploying your application to different places. If you
    /// hardcode the path, for example &quot;c:\\xx\\t1.xls', and your user has it at drive d, it won't work.
    /// it you just write t1.xls, it will.<para></para>
    /// <para></para>
    /// If you are using a TemplateStore, FlexCel will use it for the Template, and will not search the
    /// disks. You can still let the path info in the template property, but it will not be used. For
    /// \example, if Template:= 'templ\\t1.xls', FlexCel will search for t1.xls inside the TemplateStore.<para></para>
    ///
    /// </remarks>
    property Template: TFileName read FTemplate write SetTemplate;

    /// <summary>
    /// Name of the file to be created.
    /// </summary>
    /// <remarks>
    /// This property defines the filename that will be used to save the created file, and is also used by
    /// the report designer to open the correct file when you double click a TFlexCelReport component.<para></para>
    /// <para></para>
    /// \Note that if you call <see cref="TCustomFlexCelReport.Run@TStream@TStream" text="TCustomFlexCelReport.Run (TStream\, TStream)" />
    /// this property is not used.<para></para>
    /// 
    /// </remarks>
    /// <example>
    /// For this Demo to Run, drop a TFlexCelReport, a TXlsAdapter, a TButton and a TOpenDialog on a Form.
    /// Connect the XlsAdapter to the FlexCelReport.
    /// 
    /// <code lang="delphi">
    /// procedure TFPrinting.Button1Click(Sender: TObject);
    /// begin
    ///   if OpenDialog1.Execute then
    ///   begin
    ///     FlexCelReport1.Adapter.AllowOverwritingFiles := true;
    ///     FlexCelReport1.FileName:=OpenDialog1.FileName;
    ///     FlexCelReport1.Run;
    ///   end;
    /// end;
    /// </code>
    /// </example>                                                                                                                        
    property FileName: TFileName read FFileName write FFileName;

    /// <summary>
    /// This property is obsolete and has no effect.
    /// </summary>
    property AutoClose: boolean read FAutoClose write FAutoClose;

  published
    /// <summary>
    /// Field for naming the new sheets.
    /// </summary>
    /// <remarks>
    /// This is the name of the field that will be used to name the sheets created. Use this together with <see cref="TFlexCelReport.PagesDataSet" />
    /// to create a report that spans through multiple sheets.<para></para>
    /// 
    /// </remarks>                                                                                                                                   
    property PagesDataField: string read FPagesDataField write SetPagesDataField;

    /// <summary>
    /// Adapter this component will use to create the file.
    /// </summary>
    /// <remarks>
    /// To use a FlexCelReport you need to drop a TXLSAdapter into the Datamodule, and then set this property
    /// to point to it. The adapter is the component that handles the actual file creation, and you need just
    /// one on the Datamodule for all the FlexCelReport components.
    /// </remarks>                                                                                           
    property Adapter: TExcelAdapter read FAdapter write SetAdapter;

    /// <summary>
    /// Toggle between using Field Names/Display Names
    /// </summary>
    /// <remarks>
    /// When true, FlexCel will use the Display Labels of the fields and not the Field Names to populate the
    /// data.<para></para>
    /// <para></para>
    /// Imagine you have a field called &quot;CUST&quot; with display name &quot;CUSTOMER&quot;<para></para>
    /// <para></para>
    /// When UseDisplayNames=true you have to write ##Table1##CUSTOMER at the template.<para></para>
    /// When UseDisplayNames=false you have to write ##Table1##CUST at the template.<para></para>
    /// 
    /// </remarks>                                                                                          
    property UseDisplayNames: boolean read FUseDisplayNames write FUseDisplayNames default false;

    /// <summary>
    /// Determines if to use hidden fields when doing generic reports.
    /// </summary>
    /// <remarks>
    /// When you are doing a generic report (##ds.*) all fields from the dataset will be sent to the report.
    /// With htis property you can control whether to send hidden fields too or not.
    /// </remarks>                                                                                          
    property UseHiddenFields: boolean read FUseHiddenFields write FUseHiddenFields default true;

    /// <summary>
    /// Defines what FlexCelReport must do when a table has no rows.
    /// </summary>
    /// <remarks>
    /// This is normally useful in Master detail reports. When a detail report has no records, you might want
    /// to delete the whole row with the details, or keep an empty row in the report. You can control what to
    /// do with this property.
    /// </remarks>                                                                                           
    property DeleteEmptyRows: boolean read FDeleteEmptyRows write FDeleteEmptyRows default true;

    /// <summary>
    /// Format to be applied to Date Cells, when no format is specified.
    /// </summary>
    /// <remarks>
    /// Excel doesn't have the concept of &quot;Date&quot; datatypes. All dates are just numbers, (the number
    /// of days from 1900) formatted to show as a date.<para></para>
    /// <para></para>
    /// That is, number &quot;1&quot; will stand for &quot;1/1/1900&quot; and number &quot;3.25&quot; (3 days
    /// and 1/4) will stand for &quot;03/01/1900 06:00:00 a.m.&quot;<para></para>
    /// <para></para>
    /// When creating a template, you can specify the date format directly on the template, but when using
    /// generic reporting (##DataSet##*), you don't know which column will hold date values.<para></para>
    /// <para></para>
    /// So, if you specify a format on this property, all the date/time fields of the database on a generic
    /// report will be formatted with this string.<para></para>
    /// <para></para>
    /// The format string is one valid Excel format string, the ones you can see on Excel at
    /// &quot;Edit-&gt;Format-&gt;Cells&quot;<para></para>
    ///
    /// </remarks>
    property DateTimeFormat: string read FDateTimeFormat write FDateTimeFormat;

    /// <summary>
    /// If true and you are inserting pictures from a database, FlexCel will not replace pictures when the
    /// field in the database is null.
    /// </summary>
    /// <remarks>
    /// If this property is false, FlexCel will clear images that don't have a corresponding image in the
    /// database, instead of leaving the placeholder picture you put in the template.
    /// </remarks>
    property KeepEmptyPictures: boolean read FKeepEmptyPictures write FKeepEmptyPictures;

    /// <summary>
    /// Determines how the report will behave when inserting rows.
    /// </summary>
    /// <remarks>
    /// The possible values for this parameter are:
    ///
    /// <xtable columnwidths="30c%">
    /// Value                       Meaning
    /// --------------------------  ------------------------------------------------------------------------------
    /// frm_FullCopyAndInsert       This is the default mode. Rows will be inserted down when filling the bands
    ///                              with the data from the database.
    /// frm_OnlyCopy,               On this mode, rows will be copied down but not inserted when expanding bands.
    ///                              This means that if you have a cell at A15 and a __band__ at A10 with 4
    ///                              records, after running the report Cell A15 will still be at this position. If
    ///                              there are more than 5 records in __band__ then the contents of cell A15 will
    ///                              be overwritten.
    /// frm_DontCopyAndDontInsert   When in this mode, cell will just be filled, no rows will be inserted or
    ///                              copied. This mode can be useful when you want to do &quot;fixed form&quot;
    ///                              \reports, where for example you want to have some text fixed at row 20, and
    ///                              don't want the report to move that row down.
    /// </xtable>
    /// </remarks>
    property ReportModeRows: TFlxReportMode read FReportModeRows write FReportModeRows default frm_FullCopyAndInsert;

    /// <summary>
    /// This property is not currently implemented.
    /// </summary>
    property ReportModeCols: TFlxReportMode read FReportModeCols write FReportModeCols default frm_FullCopyAndInsert;
    //property ImageResize: TFlxImageResize read FImageResize write FImageResize default fli_ResizeNone;

    //Events
    /// <summary>
    /// Occurs before the workbook starts to be generated.
    /// </summary>
    /// <remarks>
    /// This events allows you to do custom modifications to the template before the file is generated.<para></para>
    /// <b>Note: </b>Try not to use this event. Anything you do with code at this point will be fixed inside
    /// your application, and you won't be able to change it without recompiling.<para></para>
    ///
    /// </remarks>
    property OnBeforeGenerateWorkbook: TOnGenerateEvent read FOnBeforeGenerateWorkbook write FOnBeforeGenerateWorkbook;

    /// <summary>
    /// Occurs after the whole workbook is generated.
    /// </summary>
    /// <remarks>
    /// This events allows you to further customize the file after it has been generated.<para></para>
    /// <b>Note: </b>Try not to use this event. Anything you do with code at this point will be fixed inside
    /// your application, and you won't be able to change it without recompiling.
    /// </remarks>
    property OnAfterGenerateWorkbook: TOnGenerateEvent read FOnAfterGenerateWorkbook write FOnAfterGenerateWorkbook;

    /// <summary>
    /// Occurs before each worksheet on the workbook is generated.
    /// </summary>
    /// <remarks>
    /// This events allows you to do custom modifications to the template before each sheet is generated.<para></para>
    /// <b>Note: </b>Try not to use this event. Anything you do with code at this point will be fixed inside
    /// your application, and you won't be able to change it without recompiling.
    /// </remarks>
    property OnBeforeGeneratePage: TOnGeneratePageEvent read FOnBeforeGeneratePage write FOnBeforeGeneratePage;

    /// <summary>
    /// Occurs after each worksheet on the workbook is generated.
    /// </summary>
    /// <remarks>
    /// This events allows you to further customize each sheet after it has been generated.<para></para>
    /// <b>Note: </b>Try not to use this event. Anything you do with code at this point will be fixed inside
    /// your application, and you won't be able to change it without recompiling.
    /// </remarks>
    property OnAfterGeneratePage: TOnGeneratePageEvent read FOnAfterGeneratePage write FOnAfterGeneratePage;

    /// <summary>
    /// Occurs before the file is saved to disk, once for each of each file format generated.
    /// </summary>
    /// <remarks>
    /// You can use this event if saving the report in more than one format. But normally there is no use for
    /// this event.
    /// </remarks>
    /// <example>
    /// <code lang="delphi">
    /// procedure TFTestReport.FlexCelReport1GetFilename(Sender: TObject;
    ///   const FileFormat: Integer; var Filename: TFileName);
    /// begin
    ///   case TExcelSaveFormatNative(FileFormat) of
    ///     snXLS: Filename:=Filename+'.xls';
    ///     snCSVComma: Filename:=Filename+'.csv';
    ///     snCSVSemiColon: Filename:=Filename+'.csv';
    ///     snTabDelimited: Filename:=Filename+'.txt';
    ///   end; //case
    /// end;
    /// </code>
    /// 
    /// </example>                                                                                           
    property OnGetFilename: TOnGetFileNameEvent read FOnGetFileName write FOnGetFileName;

    /// <summary>
    /// Occurs before the report is saved to a stream, once for each of the file formats generated.
    /// </summary>
    /// <remarks>
    /// Use this event to save the report to a stream instead of a file. If you assign OnGetOutStream,
    /// FlexCel won't generate a file, it doesn't matter if you define
    /// filenameUCustomFlexCelReport.TCustomFlexCelReport.FileName or not. Instead, the results will be saved
    /// to the stream you specify on this event, by setting the variable OutStream.<para></para>
    /// <para></para>
    /// <b>Note that is normally easier to call <see cref="TCustomFlexCelReport.SaveToStream@TStream" text="TCustomFlexCelReport.SaveToStream" />
    /// directly, and not using this event.</b><para></para>
    /// 
    /// </remarks>                                                                                                                               
    property OnGetOutStream: TOnGetOutStreamEvent read FOnGetOutStream write FOnGetOutStream;

    /// <summary>
    /// Occurs before a cell from the template is filled with a value.
    /// </summary>
    /// <remarks>
    /// This event is fired before each value is written to the Excel sheet. You can modify that value here.<para></para>
    /// This can be useful to avoid defining Calculated fields on the dataset.<para></para>
    /// <para></para>
    /// <b>Note</b>: This event has been obsoleted by OnGetCellValueXRow.
    /// </remarks>
    /// <param name="Sender">FlexCelReport component sending the event.</param>
    /// <param name="FieldName">Field name that is being read.</param>
    /// <param name="FieldValue">Value for the field. This variable contains the value read from the
    ///                          database, and you can modify it to a new value.</param>                                 
    property OnGetCellValue: TOnGetCellValue read FOnGetCellValue write FOnGetCellValue;

    /// <summary>
    /// Occurs before a cell from the template is filled with a value.
    /// </summary>
    /// <remarks>
    /// This event is fired before each value is written to the Excel sheet. You can modify that value here.<para></para>
    /// This can be useful to avoid defining Calculated fields on the dataset.<para></para>
    /// <para></para>
    /// <b>Note</b>: This event has been obsoleted by OnGetCellValueXRow.
    /// </remarks>
    /// <param name="Sender">FlexCelReport component sending the event.</param>
    /// <param name="ExcelApp">XlsAdapter used by the report.</param>
    /// <param name="FieldName">Field name that is being read.</param>
    /// <param name="FieldValue">Value for the field. This variable contains the value read from the
    ///                          database, and you can modify it to a new value.</param>
    /// <param name="XF">Format for the cell. It contains the default XF that will be assigned to
    ///                  the cell, but you can change it here. (By using ExcelApp.AddFormat)</param>                     
    property OnGetCellValueX: TOnGetCellValueX read FOnGetCellValueX write FOnGetCellValueX;

    /// <summary>
    /// Occurs before a cell from the template is filled with a value.
    /// </summary>
    /// <remarks>
    /// This event is fired before each value is written to the Excel sheet. You can modify that value here.<para></para>
    /// This can be useful to avoid defining Calculated fields on the dataset.<para></para>
    /// <para></para>
    /// <b>Note</b>: This event obsoletes both OnGetCellValue and OnGetCellValueX. Newer code should use this
    /// event instead of the other two.
    /// </remarks>
    /// <param name="Sender">FlexCelReport component sending the event.</param>
    /// <param name="ExcelApp">XlsAdapter used by the report.</param>
    /// <param name="FieldName">Field name that is being read.</param>
    /// <param name="FieldValue">Value for the field. This variable contains the value read from the
    ///                          database, and you can modify it to a new value.</param>
    /// <param name="XF">Format for the cell. It contains the default XF that will be assigned to
    ///                  the cell, but you can change it here. (By using ExcelApp.AddFormat)</param>
    /// <param name="Row">Row of the cell where the value is being replaced.</param>
    /// <param name="Col">Column of the cell where the value is being replaced.</param>                                  
    property OnGetCellValueXRow: TOnGetCellValueXRow read FOnGetCellValueXRow write FOnGetCellValueXRow;

    /// <summary>
    /// Occurs when progress is made in the template.
    /// </summary>
    /// <remarks>
    /// this event can be a simple way to get feedback for your reports, but the recommended way to do this
    /// if you have reports that take a considerable time to execute is to run the reports from athread and
    /// use the Progress property to update the user interface.<para></para>
    /// Using this eevnt will probably result in a non responsive application.<para></para>
    /// 
    /// </remarks>                                                                                         
    property OnProgress: TOnFlxProgressEvent read FOnProgress write FOnProgress;

    /// <summary>
    /// Occurs before an image is replaced.
    /// </summary>
    /// <remarks>
    /// You can modify the image properties and image that is being replaced here.
    /// </remarks>
    /// <param name="Sender">FlexCelReport component sending the event.</param>
    /// <param name="ExcelApp">XlsAdapter used by the report.</param>
    /// <param name="FieldName">Field that contains the image.</param>
    /// <param name="FieldType">Type of the image that will be inserted.</param>
    /// <param name="ImageData">Stream with the data for the image. You can modify this value to assign a
    ///                         different image, but remember to set the position of the stream to 0 before
    ///                         writing new data.</param>
    /// <param name="Row">Row of the cell where the image will be placed. You can modify this value.</param>
    /// <param name="Col">Column of the cell where the image will be placed. You can modify this value</param>
    /// <param name="Height">Height in pixels of the new image. If you don't modify this value the image
    ///                      dimensions will be the same as the image in the template.</param>
    /// <param name="Width">Width in pixels of the new image. If you don't modify this value the image
    ///                     dimensions will be the same as the image in the template.</param>                 
    property OnGetImageSize: TOnGetImageSize read FOnGetImageSize write FOnGetImageSize;
    { Published declarations }
  end;

  ClassOfTCustomFlexCelReport= class of TCustomFlexCelReport;

implementation

uses Math;

{ TCustomFlexCelReport }

constructor TCustomFlexCelReport.Create(AOwner: TComponent);
begin
  inherited;
  FValues:=TFlxPropList.Create;
  FUseDisplayNames:=false;
  FUseHiddenFields:=true;
  FDeleteEmptyRows:=true;
  FDateTimeFormat:=DefaultDateTimeFormat;
  FReportModeRows:=frm_FullCopyAndInsert;
  FReportModeCols:=frm_FullCopyAndInsert;
  FProgress:=TFlxProgress.Create(Self);
  FKeepEmptyPictures := false;
  ClearProgress;
end;

destructor TCustomFlexCelReport.Destroy;
begin
  FreeAndNil(FProgress);
  FreeAndNil(FValues);
  inherited;
end;

procedure TCustomFlexCelReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FAdapter then
        FAdapter:= nil;
  end;
end;

//----------------------------------------------------------------------------//
procedure TCustomFlexCelReport.InsertSheets(const FirstPage: integer);
var
  Rc: integer;
begin
  LazyDbList.Check(GetPagesDataSet);
  if GetPagesDataSet=nil then Rc:=1 else Rc:= GetPagesDataSet.RecordCount;
  if (Rc<=0) then Raise Exception.Create(ErrTooManySheets);
  if (Rc>250) then Raise Exception.Create(ErrTooManySheets);
  Workbook.InsertAndCopySheets(FirstPage, FirstPage+1, Rc-1);
end;

//Ranges containing '!' (like "'Sheet1'!Name") are special in Excel, they are local and refer to just one page
function TCustomFlexCelReport.IsDBName(s: UTF16String): boolean;
begin
   if pos('!',s)>0 then delete(s,1,pos('!',s));
   Result:=(copy(s,1,length(DataSetStr))=DataSetStr);
end;

function TCustomFlexCelReport.GetDataSetFromName(s: UTF16String): WideStringArray;
begin
   if pos('!',s)>0 then delete(s,1,pos('!',s));

   SetLength(Result,0);
   s:=copy(s,length(DataSetStr)+1,Length( s));
   while pos(DataSetStr, s)>0 do
   begin
     SetLength(Result, Length(Result)+1);
     Result[Length(Result)-1]:=copy(s,1,pos(DataSetStr,(s+DataSetStr))-1);
     delete(s,1,Length(Result[Length(Result)-1])+length(DataSetStr));
   end;
end;

function TCustomFlexCelReport.FindSubBands(const StartRow, EndRow: integer): TExcelBandList;
var
  b: TExcelBand;
begin
  Result:=TExcelBandList.Create(true);
  b:= FindBands(StartRow, EndRow);
  while b<>nil do
  begin
    Result.Add(b);
    b:=FindBands(b.EndRow+1, EndRow); //Search for all the ranges below the one we found. The ones inside will be subbands of it, not of the parent
  end;
end;

procedure TCustomFlexCelReport.FillBandValueList(const RangePos: integer);
var
  i, k, rl, R1, R2, C1, C2: integer;
  v: TXlsCellValue;
  FirstColumn: integer;
  RTFRuns: TRTFRunList;
begin
  FirstColumn:=Workbook.GetFirstColumn;
  R1:=Workbook.RangeR1[RangePos];
  R2:=Workbook.RangeR2[RangePos];
  C1:=Workbook.RangeC1[RangePos];
  C2:=Workbook.RangeC2[RangePos];
  SetLength(ValueCache, R2-R1+1);
  for i:=0 to Length(ValueCache)-1 do
  begin
    SetLength(ValueCache[i].Cols, C2-C1+1); //This is the maximum. Later we adjust it to what we use
    if FReportModeRows = frm_DontCopyAndDontInsert then
    begin
      ValueCache[i].XF:=Workbook.RowFormat[R1+i];
      ValueCache[i].Height:=Workbook.RowHeight[R1+i];
      ValueCache[i].AutoHeight:=Workbook.AutoRowHeight[R1+i];
      ValueCache[i].Hidden:=Workbook.RowHidden[R1+i];
    end;
    rl:=0;
    for k:=0 to Length(ValueCache[i].Cols)-1 do
    begin
      Workbook.GetCellDataX2(R1+i, k+C1-FirstColumn,v ,RTFRuns);
      if ((v.XF>=0) or (not VarIsEmpty(v.Value))) and (not v.IsFormula) then
      begin
        ValueCache[i].Cols[rl]:= GetBandValue(v.Value, k+C1-FirstColumn, v.XF, RTFRuns);
        inc(rl);
      end;
    end;
    SetLength(ValueCache[i].Cols, rl); //shrink empty values
  end;

end;


function TCustomFlexCelReport.FindBands(const StartRow, EndRow: integer): TExcelBand;
var
  i, St, En, sRow, eRow, First:integer;
  DataName: WidestringArray;
begin
  St:=EndRow; First:=-1;
  for i:=1 to Workbook.RangeCount do
  if IsDBName(Workbook.RangeName[i]) and
     (Workbook.RangeSheet[i]= Workbook.ActiveSheet) then
  begin
    //Search For the lowest row
    sRow:= Workbook.RangeR1[i];
    eRow:= Workbook.RangeR2[i];
    if (sRow>=StartRow)and
      (sRow<=St) and (eRow<=EndRow) and
      ((sRow<>StartRow) or (eRow<>EndRow))//do not process itself
       then begin;St:=sRow; First:=i;end;
  end;
  if First<0 then Begin; Result:=nil;exit;end;

  //Now search for the biggest range starting on St
  en:=St;First:=-1;
  for i:=1 to Workbook.RangeCount do
  if IsDBName(Workbook.RangeName[i]) and
     (Workbook.RangeSheet[i]= Workbook.ActiveSheet) then
  begin
    sRow:= Workbook.RangeR1[i];
    eRow:= Workbook.RangeR2[i];
    if (sRow=St)and
      (eRow>=En) and (eRow<=EndRow) and
      ((sRow<>StartRow) or (eRow<>EndRow))//do not process itself
       then begin; En:=eRow; First:=i;end;
  end;

  Result:=TExcelBand.Create;
  Result.StartRow:=St;
  Result.EndRow:=En;
  Result.RangePos:=First;
  SetLength(DataName,0);
  DataName:=GetDataSetFromName(Workbook.RangeName[First]);
  SetLength(Result.DataSet,Length(DataName));
  for i:=0 to length(DataName)-1 do Result.DataSet[i]:=GetDataSet(DataName[i]);
  Result.SubBands:=FindSubBands(St,En);
end;


procedure TCustomFlexCelReport.ReadTemplate(out MainBand: TExcelBand);
begin
  //Find the Bands
  MainBand:=FindBands(1, 65535);
  if MainBand=nil then exit; //nothing to do in this page
  Workbook.SetBounds(MainBand.RangePos);
  if Workbook.CanOptimizeRead then FillBandValuelist(MainBand.RangePos);
end;

function TCustomFlexCelReport.BandIsNil(const Ds: TDataSetArray): boolean;
var
  i: integer;
begin
  Result:=true;
  for i:=0 to length(Ds)-1 do if (Ds[i]<>nil )then Result:=false;
end;

function TCustomFlexCelReport.BandEof(const Ds: TDataSetArray;var FirstRecord: boolean): boolean;
var
  i: integer;
begin
  Result:=true;
  if not DeleteEmptyRows and FirstRecord then
  begin
    Result:=false;
    FirstRecord:=false;
    exit;
  end;

  for i:=0 to length(Ds)-1 do
    if (Ds[i]<>nil ) and (not Ds[i].Eof) then Result:=false;
end;

procedure TCustomFlexCelReport.BandMoveFirst(const Ds: TDataSetArray);
var
  i: integer;
begin
  for i:=0 to length(Ds)-1 do if Ds[i]<>nil then Ds[i].First;
end;

procedure TCustomFlexCelReport.BandMoveNext(const Ds: TDataSetArray);
var
  i: integer;
begin
  for i:=0 to length(Ds)-1 do if (Ds[i]<>nil) and not (Ds[i].Eof) then Ds[i].Next;
  inc (FProgress.FCounter);
  if Assigned(OnProgress) and (FProgress.Counter mod 10=0) then OnProgress(Self, FProgress, Canceled);
end;

procedure TCustomFlexCelReport.CopyStructure(const Band: TExcelBand; var RowOffset: integer);
var
  RealOldRangeCount: integer;
  k:integer;
  DataRecordCount, DataRecCount: integer;
  FirstRecord: boolean;
begin
    if Canceled then exit;

    //Insert the new Cells
    if DeleteEmptyRows then DataRecordCount:=0 else DataRecordCount:=1;
    for k:=0 to Length(Band.DataSet)-1 do
    begin
      LazyDbList.Check(Band.DataSet[k]);
      if Band.DataSet[k]=nil then DataRecCount:=1 else DataRecCount:=Band.DataSet[k].RecordCount;
      if DataRecCount>DataRecordCount then DataRecordCount:=DataRecCount;
    end;
    BandMoveFirst(Band.DataSet);

    //insert/delete the corresponding rows
    RealOldRangeCount:=Band.EndRow - Band.StartRow+1;  //in RealOldRangeCount we store the row count without the subbands
    for k:=0 to Band.SubBands.Count-1 do Dec(RealOldRangeCount,(Band.SubBands[k] as TExcelBand).EndRow-(Band.SubBands[k] as TExcelBand).StartRow+1);

    if DataRecordCount - 1 > 0 then
    begin
      Workbook.InsertAndCopyRows(Band.StartRow+RowOffset, Band.EndRow+RowOffset, Band.EndRow+1+RowOffset, DataRecordCount - 1, Workbook.CanOptimizeRead);
    end else
    if DataRecordCount - 1 < 0 then //We must delete the line
    begin
      Workbook.DeleteRows(Band.StartRow+RowOffset, Band.EndRow-Band.StartRow+1);
    end;

    // SubBands
    if Band.SubBands.Count>0 then
    begin
      FirstRecord:=true;
      while BandIsNil(Band.DataSet) or (not BandEof(Band.DataSet, FirstRecord)) do
      begin
        for k:=0 to Band.SubBands.Count-1 do
        begin
          CopyStructure(Band.SubBands[k] as TExcelBand, RowOffset);
          dec(RowOffset, TExcelBand(Band.SubBands[k]).EndRow-TExcelBand(Band.SubBands[k]).StartRow+1); //Compensate the extra line in the ranges
        end;

        for k:=0 to Band.SubBands.Count-1 do
          inc(RowOffset, TExcelBand(Band.SubBands[k]).EndRow-TExcelBand(Band.SubBands[k]).StartRow+1); //Restore the extra line for the next record

        inc(RowOffset,RealOldRangeCount);  //not just the total range, because the Subbands have already incremented their part.
        if not BandIsNil(Band.DataSet) then BandMoveNext(Band.DataSet) else break;
      end;
    end else inc(RowOffset, RealOldRangeCount*DataRecordCount);

    BandMoveFirst(Band.DataSet);
end;

function TCustomFlexCelReport.GetPictureType(const s: UTF16String): TXlsImgTypes;
var
  Id: string;
begin
  Id:=UpperCase(s);
  if pos(FieldStr,Id)<> 0 then
  begin; //is a db image
    while pos(FieldStr,Id)>0 do Delete(Id, 1, pos(FieldStr,Id)+Length(FieldStr)-1 );
    if Id= xls_Wmf then Result:= xli_Wmf else
    if Id= xls_Emf then Result:= xli_Emf else
    if Id= xls_Png then Result:= xli_Png else
    if Id= xls_Jpeg then Result:= xli_Jpeg else
    raise Exception.CreateFmt(ErrInvalidDrawingType, [Id]);
  end else
  if pos(VarStr,Id)<> 0 then
  begin; //is a prop image
    while pos(VarStr,Id)>0 do Delete(Id, 1, pos(VarStr,Id)+Length(VarStr)-1 );
    if Id= xls_Wmf then Result:= xli_Wmf else
    if Id= xls_Emf then Result:= xli_Emf else
    if Id= xls_Png then Result:= xli_Png else
    if Id= xls_Jpeg then Result:= xli_Jpeg else
    raise Exception.CreateFmt(ErrInvalidDrawingType, [Id]);
  end else
  begin  //Is not an image to replace
    Result:=xli_Jpeg;
  end;
end;

function TCustomFlexCelReport.SupressCR(const s: UTF16String): UTF16String;
var
  i,k: integer;
begin
  SetLength(Result,Length(s));
  k:=1;
  for i:=1 to Length(s) do if s[i]<>#13 then
  begin
    Result[k]:=s[i];
    inc(k);
  end;

  SetLength(Result, k-1);
end;


procedure TCustomFlexCelReport.GetMultiDimArray(var v: variant; PropIndex: string; const VarName: string);
var
  p:^VariantArray;
  u: variant;
  i, k, abs, LastDim: integer;
begin
  abs:=0;
  k:=1;
  LastDim:=1;
  while PropIndex<>'' do
  begin
    i:=StrToInt(Copy(PropIndex,1,Pos(VarStr,PropIndex+VarStr)-1));
    Delete(PropIndex,1,Pos(VarStr,PropIndex+VarStr)+Length(VarStr)-1);
    if k> VarArrayDimCount(v) then raise exception.CreateFmt(ErrTooManyDimensions,[VarName, VarArrayDimCount(v)]);
    if (i<VarArrayLowBound(v,k)) or (i>VarArrayHighBound(v,k)) then raise Exception.CreateFmt(ErrIndexOutBounds, [i, VarName,VarArrayLowBound(v,k),VarArrayHighBound(v,k)]);

    inc(abs, (i-VarArrayLowBound(v,k))* LastDim);
    LastDim:=LastDim* (VarArrayHighBound(v,k)-VarArrayLowBound(v,k)+1);
    inc(k);
  end;

  u:=null;
  p:=VarArrayLock(v);
  try
    u:=(p[abs]);
  finally
    VarArrayUnlock(v);
  end;

  v:=u;
end;


procedure TCustomFlexCelReport.GetOneDimArray(var v: variant; PropIndex: string; const VarName: string);
var
  i: integer;
begin
  while PropIndex<>'' do
  begin
    i:=StrToInt(Copy(PropIndex,1,Pos(VarStr,PropIndex+VarStr)-1));
    Delete(PropIndex,1,Pos(VarStr,PropIndex+VarStr)+Length(VarStr)-1);
    if (i<VarArrayLowBound(v,1)) or (i>VarArrayHighBound(v,1)) then raise Exception.CreateFmt(ErrIndexOutBounds, [i, VarName,VarArrayLowBound(v,1),VarArrayHighBound(v,1)]);
    v:=v[i];
  end;
end;


function TCustomFlexCelReport.GetOneBandValue(const v:Variant; const ColOffset: integer; const XF: integer; const RTFRuns: TRTFRunList; const RTFOfs: integer): TOneBandValue;
var
  Ds: IXlsDataSet;
  DsName, FieldName: string;
  VarName, PropIndex: string;
  s: UTF16String;
  vval: variant;
  i,k, RTFCount: integer;
begin
  Result.ValueType:=flv_Const;
  Result.Value.Value:=v;
  Result.Value.XF:=XF;
  Result.CellValue:=v;
  Result.ColOffset:= ColOffset;

  s:=v;
  if copy(s,1,Length(FieldStr))=FieldStr then //It's a field from the database
  begin
    DsName:=copy(s,Length(FieldStr)+1, Length(s));
    DsName:=copy(DsName,1, pos(FieldStr,DsName)-1);
    Ds:=GetDataSet(DsName);
    if Ds=nil then Raise Exception.CreateFmt(ErrNoDataSet,[DsName]);
    FieldName:=copy(s,1+length(DsName)+length(FieldStr)*2,length(s));
    FieldName:=copy(FieldName, 1, pos(FieldStr, FieldName+FieldStr)-1);
    if FieldName= FullDataSetStr then
    begin
      Result.ValueType:=flv_FullDataSet;
      Result.Value.Value:=unassigned;
    end else
    begin
      LazyDbList.Check(Ds);
      Result.ValueType:= flv_Field;
      Result.Field:=Ds.FieldByName(FieldName);
      Result.DataSet:=Ds;
    end;

  end else
  if copy(s,1,Length(VarStr))=VarStr then  //It's a Property of the datamodule or a 'Value' prop
  begin
    VarName:=copy(s,Length(VarStr)+1, Length(s));
    vval:=Values[copy(VarName,1,Pos(VarStr, VarName+VarStr)-1)];

    PropIndex:='';
    if Pos(VarStr, VarName)<>0 then//It's a Prop with Subindexs
    begin
      PropIndex:=copy(VarName,Pos(VarStr, VarName)+ Length(VarStr), Length(VarName));
      VarName:=copy(VarName,1,Pos(VarStr, VarName)-1);
    end;

    Result.PropIndex:= PropIndex;
    Result.VarName:= VarName;

    if not VarisEmpty(vval) then
    begin  //Is a 'Value'
      Result.ValueType:=flv_Value;
      Result.Value.Value:=vval;
    end
    else
    begin  //is a prop
      Result.ValueType:= flv_Property;
      Result.PropInfo:=GetPropertyInfo(VarName);
      if Result.PropInfo=nil then
      begin
        Result.MethodInfo:= GetMethodInfo(VarName);
        Result.ValueType:= flv_Method;

        if Result.MethodInfo = nil then raise exception.CreateFmt(ErrNoPropDefined,[VarName]);
      end;
    end;
  end;

  RTFCount:=0;
  for i:=0 to Length(RTFRuns)-1 do
    if (RTFRuns[i].FirstChar-RTFOfs>=0)and(RTFRuns[i].FirstChar-RTFOfs<Length(VariantToString(v))) then inc (RTFCount);
  SetLength(Result.RTFRuns, RTFCount);
  k:=0;
  for i:=0 to Length(RTFRuns)-1 do
  begin
    if (RTFRuns[i].FirstChar-RTFOfs>=0)and(RTFRuns[i].FirstChar-RTFOfs<Length(VariantToString(v))) then
    begin
      Result.RTFRuns[k]:=RTFRuns[i];
      dec(Result.RTFRuns[k].FirstChar, RTFOfs);
      inc(k)
    end;
  end;
end;

function TCustomFlexCelReport.GetBandValue(const v: Variant; const ColOffset: integer; const XF: integer; const RTFRuns: TRTFRunList): TBandValue;
var
  s: UTF16String;
  p1,p2, p: integer;
  sLen: integer;
begin
  SetLength(Result,1);
  s:=v;
  sLen:=Length(s);

  repeat
    p:=pos(StrOpen+FieldStr,s);
    p2:=pos(StrOpen+VarStr,s);
    if (p2>0) and ((p<=0)or(p2<p)) then p:=p2;

    if p=1 then
    begin
      p1:=pos(StrClose,s);
      if p1<=0 then raise Exception.CreateFmt(ErrInvalidField,[]);
      Result[Length(Result)-1]:=GetOneBandValue(copy(s,Length(StrOpen)+1,p1-1-Length(StrOpen)), ColOffset, XF, RTFRuns, sLen-Length(s));
      s:=copy(s,p1+1,Length(s));
    end else
    if p>0 then
    begin
      Result[Length(Result)-1]:=GetOneBandValue(copy(s,1,p-1), ColOffset, XF, RTFRuns, sLen-Length(s));
      s:=copy(s,p,Length(s));
    end else
    begin
      if Length(Result)<=1 then
        Result[Length(Result)-1]:=GetOneBandValue(v, ColOffset, XF, RTFRuns, sLen-Length(s))
      else
        Result[Length(Result)-1]:=GetOneBandValue(s, ColOffset, XF, RTFRuns, sLen-Length(s));

      s:='';
    end;

    if s<>'' then SetLength(Result,Length(Result)+1);
  until s='';
end;

function TCustomFlexCelReport.GetOneValue(const BandValue: TBandValue; const RowOffset, col: integer; const i: integer; var RTFRuns: TRTFRunList; const RTFLen: integer): variant;
var
  Field: IXlsField;
  z,k: integer;
  IncludeRTF: boolean;
begin
  IncludeRTF:=false;
  case BandValue[i].ValueType of
    flv_Const:
    begin
      Result:=BandValue[i].Value.Value;
      IncludeRTF:=true;
    end;
    flv_Field:
    begin
        Field:=BandValue[i].Field;
        if BandValue[i].DataSet.Eof then Result:=Unassigned else
        if Field.IsTDateTimeField then
          if VarisEmpty(Field.Value) or VarIsNull(Field.Value) then
            Result:=Unassigned
            else Result:= Field.AsFloat
        else
        //There are problems if we assign v:=Field.Value to a TDateTimeField, the result is a string and has problems with the locales
        //Remember to format the cell in the excel template as Date.
        if Field.IsTMemoField then Result:= SupressCR(VariantToString(Field.Value)) else
        Result:=Field.Value;
        if Assigned(FOnGetCellValue) then FOnGetCellValue(Self, BandValue[i].CellValue, Result);
        IncludeRTF:=true;
    end;

    flv_Method:
    begin
      try
        Result:=GetVariantMethod(BandValue[i].MethodInfo, BandValue[i].PropIndex);
      except
        raise exception.CreateFmt(ErrBadProp,[BandValue[i].VarName]);
      end; //except
      if Assigned(FOnGetCellValue) then FOnGetCellValue(Self, BandValue[i].CellValue, Result);
      //if VarType(Result)=varDate then Result:=VarAsType(Result, varDouble); //Convert dates into numbers

      IncludeRTF:=true;
    end;

    flv_Property, flv_Value:
    begin
        if BandValue[i].ValueType=flv_Property then
      begin
        try
            Result:=GetVariantProperty(BandValue[i].PropInfo);
        except
            raise exception.CreateFmt(ErrBadProp,[BandValue[i].VarName]);
        end; //except
      end
        else Result:=BandValue[i].Value.Value;

        if (VarType(Result) <> (varArray or varByte)) then  //Arrays of byte are used for image data.
        begin
          if VarArrayDimCount(Result)>1 then GetMultiDimArray(Result, BandValue[i].PropIndex, BandValue[i].VarName) else
          if VarArrayDimCount(Result)=1 then GetOneDimArray(Result, BandValue[i].PropIndex, BandValue[i].VarName);
        end;

      if Assigned(FOnGetCellValue) then FOnGetCellValue(Self, BandValue[i].CellValue, Result);
      //if VarType(Result)=varDate then Result:=VarAsType(Result, varDouble); //Convert dates into numbers

      IncludeRTF:=true;
    end;

    flv_FullDataset:
    begin
        FullDataSets.Add(TFullDataSet.Create(BandValue[i].CellValue, RowOffset, Col));
      Result:=Unassigned;
    end;
    else Result:=Unassigned;
  end; //case

  if IncludeRTF then
  begin
    k:=Length(RTFRuns);
    SetLength(RTFRuns, k+Length(BandValue[i].RTFRuns)); //maximum length
    for z:=0 to Length(BandValue[i].RTFRuns)-1 do
    begin
      if BandValue[i].RTFRuns[z].FirstChar<Length(VariantToString(Result)) then
      begin
        RTFRuns[k]:=BandValue[i].RTFRuns[z];
        inc(RTFRuns[k].FirstChar, RTFLen);
        inc(k);
      end;
    end;
    SetLength(RTFRuns, k);
  end;

end;

function TCustomFlexCelReport.GetValue(const BandValue: TBandValue; const RowOffset, col: integer; out RTFRuns: TRTFRunList): variant;
var
  i:integer;
begin
  Result:=unassigned;
  SetLength(RTFRuns,0);
  if Length(BandValue)=1 then Result:=GetOneValue(BandValue, RowOffset, col, 0, RTFRuns,0)
  else if Length(BandValue)>1 then
  begin
    Result:='';
    for i:=0 to Length(BandValue)-1 do
      Result:=Result+VariantToString(GetOneValue(BandValue, RowOffset, col, i, RTFRuns, Length(Result)));
  end;
end;

procedure TCustomFlexCelReport.FillFullDatasets;
var
  Ds: IXlsDataSet;
  DsName: string;
  i,k, fds, fds2, f, Col: integer;
  Rc: integer;
  FullDs: TFullDataSet;
  Fmt: TFlxFormat;
  CV: TXlsCellValue;
begin
  for fds:=0 to FullDataSets.Count-1 do
  begin
    FullDs:= FullDataSets[fds];
    DsName:=copy(FullDs.Text,Length(FieldStr)+1, Length(FullDs.Text));
    DsName:=copy(DsName,1, pos(FieldStr,DsName)-1);
    Ds:=GetDataSet(DsName);
    if Ds=nil then Raise Exception.CreateFmt(ErrNoDataSet,[DsName]);

    LazyDbList.Check(Ds);
    if Ds=nil then Rc:=1 else Rc:=Ds.RecordCount;
    Ds.First;

    if FReportModeRows <> frm_DontCopyAndDontInsert then
    begin
      if Rc>0 then
        Workbook.InsertAndCopyRows(FullDs.RowOffset+2, FullDs.RowOffset+2, FullDs.RowOffset+3, Rc-1, false)
      else
        Workbook.DeleteRows(FullDs.RowOffset+2,1);

      for fds2:=fds+1 to FullDataSets.Count-1 do // insert rows into next FullDataSets
        if FullDataSets[fds2].RowOffset>FullDs.RowOffset then inc(FullDataSets[fds2].RowOffset, Rc-1);
    end;

    Workbook.PrepareBlockData(FullDs.RowOffset+1, FullDs.Col, FullDs.RowOffset+1+Rc+1-1, FullDs.Col+Ds.FieldVisibleCount-1);
    Col:=FullDs.Col;
    for i:= FullDs.Col to FullDs.Col + Ds.FieldCount-1 do
      if FUseHiddenFields or Ds.Fields[i-FullDs.Col].Visible then
      begin
        Workbook.AssignBlockData(FullDs.RowOffset+1, Col, Ds.Fields[i-FullDs.Col].DisplayName);
        inc(Col);
      end;

    for k:=1 to Rc do
    begin
      if Canceled then exit;
      Col:=FullDs.Col;
      for i:= FullDs.Col to FullDs.Col + Ds.FieldCount-1 do
      begin
        if (not FUseHiddenFields and not Ds.Fields[i-FullDs.Col].Visible) then continue;
        if Ds.Fields[i-FullDs.Col].IsTMemoField then
        begin
          if (Workbook.CanOptimizeRead) then
          begin
            CV.Value:=SupressCR(Ds.Fields[i-FullDs.Col].Value);
            CV.XF:=Workbook.GetCellDataX(FullDs.RowOffset+1+k, Col).XF;
            if Assigned(FOnGetCellValueX) then FOnGetCellValueX(Self, Workbook ,Ds.Fields[i-FullDs.Col].DisplayName, CV.Value, CV.XF);
            if Assigned(FOnGetCellValueXRow) then FOnGetCellValueXRow(Self, Workbook ,Ds.Fields[i-FullDs.Col].DisplayName, CV.Value, CV.XF, FullDs.RowOffset+1+k, Col );
            Workbook.AssignCellDataX(FullDs.RowOffset+1+k, Col, CV);
          end else
            Workbook.AssignBlockData(FullDs.RowOffset+1+k, Col, SupressCR(Ds.Fields[i-FullDs.Col].Value));
        end else
        //Convert dates into numbers, and format the cell as date with the DateTimeFormat property
        if (Ds.Fields[i-FullDs.Col].IsTDateTimeField) and (Workbook.CanOptimizeRead) and not VarIsNull(Ds.Fields[i-FullDs.Col].Value)  then
        begin
          f:=Workbook.GetCellDataX(FullDs.RowOffset+1+k, Col).XF;
          if f>=0 then Fmt:=Workbook.FormatList[f] else Fmt:=Workbook.FormatList[0];
          if trim(FDateTimeFormat)='' then Fmt.Format:=DefaultDateTimeFormat else Fmt.Format:=FDateTimeFormat;
          CV.Value:=Ds.Fields[i-FullDs.Col].AsFloat;
          CV.XF:=Workbook.AddFormat(Fmt);
          if Assigned(FOnGetCellValueX) then FOnGetCellValueX(Self, Workbook, Ds.Fields[i-FullDs.Col].DisplayName, CV.Value, CV.XF);
          if Assigned(FOnGetCellValueXRow) then FOnGetCellValueXRow(Self, Workbook ,Ds.Fields[i-FullDs.Col].DisplayName, CV.Value, CV.XF, FullDs.RowOffset+1+k, Col );
          Workbook.AssignCellDataX(FullDs.RowOffset+1+k, Col, CV);
        end
        else
          if (Workbook.CanOptimizeRead) then
          begin
            CV.Value:=Ds.Fields[i-FullDs.Col].Value;
            CV.XF:=Workbook.GetCellDataX(FullDs.RowOffset+1+k, Col).XF;
            if Assigned(FOnGetCellValueX) then FOnGetCellValueX(Self, Workbook, Ds.Fields[i-FullDs.Col].DisplayName, CV.Value, CV.XF);
            if Assigned(FOnGetCellValueXRow) then FOnGetCellValueXRow(Self, Workbook ,Ds.Fields[i-FullDs.Col].DisplayName, CV.Value, CV.XF, FullDs.RowOffset+1+k, Col );
            Workbook.AssignCellDataX(FullDs.RowOffset+1+k, Col, CV);
          end else
            Workbook.AssignBlockData(FullDs.RowOffset+1+k, Col, Ds.Fields[i-FullDs.Col].Value);
        inc(Col);
      end;
      Ds.Next;
    end;
    Workbook.PasteBlockData;
  end;
end;

procedure TCustomFlexCelReport.ReplaceValues(const Band: TExcelBand;const Rof: integer; var RowOffset: integer);
var
  j:integer;
  CV: TXlsCellValue;
  v:Variant;
  RTFRuns: TRTFRunList;
begin
  if Workbook.CanOptimizeRead then
  begin
    {if FReportModeRows = frm_DontCopyAndDontInsert then
    begin
      Workbook.RowFormat[RowOffset+1]:=ValueCache[Rof].XF;
      Workbook.RowHeight[RowOffset+1]:=ValueCache[Rof].Height;
      Workbook.AutoRowHeight[RowOffset+1]:=ValueCache[Rof].AutoHeight;
      Workbook.RowHidden[RowOffset+1]:=ValueCache[Rof].Hidden;
    end;
    }
    for j:=0 to Length(ValueCache[Rof].Cols)-1 do
    begin
      CV.Value:=GetValue(ValueCache[Rof].Cols[j], RowOffset, ValueCache[Rof].Cols[j][0].ColOffset, RTFRuns);
      CV.XF:=ValueCache[Rof].Cols[j][0].Value.XF;

      if ValueCache[Rof].Cols[j][0].ValueType<> flv_FullDataSet then
      begin
        if (ValueCache[Rof].Cols[j][0].ValueType<>flv_Const) then
        begin
          if Assigned(FOnGetCellValueX) then
            FOnGetCellValueX(Self, Workbook, ValueCache[Rof].Cols[j][0].CellValue, CV.Value, CV.XF);
          if  Assigned(FOnGetCellValueXRow) then
            FOnGetCellValueXRow(Self, Workbook, ValueCache[Rof].Cols[j][0].CellValue, CV.Value, CV.XF, RowOffset+1, ValueCache[Rof].Cols[j][0].ColOffset);
          end;
        Workbook.AssignCellDataX2(RowOffset+1, ValueCache[Rof].Cols[j][0].ColOffset, CV, RTFRuns);
      end;
    end
  end else

  begin
  for j:=0 to Workbook.CellCount(RowOffset+1)-1 do
  begin
    v:=Workbook.GetCellData(RowOffset+1,j);
      if not VarIsEmpty(v) then Workbook.AssignCellData(RowOffset+1, j, GetValue(GetBandValue(v, j, -1, nil), RowOffset, j, RTFRuns));
    end;
  end;
end;

procedure TCustomFlexCelReport.ReplacePictures(var RowOffset: integer);
var
  i:integer;
  v:UTF16String;
  vwv: variant;
  vws: ByteArray;
  PictureType: TXlsImgTypes;
  RTFRuns: TRTFRunList;
  R, C: integer;
  ImgHeight, ImgWidth: extended;
  XOfsPixel, YOfsPixel: extended;
  Props: TImageProperties;
  Anchor: TClientAnchor;
  p: TXlsImgTypes;
  ImageData: TMemoryStream;
begin
  for i:=Workbook.PicturesCount[RowOffset+1]-1 downto 0 do
  begin
    v:=Workbook.PictureName[RowOffset+1,i];
    PictureType:= GetPictureType(v);
    vwv:=GetValue(GetBandValue(v,0,-1,nil), RowOffset, 0, RTFRuns);
    if (VarType(vwv) = (varArray or varByte))  then vws := vwv else SetLength(vws, 0);
    
    if (true) and ((Length(vws) > 0) or FKeepEmptyPictures) then
    begin
      if Assigned (FOnGetImageSize) then
      begin
        Workbook.GetPicture(RowOffset+1, i, nil, p, Anchor);
        CalcImgDimentions(Workbook, Anchor, XOfsPixel, YOfsPixel, ImgWidth, ImgHeight);
        R:=Anchor.Row1;
        C:=Anchor.Col1;
        ImageData:=TMemoryStream.Create;
        try
          ImageData.Write(vws[0], Length(vws));
          FOnGetImageSize(Self,  Workbook, v, PictureType, ImageData, R, C, ImgHeight, ImgWidth);
          ImageData.Position:=0;

          SetLength(vws, ImageData.Size);
          ImageData.ReadBuffer(vws[0], length(vws));
        finally
          FreeAndNil(ImageData);
        end; //finally
        CalcImgCells(Workbook, R,C, Round(YOfsPixel), Round(XOfsPixel), ImgHeight, ImgWidth, Props);
        Workbook.AssignPictureProperties(RowOffset+1, i, Props);
      end;
      Workbook.AssignPicture(RowOffset+1, i, vws, PictureType);
    end;
  end;
end;

procedure TCustomFlexCelReport.ReplaceComments(var RowOffset: integer);
var
  i:integer;
  v, vw:Variant;
  RTFRuns: TRTFRunList;
begin
  for i:=Workbook.CommentsCount[RowOffset+1]-1 downto 0 do   //Reverse order so comments might be deleted
  begin
    v:=Workbook.CommentText[RowOffset+1,i];
    vw:= GetValue(GetBandValue(v,0,-1,nil), RowOffset, 0, RTFRuns);
    if not VarIsEmpty(vw) and (v<>vw) then Workbook.AssignComment(RowOffset+1, i ,vw);
  end;
end;


procedure TCustomFlexCelReport.FillBandData( const Band: TExcelBand; var RowOffset: integer; const MainBandRow: integer);
var
  i,k, SaveK:integer;
  SaveRowOffset: integer;
  FirstRecord:Boolean;
begin
  //Fill in the data
  FirstRecord:=true;
  BandMoveFirst(Band.DataSet);

  while (BandIsNil(Band.DataSet)) or (not BandEof(Band.DataSet, FirstRecord)) do
  begin
    i:=Band.StartRow;
    while i<=Band.EndRow do
    begin
      if Canceled then exit;
      SaveK:=-1;
      for k:=0 to Band.SubBands.Count-1 do
        if (Band.SubBands[k] as TExcelBand).StartRow=i then
        begin
          SaveK:=k;
          break;
        end;
      if SaveK>=0 then
      begin
        SaveRowOffset := RowOffset;
        FillBandData(Band.SubBands[SaveK] as TExcelBand, RowOffset, MainBandRow);
        i:=(Band.SubBands[SaveK] as TExcelBand).EndRow;
        if FReportModeRows=frm_DontCopyAndDontInsert then i:= RowOffset - SaveRowOffset + (Band.SubBands[SaveK] as TExcelBand).StartRow - 1;
      end else
      begin
        ReplaceValues(Band, i-MainBandRow, RowOffset);
        ReplaceComments(RowOffset);
        ReplacePictures(RowOffset);
        inc(RowOffset);
      end;
      inc(i);
    end;
    if not BandIsNil(Band.DataSet) then BandMoveNext(Band.DataSet) else break;
  end;
end;

function TCustomFlexCelReport.ExportFieldData: boolean;
var
  MainBand: TExcelBand;
  RowOffset: integer;
begin
  Result:=false;
  MainBand:= nil;
  try
    ValueCache:= nil;
    try
      ReadTemplate(MainBand);
      if MainBand=nil then exit;
      if Canceled then exit;
      Result:=true;

      RowOffset:=0;
      FProgress.xPhase:=fps_CopyStructure;
      if FReportModeRows<>frm_DontCopyAndDontInsert then CopyStructure(MainBand, RowOffset);
      FProgress.xPhase:=fps_FillData;

      RowOffset:=MainBand.StartRow-1;
      Workbook.BeginSheet;
      try
        FillBandData(MainBand, RowOffset, MainBand.StartRow);
      finally
        Workbook.EndSheet(RowOffset);
      end;  //finally
    finally
    ValueCache:=nil;
    end; //finally
  finally
    FreeAndNil(MainBand);
  end; //finally
end;

procedure TCustomFlexCelReport.ClearProgress;
begin
  FProgress.FSheet:=0;
  FProgress.FCounter:=0;
  FProgress.xPhase:=fps_NotRunning;
end;

//----------------------------------------------------------------------------//
procedure TCustomFlexCelReport.Execute(const InStream: TStream = nil; const OutStream: TStream=nil);
var
  i, FirstSheet:integer;

begin
  ClearProgress;
  FProgress.xPhase:=fps_ReadTemplate;
  if FAdapter=nil then raise Exception.Create(ErrNoAdapter);
  try
    Workbook:=FAdapter.GetWorkbook;
    try
      Workbook.Connect;
      try
        if (InStream = nil) then Workbook.OpenFileAndSearch(FTemplate) else Workbook.LoadFromStream(InStream);
        try
          LazyDbList:=TExcelDbList.Create;
          try
            LazyDbList.Check(GetPagesDataSet);
            if Assigned (FOnBeforeGenerateWorkbook) then FOnBeforeGenerateWorkbook(Self, WorkBook);

            FirstSheet:=0;
            if GetPagesDataSet<>nil then
            begin
              FirstSheet:= Workbook.ActiveSheet;
              InsertSheets(FirstSheet);
            end;

            for i:=1 to Workbook.SheetCount do
            begin
              FProgress.xPhase:=fps_OrganizeData;
              FProgress.xSheet:=i;
              if Canceled then exit;
              if Assigned (FOnBeforeGeneratePage) then FOnBeforeGeneratePage(Self, Workbook);

              if Workbook.IsWorksheet(i) then
              begin
                Workbook.ActiveSheet:=i;

                FullDataSets:= TFullDataSetList.Create;
                try
                  if ExportFieldData then
                  begin
                    FillFullDatasets;
                    if Canceled then exit;
                    FProgress.xPhase:=fps_FinalCleanup;
                    Workbook.DeleteMarkedRows(MarkedRowStr);
                    Workbook.MakePageBreaks(HPageBreakStr);
                  end
                  else
                  begin
                    FProgress.xPhase:=fps_FinalCleanup;
                  end;
                  
                  Workbook.RefreshPivotTables;
                  if Canceled then exit;
                  Workbook.RefreshChartRanges(FieldStr);
                  if Assigned (FOnAfterGeneratePage) then FOnAfterGeneratePage(Self, Workbook);

                  if (GetPagesDataSet<>nil) and (i>=FirstSheet) then
                  begin
                    if not GetPagesDataSet.Eof then
                    begin
                      if (FPagesDataField<>'') then Workbook.ActiveSheetName:=GetPagesDataSet.FieldByName(FPagesDataField).Value;
                      GetPagesDataSet.Next;
                    end;
                  end;

                finally
                  FreeAndNil(FullDataSets);
                end; //finally
              end;
            end; //For each page
          finally
            FreeAndNil(LazyDbList);
          end; //finally

          Workbook.ActiveSheet:=1;

          while (Workbook.ActiveSheetVisible <> sv_Visible) and (Workbook.ActiveSheet < Workbook.SheetCount)  do
          begin
            Workbook.ActiveSheet := Workbook.ActiveSheet + 1;
          end;
          Workbook.SelectSheet(Workbook.ActiveSheet);


          if Assigned (FOnAfterGenerateWorkbook) then FOnAfterGenerateWorkbook(Self, Workbook);

          if Canceled then exit;
          Workbook.Save(FAutoClose, FFileName, FOnGetFileName, FOnGetOutStream, OutStream);
        except
          Workbook.CloseFile;
          raise;
        end; //Except

        if (FAutoClose) then    //If there was an exception the workbook has already been closed, so we dont have to protect this
        try
          Workbook.CloseFile;  //This won't quit excel, but when the app finishes it will quit too.
        except
          //nothing
        end; //Except

      finally
        Workbook.Disconnect;
      end; //finally
    finally
      FreeAndNil(Workbook);
    end; //finally
  finally
    FProgress.xPhase:=fps_Done;
  end; //finally
end;

procedure TCustomFlexCelReport.SetTemplate(const Value: TFileName);
begin
  FTemplate := Value;
end;

procedure TCustomFlexCelReport.SetPagesDataField(const Value: string);
begin
  FPagesDataField := Value;
end;

procedure TCustomFlexCelReport.SetAdapter(const Value: TExcelAdapter);
begin
  FAdapter := Value;
end;

procedure TCustomFlexCelReport.Cancel;
begin
  Canceled:=true;
end;

procedure TCustomFlexCelReport.Run;
begin
  Execute;
end;

procedure TCustomFlexCelReport.Run(const InStream, OutStream: TStream);
begin
  Execute(InStream, OutStream);
end;

procedure TCustomFlexCelReport.SaveToStream(const DataStream: TStream);
begin
  Execute(nil, DataStream);
end;

{$Include TFlxPropListImp.inc}

constructor TFlxProp.Create(const aName: string; const aValue: variant);
begin
  inherited Create;
  Name:=aName;
  Value:=aValue;
end;

function TCustomFlexCelReport.GetPropertyInfo(
  const PropName: string): PPropInfo;
begin
  Result:=GetPropInfo(DesignDataModule, PropName);
end;

function TCustomFlexCelReport.GetVariantProperty(
  const PropInfo: PPropInfo): variant;
begin
  Result:=GetVariantProp(DesignDataModule, PropInfo);
end;

function TCustomFlexCelReport.GetMethodInfo(
  const MethodName: string): Pointer;
begin
  Result := DesignDataModule.MethodAddress(MethodName);
end;

function TCustomFlexCelReport.ParseParams(const Arguments: string): ArrayOfVariant;
var
  Index1, Index2: integer;
  value: integer;
  s: string;
begin
    Index1:=1;
    SetLength(Result, 0);
    while Index1 < Length(Arguments) do
    begin
      Index2:=Posex(VarStr, Arguments, Index1);
      if (Index2 <= 0) then Index2:=Length(Arguments) + 1;

      SetLength(Result, Length(Result) + 1);
      s:= copy(Arguments, Index1, Index2 - Index1);
      if TryStrToInt(s, value) then Result[Length(Result) - 1]:= value else Result[Length(Result) - 1]:= s;

      Index1:=Index2  + Length(VarStr);
    end;
end;

function TCustomFlexCelReport.GetVariantMethod(const MethodInfo: pointer;
  const Arguments: string): variant;
var
  Method: function(const data: array of variant): variant of object;
  Method2: function: variant of object;
begin
  if Trim(Arguments) = '' then
  begin
    TMethod(Method2).Code:= MethodInfo;
    TMethod(Method2).Data:= DesignDataModule;
    Result := Method2();
  end
     else
     begin
       TMethod(Method).Code:= MethodInfo;
       TMethod(Method).Data:= DesignDataModule;
       Result := Method(ParseParams(Arguments));
     end;
end;

{ TFlxProgress }


constructor TFlxProgress.Create(const aFlexCelReport: TCustomFlexCelReport);
begin
  inherited Create;
  FlexCelReport:=aFlexCelReport;
end;

procedure TFlxProgress.SetPhase(const Value: TFlxProgressPhase);
begin
  FCounter:=0;
  FPhase := Value;
  if Assigned(FlexCelReport.OnProgress) then FlexCelReport.OnProgress(Self, FlexCelReport.FProgress, FlexCelReport.Canceled);
end;

procedure TFlxProgress.SetSheet(const Value: integer);
begin
  FSheet := Value;
  if Assigned(FlexCelReport.OnProgress) then FlexCelReport.OnProgress(Self, FlexCelReport.FProgress, FlexCelReport.Canceled);
end;

end.
