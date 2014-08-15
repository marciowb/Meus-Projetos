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
unit ap_CmAdmCtl;

interface

uses
  Windows,
  ActiveX,
  Classes,
  Graphics,
  OleServer,
  OleCtrls,
  StdVCL,
  COMAdmin,
  CmAdmCtl,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatCmAdmCtlLibrary = class(TatScripterLibrary)
    procedure __TCOMAdminCatalogCreate(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogDestroy(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogConnect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogDisconnect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogGetCollection(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogICOMAdminCatalog_Connect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogGet_MajorVersion(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogGet_MinorVersion(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogImportComponent(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogInstallComponent(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogShutdownApplication(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogExportApplication(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogInstallApplication(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogStopRouter(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogRefreshRouter(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogStartRouter(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogRefreshComponents(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogBackupREGDB(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogRestoreREGDB(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogStartApplication(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogServiceCheck(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogInstallEventClass(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogMajorVersion(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogMinorVersion(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectCreate(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectConnect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectDisconnect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectGet_Value(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectSet_Value(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectGet_Key(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectGet_Name(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectIsPropertyReadOnly(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectGet_Valid(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogObjectIsPropertyWriteOnly(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogObjectValue(AMachine: TatVirtualMachine);
    procedure __SetTCOMAdminCatalogObjectValue(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogObjectKey(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogObjectName(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogObjectValid(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionDestroy(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionConnect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionDisconnect(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_Item(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_Count(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionRemove(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionAdd(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionPopulate(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionSaveChanges(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGetCollection(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_Name(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_AddEnabled(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_RemoveEnabled(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGetUtilInterface(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_DataStoreMajorVersion(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionGet_DataStoreMinorVersion(AMachine: TatVirtualMachine);
    procedure __TCOMAdminCatalogCollectionPopulateByQuery(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogCollectionCount(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogCollectionName(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogCollectionAddEnabled(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogCollectionRemoveEnabled(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogCollectionDataStoreMajorVersion(AMachine: TatVirtualMachine);
    procedure __GetTCOMAdminCatalogCollectionDataStoreMinorVersion(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  CoCOMAdminCatalogClass = class of CoCOMAdminCatalog;
  TCOMAdminCatalogClass = class of TCOMAdminCatalog;
  CoCOMAdminCatalogObjectClass = class of CoCOMAdminCatalogObject;
  TCOMAdminCatalogObjectClass = class of TCOMAdminCatalogObject;
  CoCOMAdminCatalogCollectionClass = class of CoCOMAdminCatalogCollection;
  TCOMAdminCatalogCollectionClass = class of TCOMAdminCatalogCollection;



implementation



procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).Destroy;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogConnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).Connect;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).Disconnect;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogGetCollection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalog(CurrentObject).GetCollection(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogICOMAdminCatalog_Connect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalog(CurrentObject).ICOMAdminCatalog_Connect(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogGet_MajorVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalog(CurrentObject).Get_MajorVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogGet_MinorVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalog(CurrentObject).Get_MinorVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogImportComponent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).ImportComponent(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogInstallComponent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).InstallComponent(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogShutdownApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).ShutdownApplication(GetInputArg(0));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogExportApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).ExportApplication(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogInstallApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).InstallApplication(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),GetInputArg(3),GetInputArg(4),GetInputArg(5));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogStopRouter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).StopRouter;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogRefreshRouter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).RefreshRouter;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogStartRouter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).StartRouter;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogRefreshComponents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).RefreshComponents;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogBackupREGDB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).BackupREGDB(GetInputArg(0));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogRestoreREGDB(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).RestoreREGDB(GetInputArg(0));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogStartApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).StartApplication(GetInputArg(0));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogServiceCheck(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalog(CurrentObject).ServiceCheck(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogInstallEventClass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalog(CurrentObject).InstallEventClass(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3));
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogMajorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCOMAdminCatalog(CurrentObject).MajorVersion));
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogMinorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCOMAdminCatalog(CurrentObject).MinorVersion));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogObjectClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogObject(CurrentObject).Destroy;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectConnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogObject(CurrentObject).Connect;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogObject(CurrentObject).Disconnect;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectGet_Value(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogObject(CurrentObject).Get_Value(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectSet_Value(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogObject(CurrentObject).Set_Value(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectGet_Key(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogObject(CurrentObject).Get_Key;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectGet_Name(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogObject(CurrentObject).Get_Name;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectIsPropertyReadOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogObject(CurrentObject).IsPropertyReadOnly(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectGet_Valid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogObject(CurrentObject).Get_Valid;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogObjectIsPropertyWriteOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogObject(CurrentObject).IsPropertyWriteOnly(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogObjectValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogObject(CurrentObject).Value[GetArrayIndex(0)]);
  end;
end;

procedure TatCmAdmCtlLibrary.__SetTCOMAdminCatalogObjectValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogObject(CurrentObject).Value[GetArrayIndex(0)]:=GetInputArg(0);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogObjectKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogObject(CurrentObject).Key);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogObjectName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogObject(CurrentObject).Name);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogObjectValid(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogObject(CurrentObject).Valid);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogCollection(CurrentObject).Destroy;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionConnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogCollection(CurrentObject).Connect;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogCollection(CurrentObject).Disconnect;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_Item(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).Get_Item(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_Count(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).Get_Count);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionRemove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogCollection(CurrentObject).Remove(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionPopulate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogCollection(CurrentObject).Populate;
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionSaveChanges(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).SaveChanges);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGetCollection(AMachine: TatVirtualMachine);
  var
  Param1: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).GetCollection(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_Name(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogCollection(CurrentObject).Get_Name;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_AddEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogCollection(CurrentObject).Get_AddEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_RemoveEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogCollection(CurrentObject).Get_RemoveEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGetUtilInterface(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCOMAdminCatalogCollection(CurrentObject).GetUtilInterface;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_DataStoreMajorVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).Get_DataStoreMajorVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionGet_DataStoreMinorVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCOMAdminCatalogCollection(CurrentObject).Get_DataStoreMinorVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCmAdmCtlLibrary.__TCOMAdminCatalogCollectionPopulateByQuery(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCOMAdminCatalogCollection(CurrentObject).PopulateByQuery(GetInputArg(0),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogCollectionCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCOMAdminCatalogCollection(CurrentObject).Count));
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogCollectionName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogCollection(CurrentObject).Name);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogCollectionAddEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogCollection(CurrentObject).AddEnabled);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogCollectionRemoveEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCOMAdminCatalogCollection(CurrentObject).RemoveEnabled);
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogCollectionDataStoreMajorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCOMAdminCatalogCollection(CurrentObject).DataStoreMajorVersion));
  end;
end;

procedure TatCmAdmCtlLibrary.__GetTCOMAdminCatalogCollectionDataStoreMinorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCOMAdminCatalogCollection(CurrentObject).DataStoreMinorVersion));
  end;
end;

procedure TatCmAdmCtlLibrary.Init;
begin
  With Scripter.DefineClass(CoCOMAdminCatalog) do
  begin
  end;
  With Scripter.DefineClass(TCOMAdminCatalog) do
  begin
    DefineMethod('Create',1,tkClass,TCOMAdminCatalog,__TCOMAdminCatalogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCOMAdminCatalogDestroy,false,0);
    DefineMethod('Connect',0,tkNone,nil,__TCOMAdminCatalogConnect,false,0);
    DefineMethod('Disconnect',0,tkNone,nil,__TCOMAdminCatalogDisconnect,false,0);
    DefineMethod('GetCollection',1,tkClass,TCOMAdminCatalogCollection,__TCOMAdminCatalogGetCollection,false,0);
    DefineMethod('ICOMAdminCatalog_Connect',1,tkClass,TCOMAdminCatalogCollection,__TCOMAdminCatalogICOMAdminCatalog_Connect,false,0);
    DefineMethod('Get_MajorVersion',0,tkInteger,nil,__TCOMAdminCatalogGet_MajorVersion,false,0);
    DefineMethod('Get_MinorVersion',0,tkInteger,nil,__TCOMAdminCatalogGet_MinorVersion,false,0);
    DefineMethod('ImportComponent',2,tkNone,nil,__TCOMAdminCatalogImportComponent,false,0);
    DefineMethod('InstallComponent',4,tkNone,nil,__TCOMAdminCatalogInstallComponent,false,0);
    DefineMethod('ShutdownApplication',1,tkNone,nil,__TCOMAdminCatalogShutdownApplication,false,0);
    DefineMethod('ExportApplication',3,tkNone,nil,__TCOMAdminCatalogExportApplication,false,0);
    DefineMethod('InstallApplication',6,tkNone,nil,__TCOMAdminCatalogInstallApplication,false,0);
    DefineMethod('StopRouter',0,tkNone,nil,__TCOMAdminCatalogStopRouter,false,0);
    DefineMethod('RefreshRouter',0,tkNone,nil,__TCOMAdminCatalogRefreshRouter,false,0);
    DefineMethod('StartRouter',0,tkNone,nil,__TCOMAdminCatalogStartRouter,false,0);
    DefineMethod('RefreshComponents',0,tkNone,nil,__TCOMAdminCatalogRefreshComponents,false,0);
    DefineMethod('BackupREGDB',1,tkNone,nil,__TCOMAdminCatalogBackupREGDB,false,0);
    DefineMethod('RestoreREGDB',1,tkNone,nil,__TCOMAdminCatalogRestoreREGDB,false,0);
    DefineMethod('StartApplication',1,tkNone,nil,__TCOMAdminCatalogStartApplication,false,0);
    DefineMethod('ServiceCheck',1,tkInteger,nil,__TCOMAdminCatalogServiceCheck,false,0);
    DefineMethod('InstallEventClass',4,tkNone,nil,__TCOMAdminCatalogInstallEventClass,false,0);
    DefineProp('MajorVersion',tkInteger,__GetTCOMAdminCatalogMajorVersion,nil,nil,false,0);
    DefineProp('MinorVersion',tkInteger,__GetTCOMAdminCatalogMinorVersion,nil,nil,false,0);
  end;
  With Scripter.DefineClass(CoCOMAdminCatalogObject) do
  begin
  end;
  With Scripter.DefineClass(TCOMAdminCatalogObject) do
  begin
    DefineMethod('Create',1,tkClass,TCOMAdminCatalogObject,__TCOMAdminCatalogObjectCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCOMAdminCatalogObjectDestroy,false,0);
    DefineMethod('Connect',0,tkNone,nil,__TCOMAdminCatalogObjectConnect,false,0);
    DefineMethod('Disconnect',0,tkNone,nil,__TCOMAdminCatalogObjectDisconnect,false,0);
    DefineMethod('Get_Value',1,tkVariant,nil,__TCOMAdminCatalogObjectGet_Value,false,0);
    DefineMethod('Set_Value',2,tkNone,nil,__TCOMAdminCatalogObjectSet_Value,false,0);
    DefineMethod('Get_Key',0,tkVariant,nil,__TCOMAdminCatalogObjectGet_Key,false,0);
    DefineMethod('Get_Name',0,tkVariant,nil,__TCOMAdminCatalogObjectGet_Name,false,0);
    DefineMethod('IsPropertyReadOnly',1,tkVariant,nil,__TCOMAdminCatalogObjectIsPropertyReadOnly,false,0);
    DefineMethod('Get_Valid',0,tkVariant,nil,__TCOMAdminCatalogObjectGet_Valid,false,0);
    DefineMethod('IsPropertyWriteOnly',1,tkVariant,nil,__TCOMAdminCatalogObjectIsPropertyWriteOnly,false,0);
    DefineProp('Value',tkVariant,__GetTCOMAdminCatalogObjectValue,__SetTCOMAdminCatalogObjectValue,nil,false,1);
    DefineProp('Key',tkVariant,__GetTCOMAdminCatalogObjectKey,nil,nil,false,0);
    DefineProp('Name',tkVariant,__GetTCOMAdminCatalogObjectName,nil,nil,false,0);
    DefineProp('Valid',tkVariant,__GetTCOMAdminCatalogObjectValid,nil,nil,false,0);
  end;
  With Scripter.DefineClass(CoCOMAdminCatalogCollection) do
  begin
  end;
  With Scripter.DefineClass(TCOMAdminCatalogCollection) do
  begin
    DefineMethod('Create',1,tkClass,TCOMAdminCatalogCollection,__TCOMAdminCatalogCollectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCOMAdminCatalogCollectionDestroy,false,0);
    DefineMethod('Connect',0,tkNone,nil,__TCOMAdminCatalogCollectionConnect,false,0);
    DefineMethod('Disconnect',0,tkNone,nil,__TCOMAdminCatalogCollectionDisconnect,false,0);
    DefineMethod('Get_Item',1,tkClass,TCOMAdminCatalogObject,__TCOMAdminCatalogCollectionGet_Item,false,0);
    DefineMethod('Get_Count',0,tkInteger,nil,__TCOMAdminCatalogCollectionGet_Count,false,0);
    DefineMethod('Remove',1,tkNone,nil,__TCOMAdminCatalogCollectionRemove,false,0);
    DefineMethod('Add',0,tkClass,TCOMAdminCatalogObject,__TCOMAdminCatalogCollectionAdd,false,0);
    DefineMethod('Populate',0,tkNone,nil,__TCOMAdminCatalogCollectionPopulate,false,0);
    DefineMethod('SaveChanges',0,tkInteger,nil,__TCOMAdminCatalogCollectionSaveChanges,false,0);
    DefineMethod('GetCollection',2,tkClass,TCOMAdminCatalogCollection,__TCOMAdminCatalogCollectionGetCollection,false,0).SetVarArgs([1]);
    DefineMethod('Get_Name',0,tkVariant,nil,__TCOMAdminCatalogCollectionGet_Name,false,0);
    DefineMethod('Get_AddEnabled',0,tkVariant,nil,__TCOMAdminCatalogCollectionGet_AddEnabled,false,0);
    DefineMethod('Get_RemoveEnabled',0,tkVariant,nil,__TCOMAdminCatalogCollectionGet_RemoveEnabled,false,0);
    DefineMethod('GetUtilInterface',0,tkVariant,nil,__TCOMAdminCatalogCollectionGetUtilInterface,false,0);
    DefineMethod('Get_DataStoreMajorVersion',0,tkInteger,nil,__TCOMAdminCatalogCollectionGet_DataStoreMajorVersion,false,0);
    DefineMethod('Get_DataStoreMinorVersion',0,tkInteger,nil,__TCOMAdminCatalogCollectionGet_DataStoreMinorVersion,false,0);
    DefineMethod('PopulateByQuery',2,tkNone,nil,__TCOMAdminCatalogCollectionPopulateByQuery,false,0);
    DefineProp('Count',tkInteger,__GetTCOMAdminCatalogCollectionCount,nil,nil,false,0);
    DefineProp('Name',tkVariant,__GetTCOMAdminCatalogCollectionName,nil,nil,false,0);
    DefineProp('AddEnabled',tkVariant,__GetTCOMAdminCatalogCollectionAddEnabled,nil,nil,false,0);
    DefineProp('RemoveEnabled',tkVariant,__GetTCOMAdminCatalogCollectionRemoveEnabled,nil,nil,false,0);
    DefineProp('DataStoreMajorVersion',tkInteger,__GetTCOMAdminCatalogCollectionDataStoreMajorVersion,nil,nil,false,0);
    DefineProp('DataStoreMinorVersion',tkInteger,__GetTCOMAdminCatalogCollectionDataStoreMinorVersion,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatCmAdmCtlLibrary.LibraryName: string;
begin
  result := 'CmAdmCtl';
end;

initialization
  RegisterScripterLibrary(TatCmAdmCtlLibrary, True);

{$WARNINGS ON}

end.

