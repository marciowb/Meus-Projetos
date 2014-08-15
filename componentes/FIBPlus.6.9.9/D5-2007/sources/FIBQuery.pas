{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

unit FIBQuery;


interface

{$I FIBPlus.inc}

uses
  SysUtils, Classes, ibase,IB_Intf, IB_Externals,
  DB, fib, FIBDatabase, StdFuncs,IB_ErrorCodes,SqlTxtRtns,pFIBProps,
  pFIBInterfaces, 
 {$IFDEF SUPPORT_ARRAY_FIELD}   pFIBArray,  {$ENDIF}
 {$IFDEF WINDOWS}
   Windows {$IFDEF D6+},FMTBcd,  Variants{$ENDIF}
   ;
 {$ENDIF}
 {$IFDEF LINUX}
   Types, FMTBcd , Variants;
 {$ENDIF}

type
  (*Stream Events*)
  TCallBackBlobReadWrite= procedure(BlobSize:integer; BytesProcessing:integer; var Stop:boolean) of object;

  TFIBQuery = class;
  TFIBXSQLDA = class;
  TFIBXSQLVAR = class;

  TExtDescribeSQLVar =
  record
   sql_relation_alias: array[0..LENGTH_METANAMES-1] of Char;
  end;



  TTypeSetToParam =(tspNull,tspIsNullable,tspScale, tspValue,tspSqlVar);
 
  (* TFIBXSQLVAR *)
  TFIBXSQLVAR = class(TObject)
  private
    function  GetAsBoolean: boolean;
    procedure SetAsBoolean(const Value: boolean);
  protected
    FIndex: Integer;
    FModified: Boolean;
    FName: string;
    FQuery: TFIBQuery;
    FVariantFalse,
    FVariantTrue: Variant;
    FXSQLVAR: PXSQLVAR;       // Point to the PXSQLVAR in the owner object
    FParent : TFIBXSQLDA;
// Added variables
    FIsMacro :boolean;
    FQuoted  :boolean;
    FOldValue:Variant; // Value Param from last ExecQuery
    FDefMacroValue :string;
    FSrvSQLType    :integer;
    FSrvSQLSubType :integer;
    FSrvSQLLen     :Smallint;
    FSrvSQLScale   :Smallint;
    FInWhereClause :boolean;
    FCanForceIsNull:boolean;
    FInitialized   :boolean;
    FBeginPosInText:integer;
    FEndPosInText  :integer;
    FIsDefferedSetting:boolean;
    FStreamValue   :TMemoryStream;
    FWideTempValue :WideString;
 {$IFDEF SUPPORT_ARRAY_FIELD}
    vFIBArray:TpFIBArray;
 {$ENDIF}
 
    function AdjustScale(Value: Int64; Scale: Integer): Double; {$IFDEF D6+} deprecated; {$ENDIF}
    function AdjustScaleToCurrency(Value: Int64; Scale: Integer): Currency; {$IFDEF D6+} deprecated;{$ENDIF}
    function AdjustScaleToInt64(Value: Int64; Scale: Integer): Int64;{$IFDEF D6+} deprecated;{$ENDIF}
    function GetAsInt64: Int64;
 
    function GetAsCurrency: Currency;
 {$IFNDEF NO_USE_COMP}
    function GetAsComp: Comp;
 {$ENDIF}    
    function GetAsDateTime: TDateTime;
    function GetAsTimeStamp: TTimeStamp;
    function GetAsDouble: Double;
    function GetAsFloat: Double;
    function GetAsSingle: Float;
    function GetAsLong: Long;
    function GetAsPointer: Pointer;
    function GetAsQuad: TISC_QUAD;
    function GetAsShort: Short;
    function GetAsString: string;
    function GetAsVariant:  Variant;
    function GetAsExtended: Extended;
    function GetAsXSQLVAR: PXSQLVAR;
    function GetIsNull: Boolean;
    function GetIsNullable: Boolean;
    function GetSize: Integer;
    function GetSQLType: Integer;
    function GetServerSQLType:Integer;
    function GetSQLSubtype: Short;
    function GetServerSQLSubType:Integer;
    function GetServerSQLSize:Integer;
    function GetServerSQLScale:Integer;    
//  Array Support
 {$IFDEF SUPPORT_ARRAY_FIELD}
    procedure CheckArrayType;
    function GetDimensionCount:Integer;
    function GetDimension(Index: Integer): TISC_ARRAY_BOUND;
    function GetSliceSize:integer;
    function GetElementType:TFieldType;
    function GetArraySize:integer;
  {$ENDIF}
//
    procedure SetValue(aSQLType,aSize:integer;ValueType:TTypeSetToParam;const aValue);

    procedure SetAsCurrency(aValue: Currency);
 {$IFNDEF NO_USE_COMP}
    procedure SetAsComp(aValue: comp); //patchInt64A
{$ENDIF}
    procedure SetAsInt64(aValue: Int64);
    procedure SetAsDateTime(aValue: TDateTime);
    procedure SetAsTime(aValue: TDateTime);
    procedure SetAsDate(aValue: TDateTime);
    procedure SetAsTimeStamp(aValue: TTimeStamp);
    procedure SetAsDouble(aValue: Double);
    procedure SetAsFloat(aValue: Double);
    procedure SetAsSingle(aValue: Float);
    procedure SetAsExtended(aValue: Extended);

    procedure SetAsLong(aValue: Long);
    procedure SetAsQuad(aValue: TISC_QUAD);
    procedure SetAsShort(aValue: Short);
    procedure InternalSetAsString(aValue:Pointer; IsWide:boolean; AdjustDeffered:boolean=False);
    procedure SetAsString(const aValue: string);
    procedure SetAsWideString(const aValue: WideString);
    function  GetAsWideString:WideString;
 
    procedure SetAsVariant(Value: Variant);
 
    procedure SetAsXSQLVAR(aValue: PXSQLVAR);
    procedure SetIsNull(aValue: Boolean);
    procedure SetIsNullable(aValue: Boolean);
    function  GetScale: integer;

    procedure SetScale(Value: integer);
    function  GetAsBcd: TBcd;
    procedure SetAsBcd(Value: TBcd);

    function  GetAsGUID: TGUID;
    procedure SetAsGuid(aValue: TGUID);
    procedure SetSQLLen(A:SmallInt);
  public
    constructor Create(AParent: TFIBXSQLDA);
    destructor  Destroy; override;
    procedure   Assign(Source: TFIBXSQLVAR);
 

//    procedure SetSQLLen(A:SmallInt);

    function IsNumericType(SQLType:Integer):boolean;
    function IsRealType(SQLType:Integer):boolean;
    function IsDateTimeType(SQLType:Integer):boolean;

    procedure LoadFromFile(const FileName: string); overload;
    procedure LoadFromFile(const FileName: string;cb: TCallBackBlobReadWrite); overload;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string;cb: TCallBackBlobReadWrite=nil);
    procedure SaveToStream(Stream: TStream);
    procedure Clear;
    function  IsParam:boolean;
    function  IsBlob:boolean;
    function  SqlName:string;
    function  AliasName:string;
    function  RelationName:string;
    function  CharacterSet :string;
// Array Support
{$IFDEF SUPPORT_ARRAY_FIELD}
    function  IsArray:boolean;
    function  GetArrayElement(Indexes: array of Integer):Variant;
    function  GetArrayValues:Variant;
    procedure SetArrayValue(Value:Variant);
{$ENDIF}
    function  IsDefMacroValue :boolean;
    procedure SetDefMacroValue;
//

    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
 {$IFNDEF NO_USE_COMP}
    property AsComp: comp read GetAsComp write SetAsComp;
 {$ENDIF}
    property AsExtended: Extended read GetAsExtended write SetAsExtended;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsBcd: TBcd read GetAsBcd write SetAsBcd;
    property AsGuid:TGUID read GetAsGUID write SetAsGUID ;    
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsDate: TDateTime read GetAsDateTime write SetAsDate;
    property AsTime: TDateTime read GetAsDateTime write SetAsTime;
    property AsTimeStamp:TTimeStamp read GetAsTimeStamp write SetAsTimeStamp;
    property AsDouble: Double read GetAsDouble write SetAsDouble;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsSingle: Float read GetAsSingle write SetAsSingle;
    property AsInteger: Integer read GetAsLong write SetAsLong;
    property AsLong: Long read GetAsLong write SetAsLong;
    property AsPointer: Pointer read GetAsPointer ;
    property AsQuad: TISC_QUAD read GetAsQuad write SetAsQuad;
    property AsShort: Short read GetAsShort write SetAsShort;
    property AsString: string read GetAsString write SetAsString;
    property AsWideString: WideString read GetAsWideString write SetAsWideString;    
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property AsXSQLVAR: PXSQLVAR read GetAsXSQLVAR write SetAsXSQLVAR;
    property AsBoolean: boolean  read GetAsBoolean write SetAsBoolean;
    property Data: PXSQLVAR read FXSQLVAR write FXSQLVAR;
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property IsNullable: Boolean read GetIsNullable write SetIsNullable;
    property Scale: Integer read  GetScale write  SetScale;
    property Index: Integer read FIndex;
    property Modified: Boolean read FModified write FModified;
    property Name: string read FName;
    property Size: Integer read GetSize;
    property ServerSize: Integer read GetServerSQLSize;
    property SQLType: Integer read GetSQLType;
    property ServerSQLType: Integer read GetServerSQLType;
    property SQLSubtype:Short read GetSQLSubtype;
    property ServerSQLSubType: Integer read GetServerSQLSubType;    
    property Value: Variant read GetAsVariant write SetAsVariant;
    property OldValue: Variant read FOldValue;
    property VariantFalse: Variant read FVariantFalse write FVariantFalse;
    property VariantTrue: Variant read FVariantTrue write FVariantTrue;
// Added properties
    property IsMacro:boolean  read FIsMacro write FIsMacro;
    property Quoted :boolean  read FQuoted  write FQuoted;
    property DefMacroValue:string read FDefMacroValue write FDefMacroValue;
    property InWhereClause:boolean read FInWhereClause;
    property BeginPosInText:integer read FBeginPosInText;
    property EndPosInText  :integer read FEndPosInText;

//  Array Support
 {$IFDEF SUPPORT_ARRAY_FIELD}
    property FIBArray:TpFIBArray read vFIBArray;
    property DimensionCount:integer read GetDimensionCount;
    property Dimension[Index: Integer]: TISC_ARRAY_BOUND read GetDimension;
    property ElementType:TFieldType read GetElementType;
    property ArraySize:Integer read GetArraySize;
 {$ENDIF}

  end;

  TFIBXSQLVARArray = array[0..0] of TFIBXSQLVAR;
  PFIBXSQLVARArray = ^TFIBXSQLVARArray;

  (* TFIBXSQLVAR *)
  TFIBXSQLDA = class(TObject)
  private
    FEquelNames: TStringList;
    FCachedNames:TStringList;
    FCount: Integer;
    FHasDefferedSettings:Boolean;
    procedure AdjustDefferedSettings;
  protected
    FNames     : TStringList;
    FQuery: TFIBQuery;
    FSize: Integer;
    FXSQLDA: PXSQLDA;
    FXSQLVARs: PFIBXSQLVARArray; // array of FIBXQLVARs
    FIsParams: boolean;
    function   GetModified: Boolean;
    function   GetNames: string;
    function   GetRecordSize: Integer;
    function   GetXSQLDA: PXSQLDA;
    function   GetXSQLVAR(Idx: Integer): TFIBXSQLVAR;
    function   GetXSQLVARByName(const Idx: string): TFIBXSQLVAR;
    procedure  Initialize;
    procedure  SetCount(Value: Integer);
    procedure  AddName(const FieldName: string; Idx: Integer; Quoted:boolean);
    procedure  SetUnModifiedToVars;
  public
    constructor Create(aIsParams:boolean);
    destructor Destroy; override;
    procedure  ClearValues;
    function   FindParam(const aParamName: string): TFIBXSQLVAR;
    function   ParamByName(const aParamName: string): TFIBXSQLVAR;
    procedure  AssignValues(SourceSQLDA:TFIBXSQLDA);
    property AsXSQLDA: PXSQLDA read GetXSQLDA;
    property ByName[const Idx: string]: TFIBXSQLVAR read GetXSQLVARByName;
    property Count: Integer read FCount write SetCount;
    property Modified: Boolean read GetModified;
    property Names: string read GetNames;
    property RecordSize: Integer read GetRecordSize;
    property Vars[Idx: Integer]: TFIBXSQLVAR read GetXSQLVAR; default;
  end;
 
  (* TFIBBatch - basis for batch input and batch output objects. *)
  TBatchState = (bsNotPrepared,bsFileReady,bsInProcess,bsInError);
 
  TFIBBatch = class(TObject)
  protected
    FFilename: string;
    FColumns: TFIBXSQLDA;
    FParams : TFIBXSQLDA;
    FState  : TBatchState;
  public
    constructor Create;
    procedure ReadyStream; virtual; abstract;
    property  Columns: TFIBXSQLDA read FColumns;
    property  Filename: string read FFilename write FFilename;
    property  Params: TFIBXSQLDA read FParams;
    property  State : TBatchState read FState ;
  end;

  (* TFIBBatchInputStream - see FIBMiscellaneous for good examples. *)
  TFIBBatchInputStream = class(TFIBBatch)
  public
    function ReadParameters: Boolean; virtual; abstract;
  end;
  TFIBBatchInputStreamClass = class of TFIBBatchInputStream;

  (* TFIBBatchOutputStream - see FIBMiscellaneous for good examples. *)
  TFIBBatchOutputStream = class(TFIBBatch)
  public
    function WriteColumns: Boolean; virtual; abstract;
  end;

  TFIBBatchOutputStreamClass = class of TFIBBatchOutputStream;
 
  (* TFIBQuery *)
  TFIBSQLTypes = (SQLUnknown, SQLSelect, SQLInsert,
                   SQLUpdate, SQLDelete, SQLDDL,
                   SQLGetSegment, SQLPutSegment,
                   SQLExecProcedure, SQLStartTransaction,
                   SQLCommit, SQLRollback,
                   SQLSelectForUpdate, SQLSetGenerator,SQLSavePointOperation
                  );
 
  TOnSQLFetch  =procedure (RecordNumber:integer;   var StopFetching:boolean
  ) of object;

  TBatchOperation =(boInput,boOutput,boOutputToQuery);
  TBatchAction    =(baContinue,baStop,baSkip);
  TBatchErrorAction =(beFail, beAbort, beRetry,beIgnore);
 
  TOnBatching     =
   procedure(BatchOperation:TBatchOperation;RecNumber:integer;var BatchAction :TBatchAction)
   of object;

  TOnBatchError  =  procedure(E:EFIBError;var BatchErrorAction:TBatchErrorAction)   of object;


  TAllRowsAffected =
  record
    Updates: integer;
    Deletes: integer;
    Selects: integer;
    Inserts: integer;
  end;

  TQueryRunStateValues=(qrsInPrepare,qrsInExecute);
  TQueryRunState = set of TQueryRunStateValues;

  TFIBQuery = class(TComponent,ISQLObject)
  private
   FOnBatching:TOnBatching;
   FDoParamCheck:boolean;
   FParser:    TSQLParser;
   FTransactionEnding:TNotifyEvent;
   FTransactionEnded :TNotifyEvent;
   FBeforeExecute :TNotifyEvent;
   FAfterExecute  :TNotifyEvent;
{$IFDEF CSMonitor}
   FCSMonitorSupport: TCSMonitorSupport;
   procedure SetMonitorSupport(Value:TCSMonitorSupport);   
   function GetCSMonText: string;
{$ENDIF}   
   function GetSQLKind: TSQLKind;
  protected
    FBase: TFIBBase;
    FBOF,                          // At BOF?
    FEof,                          // At EOF
    FGoToFirstRecordOnExecute,     // Automatically position record on first record after executing
    FOpen,                         // Is a cursor open?
    FPrepared: Boolean;            // Has the query been prepared?
    FRecordCount: Integer;         // How many records have been read so far?
    FHandle: TISC_STMT_HANDLE;     // Once prepared, this accesses the SQL Query
 
    FOnSQLChanging: TNotifyEvent;  // Call this when the SQL is changing.
    FSQL: TStrings;                // SQL Query (by user)
    FParamCheck: Boolean;          // Check for parameters? (just like TQuery)
    FProcessedSQL: string;       // SQL Query (pre-processed for param labels)
    FSQLParams,                    // Any parameters to the query.
    FSQLRecord: TFIBXSQLDA;        // The current record
    FSQLType: TFIBSQLTypes;        // Select, update, delete, insert, create, alter, etc...
 
 
    FUserSQLParams:TFIBXSQLDA;
    FProcExecuted:boolean;
    FOnSQLFetch:TOnSQLFetch;
    FMacroChar :Char;
    vUserParamsCreated:boolean;
    FCountLockSQL:integer;
    FModifyTable:string;
    FOptions:TpFIBQueryOptions;
    vDiffParams:boolean;
    FOnlySrvParams :TStringList;
    FCallTime :Cardinal;
    FMacroChanged:boolean;
    FSQLTextChangeCount:integer;
    FHaveStreamParams:boolean;
    FQueryRunState:TQueryRunState;
    FCodePageApplied:boolean;
    FAutoCloseOnTransactionEnd:boolean;
  {$DEFINE FIB_INTERFACE}
   {$I FIBQueryPT.inc}
  {$UNDEF FIB_INTERFACE}
    procedure SaveStreamedParams;
    procedure ClearStreamedParams;    
    procedure SetParamCheck(Value:boolean);
    function  GetModifyTable:string;
    procedure DatabaseDisconnecting(Sender: TObject);
    function  GetDatabase: TFIBDatabase;
    function  GetDBHandle: PISC_DB_HANDLE;
    function  GetEOF: Boolean;
    function  GetFields(const Idx: Integer): TFIBXSQLVAR;
    function  GetFieldIndex(const FieldName: string): Integer;
    function  GetPlan: string;
    function  GetRecordCount: Integer;
    function  GetRowsAffected: Integer;
    function  GetAllRowsAffected: TAllRowsAffected ;
 
    function  GetSQLParams: TFIBXSQLDA;
    function  GetTransaction: TFIBTransaction;
    function  GetTRHandle: PISC_TR_HANDLE;
    procedure SetDatabase(Value: TFIBDatabase); virtual;
    procedure SetSQL(Value: TStrings);
    procedure SetMacroChar(Value:Char);
    procedure SetTransaction(Value: TFIBTransaction);
    procedure SQLChanging(Sender: TObject);
    procedure SQLChange(Sender: TObject);
    procedure DoTransactionEnding(Sender: TObject);
 // Added procedures
    procedure SaveRestoreValues(SQLDA:TFIBXSQLDA;IsSave:boolean);
 
    function  GetWhereClause(Index:Integer):string;
    procedure SetWhereClause(Index:Integer;const WhereClauseTxt:string);
    function  GetOrderString:string;
    procedure SetOrderString(const OrderTxt:string);

    function  GetGroupByString:string;
    procedure SetGroupByString(const GroupByTxt:string);
 
    function  GetFieldsClause:string;
    procedure SetFieldsClause(const NewFields:string);

    procedure PrepareUserParamsTypes;
    procedure StartStatisticExec(const stText:string);
    procedure EndStatisticExec(const stText:string);
    procedure DoStatisticPrepare(const stText:string);
 
    function  ParamsNotExist(const SQLText:string):boolean;
    procedure PreprocessSQL(const sSQL:string;IsUserSQL:boolean);
    procedure DoBeforeExecute;
    procedure DoAfterExecute;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Loaded;  override;
    property Handle: TISC_STMT_HANDLE read FHandle;         
  private
    FExtSQLDA:array of TExtDescribeSQLVar;
    procedure FillExtDescribeSQLVars;
    procedure ConvertSQLTextToCodePage;
  public
    function TableAliasForField(FieldIndex:integer):string; overload;
    function TableAliasForFieldByName(const aFieldName:string):string;
 {$IFNDEF BCB}
    function TableAliasForField(const aFieldName:string):string; overload;
 {$ENDIF}
  private
    FOnBatchError :TOnBatchError  ;
    FCursorName   :string;
  public
    function BatchInput(InputObject: TFIBBatchInputStream) :boolean;
    function BatchOutput(OutputObject: TFIBBatchOutputStream):boolean;
{$IFDEF WINDOWS}
    procedure BatchInputRawFile(const FileName:string);
    procedure BatchOutputRawFile(const FileName:string;Version:integer=1);
{$ENDIF}
    procedure BatchToQuery(ToQuery:TFIBQuery;Mappings:TStrings);
  public
    function  Call(ErrCode: ISC_STATUS; RaiseError: Boolean): ISC_STATUS;
    procedure CheckClosed(const OpName:string);// raise error if query is not closed.
    procedure CheckOpen(const OpName:string); // raise error if query is not open.
    procedure CheckValidStatement;   // raise error if statement is invalid.
    procedure Close;               // close the query.
    function  Current: TFIBXSQLDA;
    procedure ExecQuery; virtual;               // ExecQuery the query.
    procedure ExecuteImmediate;
{$IFDEF SUPPORT_IB2007}
    procedure ExecuteAsBatch; overload;
    procedure ExecuteAsBatch(const SQLs:array of string); overload;
{$ENDIF}    
    procedure FreeHandle;
    function  Next: TFIBXSQLDA;
    procedure Prepare;                  // Prepare the query.
 
    function FieldByName(const FieldName: string): TFIBXSQLVAR;
    function FindField(const FieldName: string): TFIBXSQLVAR;
    function FN(const FieldName: string): TFIBXSQLVAR;
 
    function  FieldByOrigin(const TableName,FieldName:string):TFIBXSQLVAR; //overload;
    function  SQLFieldName(const aFieldName:string):string;
{$IFDEF SUPPORT_ARRAY_FIELD}
    procedure PrepareArrayFields;
    procedure PrepareArraySqlVar(
      SqlVar:TFIBXSQLVAR;const RelName,aSQLName:string; IsField:boolean
    );
{$ENDIF}
    procedure SetParamValues(const ParamValues: array of Variant); overload;
    procedure SetParamValues(const ParamNames: string;ParamValues: array of Variant); overload;
    procedure ExecWP(const ParamValues: array of Variant); overload;
    procedure ExecWP(const ParamNames: string;ParamValues: array of Variant); overload;
                                           // Exec Query with ParamValues
    procedure ExecWPS(const ParamSources: array of ISQLObject); overload;
    procedure ExecWPS(ParamSource:ISQLObject; AllRecords:boolean=True); overload;

    procedure BeginModifySQLText;
    procedure EndModifySQLText;
    function  CountModifySQLText:integer;
    function  GetMainWhereIndex:integer;
    function  GetMainWhereClause :string;
    procedure SetMainWhereClause (const Value:string);
    function  IsProc :boolean; 
    function  ParamByName(const ParamName:string): TFIBXSQLVAR;
    function  FindParam  (const aParamName: string): TFIBXSQLVAR;
    procedure ApplyMacro;
    procedure RestoreMacroDefaultValues;
    function FieldCount:integer;
    function SQLDescribeInfo(InfoRequest:array of char):PXSQLDA;
    property Bof: Boolean read FBOF;
    property DBHandle: PISC_DB_HANDLE read GetDBHandle;
    property Eof: Boolean read GetEOF;
    property FldByName[const FieldName: string]: TFIBXSQLVAR read FieldByName;  default;
    property Fields[const Idx: Integer]: TFIBXSQLVAR read GetFields;
    property FieldIndex[const FieldName: string]: Integer read GetFieldIndex;
    property Open: Boolean read FOpen;
    property Params: TFIBXSQLDA read GetSQLParams;
    property Plan: string read GetPlan;
    property Prepared: Boolean read FPrepared;
    property RecordCount: Integer read GetRecordCount;
    property RowsAffected: Integer read GetRowsAffected;
    property AllRowsAffected: TAllRowsAffected read GetAllRowsAffected;
    property SQLType: TFIBSQLTypes read FSQLType;
    property TRHandle: PISC_TR_HANDLE read GetTRHandle;
    property ProcExecuted:boolean read FProcExecuted write FProcExecuted;
    property OnSQLFetch:TOnSQLFetch read FOnSQLFetch write FOnSQLFetch; // for internal use
    property OnlySrvParams:TStringList read FOnlySrvParams;
  protected
    FConditions:TConditions;
    procedure SetConditions(Value:TConditions);
  published
    property  Conditions: TConditions read FConditions write SetConditions;
  public
{ISQLObject}
    function  ParamCount:integer;
    function  ParamName(ParamIndex:integer):string;
    function  FieldName(FieldIndex:integer):string;
    function  FieldsCount:integer;
    function  FieldExist(const FieldName:string; var FieldIndex:integer):boolean;
    function  ParamExist(const ParamName:string; var ParamIndex:integer):boolean;
    function  FieldValue(const FieldName:string;Old:boolean):variant;   overload;
    function  FieldValue(const FieldIndex:integer;Old:boolean):variant; overload;
    function  ParamValue(const ParamName:string):variant;   overload;
    function  ParamValue(const ParamIndex:integer):variant; overload;
    procedure SetParamValue(const ParamIndex:integer; aValue:Variant);
    function  IEof:boolean;
    procedure INext;
 
{End ISQLObject}
 
 
 
    function  ReadySQLText(ForChangeExecSQL:boolean=True):string;
    property  SQLTextChangeCount:integer read FSQLTextChangeCount;
  private
    procedure SetPlanClause(const Value:string);
    function  GetPlanClause:string;
  public      
    procedure AssignProperties(Source: TFIBQuery);
    function  WhereClausesCount:integer;
    property  WhereClause[Index:integer]:string read GetWhereClause write SetWhereClause;
    property  MainWhereClause:string read GetMainWhereClause write SetMainWhereClause;
    property  IndexMainWhere:integer read GetMainWhereIndex;
    property  CursorName   :string read FCursorName write FCursorName;
    property  OrderClause:string read GetOrderString write SetOrderString;
    property  GroupByClause:string read GetGroupByString  write SetGroupByString;
    property  FieldsClause:string read GetFieldsClause  write SetFieldsClause;
    property  PlanClause:string read GetPlanClause write SetPlanClause;
    property  ModifyTable:string read GetModifyTable;
    property  CallTime :Cardinal read FCallTime;
    property  MacroChanged:boolean read  FMacroChanged;
    property  SQLKind:TSQLKind read GetSQLKind;
    property BeforeExecute:TNotifyEvent read FBeforeExecute write FBeforeExecute;
    property AfterExecute :TNotifyEvent read FAfterExecute  write FAfterExecute;

  published
    property Transaction: TFIBTransaction read GetTransaction write SetTransaction;
    property Database: TFIBDatabase read GetDatabase write SetDatabase    ;

    property GoToFirstRecordOnExecute: Boolean read FGoToFirstRecordOnExecute
                                               write FGoToFirstRecordOnExecute
                                               default True;
    property ParamCheck: Boolean read FParamCheck write SetParamCheck default True;
    property SQL: TStrings read FSQL write SetSQL;

 
    property OnSQLChanging: TNotifyEvent      read FOnSQLChanging write FOnSQLChanging;
    property Options      : TpFIBQueryOptions read FOptions write FOptions stored False;
    property OnBatching   : TOnBatching       read FOnBatching write FOnBatching ;
    property OnBatchError :TOnBatchError      read FOnBatchError write FOnBatchError;
    property TransactionEnding:TNotifyEvent   read FTransactionEnding write FTransactionEnding;
    property TransactionEnded :TNotifyEvent   read FTransactionEnded  write FTransactionEnded;
{$IFDEF CSMonitor}
    property CSMonitorSupport: TCSMonitorSupport read FCSMonitorSupport write SetMonitorSupport;
{$ENDIF}    
 
  end;
 
 
procedure BlobToStream (ModelVar:TFIBXSQLVAR; BlobID:TISC_QUAD;Stream: TStream);

const
   ExecProcPrefix ='EXECUTE ';
  //Statistic consts
   scPrepareCount   ='PrepareCount'  ;  
   scExecuteCount   ='ExecuteCount'  ;
   scSumTimeExecute ='SumTimeExecute';
   scAvgTimeExecute ='AvgTimeExecute';
   scMaxTimeExecute ='MaxTimeExecute';
   scLastTimeExecute='LastTimeExecute';
   scLastQuery      ='LastQueryName';

 
   fibGUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';
   chUnicodeFSS=3;

{$IFDEF SUPPORT_KOI8_CHARSET}
   chFBKOI8R=63;
   chFBKOI8U=64;
   CodePageKOI8R=20866;
   CodePageKOI8RU=21866;
{$ENDIF}

var DisableEncodingSQLText:boolean;
    TraceString:string;
implementation

uses
  FIBMiscellaneous,  StrUtil,
  IBBlobFilter, FIBConsts,FIBCloneComponents 
  //Added uses
{$IFNDEF NO_MONITOR}
  ,FIBSQLMonitor
{$ENDIF}
{$IFDEF CSMonitor}
 ,FIBDataSet,pFIBDataSet
{$ENDIF}
  ;
 
const
 cPlanMaxLength=16384;


(* TFIBXSQLVAR *)
constructor TFIBXSQLVAR.Create(AParent: TFIBXSQLDA);
begin
  FParent := AParent;
  FVariantFalse := 0;
  FVariantTrue  := 1;
  FModified:=False;
  FIsMacro      :=False;
  FQuoted       :=False;
  FOldValue     :=Unassigned;
  FInWhereClause:=False;
  FInitialized  :=False;
  FCanForceIsNull:=False;
 {$IFDEF SUPPORT_ARRAY_FIELD}
  vFIBArray   :=nil;
 {$ENDIF}
end;

destructor TFIBXSQLVAR.Destroy; //override;
begin
 {$IFDEF SUPPORT_ARRAY_FIELD}
 if Assigned(vFIBArray) then vFIBArray.Free;
 {$ENDIF}
 inherited Destroy;
 FreeAndNil(FStreamValue);
end;
 
{$WARNINGS OFF}
function TFIBXSQLVAR.AdjustScale(Value: Int64; Scale: Integer): Double;
begin
 Result := Value*E10[Scale];
end;
 
 
function TFIBXSQLVAR.AdjustScaleToCurrency(Value: Int64; Scale: Integer): Currency;
begin
 try
  Result := Value * E10[Scale];
 except
  Result := 0;
 end;
end;


function TFIBXSQLVAR.AdjustScaleToInt64(Value: Int64; Scale: Integer): Int64;
begin
  if Scale = 0 then
   Result := Value
  else
   Result := Value div Trunc(E10[-Scale])
end;
{$WARNINGS ON}

procedure TFIBXSQLVAR.Assign(Source: TFIBXSQLVAR);
var 
  szBuff: PChar;
  s_bhandle, d_bhandle: TISC_BLOB_HANDLE;
  bSourceBlob, bDestBlob: Boolean;
  iSegs, iMaxSeg, iSize: Long;
  iBlobType: Short;
  SP:TFIBXSQLVAR;
  DestSQLType,SrcSQLType:integer;
begin
  szBuff := nil;
  SrcSQLType :=Source.FXSQLVAR^.sqltype and (not 1);
  DestSQLType:=FXSQLVAR^.sqltype and (not 1) ;
  bSourceBlob:=SrcSQLType=SQL_BLOB;
  bDestBlob  :=True;
  s_bhandle  :=nil;
  d_bhandle  :=nil;
  try
    if (Source.IsNull) then
    begin
      IsNull := True;
      Exit;
    end
    else
    if (DestSQLType = SQL_ARRAY) or   (SrcSQLType = SQL_ARRAY) then  Exit;
     // arrays not supported.
 
    if (DestSQLType <> SQL_BLOB) and not bSourceBlob then
    begin
      AsXSQLVAR := Source.AsXSQLVAR;
      Exit;
    end
    else
    if (SrcSQLType <> SQL_BLOB) then
    begin
      szBuff := nil;
      FIBAlloc(szBuff, 0, Source.FXSQLVAR^.sqllen);
      Move(Source.FXSQLVAR^.sqldata[0], szBuff[0], Source.FXSQLVAR^.sqllen);
      iSize := Source.FXSQLVAR^.sqllen;
    end
    else
    if (DestSQLType <> SQL_BLOB) then
    begin
     if FParent=FQuery.FUserSQLParams then
     begin
      if not FQuery.Prepared then FQuery.Prepare;
      SP:=FQuery.FSQLParams.FindParam(Name);
      bDestBlob := not (
       (SP=nil) or (SP.FXSQLVAR^.sqltype and (not 1) <> SQL_BLOB)
      );
      if bDestBlob then AsQuad:=SP.AsQuad;
     end
     else
      bDestBlob := False;
    end;
    if bSourceBlob then
    begin
      // read the blob
      Source.FQuery.Call(
        Source.FQuery.Database.ClientLibrary.isc_open_blob2(StatusVector, Source.FQuery.DBHandle,
        Source.FQuery.TRHandle, @s_bhandle, PISC_QUAD(Source.FXSQLVAR.sqldata),
        0, nil), True
      );
      with Source.FQuery,Source.FQuery.Database do
      try
        GetBlobInfo(ClientLibrary,@s_bhandle,iSegs, iMaxSeg, iSize,iBlobType);
        szBuff := nil;
        FIBAlloc(szBuff, 0, iSize);
        ReadBlob(ClientLibrary,@s_bhandle, szBuff, iSize);
        if (not bDestBlob)  // избегаем лишних преобразоаний
         or (FXSQLVAR^.sqlsubtype<>Source.FXSQLVAR^.sqlsubtype)
        then
         IBFilterBuffer(Database,szBuff, iSize, Source.FXSQLVAR^.sqlsubtype, False);  // ivan_ra

      finally
        Source.FQuery.Call(
         ClientLibrary.isc_close_blob(StatusVector, @s_bhandle), True
        );
      end;
    end;
 
    if bDestBlob then
    begin
      // write the blob
      FQuery.Call(FQuery.Database.ClientLibrary.isc_create_blob2(StatusVector, FQuery.DBHandle,
        FQuery.TRHandle, @d_bhandle, PISC_QUAD(FXSQLVAR.sqldata),
        0, nil), True);
      try
        if (not bSourceBlob)  // избегаем лишних преобразоаний
        or (FXSQLVAR^.sqlsubtype<>Source.FXSQLVAR^.sqlsubtype)
        then
         IBFilterBuffer(FQuery.Database,szBuff, iSize, Source.FXSQLVAR^.sqlsubtype, True);  // ivan_ra
        WriteBlob(FQuery.Database.ClientLibrary,@d_bhandle, szBuff, iSize);
        IsNull := False;
      finally
        FQuery.Call(FQuery.Database.ClientLibrary.isc_close_blob(StatusVector, @d_bhandle), True);
      end;
    end
    else
    begin
      // just copy the buffer
      FXSQLVAR.sqltype := SQL_TEXT;
      FXSQLVAR.sqllen := iSize;
      FIBAlloc(FXSQLVAR.sqldata, iSize, iSize);
      Move(szBuff[0], FXSQLVAR^.sqldata[0], iSize);
    end;
  finally
    FIBAlloc(szBuff, 0, 0);
  end;
end;
 
procedure TFIBXSQLVAR.SetSQLLen(A:SmallInt);
begin
  FXSQLVAR^.sqllen:=A
end;

 
function TFIBXSQLVAR.GetAsInt64: Int64;
begin
  Result := 0;
  if not IsNull then
    case FXSQLVAR^.sqltype and (not 1) of
      SQL_TEXT, SQL_VARYING:
      begin
        try
          Result := StrToInt64(AsString);
        except
          on E: Exception do FIBError(feInvalidDataConversion, [nil]);
        end;
      end;
      SQL_SHORT:
  	Result :=  PShort(FXSQLVAR^.sqldata)^ div Trunc(E10[-FXSQLVAR^.sqlscale]);
      SQL_LONG:
      	Result := PLong(FXSQLVAR^.sqldata)^ div Trunc(E10[-FXSQLVAR^.sqlscale]);
      SQL_INT64:
      	Result := PInt64(FXSQLVAR^.sqldata)^ div Trunc(E10[-FXSQLVAR^.sqlscale]);
 
      SQL_DOUBLE, SQL_FLOAT, SQL_D_FLOAT:
        Result := Trunc(AsDouble);
    else
        FIBError(feInvalidDataConversion, [nil]);
    end;
end;
 
 

function TFIBXSQLVAR.GetAsCurrency: Currency;
begin
  if (FQuery.Database.SQLDialect < 3)
   or (FXSQLVAR^.sqltype and (not 1)<>SQL_INT64)
  then
    Result := GetAsDouble
  else
    Result :=  PInt64(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale];
end;
 
{$IFNDEF NO_USE_COMP}
function TFIBXSQLVAR.GetAsComp: Comp;
begin
  InitFPU;
  Result := 0;
  if not IsNull then
    if (FXSQLVAR^.sqltype and (not 1))<>SQL_INT64 then
     Result:= AsDouble
    else
     Result := PInt64(FXSQLVAR^.sqldata)^ *E10[FXSQLVAR^.sqlscale];
end;
{$ENDIF}
const
  IBBuffDateDelta=678576;

function TFIBXSQLVAR.GetAsTimeStamp: TTimeStamp;
begin
  if IsNull then
  begin
    Result.Time :=0;
    Result.Date :=0;
  end
  else
  case FXSQLVAR^.sqltype and (not 1) of
   SQL_TEXT, SQL_VARYING:
   try
       Result := DateTimeToTimeStamp(StrToDate(AsString));
   except
    on E: EConvertError do FIBError(feInvalidDataConversion, [nil]);
   end;
   SQL_TYPE_TIME:
   begin
       Result.Date := 0;
       Result.Time := PISC_TIME(FXSQLVAR^.sqldata)^ div 10
   end;
   SQL_TYPE_DATE:
   begin
       Result.Date := PISC_DATE(FXSQLVAR^.sqldata)^ + IBBuffDateDelta;
       Result.Time := 0
   end;
   SQL_TIMESTAMP:
   with PISC_QUAD(FXSQLVAR^.sqldata)^ do
   begin
       Result.Date := gds_quad_high + IBBuffDateDelta;
       Result.Time := gds_quad_low div 10
   end;
  else
   FIBError(feInvalidDataConversion, [nil]);
  end;
end;
 
 
function TFIBXSQLVAR.GetAsDateTime: TDateTime;
const
  MSecsPerDay10 = MSecsPerDay * 10;
begin
  Result := 0;
  if not IsNull then
  case FXSQLVAR^.sqltype and (not 1) of
    SQL_TEXT, SQL_VARYING:
    try
        Result := StrToDate(AsString);
    except
        on E: EConvertError do FIBError(feInvalidDataConversion, [nil]);
    end;
    SQL_TYPE_TIME:
    begin
     Result :=PISC_TIME(FXSQLVAR^.sqldata)^/MSecsPerDay10;
    end;
    SQL_TYPE_DATE:
    begin
      Result:=PISC_DATE(FXSQLVAR^.sqldata)^-IBDateDelta;
    end;
    SQL_TIMESTAMP:
    begin
{     Result:=
      PISC_QUAD(FXSQLVAR^.sqldata)^.gds_quad_high-IBDateDelta+
       PISC_QUAD(FXSQLVAR^.sqldata)^.gds_quad_low/MSecsPerDay10;}
 
     Result:=
      HookTimeStampToDateTime(AsTimeStamp);
    end;
  else
     FIBError(feInvalidDataConversion, [nil]);
  end;
end;
 

function TFIBXSQLVAR.GetAsDouble: Double;
begin
  Result := 0;
  if not IsNull then
    case FXSQLVAR^.sqltype and (not 1) of
      SQL_TEXT, SQL_VARYING:
      begin
        try
          Result := StrToFloat(AsString);
        except
          on E: Exception do FIBError(feInvalidDataConversion, [nil]);
        end;
      end;
      SQL_SHORT:
        Result := PShort(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale];
      SQL_LONG:
        Result := PLong(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale];
      SQL_FLOAT:
        Result := PFloat(FXSQLVAR^.sqldata)^;
      SQL_INT64:
        Result := PInt64(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale];
      SQL_DOUBLE, SQL_D_FLOAT:
        Result := PDouble(FXSQLVAR^.sqldata)^;
      SQL_BOOLEAN :
        case PShort(FXSQLVAR^.sqldata)^ of
          ISC_TRUE  : Result := 1;
          ISC_FALSE : Result := 0;
        end;        
    else
        FIBError(feInvalidDataConversion, [nil]);
    end;
end;

function TFIBXSQLVAR.GetAsSingle: Float;
begin
  Result := 0;
  try
    Result := AsDouble;
  except
    on E: EOverflow do
      FIBError(feInvalidDataConversion, [nil]);
  end;
end;

function TFIBXSQLVAR.GetAsFloat: Double;
begin
 Result := GetAsDouble;
end;

function TFIBXSQLVAR.GetAsLong: Long;
begin
  Result := 0;
  if not IsNull then
    case FXSQLVAR^.sqltype and (not 1) of
      SQL_TEXT, SQL_VARYING:
      begin
        try
          Result := StrToInt(AsString);
        except
          on E: Exception do FIBError(feInvalidDataConversion, [nil]);
        end;
      end;
      SQL_SHORT:
        Result := Trunc(PShort(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale]);
      SQL_LONG:
      begin
        Result := Trunc(PLong(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale]);
      end;
      SQL_INT64:
        Result := Trunc(PInt64(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale]);
 
      SQL_DOUBLE, SQL_FLOAT, SQL_D_FLOAT:
        Result := Trunc(AsDouble);
      SQL_BOOLEAN :
        Result:=PShort(FXSQLVAR^.sqldata)^
    else
        FIBError(feInvalidDataConversion, [nil]);
    end;
end;

function TFIBXSQLVAR.GetAsPointer: Pointer;
begin
  if not IsNull then
    Result := FXSQLVAR^.sqldata
  else
    Result := nil;
end;

function TFIBXSQLVAR.GetAsQuad: TISC_QUAD;
begin
  if IsNull then
  begin
   Result.gds_quad_high := 0;
   Result.gds_quad_low  := 0;
  end
  else
  case FXSQLVAR^.sqltype and (not 1) of
  SQL_BLOB, SQL_ARRAY, SQL_QUAD:
    Result := PISC_QUAD(FXSQLVAR^.sqldata)^;
  else
      FIBError(feInvalidDataConversion, [nil]);
  end;
end;
 
function TFIBXSQLVAR.GetAsShort: Short;
begin
  Result := 0;
  try
    Result := AsLong;
  except
    on E: Exception do FIBError(feInvalidDataConversion, [nil]);
  end;
end;
 
 
function TFIBXSQLVAR.GetAsString: string;
var
  sz: PChar;
  str_len: Integer;
  bs     :TFIBBlobStream;
begin
  Result := '';
  (* Check null, if so return a default string *)
  if not IsNull then
    case FXSQLVar^.sqltype and (not 1) of
//      0: Result:='';
      SQL_ARRAY:
        Result := '(ARRAY)';
      SQL_BLOB:
        try
          Result:='(BLOB)'; { return on error }
          if IsParam and (FStreamValue=nil) then
           Exit; // BlobHandle may be invalid
          if FStreamValue<>nil then
          begin
            if FStreamValue.Size=0 then
             Result := ''
            else
            begin
             SetLength(Result, FStreamValue.Size);
             FStreamValue.Position:=0;
             FStreamValue.Read(Result[1],FStreamValue.Size)
            end;
          end
          else
          begin
            bs := TFIBBlobStream.Create;
            try
              bs.Mode := bmRead;
              with FQuery do
              begin
               if Database.NeedUTFEncodeDDL then
                 bs.InternalSetCharSet(Byte(FXSQLVar^.sqlscale));
               bs.Database := Database;
               bs.Transaction := Transaction;
               if qoStartTransaction in Options then
                if (Transaction<>nil) and not Transaction.InTransaction then
                   Transaction.StartTransaction;
              end;
              bs.BlobID := AsQuad;
              bs.blobSubType:=FXSQLVAR^.sqlsubtype;
              Result    := bs.AsString;
 
            finally
              bs.Free;
            end;
          end;
        except
          //BlobHandle is invalid!
        end;
 

      SQL_TEXT, SQL_VARYING:
      begin
          sz := FXSQLVAR^.sqldata;
          if (FXSQLVar^.sqltype and (not 1) = SQL_TEXT) then
            str_len := FXSQLVar^.sqllen
          else
          begin
//            str_len := FQuery.Database.ClientLibrary.isc_vax_integer(FXSQLVar^.sqldata, 2);
            str_len :=PWord(sz)^;// It is isc_vax_integer(LocalData, 2);   
            Inc(sz, 2);
          end;
          SetString(Result, sz, str_len);
          if Byte(FXSQLVar^.sqlsubtype) in FQuery.Database.UnicodeCharsets then
            if FQuery.Database.NeedUnicodeFieldsTranslation then
             Result:=UTF8Decode(Result);
{$IFDEF SUPPORT_KOI8_CHARSET}
          if Byte(FXSQLVar^.sqlsubtype) in [chFBKOI8R,chFBKOI8U] then
             Result:=ConvertFromCodePage(Result,CodePageKOI8R);
{$ENDIF}
          if qoTrimCharFields in FQuery.Options then
           DoTrimRight(Result);
      end;
      SQL_TYPE_DATE:
        Result :=DateToStr(AsDateTime);
      SQL_DATE:
        Result :=DateTimeToStr(AsDateTime);
      SQL_TYPE_TIME:
        Result := TimeToStr(AsTime);
      SQL_SHORT, SQL_LONG:
        if FXSQLVAR^.sqlscale <> 0 then
          Result := FloatToStr(AsDouble)
        else
          Result := IntToStr(AsLong);
      SQL_INT64:
        if FXSQLVAR^.sqlscale = 0 then
          Result := IntToStr(AsInt64)
        else
        with FXSQLVAR^ do
        begin
          Result := CompWithScaleToStr(PInt64(sqldata)^,-sqlscale,DecimalSeparator)
        end;
      SQL_DOUBLE, SQL_FLOAT, SQL_D_FLOAT:
        Result := FloatToStr(AsDouble);
      SQL_BOOLEAN:
        if AsBoolean then
          Result := TrueStr
        else
          Result := FalseStr;

    else
        FIBError(feInvalidDataConversion, [nil]);
    end;
end;
 
function TFIBXSQLVAR.GetAsExtended: Extended;
begin
  Result := 0;
  if not IsNull then
    case FXSQLVAR^.sqltype and (not 1) of
      SQL_TEXT, SQL_VARYING:
      try
          Result := StrToFloat(AsString);
      except
          on E: Exception do FIBError(feInvalidDataConversion, [nil]);
      end;
      SQL_SHORT:
        Result := Long(PShort(FXSQLVAR^.sqldata)^)*E10[FXSQLVAR^.sqlscale];
      SQL_LONG:
        Result := PLong(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale];
      SQL_FLOAT:
        Result := PFloat(FXSQLVAR^.sqldata)^;
      SQL_INT64:
        Result := PInt64(FXSQLVAR^.sqldata)^*E10[FXSQLVAR^.sqlscale];
      SQL_DOUBLE, SQL_D_FLOAT:
        Result := PDouble(FXSQLVAR^.sqldata)^;
      else
        FIBError(feInvalidDataConversion, [nil]);
    end;
end;

function TFIBXSQLVAR.GetAsVariant: Variant;
begin
  if IsNull then
    Result := NULL
  (* Check null, if so return a default string *)
  else
  case FXSQLVar^.sqltype and (not 1) of
      SQL_ARRAY:
        Result := '(Array)';
      SQL_BLOB:
//        Result := '(BLOB)';
        Result := AsString;
      SQL_TEXT, SQL_VARYING:
        if Byte(FXSQLVar^.sqlsubtype) in FQuery.Database.UnicodeCharsets then
         Result := GetAsWideString
        else
         Result := AsString;
      SQL_TYPE_DATE, SQL_TYPE_TIME,SQL_DATE:
        Result := AsDateTime;
      SQL_SHORT, SQL_LONG:
        if FXSQLVAR^.sqlscale <> 0 then
          Result := AsDouble
        else
          Result := AsLong;
      SQL_INT64:
        if FXSQLVAR^.sqlscale = 0 then
        {$IFDEF D6+}
          Result := AsInt64
        {$ELSE}
          Result := AsExtended
        {$ENDIF}
        else
        if FXSQLVAR^.sqlscale >= (-4) then
          Result := AsExtended
        else
          Result := AsDouble;
      SQL_DOUBLE, SQL_FLOAT, SQL_D_FLOAT:
        Result := AsDouble;
      SQL_BOOLEAN:
        Result := AsBoolean
  else
        FIBError(feInvalidDataConversion, [nil]);
  end;
end;

function TFIBXSQLVAR.GetAsXSQLVAR: PXSQLVAR;
begin
  Result := FXSQLVAR;
end;
 
function TFIBXSQLVAR.GetIsNull: Boolean;
begin
   Result := (FStreamValue=nil);
   if Result then
    Result:=
    ((not FParent.FIsParams) and (FQuery.RecordCount=0) and (FQuery.SQLType<>SQLExecProcedure))
    or
    (IsNullable and (FXSQLVAR^.sqlind^ = -1) or (FXSQLVAR^.sqlType in [0,1]));
end;
 
function TFIBXSQLVAR.GetIsNullable: Boolean;
begin
  Result := (FXSQLVAR^.sqltype and 1 = 1);
  if Result and not Assigned(FXSQLVAR^.sqlind) then
   FIBAlloc(FXSQLVAR^.sqlind, 0, SizeOf(Short));
end;
 
procedure TFIBXSQLVAR.LoadFromFile(const FileName: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(fs);
  finally
    fs.Free;
  end;
end;
 
procedure TFIBXSQLVAR.LoadFromFile(const FileName: string;cb: TCallBackBlobReadWrite);
var
   q: TISC_QUAD;
begin
  q:=FileToBlob(FileName,FQuery.Database,FQuery.Transaction,cb);
  AsQuad:=q;
  if Assigned(FStreamValue) then
  begin
   FStreamValue.Free;
   FStreamValue:=nil;
  end;
end;


procedure TFIBXSQLVAR.LoadFromStream(Stream: TStream);
begin
  if FStreamValue=nil then
   FStreamValue:=TMemoryStream.Create;
  FStreamValue.LoadFromStream(Stream);
  FQuery.FHaveStreamParams:=True;
  FXSQLVar^.sqltype:=SQL_BLOB
end;
{
procedure TFIBXSQLVAR.SaveToFile(const FileName: string);
var 
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
  try
    SaveToStream(fs);
  finally
    fs.Free;
  end;
end;}
 
procedure TFIBXSQLVAR.SaveToFile(const FileName: string;cb: TCallBackBlobReadWrite=nil);
begin
 BlobToFile(asQuad, FileName,FQuery.Database,FQuery.Transaction,cb)
end;
 
procedure BlobToStream (ModelVar:TFIBXSQLVAR; BlobID:TISC_QUAD;Stream: TStream);
var 
  bs: TFIBBlobStream;
begin
  bs := TFIBBlobStream.Create;
  try
    bs.blobSubType:=ModelVar.AsXSQLVAR^.sqlsubtype;  // ivan_ra
    bs.Mode       := bmRead;
    with ModelVar.FQuery do
    begin
      bs.Database    := Database;
      bs.Transaction := Transaction;
      if qoStartTransaction in Options then
       if (Transaction<>nil) and not Transaction.InTransaction then
          Transaction.StartTransaction;
    end;
    bs.BlobID := BlobId;
    bs.SaveToStream(Stream);
  finally
    bs.Free;
  end;
end;

procedure TFIBXSQLVAR.SaveToStream(Stream: TStream);
begin
  BlobToStream (Self,AsQuad,Stream);
end;

function TFIBXSQLVAR.GetSize: Integer;
begin
  Result := FXSQLVAR^.sqllen;
end;

procedure TFIBXSQLVAR.Clear;
begin
 IsNull:=True;
end;
// Array Support
 
{$IFDEF SUPPORT_ARRAY_FIELD}
 
function  TFIBXSQLVAR.IsArray:boolean;
begin
  Result:=(FXSQLVAR^.sqltype and (not 1) = SQL_ARRAY)
end;
 
procedure TFIBXSQLVAR.CheckArrayType;
begin
 if not IsArray or not Assigned(vFIBArray)
  then
   FIBError(feNotIsArrayField,[FXSQLVAR^.relName+'.'+FXSQLVAR^.SQlName]);
end;

function TFIBXSQLVAR.GetDimensionCount:Integer;
begin
 CheckArrayType;
 Result:=vFIBArray.DimensionCount
end;
 

function TFIBXSQLVAR.GetElementType:TFieldType;
begin
 CheckArrayType;
 Result:=vFIBArray.ArrayType
end;

function TFIBXSQLVAR.GetDimension(Index: Integer): TISC_ARRAY_BOUND;
begin
 CheckArrayType;
 Result:=vFIBArray.Dimension[Index]
end;
 
function TFIBXSQLVAR.GetSliceSize:integer;
begin
  CheckArrayType;
  Result:=vFIBArray.ArraySize
end;

 

procedure TFIBXSQLVAR.SetArrayValue(Value:Variant);
begin
 CheckArrayType;
 vFIBArray.SetArrayValue(Value, FXSQLVAR^.sqldata,
  FQuery.DBHandle,FQuery.TRHandle
 );
 AsQuad:=PISC_QUAD(FXSQLVAR^.sqldata)^
end;

function TFIBXSQLVAR.GetArrayValues:Variant;
begin
 CheckArrayType;
 Result:=False;
 if not Assigned(vFIBArray) then Exit;
 Result:= vFIBArray.GetArrayValues(FXSQLVAR^.sqldata,
             FQuery.DBHandle, FQuery.TRHandle
          );
end;

function TFIBXSQLVAR.GetArrayElement(Indexes: array of Integer):Variant;
begin
 CheckArrayType;
 Result:=GetArrayValues[Indexes[0]]
end;

function TFIBXSQLVAR.GetArraySize:integer;
begin
 CheckArrayType;
 Result:=vFIBArray.ArraySize
end;
{$ENDIF}
// End Array Support

procedure TFIBXSQLVAR.SetDefMacroValue;
begin
 asString:=FDefMacroValue
end;
 
function  TFIBXSQLVAR.IsDefMacroValue :boolean;
begin
 Result:= IsMacro and (FDefMacroValue=asString)
end;
 
function TFIBXSQLVAR.GetSQLType: Integer;
begin
  Result := FXSQLVAR^.sqltype and (not 1);
end;

function TFIBXSQLVAR.GetSQLSubtype: Short;
begin
  Result := FXSQLVAR^.sqlsubtype;
end;

function TFIBXSQLVAR.IsRealType(SQLType:Integer):boolean;
begin
  Result:=
    ((SQLType=SQL_INT64)  or (SQLType=SQL_LONG) or
    (SQLType=SQL_SHORT) and (Scale<>0) ) or (SQLType=SQL_DOUBLE) or
    (SQLType=SQL_FLOAT) or (SQLType=SQL_D_FLOAT)
end;

function TFIBXSQLVAR.IsNumericType(SQLType:Integer):boolean;
begin
  Result:=
    (SQLType=SQL_INT64) or (SQLType=SQL_LONG) or
    (SQLType=SQL_SHORT) or (SQLType=SQL_DOUBLE) or
    (SQLType=SQL_FLOAT) or (SQLType=SQL_D_FLOAT)
end;

function TFIBXSQLVAR.IsDateTimeType(SQLType:Integer):boolean;
begin
  Result:=
   (SQLType =SQL_TIMESTAMP) or(SQLType = SQL_TYPE_DATE) or (SQLType = SQL_TYPE_TIME)
end;

function TFIBXSQLVAR.GetServerSQLType:Integer;
var 
  SrvSqlVar: TFIBXSQLVAR;
begin
 if not FQuery.Prepared then
  Result:=0 // Unknown
 else               
 with FParent do
 if not FIsParams  or (FParent.FQuery.FSQLParams=FParent) then
  if FInitialized then
   Result:=FSrvSQLType
  else
   Result:=GetSQLType
 else
 begin
   if FSrvSQlType<>0 then
    Result:=FSrvSQLType
   else
   begin
     SrvSqlVar:=FQuery.FSQLParams.FindParam(FName);
     if SrvSqlVar=nil then
      Result:=GetSQLType
     else
     if SrvSqlVar.FSrvSQlType=0 then
      Result:=SrvSqlVar.SQLType
     else
      Result:=SrvSqlVar.FSrvSQLType;
    FSrvSQLType:=Result
   end;
 end;
end;

function TFIBXSQLVAR.GetServerSQLScale:Integer;
var
  SrvSqlVar: TFIBXSQLVAR;
begin
 with FParent do
 if not FIsParams  or (FParent.FQuery.FSQLParams=FParent) then
  if FInitialized then
   Result:=GetScale
  else
   Result:=FSrvSQLScale
 else
 begin
   if FSrvSQLScale<>0 then
    Result:=FSrvSQLScale
   else
   begin
    SrvSqlVar:=FQuery.FSQLParams.FindParam(FName);
    if SrvSqlVar=nil then
     Result:=GetScale
    else
    if SrvSqlVar.FSrvSQLScale=0 then
     Result:=SrvSqlVar.Scale
    else
     Result:=SrvSqlVar.FSrvSQLScale;
    FSrvSQLScale:=Result;
   end;
 end;
end;


function TFIBXSQLVAR.GetServerSQLSize:Integer;
var
  SrvSqlVar: TFIBXSQLVAR;
begin
 if not FQuery.Prepared then
  Result:=0 // Unknown
 else
 with FParent do
 if not FIsParams  or (FParent.FQuery.FSQLParams=FParent) then
  if FInitialized then
   Result:=GetSize
  else
   Result:=FSrvSQLLen
 else
 begin
   if FSrvSQLLen<>0 then
    Result:=FSrvSQLLen
   else
   begin
    SrvSqlVar:=FQuery.FSQLParams.FindParam(FName);
    if SrvSqlVar=nil then
     Result:=GetSize
    else
    if SrvSqlVar.FSrvSQLLen=0 then
     Result:=SrvSqlVar.Size
    else
     Result:=SrvSqlVar.FSrvSQLLen;
    FSrvSQLLen:=Result;
   end;
 end;
end;

function  TFIBXSQLVAR.GetServerSQLSubType:Integer;
var
  SrvSqlVar: TFIBXSQLVAR;
begin
 if not FQuery.Prepared then
  Result:=0 // Unknown
 else
 with FParent do
 if not FIsParams  or (FParent.FQuery.FSQLParams=FParent) then
   if FInitialized then
    Result:=GetSQLSubType
   else
    Result:=FSrvSQLSubType
 else
 begin
   if FSrvSQLSubType<>0 then
    Result:=FSrvSQLSubType
   else
   begin
    SrvSqlVar:=FQuery.FSQLParams.FindParam(FName);
    if SrvSqlVar=nil then
     Result:=GetSQLSubType
    else
     Result:=SrvSqlVar.FSrvSQLSubType;
    FSrvSQLSubType:=Result;
   end;
 end;
end;


procedure InternalSetNull(xvar: TFIBXSQLVAR;const aValue:boolean);
begin
  with xvar,xvar.FXSQLVAR^ do
  begin
   if aValue then
   begin
     if (xvar.FXSQLVAR^.sqltype in [0,1]) then
     begin
      sqlType:=SQL_TEXT ;
      sqllen :=0;
      FreeMem(sqldata);
      sqldata:=nil;
     end;
     if (not IsNullable) then  IsNullable := True;
     sqlind^ := -1;
{     if xvar.IsParam then
      sqllen  :=0;}
   end
   else
    if IsNullable then  sqlind^ := 0;
   FModified := True;
  end;
end;

procedure InternalSetNullable(xvar: TFIBXSQLVAR;const aValue:boolean);
begin
 if (aValue <> xvar.IsNullable) then
 with xvar.FXSQLVAR^ do
 if aValue then
 begin
   sqltype := sqltype or 1;
   FIBAlloc(sqlind, 0, SizeOf(Short));
 end
 else
 begin
   sqltype := sqltype and (not 1);
   FIBAlloc(sqlind, 0, 0);
 end;
end;
 
procedure InternalSetValue(xvar: TFIBXSQLVAR; aSQLType,aSize:integer;const aValue);
begin
 with xvar,xvar.FXSQLVAR^ do
 begin
    if IsNull  then
     IsNull := False;
    sqlscale := 0;
    if (aSize=0) then
    begin
      sqllen   := aSize;
      ReallocMem(sqldata,1);
    end
    else
    if (sqllen<>aSize) then
    begin
      sqllen   := aSize;
      ReallocMem(sqldata,aSize);
    end;
    sqltype  := aSQLType or (sqltype and 1);
    Move(aValue,sqldata^,sqllen);
    FModified := True;
 end;
end;
 
procedure InternalSetAsXSQLVAR(xvar: TFIBXSQLVAR;aValue: PXSQLVAR);
var 
  local_sqlind: PShort;
  local_sqldata: PChar;
  local_sqllen: Integer;
begin
    with xvar,xvar.FXSQLVAR^ do
    begin
      local_sqlind  := sqlind;
      local_sqldata := sqldata;
      Move(aValue^, FXSQLVAR^, SizeOf(TXSQLVAR));
      sqlind  := local_sqlind;
      sqldata := local_sqldata;
 

      if (sqlind = nil) then
      begin
       if (aValue^.sqlind<>nil) then
       begin
        FIBAlloc(sqlind, 0, SizeOf(Short));
        sqlind^:= aValue^.sqlind^;
       end;
      end
      else
      if (aValue^.sqlind=nil) then
      begin
        FIBAlloc(sqlind, 0, 0);
        sqlind:=nil;
      end
      else
        sqlind^:= aValue^.sqlind^;

      if (sqltype and (not 1)) = SQL_VARYING then
        local_sqllen := sqllen + 2
      else
        local_sqllen := sqllen;
      if local_sqllen<>0 then
      begin
       FIBAlloc(sqldata, 0, local_sqllen);
       Move(aValue^.sqldata[0], FXSQLVAR^.sqldata[0], local_sqllen);
      end
      else
      begin
        ReallocMem(sqldata,1);
      end;
      FModified := True;
    end;
end;
 
procedure TFIBXSQLVAR.SetValue(aSQLType,aSize:integer;ValueType:TTypeSetToParam;const aValue);
var
  i:  Integer;
  xvar: TFIBXSQLVAR;
begin
  if (FParent.FEquelNames.Count=0) or not FParent.FEquelNames.Find(FName,i) then
   case ValueType of
    tspNull      :InternalSetNull(Self,Boolean(aValue));
    tspIsNullable:InternalSetNullable(Self,Boolean(aValue));
    tspScale     :FXSQLVAR^.sqlscale:=Integer(aValue);
    tspValue     :InternalSetValue(Self, aSQLType,aSize,aValue);
    tspSqlVar    :InternalSetAsXSQLVAR(Self,PXSQLVAR(aValue));
   end
  else
  while (i<FParent.FEquelNames.Count) and (FParent.FEquelNames[i]=FName) do
  begin
   xvar:=FParent[Integer(FParent.FEquelNames.Objects[i])];
   case ValueType of
    tspNull      :InternalSetNull(xvar,Boolean(aValue));
    tspIsNullable:InternalSetNullable(xvar,Boolean(aValue));
    tspScale     :xvar.FXSQLVAR^.sqlscale:=Integer(aValue);
    tspValue     :InternalSetValue(xvar, aSQLType,aSize,aValue);
    tspSqlVar    :InternalSetAsXSQLVAR(xvar,PXSQLVAR(aValue))
   end;
   Inc(i)
  end;
  FInitialized:=True;
  if IsMacro  and not FQuery.FMacroChanged then
   if VarToStr(Value)<>VarToStr(OldValue) then
     FQuery.FMacroChanged:=True;
end;
 
 
procedure TFIBXSQLVAR.SetAsInt64(aValue: Int64);
begin
 if FQuery.Database.SQLDialect < 3 then
  SetAsLong(aValue) // Иначе ИБ4 валится
 else
  SetValue(SQL_INT64,SizeOf(Int64),tspValue,aValue)
end;

 

 
procedure TFIBXSQLVAR.SetAsCurrency(aValue: Currency);
begin
 if FQuery.Database.SQLDialect < 3 then
  SetAsDouble(aValue)
 else
 begin
   SetValue(SQL_INT64,SizeOf(Currency),tspValue,aValue);
   SetScale(-4);
 end;
end;
 
 {$IFNDEF NO_USE_COMP}
procedure TFIBXSQLVAR.SetAsComp(aValue: comp);
begin
  SetValue(SQL_INT64,SizeOf(Comp),tspValue,aValue)
end;
{$ENDIF}
 
procedure TFIBXSQLVAR.SetAsTimeStamp(aValue: TTimeStamp);
var 
    tq:  TISC_QUAD;
begin
    with tq do
    begin
      gds_quad_high :=aValue.Date-IBBuffDateDelta;
      gds_quad_low  :=aValue.Time*10;
    end;
    SetValue(SQL_DATE,SizeOf(TISC_QUAD),tspValue,tq);
end;
 

procedure TFIBXSQLVAR.SetAsTime(aValue: TDateTime);
begin
  AsTimeStamp:=DateTimeToTimeStamp(aValue);
end;

procedure TFIBXSQLVAR.SetAsDate(aValue: TDateTime);
begin
  AsTimeStamp:=DateTimeToTimeStamp(Trunc(aValue));
end;


procedure TFIBXSQLVAR.SetAsDateTime(aValue: TDateTime);
begin
   AsTimeStamp:=DateTimeToTimeStamp(aValue);
end;
 
procedure TFIBXSQLVAR.SetAsDouble(aValue: Double);
begin
  SetValue(SQL_DOUBLE,SizeOf(Double),tspValue,aValue)
end;

procedure TFIBXSQLVAR.SetAsSingle(aValue: Float);
begin
  SetValue(SQL_FLOAT,SizeOf(Float),tspValue,aValue)
end;

procedure TFIBXSQLVAR.SetAsFloat(aValue: Double);
begin
 SetAsDouble(aValue)
end;
 
procedure TFIBXSQLVAR.SetAsExtended(aValue: Extended);
var vScale:integer;
begin
  if (FQuery.Database.SQLDialect < 3) then
   SetAsDouble(aValue)
  else
  begin
   vScale:=ExtPrecision(aValue)-18;
   AsInt64:=Round(aValue*E10[-vScale]);
   SetScale(vScale);
  end;
end;
 
procedure TFIBXSQLVAR.SetAsLong(aValue: Long);
begin
  SetValue(SQL_LONG,SizeOf(Long),tspValue,aValue);
end;
 
 
procedure TFIBXSQLVAR.SetAsQuad(aValue: TISC_QUAD);
var vSQLType:Integer;
begin
  if sqltype and (not 1) <> SQL_ARRAY then
   vSQLType:=SQL_BLOB
  else
   vSQLType:=SQL_ARRAY;
  SetValue(vSQLType,SizeOf(TISC_QUAD),tspValue,aValue)
end;

procedure TFIBXSQLVAR.SetAsShort(aValue: Short);
begin
  SetValue(SQL_SHORT,SizeOf(Short),tspValue,aValue)
end;


 
procedure TFIBXSQLVAR.InternalSetAsString(aValue:Pointer; IsWide:boolean; AdjustDeffered:boolean=False);
// Value may be string or widestring
var 
   vNeedUTFEncode:  boolean;
   sSubType,sSQLScale:Short;
   sSQLType,vSQLType,vSize :integer;
   vValue:string;
   B:boolean;
begin
   sSQLType:=ServerSqlType;
   sSubType:=ServerSQLSubType;
   sSQLScale:=GetServerSQLScale;
 
   if AdjustDeffered then
   begin
     case sSQLType of
        SQL_TEXT,SQL_VARYING:
        begin
         vNeedUTFEncode:= (FQuery.Database.IsUnicodeConnect and not (sSubType in [0,1])) or
             (Byte(sSubType) in FQuery.Database.UnicodeCharsets);
         FIsDefferedSetting:=False;
         if not vNeedUTFEncode then
           Exit;
        end;
     SQL_BLOB:
      begin
       vNeedUTFEncode:= True; // Будем считать что все проверено
       FIsDefferedSetting:=False;
      end;
     else
      vNeedUTFEncode:= False
     end;
   end
   else
   if not IsMacro and FQuery.Database.NeedUnicodeFieldsTranslation then
   begin
     vNeedUTFEncode:=False;
     if IsWide then
      FWideTempValue:=PWideString(aValue)^
     else
      FWideTempValue:='';
 


{     vNeedUTFEncode:=IsWide;
     if vNeedUTFEncode then
       FIsDefferedSetting:=False
     else    }
     begin
       case sSQLType of
        0:
        begin
         FIsDefferedSetting:=True;
         FParent.FHasDefferedSettings:=True;
        end;
        SQL_TEXT,SQL_VARYING:
        begin
         vNeedUTFEncode:= (FQuery.Database.IsUnicodeConnect and not (sSubType in [0,1])) or
          (Byte(sSubType) in FQuery.Database.UnicodeCharsets);
         FIsDefferedSetting:=False;
        end;
        SQL_BLOB:
        begin
         vNeedUTFEncode:= FQuery.Database.NeedUTFEncodeDDL and
          (FQuery.Database.IsUnicodeConnect and (sSubType =1) and
           not (sSQLScale in [0,1])) or
           (Byte(sSQLScale) in FQuery.Database.UnicodeCharsets);
          FIsDefferedSetting:=False;
        end;
       end;
     end;
   end
   else
   begin
    FIsDefferedSetting:=False;
    vNeedUTFEncode:=False;
   end;

   if IsWide then
   begin
    if vNeedUTFEncode then
     vValue:=UTF8Encode(PWideString(aValue)^)
    else
     vValue:=PWideString(aValue)^;
   end
   else
   begin
 
    if vNeedUTFEncode then
     if Length(FWideTempValue)=0 then
      vValue:=UTF8Encode(PString(aValue)^)
     else
     begin
       vValue:=UTF8Encode(FWideTempValue);
       FWideTempValue:='';
     end
    else
     vValue:=PString(aValue)^;
   end;
   if vNeedUTFEncode then
     FXSQLVAR^.sqlsubtype:=chUnicodeFSS;
   if Length(vValue)>32767 then
    if not IsWide  then
     sSQLType:=SQL_BLOB
    else
     raise Exception.Create(
       Format(SFIBErrorWideStringValueTooLong, [CmpFullName(FQuery),Name])
     );

    if (sSQLType = SQL_BLOB) then
    begin
      if FStreamValue=nil then
       FStreamValue:=TMemoryStream.Create;
 
     if Length(vValue)=0 then
      FStreamValue.Clear
     else
     begin
      FStreamValue.Position:=0;
      FStreamValue.Write(vValue[1],Length(vValue));
     end;
     FQuery.FHaveStreamParams:=True;
     FXSQLVAR^.sqltype:=sSQLType;
     FXSQLVAR^.sqlsubtype:= sSubType;
     FXSQLVAR^.sqlscale:= sSQLScale;     
     Exit;
    end
    else
    with FXSQLVAR^ do
    if (sqlname = 'DB_KEY') or (sqlname = 'RDB$DB_KEY') then
    begin
     vSQLType:=sqltype;
     vSize   :=sqllen
    end
    else
    begin
     vSQLType:=SQL_TEXT;
     vSize   :=Length(vValue);
    end;
 

     if vSize>0 then
     begin
       if not IsMacro and IsNumericType(sSQLType) then
       begin
       // Avoid  bug in  CAST
         vValue:=ReplaceStr(vValue,',',SQLDecimalSeparator);
         if not (DecimalSeparator in [SQLDecimalSeparator,',']) then
          vValue:=ReplaceStr(vValue,DecimalSeparator,SQLDecimalSeparator);
       end;
       SetValue(vSQLType,vSize, tspValue,vValue[1])
     end
     else
     if IsNumericType(sSQLType)  or (IsDateTimeType(sSQLType)) then
     begin
      B:=True;
      SetValue(vSQLType,vSize, tspNull,B)
     end
     else
      SetValue(vSQLType,vSize, tspValue,'')
end;
 
procedure TFIBXSQLVAR.SetAsString(const aValue: string);
begin
   InternalSetAsString(@aValue, False);
end;
 
procedure TFIBXSQLVAR.SetAsWideString(const aValue: WideString);
begin
   InternalSetAsString(@aValue, True);
end;
 

function  TFIBXSQLVAR.GetAsWideString:WideString;
var
    sz: PChar;
    str_len:integer;
    s:string;
    bs     :TFIBBlobStream;

begin
//   S:=GetAsString;
   if Length(FWideTempValue)>0 then
    Result:=FWideTempValue
   else
   if FQuery.Database.NeedUnicodeFieldsTranslation then
     with FXSQLVAR^ do
     case sqltype and (not 1) of
      SQL_TEXT,SQL_VARYING :
       if Byte(sqlsubtype) in FQuery.Database.UnicodeCharsets then
       begin
         if IsNull then
          Result:=''
         else
         begin
          sz := FXSQLVAR^.sqldata;
          if (FXSQLVar^.sqltype and (not 1) = SQL_TEXT) then
            str_len := FXSQLVar^.sqllen
          else
          begin
//            str_len := FQuery.Database.ClientLibrary.isc_vax_integer(FXSQLVar^.sqldata, 2);
            str_len :=PWord(sz)^;// It is isc_vax_integer(sz, 2);
            Inc(sz, 2);
          end;
          SetString(s, sz, str_len);
          Result:=UTF8Decode(s);
          if qoTrimCharFields in FQuery.Options then
           Result:=TrimRight(Result);
 
         end
       end
       else
        Result:=GetAsString;

      SQL_BLOB:
        try
          Result:='(BLOB)'; { return on error }
          if IsParam and (FStreamValue=nil) then
           Exit; // BlobHandle may be invalid
          if FStreamValue<>nil then
          begin
            if FStreamValue.Size=0 then
             Result := ''
            else
            begin
             SetLength(Result, FStreamValue.Size);
             FStreamValue.Position:=0;
             FStreamValue.Read(Result[1],FStreamValue.Size)
            end;
          end
          else
          begin
            bs := TFIBBlobStream.Create;
            try
              bs.Mode := bmRead;
              with FQuery do
              begin
               if Database.NeedUTFEncodeDDL then
                 bs.InternalSetCharSet(Byte(FXSQLVar^.sqlscale));
               bs.Database := Database;
               bs.Transaction := Transaction;
               if qoStartTransaction in Options then
                if (Transaction<>nil) and not Transaction.InTransaction then
                   Transaction.StartTransaction;
              end;
              bs.BlobID := AsQuad;
              bs.blobSubType:=FXSQLVAR^.sqlsubtype;
              Result    := bs.AsWideString;

            finally
              bs.Free;
            end;
          end
        except
          //BlobHandle is invalid!
        end;


     else
       Result:=GetAsString;
     end
   else
    Result:=GetAsString;
end;

{$IFNDEF D6+}
type
 PDate=PDateTime;
 PWordBool=^WordBool;
{$ENDIF}

procedure TFIBXSQLVAR.SetAsVariant(Value: Variant);
var 
     vt: integer;
     sSQLType:integer;
     v:TVarData;
     ws:WideString;
    {$IFDEF SUPPORT_ARRAY_FIELD}
     BlobValue:TMemoryStream;
    {$ENDIF}
begin
  vt:=VarType(Value);
  sSQLType:=ServerSqlType;
//  if not FParent.FQuery.Prepared then
  if sSQLType=0 then
  begin
   FParent.FHasDefferedSettings:=True;
   FIsDefferedSetting:=True;
  end;

  if (sSQLType=SQL_TIMESTAMP) or (sSQLType=SQL_TYPE_DATE) then
   if vt in [varDouble,varCurrency,varInteger,varSingle,varSmallint
    {$IFDEF D6+}
     ,varWord,varShortInt ,  varLongWord,varInt64
    {$ENDIF}

   ] then
   begin
    vt:=varDate;
    Value:=TDateTime(Value);
   end;
  if VarIsNull(Value) then
    IsNull := True
  else
  case vt of
    varEmpty, varNull:
      IsNull := True;
    varSmallint, varInteger, varByte
    {$IFDEF D6+}
    ,varWord,varShortInt ,  varLongWord
    {$ENDIF}
    :
      AsLong := Value;
   {$IFDEF D6+}
    varInt64	:
      AsInt64  :=Value;
   {$ENDIF}
    varSingle, varDouble:
      AsDouble := Value;
    varCurrency:
      AsCurrency := Value;
    varBoolean:
      if Value then
        AsVariant := VariantTrue
      else
        AsVariant := VariantFalse;
    varDate:
     case sSQLType of
      SQL_TYPE_TIME: AsTime:=Value;
      SQL_TYPE_DATE: AsDate:=Value;
     else
      AsDateTime := Value;
     end;
    varOleStr:
    begin
       AsWideString := Value;
    end;
    varString:
      AsString := Value;
    varArray:
    {$IFDEF SUPPORT_ARRAY_FIELD}
     if IsArray then
      SetArrayValue(Value)
     else
    {$ENDIF}
     if IsBlob or (sSQLType=0) then
     begin
       BlobValue:=TMemoryStream.Create;
       try
        VariantToStream(Value,BlobValue);
        LoadFromStream(BlobValue);
       finally
        BlobValue.Free
       end;
     end
 
    ;
    varVariant:
      AsVariant:= Variant(PVarData(TVarData(Value).VPointer)^);
    varByRef, varDispatch, varError, varUnknown:
      FIBError(feNotPermitted, [nil]);
  else
   if VarIsArray(Value) then
   begin
    {$IFDEF SUPPORT_ARRAY_FIELD}
     if IsArray then
      SetArrayValue(Value)
     else
    {$ENDIF}
     if IsBlob or (sSQLType=0) then
     begin
       BlobValue:=TMemoryStream.Create;
       try
        VariantToStream(Value,BlobValue);
        LoadFromStream(BlobValue);
       finally
        BlobValue.Free
       end;
     end
   end
   else
   if vt and varByRef <> 0 then
   begin
        v:=TVarData(Value);
        case vt and not varByRef of
          varSmallInt: AsLong := PSmallInt(v.VPointer)^;
          varInteger:  AsLong := PInteger(v.VPointer)^;
          varSingle:   AsDouble := PSingle(V.VPointer)^;
          varDouble:   AsDouble := PDouble(V.VPointer)^;
          varCurrency: AsCurrency := PCurrency(V.VPointer)^;
          varDate:
               case sSQLType of
                SQL_TYPE_TIME: AsTime:=PDate(V.VPointer)^;
                SQL_TYPE_DATE: AsDate:=PDate(V.VPointer)^;
               else
                AsDateTime := PDate(V.VPointer)^;
               end ;
          varOleStr:   begin
    {$IFNDEF D6+}
                        ws:=Value;
    {$ELSE}
                        ws:=VarToWideStr(Value);
    {$ENDIF}
                        AsVariant:=ws;
                       end;
 
          varBoolean:  AsBoolean := PWordBool(V.VPointer)^;
    {$IFDEF D6+}
          varShortInt: AsLong :=PShortInt(V.VPointer)^;
    {$ENDIF}
          varByte:     AsLong := PByte(V.VPointer)^;
    {$IFDEF D6+}
          varWord:     AsLong := PWord(V.VPointer)^;
          varLongWord: AsLong := PLongWord(V.VPointer)^;
          varInt64:    AsInt64:= PInt64(V.VPointer)^;
    {$ENDIF}
          varVariant:  AsVariant:= Variant(PVarData(V.VPointer)^);
        else
           FIBError(feNotPermitted, [nil]);
        end
   end
   else
     FIBError(feNotPermitted, [nil]);

  end;
end;

procedure TFIBXSQLVAR.SetAsXSQLVAR(aValue: PXSQLVAR);
begin
   SetValue(0,0, tspSqlVar,aValue)
end;

procedure TFIBXSQLVAR.SetIsNull(aValue: Boolean);
begin
  SetValue(0,0,tspNull,aValue)
end;
 
procedure TFIBXSQLVAR.SetIsNullable(aValue: Boolean);
begin
  SetValue(0,0,tspIsNullable,aValue)
end;
 
function  TFIBXSQLVAR.GetScale: integer;
begin
  Result:=FXSQLVAR^.sqlscale
end;

 
procedure TFIBXSQLVAR.SetScale(Value: integer);
begin
 SetValue(0,0,tspScale,Value)
end;

function  TFIBXSQLVAR.IsBlob:boolean;
begin
  case SQLType of
     SQL_BLOB,SQL_ARRAY:   Result:=True;
  else
    Result := False;
  end;
end;

function  TFIBXSQLVAR.IsParam:boolean;
begin
  Result:= Assigned(FParent) and FParent.FIsParams
end;

function  TFIBXSQLVAR.SqlName:string;
begin
  if not Assigned(FParent) or FParent.FIsParams then
   Result := ''
  else
  with FParent.FXSQLVARs[FIndex].Data^ do
    SetString(Result, sqlname, sqlname_length)
end;

function  TFIBXSQLVAR.AliasName:string;
begin
  if not Assigned(FParent) or FParent.FIsParams then
   Result := ''
  else
  with FParent.FXSQLVARs[FIndex].Data^ do
    SetString(Result, aliasname, aliasname_length)
end;

function  TFIBXSQLVAR.RelationName:string;
begin
  if not Assigned(FParent) or FParent.FIsParams then
   Result := ''
  else
  with FParent.FXSQLVARs[FIndex].Data^ do
    SetString(Result, relname, relname_length)
end;
 
 
 
function TFIBXSQLVAR.CharacterSet :string;
begin
  if not Assigned(FParent) then
   Result :=UnknownStr
  else
  with FParent.FXSQLVARs[FIndex].Data^ do
  begin
    if  (Byte(sqlsubtype)<61) then
     Result:=IBStdCharacterSets[Byte(sqlsubtype)]
    else
     Result :=UnknownStr
  end
end;
 
function  TFIBXSQLVAR.GetAsBcd: TBcd;
begin
  if (FQuery.Database.SQLDialect < 3) or (FXSQLVAR^.sqltype and (not 1)<>SQL_INT64)
  then
  begin
   if not CurrToBCD(GetAsCurrency,Result) then
     FIBError(feInvalidDataConversion, [nil])
  end
  else
  begin
   if not Int64ToBCD(PInt64(FXSQLVAR^.sqldata)^,-FXSQLVAR^.sqlscale,Result) then
     FIBError(feInvalidDataConversion, [nil])
  end;
end;
 
procedure TFIBXSQLVAR.SetAsBcd(Value: TBcd);
var e:extended;
    C:Int64;
    lScale  :byte;
begin
  if (FQuery.Database.SQLDialect < 3) then
  begin
   if not BCDToExtended(Value,e) then
     FIBError(feInvalidDataConversion, [nil]);
   SetAsExtended(e);
  end
  else
  begin
   if not BCDToCompWithScale(Value,c,lScale) then
    FIBError(feInvalidDataConversion, [nil]);
   SetValue(SQL_INT64,SizeOf(Comp),tspValue,C);
   Scale :=-lScale;
  end;
end;

 
function  TFIBXSQLVAR.GetAsGUID: TGUID;
begin
  if not IsNull then
   case FXSQLVAR^.sqltype and (not 1) of
    SQL_VARYING: Result := PGUID(FXSQLVAR^.sqldata+2)^;
    SQL_TEXT   : Result := PGUID(FXSQLVAR^.sqldata)^  ;
   end
  else
   Result:= fibGUID_NULL
end;

procedure TFIBXSQLVAR.SetAsGuid(aValue: TGUID);
begin
 SetValue(SQL_TEXT,SizeOf(aValue),tspValue,aValue);
end;
 
function TFIBXSQLVAR.GetAsBoolean: boolean;
begin
  Result := False;
  if not IsNull then
    case FXSQLVAR^.sqltype and (not 1) of
      SQL_BOOLEAN,SQL_SHORT:
        Result := PShort(FXSQLVAR^.sqldata)^=ISC_TRUE;
      SQL_LONG:
       Result  := PLong(FXSQLVAR^.sqldata)^=ISC_TRUE;
      SQL_INT64:
       Result  := PInt64(FXSQLVAR^.sqldata)^=ISC_TRUE;
    else
        FIBError(feInvalidDataConversion, [nil])
    end;
end;
 
procedure TFIBXSQLVAR.SetAsBoolean(const Value: boolean);
begin
  SetAsShort(Ord(Value));
end;
 
(* TFIBXSQLDA *)
constructor TFIBXSQLDA.Create(aIsParams:boolean);
begin
  FNames                 := TStringList.Create;
  with FNames do
  begin
   Sorted          := True;
   Duplicates      := dupAccept;
  end;

  FEquelNames            := TStringList.Create;
  with FEquelNames do
  begin
   Sorted     := True;
   Duplicates := dupAccept;
  end;
 
  FCachedNames           := TStringList.Create;
  with FCachedNames do
  begin
   Sorted     := True;
   Duplicates := dupIgnore;
  end;
  FIsParams              := aIsParams;
  FSize                  := 0;
  FXSQLDA                := nil;
end;
 
 
destructor TFIBXSQLDA.Destroy;
var 
  i:  Integer;
begin
  FNames.Free;
  FEquelNames.Free;
  FCachedNames.Free;  
  if FXSQLDA <> nil then
  begin
    for i := 0 to FSize - 1 do
    with FXSQLDA^.sqlvar[i] do
    begin
      FIBAlloc(sqldata, 0, 0);
      FIBAlloc(sqlind, 0, 0);
      FXSQLVARs^[i].Free;
    end;
    FIBAlloc(FXSQLDA, 0, 0);
    FIBAlloc(FXSQLVARs, 0, 0);
    FXSQLDA := nil;
  end;
  inherited;
end;
 

function TFIBXSQLDA.FindParam(const aParamName: string): TFIBXSQLVAR;
begin
  Result := ByName[aParamName];
end;

function TFIBXSQLDA.ParamByName(const aParamName: string): TFIBXSQLVAR;
begin
  Result := ByName[aParamName];
  if Result=nil then
   raise Exception.Create(
     Format(SFIBErrorParamNotExist, [aParamName, CmpFullName(FQuery)])
   );
end;

procedure  TFIBXSQLDA.AssignValues(SourceSQLDA:TFIBXSQLDA);
var i:integer;
    pc:integer;
    uSType,sSType :integer; //parameterType
    CurPar,Srvpar:TFIBXSQLVAR;
begin
// uSType - user Params[i].SQLType
// sSType - real Params[i].SQLType
 pc:=Pred(SourceSQLDA.Count);
 for i:=0 to pc do
 begin
   CurPar:=SourceSQLDA[i];
   Srvpar:=ByName[CurPar.Name];
   if (Srvpar<>nil) and (CurPar<>nil) then
   with Srvpar do
   begin
    if CurPar.IsNull then
    begin
       AsVariant:= Null;
       Continue;
    end;
    sSType:=FXSQLVAR^.sqltype and (not 1);
    uSType:=CurPar.FXSQLVar^.sqltype and (not 1);
 
    if  ((uSType = SQL_BLOB) or (uSType = SQL_ARRAY))
     and ((sSType = SQL_BLOB) or (sSType = SQL_ARRAY))
    then
      AsQuad:=CurPar.AsQuad
    else
    begin
     if uSType = SQL_INT64 then
     begin
      if (sSType = SQL_BLOB) or (sSType = SQL_ARRAY) then
       AsInt64:=0;
      Assign(CurPar);
     end
     else
{     if IsDateTimeType(sSType) then
     begin
       if CurPar.AsString<>'' then
        if uSType = SQL_TEXT then
         SetAsString(CurPar.AsString)
        else
        case sSType of
         SQL_TIMESTAMP:SetAsDateTime(CurPar.Value);
         SQL_TYPE_TIME:SetAsTime(CurPar.Value);
         SQL_TYPE_DATE:SetAsDate(CurPar.Value)
        else
         SetAsString(CurPar.AsString);
        end
       else
        AsVariant:= CurPar.asVariant;
     end
     else}
     begin
      AsVariant:= CurPar.asVariant;
     end
    end
   end;
 end; 
end;
 
procedure  TFIBXSQLDA.ClearValues;
var 
   j:  integer;
   b:boolean;
begin
 for j :=0  to Pred(Count) do
 begin
  b:=FXSQLVARs^[j].IsNullable;
  FXSQLVARs^[j].IsNull:=True;
  FXSQLVARs^[j].IsNullable:=b;  
 end;
end;
 
 
procedure TFIBXSQLDA.AddName(const FieldName: string; Idx: Integer; Quoted:boolean);
var
  fn: string;
  i : integer;
begin
  if not Quoted then
    fn := FastUpperCase(FieldName)
  else
    fn := FieldName;
  if FIsParams then
   with FEquelNames do
   begin
    if Find(fn,i) then
     AddObject(fn,TObject(Idx))
    else
    if FNames.Find(fn,i) then
    begin
     AddObject(fn,TObject(Idx));
     AddObject(fn,FNames.Objects[i]);
    end;
   end;

  FNames.AddObject(fn,TObject(Idx));
  with FXSQLVARs^[Idx] do
  begin
   FName  := fn;
   FIndex := Idx;
  end;
end;

procedure TFIBXSQLDA.AdjustDefferedSettings;
var 
 i:  Integer;
 s: string;
 sSQLType:integer;
 uSQLType:integer;
begin
// Преобразования которые не произошли в момент присвоения.
// Потому что присваивали до того как запрос был отпрепарен
  for i:=0 to FCount - 1 do
  if FXSQLVARs^[i].FIsDefferedSetting then
  begin
    sSQLType:=FXSQLVARs^[i].ServerSqlType;
    uSQLType:=FXSQLVARs^[i].SqlType;
    case uSQLType of
      SQL_TEXT,SQL_VARYING:
        begin
         //UNICODE;
         s:=FXSQLVARs^[i].GetAsString;
         FXSQLVARs^[i].InternalSetAsString(@s, False,True)
        end;
     SQL_DOUBLE,SQL_INT64,SQL_LONG,SQL_FLOAT,SQL_SHORT:
      if ((sSQLType=SQL_TIMESTAMP) or (sSQLType=SQL_TYPE_DATE) or (sSQLType=SQL_TYPE_TIME)) then
      begin
       FXSQLVARs^[i].SetAsDateTime(FXSQLVARs^[i].Value)
      end;
     SQL_BLOB:
     if FQuery.Database.NeedUTFEncodeDDL then // More FB21
      if FXSQLVARs^[i].ServerSQLSubType=1 then // Blob Text
       if FXSQLVARs^[i].FSrvSQLScale in FQuery.Database.UnicodeCharsets then
       begin
         s:=FXSQLVARs^[i].GetAsString;
         FXSQLVARs^[i].InternalSetAsString(@s, False,True)
       end;
 
    end;
  end;
  FHasDefferedSettings:=False
end;

function TFIBXSQLDA.GetModified: Boolean;
var 
 i: Integer;
begin
  Result := False;
  for i:=0 to FCount - 1 do
   if FXSQLVARs^[i].Modified then
   begin
    Result := True;
    Exit;
   end;
end;

procedure TFIBXSQLDA.SetUnModifiedToVars;
var i: Integer;
begin
  for i:=0 to FCount - 1 do
   FXSQLVARs^[i].Modified:=False;
end;

function TFIBXSQLDA.GetNames: string;
begin
  Result := FNames.Text;
end;
 
function TFIBXSQLDA.GetRecordSize: Integer;
begin
  Result := SizeOf(TFIBXSQLDA) + XSQLDA_LENGTH(FSize);
end;
 
function TFIBXSQLDA.GetXSQLDA: PXSQLDA;
begin
  Result := FXSQLDA;
end;

function TFIBXSQLDA.GetXSQLVAR(Idx: Integer): TFIBXSQLVAR;
begin
  if (Idx < 0) or (Idx >= FCount) then
    FIBError(feXSQLDAIndexOutOfRange, [nil]);
  Result := FXSQLVARs^[Idx]
end;

 
function TFIBXSQLDA.GetXSQLVARByName(const Idx: string): TFIBXSQLVAR;
var 
  s: string;
  i: Integer;
begin
  if FCachedNames.Find(Idx,i) then
  begin
   Result:=TFIBXSQLVAR(FCachedNames.Objects[i]);
   Exit;
  end;

  if (Length(Idx) > 0) and (Idx[1]='"') then
     s := FastCopy(s,2,Length(s)-2)
  else
  if Assigned(FQuery) and Assigned(FQuery.Database) then
   if FQuery.Database.SQLDialect=1 then
    s := FastUpperCase(Idx)
   else
   begin
     with FQuery.Database do
      if UpperOldNames  and  not EasyNeedQuote(Idx) then
        s := FastUpperCase(Idx)
      else
        s := Idx
   end
  else
   s := FastUpperCase(Idx);

 
   if FNames.Find(s,i) then
    Result := GetXSQLVAR(Integer(FNames.Objects[i]))
   else
    Result := nil;   
// For params from macros
  if (Result=nil) and (FQuery<>nil) and (Self=FQuery.FUserSQLParams)
  then
  begin
    if FQuery.MacroChanged then FQuery.ApplyMacro;
    Result:=FQuery.FSQLParams.GetXSQLVARByName(Idx)
  end
  else
  if Assigned(Result) then
  begin
   FCachedNames.AddObject(Idx,Result);
  end
end;
 
 
procedure TFIBXSQLDA.Initialize;
var 
  i, j,c: Integer;
  NamesWereEmpty: Boolean;
  st,st1: string;
begin
  NamesWereEmpty := (FNames.Count = 0);
  if FXSQLDA <> nil then
  begin
    j:=0;
    for i := 0 to FCount - 1 do
    begin
      with FXSQLVARs^[i].Data^ do
      begin
        FXSQLVARs^[i].FSrvSQlType :=sqltype and (not 1);
        FXSQLVARs^[i].FSrvSQlLen :=sqllen;
        FXSQLVARs^[i].FSrvSQLScale:=sqlscale;
        FXSQLVARs^[i].FSrvSQLSubType:=sqlsubtype;
        FXSQLVARs^[i].FInitialized:=True;
        if NamesWereEmpty then
        begin
          if FQuery.Database.IsUnicodeConnect then
           st := UTF8Decode(aliasname)
          else
{$IFDEF SUPPORT_KOI8_CHARSET}
          if FQuery.Database.IsKOI8Connect then
           st := ConvertFromCodePage(aliasname,CodePageKOI8R)
          else
{$ENDIF}
           st := aliasname;
          if st = '' then
          begin
            Inc(j);
            st := 'F_'+IntToStr(j);
            StrPCopy(aliasname, st);
            aliasname_length:=Length(st)            
          end
          else
          if GetXSQLVARByName(st)<>nil then
          begin
//              Reapeated FieldNames          
            c:=0;
            repeat
             Inc(c);
             st1:=st+IntToStr(c);
             if Length(st1)>=LENGTH_METANAMES-1 then
              st1:=
                FastCopy(st,1,Length(st)-(Length(st1)-LENGTH_METANAMES))+IntToStr(c);
            until GetXSQLVARByName(st1)=nil;
 
            StrPCopy(aliasname, st1);
            st:=st1;
            aliasname_length:=Length(st)
          end;
          AddName(st,i,True);
        end;
        case sqltype and (not 1) of
          0:
           if Self<>FQuery.FUserSQLParams then
           begin
            FIBError(feUnknownSQLDataType, [sqltype and (not 1)])
           end;
          SQL_TEXT:
            if (sqllen = 0) then
             FIBAlloc(sqldata, 0, 1)
            else
             FIBAlloc(sqldata, 0, sqllen);
          SQL_TYPE_DATE, SQL_TYPE_TIME, SQL_TIMESTAMP,
          SQL_BLOB, SQL_ARRAY, SQL_QUAD, SQL_SHORT,
          SQL_LONG, SQL_INT64, SQL_DOUBLE, SQL_FLOAT, SQL_D_FLOAT,SQL_BOOLEAN:
          begin
            FIBAlloc(sqldata, 0, sqllen);
          end;
          SQL_VARYING:
          begin
             FIBAlloc(sqldata, 0, sqllen + 2);
          end
        else
            FIBError(feUnknownSQLDataType, [sqltype and (not 1)])
        end;
        if (sqltype and 1 = 1) then
          FIBAlloc(sqlind, 0, SizeOf(Short))
        else
        if (sqlind <> nil) then
          FIBAlloc(sqlind, 0, 0);
      end;
    end;
  end;
end;

procedure TFIBXSQLDA.SetCount(Value: Integer);
var
  i, OldSize: Integer;
begin
  FNames.Clear;
  FEquelNames.Clear;
  FCachedNames.Clear;
  FCount := Value;
  if FSize > 0 then
    OldSize := XSQLDA_LENGTH(FSize)
  else
    OldSize := 0;

  if FCount > FSize then
  begin
    FIBAlloc(FXSQLDA, OldSize, XSQLDA_LENGTH(FCount));
    FIBAlloc(FXSQLVARs, FSize * SizeOf(TFIBXSQLVAR), FCount * SizeOf(TFIBXSQLVAR));
    FXSQLDA^.version := SQLDA_VERSION_CURRENT  ;
    for i := 0 to FCount - 1 do
    begin
      if i >= FSize then
      begin
        FXSQLVARs^[i] := TFIBXSQLVAR.Create(Self);
        FXSQLVARs^[i].FQuery := FQuery;
      end;
      FXSQLVARs^[i].FXSQLVAR := @FXSQLDA^.sqlvar[i];
    end;
    FSize := FCount;
  end;
  if (FSize > 0)then
  begin
    FXSQLDA^.sqln := Value;
    FXSQLDA^.sqld := Value;
  end;
end;
 
(* TFIBQuery *)
constructor TFIBQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSQLTextChangeCount:=0;
  FAutoCloseOnTransactionEnd:=True;
 
{$IFDEF CSMonitor}
  FCSMonitorSupport := TCSMonitorSupport.Create(Self);
{$ENDIF}

  FBase := TFIBBase.Create(Self);
  with FBase do
  begin
   OnDatabaseDisconnecting := DatabaseDisconnecting;
   OnTransactionEnding     := DoTransactionEnding;
  end;
  FBOF := False;
  FEOF := False;
  FPrepared := False;
  FRecordCount := 0;
  FSQL := TStringList.Create;
  TStringList(FSQL).OnChanging := SQLChanging;
  FHandle := nil;
  FSQLParams := TFIBXSQLDA.Create(True);
  FSQLParams.FQuery := Self;
  FSQLRecord := TFIBXSQLDA.Create(False);
  FSQLRecord.FQuery := Self;
  FUserSQLParams:=TFIBXSQLDA.Create(True);
  FUserSQLParams.FQuery := Self;
  FSQLType := SQLUnknown;
  FProcExecuted:=False;
  FMacroChar   :='@';
  FConditions       :=TConditions.Create(Self);
  FParser:=    TSQLParser.Create;
  TStringList(FSQL).OnChange   := SQLChange;

  if (csDesigning in ComponentState) and   not CmpInLoadedState(Self)  then
  begin
  //Default values from tools
    ParamCheck               := DefParamCheck;
    GoToFirstRecordOnExecute := DefGoToFirstRecordOnExecute;
    FOptions                 := DefQueryOptions;
    DataBase                 := DefDataBase;
  end
  else
  begin
   FParamCheck :=True;
   FGoToFirstRecordOnExecute :=True;
   FOptions    :=[];
  end;

  FCountLockSQL:=0;
  FModifyTable:='-1';
 
  if AOwner is TFIBDatabase then
    Database := TFIBDatabase(AOwner)
  else
    if AOwner is TFIBTransaction then  Transaction := TFIBTransaction(AOwner);
  vDiffParams    :=False;
  FOnlySrvParams :=TStringList.Create;
  with FOnlySrvParams do
  begin
    Sorted    :=True;
    Duplicates:=dupIgnore;
  end;
  FCallTime :=0;
  vUserParamsCreated:=False;
  FMacroChanged     :=False;
 
end;
 
destructor TFIBQuery.Destroy;
begin
  if (FOpen) then   Close;
  if (FHandle <> nil) then   FreeHandle;

{$IFDEF CSMonitor}
  FCSMonitorSupport.Free;
{$ENDIF}
 
  FBase.Free;
  FSQLParams.Free;
  FSQLRecord.Free;
  FUserSQLParams.Free;
  FOnlySrvParams.Free;
  FConditions.Free;
  FParser.Free;
  SetLength(FExtSQLDA,0);
  inherited;
  FSQL.Free;
end;

procedure   TFIBQuery.Loaded;
begin
  inherited;
end;

{$DEFINE FIB_IMPLEMENT}
{$I FIBQueryPT.inc}
{$UNDEF FIB_IMPLEMENT}
 

function TFIBQuery.BatchInput(InputObject: TFIBBatchInputStream):boolean;
var RecNum:integer;
    BatchAction :TBatchAction;
    ErrorAction :TBatchErrorAction;
 
begin
    if not Prepared then
     Prepare;
    Result:= FSQLType in [SQLInsert, SQLUpdate, SQLDelete, SQLExecProcedure] ;
    if not Result then
     Exit;
    InputObject.FParams := Self.FUserSQLParams;
//    Self.FUserSQLParams.Initialize;
    InputObject.ReadyStream;
    Result:=InputObject.State=bsFileReady;
    RecNum:=1;
    BatchAction := baContinue;
  while InputObject.ReadParameters do
  begin
     if Assigned(FOnBatching) then
     begin
       FOnBatching(boInput,RecNum,BatchAction);
       Inc(RecNum);
     end;

     case BatchAction of
      baContinue:
      begin
        ErrorAction:=beRetry;
        while ErrorAction=beRetry do
        try
          ExecQuery;
          ErrorAction:=beIgnore;
        except
         on  E:EFIBError do
          if Assigned(FOnBatchError) then
          begin
            ErrorAction:=beFail;
            FOnBatchError(E,ErrorAction);
            case ErrorAction of    //
              beFail : raise;
              beAbort: Abort;
            end;    // case
          end
          else
            raise
        end;
      end;
      baStop    : Exit;
     else
      BatchAction := baContinue;
     end;
  end;
end;

function TFIBQuery.BatchOutput(OutputObject: TFIBBatchOutputStream):boolean;
var RecNum:integer;
    BatchAction :TBatchAction;
begin
  CheckClosed('batch output');
  if not Prepared then  Prepare;
  Result:= FSQLType = SQLSelect;
  if not Result then Exit;
   try
      ExecQuery;
      OutputObject.FColumns := Self.FSQLRecord;
      OutputObject.ReadyStream;
      Result:=OutputObject.State=bsFileReady;
      RecNum:=1;
      BatchAction := baContinue;
      if not FGoToFirstRecordOnExecute then
        Next;
      while (not Eof) do
      begin
       if Assigned(FOnBatching) then
       begin
        FOnBatching(boOutput,RecNum,BatchAction);
        Inc(RecNum);
       end;
       case BatchAction of
        baContinue: if not (OutputObject.WriteColumns) then Break;
        baStop    : Break;
       else
        BatchAction := baContinue;       
       end;
       Next;
      end;
    Close;
   except
      Close;
      Result:=False
   end;
end;

{$IFDEF WINDOWS}
procedure TFIBQuery.BatchInputRawFile(const FileName:string);
var
   RawInput : TFIBInputRawFile;
begin
  RawInput := TFIBInputRawFile.Create;
  try
    RawInput.FileName := FileName;
    BatchInput(RawInput);
  finally
    RawInput.Free;
  end;
end;

procedure TFIBQuery.BatchOutputRawFile(const FileName:string;Version:integer=1);
var
   RawOutput :  TFIBOutputRawFile;
begin
  if not (Version in [1,2]) then
    Version:=1;
  RawOutput:= TFIBOutputRawFile.CreateEx(Version);
  try
    RawOutput.FileName := FileName;
    BatchOutput(RawOutput);
  finally
    RawOutput.Free;
  end;
end;
{$ENDIF}

procedure TFIBQuery.BatchToQuery(ToQuery:TFIBQuery;Mappings:TStrings);
var Map     :TList;
    i,RecNum:Integer;
    BatchAction :TBatchAction;
    ErrorAction :TBatchErrorAction;
 
function GetParam(const FieldName:string):TFIBXSQLVAR;
var j,p: integer;
    s:string;
begin
   s:='';
   if Mappings=nil then
    s:=FieldName
   else
   for j:=0 to Pred(Mappings.Count) do
   begin
    p:=PosCI('='+FieldName,Mappings[j]);
    if (p>0) and (p+Length(FieldName) = Length(Mappings[j])) then
    begin
     s:=FastCopy(Mappings[j],1,p-1);
     Break;
    end;
   end;
   if s='' then s:=FieldName;
   Result := ToQuery.FindParam(s)
end;
 
begin
 if ToQuery=nil then Exit;
 Close;
 if not Prepared then Prepare;
 if not ToQuery.Prepared then ToQuery.Prepare;
 Map := TList.Create;
 try
  Map.Count := FieldCount;
  for i:=0 to Pred(FieldCount) do
   Map[i]:=GetParam(Fields[i].Name);
  ExecQuery;
  RecNum:=1;
  while not eof do
  begin
   BatchAction := baContinue;
   if Assigned(FOnBatching) then
   begin
     FOnBatching(boOutputToQuery,RecNum,BatchAction);
     Inc(RecNum);
   end;
   case BatchAction of
    baContinue:
    begin
     for i:=0 to Pred(FieldCount) do
      if Map[i]<>nil then
       TFIBXSQLVAR(Map[i]).Assign(Fields[i]);
     ErrorAction:=beRetry;
     while ErrorAction=beRetry do
      try
        ToQuery.ExecQuery;
        ErrorAction:=beIgnore;
      except
       on  E:EFIBError do
        if Assigned(FOnBatchError) then
        begin
          ErrorAction:=beFail;
          FOnBatchError(E,ErrorAction);
          case ErrorAction of    //
            beFail : raise;
            beAbort: Abort;
          end;    // case
        end
        else
          raise
      end;
    end;
    baStop    : Exit;
   else
    BatchAction := baContinue;
   end;
   Next;
  end;
 finally
  Map.Free;
 end;
end;

procedure TFIBQuery.CheckClosed(const OpName:string);
begin
  if FOpen then
   FIBError(feDatasetOpen, [OpName,CmpFullName(Self)]);
end;
 
procedure TFIBQuery.CheckOpen(const OpName:string);
begin
  if not FOpen then
   FIBError(feDatasetClosed, [OpName,CmpFullName(Self)]);
end;

procedure TFIBQuery.CheckValidStatement;
var 
  ForceConnect:  boolean;
  ForceTransaction:boolean;
begin
  if not Assigned(Database) then
    FIBError(feDatabaseNotAssigned, [CmpFullName(Self)]);
  if not Assigned(Transaction) then
    FIBError(feTransactionNotAssigned, [CmpFullName(Self)]);
 
  ForceConnect:=not Database.Connected;
  if ForceConnect then Database.Connected:=True;
  ForceTransaction:=not Transaction.InTransaction;
  if ForceTransaction then
   Transaction.StartTransaction;
  try
   try
    Prepare;
   except
     FIBError(feInvalidStatementHandle, [CmpFullName(Self)]);
   end;
  finally
   if ForceTransaction then
    Transaction.Commit;
   if ForceConnect then
    Database.Connected:=False;
  end;
end;

procedure TFIBQuery.Close;
var      
  isc_res:  ISC_STATUS;
begin
  try
    if (FHandle <> nil)  and FOpen then
    case SQLType of
    SQLSelect,SQLSelectForUpdate:
      begin
        isc_res :=
          Call(
           Database.ClientLibrary.isc_dsql_free_statement(StatusVector, @FHandle, DSQL_close),
           False
          );
        if (StatusVector^ = 1) and (isc_res > 0)
         and not CheckStatusVector([isc_bad_stmt_handle, isc_dsql_cursor_close_err]) then
          IBError(Database.ClientLibrary,Self);
      end;
    end;
  finally
    FEOF := False;
    FBOF := False;
    FOpen := False;
    FProcExecuted:=False;
    if  (qoFreeHandleAfterExecute in Options) then
     FreeHandle   
  end;
end;
 
function TFIBQuery.Call(ErrCode: ISC_STATUS; RaiseError: Boolean): ISC_STATUS;
begin
  Set8087CW(Default8087CW);
  Result := 0;
  if Transaction <> nil then
    Result := Transaction.Call(ErrCode, False);
  if (ErrCode > 0) and RaiseError then
    IbError(Database.ClientLibrary,Self);
end;
 
function TFIBQuery.Current: TFIBXSQLDA;
begin
  Result := FSQLRecord;
end;
 
procedure TFIBQuery.DatabaseDisconnecting(Sender: TObject);
begin
  if (FHandle <> nil) then
  begin
    Close;
    FreeHandle;
  end;
end;
 


procedure TFIBQuery.BeginModifySQLText;
begin
 Inc(FCountLockSQL)
end;

procedure TFIBQuery.EndModifySQLText;
begin
  if FCountLockSQL>0 then Dec (FCountLockSQL)
  else FCountLockSQL:=0;
  if FCountLockSQL=0 then
   SQLChange(nil);
end;

function  TFIBQuery.CountModifySQLText:integer;
begin
  Result:=FCountLockSQL;
end;
 
function  TFIBQuery.GetMainWhereIndex:integer;
begin
 Result :=MainWhereIndex(SQL.Text);
end;

function  TFIBQuery.GetMainWhereClause :string;
var ind :integer;
begin
 ind := GetMainWhereIndex;
 if ind=-1 then
  Result :=''
 else
  Result :=WhereClause[ind]
end;

procedure TFIBQuery.SetMainWhereClause (const Value:string);
begin
 SQL.Text:=FParser.SetMainWhereClause(Value);
end;
 
 
 


 
function  TFIBQuery.ParamsNotExist(const SQLText:string):boolean;
var 
       i:  integer;
   State:TParserState;
   QuoteChar:Char;
begin
 State:=sNormal;
 QuoteChar:='''';
 for i:=2 to Length(SQLText) do
 begin
  case State of
   sNormal:
    case SQLText[i] of
     '?',':':
         begin
           Result:=False;
           Exit;
         end;
     '*':
       if (SQLText[i-1]='/' ) then
         State:=sComment;
     '''','"':
       begin
        QuoteChar:=SQLText[i];
        State:=sQuote
       end;
     '-':
       if (SQLText[i-1]='-' ) then
         State:=sFBComment;
    else
     if SQLText[i]=FMacroChar then
     begin
           Result:=False;
           Exit;
     end;

    end;
   sQuote:
    if SQLText[i]=QuoteChar then
      State:=sNormal;
   sComment:
    if (SQLText[i]='/')  and (SQLText[i-1]='*') then
      State:=sNormal;
   sFBComment:
    if (SQLText[i]=#13)  then
      State:=sNormal;
  end;
 end;
 Result:=True;
end;

procedure TFIBQuery.SaveRestoreValues(SQLDA:TFIBXSQLDA;IsSave:boolean);
var j,pc:integer;
begin
   pc  :=Pred(SQLDA.Count);
   if IsSave then
     for j := 0 to pc do
     begin
      if SQLDA[j].FInitialized then
        SQLDA[j].FOldValue:=SQLDA[j].Value
     end
   else
     for j := 0 to pc do
     case SQLDA[j].SQLType of
      SQL_BLOB,SQL_ARRAY:;
     else
      if not VarIsEmpty(SQLDA[j].FOldValue) then
       SQLDA[j].Value := SQLDA[j].FOldValue
      else
       if SQLDA[j].SQLType=SQL_VARYING then
         SQLDA[j].FXSQLVAR^.sqltype:=SQL_TEXT;
     end
end;


{$IFNDEF NO_MONITOR}
type THackMonitorHook=class(TFIBSQLMonitorHook);
{$ENDIF}




function  TFIBQuery.ReadySQLText(ForChangeExecSQL:boolean=True):string;
type
 TCompareNull=(cNone,cIsNull,cIsNotNull);
var i,j:integer;
    pv:string;
    vLenMacro:integer;
    vDelta   :integer;
    pv1      :string;
    c        :TCompareNull;
const  StrIsNull=' IS NULL ';
       StrIsNotNull=' IS NOT NULL ';
 
begin
  if ForChangeExecSQL then
   vDiffParams:=False;
  Result:=FParser.SQLText;
  vDelta:=0;
  for i := 0 to Pred(Params.Count) do
  if Params[i].IsMacro then
  begin
     vLenMacro:=Params[i].FEndPosInText-Params[i].FBeginPosInText+1;
     pv :=Params[i].asString;
     if Params[i].Quoted then
     begin
      if pv='' then
       pv1:=''''+''''
      else
      if pv[1]='''' then
       pv1:=pv
      else
      begin
        pv1:=pv+'''';
        if pv1[1]='#' then
         pv1[1]:=''''
        else
         pv1:=''''+pv1
      end;
     end
     else
      pv1:=pv;
     Result:=Copy(Result,1, Params[i].FBeginPosInText-vDelta-1)+pv1+
         Copy(Result,Params[i].FEndPosInText-vDelta+1,MaxInt);
     Inc(vDelta,vLenMacro-Length(pv1));
     Params[i].FOldValue:=pv;
   if ForChangeExecSQL then     
     vDiffParams:=True;
  end
  else
  if not(qoNoForceIsNull in Options)
   and ((qrsInExecute in FQueryRunState) or not (qrsInPrepare in FQueryRunState))
//^^^  чтоб не заменялось при простом препаре. Заменялось только непосредственно перед вызовом на исполнение   
  then
  if Params[i].isNull and Params[i].InWhereClause and Params[i].FCanForceIsNull then
  begin
   J:=Params[i].FBeginPosInText-1;
   while FParser.SQLText[J] in CharsAfterClause do
    Dec(J);
   c:=cNone;
   case FParser.SQLText[J] of
    '>': if FParser.SQLText[J-1]='<' then
         begin
          c:=cIsNotNull;
          Dec(J);
         end;
 
    '=':
          if FParser.SQLText[J-1] in ['!','^','~'] then
          begin
           c:=cIsNotNull;
           Dec(J);
          end
          else
          if not (FParser.SQLText[J-1] in ['<','>']) then
            c:=cIsNull
   end;

   if c<>cNone then
   begin
    vLenMacro:=Params[i].FEndPosInText-J+1;

    case  c of
    cIsNull:     pv1:=StrIsNull;
    cIsNotNull:
     pv1:=StrIsNotNull
    end;
    Result:=Copy(Result,1, J-vDelta-1)+pv1+
     Copy(Result,Params[i].FEndPosInText-vDelta+1,MaxInt);
    Inc(vDelta,vLenMacro-Length(pv1));
    if ForChangeExecSQL then
    begin
     Params[i].FOldValue:=null;
     vDiffParams:=True
    end;
   end;
  end;
end;

procedure TFIBQuery.StartStatisticExec(const stText:string);
begin
 if Assigned(Database.SQLStatisticsMaker) and  Database.SQLStatisticsMaker.ActiveStatistics then
 with Database.SQLStatisticsMaker do
 begin
  SetStringValue(stText,scLastQuery,CmpFullName(Self));
  FixStartTime(stText,scLastTimeExecute);
  IncCounter(stText,scExecuteCount);
 end;
end;
 
procedure TFIBQuery.DoStatisticPrepare(const stText:string);
begin
 if Assigned(Database.SQLStatisticsMaker) and  Database.SQLStatisticsMaker.ActiveStatistics then
 with Database.SQLStatisticsMaker do
 begin
  SetStringValue(stText,scLastQuery,CmpFullName(Self));
  IncCounter(stText,scPrepareCount);
 end;
end;
 
procedure TFIBQuery.EndStatisticExec(const stText:string);
var lt,s,j:integer;
    ts:TStrings;
begin
 if Assigned(Database.SQLStatisticsMaker) and  Database.SQLStatisticsMaker.ActiveStatistics then
 with Database.SQLStatisticsMaker do
 begin
  lt:=FixEndTime(stText,scLastTimeExecute);
  s:=AddIntValue(stText,scSumTimeExecute,lt);
  SetIntValue(stText,
   scAvgTimeExecute,
   Round(s/GetVarInt(stText,scExecuteCount))
  );
  if GetVarInt(stText,scMaxTimeExecute)<lt  then
  begin
   SetIntValue (stText,scMaxTimeExecute,lt);
   ts:=GetVarStrings(stText,scMaxTimeExecute);
   ts.Clear;
   for  j:= 0 to Params.Count-1 do
   with Params[j] do
   begin
    if   (FXSQLVAR^.sqltype and (not 1) <> SQL_ARRAY)
     and (FXSQLVAR^.sqltype and (not 1) <> SQL_BLOB)
    then
     ts.Add('Params['+IntToStr(j)+']='''+AsString+'''')
    else
     ts.Add('Params['+IntToStr(j)+']=('+
      IntToStr(Params[j].AsQuad.gds_quad_high)+','+
      IntToStr(Params[j].AsQuad.gds_quad_low)+')'
     ) 
   end;
  end;
 end;
end;

procedure TFIBQuery.DoBeforeExecute;
begin
  if Assigned(FBeforeExecute) then
   FBeforeExecute(Self);
  if not Assigned(Transaction) then
    FIBError(feTransactionNotAssigned, [CmpFullName(Self)]);
  FSQLRecord.ClearValues;
 
  if qoStartTransaction in Options then
   if (Transaction<>nil) and not Transaction.InTransaction then
    Transaction.StartTransaction;
  Transaction.DoOnSQLExec(Self,koBefore);
end;

procedure TFIBQuery.DoAfterExecute;
begin
  if Assigned(FAfterExecute) then FAfterExecute(Self);
  Transaction.DoOnSQLExec(Self,koAfter);
  Params.SetUnModifiedToVars;
  FMacroChanged:=False;
  ClearStreamedParams;

{$IFNDEF NO_MONITOR}
   if MonitoringEnabled  then
    if MonitorHook<>nil then
     MonitorHook.SQLExecute(Self);
{$ENDIF}

  if qoAutoCommit in Options then
  with Transaction do
  begin
    if TimeoutAction=TACommitRetaining then
     CommitRetaining
    else
     Commit;
  end;
end;

procedure  TFIBQuery.ConvertSQLTextToCodePage;
begin
  if not DisableEncodingSQLText and not FCodePageApplied then
  case SQLKind of
   skDDL: if Database.NeedUTFEncodeDDL  then
             FProcessedSQL:=UTF8Encode(FProcessedSQL);
  else
  {$IFDEF SUPPORT_KOI8_CHARSET}
   if Database.IsKOI8Connect  then
    FProcessedSQL:= ConvertToCodePage(FProcessedSQL,CodePageKOI8R)
   else
  {$ENDIF}
   if Database.IsUnicodeConnect then
    FProcessedSQL:=UTF8Encode(FProcessedSQL);
  end;
  FCodePageApplied:=True;
end;

procedure TFIBQuery.ExecuteImmediate;
var 
  xSQLDA:  PXSQLDA;
  pc: integer;
begin
  DoBeforeExecute;
{$IFDEF CSMonitor}
  if Pos('/* CSMON$', FParser.SQLText) <= 0 then
    FParser.SQLText := FParser.SQLText + GetCSMonText;
{$ENDIF}
  if (Length(FProcessedSQL) = 0) or FMacroChanged then
  begin
   PreprocessSQL(ReadySQLText,False);
   ConvertSQLTextToCodePage;
  end
  else
  if not FCodePageApplied then
    ConvertSQLTextToCodePage;
  SaveStreamedParams;
  pc:=Params.Count;
  if (vDiffParams and  FDoParamCheck and (pc>0)) then
  begin
   FSQLParams.AssignValues(FUserSQLParams);
   xSQLDA:=FSQLParams.AsXSQLDA;
  end
  else
  begin
   xSQLDA:=FUserSQLParams.AsXSQLDA;
   if FUserSQLParams.FHasDefferedSettings then
    FUserSQLParams.AdjustDefferedSettings;
  end;
  TraceString:=FProcessedSQL;
  FreeHandle;
  Call(
    Database.ClientLibrary.
    isc_dsql_execute_immediate(
     StatusVector, @Database.Handle, @Transaction.Handle, 0,
     PChar(FProcessedSQL), Database.SQLDialect, xSQLDA
    ),
   True
  );
  DoAfterExecute
 
end;
 
 
{$IFDEF SUPPORT_IB2007}
procedure TFIBQuery.ExecuteAsBatch(const SQLs:array of string);
var 
    vBatchBuffer,vb : PPChar;
    vBatchCount  : Integer;
    i:Integer;
    pCurCommand  : PChar;
    Results      : PULong;       
begin
 if Database.IsIB2007Connect and (Length(SQLs)>0) then
 begin
   vBatchCount :=Length(SQLs);
   vBatchBuffer:=nil;
   for i:=0 to Pred(vBatchCount) do
   begin
    FIBAlloc(vBatchBuffer, vBatchCount * Sizeof(PChar),
            (vBatchCount + 1) * Sizeof(PChar));
    GetMem(pCurCommand,Length(SQLs[i]) + 1);
    Move(SQLs[I][1], pCurCommand^, Length(SQLs[i]));
    pCurCommand[Length(SQLs[i])]:=#0;
    vb:=vBatchBuffer;
    Inc(vb,I);
    vb^:=pCurCommand;
   end;
    Results:=nil;
    try
     if vBatchCount>0 then
     begin
        if qoStartTransaction in Options then
         if (Transaction<>nil) and not Transaction.InTransaction then
            Transaction.StartTransaction;
 
      GetMem(Results, vBatchCount * Sizeof(ULong));
      Call(Database.ClientLibrary.isc_dsql_batch_execute_immed(StatusVector,
                              @Database.Handle, @Transaction.Handle, Database.SQLDialect,
                              vBatchCount, vBatchBuffer, Results), true);
     end
    finally
      vb := vBatchBuffer;
      for I := 0 to vBatchCount - 1 do
      begin
        FreeMem(vb^);
        Inc(vb);
      end;
      FreeMem(vBatchBuffer);
      FreeMem(Results);
    end;
 end;
end;
 
procedure TFIBQuery.ExecuteAsBatch;
var
    vBatchBuffer,vb :  PPChar;
    vBatchCount  : Integer;
//    curCommand   : string;
    curPos,LastPos: integer;
    SQLText      : string;
    pCurCommand  : PChar;
    Results      : PULong;
    I            :integer;
    ExistSQL     :Boolean;
 function GetCurCommand:boolean;
 var
    State: integer; //0 - норма,1- коммент ,2 кавычки одинарные,3 двойные
 begin
   Result:=False;
   State:=0;
   LastPos:=curPos;
   ExistSQL:=False;
   while LastPos<=Length(SQLText) do
   begin
     case State of
     0: case SQLText[LastPos] of
       '''':begin
              State:=2;
              Inc(LastPos);
            end;
       '"' :begin
              State:=3;
              Inc(LastPos);
            end;

       '/':begin
            if (LastPos<Length(SQLText)) and (SQLText[LastPos+1]='*') then
            begin
              State:=1;
              Inc(LastPos);
            end;
           end;
       ';':begin
             Inc(LastPos);
             Result :=True;
             Exit;
           end;
        else
         if SQLText[LastPos]>='A' then
         ExistSQL:=True;
        end;
      1: //State=1
      case SQLText[LastPos] of
      '*':begin
            if (LastPos<Length(SQLText)) and (SQLText[LastPos+1]='/') then
            begin
              State:=0;
              Inc(LastPos);
            end
          end;
      end;
      2:
      case SQLText[LastPos] of
       '''': State:=0;
      end;
      3:
      case SQLText[LastPos] of
       '"': State:=0;
      end;
 
     end;
    Inc(LastPos);
   end;
 end;

begin
 if Database.IsIB2007Connect then
 begin
  if not (qoStartTransaction in Options) then
   Transaction.CheckInTransaction
  else
   Database.CheckActive;
 
  vBatchCount :=0;
  vBatchBuffer:=nil;
  curPos:=1;
  SQLText:=SQL.Text;
 
  while GetCurCommand do
  begin
   if ExistSQL then
   begin
    FIBAlloc(vBatchBuffer, vBatchCount * Sizeof(PChar),
            (vBatchCount + 1) * Sizeof(PChar));
    GetMem(pCurCommand,LastPos-curPos + 1);
    Move(SQLText[curPos], pCurCommand^, LastPos-curPos);
    pCurCommand[LastPos-curPos]:=#0;
    vb:=vBatchBuffer;
    Inc(vb,vBatchCount);
    vb^:=pCurCommand;
    Inc(vBatchCount);
   end;
   CurPos:=LastPos
  end;// while
  Results:=nil;
  try
   if vBatchCount>0 then
   begin
      if qoStartTransaction in Options then
       if (Transaction<>nil) and not Transaction.InTransaction then
          Transaction.StartTransaction;
 
    GetMem(Results, vBatchCount * Sizeof(ULong));
    Call(Database.ClientLibrary.isc_dsql_batch_execute_immed(StatusVector,
                            @Database.Handle, @Transaction.Handle, Database.SQLDialect,
                            vBatchCount, vBatchBuffer, Results), true);
   end
  finally
    vb := vBatchBuffer;
    for I := 0 to vBatchCount - 1 do
    begin
      FreeMem(vb^);
      Inc(vb);
    end;
    FreeMem(vBatchBuffer);
    FreeMem(Results);
  end;
 end
end;
{$ENDIF}

procedure TFIBQuery.ExecQuery;
var
  fetch_res:  ISC_STATUS;
  pc:integer;
  SV:PISC_STATUS;
  xSQLDA:PXSQLDA;
  vParams:TFIBXSQLDA;
  st:string;
 
procedure DoLog(const Mess:string='Execute query:');
var 
   j:  integer;
begin
      if Assigned(Database.SQLLogger)  and (lfQExecute in Database.SQLLogger.LogFlags) then
      begin
        st:='';
        for  j:=0 to vParams.Count-1 do
         with vParams[j] do
         begin
          if   (FXSQLVAR^.sqltype and (not 1) <> SQL_ARRAY)
           and (FXSQLVAR^.sqltype and (not 1) <> SQL_BLOB)
          then
           st:=st+#13#10'Params['+IntToStr(j)+']='''+AsString+''''
          else
           st:=st+#13#10'Params['+IntToStr(j)+']=('+
            IntToStr(vParams[j].AsQuad.gds_quad_high)+','+
            IntToStr(vParams[j].AsQuad.gds_quad_low)+')'
         end;
 
 
        Database.SQLLogger.WriteData(
         CmpFullName(Self), 'TrID='+IntToStr(Transaction.TransactionID)+' '+Mess,
         FProcessedSQL+st,lfQExecute
        );
      end;
end;
 
begin
 Include(FQueryRunState,qrsInExecute);
 try
  if GetSQLKind=skDDL then
  begin
    ExecuteImmediate;
    Exit;
  end;


  DoBeforeExecute;
  pc:=Params.Count;
  if FDoParamCheck and (pc>0)  then
   Prepare
  else
  if not Prepared then
   Prepare;

  if (vDiffParams and  FDoParamCheck and (pc>0)) then
  begin
   FSQLParams.AssignValues(FUserSQLParams);
   xSQLDA:=FSQLParams.AsXSQLDA;
   vParams:=FSQLParams
  end
  else
  begin
   xSQLDA:=FUserSQLParams.AsXSQLDA;
   vParams:=FUserSQLParams;
   if FUserSQLParams.FHasDefferedSettings then
    FUserSQLParams.AdjustDefferedSettings;
  end;
  SaveStreamedParams;  
 {$IFDEF WINDOWS}
  FCallTime:=GetTickCount;
 {$ENDIF}
  try
   SV:=StatusVector;
   case FSQLType of
    SQLSelect,SQLSelectForUpdate:
    begin
      if Open then Close;
      StartStatisticExec(FProcessedSQL);
      Call(
       Database.ClientLibrary.isc_dsql_execute(SV,TRHandle,@FHandle,DataBase.SQLDialect,xSQLDA),
       True
      );
      EndStatisticExec(FProcessedSQL);
      FOpen := True;
      FBOF := True;
      FEOF := False;
      FRecordCount := 0;
      FSQLRecord.ClearValues;
      DoLog;
      if FGoToFirstRecordOnExecute then
        Next;
    end;
    SQLExecProcedure:
    begin
      StartStatisticExec(FProcessedSQL);
      fetch_res :=
       Call(
        Database.ClientLibrary.isc_dsql_execute2(SV, TRHandle,
        @FHandle,DataBase.SQLDialect,xSQLDA,FSQLRecord.AsXSQLDA), False
       );
      EndStatisticExec(FProcessedSQL);
      DoLog;
      if (fetch_res <> 0) then
       IbError(Database.ClientLibrary,Self) ;
     FProcExecuted:=True;
    end;
    SQLCommit:
    begin
      StartStatisticExec(FProcessedSQL);
      Transaction.Commit;
      EndStatisticExec(FProcessedSQL);
      DoLog;
    end;
    SQLRollback:
    begin
      StartStatisticExec(FProcessedSQL);
      Transaction.RollBack;
      EndStatisticExec(FProcessedSQL);
      DoLog;
    end;
   else
    begin
      StartStatisticExec(FProcessedSQL);
      Call(Database.ClientLibrary.isc_dsql_execute(StatusVector,
                           TRHandle,
                           @FHandle,
                           DataBase.SQLDialect,
                           xSQLDA), True);
      EndStatisticExec(FProcessedSQL);
      DoLog;
    end;
   end;
{$IFDEF WINDOWS}
    FCallTime:=GetTickCount-FCallTime;
{$ENDIF}
 
   if FDoParamCheck and (pc>0) then
    SaveRestoreValues(FUserSQLParams,True);
   DoAfterExecute;
  except
   On E:Exception do
   begin
 {$IFDEF WINDOWS}
    FCallTime:=GetTickCount-FCallTime;
 {$ENDIF}
{$IFNDEF NO_MONITOR}
    if MonitoringEnabled  then
    if MonitorHook<>nil then
    with THackMonitorHook(MonitorHook) do    //Added Source
      begin
       SQLExecute( Self );
       st:=CmpFullName(Self);
       WriteSQLData(st + ': [Execute] ' + E.Message,tfQExecute);
      end;
{$ENDIF}
      DoLog('Error on execute query. Error message: "'+E.Message+'"');
    raise;
   end
  end;
  if not Open and (qoFreeHandleAfterExecute in Options) then
   FreeHandle;
 finally
  Exclude(FQueryRunState,qrsInExecute);
 end
end;
 
procedure TFIBQuery.ExecWPS(const ParamSources: array of ISQLObject);
begin
  AssignSQLObjectParams(Self,ParamSources);
  ExecQuery;
end;
 
procedure TFIBQuery.ExecWPS(ParamSource:ISQLObject; AllRecords:boolean=True);
var
    ErrorAction :  TBatchErrorAction;
begin
  if AllRecords then
   while not ParamSource.IEof do
   begin
     AssignSQLObjectParams(Self,[ParamSource]);
    try
     ExecQuery;
    except
     on  E:EFIBError do
          if Assigned(FOnBatchError) then
          begin
            ErrorAction:=beFail;
            FOnBatchError(E,ErrorAction);
            case ErrorAction of    //
              beFail : raise;
              beAbort: Abort;
            end;    // case
          end
          else
            raise
    end;
     ParamSource.INext
   end
  else
   ExecWPS([ParamSource]);
end;
 
function TFIBQuery.GetEOF: Boolean;
begin
  Result := FEOF or not FOpen;
  if FEOF and FOpen and (qoFreeHandleAfterExecute in Options)  then
     FreeHandle;
end;


 
function TFIBQuery.FieldByName(const FieldName: string): TFIBXSQLVAR;
begin
  Result:=FSQLRecord.ByName[FieldName];
  if not Assigned(Result) then
    FIBError(feFieldNotFound, [FieldName]);
end;

function TFIBQuery.FindField(const FieldName: string): TFIBXSQLVAR;
begin
  Result:=FSQLRecord.ByName[FieldName];
end;

function TFIBQuery.FN(const FieldName: string): TFIBXSQLVAR;
begin
  Result:=FSQLRecord.ByName[FieldName];
end;

function TFIBQuery.FieldByOrigin(const TableName,FieldName:string):TFIBXSQLVAR;
var
   i:  integer;
   vTableName:string;
   vFieldName:string;
begin
  if Assigned(Database) and ((Database.SQLDialect<3) or Database.UpperOldNames) then
  begin
   vTableName:=FastUpperCase(TableName);
   vFieldName:=FastUpperCase(FieldName);
  end
  else
  begin
   vTableName:=TableName;
   vFieldName:=FieldName;
  end;
  with FSQLRecord do
  for i:=0 to Pred(FCount) do
  begin
    if   (FXSQLVARs[i].Data^.relname=vTableName)
     and (FXSQLVARs[i].Data^.sqlname=vFieldName)
    then
    begin
      Result:=FXSQLVARs[i];
      Exit;
    end;
  end;
  Result := nil;
end;
 
 
function  TFIBQuery.SQLFieldName(const aFieldName:string):string;
var
  tf: TFIBXSQLVAR ;
  vSQL:string;
  rn:string;
begin
 if not Prepared then
   Prepare;
 tf:=FN(aFieldName);
 if not Assigned(tf) then
  Result := ''
 else
 begin
  vSQL:=ReadySQLText(False);
  rn  :=tf.RelationName;
  if Length(rn) > 0 then
   Result:=
    FormatIdentifier(3,TableAliasForFieldByName(aFieldName))+'.'+
        FormatIdentifier(3,tf.SQLName)
  else
   Result:= ''
 end;
end;

function TFIBQuery.GetFields(const Idx: Integer): TFIBXSQLVAR;
begin
  if (Idx < 0) or (Idx >= FSQLRecord.Count) then
    FIBError(feFieldNotFound, ['Field No: ' + IntToStr(Idx)]);
  Result := FSQLRecord[Idx];
end;

function TFIBQuery.GetFieldIndex(const FieldName: string): Integer;
var 
 xsv: TFIBXSQLVAR;
begin
  xsv:=FSQLRecord.ByName[FieldName];
  if (xsv = nil) then
    Result := -1
  else
    Result := xsv.Index;
end;
 


function TFIBQuery.Next: TFIBXSQLDA;
var
  fetch_res: ISC_STATUS;
  StopFetching:boolean;
  st:String;
  i:integer;
begin
  Result := nil;
  if not FEOF then
  begin
   CheckOpen('fetch next record');
   if Assigned(FOnSQLFetch) then
   begin
    StopFetching:=False;
    FOnSQLFetch(FRecordCount,StopFetching);
    if StopFetching and not (csLoading in ComponentState) then
     Abort;
   end;
    // Go to the next record...
   Set8087CW(Default8087CW);
   fetch_res :=
     Call(
      FBase.Database.ClientLibrary.isc_dsql_fetch(StatusVector,
       @FHandle, FBase.Database.SQLDialect, FSQLRecord.FXSQLDA
      ),
      False
     );
 
    if (fetch_res > 0) then
    begin
       if (fetch_res = 100) then
          FEOF := True
       else
       if (CheckStatusVector([isc_dsql_cursor_err])) then
        FEOF := True
       else
       try
         IbError(FBase.Database.ClientLibrary,Self);
       except
          Close;
          raise ;
       end
    end
    else
    begin
        Inc(FRecordCount);
        FBOF := False;
        Result := FSQLRecord;
    end;
 
{$IFNDEF NO_MONITOR}
    if MonitoringEnabled  then
    if MonitorHook<>nil then
     MonitorHook.SQLFetch(Self);
{$ENDIF}
 
    if Assigned(FBase.Database.SQLLogger) and (lfQFetch in FBase.Database.SQLLogger.LogFlags) then
    begin
      for i:=0 to Pred(Current.Count) do
      begin
       st:=st+Fields[i].Name+' = ';
       if Fields[i].IsNull then
         st := st + 'NULL'
       else
         st := st + Fields[i].asString;
       st:=st+CRLF;
      end;
      st:=CRLF+st;
 
      if (Eof) then
       st := st + CRLF + '  End of file reached';
     Database.SQLLogger.WriteData(
      CmpFullName(Self),'Fetch:',
      st,lfQPrepare
     );
    end
  end;
end;

procedure TFIBQuery.FreeHandle;
var 
  isc_res:  ISC_STATUS;
begin
  try
    FSQLRecord.Count := 0;
    if FHandle <> nil then
    begin
      isc_res :=
        Call(
         Database.ClientLibrary.isc_dsql_free_statement(StatusVector, @FHandle, DSQL_drop),
          False
        );
      if (StatusVector^ = 1) and (isc_res > 0) and (isc_res <> isc_bad_stmt_handle) then
        IbError(Database.ClientLibrary,Self);
      FEOF:=True;  
    end;
  finally
    FPrepared := False;
    FHandle := nil;
  end;
end;

function TFIBQuery.GetDatabase: TFIBDatabase;
begin
  Result := FBase.Database;
end;
 
function TFIBQuery.GetDBHandle: PISC_DB_HANDLE;
begin
  Result := FBase.DBHandle;
end;
 

function Get_Numeric_Info(ClientLibrary:IIbClientLibrary; var buffer:PChar):integer;
var
   L:  Short;
begin
  if not Assigned(ClientLibrary) then
   Result := -1
  else
  begin
   L:=ClientLibrary.isc_vax_integer(buffer, 2);
   Inc(buffer,2);
   Result:=ClientLibrary.isc_vax_integer(buffer, L);
   Inc(buffer,L);
  end;
end;


function Get_String_Info(ClientLibrary:IIbClientLibrary;  var SourceBuffer:PChar;
 DestBuffer:PChar; Dest_len:integer):integer;
var 
    p:  PChar;
begin
  if not Assigned(ClientLibrary) then
   Result := -1
  else
  begin
   FillChar(DestBuffer[0],Dest_len,0);
   p:=SourceBuffer;
   Result:=ClientLibrary.isc_vax_integer(p, 2);
   if Result>=Dest_len then
    Result:=Dest_len-1;
   Move(SourceBuffer[2],DestBuffer[0],Result);
   Inc(SourceBuffer, Result+2);
  end
end;

procedure TFIBQuery.FillExtDescribeSQLVars;
var 
  Result_buffer: array[0..32766] of Char;
  PResult:PChar;
  item:PChar;
  index :Short;
  Lib:IIbClientLibrary;
  InfoRequest:array[0..4] of char;
  vSQL,RN:string;
begin
  if (not Prepared) then
   Exit
  else
  begin
   if not Database.IsFirebirdConnect or (Database.ServerMajorVersion<2) then
   begin
     if Length(FExtSQLDA)<FSQLRecord.Count then
       SetLength(FExtSQLDA,FSQLRecord.Count);
     vSQL:=ReadySQLText(False);
     for index:=0 to Pred(FieldCount) do
     begin
       rn  :=Fields[index].RelationName;
       if Length(rn) > 0 then
       begin
        rn  :=AliasForTable(vSQL, FormatIdentifier(3,rn));
        if Length(rn) > 0 then
         Move(rn[1],FExtSQLDA[index].sql_relation_alias[0],Length(RN))
        else
         FillChar(FExtSQLDA[index].sql_relation_alias[0],SizeOf(FExtSQLDA[index].sql_relation_alias[0]),0)
       end
       else
        FillChar(FExtSQLDA[index].sql_relation_alias[0],SizeOf(FExtSQLDA[index].sql_relation_alias[0]),0)
     end;
    Exit;
   end;

   InfoRequest[0]:= Char(isc_info_sql_select);
   InfoRequest[1]:= Char(isc_info_sql_describe_vars);
   InfoRequest[2]:= Char(isc_info_sql_sqlda_seq);
   InfoRequest[3]:= Char(frb_info_sql_relation_alias);
   InfoRequest[4]:= Char(isc_info_sql_describe_end);

      Lib:=Database.ClientLibrary;
      Call(Lib.isc_dsql_sql_info(
         StatusVector,@FHandle, SizeOf(InfoRequest), @InfoRequest[0],
         SizeOf(Result_buffer), Result_buffer), True
      );
      if  (Result_buffer[0] <> Char(isc_info_sql_select))
       or (Result_buffer[1] <> Char(isc_info_sql_describe_vars))
      then
      begin
        Exit;
      end;
      if Length(FExtSQLDA)<FSQLRecord.Count then
       SetLength(FExtSQLDA,FSQLRecord.Count);
      PResult:=@Result_buffer[2];
      Get_Numeric_Info(Lib,PResult);
      index:=0;
      while PResult[0]<>Char(isc_info_end) do
      begin
        item:=PResult;
        if item[0]=Char(isc_info_sql_describe_end) then
         Inc(PResult,1)
        else
        while item[0]<>Char(isc_info_sql_describe_end) do
        begin
          Inc(PResult,1);
          case Byte(item[0]) of
            isc_info_sql_sqlda_seq:
            begin
              index := get_numeric_info(Lib,PResult)-1;
            end;
            frb_info_sql_relation_alias:
            begin
              get_string_info(Lib,PResult,@FExtSQLDA[index].sql_relation_alias[0],
                SizeOf(FExtSQLDA[index].sql_relation_alias)
              );
              if (FExtSQLDA[index].sql_relation_alias = '') then
              begin
               RN:=Fields[index].RelationName;
               if(Length(RN)>0)then
                Move(RN[1],
                 FExtSQLDA[index].sql_relation_alias[0],
                 Length(RN)
                );
              end
            end;
            isc_info_truncated:
            begin

            end;
          end;
          item:=PResult;
        end;
      end;
  end;
end;

function TFIBQuery.TableAliasForField(FieldIndex:integer):string;
begin
  if not Prepared then
   Prepare;

  if Length(FExtSQLDA)=0 then
   FillExtDescribeSQLVars;

  if (FieldIndex<0) or(FieldIndex>=Length(FExtSQLDA)) then
   Result := ''
  else
   begin
    Result:=   FormatIdentifier(3,FExtSQLDA[FieldIndex].sql_relation_alias);
   end;
end;

function TFIBQuery.TableAliasForFieldByName(const aFieldName:string):string;
var 
  tf: TFIBXSQLVAR ;
begin
  tf:=FN(aFieldName);
  if not Assigned(tf) then
   Result := ''
  else
   Result:=TableAliasForField(tf.FIndex);
end;

{$IFNDEF BCB}
function TFIBQuery.TableAliasForField(const aFieldName:string):string;
begin
  Result:=TableAliasForFieldByName(aFieldName)
end;
{$ENDIF}

function TFIBQuery.SQLDescribeInfo(InfoRequest:array of char):PXSQLDA;
var 
  Result_buffer: array[0..32766] of Char;
  PResult:PChar;
  N:integer;
  item:PChar;
  index :Short;
  SQLVar:PXSQLVAR;
  Lib:IIbClientLibrary;
begin
  if (not Prepared) then
   Result := nil
  else
  begin
    Lib:=Database.ClientLibrary;
      Call(Lib.isc_dsql_sql_info(
         StatusVector,@FHandle, SizeOf(InfoRequest), @InfoRequest[0],
         SizeOf(Result_buffer), Result_buffer), True
      );
      if not (Result_buffer[0] in [Char(isc_info_sql_select),Char(isc_info_sql_bind)])
       or (Result_buffer[1] <> Char(isc_info_sql_describe_vars))
      then
      begin
        Result:=nil;
        Exit;
      end;
      Result:=AllocMem(SizeOf(TXSQLDA));
      PResult:=@Result_buffer[2];
      N := Get_Numeric_Info(Lib,PResult);
      Result^.sqld:=N;
      while PResult[0]<>Char(isc_info_end) do
      begin
        item:=PResult;
        SQLVar:=nil;
        if item[0]=Char(isc_info_sql_describe_end) then
         Inc(PResult,1)
        else
        while item[0]<>Char(isc_info_sql_describe_end) do
        begin
          Inc(PResult,1);
          case Byte(item[0]) of
            isc_info_sql_sqlda_seq:
            begin
              index := get_numeric_info(Lib,PResult);
              SQLVar:=@Result^.sqlvar[index-1];
              Inc(Result^.sqln)
            end;
            isc_info_sql_type:
              SQLVar.sqltype := get_numeric_info(Lib,PResult);
            isc_info_sql_sub_type:
              SQLVar.sqlsubtype:= get_numeric_info(Lib,PResult);
            isc_info_sql_scale:
              SQLVar.sqlscale  := get_numeric_info(Lib,PResult);
            isc_info_sql_length:
              SQLVar.sqllen  := get_numeric_info(Lib,PResult);
            isc_info_sql_field:
              SQLVar.sqlname_length :=
               get_string_info(Lib,PResult,@SQLVar.sqlname[0],SizeOf(SQLVar.sqlname));
            isc_info_sql_relation:
              SQLVar.relname_length :=
               get_string_info(Lib,PResult,@SQLVar.relname[0],SizeOf(SQLVar.relname));
            isc_info_sql_owner:
              SQLVar.ownname_length :=
               get_string_info(Lib,PResult,@SQLVar.ownname[0],SizeOf(SQLVar.ownname));
            isc_info_sql_alias:
              SQLVar.aliasname_length:=
               get_string_info(Lib,PResult,@SQLVar.aliasname[0],SizeOf(SQLVar.aliasname));
{            frb_info_sql_relation_alias:
                  get_string_info(Lib,PResult,@SQLVar.ownname[0],SizeOf(SQLVar.aliasname));}
            isc_info_truncated:
            begin

            end;
          end;
          item:=PResult;
        end;
      end;
  end;
end;
 
function TFIBQuery.GetPlan: string;
var
  Result_buffer:  array[0..cPlanMaxLength] of Char;
  Result_length: Integer;
  info_request: Char;
  Position:integer;
begin
  if (not Prepared) or
     (not (FSQLType in [SQLSelect, SQLSelectForUpdate, SQLExecProcedure,
                        SQLUpdate, SQLDelete,SQLInsert])) then
    Result := ''
  else
  begin
    info_request := Char(isc_info_sql_get_plan);
    Call(Database.ClientLibrary.isc_dsql_sql_info(
       StatusVector,@FHandle, 1, @info_request,
       SizeOf(Result_buffer), Result_buffer), True
    );
    if (Result_buffer[0] <> Char(isc_info_sql_get_plan)) then
    begin
      Result:=''; Exit;
    end;
    Result_length := Database.ClientLibrary.isc_vax_integer(@Result_buffer[1], 2);
 
    Position:=3;
    while (result_length>0) and (Result_buffer[Position] in [#0,#10,#13,#9,' ']) do
    begin
     Inc(Position);
     Dec(result_length);
    end;
    if  result_length>0 then
     SetString(Result, PChar(@Result_buffer[Position]), result_length)
    else
     Result:='';
 
    if Database.IsUnicodeConnect then
     Result:=UTF8Decode(Result);
{$IFDEF SUPPORT_KOI8_CHARSET}
    if Database.IsKOI8Connect then
      Result:=ConvertFromCodePage(Result,CodePageKOI8R);
{$ENDIF}

  end;
end;

function TFIBQuery.GetRecordCount: Integer;
begin
  Result := FRecordCount;
end;
 
 
 

function TFIBQuery.GetAllRowsAffected: TAllRowsAffected;
var
  InfoBuffer: PChar;
  AllocAddr : PChar;

  info_request: Char;
  InfoLen: integer;

  function  ReadRequest:integer;
  begin
    with Database.ClientLibrary do
    begin
      Inc(InfoBuffer);
      InfoLen := isc_vax_integer( InfoBuffer, 2 );
      Inc(InfoBuffer,2);
      Result:= isc_vax_integer( InfoBuffer, InfoLen );
      Inc(InfoBuffer,InfoLen);
    end;
  end;
 
begin
  if not Prepared then
    Prepare;
 InfoBuffer:=AllocMem(255);
 AllocAddr :=InfoBuffer;
 try
  with Database.ClientLibrary do
  begin
    info_request := Char(isc_info_sql_records);
    FillChar(Result,SizeOf(Result),0);
 
    if isc_dsql_sql_info(StatusVector, @FHandle, 1, @info_request,
                         255, InfoBuffer) > 0 then
      IbError(Database.ClientLibrary,Self);
    if (InfoBuffer[0] = Char(isc_info_end)) then
     Exit;
    if (InfoBuffer[0] <> Char(isc_info_sql_records)) then
      FIBError(feUnknownError, [nil]);
    Inc(InfoBuffer);
    InfoLen := isc_vax_integer( InfoBuffer, 2 );
    if InfoLen>255 then
    begin
     InfoBuffer:=AllocAddr;
     ReallocMem(InfoBuffer,InfoLen);
     AllocAddr :=InfoBuffer;
     if isc_dsql_sql_info(StatusVector, @FHandle, 1, @info_request,
                         InfoLen, InfoBuffer) > 0 then
      IbError(Database.ClientLibrary,Self);
     Inc(InfoBuffer);
    end;
    Inc(InfoBuffer,2);
 
    while Byte(InfoBuffer[0]) <> isc_info_end do
    case Byte(InfoBuffer[0]) of
      isc_info_req_insert_count:
        Result.Inserts :=ReadRequest;
      isc_info_req_update_count:
        Result.Updates :=ReadRequest;
      isc_info_req_select_count:
        Result.Selects := ReadRequest;
      isc_info_req_delete_count:
        Result.Deletes := ReadRequest;
    else
       FIBError(feUnknownError, [nil]);
    end;
  end;
 finally
  FreeMem(AllocAddr);
 end;
end;

function TFIBQuery.GetRowsAffected: integer;
var
   ar:  TAllRowsAffected;
begin
  ar:=GetAllRowsAffected;
  case SQLType of
     SQLUpdate:   Result := ar.Updates;
     SQLDelete:   Result := ar.Deletes;
     SQLInsert:   Result := ar.Inserts;
     SQLSelect:   Result := ar.Selects;
  else
   Result:=ar.Updates+ar.Deletes+ar.Selects+ar.Inserts
  end ;
end;

function TFIBQuery.GetSQLParams: TFIBXSQLDA;
begin
  if (FUserSQLParams.FXSQLDA=nil)  and not vUserParamsCreated  then
   SQLChange(nil);
  Result := FUserSQLParams;
end;

function TFIBQuery.GetTransaction: TFIBTransaction;
begin
  Result := FBase.Transaction;
end;
 
function TFIBQuery.GetTRHandle: PISC_TR_HANDLE;
begin
  Result := FBase.TRHandle;
end;

(*
 * Preprocess SQL
 *  Using FSQL, process the typed SQL and put the process SQL
 *  in FProcessedSQL and parameter names in FSQLParams
 *)
const
  ParamNameChars=['A'..'Z', 'a'..'z', '0'..'9', '_', '$','%','#','.'];
 
procedure TFIBQuery.PreprocessSQL(const sSQL:string;IsUserSQL:boolean);
const
  DefParCount=10;
var
  cCurChar, cNextChar, cQuoteChar:  Char;
  sParamName: string;
  sMacroName: string;
  i, iLenSQL, iCurState, iSQLPos: Integer;
  iCurParamState:byte;
  slNames: TStrings;
  BracketOpenedInWhere:integer;
 
  vParams :TFIBXSQLDA;
  NewParams:TFIBXSQLDA;
  tempVar,tempVar1:TXSQLVAR;
  ParVar,NParVar:TFIBXSQLVAR;

  PCount,Ind:integer;
 
  CurMDef:string;
  OldStyleMacro:boolean;
//  EndMacro :boolean;
  InWhereClause  :boolean;
  CanForceIsNull :boolean;
  OldMacroChanged:boolean;
 
  vBeginParamPos  :integer;
  vBeginParamsPos :array of integer;
  vEndParamsPos   :array of integer;
  vInDeclarationSection  :boolean;
 
  procedure AddToProcessedSQL(cChar: Char);
  begin
   if not IsUserSQL then
   begin
    if iSQLPos > Length( FProcessedSQL ) then
     SetLength( FProcessedSQL, Length( FProcessedSQL ) + 512 );
    FProcessedSQL[iSQLPos] := cChar;
    Inc(iSQLPos);
   end;
  end;
 
  function ParamCanForceIsNull(EndPos:integer):boolean;
  begin
    if not InWhereClause then
     Result:=False
    else
    begin
      while (EndPos<=iLenSQL) and (sSQL[EndPos] in [' ',#9,#13,#10]) do
       Inc(EndPos);
      if EndPos<=iLenSQL then
      begin
        case sSQL[EndPos] of
        '+','|','*': Result := False;
        '-': Result:= (EndPos<iLenSQL) and (sSQL[EndPos+1]='-');
        '/': Result:= (EndPos<iLenSQL) and (sSQL[EndPos+1]='*');
        else
          Result := True;
        end;
      end
      else
        Result:=True;
    end;
  end;
 
const
  DefaultState = 0;
  CommentState = 1;
  QuoteState = 2;
  ParamState = 3;
  MacroState =4;
  FBCommentState=5;
  ParamDefaultState = 0;
  ParamQuoteState = 1;
 
procedure RegParamName(AddQuote:boolean);
var 
   b: Byte;
begin
 iCurParamState := ParamDefaultState;
 iCurState := DefaultState;
 Inc(PCount);
 b:=0;
 if InWhereClause then
  b:=SetBit(b,0,True);
 if CanForceIsNull then
  b:=SetBit(b,1,True);
 if AddQuote then
  b:=SetBit(b,2,True);

 slNames.AddObject(sParamName,TObject(b));
 SetLength(vBeginParamsPos,PCount);
 SetLength(vEndParamsPos,PCount);
 vBeginParamsPos[PCount-1]:=vBeginParamPos;
 if AddQuote then
  vEndParamsPos[PCount-1]:=i+1
 else
  vEndParamsPos[PCount-1]:=i;
 sParamName := '';
end;
 
begin
  slNames       := TStringList.Create;
  try
    (* Do some initializations of variables *)
    cQuoteChar := '''';
    PCount     := 0;
    InWhereClause :=False;
    CanForceIsNull:=False;
    BracketOpenedInWhere:=0;
    iLenSQL := Length(sSQL); //+MaxParams
    if not IsUserSQL then
    begin
     FCodePageApplied:=False;
     SetString(FProcessedSQL, nil, iLenSQL);
     FillChar(FProcessedSQL[1],iLenSQL,0);
    end;

    i := 1;
    iSQLPos        := 1;
    iCurState      := DefaultState;
    iCurParamState := ParamDefaultState;
    OldStyleMacro  := False;
    vInDeclarationSection:=True;
    (*
     * Now, traverse through the SQL string, character by character,
     * picking out the parameters and formatting correctly for InterBase.
     *)
    while (i <= iLenSQL) do
    begin
      // Get the current token and a look-ahead.
      cCurChar := sSQL[i];
      if i = iLenSQL then
        cNextChar := #0
      else
        cNextChar := sSQL[i + 1];

      if (iCurState=DefaultState) and not(SQLKind in [skExecuteProc,skExecuteBlock]) then
      begin
        if not InWhereClause then
        begin
         InWhereClause:=IsWhereBeginPos(sSQL,i);
         if InWhereClause and IsUserSQL then
         begin
           Inc(i,5);BracketOpenedInWhere:=0;
           Continue;
         end
        end
        else
        begin
          case cCurChar of
            '(': Inc(BracketOpenedInWhere);
            ')': Dec(BracketOpenedInWhere);
          end;
          InWhereClause:=(BracketOpenedInWhere>=0) and
           not IsWhereEndPos(sSQL,i)
        end;
      end;
 
      // Now act based on the current state.
      case iCurState of
        DefaultState:
        begin
          case cCurChar of
           'A','a':
            begin
             if SQLKind=skExecuteBlock then
             begin
               if vInDeclarationSection and (iLenSQL-i>=2)  then
                vInDeclarationSection:= not
                (   (sSQL[i+1] in ['S','s'])
                and (sSQL[i+2] in CharsAfterClause)
                );
              if vInDeclarationSection and (iLenSQL-i>=2)  then
                vInDeclarationSection:= not
                (   (sSQL[i+1] in ['S','s'])
                and (sSQL[i+2] in CharsAfterClause)
                );
             end;
            end;

            '''', '"':
            begin
              cQuoteChar := cCurChar;
              iCurState := QuoteState;
            end;
            '?', ':':
            if FParser.CanParamsCheck and vInDeclarationSection  then
            begin
              iCurState := ParamState;
              AddToProcessedSQL('?');
              vBeginParamPos:=i;
            end;
            '/':
             if (cNextChar = '*') then
             begin
              AddToProcessedSQL(cCurChar);
              Inc(i);
              iCurState := CommentState;
             end;
            '-':
            begin
               if cCurChar=cNextChar then
               begin
                iCurState := FBCommentState;
                AddToProcessedSQL(cCurChar);
                Inc(i);
               end;
            end;
          else
             if cCurChar=FMacroChar then
             begin
              iCurState := MacroState;
              OldStyleMacro:=cNextChar<>FMacroChar;
              if OldStyleMacro then
               sParamName:=FMacroChar;
              vBeginParamPos:=i;
             end;
          end;
        end;
        FBCommentState:
        begin
          if (cCurChar in [#0,#13,#10]) then
           iCurState :=DefaultState;
        end;
        CommentState:
        begin
          if (cNextChar = #0) then
            FIBError(feSQLParseError, [CmpFullName(Self), SFIBErrorEOFInComments])
          else
          if (cCurChar = '*') then
          begin
            if (cNextChar = '/') then  iCurState := DefaultState;
          end;
        end;
        QuoteState:
        begin
          if (cNextChar = #0) then
            FIBError(feSQLParseError, [CmpFullName(Self), SFIBErrorEOFInString])
          else
          if (cCurChar = cQuoteChar) then
          begin
            if (cNextChar = cQuoteChar) then
            begin
              AddToProcessedSQL(cCurChar);
              Inc(i);
            end
            else
              iCurState := DefaultState;
          end;
        end;
        ParamState,MacroState:
        begin
         if iCurParamState = ParamDefaultState then
          if cCurChar = '"' then
          begin
           iCurParamState := ParamQuoteState;
           Inc(i);
           AddToProcessedSQL(' ');
           Continue;
          end;
          // Step 1, collect the name of the parameter
          if (iCurParamState = ParamQuoteState) or   (cCurChar in ParamNameChars)
          then
            sParamName := sParamName + cCurChar
          else
          if ((iCurState=MacroState) and
           (not OldStyleMacro or not (cCurChar in [' ',#13,#10]))
           )
          then
              sParamName := sParamName + cCurChar
          else
           if not  CmpInLoadedState(Self) then
            FIBError(feSQLParseError, [CmpFullName(Self), SFIBErrorParamNameExpected])
           else
            Exit; 
          // Step 2, determine if the parameter name is finished.
          if  (cNextChar='"') and (iCurParamState = ParamQuoteState)
          then
          begin
              CanForceIsNull:=ParamCanForceIsNull(i+2);
              RegParamName(True);
              Inc(i,2);
              CanForceIsNull:=False;
              AddToProcessedSQL(' ');
              Continue;
          end;
 
          if iCurState<>MacroState then
          begin
           if not (cNextChar in ParamNameChars) and (iCurParamState <> ParamQuoteState) then
           begin
            CanForceIsNull:=ParamCanForceIsNull(i+1);
            RegParamName(False);
            if InWhereClause and (cNextChar=')') then
             Dec(BracketOpenedInWhere);
            Inc(i);
            CanForceIsNull:=False;
           end;
          end
          else
          begin
            if OldStyleMacro then
            begin
              if not (iCurParamState = ParamQuoteState) and (cNextChar in [' ',#13,#10]) then
              begin
                RegParamName(False);
                Inc(i);
              end;
            end
            else
            begin
              if not (iCurParamState = ParamQuoteState) and  (cNextChar=FMacroChar) then
              begin
                Inc(i);
                RegParamName(False);
              end;
            end;
          end;
        end;
      end;
      if (iCurState in  [ParamState,MacroState]) then
        AddToProcessedSQL(' ')
      else
        AddToProcessedSQL(sSQL[i]);
      Inc(i);
    end;

   if not IsUserSQL then
   begin
    SetLength( FProcessedSQL, iSQLPos-1);
   end;

// Create Params List
    NewParams:=TFIBXSQLDA.Create(True);

    NewParams.FQuery := Self;
    NewParams.FXSQLDA:= nil;

    if IsUserSQL then
     vParams:=FUserSQLParams
    else
     vParams:=FSQLParams;

    NewParams.FHasDefferedSettings:=vParams.FHasDefferedSettings;
    NewParams.Count := slNames.Count;
    for i := 0 to slNames.Count - 1 do
    begin
      sParamName:=slNames[i];
      if sParamName[1]<>FMacroChar then
      begin
       NewParams.AddName(sParamName, i,GetBit(Byte(slNames.Objects[i]),2));
       NewParams[i].IsMacro:=False;
       InternalSetNull(NewParams[i],True);
       if IsUserSQL then
        NewParams[i].FXSQLVAR^.sqlType:=0;
       NewParams[i].FInitialized:=False;
       NewParams[i].FInWhereClause:=GetBit(Byte(slNames.Objects[i]),0);
       NewParams[i].FCanForceIsNull:=GetBit(Byte(slNames.Objects[i]),1);
       NewParams[i].FBeginPosInText:=vBeginParamsPos[i];
       NewParams[i].FEndPosInText  :=vEndParamsPos[i];
      end
      else // Макросы
      if not IsUserSQL then
       NewParams.Count:=NewParams.Count-1
      else
      begin
       CurMDef:='';
       sMacroName :=ParseMacroString(sParamName, FMacroChar,CurMDef);
       NewParams.AddName(FastCopy(sMacroName,2,255), i,False);
       NewParams[i].IsMacro:=True;
       NewParams[i].Quoted :=(CurMDef<>'') and (CurMDef[1]='#');
       if NewParams[i].Quoted then
        DoCopy(CurMDef,NewParams[i].FDefMacroValue,2,Length(CurMDef)-1)
       else
        NewParams[i].FDefMacroValue := CurMDef;
       if Length(CurMDef)>0 then
        InternalSetValue(NewParams[i], SQL_TEXT,Length(CurMDef),CurMDef[1])
       else
        InternalSetValue(NewParams[i], SQL_TEXT,0,'');
       NewParams[i].FBeginPosInText:=vBeginParamsPos[i];
       NewParams[i].FEndPosInText  :=vEndParamsPos[i];
      end;
 
     vParams.FCachedNames.Clear;
     if (vParams.Count>0) and (NewParams.Count>i) then
     begin
      OldMacroChanged:=MacroChanged;
      try
       FMacroChanged:=False;
       ParVar:=vParams.ByName[NewParams[i].Name];
      finally
        FMacroChanged:=OldMacroChanged
      end;
      if Assigned(ParVar)  and  (ParVar.FParent<>vParams) then ParVar:=nil
     end
     else
      ParVar:=nil;
     if (ParVar<>nil) and (ParVar.FXSQLVAR^.sqltype and (not 1)<>520) then
//     if (ParVar<>nil) then
     begin
// Restore Old ParamValues
      NParVar         :=NewParams[i];
      ParVar.FInWhereClause:=NParVar.FInWhereClause;
      ParVar.IsMacro  :=NParVar.IsMacro;
      ParVar.FDefMacroValue :=NParVar.FDefMacroValue;
      ParVar.FBeginPosInText:=NParVar.FBeginPosInText;
      ParVar.FEndPosInText  :=NParVar.FEndPosInText;
      tempVar         :=NParVar.FXSQLVAR^;
      tempVar1        :=ParVar.FXSQLVAR^;
      NParVar.FParent :=vParams;
      NParVar.FXSQLVAR^.sqltype:=ParVar.FXSQLVAR^.sqltype;
      vParams.FXSQLVARs^[ParVar.FIndex]     :=NParVar;
      vParams.FXSQLDA^.sqlvar[ParVar.FIndex]:=tempVar;
 
      NewParams.FXSQLVARs^[i]     :=ParVar;
      NewParams.FXSQLDA^.sqlvar[i]:=tempVar1;
      ParVar.FXSQLVAR := @NewParams.FXSQLDA^.sqlvar[i];
      vParams[ParVar.FIndex].FXSQLVAR := @vParams.FXSQLDA^.sqlvar[ParVar.FIndex];
      Ind:=vParams.FNames.IndexOfObject(TObject(ParVar.FIndex));
      if Ind>-1 then
       vParams.FNames.Delete(Ind);
      ParVar.FParent :=NewParams;
      ParVar.FIndex  :=i;
      ParVar.FSrvSQLType:=0;
      ParVar.FSrvSQLSubType:=0;
      ParVar.FSrvSQLLen:=0;
     end;
    end;
    if IsUserSQL then
       FUserSQLParams := NewParams
    else
       FSQLParams     := NewParams;
    vParams.Free;
  finally
    slNames.Free;
  end;
end;

procedure TFIBQuery.SetDatabase(Value: TFIBDatabase);
begin
  if (Value <> FBase.Database) and FPrepared then
   FreeHandle;
  FBase.Database := Value;
end;

// Array Support
{$IFDEF SUPPORT_ARRAY_FIELD}
 
procedure TFIBQuery.PrepareArraySqlVar(SqlVar:TFIBXSQLVAR;
           const RelName,aSQLName:string; IsField:boolean
          );
begin
 if SqlVar= nil then
  FIBError(feInvalidParamColumnIndex,['']);
 with Database.ClientLibrary do
 try
    with SqlVar do
    begin
     if SqlVar.vFIBArray=nil then
      vFIBArray:=TpFIBArray.Create(Database.ClientLibrary,FXSQLVAR,
       DBHandle,TRHandle, RelName, aSQLName
      );
     if not IsField then
     begin
      FIBAlloc(FXSQLVAR^.sqldata, 0, 0);
      FIBAlloc(FXSQLVAR^.sqldata, 0, vFIBArray.ArraySize);
      FXSQLVAR^.sqltype:=540
     end;
    end;
 except
   IbError(Database.ClientLibrary,Self)
 end;
end;
 
 
procedure TFIBQuery.PrepareArrayFields;
var i:integer;
    v:TFIBXSQLVAR;
    da:TFIBXSQLDA;
begin
 da:=Current;
 for i:=0 to Pred(da.Count) do
 begin
   v:=da.Vars[i];
   with v,v.FXSQLVAR^ do
    if (sqltype and (not 1) = SQL_ARRAY) then
     PrepareArraySqlVar(v,RelName,SQLName,True);
 end;
end;
{$ENDIF}
 

procedure TFIBQuery.PrepareUserParamsTypes;
var i       :integer;
    vSqlType :integer;
    SQLPar  :TFIBXSQLVAR;
    StrVal  :string;
    vIsNull :boolean;
begin
 FOnlySrvParams.Clear;
 if not vDiffParams then
  Exit;
 for i:=0 to Pred(FUserSQLParams.Count) do
 begin
  SQLPar  :=FSQLParams.FindParam(FUserSQLParams[i].Name);
  if SQLPar=nil then
   Continue;
  vSqlType :=SQLPar.FXSQLVAR^.sqltype and (not 1);
  if (vSqlType = SQL_TIMESTAMP) or (vSqlType = SQL_TYPE_DATE)  then
  with FUserSQLParams[i] do
  case SQLType of
   SQL_DOUBLE, SQL_FLOAT, SQL_D_FLOAT,SQL_INT64:  asDateTime:=asFloat
  end;
  if (vSqlType = SQL_BLOB) or (vSqlType = SQL_ARRAY) then
  with FUserSQLParams[i] do
  begin
    if SqlType<>vSqlType then
    begin
     vIsNull :=FUserSQLParams[i].IsNull;
     if (vSqlType<>SQL_ARRAY) then
      StrVal  :=FUserSQLParams[i].asString;
     FXSQLVAR^.sqlsubtype :=SQLPar.Data^.sqlsubtype;
     if vIsNull then
     begin
      AsQuad:=SQLPar.AsQuad;
      IsNull:=True;
      Continue
     end;
     if vSqlType<> SQL_ARRAY then
      asString:=StrVal;
    end;
  end;
 end;
 SLDifference(FSQLParams.FNames,FUserSQLParams.FNames,FOnlySrvParams)
end;


procedure TFIBQuery.Prepare;
var
  stmt_len:  Integer;
  res_buffer: array[0..7] of Char;
  type_item: Char;
  i:integer;
  SV: PISC_STATUS;
  ParamsSQLDA:PXSQLDA;
  BlobValue:string;
  {$IFNDEF NO_MONITOR}
   st:string;
  {$ENDIF}
 
 
  function NeedTransformUserSQL:boolean;
  var j,pc:integer;
      p:TFIBXSQLVAR;
  begin
   Result:=not FPrepared or FMacroChanged ;
   if Result then
    Exit;
   pc:=Pred(Params.Count);
   for j:=0  to pc do
   begin
     p:=Params[j];
     if p.IsMacro then
       Result:=p.Value<>p.FOldValue;
// Изменилось макрозначение. Необходимо изменить SQL.
     if Result then Exit;
     Result:=
       (p.FCanForceIsNull and (p.IsNull xor VarIsNull(p.FOldValue)));
// Возможно необходимо изменить условие Is null
     if Result then Exit;
   end;
  end;
begin
 Include(FQueryRunState,qrsInPrepare);
 try
  if Open then Close;
  FBase.CheckDatabase;
{$IFDEF CSMonitor}
  if Pos('/* CSMON$', FParser.SQLText) <= 0 then
    FParser.SQLText := FParser.SQLText + GetCSMonText;
{$ENDIF}
 
  if qoStartTransaction in Options then
   if (Transaction<>nil) and not Transaction.InTransaction then
    Transaction.StartTransaction;
  FBase.CheckTransaction;
  if (FDoParamCheck) and (Params.Count>0) then
  begin
   if not vUserParamsCreated then
    SQLChange(nil);
   if NeedTransformUserSQL then
   begin
    PreprocessSQL(ReadySQLText,False);
    ConvertSQLTextToCodePage;
    FMacroChanged:=False;
    FreeHandle;
   end;
  end
  else
  begin
 
{$IFDEF CSMonitor}
  if Pos('/* CSMON$', FProcessedSQL) <= 0 then
    FProcessedSQL  := FProcessedSQL + GetCSMonText;
{$ENDIF}
    ConvertSQLTextToCodePage;
  end;
  if FPrepared then
   Exit;
  SetLength(FExtSQLDA,0);
  if IsBlank(FProcessedSQL) then
    FIBError(feEmptyQuery, ['Prepare']);

  SV:=StatusVector;
  with Database.ClientLibrary do
  try
    Call(isc_dsql_alloc_statement2(SV, DBHandle,
                                    @FHandle), True);
    FSQLRecord.Count := 1;
    Call(isc_dsql_prepare(SV, TRHandle, @FHandle, 0,
               PChar(FProcessedSQL),
               DataBase.SQlDialect,
     FSQLRecord.FXSQLDA
    ),
     True
    );

 
    (* After preparing the statement, query the stmt type and possibly
      create a FSQLRecord "holder" *)
    (* Get the type of the statement *)
    type_item := Char(isc_info_sql_stmt_type);
    Call(isc_dsql_sql_info(SV, @FHandle, 1, @type_item,
                         SizeOf(res_buffer), res_buffer), True);
    if (res_buffer[0] <> Char(isc_info_sql_stmt_type)) then
      FIBError(feUnknownError, [nil]);
    stmt_len := isc_vax_integer(@res_buffer[1], 2);
    FSQLType := TFIBSQLTypes(isc_vax_integer(@res_buffer[3], stmt_len));
    if FSQLType=SQLSelectForUpdate then
    begin
      if FCursorName='' then
       FCursorName:=RandomString(10);
      Call(
       isc_dsql_set_cursor_name(StatusVector, @FHandle, PChar(FCursorName), 0),
       True
      );
    end;

    (* Done getting the type *)
    case FSQLType of
      SQLGetSegment,
      SQLPutSegment,
      SQLStartTransaction:
      begin
        FreeHandle;
        FIBError(feNotPermitted, [nil]);
      end;
      SQLInsert, SQLUpdate, SQLDelete, SQLSelect, SQLSelectForUpdate,
      SQLExecProcedure:
      begin
        (* We already know how many inputs there are, so... *)
        if vDiffParams then
         ParamsSQLDA:=FSQLParams.FXSQLDA
        else
         ParamsSQLDA:=FUserSQLParams.FXSQLDA;
        if (ParamsSQLDA <> nil) then
        begin
         if vDiffParams then //!!!
          SaveRestoreValues(FSQLParams,True);
         if
          Call(isc_dsql_describe_bind(SV, @FHandle, DataBase.SQlDialect,
             FSQLParams.FXSQLDA
          ), False) > 0
         then
           IbError(Database.ClientLibrary,Self)
         else
         begin
          if (ParamsSQLDA=FUserSQLParams.FXSQLDA) then
           for i:=0 to Pred(FUserSQLParams.Count) do
            if FUserSQLParams[i].IsNull then
            begin
              FUserSQLParams[i].FXSQLVAR^.sqltype:=FSQLParams[i].FXSQLVAR^.sqltype;
              FUserSQLParams[i].FXSQLVAR^.sqlscale:=FSQLParams[i].FXSQLVAR^.sqlscale;              
              FUserSQLParams[i].FXSQLVAR^.sqllen :=FSQLParams[i].FXSQLVAR^.sqllen;
              FUserSQLParams[i].FXSQLVAR^.sqlsubtype:=FSQLParams[i].FXSQLVAR^.sqlsubtype;              
              FIBAlloc(FUserSQLParams[i].FXSQLVAR^.sqldata,0,
               FSQLParams[i].FXSQLVAR^.sqllen
              );
              FUserSQLParams[i].IsNull:=True
            end
            else
            if FSQLParams[i].IsBlob and not FUserSQLParams[i].IsBlob then
            begin
            //Change buzz 8.02.2003
              if FUserSQLParams[i].SQLType=SQL_TEXT then
              begin
                SetLength(BlobValue,FUserSQLParams[i].FXSQLVAR^.sqllen);
                if Length(BlobValue)>0 then
                 Move(FUserSQLParams[i].FXSQLVAR^.sqldata^,BlobValue[1],Length(BlobValue))

              end
              else
              begin
               BlobValue:=FUserSQLParams[i].AsString;
              end; 
              FUserSQLParams[i].FXSQLVAR^.sqltype:=FSQLParams[i].FXSQLVAR^.sqltype;
              FUserSQLParams[i].FXSQLVAR^.sqllen :=FSQLParams[i].FXSQLVAR^.sqllen;
              ReallocMem(FUserSQLParams[i].FXSQLVAR^.sqldata,FSQLParams[i].FXSQLVAR^.sqllen);
              FUserSQLParams[i].FXSQLVAR^.sqlsubtype:=FSQLParams[i].FXSQLVAR^.sqlsubtype;
              FUserSQLParams[i].FSrvSQlType:=FSQLParams[i].SQLType ;
              FSQLParams[i].FSrvSQlType:=FSQLParams[i].SQLType ;
              FUserSQLParams[i].FSrvSQLSubType:=FSQLParams[i].SQLSubtype;
              FPrepared := True;              
              FUserSQLParams[i].AsString:=BlobValue
            end;
         end;
        end;

        FSQLParams.Initialize;
        if vDiffParams then //!!!
         SaveRestoreValues(FSQLParams,False);
        if FSQLType in [SQLSelect, SQLSelectForUpdate, SQLExecProcedure] then
        begin
          if FSQLRecord.FXSQLDA^.sqld > FSQLRecord.FXSQLDA^.sqln then
          begin
            FSQLRecord.Count := FSQLRecord.FXSQLDA^.sqld;
            Call(isc_dsql_describe(SV, @FHandle, DataBase.SQlDialect, FSQLRecord.FXSQLDA), True);
          end
          else
           if FSQLRecord.FXSQLDA^.sqld = 0 then FSQLRecord.Count := 0;
          FSQLRecord.Initialize;
        end
        else
         FSQLRecord.Count :=0;
       PrepareUserParamsTypes;
       {$IFDEF SUPPORT_ARRAY_FIELD}
       PrepareArrayFields;
       {$ENDIF}
      end;
    end;
    FPrepared := True;
    {$IFNDEF NO_MONITOR}
     if MonitoringEnabled  then    
      if MonitorHook<>nil then
       MonitorHook.SQLPrepare(Self);
    {$ENDIF}
 
    DoStatisticPrepare(FProcessedSQL);
    if Assigned(Database.SQLLogger) then
    begin
     Database.SQLLogger.WriteData(
      CmpFullName(Self),'Prepare:',
      FProcessedSQL,lfQPrepare
     );
    end;
  except
    on E: Exception do
    begin
{$IFNDEF NO_MONITOR}
    if MonitoringEnabled  then
     if MonitorHook<>nil then
      with THackMonitorHook(MonitorHook) do    //Added Source
      begin
       if Assigned(Owner) then   st:=Owner.Name+'.'+Name else st:=Name;
       WriteSQLData(st + ': [Prepare] ' + E.Message,tfQPrepare);
      end;      
{$ENDIF}
      if Assigned(Database.SQLLogger) then
      begin
       Database.SQLLogger.WriteData(
        CmpFullName(Self),'Error on Prepare:',
        FProcessedSQL,lfQPrepare
       );
      end;
      if (FHandle <> nil) then
        FreeHandle;
      raise;
    end;
  end;
 finally
  Exclude(FQueryRunState,qrsInPrepare);
 end
end;
 
procedure TFIBQuery.SetSQL(Value: TStrings);
begin
  FSQL.Assign(Value);
end;
 
procedure TFIBQuery.SetMacroChar(Value:Char);
begin
 if Value=' ' then
  FMacroChar:=#0
 else
  FMacroChar:=Value
end;

procedure TFIBQuery.SetTransaction(Value: TFIBTransaction);
begin
  FBase.Transaction := Value;
end;
 

function TFIBQuery.GetModifyTable:string;
begin
 if FModifyTable='-1' then
 begin
  SQLChange(nil);
  FModifyTable:=SqlTxtRtns.GetModifyTable(FParser.SQLText);
 end;
 Result:=FModifyTable
end;

procedure TFIBQuery.SaveStreamedParams;
var
  bs:  TFIBBlobStream;
  i:integer;
begin
  if not FHaveStreamParams then
   Exit;
 
  bs := TFIBBlobStream.Create;
  try
    bs.Mode := bmWrite;
    for i:=0 to Pred(Params.Count) do
    with Params[i] do
    if FStreamValue<>nil then
    begin
      IsNull:=False;
      bs.blobSubType:=ServerSQLSubType;
      with FQuery do
      begin
       bs.Database := Database;
       bs.Transaction := Transaction;
       FStreamValue.Seek(0, soFromBeginning);
       bs.LoadFromStream(FStreamValue);
       if qoStartTransaction in Options then
        if (Transaction<>nil) and not Transaction.InTransaction then
           Transaction.StartTransaction;
      end;
      bs.Finalize;
      AsQuad := bs.BlobID;
    end
  finally
    bs.Free;
  end;
end;

procedure TFIBQuery.ClearStreamedParams;
var 
  i:  integer;
begin
  if not FHaveStreamParams then
   Exit;
    for i:=0 to Pred(Params.Count) do
    with Params[i] do
     if FStreamValue<>nil then
     begin
      FreeAndNil(FStreamValue);
     end;
   FHaveStreamParams:=False
end;
 
procedure TFIBQuery.SetParamCheck(Value:boolean);
begin
 FDoParamCheck:=Value;
 FParamCheck:=Value;
 if not Value then
  begin
    FUserSQLParams.Count:=0;
    FSQLParams    .Count:=0;
    FProcessedSQL := FSQL.Text;
    FreeHandle;
  end

end;

procedure TFIBQuery.SQLChange(Sender: TObject);
begin
  FParser.SQLText:=FSQL.Text;
  if FCountLockSQL>0 then
   Exit;
  Inc(FSQLTextChangeCount); // Internal Use
  FModifyTable:='-1';
  FDoParamCheck:=ParamCheck;
  if not FDoParamCheck or (FSQL.Count=0) or ParamsNotExist(FParser.SQLText)
  then
  begin
    FUserSQLParams.Count:=0;
    FSQLParams    .Count:=0;
    FProcessedSQL := FParser.SQLText;
  end
  else
  begin
   // For register Params
    PreprocessSQL(FParser.SQLText,True);
    if FUserSQLParams.Count=0 then
     FProcessedSQL := FParser.SQLText
    else
     FProcessedSQL := '';
  end;
  FreeHandle;
  vUserParamsCreated:=True;
  FCodePageApplied:=False;
end;

procedure TFIBQuery.SQLChanging(Sender: TObject);
begin
  if not (csDesigning in ComponentState) then
   CheckClosed('change sql text')
  else
   Close;
  with Conditions do
   if State =[] then
   begin
    RestorePrimarySQL;
    PrimarySQL:=''
   end;
  if Assigned(OnSQLChanging) then OnSQLChanging(Self);
  if FHandle <> nil then FreeHandle;
  FMacroChanged :=False;
end;


procedure TFIBQuery.DoTransactionEnding(Sender: TObject);
begin
  if Transaction.State in [tsDoRollback,tsDoCommit] then
  if FAutoCloseOnTransactionEnd then
   if (FOpen) then Close;
end;
 
//// Routine work
procedure TFIBQuery.SetParamValues(const ParamValues: array of Variant);
var 
    i :  integer;
    pc:integer;
begin
// Exec Query with ParamValues
 if High(ParamValues)<Pred(Params.Count) then
  pc:=High(ParamValues)
 else
  pc:=Pred(Params.Count);
 for i:=Low(ParamValues)  to pc do
  Params[i].AsVariant:=ParamValues[i];
end;
 
procedure TFIBQuery.SetParamValues(const ParamNames: string;ParamValues: array of Variant);
var 
    i :  integer;
    pc:integer;
    curPar:TFIBXSQLVAR;

begin
 pc:=WordCount(ParamNames,[';'])-1;
 if pc<>High(ParamValues) then
  raise Exception.Create(
   Format(SFIBParamsCountNotEquelValuesCount, ['procedure '+ CmpFullName(Self)+'.SetParamValues'])
  );
 for i:=0  to pc do
 begin
  curPar:=ParamByName(ExtractWord(i+1,ParamNames,[';']));
  curPar.AsVariant:=ParamValues[i];
 end;
end;

procedure TFIBQuery.ExecWP(const ParamValues: array of Variant);
begin
// Exec Query with ParamValues
 SetParamValues(ParamValues);
 ExecQuery
end;

procedure TFIBQuery.ExecWP(const ParamNames: string;ParamValues: array of Variant);
begin
 SetParamValues(ParamNames,ParamValues);
 ExecQuery
end;
 
function  TFIBQuery.FieldCount:integer;
begin
  if FSQLRecord<>nil then
    Result:=FSQLRecord.Count
  else
    Result:=0;
end;

function TFIBQuery.FindParam  (const aParamName: string): TFIBXSQLVAR;
begin
 Result:=Params.ByName[aParamName];
end;

function  TFIBQuery.ParamByName(const ParamName:string): TFIBXSQLVAR;
begin
   Result:=Params.ByName[ParamName];
   if (Result=nil) and IsProc then Result:=FieldByName(ParamName);
   if (Result=nil) then
     raise Exception.Create(
       Format(SFIBErrorParamNotExist, [ParamName, CmpFullName(Self)])
     );
end;

procedure TFIBQuery.ApplyMacro;
begin
  if csDesigning in ComponentState then
   Exit;
  Close;
  FreeHandle;
  PreprocessSQL(ReadySQLText,False);
  FMacroChanged:=False;
end;

procedure TFIBQuery.RestoreMacroDefaultValues;
var
    i: integer;
begin
  for i:=0 to Pred(Params.Count) do
  if Params[i].IsMacro then
  begin
   Params[i].asString:=Params[i].DefMacroValue
  end;
end;

function  TFIBQuery.IsProc :boolean;
begin
  Result:= FastUpperCase(FastCopy(TrimLeft(SQL.Text),1,8))=ExecProcPrefix
end;

// Conditions;
procedure TFIBQuery.SetConditions(Value:TConditions);
begin
 FConditions.Assign(Value)
end;


function  TFIBQuery.ParamCount:integer;
begin
  Result:=Params.Count
end;
 
function  TFIBQuery.ParamName(ParamIndex:integer):string;
begin
  Result:=Params[ParamIndex].Name;
end;
 
function  TFIBQuery.FieldName(FieldIndex:integer):string;
begin
  Result:=FSQLRecord[FieldIndex].Name;
end;

function  TFIBQuery.FieldsCount:integer;
begin
  Result:=FieldCount
end;

function  TFIBQuery.FieldExist(const FieldName:string; var FieldIndex:integer):boolean;
begin
  FieldIndex:=GetFieldIndex(FieldName);
  Result:=FieldIndex>-1
end;

function  TFIBQuery.ParamExist(const ParamName:string; var ParamIndex:integer):boolean;
var Par:TFIBXSQLVAR;
begin
  Par:=FindParam(ParamName);
  Result:= Assigned(Par);
  if Result then
   ParamIndex:=Par.FIndex
end;
 
function  TFIBQuery.FieldValue(const FieldName:string;Old:boolean):variant;
begin
  Result:=FieldByName(FieldName).Value;
end;
 
function  TFIBQuery.FieldValue(const FieldIndex:integer;Old:boolean):variant;
begin
  Result:=GetFields(FieldIndex).Value;
end;

function  TFIBQuery.ParamValue(const ParamName:string):variant;
begin
  Result:=ParamByName(ParamName).Value;
end;
 
function  TFIBQuery.ParamValue(const ParamIndex:integer):variant;
begin
  Result:=Params[ParamIndex].Value;
end;

function TFIBQuery.WhereClausesCount:integer;
begin
 Result:=WhereCount(SQL.Text)
end;

procedure TFIBQuery.SetPlanClause(const Value:string);
begin
  SQL.Text := FParser.SetMainPlan(Value);
end;

function  TFIBQuery.GetPlanClause:string;
begin
  Result := FParser.MainPlanClause;
end;

function TFIBQuery.GetWhereClause(Index:Integer):string;
var 
   StartPos,EndPos: integer;
begin
  Result := FParser.WhereClause(Index,StartPos,EndPos);
end;

procedure TFIBQuery.
 SetWhereClause(Index:Integer;const WhereClauseTxt:string);
begin
  SQL.Text := FParser.SetWhereClause(Index,WhereClauseTxt);
end;
 
function  TFIBQuery.GetOrderString:string;
begin
  Result := FParser.OrderClause;
end;
 
function  TFIBQuery.GetGroupByString:string;
begin
  Result:=FParser.GroupByClause
end;
 
procedure TFIBQuery.SetGroupByString(const GroupByTxt:string);
var
   CondApplied:  boolean;
begin
  CondApplied:=Conditions.Applied;
  Conditions.CancelApply;
  SQL.Text:= FParser.SetGroupClause(GroupByTxt);
  if CondApplied then
    Conditions.Apply;
end;
 
function  TFIBQuery.GetFieldsClause:string;
begin
  Result := FParser.GetFieldsClause
end;
 
procedure TFIBQuery.SetFieldsClause(const NewFields:string);
var
   CondApplied: boolean;
begin
  CondApplied:=Conditions.Applied;
  Conditions.CancelApply;
  SQL.Text:= FParser.SetFieldsClause(NewFields);
  if CondApplied then
    Conditions.Apply;
end;

procedure TFIBQuery.SetOrderString(const OrderTxt:string);
var
   CondApplied: boolean;
begin
  CondApplied:=Conditions.Applied;
  Conditions.CancelApply;
  SQL.Text:= FParser.SetOrderClause(OrderTxt);
  if CondApplied then
    Conditions.Apply;
end;
 
procedure TFIBQuery.SetParamValue(const ParamIndex: integer;
  aValue: Variant);
begin
  Params[ParamIndex].Value:=aValue;
end;

function  TFIBQuery.IEof:boolean;
begin
  Result:=Eof
end;
 
procedure TFIBQuery.INext;
begin
  Next
end;
//
function TFIBQuery.GetSQLKind: TSQLKind;
begin
   Result:=FParser.SQLKind
end;
 
procedure TFIBQuery.AssignProperties(Source: TFIBQuery);
begin
 CopyProps(Source,Self);
end;
 
{$IFDEF CSMonitor}
procedure TFIBQuery.SetMonitorSupport(Value:TCSMonitorSupport);
begin
 FCSMonitorSupport.Assign(Value)
end;

function TFIBQuery.GetCSMonText: string;
var
  bWasComment, bEnabled, bIncludeDSDesc:  boolean;
  // db
  DB_pl: TFIBDatabase;
  sDB_pl_name: string;
  // tr
  Tr_pl: TFIBTransaction;
  sTr_pl_name: string;
  // tr
  sDs_pl_name: string;
begin
  Result := '';
  bWasComment := false;
  bIncludeDSDesc := FCSMonitorSupport.IncludeDatasetDescription;
  bEnabled := FCSMonitorSupport.Enabled = csmeEnabled;
  if FCSMonitorSupport.Enabled = csmeDisabled then exit;
  DB_pl := GetDatabase;
  if (not Assigned(DB_pl)) then Exit;
  Tr_pl := GetTransaction;
  if (not Assigned(Tr_pl)) then Exit;
  if not bEnabled then
    bEnabled := (FCSMonitorSupport.Enabled = csmeTransactionDriven) and
      (Tr_pl.CSMonitorSupport.Enabled = csmeEnabled);
  if not bEnabled then
    bEnabled := (FCSMonitorSupport.Enabled = csmeDatabaseDriven) and
      (DB_pl.CSMonitorSupport.Enabled = csmeEnabled);
  if not bEnabled then
    bEnabled := (FCSMonitorSupport.Enabled = csmeTransactionDriven) and
      (Tr_pl.CSMonitorSupport.Enabled = csmeDatabaseDriven) and
      (DB_pl.CSMonitorSupport.Enabled = csmeEnabled);
  if not bEnabled then Exit;
  // db
  sDB_pl_name := '';
  if Assigned(DB_pl) then
  begin
    sDB_pl_name := DB_pl.Name;
    if IsEmptyStr(sDB_pl_name) then sDB_pl_name := 'DB_0x' + IntToHex(integer(DB_pl), 8);
    if Assigned(DB_pl.Owner) then sDB_pl_name :=
      DB_pl.Owner.Name + '.' + sDB_pl_name;
  end;
  if sDB_pl_name <> '' then
  begin
    Result := '/* CSMON$CON_NAME=' + sDB_pl_name + '; ';
    bWasComment := true;
  end;
  // tr
  sTr_pl_name := '';
  if Assigned(Tr_pl) then
  begin
    sTr_pl_name := Tr_pl.Name;
    if IsEmptyStr(sTr_pl_name) then sTr_pl_name := 'Trans_0x' + IntToHex(integer(Tr_pl), 8);
    if Assigned(Tr_pl.Owner) then sTr_pl_name :=
      Tr_pl.Owner.Name + '.' + sTr_pl_name;
  end;
  if sTr_pl_name <> '' then
  begin
    if not bWasComment then Result := Result + '/* ';
    Result := Result + 'CSMON$TR_NAME=' + sTr_pl_name + '; ';
    bWasComment := True;
  end;
  sDs_pl_name := Name;
  if IsEmptyStr(sDs_pl_name) then
   sDs_pl_name := 'Query_0x' + IntToHex(integer(Self), 8);
  if Assigned(Owner) then
    if Owner is TFIBDataSet then
    begin
      if Owner is TpFIBDataSet then
      begin
        if (not IsEmptyStr((Owner as TpFIBDataSet).Description) ) and bIncludeDSDesc then
          sDs_pl_name := Owner.Name + ':[' + trim((Owner as TpFIBDataSet).Description) + '].' + sDs_pl_name else
          sDs_pl_name := Owner.Name + '.' + sDs_pl_name;
      end else sDs_pl_name := Owner.Name + '.' + sDs_pl_name;
      if assigned(Owner.Owner) then
        sDs_pl_name := Owner.Owner.Name + '.' + sDs_pl_name;
    end else sDs_pl_name := Owner.Name + '.' + sDs_pl_name;
  if sDs_pl_name <> '' then
  begin
    if not bWasComment then Result := Result + '/* ';
    Result := Result + 'CSMON$ST_NAME=' + sDs_pl_name + '; ';
    bWasComment := True;
  end;
  if bWasComment then Result := Result + ' */';
  Result := ' ' + Result;
end;
{$ENDIF}

{ TFIBBatch }

constructor TFIBBatch.Create;
begin
  inherited Create;
  FState  :=bsNotPrepared;
end;

initialization
 DisableEncodingSQLText:=False;
finalization
//
end.
