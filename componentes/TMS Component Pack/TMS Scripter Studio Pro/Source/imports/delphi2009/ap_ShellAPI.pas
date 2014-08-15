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
unit ap_ShellAPI;

interface

uses
  Windows,
  ShellAPI,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatShellAPILibrary = class(TatScripterLibrary)
    procedure __DragQueryFile(AMachine: TatVirtualMachine);
    procedure __DragQueryFileA(AMachine: TatVirtualMachine);
    procedure __DragQueryFileW(AMachine: TatVirtualMachine);
    procedure __DragQueryPoint(AMachine: TatVirtualMachine);
    procedure __DragFinish(AMachine: TatVirtualMachine);
    procedure __DragAcceptFiles(AMachine: TatVirtualMachine);
    procedure __ShellExecute(AMachine: TatVirtualMachine);
    procedure __ShellExecuteA(AMachine: TatVirtualMachine);
    procedure __ShellExecuteW(AMachine: TatVirtualMachine);
    procedure __FindExecutable(AMachine: TatVirtualMachine);
    procedure __FindExecutableA(AMachine: TatVirtualMachine);
    procedure __FindExecutableW(AMachine: TatVirtualMachine);
    procedure __ShellAbout(AMachine: TatVirtualMachine);
    procedure __ShellAboutA(AMachine: TatVirtualMachine);
    procedure __ShellAboutW(AMachine: TatVirtualMachine);
    procedure __DuplicateIcon(AMachine: TatVirtualMachine);
    procedure __ExtractAssociatedIcon(AMachine: TatVirtualMachine);
    procedure __ExtractAssociatedIconA(AMachine: TatVirtualMachine);
    procedure __ExtractAssociatedIconW(AMachine: TatVirtualMachine);
    procedure __ExtractIcon(AMachine: TatVirtualMachine);
    procedure __ExtractIconA(AMachine: TatVirtualMachine);
    procedure __ExtractIconW(AMachine: TatVirtualMachine);
    procedure __SHAppBarMessage(AMachine: TatVirtualMachine);
    procedure __DoEnvironmentSubst(AMachine: TatVirtualMachine);
    procedure __DoEnvironmentSubstA(AMachine: TatVirtualMachine);
    procedure __DoEnvironmentSubstW(AMachine: TatVirtualMachine);
    procedure __ExtractIconEx(AMachine: TatVirtualMachine);
    procedure __ExtractIconExA(AMachine: TatVirtualMachine);
    procedure __ExtractIconExW(AMachine: TatVirtualMachine);
    procedure __SHFileOperation(AMachine: TatVirtualMachine);
    procedure __SHFileOperationA(AMachine: TatVirtualMachine);
    procedure __SHFileOperationW(AMachine: TatVirtualMachine);
    procedure __SHFreeNameMappings(AMachine: TatVirtualMachine);
    procedure __SHGetFileInfo(AMachine: TatVirtualMachine);
    procedure __SHGetFileInfoA(AMachine: TatVirtualMachine);
    procedure __SHGetFileInfoW(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _DRAGINFOAWrapper = class(TatRecordWrapper)
  private
    FuSize: UINT;
    FfNC: BOOL;
    FgrfKeyState: DWORD;
  public
    constructor Create(ARecord: _DRAGINFOA);
    function ObjToRec: _DRAGINFOA;
  published
    property uSize: UINT read FuSize write FuSize;
    property fNC: BOOL read FfNC write FfNC;
    property grfKeyState: DWORD read FgrfKeyState write FgrfKeyState;
  end;
  
  _DRAGINFOWWrapper = class(TatRecordWrapper)
  private
    FuSize: UINT;
    FfNC: BOOL;
    FgrfKeyState: DWORD;
  public
    constructor Create(ARecord: _DRAGINFOW);
    function ObjToRec: _DRAGINFOW;
  published
    property uSize: UINT read FuSize write FuSize;
    property fNC: BOOL read FfNC write FfNC;
    property grfKeyState: DWORD read FgrfKeyState write FgrfKeyState;
  end;
  
  _AppBarDataWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhWnd: HWND;
    FuCallbackMessage: UINT;
    FuEdge: UINT;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: _AppBarData);
    function ObjToRec: _AppBarData;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hWnd: HWND read FhWnd write FhWnd;
    property uCallbackMessage: UINT read FuCallbackMessage write FuCallbackMessage;
    property uEdge: UINT read FuEdge write FuEdge;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _SHFILEOPSTRUCTAWrapper = class(TatRecordWrapper)
  private
    FWnd: HWND;
    FwFunc: UINT;
    FfFlags: FILEOP_FLAGS;
    FfAnyOperationsAborted: BOOL;
  public
    constructor Create(ARecord: _SHFILEOPSTRUCTA);
    function ObjToRec: _SHFILEOPSTRUCTA;
  published
    property Wnd: HWND read FWnd write FWnd;
    property wFunc: UINT read FwFunc write FwFunc;
    property fFlags: FILEOP_FLAGS read FfFlags write FfFlags;
    property fAnyOperationsAborted: BOOL read FfAnyOperationsAborted write FfAnyOperationsAborted;
  end;
  
  _SHFILEOPSTRUCTWWrapper = class(TatRecordWrapper)
  private
    FWnd: HWND;
    FwFunc: UINT;
    FfFlags: FILEOP_FLAGS;
    FfAnyOperationsAborted: BOOL;
  public
    constructor Create(ARecord: _SHFILEOPSTRUCTW);
    function ObjToRec: _SHFILEOPSTRUCTW;
  published
    property Wnd: HWND read FWnd write FWnd;
    property wFunc: UINT read FwFunc write FwFunc;
    property fFlags: FILEOP_FLAGS read FfFlags write FfFlags;
    property fAnyOperationsAborted: BOOL read FfAnyOperationsAborted write FfAnyOperationsAborted;
  end;
  
  _SHNAMEMAPPINGAWrapper = class(TatRecordWrapper)
  private
    FcchOldPath: Integer;
    FcchNewPath: Integer;
  public
    constructor Create(ARecord: _SHNAMEMAPPINGA);
    function ObjToRec: _SHNAMEMAPPINGA;
  published
    property cchOldPath: Integer read FcchOldPath write FcchOldPath;
    property cchNewPath: Integer read FcchNewPath write FcchNewPath;
  end;
  
  _SHNAMEMAPPINGWWrapper = class(TatRecordWrapper)
  private
    FcchOldPath: Integer;
    FcchNewPath: Integer;
  public
    constructor Create(ARecord: _SHNAMEMAPPINGW);
    function ObjToRec: _SHNAMEMAPPINGW;
  published
    property cchOldPath: Integer read FcchOldPath write FcchOldPath;
    property cchNewPath: Integer read FcchNewPath write FcchNewPath;
  end;
  
  _SHELLEXECUTEINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: ULONG;
    FWnd: HWND;
    FnShow: Integer;
    FhInstApp: HINST;
    FhkeyClass: HKEY;
    FdwHotKey: DWORD;
    FhIcon: THandle;
    FhProcess: THandle;
  public
    constructor Create(ARecord: _SHELLEXECUTEINFOA);
    function ObjToRec: _SHELLEXECUTEINFOA;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: ULONG read FfMask write FfMask;
    property Wnd: HWND read FWnd write FWnd;
    property nShow: Integer read FnShow write FnShow;
    property hInstApp: HINST read FhInstApp write FhInstApp;
    property hkeyClass: HKEY read FhkeyClass write FhkeyClass;
    property dwHotKey: DWORD read FdwHotKey write FdwHotKey;
    property hIcon: THandle read FhIcon write FhIcon;
    property hProcess: THandle read FhProcess write FhProcess;
  end;
  
  _SHELLEXECUTEINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: ULONG;
    FWnd: HWND;
    FnShow: Integer;
    FhInstApp: HINST;
    FhkeyClass: HKEY;
    FdwHotKey: DWORD;
    FhIcon: THandle;
    FhProcess: THandle;
  public
    constructor Create(ARecord: _SHELLEXECUTEINFOW);
    function ObjToRec: _SHELLEXECUTEINFOW;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: ULONG read FfMask write FfMask;
    property Wnd: HWND read FWnd write FWnd;
    property nShow: Integer read FnShow write FnShow;
    property hInstApp: HINST read FhInstApp write FhInstApp;
    property hkeyClass: HKEY read FhkeyClass write FhkeyClass;
    property dwHotKey: DWORD read FdwHotKey write FdwHotKey;
    property hIcon: THandle read FhIcon write FhIcon;
    property hProcess: THandle read FhProcess write FhProcess;
  end;
  
  _NOTIFYICONDATAAWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FWnd: HWND;
    FuID: UINT;
    FuFlags: UINT;
    FuCallbackMessage: UINT;
    FhIcon: HICON;
    FdwState: DWORD;
    FdwStateMask: DWORD;
    FuTimeout: UINT;
    FdwInfoFlags: DWORD;
  public
    constructor Create(ARecord: _NOTIFYICONDATAA);
    function ObjToRec: _NOTIFYICONDATAA;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property Wnd: HWND read FWnd write FWnd;
    property uID: UINT read FuID write FuID;
    property uFlags: UINT read FuFlags write FuFlags;
    property uCallbackMessage: UINT read FuCallbackMessage write FuCallbackMessage;
    property hIcon: HICON read FhIcon write FhIcon;
    property dwState: DWORD read FdwState write FdwState;
    property dwStateMask: DWORD read FdwStateMask write FdwStateMask;
    property uTimeout: UINT read FuTimeout write FuTimeout;
    property dwInfoFlags: DWORD read FdwInfoFlags write FdwInfoFlags;
  end;
  
  _NOTIFYICONDATAWWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FWnd: HWND;
    FuID: UINT;
    FuFlags: UINT;
    FuCallbackMessage: UINT;
    FhIcon: HICON;
    FdwState: DWORD;
    FdwStateMask: DWORD;
    FuTimeout: UINT;
    FdwInfoFlags: DWORD;
  public
    constructor Create(ARecord: _NOTIFYICONDATAW);
    function ObjToRec: _NOTIFYICONDATAW;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property Wnd: HWND read FWnd write FWnd;
    property uID: UINT read FuID write FuID;
    property uFlags: UINT read FuFlags write FuFlags;
    property uCallbackMessage: UINT read FuCallbackMessage write FuCallbackMessage;
    property hIcon: HICON read FhIcon write FhIcon;
    property dwState: DWORD read FdwState write FdwState;
    property dwStateMask: DWORD read FdwStateMask write FdwStateMask;
    property uTimeout: UINT read FuTimeout write FuTimeout;
    property dwInfoFlags: DWORD read FdwInfoFlags write FdwInfoFlags;
  end;
  
  _SHFILEINFOAWrapper = class(TatRecordWrapper)
  private
    FhIcon: HICON;
    FiIcon: Integer;
    FdwAttributes: DWORD;
  public
    constructor Create(ARecord: _SHFILEINFOA);
    function ObjToRec: _SHFILEINFOA;
  published
    property hIcon: HICON read FhIcon write FhIcon;
    property iIcon: Integer read FiIcon write FiIcon;
    property dwAttributes: DWORD read FdwAttributes write FdwAttributes;
  end;
  
  _SHFILEINFOWWrapper = class(TatRecordWrapper)
  private
    FhIcon: HICON;
    FiIcon: Integer;
    FdwAttributes: DWORD;
  public
    constructor Create(ARecord: _SHFILEINFOW);
    function ObjToRec: _SHFILEINFOW;
  published
    property hIcon: HICON read FhIcon write FhIcon;
    property iIcon: Integer read FiIcon write FiIcon;
    property dwAttributes: DWORD read FdwAttributes write FdwAttributes;
  end;
  

implementation

constructor _DRAGINFOAWrapper.Create(ARecord: _DRAGINFOA);
begin
  inherited Create;
  FuSize := ARecord.uSize;
  FfNC := ARecord.fNC;
  FgrfKeyState := ARecord.grfKeyState;
end;

function _DRAGINFOAWrapper.ObjToRec: _DRAGINFOA;
begin
  result.uSize := FuSize;
  result.fNC := FfNC;
  result.grfKeyState := FgrfKeyState;
end;

constructor _DRAGINFOWWrapper.Create(ARecord: _DRAGINFOW);
begin
  inherited Create;
  FuSize := ARecord.uSize;
  FfNC := ARecord.fNC;
  FgrfKeyState := ARecord.grfKeyState;
end;

function _DRAGINFOWWrapper.ObjToRec: _DRAGINFOW;
begin
  result.uSize := FuSize;
  result.fNC := FfNC;
  result.grfKeyState := FgrfKeyState;
end;

constructor _AppBarDataWrapper.Create(ARecord: _AppBarData);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhWnd := ARecord.hWnd;
  FuCallbackMessage := ARecord.uCallbackMessage;
  FuEdge := ARecord.uEdge;
  FlParam := ARecord.lParam;
end;

function _AppBarDataWrapper.ObjToRec: _AppBarData;
begin
  result.cbSize := FcbSize;
  result.hWnd := FhWnd;
  result.uCallbackMessage := FuCallbackMessage;
  result.uEdge := FuEdge;
  result.lParam := FlParam;
end;

constructor _SHFILEOPSTRUCTAWrapper.Create(ARecord: _SHFILEOPSTRUCTA);
begin
  inherited Create;
  FWnd := ARecord.Wnd;
  FwFunc := ARecord.wFunc;
  FfFlags := ARecord.fFlags;
  FfAnyOperationsAborted := ARecord.fAnyOperationsAborted;
end;

function _SHFILEOPSTRUCTAWrapper.ObjToRec: _SHFILEOPSTRUCTA;
begin
  result.Wnd := FWnd;
  result.wFunc := FwFunc;
  result.fFlags := FfFlags;
  result.fAnyOperationsAborted := FfAnyOperationsAborted;
end;

constructor _SHFILEOPSTRUCTWWrapper.Create(ARecord: _SHFILEOPSTRUCTW);
begin
  inherited Create;
  FWnd := ARecord.Wnd;
  FwFunc := ARecord.wFunc;
  FfFlags := ARecord.fFlags;
  FfAnyOperationsAborted := ARecord.fAnyOperationsAborted;
end;

function _SHFILEOPSTRUCTWWrapper.ObjToRec: _SHFILEOPSTRUCTW;
begin
  result.Wnd := FWnd;
  result.wFunc := FwFunc;
  result.fFlags := FfFlags;
  result.fAnyOperationsAborted := FfAnyOperationsAborted;
end;

constructor _SHNAMEMAPPINGAWrapper.Create(ARecord: _SHNAMEMAPPINGA);
begin
  inherited Create;
  FcchOldPath := ARecord.cchOldPath;
  FcchNewPath := ARecord.cchNewPath;
end;

function _SHNAMEMAPPINGAWrapper.ObjToRec: _SHNAMEMAPPINGA;
begin
  result.cchOldPath := FcchOldPath;
  result.cchNewPath := FcchNewPath;
end;

constructor _SHNAMEMAPPINGWWrapper.Create(ARecord: _SHNAMEMAPPINGW);
begin
  inherited Create;
  FcchOldPath := ARecord.cchOldPath;
  FcchNewPath := ARecord.cchNewPath;
end;

function _SHNAMEMAPPINGWWrapper.ObjToRec: _SHNAMEMAPPINGW;
begin
  result.cchOldPath := FcchOldPath;
  result.cchNewPath := FcchNewPath;
end;

constructor _SHELLEXECUTEINFOAWrapper.Create(ARecord: _SHELLEXECUTEINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FWnd := ARecord.Wnd;
  FnShow := ARecord.nShow;
  FhInstApp := ARecord.hInstApp;
  FhkeyClass := ARecord.hkeyClass;
  FdwHotKey := ARecord.dwHotKey;
  FhIcon := ARecord.hIcon;
  FhProcess := ARecord.hProcess;
end;

function _SHELLEXECUTEINFOAWrapper.ObjToRec: _SHELLEXECUTEINFOA;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.Wnd := FWnd;
  result.nShow := FnShow;
  result.hInstApp := FhInstApp;
  result.hkeyClass := FhkeyClass;
  result.dwHotKey := FdwHotKey;
  result.hIcon := FhIcon;
  result.hProcess := FhProcess;
end;

constructor _SHELLEXECUTEINFOWWrapper.Create(ARecord: _SHELLEXECUTEINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FWnd := ARecord.Wnd;
  FnShow := ARecord.nShow;
  FhInstApp := ARecord.hInstApp;
  FhkeyClass := ARecord.hkeyClass;
  FdwHotKey := ARecord.dwHotKey;
  FhIcon := ARecord.hIcon;
  FhProcess := ARecord.hProcess;
end;

function _SHELLEXECUTEINFOWWrapper.ObjToRec: _SHELLEXECUTEINFOW;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.Wnd := FWnd;
  result.nShow := FnShow;
  result.hInstApp := FhInstApp;
  result.hkeyClass := FhkeyClass;
  result.dwHotKey := FdwHotKey;
  result.hIcon := FhIcon;
  result.hProcess := FhProcess;
end;

constructor _NOTIFYICONDATAAWrapper.Create(ARecord: _NOTIFYICONDATAA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FWnd := ARecord.Wnd;
  FuID := ARecord.uID;
  FuFlags := ARecord.uFlags;
  FuCallbackMessage := ARecord.uCallbackMessage;
  FhIcon := ARecord.hIcon;
  FdwState := ARecord.dwState;
  FdwStateMask := ARecord.dwStateMask;
  FuTimeout := ARecord.uTimeout;
  FdwInfoFlags := ARecord.dwInfoFlags;
end;

function _NOTIFYICONDATAAWrapper.ObjToRec: _NOTIFYICONDATAA;
begin
  result.cbSize := FcbSize;
  result.Wnd := FWnd;
  result.uID := FuID;
  result.uFlags := FuFlags;
  result.uCallbackMessage := FuCallbackMessage;
  result.hIcon := FhIcon;
  result.dwState := FdwState;
  result.dwStateMask := FdwStateMask;
  result.uTimeout := FuTimeout;
  result.dwInfoFlags := FdwInfoFlags;
end;

constructor _NOTIFYICONDATAWWrapper.Create(ARecord: _NOTIFYICONDATAW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FWnd := ARecord.Wnd;
  FuID := ARecord.uID;
  FuFlags := ARecord.uFlags;
  FuCallbackMessage := ARecord.uCallbackMessage;
  FhIcon := ARecord.hIcon;
  FdwState := ARecord.dwState;
  FdwStateMask := ARecord.dwStateMask;
  FuTimeout := ARecord.uTimeout;
  FdwInfoFlags := ARecord.dwInfoFlags;
end;

function _NOTIFYICONDATAWWrapper.ObjToRec: _NOTIFYICONDATAW;
begin
  result.cbSize := FcbSize;
  result.Wnd := FWnd;
  result.uID := FuID;
  result.uFlags := FuFlags;
  result.uCallbackMessage := FuCallbackMessage;
  result.hIcon := FhIcon;
  result.dwState := FdwState;
  result.dwStateMask := FdwStateMask;
  result.uTimeout := FuTimeout;
  result.dwInfoFlags := FdwInfoFlags;
end;

constructor _SHFILEINFOAWrapper.Create(ARecord: _SHFILEINFOA);
begin
  inherited Create;
  FhIcon := ARecord.hIcon;
  FiIcon := ARecord.iIcon;
  FdwAttributes := ARecord.dwAttributes;
end;

function _SHFILEINFOAWrapper.ObjToRec: _SHFILEINFOA;
begin
  result.hIcon := FhIcon;
  result.iIcon := FiIcon;
  result.dwAttributes := FdwAttributes;
end;

constructor _SHFILEINFOWWrapper.Create(ARecord: _SHFILEINFOW);
begin
  inherited Create;
  FhIcon := ARecord.hIcon;
  FiIcon := ARecord.iIcon;
  FdwAttributes := ARecord.dwAttributes;
end;

function _SHFILEINFOWWrapper.ObjToRec: _SHFILEINFOW;
begin
  result.hIcon := FhIcon;
  result.iIcon := FiIcon;
  result.dwAttributes := FdwAttributes;
end;



procedure TatShellAPILibrary.__DragQueryFile(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DragQueryFile(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__DragQueryFileA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DragQueryFileA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__DragQueryFileW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DragQueryFileW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__DragQueryPoint(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TPointWrapper) then 
  Param1Rec := TPointWrapper.Create(Param1);
Param1 := TPointWrapper(Param1Rec).ObjToRec;
AResult := ShellAPI.DragQueryPoint(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatShellAPILibrary.__DragFinish(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShellAPI.DragFinish(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatShellAPILibrary.__DragAcceptFiles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShellAPI.DragAcceptFiles(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatShellAPILibrary.__ShellExecute(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellExecute(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellExecuteA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellExecuteA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),PAnsiChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellExecuteW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellExecuteW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__FindExecutable(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.FindExecutable(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__FindExecutableA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.FindExecutableA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__FindExecutableW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.FindExecutableW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellAbout(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellAbout(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellAboutA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellAboutA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellAboutW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellAboutW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__DuplicateIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DuplicateIcon(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ExtractAssociatedIcon(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ShellAPI.ExtractAssociatedIcon(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShellAPILibrary.__ExtractAssociatedIconA(AMachine: TatVirtualMachine);
  var
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ShellAPI.ExtractAssociatedIconA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShellAPILibrary.__ExtractAssociatedIconW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ShellAPI.ExtractAssociatedIconW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShellAPILibrary.__ExtractIcon(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ExtractIcon(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ExtractIconA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ExtractIconA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ExtractIconW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ExtractIconW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHAppBarMessage(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TAppBarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _AppBarDataWrapper) then 
  Param1Rec := _AppBarDataWrapper.Create(Param1);
Param1 := _AppBarDataWrapper(Param1Rec).ObjToRec;
AResult := Integer(ShellAPI.SHAppBarMessage(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_AppBarDataWrapper.Create(Param1)));
  end;
end;

procedure TatShellAPILibrary.__DoEnvironmentSubst(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DoEnvironmentSubst(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__DoEnvironmentSubstA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DoEnvironmentSubstA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__DoEnvironmentSubstW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.DoEnvironmentSubstW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ExtractIconEx(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: HICON;
  Param3: HICON;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShellAPI.ExtractIconEx(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2,Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__ExtractIconExA(AMachine: TatVirtualMachine);
  var
  Param2: HICON;
  Param3: HICON;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShellAPI.ExtractIconExA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2,Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__ExtractIconExW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2: HICON;
  Param3: HICON;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShellAPI.ExtractIconExW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2,Param3,VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__SHFileOperation(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.SHFileOperation(_SHFILEOPSTRUCTWWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHFileOperationA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.SHFileOperationA(_SHFILEOPSTRUCTAWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHFileOperationW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.SHFileOperationW(_SHFILEOPSTRUCTWWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHFreeNameMappings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ShellAPI.SHFreeNameMappings(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatShellAPILibrary.__SHGetFileInfo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Rec: TObject;
  Param2: TSHFileInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SHFILEINFOWWrapper) then 
  Param2Rec := _SHFILEINFOWWrapper.Create(Param2);
Param2 := _SHFILEINFOWWrapper(Param2Rec).ObjToRec;
AResult := Integer(ShellAPI.SHGetFileInfo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SHFILEINFOWWrapper.Create(Param2)));
  end;
end;

procedure TatShellAPILibrary.__SHGetFileInfoA(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TSHFileInfoA;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SHFILEINFOAWrapper) then 
  Param2Rec := _SHFILEINFOAWrapper.Create(Param2);
Param2 := _SHFILEINFOAWrapper(Param2Rec).ObjToRec;
AResult := Integer(ShellAPI.SHGetFileInfoA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SHFILEINFOAWrapper.Create(Param2)));
  end;
end;

procedure TatShellAPILibrary.__SHGetFileInfoW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Rec: TObject;
  Param2: TSHFileInfoW;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _SHFILEINFOWWrapper) then 
  Param2Rec := _SHFILEINFOWWrapper.Create(Param2);
Param2 := _SHFILEINFOWWrapper(Param2Rec).ObjToRec;
AResult := Integer(ShellAPI.SHGetFileInfoW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),Param2,VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_SHFILEINFOWWrapper.Create(Param2)));
  end;
end;

procedure TatShellAPILibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DragQueryFile',4,tkInteger,nil,__DragQueryFile,false,0);
    DefineMethod('DragQueryFileA',4,tkInteger,nil,__DragQueryFileA,false,0);
    DefineMethod('DragQueryFileW',4,tkInteger,nil,__DragQueryFileW,false,0);
    DefineMethod('DragQueryPoint',2,tkVariant,nil,__DragQueryPoint,false,0).SetVarArgs([1]);
    DefineMethod('DragFinish',1,tkNone,nil,__DragFinish,false,0);
    DefineMethod('DragAcceptFiles',2,tkNone,nil,__DragAcceptFiles,false,0);
    DefineMethod('ShellExecute',6,tkInteger,nil,__ShellExecute,false,0);
    DefineMethod('ShellExecuteA',6,tkInteger,nil,__ShellExecuteA,false,0);
    DefineMethod('ShellExecuteW',6,tkInteger,nil,__ShellExecuteW,false,0);
    DefineMethod('FindExecutable',3,tkInteger,nil,__FindExecutable,false,0);
    DefineMethod('FindExecutableA',3,tkInteger,nil,__FindExecutableA,false,0);
    DefineMethod('FindExecutableW',3,tkInteger,nil,__FindExecutableW,false,0);
    DefineMethod('ShellAbout',4,tkInteger,nil,__ShellAbout,false,0);
    DefineMethod('ShellAboutA',4,tkInteger,nil,__ShellAboutA,false,0);
    DefineMethod('ShellAboutW',4,tkInteger,nil,__ShellAboutW,false,0);
    DefineMethod('DuplicateIcon',2,tkInteger,nil,__DuplicateIcon,false,0);
    DefineMethod('ExtractAssociatedIcon',3,tkInteger,nil,__ExtractAssociatedIcon,false,0).SetVarArgs([2]);
    DefineMethod('ExtractAssociatedIconA',3,tkInteger,nil,__ExtractAssociatedIconA,false,0).SetVarArgs([2]);
    DefineMethod('ExtractAssociatedIconW',3,tkInteger,nil,__ExtractAssociatedIconW,false,0).SetVarArgs([2]);
    DefineMethod('ExtractIcon',3,tkInteger,nil,__ExtractIcon,false,0);
    DefineMethod('ExtractIconA',3,tkInteger,nil,__ExtractIconA,false,0);
    DefineMethod('ExtractIconW',3,tkInteger,nil,__ExtractIconW,false,0);
    DefineMethod('SHAppBarMessage',2,tkInteger,nil,__SHAppBarMessage,false,0).SetVarArgs([1]);
    DefineMethod('DoEnvironmentSubst',2,tkInteger,nil,__DoEnvironmentSubst,false,0);
    DefineMethod('DoEnvironmentSubstA',2,tkInteger,nil,__DoEnvironmentSubstA,false,0);
    DefineMethod('DoEnvironmentSubstW',2,tkInteger,nil,__DoEnvironmentSubstW,false,0);
    DefineMethod('ExtractIconEx',5,tkInteger,nil,__ExtractIconEx,false,0).SetVarArgs([2,3]);
    DefineMethod('ExtractIconExA',5,tkInteger,nil,__ExtractIconExA,false,0).SetVarArgs([2,3]);
    DefineMethod('ExtractIconExW',5,tkInteger,nil,__ExtractIconExW,false,0).SetVarArgs([2,3]);
    DefineMethod('SHFileOperation',1,tkInteger,nil,__SHFileOperation,false,0);
    DefineMethod('SHFileOperationA',1,tkInteger,nil,__SHFileOperationA,false,0);
    DefineMethod('SHFileOperationW',1,tkInteger,nil,__SHFileOperationW,false,0);
    DefineMethod('SHFreeNameMappings',1,tkNone,nil,__SHFreeNameMappings,false,0);
    DefineMethod('SHGetFileInfo',5,tkInteger,nil,__SHGetFileInfo,false,0).SetVarArgs([2]);
    DefineMethod('SHGetFileInfoA',5,tkInteger,nil,__SHGetFileInfoA,false,0).SetVarArgs([2]);
    DefineMethod('SHGetFileInfoW',5,tkInteger,nil,__SHGetFileInfoW,false,0).SetVarArgs([2]);
    AddConstant('ABM_NEW',ABM_NEW);
    AddConstant('ABM_REMOVE',ABM_REMOVE);
    AddConstant('ABM_QUERYPOS',ABM_QUERYPOS);
    AddConstant('ABM_SETPOS',ABM_SETPOS);
    AddConstant('ABM_GETSTATE',ABM_GETSTATE);
    AddConstant('ABM_GETTASKBARPOS',ABM_GETTASKBARPOS);
    AddConstant('ABM_ACTIVATE',ABM_ACTIVATE);
    AddConstant('ABM_GETAUTOHIDEBAR',ABM_GETAUTOHIDEBAR);
    AddConstant('ABM_SETAUTOHIDEBAR',ABM_SETAUTOHIDEBAR);
    AddConstant('ABM_WINDOWPOSCHANGED',ABM_WINDOWPOSCHANGED);
    AddConstant('ABN_STATECHANGE',ABN_STATECHANGE);
    AddConstant('ABN_POSCHANGED',ABN_POSCHANGED);
    AddConstant('ABN_FULLSCREENAPP',ABN_FULLSCREENAPP);
    AddConstant('ABN_WINDOWARRANGE',ABN_WINDOWARRANGE);
    AddConstant('ABS_AUTOHIDE',ABS_AUTOHIDE);
    AddConstant('ABS_ALWAYSONTOP',ABS_ALWAYSONTOP);
    AddConstant('ABE_LEFT',ABE_LEFT);
    AddConstant('ABE_TOP',ABE_TOP);
    AddConstant('ABE_RIGHT',ABE_RIGHT);
    AddConstant('ABE_BOTTOM',ABE_BOTTOM);
    AddConstant('FO_MOVE',FO_MOVE);
    AddConstant('FO_COPY',FO_COPY);
    AddConstant('FO_DELETE',FO_DELETE);
    AddConstant('FO_RENAME',FO_RENAME);
    AddConstant('FOF_MULTIDESTFILES',FOF_MULTIDESTFILES);
    AddConstant('FOF_CONFIRMMOUSE',FOF_CONFIRMMOUSE);
    AddConstant('FOF_SILENT',FOF_SILENT);
    AddConstant('FOF_RENAMEONCOLLISION',FOF_RENAMEONCOLLISION);
    AddConstant('FOF_NOCONFIRMATION',FOF_NOCONFIRMATION);
    AddConstant('FOF_WANTMAPPINGHANDLE',FOF_WANTMAPPINGHANDLE);
    AddConstant('FOF_ALLOWUNDO',FOF_ALLOWUNDO);
    AddConstant('FOF_FILESONLY',FOF_FILESONLY);
    AddConstant('FOF_SIMPLEPROGRESS',FOF_SIMPLEPROGRESS);
    AddConstant('FOF_NOCONFIRMMKDIR',FOF_NOCONFIRMMKDIR);
    AddConstant('FOF_NOERRORUI',FOF_NOERRORUI);
    AddConstant('FOF_NOCOPYSECURITYATTRIBS',FOF_NOCOPYSECURITYATTRIBS);
    AddConstant('FOF_NORECURSION',FOF_NORECURSION);
    AddConstant('FOF_NO_CONNECTED_ELEMENTS',FOF_NO_CONNECTED_ELEMENTS);
    AddConstant('FOF_WANTNUKEWARNING',FOF_WANTNUKEWARNING);
    AddConstant('FOF_NORECURSEREPARSE',FOF_NORECURSEREPARSE);
    AddConstant('FOF_NO_UI',FOF_NO_UI);
    AddConstant('PO_DELETE',PO_DELETE);
    AddConstant('PO_RENAME',PO_RENAME);
    AddConstant('PO_PORTCHANGE',PO_PORTCHANGE);
    AddConstant('PO_REN_PORT',PO_REN_PORT);
    AddConstant('SE_ERR_FNF',SE_ERR_FNF);
    AddConstant('SE_ERR_PNF',SE_ERR_PNF);
    AddConstant('SE_ERR_ACCESSDENIED',SE_ERR_ACCESSDENIED);
    AddConstant('SE_ERR_OOM',SE_ERR_OOM);
    AddConstant('SE_ERR_DLLNOTFOUND',SE_ERR_DLLNOTFOUND);
    AddConstant('SE_ERR_SHARE',SE_ERR_SHARE);
    AddConstant('SE_ERR_ASSOCINCOMPLETE',SE_ERR_ASSOCINCOMPLETE);
    AddConstant('SE_ERR_DDETIMEOUT',SE_ERR_DDETIMEOUT);
    AddConstant('SE_ERR_DDEFAIL',SE_ERR_DDEFAIL);
    AddConstant('SE_ERR_DDEBUSY',SE_ERR_DDEBUSY);
    AddConstant('SE_ERR_NOASSOC',SE_ERR_NOASSOC);
    AddConstant('SEE_MASK_CLASSNAME',SEE_MASK_CLASSNAME);
    AddConstant('SEE_MASK_CLASSKEY',SEE_MASK_CLASSKEY);
    AddConstant('SEE_MASK_IDLIST',SEE_MASK_IDLIST);
    AddConstant('SEE_MASK_INVOKEIDLIST',SEE_MASK_INVOKEIDLIST);
    AddConstant('SEE_MASK_ICON',SEE_MASK_ICON);
    AddConstant('SEE_MASK_HOTKEY',SEE_MASK_HOTKEY);
    AddConstant('SEE_MASK_NOCLOSEPROCESS',SEE_MASK_NOCLOSEPROCESS);
    AddConstant('SEE_MASK_CONNECTNETDRV',SEE_MASK_CONNECTNETDRV);
    AddConstant('SEE_MASK_FLAG_DDEWAIT',SEE_MASK_FLAG_DDEWAIT);
    AddConstant('SEE_MASK_DOENVSUBST',SEE_MASK_DOENVSUBST);
    AddConstant('SEE_MASK_FLAG_NO_UI',SEE_MASK_FLAG_NO_UI);
    AddConstant('SEE_MASK_UNICODE',SEE_MASK_UNICODE);
    AddConstant('SEE_MASK_NO_CONSOLE',SEE_MASK_NO_CONSOLE);
    AddConstant('SEE_MASK_ASYNCOK',SEE_MASK_ASYNCOK);
    AddConstant('NIM_ADD',NIM_ADD);
    AddConstant('NIM_MODIFY',NIM_MODIFY);
    AddConstant('NIM_DELETE',NIM_DELETE);
    AddConstant('NIM_SETFOCUS',NIM_SETFOCUS);
    AddConstant('NIM_SETVERSION',NIM_SETVERSION);
    AddConstant('NIF_MESSAGE',NIF_MESSAGE);
    AddConstant('NIF_ICON',NIF_ICON);
    AddConstant('NIF_TIP',NIF_TIP);
    AddConstant('NIF_STATE',NIF_STATE);
    AddConstant('NIF_INFO',NIF_INFO);
    AddConstant('NIIF_NONE',NIIF_NONE);
    AddConstant('NIIF_INFO',NIIF_INFO);
    AddConstant('NIIF_WARNING',NIIF_WARNING);
    AddConstant('NIIF_ERROR',NIIF_ERROR);
    AddConstant('NIIF_ICON_MASK',NIIF_ICON_MASK);
    AddConstant('NIN_SELECT',NIN_SELECT);
    AddConstant('NINF_KEY',NINF_KEY);
    AddConstant('NIN_KEYSELECT',NIN_KEYSELECT);
    AddConstant('NIN_BALLOONSHOW',NIN_BALLOONSHOW);
    AddConstant('NIN_BALLOONHIDE',NIN_BALLOONHIDE);
    AddConstant('NIN_BALLOONTIMEOUT',NIN_BALLOONTIMEOUT);
    AddConstant('NIN_BALLOONUSERCLICK',NIN_BALLOONUSERCLICK);
    AddConstant('SHGFI_ICON',SHGFI_ICON);
    AddConstant('SHGFI_DISPLAYNAME',SHGFI_DISPLAYNAME);
    AddConstant('SHGFI_TYPENAME',SHGFI_TYPENAME);
    AddConstant('SHGFI_ATTRIBUTES',SHGFI_ATTRIBUTES);
    AddConstant('SHGFI_ICONLOCATION',SHGFI_ICONLOCATION);
    AddConstant('SHGFI_EXETYPE',SHGFI_EXETYPE);
    AddConstant('SHGFI_SYSICONINDEX',SHGFI_SYSICONINDEX);
    AddConstant('SHGFI_LINKOVERLAY',SHGFI_LINKOVERLAY);
    AddConstant('SHGFI_SELECTED',SHGFI_SELECTED);
    AddConstant('SHGFI_LARGEICON',SHGFI_LARGEICON);
    AddConstant('SHGFI_SMALLICON',SHGFI_SMALLICON);
    AddConstant('SHGFI_OPENICON',SHGFI_OPENICON);
    AddConstant('SHGFI_SHELLICONSIZE',SHGFI_SHELLICONSIZE);
    AddConstant('SHGFI_PIDL',SHGFI_PIDL);
    AddConstant('SHGFI_USEFILEATTRIBUTES',SHGFI_USEFILEATTRIBUTES);
    AddConstant('SHGNLI_PIDL',SHGNLI_PIDL);
    AddConstant('SHGNLI_PREFIXNAME',SHGNLI_PREFIXNAME);
    AddConstant('SHGNLI_NOUNIQUE',SHGNLI_NOUNIQUE);
    AddConstant('shell32',shell32);
  end;
end;

class function TatShellAPILibrary.LibraryName: string;
begin
  result := 'ShellAPI';
end;

initialization
  RegisterScripterLibrary(TatShellAPILibrary, True);

{$WARNINGS ON}

end.

