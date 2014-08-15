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
unit ap_IB;

interface

uses
  Windows,
  SysUtils,
  Classes,
  IBHeader,
  IBExternals,
  IBUtils,
  DB,
  IBXConst,
  IB,
  Variants,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatIBLibrary = class(TatScripterLibrary)
    procedure __EIBErrorCreate(AMachine: TatVirtualMachine);
    procedure __GetEIBErrorSQLCode(AMachine: TatVirtualMachine);
    procedure __GetEIBErrorIBErrorCode(AMachine: TatVirtualMachine);
    procedure __IBAlloc(AMachine: TatVirtualMachine);
    procedure __IBDataBaseError(AMachine: TatVirtualMachine);
    procedure __StatusVectorAsText(AMachine: TatVirtualMachine);
    procedure __SetIBDataBaseErrorMessages(AMachine: TatVirtualMachine);
    procedure __GetIBDataBaseErrorMessages(AMachine: TatVirtualMachine);
    procedure __GetIBCS(AMachine: TatVirtualMachine);
    procedure __SetIBCS(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EIBErrorClass = class of EIBError;
  EIBInterBaseErrorClass = class of EIBInterBaseError;
  EIBInterBaseRoleErrorClass = class of EIBInterBaseRoleError;
  EIBClientErrorClass = class of EIBClientError;



implementation



procedure TatIBLibrary.__EIBErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EIBErrorClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBLibrary.__GetEIBErrorSQLCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EIBError(CurrentObject).SQLCode));
  end;
end;

procedure TatIBLibrary.__GetEIBErrorIBErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EIBError(CurrentObject).IBErrorCode));
  end;
end;

procedure TatIBLibrary.__IBAlloc(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    IB.IBAlloc(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatIBLibrary.__IBDataBaseError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IB.IBDataBaseError;
  end;
end;

procedure TatIBLibrary.__StatusVectorAsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IB.StatusVectorAsText;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBLibrary.__SetIBDataBaseErrorMessages(AMachine: TatVirtualMachine);
  var
  Param0: TIBDataBaseErrorMessages;
begin
  with AMachine do
  begin
IntToSet(Param0, VarToInteger(GetInputArg(0)), SizeOf(Param0));
    IB.SetIBDataBaseErrorMessages(Param0);
  end;
end;

procedure TatIBLibrary.__GetIBDataBaseErrorMessages(AMachine: TatVirtualMachine);
  var
  AResultSet: TIBDataBaseErrorMessages;
  AResult: variant;
begin
  with AMachine do
  begin
AResultSet := IB.GetIBDataBaseErrorMessages;
AResult := IntFromSet(AResultSet, SizeOf(AResultSet));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBLibrary.__GetIBCS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(_RTL_CRITICAL_SECTIONWrapper.Create(IB.IBCS)));
  end;
end;

procedure TatIBLibrary.__SetIBCS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IB.IBCS:=_RTL_CRITICAL_SECTIONWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatIBLibrary.Init;
begin
  With Scripter.DefineClass(EIBError) do
  begin
    DefineMethod('Create',2,tkClass,EIBError,__EIBErrorCreate,true,0);
    DefineProp('SQLCode',tkInteger,__GetEIBErrorSQLCode,nil,nil,false,0);
    DefineProp('IBErrorCode',tkInteger,__GetEIBErrorIBErrorCode,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EIBInterBaseError) do
  begin
  end;
  With Scripter.DefineClass(EIBInterBaseRoleError) do
  begin
  end;
  With Scripter.DefineClass(EIBClientError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('IBAlloc',3,tkNone,nil,__IBAlloc,false,0).SetVarArgs([0]);
    DefineMethod('IBDataBaseError',0,tkNone,nil,__IBDataBaseError,false,0);
    DefineMethod('StatusVectorAsText',0,tkVariant,nil,__StatusVectorAsText,false,0);
    DefineMethod('SetIBDataBaseErrorMessages',1,tkNone,nil,__SetIBDataBaseErrorMessages,false,0);
    DefineMethod('GetIBDataBaseErrorMessages',0,tkInteger,nil,__GetIBDataBaseErrorMessages,false,0);
    DefineProp('IBCS',tkVariant,__GetIBCS,__SetIBCS,nil,false,0);
    AddConstant('tfQPrepare',tfQPrepare);
    AddConstant('tfQExecute',tfQExecute);
    AddConstant('tfQFetch',tfQFetch);
    AddConstant('tfError',tfError);
    AddConstant('tfStmt',tfStmt);
    AddConstant('tfConnect',tfConnect);
    AddConstant('tfTransact',tfTransact);
    AddConstant('tfBlob',tfBlob);
    AddConstant('tfService',tfService);
    AddConstant('tfMisc',tfMisc);
    AddConstant('ShowSQLCode',ShowSQLCode);
    AddConstant('ShowIBMessage',ShowIBMessage);
    AddConstant('ShowSQLMessage',ShowSQLMessage);
    AddConstant('ibxeUnknownError',ibxeUnknownError);
    AddConstant('ibxeInterBaseMissing',ibxeInterBaseMissing);
    AddConstant('ibxeInterBaseInstallMissing',ibxeInterBaseInstallMissing);
    AddConstant('ibxeIB60feature',ibxeIB60feature);
    AddConstant('ibxeNotSupported',ibxeNotSupported);
    AddConstant('ibxeNotPermitted',ibxeNotPermitted);
    AddConstant('ibxeFileAccessError',ibxeFileAccessError);
    AddConstant('ibxeConnectionTimeout',ibxeConnectionTimeout);
    AddConstant('ibxeCannotSetDatabase',ibxeCannotSetDatabase);
    AddConstant('ibxeCannotSetTransaction',ibxeCannotSetTransaction);
    AddConstant('ibxeOperationCancelled',ibxeOperationCancelled);
    AddConstant('ibxeDPBConstantNotSupported',ibxeDPBConstantNotSupported);
    AddConstant('ibxeDPBConstantUnknown',ibxeDPBConstantUnknown);
    AddConstant('ibxeTPBConstantNotSupported',ibxeTPBConstantNotSupported);
    AddConstant('ibxeTPBConstantUnknown',ibxeTPBConstantUnknown);
    AddConstant('ibxeDatabaseClosed',ibxeDatabaseClosed);
    AddConstant('ibxeDatabaseOpen',ibxeDatabaseOpen);
    AddConstant('ibxeDatabaseNameMissing',ibxeDatabaseNameMissing);
    AddConstant('ibxeNotInTransaction',ibxeNotInTransaction);
    AddConstant('ibxeInTransaction',ibxeInTransaction);
    AddConstant('ibxeTimeoutNegative',ibxeTimeoutNegative);
    AddConstant('ibxeNoDatabasesInTransaction',ibxeNoDatabasesInTransaction);
    AddConstant('ibxeUpdateWrongDB',ibxeUpdateWrongDB);
    AddConstant('ibxeUpdateWrongTR',ibxeUpdateWrongTR);
    AddConstant('ibxeDatabaseNotAssigned',ibxeDatabaseNotAssigned);
    AddConstant('ibxeTransactionNotAssigned',ibxeTransactionNotAssigned);
    AddConstant('ibxeXSQLDAIndexOutOfRange',ibxeXSQLDAIndexOutOfRange);
    AddConstant('ibxeXSQLDANameDoesNotExist',ibxeXSQLDANameDoesNotExist);
    AddConstant('ibxeEOF',ibxeEOF);
    AddConstant('ibxeBOF',ibxeBOF);
    AddConstant('ibxeInvalidStatementHandle',ibxeInvalidStatementHandle);
    AddConstant('ibxeSQLOpen',ibxeSQLOpen);
    AddConstant('ibxeSQLClosed',ibxeSQLClosed);
    AddConstant('ibxeDatasetOpen',ibxeDatasetOpen);
    AddConstant('ibxeDatasetClosed',ibxeDatasetClosed);
    AddConstant('ibxeUnknownSQLDataType',ibxeUnknownSQLDataType);
    AddConstant('ibxeInvalidColumnIndex',ibxeInvalidColumnIndex);
    AddConstant('ibxeInvalidParamColumnIndex',ibxeInvalidParamColumnIndex);
    AddConstant('ibxeInvalidDataConversion',ibxeInvalidDataConversion);
    AddConstant('ibxeColumnIsNotNullable',ibxeColumnIsNotNullable);
    AddConstant('ibxeBlobCannotBeRead',ibxeBlobCannotBeRead);
    AddConstant('ibxeBlobCannotBeWritten',ibxeBlobCannotBeWritten);
    AddConstant('ibxeEmptyQuery',ibxeEmptyQuery);
    AddConstant('ibxeCannotOpenNonSQLSelect',ibxeCannotOpenNonSQLSelect);
    AddConstant('ibxeNoFieldAccess',ibxeNoFieldAccess);
    AddConstant('ibxeFieldReadOnly',ibxeFieldReadOnly);
    AddConstant('ibxeFieldNotFound',ibxeFieldNotFound);
    AddConstant('ibxeNotEditing',ibxeNotEditing);
    AddConstant('ibxeCannotInsert',ibxeCannotInsert);
    AddConstant('ibxeCannotPost',ibxeCannotPost);
    AddConstant('ibxeCannotUpdate',ibxeCannotUpdate);
    AddConstant('ibxeCannotDelete',ibxeCannotDelete);
    AddConstant('ibxeCannotRefresh',ibxeCannotRefresh);
    AddConstant('ibxeBufferNotSet',ibxeBufferNotSet);
    AddConstant('ibxeCircularReference',ibxeCircularReference);
    AddConstant('ibxeSQLParseError',ibxeSQLParseError);
    AddConstant('ibxeUserAbort',ibxeUserAbort);
    AddConstant('ibxeDataSetUniDirectional',ibxeDataSetUniDirectional);
    AddConstant('ibxeCannotCreateSharedResource',ibxeCannotCreateSharedResource);
    AddConstant('ibxeWindowsAPIError',ibxeWindowsAPIError);
    AddConstant('ibxeColumnListsDontMatch',ibxeColumnListsDontMatch);
    AddConstant('ibxeColumnTypesDontMatch',ibxeColumnTypesDontMatch);
    AddConstant('ibxeCantEndSharedTransaction',ibxeCantEndSharedTransaction);
    AddConstant('ibxeFieldUnsupportedType',ibxeFieldUnsupportedType);
    AddConstant('ibxeCircularDataLink',ibxeCircularDataLink);
    AddConstant('ibxeEmptySQLStatement',ibxeEmptySQLStatement);
    AddConstant('ibxeIsASelectStatement',ibxeIsASelectStatement);
    AddConstant('ibxeRequiredParamNotSet',ibxeRequiredParamNotSet);
    AddConstant('ibxeNoStoredProcName',ibxeNoStoredProcName);
    AddConstant('ibxeIsAExecuteProcedure',ibxeIsAExecuteProcedure);
    AddConstant('ibxeUpdateFailed',ibxeUpdateFailed);
    AddConstant('ibxeNotCachedUpdates',ibxeNotCachedUpdates);
    AddConstant('ibxeNotLiveRequest',ibxeNotLiveRequest);
    AddConstant('ibxeNoProvider',ibxeNoProvider);
    AddConstant('ibxeNoRecordsAffected',ibxeNoRecordsAffected);
    AddConstant('ibxeNoTableName',ibxeNoTableName);
    AddConstant('ibxeCannotCreatePrimaryIndex',ibxeCannotCreatePrimaryIndex);
    AddConstant('ibxeCannotDropSystemIndex',ibxeCannotDropSystemIndex);
    AddConstant('ibxeTableNameMismatch',ibxeTableNameMismatch);
    AddConstant('ibxeIndexFieldMissing',ibxeIndexFieldMissing);
    AddConstant('ibxeInvalidCancellation',ibxeInvalidCancellation);
    AddConstant('ibxeInvalidEvent',ibxeInvalidEvent);
    AddConstant('ibxeMaximumEvents',ibxeMaximumEvents);
    AddConstant('ibxeNoEventsRegistered',ibxeNoEventsRegistered);
    AddConstant('ibxeInvalidQueueing',ibxeInvalidQueueing);
    AddConstant('ibxeInvalidRegistration',ibxeInvalidRegistration);
    AddConstant('ibxeInvalidBatchMove',ibxeInvalidBatchMove);
    AddConstant('ibxeSQLDialectInvalid',ibxeSQLDialectInvalid);
    AddConstant('ibxeSPBConstantNotSupported',ibxeSPBConstantNotSupported);
    AddConstant('ibxeSPBConstantUnknown',ibxeSPBConstantUnknown);
    AddConstant('ibxeServiceActive',ibxeServiceActive);
    AddConstant('ibxeServiceInActive',ibxeServiceInActive);
    AddConstant('ibxeServerNameMissing',ibxeServerNameMissing);
    AddConstant('ibxeQueryParamsError',ibxeQueryParamsError);
    AddConstant('ibxeStartParamsError',ibxeStartParamsError);
    AddConstant('ibxeOutputParsingError',ibxeOutputParsingError);
    AddConstant('ibxeUseSpecificProcedures',ibxeUseSpecificProcedures);
    AddConstant('ibxeSQLMonitorAlreadyPresent',ibxeSQLMonitorAlreadyPresent);
    AddConstant('ibxeCantPrintValue',ibxeCantPrintValue);
    AddConstant('ibxeEOFReached',ibxeEOFReached);
    AddConstant('ibxeEOFInComment',ibxeEOFInComment);
    AddConstant('ibxeEOFInString',ibxeEOFInString);
    AddConstant('ibxeParamNameExpected',ibxeParamNameExpected);
    AddConstant('ibxeSuccess',ibxeSuccess);
    AddConstant('ibxeDelphiException',ibxeDelphiException);
    AddConstant('ibxeNoOptionsSet',ibxeNoOptionsSet);
    AddConstant('ibxeNoDestinationDirectory',ibxeNoDestinationDirectory);
    AddConstant('ibxeNosourceDirectory',ibxeNosourceDirectory);
    AddConstant('ibxeNoUninstallFile',ibxeNoUninstallFile);
    AddConstant('ibxeOptionNeedsClient',ibxeOptionNeedsClient);
    AddConstant('ibxeOptionNeedsServer',ibxeOptionNeedsServer);
    AddConstant('ibxeInvalidOption',ibxeInvalidOption);
    AddConstant('ibxeInvalidOnErrorResult',ibxeInvalidOnErrorResult);
    AddConstant('ibxeInvalidOnStatusResult',ibxeInvalidOnStatusResult);
    AddConstant('ibxeDPBConstantUnknownEx',ibxeDPBConstantUnknownEx);
    AddConstant('ibxeTPBConstantUnknownEx',ibxeTPBConstantUnknownEx);
    AddConstant('ibxeUnknownPlan',ibxeUnknownPlan);
    AddConstant('ibxeFieldSizeMismatch',ibxeFieldSizeMismatch);
    AddConstant('ibxeEventAlreadyRegistered',ibxeEventAlreadyRegistered);
    AddConstant('ibxeStringTooLarge',ibxeStringTooLarge);
    AddConstant('IBPalette1',IBPalette1);
    AddConstant('IBPalette2',IBPalette2);
    AddConstant('IBLocalBufferLength',IBLocalBufferLength);
    AddConstant('IBBigLocalBufferLength',IBBigLocalBufferLength);
    AddConstant('IBHugeLocalBufferLength',IBHugeLocalBufferLength);
  end;
end;

class function TatIBLibrary.LibraryName: string;
begin
  result := 'IB';
end;

initialization
  RegisterScripterLibrary(TatIBLibrary, True);

{$WARNINGS ON}

end.

