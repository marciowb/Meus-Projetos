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
unit ap_CorbaStd;

interface

uses
  Classes,
  ActiveX,
  Midas,
  Forms,
  CorbaObj,
  OrbPas,
  CorbaStd,
  Variants,
  atScript;

type
  TatCorbaStdLibrary = class(TatScripterLibrary)
    procedure __TAppServerStubAS_ApplyUpdates(AMachine: TatVirtualMachine);
    procedure __TAppServerStubAS_GetRecords(AMachine: TatVirtualMachine);
    procedure __TAppServerStubAS_DataRequest(AMachine: TatVirtualMachine);
    procedure __TAppServerStubAS_GetProviderNames(AMachine: TatVirtualMachine);
    procedure __TAppServerStubAS_GetParams(AMachine: TatVirtualMachine);
    procedure __TAppServerStubAS_RowRequest(AMachine: TatVirtualMachine);
    procedure __TAppServerStubAS_Execute(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TAppServerSkeletonClass = class of TAppServerSkeleton;
  TAppServerStubClass = class of TAppServerStub;



implementation

{$WARNINGS OFF}



procedure TatCorbaStdLibrary.__TAppServerStubAS_ApplyUpdates(AMachine: TatVirtualMachine);
  var
  Param3: Integer;
  Param4: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
Param4 := GetInputArg(4);
AResult := TAppServerStub(CurrentObject).AS_ApplyUpdates(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),Param3,Param4);
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatCorbaStdLibrary.__TAppServerStubAS_GetRecords(AMachine: TatVirtualMachine);
  var
  Param2: Integer;
  Param5: OleVariant;
  Param6: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param5 := GetInputArg(5);
Param6 := GetInputArg(6);
AResult := TAppServerStub(CurrentObject).AS_GetRecords(GetInputArg(0),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),GetInputArg(4),Param5,Param6);
    ReturnOutputArg(AResult);
    SetInputArg(5,Param5);
    SetInputArg(6,Param6);
  end;
end;

procedure TatCorbaStdLibrary.__TAppServerStubAS_DataRequest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TAppServerStub(CurrentObject).AS_DataRequest(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaStdLibrary.__TAppServerStubAS_GetProviderNames(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TAppServerStub(CurrentObject).AS_GetProviderNames;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorbaStdLibrary.__TAppServerStubAS_GetParams(AMachine: TatVirtualMachine);
  var
  Param1: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := TAppServerStub(CurrentObject).AS_GetParams(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatCorbaStdLibrary.__TAppServerStubAS_RowRequest(AMachine: TatVirtualMachine);
  var
  Param3: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := TAppServerStub(CurrentObject).AS_RowRequest(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatCorbaStdLibrary.__TAppServerStubAS_Execute(AMachine: TatVirtualMachine);
  var
  Param2: OleVariant;
  Param3: OleVariant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
Param3 := GetInputArg(3);
    TAppServerStub(CurrentObject).AS_Execute(GetInputArg(0),GetInputArg(1),Param2,Param3);
    SetInputArg(2,Param2);
    SetInputArg(3,Param3);
  end;
end;

procedure TatCorbaStdLibrary.Init;
begin
  With Scripter.DefineClass(TAppServerSkeleton) do
  begin
  end;
  With Scripter.DefineClass(TAppServerStub) do
  begin
    DefineMethod('AS_ApplyUpdates',5,tkVariant,nil,__TAppServerStubAS_ApplyUpdates,false).SetVarArgs([4]);
    DefineMethod('AS_GetRecords',7,tkVariant,nil,__TAppServerStubAS_GetRecords,false).SetVarArgs([5,6]);
    DefineMethod('AS_DataRequest',2,tkVariant,nil,__TAppServerStubAS_DataRequest,false);
    DefineMethod('AS_GetProviderNames',0,tkVariant,nil,__TAppServerStubAS_GetProviderNames,false);
    DefineMethod('AS_GetParams',2,tkVariant,nil,__TAppServerStubAS_GetParams,false).SetVarArgs([1]);
    DefineMethod('AS_RowRequest',4,tkVariant,nil,__TAppServerStubAS_RowRequest,false).SetVarArgs([3]);
    DefineMethod('AS_Execute',4,tkNone,nil,__TAppServerStubAS_Execute,false).SetVarArgs([2,3]);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatCorbaStdLibrary.LibraryName: string;
begin
  result := 'CorbaStd';
end;

initialization
  RegisterScripterLibrary(TatCorbaStdLibrary, True);

{$WARNINGS ON}

end.
