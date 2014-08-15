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
unit ap_Psapi;

interface

uses
  Windows,
  Psapi,
  atScript;

{$WARNINGS OFF}

type
  TatPsapiLibrary = class(TatScripterLibrary)
    procedure __GetModuleBaseNameA(AMachine: TatVirtualMachine);
    procedure __GetModuleBaseNameW(AMachine: TatVirtualMachine);
    procedure __GetModuleBaseName(AMachine: TatVirtualMachine);
    procedure __GetModuleFileNameExA(AMachine: TatVirtualMachine);
    procedure __GetModuleFileNameExW(AMachine: TatVirtualMachine);
    procedure __GetModuleFileNameEx(AMachine: TatVirtualMachine);
    procedure __EmptyWorkingSet(AMachine: TatVirtualMachine);
    procedure __InitializeProcessForWsWatch(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _MODULEINFOWrapper = class(TatRecordWrapper)
  private
    FSizeOfImage: DWORD;
  public
    constructor Create(ARecord: _MODULEINFO);
    function ObjToRec: _MODULEINFO;
  published
    property SizeOfImage: DWORD read FSizeOfImage write FSizeOfImage;
  end;
  
  _PSAPI_WS_WATCH_INFORMATIONWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _PSAPI_WS_WATCH_INFORMATION);
    function ObjToRec: _PSAPI_WS_WATCH_INFORMATION;
  published
  end;
  
  _PROCESS_MEMORY_COUNTERSWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FPageFaultCount: DWORD;
    FPeakWorkingSetSize: DWORD;
    FWorkingSetSize: DWORD;
    FQuotaPeakPagedPoolUsage: DWORD;
    FQuotaPagedPoolUsage: DWORD;
    FQuotaPeakNonPagedPoolUsage: DWORD;
    FQuotaNonPagedPoolUsage: DWORD;
    FPagefileUsage: DWORD;
    FPeakPagefileUsage: DWORD;
  public
    constructor Create(ARecord: _PROCESS_MEMORY_COUNTERS);
    function ObjToRec: _PROCESS_MEMORY_COUNTERS;
  published
    property cb: DWORD read Fcb write Fcb;
    property PageFaultCount: DWORD read FPageFaultCount write FPageFaultCount;
    property PeakWorkingSetSize: DWORD read FPeakWorkingSetSize write FPeakWorkingSetSize;
    property WorkingSetSize: DWORD read FWorkingSetSize write FWorkingSetSize;
    property QuotaPeakPagedPoolUsage: DWORD read FQuotaPeakPagedPoolUsage write FQuotaPeakPagedPoolUsage;
    property QuotaPagedPoolUsage: DWORD read FQuotaPagedPoolUsage write FQuotaPagedPoolUsage;
    property QuotaPeakNonPagedPoolUsage: DWORD read FQuotaPeakNonPagedPoolUsage write FQuotaPeakNonPagedPoolUsage;
    property QuotaNonPagedPoolUsage: DWORD read FQuotaNonPagedPoolUsage write FQuotaNonPagedPoolUsage;
    property PagefileUsage: DWORD read FPagefileUsage write FPagefileUsage;
    property PeakPagefileUsage: DWORD read FPeakPagefileUsage write FPeakPagefileUsage;
  end;
  

implementation

constructor _MODULEINFOWrapper.Create(ARecord: _MODULEINFO);
begin
  inherited Create;
  FSizeOfImage := ARecord.SizeOfImage;
end;

function _MODULEINFOWrapper.ObjToRec: _MODULEINFO;
begin
  result.SizeOfImage := FSizeOfImage;
end;

constructor _PSAPI_WS_WATCH_INFORMATIONWrapper.Create(ARecord: _PSAPI_WS_WATCH_INFORMATION);
begin
  inherited Create;
end;

function _PSAPI_WS_WATCH_INFORMATIONWrapper.ObjToRec: _PSAPI_WS_WATCH_INFORMATION;
begin
end;

constructor _PROCESS_MEMORY_COUNTERSWrapper.Create(ARecord: _PROCESS_MEMORY_COUNTERS);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FPageFaultCount := ARecord.PageFaultCount;
  FPeakWorkingSetSize := ARecord.PeakWorkingSetSize;
  FWorkingSetSize := ARecord.WorkingSetSize;
  FQuotaPeakPagedPoolUsage := ARecord.QuotaPeakPagedPoolUsage;
  FQuotaPagedPoolUsage := ARecord.QuotaPagedPoolUsage;
  FQuotaPeakNonPagedPoolUsage := ARecord.QuotaPeakNonPagedPoolUsage;
  FQuotaNonPagedPoolUsage := ARecord.QuotaNonPagedPoolUsage;
  FPagefileUsage := ARecord.PagefileUsage;
  FPeakPagefileUsage := ARecord.PeakPagefileUsage;
end;

function _PROCESS_MEMORY_COUNTERSWrapper.ObjToRec: _PROCESS_MEMORY_COUNTERS;
begin
  result.cb := Fcb;
  result.PageFaultCount := FPageFaultCount;
  result.PeakWorkingSetSize := FPeakWorkingSetSize;
  result.WorkingSetSize := FWorkingSetSize;
  result.QuotaPeakPagedPoolUsage := FQuotaPeakPagedPoolUsage;
  result.QuotaPagedPoolUsage := FQuotaPagedPoolUsage;
  result.QuotaPeakNonPagedPoolUsage := FQuotaPeakNonPagedPoolUsage;
  result.QuotaNonPagedPoolUsage := FQuotaNonPagedPoolUsage;
  result.PagefileUsage := FPagefileUsage;
  result.PeakPagefileUsage := FPeakPagefileUsage;
end;



procedure TatPsapiLibrary.__GetModuleBaseNameA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Psapi.GetModuleBaseNameA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__GetModuleBaseNameW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Psapi.GetModuleBaseNameW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__GetModuleBaseName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Psapi.GetModuleBaseName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__GetModuleFileNameExA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Psapi.GetModuleFileNameExA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__GetModuleFileNameExW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Psapi.GetModuleFileNameExW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__GetModuleFileNameEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Psapi.GetModuleFileNameEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__EmptyWorkingSet(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Psapi.EmptyWorkingSet(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.__InitializeProcessForWsWatch(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Psapi.InitializeProcessForWsWatch(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPsapiLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetModuleBaseNameA',4,tkInteger,nil,__GetModuleBaseNameA,false,0);
    DefineMethod('GetModuleBaseNameW',4,tkInteger,nil,__GetModuleBaseNameW,false,0);
    DefineMethod('GetModuleBaseName',4,tkInteger,nil,__GetModuleBaseName,false,0);
    DefineMethod('GetModuleFileNameExA',4,tkInteger,nil,__GetModuleFileNameExA,false,0);
    DefineMethod('GetModuleFileNameExW',4,tkInteger,nil,__GetModuleFileNameExW,false,0);
    DefineMethod('GetModuleFileNameEx',4,tkInteger,nil,__GetModuleFileNameEx,false,0);
    DefineMethod('EmptyWorkingSet',1,tkVariant,nil,__EmptyWorkingSet,false,0);
    DefineMethod('InitializeProcessForWsWatch',1,tkVariant,nil,__InitializeProcessForWsWatch,false,0);
  end;
end;

class function TatPsapiLibrary.LibraryName: string;
begin
  result := 'Psapi';
end;

initialization
  RegisterScripterLibrary(TatPsapiLibrary, True);

{$WARNINGS ON}

end.

