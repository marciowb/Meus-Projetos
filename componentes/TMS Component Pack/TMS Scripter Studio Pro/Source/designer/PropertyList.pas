{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit PropertyList;

{$I ASCRIPT.INC}

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE VERSION4}
{$ENDIF}

interface

uses
  Windows, Classes, SysUtils,
  {$IFDEF DELPHI6_LVL}
  Variants,
  {$ENDIF}
  TypInfo, Graphics, Controls, Forms, Menus,
  DB, DBTables, ADODB;

resourcestring
  strPropListInvalidValue = 'Invalid property value. %s';

const
  /// Summary:
  ///   Set constant containing all types that are considered ordinals, which means they can be converted to/from an integer value.
  tkOrdinals = [tkInteger, tkChar, tkEnumeration, tkSet, tkClass, tkWChar];

  /// Summary:
  ///   Set constant containing all types that are chars.
  tkChars = [tkChar, tkWChar];

  /// Summary:
  ///   Set constant containing all string types.
  tkStrings = [tkString, tkLString, tkWString
    {$IFDEF DELPHI2009_LVL},tkUString{$ENDIF}];

  PROP_DATAFIELD = 'DATAFIELD';
  PROP_TABLENAME = 'TABLENAME';
  PROP_DATABASENAME = 'DATABASENAME';

type
  /// Summary:
  ///   Exception class raised when internal errors occur while using the property list objects.
  EPropertyException = class(Exception);

  TPropertyList = class;
  TProperty = class;

  /// Summary:
  ///   Event type used to implement a custom property. Handlers of this event should retrieve a value for the specified property.
  /// Parameters:
  ///   AInstance - The instance of object which owns the specified property.
  ///   Prop - The property for which the value must be provided.
  /// Return Value:
  ///   The value of the specified property.
  /// See Also:
  ///   TCustomPropData; RegisterCustomProperty
  TGetPropertyValue = function(AInstance: TPersistent; Prop: TProperty): string;

  /// Summary:
  ///   Event type used to implement a custom property. Handlers of this event should set the value for the specified property.
  /// Parameters:
  ///   AInstance - The instance of object which owns the specified property.
  ///   Prop - The property that will have its value set. 
  ///   Value - The value that must be set to the specified property.
  /// See Also:
  ///   TCustomPropData; RegisterCustomProperty
  TSetPropertyValue = procedure(AInstance: TPersistent; Prop: TProperty; Value: string);
                         
  /// Summary:
  ///   A TCustomPropData object holds information about a registered custom property.
  /// Description:
  ///   When the programmer registers a custom property using RegisterCustomProperty procedure, a TCustomPropData object
  ///   is created to hold all information needed for the custom property to operate. This object is used internally by
  ///   the TProperty object. 
  /// See Also:
  ///   RegisterCustomProperty
  TCustomPropData = class
  public
    /// Summary:
    ///   Holds the class type for which the custom property will be created.
    InstanceType: TClass;

    /// Summary:
    ///   Holds the name of the custom property
    PropName: string;

    /// Summary:
    ///   Holds the type information about the custom property.
    PropType: PTypeInfo;

    /// Summary:
    ///   Specify if the registered custom property will also appear in descending classes.
    Descendants: Boolean;
    
    /// Summary:
    ///   Specifies the procedure which will be used to emulate a getter for the property.
    GetProc: TGetPropertyValue;

    /// Summary:
    ///   Specifies the procedure which will be used to emulate a setter for the property. 
    SetProc: TSetPropertyValue;
    
    /// Summary:
    ///   Instantiates the TCustomPropData passing all the needed data.
    constructor Create(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; 
      ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
  end;

  /// Summary:
  ///   TProperty represents a property in an object instance.
  /// Description:
  ///   A TProperty object encapsulates an existing property of an object. It provides methods to read and write
  ///   property values in different formats, and also provides information about the property, like its default value,
  ///   its type information, among others. The property might be a real property of the object, or can be a custom or
  ///   emulated property.
  TProperty = class
  private
    FOwner: TPropertyList;
    FRoot: TComponent;
    FInstance: TPersistent;
    FPropInfo: PPropInfo;
    FTypeData: PTypeData;
    FProperties: TPropertyList;
    FPropData: TCustomPropData;
    // internal property access methods
    function GetEmulated: Boolean;
    function GetCustom: Boolean;
    function GetOwnerProperty: TProperty;
    function GetLevel: Integer;
    // propinfo properties access methods
    function GetPropType: PTypeInfo;
    function GetGetProc: Pointer;
    function GetSetProc: Pointer;
    function GetIsStored: Boolean;
    function GetIndex: SmallInt;
    function GetDefault: LongInt;
    function GetNameIndex: SmallInt;
    function GetName: String;
    function GetFullName: string;
    function GetTypeName: string;
    function GetTypeKind: TTypeKind;
    // properties for ordinal and set types
    function GetOrdType: TOrdType;
    function GetMinValue: Longint;
    function GetMaxValue: Longint;
    // property for set types
    function GetCompType: PTypeInfo;
    // properties for enumeration types
    function GetBaseType: PTypeInfo;
    function GetEnumCount: Integer;
    function GetEName(Value: Integer): string;
    function GetEValue(Value: string): Integer;
    // property for float types
    function GetFloatType: TFloatType;
    // property for short string types
    function GetMaxLength: Byte;
    // properties for class types
    function GetClassType: TClass;
    function GetParentInfo: PTypeInfo;
    function GetUnitName: string;
    // properties for method types
    function GetMethodKind: TMethodKind;
    function GetParamCount: Integer;
    function GetParamFlags(Index: Integer): TParamFlags;
    function GetParamName(Index: Integer): string;
    function GetParamType(Index: Integer): string;
    function GetParameter(Index: Integer): string;
    function GetResultType: string;
    function GetMethodDeclaration: string;
    // properties for interface type
    function GetIntfParent: PTypeInfo;
    function GetIntfFlags: TIntfFlags;
    function GetGUID: TGUID;
    function GetIntfUnit: string;
    {$IFNDEF VERSION3}
    // properties for Int64 type
    function GetMinInt64Value: Int64;
    function GetMaxInt64Value: Int64;
    {$ENDIF}
    // value access methods
    function GetAsFloat: Extended;
    procedure SetAsFloat(const Value: Extended);
    function GetAsMethod: TMethod;
    procedure SetAsMethod(const Value: TMethod);
    function GetAsInteger: Longint;
    procedure SetAsInteger(const Value: Longint);
    function GetAsChar: Char;
    procedure SetAsChar(const Value: Char);
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const Value: Boolean);
    function GetAsObject: TObject;
    procedure SetAsObject(const Value: TObject);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const Value: TDateTime);
    function GetAsDate: TDate;
    procedure SetAsDate(const Value: TDate);
    function GetAsTime: TTime;
    procedure SetAsTime(const Value: TTime);
    function GetAsString: WideString;
    procedure SetAsString(const Value: WideString);
    function GetAsVariant: Variant;
    procedure SetAsVariant(const Value: Variant);
    {$IFNDEF VERSION3}
    function GetAsInterface: IUnknown;
    procedure SetAsInterface(const Value: IUnknown);
    {$ENDIF}
    function IntSetToStr(Value: integer): string;
    function StrToIntSet(Value: string): integer;
    function ObjectToStr(Value: TObject): string;
    function StrToObject(Value: string): TObject;
    function GetAsWChar: WideChar;
    procedure SetAsWChar(const Value: WideChar);
    procedure EnumFieldNames(AValues: TStrings);
    procedure EnumTableNames(AValues: TStrings);
    procedure EnumDatabaseNames(AValues: TStrings);
  public
    /// Summary:
    ///   Creates a new instance of a TProperty object passing the basic needed parameters.
    /// Parameters:
    ///   AOwner - The TPropertyList object which owns this TProperty object
    ///   ARoot - The root object of the property. Usually the owner form of the component instance. See Root property.
    ///   AInstance - The instance of the object which holds the property.
    ///   APropInfo - The RTTI prop info of the property. If this parameter is not provided, the property will be considered as emulated.
    ///   APropData - The TCustomPropData object which will be used to emulate a custom virtual property.
    constructor Create(AOwner: TPropertyList; ARoot,AInstance: TComponent; APropInfo: PPropInfo; APropData: TCustomPropData); virtual;
    destructor Destroy; override;
    
    procedure SetEmulatedOn;
    
    procedure SetEmulatedOff;

    /// Summary:
    ///   Copy the content from another property into this one.
    /// Parameters:
    ///   Source - The source property from which the values will be copied. 
    procedure Assign(Source: TProperty);
    
    /// Summary:
    ///   Creates the internal instance of the property list. Override this method if you want your descendant to use 
    ///   instantiate a different TPropertyList class for the internal property list object.
    function CreatePropertyList: TPropertyList; virtual;
    
    /// Summary:
    ///   Retrieves the propery value in a friendly format. For example, if the property is a menu type property,
    ///   this functions returns '(Menu)'. 
    function DisplayValue: string; virtual;
    
    /// Summary:
    ///   Returns the property value in string format.
    /// Description:
    ///   You don't need to call GetStringValue directly, this method is most used by TProperty descendant classes to 
    ///   override the default behavior of converting a property value into a string. To read/write string values use
    ///   AsString property.
    function GetStringValue: WideString; virtual;
    
    /// Summary:
    ///   Sets the property value using a string value.
    /// Parameters:
    ///   Value - The string value which will be set to the property.
    /// Description:
    ///   You don't need to call SetStringValue directly, this method is most used by TProperty descendant classes to 
    ///   override the default behavior of converting a string to a property value. To read/write string values use
    ///   AsString property.
    procedure SetStringValue(const Value: WideString); virtual;
    
    /// Summary:
    ///   Fill a list of valid string values for the property.
    /// Description:
    ///   Call ValuesList to fill a string list with valid values for the property. For example, if the property is 
    ///   an enumerated type, the enumerated values will be filled in the string.
    procedure ValuesList(const AValues: TStrings); virtual;
    
    /// Summary:
    ///   Returns true if the specified object can be used as a property value. Used for properties of type tkClass.
    /// Description:
    ///   If the property is of type tkClass, then this method returns true if the specified object can be set to the 
    ///   property value. For the object to be compatible, it must be of the same class as the property type (for example,
    ///   a TEdit object is compatible for a property of type TWinControl).
    /// Parameters:
    ///   AObject - The object which will be checked for compatibility with the property.
    /// Return Value:
    ///   True if the object is compatible and property type is tkClass, false otherwise.
    function IsCompatibleObject(AObject: TObject): Boolean;
    
    /// Summary:
    ///   Returns true if the specified type info is compatible with the property. Used for properties of type tkClass.
    /// Description:
    ///   If the property is of type tkClass, then this method returns true if the specified type is compatible with the property. 
    ///   For a type to be compatible, it must be a class type which descends from the current property type. (For example, 
    ///   a TEdit type is compatible for a property of type TWinControl).
    /// Parameters:
    ///   AObject - The type which will be checked for compatibility with the property.
    /// Return Value:
    ///   True if the type is compatible and property type is tkClass, false otherwise.
    function IsCompatibleType(ATypeInfo: PTypeInfo): Boolean;
    
    /// Summary:
    ///   Check if the property type is same or descending of a specified type. Used for properties of type tkClass.
    /// Description:
    ///   If the property is of type tkClass, then this method returns true if the specified property is the same type
    ///   of the specified type, or descends from it. For example, if the property is a TEdit type, then calling this method
    ///   passing TComponent type info will return true, since TEdit "is" type TComponent.
    /// Parameters:
    ///   ATypeInfo - The type info for which the property will be checked to be the same type
    /// Return Value:
    ///   True if the property is of type ATypeInfo, false otherwise. If the property is not of type tkClass, false is returned.
    function IsType(ATypeInfo: PTypeInfo): Boolean;
    
    /// Summary:
    ///   Checks if the property is compatible with another one.
    /// Description:
    ///   Use this method to check if the property is compatible with another property. To be compatible means that both
    ///   properties can receive the same value no matter what is the value. In summary, the properties must be of the same type.
    /// Parameters:
    ///   P - The property which will be checked to be compatible with this one.
    /// Return Value:
    ///   True if properties are compatible, false otherwise.
    function IsCompatible(P: TProperty): Boolean;

    /// Summary:
    ///   Indicates if the property is emulated.
    /// Description:
    ///   An emulated property is a property that is not a real property in the object instance. In short, a property is emulated
    ///   if it doesn't have the internal RTTI information about the property. 
    ///    
    ///   There are two types of emulated properties:
    ///   the one created internally by the property list, and the ones that were registered by the application as virtual properties,
    ///   using RegisterCustomProperty method. This can be verified using the Custom property. 
    ///   
    ///   The emulated properties created internally are for example the subproperties for variant and set properties.
    ///   For a set type property, an emulated boolean subproperty is created for each set element so that each element can be
    ///   individually set or unset as if it was boolean property.
    property Emulated: Boolean read GetEmulated;
    
    /// Summary:
    ///   Indicates if the property is a custom property.
    /// Description:
    ///   A custom property is a property that is not a direct access to a real property of the object instance. Instead, it works
    ///   as a virtual property, where the getter and setter are provided by the programmer using RegisterCustomProperty procedure.
    ///   This way the property is saved and writted in a custom way, and it's up to the programmer where to save and load the values.
    /// See Also:
    ///   RegisterCustomProperty 
    property Custom: Boolean read GetCustom;
    
    /// Summary:
    ///   Contains a reference to the TPropertyList object that holds the current property.
    property Owner: TPropertyList read FOwner;
    
    /// Summary:
    ///   Contains a reference to the owner property of this property, if it exists (if current property is a subproperty).
    /// Description:
    ///   If the property is a subproperty, then it has an owner. The name of a font is an example of subproperties. The Font
    ///   property belongs to an object, and the Name property belongs to the font. So, Font.Name will be the full name of
    ///   the property, Name is a subproperty and its OwnerProperty is Font.
    property OwnerProperty: TProperty read GetOwnerProperty;
    
    /// Summary:
    ///   Indicates the property level in the property/subproperty tree.
    /// Description:
    ///   This property relates to subproperties. A property at "top" level, which means a property that is now owned by another
    ///   property, but instead is a direct property of the object instance, has a level value of 0. A subproperty of that property
    ///   will have level 1, and so on.
    property Level: Integer read GetLevel;

    /// Summary:
    ///   Contains a reference to the root object that owns the object instance.
    /// Description:
    ///   Root contains the component container of the object instance holding the property. The Root property is used for some
    ///   specific tasks, like for example, if the property is an object property (a DataSource property, for example), then Root
    ///   is used to find the data source reference which was assigned using only the datasource name. Usually the Root property
    ///   is the form which contains the components being inspected.
    property Root: TComponent read FRoot write FRoot;
    
    /// Summary:
    ///   The object instance which owns the current property.
    /// Description:
    ///   Instance holds a reference to the object to which this property belongs.
    property Instance: TPersistent read FInstance write FInstance;

    /// Summary:
    ///   Holds the PTypeData information about the property.
    property TypeData: PTypeData read FTypeData;

    /// Summary:
    ///   Holds the PTypeInfo information about the property.
    property PropType: PTypeInfo read GetPropType;
    
    /// Summary:
    ///   Returns a pointer to the GetProc procedure of the property (PropInfo^.GetProc). 
    property GetProc: Pointer read GetGetProc;

    /// Summary:
    ///   Returns a pointer to the SetProc procedure of the property (PropInfo^.SetProc). 
    property SetProc: Pointer read GetSetProc;
    
    /// Summary:
    ///   Returns true if the property is stored, false otherwise.
    property IsStored: Boolean read GetIsStored;
    
    /// Summary:
    ///   Returns PPropInfo^.Index for the property  
    property Index: SmallInt read GetIndex;
    
    /// Summary:
    ///   Retrieves the default value of the property.
    property Default: Integer read GetDefault;
    
    /// Summary:
    ///   Returns PPropInfo^.NameIndex for the property.  
    property NameIndex: SmallInt read GetNameIndex;
    
    /// Summary:
    ///   Provides the name of the property.
    property Name: string read GetName;
    
    /// Summary:
    ///   Provides the full qualified name of the property. If the property is a subproperty, FullName retrieves the
    ///   name of all properties until the current property. For example, Font.Name or Font.Style.fsBold. Use Name property
    ///   to retrieve only the name of the property.
    property FullName: string read GetFullName;
    
    /// Summary:
    ///   Retrieves the name of the property type. For example, 'string', 'boolean' or 'TDatasource'.
    property TypeName: string read GetTypeName;
    
    /// Summary:
    ///   Retrieves the TTypeKind for this property.
    property TypeKind: TTypeKind read GetTypeKind;
    
    /// Summary:
    ///   Retrieves the TOrdType value for this property. If the property is not an ordinal type, then returned value 
    ///   is TOrdType(0)
    property OrdType: TOrdType read GetOrdType;
    
    /// Summary:
    ///   Retrieves the minimum valid ordinal value of the property.
    property MinValue: Longint read GetMinValue;

    /// Summary:
    ///   Retrieves the maximum valid ordinal value of the property.
    property MaxValue: Longint read GetMaxValue;
    
    /// Summary:
    ///   If this property is of type tkEnumareted, the BaseType returns the PTypeInfo of the base type of enumerated type.
    property BaseType: PTypeInfo read GetBaseType;
    
    /// Summary:
    ///   For enumerated properties, returns the number of enumerated items. 
    property EnumCount: Integer read GetEnumCount;

    /// Summary:
    ///   For enumerated properties, returns the name of the indexed enumerated item. 
    property Names[Index: Integer]: string read GetEName;

    /// Summary:
    ///   For enumerated properties, returns the ordinal value of the indexed enumerated item. 
    property Values[Index: string]: Integer read GetEValue;
    
    /// Summary:
    ///   For set properties, returns the TypeData.CompType value.
    property CompType: PTypeInfo read GetCompType;
                                     
    /// Summary:                       
    ///   For float properties, returns the TFloatType value of the property. 
    property FloatType: TFloatType read GetFloatType;
    
    /// Summary:
    ///   For short string properties, return the max length of the string. 
    property MaxLength: Byte read GetMaxLength;
    
    /// Summary:
    ///   For class properties, retrieves the TClass reference of the property type.
    property PropClassType: TClass read GetClassType;
    
    /// Summary:
    ///   For class properties, retrieves the PTypeInfo for the parent class of the property type.
    property ParentInfo: PTypeInfo read GetParentInfo;
    
    {$WARNINGS OFF}
    /// Summary:
    ///   For class properties, retrieves the name of the unit in which the class was declared.
    property UnitName: string read GetUnitName;
    {$WARNINGS ON}

    /// Summary:
    ///   Holds a list of subproperties of this property.
    property Properties: TPropertyList read FProperties;

    /// Summary:
    ///   For method (event) properties, retrieves the TMethodKind value associated with the property.
    property MethodKind: TMethodKind read GetMethodKind;

    /// Summary:
    ///   For method (event) properties, retrieves the number of params of the method/event type.
    property ParamCount: Integer read GetParamCount;

    /// Summary:
    ///   For method (event) properties, retrieves indexed access for the TParamFlags of a param of the method/event type.
    property ParamFlags[Index: Integer]: TParamFlags read GetParamFlags;

    /// Summary:
    ///   For method (event) properties, retrieves the name of the specified parameter of method/event type.
    property ParamNames[Index: Integer]: String read GetParamName;

    /// Summary:
    ///   For method (event) properties, retrieves the type name of the specified parameter of method/event type.
    property ParamTypes[Index: Integer]: String read GetParamType;

    /// Summary:
    ///   For method (event) properties, retrieves the parameter declaration of the specified method/event type.
    ///   This property might return, for example, 'Sender: TObject', 'var Rect: Rect', etc.
    property Parameters[Index: Integer]: String read GetParameter;

    /// Summary:
    ///   For method (event) properties, retrieves the type name of the method result. If the method type is not
    ///   a function, ResultType is an empty string.
    property ResultType: string read GetResultType;

    /// Summary:
    ///   For method (event) properties, retrieves the full method/event declaration. For example: 
    ///   'procedure(Sender: TObject) of object;'
    property MethodDeclaration: string read GetMethodDeclaration;
    
    /// Summary:
    ///   For interface properties, retrieves the PTypeInfo for the parent interface of the property type.
    property IntfParent: PTypeInfo read GetIntfParent;
    
    /// Summary:
    ///   For interface properties, retrieves the TIntfFlags of the property.
    property IntfFlags: TIntfFlags read GetIntfFlags;

    /// Summary:
    ///   For interface properties, retrieves the GUID of the property's interface type.
    property GUID: TGUID read GetGUID;

    /// Summary:
    ///   For interface properties, retrieves the IntfUnit of the property's interface type.
    property IntfUnit: string read GetIntfUnit;

    {$IFNDEF VERSION3}
    /// Summary:
    ///   Retrieves the minimum valid ordinal value of the property, in Int64 type. 
    property MinInt64Value: Int64 read GetMinInt64Value;

    /// Summary:
    ///   Retrieves the maximum valid ordinal value of the property, in Int64 type. 
    property MaxInt64Value: Int64 read GetMaxInt64Value;
    {$ENDIF}

    /// Summary:
    ///   Use this property to read or write the property value as a float format. 
    property AsFloat: Extended read GetAsFloat write SetAsFloat;

    /// Summary:
    ///   Use this property to read or write the property as method/event.  
    property AsMethod: TMethod read GetAsMethod write SetAsMethod;

    /// Summary:
    ///   Use this property to read or write the property as integer.  
    property AsInteger: Longint read GetAsInteger write SetAsInteger;

    /// Summary:                                                
    ///   Use this property to read or write the property as char.  
    property AsChar: Char read GetAsChar write SetAsChar;

    /// Summary:
    ///   Use this property to read or write the property as wide char.  
    property AsWChar: WideChar read GetAsWChar write SetAsWChar;

    /// Summary:
    ///   Use this property to read or write the property as boolean.  
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;

    /// Summary:
    ///   Use this property to read or write the property as object.  
    property AsObject: TObject read GetAsObject write SetAsObject;

    /// Summary:
    ///   Use this property to read or write the property as date/time.  
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;

    /// Summary:
    ///   Use this property to read or write the property as date.  
    property AsDate: TDate read GetAsDate write SetAsDate;

    /// Summary:
    ///   Use this property to read or write the property as time.  
    property AsTime: TTime read GetAsTime write SetAsTime;

    /// Summary:
    ///   Use this property to read or write the property as string.  
    property AsString: WideString read GetAsString write SetAsString;

    /// Summary:
    ///   Use this property to read or write the property as variant.  
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    
    {$IFNDEF VERSION3}
    /// Summary:
    ///   Use this property to read or write the property as interface.  
    property AsInterface: IUnknown read GetAsInterface write SetAsInterface;
    {$ENDIF}
  end;

  /// Summary:
  ///   TCompareMethod is a regular function type used for property sorting operations. The function must compare
  ///   the two provided properties and return the comparison result.
  /// Parameters:
  ///   P1 - First property to be compared.
  ///   P2 - Second property to be compared.
  /// Return Value:
  ///   Returns 0 if the properties are equal, negative if P1 must be sorted before P2, positive value if P1 must be sorted after P2.
  TCompareMethod = function (P1, P2: TProperty): Integer of object;

  /// Summary:
  ///   Holds a list of all properties of a given object instance.
  /// Description:
  ///   TPropertyList holds a list of TProperty objects representing all the properties of an object instance. When the Instance
  ///   property is set to a valid instance, it automatically loads all properties of the instance and updates the list of properties.
  ///   If custom properties are registered for the instance class, they are also created as if it was existing properties of the instance.
  TPropertyList = class
  private
    FOwner: TProperty;
    FProperties: TList;
    FRoot: TComponent;
    FInstance: TComponent;
    function GetOwnerList: TPropertyList;
    function GetLevel: Integer;
    function GetCount: Integer;
    function GetProperty(AIndex: Integer): TProperty;
    procedure SetRoot(const Value: TComponent);
    procedure SetInstance(const Value: TComponent);
    procedure Clear;
    procedure Sort;
  public
    constructor Create(AOwner: TProperty); virtual;
    destructor Destroy; override;
    
    /// Summary:
    ///   Adds a new property in the property list.
    /// Description:
    ///   CreateProperty is called automatically by the Update method when the properties are being enumerated and added 
    ///   automatically. You can override this method for custom property creation or to add additional functionality
    ///   to the create property process. Either APropInfo or APropData parameter must be nil, they are mutually exclusive.
    /// Parameters:
    ///   APropInfo - the RTTI PPropInfo of the property. If nil, then you must provide the custom data to create a custom property.
    ///   APropData - The TCustomPropData used to create a Custom property.
    /// Return Value:
    ///   The newly created TProperty object.
    function CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty; virtual;
    
    /// Summary:
    ///   Used internally by the property list to add emulated properties for variant and set types. 
    procedure AddEmulated(P: TProperty); virtual;
    
    /// Summary:
    ///   Recreates the internal list of properties based on the current instance set.
    procedure Update; virtual;
    
    /// Summary:
    ///   Compares two properties for sorting purposes. This method is used by Sort method to sort the properties in the list.
    ///   By default, the properties are compared by its name (sorted alphabetically). Override this method if you want to implement
    ///   a different sort criteria.
    /// Parameters:
    ///   P1 - First property to be compared.
    ///   P2 - Second property to be compared.
    /// Return Value:
    ///   Zero if properties are equal, negative value if P1 must be sorted before P2, positive value if P1 must be sorted after P2.
    function Compare(P1,P2: TProperty): Integer; virtual;
    
    /// Summary:
    ///   Indicates if a property must be included in the property list or not. By default all properties are included,
    ///   override this method in a descending class if you want to implement some filtering criteria.
    /// Parameters:
    ///   P - The property ot be checked for filtering.
    /// Return Value:
    ///   True if the property must be included in the property list, false if the property must be ignored (filtered).
    function Filter(P: TProperty): Boolean; virtual;

    /// Summary:
    ///   Returns the index of the specified property in the property list.
    /// Parameters:
    ///   Item - The property object.
    /// Return Value:
    ///   Index of the specified property. If the property is not found, -1 is returned.
    function IndexOf(const Item: TProperty): Integer;

    /// Summary:
    ///   Returns the index of a property given its name.
    /// Parameters:
    ///   Name - The name of the searched property.
    /// Return Value:
    ///   Index of the specified property. If the property is not found, -1 is returned.
    function IndexOfName(const Name: string): Integer;

    /// Summary:
    ///   Retrieves the TProperty object given the property name.
    /// Parameters:
    ///   Name - The name of the searched property.
    /// Return Value:
    ///   The associated TProperty object. If the property is not found, nil is returned.
    function FindProperty(const Name: string): TProperty;
    
    /// Summary:
    ///   Provides a reference to the TPropertyList that owns this property.
    /// Description:
    ///   Actually a property list is owned by a TProperty object, which in turn is owned by a property list. So, OwnerList
    ///   retrieves the property list which owns the property that owns this property list.
    property OwnerList: TPropertyList read GetOwnerList;
    
    /// Summary:
    ///   Retrieves the level of this property list.
    /// See Also:
    ///   TProperty.Level
    property Level: Integer read GetLevel;
    
    /// Summary:
    ///   Provides indexed-access to the TProperty objects representing the available properties of the current Instance.
    property Properties[Index: Integer]: TProperty read GetProperty; default;
    
    /// Summary:
    ///   Retrieves the number of available properties in the property list.
    property Count: Integer read GetCount;
    
    /// Summary:
    ///   Retrieves a reference to the TProperty object that owns this property list.
    property Owner: TProperty read FOwner;
    
    /// Summary:
    ///   Contains a reference to the root object that owns the object instance.
    /// Description:
    ///   Root contains the component container of the object instance holding the properties. The Root property is used for some
    ///   specific tasks, like for example, if the property is an object property (a DataSource property, for example), then Root
    ///   is used to find the data source reference which was assigned using only the datasource name. Usually the Root property
    ///   is the form which contains the components being inspected.
    property Root: TComponent read FRoot write SetRoot;

    /// Summary:
    ///   The object instance which holds the list of properties.
    /// Description:
    ///   Instance holds a reference to the object which holds the properties available. Setting this property will automatically
    ///   update the list of properties. The properties are retrieved using RTTI and also checking the custom properties
    ///   registered by the application using RegisterCustomProperty.
    property Instance: TComponent read FInstance write SetInstance;
  end;

/// Summary:
///   Registers a custom (virtual) property for the specified class.
/// Description:
///   You can use this procedure to create a new custom (virtual) property for a specified class. When a list of properties
///   is built for a specific object, all available properties for the object are retrieved using RTTI and added to the property
///   list, and it also includes all custom properties registered for the object class. For example, you can create a new
///   custom property named "MyProp" for the class TEdit. This way, whenever a list of properties for an object is of class TEdit
///   is about to be built, a property named "MyProp" will appear as if it was a real property of the TEdit class. You can
///   then specify custom procedures to read and and write the MyProp value, simulating the getter and the setter of that property.
/// Parameters:
///   AInstanceType - The class for which the custom property will be registered.
///   APropName - The name of the new property.
///   APropType - The PTypeInfo information about the property. This will hold the actual data type of the property.
///   ADescendants - If true, the new property will appear in objects of the specified class, and also objects descending of
///                  the class. If false, only objects of the specified class will have it. 
///                  For example, if the property was registered for a TWinControl, then a TEdit or TButton object
///                  will also display the custom property if ADescendants is true. If it is false, the property will only appear
///                  for TWinControl objects, and TEdit and TButton classes will not show the custom property.
///   AGetProc - A reference to a procedure that will implement the property Getter.
///   ASetProc - A reference to a procedure that will implement the property Setter.
procedure RegisterCustomProperty(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; 
  ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);

/// Summary:
///   Checks if a custom property was already registered for a specified class.
/// Parameters:
///   AInstanceType - The class reference for which the custom property will be checked.
///   APropName - The name of registered property.
/// Return Value:
///   Returns true if a custom property of name APropName has been already registered for the class specified by AInstanceType.
///   Returns false if the property was not registered.
/// See Also:
///   RegisterCustomProperty
function RegisteredProperty(AInstanceType: TClass; APropName: string): Boolean;

/// Summary:
///   Unregisters a custom property previously registered with RegisterCustomProperty. If not property has been registered,
///   nothing happens.
/// Parameters:
///   AInstanceType - The class reference for which the property has been registered.
///   APropName - The name of registered property.
procedure UnregisterCustomProperty(AInstanceType: TClass; APropName: string);

/// Summary:
///   Unregisters all custom properties that has been previously registered with RegisterCustomProperty. 
procedure UnregisterCustomProperties;

implementation

// variant internal functions

const
  VariantNames: array[0..12] of TIdentMapEntry = (
    (Value: varEmpty; Name: 'Unassigned'),
    (Value: varNull; Name: 'Null'),
    (Value: varSmallint; Name: 'Smallint'),
    (Value: varInteger; Name: 'Integer'),
    (Value: varSingle; Name: 'Single'),
    (Value: varDouble; Name: 'Double'),
    (Value: varCurrency;  Name: 'Currency'),
    (Value: varDate; Name: 'Date'),
    (Value: varOleStr; Name: 'OleStr'),
    (Value: varBoolean; Name: 'Boolean'),
    (Value: varUnknown; Name: 'Unknown'),
    (Value: varByte; Name: 'Byte'),
    (Value: varString; Name: 'String'));

function VariantName(AType: Integer): string;
begin
  IntToIdent(AType,Result,VariantNames);
end;

function VariantType(AName: string): Integer;
begin
  IdentToInt(AName,Result,VariantNames);
end;

const
  ModalResults: array[mrNone..mrYesToAll] of TIdentMapEntry = (
    (Value: 0; Name: 'mrNone'),
    (Value: mrOk; Name: 'mrOk'),
    (Value: mrCancel; Name: 'mrCancel'),
    (Value: mrAbort; Name: 'mrAbort'),
    (Value: mrRetry; Name: 'mrRetry'),
    (Value: mrIgnore; Name: 'mrIgnore'),
    (Value: mrYes; Name: 'mrYes'),
    (Value: mrNo; Name: 'mrNo'),
    (Value: mrAll; Name: 'mrAll'),
    (Value: mrNoToAll; Name: 'mrNoToAll'),
    (Value: mrYesToAll; Name: 'mrYesToAll'));

function ModalResultToIdent(ModalResult: Integer; var Ident: string): Boolean;
begin
  Result:=IntToIdent(ModalResult,Ident,ModalResults);
end;

{function IdentToModalResult(const Ident: string; var ModalResult: Integer): Boolean;
begin
  Result:=IdentToInt(Ident,ModalResult,ModalResults);
end;}

function ModalResultToString(ModalResult: TModalResult): string;
begin
  if not IntToIdent(ModalResult,Result,ModalResults) then Result:=IntToStr(ModalResult);
end;

function StringToModalResult(Ident: string): Integer;
begin
  if not IdentToInt(Ident,Result,ModalResults) then Result:=StrToInt(Ident);
end;

constructor TCustomPropData.Create(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
begin
  inherited Create;
  InstanceType:=AInstanceType;
  PropName:=APropName;
  PropType:=APropType;
  Descendants:=ADescendants;
  GetProc:=AGetProc;
  SetProc:=ASetProc;
end;

type
  TCustomPropertiesList = class(TList)
    function GetPropertyData(AInstanceType: TClass; APropName: string): TCustomPropData;
    function FindProperty(AInstanceType: TClass; APropName: string): TCustomPropData;
  end;

function TCustomPropertiesList.GetPropertyData(AInstanceType: TClass; APropName: string): TCustomPropData;
var
  i: Integer;
  AType: TClass;
begin
  Result:=nil;
  APropName:=AnsiUpperCase(APropName);
  AType:=AInstanceType;
  while Assigned(AType) do
  begin
    for i:=0 to Pred(Count) do
      with TCustomPropData(Items[i]) do
        if (AType=InstanceType) and
          (APropName=AnsiUpperCase(PropName)) and
          ((AType=AInstanceType) or Descendants) then
        begin
          Result:=Items[i];
          Exit;
        end;
    AType:=AType.ClassParent;
  end;
end;

function TCustomPropertiesList.FindProperty(AInstanceType: TClass; APropName: string): TCustomPropData;
var
  i: Integer;
begin
  Result:=nil;
  APropName:=AnsiUpperCase(APropName);
  for i:=0 to Pred(Count) do
    with TCustomPropData(Items[i]) do
      if (AInstanceType=InstanceType) and (APropName=AnsiUpperCase(PropName)) then
      begin
        Result:=Items[i];
        Break;
      end;
end;

var
  _CustomProperties: TCustomPropertiesList;

function CustomProperties: TCustomPropertiesList;
begin
  if _CustomProperties = nil then
    _CustomProperties := TCustomPropertiesList.Create;
  result := _CustomProperties;
end;

procedure RegisterCustomProperty(AInstanceType: TClass; APropName: string; APropType: PTypeInfo; ADescendants: Boolean; AGetProc: TGetPropertyValue; ASetProc: TSetPropertyValue);
begin
  with CustomProperties do
    if not Assigned(FindProperty(AInstanceType,APropName)) then
      Add(TCustomPropData.Create(AInstanceType,APropName,APropType,ADescendants,AGetProc,ASetProc));
end;

function RegisteredProperty(AInstanceType: TClass; APropName: string): Boolean;
begin
  Result:=Assigned(CustomProperties.GetPropertyData(AInstanceType,APropName));
end;

procedure UnregisterCustomProperty(AInstanceType: TClass; APropName: string);
var
  P: TCustomPropData;
begin
  with CustomProperties do
  begin
    P:=FindProperty(AInstanceType,APropName);
    if Assigned(P) then
    begin
      Delete(IndexOf(P));
      P.Free;
    end;
  end;
end;

procedure UnregisterCustomProperties;
var
  i: Integer;
begin
  with CustomProperties do
  begin
    for i:=0 to Pred(Count) do TObject(Items[i]).Free;
    Clear;
  end;
end;

function TProperty.GetEmulated: Boolean;
begin
  Result:=not Assigned(FPropInfo);
end;

function TProperty.GetCustom: Boolean;
begin
  Result:=Assigned(FPropData);
end;

function TProperty.GetOwnerProperty: TProperty;
begin
  if Assigned(Owner) then Result:=Owner.Owner
  else Result:=nil;
end;

function TProperty.GetLevel: Integer;
var
  P: TProperty;
begin
  Result:=0;
  P:=OwnerProperty;
  while Assigned(P) do
  begin
    Inc(Result);
    P:=P.OwnerProperty;
  end;
end;

function TProperty.GetPropType: PTypeInfo;
begin
  if Emulated then
    if Custom then Result:=FPropData.PropType
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkSet: Result:=TypeInfo(Boolean);
        else Result:=nil;
        end
      else Result:=nil
  else Result:=FPropInfo.PropType^;
end;

function TProperty.GetGetProc: Pointer;
begin
  if Emulated then Result:=nil
  else Result:=FPropInfo.GetProc;
end;

function TProperty.GetSetProc: Pointer;
begin
  if Emulated then Result:=nil
  else Result:=FPropInfo.SetProc;
end;

function TProperty.GetIsStored: Boolean;
begin
  if Emulated then Result:=False
  else Result:=Assigned(FPropInfo.StoredProc);
end;

function TProperty.GetIndex: SmallInt;
begin
  if Emulated then Result:=0
  else Result:=FPropInfo.Index;
end;

function TProperty.GetDefault: LongInt;
begin
  if Emulated then Result:=0
  else Result:=FPropInfo.Default;
end;

function TProperty.GetNameIndex: SmallInt;
begin
  if Emulated then Result:=0
  else Result:=FPropInfo.NameIndex;
end;

function TProperty.GetName: String;
begin
  if Emulated then
    if Custom then Result:=FPropData.PropName
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkVariant: Result:='Type';
          tkSet: Result:=GetEnumName(OwnerProperty.CompType,Owner.IndexOf(Self))
        else Result:=''
        end
      else Result:=''
  else Result := string(FPropInfo.Name);
end;

function TProperty.GetFullName: string;
var
  OP: TProperty;
begin
  Result:=Name;
  OP:=OwnerProperty;
  while Assigned(OP) do
  begin
    Result:=OP.Name+'.'+Result;
    OP:=OP.OwnerProperty;
  end;
end;

function TProperty.GetTypeName: string;
begin
  Result := string(PropType.Name);
end;

function TProperty.GetTypeKind: TTypeKind;
begin
  if Emulated then
    if Custom then Result:=FPropData.PropType.Kind
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkSet: Result:=tkEnumeration;
        else Result:=tkUnknown;
        end
      else Result:=tkUnknown
  else Result:=PropType.Kind;
end;

function TProperty.GetOrdType: TOrdType;
begin
  if TypeKind in [tkInteger,tkChar,tkWChar,tkEnumeration,tkSet] then
    Result:=FTypeData.OrdType
  else Result:=TOrdType(0);
end;

function TProperty.GetMinValue: Longint;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      case OwnerProperty.TypeKind of
        tkSet: Result:=Integer(Low(Boolean));
      else Result:=0;
      end
    else Result:=0
  else
    case TypeKind of
      tkInteger,tkChar,tkEnumeration: Result:=FTypeData.MinValue;
      tkSet: Result:=GetTypeData(CompType).MinValue;
    else Result:=0;
    end;
end;

function TProperty.GetMaxValue: Longint;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      case OwnerProperty.TypeKind of
        tkSet: Result:=Integer(High(Boolean));
      else Result:=0;
      end
    else Result:=0
  else
    case TypeKind of
      tkInteger,tkChar,tkEnumeration: Result:=FTypeData.MaxValue;
      tkSet: Result:=GetTypeData(CompType).MaxValue;
    else Result:=0;
    end;
end;

function TProperty.GetBaseType: PTypeInfo;
begin
  if TypeKind=tkEnumeration then Result:=FTypeData.BaseType^
  else Result:=nil;
end;

function TProperty.GetEnumCount: Integer;
begin
  if TypeKind=tkEnumeration then Result:=Succ(MaxValue-MinValue)
  else Result:=0;
end;

function TProperty.GetEName(Value: Integer): string;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      case OwnerProperty.TypeKind of
        tkSet: Result:=GetEnumName(TypeInfo(Boolean),Value);
      else Result:='';
      end
    else Result:=''
  else
    if TypeKind=tkEnumeration then Result:=GetEnumName(PropType,Value)
    else Result:='';
end;

function TProperty.GetEValue(Value: string): Integer;
begin
  if TypeKind=tkEnumeration then Result:=GetEnumValue(PropType,Value)
  else Result:=0;
end;

function TProperty.GetCompType: PTypeInfo;
begin
  if TypeKind=tkSet then Result:=FTypeData.CompType^
  else Result:=nil;
end;

function TProperty.GetFloatType: TFloatType;
begin
  if TypeKind=tkFloat then Result:=FTypeData.FloatType
  else Result:=TFloatType(0);
end;

function TProperty.GetMaxLength: Byte;
begin
  if TypeKind=tkString then Result:=FTypeData.MaxLength
  else Result:=0;
end;

function TProperty.GetClassType: TClass;
begin
  if TypeKind=tkClass then Result:=FTypeData.ClassType
  else Result:=nil;
end;

function TProperty.GetParentInfo: PTypeInfo;
begin
  if TypeKind=tkClass then Result:=FTypeData.ParentInfo^
  else Result:=nil;
end;

function TProperty.GetUnitName: string;
begin
  if TypeKind=tkClass then Result:=string(FTypeData.UnitName)
  else Result:='';
end;

function TProperty.GetMethodKind: TMethodKind;
begin
  if TypeKind=tkMethod then Result:=FTypeData.MethodKind
  else Result:=TMethodKind(0);
end;

function TProperty.GetParamCount: Integer;
begin
  if TypeKind=tkMethod then Result:=FTypeData.ParamCount
  else Result:=0;
end;

function TProperty.GetParamFlags(Index: Integer): TParamFlags;
var
  P: PByte;
  i: Integer;
begin
  Result := [];
  if TypeKind=tkMethod then
  begin
    P := Pointer(@FTypeData.ParamList[0]);
    for i:=0 to Pred(ParamCount) do
    begin
      if i=Index then
      begin
        Result := TParamFlags(P^);
        Break;
      end;
      Inc(P, SizeOf(TParamFlags));
      Inc(P, Length(PShortString(P)^) + 1);
      Inc(P, Length(PShortString(P)^) + 1);
    end;
  end;
end;

function TProperty.GetParamName(Index: Integer): string;
var
  P: PByte;
  i: Integer;
begin
  Result:='';
  if TypeKind = tkMethod then
  begin
    P := Pointer(@FTypeData.ParamList[0]);
    for i:=0 to Pred(ParamCount) do
    begin
      Inc(P, SizeOf(TParamFlags));
      if i=Index then
      begin
        Result := string(PShortString(P)^);
        Break;
      end;
      Inc(P, Length(PShortString(P)^) + 1);
      Inc(P, Length(PShortString(P)^) + 1);
    end;
  end;
end;

function TProperty.GetParamType(Index: Integer): string;
var
  P: PByte;
  i: Integer;
begin
  Result := '';
  if TypeKind = tkMethod then
  begin
    P := Pointer(@FTypeData.ParamList[0]);
    for i:=0 to Pred(ParamCount) do
    begin
      Inc(P, SizeOf(TParamFlags));
      Inc(P, Length(PShortString(P)^) + 1);
      if i=Index then
      begin
        Result := string(PShortString(P)^);
        Break;
      end;
      Inc(P, Length(PShortString(P)^) + 1);
    end;
  end;
end;

function TProperty.GetParameter(Index: Integer): String;
begin
  if TypeKind=tkMethod then
  begin
    Result:='';
    if pfVar in ParamFlags[Index] then Result:=Result+'var ';
    if pfConst in ParamFlags[Index] then Result:=Result+'const ';
    if pfArray in ParamFlags[Index] then Result:=Result+'array of ';
    Result:=Result+ParamNames[Index]+': '+ParamTypes[Index];
  end
  else Result:='';
end;

function TProperty.GetResultType: string;
var
  P: PByte;
  i: Integer;
begin
  if (TypeKind=tkMethod) and (MethodKind=mkFunction) then
  begin
    P := Pointer(@FTypeData.ParamList);
    for i := 0 to Pred(ParamCount) do
    begin
      Inc(P, SizeOf(TParamFlags));
      Inc(P, Length(PShortString(P)^) + 1);
      Inc(P, Length(PShortString(P)^) + 1);
    end;
    Result:= string(PShortString(P)^);
  end
  else Result:='';
end;

function TProperty.GetMethodDeclaration: string;
var
  i: Integer;
begin
  if TypeKind=tkMethod then
  begin
    if MethodKind=mkProcedure then Result:='procedure'
    else Result:='function';
    if ParamCount>0 then
    begin
      Result:=Result+' (';
      for i:=0 to Pred(ParamCount) do
      begin
        Result:=Result+Parameters[i];
        if i<Pred(ParamCount) then Result:=Result+'; '
        else Result:=Result+')';
      end;
    end;
    if MethodKind = mkFunction then
      Result := Result + ': ' + ResultType;
    Result := Result+' of object;'
  end
  else Result:='';
end;

function TProperty.GetIntfParent: PTypeInfo;
begin
  if TypeKind=tkInterface then Result:=FTypeData.IntfParent^
  else Result:=nil;
end;

function TProperty.GetIntfFlags: TIntfFlags;
begin
  if TypeKind=tkInterface then Result:=FTypeData.IntfFlags
  else Result:=[];
end;

function TProperty.GetGUID: TGUID;
begin
  if TypeKind=tkInterface then Result:=FTypeData.GUID
  else FillChar(Result,SizeOf(Result),0);
end;

function TProperty.GetIntfUnit: string;
begin
  if TypeKind=tkInterface then Result := string(FTypeData.IntfUnit)
  else Result:='';
end;

{$IFNDEF VERSION3}

function TProperty.GetMinInt64Value: Int64;
begin
  if TypeKind=tkInt64 then Result:=FTypeData.MinInt64Value
  else Result:=0;
end;

function TProperty.GetMaxInt64Value: Int64;
begin
  if TypeKind=tkInt64 then Result:=FTypeData.MaxInt64Value
  else Result:=0;
end;

{$ENDIF}

function TProperty.GetAsFloat: Extended;
begin
  if TypeKind=tkFloat then Result:=GetFloatProp(Instance,FPropInfo)
  else Result:=0;
end;

procedure TProperty.SetAsFloat(const Value: Extended);
begin
  if TypeKind=tkFloat then SetFloatProp(Instance,FPropInfo,Value);
end;

function TProperty.GetAsMethod: TMethod;
begin
  if TypeKind=tkMethod then Result:=GetMethodProp(Instance,FPropInfo)
  else FillChar(Result,SizeOf(Result),0);
end;

procedure TProperty.SetAsMethod(const Value: TMethod);
begin
  if TypeKind=tkMethod then SetMethodProp(Instance,FPropInfo,Value);
end;

function TProperty.GetAsInteger: Longint;
begin
  if Emulated and Custom then
  begin
    Case TypeKind of
      tkSet:
        Result := StrToIntSet(FPropData.GetProc(Instance,Self));
    else
      Result := StrToInt(FPropData.GetProc(Instance,Self));
    end;
  end
  else
  begin
    if TypeKind in tkOrdinals then Result := GetOrdProp(Instance,FPropInfo)
    else Result:=0;
  end;
end;

procedure TProperty.SetAsInteger(const Value: Longint);
begin
  if Emulated and Custom then
  begin
    Case TypeKind of
      tkSet:
        FPropData.SetProc(Instance, Self, IntSetToStr(Value));
    else
      FPropData.SetProc(Instance, Self, IntToStr(Value));
    end;
  end
  else
  begin
    if TypeKind in tkOrdinals then SetOrdProp(Instance,FPropInfo,Value);
  end;
end;

function TProperty.GetAsChar: Char;
begin
  if TypeKind in tkChars then Result:=Char(AsInteger)
  else Result:=#0;
end;

procedure TProperty.SetAsChar(const Value: Char);
begin
  if TypeKind in tkChars then AsInteger:=Ord(Value);
end;

function TProperty.GetAsBoolean: Boolean;
begin
  if Emulated and not Custom then
    if Assigned(OwnerProperty) then
      Result:=OwnerProperty.AsInteger and (1 shl Owner.IndexOf(Self)) <> 0
    else Result:=False
  else
    if TypeKind in tkOrdinals then Result:=AsInteger<>0
    else Result:=False;
end;

procedure TProperty.SetAsBoolean(const Value: Boolean);
begin
  if Emulated and not Custom then
  begin
    if Assigned(OwnerProperty) then
      if Value then
        OwnerProperty.AsInteger:=OwnerProperty.AsInteger or 1 shl Owner.IndexOf(Self)
      else
        OwnerProperty.AsInteger:=OwnerProperty.AsInteger and not (1 shl Owner.IndexOf(Self));
  end
  else
    if TypeKind in tkOrdinals then AsInteger:=Longint(Value);
end;

function TProperty.GetAsObject: TObject;
begin
  if Emulated and Custom then
  begin
    result := StrToObject(FPropData.GetProc(Instance, Self));
  end
  else
    if TypeKind=tkClass then Result:=TObject(GetOrdProp(Instance,FPropInfo))
    else Result:=nil;
end;

procedure TProperty.SetAsObject(const Value: TObject);
begin
  if Emulated and Custom then
  begin
    FPropData.SetProc(Instance, Self, ObjectToStr(Value));
  end else
    if TypeKind=tkClass then SetOrdProp(Instance,FPropInfo,Longint(Value));
end;

function TProperty.GetAsDateTime: TDateTime;
begin
  Result:=AsFloat;
end;

procedure TProperty.SetAsDateTime(const Value: TDateTime);
begin
  AsFloat:=Value;
end;

function TProperty.GetAsDate: TDate;
begin
  Result:=Int(AsFloat);
end;

procedure TProperty.SetAsDate(const Value: TDate);
begin
  AsFloat:=Int(Value);
end;

function TProperty.GetAsTime: TTime;
begin
  Result:=Frac(AsFloat);
end;

procedure TProperty.SetAsTime(const Value: TTime);
begin
  AsFloat:=Frac(Value);
end;

function TProperty.GetAsString: WideString;
begin
  Result:=GetStringValue;
end;

procedure TProperty.SetAsString(const Value: WideString);
begin
  if AsString<>Value then SetStringValue(Value);
end;

{$IFDEF VERSION3}
{$DEFINE NOGETPROPVALUE}
{$ENDIF}
{$IFDEF VERSION4}
{$DEFINE NOGETPROPVALUE}
{$ENDIF}

function TProperty.GetAsVariant: Variant;
begin
  {$IFNDEF NOGETPROPVALUE}
  Result:=GetPropValue(Instance,Name,False);
  {$ELSE}
  if TypeKind=tkVariant then Result:=GetVariantProp(Instance,FPropInfo)
  else FillChar(Result,SizeOf(Result),0);
  {$ENDIF}
end;

function TProperty.GetAsWChar: WideChar;
begin
  if TypeKind in tkChars then Result := WideChar(AsInteger)
  else Result:=#0;
end;

procedure TProperty.SetAsVariant(const Value: Variant);
begin
  if TypeKind=tkVariant then SetVariantProp(Instance,FPropInfo,Value);
end;

procedure TProperty.SetAsWChar(const Value: WideChar);
begin
  if TypeKind in tkChars then AsInteger := Ord(Value);
end;

{$IFNDEF VERSION3}

function GetInterfaceProperty(Instance: TObject; PropInfo: PPropInfo): IUnknown;
type
  TInterfaceGetProc = function: IUnknown of object;
  TInterfaceIndexedGetProc = function(Index: Integer): IUnknown of object;
var
  P: ^IUnknown;
  M: TMethod;
  Getter: Longint;
begin
  Getter:=Longint(PropInfo^.GetProc);
  if (Getter and $FF000000)=$FF000000 then
  begin
    P:=Pointer(Integer(Instance)+(Getter and $00FFFFFF));
    Result:=P^;
  end
  else
  begin
    if (Getter and $FF000000)=$FE000000 then
      M.Code:=Pointer(PInteger(PInteger(Instance)^+SmallInt(Getter))^)
    else M.Code:=Pointer(Getter);
    M.Data:=Instance;
    if PropInfo^.Index=Integer($80000000) then Result:=TInterfaceGetProc(M)()
    else Result:=TInterfaceIndexedGetProc(M)(PropInfo^.Index);
  end;
end;

procedure SetInterfaceProperty(Instance: TObject; PropInfo: PPropInfo;
  const Value: IUnknown);
type
  TInterfaceSetProc = procedure(const Value: IUnknown) of object;
  TInterfaceIndexedSetProc = procedure (Index: Integer; const Value: IUnknown) of object;
var
  P: ^IUnknown;
  M: TMethod;
  Setter: Longint;
begin
  Setter:=Longint(PropInfo^.SetProc);
  if (Setter and $FF000000)=$FF000000 then
  begin
    P:=Pointer(Integer(Instance)+(Setter and $00FFFFFF));
    P^:=Value;
  end
  else
  begin
    if (Setter and $FF000000)=$FE000000 then
      M.Code:=Pointer(PInteger(PInteger(Instance)^+SmallInt(Setter))^)
    else M.Code:=Pointer(Setter);
    M.Data:=Instance;
    if PropInfo^.Index=Integer($80000000) then TInterfaceSetProc(M)(Value)
    else TInterfaceIndexedSetProc(M)(PropInfo^.Index,Value);
  end;
end;

function TProperty.GetAsInterface: IUnknown;
begin
  Result:=GetInterfaceProperty(Instance,FPropInfo)
end;

procedure TProperty.SetAsInterface(const Value: IUnknown);
begin
  SetInterfaceProperty(Instance,FPropInfo,Value);
end;

{$ENDIF}

constructor TProperty.Create(AOwner: TPropertyList; ARoot,AInstance: TComponent; APropInfo: PPropInfo; APropData: TCustomPropData);
begin
  inherited Create;
  FOwner:=AOwner;
  FRoot:=ARoot;
  FProperties:=CreatePropertyList;
  FProperties.FRoot:=ARoot;
  FInstance:=AInstance;
  FPropInfo:=APropInfo;
  if Emulated then FPropData:=APropData
  else FTypeData:=GetTypeData(PropType);
  if Custom then FTypeData:=GetTypeData(FPropData.PropType);
  case TypeKind of
    tkVariant: FProperties.AddEmulated(Self);
    tkSet: FProperties.AddEmulated(Self);
    tkClass:
      if not IsType(TypeInfo(TComponent)) then FProperties.Instance:=TComponent(AsObject);
  end;
end;

destructor TProperty.Destroy;
begin
  FProperties.Free;
  inherited;
end;

procedure TProperty.Assign(Source: TProperty);
begin
  FRoot:=Source.FRoot;
  FInstance:=Source.FInstance;
  FPropInfo:=Source.FPropInfo;
  FTypeData:=Source.FTypeData;
  FPropData:=Source.FPropData;
end;

function TProperty.CreatePropertyList: TPropertyList;
begin
  Result:=TPropertyList.Create(Self);
end;

function TProperty.DisplayValue: string;
begin
  if TypeKind=tkClass then
    if Assigned(AsObject) then
      if AsObject is TMenuItem then Result:='(Menu)'
      else
        if AsObject is TComponent then Result:=TComponent(AsObject).Name
        else
          if (AsObject is TGraphic) and TGraphic(AsObject).Empty or
            (AsObject is TPicture) and not Assigned(TPicture(AsObject).Graphic) then
              Result:='(None)'
          else Result:='('+AsObject.ClassName+')'
    else Result:=''
  else Result:=AsString;
end;

function TProperty.IntSetToStr(Value: integer): string;
var
  i: integer;
begin
  Result:='[';
  for i:=MinValue to MaxValue do
  begin
    if Value and 1 <> 0 then Result:=Result+GetEnumName(CompType,i)+',';
    Value := Value shr 1;
  end;
  if Result[Length(Result)]=',' then Delete(Result,Length(Result),1);
  Result:=Result+']';
end;

function TProperty.StrToIntSet(Value: string): integer;
var
  Val,Enum: string;
  P, V: Integer;
begin
  Result := 0;
  if Length(Value) > 2 then
  begin
    Val := Value;
    if Val[1] = '[' then Delete(Val, 1, 1);
    if Val[Length(Val)] = ']' then Delete(Val, Length(Val), 1);
    repeat
      P := Pos(',', Val);
      if (P=0) and (Val<>'') then Enum:=Val
      else Enum:=Copy(Val,1,Pred(P));
      Delete(Val,1,P);
      V:=GetEnumValue(CompType, Enum);
      if V=0 then V:=1
      else V:=1 shl V;
      Result:=Result or V;
    until P=0;
  end;
end;

function TProperty.ObjectToStr(Value: TObject): string;
begin
  if Value is TComponent then
  begin
    if Assigned(Value) then
      Result := TComponent(Value).Name
    else
      Result := '';
  end
  else
    Result := IntToStr(Integer(Value));
end;

function TProperty.StrToObject(Value: string): TObject;
begin
  result := nil;
  if (not IsType(TypeInfo(TMenuItem))) or (Uppercase(Name) = 'WINDOWMENU') then
    if IsType(TypeInfo(TComponent)) then
    begin
      if Assigned(FRoot) then
        result := FRoot.FindComponent(Value);
    end
    else
      result := TObject(StrToInt(Value));
end;

function TProperty.GetStringValue: WideString;
var
  i: Integer;
  Val: Longint;
  ObjVal: TObject;
  {$IFNDEF VERSION3}
  Obj: IUnknown;
  {$ENDIF}
begin
  if Emulated then
    if Custom then Result:=FPropData.GetProc(Instance,Self)
    else
      if Assigned(OwnerProperty) then
        case OwnerProperty.TypeKind of
          tkVariant: Result:=VariantName(TVarData(OwnerProperty.AsVariant).VType);
          tkSet: Result:=GetEnumName(TypeInfo(Boolean),Integer(AsBoolean));
        else Result:='';
        end
      else Result:=''
  else
    case TypeKind of
      tkString, tkLString, tkWString{$IFDEF DELPHI2009_LVL}, tkUString{$ENDIF}:
        result := GetStrProp(Instance,FPropInfo);
      tkChar,tkWChar: Result:=AsChar;
      tkInteger:
        if PropType=TypeInfo(TCursor) then Result:=CursorToString(AsInteger)
        else
          if PropType=TypeInfo(TColor) then Result:=ColorToString(AsInteger)
          else
            if PropType=TypeInfo(TShortCut) then
            begin
              Result:=ShortCutToText(AsInteger);
              if Result='' then Result:='(None)';
            end
            else
              if PropType=TypeInfo(TModalResult) then Result:=ModalResultToString(AsInteger)
              else
                //if (PropType<>TypeInfo(TFontCharset)) or not CharsetToIdent(AsInteger,Result) then
                  Result:=IntToStr(AsInteger);
      tkVariant:
        if VarType(AsVariant)<>varNull then Result:=AsVariant
        else Result:='';
      tkEnumeration: Result:=Names[AsInteger];
      tkSet:
      begin
        Val:=AsInteger;
        Result := IntSetToStr(Val);
      end;
      tkFloat:
        if PropType=TypeInfo(TDateTime) then
          if AsFloat<>0 then Result:=DateTimeToStr(AsDateTime)
          else Result:=''
        else
          if PropType=TypeInfo(TDate) then
            if AsFloat<>0 then Result:=DateToStr(AsDate)
            else Result:=''
          else
            if PropType=TypeInfo(TTime) then
              if AsFloat<>0 then Result:=TimeToStr(AsTime)
              else Result:=''
            else Result:=FloatToStr(AsFloat);
      {$IFNDEF VERSION3}
      tkInterface:
      begin
        Result:='';
        if Assigned(Root) then
          with Root do
            for i:=0 to Pred(ComponentCount) do
            begin
              Obj:=nil;
              if (Components[i].GetInterface(GUID,Obj)) and (Obj=AsInterface) then
                Result:=Components[i].Name;
            end;
      end;
      {$ENDIF}
      tkClass:
        begin
          ObjVal := AsObject;
          Result := ObjectToStr(ObjVal);
        end;
      tkMethod:
        if Assigned(FRoot) then Result:=FRoot.MethodName(AsMethod.Code)
        else Result:='';
    else Result:='';
    end;
end;

procedure TProperty.SetStringValue(const Value: WideString);
var
  Result,V: Integer;
  M: TMethod;
  VV: Variant;
  {$IFNDEF VERSION3}
  Comp: TComponent;
  Obj: IUnknown;
  {$ENDIF}
begin
  try
    if Emulated then
    begin
      if Custom then FPropData.SetProc(Instance,Self,Value)
      else
        if Assigned(OwnerProperty) then
          case OwnerProperty.TypeKind of
            tkVariant:
            begin
              VV:=OwnerProperty.AsVariant;
              TVarData(VV).VType:=VariantType(Value);
              OwnerProperty.AsVariant:=VV;
            end;
            tkSet: AsBoolean:=GetEnumValue(TypeInfo(Boolean),Value)<>0;
          end;
    end
    else
      case TypeKind of
        tkString, tkLString, tkWString{$IFDEF DELPHI2009_LVL}, tkUString{$ENDIF}:
          SetStrProp(Instance,FPropInfo,Value);
        tkWChar:
          if Length(Value) > 0 then
            AsWChar := Value[1]
          else
            AsWChar := #0;
        tkChar:
          if Length(Value) > 0 then
            AsChar := Char(Value[1])
          else
            AsChar := #0;
        tkInteger:
          if PropType=TypeInfo(TCursor) then AsInteger:=StringToCursor(Value)
          else
            if PropType=TypeInfo(TColor) then AsInteger:=StringToColor(Value)
            else
              if PropType=TypeInfo(TModalResult) then AsInteger:=StringToModalResult(Value)
              else
                if PropType=TypeInfo(TShortCut) then AsInteger:=TextToShortCut(Value)
                else
                  if (PropType=TypeInfo(TFontCharset)) and IdentToCharset(Value,Result) then
                    AsInteger:=Result
                  else AsInteger:=StrToInt(Value);
        tkVariant: AsVariant:=Value;
        tkEnumeration:
        begin
          V:=Values[Value];
          if (V>=MinValue) and (V<=MaxValue) then AsInteger:=V
          else raise Exception.Create('');
        end;
        tkSet:
          AsInteger := StrToIntSet(Value);
        tkFloat:
        if PropType=TypeInfo(TDateTime) then AsDateTime:=StrToDateTime(Value)
        else
          if PropType=TypeInfo(TDate) then AsDate:=StrToDate(Value)
          else
            if PropType=TypeInfo(TTime) then AsTime:=StrToTime(Value)
            else AsFloat:=StrToFloat(Value);
        tkClass:
          AsObject := StrToObject(Value);
        {$IFNDEF VERSION3}
        tkInterface:
          if Assigned(FRoot) then
          begin
            Comp:=FRoot.FindComponent(Value);
            if Assigned(Comp) then
            begin
              Obj:=nil;
              if Comp.GetInterface(GUID,Obj) then AsInterface:=Obj;
            end;
          end;
        {$ENDIF}
        tkMethod:
          if Assigned(FRoot) then
          begin
            M.Code:=FRoot.MethodAddress(Value);
            M.Data:=FRoot;
            AsMethod:=M;
          end;
      end;
  except
    on E: Exception do
      raise EPropertyException.CreateFmt(strPropListInvalidValue,[E.Message]);
  end;
end;

procedure TProperty.ValuesList(const AValues: TStrings);

{$IFDEF VER150}
{$DEFINE SYSCOLOR}
{$ENDIF}
{$IFDEF VER170}
{$DEFINE SYSCOLOR}
{$ENDIF}

const
  {$IFDEF SYSCOLOR}
  SysColor = clSystemColor;
  {$ELSE}
  SysColor = $80000000;
  {$ENDIF}
var
  i: Integer;
  S: string;
  {$IFNDEF VERSION3}
  Obj: IUnknown;
  {$ENDIF}
begin
  if Assigned(AValues) then
    with AValues do
    begin
      Clear;
      if Emulated and Assigned(OwnerProperty) and (OwnerProperty.TypeKind=tkVariant) then
        for i:=0 to High(VariantNames) do Add(VariantName(VariantNames[i].Value))
      else
        case TypeKind of
          tkString, tkLString, tkWString{$IFDEF DELPHI2009_LVL}, tkUString{$ENDIF}:
            if PropType = TypeInfo(TFontName) then
              Assign(Screen.Fonts)
            else if UpperCase(Name) = PROP_DATAFIELD then
              EnumFieldNames(AValues)
            else if UpperCase(Name) = PROP_TABLENAME then
              EnumTableNames(AValues)
            else if UpperCase(Name) = PROP_DATABASENAME then
              EnumDatabaseNames(AValues);
          tkEnumeration: for i:=MinValue to MaxValue do Add(Self.Names[i]);
          tkInteger:
            if PropType=TypeInfo(TColor) then
            begin
              Add(ColorToString(clBlack));
              Add(ColorToString(clMaroon));
              Add(ColorToString(clGreen));
              Add(ColorToString(clOlive));
              Add(ColorToString(clNavy));
              Add(ColorToString(clPurple));
              Add(ColorToString(clTeal));
              Add(ColorToString(clGray));
              Add(ColorToString(clSilver));
              Add(ColorToString(clRed));
              Add(ColorToString(clLime));
              Add(ColorToString(clYellow));
              Add(ColorToString(clBlue));
              Add(ColorToString(clFuchsia));
              Add(ColorToString(clAqua));
              Add(ColorToString(clWhite));
              for i:=0 to 32 do
                if ColorToIdent(TColor(DWORD(i) or SysColor),S) then Add(S);
            end
            else
              if PropType=TypeInfo(TCursor) then
              begin
                for i:=0 downto -32 do
                  if CursorToIdent(i,S) then Add(S);
              end
              else
                if PropType=TypeInfo(TFontCharset) then
                begin
                  for i:=Low(TFontCharset) to High(TFontCharset) do
                    if CharsetToIdent(i,S) then Add(S);
                end
                else
                  if PropType=TypeInfo(TFontName) then
                  begin
                    for i:=Low(TFontCharset) to High(TFontCharset) do
                      if CharsetToIdent(i,S) then Add(S);
                  end
                  else
                    if PropType=TypeInfo(TShortCut) then
                    begin
                      Add('(None)');
                      for i:=Ord('A') to Ord('Z') do Add(ShortCutToText(ShortCut(i,[ssCtrl])));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(i));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(ShortCut(i,[ssCtrl])));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(ShortCut(i,[ssShift])));
                      for i:=VK_F1 to VK_F12 do Add(ShortCutToText(ShortCut(i,[ssCtrl,ssShift])));
                      Add(ShortCutToText(VK_INSERT));
                      Add(ShortCutToText(ShortCut(VK_INSERT,[ssShift])));
                      Add(ShortCutToText(ShortCut(VK_INSERT,[ssCtrl])));
                      Add(ShortCutToText(VK_DELETE));
                      Add(ShortCutToText(ShortCut(VK_DELETE,[ssShift])));
                      Add(ShortCutToText(ShortCut(VK_DELETE,[ssCtrl])));
                      Add(ShortCutToText(ShortCut(VK_BACK,[ssAlt])));
                      Add(ShortCutToText(ShortCut(VK_BACK,[ssAlt,ssShift])));
                    end
                    else
                      if PropType=TypeInfo(TModalResult) then
                      begin
                        for i:=mrNone to mrYesToAll do
                          if ModalResultToIdent(i,S) then Add(S);
                      end;
          tkClass:
            if Assigned(FRoot) then
              with FRoot do
                for i:=0 to Pred(ComponentCount) do
                  if IsCompatibleObject(Components[i]) then
                    with Components[i] do
                      if Name<>'' then Add(Name);
          {$IFNDEF VERSION3}
          tkInterface:
            if Assigned(FRoot) then
              with FRoot do
                for i:=0 to Pred(ComponentCount) do
                begin
                  Obj:=nil;
                  if Components[i].GetInterface(GUID,Obj) then
                    with Components[i] do
                      if Name<>'' then Add(Name);
                end;
          {$ENDIF}
      end;
    end;
end;

function TProperty.IsCompatibleObject(AObject: TObject): Boolean;
begin
  Result:=IsCompatibleType(AObject.ClassInfo);
end;

function TProperty.IsCompatibleType(ATypeInfo: PTypeInfo): Boolean;
begin
  Result:=False;
  if TypeKind=tkClass then
    while Assigned(ATypeInfo) do
    begin
      Result:=ATypeInfo=PropType;
      if Result then Break;
      with GetTypeData(ATypeInfo)^ do
        if Assigned(ParentInfo) then ATypeInfo:=ParentInfo^
        else ATypeInfo:=nil;
    end;
end;

function TProperty.IsType(ATypeInfo: PTypeInfo): Boolean;
var
  ITypeInfo: PTypeInfo;
begin
  Result:=False;
  ITypeInfo:=PropType;
  if TypeKind=tkClass then
    while Assigned(ITypeInfo) do
    begin
      Result:=ITypeInfo=ATypeInfo;
      if Result then Break;
      with GetTypeData(ITypeInfo)^ do
        if Assigned(ParentInfo) then ITypeInfo:=ParentInfo^
        else ITypeInfo:=nil;
    end;
end;

function TProperty.IsCompatible(P: TProperty): Boolean;
begin
  Result:=Assigned(P) and (FTypeData=P.TypeData);
end;

function TPropertyList.GetOwnerList: TPropertyList;
begin
  if Assigned(Owner) then Result:=Owner.Owner
  else Result:=nil;
end;

function TPropertyList.GetLevel: Integer;
var
  P: TPropertyList;
begin
  Result:=0;
  P:=OwnerList;
  while Assigned(P) do
  begin
    Inc(Result);
    P:=P.OwnerList;
  end;
end;

function TPropertyList.GetProperty(AIndex: Integer): TProperty;
begin
  with FProperties do
    if (AIndex>=0) and (AIndex<Count) then Result:=TProperty(Items[AIndex])
    else Result:=nil;
end;

function TPropertyList.GetCount: Integer;
begin
  Result:=FProperties.Count;
end;

procedure TPropertyList.SetRoot(const Value: TComponent);
begin
  if FRoot<>Value then
  begin
    FRoot:=Value;
    Update;
  end;
end;

procedure TPropertyList.SetInstance(const Value: TComponent);
begin
  if FInstance<>Value then
  begin
    FInstance:=Value;
    Update;
  end;
end;

procedure TPropertyList.Clear;
var
  i: Integer;
begin
  for i:=0 to Pred(Count) do Properties[i].Free;
  FProperties.Clear;
end;

procedure QuickSort(SortList: PPointerList; L,R: Integer; Compare: TCompareMethod);
var
  I,J: Integer;
  P,T: Pointer;
begin
  repeat
    I:=L;
    J:=R;
    P:=SortList^[(L+R) shr 1];
    repeat
      while Compare(SortList^[I],P)<0 do Inc(I);
      while Compare(SortList^[J],P)>0 do Dec(J);
      if I<=J then
      begin
        T:=SortList^[I];
        SortList^[I]:=SortList^[J];
        SortList^[J]:=T;
        Inc(I);
        Dec(J);
      end;
    until I>J;
    if L<J then QuickSort(SortList,L,J,Compare);
    L:=I;
  until I>=R;
end;

procedure TPropertyList.Sort;
begin
  with FProperties do
    if Assigned(List) and (Count>0) then
      QuickSort(List,0,Pred(Count),Compare);
end;

constructor TPropertyList.Create(AOwner: TProperty);
begin
  inherited Create;
  FOwner:=AOwner;
  FProperties:=TList.Create;
end;

destructor TPropertyList.Destroy;
begin
  Clear;
  FProperties.Free;
  inherited;
end;

function TPropertyList.CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty;
begin
  Result:=TProperty.Create(Self,FRoot,FInstance,APropInfo,nil);
end;

procedure TPropertyList.AddEmulated(P: TProperty);
var
  i: Integer;
begin
  with P do
    case TypeKind of
      tkVariant:
        Self.FProperties.Add(TProperty.Create(Self,nil,nil,nil,nil));
      tkSet:
        for i:=MinValue to MaxValue do
          Self.FProperties.Add(TProperty.Create(Self,nil,nil,nil,nil));
    end;
end;

procedure TPropertyList.Update;

  procedure EnumProperties(const Instance: TPersistent);
  var
    Props: PPropList;
    i,Count: Integer;
    Prop: TProperty;
    PropData: TCustomPropData;
  begin
    if Assigned(Instance) then
    begin
      GetMem(Props,GetTypeData(Instance.ClassInfo).PropCount*SizeOf(PPropInfo));
      try
        Count:=GetPropList(Instance.ClassInfo,tkAny,Props);
        for i:=0 to Pred(Count) do
        begin
          if not Assigned(OwnerList) then PropData:=CustomProperties.GetPropertyData(Instance.ClassType, string(Props[i].Name))
          else PropData:=nil;
          if Assigned(PropData) then Prop:=CreateProperty(nil,PropData)
          else Prop:=CreateProperty(Props[i],nil);
          if Filter(Prop) then FProperties.Add(Prop)
          else Prop.Free
        end;
        if not Assigned(OwnerList) then
          with CustomProperties do
            for i:=0 to Pred(Count) do
              with TCustomPropData(Items[i]) do
                if not Assigned(Self.FindProperty(PropName)) then
                begin
                  PropData:=GetPropertyData(Instance.ClassType,PropName);
                  if Assigned(PropData) then
                  begin
                    Prop:=CreateProperty(nil,PropData);
                    if Filter(Prop) then FProperties.Add(Prop)
                    else Prop.Free
                  end;
                end;
      finally
        FreeMem(Props);
      end;
    end;
  end;

begin
  Clear;
  if Assigned(FInstance) and (FInstance.ClassInfo<>nil) then
  begin
    EnumProperties(FInstance);
    Sort;
  end;
end;

function TPropertyList.Compare(P1,P2: TProperty): Integer;
begin
  if Level>0 then Result:=OwnerList.Compare(P1,P2)
  else Result:=CompareStr(P1.Name,P2.Name);
end;

function TPropertyList.Filter(P: TProperty): Boolean;
begin
  Result:=True;
end;

function TPropertyList.IndexOf(const Item: TProperty): Integer;
begin
  Result:=FProperties.IndexOf(Item);
end;

function TPropertyList.IndexOfName(const Name: string): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Pred(Count) do
    if Properties[i].Name=Name then
    begin
      Result:=i;
      Break;
    end;
end;

function TPropertyList.FindProperty(const Name: string): TProperty;

  function DoFindProperty(Name: string; PropertyList: TPropertyList): TProperty;
  var
    P: Integer;
    S: string;
  begin
    if Name<>'' then
      with PropertyList do
      begin
        P:=Pos('.',Name);
        if P=0 then S:=Name
        else S:=Copy(Name,1,Pred(P));
        Result:=Properties[IndexOfName(S)];
        if Assigned(Result) and (P<>0) then
        begin
          Delete(Name,1,P);
          Result:=DoFindProperty(Name,Result.Properties);
        end;
      end
      else Result:=nil;
  end;

begin
  Result:=DoFindProperty(Name,Self);
end;

procedure TProperty.SetEmulatedOff;
begin
  FPropInfo := TypInfo.GetPropInfo(FInstance.ClassInfo, GetName);
end;

procedure TProperty.SetEmulatedOn;
begin
  FPropInfo := nil;
end;

procedure TProperty.EnumFieldNames(AValues: TStrings);
var
  ds: TDataSource;
begin
  if Assigned(Instance) and IsPublishedProp(Instance, 'DataSource') then
  begin
    ds := GetObjectProp(Instance, 'DataSource', TDataSource) as TDataSource;
    {$WARNINGS OFF}
    if Assigned(ds) and Assigned(ds.DataSet) then
      ds.DataSet.GetFieldNames(AValues);
    {$WARNINGS ON}
  end;
end;

procedure TProperty.EnumTableNames(AValues: TStrings);
begin
  if Assigned(Instance) then
  begin
    if Instance is TCustomADODataset then
    begin
      if TCustomADODataset(Instance).Connection <> nil then
        TCustomADODataset(Instance).Connection.GetTableNames(AValues);
    end
    else if (Instance is TDataSet) and IsPublishedProp(Instance, 'DatabaseName') then
      Session.GetTableNames(GetStrProp(Instance, 'DatabaseName'), '*', True, False, AValues);
  end;
end;

procedure TProperty.EnumDatabaseNames(AValues: TStrings);
begin
  if Assigned(Instance) then
    Session.GetDatabaseNames(AValues);
end;

initialization
finalization
  UnregisterCustomProperties;
  _CustomProperties.Free;
  _CustomProperties := nil;
end.

