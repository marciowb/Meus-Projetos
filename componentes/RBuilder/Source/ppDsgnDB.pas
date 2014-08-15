{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppDsgnDB;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  SysUtils, Classes,
  ppComm, ppDB, ppTypes, ppForms, ppUtils, ppIniStorage;

type


  TppBasicDataSettings = class;
  TppFieldFieldNames = class;
  TppJoinFieldNames = class;
  TppTableFieldNames = class;

  {@TppDataDictionary

    The data dictionary component is designed to help you present a clear and
    concise view of the database to your end-users.  The three main ways that it
    does this are:

    1. Control the tables which the user can see (as well as the names of the
       tables.)
    2. Control the fields which the user can see (as well as the names of the
       fields.)
    3. Provide default join relationships between tables.

    The information utilized by the data dictionary is usually stored in
    database tables.  There is one table for each major function of the data
    dictionary.

    1. Table names table
    2. Field names table
    3. Join relationships table

    The fields which should appear in each of these tables are listed in the
    TablePipeline, FieldPipeline and JoinPipeline topics, respectively. The
    exact table definitions which should be used for these tables varies
    depending on the database product which you are using, so it is
    recommended that you refer to the ...RBuilder\\Demos\\EndUser Databases
    directory in order to find the example which shows how to configure the data
    dictionary with your database and with your chosen database connectivity
    product.

    Once you have the data dictionary tables created in your database, you can
    connect them to the data dictionary component using standard data pipelines.
    The usual configuration is to have a TTable connected to a TDataSource which
    is then connected to a TppDBPipeline.  The data pipeline is then connected
    to the data dictionary.  Once the pipelines are connected, you can use the
    BuilderSettings properties to indicate the SessionType and DatabaseName
    which correspond to the database which the data dictionary will describe
    (this is the database your end-users will query in order to build reports.)
    Configuring these properties will allow you to launch the Data Dictionary
    Builder - which can be done by double-clicking on the data dictionary
    component.  The Data Dictionary Builder is a utility which will help you
    automatically generate and maintain the entries of your data dictionary.

    Additional features of the data dictionary which you might find useful
    include the UseTableOwnerNames property, which determines whether the data
    dictionary expects to find the table name entries prefixed with owner names.
    This feature can be used where you have used owner names to distinguish
    between otherwise identical sets of tables in your database.

    The TableFieldNames, FieldFieldNames and JoinFieldNames properties allow you
    to correlate the required field sets of the data dictionary to the actual
    field names used in your data dictionary tables.  This can be helpful when
    you are maintaining naming standards in the database or are using existing
    data dictionary tables where the field names are different from the data
    dictionary component's default field names.

    The AutoJoin property indicates whether or not default join relationships
    will be provided via the JoinPipeline, when multiple tables are selected in
    the Query Wizard or Query Designer.  If AutoJoin is True, then the
    JoinPipeline must be assigned.  If AutoJoin is False, the JoinPipeline
    does not need to be assigned, nor do you need to create the rbJoin table in
    your database.

    Use the ValidateTableNames property to insure that the table entries found
    in the data dictionary actually have matching tables in the database.  If
    you are certain that the table entries in the data dictionary are correct,
    then set ValidateTableNames to False in order to improve performance. The
    ValidateFieldNames property provides the same functionality for the field
    names.  If a field name appears in the data dictionary, but not in the
    actual table, it will be automatically dropped from any field list displayed
    in the Query Wizard or Query Designer when ValidateFieldNames is True.  If
    the field entries in the data dictionary are correct, you can improve
    performance by setting this property to False.  Whenever ValidateFieldNames
    is false, each field entry must have the DataType field value assigned.  For
    a complete description of the DataType field, see the FieldPipeline help
    topic.}

  {@TppDataDictionary.Active

    If this property is set to True, then the data dictionary will be able to
    search for entries and request field values from the TablePipeline,
    FieldPipeline and JoinPipeline (when the AutoJoin property is set to True.)}

  {@TppDataDictionary.AllowManualJoins

    This property only applies when the AutoJoin property has been set to True.
    If AllowManualJoins is False, then the relations defined in the rbJoin data
    dictionary table represent the only legal joins between tables.  When using
    the Query Wizard and Query Designer the end-user will only be able to join
    tables which have a predefined relationship in the AutoJoin table. If
    AllowManualJoins is set to True, the end-user can modify any join
    relationship which was created based on an entry in the AutoJoins table
    and can also create new relations (join conditions) between tables which
    have no predefined relation.}

  {@TppDataDictionary.AutoJoin

    Indicates whether the join relationships provided via the JoinPipeline
    should be used when multiple tables are selected in the Query Wizard or
    Query Designer.  The join dialog will automatically suggest joins
    between tables where the tables have matching field names - the default 
    join type in this instance is always an inner join.  AutoJoin gives you
    the capability to specify more complex joins between the tables as well 
    as control the default join type.

    For instance, let's assume that you have two tables, Customer and
    Order.  These tables are linked by the CustNo field, which is the key 
    field for the Customer table and a foreign key in the Order table.  
    Using the Data Dictionary Builder, you could create a join record for
    these two tables and set the join type to LEFT OUTER.  Whenever the 
    user selected the customer and order table a left outer join would be
    used as the default - meaning that all customers will be selected, even 
    when there are no corresponding orders for a given customer.  Without
    the use of this AutoJoin relationship, the two tables would default to 
    an INNER join, where only customers with corresponding orders would be
    selected.}

  {@TppDataDictionary.BuilderSettings

    The 'Builder' in BuilderSettings refers to the Data Dictionary Builder.
    The Data Dictionary Builder allows you to edit, generate, synchronize and
    maintain your data dictionary tables.  In order to do this, it needs to
    connect to the database you will be using to retrieve report data.  The
    properties contained in BuilderSettings must be configured in order for the
    Data Dictionary Builder to function properly.  They are:

    <Table>
    Value               Meaning
    --------------      -------
    DatabaseName        The name of the database which the data dictionary
                        entries will describe.
                        This property should be assigned to an alias or database
                        object which can connect to the database from which data
                        will be retrieved for reports.
    SessionType         The type of connection to be used.  This property
                        determines which objects will appear in the drop-down
                        list of the DatabaseName property.  It defaults
                        to 'BDESession', but can be set to IBXSession,
                        ADOSession or to a third party session component which
                        has been created and installed at Delphi design-time.
    </Table>}

  {@TppDataDictionary.Close

    Closes the TablePipeline and FieldPipeline components.}

  {@TppDataDictionary.FieldCount

    When the TableName property is set, this property indicates the number of
    field entries found by the data dictionary for the given table.}

  {@TppDataDictionary.FieldFieldNames

    This property contains all of the field names from the FieldPipeline which
    correlate to the fields required by the data dictionary. This object allows
    you to use any field names you desire in your database table. The properties
    of this object have the following meanings:

    <Table>
    Field       Use
    ----------  -----
    TableName   The name of the field containing the table name to which the
                field entries correspond.  Together the TableName and FieldName
                fields make up the primary key of the table which contains the
                field entries.  The TableName is a foreign key from the table
                containing the table entries.
    FieldName   The name of the field containing the field name.  These are the
                raw field names which match the names found in the database.
    FieldAlias  The name of the field containing the field alias.  The field
                alias is displayed in ReportBuilder user-interface instead of
                the raw field name - and is one of the main reasons for the
                existence of the data dictionary.
    Selectable  The name of the field containing the selectable value.  The
                selectable value is assigned to the Selectable property of a
                TppField object when the field entry is read by the data
                dictionary.
    Searchable  The name of the field containing the searchable value.  The
                searchable value is assigned to the Searchable property of a
                TppField object when the field entry is read by the data
                dictionary.
    Sortable    The name of the field containing the sortable value.  The
                sortable value is assigned to the Sortable property of a
                TppField object when the field entry is read by the data
                dictionary.
    </Table>}

  {@TppDataDictionary.FieldPipeline

    This property should be assigned to a data pipeline which is configured to
    access the field entries of the data dictionary.  The table containing the
    field entries should have the following structure.

    <Table>
    Value         Meaning
    ----------    -------
    TableName     Type String. The name of the table to which the field
                  entry corresponds.
    FieldName     Type String. The raw field name of the field.  This value
                  should match the value of a real field found in the database.
    DataType      Type String. The data type of the field, expressed as one of
                  the names in the TppDataType enumerated type (i.e dtString).
    Selectable    Type Char(1). Contains either 'T' or 'F'. Indicates whether or
                  not the field can be selected from the Select Fields page of
                  the query wizard.
    Searchable    Type Char(1). Contains either 'T' or 'F'. Indicates whether or
                  not the field can be selected from the Search Criteria page of
                  the query wizard.
    Sortable      Type Char(1). Contains either 'T' or 'F'. Indicates whether or
                  not the field can be selected from the Sort Order page of the
                  query wizard.
    AutoSearch    Type Char(1). Contains either 'T' or 'F'.. Indicates whether
                  or not the field should be set to AutoSearch when selected as
                  search criteria.
    Mandatory     Type Char(1). Contains either 'T' or 'F'.. Only applies when
                  AutoSearch is True. Determines if the AutoSearch field will be
                  a mandatory entry in the AutoSearch dialog.
    </Table>

    Note: Your field entry table need not use these field names.  You can
    specify different field names using the FieldFieldNames property.

    The Data Dictionary Builder allows you to automatically generate the
    field entries for a given database.}

  {@TppDataDictionary.Fields

    When the TableName property is set, this property contains the corresponding
    fields found by the data dictionary.  FieldAlias, Selectable, Searchable and
    Sortable property values are all set based on the values from the data
    dictionary.}

  {@TppDataDictionary.JoinFieldNames

    This property contains all of the field names from the JoinPipeline which
    correlate to the fields required by the data dictionary. This object allows
    you to use any field names you desire in your database table. The properties
    of this object have the following meanings:

    <Table>
    Value           Meaning
    -----------     -------
    TableName1      Type String. The name of the first table involved in the
                    join.  This field is foreign key from the TableName field of
                    the table entries.
    TableName2      Type String. The name of the second table involved in the
                    join.  Also a foreign key from the TableName field of the
                    table entries.
    JoinType        Type String. Inner, Left Outer, Right Outer or Full Outer
                    (cartesian product.)  The valid values of this field are the
                    names of the TdaJoinType numerated type. (dajtInner,
                    dajtLeftOuter, dajtRightOuter and dajtOuter)
    FieldNames1     Type String. The names of the fields from TableName1 which
                    are participating in the join relationship.
    FieldsNames2    Type String. The names of the fields from TableName2 which
                    are participating in the join relationship.
    Operators       Type String. The operators to be used when joining the two
                    sets of fields in FieldNames1 and FieldNames2.
    </Table>}

  {@TppDataDictionary.JoinPipeline

    This property should be assigned to a data pipeline which is configured to
    access the default join relationship entries of the data dictionary.  The
    table containing the join entries should have the following structure.

    <Table>
    Value           Meaning
    ------------    -------
    TableName1      Type String. The name of the first table involved in the
                    join.  This field is foreign key from the TableName field of
                    the table entries.
    TableName2      Type String. The name of the second table involved in the
                    join.  Also a foreign key from the TableName field of the
                    table entries.
    JoinType        Type String. Inner, Left Outer, Right Outer or Full Outer
                    (cartesian product.)  The valid values of this field are the
                    names of the TdaJoinType enumerated type. (dajtInner,
                    dajtLeftOuter, dajtRightOuter and dajtOuter)
    FieldNames1     Type String. The names of the fields from TableName1 which
                    are participating in the join relationship.
    FieldsNames2    Type String. The names of the fields from TableName2 which
                    are participating in the join relationship.
    Operators       Type String. The operators to be used when joining the two
                    sets of fields in FieldNames1 and FieldNames2.
    </Table>

    Note: Your join entry table need not use these field names.  You can specify
    different field names using the JoinFieldNames property.

    The FieldNames1, FieldNames2 and Operators values take the form of a
    comma-delimited list. There must be the same number of elements in each list.
    For example, if you were joining on three fields, the format would be:

    FieldNames1:	field1,field2,field3
    FieldNames2:	field1,field2,field3
    Operators:	=,=,=

    The Data Dictionary Builder allows you to use the Join Dialog to define the
    default join relationships between tables. It then saves the join
    information in the appropriate format to the join relationships table.  This
    is the easiest way to create join relationship data.}

  {@TppDataDictionary.TableAlias

    Run-time and read-only.  When the TableName property is set to a table which
    is found in the table entries of the data dictionary, this property contains
    the corresponding table alias.  The table alias is displayed on the Select
    Tables page of the Query Wizard and Query Designer.}

  {@TppDataDictionary.TableFieldNames

    This property contains all of the field names from the TablePipeline which
    correlate to the fields required by the data dictionary. This object allows
    you to use any field names you desire in your database table. The properties
    of this object have the following meanings:

    <Table>
    Field       Use
    ----------  -----
    TableName   The name of the field containing the table name.  The TableName
                is the primary key of the table.  The TableName is a foreign key
                in the table containing the field entries.
    TableAlias  The name of the field containing the table alias.  The table
                alias is displayed in ReportBuilder user-interface instead of
                the raw table name - and is one of the main reasons for the
                existence of the data dictionary.
    </Table>}

  {@TppDataDictionary.TableName

    When this property is set to a table name which is found in the data
    dictionary, the TableAlias, FieldCount and Fields properties are modifed to
    reflect all the available data dictionary information on the table.}

  {@TppDataDictionary.TablePipeline

    This property should be assigned to a data pipeline which is configured to
    access the table entries of the data dictionary.  The table containing the
    table entries should have the following structure.

    <Table>
    Value            Meaning
    -----------      ------
    TableName        Type String. The name of a table in the database. The TableName is the primary key of the table.  The TableName is a foreign key in the table containing the field entries.
    TableAlias       Type String. The alias which will be used to represent the table. The table alias is displayed in ReportBuilder user-interface instead of the raw table name.
    </Table>

    Note: Your field entry table need not use these field names.  You can
    specify different field names using the TableFieldNames property.

    The Data Dictionary Builder allows you to automatically generate the table
    entries for a given database.}

  {@TppDataDictionary.UserName

    This is the name which will be displayed in the Data Settings dialog when
    selecting a data dictionary component from within the data workspace.  This
    normally applies to work done in the data workspace at Delphi design-time.

    You can access the Data Settings dialog by clicking on the data tab of
    the Report Designer and accessing the File | Data Settings menu option.
    When you want to utilize the data dicitonary in the context of an
    running application, you would normally configure the
    Designer.DataSettings property in the Object Inspector and set the 
    Designer.AllowDataSettingsChange property to False - so that the end-
    user cannot modify the data settings (i.e. change the database, session
    type, sql generation type or data dictionary object.)}

  {@TppDataDictionary.UseTableOwnerName

    Defaults to False. Determines whether the data dictionary expects the owner
    name to be present in the table name entries.

    In database products such as Interbase, Oracle and Sybase, it is possible to
    define tables and logins such that a user of the database will see the
    tables names in the format:

            ownername.tablename

    where the owner name is the name of the user which created the table.  The
    owner name is sometimes used to differentiate sets of tables.  The data
    dictionary component normally removes the owner name from a table when
    searching for table entries. This is useful when you want to provide the
    same data dictionary to different users, regardless of the owner name they
    see when logged on to the database. However, if you are using the owner name
    to differentiate sets of identical tables or sets of tables where some of
    the table names are the same, then the owner name is actually needed to
    uniquely identify the table. In this case you should set UseTableOwnerName
    to True and include the owner name in the table entries of the data
    dictionary.  When configured in this way, the data dictionary will use the
    owner name and table name when assembling a list of tables.

    If UseTableOwnerName is True, the Data Dictionary Builder will
    automatically include the owner name when generating the table entries 
    for a given database.}

  {@TppDataDictionary.ValidateFieldNames

    Defaults to True. This property indicates whether or not the field entries
    in the data dicitonary will be compared to the fields actually present in a
    given database table.  If matching fields cannot be found in the database,
    then the fields will not be displayed in the selection lists used in the
    Query Wizard or Query Designer.

    When a table is selected in the Query Wizard or Query Designer, the
    table is actually opened on the database so that the fields and their
    data types can be determined.  On Client/Server databases it is better 
    to turn ValidateFieldNames off, provide accurate data dictionary 
    entries and avoid the performance hit of opening the tables.  When
    ValidateFieldNames is turned off, the Query Wizard and Query Designer 
    rely solely on the data dictionary entry to provide the field names and
    data types. . One way to insure that these values are accurate is to 
    use the Data Dictionary Builder to automatically generate them based on
    the tables and fields defined in your database.}

  {@TppDataDictionary.ValidateFieldNames

    Defaults to True. This property indicates whether or not the field entries
    in the data dicitonary will be compared to the fields actually present in a
    given database table.  If matching fields cannot be found in the database,
    then the fields will not be displayed in the selection lists used in the
    Query Wizard or Query Designer.

    When a table is selected in the Query Wizard or Query Designer, the 
    table is actually opened on the database so that the fields and their
    data types can be determined.  On Client/Server databases it is better
    to turn ValidateFieldNames off, provide accurate data dictionary
    entries and avoid the performance hit of opening the tables.  When
    ValidateFieldNames is turned off, the Query Wizard and Query Designer 
    rely solely on the data dictionary entry to provide the field names and
    data types. . One way to insure that these values are accurate is to
    use the Data Dictionary Builder to automatically generate them based on
    the tables and fields defined in your database.}

  {@TppDataDictionary.ValidateTableNames

    Defaults to True. This property indicates whether or not the table names
    supplied by the data dictionary should be validated against the table names
    supplied by the currently connected database. In order to optimize the
    performance of the data dictionary, you can set this property to False. The
    data dictionary will then return the table names accessible via the table
    data pipeline, without verifying whether or not the tables are actually
    present in the database.

    During normal operation, the Query Wizard and Query Designer call the
    Session.GetTableNames function to retrieve a list of available tables for
    the query.  This list is then compared to the tables in the data dictionary.
    Only tables which have a matching entry in the data dictionary are
    displayed.  This call to the Session object can be very slow on
    Client/Server databases.  It is therefore advantageous to turn off the
    validation of the table names.  When ValidateTableNames is set to False,
    Session.GetTableNames is not called and the table names which appear in the
    data dictionary are used as-is.

    One way to insure that your data dictionary contains valid table
    entries is to use the Data Dictionary Builder to generate them.}
    
  TppDataDictionary = class(TppCommunicator)
    private
      FActive: Boolean;
      FAllowManualJoins: Boolean;
      FAutoJoin: Boolean;
      FBuilderSettings: TppBasicDataSettings;
      FErrorMessage: String;
      FFieldFieldNames: TppFieldFieldNames;
      FFieldList: TStringList;
      FFieldPipeline: TppDataPipeline;
      FTableAlias: String;
      FJoinFieldNames: TppJoinFieldNames;
      FJoinPipeline: TppDataPipeline;
      FTableFieldNames: TppTableFieldNames;
      FTableName: String;
      FTablePipeline: TppDataPipeline;
      FUseTableOwnerName: Boolean;
      FValidateFieldNames: Boolean;
      FValidateTableNames: Boolean;

      function  AddField(aField: TppField): Integer;
      procedure CreateFields;
      function  FieldsOpen: Boolean;
      procedure FreeFields;
      function  GetField(Index: Integer): TppField;
      function  GetFieldCount: Integer;
      function  JoinsOpen: Boolean;
      procedure SetBuilderSettings(aSettings: TppBasicDataSettings);
      procedure SetFieldFieldNames(aFieldFieldNames: TppFieldFieldNames);
      procedure SetActive(aValue: Boolean);
      procedure SetFieldPipeline(aDataPipeline: TppDataPipeline);
      procedure SetJoinFieldNames(aJoinFieldNames: TppJoinFieldNames);
      procedure SetJoinPipeline(aDataPipeline: TppDataPipeline);
      procedure SetTableFieldNames(aTableFieldNames: TppTableFieldNames);
      procedure SetTableName(const aName: String);
      procedure SetTablePipeline(aDataPipeline: TppDataPipeline);
      function  TablesOpen: Boolean;
      function  ValidDataPipelineFields(aDataPipeline: TppDataPipeline; const aPropertyName: String;
                                        aFieldProperties, aFieldNames: TStrings): Boolean;
      function  ValidDataPipeline(aDataPipeline: TppDataPipeline; const aPropertyName: String): Boolean;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure Assign(Source: TPersistent); override;

      procedure AppendFieldRecord(const aTableName, aFieldName, aFieldAlias,
                                  aSelectable, aSearchable, aSortable, aAutoSearch, aDataType: String);
      procedure AppendJoinRecord(const aTableName1, aTableName2, aJoinType: String;
                                 aFieldNames1, aFieldNames2, aOperators: TStrings);
      procedure AppendTableRecord(const aTableName, aTableAlias: String);
      procedure GetCompatibleJoinTables(const aSelectedTableName: String; aJoinTableNames: TStrings);
      function  GetFieldAlias(const aTableName, aFieldName: String): String;
      function  GetFirstJoinTable(const aSelectedTableName: String; aSelectedTableNames: TStrings): Integer;
      procedure GetJoinableTableNames(aLocalTableNames: TStrings; aForeignTableName: TStrings);
      function  GetJoinData(const aTableName1, aTableName2: String; var aJoinType: String; aFieldNames1, aFieldNames2, aOperators: TStrings): Boolean;
      function  GetLinkData(const aTableName1, aTableName2: String; var aJoinType: String; aFieldNames1, aFieldNames2, aOperators: TStrings): Boolean;
      procedure GetJoinTableNames(aSelectedTableNames, aJoinTableNames, aJoinTableAliases: TStrings);
      function  GetTableAlias(const aTableName: String): String;
      procedure GetTableNames(aTableNames, aTableAliases: TStrings);
      procedure Close;
      function  FieldForFieldName(const aFieldName: String): TppField;
      function  FindField(aField: TppField): Integer;
      procedure Open;
      procedure Reset;
      function  ValidSettings: Boolean;

      property Active: Boolean read FActive write SetActive;
      property ErrorMessage: String read FErrorMessage;
      property Fields[Index: Integer]: TppField read GetField;
      property FieldCount: Integer read GetFieldCount;
      property TableAlias: String read FTableAlias;
      property TableName: String read FTableName write SetTableName;

    published
      property AllowManualJoins: Boolean read FAllowManualJoins write FAllowManualJoins default False;
      property AutoJoin: Boolean read FAutoJoin write FAutoJoin default False;
      property BuilderSettings: TppBasicDataSettings read FBuilderSettings write SetBuilderSettings;
      property FieldFieldNames: TppFieldFieldNames read FFieldFieldNames write SetFieldFieldNames;
      property FieldPipeline: TppDataPipeline read FFieldPipeline write SetFieldPipeline;
      property JoinFieldNames: TppJoinFieldNames read FJoinFieldNames write SetJoinFieldNames;
      property JoinPipeline: TppDataPipeline read FJoinPipeline write SetJoinPipeline;
      property TableFieldNames: TppTableFieldNames read FTableFieldNames write SetTableFieldNames;
      property TablePipeline: TppDataPipeline read FTablePipeline write SetTablePipeline;
      property UserName;
      property UseTableOwnerName: Boolean read FUseTableOwnerName write FUseTableOwnerName default False;
      property ValidateFieldNames: Boolean read FValidateFieldNames write FValidateFieldNames default True;
      property ValidateTableNames: Boolean read FValidateTableNames write FValidateTableNames default True;

  end; {class, TppDataDictionary}

  {@TppTableFieldNames }
  TppTableFieldNames = class(TPersistent)
    private
      FDataDictionary: TppDataDictionary;

      FTableName: String;
      FTableAlias: String;

    public
      constructor Create(aDataDictionary: TppDataDictionary);

      procedure Assign(Source: TPersistent); override;

      property DataDictionary: TppDataDictionary read FDataDictionary;

    published
      property TableName: String read FTableName write FTableName;
      property TableAlias: String read FTableAlias write FTableAlias;

  end; {class, TppTableFieldNames}

  {@TppFieldFieldNames }
  TppFieldFieldNames = class(TPersistent)
    private
      FDataDictionary: TppDataDictionary;

      FAutoSearch: String;
      FDataType: String;
      FFieldAlias: String;
      FFieldName: String;
      FMandatory: String;
      FSearchable: String;
      FSelectable: String;
      FSortable: String;
      FTableName: String;

    public
      constructor Create(aDataDictionary: TppDataDictionary);

      procedure Assign(Source: TPersistent); override;

      property DataDictionary: TppDataDictionary read FDataDictionary;

    published
      property AutoSearch: String read FAutoSearch write FAutoSearch;
      property DataType: String read FDataType write FDataType;
      property FieldName: String read FFieldName write FFieldName;
      property FieldAlias: String read FFieldAlias write FFieldAlias;
      property Mandatory: String read FMandatory write FMandatory;
      property Searchable: String read FSearchable write FSearchable;
      property Selectable: String read FSelectable write FSelectable;
      property Sortable: String read FSortable write FSortable;
      property TableName: String read FTableName write FTableName;

  end; {class, TppFieldFieldNames}

  {@TppJoinFieldNames }
  TppJoinFieldNames = class(TPersistent)
    private
      FDataDictionary: TppDataDictionary;

      FTableName1: String;
      FTableName2: String;
      FJoinType: String;
      FFieldNames1: String;
      FFieldNames2: String;
      FOperators: String;

    public
      constructor Create(aDataDictionary: TppDataDictionary);

      procedure Assign(Source: TPersistent); override;

      property DataDictionary: TppDataDictionary read FDataDictionary;

    published
      property TableName1: String read FTableName1 write FTableName1;
      property TableName2: String read FTableName2 write FTableName2;
      property JoinType: String read FJoinType write FJoinType;
      property FieldNames1: String read FFieldNames1 write FFieldNames1;
      property FieldNames2: String read FFieldNames2 write FFieldNames2;
      property Operators: String read FOperators write FOperators;

  end; {class, TppJoinFieldNames}


  {@TppBasicDataSettings}
  TppBasicDataSettings = class(TPersistent)
    private
      FActive: Boolean;
      FDatabaseName: TFilename;
      FOnChange: TNotifyEvent;
      FParent: TppCommunicator;
      FSessionType: String;
      
    protected
      function  IsActive: Boolean;
      procedure DoOnChange;
      procedure SetDatabaseName(aDatabaseName: TFilename); virtual;
      procedure SetSessionType(aSessionType: String); virtual;

    public
      constructor Create(aParent: TppCommunicator); virtual;

      procedure Assign(Source: TPersistent); override;
      procedure SaveStateInfo(aIniStorage: TppIniStorage); virtual;
      procedure LoadStateInfo(aIniStorage: TppIniStorage; aDataModule: TppCommunicator); virtual;

      property Active: Boolean read FActive write FActive;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
      property Parent: TppCommunicator read FParent;

    published
      property DatabaseName: TFilename read FDatabaseName write SetDatabaseName;
      property SessionType: String read FSessionType write SetSessionType;

  end; {class, TppBasicDataSettings}

  {@TppDataSettings}
  TppDataSettings = class(TppBasicDataSettings)
    private
      FAllowEditSQL: Boolean;
      FDataDictionary: TppDataDictionary;
      FDatabaseType: TppDatabaseType;
      FCollationType: TppCollationType;
      FGuidCollationType: TppGuidCollationType;
      FIsCaseSensitive: Boolean;
      FNullCollationType: TppNullCollationType;
      FSQLType: TppSQLType;
      FUseDataDictionary: Boolean;

      procedure SetAllowEditSQL(aValue: Boolean);
      procedure SetCollationType(aCollationType: TppCollationType);
      procedure SetDatabaseType(aDatabaseType: TppDatabaseType);
      procedure SetDataDictionary(aDataDictionary: TppDataDictionary);
      procedure SetIsCaseSensitive(aValue: Boolean);
      procedure SetSQLType(aSQLType: TppSQLType);
      procedure SetUseDataDictionary(aValue: Boolean);
      procedure SetGuidCollationType(aGuidCollationType: TppGuidCollationType);
      procedure SetNullCollationType(const Value: TppNullCollationType);

    protected
      procedure SetSessionType(aSessionType: String); override;
      function GetDefaultCollationType(aDatabaseType: TppDatabaseType): TppCollationType;
      function GetDefaultGuidCollationType(aDatabaseType: TppDatabaseType): TppGuidCollationType;
      function GetDefaultNullCollationType(aDatabaseType: TppDatabaseType): TppNullCollationType;
      function GetDefaultIsCaseSensitive(aDatabaseType: TppDatabaseType): Boolean;
    public
      constructor Create(aParent: TppCommunicator); override;

      procedure Assign(Source: TPersistent); override;
      function EqualTo(aDataSettings: TppDataSettings): Boolean;
      procedure SaveStateInfo(aIniStorage: TppIniStorage); override;
      procedure LoadStateInfo(aIniStorage: TppIniStorage; aDataModule: TppCommunicator); override;

    published
      property AllowEditSQL: Boolean read FAllowEditSQL write SetAllowEditSQL;
      property CollationType: TppCollationType read FCollationType write SetCollationType default ctASCII;
      property DatabaseType: TppDatabaseType read FDatabaseType write SetDatabaseType default dtOther;
      property DataDictionary: TppDataDictionary read FDataDictionary write SetDataDictionary;
      property GuidCollationType: TppGuidCollationType read FGuidCollationType write SetGuidCollationType;
      property IsCaseSensitive: Boolean read FIsCaseSensitive write SetIsCaseSensitive default False;
      property NullCollationType: TppNullCollationType read FNullCollationType write SetNullCollationType default ncNullsFirst;
      property SQLType: TppSQLType read FSQLType write SetSQLType;
      property UseDataDictionary: Boolean read FUseDataDictionary write SetUseDataDictionary default False;

    end; {class, TppDataSettings}


  {@TppCustomDataSettingsDialog }
  TppCustomDataSettingsDialog = class(TppForm)
    private
      FDataModule: TComponent;

    protected
      function  GetDataSettings: TPersistent; virtual; abstract;
      procedure SetDataSettings(aAccessConfig: TPersistent); virtual; abstract;

    public
      procedure Initialize; virtual; abstract;

      property DataModule: TComponent read FDataModule write FDataModule;
      property DataSettings: TPersistent read GetDataSettings write SetDataSettings;

    end; {class, TppCustomDataSettingsDialog}



implementation

{------------------------------------------------------------------------------}
{ ppStringFieldValueToBoolean }

function ppStringFieldValueToBoolean(aValue: Variant): Boolean;
var
  lsValue: String;
begin

  Result := False;

  if VarIsNull(aValue) or not(ppVariantIsString(aValue)) then Exit;

  lsValue := aValue;

  if (Length(lsValue) > 0) then
    Result := (CompareText(lsValue[1], 'T') = 0)
  else
    Result := False;
    
end; {function, ppStringFieldValueToBoolean}


{******************************************************************************
 *
 ** T A B L E   F I E L D   N A M E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTableFieldNames.Create }

constructor TppTableFieldNames.Create(aDataDictionary: TppDataDictionary);
begin

  inherited Create;

  FDataDictionary := aDataDictionary;

  FTableName := 'TableName';
  FTableAlias := 'TableAlias';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTableFieldNames.Assign }

procedure TppTableFieldNames.Assign(Source: TPersistent);
var
  lTableFields: TppTableFieldNames;
begin

  if not(Source is TppTableFieldNames) then Exit;

  lTableFields := TppTableFieldNames(Source);

  FTableName := lTableFields.TableName;
  FTableAlias := lTableFields.TableAlias;

end; {constructor, Assign}

{******************************************************************************
 *
 ** J O I N   F I E L D   N A M E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppJoinFieldNames.Create }

constructor TppJoinFieldNames.Create(aDataDictionary: TppDataDictionary);
begin

  inherited Create;

  FDataDictionary := aDataDictionary;

  FTableName1 := 'TableName1';
  FTableName2 := 'TableName2';
  FJoinType := 'JoinType';
  FFieldNames1 := 'FieldNames1';
  FFieldNames2 := 'FieldNames2';
  FOperators := 'Operators';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppJoinFieldNames.Assign }

procedure TppJoinFieldNames.Assign(Source: TPersistent);
var
  lJoinFields: TppJoinFieldNames;
begin

  if not(Source is TppJoinFieldNames) then Exit;

  lJoinFields := TppJoinFieldNames(Source);

  FTableName1 := lJoinFields.TableName1;
  FTableName2 := lJoinFields.TableName2;
  FJoinType := lJoinFields.JoinType;
  FFieldNames1 := lJoinFields.FieldNames1;
  FFieldNames2 := lJoinFields.FieldNames2;
  FOperators := lJoinFields.Operators;

end; {constructor, Assign}

{******************************************************************************
 *
 ** F I E L D   F I E L D   N A M E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFieldFieldNames.Create }

constructor TppFieldFieldNames.Create(aDataDictionary: TppDataDictionary);
begin

  inherited Create;

  FDataDictionary := aDataDictionary;

  FAutoSearch := 'AutoSearch';
  FDataType := 'DataType';
  FFieldAlias := 'FieldAlias';
  FFieldName := 'FieldName';
  FMandatory := 'Mandatory';
  FSearchable := 'Searchable';
  FSelectable := 'Selectable';
  FSortable := 'Sortable';
  FTableName := 'TableName';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFieldFieldNames.Assign }

procedure TppFieldFieldNames.Assign(Source: TPersistent);
var
  lFieldFields: TppFieldFieldNames;
begin

  if not(Source is TppFieldFieldNames) then Exit;

  lFieldFields := TppFieldFieldNames(Source);

  FAutoSearch := lFieldFields.AutoSearch;
  FDataType := lFieldFields.DataType;
  FFieldAlias := lFieldFields.FieldAlias;
  FFieldName := lFieldFields.FieldName;
  FMandatory := lFieldFields.Mandatory;
  FSearchable := lFieldFields.Searchable;
  FSelectable := lFieldFields.Selectable;
  FSortable := lFieldFields.Sortable;
  FTableName := lFieldFields.TableName;

end; {constructor, Assign}

{******************************************************************************
 *
 ** D A T A   D I C T I O N A R Y
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataDictionary.Create }

constructor TppDataDictionary.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FActive := False;
  FAllowManualJoins := False;
  FAutoJoin := False;
  FBuilderSettings := TppBasicDataSettings.Create(Self);
  FErrorMessage := '';
  FFieldFieldNames := TppFieldFieldNames.Create(Self);
  FFieldList := TStringList.Create;
  FFieldPipeline := nil;
  FJoinFieldNames := TppJoinFieldNames.Create(Self);
  FTableFieldNames := TppTableFieldNames.Create(Self);
  FTableName := '';
  FTablePipeline := nil;
  FUseTableOwnerName := False;
  FValidateTableNames := True;
  FValidateFieldNames := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataDictionary.Destroy }

destructor TppDataDictionary.Destroy;
begin

  FreeFields;

  FBuilderSettings.Free;
  FFieldList.Free;
  FFieldFieldNames.Free;
  FJoinFieldNames.Free;
  FTableFieldNames.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppDataDictionary.Assign }

procedure TppDataDictionary.Assign(Source: TPersistent);
var
  lSource: TppDataDictionary;
begin

  if not(Source is TppDataDictionary) then Exit;

  lSource := TppDataDictionary(Source);

  FreeFields;

  FActive := False;
  FAllowManualJoins := lSource.AllowManualJoins;
  FAutoJoin := lSource.AutoJoin;
  FBuilderSettings.Assign(lSource.BuilderSettings);
  FErrorMessage := '';
  FFieldFieldNames.Assign(lSource.FieldFieldNames);
  SetFieldPipeline(lSource.FieldPipeline);
  FTableAlias := '';
  FJoinFieldNames.Assign(lSource.JoinFieldNames);
  SetJoinPipeline(lSource.JoinPipeline);
  FTableFieldNames.Assign(lSource.TableFieldNames);
  FTableName := '';
  SetTablePipeline(lSource.TablePipeline);
  FUseTableOwnerName := lSource.UseTableOwnerName;
  FValidateFieldNames := lSource.ValidateFieldNames;
  FValidateTableNames := lSource.ValidateTableNames;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDataDictionary.Notify }

procedure TppDataDictionary.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  inherited Notify(aCommunicator, aOperation);

  if not(aOperation = ppopRemove) then Exit;

  if (aCommunicator = FTablePipeline) then
    FTablePipeline := nil

  else if (aCommunicator = FFieldPipeline) then
    FFieldPipeline := nil

  else if (aCommunicator = FJoinPipeline) then
    FJoinPipeline := nil;

end; {procedure, Notify}


{@TppDataDictionary.GetFirstJoinTable
 Given a selected table, finds the position in aSelectedTableNames where that
 table is found as a compatible join table.}

function  TppDataDictionary.GetFirstJoinTable(const aSelectedTableName: String; aSelectedTableNames: TStrings): Integer;
var
  lJoinTables: TStrings;
  liIndex: Integer;
  lsTableName: String;
begin

  Result := -1;

  lJoinTables := TStringList.Create;

  liIndex := 0;

  while (liIndex < aSelectedTableNames.Count - 1) and (Result = -1) do
    begin
      lsTableName := aSelectedTableNames[liIndex];

      GetCompatibleJoinTables(lsTableName, lJoinTables);

      if (lJoinTables.IndexOf(aSelectedTableName) <> -1) then
        Result := liIndex
      else
        Inc(liIndex);
    end;

  lJoinTables.Free;
  
end; {procedure, GetFirstJoinTable}


{@TppDataDictionary.GetCompatibleJoinTables
 Used by the Query Wizard and Query Designer to determine the valid tables which
 could be joined with a given table.}

procedure TppDataDictionary.GetCompatibleJoinTables(const aSelectedTableName: String; aJoinTableNames: TStrings);
var
  lsTable1: String;
  lsTable2: String;

begin
  aJoinTableNames.Clear;

  if not(TablesOpen) or not(JoinsOpen) then Exit;

  FJoinPipeline.First;

  while not(FJoinPipeline.EOF) do
    begin
      lsTable1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName1);
      lsTable2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName2);

      if (CompareText(aSelectedTableName, lsTable1) = 0) then
        aJoinTableNames.Add(lsTable2)

      else if (CompareText(aSelectedTableName, lsTable2) = 0) then
        aJoinTableNames.Add(lsTable1);

      FJoinPipeline.Next;
    end;

end; {procedure, GetCompatibleJoinTables}

{------------------------------------------------------------------------------}
{ TppDataDictionary.GetLinkData }

function TppDataDictionary.GetLinkData(const aTableName1, aTableName2: String; var aJoinType: String; aFieldNames1, aFieldNames2, aOperators: TStrings): Boolean;
var
  lbFound: Boolean;
  lsTable1: String;
  lsTable2: String;
  lsFieldNames1: String;
  lsFieldNames2: String;
  lsOperators: String;
begin

  Result := False;

  if not(JoinsOpen) then Exit;

  FJoinPipeline.First;

  lbFound := False;

  while not(FJoinPipeline.EOF) and not(lbFound) do
    begin
      lsTable1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName1);
      lsTable2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName2);

      if (CompareText(aTableName1, lsTable1) = 0) and (CompareText(aTableName2, lsTable2) = 0) then
        begin
          lbFound := True;

          lsFieldNames1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.FieldNames1);
          lsFieldNames2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.FieldNames2);
          lsOperators := FJoinPipeline.GetFieldValue(FJoinFieldNames.Operators);
        end
      else
        FJoinPipeline.Next;

    end;

  if (lbFound) then
    begin
      aJoinType := FJoinPipeline.GetFieldValue(FJoinFieldNames.JoinType);

      ppParseString(lsFieldNames1, aFieldNames1);
      ppParseString(lsFieldNames2, aFieldNames2);
      ppParseString(lsOperators, aOperators);

      Result := True;
    end;

end; {procedure, GetLinkData}


{@TppDataDictionary.GetJoinData
 Given two table names, returns the default join information for the tables.  If
 no information is found, False is returned.

 Used by the Query Wizard and Query Designer to retrieve join information.}

function TppDataDictionary.GetJoinData(const aTableName1, aTableName2: String; var aJoinType: String; aFieldNames1, aFieldNames2, aOperators: TStrings): Boolean;
var
  lbFound: Boolean;
  lsTable1: String;
  lsTable2: String;
  lsFieldNames1: String;
  lsFieldNames2: String;
  lsOperators: String;
begin

  Result := False;

  if not(JoinsOpen) then Exit;

  FJoinPipeline.First;

  lbFound := False;

  while not(FJoinPipeline.EOF) and not(lbFound) do
    begin
      lsTable1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName1);
      lsTable2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName2);

      if (CompareText(aTableName1, lsTable1) = 0) and (CompareText(aTableName2, lsTable2) = 0) then
        begin
          lbFound := True;

          lsFieldNames1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.FieldNames1);
          lsFieldNames2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.FieldNames2);
          lsOperators := FJoinPipeline.GetFieldValue(FJoinFieldNames.Operators);
        end
      else
        FJoinPipeline.Next;

    end;

  if not(lbFound) then
    begin
      FJoinPipeline.First;

      while not(FJoinPipeline.EOF) and not(lbFound) do
        begin
          lsTable1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName1);
          lsTable2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName2);

          if (CompareText(aTableName2, lsTable1) = 0) and (CompareText(aTableName1, lsTable2) = 0) then
            begin
              lbFound := True;

              lsFieldNames1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.FieldNames2);
              lsFieldNames2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.FieldNames1);
              lsOperators := FJoinPipeline.GetFieldValue(FJoinFieldNames.Operators);
            end

          else
            FJoinPipeline.Next;
        end;
    end;

    
  if not(lbFound) then Exit;

  aJoinType := FJoinPipeline.GetFieldValue(FJoinFieldNames.JoinType);

  ppParseString(lsFieldNames1, aFieldNames1);
  ppParseString(lsFieldNames2, aFieldNames2);
  ppParseString(lsOperators, aOperators);

  Result := True;

end; {procedure, GetJoinData}


{@TppDataDictionary.GetJoinableTableNames
 Given a list of selected tables, returns a list of table names and aliases of
 tables which could be joined with the selected tables.}

procedure TppDataDictionary.GetJoinableTableNames(aLocalTableNames: TStrings; aForeignTableName: TStrings);
begin

  aLocalTableNames.Clear;
  aForeignTableName.Clear;

  if (ppdaNoRecords in FJoinPipeline.State) then Exit;

  if not(JoinsOpen) then Exit;

  FJoinPipeline.First;

  while not(FJoinPipeline.EOF) do
    begin
      aLocalTableNames.Add(FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName1));
      aForeignTableName.Add(FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName2));

      FJoinPipeline.Next;
    end;

end; {procedure, GetJoinableTableNames}

{------------------------------------------------------------------------------}
{ TppDataDictionary.GetJoinTableNames }

procedure TppDataDictionary.GetJoinTableNames(aSelectedTableNames, aJoinTableNames, aJoinTableAliases: TStrings);
var
  liIndex: Integer;
  lsTable1: String;
  lsTable2: String;
  lsSelectTable: String;
begin

  aJoinTableNames.Clear;
  aJoinTableAliases.Clear;

  if not(TablesOpen) or not(JoinsOpen) then Exit;

  for liIndex := 0 to aSelectedTableNames.Count - 1 do
    begin
      lsSelectTable := aSelectedTableNames[liIndex];

      FJoinPipeline.First;

      while not(FJoinPipeline.EOF) do
        begin
          lsTable1 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName1);
          lsTable2 := FJoinPipeline.GetFieldValue(FJoinFieldNames.TableName2);

          if (CompareText(lsSelectTable, lsTable1) = 0) and (aSelectedTableNames.IndexOf(lsTable2) = -1) then
            aJoinTableNames.Add(lsTable2)

          else if (CompareText(lsSelectTable, lsTable2) = 0) and (aSelectedTableNames.IndexOf(lsTable1) = -1) then
            aJoinTableNames.Add(lsTable1);

          FJoinPipeline.Next;
        end;
    end;

  for liIndex := 0 to aJoinTableNames.Count - 1 do
    aJoinTableAliases.Add(GetTableAlias(aJoinTableNames[liIndex]));

end; {procedure, GetJoinTableNames}


{@TppDataDictionary.GetTableNames
 Returns all of the table names and table aliases provided via the
 TablePipeline.}

procedure TppDataDictionary.GetTableNames(aTableNames, aTableAliases: TStrings);
begin

  aTableNames.Clear;

  if not(TablesOpen) then Exit;

  FTablePipeline.First;

  while not(FTablePipeline.EOF) do
    begin
      aTableNames.Add(FTablePipeline.GetFieldValue(FTableFieldNames.TableName));
      aTableAliases.Add(FTablePipeline.GetFieldValue(FTableFieldNames.TableAlias));

      FTablePipeline.Next;
    end;

end; {procedure, GetTableNames}


{@TppDataDictionary.GetTableAlias
 Given a list of selected tables, returns a list of table names and aliases of
 tables which could be joined with the selected tables.}

function TppDataDictionary.GetTableAlias(const aTableName: String): String;
begin

  Result := '';

  if not(TablesOpen) then Exit;

  FTablePipeline.First;

  if FTablePipeline.Locate(FTableFieldNames.TableName, aTableName, [pploCaseInsensitive]) then
    Result := FTablePipeline.GetFieldValue(FTableFieldNames.TableAlias);

end; {function, GetTableAlias}


{@TppDataDictionary.GetFieldAlias
 Given a table name and field name, returns the field alias found in the field
 entry table.

 Used by the Query Designer and Query Wizard to retrieve field aliases.}

function TppDataDictionary.GetFieldAlias(const aTableName, aFieldName: String): String;
var
  lsFieldNames: String;
begin

  Result := '';

  if not(FieldsOpen) then Exit;

  lsFieldNames := FFieldFieldNames.TableName + ';' + FFieldFieldNames.FieldName;

  FFieldPipeline.First;
  
  if FFieldPipeline.Locate(lsFieldNames, VarArrayOf([aTableName,aFieldName]), [pploCaseInsensitive]) then
    Result := FFieldPipeline.GetFieldValue(FFieldFieldNames.FieldAlias);

end; {function, GetFieldAlias}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetBuilderSettings }

procedure TppDataDictionary.SetBuilderSettings(aSettings: TppBasicDataSettings);
begin
  FBuilderSettings.Assign(aSettings);
end; {procedure, SetBuilderSettings}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetTableFieldNames }

procedure TppDataDictionary.SetTableFieldNames(aTableFieldNames: TppTableFieldNames);
begin
  FTableFieldNames.Assign(aTableFieldNames);
end; {procedure, SetTableFieldNames}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetJoinFieldNames }

procedure TppDataDictionary.SetJoinFieldNames(aJoinFieldNames: TppJoinFieldNames);
begin
  FJoinFieldNames.Assign(aJoinFieldNames);
end; {procedure, SetJoinFieldNames}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetFieldFieldNames }

procedure TppDataDictionary.SetFieldFieldNames(aFieldFieldNames: TppFieldFieldNames);
begin
  FFieldFieldNames.Assign(aFieldFieldNames);
end; {procedure, SetFieldFieldNames}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetJoinPipeline }

procedure TppDataDictionary.SetJoinPipeline(aDataPipeline: TppDataPipeline);
begin

  if (FJoinPipeline <> nil) then
    FJoinPipeline.RemoveNotify(Self);

  FJoinPipeline := aDataPipeline;

  if (FJoinPipeline <> nil) then
    FJoinPipeline.AddNotify(Self);

  if (csReading in ComponentState) or (csLoading in ComponentState) then Exit;

  FAutoJoin := (FJoinPipeline <> nil);

end; {procedure, SetJoinPipeline}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetTablePipeline }

procedure TppDataDictionary.SetTablePipeline(aDataPipeline: TppDataPipeline);
begin

  if (FTablePipeline <> nil) then
    FTablePipeline.RemoveNotify(Self);

  FTablePipeline := aDataPipeline;

  if (FTablePipeline <> nil) then
    FTablePipeline.AddNotify(Self);

end; {procedure, SetTablePipeline}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetFieldPipeline }

procedure TppDataDictionary.SetFieldPipeline(aDataPipeline: TppDataPipeline);
begin

  if (FFieldPipeline <> nil) then
    FFieldPipeline.RemoveNotify(Self);

  FFieldPipeline := aDataPipeline;

  if (FFieldPipeline <> nil) then
    FFieldPipeline.AddNotify(Self);

end; {procedure, SetFieldPipeline}

{------------------------------------------------------------------------------}
{ TppDataDictionary.TablesOpen }

function TppDataDictionary.TablesOpen: Boolean;
begin

  Result := False;

  if (FTablePipeline = nil) then Exit;

  if not(FTablePipeline.Active) then
    try
      FTablePipeline.Open;
    except {on EDatabaseError do}
      Exit;
    end;

  Result := True;

end; {function, TablesOpen}

{------------------------------------------------------------------------------}
{ TppDataDictionary.FieldsOpen }

function TppDataDictionary.FieldsOpen: Boolean;
begin

  Result := False;

  if (FFieldPipeline = nil) then Exit;

  if not(FFieldPipeline.Active) then
    try
      FFieldPipeline.Open;
    except {on EDatabaseError do}
      Exit;
    end;

  Result := True;

end; {function, FieldsOpen}

{------------------------------------------------------------------------------}
{ TppDataDictionary.JoinsOpen }

function TppDataDictionary.JoinsOpen: Boolean;
begin

  Result := False;

  if (FJoinPipeline = nil) then Exit;

  if not(FJoinPipeline.Active) then
    try
      FJoinPipeline.Open;
    except {on EDatabaseError do}
      Exit;
    end;

  Result := True;

end; {function, JoinsOpen}


{@TppDataDictionary.Open
 Opens the TablePipeline and FieldPipeline components and if AutoJoin is True,
 the JoinPipeline as well.}

procedure TppDataDictionary.Open;
begin
  FActive := True;

  CreateFields;
end; {procedure, Open}

{------------------------------------------------------------------------------}
{ TppDataDictionary.Close }

procedure TppDataDictionary.Close;
begin
  FreeFields;

  FActive := False;
end; {procedure, Close}


{@TppDataDictionary.Reset
 Closes and then reopens the pipelines assigned to the data dictionary.}

procedure TppDataDictionary.Reset;
begin
  Close;

  Open;
end; {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetActive }

procedure TppDataDictionary.SetActive(aValue: Boolean);
begin
  if (FActive = aValue) then Exit;

  if aValue then
    Open
  else
    Close;

end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TppDataDictionary.SetTableName }

procedure TppDataDictionary.SetTableName(const aName: String);
var
  lsName: String;
  lsTableName: String;
  lsExtension: String;
  lbFileBased: Boolean;
begin

  if (aName = FTableName) then Exit;

  if FActive then
    Close;

  lsName := aName;

  {remove owner name if necessary}
  if not(FUseTableOwnerName) then
    begin
      ppStripOffTableName(lsName, lsTableName, lsExtension, lbFileBased);

      if not(lbFileBased) then
        lsName := lsTableName;
    end;

  FTableName := lsName;

  FTableAlias := GetTableAlias(FTableName);

end; {procedure, SetTableName}

{------------------------------------------------------------------------------}
{ TppDataDictionary.FreeFields }

procedure TppDataDictionary.FreeFields;
var
  liIndex: Integer;
begin
  for liIndex := 0 to FFieldList.Count - 1 do
    TppField(FFieldList.Objects[liIndex]).Free;

  FFieldList.Clear;
end; {procedure, FreeFields}

{------------------------------------------------------------------------------}
{ TppDataDictionary.GetField }

function TppDataDictionary.GetField(Index: Integer): TppField;
begin
  if not(FActive) then Open;

  Result := TppField(FFieldList.Objects[Index]);
end; {function, GetField}

{------------------------------------------------------------------------------}
{ TppDataDictionary.GetFieldCount }

function TppDataDictionary.GetFieldCount: Integer;
begin
  if not(FActive) then Open;

  Result := FFieldList.Count;
end; {function, GetFieldCount}


{@TppDataDictionary.FieldForFieldName
 Given a raw field name, returns the corresponding TppField object.}

function TppDataDictionary.FieldForFieldName(const aFieldName: String): TppField;
var
  liField: Integer;
  lsKey: String;
begin
  if not(FActive) then Open;

  lsKey := Uppercase(FTableName) + Uppercase(aFieldName);

  liField := FFieldList.IndexOf(lsKey);

  if liField >= 0 then
    Result := Fields[liField]
  else
    Result := nil;

end; {function, FieldForFieldName}


{@TppDataDictionary.FindField
 Given a TppField object, returns the corresponding position in the Fields array
 property.}

function TppDataDictionary.FindField(aField: TppField): Integer;
begin
  if not(FActive) then Open;

  Result := FFieldList.IndexOfObject(aField);
end; {function, FindField}

{------------------------------------------------------------------------------}
{ TppDataDictionary.AddField }

function TppDataDictionary.AddField(aField: TppField): Integer;
var
  lsKey: String;
begin
  lsKey := Uppercase(FTableName) + Uppercase(aField.FieldName);

  Result := FFieldList.AddObject(lsKey, aField);
end; {function, AddField}

{------------------------------------------------------------------------------}
{ TppDataDictionary.CreateFields }

procedure TppDataDictionary.CreateFields;
var
  lField: TppField;
  lDataType: Variant;
begin

  if not(TablesOpen) then Exit;

  if not(FieldsOpen) then Exit;

  {must goto first record}
  FFieldPipeline.First;

  {create field maps}
  while not(FFieldPipeline.EOF) do
    begin

      if (CompareText(FFieldPipeline.GetFieldValue(FFieldFieldNames.TableName), TableName) = 0) then
        begin
          lField := TppField.Create(nil);

          lField.Name := lField.GetValidName(lField);
          lField.TableAlias  := TableAlias;
          lField.TableName   := TableName;

          lField.FieldName   := FFieldPipeline.GetFieldValue(FFieldFieldNames.FieldName);
          lField.FieldAlias  := FFieldPipeline.GetFieldValue(FFieldFieldNames.FieldAlias);
          lField.Selectable  := ppStringFieldValueToBoolean(FFieldPipeline.GetFieldValue(FFieldFieldNames.Selectable));
          lField.Searchable  := ppStringFieldValueToBoolean(FFieldPipeline.GetFieldValue(FFieldFieldNames.Searchable));
          lField.Sortable    := ppStringFieldValueToBoolean(FFieldPipeline.GetFieldValue(FFieldFieldNames.Sortable));
          lField.AutoSearch  := ppStringFieldValueToBoolean(FFieldPipeline.GetFieldValue(FFieldFieldNames.AutoSearch));
          lField.Mandatory   := ppStringFieldValueToBoolean(FFieldPipeline.GetFieldValue(FFieldFieldNames.Mandatory));

          {convert the data type to an enumerated type}
          lDataType := FFieldPipeline.GetFieldValue(FFieldFieldNames.DataType);

          if not(VarIsNull(lDataType)) and (Length(lDataType) <> 0) then
            lField.DataType := TppDataType(ppGetEnumValue(TypeInfo(TppDataType), lDataType));

          AddField(lField);
        end;

      FFieldPipeline.Next;
    end;

end; {function, CreateFields}


{@TppDataDictionary.AppendTableRecord
 Creates a table entry in the data dictionary.

 Note: This routine is used to populate the data dictionary before it is used
 for the first time. Once you've populated the data dictionary, you won't need
 to call this routine again.

 The simplest way to populate the data dictionary tables is to use the Data
 Dictionary Builder.}

procedure TppDataDictionary.AppendTableRecord(const aTableName, aTableAlias: String);
begin

  if not(TablesOpen) then Exit;

  FTablePipeline.Insert;

  FTablePipeline.SetFieldValue(FTableFieldNames.TableName, aTableName);
  FTablePipeline.SetFieldValue(FTableFieldNames.TableAlias, aTableAlias);

  FTablePipeline.Post;

end; {procedure, AppendTableRecord}


{@TppDataDictionary.AppendFieldRecord
 Creates a field entry in the data dictionary.

 Note: This routine is used to populate the data dictionary before it is used
 for the first time. Once you've populated the data dictionary, you won't need
 to call this routine again.

 The simplest way to populate the data dictionary tables is to use the Data
 Dictionary Builder.}

procedure TppDataDictionary.AppendFieldRecord(const aTableName, aFieldName, aFieldAlias,
                                              aSelectable, aSearchable, aSortable, aAutoSearch, aDataType: String);
begin

  if not(FieldsOpen) then Exit;

  FFieldPipeline.Insert;

  FFieldPipeline.SetFieldValue(FFieldFieldNames.TableName, aTableName);

  FFieldPipeline.SetFieldValue(FFieldFieldNames.FieldName, aFieldName);

  if (aFieldAlias = '') then
    FFieldPipeline.SetFieldValue(FFieldFieldNames.FieldAlias, aFieldName)
  else
    FFieldPipeline.SetFieldValue(FFieldFieldNames.FieldAlias, aFieldAlias);

  FFieldPipeline.SetFieldValue(FFieldFieldNames.Selectable, aSelectable);
  FFieldPipeline.SetFieldValue(FFieldFieldNames.Searchable, aSearchable);
  FFieldPipeline.SetFieldValue(FFieldFieldNames.Sortable, aSortable);

  FFieldPipeline.SetFieldValue(FFieldFieldNames.AutoSearch, aAutoSearch);
  FFieldPipeline.SetFieldValue(FFieldFieldNames.DataType, aDataType);

  FFieldPipeline.Post;

end; {procedure, AppendFieldRecord}


{@TppDataDictionary.AppendJoinRecord
 Creates a join entry in the data dictionary.

 Note: This routine is used to populate the data dictionary before it is used
 for the first time. Once you've populated the data dictionary, you won't need
 to call this routine again.

 The simplest way to populate the data dictionary tables is to use the Data
 Dictionary Builder.}

procedure TppDataDictionary.AppendJoinRecord(const aTableName1, aTableName2, aJoinType: String;
                                             aFieldNames1, aFieldNames2, aOperators: TStrings);
begin

  if not(JoinsOpen) then Exit;

  FJoinPipeline.Insert;

  FJoinPipeline.SetFieldValue(FJoinFieldNames.TableName1, aTableName1);
  FJoinPipeline.SetFieldValue(FJoinFieldNames.TableName2, aTableName2);
  FJoinPipeline.SetFieldValue(FJoinFieldNames.JoinType, aJoinType);
  FJoinPipeline.SetFieldValue(FJoinFieldNames.FieldNames1, ppCombineStrings(aFieldNames1));
  FJoinPipeline.SetFieldValue(FJoinFieldNames.FieldNames2, ppCombineStrings(aFieldNames2));
  FJoinPipeline.SetFieldValue(FJoinFieldNames.Operators, ppCombineStrings(aOperators));

  FJoinPipeline.Post;
  
end; {procedure, AppendJoinRecord}


{******************************************************************************
 *
 ** B A S I C   D A T A   S E T T I N G S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.Create }

constructor TppBasicDataSettings.Create(aParent: TppCommunicator);
begin

  inherited Create;

  FActive := True;
  FDatabaseName := '';
  FSessionType := 'BDESession';
  FOnChange := nil;
  FParent := aParent;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.Assign }

procedure TppBasicDataSettings.Assign(Source: TPersistent);
var
  lSourceSettings: TppBasicDataSettings;
begin

  if (Source is TppBasicDataSettings) then
    begin
      FActive := False;

      lSourceSettings := TppBasicDataSettings(Source);

      FDatabaseName := lSourceSettings.DatabaseName;
      FSessionType := lSourceSettings.SessionType;

      FActive := True;
    end;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.IsActive }

function TppBasicDataSettings.IsActive: Boolean;
begin

  Result := False;

  if (Parent = nil) then Exit;

  if (csReading in Parent.ComponentState) or (csLoading in Parent.ComponentState) then Exit;

  if (csDestroying in Parent.ComponentState) then Exit;

  Result := FActive;

end;  {function, IsActive}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.DoOnChange }

procedure TppBasicDataSettings.DoOnChange;
begin

  if not(IsActive) then Exit;

  if Assigned(FOnChange) then FOnChange(Self);

end; {procedure, DoOnChange}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.SetDatabaseName }

procedure TppBasicDataSettings.SetDatabaseName(aDatabaseName: TFileName);
begin

  FDatabaseName := aDatabaseName;

  DoOnChange;

end; {procedure, SetDatabaseName}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.SetSessionType }

procedure TppBasicDataSettings.SetSessionType(aSessionType: String);
begin

  FSessionType := aSessionType;

  if not(IsActive) then Exit;

  FDatabaseName := '';

  DoOnChange;

end; {procedure, SetSessionType}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.LoadStateInfo }

procedure TppBasicDataSettings.LoadStateInfo(aIniStorage: TppIniStorage; aDataModule: TppCommunicator);
begin
  FDatabaseName := aIniStorage.ReadString('DataAccess', 'DatabaseName',  'DBDEMOS');
  FSessionType  := aIniStorage.ReadString('DataAccess', 'SessionType',   'BDESession');

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppBasicDataSettings.SaveStateInfo }

procedure TppBasicDataSettings.SaveStateInfo(aIniStorage: TppIniStorage);
begin
  aIniStorage.WriteString('DataAccess',  'DatabaseName',  FDatabaseName);
  aIniStorage.WriteString('DataAccess',  'SessionType',   FSessionType);

end; {procedure, SaveStateInfo}

{******************************************************************************
 *
 ** D A T A   S E T T I N G S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDataSettings.Create }

constructor TppDataSettings.Create(aParent: TppCommunicator);
begin

  inherited Create(aParent);

  FAllowEditSQL := False;
  FDatabaseType := dtParadox;
  FDataDictionary := nil;
  FCollationType := ctASCII;
  FGuidCollationType := gcString;
  FIsCaseSensitive := True;
  FNullCollationType := ncNullsFirst;
  FSQLType := sqBDELocal;
  FUseDataDictionary := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppDataSettings.Assign }

procedure TppDataSettings.Assign(Source: TPersistent);
var
  lSourceSettings: TppDataSettings;
begin

  if (Source is TppDataSettings) then
    begin
      FActive := False;

      lSourceSettings := TppDataSettings(Source);

      {copy basic settings props, since inherited is not called}
      FDatabaseName := lSourceSettings.DatabaseName;
      FDatabaseType := lSourceSettings.DatabaseType;
      FCollationType := lSourceSettings.CollationType;
      FGuidCollationType := lSourceSettings.GuidCollationType;
      FNullCollationType :=  lSourceSettings.FNullCollationType;
      FSessionType := lSourceSettings.SessionType;

      FAllowEditSQL := lSourceSettings.AllowEditSQL;
      SetDataDictionary(lSourceSettings.DataDictionary);
      FIsCaseSensitive := lSourceSettings.IsCaseSensitive;
      FSQLType := lSourceSettings.SQLType;
      FUseDataDictionary := lSourceSettings.UseDataDictionary;

      FActive := True;
    end;

  DoOnChange;

end; {procedure, Assign}

{------------------------------------------------------------------------------}
{ TppDataSettings.EqualTo }

function TppDataSettings.EqualTo(aDataSettings: TppDataSettings): Boolean;
begin

  Result := (FDatabaseName = aDataSettings.FDatabaseName) and
            (FDatabaseType = aDataSettings.FDatabaseType) and
            (FCollationType = aDataSettings.FCollationType) and
            (FGuidCollationType = aDataSettings.FGuidCollationType) and
            (FNullCollationType = aDataSettings.FNullCollationType) and
            (FSessionType = aDataSettings.FSessionType) and
            (FAllowEditSQL = aDataSettings.FAllowEditSQL) and
            (FSQLType = aDataSettings.FSQLType) and
            (FIsCaseSensitive = aDataSettings.FIsCaseSensitive) and
            (FUseDataDictionary = aDataSettings.FUseDataDictionary);

end; {function, EqualTo}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetDataDictionary }

procedure TppDataSettings.SetDataDictionary(aDataDictionary: TppDataDictionary);
begin

  if (FDataDictionary <> nil) and (FParent <> nil) then
    FParent.RemoveNotify(FDataDictionary);

  FDataDictionary := aDataDictionary;

  if (FDataDictionary <> nil) and (FParent <> nil) then
    FParent.AddNotify(FDataDictionary);

end; {procedure, SetDataDictionary}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetAllowEditSQL }

procedure TppDataSettings.SetAllowEditSQL(aValue: Boolean);
begin

  FAllowEditSQL := aValue;

  DoOnChange;

end; {procedure, SetAllowEditSQL}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetCollationType }

procedure TppDataSettings.SetCollationType(aCollationType: TppCollationType);
begin

  FCollationType := aCollationType;

  DoOnChange;

end; {procedure, SetCollationType}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetGuidCollationType }

procedure TppDataSettings.SetGuidCollationType(aGuidCollationType: TppGuidCollationType);
begin

  FGuidCollationType := aGuidCollationType;

  DoOnChange;

end; {procedure, SetCollationType}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetDatabaseType }

procedure TppDataSettings.SetDatabaseType(aDatabaseType: TppDatabaseType);
begin

  FDatabaseType := aDatabaseType;

  if not(IsActive) then Exit;

  {set database defaults}
  FCollationType := GetDefaultCollationType(aDatabaseType);
  FGuidCollationType := GetDefaultGuidCollationType(aDatabaseType);
  FNullCollationType := GetDefaultNullCollationType(aDatabaseType);
  FIsCaseSensitive := GetDefaultIsCaseSensitive(aDatabaseType);

  DoOnChange;

end; {procedure, SetDatabaseType}

{------------------------------------------------------------------------------}
{ TppDataSettings.GetDefaultCollationType }

function TppDataSettings.GetDefaultCollationType(aDatabaseType: TppDatabaseType): TppCollationType;
begin

  case aDatabaseType of
    dtAdvantage:   Result := ctASCII;
    dtParadox:     Result := ctASCII;
    dtInterBase:   Result := ctASCII;
    dtMSAccess:    Result := ctANSI;
    dtMSSQLServer: Result := ctANSI;
    dtSybaseASA:   Result := ctANSI;
    dtSybaseASE:   Result := ctANSI;
    dtOracle:      Result := ctANSI;
    dtPostgreSQL:  Result := ctASCII;
    else
      Result := ctANSI;
  end;

end; {procedure, GetDefaultCollationType}

{------------------------------------------------------------------------------}
{ TppDataSettings.GetDefaultGuidCollationType }

function TppDataSettings.GetDefaultGuidCollationType(aDatabaseType: TppDatabaseType): TppGuidCollationType;
begin

  case aDatabaseType of
    dtMSSQLServer: Result := gcMSSQLServer;
    dtMSAccess: Result := gcMSAccess;
  else
    Result := gcString;
  end;

end; {procedure, GetDefaultGuidCollationType}

{------------------------------------------------------------------------------}
{ TppDataSettings.GetDefaultNullCollationType }

function TppDataSettings.GetDefaultNullCollationType(aDatabaseType: TppDatabaseType): TppNullCollationType;
begin

  if (aDatabaseType = dtOracle) then
    Result := ncNullsLast
  else
    Result := ncNullsFirst;

end; {procedure, GetDefaultGuidCollationType}

{------------------------------------------------------------------------------}
{ TppDataSettings.GetDefaultIsCaseSensitive }

function TppDataSettings.GetDefaultIsCaseSensitive(aDatabaseType: TppDatabaseType): Boolean;
begin

  case aDatabaseType of
    dtAdvantage:   Result := False;
    dtParadox:     Result := True;
    dtInterBase:   Result := False;
    dtMSAccess:    Result := False;
    dtMSSQLServer: Result := False;
    dtSybaseASA:   Result := False;
    dtSybaseASE:   Result := False;
    dtOracle:      Result := False;
    dtPostgreSQL:  Result := True;
    else
      Result := False;
  end;

end; {procedure, GetDefaultIsCaseSensitive}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetIsCaseSensitive }

procedure TppDataSettings.SetIsCaseSensitive(aValue: Boolean);
begin

  FIsCaseSensitive := aValue;

  DoOnChange;

end; {procedure, SetIsCaseSensitive}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetSQLType }

procedure TppDataSettings.SetSQLType(aSQLType: TppSQLType);
begin

  FSQLType := aSQLType;

  DoOnChange;

end; {procedure, SetSQLType}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetUseDataDictionary }

procedure TppDataSettings.SetUseDataDictionary(aValue: Boolean);
begin

  FUseDataDictionary := aValue;

  DoOnChange;

end; {procedure, SetUseDataDictionary}

{------------------------------------------------------------------------------}
{ TppDataSettings.SetSessionType }

procedure TppDataSettings.SetSessionType(aSessionType: String);
begin

  if (SessionType = aSessionType) then Exit;

  {assign basic setting props, since inherited is not called}
  FSessionType := aSessionType;

  if not(IsActive) then Exit;

  FDatabaseName := '';

  {set default SQlType}
  if (FSessionType <> 'BDESession') and (FSQLType = sqBDELocal) then
    FSQLType := sqSQL1;

  DoOnChange;
  
end; {procedure, SetSessionType}

{------------------------------------------------------------------------------}
{ TppDataSettings.LoadStateInfo }

procedure TppDataSettings.LoadStateInfo(aIniStorage: TppIniStorage; aDataModule: TppCommunicator);
var
  lsDataDictionary: String;
  lDataDictList: TppCommunicatorPickList;
  liIndex: Integer;
begin

  inherited LoadStateInfo(aIniStorage, aDataModule);

  FDatabaseType := TppDatabaseType(aIniStorage.ReadInteger('DataAccess', 'DatabaseType',  Ord(dtParadox)));
  FCollationType := TppCollationType(aIniStorage.ReadInteger('DataAccess', 'CollationType',  Ord(ctANSI)));
  FSQLType := TppSQLType(aIniStorage.ReadInteger('DataAccess', 'SQLType', Ord(sqBDELocal)));
  FAllowEditSQL := aIniStorage.ReadBool('DataAccess', 'AllowEditSQL', True);
  FIsCaseSensitive := aIniStorage.ReadBool('DataAccess', 'IsCaseSensitive', False);
  FUseDataDictionary := aIniStorage.ReadBool('DataAccess', 'UseDataDictionary', False);
  FGuidCollationType := TppGuidCollationType(aIniStorage.ReadInteger('DataAccess', 'GuidCollationType',  Ord(FGuidCollationType)));
  FNullCollationType := TppNullCollationType(aIniStorage.ReadInteger('DataAccess', 'NullCollationType',  Ord(FNullCollationType)));

  lsDataDictionary := aIniStorage.ReadString('DataAccess', 'DataDictionary',  '');

  if lsDataDictionary = '' then
    FDataDictionary := nil
  else
    begin
      lDataDictList := TppCommunicatorPickList.Create(aDataModule, TppDataDictionary);
      liIndex := lDataDictList.IndexOf(lsDataDictionary);
      if liIndex >= 0 then
        FDataDictionary := TppDataDictionary(lDataDictList.Objects[liIndex])
      else
        FDataDictionary := nil;

      lDataDictList.Free;  
    end;

end; {procedure, LoadStateInfo}

{------------------------------------------------------------------------------}
{ TppDataSettings.SaveStateInfo }

procedure TppDataSettings.SaveStateInfo(aIniStorage: TppIniStorage);
begin

  inherited SaveStateInfo(aIniStorage);

  aIniStorage.WriteInteger('DataAccess', 'CollationType',     Ord(FCollationType));
  aIniStorage.WriteInteger('DataAccess', 'DatabaseType',      Ord(FDatabaseType));
  aIniStorage.WriteInteger('DataAccess', 'SQLType',           Ord(FSQLType));
  aIniStorage.WriteInteger('DataAccess',    'GuidCollationType', Ord(FGuidCollationType));
  aIniStorage.WriteInteger('DataAccess',    'NullCollationType', Ord(FNullCollationType));
  aIniStorage.WriteBool('DataAccess',    'AllowEditSQL',      FAllowEditSQL);
  aIniStorage.WriteBool('DataAccess',    'IsCaseSensitive',   FIsCaseSensitive);
  aIniStorage.WriteBool('DataAccess',    'UseDataDictionary', FUseDataDictionary);

  if FDataDictionary <> nil then
    aIniStorage.WriteString('DataAccess', 'DataDictionary', FDataDictionary.UserName);

end; {procedure, SaveStateInfo}


{------------------------------------------------------------------------------}
{ TppDataDictionary.SetNullCollationType }

procedure TppDataSettings.SetNullCollationType(const Value: TppNullCollationType);
begin

  FNullCollationType := Value;

  DoOnChange;

end;

{------------------------------------------------------------------------------}
{ TppDataDictionary.ValidSettings }

function TppDataDictionary.ValidSettings: Boolean;
var
  lFieldPropertyLists: TList;
  lFieldNameLists: TList;
  lPipelines: TStrings;
  lFieldNames: TStrings;
  lFieldProperties: TStrings;
  liIndex: Integer;
  lDataPipeline: TppDataPipeline;
  lsPropertyName: String;
begin

  Result := True;

  lPipelines := TStringList.Create;
  lFieldPropertyLists := TList.Create;
  lFieldNameLists := TList.Create;


  lPipelines.AddObject('TablePipeline', FTablePipeline);

  lFieldProperties := TStringList.Create;
  lFieldProperties.Add('TableName');
  lFieldProperties.Add('TableAlias');
  lFieldPropertyLists.Add(lFieldProperties);

  lFieldNames := TStringList.Create;
  lFieldNames.Add(FTableFieldNames.TableName);
  lFieldNames.Add(FTableFieldNames.TableAlias);
  lFieldNameLists.Add(lFieldNames);


  lPipelines.AddObject('FieldPipeline', FFieldPipeline);

  lFieldProperties := TStringList.Create;
  lFieldProperties.Add('AutoSearch');
  lFieldProperties.Add('DataType');
  lFieldProperties.Add('FieldAlias');
  lFieldProperties.Add('FieldName');
  lFieldProperties.Add('Mandatory');
  lFieldProperties.Add('Searchable');
  lFieldProperties.Add('Selectable');
  lFieldProperties.Add('Sortable');
  lFieldProperties.Add('TableName');
  lFieldPropertyLists.Add(lFieldProperties);

  lFieldNames := TStringList.Create;
  lFieldNames.Add(FFieldFieldNames.AutoSearch);
  lFieldNames.Add(FFieldFieldNames.DataType);
  lFieldNames.Add(FFieldFieldNames.FieldAlias);
  lFieldNames.Add(FFieldFieldNames.FieldName);
  lFieldNames.Add(FFieldFieldNames.Mandatory);
  lFieldNames.Add(FFieldFieldNames.Searchable);
  lFieldNames.Add(FFieldFieldNames.Selectable);
  lFieldNames.Add(FFieldFieldNames.Sortable);
  lFieldNames.Add(FFieldFieldNames.TableName);
  lFieldNameLists.Add(lFieldNames);


  if (FAutoJoin) then
    begin
      lPipelines.AddObject('JoinPipeline', FJoinPipeline);

      lFieldProperties := TStringList.Create;
      lFieldProperties.Add('FieldNames1');
      lFieldProperties.Add('FieldNames2');
      lFieldProperties.Add('JoinType');
      lFieldProperties.Add('Operators');
      lFieldProperties.Add('TableName1');
      lFieldProperties.Add('TableName2');
      lFieldPropertyLists.Add(lFieldProperties);

      lFieldNames := TStringList.Create;
      lFieldNames.Add(FJoinFieldNames.FieldNames1);
      lFieldNames.Add(FJoinFieldNames.FieldNames2);
      lFieldNames.Add(FJoinFieldNames.JoinType);
      lFieldNames.Add(FJoinFieldNames.Operators);
      lFieldNames.Add(FJoinFieldNames.TableName1);
      lFieldNames.Add(FJoinFieldNames.TableName2);
      lFieldNameLists.Add(lFieldNames);
    end;

  liIndex := 0;

  while (Result) and (liIndex < lPipelines.Count) do
    begin
      lDataPipeline := TppDataPipeline(lPipelines.Objects[liIndex]);
      lsPropertyName := lPipelines[liIndex];

      lFieldProperties := TStringList(lFieldPropertyLists[liIndex]);
      lFieldNames := TStringList(lFieldNameLists[liIndex]);

      if not(ValidDataPipeline(lDataPipeline, lsPropertyName)) or
         not(ValidDataPipelineFields(lDataPipeline, lsPropertyName, lFieldProperties, lFieldNames)) then
        Result := False
      else
        Inc(liIndex);
    end;

  for liIndex := 0 to lFieldPropertyLists.Count - 1 do
    TStringList(lFieldPropertyLists[liIndex]).Free;

  for liIndex := 0 to lFieldNameLists.Count - 1 do
    TStringList(lFieldNameLists[liIndex]).Free;

  lFieldPropertyLists.Free;
  lFieldNameLists.Free;
  lPipelines.Free;

end; {function, ValidSettings}

{------------------------------------------------------------------------------}
{ TppDataDictionary.ValidDataPipeline }

function TppDataDictionary.ValidDataPipeline(aDataPipeline: TppDataPipeline; const aPropertyName: String): Boolean;
begin

  Result := True;

  if (aDataPipeline <> nil) then
    begin

      try
        aDataPipeline.Open;
      except
        FErrorMessage := ppLoadStr(682); {'DataDictionary.<name> ''<name>'' could not be opened.'}
        FErrorMessage := ppSetMessageParameters(FErrorMessage);
        FErrorMessage := Format(FErrorMessage, [aPropertyName, aDataPipeline.Name]);

        Result := False;
      end;

      if Result and not(aDataPipeline.Active) then
        begin
          FErrorMessage := ppLoadStr(682); {'DataDictionary.<name> ''<name>'' could not be opened.'}
          FErrorMessage := ppSetMessageParameters(FErrorMessage);
          FErrorMessage := Format(FErrorMessage, [aPropertyName, aDataPipeline.Name]);

          Result := False;
        end;
    end

  else
    begin
      FErrorMessage := ppLoadStr(683); {'DataDictionary.<name> property is not assigned.'};
      FErrorMessage := ppSetMessageParameters(FErrorMessage);
      FErrorMessage := Format(FErrorMessage, [aPropertyName]);

      Result := False;
    end;

end; {function, ValidDataPipeline}

{------------------------------------------------------------------------------}
{ TppDataDictionary.ValidDataPipelineFields }

function TppDataDictionary.ValidDataPipelineFields(aDataPipeline: TppDataPipeline; const aPropertyName: String;
                                                   aFieldProperties, aFieldNames: TStrings): Boolean;
var
  lFieldNames: TStringList;
  liIndex: Integer;
  lsFieldName: String;
  lsFieldPropertyName: String;
begin

  Result := True;

  lFieldNames := TStringList.Create;

  aDataPipeline.GetFieldNames(lFieldNames);

  liIndex := 0;

  while Result and (liIndex < aFieldNames.Count) do
    begin
      lsFieldName := aFieldNames[liIndex];
      lsFieldPropertyName := aFieldProperties[liIndex];

      if (lFieldNames.IndexOf(lsFieldName) = -1) then
        begin
          FErrorMessage := ppLoadStr(684); {'<name>.<name> field: ''<name>'' could not be found.'}
          FErrorMessage := ppSetMessageParameters(FErrorMessage);
          FErrorMessage := Format(FErrorMessage, [aPropertyName, lsFieldPropertyName, lsFieldName]);

          Result := False;
        end
      else
        Inc(liIndex);
    end;

  lFieldNames.Free;

end; {function, ValidDataPipelineFields}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppDataDictionary]);

finalization

  UnRegisterClasses([TppDataDictionary]);

end.
