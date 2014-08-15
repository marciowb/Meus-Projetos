{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit ppVar;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants, {$ENDIF}
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,

  ppComm,
  ppDB,
  ppClass,
  ppTypes,
  ppUtils,
  ppDevice,
  ppPrnabl,
  ppStrtch,
  ppDrwCmd,
  ppCtrls,
  ppClasUt,
  ppRTTI;

type

  {@TppCustomVariable

    Abastract ancestor for variable components. The standard variable components
    provided with ReportBuilder are: TppVariable, TppSystemVariable.}

  TppCustomVariable = class(TppCustomText)
    protected
      function GetDataType: TppDataType; virtual; abstract;

      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

  end; {class, TppCustomVariable}

  {@TppVariable

    The TppVariable component is used to when you want to code your own
    calculations. The calculations are usually placed in the OnCalc event.
    (Note: If you are using RAP, ReportBuilder's native programming language,
    then consult the RAP help regarding the use of Variable components.) The
    DataType property designates the native type of the variable. You can
    control the appearance of this value with the DisplayFormat property.

    You can store the value of calculations in one of the following properties:
    AsBoolean, AsChar, AsCurrency, AsDateTime, AsDate, AsDouble, AsExtended,
    AsInteger, AsSingle, AsString, AsTime.  You can also store values which are
    any of these types in the Variable component via the Value property. Once
    the value is set the Text property will reflect the new value. If you want
    to format the data, simply assign the value and then assign the
    DisplayFormat property.  The Text property will then return a formatted
    value.  For example, if you set AsInteger := 1000 and DisplayFormat to
    '#,0', then the Text property will return '1,000'.

    The value of a Variable component is usually set from the OnCalc event of
    the component.  This approach is generally superior to using the OnPrint
    event, since OnPrint fires multiple times each time the band prints, and
    OnCalc fires only once per pass.

    You can control the appearance of this component (Font, Alignment, etc.) at
    design-time by using the Format Bar of the Report Designer. You can also set
    key properties by using the speed menu.  To access the speed menu, position
    the mouse cursor over the component and click the right mouse button.}

  {@TppVariable.AsBoolean

    When the DataType is set to dtBoolean, you can store and retrieve a boolean
    value using this property.}

  {@TppVariable.AsChar

    When the DataType is set to dtChar, you can store and retrieve a single
    character value using this property.}

  {@TppVariable.AsCurrency

    When the DataType is set to dtCurrency, you can store and retrieve a
    currency value using this property.}

  {@TppVariable.AsDate

    When the DataType is set to dtDate, you can store and retrieve a date value
    using this property.}

  {@TppVariable.AsDateTime

    When the DataType is set to dtDateTime, you can store and retrieve a
    datetime value using this property.}

  {@TppVariable.AsDouble

    When the DataType is set to dtDouble, you can store and retrieve a double
    value using this property.}

  {@TppVariable.AsExtended

    When the DataType is set to dtExtended, you can store and retrieve a
    extended value using this property.}

  {@TppVariable.AsInteger

    When the DataType is set to dtInteger, you can store and retrieve a integer
    value using this property.}

  {@TppVariable.AsSingle

    When the DataType is set to dtSingle, you can store and retrieve a single
    value using this property.}

  {@TppVariable.AsString

    When the DataType is set to dtString, you can store and retrieve a string
    value using this property.}

  {@TppVariable.AsTime

    When the DataType is set to dtTime, you can store and retrieve a time value
    using this property.}
    
  {@TppVariable.BlankWhenZero

    When the Variable value is equal to zero, the BlankWhenZero property
    allows you to print a blank instead of a 0.  Applicable only when the
    Variable.DataType is a numeric type.

    Defaults to False.

    From the Report Designer you can access the BlankWhenZero property by
    positioning the mouse cursor over the component and clicking the right
    mouse button.  A speed menu containing the key properties for the
    component will be displayed.  If it is checked, BlankWhenZero is on.
    Selecting the BlankWhenZero option from this menu will toggle its value.}

  {@TppVariable.CalcComponent

    Used to specify the group or data pipeline which will notify the variable
    when it is time to calculate the value. The CalcComponent property is valid
    only when the CalcType has been set to one of the following types:

    <Table>
    Value	                      Meaning
    -----------------------     -------
    veDataPipelineTraversal	    Value is calculated each time the specified data
                                pipeline traverses a record.
    veGroupBeforeHeader	        Value is calculated each time the group header
                                of the specified group is about to print.
    veGroupBeforeHeader	        Value is calculated before the group header is
                                printed.  Use this setting when you want to
                                calculate the value every time the group
                                header prints.  This setting will cause the
                                OnCalc event to fire when a group header is
                                printing on subsequent pages - which usually
                                means it is not appropriate for counting,
                                summing, etc.  If you need to correlate the
                                OnCalc with a group break, use veGroupEnd.
    veGroupBeforeFooter	        Value is calculated each time the group footer
                                of the specified group is about to print.
    veGroupStart	              Value is calculated before a group break occurs.
    veGroupEnd	                Value is calculated after a group break occurs.
    </Table>}

  {@TppVariable.CalcOrder

    Determines the order in which the variable will be calculated, relative to
    the other variables in the same band.}

  {@TppVariable.CalcType

    Determines the when the value of the Variable component is calculated.
    Defaults to veTraversal.

    <Table>
    Value	                      Meaning
    -----------------------     -------
    veTraversal	                Value is calculated each time the report engine
                                traverses a record.
    veDataPipelineTraversal*	  Value is calculated each time a data pipeline
                                traverses a record.
    vePageStart	                Value is calculated at the beginning of each
                                page.
    vePageEnd	                  Value is calculated at the end of each page.
    veColumnStart	              Value is calculated at the beginning of each
                                column.
    veColumnEnd	                Value is calculated at the end of each column.
    veReportStart	              Value is calculated at the beginning of the
                                report generation process.
    veReportEnd	                Value is calculated at the end of the report
                                generation process.
    veGroupBeforeHeader*	      Value is calculated before the group header is
                                printed.  Use this setting when you want to
                                calculate the value every time the group
                                header prints.  This setting will cause OnCalc
                                to fire when a group header is printing on
                                subsequent pages - which usually means it is
                                not appropriate for counting, summing, etc.
                                If you need to correlate the OnCalc with a group
                                break, use veGroupEnd.
    veGroupBeforeFooter*	      Value is calculated before the group footer is
                                printed.
    veGroupStart*	              Value is calculated at the beginning of each
                                group.*
    veGroupEnd*	                Value is calculated at the end of each group.*
    </Table>

    *When using this setting the CalcComponent must also be specified.}

  {@TppVariable.DataType

    Determines the native data type of the variable. Defaults to dtString.

    <Table>
    Value	        Meaning
    ---------     --------
    dtBoolean     Data is a boolean value
    dtChar        Data is a char value
    dtCurrency    Data is a currency value
    dtDate        Data is a date value
    dtDateTime    Data is a datetime value
    dtDouble      Data is a double value
    dtExtended    Data is an extended value
    dtInteger	    Data is an integer value
    dtSingle	    Data is a single value
    dtString      Data is a string value
    dtTime        Data is a time value
    </Table>

    The following types are used by DataPipeline classes, but are not supported
    by TppVariable:

    dtBLOB
    dtGraphic
    dtNotKnown
    dtMemo
    dtLongint
    dtVariant	You can use a TppVariable as a variant by using the Value
              property.}

  {@TppVariable.DisplayFormat

    The DisplayFormat property is used to control how data is formatted for a
    report.  For example, '#,0' would display 10000 as 10,000.  If the datafield
    is a date or time type, then you can use the standard formatting characters
    for those types ('mm/dd/yyyy', 'hh:nn:ss')

    DisplayFormat differs from the Delphi implementation in the case of string
    types.  In order to format strings simply type a valid EditMask into the
    DisplayFormat property. ReportBuilder will then apply the EditMask to the
    string value.

    From the Report Designer you can access the DisplayFormat property by
    positioning the mouse cursor over the component and clicking the right mouse
    button.  A speed menu containing the key properties for the component will
    be displayed.  Select DisplayFormat... from this menu.  The DisplayFormat
    dialog will be displayed (Note: if your DataSource is currently active,
    ReportBuilder will detect the underlying field type and provide a list of
    the more common formats for that type.)}

  {@TppVariable.LookAhead

    LookAhead is designed to allow you to display summary calculations in the
    title band, page footer calculations in the page header band, group footer
    calculations in the group header band and column footer calculations in the
    column header.

    When the LookAhead property is set to True, the draw command which
    represents the component on the rendered page will continue to update with
    the most recent calculation value until the report completes the generation
    of the associated page, group or column. When creating a lookahead variable,
    right-click over the Variable in the Report Designer,  select the
    Timing... menu option and set the OnReset option as follows:

    <Table>
    Band                OnReset Setting
    --------------      -------------
    Title               veReportEnd
    Header              vePageStart
    Column Header       veColumnStart
    Group Header        veGroupEnd (and select the appropriate group from the
                        drop-down list.)
    </Table>

    Note: The Report.PassSetting property must be set to psTwoPass, in order for
    LookAhead calculations to function reliably.}

  {@TppVariable.OldOnCalc

    This event is retained for backward compatibility.  Any event handlers
    assigned to this event will still function, but should be moved to the
    OnCalc event of the Variable.}

  {@TppVariable.OnCalc

    Use the OnCalc event handler when you want to perform calculations. The
    OnCalc event fires when the calculation for the component needs to be
    performed. By default this this event occurs once for each record traversal
    completed by the report engine.  You can control exactly when the component
    is calculated and reset using the CalcType and ResetType properties
    respectively.

    The currrent value of the variable is passed in the Value parameter.  You
    can then set the value of the variable by setting this property or by
    setting any of the 'As' properties of the variable directly.  If you choose
    to set the Value parameter, make sure the datatype of your assignment
    matches the DataType of the variable.  For instance, if you have the
    DataType set to dtString, then the following code would raise an exception:

    Value := Value + 1;

    This event handler would require the Variable.DataType to be set to a
    numeric type.}

  {@TppVariable.OnReset

    Use the OnReset event handler when you want to control the initial value of
    the variable before calculations begin. The OnReset event fires after the
    value of the variable has been cleared. You can set the initial value by
    modifying the Value parameter.  The following code would initialize the
    variable to a value of 1:

    Value := 1;

    This event handler would require the Variable.DataType to be set to a
    numeric type.  If the Variable.DataType was not set to numeric type an
    exception would be raised.}

  {@TppDBText.ReprintOnSubsequent

    The ReprintOnSubsequent property is used in conjunction with the
    SuppressRepeatedValues property.  When SuppressRepeatedValues is set to
    True, and detail lines have overflowed onto a new page, you can force
    the value to reprint on the first detail line of the new page by setting
    ReprintOnSubsequent to True

    Defaults to False.}

  {@TppVariable.ResetComponent

    Used to specify the group or data pipeline which will notify the variable
    when it is time to reset the value. The ResetComponent property is valid
    only when the ResetType has been set to one of the following types:

    <Table>
    Value	                      Meaning
    -----------------------     ------------------------
    veDataPipelineTraversal     Value is reset each time the specified data
                                pipeline traverses a record.
    veGroupBeforeHeader         Value is calculated before the group header is
                                printed.  Use this setting when you want to
                                calculate the value every time the group
                                header prints.  This setting will cause the
                                OnReset event to fire when a group header is
                                printing on subsequent pages - which usually
                                means it is not appropriate for counting,
                                summing, etc.  If you need to correlate the
                                OnCalc with a group break, use veGroupEnd.
    veGroupBeforeFooter	        Value is reset each time the group footer of the
                                specified group is about to print.
    veGroupStart	              Value is reset before a group break occurs.
    veGroupEnd	                Value is reset after a group break occurs.
    </Table>}

  {@TppVariable.ResetType

    Determines the when the value of the Variable component is reset. Defaults
    to veReportEnd.

    <Table>
    Value	                      Meaning
    -----------------------     -------
    veTraversal	                Value is reset each time the report engine
                                traverses a record.
    veDataPipelineTraversal*	  Value is reset each time a data pipeline
                                traverses a record.
    vePageStart	                Value is reset at the beginning of each page.
    vePageEnd	                  Value is reset at the end of each page.
    veColumnStart	              Value is reset at the end of each column.
    veReportStart	              Value is reset at the beginning of the report
                                generation process.
    veReportEnd	                Value is reset at the end of the report
                                generation process.
    veGroupBeforeHeader*	      Value is calculated before the group header is
                                printed.  Use this setting when you want to
                                calculate the value every time the group
                                header prints.  This setting will cause the
                                OnReset event to fire when a group header is
                                printing on subsequent pages - which usually
                                means it is not appropriate for counting,
                                summing, etc.  If you need to correlate the
                                OnReset with a group break, use veGroupEnd.
    veGroupBeforeFooter*	      Value is reset before the group footer band
                                generates.
    veGroupStart*	              Value is reset at the beginning of each group.
    veGroupEnd*	                Value is reset at the end of each group.
    </Table>

    *When using this setting the ResetComponent must also be specified}

  {@TppVariable.SuppressRepeatedValues

    Defaults to False. When the value of a variable is the same across several
    records, the SuppressRepeatedValues property allows you to print the value
    only once each time the value changes. This can be useful in reports where a
    highly redundant value has been included in the detail band.  If the detail
    band overflows onto a new page or column, you can force the suppressed
    value to print again by using the ReprintOnSubsequent property.}

  {@TppVariable.Value

    Use this property to get the value of a Variable component as a variant, or
    to set the value of the Variable without regard to type. Value is simply a
    pass-thru conversion property. The true data type of the variable is always
    indicated by the DataType property.}

  TppVariable = class(TppCustomVariable)
    private
      FBoolean: Boolean;
      FCalcOrder: TTabOrder;
      FCalcComponent: TppCommunicator;
      FCalcDataPipelineName: String;
      FCalcType: TppVarEventType;
      FCalcEventType: Integer;
      FChar: Char;
      FCurrency: Currency;
      FDataType: TppDataType;
      FDateTime: TDateTime;
      FDouble: Double;
      FExtended: Extended;
      FJustSaved: Boolean;
      FLookAhead: Boolean;
      FLookAheadList: TppLookAheadList;
      FInteger: Longint;
      FOldOnCalc: TNotifyEvent;
      FOnCalc: TppVarCalcEvent;
      FOnReset: TppVarCalcEvent;
      FResetComponent: TppCommunicator;
      FResetDataPipelineName: String;
      FResetType: TppVarEventType;
      FResetEventType: Integer;
      FRestored: Boolean;
      FSingle: Single;
      FString: String;
      FBlankWhenZero: Boolean;
      FCurrentSaveRec: TppVariableSaveRec;
      FPriorSaveRec: TppVariableSaveRec;
      FCacheableSaveRec: TppVariableSaveRec;

      function  CanCalcLookAheads: Boolean;
      procedure ClearRestored;
      procedure DoOnCalc;
      procedure DoOnReset;
      function  GetCalcOrder: TTabOrder;
      function  GetCalcComponent: TppCommunicator;
      function  GetReportKey: String;
      function  GetResetComponent: TppCommunicator;
      procedure InitLookAhead;
      procedure SetCalcComponent(aCommunicator: TppCommunicator);
      procedure SetCalcOrder(aCalcOrder: TTabOrder);
      procedure SetCalcType(aVarEventType: TppVarEventType);
      procedure SetDataType(aDataType: TppDataType);
      procedure SetEventNotifies;
      procedure SetResetComponent(aCommunicator: TppCommunicator);
      procedure SetResetType(aVarEventType: TppVarEventType);
      function IsStoredCalcComponent: Boolean;
      function IsStoredResetComponent: Boolean;

      procedure SetBlankWhenZero(const Value: Boolean);
      procedure SetBoolean(Value: Boolean);
      procedure SetChar(Value: Char);
      procedure SetCurrency(Value: Currency);
      procedure SetDateTime(Value: TDateTime);
      procedure SetDouble(Value: Double);
      procedure SetExtended(Value: Extended);
      procedure SetInteger(Value: Longint);
      procedure SetSingle(Value: Single);
      procedure SetString(Value: String);
      function  ValidNotify(aSource, aTarget: TppCommunicator; aSourceEvent, aTargetEvent: Integer): Boolean;

      function  GetVariant: Variant;
      procedure SetVariant(Value: Variant);
      function  GetCustomValue: Variant;

      procedure SetLookAhead(aValue: Boolean);
      function  GetLookAheadKey: String;
      function  GetIDNo1: Integer;
      function  GetIDNo2: Integer;
      function  GetTraversalCount: Integer;

      procedure ReadCalcDataPipelineName(Reader: TReader);
      procedure ReadResetDataPipelineName(Reader: TReader);

      procedure WriteCalcDataPipelineName(Writer: TWriter);
      procedure WriteResetDataPipelineName(Writer: TWriter);

    protected
      procedure DefineProperties(Filer: TFiler); override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;

      function  GetDataType: TppDataType; override;
      function  GetDefaultPropHint: String; override;
      function  GetDescription: String; override;
      function  GetTheText: String; override;
      procedure SetDisplayFormat(const aFormat: String); override;
      procedure SetUserName(const aUserName: TComponentName); override;
      procedure RestorePriorValue; virtual;
      procedure ValuesToSaveRec(var aSaveRec: TppVariableSaveRec); virtual;
      procedure ValuesFromSaveRec(aSaveRec: TppVariableSaveRec); virtual;

     public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      function  EventOrder: String; override;

      procedure Clear; override;
      procedure Compute; override;
      procedure EndOfMainReport; override;
      procedure GetDefaultPropEnumNames(aList: TStrings); override;
      function  GetTheCalcOrder: TTabOrder;
      procedure Init; override;
      procedure PageStart; override;
      procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      procedure SetText(Value: String); override;
      procedure StartOfMainReport; override;
      procedure UpdateCalcOrder(aCalcOrder: TTabOrder);

      property Alignment;
      property AsBoolean: Boolean read FBoolean write SetBoolean;
      property AsChar: Char read FChar write SetChar;
      property AsCurrency: Currency read FCurrency write SetCurrency;
      property AsDateTime: TDateTime read FDateTime write SetDateTime;
      property AsDate: TDateTime read FDateTime write SetDateTime;
      property AsDouble: Double read FDouble write SetDouble;
      property AsExtended: Extended read FExtended write SetExtended;
      property AsInteger: Longint read FInteger write SetInteger;
      property AsSingle: Single read FSingle write SetSingle;
      property AsString: String read FString write SetString;
      property AsTime: TDateTime read FDateTime write SetDateTime;

      {retained for backward compatibility}
      property AsFloat: Double read FDouble write SetDouble;
      property Value: Variant read GetVariant write SetVariant;

    published
      property Anchors;
      property AutoSize;
      property Border;
      property BlankWhenZero: Boolean read FBlankWhenZero write SetBlankWhenZero;
      property CalcOrder: TTabOrder read GetCalcOrder write SetCalcOrder default -1;
      property CalcComponent: TppCommunicator read GetCalcComponent  write SetCalcComponent stored IsStoredCalcComponent;
      property CalcType: TppVarEventType read FCalcType write SetCalcType default veTraversal;
      property Color;
      property DataType: TppDataType read FDataType write SetDataType default dtString;
      property DisplayFormat;
      property Ellipsis;
      property Font;
      property Height stored False;
      property Left stored False;
      property LookAhead: Boolean read FLookAhead write SetLookAhead default False;
      property OldOnCalc: TNotifyEvent read FOldOnCalc write FOldOnCalc;
      property OnCalc: TppVarCalcEvent read FOnCalc write FOnCalc;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property OnFormat;
      property OnReset: TppVarCalcEvent read FOnReset write FOnReset;
      property ResetComponent: TppCommunicator read GetResetComponent  write SetResetComponent stored IsStoredResetComponent;
      property ResetType: TppVarEventType read FResetType write SetResetType default veReportEnd;
      property SuppressRepeatedValues;
      property ReprintOnSubsequent;
      property TextAlignment;
      property Top stored False;
      property Transparent;
      property UserName;
      property Visible;
      property Width stored False;
      property WordWrap;

  end; {class, TppVariable}

  {@TppSystemVariable

    The TppSystemVariable component is used to print common report information.
    The VarType property designates the value which will be displayed.  You can
    control the appearance of this value with the DisplayFormat property.

    <Table>
    VarType          Meaning
    ---------------  ---------
    vtDate           Current system date
    vtDateTime	     Current system date and time
    vtDocumentName   Name of the document, as given in the
                     PrinterSetup.DocumentName property
    vtPrintDateTime  Date and time the report was printed (prints same date
                     and time on every page)
    vtPageCount	     Total number pages in the group or report*
    vtPageSet	       Current page number and total pages in group or report
                     ('1 of 5')*
    vtPageSetDesc    Textual summary of page number and pagecount
                     ('Page 1 of 5')*
    vtPageNo	       Current page number
    vtPageDesc	     Textual summary of current page number ('Page 1')
    vtTime	         System time
    vtCopyNo         Current copy number (when printing mulitple copies to the
                     printer).  Note: This text will not print with the original
                     document.  The component will print with the first and
                     subsequent copies of the report.
    vtCopyNoDesc     Textual summary of the current copy number ('Copy 1').
                     Note: This text will not print with the original
                     document.  The component will print with the first and
                     subsequent copies of the report.
    vtSearchDesc     Textual description of the search conditions definied with
                     report autosearch fields.
    </Table>


    You can control the appearance of this component (Font, Alignment, etc.) at
    design-time by using the Format Bar of the Report Designer. You can also set
    key properties by using the speed menu.  To access the speed menu, position
    the mouse cursor over the component and click the right mouse button.}

  {@TppSystemVariable.DisplayFormat

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
    dialog will be displayed. (Note: if your DataSource is currently active,
    ReportBuilder will detect the underlying field type and provide a list of
    the more common formats for that type.)}

  {@TppSystemVariable.VarType

    The VarType property determines what type of report information is printed
    in the report. From the Report Designer, use the drop-down combo-box on the
    far left of the Edit Bar to set this property.

    <Table>
    Value	           Meaning
    ---------------  ---------
    vtDate           Current system date
    vtDateTime	     Current system date and time
    vtDocumentName   Name of the document, as given in the
                     PrinterSetup.DocumentName property
    vtPrintDateTime  Date and time the report was printed (prints same date
                     and time on every page)
    vtPageCount	     Total number pages in the group or report*
    vtPageSet	       Current page number and total pages in group or report
                     ('1 of 5')*
    vtPageSetDesc    Textual summary of page number and pagecount
                     ('Page 1 of 5')*
    vtPageNo	       Current page number
    vtPageDesc	     Textual summary of current page number ('Page 1')
    vtTime	         System time
    vtCopyNo         Current copy number (when printing mulitple copies to the
                     printer).  Note: This text will not print with the original
                     document.  The component will print with the first and
                     subsequent copies of the report.
    vtCopyNoDesc     Textual summary of the current copy number ('Copy 1').
                     Note: This text will not print with the original
                     document.  The component will print with the first and
                     subsequent copies of the report.
    vtSearchDesc     Textual description of the search conditions definied with
                     report autosearch fields.
    </Table>

    Note: Most reports which display page counts should have the
          Report.PassSetting property set to psTwoPass.  This guarantees an
          accurate page count when the report is being previewed.}

  TppSystemVariable = class(TppCustomVariable)
    private
      FVarType: TppVarType;

      procedure SetVarType(aVarType: TppVarType);

      function  GetStandardValue: Variant;

    protected
      function  GetDataType: TppDataType; override;
      function  GetDefaultPropHint: String; override;
      function  GetDescription: String; override;
      function  GetTheText: String; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetDisplayFormat(const aFormat: String); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure GetDefaultPropEnumNames(aList: TStrings); override;

      property Alignment;
      property DataType: TppDataType read GetDataType;

    published
      property Anchors;
      property AutoSize;
      property Border;
      property VarType: TppVarType read FVarType write SetVarType default vtDate;
      property Color;
      property DisplayFormat;
      property Font;
      property Height stored False;
      property Left stored False;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
      property TextAlignment;
      property Top stored False;
      property Transparent;
      property UserName;
      property Visible;
      property Width stored False;
      property WordWrap;

  end; {class, TppSystemVariable}

    {TppCalc

    This component discontinued as version 4.0}

  TppCalc = class(TppCustomText)
    private
      FCalcType: TppCalcType;
      FCustomType: TppDataType;
      FOnCalc: TNotifyEvent;

      {used to hold values for 'As' properties}
      FBoolean: Boolean;
      FDateTime: TDateTime;
      FInteger: Longint;
      FDouble: Double;
      FString: String;

      function  GetCustomValue: Variant;
      function  GetStandardValue: Variant;

      procedure SetCustomType(aDataType: TppDataType);
      procedure SetBoolean(Value: Boolean);
      procedure SetDateTime(Value: TDateTime);
      procedure SetDouble(Value: Double);
      procedure SetInteger(Value: Longint);
      procedure SetString(Value: String);

    protected
      {used for conversion to 3.0}
      procedure ReadDataType(Reader: TReader);
      procedure DefineProperties(Filer: TFiler); override;

      function  GetDefaultPropHint: String; override;
      function  GetDescription: String; override;
      function  GetTheText: String; override;
      procedure PropertiesToDrawCommand(aDrawCommand: TppDrawCommand); override;
      procedure SetCalcType(aCalcType: TppCalcType); virtual;
      procedure SetDisplayFormat(const aFormat: String); override;
      procedure SetTheDataType;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Clear; override;
      procedure Compute; override;
      procedure GetDefaultPropEnumNames(aList: TStrings); override;
      function  IsCalc: Boolean; override;
      procedure RestoreFromCache(aCachePageNo: Longint); override;
      procedure SaveToCache(aCachePageNo: Longint); override;
      procedure SetText(Value: String); override;

      {used for conversion to 3.0}
      procedure Convert(aVersionNo: Integer); override;

      property AsBoolean: Boolean read FBoolean write SetBoolean;
      property AsDateTime: TDateTime read FDateTime write SetDateTime;
      property AsDate: TDateTime read FDateTime write SetDateTime;
      property AsTime: TDateTime read FDateTime write SetDateTime;
      property AsFloat: Double read FDouble write SetDouble;
      property AsInteger: Longint read FInteger write SetInteger;
      property AsString: String read FString write SetString;

    published
      property Alignment;
      property AutoSize;
      property CalcType: TppCalcType read FCalcType write SetCalcType default ctDate;
      property Color;
      property CustomType: TppDataType read FCustomType write SetCustomType;
      property DisplayFormat;
      property Font;
      property OnCalc: TNotifyEvent read FOnCalc write FOnCalc;
      property OnDrawCommandClick;
      property OnDrawCommandCreate;
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

  end; {class TppCalc}

{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppVariableRTTI }
  TraTppVariableRTTI = class(TraTppCustomTextRTTI)
    public
      class procedure GetEventList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
  end; {class, TraTppVariableRTTI}

  {@TraTppSystemVariableRTTI }
  TraTppSystemVariableRTTI = class(TraTppCustomTextRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppSystemVariableRTTI}

implementation

uses
  ppBands, ppPlainText, ppReport;

const
  cValidDataTypes = [dtBoolean, dtDate, dtTime, dtDateTime, dtInteger,
                     dtSingle, dtDouble, dtExtended, dtCurrency, dtChar, dtString];


{******************************************************************************
 *
 ** C U S T O M   V A R I A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCustomVariable.PropertiesToDrawCommand }

procedure TppCustomVariable.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  {transfer properties to draw command}
  aDrawCommand.DataType := GetDataType;

end; {procedure, PropertiesToDrawCommand}


{******************************************************************************
 *
 ** V A R I A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppVariable.Create }

constructor TppVariable.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppVariableSaveRec);
  DefaultPropName := 'DataType';
  DefaultPropEditType := etValueList;
  DrawCommandClass := TppDrawVariable;

  FCalcOrder := -1;
  FCalcComponent := nil;
  FCalcDataPipelineName := '';
  FCalcEventType := ciTraversal;
  FCalcType := veTraversal;
  FDataType := dtString;
  FJustSaved := False;
  FLookAhead := False;
  FLookAheadList := nil;
  FResetComponent := nil;
  FResetDataPipelineName := '';
  FResetEventType := ciEngineEnd;
  FResetType := veReportEnd;
  FOnCalc := nil;
  FOldOnCalc := nil;


end; {function, Create}

{------------------------------------------------------------------------------}
{ TppVariable.Destroy }

destructor TppVariable.Destroy;
begin

  FLookAheadList.Free;

  inherited Destroy;

end; {function, Destroy}

{------------------------------------------------------------------------------}
{ TppVariable.DefineProperties - read/write private 'fake' properties }

procedure TppVariable.DefineProperties(Filer: TFiler);
var
  lAncestor: TppVariable;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppVariable) then
    lAncestor := TppVariable(Filer.Ancestor)
  else
    lAncestor := nil;

  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('CalcDataPipelineName', ReadCalcDataPipelineName, WriteCalcDataPipelineName,
                            (FCalcType = veDataPipelineTraversal) and (FCalcComponent <> lAncestor.FCalcComponent));

      Filer.DefineProperty('ResetDataPipelineName', ReadResetDataPipelineName, WriteResetDataPipelineName,
                            (FResetType = veDataPipelineTraversal) and (FResetComponent <> lAncestor.FResetComponent));
    end
  else
    begin
      Filer.DefineProperty('CalcDataPipelineName', ReadCalcDataPipelineName, WriteCalcDataPipelineName,
                            (FCalcType = veDataPipelineTraversal) and (FCalcComponent <> nil));

      Filer.DefineProperty('ResetDataPipelineName', ReadResetDataPipelineName, WriteResetDataPipelineName,
                            (FResetType = veDataPipelineTraversal) and (FResetComponent <> nil));

    end;

end; {procedure, DefineProperties}

{------------------------------------------------------------------------------}
{ TppVariable.ReadCalcDataPipelineName }

procedure TppVariable.ReadCalcDataPipelineName(Reader: TReader);
begin
  FCalcDataPipelineName := Reader.ReadString;

end; {procedure, ReadDataPipelineName}

{------------------------------------------------------------------------------}
{ TppVariable.ReadResetDataPipelineName }

procedure TppVariable.ReadResetDataPipelineName(Reader: TReader);
begin
  FResetDataPipelineName := Reader.ReadString;
  
end; {procedure, ReadDataPipelineName}

{------------------------------------------------------------------------------}
{ TppVariable.WriteCalcDataPipelineName }

procedure TppVariable.WriteCalcDataPipelineName(Writer: TWriter);
begin
  Writer.WriteString(FCalcComponent.Name);

end; {procedure, WriteCalcDataPipelineName}

{------------------------------------------------------------------------------}
{ TppVariable.WriteResetDataPipelineName }

procedure TppVariable.WriteResetDataPipelineName(Writer: TWriter);
begin
  Writer.WriteString(FResetComponent.Name);

end; {procedure, WriteResetDataPipelineName}

{------------------------------------------------------------------------------}
{ TppVariable.ResolvePipelineReferences }

procedure TppVariable.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  lDataPipeline: TppDataPipeline;
begin

  if (FCalcComponent = nil) and (FCalcDataPipelineName <> '') then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FCalcDataPipelineName);
      if lDataPipeline <> nil then
        SetCalcComponent(lDataPipeline);
    end;

  if (FResetComponent = nil) and (FResetDataPipelineName <> '') then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FResetDataPipelineName);
      if lDataPipeline <> nil then
        SetResetComponent(lDataPipeline);
    end;

end;  {procedure, ResolvePipelineReferences}

{------------------------------------------------------------------------------}
{ TppVariable.Notify}

procedure TppVariable.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FCalcComponent) then
    FCalcComponent := nil
    
  else if(aCommunicator = FResetComponent) then
    FResetComponent := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppVariable.EventOrder }

function TppVariable.EventOrder: String;
begin
  Result := Band.Rank + Format('%8d',[GetCalcOrder]);
end; {function, EventOrder}

{------------------------------------------------------------------------------}
{ TppVariable.EventNotify }

procedure TppVariable.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if ValidNotify(aCommunicator, FResetComponent, aEventID, FResetEventType) then
    Clear;

  if ValidNotify(aCommunicator, FCalcComponent, aEventID, FCalcEventType) then
    Compute;

  if (aCommunicator = Band.Report.Engine) and (aEventID = ciDetailOutOfSpace) and
          (FCalcType = veTraversal) then
    begin
      RestorePriorValue;  // dynamic detail band could not print
      FRestored := True;
    end;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TppVariable.ValidNotify }

function TppVariable.ValidNotify(aSource, aTarget: TppCommunicator; aSourceEvent, aTargetEvent: Integer): Boolean;
begin
  Result := (aSource = aTarget) and (aSourceEvent = aTargetEvent);
end; {procedure, ValidNotify}

{------------------------------------------------------------------------------}
{ TppVariable.PropertiesToDrawCommand }

procedure TppVariable.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawVariable: TppDrawVariable;
  lsLookAheadKey: String;
  lMainReport: TppCustomReport;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  lDrawVariable := TppDrawVariable(aDrawCommand);

  lDrawVariable.Value := GetCustomValue;


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
{ TppVariable.IsStoredCalcComponent }

function TppVariable.IsStoredCalcComponent: Boolean;
begin
  Result := not(FCalcComponent is TppDataPipeline);
end;

{------------------------------------------------------------------------------}
{ TppVariable.IsStoredResetComponent }

function TppVariable.IsStoredResetComponent: Boolean;
begin
  Result := not(FResetComponent is TppDataPipeline);
end;

{------------------------------------------------------------------------------}
{ TppVariable.Init }

procedure TppVariable.Init;
begin

  inherited Init;

  SetEventNotifies;

  if not(CalcType in [veDataPipelineTraversal, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    begin
    
      if (CalcType in [veTraversal, veReportStart, veReportEnd]) then
        SetCalcComponent(Band.Report.Engine)

      else
        SetCalcComponent(Band.Report);

    end;

  if not(ResetType in [veDataPipelineTraversal, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    begin

      if (ResetType in [veTraversal, veReportStart, veReportEnd]) then
        SetResetComponent(Band.Report.Engine)

      else
        SetResetComponent(Band.Report);

    end;


  Clear;

  ValuesToSaveRec(FCacheableSaveRec);
  ValuesToSaveRec(FPriorSaveRec);

end; {procedure, Init}

{------------------------------------------------------------------------------}
{ TppVariable.SetCalcType }

procedure TppVariable.SetCalcType(aVarEventType: TppVarEventType);
begin

  FCalcType := aVarEventType;

  SetEventNotifies;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetCalcType}

{------------------------------------------------------------------------------}
{ TppVariable.SetResetType }

procedure TppVariable.SetResetType(aVarEventType: TppVarEventType);
begin

  FResetType := aVarEventType;

  SetEventNotifies;

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetResetType}

{------------------------------------------------------------------------------}
{ TppVariable.SetEventNotifies }

procedure TppVariable.SetEventNotifies;
var
  lEventNotifies: TppEvents;
begin

  FResetEventType := ppVarEventToEvent(FResetType);

  FCalcEventType := ppVarEventToEvent(FCalcType);

  lEventNotifies := [];
                                                       
  Include(lEventNotifies, FCalcEventType);
  
  Include(lEventNotifies, FResetEventType);

  EventNotifies := EventNotifies + lEventNotifies;

  EventNotifies := EventNotifies + [ciPageBackward];

  if (Band is TppFooterBand) and (FCalcType = veTraversal) then
    EventNotifies := EventNotifies + [ciDetailOutOfSpace]
  else
    EventNotifies := EventNotifies - [ciDetailOutOfSpace];

end; {procedure, SetEventNotifies}

{------------------------------------------------------------------------------}
{ TppVariable.GetCalcComponent }

function TppVariable.GetCalcComponent: TppCommunicator;
begin
  if (csWriting in ComponentState) and not(CalcType in [veDataPipelineTraversal, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    Result := nil
  else
    Result := FCalcComponent;
end; {procedure, GetCalcComponent}

{------------------------------------------------------------------------------}
{ TppVariable.GetResetComponent }

function TppVariable.GetResetComponent: TppCommunicator;
begin
  if (csWriting in ComponentState) and not(ResetType in [veDataPipelineTraversal, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter]) then
    Result := nil
  else
    Result := FResetComponent;
end; {procedure, GetResetComponent}

{------------------------------------------------------------------------------}
{ TppVariable.SetCalcComponent }

procedure TppVariable.SetCalcComponent(aCommunicator: TppCommunicator);
begin

  if (FCalcComponent <> nil) then
    FCalcComponent.RemoveEventNotify(Self);

  FCalcComponent := aCommunicator;

  if (FCalcComponent <> nil) then
    FCalcComponent.AddEventNotify(Self);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetCalcComponent}

{------------------------------------------------------------------------------}
{ TppVariable.SetResetComponent }

procedure TppVariable.SetResetComponent(aCommunicator: TppCommunicator);
begin

  if (FResetComponent <> nil) then
    FResetComponent.RemoveEventNotify(Self);

  FResetComponent := aCommunicator;

  if (FResetComponent <> nil) then
    FResetComponent.AddEventNotify(Self);

  {notify report designer}
  PropertyChange;

  {notify report engine}
  Reset;

end; {procedure, SetResetComponent}

{------------------------------------------------------------------------------}
{ TppVariable.GetTheCalcOrder }

function TppVariable.GetTheCalcOrder: TTabOrder;
begin
  Result := FCalcOrder;
end; {function, GetTheCalcOrder}

{------------------------------------------------------------------------------}
{ TppVariable.GetCalcOrder }

function TppVariable.GetCalcOrder: TTabOrder;
begin
  if (Band <> nil) then
    Result := Band.IndexOfVariable(Self)
  else
    Result := -1;
end; {function, GetCalcOrder}

{------------------------------------------------------------------------------}
{ TppVariable.SetCalcOrder }

procedure TppVariable.SetCalcOrder(aCalcOrder: TTabOrder);
begin

  if csReading in ComponentState then
    FCalcOrder := aCalcOrder
  else
    begin
      UpdateCalcOrder(aCalcOrder);

      PropertyChange;

      Reset;
    end;

end; {function, SetCalcOrder}

{------------------------------------------------------------------------------}
{ TppVariable.UpdateCalcOrder }

procedure TppVariable.UpdateCalcOrder(aCalcOrder: TTabOrder);
var
  liVarIndex: Integer;
  liVarCount: Integer;
begin

  liVarIndex := GetCalcOrder;
  liVarCount := Band.VariableCount;

  {doctor value until it is valid}
  if aCalcOrder < 0 then
    aCalcOrder := 0;

  if (liVarCount > 0) and (aCalcOrder >= liVarCount) then
    aCalcOrder := liVarCount - 1;

  if (aCalcOrder <> liVarIndex) then
    begin
      {remove from old position}
      if (liVarIndex >= 0) then
        Band.RemoveVariable(Self);

      {insert into new position}
      Band.InsertVariable(aCalcOrder, Self);
    end;

end; {procedure, UpdateCalcOrder}

{------------------------------------------------------------------------------}
{ TppVariable.GetDataType }

function TppVariable.GetDataType: TppDataType;
begin
  Result := FDataType;
end; {function, GetDataType}

{------------------------------------------------------------------------------}
{ TppVariable.SetDisplayFormat }

procedure TppVariable.SetDisplayFormat(const aFormat: String);
begin

  inherited SetDisplayFormat(aFormat);

  {set design time caption}
  if (pppcDesigning in DesignState) and not(Printing) then
    Caption := GetText;

end; {function, SetDisplayFormat}

{------------------------------------------------------------------------------}
{ TppVariable.SetText }

procedure TppVariable.SetText(Value: String);
begin
  SetString(Value);

  inherited SetText(Value);
end; {procedure, SetText}

{------------------------------------------------------------------------------}
{ TppVariable.GetDescription }

function TppVariable.GetDescription: String;
begin
  Result := UserName;
end; {function, GetDescription}

{------------------------------------------------------------------------------}
{ TppVariable.DoOnCalc }

procedure TppVariable.DoOnCalc;
var
  lValue: Variant;
  lOldValue: Variant;
  lParams: TraParamList;
begin

  lValue := Value;

  if Assigned(FOnCalc) then
    begin
      lOldValue := lValue;

      FOnCalc(Self, lValue);

      if (VarType(lValue) <> VarType(lOldValue)) or (lValue <> lOldValue ) then
        SetVariant(lValue);
    end

  else if Assigned(FOldOnCalc) then
    FOldOnCalc(Self);

  lValue := Value;
  lOldValue := lValue;

  lParams := TraTppVariableRTTI.GetParams('OnCalc');
  lParams.CreateValuePointer(0, lValue);

  SendEventNotify(Self, ciComponentCalc, lParams);

  lParams.Free;

  {update value with modified variant}
  if (VarType(lValue) <> VarType(lOldValue)) or (lValue <> lOldValue ) then
    SetVariant(lValue);

  {these events fire after the cache has been written, so we must update it}
  if FJustSaved and (FCalcType in [vePageEnd, veColumnEnd]) then
    begin
      FJustSaved := False;

      SaveToCache(GetMainReport.AbsolutePageNo);
    end;

  {update lookahead totals}
  if (FLookAheadList <> nil) and (GetMainReport.FirstPass) then
    FLookAheadList.UpdateTotal(GetLookAheadKey, GetTraversalCount, Text);

end; {procedure, DoOnCalc}

{------------------------------------------------------------------------------}
{ TppVariable.DoOnReset }

procedure TppVariable.DoOnReset;
var
  lValue: Variant;
  lOldValue: Variant;
  lParams: TraParamList;
begin

  lValue := Value;

  if Assigned(FOnReset) then
    begin
      lOldValue := lValue;

      FOnReset(Self, lValue);

      if (VarType(lValue) <> VarType(lOldValue)) or (lValue <> lOldValue ) then
        SetVariant(lValue);
    end;

  lValue := Value;
  lOldValue := lValue;

  lParams := TraTppVariableRTTI.GetParams('OnReset');
  lParams.CreateValuePointer(0, lValue);

  SendEventNotify(Self, ciComponentReset, lParams);

  lParams.Free;

  {update value with modified variant}
  if (VarType(lValue) <> VarType(lOldValue)) or (lValue <> lOldValue ) then
    SetVariant(lValue);

  {these events fire after the cache has been written, so we must update it}
  if (FJustSaved) and (FResetType in [vePageEnd, veColumnEnd]) then
    begin
      FJustSaved := False;

      SaveToCache(GetMainReport.AbsolutePageNo);
    end;

end; {procedure, DoOnReset}

{------------------------------------------------------------------------------}
{ TppVariable.Compute }

procedure TppVariable.Compute;
begin

  if not(Printing) then Exit;

  ValuesToSaveRec(FPriorSaveRec);

  DoOnCalc;

  ValuesToSaveRec(FCacheableSaveRec);

end; {procedure, Compute}


{------------------------------------------------------------------------------}
{ TppVariable.RestorePriorValue }

procedure TppVariable.RestorePriorValue;
begin

  ValuesToSaveRec(FCurrentSaveRec);
  ValuesFromSaveRec(FPriorSaveRec);

end;

{------------------------------------------------------------------------------}
{ TppVariable.Clear }

procedure TppVariable.Clear;
begin
  inherited Clear;

  if (FResetType = vePageEnd) and (FRestored) then
    ClearRestored
  else
    begin
      FBoolean := False;
      FChar := #0;
      FCurrency := 0;
      FDateTime := 0.0;
      FDouble := 0;
      FExtended := 0;
      FInteger := 0;
      FSingle := 0;
      FString := '';
    end;

  DoOnReset;

  ValuesToSaveRec(FCacheableSaveRec);

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppVariable.ClearRestored }

procedure TppVariable.ClearRestored;
begin

  FBoolean := False;
  FChar := #0;
  FCurrency := FCurrentSaveRec.FCurrency - FPriorSaveRec.FCurrency;
  FDateTime := 0.0;
  FDouble := FCurrentSaveRec.FDouble - FPriorSaveRec.FDouble;
  FExtended := FCurrentSaveRec.FExtended - FPriorSaveRec.FExtended;
  FInteger := FCurrentSaveRec.FInteger - FPriorSaveRec.FInteger;
  FSingle := FCurrentSaveRec.FSingle - FPriorSaveRec.FSingle;
  FString := '';

  FRestored := False;

end; {procedure, ClearRestored}

{------------------------------------------------------------------------------}
{ TppVariable.GetDefaultPropHint }

function TppVariable.GetDefaultPropHint: String;
begin
  Result := ppLoadStr(379); {data type}
end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TppVariable.GetDefaultPropEnumNames }

procedure TppVariable.GetDefaultPropEnumNames(aList: TStrings);
begin

  aList.Clear;

  aList.Add(ppLoadStr(363)); {boolean}
  aList.Add(ppLoadStr(303)); {date}
  aList.Add(ppLoadStr(311)); {time}
  aList.Add(ppLoadStr(304)); {datetime}
  aList.Add(ppLoadStr(334)); {integer}
  aList.Add(ppLoadStr(335)); {single}
  aList.Add(ppLoadStr(337)); {double}
  aList.Add(ppLoadStr(339)); {extended}
  aList.Add(ppLoadStr(341)); {currency}
  aList.Add(ppLoadStr(409)); {char}
  aList.Add(ppLoadStr(324)); {string}

end; {procedure, GetDefaultPropEnumNames}

{------------------------------------------------------------------------------}
{ TppVariable.SetLookAhead }

procedure TppVariable.SetLookAhead(aValue: Boolean);
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
{ TppVariable.CanCalcLookAheads }

function TppVariable.CanCalcLookAheads: Boolean;
var
  lMainReport: TppCustomReport;
begin

  lMainReport := GetMainReport;

  Result := (lMainReport <> nil) and (lMainReport.PassSetting = psTwoPass) and FLookAhead;

end; {procedure, CanCalcLookAheads}

{------------------------------------------------------------------------------}
{ TppVariable.StartOfMainReport }

procedure TppVariable.StartOfMainReport;
begin
  InitLookAhead;
end; {procedure, StartOfMainReport}

{------------------------------------------------------------------------------}
{ TppVariable.EndOfMainReport }

procedure TppVariable.EndOfMainReport;
begin
  if FLookAheadList <> nil then
    FLookAheadList.SignOffTotals;
end; {procedure, EndOfMainReport}

{------------------------------------------------------------------------------}
{ TppVariable.PageStart }

procedure TppVariable.PageStart;
begin

  inherited;

  if (DataType = dtString) then
    Compute;

end; {procedure, PageStart}

{------------------------------------------------------------------------------}
{ TppVariable.InitLookAhead }

procedure TppVariable.InitLookAhead;
var
  lReport: TppCustomReport;
begin

  if (FLookAheadList <> nil) then
    begin
      FLookAheadList.Free;

      FLookAheadList := nil;
    end;

  if not(CanCalcLookAheads) then Exit;

  FLookAheadList := TppLookAheadList.CreateList(Self);

  lReport := GetReport;

  if (lReport <> nil) and (lReport.Engine <> nil) then
    lReport.Engine.AddEventNotify(Self);

end; {procedure, InitLookAhead}

{------------------------------------------------------------------------------}
{ TppVariable.GetTraversalCount }

function TppVariable.GetTraversalCount: Integer;
begin

  if (FCalcComponent is TppDataPipeline) then
    Result := TppDataPipeline(FCalcComponent).TraversalCount

  else if (Band is TppDetailBand) and (TppDetailBand(Band).DataPipeline <> nil) then
    Result := TppDetailBand(Band).DataPipeline.TraversalCount

  else if (Band.Report.DataPipeline <> nil) then
    Result := Band.Report.DataPipeline.TraversalCount

  else
    Result := 0;

end; {function, GetTraversalCount}

{------------------------------------------------------------------------------}
{ TppVariable.GetReportKey }

function TppVariable.GetReportKey: String;
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
{ TppVariable.GetLookAheadKey }

function TppVariable.GetLookAheadKey: String;
begin
  Result := GetReportKey + Format('%8d', [GetIDNo1]) + '|' + Format('%8d', [GetIDNo2]);
end; {function, GetLookAheadKey}

{------------------------------------------------------------------------------}
{ TppVariable.GetIDNo1 }

function TppVariable.GetIDNo1: Integer;
begin

  Result := 0;

  case FResetType of

    vePageStart, vePageEnd, veColumnStart, veColumnEnd:
      Result := Band.Report.AbsolutePageNo;

    veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter:
      if (FResetComponent is TppGroup) then
        Result := TppGroup(FResetComponent).BreakNo;

    veDataPipelineTraversal:
      if (FResetComponent is TppDataPipeline) then
        Result := TppDataPipeline(FResetComponent).TraversalCount;

    veTraversal:
      Result := GetTraversalCount;

  end;

end; {function, GetIDNo1}

{------------------------------------------------------------------------------}
{ TppVariable.GetIDNo2 }

function TppVariable.GetIDNo2: Integer;
begin

  case FResetType of

    veColumnStart, veColumnEnd:
      Result := Band.Report.CurrentColumn;

    else
      Result := 0;

  end;

end; {function, GetIDNo2}

{------------------------------------------------------------------------------}
{ TppVariable.SetBlankWhenZero }

procedure TppVariable.SetBlankWhenZero(const Value: Boolean);
begin

  if  FBlankWhenZero <> Value then
    begin
      BeforePropertyChange('BlankWhenZero');
      FBlankWhenZero := Value;
      PropertyChange;
    end;

end;


{------------------------------------------------------------------------------}
{ TppVariable.SetDataType }

procedure TppVariable.SetDataType(aDataType: TppDataType);
begin
  if (FDataType <> aDataType) and (aDataType in cValidDataTypes) then
    begin
      BeforePropertyChange('DataType');
      FDataType := aDataType;

      PropertyChange;
      Reset;
    end;

end; {procedure, SetDataType}

{------------------------------------------------------------------------------}
{ TppVariable.SetBoolean }

procedure TppVariable.SetBoolean(Value: Boolean);
begin

  FBoolean := Value;

  FDataType := dtBoolean;

  PropertyChange;
  Reset;

end; {procedure, SetBoolean}

{------------------------------------------------------------------------------}
{ TppVariable.SetChar }

procedure TppVariable.SetChar(Value: Char);
begin
  FChar := Value;
  FDataType := dtChar;

  PropertyChange;
  Reset;

end; {procedure, SetChar}

{------------------------------------------------------------------------------}
{ TppVariable.SetCurrency }

procedure TppVariable.SetCurrency(Value: Currency);
begin
  FCurrency := Value;
  FDataType := dtCurrency;

  PropertyChange;
  Reset;
end; {procedure, SetCurrency}

{------------------------------------------------------------------------------}
{ TppVariable.SetDateTime }

procedure TppVariable.SetDateTime(Value: TDateTime);
begin
  FDateTime := Value;
  FDataType := dtDateTime;

  PropertyChange;
  Reset;
end; {procedure, SetDateTime}

{------------------------------------------------------------------------------}
{ TppVariable.SetDouble }

procedure TppVariable.SetDouble(Value: Double);
begin
  FDouble := Value;
  FDataType := dtDouble;

  PropertyChange;
  Reset;
end; {procedure, SetDouble}

{------------------------------------------------------------------------------}
{ TppVariable.SetExtended }

procedure TppVariable.SetExtended(Value: Extended);
begin
  FExtended := Value;
  FDataType := dtExtended;

  PropertyChange;
  Reset;
end; {procedure, SetExtended}

{------------------------------------------------------------------------------}
{ TppVariable.SetInteger }

procedure TppVariable.SetInteger(Value: Longint);
begin
  FInteger := Value;
  FDataType := dtInteger;

  if Printing then Exit;

  PropertyChange;

  Reset;
  
end; {procedure, SetInteger}

{------------------------------------------------------------------------------}
{ TppVariable.SetSingle }

procedure TppVariable.SetSingle(Value: Single);
begin
  FSingle := Value;
  FDataType := dtSingle;

  PropertyChange;
  Reset;
end; {procedure, SetSingle}

{------------------------------------------------------------------------------}
{ TppVariable.SetString }

procedure TppVariable.SetString(Value: String);
begin
  FString := Value;
  FDataType := dtString;

  PropertyChange;
  Reset;
end; {procedure, SetString}

{------------------------------------------------------------------------------}
{ TppVariable.ValuesFromSaveRec }

procedure TppVariable.ValuesFromSaveRec(aSaveRec: TppVariableSaveRec);
begin

  FInteger := aSaveRec.FInteger;
  FChar := aSaveRec.FChar;
  FBoolean := aSaveRec.FBoolean;
  FCurrency := aSaveRec.FCurrency;
  FDateTime := aSaveRec.FDateTime;
  FDouble := aSaveRec.FDouble;
  FExtended := aSaveRec.FExtended;
  FSingle := aSaveRec.FSingle;

end;

{------------------------------------------------------------------------------}
{ TppVariable.ValuesToSaveRec }

procedure TppVariable.ValuesToSaveRec(var aSaveRec: TppVariableSaveRec);
begin

  aSaveRec.FInteger := FInteger;
  aSaveRec.FChar := FChar;
  aSaveRec.FBoolean := FBoolean;
  aSaveRec.FCurrency := FCurrency;
  aSaveRec.FDateTime := FDateTime;
  aSaveRec.FDouble := FDouble;
  aSaveRec.FExtended := FExtended;
  aSaveRec.FSingle := FSingle;

end;

{------------------------------------------------------------------------------}
{ TppVariable.RestoreFromCache }

procedure TppVariable.RestoreFromCache(aCachePageNo: Longint);
begin

  ReadRecordFromCache(aCachePageNo, FCacheableSaveRec);

  DrawComponent := FCacheableSaveRec.FDrawComponent;
  ResetOnCompute := FCacheableSaveRec.FResetOnCompute;

  ValuesFromSaveRec(FCacheableSaveRec);

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppVariable.SaveToCache }

procedure TppVariable.SaveToCache(aCachePageNo: Longint);
begin

  FCacheableSaveRec.FDrawComponent := DrawComponent;
  FCacheableSaveRec.FResetOnCompute := ResetOnCompute;

  ValuestoSaveRec(FCacheableSaveRec);

  WriteRecordToCache(aCachePageNo, FCacheableSaveRec);

  FJustSaved := True;

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppVariable.GetVariant }

function TppVariable.GetVariant: Variant;
begin

  case FDataType of
    dtBoolean:   Result    := FBoolean;
    dtChar:      Result    := FChar;
    dtCurrency:  Result    := FCurrency;
    dtDouble:    Result    := FDouble;
    dtExtended:  Result    := FExtended;
    dtDate,
    dtTime,
    dtDateTime:  Result    := FDateTime;
    dtInteger:   Result    := FInteger;
    dtSingle:    Result    := FSingle;
    dtString:    Result    := FString;
  end;

end; {procedure, GetVariant}

{------------------------------------------------------------------------------}
{ TppVariable.SetVariant }

procedure TppVariable.SetVariant(Value: Variant);
begin

  {if Null or Empty, assignment will raise exception}
  if VarType(Value) in [varNull, varEmpty] then Exit;

  {Cannot assign an empty string to a char type.}
  if (FDataType = dtChar) and (Length(String(Value)) = 0) then Exit;

  case FDataType of
    dtBoolean:   FBoolean  := Boolean(Value);
    dtChar:      FChar     := String(Value)[1];
    dtCurrency:  FCurrency := Currency(Value);
    dtDouble:    FDouble   := Double(Value);
    dtExtended:  FExtended := Double(Value);
    dtDate,
    dtTime,                                  
    dtDateTime:  FDateTime := TDateTime(Value);
    dtInteger:   FInteger  := Integer(Value);
    dtSingle:    FSingle   := Single(Value);
    dtString:    FString   := String(Value);
  end;

  PropertyChange;

  Reset;

end; {procedure, SetVariant}

{------------------------------------------------------------------------------}
{ TppVariable.GetTheText' }

function TppVariable.GetTheText: String;
var
  lsText: String;
  lsFormat: String;
  lValue: Variant;
begin

  //if FDataType = dtString then
    //Compute;

  lValue := GetCustomValue;

  if (pppcDesigning in DesignState) and not(Printing) then
    lsText := lValue

  else if (FBlankWhenZero) and (FDataType in [dtInteger, dtDouble, dtCurrency, dtSingle, dtExtended]) and
          (lValue = 0) then
    lsText := ''
    
  else
    begin
      if Assigned(OnFormat) then
        lsFormat := ''
      else
        lsFormat := DisplayFormat;

      lsText := ppFormat(lsFormat, FDataType, lValue);
    end;

  if Assigned(OnFormat) then
    OnFormat(Self, DisplayFormat, FDataType, lValue, lsText);

  Result := lsText;

end; {function, GetTheText}

{------------------------------------------------------------------------------}
{ TppVariable.GetCustomValue }

function TppVariable.GetCustomValue: Variant;
begin

  {show 'Custom' as caption}
  if (pppcDesigning in DesignState) and not(Printing) then
    Result :=  UserName

  else
      case FDataType of

        dtBoolean:     Result := FBoolean;

        dtChar:        Result := FChar;

        dtCurrency:    Result := FCurrency;

        dtDouble:      Result := FDouble;

        dtExtended:    Result := FExtended;

        dtDate,
        dtTime,
        dtDateTime:    Result := FDateTime;

        dtInteger:     Result := FInteger;

        dtSingle:      Result := FSingle;

        dtString:      Result := FString;

      else
        Result := '';

      end; {case}


end; {function, GetCustomValue}

{------------------------------------------------------------------------------}
{ TppVariable.SetUserName }

procedure TppVariable.SetUserName(const aUserName: TComponentName);
begin

  inherited SetUserName(aUserName);

  Caption := UserName;

end;  {procedure, SetUserName}


{******************************************************************************
 *
 ** S Y S T E M   V A R I A B L E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppSystemVariable.Create }

constructor TppSystemVariable.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  DefaultPropName := 'VarType';
  DefaultPropEdittype := etValueList;
  DrawCommandClass := TppDrawVar;

  FVarType := vtDate;

end; {function, Create}

{------------------------------------------------------------------------------}
{ TppSystemVariable.Destroy }

destructor TppSystemVariable.Destroy;
begin

  inherited Destroy;

end; {function, Destroy}

{------------------------------------------------------------------------------}
{ TppSystemVariable.SetVarType }

procedure TppSystemVariable.SetVarType(aVarType: TppVarType);
var
  lMainReport: TppCustomReport;
begin

  BeforePropertyChange('VarType');
  
  FVarType := aVarType;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if (FVarType in [vtPageSet, vtPageSetDesc]) then
    begin
      lMainReport := GetMainReport;

      if (lMainReport <> nil) then
        lMainReport.PassSetting := psTwoPass;
    end;

  {set design time caption}
  if (pppcDesigning in DesignState) and not(Printing) then
    begin
      Caption := GetText;

      PropertyChange;

      Reset;
    end;

end; {function, SetVarType}

{------------------------------------------------------------------------------}
{ TppSystemVariable.SetDisplayFormat }

procedure TppSystemVariable.SetDisplayFormat(const aFormat: String);
begin

  inherited SetDisplayFormat(aFormat);

  {set design time caption}
  if (pppcDesigning in DesignState) and not (Printing) then
    Caption := GetText;

end; {function, SetDisplayFormat}

{------------------------------------------------------------------------------}
{ TppSystemVariable.GetDefaultPropEnumNames }

procedure TppSystemVariable.GetDefaultPropEnumNames(aList: TStrings);
var
  lsDocName: String;
begin

  lsDocName := ppLoadStr(1127);
  lsDocName := StringReplace(lsDocName, ' ', '', [rfReplaceAll, rfIgnoreCase]);

  aList.Clear;

  aList.Add(ppLoadStr(303));
  aList.Add(ppLoadStr(304));
  aList.Add(lsDocName);
  aList.Add(ppLoadStr(305));
  aList.Add(ppLoadStr(306));
  aList.Add(ppLoadStr(307));
  aList.Add(ppLoadStr(308));
  aList.Add(ppLoadStr(309));
  aList.Add(ppLoadStr(310));
  aList.Add(ppLoadStr(311));
  aList.Add(ppLoadStr(1098));
  aList.Add(ppLoadStr(1171));
  aList.Add(ppLoadStr(1172));

end; {procedure, GetDefaultPropEnumNames}

{------------------------------------------------------------------------------}
{ TppSystemVariable.GetDefaultPropHint }

function TppSystemVariable.GetDefaultPropHint: String;
begin
  Result := ppLoadStr(378);
end; {function, GetDefaultPropHint}

{------------------------------------------------------------------------------}
{ TppSystemVariable.GetDescription }

function TppSystemVariable.GetDescription: String;
var
  lsCaption: String;

begin
  {format design time caption}
  case FVarType of

    vtDate          : lsCaption := ppLoadStr(303);
    vtDateTime      : lsCaption := ppLoadStr(304);
    vtPrintDateTime : lsCaption := ppLoadStr(305);
    vtPageCount     : lsCaption := ppLoadStr(306);
    vtPageSet       : lsCaption := ppLoadStr(307);
    vtPageSetDesc   : lsCaption := ppLoadStr(308);
    vtPageNo        : lsCaption := ppLoadStr(309);
    vtPageNoDesc    : lsCaption := ppLoadStr(310);
    vtTime          : lsCaption := ppLoadStr(311);
    vtDocumentName  :
      begin
        lsCaption := ppLoadStr(1127);
        lsCaption := TppPlainText.StringStrip(lsCaption, ' ');
      end;
    vtCopyNo        : lsCaption := ppLoadStr(1098);
    vtCopyNoDesc    : lsCaption := ppLoadStr(1171);
    vtSearchDesc    : lsCaption := ppLoadStr(1172);

  end; {case, CalcType}


  Result := UserName + ': ' + lsCaption

end; {function, GetDescription}

{------------------------------------------------------------------------------}
{ TppSystemVariable.GetDataType }

function TppSystemVariable.GetDataType: TppDataType;
begin

  case FVarType of

    vtDate:           Result := dtDate;
    vtDateTime:       Result := dtDateTime;
    vtPageCount:      Result := dtInteger;
    vtPageSet:        Result := dtString;
    vtPageSetDesc:    Result := dtString;
    vtPageNo:         Result := dtInteger;
    vtPageNoDesc:     Result := dtString;
    vtPrintDateTime:  Result := dtDateTime;
    vtTime:           Result := dtTime;
    vtDocumentName:   Result := dtString;
    vtCopyNo:         Result := dtInteger;
    vtCopyNoDesc:     Result := dtString;
    vtSearchDesc:     Result := dtString;

  else              Result := dtNotKnown;

  end; {case, VarType}

end; {function, GetDataType}

{------------------------------------------------------------------------------}
{ TppSystemVariable.PropertiesToDrawCommand }

procedure TppSystemVariable.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawVar;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawVar) then Exit;

  lDrawCommand := TppDrawVar(aDrawCommand);

  {transfer properties to draw command}
  lDrawCommand.VarType  := FVarType;
  lDrawCommand.Value := GetStandardValue;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppSystemVariable.GetStandardValue }

function TppSystemVariable.GetStandardValue: Variant;
var
  liPageNo: Integer;
begin

  case FVarType of

    vtDate:
      Result := Date;

    vtDateTime:
      Result := Now;

    vtPageCount:
      if (Printing) then
        Result := Band.Report.PageCount
      else
        Result := 1;

    vtPageSet, vtPageSetDesc, vtPageNoDesc:
      begin
        liPageNo := Band.Report.PageNo;

        Result := ppFormatVarValue(FVarType, liPageNo, Band.Report.PageCount,
                                   Band.Report.PrintDateTime, Band.LanguageIndex, Printing);
      end;

   vtPageNo:
     if (Printing) then
       Result := Band.Report.PageNo
     else
       Result := 1;


    vtPrintDateTime:
      if (Printing) then
        Result := Band.Report.PrintDateTime
      else
        Result := Now;

    vtTime:
      Result := Time;

    vtDocumentName:
      Result := Band.Report.PrinterSetup.DocumentName;

    vtCopyNo:
      Result := ppLoadStr(1098);

    vtCopyNoDesc:
      Result := ppLoadStr(1166);

    vtSearchDesc:
      if (Printing) and (Band.Report <> nil) and (Band.Report.MainReport <> nil) then
        Result := StringReplace(TppReport(Band.Report.MainReport).AutoSearchDescription, #13#10, ' ', [rfReplaceAll])
      else
        Result := ppLoadStr(1172);

  end; {case, vartype}


end; {procedure, GetStandardValue}

{------------------------------------------------------------------------------}
{ TppSystemVariable.GetTheText }

function TppSystemVariable.GetTheText: String;
var
  lsText: String;
  lsFormat: String;
  lValue: Variant;
begin

  case FVarType of

    vtDate, vtTime, vtDateTime, vtPageCount, vtPageNo, vtPrintDateTime:
      begin
        if Assigned(OnFormat) then
          lsFormat := ''
        else
          lsFormat := DisplayFormat;

        lValue := GetStandardValue;
        lsText := ppFormat(lsFormat, GetDataType, lValue);
      end;

    vtPageSet, vtPageSetDesc, vtPageNoDesc, vtDocumentName, vtCopyNo, vtCopyNoDesc, vtSearchDesc:
      begin
        lValue := GetStandardValue;
        lsText := lValue;
      end;

  end; {case, vartype}

  if Assigned(OnFormat) then
    OnFormat(Self, DisplayFormat, GetDataType, lValue, lsText);

  Result := lsText;

end; {function, GetTheText}



{******************************************************************************
 *
 ** C A L C
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCalc.Create }

constructor TppCalc.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  CacheRecordSize := SizeOf(TppCalcSaveRec);

  DrawCommandClass := TppDrawCalc;

  FCalcType   := ctDate;
  FCustomType := dtDateTime;
  FOnCalc     := nil;

  FBoolean  := False;
  FDateTime := Now;
  FInteger  := 0;
  FDouble   := 0;
  FString   := '';

  DefaultPropName     := 'CalcType';
  DefaultPropEdittype := etValueList;

end; {function, Create}

{------------------------------------------------------------------------------}
{ TppCalc.Destroy }

destructor TppCalc.Destroy;
begin

  inherited Destroy;

end; {function, Destroy}

{------------------------------------------------------------------------------}
{ TppCalc.Convert }

procedure TppCalc.Convert(aVersionNo: Integer);
begin

  inherited Convert(aVersionNo);

  if (aVersionNo < 3000) then
    SetTheDataType;

end; {procedure, Convert}

{------------------------------------------------------------------------------}
{ TppCalc.IsCalc }

function TppCalc.IsCalc: Boolean;
begin
  Result := True;
end; {function, IsCalc}


{------------------------------------------------------------------------------}
{ TppCalc.GetDefaultPropHint }

function TppCalc.GetDefaultPropHint: String;
begin
  {do not convert, this is a deprecated component}
  Result := 'Calc Types';
end; {function, GetDefaultPropHint}


{------------------------------------------------------------------------------}
{ TppCalc.PropertiesToDrawCommand }

procedure TppCalc.PropertiesToDrawCommand(aDrawCommand: TppDrawCommand);
var
  lDrawCommand: TppDrawCalc;
begin

  inherited PropertiesToDrawCommand(aDrawCommand);

  if not(aDrawCommand is TppDrawCalc) then Exit;

  lDrawCommand := TppDrawCalc(aDrawCommand);

  {transfer properties to draw command}
  lDrawCommand.CalcType := FCalcType;
  lDrawCommand.DataType := FCustomType;

end; {procedure, PropertiesToDrawCommand}

{------------------------------------------------------------------------------}
{ TppCalc.SetBoolean }

procedure TppCalc.SetBoolean(Value: Boolean);
begin
 FBoolean  := Value;
 FCustomType := dtBoolean;
end;

{------------------------------------------------------------------------------}
{ TppCalc.SetDateTime }

procedure TppCalc.SetDateTime(Value: TDateTime);
begin
  FDateTime := Value;
  FCustomType := dtDateTime;
end;

{------------------------------------------------------------------------------}
{ TppCalc.SetDouble }

procedure TppCalc.SetDouble(Value: Double);
begin
  FDouble   := Value;
  FCustomType := dtDouble;
end;

{------------------------------------------------------------------------------}
{ TppCalc.SetInteger }

procedure TppCalc.SetInteger(Value: Longint);
begin
  FInteger  := Value;
  FCustomType := dtInteger;
end;

{------------------------------------------------------------------------------}
{ TppCalc.SetString }

procedure TppCalc.SetString(Value: String);
begin
  FString   := Value;
  FCustomType := dtString;
end;


{------------------------------------------------------------------------------}
{ TppCalc.SetText }

procedure TppCalc.SetText(Value: String);
begin

  if (FCalcType = ctCustom) then
    begin
      SetString(Value);
      inherited SetText(Value);
    end;

end;

{------------------------------------------------------------------------------}
{ TppCalc.GetDescription }

function TppCalc.GetDescription: String;
var
  lsCaption: String;

begin
  {format design time caption}
  case FCalcType of

    ctDate          : lsCaption := ppLoadStr(303);
    ctDateTime      : lsCaption := ppLoadStr(304);
    ctPrintDateTime : lsCaption := ppLoadStr(305);
    ctPageCount     : lsCaption := ppLoadStr(306);
    ctPageSet       : lsCaption := ppLoadStr(307);
    ctPageSetDesc   : lsCaption := ppLoadStr(308);
    ctPageNo        : lsCaption := ppLoadStr(309);
    ctPageNoDesc    : lsCaption := ppLoadStr(310);
    ctTime          : lsCaption := ppLoadStr(311);
    ctCustom        : lsCaption := 'Custom';

  end; {case, CalcType}


  Result := Name + ': ' + lsCaption

end;


{------------------------------------------------------------------------------}
{ TppCalc.SetCalcType }

procedure TppCalc.SetCalcType(aCalcType: TppCalcType);
begin

  FCalcType := aCalcType;

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  SetTheDataType;

  {set design time caption}
  if (pppcDesigning in DesignState) and not (Printing) then
    begin
      Caption := GetText;
      PropertyChange;
    end;

end; {function, SetCalcType}

{------------------------------------------------------------------------------}
{ TppCalc.GetTheText }

function TppCalc.GetTheText: String;
var
  lsText: String;
  lsStdFormat: String;
  lValue: Variant;

begin


  if Assigned(OnFormat) then
    lsStdFormat := ''
  else
    lsStdFormat := DisplayFormat;

  {format lsValue, if necessary}
  case FCalcType of

    ctDate, ctTime, ctDateTime, ctPageCount, ctPageNo, ctPrintDateTime:
      begin
        lValue := GetStandardValue;
        lsText := ppFormat(lsStdFormat, FCustomType, lValue);
      end;

    ctPageSet, ctPageSetDesc, ctPageNoDesc:
      begin
        lValue := GetStandardValue;
        lsText := lValue;
      end;

    ctCustom:
      begin
        lValue := GetCustomValue;

        if (pppcDesigning in DesignState) and not(Printing) then
          lsText := lValue
        else
          lsText := ppFormat(lsStdFormat, FCustomType, lValue);
      end;

    else
      begin
        lValue := '';
        lsText := '';
      end;

  end; {case, calctype}

  if Assigned(OnFormat) then
    OnFormat(Self, DisplayFormat, FCustomType, lValue, lsText);

  Result := lsText;

end; {function, GetTheText}

{------------------------------------------------------------------------------}
{ TppCalc.GetCustomValue }

function TppCalc.GetCustomValue: Variant;
begin

   { (end-user designing but not printing) then show 'Custom' as caption }
  if ((pppcDesigning in DesignState) and not (Printing)) then

    Result := 'Custom'

  else
      case FCustomType of

        dtDate, dtTime, dtDateTime:
          Result := FDateTime;

        dtInteger:
          Result := FInteger;

        dtDouble:
          Result := FDouble;

        dtString:
          Result := FString;

        dtBoolean:
          Result := FBoolean;

      else
        Result := '';

      end; {case}


end; {function, GetCustomValue}

{------------------------------------------------------------------------------}
{ TppCalc.GetStandardValue }

function TppCalc.GetStandardValue: Variant;
begin

  case FCalcType of

    ctDate:
      Result := Date;

    ctDateTime:
      Result := Now;

    ctPageCount:
      if (Printing) then
        Result := Band.Report.PageCount
      else
        Result := 1;

    ctPageSet, ctPageSetDesc, ctPageNoDesc:
      Result := ppFormatCalcValue(FCalcType, Band.Report.PageNo, Band.Report.PageCount,
                              Band.Report.PrintDateTime, Band.LanguageIndex, Printing);

   ctPageNo:
     if (Printing) then
       Result := Band.Report.PageNo
     else
       Result := 1;


    ctPrintDateTime:
      if (Printing) then
        Result := Band.Report.PrintDateTime
      else
        Result := Now;

    ctTime:
      Result := Time;


  end; {case, calctype}


end; {procedure, GetStandardValue}

{------------------------------------------------------------------------------}
{ TppCalc.SetTheDataType }

procedure TppCalc.SetTheDataType;
begin
  case FCalcType of

    ctDate:
      FCustomType := dtDate;

    ctDateTime:
      FCustomType := dtDateTime;

    ctPageCount:
      FCustomType := dtInteger;

    ctPageSet:
      FCustomType := dtString;

    ctPageSetDesc:
      FCustomType := dtString;

    ctPageNo:
      FCustomType := dtInteger;

    ctPageNoDesc:
      FCustomType := dtString;

    ctPrintDateTime:
      FCustomType := dtDateTime;

    ctTime:
      FCustomType := dtTime;

    ctCustom:
      FCustomType := dtString;

  end; {case, CalcType}

end; {procedure, SetTheDataType}

{------------------------------------------------------------------------------}
{ TppCalc.SetCustomType }

procedure TppCalc.SetCustomType(aDataType: TppDataType);
begin
  if (csReading in ComponentState) or (csLoading in ComponentState) then
    FCustomType := aDataType

  else if (FCalcType = ctCustom) then
    FCustomType := aDataType;

end;


{------------------------------------------------------------------------------}
{ TppCalc.SetDisplayFormat }

procedure TppCalc.SetDisplayFormat(const aFormat: String);
begin

  inherited SetDisplayFormat(aFormat);

  {set design time caption}
  if (pppcDesigning in DesignState) and not (Printing) then
    Caption := GetText;

end; {function, SetDisplayFormat}


{------------------------------------------------------------------------------}
{ TppCalc.Compute }

procedure TppCalc.Compute;
begin

  if (FCalcType = ctCustom) and (Printing) then
    begin
      if ResetOnCompute then Clear;

      if Assigned(FOnCalc) then FOnCalc(Self);
    end;

end; {procedure, Compute}

{------------------------------------------------------------------------------}
{ TppCalc.GetDefaultPropEnumNames }

procedure TppCalc.GetDefaultPropEnumNames(aList: TStrings);
begin

  aList.Clear;

   aList.Add(ppLoadStr(303));
   aList.Add(ppLoadStr(304));
   aList.Add(ppLoadStr(305));
   aList.Add(ppLoadStr(306));
   aList.Add(ppLoadStr(307));
   aList.Add(ppLoadStr(308));
   aList.Add(ppLoadStr(309));
   aList.Add(ppLoadStr(310));
   aList.Add(ppLoadStr(311));
   aList.Add('Custom');

end; {procedure, GetDefaultPropEnumNames}


{------------------------------------------------------------------------------}
{ TppCalc.Clear }

procedure TppCalc.Clear;
begin
  inherited Clear;

  FBoolean  := False;
  FInteger  := 0;
  FDouble   := 0;
  FString   := '';
  FDateTime := Now;
end;

{------------------------------------------------------------------------------}
{ TppCalc.RestoreFromCache }

procedure TppCalc.RestoreFromCache(aCachePageNo: Longint);
var
  lRec: TppCalcSaveRec;
begin
  ReadRecordFromCache(aCachePageNo, lRec);

  DrawComponent := lRec.FDrawComponent;

  FBoolean  := lRec.FBoolean;
  FDateTime := lRec.FDateTime;
  FInteger  := lRec.FInteger;
  FDouble   := lRec.FDouble;

end; {procedure, RestoreFromCache}

{------------------------------------------------------------------------------}
{ TppCalc.SaveToCache }

procedure TppCalc.SaveToCache(aCachePageNo: Longint);
var
  lRec: TppCalcSaveRec;
begin
  lRec.FDrawComponent := DrawComponent;

  lRec.FBoolean  := FBoolean;
  lRec.FDateTime := FDateTime;
  lRec.FInteger  := FInteger;
  lRec.FDouble   := FDouble;

  WriteRecordToCache(aCachePageNo, lRec);

end; {procedure, SaveToCache}

{------------------------------------------------------------------------------}
{ TppCalc.DefineProperties }

procedure TppCalc.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);

  Filer.DefineProperty('DataType', ReadDataType, nil, False);

end;

{------------------------------------------------------------------------------}
{ TppCalc.ReadDataType }

procedure TppCalc.ReadDataType(Reader: TReader);
var
  lsDataType: String;
begin
  lsDataType := Reader.ReadIdent;

  if (lsDataType = 'ftString') then
    FCustomType := dtString

  else if (lsDataType = 'ftSmallint') or (lsDataType = 'ftInteger') or
          (lsDataType = 'ftWord') or (lsDataType = 'ftBytes') then
    FCustomType := dtInteger

  else if (lsDataType = 'ftFloat' ) or (lsDataType = 'ftCurrency') then
    FCustomType := dtDouble

  else if (lsDataType = 'ftBoolean') then
    FCustomType := dtBoolean

  else if (lsDataType = 'ftDate') then
    FCustomType := dtDate

  else if (lsDataType = 'ftTime') then
    FCustomType := dtTime

  else if (lsDataType = 'ftDateTime') then
    FCustomType := dtDateTime;

end; {procedure, ReadDataType}


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
 ** V A R I A B L E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.RefClass }

class function TraTppVariableRTTI.RefClass: TClass;
begin
  Result := TppVariable;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.GetEventList }

class procedure TraTppVariableRTTI.GetEventList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetEventList(aClass, aPropList);

  aPropList.RemoveProp('OldOnCalc');

end; {class function, GetEventList}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.GetPropList }

class procedure TraTppVariableRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  {add public methods}
  aPropList.AddMethod('SaveToCache');

  {add public props}
  aPropList.AddProp('AsBoolean');
  aPropList.AddProp('AsChar');
  aPropList.AddProp('AsCurrency');
  aPropList.AddProp('AsDateTime');
  aPropList.AddProp('AsDate');
  aPropList.AddProp('AsDouble');
  aPropList.AddProp('AsExtended');
  aPropList.AddProp('AsInteger');
  aPropList.AddProp('AsSingle');
  aPropList.AddProp('AsString');
  aPropList.AddProp('AsTime');
  aPropList.AddProp('Value');

end; {class function, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.GetParams }

class function TraTppVariableRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'OnCalc') = 0) or (CompareText(aMethodName, 'OnReset') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Value', daVariant, nil, '', False, True);
    end
  else if (CompareText(aMethodName, 'SaveToCache') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aCachePageNo', daInteger, nil, '', False, False);
    end


  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.GetPropRec }

class function TraTppVariableRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {events}
  if (CompareText(aPropName, 'OnCalc') = 0) then
    EventToRec(aPropName, ciComponentCalc, True, aPropRec)

  else if (CompareText(aPropName, 'OnReset') = 0) then
    EventToRec(aPropName, ciComponentReset, True, aPropRec)

  else if (CompareText(aPropName, 'SaveToCache') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  {properties & methods}
  else if (CompareText(aPropName, 'AsBoolean') = 0) then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if (CompareText(aPropName, 'AsChar') = 0) then
    PropToRec(aPropName, daChar, False, aPropRec)

  else if (CompareText(aPropName, 'AsCurrency') = 0) then
    PropToRec(aPropName, daCurrency, False, aPropRec)

  else if (CompareText(aPropName, 'AsDateTime') = 0) then
    PropToRec(aPropName, daDateTime, False, aPropRec)

  else if (CompareText(aPropName, 'AsDate') = 0) then
    PropToRec(aPropName, daDate, False, aPropRec)

  else if (CompareText(aPropName, 'AsDouble') = 0) then
    PropToRec(aPropName, daDouble, False, aPropRec)

  else if (CompareText(aPropName, 'AsExtended') = 0) then
    PropToRec(aPropName, daExtended, False, aPropRec)

  else if (CompareText(aPropName, 'AsInteger') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'AsSingle') = 0) then
    PropToRec(aPropName, daSingle, False, aPropRec)

  else if (CompareText(aPropName, 'AsString') = 0) then
    PropToRec(aPropName, daString, False, aPropRec)

  else if (CompareText(aPropName, 'AsTime') = 0) then
    PropToRec(aPropName, daTime, False, aPropRec)

  else if (CompareText(aPropName, 'CalcOrder') = 0) then
    PropToRec(aPropName, daInteger, False, aPropRec)

  else if (CompareText(aPropName, 'CalcComponent') = 0) then
    ClassPropToRec(aPropName, TppCommunicator, False, aPropRec)

  else if (CompareText(aPropName, 'CalcType') = 0) then
    EnumPropToRec(aPropName, 'TppVarEventType', False, aPropRec)

  else if (CompareText(aPropName, 'DataType') = 0) then
    EnumPropToRec(aPropName, 'TppDataType', False, aPropRec)

  else if (CompareText(aPropName, 'ResetComponent') = 0) then
    ClassPropToRec(aPropName, TppCommunicator, False, aPropRec)

  else if (CompareText(aPropName, 'ResetType') = 0) then
    EnumPropToRec(aPropName, 'TppVarEventType', False, aPropRec)

  else if (CompareText(aPropName, 'Value') = 0) then
    PropToRec(aPropName, daVariant, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.GetPropValue }

class function TraTppVariableRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AsBoolean') = 0) then
    Integer(aValue) := Ord(TppVariable(aObject).AsBoolean)

  else if (CompareText(aPropName, 'AsChar') = 0) then
    Char(aValue) := TppVariable(aObject).AsChar

  else if (CompareText(aPropName, 'AsCurrency') = 0) then
    Currency(aValue) := TppVariable(aObject).AsCurrency

  else if (CompareText(aPropName, 'AsDateTime') = 0) then
    TDateTime(aValue) := TppVariable(aObject).AsDateTime

  else if (CompareText(aPropName, 'AsDate') = 0) then
    TDateTime(aValue) := TppVariable(aObject).AsDate

  else if (CompareText(aPropName, 'AsDouble') = 0) then
    Double(aValue) := TppVariable(aObject).AsDouble

  else if (CompareText(aPropName, 'AsExtended') = 0) then
    Extended(aValue) := TppVariable(aObject).AsExtended

  else if (CompareText(aPropName, 'AsInteger') = 0) then
    Integer(aValue) := TppVariable(aObject).AsInteger

  else if (CompareText(aPropName, 'AsSingle') = 0) then
    Single(aValue) := TppVariable(aObject).AsSingle

  else if (CompareText(aPropName, 'AsString') = 0) then
    String(aValue) := TppVariable(aObject).AsString

  else if (CompareText(aPropName, 'AsTime') = 0) then
    TDateTime(aValue) := TppVariable(aObject).AsTime

  else if (CompareText(aPropName, 'CalcOrder') = 0) then
    Integer(aValue) := TppVariable(aObject).CalcOrder

  else if (CompareText(aPropName, 'CalcComponent') = 0) then
    Integer(aValue) := Integer(TppVariable(aObject).CalcComponent)

  else if (CompareText(aPropName, 'CalcType') = 0) then
    TppVarEventType(aValue) := TppVariable(aObject).CalcType

  else if (CompareText(aPropName, 'DataType') = 0) then
    TppDataType(aValue) := TppVariable(aObject).DataType

  else if (CompareText(aPropName, 'ResetComponent') = 0) then
    Integer(aValue) := Integer(TppVariable(aObject).ResetComponent)

  else if (CompareText(aPropName, 'ResetType') = 0) then
    TppVarEventType(aValue) := TppVariable(aObject).ResetType

  else if (CompareText(aPropName, 'Value') = 0) then
    Variant(aValue) := TppVariable(aObject).Value

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.SetPropValue }

class function TraTppVariableRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AsBoolean') = 0) then
    TppVariable(aObject).AsBoolean := Boolean(aValue)

  else if (CompareText(aPropName, 'AsChar') = 0) then
    TppVariable(aObject).AsChar := Char(aValue)

  else if (CompareText(aPropName, 'AsCurrency') = 0) then
    TppVariable(aObject).AsCurrency := Currency(aValue)

  else if (CompareText(aPropName, 'AsDateTime') = 0) then
    TppVariable(aObject).AsDateTime := TDateTime(aValue)

  else if (CompareText(aPropName, 'AsDate') = 0) then
    TppVariable(aObject).AsDate := TDateTime(aValue)

  else if (CompareText(aPropName, 'AsDouble') = 0) then
    TppVariable(aObject).AsDouble := Double(aValue)

  else if (CompareText(aPropName, 'AsExtended') = 0) then
    TppVariable(aObject).AsExtended := Extended(aValue)

  else if (CompareText(aPropName, 'AsInteger') = 0) then
    TppVariable(aObject).AsInteger := Integer(aValue)

  else if (CompareText(aPropName, 'AsSingle') = 0) then
    TppVariable(aObject).AsSingle := Single(aValue)

  else if (CompareText(aPropName, 'AsString') = 0) then
    TppVariable(aObject).AsString := String(aValue)

  else if (CompareText(aPropName, 'AsTime') = 0) then
    TppVariable(aObject).AsTime := TDateTime(aValue)

  else if (CompareText(aPropName, 'CalcOrder') = 0) then
    TppVariable(aObject).CalcOrder := Integer(aValue)

  else if (CompareText(aPropName, 'CalcComponent') = 0) then
    TppVariable(aObject).CalcComponent := TppCommunicator(aValue)

  else if (CompareText(aPropName, 'CalcType') = 0) then
    TppVariable(aObject).CalcType := TppVarEventType(aValue)

  else if (CompareText(aPropName, 'DataType') = 0) then
    TppVariable(aObject).DataType := TppDataType(aValue)

  else if (CompareText(aPropName, 'ResetComponent') = 0) then
    TppVariable(aObject).ResetComponent := TppCommunicator(aValue)

  else if (CompareText(aPropName, 'ResetType') = 0) then
    TppVariable(aObject).ResetType := TppVarEventType(aValue)

  else if (CompareText(aPropName, 'Value') = 0) then
    TppVariable(aObject).Value := Variant(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{------------------------------------------------------------------------------}
{ TraTppVariableRTTI.CallMethod }

class function TraTppVariableRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  liPageNo: Integer;
begin

  Result := True;

  if (CompareText(aMethodName, 'SaveToCache') = 0) then
    begin
      aParams.GetParamValue(0, liPageNo);
      TppVariable(aObject).SaveToCache(liPageNo);
    end

  else
    inherited CallMethod(aObject, aMethodName, aParams, aGet);


end;


{******************************************************************************
 *
 ** S Y S T E M   V A R I A B L E   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppSystemVariableRTTI.RefClass }

class function TraTppSystemVariableRTTI.RefClass: TClass;
begin
  Result := TppSystemVariable;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppSystemVariableRTTI.GetPropList }

class procedure TraTppSystemVariableRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.Add('DataType');

end; {class function, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppSystemVariableRTTI.GetPropRec }

class function TraTppSystemVariableRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'VarType') = 0) then
    EnumPropToRec(aPropName, 'TppVarType', True, aPropRec)

  else if (CompareText(aPropName, 'DataType') = 0) then
    EnumPropToRec(aPropName, 'TppDataType', False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppSystemVariableRTTI.GetPropValue }

class function TraTppSystemVariableRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'VarType') = 0) then
    Byte(aValue) := Ord(TppSystemVariable(aObject).VarType)

  else if (CompareText(aPropName, 'DataType') = 0) then
    TppDataType(aValue) := TppSystemVariable(aObject).DataType

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTppSystemVariableRTTI.SetPropValue }

class function TraTppSystemVariableRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'VarType') = 0) then
    TppSystemVariable(aObject).VarType := TppVarType(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  raRegisterRTTI(TraTppVariableRTTI);
  raRegisterRTTI(TraTppSystemVariableRTTI);

finalization

  raUnRegisterRTTI(TraTppVariableRTTI);
  raUnRegisterRTTI(TraTppSystemVariableRTTI);

end.
