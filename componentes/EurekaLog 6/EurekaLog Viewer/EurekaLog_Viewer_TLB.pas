unit EurekaLog_Viewer_TLB;

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
// File generated on 21/07/2008 11.24.47 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Lavoro\EurekaLog\EurekaLog Viewer\EurekaLog_Viewer.tlb (1)
// LIBID: {C5904013-9FFE-4BFB-A5CD-0F483E9FD28F}
// LCID: 0
// Helpfile: 
// HelpString: EurekaLog_Viewer Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
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
  EurekaLog_ViewerMajorVersion = 1;
  EurekaLog_ViewerMinorVersion = 0;

  LIBID_EurekaLog_Viewer: TGUID = '{C5904013-9FFE-4BFB-A5CD-0F483E9FD28F}';

  IID_ILink: TGUID = '{8F34B81F-0131-4F30-B5CF-95C03B4DFAFA}';
  CLASS_Link: TGUID = '{C466031D-1932-4BB3-B807-5F3397162A5F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ILink = interface;
  ILinkDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Link = ILink;


// *********************************************************************//
// Interface: ILink
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8F34B81F-0131-4F30-B5CF-95C03B4DFAFA}
// *********************************************************************//
  ILink = interface(IDispatch)
    ['{8F34B81F-0131-4F30-B5CF-95C03B4DFAFA}']
    procedure AddFiles(Files: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  ILinkDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8F34B81F-0131-4F30-B5CF-95C03B4DFAFA}
// *********************************************************************//
  ILinkDisp = dispinterface
    ['{8F34B81F-0131-4F30-B5CF-95C03B4DFAFA}']
    procedure AddFiles(Files: OleVariant); dispid 201;
  end;

// *********************************************************************//
// The Class CoLink provides a Create and CreateRemote method to          
// create instances of the default interface ILink exposed by              
// the CoClass Link. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLink = class
    class function Create: ILink;
    class function CreateRemote(const MachineName: string): ILink;
  end;

implementation

uses ComObj;

class function CoLink.Create: ILink;
begin
  Result := CreateComObject(CLASS_Link) as ILink;
end;

class function CoLink.CreateRemote(const MachineName: string): ILink;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Link) as ILink;
end;

end.
