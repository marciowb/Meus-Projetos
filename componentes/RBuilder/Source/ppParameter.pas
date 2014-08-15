{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppParameter;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6} Variants, {$ENDIF}
  Windows,
  Classes,
  SysUtils,
  Typinfo,

  ppTypes,
  ppUtils,
  ppRTTI,
  ppCollectionBase,
  ppComm,
  ppRelatv,
  ppClass,
  ppDB,
  ppAsField;

const

  {note: only these datatypes are supported by TppParameter}
  cValidParameterDataTypes: TppDataTypeSet = [dtString,
                                              dtInteger, dtLargeInt,
                                              dtCurrency, dtSingle, dtDouble,
                                              dtBoolean,
                                              dtDateTime, dtDate, dtTime];

type

  TppParameter = class;

{$IFNDEF Delphi6}
  {D5 does not have a TVarType}
  TVarType = Integer;
{$ENDIF}


  {@TppAutoSearchSettings

    Use AutoSearchSettings to enable Parameter values to be populated
    by ReportBuilder's autosearch user interface. AutoSearchSettings essentially
    enable a Parameter to dynamically create and bind to an AutoSearchField at
    run-time.

    A typical report might have one or Parameters with AutoSearchSettings defined
    and one or more sql query's with search criteria that reference the Parameters.
    At run-time RB will generate an ask-at-runtime dialog, the user will enter
    search values, which will automatically be applied to the sql.

      Query
        search -- parameter.autosearch settings -- autosearch field -- user interface

    Use the Enabled boolean property to control whether AutoSearchSettings are
    used at generation time.

    Most AutoSearchSettings properties are use to create an initialize an
    AutoSearchField at generation time.}

  {@TppAutoSearchSettings.DataPipeline

    Optional. Can be used to group autosearchfields together.}

  {@TppAutoSearchSettings.Enabled

    Use the Enabled boolean property to control whether AutoSearchSettings are
    used at run-time.}

  {@TppAutoSearchSettings.FieldAlias

   User friendly field name to be displayed by the autosearch dialog.}

  {@TppAutoSearchSettings.LogicalPrefix

   Used to combine multiple search criteria using And, Or logical operators and
   to prefix a search condition with the Not operation.}

  {@TppAutoSearchSettings.Mandatory

   Used to indicate that a search value must be specified. When True, the
   ShowAllValues property is ignored.}

  {@TppAutoSearchSettings.SearchExpression

   Contains the search value.}

  {@TppAutoSearchSettings.SearchOperator

   Indicates the type of search operator being used.}

  {@TppAutoSearchSettings.ShowAllValues

    Can be used to indicate that no search condition should be used.}


  TppAutoSearchSettings = class(TPersistent)
  private
    FDataPipeline: TppDataPipeline;
    FDataPipelineName: string;
    FEnabled: Boolean;
    FFieldAlias: string;
    FLogicalPrefix: TppLogicalOperatorTypes;
    FMandatory: Boolean;
    FOnChange: TNotifyEvent;
    FParameter: TppParameter;
    FSearchOperator: TppSearchOperatorType;
    FShowAllValues: Boolean;
    FValueList: TppSearchValueList;
    FUpdating: Boolean;

    procedure ehDataPipeline_FreeNotify(Sender, aParameters: TObject);
    function GetSearchExpression: String;

    procedure ReadDataPipelineName(Reader: TReader);
    procedure SetDataPipeline(const Value: TppDataPipeline);
    procedure SetSearchOperator(aOperator: TppSearchOperatorType);
    procedure SetSearchExpression(const aExpression: String);
    procedure SetShowAllValues(const Value: Boolean);
    procedure WriteDataPipelineName(Writer: TWriter);

  protected
    {override from TPersistent}
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;

    procedure DoOnChange; virtual;

  public
    constructor Create(aParameter: TppParameter); virtual;
    destructor Destroy; override;

    procedure Assign(aPersistent: TPersistent); override;
    function IsMultiValue: Boolean;
    procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); virtual;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  published
    property DataPipeline: TppDataPipeline read FDataPipeline write SetDataPipeline stored False;
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property FieldAlias: string read FFieldAlias write FFieldAlias;
    property LogicalPrefix: TppLogicalOperatorTypes read FLogicalPrefix write FLogicalPrefix;
    property Mandatory: Boolean read FMandatory write FMandatory;
    property SearchExpression: String read GetSearchExpression write SetSearchExpression;
    property SearchOperator: TppSearchOperatorType read FSearchOperator write SetSearchOperator default soEqual;
    property ShowAllValues: Boolean read FShowAllValues write SetShowAllValues default False;

  end;


  {@TppParameter

    TppParameter represents a named parameter in a TppParameterList.

    The Name, DataType, and Value properties describe the parameter. Use the
    EqualTo method to compare one parameter value to another. The AsBoolean,
    AsInteger, and AsString properties return the parameter value as a
    specific data type.

    Use Parameter.AutoSearchSettings to enable Parameter values to be populated
    by ReportBuilder's autosearch user interface. AutoSearchSettings essentially
    enables a Parameter to dynamically create and bind to an AutoSearchField at
    run-time.

    Use Parameter.LookupSettings to bind a Parameter to lookup data and control
    the appearance of a lookup list displayed to the user. LookupSettings
    includes the ability to support name/value lists or simple value lists as well
    options to control the sort order and display type.}

  {@TppParameter.AsBoolean

    Returns the parameter's value as a boolean data type.}

  {@TppParameter.AsInteger

    Returns the parameter's value as an integer data type.}

  {@TppParameter.AsString

    Returns the parameter's value as a string data type.}

  {@TppParameter.AutoSearchSettings

    Use AutoSearchSettings to enable Parameter values to be populated
    by ReportBuilder's autosearch user interface. AutoSearchSettings essentially
    enables a Parameter to dynamically create and bind to an AutoSearchField at
    run-time.}

  {@TppParameter.Bindable

    Defaults to True. Set Bindable to False to hide a Parameter from the DADE
    query designer.

    The data workspace (DADE) query designer allows users to bind parameters to
    search expressions (WHERE) and group search expressions (HAVING).  Use the
    Bindable propery to show or hide parameters from the query designer.}

  {@TppParameter.DataType

    Specifies the native data type of the parameter value. Defaults to dtString.

    <Table>
    Value	        Meaning
    ----------    --------
    dtBoolean     Data is a boolean value
    dtCurrency    Data is a currency value
    dtDateTime    Data is a datetime value
    dtDouble      Data is a double value
    dtLargeInt    Data is a large integer (Int64)
    dtInteger	    Data is an integer value
    dtSingle	    Data is a single value
    dtString      Data is a string value
    </Table>}

  {@TppParameter.OnValueChange

    Occurs whenver the parameter value is modified.

    The OnValueChange event is used internally by the TppParameterList object.}

  {@TppParameter.LookupSettings

    Use Parameter.LookupSettings to bind a Parameter to lookup data and control
    the appearance of a lookup list displayed to the user. LookupSettings
    includes the ability to support name/value lists or simple value lists as well
    options to control the sort order and display type.}

  {@TppParameter.Name

    Specifies the parameter name.}

  {@TppParameter.Value

    Specifies the parameter value. Defaults to Unassigned.}

  {@TppParameter.Values

    Use Values and ValueCount to access parameter values for multi-value cases,
    such as when AutoSearchSettings.SearchOperator is set to Between or InList.

    Run-time and read-only. At design-time, use the AutoSearchSettings.SearchExpression
    to specify values as a comma delimited list}

  {@TppParameter.ValueCount

    Returns the number of values. Some AutoSearchSettings.SearchOperator's
    allow for multiple values. For example the Between and InList operators}

  TppParameter = class(TppRelative)
    private
      FAutoSearchField: TppAutoSearchField;
      FAutoSearchSettings: TppAutoSearchSettings;
      FDataType: TppDataType;
      FLookupList: TppLookupList;
      FNull: Boolean;
      FOnValueChange: TNotifyEvent;
      FUpdateCount: Integer;
      FValue: Variant;
      FBindable: Boolean;


      function GetAsBoolean: Boolean;
      function GetAsInteger: Integer;
      function GetAsString: String;
      function GetAutoSearchSettings: TppAutoSearchSettings;
      function GetLookupSettings: TppLookupSettings;
      function GetPickList: TStrings;
      function GetIsUpdating: Boolean;
      function GetValue: Variant;
      function GetValueCount: Integer;
      function GetValues(Index: Integer): Variant;
      procedure ReadPickList(Reader: TReader);

      procedure SetAsBoolean(aValue: Boolean);
      procedure SetAsString(aValue: String);
      procedure SetAsInteger(aValue: Integer);
      procedure SetAutoSearchSettings(const Value: TppAutoSearchSettings);
      procedure SetDataType(aDataType: TppDataType);
      procedure SetLookupList(const aLookupList: TppLookupList);
      procedure SetLookupSettings(const Value: TppLookupSettings);
      procedure SetPickList(aPickList: TStrings);

    protected

      {override from TPersistent}
      procedure AssignTo(Dest: TPersistent); override;
      procedure DefineProperties(Filer: TFiler); override;
      procedure DoOnValueChange; virtual;
      procedure ehAutoSearchField_Change(Sender: TObject); virtual;
      function MapDataTypeToVarType(aDataType: TppDataType): TVarType; virtual;
      procedure SetUserName(const aUserName: TComponentName); override;

      procedure SetValue(aValue: Variant); virtual;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure CreateAutoSearchField(aReport: TppRelative);

      function IsNull: Boolean;
      procedure Assign(Source: TPersistent); override;
      procedure BeginUpdate;
      procedure EndUpdate;
      function EqualTo(aParameter: TppParameter): Boolean;
      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;
      procedure InitializeForReport(aReport: TppRelative);
      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;
      procedure ResolvePipelineReferences(aPipelineList: TppDataPipelineList); virtual;

      property PickList: TStrings read GetPickList write SetPickList;
      
      property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
      property AsInteger: Integer read GetAsInteger write SetAsInteger;
      property AsString: String read GetAsString write SetAsString;
      property IsUpdating: Boolean read GetIsUpdating;
      property ValueCount: Integer read GetValueCount;
      property Values[Index: Integer]: Variant read GetValues;

      property OnValueChange: TNotifyEvent read FOnValueChange write FOnValueChange;

    published
      property AutoSearchSettings: TppAutoSearchSettings read GetAutoSearchSettings write SetAutoSearchSettings;
      property DataType: TppDataType read FDataType write SetDataType;
      property LookupList: TppLookupList read FLookupList write SetLookupList;
      property LookupSettings: TppLookupSettings read GetLookupSettings write SetLookupSettings;
      property Name;
      property Value: Variant read GetValue write SetValue;
      property UserName;
      property Bindable: Boolean read FBindable write FBindable default True;

  end;

  {@TppParameterList

    TppParameterList is used to manage a collection of TppParameter items.

    Use the Add, Remove, and Clear methods to maintain the list of TppParameter
    items.

    The Values array property provides access to the parameter values. The
    Items and ItemsByIndex array properties provide access to the TppParameter
    items in the list.

    TppParameterList can be used to define custom parameters that are sent
    between a client and a report server.}

  {@TppParameterList.Count

   Read-only. Returns the number of parameters in the list.}

  {@TppParameterList.Items

   Default property. Provides parameter name access to the TppParameter objects
   in the list.

   Use InsertMode to control whether this property automatically adds new
   item to the list.}

  {@TppParameterList.ItemsByIndex

    Provides index access to the TppParameter objects in the list.

    Use the Items and Count properties to iterate through the parameter list.}

  {@TppParameterList.InsertMode

   Defaults to True. Determines whether the array automatically adds new
   items to the list.
   
   If InsertMode is set to True, the Items array can automatically add
   new items to the list. When setting a parameter value for a named item
   that does not appear in the list, a new parameter is implicitly added.
   When accessing a parameter value that does not appear in the list, a
   temporary parameter is returned that contains an empty value.

   If InsertMode is set to False, specifying a parameter name that does not
   exist in the list, results in an EParameterError exception being raised.}


  TppParameterList = class(TppRelative)
    private
      FNullParameter: TppParameter;
      FInsertMode: Boolean;

      procedure AssignParameterList(aSource: TppParameterList);
      function GetParameterForIndex(aIndex: Integer): TppParameter;

    protected
      procedure NullParameterValueChangeEvent(Sender: TObject);
      function GetParameterForName(aName: String): TppParameter; 
      function GetItemForName(aName: String): TppParameter; virtual;
      function GetValueForName(aName: String): Variant; virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;
      procedure AssignValues(aSource: TppParameterList);
      function EqualTo(aSource: TppParameterList): Boolean;
      function InList(aName: String): Boolean;

      function ContainsAutoSearch: Boolean;
      function Add(aName: String): TppParameter; overload;
      function Add(aName: String; aValue: String): TppParameter; overload;
      function Add(aName: String; aDataType: TppDataType; aValue: Variant): TppParameter; overload;
      function Add(aParameters: TppParameterList): TppParameter; overload;
      function Add: TppParameter; overload;
      procedure Clear;
      procedure GetNames(aStrings: TStrings);
      procedure GetVisibleNames(aStrings: TStrings);
      procedure InitializeForReport(aReport: TppRelative);
      procedure Remove(aName: String); overload;
      procedure Remove(aNames: array of String); overload;

      property InsertMode: Boolean read FInsertMode write FInsertMode;
      property Count: Integer read GetChildCount;
      property Values[Name: String]: Variant read GetValueForName;
      property Items[Name: String]: TppParameter read GetItemForName; default;
      property ItemsByIndex[Index: Integer]: TppParameter read GetParameterForIndex;

  end;

  {TppParameterDataTypeInfo
    - used by the property editor}
  TppParameterDataTypeInfo = class
    public
      class procedure GetEnumNames(aList: TStrings);
      class function IsValidType(aDataType: TppDataType): Boolean;
      class function GetEnumName(aDataType: TppDataType): String;
    end;

  {TppParameterCollection}
  TppParameterCollection = class(TppComponentCollectionBase)
  private
    function GetItemForIndex(aIndex: Integer): TppParameter;

  public
    function IndexOf(aObject: TppParameter): Integer;
    procedure Add(aObject: TppParameter); virtual;
    procedure Remove(aObject: TppParameter); virtual;

    property Items[Index: Integer]: TppParameter read GetItemForIndex; default;

  end;


{******************************************************************************
 *
 ** R T T I
 *
{******************************************************************************}

  {@TraTppParameterListRTTI }
  TraTppParameterListRTTI = class(TraTppRelativeRTTI)
  private
    public
      class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
      class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
      class function  GetParams(const aMethodName: String): TraParamList; override;
      class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
      class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
      class function  RefClass: TClass; override;
      class function  SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
  end; {class, TraTppParameterListRTTI}





implementation

{$IFNDEF Delphi6}

{Delphi5 does not have support for VarIsClear}
function VarIsClear(const V: Variant): Boolean;
begin
  Result := VarIsEmpty(V);
end;
{$ENDIF}



{******************************************************************************
 *
 ** P A R A M E T E R
 *
{******************************************************************************}

{@TppParameter.Create}

constructor TppParameter.Create(AOwner: TComponent);
begin
  inherited;

  FDataType := dtString;
  FValue := '';
  FNull := False;
  FAutoSearchSettings := TppAutoSearchSettings.Create(Self);
  EventNotifies := EventNotifies + [ciParamValueChange];
  FLookupList := TppLookupList.Create;
  FBindable := True;


end;

destructor TppParameter.Destroy;
begin

  FLookupList.Free;
  FLookupList := nil;

  FAutoSearchSettings.Free;
  FAutoSearchSettings := nil;

  FAutoSearchField.Free;
  FAutoSearchField := nil;


  inherited;

end;


{@TppParameter.Assign

  Assigns the Name, DataType and Value of one parameter to another.}

procedure TppParameter.Assign(Source: TPersistent);
var
  lSource: TppParameter;
begin

  if (Source is TppParameter) then
    begin
      lSource := TppParameter(Source);

      Name := lSource.Name;
      UserName := lSource.UserName;
      FDataType := lSource.DataType;
      FNull := lSource.FNull;

      // asign autosearch settings, prior to assigning FValue, FNull
      FAutoSearchSettings.Assign(lSource.AutoSearchSettings);

      // do this after assign autosearch settings; update FValue, FNull directly
      FValue := lSource.FValue;
      FNull := lSource.FNull;

      FLookupList.Assign(lSource.LookupList);
    end
  else
    inherited Assign(Source);

end;


{@TppParameter.EqualTo

  Compares two parameters for equality. Two parameters are equal if they
  have the same Name, DataType, and Value.}

function TppParameter.EqualTo(aParameter: TppParameter): Boolean;
begin

  if IsNull then
    Result := (Name = aParameter.Name) and
              (FDataType = aParameter.DataType) and
              (aParameter.IsNull)
  else
    Result := (Name = aParameter.Name) and
              (FDataType = aParameter.DataType) and
              (FValue = aParameter.Value);
end;

{@TppParameter.GetAsString}

function TppParameter.GetAsString: String;
{$IFDEF Delphi6}
var
  lLargeInt: Int64;
{$ENDIF}
begin

  if IsNull then
    Result := ''

  else case FDataType of

    dtString: Result := FValue;
    dtInteger: Result := IntToStr(FValue);
{$IFDEF Delphi6}
    dtLargeInt:
      begin
        lLargeInt := FValue;
        Result := IntToStr(lLargeInt);
      end;
{$ENDIF}
    dtBoolean: if FValue then
                 Result := 'True'
               else
                 Result := 'False';
    dtSingle: Result := FloatToStrF(FValue, ffGeneral, 7, 0);
    dtDouble: Result := FloatToStrF(FValue, ffGeneral, 15, 0);
    dtCurrency: Result := CurrToStr(FValue);
    dtDateTime: Result := DateTimeToStr(FValue);
    dtDate: Result := DateToStr(FValue);
    dtTime: Result := TimeToStr(FValue);

  end; {case }

end;

{@TppParameter.GetAsBoolean}

function TppParameter.GetAsBoolean: Boolean;
begin

  if IsNull then
    Result := False

  else case FDataType of
    dtString:  if (FValue = '1') or SameText(FValue, 'T') or SameText(FValue, 'True') then
                 Result := True
               else
                 Result := False;
    dtInteger,
    dtLargeInt: Result := (FValue > 0);
    dtBoolean: Result := FValue;

  else
    Result := False;

  end;    {case }

end;

{@TppParameter.GetAsInteger}

function TppParameter.GetAsInteger: Integer;
begin

  if IsNull then
    Result := 0

  else case FDataType of
    dtString:  Result := StrToIntDef(FValue, 0);
    dtInteger,
    dtLargeInt: Result := FValue;
    dtBoolean: if FValue then
                 Result := 1
               else
                 Result := 0;

    dtSingle, dtDouble: Result := Integer(FValue);
    dtCurrency: Result := Integer(FValue);
    dtDateTime, dtDate, dtTime: Result := Integer(FValue);

  else
    Result := 0;
    
  end { case }


end;

{@TppParameter.SetAsString}

procedure TppParameter.SetAsString(aValue: String);
var
  lSingleValue: Single;
  lDoubleValue: Double;
  lValue: Variant;
begin

  case FDataType of
    dtString: lValue := aValue;
    dtInteger: lValue := StrToIntDef(aValue, 0);
{$IFDEF Delphi6}
    dtLargeInt: lValue := StrToInt64(aValue);
{$ENDIF}
    dtBoolean: if (aValue = '1') or SameText(aValue, 'T') or SameText(aValue, 'True') then
                 lValue := True
               else
                 lValue := False;
    dtSingle:
      begin
        lSingleValue := StrToFloat(aValue);
        lValue := lSingleValue;
      end;
   dtDouble:
      begin
        lDoubleValue := StrToFloat(aValue);
        lValue := lDoubleValue;
      end;
    dtCurrency: lValue := StrToCurr(aValue);
    dtDateTime: lValue := StrToDateTime(aValue);
    dtDate: lValue := StrToDate(aValue);
    dtTime: lValue := StrToTime(aValue);

  end;    { case }

  SetValue(lValue);

end;

{@TppParameter.SetAsBoolean}

procedure TppParameter.SetAsBoolean(aValue: Boolean);
var
  lValue: Variant;
begin

  case FDataType of
    dtString: if aValue then
                lValue := 'T'
              else
                lValue := 'F';

    dtInteger,
    dtLargeInt: if aValue then
                lValue := 1
              else
                lValue := 0;

    dtBoolean: lValue := aValue;

  end;    { case }

  SetValue(lValue);

    
end;

{@TppParameter.SetAsInteger}

procedure TppParameter.SetAsInteger(aValue: Integer);
var
  lValue: Variant;
begin

  case FDataType of
    dtString: lValue := IntToStr(aValue);

    dtInteger,
    dtLargeInt: lValue := aValue;

    dtBoolean: if (aValue > 0) then
                 lValue := True
               else
                 lValue := False;
    dtSingle, dtDouble: lValue := aValue;
    dtCurrency: lValue := aValue;
    dtDateTime, dtDate, dtTime: lValue := aValue;

  end;    { case }

  SetValue(lValue);

    
end;


{@TppParameter.IsNull

  Indicates whether the value assigned to the parameter is NULL.}

function TppParameter.IsNull: Boolean;
begin
  Result := FNull or VarIsNull(FValue) or VarIsClear(FValue);

end;

{$IFDEF Delphi6}

{@TppParameter.MapDataTypeToVarType}

function TppParameter.MapDataTypeToVarType(aDataType: TppDataType): TVarType;
begin

  case aDataType of
    dtInteger: Result := varInteger;
    dtLargeInt: Result := varInt64;
    dtSingle: Result := varSingle;
    dtDouble: Result := varDouble;
    dtCurrency: Result := varCurrency;
    dtDateTime, dtDate, dtTime: Result := varDate;
    dtBoolean: Result := varBoolean;
{$IFDEF Delphi12}
    dtString: Result := varUString;
{$ELSE}
    dtString: Result := varString;
{$ENDIF}
  else
    Result := varUnknown;

  end;

end;

{$ELSE}

{Delphi5 has a smaller set of var types}

{@TppParameter.MapDataTypeToVarType}

function TppParameter.MapDataTypeToVarType(aDataType: TppDataType): TVarType;
begin

 case aDataType of
   dtInteger: Result := varInteger;
   dtSingle: Result := varSingle;
   dtDouble: Result := varDouble;
   dtCurrency: Result := varCurrency;
   dtDateTime, dtDate, dtTime: Result := varDate;
   dtBoolean: Result := varBoolean;
   dtString: Result := varString;
 else
   Result := varUnknown;

 end;

end;

{$ENDIF}

{@TppParameter.SetValue}

procedure TppParameter.SetValue(aValue: Variant);
begin

  if IsUpdating then Exit;

  BeginUpdate;

  FNull := VarIsClear(aValue) or VarIsNull(aValue);

  if not(FNull) then
   begin
     FValue := VarAsType(aValue, MapDataTypeToVarType(FDataType));

      // udpate autosearch settings
      if not (csReading in ComponentState) then
        FAutoSearchSettings.SearchExpression := GetAsString;

   end;

  EndUpdate;

  DoOnValueChange;

end;

{@TppParameter.DoOnValueChange}

procedure TppParameter.DoOnValueChange;
begin

  if IsUpdating then Exit;

  BeginUpdate;

  try
    if FAutoSearchField <> nil then
      begin
        FAutoSearchField.SearchExpression := FAutoSearchSettings.SearchExpression;
        FAutoSearchField.ShowAllValues := FAutoSearchSettings.ShowAllValues;
        FAutoSearchField.Mandatory := FAutoSearchSettings.Mandatory;
      end;

    if Assigned(FOnValueChange) then FOnValueChange(Self);

    SendEventNotify(Self, ciParamValueChange, nil);

    // enable the param list to broadcast changes as well
    if (Parent <> nil) then
      Parent.SendEventNotify(Self, ciParamValueChange, nil);

  finally
    EndUpdate;

  end;


end;

{@TppParameter.SetDataType}

procedure TppParameter.SetDataType(aDataType: TppDataType);
var
  lsEnumName: String;
  lValue: Variant;
begin

  if (csReading in ComponentState) then
    begin
      FDataType := aDataType;
      Exit;
    end;

  if not TppParameterDataTypeInfo.IsValidType(aDataType) then
    begin
      lsEnumName := GetEnumName(TypeInfo(TppDataType), Ord(aDataType));
      raise EParameterError.CreateFmt('TppParameter.SetDataType: %s data type is not supported', [lsEnumName]);
    end;

  if (FDataType <> aDataType) then
    begin
      try
        if (aDataType in [dtDateTime, dtDate, dtTime]) then
          begin
            if (FDataType in [dtDateTime, dtDate, dtTime]) then
              lValue := VarAsType(FValue, MapDataTypeToVarType(aDataType))
            else if (aDataType = dtDateTime) then
              lValue := VarAsType(Now, MapDataTypeToVarType(aDataType))
            else if (aDataType = dtDate) then
              lValue := VarAsType(Date, MapDataTypeToVarType(aDataType))
            else
              lValue := VarAsType(Time, MapDataTypeToVarType(aDataType));
          end

        {toggle default numeric, value as needed}
        else if (FDataType = dtString) and (FValue = '') then
          lValue := VarAsType(0, MapDataTypeToVarType(aDataType))

        else if (aDataType = dtString) and (FValue = 0) then
          lValue := VarAsType('', MapDataTypeToVarType(aDataType))

        else
          lValue := VarAsType(FValue, MapDataTypeToVarType(aDataType));

      except
        lValue := VarAsType(0, MapDataTypeToVarType(aDataType));

      end;

      FDataType := aDataType;
      SetValue(lValue);

    end;


end;

{******************************************************************************
 *
 ** P A R A M E T E R   L I S T
 *
{******************************************************************************}

{@TppParameterList.Create}

constructor TppParameterList.Create(aOwner: TComponent);
begin

  inherited;

  FInsertMode := True;
  
  FNullParameter := TppParameter.Create(nil);
  FNullParameter.OnValueChange := NullParameterValueChangeEvent;

end;

{@TppParameterList.Destroy}

destructor TppParameterList.Destroy;
begin

  FNullParameter.Free;
  
  inherited;
  
end;

{ TppParameterList.Assign }

procedure TppParameterList.Assign(Source: TPersistent);
begin

  if (Source is TppParameterList) then
    AssignParameterList(TppParameterList(Source))
  else if (Source = nil) then
    Clear
  else    
    inherited Assign(Source);

end;

{ TppParameterList.AssignParameterList }

procedure TppParameterList.AssignParameterList(aSource: TppParameterList);
var
  liIndex: Integer;
  lParameter: TppParameter;
  lSourceParameter: TppParameter;
begin

  FreeChildren;

  for liIndex := 0 to aSource.Count-1 do
    begin
      lSourceParameter := aSource.GetParameterForIndex(liIndex);

      lParameter := TppParameter.Create(Owner);

      lParameter.Assign(lSourceParameter);

      lParameter.Parent := Self;

    end;

end;

{@TppParameterList.AssignValues}

procedure TppParameterList.AssignValues(aSource: TppParameterList);
var
  liIndex: Integer;
  lParameter: TppParameter;
  lSourceParameter: TppParameter;
begin

  for liIndex := 0 to aSource.Count-1 do
    begin
      lSourceParameter := aSource.GetParameterForIndex(liIndex);

      lParameter := GetParameterForName(lSourceParameter.Name);

      if (lParameter <> nil) and (lParameter.DataType = lSourceParameter.DataType) then
        lParameter.Value := lSourceParameter.Value;

    end;

end;

{------------------------------------------------------------------------------}
{@TppParameterList.EqualTo

  Compares one parameter lists to another and returns true if the lists contain
  the same parameter names and values.}

function TppParameterList.EqualTo(aSource: TppParameterList): Boolean;
var
  liIndex: Integer;
  lParameter: TppParameter;
  lSourceParameter: TppParameter;
begin

  Result := (aSource <> nil) and (aSource.Count = Count);

  liIndex := 0;

  while Result and (liIndex < Count) do
    begin
      lParameter := GetParameterForIndex(liIndex);

      lSourceParameter := aSource.GetParameterForName(lParameter.Name);

      if (lSourceParameter = nil) then
        Result := False
      else
        Result :=  lParameter.EqualTo(lSourceParameter);

      Inc(liIndex);

    end;

end; {function, EqualTo}


{@TppParameterList.Add

  Adds a new parameter to the list and returns the new TppParameter object as
  the result.}

function TppParameterList.Add(aName: String): TppParameter;
begin

  if (GetParameterForName(aName) <> nil) then
    raise EParameterError.CreateFmt('TppParameterList.Add: a Parameter named, %s, already exists.', [aName]);

  Result := TppParameter.Create(nil);
  Result.Parent := Self;

  Result.Name := aName;
  Result.UserName := aName;

end;

function TppParameterList.Add(aName, aValue: String): TppParameter;
begin
  Result := Add(aName, dtString, aValue);

end;


function TppParameterList.Add(aName: String; aDataType: TppDataType; aValue: Variant): TppParameter;
begin

  Result := Add(aName);
  Result.DataType := aDataType;
  Result.Value := aValue;

end;


function TppParameterList.Add(aParameters: TppParameterList): TppParameter;
var
  liIndex: Integer;
  lParam: TppParameter;
begin

  Result := nil;

  for liIndex := 0 to aParameters.Count-1 do
    begin
      lParam := aParameters.ItemsByIndex[liIndex];

      Add(lParam.Name, lParam.DataType, lParam.Value);

      Result := lParam;

    end;

end;

{@TppParameterList.Add

  Adds a new parameter to the list and returns the new TppParameter object as
  the result.}

function TppParameterList.Add: TppParameter;
begin

  Result := TppParameter.Create(Owner);
  Result.Parent := Self;

  Result.Name := Result.GetValidName(Result);
  Result.UserName := Result.Name;

end;

{@TppParameterList.Clear

  Removes and destroys all parameter objects in the list.}

procedure TppParameterList.Clear;
begin
  FreeChildren;

end;

{@TppParameterList.Clear

  Indicates whether any Parameters have AutoSearchSettings.Enabled.}

function TppParameterList.ContainsAutoSearch: Boolean;
var
  liIndex: Integer;
begin
  Result := False;

  for liIndex := 0 to Count - 1 do
    if GetParameterForIndex(liIndex).AutoSearchSettings.Enabled then
      begin
        Result := True;
        Exit;
      end;

end;

{@TppParameterList.GetValueForName}

function TppParameterList.GetValueForName(aName: String): Variant;
var
  lParameter: TppParameter;
begin

  lParameter := GetItemForName(aName);

  if (lParameter <> nil) then
    Result := lParameter.Value
  else
    Result := '';

end;

{@TppParameterList.GetItemForName}

function TppParameterList.GetItemForName(aName: String): TppParameter;
begin

  Result := GetParameterForName(aName);

  {return a dummy null parameter, if no param exist for aName}
  if (Result = nil) and (FInsertMode) then
    begin
      Result := FNullParameter;
      Result.Name := aName;
    end;

  if (Result = nil) then
    raise EParameterError.CreateFmt('TppParameterList.GetItemForName: No parameter named, %s, exists', [aName]);

end;

procedure TppParameterList.GetNames(aStrings: TStrings);
var
  liIndex: Integer;
begin
  for liIndex := 0 to Count - 1 do
    aStrings.Add(ItemsByIndex[liIndex].UserName);
    
end;

procedure TppParameterList.GetVisibleNames(aStrings: TStrings);
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count - 1 do
    begin
      if ItemsByIndex[liIndex].Bindable then
        aStrings.Add(ItemsByIndex[liIndex].UserName);
    end;
end;


{@TppParameterList.GetParameterForIndex}

function TppParameterList.GetParameterForIndex(aIndex: Integer): TppParameter;
begin
  Result := TppParameter(Children[aIndex]);

end;


{@TppParameterList.GetParameterForName}

function TppParameterList.GetParameterForName(aName: String): TppParameter;
var
  liIndex: Integer;
  lParameter: TppParameter;
begin

  Result := nil;
  liIndex := 0;

  while (Result = nil) and (liIndex < ChildCount) do
    begin
      lParameter := TppParameter(Children[liIndex]);

      if AnsiSameText(lParameter.UserName, aName) then
        Result := lParameter
      else if AnsiSameText(lParameter.Name, aName) then
        Result := lParameter
      else
        Inc(liIndex);

    end; {while}


end;

procedure TppParameterList.InitializeForReport(aReport: TppRelative);
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count-1 do
    ItemsByIndex[liIndex].InitializeForReport(aReport);

end;

{@TppParameterList.InList

  Indicates whether a parameter with a specified name appears in the list.}

function TppParameterList.InList(aName: String): Boolean;
begin
  Result := GetParameterForName(aName) <> nil;
end;

{@TppParameterList.Remove

 Removes a named parameter object from the list and destroys it.}

procedure TppParameterList.Remove(aName: String);
var
  lParameter: TppParameter;
begin

  lParameter := GetParameterForName(aName);

  if (lParameter <> nil) then
    lParameter.Free;

end;

{@TppParameterList.Remove

  Removes parameters corresponding to a array of names.}

procedure TppParameterList.Remove(aNames: array of String);
var
  liIndex: Integer;
  lsParameterName: String;
begin

  for liIndex := Low(aNames) to High(aNames) do
    begin

      lsParameterName := aNames[liIndex];

      if InList(lsParameterName) then
        Items[lsParameterName].Free;

    end;

end;

{@TppParameterList.NullParameterValueChangeEvent}

procedure TppParameterList.NullParameterValueChangeEvent(Sender: TObject);
begin

  {add Null parameter to the list}
  FNullParameter.Parent := Self;
  FNullParameter.OnValueChange := nil;

  {create a new null parameter}
  FNullParameter := TppParameter.Create(nil);
  FNullParameter.OnValueChange := NullParameterValueChangeEvent;

end;


{******************************************************************************
 *
 ** P A R A M E T E R  D A T A T Y P E   I N F O
 *
{******************************************************************************}


{@TppParameterDataTypeInfo.IsValidType}

class function TppParameterDataTypeInfo.IsValidType(aDataType: TppDataType): Boolean;
begin
  Result := (aDataType in cValidParameterDataTypes);

end;

{@TppParameterDataTypeInfo.GetEnumName}

class function TppParameterDataTypeInfo.GetEnumName(aDataType: TppDataType): String;
begin
  Result := TypInfo.GetEnumName(TypeInfo(TppDataType), Ord(aDataType));
end;

{@TppParameterDataTypeInfo.GetEnumNames}

class procedure TppParameterDataTypeInfo.GetEnumNames(aList: TStrings);
var
  lDataType: TppDataType;
  lsEnumName: String;
begin

  for lDataType := Low(TppDataType) to High(TppDataType) do

    if IsValidType(lDataType) then
      begin
        lsEnumName := GetEnumName(lDataType);
        aList.Add(lsEnumName)

      end;

end;



{******************************************************************************
 *
 ** P A R A M E T E R  L I S T  R T T I
 *
{******************************************************************************}

{@TraTppParameterListRTTI.RefClass}

class function TraTppParameterListRTTI.RefClass: TClass;
begin
  Result := TppParameterList;
end;

{@TraTppParameterListRTTI.GetPropList}

class procedure TraTppParameterListRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited;

  {add methods}
  aPropList.AddMethod('Assign');
  aPropList.AddMethod('EqualTo');
  
  aPropList.AddMethod('AddName');
  aPropList.AddMethod('Add');
  aPropList.AddMethod('Clear');
  aPropList.AddMethod('InList');
  aPropList.AddMethod('Remove');

  {add public props}
  aPropList.AddProp('Count');
  aPropList.AddProp('InsertMode');
  aPropList.AddProp('Items');
  aPropList.AddProp('ItemsByIndex');
  aPropList.AddProp('Values');


end;

{@TraTppParameterListRTTI.GetPropRec}

class function TraTppParameterListRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin
  Result := True;

  {properties & methods}
  if ppEqual(aPropName, 'Count') then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if ppEqual(aPropName, 'InsertMode') then
    PropToRec(aPropName, daBoolean, False, aPropRec)

  else if ppEqual(aPropName, 'Items')  then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'ItemsByIndex')  then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, '') or ppEqual(aPropName, 'Values') then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if ppEqual(aPropName, 'Assign') then
    MethodToRec(aPropName, True, aPropRec)
    
  else if ppEqual(aPropName, 'EqualTo') then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'AddName') then
    MethodToRec(aPropName, True, aPropRec)
    
  else if ppEqual(aPropName, 'Add') then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'Clear') then
    MethodToRec(aPropName, False, aPropRec)

  else if ppEqual(aPropName, 'InList') then
    MethodToRec(aPropName, True, aPropRec)

  else if ppEqual(aPropName, 'Remove') then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{@TraTppParameterListRTTI.GetParams}

class function TraTppParameterListRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if ppEqual(aMethodName, '') or ppEqual(aMethodName, 'Values') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', False, False);
      Result.AddParam('Result', daVariant, nil, '', False, False);
    end

  else if ppEqual(aMethodName, 'Items') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', False, False);
      Result.AddParam('Result', daClass, TppParameter, '', False, False);
    end
    
  else if ppEqual(aMethodName, 'ItemsByIndex') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TppParameter, '', False, False);
    end

  else if ppEqual(aMethodName, 'Assign') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Source', daObject, TppParameterList, '', False, False);
    end
    
  else if ppEqual(aMethodName, 'EqualTo') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Source', daObject, TppParameterList, '', False, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end

  else if ppEqual(aMethodName, 'AddName') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', False, False);
      Result.AddParam('Result', daClass, TppParameter, '', False, False);
    end

  else if ppEqual(aMethodName, 'Add') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', False, False);
      Result.AddParam('DataType', daEnum, nil, 'TppDataType', False, False);
      Result.AddParam('Value', daVariant, nil, '', False, False);
      Result.AddParam('Result', daClass, TppParameter, '', False, False);
    end
  else if ppEqual(aMethodName, 'InList') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', False, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else if ppEqual(aMethodName, 'Remove') then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Name', daString, nil, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);


end;


{@TraTppParameterListRTTI.GetPropValue}

class function TraTppParameterListRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'Count') then
    Integer(aValue) := TppParameterList(aObject).Count

  else if ppEqual(aPropName, 'InsertMode') then
    Boolean(aValue) := TppParameterList(aObject).InsertMode

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);


end;

{ TraTppParameterListRTTI.SetPropValue }

class function TraTppParameterListRTTI.SetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if ppEqual(aPropName, 'InsertMode') then
    TppParameterList(aObject).InsertMode := Boolean(aValue)

  else
    Result := inherited SetPropValue(aObject, aPropName, aValue);

end; {class function, SetPropValue}


{@TraTppParameterListRTTI.CallMethod}

class function TraTppParameterListRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lParameterList: TppParameterList;
  lParameter: TppParameter;
  lDataType: TppDataType;
  lsName: String;
  liIndex: Integer;
  lvValue: Variant;
  lbResult: Boolean;
begin

  Result := True;

  lParameterList := TppParameterList(aObject);

  if ppEqual(aMethodName, '') or ppEqual(aMethodName, 'Values') then
    begin
      aParams.GetParamValue(0, lsName);
      if aGet then
        begin
          lvValue := lParameterList.Values[lsName];
          aParams.SetParamValue(1, lvValue);
        end
      else
        begin
          aParams.GetParamValue(1, lvValue);
          lParameterList.Items[lsName].Value := lvValue;
        end;

    end

  else if ppEqual(aMethodName, 'Items') then
    begin
      aParams.GetParamValue(0, lsName);

      lParameter := lParameterList.Items[lsName];

      aParams.SetParamValue(1, lParameter);
    end
    
  else if ppEqual(aMethodName, 'ItemsByIndex') then
    begin
      aParams.GetParamValue(0, liIndex);

      lParameter := lParameterList.ItemsByIndex[liIndex];

      aParams.SetParamValue(1, lParameter);
    end

  else if ppEqual(aMethodName, 'AddName') then
    begin
      aParams.GetParamValue(0, lsName);

      lParameter := lParameterList.Add(lsName);

      aParams.SetParamValue(1, lParameter);
    end
    
  else if ppEqual(aMethodName, 'Add') then
    begin
      aParams.GetParamValue(0, lsName);
      aParams.GetParamValue(1, lDataType);
      aParams.GetParamValue(2, lvValue);

      lParameter := lParameterList.Add(lsName, lDataType, lvValue);

      aParams.SetParamValue(3, lParameter);
    end

  else if ppEqual(aMethodName, 'InList') then
    begin
      aParams.GetParamValue(0, lsName);

      lbResult := lParameterList.InList(lsName);

      aParams.SetParamValue(1, lbResult);
    end

  else if ppEqual(aMethodName, 'Clear') then
    lParameterList.Clear

  else if ppEqual(aMethodName, 'Remove') then
    begin
      aParams.GetParamValue(0, lsName);

      lParameterList.Remove(lsName);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);


end;

procedure TppParameter.AssignTo(Dest: TPersistent);
var
  lAsField: TppAutoSearchField;
begin

  if (Dest is TppAutoSearchField) then
    begin

      lAsField := TppAutoSearchField(Dest);

      BeginUpdate;

      try

        lAsField.LookupList := FLookupList;

        if (lAsField.DataType <> FDataType) then
          lAsField.DataType := FDataType;

        FAutoSearchSettings.AssignTo(lAsField);



      finally
        EndUpdate;
      end;


    end
  else
    inherited;

end;

procedure TppParameter.BeginUpdate;
begin
  Inc(FUpdateCount); 
end;

procedure TppParameter.CreateAutoSearchField(aReport: TppRelative);
var
  lDataPipeline: TppDataPipeline;
begin

  if not FAutoSearchSettings.Enabled then Exit;

  if IsUpdating then Exit;

  BeginUpdate;

  try

    FAutoSearchField.Free;
    FAutoSearchField := TppAutoSearchField.Create(nil);
    FAutoSearchField.Parent := aReport;
    FAutoSearchField.AddNotify(Self);
    FAutoSearchField.OnChange := ehAutoSearchField_Change;

    AssignTo(FAutoSearchField);

    if (FAutoSearchField.DataView = nil) then
      if TraRTTI.GetPropValue(aReport, 'DataPipeline', lDataPipeline) and (lDataPipeline <> nil) then
         FAutoSearchField.DataView := lDataPipeline.DataView;

    if (FAutoSearchField.FieldAlias = '') then
      FAutoSearchField.FieldAlias := UserName;
      
  finally
    EndUpdate;
  end;

end;

{------------------------------------------------------------------------------}
{ TppParameter.DefineProperties}

procedure TppParameter.DefineProperties(Filer: TFiler);
begin

  inherited DefineProperties(Filer);

  // conversion to RB 11
  Filer.DefineProperty('PickList.Strings', ReadPickList, nil, false);

end;

procedure TppParameter.ehAutoSearchField_Change(Sender: TObject);
begin

  if IsUpdating then Exit;

  BeginUpdate;

  try

    // update autosearch settings
    FAutoSearchSettings.Assign(FAutoSearchField);

  finally
    EndUpdate;

  end;

  // notify observers
  DoOnValueChange;

end;

procedure TppParameter.EndUpdate;
begin
  if (FUpdateCount > 0) then
    Dec(FUpdateCount);

end;

{------------------------------------------------------------------------------}
{ TppParameter.EventNotify }

procedure TppParameter.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

end; {procedure, EventNotify}

function TppParameter.GetAutoSearchSettings: TppAutoSearchSettings;
begin

  // keep these in sync
  Result := FAutoSearchSettings;

end;

function TppParameter.GetLookupSettings: TppLookupSettings;
begin
  Result := FLookupList.LookupSettings;
end;

{@TraTppParameterListRTTI.GetPickList}

function TppParameter.GetPickList: TStrings;
begin
  Result := FLookupList;
    
end;

function TppParameter.GetIsUpdating: Boolean;
begin
  Result := FUpdateCount > 0;
end;

function TppParameter.GetValue: Variant;
begin

  if (FAutoSearchSettings.IsMultiValue) and (FAutoSearchSettings.FValueList.Count > 0) then
    Result := FAutoSearchSettings.FValueList.Values[0]
  else
    Result := FValue;

end;

function TppParameter.GetValueCount: Integer;
begin
  Result := FAutoSearchSettings.FValueList.Count;
end;

function TppParameter.GetValues(Index: Integer): Variant;
begin
  Result := FAutoSearchSettings.FValueList.Values[Index];
end;

procedure TppParameter.InitializeForReport(aReport: TppRelative);
begin

  FAutoSearchField.Free;
  FAutoSearchField := nil;

  if FAutoSearchSettings.Enabled then
    CreateAutoSearchField(aReport)
  else
    FLookupList.BuildList;


end;

{------------------------------------------------------------------------------}
{ TppParameter.Notify }

procedure TppParameter.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  {remove corresponding criteria}
  if (aOperation = ppopRemove) and (aCommunicator = FAutoSearchField) then
    FAutoSearchField := nil;

end; {procedure, Notify}

{------------------------------------------------------------------------------}
{ TppParameter.ReadDataPipelineName }

procedure TppParameter.ReadPickList(Reader: TReader);
begin
  Reader.ReadListBegin;
  FLookupList.BeginUpdate;
  try
    FLookupList.Clear;
    while not Reader.EndOfList do FLookupList.Add(Reader.ReadString);
  finally
    FLookupList.EndUpdate;
  end;
  Reader.ReadListEnd;


end;

{------------------------------------------------------------------------------}
{ TppAutoSearchSettings.ResolvePipelineReferences }

procedure TppParameter.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
begin

  FAutoSearchSettings.ResolvePipelineReferences(aPipelineList);

  LookupSettings.ResolvePipelineReferences(aPipelineList);

end;

procedure TppParameter.SetAutoSearchSettings(const Value: TppAutoSearchSettings);
begin
  FAutoSearchSettings.Assign(Value);
end;

{@TppParameter.SetLookupList}

procedure TppParameter.SetLookupList(const aLookupList: TppLookupList);
begin
  FLookupList.Assign(aLookupList);

end;

procedure TppParameter.SetLookupSettings(const Value: TppLookupSettings);
begin
  FLookupList.LookupSettings := Value;
end;

{@TppParameter.SetPickList}

procedure TppParameter.SetPickList(aPickList: TStrings);
begin
  FLookupList.Assign(aPickList);

end;

{------------------------------------------------------------------------------}
{ TppParameter.SetUserName }

procedure TppParameter.SetUserName(const aUserName: TComponentName);
begin

  inherited SetUserName(aUserName);

  SendDesignMessage(RM_COMPONENTNAMECHANGE, ppWCustomMsg, Self);

end; 

{ TppParameterCollection }

procedure TppParameterCollection.Add(aObject: TppParameter);
begin
  InnerList.Add(aObject);
end;

function TppParameterCollection.GetItemForIndex(aIndex: Integer): TppParameter;
begin
  Result := TppParameter(InnerList[aIndex]);

end;

function TppParameterCollection.IndexOf(aObject: TppParameter): Integer;
begin
  Result := InnerList.IndexOf(aObject);
end;

procedure TppParameterCollection.Remove(aObject: TppParameter);
begin
  InnerList.Remove(aObject);
end;

constructor TppAutoSearchSettings.Create(aParameter: TppParameter);
begin

  inherited Create;

  FParameter := aParameter;
  FSearchOperator :=  soEqual;
  FMandatory := True;
  FValuelist := TppSearchValueList.Create(FParameter);

end;

destructor TppAutoSearchSettings.Destroy;
begin

  FValuelist.Free;
  FValuelist := nil;

  SetDataPipeline(nil);

  inherited;
end;

procedure TppAutoSearchSettings.Assign(aPersistent: TPersistent);
var
  lSource:  TppAutoSearchSettings;
  lAsField: TppAutoSearchField;
begin

  if (aPersistent is TppAutoSearchSettings) then
    begin
      lSource :=  TppAutoSearchSettings(aPersistent);

      SetDataPipeline(lSource.DataPipeline);
      FEnabled := lSource.Enabled;
      FFieldAlias := lSource.FieldAlias;
      FLogicalPrefix := lSource.LogicalPrefix;
      FSearchOperator := lSource.SearchOperator;
      FMandatory := lSource.Mandatory;
      SearchExpression := lSource.SearchExpression;
      FShowAllValues := lSource.ShowAllValues;

    end
  else if (aPersistent is TppAutoSearchField) then
    begin
    
      lAsField := TppAutoSearchField(aPersistent);

      if (lAsField.DataView <> nil) and (lAsField.DataView is TdaDataView) then
        SetDataPipeline(TdaDataView(lAsField.DataView).DataPipelines[0])
      else
        SetDataPipeline(nil);

      FieldAlias := lAsField.FieldAlias;
      FLogicalPrefix := lAsField.LogicalPrefix;
      FSearchOperator := lAsField.SearchOperator;
      FMandatory := lAsField.Mandatory;
      SearchExpression := lAsField.SearchExpression;
      FShowAllValues := lAsField.ShowAllValues;

    end
  else
    inherited;


end;

procedure TppAutoSearchSettings.AssignTo(Dest: TPersistent);
var
  lAsField: TppAutoSearchField;
begin
  if (Dest is TppAutoSearchField) then
    begin

      lAsField := TppAutoSearchField(Dest);

      // optimize to only change props that are different
      if (FDataPipeline <> nil) and (lAsField.DataView <> FDataPipeline.DataView) then
        lAsField.DataView := FDataPipeline.DataView;

      if (lAsField.FieldAlias <> FieldAlias) then
        lAsField.FieldAlias := FieldAlias;

      if (lAsField.LogicalPrefix <> FLogicalPrefix) then
        lAsField.LogicalPrefix := FLogicalPrefix;

      if (lAsField.SearchOperator <> FSearchOperator) then
        lAsField.SearchOperator := FSearchOperator;

      if (lAsField.Mandatory <> FMandatory) then
        lAsField.Mandatory := FMandatory;

      if (lAsField.SearchExpression <> SearchExpression) then
        lAsField.SearchExpression := SearchExpression;

      if (lAsField.ShowAllValues <> FShowAllValues) then
        lAsField.ShowAllValues := FShowAllValues;

    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
{ TppAutoSearchSettings.DefineProperties}

procedure TppAutoSearchSettings.DefineProperties(Filer: TFiler);
var
  lAncestor: TppAutoSearchSettings;

begin

  inherited DefineProperties(Filer);

  if (Filer.Ancestor is TppAutoSearchSettings) then
    lAncestor := TppAutoSearchSettings(Filer.Ancestor)
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

procedure TppAutoSearchSettings.DoOnChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TppAutoSearchSettings.ehDataPipeline_FreeNotify(Sender, aParameters: TObject);
begin
  FDataPipeline := nil;
end;

function TppAutoSearchSettings.GetSearchExpression: String;
begin

  if (csWriting in FParameter.ComponentState) then
    Result := FValueList.CommaText
  else
    Result := FValueList.SearchExpression

end;

function TppAutoSearchSettings.IsMultiValue: Boolean;
begin

  Result := (FSearchOperator in [soInList, soNotInList, soBetween, soNotBetween]);

end;

{------------------------------------------------------------------------------}
{ TppAutoSearchSettings.ReadDataPipelineName }

procedure TppAutoSearchSettings.ReadDataPipelineName(Reader: TReader);
begin
  FDataPipelineName := Reader.ReadString;

end; {procedure, ReadDataPipelineName}

{------------------------------------------------------------------------------}
{ TppAutoSearchSettings.ResolvePipelineReferences }

procedure TppAutoSearchSettings.ResolvePipelineReferences(aPipelineList: TppDataPipelineList);
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

procedure TppAutoSearchSettings.SetDataPipeline(const Value: TppDataPipeline);
begin

  if FDataPipeline = Value then Exit;

  // remove free notify
  if (FDataPipeline <> nil) then
    FDataPipeline.mcFreeNotify.RemoveNotify(ehDataPipeline_FreeNotify);

  FDataPipeline := Value;

  DoOnChange;

  // add free notify
  if (FDataPipeline <> nil) then
    FDataPipeline.mcFreeNotify.AddNotify(ehDataPipeline_FreeNotify);

end;

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetSearchExpression }

procedure TppAutoSearchSettings.SetSearchExpression(const aExpression: String);
begin

  if (csReading in FParameter.ComponentState) then
    FValueList.CommaText := aExpression
  else if not(FUpdating) then
    begin
      FUpdating := True;

      try
        FValueList.SearchExpression := aExpression;

        // update parameter.FValue here
        if (FParameter.DataType = dtString) and not(IsMultiValue) then
          FParameter.FValue := aExpression
        else if (FValueList.Count > 0) then
          FParameter.FValue := FValueList.Values[0];

        DoOnChange;

      finally
        FUpdating := False;

        if (FParameter <> nil) then
          FParameter.DoOnValueChange;

      end;

    end;


end; {procedure, SetSearchExpression}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetSearchOperator }

procedure TppAutoSearchSettings.SetSearchOperator(aOperator: TppSearchOperatorType);
begin

  FSearchOperator := aOperator;

  if (FParameter <> nil) then
    FParameter.DoOnValueChange;

  DoOnChange;

end; {procedure, SetSearchOperator}

{------------------------------------------------------------------------------}
{ TppAutoSearchField.SetShowAllValues }

procedure TppAutoSearchSettings.SetShowAllValues(const Value: Boolean);
begin

  if FUpdating then Exit;

  if (FShowAllValues = Value) then Exit;

  FUpdating := True;

  try
    FShowAllValues := Value;
  finally
    FUpdating := False;

  end;

  // fire event notification
  if (FParameter <> nil) then
    FParameter.DoOnValueChange;

  DoOnChange;

end;


{------------------------------------------------------------------------------}
{ TppAutoSearchSettings.WriteDataPipelineName }

procedure TppAutoSearchSettings.WriteDataPipelineName(Writer: TWriter);
begin
  if (FDataPipeline <> nil) then
    Writer.WriteString(FDataPipeline.Name)
  else
    Writer.WriteString('');

end; {procedure, WriteDataPipelineName}


initialization
  RegisterClasses([TppParameter, TppParameterList, TppAutoSearchSettings]);
  raRegisterRTTI(TraTppParameterListRTTI);

finalization
  UnRegisterClasses([TppParameter, TppParameterList, TppAutoSearchSettings]);
  raUnRegisterRTTI(TraTppParameterListRTTI);

end.
 
