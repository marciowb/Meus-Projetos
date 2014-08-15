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
unit ap_OleDlg;

interface

uses
  Windows,
  CommCtrl,
  ActiveX,
  OleDlg,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatOleDlgLibrary = class(TatScripterLibrary)
    procedure __OleUIInsertObject(AMachine: TatVirtualMachine);
    procedure __OleUIInsertObjectA(AMachine: TatVirtualMachine);
    procedure __OleUIInsertObjectW(AMachine: TatVirtualMachine);
    procedure __OleUIPasteSpecial(AMachine: TatVirtualMachine);
    procedure __OleUIPasteSpecialA(AMachine: TatVirtualMachine);
    procedure __OleUIPasteSpecialW(AMachine: TatVirtualMachine);
    procedure __OleUIEditLinks(AMachine: TatVirtualMachine);
    procedure __OleUIEditLinksA(AMachine: TatVirtualMachine);
    procedure __OleUIEditLinksW(AMachine: TatVirtualMachine);
    procedure __OleUIChangeIcon(AMachine: TatVirtualMachine);
    procedure __OleUIChangeIconA(AMachine: TatVirtualMachine);
    procedure __OleUIChangeIconW(AMachine: TatVirtualMachine);
    procedure __OleUIConvert(AMachine: TatVirtualMachine);
    procedure __OleUIConvertA(AMachine: TatVirtualMachine);
    procedure __OleUIConvertW(AMachine: TatVirtualMachine);
    procedure __OleUICanConvertOrActivateAs(AMachine: TatVirtualMachine);
    procedure __OleUIBusy(AMachine: TatVirtualMachine);
    procedure __OleUIBusyA(AMachine: TatVirtualMachine);
    procedure __OleUIBusyW(AMachine: TatVirtualMachine);
    procedure __OleUIObjectProperties(AMachine: TatVirtualMachine);
    procedure __OleUIObjectPropertiesA(AMachine: TatVirtualMachine);
    procedure __OleUIObjectPropertiesW(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagOLEUIINSERTOBJECTAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FcchFile: Integer;
    FcClsidExclude: Integer;
    FoleRender: Longint;
    Fsc: HResult;
    FhMetaPict: HGlobal;
  public
    constructor Create(ARecord: tagOLEUIINSERTOBJECTA);
    function ObjToRec: tagOLEUIINSERTOBJECTA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property cchFile: Integer read FcchFile write FcchFile;
    property cClsidExclude: Integer read FcClsidExclude write FcClsidExclude;
    property oleRender: Longint read FoleRender write FoleRender;
    property sc: HResult read Fsc write Fsc;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
  end;
  
  tagOLEUIINSERTOBJECTWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FcchFile: Integer;
    FcClsidExclude: Integer;
    FoleRender: Longint;
    Fsc: HResult;
    FhMetaPict: HGlobal;
  public
    constructor Create(ARecord: tagOLEUIINSERTOBJECTW);
    function ObjToRec: tagOLEUIINSERTOBJECTW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property cchFile: Integer read FcchFile write FcchFile;
    property cClsidExclude: Integer read FcClsidExclude write FcClsidExclude;
    property oleRender: Longint read FoleRender write FoleRender;
    property sc: HResult read Fsc write Fsc;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
  end;
  
  tagOLEUIPASTEENTRYAWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FdwScratchSpace: DWORD;
  public
    constructor Create(ARecord: tagOLEUIPASTEENTRYA);
    function ObjToRec: tagOLEUIPASTEENTRYA;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwScratchSpace: DWORD read FdwScratchSpace write FdwScratchSpace;
  end;
  
  tagOLEUIPASTEENTRYWWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FdwScratchSpace: DWORD;
  public
    constructor Create(ARecord: tagOLEUIPASTEENTRYW);
    function ObjToRec: tagOLEUIPASTEENTRYW;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwScratchSpace: DWORD read FdwScratchSpace write FdwScratchSpace;
  end;
  
  tagOLEUIPASTESPECIALAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FcPasteEntries: Integer;
    FcLinkTypes: Integer;
    FcClsidExclude: Integer;
    FnSelectedIndex: Integer;
    FfLink: BOOL;
    FhMetaPict: HGlobal;
  public
    constructor Create(ARecord: tagOLEUIPASTESPECIALA);
    function ObjToRec: tagOLEUIPASTESPECIALA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property cPasteEntries: Integer read FcPasteEntries write FcPasteEntries;
    property cLinkTypes: Integer read FcLinkTypes write FcLinkTypes;
    property cClsidExclude: Integer read FcClsidExclude write FcClsidExclude;
    property nSelectedIndex: Integer read FnSelectedIndex write FnSelectedIndex;
    property fLink: BOOL read FfLink write FfLink;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
  end;
  
  tagOLEUIPASTESPECIALWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FcPasteEntries: Integer;
    FcLinkTypes: Integer;
    FcClsidExclude: Integer;
    FnSelectedIndex: Integer;
    FfLink: BOOL;
    FhMetaPict: HGlobal;
  public
    constructor Create(ARecord: tagOLEUIPASTESPECIALW);
    function ObjToRec: tagOLEUIPASTESPECIALW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property cPasteEntries: Integer read FcPasteEntries write FcPasteEntries;
    property cLinkTypes: Integer read FcLinkTypes write FcLinkTypes;
    property cClsidExclude: Integer read FcClsidExclude write FcClsidExclude;
    property nSelectedIndex: Integer read FnSelectedIndex write FnSelectedIndex;
    property fLink: BOOL read FfLink write FfLink;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
  end;
  
  tagOLEUIEDITLINKSAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
  public
    constructor Create(ARecord: tagOLEUIEDITLINKSA);
    function ObjToRec: tagOLEUIEDITLINKSA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
  end;
  
  tagOLEUIEDITLINKSWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
  public
    constructor Create(ARecord: tagOLEUIEDITLINKSW);
    function ObjToRec: tagOLEUIEDITLINKSW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
  end;
  
  tagOLEUICHANGEICONAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FhMetaPict: HGlobal;
    FcchIconExe: Integer;
  public
    constructor Create(ARecord: tagOLEUICHANGEICONA);
    function ObjToRec: tagOLEUICHANGEICONA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
    property cchIconExe: Integer read FcchIconExe write FcchIconExe;
  end;
  
  tagOLEUICHANGEICONWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FhMetaPict: HGlobal;
    FcchIconExe: Integer;
  public
    constructor Create(ARecord: tagOLEUICHANGEICONW);
    function ObjToRec: tagOLEUICHANGEICONW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
    property cchIconExe: Integer read FcchIconExe write FcchIconExe;
  end;
  
  tagOLEUICONVERTAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FdvAspect: Longint;
    FwFormat: Word;
    FfIsLinkedObject: BOOL;
    FhMetaPict: HGlobal;
    FfObjectsIconChanged: BOOL;
    FcClsidExclude: Integer;
  public
    constructor Create(ARecord: tagOLEUICONVERTA);
    function ObjToRec: tagOLEUICONVERTA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property dvAspect: Longint read FdvAspect write FdvAspect;
    property wFormat: Word read FwFormat write FwFormat;
    property fIsLinkedObject: BOOL read FfIsLinkedObject write FfIsLinkedObject;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
    property fObjectsIconChanged: BOOL read FfObjectsIconChanged write FfObjectsIconChanged;
    property cClsidExclude: Integer read FcClsidExclude write FcClsidExclude;
  end;
  
  tagOLEUICONVERTWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    FdvAspect: Longint;
    FwFormat: Word;
    FfIsLinkedObject: BOOL;
    FhMetaPict: HGlobal;
    FfObjectsIconChanged: BOOL;
    FcClsidExclude: Integer;
  public
    constructor Create(ARecord: tagOLEUICONVERTW);
    function ObjToRec: tagOLEUICONVERTW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property dvAspect: Longint read FdvAspect write FdvAspect;
    property wFormat: Word read FwFormat write FwFormat;
    property fIsLinkedObject: BOOL read FfIsLinkedObject write FfIsLinkedObject;
    property hMetaPict: HGlobal read FhMetaPict write FhMetaPict;
    property fObjectsIconChanged: BOOL read FfObjectsIconChanged write FfObjectsIconChanged;
    property cClsidExclude: Integer read FcClsidExclude write FcClsidExclude;
  end;
  
  tagOLEUIBUSYAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    Ftask: HTask;
  public
    constructor Create(ARecord: tagOLEUIBUSYA);
    function ObjToRec: tagOLEUIBUSYA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property task: HTask read Ftask write Ftask;
  end;
  
  tagOLEUIBUSYWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FhWndOwner: HWnd;
    FlCustData: Longint;
    FhInstance: THandle;
    FhResource: HRsrc;
    Ftask: HTask;
  public
    constructor Create(ARecord: tagOLEUIBUSYW);
    function ObjToRec: tagOLEUIBUSYW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property lCustData: Longint read FlCustData write FlCustData;
    property hInstance: THandle read FhInstance write FhInstance;
    property hResource: HRsrc read FhResource write FhResource;
    property task: HTask read Ftask write Ftask;
  end;
  
  tagOLEUIGNRLPROPSAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FlCustData: Longint;
  public
    constructor Create(ARecord: tagOLEUIGNRLPROPSA);
    function ObjToRec: tagOLEUIGNRLPROPSA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property lCustData: Longint read FlCustData write FlCustData;
  end;
  
  tagOLEUIGNRLPROPSWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FlCustData: Longint;
  public
    constructor Create(ARecord: tagOLEUIGNRLPROPSW);
    function ObjToRec: tagOLEUIGNRLPROPSW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property lCustData: Longint read FlCustData write FlCustData;
  end;
  
  tagOLEUIVIEWPROPSAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FlCustData: Longint;
    FnScaleMin: Integer;
    FnScaleMax: Integer;
  public
    constructor Create(ARecord: tagOLEUIVIEWPROPSA);
    function ObjToRec: tagOLEUIVIEWPROPSA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property lCustData: Longint read FlCustData write FlCustData;
    property nScaleMin: Integer read FnScaleMin write FnScaleMin;
    property nScaleMax: Integer read FnScaleMax write FnScaleMax;
  end;
  
  tagOLEUIVIEWPROPSWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FlCustData: Longint;
    FnScaleMin: Integer;
    FnScaleMax: Integer;
  public
    constructor Create(ARecord: tagOLEUIVIEWPROPSW);
    function ObjToRec: tagOLEUIVIEWPROPSW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property lCustData: Longint read FlCustData write FlCustData;
    property nScaleMin: Integer read FnScaleMin write FnScaleMin;
    property nScaleMax: Integer read FnScaleMax write FnScaleMax;
  end;
  
  tagOLEUILINKPROPSAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FlCustData: Longint;
  public
    constructor Create(ARecord: tagOLEUILINKPROPSA);
    function ObjToRec: tagOLEUILINKPROPSA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property lCustData: Longint read FlCustData write FlCustData;
  end;
  
  tagOLEUILINKPROPSWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FlCustData: Longint;
  public
    constructor Create(ARecord: tagOLEUILINKPROPSW);
    function ObjToRec: tagOLEUILINKPROPSW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property lCustData: Longint read FlCustData write FlCustData;
  end;
  
  tagOLEUIOBJECTPROPSAWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FdwObject: Longint;
    FdwLink: Longint;
  public
    constructor Create(ARecord: tagOLEUIOBJECTPROPSA);
    function ObjToRec: tagOLEUIOBJECTPROPSA;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property dwObject: Longint read FdwObject write FdwObject;
    property dwLink: Longint read FdwLink write FdwLink;
  end;
  
  tagOLEUIOBJECTPROPSWWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FdwFlags: Longint;
    FdwObject: Longint;
    FdwLink: Longint;
  public
    constructor Create(ARecord: tagOLEUIOBJECTPROPSW);
    function ObjToRec: tagOLEUIOBJECTPROPSW;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property dwFlags: Longint read FdwFlags write FdwFlags;
    property dwObject: Longint read FdwObject write FdwObject;
    property dwLink: Longint read FdwLink write FdwLink;
  end;
  

implementation

constructor tagOLEUIINSERTOBJECTAWrapper.Create(ARecord: tagOLEUIINSERTOBJECTA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FcchFile := ARecord.cchFile;
  FcClsidExclude := ARecord.cClsidExclude;
  FoleRender := ARecord.oleRender;
  Fsc := ARecord.sc;
  FhMetaPict := ARecord.hMetaPict;
end;

function tagOLEUIINSERTOBJECTAWrapper.ObjToRec: tagOLEUIINSERTOBJECTA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.cchFile := FcchFile;
  result.cClsidExclude := FcClsidExclude;
  result.oleRender := FoleRender;
  result.sc := Fsc;
  result.hMetaPict := FhMetaPict;
end;

constructor tagOLEUIINSERTOBJECTWWrapper.Create(ARecord: tagOLEUIINSERTOBJECTW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FcchFile := ARecord.cchFile;
  FcClsidExclude := ARecord.cClsidExclude;
  FoleRender := ARecord.oleRender;
  Fsc := ARecord.sc;
  FhMetaPict := ARecord.hMetaPict;
end;

function tagOLEUIINSERTOBJECTWWrapper.ObjToRec: tagOLEUIINSERTOBJECTW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.cchFile := FcchFile;
  result.cClsidExclude := FcClsidExclude;
  result.oleRender := FoleRender;
  result.sc := Fsc;
  result.hMetaPict := FhMetaPict;
end;

constructor tagOLEUIPASTEENTRYAWrapper.Create(ARecord: tagOLEUIPASTEENTRYA);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwScratchSpace := ARecord.dwScratchSpace;
end;

function tagOLEUIPASTEENTRYAWrapper.ObjToRec: tagOLEUIPASTEENTRYA;
begin
  result.dwFlags := FdwFlags;
  result.dwScratchSpace := FdwScratchSpace;
end;

constructor tagOLEUIPASTEENTRYWWrapper.Create(ARecord: tagOLEUIPASTEENTRYW);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FdwScratchSpace := ARecord.dwScratchSpace;
end;

function tagOLEUIPASTEENTRYWWrapper.ObjToRec: tagOLEUIPASTEENTRYW;
begin
  result.dwFlags := FdwFlags;
  result.dwScratchSpace := FdwScratchSpace;
end;

constructor tagOLEUIPASTESPECIALAWrapper.Create(ARecord: tagOLEUIPASTESPECIALA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FcPasteEntries := ARecord.cPasteEntries;
  FcLinkTypes := ARecord.cLinkTypes;
  FcClsidExclude := ARecord.cClsidExclude;
  FnSelectedIndex := ARecord.nSelectedIndex;
  FfLink := ARecord.fLink;
  FhMetaPict := ARecord.hMetaPict;
end;

function tagOLEUIPASTESPECIALAWrapper.ObjToRec: tagOLEUIPASTESPECIALA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.cPasteEntries := FcPasteEntries;
  result.cLinkTypes := FcLinkTypes;
  result.cClsidExclude := FcClsidExclude;
  result.nSelectedIndex := FnSelectedIndex;
  result.fLink := FfLink;
  result.hMetaPict := FhMetaPict;
end;

constructor tagOLEUIPASTESPECIALWWrapper.Create(ARecord: tagOLEUIPASTESPECIALW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FcPasteEntries := ARecord.cPasteEntries;
  FcLinkTypes := ARecord.cLinkTypes;
  FcClsidExclude := ARecord.cClsidExclude;
  FnSelectedIndex := ARecord.nSelectedIndex;
  FfLink := ARecord.fLink;
  FhMetaPict := ARecord.hMetaPict;
end;

function tagOLEUIPASTESPECIALWWrapper.ObjToRec: tagOLEUIPASTESPECIALW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.cPasteEntries := FcPasteEntries;
  result.cLinkTypes := FcLinkTypes;
  result.cClsidExclude := FcClsidExclude;
  result.nSelectedIndex := FnSelectedIndex;
  result.fLink := FfLink;
  result.hMetaPict := FhMetaPict;
end;

constructor tagOLEUIEDITLINKSAWrapper.Create(ARecord: tagOLEUIEDITLINKSA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
end;

function tagOLEUIEDITLINKSAWrapper.ObjToRec: tagOLEUIEDITLINKSA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
end;

constructor tagOLEUIEDITLINKSWWrapper.Create(ARecord: tagOLEUIEDITLINKSW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
end;

function tagOLEUIEDITLINKSWWrapper.ObjToRec: tagOLEUIEDITLINKSW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
end;

constructor tagOLEUICHANGEICONAWrapper.Create(ARecord: tagOLEUICHANGEICONA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FhMetaPict := ARecord.hMetaPict;
  FcchIconExe := ARecord.cchIconExe;
end;

function tagOLEUICHANGEICONAWrapper.ObjToRec: tagOLEUICHANGEICONA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.hMetaPict := FhMetaPict;
  result.cchIconExe := FcchIconExe;
end;

constructor tagOLEUICHANGEICONWWrapper.Create(ARecord: tagOLEUICHANGEICONW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FhMetaPict := ARecord.hMetaPict;
  FcchIconExe := ARecord.cchIconExe;
end;

function tagOLEUICHANGEICONWWrapper.ObjToRec: tagOLEUICHANGEICONW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.hMetaPict := FhMetaPict;
  result.cchIconExe := FcchIconExe;
end;

constructor tagOLEUICONVERTAWrapper.Create(ARecord: tagOLEUICONVERTA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FdvAspect := ARecord.dvAspect;
  FwFormat := ARecord.wFormat;
  FfIsLinkedObject := ARecord.fIsLinkedObject;
  FhMetaPict := ARecord.hMetaPict;
  FfObjectsIconChanged := ARecord.fObjectsIconChanged;
  FcClsidExclude := ARecord.cClsidExclude;
end;

function tagOLEUICONVERTAWrapper.ObjToRec: tagOLEUICONVERTA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.dvAspect := FdvAspect;
  result.wFormat := FwFormat;
  result.fIsLinkedObject := FfIsLinkedObject;
  result.hMetaPict := FhMetaPict;
  result.fObjectsIconChanged := FfObjectsIconChanged;
  result.cClsidExclude := FcClsidExclude;
end;

constructor tagOLEUICONVERTWWrapper.Create(ARecord: tagOLEUICONVERTW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  FdvAspect := ARecord.dvAspect;
  FwFormat := ARecord.wFormat;
  FfIsLinkedObject := ARecord.fIsLinkedObject;
  FhMetaPict := ARecord.hMetaPict;
  FfObjectsIconChanged := ARecord.fObjectsIconChanged;
  FcClsidExclude := ARecord.cClsidExclude;
end;

function tagOLEUICONVERTWWrapper.ObjToRec: tagOLEUICONVERTW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.dvAspect := FdvAspect;
  result.wFormat := FwFormat;
  result.fIsLinkedObject := FfIsLinkedObject;
  result.hMetaPict := FhMetaPict;
  result.fObjectsIconChanged := FfObjectsIconChanged;
  result.cClsidExclude := FcClsidExclude;
end;

constructor tagOLEUIBUSYAWrapper.Create(ARecord: tagOLEUIBUSYA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  Ftask := ARecord.task;
end;

function tagOLEUIBUSYAWrapper.ObjToRec: tagOLEUIBUSYA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.task := Ftask;
end;

constructor tagOLEUIBUSYWWrapper.Create(ARecord: tagOLEUIBUSYW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FhWndOwner := ARecord.hWndOwner;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FhResource := ARecord.hResource;
  Ftask := ARecord.task;
end;

function tagOLEUIBUSYWWrapper.ObjToRec: tagOLEUIBUSYW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.hWndOwner := FhWndOwner;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.hResource := FhResource;
  result.task := Ftask;
end;

constructor tagOLEUIGNRLPROPSAWrapper.Create(ARecord: tagOLEUIGNRLPROPSA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FlCustData := ARecord.lCustData;
end;

function tagOLEUIGNRLPROPSAWrapper.ObjToRec: tagOLEUIGNRLPROPSA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.lCustData := FlCustData;
end;

constructor tagOLEUIGNRLPROPSWWrapper.Create(ARecord: tagOLEUIGNRLPROPSW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FlCustData := ARecord.lCustData;
end;

function tagOLEUIGNRLPROPSWWrapper.ObjToRec: tagOLEUIGNRLPROPSW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.lCustData := FlCustData;
end;

constructor tagOLEUIVIEWPROPSAWrapper.Create(ARecord: tagOLEUIVIEWPROPSA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FlCustData := ARecord.lCustData;
  FnScaleMin := ARecord.nScaleMin;
  FnScaleMax := ARecord.nScaleMax;
end;

function tagOLEUIVIEWPROPSAWrapper.ObjToRec: tagOLEUIVIEWPROPSA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.lCustData := FlCustData;
  result.nScaleMin := FnScaleMin;
  result.nScaleMax := FnScaleMax;
end;

constructor tagOLEUIVIEWPROPSWWrapper.Create(ARecord: tagOLEUIVIEWPROPSW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FlCustData := ARecord.lCustData;
  FnScaleMin := ARecord.nScaleMin;
  FnScaleMax := ARecord.nScaleMax;
end;

function tagOLEUIVIEWPROPSWWrapper.ObjToRec: tagOLEUIVIEWPROPSW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.lCustData := FlCustData;
  result.nScaleMin := FnScaleMin;
  result.nScaleMax := FnScaleMax;
end;

constructor tagOLEUILINKPROPSAWrapper.Create(ARecord: tagOLEUILINKPROPSA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FlCustData := ARecord.lCustData;
end;

function tagOLEUILINKPROPSAWrapper.ObjToRec: tagOLEUILINKPROPSA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.lCustData := FlCustData;
end;

constructor tagOLEUILINKPROPSWWrapper.Create(ARecord: tagOLEUILINKPROPSW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FlCustData := ARecord.lCustData;
end;

function tagOLEUILINKPROPSWWrapper.ObjToRec: tagOLEUILINKPROPSW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.lCustData := FlCustData;
end;

constructor tagOLEUIOBJECTPROPSAWrapper.Create(ARecord: tagOLEUIOBJECTPROPSA);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FdwObject := ARecord.dwObject;
  FdwLink := ARecord.dwLink;
end;

function tagOLEUIOBJECTPROPSAWrapper.ObjToRec: tagOLEUIOBJECTPROPSA;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.dwObject := FdwObject;
  result.dwLink := FdwLink;
end;

constructor tagOLEUIOBJECTPROPSWWrapper.Create(ARecord: tagOLEUIOBJECTPROPSW);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FdwFlags := ARecord.dwFlags;
  FdwObject := ARecord.dwObject;
  FdwLink := ARecord.dwLink;
end;

function tagOLEUIOBJECTPROPSWWrapper.ObjToRec: tagOLEUIOBJECTPROPSW;
begin
  result.cbStruct := FcbStruct;
  result.dwFlags := FdwFlags;
  result.dwObject := FdwObject;
  result.dwLink := FdwLink;
end;



procedure TatOleDlgLibrary.__OleUIInsertObject(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIInsertObject;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIINSERTOBJECTWWrapper) then 
  Param0Rec := tagOLEUIINSERTOBJECTWWrapper.Create(Param0);
Param0 := tagOLEUIINSERTOBJECTWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIInsertObject(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIINSERTOBJECTWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIInsertObjectA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIInsertObjectA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIINSERTOBJECTAWrapper) then 
  Param0Rec := tagOLEUIINSERTOBJECTAWrapper.Create(Param0);
Param0 := tagOLEUIINSERTOBJECTAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIInsertObjectA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIINSERTOBJECTAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIInsertObjectW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIInsertObjectW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIINSERTOBJECTWWrapper) then 
  Param0Rec := tagOLEUIINSERTOBJECTWWrapper.Create(Param0);
Param0 := tagOLEUIINSERTOBJECTWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIInsertObjectW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIINSERTOBJECTWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIPasteSpecial(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIPasteSpecial;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIPASTESPECIALWWrapper) then 
  Param0Rec := tagOLEUIPASTESPECIALWWrapper.Create(Param0);
Param0 := tagOLEUIPASTESPECIALWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIPasteSpecial(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIPASTESPECIALWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIPasteSpecialA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIPasteSpecialA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIPASTESPECIALAWrapper) then 
  Param0Rec := tagOLEUIPASTESPECIALAWrapper.Create(Param0);
Param0 := tagOLEUIPASTESPECIALAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIPasteSpecialA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIPASTESPECIALAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIPasteSpecialW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIPasteSpecialW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIPASTESPECIALWWrapper) then 
  Param0Rec := tagOLEUIPASTESPECIALWWrapper.Create(Param0);
Param0 := tagOLEUIPASTESPECIALWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIPasteSpecialW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIPASTESPECIALWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIEditLinks(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIEditLinks;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIEDITLINKSWWrapper) then 
  Param0Rec := tagOLEUIEDITLINKSWWrapper.Create(Param0);
Param0 := tagOLEUIEDITLINKSWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIEditLinks(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIEDITLINKSWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIEditLinksA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIEditLinksA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIEDITLINKSAWrapper) then 
  Param0Rec := tagOLEUIEDITLINKSAWrapper.Create(Param0);
Param0 := tagOLEUIEDITLINKSAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIEditLinksA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIEDITLINKSAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIEditLinksW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIEditLinksW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIEDITLINKSWWrapper) then 
  Param0Rec := tagOLEUIEDITLINKSWWrapper.Create(Param0);
Param0 := tagOLEUIEDITLINKSWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIEditLinksW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIEDITLINKSWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIChangeIcon(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIChangeIcon;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUICHANGEICONWWrapper) then 
  Param0Rec := tagOLEUICHANGEICONWWrapper.Create(Param0);
Param0 := tagOLEUICHANGEICONWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIChangeIcon(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUICHANGEICONWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIChangeIconA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIChangeIconA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUICHANGEICONAWrapper) then 
  Param0Rec := tagOLEUICHANGEICONAWrapper.Create(Param0);
Param0 := tagOLEUICHANGEICONAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIChangeIconA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUICHANGEICONAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIChangeIconW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIChangeIconW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUICHANGEICONWWrapper) then 
  Param0Rec := tagOLEUICHANGEICONWWrapper.Create(Param0);
Param0 := tagOLEUICHANGEICONWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIChangeIconW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUICHANGEICONWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIConvert(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIConvert;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUICONVERTWWrapper) then 
  Param0Rec := tagOLEUICONVERTWWrapper.Create(Param0);
Param0 := tagOLEUICONVERTWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIConvert(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUICONVERTWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIConvertA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIConvertA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUICONVERTAWrapper) then 
  Param0Rec := tagOLEUICONVERTAWrapper.Create(Param0);
Param0 := tagOLEUICONVERTAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIConvertA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUICONVERTAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIConvertW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIConvertW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUICONVERTWWrapper) then 
  Param0Rec := tagOLEUICONVERTWWrapper.Create(Param0);
Param0 := tagOLEUICONVERTWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIConvertW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUICONVERTWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUICanConvertOrActivateAs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := OleDlg.OleUICanConvertOrActivateAs(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleDlgLibrary.__OleUIBusy(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIBusy;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIBUSYWWrapper) then 
  Param0Rec := tagOLEUIBUSYWWrapper.Create(Param0);
Param0 := tagOLEUIBUSYWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIBusy(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIBUSYWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIBusyA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIBusyA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIBUSYAWrapper) then 
  Param0Rec := tagOLEUIBUSYAWrapper.Create(Param0);
Param0 := tagOLEUIBUSYAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIBusyA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIBUSYAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIBusyW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIBusyW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIBUSYWWrapper) then 
  Param0Rec := tagOLEUIBUSYWWrapper.Create(Param0);
Param0 := tagOLEUIBUSYWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIBusyW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIBUSYWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIObjectProperties(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIObjectProps;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIOBJECTPROPSWWrapper) then 
  Param0Rec := tagOLEUIOBJECTPROPSWWrapper.Create(Param0);
Param0 := tagOLEUIOBJECTPROPSWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIObjectProperties(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIOBJECTPROPSWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIObjectPropertiesA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIObjectPropsA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIOBJECTPROPSAWrapper) then 
  Param0Rec := tagOLEUIOBJECTPROPSAWrapper.Create(Param0);
Param0 := tagOLEUIOBJECTPROPSAWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIObjectPropertiesA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIOBJECTPROPSAWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.__OleUIObjectPropertiesW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOleUIObjectPropsW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOLEUIOBJECTPROPSWWrapper) then 
  Param0Rec := tagOLEUIOBJECTPROPSWWrapper.Create(Param0);
Param0 := tagOLEUIOBJECTPROPSWWrapper(Param0Rec).ObjToRec;
AResult := Integer(OleDlg.OleUIObjectPropertiesW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOLEUIOBJECTPROPSWWrapper.Create(Param0)));
  end;
end;

procedure TatOleDlgLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('OleUIInsertObject',1,tkInteger,nil,__OleUIInsertObject,false,0).SetVarArgs([0]);
    DefineMethod('OleUIInsertObjectA',1,tkInteger,nil,__OleUIInsertObjectA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIInsertObjectW',1,tkInteger,nil,__OleUIInsertObjectW,false,0).SetVarArgs([0]);
    DefineMethod('OleUIPasteSpecial',1,tkInteger,nil,__OleUIPasteSpecial,false,0).SetVarArgs([0]);
    DefineMethod('OleUIPasteSpecialA',1,tkInteger,nil,__OleUIPasteSpecialA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIPasteSpecialW',1,tkInteger,nil,__OleUIPasteSpecialW,false,0).SetVarArgs([0]);
    DefineMethod('OleUIEditLinks',1,tkInteger,nil,__OleUIEditLinks,false,0).SetVarArgs([0]);
    DefineMethod('OleUIEditLinksA',1,tkInteger,nil,__OleUIEditLinksA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIEditLinksW',1,tkInteger,nil,__OleUIEditLinksW,false,0).SetVarArgs([0]);
    DefineMethod('OleUIChangeIcon',1,tkInteger,nil,__OleUIChangeIcon,false,0).SetVarArgs([0]);
    DefineMethod('OleUIChangeIconA',1,tkInteger,nil,__OleUIChangeIconA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIChangeIconW',1,tkInteger,nil,__OleUIChangeIconW,false,0).SetVarArgs([0]);
    DefineMethod('OleUIConvert',1,tkInteger,nil,__OleUIConvert,false,0).SetVarArgs([0]);
    DefineMethod('OleUIConvertA',1,tkInteger,nil,__OleUIConvertA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIConvertW',1,tkInteger,nil,__OleUIConvertW,false,0).SetVarArgs([0]);
    DefineMethod('OleUICanConvertOrActivateAs',3,tkVariant,nil,__OleUICanConvertOrActivateAs,false,0);
    DefineMethod('OleUIBusy',1,tkInteger,nil,__OleUIBusy,false,0).SetVarArgs([0]);
    DefineMethod('OleUIBusyA',1,tkInteger,nil,__OleUIBusyA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIBusyW',1,tkInteger,nil,__OleUIBusyW,false,0).SetVarArgs([0]);
    DefineMethod('OleUIObjectProperties',1,tkInteger,nil,__OleUIObjectProperties,false,0).SetVarArgs([0]);
    DefineMethod('OleUIObjectPropertiesA',1,tkInteger,nil,__OleUIObjectPropertiesA,false,0).SetVarArgs([0]);
    DefineMethod('OleUIObjectPropertiesW',1,tkInteger,nil,__OleUIObjectPropertiesW,false,0).SetVarArgs([0]);
    AddConstant('IDC_OLEUIHELP',IDC_OLEUIHELP);
    AddConstant('IDC_IO_CREATENEW',IDC_IO_CREATENEW);
    AddConstant('IDC_IO_CREATEFROMFILE',IDC_IO_CREATEFROMFILE);
    AddConstant('IDC_IO_LINKFILE',IDC_IO_LINKFILE);
    AddConstant('IDC_IO_OBJECTTYPELIST',IDC_IO_OBJECTTYPELIST);
    AddConstant('IDC_IO_DISPLAYASICON',IDC_IO_DISPLAYASICON);
    AddConstant('IDC_IO_CHANGEICON',IDC_IO_CHANGEICON);
    AddConstant('IDC_IO_FILE',IDC_IO_FILE);
    AddConstant('IDC_IO_FILEDISPLAY',IDC_IO_FILEDISPLAY);
    AddConstant('IDC_IO_RESULTIMAGE',IDC_IO_RESULTIMAGE);
    AddConstant('IDC_IO_RESULTTEXT',IDC_IO_RESULTTEXT);
    AddConstant('IDC_IO_ICONDISPLAY',IDC_IO_ICONDISPLAY);
    AddConstant('IDC_IO_OBJECTTYPETEXT',IDC_IO_OBJECTTYPETEXT);
    AddConstant('IDC_IO_FILETEXT',IDC_IO_FILETEXT);
    AddConstant('IDC_IO_FILETYPE',IDC_IO_FILETYPE);
    AddConstant('IDC_IO_INSERTCONTROL',IDC_IO_INSERTCONTROL);
    AddConstant('IDC_IO_ADDCONTROL',IDC_IO_ADDCONTROL);
    AddConstant('IDC_IO_CONTROLTYPELIST',IDC_IO_CONTROLTYPELIST);
    AddConstant('IDC_PS_PASTE',IDC_PS_PASTE);
    AddConstant('IDC_PS_PASTELINK',IDC_PS_PASTELINK);
    AddConstant('IDC_PS_SOURCETEXT',IDC_PS_SOURCETEXT);
    AddConstant('IDC_PS_PASTELIST',IDC_PS_PASTELIST);
    AddConstant('IDC_PS_PASTELINKLIST',IDC_PS_PASTELINKLIST);
    AddConstant('IDC_PS_DISPLAYLIST',IDC_PS_DISPLAYLIST);
    AddConstant('IDC_PS_DISPLAYASICON',IDC_PS_DISPLAYASICON);
    AddConstant('IDC_PS_ICONDISPLAY',IDC_PS_ICONDISPLAY);
    AddConstant('IDC_PS_CHANGEICON',IDC_PS_CHANGEICON);
    AddConstant('IDC_PS_RESULTIMAGE',IDC_PS_RESULTIMAGE);
    AddConstant('IDC_PS_RESULTTEXT',IDC_PS_RESULTTEXT);
    AddConstant('IDC_CI_GROUP',IDC_CI_GROUP);
    AddConstant('IDC_CI_CURRENT',IDC_CI_CURRENT);
    AddConstant('IDC_CI_CURRENTICON',IDC_CI_CURRENTICON);
    AddConstant('IDC_CI_DEFAULT',IDC_CI_DEFAULT);
    AddConstant('IDC_CI_DEFAULTICON',IDC_CI_DEFAULTICON);
    AddConstant('IDC_CI_FROMFILE',IDC_CI_FROMFILE);
    AddConstant('IDC_CI_FROMFILEEDIT',IDC_CI_FROMFILEEDIT);
    AddConstant('IDC_CI_ICONLIST',IDC_CI_ICONLIST);
    AddConstant('IDC_CI_LABEL',IDC_CI_LABEL);
    AddConstant('IDC_CI_LABELEDIT',IDC_CI_LABELEDIT);
    AddConstant('IDC_CI_BROWSE',IDC_CI_BROWSE);
    AddConstant('IDC_CI_ICONDISPLAY',IDC_CI_ICONDISPLAY);
    AddConstant('IDC_CV_OBJECTTYPE',IDC_CV_OBJECTTYPE);
    AddConstant('IDC_CV_DISPLAYASICON',IDC_CV_DISPLAYASICON);
    AddConstant('IDC_CV_CHANGEICON',IDC_CV_CHANGEICON);
    AddConstant('IDC_CV_ACTIVATELIST',IDC_CV_ACTIVATELIST);
    AddConstant('IDC_CV_CONVERTTO',IDC_CV_CONVERTTO);
    AddConstant('IDC_CV_ACTIVATEAS',IDC_CV_ACTIVATEAS);
    AddConstant('IDC_CV_RESULTTEXT',IDC_CV_RESULTTEXT);
    AddConstant('IDC_CV_CONVERTLIST',IDC_CV_CONVERTLIST);
    AddConstant('IDC_CV_ICONDISPLAY',IDC_CV_ICONDISPLAY);
    AddConstant('IDC_EL_CHANGESOURCE',IDC_EL_CHANGESOURCE);
    AddConstant('IDC_EL_AUTOMATIC',IDC_EL_AUTOMATIC);
    AddConstant('IDC_EL_CANCELLINK',IDC_EL_CANCELLINK);
    AddConstant('IDC_EL_UPDATENOW',IDC_EL_UPDATENOW);
    AddConstant('IDC_EL_OPENSOURCE',IDC_EL_OPENSOURCE);
    AddConstant('IDC_EL_MANUAL',IDC_EL_MANUAL);
    AddConstant('IDC_EL_LINKSOURCE',IDC_EL_LINKSOURCE);
    AddConstant('IDC_EL_LINKTYPE',IDC_EL_LINKTYPE);
    AddConstant('IDC_EL_LINKSLISTBOX',IDC_EL_LINKSLISTBOX);
    AddConstant('IDC_EL_COL1',IDC_EL_COL1);
    AddConstant('IDC_EL_COL2',IDC_EL_COL2);
    AddConstant('IDC_EL_COL3',IDC_EL_COL3);
    AddConstant('IDC_BZ_RETRY',IDC_BZ_RETRY);
    AddConstant('IDC_BZ_ICON',IDC_BZ_ICON);
    AddConstant('IDC_BZ_MESSAGE1',IDC_BZ_MESSAGE1);
    AddConstant('IDC_BZ_SWITCHTO',IDC_BZ_SWITCHTO);
    AddConstant('IDC_UL_METER',IDC_UL_METER);
    AddConstant('IDC_UL_STOP',IDC_UL_STOP);
    AddConstant('IDC_UL_PERCENT',IDC_UL_PERCENT);
    AddConstant('IDC_UL_PROGRESS',IDC_UL_PROGRESS);
    AddConstant('IDC_PU_LINKS',IDC_PU_LINKS);
    AddConstant('IDC_PU_TEXT',IDC_PU_TEXT);
    AddConstant('IDC_PU_CONVERT',IDC_PU_CONVERT);
    AddConstant('IDC_PU_ICON',IDC_PU_ICON);
    AddConstant('IDC_GP_OBJECTNAME',IDC_GP_OBJECTNAME);
    AddConstant('IDC_GP_OBJECTTYPE',IDC_GP_OBJECTTYPE);
    AddConstant('IDC_GP_OBJECTSIZE',IDC_GP_OBJECTSIZE);
    AddConstant('IDC_GP_CONVERT',IDC_GP_CONVERT);
    AddConstant('IDC_GP_OBJECTICON',IDC_GP_OBJECTICON);
    AddConstant('IDC_GP_OBJECTLOCATION',IDC_GP_OBJECTLOCATION);
    AddConstant('IDC_VP_PERCENT',IDC_VP_PERCENT);
    AddConstant('IDC_VP_CHANGEICON',IDC_VP_CHANGEICON);
    AddConstant('IDC_VP_EDITABLE',IDC_VP_EDITABLE);
    AddConstant('IDC_VP_ASICON',IDC_VP_ASICON);
    AddConstant('IDC_VP_RELATIVE',IDC_VP_RELATIVE);
    AddConstant('IDC_VP_SPIN',IDC_VP_SPIN);
    AddConstant('IDC_VP_SCALETXT',IDC_VP_SCALETXT);
    AddConstant('IDC_VP_ICONDISPLAY',IDC_VP_ICONDISPLAY);
    AddConstant('IDC_VP_RESULTIMAGE',IDC_VP_RESULTIMAGE);
    AddConstant('IDC_LP_OPENSOURCE',IDC_LP_OPENSOURCE);
    AddConstant('IDC_LP_UPDATENOW',IDC_LP_UPDATENOW);
    AddConstant('IDC_LP_BREAKLINK',IDC_LP_BREAKLINK);
    AddConstant('IDC_LP_LINKSOURCE',IDC_LP_LINKSOURCE);
    AddConstant('IDC_LP_CHANGESOURCE',IDC_LP_CHANGESOURCE);
    AddConstant('IDC_LP_AUTOMATIC',IDC_LP_AUTOMATIC);
    AddConstant('IDC_LP_MANUAL',IDC_LP_MANUAL);
    AddConstant('IDC_LP_DATE',IDC_LP_DATE);
    AddConstant('IDC_LP_TIME',IDC_LP_TIME);
    AddConstant('IDD_INSERTOBJECT',IDD_INSERTOBJECT);
    AddConstant('IDD_CHANGEICON',IDD_CHANGEICON);
    AddConstant('IDD_CONVERT',IDD_CONVERT);
    AddConstant('IDD_PASTESPECIAL',IDD_PASTESPECIAL);
    AddConstant('IDD_EDITLINKS',IDD_EDITLINKS);
    AddConstant('IDD_BUSY',IDD_BUSY);
    AddConstant('IDD_UPDATELINKS',IDD_UPDATELINKS);
    AddConstant('IDD_CHANGESOURCE',IDD_CHANGESOURCE);
    AddConstant('IDD_INSERTFILEBROWSE',IDD_INSERTFILEBROWSE);
    AddConstant('IDD_CHANGEICONBROWSE',IDD_CHANGEICONBROWSE);
    AddConstant('IDD_CONVERTONLY',IDD_CONVERTONLY);
    AddConstant('IDD_CHANGESOURCE4',IDD_CHANGESOURCE4);
    AddConstant('IDD_GNRLPROPS',IDD_GNRLPROPS);
    AddConstant('IDD_VIEWPROPS',IDD_VIEWPROPS);
    AddConstant('IDD_LINKPROPS',IDD_LINKPROPS);
    AddConstant('IDD_CANNOTUPDATELINK',IDD_CANNOTUPDATELINK);
    AddConstant('IDD_LINKSOURCEUNAVAILABLE',IDD_LINKSOURCEUNAVAILABLE);
    AddConstant('IDD_SERVERNOTFOUND',IDD_SERVERNOTFOUND);
    AddConstant('IDD_OUTOFMEMORY',IDD_OUTOFMEMORY);
    AddConstant('IDD_SERVERNOTREG',IDD_SERVERNOTREG);
    AddConstant('IDD_LINKTYPECHANGED',IDD_LINKTYPECHANGED);
    AddConstant('OLESTDDELIM',OLESTDDELIM);
    AddConstant('SZOLEUI_MSG_HELP',SZOLEUI_MSG_HELP);
    AddConstant('SZOLEUI_MSG_ENDDIALOG',SZOLEUI_MSG_ENDDIALOG);
    AddConstant('SZOLEUI_MSG_BROWSE',SZOLEUI_MSG_BROWSE);
    AddConstant('SZOLEUI_MSG_CHANGEICON',SZOLEUI_MSG_CHANGEICON);
    AddConstant('SZOLEUI_MSG_CLOSEBUSYDIALOG',SZOLEUI_MSG_CLOSEBUSYDIALOG);
    AddConstant('SZOLEUI_MSG_CONVERT',SZOLEUI_MSG_CONVERT);
    AddConstant('SZOLEUI_MSG_CHANGESOURCE',SZOLEUI_MSG_CHANGESOURCE);
    AddConstant('SZOLEUI_MSG_ADDCONTROL',SZOLEUI_MSG_ADDCONTROL);
    AddConstant('SZOLEUI_MSG_BROWSE_OFN',SZOLEUI_MSG_BROWSE_OFN);
    AddConstant('ID_BROWSE_CHANGEICON',ID_BROWSE_CHANGEICON);
    AddConstant('ID_BROWSE_INSERTFILE',ID_BROWSE_INSERTFILE);
    AddConstant('ID_BROWSE_ADDCONTROL',ID_BROWSE_ADDCONTROL);
    AddConstant('ID_BROWSE_CHANGESOURCE',ID_BROWSE_CHANGESOURCE);
    AddConstant('OLEUI_FALSE',OLEUI_FALSE);
    AddConstant('OLEUI_SUCCESS',OLEUI_SUCCESS);
    AddConstant('OLEUI_OK',OLEUI_OK);
    AddConstant('OLEUI_CANCEL',OLEUI_CANCEL);
    AddConstant('OLEUI_ERR_STANDARDMIN',OLEUI_ERR_STANDARDMIN);
    AddConstant('OLEUI_ERR_STRUCTURENULL',OLEUI_ERR_STRUCTURENULL);
    AddConstant('OLEUI_ERR_STRUCTUREINVALID',OLEUI_ERR_STRUCTUREINVALID);
    AddConstant('OLEUI_ERR_CBSTRUCTINCORRECT',OLEUI_ERR_CBSTRUCTINCORRECT);
    AddConstant('OLEUI_ERR_HWNDOWNERINVALID',OLEUI_ERR_HWNDOWNERINVALID);
    AddConstant('OLEUI_ERR_LPSZCAPTIONINVALID',OLEUI_ERR_LPSZCAPTIONINVALID);
    AddConstant('OLEUI_ERR_LPFNHOOKINVALID',OLEUI_ERR_LPFNHOOKINVALID);
    AddConstant('OLEUI_ERR_HINSTANCEINVALID',OLEUI_ERR_HINSTANCEINVALID);
    AddConstant('OLEUI_ERR_LPSZTEMPLATEINVALID',OLEUI_ERR_LPSZTEMPLATEINVALID);
    AddConstant('OLEUI_ERR_HRESOURCEINVALID',OLEUI_ERR_HRESOURCEINVALID);
    AddConstant('OLEUI_ERR_FINDTEMPLATEFAILURE',OLEUI_ERR_FINDTEMPLATEFAILURE);
    AddConstant('OLEUI_ERR_LOADTEMPLATEFAILURE',OLEUI_ERR_LOADTEMPLATEFAILURE);
    AddConstant('OLEUI_ERR_DIALOGFAILURE',OLEUI_ERR_DIALOGFAILURE);
    AddConstant('OLEUI_ERR_LOCALMEMALLOC',OLEUI_ERR_LOCALMEMALLOC);
    AddConstant('OLEUI_ERR_GLOBALMEMALLOC',OLEUI_ERR_GLOBALMEMALLOC);
    AddConstant('OLEUI_ERR_LOADSTRING',OLEUI_ERR_LOADSTRING);
    AddConstant('OLEUI_ERR_OLEMEMALLOC',OLEUI_ERR_OLEMEMALLOC);
    AddConstant('OLEUI_ERR_STANDARDMAX',OLEUI_ERR_STANDARDMAX);
    AddConstant('IOF_SHOWHELP',IOF_SHOWHELP);
    AddConstant('IOF_SELECTCREATENEW',IOF_SELECTCREATENEW);
    AddConstant('IOF_SELECTCREATEFROMFILE',IOF_SELECTCREATEFROMFILE);
    AddConstant('IOF_CHECKLINK',IOF_CHECKLINK);
    AddConstant('IOF_CHECKDISPLAYASICON',IOF_CHECKDISPLAYASICON);
    AddConstant('IOF_CREATENEWOBJECT',IOF_CREATENEWOBJECT);
    AddConstant('IOF_CREATEFILEOBJECT',IOF_CREATEFILEOBJECT);
    AddConstant('IOF_CREATELINKOBJECT',IOF_CREATELINKOBJECT);
    AddConstant('IOF_DISABLELINK',IOF_DISABLELINK);
    AddConstant('IOF_VERIFYSERVERSEXIST',IOF_VERIFYSERVERSEXIST);
    AddConstant('IOF_DISABLEDISPLAYASICON',IOF_DISABLEDISPLAYASICON);
    AddConstant('IOF_HIDECHANGEICON',IOF_HIDECHANGEICON);
    AddConstant('IOF_SHOWINSERTCONTROL',IOF_SHOWINSERTCONTROL);
    AddConstant('IOF_SELECTCREATECONTROL',IOF_SELECTCREATECONTROL);
    AddConstant('OLEUI_IOERR_LPSZFILEINVALID',OLEUI_IOERR_LPSZFILEINVALID);
    AddConstant('OLEUI_IOERR_LPSZLABELINVALID',OLEUI_IOERR_LPSZLABELINVALID);
    AddConstant('OLEUI_IOERR_HICONINVALID',OLEUI_IOERR_HICONINVALID);
    AddConstant('OLEUI_IOERR_LPFORMATETCINVALID',OLEUI_IOERR_LPFORMATETCINVALID);
    AddConstant('OLEUI_IOERR_PPVOBJINVALID',OLEUI_IOERR_PPVOBJINVALID);
    AddConstant('OLEUI_IOERR_LPIOLECLIENTSITEINVALID',OLEUI_IOERR_LPIOLECLIENTSITEINVALID);
    AddConstant('OLEUI_IOERR_LPISTORAGEINVALID',OLEUI_IOERR_LPISTORAGEINVALID);
    AddConstant('OLEUI_IOERR_SCODEHASERROR',OLEUI_IOERR_SCODEHASERROR);
    AddConstant('OLEUI_IOERR_LPCLSIDEXCLUDEINVALID',OLEUI_IOERR_LPCLSIDEXCLUDEINVALID);
    AddConstant('OLEUI_IOERR_CCHFILEINVALID',OLEUI_IOERR_CCHFILEINVALID);
    AddConstant('OLEUIPASTE_ENABLEICON',OLEUIPASTE_ENABLEICON);
    AddConstant('OLEUIPASTE_PASTEONLY',OLEUIPASTE_PASTEONLY);
    AddConstant('OLEUIPASTE_PASTE',OLEUIPASTE_PASTE);
    AddConstant('OLEUIPASTE_LINKANYTYPE',OLEUIPASTE_LINKANYTYPE);
    AddConstant('OLEUIPASTE_LINKTYPE1',OLEUIPASTE_LINKTYPE1);
    AddConstant('OLEUIPASTE_LINKTYPE2',OLEUIPASTE_LINKTYPE2);
    AddConstant('OLEUIPASTE_LINKTYPE3',OLEUIPASTE_LINKTYPE3);
    AddConstant('OLEUIPASTE_LINKTYPE4',OLEUIPASTE_LINKTYPE4);
    AddConstant('OLEUIPASTE_LINKTYPE5',OLEUIPASTE_LINKTYPE5);
    AddConstant('OLEUIPASTE_LINKTYPE6',OLEUIPASTE_LINKTYPE6);
    AddConstant('OLEUIPASTE_LINKTYPE7',OLEUIPASTE_LINKTYPE7);
    AddConstant('OLEUIPASTE_LINKTYPE8',OLEUIPASTE_LINKTYPE8);
    AddConstant('PS_MAXLINKTYPES',PS_MAXLINKTYPES);
    AddConstant('PSF_SHOWHELP',PSF_SHOWHELP);
    AddConstant('PSF_SELECTPASTE',PSF_SELECTPASTE);
    AddConstant('PSF_SELECTPASTELINK',PSF_SELECTPASTELINK);
    AddConstant('PSF_CHECKDISPLAYASICON',PSF_CHECKDISPLAYASICON);
    AddConstant('PSF_DISABLEDISPLAYASICON',PSF_DISABLEDISPLAYASICON);
    AddConstant('PSF_HIDECHANGEICON',PSF_HIDECHANGEICON);
    AddConstant('PSF_STAYONCLIPBOARDCHANGE',PSF_STAYONCLIPBOARDCHANGE);
    AddConstant('PSF_NOREFRESHDATAOBJECT',PSF_NOREFRESHDATAOBJECT);
    AddConstant('OLEUI_IOERR_SRCDATAOBJECTINVALID',OLEUI_IOERR_SRCDATAOBJECTINVALID);
    AddConstant('OLEUI_IOERR_ARRPASTEENTRIESINVALID',OLEUI_IOERR_ARRPASTEENTRIESINVALID);
    AddConstant('OLEUI_IOERR_ARRLINKTYPESINVALID',OLEUI_IOERR_ARRLINKTYPESINVALID);
    AddConstant('OLEUI_PSERR_CLIPBOARDCHANGED',OLEUI_PSERR_CLIPBOARDCHANGED);
    AddConstant('OLEUI_PSERR_GETCLIPBOARDFAILED',OLEUI_PSERR_GETCLIPBOARDFAILED);
    AddConstant('OLEUI_ELERR_LINKCNTRNULL',OLEUI_ELERR_LINKCNTRNULL);
    AddConstant('OLEUI_ELERR_LINKCNTRINVALID',OLEUI_ELERR_LINKCNTRINVALID);
    AddConstant('ELF_SHOWHELP',ELF_SHOWHELP);
    AddConstant('ELF_DISABLEUPDATENOW',ELF_DISABLEUPDATENOW);
    AddConstant('ELF_DISABLEOPENSOURCE',ELF_DISABLEOPENSOURCE);
    AddConstant('ELF_DISABLECHANGESOURCE',ELF_DISABLECHANGESOURCE);
    AddConstant('ELF_DISABLECANCELLINK',ELF_DISABLECANCELLINK);
    AddConstant('CIF_SHOWHELP',CIF_SHOWHELP);
    AddConstant('CIF_SELECTCURRENT',CIF_SELECTCURRENT);
    AddConstant('CIF_SELECTDEFAULT',CIF_SELECTDEFAULT);
    AddConstant('CIF_SELECTFROMFILE',CIF_SELECTFROMFILE);
    AddConstant('CIF_USEICONEXE',CIF_USEICONEXE);
    AddConstant('OLEUI_CIERR_MUSTHAVECLSID',OLEUI_CIERR_MUSTHAVECLSID);
    AddConstant('OLEUI_CIERR_MUSTHAVECURRENTMETAFILE',OLEUI_CIERR_MUSTHAVECURRENTMETAFILE);
    AddConstant('OLEUI_CIERR_SZICONEXEINVALID',OLEUI_CIERR_SZICONEXEINVALID);
    AddConstant('PROP_HWND_CHGICONDLG',PROP_HWND_CHGICONDLG);
    AddConstant('CF_SHOWHELPBUTTON',CF_SHOWHELPBUTTON);
    AddConstant('CF_SETCONVERTDEFAULT',CF_SETCONVERTDEFAULT);
    AddConstant('CF_SETACTIVATEDEFAULT',CF_SETACTIVATEDEFAULT);
    AddConstant('CF_SELECTCONVERTTO',CF_SELECTCONVERTTO);
    AddConstant('CF_SELECTACTIVATEAS',CF_SELECTACTIVATEAS);
    AddConstant('CF_DISABLEDISPLAYASICON',CF_DISABLEDISPLAYASICON);
    AddConstant('CF_DISABLEACTIVATEAS',CF_DISABLEACTIVATEAS);
    AddConstant('CF_HIDECHANGEICON',CF_HIDECHANGEICON);
    AddConstant('CF_CONVERTONLY',CF_CONVERTONLY);
    AddConstant('OLEUI_CTERR_CLASSIDINVALID',OLEUI_CTERR_CLASSIDINVALID);
    AddConstant('OLEUI_CTERR_DVASPECTINVALID',OLEUI_CTERR_DVASPECTINVALID);
    AddConstant('OLEUI_CTERR_CBFORMATINVALID',OLEUI_CTERR_CBFORMATINVALID);
    AddConstant('OLEUI_CTERR_HMETAPICTINVALID',OLEUI_CTERR_HMETAPICTINVALID);
    AddConstant('OLEUI_CTERR_STRINGINVALID',OLEUI_CTERR_STRINGINVALID);
    AddConstant('BZ_DISABLECANCELBUTTON',BZ_DISABLECANCELBUTTON);
    AddConstant('BZ_DISABLESWITCHTOBUTTON',BZ_DISABLESWITCHTOBUTTON);
    AddConstant('BZ_DISABLERETRYBUTTON',BZ_DISABLERETRYBUTTON);
    AddConstant('BZ_NOTRESPONDINGDIALOG',BZ_NOTRESPONDINGDIALOG);
    AddConstant('OLEUI_BZERR_HTASKINVALID',OLEUI_BZERR_HTASKINVALID);
    AddConstant('OLEUI_BZ_SWITCHTOSELECTED',OLEUI_BZ_SWITCHTOSELECTED);
    AddConstant('OLEUI_BZ_RETRYSELECTED',OLEUI_BZ_RETRYSELECTED);
    AddConstant('OLEUI_BZ_CALLUNBLOCKED',OLEUI_BZ_CALLUNBLOCKED);
    AddConstant('VPF_SELECTRELATIVE',VPF_SELECTRELATIVE);
    AddConstant('VPF_DISABLERELATIVE',VPF_DISABLERELATIVE);
    AddConstant('VPF_DISABLESCALE',VPF_DISABLESCALE);
    AddConstant('OPF_OBJECTISLINK',OPF_OBJECTISLINK);
    AddConstant('OPF_NOFILLDEFAULT',OPF_NOFILLDEFAULT);
    AddConstant('OPF_SHOWHELP',OPF_SHOWHELP);
    AddConstant('OPF_DISABLECONVERT',OPF_DISABLECONVERT);
    AddConstant('OLEUI_OPERR_SUBPROPNULL',OLEUI_OPERR_SUBPROPNULL);
    AddConstant('OLEUI_OPERR_SUBPROPINVALID',OLEUI_OPERR_SUBPROPINVALID);
    AddConstant('OLEUI_OPERR_PROPSHEETNULL',OLEUI_OPERR_PROPSHEETNULL);
    AddConstant('OLEUI_OPERR_PROPSHEETINVALID',OLEUI_OPERR_PROPSHEETINVALID);
    AddConstant('OLEUI_OPERR_SUPPROP',OLEUI_OPERR_SUPPROP);
    AddConstant('OLEUI_OPERR_PROPSINVALID',OLEUI_OPERR_PROPSINVALID);
    AddConstant('OLEUI_OPERR_PAGESINCORRECT',OLEUI_OPERR_PAGESINCORRECT);
    AddConstant('OLEUI_OPERR_INVALIDPAGES',OLEUI_OPERR_INVALIDPAGES);
    AddConstant('OLEUI_OPERR_NOTSUPPORTED',OLEUI_OPERR_NOTSUPPORTED);
    AddConstant('OLEUI_OPERR_DLGPROCNOTNULL',OLEUI_OPERR_DLGPROCNOTNULL);
    AddConstant('OLEUI_OPERR_LPARAMNOTZERO',OLEUI_OPERR_LPARAMNOTZERO);
    AddConstant('OLEUI_GPERR_STRINGINVALID',OLEUI_GPERR_STRINGINVALID);
    AddConstant('OLEUI_GPERR_CLASSIDINVALID',OLEUI_GPERR_CLASSIDINVALID);
    AddConstant('OLEUI_GPERR_LPCLSIDEXCLUDEINVALID',OLEUI_GPERR_LPCLSIDEXCLUDEINVALID);
    AddConstant('OLEUI_GPERR_CBFORMATINVALID',OLEUI_GPERR_CBFORMATINVALID);
    AddConstant('OLEUI_VPERR_METAPICTINVALID',OLEUI_VPERR_METAPICTINVALID);
    AddConstant('OLEUI_VPERR_DVASPECTINVALID',OLEUI_VPERR_DVASPECTINVALID);
    AddConstant('OLEUI_LPERR_LINKCNTRNULL',OLEUI_LPERR_LINKCNTRNULL);
    AddConstant('OLEUI_LPERR_LINKCNTRINVALID',OLEUI_LPERR_LINKCNTRINVALID);
    AddConstant('OLEUI_OPERR_PROPERTYSHEET',OLEUI_OPERR_PROPERTYSHEET);
    AddConstant('OLEUI_QUERY_GETCLASSID',OLEUI_QUERY_GETCLASSID);
    AddConstant('OLEUI_QUERY_LINKBROKEN',OLEUI_QUERY_LINKBROKEN);
  end;
end;

class function TatOleDlgLibrary.LibraryName: string;
begin
  result := 'OleDlg';
end;

initialization
  RegisterScripterLibrary(TatOleDlgLibrary, True);

{$WARNINGS ON}

end.

