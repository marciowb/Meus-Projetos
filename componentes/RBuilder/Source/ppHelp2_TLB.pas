unit ppHelp2_TLB;

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

// PASTLWTR : 1.2
// File generated on 11/9/2004 5:51:16 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Common Files\Microsoft Shared\MSEnv\vshelp.tlb (1)
// LIBID: {83285928-227C-11D3-B870-00C04F79F802}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
// Errors:
//   Hint: Member 'Help' of 'Help' changed to 'Help_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  VsHelpMajorVersion = 1;
  VsHelpMinorVersion = 0;

  LIBID_VsHelp: TGUID = '{83285928-227C-11D3-B870-00C04F79F802}';

  IID_IVsHelpOwner: TGUID = '{B9B0983A-364C-4866-873F-D5ED190138FB}';
  IID_IVsHelpTopicShowEvents: TGUID = '{D1AAC64A-6A25-4274-B2C6-BC3B840B6E54}';
  IID_Help: TGUID = '{4A791148-19E4-11D3-B86B-00C04F79F802}';
  IID_IVsHelpEvents: TGUID = '{507E4490-5A8C-11D3-B897-00C04F79F802}';
  CLASS_DExploreAppObj: TGUID = '{4A79114D-19E4-11D3-B86B-00C04F79F802}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IVsHelpOwner = interface;
  IVsHelpOwnerDisp = dispinterface;
  IVsHelpTopicShowEvents = interface;
  Help = interface;
  HelpDisp = dispinterface;
  IVsHelpEvents = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DExploreAppObj = Help;


// *********************************************************************//
// Interface: IVsHelpOwner
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B9B0983A-364C-4866-873F-D5ED190138FB}
// *********************************************************************//
  IVsHelpOwner = interface(IDispatch)
    ['{B9B0983A-364C-4866-873F-D5ED190138FB}']
    procedure BringHelpToTop(hwndHelpApp: Integer); safecall;
    function Get_AutomationObject: IDispatch; safecall;
    property AutomationObject: IDispatch read Get_AutomationObject;
  end;

// *********************************************************************//
// DispIntf:  IVsHelpOwnerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B9B0983A-364C-4866-873F-D5ED190138FB}
// *********************************************************************//
  IVsHelpOwnerDisp = dispinterface
    ['{B9B0983A-364C-4866-873F-D5ED190138FB}']
    procedure BringHelpToTop(hwndHelpApp: Integer); dispid 1;
    property AutomationObject: IDispatch readonly dispid 10;
  end;

// *********************************************************************//
// Interface: IVsHelpTopicShowEvents
// Flags:     (4096) Dispatchable
// GUID:      {D1AAC64A-6A25-4274-B2C6-BC3B840B6E54}
// *********************************************************************//
  IVsHelpTopicShowEvents = interface(IDispatch)
    ['{D1AAC64A-6A25-4274-B2C6-BC3B840B6E54}']
    function OnBeforeTopicShow(const bstrURL: WideString; const pWB: IDispatch): HResult; stdcall;
    function OnTopicShowComplete(const bstrURL: WideString; const pWB: IDispatch): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: Help
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A791148-19E4-11D3-B86B-00C04F79F802}
// *********************************************************************//
  Help = interface(IDispatch)
    ['{4A791148-19E4-11D3-B86B-00C04F79F802}']
    procedure Contents; safecall;
    procedure Index; safecall;
    procedure Search; safecall;
    procedure IndexResults; safecall;
    procedure SearchResults; safecall;
    procedure DisplayTopicFromId(const bstrFile: WideString; Id: LongWord); safecall;
    procedure DisplayTopicFromURL(const pszURL: WideString); safecall;
    procedure DisplayTopicFromURLEx(const pszURL: WideString; 
                                    const pIVsHelpTopicShowEvents: IVsHelpTopicShowEvents); safecall;
    procedure DisplayTopicFromKeyword(const pszKeyword: WideString); safecall;
    procedure DisplayTopicFromF1Keyword(const pszKeyword: WideString); safecall;
    procedure DisplayTopicFrom_OLD_Help(const bstrFile: WideString; Id: LongWord); safecall;
    procedure SyncContents(const bstrURL: WideString); safecall;
    procedure CanSyncContents(const bstrURL: WideString); safecall;
    function GetNextTopic(const bstrURL: WideString): WideString; safecall;
    function GetPrevTopic(const bstrURL: WideString): WideString; safecall;
    procedure FilterUI; safecall;
    procedure CanShowFilterUI; safecall;
    procedure Close; safecall;
    procedure SyncIndex(const bstrKeyword: WideString; fShow: Integer); safecall;
    procedure SetCollection(const bstrCollection: WideString; const bstrFilter: WideString); safecall;
    function Get_Collection: WideString; safecall;
    function Get_Filter: WideString; safecall;
    procedure Set_Filter(const pbstrFilter: WideString); safecall;
    function Get_FilterQuery: WideString; safecall;
    function Get_HelpOwner: IVsHelpOwner; safecall;
    procedure Set_HelpOwner(const ppObj: IVsHelpOwner); safecall;
    function Get_HxSession: IDispatch; safecall;
    function Get_Help_: IDispatch; safecall;
    function GetObject(const bstrMoniker: WideString; const bstrOptions: WideString): IDispatch; safecall;
    property Collection: WideString read Get_Collection;
    property Filter: WideString read Get_Filter write Set_Filter;
    property FilterQuery: WideString read Get_FilterQuery;
    property HelpOwner: IVsHelpOwner read Get_HelpOwner write Set_HelpOwner;
    property HxSession: IDispatch read Get_HxSession;
    property Help_: IDispatch read Get_Help_;
  end;

// *********************************************************************//
// DispIntf:  HelpDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {4A791148-19E4-11D3-B86B-00C04F79F802}
// *********************************************************************//
  HelpDisp = dispinterface
    ['{4A791148-19E4-11D3-B86B-00C04F79F802}']
    procedure Contents; dispid 1;
    procedure Index; dispid 2;
    procedure Search; dispid 3;
    procedure IndexResults; dispid 4;
    procedure SearchResults; dispid 5;
    procedure DisplayTopicFromId(const bstrFile: WideString; Id: LongWord); dispid 6;
    procedure DisplayTopicFromURL(const pszURL: WideString); dispid 7;
    procedure DisplayTopicFromURLEx(const pszURL: WideString; 
                                    const pIVsHelpTopicShowEvents: IVsHelpTopicShowEvents); dispid 8;
    procedure DisplayTopicFromKeyword(const pszKeyword: WideString); dispid 9;
    procedure DisplayTopicFromF1Keyword(const pszKeyword: WideString); dispid 10;
    procedure DisplayTopicFrom_OLD_Help(const bstrFile: WideString; Id: LongWord); dispid 11;
    procedure SyncContents(const bstrURL: WideString); dispid 12;
    procedure CanSyncContents(const bstrURL: WideString); dispid 13;
    function GetNextTopic(const bstrURL: WideString): WideString; dispid 14;
    function GetPrevTopic(const bstrURL: WideString): WideString; dispid 15;
    procedure FilterUI; dispid 16;
    procedure CanShowFilterUI; dispid 17;
    procedure Close; dispid 18;
    procedure SyncIndex(const bstrKeyword: WideString; fShow: Integer); dispid 19;
    procedure SetCollection(const bstrCollection: WideString; const bstrFilter: WideString); dispid 20;
    property Collection: WideString readonly dispid 21;
    property Filter: WideString dispid 22;
    property FilterQuery: WideString readonly dispid 23;
    property HelpOwner: IVsHelpOwner dispid 24;
    property HxSession: IDispatch readonly dispid 25;
    property Help_: IDispatch readonly dispid 26;
    function GetObject(const bstrMoniker: WideString; const bstrOptions: WideString): IDispatch; dispid 27;
  end;

// *********************************************************************//
// Interface: IVsHelpEvents
// Flags:     (4096) Dispatchable
// GUID:      {507E4490-5A8C-11D3-B897-00C04F79F802}
// *********************************************************************//
  IVsHelpEvents = interface(IDispatch)
    ['{507E4490-5A8C-11D3-B897-00C04F79F802}']
    function OnFilterChanged(const bstrNewFilter: WideString): HResult; stdcall;
    function OnCollectionChanged(const bstrNewCollection: WideString; 
                                 const bstrNewFilter: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoDExploreAppObj provides a Create and CreateRemote method to          
// create instances of the default interface Help exposed by              
// the CoClass DExploreAppObj. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDExploreAppObj = class
    class function Create: Help;
    class function CreateRemote(const MachineName: string): Help;
  end;

implementation

uses ComObj;

class function CoDExploreAppObj.Create: Help;
begin
  Result := CreateComObject(CLASS_DExploreAppObj) as Help;
end;

class function CoDExploreAppObj.CreateRemote(const MachineName: string): Help;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DExploreAppObj) as Help;
end;

end.
