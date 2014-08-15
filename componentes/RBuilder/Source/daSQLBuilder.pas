{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit daSQLBuilder;

interface

uses
  SysUtils,
  Classes,

  ppTypes,
  ppRTTI,
  ppDB,
  ppClass,
  ppDsgnDB,
  ppUtils,

  daSQL;

type

  // forward declarations                           
  TdaSQLBuilder = class;
  TdaSQLSelectTables = class;
  TdaSQLSelectFields = class;
  TdaSQLCalcFields = class;
  TdaSQLGroupByFields = class;
  TdaSQLCriteriaList = class;
  TdaSQLGroupCriteriaList = class;
  TdaSQLOrderByFields = class;
  TdaSQLLinks = class;

  TdaSQLBuilderClass = class of TdaSQLBuilder;


  {@TdaSQLBuilder

    Provides a run-time interface for dynamically modifying the TdaSQL object
    associated with a DADE SQL DataView.

    ReportBuilder's Data workspace provides visual query designer tools that
    enable design-time modification of DADE SQL DataViews. Use TdaSQLBuilder to
    modify DADE SQL programmatically at run-time. Modification of SQL should
    be performed from the Report.OnInitializeParameters or
    Report.BeforeOpenDataPipelines events.

    The SQLBuilder class is designed to modify an existing SQL object. The
    constructor is overloaded to accept a SQL object, a DataPipeline, or a
    Report. The following statements produce the same result:

     <Code>

      lSQLBuilder := TdaSQLBuilder.Create(myReport.DataPipeline.SQL);

      lSQLBuilder := TdaSQLBuilder.Create(myReport.DataPipeline);

      lSQLBuilder := TdaSQLBuilder.Create(myReport);

      </Code>

    The SQLBuilder class contains a number of object properties organized much
    like the pages of the visual query designer. Each of the following object
    properties is used to manage a list of table, field, or criteria items
    that are used to define a SQL statement.

    <Table>
     Property                Use
     -----------------       --------------------------------------------
     SelectTables            add/remove tables and table joins to the SQL From clause
     SelectFields            add/remove fields to the SQL Select clause
     CalcFields              add/remove calculated fields to the SQL Select clause
     GroupByFields           add/remove fields to the SQL Group By clause
     SearchCriteria          add/remove search criteria to the SQL Where clause
     GroupSearchCriteria     add/remove group search criteria to the SQL Having clause
     OrderByFields           add/remove fields to the SQL Order By clause
    </Table>

   }

  {@TdaSQLBuilder.DataSettings
   Provides access to the DataSettings of the SQL object.}

  {@TdaSQLBuilder.Distinct
   Defaults to False. Set Distince to True to add the Distinct keyword to the
   Select clause of the SQL.}

  {@TdaSQLBuilder.SelectTables
   Used to add/remove tables and table joins to the From clause of the SQL.}

  {@TdaSQLBuilder.SelectFields
   Used to add/remove fields to the Select clause of the SQL.}

  {@TdaSQLBuilder.CalcFields
   Used to add/remove calculated fields to the Select clause of the SQL.}

  {@TdaSQLBuilder.GroupByFields
   Used to add/remove fields to the Group By clause of the SQL.}

  {@TdaSQLBuilder.SearchCriteria
   Used to add/remove search criteria to the Where clause of the SQL.}

  {@TdaSQLBuilder.GroupSearchCriteria
   Used to add/remove search criteria to the Having clause of the SQL.}

  {@TdaSQLBuilder.OrderByFields
   Used to add/remove fields to the Order By clause of the SQL.}

  TdaSQLBuilder = class(TPersistent)
  private
    FSQL: TdaSQL;
    FOriginalSQL: TdaSQL;
    FSelectTables: TdaSQLSelectTables;
    FSelectFields: TdaSQLSelectFields;
    FCalcFields: TdaSQLCalcFields;
//    FDataPipeline: TppDataPipeline;
    FGroupByFields: TdaSQLGroupByFields;
    FSearchCriteria: TdaSQLCriteriaList;
    FOrderByFields: TdaSQLOrderByFields;
    FDataSettings: TppDataSettings;
    FGroupSearchCriteria: TdaSQLGroupCriteriaList;
    FSQLLinks: TdaSQLLinks;


    function GetDataSettings: TppDataSettings;
    function GetDistinct: Boolean;
    function GetSQL: TdaSQL;
    procedure SetDataSettings(aDataSettings: TppDataSettings);
    procedure SetDistinct(const Value: Boolean);

  public
    constructor Create(aSQL: TObject); overload; virtual;
    constructor Create(aReport: TppCustomReport); overload; virtual;
    constructor Create(aDataPipeline: TppDataPipeline); overload; virtual;

    destructor Destroy; override;

    procedure Clear;
    procedure ApplyUpdates;

    procedure CreateLink(aMasterPipeline: TppDataPipeline; aMasterFieldAlias, aDetailFieldAlias: String);

  published // used for RTTI only, not streaming

    property SQL: TdaSQL read GetSQL;
    property SQLLinks: TdaSQLLinks read FSQLLinks;

    property DataSettings: TppDataSettings read GetDataSettings write SetDataSettings;
    property Distinct: Boolean read GetDistinct write SetDistinct;
    property SelectTables: TdaSQLSelectTables read FSelectTables;
    property SelectFields: TdaSQLSelectFields read FSelectFields;
    property CalcFields:   TdaSQLCalcFields read FCalcFields;
    property GroupByFields: TdaSQLGroupByFields read FGroupByFields;
    property GroupSearchCriteria: TdaSQLGroupCriteriaList read FGroupSearchCriteria;
    property SearchCriteria: TdaSQLCriteriaList read FSearchCriteria;
    property OrderByFields: TdaSQLOrderByFields read FOrderByFields;
  end;


  {@TdaSQLLinks

    Used to define a linking relationship to a master query. }

  TdaSQLLinks = class(TPersistent)
  private
    FSQL: TdaSQL;

    function GetCount: Integer;
    function GetItems(Index: Integer): TdaSQLLink;
    function GetLinkType: TdaLinkType;
    function GetMasterSQL: TdaSQL;
    procedure SetLinkType(const Value: TdaLinkType);

  public
    constructor Create(aSQL: TdaSQL); virtual;

    procedure Clear;
    function Add(aMasterPipeline: TppDataPipeline; aMasterFieldAlias, aDetailFieldAlias: String): TdaSQLLink;
    procedure Remove(aIndex: Integer);

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdaSQLLink read GetItems; default;
    property LinkType: TdaLinkType read GetLinkType write SetLinkType;
    property MasterSQL: TdaSQL read GetMasterSQL;

  end;

  {@TdaSQLTableList

   Abstract ancestor class. Provides properties and methods for managing a list
   of TdaTable objects that are used to define a SQL query.

   The TdaSQLTableList class defines an Available[] array that provides a list
   of tables that are available to be added to the SQL and an Items[] array that
   represents the list of tables that are included in the SQL. The Items[]
   array property is declared as the default property. Thus the following
   two references are equivalent:

      <Code>

      lSQLBuilder.SelectTables[liIndex]
      lSQLBuilder.SelectTables.Items[liIndex]

      </Code>

   Descendants include TdaSQLSelectTables.}

  {@TdaSQLSelectTables.Available
   Array propery that provides access to the list of tables that are avialable
   to the SQL.}

  {@TdaSQLSelectTables.AvailableCount
   Indicates the number of items in the Available array.}

  {@TdaSQLSelectTables.Items
   Default array propery. Provides access to the tables that have been added to
   the SQL.}

  {@TdaSQLSelectTables.Count
   Indicates the number of tables in the Items array.}

  TdaSQLTableList = class(TPersistent)
  protected
    function GetAvailable(Index: Integer): TdaTable; virtual; abstract;
    function GetAvailableCount: Integer; virtual; abstract;
    function GetSelected(Index: Integer): TdaTable; virtual; abstract;
    function GetCount: Integer; virtual; abstract;

  public
    constructor Create(aSQL: TdaSQL); virtual;

    class function IsNamedTable(aTable: TdaTable; const aNameOrAlias: String): Boolean;

    procedure Clear; virtual; abstract;

    function Exists(const aTableNameOrAlias: String): Boolean; virtual;
    function IndexOfAvailable(const aNameOrAlias: String): Integer; virtual;
    function IndexOf(const aNameOrAlias: String): Integer; virtual;

    function Add(const aNameOrAlias: String): TdaTable; overload; virtual;
    function Add(aAvailableIndex: Integer): TdaTable; overload; virtual; abstract;
    function Remove(const aNameOrAlias: String): TdaTable; overload; virtual;
    function Remove(aSelectedIndex: Integer): TdaTable; overload; virtual; abstract;

    property Available[Index: Integer]: TdaTable read GetAvailable;
    property AvailableCount: Integer read GetAvailableCount;
    property Items[Index: Integer]: TdaTable read GetSelected; default;
    property Count: Integer read GetCount;

  end;

  {@TdaSQLSelectTables

   Represents the list of tables that appear in the From clause of the SQL.
   Used by TdaSQLBuilder to add/remove tables and table joins to a TdaSQL object.

   The following example adds the customer table and an inner join on the orders
   table to the customer table. The tables are joined on the custno field from
   each table using the '=' operator.

    <Code>

     lSQLBuilder := TdaSQLBuilder.Create(Report.DataPipeline);

     lSQLBuilder.Clear;

     lSQLBuilder.SelectTables.Add('Customer');
     lSQLBuilder.SelectTables.AddJoin('Orders', 'Customer', 'CustNo', '=', 'CustNo');
     lSQLBuilder.SelectFields.AddAllFields;

     lSQLBuilder.ApplyUpdates;

     lSQLBuilder.Free;

    </Code>

   Use the Items[] array and Count properties to iterate through the selected tables.
   The Available[] array and AvailableCount properties provide a list of the available
   tables.

   There are number of methods that enable tables and table joins to be added
   and removed from the SQL. The Add and Remove methods are overloaded to accept
   an index, table name, or table alias. The methods related to adding joins
   will add the table to the from clause if it does not already exists and
   add join conditions.

     <Table>
     Method                  Use
     ------------------      -------------------------------
     Add                     add a table to the SQL
     AddJoin                 add an inner join to the SQL
     AddFullOuterJoin        add a full outer join to the SQL
     AddLeftOuterJoin        add a left outer join to the SQL
     AddRightOuterJoin       add a right outer join to the SQL
     Clear                   remove all tables from the SQL
     Remove                  remove a table and associated join conditions
     </Table>}


  TdaSQLSelectTables = class(TdaSQLTableList)
  private
    FSQL: TdaSQL;

  protected
    function AddTableJoin(const aNameOrAlias, aJoinToNameOrAliases: String; aJoinType: TdaJoinType; const aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases: String): Boolean; virtual;
    function GetAvailable(Index: Integer): TdaTable; override;
    function GetAvailableCount: Integer; override;
    function GetSelected(Index: Integer): TdaTable; override;
    function GetCount: Integer; override;

  public
    constructor Create(aSQL: TdaSQL); override;

    procedure Clear; override;

    function AddJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases:
        String): Boolean; overload; virtual;
    function AddFullOuterJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators,
        aJoinToFieldNamesOrAliases: String): Boolean; virtual;
    function AddLeftOuterJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators,
        aJoinToFieldNamesOrAliases: String): Boolean; virtual;
    function AddRightOuterJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators,
        aJoinToFieldNamesOrAliases: String): Boolean; virtual;

    function Add(aAvailableIndex: Integer): TdaTable; overload; override;
    function Remove(aSelectedIndex: Integer): TdaTable; overload; override;

  end;


  {@TdaSQLFieldList

   Abstract ancestor class. Provides properties and methods for managing a list
   of TdaField objects that are used to define a SQL query.

   The TdaSQLFieldList class defines an Available[] array that provides a list
   of fields that are available to be added to the SQL and an Items[] array that
   is defined as the default property and represents the list of fields that
   are included in the SQL.

   Descendants include TdaSQLSelectFields, TdaSQLGroupByFields, and TdaSQLOrderByFields.}

  {@TdaSQLFieldList.Available
   Array propery that provides access to the list of fields that are avialable
   to the SQL.}

  {@TdaSQLFieldList.AvailableCount
   Indicates the number of items in the Available array.}

  {@TdaSQLFieldList.Items
   Default array propery. Provides access to the fields that have been added to
   the SQL}

  {@TdaSQLFieldList.Count
   Indicates the number of fields in the Items array.}

  TdaSQLFieldList = class(TPersistent)
  private
    FSQL: TdaSQL;

  protected
    function GetAvailable(Index: Integer): TdaField; virtual; abstract;
    function GetAvailableCount: Integer; virtual; abstract;
    function GetSelected(Index: Integer): TdaField; virtual; abstract;
    function GetCount: Integer; virtual; abstract;

    property SQL: TdaSQL read FSQL;

  public
    constructor Create(aSQL: TdaSQL); virtual;
    class function IsNamedField(aField: TdaField; const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Boolean;

    procedure Clear; virtual; abstract;

    function Exists(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Boolean; virtual;
    function IndexOfAvailable(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Integer; virtual;
    function IndexOf(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Integer; virtual;

    function Add(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField; overload;  virtual;
    function Add(aAvailableIndex: Integer): TdaField; overload;  virtual; abstract;
    function Remove(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField; overload; virtual;
    function Remove(aSelectedIndex: Integer): TdaField; overload; virtual; abstract;

    property Available[Index: Integer]: TdaField read GetAvailable;
    property AvailableCount: Integer read GetAvailableCount;
    property Items[Index: Integer]: TdaField read GetSelected; default;
    property Count: Integer read GetCount;

  end;


  {@TdaSQLSelectFields

   Used to add/remove fields to the Select clause.
   Represents the list of fields that appear in the Select clause of the SQL.

   The following example adds the customer table and selects all fields.

    <Code>

     lSQLBuilder := TdaSQLBuilder.Create(Report.DataPipeline);

     lSQLBuilder.Clear;
     lSQLBuilder.SelectTables.Add('Customer');
     lSQLBuilder.SelectFields.AddAllFields;

     lSQLBuilder.ApplyUpdates;

     lSQLBuilder.Free;

    </Code>

   Use the Items[] array and Count properties to iterate through the
   selected fields. The Available[] array and AvailableCount properties provide
   a list of the available fields. The Available[] array is comprised of the
   fields from the tables that appear in the TdaSQLBuilder.SelectTables[] array.

   There are number of methods that enable Select fields to be added
   and removed from the SQL. The Add and Remove methods are overloaded to accept
   an index, field name, or field alias.

    <Table>
     Method                  Use
     ----------------        -------------------------------
     Add                     add a table to the SQL
     AddAllFields            add all fields to the SQL
     Clear                   remove all tables from the SQL
     Remove                  remove a table and associated join conditions
    </Table>}
    
  TdaSQLSelectFields = class(TdaSQLFieldList)
  protected
    function GetAvailable(Index: Integer): TdaField; override;
    function GetAvailableCount: Integer; override;
    function GetSelected(Index: Integer): TdaField; override;
    function GetCount: Integer; override;

  public
    procedure Clear; override;

    function AddAllFields: Boolean; overload; virtual;
    function AddAllFields(const aTableNameOrAlias: String): Boolean; overload; virtual;
    function Add(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField; overload;  override;
    function Add(aAvailableIndex: Integer): TdaField; overload;  override;
    function Remove(aSelectedIndex: Integer): TdaField; overload; override;

  end;

  {@TdaSQLCalcFields

   Used to add/remove calculated fields to the Select clause of the SQL.
   Represents the list of calc fields that appear in the Select clause of the SQL.

   The following example adds the orders table, a select field on custno,
   and a calc sum on AmountPaid. Note that adding a an aggregate calculation
   to the SQL will automatically cause the non-aggregate fields to be added
   to the GroupByFields list.

    <Code>

     lSQLBuilder := TdaSQLBuilder.Create(Report.DataPipeline);

     lSQLBuilder.Clear;
     lSQLBuilder.SelectTables.Add('Orders');
     lSQLBuilder.SelectFields.Add('CustNo');
     lSQLBuilder.CalcFields.AddSum('AmoundPaid');

     lSQLBuilder.ApplyUpdates;

     lSQLBuilder.Free;

    </Code>

   Use the Items[] array and Count properties to iterate through the
   calculated fields that are included in the SQL. The Available[] array and
   AvailableCount properties provide a list of the available fields.
   The Available[] array is comprised of the fields from the tables that appear
   in the TdaSQLBuilder.SelectTables[] array.

   There are number of methods that enable calculated fields to be added
   and removed from the SQL. The Remove method is overloaded to accept
   an index, field name, or field alias.

    <Table>
     Method                  Use
     -------------           --------------------------------
     AddAvg                  add an Average calculated field to the SQL
     AddCount                add a Count calculated field to the SQL
     AddMin                  add a Minumum calculated field to the SQL
     AddMax                  add a Minumum calculated field to the SQL
     AddSum                  add a Sum calculated field to the SQL
     AddExpression           add an Expression calculated field to the SQL
     Remove                  remove a calculated from the SQL
    </Table>}

  {@TdaSQLCalcFields.Available
   Array propery that provides access to the list of fields that are avialable
   to the SQL.}

  {@TdaSQLCalcFields.AvailableCount
   Indicates the number of items in the Available array.}

  {@TdaSQLCalcFields.Items
   Default array propery. Provides access to the calculated fields that have been
   added to the SQL}

  {@TdaSQLCalcFields.Count
   Indicates the number of calculated fields in the Items array.}

  TdaSQLCalcFields = class(TPersistent)
  private
    FSQL: TdaSQL;

  protected
    function GetAvailable(Index: Integer): TdaField; virtual;
    function GetAvailableCount: Integer; virtual;
    function GetSelected(Index: Integer): TdaCalculation; virtual;
    function GetCount: Integer; virtual;
    function Add(const aTableNameOrAlias: String; const aFieldNameOrAlias: String; aCalcType: TdaCalcType): TdaCalculation; overload;  virtual;
    function Add(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaCalculation; overload;  virtual;
    function Add(aAvailableIndex: Integer): TdaCalculation; overload;  virtual;

  public
    constructor Create(aSQL: TdaSQL); virtual;

    procedure Clear; virtual;

    function Exists(const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean; virtual;
    function IndexOfAvailable(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Integer; virtual;
    function IndexOf(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Integer; virtual;

    function AddAvg(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaCalculation; virtual;
    function AddCount: TdaCalculation; virtual;
    function AddMin(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaCalculation; virtual;
    function AddMax(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaCalculation; virtual;
    function AddSum(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaCalculation; virtual;
    function AddExpression(aFieldAlias: String; const aExpression: String): TdaCalculation; overload; virtual;
    function AddExpression(const aExpression: String): TdaCalculation; overload; virtual;
    function Remove(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField; overload; virtual;
    function Remove(aSelectedIndex: Integer): TdaField; overload; virtual;

    property Available[Index: Integer]: TdaField read GetAvailable;
    property AvailableCount: Integer read GetAvailableCount;
    property Items[Index: Integer]: TdaCalculation read GetSelected; default;
    property Count: Integer read GetCount;

  end;

  {@TdaSQLGroupByFields

   Used to add/remove Group By fields to the SQL.
   Represents the list of fields that appear in the Group By clause of the SQL.

   Group By fields are automatically added to the SQL whenever an aggregate
   calculated field is added to the SQL. For this reason, you will rarely need
   to add Group By fields to the SQL.

   Use the Items[] array and Count properties to iterate through the
   group by fields that are included in the SQL. The Available[] array and
   AvailableCount properties provide a list of the available fields.
   The Available[] array is comprised of the fields from the tables that appear
   in the TdaSQLBuilder.SelectTables[] array.

   The Add and Remove methods enable Group By fields to be added
   and removed from the SQL. The methods are overloaded to accept
   an index, field name, or field alias.}
   
  TdaSQLGroupByFields = class(TdaSQLFieldList)
  protected
    function GetAvailable(Index: Integer): TdaField; override;
    function GetAvailableCount: Integer; override;
    function GetSelected(Index: Integer): TdaField; override;
    function GetCount: Integer; override;

  public
    procedure Clear; override;

    function Add(aAvailableIndex: Integer): TdaField; overload;  override;
    function Remove(aSelectedIndex: Integer): TdaField; overload; override;

  end;

  {@TdaSQLOrderByFields

   Used to add/remove fields to the Order By clause of the SQL.
   Represents the list of fields that appear in the Order By clause of the SQL.

   The following example adds the customers table, selects all fields, and
   orders the data on the Company field.

    <Code>

     lSQLBuilder := TdaSQLBuilder.Create(Report.DataPipeline);

     lSQLBuilder.Clear;
     lSQLBuilder.SelectTables.Add('Customer');
     lSQLBuilder.SelectFields.AddAllFields;
     lSQLBuilder.OrderByFields.Add('Company');
     lSQLBuilder.ApplyUpdates;

     lSQLBuilder.Free;

    </Code>

   Use the Items[] array and Count properties to iterate through the
   Order By fields that are included in the SQL. The Available[] array and
   AvailableCount properties provide a list of the available fields.
   The Available[] array is comprised of the fields from the tables that appear
   in the TdaSQLBuilder.SelectTables[] array.

   The Add and Remove methods enable Order By fields to be added
   and removed from the SQL. The methods are overloaded to accept
   an index, field name, or field alias.}
  TdaSQLOrderByFields = class(TdaSQLFieldList)
  private
  protected
    function GetAvailable(Index: Integer): TdaField; override;
    function GetAvailableCount: Integer; override;
    function GetSelected(Index: Integer): TdaField; override;
    function GetCount: Integer; override;

  public
    procedure Clear; override;

    function Add(aAvailableIndex: Integer): TdaField; overload;  override;
    function AddDescending(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField; virtual;
    function Remove(aSelectedIndex: Integer): TdaField; overload; override;

  end;

  {@TdaSQLCriteriaList

   Used to add/remove search criteria to the Where clause of the SQL.
   Represents the list of search criteria that appear in the Where clause of
   the SQL.

   The following example adds the customers table, selects all fields, and
   adds an AutoSearch Criteria on the Company field to select Company's that
   begin with the letter 'S'

    <Code>

     lSQLBuilder := TdaSQLBuilder.Create(Report.DataPipeline);

     lSQLBuilder.Clear;
     lSQLBuilder.SelectTables.Add('Customer');
     lSQLBuilder.SelectFields.AddAllFields;
     lSQLBuilder.SearchCriteria.AddAutoSearch('Customer', 'Company', 'Like', 'S');
     lSQLBuilder.ApplyUpdates;

     lSQLBuilder.Free;

    </Code>

   Use the Items[] array and Count properties to iterate through the
   search criteria that are included in the SQL. The Available[] array and
   AvailableCount properties provide a list of the available fields.
   The Available[] array is comprised of the fields from the tables that appear
   in the TdaSQLBuilder.SelectTables[] array.

   There are number of methods that enable search criteria fields to be added
   and removed from the SQL. The Add and Remove methods are overloaded to accept
   an index, field name, or field alias.

     <Table>
     Method                  Use
     ---------------------   -------------------------------
     Add                     add search criteria to the SQL
     AddAutoSearch           add AutoSearch criteria to the SQL
     InsertOpenParentheses   insert an open parantheses '('
     InsertCloseParentheses  insert a close parantheses ')'
     InsertOr                insert an Or between search criteria
     InsertNot               insert a Not before search criteria
     Remove                  remove search criteria from the SQL
    </Table>}
   
  {@TdaSQLCriteriaList.Available
   Array propery that provides access to the list of fields that are available
   to the SQL.}

  {@TdaSQLCriteriaList.AvailableCount
   Indicates the number of items in the Available array.}

  {@TdaSQLCriteriaList.Items
   Default array propery. Provides access to the criteria that have been
   added to the SQL.}

  {@TdaSQLCriteriaList.Count
   Indicates the number of criteria in the Items array.}

  TdaSQLCriteriaList = class(TPersistent)
  private
    FSQL: TdaSQL;

  protected
    function Add(aAvailableIndex: Integer): TdaCriteria; overload; virtual;
    function Add(const aTableNameOrAlias, aFieldNameOrAlias: String; aOperator: TdaCriteriaOperatorType; aValue: String): TdaCriteria; overload;  virtual;
    function AddAutoSearch(const aTableNameOrAlias: String; const aFieldNameOrAlias: String; aOperator: TdaCriteriaOperatorType; aValue: String): TdaCriteria; overload; virtual;
    function GetAvailable(Index: Integer): TdaField; virtual;
    function GetAvailableCount: Integer; virtual;
    function GetSelected(Index: Integer): TdaCriteria; virtual;
    function GetCount: Integer; virtual;

  public
    constructor Create(aSQL: TdaSQL); virtual;

    class function GetTypeForOperator(aOperator: String): TdaCriteriaOperatorType;

    procedure Clear; virtual;

    function Exists(const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean; virtual;
    function IndexOfAvailable(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Integer; virtual;
    function IndexOf(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Integer; virtual;

    procedure Move(aCurrentIndex, aNewIndex: Integer); virtual;
    procedure AddParentheses; virtual;
    procedure InsertOpenParentheses(aPosition: Integer); virtual;
    procedure InsertCloseParentheses(aPosition: Integer); virtual;
    procedure InsertOr(aPosition: Integer); virtual;
    procedure InsertNot(aPosition: Integer); virtual;

    function Add(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aValue: String): TdaCriteria; overload; virtual;
    function AddAutoSearch(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aValue: String): TdaCriteria; overload;  virtual;
    function AddAutoSearchWithParam(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aParamName: String): TdaCriteria; overload; virtual;
    function AddParamSearch(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aParamName: String): TdaCriteria; overload; virtual;
    function Remove(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): Boolean; overload; virtual;
    function Remove(aSelectedIndex: Integer): Boolean; overload; virtual;

    property Available[Index: Integer]: TdaField read GetAvailable;
    property AvailableCount: Integer read GetAvailableCount;
    property Items[Index: Integer]: TdaCriteria read GetSelected; default;
    property Count: Integer read GetCount;

  end;


  {@TdaSQLGroupCriteriaList

   Used to add/remove group search criteria to the Having clause of the SQL.
   Represents the list of group search criteria that appear in the Having clause
   of the SQL.

   Group search criteria can be used to apply search conditions to aggregate
   (i.e. summary) calculations performed in the SQL Group By.

   Descends from TdaSQLCriteriaList and overrides methods to manage the list of
   available and selected items.

  }
  TdaSQLGroupCriteriaList = class(TdaSQLCriteriaList)
  private
    FSQL: TdaSQL;

  protected
    function Add(aAvailableIndex: Integer): TdaCriteria; override;
    function GetAvailable(Index: Integer): TdaField; override;
    function GetAvailableCount: Integer; override;
    function GetCount: Integer; override;
    function GetSelected(Index: Integer): TdaCriteria; override;

  public
    constructor Create(aSQL: TdaSQL); override;

    procedure Clear; override;

    function Remove(aSelectedIndex: Integer): Boolean; override;

  end;

  {TraTdaSQLBuilderRTTI}
  TraTdaSQLBuilderRTTI = class(TraTObjectRTTI)
  private
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;


  {TraTdaSQLTableListRTTI}
  TraTdaSQLTableListRTTI = class(TraTObjectRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;


  {TraTdaSQLSelectTablesRTTI}
  TraTdaSQLSelectTablesRTTI = class(TraTdaSQLTableListRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;


  {TraTdaSQLFieldListRTTI}
  TraTdaSQLFieldListRTTI = class(TraTObjectRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetPropValue(aObject:  TObject; const aPropName: String; var aValue): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;

  {TraTdaSQLSelectFieldsRTTI}
  TraTdaSQLSelectFieldsRTTI = class(TraTdaSQLFieldListRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;

  {TraTdaSQLOrderByFieldsRTTI}
  TraTdaSQLOrderByFieldsRTTI = class(TraTdaSQLFieldListRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;
  end;

  {TraTdaSQLCalcFieldsRTTI}
  TraTdaSQLCalcFieldsRTTI = class(TraTObjectRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetPropValue(aObject:  TObject; const aPropName: String; var aValue): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;

  {TraTdaSQLCriteriaListRTTI}
  TraTdaSQLCriteriaListRTTI = class(TraTObjectRTTI)
  public
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function  GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function  GetPropValue(aObject:  TObject; const aPropName: String; var aValue): Boolean; override;
    class function  GetParams(const aMethodName: String): TraParamList; override;
    class function  CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function  RefClass: TClass; override;

  end;

  {TraTdaSQLCriteriaListRTTI}
  TraTdaSQLGroupCriteriaListRTTI = class(TraTdaSQLCriteriaListRTTI)
  public
    class function  RefClass: TClass; override;
  end;

  {TraTdaSQLLinksRTTI}
  TraTdaSQLLinksRTTI = class(TraTObjectRTTI)
  public
    class function CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean; override;
    class function GetParams(const aMethodName: String): TraParamList; override;
    class procedure GetPropList(aClass: TClass; aPropList: TraPropList); override;
    class function GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean; override;
    class function GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean; override;
    class function RefClass: TClass; override;
  end;




implementation

const
  cSearchConditions: array[0..13] of String = ('=','<>','<','<=','>','>=','LIKE','NOT LIKE',
                                                    'BETWEEN','NOT BETWEEN','IN','NOT IN','IS NULL','IS NOT NULL');

  // this versions adds some variations to support IN LIST and IS BLANK which are closer to the
  // TppSearchOperatorType definitions
  cSearchConditions2: array[0..13] of String = ('=','<>','<','<=','>','>=','LIKE','NOT LIKE',
                                                    'BETWEEN','NOT BETWEEN','IN LIST','NOT IN LIST','IS BLANK','IS NOT BLANK');

{******************************************************************************
 *
 **  S Q L   B U I L D E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.Create(aSQL) }

constructor TdaSQLBuilder.Create(aSQL: TObject);
var
  lSQLClass: TdaSQLClass;
begin

  inherited Create;

  if not(aSQL is TdaSQL) then
    raise EDataError.Create(' TdaSQLBuilder.Create: aSQL must be of type TdaSQL'); 

  FDataSettings := TppDataSettings.Create(nil);

  FOriginalSQL := TdaSQL(aSQL);

  lSQLClass := TdaSQLClass(FOriginalSQL.ClassType);

  FSQL := lSQLClass.Create(nil);
  FSQL.Assign(FOriginalSQL);
  FSQL.Modified := False;
  FSQL.AllowSelfJoin := True;

  FSQL.ReportParameters := FOriginalSQL.ReportParameters;


  FSelectTables := TdaSQLSelectTables.Create(FSQL);
  FSelectFields := TdaSQLSelectFields.Create(FSQL);
  FCalcFields := TdaSQLCalcFields.Create(FSQL);
  FGroupByFields := TdaSQLGroupByFields.Create(FSQL);
  FSearchCriteria := TdaSQLCriteriaList.Create(FSQL);
  FGroupSearchCriteria := TdaSQLGroupCriteriaList.Create(FSQL);
  FOrderByFields := TdaSQLOrderByFields.Create(FSQL);
  FSQLLinks := TdaSQLLinks.Create(FSQL);


end;

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.Create(aReport) }

constructor TdaSQLBuilder.Create(aReport: TppCustomReport);
begin

  if (aReport = nil) then
    raise EDataError.Create('TdaSQLBuilder.Create: aReport is nil');

  if (aReport.DataPipeline = nil) then
    raise EDataError.Create('TdaSQLBuilder.Create: aReport.DataPipeline is nil');

  Create(aReport.DataPipeline);

end;


constructor TdaSQLBuilder.Create(aDataPipeline: TppDataPipeline);
begin

  if (aDataPipeline = nil) then
    raise EDataError.Create('TdaSQLBuilder.Create: aDataPipeline is nil');

  if (aDataPipeline.SQL = nil) then
    raise EDataError.Create('TdaSQLBuilder.Create: aDataPipeline.SQL is nil');

  Create(aDataPipeline.SQL);

end;


{------------------------------------------------------------------------------}
{ TdaSQLBuilder.Destroy }

destructor TdaSQLBuilder.Destroy;
begin

  if (FSQL <> nil) and (FSQL.Modified) then
    ApplyUpdates;

  FSelectTables.Free;
  FSelectFields.Free;
  FCalcFields.Free;
  FGroupByFields.Free;
  FSearchCriteria.Free;
  FOrderByFields.Free;
  FGroupSearchCriteria.Free;
  FDataSettings.Free;
  FSQLLinks.Free;

  FSQL.Free;

  inherited;

end;

{------------------------------------------------------------------------------}
{@TdaSQLBuilder.ApplyUpdates
  Applies the SQL updates to the associated QueryDataView. Call ApplyUpdates to
  ensure that the SQLUpdates are applied.

  If the SQLBuilder detects that the SQL has been updated, this method is called
  automatically when the TdaSQLBuilder instance is destroyed.}

procedure TdaSQLBuilder.ApplyUpdates;
begin

  // apply the modified sql to the QueryDataView (i.e. the Owner) by setting
  // using RTTI to set the QueryDataView.SQL property
  if (FOriginalSQL.Owner <> nil) and TraRTTI.IsValidPropName(FOriginalSQL.Owner, 'SQL') then
    TraRTTI.SetPropValue(FOriginalSQL.Owner, 'SQL', FSQL);

end;


{------------------------------------------------------------------------------}
{@TdaSQLBuilder.Clear
 Clears the SQL definition. Removes all SelectTables, SelectFields, etc.
 from the TdaSQL object.}

procedure TdaSQLBuilder.Clear;
begin
  FSQL.Clear;

end;

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.CreateLink }

procedure TdaSQLBuilder.CreateLink(aMasterPipeline: TppDataPipeline; aMasterFieldAlias, aDetailFieldAlias: String);
var
  lDetailField: TdaField;
  lMasterField: TdaField;
  lMasterSQL: TdaSQL;
begin

   lMasterSQL := aMasterPipeline.SQL as TdaSQL;

  if (lMasterSQL = nil) then
    raise EDataError.Create('TdaSQLBuilder.CreateLink: MasterPipeline.SQL is nil');

  lMasterField := lMasterSQL.GetFieldForAlias(aMasterFieldAlias);

  if (lMasterField = nil) then
    raise EDataError.Create('TdaSQLBuilder.CreateLink: master field not found: ' + aMasterFieldAlias);

  lDetailField := FSQL.GetFieldForAlias(aDetailFieldAlias);

  if (lDetailField = nil) then
    raise EDataError.Create('TdaSQLBuilder.CreateLink: detail field not found: ' + aDetailFieldAlias);

  FSQL.MasterSQL := lMasterSQL; 
  FSQL.CreateLink(lMasterField, lDetailField);

end; {procedure, CreateLink}


{------------------------------------------------------------------------------}
{ TdaSQLBuilder.GetDataSettings }

function TdaSQLBuilder.GetDataSettings: TppDataSettings;
begin
  FDataSettings.CollationType := FSQL.CollationType;
  FDataSettings.GuidCollationType := FSQL.GuidCollationType;
  FDataSettings.NullCollationType := FSQL.NullCollationType;
  FDataSettings.DatabaseType := FSQL.DatabaseType;
  FDataSettings.SQLType := FSQL.SQLType;
  FDataSettings.DataDictionary := FSQL.DataDictionary;
  FDataSettings.IsCaseSensitive := FSQL.IsCaseSensitive;

  Result := FDataSettings;

end;

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.GetDistinct }

function TdaSQLBuilder.GetDistinct: Boolean;
begin
  Result := FSQL.Distinct;
end;

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.GetSQL }

function TdaSQLBuilder.GetSQL: TdaSQL;
begin
  Result := FSQL;

end;

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.SetDataSettings }

procedure TdaSQLBuilder.SetDataSettings(aDataSettings: TppDataSettings);
begin
  FDataSettings.Assign(aDataSettings);

  FSQL.CollationType := FDataSettings.CollationType;
  FSQL.GuidCollationType := FDataSettings.GuidCollationType;
  FSQL.NullCollationType := FDataSettings.NullCollationType;
  FSQL.DatabaseType := FDataSettings.DatabaseType;
  FSQL.SQLType := FDataSettings.SQLType;
  FSQL.DataDictionary := FDataSettings.DataDictionary;
  FSQL.IsCaseSensitive := FDataSettings.IsCaseSensitive;

end;

{------------------------------------------------------------------------------}
{ TdaSQLBuilder.SetDistinct }

procedure TdaSQLBuilder.SetDistinct(const Value: Boolean);
begin
  FSQL.Distinct := Value;
end;

{******************************************************************************
 *
 **  T A B L E   L IS T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLTableList.Create }

constructor TdaSQLTableList.Create(aSQL: TdaSQL);
begin

end;

{------------------------------------------------------------------------------}
{ TdaSQLTableList.Add}

function TdaSQLTableList.Add(const aNameOrAlias: String): TdaTable;
var
  liIndex: Integer;
begin
  liIndex := IndexOfAvailable(aNameOrAlias);

  if (liIndex >= 0) then
    Result := Add(liIndex)
  else
    Result := nil;

end;


{------------------------------------------------------------------------------}
{@TdaSQLTableList.Exists
  Indicates whether a table with a specified name or alias exists in the
  Items array.}

function TdaSQLTableList.Exists(const aTableNameOrAlias: String): Boolean;
begin
  Result := IndexOf(aTableNameOrAlias) >= 0;

end;


{------------------------------------------------------------------------------}
{@TdaSQLTableList.IndexOfAvailable
  Returns the position of a specified table in the Available[] array. A value
  of -1 is returned if no table exists.}

function TdaSQLTableList.IndexOfAvailable(const aNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;
  
  while not(lbFound) and (liIndex < AvailableCount) do
    begin
      lbFound := IsNamedTable(Available[liIndex], aNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);
    end;
  
  if lbFound then
    Result := liIndex;

end;

{------------------------------------------------------------------------------}
{@TdaSQLTableList.IndexOf
  Returns the position of a specified table in the Items[] array. A value
  of -1 is returned if no entry exists.}

function TdaSQLTableList.IndexOf(const aNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin
  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;
  
  while not(lbFound) and (liIndex < Count) do
    begin
      lbFound := IsNamedTable(Items[liIndex], aNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);
    end;
  
  if lbFound then
    Result := liIndex;

end;

{------------------------------------------------------------------------------}
{@TdaSQLTableList.IsNamedTable
  Indicates whether a table matches a specified Name or Alias. Performs a
  non case-sensitive comparison of the specified aNameorAlias parameter value
  against the following TdaTable properties: TableName, TableAlias, SQLAlias and
  RawTableName.}

class function TdaSQLTableList.IsNamedTable(aTable: TdaTable; const aNameOrAlias: String): Boolean;
begin
  Result := (CompareText(aTable.TableAlias, aNameOrAlias) = 0) or
            (CompareText(aTable.SQLAlias, aNameOrAlias) = 0) or
            (CompareText(aTable.RawTableName, aNameOrAlias) = 0) or
            (CompareText(aTable.TableName, aNameOrAlias) = 0);

end;

{------------------------------------------------------------------------------}
{ TdaSQLTableList.Remove }

function TdaSQLTableList.Remove(const aNameOrAlias: String): TdaTable;
var
  liIndex: Integer;
begin
  liIndex := IndexOf(aNameOrAlias);

  if (liIndex >= 0) then
    Result := Remove(liIndex)
  else
    Result := nil;

end;


{******************************************************************************
 *
 ** S E L E C T   T A B L E   L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLSelectTables.Create }

constructor TdaSQLSelectTables.Create(aSQL: TdaSQL);
begin
  inherited;

  FSQL := aSQL;

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.AddJoin
  Adds a table and an inner join to an existing table.

  The following example adds the orders table to the SQL and an inner join to
  the customer table on the custno field.

  example:

    mySQLBuilder.SelectTables.AddJoin('orders', 'customer', 'custno', '=', 'custno');

    <Table>
     Parameter                    Meaning
     -------------------------   -------------------------
     aNameOrAlias                name or alias of the table to be added
     aJoinToNameOrAliases        existing table to be joined to or a oomma delimited list of table names or aliases
     aFieldNamesOrAliases        comma delimted list of field names or aliases
     aOperators                  comma delimited list of relational operators
     aJoinToFieldNamesOrAliases  comma delimted list of fields to be joined to
    </Table>

}

function TdaSQLSelectTables.AddJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases: String): Boolean;
begin
  Result := AddTableJoin(aNameOrAlias, aJoinToNameOrAliases, dajtInner, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases);

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.AddFullOuterJoin
  Adds a table and a full outer join to an existing table.

  See the AddJoin method for more information.}

function TdaSQLSelectTables.AddFullOuterJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases: String): Boolean;
begin
  Result := AddTableJoin(aNameOrAlias, aJoinToNameOrAliases, dajtOuter, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases);

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.AddLeftOuterJoin
  Adds a table and a left outer join to an existing table.

  See the AddJoin method for more information.}

function TdaSQLSelectTables.AddLeftOuterJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases: String): Boolean;
begin
  Result := AddTableJoin(aNameOrAlias, aJoinToNameOrAliases, dajtLeftOuter, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases);

end;


{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.AddRightOuterJoin
  Adds a table and a right outer join to an existing table.

  See the AddJoin method for more information.}

function TdaSQLSelectTables.AddRightOuterJoin(const aNameOrAlias, aJoinToNameOrAliases, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases: String): Boolean;
begin
  Result := AddTableJoin(aNameOrAlias, aJoinToNameOrAliases, dajtRightOuter, aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases);

end;


{------------------------------------------------------------------------------}
{ TdaSQLSelectTables.AddTableJoin }

function TdaSQLSelectTables.AddTableJoin(const aNameOrAlias, aJoinToNameOrAliases: String; aJoinType: TdaJoinType; const aFieldNamesOrAliases, aOperators, aJoinToFieldNamesOrAliases: String): Boolean;
var
  liIndex: Integer;
  liLocalField: Integer;
  liForeignField: Integer;
  liTable2: Integer;
  lTable1: TdaTable;
  lTable2: TdaTable;
  lJoinToTableNames: TStrings;
  lFieldNames1: TStrings;
  lFieldNames2: TStrings;
  lsLocalFieldName: String;
  lsForeignFieldName: String;
  lOperators: TStrings;
  lJoinOperator: TdaJoinOperatorType;
  lSelectFields: TdaSQLSelectFields;
  lLocalField: TdaField;
  lForeignField: TdaField;
  lsJoinToTableName: string;
  liTable1: Integer;
  lsOperator: String;
begin

  Result := False;

  if (IndexOfAvailable(aNameOrAlias) < 0) then Exit;

  {parse the parameter strings}
  lJoinToTableNames := TStringList.Create;
  ppParseString(aJoinToNameOrAliases, lJoinToTableNames);

  lFieldNames1 := TStringList.Create;
  ppParseString(aFieldNamesOrAliases, lFieldNames1);

  lFieldNames2 := TStringList.Create;
  ppParseString(aJoinToFieldNamesOrAliases, lFieldNames2);

  lOperators := TStringList.Create;
  ppParseString(aOperators, lOperators);

  // add table 1
  liTable1 := IndexOf(aNameOrAlias);

  if liTable1 >= 0 then
    lTable1 := Items[liTable1] // use existing select table
  else
    lTable1 := Add(aNameOrAlias); // add table to select

  lTable1.JoinType := aJoinType;

  {add the join fields}
  lSelectFields := TdaSQLSelectFields.Create(FSQL);

  for liIndex := 0 to lFieldNames1.Count - 1 do
    begin
      lLocalField := nil;
      lForeignField := nil;

      if (liIndex < lJoinToTableNames.Count) then
        lsJoinToTableName := Trim(lJoinToTableNames[liIndex])
      else if (lJoinToTableNames.Count = 1) then
        lsJoinToTableName := Trim(lJoinToTableNames[0]) // use same table for all fields
      else
        Continue; // no table specified

      lsLocalFieldName :=  Trim(lFieldNames1[liIndex]);
      lsForeignFieldName :=  Trim(lFieldNames2[liIndex]);

      if (liIndex < lOperators.Count) then
        lsOperator := Trim(lOperators[liIndex])
      else if (lJoinToTableNames.Count = 1) then
        lsOperator := Trim(lOperators[0]) // use same operator for all
      else
        Continue; // no operator specified

      liTable2 := IndexOf(lsJoinToTableName);

      if liTable2 >= 0 then
        lTable2 := Items[liTable2] // use existing select table
      else
        lTable2 := Add(lsJoinToTableName); // add table to select

      if (lTable2 = nil) then Continue;

      liLocalField := lSelectFields.IndexOf(lTable1.TableName, lsLocalFieldName);

      if (liLocalField >= 0) then
        lLocalField := lSelectFields[liLocalField]
      else
        begin
          liLocalField := lSelectFields.IndexOfAvailable(lTable1.TableName, lsLocalFieldName);
          if (liLocalField >= 0) then
            lLocalField := lSelectFields.Available[liLocalField];
        end;

      liForeignField := lSelectFields.IndexOf(lTable2.TableName, lsForeignFieldName);

      if (liForeignField >= 0) then
        lForeignField := lSelectFields[liForeignField]
      else
        begin
          liForeignField := lSelectFields.IndexOfAvailable(lTable2.TableName, lsForeignFieldName);
          if (liForeignField >= 0) then
            lForeignField := lSelectFields.Available[liForeignField];
        end;

      if (lLocalField <> nil) and (lForeignField <> nil) then
        begin
          lJoinOperator := daStringToJoinOperator(lsOperator);
          lTable1.AddTableJoin(lTable2, lForeignField.FieldName, lLocalField.FieldName,  lJoinOperator);

        end
      else if (lLocalField <> nil) and (lForeignField = nil) then
        begin
          lJoinOperator := daStringToJoinOperator(lsOperator);
          lTable1.AddTableJoin(lTable2, lsForeignFieldName, lLocalField.FieldName,  lJoinOperator);

        end



    end;

  lJoinToTableNames.Free;
  lFieldNames1.Free;
  lFieldNames2.Free;
  lOperators.Free;
  lSelectFields.Free;

  Result := True;

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.Add
  Adds a specified table to the Select Tables array.

  Add is overloaded to accept a table index, table name, or table alias.

  Call this method to add the first table to the SQL, thereafter use the
  AddJoin method.}

function TdaSQLSelectTables.Add(aAvailableIndex: Integer): TdaTable;
begin
  Result := FSQL.SelectTableOnly(aAvailableIndex);

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.Clear
 Removes all tables from the Items array.}

procedure TdaSQLSelectTables.Clear;
begin
  inherited;

  FSQL.ClearSelectTables;

end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectTables.GetAvailable }

function TdaSQLSelectTables.GetAvailable(Index: Integer): TdaTable;
begin
  Result := FSQL.AvailableSelectTables[Index];
end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectTables.GetAvailableCount }

function TdaSQLSelectTables.GetAvailableCount: Integer;
begin
  Result := FSQL.AvailableSelectTableCount;
end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectTables.GetSelected }

function TdaSQLSelectTables.GetSelected(Index: Integer): TdaTable;
begin
  Result := FSQL.SelectTables[Index];
end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectTables.GetCount }

function TdaSQLSelectTables.GetCount: Integer;
begin
  Result := FSQL.SelectTableCount;

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectTables.Remove

  Remove a specified table from the Items array.

  Remove is overloaded to accept either a table index, table name or table alias.}

function TdaSQLSelectTables.Remove(aSelectedIndex: Integer): TdaTable;
begin
  Result := FSQL.DeselectTable(aSelectedIndex);

end;

{******************************************************************************
 *
 ** F I E L D    L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLFieldList.Create }

constructor TdaSQLFieldList.Create(aSQL: TdaSQL);
begin
  FSQL := aSQL;
  
end;

{------------------------------------------------------------------------------}
{ TdaSQLFieldList.IsNamedField }

class function TdaSQLFieldList.IsNamedField(aField: TdaField; const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean;
var
  lbIsFieldName: Boolean;
begin

  Result := False;

  if (aField = nil) then Exit;  

  // check field name & alias
  lbIsFieldName := (CompareText(aField.FieldName, aFieldNameOrAlias) = 0) or
                   (CompareText(aField.FieldAlias, aFieldNameOrAlias) = 0) or
                   (CompareText(Trim(aField.Description), aFieldNameOrAlias) = 0) or
                   (CompareText(aField.SQLFieldName, aFieldNameOrAlias) = 0);

  // check table name & alias
  if lbIsFieldName then
    Result := (CompareText(aField.TableName, aTableNameOrAlias) = 0) or
              (CompareText(aField.TableAlias, aTableNameOrAlias) = 0) or
              (CompareText(aField.TableSQLAlias, aTableNameOrAlias) = 0);

end;

{------------------------------------------------------------------------------}
{ TdaSQLFieldList.Add }

function TdaSQLFieldList.Add(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaField;
var
  liIndex: Integer;
begin

  liIndex := IndexOfAvailable(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    Result := Add(liIndex)
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{@TdaSQLFieldList.Exists
 Returns True if the specified field exists in the Items array.}

function TdaSQLFieldList.Exists(const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean;
begin
  Result := (IndexOf(aTableNameOrAlias, aFieldNameOrAlias) >= 0);

end;

{------------------------------------------------------------------------------}
{@TdaSQLFieldList.IndexOfAvailable
 Returns the position the specified field in the Available[] array. If the field
 is not present, a -1 is returned.}

function TdaSQLFieldList.IndexOfAvailable(const aTableNameOrAlias, aFieldNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < AvailableCount) do
    begin
      lbFound := IsNamedField(Available[liIndex], aTableNameOrAlias, aFieldNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);
        
    end;

  if lbFound then
    Result := liIndex;


end;

{------------------------------------------------------------------------------}
{@TdaSQLFieldList.IndexOf
 Returns the position the specified field in the Items[] array. If the field
 is not present, a -1 is returned.}

function TdaSQLFieldList.IndexOf(const aTableNameOrAlias,aFieldNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;
  
  while not(lbFound) and (liIndex < Count) do
    begin
      lbFound := IsNamedField(Items[liIndex], aTableNameOrAlias, aFieldNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);
        
    end;

  if lbFound then
    Result := liIndex;

end;

{------------------------------------------------------------------------------}
{@TdaSQLFieldList.Remove
  Removes the specified field from the Items[] array.}

function TdaSQLFieldList.Remove(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaField;
var
  liIndex: Integer;
begin
  liIndex := IndexOf(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    Result := Remove(liIndex)
  else
    Result := nil;


end;

{******************************************************************************
 *
 ** S E L E C T   F I E L D S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{@TdaSQLFieldList.AddAllFields
 Clears the Items array and then adds all fields from all currently selected
 tables to the Items array.

 Overloaded. If the aTableNameOrAlias parameter is specified, only the fields
 for the specified table are added.}
  
function TdaSQLSelectFields.AddAllFields: Boolean;
var
  lTableList: TdaSQLSelectTables;
  liIndex: Integer;
begin

  Clear;

  lTableList := TdaSQLSelectTables.Create(SQL);

  try
    for liIndex := 0 to lTableList.Count-1 do
      AddAllFields(lTableList[liIndex].TableName);

  finally
    lTableList.Free;

  end;

  Result := Count > 0;


end;

function TdaSQLSelectFields.AddAllFields(const aTableNameOrAlias: String): Boolean;
var
  lTableList: TdaSQLSelectTables;
  liIndex: Integer;
begin

  lTableList := TdaSQLSelectTables.Create(SQL);

  try
    liIndex := lTableList.IndexOf(aTableNameOrAlias);

    if (liIndex >= 0) then
      SQL.AddSelectField(lTableList[liIndex], '*');

  finally
    lTableList.Free;

  end;

  Result := liIndex >= 0;


end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectFields.Add
  Adds a specified field to the Items array.

  Overloaded. Accepts either an Index or a table and field name or alias.}

function TdaSQLSelectFields.Add(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField;
begin

  Result := nil;

  if (aFieldNameOrAlias = '*') then
    AddAllFields(aTableNameOrAlias)
  else
    Result := inherited Add(aTableNameOrAlias, aFieldNameOrAlias);

end;

function TdaSQLSelectFields.Add(aAvailableIndex: Integer): TdaField;
begin
  Result := SQL.SelectField(aAvailableIndex);

end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectFields.Clear
 Removes all fields from the Items array.}

procedure TdaSQLSelectFields.Clear;
begin
  SQL.ClearSelectFields;

end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectFields.GetAvailable }

function TdaSQLSelectFields.GetAvailable(Index: Integer): TdaField;
begin
  Result := SQL.AvailableSelectFields[Index];
end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectFields.GetAvailableCount }

function TdaSQLSelectFields.GetAvailableCount: Integer;
begin
  Result := SQL.AvailableSelectFieldCount;
end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectFields.GetSelected }

function TdaSQLSelectFields.GetSelected(Index: Integer): TdaField;
begin
  Result := SQL.SelectFields[Index];
end;

{------------------------------------------------------------------------------}
{ TdaSQLSelectFields.GetCount }

function TdaSQLSelectFields.GetCount: Integer;
begin
  Result := SQL.SelectFieldCount;
end;

{------------------------------------------------------------------------------}
{@TdaSQLSelectFields.Remove
  Removes a specified field from the Items array.

  Overloaded. Accepts either an Index or a table and field name or alias.}

function TdaSQLSelectFields.Remove(aSelectedIndex: Integer): TdaField;
begin
  Result := SQL.DeselectField(aSelectedIndex);

end;


{******************************************************************************
 *
 ** C A L C   F I E L D S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.Create }

constructor TdaSQLCalcFields.Create(aSQL: TdaSQL);
begin
  FSQL := aSQL;

end;

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.Add }

function TdaSQLCalcFields.Add(const aTableNameOrAlias, aFieldNameOrAlias: String; aCalcType: TdaCalcType): TdaCalculation;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias);

  if (Result <> nil) then
    Result.CalcType := aCalcType;

end;


{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.Add }

function TdaSQLCalcFields.Add(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaCalculation;
var
  liIndex: Integer;
begin
  liIndex := IndexOfAvailable(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    Result := Add(liIndex)
  else
    Result := nil;


end;

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.Add }

function TdaSQLCalcFields.Add(aAvailableIndex: Integer): TdaCalculation;
begin
  Result := TdaCalculation(FSQL.SelectCalcField(aAvailableIndex));

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddAvg
 Adds an Avg calculated field to the Items[] array. }

function TdaSQLCalcFields.AddAvg(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaCalculation;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, dacaAvg);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddCount
  Adds a Count(*) calculated field to the Items[] array. }

function TdaSQLCalcFields.AddCount: TdaCalculation;
begin
  Result := Add(0);

  if (Result <> nil) then
    Result.CalcType := dacaCount;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddExpression
  Adds an expression calc field to the Items[] array and assign it the specified
  field alias. }

function TdaSQLCalcFields.AddExpression(aFieldAlias: String; const aExpression: String): TdaCalculation;
begin

  Result := AddExpression(aExpression);
  Result.FieldAlias := aFieldAlias;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddExpression
  Adds an expression calc field to the Items[] array. }

function TdaSQLCalcFields.AddExpression(const aExpression: String):
    TdaCalculation;
begin

  Result := Add(0);

  if (Result <> nil) then
    begin
      Result.CalcType := dacaExpression;
      Result.Expression := aExpression;
    end;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddMax
  Adds a Max calculated field to the Items[] array. }

function TdaSQLCalcFields.AddMax(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaCalculation;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, dacaMax);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddMin
  Adds a Min calculated field to the Items[] array. }

function TdaSQLCalcFields.AddMin(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaCalculation;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, dacaMin);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.AddSum
  Adds a Sum calculated field to the Items[] array. }

function TdaSQLCalcFields.AddSum(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaCalculation;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, dacaSum);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.Clear
 Removes all calculated fields from the Items[] array.}

procedure TdaSQLCalcFields.Clear;
begin
  FSQL.ClearCalcFields;

end;

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.GetAvailable }

function TdaSQLCalcFields.GetAvailable(Index: Integer): TdaField;
begin
  Result := FSQL.AvailableCalcFields[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.GetAvailableCount }

function TdaSQLCalcFields.GetAvailableCount: Integer;
begin
  Result := FSQL.AvailableCalcFieldCount;

end;

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.GetSelected }

function TdaSQLCalcFields.GetSelected(Index: Integer): TdaCalculation;
begin
  Result := FSQL.CalcFields[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLCalcFields.GetCount }

function TdaSQLCalcFields.GetCount: Integer;
begin
  Result := FSQL.CalcFieldCount;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.Exists
  Returns True if a specified field exists in the Items[] array.}

function TdaSQLCalcFields.Exists(const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean;
begin
  Result := (IndexOf(aTableNameOrAlias, aFieldNameOrAlias) >= 0);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.IndexOfAvailable
 Returns the position of the specified field in the Available[] array. A value of
 -1 is returned if no field can found.}

function TdaSQLCalcFields.IndexOfAvailable(const aTableNameOrAlias, aFieldNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < FSQL.AvailableCalcFieldCount) do
    begin
      lbFound := TdaSQLFieldList.IsNamedField(FSQL.AvailableCalcFields[liIndex], aTableNameOrAlias, aFieldNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex;


end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.IndexOf 
 Returns the position of the specified field in the Items[] array. A value of
 -1 is returned if no field can found.}

function TdaSQLCalcFields.IndexOf(const aTableNameOrAlias, aFieldNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;
  
  while not(lbFound) and (liIndex < FSQL.CalcFieldCount) do
    begin
      lbFound := TdaSQLFieldList.IsNamedField(FSQL.CalcFields[liIndex], aTableNameOrAlias, aFieldNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex;


end;

{------------------------------------------------------------------------------}
{@TdaSQLCalcFields.Remove
 Removes a specified calc field from the Items[] array.

 Overloaded. Accepts either an Index or a table and field name/alias}

function TdaSQLCalcFields.Remove(aSelectedIndex: Integer): TdaField;
begin
  Result := FSQL.DeselectCalcField(aSelectedIndex);

end;


function TdaSQLCalcFields.Remove(const aTableNameOrAlias, aFieldNameOrAlias: String): TdaField;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    Result := Remove(liIndex)
  else
    Result := nil;

end;

{******************************************************************************
 *
 ** G R O U P  B Y  F I E L D S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{@TdaSQLGroupByFields.Add
 Adds a specified Group By field to the Items[] array.

 Overloaded. Accepts either an Available[] array Index or a table and field name/alias  }

function TdaSQLGroupByFields.Add(aAvailableIndex: Integer): TdaField;
begin
  Result := SQL.SelectGroupByField(aAvailableIndex);

end;

{------------------------------------------------------------------------------}
{@TdaSQLGroupByFields.Clear
 Removes all Group By fields from the Items[] array.}

procedure TdaSQLGroupByFields.Clear;
begin
  SQL.ClearGroupByFields;

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupByFields.GetAvailable }

function TdaSQLGroupByFields.GetAvailable(Index: Integer): TdaField;
begin
  Result := SQL.AvailableGroupByFields[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupByFields.GetAvailableCount }

function TdaSQLGroupByFields.GetAvailableCount: Integer;
begin
  Result := SQL.AvailableGroupByFieldCount;

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupByFields.GetSelected }

function TdaSQLGroupByFields.GetSelected(Index: Integer): TdaField;
begin
  Result := SQL.GroupByFields[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupByFields.GetCount }

function TdaSQLGroupByFields.GetCount: Integer;
begin
  Result := SQL.GroupByFieldCount;

end;

{------------------------------------------------------------------------------}
{@TdaSQLGroupByFields.Remove
 Removes a specified Group By field from the Items[] array.

 Overloaded. Accepts either an Index or a table and field name/alias}

function TdaSQLGroupByFields.Remove(aSelectedIndex: Integer): TdaField;
begin
  Result := SQL.DeselectGroupByField(aSelectedIndex);

end;

{******************************************************************************
 *
 ** O R D E R   B Y  F I E L D S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{@TdaSQLOrderByFields.AddDescending
 Adds a specified field to the Order By array and sets the TdaField.Ascending
 property to False.}

function TdaSQLOrderByFields.AddDescending(const aTableNameOrAlias: String; const aFieldNameOrAlias: String): TdaField;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias);

  if (Result <> nil) then
    Result.Ascending := False;

end;

{------------------------------------------------------------------------------}
{@TdaSQLOrderByFields.Add
 Adds a specified field to the Order By array.

 Overloaded. Accepts an Available Index or a table and field name/alias.}

function TdaSQLOrderByFields.Add(aAvailableIndex: Integer): TdaField;
begin
  Result := SQL.SelectOrderByField(aAvailableIndex);

end;

{------------------------------------------------------------------------------}
{@TdaSQLOrderByFields.Clear
  Removes all items from the Order By array.}

procedure TdaSQLOrderByFields.Clear;
begin
  SQL.ClearOrderByFields;

end;

{------------------------------------------------------------------------------}
{ TdaSQLOrderByFields.GetAvailable }

function TdaSQLOrderByFields.GetAvailable(Index: Integer): TdaField;
begin
  Result := SQL.AvailableOrderByFields[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLOrderByFields.GetAvailableCount }

function TdaSQLOrderByFields.GetAvailableCount: Integer;
begin
  Result := SQL.AvailableOrderByFieldCount;

end;

{------------------------------------------------------------------------------}
{ TdaSQLOrderByFields.GetSelected }

function TdaSQLOrderByFields.GetSelected(Index: Integer): TdaField;
begin
  Result := SQL.OrderByFields[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLOrderByFields.GetCount }

function TdaSQLOrderByFields.GetCount: Integer;
begin
  Result := SQL.OrderByFieldCount;

end;

{------------------------------------------------------------------------------}
{@TdaSQLOrderByFields.Remove
 Removes a specified item from the Order By array.
 
 Overloaded. Accepts either an Index or a table and field name/alias}

function TdaSQLOrderByFields.Remove(aSelectedIndex: Integer): TdaField;
begin
  Result := SQL.DeselectOrderByField(aSelectedIndex);

end;

{******************************************************************************
 *
 ** S E A R C H   C R I T E R I A
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLCriteriaList.Create }

constructor TdaSQLCriteriaList.Create(aSQL: TdaSQL);
begin
  FSQL := aSQL;
end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.Add
 Adds a new Criteria to the Items[] array.

 Example:

 <Code>

   mySQLBuilder.SearchCriteria.Add('Customer', 'Company', 'Like', 'S');

 </Code>}

function TdaSQLCriteriaList.Add(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aValue: String): TdaCriteria;
var
  liIndex: Integer;
begin

  liIndex := IndexOfAvailable(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    begin
      Result := Add(liIndex);
      Result.Operator := GetTypeForOperator(aOperator);
      Result.Value := aValue;
    end
  else
    Result := nil;

end;


function TdaSQLCriteriaList.Add(const aTableNameOrAlias, aFieldNameOrAlias: String; aOperator: TdaCriteriaOperatorType; aValue: String): TdaCriteria;
var
  liIndex: Integer;
begin

  liIndex := IndexOfAvailable(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    begin
      Result := Add(liIndex);
      Result.Operator := aOperator;
      Result.Value := aValue;
    end
  else
    Result := nil;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.AddAutoSearch 
 Adds a new AutoSearch Criteria to the Items[] array.

 Example:

  <Code>

   mySQLBuilder.SearchCriteria.AddAutoSearch('Customer', 'Company', 'Like', 'S');

 
  </Code>}

function TdaSQLCriteriaList.AddAutoSearch(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aValue: String): TdaCriteria;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, aOperator, aValue);
  if Result <> nil then
    Result.AutoSearch := True;

end;


function TdaSQLCriteriaList.AddAutoSearch(const aTableNameOrAlias, aFieldNameOrAlias: String; aOperator: TdaCriteriaOperatorType; aValue: String): TdaCriteria;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, aOperator, aValue);
  if Result <> nil then
    Result.AutoSearch := True;

end;


{------------------------------------------------------------------------------}
{ TdaSQLCriteriaList.Add }

function TdaSQLCriteriaList.Add(aAvailableIndex: Integer): TdaCriteria;
begin
  Result := FSQL.SelectCriteria(aAvailableIndex);
end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.AddAutoSearchWithParam
 Adds a new AutoSearch Criteria to the Items[] array. Initializes the
 TdaCriteria.ParamName property to aParamName. This will bind the search
 criteria item to the Report.Parameters[ ] with the corresponding name.

 Example:

  <Code>

   mySQLBuilder.SearchCriteria.AddAutoSearchWithParam('Customer', 'Company', 'Like', 'Company');

 
  </Code>}

function TdaSQLCriteriaList.AddAutoSearchWithParam(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aParamName: String): TdaCriteria;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, aOperator, '');
  if Result <> nil then
    begin
      Result.AutoSearch := True;
      Result.ParamName := aParamName;
    end;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.AddParamSearch
 Adds a Parameterized Search Criteria to the Items[] array. Initializes the
 TdaCriteria.ParamName property to aParamName. This will bind the search
 criteria item to the Report.Parameters[ ] with the corresponding name.

 Example:

  <Code>

   mySQLBuilder.SearchCriteria.AddParamSearch('Customer', 'Company', 'Like', 'Company');

  </Code>}

function TdaSQLCriteriaList.AddParamSearch(const aTableNameOrAlias, aFieldNameOrAlias, aOperator, aParamName: String): TdaCriteria;
begin
  Result := Add(aTableNameOrAlias, aFieldNameOrAlias, aOperator, '');
  if Result <> nil then
    Result.ParamName := aParamName;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.Clear
 Removes all Criteria from the Items[] array.}

procedure TdaSQLCriteriaList.Clear;
begin
  FSQL.ClearCriteria;
end;

{------------------------------------------------------------------------------}
{ TdaSQLCriteriaList.GetAvailable }

function TdaSQLCriteriaList.GetAvailable(Index: Integer): TdaField;
begin
  Result := FSQL.AvailableCriteria[Index];
end;

{------------------------------------------------------------------------------}
{ TdaSQLCriteriaList.GetAvailableCount }

function TdaSQLCriteriaList.GetAvailableCount: Integer;
begin
  Result := FSQL.AvailableCriteriaCount;
end;

{------------------------------------------------------------------------------}
{ TdaSQLCriteriaList.GetSelected }

function TdaSQLCriteriaList.GetSelected(Index: Integer): TdaCriteria;
begin
  Result := FSQL.Criteria[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLCriteriaList.GetCount }

function TdaSQLCriteriaList.GetCount: Integer;
begin
  Result := FSQL.CriteriaCount;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.Exists
 Returns True if a Criteria has been added corresponding to the specified
 data field.}

function TdaSQLCriteriaList.Exists(const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean;
begin
  Result := (IndexOf(aTableNameOrAlias, aFieldNameOrAlias) >= 0);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.IndexOfAvailable
 Returns the position of the specified data field in the Available[] array.}

function TdaSQLCriteriaList.IndexOfAvailable(const aTableNameOrAlias, aFieldNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < AvailableCount) do
    begin
      lbFound := TdaSQLFieldList.IsNamedField(Available[liIndex], aTableNameOrAlias, aFieldNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.IndexOf
 Returns the position of the specified data field in the Items[] array.}

function TdaSQLCriteriaList.IndexOf(const aTableNameOrAlias, aFieldNameOrAlias: String): Integer;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  Result := -1;

  {determine if table is in query}
  liIndex := 0;
  lbFound := False;

  while not(lbFound) and (liIndex < Count) do
    begin
      if (Items[liIndex].Field <> nil) then
        lbFound := TdaSQLFieldList.IsNamedField(Items[liIndex].Field, aTableNameOrAlias, aFieldNameOrAlias);

      if not(lbFound) then
        Inc(liIndex);

    end;

  if lbFound then
    Result := liIndex;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.Remove
 Removes the specified item from the Items[] array.

 Overloaded. Accepts an Index or a table and field name/alias.}

function TdaSQLCriteriaList.Remove(aSelectedIndex: Integer): Boolean;
begin
  Result := FSQL.RemoveCriteria(aSelectedIndex);
end;

function TdaSQLCriteriaList.Remove(const aTableNameOrAlias, aFieldNameOrAlias: String): Boolean;
var
  liIndex: Integer;
begin

  liIndex := IndexOf(aTableNameOrAlias, aFieldNameOrAlias);

  if (liIndex >= 0) then
    Result := Remove(liIndex)
  else
    Result := False;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.AddParentheses
 Adds two criteria to the Items[] array. An open parentheses at the beginning
 of the Items[] array and a close parenteses at the end.}

procedure TdaSQLCriteriaList.AddParentheses;
begin
  if (Count >= 1) then
    begin
      InsertOpenParentheses(0);
      InsertCloseParentheses(Count);
    end;

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.InsertCloseParentheses
 Inserts a closing parentheses in the Items[] array at the specified position.}
 
procedure TdaSQLCriteriaList.InsertCloseParentheses(aPosition: Integer);
begin
  FSQL.InsertCriteria(aPosition, dacrEnd);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.InsertNot
 Inserts a Not criteria in the Items[] array at the specified position.}

procedure TdaSQLCriteriaList.InsertNot(aPosition: Integer);
begin
  FSQL.InsertCriteria(aPosition, dacrNot);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.InsertOpenParentheses
 Inserts an open parentheses in the Items[] array at the specified position.}

procedure TdaSQLCriteriaList.InsertOpenParentheses(aPosition: Integer);
begin
  FSQL.InsertCriteria(aPosition, dacrBegin);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.InsertOr
 Inserts an Or criteria in the Items[] array at the specified position.

 Note: If no operators are specified between Criteria items, then an And
       will be generated.}

procedure TdaSQLCriteriaList.InsertOr(aPosition: Integer);
begin
  FSQL.InsertCriteria(aPosition, dacrOr);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.Move
  Moves a Criteria item from its current position to a new position in the
  Items[] array.}

procedure TdaSQLCriteriaList.Move(aCurrentIndex, aNewIndex: Integer);
var
  lCriteria: TdaCriteria;
begin
  lCriteria := Items[aCurrentIndex];
  FSQL.MoveChild(lCriteria, aCurrentIndex, aNewIndex);

end;

{------------------------------------------------------------------------------}
{@TdaSQLCriteriaList.GetTypeForOperator
 Returns the TdaCriteriaOperatoryType for corresponding to the specified
 string. If no enumerated type is found for the specified string, then
 a value of dacoEqual is returned.}

class function TdaSQLCriteriaList.GetTypeForOperator(aOperator: String): TdaCriteriaOperatorType;
var
  liIndex: Integer;
  lbFound: Boolean;
begin

  liIndex := Low(cSearchConditions);
  lbFound := False;

  while not(lbFound) and (liIndex <= High(cSearchConditions)) do
    begin

     if CompareText(aOperator, cSearchConditions[liIndex]) = 0 then
       lbFound := True
     else
       Inc(liIndex);

    end;

  // look in cSearchConditions2
  if not(lbFound) then
    begin

      liIndex := Low(cSearchConditions2);
      lbFound := False;

      while not(lbFound) and (liIndex <= High(cSearchConditions2)) do
        begin

         if CompareText(aOperator, cSearchConditions2[liIndex]) = 0 then
           lbFound := True
         else
           Inc(liIndex);

        end;
    end;


  if lbFound then
    Result := TdaCriteriaOperatorType(liIndex)
  else
    Result := dacoEqual;

end;

{******************************************************************************
 *
 ** G R O U P   S E A R C H   C R I T E R I A
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLGroupCriteriaList.Create }

constructor TdaSQLGroupCriteriaList.Create(aSQL: TdaSQL);
begin
  FSQL := aSQL;

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupCriteriaList.Add }

function TdaSQLGroupCriteriaList.Add(aAvailableIndex: Integer): TdaCriteria;
begin
  Result := FSQL.SelectGroupCriteria(aAvailableIndex);

end;

{------------------------------------------------------------------------------}
{@TdaSQLGroupCriteriaList.Clear
 Removes all Group Criteria from the Items[] array.}

procedure TdaSQLGroupCriteriaList.Clear;
begin
  FSQL.ClearGroupCriteria;

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupCriteriaList.GetAvailable }

function TdaSQLGroupCriteriaList.GetAvailable(Index: Integer): TdaField;
begin
  Result := FSQL.AvailableGroupCriteria[Index];

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupCriteriaList.GetAvailableCount }

function TdaSQLGroupCriteriaList.GetAvailableCount: Integer;
begin
  Result := FSQL.AvailableGroupCriteriaCount;

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupCriteriaList.GetCount }

function TdaSQLGroupCriteriaList.GetCount: Integer;
begin
  Result := FSQL.GroupCriteriaCount;

end;

{------------------------------------------------------------------------------}
{ TdaSQLGroupCriteriaList.GetSelected }

function TdaSQLGroupCriteriaList.GetSelected(Index: Integer): TdaCriteria;
begin
  Result := FSQL.GroupCriteria[Index];

end;

{------------------------------------------------------------------------------}
{@TdaSQLGroupCriteriaList.Remove
 Removes the specified item from the Items[] array.

 Overloaded. Accepts an Index or a table and field name/alias.}

function TdaSQLGroupCriteriaList.Remove(aSelectedIndex: Integer): Boolean;
begin
  Result := FSQL.DeselectGroupCriteria(aSelectedIndex);

end;

{******************************************************************************
 *
 ** S Q L  F I E L D   L I N K S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSQLLinks.Create }

constructor TdaSQLLinks.Create(aSQL: TdaSQL);
begin

  inherited Create;

  FSQL := aSQL;

end;

{------------------------------------------------------------------------------}
{ TdaSQLLinks.Clear }

procedure TdaSQLLinks.Clear;
begin

  FSQL.MasterSQL := nil;
  FSQL.ClearSQLLinks;

end;

{------------------------------------------------------------------------------}
{ TdaSQLLinks.Add }

function TdaSQLLinks.Add(aMasterPipeline: TppDataPipeline; aMasterFieldAlias, aDetailFieldAlias: String): TdaSQLLink;
var
  lDetailField: TdaField;
  lMasterField: TdaField;
  lMasterSQL: TdaSQL;
begin

  lMasterSQL := aMasterPipeline.SQL as TdaSQL;

  if (lMasterSQL = nil) then
    raise EDataError.Create('TdaSQLBuilder.Add: MasterPipeline.SQL is nil');

  lMasterField := lMasterSQL.GetFieldForAlias(aMasterFieldAlias);

  if (lMasterField = nil) then
    raise EDataError.Create('TdaSQLBuilder.Add: master field not found: ' + aMasterFieldAlias);

  lDetailField := FSQL.GetFieldForAlias(aDetailFieldAlias);

  if (lDetailField = nil) then
    raise EDataError.Create('TdaSQLBuilder.Add: detail field not found: ' + aDetailFieldAlias);

  FSQL.MasterSQL := lMasterSQL; 
  FSQL.CreateLink(lMasterField, lDetailField);

  Result := FSQL.Links[FSQL.LinkCount-1];

end;

{------------------------------------------------------------------------------}
{ TdaSQLLinks.GetCount }

function TdaSQLLinks.GetCount: Integer;
begin
  Result := FSQL.LinkCount;
end;

{------------------------------------------------------------------------------}
{ TdaSQLLinks.GetItems }

function TdaSQLLinks.GetItems(Index: Integer): TdaSQLLink;
begin
  Result := FSQL.Links[Index];
end;

{------------------------------------------------------------------------------}
{ TdaLinkBroker.GetLinkType }

function TdaSQLLinks.GetLinkType: TdaLinkType;
begin
  Result := FSQL.LinkType;

end;

{------------------------------------------------------------------------------}
{ TdaSQLLinks.GetMasterSQL }

function TdaSQLLinks.GetMasterSQL: TdaSQL;
begin
  Result := FSQL.MasterSQL;
end;

{------------------------------------------------------------------------------}
{ TdaSQLLinks.Remove }

procedure TdaSQLLinks.Remove(aIndex: Integer);
begin

  FSQL.Links[aIndex].Free;

  if (FSQL.LinkCount = 0) then
    FSQL.MasterSQL := nil;

end;

{------------------------------------------------------------------------------}
{ TdaLinkBroker.SetLinkType }

procedure TdaSQLLinks.SetLinkType(const Value: TdaLinkType);
begin
  FSQL.LinkType := Value;

end;

{******************************************************************************
 *
 ** S Q L   B U I L D E R   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTdaSQLBuilderRTTI.RefClass }

class function TraTdaSQLBuilderRTTI.RefClass: TClass;
begin
  Result := TdaSQLBuilder;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLBuilderRTTI.GetPropList }

class procedure TraTdaSQLBuilderRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited;

  aPropList.Add('ApplyUpdates');
  aPropList.Add('Clear');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLBuilderRTTI.GetPropRec }

class function TraTdaSQLBuilderRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'ApplyUpdates') = 0) then
    MethodToRec(aPropName, False, aPropRec)
  else if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;


{------------------------------------------------------------------------------}
{ TraTdaSQLBuilderRTTI.GetParams }

class function TraTdaSQLBuilderRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if CompareText(aMethodName, 'Create') = 0 then
    begin
      {note: Class and Result params will be added automatically by ConstructorToRec}
      Result := TraParamList.Create;

      Result.AddParam('aDataPipeline', daClass, TppDataPipeline, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end; {function, GetParams}

{------------------------------------------------------------------------------}
{ TraTdaSQLBuilderRTTI.CallMethod }

class function TraTdaSQLBuilderRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lClass: TClass;
  lDataPipeline: TppDataPipeline;
  lSQLBuilder: TdaSQLBuilder;
begin

  Result := True;

 if CompareText(aMethodName, 'Create') = 0 then
    begin
      lDataPipeline := nil;
      aParams.GetParamValue(0, lDataPipeline);

      lClass := aParams[1].ClassType;

      lSQLBuilder := TdaSQLBuilderClass(lClass).Create(lDataPipeline);

      aParams.SetParamValue(2, Integer(lSQLBuilder));
    end
  else if CompareText(aMethodName, 'ApplyUpdates') = 0 then
    begin
      TdaSQLBuilder(aObject).ApplyUpdates;
    end
  else if CompareText(aMethodName, 'Clear') = 0 then
    begin
      TdaSQLBuilder(aObject).Clear;
    end
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end; {class function, CallMethod}

{******************************************************************************
 *
 ** S Q L  T A B L E  L I S T   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTdaSQLTableListRTTI.RefClass }

class function TraTdaSQLTableListRTTI.RefClass: TClass;
begin
  Result := TdaSQLTableList;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLTableListRTTI.GetPropList }

class procedure TraTdaSQLTableListRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('Clear');
  aPropList.AddMethod('Exists');
  aPropList.AddMethod('IndexOfAvailable');
  aPropList.AddMethod('IndexOf');
  aPropList.AddMethod('Add');
  aPropList.AddMethod('AddByIndex');
  aPropList.AddMethod('Remove');
  aPropList.AddMethod('RemoveByIndex');

  aPropList.AddProp('Available');
  aPropList.AddProp('AvailableCount');
  aPropList.AddProp('Items');
  aPropList.AddProp('Count');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLTableListRTTI.GetPropRec }

class function TraTdaSQLTableListRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'Exists') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOfAvailable') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOf') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Add') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'AddByIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Remove') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'RemoveByIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Available') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'AvailableCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (aPropName = '') or (CompareText(aPropName, 'Items') = 0) then // default prop
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Count') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLTableListRTTI.GetParams }

class function TraTdaSQLTableListRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) or
          (CompareText(aMethodName, 'IndexOf') = 0)then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daInteger, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'Add') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaTable, '', False, False);
    end
  else if (CompareText(aMethodName, 'AddByIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaTable, '', False, False);
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaTable, '', False, False);
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaTable, '', False, False);
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaTable, '', False, False);
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaTable, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLTableListRTTI.CallMethod }

class function TraTdaSQLTableListRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lTableList: TdaSQLTableList;
  liIndex: Integer;
  lbResult: Boolean;
  liResult: Integer;
  lResultTable: TdaTable;
  lsTableNameOrAlias: String;
begin

  Result := True;

  lTableList := TdaSQLTableList(aObject);

  if (CompareText(aMethodName, 'Clear') = 0) then
    begin
      lTableList.Clear;
      
    end
 else if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);

      lbResult := lTableList.Exists(lsTableNameOrAlias);

      aParams.SetParamValue(1, lbResult);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);

      liResult := lTableList.IndexOfAvailable(lsTableNameOrAlias);

      aParams.SetParamValue(1, liResult);
    end
  else if (CompareText(aMethodName, 'IndexOf') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);

      liResult := lTableList.IndexOf(lsTableNameOrAlias);

      aParams.SetParamValue(1, liResult);
    end
  else if (CompareText(aMethodName, 'Add') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);

      lResultTable := lTableList.Add(lsTableNameOrAlias);

      aParams.SetParamValue(1, Integer(lResultTable));
    end
  else if (CompareText(aMethodName, 'AddByIndex') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultTable := lTableList.Add(liIndex);

      aParams.SetParamValue(1, Integer(lResultTable));
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);

      lResultTable := lTableList.Remove(lsTableNameOrAlias);

      aParams.SetParamValue(1, Integer(lResultTable));
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultTable := lTableList.Remove(liIndex);

      aParams.SetParamValue(1, Integer(lResultTable));
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultTable := lTableList.Available[liIndex];

      aParams.SetParamValue(1, Integer(lResultTable));
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      aParams.GetParamValue(0, liIndex);

      lResultTable := lTableList[liIndex];

      aParams.SetParamValue(1, Integer(lResultTable));
    end


  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLTableListRTTI.GetPropValue }

class function TraTdaSQLTableListRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin
 
  Result := True;

  if (CompareText(aPropName, 'AvailableCount') = 0) then
    Integer(aValue) := Integer(TdaSQLTableList(aObject).AvailableCount)
    
  else if (CompareText(aPropName, 'Count') = 0) then
    Integer(aValue) := Integer(TdaSQLTableList(aObject).Count)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{******************************************************************************
 *
 ** S Q L  S E L E C T  T A B L E S   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTdaSQLSelectTablesRTTI.RefClass }

class function TraTdaSQLSelectTablesRTTI.RefClass: TClass;
begin
  Result := TdaSQLSelectTables;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLSelectTablesRTTI.GetPropList }

class procedure TraTdaSQLSelectTablesRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('AddJoin');
  aPropList.AddMethod('AddFullOuterJoin');
  aPropList.AddMethod('AddLeftOuterJoin');
  aPropList.AddMethod('AddRightOuterJoin');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLSelectTablesRTTI.GetPropRec }

class function TraTdaSQLSelectTablesRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AddJoin')           = 0) or
     (CompareText(aPropName, 'AddFullOuterJoin')  = 0) or
     (CompareText(aPropName, 'AddLeftOuterJoin')  = 0) or
     (CompareText(aPropName, 'AddRightOuterJoin') = 0) then

    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);


end;


{------------------------------------------------------------------------------}
{ TraTdaSQLSelectTablesRTTI.GetPropRec }

class function TraTdaSQLSelectTablesRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'AddJoin')           = 0) or
     (CompareText(aMethodName, 'AddFullOuterJoin')  = 0) or
     (CompareText(aMethodName, 'AddLeftOuterJoin')  = 0) or
     (CompareText(aMethodName, 'AddRightOuterJoin') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aJoinToNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNamesOrAliases', daString, nil, '', True, False);
      Result.AddParam('aOperators', daString, nil, '', True, False);
      Result.AddParam('aJoinToFieldNamesOrAliases', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else
    Result := inherited GetParams(aMethodName);


end;



{------------------------------------------------------------------------------}
{ TraTdaSQLSelectTablesRTTI.CallMethod }

class function TraTdaSQLSelectTablesRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lSelectTables: TdaSQLSelectTables;
  lsNameOrAlias: String;
  lsJoinToNameOrAlias: String;
  lsFieldNamesOrAliases: String;
  lsOperators: String;
  lsJoinToFieldNamesOrAliases: String;
  lbResult: Boolean;
begin

  Result := True;

  lSelectTables := TdaSQLSelectTables(aObject);


  if (CompareText(aMethodName, 'AddJoin')           = 0) or
     (CompareText(aMethodName, 'AddFullOuterJoin')  = 0) or
     (CompareText(aMethodName, 'AddLeftOuterJoin')  = 0) or
     (CompareText(aMethodName, 'AddRightOuterJoin') = 0) then
    begin
      aParams.GetParamValue(0, lsNameOrAlias);
      aParams.GetParamValue(1, lsJoinToNameOrAlias);
      aParams.GetParamValue(2, lsFieldNamesOrAliases);
      aParams.GetParamValue(3, lsOperators);
      aParams.GetParamValue(4, lsJoinToFieldNamesOrAliases);
    end;

  if (CompareText(aMethodName, 'AddJoin') = 0) then
    begin
      lbResult := lSelectTables.AddJoin(lsNameOrAlias, lsJoinToNameOrAlias, lsFieldNamesOrAliases, lsOperators, lsJoinToFieldNamesOrAliases);

      aParams.SetParamValue(5, lbResult);
    end
  else if (CompareText(aMethodName, 'AddFullOuterJoin') = 0) then
    begin
      lbResult := lSelectTables.AddFullOuterJoin(lsNameOrAlias, lsJoinToNameOrAlias, lsFieldNamesOrAliases, lsOperators, lsJoinToFieldNamesOrAliases);

      aParams.SetParamValue(5, lbResult);
    end
  else if (CompareText(aMethodName, 'AddLeftOuterJoin') = 0) then
    begin
      lbResult := lSelectTables.AddLeftOuterJoin(lsNameOrAlias, lsJoinToNameOrAlias, lsFieldNamesOrAliases, lsOperators, lsJoinToFieldNamesOrAliases);

      aParams.SetParamValue(5, lbResult);
    end
  else if (CompareText(aMethodName, 'AddRightOuterJoin') = 0) then
    begin
      lbResult := lSelectTables.AddRightOuterJoin(lsNameOrAlias, lsJoinToNameOrAlias, lsFieldNamesOrAliases, lsOperators, lsJoinToFieldNamesOrAliases);

      aParams.SetParamValue(5, lbResult);
    end

  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;



{******************************************************************************
 *
 ** S Q L  F I E L D  L I S T   R T T I
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.RefClass }

class function TraTdaSQLFieldListRTTI.RefClass: TClass;
begin
  Result := TdaSQLFieldList;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.GetPropList }

class procedure TraTdaSQLFieldListRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('Clear');
  aPropList.AddMethod('Exists');
  aPropList.AddMethod('IndexOfAvailable');
  aPropList.AddMethod('IndexOf');
  aPropList.AddMethod('Add');
  aPropList.AddMethod('AddByIndex');
  aPropList.AddMethod('Remove');
  aPropList.AddMethod('RemoveByIndex');

  aPropList.AddProp('Available');
  aPropList.AddProp('AvailableCount');
  aPropList.AddProp('Items');
  aPropList.AddProp('Count');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.GetPropRec }

class function TraTdaSQLFieldListRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'Exists') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOfAvailable') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOf') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Add') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'AddByIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Remove') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'RemoveByIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Available') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'AvailableCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (aPropName = '') or (CompareText(aPropName, 'Items') = 0) then // default prop
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Count') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.GetParams }

class function TraTdaSQLFieldListRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) or
          (CompareText(aMethodName, 'IndexOf') = 0)then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daInteger, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'Add') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end
  else if (CompareText(aMethodName, 'AddByIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.CallMethod }

class function TraTdaSQLFieldListRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lFieldList: TdaSQLFieldList;
  liIndex: Integer;
  lbResult: Boolean;
  liResult: Integer;
  lResultField: TdaField;
  lsTableNameOrAlias: String;
  lsFieldNameOrAlias: String;
begin

  Result := True;

  lFieldList := TdaSQLFieldList(aObject);

  if (CompareText(aMethodName, 'Clear') = 0) then
    begin
      lFieldList.Clear;
    end
  else if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lbResult := lFieldList.Exists(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, lbResult);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      liResult := lFieldList.IndexOfAvailable(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, liResult);
    end
  else if (CompareText(aMethodName, 'IndexOf') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      liResult := lFieldList.IndexOf(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, liResult);
    end
  else if (CompareText(aMethodName, 'Add') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultField := lFieldList.Add(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultField));
    end
  else if (CompareText(aMethodName, 'AddByIndex') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lFieldList.Add(liIndex);

      aParams.SetParamValue(1, Integer(lResultField));
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultField := lFieldList.Remove(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultField));
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lFieldList.Remove(liIndex);

      aParams.SetParamValue(1, Integer(lResultField));
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lFieldList.Available[liIndex];

      aParams.SetParamValue(1, Integer(lResultField));
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lFieldList[liIndex];

      aParams.SetParamValue(1, Integer(lResultField));
    end


  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.GetPropValue }

class function TraTdaSQLFieldListRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin
 
  Result := True;

  if (CompareText(aPropName, 'AvailableCount') = 0) then
    Integer(aValue) := Integer(TdaSQLFieldList(aObject).AvailableCount)
    
  else if (CompareText(aPropName, 'Count') = 0) then
    Integer(aValue) := Integer(TdaSQLFieldList(aObject).Count)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}



{******************************************************************************
 *
 ** S Q L  S E L E C T  F I E L D S  R T T I
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TraTdaSQLSelectFieldsRTTI.RefClass }

class function TraTdaSQLSelectFieldsRTTI.RefClass: TClass;
begin
  Result := TdaSQLSelectFields;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLSelectFieldsRTTI.GetPropList }

class procedure TraTdaSQLSelectFieldsRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('AddAllFields');
  aPropList.AddMethod('AddAllFieldsForTable');

end;


{------------------------------------------------------------------------------}
{ TraTdaSQLSelectFieldsRTTI.GetPropRec }

class function TraTdaSQLSelectFieldsRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AddAllFields') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'AddAllFieldsForTable') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLSelectFieldsRTTI.GetParams }

class function TraTdaSQLSelectFieldsRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'AddAllFields') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
 else if (CompareText(aMethodName, 'AddAllFieldsForTable') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.CallMethod }

class function TraTdaSQLSelectFieldsRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lSelectFields: TdaSQLSelectFields;
  lbResult: Boolean;
  lsTableNameOrAlias: String;
begin

  Result := True;

  lSelectFields := TdaSQLSelectFields(aObject);

  if (CompareText(aMethodName, 'AddAllFields') = 0) then
    begin
      lbResult := lSelectFields.AddAllFields;

      aParams.SetParamValue(0, lbResult);
    end
  else if (CompareText(aMethodName, 'AddAllFieldsForTable') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);

      lbResult := lSelectFields.AddAllFields(lsTableNameOrAlias);

      aParams.SetParamValue(1, lbResult);
    end
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;


{******************************************************************************
 *
 ** S Q L  S E L E C T  F I E L D S  R T T I
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TraTdaSQLOrderByFieldsRTTI.RefClass }

class function TraTdaSQLOrderByFieldsRTTI.RefClass: TClass;
begin
  Result := TdaSQLOrderByFields;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLOrderByFieldsRTTI.GetPropList }

class procedure TraTdaSQLOrderByFieldsRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('AddDescending');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLOrderByFieldsRTTI.GetPropRec }

class function TraTdaSQLOrderByFieldsRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AddDescending') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLOrderByFieldsRTTI.GetParams }

class function TraTdaSQLOrderByFieldsRTTI.GetParams(const aMethodName: String): TraParamList;
begin

 if (CompareText(aMethodName, 'AddDescending') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLFieldListRTTI.CallMethod }

class function TraTdaSQLOrderByFieldsRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lOrderByFields: TdaSQLOrderByFields;
  lResultField: TdaField;
  lsTableNameOrAlias: String;
  lsFieldNameOrAlias: String;
begin

  Result := True;

  lOrderByFields := TdaSQLOrderByFields(aObject);

  if (CompareText(aMethodName, 'AddDescending') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultField := lOrderByFields.AddDescending(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, lResultField);
    end
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;




{******************************************************************************
 *
 ** S Q L  C A L C   F I E L D S   R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTdaSQLCalcFieldsRTTI.RefClass }

class function TraTdaSQLCalcFieldsRTTI.RefClass: TClass;
begin
  Result := TdaSQLCalcFields;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCalcFieldsRTTI.GetPropList }

class procedure TraTdaSQLCalcFieldsRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('Clear');
  aPropList.AddMethod('Exists');
  aPropList.AddMethod('IndexOfAvailable');
  aPropList.AddMethod('IndexOf');

  aPropList.AddMethod('AddAvg');
  aPropList.AddMethod('AddCount');
  aPropList.AddMethod('AddMin');
  aPropList.AddMethod('AddMax');
  aPropList.AddMethod('AddSum');
  aPropList.AddMethod('AddExpression');
  aPropList.AddMethod('Remove');
  aPropList.AddMethod('RemoveByIndex');

  aPropList.AddProp('Available');
  aPropList.AddProp('AvailableCount');
  aPropList.AddProp('Items');
  aPropList.AddProp('Count');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCalcFieldsRTTI.GetPropRec }

class function TraTdaSQLCalcFieldsRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'Exists') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOfAvailable') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOf') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'AddAvg') = 0) or
          (CompareText(aPropName, 'AddCount') = 0) or
          (CompareText(aPropName, 'AddMin') = 0) or
          (CompareText(aPropName, 'AddMax') = 0) or
          (CompareText(aPropName, 'AddSum') = 0) or
          (CompareText(aPropName, 'AddExpression') = 0) then
    MethodToRec(aPropName, True, aPropRec)
    
  else if (CompareText(aPropName, 'Remove') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'RemoveByIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Available') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'AvailableCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (aPropName = '') or (CompareText(aPropName, 'Items') = 0) then // default prop
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Count') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCalcFieldsRTTI.GetParams }

class function TraTdaSQLCalcFieldsRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) or
          (CompareText(aMethodName, 'IndexOf') = 0)then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daInteger, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'AddAvg') = 0) or
          (CompareText(aMethodName, 'AddMin') = 0) or
          (CompareText(aMethodName, 'AddMax') = 0) or
          (CompareText(aMethodName, 'AddSum') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end
  else if (CompareText(aMethodName, 'AddCount') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end
  else if (CompareText(aMethodName, 'AddExpression') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aExpression', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaCalculation, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCalcFieldsRTTI.CallMethod }

class function TraTdaSQLCalcFieldsRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lCalcFields: TdaSQLCalcFields;
  liIndex: Integer;
  lbResult: Boolean;
  liResult: Integer;
  lResultField: TdaField;
  lResultCalc: TdaCalculation;
  lsTableNameOrAlias: String;
  lsFieldNameOrAlias: String;
  lsExpression: String;
begin

  Result := True;

  lCalcFields := TdaSQLCalcFields(aObject);

  if (CompareText(aMethodName, 'Clear') = 0) then
    begin
      lCalcFields.Clear;
    end
  else if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lbResult := lCalcFields.Exists(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, lbResult);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      liResult := lCalcFields.IndexOfAvailable(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, liResult);
    end
  else if (CompareText(aMethodName, 'IndexOf') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      liResult := lCalcFields.IndexOf(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, liResult);
    end
  else if (CompareText(aMethodName, 'AddAvg') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultCalc := lCalcFields.AddAvg(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultCalc));
    end
  else if (CompareText(aMethodName, 'AddMin') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultCalc := lCalcFields.AddMin(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultCalc));
    end
  else if (CompareText(aMethodName, 'AddMax') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultCalc := lCalcFields.AddMax(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultCalc));
    end
  else if (CompareText(aMethodName, 'AddSum') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultCalc := lCalcFields.AddSum(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultCalc));
    end
  else if (CompareText(aMethodName, 'AddCount') = 0) then
    begin
      lResultCalc := lCalcFields.AddCount;

      aParams.SetParamValue(0, Integer(lResultCalc));
    end
  else if (CompareText(aMethodName, 'AddExpression') = 0) then
    begin
      aParams.GetParamValue(0, lsExpression);
      
      lResultCalc := lCalcFields.AddExpression(lsExpression);

      aParams.SetParamValue(1, Integer(lResultCalc));
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lResultField := lCalcFields.Remove(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, Integer(lResultField));
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lCalcFields.Remove(liIndex);

      aParams.SetParamValue(1, Integer(lResultField));
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lCalcFields.Available[liIndex];

      aParams.SetParamValue(1, Integer(lResultField));
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      aParams.GetParamValue(0, liIndex);

      lResultCalc := lCalcFields[liIndex];

      aParams.SetParamValue(1, Integer(lResultCalc));
    end


  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCalcFieldsRTTI.GetPropValue }

class function TraTdaSQLCalcFieldsRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AvailableCount') = 0) then
    Integer(aValue) := Integer(TdaSQLCalcFields(aObject).AvailableCount)
    
  else if (CompareText(aPropName, 'Count') = 0) then
    Integer(aValue) := Integer(TdaSQLCalcFields(aObject).Count)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{******************************************************************************
 *
 ** S Q L  C R I T E R I A   L I S T    R T T I
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TraTdaSQLCriteriaListRTTI.RefClass }

class function TraTdaSQLCriteriaListRTTI.RefClass: TClass;
begin
  Result := TdaSQLCriteriaList;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCriteriaListRTTI.GetPropList }

class procedure TraTdaSQLCriteriaListRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin
  inherited;

  aPropList.AddMethod('Clear');
  aPropList.AddMethod('Exists');
  aPropList.AddMethod('IndexOfAvailable');
  aPropList.AddMethod('IndexOf');

  aPropList.AddMethod('Move');
  aPropList.AddMethod('AddParentheses');
  aPropList.AddMethod('InsertOpenParentheses');
  aPropList.AddMethod('InsertCloseParentheses');
  aPropList.AddMethod('InsertNot');
  aPropList.AddMethod('Add');
  aPropList.AddMethod('AddAutoSearch');
  aPropList.AddMethod('Remove');
  aPropList.AddMethod('RemoveByIndex');

  aPropList.AddProp('Available');
  aPropList.AddProp('AvailableCount');
  aPropList.AddProp('Items');
  aPropList.AddProp('Count');

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCriteriaListRTTI.GetPropRec }

class function TraTdaSQLCriteriaListRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'Exists') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOfAvailable') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'IndexOf') = 0) then
    MethodToRec(aPropName, True, aPropRec)
    
  else if (CompareText(aPropName, 'Move') = 0) then
    MethodToRec(aPropName, True, aPropRec)
    
  else if (CompareText(aPropName, 'AddParentheses') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'InsertOpenParentheses') = 0) or
          (CompareText(aPropName, 'InsertCloseParentheses') = 0) or
          (CompareText(aPropName, 'InsertOr') = 0) or
          (CompareText(aPropName, 'InsertNot') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Add') = 0) or
          (CompareText(aPropName, 'AddAutoSearch') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Remove') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'RemoveByIndex') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Available') = 0) then
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'AvailableCount') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (aPropName = '') or (CompareText(aPropName, 'Items') = 0) then // default prop
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Count') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)
  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;


{------------------------------------------------------------------------------}
{ TraTdaSQLCriteriaListRTTI.GetParams }

class function TraTdaSQLCriteriaListRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);

    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) or
          (CompareText(aMethodName, 'IndexOf') = 0)then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daInteger, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'Move') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aCurrentIndex', daInteger, nil, '', True, False);
      Result.AddParam('aNewIndex', daInteger, nil, '', True, False);
    end
  else if (CompareText(aMethodName, 'InsertOpenParentheses')  = 0) or
          (CompareText(aMethodName, 'InsertCloseParentheses') = 0) or
          (CompareText(aMethodName, 'InsertNot') = 0) or
          (CompareText(aMethodName, 'InsertOr') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aPosition', daInteger, nil, '', True, False);
    end
  else if (CompareText(aMethodName, 'Add') = 0) or
          (CompareText(aMethodName, 'AddAutoSearch') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aOperator', daString, nil, '', True, False);
      Result.AddParam('aValue', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaCriteria, '', False, False);
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aTableNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('aFieldNameOrAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aIndex', daInteger, nil, '', True, False);
      Result.AddParam('Result', daBoolean, nil, '', False, False);
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaField, '', False, False);
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaCriteria, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCriteriaListRTTI.CallMethod }

class function TraTdaSQLCriteriaListRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  lCriteriaList: TdaSQLCriteriaList;
  liIndex: Integer;
  lbResult: Boolean;
  liResult: Integer;
  liCurrentPosition: Integer;
  liNewPosition: Integer;
  liPosition: Integer;
  lResultField: TdaField;
  lResultCriteria: TdaCriteria;
  lsTableNameOrAlias: String;
  lsFieldNameOrAlias: String;
  lsOperator: String;
  lsValue: String;
begin

  Result := True;

  lCriteriaList := TdaSQLCriteriaList(aObject);

  if (CompareText(aMethodName, 'Clear') = 0) then
    begin
      lCriteriaList.Clear;
    end
  else if (CompareText(aMethodName, 'Exists') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lbResult := lCriteriaList.Exists(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, lbResult);
    end
  else if (CompareText(aMethodName, 'IndexOfAvailable') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      liResult := lCriteriaList.IndexOfAvailable(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, liResult);
    end
  else if (CompareText(aMethodName, 'IndexOf') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      liResult := lCriteriaList.IndexOf(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, liResult);
    end
  else if (CompareText(aMethodName, 'Move') = 0) then
    begin
      aParams.GetParamValue(0, liCurrentPosition);
      aParams.GetParamValue(1, liNewPosition);

      lCriteriaList.Move(liCurrentPosition, liNewPosition);

    end
  else if (CompareText(aMethodName, 'AddParentheses') = 0) then
    begin
      lCriteriaList.AddParentheses;
    end
  else if (CompareText(aMethodName, 'InsertOpenParentheses') = 0) then
    begin
      aParams.GetParamValue(0, liPosition);

      lCriteriaList.InsertOpenParentheses(liPosition);
    end
  else if (CompareText(aMethodName, 'InsertCloseParentheses') = 0) then
    begin
      aParams.GetParamValue(0, liPosition);

      lCriteriaList.InsertCloseParentheses(liPosition);
    end
  else if (CompareText(aMethodName, 'InsertNot') = 0) then
    begin
      aParams.GetParamValue(0, liPosition);

      lCriteriaList.InsertNot(liPosition);
    end
  else if (CompareText(aMethodName, 'InsertOr') = 0) then
    begin
      aParams.GetParamValue(0, liPosition);

      lCriteriaList.InsertOr(liPosition);
    end
  else if (CompareText(aMethodName, 'Add') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);
      aParams.GetParamValue(2, lsOperator);
      aParams.GetParamValue(3, lsValue);

      lResultCriteria := lCriteriaList.Add(lsTableNameOrAlias, lsFieldNameOrAlias, lsOperator, lsValue);

      aParams.SetParamValue(4, Integer(lResultCriteria));
    end
  else if (CompareText(aMethodName, 'AddAutoSearch') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);
      aParams.GetParamValue(2, lsOperator);
      aParams.GetParamValue(3, lsValue);

      lResultCriteria := lCriteriaList.AddAutoSearch(lsTableNameOrAlias, lsFieldNameOrAlias, lsOperator, lsValue);

      aParams.SetParamValue(4, Integer(lResultCriteria));
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      aParams.GetParamValue(0, lsTableNameOrAlias);
      aParams.GetParamValue(1, lsFieldNameOrAlias);

      lbResult := lCriteriaList.Remove(lsTableNameOrAlias, lsFieldNameOrAlias);

      aParams.SetParamValue(2, lbResult);
    end
  else if (CompareText(aMethodName, 'RemoveByIndex') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lbResult := lCriteriaList.Remove(liIndex);

      aParams.SetParamValue(1, lbResult);
    end
  else if (CompareText(aMethodName, 'Available') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lResultField := lCriteriaList.Available[liIndex];

      aParams.SetParamValue(1, Integer(lResultField));
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      aParams.GetParamValue(0, liIndex);

      lResultCriteria := lCriteriaList[liIndex];

      aParams.SetParamValue(1, Integer(lResultCriteria));
    end
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLCriteriaListRTTI.GetPropValue }

class function TraTdaSQLCriteriaListRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'AvailableCount') = 0) then
    Integer(aValue) := Integer(TdaSQLCriteriaList(aObject).AvailableCount)
    
  else if (CompareText(aPropName, 'Count') = 0) then
    Integer(aValue) := Integer(TdaSQLCriteriaList(aObject).Count)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}


{******************************************************************************
 *
 ** S Q L   L I N K S    R T T I
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TraTdaSQLLinksRTTI.RefClass }

class function TraTdaSQLLinksRTTI.RefClass: TClass;
begin
  Result := TdaSQLLinks;

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLLinksRTTI.GetPropList }

class procedure TraTdaSQLLinksRTTI.GetPropList(aClass: TClass; aPropList: TraPropList);
begin

  inherited;

  aPropList.AddMethod('Clear');
  aPropList.AddMethod('Add');
  aPropList.AddMethod('Remove');

  aPropList.AddProp('Count');
  aPropList.AddProp('Items');
  aPropList.AddProp('LinkType');
  aPropList.AddProp('MasterSQL');

end;


{------------------------------------------------------------------------------}
{ TraTdaSQLLinksRTTI.GetPropRec }

class function TraTdaSQLLinksRTTI.GetPropRec(aClass: TClass; const aPropName: String; var aPropRec: TraPropRec): Boolean;
begin

  Result := True;

  if (CompareText(aPropName, 'Clear') = 0) then
    MethodToRec(aPropName, False, aPropRec)

  else if (CompareText(aPropName, 'Add') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (CompareText(aPropName, 'Remove') = 0) then
    MethodToRec(aPropName, True, aPropRec)

  else if (aPropName = '') or (CompareText(aPropName, 'Items') = 0) then // default prop
    AccessSpecifierToRec(aPropName, aPropRec)

  else if (CompareText(aPropName, 'Count') = 0) then
    PropToRec(aPropName, daInteger, True, aPropRec)

  else if (CompareText(aPropName, 'LinkType') = 0) then
    EnumPropToRec(aPropName, 'TdaLinkType', False, aPropRec)

  else if (CompareText(aPropName, 'MasterSQL') = 0) then
    ClassPropToRec(aPropName, TdaSQL, False, aPropRec)

  else
    Result := inherited GetPropRec(aClass, aPropName, aPropRec);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLLinksRTTI.GetParams }

class function TraTdaSQLLinksRTTI.GetParams(const aMethodName: String): TraParamList;
begin

  if (CompareText(aMethodName, 'Add') = 0) then
    begin
      Result := TraParamList.Create;

      Result.AddParam('aMasterPipeline', daClass, TppDataPipeline, '', True, False);
      Result.AddParam('aMasterFieldAlias', daString, nil, '', True, False);
      Result.AddParam('aDetailFieldAlias', daString, nil, '', True, False);
      Result.AddParam('Result', daClass, TdaSQLLink, '', False, False);
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      Result := TraParamList.Create;
      Result.AddParam('aIndex', daInteger, nil, '', True, False);
    end
  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
    begin
      Result := TraParamList.Create;

      Result.AddParam('Index', daInteger, nil, '', False, False);
      Result.AddParam('Result', daClass, TdaSQLLink, '', False, False);
    end

  else
    Result := inherited GetParams(aMethodName);

end;

{------------------------------------------------------------------------------}
{ TraTdaSQLLinksRTTI.GetPropValue }

class function TraTdaSQLLinksRTTI.GetPropValue(aObject: TObject; const aPropName: String; var aValue): Boolean;
begin

  Result := True;

   if (CompareText(aPropName, 'Count') = 0) then
    Integer(aValue) := Integer(TdaSQLLinks(aObject).Count)

   else if (CompareText(aPropName, 'LinkType') = 0) then
    TdaLinkType(aValue) := TdaSQLLinks(aObject).LinkType

   else if (CompareText(aPropName, 'MasterSQL') = 0) then
    Integer(aValue) := Integer(TdaSQLLinks(aObject).MasterSQL)

  else
    Result := inherited GetPropValue(aObject, aPropName, aValue);

end; {class function, GetPropValue}

{------------------------------------------------------------------------------}
{ TraTdaSQLLinksRTTI.CallMethod }

class function TraTdaSQLLinksRTTI.CallMethod(aObject: TObject; const aMethodName: String; aParams: TraParamList; aGet: Boolean): Boolean;
var
  liIndex: Integer;
  lSQLLinks: TdaSQLLinks;
  lResultLink: TdaSQLLink;
  lDataPipeline: TppDataPipeline;
  lsMasterFieldAlias: String;
  lsDetailFieldAlias: String;
begin

  Result := True;

  lSQLLinks := TdaSQLLinks(aObject);

  if (CompareText(aMethodName, 'Clear') = 0) then
    begin
      lSQLLinks.Clear;
    end
  else if (CompareText(aMethodName, 'Add') = 0) then
    begin
      aParams.GetParamValue(0, lDataPipeline);
      aParams.GetParamValue(1, lsMasterFieldAlias);
      aParams.GetParamValue(2, lsDetailFieldAlias);

      lResultLink := lSQLLinks.Add(lDataPipeline, lsMasterFieldAlias, lsDetailFieldAlias);

      aParams.SetParamValue(3, Integer(lResultLink));
    end
  else if (CompareText(aMethodName, 'Remove') = 0) then
    begin
      aParams.GetParamValue(0, liIndex);

      lSQLLinks.Remove(liIndex);
    end

  else if (aMethodName = '') or (CompareText(aMethodName, 'Items') = 0) then // default prop
begin
      aParams.GetParamValue(0, liIndex);

      lResultLink := lSQLLinks[liIndex];

      aParams.SetParamValue(1, Integer(lResultLink));
    end
  else
    Result := inherited CallMethod(aObject, aMethodName, aParams, aGet);

end;

{ TraTdaSQLGroupCriteriaListRTTI }

class function TraTdaSQLGroupCriteriaListRTTI.RefClass: TClass;
begin
  Result := TdaSQLGroupCriteriaList;
end;


initialization
  RegisterClasses([TdaSQLBuilder, TdaSQLTableList, TdaSQLSelectTables, TdaSQLLinks,
                   TdaSQLFieldList, TdaSQLSelectFields, TdaSQLCalcFields, TdaSQLGroupByFields,
                   TdaSQLOrderByFields, TdaSQLCriteriaList, TdaSQLGroupCriteriaList]);

  raRegisterRTTI(TraTdaSQLBuilderRTTI);
  raRegisterRTTI(TraTdaSQLSelectTablesRTTI);
  raRegisterRTTI(TraTdaSQLFieldListRTTI);
  raRegisterRTTI(TraTdaSQLSelectFieldsRTTI);
  raRegisterRTTI(TraTdaSQLOrderByFieldsRTTI);
  raRegisterRTTI(TraTdaSQLCalcFieldsRTTI);
  raRegisterRTTI(TraTdaSQLCriteriaListRTTI);
  raRegisterRTTI(TraTdaSQLGroupCriteriaListRTTI);
  raRegisterRTTI(TraTdaSQLLinksRTTI);



finalization

  raUnRegisterRTTI(TraTdaSQLBuilderRTTI);
  raUnRegisterRTTI(TraTdaSQLSelectTablesRTTI);
  raUnRegisterRTTI(TraTdaSQLFieldListRTTI);
  raUnRegisterRTTI(TraTdaSQLSelectFieldsRTTI);
  raUnRegisterRTTI(TraTdaSQLOrderByFieldsRTTI);
  raUnRegisterRTTI(TraTdaSQLCalcFieldsRTTI);
  raUnRegisterRTTI(TraTdaSQLCriteriaListRTTI);
  raUnRegisterRTTI(TraTdaSQLGroupCriteriaListRTTI);
  raUnRegisterRTTI(TraTdaSQLLinksRTTI);

  UnRegisterClasses([TdaSQLBuilder, TdaSQLTableList, TdaSQLSelectTables, TdaSQLLinks,
                   TdaSQLFieldList, TdaSQLSelectFields, TdaSQLCalcFields, TdaSQLGroupByFields,
                   TdaSQLOrderByFields, TdaSQLCriteriaList, TdaSQLGroupCriteriaList]);

end.
