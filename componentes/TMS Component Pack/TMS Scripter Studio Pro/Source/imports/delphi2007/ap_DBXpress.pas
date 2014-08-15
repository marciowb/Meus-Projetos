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
unit ap_DBXpress;

interface

uses
  Windows,
  DBCommonTypes,
  DBXpress,
  Variants,
  atScript;

type
  TatDBXpressLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  FLDDesc30Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiFldType: Word;
    FiSubType: Word;
    FiUnits1: SmallInt;
    FiUnits2: SmallInt;
    FiOffset: Word;
    FiLen: LongWord;
    FiNullOffset: Word;
    FefldvVchk: FLDVchk;
    FefldrRights: FLDRights;
    FbCalcField: WordBool;
  public                        
    constructor Create(ARecord: FLDDesc30);
    function ObjToRec: FLDDesc30;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property iFldType: Word read FiFldType write FiFldType;
    property iSubType: Word read FiSubType write FiSubType;
    property iUnits1: SmallInt read FiUnits1 write FiUnits1;
    property iUnits2: SmallInt read FiUnits2 write FiUnits2;
    property iOffset: Word read FiOffset write FiOffset;
    property iLen: LongWord read FiLen write FiLen;
    property iNullOffset: Word read FiNullOffset write FiNullOffset;
    property efldvVchk: FLDVchk read FefldvVchk write FefldvVchk;
    property efldrRights: FLDRights read FefldrRights write FefldrRights;
    property bCalcField: WordBool read FbCalcField write FbCalcField;
  end;
  
  FLDDesc25Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiFldType: Word;
    FiSubType: Word;
    FiUnits1: SmallInt;
    FiUnits2: SmallInt;
    FiOffset: Word;
    FiLen: LongWord;
    FiNullOffset: Word;
    FefldvVchk: FLDVchk;
    FefldrRights: FLDRights;
    FbCalcField: WordBool;
  public
    constructor Create(ARecord: FLDDesc25);
    function ObjToRec: FLDDesc25;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property iFldType: Word read FiFldType write FiFldType;
    property iSubType: Word read FiSubType write FiSubType;
    property iUnits1: SmallInt read FiUnits1 write FiUnits1;
    property iUnits2: SmallInt read FiUnits2 write FiUnits2;
    property iOffset: Word read FiOffset write FiOffset;
    property iLen: LongWord read FiLen write FiLen;
    property iNullOffset: Word read FiNullOffset write FiNullOffset;
    property efldvVchk: FLDVchk read FefldvVchk write FefldvVchk;
    property efldrRights: FLDRights read FefldrRights write FefldrRights;
    property bCalcField: WordBool read FbCalcField write FbCalcField;
  end;
  
  ObjAttrDesc30Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjAttrDesc30);
    function ObjToRec: ObjAttrDesc30;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjAttrDesc25Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjAttrDesc25);
    function ObjToRec: ObjAttrDesc25;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjTypeDesc30Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjTypeDesc30);
    function ObjToRec: ObjTypeDesc30;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjTypeDesc25Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjTypeDesc25);
    function ObjToRec: ObjTypeDesc25;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjParentDesc30Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiParentFldNum: Word;
  public
    constructor Create(ARecord: ObjParentDesc30);
    function ObjToRec: ObjParentDesc30;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property iParentFldNum: Word read FiParentFldNum write FiParentFldNum;
  end;
  
  ObjParentDesc25Wrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiParentFldNum: Word;
  public
    constructor Create(ARecord: ObjParentDesc25);
    function ObjToRec: ObjParentDesc25;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property iParentFldNum: Word read FiParentFldNum write FiParentFldNum;
  end;
  
  TTransactionDescWrapper = class(TatRecordWrapper)
  private
    FTransactionID: LongWord;
    FGlobalID: LongWord;
    FIsolationLevel: TTransIsolationLevel;
    FCustomIsolation: LongWord;
  public
    constructor Create(ARecord: TTransactionDesc);
    function ObjToRec: TTransactionDesc;
  published
    property TransactionID: LongWord read FTransactionID write FTransactionID;
    property GlobalID: LongWord read FGlobalID write FGlobalID;
    property IsolationLevel: TTransIsolationLevel read FIsolationLevel write FIsolationLevel;
    property CustomIsolation: LongWord read FCustomIsolation write FCustomIsolation;
  end;
  

implementation

{$WARNINGS OFF}

constructor FLDDesc30Wrapper.Create(ARecord: FLDDesc30);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiFldType := ARecord.iFldType;
  FiSubType := ARecord.iSubType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FiOffset := ARecord.iOffset;
  FiLen := ARecord.iLen;
  FiNullOffset := ARecord.iNullOffset;
  FefldvVchk := ARecord.efldvVchk;
  FefldrRights := ARecord.efldrRights;
  FbCalcField := ARecord.bCalcField;
end;

function FLDDesc30Wrapper.ObjToRec: FLDDesc30;
begin
  result.iFldNum := FiFldNum;
  result.iFldType := FiFldType;
  result.iSubType := FiSubType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.iOffset := FiOffset;
  result.iLen := FiLen;
  result.iNullOffset := FiNullOffset;
  result.efldvVchk := FefldvVchk;
  result.efldrRights := FefldrRights;
  result.bCalcField := FbCalcField;
end;

constructor FLDDesc25Wrapper.Create(ARecord: FLDDesc25);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiFldType := ARecord.iFldType;
  FiSubType := ARecord.iSubType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FiOffset := ARecord.iOffset;
  FiLen := ARecord.iLen;
  FiNullOffset := ARecord.iNullOffset;
  FefldvVchk := ARecord.efldvVchk;
  FefldrRights := ARecord.efldrRights;
  FbCalcField := ARecord.bCalcField;
end;

function FLDDesc25Wrapper.ObjToRec: FLDDesc25;
begin
  result.iFldNum := FiFldNum;
  result.iFldType := FiFldType;
  result.iSubType := FiSubType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.iOffset := FiOffset;
  result.iLen := FiLen;
  result.iNullOffset := FiNullOffset;
  result.efldvVchk := FefldvVchk;
  result.efldrRights := FefldrRights;
  result.bCalcField := FbCalcField;
end;

constructor ObjAttrDesc30Wrapper.Create(ARecord: ObjAttrDesc30);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjAttrDesc30Wrapper.ObjToRec: ObjAttrDesc30;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjAttrDesc25Wrapper.Create(ARecord: ObjAttrDesc25);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjAttrDesc25Wrapper.ObjToRec: ObjAttrDesc25;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjTypeDesc30Wrapper.Create(ARecord: ObjTypeDesc30);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjTypeDesc30Wrapper.ObjToRec: ObjTypeDesc30;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjTypeDesc25Wrapper.Create(ARecord: ObjTypeDesc25);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjTypeDesc25Wrapper.ObjToRec: ObjTypeDesc25;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjParentDesc30Wrapper.Create(ARecord: ObjParentDesc30);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiParentFldNum := ARecord.iParentFldNum;
end;

function ObjParentDesc30Wrapper.ObjToRec: ObjParentDesc30;
begin
  result.iFldNum := FiFldNum;
  result.iParentFldNum := FiParentFldNum;
end;

constructor ObjParentDesc25Wrapper.Create(ARecord: ObjParentDesc25);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiParentFldNum := ARecord.iParentFldNum;
end;

function ObjParentDesc25Wrapper.ObjToRec: ObjParentDesc25;
begin
  result.iFldNum := FiFldNum;
  result.iParentFldNum := FiParentFldNum;
end;

constructor TTransactionDescWrapper.Create(ARecord: TTransactionDesc);
begin
  inherited Create;
  FTransactionID := ARecord.TransactionID;
  FGlobalID := ARecord.GlobalID;
  FIsolationLevel := ARecord.IsolationLevel;
  FCustomIsolation := ARecord.CustomIsolation;
end;

function TTransactionDescWrapper.ObjToRec: TTransactionDesc;
begin
  result.TransactionID := FTransactionID;
  result.GlobalID := FGlobalID;
  result.IsolationLevel := FIsolationLevel;
  result.CustomIsolation := FCustomIsolation;
end;



procedure TatDBXpressLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('eDrvBlobSize',eDrvBlobSize);
    AddConstant('eDrvCallBack',eDrvCallBack);
    AddConstant('eDrvCallBackInfo',eDrvCallBackInfo);
    AddConstant('eDrvRestrict',eDrvRestrict);
    AddConstant('eDrvVersion',eDrvVersion);
    AddConstant('eDrvProductVersion',eDrvProductVersion);
    AddConstant('eConnAutoCommit',eConnAutoCommit);
    AddConstant('eConnBlockingMode',eConnBlockingMode);
    AddConstant('eConnBlobSize',eConnBlobSize);
    AddConstant('eConnRoleName',eConnRoleName);
    AddConstant('eConnWaitOnLocks',eConnWaitOnLocks);
    AddConstant('eConnCommitRetain',eConnCommitRetain);
    AddConstant('eConnTxnIsoLevel',eConnTxnIsoLevel);
    AddConstant('eConnNativeHandle',eConnNativeHandle);
    AddConstant('eConnServerVersion',eConnServerVersion);
    AddConstant('eConnCallBack',eConnCallBack);
    AddConstant('eConnHostName',eConnHostName);
    AddConstant('eConnDatabaseName',eConnDatabaseName);
    AddConstant('eConnCallBackInfo',eConnCallBackInfo);
    AddConstant('eConnObjectMode',eConnObjectMode);
    AddConstant('eConnMaxActiveComm',eConnMaxActiveComm);
    AddConstant('eConnServerCharSet',eConnServerCharSet);
    AddConstant('eConnSqlDialect',eConnSqlDialect);
    AddConstant('eConnRollbackRetain',eConnRollbackRetain);
    AddConstant('eConnObjectQuoteChar',eConnObjectQuoteChar);
    AddConstant('eConnConnectionName',eConnConnectionName);
    AddConstant('eConnOSAuthentication',eConnOSAuthentication);
    AddConstant('eConnSupportsTransaction',eConnSupportsTransaction);
    AddConstant('eConnMultipleTransaction',eConnMultipleTransaction);
    AddConstant('eConnServerPort',eConnServerPort);
    AddConstant('eConnOnLine',eConnOnLine);
    AddConstant('eConnTrimChar',eConnTrimChar);
    AddConstant('eConnQualifiedName',eConnQualifiedName);
    AddConstant('eConnCatalogName',eConnCatalogName);
    AddConstant('eConnSchemaName',eConnSchemaName);
    AddConstant('eConnObjectName',eConnObjectName);
    AddConstant('eConnQuotedObjectName',eConnQuotedObjectName);
    AddConstant('eConnCustomInfo',eConnCustomInfo);
    AddConstant('eConnTimeOut',eConnTimeOut);
    AddConstant('eConnConnectionString',eConnConnectionString);
    AddConstant('eConnTDSPacketSize',eConnTDSPacketSize);
    AddConstant('eConnClientHostName',eConnClientHostName);
    AddConstant('eConnClientAppName',eConnClientAppName);
    AddConstant('eConnCompressed',eConnCompressed);
    AddConstant('eConnEncrypted',eConnEncrypted);
    AddConstant('eConnPrepareSQL',eConnPrepareSQL);
    AddConstant('eConnDecimalSeparator',eConnDecimalSeparator);
    AddConstant('eCommRowsetSize',eCommRowsetSize);
    AddConstant('eCommBlobSize',eCommBlobSize);
    AddConstant('eCommBlockRead',eCommBlockRead);
    AddConstant('eCommBlockWrite',eCommBlockWrite);
    AddConstant('eCommParamCount',eCommParamCount);
    AddConstant('eCommNativeHandle',eCommNativeHandle);
    AddConstant('eCommCursorName',eCommCursorName);
    AddConstant('eCommStoredProc',eCommStoredProc);
    AddConstant('eCommSQLDialect',eCommSQLDialect);
    AddConstant('eCommTransactionID',eCommTransactionID);
    AddConstant('eCommPackageName',eCommPackageName);
    AddConstant('eCommTrimChar',eCommTrimChar);
    AddConstant('eCommQualifiedName',eCommQualifiedName);
    AddConstant('eCommCatalogName',eCommCatalogName);
    AddConstant('eCommSchemaName',eCommSchemaName);
    AddConstant('eCommObjectName',eCommObjectName);
    AddConstant('eCommQuotedObjectName',eCommQuotedObjectName);
    AddConstant('eCommPrepareSQL',eCommPrepareSQL);
    AddConstant('eCommDecimalSeparator',eCommDecimalSeparator);
    AddConstant('eCurObjectAttrName',eCurObjectAttrName);
    AddConstant('eCurObjectTypeName',eCurObjectTypeName);
    AddConstant('eCurParentFieldID',eCurParentFieldID);
    AddConstant('eMetaCatalogName',eMetaCatalogName);
    AddConstant('eMetaSchemaName',eMetaSchemaName);
    AddConstant('eMetaDatabaseName',eMetaDatabaseName);
    AddConstant('eMetaDatabaseVersion',eMetaDatabaseVersion);
    AddConstant('eMetaTransactionIsoLevel',eMetaTransactionIsoLevel);
    AddConstant('eMetaSupportsTransaction',eMetaSupportsTransaction);
    AddConstant('eMetaMaxObjectNameLength',eMetaMaxObjectNameLength);
    AddConstant('eMetaMaxColumnsInTable',eMetaMaxColumnsInTable);
    AddConstant('eMetaMaxColumnsInSelect',eMetaMaxColumnsInSelect);
    AddConstant('eMetaMaxRowSize',eMetaMaxRowSize);
    AddConstant('eMetaMaxSQLLength',eMetaMaxSQLLength);
    AddConstant('eMetaObjectQuoteChar',eMetaObjectQuoteChar);
    AddConstant('eMetaSQLEscapeChar',eMetaSQLEscapeChar);
    AddConstant('eMetaProcSupportsCursor',eMetaProcSupportsCursor);
    AddConstant('eMetaProcSupportsCursors',eMetaProcSupportsCursors);
    AddConstant('eMetaSupportsTransactions',eMetaSupportsTransactions);
    AddConstant('eMetaPackageName',eMetaPackageName);
    AddConstant('eMetaDefaultSchemaName',eMetaDefaultSchemaName);
    AddConstant('eObjTypeDatabase',eObjTypeDatabase);
    AddConstant('eObjTypeDataType',eObjTypeDataType);
    AddConstant('eObjTypeTable',eObjTypeTable);
    AddConstant('eObjTypeView',eObjTypeView);
    AddConstant('eObjTypeSynonym',eObjTypeSynonym);
    AddConstant('eObjTypeProcedure',eObjTypeProcedure);
    AddConstant('eObjTypeUser',eObjTypeUser);
    AddConstant('eObjTypeRole',eObjTypeRole);
    AddConstant('eObjTypeUDT',eObjTypeUDT);
    AddConstant('eObjTypePackage',eObjTypePackage);
    AddConstant('xilREADCOMMITTED',xilREADCOMMITTED);
    AddConstant('xilREPEATABLEREAD',xilREPEATABLEREAD);
    AddConstant('xilDIRTYREAD',xilDIRTYREAD);
    AddConstant('xilCUSTOM',xilCUSTOM);
    AddConstant('paramUNKNOWN',paramUNKNOWN);
    AddConstant('paramIN',paramIN);
    AddConstant('paramOUT',paramOUT);
    AddConstant('paramINOUT',paramINOUT);
    AddConstant('paramRET',paramRET);
    AddConstant('traceQPREPARE',traceQPREPARE);
    AddConstant('traceQEXECUTE',traceQEXECUTE);
    AddConstant('traceERROR',traceERROR);
    AddConstant('traceSTMT',traceSTMT);
    AddConstant('traceCONNECT',traceCONNECT);
    AddConstant('traceTRANSACT',traceTRANSACT);
    AddConstant('traceBLOB',traceBLOB);
    AddConstant('traceMISC',traceMISC);
    AddConstant('traceVENDOR',traceVENDOR);
    AddConstant('traceDATAIN',traceDATAIN);
    AddConstant('traceDATAOUT',traceDATAOUT);
    AddConstant('DBXDRIVERVERSION30',DBXDRIVERVERSION30);
    AddConstant('DBXPRODUCTVERSION30',DBXPRODUCTVERSION30);
    AddConstant('MAXNAMELEN',MAXNAMELEN);
    AddConstant('NAMEBUFLEN',NAMEBUFLEN);
    AddConstant('SQL_ERROR',SQL_ERROR);
    AddConstant('SQL_NULL_DATA',SQL_NULL_DATA);
    AddConstant('DBXERR_NONE',DBXERR_NONE);
    AddConstant('DBXERR_WARNING',DBXERR_WARNING);
    AddConstant('DBXERR_NOMEMORY',DBXERR_NOMEMORY);
    AddConstant('DBXERR_INVALIDFLDTYPE',DBXERR_INVALIDFLDTYPE);
    AddConstant('DBXERR_INVALIDHNDL',DBXERR_INVALIDHNDL);
    AddConstant('DBXERR_NOTSUPPORTED',DBXERR_NOTSUPPORTED);
    AddConstant('DBXERR_INVALIDTIME',DBXERR_INVALIDTIME);
    AddConstant('DBXERR_INVALIDXLATION',DBXERR_INVALIDXLATION);
    AddConstant('DBXERR_OUTOFRANGE',DBXERR_OUTOFRANGE);
    AddConstant('DBXERR_INVALIDPARAM',DBXERR_INVALIDPARAM);
    AddConstant('DBXERR_EOF',DBXERR_EOF);
    AddConstant('DBXERR_SQLPARAMNOTSET',DBXERR_SQLPARAMNOTSET);
    AddConstant('DBXERR_INVALIDUSRPASS',DBXERR_INVALIDUSRPASS);
    AddConstant('DBXERR_INVALIDPRECISION',DBXERR_INVALIDPRECISION);
    AddConstant('DBXERR_INVALIDLEN',DBXERR_INVALIDLEN);
    AddConstant('DBXERR_INVALIDTXNISOLEVEL',DBXERR_INVALIDTXNISOLEVEL);
    AddConstant('DBXERR_INVALIDTXNID',DBXERR_INVALIDTXNID);
    AddConstant('DBXERR_DUPLICATETXNID',DBXERR_DUPLICATETXNID);
    AddConstant('DBXERR_DRIVERRESTRICTED',DBXERR_DRIVERRESTRICTED);
    AddConstant('DBXERR_LOCALTRANSACTIVE',DBXERR_LOCALTRANSACTIVE);
    AddConstant('DBXERR_MULTIPLETRANSNOTENABLED',DBXERR_MULTIPLETRANSNOTENABLED);
    AddConstant('DBXERR_CONNECTIONFAILED',DBXERR_CONNECTIONFAILED);
    AddConstant('DBXERR_DRIVERINITFAILED',DBXERR_DRIVERINITFAILED);
    AddConstant('DBXERR_OPTLOCKFAILED',DBXERR_OPTLOCKFAILED);
    AddConstant('DBXERR_INVALIDREF',DBXERR_INVALIDREF);
    AddConstant('DBXERR_NOTABLE',DBXERR_NOTABLE);
    AddConstant('DBXERR_MISSINGPARAMINSQL',DBXERR_MISSINGPARAMINSQL);
    AddConstant('DBXERR_NOTIMPLEMENT',DBXERR_NOTIMPLEMENT);
    AddConstant('DBXERR_DRIVERINCOMPATIBLE',DBXERR_DRIVERINCOMPATIBLE);
    AddConstant('DBXERR_NODATA',DBXERR_NODATA);
    AddConstant('DBX_MAXSTATICERRORS',DBX_MAXSTATICERRORS);
    AddConstant('DBXERR_SQLERROR',DBXERR_SQLERROR);
    AddConstant('trUNKNOWN',trUNKNOWN);
    AddConstant('trQPREPARE',trQPREPARE);
    AddConstant('trQEXECUTE',trQEXECUTE);
    AddConstant('trERROR',trERROR);
    AddConstant('trSTMT',trSTMT);
    AddConstant('trCONNECT',trCONNECT);
    AddConstant('trTRANSACT',trTRANSACT);
    AddConstant('trBLOB',trBLOB);
    AddConstant('trMISC',trMISC);
    AddConstant('trVENDOR',trVENDOR);
    AddConstant('trDATAIN',trDATAIN);
    AddConstant('trDATAOUT',trDATAOUT);
    AddConstant('eSQLTable',eSQLTable);
    AddConstant('eSQLView',eSQLView);
    AddConstant('eSQLSystemTable',eSQLSystemTable);
    AddConstant('eSQLSynonym',eSQLSynonym);
    AddConstant('eSQLTempTable',eSQLTempTable);
    AddConstant('eSQLLocal',eSQLLocal);
    AddConstant('eSQLProcedure',eSQLProcedure);
    AddConstant('eSQLFunction',eSQLFunction);
    AddConstant('eSQLPackage',eSQLPackage);
    AddConstant('eSQLSysProcedure',eSQLSysProcedure);
    AddConstant('eSQLRowId',eSQLRowId);
    AddConstant('eSQLRowVersion',eSQLRowVersion);
    AddConstant('eSQLAutoIncr',eSQLAutoIncr);
    AddConstant('eSQLDefault',eSQLDefault);
    AddConstant('eSQLNonUnique',eSQLNonUnique);
    AddConstant('eSQLUnique',eSQLUnique);
    AddConstant('eSQLPrimaryKey',eSQLPrimaryKey);
    AddConstant('fldUNKNOWN',fldUNKNOWN);
    AddConstant('fldZSTRING',fldZSTRING);
    AddConstant('fldDATE',fldDATE);
    AddConstant('fldBLOB',fldBLOB);
    AddConstant('fldBOOL',fldBOOL);
    AddConstant('fldINT16',fldINT16);
    AddConstant('fldINT32',fldINT32);
    AddConstant('fldFLOAT',fldFLOAT);
    AddConstant('fldBCD',fldBCD);
    AddConstant('fldBYTES',fldBYTES);
    AddConstant('fldTIME',fldTIME);
    AddConstant('fldTIMESTAMP',fldTIMESTAMP);
    AddConstant('fldUINT16',fldUINT16);
    AddConstant('fldUINT32',fldUINT32);
    AddConstant('fldFLOATIEEE',fldFLOATIEEE);
    AddConstant('fldVARBYTES',fldVARBYTES);
    AddConstant('fldLOCKINFO',fldLOCKINFO);
    AddConstant('fldCURSOR',fldCURSOR);
    AddConstant('fldINT64',fldINT64);
    AddConstant('fldUINT64',fldUINT64);
    AddConstant('fldADT',fldADT);
    AddConstant('fldARRAY',fldARRAY);
    AddConstant('fldREF',fldREF);
    AddConstant('fldTABLE',fldTABLE);
    AddConstant('fldDATETIME',fldDATETIME);
    AddConstant('fldFMTBCD',fldFMTBCD);
    AddConstant('fldWIDESTRING',fldWIDESTRING);
    AddConstant('MAXLOGFLDTYPES',MAXLOGFLDTYPES);
    AddConstant('fldstMONEY',fldstMONEY);
    AddConstant('fldstMEMO',fldstMEMO);
    AddConstant('fldstBINARY',fldstBINARY);
    AddConstant('fldstFMTMEMO',fldstFMTMEMO);
    AddConstant('fldstOLEOBJ',fldstOLEOBJ);
    AddConstant('fldstGRAPHIC',fldstGRAPHIC);
    AddConstant('fldstDBSOLEOBJ',fldstDBSOLEOBJ);
    AddConstant('fldstTYPEDBINARY',fldstTYPEDBINARY);
    AddConstant('fldstACCOLEOBJ',fldstACCOLEOBJ);
    AddConstant('fldstWIDEMEMO',fldstWIDEMEMO);
    AddConstant('fldstHMEMO',fldstHMEMO);
    AddConstant('fldstHBINARY',fldstHBINARY);
    AddConstant('fldstBFILE',fldstBFILE);
    AddConstant('fldstPASSWORD',fldstPASSWORD);
    AddConstant('fldstFIXED',fldstFIXED);
    AddConstant('fldstAUTOINC',fldstAUTOINC);
    AddConstant('fldstADTNestedTable',fldstADTNestedTable);
    AddConstant('fldstADTDATE',fldstADTDATE);
    AddConstant('fldstORATIMESTAMP',fldstORATIMESTAMP);
    AddConstant('fldstORAINTERVAL',fldstORAINTERVAL);
  end;
end;

class function TatDBXpressLibrary.LibraryName: string;
begin
  result := 'DBXpress';
end;

initialization
  RegisterScripterLibrary(TatDBXpressLibrary, True);

{$WARNINGS ON}

end.
