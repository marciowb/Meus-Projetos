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
unit ap_COMAdmin;

interface

uses
  Windows,
  ActiveX,
  COMAdmin,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatCOMAdminLibrary = class(TatScripterLibrary)
    procedure __GetLIBID_COMAdmin(AMachine: TatVirtualMachine);
    procedure __GetIID_ICOMAdminCatalog(AMachine: TatVirtualMachine);
    procedure __GetCLASS_COMAdminCatalog(AMachine: TatVirtualMachine);
    procedure __GetIID_ICatalogObject(AMachine: TatVirtualMachine);
    procedure __GetCLASS_COMAdminCatalogObject(AMachine: TatVirtualMachine);
    procedure __GetIID_ICatalogCollection(AMachine: TatVirtualMachine);
    procedure __GetCLASS_COMAdminCatalogCollection(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatCOMAdminLibrary.__GetLIBID_COMAdmin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.LIBID_COMAdmin)));
  end;
end;

procedure TatCOMAdminLibrary.__GetIID_ICOMAdminCatalog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.IID_ICOMAdminCatalog)));
  end;
end;

procedure TatCOMAdminLibrary.__GetCLASS_COMAdminCatalog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.CLASS_COMAdminCatalog)));
  end;
end;

procedure TatCOMAdminLibrary.__GetIID_ICatalogObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.IID_ICatalogObject)));
  end;
end;

procedure TatCOMAdminLibrary.__GetCLASS_COMAdminCatalogObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.CLASS_COMAdminCatalogObject)));
  end;
end;

procedure TatCOMAdminLibrary.__GetIID_ICatalogCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.IID_ICatalogCollection)));
  end;
end;

procedure TatCOMAdminLibrary.__GetCLASS_COMAdminCatalogCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(COMAdmin.CLASS_COMAdminCatalogCollection)));
  end;
end;

procedure TatCOMAdminLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_COMAdmin',tkVariant,__GetLIBID_COMAdmin,nil,nil,false,0);
    DefineProp('IID_ICOMAdminCatalog',tkVariant,__GetIID_ICOMAdminCatalog,nil,nil,false,0);
    DefineProp('CLASS_COMAdminCatalog',tkVariant,__GetCLASS_COMAdminCatalog,nil,nil,false,0);
    DefineProp('IID_ICatalogObject',tkVariant,__GetIID_ICatalogObject,nil,nil,false,0);
    DefineProp('CLASS_COMAdminCatalogObject',tkVariant,__GetCLASS_COMAdminCatalogObject,nil,nil,false,0);
    DefineProp('IID_ICatalogCollection',tkVariant,__GetIID_ICatalogCollection,nil,nil,false,0);
    DefineProp('CLASS_COMAdminCatalogCollection',tkVariant,__GetCLASS_COMAdminCatalogCollection,nil,nil,false,0);
    AddConstant('COMAdminMajorVersion',COMAdminMajorVersion);
    AddConstant('COMAdminMinorVersion',COMAdminMinorVersion);
    AddConstant('COMAdminInstallNoUsers',COMAdminInstallNoUsers);
    AddConstant('COMAdminInstallUsers',COMAdminInstallUsers);
    AddConstant('COMAdminInstallForceOverwriteOfFiles',COMAdminInstallForceOverwriteOfFiles);
    AddConstant('COMAdminExportNoUsers',COMAdminExportNoUsers);
    AddConstant('COMAdminExportUsers',COMAdminExportUsers);
    AddConstant('COMAdminExportApplicationProxy',COMAdminExportApplicationProxy);
    AddConstant('COMAdminExportForceOverwriteOfFiles',COMAdminExportForceOverwriteOfFiles);
    AddConstant('COMAdminThreadingModelApartment',COMAdminThreadingModelApartment);
    AddConstant('COMAdminThreadingModelFree',COMAdminThreadingModelFree);
    AddConstant('COMAdminThreadingModelMain',COMAdminThreadingModelMain);
    AddConstant('COMAdminThreadingModelBoth',COMAdminThreadingModelBoth);
    AddConstant('COMAdminThreadingModelNeutral',COMAdminThreadingModelNeutral);
    AddConstant('COMAdminThreadingModelNotSpecified',COMAdminThreadingModelNotSpecified);
    AddConstant('COMAdminTransactionIgnored',COMAdminTransactionIgnored);
    AddConstant('COMAdminTransactionNone',COMAdminTransactionNone);
    AddConstant('COMAdminTransactionSupported',COMAdminTransactionSupported);
    AddConstant('COMAdminTransactionRequired',COMAdminTransactionRequired);
    AddConstant('COMAdminTransactionRequiresNew',COMAdminTransactionRequiresNew);
    AddConstant('COMAdminSynchronizationIgnored',COMAdminSynchronizationIgnored);
    AddConstant('COMAdminSynchronizationNone',COMAdminSynchronizationNone);
    AddConstant('COMAdminSynchronizationSupported',COMAdminSynchronizationSupported);
    AddConstant('COMAdminSynchronizationRequired',COMAdminSynchronizationRequired);
    AddConstant('COMAdminSynchronizationRequiresNew',COMAdminSynchronizationRequiresNew);
    AddConstant('COMAdminActivationInproc',COMAdminActivationInproc);
    AddConstant('COMAdminActivationLocal',COMAdminActivationLocal);
    AddConstant('COMAdminAccessChecksApplicationLevel',COMAdminAccessChecksApplicationLevel);
    AddConstant('COMAdminAccessChecksApplicationComponentLevel',COMAdminAccessChecksApplicationComponentLevel);
    AddConstant('COMAdminAuthenticationDefault',COMAdminAuthenticationDefault);
    AddConstant('COMAdminAuthenticationNone',COMAdminAuthenticationNone);
    AddConstant('COMAdminAuthenticationConnect',COMAdminAuthenticationConnect);
    AddConstant('COMAdminAuthenticationCall',COMAdminAuthenticationCall);
    AddConstant('COMAdminAuthenticationPacket',COMAdminAuthenticationPacket);
    AddConstant('COMAdminAuthenticationIntegrity',COMAdminAuthenticationIntegrity);
    AddConstant('COMAdminAuthenticationPrivacy',COMAdminAuthenticationPrivacy);
    AddConstant('COMAdminImpersonationAnonymous',COMAdminImpersonationAnonymous);
    AddConstant('COMAdminImpersonationIdentify',COMAdminImpersonationIdentify);
    AddConstant('COMAdminImpersonationImpersonate',COMAdminImpersonationImpersonate);
    AddConstant('COMAdminImpersonationDelegate',COMAdminImpersonationDelegate);
    AddConstant('COMAdminAuthenticationCapabilitiesNone',COMAdminAuthenticationCapabilitiesNone);
    AddConstant('COMAdminAuthenticationCapabilitiesStaticCloaking',COMAdminAuthenticationCapabilitiesStaticCloaking);
    AddConstant('COMAdminAuthenticationCapabilitiesDynamicCloaking',COMAdminAuthenticationCapabilitiesDynamicCloaking);
    AddConstant('COMAdminAuthenticationCapabilitiesSecureReference',COMAdminAuthenticationCapabilitiesSecureReference);
    AddConstant('COMAdminOSWindows3_1',COMAdminOSWindows3_1);
    AddConstant('COMAdminOSWindows9x',COMAdminOSWindows9x);
    AddConstant('COMAdminOSWindowsNT',COMAdminOSWindowsNT);
    AddConstant('COMAdminOSWindowsNTEnterprise',COMAdminOSWindowsNTEnterprise);
    AddConstant('COMAdminServiceLoadBalanceRouter',COMAdminServiceLoadBalanceRouter);
    AddConstant('COMAdminServiceIMDB',COMAdminServiceIMDB);
    AddConstant('COMAdminServiceStopped',COMAdminServiceStopped);
    AddConstant('COMAdminServiceStartPending',COMAdminServiceStartPending);
    AddConstant('COMAdminServiceStopPending',COMAdminServiceStopPending);
    AddConstant('COMAdminServiceRunning',COMAdminServiceRunning);
    AddConstant('COMAdminServiceContinuePending',COMAdminServiceContinuePending);
    AddConstant('COMAdminServicePausePending',COMAdminServicePausePending);
    AddConstant('COMAdminServicePaused',COMAdminServicePaused);
    AddConstant('COMAdminServiceUnknownState',COMAdminServiceUnknownState);
    AddConstant('COMAdminFileFlagLoadable',COMAdminFileFlagLoadable);
    AddConstant('COMAdminFileFlagCOM',COMAdminFileFlagCOM);
    AddConstant('COMAdminFileFlagContainsPS',COMAdminFileFlagContainsPS);
    AddConstant('COMAdminFileFlagContainsComp',COMAdminFileFlagContainsComp);
    AddConstant('COMAdminFileFlagContainsTLB',COMAdminFileFlagContainsTLB);
    AddConstant('COMAdminFileFlagSelfReg',COMAdminFileFlagSelfReg);
    AddConstant('COMAdminFileFlagSelfUnReg',COMAdminFileFlagSelfUnReg);
    AddConstant('COMAdminFileFlagUnloadableDLL',COMAdminFileFlagUnloadableDLL);
    AddConstant('COMAdminFileFlagDoesNotExist',COMAdminFileFlagDoesNotExist);
    AddConstant('COMAdminFileFlagAlreadyInstalled',COMAdminFileFlagAlreadyInstalled);
    AddConstant('COMAdminFileFlagBadTLB',COMAdminFileFlagBadTLB);
    AddConstant('COMAdminFileFlagGetClassObjFailed',COMAdminFileFlagGetClassObjFailed);
    AddConstant('COMAdminFileFlagClassNotAvailable',COMAdminFileFlagClassNotAvailable);
    AddConstant('COMAdminFileFlagRegistrar',COMAdminFileFlagRegistrar);
    AddConstant('COMAdminFileFlagNoRegistrar',COMAdminFileFlagNoRegistrar);
    AddConstant('COMAdminFileFlagDLLRegsvrFailed',COMAdminFileFlagDLLRegsvrFailed);
    AddConstant('COMAdminFileFlagRegTLBFailed',COMAdminFileFlagRegTLBFailed);
    AddConstant('COMAdminFileFlagRegistrarFailed',COMAdminFileFlagRegistrarFailed);
    AddConstant('COMAdminFileFlagError',COMAdminFileFlagError);
    AddConstant('COMAdminCompFlagTypeInfoFound',COMAdminCompFlagTypeInfoFound);
    AddConstant('COMAdminCompFlagCOMPlusPropertiesFound',COMAdminCompFlagCOMPlusPropertiesFound);
    AddConstant('COMAdminCompFlagProxyFound',COMAdminCompFlagProxyFound);
    AddConstant('COMAdminCompFlagInterfacesFound',COMAdminCompFlagInterfacesFound);
    AddConstant('COMAdminCompFlagAlreadyInstalled',COMAdminCompFlagAlreadyInstalled);
    AddConstant('COMAdminCompFlagNotInApplication',COMAdminCompFlagNotInApplication);
    AddConstant('COMAdminErrObjectErrors',COMAdminErrObjectErrors);
    AddConstant('COMAdminErrObjectInvalid',COMAdminErrObjectInvalid);
    AddConstant('COMAdminErrKeyMissing',COMAdminErrKeyMissing);
    AddConstant('COMAdminErrAlreadyInstalled',COMAdminErrAlreadyInstalled);
    AddConstant('COMAdminErrAppFileWriteFail',COMAdminErrAppFileWriteFail);
    AddConstant('COMAdminErrAppFileReadFail',COMAdminErrAppFileReadFail);
    AddConstant('COMAdminErrAppFileVersion',COMAdminErrAppFileVersion);
    AddConstant('COMAdminErrBadPath',COMAdminErrBadPath);
    AddConstant('COMAdminErrApplicationExists',COMAdminErrApplicationExists);
    AddConstant('COMAdminErrRoleExists',COMAdminErrRoleExists);
    AddConstant('COMAdminErrCantCopyFile',COMAdminErrCantCopyFile);
    AddConstant('COMAdminErrNoUser',COMAdminErrNoUser);
    AddConstant('COMAdminErrInvalidUserids',COMAdminErrInvalidUserids);
    AddConstant('COMAdminErrNoRegistryCLSID',COMAdminErrNoRegistryCLSID);
    AddConstant('COMAdminErrBadRegistryProgID',COMAdminErrBadRegistryProgID);
    AddConstant('COMAdminErrAuthenticationLevel',COMAdminErrAuthenticationLevel);
    AddConstant('COMAdminErrUserPasswdNotValid',COMAdminErrUserPasswdNotValid);
    AddConstant('COMAdminErrCLSIDOrIIDMismatch',COMAdminErrCLSIDOrIIDMismatch);
    AddConstant('COMAdminErrRemoteInterface',COMAdminErrRemoteInterface);
    AddConstant('COMAdminErrDllRegisterServer',COMAdminErrDllRegisterServer);
    AddConstant('COMAdminErrNoServerShare',COMAdminErrNoServerShare);
    AddConstant('COMAdminErrDllLoadFailed',COMAdminErrDllLoadFailed);
    AddConstant('COMAdminErrBadRegistryLibID',COMAdminErrBadRegistryLibID);
    AddConstant('COMAdminErrAppDirNotFound',COMAdminErrAppDirNotFound);
    AddConstant('COMAdminErrRegistrarFailed',COMAdminErrRegistrarFailed);
    AddConstant('COMAdminErrCompFileDoesNotExist',COMAdminErrCompFileDoesNotExist);
    AddConstant('COMAdminErrCompFileLoadDLLFail',COMAdminErrCompFileLoadDLLFail);
    AddConstant('COMAdminErrCompFileGetClassObj',COMAdminErrCompFileGetClassObj);
    AddConstant('COMAdminErrCompFileClassNotAvail',COMAdminErrCompFileClassNotAvail);
    AddConstant('COMAdminErrCompFileBadTLB',COMAdminErrCompFileBadTLB);
    AddConstant('COMAdminErrCompFileNotInstallable',COMAdminErrCompFileNotInstallable);
    AddConstant('COMAdminErrNotChangeable',COMAdminErrNotChangeable);
    AddConstant('COMAdminErrNotDeletable',COMAdminErrNotDeletable);
    AddConstant('COMAdminErrSession',COMAdminErrSession);
    AddConstant('COMAdminErrCompMoveLocked',COMAdminErrCompMoveLocked);
    AddConstant('COMAdminErrCompMoveBadDest',COMAdminErrCompMoveBadDest);
    AddConstant('COMAdminErrRegisterTLB',COMAdminErrRegisterTLB);
    AddConstant('COMAdminErrSystemApp',COMAdminErrSystemApp);
    AddConstant('COMAdminErrCompFileNoRegistrar',COMAdminErrCompFileNoRegistrar);
    AddConstant('COMAdminErrCoReqCompInstalled',COMAdminErrCoReqCompInstalled);
    AddConstant('COMAdminErrServiceNotInstalled',COMAdminErrServiceNotInstalled);
    AddConstant('COMAdminErrPropertySaveFailed',COMAdminErrPropertySaveFailed);
    AddConstant('COMAdminErrObjectExists',COMAdminErrObjectExists);
    AddConstant('COMAdminErrRegFileCorrupt',COMAdminErrRegFileCorrupt);
    AddConstant('COMAdminErrPropertyOverflow',COMAdminErrPropertyOverflow);
    AddConstant('COMAdminErrNotInRegistry',COMAdminErrNotInRegistry);
    AddConstant('COMAdminErrObjectNotPoolable',COMAdminErrObjectNotPoolable);
    AddConstant('COMAdminErrApplidMatchesClsid',COMAdminErrApplidMatchesClsid);
    AddConstant('COMAdminErrRoleDoesNotExist',COMAdminErrRoleDoesNotExist);
    AddConstant('COMAdminErrStartAppNeedsComponents',COMAdminErrStartAppNeedsComponents);
    AddConstant('COMAdminErrRequiresDifferentPlatform',COMAdminErrRequiresDifferentPlatform);
    AddConstant('COMAdminErrQueuingServiceNotAvailable',COMAdminErrQueuingServiceNotAvailable);
    AddConstant('COMAdminErrObjectParentMissing',COMAdminErrObjectParentMissing);
    AddConstant('COMAdminErrObjectDoesNotExist',COMAdminErrObjectDoesNotExist);
    AddConstant('COMAdminErrCanNotExportAppProxy',COMAdminErrCanNotExportAppProxy);
    AddConstant('COMAdminErrCanNotStartApp',COMAdminErrCanNotStartApp);
    AddConstant('COMAdminErrCanNotExportSystemApp',COMAdminErrCanNotExportSystemApp);
    AddConstant('COMAdminErrCanNotSubscribeToComponent',COMAdminErrCanNotSubscribeToComponent);
  end;
end;

class function TatCOMAdminLibrary.LibraryName: string;
begin
  result := 'COMAdmin';
end;

initialization
  RegisterScripterLibrary(TatCOMAdminLibrary, True);

{$WARNINGS ON}

end.

