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
unit ap_ShareMem;

interface

uses
  ShareMem,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatShareMemLibrary = class(TatScripterLibrary)
    procedure __GetHeapStatus(AMachine: TatVirtualMachine);
    procedure __GetAllocMemCount(AMachine: TatVirtualMachine);
    procedure __GetAllocMemSize(AMachine: TatVirtualMachine);
    procedure __DumpBlocks(AMachine: TatVirtualMachine);
    procedure __HeapAddRef(AMachine: TatVirtualMachine);
    procedure __HeapRelease(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatShareMemLibrary.__GetHeapStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(THeapStatusWrapper.Create(ShareMem.GetHeapStatus));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShareMemLibrary.__GetAllocMemCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShareMem.GetAllocMemCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShareMemLibrary.__GetAllocMemSize(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShareMem.GetAllocMemSize);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShareMemLibrary.__DumpBlocks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShareMem.DumpBlocks;
  end;
end;

procedure TatShareMemLibrary.__HeapAddRef(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShareMem.HeapAddRef;
  end;
end;

procedure TatShareMemLibrary.__HeapRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShareMem.HeapRelease;
  end;
end;

procedure TatShareMemLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetHeapStatus',0,tkVariant,nil,__GetHeapStatus,false,0);
    DefineMethod('GetAllocMemCount',0,tkInteger,nil,__GetAllocMemCount,false,0);
    DefineMethod('GetAllocMemSize',0,tkInteger,nil,__GetAllocMemSize,false,0);
    DefineMethod('DumpBlocks',0,tkNone,nil,__DumpBlocks,false,0);
    DefineMethod('HeapAddRef',0,tkNone,nil,__HeapAddRef,false,0);
    DefineMethod('HeapRelease',0,tkNone,nil,__HeapRelease,false,0);
  end;
end;

class function TatShareMemLibrary.LibraryName: string;
begin
  result := 'ShareMem';
end;

initialization
  RegisterScripterLibrary(TatShareMemLibrary, True);

{$WARNINGS ON}

end.

