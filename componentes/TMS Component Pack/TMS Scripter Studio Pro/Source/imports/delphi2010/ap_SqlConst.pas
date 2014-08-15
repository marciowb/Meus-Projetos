{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2009                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_SqlConst;

interface

{$WARNINGS OFF}

uses
  SqlConst,
  Variants,
  atScript;

type
  TatSqlConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation

{$WARNINGS OFF}



procedure TatSqlConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('DRIVERS_KEY',DRIVERS_KEY);
    AddConstant('CONNECTIONS_KEY',CONNECTIONS_KEY);
    AddConstant('DRIVERNAME_KEY',DRIVERNAME_KEY);
    AddConstant('HOSTNAME_KEY',HOSTNAME_KEY);
    AddConstant('ROLENAME_KEY',ROLENAME_KEY);
    AddConstant('DATABASENAME_KEY',DATABASENAME_KEY);
    AddConstant('MAXBLOBSIZE_KEY',MAXBLOBSIZE_KEY);
    AddConstant('VENDORLIB_KEY',VENDORLIB_KEY);
    AddConstant('DLLLIB_KEY',DLLLIB_KEY);
    AddConstant('GETDRIVERFUNC_KEY',GETDRIVERFUNC_KEY);
    AddConstant('AUTOCOMMIT_KEY',AUTOCOMMIT_KEY);
    AddConstant('BLOCKINGMODE_KEY',BLOCKINGMODE_KEY);
    AddConstant('WAITONLOCKS_KEY',WAITONLOCKS_KEY);
    AddConstant('COMMITRETAIN_KEY',COMMITRETAIN_KEY);
    AddConstant('TRANSISOLATION_KEY',TRANSISOLATION_KEY);
    AddConstant('SQLDIALECT_KEY',SQLDIALECT_KEY);
    AddConstant('SQLLOCALE_CODE_KEY',SQLLOCALE_CODE_KEY);
    AddConstant('ERROR_RESOURCE_KEY',ERROR_RESOURCE_KEY);
    AddConstant('SQLSERVER_CHARSET_KEY',SQLSERVER_CHARSET_KEY);
    AddConstant('CONNECTION_STRING',CONNECTION_STRING);
    AddConstant('SREADCOMMITTED',SREADCOMMITTED);
    AddConstant('SREPEATREAD',SREPEATREAD);
    AddConstant('SDIRTYREAD',SDIRTYREAD);
    AddConstant('szUSERNAME',szUSERNAME);
    AddConstant('szPASSWORD',szPASSWORD);
    AddConstant('SLocaleCode',SLocaleCode);
    AddConstant('ROWSETSIZE_KEY',ROWSETSIZE_KEY);
    AddConstant('OSAUTHENTICATION',OSAUTHENTICATION);
    AddConstant('SERVERPORT',SERVERPORT);
    AddConstant('MULTITRANSENABLED',MULTITRANSENABLED);
    AddConstant('TRIMCHAR',TRIMCHAR);
    AddConstant('CUSTOM_INFO',CUSTOM_INFO);
    AddConstant('CONN_TIMEOUT',CONN_TIMEOUT);
    AddConstant('TDSPACKETSIZE',TDSPACKETSIZE);
    AddConstant('CLIENTHOSTNAME',CLIENTHOSTNAME);
    AddConstant('CLIENTAPPNAME',CLIENTAPPNAME);
    AddConstant('COMPRESSED',COMPRESSED);
    AddConstant('ENCRYPTED',ENCRYPTED);
    AddConstant('PREPARESQL',PREPARESQL);
    AddConstant('SLoginError',SLoginError);
    AddConstant('SMonitorActive',SMonitorActive);
    AddConstant('SMissingConnection',SMissingConnection);
    AddConstant('SDatabaseOpen',SDatabaseOpen);
    AddConstant('SDatabaseClosed',SDatabaseClosed);
    AddConstant('SMissingSQLConnection',SMissingSQLConnection);
    AddConstant('SConnectionNameMissing',SConnectionNameMissing);
    AddConstant('SEmptySQLStatement',SEmptySQLStatement);
    AddConstant('SNoParameterValue',SNoParameterValue);
    AddConstant('SNoParameterType',SNoParameterType);
    AddConstant('SParameterTypes',SParameterTypes);
    AddConstant('SDataTypes',SDataTypes);
    AddConstant('SResultName',SResultName);
    AddConstant('SNoTableName',SNoTableName);
    AddConstant('SNoSqlStatement',SNoSqlStatement);
    AddConstant('SNoDataSetField',SNoDataSetField);
    AddConstant('SNoCachedUpdates',SNoCachedUpdates);
    AddConstant('SMissingDataBaseName',SMissingDataBaseName);
    AddConstant('SMissingDataSet',SMissingDataSet);
    AddConstant('SMissingDriverName',SMissingDriverName);
    AddConstant('SPrepareError',SPrepareError);
    AddConstant('SObjectNameError',SObjectNameError);
    AddConstant('SSQLDataSetOpen',SSQLDataSetOpen);
    AddConstant('SNoActiveTrans',SNoActiveTrans);
    AddConstant('SActiveTrans',SActiveTrans);
    AddConstant('SDllLoadError',SDllLoadError);
    AddConstant('SDllProcLoadError',SDllProcLoadError);
    AddConstant('SConnectionEditor',SConnectionEditor);
    AddConstant('SAddConnectionString',SAddConnectionString);
    AddConstant('SRefreshConnectionString',SRefreshConnectionString);
    AddConstant('SRemoveConnectionString',SRemoveConnectionString);
    AddConstant('SCommandTextEditor',SCommandTextEditor);
    AddConstant('SMissingDLLName',SMissingDLLName);
    AddConstant('SMissingDriverRegFile',SMissingDriverRegFile);
    AddConstant('STableNameNotFound',STableNameNotFound);
    AddConstant('SNoCursor',SNoCursor);
    AddConstant('SMetaDataOpenError',SMetaDataOpenError);
    AddConstant('SErrorMappingError',SErrorMappingError);
    AddConstant('SStoredProcsNotSupported',SStoredProcsNotSupported);
    AddConstant('SPackagesNotSupported',SPackagesNotSupported);
    AddConstant('STooManyActualParam',STooManyActualParam);
    AddConstant('SDBXUNKNOWNERROR',SDBXUNKNOWNERROR);
    AddConstant('SNOERROR',SNOERROR);
    AddConstant('SWARNING',SWARNING);
    AddConstant('SNOMEMORY',SNOMEMORY);
    AddConstant('SINVALIDFLDTYPE',SINVALIDFLDTYPE);
    AddConstant('SINVALIDHNDL',SINVALIDHNDL);
    AddConstant('SNOTSUPPORTED',SNOTSUPPORTED);
    AddConstant('SINVALIDTIME',SINVALIDTIME);
    AddConstant('SINVALIDXLATION',SINVALIDXLATION);
    AddConstant('SOUTOFRANGE',SOUTOFRANGE);
    AddConstant('SINVALIDPARAM',SINVALIDPARAM);
    AddConstant('SEOF',SEOF);
    AddConstant('SSQLPARAMNOTSET',SSQLPARAMNOTSET);
    AddConstant('SINVALIDUSRPASS',SINVALIDUSRPASS);
    AddConstant('SINVALIDPRECISION',SINVALIDPRECISION);
    AddConstant('SINVALIDLEN',SINVALIDLEN);
    AddConstant('SINVALIDXISOLEVEL',SINVALIDXISOLEVEL);
    AddConstant('SINVALIDTXNID',SINVALIDTXNID);
    AddConstant('SDUPLICATETXNID',SDUPLICATETXNID);
    AddConstant('SDRIVERRESTRICTED',SDRIVERRESTRICTED);
    AddConstant('SLOCALTRANSACTIVE',SLOCALTRANSACTIVE);
    AddConstant('SMULTIPLETRANSNOTENABLED',SMULTIPLETRANSNOTENABLED);
    AddConstant('SCONNECTIONFAILED',SCONNECTIONFAILED);
    AddConstant('SDRIVERINITFAILED',SDRIVERINITFAILED);
    AddConstant('SOPTLOCKFAILED',SOPTLOCKFAILED);
    AddConstant('SINVALIDREF',SINVALIDREF);
    AddConstant('SNOTABLE',SNOTABLE);
    AddConstant('SMISSINGPARAMINSQL',SMISSINGPARAMINSQL);
    AddConstant('SNOTIMPLEMENTED',SNOTIMPLEMENTED);
    AddConstant('SDRIVERINCOMPATIBLE',SDRIVERINCOMPATIBLE);
    AddConstant('SNODATA',SNODATA);
    AddConstant('SSQLERROR',SSQLERROR);
    AddConstant('SDBXError',SDBXError);
    AddConstant('SSQLServerError',SSQLServerError);
    AddConstant('SConfFileMoveError',SConfFileMoveError);
    AddConstant('SMissingConfFile',SMissingConfFile);
    AddConstant('SObjectViewNotTrue',SObjectViewNotTrue);
    AddConstant('SObjectTypenameRequired',SObjectTypenameRequired);
    AddConstant('SCannotCreateFile',SCannotCreateFile);
    AddConstant('SDlgOpenCaption',SDlgOpenCaption);
    AddConstant('SDlgFilterTxt',SDlgFilterTxt);
    AddConstant('SLogFileFilter',SLogFileFilter);
    AddConstant('SCircularProvider',SCircularProvider);
    AddConstant('SUnknownDataType',SUnknownDataType);
    AddConstant('SSaveConnectionParams',SSaveConnectionParams);
    AddConstant('SReloadConnectionParams',SReloadConnectionParams);
    AddConstant('SGenerateClientClasses',SGenerateClientClasses);
  end;
end;

class function TatSqlConstLibrary.LibraryName: string;
begin
  result := 'SqlConst';
end;

initialization
  RegisterScripterLibrary(TatSqlConstLibrary, True);

{$WARNINGS ON}

end.
