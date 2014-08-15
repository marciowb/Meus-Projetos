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
unit ap_WinSvc;

interface

uses
  Windows,
  WinSvc,
  atScript;

{$WARNINGS OFF}

type
  TatWinSvcLibrary = class(TatScripterLibrary)
    procedure __CloseServiceHandle(AMachine: TatVirtualMachine);
    procedure __ControlService(AMachine: TatVirtualMachine);
    procedure __DeleteService(AMachine: TatVirtualMachine);
    procedure __EnumDependentServicesA(AMachine: TatVirtualMachine);
    procedure __EnumDependentServicesW(AMachine: TatVirtualMachine);
    procedure __EnumDependentServices(AMachine: TatVirtualMachine);
    procedure __EnumServicesStatusA(AMachine: TatVirtualMachine);
    procedure __EnumServicesStatusW(AMachine: TatVirtualMachine);
    procedure __EnumServicesStatus(AMachine: TatVirtualMachine);
    procedure __GetServiceKeyNameA(AMachine: TatVirtualMachine);
    procedure __GetServiceKeyNameW(AMachine: TatVirtualMachine);
    procedure __GetServiceKeyName(AMachine: TatVirtualMachine);
    procedure __GetServiceDisplayNameA(AMachine: TatVirtualMachine);
    procedure __GetServiceDisplayNameW(AMachine: TatVirtualMachine);
    procedure __GetServiceDisplayName(AMachine: TatVirtualMachine);
    procedure __NotifyBootConfigStatus(AMachine: TatVirtualMachine);
    procedure __OpenSCManagerA(AMachine: TatVirtualMachine);
    procedure __OpenSCManagerW(AMachine: TatVirtualMachine);
    procedure __OpenSCManager(AMachine: TatVirtualMachine);
    procedure __OpenServiceA(AMachine: TatVirtualMachine);
    procedure __OpenServiceW(AMachine: TatVirtualMachine);
    procedure __OpenService(AMachine: TatVirtualMachine);
    procedure __QueryServiceLockStatusA(AMachine: TatVirtualMachine);
    procedure __QueryServiceLockStatusW(AMachine: TatVirtualMachine);
    procedure __QueryServiceLockStatus(AMachine: TatVirtualMachine);
    procedure __QueryServiceStatus(AMachine: TatVirtualMachine);
    procedure __SetServiceStatus(AMachine: TatVirtualMachine);
    procedure __StartServiceCtrlDispatcherA(AMachine: TatVirtualMachine);
    procedure __StartServiceCtrlDispatcherW(AMachine: TatVirtualMachine);
    procedure __StartServiceCtrlDispatcher(AMachine: TatVirtualMachine);
    procedure __StartServiceA(AMachine: TatVirtualMachine);
    procedure __StartServiceW(AMachine: TatVirtualMachine);
    procedure __StartService(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _SERVICE_STATUSWrapper = class(TatRecordWrapper)
  private
    FdwServiceType: DWORD;
    FdwCurrentState: DWORD;
    FdwControlsAccepted: DWORD;
    FdwWin32ExitCode: DWORD;
    FdwServiceSpecificExitCode: DWORD;
    FdwCheckPoint: DWORD;
    FdwWaitHint: DWORD;
  public
    constructor Create(ARecord: _SERVICE_STATUS);
    function ObjToRec: _SERVICE_STATUS;
  published
    property dwServiceType: DWORD read FdwServiceType write FdwServiceType;
    property dwCurrentState: DWORD read FdwCurrentState write FdwCurrentState;
    property dwControlsAccepted: DWORD read FdwControlsAccepted write FdwControlsAccepted;
    property dwWin32ExitCode: DWORD read FdwWin32ExitCode write FdwWin32ExitCode;
    property dwServiceSpecificExitCode: DWORD read FdwServiceSpecificExitCode write FdwServiceSpecificExitCode;
    property dwCheckPoint: DWORD read FdwCheckPoint write FdwCheckPoint;
    property dwWaitHint: DWORD read FdwWaitHint write FdwWaitHint;
  end;
  
  _ENUM_SERVICE_STATUSAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _ENUM_SERVICE_STATUSA);
    function ObjToRec: _ENUM_SERVICE_STATUSA;
  published
  end;
  
  _ENUM_SERVICE_STATUSWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _ENUM_SERVICE_STATUSW);
    function ObjToRec: _ENUM_SERVICE_STATUSW;
  published
  end;
  
  _QUERY_SERVICE_LOCK_STATUSAWrapper = class(TatRecordWrapper)
  private
    FfIsLocked: DWORD;
    FdwLockDuration: DWORD;
  public
    constructor Create(ARecord: _QUERY_SERVICE_LOCK_STATUSA);
    function ObjToRec: _QUERY_SERVICE_LOCK_STATUSA;
  published
    property fIsLocked: DWORD read FfIsLocked write FfIsLocked;
    property dwLockDuration: DWORD read FdwLockDuration write FdwLockDuration;
  end;
  
  _QUERY_SERVICE_LOCK_STATUSWWrapper = class(TatRecordWrapper)
  private
    FfIsLocked: DWORD;
    FdwLockDuration: DWORD;
  public
    constructor Create(ARecord: _QUERY_SERVICE_LOCK_STATUSW);
    function ObjToRec: _QUERY_SERVICE_LOCK_STATUSW;
  published
    property fIsLocked: DWORD read FfIsLocked write FfIsLocked;
    property dwLockDuration: DWORD read FdwLockDuration write FdwLockDuration;
  end;
  
  _QUERY_SERVICE_CONFIGAWrapper = class(TatRecordWrapper)
  private
    FdwServiceType: DWORD;
    FdwStartType: DWORD;
    FdwErrorControl: DWORD;
    FdwTagId: DWORD;
  public
    constructor Create(ARecord: _QUERY_SERVICE_CONFIGA);
    function ObjToRec: _QUERY_SERVICE_CONFIGA;
  published
    property dwServiceType: DWORD read FdwServiceType write FdwServiceType;
    property dwStartType: DWORD read FdwStartType write FdwStartType;
    property dwErrorControl: DWORD read FdwErrorControl write FdwErrorControl;
    property dwTagId: DWORD read FdwTagId write FdwTagId;
  end;
  
  _QUERY_SERVICE_CONFIGWWrapper = class(TatRecordWrapper)
  private
    FdwServiceType: DWORD;
    FdwStartType: DWORD;
    FdwErrorControl: DWORD;
    FdwTagId: DWORD;
  public
    constructor Create(ARecord: _QUERY_SERVICE_CONFIGW);
    function ObjToRec: _QUERY_SERVICE_CONFIGW;
  published
    property dwServiceType: DWORD read FdwServiceType write FdwServiceType;
    property dwStartType: DWORD read FdwStartType write FdwStartType;
    property dwErrorControl: DWORD read FdwErrorControl write FdwErrorControl;
    property dwTagId: DWORD read FdwTagId write FdwTagId;
  end;
  
  _SERVICE_TABLE_ENTRYAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _SERVICE_TABLE_ENTRYA);
    function ObjToRec: _SERVICE_TABLE_ENTRYA;
  published
  end;
  
  _SERVICE_TABLE_ENTRYWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _SERVICE_TABLE_ENTRYW);
    function ObjToRec: _SERVICE_TABLE_ENTRYW;
  published
  end;
  

implementation

constructor _SERVICE_STATUSWrapper.Create(ARecord: _SERVICE_STATUS);
begin
  inherited Create;
  FdwServiceType := ARecord.dwServiceType;
  FdwCurrentState := ARecord.dwCurrentState;
  FdwControlsAccepted := ARecord.dwControlsAccepted;
  FdwWin32ExitCode := ARecord.dwWin32ExitCode;
  FdwServiceSpecificExitCode := ARecord.dwServiceSpecificExitCode;
  FdwCheckPoint := ARecord.dwCheckPoint;
  FdwWaitHint := ARecord.dwWaitHint;
end;

function _SERVICE_STATUSWrapper.ObjToRec: _SERVICE_STATUS;
begin
  result.dwServiceType := FdwServiceType;
  result.dwCurrentState := FdwCurrentState;
  result.dwControlsAccepted := FdwControlsAccepted;
  result.dwWin32ExitCode := FdwWin32ExitCode;
  result.dwServiceSpecificExitCode := FdwServiceSpecificExitCode;
  result.dwCheckPoint := FdwCheckPoint;
  result.dwWaitHint := FdwWaitHint;
end;

constructor _ENUM_SERVICE_STATUSAWrapper.Create(ARecord: _ENUM_SERVICE_STATUSA);
begin
  inherited Create;
end;

function _ENUM_SERVICE_STATUSAWrapper.ObjToRec: _ENUM_SERVICE_STATUSA;
begin
end;

constructor _ENUM_SERVICE_STATUSWWrapper.Create(ARecord: _ENUM_SERVICE_STATUSW);
begin
  inherited Create;
end;

function _ENUM_SERVICE_STATUSWWrapper.ObjToRec: _ENUM_SERVICE_STATUSW;
begin
end;

constructor _QUERY_SERVICE_LOCK_STATUSAWrapper.Create(ARecord: _QUERY_SERVICE_LOCK_STATUSA);
begin
  inherited Create;
  FfIsLocked := ARecord.fIsLocked;
  FdwLockDuration := ARecord.dwLockDuration;
end;

function _QUERY_SERVICE_LOCK_STATUSAWrapper.ObjToRec: _QUERY_SERVICE_LOCK_STATUSA;
begin
  result.fIsLocked := FfIsLocked;
  result.dwLockDuration := FdwLockDuration;
end;

constructor _QUERY_SERVICE_LOCK_STATUSWWrapper.Create(ARecord: _QUERY_SERVICE_LOCK_STATUSW);
begin
  inherited Create;
  FfIsLocked := ARecord.fIsLocked;
  FdwLockDuration := ARecord.dwLockDuration;
end;

function _QUERY_SERVICE_LOCK_STATUSWWrapper.ObjToRec: _QUERY_SERVICE_LOCK_STATUSW;
begin
  result.fIsLocked := FfIsLocked;
  result.dwLockDuration := FdwLockDuration;
end;

constructor _QUERY_SERVICE_CONFIGAWrapper.Create(ARecord: _QUERY_SERVICE_CONFIGA);
begin
  inherited Create;
  FdwServiceType := ARecord.dwServiceType;
  FdwStartType := ARecord.dwStartType;
  FdwErrorControl := ARecord.dwErrorControl;
  FdwTagId := ARecord.dwTagId;
end;

function _QUERY_SERVICE_CONFIGAWrapper.ObjToRec: _QUERY_SERVICE_CONFIGA;
begin
  result.dwServiceType := FdwServiceType;
  result.dwStartType := FdwStartType;
  result.dwErrorControl := FdwErrorControl;
  result.dwTagId := FdwTagId;
end;

constructor _QUERY_SERVICE_CONFIGWWrapper.Create(ARecord: _QUERY_SERVICE_CONFIGW);
begin
  inherited Create;
  FdwServiceType := ARecord.dwServiceType;
  FdwStartType := ARecord.dwStartType;
  FdwErrorControl := ARecord.dwErrorControl;
  FdwTagId := ARecord.dwTagId;
end;

function _QUERY_SERVICE_CONFIGWWrapper.ObjToRec: _QUERY_SERVICE_CONFIGW;
begin
  result.dwServiceType := FdwServiceType;
  result.dwStartType := FdwStartType;
  result.dwErrorControl := FdwErrorControl;
  result.dwTagId := FdwTagId;
end;

constructor _SERVICE_TABLE_ENTRYAWrapper.Create(ARecord: _SERVICE_TABLE_ENTRYA);
begin
  inherited Create;
end;

function _SERVICE_TABLE_ENTRYAWrapper.ObjToRec: _SERVICE_TABLE_ENTRYA;
begin
end;

constructor _SERVICE_TABLE_ENTRYWWrapper.Create(ARecord: _SERVICE_TABLE_ENTRYW);
begin
  inherited Create;
end;

function _SERVICE_TABLE_ENTRYWWrapper.ObjToRec: _SERVICE_TABLE_ENTRYW;
begin
end;



procedure TatWinSvcLibrary.__CloseServiceHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSvc.CloseServiceHandle(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__ControlService(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TServiceStatus;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SERVICE_STATUSWrapper) then 
  Param2Rec := _SERVICE_STATUSWrapper.Create(Param2);
Param2 := _SERVICE_STATUSWrapper(Param2Rec).ObjToRec;
AResult := WinSvc.ControlService(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SERVICE_STATUSWrapper.Create(Param2)));
  end;
end;

procedure TatWinSvcLibrary.__DeleteService(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSvc.DeleteService(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__EnumDependentServicesA(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TEnumServiceStatusA;
  Param4: DWORD;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _ENUM_SERVICE_STATUSAWrapper) then 
  Param2Rec := _ENUM_SERVICE_STATUSAWrapper.Create(Param2);
Param2 := _ENUM_SERVICE_STATUSAWrapper(Param2Rec).ObjToRec;
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := WinSvc.EnumDependentServicesA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),Param4,Param5);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_ENUM_SERVICE_STATUSAWrapper.Create(Param2)));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatWinSvcLibrary.__EnumDependentServicesW(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TEnumServiceStatusW;
  Param4: DWORD;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _ENUM_SERVICE_STATUSWWrapper) then 
  Param2Rec := _ENUM_SERVICE_STATUSWWrapper.Create(Param2);
Param2 := _ENUM_SERVICE_STATUSWWrapper(Param2Rec).ObjToRec;
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := WinSvc.EnumDependentServicesW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),Param4,Param5);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_ENUM_SERVICE_STATUSWWrapper.Create(Param2)));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatWinSvcLibrary.__EnumDependentServices(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TEnumServiceStatus;
  Param4: DWORD;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _ENUM_SERVICE_STATUSAWrapper) then 
  Param2Rec := _ENUM_SERVICE_STATUSAWrapper.Create(Param2);
Param2 := _ENUM_SERVICE_STATUSAWrapper(Param2Rec).ObjToRec;
Param4 := VarToInteger(GetInputArg(4));
Param5 := VarToInteger(GetInputArg(5));
AResult := WinSvc.EnumDependentServices(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),Param4,Param5);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_ENUM_SERVICE_STATUSAWrapper.Create(Param2)));
    SetInputArg(4,Integer(Param4));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatWinSvcLibrary.__EnumServicesStatusA(AMachine: TatVirtualMachine);
  var
  Param3Rec: TObject;
  Param3: TEnumServiceStatusA;
  Param5: DWORD;
  Param6: DWORD;
  Param7: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is _ENUM_SERVICE_STATUSAWrapper) then 
  Param3Rec := _ENUM_SERVICE_STATUSAWrapper.Create(Param3);
Param3 := _ENUM_SERVICE_STATUSAWrapper(Param3Rec).ObjToRec;
Param5 := VarToInteger(GetInputArg(5));
Param6 := VarToInteger(GetInputArg(6));
Param7 := VarToInteger(GetInputArg(7));
AResult := WinSvc.EnumServicesStatusA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,VarToInteger(GetInputArg(4)),Param5,Param6,Param7);
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(_ENUM_SERVICE_STATUSAWrapper.Create(Param3)));
    SetInputArg(5,Integer(Param5));
    SetInputArg(6,Integer(Param6));
    SetInputArg(7,Integer(Param7));
  end;
end;

procedure TatWinSvcLibrary.__EnumServicesStatusW(AMachine: TatVirtualMachine);
  var
  Param3Rec: TObject;
  Param3: TEnumServiceStatusW;
  Param5: DWORD;
  Param6: DWORD;
  Param7: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is _ENUM_SERVICE_STATUSWWrapper) then 
  Param3Rec := _ENUM_SERVICE_STATUSWWrapper.Create(Param3);
Param3 := _ENUM_SERVICE_STATUSWWrapper(Param3Rec).ObjToRec;
Param5 := VarToInteger(GetInputArg(5));
Param6 := VarToInteger(GetInputArg(6));
Param7 := VarToInteger(GetInputArg(7));
AResult := WinSvc.EnumServicesStatusW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,VarToInteger(GetInputArg(4)),Param5,Param6,Param7);
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(_ENUM_SERVICE_STATUSWWrapper.Create(Param3)));
    SetInputArg(5,Integer(Param5));
    SetInputArg(6,Integer(Param6));
    SetInputArg(7,Integer(Param7));
  end;
end;

procedure TatWinSvcLibrary.__EnumServicesStatus(AMachine: TatVirtualMachine);
  var
  Param3Rec: TObject;
  Param3: TEnumServiceStatus;
  Param5: DWORD;
  Param6: DWORD;
  Param7: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is _ENUM_SERVICE_STATUSAWrapper) then 
  Param3Rec := _ENUM_SERVICE_STATUSAWrapper.Create(Param3);
Param3 := _ENUM_SERVICE_STATUSAWrapper(Param3Rec).ObjToRec;
Param5 := VarToInteger(GetInputArg(5));
Param6 := VarToInteger(GetInputArg(6));
Param7 := VarToInteger(GetInputArg(7));
AResult := WinSvc.EnumServicesStatus(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,VarToInteger(GetInputArg(4)),Param5,Param6,Param7);
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(_ENUM_SERVICE_STATUSAWrapper.Create(Param3)));
    SetInputArg(5,Integer(Param5));
    SetInputArg(6,Integer(Param6));
    SetInputArg(7,Integer(Param7));
  end;
end;

procedure TatWinSvcLibrary.__GetServiceKeyNameA(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.GetServiceKeyNameA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__GetServiceKeyNameW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.GetServiceKeyNameW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__GetServiceKeyName(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.GetServiceKeyName(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__GetServiceDisplayNameA(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.GetServiceDisplayNameA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__GetServiceDisplayNameW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.GetServiceDisplayNameW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__GetServiceDisplayName(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.GetServiceDisplayName(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__NotifyBootConfigStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSvc.NotifyBootConfigStatus(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__OpenSCManagerA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSvc.OpenSCManagerA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__OpenSCManagerW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSvc.OpenSCManagerW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__OpenSCManager(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSvc.OpenSCManager(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__OpenServiceA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSvc.OpenServiceA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__OpenServiceW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSvc.OpenServiceW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__OpenService(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSvc.OpenService(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSvcLibrary.__QueryServiceLockStatusA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TQueryServiceLockStatusA;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _QUERY_SERVICE_LOCK_STATUSAWrapper) then 
  Param1Rec := _QUERY_SERVICE_LOCK_STATUSAWrapper.Create(Param1);
Param1 := _QUERY_SERVICE_LOCK_STATUSAWrapper(Param1Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.QueryServiceLockStatusA(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_QUERY_SERVICE_LOCK_STATUSAWrapper.Create(Param1)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__QueryServiceLockStatusW(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TQueryServiceLockStatusW;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _QUERY_SERVICE_LOCK_STATUSWWrapper) then 
  Param1Rec := _QUERY_SERVICE_LOCK_STATUSWWrapper.Create(Param1);
Param1 := _QUERY_SERVICE_LOCK_STATUSWWrapper(Param1Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.QueryServiceLockStatusW(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_QUERY_SERVICE_LOCK_STATUSWWrapper.Create(Param1)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__QueryServiceLockStatus(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TQueryServiceLockStatus;
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _QUERY_SERVICE_LOCK_STATUSAWrapper) then 
  Param1Rec := _QUERY_SERVICE_LOCK_STATUSAWrapper.Create(Param1);
Param1 := _QUERY_SERVICE_LOCK_STATUSAWrapper(Param1Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := WinSvc.QueryServiceLockStatus(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_QUERY_SERVICE_LOCK_STATUSAWrapper.Create(Param1)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSvcLibrary.__QueryServiceStatus(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TServiceStatus;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SERVICE_STATUSWrapper) then 
  Param1Rec := _SERVICE_STATUSWrapper.Create(Param1);
Param1 := _SERVICE_STATUSWrapper(Param1Rec).ObjToRec;
AResult := WinSvc.QueryServiceStatus(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SERVICE_STATUSWrapper.Create(Param1)));
  end;
end;

procedure TatWinSvcLibrary.__SetServiceStatus(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TServiceStatus;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SERVICE_STATUSWrapper) then 
  Param1Rec := _SERVICE_STATUSWrapper.Create(Param1);
Param1 := _SERVICE_STATUSWrapper(Param1Rec).ObjToRec;
AResult := WinSvc.SetServiceStatus(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SERVICE_STATUSWrapper.Create(Param1)));
  end;
end;

procedure TatWinSvcLibrary.__StartServiceCtrlDispatcherA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TServiceTableEntryA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _SERVICE_TABLE_ENTRYAWrapper) then 
  Param0Rec := _SERVICE_TABLE_ENTRYAWrapper.Create(Param0);
Param0 := _SERVICE_TABLE_ENTRYAWrapper(Param0Rec).ObjToRec;
AResult := WinSvc.StartServiceCtrlDispatcherA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_SERVICE_TABLE_ENTRYAWrapper.Create(Param0)));
  end;
end;

procedure TatWinSvcLibrary.__StartServiceCtrlDispatcherW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TServiceTableEntryW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _SERVICE_TABLE_ENTRYWWrapper) then 
  Param0Rec := _SERVICE_TABLE_ENTRYWWrapper.Create(Param0);
Param0 := _SERVICE_TABLE_ENTRYWWrapper(Param0Rec).ObjToRec;
AResult := WinSvc.StartServiceCtrlDispatcherW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_SERVICE_TABLE_ENTRYWWrapper.Create(Param0)));
  end;
end;

procedure TatWinSvcLibrary.__StartServiceCtrlDispatcher(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TServiceTableEntry;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _SERVICE_TABLE_ENTRYAWrapper) then 
  Param0Rec := _SERVICE_TABLE_ENTRYAWrapper.Create(Param0);
Param0 := _SERVICE_TABLE_ENTRYAWrapper(Param0Rec).ObjToRec;
AResult := WinSvc.StartServiceCtrlDispatcher(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_SERVICE_TABLE_ENTRYAWrapper.Create(Param0)));
  end;
end;

procedure TatWinSvcLibrary.__StartServiceA(AMachine: TatVirtualMachine);
  var
  Param2: PAnsiChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := PChar(VarToStr(GetInputArg(2)));
AResult := WinSvc.StartServiceA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,string(Param2));
  end;
end;

procedure TatWinSvcLibrary.__StartServiceW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param2: PWideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
AResult := WinSvc.StartServiceW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,WideCharToString(Param2));
  end;
end;

procedure TatWinSvcLibrary.__StartService(AMachine: TatVirtualMachine);
  var
  Param2: PChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := PChar(VarToStr(GetInputArg(2)));
AResult := WinSvc.StartService(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,string(Param2));
  end;
end;

procedure TatWinSvcLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('CloseServiceHandle',1,tkVariant,nil,__CloseServiceHandle,false,0);
    DefineMethod('ControlService',3,tkVariant,nil,__ControlService,false,0).SetVarArgs([2]);
    DefineMethod('DeleteService',1,tkVariant,nil,__DeleteService,false,0);
    DefineMethod('EnumDependentServicesA',6,tkVariant,nil,__EnumDependentServicesA,false,0).SetVarArgs([2,4,5]);
    DefineMethod('EnumDependentServicesW',6,tkVariant,nil,__EnumDependentServicesW,false,0).SetVarArgs([2,4,5]);
    DefineMethod('EnumDependentServices',6,tkVariant,nil,__EnumDependentServices,false,0).SetVarArgs([2,4,5]);
    DefineMethod('EnumServicesStatusA',8,tkVariant,nil,__EnumServicesStatusA,false,0).SetVarArgs([3,5,6,7]);
    DefineMethod('EnumServicesStatusW',8,tkVariant,nil,__EnumServicesStatusW,false,0).SetVarArgs([3,5,6,7]);
    DefineMethod('EnumServicesStatus',8,tkVariant,nil,__EnumServicesStatus,false,0).SetVarArgs([3,5,6,7]);
    DefineMethod('GetServiceKeyNameA',4,tkVariant,nil,__GetServiceKeyNameA,false,0).SetVarArgs([3]);
    DefineMethod('GetServiceKeyNameW',4,tkVariant,nil,__GetServiceKeyNameW,false,0).SetVarArgs([3]);
    DefineMethod('GetServiceKeyName',4,tkVariant,nil,__GetServiceKeyName,false,0).SetVarArgs([3]);
    DefineMethod('GetServiceDisplayNameA',4,tkVariant,nil,__GetServiceDisplayNameA,false,0).SetVarArgs([3]);
    DefineMethod('GetServiceDisplayNameW',4,tkVariant,nil,__GetServiceDisplayNameW,false,0).SetVarArgs([3]);
    DefineMethod('GetServiceDisplayName',4,tkVariant,nil,__GetServiceDisplayName,false,0).SetVarArgs([3]);
    DefineMethod('NotifyBootConfigStatus',1,tkVariant,nil,__NotifyBootConfigStatus,false,0);
    DefineMethod('OpenSCManagerA',3,tkInteger,nil,__OpenSCManagerA,false,0);
    DefineMethod('OpenSCManagerW',3,tkInteger,nil,__OpenSCManagerW,false,0);
    DefineMethod('OpenSCManager',3,tkInteger,nil,__OpenSCManager,false,0);
    DefineMethod('OpenServiceA',3,tkInteger,nil,__OpenServiceA,false,0);
    DefineMethod('OpenServiceW',3,tkInteger,nil,__OpenServiceW,false,0);
    DefineMethod('OpenService',3,tkInteger,nil,__OpenService,false,0);
    DefineMethod('QueryServiceLockStatusA',4,tkVariant,nil,__QueryServiceLockStatusA,false,0).SetVarArgs([1,3]);
    DefineMethod('QueryServiceLockStatusW',4,tkVariant,nil,__QueryServiceLockStatusW,false,0).SetVarArgs([1,3]);
    DefineMethod('QueryServiceLockStatus',4,tkVariant,nil,__QueryServiceLockStatus,false,0).SetVarArgs([1,3]);
    DefineMethod('QueryServiceStatus',2,tkVariant,nil,__QueryServiceStatus,false,0).SetVarArgs([1]);
    DefineMethod('SetServiceStatus',2,tkVariant,nil,__SetServiceStatus,false,0).SetVarArgs([1]);
    DefineMethod('StartServiceCtrlDispatcherA',1,tkVariant,nil,__StartServiceCtrlDispatcherA,false,0).SetVarArgs([0]);
    DefineMethod('StartServiceCtrlDispatcherW',1,tkVariant,nil,__StartServiceCtrlDispatcherW,false,0).SetVarArgs([0]);
    DefineMethod('StartServiceCtrlDispatcher',1,tkVariant,nil,__StartServiceCtrlDispatcher,false,0).SetVarArgs([0]);
    DefineMethod('StartServiceA',3,tkVariant,nil,__StartServiceA,false,0).SetVarArgs([2]);
    DefineMethod('StartServiceW',3,tkVariant,nil,__StartServiceW,false,0).SetVarArgs([2]);
    DefineMethod('StartService',3,tkVariant,nil,__StartService,false,0).SetVarArgs([2]);
    AddConstant('SERVICES_ACTIVE_DATABASEA',SERVICES_ACTIVE_DATABASEA);
    AddConstant('SERVICES_ACTIVE_DATABASEW',SERVICES_ACTIVE_DATABASEW);
    AddConstant('SERVICES_ACTIVE_DATABASE',SERVICES_ACTIVE_DATABASE);
    AddConstant('SERVICES_FAILED_DATABASEA',SERVICES_FAILED_DATABASEA);
    AddConstant('SERVICES_FAILED_DATABASEW',SERVICES_FAILED_DATABASEW);
    AddConstant('SERVICES_FAILED_DATABASE',SERVICES_FAILED_DATABASE);
    AddConstant('SC_GROUP_IDENTIFIERA',SC_GROUP_IDENTIFIERA);
    AddConstant('SC_GROUP_IDENTIFIERW',SC_GROUP_IDENTIFIERW);
    AddConstant('SC_GROUP_IDENTIFIER',SC_GROUP_IDENTIFIER);
    AddConstant('SERVICE_NO_CHANGE',SERVICE_NO_CHANGE);
    AddConstant('SERVICE_ACTIVE',SERVICE_ACTIVE);
    AddConstant('SERVICE_INACTIVE',SERVICE_INACTIVE);
    AddConstant('SERVICE_STATE_ALL',SERVICE_STATE_ALL);
    AddConstant('SERVICE_CONTROL_STOP',SERVICE_CONTROL_STOP);
    AddConstant('SERVICE_CONTROL_PAUSE',SERVICE_CONTROL_PAUSE);
    AddConstant('SERVICE_CONTROL_CONTINUE',SERVICE_CONTROL_CONTINUE);
    AddConstant('SERVICE_CONTROL_INTERROGATE',SERVICE_CONTROL_INTERROGATE);
    AddConstant('SERVICE_CONTROL_SHUTDOWN',SERVICE_CONTROL_SHUTDOWN);
    AddConstant('SERVICE_STOPPED',SERVICE_STOPPED);
    AddConstant('SERVICE_START_PENDING',SERVICE_START_PENDING);
    AddConstant('SERVICE_STOP_PENDING',SERVICE_STOP_PENDING);
    AddConstant('SERVICE_RUNNING',SERVICE_RUNNING);
    AddConstant('SERVICE_CONTINUE_PENDING',SERVICE_CONTINUE_PENDING);
    AddConstant('SERVICE_PAUSE_PENDING',SERVICE_PAUSE_PENDING);
    AddConstant('SERVICE_PAUSED',SERVICE_PAUSED);
    AddConstant('SERVICE_ACCEPT_STOP',SERVICE_ACCEPT_STOP);
    AddConstant('SERVICE_ACCEPT_PAUSE_CONTINUE',SERVICE_ACCEPT_PAUSE_CONTINUE);
    AddConstant('SERVICE_ACCEPT_SHUTDOWN',SERVICE_ACCEPT_SHUTDOWN);
    AddConstant('SC_MANAGER_CONNECT',SC_MANAGER_CONNECT);
    AddConstant('SC_MANAGER_CREATE_SERVICE',SC_MANAGER_CREATE_SERVICE);
    AddConstant('SC_MANAGER_ENUMERATE_SERVICE',SC_MANAGER_ENUMERATE_SERVICE);
    AddConstant('SC_MANAGER_LOCK',SC_MANAGER_LOCK);
    AddConstant('SC_MANAGER_QUERY_LOCK_STATUS',SC_MANAGER_QUERY_LOCK_STATUS);
    AddConstant('SC_MANAGER_MODIFY_BOOT_CONFIG',SC_MANAGER_MODIFY_BOOT_CONFIG);
    AddConstant('SC_MANAGER_ALL_ACCESS',SC_MANAGER_ALL_ACCESS);
    AddConstant('SERVICE_QUERY_CONFIG',SERVICE_QUERY_CONFIG);
    AddConstant('SERVICE_CHANGE_CONFIG',SERVICE_CHANGE_CONFIG);
    AddConstant('SERVICE_QUERY_STATUS',SERVICE_QUERY_STATUS);
    AddConstant('SERVICE_ENUMERATE_DEPENDENTS',SERVICE_ENUMERATE_DEPENDENTS);
    AddConstant('SERVICE_START',SERVICE_START);
    AddConstant('SERVICE_STOP',SERVICE_STOP);
    AddConstant('SERVICE_PAUSE_CONTINUE',SERVICE_PAUSE_CONTINUE);
    AddConstant('SERVICE_INTERROGATE',SERVICE_INTERROGATE);
    AddConstant('SERVICE_USER_DEFINED_CONTROL',SERVICE_USER_DEFINED_CONTROL);
    AddConstant('SERVICE_ALL_ACCESS',SERVICE_ALL_ACCESS);
    AddConstant('SERVICE_KERNEL_DRIVER',SERVICE_KERNEL_DRIVER);
    AddConstant('SERVICE_FILE_SYSTEM_DRIVER',SERVICE_FILE_SYSTEM_DRIVER);
    AddConstant('SERVICE_ADAPTER',SERVICE_ADAPTER);
    AddConstant('SERVICE_RECOGNIZER_DRIVER',SERVICE_RECOGNIZER_DRIVER);
    AddConstant('SERVICE_DRIVER',SERVICE_DRIVER);
    AddConstant('SERVICE_WIN32_OWN_PROCESS',SERVICE_WIN32_OWN_PROCESS);
    AddConstant('SERVICE_WIN32_SHARE_PROCESS',SERVICE_WIN32_SHARE_PROCESS);
    AddConstant('SERVICE_WIN32',SERVICE_WIN32);
    AddConstant('SERVICE_INTERACTIVE_PROCESS',SERVICE_INTERACTIVE_PROCESS);
    AddConstant('SERVICE_TYPE_ALL',SERVICE_TYPE_ALL);
    AddConstant('SERVICE_BOOT_START',SERVICE_BOOT_START);
    AddConstant('SERVICE_SYSTEM_START',SERVICE_SYSTEM_START);
    AddConstant('SERVICE_AUTO_START',SERVICE_AUTO_START);
    AddConstant('SERVICE_DEMAND_START',SERVICE_DEMAND_START);
    AddConstant('SERVICE_DISABLED',SERVICE_DISABLED);
    AddConstant('SERVICE_ERROR_IGNORE',SERVICE_ERROR_IGNORE);
    AddConstant('SERVICE_ERROR_NORMAL',SERVICE_ERROR_NORMAL);
    AddConstant('SERVICE_ERROR_SEVERE',SERVICE_ERROR_SEVERE);
    AddConstant('SERVICE_ERROR_CRITICAL',SERVICE_ERROR_CRITICAL);
  end;
end;

class function TatWinSvcLibrary.LibraryName: string;
begin
  result := 'WinSvc';
end;

initialization
  RegisterScripterLibrary(TatWinSvcLibrary, True);

{$WARNINGS ON}

end.

