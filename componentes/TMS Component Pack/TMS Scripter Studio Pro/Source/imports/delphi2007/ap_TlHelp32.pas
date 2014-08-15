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
unit ap_TlHelp32;

interface

uses
  Windows,
  TlHelp32,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatTlHelp32Library = class(TatScripterLibrary)
    procedure __CreateToolhelp32Snapshot(AMachine: TatVirtualMachine);
    procedure __Heap32ListFirst(AMachine: TatVirtualMachine);
    procedure __Heap32ListNext(AMachine: TatVirtualMachine);
    procedure __Heap32First(AMachine: TatVirtualMachine);
    procedure __Heap32Next(AMachine: TatVirtualMachine);
    procedure __Process32FirstW(AMachine: TatVirtualMachine);
    procedure __Process32NextW(AMachine: TatVirtualMachine);
    procedure __Process32First(AMachine: TatVirtualMachine);
    procedure __Process32Next(AMachine: TatVirtualMachine);
    procedure __Thread32First(AMachine: TatVirtualMachine);
    procedure __Thread32Next(AMachine: TatVirtualMachine);
    procedure __Module32First(AMachine: TatVirtualMachine);
    procedure __Module32Next(AMachine: TatVirtualMachine);
    procedure __Module32FirstW(AMachine: TatVirtualMachine);
    procedure __Module32NextW(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagHEAPLIST32Wrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    Fth32ProcessID: DWORD;
    Fth32HeapID: DWORD;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagHEAPLIST32);
    function ObjToRec: tagHEAPLIST32;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property th32ProcessID: DWORD read Fth32ProcessID write Fth32ProcessID;
    property th32HeapID: DWORD read Fth32HeapID write Fth32HeapID;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagHEAPENTRY32Wrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FhHandle: THandle;
    FdwAddress: DWORD;
    FdwBlockSize: DWORD;
    FdwFlags: DWORD;
    FdwLockCount: DWORD;
    FdwResvd: DWORD;
    Fth32ProcessID: DWORD;
    Fth32HeapID: DWORD;
  public
    constructor Create(ARecord: tagHEAPENTRY32);
    function ObjToRec: tagHEAPENTRY32;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property hHandle: THandle read FhHandle write FhHandle;
    property dwAddress: DWORD read FdwAddress write FdwAddress;
    property dwBlockSize: DWORD read FdwBlockSize write FdwBlockSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwLockCount: DWORD read FdwLockCount write FdwLockCount;
    property dwResvd: DWORD read FdwResvd write FdwResvd;
    property th32ProcessID: DWORD read Fth32ProcessID write Fth32ProcessID;
    property th32HeapID: DWORD read Fth32HeapID write Fth32HeapID;
  end;
  
  tagPROCESSENTRY32WWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FcntUsage: DWORD;
    Fth32ProcessID: DWORD;
    Fth32DefaultHeapID: DWORD;
    Fth32ModuleID: DWORD;
    FcntThreads: DWORD;
    Fth32ParentProcessID: DWORD;
    FpcPriClassBase: Longint;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagPROCESSENTRY32W);
    function ObjToRec: tagPROCESSENTRY32W;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property cntUsage: DWORD read FcntUsage write FcntUsage;
    property th32ProcessID: DWORD read Fth32ProcessID write Fth32ProcessID;
    property th32DefaultHeapID: DWORD read Fth32DefaultHeapID write Fth32DefaultHeapID;
    property th32ModuleID: DWORD read Fth32ModuleID write Fth32ModuleID;
    property cntThreads: DWORD read FcntThreads write FcntThreads;
    property th32ParentProcessID: DWORD read Fth32ParentProcessID write Fth32ParentProcessID;
    property pcPriClassBase: Longint read FpcPriClassBase write FpcPriClassBase;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagPROCESSENTRY32Wrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FcntUsage: DWORD;
    Fth32ProcessID: DWORD;
    Fth32DefaultHeapID: DWORD;
    Fth32ModuleID: DWORD;
    FcntThreads: DWORD;
    Fth32ParentProcessID: DWORD;
    FpcPriClassBase: Longint;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagPROCESSENTRY32);
    function ObjToRec: tagPROCESSENTRY32;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property cntUsage: DWORD read FcntUsage write FcntUsage;
    property th32ProcessID: DWORD read Fth32ProcessID write Fth32ProcessID;
    property th32DefaultHeapID: DWORD read Fth32DefaultHeapID write Fth32DefaultHeapID;
    property th32ModuleID: DWORD read Fth32ModuleID write Fth32ModuleID;
    property cntThreads: DWORD read FcntThreads write FcntThreads;
    property th32ParentProcessID: DWORD read Fth32ParentProcessID write Fth32ParentProcessID;
    property pcPriClassBase: Longint read FpcPriClassBase write FpcPriClassBase;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagTHREADENTRY32Wrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FcntUsage: DWORD;
    Fth32ThreadID: DWORD;
    Fth32OwnerProcessID: DWORD;
    FtpBasePri: Longint;
    FtpDeltaPri: Longint;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagTHREADENTRY32);
    function ObjToRec: tagTHREADENTRY32;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property cntUsage: DWORD read FcntUsage write FcntUsage;
    property th32ThreadID: DWORD read Fth32ThreadID write Fth32ThreadID;
    property th32OwnerProcessID: DWORD read Fth32OwnerProcessID write Fth32OwnerProcessID;
    property tpBasePri: Longint read FtpBasePri write FtpBasePri;
    property tpDeltaPri: Longint read FtpDeltaPri write FtpDeltaPri;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagMODULEENTRY32Wrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    Fth32ModuleID: DWORD;
    Fth32ProcessID: DWORD;
    FGlblcntUsage: DWORD;
    FProccntUsage: DWORD;
    FmodBaseSize: DWORD;
    FhModule: HMODULE;
  public
    constructor Create(ARecord: tagMODULEENTRY32);
    function ObjToRec: tagMODULEENTRY32;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property th32ModuleID: DWORD read Fth32ModuleID write Fth32ModuleID;
    property th32ProcessID: DWORD read Fth32ProcessID write Fth32ProcessID;
    property GlblcntUsage: DWORD read FGlblcntUsage write FGlblcntUsage;
    property ProccntUsage: DWORD read FProccntUsage write FProccntUsage;
    property modBaseSize: DWORD read FmodBaseSize write FmodBaseSize;
    property hModule: HMODULE read FhModule write FhModule;
  end;
  
  tagMODULEENTRY32WWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    Fth32ModuleID: DWORD;
    Fth32ProcessID: DWORD;
    FGlblcntUsage: DWORD;
    FProccntUsage: DWORD;
    FmodBaseSize: DWORD;
    FhModule: HMODULE;
  public
    constructor Create(ARecord: tagMODULEENTRY32W);
    function ObjToRec: tagMODULEENTRY32W;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property th32ModuleID: DWORD read Fth32ModuleID write Fth32ModuleID;
    property th32ProcessID: DWORD read Fth32ProcessID write Fth32ProcessID;
    property GlblcntUsage: DWORD read FGlblcntUsage write FGlblcntUsage;
    property ProccntUsage: DWORD read FProccntUsage write FProccntUsage;
    property modBaseSize: DWORD read FmodBaseSize write FmodBaseSize;
    property hModule: HMODULE read FhModule write FhModule;
  end;
  

implementation

constructor tagHEAPLIST32Wrapper.Create(ARecord: tagHEAPLIST32);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  Fth32ProcessID := ARecord.th32ProcessID;
  Fth32HeapID := ARecord.th32HeapID;
  FdwFlags := ARecord.dwFlags;
end;

function tagHEAPLIST32Wrapper.ObjToRec: tagHEAPLIST32;
begin
  result.dwSize := FdwSize;
  result.th32ProcessID := Fth32ProcessID;
  result.th32HeapID := Fth32HeapID;
  result.dwFlags := FdwFlags;
end;

constructor tagHEAPENTRY32Wrapper.Create(ARecord: tagHEAPENTRY32);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FhHandle := ARecord.hHandle;
  FdwAddress := ARecord.dwAddress;
  FdwBlockSize := ARecord.dwBlockSize;
  FdwFlags := ARecord.dwFlags;
  FdwLockCount := ARecord.dwLockCount;
  FdwResvd := ARecord.dwResvd;
  Fth32ProcessID := ARecord.th32ProcessID;
  Fth32HeapID := ARecord.th32HeapID;
end;

function tagHEAPENTRY32Wrapper.ObjToRec: tagHEAPENTRY32;
begin
  result.dwSize := FdwSize;
  result.hHandle := FhHandle;
  result.dwAddress := FdwAddress;
  result.dwBlockSize := FdwBlockSize;
  result.dwFlags := FdwFlags;
  result.dwLockCount := FdwLockCount;
  result.dwResvd := FdwResvd;
  result.th32ProcessID := Fth32ProcessID;
  result.th32HeapID := Fth32HeapID;
end;

constructor tagPROCESSENTRY32WWrapper.Create(ARecord: tagPROCESSENTRY32W);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FcntUsage := ARecord.cntUsage;
  Fth32ProcessID := ARecord.th32ProcessID;
  Fth32DefaultHeapID := ARecord.th32DefaultHeapID;
  Fth32ModuleID := ARecord.th32ModuleID;
  FcntThreads := ARecord.cntThreads;
  Fth32ParentProcessID := ARecord.th32ParentProcessID;
  FpcPriClassBase := ARecord.pcPriClassBase;
  FdwFlags := ARecord.dwFlags;
end;

function tagPROCESSENTRY32WWrapper.ObjToRec: tagPROCESSENTRY32W;
begin
  result.dwSize := FdwSize;
  result.cntUsage := FcntUsage;
  result.th32ProcessID := Fth32ProcessID;
  result.th32DefaultHeapID := Fth32DefaultHeapID;
  result.th32ModuleID := Fth32ModuleID;
  result.cntThreads := FcntThreads;
  result.th32ParentProcessID := Fth32ParentProcessID;
  result.pcPriClassBase := FpcPriClassBase;
  result.dwFlags := FdwFlags;
end;

constructor tagPROCESSENTRY32Wrapper.Create(ARecord: tagPROCESSENTRY32);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FcntUsage := ARecord.cntUsage;
  Fth32ProcessID := ARecord.th32ProcessID;
  Fth32DefaultHeapID := ARecord.th32DefaultHeapID;
  Fth32ModuleID := ARecord.th32ModuleID;
  FcntThreads := ARecord.cntThreads;
  Fth32ParentProcessID := ARecord.th32ParentProcessID;
  FpcPriClassBase := ARecord.pcPriClassBase;
  FdwFlags := ARecord.dwFlags;
end;

function tagPROCESSENTRY32Wrapper.ObjToRec: tagPROCESSENTRY32;
begin
  result.dwSize := FdwSize;
  result.cntUsage := FcntUsage;
  result.th32ProcessID := Fth32ProcessID;
  result.th32DefaultHeapID := Fth32DefaultHeapID;
  result.th32ModuleID := Fth32ModuleID;
  result.cntThreads := FcntThreads;
  result.th32ParentProcessID := Fth32ParentProcessID;
  result.pcPriClassBase := FpcPriClassBase;
  result.dwFlags := FdwFlags;
end;

constructor tagTHREADENTRY32Wrapper.Create(ARecord: tagTHREADENTRY32);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FcntUsage := ARecord.cntUsage;
  Fth32ThreadID := ARecord.th32ThreadID;
  Fth32OwnerProcessID := ARecord.th32OwnerProcessID;
  FtpBasePri := ARecord.tpBasePri;
  FtpDeltaPri := ARecord.tpDeltaPri;
  FdwFlags := ARecord.dwFlags;
end;

function tagTHREADENTRY32Wrapper.ObjToRec: tagTHREADENTRY32;
begin
  result.dwSize := FdwSize;
  result.cntUsage := FcntUsage;
  result.th32ThreadID := Fth32ThreadID;
  result.th32OwnerProcessID := Fth32OwnerProcessID;
  result.tpBasePri := FtpBasePri;
  result.tpDeltaPri := FtpDeltaPri;
  result.dwFlags := FdwFlags;
end;

constructor tagMODULEENTRY32Wrapper.Create(ARecord: tagMODULEENTRY32);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  Fth32ModuleID := ARecord.th32ModuleID;
  Fth32ProcessID := ARecord.th32ProcessID;
  FGlblcntUsage := ARecord.GlblcntUsage;
  FProccntUsage := ARecord.ProccntUsage;
  FmodBaseSize := ARecord.modBaseSize;
  FhModule := ARecord.hModule;
end;

function tagMODULEENTRY32Wrapper.ObjToRec: tagMODULEENTRY32;
begin
  result.dwSize := FdwSize;
  result.th32ModuleID := Fth32ModuleID;
  result.th32ProcessID := Fth32ProcessID;
  result.GlblcntUsage := FGlblcntUsage;
  result.ProccntUsage := FProccntUsage;
  result.modBaseSize := FmodBaseSize;
  result.hModule := FhModule;
end;

constructor tagMODULEENTRY32WWrapper.Create(ARecord: tagMODULEENTRY32W);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  Fth32ModuleID := ARecord.th32ModuleID;
  Fth32ProcessID := ARecord.th32ProcessID;
  FGlblcntUsage := ARecord.GlblcntUsage;
  FProccntUsage := ARecord.ProccntUsage;
  FmodBaseSize := ARecord.modBaseSize;
  FhModule := ARecord.hModule;
end;

function tagMODULEENTRY32WWrapper.ObjToRec: tagMODULEENTRY32W;
begin
  result.dwSize := FdwSize;
  result.th32ModuleID := Fth32ModuleID;
  result.th32ProcessID := Fth32ProcessID;
  result.GlblcntUsage := FGlblcntUsage;
  result.ProccntUsage := FProccntUsage;
  result.modBaseSize := FmodBaseSize;
  result.hModule := FhModule;
end;



procedure TatTlHelp32Library.__CreateToolhelp32Snapshot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TlHelp32.CreateToolhelp32Snapshot(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTlHelp32Library.__Heap32ListFirst(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: THeapList32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagHEAPLIST32Wrapper) then 
  Param1Rec := tagHEAPLIST32Wrapper.Create(Param1);
Param1 := tagHEAPLIST32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Heap32ListFirst(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagHEAPLIST32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Heap32ListNext(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: THeapList32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagHEAPLIST32Wrapper) then 
  Param1Rec := tagHEAPLIST32Wrapper.Create(Param1);
Param1 := tagHEAPLIST32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Heap32ListNext(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagHEAPLIST32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Heap32First(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: THeapEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagHEAPENTRY32Wrapper) then 
  Param0Rec := tagHEAPENTRY32Wrapper.Create(Param0);
Param0 := tagHEAPENTRY32Wrapper(Param0Rec).ObjToRec;
AResult := TlHelp32.Heap32First(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagHEAPENTRY32Wrapper.Create(Param0)));
  end;
end;

procedure TatTlHelp32Library.__Heap32Next(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: THeapEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagHEAPENTRY32Wrapper) then 
  Param0Rec := tagHEAPENTRY32Wrapper.Create(Param0);
Param0 := tagHEAPENTRY32Wrapper(Param0Rec).ObjToRec;
AResult := TlHelp32.Heap32Next(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagHEAPENTRY32Wrapper.Create(Param0)));
  end;
end;

procedure TatTlHelp32Library.__Process32FirstW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TProcessEntry32W;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagPROCESSENTRY32WWrapper) then 
  Param1Rec := tagPROCESSENTRY32WWrapper.Create(Param1);
Param1 := tagPROCESSENTRY32WWrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Process32FirstW(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagPROCESSENTRY32WWrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Process32NextW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TProcessEntry32W;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagPROCESSENTRY32WWrapper) then 
  Param1Rec := tagPROCESSENTRY32WWrapper.Create(Param1);
Param1 := tagPROCESSENTRY32WWrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Process32NextW(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagPROCESSENTRY32WWrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Process32First(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TProcessEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagPROCESSENTRY32Wrapper) then 
  Param1Rec := tagPROCESSENTRY32Wrapper.Create(Param1);
Param1 := tagPROCESSENTRY32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Process32First(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagPROCESSENTRY32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Process32Next(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TProcessEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagPROCESSENTRY32Wrapper) then 
  Param1Rec := tagPROCESSENTRY32Wrapper.Create(Param1);
Param1 := tagPROCESSENTRY32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Process32Next(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagPROCESSENTRY32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Thread32First(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TThreadEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagTHREADENTRY32Wrapper) then 
  Param1Rec := tagTHREADENTRY32Wrapper.Create(Param1);
Param1 := tagTHREADENTRY32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Thread32First(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagTHREADENTRY32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Thread32Next(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TThreadENtry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagTHREADENTRY32Wrapper) then 
  Param1Rec := tagTHREADENTRY32Wrapper.Create(Param1);
Param1 := tagTHREADENTRY32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Thread32Next(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagTHREADENTRY32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Module32First(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TModuleEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagMODULEENTRY32Wrapper) then 
  Param1Rec := tagMODULEENTRY32Wrapper.Create(Param1);
Param1 := tagMODULEENTRY32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Module32First(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagMODULEENTRY32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Module32Next(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TModuleEntry32;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagMODULEENTRY32Wrapper) then 
  Param1Rec := tagMODULEENTRY32Wrapper.Create(Param1);
Param1 := tagMODULEENTRY32Wrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Module32Next(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagMODULEENTRY32Wrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Module32FirstW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TModuleEntry32W;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagMODULEENTRY32WWrapper) then 
  Param1Rec := tagMODULEENTRY32WWrapper.Create(Param1);
Param1 := tagMODULEENTRY32WWrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Module32FirstW(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagMODULEENTRY32WWrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.__Module32NextW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TModuleEntry32W;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagMODULEENTRY32WWrapper) then 
  Param1Rec := tagMODULEENTRY32WWrapper.Create(Param1);
Param1 := tagMODULEENTRY32WWrapper(Param1Rec).ObjToRec;
AResult := TlHelp32.Module32NextW(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagMODULEENTRY32WWrapper.Create(Param1)));
  end;
end;

procedure TatTlHelp32Library.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CreateToolhelp32Snapshot',2,tkInteger,nil,__CreateToolhelp32Snapshot,false,0);
    DefineMethod('Heap32ListFirst',2,tkVariant,nil,__Heap32ListFirst,false,0).SetVarArgs([1]);
    DefineMethod('Heap32ListNext',2,tkVariant,nil,__Heap32ListNext,false,0).SetVarArgs([1]);
    DefineMethod('Heap32First',3,tkVariant,nil,__Heap32First,false,0).SetVarArgs([0]);
    DefineMethod('Heap32Next',1,tkVariant,nil,__Heap32Next,false,0).SetVarArgs([0]);
    DefineMethod('Process32FirstW',2,tkVariant,nil,__Process32FirstW,false,0).SetVarArgs([1]);
    DefineMethod('Process32NextW',2,tkVariant,nil,__Process32NextW,false,0).SetVarArgs([1]);
    DefineMethod('Process32First',2,tkVariant,nil,__Process32First,false,0).SetVarArgs([1]);
    DefineMethod('Process32Next',2,tkVariant,nil,__Process32Next,false,0).SetVarArgs([1]);
    DefineMethod('Thread32First',2,tkVariant,nil,__Thread32First,false,0).SetVarArgs([1]);
    DefineMethod('Thread32Next',2,tkVariant,nil,__Thread32Next,false,0).SetVarArgs([1]);
    DefineMethod('Module32First',2,tkVariant,nil,__Module32First,false,0).SetVarArgs([1]);
    DefineMethod('Module32Next',2,tkVariant,nil,__Module32Next,false,0).SetVarArgs([1]);
    DefineMethod('Module32FirstW',2,tkVariant,nil,__Module32FirstW,false,0).SetVarArgs([1]);
    DefineMethod('Module32NextW',2,tkVariant,nil,__Module32NextW,false,0).SetVarArgs([1]);
    AddConstant('MAX_MODULE_NAME32',MAX_MODULE_NAME32);
    AddConstant('TH32CS_SNAPHEAPLIST',TH32CS_SNAPHEAPLIST);
    AddConstant('TH32CS_SNAPPROCESS',TH32CS_SNAPPROCESS);
    AddConstant('TH32CS_SNAPTHREAD',TH32CS_SNAPTHREAD);
    AddConstant('TH32CS_SNAPMODULE',TH32CS_SNAPMODULE);
    AddConstant('TH32CS_SNAPALL',TH32CS_SNAPALL);
    AddConstant('TH32CS_INHERIT',TH32CS_INHERIT);
    AddConstant('HF32_DEFAULT',HF32_DEFAULT);
    AddConstant('HF32_SHARED',HF32_SHARED);
    AddConstant('LF32_FIXED',LF32_FIXED);
    AddConstant('LF32_FREE',LF32_FREE);
    AddConstant('LF32_MOVEABLE',LF32_MOVEABLE);
  end;
end;

class function TatTlHelp32Library.LibraryName: string;
begin
  result := 'TlHelp32';
end;

initialization
  RegisterScripterLibrary(TatTlHelp32Library, True);

{$WARNINGS ON}

end.

