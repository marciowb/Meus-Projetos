unit cxWebHTMLHostIntf;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 4/9/2002 1:08:09 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: cxWebHTMLHostIntf.tlb (1)
// LIBID: {95B6E854-AE90-4BD6-8356-342851C367FF}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  cxWebHTMLHostIntfMajorVersion = 1;
  cxWebHTMLHostIntfMinorVersion = 0;

  LIBID_cxWebHTMLHostIntf: TGUID = '{95B6E854-AE90-4BD6-8356-342851C367FF}';

  IID_IHostDialogHelper: TGUID = '{53DEC138-A51E-11D2-861E-00C04FA35C89}';
  CLASS_HostDialogHelper: TGUID = '{429AF92C-A51F-11D2-861E-00C04FA35C89}';
  IID_IDocHostUIHandler: TGUID = '{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}';
  IID_IDocHostUIHandler2: TGUID = '{3050F6D0-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_ICustomDoc: TGUID = '{3050F3F0-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IDocHostShowUI: TGUID = '{C4D244B0-D43E-11CF-893B-00AA00BDCE1A}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum tagDOCHOSTUITYPE
type
  tagDOCHOSTUITYPE = TOleEnum;
const
  DOCHOSTUITYPE_BROWSE = $00000000;
  DOCHOSTUITYPE_AUTHOR = $00000001;

// Constants for enum tagDOCHOSTUIDBLCLK
type
  tagDOCHOSTUIDBLCLK = TOleEnum;
const
  DOCHOSTUIDBLCLK_DEFAULT = $00000000;
  DOCHOSTUIDBLCLK_SHOWPROPERTIES = $00000001;
  DOCHOSTUIDBLCLK_SHOWCODE = $00000002;

// Constants for enum tagDOCHOSTUIFLAG
type
  tagDOCHOSTUIFLAG = TOleEnum;
const
  DOCHOSTUIFLAG_DIALOG = $00000001;
  DOCHOSTUIFLAG_DISABLE_HELP_MENU = $00000002;
  DOCHOSTUIFLAG_NO3DBORDER = $00000004;
  DOCHOSTUIFLAG_SCROLL_NO = $00000008;
  DOCHOSTUIFLAG_DISABLE_SCRIPT_INACTIVE = $00000010;
  DOCHOSTUIFLAG_OPENNEWWIN = $00000020;
  DOCHOSTUIFLAG_DISABLE_OFFSCREEN = $00000040;
  DOCHOSTUIFLAG_FLAT_SCROLLBAR = $00000080;
  DOCHOSTUIFLAG_DIV_BLOCKDEFAULT = $00000100;
  DOCHOSTUIFLAG_ACTIVATE_CLIENTHIT_ONLY = $00000200;
  DOCHOSTUIFLAG_OVERRIDEBEHAVIORFACTORY = $00000400;
  DOCHOSTUIFLAG_CODEPAGELINKEDFONTS = $00000800;
  DOCHOSTUIFLAG_URL_ENCODING_DISABLE_UTF8 = $00001000;
  DOCHOSTUIFLAG_URL_ENCODING_ENABLE_UTF8 = $00002000;
  DOCHOSTUIFLAG_ENABLE_FORMS_AUTOCOMPLETE = $00004000;
  DOCHOSTUIFLAG_ENABLE_INPLACE_NAVIGATION = $00010000;
  DOCHOSTUIFLAG_IME_ENABLE_RECONVERSION = $00020000;
  DOCHOSTUIFLAG_THEME = $00040000;
  DOCHOSTUIFLAG_NOTHEME = $00080000;
  DOCHOSTUIFLAG_NOPICS = $00100000;
  DOCHOSTUIFLAG_NO3DOUTERBORDER = $00200000;
  DOCHOSTUIFLAG_DISABLE_EDIT_NS_FIXUP = $00400000;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IHostDialogHelper = interface;
  IDocHostUIHandler = interface;
  IDocHostUIHandler2 = interface;
  ICustomDoc = interface;
  IDocHostShowUI = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  HostDialogHelper = IHostDialogHelper;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^Integer; {*}
  POleVariant1 = ^OleVariant; {*}
  PSmallint1 = ^Smallint; {*}
  PUserType1 = ^TGUID; {*}

  DOCHOSTUIINFO = packed record
    cbSize: LongWord;
    dwFlags: LongWord;
    dwDoubleClick: LongWord;
    pchHostCss: PWideChar;
    pchHostNS: PWideChar;
  end;


// *********************************************************************//
// Interface: IHostDialogHelper
// Flags:     (0)
// GUID:      {53DEC138-A51E-11D2-861E-00C04FA35C89}
// *********************************************************************//
  IHostDialogHelper = interface(IUnknown)
    ['{53DEC138-A51E-11D2-861E-00C04FA35C89}']
    function ShowHTMLDialog(var hwndParent: Integer; const pMk: IUnknown; 
                            var pvarArgIn: OleVariant; var pchOptions: Smallint; 
                            var pvarArgOut: OleVariant; const punkHost: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDocHostUIHandler
// Flags:     (0)
// GUID:      {BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}
// *********************************************************************//
  IDocHostUIHandler = interface(IUnknown)
    ['{BD3F23C0-D43E-11CF-893B-00AA00BDCE1A}']
    function ShowContextMenu(dwID: LongWord; ppt: PPoint; const pcmdtReserved: IUnknown;
                             const pdispReserved: IDispatch): HResult; stdcall;
    function GetHostInfo(var pInfo: DOCHOSTUIINFO): HResult; stdcall;
    function ShowUI(dwID: LongWord; const pActiveObject: IUnknown; const pCommandTarget: IUnknown; 
                    const pFrame: IUnknown; const pDoc: IUnknown): HResult; stdcall;
    function HideUI: HResult; stdcall;
    function UpdateUI: HResult; stdcall;
    function EnableModeless(fEnable: Integer): HResult; stdcall;
    function OnDocWindowActivate(fActivate: Integer): HResult; stdcall;
    function OnFrameWindowActivate(fActivate: Integer): HResult; stdcall;
    function ResizeBorder(var prcBorder: Integer; const pUIWindow: IUnknown; fRameWindow: Integer): HResult; stdcall;
    function TranslateAccelerator(lpmsg: PMsg; pguidCmdGroup: PGUID; nCmdID: LongWord): HResult; stdcall;
    function GetOptionKeyPath(out pchKey: PWideChar; dw: LongWord): HResult; stdcall;
    function GetDropTarget(const pDropTarget: IUnknown; var ppDropTarget: IUnknown): HResult; stdcall;
    function GetExternal(var ppDispatch: IDispatch): HResult; stdcall;
    function TranslateUrl(dwTranslate: LongWord; const pchURLIn: PWideChar; out ppchURLOut: PWideChar): HResult; stdcall;
    function FilterDataObject(const pDO: IUnknown; var ppDORet: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDocHostUIHandler2
// Flags:     (0)
// GUID:      {3050F6D0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IDocHostUIHandler2 = interface(IDocHostUIHandler)
    ['{3050F6D0-98B5-11CF-BB82-00AA00BDCE0B}']
    function GetOverrideKeyPath(out pchKey: PWideChar; dw: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ICustomDoc
// Flags:     (0)
// GUID:      {3050F3F0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  ICustomDoc = interface(IUnknown)
    ['{3050F3F0-98B5-11CF-BB82-00AA00BDCE0B}']
    function SetUIHandler(const pUIHandler: IDocHostUIHandler): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDocHostShowUI
// Flags:     (0)
// GUID:      {C4D244B0-D43E-11CF-893B-00AA00BDCE1A}
// *********************************************************************//
  IDocHostShowUI = interface(IUnknown)
    ['{C4D244B0-D43E-11CF-893B-00AA00BDCE1A}']
    function ShowMessage(hwnd: THandle; lpstrText, lpstrCaption: PWideChar; dwType: LongWord; lpstrHelpFile: PWideChar;
                         dwHelpContext: LongWord; var plResult: LongInt): HResult; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: PWideChar; uCommand: LongWord; dwData: LongWord;
                      ptMouse: TPoint; var pDispatchObjectHit: IDispatch): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoHostDialogHelper provides a Create and CreateRemote method to
// create instances of the default interface IHostDialogHelper exposed by
// the CoClass HostDialogHelper. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHostDialogHelper = class
    class function Create: IHostDialogHelper;
    class function CreateRemote(const MachineName: string): IHostDialogHelper;
  end;

implementation

uses ComObj;

class function CoHostDialogHelper.Create: IHostDialogHelper;
begin
  Result := CreateComObject(CLASS_HostDialogHelper) as IHostDialogHelper;
end;

class function CoHostDialogHelper.CreateRemote(const MachineName: string): IHostDialogHelper;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HostDialogHelper) as IHostDialogHelper;
end;

end.
