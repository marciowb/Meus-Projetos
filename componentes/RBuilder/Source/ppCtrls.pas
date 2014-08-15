{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                    BBBBB   }

unit ppCtrls;

interface

{$I ppIfDef.pas}

{.$DEFINE CodeSite}

uses
  {$IFDEF CodeSite}csIntf,{$ENDIF}
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  JPEG,
{$IFDEF Delphi11}
  GIFImg,
{$ELSE}
  ppGIFImage,
{$ENDIF}
{$IFDEF Delphi12}
  PNGImage,
{$ENDIF}

  ppComm,
  ppDB,
  ppClass,
  ppTypes,
  ppUtils,
  ppDevice,
  ppPrnabl,
  ppStrtch,
  ppDrwCmd,
  ppRTTI;

type

  {@TppCustomComponent

    Ancestor from which all static-size components descend. The standard
    static classes provided with ReportBuilder are:

            - TppCustomText
            - TppCustomGraphic
            - TppCustomImage}
            
  TppCustomComponent = class(TppComponent)
    private

    protected
      {used for conversion to 3.0}
      procedure ReadShiftWithBand(Reader: TReader);
      procedure ReadStretchWithBand(Reader: TReader);
      procedure DefineProperties(Filer: TFiler); override;

      procedure CalcPrintPosition; virtual;
      procedure CalcSpaceUsed; virtual;
      function  ParentOverFlow: Boolean;
      function  ParentStretch: Boolean;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Generate; override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      
    published
      property OnDrawCommandClick;
      property OnDrawCommandCreate;


  end; {class, TppCustomComponent }

{******************************************************************************
 *
 ** C U S T O M    C L A S S E S
 *
{******************************************************************************}

  {@TppCustomText

    Ancestor from which all textual components descend. The standard
    textual components provided with ReportBuilder are:

            - TppDBCalc
            - TppDBText
            - TppLabel
            - TppSystemVariable
            - TppVariable}

  {@TppCustomText.Angle

    Use the Angle property to display rotated text.

    The Angle property controls the angle at which the text component is to be
    displayed.  All angles must be whole numbers and are calculated in degrees.
    Angle values between the values of 1 - 359 will rotate the text counter
    clockwise.  Alternatively angle values between -359 - -1 will rotate the
    text clockwise.  AutoSize and Text Alignment are supported for angled text.
    Wordwrapping is not supported for angled text. }

  {@TppCustomText.CharWrap

    Defaults to False. The CharWrap property determines if the individual
    characters of a word will be wrapped to the next line when a single
    word does fit within the width of the control.}

  {@TppCustomText.DisplayFormat

    The DisplayFormat property is used to control how data is formatted for a
    report.  For example, '#,0' would display 10000 as 10,000.  If the datafield
    is a date or time type, then you can use the standard formatting characters
    for those types ('mm/dd/yyyy', 'hh:nn:ss').

    DisplayFormat differs from the Delphi implementation in the case of string
    types.  In order to format strings, simply type a valid EditMask into the
    DisplayFormat property. ReportBuilder will then apply the EditMask to the
    string value.

    From the Report Designer you can access the DisplayFormat property by
    positioning the mouse cursor over the component and clicking the right mouse
    button.  A speed menu containing the key properties for the component will
    be displayed.  Select DisplayFormat... from this menu.  The DisplayFormat
    dialog will be displayed (note: if your DataSource is currently active,
    ReportBuilder will detect the underlying field type and provide a list of
    the more common formats for that type).}

  {@TppCustomText.Ellipsis

    Adds an ellipsis (...) to the end of truncated text.

    This property can be used to automaically add an ellipsis to the end of a
    piece of truncated text (non autosized).  This can be useful when trying to
    keep all text on a single line while still letting the person viewing the
    report know the text has been truncated.

    Note that Ellipsis and AutoSize cannot be used at the same time.}

  {@TppCustomText.Hyperlink

    The Hyperlink property contains the internet location the text object will
    navigate to if it is clicked inside the viewer.

    When a valid web address or email address is assigned to the Hyperlink
    property, the text object becomes clickable in the viewer window and will
    navigate to the proper location once clicked using the default web browser
    or email client.}

  {@TppCustomText.HyperlinkColor

    Defines the font color given to a text object with the Hyperlink property
    assigned.}

  {@TppCustomText.HyperlinkEnabled

    Toggles the hyperlink feature for the individual text component.
    Setting this property to False will remove hyperlink recognition and will
    ignore the HyperLink property when previewing.}

  {@TppCustomText.OnFormat

    The OnFormat event fires each time the text of the component is
    formatted. The DisplayFormat parameter contains the format. The Value
    parameter contains the value of the field associated with the
    component, in it's native format.  Use the DataType parameter to
    typecast the Value property and save it in a variable of the
    appropriate type. Then format the value and convert it to a string. Use
    the Text parameter is used to return the formatted value. OnFormat is
    used when custom display formats have been created. Custom display
    formats require the developer to supply the formatting logic for the
    component.}
    
  {@TppCustomText.OnGetText

    The OnGetText event fires each time the component's Text property is
    referenced. This enables you to override the value of the Text
    property.

    Note: If you need to group on a custom text field (TppVariable,
    TppLabel,..) you must add code to this event handler to control the
    value of the Text rather than use the OnPrint or OnCalc event. This is
    necessary due to the timing of when each of these events fire.}

  {@TppCustomText.Save

    The Save property controls whether a textual component will be included
    when printing to a text file.  The order the component will be saved
    in, in relation to other components within the band is determined by
    the SaveOrder property.}

  {@TppCustomText.SaveLength

    When printing to a text file with the TextFileType set to
    ftFixedLength, the SaveLength property specifies the field size for the
    components text value.  If the component text value is greater than
    this length, it is truncated.  If the text value length is less than
    the SaveLength, then spaces are padded onto the value.  Spaces are
    padded on the left, right, or both(for centered) depending on the
    Alignment property of the component}

  {@TppCustomText.SaveOrder

    When printing to a text file with the property determines the relative
    position of the textual component within the line of text for the band.}

  TppCustomText  = class(TppCustomComponent)
    private
      FAlreadyPrinted: Boolean;
      FAngle: Integer;
      FBreakFieldForGroups: TList;
      FCharWrap: Boolean;
      FDisplayFormat: String;
      FEllipsis: Boolean;
      FFirstPage: Integer;
      FFirstColumn: Integer;
      FHyperLinkEnabled: Boolean;
      FHyperlink: string;
      FHyperlinkAuto: string;
      FHyperlinkColor: TColor;
      FRotatedOrigin: TPoint;
      FStdFontColor: TColor;
      FSaveOrder: Integer;
      FSave: Boolean;
      FSaveLength: Integer;
      FOnGetText: TppGetTextEvent;
      FOnFormat: TppFormatEvent;

      {used for conversion to 3.1}
      FOnSave: String;
      FPriorValue: String;
      FPriorValueSame: Boolean;
      FReprintOnSubsequent: Boolean;
      FSuppressRepeatedValues: Boolean;
      FWrappedText: TStringList;

      function  GetDisplayFormat: String;
      function  GetSaveOrder: TTabOrder;
      procedure SetAngle(Value: Integer);
      procedure SetSaveOrder(Value: TTabOrder);
      procedure SetCharWrap(Value: Boolean);
      procedure SetHyperlink(Value: string);
      procedure SetSave(Value: Boolean);
      procedure SetSaveLength(Value: Integer);

      procedure CalcStandardBounds;
      procedure CalcRotatedBounds;
      function  CalcClientRect(aClientRect: TRect): TRect;
      function  CalcTextWidthInReportUnits(aText: String; aFont: TFont): Double;
      function  FormatTextWithEllipsis(aText: String): String;

      function  EmailAddressDetected(aCaption: String): Boolean;
      function GetHyperlink: string;
      function  HyperLinkDetected(aCaption: string): Boolean;

      {used for conversion to 3.0}
      procedure ReadOnSave(Reader: TReader);

      procedure ReadRotatedOriginLeft(Reader: TReader);
      procedure ReadRotatedOriginTop(Reader: TReader);
      procedure SetReprintOnSubsequent(Value: Boolean);
      procedure SetSuppressRepeatedValues(Value: Boolean);
      procedure UpdateValues;
      procedure WriteRotatedOriginLeft(Writer: TWriter);
      procedure WriteRotatedOriginTop(Writer: TWriter);
      procedure SetHyperlinkColor(const Value: TColor);
      procedure SetHyperLinkEnabled(const Value: Boolean);
      procedure UpdateHyperlinkFont;

    protected
      {used for conversion to 3.1}
      procedure DefineProperties(Filer: TFiler); override;

      procedure AdjustBounds; override;
      procedure BoundsChange; override;
      procedure CalcSpaceUsed; override;
      procedure ColumnStart; virtual;
      procedure FontChanged(Sender: TObject); override;
      function  GetDescription: String; override;
      function  GetTheText: String; virtual;
      function  ProcessHyperlink(aText: string): Boolean; virtual;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetAutoSize(Value: Boolean); override;
      procedure SetBand(aBand: TppBand); override;
      procedure SetCaption(Value: String); override;
      procedure SetDisplayFormat(const aFormat: String); virtual;
      procedure SetEllipsis(Value: Boolean); virtual;
      procedure SetName(const Value: TComponentName); override;
      procedure SetTextAlignment(Value: TppTextAlignment); override;
      procedure SetWordWrap(Value: Boolean); override;

      {protected so TppLabel doesn't have to implement it}
      property DisplayFormat: String read GetDisplayFormat write SetDisplayFormat;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure AddBreakFieldForGroup(aGroup: TppGroup);
      procedure Clear; override;
      procedure Convert(aVersionNo: Integer); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure RemoveBreakFieldForGroup(aGroup: TppGroup);
      function  GetText: String; override;
      function  GetTextBuf: PChar;
      function  GetTheSaveOrder: TTabOrder;
      procedure Init; override;
      procedure PageStart; override;
      procedure UpdateSaveOrder(Value: TTabOrder);
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;

      property AutoSize default True;
      property Color; {needs to be at least public for ppDesigner}
      property Description: String read GetDescription;
      property Ellipsis: Boolean read FEllipsis write SetEllipsis;
      property OnFormat: TppFormatEvent read FOnFormat write FOnFormat;
      property FirstPage: Integer read FFirstPage write FFirstPage;
      property FirstColumn: Integer read FFirstColumn write FFirstColumn;
      property AlreadyPrinted: Boolean read FAlreadyPrinted write FAlreadyPrinted;
      property PriorValue: String read FPriorValue write FPriorValue;
      property PriorValueSame: Boolean read FPriorValueSame write FPriorValueSame;
      property RotatedOrigin: TPoint read FRotatedOrigin;
      property SuppressRepeatedValues: Boolean read FSuppressRepeatedValues write SetSuppressRepeatedValues default False;
      property ReprintOnSubsequent: Boolean read FReprintOnSubsequent write SetReprintOnSubsequent default False;
      property Transparent;

      {used for conversion to 3.1}
      property OnSave: String read FOnSave;

    published
      property Angle: Integer read FAngle write SetAngle default 0;
      property CharWrap: Boolean read FCharWrap write SetCharWrap default False;
      property HyperlinkEnabled: Boolean read FHyperLinkEnabled write SetHyperLinkEnabled default True;
      property Hyperlink: string read GetHyperlink write SetHyperlink;
      property HyperlinkColor: TColor read FHyperlinkColor write SetHyperlinkColor;
      property OnGetText: TppGetTextEvent read FOnGetText write FOnGetText;
      property ReprintOnOverFlow;
      property SaveOrder: TTabOrder read GetSaveOrder write SetSaveOrder default -1;
      property Save: Boolean read FSave write SetSave default False;
      property SaveLength: Integer read FSaveLength write SetSaveLength default 0;
      property UserName;

  end; {class, TppCustomText}


  {@TppCustomImage

    Ancestor from which all image components descend. The standard image
    components provided with ReportBuilder are:

            - TppDBImage
            - TppImage}

  {@TppCustomImage.AlignHorizontal

    This property determines the horizontal alignment of an image inside the
    control.  An image can be aligned horizontally using the following types:

    - ahLeft
    - ahCenter
    - ahRight}

  {@TppCustomImage.AlignVertical

    This property determines the vertical alignment of an image inside the
    control.  An image can be aligned vertically using the following types:

    - avTop
    - avCenter
    - avBottom}

  {TppCustomImage.Center

    The Center property determines whether the image is centered inside the
    control.

    From the Report Designer you can access the Center property by
    positioning the mouse cursor over the component and clicking the right
    mouse button.  A speed menu containing the key properties for the
    component will be displayed.  The Center option should be near the top
    of the speedmenu.  If it is checked, centering is on.  Selecting the
    Center option from this menu will toggle its value.}

  {@TppCustomImage.DirectDraw

    This property indicates whether the image will be sent directly to the
    printer or to an intermediate bitmap and then copied to the printer.  If you
    are having difficulty getting an image to print correctly on the printer,
    try setting this property to True.}

  {@TppCustomImage.Font

    Design-time only.  This property allows you to set the font that will be
    displayed for the control at design-time.

    Use the Format Bar in the Report Designer to control the Name, Size and
    Style of the font.  To set the Font color, select the Graphics Palette
    option from the Tools menu, then click the left mouse button on the desired
    color.  This will set the Font and/or Pen Color for all selected
    components.}

  {@TppCustomImage.MaintainAspectRatio

    Determines whether an image is scaled proportionally.

    Set the MaintainAspectRatio to true when you want a scaled image to maintain
    its original width to height ratio. (Note: Use the Stretch property to
    determine whether the image is scaled. If Stretch is false then the value of
    MaintainAspectRatio is ignored.)

    Defaults to False.

    From the Report Designer you can access the MaintainAspectRatio property by
    positioning the mouse cursor over the component and clicking the right mouse
    button.  A speed menu containing the key properties for the component will
    be displayed.  If the MaintainAspectRatio property is checked and Stretch is
    also checked, the image will be scaled.  Selecting the MaintainAspectRatio
    option will toggle its value.}

  {@TppCustomImage.Picture

    The Picture property contains the graphical image that is printed by an
    image report control..

    For a TppDBImage, the Picture property is a run-time property only.

    For TppImage, you can set the Picture property at design-time or run-time.
    You can access the Picture property at design-time by positioning the mouse
    cursor over the component and clicking the right mouse button.  A speed menu
    containing the key properties for the component will be displayed.  Select
    the Picture option and a dialog will be displayed.  You can use this dialog
    to select your picture file.}

  {@TppCustomImage.Stretch

    For report images, the Stretch property determines whether the image is
    scaled to fit inside the component.

    When Stretch is set to true, you can determine whether the image is
    scaled proportionally by setting the MaintainAspectRatio property.

    Defaults to False.

    From the Report Designer you can access the Stretch property by
    positioning the mouse cursor over the component and clicking the right
    mouse button.  A speed menu containing the key properties for the
    component will be displayed.  If the Stretch property is checked, the
    image will be scaled.  Selecting the Stretch option will toggle its
    value.}

  TppCustomImage = class(TppCustomComponent)
    private
      FAlignHorizontal: TppAlignHorizontalType;
      FAlignVertical: TppAlignVerticalType;
      FMaintainAspectRatio: Boolean;
      FPicture : TPicture;
      FStretch : Boolean;
      FDirectDraw: Boolean;
      FImageID: Integer;

      procedure SetCenter(Value: Boolean);
      procedure SetDirectDraw(Value: Boolean);
      procedure SetMaintainAspectRatio(Value: Boolean);
      procedure SetStretch(Value: Boolean);
      function  GetCenter: Boolean;

      {read/write private properties}
      procedure ReadCenter(Reader: TReader);

    protected
      procedure DefineProperties(Filer: TFiler); override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure PictureChanged(Sender: TObject); virtual;
      procedure CalcPrintPosition; override;
      function  GetCaption: String; override;
      function  GetPicture: TPicture; virtual;
      procedure SetAlignHorizontal(Value: TppAlignHorizontalType); virtual;
      procedure SetAlignVertical(const Value: TppAlignVerticalType); virtual;
      procedure SetAutoSize(Value: Boolean); override;
      procedure SetPicture(aPicture: TPicture); virtual;
      procedure SetTransparent(Value: Boolean); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Convert(aVersionNo: Integer); override;
      function  HasColor: Boolean; override;
      function  HasFont: Boolean; override;
      procedure Init; override;

      property  Picture: TPicture read GetPicture write SetPicture;
      property  Center: Boolean read GetCenter write SetCenter;

    published
      property AlignHorizontal: TppAlignHorizontalType read FAlignHorizontal write SetAlignHorizontal;
      property AlignVertical: TppAlignVerticalType read FAlignVertical write SetAlignVertical;
      property AutoSize; {needed to be redeclared in this class so the DocOMatic can parse the topic comment}
      property DirectDraw: Boolean read FDirectDraw write SetDirectDraw default False;
      property Font stored False;
      property MaintainAspectRatio: Boolean read FMaintainAspectRatio write SetMaintainAspectRatio;
      property ReprintOnOverFlow;
      property Stretch: Boolean read FStretch write SetStretch default False;
      property Transparent default False;
      property Visible;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;

  end; {class, TppCustomImage}


  {@TppCustomGraphic

    Ancestor from which all graphic components descend. The standard
    graphic components provided with ReportBuilder are:

            - TppLine
            - TppShape}

  {@TppCustomGraphic.Brush

    The Brush property determines the fill color and pattern of a TppShape
    report control.

    To set the Brush.Color from the Report Designer, select the Graphics
    Palette option on the Tools menu, then click the right mouse button on
    the desired color.  This will set the Brush Color (BC) for all selected
    components.}

  {@TppCustomGraphic.Pen

    The Pen property determines the frame color and frame width the of a
    TppShape report control.

    Use the Report Designer's Color Palette to set the Pen's Color and
    Width.

    Note: When set to zero, Pen.Width behaves differently than in Delphi.
    The zero value is used as an indicator for hairlines.  If you want a
    shape or line to draw with the thinnest line your printer is capable
    of, set Pen.Width to zero.  In print preview, the shape or line will
    look the same as a one-pixel width line, however, when printed it will
    look thinner (how much thinner depends on the capabilities of your 
    printer.)  This feature can be used to considerably improve the
    appearance of reports where one-pixel width lines are looking too
    heavy.}

  TppCustomGraphic = class(TppCustomComponent)
    private
      FBrush: TBrush;
      FPen: TPen;

    protected
      procedure SetBrush(aBrush: TBrush); virtual;
      procedure SetPen(aPen: TPen); virtual;

      {notify object when style changed}
      procedure StyleChanged(Sender: TObject); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure GetBackgroundColor(var aColor: TColor; var aIsClear: Boolean); override;
      procedure GetForegroundColor(var aColor: TColor; var aIsClear: Boolean); override;
      function  HasFont: Boolean; override;
      procedure SetBackgroundColor(aColor: TColor; aIsClear: Boolean); override;
      procedure SetForegroundColor(aColor: TColor; aIsClear: Boolean); override;
      procedure SetPenWidth(aWidth: Integer); override;

      property Brush: TBrush read FBrush write SetBrush;
      property Pen: TPen read FPen write SetPen;

  end; {class, TppCustomGraphic }



{******************************************************************************
 *
 ** C U S T O M    T E X T    C L A S S E S
 *
{******************************************************************************}

  {@TppLabel

    The TppLabel component is a report control that displays text on a
    report.  Report labels are typically used for report titles, column
    headings, group headings, etc.  The text of a label is the value of its
    Caption property.  How the text of the caption aligns within the label
    is determined by the value of the Alignment property.  You can have the
    label resize automatically to fit a changing caption if you set the
    AutoSize property to True. Use the Angle property to rotate the text.  Set
    the WordWrap property to True if you the want the text to wrap rather than
    be truncated to fit inside the control.

    You can control the appearance of this component (Font, Alignment,
    etc.) at design-time by using the Format Bar of the Report Designer.
    The Format Bar also allows you to set the Caption property from an edit
    box at the far left.  You can also set key properties by using the
    speed menu.  To access the speed menu, position the mouse cursor over
    the component and click the right mouse button.}

  TppLabel = class(TppCustomText)
    private

    protected
      function  GetDefaultPropHint: String; override;
      procedure SetUserName(const Value: TComponentName); override;

    public
      constructor Create(aOwner: TComponent); override;
      property Alignment;

    published
      property Anchors;
      property AutoSize;
      property Border;
      property Caption;
      property Color;
      property Ellipsis;
      property Font;
      property HyperLink;
      property HyperlinkColor;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property TextAlignment;
      property Transparent;
      property UserName;
      property Visible;
      property WordWrap;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;

  end; {class, TppLabel}


  {@TppDBText

    The TppDBText component is a data-aware report control that is used to print
    text from a database field.  The database field that is printed is the value
    of the DataField property.  To avoid printing the same data on consecutive
    detail lines set the SuppressRepeatedValues property to true.  When
    SuppressRepeatedValues is set to True you can enable the field value to
    reprint on the first detail line of a new page by setting the
    ReprintOnSubsequent property to True.

    The text of a TppDBText control is the value of its Caption property.  Use the
    DisplayFormat property to control how the text is formatted.  How the text of
    the caption aligns within the label is determined by the value of the Alignment
    property.  You can have the control resize automatically to fit a changing
    caption if you set the AutoSize property to True.Use the Angle property to
    rotate the text. Set the WordWrap property to True if you the want the text
    to wrap rather than be truncated to fit inside the control.

    You can control the appearance of this component (Font, Alignment, etc.) at
    design-time by using the Format Bar of the Report Designer. The Format Bar also
    allows you to set the DataField property from a drop down list box at the far
    left.  You can also set key properties by using the speed menu.  To access the
    speed menu, position the mouse cursor over the component and click the right
    mouse button.}

  {@TppDBText.BlankWhenZero

    When the DataField value is equal to zero, the BlankWhenZero property
    allows you to print a blank instead of a 0.

    Defaults to False.

    From the Report Designer you can access the BlankWhenZero property by
    positioning the mouse cursor over the component and clicking the right
    mouse button.  A speed menu containing the key properties for the
    component will be displayed.  The BlankWhenZero option should be near the
    top of the speedmenu.  If it is checked, BlankWhenZero is on.  Selecting
    the BlankWhenZero option from this menu will toggle its value.}

  {@TppDBText.ReprintOnSubsequent

    The ReprintOnSubsequent property is used in conjunction with the
    SuppressRepeatedValues property.  When SuppressRepeatedValues is set to
    True, and detail lines have overflowed onto a new page, you can force
    DataField to reprint on the first detail line of the new page by setting
    ReprintOnSubsequent to True

    Defaults to False.

    To set the ReprintOnSubsequent property from the Report Designer, position
    your mouse cursor over the component and click the right mouse button.  The
    ReprintOnSubsequent option will be displayed in the speedmenu.  If it is
    checked, ReprintOnSubsequent is on.  Selecting the ReprintOnSubsequent
    option from this menu will toggle its value.}

  {@TppDBText.ResetGroup

    The ResetGroup property is used to specify a control group for a report
    calculation.  Each time the data value of the field specified by the Group's
    BreakName property changes, the calculated value of the TppDBCalc control is
    reset to zero, and the calculation begins again.

    When the ResetGroup property is nil, it can be set by dragging the report
    control into a GroupHeader or a GroupFooter band.  This property can also be
    set by accessing the calculations dialog from the speed menu for the report
    control.

    Note: For DBText components, the ResetGroup property can be used to control
    the behavior of the SuppressRepeatedValues property.  Normally the DBText
    component tracks the text value of a field, suppressing any repeated values.
    It does this without any regard to group breaks which may have a occurred.
    By associating a DBText component with group, you can force a DBText
    component to reprint when the group breaks.}

  {@TppDBText.SuppressRepeatedValues

    Defaults to False. When the value of a field (as determined by the DataField
    property) is the same across several records, the SuppressRepeatedValues
    property allows you to print the value only once each time the field value
    changes. This can be useful in reports where a highly redundant field has
    been included in the detail band (for example, the City field in a report
    containing addresses.)  If the detail band overflows onto a new page or
    column, you can force the suppressed value to print again by using the
    ReprintOnSubsequent property.

    You can use the ResetGroup property to further control the behavior of
    SuppressRepeatedValues.  Normally the DBText component tracks the text value
    of the field, suppressing any repeated values.  It does this without any
    regard to group breaks which may have occurred.  By associating a DBText
    component with a group, you can force values to reprint whenever the group
    breaks, regardless of whether the text value was the same for the previous
    record.

    To set the SuppressRepeatedValues property from the Report Designer,
    position your mouse cursor over the component and click the right mouse
    button.  The SuppressRepeatedValues option will be displayed in the
    speedmenu.  If it is checked, SuppressRepeatedValues is on.  Selecting the
    SuppressRepeatedValues option from this menu will toggle its value.}

  TppDBText = class(TppCustomText)
    private
      FBlankWhenZero: Boolean;
      FFieldValue: Variant;
      FFieldDataType: TppDataType;
      FCurrentValue: String;
      FJustRestored: Boolean;

      function  GetFieldValue: Variant;
      procedure SetBlankWhenZero(Value: Boolean);
      procedure UpdateValues;

    protected
      procedure CalcSpaceUsed; override;
      function  GetDescription: String; override;
      function  GetTheText: String; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetDataField(const Value: String); override;
      procedure SetDisplayFormat(const aFormat: String); override;
      procedure SetUserName(const Value: TComponentName); override;
      procedure RestorePriorValue; virtual;

   public
      constructor Create(aOwner: TComponent); override;
      destructor  Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      procedure Compute; override;
      function  IsCalc: Boolean; override;
      function  IsDataAware: Boolean; override;
      procedure Init; override;
      procedure PageStart; override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;

      property Alignment;
      property FieldValue: Variant read GetFieldValue;

    published
      property Anchors;
      property AutoSize default False;
      property BlankWhenZero: Boolean read FBlankWhenZero write SetBlankWhenZero default False;
      property Border;
      property Color;
      property DataField;
      property DataPipeline;
      property DisplayFormat;
      property Ellipsis;
      property Font;
      property Hyperlink;
      property HyperlinkColor;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property ParentDataPipeline;
      property ReprintOnSubsequent;
      property ResetGroup;
      property SuppressRepeatedValues;
      property TextAlignment;
      property Transparent;
      property UserName;
      property Visible;
      property WordWrap;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;

      {events}
      property OnFormat;

  end; {class, TppDBText}


  TppLookAheadList = class;

  {@TppDBCalc

    The TppDBCalc component is a data-aware report component used to
    perform common report calculations and print the resulting value.  The
    calculation is performed based on the value of the field specified in
    DataField  Use the DBCalcType property to indicate the necessary
    calculation.

    Calculations such as group totals are available through ResetGroup
    property.  Each time the field value for the Reset Group changes
    (breaks), all associated DBCalc components are reset to zero.

    You can do custom calculations based on the current Value of a DBCalc.
    You can also control the Divsior for average calculations.

    Use the DisplayFormat property to control how the text is formatted.
    Text alignment of the caption is determined by the value of the
    Alignment property.  You can force the control to resize to fit a 
    changing caption by setting the AutoSize property to True.  Use the Angle
    property to rotate the text.

    You can control the appearance of this component (Font, Alignment,
    etc.) at design-time by using the Format Bar of the Report Designer.
    The Format Bar also allows you to set the DataField property from a
    drop down list box at the far left.  You can also set key properties by
    using the speed menu.  To access the speed menu, position the mouse
    cursor over the component and click the right mouse button.}

  {@TppDBCalc.DBCalcType

    The DBCalcType property determines what type of report information is
    calculated and printed on the report.  This property can be set from the
    report control's speed menu.

    For report group calculations you can use the ResetGroup property to enable
    a calculated value to be reset to zero each time the value of the field
    changes.

    <Table>
    Value	      Meaning
    ---------   ---------
    dcCount	    Count one for each group of records where the ResetGroup field
                value is the same
    dcSum	Sum   data values for each group of records where the ResetGroup
                field value is the same
    dcMinimum	  Minimum data value for each group of records where the
                ResetGroup field value is the same
    dcMaximum	  Maximum data value for each group of records where the
                ResetGroup field value is the same
    dcAverage	  Average of all data values for each group of records where the
                ResetGroup field value is the same
    </Table>}

  {@TppDBCalc.Divisor

    Run-time only. The Divisor property is applicable only when the value of the
    DBCalcType property is dcAverage.  You can use this property to control the
    value of the divisor used in the average calculation.

    As an example, this property could be used to to exclude all zero values
    from the average calculation.  Simply exclude all the occurrences of non-zero
    values in the OnCalc event handler by decrementing the Divisor property.}

  {@TppDBCalc.LookAhead

    LookAhead is designed to allow you to display summary calculations in the
    title band, page footer calculations in the page header band, group footer
    calculations in the group header band and column footer calculations in the
    column header.

    When the LookAhead property is set to True, the draw command which
    represents the component on the rendered page will continue to update with
    the most recent calculation value until the report completes the generation
    of the associated page, group or column.

    Note: The Report.PassSetting property must be set to psTwoPass, in
    order for LookAhead calculations to function reliably.}

  {@TppDBCalc.OnCalc

    The OnCalc event fires after the calculation for the component has been
    performed. Unlike the OnPrint event this event occurs once for each record
    in the DataSet.  Use the OnCalc event handler when you want to perform
    calculations based on the component.}

  {@TppDBCalc.Value

    Run-time only. The Value property contains the value of the calculation.
    You can use this property as the basis for other calculations or to change
    the value dynamically as the report is printing.  An example of the use of
    this property would be to set its value in the OnGroupBreak event handler,
    thus creating an initial value for the calculations.}

  {@TppDBCalc.OnGroupBreak

    The OnGroupBreak event fires once at the beginning of the Report and
    subsequently each time the group specified by the ResetGroup property
    breaks.  Use the OnGroupBreak event to set the initial value on which
    calculations should be based.

    Note: The timing of OnGroupBreak is after the TppDBCalc has been reset to
    zero and before the calculation for the current record.}

  TppDBCalc = class(TppDBText)
    private
      FDBCalcType: TppDBCalcType;
      FDivisor: Double;
      FJustSaved: Boolean;
      FLookAhead: Boolean;
      FLookAheadList: TppLookAheadList;
      FOnCalc: TNotifyEvent;
      FOnGroupBreak: TNotifyEvent;
      FValue: Double;
      FCacheableDivisor: Double;
      FCacheableValue: Double;
      FPriorDivisor: Double;
      FPriorValue: Double;

      function  CanCalcLookAheads: Boolean;
      function ComputeInitialValue: Double;
      function ComputeValueForCalcType(aValue: Double): Double;
      function  GetIDNo1: Integer;
      function  GetIDNo2: Integer;
      function  GetReportKey: String;
      function  GetTraversalCount: Integer;
      function  GetValue: Variant;
      procedure InitLookAhead;
      procedure SetDBCalcType(aDBCalcType: TppDBCalcType);
      procedure SetValue(aValue: Variant);
      procedure SetLookAhead(aValue: Boolean);

   protected
      function  GetDescription: String; override;
      function  GetTheText: String; override;
      function  IsGroupBased: Boolean; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetBand(aBand: TppBand); override;
      procedure RestorePriorValue; override;

   public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Clear; override;
      procedure Compute; override;
      procedure EndOfMainReport; override;
      function GetLookAheadKey: String;
      function GetLookAheadValue(const aLookAheadKey: String): String;
      procedure  Init; override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      procedure StartOfMainReport; override;
      procedure UpdateLookAheadTotal;

      property Divisor: Double read FDivisor write FDivisor;
      property Value: Variant read GetValue write SetValue;

    published
      property Anchors;
      property Border;
      property DBCalcType: TppDBCalcType read FDBCalcType write SetDBCalcType default dcSum;
      property LookAhead: Boolean read FLookAhead write SetLookAhead default False;
      property OnCalc: TNotifyEvent read FOnCalc  write FOnCalc;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property OnGroupBreak: TNotifyEvent read FOnGroupBreak  write FOnGroupBreak;

  end; {class, TppDBCalc}


  {@TppLookAheadList }
  TppLookAheadList = class(TList)
    private
      FOwner: TppCommunicator;

      function  AddTotal(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String): TppDrawVariable;
      function  FindTotal(const aLookAheadKey: String): TppDrawVariable;
      procedure FreeTotals;
      procedure SendCalcNotify(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String);

    public
      constructor CreateList(aOwner: TppCommunicator);
      destructor Destroy; override;

      procedure Clear; override;

      function  RetrieveTotal(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String): String;
      procedure UpdateTotal(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String);
      procedure SignOffTotals;
      
  end; {class, TppLookAheadList}

{******************************************************************************
 *
 ** C U S T O M    G R A P H I C    C L A S S E S
 *
{******************************************************************************}

  {@TppShape

    The TppShape component is used to print graphical shapes.  The shape
    that is printed is determined by the value of the Shape Property.  The
    Pen and Brush properties are used to set the outline color and interior
    color of the shape.  Set the StretchWithParent property to True if you
    want the Height of the shape to stretch with the band (this only occurs
    when the shape shares a band with a memo component and the memo
    component is stretching).

    The TppShape component is very useful for giving reports a distinctive,
    professional look.

    Use the Report Designer's Format Bar to set the Shape property and to
    BringToFront or SendToBack.  Use the Graphics Palette to set the Pen
    Color (PC) Brush Color (BC) and Pen Width.  To access the speed menu
    for this component, position your mouse cursor over the component and
    click the right mouse button.}

  {@TppShape.Shape

    The Shape property determines what type of shape is printed on the report.
    This property can be set from the combo box on the Format Bar.

    <Table>
    Value	          Meaning
    -------------   --------
    stEllipse	      Ellipse
    stRectangle	    Rectangle
    stRoundRect	    Rectangle with rounded corners
    stRoundSquare   Square with rounded corners
    stSquare	      Square
    stCircle	      Circle
    </Table>}

  {@TppShape.Gradient

    The Gradient property allows the shape to be filled with a two color gradient
    effect rather than a solid color.  See the TppGradient topic for more
    information.}

  TppShape = class(TppCustomGraphic)
    private
{$IFDEF NewRect}
      FOldStyle: Boolean;
{$ENDIF}
      FShapeType: TShapeType;
      FGradient: TppGradient;

      procedure SetGradient(Value: TppGradient);
      procedure SetShape(aShapeType: TShapeType);

    protected
      function  GetDefaultPropHint: String; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

      procedure StyleChanged(Sender: TObject); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure CalcDimensions(var aLeft, aTop, aRight, aBottom, aXCornerRound, aYCornerRound: Longint);
      procedure Convert(aVersionNo: Integer); override;
      procedure GetDefaultPropEnumNames(aList: TStrings); override;

    published
      property Anchors;
      property Brush;
      property Gradient: TppGradient read FGradient write SetGradient;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property ParentHeight;
      property ParentWidth;
      property Pen;
      property ReprintOnOverFlow;
      property Shape: TShapeType read FShapeType write SetShape default stRectangle;
      property StretchWithParent;
      property UserName;
      property Visible;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
{$IFDEF NewRect}
      property OldStyle: Boolean read FOldStyle write FOldStyle default False;
{$ENDIF}
      property Top stored False;
      property Width stored False;

  end; {class, TppShape}


  {@TppLine

    Use TppLine to print vertical or horizontal lines.  The orientation of
    the line is determined by the value of the Position property.  Use the
    Style property to control whether a single or double line is printed.
    The Pen property is used to control the line's color and width.  Set
    the StretchWithBand property to True if you want the Height of the line
    to stretch as the band stretches (this only occurs when a memo
    component is stretching and the band PrintHeight property has been set
    to phDynamic).

    The TppLine component is very useful for giving reports a distinctive,
    professional look.  Double Style lines are great for underscoring
    report totals.

    Use the Report Designer's Format Bar to set the Position property and
    to BringToFront or SendToBack.  Use the Graphics Palette to set the Pen
    Color (PC) and Pen.Width.  To access the speed menu for this component,
    position your mouse cursor over the component and click the right mouse
    button.}

  {@TppLine.Position

    The Position property determines the orientation of the line within the
    component.

    <Table>
    Value		     Meaning
    ---------    --------------
    lpTop		     Horizontal line at top of the report control.
    lpBottom	   Horizontal line at bottom of the report control.
    lpLeft		   Vertical line along left side of the report control.
    lpRight		   Vertical line along right side of the report control.
    lpDiagLeft   Diagonal line from upper left to lower right
    lpDiagRight  Diagonal line from upper right to lower left
    </Table>

    To set this property at design-time, use the drop down combo box on the far
    left of the Format Bar.}

  {@TppLine.Style

    The Style property determines whether a single or double line is printed.
    Double lines are useful for report totals.

    The Style property can be set from the report control's speed menu.

    <Table>
    Value		      Meaning
    ---------     -------------
    lsSingle	    Single line is printed.
    lsDouble	    Two parallel lines are printed.
    </Table>

    To set the Style property from the Report Designer, position your mouse
    cursor over the component and click the right mouse button.  Two menu
    options will be available at the top of the speed menu, Single and Double.
    The style that is currently selected will be checked.}

  {@TppLine.Weight

    This property determines the width of the line. It is expressed in points,
    which are roughly equivalent to 1/72nd of an inch. This is the property
    which is set when you select a line width from the Draw toolbar.}

  TppLine = class(TppCustomGraphic)
    private
      FOldPenWidth: Integer;
      FPosition: TppLinePositionType;
      FSettingWeight: Boolean;
      FStyle: TppLineStyleType;
      FWeight: Single;

      procedure SetPosition(aLinePosition: TppLinePositionType);
      procedure SetStyle(aLineStyle: TppLineStyleType);
      procedure SetWeight(aWeight: Single);

    protected
      function  GetDefaultPropHint: String; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

      procedure StyleChanged(Sender: TObject); override;

    public
      constructor Create(aOwner: TComponent); override;

      procedure Convert(aVersionNo: Integer); override;
      procedure GetDefaultPropEnumNames(aList: TStrings); override;
      function  HasColor: Boolean; override;

    published
      property Anchors;
      property Border;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property Pen;
      property ParentHeight;
      property ParentWidth;
      property Position: TppLinePositionType read FPosition write SetPosition default lpTop;
      property ReprintOnOverFlow;
      property StretchWithParent;
      property Style: TppLineStyleType read FStyle write SetStyle default lsSingle;
      property UserName;
      property Visible;
      property Weight: Single read FWeight write SetWeight;

      {these properties saved in 'fake' properties}
      property Height stored False;
      property Left stored False;
      property Top stored False;
      property Width stored False;

  end; {class, TppLine}


{******************************************************************************
 *
 ** C U S T O M    I M A G E    C L A S S E S
 *
{******************************************************************************}


 {@TppImage

    Use the TppImage report component to print a graphical image.  The
    image that is printed is determined by the value of the Picture
    Property.  Set the AutoSize property to True if you want the report
    control to resize to accommodate the size of the picture.  Set the
    Stretch property to True if you want to scale the picture to fit inside
    the component.

    From the Report Designer you can set the key properties for this
    component by positioning the mouse cursor over the component and
    clicking the right mouse button.  A speed menu will be displayed.}

  TppImage = class(TppCustomImage)
    protected
      procedure PictureChanged(Sender: TObject); override;

    public

    published
      property Anchors;
      property AutoSize;
      property Border;
      property DirectDraw;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property Picture;

  end; {class, TppImage}

  {@TppDBImage

    The TppDBImage component is a data-aware report control that is used to
    print a graphical image stored in a database field, such as a BLOB
    field.  The image that is printed is determined by the value of the
    DataField property. Set the Stretch property to True if you want to
    scale the picture to fit inside the report control.

    To set the DataField property from the Report Designer, use the combo
    box on the far left of the Format Bar. You can also set key properties
    by using the speed menu.  To access the speed menu, position the mouse
    cursor over the component and click the right mouse button.}

  {@TppDBImage.AutoDisplay

    The value of the AutoDisplay property determines whether to automatically
    display the contents of a BLOB in a database field in a TppDBMemo or
    TppDBImage component. If AutoDisplay is True (the default value), the
    component automatically displays new data when the underlying BLOB field
    changes (such as when moving to a new record). If AutoDisplay is False, the
    control clears whenever the underlying BLOB field changes.

    Note: You might want to change the value of AutoDisplay to False if the
    automatic loading of BLOB fields seems to take too long.}

  {@TppDBImage.GraphicType

    Defaults to 'Bitmap'. The GraphicType indicates the kind TGraphicClass
    object which needs to be created to successfully load the image from the
    database.  The following options are provided with ReportBuilder.

    <Table>
    Value	      Meaning
    --------    ---------
    AutoDetect  Auto-detects the graphic type by examining the blob stream header
    Bitmap	    Instantiates an instance of TBitmap, into which the contents of
                the BLOB field are loaded.
    Icon	      Instantiates an instance of TIcon, into which the contents of
                the BLOB field are loaded.
    Metafile	  Instantiates an instance of TMetafile, into which the contents
                of the BLOB field are loaded.
    JPEG	      Instantiates an instance of TJPEGImage, into which the contents
                of the BLOB field are loaded. You will need to add the ppJPEG
                unit to the uses clause of your application in order to
                successfully load JPEGs.
    GIF	        Instantiates an instance of TGIFImage, into which the contents
                of the BLOB field are loaded. You will need to add the ppGIF
                unit to the uses clause of your application in order to
                successfully load GIFs.
    </Table>

    Note: Any TGraphicClass descendant can be registered and used with the
    DBImage component.  For an example of registering a TGraphicClass with
    ReportBuilder, see the ppJPEG or ppGIF unit.}

  {@TppDBImage.OnGetPicture

    The OnGetPicture event fires before the data in the BLOB field is assigned
    to Picture property.  Use the OnGetPicture event when you want manipulate
    the contents of the BLOB field and assign the resulting Picture manually.
    This would allow you to decompress a BLOB field and then assign the result
    as a Picture.  If you create an OnGetPicture event handler, the DBImage
    component will not attempt to assign the BLOB field to the Picture property
    at run-time.}

  TppDBImage = class(TppCustomImage)
    private
      FAutoDisplay: Boolean;
      FGraphicType: String;
      FOnGetPicture: TppPictureEvent;

      procedure DoOnGetPicture(Sender: TObject; aPicture: TPicture);
      function GetGraphicClass: TGraphicClass;
      function GetGraphicClassForStream(aStream: TStream): TGraphicClass;

    protected
      function  GetDescription: String; override;
      function  GetPicture: TPicture; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetAutoDisplay(Value: Boolean);
      procedure SetDataField(const Value: String); override;

      procedure SetGraphicType(aGraphicType: String);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      function  IsDataAware: Boolean; override;
      procedure LoadPicture; virtual;

      property GraphicClass: TGraphicClass read GetGraphicClass;

    published
      property Anchors;
      property Border;
      property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
      property DataField;
      property DataPipeline;
      property DirectDraw;
      property GraphicType: String read FGraphicType write SetGraphicType;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property OnGetPicture: TppPictureEvent read FOnGetPicture write FOnGetPicture;
      property ParentDataPipeline;

  end; {class, TppDBImage}


{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppCustomTextRTTI }
  TraTppCustomTextRTTI = class(TraTppComponentRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class procedure GetEventList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCustomTextRTTI}

  {@TraTppCustomImageRTTI }
  TraTppCustomImageRTTI = class(TraTppComponentRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCustomImageRTTI}

  {@TraTppDBImageRTTI }
  TraTppDBImageRTTI = class(TraTppCustomImageRTTI)
  private
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppDBImageRTTI}

  {@TraTppCustomGraphicRTTI }
  TraTppCustomGraphicRTTI = class(TraTppComponentRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppCustomGraphicRTTI}

  {@TraTppLineRTTI }
  TraTppLineRTTI = class(TraTppCustomGraphicRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppLineRTTI}

  {@TraTppShapeRTTI }
  TraTppShapeRTTI = class(TraTppCustomGraphicRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppShapeRTTI}

  {@TraTppDBTextRTTI }
  TraTppDBTextRTTI = class(TraTppCustomTextRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDBTextRTTI}

  {@TraTppDBCalcRTTI }
  TraTppDBCalcRTTI = class(TraTppDBTextRTTI)
    public
      class function GetParams(const aMethodName: String): TraParamList; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppDBCalcRTTI}

type

  {TppGraphicDetector

    used by DBImage to auto-detect the graphic type stored in a blob stream}
  TppGraphicDetector = class
  protected
    class function StartsWith(aText, aSubString: AnsiString): Boolean; overload;
    class function StartsWith(aBytes: TBytes; aWords: array of word): Boolean; overload;
    class function IsEMFStream(aStream: TStream): Boolean;
    class function IsWMFStream(aStream: TStream): Boolean;
  public
    class function CreateInstance(aStream: TStream): TGraphic;
    class function GetGraphicClass(aStream: TStream): TGraphicClass;
    class function GetGraphicType(aFileName: String): String; overload;
    class function GetGraphicType(aStream: TStream): string; overload;
  end;

  procedure ppRegisterGraphicClass(aName: String; aGraphicClass: TGraphicClass);
  procedure ppUnRegisterGraphicClass(aGraphicClass: TGraphicClass);
  function  ppGetGraphicClassForName(aName: String): TGraphicClass;

  function ppGraphicClasses: TStringList;


var
  ppShape: TppShape;
  ppLine:  TppLine;

implementation

uses
  ppEngine, ppBands, ppRegion, ppPrintr, ppPlainText, ppRotatedText, ppSubRpt, ppStrUtils, ActiveX;

var
  FGraphicClasses: TStringList = nil;

const
  cIgnore = 'Ignore'; // do not localize

{******************************************************************************
 *
 ** C U S T O M   C O M P O N E N T
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppCustomComponent.Create }

constructor TppCustomComponent.Create(aOwner: TComponent);
begin

  inherited Create(AOwner);

  CacheRecordSize  := SizeOf(TppCustomComponentSaveRec);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomComponent.Destroy }

destructor TppCustomComponent.Destroy;
begin

   inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomComponent.ParentOverFlow }

function TppCustomComponent.ParentOverFlow: Boolean;
begin
  if (Parent is TppBand) then
    Result := TppCustomBand(Parent).OverFlow
  else
    Result := TppCustomRegion(Parent).OverFlow;
end; {function, ParentOverFlow}

{------------------------------------------------------------------------------}
{ TppCustomComponent.ParentStretch }

function TppCustomComponent.ParentStretch: Boolean;
begin
  if (Parent is TppBand) then
    Result := (Band.PrintHeight = phDynamic)
  else
    Result := TppCustomRegion(Parent).Stretch and (Band.PrintHeight = phDynamic);
end; {function, ParentStretch}

{------------------------------------------------------------------------------}
{ TppCustomComponent.Generate }

procedure TppCustomComponent.Generate;
begin

  {reset draw component, for reprintonoverflow}
  if ReprintOnOverFlow and (ParentOverFlow) then
    RedrawOnOverFlow;

  {fire OnPrint event}
  if not(Visible) and not(DrawComponent) then
    begin
      DoOnPrint;

      if Visible then
        DrawComponent := True;
    end
  else
    DoOnPrint;

  {allow component to draw, or indicate generation is complete}
  if DrawComponent and Visible then
    begin
      CalcPrintPosition;

      if not(OutOfSpace) then
        GenerationComplete := True;
    end
  else
    GenerationComplete := True;

end; {procedure, Generate}

{------------------------------------------------------------------------------}
{ TppCustomComponent.CalcPrintPosition }

procedure TppCustomComponent.CalcPrintPosition;
var
  lBand: TppCustomBand;
  lRegion: TppCustomRegion;
  llNewLeft: Longint;
  llNewTop: Longint;
  llNewHeight: Longint;
  lRect: TppRect;
  llRelativeTop: Longint;
  lMaxStretchable: TppStretchable;
//  llChange: Longint;
  lbPartialGeneration: Boolean;
  llPartialAdjustment: Longint;
  llPageBottom: Longint;
  llCurrentPosition: Longint;
begin

  lBand := TppCustomBand(Band);

  llNewLeft := lBand.PrintPosRect.Left + mmLeft;
  llNewHeight := mmHeight;

  {calc max stretchable and change in parent height}
//  llChange := 0;
  lMaxStretchable := nil;

  {determine parent's position and state}
  if Parent is TppBand then
    begin
      llCurrentPosition := lBand.CurrentPosition;
      llPageBottom := lBand.PageBottom;
      lbPartialGeneration := lBand.PartialGeneration;
      llPartialAdjustment := lBand.PartialAdjustment;

      llNewTop := lBand.PrintPosRect.Top + mmTop;

      if (lBand.SpaceUsed > 0) then
        begin
          lMaxStretchable := lBand.MaxStretchable;
//          llChange := lBand.SpaceUsed - lBand.mmHeight;
        end;

    end

  else
    begin
      lRegion := TppCustomRegion(Parent);

      llCurrentPosition := lRegion.CurrentPosition;
      llPageBottom := lRegion.PageBottom;
      lbPartialGeneration := lRegion.PartialGeneration;
      llPartialAdjustment := lRegion.PartialAdjustment;

      llNewTop := lRegion.PrintPosRect.Top + (mmTop - lRegion.mmTop);

      if (lRegion.SpaceUsed > 0) then
        begin
          lMaxStretchable := TppCustomRegion(Parent).MaxStretchable;
//          llChange := lRegion.SpaceUsed - lRegion.mmHeight;
        end;

    end;


  {adjust top and change for partial generation}
  if lbPartialGeneration then
    llNewTop := llNewTop - llPartialAdjustment;


  {adjust top if shifting with parent}
  if (ShiftWithParent) then
    begin

      {check whether space used > 0 or we're out of space}
      if (lMaxStretchable <> nil) and ((lMaxStretchable.SpaceUsed > 0) or (lMaxStretchable.OutOfSpace)) then
        begin
          llRelativeTop := mmTop - (lMaxStretchable.mmTop + lMaxStretchable.mmHeight);

          llNewTop := lMaxStretchable.PrintPosRect.Top + lMaxStretchable.SpaceUsed + llRelativeTop;
        end;

      // commented out this code that had been added, it causes problems
{      else
        begin
          llNewTop := llNewTop + llChange;

          // do not allow object to shift above the current print position
          if (llNewTop < llCurrentPosition) then
            llNewTop := llCurrentPosition;

        end;  }

    end;

  {adjust height if stretching with parent}
  if (StretchWithParent) then
    begin

      if (llNewTop < llCurrentPosition) then
        llNewHeight := llCurrentPosition - llNewTop;

      {if stretched beyond page, adjust stretch}
      if (llNewTop < llPageBottom) and ((llNewTop + llNewHeight) > llPageBottom) then
        llNewHeight := llPageBottom - llNewTop;
    end;

  {if we're out of space, exit}
  if ParentStretch and ((llNewTop + llNewHeight) > (llPageBottom + 1)) then
    begin
      OutOfSpace := True;

      Exit;
    end;

  {set print position}
  lRect.Left   := llNewLeft;
  lRect.Top    := llNewTop;
  lRect.Right  := lRect.Left + mmWidth;
  lRect.Bottom := lRect.Top + llNewHeight;

  PrintPosRect := lRect;

  {calc default space used}
  SpaceUsed := llNewHeight;

  {allow descendent to calculate space used}
  CalcSpaceUsed;

  {update print position}
  lRect.Left   := PrintPosRect.Left;
  lRect.Top    := PrintPosRect.Top;
  lRect.Right  := PrintPosRect.Right;
  lRect.Bottom := lRect.Top + SpaceUsed;

  PrintPosRect := lRect;

end; {procedure, CalcPrintPosition}

{------------------------------------------------------------------------------}
{ TppCustomComponent.CalcSpaceUsed}

procedure TppCustomComponent.CalcSpaceUsed;
begin

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppCustomComponent.RestoreFromCache }

procedure TppCustomComponent.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppCustomComponentSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent := lRec.FDrawComponent;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppCustomComponent.SaveToCache }

procedure TppCustomComponent.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppCustomComponentSaveRec;
begin

  lRec.FDrawComponent := DrawComponent;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}



{------------------------------------------------------------------------------}
{ TppCustomComponent.DefineProperties }

procedure TppCustomComponent.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  Filer.DefineProperty('ShiftWithBand', ReadShiftWithBand, nil, False);
  Filer.DefineProperty('StretchWithBand', ReadStretchWithBand, nil, False);

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppCustomComponent.ReadShiftWithBand }

procedure TppCustomComponent.ReadShiftWithBand(Reader: TReader);
begin
  ShiftWithParent := Reader.ReadBoolean;
end; {procedure, ReadShiftWithBand}

{------------------------------------------------------------------------------}
{ TppCustomComponent.ReadStretchWithBand }

procedure TppCustomComponent.ReadStretchWithBand(Reader: TReader);
begin
  StretchWithParent := Reader.ReadBoolean;
end; {procedure, ReadStretchWithBand}



{******************************************************************************
 *
 ** C U S T O M  T E X T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomText.Create }

constructor TppCustomText.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  SetDefaultAutoSize(True);
  Color            := clWhite;
  DrawCommandClass := TppDrawText;

  FCharWrap         := False;
  FDisplayFormat    := '';
  FHyperLink        := '';
  FHyperLinkColor   := clBlue;
  FHyperLinkEnabled := True;
  FStdFontColor     := Font.Color;
  FOnGetText        := nil;
  FSaveLength       := 0;
  FSaveOrder        := -1;

  FFirstPage              := -1;
  FFirstColumn            := -1;
  FPriorValue             := '';
  FPriorValueSame         := False;
  FReprintOnSubsequent    := False;
  FSuppressRepeatedValues := False;
  FAlreadyPrinted         := False;

  FBreakFieldForGroups := TList.Create;


  {used for conversion to 3.1}
  FOnSave := '';

  EventNotifies := EventNotifies + [ciEngineStartColumn];

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomText.Destroy }

destructor TppCustomText.Destroy;
var
  liGroup: Integer;
  lGroup: TppGroup;

begin

  {notify groups that their BreakField is history, if needed}
  for liGroup := (FBreakFieldForGroups.Count-1) downto 0 do
    begin
      lGroup := FBreakFieldForGroups[liGroup];
      lGroup.BreakName := '';
    end;

  FBreakFieldForGroups.Free;

  FWrappedText.Free;
  FWrappedText := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomText.SetCharWrap }

procedure TppCustomText.SetCharWrap(Value: Boolean);
begin

  if Printing then Exit;

  if (FCharWrap <> Value) then
    begin
      BeforePropertyChange('CharWrap');

      FCharWrap := Value;

      {repaint design control}
      InvalidateDesignControl;

      {notify report designer}
      PropertyChange;

      {notify report engine}
      Reset;
    end;

end; {procedure, SetCharWrap}

{------------------------------------------------------------------------------}
{ TppCustomText.DefineProperties }

procedure TppCustomText.DefineProperties(Filer: TFiler);
var
  lAncestor: TppCustomText;
begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppCustomText) then
    lAncestor := TppCustomText(Filer.Ancestor)
  else
    lAncestor := nil;

  {used for conversion to 3.1}
  Filer.DefineProperty('OnSave', ReadOnSave, nil, False);

  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('RotatedOriginLeft', ReadRotatedOriginLeft, WriteRotatedOriginLeft, (FRotatedOrigin.X <> lAncestor.FRotatedOrigin.X) and (Angle <> 0));
      Filer.DefineProperty('RotatedOriginTop', ReadRotatedOriginTop, WriteRotatedOriginTop, (FRotatedOrigin.Y <> lAncestor.FRotatedOrigin.Y) and (Angle <> 0));
    end
  else
    begin
      Filer.DefineProperty('RotatedOriginLeft', ReadRotatedOriginLeft, WriteRotatedOriginLeft, Angle <> 0);
      Filer.DefineProperty('RotatedOriginTop', ReadRotatedOriginTop, WriteRotatedOriginTop, Angle <> 0);
    end;

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppCustomText.ReadOnSave }

procedure TppCustomText.ReadOnSave(Reader: TReader);
begin
  FOnSave := Reader.ReadIdent;
end; {procedure, ReadOnSave}

{------------------------------------------------------------------------------}
{ TppCustomText.ReadRotatedOriginLeft }

procedure TppCustomText.ReadRotatedOriginLeft(Reader: TReader);
begin
  FRotatedOrigin.X := Reader.ReadInteger;

end; {procedure, ReadRotatedOriginLeft}

{------------------------------------------------------------------------------}
{ TppCustomText.ReadRotatedOriginTop }

procedure TppCustomText.ReadRotatedOriginTop(Reader: TReader);
begin
  FRotatedOrigin.Y := Reader.ReadInteger;

end; {procedure, ReadRotatedOriginTop}

{------------------------------------------------------------------------------}
{ TppCustomText.WriteRotatedOriginLeft }

procedure TppCustomText.WriteRotatedOriginLeft(Writer: TWriter);
begin
  Writer.WriteInteger(FRotatedOrigin.X);

end; {procedure, WriteRotatedOriginLeft}

{------------------------------------------------------------------------------}
{ TppCustomText.WriteRotatedOriginTop }

procedure TppCustomText.WriteRotatedOriginTop(Writer: TWriter);
begin
  Writer.WriteInteger(FRotatedOrigin.Y);
  
end; {procedure, WriteRotatedOriginTop}

{------------------------------------------------------------------------------}
{ TppCustomText.Convert }

procedure TppCustomText.Convert(aVersionNo: Integer);
begin
  inherited Convert(aVersionNo);

  if (aVersionNo < 3100) and (Band <> nil) and (Band.Report <> nil) and (FOnSave <> '') then
    Band.Report.AssignOnSave(FOnSave);

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppCustomText.AdjustBounds }

procedure TppCustomText.AdjustBounds;
begin
  if (csReading in ComponentState) then Exit;

  if Angle = 0 then
    CalcStandardBounds
  else
    CalcRotatedBounds;

end; {procedure, AdjustBounds}

{------------------------------------------------------------------------------}
{ TppCustomText.BoundsChange }

procedure TppCustomText.BoundsChange;
var
  lCanvas: TCanvas;
  lClientRect: TRect;
  lBitmap: TBitmap;
  lPrinter: TppPrinter;
begin

  inherited;

  if (Angle <> 0) and (Text <> '') then
    begin
      lPrinter := GetPrinter;

      if (lPrinter <> nil) then
        begin
          lBitmap := nil;
          lCanvas := lPrinter.Canvas;
          lClientRect := Rect(0, 0, Trunc(ppFromMMThousandths(mmWidth,  utPrinterPixels, pprtHorizontal, lPrinter)),
                                    Trunc(ppFromMMThousandths(mmHeight, utPrinterPixels, pprtVertical, lPrinter)));
        end
      else
        begin
          lBitmap := TBitmap.Create;
          lCanvas := lBitmap.Canvas;
          lClientRect := spClientRect;
        end;

      lBitmap.Free;

      FRotatedOrigin := TppRotatedText.CalcRotatedOrigin(lCanvas, Text, Font, mmWidth, mmHeight, Angle, AutoSize, Alignment, Border);
    end;

end; {procedure, BoundsChange}

{------------------------------------------------------------------------------}
{ TppCustomText.CalcStandardBounds }

procedure TppCustomText.CalcStandardBounds;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps:  array[Boolean] of Word = (0, DT_WORDBREAK);
var
  lPrinter: TppPrinter;
  lBitmap: TBitmap;
  lCanvas: TCanvas;
  lClientRect: TRect;
  lFlags: Word;
  lsCaption: String;
begin

  if Printing then Exit;

  if not(AutoSize) and WordWrap then Exit;

  {use printer dc to calculate text extent}
  lPrinter := GetPrinter;

  if (lPrinter <> nil) then
    begin
      lBitmap := nil;
      lCanvas := lPrinter.Canvas;
      lClientRect := Rect(0, 0, Trunc(ppFromMMThousandths(mmWidth,  utPrinterPixels, pprtHorizontal, lPrinter)),
                                Trunc(ppFromMMThousandths(mmHeight, utPrinterPixels, pprtVertical, lPrinter)));
    end
  else
    begin
      lBitmap := TBitmap.Create;
      lCanvas := lBitmap.Canvas;
      lClientRect := spClientRect;
    end;

  {calculate text extent}
  lCanvas.Font := Font;

  lFlags := DT_CALCRECT or DT_EXPANDTABS or Alignments[Alignment] or WordWraps[WordWrap] or DT_NOPREFIX  or DT_TOP or DT_EXTERNALLEADING;

  lsCaption := Caption;

  // do not allow height and width to be zero when designing
  if (Caption = '') then
    if not(Printing) then
      lsCaption := 'l';

  DrawText(lCanvas.Handle, PChar(lsCaption), Length(lsCaption), lClientRect, lFlags);

  lBitmap.Free;

  {convert printer pixels or screen pixels to microns}
  if (lPrinter <> nil) then
    lClientRect := Rect(0, 0, Trunc(ppToMMThousandths(lClientRect.Right,  utPrinterPixels, pprtHorizontal, lPrinter)),
                              Trunc(ppToMMThousandths(lClientRect.Bottom, utPrinterPixels, pprtVertical, lPrinter)))
  else
    lClientRect := Rect(0, 0, Trunc(ppToMMThousandths(lClientRect.Right,  utScreenPixels, pprtHorizontal, lPrinter)),
                              Trunc(ppToMMThousandths(lClientRect.Bottom, utScreenPixels, pprtVertical, lPrinter)));

  {Calculate the current client rectangle according to AutoSize and Border values}
  lClientRect := CalcClientRect(lClientRect);
  mmSetBounds(lClientRect.Left, lClientRect.Top, lClientRect.Right, lClientRect.Bottom);

end; {procedure, CalcStandardBounds}

{------------------------------------------------------------------------------}
{ TppCustomText.CalcRotatedBounds }

procedure TppCustomText.CalcRotatedBounds;
var
  lCanvas: TCanvas;
  lClientRect: TRect;
  lBitmap: TBitmap;
  lPrinter: TppPrinter;
  lsText: String;
begin

  lPrinter := GetPrinter;

  if (lPrinter <> nil) then
    begin
      lBitmap := nil;
      lCanvas := lPrinter.Canvas;
      lClientRect := Rect(mmLeft, mmTop, Trunc(ppFromMMThousandths(mmWidth,  utScreenPixels, pprtHorizontal, lPrinter)),
                                Trunc(ppFromMMThousandths(mmHeight, utScreenPixels, pprtVertical, lPrinter)));
    end
  else
    begin
      lBitmap := TBitmap.Create;
      lCanvas := lBitmap.Canvas;
      lClientRect := spClientRect;
    end;

  lsText := Text;

  // do not allow height and width to be zero when designing
  if (lsText = '') then
    if (pppcDesigning in DesignState) and not(Printing) then
      lsText := 'l';

  lClientRect := TppRotatedText.CalcRotatedTextBounds(lCanvas, lsText, Font, mmLeft, mmTop, mmWidth, mmHeight, Angle, AutoSize, Alignment, Border);

  lBitmap.Free;

  mmSetBounds(lClientRect.Left, lClientRect.Top, lClientRect.Right, lClientRect.Bottom);
  InvalidateDesignControl;

end; {procedure, CalcRotatedBounds}

{------------------------------------------------------------------------------}
{ TppCustomText.CalcClientRect }

function TppCustomText.CalcClientRect(aClientRect: TRect): TRect;
var
  liWidthChange: Integer;
  liBorderWidth: Integer;
begin

  Result := aClientRect;

  liBorderWidth := 0;

  Result.Top := mmTop;

  if (not(AutoSize)) then
    begin
      Result.Left := mmLeft;
      Result.Right := mmWidth;
    end;

  if Border.Visible then
    begin
      liBorderWidth := Border.MMWeight;

      {Snap vertical bounding box to text bottom if wordwrapped}
      if not(AutoSize)then
        begin
          if (WordWrap) then
            begin
              if [bpTop, bpBottom] <= Border.BorderPositions then
                Result.Bottom := Result.Bottom + (2 * liBorderWidth)
              else if (bpTop in Border.BorderPositions) or (bpBottom in Border.BorderPositions) then
                Result.Bottom := Result.Bottom + liBorderWidth
            end
          else
            Result.Bottom := mmHeight;
        end;
    end;

  if AutoSize then
    begin
      {Adjust bounding box according to visible borders}
      if [bpTop, bpBottom] <= Border.BorderPositions then
        Result.Bottom := Result.Bottom + (2 * liBorderWidth)
      else if (bpTop in Border.BorderPositions) or (bpBottom in Border.BorderPositions) then
        Result.Bottom := Result.Bottom + liBorderWidth;

      if [bpLeft, bpRight] <= Border.BorderPositions then
        Result.Right := Result.Right + (2 * liBorderWidth)
      else if (bpLeft in Border.BorderPositions) or (bpRight in Border.BorderPositions) then
        Result.Right := Result.Right + liBorderWidth;

      liWidthChange := mmWidth - aClientRect.Right;

      {Adjust bounding box according to current text alignment}
      case Alignment of

        taLeftJustify:
          Result.Left := mmLeft;

        taRightJustify:
          if (Border.BorderPositions <> Border.PreviousBorderPositions) then
            begin
              Result.Left := mmLeft;
              Border.PreviousBorderPositions := Border.BorderPositions;
            end
          else
            Result.Left := mmLeft + liWidthChange;

        taCenter:
          Result.Left := mmLeft + (liWidthChange div 2);

       else
         raise EDesignError.Create('TppCustomText.AdjustBounds: Unknown alignment type.');

      end;
  end;

end; {function, CalcClientRect}

{------------------------------------------------------------------------------}
{ TppCustomText.AddBreakFieldForGroup }

procedure TppCustomText.AddBreakFieldForGroup(aGroup: TppGroup);
begin
  FBreakFieldForGroups.Add(aGroup);
end;

{------------------------------------------------------------------------------}
{ TppCustomText.CalcSpaceUsed}

procedure TppCustomText.CalcSpaceUsed;
var
  lPrinter: TppPrinter;
  lTextMetric: TTextMetric;
  liCharPos: Integer;
  liLeading: Integer;
  lTabStops: TStrings;
  lbPrintIt: Boolean;
  lBand: TppCustomBand;
  liLineHeight: Integer;
  lPosRect: TppRect;
begin
  // TODO: implement calc space used for rotated text
  if (FAngle <> 0) then Exit;

  lbPrintIt := False;
  lBand := TppCustomBand(Band);


  liLineHeight := mmHeight;

  if (FWrappedText <> nil) then
    FWrappedText.Clear;

  // calc line height
  if WordWrap or AutoSize then
    begin
      lPrinter := GetPrinter;
      lPrinter.Canvas.Font := Font;

      GetTextMetrics(lPrinter.Canvas.Handle, lTextMetric);

      liLineHeight := ppToMMThousandths(lTextMetric.tmHeight + lTextMetric.tmExternalLeading, utPrinterPixels, pprtVertical, lPrinter);

    end;


  // calc wrapped text
  if WordWrap then
    begin
       lPrinter := GetPrinter;

      // create on demand
      if (FWrappedText = nil) then
        FWrappedText := TStringList.Create;

      liCharPos := 0;
      liLeading := 0;
      lTabStops := nil;

      lPosRect := PrintPosRect;

      // adjust so that we can fit at least one line
      if liLineHeight > (lPosRect.Bottom - lPosRect.Top) then
        lPosRect.Bottom := lPosRect.Top + liLineHeight;

      // wrap lines
      TppPlainText.WordWrap(GetText, lPosRect, TextAlignment, AutoSize, Font, FCharWrap, liLeading, lTabStops, lPrinter, liCharPos, FWrappedText);

    end;

  // calc space used
  if not(AutoSize) then
    SpaceUsed := mmHeight
  else
    begin

      // default space used to line height
      SpaceUsed := liLineHeight;

      // adjust for number of lines
      if WordWrap and (FWrappedText.Count > 0) then
        SpaceUsed := SpaceUsed * FWrappedText.Count;

    end;

  if not(FPriorValueSame) or ((DataPipeline <> nil) and
                              (ppdaFirstRecord in DataPipeline.State) and not(AlreadyPrinted))  then
    begin
      lbPrintIt := True;
      FAlreadyPrinted := False;
    end
  else
    begin
      if FSuppressRepeatedValues then
        begin
          if (FReprintOnSubsequent) and ((FFirstPage < lBand.Report.Engine.AbsolutePageNo) or
             (FFirstColumn < lBand.Report.Engine.CurrentColumn)) and not(FAlreadyPrinted) then
            lbPrintIt := True

          else if lBand.OverFlow and not(ReprintOnOverFlow) and not(DrawComponent) then
           lbPrintIt := False

          else
            lbPrintIt := False;
        end
      else if DrawComponent then
        lbPrintIt := True;
    end;

  if lbPrintIt then
    FAlreadyPrinted := True
  else
    begin
      SpaceUsed := 0;

      DrawComponent := False;
    end;


   UpdateValues;

end; {procedure, CalcSpaceUsed}


{------------------------------------------------------------------------------}
{ TppDBText.Clear }

procedure TppCustomText.Clear;
begin

  inherited Clear;

  FAlreadyPrinted := False;
  FFirstColumn := -1;
  FFirstPage := -1;
  FPriorValue := '';
  FPriorValueSame := False;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppCustomText.RemoveBreakFieldForGroup }

procedure TppCustomText.RemoveBreakFieldForGroup(aGroup: TppGroup);
begin
  FBreakFieldForGroups.Remove(aGroup);
end;

procedure TppCustomText.RestoreFromCache(aCachePageNo: Integer);
var
  lRec: TppCustomTextSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent := lRec.FDrawComponent;
  FPriorValueSame := lRec.FPriorValueSame;
  FFirstPage      := lRec.FFirstPage;
  FFirstColumn    := lRec.FFirstColumn;
  FAlreadyPrinted := lRec.FAlreadyPrinted;

end;

procedure TppCustomText.SaveToCache(aCachePageNo: Integer);
var
  lRec: TppCustomTextSaveRec;
begin

  lRec.FDrawComponent := DrawComponent;
  lRec.FPriorValueSame  := FPriorValueSame;
  lRec.FFirstPage       := FFirstPage;
  lRec.FFirstColumn     := FFirstColumn;
  lRec.FAlreadyPrinted  := FAlreadyPrinted;

  WriteRecordToCache(aCachePageNo, lRec);

end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetDescription }

function TppCustomText.GetDescription: String;
begin
  Result := UserName + ': ' + Caption;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetText }

function TppCustomText.GetText: String;
var
  lsText: String;
  lParams: TraParamList;

begin

  lsText := GetTheText;

  if Ellipsis then
    lsText := FormatTextWithEllipsis(lsText);

  Result := lsText;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (pppcDesigning in DesignState) and not(Printing) then exit;

  {allow user to override Text value}
  if Assigned(FOnGetText) then FOnGetText(Self, lsText);

  lParams := TraTppCustomTextRTTI.GetParams('OnGetText');
  lParams.CreateValuePointer(0, lsText);

  SendEventNotify(Self, ciComponentGetText, lParams);

  lParams.Free;

  Result := lsText;

end; {function, GetText}

{------------------------------------------------------------------------------}
{ TppCustomText.GetTheText }

function TppCustomText.GetTheText: String;
begin
  Result := inherited GetText;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetTheSaveOrder }

function TppCustomText.GetTheSaveOrder: TTabOrder;
begin
  Result := FSaveOrder;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetSaveOrder }

function TppCustomText.GetSaveOrder: TTabOrder;
begin
  if Band <> nil then
    Result := Band.IndexOfSave(Self)
  else
    Result := -1;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetAngle }

procedure TppCustomText.SetAngle(Value: Integer);
begin

  if (FAngle <> Value) then
    begin
      BeforePropertyChange('Angle');

      {Convert negative angles and check to see if the angle is within the boundaries}
      if (Value > -360) and (Value < 0) then
        FAngle := Value + 360
      else if (Value >= 0) and (Value < 360) then
        FAngle := Value;

      if Value <> 0 then
        WordWrap := False;

      AdjustBounds;

      PropertyChange;
    end;
end;

procedure TppCustomText.SetAutoSize(Value: Boolean);
begin
  inherited;

  if not(csReading in ComponentState) and not(csLoading in ComponentState) then
    if (AutoSize) and (Ellipsis) then
      Ellipsis := False;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSaveLength }

procedure TppCustomText.SetSaveLength(Value: Integer);
begin
  if FSaveLength <> Value then
    begin
      FSaveLength := Value;
      Reset;
    end;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSaveOrder }

procedure TppCustomText.SetSaveOrder(Value: TTabOrder);
var
  liSaveIndex: Integer;
  liSaveCount: Integer;
begin

  if csReading in ComponentState then
    FSaveOrder := Value
  else
    begin
      {if save is not turned on, we're outta here}
      if not(FSave) then Exit;

      liSaveIndex := GetSaveOrder;
      liSaveCount := Band.SaveCount;

      {doctor value until it is valid}
      if Value < 0 then Value := 0;
      if (liSaveCount > 0) and (Value >= liSaveCount) then Value := liSaveCount - 1;

      if (Value <> liSaveIndex) then
        begin
          {remove from old position}
          if (liSaveIndex >= 0) then
            Band.RemoveSave(Self);

          {insert into new position}
          Band.InsertSave(Value, Self);
        end;
    end;


end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSave }

procedure TppCustomText.SetSave(Value: Boolean);
begin
  if FSave <> Value then
    begin
      FSave := Value;

      if (csReading in ComponentState) then Exit;

      if FSave then
        Band.AddSave(Self)
      else
        Band.RemoveSave(Self);

      if (pppcDesigning in DesignState) then
        PropertyChange;

      Reset;

    end;
end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetTextAlignment }

procedure TppCustomText.SetTextAlignment(Value: TppTextAlignment);
begin

  {Full justification is only for memos, labels should ignore it.}
  if Value <> taFullJustified then
    inherited SetTextAlignment(Value);

end; {procedure, SetTextAlignment}

{------------------------------------------------------------------------------}
{ TppCustomText.SetWordWrap }

procedure TppCustomText.SetWordWrap(Value: Boolean);
begin
  if Angle = 0 then
    inherited SetWordWrap(Value)
  else
    inherited SetWordWrap(False);

end; {procedure, SetWordWrap}

{------------------------------------------------------------------------------}
{ TppCustomText.UpdateSaveOrder }

procedure TppCustomText.UpdateSaveOrder(Value: TTabOrder);
var
  liSaveIndex: Integer;
  liSaveCount: Integer;
begin

  {if save is not turned on, we're outta here}
  if not(FSave) then Exit;

  liSaveIndex := GetSaveOrder;
  liSaveCount := Band.SaveCount;

  {doctor value until it is valid}
  if Value < 0 then Value := 0;
  if (liSaveCount > 0) and (Value >= liSaveCount) then Value := liSaveCount - 1;

  if (Value <> liSaveIndex) then
    begin
      {remove from old position}
      if (liSaveIndex >= 0) then
        Band.RemoveSave(Self);

      {insert into new position}
      Band.InsertSave(Value, Self);
    end;

end; {procedure, UpdateSaveOrder}


{------------------------------------------------------------------------------}
{ TppCustomText.SetBand }

procedure TppCustomText.SetBand(aBand: TppBand);
begin

  inherited SetBand(aBand);

end; {procedure, SetBand}


{------------------------------------------------------------------------------}
{ TppCustomText.GetDisplayFormat }

function TppCustomText.GetDisplayFormat: String;
begin
  Result := FDisplayFormat;

end; {function, GetDisplayFormat}

{------------------------------------------------------------------------------}
{ TppCustomText.SetDisplayFormat }

procedure TppCustomText.SetDisplayFormat(const aFormat: String);
begin
  if FDisplayFormat <> aFormat then
    begin
      BeforePropertyChange('DisplayFormat');
      FDisplayFormat := aFormat;
      PropertyChange;
    end;

end; {function, SetDisplayFormat}

{------------------------------------------------------------------------------}
{ TppCustomText.SetEllipsis }

procedure TppCustomText.SetEllipsis(Value: Boolean);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    FEllipsis := Value
  else if FEllipsis <> Value then
    begin
      BeforePropertyChange('Ellipsis');
      FEllipsis := Value;
      AdjustBounds;
      PropertyChange;

      if (FEllipsis) and (AutoSize) then
        AutoSize := False;
    end;

end; {function, SetEllipsis}

{------------------------------------------------------------------------------}
{ TppCustomText.SetHyperLink }

procedure TppCustomText.SetHyperlink(Value: string);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      FHyperLink := Value;
      Exit;
    end;

  if FHyperLink <> Value then
    begin
      BeforePropertyChange('HyperLink');

      if ProcessHyperLink(Value) then
        begin
          FHyperLink := FHyperLinkAuto;
          FHyperLinkAuto := '';
        end
      else
        begin
          FHyperLink := Value;
          FHyperLinkAuto := '';

          UpdateHyperlinkFont();

        end;

      {repaint design control}
      InvalidateDesignControl;

      PropertyChange;
    end;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetHyperlinkColor }

procedure TppCustomText.SetHyperlinkColor(const Value: TColor);
begin
  if (FHyperLinkColor = Value) then Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      FHyperlinkColor := Value;
      Exit;
    end;

  BeforePropertyChange('HyperlinkColor');

  FHyperlinkColor := Value;

  UpdateHyperLinkFont;

  {repaint design control}
  InvalidateDesignControl;

  PropertyChange;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetHyperLinkEnabled }

procedure TppCustomText.SetHyperLinkEnabled(const Value: Boolean);
begin

  if (FHyperlinkEnabled = Value) then Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) then
    begin
      FHyperlinkEnabled := Value;
      Exit;
    end;

  BeforePropertyChange('HyperLinkEnabled');

  FHyperLinkEnabled := Value;

  // process the hyperlink to turn it on
  if (FHyperlink = '') and (FHyperlinkEnabled) then
    begin
      FHyperlinkAuto := '';
      ProcessHyperLink(GetText);
    end;

  // update font
  UpdateHyperLinkFont();


  {repaint design control}
  InvalidateDesignControl;

  PropertyChange;


end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetCaption }

procedure TppCustomText.SetCaption(Value: String);
begin
  if (FHyperLinkAuto = '') or (FHyperLinkAuto = Caption) then
    ProcessHyperLink(Value);

  inherited;

  if (not(AutoSize)) and (Angle <> 0) then
    AdjustBounds;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetName }

procedure TppCustomText.SetName(const Value: TComponentName);
var
  lsOldName: String;
  liGroup: Integer;
  lGroup: TppGroup;

begin

  lsOldName := Name;

  inherited SetName(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if FBreakFieldForGroups.Count > 0 then

    {notify groups that their BreakField's name has changed }
    for liGroup := 0 to (FBreakFieldForGroups.Count-1) do
      begin
        lGroup := FBreakFieldForGroups[liGroup];
        lGroup.BreakComponentNameChanged(lsOldName, Value);
      end;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.PropertiesToDrawCommand }

procedure TppCustomText.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawText: TppDrawText;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawText) then Exit;

  lDrawText := TppDrawText(aDrawCommand);

  {create print object}
  lDrawText.Alignment := Alignment;
  lDrawText.Angle := Angle;
  lDrawText.AutoSize := AutoSize;
  lDrawText.Color := Color;
  lDrawText.ForceJustifyLastLine := ForceJustifyLastLine;
  lDrawText.Left := PrintPosRect.Left;
  lDrawText.Top := PrintPosRect.Top;
  lDrawText.Height := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawText.Width := PrintPosRect.Right - PrintPosRect.Left;
  lDrawText.RotatedOrigin := FRotatedOrigin;
  lDrawText.TextAlignment := TextAlignment;
  lDrawText.Transparent := Transparent;
  lDrawText.WordWrap := WordWrap;
  lDrawText.Font := Font;

  if HyperLinkEnabled then
    lDrawText.HyperLink := HyperLink;

  // when word wrapping, use the wrapped text
  if (WordWrap) and (FWrappedText <> nil) then
    lDrawText.WrappedText := FWrappedText;

  lDrawText.Text := Text;

  lDrawText.DisplayFormat := DisplayFormat;
//  lDrawText.DataType := dtString;  {no need to assign, this is the default}
//  lDrawText.Value := {leave unassigned to optimize}

  {assign print to file properties}

  lDrawText.BandType := Band.BandType;
  lDrawText.BandSave := Band.Save;
  lDrawText.BandSaveNo := Band.Report.ReportBandCount;
  lDrawText.Component := Self;
  lDrawText.ComponentSave := Save;
  lDrawText.ComponentSaveNo := SaveOrder;
  lDrawText.SaveLength := SaveLength;

  if Band.Report.Parent is TppSubReport then
    lDrawText.ReportSaveNo := ((TppSubreport(Band.Report.Parent).Count + 1) + TppSubreport(Band.Report.Parent).ZOrder) *
                                TppSubreport(Band.Report.Parent).Band.Report.ReportBandCount
  else
    lDrawText.ReportSaveNo := 0;


end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetTextBuf }

function TppCustomText.GetTextBuf: PChar;
begin
  Result := StrAlloc(Length(Text) + 1);
  StrPCopy(Result, Text);
end;

{------------------------------------------------------------------------------}
{ TppCustomText.ProcessHyperLink }

function TppCustomText.ProcessHyperLink(aText: string): Boolean;
var
  lbOldHyperLinkState: Boolean;
  lbNewHyperlinkState: Boolean;
begin

  Result := False;

  if not(HyperLinkEnabled) then exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  lbOldHyperLinkState := (HyperLink <> '');

  if HyperLinkDetected(aText) then
    FHyperLinkAuto := aText
  else if EmailAddressDetected(aText) then
   FHyperLinkAuto := 'mailto:' + aText
  else
    FHyperLinkAuto := '';

  Result := (FHyperLinkAuto <> '');

  lbNewHyperlinkState := (HyperLink <> '');

  if (lbNewHyperlinkState <> lbOldHyperLinkState) then
    UpdateHyperLinkFont();

end;

{------------------------------------------------------------------------------}
{ TppCustomText.HyperLinkDetected }

function TppCustomText.HyperLinkDetected(aCaption: string): Boolean;
var
  lsCaption: String;
  liHttpPos: Integer;
  liWwwPos: Integer;
begin

  lsCaption := UpperCase(aCaption);

  liHttpPos := Pos('HTTP://', lsCaption);
  liWwwPos  := Pos('WWW.', lsCaption);

  if (liHttpPos = 1) then
    Result := True
  else if (liWwwPos = 1) then
    Result := True
  else
    Result := False;

end;

function TppCustomText.EmailAddressDetected(aCaption: String): Boolean;
var
  liAtPos: Integer;
  liDotPos: Integer;
begin

  liAtPos   := Pos('@', aCaption);
  liDotPos  := TppStrUtils.PosBack('.', aCaption);  //Search from the end so email addresses can contain a dot.

  if (liAtPos > 0) and (liAtPos < liDotPos) then
    Result := True
  else
    Result := False;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.EventNotify }

procedure TppCustomText.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin
  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aCommunicator = Band.Report) and (aEventID = ciEngineStartColumn) then
    ColumnStart;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppCustomText.Init }

procedure TppCustomText.Init;
begin

  inherited Init;

  FAlreadyPrinted := False;
  FFirstColumn := -1;
  FFirstPage := -1;
  FPriorValue := '';
  FPriorValueSame := False;

  Band.Report.AddEventNotify(Self);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppCustomText.ColumnStart }

procedure TppCustomText.ColumnStart;
begin
  FAlreadyPrinted := not(FReprintOnSubsequent);
end; {procedure, ColumnStart}

{------------------------------------------------------------------------------}
{ TppCustomText.FontChanged }

procedure TppCustomText.FontChanged(Sender: TObject);
begin

  inherited;

  if (HyperLink = '') or not(HyperLinkEnabled) then
    FStdFontColor := Font.Color
  else
    FHyperLinkColor := Font.Color;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.FormatTextWithEllipsis }

function TppCustomText.FormatTextWithEllipsis(aText: String): String;
const
  cEllipsis = '...';
var
  ldTextWidth: Double;
  lsText: String;
begin

  Result := aText;
  lsText := aText;

  ldTextWidth := CalcTextWidthInReportUnits(lsText, Font);

  {shrink length of text and add the elipses, as needed}
  if (ldTextWidth > Width) then
    repeat
      lsText := Copy(lsText,1, Length(lsText)-1);
      Result := lsText + cEllipsis;
      ldTextWidth := CalcTextWidthInReportUnits(Result, Font);

    until (ldTextWidth < Width);

end;

{------------------------------------------------------------------------------}
{ TppCustomText.CalcTextWidthInReportUnits }

function TppCustomText.CalcTextWidthInReportUnits(aText: String; aFont: TFont): Double;
var
  liPrinterPixels: Integer;
  liMicrons: Integer;
  lCanvas: TCanvas;
begin

  lCanvas := Band.Report.Printer.Canvas;

  lCanvas.Font := aFont;

  {calc width in printer pixels}
  liPrinterPixels := lCanvas.TextWidth(aText);

  {convert to microns}
  liMicrons := ppToMMThousandths(liPrinterPixels, utPrinterPixels, pprtHorizontal, Band.Report.Printer);

  {convert from microns to report units}
  Result := ppFromMMThousandths(liMicrons, Band.Report.Units, pprtHorizontal, Band.Report.Printer);

end;

{------------------------------------------------------------------------------}
{ TppCustomText.GetHyperlink }

function TppCustomText.GetHyperlink: string;
begin
  if (csWriting in ComponentState) then
    Result := FHyperlink
  else if (FHyperLink <> '') then
    Result := FHyperlink
  else
    Result := FHyperlinkAuto;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.PageStart }

procedure TppCustomText.PageStart;
begin

  if (FFirstPage <> -1) then
    FAlreadyPrinted := not(FReprintOnSubsequent);

end; {procedure, PageStart}

{------------------------------------------------------------------------------}
{ TppCustomText.SetReprintOnSubsequent }

procedure TppCustomText.SetReprintOnSubsequent(Value: Boolean);
begin
  if  FReprintOnSubsequent <> Value then
    begin
      FReprintOnSubsequent := Value;
      Reset;
      PropertyChange;
    end;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.SetSuppressRepeatedValues }

procedure TppCustomText.SetSuppressRepeatedValues(Value: Boolean);
begin
  if  FSuppressRepeatedValues <> Value then
    begin
      FSuppressRepeatedValues := Value;
      Reset;
      PropertyChange;
    end;

end;

procedure TppCustomText.UpdateHyperlinkFont;
begin

    // adjust font
  if (HyperLink <> '') and (HyperLinkEnabled) then
    begin
      Font.Color := FHyperLinkColor;
      Font.Style := Font.Style + [fsUnderLine];
    end
  else
    begin
      Font.Color := FStdFontColor;
      Font.Style := Font.Style - [fsUnderLine];
    end;

end;

{------------------------------------------------------------------------------}
{ TppCustomText.UpdateValues }

procedure TppCustomText.UpdateValues;
begin

  if (FPriorValue <> Text) then
    begin
      FPriorValue := Text;
      FPriorValueSame := False;
      FFirstPage := Band.Report.AbsolutePage;
      FFirstColumn := Band.Report.CurrentColumn;

    end
  else
    FPriorValueSame := True;

end; {procedure, UpdateValues}


{******************************************************************************
 *
 ** L A B E L
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppLabel.Create }

constructor TppLabel.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  DefaultPropName     := 'Caption';
  DefaultPropEditType := etAutoEdit;

end; {constructor, Create}



{------------------------------------------------------------------------------}
{ TppLabel.GetDefaultPropHint }

function TppLabel.GetDefaultPropHint: String;
begin

  Result := ppLoadStr(119);

end; {function, GetDefaultPropHint}


{------------------------------------------------------------------------------}
{ TppLabel.SetUserName }

procedure TppLabel.SetUserName(const Value: TComponentName);
var
  lsOldName : String;

begin

  lsOldName := UserName;

  inherited SetUserName(Value);

  {check whether set name was successful (i.e. user name is valid) }
  if (UserName = lsOldName) then Exit;

  if (csReading in ComponentState) or (csLoading in ComponentState) and
      not (pppcPasting in DesignState) then Exit;

  {on name change, also change caption if it is the same as the user name}
  if (Caption = lsOldName) then
    Caption := Value;

end; {procedure, SetUserName}




{******************************************************************************
 *
 ** D B T E X T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBText.Create }

constructor TppDBText.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  SetDefaultAutoSize(False);
  CacheRecordSize := SizeOf(TppDBTextSaveRec);
  EventNotifies := EventNotifies + [ciTraversal];

  FBlankWhenZero          := False;
  FCurrentValue             := '';
  FJustRestored           := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDBText.Destroy }

destructor TppDBText.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDBText.GetFieldValue }

function TppDBText.GetFieldValue: Variant;
begin

  Result := 0;

  if (DataPipeline = nil) then Exit;

  if (DataField = '') then Exit;

  try
    Result := DataPipeline.GetFieldValue(DataField);

  except
    on E:EDataError do
      if Band.Report.Engine.Printing then
        Band.Report.RaiseException(E);

    on E:EConvertError do
      if Band.Report.Engine.Printing then
        Band.Report.RaiseException(E);

  end; {try, except}

end; {function, GetFieldValue}

{------------------------------------------------------------------------------}
{ TppDBText.GetDescription }

function TppDBText.GetDescription: String;
begin
  if (DataField <> '') then
    Result := UserName + ': ' + DataField
  else
    Result := UserName;
end;

{------------------------------------------------------------------------------}
{ TppDBText.IsCalc }

function TppDBText.IsCalc: Boolean;
begin
  Result := True;
end; {function, IsCalc}

{------------------------------------------------------------------------------}
{ TppDBText.Init }

procedure TppDBText.Init;
begin

  inherited Init;

  Band.Report.Engine.AddEventNotify(Self);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppDBText.Compute }

procedure TppDBText.Compute;
begin

  UpdateValues;

  ResetOnCompute := False;

end; {procedure, Compute}

{------------------------------------------------------------------------------}
{ TppDBText.UpdateValues }

procedure TppDBText.UpdateValues;
var
  lbSuppressWhenNotReprintOnSubsequent: Boolean;
begin

  FCurrentValue := Text;

  {addresses case where reprint on subsequent is false and suppressing repeated
   values across a page break or new page group. Must assign ResetGroup in order
   to have values suppressed when a page break accurs}
  if (FSuppressRepeatedValues) and (not(FReprintOnSubsequent)) and (ResetGroup <> nil) and not(ResetGroup.KeptTogether) then
    lbSuppressWhenNotReprintOnSubsequent := True
  else
    lbSuppressWhenNotReprintOnSubsequent := False;

  if not(lbSuppressWhenNotReprintOnSubsequent and (PriorValue = cIgnore)) and (ResetOnCompute or (PriorValue <> FCurrentValue)) then
    begin
      PriorValue := FCurrentValue;
      PriorValueSame := False;
      FirstPage := Band.Report.AbsolutePage;
      FirstColumn := Band.Report.CurrentColumn;
    end
  else
    PriorValueSame := True;

end; {procedure, UpdateValues}

{------------------------------------------------------------------------------}
{ TppDBText.CalcSpaceUsed }

procedure TppDBText.CalcSpaceUsed;
begin
  inherited;

end; {procedure, CalcSpaceUsed}

{------------------------------------------------------------------------------}
{ TppDBText.RestoreFromCache }

procedure TppDBText.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppDBTextSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent   := lRec.FDrawComponent;
  FirstPage       := lRec.FFirstPage;
  FirstColumn     := lRec.FFirstColumn;
  PriorValueSame  := lRec.FPriorValueSame;
  AlreadyPrinted  := lRec.FAlreadyPrinted;
  ResetOnCompute  := lRec.FResetOnCompute;

{$IFDEF CodeSite}
CodeSite.SendMsg('TppDBText.RestoreFromCache(' + IntToStr(aCachePageNo) + '): ' + PriorValue);
CodeSite.SendMsg('  PrioValueSame = ' + BoolToStr(PriorValueSame));
CodeSite.SendMsg('  AlreadyPrinted = ' + BoolToStr(AlreadyPrinted));
{$ENDIF}

  {assign a special value used in the UpdateValues method}
  if (SuppressRepeatedValues and not(ReprintOnSubsequent) and (ResetGroup <> nil)) then
    PriorValue := cIgnore;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppDBText.SaveToCache }

procedure TppDBText.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppDBTextSaveRec;
begin
{$IFDEF CodeSite}
//  CodeSite.SendMsg('TppDBText.SaveToCache(' + IntToStr(aCachePageNo) + '): ' + PriorValue);
{$ENDIF}

  lRec.FDrawComponent   := DrawComponent;
  lRec.FPriorValueSame  := PriorValueSame;
  lRec.FFirstPage       := FirstPage;
  lRec.FFirstColumn     := FirstColumn;
  lRec.FAlreadyPrinted  := AlreadyPrinted;
  lRec.FResetOnCompute  := ResetOnCompute;

  WriteRecordToCache(aCachePageNo, lRec);
  
end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppDBText.SetDisplayFormat }

procedure TppDBText.SetDisplayFormat(const aFormat: String);
begin
  inherited SetDisplayFormat(aFormat);

  Caption := GetText;
end;

{------------------------------------------------------------------------------}
{ TppDBText.SetUserName }

procedure TppDBText.SetUserName(const Value: TComponentName);
begin
  inherited SetUserName(Value);

  if (csReading in ComponentState) or (csLoading in ComponentState) and
     not (pppcPasting in DesignState) then Exit;

  Caption := GetText;

end; {procedure, SetUserName}


{------------------------------------------------------------------------------}
{ TppDBText.GetTheText }

function TppDBText.GetTheText: String;
var
  lsText: String;
  lsFormat: String;
begin

  if CheckForPipelineData then
    begin

      try
        FFieldDataType := DataPipeline.GetFieldDataType(DataField);
      except
        FFieldDataType := dtString;
      end;

      if Assigned(FOnFormat) then
        lsFormat := ''
      else
        lsFormat := DisplayFormat;

      try
       FFieldValue := DataPipeline.GetFieldValue(DataField);

      except on EDataError do
        lsText := '';
             on EConvertError do
        lsText := '';
             on EVariantError do
        lsText := '';

      end; {try, except }

{$IFDEF Delphi6}
      if (FBlankWhenZero and (FFieldValue <> Null)) and (VarType(FFieldValue) in [varSmallInt..varCurrency, varShortInt..varInt64, varDate]) and (FFieldValue = 0) then
{$ELSE}
      if (FBlankWhenZero and (FFieldValue <> Null)) and (VarType(FFieldValue) in [varSmallInt..varCurrency, varDate]) and (FFieldValue = 0) then
{$ENDIF}
        lsText := ''
      else if ppVariantIsString(FFieldValue) and (FFieldValue = '') then
        lsText := ''
      else if (FFieldDataType in [dtDate, dtDateTime]) and (VarIsNull(FFieldValue)) then
        lsText := ''
      else
        begin
          try
            lsText := ppFormat(lsFormat, FFieldDataType, FFieldValue);
            ProcessHyperLink(lsText);
          except on EVariantError do
            lsText := '';
          end;

          if Assigned(FOnFormat) then
            FOnFormat(Self, DisplayFormat, FFieldDataType, FFieldValue, lsText);
        end;

    end {get data }

  else if (Printing) then
    lsText := ''

  else {must be designing}

    begin

      {display db field name}
      if (DataField <> '') then
        begin
          if (DataPipeline <> nil) then
            lsText := DataPipeline.FieldAliasForFieldName(DataField)
          else
            lsText := DataField;
        end

      else {display component name}
        lsText := UserName;

    end;

  Result := lsText;

end; {function, GetTheText}

{------------------------------------------------------------------------------}
{ TppDBText.SetBlankWhenZero }

procedure TppDBText.SetBlankWhenZero(Value: Boolean);
begin
  if  FBlankWhenZero <> Value then
    begin
      FBlankWhenZero := Value;
      PropertyChange;
    end;

end; {procedure, SetBlankWhenZero}

{------------------------------------------------------------------------------}
{ TppDBText.IsDataAware }

function TppDBText.IsDataAware: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TppDBText.SetDataField }

procedure TppDBText.SetDataField(const Value: string);
begin


  inherited SetDataField(Value);

  {this will set caption}
  Notify(DataPipeline, ppopDataChange);

  PropertyChange;

end; {procedure, SetDataField}

{------------------------------------------------------------------------------}
{ TppDBText.Notify }

procedure TppDBText.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (csDestroying in ComponentState) then Exit;

  if (aCommunicator <> nil) and (aCommunicator.Owner <> nil) and (aCommunicator.Owner is TppDrawVariable) then Exit;

  if (aOperation in [ppopDataChange, ppopRemove]) and (pppcDesigning in DesignState) and not(Printing) then
    Caption := GetText;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDBText.EventNotify }

procedure TppDBText.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aCommunicator = ResetGroup) and (aEventID = ciGroupAfterGroupBreak) then
    Clear

  else if (aCommunicator = Band.Report.Engine) and (aEventID = ciTraversal) then
    Compute

  else if (aCommunicator = Band.Report.Engine) and (aEventID = ciDetailOutOfSpace) {and (Band is TppFooterBand)} then
    RestorePriorValue;  // dynamic detail band could not print

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppDBText.PageStart }

procedure TppDBText.PageStart;
var
  liRecordNo: Integer;
begin

  inherited;

  // restore PriorValue for start of page here,
  //this method is called after the datapipeline record pos has been synced
  if (SuppressRepeatedValues) and (DataPipeline <> nil) then
    begin
      PriorValue := '';

      if not(DataPipeline.Bof) and (DataPipeline.RecordNo > 0) then
        begin
          liRecordNo := DataPipeline.RecordNo;
          DataPipeline.SkipBack;

          if (DataPipeline.RecordNo <> liRecordNo) then
            begin
              PriorValue := Text;
              DataPipeline.Skip;
            end
          end;

    end;

end; {procedure, PageStart}

{------------------------------------------------------------------------------}
{ TppDBText.PropertiesToDrawCommand }

procedure TppDBText.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawText: TppDrawText;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawText) then Exit;

  lDrawText := TppDrawText(aDrawCommand);

  if (FFieldDataType <> dtString) then
    begin
      lDrawText.DataType := FFieldDataType;
      lDrawText.Value := FFieldValue;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDBText.RestorePriorValue }

procedure TppDBText.RestorePriorValue;
begin

  {restore prior value here - see DBCalc}

end;

{******************************************************************************
 *
 ** L O O K A H E A D   L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLookAheadList.CreateList }

constructor TppLookAheadList.CreateList(aOwner: TppCommunicator);
begin

  inherited Create;

  FOwner := aOwner;

end; {constructor, CreateList}

{------------------------------------------------------------------------------}
{ TppLookAheadList.Destroy }

destructor TppLookAheadList.Destroy;
begin

  FreeTotals;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppLookAheadList.FreeTotals }

procedure TppLookAheadList.FreeTotals;
var
  liIndex: Integer;
  lDrawVariable: TppCommunicator;
begin

  for liIndex := 0 to Count - 1 do
    begin
      lDrawVariable := TppCommunicator(Items[0]);

      FOwner.RemoveEventNotify(lDrawVariable);

      lDrawVariable.Free;

      Delete(0);
    end;

end; {procedure, FreeTotals}

{------------------------------------------------------------------------------}
{ TppLookAheadList.Clear }

procedure TppLookAheadList.Clear;
begin

  FreeTotals;

  inherited Clear;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppLookAheadList.UpdateTotal }

procedure TppLookAheadList.UpdateTotal(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String);
var
  lDrawVariable: TppDrawVariable;
begin

  lDrawVariable := FindTotal(aLookAheadKey);

  {if total cannot be found, add new total}
  if (lDrawVariable = nil) then
    AddTotal(aLookAheadKey, aTraversalCount, aText)
  else
    SendCalcNotify(aLookAheadKey, aTraversalCount, aText);

end; {procedure, UpdateTotal}

{------------------------------------------------------------------------------}
{ TppLookAheadList.RetrieveTotal }

function TppLookAheadList.RetrieveTotal(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String): String;
var
  lDrawVariable: TppDrawVariable;
begin

  lDrawVariable := FindTotal(aLookAheadKey);

  if (lDrawVariable <> nil) then
    Result := lDrawVariable.Text
  else
    Result := aText;

end; {function, RetrieveTotal}

{------------------------------------------------------------------------------}
{ TppLookAheadList.SignOffTotals }

procedure TppLookAheadList.SignOffTotals;
var
  liIndex: Integer;
begin

  {most of these have already been disconnected, except the last one}
  for liIndex := 0 to Count - 1 do
    FOwner.RemoveEventNotify(TppDrawVariable(Items[liIndex]).WalkieTalkie);

end; {procedure, SignOffTotals}

{------------------------------------------------------------------------------}
{ TppLookAheadList.AddTotal }

function TppLookAheadList.AddTotal(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String): TppDrawVariable;
var
  lDrawVariable: TppDrawVariable;
begin

  lDrawVariable := TppDrawVariable.Create(FOwner);

  lDrawVariable.Text := aText;
  lDrawVariable.LookAhead := True;
  lDrawVariable.LookAheadKey := aLookAheadKey;
  lDrawVariable.TraversalCount := aTraversalCount;

  {notify draw command when calculation is made}
  FOwner.AddEventNotify(lDrawVariable.WalkieTalkie);

  Result := lDrawVariable;

  Add(Result);
  
end; {procedure, AddTotal}

{------------------------------------------------------------------------------}
{ TppLookAheadList.FindTotal }

function TppLookAheadList.FindTotal(const aLookAheadKey: String): TppDrawVariable;
var
  lDrawVariable: TppDrawVariable;
  liIndex: Integer;
  lRemove: TList;
begin

  Result := nil;

  liIndex := 0;
  lRemove := TList.Create;

  while (liIndex < Count) and (Result = nil) do
    begin
      lDrawVariable := TppDrawVariable(Items[liIndex]);

      if (lDrawVariable.LookAheadKey = aLookAheadKey) then
        Result := lDrawVariable
      else
        lRemove.Add(lDrawVariable);

      Inc(liIndex);
    end;

  {if the id nos don't match, we don't need to notify the draw command any longer}
  for liIndex := 0 to lRemove.Count - 1 do
    begin
      lDrawVariable := TppDrawVariable(lRemove[liIndex]);

      FOwner.RemoveEventNotify(lDrawVariable.WalkieTalkie);
    end;

  lRemove.Free;

end; {function, FindTotal}

{------------------------------------------------------------------------------}
{ TppLookAheadList.SendCalcNotify }

procedure TppLookAheadList.SendCalcNotify(const aLookAheadKey: String; aTraversalCount: Integer; const aText: String);
var
  lParams: TraParamList;
  lsLookAheadKey: String;
  liTraversalCount: Integer;
  lsText: String;
begin

  {notify all currently connect draw commands}
  lParams := TraParamList.Create;

  lParams.AddParam('aLookAheadKey', daString, nil, '', False, False);
  lParams.AddParam('aTraversalCount', daInteger, nil, '', False, False);
  lParams.AddParam('aText', daString, nil, '', False, False);

  lsLookAheadKey := aLookAheadKey;
  liTraversalCount := aTraversalCount;
  lsText := aText;

  lParams.CreateValuePointer(0, lsLookAheadKey);
  lParams.CreateValuePointer(1, liTraversalCount);
  lParams.CreateValuePointer(2, lsText);

  FOwner.SendEventNotify(FOwner, ciComponentCalcLookAhead, lParams);

  lParams.Free;
  
end; {procedure, SendCalcNotify}


{******************************************************************************
 *
 ** D B C A L C
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDBCalc.Create }

constructor TppDBCalc.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  CacheRecordSize := SizeOf(TppDBCalcSaveRec);
  DrawCommandClass := TppDrawVariable;

  FDBCalcType := dcSum;
  FDivisor := 0;
  FJustSaved := False;
  FLookAhead := False;
  FLookAheadList := nil;
  FOnCalc := nil;
  FOnGroupBreak := nil;
  FValue := 0;

end; {procedure, Create}

{------------------------------------------------------------------------------}
{ TppDBCalc.Destroy }

destructor TppDBCalc.Destroy;
begin

  FLookAheadList.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDBCalc.SetValue }

procedure TppDBCalc.SetValue(aValue: Variant);
begin

  FValue := Double(aValue);

end; {procedure, SetValue}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetValue }

function TppDBCalc.GetValue: Variant;
begin

  Result := FValue;

end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetDescription }

function TppDBCalc.GetDescription: String;
var
  lsCaption: String;
begin
  {format design time caption}
  case FDBCalcType of

    dcCount  : lsCaption := ppLoadStr(1028) + '('; {'Count'}
    dcSum    : lsCaption := ppLoadStr(1029) + '('; {'Sum'}
    dcMinimum: lsCaption := ppLoadStr(1030) + '('; {'Minimum'}
    dcMaximum: lsCaption := ppLoadStr(1031) + '('; {'Maximum'}
    dcAverage: lsCaption := ppLoadStr(1032) + '('; {'Average'}

  end; {case, DBCalcType}

  if (DataField <> '') then
    Result := UserName + ': ' + lsCaption + DataField + ')'
  else
    if (FDBCalcType = dcCount) then
      Result := UserName + ': ' + lsCaption + '*)'
    else
      Result := UserName + ': ' + lsCaption + '?)';

end; {procedure, GetDescription}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetTheText }

function TppDBCalc.GetTheText: String;
var
  lsText: String;
begin

  if (pppcDesigning in DesignState) and not(Printing) then

    begin

      {format design time caption}
      case FDBCalcType of

        dcCount  : lsText := ppLoadStr(1028) + '('; {'Count'}
        dcSum    : lsText := ppLoadStr(1029) + '('; {'Sum'}
        dcMinimum: lsText := ppLoadStr(1030) + '('; {'Minimum'}
        dcMaximum: lsText := ppLoadStr(1031) + '('; {'Maximum'}
        dcAverage: lsText := ppLoadStr(1032) + '('; {'Average'}

      end; {case, DBCalcType}

      {display db field name}
      if (DataField <> '') then
        begin
          if (DataPipeline <> nil) then
            lsText := lsText + DataPipeline.FieldAliasForFieldName(DataField) + ')'
          else
            lsText := lsText + DataField + ')';
        end
      else
        if (FDBCalcType = dcCount) then
          lsText := lsText + '*)'
        else
          lsText := lsText + '?)';

    end

  else

    begin
      FFieldValue := FValue;

      if FDBCalcType = dcAverage then
        begin
          if FDivisor = 0 then
            FFieldValue := 0
          else
            FFieldValue := FFieldValue / FDivisor;
        end;

      if (FBlankWhenZero) and (FFieldValue = 0) then
        lsText := ''

      else
        begin
          if (FDBCalcType = dcCount) then
            FFieldDataType := dtInteger
          else if (DataPipeline <> nil) and (DataPipeline.GetFieldDataType(DataField) in [dtDate, dtTime, dtDateTime]) then
            FFieldDataType := dtDateTime
          else
            FFieldDataType := dtDouble;

          if (FFieldDataType = dtDateTime) and (FFieldValue = 0) then
            lsText := ''
          else
            lsText := ppFormat(DisplayFormat, FFieldDataType, FFieldValue);

          if Assigned(FOnFormat) then
            FOnFormat(Self, DisplayFormat, FFieldDataType, FFieldValue, lsText);
        end;

    end;

  Result := lsText;

end; {function, GetTheText}

{------------------------------------------------------------------------------}
{ TppDBCalc.SetDBCalcType }

procedure TppDBCalc.SetDBCalcType(aDBCalcType: TppDBCalcType);
begin

  FDBCalcType := aDBCalcType;

  {call data change to set caption}
  if (pppcDesigning in DesignState) and not (Printing) then
    begin
      Notify(DataPipeline, ppopDataChange);
      
      PropertyChange;
    end;

  Reset;

end; {procedure, SetDBCalcType}

{------------------------------------------------------------------------------}
{ TppDBCalc.RestoreFromCache }

procedure TppDBCalc.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppDBCalcSaveRec;
begin

  ReadRecordFromCache(aCachePageNo, lRec);

  AlreadyPrinted  := lRec.FAlreadyPrinted;
  DrawComponent   := lRec.FDrawComponent;
  FirstPage       := lRec.FFirstPage;
  PriorValueSame  := lRec.FPriorValueSame;
  ResetOnCompute  := lRec.FResetOnCompute;

  FValue          := lRec.FValue;
  FDivisor        := lRec.FDivisor;

  FCacheableValue := FValue;
  FCacheableDivisor := FDivisor;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppDBCalc.SaveToCache }

procedure TppDBCalc.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppDBCalcSaveRec;
begin

  lRec.FAlreadyPrinted  := AlreadyPrinted;
  lRec.FFirstPage       := FirstPage;
  lRec.FPriorValueSame  := PriorValueSame;
  lRec.FResetOnCompute  := ResetOnCompute;
  lRec.FDrawComponent   := DrawComponent;

  lRec.FValue           := FCacheableValue;
  lRec.FDivisor         := FCacheableDivisor;

  WriteRecordToCache(aCachePageNo, lRec);

  FJustSaved := True;

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppDBCalc.IsGroupBased }

function TppDBCalc.IsGroupBased: Boolean;
begin
  Result := True;
end; {function, IsGroupBased}

{------------------------------------------------------------------------------}
{ TppDBCalc.Clear }

procedure TppDBCalc.Clear;
begin

  inherited Clear;
  
  {reset values}
  FValue := 0;
  FDivisor := 0;

  FPriorValue := 0;
  FPriorDivisor := 0;

  FCacheableValue := 0;
  FCacheableDivisor := 0;

  if (FJustSaved) and ((Band is TppFooterBand) or (Band is TppColumnFooterBand)) then
    begin
      FJustSaved := False;

      SaveToCache(GetMainReport.AbsolutePageNo);
    end;


end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppDBCalc.Init }

procedure TppDBCalc.Init;
begin
  inherited;

  FValue := 0;
  FDivisor := 0;

  FPriorValue := 0;
  FPriorDivisor := 0;

  FCacheableValue := 0;
  FCacheableDivisor := 0;

  if (Band is TppFooterBand) then
    EventNotifies := EventNotifies + [ciDetailOutOfSpace]
  else
    EventNotifies := EventNotifies - [ciDetailOutOfSpace];

end;

{------------------------------------------------------------------------------}
{ TppDBCalc.Compute }

procedure TppDBCalc.Compute;
var
  ldValue: Double;
  lReport: TppCustomReport;
begin

  FPriorValue := FValue;
  FPriorDivisor := FDivisor;

  if (DataPipeline <> nil) and (ppdaNoRecords in DataPipeline.State) then
    begin
      lReport := GetReport;
      // only reset to 0, when report's datapipeline has no records
      if (lReport.DataPipeline <> nil) and (ppdaNoRecords in lReport.DataPipeline.State) then
        FValue := 0;
    end
  else
    begin
      ldValue := ComputeInitialValue;

      FDivisor := FDivisor + 1;

      FValue := ComputeValueForCalcType(ldValue);
    end;

  {call inherited here, otherwise resetoncompute is reset too early}
  inherited Compute;

  if Assigned(FOnCalc) then FOnCalc(Self);

  SendEventNotify(Self, ciComponentCalc, nil);

  {update lookahead totals}
  UpdateLookAheadTotal;

  FCacheableValue := FValue;
  FCacheableDivisor := FDivisor;

end; {procedure, Compute}


{------------------------------------------------------------------------------}
{ TppDBCalc.RestorePriorValue }

procedure TppDBCalc.RestorePriorValue;
begin
  FValue := FPriorValue;
  FDivisor := FPriorDivisor;

end;


{------------------------------------------------------------------------------}
{ TppDBCalc.ComputeInitialValue }

function TppDBCalc.ComputeInitialValue: Double;
var
  lValue: Variant;
begin

  if ResetOnCompute then
    begin
      if Assigned(FOnGroupBreak) then FOnGroupBreak(Self);
      SendEventNotify(Self, ciGroupBreak, nil);
    end;

  if (DataPipeline <> nil) and (DataField <> '') then
    lValue := GetFieldValue
  else
    lValue := 0;

  if (VarIsNull(lValue)) then
    Result := 0

{$IFDEF Delphi6}
  else if (VarType(lValue) in [varSmallInt..varCurrency, varShortInt..varInt64]) then
{$ELSE}
  else if (VarType(lValue) in [varSmallInt..varCurrency]) then
{$ENDIF}

    Result := lValue

  else if (VarType(lValue) = varDate) then
    Result := VarAsType(lValue, varDouble)

  else
    Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppDBCalc.ComputeValueForCalcType }

function TppDBCalc.ComputeValueForCalcType(aValue: Double): Double;
begin

  Result := 0;

  case FDBCalcType of
    dcCount:
      Result := FDivisor;

    dcSum, dcAverage:
      Result := FValue + aValue;

    dcMinimum:
      begin
        if (ResetOnCompute) then
          Result := aValue
        else
          begin
            if aValue < FValue then
              Result := aValue
            else
              Result := FValue;
          end;
      end;

    dcMaximum:
      begin
        if (ResetOnCompute) then
          Result := aValue
        else
          begin
            if aValue > FValue then
              Result := aValue
            else
              Result := FValue;
          end;
      end;

  end; {case, calc type}

end;

{------------------------------------------------------------------------------}
{ TppDBCalc.UpdateLookAheadTotal }

procedure TppDBCalc.UpdateLookAheadTotal;
begin

  if (FLookAheadList <> nil) and (GetMainReport.FirstPass) then
    FLookAheadList.UpdateTotal(GetLookAheadKey, GetTraversalCount, Text);

end; {procedure, UpdateLookAheadTotal}

{------------------------------------------------------------------------------}
{ TppDBCalc.SetLookAhead }

procedure TppDBCalc.SetLookAhead(aValue: Boolean);
var
  lMainReport: TppCustomReport;
begin

  if Printing then Exit;
  
  FLookAhead := aValue;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FLookAhead) then
    begin
      lMainReport := GetMainReport;

      if (lMainReport <> nil) then
        lMainReport.PassSetting := psTwoPass;
    end;

  PropertyChange;

  Reset;

end; {procedure, SetLookAhead}

{------------------------------------------------------------------------------}
{ TppDBCalc.CanCalcLookAheads }

function TppDBCalc.CanCalcLookAheads: Boolean;
var
  lMainReport: TppCustomReport;
begin

  lMainReport := GetMainReport;

  Result := (lMainReport <> nil) and (lMainReport.PassSetting = psTwoPass) and FLookAhead;

end; {procedure, CanCalcLookAheads}

{------------------------------------------------------------------------------}
{ TppDBCalc.StartOfMainReport }

procedure TppDBCalc.StartOfMainReport;
begin
  InitLookAhead;
end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppDBCalc.EndOfMainReport }

procedure TppDBCalc.EndOfMainReport;
begin
  if (FLookAheadList <> nil) then
    FLookAheadList.SignOffTotals;
end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppDBCalc.InitLookAhead }

procedure TppDBCalc.InitLookAhead;
begin

  if (FLookAheadList <> nil) then
    begin
      FLookAheadList.Free;

      FLookAheadList := nil;
    end;

  if not(CanCalcLookAheads) then Exit;

  FLookAheadList := TppLookAheadList.CreateList(Self);

end; {procedure, InitLookAhead}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetTraversalCount }

function TppDBCalc.GetTraversalCount: Integer;
begin

  if (DataPipeline <> nil) then
    Result := DataPipeline.TraversalCount

  else if (ResetGroup <> nil) and (ResetGroup.DataPipeline <> nil) then
    Result := ResetGroup.DataPipeline.TraversalCount

  else if (Band is TppDetailBand) and (TppDetailBand(Band).DataPipeline <> nil) then
    Result := TppDetailBand(Band).DataPipeline.TraversalCount

  else if (Band.Report.DataPipeline <> nil) then
    Result := Band.Report.DataPipeline.TraversalCount

  else
    Result := 0;

end; {function, GetTraversalCount}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetReportKey }

function TppDBCalc.GetReportKey: String;
var
  lsKey: String;
begin

  if (CanCalcLookAheads) and (Band.Report <> Band.Report.MainReport) then
    begin
      lsKey := '';

      Band.Report.GetReportKey(lsKey);

      Result := lsKey;
    end
  else
    Result := '';

end; {procedure, GetReportKey}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetLookAheadKey }

function TppDBCalc.GetLookAheadKey: String;
begin
  Result := GetReportKey + Format('%8d', [GetIDNo1]) + '|' + Format('%8d', [GetIDNo2]);
end; {function, GetLookAheadKey}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetIDNo1 }

function TppDBCalc.GetIDNo1: Integer;
begin

  if (ResetGroup is TppGroup) then
    Result := TppGroup(ResetGroup).BreakNo

  else if (BandType in [btHeader, btFooter, btColumnHeader, btColumnFooter]) then
    Result := Band.Report.AbsolutePageNo

  else
    Result := 0;

end; {function, GetIDNo1}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetIDNo2 }

function TppDBCalc.GetIDNo2: Integer;
begin

  if (ResetGroup is TppGroup) then
    Result := 0

  else if (BandType in [btColumnHeader, btColumnFooter]) then
    Result := Band.Report.CurrentColumn

  else
    Result := 0;

end; {function, GetIDNo2}

{------------------------------------------------------------------------------}
{ TppDBCalc.PropertiesToDrawCommand }

procedure TppDBCalc.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawVariable: TppDrawVariable;
  lsLookAheadKey: String;
  lMainReport: TppCustomReport;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  lDrawVariable := TppDrawVariable(aDrawCommand);

  if (FLookAheadList <> nil) then
    begin
      lsLookAheadKey := GetLookAheadKey;

      lDrawVariable.Text := FLookAheadList.RetrieveTotal(lsLookAheadKey, GetTraversalCount, lDrawVariable.Text);

      {make draw command update on-the-fly}
      lMainReport := GetMainReport;

      if (lMainReport <> nil) and (lMainReport.FirstPass) then
        begin
          lDrawVariable.LookAhead := True;
          lDrawVariable.LookAheadKey := lsLookAheadKey;

          AddEventNotify(lDrawVariable.WalkieTalkie);
        end;
    end;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppDBCalc.GetLookAheadValue }

function TppDBCalc.GetLookAheadValue(const aLookAheadKey: String): String;
begin
  Result := FLookAheadList.RetrieveTotal(aLookAheadKey, GetTraversalCount, '0')
end; {function, GetLookAheadValue}

{------------------------------------------------------------------------------}
{ TppDBCalc.SetBand }

procedure TppDBCalc.SetBand(aBand: TppBand);
begin


  inherited SetBand(aBand);


  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;


  if (pppcDesigning in DesignState) then
    begin

      {set group,  if no group currenly assigned and the band being assigned is a group band}
      if ( (Band <> nil) and (Band is TppGroupBand) ) then
        ResetGroup := (Band as TppGroupBand).Group
      else
        ResetGroup := nil;

    end;

end; {procedure, SetBand}


{******************************************************************************
 *
 ** C U S T O M   G R A P H I C
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomGraphic.Create }

constructor TppCustomGraphic.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  spWidth   := 50;
  spHeight  := 50;

  FBrush := TBrush.Create;
  FPen   := TPen.Create;

  {if pen or brush changed - notify design control}
  FPen.OnChange   := StyleChanged;
  FBrush.OnChange := StyleChanged;
end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.Destroy }

destructor TppCustomGraphic.Destroy;
begin
  FBrush.Free;
  FPen.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.SetPen }

procedure TppCustomGraphic.SetPen(aPen: TPen);
begin
  FPen.Assign(aPen);
  StyleChanged(Self);
end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.SetBrush }

procedure TppCustomGraphic.SetBrush(aBrush: TBrush);
begin
  FBrush.Assign(aBrush);
  StyleChanged(Self);
end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.GetBackGroundColor }

procedure TppCustomGraphic.GetBackGroundColor(var aColor: TColor; var aIsClear: Boolean);
begin

  aColor   := FBrush.Color;
  aIsClear := (FBrush.Style = bsClear);

end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.GetForeGroundColor }

procedure TppCustomGraphic.GetForeGroundColor(var aColor: TColor; var aIsClear: Boolean);
begin

  aColor   := FPen.Color;
  aIsClear := (FPen.Style = psClear);

end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.SetBackgroundColor }

procedure TppCustomGraphic.SetBackgroundColor(aColor: TColor; aIsClear: Boolean);
var
  lbBrushStyleChange: Boolean;
  lbBrushColorChange: Boolean;
begin

  lbBrushColorChange := (FBrush.Color <> aColor) and not(aIsClear);

  if (aIsClear) then
    lbBrushStyleChange := (FBrush.Style <> bsClear)
  else
    lbBrushStyleChange := (FBrush.Style = bsClear);

  if lbBrushColorChange then
    begin
      BeforePropertyChange('Brush.Color');
      FBrush.Color := aColor;
      PropertyChange;
    end;

  if lbBrushStyleChange then
    begin
      BeforePropertyChange('Brush.Style');
      if aIsClear then
        FBrush.Style := bsClear
      else
        FBrush.Style := bsSolid;
      PropertyChange;
    end;

  StyleChanged(Self);

end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.SetForegroundColor }

procedure TppCustomGraphic.SetForegroundColor(aColor: TColor; aIsClear: Boolean);
var
  lbPenStyleChange: Boolean;
  lbPenColorChange: Boolean;
begin

  lbPenColorChange := (FPen.Color <> aColor) and not(aIsClear);

  if (aIsClear) then
    lbPenStyleChange := (FPen.Style <> psClear)
  else
    lbPenStyleChange := (FPen.Style = psClear);

  if lbPenColorChange then
    begin
      BeforePropertyChange('Pen.Color');
      FPen.Color := aColor;
      PropertyChange;
    end;

  if lbPenStyleChange then
    begin
      BeforePropertyChange('Pen.Style');
      if aIsClear then
        FPen.Style := psClear
      else
        FPen.Style := psSolid;
      PropertyChange;
    end;

  StyleChanged(Self);

end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.SetPenWidth }

procedure TppCustomGraphic.SetPenWidth(aWidth: Integer);
begin
  FPen.Width := aWidth;
  StyleChanged(Self);
end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.StyleChanged }

procedure TppCustomGraphic.StyleChanged(Sender: TObject);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  InvalidateDesignControl;
  
  PropertyChange;

  Reset;

end;

{------------------------------------------------------------------------------}
{ TppCustomGraphic.HasFont }

function TppCustomGraphic.HasFont: Boolean;
begin
  Result := False;
end;


{******************************************************************************
 *
 ** S H A P E
 *
{******************************************************************************}
{------------------------------------------------------------------------------}
{ TppShape.Create }

constructor TppShape.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  DrawCommandClass := TppDrawShape;

  FShapeType := stRectangle;
  FGradient := TppGradient.Create(Self);
  FGradient.OnChange := StyleChanged;

  DefaultPropName     := 'Shape';
  DefaultPropEditType := etValueList;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppShape.Destroy }

destructor TppShape.Destroy;
begin
  FGradient.Free;
  FGradient := nil;

  inherited;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppShape.SetShape}

procedure TppShape.SetShape(aShapeType: TShapeType);
begin
  BeforePropertyChange('Shape');

  FShapeType := aShapeType;

  StyleChanged(Self);

end; {procedure, SetShape}

{------------------------------------------------------------------------------}
{ TppShape.CalcDimensions }

procedure TppShape.CalcDimensions(var aLeft, aTop, aRight, aBottom, aXCornerRound, aYCornerRound: Longint);
var
  liWidth: Integer;
  liHeight: Integer;
  liSide: Integer;
begin

  aLeft   := FPen.Width div 2;
  aTop    := aLeft;

  if Printing then
    begin
      liWidth  := ppToScreenPixels(PrintPosRect.Right - PrintPosRect.Left, utMMThousandths, pprtHorizontal, nil);
      liHeight := ppToScreenPixels(PrintPosRect.Bottom - PrintPosRect.Top, utMMThousandths, pprtVertical, nil);
    end

  else
    begin
      liWidth  := spWidth;
      liHeight := spHeight;
    end;

  aRight  := (aLeft + liWidth)  - ((FPen.Width div 2) * 2);
  aBottom := (aTop  + liHeight) - ((FPen.Width div 2) * 2);

  {determine length of the shortest side, use for circles, squares and corner rounding}
  if (liWidth < liHeight) then
    liSide := liWidth
  else
    liSide := liHeight;

  {if shape is square or circle, make 'sides' of shape equal}
  if FShapeType in [stSquare, stRoundSquare, stCircle] then
    begin
      {recalc top & left drawing positions based on centered side}
      Inc(aLeft, (liWidth  - liSide) div 2);
      Inc(aTop,  (liHeight - liSide) div 2);

      {set width and height to side}
      Dec(aRight, (liWidth  - liSide) div 2);
      Dec(aBottom,  (liHeight - liSide) div 2);
    end; {if shape has equal 'sides'}

  aXCornerRound := liSide div 4;
  aYCornerRound := liSide div 4;

end; {procedrue, CalcDimensions}

{------------------------------------------------------------------------------}
{ TppShape.Convert }

procedure TppShape.Convert(aVersionNo: Integer);
begin
  inherited Convert(aVersionNo);

{$IFDEF NewRect}
  if (aVersionNo < 11) then
    FOldStyle := True;
{$ENDIF}

end; {procedure, Convert}


{------------------------------------------------------------------------------}
{ TppShape.GetDefaultPropHint }

function TppShape.GetDefaultPropHint: String;
begin
  Result := ppLoadStr(118);
end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TppShape.PropertiesToDrawCommand }

procedure TppShape.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawShape;
  llXCornerRound: Longint;
  llYCornerRound: Longint;
  llLeft: Longint;
  llTop: Longint;
  llRight: Longint;
  llBottom: Longint;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawShape) then Exit;

  CalcDimensions(llLeft, llTop, llRight, llBottom, llXCornerRound, llYCornerRound);

  llLeft := PrintPosRect.Left + ppToMMThousandths(llLeft, utScreenPixels, pprtVertical, nil);
  llTop := PrintPosRect.Top + ppToMMThousandths(llTop, utScreenPixels, pprtVertical, nil);
  llRight := PrintPosRect.Left + ppToMMThousandths(llRight, utScreenPixels, pprtVertical, nil);
  llBottom := PrintPosRect.Top + ppToMMThousandths(llBottom, utScreenPixels, pprtVertical, nil);
  llXCornerRound := ppToMMThousandths(llXCornerRound, utScreenPixels, pprtVertical, nil);
  llYCornerRound := ppToMMThousandths(llYCornerRound, utScreenPixels, pprtVertical, nil);

  lDrawCommand := TppDrawShape(aDrawCommand);

  {transfer properties to draw command}
  lDrawCommand.Brush        := FBrush;
  lDrawCommand.Pen          := FPen;
  lDrawCommand.Left         := llLeft;
  lDrawCommand.Top          := llTop;
  lDrawCommand.Height       := llBottom - llTop;
  lDrawCommand.Width        := llRight - llLeft;
  lDrawCommand.ShapeType    := FShapeType;
  lDrawCommand.XCornerRound := llXCornerRound;
  lDrawCommand.YCornerRound := llYCornerRound;

  lDrawCommand.Gradient.Assign(FGradient);

{$IFDEF NewRect}
  lDrawCommand.OldStyle     := FOldStyle;
{$ENDIF}
  {set draw command type}
  if (FShapeType = stSquare) then
    lDrawCommand.ShapeType := stRectangle

  else if (FShapeType = stCircle) then
    lDrawCommand.ShapeType := stEllipse

  else if (FShapeType = stRoundSquare) then
    lDrawCommand.ShapeType := stRoundRect;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppShape.GetDefaultPropEnumNames }

procedure TppShape.GetDefaultPropEnumNames(aList: TStrings);
begin

  aList.Clear;

  aList.Add(ppLoadStr(318));
  aList.Add(ppLoadStr(319));
  aList.Add(ppLoadStr(320));
  aList.Add(ppLoadStr(321));
  aList.Add(ppLoadStr(322));
  aList.Add(ppLoadStr(323));

end; {procedure, GetDefaultPropEnumNames}

procedure TppShape.SetGradient(Value: TppGradient);
begin
  FGradient.Assign(Value);

  StyleChanged(Self);

end;



{------------------------------------------------------------------------------}
{ TppShape.StyleChanged }

procedure TppShape.StyleChanged(Sender: TObject);
begin

  inherited StyleChanged(Sender);

 {set transparent based upon the value of brush style}
  if (Transparent <> (FBrush.Style = bsClear)) then
    Transparent := (FBrush.Style = bsClear);

end; {procedure, StyleChanged}



{******************************************************************************
 *
 ** L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLine.Create }

constructor TppLine.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FOldPenWidth := 0;
  FPosition := lpTop;
  FSettingWeight := False;
  FStyle := lsSingle;
  FWeight := 0.75;
  Brush.Style := bsClear;

  DrawCommandClass := TppDrawLine;
  spWidth     := 50;
  spHeight    := 15;
  Transparent := True;

  DefaultPropName     := 'Position';
  DefaultPropEditType := etValueList;


end; {constructor TppLine}

{------------------------------------------------------------------------------}
{ TppLine.Convert }

procedure TppLine.Convert(aVersionNo: Integer);
begin
  inherited Convert(aVersionNo);

  if (aVersionNo < 3000) then
    FWeight := ((Pen.Width / Screen.PixelsPerInch) * 72);

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppLine.GetDefaultPropHint }

function TppLine.GetDefaultPropHint: String;
begin
  Result := ppLoadStr(117);
end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TppLine.HasColor }

function  TppLine.HasColor: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppLine.SetStyle }

procedure TppLine.SetStyle(aLineStyle: TppLineStyleType);
begin
  BeforePropertyChange('Style');

  FStyle := aLineStyle;
  StyleChanged(Self);

  AfterPropertyChange;
  
end;

{------------------------------------------------------------------------------}
{ TppLine.SetPosition }

procedure TppLine.SetPosition(aLinePosition: TppLinePositionType);
begin
  if (FPosition <> aLinePosition) then
    begin
      BeforePropertyChange('Position');

      FPosition := aLinePosition;
      StyleChanged(Self);
    end;

end;

{------------------------------------------------------------------------------}
{ TppLine.StyleChanged }

procedure TppLine.StyleChanged(Sender: TObject);
begin

  inherited StyleChanged(Sender);

  if (FSettingWeight) then Exit;

  if (FOldPenWidth <> Pen.Width) then
    begin
      FOldPenWidth := Pen.Width;

      FWeight := ((Pen.Width / Screen.PixelsPerInch) * 72);
    end;

end;

{------------------------------------------------------------------------------}
{ TppLine.SetWeight }

procedure TppLine.SetWeight(aWeight: Single);
begin


  if (FWeight <> aWeight) then
    begin
      BeforePropertyChange('Weight');
      FSettingWeight := True;

      FWeight := aWeight;

      Pen.Width := Round(aWeight * Screen.PixelsPerInch / 72);

      FOldPenWidth := Pen.Width;

      FSettingWeight := False;

//    do not call property change, it fires when Pen.Width is set above
//    PropertyChange;

    end;

end; {procedure, SetWeight}


{------------------------------------------------------------------------------}
{ TppLine.PropertiesToDrawCommand }

procedure TppLine.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawLine;
  llWidth: Longint;
  llHeight: Longint;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawLine) then Exit;

  lDrawCommand := TppDrawLine(aDrawCommand);

  llWidth := (PrintPosRect.Right - PrintPosRect.Left);
  llHeight := (PrintPosRect.Bottom - PrintPosRect.Top);

  {transfer properties to draw command}
  lDrawCommand.LineStyle    := FStyle;
  lDrawCommand.LinePosition := FPosition;
  lDrawCommand.Left         := PrintPosRect.Left;
  lDrawCommand.Top          := PrintPosRect.Top;
  lDrawCommand.Height       := llHeight;
  lDrawCommand.Width        := llWidth;
  lDrawCommand.Pen          := FPen;
  lDrawCommand.Weight       := FWeight;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppLine.GetDefaultPropEnumNames }

procedure TppLine.GetDefaultPropEnumNames(aList: TStrings);
begin

  aList.Clear;
  
  aList.Add(ppLoadStr(182)); {top}
  aList.Add(ppLoadStr(325)); {bottom}
  aList.Add(ppLoadStr(181)); {left}
  aList.Add(ppLoadStr(327)); {right}
  aList.Add(ppLoadStr(1161)); {diagonal left}
  aList.Add(ppLoadStr(1162)); {diagonal right}

end; {procedure, GetDefaultPropEnumNames}


{******************************************************************************
 *
 ** C U S T O M   I M A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomImage.Create }

constructor TppCustomImage.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  {init inherited properties}
  DrawCommandClass := TppDrawImage;

  spHeight   := 50;
  spWidth    := 50;

  FDirectDraw          := False;
  FMaintainAspectRatio := False;
  FPicture             := TPicture.Create;
  FStretch             := False;
  Transparent          := False;
  FImageID             := 0;
  FAlignHorizontal     := ahCenter;
  FAlignVertical       := avCenter;

  {assign event handler for picture}
  FPicture.OnChange := PictureChanged;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCustomImage.Destroy }

destructor TppCustomImage.Destroy;
begin
  FPicture.Free;

  inherited Destroy;
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCustomImage.DefineProperties }

procedure TppCustomImage.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  {Used for converstion to 11.0}
  Filer.DefineProperty('Center', ReadCenter, nil, False);

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppCustomImage.ReadCenter }

procedure TppCustomImage.ReadCenter(Reader: TReader);
begin
  SetCenter(Reader.ReadBoolean);

end; {procedure, ReadCenter}

{------------------------------------------------------------------------------}
{ TppCustomImage.Convert }

procedure TppCustomImage.Convert(aVersionNo: Integer);
begin
  inherited Convert(aVersionNo);

  {convert DirectDraw to False, except for MetaFiles}
  if (aVersionNo <= 4200) then
    if (FPicture.Graphic <> nil) and not(FPicture.Graphic.Empty) then
      FDirectDraw := (FPicture.Graphic is TMetaFile);

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppCustomImage.HasColor }

function  TppCustomImage.HasColor: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TppCustomImage.HasFont }

function  TppCustomImage.HasFont: Boolean;
begin
  Result := False;
end;


{------------------------------------------------------------------------------}
{ TppCustomImage.SetAutoSize }

procedure TppCustomImage.SetAutoSize(Value: Boolean);
begin

  inherited SetAutoSize(Value);

  PictureChanged(Self);

end; {procedure, SetAutoSize}

{------------------------------------------------------------------------------}
{ TppCustomImage.GetCaption }

function TppCustomImage.GetCaption: String;
begin

  if IsDataAware and (DataField <> '') then
    begin
      if DataPipeline <> nil then
        Result := DataPipeline.FieldAliasForFieldName(DataField)
      else
        Result := DataField;
    end
  else
    Result := UserName;

end; {procedure, GetCaption}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetCenter }

procedure TppCustomImage.SetCenter(Value: Boolean);
begin

  if Value then
    begin
      AlignHorizontal := ahCenter;
      AlignVertical := avCenter;
    end
  else
    begin
      AlignHorizontal := ahLeft;
      AlignVertical := avTop;
    end;

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetCenter}

{------------------------------------------------------------------------------}
{ TppCustomImage.GetCenter }

function TppCustomImage.GetCenter: Boolean;
begin
  Result := (AlignHorizontal = ahCenter) and (AlignVertical = avCenter);

end; {function, GetCenter}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetDirectDraw }

procedure TppCustomImage.SetDirectDraw(Value: Boolean);
begin

  FDirectDraw := Value;

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetDirectDraw}


{------------------------------------------------------------------------------}
{ TppCustomImage.SetMaintainAspectRatio }

procedure TppCustomImage.SetMaintainAspectRatio(Value: Boolean);
begin
  if FMaintainAspectRatio = Value then Exit;

  BeforePropertyChange('MaintainAspectRatio');

  FMaintainAspectRatio := Value;

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetMaintainAspectRatio}


{------------------------------------------------------------------------------}
{ TppCustomImage.GetPicture }

function TppCustomImage.GetPicture: TPicture;
begin
  Result := FPicture;
end; {procedure, GetPicture}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetPicture }

procedure TppCustomImage.SetPicture(aPicture: TPicture);
begin
  BeforePropertyChange('Picture');

  FPicture.Assign(aPicture);

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetPicture}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetStretch }

procedure TppCustomImage.SetStretch(Value: Boolean);
begin

  BeforePropertyChange('Stretch');

  FStretch := Value;

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetStretch}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetTransparent }

procedure TppCustomImage.SetTransparent(Value: Boolean);
begin

  inherited SetTransparent(Value);

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetTransparent}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetAlignHorizontal }

procedure TppCustomImage.SetAlignHorizontal(Value: TppAlignHorizontalType);
begin

  if FAlignHorizontal = Value then Exit;

  BeforePropertyChange('AlignHorizontal');

  FAlignHorizontal := Value;

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetAlignHorizontal}

{------------------------------------------------------------------------------}
{ TppCustomImage.SetAlignVertical }

procedure TppCustomImage.SetAlignVertical(const Value: TppAlignVerticalType);
begin

  if FAlignVertical = Value then Exit;

  BeforePropertyChange('AlignVertical');

  FAlignVertical := Value;

  PictureChanged(Self);

  PropertyChange;

end; {procedure, SetAlignVertical}

{------------------------------------------------------------------------------}
{ TppCustomImage.CalcPrintPosition }

procedure TppCustomImage.CalcPrintPosition;
begin

  GetPicture;

  inherited;

end;

{------------------------------------------------------------------------------}
{ TppCustomImage.PictureChanged }

procedure TppCustomImage.PictureChanged(Sender: TObject);
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if AutoSize and (FPicture.Width > 0) and (FPicture.Height > 0) then
    spSetBounds(spLeft, spTop, FPicture.Width, FPicture.Height);

  if AutoSize and (FPicture.Graphic = nil) then
    if not(pppcDesigning in DesignState) or (Printing) then
      spSetBounds(spLeft, spTop, 0, 0);

 InvalidateDesignControl;

 if (GeneratingNewPage) then
   Inc(FImageID);

end; {procedure, PictureChanged}

{------------------------------------------------------------------------------}
{ TppCustomImage.PropertiesToDrawCommand }

procedure TppCustomImage.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawImage;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawImage) then Exit;


  lDrawCommand := TppDrawImage(aDrawCommand);

  {transfer properties to draw command}
  lDrawCommand.Left := PrintPosRect.Left;
  lDrawCommand.Top := PrintPosRect.Top;
  lDrawCommand.Height := PrintPosRect.Bottom - PrintPosRect.Top;
  lDrawCommand.Width := PrintPosRect.Right - PrintPosRect.Left;
  lDrawCommand.AlignHorizontal := FAlignHorizontal;
  lDrawCommand.AlignVertical := FAlignVertical;
  lDrawCommand.Stretch := FStretch;
  lDrawCommand.MaintainAspectRatio := FMaintainAspectRatio;
  lDrawCommand.DirectDraw := FDirectDraw;

  {we need a name for the optimization scheme}
  if (Name = '') then
    Name := GetValidName(Self);

  lDrawCommand.ImageName := Name + IntToStr(FImageID);

  lDrawCommand.Picture := FPicture;
  lDrawCommand.Transparent := Transparent;

end; {procedure, PropertiesToDrawCommand}


{------------------------------------------------------------------------------}
{ TppCustomImage.Init }

procedure TppCustomImage.Init;
begin
  inherited Init;

  //FImageID := 0;
end; {procedure, Init}


{******************************************************************************
 *
 ** I M A G E
 *
{******************************************************************************}




{******************************************************************************
 *
 ** D B I M A G E
 *
{******************************************************************************}

const
  cAutoDetect = 'AutoDetect'; // do not localize

{------------------------------------------------------------------------------}
{ TppDBImage.Create }

constructor TppDBImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAutoDisplay  := True;
  FOnGetPicture := nil;

  FGraphicType := cAutoDetect;


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDBImage.Destroy }

destructor TppDBImage.Destroy;
begin
  inherited Destroy;
end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDBImage.GetDescription }

function TppDBImage.GetDescription: String;
begin
  if (DataField <> '') then
    Result := UserName + ': ' + DataField
  else
    Result := UserName;

end; {function, GetDescription}

{------------------------------------------------------------------------------}
{ TppDBImage.Notify }

procedure TppDBImage.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (csDestroying in ComponentState) then Exit;

  if (aCommunicator = DataPipeline) and (aOperation in [ppopDataChange, ppopRemove]) and (pppcDesigning in DesignState) and not(Printing) then
    LoadPicture;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppDBImage.SetAutoDisplay }

procedure TppDBImage.SetAutoDisplay(Value: Boolean);
begin

  if FAutoDisplay <> Value then
    begin
      FAutoDisplay := Value;

      if Value then LoadPicture;
    end;

end;

{------------------------------------------------------------------------------}
{ TppDBImage.SetGraphicType }

procedure TppDBImage.SetGraphicType(aGraphicType: String);
begin

  if (aGraphicType <> cAutoDetect) and (ppGetGraphicClassForName(aGraphicType) = nil) then Exit;

  if (FGraphicType <> aGraphicType) then
    begin
      BeforePropertyChange('GraphicType');

      FGraphicType := aGraphicType;

      if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

      {default DirectDraw to False, except for MetaFiles}
      FDirectDraw := (FGraphicType = 'MetaFile');

      PropertyChange;

      Reset;
    end;


end; {procedure, SetGraphicType}

{------------------------------------------------------------------------------}
{ TppDBImage.DoOnGetPicture }

procedure TppDBImage.DoOnGetPicture(Sender: TObject; aPicture: TPicture);
var
  lParams: TraParamList;
begin

  if Assigned(FOnGetPicture) then
    FOnGetPicture(Sender, aPicture);

  lParams := TraTppDBImageRTTI.GetParams('OnGetPicture');
  lParams.CreateValuePointer(0, aPicture);

  SendEventNotify(Self, ciComponentGetPicture, lParams);

  lParams.Free;

end; {procedure, DoOnGetPicture}

{------------------------------------------------------------------------------}
{ TppDBImage.GetGraphicClass }

function TppDBImage.GetGraphicClass: TGraphicClass;
begin

  Result := ppGetGraphicClassForName(FGraphicType);

end; {function, GetGraphicClass}

{------------------------------------------------------------------------------}
{ TppDBImage.GetGraphicClass }

function TppDBImage.GetGraphicClassForStream(aStream: TStream): TGraphicClass;
var
  lsGraphicType: String;
begin

  if FGraphicType = cAutoDetect then
    begin
      lsGraphicType := TppGraphicDetector.GetGraphicType(aStream);
      if lsGraphicType = 'unknown' then
        raise EDataError.Create('Unable to auto-detect graphic type');
    end
  else
    lsGraphicType := FGraphicType;

  Result := ppGetGraphicClassForName(lsGraphicType);

  if (Result = nil) then
    raise EDataError.Create('No graphic class registered for type: ' + lsGraphicType);

end; {function, GetGraphicClass}

{------------------------------------------------------------------------------}
{ TppDBImage.GetPicture }

function TppDBImage.GetPicture: TPicture;
begin
  LoadPicture;

  Result := inherited GetPicture;
end;

{------------------------------------------------------------------------------}
{ TppDBImage.LoadPicture }

procedure TppDBImage.LoadPicture;
var
  lDataType: TppDataType;
  lImageStream: TMemoryStream;
  lGraphic: TGraphic;
  lGraphicClass: TGraphicClass;
  lsFileName: String;
  lValue: Variant;
begin

  // this will cause the Picture to free its graphic objects
  FPicture.Graphic := nil;

  if not(FAutoDisplay) and not((Assigned(FOnGetPicture)) or (IsActiveNotify(ciComponentGetPicture))) then Exit;

  if ((Assigned(FOnGetPicture)) or (IsActiveNotify(ciComponentGetPicture))) then
    DoOnGetPicture(Self, FPicture)

  else if (CheckForPipelineData) then
    begin

      lDataType := dtNotKnown;

      try
        lDataType := DataPipeline.GetFieldDataType(DataField);
      except

      end;

      if (lDataType in [dtBLOB, dtGraphic, dtMemo]) then
        try
          lImageStream := TMemoryStream.Create;

          try
            DataPipeline.GetFieldAsStream(DataField, lImageStream);

            // if field is null, stream size will be 0
            if lImageStream.Size > 0 then
              begin
                lImageStream.Position := 0;

                lGraphicClass := GetGraphicClassForStream(lImageStream);

                 // for bitmaps, call DataPipeline.GetFieldAsPicture
                if (lGraphicClass = TBitmap) then
                  FPicture.Assign(DataPipeline.GetFieldAsPicture(DataField))
                else
                  begin
                    lGraphic := lGraphicClass.Create;
                    lGraphic.LoadFromStream(lImageStream);
                    FPicture.Graphic := lGraphic;
                    lGraphic.Free;
                  end;

              end;

          finally
            lImageStream.Free;
          end; {try, finally}

        except
          if Band.Report.Engine.Printing then
            Band.Report.RaiseException(EPrintError.Create(ppLoadStr(290)))
          else
            FPicture.Graphic :=  nil;
        end {try, except}

     else if (lDataType = dtString) then
      begin
        lValue := DataPipeline.GetFieldValue(DataField);

        if not VarIsNull(lValue) then
          begin
            lsFileName := lValue;

            if FileExists(lsFileName) then
              FPicture.LoadFromFile(lsFileName);
          end

      end;

    end;


  InvalidateDesignControl;

end; {procedure, LoadPicture}

{------------------------------------------------------------------------------}
{ TppDBImage.IsDataAware }

function TppDBImage.IsDataAware: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TppDBImage.SetDataField }

procedure TppDBImage.SetDataField(const Value: string);
begin

  inherited SetDataField(Value);

  {display the picture}
  LoadPicture;

  PropertyChange;


end; {procedure, SetDataField}

{------------------------------------------------------------------------------}
{ TppImage.PropertiesToDrawCommand }

procedure TppDBImage.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
begin

  inherited PropertiesToDrawCommand(aDrawCommand);


  TppDrawImage(aDrawCommand).ImageName := 'ppImage' + ppCreateGuidString;

end; {procedure, PropertiesToDrawCommand}


{******************************************************************************
 *
 ** R E G I S T E R   R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppGraphicClasses }

function ppGraphicClasses: TStringList;
begin

  if FGraphicClasses = nil then
    begin
      FGraphicClasses := TStringList.Create;

      {register default graphic classes}
      ppRegisterGraphicClass(cAutoDetect,   nil);
      ppRegisterGraphicClass('Bitmap',   TBitmap);
      ppRegisterGraphicClass('MetaFile', TMetaFile);
      ppRegisterGraphicClass('Icon',     TIcon);
      ppRegisterGraphicClass('JPEG',     TJPEGImage);
      ppRegisterGraphicClass('GIF',     TGifImage);

{$IFDEF Delphi12}
      ppRegisterGraphicClass('PNG',     TPngImage);
{$ENDIF}

      FGraphicClasses.Sorted := True;
    end;

  Result := FGraphicClasses;

end; {function,  ppGraphicClasses}


{------------------------------------------------------------------------------}
{ ppRegisterGraphicClass }

procedure ppRegisterGraphicClass(aName: String; aGraphicClass: TGraphicClass);
var
  liIndex: Integer;
begin

  if ppGraphicClasses.Find(aName, liIndex) then
    ppGraphicClasses.Objects[liIndex] := TObject(aGraphicClass)
  else
    ppGraphicClasses.AddObject(aName, TObject(aGraphicClass));

end; {procedure, ppRegisterGraphicClass}


{------------------------------------------------------------------------------}
{ ppUnRegisterGraphicClass }

procedure ppUnRegisterGraphicClass(aGraphicClass: TGraphicClass);
var
  liIndex: Integer;
begin

  if (FGraphicClasses = nil) then Exit;

  liIndex := ppGraphicClasses.IndexOfObject(TObject(aGraphicClass));

  if  liIndex >= 0 then
    ppGraphicClasses.Delete(liIndex);

end; {procedure, ppRegisterGraphicClass}

{------------------------------------------------------------------------------}
{ ppGetGraphicClassForName }

function ppGetGraphicClassForName(aName: String): TGraphicClass;
var
  liIndex: Integer;
begin

  if ppGraphicClasses.Find(aName, liIndex) then
    Result := TGraphicClass(ppGraphicClasses.Objects[liIndex])
  else
    Result := nil

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
 ** C U S T O M   T E X T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.RefClass }

class function TraTppCustomTextRTTI.RefClass: TClass;
begin
  Result := TppCustomText;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.GetPropList }

class procedure TraTppCustomTextRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddProp('RotatedOriginLeft');
  aPropList.AddProp('RotatedOriginTop');

end; {class function, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.GetEventList }

class procedure TraTppCustomTextRTTI.GetEventList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetEventList(aClass, aPropList);

  {remove OnFormat - no need to support this in RAP, OnFormat is retained in
    RB for backward compatibility only. }
  aPropList.RemoveProp('OnFormat');

end; {class procedure, GetEventList}


{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.GetParams }

class function TraTppCustomTextRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'OnGetText') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Text', daString, nil, '', False, True);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.GetPropRec }

class function TraTppCustomTextRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'OnGetText') = 0) then
    EventToRec(aPropName, ciComponentGetText, True, aPropRec)

  else if (CompareText(aPropName, 'AutoSize') = 0) then
    PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'CharWrap') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Color') = 0) then
    EnumPropToRec(aPropName, 'TColor', False, aPropRec)

  else if (CompareText(aPropName, 'Description') = 0) then
    PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'RotatedOriginLeft') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'RotatedOriginTop') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'SaveOrder') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Save') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'SaveLength') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'Text') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'Transparent') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.GetPropValue }

class function TraTppCustomTextRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AutoSize') = 0) then
    Boolean(aValue) := TppCustomText(aObject).AutoSize

  else if (CompareText(aPropName, 'Description') = 0) then
    String(aValue) := TppCustomText(aObject).Description

  else if (CompareText(aPropName, 'CharWrap') = 0) then
    Boolean(aValue) := TppCustomText(aObject).CharWrap

  else if (CompareText(aPropName, 'Color') = 0) then
    Integer(aValue) := Ord(TppCustomText(aObject).Color)

  else if (CompareText(aPropName, 'RotatedOriginLeft') = 0) then
    Integer(aValue) := TppCustomText(aObject).RotatedOrigin.X

  else if (CompareText(aPropName, 'RotatedOriginTop') = 0) then
    Integer(aValue) := TppCustomText(aObject).RotatedOrigin.Y

  else if (CompareText(aPropName, 'SaveOrder') = 0) then
    Integer(aValue) := TppCustomText(aObject).SaveOrder

  else if (CompareText(aPropName, 'Save') = 0) then
    Integer(aValue) := Ord(TppCustomText(aObject).Save)

  else if (CompareText(aPropName, 'SaveLength') = 0) then
    Integer(aValue) := TppCustomText(aObject).SaveLength

  else if (CompareText(aPropName, 'Text') = 0) then
    String(aValue) := TppCustomText(aObject).Text

  else if (CompareText(aPropName, 'Transparent') = 0) then
    Boolean(aValue) := TppCustomText(aObject).Transparent

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);
    
end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCustomTextRTTI.SetPropValue }

class function TraTppCustomTextRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AutoSize') = 0) then
    TppCustomText(aObject).AutoSize := Boolean(aValue)

  else if (CompareText(aPropName, 'CharWrap') = 0) then
    TppCustomText(aObject).CharWrap := Boolean(aValue)

  else if (CompareText(aPropName, 'Color') = 0) then
    TppCustomText(aObject).Color := TColor(aValue)

  else if (CompareText(aPropName, 'SaveOrder') = 0) then
    TppCustomText(aObject).SaveOrder := Integer(aValue)

  else if (CompareText(aPropName, 'Save') = 0) then
    TppCustomText(aObject).Save := Boolean(aValue)

  else if (CompareText(aPropName, 'SaveLength') = 0) then
    TppCustomText(aObject).SaveLength := Integer(aValue)

  else if (CompareText(aPropName, 'Text') = 0) then
    TppCustomText(aObject).Text := String(aValue)

  else if (CompareText(aPropName, 'Transparent') = 0) then
    TppCustomText(aObject).Transparent := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{******************************************************************************
 *
 ** C U S T O M   I M A G E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomImageRTTI.RefClass }

class function TraTppCustomImageRTTI.RefClass: TClass;
begin
  Result := TppCustomImage;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomImageRTTI.GetPropList }

class procedure TraTppCustomImageRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited GetPropList(aClass, aPropList);

  //Add public properties
  aPropList.AddProp('Center');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomImageRTTI.GetPropRec }

class function TraTppCustomImageRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Center') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'DirectDraw') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'MaintainAspectRatio') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Stretch') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'Transparent') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomImageRTTI.GetPropValue }

class function TraTppCustomImageRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Center') = 0) then
    Boolean(aValue) := TppCustomImage(aObject).Center

  else if (CompareText(aPropName, 'DirectDraw') = 0) then
    Boolean(aValue) := TppCustomImage(aObject).DirectDraw

  else if (CompareText(aPropName, 'MaintainAspectRatio') = 0) then
    Boolean(aValue) := TppCustomImage(aObject).MaintainAspectRatio

  else if (CompareText(aPropName, 'Stretch') = 0) then
    Boolean(aValue) := TppCustomImage(aObject).Stretch

  else if (CompareText(aPropName, 'Transparent') = 0) then
    Boolean(aValue) := TppCustomImage(aObject).Transparent

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCustomImageRTTI.SetPropValue }

class function TraTppCustomImageRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Center') = 0) then
    TppCustomImage(aObject).Center := Boolean(aValue)

  else if (CompareText(aPropName, 'DirectDraw') = 0) then
    TppCustomImage(aObject).DirectDraw := Boolean(aValue)

  else if (CompareText(aPropName, 'MaintainAspectRatio') = 0) then
    TppCustomImage(aObject).MaintainAspectRatio := Boolean(aValue)

  else if (CompareText(aPropName, 'Stretch') = 0) then
    TppCustomImage(aObject).Stretch := Boolean(aValue)

  else if (CompareText(aPropName, 'Transparent') = 0) then
    TppCustomImage(aObject).Transparent := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{******************************************************************************
 *
 ** T P P D B I M A G E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDBImageRTTI.GetPropList }

class procedure TraTppDBImageRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

    {add public props}
    aPropList.AddProp('Picture');

end; {class procedure, GetPropList}


{------------------------------------------------------------------------------}
{ TraTppDBImageRTTI.GetParams }

class function TraTppDBImageRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'OnGetPicture') = 0)  then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aPicture', daClass, TPicture, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppDBImageRTTI.GetPropRec }

class function TraTppDBImageRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Picture') = 0) then
     PropToRec(aPropName, daObject, False, aPropRec)

  {events}
  else if (CompareText(aPropName, 'OnGetPicture') = 0) then
    EventToRec(aPropName, ciComponentGetPicture, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;  {class function, GetPropRec}


{------------------------------------------------------------------------------}
{ TraTppDBImageRTTI.GetPropValue }

class function TraTppDBImageRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Picture') = 0) then
    TObject(aValue) := TppDBImage(aObject).Picture

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDBImageRTTI.SetPropValue }

class function TraTppDBImageRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Picture') = 0) then
    TppDBImage(aObject).Picture := TPicture(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}



{------------------------------------------------------------------------------}
{ TraTppDBImageRTTI.RefClass }

class function TraTppDBImageRTTI.RefClass: TClass;
begin
  Result := TppDBImage;
end; {class function, RefClass}



{******************************************************************************
 *
 ** C U S T O M   G R A P H I C   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppCustomGraphicRTTI.RefClass }

class function TraTppCustomGraphicRTTI.RefClass: TClass;
begin
  Result := TppCustomGraphic;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppCustomGraphicRTTI.GetPropList }

class procedure TraTppCustomGraphicRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppCustomGraphicRTTI.GetPropRec }

class function TraTppCustomGraphicRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Brush') = 0) then
    ClassPropToRec(aPropName, TBrush, False, aPropRec)

  else if (CompareText(aPropName, 'Pen') = 0) then
    ClassPropToRec(aPropName, TPen, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppCustomGraphicRTTI.GetPropValue }

class function TraTppCustomGraphicRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Brush') = 0) then
    Integer(aValue) := Integer(TppCustomGraphic(aObject).Brush)

  else if (CompareText(aPropName, 'Pen') = 0) then
    Integer(aValue) := Integer(TppCustomGraphic(aObject).Pen)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppCustomGraphicRTTI.SetPropValue }

class function TraTppCustomGraphicRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Brush') = 0) then
    TppCustomGraphic(aObject).Brush := TBrush(aValue)

  else if (CompareText(aPropName, 'Pen') = 0) then
    TppCustomGraphic(aObject).Pen := TPen(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** L I N E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppLineRTTI.RefClass }

class function TraTppLineRTTI.RefClass: TClass;
begin
  Result := TppLine;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppLineRTTI.GetPropList }

class procedure TraTppLineRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppLineRTTI.GetPropRec }

class function TraTppLineRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Position') = 0) then
    EnumPropToRec(aPropName, 'TppLinePositionType', False, aPropRec)

  else if (CompareText(aPropName, 'Style') = 0) then
    EnumPropToRec(aPropName, 'TppLineStyleType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppLineRTTI.GetPropValue }

class function TraTppLineRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Position') = 0) or (CompareText(aPropName, 'LinePosition') = 0) then
    TppLinePositionType(aValue) := TppLine(aObject).Position

  else if (CompareText(aPropName, 'Style') = 0) then
    TppLineStyleType(aValue) := TppLine(aObject).Style

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppLineRTTI.SetPropValue }

class function TraTppLineRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Position') = 0) then
    TppLine(aObject).Position := TppLinePositionType(aValue)

  else if (CompareText(aPropName, 'Style') = 0) then
    TppLine(aObject).Style := TppLineStyleType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** S H A P E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppShapeRTTI.RefClass }

class function TraTppShapeRTTI.RefClass: TClass;
begin
  Result := TppShape;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppShapeRTTI.GetPropList }

class procedure TraTppShapeRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppShapeRTTI.GetPropRec }

class function TraTppShapeRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Shape') = 0) then
    EnumPropToRec(aPropName, 'TShapeType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppShapeRTTI.GetPropValue }

class function TraTppShapeRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Shape') = 0) then
    TShapeType(aValue) := TppShape(aObject).Shape

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppShapeRTTI.SetPropValue }

class function TraTppShapeRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Shape') = 0) then
    TppShape(aObject).Shape := TShapeType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** D B T E X T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDBTextRTTI.RefClass }

class function TraTppDBTextRTTI.RefClass: TClass;
begin
  Result := TppDBText;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDBTextRTTI.GetPropList }

class procedure TraTppDBTextRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('FieldValue');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDBTextRTTI.GetPropRec }

class function TraTppDBTextRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AlreadyPrinted') = 0) then
     PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'BlankWhenZero') = 0) then
     PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'FieldValue') = 0) then
     PropToRec(aPropName, daVariant, True, aPropRec)

  else if (CompareText(aPropName, 'FirstPage') = 0) then
     PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'PriorValue') = 0) then
     PropToRec(aPropName, daString, True, aPropRec)

  else if (CompareText(aPropName, 'PriorValueSame') = 0) then
     PropToRec(aPropName, daBoolean, True, aPropRec)

  else if (CompareText(aPropName, 'ReprintOnSubsequent') = 0) then
     PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'SuppressRepeatedValues') = 0) then
     PropToRec(aPropName, daBoolean, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDBTextRTTI.GetPropValue }

class function TraTppDBTextRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AlreadyPrinted') = 0) then
    Boolean(aValue) := TppDBText(aObject).AlreadyPrinted

  else if (CompareText(aPropName, 'BlankWhenZero') = 0) then
    Boolean(aValue) := TppDBText(aObject).BlankWhenZero

  else if (CompareText(aPropName, 'FieldValue') = 0) then
    Variant(aValue) := TppDBText(aObject).FieldValue

  else if (CompareText(aPropName, 'FirstPage') = 0) then
    Integer(aValue) := TppDBText(aObject).FirstPage

  else if (CompareText(aPropName, 'PriorValue') = 0) then
    String(aValue) := TppDBText(aObject).PriorValue

  else if (CompareText(aPropName, 'PriorValueSame') = 0) then
    Boolean(aValue) := TppDBText(aObject).PriorValueSame

  else if (CompareText(aPropName, 'ReprintOnSubsequent') = 0) then
    Boolean(aValue) := TppDBText(aObject).ReprintOnSubsequent

  else if (CompareText(aPropName, 'SuppressRepeatedValues') = 0) then
    Boolean(aValue) := TppDBText(aObject).SuppressRepeatedValues

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDBTextRTTI.SetPropValue }

class function TraTppDBTextRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'BlankWhenZero') = 0) then
    TppDBText(aObject).BlankWhenZero := Boolean(aValue)

  else if (CompareText(aPropName, 'ReprintOnSubsequent') = 0) then
    TppDBText(aObject).ReprintOnSubsequent := Boolean(aValue)

  else if (CompareText(aPropName, 'SuppressRepeatedValues') = 0) then
    TppDBText(aObject).SuppressRepeatedValues := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{******************************************************************************
 *
 ** D B C A L C   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.RefClass }

class function TraTppDBCalcRTTI.RefClass: TClass;
begin
  Result := TppDBCalc;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.GetPropList }

class procedure TraTppDBCalcRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public props}
  aPropList.AddProp('Value');

  aPropList.AddMethod('Clear');
  aPropList.AddMethod('GetLookAheadKey');
  aPropList.AddMethod('GetLookAheadValue');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.GetPropRec }

class function TraTppDBCalcRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'GetLookAheadKey') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'GetLookAheadValue') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Divisor') = 0) then
    PropToRec(aPropName, daDouble, False, aPropRec)

  else if (CompareText(aPropName, 'Value') = 0) then
    PropToRec(aPropName, daVariant, True, aPropRec)

  else if (CompareText(aPropName, 'DBCalcType') = 0) then
    EnumPropToRec(aPropName, 'TppDBCalcType', False, aPropRec)

  else if (CompareText(aPropName, 'OnCalc') = 0) then
    EventToRec(aPropName, ciComponentCalc, False, aPropRec)

  else if (CompareText(aPropName, 'OnGroupBreak') = 0) then
    EventToRec(aPropName, ciGroupBreak, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.CallMethod }

class function TraTppDBCalcRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lDBCalc: TppDBCalc;
  lString: String;
  lsResult: String;
begin

  Result := True;

  lDBCalc := TppDBCalc(aObject);

  if ppEqual(aMethodName, 'Clear')  then
    lDBCalc.Clear
  else if ppEqual(aMethodName, 'GetLookAheadKey') then
    begin
      lsResult := lDBCalc.GetLookAheadKey;
      aParams.SetParamValue(0, lsResult);
    end
  else if ppEqual(aMethodName, 'GetLookAheadValue') then
    begin
      aParams.GetParamValue(0, lString);
      lsResult := lDBCalc.GetLookAheadValue(lString);
      aParams.SetParamValue(1, lsResult);
    end
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.GetPropValue }

class function TraTppDBCalcRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Divisor') = 0) then
    Double(aValue) := TppDBCalc(aObject).Divisor

  else if (CompareText(aPropName, 'Value') = 0) then
    Variant(aValue) := TppDBCalc(aObject).Value

  else if (CompareText(aPropName, 'DBCalcType') = 0) then
    TppDBCalcType(aValue) := TppDBCalc(aObject).DBCalcType

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.SetPropValue }

class function TraTppDBCalcRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Divisor') = 0) then
    TppDBCalc(aObject).Divisor := Double(aValue)

  else if (CompareText(aPropName, 'Value') = 0) then
    TppDBCalc(aObject).Value := Variant(aValue)

  else if (CompareText(aPropName, 'DBCalcType') = 0) then
    TppDBCalc(aObject).DBCalcType := TppDBCalcType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{------------------------------------------------------------------------------}
{ TraTppDBCalcRTTI.GetParams }

class function TraTppDBCalcRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'GetLookAheadKey') then
    begin
      Result := TraParamList.Create;
      
      Result.AddParam('Result', daString, nil, '', False, False);
    end
  else if ppEqual(aMethodName, 'GetLookAheadValue') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aLookAheadKey', daString, nil, '', True {IsConst}, False {IsVar});
      Result.AddParam('Result', daString, nil, '', False, False);
    end
  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TppImage.PictureChanged }

procedure TppImage.PictureChanged(Sender: TObject);
begin

  inherited;
  
  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

 PropertyChange;


end; {procedure, PictureChanged}

class function TppGraphicDetector.GetGraphicType(aFileName: String): String;
var
  lFileStream: TFileStream;
begin
  lFileStream := TFileStream.Create(aFileName, fmOpenRead);

  Result := GetGraphicType(lFileStream);

  lFileStream.Free;

end;

class function TppGraphicDetector.GetGraphicType(aStream: TStream): string;
var
  lBytes: TBytes;
  lsHeader: AnsiString;
begin

  SetLength(lBytes, 20);
  SetLength(lsHeader, 20);

  aStream.Read(lBytes[0], 20);
  aStream.Seek(-20, soFromCurrent);

  Move(lBytes[0], lsHeader[1], 20);

  if StartsWith(lsHeader, 'BM') then
    Result := 'Bitmap'
  else if StartsWith(lsHeader, 'JFIF') then
    Result := 'JPEG'
  else if StartsWith(lsHeader, 'PNG') then
    Result := 'PNG'
  else if StartsWith(lsHeader, 'GIF') then
    Result := 'GIF'
  else if IsEMFStream(aStream) then
    Result := 'MetaFile'
  else if IsWMFStream(aStream) then
    Result := 'MetaFile'
  else if StartsWith(lBytes, [0, 1]) then
    Result := 'Icon'
  else
    Result := 'unknown';

end;

class function TppGraphicDetector.StartsWith(aText, aSubString: AnsiString): Boolean;
begin
  Result := (Pos(aSubString, aText) > 0);
end;

class function TppGraphicDetector.StartsWith(aBytes: TBytes; aWords: array of word): Boolean;
var
  lPWord: PWord;
  liIndex: Integer;
begin

  Result := True;

  for liIndex := 0 to Length(aWords) - 1 do
    begin
      lPWord := @aBytes[liIndex*2];

      if lPWord^ <> aWords[liIndex] then
        begin
          Result := False;
          Exit;
        end;

    end;

end;

class function TppGraphicDetector.IsEMFStream(aStream: TStream): Boolean;
var
  liHeaderSize: Longint;
  lEnhHeader: TEnhMetaHeader;
begin

  Result := False;

  liHeaderSize := Sizeof(lEnhHeader);

  if aStream.Size < liHeaderSize then Exit;

  // read header
  aStream.Read(lEnhHeader, liHeaderSize);
  aStream.Seek(-liHeaderSize, soFromCurrent);

  // check signature
  Result := (lEnhHeader.iType = EMR_HEADER) and (lEnhHeader.dSignature = ENHMETA_SIGNATURE);

end;


const
  WMFKey  = Integer($9AC6CDD7);

type
  TMetafileHeader = packed record
    Key: Longint;
    Handle: SmallInt;
    Box: TSmallRect;
    Inch: Word;
    Reserved: Longint;
    CheckSum: Word;
  end;

class function TppGraphicDetector.CreateInstance(aStream: TStream): TGraphic;
var
  lGraphic: TGraphic;
  lGraphicClass: TGraphicClass;
begin

  Result := nil;

  lGraphicClass := GetGraphicClass(aStream);

  if lGraphicClass = nil then Exit;

  lGraphic := lGraphicClass.Create;
  lGraphic.LoadFromStream(aStream);

  Result := lGraphic;

end;

class function TppGraphicDetector.GetGraphicClass(aStream: TStream): TGraphicClass;
var
  lsGraphicType: string;
begin
  lsGraphicType := GetGraphicType(aStream);

  Result :=  ppGetGraphicClassForName(lsGraphicType);
end;

class function TppGraphicDetector.IsWMFStream(aStream: TStream): Boolean;
var
  liHeaderSize: Longint;
  lHeader: TMetafileHeader;
begin

  Result := False;

  liHeaderSize := Sizeof(lHeader);

  if aStream.Size < liHeaderSize then Exit;

  // read header
  aStream.Read(lHeader, liHeaderSize);
  aStream.Seek(-liHeaderSize, soFromCurrent);

  // check WMF key
  Result := (lHeader.Key = WMFKey);

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  raRegisterRTTI(TraTppCustomTextRTTI);
  raRegisterRTTI(TraTppCustomImageRTTI);
  raRegisterRTTI(TraTppDBImageRTTI);
  raRegisterRTTI(TraTppCustomGraphicRTTI);
  raRegisterRTTI(TraTppLineRTTI);
  raRegisterRTTI(TraTppShapeRTTI);
  raRegisterRTTI(TraTppDBTextRTTI);
  raRegisterRTTI(TraTppDBCalcRTTI);

finalization

  FGraphicClasses.Free;
  FGraphicClasses := nil;

  raUnRegisterRTTI(TraTppCustomTextRTTI);
  raUnRegisterRTTI(TraTppCustomImageRTTI);
  raUnRegisterRTTI(TraTppDBImageRTTI);
  raUnRegisterRTTI(TraTppCustomGraphicRTTI);
  raUnRegisterRTTI(TraTppLineRTTI);
  raUnRegisterRTTI(TraTppShapeRTTI);
  raUnRegisterRTTI(TraTppDBTextRTTI);
  raUnRegisterRTTI(TraTppDBCalcRTTI);

end.
