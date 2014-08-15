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
unit ap_IBXConst;

interface

uses
  IBUtils,
  IBXConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBXConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatIBXConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('IBX_Version',IBX_Version);
    AddConstant('SIBDatabaseEditor',SIBDatabaseEditor);
    AddConstant('SIBTransactionEditor',SIBTransactionEditor);
    AddConstant('SDatabaseFilter',SDatabaseFilter);
    AddConstant('SDisconnectDatabase',SDisconnectDatabase);
    AddConstant('SCommitTransaction',SCommitTransaction);
    AddConstant('SExecute',SExecute);
    AddConstant('SNoDataSet',SNoDataSet);
    AddConstant('SSQLGenSelect',SSQLGenSelect);
    AddConstant('SSQLNotGenerated',SSQLNotGenerated);
    AddConstant('SIBUpdateSQLEditor',SIBUpdateSQLEditor);
    AddConstant('SIBDataSetEditor',SIBDataSetEditor);
    AddConstant('SSQLDataSetOpen',SSQLDataSetOpen);
    AddConstant('SDefaultTransaction',SDefaultTransaction);
    AddConstant('SUnknownError',SUnknownError);
    AddConstant('SInterBaseMissing',SInterBaseMissing);
    AddConstant('SInterBaseInstallMissing',SInterBaseInstallMissing);
    AddConstant('SIB60feature',SIB60feature);
    AddConstant('SNotSupported',SNotSupported);
    AddConstant('SNotPermitted',SNotPermitted);
    AddConstant('SFileAccessError',SFileAccessError);
    AddConstant('SConnectionTimeout',SConnectionTimeout);
    AddConstant('SCannotSetDatabase',SCannotSetDatabase);
    AddConstant('SCannotSetTransaction',SCannotSetTransaction);
    AddConstant('SOperationCancelled',SOperationCancelled);
    AddConstant('SDPBConstantNotSupported',SDPBConstantNotSupported);
    AddConstant('SDPBConstantUnknown',SDPBConstantUnknown);
    AddConstant('STPBConstantNotSupported',STPBConstantNotSupported);
    AddConstant('STPBConstantUnknown',STPBConstantUnknown);
    AddConstant('SDatabaseClosed',SDatabaseClosed);
    AddConstant('SDatabaseOpen',SDatabaseOpen);
    AddConstant('SDatabaseNameMissing',SDatabaseNameMissing);
    AddConstant('SNotInTransaction',SNotInTransaction);
    AddConstant('SInTransaction',SInTransaction);
    AddConstant('STimeoutNegative',STimeoutNegative);
    AddConstant('SNoDatabasesInTransaction',SNoDatabasesInTransaction);
    AddConstant('SUpdateWrongDB',SUpdateWrongDB);
    AddConstant('SUpdateWrongTR',SUpdateWrongTR);
    AddConstant('SDatabaseNotAssigned',SDatabaseNotAssigned);
    AddConstant('STransactionNotAssigned',STransactionNotAssigned);
    AddConstant('SXSQLDAIndexOutOfRange',SXSQLDAIndexOutOfRange);
    AddConstant('SXSQLDANameDoesNotExist',SXSQLDANameDoesNotExist);
    AddConstant('SEOF',SEOF);
    AddConstant('SBOF',SBOF);
    AddConstant('SInvalidStatementHandle',SInvalidStatementHandle);
    AddConstant('SSQLOpen',SSQLOpen);
    AddConstant('SSQLClosed',SSQLClosed);
    AddConstant('SDatasetOpen',SDatasetOpen);
    AddConstant('SDatasetClosed',SDatasetClosed);
    AddConstant('SUnknownSQLDataType',SUnknownSQLDataType);
    AddConstant('SInvalidColumnIndex',SInvalidColumnIndex);
    AddConstant('SInvalidParamColumnIndex',SInvalidParamColumnIndex);
    AddConstant('SInvalidDataConversion',SInvalidDataConversion);
    AddConstant('SColumnIsNotNullable',SColumnIsNotNullable);
    AddConstant('SBlobCannotBeRead',SBlobCannotBeRead);
    AddConstant('SBlobCannotBeWritten',SBlobCannotBeWritten);
    AddConstant('SEmptyQuery',SEmptyQuery);
    AddConstant('SCannotOpenNonSQLSelect',SCannotOpenNonSQLSelect);
    AddConstant('SNoFieldAccess',SNoFieldAccess);
    AddConstant('SFieldReadOnly',SFieldReadOnly);
    AddConstant('SFieldNotFound',SFieldNotFound);
    AddConstant('SNotEditing',SNotEditing);
    AddConstant('SCannotInsert',SCannotInsert);
    AddConstant('SCannotPost',SCannotPost);
    AddConstant('SCannotUpdate',SCannotUpdate);
    AddConstant('SCannotDelete',SCannotDelete);
    AddConstant('SCannotRefresh',SCannotRefresh);
    AddConstant('SBufferNotSet',SBufferNotSet);
    AddConstant('SCircularReference',SCircularReference);
    AddConstant('SSQLParseError',SSQLParseError);
    AddConstant('SUserAbort',SUserAbort);
    AddConstant('SDataSetUniDirectional',SDataSetUniDirectional);
    AddConstant('SCannotCreateSharedResource',SCannotCreateSharedResource);
    AddConstant('SWindowsAPIError',SWindowsAPIError);
    AddConstant('SColumnListsDontMatch',SColumnListsDontMatch);
    AddConstant('SColumnTypesDontMatch',SColumnTypesDontMatch);
    AddConstant('SCantEndSharedTransaction',SCantEndSharedTransaction);
    AddConstant('SFieldUnsupportedType',SFieldUnsupportedType);
    AddConstant('SCircularDataLink',SCircularDataLink);
    AddConstant('SEmptySQLStatement',SEmptySQLStatement);
    AddConstant('SIsASelectStatement',SIsASelectStatement);
    AddConstant('SRequiredParamNotSet',SRequiredParamNotSet);
    AddConstant('SNoStoredProcName',SNoStoredProcName);
    AddConstant('SIsAExecuteProcedure',SIsAExecuteProcedure);
    AddConstant('SUpdateFailed',SUpdateFailed);
    AddConstant('SNotCachedUpdates',SNotCachedUpdates);
    AddConstant('SNotLiveRequest',SNotLiveRequest);
    AddConstant('SNoProvider',SNoProvider);
    AddConstant('SNoRecordsAffected',SNoRecordsAffected);
    AddConstant('SNoTableName',SNoTableName);
    AddConstant('SCannotCreatePrimaryIndex',SCannotCreatePrimaryIndex);
    AddConstant('SCannotDropSystemIndex',SCannotDropSystemIndex);
    AddConstant('STableNameMismatch',STableNameMismatch);
    AddConstant('SIndexFieldMissing',SIndexFieldMissing);
    AddConstant('SInvalidCancellation',SInvalidCancellation);
    AddConstant('SInvalidEvent',SInvalidEvent);
    AddConstant('SMaximumEvents',SMaximumEvents);
    AddConstant('SNoEventsRegistered',SNoEventsRegistered);
    AddConstant('SInvalidQueueing',SInvalidQueueing);
    AddConstant('SInvalidRegistration',SInvalidRegistration);
    AddConstant('SInvalidBatchMove',SInvalidBatchMove);
    AddConstant('SSQLDialectInvalid',SSQLDialectInvalid);
    AddConstant('SSPBConstantNotSupported',SSPBConstantNotSupported);
    AddConstant('SSPBConstantUnknown',SSPBConstantUnknown);
    AddConstant('SServiceActive',SServiceActive);
    AddConstant('SServiceInActive',SServiceInActive);
    AddConstant('SServerNameMissing',SServerNameMissing);
    AddConstant('SQueryParamsError',SQueryParamsError);
    AddConstant('SStartParamsError',SStartParamsError);
    AddConstant('SOutputParsingError',SOutputParsingError);
    AddConstant('SUseSpecificProcedures',SUseSpecificProcedures);
    AddConstant('SSQLMonitorAlreadyPresent',SSQLMonitorAlreadyPresent);
    AddConstant('SCantPrintValue',SCantPrintValue);
    AddConstant('SEOFReached',SEOFReached);
    AddConstant('SEOFInComment',SEOFInComment);
    AddConstant('SEOFInString',SEOFInString);
    AddConstant('SParamNameExpected',SParamNameExpected);
    AddConstant('SSuccess',SSuccess);
    AddConstant('SDelphiException',SDelphiException);
    AddConstant('SNoOptionsSet',SNoOptionsSet);
    AddConstant('SNoDestinationDirectory',SNoDestinationDirectory);
    AddConstant('SNosourceDirectory',SNosourceDirectory);
    AddConstant('SNoUninstallFile',SNoUninstallFile);
    AddConstant('SOptionNeedsClient',SOptionNeedsClient);
    AddConstant('SOptionNeedsServer',SOptionNeedsServer);
    AddConstant('SInvalidOption',SInvalidOption);
    AddConstant('SInvalidOnErrorResult',SInvalidOnErrorResult);
    AddConstant('SInvalidOnStatusResult',SInvalidOnStatusResult);
    AddConstant('SInterbaseExpressVersion',SInterbaseExpressVersion);
    AddConstant('SEditSQL',SEditSQL);
    AddConstant('SDPBConstantUnknownEx',SDPBConstantUnknownEx);
    AddConstant('STPBConstantUnknownEx',STPBConstantUnknownEx);
    AddConstant('SInterbaseExpressVersionEx',SInterbaseExpressVersionEx);
    AddConstant('SUnknownPlan',SUnknownPlan);
    AddConstant('SFieldSizeMismatch',SFieldSizeMismatch);
    AddConstant('SEventAlreadyRegistered',SEventAlreadyRegistered);
    AddConstant('SStringTooLarge',SStringTooLarge);
    AddConstant('SIBServiceEditor',SIBServiceEditor);
    AddConstant('SIBSuccessConnect',SIBSuccessConnect);
    AddConstant('SNoTimers',SNoTimers);
    AddConstant('SLoginPromptFailure',SLoginPromptFailure);
  end;
end;

class function TatIBXConstLibrary.LibraryName: string;
begin
  result := 'IBXConst';
end;

initialization
  RegisterScripterLibrary(TatIBXConstLibrary, True);

{$WARNINGS ON}

end.

