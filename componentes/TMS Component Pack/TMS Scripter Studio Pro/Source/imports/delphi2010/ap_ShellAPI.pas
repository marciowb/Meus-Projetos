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
  ap_Windows,
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
    procedure __ExtractAssociatedIconEx(AMachine: TatVirtualMachine);
    procedure __ExtractAssociatedIconExA(AMachine: TatVirtualMachine);
    procedure __ExtractAssociatedIconExW(AMachine: TatVirtualMachine);
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
    procedure __SHCreateProcessAsUserW(AMachine: TatVirtualMachine);
    procedure __SHEvaluateSystemCommandTemplate(AMachine: TatVirtualMachine);
    procedure __SHEmptyRecycleBin(AMachine: TatVirtualMachine);
    procedure __SHEmptyRecycleBinA(AMachine: TatVirtualMachine);
    procedure __SHEmptyRecycleBinW(AMachine: TatVirtualMachine);
    procedure __SHQueryUserNotificationState(AMachine: TatVirtualMachine);
    procedure __Shell_NotifyIconGetRect(AMachine: TatVirtualMachine);
    procedure __SHGetFileInfo(AMachine: TatVirtualMachine);
    procedure __SHGetFileInfoA(AMachine: TatVirtualMachine);
    procedure __SHGetFileInfoW(AMachine: TatVirtualMachine);
    procedure __SHGetStockIconInfo(AMachine: TatVirtualMachine);
    procedure __SHGetDiskFreeSpace(AMachine: TatVirtualMachine);
    procedure __SHGetDiskFreeSpaceA(AMachine: TatVirtualMachine);
    procedure __SHGetDiskFreeSpaceW(AMachine: TatVirtualMachine);
    procedure __SHGetDiskFreeSpaceEx(AMachine: TatVirtualMachine);
    procedure __SHGetDiskFreeSpaceExA(AMachine: TatVirtualMachine);
    procedure __SHGetDiskFreeSpaceExW(AMachine: TatVirtualMachine);
    procedure __SHGetNewLinkInfo(AMachine: TatVirtualMachine);
    procedure __SHGetNewLinkInfoA(AMachine: TatVirtualMachine);
    procedure __SHGetNewLinkInfoW(AMachine: TatVirtualMachine);
    procedure __SHInvokePrinterCommand(AMachine: TatVirtualMachine);
    procedure __SHInvokePrinterCommandA(AMachine: TatVirtualMachine);
    procedure __SHInvokePrinterCommandW(AMachine: TatVirtualMachine);
    procedure __SHLoadNonloadedIconOverlayIdentifiers(AMachine: TatVirtualMachine);
    procedure __SHSetLocalizedName(AMachine: TatVirtualMachine);
    procedure __SHRemoveLocalizedName(AMachine: TatVirtualMachine);
    procedure __SHGetLocalizedName(AMachine: TatVirtualMachine);
    procedure __ShellMessageBox(AMachine: TatVirtualMachine);
    procedure __ShellMessageBoxA(AMachine: TatVirtualMachine);
    procedure __ShellMessageBoxW(AMachine: TatVirtualMachine);
    procedure __IsLFNDrive(AMachine: TatVirtualMachine);
    procedure __IsLFNDriveA(AMachine: TatVirtualMachine);
    procedure __IsLFNDriveW(AMachine: TatVirtualMachine);
    procedure __SHEnumerateUnreadMailAccounts(AMachine: TatVirtualMachine);
    procedure __SHEnumerateUnreadMailAccountsA(AMachine: TatVirtualMachine);
    procedure __SHEnumerateUnreadMailAccountsW(AMachine: TatVirtualMachine);
    procedure __SHGetUnreadMailCount(AMachine: TatVirtualMachine);
    procedure __SHGetUnreadMailCountA(AMachine: TatVirtualMachine);
    procedure __SHGetUnreadMailCountW(AMachine: TatVirtualMachine);
    procedure __SHSetUnreadMailCount(AMachine: TatVirtualMachine);
    procedure __SHSetUnreadMailCountA(AMachine: TatVirtualMachine);
    procedure __SHSetUnreadMailCountW(AMachine: TatVirtualMachine);
    procedure __SHTestTokenMembership(AMachine: TatVirtualMachine);
    procedure __InitNetworkAddressControl(AMachine: TatVirtualMachine);
    procedure __SHGetDriveMedia(AMachine: TatVirtualMachine);
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
    FhMonitor: THandle;
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
    property hMonitor: THandle read FhMonitor write FhMonitor;
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
    FhMonitor: THandle;
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
    property hMonitor: THandle read FhMonitor write FhMonitor;
    property hProcess: THandle read FhProcess write FhProcess;
  end;
  
  _SHCREATEPROCESSINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: ULONG;
    Fhwnd: HWND;
    FhUserToken: THandle;
    FbInheritHandles: BOOL;
    FdwCreationFlags: DWORD;
  public
    constructor Create(ARecord: _SHCREATEPROCESSINFOW);
    function ObjToRec: _SHCREATEPROCESSINFOW;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: ULONG read FfMask write FfMask;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property hUserToken: THandle read FhUserToken write FhUserToken;
    property bInheritHandles: BOOL read FbInheritHandles write FbInheritHandles;
    property dwCreationFlags: DWORD read FdwCreationFlags write FdwCreationFlags;
  end;
  
  ASSOCIATIONELEMENTWrapper = class(TatRecordWrapper)
  private
    Fac: TAssocClass;
    FhkClass: HKEY;
  public
    constructor Create(ARecord: ASSOCIATIONELEMENT);
    function ObjToRec: ASSOCIATIONELEMENT;
  published
    property ac: TAssocClass read Fac write Fac;
    property hkClass: HKEY read FhkClass write FhkClass;
  end;
  
  SHQUERYRBINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fi64Size: DWORDLONG;
    Fi64NumItems: DWORDLONG;
  public
    constructor Create(ARecord: SHQUERYRBINFO);
    function ObjToRec: SHQUERYRBINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property i64Size: DWORDLONG read Fi64Size write Fi64Size;
    property i64NumItems: DWORDLONG read Fi64NumItems write Fi64NumItems;
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
    FuVersion: UINT;
    FdwInfoFlags: DWORD;
    FguidItem: TGUID;
    FhBalloonIcon: HICON;
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
    property uVersion: UINT read FuVersion write FuVersion;
    property dwInfoFlags: DWORD read FdwInfoFlags write FdwInfoFlags;
    property guidItem: TGUID read FguidItem write FguidItem;
    property hBalloonIcon: HICON read FhBalloonIcon write FhBalloonIcon;
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
    FuVersion: UINT;
    FdwInfoFlags: DWORD;
    FguidItem: TGUID;
    FhBalloonIcon: HICON;
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
    property uVersion: UINT read FuVersion write FuVersion;
    property dwInfoFlags: DWORD read FdwInfoFlags write FdwInfoFlags;
    property guidItem: TGUID read FguidItem write FguidItem;
    property hBalloonIcon: HICON read FhBalloonIcon write FhBalloonIcon;
  end;
  
  NOTIFYICONIDENTIFIERWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhWnd: HWND;
    FuID: UINT;
    FguidItem: TGUID;
  public
    constructor Create(ARecord: NOTIFYICONIDENTIFIER);
    function ObjToRec: NOTIFYICONIDENTIFIER;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hWnd: HWND read FhWnd write FhWnd;
    property uID: UINT read FuID write FuID;
    property guidItem: TGUID read FguidItem write FguidItem;
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
  
  SHSTOCKICONINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhIcon: HICON;
    FiSysImageIndex: Integer;
    FiIcon: Integer;
  public
    constructor Create(ARecord: SHSTOCKICONINFO);
    function ObjToRec: SHSTOCKICONINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hIcon: HICON read FhIcon write FhIcon;
    property iSysImageIndex: Integer read FiSysImageIndex write FiSysImageIndex;
    property iIcon: Integer read FiIcon write FiIcon;
  end;
  
  OPEN_PRINTER_PROPS_INFOAWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FuSheetIndex: UINT;
    FdwFlags: DWORD;
    FbModal: BOOL;
  public
    constructor Create(ARecord: OPEN_PRINTER_PROPS_INFOA);
    function ObjToRec: OPEN_PRINTER_PROPS_INFOA;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property uSheetIndex: UINT read FuSheetIndex write FuSheetIndex;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property bModal: BOOL read FbModal write FbModal;
  end;
  
  OPEN_PRINTER_PROPS_INFOWWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FuSheetIndex: UINT;
    FdwFlags: DWORD;
    FbModal: BOOL;
  public
    constructor Create(ARecord: OPEN_PRINTER_PROPS_INFOW);
    function ObjToRec: OPEN_PRINTER_PROPS_INFOW;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property uSheetIndex: UINT read FuSheetIndex write FuSheetIndex;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property bModal: BOOL read FbModal write FbModal;
  end;
  
  NET_ADDRESS_INFO_Wrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: NET_ADDRESS_INFO_);
    function ObjToRec: NET_ADDRESS_INFO_;
  published
  end;
  
  NC_ADDRESSWrapper = class(TatRecordWrapper)
  private
    FPortNumber: USHORT;
    FPrefixLength: Byte;
  public
    constructor Create(ARecord: NC_ADDRESS);
    function ObjToRec: NC_ADDRESS;
  published
    property PortNumber: USHORT read FPortNumber write FPortNumber;
    property PrefixLength: Byte read FPrefixLength write FPrefixLength;
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
  FhMonitor := ARecord.hMonitor;
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
  result.hMonitor := FhMonitor;
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
  FhMonitor := ARecord.hMonitor;
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
  result.hMonitor := FhMonitor;
  result.hProcess := FhProcess;
end;

constructor _SHCREATEPROCESSINFOWWrapper.Create(ARecord: _SHCREATEPROCESSINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  Fhwnd := ARecord.hwnd;
  FhUserToken := ARecord.hUserToken;
  FbInheritHandles := ARecord.bInheritHandles;
  FdwCreationFlags := ARecord.dwCreationFlags;
end;

function _SHCREATEPROCESSINFOWWrapper.ObjToRec: _SHCREATEPROCESSINFOW;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.hwnd := Fhwnd;
  result.hUserToken := FhUserToken;
  result.bInheritHandles := FbInheritHandles;
  result.dwCreationFlags := FdwCreationFlags;
end;

constructor ASSOCIATIONELEMENTWrapper.Create(ARecord: ASSOCIATIONELEMENT);
begin
  inherited Create;
  Fac := ARecord.ac;
  FhkClass := ARecord.hkClass;
end;

function ASSOCIATIONELEMENTWrapper.ObjToRec: ASSOCIATIONELEMENT;
begin
  result.ac := Fac;
  result.hkClass := FhkClass;
end;

constructor SHQUERYRBINFOWrapper.Create(ARecord: SHQUERYRBINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fi64Size := ARecord.i64Size;
  Fi64NumItems := ARecord.i64NumItems;
end;

function SHQUERYRBINFOWrapper.ObjToRec: SHQUERYRBINFO;
begin
  result.cbSize := FcbSize;
  result.i64Size := Fi64Size;
  result.i64NumItems := Fi64NumItems;
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
  FuVersion := ARecord.uVersion;
  FdwInfoFlags := ARecord.dwInfoFlags;
  FguidItem := ARecord.guidItem;
  FhBalloonIcon := ARecord.hBalloonIcon;
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
  result.uVersion := FuVersion;
  result.dwInfoFlags := FdwInfoFlags;
  result.guidItem := FguidItem;
  result.hBalloonIcon := FhBalloonIcon;
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
  FuVersion := ARecord.uVersion;
  FdwInfoFlags := ARecord.dwInfoFlags;
  FguidItem := ARecord.guidItem;
  FhBalloonIcon := ARecord.hBalloonIcon;
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
  result.uVersion := FuVersion;
  result.dwInfoFlags := FdwInfoFlags;
  result.guidItem := FguidItem;
  result.hBalloonIcon := FhBalloonIcon;
end;

constructor NOTIFYICONIDENTIFIERWrapper.Create(ARecord: NOTIFYICONIDENTIFIER);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhWnd := ARecord.hWnd;
  FuID := ARecord.uID;
  FguidItem := ARecord.guidItem;
end;

function NOTIFYICONIDENTIFIERWrapper.ObjToRec: NOTIFYICONIDENTIFIER;
begin
  result.cbSize := FcbSize;
  result.hWnd := FhWnd;
  result.uID := FuID;
  result.guidItem := FguidItem;
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

constructor SHSTOCKICONINFOWrapper.Create(ARecord: SHSTOCKICONINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhIcon := ARecord.hIcon;
  FiSysImageIndex := ARecord.iSysImageIndex;
  FiIcon := ARecord.iIcon;
end;

function SHSTOCKICONINFOWrapper.ObjToRec: SHSTOCKICONINFO;
begin
  result.cbSize := FcbSize;
  result.hIcon := FhIcon;
  result.iSysImageIndex := FiSysImageIndex;
  result.iIcon := FiIcon;
end;

constructor OPEN_PRINTER_PROPS_INFOAWrapper.Create(ARecord: OPEN_PRINTER_PROPS_INFOA);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FuSheetIndex := ARecord.uSheetIndex;
  FdwFlags := ARecord.dwFlags;
  FbModal := ARecord.bModal;
end;

function OPEN_PRINTER_PROPS_INFOAWrapper.ObjToRec: OPEN_PRINTER_PROPS_INFOA;
begin
  result.dwSize := FdwSize;
  result.uSheetIndex := FuSheetIndex;
  result.dwFlags := FdwFlags;
  result.bModal := FbModal;
end;

constructor OPEN_PRINTER_PROPS_INFOWWrapper.Create(ARecord: OPEN_PRINTER_PROPS_INFOW);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FuSheetIndex := ARecord.uSheetIndex;
  FdwFlags := ARecord.dwFlags;
  FbModal := ARecord.bModal;
end;

function OPEN_PRINTER_PROPS_INFOWWrapper.ObjToRec: OPEN_PRINTER_PROPS_INFOW;
begin
  result.dwSize := FdwSize;
  result.uSheetIndex := FuSheetIndex;
  result.dwFlags := FdwFlags;
  result.bModal := FbModal;
end;

constructor NET_ADDRESS_INFO_Wrapper.Create(ARecord: NET_ADDRESS_INFO_);
begin
  inherited Create;
end;

function NET_ADDRESS_INFO_Wrapper.ObjToRec: NET_ADDRESS_INFO_;
begin
end;

constructor NC_ADDRESSWrapper.Create(ARecord: NC_ADDRESS);
begin
  inherited Create;
  FPortNumber := ARecord.PortNumber;
  FPrefixLength := ARecord.PrefixLength;
end;

function NC_ADDRESSWrapper.ObjToRec: NC_ADDRESS;
begin
  result.PortNumber := FPortNumber;
  result.PrefixLength := FPrefixLength;
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
AResult := ShellAPI.ShellExecute(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellExecuteA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.ShellExecuteA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),PAnsiChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5)));
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
AResult := ShellAPI.ShellExecuteW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5)));
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
AResult := ShellAPI.FindExecutable(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__FindExecutableA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.FindExecutableA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))));
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
AResult := ShellAPI.FindExecutableW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
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
AResult := Integer(ShellAPI.DuplicateIcon(GetInputArg(0),VarToInteger(GetInputArg(1))));
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
AResult := Integer(ShellAPI.ExtractAssociatedIcon(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
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
AResult := Integer(ShellAPI.ExtractAssociatedIconA(GetInputArg(0),PAnsiChar(VarToStr(GetInputArg(1))),Param2));
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
AResult := Integer(ShellAPI.ExtractAssociatedIconW(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatShellAPILibrary.__ExtractAssociatedIconEx(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: WORD;
  Param3: WORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShellAPI.ExtractAssociatedIconEx(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__ExtractAssociatedIconExA(AMachine: TatVirtualMachine);
  var
  Param2: WORD;
  Param3: WORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShellAPI.ExtractAssociatedIconExA(GetInputArg(0),PAnsiChar(VarToStr(GetInputArg(1))),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__ExtractAssociatedIconExW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: WORD;
  Param3: WORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(ShellAPI.ExtractAssociatedIconExW(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__ExtractIcon(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ExtractIcon(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ExtractIconA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ExtractIconA(GetInputArg(0),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
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
AResult := Integer(ShellAPI.ExtractIconW(GetInputArg(0),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
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
    ShellAPI.SHFreeNameMappings(GetInputArg(0));
  end;
end;

procedure TatShellAPILibrary.__SHCreateProcessAsUserW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TSHCreateProcessInfoW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _SHCREATEPROCESSINFOWWrapper) then 
  Param0Rec := _SHCREATEPROCESSINFOWWrapper.Create(Param0);
Param0 := _SHCREATEPROCESSINFOWWrapper(Param0Rec).ObjToRec;
AResult := ShellAPI.SHCreateProcessAsUserW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_SHCREATEPROCESSINFOWWrapper.Create(Param0)));
  end;
end;

procedure TatShellAPILibrary.__SHEvaluateSystemCommandTemplate(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param1: LPWSTR;
  Param2Buf: array[0..127] of WideChar;
  Param2: LPWSTR;
  Param3Buf: array[0..127] of WideChar;
  Param3: LPWSTR;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
Param3 := StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3))));
AResult := ShellAPI.SHEvaluateSystemCommandTemplate(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
    SetInputArg(2,WideCharToString(Param2));
    SetInputArg(3,WideCharToString(Param3));
  end;
end;

procedure TatShellAPILibrary.__SHEmptyRecycleBin(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHEmptyRecycleBin(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHEmptyRecycleBinA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHEmptyRecycleBinA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHEmptyRecycleBinW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHEmptyRecycleBinW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHQueryUserNotificationState(AMachine: TatVirtualMachine);
  var
  Param0: QUERY_USER_NOTIFICATION_STATE;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := ShellAPI.SHQueryUserNotificationState(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatShellAPILibrary.__Shell_NotifyIconGetRect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: NOTIFYICONIDENTIFIER;
  Param1Rec: TObject;
  Param1: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is NOTIFYICONIDENTIFIERWrapper) then 
  Param0Rec := NOTIFYICONIDENTIFIERWrapper.Create(Param0);
Param0 := NOTIFYICONIDENTIFIERWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TRectWrapper) then 
  Param1Rec := TRectWrapper.Create(Param1);
Param1 := TRectWrapper(Param1Rec).ObjToRec;
AResult := ShellAPI.Shell_NotifyIconGetRect(Param0,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(NOTIFYICONIDENTIFIERWrapper.Create(Param0)));
    SetInputArg(1,integer(TRectWrapper.Create(Param1)));
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

procedure TatShellAPILibrary.__SHGetStockIconInfo(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TSHStockIconInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is SHSTOCKICONINFOWrapper) then 
  Param2Rec := SHSTOCKICONINFOWrapper.Create(Param2);
Param2 := SHSTOCKICONINFOWrapper(Param2Rec).ObjToRec;
AResult := ShellAPI.SHGetStockIconInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(SHSTOCKICONINFOWrapper.Create(Param2)));
  end;
end;

procedure TatShellAPILibrary.__SHGetDiskFreeSpace(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: ULARGE_INTEGER;
  Param2Rec: TObject;
  Param2: ULARGE_INTEGER;
  Param3Rec: TObject;
  Param3: ULARGE_INTEGER;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is ULARGE_INTEGERWrapper) then 
  Param1Rec := ULARGE_INTEGERWrapper.Create(Param1);
Param1 := ULARGE_INTEGERWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is ULARGE_INTEGERWrapper) then 
  Param2Rec := ULARGE_INTEGERWrapper.Create(Param2);
Param2 := ULARGE_INTEGERWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is ULARGE_INTEGERWrapper) then 
  Param3Rec := ULARGE_INTEGERWrapper.Create(Param3);
Param3 := ULARGE_INTEGERWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetDiskFreeSpace(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(ULARGE_INTEGERWrapper.Create(Param1)));
    SetInputArg(2,integer(ULARGE_INTEGERWrapper.Create(Param2)));
    SetInputArg(3,integer(ULARGE_INTEGERWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetDiskFreeSpaceA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: ULARGE_INTEGER;
  Param2Rec: TObject;
  Param2: ULARGE_INTEGER;
  Param3Rec: TObject;
  Param3: ULARGE_INTEGER;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is ULARGE_INTEGERWrapper) then 
  Param1Rec := ULARGE_INTEGERWrapper.Create(Param1);
Param1 := ULARGE_INTEGERWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is ULARGE_INTEGERWrapper) then 
  Param2Rec := ULARGE_INTEGERWrapper.Create(Param2);
Param2 := ULARGE_INTEGERWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is ULARGE_INTEGERWrapper) then 
  Param3Rec := ULARGE_INTEGERWrapper.Create(Param3);
Param3 := ULARGE_INTEGERWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetDiskFreeSpaceA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(ULARGE_INTEGERWrapper.Create(Param1)));
    SetInputArg(2,integer(ULARGE_INTEGERWrapper.Create(Param2)));
    SetInputArg(3,integer(ULARGE_INTEGERWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetDiskFreeSpaceW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: ULARGE_INTEGER;
  Param2Rec: TObject;
  Param2: ULARGE_INTEGER;
  Param3Rec: TObject;
  Param3: ULARGE_INTEGER;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is ULARGE_INTEGERWrapper) then 
  Param1Rec := ULARGE_INTEGERWrapper.Create(Param1);
Param1 := ULARGE_INTEGERWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is ULARGE_INTEGERWrapper) then 
  Param2Rec := ULARGE_INTEGERWrapper.Create(Param2);
Param2 := ULARGE_INTEGERWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is ULARGE_INTEGERWrapper) then 
  Param3Rec := ULARGE_INTEGERWrapper.Create(Param3);
Param3 := ULARGE_INTEGERWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetDiskFreeSpaceW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(ULARGE_INTEGERWrapper.Create(Param1)));
    SetInputArg(2,integer(ULARGE_INTEGERWrapper.Create(Param2)));
    SetInputArg(3,integer(ULARGE_INTEGERWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetDiskFreeSpaceEx(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: ULARGE_INTEGER;
  Param2Rec: TObject;
  Param2: ULARGE_INTEGER;
  Param3Rec: TObject;
  Param3: ULARGE_INTEGER;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is ULARGE_INTEGERWrapper) then 
  Param1Rec := ULARGE_INTEGERWrapper.Create(Param1);
Param1 := ULARGE_INTEGERWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is ULARGE_INTEGERWrapper) then 
  Param2Rec := ULARGE_INTEGERWrapper.Create(Param2);
Param2 := ULARGE_INTEGERWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is ULARGE_INTEGERWrapper) then 
  Param3Rec := ULARGE_INTEGERWrapper.Create(Param3);
Param3 := ULARGE_INTEGERWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetDiskFreeSpaceEx(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(ULARGE_INTEGERWrapper.Create(Param1)));
    SetInputArg(2,integer(ULARGE_INTEGERWrapper.Create(Param2)));
    SetInputArg(3,integer(ULARGE_INTEGERWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetDiskFreeSpaceExA(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: ULARGE_INTEGER;
  Param2Rec: TObject;
  Param2: ULARGE_INTEGER;
  Param3Rec: TObject;
  Param3: ULARGE_INTEGER;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is ULARGE_INTEGERWrapper) then 
  Param1Rec := ULARGE_INTEGERWrapper.Create(Param1);
Param1 := ULARGE_INTEGERWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is ULARGE_INTEGERWrapper) then 
  Param2Rec := ULARGE_INTEGERWrapper.Create(Param2);
Param2 := ULARGE_INTEGERWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is ULARGE_INTEGERWrapper) then 
  Param3Rec := ULARGE_INTEGERWrapper.Create(Param3);
Param3 := ULARGE_INTEGERWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetDiskFreeSpaceExA(PAnsiChar(VarToStr(GetInputArg(0))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(ULARGE_INTEGERWrapper.Create(Param1)));
    SetInputArg(2,integer(ULARGE_INTEGERWrapper.Create(Param2)));
    SetInputArg(3,integer(ULARGE_INTEGERWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetDiskFreeSpaceExW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: ULARGE_INTEGER;
  Param2Rec: TObject;
  Param2: ULARGE_INTEGER;
  Param3Rec: TObject;
  Param3: ULARGE_INTEGER;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is ULARGE_INTEGERWrapper) then 
  Param1Rec := ULARGE_INTEGERWrapper.Create(Param1);
Param1 := ULARGE_INTEGERWrapper(Param1Rec).ObjToRec;
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is ULARGE_INTEGERWrapper) then 
  Param2Rec := ULARGE_INTEGERWrapper.Create(Param2);
Param2 := ULARGE_INTEGERWrapper(Param2Rec).ObjToRec;
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is ULARGE_INTEGERWrapper) then 
  Param3Rec := ULARGE_INTEGERWrapper.Create(Param3);
Param3 := ULARGE_INTEGERWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetDiskFreeSpaceExW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1,Param2,Param3);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(ULARGE_INTEGERWrapper.Create(Param1)));
    SetInputArg(2,integer(ULARGE_INTEGERWrapper.Create(Param2)));
    SetInputArg(3,integer(ULARGE_INTEGERWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetNewLinkInfo(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := ShellAPI.SHGetNewLinkInfo(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatShellAPILibrary.__SHGetNewLinkInfoA(AMachine: TatVirtualMachine);
  var
  Param3: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := ShellAPI.SHGetNewLinkInfoA(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),Param3,VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatShellAPILibrary.__SHGetNewLinkInfoW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  Param3: BOOL;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := ShellAPI.SHGetNewLinkInfoW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),Param3,VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatShellAPILibrary.__SHInvokePrinterCommand(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHInvokePrinterCommand(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHInvokePrinterCommandA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHInvokePrinterCommandA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHInvokePrinterCommandW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHInvokePrinterCommandW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHLoadNonloadedIconOverlayIdentifiers(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHLoadNonloadedIconOverlayIdentifiers;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHSetLocalizedName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHSetLocalizedName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHRemoveLocalizedName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHRemoveLocalizedName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHGetLocalizedName(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  Param3: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := ShellAPI.SHGetLocalizedName(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatShellAPILibrary.__ShellMessageBox(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellMessageBox(GetInputArg(0),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellMessageBoxA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellMessageBoxA(GetInputArg(0),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__ShellMessageBoxW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param3Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShellAPI.ShellMessageBoxW(GetInputArg(0),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),StringToWideChar(VarToStr(GetInputArg(3)),Param3Buf,Length(VarToStr(GetInputArg(3)))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__IsLFNDrive(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.IsLFNDrive(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__IsLFNDriveA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.IsLFNDriveA(PAnsiChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__IsLFNDriveW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.IsLFNDriveW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHEnumerateUnreadMailAccounts(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHEnumerateUnreadMailAccounts(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHEnumerateUnreadMailAccountsA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHEnumerateUnreadMailAccountsA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHEnumerateUnreadMailAccountsW(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHEnumerateUnreadMailAccountsW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHGetUnreadMailCount(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  Param3Rec: TObject;
  Param3: FILETIME;
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is _FILETIMEWrapper) then 
  Param3Rec := _FILETIMEWrapper.Create(Param3);
Param3 := _FILETIMEWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetUnreadMailCount(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,Param3,StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,integer(_FILETIMEWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetUnreadMailCountA(AMachine: TatVirtualMachine);
  var
  Param2: DWORD;
  Param3Rec: TObject;
  Param3: FILETIME;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is _FILETIMEWrapper) then 
  Param3Rec := _FILETIMEWrapper.Create(Param3);
Param3 := _FILETIMEWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetUnreadMailCountA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),Param2,Param3,PAnsiChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,integer(_FILETIMEWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHGetUnreadMailCountW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  Param3Rec: TObject;
  Param3: FILETIME;
  Param4Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is _FILETIMEWrapper) then 
  Param3Rec := _FILETIMEWrapper.Create(Param3);
Param3 := _FILETIMEWrapper(Param3Rec).ObjToRec;
AResult := ShellAPI.SHGetUnreadMailCountW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2,Param3,StringToWideChar(VarToStr(GetInputArg(4)),Param4Buf,Length(VarToStr(GetInputArg(4)))),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,integer(_FILETIMEWrapper.Create(Param3)));
  end;
end;

procedure TatShellAPILibrary.__SHSetUnreadMailCount(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHSetUnreadMailCount(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHSetUnreadMailCountA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHSetUnreadMailCountA(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHSetUnreadMailCountW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHSetUnreadMailCountW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHTestTokenMembership(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.SHTestTokenMembership(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__InitNetworkAddressControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShellAPI.InitNetworkAddressControl;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShellAPILibrary.__SHGetDriveMedia(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := ShellAPI.SHGetDriveMedia(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
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
    DefineMethod('ShellExecute',6,tkVariant,nil,__ShellExecute,false,0);
    DefineMethod('ShellExecuteA',6,tkVariant,nil,__ShellExecuteA,false,0);
    DefineMethod('ShellExecuteW',6,tkVariant,nil,__ShellExecuteW,false,0);
    DefineMethod('FindExecutable',3,tkVariant,nil,__FindExecutable,false,0);
    DefineMethod('FindExecutableA',3,tkVariant,nil,__FindExecutableA,false,0);
    DefineMethod('FindExecutableW',3,tkVariant,nil,__FindExecutableW,false,0);
    DefineMethod('ShellAbout',4,tkInteger,nil,__ShellAbout,false,0);
    DefineMethod('ShellAboutA',4,tkInteger,nil,__ShellAboutA,false,0);
    DefineMethod('ShellAboutW',4,tkInteger,nil,__ShellAboutW,false,0);
    DefineMethod('DuplicateIcon',2,tkInteger,nil,__DuplicateIcon,false,0);
    DefineMethod('ExtractAssociatedIcon',3,tkInteger,nil,__ExtractAssociatedIcon,false,0).SetVarArgs([2]);
    DefineMethod('ExtractAssociatedIconA',3,tkInteger,nil,__ExtractAssociatedIconA,false,0).SetVarArgs([2]);
    DefineMethod('ExtractAssociatedIconW',3,tkInteger,nil,__ExtractAssociatedIconW,false,0).SetVarArgs([2]);
    DefineMethod('ExtractAssociatedIconEx',4,tkInteger,nil,__ExtractAssociatedIconEx,false,0).SetVarArgs([2,3]);
    DefineMethod('ExtractAssociatedIconExA',4,tkInteger,nil,__ExtractAssociatedIconExA,false,0).SetVarArgs([2,3]);
    DefineMethod('ExtractAssociatedIconExW',4,tkInteger,nil,__ExtractAssociatedIconExW,false,0).SetVarArgs([2,3]);
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
    DefineMethod('SHCreateProcessAsUserW',1,tkVariant,nil,__SHCreateProcessAsUserW,false,0).SetVarArgs([0]);
    DefineMethod('SHEvaluateSystemCommandTemplate',4,tkVariant,nil,__SHEvaluateSystemCommandTemplate,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHEmptyRecycleBin',3,tkVariant,nil,__SHEmptyRecycleBin,false,0);
    DefineMethod('SHEmptyRecycleBinA',3,tkVariant,nil,__SHEmptyRecycleBinA,false,0);
    DefineMethod('SHEmptyRecycleBinW',3,tkVariant,nil,__SHEmptyRecycleBinW,false,0);
    DefineMethod('SHQueryUserNotificationState',1,tkVariant,nil,__SHQueryUserNotificationState,false,0).SetVarArgs([0]);
    DefineMethod('Shell_NotifyIconGetRect',2,tkVariant,nil,__Shell_NotifyIconGetRect,false,0).SetVarArgs([0,1]);
    DefineMethod('SHGetFileInfo',5,tkInteger,nil,__SHGetFileInfo,false,0).SetVarArgs([2]);
    DefineMethod('SHGetFileInfoA',5,tkInteger,nil,__SHGetFileInfoA,false,0).SetVarArgs([2]);
    DefineMethod('SHGetFileInfoW',5,tkInteger,nil,__SHGetFileInfoW,false,0).SetVarArgs([2]);
    DefineMethod('SHGetStockIconInfo',3,tkVariant,nil,__SHGetStockIconInfo,false,0).SetVarArgs([2]);
    DefineMethod('SHGetDiskFreeSpace',4,tkVariant,nil,__SHGetDiskFreeSpace,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHGetDiskFreeSpaceA',4,tkVariant,nil,__SHGetDiskFreeSpaceA,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHGetDiskFreeSpaceW',4,tkVariant,nil,__SHGetDiskFreeSpaceW,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHGetDiskFreeSpaceEx',4,tkVariant,nil,__SHGetDiskFreeSpaceEx,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHGetDiskFreeSpaceExA',4,tkVariant,nil,__SHGetDiskFreeSpaceExA,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHGetDiskFreeSpaceExW',4,tkVariant,nil,__SHGetDiskFreeSpaceExW,false,0).SetVarArgs([1,2,3]);
    DefineMethod('SHGetNewLinkInfo',5,tkVariant,nil,__SHGetNewLinkInfo,false,0).SetVarArgs([3]);
    DefineMethod('SHGetNewLinkInfoA',5,tkVariant,nil,__SHGetNewLinkInfoA,false,0).SetVarArgs([3]);
    DefineMethod('SHGetNewLinkInfoW',5,tkVariant,nil,__SHGetNewLinkInfoW,false,0).SetVarArgs([3]);
    DefineMethod('SHInvokePrinterCommand',5,tkVariant,nil,__SHInvokePrinterCommand,false,0);
    DefineMethod('SHInvokePrinterCommandA',5,tkVariant,nil,__SHInvokePrinterCommandA,false,0);
    DefineMethod('SHInvokePrinterCommandW',5,tkVariant,nil,__SHInvokePrinterCommandW,false,0);
    DefineMethod('SHLoadNonloadedIconOverlayIdentifiers',0,tkVariant,nil,__SHLoadNonloadedIconOverlayIdentifiers,false,0);
    DefineMethod('SHSetLocalizedName',3,tkVariant,nil,__SHSetLocalizedName,false,0);
    DefineMethod('SHRemoveLocalizedName',1,tkVariant,nil,__SHRemoveLocalizedName,false,0);
    DefineMethod('SHGetLocalizedName',4,tkVariant,nil,__SHGetLocalizedName,false,0).SetVarArgs([3]);
    DefineMethod('ShellMessageBox',5,tkInteger,nil,__ShellMessageBox,false,0);
    DefineMethod('ShellMessageBoxA',5,tkInteger,nil,__ShellMessageBoxA,false,0);
    DefineMethod('ShellMessageBoxW',5,tkInteger,nil,__ShellMessageBoxW,false,0);
    DefineMethod('IsLFNDrive',1,tkVariant,nil,__IsLFNDrive,false,0);
    DefineMethod('IsLFNDriveA',1,tkVariant,nil,__IsLFNDriveA,false,0);
    DefineMethod('IsLFNDriveW',1,tkVariant,nil,__IsLFNDriveW,false,0);
    DefineMethod('SHEnumerateUnreadMailAccounts',4,tkVariant,nil,__SHEnumerateUnreadMailAccounts,false,0);
    DefineMethod('SHEnumerateUnreadMailAccountsA',4,tkVariant,nil,__SHEnumerateUnreadMailAccountsA,false,0);
    DefineMethod('SHEnumerateUnreadMailAccountsW',4,tkVariant,nil,__SHEnumerateUnreadMailAccountsW,false,0);
    DefineMethod('SHGetUnreadMailCount',6,tkVariant,nil,__SHGetUnreadMailCount,false,0).SetVarArgs([2,3]);
    DefineMethod('SHGetUnreadMailCountA',6,tkVariant,nil,__SHGetUnreadMailCountA,false,0).SetVarArgs([2,3]);
    DefineMethod('SHGetUnreadMailCountW',6,tkVariant,nil,__SHGetUnreadMailCountW,false,0).SetVarArgs([2,3]);
    DefineMethod('SHSetUnreadMailCount',3,tkVariant,nil,__SHSetUnreadMailCount,false,0);
    DefineMethod('SHSetUnreadMailCountA',3,tkVariant,nil,__SHSetUnreadMailCountA,false,0);
    DefineMethod('SHSetUnreadMailCountW',3,tkVariant,nil,__SHSetUnreadMailCountW,false,0);
    DefineMethod('SHTestTokenMembership',2,tkVariant,nil,__SHTestTokenMembership,false,0);
    DefineMethod('InitNetworkAddressControl',0,tkVariant,nil,__InitNetworkAddressControl,false,0);
    DefineMethod('SHGetDriveMedia',2,tkVariant,nil,__SHGetDriveMedia,false,0).SetVarArgs([1]);
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
    AddConstant('ABM_SETSTATE',ABM_SETSTATE);
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
    AddConstant('SEE_MASK_DEFAULT',SEE_MASK_DEFAULT);
    AddConstant('SEE_MASK_CLASSNAME',SEE_MASK_CLASSNAME);
    AddConstant('SEE_MASK_CLASSKEY',SEE_MASK_CLASSKEY);
    AddConstant('SEE_MASK_IDLIST',SEE_MASK_IDLIST);
    AddConstant('SEE_MASK_INVOKEIDLIST',SEE_MASK_INVOKEIDLIST);
    AddConstant('SEE_MASK_ICON',SEE_MASK_ICON);
    AddConstant('SEE_MASK_HOTKEY',SEE_MASK_HOTKEY);
    AddConstant('SEE_MASK_NOCLOSEPROCESS',SEE_MASK_NOCLOSEPROCESS);
    AddConstant('SEE_MASK_CONNECTNETDRV',SEE_MASK_CONNECTNETDRV);
    AddConstant('SEE_MASK_NOASYNC',SEE_MASK_NOASYNC);
    AddConstant('SEE_MASK_FLAG_DDEWAIT',SEE_MASK_FLAG_DDEWAIT);
    AddConstant('SEE_MASK_DOENVSUBST',SEE_MASK_DOENVSUBST);
    AddConstant('SEE_MASK_FLAG_NO_UI',SEE_MASK_FLAG_NO_UI);
    AddConstant('SEE_MASK_UNICODE',SEE_MASK_UNICODE);
    AddConstant('SEE_MASK_NO_CONSOLE',SEE_MASK_NO_CONSOLE);
    AddConstant('SEE_MASK_ASYNCOK',SEE_MASK_ASYNCOK);
    AddConstant('SEE_MASK_HMONITOR',SEE_MASK_HMONITOR);
    AddConstant('SEE_MASK_NOZONECHECKS',SEE_MASK_NOZONECHECKS);
    AddConstant('SEE_MASK_NOQUERYCLASSSTORE',SEE_MASK_NOQUERYCLASSSTORE);
    AddConstant('SEE_MASK_WAITFORINPUTIDLE',SEE_MASK_WAITFORINPUTIDLE);
    AddConstant('SEE_MASK_FLAG_LOG_USAGE',SEE_MASK_FLAG_LOG_USAGE);
    AddConstant('ASSOCCLASS_SHELL_KEY',ASSOCCLASS_SHELL_KEY);
    AddConstant('ASSOCCLASS_PROGID_KEY',ASSOCCLASS_PROGID_KEY);
    AddConstant('ASSOCCLASS_PROGID_STR',ASSOCCLASS_PROGID_STR);
    AddConstant('ASSOCCLASS_CLSID_KEY',ASSOCCLASS_CLSID_KEY);
    AddConstant('ASSOCCLASS_CLSID_STR',ASSOCCLASS_CLSID_STR);
    AddConstant('ASSOCCLASS_APP_KEY',ASSOCCLASS_APP_KEY);
    AddConstant('ASSOCCLASS_APP_STR',ASSOCCLASS_APP_STR);
    AddConstant('ASSOCCLASS_SYSTEM_STR',ASSOCCLASS_SYSTEM_STR);
    AddConstant('ASSOCCLASS_FOLDER',ASSOCCLASS_FOLDER);
    AddConstant('ASSOCCLASS_STAR',ASSOCCLASS_STAR);
    AddConstant('SHERB_NOCONFIRMATION',SHERB_NOCONFIRMATION);
    AddConstant('SHERB_NOPROGRESSUI',SHERB_NOPROGRESSUI);
    AddConstant('SHERB_NOSOUND',SHERB_NOSOUND);
    AddConstant('QUNS_NOT_PRESENT',QUNS_NOT_PRESENT);
    AddConstant('QUNS_BUSY',QUNS_BUSY);
    AddConstant('QUNS_RUNNING_D3D_FULL_SCREEN',QUNS_RUNNING_D3D_FULL_SCREEN);
    AddConstant('QUNS_PRESENTATION_MODE',QUNS_PRESENTATION_MODE);
    AddConstant('QUNS_ACCEPTS_NOTIFICATIONS',QUNS_ACCEPTS_NOTIFICATIONS);
    AddConstant('QUNS_QUIET_TIME',QUNS_QUIET_TIME);
    AddConstant('NIM_ADD',NIM_ADD);
    AddConstant('NIM_MODIFY',NIM_MODIFY);
    AddConstant('NIM_DELETE',NIM_DELETE);
    AddConstant('NIM_SETFOCUS',NIM_SETFOCUS);
    AddConstant('NIM_SETVERSION',NIM_SETVERSION);
    AddConstant('NOTIFYICON_VERSION',NOTIFYICON_VERSION);
    AddConstant('NOTIFYICON_VERSION_4',NOTIFYICON_VERSION_4);
    AddConstant('NIF_MESSAGE',NIF_MESSAGE);
    AddConstant('NIF_ICON',NIF_ICON);
    AddConstant('NIF_TIP',NIF_TIP);
    AddConstant('NIF_STATE',NIF_STATE);
    AddConstant('NIF_INFO',NIF_INFO);
    AddConstant('NIF_GUID',NIF_GUID);
    AddConstant('NIF_REALTIME',NIF_REALTIME);
    AddConstant('NIF_SHOWTIP',NIF_SHOWTIP);
    AddConstant('NIS_HIDDEN',NIS_HIDDEN);
    AddConstant('NIS_SHAREDICON',NIS_SHAREDICON);
    AddConstant('NIIF_NONE',NIIF_NONE);
    AddConstant('NIIF_INFO',NIIF_INFO);
    AddConstant('NIIF_WARNING',NIIF_WARNING);
    AddConstant('NIIF_ERROR',NIIF_ERROR);
    AddConstant('NIIF_USER',NIIF_USER);
    AddConstant('NIIF_ICON_MASK',NIIF_ICON_MASK);
    AddConstant('NIIF_NOSOUND',NIIF_NOSOUND);
    AddConstant('NIIF_LARGE_ICON',NIIF_LARGE_ICON);
    AddConstant('NIIF_RESPECT_QUIET_TIME',NIIF_RESPECT_QUIET_TIME);
    AddConstant('NIN_SELECT',NIN_SELECT);
    AddConstant('NINF_KEY',NINF_KEY);
    AddConstant('NIN_KEYSELECT',NIN_KEYSELECT);
    AddConstant('NIN_BALLOONSHOW',NIN_BALLOONSHOW);
    AddConstant('NIN_BALLOONHIDE',NIN_BALLOONHIDE);
    AddConstant('NIN_BALLOONTIMEOUT',NIN_BALLOONTIMEOUT);
    AddConstant('NIN_BALLOONUSERCLICK',NIN_BALLOONUSERCLICK);
    AddConstant('NIN_POPUPOPEN',NIN_POPUPOPEN);
    AddConstant('NIN_POPUPCLOSE',NIN_POPUPCLOSE);
    AddConstant('SHGFI_ICON',SHGFI_ICON);
    AddConstant('SHGFI_DISPLAYNAME',SHGFI_DISPLAYNAME);
    AddConstant('SHGFI_TYPENAME',SHGFI_TYPENAME);
    AddConstant('SHGFI_ATTRIBUTES',SHGFI_ATTRIBUTES);
    AddConstant('SHGFI_ICONLOCATION',SHGFI_ICONLOCATION);
    AddConstant('SHGFI_EXETYPE',SHGFI_EXETYPE);
    AddConstant('SHGFI_SYSICONINDEX',SHGFI_SYSICONINDEX);
    AddConstant('SHGFI_LINKOVERLAY',SHGFI_LINKOVERLAY);
    AddConstant('SHGFI_SELECTED',SHGFI_SELECTED);
    AddConstant('SHGFI_ATTR_SPECIFIED',SHGFI_ATTR_SPECIFIED);
    AddConstant('SHGFI_LARGEICON',SHGFI_LARGEICON);
    AddConstant('SHGFI_SMALLICON',SHGFI_SMALLICON);
    AddConstant('SHGFI_OPENICON',SHGFI_OPENICON);
    AddConstant('SHGFI_SHELLICONSIZE',SHGFI_SHELLICONSIZE);
    AddConstant('SHGFI_PIDL',SHGFI_PIDL);
    AddConstant('SHGFI_USEFILEATTRIBUTES',SHGFI_USEFILEATTRIBUTES);
    AddConstant('SHGFI_ADDOVERLAYS',SHGFI_ADDOVERLAYS);
    AddConstant('SHGFI_OVERLAYINDEX',SHGFI_OVERLAYINDEX);
    AddConstant('SHGSI_ICONLOCATION',SHGSI_ICONLOCATION);
    AddConstant('SHGSI_ICON',SHGSI_ICON);
    AddConstant('SHGSI_SYSICONINDEX',SHGSI_SYSICONINDEX);
    AddConstant('SHGSI_LINKOVERLAY',SHGSI_LINKOVERLAY);
    AddConstant('SHGSI_SELECTED',SHGSI_SELECTED);
    AddConstant('SHGSI_LARGEICON',SHGSI_LARGEICON);
    AddConstant('SHGSI_SMALLICON',SHGSI_SMALLICON);
    AddConstant('SHGSI_SHELLICONSIZE',SHGSI_SHELLICONSIZE);
    AddConstant('SIID_DOCNOASSOC',SIID_DOCNOASSOC);
    AddConstant('SIID_DOCASSOC',SIID_DOCASSOC);
    AddConstant('SIID_APPLICATION',SIID_APPLICATION);
    AddConstant('SIID_FOLDER',SIID_FOLDER);
    AddConstant('SIID_FOLDEROPEN',SIID_FOLDEROPEN);
    AddConstant('SIID_DRIVE525',SIID_DRIVE525);
    AddConstant('SIID_DRIVE35',SIID_DRIVE35);
    AddConstant('SIID_DRIVEREMOVE',SIID_DRIVEREMOVE);
    AddConstant('SIID_DRIVEFIXED',SIID_DRIVEFIXED);
    AddConstant('SIID_DRIVENET',SIID_DRIVENET);
    AddConstant('SIID_DRIVENETDISABLED',SIID_DRIVENETDISABLED);
    AddConstant('SIID_DRIVECD',SIID_DRIVECD);
    AddConstant('SIID_DRIVERAM',SIID_DRIVERAM);
    AddConstant('SIID_WORLD',SIID_WORLD);
    AddConstant('SIID_SERVER',SIID_SERVER);
    AddConstant('SIID_PRINTER',SIID_PRINTER);
    AddConstant('SIID_MYNETWORK',SIID_MYNETWORK);
    AddConstant('SIID_FIND',SIID_FIND);
    AddConstant('SIID_HELP',SIID_HELP);
    AddConstant('SIID_SHARE',SIID_SHARE);
    AddConstant('SIID_LINK',SIID_LINK);
    AddConstant('SIID_SLOWFILE',SIID_SLOWFILE);
    AddConstant('SIID_RECYCLER',SIID_RECYCLER);
    AddConstant('SIID_RECYCLERFULL',SIID_RECYCLERFULL);
    AddConstant('SIID_MEDIACDAUDIO',SIID_MEDIACDAUDIO);
    AddConstant('SIID_LOCK',SIID_LOCK);
    AddConstant('SIID_AUTOLIST',SIID_AUTOLIST);
    AddConstant('SIID_PRINTERNET',SIID_PRINTERNET);
    AddConstant('SIID_SERVERSHARE',SIID_SERVERSHARE);
    AddConstant('SIID_PRINTERFAX',SIID_PRINTERFAX);
    AddConstant('SIID_PRINTERFAXNET',SIID_PRINTERFAXNET);
    AddConstant('SIID_PRINTERFILE',SIID_PRINTERFILE);
    AddConstant('SIID_STACK',SIID_STACK);
    AddConstant('SIID_MEDIASVCD',SIID_MEDIASVCD);
    AddConstant('SIID_STUFFEDFOLDER',SIID_STUFFEDFOLDER);
    AddConstant('SIID_DRIVEUNKNOWN',SIID_DRIVEUNKNOWN);
    AddConstant('SIID_DRIVEDVD',SIID_DRIVEDVD);
    AddConstant('SIID_MEDIADVD',SIID_MEDIADVD);
    AddConstant('SIID_MEDIADVDRAM',SIID_MEDIADVDRAM);
    AddConstant('SIID_MEDIADVDRW',SIID_MEDIADVDRW);
    AddConstant('SIID_MEDIADVDR',SIID_MEDIADVDR);
    AddConstant('SIID_MEDIADVDROM',SIID_MEDIADVDROM);
    AddConstant('SIID_MEDIACDAUDIOPLUS',SIID_MEDIACDAUDIOPLUS);
    AddConstant('SIID_MEDIACDRW',SIID_MEDIACDRW);
    AddConstant('SIID_MEDIACDR',SIID_MEDIACDR);
    AddConstant('SIID_MEDIACDBURN',SIID_MEDIACDBURN);
    AddConstant('SIID_MEDIABLANKCD',SIID_MEDIABLANKCD);
    AddConstant('SIID_MEDIACDROM',SIID_MEDIACDROM);
    AddConstant('SIID_AUDIOFILES',SIID_AUDIOFILES);
    AddConstant('SIID_IMAGEFILES',SIID_IMAGEFILES);
    AddConstant('SIID_VIDEOFILES',SIID_VIDEOFILES);
    AddConstant('SIID_MIXEDFILES',SIID_MIXEDFILES);
    AddConstant('SIID_FOLDERBACK',SIID_FOLDERBACK);
    AddConstant('SIID_FOLDERFRONT',SIID_FOLDERFRONT);
    AddConstant('SIID_SHIELD',SIID_SHIELD);
    AddConstant('SIID_WARNING',SIID_WARNING);
    AddConstant('SIID_INFO',SIID_INFO);
    AddConstant('SIID_ERROR',SIID_ERROR);
    AddConstant('SIID_KEY',SIID_KEY);
    AddConstant('SIID_SOFTWARE',SIID_SOFTWARE);
    AddConstant('SIID_RENAME',SIID_RENAME);
    AddConstant('SIID_DELETE',SIID_DELETE);
    AddConstant('SIID_MEDIAAUDIODVD',SIID_MEDIAAUDIODVD);
    AddConstant('SIID_MEDIAMOVIEDVD',SIID_MEDIAMOVIEDVD);
    AddConstant('SIID_MEDIAENHANCEDCD',SIID_MEDIAENHANCEDCD);
    AddConstant('SIID_MEDIAENHANCEDDVD',SIID_MEDIAENHANCEDDVD);
    AddConstant('SIID_MEDIAHDDVD',SIID_MEDIAHDDVD);
    AddConstant('SIID_MEDIABLURAY',SIID_MEDIABLURAY);
    AddConstant('SIID_MEDIAVCD',SIID_MEDIAVCD);
    AddConstant('SIID_MEDIADVDPLUSR',SIID_MEDIADVDPLUSR);
    AddConstant('SIID_MEDIADVDPLUSRW',SIID_MEDIADVDPLUSRW);
    AddConstant('SIID_DESKTOPPC',SIID_DESKTOPPC);
    AddConstant('SIID_MOBILEPC',SIID_MOBILEPC);
    AddConstant('SIID_USERS',SIID_USERS);
    AddConstant('SIID_MEDIASMARTMEDIA',SIID_MEDIASMARTMEDIA);
    AddConstant('SIID_MEDIACOMPACTFLASH',SIID_MEDIACOMPACTFLASH);
    AddConstant('SIID_DEVICECELLPHONE',SIID_DEVICECELLPHONE);
    AddConstant('SIID_DEVICECAMERA',SIID_DEVICECAMERA);
    AddConstant('SIID_DEVICEVIDEOCAMERA',SIID_DEVICEVIDEOCAMERA);
    AddConstant('SIID_DEVICEAUDIOPLAYER',SIID_DEVICEAUDIOPLAYER);
    AddConstant('SIID_NETWORKCONNECT',SIID_NETWORKCONNECT);
    AddConstant('SIID_INTERNET',SIID_INTERNET);
    AddConstant('SIID_ZIPFILE',SIID_ZIPFILE);
    AddConstant('SIID_SETTINGS',SIID_SETTINGS);
    AddConstant('SIID_DRIVEHDDVD',SIID_DRIVEHDDVD);
    AddConstant('SIID_DRIVEBD',SIID_DRIVEBD);
    AddConstant('SIID_MEDIAHDDVDROM',SIID_MEDIAHDDVDROM);
    AddConstant('SIID_MEDIAHDDVDR',SIID_MEDIAHDDVDR);
    AddConstant('SIID_MEDIAHDDVDRAM',SIID_MEDIAHDDVDRAM);
    AddConstant('SIID_MEDIABDROM',SIID_MEDIABDROM);
    AddConstant('SIID_MEDIABDR',SIID_MEDIABDR);
    AddConstant('SIID_MEDIABDRE',SIID_MEDIABDRE);
    AddConstant('SIID_CLUSTEREDDRIVE',SIID_CLUSTEREDDRIVE);
    AddConstant('SIID_MAX_ICONS',SIID_MAX_ICONS);
    AddConstant('SIID_INVALID',SIID_INVALID);
    AddConstant('SHGNLI_PIDL',SHGNLI_PIDL);
    AddConstant('SHGNLI_PREFIXNAME',SHGNLI_PREFIXNAME);
    AddConstant('SHGNLI_NOUNIQUE',SHGNLI_NOUNIQUE);
    AddConstant('SHGNLI_NOLNK',SHGNLI_NOLNK);
    AddConstant('SHGNLI_NOLOCNAME',SHGNLI_NOLOCNAME);
    AddConstant('SHGNLI_USEURLEXT',SHGNLI_USEURLEXT);
    AddConstant('PRINTACTION_OPEN',PRINTACTION_OPEN);
    AddConstant('PRINTACTION_PROPERTIES',PRINTACTION_PROPERTIES);
    AddConstant('PRINTACTION_NETINSTALL',PRINTACTION_NETINSTALL);
    AddConstant('PRINTACTION_NETINSTALLLINK',PRINTACTION_NETINSTALLLINK);
    AddConstant('PRINTACTION_TESTPAGE',PRINTACTION_TESTPAGE);
    AddConstant('PRINTACTION_OPENNETPRN',PRINTACTION_OPENNETPRN);
    AddConstant('PRINTACTION_DOCUMENTDEFAULTS',PRINTACTION_DOCUMENTDEFAULTS);
    AddConstant('PRINTACTION_SERVERPROPERTIES',PRINTACTION_SERVERPROPERTIES);
    AddConstant('PRINT_PROP_FORCE_NAME',PRINT_PROP_FORCE_NAME);
    AddConstant('shell32',shell32);
    AddConstant('OFFLINE_STATUS_LOCAL',OFFLINE_STATUS_LOCAL);
    AddConstant('OFFLINE_STATUS_REMOTE',OFFLINE_STATUS_REMOTE);
    AddConstant('OFFLINE_STATUS_INCOMPLETE',OFFLINE_STATUS_INCOMPLETE);
    AddConstant('SHIL_LARGE',SHIL_LARGE);
    AddConstant('SHIL_SMALL',SHIL_SMALL);
    AddConstant('SHIL_EXTRALARGE',SHIL_EXTRALARGE);
    AddConstant('SHIL_SYSSMALL',SHIL_SYSSMALL);
    AddConstant('SHIL_JUMBO',SHIL_JUMBO);
    AddConstant('SHIL_LAST',SHIL_LAST);
    AddConstant('WC_NETADDRESS',WC_NETADDRESS);
    AddConstant('NCM_GETADDRESS',NCM_GETADDRESS);
    AddConstant('NCM_SETALLOWTYPE',NCM_SETALLOWTYPE);
    AddConstant('NCM_GETALLOWTYPE',NCM_GETALLOWTYPE);
    AddConstant('NCM_DISPLAYERRORTIP',NCM_DISPLAYERRORTIP);
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

