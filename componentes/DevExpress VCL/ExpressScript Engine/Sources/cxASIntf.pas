unit cxASIntf;

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

// PASTLWTR : $Revision:   1.130.3.0.1.0  $
// File generated on 10/30/2001 4:15:18 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: \cxASIntf.tlb (1)
// LIBID: {9A8BDD6A-80F6-4C23-977F-E15BB5E03925}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses Windows, ActiveX, Classes, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  cxASIntfMajorVersion = 1;
  cxASIntfMinorVersion = 0;

  LIBID_cxASIntf: TGUID = '{9A8BDD6A-80F6-4C23-977F-E15BB5E03925}';

  IID_IActiveScriptSite: TGUID = '{DB01A1E3-A42B-11CF-8F20-00805F2CD064}';
  IID_IActiveScriptError: TGUID = '{EAE1BA61-A4ED-11CF-8F20-00805F2CD064}';
  IID_IActiveScriptSiteWindow: TGUID = '{D10F6761-83E9-11CF-8F20-00805F2CD064}';
  IID_IActiveScript: TGUID = '{BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}';
  IID_IActiveScriptParse: TGUID = '{BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum tagSCRIPTITEM
type
  tagSCRIPTITEM = TOleEnum;
const
  SCRIPTITEM_ISVISIBLE = $00000002;
  SCRIPTITEM_ISSOURCE = $00000004;
  SCRIPTITEM_GLOBALMEMBERS = $00000008;
  SCRIPTITEM_ISPERSISTENT = $00000028;
  SCRIPTITEM_CODEONLY = $000000C8;
  SCRIPTITEM_NOCODE = $00000190;

// Constants for enum tagSCRIPTINFO
type
  tagSCRIPTINFO = TOleEnum;
const
  SCRIPTINFO_IUNKNOWN = $00000001;
  SCRIPTINFO_ITYPEINFO = $00000002;

// Constants for enum tagSCRIPTSTATE
type
  tagSCRIPTSTATE = TOleEnum;
const
  SCRIPTSTATE_UNINITIALIZED = $00000000;
  SCRIPTSTATE_INITIALIZED = $00000005;
  SCRIPTSTATE_STARTED = $00000001;
  SCRIPTSTATE_CONNECTED = $00000002;
  SCRIPTSTATE_DISCONNECTED = $00000003;
  SCRIPTSTATE_CLOSED = $00000004;

// Constants for enum tagSCRIPTTHREADSTATE
type
  tagSCRIPTTHREADSTATE = TOleEnum;
const
  SCRIPTTHREADSTATE_NOTINSCRIPT = $00000000;
  SCRIPTTHREADSTATE_RUNNING = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IActiveScriptSite = interface;
  IActiveScriptError = interface;
  IActiveScriptSiteWindow = interface;
  IActiveScript = interface;
  IActiveScriptParse = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  wireHWND = ^Integer; 
  POleVariant1 = ^OleVariant; {*}
  PUserType1 = ^EXCEPINFO; {*}
  PInteger1 = ^Integer; {*}
  PUserType2 = ^TGUID; {*}


// *********************************************************************//
// Interface: IActiveScriptSite
// Flags:     (2048) Replaceable
// GUID:      {DB01A1E3-A42B-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptSite = interface(IUnknown)
    ['{DB01A1E3-A42B-11CF-8F20-00805F2CD064}']
    function GetLCID(out plcid: LongWord): HResult; stdcall;
    function GetItemInfo(pstrName: PWideChar; dwReturnMask: LongWord; out ppiunkItem: IUnknown; 
                         out ppti: IUnknown): HResult; stdcall;
    function GetDocVersionString(out pbstrVersion: WideString): HResult; stdcall;
    function OnScriptTerminate(var pvarResult: OleVariant; var pexcepinfo: EXCEPINFO): HResult; stdcall;
    function OnStateChange(ssScriptState: tagSCRIPTSTATE): HResult; stdcall;
    function OnScriptError(const pscripterror: IActiveScriptError): HResult; stdcall;
    function OnEnterScript: HResult; stdcall;
    function OnLeaveScript: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IActiveScriptError
// Flags:     (0)
// GUID:      {EAE1BA61-A4ED-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptError = interface(IUnknown)
    ['{EAE1BA61-A4ED-11CF-8F20-00805F2CD064}']
    function GetExceptionInfo(out pexcepinfo: EXCEPINFO): HResult; stdcall;
    function GetSourcePosition(out pdwSourceContext: LongWord; out pulLineNumber: LongWord; 
                               out plCharacterPosition: Integer): HResult; stdcall;
    function GetSourceLineText(out pbstrSourceLine: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IActiveScriptSiteWindow
// Flags:     (0)
// GUID:      {D10F6761-83E9-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptSiteWindow = interface(IUnknown)
    ['{D10F6761-83E9-11CF-8F20-00805F2CD064}']
    function GetWindow(out phwnd: PInteger1): HResult; stdcall;
    function EnableModeless(fEnable: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IActiveScript
// Flags:     (0)
// GUID:      {BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScript = interface(IUnknown)
    ['{BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}']
    function SetScriptSite(const pass: IActiveScriptSite): HResult; stdcall;
    function GetScriptSite(var riid: TGUID; out ppvObject: Pointer): HResult; stdcall;
    function SetScriptState(ss: tagSCRIPTSTATE): HResult; stdcall;
    function GetScriptState(out pssState: tagSCRIPTSTATE): HResult; stdcall;
    function Close: HResult; stdcall;
    function AddNamedItem(pstrName: PWideChar; dwFlags: LongWord): HResult; stdcall;
    function AddTypeLib(var rguidTypeLib: TGUID; dwMajor: LongWord; dwMinor: LongWord; 
                        dwFlags: LongWord): HResult; stdcall;
    function GetScriptDispatch(pstrItemName: PWideChar; out ppdisp: IDispatch): HResult; stdcall;
    function GetCurrentScriptThreadID(out pstidThread: LongWord): HResult; stdcall;
    function GetScriptThreadID(dwWin32ThreadId: LongWord; out pstidThread: LongWord): HResult; stdcall;
    function GetScriptThreadState(stidThread: LongWord; out pstsState: tagSCRIPTTHREADSTATE): HResult; stdcall;
    function InterruptScriptThread(stidThread: LongWord; var pexcepinfo: EXCEPINFO; 
                                   dwFlags: LongWord): HResult; stdcall;
    function Clone(out ppscript: IActiveScript): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IActiveScriptParse
// Flags:     (0)
// GUID:      {BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptParse = interface(IUnknown)
    ['{BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}']
    function InitNew: HResult; stdcall;
    function AddScriptlet(pstrDefaultName: PWideChar; pstrCode: PWideChar; pstrItemName: PWideChar; 
                          pstrSubItemName: PWideChar; pstrEventName: PWideChar; 
                          pstrDelimiter: PWideChar; dwSourceContextCookie: LongWord; 
                          ulStartingLineNumber: LongWord; dwFlags: LongWord; 
                          out pBstrName: WideString; out pexcepinfo: EXCEPINFO): HResult; stdcall;
    function  ParseScriptText {Flags(1), (9/9) CC:4, INV:1, DBG:6}({VT_31:0}pstrCode: PWideChar;
                                                                   {VT_31:0}pstrItemName: PWideChar;
                                                                   {VT_13:0}const punkContext: IUnknown;
                                                                   {VT_31:0}pstrDelimiter: PWideChar;
                                                                   {VT_19:0}dwSourceContextCookie: LongWord;
                                                                   {VT_19:0}ulStartingLineNumber: LongWord;
                                                                   {VT_19:0}dwFlags: LongWord;
                                                                   {VT_12:1}pvarResult: Pointer;
                                                                   {VT_29:1}out pexcepinfo: EXCEPINFO): HResult; stdcall;
                          
{
    function ParseScriptText(pstrCode: PWideChar; pstrItemName: PWideChar;
                             const punkContext: IUnknown; pstrDelimiter: PWideChar;
                             dwSourceContextCookie: LongWord; ulStartingLineNumber: LongWord;
                             dwFlags: LongWord; out pvarResult: OleVariant;
                             out pexcepinfo: EXCEPINFO): HResult; stdcall;
}
  end;

implementation

uses ComObj;

end.
