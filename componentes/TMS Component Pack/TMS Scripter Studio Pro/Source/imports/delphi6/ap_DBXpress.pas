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
  DB,
  DBXpress,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatDBXpressLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  FLDDescWrapper = class(TatRecordWrapper)
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
    constructor Create(ARecord: FLDDesc);
    function ObjToRec: FLDDesc;
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
  
  SPParamDescWrapper = class(TatRecordWrapper)
  private
    FiParamNum: Word;
    FszName: string;
    FiArgType: TParamType;
    FiDataType: TFieldType;
    FiUnits1: SmallInt;
    FiUnits2: SmallInt;
    FiLen: LongWord;
  public
    constructor Create(ARecord: SPParamDesc);
    function ObjToRec: SPParamDesc;
  published
    property iParamNum: Word read FiParamNum write FiParamNum;
    property szName: string read FszName write FszName;
    property iArgType: TParamType read FiArgType write FiArgType;
    property iDataType: TFieldType read FiDataType write FiDataType;
    property iUnits1: SmallInt read FiUnits1 write FiUnits1;
    property iUnits2: SmallInt read FiUnits2 write FiUnits2;
    property iLen: LongWord read FiLen write FiLen;
  end;
  
  ObjAttrDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjAttrDesc);
    function ObjToRec: ObjAttrDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjTypeDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjTypeDesc);
    function ObjToRec: ObjTypeDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjParentDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiParentFldNum: Word;
  public
    constructor Create(ARecord: ObjParentDesc);
    function ObjToRec: ObjParentDesc;
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

constructor FLDDescWrapper.Create(ARecord: FLDDesc);
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

function FLDDescWrapper.ObjToRec: FLDDesc;
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

constructor SPParamDescWrapper.Create(ARecord: SPParamDesc);
begin
  inherited Create;
  FiParamNum := ARecord.iParamNum;
  FszName := ARecord.szName;
  FiArgType := ARecord.iArgType;
  FiDataType := ARecord.iDataType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FiLen := ARecord.iLen;
end;

function SPParamDescWrapper.ObjToRec: SPParamDesc;
begin
  result.iParamNum := FiParamNum;
  result.szName := FszName;
  result.iArgType := FiArgType;
  result.iDataType := FiDataType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.iLen := FiLen;
end;

constructor ObjAttrDescWrapper.Create(ARecord: ObjAttrDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjAttrDescWrapper.ObjToRec: ObjAttrDesc;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjTypeDescWrapper.Create(ARecord: ObjTypeDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjTypeDescWrapper.ObjToRec: ObjTypeDesc;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjParentDescWrapper.Create(ARecord: ObjParentDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiParentFldNum := ARecord.iParentFldNum;
end;

function ObjParentDescWrapper.ObjToRec: ObjParentDesc;
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
    AddConstant('fldvNOCHECKS',fldvNOCHECKS);
    AddConstant('fldvHASCHECKS',fldvHASCHECKS);
    AddConstant('fldvUNKNOWN',fldvUNKNOWN);
    AddConstant('fldrREADWRITE',fldrREADWRITE);
    AddConstant('fldrREADONLY',fldrREADONLY);
    AddConstant('fldrNONE',fldrNONE);
    AddConstant('fldrUNKNOWN',fldrUNKNOWN);
    AddConstant('cbGENERAL',cbGENERAL);
    AddConstant('cbRESERVED1',cbRESERVED1);
    AddConstant('cbRESERVED2',cbRESERVED2);
    AddConstant('cbINPUTREQ',cbINPUTREQ);
    AddConstant('cbRESERVED4',cbRESERVED4);
    AddConstant('cbRESERVED5',cbRESERVED5);
    AddConstant('cbBATCHRESULT',cbBATCHRESULT);
    AddConstant('cbRESERVED7',cbRESERVED7);
    AddConstant('cbRESTRUCTURE',cbRESTRUCTURE);
    AddConstant('cbRESERVED9',cbRESERVED9);
    AddConstant('cbRESERVED10',cbRESERVED10);
    AddConstant('cbRESERVED11',cbRESERVED11);
    AddConstant('cbRESERVED12',cbRESERVED12);
    AddConstant('cbRESERVED13',cbRESERVED13);
    AddConstant('cbRESERVED14',cbRESERVED14);
    AddConstant('cbRESERVED15',cbRESERVED15);
    AddConstant('cbRESERVED16',cbRESERVED16);
    AddConstant('cbRESERVED17',cbRESERVED17);
    AddConstant('cbTABLECHANGED',cbTABLECHANGED);
    AddConstant('cbRESERVED19',cbRESERVED19);
    AddConstant('cbCANCELQRY',cbCANCELQRY);
    AddConstant('cbSERVERCALL',cbSERVERCALL);
    AddConstant('cbRESERVED22',cbRESERVED22);
    AddConstant('cbGENPROGRESS',cbGENPROGRESS);
    AddConstant('cbDBASELOGIN',cbDBASELOGIN);
    AddConstant('cbDELAYEDUPD',cbDELAYEDUPD);
    AddConstant('cbFIELDRECALC',cbFIELDRECALC);
    AddConstant('cbTRACE',cbTRACE);
    AddConstant('cbDBLOGIN',cbDBLOGIN);
    AddConstant('cbDETACHNOTIFY',cbDETACHNOTIFY);
    AddConstant('cbNBROFCBS',cbNBROFCBS);
    AddConstant('eDrvBlobSize',eDrvBlobSize);
    AddConstant('eDrvCallBack',eDrvCallBack);
    AddConstant('eDrvCallBackInfo',eDrvCallBackInfo);
    AddConstant('eDrvRestrict',eDrvRestrict);
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
    AddConstant('eConnMaxActiveConnection',eConnMaxActiveConnection);
    AddConstant('eConnServerCharSet',eConnServerCharSet);
    AddConstant('eConnSqlDialect',eConnSqlDialect);
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
    AddConstant('eCurObjectAttrName',eCurObjectAttrName);
    AddConstant('eCurObjectTypeName',eCurObjectTypeName);
    AddConstant('eCurParentFieldID',eCurParentFieldID);
    AddConstant('cbrUSEDEF',cbrUSEDEF);
    AddConstant('cbrCONTINUE',cbrCONTINUE);
    AddConstant('cbrABORT',cbrABORT);
    AddConstant('cbrCHKINPUT',cbrCHKINPUT);
    AddConstant('cbrYES',cbrYES);
    AddConstant('cbrNO',cbrNO);
    AddConstant('cbrPARTIALASSIST',cbrPARTIALASSIST);
    AddConstant('cbrSKIP',cbrSKIP);
    AddConstant('cbrRETRY',cbrRETRY);
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
    AddConstant('eObjTypeDatabase',eObjTypeDatabase);
    AddConstant('eObjTypeDataType',eObjTypeDataType);
    AddConstant('eObjTypeTable',eObjTypeTable);
    AddConstant('eObjTypeView',eObjTypeView);
    AddConstant('eObjTypeSynonym',eObjTypeSynonym);
    AddConstant('eObjTypeProcedure',eObjTypeProcedure);
    AddConstant('eObjTypeUser',eObjTypeUser);
    AddConstant('eObjTypeRole',eObjTypeRole);
    AddConstant('eObjTypeUDT',eObjTypeUDT);
    AddConstant('xilREADCOMMITTED',xilREADCOMMITTED);
    AddConstant('xilREPEATABLEREAD',xilREPEATABLEREAD);
    AddConstant('xilDIRTYREAD',xilDIRTYREAD);
    AddConstant('xilCUSTOM',xilCUSTOM);
    AddConstant('paramUNKNOWN',paramUNKNOWN);
    AddConstant('paramIN',paramIN);
    AddConstant('paramOUT',paramOUT);
    AddConstant('paramINOUT',paramINOUT);
    AddConstant('paramRET',paramRET);
    AddConstant('MAXNAMELEN',MAXNAMELEN);
    AddConstant('SQL_ERROR',SQL_ERROR);
    AddConstant('SQL_NULL_DATA',SQL_NULL_DATA);
    AddConstant('SQL_ERROR_EOF',SQL_ERROR_EOF);
    AddConstant('SQL_SUCCESS',SQL_SUCCESS);
    AddConstant('DBXERR_NOMEMORY',DBXERR_NOMEMORY);
    AddConstant('DBXERR_INVALIDFLDTYPE',DBXERR_INVALIDFLDTYPE);
    AddConstant('DBXERR_INVALIDHNDL',DBXERR_INVALIDHNDL);
    AddConstant('DBXERR_INVALIDTIME',DBXERR_INVALIDTIME);
    AddConstant('DBXERR_NOTSUPPORTED',DBXERR_NOTSUPPORTED);
    AddConstant('DBXERR_INVALIDXLATION',DBXERR_INVALIDXLATION);
    AddConstant('DBXERR_INVALIDPARAM',DBXERR_INVALIDPARAM);
    AddConstant('DBXERR_OUTOFRANGE',DBXERR_OUTOFRANGE);
    AddConstant('DBXERR_SQLPARAMNOTSET',DBXERR_SQLPARAMNOTSET);
    AddConstant('DBXERR_EOF',DBXERR_EOF);
    AddConstant('DBXERR_INVALIDUSRPASS',DBXERR_INVALIDUSRPASS);
    AddConstant('DBXERR_INVALIDPRECISION',DBXERR_INVALIDPRECISION);
    AddConstant('DBXERR_INVALIDLEN',DBXERR_INVALIDLEN);
    AddConstant('DBXERR_INVALIDXISOLEVEL',DBXERR_INVALIDXISOLEVEL);
    AddConstant('DBXERR_INVALIDXTXNID',DBXERR_INVALIDXTXNID);
    AddConstant('DBXERR_DUPLICATETXNID',DBXERR_DUPLICATETXNID);
    AddConstant('DBXERR_DRIVERRESTRICTED',DBXERR_DRIVERRESTRICTED);
    AddConstant('DBX_MAXSTATICERRORS',DBX_MAXSTATICERRORS);
    AddConstant('MaxReservedStaticErrors',MaxReservedStaticErrors);
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
    AddConstant('fldstHMEMO',fldstHMEMO);
    AddConstant('fldstHBINARY',fldstHBINARY);
    AddConstant('fldstBFILE',fldstBFILE);
    AddConstant('fldstPASSWORD',fldstPASSWORD);
    AddConstant('fldstFIXED',fldstFIXED);
    AddConstant('fldstUNICODE',fldstUNICODE);
    AddConstant('fldstAUTOINC',fldstAUTOINC);
    AddConstant('fldstADTNestedTable',fldstADTNestedTable);
    AddConstant('fldstADTDATE',fldstADTDATE);
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

