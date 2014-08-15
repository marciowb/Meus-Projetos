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
unit ap_ADOInt;

interface

uses
  Windows,
  ActiveX,
  ADOInt,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatADOIntLibrary = class(TatScripterLibrary)
    procedure __GetLIBID_ADODB(AMachine: TatVirtualMachine);
    procedure __GetCLASS_Connection(AMachine: TatVirtualMachine);
    procedure __GetCLASS_Command(AMachine: TatVirtualMachine);
    procedure __GetCLASS_Recordset(AMachine: TatVirtualMachine);
    procedure __GetCLASS_Parameter(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DataSpace(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DataFactory(AMachine: TatVirtualMachine);
    procedure __GetIID__Collection(AMachine: TatVirtualMachine);
    procedure __GetIID__DynaCollection(AMachine: TatVirtualMachine);
    procedure __GetIID__ADO(AMachine: TatVirtualMachine);
    procedure __GetIID_Properties(AMachine: TatVirtualMachine);
    procedure __GetIID_Property_(AMachine: TatVirtualMachine);
    procedure __GetIID_Error(AMachine: TatVirtualMachine);
    procedure __GetIID_Errors(AMachine: TatVirtualMachine);
    procedure __GetIID_Command15(AMachine: TatVirtualMachine);
    procedure __GetIID_Connection15(AMachine: TatVirtualMachine);
    procedure __GetIID__Connection(AMachine: TatVirtualMachine);
    procedure __GetIID_Recordset15(AMachine: TatVirtualMachine);
    procedure __GetIID_Recordset20(AMachine: TatVirtualMachine);
    procedure __GetIID__Recordset(AMachine: TatVirtualMachine);
    procedure __GetIID_Fields15(AMachine: TatVirtualMachine);
    procedure __GetIID_Fields(AMachine: TatVirtualMachine);
    procedure __GetIID_Field(AMachine: TatVirtualMachine);
    procedure __GetIID__Parameter(AMachine: TatVirtualMachine);
    procedure __GetIID_Parameters(AMachine: TatVirtualMachine);
    procedure __GetIID__Command(AMachine: TatVirtualMachine);
    procedure __GetIID_ConnectionEventsVt(AMachine: TatVirtualMachine);
    procedure __GetDIID_ConnectionEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_RecordsetEventsVt(AMachine: TatVirtualMachine);
    procedure __GetDIID_RecordsetEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_ADOConnectionConstruction15(AMachine: TatVirtualMachine);
    procedure __GetIID_ADOConnectionConstruction(AMachine: TatVirtualMachine);
    procedure __GetIID_ADOCommandConstruction(AMachine: TatVirtualMachine);
    procedure __GetIID_ADORecordsetConstruction(AMachine: TatVirtualMachine);
    procedure __GetIID_Field15(AMachine: TatVirtualMachine);
    procedure __GetIID_IDataspace(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  CoConnectionClass = class of CoConnection;
  CoCommandClass = class of CoCommand;
  CoRecordsetClass = class of CoRecordset;
  CoParameterClass = class of CoParameter;



implementation



procedure TatADOIntLibrary.__GetLIBID_ADODB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.LIBID_ADODB)));
  end;
end;

procedure TatADOIntLibrary.__GetCLASS_Connection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.CLASS_Connection)));
  end;
end;

procedure TatADOIntLibrary.__GetCLASS_Command(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.CLASS_Command)));
  end;
end;

procedure TatADOIntLibrary.__GetCLASS_Recordset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.CLASS_Recordset)));
  end;
end;

procedure TatADOIntLibrary.__GetCLASS_Parameter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.CLASS_Parameter)));
  end;
end;

procedure TatADOIntLibrary.__GetCLASS_DataSpace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.CLASS_DataSpace)));
  end;
end;

procedure TatADOIntLibrary.__GetCLASS_DataFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.CLASS_DataFactory)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__Collection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__Collection)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__DynaCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__DynaCollection)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__ADO(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__ADO)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Properties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Properties)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Property_(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Property_)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Error(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Error)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Errors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Errors)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Command15(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Command15)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Connection15(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Connection15)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__Connection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__Connection)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Recordset15(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Recordset15)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Recordset20(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Recordset20)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__Recordset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__Recordset)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Fields15(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Fields15)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Fields(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Fields)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Field(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Field)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__Parameter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__Parameter)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Parameters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Parameters)));
  end;
end;

procedure TatADOIntLibrary.__GetIID__Command(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID__Command)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_ConnectionEventsVt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_ConnectionEventsVt)));
  end;
end;

procedure TatADOIntLibrary.__GetDIID_ConnectionEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.DIID_ConnectionEvents)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_RecordsetEventsVt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_RecordsetEventsVt)));
  end;
end;

procedure TatADOIntLibrary.__GetDIID_RecordsetEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.DIID_RecordsetEvents)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_ADOConnectionConstruction15(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_ADOConnectionConstruction15)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_ADOConnectionConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_ADOConnectionConstruction)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_ADOCommandConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_ADOCommandConstruction)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_ADORecordsetConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_ADORecordsetConstruction)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_Field15(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_Field15)));
  end;
end;

procedure TatADOIntLibrary.__GetIID_IDataspace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ADOInt.IID_IDataspace)));
  end;
end;

procedure TatADOIntLibrary.Init;
begin
  With Scripter.DefineClass(CoConnection) do
  begin
  end;
  With Scripter.DefineClass(CoCommand) do
  begin
  end;
  With Scripter.DefineClass(CoRecordset) do
  begin
  end;
  With Scripter.DefineClass(CoParameter) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_ADODB',tkVariant,__GetLIBID_ADODB,nil,nil,false,0);
    DefineProp('CLASS_Connection',tkVariant,__GetCLASS_Connection,nil,nil,false,0);
    DefineProp('CLASS_Command',tkVariant,__GetCLASS_Command,nil,nil,false,0);
    DefineProp('CLASS_Recordset',tkVariant,__GetCLASS_Recordset,nil,nil,false,0);
    DefineProp('CLASS_Parameter',tkVariant,__GetCLASS_Parameter,nil,nil,false,0);
    DefineProp('CLASS_DataSpace',tkVariant,__GetCLASS_DataSpace,nil,nil,false,0);
    DefineProp('CLASS_DataFactory',tkVariant,__GetCLASS_DataFactory,nil,nil,false,0);
    DefineProp('IID__Collection',tkVariant,__GetIID__Collection,nil,nil,false,0);
    DefineProp('IID__DynaCollection',tkVariant,__GetIID__DynaCollection,nil,nil,false,0);
    DefineProp('IID__ADO',tkVariant,__GetIID__ADO,nil,nil,false,0);
    DefineProp('IID_Properties',tkVariant,__GetIID_Properties,nil,nil,false,0);
    DefineProp('IID_Property_',tkVariant,__GetIID_Property_,nil,nil,false,0);
    DefineProp('IID_Error',tkVariant,__GetIID_Error,nil,nil,false,0);
    DefineProp('IID_Errors',tkVariant,__GetIID_Errors,nil,nil,false,0);
    DefineProp('IID_Command15',tkVariant,__GetIID_Command15,nil,nil,false,0);
    DefineProp('IID_Connection15',tkVariant,__GetIID_Connection15,nil,nil,false,0);
    DefineProp('IID__Connection',tkVariant,__GetIID__Connection,nil,nil,false,0);
    DefineProp('IID_Recordset15',tkVariant,__GetIID_Recordset15,nil,nil,false,0);
    DefineProp('IID_Recordset20',tkVariant,__GetIID_Recordset20,nil,nil,false,0);
    DefineProp('IID__Recordset',tkVariant,__GetIID__Recordset,nil,nil,false,0);
    DefineProp('IID_Fields15',tkVariant,__GetIID_Fields15,nil,nil,false,0);
    DefineProp('IID_Fields',tkVariant,__GetIID_Fields,nil,nil,false,0);
    DefineProp('IID_Field',tkVariant,__GetIID_Field,nil,nil,false,0);
    DefineProp('IID__Parameter',tkVariant,__GetIID__Parameter,nil,nil,false,0);
    DefineProp('IID_Parameters',tkVariant,__GetIID_Parameters,nil,nil,false,0);
    DefineProp('IID__Command',tkVariant,__GetIID__Command,nil,nil,false,0);
    DefineProp('IID_ConnectionEventsVt',tkVariant,__GetIID_ConnectionEventsVt,nil,nil,false,0);
    DefineProp('DIID_ConnectionEvents',tkVariant,__GetDIID_ConnectionEvents,nil,nil,false,0);
    DefineProp('IID_RecordsetEventsVt',tkVariant,__GetIID_RecordsetEventsVt,nil,nil,false,0);
    DefineProp('DIID_RecordsetEvents',tkVariant,__GetDIID_RecordsetEvents,nil,nil,false,0);
    DefineProp('IID_ADOConnectionConstruction15',tkVariant,__GetIID_ADOConnectionConstruction15,nil,nil,false,0);
    DefineProp('IID_ADOConnectionConstruction',tkVariant,__GetIID_ADOConnectionConstruction,nil,nil,false,0);
    DefineProp('IID_ADOCommandConstruction',tkVariant,__GetIID_ADOCommandConstruction,nil,nil,false,0);
    DefineProp('IID_ADORecordsetConstruction',tkVariant,__GetIID_ADORecordsetConstruction,nil,nil,false,0);
    DefineProp('IID_Field15',tkVariant,__GetIID_Field15,nil,nil,false,0);
    DefineProp('IID_IDataspace',tkVariant,__GetIID_IDataspace,nil,nil,false,0);
    AddConstant('CT_USERID',CT_USERID);
    AddConstant('CT_PROVIDER',CT_PROVIDER);
    AddConstant('CT_FILENAME',CT_FILENAME);
    AddConstant('adOpenUnspecified',adOpenUnspecified);
    AddConstant('adOpenForwardOnly',adOpenForwardOnly);
    AddConstant('adOpenKeyset',adOpenKeyset);
    AddConstant('adOpenDynamic',adOpenDynamic);
    AddConstant('adOpenStatic',adOpenStatic);
    AddConstant('adHoldRecords',adHoldRecords);
    AddConstant('adMovePrevious',adMovePrevious);
    AddConstant('adAddNew',adAddNew);
    AddConstant('adDelete',adDelete);
    AddConstant('adUpdate',adUpdate);
    AddConstant('adBookmark',adBookmark);
    AddConstant('adApproxPosition',adApproxPosition);
    AddConstant('adUpdateBatch',adUpdateBatch);
    AddConstant('adResync',adResync);
    AddConstant('adNotify',adNotify);
    AddConstant('adFind',adFind);
    AddConstant('adSeek',adSeek);
    AddConstant('adIndex',adIndex);
    AddConstant('adLockUnspecified',adLockUnspecified);
    AddConstant('adLockReadOnly',adLockReadOnly);
    AddConstant('adLockPessimistic',adLockPessimistic);
    AddConstant('adLockOptimistic',adLockOptimistic);
    AddConstant('adLockBatchOptimistic',adLockBatchOptimistic);
    AddConstant('adOptionUnspecified',adOptionUnspecified);
    AddConstant('adAsyncExecute',adAsyncExecute);
    AddConstant('adAsyncFetch',adAsyncFetch);
    AddConstant('adAsyncFetchNonBlocking',adAsyncFetchNonBlocking);
    AddConstant('adExecuteNoRecords',adExecuteNoRecords);
    AddConstant('adConnectUnspecified',adConnectUnspecified);
    AddConstant('adAsyncConnect',adAsyncConnect);
    AddConstant('adStateClosed',adStateClosed);
    AddConstant('adStateOpen',adStateOpen);
    AddConstant('adStateConnecting',adStateConnecting);
    AddConstant('adStateExecuting',adStateExecuting);
    AddConstant('adStateFetching',adStateFetching);
    AddConstant('adUseNone',adUseNone);
    AddConstant('adUseServer',adUseServer);
    AddConstant('adUseClient',adUseClient);
    AddConstant('adUseClientBatch',adUseClientBatch);
    AddConstant('adEmpty',adEmpty);
    AddConstant('adTinyInt',adTinyInt);
    AddConstant('adSmallInt',adSmallInt);
    AddConstant('adInteger',adInteger);
    AddConstant('adBigInt',adBigInt);
    AddConstant('adUnsignedTinyInt',adUnsignedTinyInt);
    AddConstant('adUnsignedSmallInt',adUnsignedSmallInt);
    AddConstant('adUnsignedInt',adUnsignedInt);
    AddConstant('adUnsignedBigInt',adUnsignedBigInt);
    AddConstant('adSingle',adSingle);
    AddConstant('adDouble',adDouble);
    AddConstant('adCurrency',adCurrency);
    AddConstant('adDecimal',adDecimal);
    AddConstant('adNumeric',adNumeric);
    AddConstant('adBoolean',adBoolean);
    AddConstant('adError',adError);
    AddConstant('adUserDefined',adUserDefined);
    AddConstant('adVariant',adVariant);
    AddConstant('adIDispatch',adIDispatch);
    AddConstant('adIUnknown',adIUnknown);
    AddConstant('adGUID',adGUID);
    AddConstant('adDate',adDate);
    AddConstant('adDBDate',adDBDate);
    AddConstant('adDBTime',adDBTime);
    AddConstant('adDBTimeStamp',adDBTimeStamp);
    AddConstant('adBSTR',adBSTR);
    AddConstant('adChar',adChar);
    AddConstant('adVarChar',adVarChar);
    AddConstant('adLongVarChar',adLongVarChar);
    AddConstant('adWChar',adWChar);
    AddConstant('adVarWChar',adVarWChar);
    AddConstant('adLongVarWChar',adLongVarWChar);
    AddConstant('adBinary',adBinary);
    AddConstant('adVarBinary',adVarBinary);
    AddConstant('adLongVarBinary',adLongVarBinary);
    AddConstant('adChapter',adChapter);
    AddConstant('adFileTime',adFileTime);
    AddConstant('adDBFileTime',adDBFileTime);
    AddConstant('adPropVariant',adPropVariant);
    AddConstant('adVarNumeric',adVarNumeric);
    AddConstant('adFldUnspecified',adFldUnspecified);
    AddConstant('adFldMayDefer',adFldMayDefer);
    AddConstant('adFldUpdatable',adFldUpdatable);
    AddConstant('adFldUnknownUpdatable',adFldUnknownUpdatable);
    AddConstant('adFldFixed',adFldFixed);
    AddConstant('adFldIsNullable',adFldIsNullable);
    AddConstant('adFldMayBeNull',adFldMayBeNull);
    AddConstant('adFldLong',adFldLong);
    AddConstant('adFldRowID',adFldRowID);
    AddConstant('adFldRowVersion',adFldRowVersion);
    AddConstant('adFldCacheDeferred',adFldCacheDeferred);
    AddConstant('adFldNegativeScale',adFldNegativeScale);
    AddConstant('adFldKeyColumn',adFldKeyColumn);
    AddConstant('adEditNone',adEditNone);
    AddConstant('adEditInProgress',adEditInProgress);
    AddConstant('adEditAdd',adEditAdd);
    AddConstant('adEditDelete',adEditDelete);
    AddConstant('adRecOK',adRecOK);
    AddConstant('adRecNew',adRecNew);
    AddConstant('adRecModified',adRecModified);
    AddConstant('adRecDeleted',adRecDeleted);
    AddConstant('adRecUnmodified',adRecUnmodified);
    AddConstant('adRecInvalid',adRecInvalid);
    AddConstant('adRecMultipleChanges',adRecMultipleChanges);
    AddConstant('adRecPendingChanges',adRecPendingChanges);
    AddConstant('adRecCanceled',adRecCanceled);
    AddConstant('adRecCantRelease',adRecCantRelease);
    AddConstant('adRecConcurrencyViolation',adRecConcurrencyViolation);
    AddConstant('adRecIntegrityViolation',adRecIntegrityViolation);
    AddConstant('adRecMaxChangesExceeded',adRecMaxChangesExceeded);
    AddConstant('adRecObjectOpen',adRecObjectOpen);
    AddConstant('adRecOutOfMemory',adRecOutOfMemory);
    AddConstant('adRecPermissionDenied',adRecPermissionDenied);
    AddConstant('adRecSchemaViolation',adRecSchemaViolation);
    AddConstant('adRecDBDeleted',adRecDBDeleted);
    AddConstant('adGetRowsRest',adGetRowsRest);
    AddConstant('adPosUnknown',adPosUnknown);
    AddConstant('adPosBOF',adPosBOF);
    AddConstant('adPosEOF',adPosEOF);
    AddConstant('adBookmarkCurrent',adBookmarkCurrent);
    AddConstant('adBookmarkFirst',adBookmarkFirst);
    AddConstant('adBookmarkLast',adBookmarkLast);
    AddConstant('adMarshalAll',adMarshalAll);
    AddConstant('adMarshalModifiedOnly',adMarshalModifiedOnly);
    AddConstant('adAffectCurrent',adAffectCurrent);
    AddConstant('adAffectGroup',adAffectGroup);
    AddConstant('adAffectAll',adAffectAll);
    AddConstant('adAffectAllChapters',adAffectAllChapters);
    AddConstant('adResyncUnderlyingValues',adResyncUnderlyingValues);
    AddConstant('adResyncAllValues',adResyncAllValues);
    AddConstant('adCompareLessThan',adCompareLessThan);
    AddConstant('adCompareEqual',adCompareEqual);
    AddConstant('adCompareGreaterThan',adCompareGreaterThan);
    AddConstant('adCompareNotEqual',adCompareNotEqual);
    AddConstant('adCompareNotComparable',adCompareNotComparable);
    AddConstant('adFilterNone',adFilterNone);
    AddConstant('adFilterPendingRecords',adFilterPendingRecords);
    AddConstant('adFilterAffectedRecords',adFilterAffectedRecords);
    AddConstant('adFilterFetchedRecords',adFilterFetchedRecords);
    AddConstant('adFilterPredicate',adFilterPredicate);
    AddConstant('adFilterConflictingRecords',adFilterConflictingRecords);
    AddConstant('adSearchForward',adSearchForward);
    AddConstant('adSearchBackward',adSearchBackward);
    AddConstant('adPersistADTG',adPersistADTG);
    AddConstant('adPersistXML',adPersistXML);
    AddConstant('adClipString',adClipString);
    AddConstant('adPromptAlways',adPromptAlways);
    AddConstant('adPromptComplete',adPromptComplete);
    AddConstant('adPromptCompleteRequired',adPromptCompleteRequired);
    AddConstant('adPromptNever',adPromptNever);
    AddConstant('adModeUnknown',adModeUnknown);
    AddConstant('adModeRead',adModeRead);
    AddConstant('adModeWrite',adModeWrite);
    AddConstant('adModeReadWrite',adModeReadWrite);
    AddConstant('adModeShareDenyRead',adModeShareDenyRead);
    AddConstant('adModeShareDenyWrite',adModeShareDenyWrite);
    AddConstant('adModeShareExclusive',adModeShareExclusive);
    AddConstant('adModeShareDenyNone',adModeShareDenyNone);
    AddConstant('adXactUnspecified',adXactUnspecified);
    AddConstant('adXactChaos',adXactChaos);
    AddConstant('adXactReadUncommitted',adXactReadUncommitted);
    AddConstant('adXactBrowse',adXactBrowse);
    AddConstant('adXactCursorStability',adXactCursorStability);
    AddConstant('adXactReadCommitted',adXactReadCommitted);
    AddConstant('adXactRepeatableRead',adXactRepeatableRead);
    AddConstant('adXactSerializable',adXactSerializable);
    AddConstant('adXactIsolated',adXactIsolated);
    AddConstant('adXactCommitRetaining',adXactCommitRetaining);
    AddConstant('adXactAbortRetaining',adXactAbortRetaining);
    AddConstant('adXactAsyncPhaseOne',adXactAsyncPhaseOne);
    AddConstant('adXactSyncPhaseOne',adXactSyncPhaseOne);
    AddConstant('adPropNotSupported',adPropNotSupported);
    AddConstant('adPropRequired',adPropRequired);
    AddConstant('adPropOptional',adPropOptional);
    AddConstant('adPropRead',adPropRead);
    AddConstant('adPropWrite',adPropWrite);
    AddConstant('adErrInvalidArgument',adErrInvalidArgument);
    AddConstant('adErrNoCurrentRecord',adErrNoCurrentRecord);
    AddConstant('adErrIllegalOperation',adErrIllegalOperation);
    AddConstant('adErrInTransaction',adErrInTransaction);
    AddConstant('adErrFeatureNotAvailable',adErrFeatureNotAvailable);
    AddConstant('adErrItemNotFound',adErrItemNotFound);
    AddConstant('adErrObjectInCollection',adErrObjectInCollection);
    AddConstant('adErrObjectNotSet',adErrObjectNotSet);
    AddConstant('adErrDataConversion',adErrDataConversion);
    AddConstant('adErrObjectClosed',adErrObjectClosed);
    AddConstant('adErrObjectOpen',adErrObjectOpen);
    AddConstant('adErrProviderNotFound',adErrProviderNotFound);
    AddConstant('adErrBoundToCommand',adErrBoundToCommand);
    AddConstant('adErrInvalidParamInfo',adErrInvalidParamInfo);
    AddConstant('adErrInvalidConnection',adErrInvalidConnection);
    AddConstant('adErrNotReentrant',adErrNotReentrant);
    AddConstant('adErrStillExecuting',adErrStillExecuting);
    AddConstant('adErrOperationCancelled',adErrOperationCancelled);
    AddConstant('adErrStillConnecting',adErrStillConnecting);
    AddConstant('adErrNotExecuting',adErrNotExecuting);
    AddConstant('adErrUnsafeOperation',adErrUnsafeOperation);
    AddConstant('adParamSigned',adParamSigned);
    AddConstant('adParamNullable',adParamNullable);
    AddConstant('adParamLong',adParamLong);
    AddConstant('adParamUnknown',adParamUnknown);
    AddConstant('adParamInput',adParamInput);
    AddConstant('adParamOutput',adParamOutput);
    AddConstant('adParamInputOutput',adParamInputOutput);
    AddConstant('adParamReturnValue',adParamReturnValue);
    AddConstant('adCmdUnspecified',adCmdUnspecified);
    AddConstant('adCmdUnknown',adCmdUnknown);
    AddConstant('adCmdText',adCmdText);
    AddConstant('adCmdTable',adCmdTable);
    AddConstant('adCmdStoredProc',adCmdStoredProc);
    AddConstant('adCmdFile',adCmdFile);
    AddConstant('adCmdTableDirect',adCmdTableDirect);
    AddConstant('adStatusOK',adStatusOK);
    AddConstant('adStatusErrorsOccurred',adStatusErrorsOccurred);
    AddConstant('adStatusCantDeny',adStatusCantDeny);
    AddConstant('adStatusCancel',adStatusCancel);
    AddConstant('adStatusUnwantedEvent',adStatusUnwantedEvent);
    AddConstant('adRsnAddNew',adRsnAddNew);
    AddConstant('adRsnDelete',adRsnDelete);
    AddConstant('adRsnUpdate',adRsnUpdate);
    AddConstant('adRsnUndoUpdate',adRsnUndoUpdate);
    AddConstant('adRsnUndoAddNew',adRsnUndoAddNew);
    AddConstant('adRsnUndoDelete',adRsnUndoDelete);
    AddConstant('adRsnRequery',adRsnRequery);
    AddConstant('adRsnResynch',adRsnResynch);
    AddConstant('adRsnClose',adRsnClose);
    AddConstant('adRsnMove',adRsnMove);
    AddConstant('adRsnFirstChange',adRsnFirstChange);
    AddConstant('adRsnMoveFirst',adRsnMoveFirst);
    AddConstant('adRsnMoveNext',adRsnMoveNext);
    AddConstant('adRsnMovePrevious',adRsnMovePrevious);
    AddConstant('adRsnMoveLast',adRsnMoveLast);
    AddConstant('adSchemaProviderSpecific',adSchemaProviderSpecific);
    AddConstant('adSchemaAsserts',adSchemaAsserts);
    AddConstant('adSchemaCatalogs',adSchemaCatalogs);
    AddConstant('adSchemaCharacterSets',adSchemaCharacterSets);
    AddConstant('adSchemaCollations',adSchemaCollations);
    AddConstant('adSchemaColumns',adSchemaColumns);
    AddConstant('adSchemaCheckConstraints',adSchemaCheckConstraints);
    AddConstant('adSchemaConstraintColumnUsage',adSchemaConstraintColumnUsage);
    AddConstant('adSchemaConstraintTableUsage',adSchemaConstraintTableUsage);
    AddConstant('adSchemaKeyColumnUsage',adSchemaKeyColumnUsage);
    AddConstant('adSchemaReferentialConstraints',adSchemaReferentialConstraints);
    AddConstant('adSchemaTableConstraints',adSchemaTableConstraints);
    AddConstant('adSchemaColumnsDomainUsage',adSchemaColumnsDomainUsage);
    AddConstant('adSchemaIndexes',adSchemaIndexes);
    AddConstant('adSchemaColumnPrivileges',adSchemaColumnPrivileges);
    AddConstant('adSchemaTablePrivileges',adSchemaTablePrivileges);
    AddConstant('adSchemaUsagePrivileges',adSchemaUsagePrivileges);
    AddConstant('adSchemaProcedures',adSchemaProcedures);
    AddConstant('adSchemaSchemata',adSchemaSchemata);
    AddConstant('adSchemaSQLLanguages',adSchemaSQLLanguages);
    AddConstant('adSchemaStatistics',adSchemaStatistics);
    AddConstant('adSchemaTables',adSchemaTables);
    AddConstant('adSchemaTranslations',adSchemaTranslations);
    AddConstant('adSchemaProviderTypes',adSchemaProviderTypes);
    AddConstant('adSchemaViews',adSchemaViews);
    AddConstant('adSchemaViewColumnUsage',adSchemaViewColumnUsage);
    AddConstant('adSchemaViewTableUsage',adSchemaViewTableUsage);
    AddConstant('adSchemaProcedureParameters',adSchemaProcedureParameters);
    AddConstant('adSchemaForeignKeys',adSchemaForeignKeys);
    AddConstant('adSchemaPrimaryKeys',adSchemaPrimaryKeys);
    AddConstant('adSchemaProcedureColumns',adSchemaProcedureColumns);
    AddConstant('adSchemaDBInfoKeywords',adSchemaDBInfoKeywords);
    AddConstant('adSchemaDBInfoLiterals',adSchemaDBInfoLiterals);
    AddConstant('adSchemaCubes',adSchemaCubes);
    AddConstant('adSchemaDimensions',adSchemaDimensions);
    AddConstant('adSchemaHierarchies',adSchemaHierarchies);
    AddConstant('adSchemaLevels',adSchemaLevels);
    AddConstant('adSchemaMeasures',adSchemaMeasures);
    AddConstant('adSchemaProperties',adSchemaProperties);
    AddConstant('adSchemaMembers',adSchemaMembers);
    AddConstant('adSchemaTrustees',adSchemaTrustees);
    AddConstant('adSeekFirstEQ',adSeekFirstEQ);
    AddConstant('adSeekLastEQ',adSeekLastEQ);
    AddConstant('adSeekAfterEQ',adSeekAfterEQ);
    AddConstant('adSeekAfter',adSeekAfter);
    AddConstant('adSeekBeforeEQ',adSeekBeforeEQ);
    AddConstant('adSeekBefore',adSeekBefore);
    AddConstant('adCriteriaKey',adCriteriaKey);
    AddConstant('adCriteriaAllCols',adCriteriaAllCols);
    AddConstant('adCriteriaUpdCols',adCriteriaUpdCols);
    AddConstant('adCriteriaTimeStamp',adCriteriaTimeStamp);
    AddConstant('adPriorityLowest',adPriorityLowest);
    AddConstant('adPriorityBelowNormal',adPriorityBelowNormal);
    AddConstant('adPriorityNormal',adPriorityNormal);
    AddConstant('adPriorityAboveNormal',adPriorityAboveNormal);
    AddConstant('adPriorityHighest',adPriorityHighest);
    AddConstant('adResyncNone',adResyncNone);
    AddConstant('adResyncAutoIncrement',adResyncAutoIncrement);
    AddConstant('adResyncConflicts',adResyncConflicts);
    AddConstant('adResyncUpdates',adResyncUpdates);
    AddConstant('adResyncInserts',adResyncInserts);
    AddConstant('adResyncAll',adResyncAll);
    AddConstant('adRecalcUpFront',adRecalcUpFront);
    AddConstant('adRecalcAlways',adRecalcAlways);
  end;
end;

class function TatADOIntLibrary.LibraryName: string;
begin
  result := 'ADOInt';
end;

initialization
  RegisterScripterLibrary(TatADOIntLibrary, True);

{$WARNINGS ON}

end.

