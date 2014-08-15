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
unit ap_ShlObj;

interface

uses
  Windows,
  ActiveX,
  CommCtrl,
  ShellAPI,
  RegStr,
  Messages,
  WinInet,
  UrlMon,
  ShlObj,
  Variants,
  ap_System,
  ap_UrlMon,
  atScript;

{$WARNINGS OFF}

type
  TatShlObjLibrary = class(TatScripterLibrary)
    procedure __SHGetSpecialFolderPath(AMachine: TatVirtualMachine);
    procedure __SHGetSpecialFolderPathA(AMachine: TatVirtualMachine);
    procedure __SHGetSpecialFolderPathW(AMachine: TatVirtualMachine);
    procedure __SHLoadInProc(AMachine: TatVirtualMachine);
    procedure __SHGetSettings(AMachine: TatVirtualMachine);
    procedure __SHCreateItemInKnownFolder(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellDesktop(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShellLink(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ActiveDesktop(AMachine: TatVirtualMachine);
    procedure __GetCLSID_DragDropHelper(AMachine: TatVirtualMachine);
    procedure __GetFMTID_Intshcut(AMachine: TatVirtualMachine);
    procedure __GetFMTID_InternetSite(AMachine: TatVirtualMachine);
    procedure __GetCGID_Explorer(AMachine: TatVirtualMachine);
    procedure __GetCGID_ShellDocView(AMachine: TatVirtualMachine);
    procedure __GetIID_INewShortcutHookA(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellBrowser(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellView(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenu(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellIcon(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellExtInit(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellPropSheetExt(AMachine: TatVirtualMachine);
    procedure __GetIID_IPersistFolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IExtractIconA(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkA(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellCopyHookA(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileViewerA(AMachine: TatVirtualMachine);
    procedure __GetIID_ICommDlgBrowser(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumIDList(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileViewerSite(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextMenu2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellExecuteHook(AMachine: TatVirtualMachine);
    procedure __GetIID_IPropSheetPage(AMachine: TatVirtualMachine);
    procedure __GetIID_INewShortcutHookW(AMachine: TatVirtualMachine);
    procedure __GetIID_IFileViewerW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellLinkW(AMachine: TatVirtualMachine);
    procedure __GetIID_IExtractIconW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellExecuteHookW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellCopyHookW(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellView2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellFolder2(AMachine: TatVirtualMachine);
    procedure __GetIID_IShellDetails(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumExtraSearch(AMachine: TatVirtualMachine);
    procedure __GetIID_IDropTargetHelper(AMachine: TatVirtualMachine);
    procedure __GetIID_IDragSourceHelper(AMachine: TatVirtualMachine);
    procedure __GetCLSID_AutoComplete(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ShelllItem(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileOpenDialog(AMachine: TatVirtualMachine);
    procedure __GetCLSID_FileSaveDialog(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _SHITEMIDWrapper = class(TatRecordWrapper)
  private
    Fcb: Word;
  public
    constructor Create(ARecord: _SHITEMID);
    function ObjToRec: _SHITEMID;
  published
    property cb: Word read Fcb write Fcb;
  end;
  
  _ITEMIDLISTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _ITEMIDLIST);
    function ObjToRec: _ITEMIDLIST;
  published
  end;
  
  _CMINVOKECOMMANDINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: DWORD;
    Fhwnd: HWND;
    FnShow: Integer;
    FdwHotKey: DWORD;
    FhIcon: THandle;
  public
    constructor Create(ARecord: _CMINVOKECOMMANDINFO);
    function ObjToRec: _CMINVOKECOMMANDINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: DWORD read FfMask write FfMask;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property nShow: Integer read FnShow write FnShow;
    property dwHotKey: DWORD read FdwHotKey write FdwHotKey;
    property hIcon: THandle read FhIcon write FhIcon;
  end;
  
  _CMINVOKECOMMANDINFOEXWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: DWORD;
    Fhwnd: HWND;
    FnShow: Integer;
    FdwHotKey: DWORD;
    FhIcon: THandle;
  public
    constructor Create(ARecord: _CMINVOKECOMMANDINFOEX);
    function ObjToRec: _CMINVOKECOMMANDINFOEX;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: DWORD read FfMask write FfMask;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property nShow: Integer read FnShow write FnShow;
    property dwHotKey: DWORD read FdwHotKey write FdwHotKey;
    property hIcon: THandle read FhIcon write FhIcon;
  end;
  
  FVSHOWINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhwndOwner: HWND;
    FiShow: Integer;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: FVSHOWINFO);
    function ObjToRec: FVSHOWINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property iShow: Integer read FiShow write FiShow;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  FOLDERSETTINGSWrapper = class(TatRecordWrapper)
  private
    FViewMode: UINT;
    FfFlags: UINT;
  public
    constructor Create(ARecord: FOLDERSETTINGS);
    function ObjToRec: FOLDERSETTINGS;
  published
    property ViewMode: UINT read FViewMode write FViewMode;
    property fFlags: UINT read FfFlags write FfFlags;
  end;
  
  _SV2CVW2_PARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhwndView: HWND;
  public
    constructor Create(ARecord: _SV2CVW2_PARAMS);
    function ObjToRec: _SV2CVW2_PARAMS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwndView: HWND read FhwndView write FhwndView;
  end;
  
  _STRRETWrapper = class(TatRecordWrapper)
  private
    FuType: UINT;
    FuOffset: UINT;
  public
    constructor Create(ARecord: _STRRET);
    function ObjToRec: _STRRET;
  published
    property uType: UINT read FuType write FuType;
    property uOffset: UINT read FuOffset write FuOffset;
  end;
  
  _SHELLDETAILSWrapper = class(TatRecordWrapper)
  private
    Ffmt: Integer;
    FcxChar: Integer;
  public
    constructor Create(ARecord: _SHELLDETAILS);
    function ObjToRec: _SHELLDETAILS;
  published
    property fmt: Integer read Ffmt write Ffmt;
    property cxChar: Integer read FcxChar write FcxChar;
  end;
  
  _browseinfoAWrapper = class(TatRecordWrapper)
  private
    FhwndOwner: HWND;
    FulFlags: UINT;
    FlParam: LPARAM;
    FiImage: Integer;
  public
    constructor Create(ARecord: _browseinfoA);
    function ObjToRec: _browseinfoA;
  published
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property ulFlags: UINT read FulFlags write FulFlags;
    property lParam: LPARAM read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  _browseinfoWWrapper = class(TatRecordWrapper)
  private
    FhwndOwner: HWND;
    FulFlags: UINT;
    FlParam: LPARAM;
    FiImage: Integer;
  public
    constructor Create(ARecord: _browseinfoW);
    function ObjToRec: _browseinfoW;
  published
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property ulFlags: UINT read FulFlags write FulFlags;
    property lParam: LPARAM read FlParam write FlParam;
    property iImage: Integer read FiImage write FiImage;
  end;
  
  tagExtraSearchWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagExtraSearch);
    function ObjToRec: tagExtraSearch;
  published
  end;
  
  SHCOLUMNIDWrapper = class(TatRecordWrapper)
  private
    Fpid: DWORD;
  public
    constructor Create(ARecord: SHCOLUMNID);
    function ObjToRec: SHCOLUMNID;
  published
    property pid: DWORD read Fpid write Fpid;
  end;
  
  DESKBANDINFOWrapper = class(TatRecordWrapper)
  private
    FdwMask: DWORD;
    FdwModeFlags: DWORD;
    FcrBkgnd: COLORREF;
  public
    constructor Create(ARecord: DESKBANDINFO);
    function ObjToRec: DESKBANDINFO;
  published
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwModeFlags: DWORD read FdwModeFlags write FdwModeFlags;
    property crBkgnd: COLORREF read FcrBkgnd write FcrBkgnd;
  end;
  
  _tagWALLPAPEROPTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwStyle: DWORD;
  public
    constructor Create(ARecord: _tagWALLPAPEROPT);
    function ObjToRec: _tagWALLPAPEROPT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
  end;
  
  _tagCOMPONENTSOPTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FfEnableComponents: BOOL;
    FfActiveDesktop: BOOL;
  public
    constructor Create(ARecord: _tagCOMPONENTSOPT);
    function ObjToRec: _tagCOMPONENTSOPT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property fEnableComponents: BOOL read FfEnableComponents write FfEnableComponents;
    property fActiveDesktop: BOOL read FfActiveDesktop write FfActiveDesktop;
  end;
  
  _tagCOMPPOSWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FiLeft: Integer;
    FiTop: Integer;
    FdwWidth: DWORD;
    FdwHeight: DWORD;
    FizIndex: Integer;
    FfCanResize: BOOL;
    FfCanResizeX: BOOL;
    FfCanResizeY: BOOL;
    FiPreferredLeftPercent: Integer;
    FiPreferredTopPercent: Integer;
  public
    constructor Create(ARecord: _tagCOMPPOS);
    function ObjToRec: _tagCOMPPOS;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property iLeft: Integer read FiLeft write FiLeft;
    property iTop: Integer read FiTop write FiTop;
    property dwWidth: DWORD read FdwWidth write FdwWidth;
    property dwHeight: DWORD read FdwHeight write FdwHeight;
    property izIndex: Integer read FizIndex write FizIndex;
    property fCanResize: BOOL read FfCanResize write FfCanResize;
    property fCanResizeX: BOOL read FfCanResizeX write FfCanResizeX;
    property fCanResizeY: BOOL read FfCanResizeY write FfCanResizeY;
    property iPreferredLeftPercent: Integer read FiPreferredLeftPercent write FiPreferredLeftPercent;
    property iPreferredTopPercent: Integer read FiPreferredTopPercent write FiPreferredTopPercent;
  end;
  
  _tagCOMPONENTWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FdwID: DWORD;
    FiComponentType: Integer;
    FfChecked: BOOL;
    FfDirty: BOOL;
    FfNoScroll: BOOL;
  public
    constructor Create(ARecord: _tagCOMPONENT);
    function ObjToRec: _tagCOMPONENT;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property dwID: DWORD read FdwID write FdwID;
    property iComponentType: Integer read FiComponentType write FiComponentType;
    property fChecked: BOOL read FfChecked write FfChecked;
    property fDirty: BOOL read FfDirty write FfDirty;
    property fNoScroll: BOOL read FfNoScroll write FfNoScroll;
  end;
  
  _NRESARRAYWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
  public
    constructor Create(ARecord: _NRESARRAY);
    function ObjToRec: _NRESARRAY;
  published
    property cItems: UINT read FcItems write FcItems;
  end;
  
  _IDAWrapper = class(TatRecordWrapper)
  private
    Fcidl: UINT;
  public
    constructor Create(ARecord: _IDA);
    function ObjToRec: _IDA;
  published
    property cidl: UINT read Fcidl write Fcidl;
  end;
  
  _FILEDESCRIPTORAWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
  public
    constructor Create(ARecord: _FILEDESCRIPTORA);
    function ObjToRec: _FILEDESCRIPTORA;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
  end;
  
  _FILEDESCRIPTORWWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
  public
    constructor Create(ARecord: _FILEDESCRIPTORW);
    function ObjToRec: _FILEDESCRIPTORW;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
  end;
  
  _FILEGROUPDESCRIPTORAWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
  public
    constructor Create(ARecord: _FILEGROUPDESCRIPTORA);
    function ObjToRec: _FILEGROUPDESCRIPTORA;
  published
    property cItems: UINT read FcItems write FcItems;
  end;
  
  _FILEGROUPDESCRIPTORWWrapper = class(TatRecordWrapper)
  private
    FcItems: UINT;
  public
    constructor Create(ARecord: _FILEGROUPDESCRIPTORW);
    function ObjToRec: _FILEGROUPDESCRIPTORW;
  published
    property cItems: UINT read FcItems write FcItems;
  end;
  
  _DROPFILESWrapper = class(TatRecordWrapper)
  private
    FpFiles: DWORD;
    FfNC: BOOL;
    FfWide: BOOL;
  public
    constructor Create(ARecord: _DROPFILES);
    function ObjToRec: _DROPFILES;
  published
    property pFiles: DWORD read FpFiles write FpFiles;
    property fNC: BOOL read FfNC write FfNC;
    property fWide: BOOL read FfWide write FfWide;
  end;
  
  SHDRAGIMAGEWrapper = class(TatRecordWrapper)
  private
    FhbmpDragImage: HBITMAP;
    FcrColorKey: COLORREF;
  public
    constructor Create(ARecord: SHDRAGIMAGE);
    function ObjToRec: SHDRAGIMAGE;
  published
    property hbmpDragImage: HBITMAP read FhbmpDragImage write FhbmpDragImage;
    property crColorKey: COLORREF read FcrColorKey write FcrColorKey;
  end;
  
  _SHDESCRIPTIONIDWrapper = class(TatRecordWrapper)
  private
    FdwDescriptionId: DWORD;
  public
    constructor Create(ARecord: _SHDESCRIPTIONID);
    function ObjToRec: _SHDESCRIPTIONID;
  published
    property dwDescriptionId: DWORD read FdwDescriptionId write FdwDescriptionId;
  end;
  
  SHELLFLAGSTATEWrapper = class(TatRecordWrapper)
  private
    FData: Word;
  public
    constructor Create(ARecord: SHELLFLAGSTATE);
    function ObjToRec: SHELLFLAGSTATE;
  published
    property Data: Word read FData write FData;
  end;
  
  _COMDLG_FILTERSPECWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _COMDLG_FILTERSPEC);
    function ObjToRec: _COMDLG_FILTERSPEC;
  published
  end;
  
  tagMACHINE_IDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagMACHINE_ID);
    function ObjToRec: tagMACHINE_ID;
  published
  end;
  
  tagDOMAIN_RELATIVE_OBJECTIDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagDOMAIN_RELATIVE_OBJECTID);
    function ObjToRec: tagDOMAIN_RELATIVE_OBJECTID;
  published
  end;
  

implementation

constructor _SHITEMIDWrapper.Create(ARecord: _SHITEMID);
begin
  inherited Create;
  Fcb := ARecord.cb;
end;

function _SHITEMIDWrapper.ObjToRec: _SHITEMID;
begin
  result.cb := Fcb;
end;

constructor _ITEMIDLISTWrapper.Create(ARecord: _ITEMIDLIST);
begin
  inherited Create;
end;

function _ITEMIDLISTWrapper.ObjToRec: _ITEMIDLIST;
begin
end;

constructor _CMINVOKECOMMANDINFOWrapper.Create(ARecord: _CMINVOKECOMMANDINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  Fhwnd := ARecord.hwnd;
  FnShow := ARecord.nShow;
  FdwHotKey := ARecord.dwHotKey;
  FhIcon := ARecord.hIcon;
end;

function _CMINVOKECOMMANDINFOWrapper.ObjToRec: _CMINVOKECOMMANDINFO;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.hwnd := Fhwnd;
  result.nShow := FnShow;
  result.dwHotKey := FdwHotKey;
  result.hIcon := FhIcon;
end;

constructor _CMINVOKECOMMANDINFOEXWrapper.Create(ARecord: _CMINVOKECOMMANDINFOEX);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  Fhwnd := ARecord.hwnd;
  FnShow := ARecord.nShow;
  FdwHotKey := ARecord.dwHotKey;
  FhIcon := ARecord.hIcon;
end;

function _CMINVOKECOMMANDINFOEXWrapper.ObjToRec: _CMINVOKECOMMANDINFOEX;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.hwnd := Fhwnd;
  result.nShow := FnShow;
  result.dwHotKey := FdwHotKey;
  result.hIcon := FhIcon;
end;

constructor FVSHOWINFOWrapper.Create(ARecord: FVSHOWINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhwndOwner := ARecord.hwndOwner;
  FiShow := ARecord.iShow;
  FdwFlags := ARecord.dwFlags;
end;

function FVSHOWINFOWrapper.ObjToRec: FVSHOWINFO;
begin
  result.cbSize := FcbSize;
  result.hwndOwner := FhwndOwner;
  result.iShow := FiShow;
  result.dwFlags := FdwFlags;
end;

constructor FOLDERSETTINGSWrapper.Create(ARecord: FOLDERSETTINGS);
begin
  inherited Create;
  FViewMode := ARecord.ViewMode;
  FfFlags := ARecord.fFlags;
end;

function FOLDERSETTINGSWrapper.ObjToRec: FOLDERSETTINGS;
begin
  result.ViewMode := FViewMode;
  result.fFlags := FfFlags;
end;

constructor _SV2CVW2_PARAMSWrapper.Create(ARecord: _SV2CVW2_PARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhwndView := ARecord.hwndView;
end;

function _SV2CVW2_PARAMSWrapper.ObjToRec: _SV2CVW2_PARAMS;
begin
  result.cbSize := FcbSize;
  result.hwndView := FhwndView;
end;

constructor _STRRETWrapper.Create(ARecord: _STRRET);
begin
  inherited Create;
  FuType := ARecord.uType;
  FuOffset := ARecord.uOffset;
end;

function _STRRETWrapper.ObjToRec: _STRRET;
begin
  result.uType := FuType;
  result.uOffset := FuOffset;
end;

constructor _SHELLDETAILSWrapper.Create(ARecord: _SHELLDETAILS);
begin
  inherited Create;
  Ffmt := ARecord.fmt;
  FcxChar := ARecord.cxChar;
end;

function _SHELLDETAILSWrapper.ObjToRec: _SHELLDETAILS;
begin
  result.fmt := Ffmt;
  result.cxChar := FcxChar;
end;

constructor _browseinfoAWrapper.Create(ARecord: _browseinfoA);
begin
  inherited Create;
  FhwndOwner := ARecord.hwndOwner;
  FulFlags := ARecord.ulFlags;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
end;

function _browseinfoAWrapper.ObjToRec: _browseinfoA;
begin
  result.hwndOwner := FhwndOwner;
  result.ulFlags := FulFlags;
  result.lParam := FlParam;
  result.iImage := FiImage;
end;

constructor _browseinfoWWrapper.Create(ARecord: _browseinfoW);
begin
  inherited Create;
  FhwndOwner := ARecord.hwndOwner;
  FulFlags := ARecord.ulFlags;
  FlParam := ARecord.lParam;
  FiImage := ARecord.iImage;
end;

function _browseinfoWWrapper.ObjToRec: _browseinfoW;
begin
  result.hwndOwner := FhwndOwner;
  result.ulFlags := FulFlags;
  result.lParam := FlParam;
  result.iImage := FiImage;
end;

constructor tagExtraSearchWrapper.Create(ARecord: tagExtraSearch);
begin
  inherited Create;
end;

function tagExtraSearchWrapper.ObjToRec: tagExtraSearch;
begin
end;

constructor SHCOLUMNIDWrapper.Create(ARecord: SHCOLUMNID);
begin
  inherited Create;
  Fpid := ARecord.pid;
end;

function SHCOLUMNIDWrapper.ObjToRec: SHCOLUMNID;
begin
  result.pid := Fpid;
end;

constructor DESKBANDINFOWrapper.Create(ARecord: DESKBANDINFO);
begin
  inherited Create;
  FdwMask := ARecord.dwMask;
  FdwModeFlags := ARecord.dwModeFlags;
  FcrBkgnd := ARecord.crBkgnd;
end;

function DESKBANDINFOWrapper.ObjToRec: DESKBANDINFO;
begin
  result.dwMask := FdwMask;
  result.dwModeFlags := FdwModeFlags;
  result.crBkgnd := FcrBkgnd;
end;

constructor _tagWALLPAPEROPTWrapper.Create(ARecord: _tagWALLPAPEROPT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwStyle := ARecord.dwStyle;
end;

function _tagWALLPAPEROPTWrapper.ObjToRec: _tagWALLPAPEROPT;
begin
  result.dwSize := FdwSize;
  result.dwStyle := FdwStyle;
end;

constructor _tagCOMPONENTSOPTWrapper.Create(ARecord: _tagCOMPONENTSOPT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FfEnableComponents := ARecord.fEnableComponents;
  FfActiveDesktop := ARecord.fActiveDesktop;
end;

function _tagCOMPONENTSOPTWrapper.ObjToRec: _tagCOMPONENTSOPT;
begin
  result.dwSize := FdwSize;
  result.fEnableComponents := FfEnableComponents;
  result.fActiveDesktop := FfActiveDesktop;
end;

constructor _tagCOMPPOSWrapper.Create(ARecord: _tagCOMPPOS);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FiLeft := ARecord.iLeft;
  FiTop := ARecord.iTop;
  FdwWidth := ARecord.dwWidth;
  FdwHeight := ARecord.dwHeight;
  FizIndex := ARecord.izIndex;
  FfCanResize := ARecord.fCanResize;
  FfCanResizeX := ARecord.fCanResizeX;
  FfCanResizeY := ARecord.fCanResizeY;
  FiPreferredLeftPercent := ARecord.iPreferredLeftPercent;
  FiPreferredTopPercent := ARecord.iPreferredTopPercent;
end;

function _tagCOMPPOSWrapper.ObjToRec: _tagCOMPPOS;
begin
  result.dwSize := FdwSize;
  result.iLeft := FiLeft;
  result.iTop := FiTop;
  result.dwWidth := FdwWidth;
  result.dwHeight := FdwHeight;
  result.izIndex := FizIndex;
  result.fCanResize := FfCanResize;
  result.fCanResizeX := FfCanResizeX;
  result.fCanResizeY := FfCanResizeY;
  result.iPreferredLeftPercent := FiPreferredLeftPercent;
  result.iPreferredTopPercent := FiPreferredTopPercent;
end;

constructor _tagCOMPONENTWrapper.Create(ARecord: _tagCOMPONENT);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FdwID := ARecord.dwID;
  FiComponentType := ARecord.iComponentType;
  FfChecked := ARecord.fChecked;
  FfDirty := ARecord.fDirty;
  FfNoScroll := ARecord.fNoScroll;
end;

function _tagCOMPONENTWrapper.ObjToRec: _tagCOMPONENT;
begin
  result.dwSize := FdwSize;
  result.dwID := FdwID;
  result.iComponentType := FiComponentType;
  result.fChecked := FfChecked;
  result.fDirty := FfDirty;
  result.fNoScroll := FfNoScroll;
end;

constructor _NRESARRAYWrapper.Create(ARecord: _NRESARRAY);
begin
  inherited Create;
  FcItems := ARecord.cItems;
end;

function _NRESARRAYWrapper.ObjToRec: _NRESARRAY;
begin
  result.cItems := FcItems;
end;

constructor _IDAWrapper.Create(ARecord: _IDA);
begin
  inherited Create;
  Fcidl := ARecord.cidl;
end;

function _IDAWrapper.ObjToRec: _IDA;
begin
  result.cidl := Fcidl;
end;

constructor _FILEDESCRIPTORAWrapper.Create(ARecord: _FILEDESCRIPTORA);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
end;

function _FILEDESCRIPTORAWrapper.ObjToRec: _FILEDESCRIPTORA;
begin
  result.dwFlags := FdwFlags;
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
end;

constructor _FILEDESCRIPTORWWrapper.Create(ARecord: _FILEDESCRIPTORW);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
end;

function _FILEDESCRIPTORWWrapper.ObjToRec: _FILEDESCRIPTORW;
begin
  result.dwFlags := FdwFlags;
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
end;

constructor _FILEGROUPDESCRIPTORAWrapper.Create(ARecord: _FILEGROUPDESCRIPTORA);
begin
  inherited Create;
  FcItems := ARecord.cItems;
end;

function _FILEGROUPDESCRIPTORAWrapper.ObjToRec: _FILEGROUPDESCRIPTORA;
begin
  result.cItems := FcItems;
end;

constructor _FILEGROUPDESCRIPTORWWrapper.Create(ARecord: _FILEGROUPDESCRIPTORW);
begin
  inherited Create;
  FcItems := ARecord.cItems;
end;

function _FILEGROUPDESCRIPTORWWrapper.ObjToRec: _FILEGROUPDESCRIPTORW;
begin
  result.cItems := FcItems;
end;

constructor _DROPFILESWrapper.Create(ARecord: _DROPFILES);
begin
  inherited Create;
  FpFiles := ARecord.pFiles;
  FfNC := ARecord.fNC;
  FfWide := ARecord.fWide;
end;

function _DROPFILESWrapper.ObjToRec: _DROPFILES;
begin
  result.pFiles := FpFiles;
  result.fNC := FfNC;
  result.fWide := FfWide;
end;

constructor SHDRAGIMAGEWrapper.Create(ARecord: SHDRAGIMAGE);
begin
  inherited Create;
  FhbmpDragImage := ARecord.hbmpDragImage;
  FcrColorKey := ARecord.crColorKey;
end;

function SHDRAGIMAGEWrapper.ObjToRec: SHDRAGIMAGE;
begin
  result.hbmpDragImage := FhbmpDragImage;
  result.crColorKey := FcrColorKey;
end;

constructor _SHDESCRIPTIONIDWrapper.Create(ARecord: _SHDESCRIPTIONID);
begin
  inherited Create;
  FdwDescriptionId := ARecord.dwDescriptionId;
end;

function _SHDESCRIPTIONIDWrapper.ObjToRec: _SHDESCRIPTIONID;
begin
  result.dwDescriptionId := FdwDescriptionId;
end;

constructor SHELLFLAGSTATEWrapper.Create(ARecord: SHELLFLAGSTATE);
begin
  inherited Create;
  FData := ARecord.Data;
end;

function SHELLFLAGSTATEWrapper.ObjToRec: SHELLFLAGSTATE;
begin
  result.Data := FData;
end;

constructor _COMDLG_FILTERSPECWrapper.Create(ARecord: _COMDLG_FILTERSPEC);
begin
  inherited Create;
end;

function _COMDLG_FILTERSPECWrapper.ObjToRec: _COMDLG_FILTERSPEC;
begin
end;

constructor tagMACHINE_IDWrapper.Create(ARecord: tagMACHINE_ID);
begin
  inherited Create;
end;

function tagMACHINE_IDWrapper.ObjToRec: tagMACHINE_ID;
begin
end;

constructor tagDOMAIN_RELATIVE_OBJECTIDWrapper.Create(ARecord: tagDOMAIN_RELATIVE_OBJECTID);
begin
  inherited Create;
end;

function tagDOMAIN_RELATIVE_OBJECTIDWrapper.ObjToRec: tagDOMAIN_RELATIVE_OBJECTID;
begin
end;



procedure TatShlObjLibrary.__SHGetSpecialFolderPath(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetSpecialFolderPath(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetSpecialFolderPathA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetSpecialFolderPathA(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetSpecialFolderPathW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ShlObj.SHGetSpecialFolderPathW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHLoadInProc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ShlObj.SHLoadInProc(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatShlObjLibrary.__SHGetSettings(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TShellFlagState;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is SHELLFLAGSTATEWrapper) then 
  Param0Rec := SHELLFLAGSTATEWrapper.Create(Param0);
Param0 := SHELLFLAGSTATEWrapper(Param0Rec).ObjToRec;
    ShlObj.SHGetSettings(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,integer(SHELLFLAGSTATEWrapper.Create(Param0)));
  end;
end;

procedure TatShlObjLibrary.__SHCreateItemInKnownFolder(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param4: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(ShlObj.SHCreateItemInKnownFolder(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),TGUIDWrapper(integer(GetInputArg(3))).ObjToRec,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellDesktop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellDesktop)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShellLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShellLink)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ActiveDesktop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ActiveDesktop)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_DragDropHelper(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_DragDropHelper)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_Intshcut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_Intshcut)));
  end;
end;

procedure TatShlObjLibrary.__GetFMTID_InternetSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.FMTID_InternetSite)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_Explorer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_Explorer)));
  end;
end;

procedure TatShlObjLibrary.__GetCGID_ShellDocView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CGID_ShellDocView)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewShortcutHookA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewShortcutHookA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellView)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenu)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellIcon)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellExtInit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellExtInit)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellPropSheetExt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellPropSheetExt)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPersistFolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPersistFolder)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExtractIconA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExtractIconA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellCopyHookA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellCopyHookA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileViewerA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileViewerA)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_ICommDlgBrowser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_ICommDlgBrowser)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumIDList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumIDList)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileViewerSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileViewerSite)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IContextMenu2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IContextMenu2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellExecuteHook(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellExecuteHook)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IPropSheetPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IPropSheetPage)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_INewShortcutHookW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_INewShortcutHookW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IFileViewerW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IFileViewerW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellLinkW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellLinkW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IExtractIconW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IExtractIconW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellExecuteHookW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellExecuteHookW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellCopyHookW(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellCopyHookW)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellView2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellView2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellFolder2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellFolder2)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IShellDetails(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IShellDetails)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IEnumExtraSearch(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IEnumExtraSearch)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDropTargetHelper(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDropTargetHelper)));
  end;
end;

procedure TatShlObjLibrary.__GetIID_IDragSourceHelper(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.IID_IDragSourceHelper)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_AutoComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_AutoComplete)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_ShelllItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_ShelllItem)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileOpenDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileOpenDialog)));
  end;
end;

procedure TatShlObjLibrary.__GetCLSID_FileSaveDialog(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ShlObj.CLSID_FileSaveDialog)));
  end;
end;

procedure TatShlObjLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('SHGetSpecialFolderPath',4,tkVariant,nil,__SHGetSpecialFolderPath,false,0);
    DefineMethod('SHGetSpecialFolderPathA',4,tkVariant,nil,__SHGetSpecialFolderPathA,false,0);
    DefineMethod('SHGetSpecialFolderPathW',4,tkVariant,nil,__SHGetSpecialFolderPathW,false,0);
    DefineMethod('SHLoadInProc',1,tkInteger,nil,__SHLoadInProc,false,0);
    DefineMethod('SHGetSettings',2,tkNone,nil,__SHGetSettings,false,0).SetVarArgs([0]);
    DefineMethod('SHCreateItemInKnownFolder',5,tkInteger,nil,__SHCreateItemInKnownFolder,false,0).SetVarArgs([4]);
    DefineProp('CLSID_ShellDesktop',tkVariant,__GetCLSID_ShellDesktop,nil,nil,false,0);
    DefineProp('CLSID_ShellLink',tkVariant,__GetCLSID_ShellLink,nil,nil,false,0);
    DefineProp('CLSID_ActiveDesktop',tkVariant,__GetCLSID_ActiveDesktop,nil,nil,false,0);
    DefineProp('CLSID_DragDropHelper',tkVariant,__GetCLSID_DragDropHelper,nil,nil,false,0);
    DefineProp('FMTID_Intshcut',tkVariant,__GetFMTID_Intshcut,nil,nil,false,0);
    DefineProp('FMTID_InternetSite',tkVariant,__GetFMTID_InternetSite,nil,nil,false,0);
    DefineProp('CGID_Explorer',tkVariant,__GetCGID_Explorer,nil,nil,false,0);
    DefineProp('CGID_ShellDocView',tkVariant,__GetCGID_ShellDocView,nil,nil,false,0);
    DefineProp('IID_INewShortcutHookA',tkVariant,__GetIID_INewShortcutHookA,nil,nil,false,0);
    DefineProp('IID_IShellBrowser',tkVariant,__GetIID_IShellBrowser,nil,nil,false,0);
    DefineProp('IID_IShellView',tkVariant,__GetIID_IShellView,nil,nil,false,0);
    DefineProp('IID_IContextMenu',tkVariant,__GetIID_IContextMenu,nil,nil,false,0);
    DefineProp('IID_IShellIcon',tkVariant,__GetIID_IShellIcon,nil,nil,false,0);
    DefineProp('IID_IShellFolder',tkVariant,__GetIID_IShellFolder,nil,nil,false,0);
    DefineProp('IID_IShellExtInit',tkVariant,__GetIID_IShellExtInit,nil,nil,false,0);
    DefineProp('IID_IShellPropSheetExt',tkVariant,__GetIID_IShellPropSheetExt,nil,nil,false,0);
    DefineProp('IID_IPersistFolder',tkVariant,__GetIID_IPersistFolder,nil,nil,false,0);
    DefineProp('IID_IExtractIconA',tkVariant,__GetIID_IExtractIconA,nil,nil,false,0);
    DefineProp('IID_IShellLinkA',tkVariant,__GetIID_IShellLinkA,nil,nil,false,0);
    DefineProp('IID_IShellCopyHookA',tkVariant,__GetIID_IShellCopyHookA,nil,nil,false,0);
    DefineProp('IID_IFileViewerA',tkVariant,__GetIID_IFileViewerA,nil,nil,false,0);
    DefineProp('IID_ICommDlgBrowser',tkVariant,__GetIID_ICommDlgBrowser,nil,nil,false,0);
    DefineProp('IID_IEnumIDList',tkVariant,__GetIID_IEnumIDList,nil,nil,false,0);
    DefineProp('IID_IFileViewerSite',tkVariant,__GetIID_IFileViewerSite,nil,nil,false,0);
    DefineProp('IID_IContextMenu2',tkVariant,__GetIID_IContextMenu2,nil,nil,false,0);
    DefineProp('IID_IShellExecuteHook',tkVariant,__GetIID_IShellExecuteHook,nil,nil,false,0);
    DefineProp('IID_IPropSheetPage',tkVariant,__GetIID_IPropSheetPage,nil,nil,false,0);
    DefineProp('IID_INewShortcutHookW',tkVariant,__GetIID_INewShortcutHookW,nil,nil,false,0);
    DefineProp('IID_IFileViewerW',tkVariant,__GetIID_IFileViewerW,nil,nil,false,0);
    DefineProp('IID_IShellLinkW',tkVariant,__GetIID_IShellLinkW,nil,nil,false,0);
    DefineProp('IID_IExtractIconW',tkVariant,__GetIID_IExtractIconW,nil,nil,false,0);
    DefineProp('IID_IShellExecuteHookW',tkVariant,__GetIID_IShellExecuteHookW,nil,nil,false,0);
    DefineProp('IID_IShellCopyHookW',tkVariant,__GetIID_IShellCopyHookW,nil,nil,false,0);
    DefineProp('IID_IShellView2',tkVariant,__GetIID_IShellView2,nil,nil,false,0);
    DefineProp('IID_IShellFolder2',tkVariant,__GetIID_IShellFolder2,nil,nil,false,0);
    DefineProp('IID_IShellDetails',tkVariant,__GetIID_IShellDetails,nil,nil,false,0);
    DefineProp('IID_IEnumExtraSearch',tkVariant,__GetIID_IEnumExtraSearch,nil,nil,false,0);
    DefineProp('IID_IDropTargetHelper',tkVariant,__GetIID_IDropTargetHelper,nil,nil,false,0);
    DefineProp('IID_IDragSourceHelper',tkVariant,__GetIID_IDragSourceHelper,nil,nil,false,0);
    DefineProp('CLSID_AutoComplete',tkVariant,__GetCLSID_AutoComplete,nil,nil,false,0);
    DefineProp('CLSID_ShelllItem',tkVariant,__GetCLSID_ShelllItem,nil,nil,false,0);
    DefineProp('CLSID_FileOpenDialog',tkVariant,__GetCLSID_FileOpenDialog,nil,nil,false,0);
    DefineProp('CLSID_FileSaveDialog',tkVariant,__GetCLSID_FileSaveDialog,nil,nil,false,0);
    AddConstant('SHDVID_SETPROGRESSPOS',SHDVID_SETPROGRESSPOS);
    AddConstant('SHDVID_SETPROGRESSRANGE',SHDVID_SETPROGRESSRANGE);
    AddConstant('SHDVID_SETSTATUSTEXT',SHDVID_SETSTATUSTEXT);
    AddConstant('SHDVID_REFRESH',SHDVID_REFRESH);
    AddConstant('SHDVID_STOP',SHDVID_STOP);
    AddConstant('SHDVID_UPDATECOMMANDS',SHDVID_UPDATECOMMANDS);
    AddConstant('SHDVID_SETTITLE',SHDVID_SETTITLE);
    AddConstant('SHDVID_FINALTITLEAVAIL',SHDVID_FINALTITLEAVAIL);
    AddConstant('SHDVID_STARTLOAD',SHDVID_STARTLOAD);
    AddConstant('SHDVID_STOPLOAD',SHDVID_STOPLOAD);
    AddConstant('SHDVID_CCALLBACK',SHDVID_CCALLBACK);
    AddConstant('SHDVID_MENUEXEC',SHDVID_MENUEXEC);
    AddConstant('SHDVID_MENUQS',SHDVID_MENUQS);
    AddConstant('SBSC_HIDE',SBSC_HIDE);
    AddConstant('SBSC_SHOW',SBSC_SHOW);
    AddConstant('SBSC_TOGGLE',SBSC_TOGGLE);
    AddConstant('SBSC_QUERY',SBSC_QUERY);
    AddConstant('SBO_DEFAULT',SBO_DEFAULT);
    AddConstant('SBO_NOBROWSERPAGES',SBO_NOBROWSERPAGES);
    AddConstant('SBCMDID_ENABLESHOWTREE',SBCMDID_ENABLESHOWTREE);
    AddConstant('SBCMDID_SHOWCONTROL',SBCMDID_SHOWCONTROL);
    AddConstant('SBCMDID_CANCELNAVIGATION',SBCMDID_CANCELNAVIGATION);
    AddConstant('SBCMDID_MAYSAVECHANGES',SBCMDID_MAYSAVECHANGES);
    AddConstant('SBCMDID_SETHLINKFRAME',SBCMDID_SETHLINKFRAME);
    AddConstant('SBCMDID_ENABLESTOP',SBCMDID_ENABLESTOP);
    AddConstant('SBCMDID_OPTIONS',SBCMDID_OPTIONS);
    AddConstant('SVUIA_DEACTIVATE',SVUIA_DEACTIVATE);
    AddConstant('SVUIA_ACTIVATE_NOFOCUS',SVUIA_ACTIVATE_NOFOCUS);
    AddConstant('SVUIA_ACTIVATE_FOCUS',SVUIA_ACTIVATE_FOCUS);
    AddConstant('SVUIA_INPLACEACTIVATE',SVUIA_INPLACEACTIVATE);
    AddConstant('DTI_ADDUI_DEFAULT',DTI_ADDUI_DEFAULT);
    AddConstant('DTI_ADDUI_DISPSUBWIZARD',DTI_ADDUI_DISPSUBWIZARD);
    AddConstant('SID_INewShortcutHookA',SID_INewShortcutHookA);
    AddConstant('SID_IShellBrowser',SID_IShellBrowser);
    AddConstant('SID_IShellView',SID_IShellView);
    AddConstant('SID_IContextMenu',SID_IContextMenu);
    AddConstant('SID_IShellIcon',SID_IShellIcon);
    AddConstant('SID_IShellFolder',SID_IShellFolder);
    AddConstant('SID_IShellExtInit',SID_IShellExtInit);
    AddConstant('SID_IShellPropSheetExt',SID_IShellPropSheetExt);
    AddConstant('SID_IPersistFolder',SID_IPersistFolder);
    AddConstant('SID_IExtractIconA',SID_IExtractIconA);
    AddConstant('SID_IShellLinkA',SID_IShellLinkA);
    AddConstant('SID_IShellCopyHookA',SID_IShellCopyHookA);
    AddConstant('SID_IFileViewerA',SID_IFileViewerA);
    AddConstant('SID_ICommDlgBrowser',SID_ICommDlgBrowser);
    AddConstant('SID_IEnumIDList',SID_IEnumIDList);
    AddConstant('SID_IFileViewerSite',SID_IFileViewerSite);
    AddConstant('SID_IContextMenu2',SID_IContextMenu2);
    AddConstant('SID_IShellExecuteHookA',SID_IShellExecuteHookA);
    AddConstant('SID_IPropSheetPage',SID_IPropSheetPage);
    AddConstant('SID_INewShortcutHookW',SID_INewShortcutHookW);
    AddConstant('SID_IFileViewerW',SID_IFileViewerW);
    AddConstant('SID_IShellLinkW',SID_IShellLinkW);
    AddConstant('SID_IExtractIconW',SID_IExtractIconW);
    AddConstant('SID_IShellExecuteHookW',SID_IShellExecuteHookW);
    AddConstant('SID_IShellCopyHookW',SID_IShellCopyHookW);
    AddConstant('SID_IShellView2',SID_IShellView2);
    AddConstant('SID_IContextMenu3',SID_IContextMenu3);
    AddConstant('SID_IPersistFolder2',SID_IPersistFolder2);
    AddConstant('SID_IShellIconOverlayIdentifier',SID_IShellIconOverlayIdentifier);
    AddConstant('SID_IShellIconOverlay',SID_IShellIconOverlay);
    AddConstant('SID_IURLSearchHook',SID_IURLSearchHook);
    AddConstant('SID_IInputObjectSite',SID_IInputObjectSite);
    AddConstant('SID_IInputObject',SID_IInputObject);
    AddConstant('SID_IDockingWindowSite',SID_IDockingWindowSite);
    AddConstant('SID_IDockingWindowFrame',SID_IDockingWindowFrame);
    AddConstant('SID_IDockingWindow',SID_IDockingWindow);
    AddConstant('SID_IDeskBand',SID_IDeskBand);
    AddConstant('SID_IActiveDesktop',SID_IActiveDesktop);
    AddConstant('SID_IShellChangeNotify',SID_IShellChangeNotify);
    AddConstant('SID_IQueryInfo',SID_IQueryInfo);
    AddConstant('SID_IShellDetails',SID_IShellDetails);
    AddConstant('SID_IShellFolder2',SID_IShellFolder2);
    AddConstant('SID_IEnumExtraSearch',SID_IEnumExtraSearch);
    AddConstant('SID_IDropTargetHelper',SID_IDropTargetHelper);
    AddConstant('SID_IDragSourceHelper',SID_IDragSourceHelper);
    AddConstant('CMF_NORMAL',CMF_NORMAL);
    AddConstant('CMF_DEFAULTONLY',CMF_DEFAULTONLY);
    AddConstant('CMF_VERBSONLY',CMF_VERBSONLY);
    AddConstant('CMF_EXPLORE',CMF_EXPLORE);
    AddConstant('CMF_NOVERBS',CMF_NOVERBS);
    AddConstant('CMF_CANRENAME',CMF_CANRENAME);
    AddConstant('CMF_NODEFAULT',CMF_NODEFAULT);
    AddConstant('CMF_INCLUDESTATIC',CMF_INCLUDESTATIC);
    AddConstant('CMF_RESERVED',CMF_RESERVED);
    AddConstant('GCS_VERBA',GCS_VERBA);
    AddConstant('GCS_HELPTEXTA',GCS_HELPTEXTA);
    AddConstant('GCS_VALIDATEA',GCS_VALIDATEA);
    AddConstant('GCS_VERBW',GCS_VERBW);
    AddConstant('GCS_HELPTEXTW',GCS_HELPTEXTW);
    AddConstant('GCS_VALIDATEW',GCS_VALIDATEW);
    AddConstant('GCS_UNICODE',GCS_UNICODE);
    AddConstant('GCS_VERB',GCS_VERB);
    AddConstant('GCS_HELPTEXT',GCS_HELPTEXT);
    AddConstant('GCS_VALIDATE',GCS_VALIDATE);
    AddConstant('CMDSTR_NEWFOLDERA',CMDSTR_NEWFOLDERA);
    AddConstant('CMDSTR_VIEWLISTA',CMDSTR_VIEWLISTA);
    AddConstant('CMDSTR_VIEWDETAILSA',CMDSTR_VIEWDETAILSA);
    AddConstant('CMDSTR_NEWFOLDERW',CMDSTR_NEWFOLDERW);
    AddConstant('CMDSTR_VIEWLISTW',CMDSTR_VIEWLISTW);
    AddConstant('CMDSTR_VIEWDETAILSW',CMDSTR_VIEWDETAILSW);
    AddConstant('CMDSTR_NEWFOLDER',CMDSTR_NEWFOLDER);
    AddConstant('CMDSTR_VIEWLIST',CMDSTR_VIEWLIST);
    AddConstant('CMDSTR_VIEWDETAILS',CMDSTR_VIEWDETAILS);
    AddConstant('CMIC_MASK_HOTKEY',CMIC_MASK_HOTKEY);
    AddConstant('CMIC_MASK_ICON',CMIC_MASK_ICON);
    AddConstant('CMIC_MASK_FLAG_NO_UI',CMIC_MASK_FLAG_NO_UI);
    AddConstant('CMIC_MASK_UNICODE',CMIC_MASK_UNICODE);
    AddConstant('CMIC_MASK_NO_CONSOLE',CMIC_MASK_NO_CONSOLE);
    AddConstant('CMIC_MASK_ASYNCOK',CMIC_MASK_ASYNCOK);
    AddConstant('CMIC_MASK_PTINVOKE',CMIC_MASK_PTINVOKE);
    AddConstant('GIL_OPENICON',GIL_OPENICON);
    AddConstant('GIL_FORSHELL',GIL_FORSHELL);
    AddConstant('GIL_ASYNC',GIL_ASYNC);
    AddConstant('GIL_SIMULATEDOC',GIL_SIMULATEDOC);
    AddConstant('GIL_PERINSTANCE',GIL_PERINSTANCE);
    AddConstant('GIL_PERCLASS',GIL_PERCLASS);
    AddConstant('GIL_NOTFILENAME',GIL_NOTFILENAME);
    AddConstant('GIL_DONTCACHE',GIL_DONTCACHE);
    AddConstant('ISIOI_ICONFILE',ISIOI_ICONFILE);
    AddConstant('ISIOI_ICONINDEX',ISIOI_ICONINDEX);
    AddConstant('ISIOI_SYSIMAGELISTINDEX',ISIOI_SYSIMAGELISTINDEX);
    AddConstant('SLR_NO_UI',SLR_NO_UI);
    AddConstant('SLR_ANY_MATCH',SLR_ANY_MATCH);
    AddConstant('SLR_UPDATE',SLR_UPDATE);
    AddConstant('SLR_NOUPDATE',SLR_NOUPDATE);
    AddConstant('SLGP_SHORTPATH',SLGP_SHORTPATH);
    AddConstant('SLGP_UNCPRIORITY',SLGP_UNCPRIORITY);
    AddConstant('SLGP_RAWPATH',SLGP_RAWPATH);
    AddConstant('FVSIF_RECT',FVSIF_RECT);
    AddConstant('FVSIF_PINNED',FVSIF_PINNED);
    AddConstant('FVSIF_NEWFAILED',FVSIF_NEWFAILED);
    AddConstant('FVSIF_NEWFILE',FVSIF_NEWFILE);
    AddConstant('FVSIF_CANVIEWIT',FVSIF_CANVIEWIT);
    AddConstant('FCIDM_SHVIEWFIRST',FCIDM_SHVIEWFIRST);
    AddConstant('FCIDM_SHVIEWLAST',FCIDM_SHVIEWLAST);
    AddConstant('FCIDM_BROWSERFIRST',FCIDM_BROWSERFIRST);
    AddConstant('FCIDM_BROWSERLAST',FCIDM_BROWSERLAST);
    AddConstant('FCIDM_GLOBALFIRST',FCIDM_GLOBALFIRST);
    AddConstant('FCIDM_GLOBALLAST',FCIDM_GLOBALLAST);
    AddConstant('FCIDM_MENU_FILE',FCIDM_MENU_FILE);
    AddConstant('FCIDM_MENU_EDIT',FCIDM_MENU_EDIT);
    AddConstant('FCIDM_MENU_VIEW',FCIDM_MENU_VIEW);
    AddConstant('FCIDM_MENU_VIEW_SEP_OPTIONS',FCIDM_MENU_VIEW_SEP_OPTIONS);
    AddConstant('FCIDM_MENU_TOOLS',FCIDM_MENU_TOOLS);
    AddConstant('FCIDM_MENU_TOOLS_SEP_GOTO',FCIDM_MENU_TOOLS_SEP_GOTO);
    AddConstant('FCIDM_MENU_HELP',FCIDM_MENU_HELP);
    AddConstant('FCIDM_MENU_FIND',FCIDM_MENU_FIND);
    AddConstant('FCIDM_MENU_EXPLORE',FCIDM_MENU_EXPLORE);
    AddConstant('FCIDM_MENU_FAVORITES',FCIDM_MENU_FAVORITES);
    AddConstant('FCIDM_TOOLBAR',FCIDM_TOOLBAR);
    AddConstant('FCIDM_STATUS',FCIDM_STATUS);
    AddConstant('IDC_OFFLINE_HAND',IDC_OFFLINE_HAND);
    AddConstant('FWF_AUTOARRANGE',FWF_AUTOARRANGE);
    AddConstant('FWF_ABBREVIATEDNAMES',FWF_ABBREVIATEDNAMES);
    AddConstant('FWF_SNAPTOGRID',FWF_SNAPTOGRID);
    AddConstant('FWF_OWNERDATA',FWF_OWNERDATA);
    AddConstant('FWF_BESTFITWINDOW',FWF_BESTFITWINDOW);
    AddConstant('FWF_DESKTOP',FWF_DESKTOP);
    AddConstant('FWF_SINGLESEL',FWF_SINGLESEL);
    AddConstant('FWF_NOSUBFOLDERS',FWF_NOSUBFOLDERS);
    AddConstant('FWF_TRANSPARENT',FWF_TRANSPARENT);
    AddConstant('FWF_NOCLIENTEDGE',FWF_NOCLIENTEDGE);
    AddConstant('FWF_NOSCROLL',FWF_NOSCROLL);
    AddConstant('FWF_ALIGNLEFT',FWF_ALIGNLEFT);
    AddConstant('FWF_NOICONS',FWF_NOICONS);
    AddConstant('FWF_SINGLECLICKACTIVATE',FWF_SINGLECLICKACTIVATE);
    AddConstant('FVM_ICON',FVM_ICON);
    AddConstant('FVM_SMALLICON',FVM_SMALLICON);
    AddConstant('FVM_LIST',FVM_LIST);
    AddConstant('FVM_DETAILS',FVM_DETAILS);
    AddConstant('SBSP_DEFBROWSER',SBSP_DEFBROWSER);
    AddConstant('SBSP_SAMEBROWSER',SBSP_SAMEBROWSER);
    AddConstant('SBSP_NEWBROWSER',SBSP_NEWBROWSER);
    AddConstant('SBSP_DEFMODE',SBSP_DEFMODE);
    AddConstant('SBSP_OPENMODE',SBSP_OPENMODE);
    AddConstant('SBSP_EXPLOREMODE',SBSP_EXPLOREMODE);
    AddConstant('SBSP_ABSOLUTE',SBSP_ABSOLUTE);
    AddConstant('SBSP_RELATIVE',SBSP_RELATIVE);
    AddConstant('SBSP_PARENT',SBSP_PARENT);
    AddConstant('SBSP_NAVIGATEBACK',SBSP_NAVIGATEBACK);
    AddConstant('SBSP_NAVIGATEFORWARD',SBSP_NAVIGATEFORWARD);
    AddConstant('SBSP_ALLOW_AUTONAVIGATE',SBSP_ALLOW_AUTONAVIGATE);
    AddConstant('SBSP_INITIATEDBYHLINKFRAME',SBSP_INITIATEDBYHLINKFRAME);
    AddConstant('SBSP_REDIRECT',SBSP_REDIRECT);
    AddConstant('SBSP_WRITENOHISTORY',SBSP_WRITENOHISTORY);
    AddConstant('SBSP_NOAUTOSELECT',SBSP_NOAUTOSELECT);
    AddConstant('FCW_STATUS',FCW_STATUS);
    AddConstant('FCW_TOOLBAR',FCW_TOOLBAR);
    AddConstant('FCW_TREE',FCW_TREE);
    AddConstant('FCW_INTERNETBAR',FCW_INTERNETBAR);
    AddConstant('FCW_PROGRESS',FCW_PROGRESS);
    AddConstant('FCT_MERGE',FCT_MERGE);
    AddConstant('FCT_CONFIGABLE',FCT_CONFIGABLE);
    AddConstant('FCT_ADDTOEND',FCT_ADDTOEND);
    AddConstant('CDBOSC_SETFOCUS',CDBOSC_SETFOCUS);
    AddConstant('CDBOSC_KILLFOCUS',CDBOSC_KILLFOCUS);
    AddConstant('CDBOSC_SELCHANGE',CDBOSC_SELCHANGE);
    AddConstant('CDBOSC_RENAME',CDBOSC_RENAME);
    AddConstant('SVSI_DESELECT',SVSI_DESELECT);
    AddConstant('SVSI_SELECT',SVSI_SELECT);
    AddConstant('SVSI_EDIT',SVSI_EDIT);
    AddConstant('SVSI_DESELECTOTHERS',SVSI_DESELECTOTHERS);
    AddConstant('SVSI_ENSUREVISIBLE',SVSI_ENSUREVISIBLE);
    AddConstant('SVSI_FOCUSED',SVSI_FOCUSED);
    AddConstant('SVSI_TRANSLATEPT',SVSI_TRANSLATEPT);
    AddConstant('SVGIO_BACKGROUND',SVGIO_BACKGROUND);
    AddConstant('SVGIO_SELECTION',SVGIO_SELECTION);
    AddConstant('SVGIO_ALLVIEW',SVGIO_ALLVIEW);
    AddConstant('SV2GV_CURRENTVIEW',SV2GV_CURRENTVIEW);
    AddConstant('SV2GV_DEFAULTVIEW',SV2GV_DEFAULTVIEW);
    AddConstant('STRRET_WSTR',STRRET_WSTR);
    AddConstant('STRRET_OFFSET',STRRET_OFFSET);
    AddConstant('STRRET_CSTR',STRRET_CSTR);
    AddConstant('REGSTR_PATH_SPECIAL_FOLDERS',REGSTR_PATH_SPECIAL_FOLDERS);
    AddConstant('CSIDL_DESKTOP',CSIDL_DESKTOP);
    AddConstant('CSIDL_INTERNET',CSIDL_INTERNET);
    AddConstant('CSIDL_PROGRAMS',CSIDL_PROGRAMS);
    AddConstant('CSIDL_CONTROLS',CSIDL_CONTROLS);
    AddConstant('CSIDL_PRINTERS',CSIDL_PRINTERS);
    AddConstant('CSIDL_PERSONAL',CSIDL_PERSONAL);
    AddConstant('CSIDL_FAVORITES',CSIDL_FAVORITES);
    AddConstant('CSIDL_STARTUP',CSIDL_STARTUP);
    AddConstant('CSIDL_RECENT',CSIDL_RECENT);
    AddConstant('CSIDL_SENDTO',CSIDL_SENDTO);
    AddConstant('CSIDL_BITBUCKET',CSIDL_BITBUCKET);
    AddConstant('CSIDL_STARTMENU',CSIDL_STARTMENU);
    AddConstant('CSIDL_MYDOCUMENTS',CSIDL_MYDOCUMENTS);
    AddConstant('CSIDL_MYMUSIC',CSIDL_MYMUSIC);
    AddConstant('CSIDL_MYVIDEO',CSIDL_MYVIDEO);
    AddConstant('CSIDL_DESKTOPDIRECTORY',CSIDL_DESKTOPDIRECTORY);
    AddConstant('CSIDL_DRIVES',CSIDL_DRIVES);
    AddConstant('CSIDL_NETWORK',CSIDL_NETWORK);
    AddConstant('CSIDL_NETHOOD',CSIDL_NETHOOD);
    AddConstant('CSIDL_FONTS',CSIDL_FONTS);
    AddConstant('CSIDL_TEMPLATES',CSIDL_TEMPLATES);
    AddConstant('CSIDL_COMMON_STARTMENU',CSIDL_COMMON_STARTMENU);
    AddConstant('CSIDL_COMMON_PROGRAMS',CSIDL_COMMON_PROGRAMS);
    AddConstant('CSIDL_COMMON_STARTUP',CSIDL_COMMON_STARTUP);
    AddConstant('CSIDL_COMMON_DESKTOPDIRECTORY',CSIDL_COMMON_DESKTOPDIRECTORY);
    AddConstant('CSIDL_APPDATA',CSIDL_APPDATA);
    AddConstant('CSIDL_PRINTHOOD',CSIDL_PRINTHOOD);
    AddConstant('CSIDL_LOCAL_APPDATA',CSIDL_LOCAL_APPDATA);
    AddConstant('CSIDL_ALTSTARTUP',CSIDL_ALTSTARTUP);
    AddConstant('CSIDL_COMMON_ALTSTARTUP',CSIDL_COMMON_ALTSTARTUP);
    AddConstant('CSIDL_COMMON_FAVORITES',CSIDL_COMMON_FAVORITES);
    AddConstant('CSIDL_INTERNET_CACHE',CSIDL_INTERNET_CACHE);
    AddConstant('CSIDL_COOKIES',CSIDL_COOKIES);
    AddConstant('CSIDL_HISTORY',CSIDL_HISTORY);
    AddConstant('CSIDL_COMMON_APPDATA',CSIDL_COMMON_APPDATA);
    AddConstant('CSIDL_WINDOWS',CSIDL_WINDOWS);
    AddConstant('CSIDL_SYSTEM',CSIDL_SYSTEM);
    AddConstant('CSIDL_PROGRAM_FILES',CSIDL_PROGRAM_FILES);
    AddConstant('CSIDL_MYPICTURES',CSIDL_MYPICTURES);
    AddConstant('CSIDL_PROFILE',CSIDL_PROFILE);
    AddConstant('CSIDL_SYSTEMX86',CSIDL_SYSTEMX86);
    AddConstant('CSIDL_PROGRAM_FILESX86',CSIDL_PROGRAM_FILESX86);
    AddConstant('CSIDL_PROGRAM_FILES_COMMON',CSIDL_PROGRAM_FILES_COMMON);
    AddConstant('CSIDL_PROGRAM_FILES_COMMONX86',CSIDL_PROGRAM_FILES_COMMONX86);
    AddConstant('CSIDL_COMMON_TEMPLATES',CSIDL_COMMON_TEMPLATES);
    AddConstant('CSIDL_COMMON_DOCUMENTS',CSIDL_COMMON_DOCUMENTS);
    AddConstant('CSIDL_COMMON_ADMINTOOLS',CSIDL_COMMON_ADMINTOOLS);
    AddConstant('CSIDL_ADMINTOOLS',CSIDL_ADMINTOOLS);
    AddConstant('CSIDL_CONNECTIONS',CSIDL_CONNECTIONS);
    AddConstant('CSIDL_COMMON_MUSIC',CSIDL_COMMON_MUSIC);
    AddConstant('CSIDL_COMMON_PICTURES',CSIDL_COMMON_PICTURES);
    AddConstant('CSIDL_COMMON_VIDEO',CSIDL_COMMON_VIDEO);
    AddConstant('CSIDL_RESOURCES',CSIDL_RESOURCES);
    AddConstant('CSIDL_RESOURCES_LOCALIZED',CSIDL_RESOURCES_LOCALIZED);
    AddConstant('CSIDL_COMMON_OEM_LINKS',CSIDL_COMMON_OEM_LINKS);
    AddConstant('CSIDL_CDBURN_AREA',CSIDL_CDBURN_AREA);
    AddConstant('CSIDL_COMPUTERSNEARME',CSIDL_COMPUTERSNEARME);
    AddConstant('CSIDL_PROFILES',CSIDL_PROFILES);
    AddConstant('CSIDL_FLAG_CREATE',CSIDL_FLAG_CREATE);
    AddConstant('CSIDL_FLAG_DONT_VERIFY',CSIDL_FLAG_DONT_VERIFY);
    AddConstant('CSIDL_FLAG_DONT_UNEXPAND',CSIDL_FLAG_DONT_UNEXPAND);
    AddConstant('CSIDL_FLAG_NO_ALIAS',CSIDL_FLAG_NO_ALIAS);
    AddConstant('CSIDL_FLAG_PER_USER_INIT',CSIDL_FLAG_PER_USER_INIT);
    AddConstant('CSIDL_FLAG_MASK',CSIDL_FLAG_MASK);
    AddConstant('BIF_RETURNONLYFSDIRS',BIF_RETURNONLYFSDIRS);
    AddConstant('BIF_DONTGOBELOWDOMAIN',BIF_DONTGOBELOWDOMAIN);
    AddConstant('BIF_STATUSTEXT',BIF_STATUSTEXT);
    AddConstant('BIF_RETURNFSANCESTORS',BIF_RETURNFSANCESTORS);
    AddConstant('BIF_EDITBOX',BIF_EDITBOX);
    AddConstant('BIF_VALIDATE',BIF_VALIDATE);
    AddConstant('BIF_NEWDIALOGSTYLE',BIF_NEWDIALOGSTYLE);
    AddConstant('BIF_USENEWUI',BIF_USENEWUI);
    AddConstant('BIF_BROWSEINCLUDEURLS',BIF_BROWSEINCLUDEURLS);
    AddConstant('BIF_UAHINT',BIF_UAHINT);
    AddConstant('BIF_NONEWFOLDERBUTTON',BIF_NONEWFOLDERBUTTON);
    AddConstant('BIF_NOTRANSLATETARGETS',BIF_NOTRANSLATETARGETS);
    AddConstant('BIF_BROWSEFORCOMPUTER',BIF_BROWSEFORCOMPUTER);
    AddConstant('BIF_BROWSEFORPRINTER',BIF_BROWSEFORPRINTER);
    AddConstant('BIF_BROWSEINCLUDEFILES',BIF_BROWSEINCLUDEFILES);
    AddConstant('BIF_SHAREABLE',BIF_SHAREABLE);
    AddConstant('BFFM_INITIALIZED',BFFM_INITIALIZED);
    AddConstant('BFFM_SELCHANGED',BFFM_SELCHANGED);
    AddConstant('BFFM_VALIDATEFAILEDA',BFFM_VALIDATEFAILEDA);
    AddConstant('BFFM_VALIDATEFAILEDW',BFFM_VALIDATEFAILEDW);
    AddConstant('BFFM_SETSTATUSTEXTA',BFFM_SETSTATUSTEXTA);
    AddConstant('BFFM_ENABLEOK',BFFM_ENABLEOK);
    AddConstant('BFFM_SETSELECTIONA',BFFM_SETSELECTIONA);
    AddConstant('BFFM_SETSELECTIONW',BFFM_SETSELECTIONW);
    AddConstant('BFFM_SETSTATUSTEXTW',BFFM_SETSTATUSTEXTW);
    AddConstant('BFFM_VALIDATEFAILED',BFFM_VALIDATEFAILED);
    AddConstant('BFFM_SETSTATUSTEXT',BFFM_SETSTATUSTEXT);
    AddConstant('BFFM_SETSELECTION',BFFM_SETSELECTION);
    AddConstant('SHGDN_NORMAL',SHGDN_NORMAL);
    AddConstant('SHGDN_INFOLDER',SHGDN_INFOLDER);
    AddConstant('SHGDN_FOREDITING',SHGDN_FOREDITING);
    AddConstant('SHGDN_INCLUDE_NONFILESYS',SHGDN_INCLUDE_NONFILESYS);
    AddConstant('SHGDN_FORADDRESSBAR',SHGDN_FORADDRESSBAR);
    AddConstant('SHGDN_FORPARSING',SHGDN_FORPARSING);
    AddConstant('SHCONTF_FOLDERS',SHCONTF_FOLDERS);
    AddConstant('SHCONTF_NONFOLDERS',SHCONTF_NONFOLDERS);
    AddConstant('SHCONTF_INCLUDEHIDDEN',SHCONTF_INCLUDEHIDDEN);
    AddConstant('SFGAO_CANCOPY',SFGAO_CANCOPY);
    AddConstant('SFGAO_CANMOVE',SFGAO_CANMOVE);
    AddConstant('SFGAO_CANLINK',SFGAO_CANLINK);
    AddConstant('SFGAO_CANRENAME',SFGAO_CANRENAME);
    AddConstant('SFGAO_CANDELETE',SFGAO_CANDELETE);
    AddConstant('SFGAO_HASPROPSHEET',SFGAO_HASPROPSHEET);
    AddConstant('SFGAO_DROPTARGET',SFGAO_DROPTARGET);
    AddConstant('SFGAO_CAPABILITYMASK',SFGAO_CAPABILITYMASK);
    AddConstant('SFGAO_GHOSTED',SFGAO_GHOSTED);
    AddConstant('SFGAO_LINK',SFGAO_LINK);
    AddConstant('SFGAO_SHARE',SFGAO_SHARE);
    AddConstant('SFGAO_READONLY',SFGAO_READONLY);
    AddConstant('SFGAO_HIDDEN',SFGAO_HIDDEN);
    AddConstant('SFGAO_DISPLAYATTRMASK',SFGAO_DISPLAYATTRMASK);
    AddConstant('SFGAO_FILESYSANCESTOR',SFGAO_FILESYSANCESTOR);
    AddConstant('SFGAO_FOLDER',SFGAO_FOLDER);
    AddConstant('SFGAO_FILESYSTEM',SFGAO_FILESYSTEM);
    AddConstant('SFGAO_HASSUBFOLDER',SFGAO_HASSUBFOLDER);
    AddConstant('SFGAO_CONTENTSMASK',SFGAO_CONTENTSMASK);
    AddConstant('SFGAO_VALIDATE',SFGAO_VALIDATE);
    AddConstant('SFGAO_REMOVABLE',SFGAO_REMOVABLE);
    AddConstant('SFGAO_COMPRESSED',SFGAO_COMPRESSED);
    AddConstant('SFGAO_BROWSABLE',SFGAO_BROWSABLE);
    AddConstant('SFGAO_NONENUMERATED',SFGAO_NONENUMERATED);
    AddConstant('SFGAO_NEWCONTENT',SFGAO_NEWCONTENT);
    AddConstant('SHCOLSTATE_TYPE_STR',SHCOLSTATE_TYPE_STR);
    AddConstant('SHCOLSTATE_TYPE_INT',SHCOLSTATE_TYPE_INT);
    AddConstant('SHCOLSTATE_TYPE_DATE',SHCOLSTATE_TYPE_DATE);
    AddConstant('SHCOLSTATE_TYPEMASK',SHCOLSTATE_TYPEMASK);
    AddConstant('SHCOLSTATE_ONBYDEFAULT',SHCOLSTATE_ONBYDEFAULT);
    AddConstant('SHCOLSTATE_SLOW',SHCOLSTATE_SLOW);
    AddConstant('SHCOLSTATE_EXTENDED',SHCOLSTATE_EXTENDED);
    AddConstant('SHCOLSTATE_SECONDARYUI',SHCOLSTATE_SECONDARYUI);
    AddConstant('SHCOLSTATE_HIDDEN',SHCOLSTATE_HIDDEN);
    AddConstant('DWFRF_NORMAL',DWFRF_NORMAL);
    AddConstant('DWFRF_DELETECONFIGDATA',DWFRF_DELETECONFIGDATA);
    AddConstant('DWFAF_HIDDEN',DWFAF_HIDDEN);
    AddConstant('DBIM_MINSIZE',DBIM_MINSIZE);
    AddConstant('DBIM_MAXSIZE',DBIM_MAXSIZE);
    AddConstant('DBIM_INTEGRAL',DBIM_INTEGRAL);
    AddConstant('DBIM_ACTUAL',DBIM_ACTUAL);
    AddConstant('DBIM_TITLE',DBIM_TITLE);
    AddConstant('DBIM_MODEFLAGS',DBIM_MODEFLAGS);
    AddConstant('DBIM_BKCOLOR',DBIM_BKCOLOR);
    AddConstant('DBIMF_NORMAL',DBIMF_NORMAL);
    AddConstant('DBIMF_VARIABLEHEIGHT',DBIMF_VARIABLEHEIGHT);
    AddConstant('DBIMF_DEBOSSED',DBIMF_DEBOSSED);
    AddConstant('DBIMF_BKCOLOR',DBIMF_BKCOLOR);
    AddConstant('DBIF_VIEWMODE_NORMAL',DBIF_VIEWMODE_NORMAL);
    AddConstant('DBIF_VIEWMODE_VERTICAL',DBIF_VIEWMODE_VERTICAL);
    AddConstant('DBIF_VIEWMODE_FLOATING',DBIF_VIEWMODE_FLOATING);
    AddConstant('DBIF_VIEWMODE_TRANSPARENT',DBIF_VIEWMODE_TRANSPARENT);
    AddConstant('DBID_BANDINFOCHANGED',DBID_BANDINFOCHANGED);
    AddConstant('DBID_SHOWONLY',DBID_SHOWONLY);
    AddConstant('DBID_MAXIMIZEBAND',DBID_MAXIMIZEBAND);
    AddConstant('COMPONENT_TOP',COMPONENT_TOP);
    AddConstant('COMP_TYPE_HTMLDOC',COMP_TYPE_HTMLDOC);
    AddConstant('COMP_TYPE_PICTURE',COMP_TYPE_PICTURE);
    AddConstant('COMP_TYPE_WEBSITE',COMP_TYPE_WEBSITE);
    AddConstant('COMP_TYPE_CONTROL',COMP_TYPE_CONTROL);
    AddConstant('COMP_TYPE_CFHTML',COMP_TYPE_CFHTML);
    AddConstant('COMP_TYPE_MAX',COMP_TYPE_MAX);
    AddConstant('AD_APPLY_SAVE',AD_APPLY_SAVE);
    AddConstant('AD_APPLY_HTMLGEN',AD_APPLY_HTMLGEN);
    AddConstant('AD_APPLY_REFRESH',AD_APPLY_REFRESH);
    AddConstant('AD_APPLY_ALL',AD_APPLY_ALL);
    AddConstant('AD_APPLY_FORCE',AD_APPLY_FORCE);
    AddConstant('AD_APPLY_BUFFERED_REFRESH',AD_APPLY_BUFFERED_REFRESH);
    AddConstant('WPSTYLE_CENTER',WPSTYLE_CENTER);
    AddConstant('WPSTYLE_TILE',WPSTYLE_TILE);
    AddConstant('WPSTYLE_STRETCH',WPSTYLE_STRETCH);
    AddConstant('WPSTYLE_MAX',WPSTYLE_MAX);
    AddConstant('COMP_ELEM_TYPE',COMP_ELEM_TYPE);
    AddConstant('COMP_ELEM_CHECKED',COMP_ELEM_CHECKED);
    AddConstant('COMP_ELEM_DIRTY',COMP_ELEM_DIRTY);
    AddConstant('COMP_ELEM_NOSCROLL',COMP_ELEM_NOSCROLL);
    AddConstant('COMP_ELEM_POS_LEFT',COMP_ELEM_POS_LEFT);
    AddConstant('COMP_ELEM_POS_TOP',COMP_ELEM_POS_TOP);
    AddConstant('COMP_ELEM_SIZE_WIDTH',COMP_ELEM_SIZE_WIDTH);
    AddConstant('COMP_ELEM_SIZE_HEIGHT',COMP_ELEM_SIZE_HEIGHT);
    AddConstant('COMP_ELEM_POS_ZINDEX',COMP_ELEM_POS_ZINDEX);
    AddConstant('COMP_ELEM_SOURCE',COMP_ELEM_SOURCE);
    AddConstant('COMP_ELEM_FRIENDLYNAME',COMP_ELEM_FRIENDLYNAME);
    AddConstant('COMP_ELEM_SUBSCRIBEDURL',COMP_ELEM_SUBSCRIBEDURL);
    AddConstant('COMP_ELEM_ALL',COMP_ELEM_ALL);
    AddConstant('ADDURL_SILENT',ADDURL_SILENT);
    AddConstant('CFSTR_SHELLIDLIST',CFSTR_SHELLIDLIST);
    AddConstant('CFSTR_SHELLIDLISTOFFSET',CFSTR_SHELLIDLISTOFFSET);
    AddConstant('CFSTR_NETRESOURCES',CFSTR_NETRESOURCES);
    AddConstant('CFSTR_FILEDESCRIPTORA',CFSTR_FILEDESCRIPTORA);
    AddConstant('CFSTR_FILEDESCRIPTORW',CFSTR_FILEDESCRIPTORW);
    AddConstant('CFSTR_FILECONTENTS',CFSTR_FILECONTENTS);
    AddConstant('CFSTR_FILENAMEA',CFSTR_FILENAMEA);
    AddConstant('CFSTR_FILENAMEW',CFSTR_FILENAMEW);
    AddConstant('CFSTR_PRINTERGROUP',CFSTR_PRINTERGROUP);
    AddConstant('CFSTR_FILENAMEMAPA',CFSTR_FILENAMEMAPA);
    AddConstant('CFSTR_FILENAMEMAPW',CFSTR_FILENAMEMAPW);
    AddConstant('CFSTR_SHELLURL',CFSTR_SHELLURL);
    AddConstant('CFSTR_PREFERREDDROPEFFECT',CFSTR_PREFERREDDROPEFFECT);
    AddConstant('CFSTR_PERFORMEDDROPEFFECT',CFSTR_PERFORMEDDROPEFFECT);
    AddConstant('CFSTR_PASTESUCCEEDED',CFSTR_PASTESUCCEEDED);
    AddConstant('CFSTR_INDRAGLOOP',CFSTR_INDRAGLOOP);
    AddConstant('CFSTR_FILEDESCRIPTOR',CFSTR_FILEDESCRIPTOR);
    AddConstant('CFSTR_FILENAME',CFSTR_FILENAME);
    AddConstant('CFSTR_FILENAMEMAP',CFSTR_FILENAMEMAP);
    AddConstant('DVASPECT_SHORTNAME',DVASPECT_SHORTNAME);
    AddConstant('FD_CLSID',FD_CLSID);
    AddConstant('FD_SIZEPOINT',FD_SIZEPOINT);
    AddConstant('FD_ATTRIBUTES',FD_ATTRIBUTES);
    AddConstant('FD_CREATETIME',FD_CREATETIME);
    AddConstant('FD_ACCESSTIME',FD_ACCESSTIME);
    AddConstant('FD_WRITESTIME',FD_WRITESTIME);
    AddConstant('FD_FILESIZE',FD_FILESIZE);
    AddConstant('FD_LINKUI',FD_LINKUI);
    AddConstant('SHCNE_RENAMEITEM',SHCNE_RENAMEITEM);
    AddConstant('SHCNE_CREATE',SHCNE_CREATE);
    AddConstant('SHCNE_DELETE',SHCNE_DELETE);
    AddConstant('SHCNE_MKDIR',SHCNE_MKDIR);
    AddConstant('SHCNE_RMDIR',SHCNE_RMDIR);
    AddConstant('SHCNE_MEDIAINSERTED',SHCNE_MEDIAINSERTED);
    AddConstant('SHCNE_MEDIAREMOVED',SHCNE_MEDIAREMOVED);
    AddConstant('SHCNE_DRIVEREMOVED',SHCNE_DRIVEREMOVED);
    AddConstant('SHCNE_DRIVEADD',SHCNE_DRIVEADD);
    AddConstant('SHCNE_NETSHARE',SHCNE_NETSHARE);
    AddConstant('SHCNE_NETUNSHARE',SHCNE_NETUNSHARE);
    AddConstant('SHCNE_ATTRIBUTES',SHCNE_ATTRIBUTES);
    AddConstant('SHCNE_UPDATEDIR',SHCNE_UPDATEDIR);
    AddConstant('SHCNE_UPDATEITEM',SHCNE_UPDATEITEM);
    AddConstant('SHCNE_SERVERDISCONNECT',SHCNE_SERVERDISCONNECT);
    AddConstant('SHCNE_UPDATEIMAGE',SHCNE_UPDATEIMAGE);
    AddConstant('SHCNE_DRIVEADDGUI',SHCNE_DRIVEADDGUI);
    AddConstant('SHCNE_RENAMEFOLDER',SHCNE_RENAMEFOLDER);
    AddConstant('SHCNE_FREESPACE',SHCNE_FREESPACE);
    AddConstant('SHCNE_EXTENDED_EVENT',SHCNE_EXTENDED_EVENT);
    AddConstant('SHCNE_EXTENDED_EVENT_PRE_IE4',SHCNE_EXTENDED_EVENT_PRE_IE4);
    AddConstant('SHCNE_ASSOCCHANGED',SHCNE_ASSOCCHANGED);
    AddConstant('SHCNE_DISKEVENTS',SHCNE_DISKEVENTS);
    AddConstant('SHCNE_GLOBALEVENTS',SHCNE_GLOBALEVENTS);
    AddConstant('SHCNE_ALLEVENTS',SHCNE_ALLEVENTS);
    AddConstant('SHCNE_INTERRUPT',SHCNE_INTERRUPT);
    AddConstant('SHCNEE_THEMECHANGED',SHCNEE_THEMECHANGED);
    AddConstant('SHCNEE_ORDERCHANGED',SHCNEE_ORDERCHANGED);
    AddConstant('SHCNF_IDLIST',SHCNF_IDLIST);
    AddConstant('SHCNF_PATHA',SHCNF_PATHA);
    AddConstant('SHCNF_PRINTERA',SHCNF_PRINTERA);
    AddConstant('SHCNF_DWORD',SHCNF_DWORD);
    AddConstant('SHCNF_PATHW',SHCNF_PATHW);
    AddConstant('SHCNF_PRINTERW',SHCNF_PRINTERW);
    AddConstant('SHCNF_TYPE',SHCNF_TYPE);
    AddConstant('SHCNF_FLUSH',SHCNF_FLUSH);
    AddConstant('SHCNF_FLUSHNOWAIT',SHCNF_FLUSHNOWAIT);
    AddConstant('SHCNF_PATH',SHCNF_PATH);
    AddConstant('SHCNF_PRINTER',SHCNF_PRINTER);
    AddConstant('QIF_CACHED',QIF_CACHED);
    AddConstant('QIF_DONTEXPANDFOLDER',QIF_DONTEXPANDFOLDER);
    AddConstant('DI_GETDRAGIMAGE',DI_GETDRAGIMAGE);
    AddConstant('SHARD_PIDL',SHARD_PIDL);
    AddConstant('SHARD_PATHA',SHARD_PATHA);
    AddConstant('SHARD_PATHW',SHARD_PATHW);
    AddConstant('SHARD_PATH',SHARD_PATH);
    AddConstant('SHGDFIL_FINDDATA',SHGDFIL_FINDDATA);
    AddConstant('SHGDFIL_NETRESOURCE',SHGDFIL_NETRESOURCE);
    AddConstant('SHGDFIL_DESCRIPTIONID',SHGDFIL_DESCRIPTIONID);
    AddConstant('SHDID_ROOT_REGITEM',SHDID_ROOT_REGITEM);
    AddConstant('SHDID_FS_FILE',SHDID_FS_FILE);
    AddConstant('SHDID_FS_DIRECTORY',SHDID_FS_DIRECTORY);
    AddConstant('SHDID_FS_OTHER',SHDID_FS_OTHER);
    AddConstant('SHDID_COMPUTER_DRIVE35',SHDID_COMPUTER_DRIVE35);
    AddConstant('SHDID_COMPUTER_DRIVE525',SHDID_COMPUTER_DRIVE525);
    AddConstant('SHDID_COMPUTER_REMOVABLE',SHDID_COMPUTER_REMOVABLE);
    AddConstant('SHDID_COMPUTER_FIXED',SHDID_COMPUTER_FIXED);
    AddConstant('SHDID_COMPUTER_NETDRIVE',SHDID_COMPUTER_NETDRIVE);
    AddConstant('SHDID_COMPUTER_CDROM',SHDID_COMPUTER_CDROM);
    AddConstant('SHDID_COMPUTER_RAMDISK',SHDID_COMPUTER_RAMDISK);
    AddConstant('SHDID_COMPUTER_OTHER',SHDID_COMPUTER_OTHER);
    AddConstant('SHDID_NET_DOMAIN',SHDID_NET_DOMAIN);
    AddConstant('SHDID_NET_SERVER',SHDID_NET_SERVER);
    AddConstant('SHDID_NET_SHARE',SHDID_NET_SHARE);
    AddConstant('SHDID_NET_RESTOFNET',SHDID_NET_RESTOFNET);
    AddConstant('SHDID_NET_OTHER',SHDID_NET_OTHER);
    AddConstant('PID_IS_URL',PID_IS_URL);
    AddConstant('PID_IS_NAME',PID_IS_NAME);
    AddConstant('PID_IS_WORKINGDIR',PID_IS_WORKINGDIR);
    AddConstant('PID_IS_HOTKEY',PID_IS_HOTKEY);
    AddConstant('PID_IS_SHOWCMD',PID_IS_SHOWCMD);
    AddConstant('PID_IS_ICONINDEX',PID_IS_ICONINDEX);
    AddConstant('PID_IS_ICONFILE',PID_IS_ICONFILE);
    AddConstant('PID_IS_WHATSNEW',PID_IS_WHATSNEW);
    AddConstant('PID_IS_AUTHOR',PID_IS_AUTHOR);
    AddConstant('PID_IS_DESCRIPTION',PID_IS_DESCRIPTION);
    AddConstant('PID_IS_COMMENT',PID_IS_COMMENT);
    AddConstant('PID_INTSITE_WHATSNEW',PID_INTSITE_WHATSNEW);
    AddConstant('PID_INTSITE_AUTHOR',PID_INTSITE_AUTHOR);
    AddConstant('PID_INTSITE_LASTVISIT',PID_INTSITE_LASTVISIT);
    AddConstant('PID_INTSITE_LASTMOD',PID_INTSITE_LASTMOD);
    AddConstant('PID_INTSITE_VISITCOUNT',PID_INTSITE_VISITCOUNT);
    AddConstant('PID_INTSITE_DESCRIPTION',PID_INTSITE_DESCRIPTION);
    AddConstant('PID_INTSITE_COMMENT',PID_INTSITE_COMMENT);
    AddConstant('PID_INTSITE_FLAGS',PID_INTSITE_FLAGS);
    AddConstant('PID_INTSITE_CONTENTLEN',PID_INTSITE_CONTENTLEN);
    AddConstant('PID_INTSITE_CONTENTCODE',PID_INTSITE_CONTENTCODE);
    AddConstant('PID_INTSITE_RECURSE',PID_INTSITE_RECURSE);
    AddConstant('PID_INTSITE_WATCH',PID_INTSITE_WATCH);
    AddConstant('PID_INTSITE_SUBSCRIPTION',PID_INTSITE_SUBSCRIPTION);
    AddConstant('PID_INTSITE_URL',PID_INTSITE_URL);
    AddConstant('PID_INTSITE_TITLE',PID_INTSITE_TITLE);
    AddConstant('PID_INTSITE_CODEPAGE',PID_INTSITE_CODEPAGE);
    AddConstant('PID_INTSITE_TRACKING',PID_INTSITE_TRACKING);
    AddConstant('PIDISF_RECENTLYCHANGED',PIDISF_RECENTLYCHANGED);
    AddConstant('PIDISF_CACHEDSTICKY',PIDISF_CACHEDSTICKY);
    AddConstant('PIDISF_CACHEIMAGES',PIDISF_CACHEIMAGES);
    AddConstant('PIDISF_FOLLOWALLLINKS',PIDISF_FOLLOWALLLINKS);
    AddConstant('PIDISM_GLOBAL',PIDISM_GLOBAL);
    AddConstant('PIDISM_WATCH',PIDISM_WATCH);
    AddConstant('PIDISM_DONTWATCH',PIDISM_DONTWATCH);
    AddConstant('SSF_SHOWALLOBJECTS',SSF_SHOWALLOBJECTS);
    AddConstant('SSF_SHOWEXTENSIONS',SSF_SHOWEXTENSIONS);
    AddConstant('SSF_SHOWCOMPCOLOR',SSF_SHOWCOMPCOLOR);
    AddConstant('SSF_SHOWSYSFILES',SSF_SHOWSYSFILES);
    AddConstant('SSF_DOUBLECLICKINWEBVIEW',SSF_DOUBLECLICKINWEBVIEW);
    AddConstant('SSF_SHOWATTRIBCOL',SSF_SHOWATTRIBCOL);
    AddConstant('SSF_DESKTOPHTML',SSF_DESKTOPHTML);
    AddConstant('SSF_WIN95CLASSIC',SSF_WIN95CLASSIC);
    AddConstant('SSF_DONTPRETTYPATH',SSF_DONTPRETTYPATH);
    AddConstant('SSF_SHOWINFOTIP',SSF_SHOWINFOTIP);
    AddConstant('SSF_MAPNETDRVBUTTON',SSF_MAPNETDRVBUTTON);
    AddConstant('SSF_NOCONFIRMRECYCLE',SSF_NOCONFIRMRECYCLE);
    AddConstant('SSF_HIDEICONS',SSF_HIDEICONS);
    AddConstant('ACO_NONE',ACO_NONE);
    AddConstant('ACO_AUTOSUGGEST',ACO_AUTOSUGGEST);
    AddConstant('ACO_AUTOAPPEND',ACO_AUTOAPPEND);
    AddConstant('ACO_SEARCH',ACO_SEARCH);
    AddConstant('ACO_FILTERPREFIXES',ACO_FILTERPREFIXES);
    AddConstant('ACO_USETAB',ACO_USETAB);
    AddConstant('ACO_UPDOWNKEYDROPSLIST',ACO_UPDOWNKEYDROPSLIST);
    AddConstant('ACO_RTLREADING',ACO_RTLREADING);
    AddConstant('SID_IModalWindow',SID_IModalWindow);
    AddConstant('SID_IEnumShellItem',SID_IEnumShellItem);
    AddConstant('SID_IShellItem',SID_IShellItem);
    AddConstant('SID_IShellItemFilter',SID_IShellItemFilter);
    AddConstant('SID_IShellItemArray',SID_IShellItemArray);
    AddConstant('SID_IPropertyStore',SID_IPropertyStore);
    AddConstant('SID_IPropertyDescriptionList',SID_IPropertyDescriptionList);
    AddConstant('SID_IFileOperationProgressSink',SID_IFileOperationProgressSink);
    AddConstant('SID_IFileDialogCustomize',SID_IFileDialogCustomize);
    AddConstant('SID_IFileDialogEvents',SID_IFileDialogEvents);
    AddConstant('SID_IFileDialogControlEvents',SID_IFileDialogControlEvents);
    AddConstant('SID_IFileDialog',SID_IFileDialog);
    AddConstant('SID_IFileOpenDialog',SID_IFileOpenDialog);
    AddConstant('SID_IFileSaveDialog',SID_IFileSaveDialog);
    AddConstant('GPS_DEFAULT',GPS_DEFAULT);
    AddConstant('GPS_HANDLERPROPERTIESONLY',GPS_HANDLERPROPERTIESONLY);
    AddConstant('GPS_READWRITE',GPS_READWRITE);
    AddConstant('GPS_TEMPORARY',GPS_TEMPORARY);
    AddConstant('GPS_FASTPROPERTIESONLY',GPS_FASTPROPERTIESONLY);
    AddConstant('GPS_OPENSLOWITEM',GPS_OPENSLOWITEM);
    AddConstant('GPS_DELAYCREATION',GPS_DELAYCREATION);
    AddConstant('GPS_BESTEFFORT',GPS_BESTEFFORT);
    AddConstant('GPS_MASK_VALID',GPS_MASK_VALID);
    AddConstant('SIGDN_NORMALDISPLAY',SIGDN_NORMALDISPLAY);
    AddConstant('SIGDN_PARENTRELATIVEPARSING',SIGDN_PARENTRELATIVEPARSING);
    AddConstant('SIGDN_DESKTOPABSOLUTEPARSING',SIGDN_DESKTOPABSOLUTEPARSING);
    AddConstant('SIGDN_PARENTRELATIVEEDITING',SIGDN_PARENTRELATIVEEDITING);
    AddConstant('SIGDN_DESKTOPABSOLUTEEDITING',SIGDN_DESKTOPABSOLUTEEDITING);
    AddConstant('SIGDN_FILESYSPATH',SIGDN_FILESYSPATH);
    AddConstant('SIGDN_URL',SIGDN_URL);
    AddConstant('SIGDN_PARENTRELATIVEFORADDRESSBAR',SIGDN_PARENTRELATIVEFORADDRESSBAR);
    AddConstant('SIGDN_PARENTRELATIVE',SIGDN_PARENTRELATIVE);
    AddConstant('SICHINT_DISPLAY',SICHINT_DISPLAY);
    AddConstant('SICHINT_ALLFIELDS',SICHINT_ALLFIELDS);
    AddConstant('SICHINT_CANONICAL',SICHINT_CANONICAL);
    AddConstant('SIATTRIBFLAGS_AND',SIATTRIBFLAGS_AND);
    AddConstant('SIATTRIBFLAGS_OR',SIATTRIBFLAGS_OR);
    AddConstant('SIATTRIBFLAGS_APPCOMPAT',SIATTRIBFLAGS_APPCOMPAT);
    AddConstant('SIATTRIBFLAGS_MASK',SIATTRIBFLAGS_MASK);
    AddConstant('CDCS_INACTIVE',CDCS_INACTIVE);
    AddConstant('CDCS_ENABLED',CDCS_ENABLED);
    AddConstant('CDCS_VISIBLE',CDCS_VISIBLE);
    AddConstant('FDEOR_DEFAULT',FDEOR_DEFAULT);
    AddConstant('FDEOR_ACCEPT',FDEOR_ACCEPT);
    AddConstant('FDEOR_REFUSE',FDEOR_REFUSE);
    AddConstant('FDESVR_DEFAULT',FDESVR_DEFAULT);
    AddConstant('FDESVR_ACCEPT',FDESVR_ACCEPT);
    AddConstant('FDESVR_REFUSE',FDESVR_REFUSE);
    AddConstant('FDAP_BOTTOM',FDAP_BOTTOM);
    AddConstant('FDAP_TOP',FDAP_TOP);
    AddConstant('FOS_OVERWRITEPROMPT',FOS_OVERWRITEPROMPT);
    AddConstant('FOS_STRICTFILETYPES',FOS_STRICTFILETYPES);
    AddConstant('FOS_NOCHANGEDIR',FOS_NOCHANGEDIR);
    AddConstant('FOS_PICKFOLDERS',FOS_PICKFOLDERS);
    AddConstant('FOS_FORCEFILESYSTEM',FOS_FORCEFILESYSTEM);
    AddConstant('FOS_ALLNONSTORAGEITEMS',FOS_ALLNONSTORAGEITEMS);
    AddConstant('FOS_NOVALIDATE',FOS_NOVALIDATE);
    AddConstant('FOS_ALLOWMULTISELECT',FOS_ALLOWMULTISELECT);
    AddConstant('FOS_PATHMUSTEXIST',FOS_PATHMUSTEXIST);
    AddConstant('FOS_FILEMUSTEXIST',FOS_FILEMUSTEXIST);
    AddConstant('FOS_CREATEPROMPT',FOS_CREATEPROMPT);
    AddConstant('FOS_SHAREAWARE',FOS_SHAREAWARE);
    AddConstant('FOS_NOREADONLYRETURN',FOS_NOREADONLYRETURN);
    AddConstant('FOS_NOTESTFILECREATE',FOS_NOTESTFILECREATE);
    AddConstant('FOS_HIDEMRUPLACES',FOS_HIDEMRUPLACES);
    AddConstant('FOS_HIDEPINNEDPLACES',FOS_HIDEPINNEDPLACES);
    AddConstant('FOS_NODEREFERENCELINKS',FOS_NODEREFERENCELINKS);
    AddConstant('FOS_DONTADDTORECENT',FOS_DONTADDTORECENT);
    AddConstant('FOS_FORCESHOWHIDDEN',FOS_FORCESHOWHIDDEN);
    AddConstant('FOS_DEFAULTNOMINIMODE',FOS_DEFAULTNOMINIMODE);
    AddConstant('FOS_FORCEPREVIEWPANEON',FOS_FORCEPREVIEWPANEON);
  end;
end;

class function TatShlObjLibrary.LibraryName: string;
begin
  result := 'ShlObj';
end;

initialization
  RegisterScripterLibrary(TatShlObjLibrary, True);

{$WARNINGS ON}

end.

