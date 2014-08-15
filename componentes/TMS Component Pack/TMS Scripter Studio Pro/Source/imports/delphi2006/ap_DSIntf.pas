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
unit ap_DSIntf;

interface

uses
  Windows,
  VarUtils,
  Variants,
  ActiveX,
  DB,
  DBCommon,
  DSIntf,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatDSIntfLibrary = class(TatScripterLibrary)
    procedure __CreateDbClientObject(AMachine: TatVirtualMachine);
    procedure __VariantArrayToString(AMachine: TatVirtualMachine);
    procedure __StringToVariantArray(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DSBase(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DSCursor(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DSWriter(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  AGGVALUEWrapper = class(TatRecordWrapper)
  private
    FiCnt: Integer;
    FeAggState: AGGSTATE;
  public
    constructor Create(ARecord: AGGVALUE);
    function ObjToRec: AGGVALUE;
  published
    property iCnt: Integer read FiCnt write FiCnt;
    property eAggState: AGGSTATE read FeAggState write FeAggState;
  end;
  
  DSBOOKMRKWrapper = class(TatRecordWrapper)
  private
    FiPos: Integer;
    FiState: Integer;
    FiRecNo: Integer;
    FiSeqNo: Integer;
    FiOrderID: Integer;
  public
    constructor Create(ARecord: DSBOOKMRK);
    function ObjToRec: DSBOOKMRK;
  published
    property iPos: Integer read FiPos write FiPos;
    property iState: Integer read FiState write FiState;
    property iRecNo: Integer read FiRecNo write FiRecNo;
    property iSeqNo: Integer read FiSeqNo write FiSeqNo;
    property iOrderID: Integer read FiOrderID write FiOrderID;
  end;
  
  DSPropsWrapper = class(TatRecordWrapper)
  private
    FiFields: Integer;
    FiRecBufSize: Integer;
    FiBookMarkSize: Integer;
    FbReadOnly: LongBool;
    FiIndexes: Integer;
    FiOptParams: Integer;
    FbDelta: LongBool;
    FiLCID: Integer;
  public
    constructor Create(ARecord: DSProps);
    function ObjToRec: DSProps;
  published
    property iFields: Integer read FiFields write FiFields;
    property iRecBufSize: Integer read FiRecBufSize write FiRecBufSize;
    property iBookMarkSize: Integer read FiBookMarkSize write FiBookMarkSize;
    property bReadOnly: LongBool read FbReadOnly write FbReadOnly;
    property iIndexes: Integer read FiIndexes write FiIndexes;
    property iOptParams: Integer read FiOptParams write FiOptParams;
    property bDelta: LongBool read FbDelta write FbDelta;
    property iLCID: Integer read FiLCID write FiLCID;
  end;
  
  DSFLDDescWrapper = class(TatRecordWrapper)
  private
    FiFldType: Integer;
    FiFldSubType: Integer;
    FiUnits1: Integer;
    FiUnits2: Integer;
    FiFldLen: Integer;
    FiFldOffsInRec: Integer;
    FiNullOffsInRec: Integer;
    FiFieldID: Word;
    FiFieldIDParent: Word;
    FbCalculated: LongBool;
    FiFldAttr: Integer;
    FiOptParameters: Integer;
  public
    constructor Create(ARecord: DSFLDDesc);
    function ObjToRec: DSFLDDesc;
  published
    property iFldType: Integer read FiFldType write FiFldType;
    property iFldSubType: Integer read FiFldSubType write FiFldSubType;
    property iUnits1: Integer read FiUnits1 write FiUnits1;
    property iUnits2: Integer read FiUnits2 write FiUnits2;
    property iFldLen: Integer read FiFldLen write FiFldLen;
    property iFldOffsInRec: Integer read FiFldOffsInRec write FiFldOffsInRec;
    property iNullOffsInRec: Integer read FiNullOffsInRec write FiNullOffsInRec;
    property iFieldID: Word read FiFieldID write FiFieldID;
    property iFieldIDParent: Word read FiFieldIDParent write FiFieldIDParent;
    property bCalculated: LongBool read FbCalculated write FbCalculated;
    property iFldAttr: Integer read FiFldAttr write FiFldAttr;
    property iOptParameters: Integer read FiOptParameters write FiOptParameters;
  end;
  
  DSIDXDescWrapper = class(TatRecordWrapper)
  private
    FiFields: Integer;
    FiKeyLen: Integer;
    FbUnique: LongBool;
  public
    constructor Create(ARecord: DSIDXDesc);
    function ObjToRec: DSIDXDesc;
  published
    property iFields: Integer read FiFields write FiFields;
    property iKeyLen: Integer read FiKeyLen write FiKeyLen;
    property bUnique: LongBool read FbUnique write FbUnique;
  end;
  
  TDSDataPacketFldDescWrapper = class(TatRecordWrapper)
  private
    FiFieldType: Integer;
    FiAttributes: Word;
  public
    constructor Create(ARecord: TDSDataPacketFldDesc);
    function ObjToRec: TDSDataPacketFldDesc;
  published
    property iFieldType: Integer read FiFieldType write FiFieldType;
    property iAttributes: Word read FiAttributes write FiAttributes;
  end;
  

implementation

constructor AGGVALUEWrapper.Create(ARecord: AGGVALUE);
begin
  inherited Create;
  FiCnt := ARecord.iCnt;
  FeAggState := ARecord.eAggState;
end;

function AGGVALUEWrapper.ObjToRec: AGGVALUE;
begin
  result.iCnt := FiCnt;
  result.eAggState := FeAggState;
end;

constructor DSBOOKMRKWrapper.Create(ARecord: DSBOOKMRK);
begin
  inherited Create;
  FiPos := ARecord.iPos;
  FiState := ARecord.iState;
  FiRecNo := ARecord.iRecNo;
  FiSeqNo := ARecord.iSeqNo;
  FiOrderID := ARecord.iOrderID;
end;

function DSBOOKMRKWrapper.ObjToRec: DSBOOKMRK;
begin
  result.iPos := FiPos;
  result.iState := FiState;
  result.iRecNo := FiRecNo;
  result.iSeqNo := FiSeqNo;
  result.iOrderID := FiOrderID;
end;

constructor DSPropsWrapper.Create(ARecord: DSProps);
begin
  inherited Create;
  FiFields := ARecord.iFields;
  FiRecBufSize := ARecord.iRecBufSize;
  FiBookMarkSize := ARecord.iBookMarkSize;
  FbReadOnly := ARecord.bReadOnly;
  FiIndexes := ARecord.iIndexes;
  FiOptParams := ARecord.iOptParams;
  FbDelta := ARecord.bDelta;
  FiLCID := ARecord.iLCID;
end;

function DSPropsWrapper.ObjToRec: DSProps;
begin
  result.iFields := FiFields;
  result.iRecBufSize := FiRecBufSize;
  result.iBookMarkSize := FiBookMarkSize;
  result.bReadOnly := FbReadOnly;
  result.iIndexes := FiIndexes;
  result.iOptParams := FiOptParams;
  result.bDelta := FbDelta;
  result.iLCID := FiLCID;
end;

constructor DSFLDDescWrapper.Create(ARecord: DSFLDDesc);
begin
  inherited Create;
  FiFldType := ARecord.iFldType;
  FiFldSubType := ARecord.iFldSubType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FiFldLen := ARecord.iFldLen;
  FiFldOffsInRec := ARecord.iFldOffsInRec;
  FiNullOffsInRec := ARecord.iNullOffsInRec;
  FiFieldID := ARecord.iFieldID;
  FiFieldIDParent := ARecord.iFieldIDParent;
  FbCalculated := ARecord.bCalculated;
  FiFldAttr := ARecord.iFldAttr;
  FiOptParameters := ARecord.iOptParameters;
end;

function DSFLDDescWrapper.ObjToRec: DSFLDDesc;
begin
  result.iFldType := FiFldType;
  result.iFldSubType := FiFldSubType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.iFldLen := FiFldLen;
  result.iFldOffsInRec := FiFldOffsInRec;
  result.iNullOffsInRec := FiNullOffsInRec;
  result.iFieldID := FiFieldID;
  result.iFieldIDParent := FiFieldIDParent;
  result.bCalculated := FbCalculated;
  result.iFldAttr := FiFldAttr;
  result.iOptParameters := FiOptParameters;
end;

constructor DSIDXDescWrapper.Create(ARecord: DSIDXDesc);
begin
  inherited Create;
  FiFields := ARecord.iFields;
  FiKeyLen := ARecord.iKeyLen;
  FbUnique := ARecord.bUnique;
end;

function DSIDXDescWrapper.ObjToRec: DSIDXDesc;
begin
  result.iFields := FiFields;
  result.iKeyLen := FiKeyLen;
  result.bUnique := FbUnique;
end;

constructor TDSDataPacketFldDescWrapper.Create(ARecord: TDSDataPacketFldDesc);
begin
  inherited Create;
  FiFieldType := ARecord.iFieldType;
  FiAttributes := ARecord.iAttributes;
end;

function TDSDataPacketFldDescWrapper.ObjToRec: TDSDataPacketFldDesc;
begin
  result.iFieldType := FiFieldType;
  result.iAttributes := FiAttributes;
end;



procedure TatDSIntfLibrary.__CreateDbClientObject(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
    DSIntf.CreateDbClientObject(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    SetInputArg(2,Param2);
  end;
end;

procedure TatDSIntfLibrary.__VariantArrayToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DSIntf.VariantArrayToString(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDSIntfLibrary.__StringToVariantArray(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := DSIntf.StringToVariantArray(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDSIntfLibrary.__GetCLSID_DSBase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(DSIntf.CLSID_DSBase)));
  end;
end;

procedure TatDSIntfLibrary.__GetCLSID_DSCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(DSIntf.CLSID_DSCursor)));
  end;
end;

procedure TatDSIntfLibrary.__GetCLSID_DSWriter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(DSIntf.CLSID_DSWriter)));
  end;
end;

procedure TatDSIntfLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CreateDbClientObject',3,tkNone,nil,__CreateDbClientObject,false,0).SetVarArgs([2]);
    DefineMethod('VariantArrayToString',1,tkVariant,nil,__VariantArrayToString,false,0);
    DefineMethod('StringToVariantArray',1,tkVariant,nil,__StringToVariantArray,false,0);
    DefineProp('CLSID_DSBase',tkVariant,__GetCLSID_DSBase,nil,nil,false,0);
    DefineProp('CLSID_DSCursor',tkVariant,__GetCLSID_DSCursor,nil,nil,false,0);
    DefineProp('CLSID_DSWriter',tkVariant,__GetCLSID_DSWriter,nil,nil,false,0);
    AddConstant('keySEARCHEQ',keySEARCHEQ);
    AddConstant('keySEARCHGT',keySEARCHGT);
    AddConstant('keySEARCHGEQ',keySEARCHGEQ);
    AddConstant('grSTATEMIDDLE',grSTATEMIDDLE);
    AddConstant('grSTATEFIRST',grSTATEFIRST);
    AddConstant('grSTATELAST',grSTATELAST);
    AddConstant('grSTATEFIRSTLAST',grSTATEFIRSTLAST);
    AddConstant('aggSTATEUNDEF',aggSTATEUNDEF);
    AddConstant('aggSTATEOK',aggSTATEOK);
    AddConstant('aggSTATEBLANK',aggSTATEBLANK);
    AddConstant('aggSTATEERROR',aggSTATEERROR);
    AddConstant('dspropLOGCHANGES',dspropLOGCHANGES);
    AddConstant('dspropREADONLY',dspropREADONLY);
    AddConstant('dspropNOOFCHANGES',dspropNOOFCHANGES);
    AddConstant('dspropCONSTRAINTS_DISABLED',dspropCONSTRAINTS_DISABLED);
    AddConstant('dspropDSISPARTIAL',dspropDSISPARTIAL);
    AddConstant('dspropRECORDSINDS',dspropRECORDSINDS);
    AddConstant('dspropAUTOINC_DISABLED',dspropAUTOINC_DISABLED);
    AddConstant('dspropISDELTA',dspropISDELTA);
    AddConstant('dspropDONTINCLMETADATA',dspropDONTINCLMETADATA);
    AddConstant('dspropINCLBLOBSINDELTA',dspropINCLBLOBSINDELTA);
    AddConstant('dspropGETSAVEPOINT',dspropGETSAVEPOINT);
    AddConstant('dspropCOMPRESSARRAYS',dspropCOMPRESSARRAYS);
    AddConstant('dspropMD_SEMANTICS',dspropMD_SEMANTICS);
    AddConstant('dspropFIELD_FULLNAME',dspropFIELD_FULLNAME);
    AddConstant('dspropFIELDID_FORNAME',dspropFIELDID_FORNAME);
    AddConstant('dspropFIELDID_FORPARENT',dspropFIELDID_FORPARENT);
    AddConstant('dspropCHANGEINDEX_VIEW',dspropCHANGEINDEX_VIEW);
    AddConstant('dspropGETUNIQUEINDEX',dspropGETUNIQUEINDEX);
    AddConstant('dspropREMOTE_UPDATEMODE',dspropREMOTE_UPDATEMODE);
    AddConstant('dspropXML_STREAMMODE',dspropXML_STREAMMODE);
    AddConstant('dspropDISABLEDELETES',dspropDISABLEDELETES);
    AddConstant('dspropDISABLEINSERTS',dspropDISABLEINSERTS);
    AddConstant('dspropDISABLEEDITS',dspropDISABLEEDITS);
    AddConstant('dspropDISABLESTRINGTRIM',dspropDISABLESTRINGTRIM);
    AddConstant('dspropDATAHASCHANGED',dspropDATAHASCHANGED);
    AddConstant('curpropCONSTRAINT_ERROR_MESSAGE',curpropCONSTRAINT_ERROR_MESSAGE);
    AddConstant('curpropDSBASE',curpropDSBASE);
    AddConstant('curpropSETCRACK',curpropSETCRACK);
    AddConstant('curpropGETORG_RECBUF',curpropGETORG_RECBUF);
    AddConstant('fldAttrArea',fldAttrArea);
    AddConstant('pcktAttrArea',pcktAttrArea);
    AddConstant('fldIsChanged',fldIsChanged);
    AddConstant('fldIsNull',fldIsNull);
    AddConstant('fldIsUnChanged',fldIsUnChanged);
    AddConstant('dsRecUnmodified',dsRecUnmodified);
    AddConstant('dsRecOrg',dsRecOrg);
    AddConstant('dsRecDeleted',dsRecDeleted);
    AddConstant('dsRecNew',dsRecNew);
    AddConstant('dsRecModified',dsRecModified);
    AddConstant('dsUnused',dsUnused);
    AddConstant('dsDetUpd',dsDetUpd);
    AddConstant('dsIsNotVisible',dsIsNotVisible);
    AddConstant('dsIsVisible',dsIsVisible);
    AddConstant('fldAttrHIDDEN',fldAttrHIDDEN);
    AddConstant('fldAttrREADONLY',fldAttrREADONLY);
    AddConstant('fldAttrREQUIRED',fldAttrREQUIRED);
    AddConstant('fldAttrLINK',fldAttrLINK);
    AddConstant('BLANK_NULL',BLANK_NULL);
    AddConstant('BLANK_NOTCHANGED',BLANK_NOTCHANGED);
    AddConstant('MAXKEYFIELDS',MAXKEYFIELDS);
    AddConstant('mdCASCADEDEL',mdCASCADEDEL);
    AddConstant('mdCASCADEMOD',mdCASCADEMOD);
    AddConstant('mdALLOWLINKCHANGE',mdALLOWLINKCHANGE);
    AddConstant('dscbrSKIP',dscbrSKIP);
    AddConstant('dscbrABORT',dscbrABORT);
    AddConstant('dscbrMERGE',dscbrMERGE);
    AddConstant('dscbrAPPLY',dscbrAPPLY);
    AddConstant('dscbrIGNORE',dscbrIGNORE);
    AddConstant('dscbrCORRECT',dscbrCORRECT);
    AddConstant('dscbrCANCEL',dscbrCANCEL);
    AddConstant('dscbrREFRESH',dscbrREFRESH);
    AddConstant('xmlUNTYPED',xmlUNTYPED);
    AddConstant('xmlXMLDATATYPED',xmlXMLDATATYPED);
    AddConstant('xmlXMLSCHEMA',xmlXMLSCHEMA);
    AddConstant('xmlXMLUTF8',xmlXMLUTF8);
    AddConstant('xmlON',xmlON);
    AddConstant('xmlUTF8',xmlUTF8);
    AddConstant('xmlOFF',xmlOFF);
    AddConstant('szUNIQUE_KEY',szUNIQUE_KEY);
    AddConstant('szPRIMARY_KEY',szPRIMARY_KEY);
    AddConstant('szDEFAULT_ORDER',szDEFAULT_ORDER);
    AddConstant('szCHANGEINDEX',szCHANGEINDEX);
    AddConstant('szCHANGE_LOG',szCHANGE_LOG);
    AddConstant('szSERVER_COL',szSERVER_COL);
    AddConstant('szCONSTRAINTS',szCONSTRAINTS);
    AddConstant('szDATASET_CONTEXT',szDATASET_CONTEXT);
    AddConstant('szDATASET_DELTA',szDATASET_DELTA);
    AddConstant('szREADONLY',szREADONLY);
    AddConstant('szSUBTYPE',szSUBTYPE);
    AddConstant('szDECIMALS',szDECIMALS);
    AddConstant('szWIDTH',szWIDTH);
    AddConstant('szFIELDNAME',szFIELDNAME);
    AddConstant('szLCID',szLCID);
    AddConstant('szBDEDOMX',szBDEDOMX);
    AddConstant('szBDERECX',szBDERECX);
    AddConstant('szBDEDEFX',szBDEDEFX);
    AddConstant('szAUTOINCVALUE',szAUTOINCVALUE);
    AddConstant('szELEMENTS',szELEMENTS);
    AddConstant('szTABLE_NAME',szTABLE_NAME);
    AddConstant('szMD_FIELDLINKS',szMD_FIELDLINKS);
    AddConstant('szTYPENAME',szTYPENAME);
    AddConstant('szUPDATEMODE',szUPDATEMODE);
    AddConstant('szFIELDPROPS',szFIELDPROPS);
    AddConstant('szPROVFLAGS',szPROVFLAGS);
    AddConstant('szORIGIN',szORIGIN);
    AddConstant('szMD_SEMANTICS',szMD_SEMANTICS);
    AddConstant('szSERVERCALC',szSERVERCALC);
    AddConstant('szBDEDOMCL',szBDEDOMCL);
    AddConstant('szBDERECCL',szBDERECCL);
    AddConstant('szBDEDEFCL',szBDEDEFCL);
    AddConstant('szDISABLE_INSERTS',szDISABLE_INSERTS);
    AddConstant('szDISABLE_DELETES',szDISABLE_DELETES);
    AddConstant('szDISABLE_EDITS',szDISABLE_EDITS);
    AddConstant('szNO_RESET_CALL',szNO_RESET_CALL);
    AddConstant('szMINVALUE',szMINVALUE);
    AddConstant('szMAXVALUE',szMAXVALUE);
    AddConstant('szstMEMO',szstMEMO);
    AddConstant('szstWideMEMO',szstWideMEMO);
    AddConstant('szstBINARY',szstBINARY);
    AddConstant('szstFMTMEMO',szstFMTMEMO);
    AddConstant('szstOLEOBJ',szstOLEOBJ);
    AddConstant('szstGRAPHIC',szstGRAPHIC);
    AddConstant('szstDBSOLEOBJ',szstDBSOLEOBJ);
    AddConstant('szstTYPEDBINARY',szstTYPEDBINARY);
    AddConstant('szstMONEY',szstMONEY);
    AddConstant('szstAUTOINC',szstAUTOINC);
    AddConstant('szstADTNESTEDTABLE',szstADTNESTEDTABLE);
    AddConstant('szstFIXEDCHAR',szstFIXEDCHAR);
    AddConstant('szstREFNESTEDTABLE',szstREFNESTEDTABLE);
    AddConstant('szstGUID',szstGUID);
    AddConstant('szstACCOLEOBJ',szstACCOLEOBJ);
    AddConstant('szstHMEMO',szstHMEMO);
    AddConstant('szstHBINARY',szstHBINARY);
    AddConstant('fldstReference',fldstReference);
    AddConstant('dsfldUNKNOWN',dsfldUNKNOWN);
    AddConstant('dsfldINT',dsfldINT);
    AddConstant('dsfldUINT',dsfldUINT);
    AddConstant('dsfldBOOL',dsfldBOOL);
    AddConstant('dsfldFLOATIEEE',dsfldFLOATIEEE);
    AddConstant('dsfldBCD',dsfldBCD);
    AddConstant('dsfldDATE',dsfldDATE);
    AddConstant('dsfldTIME',dsfldTIME);
    AddConstant('dsfldTIMESTAMP',dsfldTIMESTAMP);
    AddConstant('dsfldZSTRING',dsfldZSTRING);
    AddConstant('dsfldUNICODE',dsfldUNICODE);
    AddConstant('dsfldBYTES',dsfldBYTES);
    AddConstant('dsfldADT',dsfldADT);
    AddConstant('dsfldARRAY',dsfldARRAY);
    AddConstant('dsfldEMBEDDEDTBL',dsfldEMBEDDEDTBL);
    AddConstant('dsfldREF',dsfldREF);
    AddConstant('dsfldDATETIME',dsfldDATETIME);
    AddConstant('dsfldFMTBCD',dsfldFMTBCD);
    AddConstant('dsSizeBitsLen',dsSizeBitsLen);
    AddConstant('dsSizeBitsMask',dsSizeBitsMask);
    AddConstant('dsTypeBitsMask',dsTypeBitsMask);
    AddConstant('dsVaryingFldType',dsVaryingFldType);
    AddConstant('dsArrayFldType',dsArrayFldType);
    AddConstant('dsPseudoFldType',dsPseudoFldType);
    AddConstant('dsCompArrayFldType',dsCompArrayFldType);
    AddConstant('dsEmbeddedFldType',dsEmbeddedFldType);
    AddConstant('dsIncInDelta',dsIncInDelta);
    AddConstant('dskeyCASEINSENSITIVE',dskeyCASEINSENSITIVE);
    AddConstant('dskeyDESCENDING',dskeyDESCENDING);
    AddConstant('dsDELAYEDBIT',dsDELAYEDBIT);
    AddConstant('PACKETVERSION_1',PACKETVERSION_1);
    AddConstant('PACKETVERSION_2',PACKETVERSION_2);
    AddConstant('PACKETVERSION_3',PACKETVERSION_3);
    AddConstant('dsCASCADEDELETES',dsCASCADEDELETES);
    AddConstant('dsCASCADEUPDATES',dsCASCADEUPDATES);
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
    AddConstant('fldUNICODE',fldUNICODE);
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
    AddConstant('fldstGUID',fldstGUID);
    AddConstant('fldstORAINTERVAL',fldstORAINTERVAL);
    AddConstant('fldstORATIMESTAMP',fldstORATIMESTAMP);
    AddConstant('fldstAUTOINC',fldstAUTOINC);
    AddConstant('DBERR_NONE',DBERR_NONE);
    AddConstant('DBERR_BOF',DBERR_BOF);
    AddConstant('DBERR_EOF',DBERR_EOF);
    AddConstant('DBERR_NOSUCHINDEX',DBERR_NOSUCHINDEX);
    AddConstant('ERRCAT_ALC',ERRCAT_ALC);
    AddConstant('ERRBASE_ALC',ERRBASE_ALC);
    AddConstant('ERRCODE_DELTAISEMPTY',ERRCODE_DELTAISEMPTY);
    AddConstant('ERRCODE_NOTHINGTOUNDO',ERRCODE_NOTHINGTOUNDO);
    AddConstant('ERRCODE_NOMETADATA',ERRCODE_NOMETADATA);
    AddConstant('ERRCODE_CANNOTAPPEND',ERRCODE_CANNOTAPPEND);
    AddConstant('ERRCODE_DATAPACKETMISMATCH',ERRCODE_DATAPACKETMISMATCH);
    AddConstant('ERRCODE_ABORTED',ERRCODE_ABORTED);
    AddConstant('ERRCODE_CANCELLED',ERRCODE_CANCELLED);
    AddConstant('ERRCODE_NEWERVERSIONREQ',ERRCODE_NEWERVERSIONREQ);
    AddConstant('ERRCODE_BLOBNOTFETCHED',ERRCODE_BLOBNOTFETCHED);
    AddConstant('ERRCODE_DETAILSNOTFETCHED',ERRCODE_DETAILSNOTFETCHED);
    AddConstant('ERRCODE_NOMASTERRECORD',ERRCODE_NOMASTERRECORD);
    AddConstant('ERRCODE_LINKFIELDSNOTUNIQUE',ERRCODE_LINKFIELDSNOTUNIQUE);
    AddConstant('ERRCODE_FLYAWAY_WRONGORDER',ERRCODE_FLYAWAY_WRONGORDER);
    AddConstant('ERRCODE_NOCASCADEDUPDATES',ERRCODE_NOCASCADEDUPDATES);
    AddConstant('DBERR_DELTAISEMPTY',DBERR_DELTAISEMPTY);
    AddConstant('DBERR_NOTHINGTOUNDO',DBERR_NOTHINGTOUNDO);
    AddConstant('DBERR_NOMETADATA',DBERR_NOMETADATA);
    AddConstant('DBERR_CANNOTAPPEND',DBERR_CANNOTAPPEND);
    AddConstant('DBERR_DATAPACKETMISMATCH',DBERR_DATAPACKETMISMATCH);
    AddConstant('DBERR_ABORTED',DBERR_ABORTED);
    AddConstant('DBERR_CANCELLED',DBERR_CANCELLED);
    AddConstant('DBERR_NEWERVERSIONREQ',DBERR_NEWERVERSIONREQ);
    AddConstant('DBERR_BLOBNOTFETCHED',DBERR_BLOBNOTFETCHED);
    AddConstant('DBERR_DETAILSNOTFETCHED',DBERR_DETAILSNOTFETCHED);
    AddConstant('DBERR_NOMASTERRECORD',DBERR_NOMASTERRECORD);
    AddConstant('DBERR_LINKFIELDSNOTUNIQUE',DBERR_LINKFIELDSNOTUNIQUE);
    AddConstant('DBERR_FLYAWAY_WRONGORDER',DBERR_FLYAWAY_WRONGORDER);
    AddConstant('DBERR_NOCASCADEDUPDATES',DBERR_NOCASCADEDUPDATES);
  end;
end;

class function TatDSIntfLibrary.LibraryName: string;
begin
  result := 'DSIntf';
end;

initialization
  RegisterScripterLibrary(TatDSIntfLibrary, True);

{$WARNINGS ON}

end.

