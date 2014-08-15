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
unit ap_ObjBrkr;

interface

uses
  MConnect,
  Classes,
  SysUtils,
  ObjBrkr,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatObjBrkrLibrary = class(TatScripterLibrary)
    procedure __TServerItemCreate(AMachine: TatVirtualMachine);
    procedure __GetTServerItemHasFailed(AMachine: TatVirtualMachine);
    procedure __SetTServerItemHasFailed(AMachine: TatVirtualMachine);
    procedure __TServerCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TServerCollectionGetBalancedName(AMachine: TatVirtualMachine);
    procedure __TServerCollectionGetNextName(AMachine: TatVirtualMachine);
    procedure __TServerCollectionFindServer(AMachine: TatVirtualMachine);
    procedure __GetTServerCollectionItems(AMachine: TatVirtualMachine);
    procedure __SetTServerCollectionItems(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerCreate(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerDestroy(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerSaveToStream(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerSetConnectStatus(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerGetComputerForGUID(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerGetComputerForProgID(AMachine: TatVirtualMachine);
    procedure __TSimpleObjectBrokerGetPortForComputer(AMachine: TatVirtualMachine);
    procedure __GetTSimpleObjectBrokerServerData(AMachine: TatVirtualMachine);
    procedure __SetTSimpleObjectBrokerServerData(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EBrokerExceptionClass = class of EBrokerException;
  TServerItemClass = class of TServerItem;
  TServerCollectionClass = class of TServerCollection;
  TSimpleObjectBrokerClass = class of TSimpleObjectBroker;



implementation



procedure TatObjBrkrLibrary.__TServerItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__GetTServerItemHasFailed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TServerItem(CurrentObject).HasFailed);
  end;
end;

procedure TatObjBrkrLibrary.__SetTServerItemHasFailed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerItem(CurrentObject).HasFailed:=GetInputArg(0);
  end;
end;

procedure TatObjBrkrLibrary.__TServerCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerCollectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__TServerCollectionGetBalancedName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TServerCollection(CurrentObject).GetBalancedName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__TServerCollectionGetNextName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TServerCollection(CurrentObject).GetNextName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__TServerCollectionFindServer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerCollection(CurrentObject).FindServer(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__GetTServerCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatObjBrkrLibrary.__SetTServerCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TServerItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSimpleObjectBrokerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleObjectBroker(CurrentObject).Destroy;
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleObjectBroker(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleObjectBroker(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerSetConnectStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleObjectBroker(CurrentObject).SetConnectStatus(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerGetComputerForGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSimpleObjectBroker(CurrentObject).GetComputerForGUID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerGetComputerForProgID(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := TSimpleObjectBroker(CurrentObject).GetComputerForProgID(Param0);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__TSimpleObjectBrokerGetPortForComputer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSimpleObjectBroker(CurrentObject).GetPortForComputer(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjBrkrLibrary.__GetTSimpleObjectBrokerServerData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSimpleObjectBroker(CurrentObject).ServerData);
  end;
end;

procedure TatObjBrkrLibrary.__SetTSimpleObjectBrokerServerData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSimpleObjectBroker(CurrentObject).ServerData:=GetInputArg(0);
  end;
end;

procedure TatObjBrkrLibrary.Init;
begin
  With Scripter.DefineClass(EBrokerException) do
  begin
  end;
  With Scripter.DefineClass(TServerItem) do
  begin
    DefineMethod('Create',1,tkClass,TServerItem,__TServerItemCreate,true,0);
    DefineProp('HasFailed',tkVariant,__GetTServerItemHasFailed,__SetTServerItemHasFailed,nil,false,0);
  end;
  With Scripter.DefineClass(TServerCollection) do
  begin
    DefineMethod('Create',1,tkClass,TServerCollection,__TServerCollectionCreate,true,0);
    DefineMethod('GetBalancedName',0,tkVariant,nil,__TServerCollectionGetBalancedName,false,0);
    DefineMethod('GetNextName',0,tkVariant,nil,__TServerCollectionGetNextName,false,0);
    DefineMethod('FindServer',1,tkClass,TServerItem,__TServerCollectionFindServer,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTServerCollectionItems,__SetTServerCollectionItems,TServerItem,false,1);
  end;
  With Scripter.DefineClass(TSimpleObjectBroker) do
  begin
    DefineMethod('Create',1,tkClass,TSimpleObjectBroker,__TSimpleObjectBrokerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSimpleObjectBrokerDestroy,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TSimpleObjectBrokerSaveToStream,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TSimpleObjectBrokerLoadFromStream,false,0);
    DefineMethod('SetConnectStatus',2,tkNone,nil,__TSimpleObjectBrokerSetConnectStatus,false,0);
    DefineMethod('GetComputerForGUID',1,tkVariant,nil,__TSimpleObjectBrokerGetComputerForGUID,false,0);
    DefineMethod('GetComputerForProgID',1,tkVariant,nil,__TSimpleObjectBrokerGetComputerForProgID,false,0);
    DefineMethod('GetPortForComputer',1,tkInteger,nil,__TSimpleObjectBrokerGetPortForComputer,false,0);
    DefineProp('ServerData',tkVariant,__GetTSimpleObjectBrokerServerData,__SetTSimpleObjectBrokerServerData,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatObjBrkrLibrary.LibraryName: string;
begin
  result := 'ObjBrkr';
end;

initialization
  RegisterScripterLibrary(TatObjBrkrLibrary, True);

{$WARNINGS ON}

end.

