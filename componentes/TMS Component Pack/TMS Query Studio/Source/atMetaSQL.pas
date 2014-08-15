unit atMetaSQL;

{$I tmsdefs.inc}

interface

uses
  Windows,
  SysUtils,
  Classes,
  atBaseParser,
  {$IFDEF DELPHI6_LVL} Variants, {$ENDIF}
  DB;

type
  EMetaSQLException = class(Exception);
  ESQLParserException = class(Exception);

  TDBLinkType = (ltInnerJoin, ltLeftJoin, ltRightJoin);

  /// Description:
  ///   Defines SQL syntax types (used by TatMetaSQL.SQLSyntax property). Options are:
  ///   - ssCustom: Not used
  ///   - ssBdeLocal: Compatible with BDE Local SQL syntax, like Paradox or DBase.
  ///   - ssAccess: Compatible with Microsoft Access SQL syntax
  ///   - ssOracle: Compatible with Oracle SQL syntax
  ///   - ssInterbase: Compatible with Interbase SQL syntax
  ///   - ssMSSQL: Compatible with Microsoft SQL Server SQL Syntax
  ///   - ssDBISAM: Compatible with DBISAM SQL Syntax
  ///   - ssMySQL: Compatible with MySQL SQL Syntax
  ///   - ssNexus: Compatible with NexusDB SQL Syntax
  ///   - ssAccessADO: Compatible with Microsoft Access ADO SQL Syntax
  ///   - ssDBISAM4: Compatible with DBISAM version 4 SQL Syntax
  ///   - ssFirebird: Compatible with Firebird SQL Syntax
  TatSQLSyntax = (ssCustom, ssBdeLocal, ssAccess, ssOracle, ssInterbase, ssMSSQL,
    ssDBISAM, ssMySQL, ssNexus, ssAccessADO, ssDBISAM4, ssFirebird);

  /// Description:
  ///   Defined aggregated functions to be used in MetaSQL:
  ///   - agfNone: No aggregate function is used
  ///   - agfCount: Count function is used,returning the number of records. Example:  “Count(MyField)”
  ///   - agfSum: Sum function is used, returning the sum of field content for all records returned. Example: “SUM(MyField)”
  ///   - agfMax: Max function is used, returning the max value of field for all records returned. Example: “MAX(MyField)”
  ///   - agfMin: Min function isused, returning the min value of field for all records returned. Example: “MIN(MyField)”
  TatSQLGroupFunction = (agfNone, agfCount, agfSum, agfMax, agfMin, agfAvg);

  TatSQLFunction = (sfMonth, sfYear, sfDay );
  TatSortType = (ortAscending, ortDescending);
  TatSQLJoinSyntax = (alsFrom, alsWhere);

  TatMetaSQL = class;

  TatSqlParam = class;
  TatSqlBaseField = class;
  TatSqlField = class;
  TatSqlTable = class;

  TatSQLBaseField = class(TCollectionItem)
  private
    FFieldAlias: string;
    FActive: boolean;
    function GetMetaSQL: TatMetaSQL;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;

    /// Description:
    ///   Call Assign to copy all properties from one TatSQLBaseField object to another.
    procedure Assign(Source: TPersistent); override;

    property MetaSQL: TatMetaSQL read GetMetaSQL;
    function Field: TatSqlField;
  published
    /// Description:
    ///   FieldAlias property is the ID string that represents field in the field list. FieldAlias must be unique for a field inside the
    ///   field list. Depending on the descendant object of TatSQLBaseField, FieldAlias has a different purpose. For TatSQLField
    ///   objects, FieldAlias is the identifier of the field, being included in SELECT statement as field alias (for example,
    ///   “SELECT C.FIELDNAME AS FIELDALIAS”). For TatSQLOrderField and TatSQLGroupField objects, FieldAlias
    ///   indicates which field will be used for ordering or grouping, based on FieldAlias property of fields defined in SQLFields
    ///   property of TatMetaSQL.
    property FieldAlias: string read FFieldAlias write FFieldAlias;

    /// Description:
    ///   If Active is true, the field will be “used”. Otherwise it will be ignored. For example, only active fields in SQLFields
    ///   property will be included in SELECT clause of SQL statement. Only active order fields in OrderFields property will be
    ///   included in ORDER BY clause and only active group fields in GroupFields property will be included in GROUP BY
    ///   clause.
    property Active: boolean read FActive write FActive default true;
    { remind: complete the assign method on new properties }
  end;

  /// Description:
  ///   Collection of TatSQLBaseField
  /// See Also:
  ///   TatSQLBaseField
  TatSQLBaseFields = class(TOwnedCollection)
  private
    function GetItem(Index: integer): TatSQLBaseField;
    procedure SetItem(Index: integer; Value: TatSQLBaseField);
  public
    /// Description:
    ///   Use Add method to add a new TatSQLOrderField object in collection.
    function Add: TatSQLBaseField;

    procedure Append(ASQLFields : TatSQLBaseFields);

    /// Description:
    ///   Use FindByAlias to find a field when you know its alias. FindByAlias returns a TatSQLBaseField object. AAlias
    ///   parameter is used to search fields by its FieldAlias property. If there is no field with such alias, FindByAlias returns nil.
    function FindByAlias(const AAlias: string): TatSQLBaseField;

    function ActiveCount: integer;

    /// Description:
    ///   Use Items to access individual order fields. The value of the Index parameter corresponds to the Index property of
    ///   TatSQLBaseField. It represents the position of the order field in the order field list.
    property Items[Index: integer]: TatSQLBaseField read GetItem write SetItem; default;
  end;

  /// Description:
  ///   Defines how field expressions will behave on MetaSQL:
  ///   - etStandard: FieldExpression property is read-only and built automatically by meta-sql based on
  ///   properties like TableAlias, FieldAlias, GroupFunction, etc.
  ///   - etCustomExpr: FieldExpression property is read-write, and you must set it by yourself.
  TatSQLFieldExprType = (etStandard, etCustomExpr);
  TatSQLFieldOption = (foHiddenFromUser, foAlwaysInSelect, foCanOrderBy, foCanUseInCondition);

  TatSQLFieldOptions = set of TatSQLFieldOption;

  /// Description:
  ///   TatSQLField holds information about a query field in Meta SQL
  TatSQLField = class(TatSQLBaseField)
  private
    FFieldName: string;
    FTableAlias: string;
    FGroupFunction: TatSQLGroupFunction;
    FDataType: TFieldType;
    FDisplayLabel: string;
    FVisible: boolean;
    FFieldExpression: string;
    FExpressionType: TatSQLFieldExprType;
    FOptions: TatSQLFieldOptions;
    FIndexInSelect: integer;
    function GetFieldExpression: string;
    function IsFieldExpressionStored: Boolean;
    procedure SetFieldExpression(const Value: string);
    procedure SetExpressionType(const Value: TatSQLFieldExprType);
    function GetDisplayLabel: string;
    procedure SetDisplayLabel(const Value: string);
    function IsDisplayLabelStored: Boolean;
    function GetTableAlias: string;
  protected  
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;

    /// Description:
    ///   Call Assign to copy all properties from one TatSQLField object to another.
    procedure Assign(Source: TPersistent); override;

    procedure ChangeFieldAlias(ANewFieldAlias : String);
    procedure ChangeExclusiveFieldAlias( ANewAlias: string );
    procedure CascadeChangeFieldAlias(ANewAlias: string);

    /// Description:
    ///   This function returns true if the field object is “valid”. If ExpressionType property is etStandard, a field is valid if its
    ///   TableAlias property matches the TableAlias property of a table defined in SQLTables property of TatMetaSQL. If
    ///   ExpressionType is etCustomExpr, a field is valid if its FieldExpression property is not empty. Non-valid fields are not
    ///   included in SELECT, ORDER BY or GROUP BY clauses in SQL statement.
    function IsValid: boolean;

    function Table: TatSqlTable;
  published
    /// Description:
    ///   Use ExpressionType property to tell TatMetaSQL how FieldExpression property will behave.
    /// See Also:
    ///   TatSQLFieldExprType
    property ExpressionType: TatSQLFieldExprType read FExpressionType write SetExpressionType default etStandard; // always keep this prop before FieldExpression

    /// Description:
    ///   DataType property must contain the type of field. It is important to TatMetaSQL to know the type of the field in order to
    ///   format conditions (field compared to a value) correctly. Other visual components that are based on TatMetaSQL might
    ///   need to know the type of field.
    property DataType: TFieldType read FDataType write FDataType;

    /// Description:
    ///   FieldName property must contain the physical name of the field in database.
    property FieldName: string read FFieldName write FFieldName;

    /// Description:
    ///   Use DisplayLabel property to set the text to be displayed in GUI interface of your application. Components that are
    ///   based on TatMetaSQL use DisplayLabel to show the name of the field for end-user.
    property DisplayLabel: string read GetDisplayLabel write SetDisplayLabel stored IsDisplayLabelStored;

    /// Description:
    ///   TableAlias indicates from which table the field comes from. The table alias must be an existing table alias defined in
    ///   SQLTables property of TatMetaSQL component. If there is no item in SQLTables property which TableAlias property
    ///   matches with field TableAlias property, the field will be considered inactive and will not be present in SELECT clause
    ///   of SQL.
    property TableAlias: string read GetTableAlias write FTableAlias;

    /// Description:
    ///   Uses GroupFunction property to make a TatSQLField object turn into an aggregated function based on a specified field,
    ///   like SUM(MyField) or AVG(MyField). If GroupFunction is agfNone (default), no aggregated fuction will be used.
    /// See Also:
    ///   TatSQLGroupFunction
    property GroupFunction: TatSQLGroupFunction read FGroupFunction write FGroupFunction default agfNone;

    /// Description:
    ///   FieldExpression property contains the full expression of field, that will be used in SQL statement. For instance,
    ///   FieldExpression might contain “Customer.CustNo”, “SUM(Orders.Value)” or even “C.Quantity * C.Price”. In some
    ///   situations, FieldExpression property is read-only. In other situations, you can set FieldExpression property directly,
    ///   regardless the value of other properties like FieldName or GroupFunction. It depends on the value of ExpressionType
    ///   property.
    property FieldExpression: string read GetFieldExpression write SetFieldExpression stored IsFieldExpressionStored;

    property Visible: boolean read FVisible write FVisible default true;
    property Options: TatSQLFieldOptions read FOptions write FOptions default [foCanOrderBy, foCanUseInCondition];
    { remind: complete the assign method on new properties }
  end;

  /// Description:
  ///   TatSQLOrderField holds information about an order field in Meta SQL
  TatSQLOrderField = class(TatSQLBaseField)
  private
    FSortType: TatSortType;
  public
    /// Description:
    ///   Call Assign to copy all properties from one TatSQLOrderField object to another.
    procedure Assign(Source: TPersistent); override;
  published
    /// Description:
    ///   Use SortType property to set if the order of records based on field will be ascending or descending.
    ///   TatSortType = (ortAscending, ortDescending);
    property SortType: TatSortType read FSortType write FSortType;
    { remind: complete the assign method on new properties }
  end;

  /// Description:
  ///   TatSQLGroupField holds information about a group field in MetaSQL
  TatSQLGroupField = class(TatSQLBaseField)
  end;

  /// Description:
  ///   Collection of TatSQLField.
  /// See Also:
  ///   TatSQLField
  TatSQLFields = class(TatSQLBaseFields)
  private
    FFieldAliasSeparator: String;
    function GetItem(Index: integer): TatSQLField;
    procedure SetItem(Index: integer; Value: TatSQLField);
    procedure SetFieldAliasSeparator(const Value: String);
  protected
    FQualifiedFieldAliases : Boolean;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    /// Description:
    ///   Use Add method to add a new TatSQLField object in collection.
    function Add: TatSQLField;

    /// Description:
    ///   Use FindByAlias to find a field when you know its alias. FindByAlias returns a TatSQLField object. AAlias parameter
    ///   is used to search fields by its FieldAlias property. If there is no field with such alias, FindByAlias returns nil.
    function FindByAlias(const AAlias: string): TatSQLField;

    /// Description:
    ///   Use FindByName to find a field when you know its field name. FindByName returns a TatSQLField object. AName
    ///   parameter is used to search fields by its FieldName property. If there is no field with such name, FindByName returns
    ///   nil. Note that it might be two of more fields with same FieldName (but from different TableAlias). If that happens,
    ///   FindByName will return the field with lower index.
    function FindByName(const AName: string): TatSQLField;

    /// Description:
    ///   Use FindByLabel to find a field when you know its display lable. FindByLabel returns a TatSQLField object.
    ///   ADisplayLabel parameter is used to search fields by its DisplayLabel property. If there is no field with such label,
    ///   FindByLabel returns nil.
    function FindByLabel(const ADisplayLabel: string): TatSQLField;

    /// Description:
    ///   Use FindField to find a field when you know its FieldName and TableAlias. FindField returns a TatSQLField object.
    ///   AName and ATableAlias parameters are used to search fields by its FieldName and TableAlias properties, respectively.
    ///   If there is no field with such name and table alias, FindField returns nil.
    function FindField(const AName, ATableAlias: string): TatSQLField; overload;
    function FindField(const AName, ATableAlias: string; AGroupFunction : TatSQLGroupFunction): TatSQLField; overload;

    /// Description:
    ///   Use AddFromFields method to create metasql fields from a TFields collection indicated by AFields parameter.
    ///   AddFromFields makes use of some properties of TField object, like DisplayLabel, DataType and FieldName. FieldAlias
    ///   property is set with the same value as FieldName. AddFromFields doesn’t clear existing fields.
    procedure AddFromFields(AFields: TFields);

    /// Description:
    ///   GetDisplayLabels method fills a string list represented by AStrings with the display label of all existing fields. One
    ///   string with the DisplayLabel value is added for each field.
    procedure GetDisplayLabels(AStrings: TStrings);

    /// Description:
    ///   Use Items to access individual fields. The value of the Index parameter corresponds to the Index property of
    ///   TatSQLField. It represents the position of the field in the field list.
    property Items[Index: integer]: TatSQLField read GetItem write SetItem; default;

    property FieldAliasSeparator : String read FFieldAliasSeparator write SetFieldAliasSeparator;
  end;

  /// Description:
  ///   Collection of TatSQLOrderField
  /// See Also:
  ///   TatSQLOrderField
  TatSQLOrderFields = class(TatSQLBaseFields)
  private
    function GetItem(Index: integer): TatSQLOrderField;
    procedure SetItem(Index: integer; Value: TatSQLOrderField);
  public
    /// Description:
    ///   Use Add method to add a new TatSQLOrderField object in collection.
    function Add: TatSQLOrderField;

    /// Description:
    ///   Use Items to access individual order fields. The value of the Index parameter corresponds to the Index property of
    ///   TatSQLOrderField. It represents the position of the order field in the order field list.
    property Items[Index: integer]: TatSQLOrderField read GetItem write SetItem; default;
  end;

  /// Description:
  ///   Collection of TatSQLGroupField
  /// See Also:
  ///   TatSQLGroupField
  TatSQLGroupFields = class(TatSQLBaseFields)
  private
    function GetItem(Index: integer): TatSQLGroupField;
    procedure SetItem(Index: integer; Value: TatSQLGroupField);
  public
    /// Description:
    ///   Use Add method to add a new TatSQLGroupField object in collection.
    function Add: TatSQLGroupField;

    /// Description:
    ///   Use Items to access individual group fields. The value of the Index parameter corresponds to the Index property of
    ///   TatSQLGroupField. It represents the position of the group field in the group field list.
    property Items[Index: integer]: TatSQLGroupField read GetItem write SetItem; default;
  end;

  /// Description:
  ///   TatSQLTable holds information about a table in Meta SQL
  TatSQLTable = class(TCollectionItem)
  private
    FTableName: string;
    FTableAlias: string;
    FActive: boolean;
    function GetTableAlias: string;
    procedure DeleteEnvolvedJoins;
  protected
    function GetDisplayName: string; override;
    function GetMetaSql: TatMetaSql;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Call Assign to copy all properties from one TatSQLTable object to another.
    procedure Assign(Source: TPersistent); override;

    procedure ChangeExclusiveTableAlias(ATableAlias: string);
    procedure CascadeChangeTableAlias(ANewAlias: string);
    property MetaSql : TatMetaSql read GetMetaSql;
  published
    /// Description:
    ///   TableName must contain the name of the table in the database.
    property TableName: string read FTableName write FTableName;

    /// Description:
    ///   TableAlias property is the ID string that represents table in the table list. TableAlias must be unique for a table inside the
    ///   table list. TableAlias is the identifier of the table, being included in FROM statement as the table alias (for example,
    ///   “SELECT * FROM TABLE AS TABLEALIAS”).
    property TableAlias: string read GetTableAlias write FTableAlias;

    property Active: boolean read FActive write FActive default true;
    { remind: complete the assign method on new properties }
  end;

  /// Description:
  ///   Collection of TatSQLTable
  /// See Also:
  ///   TatSQLTable
  TatSQLTables = class(TOwnedCollection)
  private
    function GetItem(Index: integer): TatSQLTable;
    procedure SetItem(Index: integer; Value: TatSQLTable);
  public
    function MetaSql: TatMetaSql;

    /// Description:
    ///   Use FindByAlias to find a table object by its alias. FindByAlias returns a TatSQLTable object. AAlias parameter is used
    ///   to search tables by its TableAlias property. If there is no table with such alias, FindByAlias returns nil.
    function FindByAlias(const AAlias: string): TatSQLTable;

    /// Description:
    ///   Use Add method to add a new TatSQLTable object in collection.
    function Add: TatSQLTable;

    /// Description:
    ///   Use Items to access individual tables. The value of the Index parameter corresponds to the Index property of
    ///   TatSQLTable. It represents the position of the table in the order table list.
    property Items[Index: integer]: TatSQLTable read GetItem write SetItem; default;
  end;

  TatLogicalOper = (lgAnd,lgOr);

  /// Description:
  ///  TatConditionType indicates how the condition expression will behave:
  ///  - ctValueCompare: Compares field with value, using FieldAlias, Operator and Value to build expression. For example:
  ///                 FieldAlias = "CustNo"
  ///                 Operator = "="
  ///                 Value = "2"
  ///                 Expression results in "Orders.CustNo = 2"
  ///  - ctFieldCompare: Compares field with field, using FieldAlias, Operator and Value to build expression. Value property
  ///  is used for field alias. For example:
  ///                 FieldAlias = "CustNo"
  ///                 Operator = "="
  ///                 Value = "CustNo_Customer"  <- refers to a field alias
  ///                 Expression results in "Orders.CustNo = Customer.CustNo"
  ///  - ctParamCompare: Compare field with param value, using FieldAlias, Operator and Value properties to build expression.
  ///  Value property is used for param name. MetaSQL will get param value from its Params property.
  ///                 FieldAlias = 'CustNo'
  ///                 Operator = '='
  ///                 Value = 'CustNoParam'   <- refers to a param after using Params.ParamByName('CustNoParam').Value:=10
  ///                 Expression property will return "Orders.CustNo = 10"
  ///  - ctSubConditions: Returns the expression using the subconditions property, ignoring FieldAlias, Operator and Value properties.
  ///  - ctCustomExpr: Uses only Value property to build expression. For example:
  ///                   FieldAlias = "CustNo" //doesnt matter
  ///                   Operator = ">" //doesnt matter
  ///                   Value = "Address is not null"
  ///                   Expression results in "Address is not null"
  ///  - ctTrueExpr: Returns expression "0=0", regardless the content of any property
  ///  - ctFalseExpr: Returns expression "0<>0", regardless the content of any property
  TatConditionType = (ctValueCompare, ctFieldCompare, ctSubConditions, ctCustomExpr, ctParamCompare, ctTrueExpr, ctFalseExpr);

  TatSQLConditions = class;

  TatSQLJoin = class;

  /// Description:
  ///   TatSQLCondition holds information about a filter condition in Meta SQL
  TatSQLCondition = class(TCollectionItem)
  private
    FValue: Variant;
    FOperator: string;
    FFieldAlias: string;
    FName: string;
    FConditionType: TatConditionType;
    FSubConditions: TatSQLConditions;
    FExpression: string;
    FText: string;
    FActive: boolean;
    FNegate: boolean;
    function GetExpression: string;
    function SolvedExpression: string;
    function GetMetaSQL: TatMetaSQL;
    function GetDataType: TFieldType;
    function GetDisplayLabel: string;
    function GetFieldExpr(const AFieldAlias: string): string;
    function GetLogicalOper: TatLogicalOper;
    procedure SetSubConditions(const Value: TatSQLConditions);
    procedure SetExpression(const Value: string);
    procedure SetConditionType(const AValue: TatConditionType);
    function IsExpressionStored: Boolean;
    function GetSubCondLogicalOper: TatLogicalOper;
    procedure SetSubCondLogicalOper(const AValue: TatLogicalOper);

    function GetSQLJoin: TatSQLJoin;
    property SQLJoin: TatSQLJoin read GetSQLJoin;
    procedure SetValue(const AValue: Variant);
    procedure UpdateMetaSQLParams;
    function GetActive: boolean;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    /// Description:
    ///   Call Assign to copy all properties from one TatSQLCondition object to another.
    procedure Assign(Source: TPersistent); override;

    function Field: TatSqlField;

    /// Description:
    ///   DisplayLabel is a read-only property that returns the DisplayLabel property of the field associated to the condition by
    ///   the FieldAlias property.
    property DisplayLabel: string read GetDisplayLabel;

    /// Description:
    ///   DataType is a read-only property that returns the DataType property of the field associated to the condition by the
    ///   FieldAlias property.
    property DataType: TFieldType read GetDataType;

    /// Description:
    ///   TatLogicalOper = (lgAnd,lgOr);
    ///   LogicalOper is a read-only property that returns the LogicalOper property of the TatSQLConditions collections that
    ///   holds the condition object.
    property LogicalOper: TatLogicalOper read GetLogicalOper;

    property MetaSQL: TatMetaSQL read GetMetaSQL;
    {$IFDEF Inheritance}
    property SubConditions: TatSQLConditions read FSubConditions write SetSubConditions;
    procedure DefineProperties(Filer: TFiler); override;
    {$ENDIF}
  published
    /// Description:
    ///   Name property identifies uniquely a condition. When a condition is created, it comes with default name “ConditionX”,
    ///   where X is then index of condition.
    property Name: string read FName write FName;

    /// Description:
    ///   Set FieldAlias property to identify which field will be compared to a specified value. The field alias must exist in
    ///   SQLFields property. FieldAlias property is only used when the ConditionType property is ctFieldCompare,
    ///   ctValueCompare or ctParamCompare.
    property FieldAlias: string read FFieldAlias write FFieldAlias;

    /// Description:
    ///   Operator property contains the operator used to compare a field with a specified value. If you want to compare a field to
    ///   a null value, set operator property to “is null”. Operator property is only used when ConditionType property is
    ///   ctFieldCompare, ctValueCompare or ctParamCompare.
    property Operator: string read FOperator write FOperator;

    /// Description:
    ///   Value property contains the value to be compared to a field. Depending on the value of ConditionType property, Value
    ///   property has different behaviour:
    ///   - ctValueCompare: Field is compared to the value specified in Value property. For example, “Field = 2” (Value property is 2)
    ///   - ctFieldCompare: Field is compared to a field specified in Value property. In this case, Value must contain the field alias,
    ///   and the field must exist in SQLFields property. For example, “C.CustNo = O.CustNo” (Value property is “Orders_CustNo”)
    ///   - ctParamComapre: Field is compared to a value specified by a param. In this case, Value must contain the name of
    ///   param, and the value of param is set using Params property. For example, “Field = 10” (Value property is “MyParam”,
    ///   and the value o param “MyParam” is 10).
    ///   Value property is not used for other condition types.
    property Value: Variant read FValue write SetValue;

    /// Description:
    ///   ConditionType property defines how the Expression property of condition will behave.
    /// See Also:
    ///   TatConditionType
    property ConditionType: TatConditionType read FConditionType write SetConditionType default ctValueCompare;

    /// Description:
    ///   Expression property contains the full expression of condition, that will be directly included in SQL statement.
    ///   Expression property is read-only and TatMetaSQL set its content automatically, depending on value of ConditionType
    ///   property. There are two exceptions: if ConditionType is set to ctCustomExpr, then Expression property is read-write and
    ///   you can set the expression directly. If ConditionType is ctSubConditions, then Expression property is not even used in
    ///   SQL statement.
    property Expression: string read GetExpression write SetExpression stored IsExpressionStored;

    /// Description:
    ///   TatLogicalOper = (lgAnd,lgOr);
    ///   Use SubConditionsLogicalOper property to define how subconditions will be compared regarding the logical operator
    ///   AND/OR, as described in TatLogicalOper type.
    ///   For instance, if you have two subconditions defined in SubConditions property that result in expressions “A=B” and
    ///   “C>2”, SubConditionsLogicalOper property defines if these conditions will result in “A=B AND C>2” or “A=B OR
    ///   C>2” inside WHERE clause (or JOIN clause) of SQL statement.
    property SubConditionsLogicalOper: TatLogicalOper read GetSubCondLogicalOper write SetSubCondLogicalOper default lgAnd;

    {$IFNDEF Inheritance}
    /// Description:
    ///   SubConditions contains a collection of conditions that represents a nested parentesis in SQL statements. For example: a
    ///   metasql contains two conditions, named A and B which expressions are “Field1=10” and “Field2=20”. This will result
    ///   in “Field1=10 AND Field2=20” in SQL statement. Now we take “B” condition and perform some changes: a) Set its
    ///   ConditionType property to ctSubConditions. b) Set its SubConditionsLogicalOper to lgOr. c) Create two conditions
    ///   inside its SubConditions property:  “C” and “D”, which expressions are “Field3=30” and “Field4=40”. Then, result
    ///   WHERE clause (or JOIN clause) in SQL statement will be:
    ///   “Field1=10 AND (Field3=30 OR Field4=40)”.
    ///   Note that Expression property of “B” condition is ignored, but instead subconditions are included, inside parentesis.
    ///   SubConditions property only makes sense if ConditionType is set to ctSubConditions.
    property SubConditions: TatSQLConditions read FSubConditions write SetSubConditions;
    {$ENDIF}

    /// Description:
    ///   Text property is not being used in TatMetaSQL. It is only used by components based on metasql.
    property Text: string read FText write FText;

    /// Description:
    ///   Active property indicates if condition will be included in SQL statement. If Active property is false, the condition will
    ///   be included as expression “0=0” inside SQL statement, and will not influence in data result.
    property Active: boolean read GetActive write FActive default true;

    property Negate: boolean read FNegate write FNegate default false;
    { remind: complete the assign method on new properties }
  end;

  /// Description:
  ///   Collection of TatSQLCondition
  /// See Also:
  ///   TatSQLCondition
  TatSQLConditions = class(TOwnedCollection)
  private
    FMetaSQL: TatMetaSQL;
    FLogicalOperator: TatLogicalOper;
    procedure SetCondition(Index: integer; Value: TatSQLCondition);
    function GetCondition(Index: integer): TatSQLCondition;
    // function FillConditions : REPLACED BY GetConditionStr. {04/12/2003}
    function GetConditionStr(Bracketed: Boolean = false; IdentLevel: integer = 0): string;
    function GetMetaSQL: TatMetaSQL;
    function GetSQLJoin: TatSQLJoin;
    property SQLJoin: TatSQLJoin read GetSQLJoin;
    function GetActiveCondition(Index: integer): TatSQLCondition;
    procedure SetNegate(const Value: Boolean);
    function GetNegate: Boolean;
    function GetLogicalOperator: TatLogicalOper;
  protected
    function MayMergeTo(ALogicOper: tatLogicalOper): Boolean;
  public
    /// Description:
    ///   Use FindByName to find a condition object by its name. FindByName returns a TatSQLCondition object. AName
    ///   parameter is used to search conditions by its Name property. If there is no condition with such name, FindByName
    ///   returns nil.
    function FindByName(const AName: string; Recursive: boolean=true): TatSQLCondition;

    /// Description:
    ///   Use Add method to add a new TatSQLCondition object in collection.
    function Add: TatSQLCondition;

    function ActiveCount : Integer;
    function GetOwner: TPersistent; override;
    property ActiveItems[Index: integer]: TatSQLCondition read GetActiveCondition;

    /// Description:
    ///   Use Items to access individual conditions. The value of the Index parameter corresponds to the Index property of
    ///   TatSQLCondition. It represents the position of the condition in the condition list.
    property Items[Index: integer]: TatSQLCondition read GetCondition write SetCondition; default;

    /// Description:
    ///   TatLogicalOper = (lgAnd,lgOr);
    ///   Use LogicalOper property to define how conditions will be compared regarding the logical operator AND/OR, as
    ///   described in TatLogicalOper type.
    ///   For instance, if you have two conditions that result in expressions “A=B” and “C>2”, LogicalOper property defines if
    ///   these conditions will result in “A=B AND C>2” or “A=B OR C>2” inside WHERE clause (or JOIN clause) of SQL
    ///   statement.
    property LogicalOperator: TatLogicalOper read GetLogicalOperator write FLogicalOperator;

    property Negate : Boolean read GetNegate write SetNegate;
    property MetaSQL: TatMetaSQL read GetMetaSQL;
  end;

  TatSQLJoinType = (altInnerJoin, altLeftJoin, altRightJoin);

  /// Description:
  ///   TatSQLJoin holds information about a query join in Meta SQL
  TatSQLJoin = class(TCollectionItem)
  private
    FPrimaryTableAlias: string;
    FForeignTableAlias: string;
    FLinkType: TatSQLJoinType;
    FJoinConditions: TatSQLConditions;
    function GetJoinCondLogicalOper: TatLogicalOper;
    procedure SetJoinCondLogicalOper(const Value: TatLogicalOper);
    procedure SetJoinConditions(const Value: TatSQLConditions);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    /// Description:
    ///   Call Assign to copy all properties from one TatSQLJoin object to another.
    procedure Assign(Source: TPersistent); override;
  published
    /// Description:
    ///   PrimaryTableAlias must contain the alias of first table to be linked. The table must exist in SQLTables property, and its
    ///   TableAlias property must match with PrimaryTableAlias.
    property PrimaryTableAlias: string read FPrimaryTableAlias write FPrimaryTableAlias;

    /// Description:
    ///   ForeignTableAlias must contain the alias of second table to be linked. The table must exist in SQLTables property, and
    ///   its TableAlias property must match with ForeignTableAlias.
    property ForeignTableAlias: string read FForeignTableAlias write FForeignTableAlias;

    /// Description:
    ///   TatSQLJoinType = (altInnerJoin, altLeftJoin, altRightJoin)
    ///   LinkType property indicates how tables will be joinned (linked). It is directly related to INNER JOIN, LEFT JOIN and
    ///   RIGHT JOIN operators.
    property LinkType: TatSQLJoinType read FLinkType write FLinkType default altInnerJoin;

    /// Description:
    ///   TatLogicalOper = (lgAnd,lgOr);
    ///   Use JoinConditionsLogicalOper property to define how joinconditions will be compared regarding the logical operator
    ///   AND/OR, as described in TatLogicalOper type.
    ///   For instance, if you have two joinconditions defined in JoinConditions property that result in expressions “A=B” and
    ///   “C>2”, JoinConditionsLogicalOper property defines if these conditions will result in “A=B AND C>2” or “A=B OR
    ///   C>2” inside SQL statement.
    property JoinConditionsLogicalOper: TatLogicalOper read GetJoinCondLogicalOper write SetJoinCondLogicalOper default lgAnd;

    /// Description:
    ///   JoinConditions property holds in TatSQLConditions collection the structure of logical conditions that will be included as
    ///   the join conditions in SQL statement. At least one join condition should be included, and that condition must compare a
    ///   field of one table (primary) to the field of the other table (foreign).
    property JoinConditions: TatSQLConditions read FJoinConditions write SetJoinConditions;
    { remind: complete the assign method on new properties }
  end;

  /// Description:
  ///   Collection of TatSQLJoin
  /// See Also:
  ///   TatSQLJoin
  TatSQLJoins = class(TOwnedCollection)
  private
    function GetItem(Index: integer): TatSQLJoin;
    procedure SetItem(Index: integer; Value: TatSQLJoin);
  public
    /// Description:
    ///   Use Add method to add a new TatSQLJoin object in collection.
    function Add: TatSQLJoin;

    /// Description:
    ///   Use FindLink to find a join object by the table alias of the two linked tables. FindLink returns a TatSQLJoin object.
    ///   APrimaryAlias and AForeignAlias parameters are used to search joins by its PrimaryTableAlias and ForeignTableAlias
    ///   properties. If there is no join with such aliases, FindLink returns nil.
    function FindLink(const APrimaryAlias, AForeignAlias: string): TatSQLJoin;

    /// Description:
    ///   Use Items to access individual joins. The value of the Index parameter corresponds to the Index property of TatSQLJoin.
    ///   It represents the position of the join in the join list.
    property Items[Index: integer]: TatSQLJoin read GetItem write SetItem; default;
  end;

  TatSQLParams = class(TParams)
  private
    FOwner: TPersistent;
    function GetItem(i: integer): TatSqlParam;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create; overload;
    constructor Create(AOwner: TPersistent); overload;
    function Add: TatSqlParam;
    property Items[i:integer]:TatSqlParam read GetItem; default;
  end;

  TatSQLParam = class(TParam)
  private
    FActive: boolean;
    FCaption: string;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: string read FCaption write FCaption;
    property Active: boolean read FActive write FActive default true;
    { remind: complete the assign method on new properties }
  end;

  TGetFieldExpressionEvent = procedure(Sender: TObject;
    AField: TatSQLField; var AExpr: string) of object;
  TGetConditionExpressionEvent = procedure(Sender: TObject;
    ACondition: TatSQLCondition; var AExpr: string) of object;

  TSQLSyntaxConf = class(TPersistent)
  private
    FParentesisInJoins: boolean;
    FCaseSensitive: boolean;
    FIndexInGroupBy: boolean;
    FIndexInOrderBy: boolean;
    FSortInnerJoins: boolean;
    FMaskChar: string;
    FLeftJoinStr: string;
    FRightJoinStr: string;
    FDateFormat: string;
    FAsFieldOperator: string;
    FAsTableOperator: string;
    FIDOpenDelim: string;
    FInnerJoinStr: string;
    FUpperFunction: string;
    FIDCloseDelim: string;
    FJoinSyntax: TatSQLJoinSyntax;
    FOnChange: TNotifyEvent;
    procedure SetIDOpenDelim(const Value: string);
    procedure SetAsFieldOperator(const Value: string);
    procedure SetAsTableOperator(const Value: string);
    procedure SetCaseSensitive(const Value: boolean);
    procedure SetDateFormat(const Value: string);
    procedure SetIDCloseDelim(const Value: string);
    procedure SetIndexInGroupBy(const Value: boolean);
    procedure SetIndexInOrderBy(const Value: boolean);
    procedure SetInnerJoinStr(const Value: string);
    procedure SetJoinSyntax(const Value: TatSQLJoinSyntax);
    procedure SetLeftJoinStr(const Value: string);
    procedure SetMaskChar(const Value: string);
    procedure SetParentesisInJoins(const Value: boolean);
    procedure SetRightJoinStr(const Value: string);
    procedure SetSortInnerJoins(const Value: boolean);
    procedure SetUpperFunction(const Value: string);
  protected
    procedure Changed;
  public
    procedure Assign(Source: TPersistent); override;
    procedure LoadPredefinedSyntax(ASyntax: TatSQLSyntax);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property IDOpenDelim: string read FIDOpenDelim write SetIDOpenDelim;
    property IDCloseDelim: string read FIDCloseDelim write SetIDCloseDelim;
    property AsFieldOperator: string read FAsFieldOperator write SetAsFieldOperator;
    property AsTableOperator: string read FAsTableOperator write SetAsTableOperator;
    property MaskChar: string read FMaskChar write SetMaskChar;
    property DateFormat: string read FDateFormat write SetDateFormat;
    property InnerJoinStr: string read FInnerJoinStr write SetInnerJoinStr;
    property LeftJoinStr: string read FLeftJoinStr write SetLeftJoinStr;
    property RightJoinStr: string read FRightJoinStr write SetRightJoinStr;
    property ParentesisInJoins: boolean read FParentesisInJoins write SetParentesisInJoins;
    property JoinSyntax: TatSQLJoinSyntax read FJoinSyntax write SetJoinSyntax;
    property SortInnerJoins: boolean read FSortInnerJoins write SetSortInnerJoins;
    property CaseSensitive: boolean read FCaseSensitive write SetCaseSensitive;
    property IndexInGroupBy: boolean read FIndexInGroupBy write SetIndexInGroupBy;
    property IndexInOrderBy: boolean read FIndexInOrderBy write SetIndexInOrderBy;
    property UpperFunction: string read FUpperFunction write SetUpperFunction;
  end;

  /// Description:
  ///   TatMetaSQL component is a non-visual component that encapsulates an SQL statement in a object-oriented architecture.
  TatMetaSQL = class(TComponent)
  private
    FTables: TatSQLTables;
    FFields: TatSQLFields;
    FLinks: TatSQLJoins;
    FGroupFields: TatSQLGroupFields;
    FOrderFields: TatSQLOrderFields;
    FCustomFilter: string;
    FSQLSyntax: TatSQLSyntax;
    FConditions: TatSQLConditions;
    FParams: TatSQLParams;
    FDistinct: boolean;
    FOnGetConditionExpression: TGetConditionExpressionEvent;
    FOnGetFieldExpression: TGetFieldExpressionEvent;
    FSyntaxConf: TSQLSyntaxConf;
    procedure SetFields(Value: TatSQLFields);
    procedure SetTables(Value: TatSQLTables);
    procedure SetLinks(Value: TatSQLJoins);
    procedure SetGroupFields(Value: TatSQLGroupFields);
    procedure SetOrderFields(Value: TatSQLOrderFields);
    function GetSQLString: string;
    function BuildID(const ID: string): string;
    function BuildAliasID(const ID: string): string;
    procedure SetConditions(const Value: TatSQLConditions);
    function GetCondLogicalOper: TatLogicalOper;
    procedure SetCondLogicalOper(const Value: TatLogicalOper);
    procedure SetParams(const Value: TatSQLParams);
    procedure CreateParams(AParams: TatSQLParams);
    function AddDelimiter(const ID: String): string;
    procedure SetQualifiedFieldAliases(const Value: Boolean);
    function GetQualifiedFieldAliases: Boolean;
    function GetFieldAliasSeparator: String;
    procedure SetFieldAliasSeparator(const Value: String);
    procedure SetSyntaxConf(Value: TSQLSyntaxConf);
    function IsSyntaxConfStored: boolean;
    procedure SetSQLSyntax(const Value: TatSQLSyntax);
  protected
    procedure Loaded; override;
  public
    /// Description:
    ///   Search for Tfield objects in ADataset and update its DisplayLabel property based on display labels defined in TatMetaSQL.
    procedure UpdateDisplayLabels(ADataset: TDataset);

    /// Description:
    ///   Update Params property based on what is defined on metasql conditions. Params are updated automatically when conditions are changed.
    procedure UpdateParams;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// Description:
    ///   Call Assign to copy all properties from one TatMetaSQL component to another.
    procedure Assign(Source: TPersistent); override;

    /// Description:
    ///   If there is any field defined in SQLFields property that has the GroupFunction property defined (different from agfNone)
    ///   than this function returns true. Otherwise returns false.
    function HasAggregatedFields: boolean;

    /// Description:
    ///   SQL property contains the result SQL statement, based on content of metasql.
    property SQL: string read GetSQLString;

    property QualifiedFieldAliases : Boolean read GetQualifiedFieldAliases write SetQualifiedFieldAliases;
    property FieldAliasSeparator : String read GetFieldAliasSeparator write SetFieldAliasSeparator;

    /// Description:
    ///   Clear all meta sql definitions.
    procedure Clear;

    /// Description:
    ///   Returns True if Meta SQL is empty (does not contain source tables).
    function IsEmpty : Boolean;

    /// Description:
    ///   Retrieves the TatSQLTable object which TableAlias property matches AtableAlias parameter.
    function FindTableByAlias(ATableAlias: string): TatSqlTable;

    /// Description:
    ///   Retrieves the TatSQLCondition object which uses/references a parameter which name is given by AparamName parameter.
    function FindConditionByParamName(AParamName: string): TatSqlCondition;

    /// Description:
    ///   Retrieves the TatSQLField object which is envolved in a condition that uses/references a parameter which name is given
    ///   by AparamName parameter.
    function FindFieldByParamName(AParamName: string): TatSqlField;

    /// Description:
    ///   Retrieves the next condition after ACondition in the meta sql condition collection. NextMetaSQLCondition considers
    ///   conditions in join clause and where clause. If ACondition is nil, then NextMetaSQLCondition will retrieve the first
    ///   condition. The found condition is set in ACondition parameter. NextMetaSQLCondition returns True if the next
    ///   condition is found, and returns False if it reaches the end of condition list.
    function NextMetaSqlCondition(var ACondition: TatSqlCondition): boolean;

    /// Description:
    ///   Automatically set group fields of sql, based on fields with aggregated functions. If there are no fields with aggregated
    ///   functions defined, it clears the group fields. If there are some fields with aggregated functions defined, then it includes
    ///   all non-aggregated fields in the group by clause.
    function AutoUpdateGroupFields: boolean;

    {$IFDEF Inheritance}
    procedure DefineProperties(Filer: TFiler); override;
    property SQLTables: TatSQLTables read FTables write SetTables;
    property SQLFields: TatSQLFields read FFields write SetFields;
    property TableJoins: TatSQLJoins read FLinks write SetLinks;
    property Conditions: TatSQLConditions read FConditions write SetConditions;
    property GroupFields: TatSQLGroupFields read FGroupFields write SetGroupFields;
    property OrderFields: TatSQLOrderFields read FOrderFields write SetOrderFields;
    property Params: TatSQLParams read FParams write SetParams;
    {$ENDIF}
  published
    /// Description:
    ///   SQLSyntax property indicates which SQL syntax will be used by TatMetaSQL to generate SQL statement. Use this
    ///   property to generate SQL statement according to the database you are using.
    /// See Also:
    ///   TatSQLSyntax
    property SQLSyntax: TatSQLSyntax read FSQLSyntax write SetSQLSyntax;

    {$IFNDEF Inheritance}
    /// Description:
    ///   SQLTables property holds in TatSQLTables collection the list of tables where records will be queried from.
    ///   This is equivalent to the tables listed in FROM clause of a SQL statement.
    property SQLTables: TatSQLTables read FTables write SetTables;

    /// Description:
    ///   SQLFields property holds in TatSQLFields collection the list of fields that will be manipulated by TatMetaSQL.
    ///   You must include here all fields that will be selected, used for ordering, grouping or filtering. Even if you
    ///   don’t want to include field in Select part of SQL statement, but want to order record by the field, you must
    ///   include field here. If you don’t want field to be selected, you just set Active property to false.
    property SQLFields: TatSQLFields read FFields write SetFields;

    /// Description:
    ///   TableJoins property holds in TatSQLJoins collection the list of joins (links) between tables. Tables to be linked
    ///   must be already defined in SQLTables property. When defining a join, you must define the alias of the tables to be
    ///   linked, and specified at least one condition of type ctFieldCompare, comparing one field from one table to one
    ///   field of another table.
    ///   The joins defined here will appear in the FROM clause of SQL statement, where tables will be linked with INNER
    ///   JOIN, LEFT JOIN or RIGHT JOIN operators. Depending of syntax type defined in SQLSyntax property, the joins might
    ///   appear in the WHERE clause of SQL statement (for example, for Oracle SQL syntax, or when there are no outer joins
    ///   (left/right) defined in metasql).
    property TableJoins: TatSQLJoins read FLinks write SetLinks;

    /// Description:
    ///   Conditions property holds in TatSQLConditions collection the structure of logical conditions that will be included
    ///   in the WHEERE clause of SQL statement. Each condition has a ConditionType property which defines how condition
    ///   expression will be built. A condition also have a SubConditions property in order to define a structure of conditions,
    ///   that will result in nested parentesis in WHERE clause of SQL statement.
    property Conditions: TatSQLConditions read FConditions write SetConditions;

    /// Description:
    ///   GroupFields property holds in *TatSQLGroupFields collection a list of fields used to group the records. Items added
    ///   here will result in fields in GROUP BY clause of SQL statement.
    property GroupFields: TatSQLGroupFields read FGroupFields write SetGroupFields;

    /// Description:
    ///   OrderFields property holds in *TatSQLOrderField collection a list of fields used to order the records. Items added here
    ///   will result in fields in ORDER BY clause of SQL statement.
    property OrderFields: TatSQLOrderFields read FOrderFields write SetOrderFields;
    {$ENDIF}

    /// Description:
    ///   Use CustomFilter property to include any text inside WHERE clause of SQL statement. MetaSQL will put CustomFilter
    ///   content directly inside WHERE clause, with a AND operator and inside parentesis.
    property CustomFilter: string read FCustomFilter write FCustomFilter;

    /// Description:
    ///   TatLogicalOper = (lgAnd,lgOr);
    ///   Use ConditionsLogicalOper property to define how conditions will be compared regarding the logical operator
    ///   AND/OR, as described in TatLogicalOper type.
    ///   For instance, if you have two conditions defined in Conditions property that result in expressions “A=B” and “C>2”,
    ///   ConditionsLogicalOper property defines if these conditions will result in “A=B AND C>2” or “A=B OR C>2” inside
    ///   WHERE clause of SQL statement.
    ///   ConditionsLogicalOper only affects first level of Conditions property. If there are conditions with subconditions, than
    ///   the logical operator of subconditions will be defined in SubConditionsLogicalOper property of  condition object.
    property ConditionsLogicalOper: TatLogicalOper read GetCondLogicalOper write SetCondLogicalOper default lgAnd;

    {$IFNDEF Inheritance}
    /// Description:
    ///   Use Params property to set/get values of params defined in metasql. A param is defined when you create a condition
    ///   which ConditionType property is set to ctParamCompare. In this case, metasql will consider that a param is created,
    ///   which name is defined in Value property of condition.
    ///   If you have two or more conditions of type ctParamCompare which the same name in Value property, only one param
    ///   will be created. And if you set that param value, all conditions will use the same value.
    property Params: TatSQLParams read FParams write SetParams;
    {$ENDIF}

    property SyntaxConf: TSQLSyntaxConf read FSyntaxConf write SetSyntaxConf stored IsSyntaxConfStored;
    property Distinct: boolean read FDistinct write FDistinct default false;
    property OnGetFieldExpression: TGetFieldExpressionEvent read FOnGetFieldExpression write FOnGetFieldExpression;
    property OnGetConditionExpression: TGetConditionExpressionEvent read FOnGetConditionExpression write FOnGetConditionExpression;
    { remind: complete the assign method on new properties }
  end;

function IsStringType(ADataType: TFieldType): boolean;
function IsDateType(ADataType: TFieldType): boolean;
function IsIntegerType(ADataType: TFieldType): boolean;
procedure SQLStringToMetaSQL(const ASQLString: string; AMetaSQL: TatMetaSQL);

{$IFDEF DEBUG_MODE}
type
  TSQLStringToMetaSQLDebugEvent = procedure(AParser : TatBaseParser) of object;
var
  FOnSQLStringToMetaSQLDebug : TSQLStringToMetaSQLDebugEvent;
{$ENDIF}
var
   MetaSQLForceBrackets{Parenthesis} : Boolean = FALSE;

implementation

uses
  atSQLParser, Dialogs, qsRes
  {$IFDEF Inheritance}, uInheritedPropertiesManager{$ENDIF};

const
   LogicalArray: array[TatLogicalOper] of string = ('AND','OR');
   NullDate = 0;
   TrueExpr = '0=0';
   FalseExpr= '0=1';

function IsStringType(ADataType: TFieldType): boolean;
begin
   result:=(ADataType in [ftString,ftMemo,ftFmtMemo,ftWideString]);
end;

function IsDateType(ADataType: TFieldType): boolean;
begin
   result:=(ADataType in [ftDate,ftTime,ftDateTime]);
end;

function IsIntegerType(ADataType: TFieldType): boolean;
begin
   result:=(ADataType in [ftInteger,ftsmallInt,ftWord,ftAutoInc,ftLargeInt]);
end;

procedure IncludeCommaInLast(AStr: TStrings);
begin
   if AStr.Count>0 then
      AStr[AStr.Count-1]:=AStr[AStr.Count-1]+',';
end;

const
{ Just to remember:
   TatSQLGroupFunction = (agfNone, agfCount, agfSum, agfMax, agfMin);}
   SQLAggFunctions : array[TatSQLGroupFunction] of string =
      ( '%s'         , {agfNone}
        'COUNT(%s)'  , {agfCount}
        'SUM(%s)'    , {agfSum}
        'MAX(%s)'    , {agfMax}
        'MIN(%s)'    , {agfMin}
        'AVG(%s)'      {agfAvg}
      );

{TatSQLField}

constructor TatSQLField.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FGroupFunction:=agfNone;
   FVisible:=true;
   FExpressionType:=etStandard;
   FFieldExpression:='';
   FOptions:=[foCanOrderBy, foCanUseInCondition];
end;

procedure TatSQLField.Assign(Source: TPersistent);
begin
   inherited Assign(Source);
   if Source is TatSQLField then
   begin
      FieldName := TatSQLField(Source).FieldName;
      TableAlias := TatSQLField(Source).TableAlias;
      GroupFunction := TatSQLField(Source).GroupFunction;
      DataType := TatSQLField(Source).DataType;
      DisplayLabel := TatSQLField(Source).DisplayLabel;
      Visible := TatSQLField(Source).Visible;
      ExpressionType := TatSQLField(Source).ExpressionType;
      FieldExpression := TatSQLField(Source).FieldExpression;
      Options := TatSQLField(Source).Options;
   end;
end;

function TatSQLField.GetFieldExpression: string;
begin
   result:='';
   if IsValid then
   begin
      Case ExpressionType of
         etStandard :
            begin
               if TableAlias > '' then
                  result := MetaSQL.BuildAliasID(TableAlias)+'.';
               result:=result + MetaSQL.BuildID(FieldName);
               result:=Format(SQLAggFunctions[GroupFunction],[result]);
            end;
         etCustomExpr :
            result:=FFieldExpression;
      end;
   end;
   if Assigned(MetaSQL) and Assigned(MetaSQL.FOnGetFieldExpression) then
     MetaSQL.FOnGetFieldExpression(MetaSQL, Self, result);
end;

function TatSQLField.IsValid: boolean;
begin
   Case ExpressionType of
      etStandard :
         result:={ validate non defined table for * field only }
                 (Fieldname = '*') or
                 { valid when aliased table defined }
                 (Assigned(MetaSQL) and
                 (
                 (TableAlias = '') or
                 (Assigned(MetaSQL.SQLTables.FindByAlias(TableAlias)) and
                 MetaSQL.SQLTables.FindByAlias(TableAlias).Active))
                 );
      etCustomExpr :
         result:=(Trim(FFieldExpression)<>'');
   else
      result:=false;
   end;
end;


function TatSQLField.IsFieldExpressionStored: Boolean;
begin
   result:=(FExpressionType=etCustomExpr);
end;

procedure TatSQLField.SetFieldExpression(const Value: string);
begin
   if ExpressionType=etCustomExpr then
      FFieldExpression:=Value;
end;

procedure TatSQLField.SetExpressionType(const Value: TatSQLFieldExprType);
var
  OldEvent: TGetFieldExpressionEvent;
begin
   {Update internal FFieldExpression field. Avoid calling the get expression
    event, since this is an internal update}
   OldEvent := nil;
   if Assigned(MetaSQL) then
   begin
     OldEvent := MetaSQL.OnGetFieldExpression;
     MetaSQL.OnGetFieldExpression := nil;
   end;
   FFieldExpression := GetFieldExpression;
   if Assigned(MetaSQL) then
     MetaSQL.OnGetFieldExpression := OldEvent;
   FExpressionType := Value;
end;

function TatSQLField.GetDisplayLabel: string;
begin
  { if empty returns the fieldalias }
  if FDisplayLabel>'' then
    result:=FDisplayLabel
  else
    result:=FieldAlias;
end;

procedure TatSQLField.SetDisplayLabel(const Value: string);
begin
  { if equal FieldAlias then clear field (for storing optimization) }
  if Value=FieldAlias then
    FDisplayLabel := ''
  else
    FDisplayLabel := Value;
end;

function TatSQLField.IsDisplayLabelStored: Boolean;
begin
  { no storing when Displaylabel is equal FieldAlias }
  result := FDisplayLabel>'';
end;

function TatSQLField.GetTableAlias: string;
begin
  if (FTableAlias='') and Assigned(Collection) and (TatMetaSql(TatSQLFields(Collection).GetOwner).SqlTables.Count=1) then
    Result := TatMetaSql(TatSQLFields(Collection).GetOwner).SqlTables[0].TableAlias
  else
    Result := FTableAlias;
end;

function TatSQLField.Table: TatSqlTable;
begin
  { retorna o campo correspondente ao field alias }
  if Assigned(MetaSql) then
    result := MetaSQL.FindTableByAlias(TableAlias)
  else
    result := nil;
end;

function TatSQLField.GetDisplayName: string;
begin
   if Trim(FieldAlias)='' then
      result:=Fieldname{inherited GetDisplayName}
   else
      result:=FieldAlias;
end;

procedure TatSQLField.ChangeFieldAlias(ANewFieldAlias: String);
var c : integer;
begin
   if Assigned(Collection) then 
   for c := 0 to TatMetaSQL(TatSqlFields(Collection).GetOwner).Conditions.Count - 1 do    // Iterate
      if SameText(TatMetaSQL(TatSqlFields(Collection).GetOwner).Conditions[c].FieldAlias,FieldAlias) then
        TatMetaSQL(TatSqlFields(Collection).GetOwner).Conditions[c].FieldAlias := ANewFieldAlias;
   FieldAlias := ANewFieldAlias;
end;

procedure TatSQLField.ChangeExclusiveFieldAlias( ANewAlias: string );
var
  c: integer;
  AConflictingField : TatSQLField;
  s : String;
begin
  if SameText(ANewAlias,FieldAlias) or not Assigned(Collection) then
     exit;

  AConflictingField := TatSqlFields(Collection).FindByAlias(ANewAlias);
  { conflicting fields receive table qualified field aliases
    instead of aditional numeric sufixes }
  if TatSqlFields(Collection).FQualifiedFieldAliases and (Tablealias > '') then
  begin
    if (AConflictingField <> nil) and (AConflictingField <> Self) then
    begin
      { qualify field alias }
      ANewAlias := TableAlias+TatSqlFields(Collection).FieldAliasSeparator+ANewAlias;
      { change (qualify) conflicting field alias }
      with AConflictingField do
      begin
        CascadeChangeFieldAlias(TableAlias+TatSqlFields(Collection).FieldAliasSeparator+Fieldname);
      end;
    end;
  end;

  { make sure its exclusive }
  c:=0;
  s := ANewAlias;
  AConflictingField := TatSqlFields(Collection).FindByAlias(s);
  while (AConflictingField <> nil) and (AConflictingField <> Self) do
  begin
    Inc(c);
    s := ANewAlias + IntToStr(c);
    { again, loop }
    AConflictingField := TatSqlFields(Collection).FindByAlias(s);
  end;
  FieldAlias := s;
end;

procedure TatSQLField.CascadeChangeFieldAlias(ANewAlias: string);
var
  c: integer;
  AMetaSQL : TatMetaSQL;
  AOldAlias : String;

  procedure BranchConditions( ACond: TatSqlConditions );
  var c : integer;
  begin
    { update corresponding fields }
    with ACond do
      for c := 0 to Count-1 do
        case Items[c].ConditionType of
          ctSubconditions:
            BranchConditions( Items[c].SubConditions );

          ctFieldCompare :
          begin
              if SameText(Items[c].FieldAlias,AOldAlias) then
                Items[c].FieldAlias := ANewAlias;
              if SameText(Items[c].Value,AOldAlias) then
                Items[c].Value := ANewAlias;
          end;
          ctValueCompare, ctParamCompare:
              if SameText(Items[c].FieldAlias,AOldAlias) then
                Items[c].FieldAlias := ANewAlias;

          ctCustomExpr :
            { *** a implementar: atualização para condições com expressão meta-SQL *** }
        end;
  end;

  procedure BranchFields( AFields: TatSqlBaseFields );
  var c : integer;
  begin
    { update corresponding fields }
    with AFields do
      for c := 0 to Count-1 do
        if SameText(Items[c].FieldAlias,AOldAlias) then
          Items[c].FieldAlias := ANewAlias;
  end;

begin
  AOldAlias := FieldAlias;

  { invoke creation of exclusive field alias instead of changing it directly }
  ChangeExclusiveFieldAlias(ANewAlias);
  ANewAlias := FieldAlias;

  AMetaSQL := GetMetaSQL;

  { propaga a alteração do FieldAlias para as dependências do field }

  { atualiza condições gerais }
  if Assigned(AMetaSQL) then
  begin
    BranchConditions( AMetaSQL.Conditions );

    { atualiza condições de junção entre tabelas }
    with AMetaSQL.TableJoins do
      for c := 0 to Count-1 do
        BranchConditions( Items[c].JoinConditions );

    { atualiza campos de agrupamento }
    BranchFields( AMetaSQL.GroupFields );

    { atualiza campos de ordenação }
    BranchFields( AMetaSQL.OrderFields );
  end;
end;

{TatSQLFields}

function TatSQLFields.GetItem(Index: integer): TatSQLField;
begin
   result:=TatSQLField(inherited Items[Index]);
end;

procedure TatSQLFields.SetItem(Index: integer; Value: TatSQLField);
begin
   Items[Index].Assign(Value);
end;

function TatSQLFields.Add: TatSQLField;
begin
   result:=TatSQLField(inherited Add);
end;

function TatSQLFields.FindByName(const AName: string): TatSQLField;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if CompareText(Items[c].FieldName,AName)=0 then result:=Items[c];
end;

function TatSQLFields.FindField(const AName, ATableAlias: string): TatSQLField;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if (CompareText(Items[c].FieldName,AName)=0) and
         (CompareText(Items[c].TableAlias,ATableAlias)=0) then
         begin
            result:=Items[c];
            break;
         end;
end;

function TatSQLFields.FindField(const AName, ATableAlias: string;
  AGroupFunction : TatSQLGroupFunction): TatSQLField;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if (CompareText(Items[c].FieldName,AName)=0) and
         (CompareText(Items[c].TableAlias,ATableAlias)=0) and
         (Items[c].GroupFunction = AGroupFunction) then
         begin
            result:=Items[c];
            break;
         end;
end;

function TatSQLFields.FindByAlias(const AAlias: string): TatSQLField;
begin
   result:=TatSQLField(inherited FindByAlias(AAlias));
end;

procedure TatSQLFields.AddFromFields(AFields: TFields);
Var c: integer;
begin
   for c:=0 to AFields.Count-1 do
   begin
      With Add do
      begin
         DataType := AFields[c].DataType;
         FieldName := AFields[c].FieldName;
         FieldAlias := AFields[c].FieldName;
         TableAlias := '';
         GroupFunction := agfNone;
         DisplayLabel := AFields[c].DisplayLabel;
      end;
   end;
end;

procedure TatSQLFields.GetDisplayLabels(AStrings: TStrings);
var c: integer;
begin
  AStrings.Clear;
  for c:=0 to Count-1 do
    AStrings.Add(Items[c].DisplayLabel);
end;

function TatSQLFields.FindByLabel(
  const ADisplayLabel: string): TatSQLField;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if CompareText(Items[c].DisplayLabel,ADisplayLabel)=0 then result:=Items[c];
end;

procedure TatSQLFields.SetFieldAliasSeparator(const Value: String);
begin
  FFieldAliasSeparator := Value;
end;

constructor TatSQLFields.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  inherited;
  FFieldAliasSeparator := '_'; {default}
end;

{TatSQLTable}

constructor TatSQLTable.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FActive:=true;
end;

destructor TatSQLTable.Destroy;
begin
   { spread object children exclusion }
   DeleteEnvolvedJoins;
   inherited;
end;

procedure TatSQLTable.DeleteEnvolvedJoins;
var
  i : Integer;
begin
   i := 0;
   if assigned(MetaSQL) then
   while i <= MetaSQL.TableJoins.Count - 1 do    // Iterate
     if (MetaSQL.TableJoins[i].FForeignTableAlias = '')
      or SameText(MetaSQL.TableJoins[i].FForeignTableAlias,TableAlias) then
        MetaSQL.TableJoins[i].free
      else
        inc(i);
end;

procedure TatSQLTable.ChangeExclusiveTableAlias( ATableAlias: string );
var
  c: integer;
  s : String;
  ConflictingTable : TatSQLTable;
begin
  { se o nome da tabela inclui extenção então remove a extensão }
  c := Pos('.',ATableAlias);
  if c>0 then
    if sametext(copy(ATableAlias,c+1,2),'db') or
       sametext(copy(ATableAlias,c+1,3),'dbf') then
      ATableAlias := Copy(ATableAlias,1,c-1) {remove extension}
    else
      while Pos('.',ATableAlias) > 0 do
        Delete(ATableAlias,1,Pos('.',ATableAlias)); {remove all prefixes}

  { define um apelido de tabela automaticamente }
  c:=0;
  s := ATableAlias;
  ConflictingTable := nil;
  if Assigned(Collection) then
    ConflictingTable := TatSqlTables(Collection).FindByAlias(s);
  while (ConflictingTable <> nil) and (ConflictingTable <> Self) do
  begin
    Inc(c);
    s := ATableAlias + IntToStr(c);
    if Assigned(Collection) then
      ConflictingTable := TatSqlTables(Collection).FindByAlias(s);{again}
  end;
  TableAlias := s;
end;

procedure TatSQLTable.Assign(Source: TPersistent);
begin
   if Source is TatSQLTable then
   begin
      FTableName  := TatSQLTable(Source).FTableName;
      FTableAlias := TatSQLTable(Source).FTableAlias;
      FActive     := TatSQLTable(Source).FActive;
   end else
      inherited Assign(Source);
end;

function TatSQLTable.GetTableAlias: string;
begin
   if Trim(FTableAlias)='' then
      result:=FTableName
   else
      result:=FTableAlias;
end;

function TatSQLTable.GetDisplayName: string;
begin
   if Trim(TableName)='' then
      result:=inherited GetDisplayName
   else
      result:=TableName;
end;

function TatSQLTable.GetMetaSql: TatMetaSql;
begin
   if Assigned(Collection) and (TatSqlTables(Collection).GetOwner<>nil) and (TatSqlTables(Collection).GetOwner is TatMetaSql) then
      result := TatMetaSql(TatSqlTables(Collection).GetOwner)
   else
      result := nil;
end;

procedure TatSQLTable.CascadeChangeTableAlias(ANewAlias: string);
var
  c: integer;
  AOldAlias : String;
  AMetaSql : TatMetaSQL;
begin
  AOldAlias := FTableAlias;

  ChangeExclusiveTableAlias(ANewAlias);
  ANewAlias := FTableAlias;

  AMetaSql := GetMetaSql;
  { propaga a alteração do TableAlias para as dependências da tabela }

  { atualiza as junções correpondentes }
  //if AOldAlias > '' then { ForeignTableAlias will be filled after field alias is selected }
  if Assigned(AMetaSql) then
  with AMetaSql.TableJoins do
    for c := 0 to Count-1 do
      if SameText(Items[c].ForeignTableAlias,AOldAlias) then
        Items[c].ForeignTableAlias := ANewAlias;

  { atualiza as junções correpondentes }
  if AOldAlias > '' then
  if Assigned(AMetaSql) then
  with AMetaSql.TableJoins do
    for c := 0 to Count-1 do
      if SameText(Items[c].PrimaryTableAlias,AOldAlias) then
        Items[c].PrimaryTableAlias := ANewAlias;

  { atualiza os campos correspodentes }
  if Assigned(AMetaSql) then
  with AMetaSql.SqlFields do
    for c := 0 to Count-1 do
      if Items[c].ExpressionType = etStandard then
        if SameText(Items[c].TableAlias,AOldAlias) then
          Items[c].TableAlias := ANewAlias
        else
      else
        { *** a implementar: atualização para campos com expressão meta-SQL *** }
        ;
end;


{TatSQLTables}

function TatSQLTables.MetaSql: TatMetaSql;
begin
   if (GetOwner<>nil) and (GetOwner is TatMetaSql) then
      result := TatMetaSql(GetOwner)
   else
      result := nil;
end;

function TatSQLTables.GetItem(Index: integer): TatSQLTable;
begin
   result:=TatSQLTable(inherited Items[Index]);
end;

procedure TatSQLTables.SetItem(Index: integer; Value: TatSQLTable);
begin
   Items[Index].Assign(Value);
end;

function TatSQLTables.Add: TatSQLTable;
begin
   result:=TatSQLTable(inherited Add);
end;

function TatSQLTables.FindByAlias(const AAlias: string): TatSQLTable;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if CompareText(Items[c].TableAlias,AAlias)=0 then result:=Items[c];
end;

{TatSQLJoin}

constructor TatSQLJoin.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FLinkType:=altInnerJoin;
   FJoinConditions:=TatSQLConditions.Create(Self,TatSQLCondition);
   if Assigned(Collection) then
     FJoinConditions.FMetaSQL:=TatMetaSQL(TatSQLJoins(Collection).GetOwner);
end;

destructor TatSQLJoin.Destroy;
begin
   FJoinConditions.Free;
   inherited;
end;

procedure TatSQLJoin.Assign(Source: TPersistent);
begin
   if Source is TatSQLJoin then
   begin
      PrimaryTableAlias := TatSQLJoin(Source).FPrimaryTableAlias;
      ForeignTableAlias := TatSQLJoin(Source).FForeignTableAlias;
      LinkType := TatSQLJoin(Source).FLinkType;
      JoinConditionsLogicalOper := TatSQLJoin(Source).JoinConditionsLogicalOper;
      JoinConditions := TatSQLJoin(Source).FJoinConditions;
   end else
      inherited Assign(Source);
end;

function TatSQLJoin.GetDisplayName: string;
begin
   if (PrimaryTableAlias='') or (ForeignTableAlias='') then
      result:=inherited GetDisplayName
   else
      result:=Format('%s - %s',[PrimaryTableAlias,ForeignTableAlias]);
end;

function TatSQLJoin.GetJoinCondLogicalOper: TatLogicalOper;
begin
   result:=JoinConditions.LogicalOperator;
end;

procedure TatSQLJoin.SetJoinCondLogicalOper(const Value: TatLogicalOper);
begin
   JoinConditions.LogicalOperator:=Value;
end;

procedure TatSQLJoin.SetJoinConditions(const Value: TatSQLConditions);
begin
   FJoinConditions.Assign(Value);
end;

{TatSQLJoins}

function TatSQLJoins.GetItem(Index: integer): TatSQLJoin;
begin
   result:=TatSQLJoin(inherited Items[Index]);
end;

procedure TatSQLJoins.SetItem(Index: integer; Value: TatSQLJoin);
begin
   Items[Index].Assign(Value);
end;

function TatSQLJoins.Add: TatSQLJoin;
begin
   result:=TatSQLJoin(inherited Add);
end;

function TatSQLJoins.FindLink(const APrimaryAlias, AForeignAlias: string): TatSQLJoin;
var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if (AnsiCompareText(Items[c].FPrimaryTableAlias,APrimaryAlias)=0) and
         (AnsiCompareText(Items[c].FForeignTableAlias,AForeignAlias)=0) then
      begin
         result:=Items[c];
         break;
      end;
end;

{TatMetaSQL}

constructor TatMetaSQL.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FSyntaxConf := TSQLSyntaxConf.Create;
   FTables:=TatSQLTables.Create(Self,TatSQLTable);
   FFields:=TatSQLFields.Create(Self,TatSQLField);
   FLinks:=TatSQLJoins.Create(Self,TatSQLJoin);
   FOrderFields:=TatSQLOrderFields.Create(Self,TatSQLOrderField);
   FGroupFields:=TatSQLGroupFields.Create(Self,TatSQLGroupField);
   FConditions:=TatSQLConditions.Create(Self,TatSQLCondition);
   FConditions.FMetaSQL:=Self;
   FParams:=TatSQLParams.Create(Self);
   FDistinct:=false;
end;

destructor TatMetaSQL.Destroy;
begin
   FSyntaxConf.Free;
   FTables.Free;
   FFields.Free;
   FLinks.Free;
   FOrderFields.Free;
   FGroupFields .Free;
   FConditions.Free;
   FParams.Free;
   inherited;
end;

procedure TatMetaSQL.SetTables(Value: TatSQLTables);
begin
   FTables.Assign(Value);
end;

procedure TatMetaSQL.SetFields(Value: TatSQLFields);
begin
   FFields.Assign(Value);
end;

procedure TatMetaSQL.SetLinks(Value: TatSQLJoins);
begin
   FLinks.Assign(Value);
end;

procedure TatMetaSQL.SetGroupFields(Value: TatSQLGroupFields);
begin
   FGroupFields.Assign(Value);
end;

procedure TatMetaSQL.SetOrderFields(Value: TatSQLOrderFields);
begin
   FOrderFields.Assign(Value);
end;

function TatMetaSQL.HasAggregatedFields: boolean;
Var c: integer;
begin
   result:=false;
   for c:=0 to FFields.Count-1 do
      if FFields[c].GroupFunction<>agfNone then
      begin
         result:=true;
         break;
      end;
end;

function TatMetaSQL.AddDelimiter(const ID : String): string;
begin
   result := ID;
   if ID <> '*' then { don't use Delimiters in this case }
      {$IFNDEF AlwaysUseDelimiters}
      if pos(#32,ID) > 0 then
      {$ENDIF}
         result:=Format('%s%s%s',
            [SyntaxConf.IDOpenDelim, ID, SyntaxConf.IDCloseDelim]);
end;

{ mount valid Identifier }
function TatMetaSQL.BuildID(const ID: string): string;
var
  Qualifier : String;
  Identifier : String;
begin
   if IsValidIdent(ID) then
      result:=ID
   else
         { take special care on qualified table names, adding brakets when needed }
         if pos('.',ID) > 0 then
         begin
            Qualifier := copy(ID,1,pos('.',ID)-1);
            Identifier := copy(ID,pos('.',ID)+1,maxint);
            Qualifier := AddDelimiter(Qualifier);
            Identifier := AddDelimiter(Identifier);
            result:=Format('%s.%s',[Qualifier,Identifier]);
         end
         else
            result:=AddDelimiter(ID);
end;

{ mount valid Alias Identifier }
function TatMetaSQL.BuildAliasID(const ID: string): string;
var
  Identifier : String;
begin
   if IsValidIdent(ID) then
      result:=ID
   else
      { field identifier: * -> dont use delimiters }
      if ID = '*' then
         result:=ID
      else
      begin
         { take special care on qualified table names, adding brakets when needed }
         Identifier := ID;
         if pos('.',Identifier) > 0 then
         {$IFDEF TMSDOTNET}
            Borland.Delphi.System.Delete(Identifier,1,pos('.',Identifier)); { remove dot }
         {$ELSE}
            system.Delete(Identifier,1,pos('.',Identifier)); { remove dot }
         {$ENDIF}
         result:=AddDelimiter(Identifier);
      end;
end;

function TatMetaSQL.NextMetaSqlCondition(var ACondition: TatSqlCondition): boolean;
var c: integer;
   found : boolean;

  function branch( cond: TatSqlConditions ): boolean;
  var c: integer;
  begin
    result := false;
    if Assigned(cond) then
      for c:=0 to cond.Count-1 do
        with cond[c] do
          if ConditionType=ctSubconditions then
            if branch( SubConditions ) then
            begin
              result := True;
              Exit;
            end
            else
          else
          begin
            if found then
            begin
              ACondition := cond[c];
              result := True;
              Exit;
            end
            else
              found := (cond[c]=ACondition);
          end;
  end;

begin
  { explore recursively all meta-sql conditions
    to find the condition that succeds given condition }

  if not Assigned(ACondition) then
    found := True
  else
    found := False;

  { scan conditions associated to table joins }
  for c:=0 to TableJoins.Count-1 do
    with TableJoins[c] do
    begin
      result := branch( JoinConditions );
      if result then Exit;
    end;

  { scan conditions of where clause }
  result := branch( Conditions );
end;

function TatMetaSQL.FindConditionByParamName( AParamName: string ): TatSqlCondition;
var p: integer;
begin
  { varre todas as condições da meta-sql procurando pelo ocorrência do parâmetro,
    retornando a primeira Condition encontrada }
  result := nil;
  while NextMetaSqlCondition( result) do
  begin
    with result do
    begin
      case ConditionType of
        ctParamCompare:
          if SameText(AParamName,Value) then
            Exit;
        ctValueCompare: // unused (just for future feature)
          if (Copy(Value,1,1)=':') and SameText(AParamName,Copy(Value,2,MaxInt)) then
            Exit;
        ctCustomExpr:
          begin
            p := Pos(':'+AParamName,Expression);
            if (p>0) and (Pos(Copy(Expression,p+Length(AParamName),1),'_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789')=0) then
              Exit;
          end;
      end;
    end;
  end;
  result := nil;
end;

function TatMetaSQL.FindFieldByParamName( AParamName: string ): TatSqlField;
var cond : TatSqlCondition;
begin
  { varre todas as condições da meta-sql procurando pelo ocorrência do parâmetro,
    retornando o campo associadp a primeira Condition encontrada }
  cond := FindConditionByParamName( AParamName );
  if Assigned(cond) then
    result := cond.Field
  else
    result := nil;
end;

{==============================================================================}
{ TatMetaSQL.GetSQL function
{==============================================================================}
type
   TatJoinInfo = class
   private
      FPrimaryJoin: TatJoinInfo;
      FForeignJoin: TatJoinInfo;
      FLinkType: TDBLinkType;
      FPrimarySearch: string;
      FForeignSearch: string;
      FOnClause: TStrings;
      FParentJoin: TatJoinInfo;
      procedure SetPrimaryJoin(Value: TatJoinInfo);
      procedure SetForeignJoin(Value: TatJoinInfo);
      function GetTopParent: TatJoinInfo;
   public
      constructor Create;
      destructor Destroy; override;
      function FindJoinByTable(const ASearch: string): TatJoinInfo;
      function ContainsJoin(Value: TatJoinInfo): boolean;
      function FindBranchJoin(const ASearch1,ASearch2: string): TatJoinInfo;
      function TableInPrimary(const ATable: string): boolean;
      property TopParent: TatJoinInfo read GetTopParent;
      property ParentJoin: TatJoinInfo read FParentJoin;
      property PrimaryJoin: TatJoinInfo read FPrimaryJoin write SetPrimaryJoin;
      property PrimarySearch: string read FPrimarySearch write FPrimarySearch;
      property ForeignJoin: TatJoinInfo read FForeignJoin write SetForeignJoin;
      property ForeignSearch: string read FForeignSearch write FForeignSearch;
      property LinkType: TDBLinkType read FLinkType write FLinkType;
      property OnClause: TStrings read FOnClause;
   end;

constructor TatJoinInfo.Create;
begin
   inherited Create;
   FOnClause := TStringList.Create;
end;

destructor TatJoinInfo.Destroy;
begin
   FOnClause.Free;
   if Assigned(FPrimaryJoin) then FPrimaryJoin.Free;
   if Assigned(FForeignJoin) then FForeignJoin.Free;
   inherited;
end;

procedure TatJoinInfo.SetPrimaryJoin(Value: TatJoinInfo);
begin
   if not Assigned(FPrimaryJoin) and (Value<>FPrimaryJoin) then
   begin
      FPrimaryJoin:=Value;
      Value.FParentJoin:=Self;
   end;
end;

procedure TatJoinInfo.SetForeignJoin(Value: TatJoinInfo);
begin
   if not Assigned(FForeignJoin) and (Value<>FForeignJoin) then
   begin
      FForeignJoin:=Value;
      Value.FParentJoin:=Self;
   end;
end;

function TatJoinInfo.FindJoinByTable(const ASearch: string): TatJoinInfo;
begin
   result:=nil;
   if ((AnsiCompareText(ASearch,FPrimarySearch)=0) or
      (AnsiCompareText(ASearch,FForeignSearch)=0)) then
         result:=Self;
   if not Assigned(result) then
   begin
      if Assigned(FPrimaryJoin) then
         result:=FPrimaryJoin.FindJoinByTable(ASearch);
      if not Assigned(result) and Assigned(FForeignJoin) then
         result:=FForeignJoin.FindJoinByTable(ASearch);
   end;
end;

function TatJoinInfo.ContainsJoin(Value: TatJoinInfo): boolean;
begin
   result:=false;
   if Value=nil then Exit;
   result:=((Value=Self) or (Value=FPrimaryJoin) or (Value=FForeignJoin));
   if not result then
   begin
      if Assigned(FPrimaryJoin) then
         result:=FPrimaryJoin.ContainsJoin(Value);
      if not result and Assigned(FForeignJoin) then
         result:=FForeignJoin.ContainsJoin(Value);
   end;
end;

function TatJoinInfo.GetTopParent: TatJoinInfo;
begin
   if Assigned(ParentJoin) then
      result:=ParentJoin.TopParent
   else
      result:=Self;
end;

function TatJoinInfo.TableInPrimary(const ATable: string): boolean;
begin
   result:=(AnsiCompareText(ATable,FPrimarySearch)=0) or
           (Assigned(FPrimaryJoin) and Assigned(FPrimaryJoin.FindJoinByTable(ATable)));
end;

function TatJoinInfo.FindBranchJoin(const ASearch1,ASearch2: string): TatJoinInfo;

   function TableInForeign(const ATable: string): boolean;
   begin
      result:=(AnsiCompareText(ATable,FForeignSearch)=0) or
              (Assigned(FForeignJoin) and Assigned(FForeignJoin.FindJoinByTable(ATable)));
   end;

begin
   result:=nil;
   if (TableInPrimary(ASearch1) and TableInForeign(ASearch2)) or
      (TableInPrimary(ASearch2) and TableInForeign(ASearch1)) then
         result:=Self;
   if not Assigned(result) then
   begin
      if Assigned(FPrimaryJoin) then result:=FPrimaryJoin.FindBranchJoin(ASearch1,ASearch2);
      if not Assigned(result) then
         if Assigned(FForeignJoin) then result:=FForeignJoin.FindBranchJoin(ASearch1,ASearch2);
   end;
end;

{TatMetaSQL.GetSQLString}

function TatMetaSQL.GetSQLString: string;
Var
   ASQL: TStrings;
   ASelect: TStrings;
   AFrom: TStrings;
   AWhere: TStrings;
   AGroup: TStrings;
   AOrder: TStrings;

   procedure AddSelectedFields;
   Var FieldStr: string;
       c: integer;
   begin
      // Add Selected Fields
      ASelect.Clear;
      for c := 0 to SQLFields.Count - 1 do
         if SQLFields[c].IsValid and SQLFields[c].Active then
         begin
            if SQLFields[c].FieldAlias = '' then
               FieldStr:= SQLFields[c].FieldExpression
            else
               FieldStr:=Format('%s %s %s',
                               [SQLFields[c].FieldExpression,
                               SyntaxConf.AsFieldOperator,
                               BuildAliasID(SQLFields[c].FieldAlias)]);
            IncludeCommaInLast(ASelect);
            ASelect.Add(FieldStr);
            SQLFields[c].FIndexInSelect := ASelect.Count;
         end else
            SQLFields[c].FIndexInSelect := 0;
      if ASelect.Count=0 then
         ASelect.Add('*');
   end;

   procedure AddGroupFields;
   Var FieldStr: string;
       c: integer;
       ASQLField: TatSQLField;
   begin
      // Add Group Fields
      AGroup.Clear;
      for c := 0 to GroupFields.Count-1 do if GroupFields[c].Active then
      begin
         ASQLField:=SQLFields.FindByAlias(GroupFields[c].FieldAlias);
         if Assigned(ASQLField) and ASQLField.IsValid then
         begin
            if SyntaxConf.IndexInGroupBy then
              FieldStr := IntToStr(ASQLField.FIndexInSelect)
            else
              FieldStr:=ASQLField.FieldExpression;
            IncludeCommaInLast(AGroup);
            AGroup.Add(FieldStr);
         end;
      end;
   end;

   procedure AddOrderFields;
   Var FieldStr: string;
       c: integer;
       ASQLField: TatSQLField;
       IncludedFields: TStrings;
   begin
      // Add Order Fields
      AOrder.Clear;
      IncludedFields := TStringList.Create;
      try
        for c:=0 to OrderFields.Count-1 do if OrderFields[c].Active then
        begin
           ASQLField:=SQLFields.FindByAlias(OrderFields[c].FieldAlias);
           if Assigned(ASQLField) and ASQLField.IsValid then
           begin
            if SyntaxConf.IndexInOrderBy then
              FieldStr := IntToStr(ASQLField.FIndexInSelect)
            else
              FieldStr:=ASQLField.FieldExpression;

             {Include a new order field only i fthe field is not included yet}
             if IncludedFields.IndexOf(FieldStr) = -1 then
             begin
               IncludedFields.Add(FieldStr);
               if OrderFields[c].SortType=ortDescending then
                  FieldStr:=Format('%s DESC',[FieldStr]);
               IncludeCommaInLast(AOrder);
               AOrder.Add(FieldStr);
             end;
           end;
        end;
      finally
        IncludedFields.Free;
      end;
   end;

   procedure AddTablesAndLinks;
   Var Joins: TList;
       PrimaryMT: TatSQLTable;
       ForeignMT: TatSQLTable;
       Syntax: TatSQLJoinSyntax;

      procedure SortLinksForAccess(L, R: Integer);
      var
        I, J: Integer;
        P,TempLink: TatSQLJoin;
        TempIndex: integer;
        again : Boolean;
        procedure Swap(I,J : Integer);
        begin
           TempIndex:=TableJoins[I].Index;
           TempLink:=TableJoins[J];
           TableJoins[I].Index:=TempLink.Index;
           TempLink.Index:=TempIndex;
        end;
      begin
        {simpleSort: keep original order of left-joins. works. }
        repeat
           again := FALSE;
           for I := 0 to TableJoins.count-2 do
             if (TableJoins[I].LinkType in [altLeftJoin,altRightJoin])
              and (NOT (TableJoins[I+1].LinkType in [altLeftJoin,altRightJoin])) then
              begin
                swap(I,I+1);
                again := TRUE;
              end;
        until NOT again;
        exit;
        {old->QuickSort, faster, destroy original left join orders }
        repeat
          I := L;
          J := R;
          P := TableJoins[(L + R) shr 1];
          repeat
            while (not (TableJoins[I].LinkType in [altLeftJoin,altRightJoin])
                   and (P.LinkType in [altLeftJoin,altRightJoin])) do Inc(I);
            while ((TableJoins[J].LinkType in [altLeftJoin,altRightJoin]) and
                   not (P.LinkType in [altLeftJoin,altRightJoin])) do Dec(J);
            if I <= J then
            begin
              TempIndex:=TableJoins[I].Index;
              TempLink:=TableJoins[J];
              TableJoins[I].Index:=TempLink.Index;
              TempLink.Index:=TempIndex;
              Inc(I);
              Dec(J);
            end;
          until I > J;
          if L < J then SortLinksForAccess(L, J);
          L := I;
        until I >= R;
      end;

      procedure AmbiguousError;
      begin
         raise EMetaSQLException.Create(
            Format(_str(SAmbiguousError),[PrimaryMT.TableName,ForeignMT.TableName]));
      end;

      function FindJoin(const ATableSearch: string): TatJoinInfo;
      Var c: integer;
      begin
         result:=nil;
         for c:=0 to Joins.Count-1 do With TatJoinInfo(Joins[c]) do
         begin
            result:=FindJoinByTable(ATableSearch);
            if Assigned(result) then break;
         end;
      end;

      procedure AddJoinToSQL(AJoin: TatJoinInfo; const OpenPar: string);
      Var
        AuxStr: string;
        JoinOpenPar: string;
        JoinClosePar: string;
      begin
         Case Syntax of
            alsFrom :
               begin
                  if not SyntaxConf.ParentesisInJoins then
                  begin
                    JoinOpenPar := '';
                    JoinClosePar := '';
                  end else
                  begin
                    JoinOpenPar := '(';
                    JoinClosePar := ')';
                  end;

                  {Old SQLLinkJoin}
                  Case AJoin.LinkType of
                    ltLeftJoin: AuxStr := SyntaxConf.LeftJoinStr;
                    ltRightJoin: AuxStr := SyntaxConf.RightJoinStr;
                  else
                    //altInnerJoin:
                    AuxStr := SyntaxConf.InnerJoinStr;
                  end;

                  if Assigned(AJoin.PrimaryJoin) then
                     AddJoinToSQL(AJoin.PrimaryJoin,OpenPar + JoinOpenPar)
                  else
                     AuxStr:=Format('%s%s%s %s',[JoinOpenPar, OpenPar,AJoin.PrimarySearch,AuxStr]);
                  if Assigned(AJoin.ForeignJoin) then
                  begin
                     AFrom.Add(AuxStr);
                     AddJoinToSQL(AJoin.ForeignJoin,'');
                  end else
                  begin
                     AuxStr:=Format('%s %s',[AuxStr, AJoin.ForeignSearch]);
                     AFrom.Add(AuxStr);
                  end;

                  AJoin.OnClause[0]:='ON ' + JoinOpenPar + AJoin.OnClause[0];
                  AJoin.OnClause[AJoin.OnClause.Count-1] :=
                    AJoin.OnClause[AJoin.OnClause.Count-1] + JoinClosePar + JoinClosePar;
                  AFrom.AddStrings(AJoin.OnClause);
               end;
            alsWhere :
               begin
                  if Assigned(AJoin.PrimaryJoin) then
                     AddJoinToSQL(AJoin.PrimaryJoin,'')
                  else
                     AFrom.Add(AJoin.PrimarySearch+',');
                  if Assigned(AJoin.ForeignJoin) then
                     AddJoinToSQL(AJoin.ForeignJoin,'')
                  else
                     AFrom.Add(AJoin.ForeignSearch+',');
                  if AWhere.Count>0 then
                     AJoin.OnClause[0]:=' AND '+AJoin.OnClause[0];
                  AWhere.AddStrings(AJoin.OnClause);
               end;
         end;

      end;

   Var c: integer;
       PrimarySearch: string;
       ForeignSearch: string;
       PrimaryJoin: TatJoinInfo;
       ForeignJoin: TatJoinInfo;
       NewJoin: TatJoinInfo;
       ADBLinkType: TDBLinkType;
       Aux: string;
   begin
      // Check if there is at least one link that must be in From clause
      //  If yes, then syntax joins will be in From clause. If not, joins will be in Where clause
      Syntax:=alsWhere;
      if SQLTables.Count>1 then
         for c:=0 to TableJoins.Count-1 do
            if SyntaxConf.JoinSyntax = alsFrom then
            begin
               Syntax:=alsFrom;
               break;
            end;

      if (SyntaxConf.SortInnerJoins) and (TableJoins.Count>0) then
         SortLinksForAccess(0,TableJoins.Count-1);

      // Add links to SQL
      Joins:=TList.Create;
      try
         for c:=0 to TableJoins.Count-1 do With TableJoins[c] do
         begin
            //Find table names
            PrimaryMT:=SQLTables.FindByAlias(PrimaryTableAlias);
            ForeignMT:=SQLTables.FindByAlias(ForeignTableAlias);
            if not (Assigned(PrimaryMT) and Assigned(ForeignMT)) then Continue;
            if not (PrimaryMT.Active and ForeignMT.Active) then Continue;

            { Build strings that will be used to find tables that have already been
              included in joins. This strings have the format 'TableName AS TableAlias' or
              'TableName  TableAlias' }
            PrimarySearch:=Format('%s %s %s',
               [BuildID(PrimaryMT.TableName),
                SyntaxConf.AsTableOperator,
                BuildAliasID(PrimaryMT.TableAlias)]);
            ForeignSearch:=Format('%s %s %s',
               [BuildID(ForeignMT.TableName),
                SyntaxConf.AsTableOperator,
                BuildAliasID(ForeignMT.TableAlias)]);

            // Add join to join structure
            PrimaryJoin:=FindJoin(PrimarySearch);
            ForeignJoin:=FindJoin(ForeignSearch);
            if LinkType=altLeftJoin then
               ADBLinkType:=ltLeftJoin
            else if LinkType=altRightJoin then
               ADBLinkType:=ltRightJoin
            else
               ADBLinkType:=ltInnerJoin;
            if Assigned(PrimaryJoin) and Assigned(ForeignJoin) then // if both tables were already included
            begin
               if PrimaryJoin.TopParent.ContainsJoin(ForeignJoin) then // joins are linked by a parent join
               begin
                  NewJoin:=PrimaryJoin.TopParent.FindBranchJoin(PrimarySearch,ForeignSearch);
                  if NewJoin.OnClause.Count>0 then
                     NewJoin.OnClause.Add(Format(' AND %s',[JoinConditions.GetConditionStr(NOT JoinConditions.MayMergeTo(lgAnd))]))
                  else
                     NewJoin.OnClause.Add(JoinConditions.GetConditionStr);
                  if NewJoin.TableInPrimary(PrimarySearch) then
                  begin
                     if NewJoin.LinkType<>ADBLinkType then AmbiguousError;
                  end else
                  begin
                     if ((NewJoin.LinkType=ltInnerJoin) and (ADBLinkType<>ltInnerJoin)) or
                        ((NewJoin.LinkType=ltLeftJoin) and (ADBLinkType<>ltRightJoin)) or
                        ((NewJoin.LinkType=ltRightJoin) and (ADBLinkType<>ltLeftJoin)) then
                           AmbiguousError;
                  end;
               end else // joins are not linked yet
               begin
                  NewJoin:=TatJoinInfo.Create;
                  NewJoin.PrimaryJoin:=PrimaryJoin.TopParent;
                  NewJoin.ForeignJoin:=ForeignJoin.TopParent;
                  NewJoin.LinkType:=ADBLinkType;
                  NewJoin.OnClause.Add(JoinConditions.GetConditionStr);
                  Joins.Remove(NewJoin.ForeignJoin);
                  Joins[Joins.IndexOf(NewJoin.PrimaryJoin)]:=NewJoin;
               end;
            end else
            if Assigned(PrimaryJoin) then // if only primary table was included
            begin
               NewJoin:=TatJoinInfo.Create;
               NewJoin.PrimaryJoin:=PrimaryJoin.TopParent;
               NewJoin.ForeignSearch:=ForeignSearch;
               NewJoin.LinkType:=ADBLinkType;
               NewJoin.OnClause.Add(JoinConditions.GetConditionStr);
               Joins[Joins.IndexOf(NewJoin.PrimaryJoin)]:=NewJoin;
            end else
            if Assigned(ForeignJoin) then // if only foreign table was included
            begin
               NewJoin:=TatJoinInfo.Create;
               NewJoin.PrimarySearch:=PrimarySearch;
               NewJoin.ForeignJoin:=ForeignJoin.TopParent;
               NewJoin.LinkType:=ADBLinkType;
               NewJoin.OnClause.Add(JoinConditions.GetConditionStr);
               Joins[Joins.IndexOf(NewJoin.ForeignJoin)]:=NewJoin;
            end else // if no tables were included
            begin
               NewJoin:=TatJoinInfo.Create;
               NewJoin.PrimarySearch:=PrimarySearch;
               NewJoin.ForeignSearch:=ForeignSearch;
               NewJoin.LinkType:=ADBLinkType;
               NewJoin.OnClause.Add(JoinConditions.GetConditionStr);
               Joins.Add(NewJoin);
            end;

         end; {for c:=0 to TableJoins.Count-1}

         // Check for some errors that may occur when more than one error is selected
         if SQLTables.Count>1 then
         begin
            // if there are more than one join, it means that are tables not connected. Then raises an error.
            if (Syntax=alsFrom) and (Joins.Count>1) then
               raise EMetaSQLException.Create(_str(SNotEnoughTableLinks));

         end;


         // Build from string
         for c:=0 to Joins.Count-1 do
         begin
            AddJoinToSQL(TatJoinInfo(Joins[c]),'');
            Aux:=AFrom[AFrom.Count-1];
            if (Aux[Length(Aux)]<>',') then AFrom[AFrom.Count-1]:=Aux+',';
         end;
         for c:=0 to SQLTables.Count-1 do With SQLTables[c] do if Active then
         begin
            Aux:=Format('%s %s %s',
                  [BuildID(TableName),
                   SyntaxConf.AsTableOperator,
                   BuildAliasID(TableAlias)]);
            if not Assigned(FindJoin(Aux)) then AFrom.Add(Aux+',');
         end;
         if AFrom.Count > 0 then
         begin
            Aux := AFrom[AFrom.Count - 1];
            if Aux[Length(Aux)] = ',' then
               AFrom[AFrom.Count - 1] := Copy(Aux, 1, Length(Aux) - 1);
         end;
      finally
         while Joins.Count > 0 do
         begin
            TatJoinInfo(Joins[0]).Free;
            Joins.Delete(0);
         end;
         Joins.Free;
      end;
   end;

   procedure AddWhereClause;
   begin
      if AWhere.Count>0 then
        AWhere.Add(' AND '+Conditions.GetConditionStr(NOT Conditions.MayMergeTo(lgAnd)))
      else
        if Conditions.ActiveCount > 0 then
          AWhere.Add(Conditions.GetConditionStr);
      if CustomFilter<>'' then
      begin
         if AWhere.Count>0 then
            AWhere.Add(' AND ');
         AWhere.Add(Format('(%s)',[CustomFilter]));
      end;
   end;

const
  Tab = '   ';
var
  c: integer;
  HasTables: boolean;
  {$IFDEF TRIAL}
  msg: string;
  i: integer;
  {$ENDIF}
begin
  {$IFDEF TRIAL}
  if (Now > 40800) or (Now < 40430) then
  begin
    msg := 'Tfhfiesg hQjugefrdys yShtgufdeidof dvcevrfseidofnd wheassz aesxdpfitryeudu.g fPvldecaxssed rrteyguiishtjehrg,f dosrd s'+
      'tdor tcfognvtcisnwueed sewvratlhunagtbifnvgc sdzotwfnglhoiaodk jam nnhegwf d'+
      'vdefrrstigovnc sfdreormf xhttgtyph:j/u/iwnwhwg.btfmvscsdowfqtawsadreer.fcrotm';
    i := 2;
    while i < length(msg) do
    begin
      System.Delete(msg, i, 1);
      inc(i);
    end;
    raise Exception.Create(msg);
  end;
  {$ENDIF}

  SyntaxConf.LoadPredefinedSyntax(SQLSyntax);

  {If there are no tables actives, then return an empty sql string}
   HasTables := false;
   for c := 0 to SQLTables.Count - 1 do
     if SQLTables[c].Active then
     begin
       HasTables := true;
     end;
   if not HasTables then
   begin
     result := '';
     Exit;
   end;

   ASelect:=TStringList.Create;
   AFrom:=TStringList.Create;
   AWhere:=TStringList.Create;
   ASQL:=TStringList.Create;
   AGroup:=TStringList.Create;
   AOrder:=TStringList.Create;
   try
      AddSelectedFields;
      AddTablesAndLinks;
      AddGroupFields;
      AddOrderFields;
      AddWhereClause;

      for c:=0 to ASelect.Count-1 do ASelect[c]:=Tab+ASelect[c];
      for c:=0 to AFrom.Count-1 do AFrom[c]:=Tab+AFrom[c];
      for c:=0 to AWhere.Count-1 do AWhere[c]:=Tab+AWhere[c];
      for c:=0 to AGroup.Count-1 do AGroup[c]:=Tab+AGroup[c];
      for c:=0 to AOrder.Count-1 do AOrder[c]:=Tab+AOrder[c];
      if not Distinct then
         ASQL.Add('SELECT')
      else
         ASQL.Add('SELECT DISTINCT');
      ASQL.AddStrings(ASelect);
      ASQL.Add('FROM');
      ASQL.AddStrings(AFrom);
      if (AWhere.Count>0) then
      begin
         ASQL.Add('WHERE');
         //if AWhere.Count>0 then
         ASQL.AddStrings(AWhere);
     end;

      if AGroup.Count>0 then
      begin
         ASQL.Add('GROUP BY');
         ASQL.AddStrings(AGroup);
      end;

      if AOrder.Count>0 then
      begin
         ASQL.Add('ORDER BY');
         ASQL.AddStrings(AOrder);
      end;

      result:=ASQL.Text;
   finally
      AWhere.Free;
      ASelect.Free;
      AFrom.Free;
      ASQL.Free;
      AGroup.Free;
      AOrder.Free;
   end;
end;

{==============================================================================}
{ End of TatMetaSQL.GetSQL function
{==============================================================================}

procedure TatMetaSQL.Assign(Source: TPersistent);
begin
   if Source is TatMetaSQL then
   begin
      SyntaxConf:=TatMetaSQL(Source).SyntaxConf;
      SQLSyntax:=TatMetaSQL(Source).SQLSyntax;
      SyntaxConf.LoadPredefinedSyntax(SQLSyntax);
      SQLTables:=TatMetaSQL(Source).SQLTables;
      SQLFields:=TatMetaSQL(Source).SQLFields;
      TableJoins:=TatMetaSQL(Source).TableJoins;
      GroupFields:=TatMetaSQL(Source).GroupFields;
      OrderFields:=TatMetaSQL(Source).OrderFields;
      Conditions:=TatMetaSQL(Source).Conditions;
      ConditionsLogicalOper:=TatMetaSQL(Source).ConditionsLogicalOper;
      CustomFilter:=TatMetaSQL(Source).CustomFilter;
      Params:=TatMetaSQL(Source).Params;
      Distinct:=TatMetaSQL(Source).Distinct;
      OnGetFieldExpression:=TatMetaSQL(Source).OnGetFieldExpression;
      OnGetConditionExpression:=TatMetaSQL(Source).OnGetConditionExpression;
   end
   else
      inherited Assign(Source);
end;

procedure TatMetaSQL.SetConditions(const Value: TatSQLConditions);
begin
   FConditions.Assign(Value);
end;

function TatMetaSQL.GetCondLogicalOper: TatLogicalOper;
begin
   result:=FConditions.LogicalOperator;
end;

procedure TatMetaSQL.SetCondLogicalOper(const Value: TatLogicalOper);
begin
   FConditions.LogicalOperator:=Value;
end;

procedure TatMetaSQL.SetParams(const Value: TatSQLParams);
begin
   FParams.AssignValues(Value);
{   FParams.Assign(Value);   <--- What the hell, o assignvalues é o que deve
                                  ser usado. Se não funciona, tem que se
                                  corrigir o problema, não contorná-lo}
end;

procedure TatMetaSQL.CreateParams(AParams: TatSQLParams);
var AuxParams: TatSQLParams;

   procedure ProcessCondition(ACond: TatSQLCondition);

      procedure IncludeParam(const AParamName: string);
      begin
         if (Trim(AParamName)<>'') and
            not Assigned(AParams.FindParam(AParamName)) then
            TatSQLParam(AParams.Add).Name:=AParamName;
      end;

   var
      i: integer;
   begin
      Case ACond.ConditionType of
         ctSubConditions :
            {process subcondition recursively}
            for i:=0 to ACond.SubConditions.Count-1 do
               ProcessCondition(ACond.SubConditions[i]);

         ctParamCompare:
            {if param not exists, create it. Value property is used as name of param}
            IncludeParam(VarToStr(ACond.Value));

         ctCustomExpr:
            begin
               { The copy function below is necessary, because parsesql
                 works with string pointer. If we pass ACond.Expression directly,
                 it will change it, which is undesirable }
               AuxParams.ParseSQL(Copy(ACond.Expression,1,MaxInt),true);
               for i:=0 to AuxParams.Count-1 do
                  IncludeParam(AuxParams[i].Name);
            end;
      end;
   end;

var c, d: integer;
begin
   AuxParams:=TatSQLParams.Create;
   try
      AParams.Clear;
      for c:=0 to TableJoins.Count-1 do
         for d:=0 to TableJoins[c].JoinConditions.Count-1 do
            ProcessCondition(TableJoins[c].JoinConditions[d]);
      for c:=0 to Conditions.Count-1 do
         ProcessCondition(Conditions[c]);
   finally
      AuxParams.Free;
   end;
end;

procedure TatMetaSQL.UpdateParams;
var NewParams: TatSQLParams;
begin
   NewParams:=TatSQLParams.Create(Self);
   try
      CreateParams(NewParams);
      NewParams.AssignValues(FParams);
      FParams.Clear;
      FParams.Assign(NewParams);
   finally
      NewParams.Free;
   end;
end;

function TatMetaSQL.IsEmpty: Boolean;
begin
  result := (SQLTables.Count = 0);
end;

procedure TatMetaSQL.Clear;
begin
  SQLTables.Clear;
  SQLFields.Clear;
  TableJoins.Clear;
  Conditions.Clear;
  GroupFields.Clear;
  OrderFields.Clear;
  CustomFilter := '';
  Params.Clear;
  Distinct:=false;
end;

function TatMetaSQL.FindTableByAlias(ATableAlias: string): TatSqlTable;
var c: integer;
begin
  { tenta encontrar uam tabela através de seu apelido }
  if ATableAlias>'' then
  begin
    for c:=0 to SqlTables.Count-1 do
      with SqlTables[c] do
        if SameText(ATableAlias,TableAlias) then
        begin
          result := SqlTables[c];
          Exit;
        end;
    result := nil;
  end
  else
  begin
    if SqlTables.Count=1 then
      result := SqlTables[0]
    else
      result := nil;
  end;
end;

function TatMetaSQL.AutoUpdateGroupFields: boolean;
var
  c, already, grpflds: integer;
begin
  if not HasAggregatedFields then
  begin
    result := (GroupFields.Count > 0);
    GroupFields.Clear;
    Exit;
  end;

  {primeiro verifica se é necessário reajustar os campos de agrupamento
   retorna True se alterou o GroupFields}
  grpflds := 0;
  already := 0;
  for c := 0 to SQLFields.Count - 1 do
    if (SQLFields[c].GroupFunction = agfNone) and SQLFields[c].Active then
    begin
      inc(grpflds);
      if GroupFields.FindByAlias( SQLFields[c].FieldAlias ) <> nil then
        inc(already);
    end;
  result := (GroupFields.Count <> grpflds) or (already < grpflds);
  
  {somente altera os campos de agrupamento se detectou que isso é necessário}
  if result then
  begin
    GroupFields.Clear;
    for c := 0 to SQLFields.Count - 1 do
      if (SQLFields[c].GroupFunction = agfNone) and SQLFields[c].Active then
        GroupFields.Add.FieldAlias := SQLFields[c].FieldAlias;
  end;
end;

procedure TatMetaSQL.UpdateDisplayLabels(ADataset: TDataset);
var
  fld: TatSQLField;
  c: integer;
begin
  for c := 0 to ADataset.FieldCount - 1 do
  begin
     fld := SqlFields.FindByAlias(ADataset.Fields[c].FieldName);
     if Assigned(fld) then
        ADataset.Fields[c].DisplayLabel := fld.DisplayLabel;
  end;
end;

procedure TatMetaSQL.Loaded;
{$IFDEF TRIAL}
var
  msg: string;
  i: integer;
{$ENDIF}
begin
  {$IFDEF TRIAL}
  msg := 'Qtuyeurhyg xSctvubdnihoj htyrtigaflr evdesrwsqiaosnx.z sPduerrcfhtagshey '+
    'urjekgiiosltpeoriejdu hvnebrgsfivocnd fartt yhuthtypg:t/f/rwdwewd.stwmesdsrotfftgwyahruej.uchotmf.';
  i := 2;
  while i < length(msg) do
  begin
    System.Delete(msg, i, 1);
    inc(i);
  end;
  ShowMessage(msg);
  {$ENDIF}
end;

function TatMetaSQL.GetQualifiedFieldAliases: Boolean;
begin
  result := SQLFields.FQualifiedFieldAliases;
end;

procedure TatMetaSQL.SetQualifiedFieldAliases(const Value: Boolean);
begin
  SQLFields.FQualifiedFieldAliases := Value;
end;

function TatMetaSQL.GetFieldAliasSeparator: String;
begin
  result := SQLFields.FieldAliasSeparator;
end;

procedure TatMetaSQL.SetFieldAliasSeparator(const Value: String);
begin
  SQLFields.FieldAliasSeparator := Value;
end;

 {$IFDEF Inheritance}
procedure TatMetaSQL.DefineProperties(Filer: TFiler);
begin
  inherited;
  if Filer.Ancestor = nil then
  begin
    InheritedPropertiesManager.DefineProperty(Filer,'SQLTables', SQLTables);
    InheritedPropertiesManager.DefineProperty(Filer,'SQLFields', SQLFields);
    InheritedPropertiesManager.DefineProperty(Filer,'TableJoins', TableJoins);
    InheritedPropertiesManager.DefineProperty(Filer,'Conditions', Conditions);
    InheritedPropertiesManager.DefineProperty(Filer,'GroupFields', GroupFields);
    InheritedPropertiesManager.DefineProperty(Filer,'OrderFields', OrderFields);
    InheritedPropertiesManager.DefineProperty(Filer,'Params', Params);
  end
  else
  with TatMetaSql(Filer.Ancestor) do
  begin
    InheritedPropertiesManager.DefineProperty(Filer,'SQLTables', Self.SQLTables,SQLTables);
    InheritedPropertiesManager.DefineProperty(Filer,'SQLFields', Self.SQLFields,SQLFields);
    InheritedPropertiesManager.DefineProperty(Filer,'TableJoins', Self.TableJoins,TableJoins);
    InheritedPropertiesManager.DefineProperty(Filer,'Conditions', Self.Conditions,Conditions);
    InheritedPropertiesManager.DefineProperty(Filer,'GroupFields', Self.GroupFields,GroupFields);
    InheritedPropertiesManager.DefineProperty(Filer,'OrderFields', Self.OrderFields,OrderFields);
    InheritedPropertiesManager.DefineProperty(Filer,'Params', Self.Params,Params);
  end;
end;
{$ENDIF}

procedure TatMetaSQL.SetSyntaxConf(Value: TSQLSyntaxConf);
begin
  FSyntaxConf.Assign(Value);
end;

function TatMetaSQL.IsSyntaxConfStored: boolean;
begin
  result := (SQLSyntax = ssCustom);
end;

procedure TatMetaSQL.SetSQLSyntax(const Value: TatSQLSyntax);
begin
  FSQLSyntax := Value;
  SyntaxConf.LoadPredefinedSyntax(FSQLSyntax);
end;

{ TatSQLBaseFields }

function TatSQLBaseFields.ActiveCount: integer;
var
  c: integer;
begin
  result := 0;
  for c := 0 to Count - 1 do
    if Items[c].Active then
      inc(result);
end;

function TatSQLBaseFields.Add: TatSQLBaseField;
begin
   result:=TatSQLBaseField(inherited Add);
end;

procedure TatSQLBaseFields.Append(ASQLFields: TatSQLBaseFields);
var c : Integer;
begin
   for c := 0 to ASQLFields.count-1 do
      Add.assign(ASQLFields[c]);
end;

function TatSQLBaseFields.FindByAlias(const AAlias: string): TatSQLBaseField;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if (CompareText(AAlias,Items[c].FieldAlias)=0) then
      begin
         result:=Items[c];
         break;
      end;
   if result = nil then
     for c:=0 to Count-1 do
        if (Items[c].Field <> nil) and
           ((Items[c].Field.FieldAlias='') and
            (CompareText(AAlias,Items[c].Field.FieldName)=0) and
            (Items[c].Field.GroupFunction = agfNone)) then
        begin
          result:=Items[c];
          break;
        end;
end;

function TatSQLBaseFields.GetItem(Index: integer): TatSQLBaseField;
begin
   result:=TatSQLBaseField(inherited Items[Index]);
end;

procedure TatSQLBaseFields.SetItem(Index: integer; Value: TatSQLBaseField);
begin
   Items[Index].Assign(Value);
end;

{ TatSQLBaseField }

procedure TatSQLBaseField.Assign(Source: TPersistent);
begin
  if Source is TatSQLBaseField then
  begin
     FieldAlias:=TatSQLBaseField(Source).FieldAlias;
     Active:=TatSQLBaseField(Source).Active;
  end else
     inherited Assign(Source);
end;

constructor TatSQLBaseField.Create(Collection: TCollection);
begin
   inherited;
   FActive:=true;
end;

function TatSQLBaseField.Field: TatSqlField;
begin
  { retorna o campo correspondente ao field alias }
  if Self is TatSqlField then
    result := TatSqlField(Self)
  else
    if Assigned(MetaSql) then
      result := MetaSQL.SQLFields.FindByAlias(FieldAlias)
    else
      result := nil;
end;

function TatSQLBaseField.GetDisplayName: string;
begin
   if Trim(FieldAlias)='' then
      result:=inherited GetDisplayName
   else
      result:=FieldAlias;
end;

function TatSQLBaseField.GetMetaSQL: TatMetaSQL;
begin
   result:=nil;
   if Assigned(Collection) and (Collection is TatSQLBaseFields) then
      result:=TatMetaSQL(TatSQLBaseFields(Collection).GetOwner);
end;

{ TatSQLGroupFields }

function TatSQLGroupFields.Add: TatSQLGroupField;
begin
   result:=TatSQLGroupField(inherited Add);
end;

function TatSQLGroupFields.GetItem(Index: integer): TatSQLGroupField;
begin
   result:=TatSQLGroupField(inherited Items[Index]);
end;

procedure TatSQLGroupFields.SetItem(Index: integer;
  Value: TatSQLGroupField);
begin
   Items[Index].Assign(Value);
end;

{ TatSQLOrderFields }

function TatSQLOrderFields.Add: TatSQLOrderField;
begin
   result:=TatSQLOrderField(inherited Add);
end;

function TatSQLOrderFields.GetItem(Index: integer): TatSQLOrderField;
begin
   result:=TatSQLOrderField(inherited Items[Index]);
end;

procedure TatSQLOrderFields.SetItem(Index: integer;
  Value: TatSQLOrderField);
begin
   Items[Index].Assign(Value);
end;

{ TatSQLOrderField }

procedure TatSQLOrderField.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TatSQLOrderField then
  begin
     FSortType:=TatSQLOrderField(Source).FSortType;
  end;
end;

{TatSQLCondition}

function GetFormattedFieldValue(Value: Variant; FieldType: TFieldType;
   SyntaxConf: TSQLSyntaxConf; AUsePatterns: boolean = false): string;

    function ReplaceStr(const S, Srch, Replace: string): string;
    var
      I: Integer;
      Source: string;
    begin
      Source := S;
      Result := '';
      repeat
        I := Pos(Srch, Source);
        if I > 0 then begin
          Result := Result + Copy(Source, 1, I - 1) + Replace;
          Source := Copy(Source, I + Length(Srch), MaxInt);
        end
        else Result := Result + Source;
      until I <= 0;
    end;

begin
   result:='';
   if IsDateType(FieldType) then
   begin
      try
         if not VarIsNull(Value) and (VarToStr(Value) <> '') then
         {$IFDEF TMSDOTNET}
           result := FormatDateTime(SyntaxConf.DateFormat, StrToDate(VarToStr(Value)))
         {$ELSE}
           result := FormatDateTime(SyntaxConf.DateFormat, VarToDateTime(Value))
         {$ENDIF}
         else
           result := '';
      except
         result:='';
      end;
   end else
   if IsStringType(FieldType) then
   begin
      result:=VarToStr(Value);
      if AUsePatterns then
         result := ReplaceStr(result,'*', SyntaxConf.MaskChar);
      result := '''' + result + '''';
   end else
     result := VarToStr(Value);
end;

function BuildSQLCondition(FieldName, Operator: string; Value: Variant;
  FieldType: TFieldType; Insensitive: Boolean; SyntaxConf: TSQLSyntaxConf): string;
var
   FieldValue: string;
   Exact: boolean;
   DontUseValue: boolean;
begin
   { It's always exact, unless fieldtype is string and operator is one of these:
    like, contains, ends, starts or empty.
     so, if not exact, then operator will be "Like" }
   Exact := True;
   if IsStringType(FieldType) then
   begin
     Value := VarToStr(Value);
     Exact := not (
       (Operator = '') or
       (AnsiCompareText(Operator, 'LIKE') = 0) or
       (AnsiCompareText(Operator, 'CONTAINS') = 0) or
       (AnsiCompareText(Operator, 'ENDS') = 0) or
       (AnsiCompareText(Operator, 'STARTS') = 0) or
       (AnsiCompareText(Operator, 'ENDS WITH') = 0) or
       (AnsiCompareText(Operator, 'STARTS WITH') = 0)
       );
     {include automatic mask chars depending on special operators}
     if AnsiCompareText(Operator, 'CONTAINS') = 0 then
       Value := '*' + Value + '*'
     else
     if (AnsiCompareText(Operator, 'STARTS') = 0) or
       (AnsiCompareText(Operator, 'STARTS WITH') = 0) then
       Value := Value + '*'
     else
     if (AnsiCompareText(Operator, 'ENDS') = 0) or
       (AnsiCompareText(Operator, 'ENDS WITH') = 0) then
       Value := '*' + Value;
   end;

   if not Exact then Operator := 'LIKE';
   if Operator='' then Operator:='=';

   { Get formatted field value }
   FieldValue := GetFormattedFieldValue(Value,FieldType,SyntaxConf,not Exact);
   DontUseValue:=(Uppercase(Operator)='IS NULL');

   {Deal with fieldname and case sensitive }
   if IsStringType(FieldType) and Insensitive and (FieldValue<>'''''') then
     if SyntaxConf.CaseSensitive then
     begin
       FieldValue:=Format(SyntaxConf.UpperFunction, [FieldValue]);
       FieldName:=Format(SyntaxConf.UpperFunction, [FieldName]);
     end;

   {Finally format the condition}
   if DontUseValue then
      Result:=Format('%s %s',[FieldName,Operator])
   else
   if (FieldValue='') or (FieldValue='''''') then
      Result := TrueExpr
   else
      Result := Format('%s %s %s', [FieldName, Operator, FieldValue]);
end;

function TatSQLCondition.GetMetaSQL: TatMetaSQL;
begin
   result:=nil;
   if Assigned(Collection) then
      result:=TatSQLConditions(Collection).MetaSQL;
end;

function TatSQLCondition.GetDataType: TFieldType;
begin
   result:=ftInteger;
   if Assigned(MetaSQL) and
      Assigned(MetaSQL.SQLFields.FindByAlias(FieldAlias)) then
      result:=MetaSQL.SQLFields.FindByAlias(FieldAlias).DataType;
end;

function TatSQLCondition.GetDisplayLabel: string;
begin
   result:=FieldAlias;
   if Assigned(MetaSQL) and
      Assigned(MetaSQL.SQLFields.FindByAlias(FieldAlias)) then
      result:=MetaSQL.SQLFields.FindByAlias(FieldAlias).DisplayLabel;
end;

function TatSQLCondition.GetExpression: string;
Var
   ASyntaxConf: TSQLSyntaxConf;

   function BuildSQLParamCondition: string;
   Var AParam: TatSQLParam;
       AType: TFieldType;
   begin
      result:=TrueExpr;
      if Assigned(MetaSQL) then
      begin
         AParam:=TatSQLParam(MetaSQL.Params.FindParam(VarToStr(Value)));
         if Assigned(AParam) and AParam.Active then
         begin
            AType:=DataType;
            if AType=ftUnknown then
               AType:=AParam.DataType;
            result:=BuildSQLCondition(
               GetFieldExpr(FieldAlias),Operator,AParam.Value,
               AType,
               true,
               ASyntaxConf);
         end;
      end;
   end;

   function BuildSQLOracleCondition: string;

      function FindSQLField(const AFieldAlias: string): TatSQLField;
      begin
         result:=nil;
         if Assigned(MetaSQL) then
            result:=MetaSQL.SQLFields.FindByAlias(AFieldAlias);
      end;

   Var AField1, AField2: TatSQLField;
       AField1Str, AField2Str: string;
   begin
      AField1:=FindSQLField(FieldAlias);
      AField2:=FindSQLField(VarToStr(Value));
      if Assigned(AField1) and Assigned(AField2) then
      begin
         AField1Str:=AField1.FieldExpression;
         if (AField1.ExpressionType=etStandard) and
            (    (SQLJoin.LinkType=altLeftjoin) and (AnsiCompareText(SQLJoin.ForeignTableAlias,AField1.TableAlias)=0)
              or (SQLJoin.LinkType=altRightJoin) and (AnsiCompareText(SQLJoin.PrimaryTableAlias,AField1.TableAlias)=0)
            ) then
            AField1Str:=Format('%s(+)',[AField1Str]);
         AField2Str:=AField2.FieldExpression;
         if (AField2.ExpressionType=etStandard) and
            (    (SQLJoin.LinkType=altLeftjoin) and (AnsiCompareText(SQLJoin.ForeignTableAlias,AField2.TableAlias)=0)
              or (SQLJoin.LinkType=altRightJoin) and (AnsiCompareText(SQLJoin.PrimaryTableAlias,AField2.TableAlias)=0)
            ) then
            AField2Str:=Format('%s(+)',[AField2Str]);

         result:=Format('%s %s %s',[
            AField1Str,
            Operator,
            AField2Str]);
      end else
         result:=TrueExpr;

   end;

begin
   { Cannot make any change to FExpression when conditiontype is ctCustomExpr }
   if FConditionType=ctCustomExpr then
   begin
      result:=FExpression;
      exit;
   end;

   { Get SyntaxConf of SQL, just to use when needed}
   if Assigned(MetaSQL) and
      Assigned(MetaSQL.SQLFields.FindByAlias(FieldAlias)) then
      ASyntaxConf := MetaSQL.SyntaxConf
   else
   begin
     result := TrueExpr;
     exit;
   end;

   case FConditionType of
      ctValueCompare :
            result:=BuildSQLCondition(
               GetFieldExpr(FieldAlias),Operator,Value,
               DataType,
               true,
               ASyntaxConf);

      ctParamCompare :
            result:=BuildSQLParamCondition;

      ctFieldCompare :
            if ASyntaxConf.JoinSyntax = alsWhere then
              result:=BuildSQLOracleCondition
            else
               result:=Format('%s %s %s',[
                  GetFieldExpr(FieldAlias),
                  Operator,
                  GetFieldExpr(VarTostr(Value))]);

      ctTrueExpr:
         result:=TrueExpr;

      ctFalseExpr:
         result:=FalseExpr;
   else
      result:=TrueExpr;
   end;

   //Negate expression if necessary
   if FNegate then
      result:=Format('NOT (%s)',[result]);

   //Update internal FExpression field
   FExpression:=result;
end;

procedure TatSQLCondition.assign(Source: TPersistent);
begin
   if Source is TatSQLCondition then
   begin
      Name:=TatSQLCondition(Source).Name;
      FieldAlias:=TatSQLCondition(Source).FieldAlias;
      Operator:=TatSQLCondition(Source).Operator;
      Value:=TatSQLCondition(Source).Value;
      {ConditionType must be changed before Expression}
      ConditionType:=TatSQLCondition(Source).ConditionType;
      Expression:=TatSQLCondition(Source).Expression;
      SubConditionsLogicalOper:=TatSQLCondition(Source).SubConditionsLogicalOper;
      SubConditions:=TatSQLCondition(Source).SubConditions;
      Active:=TatSQLCondition(Source).Active;
      Text:=TatSQLCondition(Source).Text;
      Negate:=TatSQLCondition(Source).Negate;
   end else
      inherited Assign(Source);
end;

function TatSQLCondition.GetFieldExpr(const AFieldAlias: string): string;
begin
   result:=AFieldAlias;
   if Assigned(MetaSQL) and
      Assigned(MetaSQL.SQLFields.FindByAlias(AFieldAlias)) then
   begin
      result:=MetaSQL.SQLFields.FindByAlias(AFieldAlias).FieldExpression;
   end;
end;

constructor TatSQLCondition.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FConditionType:=ctValueCompare;
   FName:=Format('Condition%d',[Index]);
   FExpression:='';
   FSubConditions:=TatSQLConditions.Create(Self,TatSQLCondition);
   FActive:=true;
   FNegate:=false;
end;

destructor TatSQLCondition.Destroy;
begin
   if Assigned(FSubConditions) then
   FSubConditions.Free;
   inherited;
end;

procedure TatSQLCondition.SetSubConditions(const Value: TatSQLConditions);
begin
   FSubConditions.Assign(Value);
end;

function TatSQLCondition.GetLogicalOper: TatLogicalOper;
begin
   result:=lgAnd;
   if Assigned(Collection) and (Collection is TatSQLConditions) then
      result:=TatSQLConditions(Collection).LogicalOperator;
end;

function TatSQLCondition.GetDisplayName: string;
begin
   result:=Name;
end;

procedure TatSQLCondition.SetExpression(const Value: string);
var
   OldValue: string;
begin
   if ConditionType=ctCustomExpr then
   begin
      OldValue:=FExpression;
      FExpression:=Value;
      if (OldValue<>FExpression) then
         UpdateMetaSQLParams;
   end;
end;

procedure TatSQLCondition.SetConditionType(const AValue: TatConditionType);
var OldConditionType: TatConditionType;
begin
   //Update internal FExpression field (the assignment below is just
   //ilustrative, since GetExpression itself updates FExpression field
   //FExpression:=GetExpression;

   OldConditionType:=FConditionType;
   FConditionType:=AValue;
   if OldConditionType<>AValue then
   begin
      if (AValue in [ctParamCompare,ctCustomExpr]) or
         (OldConditionType in [ctParamCompare,ctCustomExpr])  then
         UpdateMetaSQLParams;
   end;
end;

function TatSQLCondition.IsExpressionStored: Boolean;
begin
   result:=(ConditionType=ctCustomExpr);
end;

function TatSQLCondition.GetSubCondLogicalOper: TatLogicalOper;
begin
   result:=SubConditions.LogicalOperator;
end;

procedure TatSQLCondition.SetSubCondLogicalOper(
  const AValue: TatLogicalOper);
begin
   SubConditions.LogicalOperator:=AValue;
end;

function TatSQLCondition.GetSQLJoin: TatSQLJoin;
begin
   result:=nil;
   if Assigned(Collection) and (Collection is TatSQLConditions) then
      result:=TatSQLConditions(Collection).SQLJoin;
end;

procedure TatSQLCondition.SetValue(const AValue: Variant);
var OldValue: Variant;
begin
   OldValue:=FValue;
   FValue := AValue;
   if (FConditionType=ctParamCompare) and (VarToStr(OldValue)<>VarToStr(Value)) then
      UpdateMetaSQLParams;
end;

procedure TatSQLCondition.UpdateMetaSQLParams;
begin
   if Assigned(MetaSQL) then
      MetaSQL.UpdateParams;
end;

function TatSQLCondition.SolvedExpression: string;

   function ReplaceParamValues(const AStr: string; AParams: TatSQLParams;
      ASyntaxConf: TSQLSyntaxConf): string;
   var
      I, J, P, LiteralChars: Integer;
      Param: TatSQLParam;
      Found: Boolean;
      ExprActive: boolean;
   begin
      ExprActive:=true;
      Result := AStr;
      for I := AParams.Count - 1 downto 0 do
      begin
         Param := AParams[I];
         //if Param.DataType = ftUnknown then Continue;
         repeat             
            P := Pos(Uppercase(':' + Param.Name), Uppercase(Result));
            Found := (P > 0) and ((Length(Result) = P + Length(Param.Name)) or
            {$IFDEF DELPHI2009_LVL}
              CharInSet(
                Result[P+Length(Param.Name)+1], [' ', ',', ';', ')', '.', #13, #10])
            {$ELSE}
               (Result[P+Length(Param.Name)+1] in [' ', ',', ';', ')', '.', #13, #10])
            {$ENDIF}
               );
            if Found then
            begin
               LiteralChars := 0;
               for J := 1 to P - 1 do
               {$IFDEF DELPHI2009_LVL}
                  if CharInSet(Result[J], ['''','"']) then Inc(LiteralChars);
               {$ELSE}
                  if (Result[J] in ['''','"']) then Inc(LiteralChars);
               {$ENDIF}
               Found := LiteralChars mod 2 = 0;
               if Found then
               begin
                  Result := Copy(Result, 1, P - 1) +
                     GetFormattedFieldValue(Param.Value,Param.DataType,ASyntaxConf) +
                     Copy(Result, P + Length(Param.Name) + 1, MaxInt);
                  ExprActive:=ExprActive and Param.Active;
               end;
            end;
         until not Found;
      end;
      if not ExprActive then
         result:=TrueExpr;
   end;


begin
   result:=Expression;
   if FConditionType=ctCustomExpr then
      if Assigned(MetaSQL) then
         result:=ReplaceParamValues(result,MetaSQL.Params,MetaSQL.SyntaxConf);
   if Assigned(MetaSQL) and Assigned(MetaSQL.FOnGetConditionExpression) then
     MetaSQL.FOnGetConditionExpression(MetaSQL, Self, result);
end;

function TatSQLCondition.Field: TatSqlField;
begin
  if Assigned(MetaSql) and
     (ConditionType in [ctParamCompare, ctValueCompare, ctFieldCompare]) then
    result := MetaSQL.SQLFields.FindByAlias(FieldAlias)
  else
    result := nil;
end;

function TatSQLCondition.GetActive: boolean;
begin
  case ConditionType of
   ctSubConditions :
     Result := FActive and (SubConditions.ActiveCount > 0);
  else
     Result := FActive and (SolvedExpression > '')
  end;
end;

{$IFDEF Inheritance}
procedure TatSQLCondition.DefineProperties(Filer: TFiler);
begin
  inherited;
  if Filer.Ancestor = nil then
  begin
    InheritedPropertiesManager.DefineProperty(Filer,'SubConditions', SubConditions);
  end
  else
  with TatSQLCondition(Filer.Ancestor) do
  begin
    InheritedPropertiesManager.DefineProperty(Filer,'SubConditions', Self.SubConditions,SubConditions);
  end;
end;
{$ENDIF}

{ TatSQLConditions }

function TatSQLConditions.GetCondition(Index: Integer): TatSQLCondition;
begin
   Result:=TatSQLCondition(inherited Items[Index]);
end;

procedure TatSQLConditions.SetCondition(Index: Integer; Value:TatSQLCondition);
begin
   Items[Index].Assign(Value);
end;

function TatSQLConditions.Add: TatSQLCondition;
begin
   result:=TatSQLCondition(inherited Add);
end;

function TatSQLConditions.MayMergeTo(ALogicOper : tatLogicalOper) : Boolean;
begin
   result := (LogicalOperator = ALogicOper) or (ActiveCount = 1);
end;

function TatSQLConditions.GetConditionStr(Bracketed: Boolean = false; IdentLevel: integer = 0) : string;
var AConditions : TStringList;

   procedure AddConditionStr(const AStr: string);
   begin
      AConditions.Add(StringOfChar(' ',IdentLevel*3) + AStr);
   end;

Var
  c : integer;
  bracketNeeded : Boolean;
  LogicalOperatorRequired : Boolean;
begin
  result := '';
  AConditions := TStringList.create;
  try
    LogicalOperatorRequired := FALSE;
    {$IFDEF TryToRemoveBrackets}
    //BracketNeeded := ActiveCount > 1;
    //IsOR := sametext(trim(HeadingOperator),'OR');
    //if ANegate and (IsOR and (ActiveCount > 1)) then
    //  BracketNeeded := TRUE;
    {$ENDIF}
    BracketNeeded := FALSE;
    if MetaSQLForceBrackets then
      BracketNeeded := TRUE;

    if ((GetOwner is TatSQLCondition) and TatSQLCondition(GetOwner).Negate) then
    begin
      AddConditionStr('NOT ');
      if ActiveCount > 1 then
        BracketNeeded := TRUE;
    end;
    if Bracketed then
      BracketNeeded := TRUE;
    if BracketNeeded then
      AddConditionStr('(');
    { cach active items only }
     for c:=0 to ActiveCount-1 do
     begin
       { add AND or OR as needed }
       if LogicalOperatorRequired then
         AddConditionStr(LogicalArray[LogicalOperator]);
       { watch case of condition: }
       Case ActiveItems[c].ConditionType of
         ctSubConditions:
           { append subcondition items as appropriate }
           begin
              { are brackets needed ? }
              AddConditionStr(
                 ActiveItems[c].SubConditions.GetConditionStr(
                   NOT ActiveItems[c].SubConditions.MayMergeTo(LogicalOperator),IdentLevel+1));
              LogicalOperatorRequired := TRUE;
           end;
         else
           begin
              AddConditionStr(ActiveItems[c].SolvedExpression);
              LogicalOperatorRequired := TRUE;
           end;
       end;
     end;

     if BracketNeeded then
       AddConditionStr(')');
     result := AConditions.text;
     if result = '' then
       result := TrueExpr;
   finally
     AConditions.free;
   end;
end;

function TatSQLConditions.FindByName(const AName: string; Recursive: boolean=true): TatSQLCondition;
Var c: integer;
begin
   result:=nil;
   for c:=0 to Count-1 do
      if AnsiCompareText(AName,Items[c].Name)=0 then
      begin
         result:=Items[c];
         exit;
      end;

   if Recursive and not Assigned(result) then
      for c:=0 to Count-1 do
      begin
         result:=Items[c].SubConditions.FindByName(AName, Recursive);
         if Assigned(result) then
            break;
      end;
end;

function TatSQLConditions.GetMetaSQL: TatMetaSQL;
begin
   Result := FMetaSQL;
   if not Assigned(FMetaSQL) and (GetOwner is TatSQLCondition) then
      result:=TatSQLCondition(GetOwner).MetaSQL;
end;

function TatSQLConditions.GetSQLJoin: TatSQLJoin;
begin
   result:=nil;
   if GetOwner<>nil then
      if GetOwner is TatSQLJoin then
         result:=TatSQLJoin(GetOwner)
      else
      if GetOwner is TatSQLCondition then
         result:=TatSQLCondition(GetOwner).SQLJoin;
end;

{ SQL statement Parser }
procedure SQLStringToMetaSQL(const ASQLString: string; AMetaSQL: TatMetaSQL);
var MetaSQLParser: TatSQLParser;
    cond_count : integer;
    expr_count : integer;

   function ConvertSpacedName(AName: string): string;
   begin
     if (Length(AName) > 2) and (Pos(AName[1], FieldDelimOpenChars) <> 0) and
       (Pos(AName[Length(AName)], FieldDelimCloseChars) <> 0) then
       result := Copy(AName, 2, Length(AName) - 2)
     else
       result := AName;
   end;

   procedure SplitInTwo(s:string;const sep:string;var a,b:string);
   var p:integer;
   begin
      { Separa a string "s" em duas partes, sinalizado por "sep" }
      { se não for encontrado o sep, então retorna em "a" a string original }
      p:=pos(AnsiUpperCase(sep),AnsiUpperCase(s));
      if p=0 then p:=MaxInt;
      a:=copy(s,1,p-1);
      b:=copy(s,p+length(sep),MaxInt);
   end;

   function DefineField(AExpressionNode:TNoTerminalNode;AAliasName:string;AIncludeInSql:boolean):TatSQLField;
   begin
     result := AMetaSQL.SqlFields.Add;
     with result do
     begin
       Active := AIncludeInSql;
       { testa o tipo da expressão para determinar o
         tipo do campo que será criado na meta-sql }

       { para ser um etStandard de um simples campos,
         o AExpressionNode deve corresponder a seguinte estrutura sintática:

         EXPRESSION (a) ::  FIELD
         FIELD          ::  [TABLE_ALIAS] + FIELDNAME
       }
       if NodeMatch( AExpressionNode, [0,0], [ntField,ntANY] ) then
       begin
         { simples referência a um campo de uma tabela }
         ExpressionType := etStandard;
         { extrai o TableAlias e o FieldName }
         if NodeMatch( AExpressionNode[0], [0], [ntTableAlias] ) then
         begin
           TableAlias := ConvertSpacedName(AExpressionNode[0][0].InputToken);
           FieldName := ConvertSpacedName(AExpressionNode[0][1].InputToken);
         end
         else
           { aqui o campo foi fornecido sem um TableAlias }
           FieldName := ConvertSpacedName(AExpressionNode[0][0].InputToken);
       end
       else
         { para ser um etStandard de função de agregação,
           o AExpressionNode deve corresponder a seguinte estrutura sintática:

           EXPRESSION (b) :: FUNCTION
           FUNCTION       :: SUM( EXPRESSION(a) )   ou
                             MAX( EXPRESSION(a) )   ou
                             MIN( EXPRESSION(a) )   ou
                             AVG( EXPRESSION(a) )   ou
                             COUNT( EXPRESSION(a) )
         }
         if (AExpressionNode[0].Nodes.Count>0) and
            (NodeType( AExpressionNode[0][0] ) in [ntSum,ntMin,ntMax,ntAvg,ntCount]) and
            (NodeMatch(AExpressionNode, [0,0,0,0,0], [ntFunction,ntANY,ntExpression,ntField,ntANY])) and
            (AExpressionNode[0][0][0].Nodes.Count = 1) then
         begin
           { função aplicada sobre um campo de uma tabela }
           ExpressionType := etStandard;
           { determina a função de agregação que está presente }
           case NodeType(AExpressionNode[0][0]) of
             ntSum   : GroupFunction := agfSum;
             ntMin   : GroupFunction := agfMin;
             ntMax   : GroupFunction := agfMax;
             ntAvg   : GroupFunction := agfAvg;
             ntCount : GroupFunction := agfCount;
           end;

           { extrai o TableAlias e o FieldName }
           if NodeMatch( AExpressionNode[0][0][0][0],[0], [ntTableAlias] ) then
           begin
             TableAlias := ConvertSpacedName(AExpressionNode[0][0][0][0][0].InputToken);
             FieldName := ConvertSpacedName(AExpressionNode[0][0][0][0][1].InputToken);
           end
           else
             { aqui o campo foi fornecido sem um TableAlias }
             FieldName := ConvertSpacedName(AExpressionNode[0][0][0][0][0].InputToken);
         end
         else
         begin
           { AExpressionNode is custom expression }
           ExpressionType := etCustomExpr;
           FieldExpression := Trim(AExpressionNode.InputToken);
         end;

       { define o apelido do campo }
       if (AAliasName>'') or (FieldName = '*') then
       begin
          { field alias fornecido na sql }
          FieldAlias := AAliasName;
          {Change field alias if field has an aggregated function}
          case GroupFunction of
            agfSum   : AAliasName := AAliasName + '_Sum';
            agfMin   : AAliasName := AAliasName + '_Min';
            agfMax   : AAliasName := AAliasName + '_Max';
            agfAvg   : AAliasName := AAliasName + '_Avg';
            agfCount : AAliasName := AAliasName + '_Cnt';
          end;
       end
       else
         { field alias não fornecido - tenta montá-lo automaticamente }
         if ExpressionType = etStandard then
         begin
           { tenta usar o nome do campo como alias,
             se já existir então inclui um contador de repetição como sufixo }
           AAliasName := FieldName;
           {Change field alias if field has an aggregated function}
           case GroupFunction of
             agfSum   : AAliasName := AAliasName + '_Sum';
             agfMin   : AAliasName := AAliasName + '_Min';
             agfMax   : AAliasName := AAliasName + '_Max';
             agfAvg   : AAliasName := AAliasName + '_Avg';
             agfCount : AAliasName := AAliasName + '_Cnt';
           end;

           ChangeExclusiveFieldAlias(AAliasName);
           AAliasName := FieldAlias; 
         end
         else
         begin
           inc(expr_count);
           AAliasName := 'Expr' + IntToStr(expr_count)
         end;
       FieldAlias := AAliasName;
     end;
   end;

   function FieldAliasByExpression(ANode:TNoTerminalNode):string;
   var c   : integer;
       fld : TatSQLField;
   begin
      { Retorna o FieldAlias associado a expressão dada em ANode.
        Se não existir um campo compatível com a expressão dada então o cria }

      result:=Trim(ANode.InputToken); // auxiliary storage
      { primeiro testa se já foi fornecido um FieldAlias como expressão do campo }
      if (NodeType(ANode[0])=ntField) and
         (NodeType(ANode[0][0])=ntFieldName) then
      begin
         fld:=AMetaSQL.SqlFields.FindByAlias(ConvertSpacedName(result));
         { se o FieldAlias dado não existe na meta-sql então causa uma exceção }
         if fld=nil then
           result := DefineField(ANode,'',false).FieldAlias;
         //   raise Exception.CreateFmt('FieldAlias ''%s'' not defined',[result]);
      end
      else
      begin
         { como não foi dado o FieldAlias então tenta encontrar o campo através
           de expressão idêntica no SqlFields do meta-sql }

         { procura o campo pela própria expressão }
         with AMetaSQL.SqlFields do
            for c:=0 to Count-1 do
               if CompareText(Items[c].FieldExpression,result)=0 then
               begin
                  { encontrou então retorna seu FieldAlias }
                  result:=Items[c].FieldAlias;
                  Exit;
               end;

         { não encontrou então cria-o agora e retorna seu FieldAlias }
         result := DefineField(ANode,'',false).FieldAlias;
      end;
   end;

   procedure ParseFields;
   var fldlst_slc_node : TNoTerminalNode;
       expr_node : TNoTerminalNode;
       c : integer;
       Start: integer;
   begin
      AMetaSQL.SqlFields.Clear;
      fldlst_slc_node := NodeCast(MetaSQLParser.Parser.Node,[0,0],[ntSelect,ntFldlst_slc]);
      if fldlst_slc_node.Nodes[0].NoTerminalIndex = Ord(ntDistinct) then
      begin
        Start := 1;
        AMetaSQL.Distinct := True;
      end else
      begin
        Start := 0;
        AMetaSQL.Distinct := false;
      end;
      if fldlst_slc_node.Nodes[Start].NoTerminalIndex = Ord(ntAllFieldsExp) then
      begin
         { * -> all fields expression found. }
      end
      else
      for c:=Start to fldlst_slc_node.Nodes.Count-1 do
      begin
         expr_node := NodeCast(fldlst_slc_node[c],[0],[ntExpression]);
         { se o FieldAlias foi dado usa-o, senão define um automaticamente }
         if fldlst_slc_node[c].Nodes.Count>1 then
            DefineField( expr_node, ConvertSpacedName(NodeCast(fldlst_slc_node[c],[1],[ntFieldAlias]).InputToken), true )
         else
            DefineField( expr_node, '', true );
      end;
   end;

   procedure ParseConditions( AExprNode:TNoTerminalNode; AConditions:TatSqlConditions );
   var c : integer;
   begin
      { monta as coleções aninhadas de conditions com base na
        estrutura de expressões AExprNode }

      { AExprNode é uma coleção de itens em que cada um pode ser:
         - <logic_expr>
         - <logic_expr1>
         - <not>
         - <exists>
         - <logic>
         - <in>
         - <relational>
         - <field> }

      for c:=0 to AExprNode.Nodes.Count-1 do
         with AConditions.Add do
         begin
            inc(cond_count);
            Name:='Condition'+IntToStr(cond_count);
            { ajusta as propriedades do condition de acordo
              com o tipo da expressão }
            case NodeType(AExprNode[c]) of
               ntLogic_Expr,  // OR operator level
               ntLogic_Expr1: // AND operator level
                  begin
                     ConditionType := ctSubConditions;
                     if NodeType(AExprNode[c])=ntLogic_Expr then
                        SubConditionsLogicalOper := lgOr
                     else
                        SubConditionsLogicalOper := lgAnd;
                     ParseConditions( AExprNode[c], SubConditions );
                     { OTIMIZAÇÃO: evita armazenar coleções com apenas uma
                       única condição, fazendo a condição assumir o conteúdo
                       de sua única subcondição interna }
                     if (SubConditions.Count=1) then
                     begin
                        ConditionType := SubConditions[0].ConditionType;
                        case SubConditions[0].ConditionType of
                           ctValueCompare, ctFieldCompare, ctParamCompare:
                              begin
                                 FieldAlias := SubConditions[0].FieldAlias;
                                 Operator := SubConditions[0].Operator;
                                 Value := SubConditions[0].Value;
                                 SubConditions.Clear;
                              end;
                           ctSubConditions:
                              begin
                                 SubConditions.Assign(SubConditions[0].SubConditions);
                                 SubConditionsLogicalOper := SubConditions[0].SubConditionsLogicalOper;
                              end;
                           ctCustomExpr:
                              begin
                                 Expression := SubConditions[0].Expression;
                                 SubConditions.Clear;
                              end;
                        end;
                     end;
                     { *** poderiamos fazer outra simplificação aqui:
                       se uma coleção possui outro coleção com de mesmo operador lógico
                       então a sub-coleção poderia ser transferida para a primeira *** }
                  end;
               ntNot,
               ntExists,
               ntIn,
               ntField:
                  begin
                     ConditionType := ctCustomExpr;
                     Expression := Trim(AExprNode[c].InputToken);
                  end;
               ntLogic:
                  if SameText(AExprNode[c].InputToken,'TRUE') then
                     ConditionType := ctTrueExpr
                  else
                     if SameText(AExprNode[c].InputToken,'FALSE') then
                        ConditionType := ctFalseExpr
                     else
                     begin
                        ConditionType := ctCustomExpr;
                        Expression := AExprNode[c].InputToken;
                     end;
               ntRelational:
                  begin
                     { a condição é representada por uma expressão lógica relacional,
                       então verifica se é uma comparação especial }

                     { reconhece 0=0 como ctTrueExpr e 0=1 como ctFalseExpr }
                     if (Trim(AExprNode[c][0].InputToken)='0') and
                        (Trim(AExprNode[c][1].InputToken)='=') and
                        (Trim(AExprNode[c][2].InputToken)='0') then
                        ConditionType := ctTrueExpr
                     else
                     if (Trim(AExprNode[c][0].InputToken)='0') and
                        (Trim(AExprNode[c][1].InputToken)='=') and
                        (Trim(AExprNode[c][2].InputToken)='1') then
                        ConditionType := ctFalseExpr
                     else
                     begin
                        { *** por enquanto não reconhece expressões do tipo
                          ctValueCompare nem ctParamCompare.
                          Devo analisar minuciosamente a estrutura sintática para
                          determinar o tipo de condição mais adequado *** }

                        { para ser um FieldCompare, a expressão deve ser
                          formada pela seguinte estrutura sintática:
                          RELATIONAL  ::  EXPRESSION + RELAT_OPER + EXPRESSION
                          RELAT_OPER  ::  "=", "<>", ">=", "<=", ">", "<"
                          EXPRESSION  ::  FIELD
                          FIELD       ::  [TABLE_ALIAS] + FIELDNAME
                        }
                        if (NodeType(AExprNode[c][0])=ntExpression) and
                           (NodeType(AExprNode[c][1])=ntRelat_Oper) and
                           (NodeType(AExprNode[c][2])=ntExpression) and
                           (NodeType(AExprNode[c][0][0])=ntField) and
                           (NodeType(AExprNode[c][2][0])=ntField) then
                        begin
                           ConditionType := ctFieldCompare;
                           FieldAlias := FieldAliasByExpression(AExprNode[c][0]);
                           Operator := AExprNode[c][1].InputToken;
                           Value := FieldAliasByExpression(AExprNode[c][2]);
                        end
                        else
                        begin
                           ConditionType := ctCustomExpr;
                           Expression := Trim(AExprNode[c].InputToken);
                        end;
                     end;
                  end;
            end;
         end;

      { OTIMIZAÇÃO: se uma coleção contém apenas uma outra coleção,
        então subsitui a primeira pela segunda }
      with AConditions do
         if (Count=1) and (Items[0].ConditionType=ctSubConditions) then
         begin
            LogicalOperator:=Items[0].SubConditions.LogicalOperator;
            for c:=0 to Items[0].SubConditions.Count-1 do
               Add.Assign(Items[0].SubConditions[c]);
            Delete(0);
         end;
   end;

   procedure ParseSource;

      procedure ExtractTable( ANode: TNoTerminalNode; ATable:TatSQLTable );
      begin
         { extrai informações de um nó <table> }
         with ATable do
         begin
            TableName :=  ConvertSpacedName(ANode[0].InputToken);
            if ANode.Nodes.Count>1 then
               TableAlias := ConvertSpacedName(ANode[1].InputToken);
         end;
      end;

      procedure ExtractJoin( ANode: TNoTerminalNode; ATable:TatSQLTable );
      var t1_alias, t1_field, t2_alias, t2_field : string;
      begin
         { desmonta o ANode que pode ser:
            - ntLeft_Join
            - ntRight_Join
            - ntInner_Join
            mas sua estrutura é sempre <table> <logic_expr> }

         ExtractTable( ANode[0], ATable );

         with AMetaSQL.TableJoins.Add do
         begin
            if NodeType(ANode)=ntLeft_Join  then LinkType := altLeftJoin else
            if NodeType(ANode)=ntRight_Join then LinkType := altLeftJoin else
            if NodeType(ANode)=ntInner_Join then LinkType := altInnerJoin;

            { primeiro monta as condições de junção como condições extras }
            JoinConditionsLogicalOper := lgOr;
            JoinConditions.Clear;
            ParseConditions( ANode[1], JoinConditions );

            { agora extrai as ligações principais da junção }
            { a primeira condição extra deve satisfazer ao seguinte critério:
              - deve ser uma equação envolvendo dois campos simples
              - um dos campos da equação deve ser proveniente da tabela indicada por ultimo na junção }
            if (JoinConditions.Count>0) then
            begin
               { *** por enquanto vou desmontar a junção manualmente porque o
                 ConditionType ainda não suporte TableJoin ***}
               SplitInTwo( JoinConditions[0].Expression, '=', t1_field, t2_field );
               SplitInTwo( Trim(t1_field), '.', t1_alias, t1_field );
               SplitInTwo( Trim(t2_field), '.', t2_alias, t2_field );
               t1_alias := ConvertSpacedName(t1_alias);
               t2_alias := ConvertSpacedName(t2_alias);
               t1_field := ConvertSpacedName(t1_field);
               t2_field := ConvertSpacedName(t2_field);
               if SameText(Trim(t1_alias),ATable.TableAlias) then
               begin
                  PrimaryTableAlias := Trim(t2_alias);
                  ForeignTableAlias := Trim(t1_alias);
               end
               else
               begin
                  PrimaryTableAlias := Trim(t1_alias);
                  ForeignTableAlias := Trim(t2_alias);
               end;
            end;
         end;
      end;

      procedure Branch( Node:TNoTerminalNode );
      var c: integer;
      begin
         { desmonta um nó interno do <Source> da Sql
           (somente se ele for <Joined_src) }
         if Node.NoTerminalIndex=ord(ntJoined_src) then
         begin
            { existem dois tipos de Joined_src: sem ou com parenteses }
            if Node[0].NoTerminalIndex=ord(ntTable) then
            begin
               { junções sem parenteses }
               ExtractTable( Node[0], AMetaSQL.SqlTables.Add );
               for c:=1 to Node.Nodes.Count-1 do
                  ExtractJoin( Node[c], AMetaSQL.SqlTables.Add );
            end
            else
            begin
               { junções com parenteses }
               Branch( Node[0] );
               for c:=1 to Node.Nodes.Count-1 do
                  ExtractJoin( Node[c], AMetaSQL.SqlTables.Add );
            end;
         end
         else
           { <listed_src> é uma coleção de <table> }
           for c:=0 to Node.Nodes.Count-1 do
             ExtractTable( Node[c], AMetaSQL.SqlTables.Add );
         //raise Exception.Create('Syntax not suported');
      end;

   begin
      AMetaSQL.SqlTables.Clear;
      AMetaSQL.TableJoins.Clear;
      Branch( NodeCast( MetaSQLParser.Parser.Node, [0,1], [ntSelect,ntSource])[0] );
   end;

   procedure ParseWhere;
   var node : TNoTerminalNode;
   begin
      AMetaSQL.Conditions.Clear;
      node := NodeCast( MetaSQLParser.Parser.Node, [0,2], [ntSelect,ntWhere] );
      { se a cláusula where estiver presente, então extrai suas condições lógicas }
      if node.Nodes.Count>0 then
      begin
         AMetaSQL.ConditionsLogicalOper:=lgOr; // poderá ser substituido dentro do ParseConditions
         ParseConditions(
            NodeCast(node,[0],[ntLogic_Expr]),
            AMetaSQL.Conditions );
      end;
   end;

   procedure ParseGroupBy;
   var fldlst_grp_node : TNoTerminalNode;
       c : integer;
   begin
      AMetaSQL.GroupFields.Clear;
      fldlst_grp_node := NodeCast(MetaSQLParser.Parser.Node,[0,3],[ntSelect,ntGroupBy]);
      if fldlst_grp_node.Nodes.Count>0 then
      begin
         fldlst_grp_node := NodeCast(fldlst_grp_node,[0],[ntFldlst_grp]);
         { scan field expressions }
         for c:=0 to fldlst_grp_node.Nodes.Count-1 do
            with AMetaSQL.GroupFields.Add do
               FieldAlias := FieldAliasByExpression(fldlst_grp_node[c]);
      end;
   end;

   procedure ParseOrderBy;
   var fldlst_ord_node : TNoTerminalNode;
       c : integer;
   begin
      AMetaSQL.OrderFields.Clear;
      fldlst_ord_node := NodeCast(MetaSQLParser.Parser.Node,[0,5],[ntSelect,ntOrderBy]);
      if fldlst_ord_node.Nodes.Count>0 then
      begin
         fldlst_ord_node := NodeCast(fldlst_ord_node,[0],[ntFldlst_ord]);
         { varre as expressões de campos }
         c:=0;
         while c<fldlst_ord_node.Nodes.Count do
         begin
            { cria um campo de ordenação }
            with AMetaSQL.OrderFields.Add do
            begin
               { define seu apelido }
               FieldAlias := FieldAliasByExpression(fldlst_ord_node[c]);
               { testa se foi fornecido também um modificador para ordenação descendente }
               if (c<fldlst_ord_node.Nodes.Count-1) and
                  (NodeType(fldlst_ord_node[c+1])=ntDescending) then
               begin
                  SortType := ortDescending;
                  inc(c);
               end;
            end;
            inc(c);
         end;
      end;
   end;

begin
   //screen.Cursor:=crHourGlass;  <-- Let user decide if he wants cursor or not
   MetaSQLParser := TatSqlParser.Create(nil);

   { desmonta a sql no objeto meta-sql }
   with MetaSQLParser do
   try
      MetaSQL:=ASQLString;
      ParseMetaSql;
      if Correct then
         if Parser.Node.Nodes.Count>0 then
         begin
            cond_count := 0; // contador de condições da meta-sql (para nomeção automática)
            expr_count := 0; // contador de campos da meta-sql (para nomeção automática)

            {$IFDEF DEBUG_MODE}
            if assigned(FOnSQLStringToMetaSQLDebug) then
               FOnSQLStringToMetaSQLDebug(Parser);
            {$ENDIF}

            ParseFields;
            ParseSource;
            ParseWhere;
            ParseGroupBy;
            ParseOrderBy;
         end
         else
      else
         raise Exception.CreateFmt(_str(SSyntaxErrorAtRow),[ErrorRow,ErrorCol]);
   finally
      Free;
      //screen.Cursor:=crDefault; <-- Let user decide if he wants cursor or not
   end;
end;

function TatSQLConditions.ActiveCount: Integer;
var i : integer;
begin
   Result := 0;
   for i := 0 to count-1 do
      if Items[i].Active then
         inc(Result);
end;

function TatSQLConditions.GetOwner: TPersistent;
begin
  result := inherited GetOwner;
end;


function TatSQLConditions.GetLogicalOperator: TatLogicalOper;
begin
  { allow stream of same logical operator conditions }
  if (ActiveCount = 1) and (ActiveItems[0].ConditionType = ctSubConditions) then
    Result := ActiveItems[0].SubConditionsLogicalOper
  else
    Result := FLogicalOperator;
end;

function TatSQLConditions.GetActiveCondition(
  Index: integer): TatSQLCondition;
var i : Integer;
begin
  result := nil;
  for i := 0 to count-1 do
    if Items[i].Active then
      if Index = 0 then
      begin
        result := Items[i];
        break;
      end
      else
        dec(Index);
end;

procedure TatSQLConditions.SetNegate(const Value: Boolean);
begin
   if GetOwner is tatSQLCondition then
     (GetOwner as tatSQLCondition).Negate:= Value;
end;

function TatSQLConditions.GetNegate: Boolean;
begin
   if GetOwner is tatSQLCondition then
     Result := (GetOwner as tatSQLCondition).Negate
   else
     Result := FALSE;
end;

{ TatSQLParam }

procedure TatSQLParam.Assign(Source: TPersistent);
begin
   if Source is TatSqlParam then
   begin
      Caption := TatSQLParam(Source).Caption;
      Active  := TatSQLParam(Source).Active;
      inherited Assign(Source);
   end
   else
      inherited Assign(Source);
end;

constructor TatSQLParam.Create(Collection: TCollection);
begin
   inherited Create(Collection);
   FActive:=true;
end;

{ TatSQLParams }

function TatSQLParams.Add: TatSqlParam;
begin
   result := TatSqlParam( inherited Add );
end;

constructor TatSQLParams.Create(AOwner: TPersistent);
begin
   FOwner:=AOwner;
   inherited Create(TatSQLParam);
end;

constructor TatSQLParams.Create;
begin
   FOwner:=nil;
   inherited Create(TatSQLParam);
end;

function TatSQLParams.GetItem(i: integer): TatSqlParam;
begin
   result := TatSqlParam( inherited Items[i] );
end;

function TatSQLParams.GetOwner: TPersistent;
begin
   result:=FOwner;
end;

{ TSQLSyntaxConf }

procedure TSQLSyntaxConf.Assign(Source: TPersistent);
begin
  if Source is TSQLSyntaxConf then
  begin
    FParentesisInJoins := TSQLSyntaxConf(Source).FParentesisInJoins;
    FCaseSensitive := TSQLSyntaxConf(Source).FCaseSensitive;
    FIndexInGroupBy := TSQLSyntaxConf(Source).FIndexInGroupBy;
    FIndexInOrderBy := TSQLSyntaxConf(Source).FIndexInOrderBy;
    FSortInnerJoins := TSQLSyntaxConf(Source).FSortInnerJoins;
    FMaskChar := TSQLSyntaxConf(Source).FMaskChar;
    FLeftJoinStr := TSQLSyntaxConf(Source).FLeftJoinStr;
    FRightJoinStr := TSQLSyntaxConf(Source).FRightJoinStr;
    FDateFormat := TSQLSyntaxConf(Source).FDateFormat;
    FAsFieldOperator := TSQLSyntaxConf(Source).FAsFieldOperator;
    FAsTableOperator := TSQLSyntaxConf(Source).FAsTableOperator;
    FIDOpenDelim := TSQLSyntaxConf(Source).FIDOpenDelim;
    FInnerJoinStr := TSQLSyntaxConf(Source).FInnerJoinStr;
    FUpperFunction := TSQLSyntaxConf(Source).FUpperFunction;
    FIDCloseDelim := TSQLSyntaxConf(Source).FIDCloseDelim;
    FJoinSyntax := TSQLSyntaxConf(Source).FJoinSyntax;
  end else
    inherited Assign(Source);
end;

procedure TSQLSyntaxConf.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TSQLSyntaxConf.LoadPredefinedSyntax(ASyntax: TatSQLSyntax);
type
   TatSQLStrSyntaxItem = (
      sqlIDOpenDelim,
      sqlIDCloseDelim,
      sqlAsFieldOperator,
      sqlAsTableOperator,
      sqlMaskChar,
      sqlLeftJoinStr,
      sqlRightJoinStr,
      sqlInnerJoinStr,
      sqlUpperFunction
      );

   TatSQLBoolSyntaxItem = (
      sqlCaseSensitive,
      sqlParentesisInJoins,
      sqlSortInnerJoins,
      sqlIndexInGroupBy,
      sqlIndexInOrderBy
      );

const
  SQLDateFormat:
     array[TatSQLSyntax] of string =
  (
   {ssCustom}    '"'+#39+'"dd/mm/yyyy"'+#39+'"',               
   {ssBDELocal}  '''"'''+'mm/dd/yyyy'+'''"''',
   {ssAccess}    '"#"mm"/"dd"/"yyyy"#"',                       
   {ssOracle}    '"TO_DATE(''"dd/mm/yyyy"'', ''DD/MM/YYYY'')"',
   {ssInterbase} '"CAST(''"mm"/"dd"/"yyyy"'' AS DATE)"',
   {ssMSSQL}     '"CONVERT(DATETIME, ''"mm/dd/yyyy"'', 101)"',  { style 101 = 'mm/dd/yyyy' }
   {ssDBISAM}    '''"''yyyy-mm-dd''"''' ,
   {ssMySQL}     '"CAST(''"yyyy"-"mm"-"dd"'' AS DATETIME)"',   { always yyyy/mm/dd, fixed style }
   {ssNexus}     '"CAST(''"ddddd"'' AS DATETIME)"',
   {ssAccessADO} '"#"mm"/"dd"/"yyyy"#"',
   {ssDBISAM4}   '"'+#39+'"yyyy-mm-dd"'+#39+'"',
   {ssFirebird}  '"CAST(''"mm"/"dd"/"yyyy"'' AS DATE)"'
  );

  SQLStrSyntax :
      array[TatSQLSyntax] of
         array[TatSQLStrSyntaxItem] of string =
  {sqlIDOpenDelim, sqlIDCloseDelim, sqlAsFieldOperator, sqlAsTableOperator,sqlMaskChar
   sqlLeftJoinStr, sqlRightJoinStr, sqlInnerJoinStr, sqlUpperFunction}

  (
   {ssCustom}     (''  , ''  , ''   , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , ''           ) ,
   {ssBDELocal}   ('"' , '"' , ''   , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , 'upper(%s)'  ) ,
   {ssAccess}     ('[' , ']' , 'AS' , '' , '*' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , ''           ) ,
   {ssOracle}     ('"' , '"' , ''   , '' , '%' , ''                , ''                 , 'INNER JOIN' , 'upper(%s)'  ) ,
   {ssInterbase}  ('"' , '"' , ''   , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , 'upper(%s)'  ) ,
   {ssMSQL}       ('[' , ']' , 'AS' , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , ''           ) ,
   {ssDBISAM}     ('"' , '"' , 'AS' , '' , '%' , 'LEFT OUTER JOIN' , 'RIGHT OUTER JOIN' , 'INNER JOIN' , 'upper(%s)'  ) ,
   {ssMySQL}      ('"' , '"' , 'AS' , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , ''           ) ,
   {ssNexus}      ('"' , '"' , 'AS' , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , 'upper(%s)'  ) ,
   {ssAccessADO}  ('[' , ']' , 'AS' , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , ''           ) ,
   {ssDBISAM4}    ('"' , '"' , 'AS' , '' , '%' , 'LEFT OUTER JOIN' , 'RIGHT OUTER JOIN' , 'INNER JOIN' , 'upper(%s)'  ) ,
   {ssFirebird}   ('"' , '"' , ''   , '' , '%' , 'LEFT JOIN'       , 'RIGHT JOIN'       , 'INNER JOIN' , 'upper(%s)'  ) 
  );

  SQLBoolSyntax:
      array[TatSQLSyntax] of
         array[TatSQLBoolSyntaxItem] of boolean =
  {sqlCaseSensitive, sqlParentesisInJoins, sqlSortInnerJoins, sqlIndexInGroupBy, sqlIndexInOrderBy}

  (
   {ssCustom}     (false , true , false , false , false ),
   {ssBDELocal}   (true  , true , false , false , false ),
   {ssAccess}     (false , true , true  , false , false ),
   {ssOracle}     (true  , true , false , false , false ),
   {ssInterbase}  (true  , true , false , false , false ),
   {ssMSQL}       (false , true , false , false , false ),
   {ssDBISAM}     (true  , true , false , false , false ),
   {ssMySQL}      (false , true , false , false , false ),
   {ssNexus}      (true  , false, false , false , false ),
   {ssAccessADO}  (false , true , true  , false , false ),
   {ssDBISAM4}    (true  , true , false , false , false ),
   {ssFirebird}   (true  , true , false , true  , true  )
  );

  SQLJoinSyntax :
    array[TatSQLSyntax] of TatSQLJoinSyntax =
  (
   {ssCustom}     alsFrom ,
   {ssBDELocal}   alsFrom ,
   {ssAccess}     alsFrom ,
   {ssOracle}     alsWhere,
   {ssInterbase}  alsFrom ,
   {ssMSQL}       alsFrom ,
   {ssDBISAM}     alsFrom ,
   {ssMySQL}      alsFrom ,
   {ssNexus}      alsFrom ,
   {ssAccessADO}  alsFrom ,
   {ssDBISAM4}    alsFrom ,
   {ssFirebird}   alsFrom
  );

begin
  if ASyntax <> ssCustom then
  begin
    FParentesisInJoins := SQLBoolSyntax[ASyntax][sqlParentesisInJoins];
    FCaseSensitive := SQLBoolSyntax[ASyntax][sqlCaseSensitive];
    FIndexInGroupBy := SQLBoolSyntax[ASyntax][sqlIndexInGroupBy];
    FIndexInOrderBy := SQLBoolSyntax[ASyntax][sqlIndexInOrderBy];
    FSortInnerJoins := SQLBoolSyntax[ASyntax][sqlSortInnerJoins];
    FMaskChar := SQLStrSyntax[ASyntax][sqlMaskChar];
    FLeftJoinStr := SQLStrSyntax[ASyntax][sqlLeftJoinStr];
    FRightJoinStr := SQLStrSyntax[ASyntax][sqlRightJoinStr];
    FDateFormat := SQLDateFormat[ASyntax];
    FAsFieldOperator := SQLStrSyntax[ASyntax][sqlAsFieldOperator];
    FAsTableOperator := SQLStrSyntax[ASyntax][sqlAsTableOperator];
    FIDOpenDelim := SQLStrSyntax[ASyntax][sqlIDOpenDelim];
    FInnerJoinStr := SQLStrSyntax[ASyntax][sqlInnerJoinStr];
    FUpperFunction := SQLStrSyntax[ASyntax][sqlUpperFunction];
    FIDCloseDelim := SQLStrSyntax[ASyntax][sqlIDCloseDelim];
    FJoinSyntax := SQLJoinSyntax[ASyntax];
  end;
end;

procedure TSQLSyntaxConf.SetAsFieldOperator(const Value: string);
begin
  if FAsFieldOperator <> Value then
  begin
    FAsFieldOperator := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetAsTableOperator(const Value: string);
begin
  if FAsTableOperator <> Value then
  begin
    FAsTableOperator := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetCaseSensitive(const Value: boolean);
begin
  if FCaseSensitive <> Value then
  begin
    FCaseSensitive := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetDateFormat(const Value: string);
begin
  if FDateFormat <> Value then
  begin
    FDateFormat := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetIDCloseDelim(const Value: string);
begin
  if FIDCloseDelim <> Value then
  begin
    FIDCloseDelim := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetIDOpenDelim(const Value: string);
begin
  if FIDOpenDelim <> Value then
  begin
    FIDOpenDelim := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetIndexInGroupBy(const Value: boolean);
begin
  if FIndexInGroupBy <> Value then
  begin
    FIndexInGroupBy := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetIndexInOrderBy(const Value: boolean);
begin
  if FIndexInOrderBy <> Value then
  begin
    FIndexInOrderBy := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetInnerJoinStr(const Value: string);
begin
  if FInnerJoinStr <> Value then
  begin
    FInnerJoinStr := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetJoinSyntax(const Value: TatSQLJoinSyntax);
begin
  if FJoinSyntax <> Value then
  begin
    FJoinSyntax := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetLeftJoinStr(const Value: string);
begin
  if FLeftJoinStr <> Value then
  begin
    FLeftJoinStr := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetMaskChar(const Value: string);
begin
  if FMaskChar <> Value then
  begin
    FMaskChar := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetParentesisInJoins(const Value: boolean);
begin
  if FParentesisInJoins <> Value then
  begin
    FParentesisInJoins := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetRightJoinStr(const Value: string);
begin
  if FRightJoinStr <> Value then
  begin
    FRightJoinStr := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetSortInnerJoins(const Value: boolean);
begin
  if FSortInnerJoins <> Value then
  begin
    FSortInnerJoins := Value;
    Changed;
  end;
end;

procedure TSQLSyntaxConf.SetUpperFunction(const Value: string);
begin
  if FUpperFunction <> Value then
  begin
    FUpperFunction := Value;
    Changed;
  end;
end;

initialization
  RegisterClasses([TatMetaSql]);
end.
