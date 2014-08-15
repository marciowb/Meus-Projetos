{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_OleDB;

interface

uses
  Windows,
  ActiveX,
  OleDB,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatOleDBLibrary = class(TatScripterLibrary)
    procedure __GetCLSID_OLEDB_ENUMERATOR(AMachine: TatVirtualMachine);
    procedure __GetCLSID_EXTENDEDERRORINFO(AMachine: TatVirtualMachine);
    procedure __GetCLSID_MSDAVTM(AMachine: TatVirtualMachine);
    procedure __GetCLSID_OLEDB_CONVERSIONLIBRARY(AMachine: TatVirtualMachine);
    procedure __GetCLSID_OLEDB_ROWPOSITIONLIBRARY(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DATALINKS(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransaction(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransactionOptions(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransactionDispenser(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransactionOutcomeEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IAccessor(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetLocate(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetResynch(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetScroll(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetChange(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetUpdate(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetIndex(AMachine: TatVirtualMachine);
    procedure __GetIID_IMultipleResults(AMachine: TatVirtualMachine);
    procedure __GetIID_IConvertType(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommandPrepare(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommandProperties(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommand(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommandWithParameters(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommandText(AMachine: TatVirtualMachine);
    procedure __GetIID_IColumnsRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_IColumnsInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBCreateCommand(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBCreateSession(AMachine: TatVirtualMachine);
    procedure __GetIID_ISourcesRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBProperties(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBInitialize(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBDataSourceAdmin(AMachine: TatVirtualMachine);
    procedure __GetIID_ISessionProperties(AMachine: TatVirtualMachine);
    procedure __GetIID_IIndexDefinition(AMachine: TatVirtualMachine);
    procedure __GetIID_ITableDefinition(AMachine: TatVirtualMachine);
    procedure __GetIID_IOpenRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_IErrorLookup(AMachine: TatVirtualMachine);
    procedure __GetIID_ISQLErrorInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IGetDataSource(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransactionLocal(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransactionJoin(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransactionObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBAsynchStatus(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetFind(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowPosition(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowPositionChange(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewChapter(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewSort(AMachine: TatVirtualMachine);
    procedure __GetIID_IViewFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetView(AMachine: TatVirtualMachine);
    procedure __GetIID_IMDFind(AMachine: TatVirtualMachine);
    procedure __GetIID_IMDRangeRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_IAlterTable(AMachine: TatVirtualMachine);
    procedure __GetIID_IAlterIndex(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommandPersist(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetChapterMember(AMachine: TatVirtualMachine);
    procedure __GetIID_IRowsetRefresh(AMachine: TatVirtualMachine);
    procedure __GetIID_IParentRowset(AMachine: TatVirtualMachine);
    procedure __GetIID_ITrusteeGroupAdmin(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectAccessControl(AMachine: TatVirtualMachine);
    procedure __GetIID_ISecurityInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IDBPromptInitialize(AMachine: TatVirtualMachine);
    procedure __GetIID_IDataInitialize(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_TABLES_INFO(AMachine: TatVirtualMachine);
    procedure __GetMDGUID_MDX(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_MDX(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_CUBES(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_DIMENSIONS(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_HIERARCHIES(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_LEVELS(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_MEASURES(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_PROPERTIES(AMachine: TatVirtualMachine);
    procedure __GetMDSCHEMA_MEMBERS(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_TRUSTEE(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_TABLE(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_COLUMN(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_DATABASE(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_PROCEDURE(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_VIEW(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_SCHEMA(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_DOMAIN(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_COLLATION(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_TRUSTEE(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_SCHEMAROWSET(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_CHARACTERSET(AMachine: TatVirtualMachine);
    procedure __GetDBOBJECT_TRANSLATION(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_CHECK_OPTION(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_CONSTRAINT_CHECK_DEFERRED(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_DROP_CASCADE(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_UNIQUE(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_ON_COMMIT_PRESERVE_ROWS(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_PRIMARY(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_CLUSTERED(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_NONCLUSTERED(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_BTREE(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_HASH(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_FILLFACTOR(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_INITIALSIZE(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_DISALLOWNULL(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_IGNORENULL(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_IGNOREANYNULL(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_SORTBOOKMARKS(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_AUTOMATICUPDATE(AMachine: TatVirtualMachine);
    procedure __GetDB_PROPERTY_EXPLICITUPDATE(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_LIKE_SQL(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_LIKE_DOS(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_LIKE_OFS(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_LIKE_MAPI(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_ASSERTIONS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_CATALOGS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_CHARACTER_SETS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_COLLATIONS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_COLUMNS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_CHECK_CONSTRAINTS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_CONSTRAINT_COLUMN_USAGE(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_CONSTRAINT_TABLE_USAGE(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_KEY_COLUMN_USAGE(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_REFERENTIAL_CONSTRAINTS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_TABLE_CONSTRAINTS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_COLUMN_DOMAIN_USAGE(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_INDEXES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_COLUMN_PRIVILEGES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_TABLE_PRIVILEGES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_USAGE_PRIVILEGES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_PROCEDURES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_SCHEMATA(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_SQL_LANGUAGES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_STATISTICS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_TABLES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_TRANSLATIONS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_PROVIDER_TYPES(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_VIEWS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_VIEW_COLUMN_USAGE(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_VIEW_TABLE_USAGE(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_PROCEDURE_PARAMETERS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_FOREIGN_KEYS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_PRIMARY_KEYS(AMachine: TatVirtualMachine);
    procedure __GetDBSCHEMA_PROCEDURE_COLUMNS(AMachine: TatVirtualMachine);
    procedure __GetDBCOL_SELFCOLUMNS(AMachine: TatVirtualMachine);
    procedure __GetDBCOL_SPECIALCOL(AMachine: TatVirtualMachine);
    procedure __GetPSGUID_QUERY(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_COLUMN(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_DATASOURCE(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_DATASOURCEINFO(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_INDEX(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_DBINIT(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_ROWSET(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_SESSION(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_TABLE(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_PROPERTIESINERROR(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_VIEW(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_DATASOURCEALL(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_DATASOURCEINFOALL(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_DBINITALL(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_ROWSETALL(AMachine: TatVirtualMachine);
    procedure __GetDBPROPSET_SESSIONALL(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_DEFAULT(AMachine: TatVirtualMachine);
    procedure __GetDBGUID_SQL(AMachine: TatVirtualMachine);
    procedure __GetDBCIDGUID(AMachine: TatVirtualMachine);
    procedure __GetDB_NULLGUID(AMachine: TatVirtualMachine);
    procedure __GetDB_NULLID(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_IDNAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_NAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_NUMBER(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_TYPE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_PRECISION(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_SCALE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_FLAGS(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_BASECOLUMNNAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_BASETABLENAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_COLLATINGSEQUENCE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_COMPUTEMODE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_DEFAULTVALUE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_DOMAINNAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_HASDEFAULT(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_ISAUTOINCREMENT(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_ISCASESENSITIVE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_ISSEARCHABLE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_ISUNIQUE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_BASECATALOGNAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_BASESCHEMANAME(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_GUID(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_PROPID(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_TYPEINFO(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_DOMAINCATALOG(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_DOMAINSCHEMA(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_DATETIMEPRECISION(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_NUMERICPRECISIONRADIX(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_OCTETLENGTH(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_COLUMNSIZE(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_CLSID(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_BASETABLEVERSION(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_KEYCOLUMN(AMachine: TatVirtualMachine);
    procedure __GetDBCOLUMN_MAYSORT(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  BOIDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: BOID);
    function ObjToRec: BOID;
  published
  end;
  
  XACTTRANSINFOWrapper = class(TatRecordWrapper)
  private
    FisoLevel: Integer;
    FisoFlags: UINT;
    FgrfTCSupported: UINT;
    FgrfRMSupported: UINT;
    FgrfTCSupportedRetaining: UINT;
    FgrfRMSupportedRetaining: UINT;
  public
    constructor Create(ARecord: XACTTRANSINFO);
    function ObjToRec: XACTTRANSINFO;
  published
    property isoLevel: Integer read FisoLevel write FisoLevel;
    property isoFlags: UINT read FisoFlags write FisoFlags;
    property grfTCSupported: UINT read FgrfTCSupported write FgrfTCSupported;
    property grfRMSupported: UINT read FgrfRMSupported write FgrfRMSupported;
    property grfTCSupportedRetaining: UINT read FgrfTCSupportedRetaining write FgrfTCSupportedRetaining;
    property grfRMSupportedRetaining: UINT read FgrfRMSupportedRetaining write FgrfRMSupportedRetaining;
  end;
  
  XACTOPTWrapper = class(TatRecordWrapper)
  private
    FulTimeout: UINT;
  public
    constructor Create(ARecord: XACTOPT);
    function ObjToRec: XACTOPT;
  published
    property ulTimeout: UINT read FulTimeout write FulTimeout;
  end;
  
  XACTSTATSWrapper = class(TatRecordWrapper)
  private
    FcOpen: UINT;
    FcCommitting: UINT;
    FcCommitted: UINT;
    FcAborting: UINT;
    FcAborted: UINT;
    FcInDoubt: UINT;
    FcHeuristicDecision: UINT;
  public
    constructor Create(ARecord: XACTSTATS);
    function ObjToRec: XACTSTATS;
  published
    property cOpen: UINT read FcOpen write FcOpen;
    property cCommitting: UINT read FcCommitting write FcCommitting;
    property cCommitted: UINT read FcCommitted write FcCommitted;
    property cAborting: UINT read FcAborting write FcAborting;
    property cAborted: UINT read FcAborted write FcAborted;
    property cInDoubt: UINT read FcInDoubt write FcInDoubt;
    property cHeuristicDecision: UINT read FcHeuristicDecision write FcHeuristicDecision;
  end;
  
  DBBINDEXTWrapper = class(TatRecordWrapper)
  private
    FulExtension: UINT;
  public
    constructor Create(ARecord: DBBINDEXT);
    function ObjToRec: DBBINDEXT;
  published
    property ulExtension: UINT read FulExtension write FulExtension;
  end;
  
  DBOBJECTWrapper = class(TatRecordWrapper)
  private
    FdwFlags: UINT;
  public
    constructor Create(ARecord: DBOBJECT);
    function ObjToRec: DBOBJECT;
  published
    property dwFlags: UINT read FdwFlags write FdwFlags;
  end;
  
  DBBINDINGWrapper = class(TatRecordWrapper)
  private
    FiOrdinal: UINT;
    FobValue: UINT;
    FobLength: UINT;
    FobStatus: UINT;
    FdwPart: DBPART;
    FdwMemOwner: DBMEMOWNER;
    FeParamIO: DBPARAMIO;
    FcbMaxLen: UINT;
    FdwFlags: UINT;
    FwType: DBTYPE;
    FbPrecision: Byte;
    FbScale: Byte;
  public
    constructor Create(ARecord: DBBINDING);
    function ObjToRec: DBBINDING;
  published
    property iOrdinal: UINT read FiOrdinal write FiOrdinal;
    property obValue: UINT read FobValue write FobValue;
    property obLength: UINT read FobLength write FobLength;
    property obStatus: UINT read FobStatus write FobStatus;
    property dwPart: DBPART read FdwPart write FdwPart;
    property dwMemOwner: DBMEMOWNER read FdwMemOwner write FdwMemOwner;
    property eParamIO: DBPARAMIO read FeParamIO write FeParamIO;
    property cbMaxLen: UINT read FcbMaxLen write FcbMaxLen;
    property dwFlags: UINT read FdwFlags write FdwFlags;
    property wType: DBTYPE read FwType write FwType;
    property bPrecision: Byte read FbPrecision write FbPrecision;
    property bScale: Byte read FbScale write FbScale;
  end;
  
  DBIDNAMEWrapper = class(TatRecordWrapper)
  private
    FulPropid: UINT;
  public
    constructor Create(ARecord: DBIDNAME);
    function ObjToRec: DBIDNAME;
  published
    property ulPropid: UINT read FulPropid write FulPropid;
  end;
  
  DBIDGUIDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: DBIDGUID);
    function ObjToRec: DBIDGUID;
  published
  end;
  
  DBIDWrapper = class(TatRecordWrapper)
  private
    FeKind: DBKIND;
  public
    constructor Create(ARecord: DBID);
    function ObjToRec: DBID;
  published
    property eKind: DBKIND read FeKind write FeKind;
  end;
  
  DBPROPIDSETWrapper = class(TatRecordWrapper)
  private
    FcPropertyIDs: UINT;
  public
    constructor Create(ARecord: DBPROPIDSET);
    function ObjToRec: DBPROPIDSET;
  published
    property cPropertyIDs: UINT read FcPropertyIDs write FcPropertyIDs;
  end;
  
  DBPROPWrapper = class(TatRecordWrapper)
  private
    FdwPropertyID: DBPROPID;
    FdwOptions: DBPROPOPTIONS;
    FdwStatus: DBPROPSTATUS;
    FvValue: OleVariant;
  public
    constructor Create(ARecord: DBPROP);
    function ObjToRec: DBPROP;
  published
    property dwPropertyID: DBPROPID read FdwPropertyID write FdwPropertyID;
    property dwOptions: DBPROPOPTIONS read FdwOptions write FdwOptions;
    property dwStatus: DBPROPSTATUS read FdwStatus write FdwStatus;
    property vValue: OleVariant read FvValue write FvValue;
  end;
  
  DBPROPSETWrapper = class(TatRecordWrapper)
  private
    FcProperties: UINT;
  public
    constructor Create(ARecord: DBPROPSET);
    function ObjToRec: DBPROPSET;
  published
    property cProperties: UINT read FcProperties write FcProperties;
  end;
  
  DBPROPINFOWrapper = class(TatRecordWrapper)
  private
    FdwPropertyID: DBPROPID;
    FdwFlags: DBPROPFLAGS;
    FvtType: Word;
    FvValues: OleVariant;
  public
    constructor Create(ARecord: DBPROPINFO);
    function ObjToRec: DBPROPINFO;
  published
    property dwPropertyID: DBPROPID read FdwPropertyID write FdwPropertyID;
    property dwFlags: DBPROPFLAGS read FdwFlags write FdwFlags;
    property vtType: Word read FvtType write FvtType;
    property vValues: OleVariant read FvValues write FvValues;
  end;
  
  DBPROPINFOSETWrapper = class(TatRecordWrapper)
  private
    FcPropertyInfos: UINT;
  public
    constructor Create(ARecord: DBPROPINFOSET);
    function ObjToRec: DBPROPINFOSET;
  published
    property cPropertyInfos: UINT read FcPropertyInfos write FcPropertyInfos;
  end;
  
  DBINDEXCOLUMNDESCWrapper = class(TatRecordWrapper)
  private
    FeIndexColOrder: DBINDEX_COL_ORDER;
  public
    constructor Create(ARecord: DBINDEXCOLUMNDESC);
    function ObjToRec: DBINDEXCOLUMNDESC;
  published
    property eIndexColOrder: DBINDEX_COL_ORDER read FeIndexColOrder write FeIndexColOrder;
  end;
  
  DBPARAMSWrapper = class(TatRecordWrapper)
  private
    FcParamSets: UINT;
    FHACCESSOR: HACCESSOR;
  public
    constructor Create(ARecord: DBPARAMS);
    function ObjToRec: DBPARAMS;
  published
    property cParamSets: UINT read FcParamSets write FcParamSets;
    property HACCESSOR: HACCESSOR read FHACCESSOR write FHACCESSOR;
  end;
  
  DBCOLUMNINFOWrapper = class(TatRecordWrapper)
  private
    FiOrdinal: UINT;
    FdwFlags: DBCOLUMNFLAGS;
    FulColumnSize: UINT;
    FwType: DBTYPE;
    FbPrecision: Byte;
    FbScale: Byte;
  public
    constructor Create(ARecord: DBCOLUMNINFO);
    function ObjToRec: DBCOLUMNINFO;
  published
    property iOrdinal: UINT read FiOrdinal write FiOrdinal;
    property dwFlags: DBCOLUMNFLAGS read FdwFlags write FdwFlags;
    property ulColumnSize: UINT read FulColumnSize write FulColumnSize;
    property wType: DBTYPE read FwType write FwType;
    property bPrecision: Byte read FbPrecision write FbPrecision;
    property bScale: Byte read FbScale write FbScale;
  end;
  
  DBLITERALINFOWrapper = class(TatRecordWrapper)
  private
    Flt: UINT;
    FfSupported: BOOL;
    FcchMaxLen: UINT;
  public
    constructor Create(ARecord: DBLITERALINFO);
    function ObjToRec: DBLITERALINFO;
  published
    property lt: UINT read Flt write Flt;
    property fSupported: BOOL read FfSupported write FfSupported;
    property cchMaxLen: UINT read FcchMaxLen write FcchMaxLen;
  end;
  
  DBCOLUMNDESCWrapper = class(TatRecordWrapper)
  private
    FcPropertySets: UINT;
    FulColumnSize: UINT;
    FwType: DBTYPE;
    FbPrecision: Byte;
    FbScale: Byte;
  public
    constructor Create(ARecord: DBCOLUMNDESC);
    function ObjToRec: DBCOLUMNDESC;
  published
    property cPropertySets: UINT read FcPropertySets write FcPropertySets;
    property ulColumnSize: UINT read FulColumnSize write FulColumnSize;
    property wType: DBTYPE read FwType write FwType;
    property bPrecision: Byte read FbPrecision write FbPrecision;
    property bScale: Byte read FbScale write FbScale;
  end;
  
  SEC_OBJECT_ELEMENTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: SEC_OBJECT_ELEMENT);
    function ObjToRec: SEC_OBJECT_ELEMENT;
  published
  end;
  
  SEC_OBJECTWrapper = class(TatRecordWrapper)
  private
    FcObjects: UINT;
  public
    constructor Create(ARecord: SEC_OBJECT);
    function ObjToRec: SEC_OBJECT;
  published
    property cObjects: UINT read FcObjects write FcObjects;
  end;
  
  TRUSTEE_WWrapper = class(TatRecordWrapper)
  private
    FMultipleTrusteeOperation: MULTIPLE_TRUSTEE_OPERATION;
    FTrusteeForm: TRUSTEE_FORM;
    FTrusteeType: TRUSTEE_TYPE;
  public
    constructor Create(ARecord: TRUSTEE_W);
    function ObjToRec: TRUSTEE_W;
  published
    property MultipleTrusteeOperation: MULTIPLE_TRUSTEE_OPERATION read FMultipleTrusteeOperation write FMultipleTrusteeOperation;
    property TrusteeForm: TRUSTEE_FORM read FTrusteeForm write FTrusteeForm;
    property TrusteeType: TRUSTEE_TYPE read FTrusteeType write FTrusteeType;
  end;
  
  DBPARAMINFOWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DBPARAMFLAGS;
    FiOrdinal: UINT;
    FulParamSize: UINT;
    FwType: DBTYPE;
    FbPrecision: Byte;
    FbScale: Byte;
  public
    constructor Create(ARecord: DBPARAMINFO);
    function ObjToRec: DBPARAMINFO;
  published
    property dwFlags: DBPARAMFLAGS read FdwFlags write FdwFlags;
    property iOrdinal: UINT read FiOrdinal write FiOrdinal;
    property ulParamSize: UINT read FulParamSize write FulParamSize;
    property wType: DBTYPE read FwType write FwType;
    property bPrecision: Byte read FbPrecision write FbPrecision;
    property bScale: Byte read FbScale write FbScale;
  end;
  
  DB_NUMERICWrapper = class(TatRecordWrapper)
  private
    Fprecision: Byte;
    Fscale: Byte;
    Fsign: Byte;
  public
    constructor Create(ARecord: DB_NUMERIC);
    function ObjToRec: DB_NUMERIC;
  published
    property precision: Byte read Fprecision write Fprecision;
    property scale: Byte read Fscale write Fscale;
    property sign: Byte read Fsign write Fsign;
  end;
  
  DBVECTORWrapper = class(TatRecordWrapper)
  private
    Fsize: UINT;
  public
    constructor Create(ARecord: DBVECTOR);
    function ObjToRec: DBVECTOR;
  published
    property size: UINT read Fsize write Fsize;
  end;
  
  DBDATEWrapper = class(TatRecordWrapper)
  private
    Fyear: Smallint;
    Fmonth: Word;
    Fday: Word;
  public
    constructor Create(ARecord: DBDATE);
    function ObjToRec: DBDATE;
  published
    property year: Smallint read Fyear write Fyear;
    property month: Word read Fmonth write Fmonth;
    property day: Word read Fday write Fday;
  end;
  
  DBTIMEWrapper = class(TatRecordWrapper)
  private
    Fhour: Word;
    Fminute: Word;
    Fsecond: Word;
  public
    constructor Create(ARecord: DBTIME);
    function ObjToRec: DBTIME;
  published
    property hour: Word read Fhour write Fhour;
    property minute: Word read Fminute write Fminute;
    property second: Word read Fsecond write Fsecond;
  end;
  
  DBTIMESTAMPWrapper = class(TatRecordWrapper)
  private
    Fyear: Smallint;
    Fmonth: Word;
    Fday: Word;
    Fhour: Word;
    Fminute: Word;
    Fsecond: Word;
    Ffraction: UINT;
  public
    constructor Create(ARecord: DBTIMESTAMP);
    function ObjToRec: DBTIMESTAMP;
  published
    property year: Smallint read Fyear write Fyear;
    property month: Word read Fmonth write Fmonth;
    property day: Word read Fday write Fday;
    property hour: Word read Fhour write Fhour;
    property minute: Word read Fminute write Fminute;
    property second: Word read Fsecond write Fsecond;
    property fraction: UINT read Ffraction write Ffraction;
  end;
  
  DBFILETIMEWrapper = class(TatRecordWrapper)
  private
    FdwLowDateTime: UINT;
    FdwHighDateTime: UINT;
  public
    constructor Create(ARecord: DBFILETIME);
    function ObjToRec: DBFILETIME;
  published
    property dwLowDateTime: UINT read FdwLowDateTime write FdwLowDateTime;
    property dwHighDateTime: UINT read FdwHighDateTime write FdwHighDateTime;
  end;
  
  DB_VARNUMERICWrapper = class(TatRecordWrapper)
  private
    Fprecision: Byte;
    Fscale: SBYTE;
    Fsign: Byte;
  public
    constructor Create(ARecord: DB_VARNUMERIC);
    function ObjToRec: DB_VARNUMERIC;
  published
    property precision: Byte read Fprecision write Fprecision;
    property scale: SBYTE read Fscale write Fscale;
    property sign: Byte read Fsign write Fsign;
  end;
  
  DBFAILUREINFOWrapper = class(TatRecordWrapper)
  private
    FHROW: HROW;
    FiColumn: UINT;
    Ffailure: HResult;
  public
    constructor Create(ARecord: DBFAILUREINFO);
    function ObjToRec: DBFAILUREINFO;
  published
    property HROW: HROW read FHROW write FHROW;
    property iColumn: UINT read FiColumn write FiColumn;
    property failure: HResult read Ffailure write Ffailure;
  end;
  
  MDAXISINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiAxis: UINT;
    FcDimensions: UINT;
    FcCoordinates: UINT;
  public
    constructor Create(ARecord: MDAXISINFO);
    function ObjToRec: MDAXISINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iAxis: UINT read FiAxis write FiAxis;
    property cDimensions: UINT read FcDimensions write FcDimensions;
    property cCoordinates: UINT read FcCoordinates write FcCoordinates;
  end;
  
  DBPARAMBINDINFOWrapper = class(TatRecordWrapper)
  private
    FulParamSize: UINT;
    FdwFlags: DBPARAMFLAGS;
    FbPrecision: Byte;
    FbScale: Byte;
  public
    constructor Create(ARecord: DBPARAMBINDINFO);
    function ObjToRec: DBPARAMBINDINFO;
  published
    property ulParamSize: UINT read FulParamSize write FulParamSize;
    property dwFlags: DBPARAMFLAGS read FdwFlags write FdwFlags;
    property bPrecision: Byte read FbPrecision write FbPrecision;
    property bScale: Byte read FbScale write FbScale;
  end;
  
  ERRORINFOWrapper = class(TatRecordWrapper)
  private
    FhrError: HResult;
    FdwMinor: UINT;
    Fdispid: Integer;
  public
    constructor Create(ARecord: ERRORINFO);
    function ObjToRec: ERRORINFO;
  published
    property hrError: HResult read FhrError write FhrError;
    property dwMinor: UINT read FdwMinor write FdwMinor;
    property dispid: Integer read Fdispid write Fdispid;
  end;
  
  EXPLICIT_ACCESS_WWrapper = class(TatRecordWrapper)
  private
    FgrfAccessPermissions: UINT;
    FgrfAccessMode: ACCESS_MODE;
    FgrfInheritance: UINT;
  public
    constructor Create(ARecord: EXPLICIT_ACCESS_W);
    function ObjToRec: EXPLICIT_ACCESS_W;
  published
    property grfAccessPermissions: UINT read FgrfAccessPermissions write FgrfAccessPermissions;
    property grfAccessMode: ACCESS_MODE read FgrfAccessMode write FgrfAccessMode;
    property grfInheritance: UINT read FgrfInheritance write FgrfInheritance;
  end;
  

implementation

constructor BOIDWrapper.Create(ARecord: BOID);
begin
  inherited Create;
end;

function BOIDWrapper.ObjToRec: BOID;
begin
end;

constructor XACTTRANSINFOWrapper.Create(ARecord: XACTTRANSINFO);
begin
  inherited Create;
  FisoLevel := ARecord.isoLevel;
  FisoFlags := ARecord.isoFlags;
  FgrfTCSupported := ARecord.grfTCSupported;
  FgrfRMSupported := ARecord.grfRMSupported;
  FgrfTCSupportedRetaining := ARecord.grfTCSupportedRetaining;
  FgrfRMSupportedRetaining := ARecord.grfRMSupportedRetaining;
end;

function XACTTRANSINFOWrapper.ObjToRec: XACTTRANSINFO;
begin
  result.isoLevel := FisoLevel;
  result.isoFlags := FisoFlags;
  result.grfTCSupported := FgrfTCSupported;
  result.grfRMSupported := FgrfRMSupported;
  result.grfTCSupportedRetaining := FgrfTCSupportedRetaining;
  result.grfRMSupportedRetaining := FgrfRMSupportedRetaining;
end;

constructor XACTOPTWrapper.Create(ARecord: XACTOPT);
begin
  inherited Create;
  FulTimeout := ARecord.ulTimeout;
end;

function XACTOPTWrapper.ObjToRec: XACTOPT;
begin
  result.ulTimeout := FulTimeout;
end;

constructor XACTSTATSWrapper.Create(ARecord: XACTSTATS);
begin
  inherited Create;
  FcOpen := ARecord.cOpen;
  FcCommitting := ARecord.cCommitting;
  FcCommitted := ARecord.cCommitted;
  FcAborting := ARecord.cAborting;
  FcAborted := ARecord.cAborted;
  FcInDoubt := ARecord.cInDoubt;
  FcHeuristicDecision := ARecord.cHeuristicDecision;
end;

function XACTSTATSWrapper.ObjToRec: XACTSTATS;
begin
  result.cOpen := FcOpen;
  result.cCommitting := FcCommitting;
  result.cCommitted := FcCommitted;
  result.cAborting := FcAborting;
  result.cAborted := FcAborted;
  result.cInDoubt := FcInDoubt;
  result.cHeuristicDecision := FcHeuristicDecision;
end;

constructor DBBINDEXTWrapper.Create(ARecord: DBBINDEXT);
begin
  inherited Create;
  FulExtension := ARecord.ulExtension;
end;

function DBBINDEXTWrapper.ObjToRec: DBBINDEXT;
begin
  result.ulExtension := FulExtension;
end;

constructor DBOBJECTWrapper.Create(ARecord: DBOBJECT);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
end;

function DBOBJECTWrapper.ObjToRec: DBOBJECT;
begin
  result.dwFlags := FdwFlags;
end;

constructor DBBINDINGWrapper.Create(ARecord: DBBINDING);
begin
  inherited Create;
  FiOrdinal := ARecord.iOrdinal;
  FobValue := ARecord.obValue;
  FobLength := ARecord.obLength;
  FobStatus := ARecord.obStatus;
  FdwPart := ARecord.dwPart;
  FdwMemOwner := ARecord.dwMemOwner;
  FeParamIO := ARecord.eParamIO;
  FcbMaxLen := ARecord.cbMaxLen;
  FdwFlags := ARecord.dwFlags;
  FwType := ARecord.wType;
  FbPrecision := ARecord.bPrecision;
  FbScale := ARecord.bScale;
end;

function DBBINDINGWrapper.ObjToRec: DBBINDING;
begin
  result.iOrdinal := FiOrdinal;
  result.obValue := FobValue;
  result.obLength := FobLength;
  result.obStatus := FobStatus;
  result.dwPart := FdwPart;
  result.dwMemOwner := FdwMemOwner;
  result.eParamIO := FeParamIO;
  result.cbMaxLen := FcbMaxLen;
  result.dwFlags := FdwFlags;
  result.wType := FwType;
  result.bPrecision := FbPrecision;
  result.bScale := FbScale;
end;

constructor DBIDNAMEWrapper.Create(ARecord: DBIDNAME);
begin
  inherited Create;
  FulPropid := ARecord.ulPropid;
end;

function DBIDNAMEWrapper.ObjToRec: DBIDNAME;
begin
  result.ulPropid := FulPropid;
end;

constructor DBIDGUIDWrapper.Create(ARecord: DBIDGUID);
begin
  inherited Create;
end;

function DBIDGUIDWrapper.ObjToRec: DBIDGUID;
begin
end;

constructor DBIDWrapper.Create(ARecord: DBID);
begin
  inherited Create;
  FeKind := ARecord.eKind;
end;

function DBIDWrapper.ObjToRec: DBID;
begin
  result.eKind := FeKind;
end;

constructor DBPROPIDSETWrapper.Create(ARecord: DBPROPIDSET);
begin
  inherited Create;
  FcPropertyIDs := ARecord.cPropertyIDs;
end;

function DBPROPIDSETWrapper.ObjToRec: DBPROPIDSET;
begin
  result.cPropertyIDs := FcPropertyIDs;
end;

constructor DBPROPWrapper.Create(ARecord: DBPROP);
begin
  inherited Create;
  FdwPropertyID := ARecord.dwPropertyID;
  FdwOptions := ARecord.dwOptions;
  FdwStatus := ARecord.dwStatus;
  FvValue := ARecord.vValue;
end;

function DBPROPWrapper.ObjToRec: DBPROP;
begin
  result.dwPropertyID := FdwPropertyID;
  result.dwOptions := FdwOptions;
  result.dwStatus := FdwStatus;
  result.vValue := FvValue;
end;

constructor DBPROPSETWrapper.Create(ARecord: DBPROPSET);
begin
  inherited Create;
  FcProperties := ARecord.cProperties;
end;

function DBPROPSETWrapper.ObjToRec: DBPROPSET;
begin
  result.cProperties := FcProperties;
end;

constructor DBPROPINFOWrapper.Create(ARecord: DBPROPINFO);
begin
  inherited Create;
  FdwPropertyID := ARecord.dwPropertyID;
  FdwFlags := ARecord.dwFlags;
  FvtType := ARecord.vtType;
  FvValues := ARecord.vValues;
end;

function DBPROPINFOWrapper.ObjToRec: DBPROPINFO;
begin
  result.dwPropertyID := FdwPropertyID;
  result.dwFlags := FdwFlags;
  result.vtType := FvtType;
  result.vValues := FvValues;
end;

constructor DBPROPINFOSETWrapper.Create(ARecord: DBPROPINFOSET);
begin
  inherited Create;
  FcPropertyInfos := ARecord.cPropertyInfos;
end;

function DBPROPINFOSETWrapper.ObjToRec: DBPROPINFOSET;
begin
  result.cPropertyInfos := FcPropertyInfos;
end;

constructor DBINDEXCOLUMNDESCWrapper.Create(ARecord: DBINDEXCOLUMNDESC);
begin
  inherited Create;
  FeIndexColOrder := ARecord.eIndexColOrder;
end;

function DBINDEXCOLUMNDESCWrapper.ObjToRec: DBINDEXCOLUMNDESC;
begin
  result.eIndexColOrder := FeIndexColOrder;
end;

constructor DBPARAMSWrapper.Create(ARecord: DBPARAMS);
begin
  inherited Create;
  FcParamSets := ARecord.cParamSets;
  FHACCESSOR := ARecord.HACCESSOR;
end;

function DBPARAMSWrapper.ObjToRec: DBPARAMS;
begin
  result.cParamSets := FcParamSets;
  result.HACCESSOR := FHACCESSOR;
end;

constructor DBCOLUMNINFOWrapper.Create(ARecord: DBCOLUMNINFO);
begin
  inherited Create;
  FiOrdinal := ARecord.iOrdinal;
  FdwFlags := ARecord.dwFlags;
  FulColumnSize := ARecord.ulColumnSize;
  FwType := ARecord.wType;
  FbPrecision := ARecord.bPrecision;
  FbScale := ARecord.bScale;
end;

function DBCOLUMNINFOWrapper.ObjToRec: DBCOLUMNINFO;
begin
  result.iOrdinal := FiOrdinal;
  result.dwFlags := FdwFlags;
  result.ulColumnSize := FulColumnSize;
  result.wType := FwType;
  result.bPrecision := FbPrecision;
  result.bScale := FbScale;
end;

constructor DBLITERALINFOWrapper.Create(ARecord: DBLITERALINFO);
begin
  inherited Create;
  Flt := ARecord.lt;
  FfSupported := ARecord.fSupported;
  FcchMaxLen := ARecord.cchMaxLen;
end;

function DBLITERALINFOWrapper.ObjToRec: DBLITERALINFO;
begin
  result.lt := Flt;
  result.fSupported := FfSupported;
  result.cchMaxLen := FcchMaxLen;
end;

constructor DBCOLUMNDESCWrapper.Create(ARecord: DBCOLUMNDESC);
begin
  inherited Create;
  FcPropertySets := ARecord.cPropertySets;
  FulColumnSize := ARecord.ulColumnSize;
  FwType := ARecord.wType;
  FbPrecision := ARecord.bPrecision;
  FbScale := ARecord.bScale;
end;

function DBCOLUMNDESCWrapper.ObjToRec: DBCOLUMNDESC;
begin
  result.cPropertySets := FcPropertySets;
  result.ulColumnSize := FulColumnSize;
  result.wType := FwType;
  result.bPrecision := FbPrecision;
  result.bScale := FbScale;
end;

constructor SEC_OBJECT_ELEMENTWrapper.Create(ARecord: SEC_OBJECT_ELEMENT);
begin
  inherited Create;
end;

function SEC_OBJECT_ELEMENTWrapper.ObjToRec: SEC_OBJECT_ELEMENT;
begin
end;

constructor SEC_OBJECTWrapper.Create(ARecord: SEC_OBJECT);
begin
  inherited Create;
  FcObjects := ARecord.cObjects;
end;

function SEC_OBJECTWrapper.ObjToRec: SEC_OBJECT;
begin
  result.cObjects := FcObjects;
end;

constructor TRUSTEE_WWrapper.Create(ARecord: TRUSTEE_W);
begin
  inherited Create;
  FMultipleTrusteeOperation := ARecord.MultipleTrusteeOperation;
  FTrusteeForm := ARecord.TrusteeForm;
  FTrusteeType := ARecord.TrusteeType;
end;

function TRUSTEE_WWrapper.ObjToRec: TRUSTEE_W;
begin
  result.MultipleTrusteeOperation := FMultipleTrusteeOperation;
  result.TrusteeForm := FTrusteeForm;
  result.TrusteeType := FTrusteeType;
end;

constructor DBPARAMINFOWrapper.Create(ARecord: DBPARAMINFO);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FiOrdinal := ARecord.iOrdinal;
  FulParamSize := ARecord.ulParamSize;
  FwType := ARecord.wType;
  FbPrecision := ARecord.bPrecision;
  FbScale := ARecord.bScale;
end;

function DBPARAMINFOWrapper.ObjToRec: DBPARAMINFO;
begin
  result.dwFlags := FdwFlags;
  result.iOrdinal := FiOrdinal;
  result.ulParamSize := FulParamSize;
  result.wType := FwType;
  result.bPrecision := FbPrecision;
  result.bScale := FbScale;
end;

constructor DB_NUMERICWrapper.Create(ARecord: DB_NUMERIC);
begin
  inherited Create;
  Fprecision := ARecord.precision;
  Fscale := ARecord.scale;
  Fsign := ARecord.sign;
end;

function DB_NUMERICWrapper.ObjToRec: DB_NUMERIC;
begin
  result.precision := Fprecision;
  result.scale := Fscale;
  result.sign := Fsign;
end;

constructor DBVECTORWrapper.Create(ARecord: DBVECTOR);
begin
  inherited Create;
  Fsize := ARecord.size;
end;

function DBVECTORWrapper.ObjToRec: DBVECTOR;
begin
  result.size := Fsize;
end;

constructor DBDATEWrapper.Create(ARecord: DBDATE);
begin
  inherited Create;
  Fyear := ARecord.year;
  Fmonth := ARecord.month;
  Fday := ARecord.day;
end;

function DBDATEWrapper.ObjToRec: DBDATE;
begin
  result.year := Fyear;
  result.month := Fmonth;
  result.day := Fday;
end;

constructor DBTIMEWrapper.Create(ARecord: DBTIME);
begin
  inherited Create;
  Fhour := ARecord.hour;
  Fminute := ARecord.minute;
  Fsecond := ARecord.second;
end;

function DBTIMEWrapper.ObjToRec: DBTIME;
begin
  result.hour := Fhour;
  result.minute := Fminute;
  result.second := Fsecond;
end;

constructor DBTIMESTAMPWrapper.Create(ARecord: DBTIMESTAMP);
begin
  inherited Create;
  Fyear := ARecord.year;
  Fmonth := ARecord.month;
  Fday := ARecord.day;
  Fhour := ARecord.hour;
  Fminute := ARecord.minute;
  Fsecond := ARecord.second;
  Ffraction := ARecord.fraction;
end;

function DBTIMESTAMPWrapper.ObjToRec: DBTIMESTAMP;
begin
  result.year := Fyear;
  result.month := Fmonth;
  result.day := Fday;
  result.hour := Fhour;
  result.minute := Fminute;
  result.second := Fsecond;
  result.fraction := Ffraction;
end;

constructor DBFILETIMEWrapper.Create(ARecord: DBFILETIME);
begin
  inherited Create;
  FdwLowDateTime := ARecord.dwLowDateTime;
  FdwHighDateTime := ARecord.dwHighDateTime;
end;

function DBFILETIMEWrapper.ObjToRec: DBFILETIME;
begin
  result.dwLowDateTime := FdwLowDateTime;
  result.dwHighDateTime := FdwHighDateTime;
end;

constructor DB_VARNUMERICWrapper.Create(ARecord: DB_VARNUMERIC);
begin
  inherited Create;
  Fprecision := ARecord.precision;
  Fscale := ARecord.scale;
  Fsign := ARecord.sign;
end;

function DB_VARNUMERICWrapper.ObjToRec: DB_VARNUMERIC;
begin
  result.precision := Fprecision;
  result.scale := Fscale;
  result.sign := Fsign;
end;

constructor DBFAILUREINFOWrapper.Create(ARecord: DBFAILUREINFO);
begin
  inherited Create;
  FHROW := ARecord.HROW;
  FiColumn := ARecord.iColumn;
  Ffailure := ARecord.failure;
end;

function DBFAILUREINFOWrapper.ObjToRec: DBFAILUREINFO;
begin
  result.HROW := FHROW;
  result.iColumn := FiColumn;
  result.failure := Ffailure;
end;

constructor MDAXISINFOWrapper.Create(ARecord: MDAXISINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiAxis := ARecord.iAxis;
  FcDimensions := ARecord.cDimensions;
  FcCoordinates := ARecord.cCoordinates;
end;

function MDAXISINFOWrapper.ObjToRec: MDAXISINFO;
begin
  result.cbSize := FcbSize;
  result.iAxis := FiAxis;
  result.cDimensions := FcDimensions;
  result.cCoordinates := FcCoordinates;
end;

constructor DBPARAMBINDINFOWrapper.Create(ARecord: DBPARAMBINDINFO);
begin
  inherited Create;
  FulParamSize := ARecord.ulParamSize;
  FdwFlags := ARecord.dwFlags;
  FbPrecision := ARecord.bPrecision;
  FbScale := ARecord.bScale;
end;

function DBPARAMBINDINFOWrapper.ObjToRec: DBPARAMBINDINFO;
begin
  result.ulParamSize := FulParamSize;
  result.dwFlags := FdwFlags;
  result.bPrecision := FbPrecision;
  result.bScale := FbScale;
end;

constructor ERRORINFOWrapper.Create(ARecord: ERRORINFO);
begin
  inherited Create;
  FhrError := ARecord.hrError;
  FdwMinor := ARecord.dwMinor;
  Fdispid := ARecord.dispid;
end;

function ERRORINFOWrapper.ObjToRec: ERRORINFO;
begin
  result.hrError := FhrError;
  result.dwMinor := FdwMinor;
  result.dispid := Fdispid;
end;

constructor EXPLICIT_ACCESS_WWrapper.Create(ARecord: EXPLICIT_ACCESS_W);
begin
  inherited Create;
  FgrfAccessPermissions := ARecord.grfAccessPermissions;
  FgrfAccessMode := ARecord.grfAccessMode;
  FgrfInheritance := ARecord.grfInheritance;
end;

function EXPLICIT_ACCESS_WWrapper.ObjToRec: EXPLICIT_ACCESS_W;
begin
  result.grfAccessPermissions := FgrfAccessPermissions;
  result.grfAccessMode := FgrfAccessMode;
  result.grfInheritance := FgrfInheritance;
end;



procedure TatOleDBLibrary.__GetCLSID_OLEDB_ENUMERATOR(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.CLSID_OLEDB_ENUMERATOR)));
  end;
end;

procedure TatOleDBLibrary.__GetCLSID_EXTENDEDERRORINFO(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.CLSID_EXTENDEDERRORINFO)));
  end;
end;

procedure TatOleDBLibrary.__GetCLSID_MSDAVTM(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.CLSID_MSDAVTM)));
  end;
end;

procedure TatOleDBLibrary.__GetCLSID_OLEDB_CONVERSIONLIBRARY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.CLSID_OLEDB_CONVERSIONLIBRARY)));
  end;
end;

procedure TatOleDBLibrary.__GetCLSID_OLEDB_ROWPOSITIONLIBRARY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.CLSID_OLEDB_ROWPOSITIONLIBRARY)));
  end;
end;

procedure TatOleDBLibrary.__GetCLSID_DATALINKS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.CLSID_DATALINKS)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransaction)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransactionOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransactionOptions)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransactionDispenser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransactionDispenser)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransactionOutcomeEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransactionOutcomeEvents)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IAccessor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IAccessor)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetInfo)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetLocate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetLocate)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetResynch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetResynch)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetScroll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetScroll)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetChange)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetUpdate)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetIndex)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IMultipleResults(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IMultipleResults)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IConvertType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IConvertType)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ICommandPrepare(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ICommandPrepare)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ICommandProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ICommandProperties)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ICommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ICommand)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ICommandWithParameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ICommandWithParameters)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ICommandText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ICommandText)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IColumnsRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IColumnsRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IColumnsInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IColumnsInfo)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBCreateCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBCreateCommand)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBCreateSession(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBCreateSession)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ISourcesRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ISourcesRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBProperties)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBInitialize)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBInfo)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBDataSourceAdmin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBDataSourceAdmin)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ISessionProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ISessionProperties)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IIndexDefinition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IIndexDefinition)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITableDefinition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITableDefinition)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IOpenRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IOpenRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IErrorLookup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IErrorLookup)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ISQLErrorInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ISQLErrorInfo)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IGetDataSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IGetDataSource)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransactionLocal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransactionLocal)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransactionJoin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransactionJoin)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITransactionObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITransactionObject)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBAsynchStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBAsynchStatus)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetFind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetFind)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowPosition(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowPosition)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowPositionChange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowPositionChange)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IViewRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IViewRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IViewChapter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IViewChapter)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IViewSort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IViewSort)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IViewFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IViewFilter)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetView)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IMDFind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IMDFind)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IMDRangeRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IMDRangeRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IAlterTable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IAlterTable)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IAlterIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IAlterIndex)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ICommandPersist(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ICommandPersist)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetChapterMember(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetChapterMember)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IRowsetRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IRowsetRefresh)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IParentRowset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IParentRowset)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ITrusteeGroupAdmin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ITrusteeGroupAdmin)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IObjectAccessControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IObjectAccessControl)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_ISecurityInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_ISecurityInfo)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDBPromptInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDBPromptInitialize)));
  end;
end;

procedure TatOleDBLibrary.__GetIID_IDataInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.IID_IDataInitialize)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_TABLES_INFO(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_TABLES_INFO)));
  end;
end;

procedure TatOleDBLibrary.__GetMDGUID_MDX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDGUID_MDX)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_MDX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_MDX)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_CUBES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_CUBES)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_DIMENSIONS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_DIMENSIONS)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_HIERARCHIES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_HIERARCHIES)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_LEVELS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_LEVELS)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_MEASURES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_MEASURES)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_PROPERTIES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_PROPERTIES)));
  end;
end;

procedure TatOleDBLibrary.__GetMDSCHEMA_MEMBERS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.MDSCHEMA_MEMBERS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_TRUSTEE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_TRUSTEE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_TABLE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_TABLE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_COLUMN(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_COLUMN)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_DATABASE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_DATABASE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_PROCEDURE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_PROCEDURE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_VIEW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_VIEW)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_SCHEMA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_SCHEMA)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_DOMAIN(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_DOMAIN)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_COLLATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_COLLATION)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_TRUSTEE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_TRUSTEE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_SCHEMAROWSET(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_SCHEMAROWSET)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_CHARACTERSET(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_CHARACTERSET)));
  end;
end;

procedure TatOleDBLibrary.__GetDBOBJECT_TRANSLATION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBOBJECT_TRANSLATION)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_CHECK_OPTION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_CHECK_OPTION)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_CONSTRAINT_CHECK_DEFERRED(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_CONSTRAINT_CHECK_DEFERRED)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_DROP_CASCADE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_DROP_CASCADE)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_UNIQUE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_UNIQUE)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_ON_COMMIT_PRESERVE_ROWS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_ON_COMMIT_PRESERVE_ROWS)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_PRIMARY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_PRIMARY)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_CLUSTERED(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_CLUSTERED)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_NONCLUSTERED(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_NONCLUSTERED)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_BTREE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_BTREE)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_HASH(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_HASH)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_FILLFACTOR(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_FILLFACTOR)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_INITIALSIZE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_INITIALSIZE)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_DISALLOWNULL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_DISALLOWNULL)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_IGNORENULL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_IGNORENULL)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_IGNOREANYNULL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_IGNOREANYNULL)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_SORTBOOKMARKS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_SORTBOOKMARKS)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_AUTOMATICUPDATE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_AUTOMATICUPDATE)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_PROPERTY_EXPLICITUPDATE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_PROPERTY_EXPLICITUPDATE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_LIKE_SQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_LIKE_SQL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_LIKE_DOS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_LIKE_DOS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_LIKE_OFS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_LIKE_OFS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_LIKE_MAPI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_LIKE_MAPI)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_ASSERTIONS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_ASSERTIONS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_CATALOGS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_CATALOGS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_CHARACTER_SETS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_CHARACTER_SETS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_COLLATIONS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_COLLATIONS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_COLUMNS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_COLUMNS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_CHECK_CONSTRAINTS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_CHECK_CONSTRAINTS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_CONSTRAINT_COLUMN_USAGE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_CONSTRAINT_COLUMN_USAGE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_CONSTRAINT_TABLE_USAGE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_CONSTRAINT_TABLE_USAGE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_KEY_COLUMN_USAGE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_KEY_COLUMN_USAGE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_REFERENTIAL_CONSTRAINTS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_REFERENTIAL_CONSTRAINTS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_TABLE_CONSTRAINTS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_TABLE_CONSTRAINTS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_COLUMN_DOMAIN_USAGE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_COLUMN_DOMAIN_USAGE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_INDEXES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_INDEXES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_COLUMN_PRIVILEGES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_COLUMN_PRIVILEGES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_TABLE_PRIVILEGES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_TABLE_PRIVILEGES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_USAGE_PRIVILEGES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_USAGE_PRIVILEGES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_PROCEDURES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_PROCEDURES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_SCHEMATA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_SCHEMATA)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_SQL_LANGUAGES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_SQL_LANGUAGES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_STATISTICS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_STATISTICS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_TABLES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_TABLES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_TRANSLATIONS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_TRANSLATIONS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_PROVIDER_TYPES(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_PROVIDER_TYPES)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_VIEWS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_VIEWS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_VIEW_COLUMN_USAGE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_VIEW_COLUMN_USAGE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_VIEW_TABLE_USAGE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_VIEW_TABLE_USAGE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_PROCEDURE_PARAMETERS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_PROCEDURE_PARAMETERS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_FOREIGN_KEYS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_FOREIGN_KEYS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_PRIMARY_KEYS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_PRIMARY_KEYS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBSCHEMA_PROCEDURE_COLUMNS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBSCHEMA_PROCEDURE_COLUMNS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOL_SELFCOLUMNS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBCOL_SELFCOLUMNS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOL_SPECIALCOL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBCOL_SPECIALCOL)));
  end;
end;

procedure TatOleDBLibrary.__GetPSGUID_QUERY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.PSGUID_QUERY)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_COLUMN(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_COLUMN)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_DATASOURCE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_DATASOURCE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_DATASOURCEINFO(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_DATASOURCEINFO)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_INDEX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_INDEX)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_DBINIT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_DBINIT)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_ROWSET(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_ROWSET)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_SESSION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_SESSION)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_TABLE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_TABLE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_PROPERTIESINERROR(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_PROPERTIESINERROR)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_VIEW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_VIEW)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_DATASOURCEALL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_DATASOURCEALL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_DATASOURCEINFOALL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_DATASOURCEINFOALL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_DBINITALL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_DBINITALL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_ROWSETALL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_ROWSETALL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBPROPSET_SESSIONALL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBPROPSET_SESSIONALL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_DEFAULT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_DEFAULT)));
  end;
end;

procedure TatOleDBLibrary.__GetDBGUID_SQL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBGUID_SQL)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCIDGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DBCIDGUID)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_NULLGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(OleDB.DB_NULLGUID)));
  end;
end;

procedure TatOleDBLibrary.__GetDB_NULLID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DB_NULLID)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_IDNAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_IDNAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_NAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_NAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_NUMBER(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_NUMBER)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_TYPE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_TYPE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_PRECISION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_PRECISION)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_SCALE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_SCALE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_FLAGS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_FLAGS)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_BASECOLUMNNAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_BASECOLUMNNAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_BASETABLENAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_BASETABLENAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_COLLATINGSEQUENCE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_COLLATINGSEQUENCE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_COMPUTEMODE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_COMPUTEMODE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_DEFAULTVALUE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_DEFAULTVALUE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_DOMAINNAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_DOMAINNAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_HASDEFAULT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_HASDEFAULT)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_ISAUTOINCREMENT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_ISAUTOINCREMENT)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_ISCASESENSITIVE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_ISCASESENSITIVE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_ISSEARCHABLE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_ISSEARCHABLE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_ISUNIQUE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_ISUNIQUE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_BASECATALOGNAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_BASECATALOGNAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_BASESCHEMANAME(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_BASESCHEMANAME)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_GUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_GUID)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_PROPID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_PROPID)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_TYPEINFO(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_TYPEINFO)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_DOMAINCATALOG(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_DOMAINCATALOG)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_DOMAINSCHEMA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_DOMAINSCHEMA)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_DATETIMEPRECISION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_DATETIMEPRECISION)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_NUMERICPRECISIONRADIX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_NUMERICPRECISIONRADIX)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_OCTETLENGTH(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_OCTETLENGTH)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_COLUMNSIZE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_COLUMNSIZE)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_CLSID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_CLSID)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_BASETABLEVERSION(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_BASETABLEVERSION)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_KEYCOLUMN(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_KEYCOLUMN)));
  end;
end;

procedure TatOleDBLibrary.__GetDBCOLUMN_MAYSORT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(DBIDWrapper.Create(OleDB.DBCOLUMN_MAYSORT)));
  end;
end;

procedure TatOleDBLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('CLSID_OLEDB_ENUMERATOR',tkVariant,__GetCLSID_OLEDB_ENUMERATOR,nil,nil,false,0);
    DefineProp('CLSID_EXTENDEDERRORINFO',tkVariant,__GetCLSID_EXTENDEDERRORINFO,nil,nil,false,0);
    DefineProp('CLSID_MSDAVTM',tkVariant,__GetCLSID_MSDAVTM,nil,nil,false,0);
    DefineProp('CLSID_OLEDB_CONVERSIONLIBRARY',tkVariant,__GetCLSID_OLEDB_CONVERSIONLIBRARY,nil,nil,false,0);
    DefineProp('CLSID_OLEDB_ROWPOSITIONLIBRARY',tkVariant,__GetCLSID_OLEDB_ROWPOSITIONLIBRARY,nil,nil,false,0);
    DefineProp('CLSID_DATALINKS',tkVariant,__GetCLSID_DATALINKS,nil,nil,false,0);
    DefineProp('IID_ITransaction',tkVariant,__GetIID_ITransaction,nil,nil,false,0);
    DefineProp('IID_ITransactionOptions',tkVariant,__GetIID_ITransactionOptions,nil,nil,false,0);
    DefineProp('IID_ITransactionDispenser',tkVariant,__GetIID_ITransactionDispenser,nil,nil,false,0);
    DefineProp('IID_ITransactionOutcomeEvents',tkVariant,__GetIID_ITransactionOutcomeEvents,nil,nil,false,0);
    DefineProp('IID_IAccessor',tkVariant,__GetIID_IAccessor,nil,nil,false,0);
    DefineProp('IID_IRowset',tkVariant,__GetIID_IRowset,nil,nil,false,0);
    DefineProp('IID_IRowsetInfo',tkVariant,__GetIID_IRowsetInfo,nil,nil,false,0);
    DefineProp('IID_IRowsetLocate',tkVariant,__GetIID_IRowsetLocate,nil,nil,false,0);
    DefineProp('IID_IRowsetResynch',tkVariant,__GetIID_IRowsetResynch,nil,nil,false,0);
    DefineProp('IID_IRowsetScroll',tkVariant,__GetIID_IRowsetScroll,nil,nil,false,0);
    DefineProp('IID_IRowsetChange',tkVariant,__GetIID_IRowsetChange,nil,nil,false,0);
    DefineProp('IID_IRowsetUpdate',tkVariant,__GetIID_IRowsetUpdate,nil,nil,false,0);
    DefineProp('IID_IRowsetIndex',tkVariant,__GetIID_IRowsetIndex,nil,nil,false,0);
    DefineProp('IID_IMultipleResults',tkVariant,__GetIID_IMultipleResults,nil,nil,false,0);
    DefineProp('IID_IConvertType',tkVariant,__GetIID_IConvertType,nil,nil,false,0);
    DefineProp('IID_ICommandPrepare',tkVariant,__GetIID_ICommandPrepare,nil,nil,false,0);
    DefineProp('IID_ICommandProperties',tkVariant,__GetIID_ICommandProperties,nil,nil,false,0);
    DefineProp('IID_ICommand',tkVariant,__GetIID_ICommand,nil,nil,false,0);
    DefineProp('IID_ICommandWithParameters',tkVariant,__GetIID_ICommandWithParameters,nil,nil,false,0);
    DefineProp('IID_ICommandText',tkVariant,__GetIID_ICommandText,nil,nil,false,0);
    DefineProp('IID_IColumnsRowset',tkVariant,__GetIID_IColumnsRowset,nil,nil,false,0);
    DefineProp('IID_IColumnsInfo',tkVariant,__GetIID_IColumnsInfo,nil,nil,false,0);
    DefineProp('IID_IDBCreateCommand',tkVariant,__GetIID_IDBCreateCommand,nil,nil,false,0);
    DefineProp('IID_IDBCreateSession',tkVariant,__GetIID_IDBCreateSession,nil,nil,false,0);
    DefineProp('IID_ISourcesRowset',tkVariant,__GetIID_ISourcesRowset,nil,nil,false,0);
    DefineProp('IID_IDBProperties',tkVariant,__GetIID_IDBProperties,nil,nil,false,0);
    DefineProp('IID_IDBInitialize',tkVariant,__GetIID_IDBInitialize,nil,nil,false,0);
    DefineProp('IID_IDBInfo',tkVariant,__GetIID_IDBInfo,nil,nil,false,0);
    DefineProp('IID_IDBDataSourceAdmin',tkVariant,__GetIID_IDBDataSourceAdmin,nil,nil,false,0);
    DefineProp('IID_ISessionProperties',tkVariant,__GetIID_ISessionProperties,nil,nil,false,0);
    DefineProp('IID_IIndexDefinition',tkVariant,__GetIID_IIndexDefinition,nil,nil,false,0);
    DefineProp('IID_ITableDefinition',tkVariant,__GetIID_ITableDefinition,nil,nil,false,0);
    DefineProp('IID_IOpenRowset',tkVariant,__GetIID_IOpenRowset,nil,nil,false,0);
    DefineProp('IID_IErrorLookup',tkVariant,__GetIID_IErrorLookup,nil,nil,false,0);
    DefineProp('IID_ISQLErrorInfo',tkVariant,__GetIID_ISQLErrorInfo,nil,nil,false,0);
    DefineProp('IID_IGetDataSource',tkVariant,__GetIID_IGetDataSource,nil,nil,false,0);
    DefineProp('IID_ITransactionLocal',tkVariant,__GetIID_ITransactionLocal,nil,nil,false,0);
    DefineProp('IID_ITransactionJoin',tkVariant,__GetIID_ITransactionJoin,nil,nil,false,0);
    DefineProp('IID_ITransactionObject',tkVariant,__GetIID_ITransactionObject,nil,nil,false,0);
    DefineProp('IID_IDBAsynchStatus',tkVariant,__GetIID_IDBAsynchStatus,nil,nil,false,0);
    DefineProp('IID_IRowsetFind',tkVariant,__GetIID_IRowsetFind,nil,nil,false,0);
    DefineProp('IID_IRowPosition',tkVariant,__GetIID_IRowPosition,nil,nil,false,0);
    DefineProp('IID_IRowPositionChange',tkVariant,__GetIID_IRowPositionChange,nil,nil,false,0);
    DefineProp('IID_IViewRowset',tkVariant,__GetIID_IViewRowset,nil,nil,false,0);
    DefineProp('IID_IViewChapter',tkVariant,__GetIID_IViewChapter,nil,nil,false,0);
    DefineProp('IID_IViewSort',tkVariant,__GetIID_IViewSort,nil,nil,false,0);
    DefineProp('IID_IViewFilter',tkVariant,__GetIID_IViewFilter,nil,nil,false,0);
    DefineProp('IID_IRowsetView',tkVariant,__GetIID_IRowsetView,nil,nil,false,0);
    DefineProp('IID_IMDFind',tkVariant,__GetIID_IMDFind,nil,nil,false,0);
    DefineProp('IID_IMDRangeRowset',tkVariant,__GetIID_IMDRangeRowset,nil,nil,false,0);
    DefineProp('IID_IAlterTable',tkVariant,__GetIID_IAlterTable,nil,nil,false,0);
    DefineProp('IID_IAlterIndex',tkVariant,__GetIID_IAlterIndex,nil,nil,false,0);
    DefineProp('IID_ICommandPersist',tkVariant,__GetIID_ICommandPersist,nil,nil,false,0);
    DefineProp('IID_IRowsetChapterMember',tkVariant,__GetIID_IRowsetChapterMember,nil,nil,false,0);
    DefineProp('IID_IRowsetRefresh',tkVariant,__GetIID_IRowsetRefresh,nil,nil,false,0);
    DefineProp('IID_IParentRowset',tkVariant,__GetIID_IParentRowset,nil,nil,false,0);
    DefineProp('IID_ITrusteeGroupAdmin',tkVariant,__GetIID_ITrusteeGroupAdmin,nil,nil,false,0);
    DefineProp('IID_IObjectAccessControl',tkVariant,__GetIID_IObjectAccessControl,nil,nil,false,0);
    DefineProp('IID_ISecurityInfo',tkVariant,__GetIID_ISecurityInfo,nil,nil,false,0);
    DefineProp('IID_IDBPromptInitialize',tkVariant,__GetIID_IDBPromptInitialize,nil,nil,false,0);
    DefineProp('IID_IDataInitialize',tkVariant,__GetIID_IDataInitialize,nil,nil,false,0);
    DefineProp('DBSCHEMA_TABLES_INFO',tkVariant,__GetDBSCHEMA_TABLES_INFO,nil,nil,false,0);
    DefineProp('MDGUID_MDX',tkVariant,__GetMDGUID_MDX,nil,nil,false,0);
    DefineProp('DBGUID_MDX',tkVariant,__GetDBGUID_MDX,nil,nil,false,0);
    DefineProp('MDSCHEMA_CUBES',tkVariant,__GetMDSCHEMA_CUBES,nil,nil,false,0);
    DefineProp('MDSCHEMA_DIMENSIONS',tkVariant,__GetMDSCHEMA_DIMENSIONS,nil,nil,false,0);
    DefineProp('MDSCHEMA_HIERARCHIES',tkVariant,__GetMDSCHEMA_HIERARCHIES,nil,nil,false,0);
    DefineProp('MDSCHEMA_LEVELS',tkVariant,__GetMDSCHEMA_LEVELS,nil,nil,false,0);
    DefineProp('MDSCHEMA_MEASURES',tkVariant,__GetMDSCHEMA_MEASURES,nil,nil,false,0);
    DefineProp('MDSCHEMA_PROPERTIES',tkVariant,__GetMDSCHEMA_PROPERTIES,nil,nil,false,0);
    DefineProp('MDSCHEMA_MEMBERS',tkVariant,__GetMDSCHEMA_MEMBERS,nil,nil,false,0);
    DefineProp('DBPROPSET_TRUSTEE',tkVariant,__GetDBPROPSET_TRUSTEE,nil,nil,false,0);
    DefineProp('DBOBJECT_TABLE',tkVariant,__GetDBOBJECT_TABLE,nil,nil,false,0);
    DefineProp('DBOBJECT_COLUMN',tkVariant,__GetDBOBJECT_COLUMN,nil,nil,false,0);
    DefineProp('DBOBJECT_DATABASE',tkVariant,__GetDBOBJECT_DATABASE,nil,nil,false,0);
    DefineProp('DBOBJECT_PROCEDURE',tkVariant,__GetDBOBJECT_PROCEDURE,nil,nil,false,0);
    DefineProp('DBOBJECT_VIEW',tkVariant,__GetDBOBJECT_VIEW,nil,nil,false,0);
    DefineProp('DBOBJECT_SCHEMA',tkVariant,__GetDBOBJECT_SCHEMA,nil,nil,false,0);
    DefineProp('DBOBJECT_DOMAIN',tkVariant,__GetDBOBJECT_DOMAIN,nil,nil,false,0);
    DefineProp('DBOBJECT_COLLATION',tkVariant,__GetDBOBJECT_COLLATION,nil,nil,false,0);
    DefineProp('DBOBJECT_TRUSTEE',tkVariant,__GetDBOBJECT_TRUSTEE,nil,nil,false,0);
    DefineProp('DBOBJECT_SCHEMAROWSET',tkVariant,__GetDBOBJECT_SCHEMAROWSET,nil,nil,false,0);
    DefineProp('DBOBJECT_CHARACTERSET',tkVariant,__GetDBOBJECT_CHARACTERSET,nil,nil,false,0);
    DefineProp('DBOBJECT_TRANSLATION',tkVariant,__GetDBOBJECT_TRANSLATION,nil,nil,false,0);
    DefineProp('DB_PROPERTY_CHECK_OPTION',tkVariant,__GetDB_PROPERTY_CHECK_OPTION,nil,nil,false,0);
    DefineProp('DB_PROPERTY_CONSTRAINT_CHECK_DEFERRED',tkVariant,__GetDB_PROPERTY_CONSTRAINT_CHECK_DEFERRED,nil,nil,false,0);
    DefineProp('DB_PROPERTY_DROP_CASCADE',tkVariant,__GetDB_PROPERTY_DROP_CASCADE,nil,nil,false,0);
    DefineProp('DB_PROPERTY_UNIQUE',tkVariant,__GetDB_PROPERTY_UNIQUE,nil,nil,false,0);
    DefineProp('DB_PROPERTY_ON_COMMIT_PRESERVE_ROWS',tkVariant,__GetDB_PROPERTY_ON_COMMIT_PRESERVE_ROWS,nil,nil,false,0);
    DefineProp('DB_PROPERTY_PRIMARY',tkVariant,__GetDB_PROPERTY_PRIMARY,nil,nil,false,0);
    DefineProp('DB_PROPERTY_CLUSTERED',tkVariant,__GetDB_PROPERTY_CLUSTERED,nil,nil,false,0);
    DefineProp('DB_PROPERTY_NONCLUSTERED',tkVariant,__GetDB_PROPERTY_NONCLUSTERED,nil,nil,false,0);
    DefineProp('DB_PROPERTY_BTREE',tkVariant,__GetDB_PROPERTY_BTREE,nil,nil,false,0);
    DefineProp('DB_PROPERTY_HASH',tkVariant,__GetDB_PROPERTY_HASH,nil,nil,false,0);
    DefineProp('DB_PROPERTY_FILLFACTOR',tkVariant,__GetDB_PROPERTY_FILLFACTOR,nil,nil,false,0);
    DefineProp('DB_PROPERTY_INITIALSIZE',tkVariant,__GetDB_PROPERTY_INITIALSIZE,nil,nil,false,0);
    DefineProp('DB_PROPERTY_DISALLOWNULL',tkVariant,__GetDB_PROPERTY_DISALLOWNULL,nil,nil,false,0);
    DefineProp('DB_PROPERTY_IGNORENULL',tkVariant,__GetDB_PROPERTY_IGNORENULL,nil,nil,false,0);
    DefineProp('DB_PROPERTY_IGNOREANYNULL',tkVariant,__GetDB_PROPERTY_IGNOREANYNULL,nil,nil,false,0);
    DefineProp('DB_PROPERTY_SORTBOOKMARKS',tkVariant,__GetDB_PROPERTY_SORTBOOKMARKS,nil,nil,false,0);
    DefineProp('DB_PROPERTY_AUTOMATICUPDATE',tkVariant,__GetDB_PROPERTY_AUTOMATICUPDATE,nil,nil,false,0);
    DefineProp('DB_PROPERTY_EXPLICITUPDATE',tkVariant,__GetDB_PROPERTY_EXPLICITUPDATE,nil,nil,false,0);
    DefineProp('DBGUID_LIKE_SQL',tkVariant,__GetDBGUID_LIKE_SQL,nil,nil,false,0);
    DefineProp('DBGUID_LIKE_DOS',tkVariant,__GetDBGUID_LIKE_DOS,nil,nil,false,0);
    DefineProp('DBGUID_LIKE_OFS',tkVariant,__GetDBGUID_LIKE_OFS,nil,nil,false,0);
    DefineProp('DBGUID_LIKE_MAPI',tkVariant,__GetDBGUID_LIKE_MAPI,nil,nil,false,0);
    DefineProp('DBSCHEMA_ASSERTIONS',tkVariant,__GetDBSCHEMA_ASSERTIONS,nil,nil,false,0);
    DefineProp('DBSCHEMA_CATALOGS',tkVariant,__GetDBSCHEMA_CATALOGS,nil,nil,false,0);
    DefineProp('DBSCHEMA_CHARACTER_SETS',tkVariant,__GetDBSCHEMA_CHARACTER_SETS,nil,nil,false,0);
    DefineProp('DBSCHEMA_COLLATIONS',tkVariant,__GetDBSCHEMA_COLLATIONS,nil,nil,false,0);
    DefineProp('DBSCHEMA_COLUMNS',tkVariant,__GetDBSCHEMA_COLUMNS,nil,nil,false,0);
    DefineProp('DBSCHEMA_CHECK_CONSTRAINTS',tkVariant,__GetDBSCHEMA_CHECK_CONSTRAINTS,nil,nil,false,0);
    DefineProp('DBSCHEMA_CONSTRAINT_COLUMN_USAGE',tkVariant,__GetDBSCHEMA_CONSTRAINT_COLUMN_USAGE,nil,nil,false,0);
    DefineProp('DBSCHEMA_CONSTRAINT_TABLE_USAGE',tkVariant,__GetDBSCHEMA_CONSTRAINT_TABLE_USAGE,nil,nil,false,0);
    DefineProp('DBSCHEMA_KEY_COLUMN_USAGE',tkVariant,__GetDBSCHEMA_KEY_COLUMN_USAGE,nil,nil,false,0);
    DefineProp('DBSCHEMA_REFERENTIAL_CONSTRAINTS',tkVariant,__GetDBSCHEMA_REFERENTIAL_CONSTRAINTS,nil,nil,false,0);
    DefineProp('DBSCHEMA_TABLE_CONSTRAINTS',tkVariant,__GetDBSCHEMA_TABLE_CONSTRAINTS,nil,nil,false,0);
    DefineProp('DBSCHEMA_COLUMN_DOMAIN_USAGE',tkVariant,__GetDBSCHEMA_COLUMN_DOMAIN_USAGE,nil,nil,false,0);
    DefineProp('DBSCHEMA_INDEXES',tkVariant,__GetDBSCHEMA_INDEXES,nil,nil,false,0);
    DefineProp('DBSCHEMA_COLUMN_PRIVILEGES',tkVariant,__GetDBSCHEMA_COLUMN_PRIVILEGES,nil,nil,false,0);
    DefineProp('DBSCHEMA_TABLE_PRIVILEGES',tkVariant,__GetDBSCHEMA_TABLE_PRIVILEGES,nil,nil,false,0);
    DefineProp('DBSCHEMA_USAGE_PRIVILEGES',tkVariant,__GetDBSCHEMA_USAGE_PRIVILEGES,nil,nil,false,0);
    DefineProp('DBSCHEMA_PROCEDURES',tkVariant,__GetDBSCHEMA_PROCEDURES,nil,nil,false,0);
    DefineProp('DBSCHEMA_SCHEMATA',tkVariant,__GetDBSCHEMA_SCHEMATA,nil,nil,false,0);
    DefineProp('DBSCHEMA_SQL_LANGUAGES',tkVariant,__GetDBSCHEMA_SQL_LANGUAGES,nil,nil,false,0);
    DefineProp('DBSCHEMA_STATISTICS',tkVariant,__GetDBSCHEMA_STATISTICS,nil,nil,false,0);
    DefineProp('DBSCHEMA_TABLES',tkVariant,__GetDBSCHEMA_TABLES,nil,nil,false,0);
    DefineProp('DBSCHEMA_TRANSLATIONS',tkVariant,__GetDBSCHEMA_TRANSLATIONS,nil,nil,false,0);
    DefineProp('DBSCHEMA_PROVIDER_TYPES',tkVariant,__GetDBSCHEMA_PROVIDER_TYPES,nil,nil,false,0);
    DefineProp('DBSCHEMA_VIEWS',tkVariant,__GetDBSCHEMA_VIEWS,nil,nil,false,0);
    DefineProp('DBSCHEMA_VIEW_COLUMN_USAGE',tkVariant,__GetDBSCHEMA_VIEW_COLUMN_USAGE,nil,nil,false,0);
    DefineProp('DBSCHEMA_VIEW_TABLE_USAGE',tkVariant,__GetDBSCHEMA_VIEW_TABLE_USAGE,nil,nil,false,0);
    DefineProp('DBSCHEMA_PROCEDURE_PARAMETERS',tkVariant,__GetDBSCHEMA_PROCEDURE_PARAMETERS,nil,nil,false,0);
    DefineProp('DBSCHEMA_FOREIGN_KEYS',tkVariant,__GetDBSCHEMA_FOREIGN_KEYS,nil,nil,false,0);
    DefineProp('DBSCHEMA_PRIMARY_KEYS',tkVariant,__GetDBSCHEMA_PRIMARY_KEYS,nil,nil,false,0);
    DefineProp('DBSCHEMA_PROCEDURE_COLUMNS',tkVariant,__GetDBSCHEMA_PROCEDURE_COLUMNS,nil,nil,false,0);
    DefineProp('DBCOL_SELFCOLUMNS',tkVariant,__GetDBCOL_SELFCOLUMNS,nil,nil,false,0);
    DefineProp('DBCOL_SPECIALCOL',tkVariant,__GetDBCOL_SPECIALCOL,nil,nil,false,0);
    DefineProp('PSGUID_QUERY',tkVariant,__GetPSGUID_QUERY,nil,nil,false,0);
    DefineProp('DBPROPSET_COLUMN',tkVariant,__GetDBPROPSET_COLUMN,nil,nil,false,0);
    DefineProp('DBPROPSET_DATASOURCE',tkVariant,__GetDBPROPSET_DATASOURCE,nil,nil,false,0);
    DefineProp('DBPROPSET_DATASOURCEINFO',tkVariant,__GetDBPROPSET_DATASOURCEINFO,nil,nil,false,0);
    DefineProp('DBPROPSET_INDEX',tkVariant,__GetDBPROPSET_INDEX,nil,nil,false,0);
    DefineProp('DBPROPSET_DBINIT',tkVariant,__GetDBPROPSET_DBINIT,nil,nil,false,0);
    DefineProp('DBPROPSET_ROWSET',tkVariant,__GetDBPROPSET_ROWSET,nil,nil,false,0);
    DefineProp('DBPROPSET_SESSION',tkVariant,__GetDBPROPSET_SESSION,nil,nil,false,0);
    DefineProp('DBPROPSET_TABLE',tkVariant,__GetDBPROPSET_TABLE,nil,nil,false,0);
    DefineProp('DBPROPSET_PROPERTIESINERROR',tkVariant,__GetDBPROPSET_PROPERTIESINERROR,nil,nil,false,0);
    DefineProp('DBPROPSET_VIEW',tkVariant,__GetDBPROPSET_VIEW,nil,nil,false,0);
    DefineProp('DBPROPSET_DATASOURCEALL',tkVariant,__GetDBPROPSET_DATASOURCEALL,nil,nil,false,0);
    DefineProp('DBPROPSET_DATASOURCEINFOALL',tkVariant,__GetDBPROPSET_DATASOURCEINFOALL,nil,nil,false,0);
    DefineProp('DBPROPSET_DBINITALL',tkVariant,__GetDBPROPSET_DBINITALL,nil,nil,false,0);
    DefineProp('DBPROPSET_ROWSETALL',tkVariant,__GetDBPROPSET_ROWSETALL,nil,nil,false,0);
    DefineProp('DBPROPSET_SESSIONALL',tkVariant,__GetDBPROPSET_SESSIONALL,nil,nil,false,0);
    DefineProp('DBGUID_DEFAULT',tkVariant,__GetDBGUID_DEFAULT,nil,nil,false,0);
    DefineProp('DBGUID_SQL',tkVariant,__GetDBGUID_SQL,nil,nil,false,0);
    DefineProp('DBCIDGUID',tkVariant,__GetDBCIDGUID,nil,nil,false,0);
    DefineProp('DB_NULLGUID',tkVariant,__GetDB_NULLGUID,nil,nil,false,0);
    DefineProp('DB_NULLID',tkVariant,__GetDB_NULLID,nil,nil,false,0);
    DefineProp('DBCOLUMN_IDNAME',tkVariant,__GetDBCOLUMN_IDNAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_NAME',tkVariant,__GetDBCOLUMN_NAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_NUMBER',tkVariant,__GetDBCOLUMN_NUMBER,nil,nil,false,0);
    DefineProp('DBCOLUMN_TYPE',tkVariant,__GetDBCOLUMN_TYPE,nil,nil,false,0);
    DefineProp('DBCOLUMN_PRECISION',tkVariant,__GetDBCOLUMN_PRECISION,nil,nil,false,0);
    DefineProp('DBCOLUMN_SCALE',tkVariant,__GetDBCOLUMN_SCALE,nil,nil,false,0);
    DefineProp('DBCOLUMN_FLAGS',tkVariant,__GetDBCOLUMN_FLAGS,nil,nil,false,0);
    DefineProp('DBCOLUMN_BASECOLUMNNAME',tkVariant,__GetDBCOLUMN_BASECOLUMNNAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_BASETABLENAME',tkVariant,__GetDBCOLUMN_BASETABLENAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_COLLATINGSEQUENCE',tkVariant,__GetDBCOLUMN_COLLATINGSEQUENCE,nil,nil,false,0);
    DefineProp('DBCOLUMN_COMPUTEMODE',tkVariant,__GetDBCOLUMN_COMPUTEMODE,nil,nil,false,0);
    DefineProp('DBCOLUMN_DEFAULTVALUE',tkVariant,__GetDBCOLUMN_DEFAULTVALUE,nil,nil,false,0);
    DefineProp('DBCOLUMN_DOMAINNAME',tkVariant,__GetDBCOLUMN_DOMAINNAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_HASDEFAULT',tkVariant,__GetDBCOLUMN_HASDEFAULT,nil,nil,false,0);
    DefineProp('DBCOLUMN_ISAUTOINCREMENT',tkVariant,__GetDBCOLUMN_ISAUTOINCREMENT,nil,nil,false,0);
    DefineProp('DBCOLUMN_ISCASESENSITIVE',tkVariant,__GetDBCOLUMN_ISCASESENSITIVE,nil,nil,false,0);
    DefineProp('DBCOLUMN_ISSEARCHABLE',tkVariant,__GetDBCOLUMN_ISSEARCHABLE,nil,nil,false,0);
    DefineProp('DBCOLUMN_ISUNIQUE',tkVariant,__GetDBCOLUMN_ISUNIQUE,nil,nil,false,0);
    DefineProp('DBCOLUMN_BASECATALOGNAME',tkVariant,__GetDBCOLUMN_BASECATALOGNAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_BASESCHEMANAME',tkVariant,__GetDBCOLUMN_BASESCHEMANAME,nil,nil,false,0);
    DefineProp('DBCOLUMN_GUID',tkVariant,__GetDBCOLUMN_GUID,nil,nil,false,0);
    DefineProp('DBCOLUMN_PROPID',tkVariant,__GetDBCOLUMN_PROPID,nil,nil,false,0);
    DefineProp('DBCOLUMN_TYPEINFO',tkVariant,__GetDBCOLUMN_TYPEINFO,nil,nil,false,0);
    DefineProp('DBCOLUMN_DOMAINCATALOG',tkVariant,__GetDBCOLUMN_DOMAINCATALOG,nil,nil,false,0);
    DefineProp('DBCOLUMN_DOMAINSCHEMA',tkVariant,__GetDBCOLUMN_DOMAINSCHEMA,nil,nil,false,0);
    DefineProp('DBCOLUMN_DATETIMEPRECISION',tkVariant,__GetDBCOLUMN_DATETIMEPRECISION,nil,nil,false,0);
    DefineProp('DBCOLUMN_NUMERICPRECISIONRADIX',tkVariant,__GetDBCOLUMN_NUMERICPRECISIONRADIX,nil,nil,false,0);
    DefineProp('DBCOLUMN_OCTETLENGTH',tkVariant,__GetDBCOLUMN_OCTETLENGTH,nil,nil,false,0);
    DefineProp('DBCOLUMN_COLUMNSIZE',tkVariant,__GetDBCOLUMN_COLUMNSIZE,nil,nil,false,0);
    DefineProp('DBCOLUMN_CLSID',tkVariant,__GetDBCOLUMN_CLSID,nil,nil,false,0);
    DefineProp('DBCOLUMN_BASETABLEVERSION',tkVariant,__GetDBCOLUMN_BASETABLEVERSION,nil,nil,false,0);
    DefineProp('DBCOLUMN_KEYCOLUMN',tkVariant,__GetDBCOLUMN_KEYCOLUMN,nil,nil,false,0);
    DefineProp('DBCOLUMN_MAYSORT',tkVariant,__GetDBCOLUMN_MAYSORT,nil,nil,false,0);
    AddConstant('DBPROPSET_COLUMNALL',DBPROPSET_COLUMNALL);
    AddConstant('DBPROPSET_CONSTRAINTALL',DBPROPSET_CONSTRAINTALL);
    AddConstant('DBPROPSET_INDEXALL',DBPROPSET_INDEXALL);
    AddConstant('DBPROPSET_TABLEALL',DBPROPSET_TABLEALL);
    AddConstant('DBPROPSET_TRUSTEEALL',DBPROPSET_TRUSTEEALL);
    AddConstant('MAXCOLS',MAXCOLS);
    AddConstant('MAXBOUND',MAXBOUND);
    AddConstant('OLEDBVER',OLEDBVER);
    AddConstant('DB_INVALID_HACCESSOR',DB_INVALID_HACCESSOR);
    AddConstant('DB_NULL_HROW',DB_NULL_HROW);
    AddConstant('DB_NULL_HCHAPTER',DB_NULL_HCHAPTER);
    AddConstant('STD_BOOKMARKLENGTH',STD_BOOKMARKLENGTH);
    AddConstant('DB_INVALIDCOLUMN',DB_INVALIDCOLUMN);
    AddConstant('DBPROPVAL_BMK_NUMERIC',DBPROPVAL_BMK_NUMERIC);
    AddConstant('DBPROPVAL_BMK_KEY',DBPROPVAL_BMK_KEY);
    AddConstant('DBPROPVAL_CL_START',DBPROPVAL_CL_START);
    AddConstant('DBPROPVAL_CL_END',DBPROPVAL_CL_END);
    AddConstant('DBPROPVAL_CU_DML_STATEMENTS',DBPROPVAL_CU_DML_STATEMENTS);
    AddConstant('DBPROPVAL_CU_TABLE_DEFINITION',DBPROPVAL_CU_TABLE_DEFINITION);
    AddConstant('DBPROPVAL_CU_INDEX_DEFINITION',DBPROPVAL_CU_INDEX_DEFINITION);
    AddConstant('DBPROPVAL_CU_PRIVILEGE_DEFINITION',DBPROPVAL_CU_PRIVILEGE_DEFINITION);
    AddConstant('DBPROPVAL_CD_NOTNULL',DBPROPVAL_CD_NOTNULL);
    AddConstant('DBPROPVAL_CB_NULL',DBPROPVAL_CB_NULL);
    AddConstant('DBPROPVAL_CB_NON_NULL',DBPROPVAL_CB_NON_NULL);
    AddConstant('DBPROPVAL_FU_NOT_SUPPORTED',DBPROPVAL_FU_NOT_SUPPORTED);
    AddConstant('DBPROPVAL_FU_COLUMN',DBPROPVAL_FU_COLUMN);
    AddConstant('DBPROPVAL_FU_TABLE',DBPROPVAL_FU_TABLE);
    AddConstant('DBPROPVAL_FU_CATALOG',DBPROPVAL_FU_CATALOG);
    AddConstant('DBPROPVAL_GB_NOT_SUPPORTED',DBPROPVAL_GB_NOT_SUPPORTED);
    AddConstant('DBPROPVAL_GB_EQUALS_SELECT',DBPROPVAL_GB_EQUALS_SELECT);
    AddConstant('DBPROPVAL_GB_CONTAINS_SELECT',DBPROPVAL_GB_CONTAINS_SELECT);
    AddConstant('DBPROPVAL_GB_NO_RELATION',DBPROPVAL_GB_NO_RELATION);
    AddConstant('DBPROPVAL_HT_DIFFERENT_CATALOGS',DBPROPVAL_HT_DIFFERENT_CATALOGS);
    AddConstant('DBPROPVAL_HT_DIFFERENT_PROVIDERS',DBPROPVAL_HT_DIFFERENT_PROVIDERS);
    AddConstant('DBPROPVAL_IC_UPPER',DBPROPVAL_IC_UPPER);
    AddConstant('DBPROPVAL_IC_LOWER',DBPROPVAL_IC_LOWER);
    AddConstant('DBPROPVAL_IC_SENSITIVE',DBPROPVAL_IC_SENSITIVE);
    AddConstant('DBPROPVAL_IC_MIXED',DBPROPVAL_IC_MIXED);
    AddConstant('DBPROPVAL_LM_NONE',DBPROPVAL_LM_NONE);
    AddConstant('DBPROPVAL_LM_READ',DBPROPVAL_LM_READ);
    AddConstant('DBPROPVAL_LM_INTENT',DBPROPVAL_LM_INTENT);
    AddConstant('DBPROPVAL_LM_RITE',DBPROPVAL_LM_RITE);
    AddConstant('DBPROPVAL_NP_OKTODO',DBPROPVAL_NP_OKTODO);
    AddConstant('DBPROPVAL_NP_ABOUTTODO',DBPROPVAL_NP_ABOUTTODO);
    AddConstant('DBPROPVAL_NP_SYNCHAFTER',DBPROPVAL_NP_SYNCHAFTER);
    AddConstant('DBPROPVAL_NP_FAILEDTODO',DBPROPVAL_NP_FAILEDTODO);
    AddConstant('DBPROPVAL_NP_DIDEVENT',DBPROPVAL_NP_DIDEVENT);
    AddConstant('DBPROPVAL_NC_END',DBPROPVAL_NC_END);
    AddConstant('DBPROPVAL_NC_HIGH',DBPROPVAL_NC_HIGH);
    AddConstant('DBPROPVAL_NC_LOW',DBPROPVAL_NC_LOW);
    AddConstant('DBPROPVAL_NC_START',DBPROPVAL_NC_START);
    AddConstant('DBPROPVAL_OO_BLOB',DBPROPVAL_OO_BLOB);
    AddConstant('DBPROPVAL_OO_IPERSIST',DBPROPVAL_OO_IPERSIST);
    AddConstant('DBPROPVAL_CB_DELETE',DBPROPVAL_CB_DELETE);
    AddConstant('DBPROPVAL_CB_PRESERVE',DBPROPVAL_CB_PRESERVE);
    AddConstant('DBPROPVAL_SU_DML_STATEMENTS',DBPROPVAL_SU_DML_STATEMENTS);
    AddConstant('DBPROPVAL_SU_TABLE_DEFINITION',DBPROPVAL_SU_TABLE_DEFINITION);
    AddConstant('DBPROPVAL_SU_INDEX_DEFINITION',DBPROPVAL_SU_INDEX_DEFINITION);
    AddConstant('DBPROPVAL_SU_PRIVILEGE_DEFINITION',DBPROPVAL_SU_PRIVILEGE_DEFINITION);
    AddConstant('DBPROPVAL_SQ_CORRELATEDSUBQUERIES',DBPROPVAL_SQ_CORRELATEDSUBQUERIES);
    AddConstant('DBPROPVAL_SQ_COMPARISON',DBPROPVAL_SQ_COMPARISON);
    AddConstant('DBPROPVAL_SQ_EXISTS',DBPROPVAL_SQ_EXISTS);
    AddConstant('DBPROPVAL_SQ_IN',DBPROPVAL_SQ_IN);
    AddConstant('DBPROPVAL_SQ_QUANTIFIED',DBPROPVAL_SQ_QUANTIFIED);
    AddConstant('DBPROPVAL_SS_ISEQUENTIALSTREAM',DBPROPVAL_SS_ISEQUENTIALSTREAM);
    AddConstant('DBPROPVAL_SS_ISTREAM',DBPROPVAL_SS_ISTREAM);
    AddConstant('DBPROPVAL_SS_ISTORAGE',DBPROPVAL_SS_ISTORAGE);
    AddConstant('DBPROPVAL_SS_ILOCKBYTES',DBPROPVAL_SS_ILOCKBYTES);
    AddConstant('DBPROPVAL_TI_CHAOS',DBPROPVAL_TI_CHAOS);
    AddConstant('DBPROPVAL_TI_READUNCOMMITTED',DBPROPVAL_TI_READUNCOMMITTED);
    AddConstant('DBPROPVAL_TI_BROWSE',DBPROPVAL_TI_BROWSE);
    AddConstant('DBPROPVAL_TI_CURSORSTABILITY',DBPROPVAL_TI_CURSORSTABILITY);
    AddConstant('DBPROPVAL_TI_READCOMMITTED',DBPROPVAL_TI_READCOMMITTED);
    AddConstant('DBPROPVAL_TI_REPEATABLEREAD',DBPROPVAL_TI_REPEATABLEREAD);
    AddConstant('DBPROPVAL_TI_SERIALIZABLE',DBPROPVAL_TI_SERIALIZABLE);
    AddConstant('DBPROPVAL_TI_ISOLATED',DBPROPVAL_TI_ISOLATED);
    AddConstant('DBPROPVAL_TR_COMMIT_DC',DBPROPVAL_TR_COMMIT_DC);
    AddConstant('DBPROPVAL_TR_COMMIT',DBPROPVAL_TR_COMMIT);
    AddConstant('DBPROPVAL_TR_COMMIT_NO',DBPROPVAL_TR_COMMIT_NO);
    AddConstant('DBPROPVAL_TR_ABORT_DC',DBPROPVAL_TR_ABORT_DC);
    AddConstant('DBPROPVAL_TR_ABORT',DBPROPVAL_TR_ABORT);
    AddConstant('DBPROPVAL_TR_ABORT_NO',DBPROPVAL_TR_ABORT_NO);
    AddConstant('DBPROPVAL_TR_DONTCARE',DBPROPVAL_TR_DONTCARE);
    AddConstant('DBPROPVAL_TR_BOTH',DBPROPVAL_TR_BOTH);
    AddConstant('DBPROPVAL_TR_NONE',DBPROPVAL_TR_NONE);
    AddConstant('DBPROPVAL_TR_OPTIMISTIC',DBPROPVAL_TR_OPTIMISTIC);
    AddConstant('DBPROPVAL_RT_FREETHREAD',DBPROPVAL_RT_FREETHREAD);
    AddConstant('DBPROPVAL_RT_APTMTTHREAD',DBPROPVAL_RT_APTMTTHREAD);
    AddConstant('DBPROPVAL_RT_SINGLETHREAD',DBPROPVAL_RT_SINGLETHREAD);
    AddConstant('DBPROPVAL_UP_CHANGE',DBPROPVAL_UP_CHANGE);
    AddConstant('DBPROPVAL_UP_DELETE',DBPROPVAL_UP_DELETE);
    AddConstant('DBPROPVAL_UP_INSERT',DBPROPVAL_UP_INSERT);
    AddConstant('DBPROPVAL_SQL_NONE',DBPROPVAL_SQL_NONE);
    AddConstant('DBPROPVAL_SQL_ODBC_MINIMUM',DBPROPVAL_SQL_ODBC_MINIMUM);
    AddConstant('DBPROPVAL_SQL_ODBC_CORE',DBPROPVAL_SQL_ODBC_CORE);
    AddConstant('DBPROPVAL_SQL_ODBC_EXTENDED',DBPROPVAL_SQL_ODBC_EXTENDED);
    AddConstant('DBPROPVAL_SQL_ANSI89_IEF',DBPROPVAL_SQL_ANSI89_IEF);
    AddConstant('DBPROPVAL_SQL_ANSI92_ENTRY',DBPROPVAL_SQL_ANSI92_ENTRY);
    AddConstant('DBPROPVAL_SQL_FIPS_TRANSITIONAL',DBPROPVAL_SQL_FIPS_TRANSITIONAL);
    AddConstant('DBPROPVAL_SQL_ANSI92_INTERMEDIATE',DBPROPVAL_SQL_ANSI92_INTERMEDIATE);
    AddConstant('DBPROPVAL_SQL_ANSI92_FULL',DBPROPVAL_SQL_ANSI92_FULL);
    AddConstant('DBPROPVAL_SQL_ESCAPECLAUSES',DBPROPVAL_SQL_ESCAPECLAUSES);
    AddConstant('DBPROPVAL_IT_BTREE',DBPROPVAL_IT_BTREE);
    AddConstant('DBPROPVAL_IT_HASH',DBPROPVAL_IT_HASH);
    AddConstant('DBPROPVAL_IT_CONTENT',DBPROPVAL_IT_CONTENT);
    AddConstant('DBPROPVAL_IT_OTHER',DBPROPVAL_IT_OTHER);
    AddConstant('DBPROPVAL_IN_DISALLOWNULL',DBPROPVAL_IN_DISALLOWNULL);
    AddConstant('DBPROPVAL_IN_IGNORENULL',DBPROPVAL_IN_IGNORENULL);
    AddConstant('DBPROPVAL_IN_IGNOREANYNULL',DBPROPVAL_IN_IGNOREANYNULL);
    AddConstant('DBPROPVAL_TC_NONE',DBPROPVAL_TC_NONE);
    AddConstant('DBPROPVAL_TC_DML',DBPROPVAL_TC_DML);
    AddConstant('DBPROPVAL_TC_DDL_COMMIT',DBPROPVAL_TC_DDL_COMMIT);
    AddConstant('DBPROPVAL_TC_DDL_IGNORE',DBPROPVAL_TC_DDL_IGNORE);
    AddConstant('DBPROPVAL_TC_ALL',DBPROPVAL_TC_ALL);
    AddConstant('DBPROPVAL_OA_NOTSUPPORTED',DBPROPVAL_OA_NOTSUPPORTED);
    AddConstant('DBPROPVAL_OA_ATEXECUTE',DBPROPVAL_OA_ATEXECUTE);
    AddConstant('DBPROPVAL_OA_ATROWRELEASE',DBPROPVAL_OA_ATROWRELEASE);
    AddConstant('DBPROPVAL_MR_NOTSUPPORTED',DBPROPVAL_MR_NOTSUPPORTED);
    AddConstant('DBPROPVAL_MR_SUPPORTED',DBPROPVAL_MR_SUPPORTED);
    AddConstant('DBPROPVAL_MR_CONCURRENT',DBPROPVAL_MR_CONCURRENT);
    AddConstant('DBPROPVAL_PT_GUID_NAME',DBPROPVAL_PT_GUID_NAME);
    AddConstant('DBPROPVAL_PT_GUID_PROPID',DBPROPVAL_PT_GUID_PROPID);
    AddConstant('DBPROPVAL_PT_NAME',DBPROPVAL_PT_NAME);
    AddConstant('DBPROPVAL_PT_GUID',DBPROPVAL_PT_GUID);
    AddConstant('DBPROPVAL_PT_PROPID',DBPROPVAL_PT_PROPID);
    AddConstant('DBPROPVAL_PT_PGUID_NAME',DBPROPVAL_PT_PGUID_NAME);
    AddConstant('DBPROPVAL_PT_PGUID_PROPID',DBPROPVAL_PT_PGUID_PROPID);
    AddConstant('DBPROPVAL_NT_SINGLEROW',DBPROPVAL_NT_SINGLEROW);
    AddConstant('DBPROPVAL_NT_MULTIPLEROWS',DBPROPVAL_NT_MULTIPLEROWS);
    AddConstant('DBPROPVAL_ASYNCH_INITIALIZE',DBPROPVAL_ASYNCH_INITIALIZE);
    AddConstant('DBPROPVAL_ASYNCH_SEQUENTIALPOPULATION',DBPROPVAL_ASYNCH_SEQUENTIALPOPULATION);
    AddConstant('DBPROPVAL_ASYNCH_RANDOMPOPULATION',DBPROPVAL_ASYNCH_RANDOMPOPULATION);
    AddConstant('DBPROPVAL_OP_EQUAL',DBPROPVAL_OP_EQUAL);
    AddConstant('DBPROPVAL_OP_RELATIVE',DBPROPVAL_OP_RELATIVE);
    AddConstant('DBPROPVAL_OP_STRING',DBPROPVAL_OP_STRING);
    AddConstant('DBPROPVAL_CO_EQUALITY',DBPROPVAL_CO_EQUALITY);
    AddConstant('DBPROPVAL_CO_STRING',DBPROPVAL_CO_STRING);
    AddConstant('DBPROPVAL_CO_CASESENSITIVE',DBPROPVAL_CO_CASESENSITIVE);
    AddConstant('DBPROPVAL_CO_CASEINSENSITIVE',DBPROPVAL_CO_CASEINSENSITIVE);
    AddConstant('DBPROPVAL_CO_CONTAINS',DBPROPVAL_CO_CONTAINS);
    AddConstant('DBPROPVAL_CO_BEGINSWITH',DBPROPVAL_CO_BEGINSWITH);
    AddConstant('DBPROPVAL_ASYNCH_BACKGROUNDPOPULATION',DBPROPVAL_ASYNCH_BACKGROUNDPOPULATION);
    AddConstant('DBPROPVAL_ASYNCH_PREPOPULATE',DBPROPVAL_ASYNCH_PREPOPULATE);
    AddConstant('DBPROPVAL_ASYNCH_POPULATEONDEMAND',DBPROPVAL_ASYNCH_POPULATEONDEMAND);
    AddConstant('DBPROPVAL_LM_SINGLEROW',DBPROPVAL_LM_SINGLEROW);
    AddConstant('DBPROPVAL_SQL_SUBMINIMUM',DBPROPVAL_SQL_SUBMINIMUM);
    AddConstant('DBPROPVAL_DST_TDP',DBPROPVAL_DST_TDP);
    AddConstant('DBPROPVAL_DST_MDP',DBPROPVAL_DST_MDP);
    AddConstant('DBPROPVAL_DST_TDPANDMDP',DBPROPVAL_DST_TDPANDMDP);
    AddConstant('MDPROPVAL_AU_UNSUPPORTED',MDPROPVAL_AU_UNSUPPORTED);
    AddConstant('MDPROPVAL_AU_UNCHANGED',MDPROPVAL_AU_UNCHANGED);
    AddConstant('MDPROPVAL_AU_UNKNOWN',MDPROPVAL_AU_UNKNOWN);
    AddConstant('MDPROPVAL_MF_WITH_CALCMEMBERS',MDPROPVAL_MF_WITH_CALCMEMBERS);
    AddConstant('MDPROPVAL_MF_WITH_NAMEDSETS',MDPROPVAL_MF_WITH_NAMEDSETS);
    AddConstant('MDPROPVAL_MF_CREATE_CALCMEMBERS',MDPROPVAL_MF_CREATE_CALCMEMBERS);
    AddConstant('MDPROPVAL_MF_CREATE_NAMEDSETS',MDPROPVAL_MF_CREATE_NAMEDSETS);
    AddConstant('MDPROPVAL_MF_SCOPE_SESSION',MDPROPVAL_MF_SCOPE_SESSION);
    AddConstant('MDPROPVAL_MF_SCOPE_GLOBAL',MDPROPVAL_MF_SCOPE_GLOBAL);
    AddConstant('MDPROPVAL_MMF_COUSIN',MDPROPVAL_MMF_COUSIN);
    AddConstant('MDPROPVAL_MMF_PARALLELPERIOD',MDPROPVAL_MMF_PARALLELPERIOD);
    AddConstant('MDPROPVAL_MMF_OPENINGPERIOD',MDPROPVAL_MMF_OPENINGPERIOD);
    AddConstant('MDPROPVAL_MMF_CLOSINGPERIOD',MDPROPVAL_MMF_CLOSINGPERIOD);
    AddConstant('MDPROPVAL_MNF_MEDIAN',MDPROPVAL_MNF_MEDIAN);
    AddConstant('MDPROPVAL_MNF_VAR',MDPROPVAL_MNF_VAR);
    AddConstant('MDPROPVAL_MNF_STDDEV',MDPROPVAL_MNF_STDDEV);
    AddConstant('MDPROPVAL_MNF_RANK',MDPROPVAL_MNF_RANK);
    AddConstant('MDPROPVAL_MNF_AGGREGATE',MDPROPVAL_MNF_AGGREGATE);
    AddConstant('MDPROPVAL_MNF_COVARIANCE',MDPROPVAL_MNF_COVARIANCE);
    AddConstant('MDPROPVAL_MNF_CORRELATION',MDPROPVAL_MNF_CORRELATION);
    AddConstant('MDPROPVAL_MNF_LINREGSLOPE',MDPROPVAL_MNF_LINREGSLOPE);
    AddConstant('MDPROPVAL_MNF_LINREGVARIANCE',MDPROPVAL_MNF_LINREGVARIANCE);
    AddConstant('MDPROPVAL_MNF_LINREG2',MDPROPVAL_MNF_LINREG2);
    AddConstant('MDPROPVAL_MNF_LINREGPOINT',MDPROPVAL_MNF_LINREGPOINT);
    AddConstant('MDPROPVAL_MNF_DRILLDOWNLEVEL',MDPROPVAL_MNF_DRILLDOWNLEVEL);
    AddConstant('MDPROPVAL_MNF_DRILLDOWNMEMBERTOP',MDPROPVAL_MNF_DRILLDOWNMEMBERTOP);
    AddConstant('MDPROPVAL_MNF_DRILLDOWNMEMBERBOTTOM',MDPROPVAL_MNF_DRILLDOWNMEMBERBOTTOM);
    AddConstant('MDPROPVAL_MNF_DRILLDOWNLEVELTOP',MDPROPVAL_MNF_DRILLDOWNLEVELTOP);
    AddConstant('MDPROPVAL_MNF_DRILLDOWNLEVELBOTTOM',MDPROPVAL_MNF_DRILLDOWNLEVELBOTTOM);
    AddConstant('MDPROPVAL_MNF_DRILLUPMEMBER',MDPROPVAL_MNF_DRILLUPMEMBER);
    AddConstant('MDPROPVAL_MNF_DRILLUPLEVEL',MDPROPVAL_MNF_DRILLUPLEVEL);
    AddConstant('MDPROPVAL_MSF_TOPPERCENT',MDPROPVAL_MSF_TOPPERCENT);
    AddConstant('MDPROPVAL_MSF_BOTTOMPERCENT',MDPROPVAL_MSF_BOTTOMPERCENT);
    AddConstant('MDPROPVAL_MSF_TOPSUM',MDPROPVAL_MSF_TOPSUM);
    AddConstant('MDPROPVAL_MSF_BOTTOMSUM',MDPROPVAL_MSF_BOTTOMSUM);
    AddConstant('MDPROPVAL_MSF_PERIODSTODATE',MDPROPVAL_MSF_PERIODSTODATE);
    AddConstant('MDPROPVAL_MSF_LASTPERIODS',MDPROPVAL_MSF_LASTPERIODS);
    AddConstant('MDPROPVAL_MSF_YTD',MDPROPVAL_MSF_YTD);
    AddConstant('MDPROPVAL_MSF_QTD',MDPROPVAL_MSF_QTD);
    AddConstant('MDPROPVAL_MSF_MTD',MDPROPVAL_MSF_MTD);
    AddConstant('MDPROPVAL_MSF_WTD',MDPROPVAL_MSF_WTD);
    AddConstant('MDPROPVAL_MSF_DRILLDOWNMEMBBER',MDPROPVAL_MSF_DRILLDOWNMEMBBER);
    AddConstant('MDPROPVAL_MSF_DRILLDOWNLEVEL',MDPROPVAL_MSF_DRILLDOWNLEVEL);
    AddConstant('MDPROPVAL_MSF_DRILLDOWNMEMBERTOP',MDPROPVAL_MSF_DRILLDOWNMEMBERTOP);
    AddConstant('MDPROPVAL_MSF_DRILLDOWNMEMBERBOTTOM',MDPROPVAL_MSF_DRILLDOWNMEMBERBOTTOM);
    AddConstant('MDPROPVAL_MSF_DRILLDOWNLEVELTOP',MDPROPVAL_MSF_DRILLDOWNLEVELTOP);
    AddConstant('MDPROPVAL_MSF_DRILLDOWNLEVELBOTTOM',MDPROPVAL_MSF_DRILLDOWNLEVELBOTTOM);
    AddConstant('MDPROPVAL_MSF_DRILLUPMEMBER',MDPROPVAL_MSF_DRILLUPMEMBER);
    AddConstant('MDPROPVAL_MSF_DRILLUPLEVEL',MDPROPVAL_MSF_DRILLUPLEVEL);
    AddConstant('MDPROPVAL_MSF_TOGGLEDRILLSTATE',MDPROPVAL_MSF_TOGGLEDRILLSTATE);
    AddConstant('MDPROPVAL_MD_SELF',MDPROPVAL_MD_SELF);
    AddConstant('MDPROPVAL_MD_BEFORE',MDPROPVAL_MD_BEFORE);
    AddConstant('MDPROPVAL_MD_AFTER',MDPROPVAL_MD_AFTER);
    AddConstant('MDPROPVAL_MSC_LESSTHAN',MDPROPVAL_MSC_LESSTHAN);
    AddConstant('MDPROPVAL_MSC_GREATERTHAN',MDPROPVAL_MSC_GREATERTHAN);
    AddConstant('MDPROPVAL_MSC_LESSTHANEQUAL',MDPROPVAL_MSC_LESSTHANEQUAL);
    AddConstant('MDPROPVAL_MSC_GREATERTHANEQUAL',MDPROPVAL_MSC_GREATERTHANEQUAL);
    AddConstant('MDPROPVAL_MC_SINGLECASE',MDPROPVAL_MC_SINGLECASE);
    AddConstant('MDPROPVAL_MC_SEARCHEDCASE',MDPROPVAL_MC_SEARCHEDCASE);
    AddConstant('MDPROPVAL_MOQ_OUTERREFERENCE',MDPROPVAL_MOQ_OUTERREFERENCE);
    AddConstant('MDPROPVAL_MOQ_DATASOURCE_CUBE',MDPROPVAL_MOQ_DATASOURCE_CUBE);
    AddConstant('MDPROPVAL_MOQ_CATALOG_CUBE',MDPROPVAL_MOQ_CATALOG_CUBE);
    AddConstant('MDPROPVAL_MOQ_SCHEMA_CUBE',MDPROPVAL_MOQ_SCHEMA_CUBE);
    AddConstant('MDPROPVAL_MOQ_CUBE_DIM',MDPROPVAL_MOQ_CUBE_DIM);
    AddConstant('MDPROPVAL_MOQ_DIM_HIER',MDPROPVAL_MOQ_DIM_HIER);
    AddConstant('MDPROPVAL_MOQ_DIMHIER_LEVEL',MDPROPVAL_MOQ_DIMHIER_LEVEL);
    AddConstant('MDPROPVAL_MOQ_LEVEL_MEMBER',MDPROPVAL_MOQ_LEVEL_MEMBER);
    AddConstant('MDPROPVAL_MOQ_MEMBER_MEMBER',MDPROPVAL_MOQ_MEMBER_MEMBER);
    AddConstant('MDPROPVAL_FS_FULL_SUPPORT',MDPROPVAL_FS_FULL_SUPPORT);
    AddConstant('MDPROPVAL_FS_GENERATED_COLUMN',MDPROPVAL_FS_GENERATED_COLUMN);
    AddConstant('MDPROPVAL_FS_GENERATED_DIMENSION',MDPROPVAL_FS_GENERATED_DIMENSION);
    AddConstant('MDPROPVAL_FS_NO_SUPPORT',MDPROPVAL_FS_NO_SUPPORT);
    AddConstant('MDPROPVAL_NL_NAMEDLEVELS',MDPROPVAL_NL_NAMEDLEVELS);
    AddConstant('MDPROPVAL_NL_NUMBEREDLEVELS',MDPROPVAL_NL_NUMBEREDLEVELS);
    AddConstant('MDPROPVAL_MJC_SINGLECUBE',MDPROPVAL_MJC_SINGLECUBE);
    AddConstant('MDPROPVAL_MJC_MULTICUBES',MDPROPVAL_MJC_MULTICUBES);
    AddConstant('MDPROPVAL_MJC_IMPLICITCUBE',MDPROPVAL_MJC_IMPLICITCUBE);
    AddConstant('MDPROPVAL_RR_NORANGEROWSET',MDPROPVAL_RR_NORANGEROWSET);
    AddConstant('MDPROPVAL_RR_READONLY',MDPROPVAL_RR_READONLY);
    AddConstant('MDPROPVAL_RR_UPDATE',MDPROPVAL_RR_UPDATE);
    AddConstant('MDPROPVAL_MS_MULTIPLETUPLES',MDPROPVAL_MS_MULTIPLETUPLES);
    AddConstant('MDPROPVAL_MS_SINGLETUPLE',MDPROPVAL_MS_SINGLETUPLE);
    AddConstant('DBPROPVAL_AO_SEQUENTIAL',DBPROPVAL_AO_SEQUENTIAL);
    AddConstant('DBPROPVAL_AO_SEQUENTIALSTORAGEOBJECTS',DBPROPVAL_AO_SEQUENTIALSTORAGEOBJECTS);
    AddConstant('DBPROPVAL_AO_RANDOM',DBPROPVAL_AO_RANDOM);
    AddConstant('DBPROPVAL_BD_ROWSET',DBPROPVAL_BD_ROWSET);
    AddConstant('DBPROPVAL_BD_INTRANSACTION',DBPROPVAL_BD_INTRANSACTION);
    AddConstant('DBPROPVAL_BD_XTRANSACTION',DBPROPVAL_BD_XTRANSACTION);
    AddConstant('DBPROPVAL_BD_REORGANIZATION',DBPROPVAL_BD_REORGANIZATION);
    AddConstant('BMK_DURABILITY_ROWSET',BMK_DURABILITY_ROWSET);
    AddConstant('BMK_DURABILITY_INTRANSACTION',BMK_DURABILITY_INTRANSACTION);
    AddConstant('BMK_DURABILITY_XTRANSACTION',BMK_DURABILITY_XTRANSACTION);
    AddConstant('BMK_DURABILITY_REORGANIZATION',BMK_DURABILITY_REORGANIZATION);
    AddConstant('DBPROPVAL_BO_NOLOG',DBPROPVAL_BO_NOLOG);
    AddConstant('DBPROPVAL_BO_NOINDEXUPDATE',DBPROPVAL_BO_NOINDEXUPDATE);
    AddConstant('DBPROPVAL_BO_REFINTEGRITY',DBPROPVAL_BO_REFINTEGRITY);
    AddConstant('DBPROPVAL_STGM_READ',DBPROPVAL_STGM_READ);
    AddConstant('DBPROPVAL_STGM_WRITE',DBPROPVAL_STGM_WRITE);
    AddConstant('DBPROPVAL_STGM_READWRITE',DBPROPVAL_STGM_READWRITE);
    AddConstant('DBPROPVAL_STGM_SHARE_DENY_NONE',DBPROPVAL_STGM_SHARE_DENY_NONE);
    AddConstant('DBPROPVAL_STGM_SHARE_DENY_READ',DBPROPVAL_STGM_SHARE_DENY_READ);
    AddConstant('DBPROPVAL_STGM_SHARE_DENY_WRITE',DBPROPVAL_STGM_SHARE_DENY_WRITE);
    AddConstant('DBPROPVAL_STGM_SHARE_EXCLUSIVE',DBPROPVAL_STGM_SHARE_EXCLUSIVE);
    AddConstant('DBPROPVAL_STGM_DIRECT',DBPROPVAL_STGM_DIRECT);
    AddConstant('DBPROPVAL_STGM_TRANSACTED',DBPROPVAL_STGM_TRANSACTED);
    AddConstant('DBPROPVAL_STGM_CREATE',DBPROPVAL_STGM_CREATE);
    AddConstant('DBPROPVAL_STGM_CONVERT',DBPROPVAL_STGM_CONVERT);
    AddConstant('DBPROPVAL_STGM_FAILIFTHERE',DBPROPVAL_STGM_FAILIFTHERE);
    AddConstant('DBPROPVAL_STGM_PRIORITY',DBPROPVAL_STGM_PRIORITY);
    AddConstant('DBPROPVAL_STGM_DELETEONRELEASE',DBPROPVAL_STGM_DELETEONRELEASE);
    AddConstant('DBPROPVAL_GB_COLLATE',DBPROPVAL_GB_COLLATE);
    AddConstant('DBPROPVAL_CS_UNINITIALIZED',DBPROPVAL_CS_UNINITIALIZED);
    AddConstant('DBPROPVAL_CS_INITIALIZED',DBPROPVAL_CS_INITIALIZED);
    AddConstant('DBPROPVAL_CS_COMMUNICATIONFAILURE',DBPROPVAL_CS_COMMUNICATIONFAILURE);
    AddConstant('DBPROPVAL_RD_RESETALL',DBPROPVAL_RD_RESETALL);
    AddConstant('DBPROPVAL_OS_RESOURCEPOOLING',DBPROPVAL_OS_RESOURCEPOOLING);
    AddConstant('DBPROPVAL_OS_TXNENLISTMENT',DBPROPVAL_OS_TXNENLISTMENT);
    AddConstant('DBPROPVAL_OS_CLIENTCURSOR',DBPROPVAL_OS_CLIENTCURSOR);
    AddConstant('DBPROPVAL_OS_ENABLEALL',DBPROPVAL_OS_ENABLEALL);
    AddConstant('DBPROPVAL_BI_CROSSROWSET',DBPROPVAL_BI_CROSSROWSET);
    AddConstant('DB_IMP_LEVEL_ANONYMOUS',DB_IMP_LEVEL_ANONYMOUS);
    AddConstant('DB_IMP_LEVEL_IDENTIFY',DB_IMP_LEVEL_IDENTIFY);
    AddConstant('DB_IMP_LEVEL_IMPERSONATE',DB_IMP_LEVEL_IMPERSONATE);
    AddConstant('DB_IMP_LEVEL_DELEGATE',DB_IMP_LEVEL_DELEGATE);
    AddConstant('DBPROMPT_PROMPT',DBPROMPT_PROMPT);
    AddConstant('DBPROMPT_COMPLETE',DBPROMPT_COMPLETE);
    AddConstant('DBPROMPT_COMPLETEREQUIRED',DBPROMPT_COMPLETEREQUIRED);
    AddConstant('DBPROMPT_NOPROMPT',DBPROMPT_NOPROMPT);
    AddConstant('DB_PROT_LEVEL_NONE',DB_PROT_LEVEL_NONE);
    AddConstant('DB_PROT_LEVEL_CONNECT',DB_PROT_LEVEL_CONNECT);
    AddConstant('DB_PROT_LEVEL_CALL',DB_PROT_LEVEL_CALL);
    AddConstant('DB_PROT_LEVEL_PKT',DB_PROT_LEVEL_PKT);
    AddConstant('DB_PROT_LEVEL_PKT_INTEGRITY',DB_PROT_LEVEL_PKT_INTEGRITY);
    AddConstant('DB_PROT_LEVEL_PKT_PRIVACY',DB_PROT_LEVEL_PKT_PRIVACY);
    AddConstant('DB_MODE_READ',DB_MODE_READ);
    AddConstant('DB_MODE_WRITE',DB_MODE_WRITE);
    AddConstant('DB_MODE_READWRITE',DB_MODE_READWRITE);
    AddConstant('DB_MODE_SHARE_DENY_READ',DB_MODE_SHARE_DENY_READ);
    AddConstant('DB_MODE_SHARE_DENY_WRITE',DB_MODE_SHARE_DENY_WRITE);
    AddConstant('DB_MODE_SHARE_EXCLUSIVE',DB_MODE_SHARE_EXCLUSIVE);
    AddConstant('DB_MODE_SHARE_DENY_NONE',DB_MODE_SHARE_DENY_NONE);
    AddConstant('DBCOMPUTEMODE_COMPUTED',DBCOMPUTEMODE_COMPUTED);
    AddConstant('DBCOMPUTEMODE_DYNAMIC',DBCOMPUTEMODE_DYNAMIC);
    AddConstant('DBCOMPUTEMODE_NOTCOMPUTED',DBCOMPUTEMODE_NOTCOMPUTED);
    AddConstant('DBPROPVAL_DF_INITIALLY_DEFERRED',DBPROPVAL_DF_INITIALLY_DEFERRED);
    AddConstant('DBPROPVAL_DF_INITIALLY_IMMEDIATE',DBPROPVAL_DF_INITIALLY_IMMEDIATE);
    AddConstant('DBPROPVAL_DF_NOT_DEFERRABLE',DBPROPVAL_DF_NOT_DEFERRABLE);
    AddConstant('DBPARAMTYPE_INPUT',DBPARAMTYPE_INPUT);
    AddConstant('DBPARAMTYPE_INPUTOUTPUT',DBPARAMTYPE_INPUTOUTPUT);
    AddConstant('DBPARAMTYPE_OUTPUT',DBPARAMTYPE_OUTPUT);
    AddConstant('DBPARAMTYPE_RETURNVALUE',DBPARAMTYPE_RETURNVALUE);
    AddConstant('DB_PT_UNKNOWN',DB_PT_UNKNOWN);
    AddConstant('DB_PT_PROCEDURE',DB_PT_PROCEDURE);
    AddConstant('DB_PT_FUNCTION',DB_PT_FUNCTION);
    AddConstant('DB_REMOTE',DB_REMOTE);
    AddConstant('DB_LOCAL_SHARED',DB_LOCAL_SHARED);
    AddConstant('DB_LOCAL_EXCLUSIVE',DB_LOCAL_EXCLUSIVE);
    AddConstant('DB_COLLATION_ASC',DB_COLLATION_ASC);
    AddConstant('DB_COLLATION_DESC',DB_COLLATION_DESC);
    AddConstant('DB_UNSEARCHABLE',DB_UNSEARCHABLE);
    AddConstant('DB_LIKE_ONLY',DB_LIKE_ONLY);
    AddConstant('DB_ALL_EXCEPT_LIKE',DB_ALL_EXCEPT_LIKE);
    AddConstant('DB_SEARCHABLE',DB_SEARCHABLE);
    AddConstant('MDTREEOP_CHILDREN',MDTREEOP_CHILDREN);
    AddConstant('MDTREEOP_SIBLINGS',MDTREEOP_SIBLINGS);
    AddConstant('MDTREEOP_PARENT',MDTREEOP_PARENT);
    AddConstant('MDTREEOP_SELF',MDTREEOP_SELF);
    AddConstant('MDTREEOP_DESCENDANTS',MDTREEOP_DESCENDANTS);
    AddConstant('MDTREEOP_ANCESTORS',MDTREEOP_ANCESTORS);
    AddConstant('MD_DIMTYPE_UNKNOWN',MD_DIMTYPE_UNKNOWN);
    AddConstant('MD_DIMTYPE_TIME',MD_DIMTYPE_TIME);
    AddConstant('MD_DIMTYPE_MEASURE',MD_DIMTYPE_MEASURE);
    AddConstant('MD_DIMTYPE_OTHER',MD_DIMTYPE_OTHER);
    AddConstant('MDLEVEL_TYPE_UNKNOWN',MDLEVEL_TYPE_UNKNOWN);
    AddConstant('MDLEVEL_TYPE_REGULAR',MDLEVEL_TYPE_REGULAR);
    AddConstant('MDLEVEL_TYPE_ALL',MDLEVEL_TYPE_ALL);
    AddConstant('MDLEVEL_TYPE_CALCULATED',MDLEVEL_TYPE_CALCULATED);
    AddConstant('MDLEVEL_TYPE_TIME',MDLEVEL_TYPE_TIME);
    AddConstant('MDLEVEL_TYPE_RESERVED1',MDLEVEL_TYPE_RESERVED1);
    AddConstant('MDLEVEL_TYPE_TIME_YEARS',MDLEVEL_TYPE_TIME_YEARS);
    AddConstant('MDLEVEL_TYPE_TIME_HALF_YEAR',MDLEVEL_TYPE_TIME_HALF_YEAR);
    AddConstant('MDLEVEL_TYPE_TIME_QUARTERS',MDLEVEL_TYPE_TIME_QUARTERS);
    AddConstant('MDLEVEL_TYPE_TIME_MONTHS',MDLEVEL_TYPE_TIME_MONTHS);
    AddConstant('MDLEVEL_TYPE_TIME_WEEKS',MDLEVEL_TYPE_TIME_WEEKS);
    AddConstant('MDLEVEL_TYPE_TIME_DAYS',MDLEVEL_TYPE_TIME_DAYS);
    AddConstant('MDLEVEL_TYPE_TIME_HOURS',MDLEVEL_TYPE_TIME_HOURS);
    AddConstant('MDLEVEL_TYPE_TIME_MINUTES',MDLEVEL_TYPE_TIME_MINUTES);
    AddConstant('MDLEVEL_TYPE_TIME_SECONDS',MDLEVEL_TYPE_TIME_SECONDS);
    AddConstant('MDLEVEL_TYPE_TIME_UNDEFINED',MDLEVEL_TYPE_TIME_UNDEFINED);
    AddConstant('MDMEASURE_AGGR_UNKNOWN',MDMEASURE_AGGR_UNKNOWN);
    AddConstant('MDMEASURE_AGGR_SUM',MDMEASURE_AGGR_SUM);
    AddConstant('MDMEASURE_AGGR_COUNT',MDMEASURE_AGGR_COUNT);
    AddConstant('MDMEASURE_AGGR_MIN',MDMEASURE_AGGR_MIN);
    AddConstant('MDMEASURE_AGGR_MAX',MDMEASURE_AGGR_MAX);
    AddConstant('MDMEASURE_AGGR_AVG',MDMEASURE_AGGR_AVG);
    AddConstant('MDMEASURE_AGGR_VAR',MDMEASURE_AGGR_VAR);
    AddConstant('MDMEASURE_AGGR_STD',MDMEASURE_AGGR_STD);
    AddConstant('MDMEASURE_AGGR_CALCULATED',MDMEASURE_AGGR_CALCULATED);
    AddConstant('MDPROP_MEMBER',MDPROP_MEMBER);
    AddConstant('MDPROP_CELL',MDPROP_CELL);
    AddConstant('MDMEMBER_TYPE_UNKNOWN',MDMEMBER_TYPE_UNKNOWN);
    AddConstant('MDMEMBER_TYPE_REGULAR',MDMEMBER_TYPE_REGULAR);
    AddConstant('MDMEMBER_TYPE_ALL',MDMEMBER_TYPE_ALL);
    AddConstant('MDMEMBER_TYPE_MEASURE',MDMEMBER_TYPE_MEASURE);
    AddConstant('MDMEMBER_TYPE_FORMULA',MDMEMBER_TYPE_FORMULA);
    AddConstant('MDMEMBER_TYPE_RESERVE1',MDMEMBER_TYPE_RESERVE1);
    AddConstant('MDMEMBER_TYPE_RESERVE2',MDMEMBER_TYPE_RESERVE2);
    AddConstant('MDMEMBER_TYPE_RESERVE3',MDMEMBER_TYPE_RESERVE3);
    AddConstant('MDMEMBER_TYPE_RESERVE4',MDMEMBER_TYPE_RESERVE4);
    AddConstant('MDDISPINFO_DRILLED_DOWN',MDDISPINFO_DRILLED_DOWN);
    AddConstant('MDDISPINFO_PARENT_SAME_AS_PREV',MDDISPINFO_PARENT_SAME_AS_PREV);
    AddConstant('DB_COUNTUNAVAILABLE',DB_COUNTUNAVAILABLE);
    AddConstant('MDFF_BOLD',MDFF_BOLD);
    AddConstant('MDFF_ITALIC',MDFF_ITALIC);
    AddConstant('MDFF_UNDERLINE',MDFF_UNDERLINE);
    AddConstant('MDFF_STRIKEOUT',MDFF_STRIKEOUT);
    AddConstant('MDAXIS_COLUMNS',MDAXIS_COLUMNS);
    AddConstant('MDAXIS_ROWS',MDAXIS_ROWS);
    AddConstant('MDAXIS_PAGES',MDAXIS_PAGES);
    AddConstant('MDAXIS_SECTIONS',MDAXIS_SECTIONS);
    AddConstant('MDAXIS_CHAPTERS',MDAXIS_CHAPTERS);
    AddConstant('MDAXIS_SLICERS',MDAXIS_SLICERS);
    AddConstant('GENERATE_METHOD_EXACT',GENERATE_METHOD_EXACT);
    AddConstant('GENERATE_METHOD_PREFIX',GENERATE_METHOD_PREFIX);
    AddConstant('GENERATE_METHOD_INFLECT',GENERATE_METHOD_INFLECT);
    AddConstant('PROPID_QUERY_RANKVECTOR',PROPID_QUERY_RANKVECTOR);
    AddConstant('PROPID_QUERY_RANK',PROPID_QUERY_RANK);
    AddConstant('PROPID_QUERY_HITCOUNT',PROPID_QUERY_HITCOUNT);
    AddConstant('PROPID_QUERY_ALL',PROPID_QUERY_ALL);
    AddConstant('PROPID_STG_CONTENTS',PROPID_STG_CONTENTS);
    AddConstant('VECTOR_RANK_MIN',VECTOR_RANK_MIN);
    AddConstant('VECTOR_RANK_MAX',VECTOR_RANK_MAX);
    AddConstant('VECTOR_RANK_INNER',VECTOR_RANK_INNER);
    AddConstant('VECTOR_RANK_DICE',VECTOR_RANK_DICE);
    AddConstant('VECTOR_RANK_JACCARD',VECTOR_RANK_JACCARD);
    AddConstant('DBSETFUNC_NONE',DBSETFUNC_NONE);
    AddConstant('DBSETFUNC_ALL',DBSETFUNC_ALL);
    AddConstant('DBSETFUNC_DISTINCT',DBSETFUNC_DISTINCT);
    AddConstant('PROXIMITY_UNIT_WORD',PROXIMITY_UNIT_WORD);
    AddConstant('PROXIMITY_UNIT_SENTENCE',PROXIMITY_UNIT_SENTENCE);
    AddConstant('PROXIMITY_UNIT_PARAGRAPH',PROXIMITY_UNIT_PARAGRAPH);
    AddConstant('PROXIMITY_UNIT_CHAPTER',PROXIMITY_UNIT_CHAPTER);
    AddConstant('CRESTRICTIONS_DBSCHEMA_ASSERTIONS',CRESTRICTIONS_DBSCHEMA_ASSERTIONS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_CATALOGS',CRESTRICTIONS_DBSCHEMA_CATALOGS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_CHARACTER_SETS',CRESTRICTIONS_DBSCHEMA_CHARACTER_SETS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_COLLATIONS',CRESTRICTIONS_DBSCHEMA_COLLATIONS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_COLUMNS',CRESTRICTIONS_DBSCHEMA_COLUMNS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_CHECK_CONSTRAINTS',CRESTRICTIONS_DBSCHEMA_CHECK_CONSTRAINTS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_CONSTRAINT_COLUMN_USAGE',CRESTRICTIONS_DBSCHEMA_CONSTRAINT_COLUMN_USAGE);
    AddConstant('CRESTRICTIONS_DBSCHEMA_CONSTRAINT_TABLE_USAGE',CRESTRICTIONS_DBSCHEMA_CONSTRAINT_TABLE_USAGE);
    AddConstant('CRESTRICTIONS_DBSCHEMA_KEY_COLUMN_USAGE',CRESTRICTIONS_DBSCHEMA_KEY_COLUMN_USAGE);
    AddConstant('CRESTRICTIONS_DBSCHEMA_REFERENTIAL_CONSTRAINTS',CRESTRICTIONS_DBSCHEMA_REFERENTIAL_CONSTRAINTS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_TABLE_CONSTRAINTS',CRESTRICTIONS_DBSCHEMA_TABLE_CONSTRAINTS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_COLUMN_DOMAIN_USAGE',CRESTRICTIONS_DBSCHEMA_COLUMN_DOMAIN_USAGE);
    AddConstant('CRESTRICTIONS_DBSCHEMA_INDEXES',CRESTRICTIONS_DBSCHEMA_INDEXES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_OBJECT_ACTIONS',CRESTRICTIONS_DBSCHEMA_OBJECT_ACTIONS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_OBJECTS',CRESTRICTIONS_DBSCHEMA_OBJECTS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_COLUMN_PRIVILEGES',CRESTRICTIONS_DBSCHEMA_COLUMN_PRIVILEGES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_TABLE_PRIVILEGES',CRESTRICTIONS_DBSCHEMA_TABLE_PRIVILEGES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_USAGE_PRIVILEGES',CRESTRICTIONS_DBSCHEMA_USAGE_PRIVILEGES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_PROCEDURES',CRESTRICTIONS_DBSCHEMA_PROCEDURES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_SCHEMATA',CRESTRICTIONS_DBSCHEMA_SCHEMATA);
    AddConstant('CRESTRICTIONS_DBSCHEMA_SQL_LANGUAGES',CRESTRICTIONS_DBSCHEMA_SQL_LANGUAGES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_STATISTICS',CRESTRICTIONS_DBSCHEMA_STATISTICS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_TABLES',CRESTRICTIONS_DBSCHEMA_TABLES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_TRANSLATIONS',CRESTRICTIONS_DBSCHEMA_TRANSLATIONS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_PROVIDER_TYPES',CRESTRICTIONS_DBSCHEMA_PROVIDER_TYPES);
    AddConstant('CRESTRICTIONS_DBSCHEMA_VIEWS',CRESTRICTIONS_DBSCHEMA_VIEWS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_VIEW_COLUMN_USAGE',CRESTRICTIONS_DBSCHEMA_VIEW_COLUMN_USAGE);
    AddConstant('CRESTRICTIONS_DBSCHEMA_VIEW_TABLE_USAGE',CRESTRICTIONS_DBSCHEMA_VIEW_TABLE_USAGE);
    AddConstant('CRESTRICTIONS_DBSCHEMA_PROCEDURE_PARAMETERS',CRESTRICTIONS_DBSCHEMA_PROCEDURE_PARAMETERS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_FOREIGN_KEYS',CRESTRICTIONS_DBSCHEMA_FOREIGN_KEYS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_PRIMARY_KEYS',CRESTRICTIONS_DBSCHEMA_PRIMARY_KEYS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_PROCEDURE_COLUMNS',CRESTRICTIONS_DBSCHEMA_PROCEDURE_COLUMNS);
    AddConstant('CRESTRICTIONS_DBSCHEMA_TABLES_INFO',CRESTRICTIONS_DBSCHEMA_TABLES_INFO);
    AddConstant('CRESTRICTIONS_MDSCHEMA_CUBES',CRESTRICTIONS_MDSCHEMA_CUBES);
    AddConstant('CRESTRICTIONS_MDSCHEMA_DIMENSIONS',CRESTRICTIONS_MDSCHEMA_DIMENSIONS);
    AddConstant('CRESTRICTIONS_MDSCHEMA_HIERARCHIES',CRESTRICTIONS_MDSCHEMA_HIERARCHIES);
    AddConstant('CRESTRICTIONS_MDSCHEMA_LEVELS',CRESTRICTIONS_MDSCHEMA_LEVELS);
    AddConstant('CRESTRICTIONS_MDSCHEMA_MEASURES',CRESTRICTIONS_MDSCHEMA_MEASURES);
    AddConstant('CRESTRICTIONS_MDSCHEMA_PROPERTIES',CRESTRICTIONS_MDSCHEMA_PROPERTIES);
    AddConstant('CRESTRICTIONS_MDSCHEMA_MEMBERS',CRESTRICTIONS_MDSCHEMA_MEMBERS);
    AddConstant('MAX_TRAN_DESC',MAX_TRAN_DESC);
    AddConstant('ISOLATIONLEVEL_UNSPECIFIED',ISOLATIONLEVEL_UNSPECIFIED);
    AddConstant('ISOLATIONLEVEL_CHAOS',ISOLATIONLEVEL_CHAOS);
    AddConstant('ISOLATIONLEVEL_READUNCOMMITTED',ISOLATIONLEVEL_READUNCOMMITTED);
    AddConstant('ISOLATIONLEVEL_BROWSE',ISOLATIONLEVEL_BROWSE);
    AddConstant('ISOLATIONLEVEL_CURSORSTABILITY',ISOLATIONLEVEL_CURSORSTABILITY);
    AddConstant('ISOLATIONLEVEL_READCOMMITTED',ISOLATIONLEVEL_READCOMMITTED);
    AddConstant('ISOLATIONLEVEL_REPEATABLEREAD',ISOLATIONLEVEL_REPEATABLEREAD);
    AddConstant('ISOLATIONLEVEL_SERIALIZABLE',ISOLATIONLEVEL_SERIALIZABLE);
    AddConstant('ISOLATIONLEVEL_ISOLATED',ISOLATIONLEVEL_ISOLATED);
    AddConstant('ISOFLAG_RETAIN_COMMIT_DC',ISOFLAG_RETAIN_COMMIT_DC);
    AddConstant('ISOFLAG_RETAIN_COMMIT',ISOFLAG_RETAIN_COMMIT);
    AddConstant('ISOFLAG_RETAIN_COMMIT_NO',ISOFLAG_RETAIN_COMMIT_NO);
    AddConstant('ISOFLAG_RETAIN_ABORT_DC',ISOFLAG_RETAIN_ABORT_DC);
    AddConstant('ISOFLAG_RETAIN_ABORT',ISOFLAG_RETAIN_ABORT);
    AddConstant('ISOFLAG_RETAIN_ABORT_NO',ISOFLAG_RETAIN_ABORT_NO);
    AddConstant('ISOFLAG_RETAIN_DONTCARE',ISOFLAG_RETAIN_DONTCARE);
    AddConstant('ISOFLAG_RETAIN_BOTH',ISOFLAG_RETAIN_BOTH);
    AddConstant('ISOFLAG_RETAIN_NONE',ISOFLAG_RETAIN_NONE);
    AddConstant('ISOFLAG_OPTIMISTIC',ISOFLAG_OPTIMISTIC);
    AddConstant('ISOFLAG_READONLY',ISOFLAG_READONLY);
    AddConstant('XACTTC_SYNC_PHASEONE',XACTTC_SYNC_PHASEONE);
    AddConstant('XACTTC_SYNC_PHASETWO',XACTTC_SYNC_PHASETWO);
    AddConstant('XACTTC_SYNC',XACTTC_SYNC);
    AddConstant('XACTTC_ASYNC_PHASEONE',XACTTC_ASYNC_PHASEONE);
    AddConstant('XACTTC_ASYNC',XACTTC_ASYNC);
    AddConstant('XACTRM_OPTIMISTICLASTWINS',XACTRM_OPTIMISTICLASTWINS);
    AddConstant('XACTRM_NOREADONLYPREPARES',XACTRM_NOREADONLYPREPARES);
    AddConstant('XACTCONST_TIMEOUTINFINITE',XACTCONST_TIMEOUTINFINITE);
    AddConstant('XACTHEURISTIC_ABORT',XACTHEURISTIC_ABORT);
    AddConstant('XACTHEURISTIC_COMMIT',XACTHEURISTIC_COMMIT);
    AddConstant('XACTHEURISTIC_DAMAGE',XACTHEURISTIC_DAMAGE);
    AddConstant('XACTHEURISTIC_DANGER',XACTHEURISTIC_DANGER);
    AddConstant('XACTSTAT_NONE',XACTSTAT_NONE);
    AddConstant('XACTSTAT_OPENNORMAL',XACTSTAT_OPENNORMAL);
    AddConstant('XACTSTAT_OPENREFUSED',XACTSTAT_OPENREFUSED);
    AddConstant('XACTSTAT_PREPARING',XACTSTAT_PREPARING);
    AddConstant('XACTSTAT_PREPARED',XACTSTAT_PREPARED);
    AddConstant('XACTSTAT_PREPARERETAINING',XACTSTAT_PREPARERETAINING);
    AddConstant('XACTSTAT_PREPARERETAINED',XACTSTAT_PREPARERETAINED);
    AddConstant('XACTSTAT_COMMITTING',XACTSTAT_COMMITTING);
    AddConstant('XACTSTAT_COMMITRETAINING',XACTSTAT_COMMITRETAINING);
    AddConstant('XACTSTAT_ABORTING',XACTSTAT_ABORTING);
    AddConstant('XACTSTAT_ABORTED',XACTSTAT_ABORTED);
    AddConstant('XACTSTAT_COMMITTED',XACTSTAT_COMMITTED);
    AddConstant('XACTSTAT_HEURISTIC_ABORT',XACTSTAT_HEURISTIC_ABORT);
    AddConstant('XACTSTAT_HEURISTIC_COMMIT',XACTSTAT_HEURISTIC_COMMIT);
    AddConstant('XACTSTAT_HEURISTIC_DAMAGE',XACTSTAT_HEURISTIC_DAMAGE);
    AddConstant('XACTSTAT_HEURISTIC_DANGER',XACTSTAT_HEURISTIC_DANGER);
    AddConstant('XACTSTAT_FORCED_ABORT',XACTSTAT_FORCED_ABORT);
    AddConstant('XACTSTAT_FORCED_COMMIT',XACTSTAT_FORCED_COMMIT);
    AddConstant('XACTSTAT_INDOUBT',XACTSTAT_INDOUBT);
    AddConstant('XACTSTAT_CLOSED',XACTSTAT_CLOSED);
    AddConstant('XACTSTAT_OPEN',XACTSTAT_OPEN);
    AddConstant('XACTSTAT_NOTPREPARED',XACTSTAT_NOTPREPARED);
    AddConstant('XACTSTAT_ALL',XACTSTAT_ALL);
    AddConstant('XACT_E_FIRST',XACT_E_FIRST);
    AddConstant('XACT_E_LAST',XACT_E_LAST);
    AddConstant('XACT_S_FIRST',XACT_S_FIRST);
    AddConstant('XACT_S_LAST',XACT_S_LAST);
    AddConstant('XACT_E_ALREADYOTHERSINGLEPHASE',XACT_E_ALREADYOTHERSINGLEPHASE);
    AddConstant('XACT_E_CANTRETAIN',XACT_E_CANTRETAIN);
    AddConstant('XACT_E_COMMITFAILED',XACT_E_COMMITFAILED);
    AddConstant('XACT_E_COMMITPREVENTED',XACT_E_COMMITPREVENTED);
    AddConstant('XACT_E_HEURISTICABORT',XACT_E_HEURISTICABORT);
    AddConstant('XACT_E_HEURISTICCOMMIT',XACT_E_HEURISTICCOMMIT);
    AddConstant('XACT_E_HEURISTICDAMAGE',XACT_E_HEURISTICDAMAGE);
    AddConstant('XACT_E_HEURISTICDANGER',XACT_E_HEURISTICDANGER);
    AddConstant('XACT_E_ISOLATIONLEVEL',XACT_E_ISOLATIONLEVEL);
    AddConstant('XACT_E_NOASYNC',XACT_E_NOASYNC);
    AddConstant('XACT_E_NOENLIST',XACT_E_NOENLIST);
    AddConstant('XACT_E_NOISORETAIN',XACT_E_NOISORETAIN);
    AddConstant('XACT_E_NORESOURCE',XACT_E_NORESOURCE);
    AddConstant('XACT_E_NOTCURRENT',XACT_E_NOTCURRENT);
    AddConstant('XACT_E_NOTRANSACTION',XACT_E_NOTRANSACTION);
    AddConstant('XACT_E_NOTSUPPORTED',XACT_E_NOTSUPPORTED);
    AddConstant('XACT_E_UNKNOWNRMGRID',XACT_E_UNKNOWNRMGRID);
    AddConstant('XACT_E_WRONGSTATE',XACT_E_WRONGSTATE);
    AddConstant('XACT_E_WRONGUOW',XACT_E_WRONGUOW);
    AddConstant('XACT_E_XTIONEXISTS',XACT_E_XTIONEXISTS);
    AddConstant('XACT_E_NOIMPORTOBJECT',XACT_E_NOIMPORTOBJECT);
    AddConstant('XACT_E_INVALIDCOOKIE',XACT_E_INVALIDCOOKIE);
    AddConstant('XACT_E_INDOUBT',XACT_E_INDOUBT);
    AddConstant('XACT_E_NOTIMEOUT',XACT_E_NOTIMEOUT);
    AddConstant('XACT_E_ALREADYINPROGRESS',XACT_E_ALREADYINPROGRESS);
    AddConstant('XACT_E_ABORTED',XACT_E_ABORTED);
    AddConstant('XACT_E_LOGFULL',XACT_E_LOGFULL);
    AddConstant('XACT_E_TMNOTAVAILABLE',XACT_E_TMNOTAVAILABLE);
    AddConstant('XACT_E_CONNECTION_DOWN',XACT_E_CONNECTION_DOWN);
    AddConstant('XACT_E_CONNECTION_DENIED',XACT_E_CONNECTION_DENIED);
    AddConstant('XACT_E_REENLISTTIMEOUT',XACT_E_REENLISTTIMEOUT);
    AddConstant('XACT_S_ASYNC',XACT_S_ASYNC);
    AddConstant('XACT_S_DEFECT',XACT_S_DEFECT);
    AddConstant('XACT_S_READONLY',XACT_S_READONLY);
    AddConstant('XACT_S_SOMENORETAIN',XACT_S_SOMENORETAIN);
    AddConstant('XACT_S_OKINFORM',XACT_S_OKINFORM);
    AddConstant('XACT_S_MADECHANGESCONTENT',XACT_S_MADECHANGESCONTENT);
    AddConstant('XACT_S_MADECHANGESINFORM',XACT_S_MADECHANGESINFORM);
    AddConstant('XACT_S_ALLNORETAIN',XACT_S_ALLNORETAIN);
    AddConstant('XACT_S_ABORTING',XACT_S_ABORTING);
    AddConstant('XACT_S_SINGLEPHASE',XACT_S_SINGLEPHASE);
    AddConstant('DBKIND_GUID_NAME',DBKIND_GUID_NAME);
    AddConstant('DBKIND_GUID_PROPID',DBKIND_GUID_PROPID);
    AddConstant('DBKIND_NAME',DBKIND_NAME);
    AddConstant('DBKIND_PGUID_NAME',DBKIND_PGUID_NAME);
    AddConstant('DBKIND_PGUID_PROPID',DBKIND_PGUID_PROPID);
    AddConstant('DBKIND_PROPID',DBKIND_PROPID);
    AddConstant('DBKIND_GUID',DBKIND_GUID);
    AddConstant('DBTYPE_EMPTY',DBTYPE_EMPTY);
    AddConstant('DBTYPE_NULL',DBTYPE_NULL);
    AddConstant('DBTYPE_I2',DBTYPE_I2);
    AddConstant('DBTYPE_I4',DBTYPE_I4);
    AddConstant('DBTYPE_R4',DBTYPE_R4);
    AddConstant('DBTYPE_R8',DBTYPE_R8);
    AddConstant('DBTYPE_CY',DBTYPE_CY);
    AddConstant('DBTYPE_DATE',DBTYPE_DATE);
    AddConstant('DBTYPE_BSTR',DBTYPE_BSTR);
    AddConstant('DBTYPE_IDISPATCH',DBTYPE_IDISPATCH);
    AddConstant('DBTYPE_ERROR',DBTYPE_ERROR);
    AddConstant('DBTYPE_BOOL',DBTYPE_BOOL);
    AddConstant('DBTYPE_VARIANT',DBTYPE_VARIANT);
    AddConstant('DBTYPE_IUNKNOWN',DBTYPE_IUNKNOWN);
    AddConstant('DBTYPE_DECIMAL',DBTYPE_DECIMAL);
    AddConstant('DBTYPE_UI1',DBTYPE_UI1);
    AddConstant('DBTYPE_ARRAY',DBTYPE_ARRAY);
    AddConstant('DBTYPE_BYREF',DBTYPE_BYREF);
    AddConstant('DBTYPE_I1',DBTYPE_I1);
    AddConstant('DBTYPE_UI2',DBTYPE_UI2);
    AddConstant('DBTYPE_UI4',DBTYPE_UI4);
    AddConstant('DBTYPE_I8',DBTYPE_I8);
    AddConstant('DBTYPE_UI8',DBTYPE_UI8);
    AddConstant('DBTYPE_GUID',DBTYPE_GUID);
    AddConstant('DBTYPE_VECTOR',DBTYPE_VECTOR);
    AddConstant('DBTYPE_RESERVED',DBTYPE_RESERVED);
    AddConstant('DBTYPE_BYTES',DBTYPE_BYTES);
    AddConstant('DBTYPE_STR',DBTYPE_STR);
    AddConstant('DBTYPE_WSTR',DBTYPE_WSTR);
    AddConstant('DBTYPE_NUMERIC',DBTYPE_NUMERIC);
    AddConstant('DBTYPE_UDT',DBTYPE_UDT);
    AddConstant('DBTYPE_DBDATE',DBTYPE_DBDATE);
    AddConstant('DBTYPE_DBTIME',DBTYPE_DBTIME);
    AddConstant('DBTYPE_DBTIMESTAMP',DBTYPE_DBTIMESTAMP);
    AddConstant('DBTYPE_HCHAPTER',DBTYPE_HCHAPTER);
    AddConstant('DBTYPE_FILETIME',DBTYPE_FILETIME);
    AddConstant('DBTYPE_DBFILETIME',DBTYPE_DBFILETIME);
    AddConstant('DBTYPE_PROPVARIANT',DBTYPE_PROPVARIANT);
    AddConstant('DBTYPE_VARNUMERIC',DBTYPE_VARNUMERIC);
    AddConstant('DBPART_INVALID',DBPART_INVALID);
    AddConstant('DBPART_VALUE',DBPART_VALUE);
    AddConstant('DBPART_LENGTH',DBPART_LENGTH);
    AddConstant('DBPART_STATUS',DBPART_STATUS);
    AddConstant('DBPARAMIO_NOTPARAM',DBPARAMIO_NOTPARAM);
    AddConstant('DBPARAMIO_INPUT',DBPARAMIO_INPUT);
    AddConstant('DBPARAMIO_OUTPUT',DBPARAMIO_OUTPUT);
    AddConstant('DBBINDFLAG_HTML',DBBINDFLAG_HTML);
    AddConstant('DBMEMOWNER_CLIENTOWNED',DBMEMOWNER_CLIENTOWNED);
    AddConstant('DBMEMOWNER_PROVIDEROWNED',DBMEMOWNER_PROVIDEROWNED);
    AddConstant('DBSTATUS_S_OK',DBSTATUS_S_OK);
    AddConstant('DBSTATUS_E_BADACCESSOR',DBSTATUS_E_BADACCESSOR);
    AddConstant('DBSTATUS_E_CANTCONVERTVALUE',DBSTATUS_E_CANTCONVERTVALUE);
    AddConstant('DBSTATUS_S_ISNULL',DBSTATUS_S_ISNULL);
    AddConstant('DBSTATUS_S_TRUNCATED',DBSTATUS_S_TRUNCATED);
    AddConstant('DBSTATUS_E_SIGNMISMATCH',DBSTATUS_E_SIGNMISMATCH);
    AddConstant('DBSTATUS_E_DATAOVERFLOW',DBSTATUS_E_DATAOVERFLOW);
    AddConstant('DBSTATUS_E_CANTCREATE',DBSTATUS_E_CANTCREATE);
    AddConstant('DBSTATUS_E_UNAVAILABLE',DBSTATUS_E_UNAVAILABLE);
    AddConstant('DBSTATUS_E_PERMISSIONDENIED',DBSTATUS_E_PERMISSIONDENIED);
    AddConstant('DBSTATUS_E_INTEGRITYVIOLATION',DBSTATUS_E_INTEGRITYVIOLATION);
    AddConstant('DBSTATUS_E_SCHEMAVIOLATION',DBSTATUS_E_SCHEMAVIOLATION);
    AddConstant('DBSTATUS_E_BADSTATUS',DBSTATUS_E_BADSTATUS);
    AddConstant('DBSTATUS_S_DEFAULT',DBSTATUS_S_DEFAULT);
    AddConstant('MDSTATUS_S_CELLEMPTY',MDSTATUS_S_CELLEMPTY);
    AddConstant('DBSTATUS_S_IGNORE',DBSTATUS_S_IGNORE);
    AddConstant('DBROWSTATUS_S_OK',DBROWSTATUS_S_OK);
    AddConstant('DBROWSTATUS_S_MULTIPLECHANGES',DBROWSTATUS_S_MULTIPLECHANGES);
    AddConstant('DBROWSTATUS_S_PENDINGCHANGES',DBROWSTATUS_S_PENDINGCHANGES);
    AddConstant('DBROWSTATUS_E_CANCELED',DBROWSTATUS_E_CANCELED);
    AddConstant('DBROWSTATUS_E_CANTRELEASE',DBROWSTATUS_E_CANTRELEASE);
    AddConstant('DBROWSTATUS_E_CONCURRENCYVIOLATION',DBROWSTATUS_E_CONCURRENCYVIOLATION);
    AddConstant('DBROWSTATUS_E_DELETED',DBROWSTATUS_E_DELETED);
    AddConstant('DBROWSTATUS_E_PENDINGINSERT',DBROWSTATUS_E_PENDINGINSERT);
    AddConstant('DBROWSTATUS_E_NEWLYINSERTED',DBROWSTATUS_E_NEWLYINSERTED);
    AddConstant('DBROWSTATUS_E_INTEGRITYVIOLATION',DBROWSTATUS_E_INTEGRITYVIOLATION);
    AddConstant('DBROWSTATUS_E_INVALID',DBROWSTATUS_E_INVALID);
    AddConstant('DBROWSTATUS_E_MAXPENDCHANGESEXCEEDED',DBROWSTATUS_E_MAXPENDCHANGESEXCEEDED);
    AddConstant('DBROWSTATUS_E_OBJECTOPEN',DBROWSTATUS_E_OBJECTOPEN);
    AddConstant('DBROWSTATUS_E_OUTOFMEMORY',DBROWSTATUS_E_OUTOFMEMORY);
    AddConstant('DBROWSTATUS_E_PERMISSIONDENIED',DBROWSTATUS_E_PERMISSIONDENIED);
    AddConstant('DBROWSTATUS_E_LIMITREACHED',DBROWSTATUS_E_LIMITREACHED);
    AddConstant('DBROWSTATUS_E_SCHEMAVIOLATION',DBROWSTATUS_E_SCHEMAVIOLATION);
    AddConstant('DBROWSTATUS_E_FAIL',DBROWSTATUS_E_FAIL);
    AddConstant('DBROWSTATUS_S_NOCHANGE',DBROWSTATUS_S_NOCHANGE);
    AddConstant('DBCOLUMNFLAGS_ISBOOKMARK',DBCOLUMNFLAGS_ISBOOKMARK);
    AddConstant('DBCOLUMNFLAGS_MAYDEFER',DBCOLUMNFLAGS_MAYDEFER);
    AddConstant('DBCOLUMNFLAGS_WRITE',DBCOLUMNFLAGS_WRITE);
    AddConstant('DBCOLUMNFLAGS_WRITEUNKNOWN',DBCOLUMNFLAGS_WRITEUNKNOWN);
    AddConstant('DBCOLUMNFLAGS_ISFIXEDLENGTH',DBCOLUMNFLAGS_ISFIXEDLENGTH);
    AddConstant('DBCOLUMNFLAGS_ISNULLABLE',DBCOLUMNFLAGS_ISNULLABLE);
    AddConstant('DBCOLUMNFLAGS_MAYBENULL',DBCOLUMNFLAGS_MAYBENULL);
    AddConstant('DBCOLUMNFLAGS_ISLONG',DBCOLUMNFLAGS_ISLONG);
    AddConstant('DBCOLUMNFLAGS_ISROWID',DBCOLUMNFLAGS_ISROWID);
    AddConstant('DBCOLUMNFLAGS_ISROWVER',DBCOLUMNFLAGS_ISROWVER);
    AddConstant('DBCOLUMNFLAGS_CACHEDEFERRED',DBCOLUMNFLAGS_CACHEDEFERRED);
    AddConstant('DBCOLUMNFLAGS_SCALEISNEGATIVE',DBCOLUMNFLAGS_SCALEISNEGATIVE);
    AddConstant('DBCOLUMNFLAGS_KEYCOLUMN',DBCOLUMNFLAGS_KEYCOLUMN);
    AddConstant('DBCOLUMNFLAGS_ISCHAPTER',DBCOLUMNFLAGS_ISCHAPTER);
    AddConstant('DBBMK_INVALID',DBBMK_INVALID);
    AddConstant('DBBMK_FIRST',DBBMK_FIRST);
    AddConstant('DBBMK_LAST',DBBMK_LAST);
    AddConstant('DBPROP_ABORTPRESERVE',DBPROP_ABORTPRESERVE);
    AddConstant('DBPROP_ACTIVESESSIONS',DBPROP_ACTIVESESSIONS);
    AddConstant('DBPROP_APPENDONLY',DBPROP_APPENDONLY);
    AddConstant('DBPROP_ASYNCTXNABORT',DBPROP_ASYNCTXNABORT);
    AddConstant('DBPROP_ASYNCTXNCOMMIT',DBPROP_ASYNCTXNCOMMIT);
    AddConstant('DBPROP_AUTH_CACHE_AUTHINFO',DBPROP_AUTH_CACHE_AUTHINFO);
    AddConstant('DBPROP_AUTH_ENCRYPT_PASSWORD',DBPROP_AUTH_ENCRYPT_PASSWORD);
    AddConstant('DBPROP_AUTH_INTEGRATED',DBPROP_AUTH_INTEGRATED);
    AddConstant('DBPROP_AUTH_MASK_PASSWORD',DBPROP_AUTH_MASK_PASSWORD);
    AddConstant('DBPROP_AUTH_PASSWORD',DBPROP_AUTH_PASSWORD);
    AddConstant('DBPROP_AUTH_PERSIST_ENCRYPTED',DBPROP_AUTH_PERSIST_ENCRYPTED);
    AddConstant('DBPROP_AUTH_PERSIST_SENSITIVE_AUTHINFO',DBPROP_AUTH_PERSIST_SENSITIVE_AUTHINFO);
    AddConstant('DBPROP_AUTH_USERID',DBPROP_AUTH_USERID);
    AddConstant('DBPROP_BLOCKINGSTORAGEOBJECTS',DBPROP_BLOCKINGSTORAGEOBJECTS);
    AddConstant('DBPROP_BOOKMARKS',DBPROP_BOOKMARKS);
    AddConstant('DBPROP_BOOKMARKSKIPPED',DBPROP_BOOKMARKSKIPPED);
    AddConstant('DBPROP_BOOKMARKTYPE',DBPROP_BOOKMARKTYPE);
    AddConstant('DBPROP_BYREFACCESSORS',DBPROP_BYREFACCESSORS);
    AddConstant('DBPROP_CACHEDEFERRED',DBPROP_CACHEDEFERRED);
    AddConstant('DBPROP_CANFETCHBACKWARDS',DBPROP_CANFETCHBACKWARDS);
    AddConstant('DBPROP_CANHOLDROWS',DBPROP_CANHOLDROWS);
    AddConstant('DBPROP_CANSCROLLBACKWARDS',DBPROP_CANSCROLLBACKWARDS);
    AddConstant('DBPROP_CATALOGLOCATION',DBPROP_CATALOGLOCATION);
    AddConstant('DBPROP_CATALOGTERM',DBPROP_CATALOGTERM);
    AddConstant('DBPROP_CATALOGUSAGE',DBPROP_CATALOGUSAGE);
    AddConstant('DBPROP_CHANGEINSERTEDROWS',DBPROP_CHANGEINSERTEDROWS);
    AddConstant('DBPROP_COL_AUTOINCREMENT',DBPROP_COL_AUTOINCREMENT);
    AddConstant('DBPROP_COL_DEFAULT',DBPROP_COL_DEFAULT);
    AddConstant('DBPROP_COL_DESCRIPTION',DBPROP_COL_DESCRIPTION);
    AddConstant('DBPROP_COL_FIXEDLENGTH',DBPROP_COL_FIXEDLENGTH);
    AddConstant('DBPROP_COL_NULLABLE',DBPROP_COL_NULLABLE);
    AddConstant('DBPROP_COL_PRIMARYKEY',DBPROP_COL_PRIMARYKEY);
    AddConstant('DBPROP_COL_UNIQUE',DBPROP_COL_UNIQUE);
    AddConstant('DBPROP_COLUMNDEFINITION',DBPROP_COLUMNDEFINITION);
    AddConstant('DBPROP_COLUMNRESTRICT',DBPROP_COLUMNRESTRICT);
    AddConstant('DBPROP_COMMANDTIMEOUT',DBPROP_COMMANDTIMEOUT);
    AddConstant('DBPROP_COMMITPRESERVE',DBPROP_COMMITPRESERVE);
    AddConstant('DBPROP_CONCATNULLBEHAVIOR',DBPROP_CONCATNULLBEHAVIOR);
    AddConstant('DBPROP_CURRENTCATALOG',DBPROP_CURRENTCATALOG);
    AddConstant('DBPROP_DATASOURCENAME',DBPROP_DATASOURCENAME);
    AddConstant('DBPROP_DATASOURCEREADONLY',DBPROP_DATASOURCEREADONLY);
    AddConstant('DBPROP_DBMSNAME',DBPROP_DBMSNAME);
    AddConstant('DBPROP_DBMSVER',DBPROP_DBMSVER);
    AddConstant('DBPROP_DEFERRED',DBPROP_DEFERRED);
    AddConstant('DBPROP_DELAYSTORAGEOBJECTS',DBPROP_DELAYSTORAGEOBJECTS);
    AddConstant('DBPROP_DSOTHREADMODEL',DBPROP_DSOTHREADMODEL);
    AddConstant('DBPROP_GROUPBY',DBPROP_GROUPBY);
    AddConstant('DBPROP_HETEROGENEOUSTABLES',DBPROP_HETEROGENEOUSTABLES);
    AddConstant('DBPROP_IAccessor',DBPROP_IAccessor);
    AddConstant('DBPROP_IColumnsInfo',DBPROP_IColumnsInfo);
    AddConstant('DBPROP_IColumnsRowset',DBPROP_IColumnsRowset);
    AddConstant('DBPROP_IConnectionPointContainer',DBPROP_IConnectionPointContainer);
    AddConstant('DBPROP_IConvertType',DBPROP_IConvertType);
    AddConstant('DBPROP_IRowset',DBPROP_IRowset);
    AddConstant('DBPROP_IRowsetChange',DBPROP_IRowsetChange);
    AddConstant('DBPROP_IRowsetIdentity',DBPROP_IRowsetIdentity);
    AddConstant('DBPROP_IRowsetIndex',DBPROP_IRowsetIndex);
    AddConstant('DBPROP_IRowsetInfo',DBPROP_IRowsetInfo);
    AddConstant('DBPROP_IRowsetLocate',DBPROP_IRowsetLocate);
    AddConstant('DBPROP_IRowsetResynch',DBPROP_IRowsetResynch);
    AddConstant('DBPROP_IRowsetScroll',DBPROP_IRowsetScroll);
    AddConstant('DBPROP_IRowsetUpdate',DBPROP_IRowsetUpdate);
    AddConstant('DBPROP_ISupportErrorInfo',DBPROP_ISupportErrorInfo);
    AddConstant('DBPROP_ILockBytes',DBPROP_ILockBytes);
    AddConstant('DBPROP_ISequentialStream',DBPROP_ISequentialStream);
    AddConstant('DBPROP_IStorage',DBPROP_IStorage);
    AddConstant('DBPROP_IStream',DBPROP_IStream);
    AddConstant('DBPROP_IDENTIFIERCASE',DBPROP_IDENTIFIERCASE);
    AddConstant('DBPROP_IMMOBILEROWS',DBPROP_IMMOBILEROWS);
    AddConstant('DBPROP_INDEX_AUTOUPDATE',DBPROP_INDEX_AUTOUPDATE);
    AddConstant('DBPROP_INDEX_CLUSTERED',DBPROP_INDEX_CLUSTERED);
    AddConstant('DBPROP_INDEX_FILLFACTOR',DBPROP_INDEX_FILLFACTOR);
    AddConstant('DBPROP_INDEX_INITIALSIZE',DBPROP_INDEX_INITIALSIZE);
    AddConstant('DBPROP_INDEX_NULLCOLLATION',DBPROP_INDEX_NULLCOLLATION);
    AddConstant('DBPROP_INDEX_NULLS',DBPROP_INDEX_NULLS);
    AddConstant('DBPROP_INDEX_PRIMARYKEY',DBPROP_INDEX_PRIMARYKEY);
    AddConstant('DBPROP_INDEX_SORTBOOKMARKS',DBPROP_INDEX_SORTBOOKMARKS);
    AddConstant('DBPROP_INDEX_TEMPINDEX',DBPROP_INDEX_TEMPINDEX);
    AddConstant('DBPROP_INDEX_TYPE',DBPROP_INDEX_TYPE);
    AddConstant('DBPROP_INDEX_UNIQUE',DBPROP_INDEX_UNIQUE);
    AddConstant('DBPROP_INIT_DATASOURCE',DBPROP_INIT_DATASOURCE);
    AddConstant('DBPROP_INIT_HWND',DBPROP_INIT_HWND);
    AddConstant('DBPROP_INIT_IMPERSONATION_LEVEL',DBPROP_INIT_IMPERSONATION_LEVEL);
    AddConstant('DBPROP_INIT_LCID',DBPROP_INIT_LCID);
    AddConstant('DBPROP_INIT_LOCATION',DBPROP_INIT_LOCATION);
    AddConstant('DBPROP_INIT_MODE',DBPROP_INIT_MODE);
    AddConstant('DBPROP_INIT_PROMPT',DBPROP_INIT_PROMPT);
    AddConstant('DBPROP_INIT_PROTECTION_LEVEL',DBPROP_INIT_PROTECTION_LEVEL);
    AddConstant('DBPROP_INIT_PROVIDERSTRING',DBPROP_INIT_PROVIDERSTRING);
    AddConstant('DBPROP_INIT_TIMEOUT',DBPROP_INIT_TIMEOUT);
    AddConstant('DBPROP_LITERALBOOKMARKS',DBPROP_LITERALBOOKMARKS);
    AddConstant('DBPROP_LITERALIDENTITY',DBPROP_LITERALIDENTITY);
    AddConstant('DBPROP_MARSHALLABLE',DBPROP_MARSHALLABLE);
    AddConstant('DBPROP_MAXINDEXSIZE',DBPROP_MAXINDEXSIZE);
    AddConstant('DBPROP_MAXOPENROWS',DBPROP_MAXOPENROWS);
    AddConstant('DBPROP_MAXPENDINGROWS',DBPROP_MAXPENDINGROWS);
    AddConstant('DBPROP_MAXROWS',DBPROP_MAXROWS);
    AddConstant('DBPROP_MAXROWSIZE',DBPROP_MAXROWSIZE);
    AddConstant('DBPROP_MAXROWSIZEINCLUDESBLOB',DBPROP_MAXROWSIZEINCLUDESBLOB);
    AddConstant('DBPROP_MAXTABLESINSELECT',DBPROP_MAXTABLESINSELECT);
    AddConstant('DBPROP_MAYWRITECOLUMN',DBPROP_MAYWRITECOLUMN);
    AddConstant('DBPROP_MEMORYUSAGE',DBPROP_MEMORYUSAGE);
    AddConstant('DBPROP_MULTIPLEPARAMSETS',DBPROP_MULTIPLEPARAMSETS);
    AddConstant('DBPROP_MULTIPLERESULTS',DBPROP_MULTIPLERESULTS);
    AddConstant('DBPROP_MULTIPLESTORAGEOBJECTS',DBPROP_MULTIPLESTORAGEOBJECTS);
    AddConstant('DBPROP_MULTITABLEUPDATE',DBPROP_MULTITABLEUPDATE);
    AddConstant('DBPROP_NOTIFICATIONGRANULARITY',DBPROP_NOTIFICATIONGRANULARITY);
    AddConstant('DBPROP_NOTIFICATIONPHASES',DBPROP_NOTIFICATIONPHASES);
    AddConstant('DBPROP_NOTIFYCOLUMNSET',DBPROP_NOTIFYCOLUMNSET);
    AddConstant('DBPROP_NOTIFYROWDELETE',DBPROP_NOTIFYROWDELETE);
    AddConstant('DBPROP_NOTIFYROWFIRSTCHANGE',DBPROP_NOTIFYROWFIRSTCHANGE);
    AddConstant('DBPROP_NOTIFYROWINSERT',DBPROP_NOTIFYROWINSERT);
    AddConstant('DBPROP_NOTIFYROWRESYNCH',DBPROP_NOTIFYROWRESYNCH);
    AddConstant('DBPROP_NOTIFYROWSETCHANGED',DBPROP_NOTIFYROWSETCHANGED);
    AddConstant('DBPROP_NOTIFYROWSETRELEASE',DBPROP_NOTIFYROWSETRELEASE);
    AddConstant('DBPROP_NOTIFYROWSETFETCHPOSITIONCHANGE',DBPROP_NOTIFYROWSETFETCHPOSITIONCHANGE);
    AddConstant('DBPROP_NOTIFYROWUNDOCHANGE',DBPROP_NOTIFYROWUNDOCHANGE);
    AddConstant('DBPROP_NOTIFYROWUNDODELETE',DBPROP_NOTIFYROWUNDODELETE);
    AddConstant('DBPROP_NOTIFYROWUNDOINSERT',DBPROP_NOTIFYROWUNDOINSERT);
    AddConstant('DBPROP_NOTIFYROWUPDATE',DBPROP_NOTIFYROWUPDATE);
    AddConstant('DBPROP_NULLCOLLATION',DBPROP_NULLCOLLATION);
    AddConstant('DBPROP_OLEOBJECTS',DBPROP_OLEOBJECTS);
    AddConstant('DBPROP_ORDERBYCOLUMNSINSELECT',DBPROP_ORDERBYCOLUMNSINSELECT);
    AddConstant('DBPROP_ORDEREDBOOKMARKS',DBPROP_ORDEREDBOOKMARKS);
    AddConstant('DBPROP_OTHERINSERT',DBPROP_OTHERINSERT);
    AddConstant('DBPROP_OTHERUPDATEDELETE',DBPROP_OTHERUPDATEDELETE);
    AddConstant('DBPROP_OUTPUTPARAMETERAVAILABILITY',DBPROP_OUTPUTPARAMETERAVAILABILITY);
    AddConstant('DBPROP_OWNINSERT',DBPROP_OWNINSERT);
    AddConstant('DBPROP_OWNUPDATEDELETE',DBPROP_OWNUPDATEDELETE);
    AddConstant('DBPROP_PERSISTENTIDTYPE',DBPROP_PERSISTENTIDTYPE);
    AddConstant('DBPROP_PREPAREABORTBEHAVIOR',DBPROP_PREPAREABORTBEHAVIOR);
    AddConstant('DBPROP_PREPARECOMMITBEHAVIOR',DBPROP_PREPARECOMMITBEHAVIOR);
    AddConstant('DBPROP_PROCEDURETERM',DBPROP_PROCEDURETERM);
    AddConstant('DBPROP_PROVIDERNAME',DBPROP_PROVIDERNAME);
    AddConstant('DBPROP_PROVIDERFILENAME',DBPROP_PROVIDERFILENAME);
    AddConstant('DBPROP_PROVIDEROLEDBVER',DBPROP_PROVIDEROLEDBVER);
    AddConstant('DBPROP_PROVIDERVER',DBPROP_PROVIDERVER);
    AddConstant('DBPROP_QUICKRESTART',DBPROP_QUICKRESTART);
    AddConstant('DBPROP_QUOTEDIDENTIFIERCASE',DBPROP_QUOTEDIDENTIFIERCASE);
    AddConstant('DBPROP_REENTRANTEVENTS',DBPROP_REENTRANTEVENTS);
    AddConstant('DBPROP_REMOVEDELETED',DBPROP_REMOVEDELETED);
    AddConstant('DBPROP_REPORTMULTIPLECHANGES',DBPROP_REPORTMULTIPLECHANGES);
    AddConstant('DBPROP_RETURNPENDINGINSERTS',DBPROP_RETURNPENDINGINSERTS);
    AddConstant('DBPROP_ROWRESTRICT',DBPROP_ROWRESTRICT);
    AddConstant('DBPROP_ROWSETCONVERSIONSONCOMMAND',DBPROP_ROWSETCONVERSIONSONCOMMAND);
    AddConstant('DBPROP_ROWTHREADMODEL',DBPROP_ROWTHREADMODEL);
    AddConstant('DBPROP_SCHEMATERM',DBPROP_SCHEMATERM);
    AddConstant('DBPROP_SCHEMAUSAGE',DBPROP_SCHEMAUSAGE);
    AddConstant('DBPROP_SERVERCURSOR',DBPROP_SERVERCURSOR);
    AddConstant('DBPROP_SESS_AUTOCOMMITISOLEVELS',DBPROP_SESS_AUTOCOMMITISOLEVELS);
    AddConstant('DBPROP_SQLSUPPORT',DBPROP_SQLSUPPORT);
    AddConstant('DBPROP_STRONGIDENTITY',DBPROP_STRONGIDENTITY);
    AddConstant('DBPROP_STRUCTUREDSTORAGE',DBPROP_STRUCTUREDSTORAGE);
    AddConstant('DBPROP_SUBQUERIES',DBPROP_SUBQUERIES);
    AddConstant('DBPROP_SUPPORTEDTXNDDL',DBPROP_SUPPORTEDTXNDDL);
    AddConstant('DBPROP_SUPPORTEDTXNISOLEVELS',DBPROP_SUPPORTEDTXNISOLEVELS);
    AddConstant('DBPROP_SUPPORTEDTXNISORETAIN',DBPROP_SUPPORTEDTXNISORETAIN);
    AddConstant('DBPROP_TABLETERM',DBPROP_TABLETERM);
    AddConstant('DBPROP_TBL_TEMPTABLE',DBPROP_TBL_TEMPTABLE);
    AddConstant('DBPROP_TRANSACTEDOBJECT',DBPROP_TRANSACTEDOBJECT);
    AddConstant('DBPROP_UPDATABILITY',DBPROP_UPDATABILITY);
    AddConstant('DBPROP_USERNAME',DBPROP_USERNAME);
    AddConstant('DBPROP_FILTEROPS',DBPROP_FILTEROPS);
    AddConstant('DBPROP_FILTERCOMPAREOPS',DBPROP_FILTERCOMPAREOPS);
    AddConstant('DBPROP_FINDCOMPAREOPS',DBPROP_FINDCOMPAREOPS);
    AddConstant('DBPROP_IChapteredRowset',DBPROP_IChapteredRowset);
    AddConstant('DBPROP_IDBAsynchStatus',DBPROP_IDBAsynchStatus);
    AddConstant('DBPROP_IRowsetFind',DBPROP_IRowsetFind);
    AddConstant('DBPROP_IRowsetView',DBPROP_IRowsetView);
    AddConstant('DBPROP_IViewChapter',DBPROP_IViewChapter);
    AddConstant('DBPROP_IViewFilter',DBPROP_IViewFilter);
    AddConstant('DBPROP_IViewRowset',DBPROP_IViewRowset);
    AddConstant('DBPROP_IViewSort',DBPROP_IViewSort);
    AddConstant('DBPROP_INIT_ASYNCH',DBPROP_INIT_ASYNCH);
    AddConstant('DBPROP_MAXOPENCHAPTERS',DBPROP_MAXOPENCHAPTERS);
    AddConstant('DBPROP_MAXORSINFILTER',DBPROP_MAXORSINFILTER);
    AddConstant('DBPROP_MAXSORTCOLUMNS',DBPROP_MAXSORTCOLUMNS);
    AddConstant('DBPROP_ROWSET_ASYNCH',DBPROP_ROWSET_ASYNCH);
    AddConstant('DBPROP_SORTONINDEX',DBPROP_SORTONINDEX);
    AddConstant('DBPROP_IMultipleResults',DBPROP_IMultipleResults);
    AddConstant('DBPROP_DATASOURCE_TYPE',DBPROP_DATASOURCE_TYPE);
    AddConstant('MDPROP_AXES',MDPROP_AXES);
    AddConstant('MDPROP_FLATTENING_SUPPORT',MDPROP_FLATTENING_SUPPORT);
    AddConstant('MDPROP_MDX_JOINCUBES',MDPROP_MDX_JOINCUBES);
    AddConstant('MDPROP_NAMED_LEVELS',MDPROP_NAMED_LEVELS);
    AddConstant('MDPROP_RANGEROWSET',MDPROP_RANGEROWSET);
    AddConstant('MDPROP_MDX_SLICER',MDPROP_MDX_SLICER);
    AddConstant('MDPROP_MDX_CUBEQUALIFICATION',MDPROP_MDX_CUBEQUALIFICATION);
    AddConstant('MDPROP_MDX_OUTERREFERENCE',MDPROP_MDX_OUTERREFERENCE);
    AddConstant('MDPROP_MDX_QUERYBYPROPERTY',MDPROP_MDX_QUERYBYPROPERTY);
    AddConstant('MDPROP_MDX_CASESUPPORT',MDPROP_MDX_CASESUPPORT);
    AddConstant('MDPROP_MDX_STRING_COMPOP',MDPROP_MDX_STRING_COMPOP);
    AddConstant('MDPROP_MDX_DESCFLAGS',MDPROP_MDX_DESCFLAGS);
    AddConstant('MDPROP_MDX_SET_FUNCTIONS',MDPROP_MDX_SET_FUNCTIONS);
    AddConstant('MDPROP_MDX_MEMBER_FUNCTIONS',MDPROP_MDX_MEMBER_FUNCTIONS);
    AddConstant('MDPROP_MDX_NUMERIC_FUNCTIONS',MDPROP_MDX_NUMERIC_FUNCTIONS);
    AddConstant('MDPROP_MDX_FORMULAS',MDPROP_MDX_FORMULAS);
    AddConstant('MDPROP_MDX_AGGREGATECELL_UPDATE',MDPROP_MDX_AGGREGATECELL_UPDATE);
    AddConstant('DBPROP_ACCESSORDER',DBPROP_ACCESSORDER);
    AddConstant('DBPROP_BOOKMARKINFO',DBPROP_BOOKMARKINFO);
    AddConstant('DBPROP_INIT_CATALOG',DBPROP_INIT_CATALOG);
    AddConstant('DBPROP_ROW_BULKOPS',DBPROP_ROW_BULKOPS);
    AddConstant('DBPROP_PROVIDERFRIENDLYNAME',DBPROP_PROVIDERFRIENDLYNAME);
    AddConstant('DBPROP_LOCKMODE',DBPROP_LOCKMODE);
    AddConstant('DBPROP_MULTIPLECONNECTIONS',DBPROP_MULTIPLECONNECTIONS);
    AddConstant('DBPROP_UNIQUEROWS',DBPROP_UNIQUEROWS);
    AddConstant('DBPROP_SERVERDATAONINSERT',DBPROP_SERVERDATAONINSERT);
    AddConstant('DBPROP_STORAGEFLAGS',DBPROP_STORAGEFLAGS);
    AddConstant('DBPROP_CONNECTIONSTATUS',DBPROP_CONNECTIONSTATUS);
    AddConstant('DBPROP_ALTERCOLUMN',DBPROP_ALTERCOLUMN);
    AddConstant('DBPROP_COLUMNLCID',DBPROP_COLUMNLCID);
    AddConstant('DBPROP_RESETDATASOURCE',DBPROP_RESETDATASOURCE);
    AddConstant('DBPROP_INIT_OLEDBSERVICES',DBPROP_INIT_OLEDBSERVICES);
    AddConstant('DBPROP_IRowsetRefresh',DBPROP_IRowsetRefresh);
    AddConstant('DBPROP_SERVERNAME',DBPROP_SERVERNAME);
    AddConstant('DBPROP_IParentRowset',DBPROP_IParentRowset);
    AddConstant('DBPROP_HIDDENCOLUMNS',DBPROP_HIDDENCOLUMNS);
    AddConstant('DBPROP_PROVIDERMEMORY',DBPROP_PROVIDERMEMORY);
    AddConstant('DBPROP_CLIENTCURSOR',DBPROP_CLIENTCURSOR);
    AddConstant('DBPROP_TRUSTEE_USERNAME',DBPROP_TRUSTEE_USERNAME);
    AddConstant('DBPROP_TRUSTEE_AUTHENTICATION',DBPROP_TRUSTEE_AUTHENTICATION);
    AddConstant('DBPROP_TRUSTEE_NEWAUTHENTICATION',DBPROP_TRUSTEE_NEWAUTHENTICATION);
    AddConstant('DBPROP_ICommandCost',DBPROP_ICommandCost);
    AddConstant('DBPROP_ICommandTree',DBPROP_ICommandTree);
    AddConstant('DBPROP_ICommandValidate',DBPROP_ICommandValidate);
    AddConstant('DBPROP_IDBSchemaCommand',DBPROP_IDBSchemaCommand);
    AddConstant('DBPROP_IProvideMoniker',DBPROP_IProvideMoniker);
    AddConstant('DBPROP_IQuery',DBPROP_IQuery);
    AddConstant('DBPROP_IReadData',DBPROP_IReadData);
    AddConstant('DBPROP_IRowsetAsynch',DBPROP_IRowsetAsynch);
    AddConstant('DBPROP_IRowsetKeys',DBPROP_IRowsetKeys);
    AddConstant('DBPROP_IRowsetNewRowAfter',DBPROP_IRowsetNewRowAfter);
    AddConstant('DBPROP_IRowsetNextRowset',DBPROP_IRowsetNextRowset);
    AddConstant('DBPROP_IRowsetWatchAll',DBPROP_IRowsetWatchAll);
    AddConstant('DBPROP_IRowsetWatchNotify',DBPROP_IRowsetWatchNotify);
    AddConstant('DBPROP_IRowsetWatchRegion',DBPROP_IRowsetWatchRegion);
    AddConstant('DBPROP_IRowsetWithParameters',DBPROP_IRowsetWithParameters);
    AddConstant('DBPROP_IRowsetExactScroll',DBPROP_IRowsetExactScroll);
    AddConstant('DBOP_scalar_constant',DBOP_scalar_constant);
    AddConstant('DBOP_DEFAULT',DBOP_DEFAULT);
    AddConstant('DBOP_NULL',DBOP_NULL);
    AddConstant('DBOP_bookmark_name',DBOP_bookmark_name);
    AddConstant('DBOP_catalog_name',DBOP_catalog_name);
    AddConstant('DBOP_column_name',DBOP_column_name);
    AddConstant('DBOP_schema_name',DBOP_schema_name);
    AddConstant('DBOP_outall_name',DBOP_outall_name);
    AddConstant('DBOP_qualifier_name',DBOP_qualifier_name);
    AddConstant('DBOP_qualified_column_name',DBOP_qualified_column_name);
    AddConstant('DBOP_table_name',DBOP_table_name);
    AddConstant('DBOP_nested_table_name',DBOP_nested_table_name);
    AddConstant('DBOP_nested_column_name',DBOP_nested_column_name);
    AddConstant('DBOP_row',DBOP_row);
    AddConstant('DBOP_table',DBOP_table);
    AddConstant('DBOP_sort',DBOP_sort);
    AddConstant('DBOP_distinct',DBOP_distinct);
    AddConstant('DBOP_distinct_order_preserving',DBOP_distinct_order_preserving);
    AddConstant('DBOP_alias',DBOP_alias);
    AddConstant('DBOP_cross_join',DBOP_cross_join);
    AddConstant('DBOP_union_join',DBOP_union_join);
    AddConstant('DBOP_inner_join',DBOP_inner_join);
    AddConstant('DBOP_left_semi_join',DBOP_left_semi_join);
    AddConstant('DBOP_right_semi_join',DBOP_right_semi_join);
    AddConstant('DBOP_left_anti_semi_join',DBOP_left_anti_semi_join);
    AddConstant('DBOP_right_anti_semi_join',DBOP_right_anti_semi_join);
    AddConstant('DBOP_left_outer_join',DBOP_left_outer_join);
    AddConstant('DBOP_right_outer_join',DBOP_right_outer_join);
    AddConstant('DBOP_full_outer_join',DBOP_full_outer_join);
    AddConstant('DBOP_natural_join',DBOP_natural_join);
    AddConstant('DBOP_natural_left_outer_join',DBOP_natural_left_outer_join);
    AddConstant('DBOP_natural_right_outer_join',DBOP_natural_right_outer_join);
    AddConstant('DBOP_natural_full_outer_join',DBOP_natural_full_outer_join);
    AddConstant('DBOP_set_intersection',DBOP_set_intersection);
    AddConstant('DBOP_set_union',DBOP_set_union);
    AddConstant('DBOP_set_left_difference',DBOP_set_left_difference);
    AddConstant('DBOP_set_right_difference',DBOP_set_right_difference);
    AddConstant('DBOP_set_anti_difference',DBOP_set_anti_difference);
    AddConstant('DBOP_bag_intersection',DBOP_bag_intersection);
    AddConstant('DBOP_bag_union',DBOP_bag_union);
    AddConstant('DBOP_bag_left_difference',DBOP_bag_left_difference);
    AddConstant('DBOP_bag_right_difference',DBOP_bag_right_difference);
    AddConstant('DBOP_bag_anti_difference',DBOP_bag_anti_difference);
    AddConstant('DBOP_division',DBOP_division);
    AddConstant('DBOP_relative_sampling',DBOP_relative_sampling);
    AddConstant('DBOP_absolute_sampling',DBOP_absolute_sampling);
    AddConstant('DBOP_transitive_closure',DBOP_transitive_closure);
    AddConstant('DBOP_recursive_union',DBOP_recursive_union);
    AddConstant('DBOP_aggregate',DBOP_aggregate);
    AddConstant('DBOP_remote_table',DBOP_remote_table);
    AddConstant('DBOP_select',DBOP_select);
    AddConstant('DBOP_order_preserving_select',DBOP_order_preserving_select);
    AddConstant('DBOP_project',DBOP_project);
    AddConstant('DBOP_project_order_preserving',DBOP_project_order_preserving);
    AddConstant('DBOP_top',DBOP_top);
    AddConstant('DBOP_top_percent',DBOP_top_percent);
    AddConstant('DBOP_top_plus_ties',DBOP_top_plus_ties);
    AddConstant('DBOP_top_percent_plus_ties',DBOP_top_percent_plus_ties);
    AddConstant('DBOP_rank',DBOP_rank);
    AddConstant('DBOP_rank_ties_equally',DBOP_rank_ties_equally);
    AddConstant('DBOP_rank_ties_equally_and_skip',DBOP_rank_ties_equally_and_skip);
    AddConstant('DBOP_navigate',DBOP_navigate);
    AddConstant('DBOP_nesting',DBOP_nesting);
    AddConstant('DBOP_unnesting',DBOP_unnesting);
    AddConstant('DBOP_nested_apply',DBOP_nested_apply);
    AddConstant('DBOP_cross_tab',DBOP_cross_tab);
    AddConstant('DBOP_is_NULL',DBOP_is_NULL);
    AddConstant('DBOP_is_NOT_NULL',DBOP_is_NOT_NULL);
    AddConstant('DBOP_equal',DBOP_equal);
    AddConstant('DBOP_not_equal',DBOP_not_equal);
    AddConstant('DBOP_less',DBOP_less);
    AddConstant('DBOP_less_equal',DBOP_less_equal);
    AddConstant('DBOP_greater',DBOP_greater);
    AddConstant('DBOP_greater_equal',DBOP_greater_equal);
    AddConstant('DBOP_equal_all',DBOP_equal_all);
    AddConstant('DBOP_not_equal_all',DBOP_not_equal_all);
    AddConstant('DBOP_less_all',DBOP_less_all);
    AddConstant('DBOP_less_equal_all',DBOP_less_equal_all);
    AddConstant('DBOP_greater_all',DBOP_greater_all);
    AddConstant('DBOP_greater_equal_all',DBOP_greater_equal_all);
    AddConstant('DBOP_equal_any',DBOP_equal_any);
    AddConstant('DBOP_not_equal_any',DBOP_not_equal_any);
    AddConstant('DBOP_less_any',DBOP_less_any);
    AddConstant('DBOP_less_equal_any',DBOP_less_equal_any);
    AddConstant('DBOP_greater_any',DBOP_greater_any);
    AddConstant('DBOP_greater_equal_any',DBOP_greater_equal_any);
    AddConstant('DBOP_anybits',DBOP_anybits);
    AddConstant('DBOP_allbits',DBOP_allbits);
    AddConstant('DBOP_anybits_any',DBOP_anybits_any);
    AddConstant('DBOP_allbits_any',DBOP_allbits_any);
    AddConstant('DBOP_anybits_all',DBOP_anybits_all);
    AddConstant('DBOP_allbits_all',DBOP_allbits_all);
    AddConstant('DBOP_between',DBOP_between);
    AddConstant('DBOP_between_unordered',DBOP_between_unordered);
    AddConstant('DBOP_match',DBOP_match);
    AddConstant('DBOP_match_unique',DBOP_match_unique);
    AddConstant('DBOP_match_partial',DBOP_match_partial);
    AddConstant('DBOP_match_partial_unique',DBOP_match_partial_unique);
    AddConstant('DBOP_match_full',DBOP_match_full);
    AddConstant('DBOP_match_full_unique',DBOP_match_full_unique);
    AddConstant('DBOP_scalar_parameter',DBOP_scalar_parameter);
    AddConstant('DBOP_scalar_function',DBOP_scalar_function);
    AddConstant('DBOP_plus',DBOP_plus);
    AddConstant('DBOP_minus',DBOP_minus);
    AddConstant('DBOP_times',DBOP_times);
    AddConstant('DBOP_over',DBOP_over);
    AddConstant('DBOP_div',DBOP_div);
    AddConstant('DBOP_modulo',DBOP_modulo);
    AddConstant('DBOP_power',DBOP_power);
    AddConstant('DBOP_like',DBOP_like);
    AddConstant('DBOP_sounds_like',DBOP_sounds_like);
    AddConstant('DBOP_like_any',DBOP_like_any);
    AddConstant('DBOP_like_all',DBOP_like_all);
    AddConstant('DBOP_is_INVALID',DBOP_is_INVALID);
    AddConstant('DBOP_is_TRUE',DBOP_is_TRUE);
    AddConstant('DBOP_is_FALSE',DBOP_is_FALSE);
    AddConstant('DBOP_and',DBOP_and);
    AddConstant('DBOP_or',DBOP_or);
    AddConstant('DBOP_xor',DBOP_xor);
    AddConstant('DBOP_equivalent',DBOP_equivalent);
    AddConstant('DBOP_not',DBOP_not);
    AddConstant('DBOP_implies',DBOP_implies);
    AddConstant('DBOP_overlaps',DBOP_overlaps);
    AddConstant('DBOP_case_condition',DBOP_case_condition);
    AddConstant('DBOP_case_value',DBOP_case_value);
    AddConstant('DBOP_nullif',DBOP_nullif);
    AddConstant('DBOP_cast',DBOP_cast);
    AddConstant('DBOP_coalesce',DBOP_coalesce);
    AddConstant('DBOP_position',DBOP_position);
    AddConstant('DBOP_extract',DBOP_extract);
    AddConstant('DBOP_char_length',DBOP_char_length);
    AddConstant('DBOP_octet_length',DBOP_octet_length);
    AddConstant('DBOP_bit_length',DBOP_bit_length);
    AddConstant('DBOP_substring',DBOP_substring);
    AddConstant('DBOP_upper',DBOP_upper);
    AddConstant('DBOP_lower',DBOP_lower);
    AddConstant('DBOP_trim',DBOP_trim);
    AddConstant('DBOP_translate',DBOP_translate);
    AddConstant('DBOP_convert',DBOP_convert);
    AddConstant('DBOP_string_concat',DBOP_string_concat);
    AddConstant('DBOP_current_date',DBOP_current_date);
    AddConstant('DBOP_current_time',DBOP_current_time);
    AddConstant('DBOP_current_timestamp',DBOP_current_timestamp);
    AddConstant('DBOP_content_select',DBOP_content_select);
    AddConstant('DBOP_content',DBOP_content);
    AddConstant('DBOP_content_freetext',DBOP_content_freetext);
    AddConstant('DBOP_content_proximity',DBOP_content_proximity);
    AddConstant('DBOP_content_vector_or',DBOP_content_vector_or);
    AddConstant('DBOP_delete',DBOP_delete);
    AddConstant('DBOP_update',DBOP_update);
    AddConstant('DBOP_insert',DBOP_insert);
    AddConstant('DBOP_min',DBOP_min);
    AddConstant('DBOP_max',DBOP_max);
    AddConstant('DBOP_count',DBOP_count);
    AddConstant('DBOP_sum',DBOP_sum);
    AddConstant('DBOP_avg',DBOP_avg);
    AddConstant('DBOP_any_sample',DBOP_any_sample);
    AddConstant('DBOP_stddev',DBOP_stddev);
    AddConstant('DBOP_stddev_pop',DBOP_stddev_pop);
    AddConstant('DBOP_var',DBOP_var);
    AddConstant('DBOP_var_pop',DBOP_var_pop);
    AddConstant('DBOP_first',DBOP_first);
    AddConstant('DBOP_last',DBOP_last);
    AddConstant('DBOP_in',DBOP_in);
    AddConstant('DBOP_exists',DBOP_exists);
    AddConstant('DBOP_unique',DBOP_unique);
    AddConstant('DBOP_subset',DBOP_subset);
    AddConstant('DBOP_proper_subset',DBOP_proper_subset);
    AddConstant('DBOP_superset',DBOP_superset);
    AddConstant('DBOP_proper_superset',DBOP_proper_superset);
    AddConstant('DBOP_disjoint',DBOP_disjoint);
    AddConstant('DBOP_pass_through',DBOP_pass_through);
    AddConstant('DBOP_defined_by_GUID',DBOP_defined_by_GUID);
    AddConstant('DBOP_text_command',DBOP_text_command);
    AddConstant('DBOP_SQL_select',DBOP_SQL_select);
    AddConstant('DBOP_prior_command_tree',DBOP_prior_command_tree);
    AddConstant('DBOP_add_columns',DBOP_add_columns);
    AddConstant('DBOP_column_list_anchor',DBOP_column_list_anchor);
    AddConstant('DBOP_column_list_element',DBOP_column_list_element);
    AddConstant('DBOP_command_list_anchor',DBOP_command_list_anchor);
    AddConstant('DBOP_command_list_element',DBOP_command_list_element);
    AddConstant('DBOP_from_list_anchor',DBOP_from_list_anchor);
    AddConstant('DBOP_from_list_element',DBOP_from_list_element);
    AddConstant('DBOP_project_list_anchor',DBOP_project_list_anchor);
    AddConstant('DBOP_project_list_element',DBOP_project_list_element);
    AddConstant('DBOP_row_list_anchor',DBOP_row_list_anchor);
    AddConstant('DBOP_row_list_element',DBOP_row_list_element);
    AddConstant('DBOP_scalar_list_anchor',DBOP_scalar_list_anchor);
    AddConstant('DBOP_scalar_list_element',DBOP_scalar_list_element);
    AddConstant('DBOP_set_list_anchor',DBOP_set_list_anchor);
    AddConstant('DBOP_set_list_element',DBOP_set_list_element);
    AddConstant('DBOP_sort_list_anchor',DBOP_sort_list_anchor);
    AddConstant('DBOP_sort_list_element',DBOP_sort_list_element);
    AddConstant('DBOP_alter_character_set',DBOP_alter_character_set);
    AddConstant('DBOP_alter_collation',DBOP_alter_collation);
    AddConstant('DBOP_alter_domain',DBOP_alter_domain);
    AddConstant('DBOP_alter_index',DBOP_alter_index);
    AddConstant('DBOP_alter_procedure',DBOP_alter_procedure);
    AddConstant('DBOP_alter_schema',DBOP_alter_schema);
    AddConstant('DBOP_alter_table',DBOP_alter_table);
    AddConstant('DBOP_alter_trigger',DBOP_alter_trigger);
    AddConstant('DBOP_alter_view',DBOP_alter_view);
    AddConstant('DBOP_coldef_list_anchor',DBOP_coldef_list_anchor);
    AddConstant('DBOP_coldef_list_element',DBOP_coldef_list_element);
    AddConstant('DBOP_create_assertion',DBOP_create_assertion);
    AddConstant('DBOP_create_character_set',DBOP_create_character_set);
    AddConstant('DBOP_create_collation',DBOP_create_collation);
    AddConstant('DBOP_create_domain',DBOP_create_domain);
    AddConstant('DBOP_create_index',DBOP_create_index);
    AddConstant('DBOP_create_procedure',DBOP_create_procedure);
    AddConstant('DBOP_create_schema',DBOP_create_schema);
    AddConstant('DBOP_create_synonym',DBOP_create_synonym);
    AddConstant('DBOP_create_table',DBOP_create_table);
    AddConstant('DBOP_create_temporary_table',DBOP_create_temporary_table);
    AddConstant('DBOP_create_translation',DBOP_create_translation);
    AddConstant('DBOP_create_trigger',DBOP_create_trigger);
    AddConstant('DBOP_create_view',DBOP_create_view);
    AddConstant('DBOP_drop_assertion',DBOP_drop_assertion);
    AddConstant('DBOP_drop_character_set',DBOP_drop_character_set);
    AddConstant('DBOP_drop_collation',DBOP_drop_collation);
    AddConstant('DBOP_drop_domain',DBOP_drop_domain);
    AddConstant('DBOP_drop_index',DBOP_drop_index);
    AddConstant('DBOP_drop_procedure',DBOP_drop_procedure);
    AddConstant('DBOP_drop_schema',DBOP_drop_schema);
    AddConstant('DBOP_drop_synonym',DBOP_drop_synonym);
    AddConstant('DBOP_drop_table',DBOP_drop_table);
    AddConstant('DBOP_drop_translation',DBOP_drop_translation);
    AddConstant('DBOP_drop_trigger',DBOP_drop_trigger);
    AddConstant('DBOP_drop_view',DBOP_drop_view);
    AddConstant('DBOP_foreign_key',DBOP_foreign_key);
    AddConstant('DBOP_grant_privileges',DBOP_grant_privileges);
    AddConstant('DBOP_index_list_anchor',DBOP_index_list_anchor);
    AddConstant('DBOP_index_list_element',DBOP_index_list_element);
    AddConstant('DBOP_primary_key',DBOP_primary_key);
    AddConstant('DBOP_property_list_anchor',DBOP_property_list_anchor);
    AddConstant('DBOP_property_list_element',DBOP_property_list_element);
    AddConstant('DBOP_referenced_table',DBOP_referenced_table);
    AddConstant('DBOP_rename_object',DBOP_rename_object);
    AddConstant('DBOP_revoke_privileges',DBOP_revoke_privileges);
    AddConstant('DBOP_schema_authorization',DBOP_schema_authorization);
    AddConstant('DBOP_unique_key',DBOP_unique_key);
    AddConstant('DBPARAMFLAGS_ISINPUT',DBPARAMFLAGS_ISINPUT);
    AddConstant('DBPARAMFLAGS_ISOUTPUT',DBPARAMFLAGS_ISOUTPUT);
    AddConstant('DBPARAMFLAGS_ISSIGNED',DBPARAMFLAGS_ISSIGNED);
    AddConstant('DBPARAMFLAGS_ISNULLABLE',DBPARAMFLAGS_ISNULLABLE);
    AddConstant('DBPARAMFLAGS_ISLONG',DBPARAMFLAGS_ISLONG);
    AddConstant('DBPARAMFLAGS_SCALEISNEGATIVE',DBPARAMFLAGS_SCALEISNEGATIVE);
    AddConstant('DBPROPFLAGS_NOTSUPPORTED',DBPROPFLAGS_NOTSUPPORTED);
    AddConstant('DBPROPFLAGS_COLUMN',DBPROPFLAGS_COLUMN);
    AddConstant('DBPROPFLAGS_DATASOURCE',DBPROPFLAGS_DATASOURCE);
    AddConstant('DBPROPFLAGS_DATASOURCECREATE',DBPROPFLAGS_DATASOURCECREATE);
    AddConstant('DBPROPFLAGS_DATASOURCEINFO',DBPROPFLAGS_DATASOURCEINFO);
    AddConstant('DBPROPFLAGS_DBINIT',DBPROPFLAGS_DBINIT);
    AddConstant('DBPROPFLAGS_INDEX',DBPROPFLAGS_INDEX);
    AddConstant('DBPROPFLAGS_ROWSET',DBPROPFLAGS_ROWSET);
    AddConstant('DBPROPFLAGS_TABLE',DBPROPFLAGS_TABLE);
    AddConstant('DBPROPFLAGS_COLUMNOK',DBPROPFLAGS_COLUMNOK);
    AddConstant('DBPROPFLAGS_READ',DBPROPFLAGS_READ);
    AddConstant('DBPROPFLAGS_WRITE',DBPROPFLAGS_WRITE);
    AddConstant('DBPROPFLAGS_REQUIRED',DBPROPFLAGS_REQUIRED);
    AddConstant('DBPROPFLAGS_SESSION',DBPROPFLAGS_SESSION);
    AddConstant('DBPROPFLAGS_TRUSTEE',DBPROPFLAGS_TRUSTEE);
    AddConstant('DBPROPOPTIONS_REQUIRED',DBPROPOPTIONS_REQUIRED);
    AddConstant('DBPROPOPTIONS_SETIFCHEAP',DBPROPOPTIONS_SETIFCHEAP);
    AddConstant('DBPROPOPTIONS_OPTIONAL',DBPROPOPTIONS_OPTIONAL);
    AddConstant('DBPROPSTATUS_OK',DBPROPSTATUS_OK);
    AddConstant('DBPROPSTATUS_NOTSUPPORTED',DBPROPSTATUS_NOTSUPPORTED);
    AddConstant('DBPROPSTATUS_BADVALUE',DBPROPSTATUS_BADVALUE);
    AddConstant('DBPROPSTATUS_BADOPTION',DBPROPSTATUS_BADOPTION);
    AddConstant('DBPROPSTATUS_BADCOLUMN',DBPROPSTATUS_BADCOLUMN);
    AddConstant('DBPROPSTATUS_NOTALLSETTABLE',DBPROPSTATUS_NOTALLSETTABLE);
    AddConstant('DBPROPSTATUS_NOTSETTABLE',DBPROPSTATUS_NOTSETTABLE);
    AddConstant('DBPROPSTATUS_NOTSET',DBPROPSTATUS_NOTSET);
    AddConstant('DBPROPSTATUS_CONFLICTING',DBPROPSTATUS_CONFLICTING);
    AddConstant('DBPROPSTATUS_NOTAVAILAVLE',DBPROPSTATUS_NOTAVAILAVLE);
    AddConstant('DBINDEX_COL_ORDER_ASC',DBINDEX_COL_ORDER_ASC);
    AddConstant('DBINDEX_COL_ORDER_DESC',DBINDEX_COL_ORDER_DESC);
    AddConstant('DBCOLUMNDESCFLAGS_TYPENAME',DBCOLUMNDESCFLAGS_TYPENAME);
    AddConstant('DBCOLUMNDESCFLAGS_ITYPEINFO',DBCOLUMNDESCFLAGS_ITYPEINFO);
    AddConstant('DBCOLUMNDESCFLAGS_PROPERTIES',DBCOLUMNDESCFLAGS_PROPERTIES);
    AddConstant('DBCOLUMNDESCFLAGS_CLSID',DBCOLUMNDESCFLAGS_CLSID);
    AddConstant('DBCOLUMNDESCFLAGS_COLSIZE',DBCOLUMNDESCFLAGS_COLSIZE);
    AddConstant('DBCOLUMNDESCFLAGS_DBCID',DBCOLUMNDESCFLAGS_DBCID);
    AddConstant('DBCOLUMNDESCFLAGS_WTYPE',DBCOLUMNDESCFLAGS_WTYPE);
    AddConstant('DBCOLUMNDESCFLAGS_PRECISION',DBCOLUMNDESCFLAGS_PRECISION);
    AddConstant('DBCOLUMNDESCFLAGS_SCALE',DBCOLUMNDESCFLAGS_SCALE);
    AddConstant('DBEVENTPHASE_OKTODO',DBEVENTPHASE_OKTODO);
    AddConstant('DBEVENTPHASE_ABOUTTODO',DBEVENTPHASE_ABOUTTODO);
    AddConstant('DBEVENTPHASE_SYNCHAFTER',DBEVENTPHASE_SYNCHAFTER);
    AddConstant('DBEVENTPHASE_FAILEDTODO',DBEVENTPHASE_FAILEDTODO);
    AddConstant('DBEVENTPHASE_DIDEVENT',DBEVENTPHASE_DIDEVENT);
    AddConstant('DBREASON_ROWSET_FETCHPOSITIONCHANGE',DBREASON_ROWSET_FETCHPOSITIONCHANGE);
    AddConstant('DBREASON_ROWSET_RELEASE',DBREASON_ROWSET_RELEASE);
    AddConstant('DBREASON_COLUMN_SET',DBREASON_COLUMN_SET);
    AddConstant('DBREASON_COLUMN_RECALCULATED',DBREASON_COLUMN_RECALCULATED);
    AddConstant('DBREASON_ROW_ACTIVATE',DBREASON_ROW_ACTIVATE);
    AddConstant('DBREASON_ROW_RELEASE',DBREASON_ROW_RELEASE);
    AddConstant('DBREASON_ROW_DELETE',DBREASON_ROW_DELETE);
    AddConstant('DBREASON_ROW_FIRSTCHANGE',DBREASON_ROW_FIRSTCHANGE);
    AddConstant('DBREASON_ROW_INSERT',DBREASON_ROW_INSERT);
    AddConstant('DBREASON_ROW_RESYNCH',DBREASON_ROW_RESYNCH);
    AddConstant('DBREASON_ROW_UNDOCHANGE',DBREASON_ROW_UNDOCHANGE);
    AddConstant('DBREASON_ROW_UNDOINSERT',DBREASON_ROW_UNDOINSERT);
    AddConstant('DBREASON_ROW_UNDODELETE',DBREASON_ROW_UNDODELETE);
    AddConstant('DBREASON_ROW_UPDATE',DBREASON_ROW_UPDATE);
    AddConstant('DBREASON_ROWSET_CHANGED',DBREASON_ROWSET_CHANGED);
    AddConstant('DBREASON_ROWPOSITION_CHANGED',DBREASON_ROWPOSITION_CHANGED);
    AddConstant('DBREASON_ROWPOSITION_CHAPTERCHANGED',DBREASON_ROWPOSITION_CHAPTERCHANGED);
    AddConstant('DBREASON_ROWPOSITION_CLEARED',DBREASON_ROWPOSITION_CLEARED);
    AddConstant('DBREASON_ROW_ASYNCHINSERT',DBREASON_ROW_ASYNCHINSERT);
    AddConstant('DBREASON_ROWSET_ROWSADDED',DBREASON_ROWSET_ROWSADDED);
    AddConstant('DBREASON_ROWSET_POPULATIONCOMPLETE',DBREASON_ROWSET_POPULATIONCOMPLETE);
    AddConstant('DBREASON_ROWSET_POPULATIONSTOPPED',DBREASON_ROWSET_POPULATIONSTOPPED);
    AddConstant('DBCOMPAREOPS_LT',DBCOMPAREOPS_LT);
    AddConstant('DBCOMPAREOPS_LE',DBCOMPAREOPS_LE);
    AddConstant('DBCOMPAREOPS_EQ',DBCOMPAREOPS_EQ);
    AddConstant('DBCOMPAREOPS_GE',DBCOMPAREOPS_GE);
    AddConstant('DBCOMPAREOPS_GT',DBCOMPAREOPS_GT);
    AddConstant('DBCOMPAREOPS_BEGINSWITH',DBCOMPAREOPS_BEGINSWITH);
    AddConstant('DBCOMPAREOPS_CONTAINS',DBCOMPAREOPS_CONTAINS);
    AddConstant('DBCOMPAREOPS_NE',DBCOMPAREOPS_NE);
    AddConstant('DBCOMPAREOPS_IGNORE',DBCOMPAREOPS_IGNORE);
    AddConstant('DBCOMPAREOPS_CASESENSITIVE',DBCOMPAREOPS_CASESENSITIVE);
    AddConstant('DBCOMPAREOPS_CASEINSENSITIVE',DBCOMPAREOPS_CASEINSENSITIVE);
    AddConstant('DBCOMPAREOPS_NOTBEGINSWITH',DBCOMPAREOPS_NOTBEGINSWITH);
    AddConstant('DBCOMPAREOPS_NOTCONTAINS',DBCOMPAREOPS_NOTCONTAINS);
    AddConstant('DBASYNCHOP_OPEN',DBASYNCHOP_OPEN);
    AddConstant('DBASYNCHPHASE_INITIALIZATION',DBASYNCHPHASE_INITIALIZATION);
    AddConstant('DBASYNCHPHASE_POPULATION',DBASYNCHPHASE_POPULATION);
    AddConstant('DBASYNCHPHASE_COMPLETE',DBASYNCHPHASE_COMPLETE);
    AddConstant('DBASYNCHPHASE_CANCELED',DBASYNCHPHASE_CANCELED);
    AddConstant('DBSORT_ASCENDING',DBSORT_ASCENDING);
    AddConstant('DBSORT_DESCENDING',DBSORT_DESCENDING);
    AddConstant('DBACCESSOR_INVALID',DBACCESSOR_INVALID);
    AddConstant('DBACCESSOR_PASSBYREF',DBACCESSOR_PASSBYREF);
    AddConstant('DBACCESSOR_ROWDATA',DBACCESSOR_ROWDATA);
    AddConstant('DBACCESSOR_PARAMETERDATA',DBACCESSOR_PARAMETERDATA);
    AddConstant('DBACCESSOR_OPTIMIZED',DBACCESSOR_OPTIMIZED);
    AddConstant('DBACCESSOR_INHERITED',DBACCESSOR_INHERITED);
    AddConstant('DBBINDSTATUS_OK',DBBINDSTATUS_OK);
    AddConstant('DBBINDSTATUS_BADORDINAL',DBBINDSTATUS_BADORDINAL);
    AddConstant('DBBINDSTATUS_UNSUPPORTEDCONVERSION',DBBINDSTATUS_UNSUPPORTEDCONVERSION);
    AddConstant('DBBINDSTATUS_BADBINDINFO',DBBINDSTATUS_BADBINDINFO);
    AddConstant('DBBINDSTATUS_BADSTORAGEFLAGS',DBBINDSTATUS_BADSTORAGEFLAGS);
    AddConstant('DBBINDSTATUS_NOINTERFACE',DBBINDSTATUS_NOINTERFACE);
    AddConstant('DBBINDSTATUS_MULTIPLESTORAGE',DBBINDSTATUS_MULTIPLESTORAGE);
    AddConstant('DBCOMPARE_LT',DBCOMPARE_LT);
    AddConstant('DBCOMPARE_EQ',DBCOMPARE_EQ);
    AddConstant('DBCOMPARE_GT',DBCOMPARE_GT);
    AddConstant('DBCOMPARE_NE',DBCOMPARE_NE);
    AddConstant('DBCOMPARE_NOTCOMPARABLE',DBCOMPARE_NOTCOMPARABLE);
    AddConstant('DBPOSITION_OK',DBPOSITION_OK);
    AddConstant('DBPOSITION_NOROW',DBPOSITION_NOROW);
    AddConstant('DBPOSITION_BOF',DBPOSITION_BOF);
    AddConstant('DBPOSITION_EOF',DBPOSITION_EOF);
    AddConstant('DBPENDINGSTATUS_NEW',DBPENDINGSTATUS_NEW);
    AddConstant('DBPENDINGSTATUS_CHANGED',DBPENDINGSTATUS_CHANGED);
    AddConstant('DBPENDINGSTATUS_DELETED',DBPENDINGSTATUS_DELETED);
    AddConstant('DBPENDINGSTATUS_UNCHANGED',DBPENDINGSTATUS_UNCHANGED);
    AddConstant('DBPENDINGSTATUS_INVALIDROW',DBPENDINGSTATUS_INVALIDROW);
    AddConstant('DBSEEK_INVALID',DBSEEK_INVALID);
    AddConstant('DBSEEK_FIRSTEQ',DBSEEK_FIRSTEQ);
    AddConstant('DBSEEK_LASTEQ',DBSEEK_LASTEQ);
    AddConstant('DBSEEK_GE',DBSEEK_GE);
    AddConstant('DBSEEK_GT',DBSEEK_GT);
    AddConstant('DBSEEK_LE',DBSEEK_LE);
    AddConstant('DBSEEK_LT',DBSEEK_LT);
    AddConstant('DBRANGE_INCLUSIVESTART',DBRANGE_INCLUSIVESTART);
    AddConstant('DBRANGE_INCLUSIVEEND',DBRANGE_INCLUSIVEEND);
    AddConstant('DBRANGE_EXCLUSIVESTART',DBRANGE_EXCLUSIVESTART);
    AddConstant('DBRANGE_EXCLUSIVEEND',DBRANGE_EXCLUSIVEEND);
    AddConstant('DBRANGE_EXCLUDENULLS',DBRANGE_EXCLUDENULLS);
    AddConstant('DBRANGE_PREFIX',DBRANGE_PREFIX);
    AddConstant('DBRANGE_MATCH',DBRANGE_MATCH);
    AddConstant('DBRANGE_MATCH_N_SHIFT',DBRANGE_MATCH_N_SHIFT);
    AddConstant('DBRANGE_MATCH_N_MASK',DBRANGE_MATCH_N_MASK);
    AddConstant('DBWATCHNOTIFY_ROWSCHANGED',DBWATCHNOTIFY_ROWSCHANGED);
    AddConstant('DBWATCHNOTIFY_QUERYDONE',DBWATCHNOTIFY_QUERYDONE);
    AddConstant('DBWATCHNOTIFY_QUERYREEXECUTED',DBWATCHNOTIFY_QUERYREEXECUTED);
    AddConstant('DBWATCHMODE_ALL',DBWATCHMODE_ALL);
    AddConstant('DBWATCHMODE_EXTEND',DBWATCHMODE_EXTEND);
    AddConstant('DBWATCHMODE_MOVE',DBWATCHMODE_MOVE);
    AddConstant('DBWATCHMODE_COUNT',DBWATCHMODE_COUNT);
    AddConstant('DBROWCHANGEKIND_INSERT',DBROWCHANGEKIND_INSERT);
    AddConstant('DBROWCHANGEKIND_DELETE',DBROWCHANGEKIND_DELETE);
    AddConstant('DBROWCHANGEKIND_UPDATE',DBROWCHANGEKIND_UPDATE);
    AddConstant('DBROWCHANGEKIND_COUNT',DBROWCHANGEKIND_COUNT);
    AddConstant('DBCONVERTFLAGS_COLUMN',DBCONVERTFLAGS_COLUMN);
    AddConstant('DBCONVERTFLAGS_PARAMETER',DBCONVERTFLAGS_PARAMETER);
    AddConstant('DBCONVERTFLAGS_ISLONG',DBCONVERTFLAGS_ISLONG);
    AddConstant('DBCONVERTFLAGS_ISFIXEDLENGTH',DBCONVERTFLAGS_ISFIXEDLENGTH);
    AddConstant('DBCONVERTFLAGS_FROMVARIANT',DBCONVERTFLAGS_FROMVARIANT);
    AddConstant('DBRESOURCE_INVALID',DBRESOURCE_INVALID);
    AddConstant('DBRESOURCE_TOTAL',DBRESOURCE_TOTAL);
    AddConstant('DBRESOURCE_CPU',DBRESOURCE_CPU);
    AddConstant('DBRESOURCE_MEMORY',DBRESOURCE_MEMORY);
    AddConstant('DBRESOURCE_DISK',DBRESOURCE_DISK);
    AddConstant('DBRESOURCE_NETWORK',DBRESOURCE_NETWORK);
    AddConstant('DBRESOURCE_RESPONSE',DBRESOURCE_RESPONSE);
    AddConstant('DBRESOURCE_ROWS',DBRESOURCE_ROWS);
    AddConstant('DBRESOURCE_OTHER',DBRESOURCE_OTHER);
    AddConstant('DBUNIT_INVALID',DBUNIT_INVALID);
    AddConstant('DBUNIT_WEIGHT',DBUNIT_WEIGHT);
    AddConstant('DBUNIT_PERCENT',DBUNIT_PERCENT);
    AddConstant('DBUNIT_MAXIMUM',DBUNIT_MAXIMUM);
    AddConstant('DBUNIT_MINIMUM',DBUNIT_MINIMUM);
    AddConstant('DBUNIT_MICRO_SECOND',DBUNIT_MICRO_SECOND);
    AddConstant('DBUNIT_MILLI_SECOND',DBUNIT_MILLI_SECOND);
    AddConstant('DBUNIT_SECOND',DBUNIT_SECOND);
    AddConstant('DBUNIT_MINUTE',DBUNIT_MINUTE);
    AddConstant('DBUNIT_HOUR',DBUNIT_HOUR);
    AddConstant('DBUNIT_BYTE',DBUNIT_BYTE);
    AddConstant('DBUNIT_KILO_BYTE',DBUNIT_KILO_BYTE);
    AddConstant('DBUNIT_MEGA_BYTE',DBUNIT_MEGA_BYTE);
    AddConstant('DBUNIT_GIGA_BYTE',DBUNIT_GIGA_BYTE);
    AddConstant('DBUNIT_NUM_MSGS',DBUNIT_NUM_MSGS);
    AddConstant('DBUNIT_NUM_LOCKS',DBUNIT_NUM_LOCKS);
    AddConstant('DBUNIT_NUM_ROWS',DBUNIT_NUM_ROWS);
    AddConstant('DBUNIT_OTHER',DBUNIT_OTHER);
    AddConstant('DBEXECLIMITS_ABORT',DBEXECLIMITS_ABORT);
    AddConstant('DBEXECLIMITS_STOP',DBEXECLIMITS_STOP);
    AddConstant('DBEXECLIMITS_SUSPEND',DBEXECLIMITS_SUSPEND);
    AddConstant('DBCOMMANDREUSE_NONE',DBCOMMANDREUSE_NONE);
    AddConstant('DBCOMMANDREUSE_PROPERTIES',DBCOMMANDREUSE_PROPERTIES);
    AddConstant('DBCOMMANDREUSE_PARAMETERS',DBCOMMANDREUSE_PARAMETERS);
    AddConstant('DBVALUEKIND_BYGUID',DBVALUEKIND_BYGUID);
    AddConstant('DBVALUEKIND_COLDESC',DBVALUEKIND_COLDESC);
    AddConstant('DBVALUEKIND_ID',DBVALUEKIND_ID);
    AddConstant('DBVALUEKIND_CONTENT',DBVALUEKIND_CONTENT);
    AddConstant('DBVALUEKIND_CONTENTVECTOR',DBVALUEKIND_CONTENTVECTOR);
    AddConstant('DBVALUEKIND_GROUPINFO',DBVALUEKIND_GROUPINFO);
    AddConstant('DBVALUEKIND_PARAMETER',DBVALUEKIND_PARAMETER);
    AddConstant('DBVALUEKIND_PROPERTY',DBVALUEKIND_PROPERTY);
    AddConstant('DBVALUEKIND_SETFUNC',DBVALUEKIND_SETFUNC);
    AddConstant('DBVALUEKIND_SORTINFO',DBVALUEKIND_SORTINFO);
    AddConstant('DBVALUEKIND_TEXT',DBVALUEKIND_TEXT);
    AddConstant('DBVALUEKIND_COMMAND',DBVALUEKIND_COMMAND);
    AddConstant('DBVALUEKIND_MONIKER',DBVALUEKIND_MONIKER);
    AddConstant('DBVALUEKIND_ROWSET',DBVALUEKIND_ROWSET);
    AddConstant('DBVALUEKIND_LIKE',DBVALUEKIND_LIKE);
    AddConstant('DBVALUEKIND_CONTENTPROXIMITY',DBVALUEKIND_CONTENTPROXIMITY);
    AddConstant('DBVALUEKIND_IDISPATCH',DBVALUEKIND_IDISPATCH);
    AddConstant('DBVALUEKIND_IUNKNOWN',DBVALUEKIND_IUNKNOWN);
    AddConstant('DBVALUEKIND_EMPTY',DBVALUEKIND_EMPTY);
    AddConstant('DBVALUEKIND_NULL',DBVALUEKIND_NULL);
    AddConstant('DBVALUEKIND_I2',DBVALUEKIND_I2);
    AddConstant('DBVALUEKIND_I4',DBVALUEKIND_I4);
    AddConstant('DBVALUEKIND_R4',DBVALUEKIND_R4);
    AddConstant('DBVALUEKIND_R8',DBVALUEKIND_R8);
    AddConstant('DBVALUEKIND_CY',DBVALUEKIND_CY);
    AddConstant('DBVALUEKIND_DATE',DBVALUEKIND_DATE);
    AddConstant('DBVALUEKIND_BSTR',DBVALUEKIND_BSTR);
    AddConstant('DBVALUEKIND_ERROR',DBVALUEKIND_ERROR);
    AddConstant('DBVALUEKIND_BOOL',DBVALUEKIND_BOOL);
    AddConstant('DBVALUEKIND_VARIANT',DBVALUEKIND_VARIANT);
    AddConstant('DBVALUEKIND_VECTOR',DBVALUEKIND_VECTOR);
    AddConstant('DBVALUEKIND_ARRAY',DBVALUEKIND_ARRAY);
    AddConstant('DBVALUEKIND_BYREF',DBVALUEKIND_BYREF);
    AddConstant('DBVALUEKIND_I1',DBVALUEKIND_I1);
    AddConstant('DBVALUEKIND_UI1',DBVALUEKIND_UI1);
    AddConstant('DBVALUEKIND_UI2',DBVALUEKIND_UI2);
    AddConstant('DBVALUEKIND_UI4',DBVALUEKIND_UI4);
    AddConstant('DBVALUEKIND_I8',DBVALUEKIND_I8);
    AddConstant('DBVALUEKIND_UI8',DBVALUEKIND_UI8);
    AddConstant('DBVALUEKIND_GUID',DBVALUEKIND_GUID);
    AddConstant('DBVALUEKIND_BYTES',DBVALUEKIND_BYTES);
    AddConstant('DBVALUEKIND_STR',DBVALUEKIND_STR);
    AddConstant('DBVALUEKIND_WSTR',DBVALUEKIND_WSTR);
    AddConstant('DBVALUEKIND_NUMERIC',DBVALUEKIND_NUMERIC);
    AddConstant('DBVALUEKIND_DBDATE',DBVALUEKIND_DBDATE);
    AddConstant('DBVALUEKIND_DBTIME',DBVALUEKIND_DBTIME);
    AddConstant('DBVALUEKIND_DBTIMESTAMP',DBVALUEKIND_DBTIMESTAMP);
    AddConstant('DBSOURCETYPE_DATASOURCE',DBSOURCETYPE_DATASOURCE);
    AddConstant('DBSOURCETYPE_ENUMERATOR',DBSOURCETYPE_ENUMERATOR);
    AddConstant('DBSOURCETYPE_DATASOURCE_TDP',DBSOURCETYPE_DATASOURCE_TDP);
    AddConstant('DBSOURCETYPE_DATASOURCE_MDP',DBSOURCETYPE_DATASOURCE_MDP);
    AddConstant('DBLITERAL_INVALID',DBLITERAL_INVALID);
    AddConstant('DBLITERAL_BINARY_LITERAL',DBLITERAL_BINARY_LITERAL);
    AddConstant('DBLITERAL_CATALOG_NAME',DBLITERAL_CATALOG_NAME);
    AddConstant('DBLITERAL_CATALOG_SEPARATOR',DBLITERAL_CATALOG_SEPARATOR);
    AddConstant('DBLITERAL_CHAR_LITERAL',DBLITERAL_CHAR_LITERAL);
    AddConstant('DBLITERAL_COLUMN_ALIAS',DBLITERAL_COLUMN_ALIAS);
    AddConstant('DBLITERAL_COLUMN_NAME',DBLITERAL_COLUMN_NAME);
    AddConstant('DBLITERAL_CORRELATION_NAME',DBLITERAL_CORRELATION_NAME);
    AddConstant('DBLITERAL_CURSOR_NAME',DBLITERAL_CURSOR_NAME);
    AddConstant('DBLITERAL_ESCAPE_PERCENT',DBLITERAL_ESCAPE_PERCENT);
    AddConstant('DBLITERAL_ESCAPE_UNDERSCORE',DBLITERAL_ESCAPE_UNDERSCORE);
    AddConstant('DBLITERAL_INDEX_NAME',DBLITERAL_INDEX_NAME);
    AddConstant('DBLITERAL_LIKE_PERCENT',DBLITERAL_LIKE_PERCENT);
    AddConstant('DBLITERAL_LIKE_UNDERSCORE',DBLITERAL_LIKE_UNDERSCORE);
    AddConstant('DBLITERAL_PROCEDURE_NAME',DBLITERAL_PROCEDURE_NAME);
    AddConstant('DBLITERAL_QUOTE',DBLITERAL_QUOTE);
    AddConstant('DBLITERAL_SCHEMA_NAME',DBLITERAL_SCHEMA_NAME);
    AddConstant('DBLITERAL_TABLE_NAME',DBLITERAL_TABLE_NAME);
    AddConstant('DBLITERAL_TEXT_COMMAND',DBLITERAL_TEXT_COMMAND);
    AddConstant('DBLITERAL_USER_NAME',DBLITERAL_USER_NAME);
    AddConstant('DBLITERAL_VIEW_NAME',DBLITERAL_VIEW_NAME);
    AddConstant('DBLITERAL_CUBE_NAME',DBLITERAL_CUBE_NAME);
    AddConstant('DBLITERAL_DIMENSION_NAME',DBLITERAL_DIMENSION_NAME);
    AddConstant('DBLITERAL_HIERARCHY_NAME',DBLITERAL_HIERARCHY_NAME);
    AddConstant('DBLITERAL_LEVEL_NAME',DBLITERAL_LEVEL_NAME);
    AddConstant('DBLITERAL_MEMBER_NAME',DBLITERAL_MEMBER_NAME);
    AddConstant('DBLITERAL_PROPERTY_NAME',DBLITERAL_PROPERTY_NAME);
    AddConstant('DBLITERAL_SCHEMA_SEPARATOR',DBLITERAL_SCHEMA_SEPARATOR);
    AddConstant('DBLITERAL_QUOTE_SUFFIX',DBLITERAL_QUOTE_SUFFIX);
    AddConstant('PERM_EXCLUSIVE',PERM_EXCLUSIVE);
    AddConstant('PERM_READDESIGN',PERM_READDESIGN);
    AddConstant('PERM_WRITEDESIGN',PERM_WRITEDESIGN);
    AddConstant('PERM_WITHGRANT',PERM_WITHGRANT);
    AddConstant('PERM_REFERENCE',PERM_REFERENCE);
    AddConstant('PERM_CREATE',PERM_CREATE);
    AddConstant('PERM_INSERT',PERM_INSERT);
    AddConstant('PERM_DELETE',PERM_DELETE);
    AddConstant('PERM_READCONTROL',PERM_READCONTROL);
    AddConstant('PERM_WRITEPERMISSIONS',PERM_WRITEPERMISSIONS);
    AddConstant('PERM_WRITEOWNER',PERM_WRITEOWNER);
    AddConstant('PERM_MAXIMUM_ALLOWED',PERM_MAXIMUM_ALLOWED);
    AddConstant('PERM_ALL',PERM_ALL);
    AddConstant('PERM_EXECUTE',PERM_EXECUTE);
    AddConstant('PERM_READ',PERM_READ);
    AddConstant('PERM_UPDATE',PERM_UPDATE);
    AddConstant('PERM_DROP',PERM_DROP);
    AddConstant('NO_MULTIPLE_TRUSTEE',NO_MULTIPLE_TRUSTEE);
    AddConstant('TRUSTEE_IS_IMPERSONATE',TRUSTEE_IS_IMPERSONATE);
    AddConstant('TRUSTEE_IS_SID',TRUSTEE_IS_SID);
    AddConstant('TRUSTEE_IS_NAME',TRUSTEE_IS_NAME);
    AddConstant('TRUSTEE_BAD_FORM',TRUSTEE_BAD_FORM);
    AddConstant('TRUSTEE_IS_UNKNOWN',TRUSTEE_IS_UNKNOWN);
    AddConstant('TRUSTEE_IS_USER',TRUSTEE_IS_USER);
    AddConstant('TRUSTEE_IS_GROUP',TRUSTEE_IS_GROUP);
    AddConstant('TRUSTEE_IS_DOMAIN',TRUSTEE_IS_DOMAIN);
    AddConstant('TRUSTEE_IS_ALIAS',TRUSTEE_IS_ALIAS);
    AddConstant('TRUSTEE_IS_WELL_KNOWN_GROUP',TRUSTEE_IS_WELL_KNOWN_GROUP);
    AddConstant('TRUSTEE_IS_DELETED',TRUSTEE_IS_DELETED);
    AddConstant('TRUSTEE_IS_INVALID',TRUSTEE_IS_INVALID);
    AddConstant('NOT_USED_ACCESS',NOT_USED_ACCESS);
    AddConstant('GRANT_ACCESS',GRANT_ACCESS);
    AddConstant('SET_ACCESS',SET_ACCESS);
    AddConstant('DENY_ACCESS',DENY_ACCESS);
    AddConstant('REVOKE_ACCESS',REVOKE_ACCESS);
    AddConstant('SET_AUDIT_SUCCESS',SET_AUDIT_SUCCESS);
    AddConstant('SET_AUDIT_FAILURE',SET_AUDIT_FAILURE);
    AddConstant('DBPROMPTOPTIONS_NONE',DBPROMPTOPTIONS_NONE);
    AddConstant('DBPROMPTOPTIONS_WIZARDSHEET',DBPROMPTOPTIONS_WIZARDSHEET);
    AddConstant('DBPROMPTOPTIONS_PROPERTYSHEET',DBPROMPTOPTIONS_PROPERTYSHEET);
    AddConstant('DBPROMPTOPTIONS_BROWSEONLY',DBPROMPTOPTIONS_BROWSEONLY);
    AddConstant('DBPROMPTOPTIONS_DISABLE_PROVIDER_SELECTION',DBPROMPTOPTIONS_DISABLE_PROVIDER_SELECTION);
    AddConstant('FACILITY_WINDOWS',FACILITY_WINDOWS);
    AddConstant('FACILITY_ITF',FACILITY_ITF);
    AddConstant('STATUS_SEVERITY_SUCCESS',STATUS_SEVERITY_SUCCESS);
    AddConstant('STATUS_SEVERITY_COERROR',STATUS_SEVERITY_COERROR);
    AddConstant('DB_E_BOGUS',DB_E_BOGUS);
    AddConstant('DB_E_BADACCESSORHANDLE',DB_E_BADACCESSORHANDLE);
    AddConstant('DB_E_ROWLIMITEXCEEDED',DB_E_ROWLIMITEXCEEDED);
    AddConstant('DB_E_READONLYACCESSOR',DB_E_READONLYACCESSOR);
    AddConstant('DB_E_SCHEMAVIOLATION',DB_E_SCHEMAVIOLATION);
    AddConstant('DB_E_BADROWHANDLE',DB_E_BADROWHANDLE);
    AddConstant('DB_E_OBJECTOPEN',DB_E_OBJECTOPEN);
    AddConstant('DB_E_BADCHAPTER',DB_E_BADCHAPTER);
    AddConstant('DB_E_CANTCONVERTVALUE',DB_E_CANTCONVERTVALUE);
    AddConstant('DB_E_BADBINDINFO',DB_E_BADBINDINFO);
    AddConstant('DB_SEC_E_PERMISSIONDENIED',DB_SEC_E_PERMISSIONDENIED);
    AddConstant('DB_E_NOTAREFERENCECOLUMN',DB_E_NOTAREFERENCECOLUMN);
    AddConstant('DB_E_LIMITREJECTED',DB_E_LIMITREJECTED);
    AddConstant('DB_E_NOCOMMAND',DB_E_NOCOMMAND);
    AddConstant('DB_E_COSTLIMIT',DB_E_COSTLIMIT);
    AddConstant('DB_E_BADBOOKMARK',DB_E_BADBOOKMARK);
    AddConstant('DB_E_BADLOCKMODE',DB_E_BADLOCKMODE);
    AddConstant('DB_E_PARAMNOTOPTIONAL',DB_E_PARAMNOTOPTIONAL);
    AddConstant('DB_E_BADCOLUMNID',DB_E_BADCOLUMNID);
    AddConstant('DB_E_BADRATIO',DB_E_BADRATIO);
    AddConstant('DB_E_BADVALUES',DB_E_BADVALUES);
    AddConstant('DB_E_ERRORSINCOMMAND',DB_E_ERRORSINCOMMAND);
    AddConstant('DB_E_CANTCANCEL',DB_E_CANTCANCEL);
    AddConstant('DB_E_DIALECTNOTSUPPORTED',DB_E_DIALECTNOTSUPPORTED);
    AddConstant('DB_E_DUPLICATEDATASOURCE',DB_E_DUPLICATEDATASOURCE);
    AddConstant('DB_E_CANNOTRESTART',DB_E_CANNOTRESTART);
    AddConstant('DB_E_NOTFOUND',DB_E_NOTFOUND);
    AddConstant('DB_E_NEWLYINSERTED',DB_E_NEWLYINSERTED);
    AddConstant('DB_E_CANNOTFREE',DB_E_CANNOTFREE);
    AddConstant('DB_E_GOALREJECTED',DB_E_GOALREJECTED);
    AddConstant('DB_E_UNSUPPORTEDCONVERSION',DB_E_UNSUPPORTEDCONVERSION);
    AddConstant('DB_E_BADSTARTPOSITION',DB_E_BADSTARTPOSITION);
    AddConstant('DB_E_NOQUERY',DB_E_NOQUERY);
    AddConstant('DB_E_NOTREENTRANT',DB_E_NOTREENTRANT);
    AddConstant('DB_E_ERRORSOCCURRED',DB_E_ERRORSOCCURRED);
    AddConstant('DB_E_NOAGGREGATION',DB_E_NOAGGREGATION);
    AddConstant('DB_E_DELETEDROW',DB_E_DELETEDROW);
    AddConstant('DB_E_CANTFETCHBACKWARDS',DB_E_CANTFETCHBACKWARDS);
    AddConstant('DB_E_ROWSNOTRELEASED',DB_E_ROWSNOTRELEASED);
    AddConstant('DB_E_BADSTORAGEFLAG',DB_E_BADSTORAGEFLAG);
    AddConstant('DB_E_BADCOMPAREOP',DB_E_BADCOMPAREOP);
    AddConstant('DB_E_BADSTATUSVALUE',DB_E_BADSTATUSVALUE);
    AddConstant('DB_E_CANTSCROLLBACKWARDS',DB_E_CANTSCROLLBACKWARDS);
    AddConstant('DB_E_BADREGIONHANDLE',DB_E_BADREGIONHANDLE);
    AddConstant('DB_E_NONCONTIGUOUSRANGE',DB_E_NONCONTIGUOUSRANGE);
    AddConstant('DB_E_INVALIDTRANSITION',DB_E_INVALIDTRANSITION);
    AddConstant('DB_E_NOTASUBREGION',DB_E_NOTASUBREGION);
    AddConstant('DB_E_MULTIPLESTATEMENTS',DB_E_MULTIPLESTATEMENTS);
    AddConstant('DB_E_INTEGRITYVIOLATION',DB_E_INTEGRITYVIOLATION);
    AddConstant('DB_E_BADTYPENAME',DB_E_BADTYPENAME);
    AddConstant('DB_E_ABORTLIMITREACHED',DB_E_ABORTLIMITREACHED);
    AddConstant('DB_E_ROWSETINCOMMAND',DB_E_ROWSETINCOMMAND);
    AddConstant('DB_E_CANTTRANSLATE',DB_E_CANTTRANSLATE);
    AddConstant('DB_E_DUPLICATEINDEXID',DB_E_DUPLICATEINDEXID);
    AddConstant('DB_E_NOINDEX',DB_E_NOINDEX);
    AddConstant('DB_E_INDEXINUSE',DB_E_INDEXINUSE);
    AddConstant('DB_E_NOTABLE',DB_E_NOTABLE);
    AddConstant('DB_E_CONCURRENCYVIOLATION',DB_E_CONCURRENCYVIOLATION);
    AddConstant('DB_E_BADCOPY',DB_E_BADCOPY);
    AddConstant('DB_E_BADPRECISION',DB_E_BADPRECISION);
    AddConstant('DB_E_BADSCALE',DB_E_BADSCALE);
    AddConstant('DB_E_BADTABLEID',DB_E_BADTABLEID);
    AddConstant('DB_E_BADID',DB_E_BADID);
    AddConstant('DB_E_BADTYPE',DB_E_BADTYPE);
    AddConstant('DB_E_DUPLICATECOLUMNID',DB_E_DUPLICATECOLUMNID);
    AddConstant('DB_E_DUPLICATETABLEID',DB_E_DUPLICATETABLEID);
    AddConstant('DB_E_TABLEINUSE',DB_E_TABLEINUSE);
    AddConstant('DB_E_NOLOCALE',DB_E_NOLOCALE);
    AddConstant('DB_E_BADRECORDNUM',DB_E_BADRECORDNUM);
    AddConstant('DB_E_BOOKMARKSKIPPED',DB_E_BOOKMARKSKIPPED);
    AddConstant('DB_E_BADPROPERTYVALUE',DB_E_BADPROPERTYVALUE);
    AddConstant('DB_E_INVALID',DB_E_INVALID);
    AddConstant('DB_E_BADACCESSORFLAGS',DB_E_BADACCESSORFLAGS);
    AddConstant('DB_E_BADSTORAGEFLAGS',DB_E_BADSTORAGEFLAGS);
    AddConstant('DB_E_BYREFACCESSORNOTSUPPORTED',DB_E_BYREFACCESSORNOTSUPPORTED);
    AddConstant('DB_E_NULLACCESSORNOTSUPPORTED',DB_E_NULLACCESSORNOTSUPPORTED);
    AddConstant('DB_E_NOTPREPARED',DB_E_NOTPREPARED);
    AddConstant('DB_E_BADACCESSORTYPE',DB_E_BADACCESSORTYPE);
    AddConstant('DB_E_WRITEONLYACCESSOR',DB_E_WRITEONLYACCESSOR);
    AddConstant('DB_SEC_E_AUTH_FAILED',DB_SEC_E_AUTH_FAILED);
    AddConstant('DB_E_CANCELED',DB_E_CANCELED);
    AddConstant('DB_E_CHAPTERNOTRELEASED',DB_E_CHAPTERNOTRELEASED);
    AddConstant('DB_E_BADSOURCEHANDLE',DB_E_BADSOURCEHANDLE);
    AddConstant('DB_E_PARAMUNAVAILABLE',DB_E_PARAMUNAVAILABLE);
    AddConstant('DB_E_ALREADYINITIALIZED',DB_E_ALREADYINITIALIZED);
    AddConstant('DB_E_NOTSUPPORTED',DB_E_NOTSUPPORTED);
    AddConstant('DB_E_MAXPENDCHANGESEXCEEDED',DB_E_MAXPENDCHANGESEXCEEDED);
    AddConstant('DB_E_BADORDINAL',DB_E_BADORDINAL);
    AddConstant('DB_E_PENDINGCHANGES',DB_E_PENDINGCHANGES);
    AddConstant('DB_E_DATAOVERFLOW',DB_E_DATAOVERFLOW);
    AddConstant('DB_E_BADHRESULT',DB_E_BADHRESULT);
    AddConstant('DB_E_BADLOOKUPID',DB_E_BADLOOKUPID);
    AddConstant('DB_E_BADDYNAMICERRORID',DB_E_BADDYNAMICERRORID);
    AddConstant('DB_E_PENDINGINSERT',DB_E_PENDINGINSERT);
    AddConstant('DB_E_BADCONVERTFLAG',DB_E_BADCONVERTFLAG);
    AddConstant('DB_E_BADPARAMETERNAME',DB_E_BADPARAMETERNAME);
    AddConstant('DB_E_MULTIPLESTORAGE',DB_E_MULTIPLESTORAGE);
    AddConstant('DB_E_CANTFILTER',DB_E_CANTFILTER);
    AddConstant('DB_E_CANTORDER',DB_E_CANTORDER);
    AddConstant('MD_E_BADTUPLE',MD_E_BADTUPLE);
    AddConstant('MD_E_BADCOORDINATE',MD_E_BADCOORDINATE);
    AddConstant('MD_E_INVALIDAXIS',MD_E_INVALIDAXIS);
    AddConstant('MD_E_INVALIDCELLRANGE',MD_E_INVALIDCELLRANGE);
    AddConstant('DB_E_NOCOLUMN',DB_E_NOCOLUMN);
    AddConstant('DB_E_COMMANDNOTPERSISTED',DB_E_COMMANDNOTPERSISTED);
    AddConstant('DB_E_DUPLICATEID',DB_E_DUPLICATEID);
    AddConstant('DB_E_OBJECTCREATIONLIMITREACHED',DB_E_OBJECTCREATIONLIMITREACHED);
    AddConstant('DB_E_BADINDEXID',DB_E_BADINDEXID);
    AddConstant('DB_E_BADINITSTRING',DB_E_BADINITSTRING);
    AddConstant('DB_E_NOPROVIDERSREGISTERED',DB_E_NOPROVIDERSREGISTERED);
    AddConstant('DB_E_MISMATCHEDPROVIDER',DB_E_MISMATCHEDPROVIDER);
    AddConstant('SEC_E_BADTRUSTEEID',SEC_E_BADTRUSTEEID);
    AddConstant('SEC_E_NOTRUSTEEID',SEC_E_NOTRUSTEEID);
    AddConstant('SEC_E_NOMEMBERSHIPSUPPORT',SEC_E_NOMEMBERSHIPSUPPORT);
    AddConstant('SEC_E_INVALIDOBJECT',SEC_E_INVALIDOBJECT);
    AddConstant('SEC_E_NOOWNER',SEC_E_NOOWNER);
    AddConstant('SEC_E_INVALIDACCESSENTRYLIST',SEC_E_INVALIDACCESSENTRYLIST);
    AddConstant('SEC_E_INVALIDOWNER',SEC_E_INVALIDOWNER);
    AddConstant('SEC_E_INVALIDACCESSENTRY',SEC_E_INVALIDACCESSENTRY);
    AddConstant('SEC_E_PERMISSIONDENIED',SEC_E_PERMISSIONDENIED);
    AddConstant('DB_S_ROWLIMITEXCEEDED',DB_S_ROWLIMITEXCEEDED);
    AddConstant('DB_S_COLUMNTYPEMISMATCH',DB_S_COLUMNTYPEMISMATCH);
    AddConstant('DB_S_TYPEINFOOVERRIDDEN',DB_S_TYPEINFOOVERRIDDEN);
    AddConstant('DB_S_BOOKMARKSKIPPED',DB_S_BOOKMARKSKIPPED);
    AddConstant('DB_S_NONEXTROWSET',DB_S_NONEXTROWSET);
    AddConstant('DB_S_ENDOFROWSET',DB_S_ENDOFROWSET);
    AddConstant('DB_S_COMMANDREEXECUTED',DB_S_COMMANDREEXECUTED);
    AddConstant('DB_S_BUFFERFULL',DB_S_BUFFERFULL);
    AddConstant('DB_S_NORESULT',DB_S_NORESULT);
    AddConstant('DB_S_CANTRELEASE',DB_S_CANTRELEASE);
    AddConstant('DB_S_GOALCHANGED',DB_S_GOALCHANGED);
    AddConstant('DB_S_UNWANTEDOPERATION',DB_S_UNWANTEDOPERATION);
    AddConstant('DB_S_DIALECTIGNORED',DB_S_DIALECTIGNORED);
    AddConstant('DB_S_UNWANTEDPHASE',DB_S_UNWANTEDPHASE);
    AddConstant('DB_S_UNWANTEDREASON',DB_S_UNWANTEDREASON);
    AddConstant('DB_S_ASYNCHRONOUS',DB_S_ASYNCHRONOUS);
    AddConstant('DB_S_COLUMNSCHANGED',DB_S_COLUMNSCHANGED);
    AddConstant('DB_S_ERRORSRETURNED',DB_S_ERRORSRETURNED);
    AddConstant('DB_S_BADROWHANDLE',DB_S_BADROWHANDLE);
    AddConstant('DB_S_DELETEDROW',DB_S_DELETEDROW);
    AddConstant('DB_S_TOOMANYCHANGES',DB_S_TOOMANYCHANGES);
    AddConstant('DB_S_STOPLIMITREACHED',DB_S_STOPLIMITREACHED);
    AddConstant('DB_S_LOCKUPGRADED',DB_S_LOCKUPGRADED);
    AddConstant('DB_S_PROPERTIESCHANGED',DB_S_PROPERTIESCHANGED);
    AddConstant('DB_S_ERRORSOCCURRED',DB_S_ERRORSOCCURRED);
    AddConstant('DB_S_PARAMUNAVAILABLE',DB_S_PARAMUNAVAILABLE);
    AddConstant('DB_S_MULTIPLECHANGES',DB_S_MULTIPLECHANGES);
  end;
end;

class function TatOleDBLibrary.LibraryName: string;
begin
  result := 'OleDB';
end;

initialization
  RegisterScripterLibrary(TatOleDBLibrary, True);

{$WARNINGS ON}

end.

