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
unit ap_BdeConst;

interface

uses
  BdeConst,
  atScript;

{$WARNINGS OFF}

type
  TatBdeConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatBdeConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SAutoSessionExclusive',SAutoSessionExclusive);
    AddConstant('SAutoSessionExists',SAutoSessionExists);
    AddConstant('SAutoSessionActive',SAutoSessionActive);
    AddConstant('SDuplicateDatabaseName',SDuplicateDatabaseName);
    AddConstant('SDuplicateSessionName',SDuplicateSessionName);
    AddConstant('SInvalidSessionName',SInvalidSessionName);
    AddConstant('SDatabaseNameMissing',SDatabaseNameMissing);
    AddConstant('SSessionNameMissing',SSessionNameMissing);
    AddConstant('SDatabaseOpen',SDatabaseOpen);
    AddConstant('SDatabaseClosed',SDatabaseClosed);
    AddConstant('SDatabaseHandleSet',SDatabaseHandleSet);
    AddConstant('SSessionActive',SSessionActive);
    AddConstant('SHandleError',SHandleError);
    AddConstant('SInvalidFloatField',SInvalidFloatField);
    AddConstant('SInvalidIntegerField',SInvalidIntegerField);
    AddConstant('STableMismatch',STableMismatch);
    AddConstant('SFieldAssignError',SFieldAssignError);
    AddConstant('SNoReferenceTableName',SNoReferenceTableName);
    AddConstant('SCompositeIndexError',SCompositeIndexError);
    AddConstant('SInvalidBatchMove',SInvalidBatchMove);
    AddConstant('SEmptySQLStatement',SEmptySQLStatement);
    AddConstant('SNoParameterValue',SNoParameterValue);
    AddConstant('SNoParameterType',SNoParameterType);
    AddConstant('SLoginError',SLoginError);
    AddConstant('SInitError',SInitError);
    AddConstant('SDatabaseEditor',SDatabaseEditor);
    AddConstant('SExplore',SExplore);
    AddConstant('SLinkDetail',SLinkDetail);
    AddConstant('SLinkMasterSource',SLinkMasterSource);
    AddConstant('SLinkMaster',SLinkMaster);
    AddConstant('SGQEVerb',SGQEVerb);
    AddConstant('SBindVerb',SBindVerb);
    AddConstant('SIDAPILangID',SIDAPILangID);
    AddConstant('SDisconnectDatabase',SDisconnectDatabase);
    AddConstant('SBDEError',SBDEError);
    AddConstant('SLookupSourceError',SLookupSourceError);
    AddConstant('SLookupTableError',SLookupTableError);
    AddConstant('SLookupIndexError',SLookupIndexError);
    AddConstant('SParameterTypes',SParameterTypes);
    AddConstant('SInvalidParamFieldType',SInvalidParamFieldType);
    AddConstant('STruncationError',STruncationError);
    AddConstant('SDataTypes',SDataTypes);
    AddConstant('SResultName',SResultName);
    AddConstant('SDBCaption',SDBCaption);
    AddConstant('SParamEditor',SParamEditor);
    AddConstant('SIndexFilesEditor',SIndexFilesEditor);
    AddConstant('SNoIndexFiles',SNoIndexFiles);
    AddConstant('SIndexDoesNotExist',SIndexDoesNotExist);
    AddConstant('SNoTableName',SNoTableName);
    AddConstant('SNoDataSetField',SNoDataSetField);
    AddConstant('SBatchExecute',SBatchExecute);
    AddConstant('SNoCachedUpdates',SNoCachedUpdates);
    AddConstant('SInvalidAliasName',SInvalidAliasName);
    AddConstant('SNoFieldAccess',SNoFieldAccess);
    AddConstant('SUpdateSQLEditor',SUpdateSQLEditor);
    AddConstant('SNoDataSet',SNoDataSet);
    AddConstant('SUntitled',SUntitled);
    AddConstant('SUpdateWrongDB',SUpdateWrongDB);
    AddConstant('SUpdateFailed',SUpdateFailed);
    AddConstant('SSQLGenSelect',SSQLGenSelect);
    AddConstant('SSQLNotGenerated',SSQLNotGenerated);
    AddConstant('SSQLDataSetOpen',SSQLDataSetOpen);
    AddConstant('SLocalTransDirty',SLocalTransDirty);
    AddConstant('SMissingDataSet',SMissingDataSet);
    AddConstant('SNoProvider',SNoProvider);
    AddConstant('SNotAQuery',SNotAQuery);
  end;
end;

class function TatBdeConstLibrary.LibraryName: string;
begin
  result := 'BdeConst';
end;

initialization
  RegisterScripterLibrary(TatBdeConstLibrary, True);

{$WARNINGS ON}

end.

