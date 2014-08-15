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
unit ap_SqlConst;

interface

uses
  SqlConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatSqlConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



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
    AddConstant('SREADCOMMITTED',SREADCOMMITTED);
    AddConstant('SREPEATREAD',SREPEATREAD);
    AddConstant('SDIRTYREAD',SDIRTYREAD);
    AddConstant('SDRIVERREG_SETTING',SDRIVERREG_SETTING);
    AddConstant('SCONNECTIONREG_SETTING',SCONNECTIONREG_SETTING);
    AddConstant('szUSERNAME',szUSERNAME);
    AddConstant('szPASSWORD',szPASSWORD);
    AddConstant('SLocaleCode',SLocaleCode);
    AddConstant('ROWSETSIZE_KEY',ROWSETSIZE_KEY);
    AddConstant('OSAUTHENTICATION',OSAUTHENTICATION);
    AddConstant('SDriverConfigFile',SDriverConfigFile);
    AddConstant('SConnectionConfigFile',SConnectionConfigFile);
    AddConstant('SDBEXPRESSREG_SETTING',SDBEXPRESSREG_SETTING);
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
    AddConstant('SCommandTextEditor',SCommandTextEditor);
    AddConstant('SMissingDLLName',SMissingDLLName);
    AddConstant('SMissingDriverRegFile',SMissingDriverRegFile);
    AddConstant('STableNameNotFound',STableNameNotFound);
    AddConstant('SNoCursor',SNoCursor);
    AddConstant('SMetaDataOpenError',SMetaDataOpenError);
    AddConstant('SErrorMappingError',SErrorMappingError);
    AddConstant('SStoredProcsNotSupported',SStoredProcsNotSupported);
    AddConstant('SPackagesNotSupported',SPackagesNotSupported);
    AddConstant('SDBXUNKNOWNERROR',SDBXUNKNOWNERROR);
    AddConstant('SDBXNOCONNECTION',SDBXNOCONNECTION);
    AddConstant('SDBXNOMETAOBJECT',SDBXNOMETAOBJECT);
    AddConstant('SDBXNOCOMMAND',SDBXNOCOMMAND);
    AddConstant('SDBXNOCURSOR',SDBXNOCURSOR);
    AddConstant('SNOMEMORY',SNOMEMORY);
    AddConstant('SINVALIDFLDTYPE',SINVALIDFLDTYPE);
    AddConstant('SINVALIDHNDL',SINVALIDHNDL);
    AddConstant('SINVALIDTIME',SINVALIDTIME);
    AddConstant('SNOTSUPPORTED',SNOTSUPPORTED);
    AddConstant('SINVALIDXLATION',SINVALIDXLATION);
    AddConstant('SINVALIDPARAM',SINVALIDPARAM);
    AddConstant('SOUTOFRANGE',SOUTOFRANGE);
    AddConstant('SSQLPARAMNOTSET',SSQLPARAMNOTSET);
    AddConstant('SEOF',SEOF);
    AddConstant('SINVALIDUSRPASS',SINVALIDUSRPASS);
    AddConstant('SINVALIDPRECISION',SINVALIDPRECISION);
    AddConstant('SINVALIDLEN',SINVALIDLEN);
    AddConstant('SINVALIDXISOLEVEL',SINVALIDXISOLEVEL);
    AddConstant('SINVALIDTXNID',SINVALIDTXNID);
    AddConstant('SDUPLICATETXNID',SDUPLICATETXNID);
    AddConstant('SDRIVERRESTRICTED',SDRIVERRESTRICTED);
    AddConstant('SLOCALTRANSACTIVE',SLOCALTRANSACTIVE);
    AddConstant('SMultiConnNotSupported',SMultiConnNotSupported);
    AddConstant('SConfFileMoveError',SConfFileMoveError);
    AddConstant('SMissingConfFile',SMissingConfFile);
    AddConstant('SObjectViewNotTrue',SObjectViewNotTrue);
    AddConstant('SDriverNotInConfigFile',SDriverNotInConfigFile);
    AddConstant('SObjectTypenameRequired',SObjectTypenameRequired);
    AddConstant('SCannotCreateFile',SCannotCreateFile);
    AddConstant('SDlgFilterTxt',SDlgFilterTxt);
    AddConstant('SLogFileFilter',SLogFileFilter);
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

