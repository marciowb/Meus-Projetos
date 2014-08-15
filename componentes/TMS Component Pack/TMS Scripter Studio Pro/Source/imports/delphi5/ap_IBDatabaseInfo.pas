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
unit ap_IBDatabaseInfo;

interface

uses
  SysUtils,
  Classes,
  IBHeader,
  IBExternals,
  IB,
  IBDatabase,
  IBDatabaseInfo,
  atScript;

{$WARNINGS OFF}

type
  TatIBDatabaseInfoLibrary = class(TatScripterLibrary)
    procedure __TIBDatabaseInfoCreate(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseInfoDestroy(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseInfoCall(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseInfoGetLongDatabaseInfo(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoAllocation(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoBaseLevel(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoDBFileName(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoDBSiteName(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoDBImplementationNo(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoDBImplementationClass(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoNoReserve(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoODSMinorVersion(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoODSMajorVersion(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoPageSize(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoVersion(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoCurrentMemory(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoForcedWrites(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoMaxMemory(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoNumBuffers(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoSweepInterval(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoUserNames(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoFetches(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoMarks(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoReads(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoWrites(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoBackoutCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoDeleteCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoExpungeCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoInsertCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoPurgeCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoReadIdxCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoReadSeqCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoUpdateCount(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoDBSQLDialect(AMachine: TatVirtualMachine);
    procedure __GetTIBDatabaseInfoReadOnly(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBDatabaseInfoClass = class of TIBDatabaseInfo;



implementation



procedure TatIBDatabaseInfoLibrary.__TIBDatabaseInfoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabaseInfoClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseInfoLibrary.__TIBDatabaseInfoDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabaseInfo(CurrentObject).Destroy;
  end;
end;

procedure TatIBDatabaseInfoLibrary.__TIBDatabaseInfoCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabaseInfo(CurrentObject).Call(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseInfoLibrary.__TIBDatabaseInfoGetLongDatabaseInfo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabaseInfo(CurrentObject).GetLongDatabaseInfo(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoAllocation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).Allocation));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoBaseLevel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).BaseLevel));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoDBFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDatabaseInfo(CurrentObject).DBFileName);
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoDBSiteName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDatabaseInfo(CurrentObject).DBSiteName);
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoDBImplementationNo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).DBImplementationNo));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoDBImplementationClass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).DBImplementationClass));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoNoReserve(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).NoReserve));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoODSMinorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ODSMinorVersion));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoODSMajorVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ODSMajorVersion));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoPageSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).PageSize));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBDatabaseInfo(CurrentObject).Version);
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoCurrentMemory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).CurrentMemory));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoForcedWrites(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ForcedWrites));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoMaxMemory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).MaxMemory));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoNumBuffers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).NumBuffers));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoSweepInterval(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).SweepInterval));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoUserNames(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).UserNames));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoFetches(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).Fetches));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoMarks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).Marks));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoReads(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).Reads));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoWrites(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).Writes));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoBackoutCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).BackoutCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoDeleteCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).DeleteCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoExpungeCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ExpungeCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoInsertCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).InsertCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoPurgeCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).PurgeCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoReadIdxCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ReadIdxCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoReadSeqCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ReadSeqCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoUpdateCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).UpdateCount));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoDBSQLDialect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).DBSQLDialect));
  end;
end;

procedure TatIBDatabaseInfoLibrary.__GetTIBDatabaseInfoReadOnly(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBDatabaseInfo(CurrentObject).ReadOnly));
  end;
end;

procedure TatIBDatabaseInfoLibrary.Init;
begin
  With Scripter.DefineClass(TIBDatabaseInfo) do
  begin
    DefineMethod('Create',1,tkClass,TIBDatabaseInfo,__TIBDatabaseInfoCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBDatabaseInfoDestroy,false,0);
    DefineMethod('Call',2,tkInteger,nil,__TIBDatabaseInfoCall,false,0);
    DefineMethod('GetLongDatabaseInfo',1,tkInteger,nil,__TIBDatabaseInfoGetLongDatabaseInfo,false,0);
    DefineProp('Allocation',tkInteger,__GetTIBDatabaseInfoAllocation,nil,nil,false,0);
    DefineProp('BaseLevel',tkInteger,__GetTIBDatabaseInfoBaseLevel,nil,nil,false,0);
    DefineProp('DBFileName',tkVariant,__GetTIBDatabaseInfoDBFileName,nil,nil,false,0);
    DefineProp('DBSiteName',tkVariant,__GetTIBDatabaseInfoDBSiteName,nil,nil,false,0);
    DefineProp('DBImplementationNo',tkInteger,__GetTIBDatabaseInfoDBImplementationNo,nil,nil,false,0);
    DefineProp('DBImplementationClass',tkInteger,__GetTIBDatabaseInfoDBImplementationClass,nil,nil,false,0);
    DefineProp('NoReserve',tkInteger,__GetTIBDatabaseInfoNoReserve,nil,nil,false,0);
    DefineProp('ODSMinorVersion',tkInteger,__GetTIBDatabaseInfoODSMinorVersion,nil,nil,false,0);
    DefineProp('ODSMajorVersion',tkInteger,__GetTIBDatabaseInfoODSMajorVersion,nil,nil,false,0);
    DefineProp('PageSize',tkInteger,__GetTIBDatabaseInfoPageSize,nil,nil,false,0);
    DefineProp('Version',tkVariant,__GetTIBDatabaseInfoVersion,nil,nil,false,0);
    DefineProp('CurrentMemory',tkInteger,__GetTIBDatabaseInfoCurrentMemory,nil,nil,false,0);
    DefineProp('ForcedWrites',tkInteger,__GetTIBDatabaseInfoForcedWrites,nil,nil,false,0);
    DefineProp('MaxMemory',tkInteger,__GetTIBDatabaseInfoMaxMemory,nil,nil,false,0);
    DefineProp('NumBuffers',tkInteger,__GetTIBDatabaseInfoNumBuffers,nil,nil,false,0);
    DefineProp('SweepInterval',tkInteger,__GetTIBDatabaseInfoSweepInterval,nil,nil,false,0);
    DefineProp('UserNames',tkClass,__GetTIBDatabaseInfoUserNames,nil,TStringList,false,0);
    DefineProp('Fetches',tkInteger,__GetTIBDatabaseInfoFetches,nil,nil,false,0);
    DefineProp('Marks',tkInteger,__GetTIBDatabaseInfoMarks,nil,nil,false,0);
    DefineProp('Reads',tkInteger,__GetTIBDatabaseInfoReads,nil,nil,false,0);
    DefineProp('Writes',tkInteger,__GetTIBDatabaseInfoWrites,nil,nil,false,0);
    DefineProp('BackoutCount',tkClass,__GetTIBDatabaseInfoBackoutCount,nil,TStringList,false,0);
    DefineProp('DeleteCount',tkClass,__GetTIBDatabaseInfoDeleteCount,nil,TStringList,false,0);
    DefineProp('ExpungeCount',tkClass,__GetTIBDatabaseInfoExpungeCount,nil,TStringList,false,0);
    DefineProp('InsertCount',tkClass,__GetTIBDatabaseInfoInsertCount,nil,TStringList,false,0);
    DefineProp('PurgeCount',tkClass,__GetTIBDatabaseInfoPurgeCount,nil,TStringList,false,0);
    DefineProp('ReadIdxCount',tkClass,__GetTIBDatabaseInfoReadIdxCount,nil,TStringList,false,0);
    DefineProp('ReadSeqCount',tkClass,__GetTIBDatabaseInfoReadSeqCount,nil,TStringList,false,0);
    DefineProp('UpdateCount',tkClass,__GetTIBDatabaseInfoUpdateCount,nil,TStringList,false,0);
    DefineProp('DBSQLDialect',tkInteger,__GetTIBDatabaseInfoDBSQLDialect,nil,nil,false,0);
    DefineProp('ReadOnly',tkInteger,__GetTIBDatabaseInfoReadOnly,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBDatabaseInfoLibrary.LibraryName: string;
begin
  result := 'IBDatabaseInfo';
end;

initialization
  RegisterScripterLibrary(TatIBDatabaseInfoLibrary, True);

{$WARNINGS ON}

end.

