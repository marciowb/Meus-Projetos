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
unit ap_IBServices;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  IBDialogs,
  IBHeader,
  IB,
  IBExternals,
  IBServices,
  atScript;

{$WARNINGS OFF}

type
  TatIBServicesLibrary = class(TatScripterLibrary)
    procedure __TIBCustomServiceCreate(AMachine: TatVirtualMachine);
    procedure __TIBCustomServiceDestroy(AMachine: TatVirtualMachine);
    procedure __TIBCustomServiceAttach(AMachine: TatVirtualMachine);
    procedure __TIBCustomServiceDetach(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomServiceServiceParamBySPB(AMachine: TatVirtualMachine);
    procedure __SetTIBCustomServiceServiceParamBySPB(AMachine: TatVirtualMachine);
    procedure __TDatabaseInfoCreate(AMachine: TatVirtualMachine);
    procedure __TDatabaseInfoDestroy(AMachine: TatVirtualMachine);
    procedure __TLicenseInfoCreate(AMachine: TatVirtualMachine);
    procedure __TLicenseInfoDestroy(AMachine: TatVirtualMachine);
    procedure __TConfigFileDataCreate(AMachine: TatVirtualMachine);
    procedure __TConfigFileDataDestroy(AMachine: TatVirtualMachine);
    procedure __TConfigParamsCreate(AMachine: TatVirtualMachine);
    procedure __TConfigParamsDestroy(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesCreate(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesDestroy(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesFetch(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesFetchDatabaseInfo(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesFetchLicenseInfo(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesFetchLicenseMaskInfo(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesFetchConfigParams(AMachine: TatVirtualMachine);
    procedure __TIBServerPropertiesFetchVersionInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBServerPropertiesDatabaseInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBServerPropertiesLicenseInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBServerPropertiesLicenseMaskInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBServerPropertiesVersionInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBServerPropertiesConfigParams(AMachine: TatVirtualMachine);
    procedure __TIBControlServiceCreate(AMachine: TatVirtualMachine);
    procedure __TIBControlServiceServiceStart(AMachine: TatVirtualMachine);
    procedure __GetTIBControlServiceIsServiceRunning(AMachine: TatVirtualMachine);
    procedure __TIBControlAndQueryServicecreate(AMachine: TatVirtualMachine);
    procedure __TIBControlAndQueryServiceGetNextLine(AMachine: TatVirtualMachine);
    procedure __TIBControlAndQueryServiceGetNextChunk(AMachine: TatVirtualMachine);
    procedure __GetTIBControlAndQueryServiceEof(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceServiceStart(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceShutdownDatabase(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceSetSweepInterval(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceSetDBSqlDialect(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceSetPageBuffers(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceActivateShadow(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceBringDatabaseOnline(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceSetReserveSpace(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceSetAsyncMode(AMachine: TatVirtualMachine);
    procedure __TIBConfigServiceSetReadOnly(AMachine: TatVirtualMachine);
    procedure __TIBLicensingServiceAddLicense(AMachine: TatVirtualMachine);
    procedure __TIBLicensingServiceRemoveLicense(AMachine: TatVirtualMachine);
    procedure __TIBBackupServiceCreate(AMachine: TatVirtualMachine);
    procedure __TIBBackupServiceDestroy(AMachine: TatVirtualMachine);
    procedure __TIBRestoreServiceCreate(AMachine: TatVirtualMachine);
    procedure __TIBRestoreServiceDestroy(AMachine: TatVirtualMachine);
    procedure __TIBValidationServiceCreate(AMachine: TatVirtualMachine);
    procedure __TIBValidationServiceDestroy(AMachine: TatVirtualMachine);
    procedure __TIBValidationServiceFetchLimboTransactionInfo(AMachine: TatVirtualMachine);
    procedure __TIBValidationServiceFixLimboTransactionErrors(AMachine: TatVirtualMachine);
    procedure __GetTIBValidationServiceLimboTransactionInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBValidationServiceLimboTransactionInfoCount(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceCreate(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceDestroy(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceDisplayUsers(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceDisplayUser(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceAddUser(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceDeleteUser(AMachine: TatVirtualMachine);
    procedure __TIBSecurityServiceModifyUser(AMachine: TatVirtualMachine);
    procedure __GetTIBSecurityServiceUserInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBSecurityServiceUserInfoCount(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBCustomServiceClass = class of TIBCustomService;
  TDatabaseInfoClass = class of TDatabaseInfo;
  TLicenseInfoClass = class of TLicenseInfo;
  TLicenseMaskInfoClass = class of TLicenseMaskInfo;
  TConfigFileDataClass = class of TConfigFileData;
  TConfigParamsClass = class of TConfigParams;
  TVersionInfoClass = class of TVersionInfo;
  TIBServerPropertiesClass = class of TIBServerProperties;
  TIBControlServiceClass = class of TIBControlService;
  TIBControlAndQueryServiceClass = class of TIBControlAndQueryService;
  TIBConfigServiceClass = class of TIBConfigService;
  TIBLicensingServiceClass = class of TIBLicensingService;
  TIBLogServiceClass = class of TIBLogService;
  TIBStatisticalServiceClass = class of TIBStatisticalService;
  TIBBackupRestoreServiceClass = class of TIBBackupRestoreService;
  TIBBackupServiceClass = class of TIBBackupService;
  TIBRestoreServiceClass = class of TIBRestoreService;
  TLimboTransactionInfoClass = class of TLimboTransactionInfo;
  TIBValidationServiceClass = class of TIBValidationService;
  TUserInfoClass = class of TUserInfo;
  TIBSecurityServiceClass = class of TIBSecurityService;

  TatIBServicesDispatcher = class(TatEventDispatcher)
  private
    procedure __TLoginEvent( Database: TIBCustomService;  LoginParams: TStrings);
  end;


implementation



procedure TatIBServicesLibrary.__TIBCustomServiceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBCustomServiceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBCustomServiceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomService(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBCustomServiceAttach(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomService(CurrentObject).Attach;
  end;
end;

procedure TatIBServicesLibrary.__TIBCustomServiceDetach(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomService(CurrentObject).Detach;
  end;
end;

procedure TatIBServicesLibrary.__GetTIBCustomServiceServiceParamBySPB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBCustomService(CurrentObject).ServiceParamBySPB[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatIBServicesLibrary.__SetTIBCustomServiceServiceParamBySPB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomService(CurrentObject).ServiceParamBySPB[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatIBServicesLibrary.__TDatabaseInfoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDatabaseInfoClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TDatabaseInfoDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDatabaseInfo(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TLicenseInfoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TLicenseInfoClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TLicenseInfoDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TLicenseInfo(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TConfigFileDataCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConfigFileDataClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TConfigFileDataDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConfigFileData(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TConfigParamsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConfigParamsClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TConfigParamsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConfigParams(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBServerPropertiesClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesFetch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).Fetch;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesFetchDatabaseInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).FetchDatabaseInfo;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesFetchLicenseInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).FetchLicenseInfo;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesFetchLicenseMaskInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).FetchLicenseMaskInfo;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesFetchConfigParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).FetchConfigParams;
  end;
end;

procedure TatIBServicesLibrary.__TIBServerPropertiesFetchVersionInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBServerProperties(CurrentObject).FetchVersionInfo;
  end;
end;

procedure TatIBServicesLibrary.__GetTIBServerPropertiesDatabaseInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBServerProperties(CurrentObject).DatabaseInfo));
  end;
end;

procedure TatIBServicesLibrary.__GetTIBServerPropertiesLicenseInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBServerProperties(CurrentObject).LicenseInfo));
  end;
end;

procedure TatIBServicesLibrary.__GetTIBServerPropertiesLicenseMaskInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBServerProperties(CurrentObject).LicenseMaskInfo));
  end;
end;

procedure TatIBServicesLibrary.__GetTIBServerPropertiesVersionInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBServerProperties(CurrentObject).VersionInfo));
  end;
end;

procedure TatIBServicesLibrary.__GetTIBServerPropertiesConfigParams(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBServerProperties(CurrentObject).ConfigParams));
  end;
end;

procedure TatIBServicesLibrary.__TIBControlServiceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBControlServiceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBControlServiceServiceStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBControlService(CurrentObject).ServiceStart;
  end;
end;

procedure TatIBServicesLibrary.__GetTIBControlServiceIsServiceRunning(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBControlService(CurrentObject).IsServiceRunning);
  end;
end;

procedure TatIBServicesLibrary.__TIBControlAndQueryServicecreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBControlAndQueryServiceClass(CurrentClass.ClassRef).create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBControlAndQueryServiceGetNextLine(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBControlAndQueryService(CurrentObject).GetNextLine;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBControlAndQueryServiceGetNextChunk(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBControlAndQueryService(CurrentObject).GetNextChunk;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__GetTIBControlAndQueryServiceEof(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBControlAndQueryService(CurrentObject).Eof);
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceServiceStart(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).ServiceStart;
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceShutdownDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).ShutdownDatabase(GetInputArg(0),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceSetSweepInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).SetSweepInterval(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceSetDBSqlDialect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).SetDBSqlDialect(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceSetPageBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).SetPageBuffers(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceActivateShadow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).ActivateShadow;
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceBringDatabaseOnline(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).BringDatabaseOnline;
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceSetReserveSpace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).SetReserveSpace(GetInputArg(0));
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceSetAsyncMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).SetAsyncMode(GetInputArg(0));
  end;
end;

procedure TatIBServicesLibrary.__TIBConfigServiceSetReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConfigService(CurrentObject).SetReadOnly(GetInputArg(0));
  end;
end;

procedure TatIBServicesLibrary.__TIBLicensingServiceAddLicense(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBLicensingService(CurrentObject).AddLicense;
  end;
end;

procedure TatIBServicesLibrary.__TIBLicensingServiceRemoveLicense(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBLicensingService(CurrentObject).RemoveLicense;
  end;
end;

procedure TatIBServicesLibrary.__TIBBackupServiceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBackupServiceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBBackupServiceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBackupService(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBRestoreServiceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBRestoreServiceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBRestoreServiceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBRestoreService(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBValidationServiceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBValidationServiceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBValidationServiceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBValidationService(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBValidationServiceFetchLimboTransactionInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBValidationService(CurrentObject).FetchLimboTransactionInfo;
  end;
end;

procedure TatIBServicesLibrary.__TIBValidationServiceFixLimboTransactionErrors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBValidationService(CurrentObject).FixLimboTransactionErrors;
  end;
end;

procedure TatIBServicesLibrary.__GetTIBValidationServiceLimboTransactionInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBValidationService(CurrentObject).LimboTransactionInfo[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBServicesLibrary.__GetTIBValidationServiceLimboTransactionInfoCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBValidationService(CurrentObject).LimboTransactionInfoCount));
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSecurityServiceClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSecurityService(CurrentObject).Destroy;
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceDisplayUsers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSecurityService(CurrentObject).DisplayUsers;
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceDisplayUser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSecurityService(CurrentObject).DisplayUser(GetInputArg(0));
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceAddUser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSecurityService(CurrentObject).AddUser;
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceDeleteUser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSecurityService(CurrentObject).DeleteUser;
  end;
end;

procedure TatIBServicesLibrary.__TIBSecurityServiceModifyUser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSecurityService(CurrentObject).ModifyUser;
  end;
end;

procedure TatIBServicesLibrary.__GetTIBSecurityServiceUserInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSecurityService(CurrentObject).UserInfo[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatIBServicesLibrary.__GetTIBSecurityServiceUserInfoCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSecurityService(CurrentObject).UserInfoCount));
  end;
end;

procedure TatIBServicesDispatcher.__TLoginEvent( Database: TIBCustomService;  LoginParams: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TLoginEvent(BeforeCall)(Database,LoginParams);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Database,LoginParams]);
    if AssignedMethod(AfterCall) then
      TLoginEvent(AfterCall)(Database,LoginParams);
  end;
end;

procedure TatIBServicesLibrary.Init;
begin
  With Scripter.DefineClass(TIBCustomService) do
  begin
    DefineMethod('Create',1,tkClass,TIBCustomService,__TIBCustomServiceCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBCustomServiceDestroy,false,0);
    DefineMethod('Attach',0,tkNone,nil,__TIBCustomServiceAttach,false,0);
    DefineMethod('Detach',0,tkNone,nil,__TIBCustomServiceDetach,false,0);
    DefineProp('ServiceParamBySPB',tkVariant,__GetTIBCustomServiceServiceParamBySPB,__SetTIBCustomServiceServiceParamBySPB,nil,false,1);
  end;
  With Scripter.DefineClass(TDatabaseInfo) do
  begin
    DefineMethod('Create',0,tkClass,TDatabaseInfo,__TDatabaseInfoCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDatabaseInfoDestroy,false,0);
  end;
  With Scripter.DefineClass(TLicenseInfo) do
  begin
    DefineMethod('Create',0,tkClass,TLicenseInfo,__TLicenseInfoCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TLicenseInfoDestroy,false,0);
  end;
  With Scripter.DefineClass(TLicenseMaskInfo) do
  begin
  end;
  With Scripter.DefineClass(TConfigFileData) do
  begin
    DefineMethod('Create',0,tkClass,TConfigFileData,__TConfigFileDataCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TConfigFileDataDestroy,false,0);
  end;
  With Scripter.DefineClass(TConfigParams) do
  begin
    DefineMethod('Create',0,tkClass,TConfigParams,__TConfigParamsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TConfigParamsDestroy,false,0);
  end;
  With Scripter.DefineClass(TVersionInfo) do
  begin
  end;
  With Scripter.DefineClass(TIBServerProperties) do
  begin
    DefineMethod('Create',1,tkClass,TIBServerProperties,__TIBServerPropertiesCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBServerPropertiesDestroy,false,0);
    DefineMethod('Fetch',0,tkNone,nil,__TIBServerPropertiesFetch,false,0);
    DefineMethod('FetchDatabaseInfo',0,tkNone,nil,__TIBServerPropertiesFetchDatabaseInfo,false,0);
    DefineMethod('FetchLicenseInfo',0,tkNone,nil,__TIBServerPropertiesFetchLicenseInfo,false,0);
    DefineMethod('FetchLicenseMaskInfo',0,tkNone,nil,__TIBServerPropertiesFetchLicenseMaskInfo,false,0);
    DefineMethod('FetchConfigParams',0,tkNone,nil,__TIBServerPropertiesFetchConfigParams,false,0);
    DefineMethod('FetchVersionInfo',0,tkNone,nil,__TIBServerPropertiesFetchVersionInfo,false,0);
    DefineProp('DatabaseInfo',tkClass,__GetTIBServerPropertiesDatabaseInfo,nil,TDatabaseInfo,false,0);
    DefineProp('LicenseInfo',tkClass,__GetTIBServerPropertiesLicenseInfo,nil,TLicenseInfo,false,0);
    DefineProp('LicenseMaskInfo',tkClass,__GetTIBServerPropertiesLicenseMaskInfo,nil,TLicenseMaskInfo,false,0);
    DefineProp('VersionInfo',tkClass,__GetTIBServerPropertiesVersionInfo,nil,TVersionInfo,false,0);
    DefineProp('ConfigParams',tkClass,__GetTIBServerPropertiesConfigParams,nil,TConfigParams,false,0);
  end;
  With Scripter.DefineClass(TIBControlService) do
  begin
    DefineMethod('Create',1,tkClass,TIBControlService,__TIBControlServiceCreate,true,0);
    DefineMethod('ServiceStart',0,tkNone,nil,__TIBControlServiceServiceStart,false,0);
    DefineProp('IsServiceRunning',tkVariant,__GetTIBControlServiceIsServiceRunning,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBControlAndQueryService) do
  begin
    DefineMethod('create',1,tkClass,TIBControlAndQueryService,__TIBControlAndQueryServicecreate,true,0);
    DefineMethod('GetNextLine',0,tkVariant,nil,__TIBControlAndQueryServiceGetNextLine,false,0);
    DefineMethod('GetNextChunk',0,tkVariant,nil,__TIBControlAndQueryServiceGetNextChunk,false,0);
    DefineProp('Eof',tkVariant,__GetTIBControlAndQueryServiceEof,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBConfigService) do
  begin
    DefineMethod('ServiceStart',0,tkNone,nil,__TIBConfigServiceServiceStart,false,0);
    DefineMethod('ShutdownDatabase',2,tkNone,nil,__TIBConfigServiceShutdownDatabase,false,0);
    DefineMethod('SetSweepInterval',1,tkNone,nil,__TIBConfigServiceSetSweepInterval,false,0);
    DefineMethod('SetDBSqlDialect',1,tkNone,nil,__TIBConfigServiceSetDBSqlDialect,false,0);
    DefineMethod('SetPageBuffers',1,tkNone,nil,__TIBConfigServiceSetPageBuffers,false,0);
    DefineMethod('ActivateShadow',0,tkNone,nil,__TIBConfigServiceActivateShadow,false,0);
    DefineMethod('BringDatabaseOnline',0,tkNone,nil,__TIBConfigServiceBringDatabaseOnline,false,0);
    DefineMethod('SetReserveSpace',1,tkNone,nil,__TIBConfigServiceSetReserveSpace,false,0);
    DefineMethod('SetAsyncMode',1,tkNone,nil,__TIBConfigServiceSetAsyncMode,false,0);
    DefineMethod('SetReadOnly',1,tkNone,nil,__TIBConfigServiceSetReadOnly,false,0);
  end;
  With Scripter.DefineClass(TIBLicensingService) do
  begin
    DefineMethod('AddLicense',0,tkNone,nil,__TIBLicensingServiceAddLicense,false,0);
    DefineMethod('RemoveLicense',0,tkNone,nil,__TIBLicensingServiceRemoveLicense,false,0);
  end;
  With Scripter.DefineClass(TIBLogService) do
  begin
  end;
  With Scripter.DefineClass(TIBStatisticalService) do
  begin
  end;
  With Scripter.DefineClass(TIBBackupRestoreService) do
  begin
  end;
  With Scripter.DefineClass(TIBBackupService) do
  begin
    DefineMethod('Create',1,tkClass,TIBBackupService,__TIBBackupServiceCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBBackupServiceDestroy,false,0);
  end;
  With Scripter.DefineClass(TIBRestoreService) do
  begin
    DefineMethod('Create',1,tkClass,TIBRestoreService,__TIBRestoreServiceCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBRestoreServiceDestroy,false,0);
  end;
  With Scripter.DefineClass(TLimboTransactionInfo) do
  begin
  end;
  With Scripter.DefineClass(TIBValidationService) do
  begin
    DefineMethod('Create',1,tkClass,TIBValidationService,__TIBValidationServiceCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBValidationServiceDestroy,false,0);
    DefineMethod('FetchLimboTransactionInfo',0,tkNone,nil,__TIBValidationServiceFetchLimboTransactionInfo,false,0);
    DefineMethod('FixLimboTransactionErrors',0,tkNone,nil,__TIBValidationServiceFixLimboTransactionErrors,false,0);
    DefineProp('LimboTransactionInfo',tkClass,__GetTIBValidationServiceLimboTransactionInfo,nil,TLimboTransactionInfo,false,1);
    DefineProp('LimboTransactionInfoCount',tkInteger,__GetTIBValidationServiceLimboTransactionInfoCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TUserInfo) do
  begin
  end;
  With Scripter.DefineClass(TIBSecurityService) do
  begin
    DefineMethod('Create',1,tkClass,TIBSecurityService,__TIBSecurityServiceCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBSecurityServiceDestroy,false,0);
    DefineMethod('DisplayUsers',0,tkNone,nil,__TIBSecurityServiceDisplayUsers,false,0);
    DefineMethod('DisplayUser',1,tkNone,nil,__TIBSecurityServiceDisplayUser,false,0);
    DefineMethod('AddUser',0,tkNone,nil,__TIBSecurityServiceAddUser,false,0);
    DefineMethod('DeleteUser',0,tkNone,nil,__TIBSecurityServiceDeleteUser,false,0);
    DefineMethod('ModifyUser',0,tkNone,nil,__TIBSecurityServiceModifyUser,false,0);
    DefineProp('UserInfo',tkClass,__GetTIBSecurityServiceUserInfo,nil,TUserInfo,false,1);
    DefineProp('UserInfoCount',tkInteger,__GetTIBSecurityServiceUserInfoCount,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TLoginEvent), TatIBServicesDispatcher, @TatIBServicesDispatcher.__TLoginEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('TCP',TCP);
    AddConstant('SPX',SPX);
    AddConstant('NamedPipe',NamedPipe);
    AddConstant('Local',Local);
    AddConstant('ByLine',ByLine);
    AddConstant('ByChunk',ByChunk);
    AddConstant('Database',Database);
    AddConstant('License',License);
    AddConstant('LicenseMask',LicenseMask);
    AddConstant('ConfigParameters',ConfigParameters);
    AddConstant('Version',Version);
    AddConstant('Forced',Forced);
    AddConstant('DenyTransaction',DenyTransaction);
    AddConstant('DenyAttachment',DenyAttachment);
    AddConstant('LicenseAdd',LicenseAdd);
    AddConstant('LicenseRemove',LicenseRemove);
    AddConstant('DataPages',DataPages);
    AddConstant('DbLog',DbLog);
    AddConstant('HeaderPages',HeaderPages);
    AddConstant('IndexPages',IndexPages);
    AddConstant('SystemRelations',SystemRelations);
    AddConstant('IgnoreChecksums',IgnoreChecksums);
    AddConstant('IgnoreLimbo',IgnoreLimbo);
    AddConstant('MetadataOnly',MetadataOnly);
    AddConstant('NoGarbageCollection',NoGarbageCollection);
    AddConstant('OldMetadataDesc',OldMetadataDesc);
    AddConstant('NonTransportable',NonTransportable);
    AddConstant('ConvertExtTables',ConvertExtTables);
    AddConstant('DeactivateIndexes',DeactivateIndexes);
    AddConstant('NoShadow',NoShadow);
    AddConstant('NoValidityCheck',NoValidityCheck);
    AddConstant('OneRelationAtATime',OneRelationAtATime);
    AddConstant('Replace',Replace);
    AddConstant('CreateNewDB',CreateNewDB);
    AddConstant('UseAllSpace',UseAllSpace);
    AddConstant('LimboTransactions',LimboTransactions);
    AddConstant('CheckDB',CheckDB);
    AddConstant('IgnoreChecksum',IgnoreChecksum);
    AddConstant('KillShadows',KillShadows);
    AddConstant('MendDB',MendDB);
    AddConstant('SweepDB',SweepDB);
    AddConstant('ValidateDB',ValidateDB);
    AddConstant('ValidateFull',ValidateFull);
    AddConstant('CommitGlobal',CommitGlobal);
    AddConstant('RollbackGlobal',RollbackGlobal);
    AddConstant('RecoverTwoPhaseGlobal',RecoverTwoPhaseGlobal);
    AddConstant('NoGlobalAction',NoGlobalAction);
    AddConstant('LimboState',LimboState);
    AddConstant('CommitState',CommitState);
    AddConstant('RollbackState',RollbackState);
    AddConstant('UnknownState',UnknownState);
    AddConstant('CommitAdvise',CommitAdvise);
    AddConstant('RollbackAdvise',RollbackAdvise);
    AddConstant('UnknownAdvise',UnknownAdvise);
    AddConstant('CommitAction',CommitAction);
    AddConstant('RollbackAction',RollbackAction);
    AddConstant('ActionAddUser',ActionAddUser);
    AddConstant('ActionDeleteUser',ActionDeleteUser);
    AddConstant('ActionModifyUser',ActionModifyUser);
    AddConstant('ActionDisplayUser',ActionDisplayUser);
    AddConstant('ModifyFirstName',ModifyFirstName);
    AddConstant('ModifyMiddleName',ModifyMiddleName);
    AddConstant('ModifyLastName',ModifyLastName);
    AddConstant('ModifyUserId',ModifyUserId);
    AddConstant('ModifyGroupId',ModifyGroupId);
    AddConstant('ModifyPassword',ModifyPassword);
    AddConstant('DefaultBufferSize',DefaultBufferSize);
    AddConstant('SPBPrefix',SPBPrefix);
  end;
end;

class function TatIBServicesLibrary.LibraryName: string;
begin
  result := 'IBServices';
end;

initialization
  RegisterScripterLibrary(TatIBServicesLibrary, True);

{$WARNINGS ON}

end.

