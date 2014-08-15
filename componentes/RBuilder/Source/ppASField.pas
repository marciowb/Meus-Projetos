{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB                             
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppASField;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes,
  SysUtils,
  Graphics,
  Variants,
  DateUtils,
  ppTypes,
  ppUtils,
  ppComm,
  ppEnum,
  ppRelatv,
  ppRTTI,
  ppDB,
  ppCharacter;

type

  TppAutoSearchField = class;
  TppLookupSettings = class;
  TppLookupList = class;
  TppSearchValueList = class;

  {IppAutoSearchFields

  Extract this interface from a TppProducer in order to access the autosearch
  fields. This is used in background printing in order to support autosearch
  without having to check the TppReport class type.}

  IppAutosearchFields = interface
    ['{B33DCD29-8809-4CAB-893B-C4776B75AEA3}']
    function iAutoSearchFieldCount: Integer;
    function iAutosearchFieldForIndex(aIndex: Integer): TppAutosearchField;
    function iCreateAutoSearchCriteria(const aDataPipelineName, aFieldName: String; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
    function iCreateAutoSearchField(const aTableName, aFieldName, aFieldAlias: String; aDataType: TppDataType; aOperator: TppSearchOperatorType; const aExpression: String; aMandatory: Boolean): TppAutoSearchField;
  end;



  {@TppAutoSearchField

    AutoSearch fields are used by ReportBuilder to store parameter values
    used to build search criteria.

    AutoSearchFields are typically created and managed automatically by DADE,
    the Data Access Environment included with ReportBuilder Professional and
    Enterprise. DADE includes query tools that can be used to add search
    criteria that are designated as AutoSearch, and as such result in a
    corresponding AutoSearchField being created.

    AutoSearchFields can also be created explicitly by calling
    Report.CreateAutoSearchField and Report.CreateAutoSearchCriteria.

    When a Report contains AutoSearchFields, an AutoSearch dialog is automatically
    displayed to the user prior to generating a report.

    If the AutoSearchField contains a LookupList, the AutoSearch dialog will
    display a list of search values from which the user can select.

    Use LookupSettings to bind the LookupList to lookup data and control the
    appearance of the lookup list.

    The SearchExpression, SearchOperator and FieldName properties contain the
    search value, the search operator and the corresponding field name respectively.

    Once an AutoSearchField contains a search criteria value, there
    are several properties which assist in building a search expression string
    which is valid in the context of either a Table.Filter property, an SQL
    'WHERE' clause or SQL parameters.

    In order to create search expressions appropriate for an SQL 'WHERE'
    clause, use the Wildcard, Delimiter and DisplayFormat properties and
    retrieve the search expression from the SQLString function.

    To build search expressions suitable for the Table.Filter property use the
    Wildcard, Delimiter and DisplayFormat properties and retrieve the search
    expression from the FilterString function.

    And in order to assign search values to the parameters in a TQuery, use
    the Wildcard property and retrieve the search values using the Value or
    Values functions.

    An example for each of these techniques is provided in the
    ...\\RBuilder\\Demos\\5. AutoSearch directory.}

  {@TppAutoSearchField.AutoSearchPanel

    The AutoSearchPanel which has been created to represent the field in the
    AutoSearch dialog.  This property is only assigned while the AutoSearch
    dialog is displayed.}

  {@TppAutoSearchField.Criteria

    When an AutoSearch field has been created by a query dataview in the data
    workspace, then this property contains a pointer to the actual criteria
    object the field represents.  This property is used by the query dataview
    when assigning the results of AutoSearch entries to the criteria within the
    SQL object.}

  {@TppAutoSearchField.DataView

    When the AutoSearchField is created by a dataview in the data workspace,
    this property is assigned by the dataview.  The AutoSearchNotebook uses the
    dataview property to distinguish between AutoSearch fields from different
    dataviews.}

  {@TppAutoSearchField.Delimiter

    Indicates the delimiter that should be used when building a FilterString or
    SQLString for a search field with a DataType of dtString.}

  {@TppAutoSearchField.LookupList

    When the AutoSearchField contains a LookupList, the AutoSearch dialog will
    display a list of search values from which the user can select. Use the
    LookupSettings to bind the LookupList to lookup data and control the
    appearance of the list. }

  {@TppAutoSearchField.LookupSettings

    Use LookupSettings to bind the LookupList to lookup data and control the
    appearance of the lookup list.}

  {@TppAutoSearchField.ParentControl

    This property contains the parent control to be used when instantiating the
    AutoSearchPanel for the field.  The AutoSearch dialog assigns this property
    when creating the AutoSearchPanels.  This property has a value only while
    the AutoSearchDialog is visible.}

  {@TppAutoSearchField.SearchExpression

    Specifies the search value or values that will be used along with the
    SearchOperator and FieldName to define a search condition that is
    applied to a SQL 'WHERE' clause.}

  {@TppAutoSearchField.SearchOperator

    The SearchOperator property determines how the search criteria will be
    evaluated. These are the possible values:


    <Table>
    Value	                  Meaning
    ----------------------  ---------
    soEqual                 The field value must be the same as the search
                            value.
    soNotEqual              The field value must not be the same as the search
                            value.
    soLessThan              The field value must be less than the search value.
    soLessThanOrEqualTo     The field value must be less than or equal to the
                            search value.
    soGreaterThan           The field value must be greater than the search
                            value.
    soGreaterThanOrEqualTo  The field value must be greater than or equal to the
                            search value.
    soLike                  The field value must begin with the search value.
                            A wildcard is automatically placed at the end of the
                            search criteria value which use this operator,
                            making it function as a 'begins with'
    soNotLike               The field value must not begins with the search
                            value.
    soBetween               The field value must fall between the two search
                            criteria values.
    soNotBetween            The field value must not fall between the two search
                            criteria values.
    soInList                The field value must appear in the list of search
                            values.
    soNotInList             The field value must not appear in the list of
                            search values.
    soBlank                 The field value must be null. (No search value is
                            required for this operator.)

    soNotBlank              The field value must not be null. (No search value
                            is required for this operator.)

    </Table>}

  {@TppAutoSearchField.Value

    The value of the SearchExpression as a variant.  The value is converted
    based on the DataType.  If you are using the Between or InList operators and
    have multiple values in the SearchExpression, use the Values property
    instead.}

  {@TppAutoSearchField.ValueCount

    The number of values which will be returned by the Values property.
    This property is applicable when the SearchOperator is Between or
    InList.}

  {@TppAutoSearchField.Values

    The values of the SearchExpression as variants.  The values are converted
    based on the DataType.  This function is only applicable when you are using
    the Between or InList operators and have multiple values in the
    SearchExpression.}

  {@TppAutoSearchField.WildCard

    Defaults to '%'.  The WildCard character which should be used when
    building strings for use with the Like operator.}


  TppAutoSearchField = class(TppRelative)
    private
      FAlignment: TAlignment;
      FAutoSearch: Boolean;
      FColumnWidth: Integer;
      FDataType: TppDataType;
      FDisplayFormat: String;
      FDisplayWidth: Integer;
      FFieldLength: Integer;
      FFieldAlias: String;
      FFieldName: String;
      FFirstField: Boolean;
      FGroupOrder: Integer;
      FIsDetail: Boolean;
      FLinkable: Boolean;
      FMandatory: Boolean;
      FReportComponent: TppCommunicator;
      FReportLabel: TppCommunicator;
      FSelectable: Boolean;
      FSelectOrder: Integer;
      FSearchable: Boolean;
      FSearch: Boolean;
      FSearchOrder: Integer;
      FSelectedIndex: Integer;
      FShowAllValues: Boolean;
      FSortable: Boolean;
      FSortOrder: Integer;
      FSort: Boolean;
      FSortExpression: String;
      FSortType: TppSortOrderType;
      FTableAlias: String;
      FTableName: String;

      FAsFilter: Boolean;
      FAutoSearchPanel: TComponent;
      FCriteria: TComponent;
      FDataPipelineName: String;
      FDataView: TComponent;
      FDelimiter: String;
      FEnabled: Boolean;
      FLastField: Boolean;
      FLogicalPrefix: TppLogicalOperatorTypes;
      FOnChange: TNotifyEvent;
      FParentControl: TComponent;
      FLookupList: TppLookupList;
      FSearchOperator: TppSearchOperatorType;
      FValueList: TppSearchValueList;
      FWildCard: String;

      procedure SetDataType(aDataType: TppDataType);

      procedure DoOnChange;
      function GetGroupDescription: String;
      function GetHasLookupList: Boolean;
      function GetLookupSettings: TppLookupSettings;
      function GetSearchExpression: String;
      function GetSubExpressions(Index: Integer): String;
      function  GetValue: Variant;
      function  GetValues(aIndex: Integer): Variant;
      function  GetValueCount: Integer;
      procedure SetCriteria(aCriteria: TComponent);
      procedure SetDataView(aDataView: TComponent);
      procedure SetDataPipelineName(const aName: String);
      procedure SetLookupList(const aLookupList: TppLookupList);
      procedure SetLookupSettings(const Value: TppLookupSettings);
      procedure SetSearchOperator(aOperator: TppSearchOperatorType);
      function  GetNameForSearchExpression(aSearchExpression: String): String;

    protected
      procedure SetFieldName(const aFieldName: String);
      procedure SetMandatory(aValue: Boolean);
      procedure SetSearchExpression(const aExpression: String);
      procedure SetShowAllValues(aValue: Boolean);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure DisableCriteria;
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure Assign(aSource: TPersistent); override;
      function AssignSearchValuesFromField(aAutoSearchField: TppAutoSearchField): Boolean; virtual;
      function EqualTo(aSource: TppAutoSearchField): Boolean;

      function  HasParent: Boolean; override;

      function Description: String;
      function FilterString: String;
      function FormattedExpression: String;
      function FormatValue(aValue: String): String;
      function GetDateTimeFormat: String; overload;
      function GetDateTimeFormat(aValue: TDateTime): String; overload;
      procedure Initialize;
      function IsMultiValue: Boolean;
      function LogicalPrefixDescr: string;
      function OperatorAsString: String;
      function OperatorDesc: String;
      function SQLString: String;
      function Valid: Boolean;

      {these properties used by the report wizard only}
      property AutoSearch: Boolean read FAutoSearch write FAutoSearch default False;
      property ColumnWidth: Integer read FColumnWidth write FColumnWidth;
      property FirstField: Boolean read FFirstField write FFirstField default False;
      property ReportComponent: TppCommunicator read FReportComponent write FReportComponent;
      property ReportLabel: TppCommunicator read FReportLabel write FReportLabel;

      {this property used by the FieldListBuilder}
      property SelectedIndex: Integer read FSelectedIndex write FSelectedIndex;

      property AutoSearchPanel: TComponent read FAutoSearchPanel write FAutoSearchPanel;
      property Criteria: TComponent read FCriteria write SetCriteria;
      property DataPipelineName: String read FDataPipelineName write SetDataPipelineName;
      property DataView: TComponent read FDataView write SetDataView;
      property Enabled: Boolean read FEnabled;
      property LastField: Boolean read FLastField write FLastField;
      property ParentControl: TComponent read FParentControl write FParentControl;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;
      property GroupDescription: String read GetGroupDescription;
      property HasLookupList: Boolean read GetHasLookupList;
      property SubExpressions[Index: Integer]: String read GetSubExpressions;
      property Value: Variant read GetValue;
      property Values[Index: Integer]: Variant read GetValues;
      property ValueCount: Integer read GetValueCount;

    published
      property Alignment: TAlignment read FAlignment write FAlignment default taLeftJustify;
      property FieldAlias: String read FFieldAlias write FFieldAlias;
      property FieldName: String read FFieldName write SetFieldName;
      property FieldLength: Integer read FFieldLength write FFieldLength;
      property IsDetail: Boolean read FIsDetail write FIsDetail default False;
      property Linkable: Boolean read FLinkable write FLinkable default True;
      property GroupOrder: Integer read FGroupOrder write FGroupOrder default -1;
      property DataType: TppDataType read FDataType write SetDataType default dtString;
      property DisplayFormat: String read FDisplayFormat write FDisplayFormat;
      property DisplayWidth: Integer read FDisplayWidth write FDisplayWidth;
      property Mandatory: Boolean read FMandatory write SetMandatory default False;
      property Position;
      property Selectable: Boolean read FSelectable write FSelectable default True;
      property SelectOrder: Integer read FSelectOrder write FSelectOrder default -1;
      property Searchable: Boolean read FSearchable write FSearchable default True;
      property Search: Boolean read FSearch write FSearch default False;
      property SearchExpression: String read GetSearchExpression write SetSearchExpression;
      property SearchOrder: Integer read FSearchOrder write FSearchOrder default -1;
      property ShowAllValues: Boolean read FShowAllValues write SetShowAllValues default False;
      property Sortable: Boolean read FSortable write FSortable default True;
      property Sort: Boolean read FSort write FSort default False;
      property SortOrder: Integer read FSortOrder write FSortOrder default -1;
      property SortType: TppSortOrderType read FSortType write FSortType default soAscending;
      property SortExpression: String read FSortExpression write FSortExpression;
      property TableAlias: String read FTableAlias write FTableAlias;
      property TableName: String read FTableName write FTableName;

      property Delimiter: String read FDelimiter write FDelimiter;
      property LogicalPrefix: TppLogicalOperatorTypes read FLogicalPrefix write FLogicalPrefix;
      property LookupList: TppLookupList read FLookupList write SetLookupList;
      property LookupSettings: TppLookupSettings read GetLookupSettings write SetLookupSettings;
      property SearchOperator: TppSearchOperatorType read FSearchOperator write SetSearchOperator default soEqual;
      property WildCard: String read FWildCard write FWildCard;

  end; {class, TppAutoSearchField}

  TppAutoSearchGroup = class;

  {@TppAutoSearchGroups

    Represents a collection of TppAutoSearchGroup objects which describe the
    autosearch fields (i.e. parameters) for a report.

    Use the Count and Groups array property to iterate through the list of
    TppAutoSearchGroup objects.}

  {@TppAutoSearchGroups.Count

    Returns the number of items in the Groups array.}

  {@TppAutoSearchGroups.Groups

    Provides access to the TppAutoSearchGroup objects.

    Each TppAutoSearchGroup object represents a collection of
    auto search fields associated with a dataview created using the
    query tools included with RB Professional and Enterprise. If the
    query tools are not used to create the search criteria, then a default
    TppAutoSearchGroup is used to represent the autosearch fields associated
    with the report.}

    
  TppAutoSearchGroups = class(TppRelative)
    private

      function GetGroupForIndex(aIndex: Integer): TppAutoSearchGroup;
      procedure AssignGroups(aSource: TppAutoSearchGroups); 

    protected

    public
      procedure Assign(aSource: TPersistent); override;
      procedure AssignAutoSearchFields(aAutoSearchFields: TList); virtual;
      function AssignSearchValuesFromGroups(aSource: TppAutoSearchGroups): Boolean;

      procedure AddAutoSearchField(aGroupDescription, aFieldName, aSearchExpression: String; aShowAllValues: Boolean); overload;
      procedure AddAutoSearchField(aAutoSearchField: TppAutoSearchField); overload;
      function AddGroup(aDescription: String): TppAutoSearchGroup;
      procedure Clear;
      function CompareStructure(aSource: TppAutoSearchGroups): Boolean;
      function EqualTo(aSource: TppAutoSearchGroups): Boolean;
      procedure GetAllFields(aAutoSearchFields: TList);
      function GetGroupForField(aAutoSearchField: TppAutoSearchField): TppAutoSearchGroup;
      function GetGroupForDescription(aDescription: String): TppAutoSearchGroup;
      function HasMandatoryField: Boolean;
      function IndexOfDescription(aDescription: String): Integer;

      property Count: Integer read GetChildCount;
      property Groups[Index: Integer]: TppAutoSearchGroup read GetGroupForIndex; default;

  end; {class, TppAutoSearchGroups}

  {@TppAutoSearchGroup

    Represents a collection of TppAutoSearchField objects which describe the
    autosearch fields (i.e. parameters) for a report.

    Use the FieldCount and Fields array property to iterate through the list of
    TppAutoSearchField objects.

    Use the FieldsByName property to access the TppAutoSearchField objects by
    name.}


  {@TppAutoSearchGroup.Description

    A text description of the dataview which created the autosearch fields.

    The Description is used by the auto search dialog's notebook for the case
    in which multiple dataviews contain auto search criteria.}

  {@TppAutoSearchGroup.FieldCount

    Returns the number of items in the Fields array.}

  {@TppAutoSearchGroup.FieldCount

    Returns the number of items in the Fields array.}

  {@TppAutoSearchGroup.Fields

    Provides access to the TppAutoSearchField objects by index.}

  {@TppAutoSearchGroup.Fields

    Provides access to the TppAutoSearchField objects by name.}

  {@TppAutoSearchGroup.FieldsByName

    Provides named access to the TppAutoSearchField objects.}

  {@TppAutoSearchGroup.TabOrder

    The tab order index the dataview which created the autosearch fields.

    The TabOrder is used by the auto search dialog's notebook for the case
    in which multiple dataviews contain auto search criteria.}

  TppAutoSearchGroup = class(TppRelative)
    private
      FDescription: String;
      FTabOrder: Integer;

      function GetDataView: TObject;
      function GetFieldForIndex(aIndex: Integer): TppAutoSearchField;
      function GetFieldForName(aFieldName: String): TppAutoSearchField;

    protected

    public
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure AddField(aAutoSearchField: TppAutoSearchField); virtual;
      procedure Assign(aSource: TPersistent); override;
      procedure AssignGroup(aSource: TppAutoSearchGroup); virtual;
      function AssignSearchValuesFromGroup(aSource: TppAutoSearchGroup): Boolean;
      procedure Clear;  virtual;
      function CompareStructure(aSource: TppAutoSearchGroup): Boolean;
      function EqualTo(aSource: TppAutoSearchGroup): Boolean;
      function GetFieldForNameAndOperator(aFieldName: String; aSearchOperator: TppSearchOperatorType): TppAutoSearchField;

      property FieldCount: Integer read GetChildCount;
      property Fields[Index: Integer]: TppAutoSearchField read GetFieldForIndex; default;
      property FieldsByName[aFieldName: String]: TppAutoSearchField read GetFieldForName;

    published
      property Description: String read FDescription write FDescription;
      property TabOrder: Integer read FTabOrder write FTabOrder;

    end; {class, TppAutoSearchGroup}

    
    TppLookupListSortOrder = (soName, soValue);
    TppLookupListDisplayType = (dtNameOnly, dtValueAndName, dtNameAndValue);
 //   TppLookupListBuildType = (dtStatic, dtRebuildWhenRelativesChange);

    {@TppLookupList

     Represents a list of items that can be displayed to the user.

     For example, when an AutoSearchField's LookupList is populated, the
     AutoSearch dialog will display a drop down list from which the user can
     select a search value.

     Use the LookupSettings to configure the behavior of the LookupList.

     The LookupSettings.DataPipeline, ValueField, and NameField properties
     are used to bind a LookupList to a datapipeline containing lookup data.

     The LookupSettings.DisplayType and SortOrder control the appearance
     of the LookupList when displayed to the user.

     The HasNameValuePairs property indicates whether Items contain
     'name=value' pairs or values only.}

   {@TppLookupList.HasNameValuePairs

     Read only. Indicates whether Items contain 'name=value' pairs or values only.}

   {@TppLookupList.LookupSettings

     Use the LookupSettings to configure the behavior of the LookupList.

     The LookupSettings.DataPipeline, ValueField, and NameField properties
     are used to bind a LookupList to a datapipeline containing lookup data.

     The LookupSettings.DisplayType and SortOrder control the appearance
     of the LookupList when displayed to the user.}

    TppLookupList = class(TStringList)
    private
      FLookupSettings: TppLookupSettings;
      function GetHasNameValuePairs: Boolean;
      procedure SetLookupSettings(const Value: TppLookupSettings);

    protected
      function CompareStrings(const S1, S2: string): Integer; override;
      function ExtractValue(aString: String): String;

 {$IFNDEF Delphi7}
      // D6 TStrings does not have this
      function GetValueFromIndex(aIndex: Integer): String;
      property ValueFromIndex[Index: Integer]: string read GetValueFromIndex;
{$ENDIF}

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure Assign(aSource: TPersistent); override;
      procedure BuildList; virtual;
      function GetDisplayNameForIndex(aIndex: Integer): String; virtual;
      function GetDisplayNameForValue(aValue: String): String;
      procedure GetDisplayNames(aNameList: TStrings);
      function GetValueForDisplayName(aName: String): String;
      function GetValueForIndex(aIndex: Integer): String;
      function IndexOfValue(aValue: String): Integer;
      function IndexOfDisplayName(aName: String): Integer;
      
      property HasNameValuePairs: Boolean read GetHasNameValuePairs;
      property LookupSettings: TppLookupSettings read FLookupSettings write SetLookupSettings;


      // MasterLookupList  - used to establish a master detail list, when master list ItemIndex changes,
      //                     then list is automatically rebuilt
      // ItemIndex         - used to specify the selected item
      // mcItemSelected    - multi-cast event, fires when item selected
      // mcBeforeBuildList -
      // mcAfterBuildList

    end;


    {@TppLookupSettings

     Contains properties used to specify the behavior of a LookupList. 

     Use the DataPipeline, ValueField, and NameField properties to bind a
     LookupList to a datapipeline containing lookup data.

     Use the DisplayType and SortOrder to control the appearance of the
     LookupList when displayed to the user.

     For example:

     <code>
       uses
         ppParameter,
         ppAsField;

       begin
         myParameter.LookupSettings.DataPipeline := CustomerLookup;
         myParameter.LookupSettings.ValueField := 'CustNo';
         myParameter.LookupSettings.NameField := 'Company';

         myParameter.LookupSettings.DisplayType := dtValueAndName;
         myParameter.LookupSettings.SortOrder := soName;

       end;

     </code>}

     {@TppLookupSettings.DataPipeline

      A DataPipeline containing lookup data. Use this propety in conjunction
      with the ValueField and NameField properties.}

     {@TppLookupSettings.DisplayType

      Specifies how lookup items are displayed to the user.

      <Table>
      Value	           Meaning
      ---------       ---------
      dtNameOnly	    Lookup items contain the name only.
      dtValueAndName  Lookup items are displayed in a 'Value - Name' format.
      dtNameAndValue	Lookup items are displayed in a 'Name - Value' format.
      </Table>}

     {@TppLookupSettings.NameField

      A DataPipeline field containing user friendly names assoicated with
      each value. When NameField is not specified, the ValueField values are
      displayed to the user}

    {@TppLookupSettings.ValueField

      A DataPipeline field containing values used for the search expression.}

     {@TppLookupSettings.SortOrder

      Specifies how lookup items are sorted.

      <Table>
      Value	           Meaning
      ---------       ---------
      soName	        Lookup items are sorted by Name.
      soValue         Lookup items are sorted by Value.
      </Table>}

    TppLookupSettings = class(TPersistent)
    private
      FDataPipeline: TppDataPipeline;
      FDataPipelineName: string;
      FNameField: String;
      FDisplayType: TppLookupListDisplayType;
      FSortOrder: TppLookupListSortOrder;
      FValueField: String;

      procedure ehDataPipeline_FreeNotify(Sender, aParameters: TObject);

      {read/write private properties}
      procedure ReadDataPipelineName(Reader: TReader);
      procedure SetDataPipeline(const Value: TppDataPipeline);
      procedure SetNameField(const Value: String);
      procedure SetDisplayType(const Value: TppLookupListDisplayType);
      procedure SetSortOrder(const Value: TppLookupListSortOrder);
      procedure SetValueField(const Value: String);
      procedure WriteDataPipelineName(Writer: TWriter);

    protected
      procedure AssignLookupSettings(aSource: TppLookupSettings); virtual;

      {override from TComponent}
      procedure DefineProperties(Filer: TFiler); override;

    public
      constructor Create; virtual;
      destructor Destroy; override;
      procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); virtual;

    published
      procedure Assign(Source: TPersistent); override;

      property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline stored False;
      property NameField: String read FNameField write SetNameField;
      property DisplayType: TppLookupListDisplayType read FDisplayType write SetDisplayType;
      property SortOrder: TppLookupListSortOrder read FSortOrder write SetSortOrder;
      property ValueField: String read FValueField write SetValueField;
    end;


  TppDateFormatType = (dfMDY, dfDMY, dfYMD);
//  TppTimeFormatType = (tfHM, tfHMS, tfHMSN);

{$IFNDEF Delphi7}
  // Delphi 6 does not have TFormatSettings
  TFormatSettings = record
      DateSeparator: Char;
      ShortDateFormat: string;
   end;

{$ENDIF}

  {TppDateFormat}
  TppDateFormat = class
  private
    FDateSeparator: Char;
    FFormatSettings: TFormatSettings;
    FFormatType: TppDateFormatType;
    FFormatTypeAsString: string;

    function GetFormatString: String;
{$IFNDEF Delphi7}
    // Delphi 6 does not have these sysutils methods
    procedure GetLocaleFormatSettings(aLCID: Integer; var aFormatSettings: TFormatSettings);
    function FormatDateTime(const aFormat: String; const aDateTime: TDateTime; const aFormatSettings: TFormatSettings): String;
    function DateToStr(const aDateTime: TDateTime; const aFormatSettings: TFormatSettings): string;
    function StrToDate(const aDateString: string; const aFormatSettings: TFormatSettings): TDateTime;
{$ENDIF}

  protected
    procedure Initialize(aFormatSettngs: TFormatSettings);

  public
    constructor Create;

    property DateSeparator: Char read FDateSeparator;
    property FormatString: String read GetFormatString;
    property FormatType: TppDateFormatType read FFormatType; // write FFormatType;
    property FormatTypeAsString: string read FFormatTypeAsString;

    function Parse(aDateString: String): TDateTime;
    function FormatValue(aDate: TDateTime): string;
    function GetYUIMonthNamesLong: string;
    function GetYUIWeekDaysShort: string;

  end;




{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppAutoSearchFieldRTTI }
  TraTppAutoSearchFieldRTTI = class(TraTppRelativeRTTI)
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
  end; {class, TraTppAutoSearchFieldRTTI}



  {TppSearchValueList}
  TppSearchValueList = class(TStringList)
  private
    FField: TppAutoSearchField;
    FParameter: Tcomponent;

    function ConvertFromDataType(aValue: Variant): String;
    function ConvertToDataType(aIndex: Integer): Variant;
    function GetSearchExpression: string;
    function GetSearchExpressionForDateTime: string;
    function GetSearchExpressionForNumeric: string;
    function GetSubExpressions(Index: Integer): String;
    function GetValues(Index: Integer): Variant;

    procedure SetSearchExpression(const aSearchExpression: string);
    procedure SetSearchExpressionForDateTime(const aSearchExpression: string);
    procedure SetSearchExpressionForNumeric(const aSearchExpression: string);
  protected
    function GetDateTimeFormat: String; overload; virtual;
    function GetDateTimeFormat(aValue: TDateTime): String; overload;
    function GetDataType: TppDataType; virtual;
    function GetIsMultiValue: Boolean; virtual;
    function GetWildCard: string; virtual;

    property DataType: TppDataType read GetDataType;
    property IsMultiValue: Boolean read GetIsMultiValue;
    property WildCard: string read GetWildCard;

  public
    constructor Create(aField: TppAutoSearchField);  overload; virtual;
    constructor Create(aParameter: TComponent); overload; virtual;

    property SearchExpression: string read GetSearchExpression write SetSearchExpression;
    property SubExpressions[Index: Integer]: String read GetSubExpressions;
    property Values[Index: Integer]: Variant read GetValues;

  end;


implementation

uses
  ppClass,
  ppParameter;

{******************************************************************************
 *
 ** A U T O   S E A R C H   F I E L D
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.Create }

constructor TppAutoSearchField.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FAlignment        := taLeftJustify;
  FAutoSearch       := False;
  FColumnWidth      := 0;
  FDataType         := dtString;
  FDisplayFormat    := '';
  FDisplayWidth     := 10;
  FFieldAlias       := '';
  FFieldName        := '';
  FFieldLength      := 10;
  FGroupOrder       := -1;
  FLinkable         := True;
  FMandatory        := False;
  FReportComponent  := nil;
  FReportLabel      := nil;
  FSelectable       := True;
  FSelectOrder      := -1;
  FSearchable       := True;
  FSearch           := False;
  FSearchOrder      := -1;
  FSelectedIndex    := -1;
  FShowAllValues    := False;
  FSortable         := True;
  FSort             := False;
  FSortExpression   := '';
  FSortOrder        := -1;
//  FSortOrderType    := soAscending;
  FTableAlias       := '';
  FTableName        := '';


  FAsFilter := False;
  FAutoSearchPanel  := nil;
  FCriteria := nil;
  FDataView := nil;
  FDelimiter := '';
  FirstField := False;
  FOnChange := nil;
  FParentControl := nil;
  FSearchOperator := soEqual;
  FWildCard := '';
  FEnabled := True;

  FLookupList := TppLookupList.Create;
  FValueList := TppSearchValueList.Create(Self);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.Destroy }

destructor TppAutoSearchField.Destroy;
begin

  FLookupList.Free;
  FLookupList := nil;

  FValueList.Free;
  FValueList := nil;

  inherited;
  
end;

{------------------------------------------------------------------------------}
{ TppAutoSearchField.Notify }

procedure TppAutoSearchField.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator = FCriteria) then
    FCriteria := nil
    
  else if (aCommunicator = FDataView) then
    FDataView := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.HasParent }

function TppAutoSearchField.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.Assign }

procedure TppAutoSearchField.Assign(aSource: TPersistent);
var
  lSource: TppAutoSearchField;
begin

  if (aSource is TppAutoSearchField) then
    begin
      lSource := TppAutoSearchField(aSource);

      FAlignment := lSource.Alignment;
      FFieldAlias := lSource.FieldAlias;
      FFieldName := lSource.FieldName;
      FFieldLength := lSource.FieldLength;
      FIsDetail := lSource.IsDetail;
      FLinkable := lSource.Linkable;
      FGroupOrder := lSource.GroupOrder;
      FDataType := lSource.DataType;
      FDisplayFormat := lSource.DisplayFormat;
      FDisplayWidth := lSource.DisplayWidth;
      FLogicalPrefix := lSource.FLogicalPrefix;
      FMandatory := lSource.Mandatory;
      Position  := lSource.Position;
      FSelectable := lSource.Selectable;
      FSelectOrder := lSource.SelectOrder;
      FSearchable := lSource.Searchable;
      FSearch := lSource.Search;
      FValueList.Assign(lSource.FValueList);
      FSearchOrder := lSource.SearchOrder;
      FShowAllValues := lSource.ShowAllValues;
      FSortable := lSource.Sortable;
      FSort := lSource.Sort;
      FSortOrder := lSource.SortOrder;
      FSortType := lSource.SortType;
      FSortExpression := lSource.SortExpression;
      FTableAlias := lSource.TableAlias;
      FTableName := lSource.TableName;

      FDelimiter := lSource.Delimiter;
      FSearchOperator := lSource.SearchOperator;
      WildCard := lSource.WildCard;

      if (lSource.FLookupList <> nil) then
        SetLookupList(lSource.FLookupList)
      else if (FLookupList <> nil) then
        FLookupList.Clear;

    end
  else
    inherited Assign(aSource);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.EqualTo }

function TppAutoSearchField.EqualTo(aSource: TppAutoSearchField): Boolean;
begin

  Result := (FAlignment = aSource.Alignment) and
            (FFieldAlias = aSource.FieldAlias) and
            (FFieldName = aSource.FieldName) and
            (FFieldLength = aSource.FieldLength) and
            (FIsDetail = aSource.IsDetail) and
            (FLinkable = aSource.Linkable) and
            (FGroupOrder = aSource.GroupOrder) and
            (FDataType = aSource.DataType) and
            (FDisplayFormat = aSource.DisplayFormat) and
            (FDisplayWidth = aSource.DisplayWidth) and
            (FLogicalPrefix = aSource.FLogicalPrefix) and
            (FMandatory = aSource.Mandatory) and
            (Position  = aSource.Position) and
            (FSelectable = aSource.Selectable) and
            (FSelectOrder = aSource.SelectOrder) and
            (FSearchable = aSource.Searchable) and
            (FSearch = aSource.Search) and
            (SearchExpression = aSource.SearchExpression) and
            (FSearchOrder = aSource.SearchOrder) and
            (FShowAllValues = aSource.ShowAllValues) and
            (FSortable = aSource.Sortable) and
            (FSort = aSource.Sort) and
            (FSortOrder = aSource.SortOrder) and
            (FSortType = aSource.SortType) and
            (FSortExpression = aSource.SortExpression) and
            (FTableAlias = aSource.TableAlias) and
            (FTableName = aSource.TableName) and
            (FDelimiter = aSource.Delimiter) and
            (FSearchOperator = aSource.SearchOperator) and
            (WildCard = aSource.WildCard);

end; {procedure, EqualTo}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.AssignSearchValuesFromField }

function TppAutoSearchField.AssignSearchValuesFromField(aAutoSearchField: TppAutoSearchField): Boolean;
begin

  Result := (SearchExpression <> aAutoSearchField.SearchExpression) or
            (ShowAllValues    <> aAutoSearchField.ShowAllValues);

  if Result then
    begin
      SearchExpression := aAutoSearchField.SearchExpression;
      ShowAllValues    := aAutoSearchField.ShowAllValues;
    end;

end; {function, AssignSearchValuesFromField}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.DoOnChange }

procedure TppAutoSearchField.DoOnChange;
begin

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  if Assigned(FOnChange) then FOnChange(Self);

end; {procedure, DoOnChange}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetMandatory }

procedure TppAutoSearchField.SetMandatory(aValue: Boolean);
begin

  if FMandatory = aValue then Exit;

  FMandatory := aValue;

  if (FMandatory) then
    FShowAllValues := False;

  DoOnChange;

end; {procedure, SetMandatory}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetShowAllValues }

procedure TppAutoSearchField.SetShowAllValues(aValue: Boolean);
begin

  if FShowAllValues = aValue then Exit;
  
  FShowAllValues := aValue;

  if (FShowAllValues) then
    FMandatory := False;

  DoOnChange;

end; {procedure, SetShowAllValues}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetFieldName }

procedure TppAutoSearchField.SetFieldName(const aFieldName: String);
begin

  {also set FieldAlias, if needed}
  if (FFieldName = FFieldAlias) then
    FFieldAlias := aFieldName;

  FFieldName:= aFieldName;

  PropertyChange;

  DoOnChange;

end; {procedure, SetFieldName}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetDataType }

procedure TppAutoSearchField.SetDataType(aDataType: TppDataType);
begin

  FDataType := aDataType;

end; {procedure, SetDataType}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetSearchExpression }

procedure TppAutoSearchField.SetSearchExpression(const aExpression: String);
begin

  if (csReading in ComponentState) then
    FValueList.CommaText := aExpression
  else if (FValueList.SearchExpression <> aExpression) then
    begin
      FValueList.SearchExpression := aExpression;

      PropertyChange;

      DoOnChange;

    end;


end; {procedure, SetSearchExpression}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetCriteria }

procedure TppAutoSearchField.SetCriteria(aCriteria: TComponent);
begin

  if (FCriteria <> nil) then
    TppCommunicator(FCriteria).RemoveNotify(Self);

  FCriteria := aCriteria;

  if (FCriteria <> nil) then
    TppCommunicator(FCriteria).AddNotify(Self)

end; {procedure, SetCriteria}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetDataView }

procedure TppAutoSearchField.SetDataView(aDataView: TComponent);
begin

  if (FDataView <> nil) then
    TppCommunicator(FDataView).RemoveNotify(Self);

  FDataView := aDataView;

  if (FDataView <> nil) then
    TppCommunicator(FDataView).AddNotify(Self)

end; {procedure, DataView}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetDataPipelineName }

procedure TppAutoSearchField.SetDataPipelineName(const aName: String);
begin

  FDataPipelineName := aName;

  DoOnChange;

end; {procedure, SetDataPipelineName}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetSearchOperator }

procedure TppAutoSearchField.SetSearchOperator(aOperator: TppSearchOperatorType);
begin

  FSearchOperator := aOperator;

  DoOnChange;

end; {procedure, SetSearchOperator}


{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetEnabled }

procedure TppAutoSearchField.DisableCriteria;
begin

  FEnabled := False;

  DoOnChange;

end; {procedure, SetEnabled}


{------------------------------------------------------------------------------}
{ TppAutoSearchField.GetValue }

function TppAutoSearchField.GetValue: Variant;
begin

  Result := GetValues(0);

end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.GetValues }

function TppAutoSearchField.GetValues(aIndex: Integer): Variant;
begin

  if (aIndex < FValueList.Count) then
    Result := FValueList.Values[aIndex]
  else
    Result := '';

  // apply wild card as needed
  if DataType in [dtString, dtChar, dtMemo] then
    if (Length(FWildCard) > 0) and (Pos(FWildCard, Result) = 0) then
      Result := Result + FWildCard;


end; {function, GetValues}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.GetValueCount }

function TppAutoSearchField.GetValueCount: Integer;
begin

  Result := FValueList.Count;

end; {function, GetValueCount}


{@TppAutoSearchField.FormatValue

 Formats an individual search criteria value.  Called by FormattedExpression.}

function TppAutoSearchField.FormatValue(aValue: String): String;
begin

  Result := aValue;

  if (DataType in [dtDate, dtDateTime]) and (Length(DisplayFormat) > 0) then
    Result := FormatDateTime(DisplayFormat, ppStrToDateTime(Result))

  else if (DataType in [dtInteger, dtLongint, dtSingle, dtDouble, dtExtended, dtCurrency]) then
    Result := ppFixUpFloatString(aValue, DisplayFormat)

  else if (DataType = dtBoolean) then
    begin
      if (Length(aValue) = 0) then
        Result := 'FALSE'

       else if ppCharInSet(UpperCase(aValue[1])[1], ['T', 'Y']) then
         Result := 'TRUE'

       else if (aValue[1] = '1') then
         Result := '1'

       else if (aValue[1] = '0') then
         Result := '0'

       else
         Result := 'FALSE';
    end;

  if (Length(FDelimiter) > 0) then
    Result := FDelimiter + Result + FDelimiter;

end; {function, FormatValue}


{@TppAutoSearchField.FormattedExpression

 This function formats the search criteria values.  Called by FilterString and
 SQLString.}

function TppAutoSearchField.FormattedExpression: String;
var
  liIndex: Integer;
begin

  Result := '';

  case FSearchOperator of

    soInList, soNotInList:
      begin
        if FAsFilter then
          begin
            for liIndex := 0 to FValueList.Count - 1 do
              begin
                if (FSearchOperator = soInList) then
                  begin
                    Result := Result + '(' + FieldName + '=' + FormatValue(FValueList.SubExpressions[liIndex]) + ')';

                    if (liIndex < FValueList.Count - 1) then
                      Result := Result + ' OR ';
                  end
                else
                  begin
                    Result := Result + '(' + FieldName + '<>' + FormatValue(FValueList.SubExpressions[liIndex]) + ')';

                    if (liIndex < FValueList.Count - 1) then
                      Result := Result + ' AND ';
                  end;
              end;
          end

        else
          begin
            for liIndex := 0 to FValueList.Count - 1 do
              begin
                Result := Result + FormatValue(FValueList.SubExpressions[liIndex]);

                if (liIndex < FValueList.Count - 1) then
                  Result := Result + ',';
              end;

            Result := '(' + Result + ')';
          end;

      end;

    soBetween, soNotBetween:
      begin

        if (FValueList.Count = 2) then
          begin

            if FAsFilter then
              begin
                if (FSearchOperator = soBetween) then
                  Result := '(' + FieldName + ' >= ' + FormatValue(FValueList.SubExpressions[0]) + ')' + ' AND ' + '(' + FieldName + ' <= ' + FormatValue(FValueList.SubExpressions[1]) + ')'
                else
                  Result := '(' + FieldName + ' < ' + FormatValue(FValueList.SubExpressions[0]) + ')' + ' OR ' + '(' + FieldName + ' > ' + FormatValue(FValueList.SubExpressions[1]) + ')'
              end

            else
              Result := FormatValue(FValueList.SubExpressions[0]) + ' AND ' + FormatValue(FValueList.SubExpressions[1]);

          end;

      end;

    soLike, soNotLike:
      begin
        if (Length(FWildCard) > 0) and (Pos(FWildCard, SearchExpression) = 0) then
          Result := SearchExpression + FWildCard;

        Result := FormatValue(Result);
      end;

    else
      begin
        Result := FormatValue(SearchExpression);
      end;
  end;


end; {function, FormattedExpression}


{@TppAutoSearchField.Description

 Returns a full description of the search condition contained in the
 AutoSearchField.  How the description begins depends upon the value of the
 FirstField property. A typical description: 'Show all data where the company
 name begins with 'T%'.  For an example of how to use the description, see the
 demo in the...RBuilder\\Demos\\AutoSearch\\6. Build Description of AutoSearch
 directory.}

function TppAutoSearchField.Description: String;
var
  lsHasAnyValue: String;
begin

  if (ShowAllValues) then
    begin
      lsHasAnyValue := ppLoadStr(1036)  {'has any value'};
      lsHasAnyValue := StringReplace(lsHasAnyValue, '.', '', []); // remove the period at the end
      Result := LogicalPrefixDescr + ' ' + FieldAlias + ' ' + lsHasAnyValue
    end
  else if FLookupList.HasNameValuePairs then
    Result := LogicalPrefixDescr + ' ' + FieldAlias + ' ' + OperatorDesc + ' ' + GetNameForSearchExpression(SearchExpression)
  else
    Result := LogicalPrefixDescr + ' ' + FieldAlias + ' ' + OperatorDesc + ' ' + SearchExpression;

end; {function, Description}

function TppAutoSearchField.GetNameForSearchExpression(aSearchExpression: String): String;
var
  lStringList: TStringList;
  liIndex: Integer;
begin
  lStringList := TStringList.Create;

  try

    if IsMultiValue then
      begin
        for liIndex := 0 to ValueCount - 1 do
          lStringList.Add(FLookupList.GetDisplayNameForValue(Values[liIndex]));
        Result := lStringList.CommaText;
      end
    else
      Result := FLookupList.GetDisplayNameForValue(SearchExpression);

  finally
    lStringList.Free;
  end;

end;


{@TppAutoSearchField.FilterString

 Returns the search criteria in a format appropriate for use in a
 Table.Filter property.}

function TppAutoSearchField.FilterString: String;
begin
  FAsFilter := True;

  if (FSearchOperator in [soInList, soNotInList, soBetween, soNotBetween]) then
    Result := '(' + FormattedExpression + ')'
  else
    Result := '(' + FieldName + ' ' + OperatorAsString + ' ' + FormattedExpression + ')';

  FAsFilter := False;
end; {function, FilterString}

function TppAutoSearchField.GetDateTimeFormat: String;
var
  ldDate: TDateTime;
//  liDefaultLCID: Integer;
//  lsShortDateformat: String;
//  lsShortTimeFormat: String;
begin
//  liDefaultLCID := GetThreadLocale;
//  lsShortDateformat := GetLocaleStr(liDefaultLCID, LOCALE_SSHORTDATE, 'm/d/yy');
//  lsShortTimeFormat := GetLocaleStr(liDefaultLCID, LOCALE_STIMEFORMAT, 'h:mm tt');
//  lsShortTimeFormat := StringReplace(ShortTimeFormat, 'AMPM', 'tt', []);


  // use display format, if specified
{  if (FDisplayFormat <> '') then
    Result := FDisplayFormat

  // use datatype to derive a format
  else} if FValueList.Count = 0 then
    begin
      if (FDataType = dtTime) then
        Result := LongTimeFormat
      else //if (FDataType = dtDate) then
        Result := ShortDateFormat
//      else
//        aField.DisplayFormat := ShortDateFormat + ' ' +  ShortTimeFormat

    end
  else // use search value to derive a format
    begin
      ldDate := Value;

      Result := GetDateTimeFormat(ldDate);

    end;


end;

function TppAutoSearchField.GetDateTimeFormat(aValue: TDateTime): String;
var
  lbDate: Boolean;
  lbTime: Boolean;
//  liDefaultLCID: Integer;
//  lsShortDateformat: String;
//  lsShortTimeFormat: String;
begin
//  liDefaultLCID := GetThreadLocale;
//  lsShortDateformat := GetLocaleStr(liDefaultLCID, LOCALE_SSHORTDATE, 'm/d/yy');
//  lsShortTimeFormat := GetLocaleStr(liDefaultLCID, LOCALE_STIMEFORMAT, 'h:mm tt');
//  lsShortTimeFormat := StringReplace(ShortTimeFormat, 'AMPM', 'tt', []);

  // use display format, if specified
{  if (FDisplayFormat <> '') then
    Result := FDisplayFormat

  else} // use search value to derive a format
    begin
      lbDate := (Int(aValue) > 0);
      lbTime := (Frac(aValue) > 0);

      if lbDate and lbTime then
         Result := ShortDateFormat + ' ' +  LongTimeFormat
      else if lbDate then
         Result := ShortDateFormat
      else // lbTime
        Result := LongTimeFormat

    end;


end;

function TppAutoSearchField.GetGroupDescription: String;
begin

  if (FDataView = nil) then
    Result := ''
  else
    Result := ppGetStringPropValue(FDataView, 'Description');

end;

function TppAutoSearchField.GetHasLookupList: Boolean;
begin
  Result := (FLookupList <> nil) and (FLookupList.Count > 0);
end;

function TppAutoSearchField.GetLookupSettings: TppLookupSettings;
begin
  Result := FLookupList.LookupSettings;
end;

function TppAutoSearchField.GetSearchExpression: String;
begin

  if (csWriting in ComponentState) then
    Result := FValueList.CommaText
  else
    Result := FValueList.SearchExpression

end;

function TppAutoSearchField.GetSubExpressions(Index: Integer): String;
begin
  Result := FValueList.SubExpressions[Index];
end;

procedure TppAutoSearchField.Initialize;
begin
  FLookupList.BuildList;
end;

function TppAutoSearchField.IsMultiValue: Boolean;
begin

  Result := (FSearchOperator in [soInList, soNotInList, soBetween, soNotBetween]);

end;

{@TppAutoSearchField.LogicalPrefixDescr

  Returns a description of the logical prefix used to build the
  auto search description displayed by the AutoSearchPanels.

  Examples:

    - 'Show all data values where the'
    - 'and the'
    - 'or the'

}
function TppAutoSearchField.LogicalPrefixDescr: string;
begin

  if (FirstField) then
    Result := ppLoadStr(54) {Show all data where the}
  else if (loOr in FLogicalPrefix) then
    Result := ppLoadStr(1094)
  else // (loAnd in FLogicalPrefix) then
    Result := ppLoadStr(55) {and the}


end;


{@TppAutoSearchField.SQLString

 Returns the search criteria in a format appropriate for use in an SQL 'WHERE'
 clause.}

function TppAutoSearchField.SQLString: String;
begin
  Result := TableName + '.' + FieldName + ' ' + OperatorAsString + ' ' + FormattedExpression;
end; {function, SQLString}


{@TppAutoSearchField.Valid

 Indicates whether a SearchExpression has been assigned to the field.  Only
 valid AutoSearch fields should be used when building a Table.Filter or SQL
 'WHERE' clause.}

function TppAutoSearchField.Valid: Boolean;
begin
  Result := not(ShowAllValues) and (Length(SearchExpression) > 0);
end; {function, Valid}


{@TppAutoSearchField.OperatorAsString

 Converts the SearchOperator setting to a value which can be used in a search
 expression.  For example, soGreaterThan is converted to '>'.}

function TppAutoSearchField.OperatorAsString: String;
begin

  if (FAsFilter) then
    case FSearchOperator of
      soEqual:                Result := '=';
      soNotEqual:             Result := '<>';
      soLessThan:             Result := '<';
      soLessThanOrEqualTo:    Result := '<=';
      soGreaterThan:          Result := '>';
      soGreaterThanOrEqualTo: Result := '>=';
      soLike:                 Result := '=';
      soNotLike:              Result := '<>';
      soBetween:              Result := '';
      soNotBetween:           Result := '';
      soInList:               Result := '';
      soNotInList:            Result := '';
      soBlank:                Result := '';
      soNotBlank:             Result := '';
    else
      Result := '=';
    end

  else
    case FSearchOperator of
      soEqual:                Result := '=';
      soNotEqual:             Result := '<>';
      soLessThan:             Result := '<';
      soLessThanOrEqualTo:    Result := '<=';
      soGreaterThan:          Result := '>';
      soGreaterThanOrEqualTo: Result := '>=';
      soLike:                 Result := 'LIKE';
      soNotLike:              Result := 'NOT LIKE';
      soBetween:              Result := 'BETWEEN';
      soNotBetween:           Result := 'NOT BETWEEN';
      soInList:               Result := 'IN';
      soNotInList:            Result := 'NOT IN';
      soBlank:                Result := 'IS NULL';
      soNotBlank:             Result := 'IS NOT NULL';
    else
      Result := '=';
    end;

end; {procedure, OperatorAsString}


{@TppAutoSearchField.OperatorDesc

 Returns a description of the SearchOperator.  The description is displayed in
 the OperatorLabel of the  AutoSearchPanels.}

function TppAutoSearchField.OperatorDesc: String;
begin

  case FSearchOperator of
    soEqual:
      begin
        if DataType in [dtDate, dtTime, dtDateTime] then
          Result := ppLoadStr(92) {'is'}
        else
          Result := ppLoadStr(93) {'is equal to'}
      end;

    soNotEqual:
      begin
        if DataType in [dtDate, dtTime, dtDateTime] then
          Result := ppLoadStr(94) {'is not'}
        else
          Result := ppLoadStr(95) {'is not equal to'}
      end;

    soLessThan:
      begin
        if DataType in [dtDate, dtTime, dtDateTime] then
          Result := ppLoadStr(96) {'is before'}
        else
          Result := ppLoadStr(97); {'is less than'}
      end;

    soLessThanOrEqualTo:
      begin
        if DataType in [dtDate, dtTime, dtDateTime] then
          Result := ppLoadStr(98) {'is on or before'}
        else
          Result := ppLoadStr(99) {'is less than or equal to'}
      end;

    soGreaterThan:
      begin
        if DataType in [dtDate, dtTime, dtDateTime] then
          Result := ppLoadStr(100) {'is after'}
        else
          Result := ppLoadStr(1000); {'is greater than'}
      end;

    soGreaterThanOrEqualTo:
      begin
        if DataType in [dtDate, dtTime, dtDateTime] then
          Result := ppLoadStr(1001) {'is on or after'}
        else
          Result := ppLoadStr(1002); {'is greater than or equal to'}
      end;

    soLike: Result := ppLoadStr(1003); {'begins with'}
    soNotLike: Result := ppLoadStr(1004); {'does not begin with'}
    soBetween: Result := ppLoadStr(1005); {'is between'}
    soNotBetween: Result := ppLoadStr(1006); {'is not between'}
    soInList: Result := ppLoadStr(1007); {'matches one of the values in this list'}
    soNotInList: Result := ppLoadStr(1027); {'does not match any of the values in this list'}
    soBlank: Result := ppLoadStr(1008); {'is blank'}
    soNotBlank: Result := ppLoadStr(1009); {'is not blank'}

  else
    Result := ppLoadStr(93); {'is equal to'}
  end;

end; {procedure, OperatorDesc}

{@TppAutoSearchField.SetLookupList}

procedure TppAutoSearchField.SetLookupList(const aLookupList: TppLookupList);
begin
  FLookupList.Assign(aLookupList);

end;

procedure TppAutoSearchField.SetLookupSettings(const Value: TppLookupSettings);
begin
  FLookupList.LookupSettings := Value;
end;


{******************************************************************************
*
*  A U T O   S E A R C H   G R O U P S
*
******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroups.GetGroupForIndex }

function TppAutoSearchGroups.GetGroupForIndex(aIndex: Integer): TppAutoSearchGroup;
begin
  if (aIndex < Count) then
    Result := TppAutoSearchGroup(Children[aIndex])
  else
    Result := nil;

end; {function, GetGroupForIndex}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.AssignAutoSearchFields

  Copies the AutoSearchField from the specified aAutoSearchFields list.}

procedure TppAutoSearchGroups.AssignAutoSearchFields(aAutoSearchFields: TList);
var
  liIndex: Integer;
  lAutoSearchField: TppAutoSearchField;
begin
  FreeChildren;

  for liIndex := 0 to aAutoSearchFields.Count-1 do
    begin
      lAutoSearchField := TppAutoSearchField(aAutoSearchFields[liIndex]);
      AddAutoSearchField(lAutoSearchField);
    end;

end; {procedure, AssignAutoSearchFields}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.AddAutoSearchField

  Copies a specified AutoSearchField.}

procedure TppAutoSearchGroups.AddAutoSearchField(aAutoSearchField: TppAutoSearchField);
var
  lDataView: TPersistent;
  lGroup: TppAutoSearchGroup;
  lsDescription: String;
  liTabOrder: Integer;
begin

  lDataView := TPersistent(aAutoSearchField.DataView);

  if (lDataView = nil) then
    begin
      lsDescription := '';
      liTabOrder := 0;
    end
  else
    begin
      lsDescription := ppGetStringPropValue(lDataView, 'Description');
      liTabOrder := ppGetOrdPropValue(lDataView, 'AutoSearchTabOrder');
    end;

  lGroup := AddGroup(lsDescription);
  lGroup.TabOrder := liTabOrder;

  lGroup.AddField(aAutoSearchField);

end; {procedure, AddAutoSearchField}

procedure TppAutoSearchGroups.AddAutoSearchField(aGroupDescription, aFieldName, aSearchExpression: String; aShowAllValues: Boolean);
var
  lAutoSearchField: TppAutoSearchField;
  lGroup: TppAutoSearchGroup;
begin

  lGroup := GetGroupForDescription(aGroupDescription);

  if (lGroup = nil) then
    lGroup := AddGroup(aGroupDescription);

  lAutoSearchField := TppAutoSearchField.Create(nil);

  lAutoSearchField.FieldName := aFieldName;
  lAutoSearchField.SearchExpression := aSearchExpression;
  lAutoSearchField.ShowAllValues := aShowAllValues;

  lGroup.AddField(lAutoSearchField);

end; {procedure, AddAutoSearchFieldForParams}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.AddGroup

  Adds a new TppAutoSearchGroup object with the specified description and
  returns a reference to the new object.}

function TppAutoSearchGroups.AddGroup(aDescription: String): TppAutoSearchGroup;
var
  liGroup: Integer;
begin

  liGroup := IndexOfDescription(aDescription);

  if (liGroup >= 0) then
    Result := GetGroupForIndex(liGroup)
  else
    begin
      Result := TppAutoSearchGroup.Create(Self);
      Result.Parent := Self;
      Result.Description := aDescription;
    end;

end; {function, AddGroup}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.Clear

  Clears all items in the Groups array.}

procedure TppAutoSearchGroups.Clear;
var
  liGroup: Integer;
begin

  for liGroup := Count-1 downto 0  do
    Groups[liGroup].Free;
//    Groups[liGroup].Clear;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.GetAllFields

  Iterates through the AutoSearchGroups structure and adds a reference for
  each of the autosearch fields to the aAutoSearchFields list.}

procedure TppAutoSearchGroups.GetAllFields(aAutoSearchFields: TList);
var
  liField: Integer;
  liGroup: Integer;
  lGroup: TppAutoSearchGroup;
begin

  aAutoSearchFields.Clear;

  for liGroup := 0 to Count-1 do
    begin
      lGroup := Groups[liGroup];

      for liField := 0 to lGroup.FieldCount-1 do
        aAutoSearchFields.Add(lGroup.Fields[liField]);

    end;

end; {function, GetAllFields}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.GetGroupForField

  Returns a reference to the TppAutoSearchGroup object associated with the
  specified AutoSearchField.}

function TppAutoSearchGroups.GetGroupForField(aAutoSearchField: TppAutoSearchField): TppAutoSearchGroup;
var
  lDataView: TObject;
  lsDescription: String;
begin

  lDataView := aAutoSearchField.DataView;

  if (lDataView <> nil) then
    lsDescription := ''
  else
    lsDescription := ppGetStringPropValue(lDataView, 'Description');

  Result := GetGroupForDescription(lsDescription);

end; {procedure, GetGroupForField}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.GetGroupForDescription

  Returns a reference to the TppAutoSearchGroup object corresponding to the
  specified description.}

function TppAutoSearchGroups.GetGroupForDescription(aDescription: String): TppAutoSearchGroup;
var
  liGroup: Integer;
begin
  liGroup := IndexOfDescription(aDescription);

  if (liGroup >= 0) then
    Result := GetGroupForIndex(liGroup)
  else
    Result := nil;

end; {function, GetGroupForDescription}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.HasMandatoryField

  Indicates whether the any AutoSearchFields have their Mandatory property value
  set to True.}

function TppAutoSearchGroups.HasMandatoryField: Boolean;
var
  liFieldIndex: Integer;
  liGroupIndex: Integer;
  lGroup: TppAutoSearchGroup;
begin

  Result := False;

  liGroupIndex := 0;

  while not(Result) and (liGroupIndex < Count) do
    begin

      lGroup := Groups[liGroupIndex];

      liFieldIndex := 0;

      while not(Result) and (liFieldIndex < lGroup.FieldCount) do
        begin

          if lGroup.Fields[liFieldIndex].Mandatory then
            Result := True
          else
            Inc(liFieldIndex);

        end;

      Inc(liGroupIndex);

    end;

end;

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.IndexOfDescription

  Returns the Groups array Index for a specified description.}

function TppAutoSearchGroups.IndexOfDescription(aDescription: String): Integer;
var
  liIndex: Integer;
begin

  liIndex := 0;
  Result := -1;

  while (Result < 0) and (liIndex < Count) do
    begin
      if Groups[liIndex].Description = aDescription then
        Result := liIndex
      else
        Inc(liIndex);
    end;

end; {procedure, IndexOfDescription}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroups.CompareStructure }

function TppAutoSearchGroups.CompareStructure(aSource: TppAutoSearchGroups): Boolean;
var
  liIndex: Integer;
  lGroup: TppAutoSearchGroup;
  lSourceGroup: TppAutoSearchGroup;
begin

  Result := (aSource <> nil) and (aSource.Count = Count);

  liIndex := 0;

  while Result and (liIndex < Count) do
    begin
      lGroup := Groups[liIndex];

      lSourceGroup := aSource.GetGroupForDescription(lGroup.Description);

      if lSourceGroup = nil then
        Result := False
      else
        Result := (lGroup.Description = lSourceGroup.Description) and
                lGroup.CompareStructure(lSourceGroup);

      Inc(liIndex);

    end;

end; {function, CompareStructure}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.Assign

  Copies each of the AutoSearchGroup objects in aSource.}

procedure TppAutoSearchGroups.Assign(aSource: TPersistent);
begin

  if (aSource is TppAutoSearchGroups) then
    AssignGroups(TppAutoSearchGroups(aSource))
  else
    inherited Assign(aSource);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.AssignGroups

  Copies each of the AutoSearchGroup objects in aSource.}

procedure TppAutoSearchGroups.AssignGroups(aSource: TppAutoSearchGroups);
var
  liIndex: Integer;
  lGroup: TppAutoSearchGroup;
  lSourceGroup: TppAutoSearchGroup;
begin

  FreeChildren;

  for liIndex := 0 to aSource.Count-1 do
    begin
      lSourceGroup := aSource[liIndex];

      lGroup := TppAutoSearchGroup.Create(nil);

      lGroup.Assign(lSourceGroup);

      lGroup.Parent := Self;

    end;

end; {procedure, AssignGroups}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.EqualTo

  Returns True, if aSource contains equivalent TppAutoSearchGroup objects.}

function TppAutoSearchGroups.EqualTo(aSource: TppAutoSearchGroups): Boolean;
var
  liIndex: Integer;
  lGroup: TppAutoSearchGroup;
  lSourceGroup: TppAutoSearchGroup;
begin

  Result := (aSource <> nil) and (aSource.Count = Count);

  liIndex := 0;

  while Result and (liIndex < Count) do
    begin
      lGroup := Groups[liIndex];

      lSourceGroup := aSource.GetGroupForDescription(lGroup.Description);

      if (lSourceGroup = nil) then
        Result := False
      else
        Result :=  lGroup.EqualTo(lSourceGroup);

      Inc(liIndex);

    end;

end; {function, EqualTo}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroups.AssignSearchValuesFromGroups

  Assigns the auto search values from aSource.}

function TppAutoSearchGroups.AssignSearchValuesFromGroups(aSource: TppAutoSearchGroups): Boolean;
var
  lbValueChange: Boolean;
  liIndex: Integer;
  lGroup: TppAutoSearchGroup;
  lSourceGroup: TppAutoSearchGroup;
begin

  Result := False;

  for liIndex := 0 to Count-1 do
    begin
      lGroup := Groups[liIndex];

      lSourceGroup := aSource.GetGroupForDescription(lGroup.Description);

      if (lGroup <> nil) then
        begin
          lbValueChange := lGroup.AssignSearchValuesFromGroup(lSourceGroup);

          if lbValueChange then
            Result := True;
        end;

    end;

end; {procedure, AssignSearchValuesFromGroups}


{******************************************************************************
*
*  A U T O   S E A R C H   G R O U P
*
******************************************************************************}

destructor TppAutoSearchGroup.Destroy;
var
  lDataView: TObject;
begin

  {if dataview is present, then update AutoSearchTabOrder}
  lDataView := GetDataView;

  if (lDataView <> nil) then
    ppSetOrdPropValue(lDataView, 'AutoSearchTabOrder', TabOrder);

  {free or remove fields as needed - can only free the fields that do not
   belong to the report.}
  Clear;
//  FreeChildren;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroup.Notify}

procedure TppAutoSearchGroup.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
var
  lbDone: Boolean;
  liIndex: Integer;
begin

  inherited Notify(aCommunicator, aOperation);

  if not(csDestroying in ComponentState) and (aOperation = ppopRemove) then
    begin

      liIndex := 0;
      lbDone := False;

      while (liIndex < ChildCount) and not(lbDone) do
        begin
          if (aCommunicator = Children[liIndex]) then
            begin
              RemoveChild(TppRelative(aCommunicator));

              lbDone := True;
            end;
//            raise EReportBuilderError.Create('TppAutoSearchGroup.Notify: Cannot free a child autosearch field.');

          Inc(liIndex);
        end;
    end;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroup.GetFieldForIndex }

function TppAutoSearchGroup.GetFieldForIndex(aIndex: Integer): TppAutoSearchField;
begin
  Result := TppAutoSearchField(Children[aIndex]);

end; {procedure, GetFieldForIndex}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroup.GetFieldForName }

function TppAutoSearchGroup.GetFieldForName(aFieldName: String): TppAutoSearchField;
var
  liIndex: Integer;
  lField: TppAutoSearchField;
begin
  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < FieldCount) do
    begin
      lField := TppAutoSearchField(Children[liIndex]);

      if lField.FieldName = aFieldName then
        Result := lField
      else
        Inc(liIndex);
    end;

end; {procedure, GetFieldForName}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroup.AddField

  Adds an item to the AutoSearchFields array.}

procedure TppAutoSearchGroup.AddField(aAutoSearchField: TppAutoSearchField);
begin
//  aAutoSearchField.Parent := Self;
  AddChild(aAutoSearchField);
  AddNotify(aAutoSearchField);
end; {procedure, AddField}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroup.Clear

  Removes all items from the AutoSearchFields array and destroys the fields for
  which this group is the parent.}

procedure TppAutoSearchGroup.Clear;
var
  liIndex: Integer;
  lField: TppAutoSearchField;
begin

  {free fields or remove them if they are part the report}
  for liIndex := FieldCount-1 downto 0 do
    begin
      lField := GetFieldForIndex(liIndex);

      if (lField.Parent = Self) then
        lField.Free
      else
        begin
          RemoveChild(lField);

          RemoveNotify(lField);
        end;

    end;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroup.GetDataView}

function TppAutoSearchGroup.GetDataView: TObject;
begin

  if FieldCount > 0 then
    Result := Fields[0].DataView
  else
    Result := nil;

end; {function, GetDataView}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroup.Assign

  Creates a copy of each AutoSearchGroup field in the source AutoSearchGroup.}

procedure TppAutoSearchGroup.Assign(aSource: TPersistent);
begin

  if (aSource is TppAutoSearchGroup) then
    AssignGroup(TppAutoSearchGroup(aSource))
  else
    inherited Assign(aSource);

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroup.AssignGroup

  Creates a copy of each AutoSearchGroup field in the source AutoSearchGroup.}

procedure TppAutoSearchGroup.AssignGroup(aSource: TppAutoSearchGroup);
var
  liIndex: Integer;
  lField: TppAutoSearchField;
  lSourceField: TppAutoSearchField;
begin

  FDescription := aSource.Description;
  FTabOrder := aSource.TabOrder;

  FreeChildren;

  for liIndex := 0 to aSource.FieldCount-1 do
    begin
      lSourceField := aSource.Fields[liIndex];

      lField := TppAutoSearchField.Create(nil);

      lField.Assign(lSourceField);

      lField.Parent := Self;

      lField.AddNotify(Self);
    end;

end; {procedure, AssignGroup}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroup.EqualTo

  Returns true if each aSource contains equivalent auto search field objects.}

function TppAutoSearchGroup.EqualTo(aSource: TppAutoSearchGroup): Boolean;
var
  lField: TppAutoSearchField;
  liIndex: Integer;
  lSourceField: TppAutoSearchField;
begin

  Result := (aSource <> nil) and (aSource.FieldCount = FieldCount) and
            (aSource.Description = Description);

  liIndex := 0;

  while Result and (liIndex < FieldCount) do
    begin
      lField := Fields[liIndex];

      lSourceField := aSource.FieldsByName[lField.FieldName];

      Result := lField.EqualTo(lSourceField);

      Inc(liIndex);

    end;

end; {function, EqualTo}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroup.CompareStructure }

function TppAutoSearchGroup.CompareStructure(aSource: TppAutoSearchGroup): Boolean;
var
  lField: TppAutoSearchField;
  liIndex: Integer;
  lSourceField: TppAutoSearchField;
begin

 Result := (aSource <> nil) and (aSource.FieldCount = FieldCount) and
            (aSource.Description = Description);

  liIndex := 0;

  while Result and (liIndex < FieldCount) do
    begin
      lField := Fields[liIndex];

      lSourceField := aSource.GetFieldForNameAndOperator(lField.FieldName, lField.SearchOperator);

      Result := (lSourceField <> nil);

      Inc(liIndex);

    end;

end; {function, CompareStructure}

{------------------------------------------------------------------------------}
{ TppAutoSearchGroup.AssignSearchValuesFromGroup }

function TppAutoSearchGroup.AssignSearchValuesFromGroup(aSource: TppAutoSearchGroup): Boolean;
var
  lbValueChange: Boolean;
  lField: TppAutoSearchField;
  liIndex: Integer;
  lSourceField: TppAutoSearchField;
begin

  Result := False;
  lbValueChange := False;

  for liIndex := 0 to FieldCount-1 do
    begin
      lField := Fields[liIndex];

      lSourceField := aSource.Fields[liIndex];

      if (lField.FieldName <> lSourceField.FieldName) or
         (lField.SearchOperator <> lSourceField.SearchOperator) then
        lSourceField := aSource.GetFieldForNameAndOperator(lField.FieldName, lField.SearchOperator);

      if (lSourceField <> nil) then
        lbValueChange := lField.AssignSearchValuesFromField(lSourceField);

      if lbValueChange then
        Result := True;

    end;

end; {procedure, AssignSearchValuesFromGroup}

{------------------------------------------------------------------------------}
{@TppAutoSearchGroup.GetFieldForNameAndOperator

  Returns a reference to the AutoSearchField corresponding to a specified
  field name and search operator.}

function TppAutoSearchGroup.GetFieldForNameAndOperator(aFieldName: String; aSearchOperator: TppSearchOperatorType): TppAutoSearchField;
var
  lField: TppAutoSearchField;
  liIndex: Integer;
begin

  Result := nil;

  liIndex := 0;

  while (Result = nil) and (liIndex < FieldCount) do
    begin
      lField := Fields[liIndex];
      
      if (lField.FieldName = aFieldName) and (lField.SearchOperator = aSearchOperator) then
        Result := lField
      else
        Inc(liIndex);

    end;

end;


{******************************************************************************
 *
 ** D A T E   F O R M A T
 *
{******************************************************************************}

{$IFNDEF Delphi7}
procedure TppDateFormat.GetLocaleFormatSettings(aLCID: Integer; var aFormatSettings: TFormatSettings);
begin
  aFormatSettings.DateSeparator := SysUtils.DateSeparator;
  aFormatSettings.ShortDateFormat := SysUtils.ShortDateFormat;
end;

function TppDateFormat.FormatDateTime(const aFormat: String; const aDateTime: TDateTime; const aFormatSettings: TFormatSettings): String;
begin
  Result := SysUtils.FormatDateTime(aFormat, aDateTime);
end;

function TppDateFormat.DateToStr(const aDateTime: TDateTime; const aFormatSettings: TFormatSettings): string;
begin
  Result := SysUtils.DateToStr(aDateTime);
end;

function TppDateFormat.StrToDate(const aDateString: string; const aFormatSettings: TFormatSettings): TDateTime;
begin
  Result := SysUtils.StrToDate(aDateString);
end;

{$ENDIF}

constructor TppDateFormat.Create;
begin

  inherited;

  GetLocaleFormatSettings(GetThreadLocale, FFormatSettings);

  Initialize(FFormatSettings);

end;


function TppDateFormat.FormatValue(aDate: TDateTime): string;
begin

  Result := DateToStr(aDate, FFormatSettings);

end;

function TppDateFormat.GetFormatString: String;
begin

  case FFormatType of
    dfMDY:
      Result := 'MM' + FDateSeparator + 'dd' + FDateSeparator + 'yyyy';
    dfDMY:
      Result := 'dd' + FDateSeparator + 'MM' + FDateSeparator + 'yyyy';
    dfYMD:
      Result := 'yyyy' + FDateSeparator +'MM' + FDateSeparator + 'dd';

  end;

end;



function TppDateFormat.GetYUIMonthNamesLong: string;
var
  ldDate: TDateTime;
  liIndex: Integer;
  lsMonthsOfYear: String;
begin

  ldDate := EncodeDate(2007,1,1);

  lsMonthsOfYear := '[';

  for liIndex := 0 to 11 do
    begin

      lsMonthsOfYear := lsMonthsOfYear + '"' + FormatDateTime('mmmm', ldDate, FFormatSettings) + '"';

      if liIndex < 11 then
        lsMonthsOfYear := lsMonthsOfYear + ','
      else
        lsMonthsOfYear := lsMonthsOfYear + ']';

      ldDate := IncMonth(ldDate);

    end;

  Result := lsMonthsOfYear;

end;

function TppDateFormat.GetYUIWeekDaysShort: string;
var
  ldDate: TDateTime;
  liIndex: Integer;
  lsDaysofWeek: String;
  lsDayName: String;
begin

  ldDate := EncodeDate(2008,01,06);

  lsDaysofWeek := '[';

  for liIndex := 0 to 6 do
    begin

      lsDayName := FormatDateTime('ddd', ldDate, FFormatSettings);
      lsDayName := Copy(lsDayName, 1, 2);

      lsDaysofWeek := lsDaysofWeek + '"' + lsDayName + '"';

      if liIndex < 6 then
        lsDaysofWeek := lsDaysofWeek + ','
      else
        lsDaysofWeek := lsDaysofWeek + ']';

      ldDate := IncDay(ldDate);

    end;

  Result := lsDaysOfWeek;

end;

procedure TppDateFormat.Initialize(aFormatSettngs: TFormatSettings);
var
  lStrings: TStringList;
  lsFormatType: String;
  liFormatType: Integer;
begin

  FFormatSettings := aFormatSettngs;

  FDateSeparator := FFormatSettings.DateSeparator;

  lStrings := TStringList.Create;
  lStrings.Delimiter := FDateSeparator;
  lStrings.DelimitedText := FFormatSettings.ShortDateFormat;

  // build string: mdy, dmy, ymd
  if (lStrings.Count >= 3) then
    FFormatTypeAsString := LowerCase(lStrings[0][1] + lStrings[1][1] + lStrings[2][1])
  else
    FFormatTypeAsString := 'mdy';

  lsFormatType := 'df' + UpperCase(FFormatTypeAsString);

  liFormatType := ppGetEnumValue(TypeInfo(TppDateFormatType), lsFormatType);

  if (liFormatType < 3) then
    FFormatType := TppDateFormatType(liFormatType)
  else
    FFormatType := dfMDY;

  lStrings.Free;

end;

function TppDateFormat.Parse(aDateString: String): TDateTime;
begin
  Result := StrToDate(aDateString, FFormatSettings);
end;

{******************************************************************************
 *
 ** S E A R C H   V A L U E   L I S T
 *
{******************************************************************************}

constructor TppSearchValueList.Create(aField: TppAutoSearchField);
begin
  inherited Create;

  FField := aField;

end;

{******************************************************************************
 *
 ** S E A R C H   V A L U E   L I S T
 *
{******************************************************************************}

constructor TppSearchValueList.Create(aParameter: TComponent);
begin
  inherited Create;

  FParameter := aParameter;

end;

function TppSearchValueList.ConvertFromDataType(aValue: Variant): String;
begin

  Result := '';

  case DataType of
    dtString, dtChar, dtMemo:
      Result := aValue;

    dtDate, dtTime, dtDateTime:
      Result := FormatDateTime(GetDateTimeFormat(), aValue);

    dtInteger, dtLongint:
      Result := IntToStr(aValue);

    dtCurrency:
      Result := CurrToStr(aValue);

    dtSingle, dtDouble, dtExtended:
      Result := FloatToStr(aValue);

    dtBoolean:
      if (Length(aValue) > 0) and ppCharInSet(UpperCase(aValue)[1], ['T', 'Y', '1']) then
        Result := 'True'
      else
        Result := 'False';

   end;


end;

function TppSearchValueList.ConvertToDataType(aIndex: Integer): Variant;
var
  lsValue: String;
  lcDecimalSep: Char;
  lcThousandSep: Char;
  lDateTime: TDateTime;
begin
  Result := '';

  lsValue := Self[aIndex];

  if (lsValue = '') then Exit; // backward compatibility

  lcDecimalSep := DecimalSeparator;
  lcThousandSep := ThousandSeparator;

  DecimalSeparator := '.';
  ThousandSeparator := ',';

  try

    if DataType in [dtString, dtChar, dtMemo] then
      begin
        Result := lsValue;
      end
    else
      begin
        lsValue := ppRemoveCharacter(ThousandSeparator, lsValue);

        case DataType of
          dtDate, dtTime, dtDateTime:
            begin
              lDateTime := StrToFloatDef(lsValue, 0.0);
              Result := lDateTime;
            end;

          dtInteger, dtLongint:
            Result := StrToIntDef(lsValue, 0);

          dtCurrency:
            Result := StrToCurrDef(lsValue, 0.0);

          dtSingle, dtDouble, dtExtended:
            Result := StrToFloatDef(lsValue, 0.0);

          dtBoolean:
             Result := (Length(lsValue) > 0) and ppCharInSet(UpperCase(lsValue)[1], ['T', 'Y', '1']);

         end;

    end;

  finally
    DecimalSeparator := lcDecimalSep;
    ThousandSeparator := lcThousandSep;
  end;

end;

function TppSearchValueList.GetDataType: TppDataType;
begin
  if (FField <> nil) then
    Result := FField.DataType
  else if (FParameter <> nil) then
    Result := TppParameter(FParameter).DataType
  else
    Result := dtString;
    
end;

function TppSearchValueList.GetDateTimeFormat: String;
begin
  if (FField <> nil) then
    Result := FField.GetDateTimeFormat
  else
    Result := '';
end;

function TppSearchValueList.GetDateTimeFormat(aValue: TDateTime): String;
var
  lbDate: Boolean;
  lbTime: Boolean;
//  liDefaultLCID: Integer;
//  lsShortDateformat: String;
//  lsShortTimeFormat: String;
begin
//  liDefaultLCID := GetThreadLocale;
//  lsShortDateformat := GetLocaleStr(liDefaultLCID, LOCALE_SSHORTDATE, 'm/d/yy');
//  lsShortTimeFormat := GetLocaleStr(liDefaultLCID, LOCALE_STIMEFORMAT, 'h:mm tt');
//  lsShortTimeFormat := StringReplace(ShortTimeFormat, 'AMPM', 'tt', []);

  // use display format, if specified
{  if (DateTimeFormat <> '') then
    Result := DateTimeFormat

  else} // use search value to derive a format
    begin
      lbDate := (Int(aValue) > 0);
      lbTime := (Frac(aValue) > 0);

      if lbDate and lbTime then
         Result := ShortDateFormat + ' ' + LongTimeFormat
      else if lbDate then
         Result := ShortDateFormat
      else // lbTime
        Result := LongTimeFormat
    end;
  

end;

function TppSearchValueList.GetIsMultiValue: Boolean;
begin
  if (FField <> nil) then
    Result := FField.IsMultiValue
  else if (FParameter <> nil) then
    Result := TppParameter(FParameter).AutoSearchSettings.IsMultiValue
  else
    Result := False;

end;

function TppSearchValueList.GetSearchExpression: string;
begin

  if (Text = '') then
    Result := Text

  else if (DataType in [dtDateTime, dtDate, dtTime]) then
    Result := GetSearchExpressionForDateTime()

  else if (DataType in [dtInteger, dtLongint, dtSingle, dtDouble, dtExtended, dtCurrency])  then
    Result := GetSearchExpressionForNumeric()

  else if IsMultiValue then
    Result := CommaText

  else
    Result := SubExpressions[0];

end;

function TppSearchValueList.GetSearchExpressionForDateTime: string;
var
  liIndex: Integer;
  lDateTime: Double;
  lSaveDecimalSeparator: Char;
begin

  Result := '';

  if (DataType in [dtDateTime, dtDate, dtTime]) and (Text <> '') then
    begin
      lSaveDecimalSeparator := DecimalSeparator;

      DecimalSeparator := '.';


      try

        for liIndex := 0 to Count - 1 do
          begin
            if (liIndex > 0) then
              Result := Result + ', ';

            // convert string to double
            if TryStrToFloat(Self[liIndex], lDateTime) then
              Result := Result + FormatDateTime(GetDateTimeFormat(lDateTime), lDateTime)
    //            Result := Result + '"' + FormatDateTime(GetDateTimeFormat(lDateTime), lDateTime) + '"';
            else
              Result := Result + Self[liIndex];

          end;

          // do not use comma text because date time string can have a space between the date and time
  //      Result := CommaText;

      finally
        DecimalSeparator := lSaveDecimalSeparator;

      end;
    end;

end;

function TppSearchValueList.GetSearchExpressionForNumeric: string;
var
  liIndex: Integer;
  lValues: array of Variant;
  lStringValues: TStringList;
begin

  // 1. convert string to numerics using '.' decimal sep
  // 2. convert numeric to string  using locale decimal seps

  Result := '';

  if (DataType in [dtInteger, dtLongint, dtSingle, dtDouble, dtExtended, dtCurrency]) and (Text <> '') then
    begin
      SetLength(lValues, Self.Count);

      // convert strings to datatype
      for liIndex := 0 to Self.Count - 1 do
        lValues[liIndex] := ConvertToDataType(liIndex);

      lStringValues := TStringList.Create;

      try
        // convert datatype to strings
        for liIndex := 0 to Self.Count - 1 do
          lStringValues.Add(ConvertFromDataType(lValues[liIndex]));

        if (Self.Count = 1) then
          Result := lStringValues[0]
        else
          Result := lStringValues.CommaText;

      finally
        lStringValues.Free;
      end;


    end;

end;

function TppSearchValueList.GetSubExpressions(Index: Integer): String;
var
  lValue: Variant;
begin
  lValue := ConvertToDataType(Index);
  Result := ConvertFromDataType(lValue);
end;

function TppSearchValueList.GetValues(Index: Integer): Variant;
begin
  Result := ConvertToDataType(Index);;
end;

function TppSearchValueList.GetWildCard: string;
begin
  if (FField <> nil) then
    Result := FField.Wildcard
  else
    Result := '';
end;

procedure TppSearchValueList.SetSearchExpression(const aSearchExpression: string);
begin

  if aSearchExpression = '' then
    Text := aSearchExpression

  else if (DataType in [dtDateTime, dtDate, dtTime]) then
    SetSearchExpressionForDateTime(aSearchExpression)

  else if (DataType in [dtInteger, dtLongint, dtSingle, dtDouble, dtExtended, dtCurrency]) then
    SetSearchExpressionForNumeric(aSearchExpression)

  else if IsMultiValue then
    begin
      // backward compatibility for custom search panels that do not use
      // TStringList.CommaText to format multiple items. This is required.
      if (Pos(' ', aSearchExpression) > 0) and (Pos('"', aSearchExpression) = 0) then
         ppUtils.ppParseString(aSearchExpression, Self)
      else
        CommaText := aSearchExpression

    end
  else
    Text := aSearchExpression;

end;


procedure TppSearchValueList.SetSearchExpressionForDateTime(const aSearchExpression: string);
var
  liIndex: Integer;
  lDateTime: TDateTime;
  lSaveDecimalSeparator: Char;
  lSaveThousandSeparator: Char;
  lsValue: String;
begin

  Clear;

  if (DataType in [dtDateTime, dtDate, dtTime]) and (aSearchExpression <> '') then
    begin
      lSaveDecimalSeparator := DecimalSeparator;
      lSaveThousandSeparator := ThousandSeparator;

      DecimalSeparator := '.';
      ThousandSeparator := ',';

      try
        // do not use comma text because date time string can have a space between the date and time
  //    CommaText := aSearchExpression;
        ppParseString(aSearchExpression, Self);

        for liIndex := 0 to Count - 1 do
          begin
            lsValue := StringReplace(Self[liIndex],'"','',[rfReplaceAll]);

            // convert string to datetime, then convert datetime to float
             if TryStrToDateTime(lsValue, lDateTime) then
               begin
                 lsValue := FloatToStr(lDateTime);
                 Self[liIndex] := ppRemoveCharacter(ThousandSeparator, lsValue);
               end
             else
               Self[liIndex] := lsValue;

          end;

      finally
        DecimalSeparator :=  lSaveDecimalSeparator;
        ThousandSeparator := lSaveThousandSeparator;

      end;

    end;

end;


procedure TppSearchValueList.SetSearchExpressionForNumeric(const aSearchExpression: string);
var
  liIndex: Integer;
  lsValue: String;
begin

  // 1. parse into string values
  // 2. strip off thousand sep
  // 3. replace locale decimal sep with '.' for storage

  // now can stream down a standard set of numerics
  Clear;

  if (DataType in [dtInteger, dtLongint, dtSingle, dtDouble, dtExtended, dtCurrency]) and (aSearchExpression <> '') then
    begin

      // check for backward compatibility
      if (Pos(' ', aSearchExpression) > 0) and (Pos('"', aSearchExpression) = 0) then
        ppUtils.ppParseString(aSearchExpression, Self)
      else if (DataType in [dtInteger, dtLongint]) or (DecimalSeparator <> ',') then
        CommaText := aSearchExpression
      else // floating point with decimal separator of ','
        CommaText := aSearchExpression;

      for liIndex := 0 to Count - 1 do
        begin

          lsValue := StringReplace(Self[liIndex],'"','',[rfReplaceAll]);
          lsValue := ppRemoveCharacter(ThousandSeparator, lsValue);
          lsValue := StringReplace(lsValue, DecimalSeparator, '.', []);

          Self[liIndex] := lsValue;

        end;

    end;

end;



{******************************************************************************
 *
 ** A U T O S E A R C H   F I E L D   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTppAutoSearchFieldRTTI.RefClass }

class function TraTppAutoSearchFieldRTTI.RefClass: TClass;
begin
  Result := TppAutoSearchField;
end; {class function, RefClass}

{------------------------------------------------------------------------------}
{ TraTppAutoSearchFieldRTTI.GetPropList }

class procedure TraTppAutoSearchFieldRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited GetPropList(aClass, aPropList);

  aPropList.AddMethod('DisableCriteria');

  {add public props}
  aPropList.AddProp('DataView');
  aPropList.AddProp('DataPipelineName');
  aPropList.AddProp('Description');
  aPropList.AddProp('LookupSettings');
  aPropList.AddProp('Value');
  aPropList.AddProp('Values');
  aPropList.AddProp('ValueCount');

end; {class procedure, GetPropList}

{------------------------------------------------------------------------------}
{ TraTppAutoSearchFieldRTTI.GetPropRec }

class function TraTppAutoSearchFieldRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  {properties & methods}
  if ppEqual(aPropName, 'DataView') then
    ClassPropToRec(aPropName, TComponent, True, aPropRec)

  else if ppEqual(aPropName, 'DataPipelineName') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'Description') then
    PropToRec(aPropName, daString, True, aPropRec)

  else if ppEqual(aPropName, 'LookupSettings') then
    ClassPropToRec(aPropName, TPersistent, True, aPropRec)

  else if ppEqual(aPropName, 'Value') then
    PropToRec(aPropName, daVariant, True, aPropRec)

  else if ppEqual(aPropName, 'Values')  then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'ValueCount') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'DisableCriteria') then
    MethodToRec(aPropName, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end; {class function, GetPropRec}

{------------------------------------------------------------------------------}
{ TraTppAutoSearchFieldRTTI.GetParams }

class function TraTppAutoSearchFieldRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, 'Values') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daVariant, nil, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {class function, GetParams}

{------------------------------------------------------------------------------}
{ TraTppAutoSearchFieldRTTI.CallMethod }

class function TraTppAutoSearchFieldRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lField: TppAutoSearchField;
  liIndex: Integer;
  lvValue: Variant;
begin

  Result := True;

  lField := TppAutoSearchField(aObject);

  if ppEqual(aMethodName, 'Values') then
    begin
      aParams.GetParamValue(0, liIndex);

      lvValue := lField.Values[liIndex];

      aParams.SetParamValue(1, lvValue);
    end

  else if ppEqual(aMethodName, 'DisableCriteria') then
    lField.DisableCriteria

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{------------------------------------------------------------------------------}
{ TraTppAutoSearchFieldRTTI.GetPropValue }

class function TraTppAutoSearchFieldRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'DataView') then
      Integer(aValue) := Integer(TppAutoSearchField(aObject).DataView)

  else if ppEqual(aPropName, 'DataPipelineName') then
     String(aValue) := TppAutoSearchField(aObject).DataPipelineName

  else if ppEqual(aPropName, 'Description') then
     String(aValue) := TppAutoSearchField(aObject).Description

  else if ppEqual(aPropName, 'LookupSettings') then
     Integer(aValue) := Integer(TppAutoSearchField(aObject).LookupSettings)

  else if ppEqual(aPropName, 'Value') then
    Variant(aValue) := TppAutoSearchField(aObject).Value

  else if ppEqual(aPropName, 'ValueCount') then
    Integer(aValue) := TppAutoSearchField(aObject).ValueCount

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{$IFNDEF Delphi7}
// D6 TStrings does not have this method
function TppLookupList.GetValueFromIndex(aIndex: Integer): String;
var
  lsName: String;
begin
  lsName := Names[aIndex];
  Result := Values[lsName];
end;
{$ENDIF}

constructor TppLookupList.Create;
begin
  inherited;
  Sorted := True;
  Duplicates := dupIgnore;
  FLookupSettings := TppLookupSettings.Create;
end;

destructor TppLookupList.Destroy;
begin
  FLookupSettings.Free;
  FLookupSettings := nil;

  inherited;

end;



procedure TppLookupList.Assign(aSource: TPersistent);
begin

  if (aSource is TppLookupList) then
    LookUpSettings := TppLookupList(aSource).LookupSettings;

  inherited;

end;

{------------------------------------------------------------------------------}
{@TppLookupList.BuildList

  Uses the LookupSettings.DataPipeline, ValueField, and NameField properties to
  iterate over the DataPipeline and populate the Items. This method is called
  automatically priore to the autoserch dialog being displayed.}

procedure TppLookupList.BuildList;
var
  lPipeline: TppDataPipeline;
  lsValue: string;
  lsDisplayName: string;
  lDataView: TdaDataView;
begin

  if (FLookupSettings.DataPipeline = nil) then Exit;

  Clear;

  lsValue := '';
  lsDisplayName := '';

  lPipeline := FLookupSettings.DataPipeline;

  lDataView := lPipeline.DataView as TdaDataView;

  if (lDataView <> nil) and not(lDataView.Active) then
    lDataView.Active := True;

  if not lPipeline.Active then
    lPipeline.Open;

  lPipeline.First;

  while not lPipeline.Eof do
    begin

      if (FLookupSettings.ValueField <> '') then
        lsValue := lPipeline.GetFieldAsString(FLookupSettings.ValueField);

      if (FLookupSettings.NameField <> '') then
        lsDisplayName := lPipeline.GetFieldAsString(FLookupSettings.NameField);

      if (FLookupSettings.ValueField <> '') and (FLookupSettings.NameField <> '') then
         Add(lsDisplayName + '=' + lsValue)   // name value pairs
      else if (FLookupSettings.ValueField <> '') then
        Add(lsValue);  // values only

      lPipeline.Next;

    end;

end;

function TppLookupList.CompareStrings(const S1, S2: string): Integer;
begin

{$IFDEF Delphi7}
  if HasNameValuePairs then
{$ELSE}
  // this is necessary due to bug in D6 string list
  if HasNameValuePairs and (pos('=', S1) > 0) and (pos('=', S2) > 0) then
{$ENDIF}
    begin
      if FLookupSettings.SortOrder = soName then
        Result := AnsiCompareText(ExtractName(S1), ExtractName(S2))
      else
        Result := AnsiCompareText(ExtractValue(S1), ExtractValue(S2));
    end
  else
    Result := inherited CompareStrings(S1, S2);

end;

function TppLookupList.ExtractValue(aString: String): String;
begin
  Result := Copy(aString, Length(ExtractName(aString)) + 2, MaxInt);
end;

{------------------------------------------------------------------------------}
{@TppLookupList.GetDisplayNameForIndex

  Returns the display name for the specified Index.}


function TppLookupList.GetDisplayNameForIndex(aIndex: Integer): String;
begin

  if HasNameValuePairs then
    case FLookupSettings.DisplayType of
      dtNameOnly: Result := Names[aIndex];
      dtValueAndName: Result := ValueFromIndex[aIndex] + ' - ' + Names[aIndex];
      dtNameAndValue: Result := Names[aIndex] + ' - ' + ValueFromIndex[aIndex];
    end
  else
    Result := Strings[aIndex];

end;

{------------------------------------------------------------------------------}
{@TppLookupList.GetDisplayNameForValue

  Returns the dsiplay name for the specified value.}

function TppLookupList.GetDisplayNameForValue(aValue: String): String;
var
  liIndex: Integer;
begin

  liIndex := IndexOfValue(aValue);

  if liIndex >= 0 then
    Result := GetDisplayNameForIndex(liIndex)
  else
    Result := '';

end;


function TppLookupList.GetHasNameValuePairs: Boolean;
begin

  if (FLookupSettings.ValueField <> '') and (FLookupSettings.NameField <> '') then
    Result := True
  else if (Count > 0) and (Pos('=', Strings[0]) > 0) then
    Result := True
  else
    Result := False;

end;

{------------------------------------------------------------------------------}
{@TppLookupList.GetDisplayNames

  Populates aNameList with the display names.}

procedure TppLookupList.GetDisplayNames(aNameList: TStrings);
var
  liIndex: Integer;
begin

 aNameList.Clear;

 for liIndex := 0 to Count - 1 do
   aNameList.Add(GetDisplayNameForIndex(liIndex));

end;

{------------------------------------------------------------------------------}
{@TppLookupList.GetDisplayNameForIndex

  Returns the value for the specified display name.}

function TppLookupList.GetValueForDisplayName(aName: String): String;
var
  liIndex: Integer;
begin
  Result := '';

  if (Count = 0) then Exit;

  if HasNameValuePairs then
    begin
        liIndex := IndexOfDisplayName(aName);

         if (liIndex >= 0) then
           Result := ValueFromIndex[liIndex]
    end
  else
    Result := aName;

end;

{------------------------------------------------------------------------------}
{@TppLookupList.GetValueForIndex

  Returns the value for the specified index.}

function TppLookupList.GetValueForIndex(aIndex: Integer): String;
begin
  Result := '';

  if (Count = 0) or (aIndex = -1) then Exit;

  if HasNameValuePairs then
    Result := ValueFromIndex[aIndex]
  else
    Result := Strings[aIndex];

end;

{------------------------------------------------------------------------------}
{@TppLookupList.IndexOfValue

  Returns the index for the specified value.}

function TppLookupList.IndexOfValue(aValue: String): Integer;
var
  liIndex: Integer;
begin

  Result := -1;

  for liIndex := 0 to Count-1 do
    if (CompareText(aValue, GetValueForIndex(liIndex)) = 0) then
      begin
        Result := liIndex;
        break;
      end;

end;

{------------------------------------------------------------------------------}
{@TppLookupList.IndexOfDisplayName

  Returns the index for the specified display name.}
  
function TppLookupList.IndexOfDisplayName(aName: String): Integer;
var
  liIndex: Integer;
begin

  Result := -1;

  for liIndex := 0 to Count-1 do
    if (CompareText(aName, GetDisplayNameForIndex(liIndex)) = 0) then
      begin
        Result := liIndex;
        break;
      end;

end;

procedure TppLookupList.SetLookupSettings(const Value: TppLookupSettings);
begin
  FLookupSettings.Assign(Value);
end;

constructor TppLookupSettings.Create;
begin

  inherited Create;


end;

destructor TppLookupSettings.Destroy;
begin

  SetDataPipeline(nil);

  inherited;

end;

procedure TppLookupSettings.Assign(Source: TPersistent);
begin

  if (Source is TppLookupSettings) then
    AssignLookupSettings(TppLookupSettings(Source))
  else
    inherited;

end;

procedure TppLookupSettings.AssignLookupSettings(aSource: TppLookupSettings);
begin

  SetDataPipeline(aSource.DataPipeline);
  FNameField := aSource.NameField;
  FDisplayType := aSource.DisplayType;
  FSortOrder := aSource.SortOrder;
  FValueField := aSource.ValueField;

end;


procedure TppLookupSettings.DefineProperties(Filer: TFiler);
var
  lAncestor: TppLookupSettings;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppLookupSettings) then
    lAncestor := TppLookupSettings(Filer.Ancestor)
  else
    lAncestor := nil;


  if (lAncestor <> nil) then
    begin
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> lAncestor.FDataPipeline);
    end
  else
    begin
      Filer.DefineProperty('DataPipelineName', ReadDataPipelineName, WriteDataPipelineName, FDataPipeline <> nil);
    end;

end;

procedure TppLookupSettings.ehDataPipeline_FreeNotify(Sender, aParameters: TObject);
begin
  FDataPipeline := nil;
end;


procedure TppLookupSettings.ReadDataPipelineName(Reader: TReader);
begin
  FDataPipelineName := Reader.ReadString;

end; {procedure, ReadDataPipelineName}


procedure TppLookupSettings.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
var
  lDataPipeline: TppDataPipeline;
begin

  {set DataPipeline property rather than FDataPipeline -}
  if (FDataPipeline = nil) and (FDataPipelineName <> '') then
    begin
      lDataPipeline := aPipelineList.GetPipelineForComponentName(FDataPipelineName);
      SetDataPipeline(lDataPipeline);
    end;

end; {procedure, ResolvePipelineReferences}

procedure TppLookupSettings.SetDataPipeline(const Value: TppDataPipeline);
begin

  // remove free notify
  if (FDataPipeline <> nil) then
    FDataPipeline.mcFreeNotify.RemoveNotify(ehDataPipeline_FreeNotify);

  FDataPipeline := Value;

  // add free notify
  if (FDataPipeline <> nil) then
    FDataPipeline.mcFreeNotify.AddNotify(ehDataPipeline_FreeNotify);

end;

procedure TppLookupSettings.SetNameField(const Value: String);
begin
  FNameField := Value;
end;

procedure TppLookupSettings.SetDisplayType(const Value: TppLookupListDisplayType);
begin
  FDisplayType := Value;
end;

procedure TppLookupSettings.SetSortOrder(const Value: TppLookupListSortOrder);
begin
  FSortOrder := Value;
end;

procedure TppLookupSettings.SetValueField(const Value: String);
begin
  FValueField := Value;
end;


procedure TppLookupSettings.WriteDataPipelineName(Writer: TWriter);
begin
  if (FDataPipeline <> nil) then
    Writer.WriteString(FDataPipeline.Name)
  else
    Writer.WriteString('');

end; {procedure, WriteDataPipelineName}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  RegisterClasses([TppAutoSearchField, TppAutoSearchGroup, TppAutoSearchGroups, TppLookupSettings]);

  raRegisterEnum('TppLookupListSortOrder', TypeInfo(TppLookupListSortOrder));
  raRegisterEnum('TppLookupListDisplayType', TypeInfo(TppLookupListDisplayType));

  raRegisterRTTI(TraTppAutoSearchFieldRTTI);

finalization

  UnRegisterClasses([TppAutoSearchField, TppAutoSearchGroup, TppAutoSearchGroups, TppLookupSettings]);

  raUnRegisterEnum('TppLookupListSortOrder');
  raUnRegisterEnum('TppLookupListDisplayType');

  raUnRegisterRTTI(TraTppAutoSearchFieldRTTI);



end.
