{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppPrnabl;                                                                 

interface

{$I ppIfDef.pas}

uses
  Types,
  Classes,
  SysUtils,
  Graphics,
  Forms,

  ppTypes,
  ppUtils,
  ppRTTI,
  ppComm,
  ppCache,
  ppDB,
  ppDevice,
  ppDrwCmd,
  ppPrintr;

type

  {@TppPrintable
  
    This class declares the properties, methods, and events used in
    components that print as part of a report.

    TppPrintable has only one descendant:
            TppCustomComponent}

  {@TppPrintable.Alignment

    Retained for backward compatibility - use TextAlignment for new reports.
    The Alignment property specifies how text is aligned within the component.
    These are the possible values:

    <Table>
    Value	            Meaning
    ---------------   ---------
    taLeftJustify	    Align text to the left side of the control
    taCenter	        Center text horizontally in the control
    taRightJustify	  Align text to the right side of the control
    </Table>}

  {@TppPrintable.AutoSize

    When the AutoSize property is True, the report component resizes to the
    width and length of the current string in the Caption property.  When
    AutoSize is False, the size of the report component is not affected by the
    length of the string in its Caption property.

    If you type text for a TppLabel component while AutoSize is True, the
    component grows for each character you type. If you change the font size of
    the text, the report label resizes to the new font size.

    The default value of AutoSize is True for non-data-aware components and
    False for data-aware components.

    For an Image component, when the AutoSize property is True, the height and
    width of the image component are determined by the size of the image
    specified in the Picture property.}

  {@TppPrintable.Border

    The Border object defines the outside border lines of a report component.
    This object allows you to decide which individual side receives a border line
    using the TppBorder.BorderPositions property.  Below are the possible values
    for the BorderPositions property:

    - bpLeft
    - bpTop
    - bpRight
    - bpBottom

    The Border object also contains properties to adjust the color, thickness,
    and line style of the border lines.  See the help for TppBorder for more
    information.  }

  {@TppPrintable.Caption

    The Caption property is the text that appears in the report component in the
    report designer. This text does not print in the report. The caption can be
    used to name components when specifying ShiftRelativeTo relationships.}

  {@TppPrintable.Color

    The Color property determines the background color of a report component.

    These are the possible values of Color:

    <Table>
    Value	               Meaning
    ------------         -----------
    clBlack	             Black
    clMaroon	           Maroon
    clGreen	             Green
    clOlive	             Olive green
    clNavy	             Navy blue
    clPurple	           Purple
    clTeal	             Teal
    clGray	             Gray
    clSilver	           Silver
    clRed	               Red
    clLime	             Lime green
    clBlue      	       Blue
    clFuchsia   	       Fuchsia
    clAqua      	       Aqua
    clWhite     	       White
    clBackground             Current color of your Windows background
    clActiveCaption	     Current color of the title bar of the active window
    clInactiveCaption	     Current color of the title bar of inactive windows
    clMenu	             Current background color of menus
    clWindow	             Current background color of windows
    clWindowFrame            Current color of window frames
    clMenuText	             Current color of text on menus
    clWindowText	     Current color of text in windows
    clCaptionText	     Current color of the text on the title bar of the
                             active window
    clActiveBorder	     Current border color of the active window
    clInactiveBorder         Current border color of inactive windows
    clAppWorkSpace	     Current color of the application workspace
    clHighlight	             Current background color of selected text
    clHightlightText	     Current color of selected text
    clBtnFace	             Current color of a button face
    clBtnShadow 	     Current color of a shadow cast by a button
    clGrayText  	     Current color of text that is dimmed
    clBtnText   	     Current color of text on a button
    clInactiveCaptionText    Current color of the text on the title bar of an
                             inactive window
    clBtnHighlight	     Current color of the highlighting on a button
    </Table>

    The second half of the colors listed here are Windows system colors. The
    color that appears depends on the color scheme users are using for Windows.
    Users can change these colors using the Control Panel in Program Manager.
    The actual color that appears will vary from system to system. For example,
    the color fuchsia may appear more blue on one system than another.
    When you use the Color dialog box to select a color, you are assigning a new
    color value to the dialog box's Color property. You can then use the value
    within the Color property and assign it to the Color property of another
    control.}

  {@TppPrintable.DataField

    The DataField property identifies the field from which the data-aware
    control displays data. The dataset the field is located in is specified in a
    data source component (TDataSource). The DataSource property of the
    data-aware control specifies which data source component.}

  {@TppPrintable.DataPipeline

    The DataPipeline property identifies the data pipeline from which the
    data-aware component retrieves data.  Data-aware components may be assigned
    to data pipelines that are not assigned to the report or to the report's
    detail band.  This is usually done in order to retrieve a field value
    from a lookup table or query.}


  {@TppPrintable.DrawCommandClass

    Contains a pointer to the class reference of the draw command that will be
    created when the component is printed.  This value is usually initialized in
    the Create method of the component.}

  {@TppPrintable.DrawComponent

    This property is used when generating a report in order to track
    whether or not the component has been drawn.}

  {@TppPrintable.Font

    The Font property controls the attributes of text written in the component
    or sent to the printer.

    Use the Format Bar in the Report Designer to control the Name, Size and
    Style of the font.  To set the Font color, select the Graphics Palette
    option from the Tools menu, then click the left mouse button on the desired
    color.  This will set the Font and/or Pen Color for all selected components.

    Note: In order to get the best results, use TrueType fonts. While your
    printer can render TrueType fonts just fine, it will substitute internal
    printer fonts (like Courier) when attempting to print fonts such as MS Sans
    Serif or System.  This means that a report that looks great in the previewer
    with MS Sans Serif will likely come out of your printer looking like it was
    typed with an IBM Selectric.

    RAP Tip
    If you are attempting to set the style of a font in RAP, then you can use
    the following boolean properties.  RAP does not currently support sets, and
    so these properties have been provided instead:

    <Table>
    Value	     Meaning
    --------   --------
    Normal	   Sets all of the other options to False.
    Bold	     Sets the font to bold.
    Italic	   Sets the font to italic.
    Strikeout	 Sets strikeout on the text.
    Underline	 Underlines the text.
    </Table>

    All settings except Normal are additive - that is, Bold, Italic and
    Underline could all be set to True. Setting Normal to True would cause all
    of the other settings to revert to False.  For example, to set the font to
    bold in RAP you would code: Label1.Font.Bold := True;}

  {@TppPrintable.GenerationComplete

    Used by the component when generating the report. Indicates that the
    component was completely generated after the Print method was called.}

  {@TppPrintable.Height

    The Height property expresses the vertical size of the component in 
    report units.}

  {@TppPrintable.LanguageIndex

    Run-time and read only. This value is derived from the value of the Language
    property. It is the base number for the currently selected language, and is
    used when calling the LoadStr method to load strings from the ppLang.res
    file.}

  {@TppPrintable.Left

    The Left property determines the horizontal coordinate of the left edge of a
    report component relative to the left edge of the parent band's starting
    print position.}

  {@TppPrintable.mmHeight

    The mmHeight property contains the value of the Height property in
    thousandths of millimeters.}

  {@TppPrintable.mmLeft

    The mmLeft property contains the value of the Left property in thousandths
    of millimeters.}

  {@TppPrintable.mmTop

    The mmTop property contains the value of the Top property in thousandths of 
    millimeters.}

  {@TppPrintable.mmWidth

    The mmWidth property contains the value of the Width property in thousandths
    of millimeters.}

  {@TppPrintable.OnDrawCommandClick

    The OnDrawCommandClick event fires when the draw command that represents the
    component in the report document is 'clicked' in the TppViewer component.
    The aDrawCommand parameter contains a TppDrawCommand object.  The usual
    practice is to place data or an information object handle in the Tag
    property of the DrawCommand in the OnDrawCommandCreate event so that
    something interesting can be done in response to the click.  For an example
    of this approach, see demo 153.}

  {@TppPrintable.OnDrawCommandCreate

    The OnDrawCommandCreate event fires when the draw command that represents
    the component in the report document is created.  The aDrawCommand parameter
    contains the TppDrawCommand object.  The usual practice is to place data or
    an information object handle in the Tag property of the DrawCommand and then
    do something interesting when the OnDrawCommandClick event fires.  For an
    example of this approach, see demo 153.}

  {@TppPrintable.OnPrint

    The OnPrint event fires before the component prints.  Use the OnPrint event
    when you want to dynamically control the appearance of the report component.
    For example, you can conditionally print a report component by setting the
    report component's Visible property at run-time based on some data field
    value.

    Note: For TppVariable components it is best to perform calculations in the
    OnCalc event due to the fact that the OnPrint event fires multiple times for
    each record in the DataPipeline.}

  {@TppPrintable.OutOfSpace}

  {@TppPrintable.OverFlow}

  {@TppPrintable.ParentHeight

    When set to True this property forces the height of the component to match
    height of the parent component.  The parent may be either a band or a
    region.}

  {@TppPrintable.ParentWidth

    When set to True this property forces the width of the component to match
    width of the parent component.  The parent may be either a band or a
    region.}

  {@TppPrintable.PrintPosRect}

  {@TppPrintable.ReprintOnOverFlow

    ReprintOnOverFlow applies to situations where a Stretchable component is
    stretching across pages.  If the memo overflows onto a new page, any
    components that are on the same band will reprint on the new page (if
    ReprintOnOverFlow is set to True).

    Defaults to False.

    To set the ReprintOnOverFlow property from the Report Designer, position
    your mouse cursor over the component and click the right mouse button.  The
    ReprintOnOverFlow option will be displayed in the speedmenu.  If it is
    checked, ReprintOnOverFlow is on. Selecting the ReprintOnOverFlow option
    from this menu will toggle its value.}

  {@TppPrintable.ResetOnCompute}

  {@TppPrintable.ShiftWithParent

    Deprecated. Use the Anchors property set to Bottom.

    ShiftWithParent applies to situations where a Stretchable component is
    stretching. If ShiftWithParent is set to True, the report component will
    move based on the amount of stretching the memo requires. When you want
    components to appear at the bottom of a memo, this is a useful feature.  If
    the memo stretches to a new page, the components will print on the next
    page.

    Defaults to False.

    To set the ShiftWithParent property from the Report Designer, position your
    mouse cursor over the component and click the right mouse button.  The
    ShiftWithParent option will be displayed in the speedmenu.  If it is
    checked, ShiftWithParent is on.  Selecting the ShiftWithParent option from
    this menu will toggle its value.}

  {@TppPrintable.SpaceUsed}

  {@TppPrintable.spBoundsRect}

  {@TppPrintable.spClientRect}

  {@TppPrintable.spClipRect}

  {@TppPrintable.spHeight}

  {@TppPrintable.spLeft}

  {@TppPrintable.spTop}

  {@TppPrintable.spWidth}

  {@TppPrintable.StretchWithParent

    The StretchWithParent property determines whether the Height of the
    component stretches to match any stretching done by the Band.  All
    stretching occurs vertically, and only vertical lines will stretch.  Band
    stretching may occur whenever a TppMemo or TppDBMemo component has the
    Stretch property set to True and the parent band PrintHeight property has
    been set to phDynamic.

    Defaults to False.

    To set the StretchWithParent property from the Report Designer, position
    your mouse cursor over the component and click the right mouse button.  The
    StretchWithParent option should be near the bottom of the speedmenu.  If it
    is checked, the component will stretch with the band.  Selecting the
    StretchWithParent option from this menu will toggle its value.}

  {@TppPrintable.Text

    The Text property contains the text that will be printed in the report.

    Use this property to store the result of any calculation made for ctCustom
    type components.

    If you are trying to print custom report information in formats that differ
    from those provided by the built-in types, some of the following TppReport
    properties may be helpful: AbsolutePage, AbsolutePageCount, Page, PageCount,
    and PrintDateTime.

    If you need to do numeric calculations on the data which cannot easily be
    provided by the built-in TppDBCalc types (Count, Sum, Avg, Min, Max), then
    it is usually best to use a standard Delphi Calculated Field or SQL.}

  {@TppPrintable.TextAlignment

    The TextAlignment property specifies how text is aligned within the
    component. These are the possible values:

    <Table>
    Value	             Meaning
    ----------------   --------
    taLeftJustified	   Align text to the left side of the control
    taCentered	       Center text horizontally in the control
    taRightJustified	 Align text to the right side of the control
    taFullJustified	   Align the text to the left and right sides of the
                       control (applies only to Memo and DBMemo components)
    </Table>}

  {@TppPrintable.Top

    The Top property determines the vertical coordinate of the top left corner
    of a report component.

    The value of top is relative to the value of a report component's parent
    band.}

  {@TppPrintable.Transparent

    The Transparent property determines whether the background of a report
    component is clear or opaque.  The default value for all report controls is
    False.

    To set the Transparent property from the Report Designer, position your
    mouse cursor over the component and click the right mouse button.  Selecting
    the Transparent option from this menu will toggle its value.

    Note: For TppShape, the analgous property to Transparent is
    Brush.Style = bsClear.}

  {@TppPrintable.Units

    The mmLeft property contains the value of the Left property in thousandths
    of millimeters.}

  {@TppPrintable.Visible

    The Visible property determines whether a report component will be printed.

    You can conditionally print a report component by setting the Visible
    property at run- time from an OnPrint event handler.

    You can suppress the printing of an entire band by setting the Visible
    property of each report component to False.  If the PrintHeight property of
    the report band is set to phStatic, then blank white space equivalent to the
    height of the band will be printed.  If PrintHeight is set to phDynamic, no
    page space is used and the next band begins printing. If you want to
    suppress an entire band, it is usually best to use the Visible property of
    the band itself.

    To set the Visible property from the Report Designer, position your mouse
    cursor over the component and click the right mouse button.  The Visible
    option should be near the bottom of the speedmenu.  If it is checked, the
    component will be printed.  Selecting the Visible option from this menu will
    toggle its value.}

  {@TppPrintable.Width

    The Width property expresses the horizontal size of a component in report
    units.}

  {@TppPrintable.WordWrap

    The WordWrap property determines whether the text of a report control has
    line breaks on word boundaries so that the text fits inside the control
    instead of being truncated.

    Defaults to False.

    To set the WordWrap property from the Report Designer, position your mouse
    cursor over the component and click the right mouse button.  The WordWrap
    option should be near the bottom of the speedmenu.  If it is checked,
    WordWrap is on.  Selecting the WordWrap option from this menu will toggle
    its value.}

  {@TppPrintable.ZOrder}

  TppPrintable = class(TppCacheable)
  private
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FBorder: TppBorder;
    FCaption: String;
    FColor: TColor;
    FCheckOutOfSpace: Boolean;
    FDataField: String;
    FDataPipeline: TppDataPipeline;
    FDataPipelineName: String;
    FDefaultPropEditType: TppPropEditType;
    FDefaultPropName: String;
    FDrawCommandClass: TppDrawCommandClass;
    FDrawComponent: Boolean;
    FFont: TFont;
    FForceJustifyLastLine: Boolean;
    FGenerationComplete: Boolean;
    FHeight: Longint;
    FLeft: Longint;
    FLookupPipeline: Boolean;
    FOnDrawCommandCreate: TppDrawCommandEvent;
    FOnDrawCommandClick: TppDrawCommandEvent;
    FOnPrint: TNotifyEvent;
    FOutOfSpace: Boolean;
    FOverFlow: Boolean;
    FParentHeight: Boolean;
    FParentWidth: Boolean;
    FPrintPosRect: TppRect;
    FReprintOnOverFlow: Boolean;
    FResetOnCompute: Boolean;
    FSaveHeight: Longint;
    FSaveWidth: Longint;
    FSpaceUsed: Longint;
    FStretchWithParent: Boolean;
    FText: String;
    FTextAlignment: TppTextAlignment;
    FTop: Longint;
    FTransparent: Boolean;
    FUnits: TppUnitType;
    FVisible: Boolean;
    FWidth: Longint;
    FWordWrap: Boolean;
    FZOrder: Integer;

    {used for conversion to 3.0}
    FDataSource: String;
    FReportField: String;

    function  GetForceJustifyLastLine: Boolean;
    function  GetHeight: Single;
    function  GetLeft: Single;
    function  GetScreenPixelLeft: Integer;
    function  GetScreenPixelTop: Integer;
    function  GetScreenPixelWidth: Integer;
    function  GetScreenPixelHeight: Integer;
    function  GetTop: Single;
    function  GetWidth: Single;
    procedure SetHeight(Value: Single);
    procedure SetLeft(Value: Single);
    procedure SetScreenPixelLeft(Value: Integer);
    procedure SetScreenPixelTop(Value: Integer);
    procedure SetScreenPixelWidth(Value: Integer);
    procedure SetScreenPixelHeight(Value: Integer);
    procedure SetTop(Value: Single);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Single);

    function  spGetBoundsRect: TRect;
    function  spGetClientRect: TRect;

    procedure BorderOnChangeEvent(Sender: TObject);

    {read/write private properties}
    procedure ReadDataPipelineName(Reader: TReader);
    procedure ReadHeight(Reader: TReader);
    procedure ReadLeft(Reader: TReader);
    procedure ReadTop(Reader: TReader);
    procedure ReadWidth(Reader: TReader);
    procedure WriteDataPipelineName(Writer: TWriter);
    procedure WriteHeight(Writer: TWriter);
    procedure WriteLeft(Writer: TWriter);
    procedure WriteTop(Writer: TWriter);
    procedure WriteWidth(Writer: TWriter);

    {used for conversion to 3.0}
    procedure ReadDataSource(Reader: TReader);
    procedure ReadRegion(Reader: TReader);
    procedure ReadReportField(Reader: TReader);
    procedure ReadParentDataSource(Reader: TReader);
    procedure ReadOnFormatText(Reader: TReader);

    procedure ReadAlignment(Reader: TReader);

  protected
    {override from TComponent}
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    procedure SetDefaultAutoSize(aValue: Boolean);
    procedure SetName(const Value: TComponentName); override;
    procedure SetUserName(const aUserName: TComponentName); override;

    procedure AdjustBounds; virtual;
    procedure BoundsChange; virtual;
    function  CheckForPipelineData: Boolean; virtual;
    procedure CreateDrawCommand(aPage: TppPage); virtual;
    procedure DrawCommandClickEvent(Sender: TObject); virtual;
    procedure DSChanged(aDesignStateSet: TppDesignStates); override;
    procedure FontChanged(Sender: TObject); virtual;
    function  GetCaption: String; virtual;
    function  GetDataPipeline: TppDataPipeline; virtual;
    function  GetDefaultPropHint: String; virtual;
    function  GetDescription: String; virtual;
    function  GetDesigner: TForm; virtual; abstract;
    function  GetLanguageIndex: Longint; virtual; abstract;
    function  GetPrinter: TppPrinter; virtual;
    function  GetShiftWithParent: Boolean; virtual;
    procedure InvalidateDesignControl; virtual;
    procedure PageStart; virtual;
    procedure PropertyChange; override;
    procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); virtual;
    procedure RedrawOnOverFlow; virtual;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetAutoSize(Value: Boolean); virtual;
    procedure SetBorder(aBorder: TppBorder); virtual;
    procedure SetColor(aColor: TColor); virtual;
    procedure SetCaption(Value: String); virtual;
    procedure SetDataField(const Value: String); virtual;
    procedure SetDataPipeline(aDataPipeline: TppDataPipeline); virtual;
    procedure SetFont(Value: TFont); virtual;
    procedure SetForceJustifyLastLine(Value: Boolean); virtual;
    procedure SetMMHeight(Value: Longint); virtual;
    procedure SetMMLeft(Value: Longint); virtual;
    procedure SetMMTop(Value: Longint); virtual;
    procedure SetMMWidth(Value: Longint); virtual;
    procedure SetParentHeight(Value: Boolean); virtual;
    procedure SetParentWidth(Value: Boolean);  virtual;
    procedure SetReprintOnOverFlow(Value: Boolean); virtual;
    procedure SetResetOnCompute(Value: Boolean); virtual;
    procedure SetShiftWithParent(Value: Boolean); virtual;
    procedure SetSpaceUsed(Value: Longint); virtual;
    procedure SetStretchWithParent(Value: Boolean); virtual;
    procedure SetTextAlignment(Value: TppTextAlignment); virtual;
    procedure SetTransparent(Value: Boolean); virtual;
    procedure SetWordWrap(Value: Boolean); virtual;
    procedure SetUnits(aUnits: TppUnitType); virtual;
    function  spGetClipRect: TRect; virtual;
    procedure UpdateDesignControlBounds; virtual;

    property Border: TppBorder read FBorder write SetBorder;
    property CheckOutOfSpace: Boolean read FCheckOutOfSpace write FCheckOutOfSpace;
    property Color: TColor read FColor write SetColor default clWhite;
    property DrawCommandClass: TppDrawCommandClass read FDrawCommandClass write FDrawCommandClass;
    property ForceJustifyLastLine: Boolean read GetForceJustifyLastLine write SetForceJustifyLastLine default False;
    property LanguageIndex: Longint read GetLanguageIndex;
    property Transparent: Boolean read FTransparent write SetTransparent default False;

  public
    constructor Create(aOwner: TComponent); override;
    destructor  Destroy; override;

    procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

    class function DefaultHint: String; virtual;

    procedure AfterDesignerCreate; virtual;
    procedure AfterPrint; virtual;
    function  AllowsJustification: Boolean; virtual;
    procedure BeforePrint; virtual;
    procedure Clear; virtual;
    procedure Compute; virtual;
    procedure ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String); virtual;
    procedure DoOnPrint; virtual;
    procedure EndOfMainReport; virtual;
    procedure FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String); virtual;
    function FromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType): Single;
    procedure Generate; virtual; abstract;
    procedure GetBackgroundColor(var aColor: TColor; var aIsClear: Boolean); virtual;
    procedure GetForegroundColor(var aColor: TColor; var aIsClear: Boolean); virtual;
    function  GetText: String; virtual;
    procedure GetDataPipelines(aDataPipelines: TList); virtual;
    procedure GetDefaultPropEnumNames(aList: TStrings); virtual;
    procedure GetDisplayFormats(aList: TStrings); virtual;
    function  HasColor: Boolean; virtual;
    function  HasFont: Boolean; virtual;
    procedure Init; virtual;
    function  IsCalc: Boolean; virtual;
    function  IsClickable: Boolean; virtual;
    function  IsDataAware: Boolean; virtual;
    procedure LanguageChanged; virtual;
    function  Printing: Boolean; virtual;
    procedure Print(aPage: TppPage); virtual;
    procedure Reset; virtual;
    procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); virtual;
    procedure SetBounds(aLeft, aTop, aWidth, aHeight: Single);
    procedure spSetBounds(aLeft, aTop, aWidth, aHeight: Integer);
    procedure mmSetBounds(aLeft, aTop, aWidth, aHeight: LongInt); virtual;
    function ToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType): Longint;
    procedure SetText(Value: String); virtual;
    procedure SetBackgroundColor(aColor: TColor; aIsClear: Boolean); virtual;
    procedure SetForegroundColor(aColor: TColor; aIsClear: Boolean); virtual;
    procedure SetPenWidth(aWidth: Integer); virtual;
    procedure StartOfMainReport; virtual;
    procedure StartOfParentReport; virtual;

    {used to convert to 3.0}
    procedure Convert(aVersionNo: Integer); virtual;

    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property Caption: String read GetCaption write SetCaption;
    property DataField: String read FDataField write SetDataField;
    property DataPipeline: TppDataPipeline read GetDataPipeline write SetDataPipeline;
    property DefaultPropHint: String read GetDefaultPropHint;
    property DefaultPropName: String read FDefaultPropName write FDefaultPropName;
    property DefaultPropEditType: TppPropEditType read FDefaultPropEditType write FDefaultPropEditType;
    property Designer: TForm read GetDesigner;
    property Description: String read GetDescription;
    property DrawComponent: Boolean read FDrawComponent write FDrawComponent;
    property Font: TFont read FFont write SetFont;
    property GenerationComplete: Boolean read FGenerationComplete write FGenerationComplete;
    property Height: Single read GetHeight write SetHeight stored False;
    property Left: Single read GetLeft write SetLeft stored False;
    property LookupPipeline: Boolean read FLookupPipeline write FLookupPipeline;
    property mmLeft: Longint read FLeft;
    property mmHeight: Longint read FHeight;
    property mmTop: Longint read FTop;
    property mmWidth: Longint read FWidth;
    property OnDrawCommandClick: TppDrawCommandEvent read FOnDrawCommandClick write FOnDrawCommandClick;
    property OnDrawCommandCreate: TppDrawCommandEvent read FOnDrawCommandCreate write FOnDrawCommandCreate;
    property OutOfSpace: Boolean read FOutOfSpace write FOutOfSpace;
    property OverFlow: Boolean read FOverFlow write FOverFlow;
    property ParentHeight: Boolean read FParentHeight write SetParentHeight default False;
    property ParentWidth: Boolean read FParentWidth write SetParentWidth default False;
    property PrintPosRect: TppRect read FPrintPosRect write FPrintPosRect;
    property ReprintOnOverFlow: Boolean read FReprintOnOverFlow write SetReprintOnOverFlow default False;
    property ResetOnCompute: Boolean read FResetOnCompute  write SetResetOnCompute;
    property ShiftWithParent: Boolean read GetShiftWithParent write SetShiftWithParent;
    property SpaceUsed: Longint read FSpaceUsed write SetSpaceUsed;
    property spClientRect: TRect read spGetClientRect;
    property spClipRect: TRect read spGetClipRect;
    property spBoundsRect: TRect read spGetBoundsRect;
    property spLeft: Integer read GetScreenPixelLeft write SetScreenPixelLeft;
    property spHeight: Integer read GetScreenPixelHeight write SetScreenPixelHeight;
    property spTop: Integer read GetScreenPixelTop write SetScreenPixelTop;
    property spWidth: Integer read GetScreenPixelWidth write SetScreenPixelWidth;
    property StretchWithParent: Boolean read FStretchWithParent write SetStretchWithParent default False;
    property Text: String read GetText write SetText;
    property TextAlignment: TppTextAlignment read FTextAlignment write SetTextAlignment default taLeftJustified;
    property Top: Single read GetTop write SetTop stored False;
    property Units: TppUnitType read FUnits write SetUnits;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Single read GetWidth write SetWidth stored False;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property ZOrder: Integer read FZOrder write FZOrder;

    {used for conversion to 3.0}
    property DataSource: String read FDataSource;
    property ReportField: String read FReportField;

  published
    property OnPrint: TNotifyEvent read FOnPrint write FOnPrint;
    
  end; {class, TppPrintable}

  {@TraTppPrintableRTTI }
  TraTppPrintableRTTI = class(TraTppCacheableRTTI)
    public
      class procedure GetEventList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppPrintableRTTI}


implementation

{******************************************************************************
 *
 ** P R I N T A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppPrintable.Create }

constructor TppPrintable.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  FAlignment          := taLeftJustify;
  FAutoSize           := False;
  FBorder             := TppBorder.Create(Self);
  FBorder.OnChange    := BorderOnChangeEvent;
  FCaption            := '';
  FCheckOutOfSpace    := True;
  FColor              := clWhite;
  FDataField          := '';
  FDataPipeline       := nil;
  FDataPipelineName   := '';
  FDefaultPropEditType := etEdit;
  FDefaultPropName    := '';
  FDrawCommandClass   := nil;
  FDrawComponent      := False;
  FFont               := TppFont.Create;
  FFont.Color         := clBlack;
  FFont.OnChange      := FontChanged;
  FForceJustifyLastLine := False;
  FGenerationComplete := False;
  FHeight             := ppToMMThousandths(17, utScreenPixels, pprtVertical, nil);
  FLeft               := 0;
  FLookupPipeline     := False;
  FOnDrawCommandClick := nil;
  FOnDrawCommandCreate := nil;
  FOnPrint            := nil;
  FOutOfSpace         := False;
  FOverFlow           := False;
  FParentWidth        := False;
  FParentHeight       := False;
  FPrintPosRect       := ppRect(0,0,0,0);
  FReprintOnOverFlow  := False;
  FResetOnCompute     := False;
  FSaveWidth          := 0;
  FSaveHeight         := 0;
  FSpaceUsed          := 0;
  FStretchWithParent  := False;
  FText               := '';
  FTextAlignment      := taLeftJustified;
  FTop                := 0;
  FTransparent        := False;
  FUnits              := utInches;
  FVisible            := True;
  FWidth              := ppToMMThousandths(65, utScreenPixels, pprtHorizontal, nil);
  FWordWrap           := False;

  if IsDataAware then
    begin
      FDefaultPropName     := 'DataField';
      FDefaultPropEditType := etFieldList;
    end;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppPrintable.Destroy }

destructor TppPrintable.Destroy;
begin

  {tell data pipeline that we no longer exist}
  if (FDataPipeline <> nil) then
    FDataPipeline.RemoveNotify(Self);

  FFont.Free;

  FBorder.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppPrintable.Notify }

procedure TppPrintable.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation = ppopRemove) and (aCommunicator = FDataPipeline) then
    begin
      FDataPipeline := nil;

      Reset;
    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppPrintable.ReadState }

procedure TppPrintable.ReadState(Reader: TReader);
begin

  {this is necessary to conver reports prior to 5.6}
  if IsDataAware then
    FDataPipelineName := TppHReaderUtils.ExtractIdentPropValue(Reader, 'DataPipeline');

  inherited ReadState(Reader);

end; {procedure, ReadState}

{------------------------------------------------------------------------------}
{ TppPrintable.Loaded }

procedure TppPrintable.Loaded;
begin

  if (pppcPasting in DesignState) then
    DSExclude([pppcPasting]);

  inherited Loaded;

end; {function, Loaded }

{------------------------------------------------------------------------------}
{ TppPrintable.GetDescription }

function TppPrintable.GetDescription: String;
begin
  Result := UserName;
end; {function, GetDescription }

{------------------------------------------------------------------------------}
{ TppPrintable.Printing }

function TppPrintable.Printing: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.IsCalc }

function TppPrintable.IsCalc: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.IsClickable }

function TppPrintable.IsClickable: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.Compute }

procedure TppPrintable.Compute;
begin

end;

{------------------------------------------------------------------------------}
{ TppPrintable.Init }

procedure TppPrintable.Init;
begin

  FOverFlow := False;

  if IsCalc then
    Clear;

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppPrintable.Clear }

procedure TppPrintable.Clear;
begin
  FResetOnCompute := True;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.StartOfMainReport }

procedure TppPrintable.StartOfMainReport;
begin

end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppPrintable.StartOfParentReport }

procedure TppPrintable.StartOfParentReport;
begin

end; {procedure, StartOfParentReport}

{------------------------------------------------------------------------------}
{ TppPrintable.EndOfMainReport }

procedure TppPrintable.EndOfMainReport;
begin

end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppPrintable.BeforePrint }

procedure TppPrintable.BeforePrint;
begin

  FGenerationComplete := False;
  FSpaceUsed := 0;
  FOutOfSpace := False;

end; {procedure, BeforePrint}

{------------------------------------------------------------------------------}
{ TppPrintable.RedrawOnOverFlow }

procedure TppPrintable.RedrawOnOverFlow;
begin
  if FVisible then
    FDrawComponent := True;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.Print }

procedure TppPrintable.Print(aPage: TppPage);
begin

  if FDrawComponent and FVisible then
    CreateDrawCommand(aPage);

end; {procedure, Print}

{------------------------------------------------------------------------------}
{ TppPrintable.CreateDrawCommand }

procedure TppPrintable.CreateDrawCommand(aPage: TppPage);
var
  lDrawCommand: TppDrawCommand;
  lParams: TraParamList;
begin

  if (FDrawCommandClass = nil) then Exit;

  {create the draw command}
  lDrawCommand := FDrawCommandClass.Create(nil);

  {transfer properties to draw command}
  PropertiesToDrawCommand(lDrawCommand);

  {assign click event handler, do this after create}
  lDrawCommand.Clickable := Assigned(FOnDrawCommandClick) or IsActiveNotify(ciPrintableDrawCommandClick) or ((lDrawCommand is TppDrawText) and (TppDrawText(lDrawCommand).HyperLink <> ''));
  lDrawCommand.OnClick := DrawCommandClickEvent;

  {assign the page rect - used for clipping}
  lDrawCommand.ClipRect := aPage.PageDef.PageRect;

  {trigger event}
  if Assigned(FOnDrawCommandCreate) then FOnDrawCommandCreate(Self, lDrawCommand);

  {assign draw command to page, do this last, so drawcommand is properly classified}
  lDrawCommand.Page := aPage;

  lParams := TraTppPrintableRTTI.GetParams('OnDrawCommandCreate');
  lParams.CreateValuePointer(0, lDrawCommand);

  SendEventNotify(Self, ciPrintableDrawCommandCreate, lParams);

  lParams.Free;

end; {procedure, CreateDrawCommand}


{@TppPrintable.PropertiesToDrawCommand
 Called each time the component is printing and a draw command has been created.
 The descendant normally assigns the properties of the draw command based on its
 own property values - so that a proper visual representation for the component
 will occur when the draw command is rendered by the receiving device(s).}

procedure TppPrintable.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
begin
  aDrawCommand.Tag := Tag;
  aDrawCommand.Border := Border;

  {for DataAware components, assign DataType from the datapipeline field info}
  if CheckForPipelineData then
    aDrawCommand.DataType := FDataPipeline.GetFieldDataType(FDataField);

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppPrintable.DrawCommandClickEvent}

procedure TppPrintable.DrawCommandClickEvent(Sender: TObject);
var
  lParams: TraParamList;
  lDrawCommand: TppDrawCommand;
begin

  if not(Sender is TppDrawCommand) then Exit;

  {trigger event}
  if Assigned(FOnDrawCommandClick) then FOnDrawCommandClick(Self, TppDrawCommand(Sender));

  lDrawCommand := TppDrawCommand(Sender);

  lParams := TraTppPrintableRTTI.GetParams('OnDrawCommandClick');
  lParams.CreateValuePointer(0, lDrawCommand);

  SendEventNotify(Self, ciPrintableDrawCommandClick, lParams);

  lParams.Free;

end; {procedure, DrawCommandClickEvent}

{------------------------------------------------------------------------------}
{ TppPrintable.AfterPrint }

procedure TppPrintable.AfterPrint;
begin

  if FGenerationComplete then
    FDrawComponent := False;

end; {procedure, AfterPrint}



{@TppPrintable.AfterDesignerCreate
 Called by the Report Designer after the component has been created.  This gives
 the component a chance to perform any initializations that cannot occur in the
 Create. (For example, the TppTeeChart component overrides this procedure and
 creates an instance of a TeeChart control for internal use.)}

procedure TppPrintable.AfterDesignerCreate;
begin
 {this method is called by the report designer}
end; {procedure, AfterDesignerCreate}


{------------------------------------------------------------------------------}
{ TppPrintable.PropertyChange }

procedure TppPrintable.PropertyChange;
begin

  if Printing then Exit;

  if (pppcLoading in DesignState) or (pppcTemplateLoading in DesignState) then Exit;

  AfterPropertyChange;

end;


{------------------------------------------------------------------------------}
{ TppPrintable.InvalidateDesignControl }

procedure TppPrintable.InvalidateDesignControl;
begin

  if not (pppcDesigning in DesignState) or (Printing) then Exit;

  SendEventNotify(Self, ciComponentInvalidateDesignControl, nil);

end; {procedure, InvalidateDesignControl}
{------------------------------------------------------------------------------}
{ TppPrintable.SetAlignment }

procedure TppPrintable.SetAlignment(Value: TAlignment);
begin

  if FAlignment <> Value then
    begin
      BeforePropertyChange('Alignment');
      FAlignment := Value;

      case FAlignment of
        taLeftJustify:
            FTextAlignment := taLeftJustified;
        taRightJustify:
            FTextAlignment := taRightJustified;
        taCenter:
            FTextAlignment := taCentered;
      end;

      InvalidateDesignControl;
      PropertyChange;
    end;

end; {procedure, SetAlignment}

{------------------------------------------------------------------------------}
{ TppPrintable.SetAutoSize }

procedure TppPrintable.SetAutoSize(Value: Boolean);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    FAutoSize := Value
  else if FAutoSize <> Value then
    begin
      BeforePropertyChange('AutoSize');
      FAutoSize := Value;

      AdjustBounds;
      PropertyChange;
    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetBorder }

procedure TppPrintable.SetBorder(aBorder: TppBorder);
begin
  FBorder.Assign(aBorder);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetParentHeight }

procedure TppPrintable.SetParentHeight(Value: Boolean);
begin
  FParentHeight := Value;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetParentWidth }

procedure TppPrintable.SetParentWidth(Value: Boolean);
begin
  FParentWidth := Value;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetSpaceUsed }

procedure TppPrintable.SetSpaceUsed(Value: Longint);
begin
  FSpaceUsed := Value;
end; {procedure, SetSpaceUsed}

{------------------------------------------------------------------------------}
{ TppPrintable.SetResetOnCompute }

procedure TppPrintable.SetResetOnCompute(Value: Boolean);
begin
  FResetOnCompute := Value;
end; {procedure, SetResetOnCompute}

{------------------------------------------------------------------------------}
{ TppPrintable.SetReprintOnOverFlow }

procedure TppPrintable.SetReprintOnOverFlow(Value: Boolean);
begin

  if FReprintOnOverFlow <> Value then
    begin

      FReprintOnOverFlow := Value;

      PropertyChange;

      Reset;

    end;

end; {procedure, SetReprintOnOverFlow}

{------------------------------------------------------------------------------}
{ TppPrintable.SetShiftWithParent }

procedure TppPrintable.SetShiftWithParent(Value: Boolean);
begin

end; {procedure, SetShiftWithParent}

{------------------------------------------------------------------------------}
{ TppPrintable.GetShiftWithParent }

function TppPrintable.GetShiftWithParent: Boolean;
begin
  Result := False;
end; {function, GetShiftWithParent}

{------------------------------------------------------------------------------}
{ TppPrintable.SetStretchWithParent }

procedure TppPrintable.SetStretchWithParent(Value: Boolean);
begin
  if FStretchWithParent <> Value then
    begin

      FStretchWithParent := Value;

      PropertyChange;

      Reset;

    end;
end; {procedure, ShiftWithParent}

{------------------------------------------------------------------------------}
{ TppPrintable.SetColor }

procedure TppPrintable.SetColor(aColor: TColor);
begin

  if HasColor and (FColor <> aColor) then
    begin
      BeforePropertyChange('Color');
      FColor := aColor;

      InvalidateDesignControl;

      PropertyChange;

      Reset;
    end;

end;

procedure TppPrintable.BorderOnChangeEvent(Sender: TObject);
begin
  AdjustBounds;
  InvalidateDesignControl;
  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetTransparent }

procedure TppPrintable.SetTransparent(Value: Boolean);
begin

  if FTransparent <> Value then
    begin
      BeforePropertyChange('Transparent');
      FTransparent := Value;

      InvalidateDesignControl;

      PropertyChange;

      Reset;
    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetVisible }

 procedure TppPrintable.SetVisible(Value: Boolean);
begin

  if FVisible <> Value then
    begin
      FVisible := Value;

      PropertyChange;
      Reset;

    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetWordWrap }

procedure TppPrintable.SetWordWrap(Value: Boolean);
begin

  if FWordWrap <> Value then
    begin
      BeforePropertyChange('WordWrap');
      FWordWrap := Value;

      AdjustBounds;
      PropertyChange;
      Reset;

    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetDefaultAutoSize }

procedure TppPrintable.SetDefaultAutoSize(aValue: Boolean);
begin
  {enable descendants to set a default autosize value, without triggering
   adjust bounds logic}
  FAutoSize := aValue;
end; {procedure, SetDefaultAutoSize}


{------------------------------------------------------------------------------}
{ TppPrintable.SetName }

procedure TppPrintable.SetName(const Value: TComponentName);
begin

  inherited SetName(Value);

  InvalidateDesignControl;

  {use Post here to avoid access violations in IDE}
  SendDesignMessage(RM_COMPONENTNAMECHANGE, ppWCustomMsg, Self);

end; {procedure, SetName}

{------------------------------------------------------------------------------}
{ TppPrintable.SetUserName }

procedure TppPrintable.SetUserName(const aUserName: TComponentName);
begin

  inherited SetUserName(aUserName);

  InvalidateDesignControl;

  {use Post here to avoid access violations in IDE}
  SendDesignMessage(RM_COMPONENTNAMECHANGE, ppWCustomMsg, Self);

end; {procedure, SetUserName}


{------------------------------------------------------------------------------}
{ TppPrintable.GetCaption }

function TppPrintable.GetCaption: String;
begin

  {if caption is empty, try to get a caption }
  if (FCaption = '') and (pppcDesigning in DesignState) and not(Printing) then
    begin
      {try getting the text }
      FCaption := GetText;

      if IsDataAware and not(CheckForPipelineData) then
        begin
          if FDataPipeline <> nil then
            FCaption := FDataPipeline.FieldAliasForFieldName(DataField)
          else
            FCaption := DataField;
        end;

    end;

  Result := FCaption;

end; {function, GetCaption}

{------------------------------------------------------------------------------}
{ TppPrintable.DefaultHint }

class function TppPrintable.DefaultHint: String;
begin
  Result := ClassName;
end; {function, DefaultHint}

{------------------------------------------------------------------------------}
{ TppPrintable.GetDefaultPropHint }

function TppPrintable.GetDefaultPropHint: String;
begin

  if IsDataAware then
    Result := ppLoadStr(203) {Data Field}

  else if FDefaultPropName = 'Caption' then
    Result := ppLoadStr(154);

end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TppPrintable.GetDataPipelines }

procedure TppPrintable.GetDataPipelines(aDataPipelines: TList);
begin
  if IsDataAware and (DataPipeline <> nil) and (aDataPipelines.IndexOf(DataPipeline) = -1) then
    aDataPipelines.Add(DataPipeline);

end; {function, GetDataPipelines}

{------------------------------------------------------------------------------}
{ TppPrintable.SetFont }

procedure TppPrintable.SetFont(Value: TFont);
begin

  BeforePropertyChange('Font');

  FFont.Assign(Value);

  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetBackgroundColor }

procedure TppPrintable.SetBackgroundColor(aColor: TColor; aIsClear: Boolean);
begin

  SetTransparent(aIsClear);

  if not aIsClear then
    SetColor(aColor);
    
end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetForceJustifyLastLine }

procedure TppPrintable.SetForceJustifyLastLine(Value: Boolean);
begin
  if (FForceJustifyLastLine <> Value) then
    begin
      BeforePropertyChange('ForceJustifyLastLine');
      FForceJustifyLastLine := Value;

      InvalidateDesignControl;
      PropertyChange;
    end;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetForegroundColor }

procedure TppPrintable.SetForegroundColor(aColor: TColor; aIsClear: Boolean);
begin

  if HasFont then
    begin
      BeforePropertyChange('Font.Color');
      FFont.Color := aColor;
      PropertyChange;
    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetPenWidth }

procedure TppPrintable.SetPenWidth(aWidth: Integer);
begin
end;

{------------------------------------------------------------------------------}
{ TppPrintable.FontChanged }

procedure TppPrintable.FontChanged(Sender: TObject);
begin

  AdjustBounds;
  InvalidateDesignControl;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetText }

function TppPrintable.GetText: String;
begin
  Result := FText;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetBackgroundColor }

procedure TppPrintable.GetBackgroundColor(var aColor: TColor; var aIsClear: Boolean);
begin

  if HasColor then
    begin
      aColor   := FColor;
      aIsClear := FTransparent;
    end
  else
    begin
      aColor := clWhite;
      aIsClear := FTransparent;
    end;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetForceJustifyLastLine }

function TppPrintable.GetForceJustifyLastLine: Boolean;
begin
  result := FForceJustifyLastLine;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetForegroundColor }

procedure TppPrintable.GetForegroundColor(var aColor: TColor; var aIsClear: Boolean);
begin

  if HasFont then
    begin
      aColor   := FFont.Color;
      aIsClear := FTransparent;
    end
  else
    aIsClear := True;

end;


{------------------------------------------------------------------------------}
{ TppPrintable.GetDefaultPropEnumNames }

procedure TppPrintable.GetDefaultPropEnumNames(aList: TStrings);
begin
end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetDisplayFormats }

procedure TppPrintable.GetDisplayFormats(aList: TStrings);
begin
end;

{------------------------------------------------------------------------------}
{ TppPrintable.spGetBoundsRect }

function TppPrintable.spGetBoundsRect: TRect;
begin
  Result := Rect( Trunc(ppFromMMThousandths(FLeft,  utScreenPixels, pprtHorizontal, nil)),
                    Trunc(ppFromMMThousandths(FTop,  utScreenPixels, pprtVertical, nil)),
                    Trunc(ppFromMMThousandths(FLeft+FWidth,  utScreenPixels, pprtHorizontal, nil)),
                    Trunc(ppFromMMThousandths(FTop+FHeight, utScreenPixels, pprtVertical, nil)) );
end;

{------------------------------------------------------------------------------}
{ TppPrintable.spGetClientRect }

function TppPrintable.spGetClientRect: TRect;
begin
  Result := Rect(0, 0, Trunc(ppFromMMThousandths(FWidth,  utScreenPixels, pprtHorizontal, nil)),
                       Trunc(ppFromMMThousandths(FHeight, utScreenPixels, pprtVertical, nil)) );
end;

{------------------------------------------------------------------------------}
{ TppPrintable.spGetClipRect }

function TppPrintable.spGetClipRect: TRect;
begin

  Result := spClientRect

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetText }

procedure TppPrintable.SetText(Value: String);
begin
  FText := Value;

  if not IsDataAware then
    PropertyChange;

end;


{@TppPrintable.HasColor
 Indicates whether the Highlight color that can be set via the Report Designer's
 highlight color control applies to this component.  This property is used for
 highlighting text - so components such as Lines, Shapes, Regions, etc override
 this function and return False.}

function TppPrintable.HasColor: Boolean;
begin
  Result := True;
end;


{@TppPrintable.HasFont
 Allows the component to indicate whether or not the Font property is being
 used.  Defaults to True.}

function TppPrintable.HasFont: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetDataPipeline }

function TppPrintable.GetDataPipeline: TppDataPipeline;
begin
  Result := FDataPipeline;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetDataPipeline }

procedure TppPrintable.SetDataPipeline(aDataPipeline: TppDataPipeline);
var
  lbPropertyChange: Boolean;
begin

  lbPropertyChange := FDataPipeline <> aDataPipeline;

  if lbPropertyChange then
    BeforePropertyChange('DataPipeline');

  if FDataPipeline <> nil then
    FDataPipeline.RemoveNotify(Self);

  FDataPipeline := aDataPipeline;

  if FDataPipeline <> nil then
    FDataPipeline.AddNotify(Self);

  {this causes the caption to change}
  Notify(FDataPipeline, ppopDataChange);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  SendDesignMessage(RM_COMPONENTDATAPIPELINECHANGE, ppWCustomMsg, nil);

  Reset;

  if lbPropertyChange then
    PropertyChange;

end; {procedure, SetDataPipeline}

{------------------------------------------------------------------------------}
{ TppPrintable.SetDataField}

procedure TppPrintable.SetDataField(const Value: String);
begin

  if not(IsDataAware) then Exit;

  if (FDataField <> Value) then
    BeforePropertyChange('DataField');

  FDataField := Value;

  {set caption}
  if Value = '' then
    Caption := Name

  else if not(CheckForPipelineData) then
    begin
      if (DataPipeline <> nil) then
        Caption := FDataPipeline.FieldAliasForFieldName(FDataField)
      else
        Caption := FDataField;
    end;

  Reset;


end; {procedure, SetDataField}

{------------------------------------------------------------------------------}
{ TppPrintable.DSChanged}

procedure TppPrintable.DSChanged(aDesignStateSet: TppDesignStates);
begin

  inherited DSChanged(aDesignStateSet);

  if IsDataAware and (pppcDisplayData in aDesignStateSet) then
    Notify(FDataPipeline, ppopDataChange);

end; {procedure, DSChanged}


{@TppPrintable.IsDataAware
 Indicates whether the DataPipeline and DataField properties apply to the
 component.  All data-aware components return true.}

function TppPrintable.IsDataAware: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.CheckForPipelineData}

function TppPrintable.CheckForPipelineData: Boolean;
begin

  Result := IsDataAware;

  if not(IsDataAware) then Exit;

  try

    if (FDataField = '') then
      Result := False

    else if (FDataPipeline = nil) then
      Result := False

    else if not(FDataPipeline.Active) then
      Result := False

    // optimization
    // note: the second check is to preserve backward compatiblity
    else if (DataPipeline.GetFieldForName(FDataField) = nil) and (DataPipeline.FieldCount > 0) then
      Result := False

    else if ((csDesigning in ComponentState) and FDataPipeline.GetFieldIsCalculated(FDataField)) then
      Result := False

    else if (pppcDesigning in DesignState) and not(pppcDisplayData in DesignState) and
            not(Printing) then
      Result := False;

  except
    Result := False;

  end;

end; {function, CheckForPipelineData}


{@TppPrintable.LanguageChanged
 This routine is called when the Language property of the report is changed.  It
 is usually used to redraw any language-specific strings in the design control
 of the component.}

procedure TppPrintable.LanguageChanged;
begin

end;

{------------------------------------------------------------------------------}
{ TppPrintable.SetCaption }

procedure TppPrintable.SetCaption(Value: String);
var
  lsOldCaption: String;
  lbPropertyChange: Boolean;
begin

  lbPropertyChange :=  not IsDataAware and (Value <> FCaption);

  if lbPropertyChange then
    BeforePropertyChange('Caption');

  lsOldCaption := FCaption;

  FCaption := Value;
  FText    := FCaption;    {used for printing}

  if AutoSize and (FCaption <> lsOldCaption) then
    AdjustBounds;

  InvalidateDesignControl;

  if lbPropertyChange then
    PropertyChange;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.DoOnPrint }

procedure TppPrintable.DoOnPrint;
begin

  if Assigned(FOnPrint) then FOnPrint(Self);

  SendEventNotify(Self, ciComponentPrint, nil);

end; {function, DoOnPrint}

{------------------------------------------------------------------------------}
{ TppPrintable.Reset }

procedure TppPrintable.Reset;
begin
end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetPrinter }

function TppPrintable.GetPrinter: TppPrinter;
begin

  Result := nil;

end;

{------------------------------------------------------------------------------}
{ TppPrintable.FromMMThousandths }

function TppPrintable.FromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType): Single;
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
{ TppPrintable.ToMMThousandths }

function TppPrintable.ToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType): Longint;
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
{ TppPrintable.AdjustBounds }

procedure TppPrintable.AdjustBounds;
begin
  InvalidateDesignControl;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.AllowsJustification }

function TppPrintable.AllowsJustification: Boolean;
begin
  {Should only be true for descendants of TppCustomMemo}
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.BoundsChange }

procedure TppPrintable.BoundsChange;
begin

  if not (pppcDesigning in DesignState) or (Printing) then Exit;

  {note: if reading or loading and not pasting}
  if ((csReading in ComponentState) or (csLoading in ComponentState)) and not(pppcPasting in DesignState) then Exit;


  {update design control bounds }
  UpdateDesignControlBounds;

  PropertyChange;


  {redraw design control if size changed }
  if ((FSaveHeight <> FHeight) or (FSaveWidth <> FWidth)) then
    begin
      FSaveHeight := FHeight;
      FSaveWidth  := FWidth;

      InvalidateDesignControl;
    end;


end; {procedure, BoundsChange}

{------------------------------------------------------------------------------}
{ TppPrintable.UpdateDesignControlBounds }

procedure TppPrintable.UpdateDesignControlBounds;
begin

  SendEventNotify(Self, ciComponentBoundsChanged, nil);

end; {procedure, UpdateDesignControlBounds}


{@TppPrintable.SetBounds
 The SetBounds method sets the report component's boundary properties, Left,
 Top, Width, and Height, to the values passed in aLeft, aTop, aWidth, and
 aHeight, respectively.

 If you are attempting to dynamically change the size of a report component at
 run-time, you may need to set the PrintHeight property of the parent band to
 phDynamic.  Otherwise your newly sized component may end up getting printed
 over due to inadequate band height.

 If you are trying to suppress the printing of a report component, use the
 Visible property.}

procedure TppPrintable.SetBounds(aLeft, aTop, aWidth, aHeight: Single);
var
  lPrinter: TObject;

begin
  lPrinter := GetPrinter;

  mmSetBounds( ppToMMThousandths(aLeft,   FUnits, pprtHorizontal, lPrinter),
               ppToMMThousandths(aTop,    FUnits, pprtVertical,   lPrinter),
               ppToMMThousandths(aWidth,  FUnits, pprtHorizontal, lPrinter),
               ppToMMThousandths(aHeight, FUnits, pprtVertical,   lPrinter) );

end;

{------------------------------------------------------------------------------}
{ TppPrintable.spSetBounds }

procedure TppPrintable.spSetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin

  mmSetBounds( ppToMMThousandths(aLeft,   utScreenPixels, pprtHorizontal, nil),
               ppToMMThousandths(aTop,    utScreenPixels, pprtVertical,   nil),
               ppToMMThousandths(aWidth,  utScreenPixels, pprtHorizontal, nil),
               ppToMMThousandths(aHeight, utScreenPixels, pprtVertical,   nil) );

end;

{------------------------------------------------------------------------------}
{ TppPrintable.mmSetBounds }

procedure TppPrintable.mmSetBounds(aLeft, aTop, aWidth, aHeight: LongInt);
begin

  if (FLeft <> aLeft) or (FTop <> aTop) then
    BeforePropertyChange('MoveBounds')
  else if (FWidth <> aWidth) or (FHeight <> aHeight) then
    BeforePropertyChange('ResizeBounds')
  else
    Exit; // nothing to do here

  FLeft   := aLeft;
  FTop    := aTop;
  FWidth  := aWidth;
  FHeight := aHeight;

  {notify report designer}
  BoundsChange;

  {notify report engine}
  Reset;

end; {procedure, SetBounds}

{------------------------------------------------------------------------------}
{ TppPrintable.Convert }

procedure TppPrintable.Convert(aVersionNo: Integer);
begin

  if (aVersionNo < 1270) then
    FDataField := FReportField;

  {convert properties from screen pixels to mmthousandths}
  if (aVersionNo < 2097) then
    begin
      FLeft   := ppToMMThousandths(FLeft,   utScreenPixels, pprtHorizontal, nil);
      FTop    := ppToMMThousandths(FTop,    utScreenPixels, pprtVertical,   nil);
      FWidth  := ppToMMThousandths(FWidth,  utScreenPixels, pprtHorizontal, nil);
      FHeight := ppToMMThousandths(FHeight, utScreenPixels, pprtVertical,   nil);
    end;

  if (aVersionNo < 3530) then
    UserName := Name;


end; {procedure, Convert}


{------------------------------------------------------------------------------}
{ TppPrintable.ConvertDataFieldNames }

procedure TppPrintable.ConvertDataFieldNames(aDataPipeline: TppDataPipeline; const aOldFieldName, aNewFieldName: String);
begin

  if (IsDataAware) and  (aDataPipeline = DataPipeline) and (ppEqual(FDataField, aOldFieldName)) then
    FDataField := aNewFieldName;

end; {procedure, ConvertDataFieldNames}

{------------------------------------------------------------------------------}
{ TppPrintable.ResolvePipelineReferences }

procedure TppPrintable.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  lDataPipeline: TppDataPipeline;
begin

  {set DataPipeline property rather than FDataPipeline -}
  if (IsDataAware) and (FDataPipeline = nil) and (FDataPipelineName <> '') then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FDataPipelineName);
      SetDataPipeline(lDataPipeline);
    end;

end; {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppPrintable.FixupPipelineReferences }

procedure TppPrintable.FixupPipelineReferences(aDataPipeline: TppDataPipeline; const aOldUserName: String);
begin

  if (IsDataAware) and (FDataPipeline <> nil) and (FDataPipeline.UserName = aOldUserName) then
    SetDataPipeline(aDataPipeline);

end; {procedure, FixupPipelineReferences}


{------------------------------------------------------------------------------}
{ TppPrintable.SetUnits }

procedure TppPrintable.SetUnits(aUnits: TppUnitType);
begin
  FUnits := aUnits;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.GetLeft }

function TppPrintable.GetLeft: Single;

begin

  Result := ppFromMMThousandths(FLeft, FUnits, pprtVertical, GetPrinter);

end; {procedure, GetLeft}

{------------------------------------------------------------------------------}
{ TppPrintable.SetLeft }

procedure TppPrintable.SetLeft(Value: Single);
begin

  {used for conversion to 3.0}
  if (csReading in ComponentState) then
    FLeft := Trunc(Value)
  else
    SetMMLeft( ppToMMThousandths(Value, FUnits, pprtVertical, GetPrinter) );

end;  {procedure, SetLeft}

{------------------------------------------------------------------------------}
{ TppPrintable.SetMMLeft }

procedure TppPrintable.SetMMLeft(Value: LongInt);
begin
  BeforePropertyChange('MoveBounds');

  FLeft := Value;

  {notify report designer}
  BoundsChange;

  {notify report engine}
  Reset;

end; {procedure, SetMMLeft}

{------------------------------------------------------------------------------}
{ TppPrintable.GetTop }

function TppPrintable.GetTop: Single;
begin

  Result := ppFromMMThousandths(FTop, FUnits, pprtVertical, GetPrinter);

end; {procedure, GetTop}

{------------------------------------------------------------------------------}
{ TppPrintable.SetTextAlignment }

procedure TppPrintable.SetTextAlignment(Value: TppTextAlignment);
begin
  if FTextAlignment <> Value then
    begin

      if (Value = taFullJustified) and (not AllowsJustification) then Exit; 

      BeforePropertyChange('TextAlignment');

      FTextAlignment := Value;

      Case FTextAlignment of
        taRightJustified:
          FAlignment := taRightJustify;
        taCentered:
          FAlignment := taCenter;
        else
          FAlignment := taLeftJustify;
      end;

      InvalidateDesignControl;
      AdjustBounds;
      PropertyChange;
    end;
end; {procedure, SetTextAlignment}

{------------------------------------------------------------------------------}
{ TppPrintable.SetTop }

procedure TppPrintable.SetTop(Value: Single);
begin

  {used for conversion to 3.0}
  if (csReading in ComponentState) then
    FTop := Trunc(Value)
  else
    SetMMTop(ppToMMThousandths(Value, FUnits, pprtVertical, GetPrinter));

end; {procedure, SetTop}

{------------------------------------------------------------------------------}
{ TppPrintable.SetMMTop }

procedure TppPrintable.SetMMTop(Value: Longint);
begin
  BeforePropertyChange('MoveBounds');

  FTop := Value;

  {notify report designer}
  BoundsChange;

  {notify report engine}
  Reset;

end; {procedure, SetMMTop}

{------------------------------------------------------------------------------}
{ TppPrintable.GetWidth }

function TppPrintable.GetWidth: Single;
begin

  Result := ppFromMMThousandths(FWidth, FUnits, pprtVertical, GetPrinter);

end; {procedure, GetWidth}

{------------------------------------------------------------------------------}
{ TppPrintable.SetWidth }

procedure TppPrintable.SetWidth(Value: Single);
begin

  {used for conversion to 3.0}
  if (csReading in ComponentState) then
    FWidth := Trunc(Value)
  else
    SetMMWidth(ppToMMThousandths(Value, FUnits, pprtVertical, GetPrinter));

end; {procedure, SetWidth}

{------------------------------------------------------------------------------}
{ TppPrintable.SetMMWidth }

procedure TppPrintable.SetMMWidth(Value: Longint);
begin
  BeforePropertyChange('ResizeBounds');

  FWidth := Value;

  BoundsChange;

  {notify report engine}
  Reset;

end; {procedure, SetMMWidth}

{------------------------------------------------------------------------------}
{ TppPrintable.GetHeight }

function TppPrintable.GetHeight: Single;
begin

  Result := ppFromMMThousandths(FHeight, FUnits, pprtVertical, GetPrinter);

end; {procedure, GetHeight}

{------------------------------------------------------------------------------}
{ TppPrintable.SetHeight }

procedure TppPrintable.SetHeight(Value: Single);
begin

 {used for conversion to 3.0}
  if (csReading in ComponentState) then
    FHeight := Trunc(Value)
  else
    SetMMHeight(ppToMMThousandths(Value, FUnits, pprtVertical, GetPrinter));

end; {procedure, SetHeight}

{------------------------------------------------------------------------------}
{ TppPrintable.SetMMHeight }

procedure TppPrintable.SetMMHeight(Value: Longint);
begin
  BeforePropertyChange('ResizeBounds');

  FHeight := Value;

  {notify report designer}
  BoundsChange;

  {notify report engine}
  Reset;

end; {procedure, SetMMHeight}

{------------------------------------------------------------------------------}
{ TppPrintable.GetScreenPixelLeft }

function TppPrintable.GetScreenPixelLeft: Integer;
begin

  Result := Trunc(ppFromMMThousandths(FLeft, utScreenPixels, pprtHorizontal, nil));

end; {procedure, GetScreenPixelLeft}

{------------------------------------------------------------------------------}
{ TppPrintable.GetScreenPixelTop }

function TppPrintable.GetScreenPixelTop: Integer;
begin

  Result := Trunc(ppFromMMThousandths(FTop, utScreenPixels, pprtVertical, nil));

end; {procedure, GetScreenPixelTop}

{------------------------------------------------------------------------------}
{ TppPrintable.GetScreenPixelWidth }

function TppPrintable.GetScreenPixelWidth: Integer;
begin

  Result := Trunc(ppFromMMThousandths(FWidth, utScreenPixels, pprtHorizontal, nil));

end; {procedure, GetScreenPixelWidth}

{------------------------------------------------------------------------------}
{ TppPrintable.GetScreenPixelHeight }

function TppPrintable.GetScreenPixelHeight: Integer;
begin

  Result := Trunc(ppFromMMThousandths(FHeight, utScreenPixels, pprtVertical, nil));

end; {procedure, GetScreenPixelHeight}

{------------------------------------------------------------------------------}
{ TppPrintable.SetScreenPixelLeft }

procedure TppPrintable.SetScreenPixelLeft(Value: Integer);
begin
  SetMMLeft( ppToMMThousandths(Value, utScreenPixels, pprtHorizontal, nil) );
end; {procedure, SetScreenPixelLeft}

{------------------------------------------------------------------------------}
{ TppPrintable.SetScreenPixelTop }

procedure TppPrintable.SetScreenPixelTop(Value: Integer);
begin
  SetMMTop( ppToMMThousandths(Value, utScreenPixels, pprtVertical, nil) );
end; {procedure, SetScreenPixelTop}

{------------------------------------------------------------------------------}
{ TppPrintable.SetScreenPixelWidth }

procedure TppPrintable.SetScreenPixelWidth(Value: Integer);
begin
  SetMMWidth( ppToMMThousandths(Value, utScreenPixels, pprtHorizontal, nil) );
end; {procedure, SetScreenPixelWidth}

{------------------------------------------------------------------------------}
{ TppPrintable.SetScreenPixelHeight }

procedure TppPrintable.SetScreenPixelHeight(Value: Integer);
begin
  SetMMHeight( ppToMMThousandths(Value, utScreenPixels, pprtVertical, nil) );
end; {procedure, SetScreenPixelHeight}

{------------------------------------------------------------------------------}
{ TppPrintable.DefineProperties}

procedure TppPrintable.DefineProperties(Filer: TFiler);
var
  lAncestor: TppPrintable;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppPrintable) then
    lAncestor := TppPrintable(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> lAncestor.FDataPipeline);
      Filer.DefineProperty('mmHeight', ReadHeight, WriteHeight, FHeight <> lAncestor.FHeight);
      Filer.DefineProperty('mmLeft', ReadLeft, WriteLeft, FLeft <> lAncestor.FLeft);
      Filer.DefineProperty('mmTop', ReadTop, WriteTop, FTop <> lAncestor.FTop);
      Filer.DefineProperty('mmWidth', ReadWidth, WriteWidth, FWidth <> lAncestor.FWidth);
    end
  else
    begin
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> nil);
      Filer.DefineProperty('mmHeight', ReadHeight, WriteHeight, True);
      Filer.DefineProperty('mmLeft', ReadLeft, WriteLeft, True);
      Filer.DefineProperty('mmTop', ReadTop, WriteTop, True);
      Filer.DefineProperty('mmWidth', ReadWidth, WriteWidth, True);
    end;


  {used for conversion to 3.0}
  Filer.DefineProperty('DataSource', ReadDataSource, nil, False);
  Filer.DefineProperty('OnFormatText', ReadOnFormatText, nil, False);
  Filer.DefineProperty('Region', ReadRegion, nil, False);
  Filer.DefineProperty('ReportField', ReadReportField, nil, False);
  Filer.DefineProperty('ParentDataSource', ReadParentDataSource, nil, False);
  Filer.DefineProperty('Alignment', ReadAlignment, nil, False);

end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadDataPipelineName }

procedure TppPrintable.ReadDataPipelineName(Reader: TReader);
begin
  FDataPipelineName := Reader.ReadString;

end; {procedure, ReadDataPipelineName}

{------------------------------------------------------------------------------}
{ TppPrintable.WriteDataPipelineName }

procedure TppPrintable.WriteDataPipelineName(Writer: TWriter);
begin
  if (FDataPipeline <> nil) then
    Writer.WriteString(FDataPipeline.Name)
  else
    Writer.WriteString('');

end; {procedure, WriteDataPipelineName}

{------------------------------------------------------------------------------}
{ TppPrintable.ReadAlignment }

procedure TppPrintable.ReadAlignment(Reader: TReader);
var
  lsValue: String;
begin
  lsValue := Reader.ReadIdent;

  if lsValue = csAlignLeftIdent then
    Alignment := taLeftJustify
  else if lsValue = csAlignCenterIdent then
    Alignment := taCenter
  else if lsValue = csAlignRightIdent then
    Alignment := taRightJustify;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadLeft }

procedure TppPrintable.ReadLeft(Reader: TReader);
begin
  FLeft := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadHeight }

procedure TppPrintable.ReadHeight(Reader: TReader);
begin
  FHeight := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadRegion }

procedure TppPrintable.ReadRegion(Reader: TReader);
begin
  Reader.ReadIdent;
end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadTop }

procedure TppPrintable.ReadTop(Reader: TReader);
begin
  FTop := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadWidth }

procedure TppPrintable.ReadWidth(Reader: TReader);
begin
  FWidth := ppReadIntegerPropValue(Reader);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.WriteLeft }

procedure TppPrintable.WriteLeft(Writer: TWriter);
begin
  Writer.WriteInteger(FLeft);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.WriteHeight}

procedure TppPrintable.WriteHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FHeight);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.WriteTop}

procedure TppPrintable.WriteTop(Writer: TWriter);
begin
  Writer.WriteInteger(FTop);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.WriteWidth}

procedure TppPrintable.WriteWidth(Writer: TWriter);
begin
  Writer.WriteInteger(FWidth);
end;

{------------------------------------------------------------------------------}
{ TppPrintable.ReadOnFormatText }

procedure TppPrintable.ReadOnFormatText(Reader: TReader);
begin

  Reader.ReadIdent;

end; {procedure, ReadOnFormatText}

{------------------------------------------------------------------------------}
{ TppPrintable.ReadReportField }

procedure TppPrintable.ReadReportField(Reader: TReader);
begin

  FReportField := Reader.ReadString;

end; {procedure, ReadReportField}

{------------------------------------------------------------------------------}
{ TppPrintable.ReadParentDataSource }

procedure TppPrintable.ReadParentDataSource(Reader: TReader);
begin

  {eat the value}
  Reader.ReadBoolean;

end; {procedure, ReadParentDataSource}

{------------------------------------------------------------------------------}
{ TppPrintable.ReadDataSource }

procedure TppPrintable.ReadDataSource(Reader: TReader);
begin

  {eat the value}
  FDataSource := Reader.ReadIdent;

end; {procedure, ReadDataSource}

{------------------------------------------------------------------------------}
{ TppPrintable.PageStart }

procedure TppPrintable.PageStart;
begin

end; {procedure, PageStart}


{******************************************************************************
 *
 ** P R I N T A B L E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppPrintableRTTI.RefClass }

class function TraTppPrintableRTTI.RefClass: TClass;
begin
  Result := TppPrintable;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppPrintableRTTI.GetEventList }

class procedure TraTppPrintableRTTI.GetEventList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetEventList(aClass, aPropList);

end; {class procedure, GetEventList}

{------------------------------------------------------------------------------}
{ TraTppPrintableRTTI.GetParams }

class function TraTppPrintableRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (ppEqual(aMethodName, 'OnDrawCommandCreate')) or (ppEqual(aMethodName, 'OnDrawCommandClick')) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aDrawCommand', daClass, TObject, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}


{------------------------------------------------------------------------------}
{ TraTppPrintableRTTI.GetPropRec }

class function TraTppPrintableRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if (CompareText(aPropName, 'OnPrint') = 0) then
    EventToRec(aPropName, ciComponentPrint, False, aPropRec)

  else if (CompareText(aPropName, 'OnDrawCommandCreate') = 0) then
    EventToRec(aPropName, ciPrintableDrawCommandCreate, True, aPropRec)

  else if (CompareText(aPropName, 'OnDrawCommandClick') = 0) then
    EventToRec(aPropName, ciPrintableDrawCommandClick, True, aPropRec)


  {properties & methods}
  else if (CompareText(aPropName, 'Alignment') = 0) then
    EnumPropToRec(aPropName, 'TAlignment', False, aPropRec)

  else if (CompareText(aPropName, 'AutoSize') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Caption') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'DataField') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'DataPipeline') = 0) then
    ClassPropToRec(aPropName, TppDataPipeline, False, aPropRec)

  else if (CompareText(aPropName, 'DefaultPropHint') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'DefaultPropName') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'DefaultPropEditType') = 0) then
    EnumPropToRec(aPropName, 'TppPropEditType', True, aPropRec)

  else if (CompareText(aPropName, 'Description') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'DrawComponent') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'Font') = 0) then
    ClassPropToRec(aPropName, TFont, False, aPropRec)

  else if (CompareText(aPropName, 'GenerationComplete') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'Height') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'Left') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'LookupPipeline') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'mmLeft') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'mmHeight') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'mmTop') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'mmWidth') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'OutOfSpace') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'OverFlow') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'ParentHeight') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'ParentWidth') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'ReprintOnOverFlow') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'ResetOnCompute') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'ShiftWithParent') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'SpaceUsed') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'spLeft') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'spHeight') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'spTop') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'spWidth') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'StretchWithParent') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Text') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'Top') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'Units') = 0) then
    EnumPropToRec(aPropName, 'TppUnitType', False, aPropRec)

  else if (CompareText(aPropName, 'Visible') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Width') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'WordWrap') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'ZOrder') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppPrintableRTTI.GetPropValue }

class function TraTppPrintableRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin
  Result := True;

  if (CompareText(aPropName, 'Alignment') = 0) then
    TAlignment(aValue) := TppPrintable(aObject).Alignment

  else if (CompareText(aPropName, 'AutoSize') = 0) then
    Boolean(aValue) := TppPrintable(aObject).AutoSize

  else if (CompareText(aPropName, 'Caption') = 0) then
    String(aValue) := TppPrintable(aObject).Caption

  else if (CompareText(aPropName, 'DataField') = 0) then
    String(aValue) := TppPrintable(aObject).DataField

  else if (CompareText(aPropName, 'DataPipeline') = 0) then
    Integer(aValue) := Integer(TppPrintable(aObject).DataPipeline)

  else if (CompareText(aPropName, 'DefaultPropHint') = 0) then
    String(aValue) := TppPrintable(aObject).DefaultPropHint

  else if (CompareText(aPropName, 'DefaultPropName') = 0) then
    String(aValue) := TppPrintable(aObject).DefaultPropName

  else if (CompareText(aPropName, 'DefaultPropEditType') = 0) then
    TppPropEditType(aValue) := TppPrintable(aObject).DefaultPropEditType

  else if (CompareText(aPropName, 'Description') = 0) then
    String(aValue) := TppPrintable(aObject).Description

  else if (CompareText(aPropName, 'DrawComponent') = 0) then
    Integer(aValue) := Ord(TppPrintable(aObject).DrawComponent)

  else if (CompareText(aPropName, 'Font') = 0) then
    Integer(aValue) := Integer(TppPrintable(aObject).Font)

  else if (CompareText(aPropName, 'GenerationComplete') = 0) then
    Integer(aValue) := Ord(TppPrintable(aObject).GenerationComplete)

  else if (CompareText(aPropName, 'Height') = 0) then
    Single(aValue) := TppPrintable(aObject).Height

  else if (CompareText(aPropName, 'Left') = 0) then
    Single(aValue) := TppPrintable(aObject).Left

  else if (CompareText(aPropName, 'LookupPipeline') = 0) then
    Integer(aValue) := Ord(TppPrintable(aObject).LookupPipeline)

  else if (CompareText(aPropName, 'mmLeft') = 0) then
    Integer(aValue) := TppPrintable(aObject).mmLeft

  else if (CompareText(aPropName, 'mmHeight') = 0) then
    Integer(aValue) := TppPrintable(aObject).mmHeight

  else if (CompareText(aPropName, 'mmTop') = 0) then
     Integer(aValue) := TppPrintable(aObject).mmTop

  else if (CompareText(aPropName, 'mmWidth') = 0) then
    Integer(aValue) := TppPrintable(aObject).mmWidth

  else if (CompareText(aPropName, 'OutOfSpace') = 0) then
    Integer(aValue) := Ord(TppPrintable(aObject).OutOfSpace)

  else if (CompareText(aPropName, 'OverFlow') = 0) then
    Integer(aValue) := Ord(TppPrintable(aObject).OverFlow)

  else if (CompareText(aPropName, 'ParentHeight') = 0) then
    Boolean(aValue) := TppPrintable(aObject).ParentHeight

  else if (CompareText(aPropName, 'ParentWidth') = 0) then
    Boolean(aValue) := TppPrintable(aObject).ParentWidth

  else if (CompareText(aPropName, 'ReprintOnOverFlow') = 0) then
    Boolean(aValue) := TppPrintable(aObject).ReprintOnOverFlow

  else if (CompareText(aPropName, 'ResetOnCompute') = 0) then
    Boolean(aValue) := TppPrintable(aObject).ResetOnCompute

  else if (CompareText(aPropName, 'ShiftWithParent') = 0) then
    Boolean(aValue) := TppPrintable(aObject).ShiftWithParent

  else if (CompareText(aPropName, 'SpaceUsed') = 0) then
    Integer(aValue) := TppPrintable(aObject).SpaceUsed

  else if (CompareText(aPropName, 'spLeft') = 0) then
    Integer(aValue) := TppPrintable(aObject).spLeft

  else if (CompareText(aPropName, 'spHeight') = 0) then
    Integer(aValue) := TppPrintable(aObject).spHeight

  else if (CompareText(aPropName, 'spTop') = 0) then
    Integer(aValue) := TppPrintable(aObject).spTop

  else if (CompareText(aPropName, 'spWidth') = 0) then
    Integer(aValue) := TppPrintable(aObject).spWidth

  else if (CompareText(aPropName, 'StretchWithParent') = 0) then
    Boolean(aValue) := TppPrintable(aObject).StretchWithParent

  else if (CompareText(aPropName, 'Text') = 0) then
    String(aValue) := TppPrintable(aObject).Text

  else if (CompareText(aPropName, 'Top') = 0) then
    Single(aValue) := TppPrintable(aObject).Top

  else if (CompareText(aPropName, 'Units') = 0) then
    TppUnitType(aValue) := TppPrintable(aObject).Units

  else if (CompareText(aPropName, 'Visible') = 0) then
    Boolean(aValue) := TppPrintable(aObject).Visible

  else if (CompareText(aPropName, 'Width') = 0) then
    Single(aValue) := TppPrintable(aObject).Width

  else if (CompareText(aPropName, 'WordWrap') = 0) then
    Boolean(aValue) := TppPrintable(aObject).WordWrap

  else if (CompareText(aPropName, 'ZOrder') = 0) then
    Integer(aValue) := TppPrintable(aObject).ZOrder

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppPrintableRTTI.SetPropValue }

class function TraTppPrintableRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Alignment') = 0) then
    TppPrintable(aObject).Alignment := TAlignment(aValue)

  else if (CompareText(aPropName, 'AutoSize') = 0) then
    TppPrintable(aObject).AutoSize := Boolean(aValue)

  else if (CompareText(aPropName, 'Caption') = 0) then
    TppPrintable(aObject).Caption := String(aValue)

  else if (CompareText(aPropName, 'DataField') = 0) then
    TppPrintable(aObject).DataField := String(aValue)

  else if (CompareText(aPropName, 'DataPipeline') = 0) then
    TppPrintable(aObject).DataPipeline := TppDataPipeline(aValue)

  else if (CompareText(aPropName, 'Font') = 0) then
    TppPrintable(aObject).Font := TFont(aValue)

  else if (CompareText(aPropName, 'Height') = 0) then
    TppPrintable(aObject).Height := Single(aValue)

  else if (CompareText(aPropName, 'Left') = 0) then
    TppPrintable(aObject).Left := Single(aValue)

  else if (CompareText(aPropName, 'ParentHeight') = 0) then
    TppPrintable(aObject).ParentHeight := Boolean(aValue)

  else if (CompareText(aPropName, 'ParentWidth') = 0) then
    TppPrintable(aObject).ParentWidth := Boolean(aValue)

  else if (CompareText(aPropName, 'ReprintOnOverFlow') = 0) then
    TppPrintable(aObject).ReprintOnOverFlow := Boolean(aValue)

  else if (CompareText(aPropName, 'ShiftWithParent') = 0) then
    TppPrintable(aObject).ShiftWithParent := Boolean(aValue)

  else if (CompareText(aPropName, 'spLeft') = 0) then
    TppPrintable(aObject).spLeft := Integer(aValue)

  else if (CompareText(aPropName, 'spHeight') = 0) then
    TppPrintable(aObject).spHeight := Integer(aValue)

  else if (CompareText(aPropName, 'spTop') = 0) then
    TppPrintable(aObject).spTop := Integer(aValue)

  else if (CompareText(aPropName, 'spWidth') = 0) then
    TppPrintable(aObject).spWidth := Integer(aValue)

  else if (CompareText(aPropName, 'StretchWithParent') = 0) then
    TppPrintable(aObject).StretchWithParent := Boolean(aValue)

  else if (CompareText(aPropName, 'Text') = 0) then
    TppPrintable(aObject).Text := String(aValue)

  else if (CompareText(aPropName, 'Top') = 0) then
    TppPrintable(aObject).Top := Single(aValue)

  else if (CompareText(aPropName, 'Units') = 0) then
    TppPrintable(aObject).Units := TppUnitType(aValue)

  else if (CompareText(aPropName, 'Visible') = 0) then
    TppPrintable(aObject).Visible := Boolean(aValue)

  else if (CompareText(aPropName, 'Width') = 0) then
    TppPrintable(aObject).Width := Single(aValue)

  else if (CompareText(aPropName, 'WordWrap') = 0) then
    TppPrintable(aObject).WordWrap := Boolean(aValue)
    
  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}




initialization

  raRegisterRTTI(TraTppPrintableRTTI);

finalization

  raUnRegisterRTTI(TraTppPrintableRTTI);

end.
