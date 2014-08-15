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
unit ap_PenWin;

interface

uses
  Windows,
  Messages,
  MMSystem,
  PenWin,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatPenWinLibrary = class(TatScripterLibrary)
    procedure __FPenUpX(AMachine: TatVirtualMachine);
    procedure __GetWEventRef(AMachine: TatVirtualMachine);
    procedure __MpIbf(AMachine: TatVirtualMachine);
    procedure __dwDiffAT(AMachine: TatVirtualMachine);
    procedure __FLTAbsTime(AMachine: TatVirtualMachine);
    procedure __FLTEAbsTime(AMachine: TatVirtualMachine);
    procedure __FEQAbsTime(AMachine: TatVirtualMachine);
    procedure __MakeAbsTime(AMachine: TatVirtualMachine);
    procedure __FIsSpecial(AMachine: TatVirtualMachine);
    procedure __FIsAnsi(AMachine: TatVirtualMachine);
    procedure __FIsGesture(AMachine: TatVirtualMachine);
    procedure __FIsKanji(AMachine: TatVirtualMachine);
    procedure __FIsShape(AMachine: TatVirtualMachine);
    procedure __FIsUniCode(AMachine: TatVirtualMachine);
    procedure __FIsVKey(AMachine: TatVirtualMachine);
    procedure __ChSyvToAnsi(AMachine: TatVirtualMachine);
    procedure __WSyvToKanji(AMachine: TatVirtualMachine);
    procedure __SyvCharacterToSymbol(AMachine: TatVirtualMachine);
    procedure __SyvKanjiToSymbol(AMachine: TatVirtualMachine);
    procedure __FIsSelectGesture(AMachine: TatVirtualMachine);
    procedure __FIsStdGesture(AMachine: TatVirtualMachine);
    procedure __FIsAnsiGesture(AMachine: TatVirtualMachine);
    procedure __SubPenMsgFromWpLp(AMachine: TatVirtualMachine);
    procedure __EventRefFromWpLp(AMachine: TatVirtualMachine);
    procedure __TerminationFromWpLp(AMachine: TatVirtualMachine);
    procedure __HwndFromHtrg(AMachine: TatVirtualMachine);
    procedure __HpcmFromWpLp(AMachine: TatVirtualMachine);
    procedure __HtrgFromHwnd(AMachine: TatVirtualMachine);
    procedure __CompressPenData(AMachine: TatVirtualMachine);
    procedure __CreatePenDataRegion(AMachine: TatVirtualMachine);
    procedure __DestroyPenData(AMachine: TatVirtualMachine);
    procedure __DuplicatePenData(AMachine: TatVirtualMachine);
    procedure __InsertPenData(AMachine: TatVirtualMachine);
    procedure __MetricScalePenData(AMachine: TatVirtualMachine);
    procedure __OffsetPenData(AMachine: TatVirtualMachine);
    procedure __RemovePenDataStrokes(AMachine: TatVirtualMachine);
    procedure __SetStrokeAttributes(AMachine: TatVirtualMachine);
    procedure __SetStrokeTableAttributes(AMachine: TatVirtualMachine);
    procedure __TrimPenData(AMachine: TatVirtualMachine);
    procedure __GetPenAsyncState(AMachine: TatVirtualMachine);
    procedure __IsPenEvent(AMachine: TatVirtualMachine);
    procedure __AddPenDataHRC(AMachine: TatVirtualMachine);
    procedure __AddWordsHWL(AMachine: TatVirtualMachine);
    procedure __ConfigHREC(AMachine: TatVirtualMachine);
    procedure __CreateCompatibleHRC(AMachine: TatVirtualMachine);
    procedure __CreateHWL(AMachine: TatVirtualMachine);
    procedure __CreateInksetHRCRESULT(AMachine: TatVirtualMachine);
    procedure __CreatePenDataHRC(AMachine: TatVirtualMachine);
    procedure __DestroyHRC(AMachine: TatVirtualMachine);
    procedure __DestroyHRCRESULT(AMachine: TatVirtualMachine);
    procedure __DestroyHWL(AMachine: TatVirtualMachine);
    procedure __EnableGestureSetHRC(AMachine: TatVirtualMachine);
    procedure __EnableSystemDictionaryHRC(AMachine: TatVirtualMachine);
    procedure __EndPenInputHRC(AMachine: TatVirtualMachine);
    procedure __GetHRECFromHRC(AMachine: TatVirtualMachine);
    procedure __GetMaxResultsHRC(AMachine: TatVirtualMachine);
    procedure __GetSymbolCountHRCRESULT(AMachine: TatVirtualMachine);
    procedure __GetWordlistCoercionHRC(AMachine: TatVirtualMachine);
    procedure __ProcessHRC(AMachine: TatVirtualMachine);
    procedure __ReadHWL(AMachine: TatVirtualMachine);
    procedure __SetInternationalHRC(AMachine: TatVirtualMachine);
    procedure __SetMaxResultsHRC(AMachine: TatVirtualMachine);
    procedure __SetWordlistCoercionHRC(AMachine: TatVirtualMachine);
    procedure __SetWordlistHRC(AMachine: TatVirtualMachine);
    procedure __UnhookResultsHookHREC(AMachine: TatVirtualMachine);
    procedure __WriteHWL(AMachine: TatVirtualMachine);
    procedure __InstallRecognizer(AMachine: TatVirtualMachine);
    procedure __CreateInkset(AMachine: TatVirtualMachine);
    procedure __DestroyInkset(AMachine: TatVirtualMachine);
    procedure __GetInksetIntervalCount(AMachine: TatVirtualMachine);
    procedure __DoDefaultPenInput(AMachine: TatVirtualMachine);
    procedure __StopInking(AMachine: TatVirtualMachine);
    procedure __StopPenInput(AMachine: TatVirtualMachine);
    procedure __GetPenAppFlags(AMachine: TatVirtualMachine);
    procedure __GetPenMiscInfo(AMachine: TatVirtualMachine);
    procedure __GetVersionPenWin(AMachine: TatVirtualMachine);
    procedure __SetPenMiscInfo(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagABSTIMEWrapper = class(TatRecordWrapper)
  private
    Fsec: DWORD;
    Fms: UINT;
  public
    constructor Create(ARecord: tagABSTIME);
    function ObjToRec: tagABSTIME;
  published
    property sec: DWORD read Fsec write Fsec;
    property ms: UINT read Fms write Fms;
  end;
  
  tagCTLINITHEDITWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fhwnd: HWND;
    Fid: Integer;
    FdwFlags: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagCTLINITHEDIT);
    function ObjToRec: tagCTLINITHEDIT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property id: Integer read Fid write Fid;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagBOXLAYOUTWrapper = class(TatRecordWrapper)
  private
    FcyCusp: Integer;
    FcyEndCusp: Integer;
    Fstyle: UINT;
    FdwReserved1: DWORD;
    FdwReserved2: DWORD;
    FdwReserved3: DWORD;
  public
    constructor Create(ARecord: tagBOXLAYOUT);
    function ObjToRec: tagBOXLAYOUT;
  published
    property cyCusp: Integer read FcyCusp write FcyCusp;
    property cyEndCusp: Integer read FcyEndCusp write FcyEndCusp;
    property style: UINT read Fstyle write Fstyle;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
    property dwReserved2: DWORD read FdwReserved2 write FdwReserved2;
    property dwReserved3: DWORD read FdwReserved3 write FdwReserved3;
  end;
  
  tagIMECOLORSWrapper = class(TatRecordWrapper)
  private
    FcColors: Integer;
  public
    constructor Create(ARecord: tagIMECOLORS);
    function ObjToRec: tagIMECOLORS;
  published
    property cColors: Integer read FcColors write FcColors;
  end;
  
  tagCTLINITBEDITWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fhwnd: HWND;
    Fid: Integer;
    FwSizeCategory: WORD;
    FwFlags: WORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagCTLINITBEDIT);
    function ObjToRec: tagCTLINITBEDIT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property id: Integer read Fid write Fid;
    property wSizeCategory: WORD read FwSizeCategory write FwSizeCategory;
    property wFlags: WORD read FwFlags write FwFlags;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagBOXEDITINFOWrapper = class(TatRecordWrapper)
  private
    FcxBox: Integer;
    FcyBox: Integer;
    FcxBase: Integer;
    FcyBase: Integer;
    FcyMid: Integer;
    FwFlags: UINT;
    FwFontHeight: UINT;
  public
    constructor Create(ARecord: tagBOXEDITINFO);
    function ObjToRec: tagBOXEDITINFO;
  published
    property cxBox: Integer read FcxBox write FcxBox;
    property cyBox: Integer read FcyBox write FcyBox;
    property cxBase: Integer read FcxBase write FcxBase;
    property cyBase: Integer read FcyBase write FcyBase;
    property cyMid: Integer read FcyMid write FcyMid;
    property wFlags: UINT read FwFlags write FwFlags;
    property wFontHeight: UINT read FwFontHeight write FwFontHeight;
  end;
  
  tagRECTOFSWrapper = class(TatRecordWrapper)
  private
    FdLeft: Integer;
    FdTop: Integer;
    FdRight: Integer;
    FdBottom: Integer;
  public
    constructor Create(ARecord: tagRECTOFS);
    function ObjToRec: tagRECTOFS;
  published
    property dLeft: Integer read FdLeft write FdLeft;
    property dTop: Integer read FdTop write FdTop;
    property dRight: Integer read FdRight write FdRight;
    property dBottom: Integer read FdBottom write FdBottom;
  end;
  
  tagPENDATAHEADERWrapper = class(TatRecordWrapper)
  private
    FwVersion: UINT;
    FcbSizeUsed: UINT;
    FcStrokes: UINT;
    FcPnt: UINT;
    FcPntStrokeMax: UINT;
    FwPndts: UINT;
    FnInkWidth: Integer;
    FrgbInk: DWORD;
  public
    constructor Create(ARecord: tagPENDATAHEADER);
    function ObjToRec: tagPENDATAHEADER;
  published
    property wVersion: UINT read FwVersion write FwVersion;
    property cbSizeUsed: UINT read FcbSizeUsed write FcbSizeUsed;
    property cStrokes: UINT read FcStrokes write FcStrokes;
    property cPnt: UINT read FcPnt write FcPnt;
    property cPntStrokeMax: UINT read FcPntStrokeMax write FcPntStrokeMax;
    property wPndts: UINT read FwPndts write FwPndts;
    property nInkWidth: Integer read FnInkWidth write FnInkWidth;
    property rgbInk: DWORD read FrgbInk write FrgbInk;
  end;
  
  tagSTROKEINFOWrapper = class(TatRecordWrapper)
  private
    FcPnt: UINT;
    FcbPnts: UINT;
    FwPdk: UINT;
    FdwTick: DWORD;
  public
    constructor Create(ARecord: tagSTROKEINFO);
    function ObjToRec: tagSTROKEINFO;
  published
    property cPnt: UINT read FcPnt write FcPnt;
    property cbPnts: UINT read FcbPnts write FcbPnts;
    property wPdk: UINT read FwPdk write FwPdk;
    property dwTick: DWORD read FdwTick write FdwTick;
  end;
  
  tagPENTIPWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fbtype: BYTE;
    Fbwidth: BYTE;
    Fbheight: BYTE;
    FbOpacity: BYTE;
    Frgb: COLORREF;
    FdwFlags: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagPENTIP);
    function ObjToRec: tagPENTIP;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property btype: BYTE read Fbtype write Fbtype;
    property bwidth: BYTE read Fbwidth write Fbwidth;
    property bheight: BYTE read Fbheight write Fbheight;
    property bOpacity: BYTE read FbOpacity write FbOpacity;
    property rgb: COLORREF read Frgb write Frgb;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagANIMATEINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FuSpeedPct: UINT;
    FuPeriodCB: UINT;
    FfuFlags: UINT;
    FlParam: LPARAM;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagANIMATEINFO);
    function ObjToRec: tagANIMATEINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property uSpeedPct: UINT read FuSpeedPct write FuSpeedPct;
    property uPeriodCB: UINT read FuPeriodCB write FuPeriodCB;
    property fuFlags: UINT read FfuFlags write FfuFlags;
    property lParam: LPARAM read FlParam write FlParam;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagOEMPENINFOWrapper = class(TatRecordWrapper)
  private
    FwPdt: UINT;
    FwValueMax: UINT;
    FwDistinct: UINT;
  public
    constructor Create(ARecord: tagOEMPENINFO);
    function ObjToRec: tagOEMPENINFO;
  published
    property wPdt: UINT read FwPdt write FwPdt;
    property wValueMax: UINT read FwValueMax write FwValueMax;
    property wDistinct: UINT read FwDistinct write FwDistinct;
  end;
  
  tagPENPACKETWrapper = class(TatRecordWrapper)
  private
    FwTabletX: UINT;
    FwTabletY: UINT;
    FwPDK: UINT;
  public
    constructor Create(ARecord: tagPENPACKET);
    function ObjToRec: tagPENPACKET;
  published
    property wTabletX: UINT read FwTabletX write FwTabletX;
    property wTabletY: UINT read FwTabletY write FwTabletY;
    property wPDK: UINT read FwPDK write FwPDK;
  end;
  
  tagOEMPENPACKETWrapper = class(TatRecordWrapper)
  private
    FwTabletX: UINT;
    FwTabletY: UINT;
    FwPDK: UINT;
    FdwTime: DWORD;
  public
    constructor Create(ARecord: tagOEMPENPACKET);
    function ObjToRec: tagOEMPENPACKET;
  published
    property wTabletX: UINT read FwTabletX write FwTabletX;
    property wTabletY: UINT read FwTabletY write FwTabletY;
    property wPDK: UINT read FwPDK write FwPDK;
    property dwTime: DWORD read FdwTime write FdwTime;
  end;
  
  tagPENINFOWrapper = class(TatRecordWrapper)
  private
    FcxRawWidth: UINT;
    FcyRawHeight: UINT;
    FwDistinctWidth: UINT;
    FwDistinctHeight: UINT;
    FnSamplingRate: Integer;
    FnSamplingDist: Integer;
    FlPdc: Longint;
    FcPens: Integer;
    FcbOemData: Integer;
    FfuOEM: UINT;
  public
    constructor Create(ARecord: tagPENINFO);
    function ObjToRec: tagPENINFO;
  published
    property cxRawWidth: UINT read FcxRawWidth write FcxRawWidth;
    property cyRawHeight: UINT read FcyRawHeight write FcyRawHeight;
    property wDistinctWidth: UINT read FwDistinctWidth write FwDistinctWidth;
    property wDistinctHeight: UINT read FwDistinctHeight write FwDistinctHeight;
    property nSamplingRate: Integer read FnSamplingRate write FnSamplingRate;
    property nSamplingDist: Integer read FnSamplingDist write FnSamplingDist;
    property lPdc: Longint read FlPdc write FlPdc;
    property cPens: Integer read FcPens write FcPens;
    property cbOemData: Integer read FcbOemData write FcbOemData;
    property fuOEM: UINT read FfuOEM write FfuOEM;
  end;
  
  tagCALBSTRUCTWrapper = class(TatRecordWrapper)
  private
    FwOffsetX: Integer;
    FwOffsetY: Integer;
    FwDistinctWidth: Integer;
    FwDistinctHeight: Integer;
  public
    constructor Create(ARecord: tagCALBSTRUCT);
    function ObjToRec: tagCALBSTRUCT;
  published
    property wOffsetX: Integer read FwOffsetX write FwOffsetX;
    property wOffsetY: Integer read FwOffsetY write FwOffsetY;
    property wDistinctWidth: Integer read FwDistinctWidth write FwDistinctWidth;
    property wDistinctHeight: Integer read FwDistinctHeight write FwDistinctHeight;
  end;
  
  tagINTERVALWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagINTERVAL);
    function ObjToRec: tagINTERVAL;
  published
  end;
  
  tagBOXRESULTSWrapper = class(TatRecordWrapper)
  private
    FindxBox: UINT;
    FhinksetBox: HINKSET;
  public
    constructor Create(ARecord: tagBOXRESULTS);
    function ObjToRec: tagBOXRESULTS;
  published
    property indxBox: UINT read FindxBox write FindxBox;
    property hinksetBox: HINKSET read FhinksetBox write FhinksetBox;
  end;
  
  tagGUIDEWrapper = class(TatRecordWrapper)
  private
    FxOrigin: Integer;
    FyOrigin: Integer;
    FcxBox: Integer;
    FcyBox: Integer;
    FcxBase: Integer;
    FcyBase: Integer;
    FcHorzBox: Integer;
    FcVertBox: Integer;
    FcyMid: Integer;
  public
    constructor Create(ARecord: tagGUIDE);
    function ObjToRec: tagGUIDE;
  published
    property xOrigin: Integer read FxOrigin write FxOrigin;
    property yOrigin: Integer read FyOrigin write FyOrigin;
    property cxBox: Integer read FcxBox write FcxBox;
    property cyBox: Integer read FcyBox write FcyBox;
    property cxBase: Integer read FcxBase write FcxBase;
    property cyBase: Integer read FcyBase write FcyBase;
    property cHorzBox: Integer read FcHorzBox write FcHorzBox;
    property cVertBox: Integer read FcVertBox write FcVertBox;
    property cyMid: Integer read FcyMid write FcyMid;
  end;
  
  tagCTLINITIEDITWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fhwnd: HWND;
    Fid: Integer;
    Fieb: WORD;
    Fiedo: WORD;
    Fiei: WORD;
    Fien: WORD;
    Fierec: WORD;
    Fies: WORD;
    Fiesec: WORD;
    Fpdts: WORD;
    Fhpndt: HPENDATA;
    Fhgdiobj: HGDIOBJ;
    FhpenGrid: HPEN;
    FwVGrid: WORD;
    FwHGrid: WORD;
    FdwApp: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagCTLINITIEDIT);
    function ObjToRec: tagCTLINITIEDIT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property id: Integer read Fid write Fid;
    property ieb: WORD read Fieb write Fieb;
    property iedo: WORD read Fiedo write Fiedo;
    property iei: WORD read Fiei write Fiei;
    property ien: WORD read Fien write Fien;
    property ierec: WORD read Fierec write Fierec;
    property ies: WORD read Fies write Fies;
    property iesec: WORD read Fiesec write Fiesec;
    property pdts: WORD read Fpdts write Fpdts;
    property hpndt: HPENDATA read Fhpndt write Fhpndt;
    property hgdiobj: HGDIOBJ read Fhgdiobj write Fhgdiobj;
    property hpenGrid: HPEN read FhpenGrid write FhpenGrid;
    property wVGrid: WORD read FwVGrid write FwVGrid;
    property wHGrid: WORD read FwHGrid write FwHGrid;
    property dwApp: DWORD read FdwApp write FdwApp;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagPDEVENTWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fhwnd: HWND;
    Fwm: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
    FfPen: BOOL;
    FlExInfo: Longint;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagPDEVENT);
    function ObjToRec: tagPDEVENT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property wm: UINT read Fwm write Fwm;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
    property fPen: BOOL read FfPen write FfPen;
    property lExInfo: Longint read FlExInfo write FlExInfo;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagSTRKFMTWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fiesf: UINT;
    FiStrk: UINT;
    FdwUser: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: tagSTRKFMT);
    function ObjToRec: tagSTRKFMT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property iesf: UINT read Fiesf write Fiesf;
    property iStrk: UINT read FiStrk write FiStrk;
    property dwUser: DWORD read FdwUser write FdwUser;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  tagPCMINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwPcm: DWORD;
    FhrgnBound: HRGN;
    FhrgnExclude: HRGN;
    FdwTimeout: DWORD;
  public
    constructor Create(ARecord: tagPCMINFO);
    function ObjToRec: tagPCMINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwPcm: DWORD read FdwPcm write FdwPcm;
    property hrgnBound: HRGN read FhrgnBound write FhrgnBound;
    property hrgnExclude: HRGN read FhrgnExclude write FhrgnExclude;
    property dwTimeout: DWORD read FdwTimeout write FdwTimeout;
  end;
  
  tagINKINGINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FwFlags: UINT;
    FhrgnClip: HRGN;
    FhrgnInkStop: HRGN;
  public
    constructor Create(ARecord: tagINKINGINFO);
    function ObjToRec: tagINKINGINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property wFlags: UINT read FwFlags write FwFlags;
    property hrgnClip: HRGN read FhrgnClip write FhrgnClip;
    property hrgnInkStop: HRGN read FhrgnInkStop write FhrgnInkStop;
  end;
  
  tagSYCWrapper = class(TatRecordWrapper)
  private
    FwStrokeFirst: UINT;
    FwPntFirst: UINT;
    FwStrokeLast: UINT;
    FwPntLast: UINT;
    FfLastSyc: BOOL;
  public
    constructor Create(ARecord: tagSYC);
    function ObjToRec: tagSYC;
  published
    property wStrokeFirst: UINT read FwStrokeFirst write FwStrokeFirst;
    property wPntFirst: UINT read FwPntFirst write FwPntFirst;
    property wStrokeLast: UINT read FwStrokeLast write FwStrokeLast;
    property wPntLast: UINT read FwPntLast write FwPntLast;
    property fLastSyc: BOOL read FfLastSyc write FfLastSyc;
  end;
  
  tagSYEWrapper = class(TatRecordWrapper)
  private
    Fsyv: SYV;
    FlRecogVal: Longint;
    Fcl: CL;
    FiSyc: Integer;
  public
    constructor Create(ARecord: tagSYE);
    function ObjToRec: tagSYE;
  published
    property syv: SYV read Fsyv write Fsyv;
    property lRecogVal: Longint read FlRecogVal write FlRecogVal;
    property cl: CL read Fcl write Fcl;
    property iSyc: Integer read FiSyc write FiSyc;
  end;
  
  tagSYGWrapper = class(TatRecordWrapper)
  private
    FcHotSpot: Integer;
    FnFirstBox: Integer;
    FlRecogVal: Longint;
    FcSye: Integer;
    FcSyc: Integer;
  public
    constructor Create(ARecord: tagSYG);
    function ObjToRec: tagSYG;
  published
    property cHotSpot: Integer read FcHotSpot write FcHotSpot;
    property nFirstBox: Integer read FnFirstBox write FnFirstBox;
    property lRecogVal: Longint read FlRecogVal write FlRecogVal;
    property cSye: Integer read FcSye write FcSye;
    property cSyc: Integer read FcSyc write FcSyc;
  end;
  
  tagRCWrapper = class(TatRecordWrapper)
  private
    Fhrec: HREC;
    Fhwnd: HWND;
    FwEventRef: UINT;
    FwRcPreferences: UINT;
    FlRcOptions: Longint;
    FwCountry: UINT;
    FwIntlPreferences: UINT;
    FwTryDictionary: UINT;
    FclErrorLevel: CL;
    Falc: ALC;
    FalcPriority: ALC;
    FwResultMode: UINT;
    FwTimeOut: UINT;
    FlPcm: Longint;
    FwRcOrient: UINT;
    FwRcDirect: UINT;
    FnInkWidth: Integer;
    FrgbInk: COLORREF;
    FdwAppParam: DWORD;
    FdwDictParam: DWORD;
    FdwRecognizer: DWORD;
  public
    constructor Create(ARecord: tagRC);
    function ObjToRec: tagRC;
  published
    property hrec: HREC read Fhrec write Fhrec;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property wEventRef: UINT read FwEventRef write FwEventRef;
    property wRcPreferences: UINT read FwRcPreferences write FwRcPreferences;
    property lRcOptions: Longint read FlRcOptions write FlRcOptions;
    property wCountry: UINT read FwCountry write FwCountry;
    property wIntlPreferences: UINT read FwIntlPreferences write FwIntlPreferences;
    property wTryDictionary: UINT read FwTryDictionary write FwTryDictionary;
    property clErrorLevel: CL read FclErrorLevel write FclErrorLevel;
    property alc: ALC read Falc write Falc;
    property alcPriority: ALC read FalcPriority write FalcPriority;
    property wResultMode: UINT read FwResultMode write FwResultMode;
    property wTimeOut: UINT read FwTimeOut write FwTimeOut;
    property lPcm: Longint read FlPcm write FlPcm;
    property wRcOrient: UINT read FwRcOrient write FwRcOrient;
    property wRcDirect: UINT read FwRcDirect write FwRcDirect;
    property nInkWidth: Integer read FnInkWidth write FnInkWidth;
    property rgbInk: COLORREF read FrgbInk write FrgbInk;
    property dwAppParam: DWORD read FdwAppParam write FdwAppParam;
    property dwDictParam: DWORD read FdwDictParam write FdwDictParam;
    property dwRecognizer: DWORD read FdwRecognizer write FdwRecognizer;
  end;
  
  tagRCRESULTWrapper = class(TatRecordWrapper)
  private
    FwResultsType: UINT;
    FcSyv: Integer;
    FhSyv: THandle;
    FnBaseLine: Integer;
    FnMidLine: Integer;
    Fhpendata: HPENDATA;
  public
    constructor Create(ARecord: tagRCRESULT);
    function ObjToRec: tagRCRESULT;
  published
    property wResultsType: UINT read FwResultsType write FwResultsType;
    property cSyv: Integer read FcSyv write FcSyv;
    property hSyv: THandle read FhSyv write FhSyv;
    property nBaseLine: Integer read FnBaseLine write FnBaseLine;
    property nMidLine: Integer read FnMidLine write FnMidLine;
    property hpendata: HPENDATA read Fhpendata write Fhpendata;
  end;
  
  tagTARGETWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FidTarget: DWORD;
    FhtrgTarget: HTRG;
    FdwData: DWORD;
  public
    constructor Create(ARecord: tagTARGET);
    function ObjToRec: tagTARGET;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property idTarget: DWORD read FidTarget write FidTarget;
    property htrgTarget: HTRG read FhtrgTarget write FhtrgTarget;
    property dwData: DWORD read FdwData write FdwData;
  end;
  
  tagTARGINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
    FhtrgOwner: HTRG;
    FcTargets: WORD;
    FiTargetLast: WORD;
  public
    constructor Create(ARecord: tagTARGINFO);
    function ObjToRec: tagTARGINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property htrgOwner: HTRG read FhtrgOwner write FhtrgOwner;
    property cTargets: WORD read FcTargets write FcTargets;
    property iTargetLast: WORD read FiTargetLast write FiTargetLast;
  end;
  
  tagINPPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
    Fhpndt: HPENDATA;
  public
    constructor Create(ARecord: tagINPPARAMS);
    function ObjToRec: tagINPPARAMS;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property hpndt: HPENDATA read Fhpndt write Fhpndt;
  end;
  
  tagSKBINFOWrapper = class(TatRecordWrapper)
  private
    Fhandle: HWnd;
    FnPad: Word;
    FfVisible: Bool;
    FfMinimized: Bool;
    FdwReserved: Longint;
  public
    constructor Create(ARecord: tagSKBINFO);
    function ObjToRec: tagSKBINFO;
  published
    property handle: HWnd read Fhandle write Fhandle;
    property nPad: Word read FnPad write FnPad;
    property fVisible: Bool read FfVisible write FfVisible;
    property fMinimized: Bool read FfMinimized write FfMinimized;
    property dwReserved: Longint read FdwReserved write FdwReserved;
  end;
  

implementation

constructor tagABSTIMEWrapper.Create(ARecord: tagABSTIME);
begin
  inherited Create;
  Fsec := ARecord.sec;
  Fms := ARecord.ms;
end;

function tagABSTIMEWrapper.ObjToRec: tagABSTIME;
begin
  result.sec := Fsec;
  result.ms := Fms;
end;

constructor tagCTLINITHEDITWrapper.Create(ARecord: tagCTLINITHEDIT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fhwnd := ARecord.hwnd;
  Fid := ARecord.id;
  FdwFlags := ARecord.dwFlags;
  FdwReserved := ARecord.dwReserved;
end;

function tagCTLINITHEDITWrapper.ObjToRec: tagCTLINITHEDIT;
begin
  result.cbSize := FcbSize;
  result.hwnd := Fhwnd;
  result.id := Fid;
  result.dwFlags := FdwFlags;
  result.dwReserved := FdwReserved;
end;

constructor tagBOXLAYOUTWrapper.Create(ARecord: tagBOXLAYOUT);
begin
  inherited Create;
  FcyCusp := ARecord.cyCusp;
  FcyEndCusp := ARecord.cyEndCusp;
  Fstyle := ARecord.style;
  FdwReserved1 := ARecord.dwReserved1;
  FdwReserved2 := ARecord.dwReserved2;
  FdwReserved3 := ARecord.dwReserved3;
end;

function tagBOXLAYOUTWrapper.ObjToRec: tagBOXLAYOUT;
begin
  result.cyCusp := FcyCusp;
  result.cyEndCusp := FcyEndCusp;
  result.style := Fstyle;
  result.dwReserved1 := FdwReserved1;
  result.dwReserved2 := FdwReserved2;
  result.dwReserved3 := FdwReserved3;
end;

constructor tagIMECOLORSWrapper.Create(ARecord: tagIMECOLORS);
begin
  inherited Create;
  FcColors := ARecord.cColors;
end;

function tagIMECOLORSWrapper.ObjToRec: tagIMECOLORS;
begin
  result.cColors := FcColors;
end;

constructor tagCTLINITBEDITWrapper.Create(ARecord: tagCTLINITBEDIT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fhwnd := ARecord.hwnd;
  Fid := ARecord.id;
  FwSizeCategory := ARecord.wSizeCategory;
  FwFlags := ARecord.wFlags;
  FdwReserved := ARecord.dwReserved;
end;

function tagCTLINITBEDITWrapper.ObjToRec: tagCTLINITBEDIT;
begin
  result.cbSize := FcbSize;
  result.hwnd := Fhwnd;
  result.id := Fid;
  result.wSizeCategory := FwSizeCategory;
  result.wFlags := FwFlags;
  result.dwReserved := FdwReserved;
end;

constructor tagBOXEDITINFOWrapper.Create(ARecord: tagBOXEDITINFO);
begin
  inherited Create;
  FcxBox := ARecord.cxBox;
  FcyBox := ARecord.cyBox;
  FcxBase := ARecord.cxBase;
  FcyBase := ARecord.cyBase;
  FcyMid := ARecord.cyMid;
  FwFlags := ARecord.wFlags;
  FwFontHeight := ARecord.wFontHeight;
end;

function tagBOXEDITINFOWrapper.ObjToRec: tagBOXEDITINFO;
begin
  result.cxBox := FcxBox;
  result.cyBox := FcyBox;
  result.cxBase := FcxBase;
  result.cyBase := FcyBase;
  result.cyMid := FcyMid;
  result.wFlags := FwFlags;
  result.wFontHeight := FwFontHeight;
end;

constructor tagRECTOFSWrapper.Create(ARecord: tagRECTOFS);
begin
  inherited Create;
  FdLeft := ARecord.dLeft;
  FdTop := ARecord.dTop;
  FdRight := ARecord.dRight;
  FdBottom := ARecord.dBottom;
end;

function tagRECTOFSWrapper.ObjToRec: tagRECTOFS;
begin
  result.dLeft := FdLeft;
  result.dTop := FdTop;
  result.dRight := FdRight;
  result.dBottom := FdBottom;
end;

constructor tagPENDATAHEADERWrapper.Create(ARecord: tagPENDATAHEADER);
begin
  inherited Create;
  FwVersion := ARecord.wVersion;
  FcbSizeUsed := ARecord.cbSizeUsed;
  FcStrokes := ARecord.cStrokes;
  FcPnt := ARecord.cPnt;
  FcPntStrokeMax := ARecord.cPntStrokeMax;
  FwPndts := ARecord.wPndts;
  FnInkWidth := ARecord.nInkWidth;
  FrgbInk := ARecord.rgbInk;
end;

function tagPENDATAHEADERWrapper.ObjToRec: tagPENDATAHEADER;
begin
  result.wVersion := FwVersion;
  result.cbSizeUsed := FcbSizeUsed;
  result.cStrokes := FcStrokes;
  result.cPnt := FcPnt;
  result.cPntStrokeMax := FcPntStrokeMax;
  result.wPndts := FwPndts;
  result.nInkWidth := FnInkWidth;
  result.rgbInk := FrgbInk;
end;

constructor tagSTROKEINFOWrapper.Create(ARecord: tagSTROKEINFO);
begin
  inherited Create;
  FcPnt := ARecord.cPnt;
  FcbPnts := ARecord.cbPnts;
  FwPdk := ARecord.wPdk;
  FdwTick := ARecord.dwTick;
end;

function tagSTROKEINFOWrapper.ObjToRec: tagSTROKEINFO;
begin
  result.cPnt := FcPnt;
  result.cbPnts := FcbPnts;
  result.wPdk := FwPdk;
  result.dwTick := FdwTick;
end;

constructor tagPENTIPWrapper.Create(ARecord: tagPENTIP);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fbtype := ARecord.btype;
  Fbwidth := ARecord.bwidth;
  Fbheight := ARecord.bheight;
  FbOpacity := ARecord.bOpacity;
  Frgb := ARecord.rgb;
  FdwFlags := ARecord.dwFlags;
  FdwReserved := ARecord.dwReserved;
end;

function tagPENTIPWrapper.ObjToRec: tagPENTIP;
begin
  result.cbSize := FcbSize;
  result.btype := Fbtype;
  result.bwidth := Fbwidth;
  result.bheight := Fbheight;
  result.bOpacity := FbOpacity;
  result.rgb := Frgb;
  result.dwFlags := FdwFlags;
  result.dwReserved := FdwReserved;
end;

constructor tagANIMATEINFOWrapper.Create(ARecord: tagANIMATEINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FuSpeedPct := ARecord.uSpeedPct;
  FuPeriodCB := ARecord.uPeriodCB;
  FfuFlags := ARecord.fuFlags;
  FlParam := ARecord.lParam;
  FdwReserved := ARecord.dwReserved;
end;

function tagANIMATEINFOWrapper.ObjToRec: tagANIMATEINFO;
begin
  result.cbSize := FcbSize;
  result.uSpeedPct := FuSpeedPct;
  result.uPeriodCB := FuPeriodCB;
  result.fuFlags := FfuFlags;
  result.lParam := FlParam;
  result.dwReserved := FdwReserved;
end;

constructor tagOEMPENINFOWrapper.Create(ARecord: tagOEMPENINFO);
begin
  inherited Create;
  FwPdt := ARecord.wPdt;
  FwValueMax := ARecord.wValueMax;
  FwDistinct := ARecord.wDistinct;
end;

function tagOEMPENINFOWrapper.ObjToRec: tagOEMPENINFO;
begin
  result.wPdt := FwPdt;
  result.wValueMax := FwValueMax;
  result.wDistinct := FwDistinct;
end;

constructor tagPENPACKETWrapper.Create(ARecord: tagPENPACKET);
begin
  inherited Create;
  FwTabletX := ARecord.wTabletX;
  FwTabletY := ARecord.wTabletY;
  FwPDK := ARecord.wPDK;
end;

function tagPENPACKETWrapper.ObjToRec: tagPENPACKET;
begin
  result.wTabletX := FwTabletX;
  result.wTabletY := FwTabletY;
  result.wPDK := FwPDK;
end;

constructor tagOEMPENPACKETWrapper.Create(ARecord: tagOEMPENPACKET);
begin
  inherited Create;
  FwTabletX := ARecord.wTabletX;
  FwTabletY := ARecord.wTabletY;
  FwPDK := ARecord.wPDK;
  FdwTime := ARecord.dwTime;
end;

function tagOEMPENPACKETWrapper.ObjToRec: tagOEMPENPACKET;
begin
  result.wTabletX := FwTabletX;
  result.wTabletY := FwTabletY;
  result.wPDK := FwPDK;
  result.dwTime := FdwTime;
end;

constructor tagPENINFOWrapper.Create(ARecord: tagPENINFO);
begin
  inherited Create;
  FcxRawWidth := ARecord.cxRawWidth;
  FcyRawHeight := ARecord.cyRawHeight;
  FwDistinctWidth := ARecord.wDistinctWidth;
  FwDistinctHeight := ARecord.wDistinctHeight;
  FnSamplingRate := ARecord.nSamplingRate;
  FnSamplingDist := ARecord.nSamplingDist;
  FlPdc := ARecord.lPdc;
  FcPens := ARecord.cPens;
  FcbOemData := ARecord.cbOemData;
  FfuOEM := ARecord.fuOEM;
end;

function tagPENINFOWrapper.ObjToRec: tagPENINFO;
begin
  result.cxRawWidth := FcxRawWidth;
  result.cyRawHeight := FcyRawHeight;
  result.wDistinctWidth := FwDistinctWidth;
  result.wDistinctHeight := FwDistinctHeight;
  result.nSamplingRate := FnSamplingRate;
  result.nSamplingDist := FnSamplingDist;
  result.lPdc := FlPdc;
  result.cPens := FcPens;
  result.cbOemData := FcbOemData;
  result.fuOEM := FfuOEM;
end;

constructor tagCALBSTRUCTWrapper.Create(ARecord: tagCALBSTRUCT);
begin
  inherited Create;
  FwOffsetX := ARecord.wOffsetX;
  FwOffsetY := ARecord.wOffsetY;
  FwDistinctWidth := ARecord.wDistinctWidth;
  FwDistinctHeight := ARecord.wDistinctHeight;
end;

function tagCALBSTRUCTWrapper.ObjToRec: tagCALBSTRUCT;
begin
  result.wOffsetX := FwOffsetX;
  result.wOffsetY := FwOffsetY;
  result.wDistinctWidth := FwDistinctWidth;
  result.wDistinctHeight := FwDistinctHeight;
end;

constructor tagINTERVALWrapper.Create(ARecord: tagINTERVAL);
begin
  inherited Create;
end;

function tagINTERVALWrapper.ObjToRec: tagINTERVAL;
begin
end;

constructor tagBOXRESULTSWrapper.Create(ARecord: tagBOXRESULTS);
begin
  inherited Create;
  FindxBox := ARecord.indxBox;
  FhinksetBox := ARecord.hinksetBox;
end;

function tagBOXRESULTSWrapper.ObjToRec: tagBOXRESULTS;
begin
  result.indxBox := FindxBox;
  result.hinksetBox := FhinksetBox;
end;

constructor tagGUIDEWrapper.Create(ARecord: tagGUIDE);
begin
  inherited Create;
  FxOrigin := ARecord.xOrigin;
  FyOrigin := ARecord.yOrigin;
  FcxBox := ARecord.cxBox;
  FcyBox := ARecord.cyBox;
  FcxBase := ARecord.cxBase;
  FcyBase := ARecord.cyBase;
  FcHorzBox := ARecord.cHorzBox;
  FcVertBox := ARecord.cVertBox;
  FcyMid := ARecord.cyMid;
end;

function tagGUIDEWrapper.ObjToRec: tagGUIDE;
begin
  result.xOrigin := FxOrigin;
  result.yOrigin := FyOrigin;
  result.cxBox := FcxBox;
  result.cyBox := FcyBox;
  result.cxBase := FcxBase;
  result.cyBase := FcyBase;
  result.cHorzBox := FcHorzBox;
  result.cVertBox := FcVertBox;
  result.cyMid := FcyMid;
end;

constructor tagCTLINITIEDITWrapper.Create(ARecord: tagCTLINITIEDIT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fhwnd := ARecord.hwnd;
  Fid := ARecord.id;
  Fieb := ARecord.ieb;
  Fiedo := ARecord.iedo;
  Fiei := ARecord.iei;
  Fien := ARecord.ien;
  Fierec := ARecord.ierec;
  Fies := ARecord.ies;
  Fiesec := ARecord.iesec;
  Fpdts := ARecord.pdts;
  Fhpndt := ARecord.hpndt;
  Fhgdiobj := ARecord.hgdiobj;
  FhpenGrid := ARecord.hpenGrid;
  FwVGrid := ARecord.wVGrid;
  FwHGrid := ARecord.wHGrid;
  FdwApp := ARecord.dwApp;
  FdwReserved := ARecord.dwReserved;
end;

function tagCTLINITIEDITWrapper.ObjToRec: tagCTLINITIEDIT;
begin
  result.cbSize := FcbSize;
  result.hwnd := Fhwnd;
  result.id := Fid;
  result.ieb := Fieb;
  result.iedo := Fiedo;
  result.iei := Fiei;
  result.ien := Fien;
  result.ierec := Fierec;
  result.ies := Fies;
  result.iesec := Fiesec;
  result.pdts := Fpdts;
  result.hpndt := Fhpndt;
  result.hgdiobj := Fhgdiobj;
  result.hpenGrid := FhpenGrid;
  result.wVGrid := FwVGrid;
  result.wHGrid := FwHGrid;
  result.dwApp := FdwApp;
  result.dwReserved := FdwReserved;
end;

constructor tagPDEVENTWrapper.Create(ARecord: tagPDEVENT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fhwnd := ARecord.hwnd;
  Fwm := ARecord.wm;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
  FfPen := ARecord.fPen;
  FlExInfo := ARecord.lExInfo;
  FdwReserved := ARecord.dwReserved;
end;

function tagPDEVENTWrapper.ObjToRec: tagPDEVENT;
begin
  result.cbSize := FcbSize;
  result.hwnd := Fhwnd;
  result.wm := Fwm;
  result.wParam := FwParam;
  result.lParam := FlParam;
  result.fPen := FfPen;
  result.lExInfo := FlExInfo;
  result.dwReserved := FdwReserved;
end;

constructor tagSTRKFMTWrapper.Create(ARecord: tagSTRKFMT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fiesf := ARecord.iesf;
  FiStrk := ARecord.iStrk;
  FdwUser := ARecord.dwUser;
  FdwReserved := ARecord.dwReserved;
end;

function tagSTRKFMTWrapper.ObjToRec: tagSTRKFMT;
begin
  result.cbSize := FcbSize;
  result.iesf := Fiesf;
  result.iStrk := FiStrk;
  result.dwUser := FdwUser;
  result.dwReserved := FdwReserved;
end;

constructor tagPCMINFOWrapper.Create(ARecord: tagPCMINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwPcm := ARecord.dwPcm;
  FhrgnBound := ARecord.hrgnBound;
  FhrgnExclude := ARecord.hrgnExclude;
  FdwTimeout := ARecord.dwTimeout;
end;

function tagPCMINFOWrapper.ObjToRec: tagPCMINFO;
begin
  result.cbSize := FcbSize;
  result.dwPcm := FdwPcm;
  result.hrgnBound := FhrgnBound;
  result.hrgnExclude := FhrgnExclude;
  result.dwTimeout := FdwTimeout;
end;

constructor tagINKINGINFOWrapper.Create(ARecord: tagINKINGINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FwFlags := ARecord.wFlags;
  FhrgnClip := ARecord.hrgnClip;
  FhrgnInkStop := ARecord.hrgnInkStop;
end;

function tagINKINGINFOWrapper.ObjToRec: tagINKINGINFO;
begin
  result.cbSize := FcbSize;
  result.wFlags := FwFlags;
  result.hrgnClip := FhrgnClip;
  result.hrgnInkStop := FhrgnInkStop;
end;

constructor tagSYCWrapper.Create(ARecord: tagSYC);
begin
  inherited Create;
  FwStrokeFirst := ARecord.wStrokeFirst;
  FwPntFirst := ARecord.wPntFirst;
  FwStrokeLast := ARecord.wStrokeLast;
  FwPntLast := ARecord.wPntLast;
  FfLastSyc := ARecord.fLastSyc;
end;

function tagSYCWrapper.ObjToRec: tagSYC;
begin
  result.wStrokeFirst := FwStrokeFirst;
  result.wPntFirst := FwPntFirst;
  result.wStrokeLast := FwStrokeLast;
  result.wPntLast := FwPntLast;
  result.fLastSyc := FfLastSyc;
end;

constructor tagSYEWrapper.Create(ARecord: tagSYE);
begin
  inherited Create;
  Fsyv := ARecord.syv;
  FlRecogVal := ARecord.lRecogVal;
  Fcl := ARecord.cl;
  FiSyc := ARecord.iSyc;
end;

function tagSYEWrapper.ObjToRec: tagSYE;
begin
  result.syv := Fsyv;
  result.lRecogVal := FlRecogVal;
  result.cl := Fcl;
  result.iSyc := FiSyc;
end;

constructor tagSYGWrapper.Create(ARecord: tagSYG);
begin
  inherited Create;
  FcHotSpot := ARecord.cHotSpot;
  FnFirstBox := ARecord.nFirstBox;
  FlRecogVal := ARecord.lRecogVal;
  FcSye := ARecord.cSye;
  FcSyc := ARecord.cSyc;
end;

function tagSYGWrapper.ObjToRec: tagSYG;
begin
  result.cHotSpot := FcHotSpot;
  result.nFirstBox := FnFirstBox;
  result.lRecogVal := FlRecogVal;
  result.cSye := FcSye;
  result.cSyc := FcSyc;
end;

constructor tagRCWrapper.Create(ARecord: tagRC);
begin
  inherited Create;
  Fhrec := ARecord.hrec;
  Fhwnd := ARecord.hwnd;
  FwEventRef := ARecord.wEventRef;
  FwRcPreferences := ARecord.wRcPreferences;
  FlRcOptions := ARecord.lRcOptions;
  FwCountry := ARecord.wCountry;
  FwIntlPreferences := ARecord.wIntlPreferences;
  FwTryDictionary := ARecord.wTryDictionary;
  FclErrorLevel := ARecord.clErrorLevel;
  Falc := ARecord.alc;
  FalcPriority := ARecord.alcPriority;
  FwResultMode := ARecord.wResultMode;
  FwTimeOut := ARecord.wTimeOut;
  FlPcm := ARecord.lPcm;
  FwRcOrient := ARecord.wRcOrient;
  FwRcDirect := ARecord.wRcDirect;
  FnInkWidth := ARecord.nInkWidth;
  FrgbInk := ARecord.rgbInk;
  FdwAppParam := ARecord.dwAppParam;
  FdwDictParam := ARecord.dwDictParam;
  FdwRecognizer := ARecord.dwRecognizer;
end;

function tagRCWrapper.ObjToRec: tagRC;
begin
  result.hrec := Fhrec;
  result.hwnd := Fhwnd;
  result.wEventRef := FwEventRef;
  result.wRcPreferences := FwRcPreferences;
  result.lRcOptions := FlRcOptions;
  result.wCountry := FwCountry;
  result.wIntlPreferences := FwIntlPreferences;
  result.wTryDictionary := FwTryDictionary;
  result.clErrorLevel := FclErrorLevel;
  result.alc := Falc;
  result.alcPriority := FalcPriority;
  result.wResultMode := FwResultMode;
  result.wTimeOut := FwTimeOut;
  result.lPcm := FlPcm;
  result.wRcOrient := FwRcOrient;
  result.wRcDirect := FwRcDirect;
  result.nInkWidth := FnInkWidth;
  result.rgbInk := FrgbInk;
  result.dwAppParam := FdwAppParam;
  result.dwDictParam := FdwDictParam;
  result.dwRecognizer := FdwRecognizer;
end;

constructor tagRCRESULTWrapper.Create(ARecord: tagRCRESULT);
begin
  inherited Create;
  FwResultsType := ARecord.wResultsType;
  FcSyv := ARecord.cSyv;
  FhSyv := ARecord.hSyv;
  FnBaseLine := ARecord.nBaseLine;
  FnMidLine := ARecord.nMidLine;
  Fhpendata := ARecord.hpendata;
end;

function tagRCRESULTWrapper.ObjToRec: tagRCRESULT;
begin
  result.wResultsType := FwResultsType;
  result.cSyv := FcSyv;
  result.hSyv := FhSyv;
  result.nBaseLine := FnBaseLine;
  result.nMidLine := FnMidLine;
  result.hpendata := Fhpendata;
end;

constructor tagTARGETWrapper.Create(ARecord: tagTARGET);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FidTarget := ARecord.idTarget;
  FhtrgTarget := ARecord.htrgTarget;
  FdwData := ARecord.dwData;
end;

function tagTARGETWrapper.ObjToRec: tagTARGET;
begin
  result.dwFlags := FdwFlags;
  result.idTarget := FidTarget;
  result.htrgTarget := FhtrgTarget;
  result.dwData := FdwData;
end;

constructor tagTARGINFOWrapper.Create(ARecord: tagTARGINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FhtrgOwner := ARecord.htrgOwner;
  FcTargets := ARecord.cTargets;
  FiTargetLast := ARecord.iTargetLast;
end;

function tagTARGINFOWrapper.ObjToRec: tagTARGINFO;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.htrgOwner := FhtrgOwner;
  result.cTargets := FcTargets;
  result.iTargetLast := FiTargetLast;
end;

constructor tagINPPARAMSWrapper.Create(ARecord: tagINPPARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  Fhpndt := ARecord.hpndt;
end;

function tagINPPARAMSWrapper.ObjToRec: tagINPPARAMS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.hpndt := Fhpndt;
end;

constructor tagSKBINFOWrapper.Create(ARecord: tagSKBINFO);
begin
  inherited Create;
  Fhandle := ARecord.handle;
  FnPad := ARecord.nPad;
  FfVisible := ARecord.fVisible;
  FfMinimized := ARecord.fMinimized;
  FdwReserved := ARecord.dwReserved;
end;

function tagSKBINFOWrapper.ObjToRec: tagSKBINFO;
begin
  result.handle := Fhandle;
  result.nPad := FnPad;
  result.fVisible := FfVisible;
  result.fMinimized := FfMinimized;
  result.dwReserved := FdwReserved;
end;



procedure TatPenWinLibrary.__FPenUpX(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FPenUpX(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetWEventRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetWEventRef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__MpIbf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.MpIbf(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__dwDiffAT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.dwDiffAT(tagABSTIMEWrapper(integer(GetInputArg(0))).ObjToRec,tagABSTIMEWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FLTAbsTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FLTAbsTime(tagABSTIMEWrapper(integer(GetInputArg(0))).ObjToRec,tagABSTIMEWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FLTEAbsTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FLTEAbsTime(tagABSTIMEWrapper(integer(GetInputArg(0))).ObjToRec,tagABSTIMEWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FEQAbsTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FEQAbsTime(tagABSTIMEWrapper(integer(GetInputArg(0))).ObjToRec,tagABSTIMEWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__MakeAbsTime(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TAbsTime;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagABSTIMEWrapper) then 
  Param0Rec := tagABSTIMEWrapper.Create(Param0);
Param0 := tagABSTIMEWrapper(Param0Rec).ObjToRec;
    PenWin.MakeAbsTime(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    SetInputArg(0,integer(tagABSTIMEWrapper.Create(Param0)));
  end;
end;

procedure TatPenWinLibrary.__FIsSpecial(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsSpecial(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsAnsi(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsAnsi(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsGesture(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsGesture(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsKanji(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsKanji(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsShape(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsShape(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsUniCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsUniCode(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsVKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsVKey(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__ChSyvToAnsi(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.ChSyvToAnsi(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__WSyvToKanji(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.WSyvToKanji(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SyvCharacterToSymbol(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SyvCharacterToSymbol(AnsiString(VarToStr(GetInputArg(0)))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SyvKanjiToSymbol(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SyvKanjiToSymbol(AnsiString(VarToStr(GetInputArg(0)))[1]));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsSelectGesture(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsSelectGesture(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsStdGesture(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsStdGesture(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__FIsAnsiGesture(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.FIsAnsiGesture(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SubPenMsgFromWpLp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SubPenMsgFromWpLp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__EventRefFromWpLp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.EventRefFromWpLp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__TerminationFromWpLp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.TerminationFromWpLp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__HwndFromHtrg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.HwndFromHtrg(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__HpcmFromWpLp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.HpcmFromWpLp(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__HtrgFromHwnd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.HtrgFromHwnd(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CompressPenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CompressPenData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CreatePenDataRegion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CreatePenDataRegion(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DestroyPenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.DestroyPenData(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DuplicatePenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.DuplicatePenData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__InsertPenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.InsertPenData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__MetricScalePenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.MetricScalePenData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__OffsetPenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.OffsetPenData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__RemovePenDataStrokes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.RemovePenDataStrokes(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetStrokeAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetStrokeAttributes(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetStrokeTableAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetStrokeTableAttributes(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__TrimPenData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.TrimPenData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetPenAsyncState(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.GetPenAsyncState(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__IsPenEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.IsPenEvent(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__AddPenDataHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.AddPenDataHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__AddWordsHWL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.AddWordsHWL(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__ConfigHREC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.ConfigHREC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CreateCompatibleHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CreateCompatibleHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CreateHWL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CreateHWL(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CreateInksetHRCRESULT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CreateInksetHRCRESULT(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CreatePenDataHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CreatePenDataHRC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DestroyHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.DestroyHRC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DestroyHRCRESULT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.DestroyHRCRESULT(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DestroyHWL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.DestroyHWL(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__EnableGestureSetHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.EnableGestureSetHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__EnableSystemDictionaryHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.EnableSystemDictionaryHRC(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__EndPenInputHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.EndPenInputHRC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetHRECFromHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetHRECFromHRC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetMaxResultsHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetMaxResultsHRC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetSymbolCountHRCRESULT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetSymbolCountHRCRESULT(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetWordlistCoercionHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetWordlistCoercionHRC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__ProcessHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.ProcessHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__ReadHWL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.ReadHWL(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetInternationalHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetInternationalHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetMaxResultsHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetMaxResultsHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetWordlistCoercionHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetWordlistCoercionHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetWordlistHRC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetWordlistHRC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__UnhookResultsHookHREC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.UnhookResultsHookHREC(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__WriteHWL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.WriteHWL(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__InstallRecognizer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.InstallRecognizer(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__CreateInkset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.CreateInkset(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DestroyInkset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := PenWin.DestroyInkset(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetInksetIntervalCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetInksetIntervalCount(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__DoDefaultPenInput(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.DoDefaultPenInput(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__StopInking(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.StopInking(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__StopPenInput(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.StopPenInput(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetPenAppFlags(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetPenAppFlags);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetPenMiscInfo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetPenMiscInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__GetVersionPenWin(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.GetVersionPenWin);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.__SetPenMiscInfo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(PenWin.SetPenMiscInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPenWinLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FPenUpX',1,tkVariant,nil,__FPenUpX,false,0);
    DefineMethod('GetWEventRef',0,tkInteger,nil,__GetWEventRef,false,0);
    DefineMethod('MpIbf',1,tkInteger,nil,__MpIbf,false,0);
    DefineMethod('dwDiffAT',2,tkInteger,nil,__dwDiffAT,false,0);
    DefineMethod('FLTAbsTime',2,tkVariant,nil,__FLTAbsTime,false,0);
    DefineMethod('FLTEAbsTime',2,tkVariant,nil,__FLTEAbsTime,false,0);
    DefineMethod('FEQAbsTime',2,tkVariant,nil,__FEQAbsTime,false,0);
    DefineMethod('MakeAbsTime',3,tkNone,nil,__MakeAbsTime,false,0).SetVarArgs([0]);
    DefineMethod('FIsSpecial',1,tkVariant,nil,__FIsSpecial,false,0);
    DefineMethod('FIsAnsi',1,tkVariant,nil,__FIsAnsi,false,0);
    DefineMethod('FIsGesture',1,tkVariant,nil,__FIsGesture,false,0);
    DefineMethod('FIsKanji',1,tkVariant,nil,__FIsKanji,false,0);
    DefineMethod('FIsShape',1,tkVariant,nil,__FIsShape,false,0);
    DefineMethod('FIsUniCode',1,tkVariant,nil,__FIsUniCode,false,0);
    DefineMethod('FIsVKey',1,tkVariant,nil,__FIsVKey,false,0);
    DefineMethod('ChSyvToAnsi',1,tkInteger,nil,__ChSyvToAnsi,false,0);
    DefineMethod('WSyvToKanji',1,tkInteger,nil,__WSyvToKanji,false,0);
    DefineMethod('SyvCharacterToSymbol',1,tkInteger,nil,__SyvCharacterToSymbol,false,0);
    DefineMethod('SyvKanjiToSymbol',1,tkInteger,nil,__SyvKanjiToSymbol,false,0);
    DefineMethod('FIsSelectGesture',1,tkVariant,nil,__FIsSelectGesture,false,0);
    DefineMethod('FIsStdGesture',1,tkVariant,nil,__FIsStdGesture,false,0);
    DefineMethod('FIsAnsiGesture',1,tkVariant,nil,__FIsAnsiGesture,false,0);
    DefineMethod('SubPenMsgFromWpLp',2,tkInteger,nil,__SubPenMsgFromWpLp,false,0);
    DefineMethod('EventRefFromWpLp',2,tkInteger,nil,__EventRefFromWpLp,false,0);
    DefineMethod('TerminationFromWpLp',2,tkInteger,nil,__TerminationFromWpLp,false,0);
    DefineMethod('HwndFromHtrg',1,tkInteger,nil,__HwndFromHtrg,false,0);
    DefineMethod('HpcmFromWpLp',2,tkInteger,nil,__HpcmFromWpLp,false,0);
    DefineMethod('HtrgFromHwnd',1,tkInteger,nil,__HtrgFromHwnd,false,0);
    DefineMethod('CompressPenData',3,tkInteger,nil,__CompressPenData,false,0);
    DefineMethod('CreatePenDataRegion',2,tkInteger,nil,__CreatePenDataRegion,false,0);
    DefineMethod('DestroyPenData',1,tkVariant,nil,__DestroyPenData,false,0);
    DefineMethod('DuplicatePenData',2,tkInteger,nil,__DuplicatePenData,false,0);
    DefineMethod('InsertPenData',3,tkInteger,nil,__InsertPenData,false,0);
    DefineMethod('MetricScalePenData',2,tkVariant,nil,__MetricScalePenData,false,0);
    DefineMethod('OffsetPenData',3,tkVariant,nil,__OffsetPenData,false,0);
    DefineMethod('RemovePenDataStrokes',3,tkInteger,nil,__RemovePenDataStrokes,false,0);
    DefineMethod('SetStrokeAttributes',4,tkInteger,nil,__SetStrokeAttributes,false,0);
    DefineMethod('SetStrokeTableAttributes',4,tkInteger,nil,__SetStrokeTableAttributes,false,0);
    DefineMethod('TrimPenData',3,tkInteger,nil,__TrimPenData,false,0);
    DefineMethod('GetPenAsyncState',1,tkVariant,nil,__GetPenAsyncState,false,0);
    DefineMethod('IsPenEvent',2,tkVariant,nil,__IsPenEvent,false,0);
    DefineMethod('AddPenDataHRC',2,tkInteger,nil,__AddPenDataHRC,false,0);
    DefineMethod('AddWordsHWL',3,tkInteger,nil,__AddWordsHWL,false,0);
    DefineMethod('ConfigHREC',4,tkInteger,nil,__ConfigHREC,false,0);
    DefineMethod('CreateCompatibleHRC',2,tkInteger,nil,__CreateCompatibleHRC,false,0);
    DefineMethod('CreateHWL',4,tkInteger,nil,__CreateHWL,false,0);
    DefineMethod('CreateInksetHRCRESULT',3,tkInteger,nil,__CreateInksetHRCRESULT,false,0);
    DefineMethod('CreatePenDataHRC',1,tkInteger,nil,__CreatePenDataHRC,false,0);
    DefineMethod('DestroyHRC',1,tkInteger,nil,__DestroyHRC,false,0);
    DefineMethod('DestroyHRCRESULT',1,tkInteger,nil,__DestroyHRCRESULT,false,0);
    DefineMethod('DestroyHWL',1,tkInteger,nil,__DestroyHWL,false,0);
    DefineMethod('EnableGestureSetHRC',3,tkInteger,nil,__EnableGestureSetHRC,false,0);
    DefineMethod('EnableSystemDictionaryHRC',2,tkInteger,nil,__EnableSystemDictionaryHRC,false,0);
    DefineMethod('EndPenInputHRC',1,tkInteger,nil,__EndPenInputHRC,false,0);
    DefineMethod('GetHRECFromHRC',1,tkInteger,nil,__GetHRECFromHRC,false,0);
    DefineMethod('GetMaxResultsHRC',1,tkInteger,nil,__GetMaxResultsHRC,false,0);
    DefineMethod('GetSymbolCountHRCRESULT',1,tkInteger,nil,__GetSymbolCountHRCRESULT,false,0);
    DefineMethod('GetWordlistCoercionHRC',1,tkInteger,nil,__GetWordlistCoercionHRC,false,0);
    DefineMethod('ProcessHRC',2,tkInteger,nil,__ProcessHRC,false,0);
    DefineMethod('ReadHWL',2,tkInteger,nil,__ReadHWL,false,0);
    DefineMethod('SetInternationalHRC',5,tkInteger,nil,__SetInternationalHRC,false,0);
    DefineMethod('SetMaxResultsHRC',2,tkInteger,nil,__SetMaxResultsHRC,false,0);
    DefineMethod('SetWordlistCoercionHRC',2,tkInteger,nil,__SetWordlistCoercionHRC,false,0);
    DefineMethod('SetWordlistHRC',2,tkInteger,nil,__SetWordlistHRC,false,0);
    DefineMethod('UnhookResultsHookHREC',2,tkInteger,nil,__UnhookResultsHookHREC,false,0);
    DefineMethod('WriteHWL',2,tkInteger,nil,__WriteHWL,false,0);
    DefineMethod('InstallRecognizer',1,tkInteger,nil,__InstallRecognizer,false,0);
    DefineMethod('CreateInkset',1,tkInteger,nil,__CreateInkset,false,0);
    DefineMethod('DestroyInkset',1,tkVariant,nil,__DestroyInkset,false,0);
    DefineMethod('GetInksetIntervalCount',1,tkInteger,nil,__GetInksetIntervalCount,false,0);
    DefineMethod('DoDefaultPenInput',2,tkInteger,nil,__DoDefaultPenInput,false,0);
    DefineMethod('StopInking',1,tkInteger,nil,__StopInking,false,0);
    DefineMethod('StopPenInput',3,tkInteger,nil,__StopPenInput,false,0);
    DefineMethod('GetPenAppFlags',0,tkInteger,nil,__GetPenAppFlags,false,0);
    DefineMethod('GetPenMiscInfo',2,tkInteger,nil,__GetPenMiscInfo,false,0);
    DefineMethod('GetVersionPenWin',0,tkInteger,nil,__GetVersionPenWin,false,0);
    DefineMethod('SetPenMiscInfo',2,tkInteger,nil,__SetPenMiscInfo,false,0);
    AddConstant('ALC_DEFAULT',ALC_DEFAULT);
    AddConstant('ALC_LCALPHA',ALC_LCALPHA);
    AddConstant('ALC_UCALPHA',ALC_UCALPHA);
    AddConstant('ALC_NUMERIC',ALC_NUMERIC);
    AddConstant('ALC_PUNC',ALC_PUNC);
    AddConstant('ALC_MATH',ALC_MATH);
    AddConstant('ALC_MONETARY',ALC_MONETARY);
    AddConstant('ALC_OTHER',ALC_OTHER);
    AddConstant('ALC_ASCII',ALC_ASCII);
    AddConstant('ALC_WHITE',ALC_WHITE);
    AddConstant('ALC_NONPRINT',ALC_NONPRINT);
    AddConstant('ALC_DBCS',ALC_DBCS);
    AddConstant('ALC_JIS1',ALC_JIS1);
    AddConstant('ALC_GESTURE',ALC_GESTURE);
    AddConstant('ALC_USEBITMAP',ALC_USEBITMAP);
    AddConstant('ALC_HIRAGANA',ALC_HIRAGANA);
    AddConstant('ALC_KATAKANA',ALC_KATAKANA);
    AddConstant('ALC_KANJI',ALC_KANJI);
    AddConstant('ALC_GLOBALPRIORITY',ALC_GLOBALPRIORITY);
    AddConstant('ALC_OEM',ALC_OEM);
    AddConstant('ALC_RESERVED',ALC_RESERVED);
    AddConstant('ALC_NOPRIORITY',ALC_NOPRIORITY);
    AddConstant('ALC_ALPHA',ALC_ALPHA);
    AddConstant('ALC_ALPHANUMERIC',ALC_ALPHANUMERIC);
    AddConstant('ALC_SYSMINIMUM',ALC_SYSMINIMUM);
    AddConstant('ALC_ALL',ALC_ALL);
    AddConstant('ALC_KANJISYSMINIMUM',ALC_KANJISYSMINIMUM);
    AddConstant('ALC_KANJIALL',ALC_KANJIALL);
    AddConstant('BXS_NONE',BXS_NONE);
    AddConstant('BXS_RECT',BXS_RECT);
    AddConstant('BXS_BOXCROSS',BXS_BOXCROSS);
    AddConstant('BXS_MASK',BXS_MASK);
    AddConstant('OBM_SKBBTNUP',OBM_SKBBTNUP);
    AddConstant('OBM_SKBBTNDOWN',OBM_SKBBTNDOWN);
    AddConstant('OBM_SKBBTNDISABLED',OBM_SKBBTNDISABLED);
    AddConstant('OBM_ZENBTNUP',OBM_ZENBTNUP);
    AddConstant('OBM_ZENBTNDOWN',OBM_ZENBTNDOWN);
    AddConstant('OBM_ZENBTNDISABLED',OBM_ZENBTNDISABLED);
    AddConstant('OBM_HANBTNUP',OBM_HANBTNUP);
    AddConstant('OBM_HANBTNDOWN',OBM_HANBTNDOWN);
    AddConstant('OBM_HANBTNDISABLED',OBM_HANBTNDISABLED);
    AddConstant('OBM_KKCBTNUP',OBM_KKCBTNUP);
    AddConstant('OBM_KKCBTNDOWN',OBM_KKCBTNDOWN);
    AddConstant('OBM_KKCBTNDISABLED',OBM_KKCBTNDISABLED);
    AddConstant('OBM_SIPBTNUP',OBM_SIPBTNUP);
    AddConstant('OBM_SIPBTNDOWN',OBM_SIPBTNDOWN);
    AddConstant('OBM_SIPBTNDISABLED',OBM_SIPBTNDISABLED);
    AddConstant('OBM_PTYBTNUP',OBM_PTYBTNUP);
    AddConstant('OBM_PTYBTNDOWN',OBM_PTYBTNDOWN);
    AddConstant('OBM_PTYBTNDISABLED',OBM_PTYBTNDISABLED);
    AddConstant('SYV_NULL',SYV_NULL);
    AddConstant('SYV_UNKNOWN',SYV_UNKNOWN);
    AddConstant('SYV_EMPTY',SYV_EMPTY);
    AddConstant('SYV_BEGINOR',SYV_BEGINOR);
    AddConstant('SYV_ENDOR',SYV_ENDOR);
    AddConstant('SYV_OR',SYV_OR);
    AddConstant('SYV_SOFTNEWLINE',SYV_SOFTNEWLINE);
    AddConstant('SYV_SPACENULL',SYV_SPACENULL);
    AddConstant('SYV_SELECTFIRST',SYV_SELECTFIRST);
    AddConstant('SYV_LASSO',SYV_LASSO);
    AddConstant('SYV_SELECTLEFT',SYV_SELECTLEFT);
    AddConstant('SYV_SELECTRIGHT',SYV_SELECTRIGHT);
    AddConstant('SYV_SELECTLAST',SYV_SELECTLAST);
    AddConstant('SYV_CLEARCHAR',SYV_CLEARCHAR);
    AddConstant('SYV_HELP',SYV_HELP);
    AddConstant('SYV_KKCONVERT',SYV_KKCONVERT);
    AddConstant('SYV_CLEAR',SYV_CLEAR);
    AddConstant('SYV_INSERT',SYV_INSERT);
    AddConstant('SYV_CONTEXT',SYV_CONTEXT);
    AddConstant('SYV_EXTENDSELECT',SYV_EXTENDSELECT);
    AddConstant('SYV_UNDO',SYV_UNDO);
    AddConstant('SYV_COPY',SYV_COPY);
    AddConstant('SYV_CUT',SYV_CUT);
    AddConstant('SYV_PASTE',SYV_PASTE);
    AddConstant('SYV_CLEARWORD',SYV_CLEARWORD);
    AddConstant('SYV_USER',SYV_USER);
    AddConstant('SYV_CORRECT',SYV_CORRECT);
    AddConstant('SYV_BACKSPACE',SYV_BACKSPACE);
    AddConstant('SYV_TAB',SYV_TAB);
    AddConstant('SYV_RETURN',SYV_RETURN);
    AddConstant('SYV_SPACE',SYV_SPACE);
    AddConstant('SYV_APPGESTUREMASK',SYV_APPGESTUREMASK);
    AddConstant('SYV_CIRCLEUPA',SYV_CIRCLEUPA);
    AddConstant('SYV_CIRCLEUPZ',SYV_CIRCLEUPZ);
    AddConstant('SYV_CIRCLELOA',SYV_CIRCLELOA);
    AddConstant('SYV_CIRCLELOZ',SYV_CIRCLELOZ);
    AddConstant('SYV_SHAPELINE',SYV_SHAPELINE);
    AddConstant('SYV_SHAPEELLIPSE',SYV_SHAPEELLIPSE);
    AddConstant('SYV_SHAPERECT',SYV_SHAPERECT);
    AddConstant('SYV_SHAPEMIN',SYV_SHAPEMIN);
    AddConstant('SYV_SHAPEMAX',SYV_SHAPEMAX);
    AddConstant('SYVHI_SPECIAL',SYVHI_SPECIAL);
    AddConstant('SYVHI_ANSI',SYVHI_ANSI);
    AddConstant('SYVHI_GESTURE',SYVHI_GESTURE);
    AddConstant('SYVHI_KANJI',SYVHI_KANJI);
    AddConstant('SYVHI_SHAPE',SYVHI_SHAPE);
    AddConstant('SYVHI_UNICODE',SYVHI_UNICODE);
    AddConstant('SYVHI_VKEY',SYVHI_VKEY);
    AddConstant('IEM_UNDO',IEM_UNDO);
    AddConstant('IEM_CUT',IEM_CUT);
    AddConstant('IEM_COPY',IEM_COPY);
    AddConstant('IEM_PASTE',IEM_PASTE);
    AddConstant('IEM_CLEAR',IEM_CLEAR);
    AddConstant('IEM_SELECTALL',IEM_SELECTALL);
    AddConstant('IEM_ERASE',IEM_ERASE);
    AddConstant('IEM_PROPERTIES',IEM_PROPERTIES);
    AddConstant('IEM_LASSO',IEM_LASSO);
    AddConstant('IEM_RESIZE',IEM_RESIZE);
    AddConstant('IEM_USER',IEM_USER);
    AddConstant('IES_BORDER',IES_BORDER);
    AddConstant('IES_HSCROLL',IES_HSCROLL);
    AddConstant('IES_VSCROLL',IES_VSCROLL);
    AddConstant('IES_OWNERDRAW',IES_OWNERDRAW);
    AddConstant('AI_CBSTROKE',AI_CBSTROKE);
    AddConstant('AI_SKIPUPSTROKES',AI_SKIPUPSTROKES);
    AddConstant('CMPD_COMPRESS',CMPD_COMPRESS);
    AddConstant('CMPD_DECOMPRESS',CMPD_DECOMPRESS);
    AddConstant('CPDR_BOX',CPDR_BOX);
    AddConstant('CPDR_LASSO',CPDR_LASSO);
    AddConstant('CPD_DEFAULT',CPD_DEFAULT);
    AddConstant('CPD_USERBYTE',CPD_USERBYTE);
    AddConstant('CPD_USERWORD',CPD_USERWORD);
    AddConstant('CPD_USERDWORD',CPD_USERDWORD);
    AddConstant('CPD_TIME',CPD_TIME);
    AddConstant('DPD_HDCPEN',DPD_HDCPEN);
    AddConstant('DPD_DRAWSEL',DPD_DRAWSEL);
    AddConstant('EPDP_REMOVE',EPDP_REMOVE);
    AddConstant('EPDS_SELECT',EPDS_SELECT);
    AddConstant('EPDS_STROKEINDEX',EPDS_STROKEINDEX);
    AddConstant('EPDS_USER',EPDS_USER);
    AddConstant('EPDS_PENTIP',EPDS_PENTIP);
    AddConstant('EPDS_TIPCOLOR',EPDS_TIPCOLOR);
    AddConstant('EPDS_TIPWIDTH',EPDS_TIPWIDTH);
    AddConstant('EPDS_TIPNIB',EPDS_TIPNIB);
    AddConstant('EPDS_INKSET',EPDS_INKSET);
    AddConstant('EPDS_EQ',EPDS_EQ);
    AddConstant('EPDS_LT',EPDS_LT);
    AddConstant('EPDS_GT',EPDS_GT);
    AddConstant('EPDS_NOT',EPDS_NOT);
    AddConstant('EPDS_NE',EPDS_NE);
    AddConstant('EPDS_GTE',EPDS_GTE);
    AddConstant('EPDS_LTE',EPDS_LTE);
    AddConstant('EPDS_REMOVE',EPDS_REMOVE);
    AddConstant('GPA_MAXLEN',GPA_MAXLEN);
    AddConstant('GPA_POINTS',GPA_POINTS);
    AddConstant('GPA_PDTS',GPA_PDTS);
    AddConstant('GPA_RATE',GPA_RATE);
    AddConstant('GPA_RECTBOUND',GPA_RECTBOUND);
    AddConstant('GPA_RECTBOUNDINK',GPA_RECTBOUNDINK);
    AddConstant('GPA_SIZE',GPA_SIZE);
    AddConstant('GPA_STROKES',GPA_STROKES);
    AddConstant('GPA_TIME',GPA_TIME);
    AddConstant('GPA_USER',GPA_USER);
    AddConstant('GPA_VERSION',GPA_VERSION);
    AddConstant('GSA_PENTIP',GSA_PENTIP);
    AddConstant('GSA_PENTIPCLASS',GSA_PENTIPCLASS);
    AddConstant('GSA_USER',GSA_USER);
    AddConstant('GSA_USERCLASS',GSA_USERCLASS);
    AddConstant('GSA_TIME',GSA_TIME);
    AddConstant('GSA_SIZE',GSA_SIZE);
    AddConstant('GSA_SELECT',GSA_SELECT);
    AddConstant('GSA_DOWN',GSA_DOWN);
    AddConstant('GSA_RECTBOUND',GSA_RECTBOUND);
    AddConstant('GSA_PENTIPTABLE',GSA_PENTIPTABLE);
    AddConstant('GSA_SIZETABLE',GSA_SIZETABLE);
    AddConstant('GSA_USERTABLE',GSA_USERTABLE);
    AddConstant('IX_END',IX_END);
    AddConstant('PENTIP_NIBDEFAULT',PENTIP_NIBDEFAULT);
    AddConstant('PENTIP_HEIGHTDEFAULT',PENTIP_HEIGHTDEFAULT);
    AddConstant('PENTIP_OPAQUE',PENTIP_OPAQUE);
    AddConstant('PENTIP_HILITE',PENTIP_HILITE);
    AddConstant('PENTIP_TRANSPARENT',PENTIP_TRANSPARENT);
    AddConstant('PDR_NOHIT',PDR_NOHIT);
    AddConstant('PDR_HIT',PDR_HIT);
    AddConstant('PDR_OK',PDR_OK);
    AddConstant('PDR_CANCEL',PDR_CANCEL);
    AddConstant('PDR_ERROR',PDR_ERROR);
    AddConstant('PDR_PNDTERR',PDR_PNDTERR);
    AddConstant('PDR_VERSIONERR',PDR_VERSIONERR);
    AddConstant('PDR_COMPRESSED',PDR_COMPRESSED);
    AddConstant('PDR_STRKINDEXERR',PDR_STRKINDEXERR);
    AddConstant('PDR_PNTINDEXERR',PDR_PNTINDEXERR);
    AddConstant('PDR_MEMERR',PDR_MEMERR);
    AddConstant('PDR_INKSETERR',PDR_INKSETERR);
    AddConstant('PDR_ABORT',PDR_ABORT);
    AddConstant('PDR_NA',PDR_NA);
    AddConstant('PDR_USERDATAERR',PDR_USERDATAERR);
    AddConstant('PDR_SCALINGERR',PDR_SCALINGERR);
    AddConstant('PDR_TIMESTAMPERR',PDR_TIMESTAMPERR);
    AddConstant('PDR_OEMDATAERR',PDR_OEMDATAERR);
    AddConstant('PDR_SCTERR',PDR_SCTERR);
    AddConstant('PDTS_LOMETRIC',PDTS_LOMETRIC);
    AddConstant('PDTS_HIMETRIC',PDTS_HIMETRIC);
    AddConstant('PDTS_HIENGLISH',PDTS_HIENGLISH);
    AddConstant('PDTS_STANDARDSCALE',PDTS_STANDARDSCALE);
    AddConstant('PDTS_DISPLAY',PDTS_DISPLAY);
    AddConstant('PDTS_ARBITRARY',PDTS_ARBITRARY);
    AddConstant('PDTS_SCALEMASK',PDTS_SCALEMASK);
    AddConstant('PDTT_DEFAULT',PDTT_DEFAULT);
    AddConstant('PDTT_PENINFO',PDTT_PENINFO);
    AddConstant('PDTT_UPPOINTS',PDTT_UPPOINTS);
    AddConstant('PDTT_OEMDATA',PDTT_OEMDATA);
    AddConstant('PDTT_COLLINEAR',PDTT_COLLINEAR);
    AddConstant('PDTT_COLINEAR',PDTT_COLINEAR);
    AddConstant('PDTT_DECOMPRESS',PDTT_DECOMPRESS);
    AddConstant('PDTT_COMPRESS',PDTT_COMPRESS);
    AddConstant('PDTT_ALL',PDTT_ALL);
    AddConstant('PHW_NONE',PHW_NONE);
    AddConstant('PHW_PRESSURE',PHW_PRESSURE);
    AddConstant('PHW_HEIGHT',PHW_HEIGHT);
    AddConstant('PHW_ANGLEXY',PHW_ANGLEXY);
    AddConstant('PHW_ANGLEZ',PHW_ANGLEZ);
    AddConstant('PHW_BARRELROTATION',PHW_BARRELROTATION);
    AddConstant('PHW_OEMSPECIFIC',PHW_OEMSPECIFIC);
    AddConstant('PHW_PDK',PHW_PDK);
    AddConstant('PHW_ALL',PHW_ALL);
    AddConstant('PDTS_COMPRESS2NDDERIV',PDTS_COMPRESS2NDDERIV);
    AddConstant('PDTS_COMPRESSMETHOD',PDTS_COMPRESSMETHOD);
    AddConstant('PDTS_NOPENINFO',PDTS_NOPENINFO);
    AddConstant('PDTS_NOUPPOINTS',PDTS_NOUPPOINTS);
    AddConstant('PDTS_NOOEMDATA',PDTS_NOOEMDATA);
    AddConstant('PDTS_NOCOLLINEAR',PDTS_NOCOLLINEAR);
    AddConstant('PDTS_NOCOLINEAR',PDTS_NOCOLINEAR);
    AddConstant('PDTS_NOTICK',PDTS_NOTICK);
    AddConstant('PDTS_NOUSER',PDTS_NOUSER);
    AddConstant('PDTS_NOEMPTYSTROKES',PDTS_NOEMPTYSTROKES);
    AddConstant('PDTS_COMPRESSED',PDTS_COMPRESSED);
    AddConstant('SSA_PENTIP',SSA_PENTIP);
    AddConstant('SSA_PENTIPCLASS',SSA_PENTIPCLASS);
    AddConstant('SSA_USER',SSA_USER);
    AddConstant('SSA_USERCLASS',SSA_USERCLASS);
    AddConstant('SSA_TIME',SSA_TIME);
    AddConstant('SSA_SELECT',SSA_SELECT);
    AddConstant('SSA_DOWN',SSA_DOWN);
    AddConstant('SSA_PENTIPTABLE',SSA_PENTIPTABLE);
    AddConstant('SSA_USERTABLE',SSA_USERTABLE);
    AddConstant('TIP_ERASECOLOR',TIP_ERASECOLOR);
    AddConstant('TPD_RECALCSIZE',TPD_RECALCSIZE);
    AddConstant('TPD_USER',TPD_USER);
    AddConstant('TPD_TIME',TPD_TIME);
    AddConstant('TPD_UPPOINTS',TPD_UPPOINTS);
    AddConstant('TPD_COLLINEAR',TPD_COLLINEAR);
    AddConstant('TPD_COLINEAR',TPD_COLINEAR);
    AddConstant('TPD_PENINFO',TPD_PENINFO);
    AddConstant('TPD_PHW',TPD_PHW);
    AddConstant('TPD_OEMDATA',TPD_OEMDATA);
    AddConstant('TPD_EMPTYSTROKES',TPD_EMPTYSTROKES);
    AddConstant('TPD_EVERYTHING',TPD_EVERYTHING);
    AddConstant('cbDictPathMax',cbDictPathMax);
    AddConstant('DIRQ_QUERY',DIRQ_QUERY);
    AddConstant('DIRQ_DESCRIPTION',DIRQ_DESCRIPTION);
    AddConstant('DIRQ_CONFIGURE',DIRQ_CONFIGURE);
    AddConstant('DIRQ_OPEN',DIRQ_OPEN);
    AddConstant('DIRQ_CLOSE',DIRQ_CLOSE);
    AddConstant('DIRQ_SETWORDLISTS',DIRQ_SETWORDLISTS);
    AddConstant('DIRQ_STRING',DIRQ_STRING);
    AddConstant('DIRQ_SUGGEST',DIRQ_SUGGEST);
    AddConstant('DIRQ_ADD',DIRQ_ADD);
    AddConstant('DIRQ_DELETE',DIRQ_DELETE);
    AddConstant('DIRQ_FLUSH',DIRQ_FLUSH);
    AddConstant('DIRQ_RCCHANGE',DIRQ_RCCHANGE);
    AddConstant('DIRQ_SYMBOLGRAPH',DIRQ_SYMBOLGRAPH);
    AddConstant('DIRQ_INIT',DIRQ_INIT);
    AddConstant('DIRQ_CLEANUP',DIRQ_CLEANUP);
    AddConstant('DIRQ_COPYRIGHT',DIRQ_COPYRIGHT);
    AddConstant('DIRQ_USER',DIRQ_USER);
    AddConstant('BITPENUP',BITPENUP);
    AddConstant('DRV_SetPenDriverEntryPoints',DRV_SetPenDriverEntryPoints);
    AddConstant('DRV_SetEntryPoints',DRV_SetEntryPoints);
    AddConstant('DRV_RemovePenDriverEntryPoints',DRV_RemovePenDriverEntryPoints);
    AddConstant('DRV_RemoveEntryPoints',DRV_RemoveEntryPoints);
    AddConstant('DRV_SetPenSamplingRate',DRV_SetPenSamplingRate);
    AddConstant('DRV_SetPenSamplingDist',DRV_SetPenSamplingDist);
    AddConstant('DRV_GetName',DRV_GetName);
    AddConstant('DRV_GetVersion',DRV_GetVersion);
    AddConstant('DRV_GetPenInfo',DRV_GetPenInfo);
    AddConstant('DRV_PenPlayStart',DRV_PenPlayStart);
    AddConstant('DRV_PenPlayBack',DRV_PenPlayBack);
    AddConstant('DRV_PenPlayStop',DRV_PenPlayStop);
    AddConstant('DRV_GetCalibration',DRV_GetCalibration);
    AddConstant('DRV_SetCalibration',DRV_SetCalibration);
    AddConstant('DRV_Reserved1',DRV_Reserved1);
    AddConstant('DRV_Reserved2',DRV_Reserved2);
    AddConstant('DRV_Query',DRV_Query);
    AddConstant('DRV_GetPenSamplingRate',DRV_GetPenSamplingRate);
    AddConstant('DRV_Calibrate',DRV_Calibrate);
    AddConstant('PLAY_VERSION_10_DATA',PLAY_VERSION_10_DATA);
    AddConstant('PLAY_VERSION_20_DATA',PLAY_VERSION_20_DATA);
    AddConstant('DRV_FAILURE',DRV_FAILURE);
    AddConstant('DRV_SUCCESS',DRV_SUCCESS);
    AddConstant('DRV_BADPARAM1',DRV_BADPARAM1);
    AddConstant('DRV_BADPARAM2',DRV_BADPARAM2);
    AddConstant('DRV_BADSTRUCT',DRV_BADSTRUCT);
    AddConstant('PENREG_DEFAULT',PENREG_DEFAULT);
    AddConstant('PENREG_WILLHANDLEMOUSE',PENREG_WILLHANDLEMOUSE);
    AddConstant('MAXOEMDATAWORDS',MAXOEMDATAWORDS);
    AddConstant('RC_LDEFAULTFLAGS',RC_LDEFAULTFLAGS);
    AddConstant('PCM_PENUP',PCM_PENUP);
    AddConstant('PCM_RANGE',PCM_RANGE);
    AddConstant('PCM_INVERT',PCM_INVERT);
    AddConstant('PCM_RECTEXCLUDE',PCM_RECTEXCLUDE);
    AddConstant('PCM_RECTBOUND',PCM_RECTBOUND);
    AddConstant('PCM_TIMEOUT',PCM_TIMEOUT);
    AddConstant('PCM_RGNBOUND',PCM_RGNBOUND);
    AddConstant('PCM_RGNEXCLUDE',PCM_RGNEXCLUDE);
    AddConstant('PCM_DOPOLLING',PCM_DOPOLLING);
    AddConstant('PCM_TAPNHOLD',PCM_TAPNHOLD);
    AddConstant('PCM_ADDDEFAULTS',PCM_ADDDEFAULTS);
    AddConstant('PDC_INTEGRATED',PDC_INTEGRATED);
    AddConstant('PDC_PROXIMITY',PDC_PROXIMITY);
    AddConstant('PDC_RANGE',PDC_RANGE);
    AddConstant('PDC_INVERT',PDC_INVERT);
    AddConstant('PDC_RELATIVE',PDC_RELATIVE);
    AddConstant('PDC_BARREL1',PDC_BARREL1);
    AddConstant('PDC_BARREL2',PDC_BARREL2);
    AddConstant('PDC_BARREL3',PDC_BARREL3);
    AddConstant('PDK_NULL',PDK_NULL);
    AddConstant('PDK_UP',PDK_UP);
    AddConstant('PDK_DOWN',PDK_DOWN);
    AddConstant('PDK_BARREL1',PDK_BARREL1);
    AddConstant('PDK_BARREL2',PDK_BARREL2);
    AddConstant('PDK_BARREL3',PDK_BARREL3);
    AddConstant('PDK_SWITCHES',PDK_SWITCHES);
    AddConstant('PDK_UNUSED10',PDK_UNUSED10);
    AddConstant('PDK_UNUSED20',PDK_UNUSED20);
    AddConstant('PDK_INVERTED',PDK_INVERTED);
    AddConstant('PDK_PENIDMASK',PDK_PENIDMASK);
    AddConstant('PDK_UNUSED1000',PDK_UNUSED1000);
    AddConstant('PDK_INKSTOPPED',PDK_INKSTOPPED);
    AddConstant('PDK_OUTOFRANGE',PDK_OUTOFRANGE);
    AddConstant('PDK_DRIVER',PDK_DRIVER);
    AddConstant('PDK_TIPMASK',PDK_TIPMASK);
    AddConstant('PDT_NULL',PDT_NULL);
    AddConstant('PDT_PRESSURE',PDT_PRESSURE);
    AddConstant('PDT_HEIGHT',PDT_HEIGHT);
    AddConstant('PDT_ANGLEXY',PDT_ANGLEXY);
    AddConstant('PDT_ANGLEZ',PDT_ANGLEZ);
    AddConstant('PDT_BARRELROTATION',PDT_BARRELROTATION);
    AddConstant('PDT_OEMSPECIFIC',PDT_OEMSPECIFIC);
    AddConstant('PID_CURRENT',PID_CURRENT);
    AddConstant('GRH_ALL',GRH_ALL);
    AddConstant('GRH_GESTURE',GRH_GESTURE);
    AddConstant('GRH_NONGESTURE',GRH_NONGESTURE);
    AddConstant('GST_SEL',GST_SEL);
    AddConstant('GST_CLIP',GST_CLIP);
    AddConstant('GST_WHITE',GST_WHITE);
    AddConstant('GST_KKCONVERT',GST_KKCONVERT);
    AddConstant('GST_EDIT',GST_EDIT);
    AddConstant('GST_SYS',GST_SYS);
    AddConstant('GST_CIRCLELO',GST_CIRCLELO);
    AddConstant('GST_CIRCLEUP',GST_CIRCLEUP);
    AddConstant('GST_CIRCLE',GST_CIRCLE);
    AddConstant('GST_ALL',GST_ALL);
    AddConstant('HRCR_NORESULTS',HRCR_NORESULTS);
    AddConstant('HRCR_COMPLETE',HRCR_COMPLETE);
    AddConstant('HRCR_GESTURE',HRCR_GESTURE);
    AddConstant('HRCR_OK',HRCR_OK);
    AddConstant('HRCR_INCOMPLETE',HRCR_INCOMPLETE);
    AddConstant('HRCR_ERROR',HRCR_ERROR);
    AddConstant('HRCR_MEMERR',HRCR_MEMERR);
    AddConstant('HRCR_INVALIDGUIDE',HRCR_INVALIDGUIDE);
    AddConstant('HRCR_INVALIDPNDT',HRCR_INVALIDPNDT);
    AddConstant('HRCR_UNSUPPORTED',HRCR_UNSUPPORTED);
    AddConstant('HRCR_CONFLICT',HRCR_CONFLICT);
    AddConstant('HRCR_HOOKED',HRCR_HOOKED);
    AddConstant('HWL_SYSTEM',HWL_SYSTEM);
    AddConstant('ISR_ERROR',ISR_ERROR);
    AddConstant('ISR_BADINKSET',ISR_BADINKSET);
    AddConstant('ISR_BADINDEX',ISR_BADINDEX);
    AddConstant('MAXHOTSPOT',MAXHOTSPOT);
    AddConstant('PH_MAX',PH_MAX);
    AddConstant('PH_DEFAULT',PH_DEFAULT);
    AddConstant('PH_MIN',PH_MIN);
    AddConstant('RHH_STD',RHH_STD);
    AddConstant('RHH_BOX',RHH_BOX);
    AddConstant('SCH_NONE',SCH_NONE);
    AddConstant('SCH_ADVISE',SCH_ADVISE);
    AddConstant('SCH_FORCE',SCH_FORCE);
    AddConstant('SCIM_INSERT',SCIM_INSERT);
    AddConstant('SCIM_OVERWRITE',SCIM_OVERWRITE);
    AddConstant('SRH_HOOKALL',SRH_HOOKALL);
    AddConstant('SSH_RD',SSH_RD);
    AddConstant('SSH_RU',SSH_RU);
    AddConstant('SSH_LD',SSH_LD);
    AddConstant('SSH_LU',SSH_LU);
    AddConstant('SSH_DL',SSH_DL);
    AddConstant('SSH_DR',SSH_DR);
    AddConstant('SSH_UL',SSH_UL);
    AddConstant('SSH_UR',SSH_UR);
    AddConstant('SIH_ALLANSICHAR',SIH_ALLANSICHAR);
    AddConstant('TH_QUERY',TH_QUERY);
    AddConstant('TH_FORCE',TH_FORCE);
    AddConstant('TH_SUGGEST',TH_SUGGEST);
    AddConstant('TRAIN_NONE',TRAIN_NONE);
    AddConstant('TRAIN_DEFAULT',TRAIN_DEFAULT);
    AddConstant('TRAIN_CUSTOM',TRAIN_CUSTOM);
    AddConstant('TRAIN_BOTH',TRAIN_BOTH);
    AddConstant('TRAIN_SAVE',TRAIN_SAVE);
    AddConstant('TRAIN_REVERT',TRAIN_REVERT);
    AddConstant('TRAIN_RESET',TRAIN_RESET);
    AddConstant('WCR_RECOGNAME',WCR_RECOGNAME);
    AddConstant('WCR_QUERY',WCR_QUERY);
    AddConstant('WCR_CONFIGDIALOG',WCR_CONFIGDIALOG);
    AddConstant('WCR_DEFAULT',WCR_DEFAULT);
    AddConstant('WCR_RCCHANGE',WCR_RCCHANGE);
    AddConstant('WCR_VERSION',WCR_VERSION);
    AddConstant('WCR_TRAIN',WCR_TRAIN);
    AddConstant('WCR_TRAINSAVE',WCR_TRAINSAVE);
    AddConstant('WCR_TRAINMAX',WCR_TRAINMAX);
    AddConstant('WCR_TRAINDIRTY',WCR_TRAINDIRTY);
    AddConstant('WCR_TRAINCUSTOM',WCR_TRAINCUSTOM);
    AddConstant('WCR_QUERYLANGUAGE',WCR_QUERYLANGUAGE);
    AddConstant('WCR_USERCHANGE',WCR_USERCHANGE);
    AddConstant('WCR_PWVERSION',WCR_PWVERSION);
    AddConstant('WCR_GETALCPRIORITY',WCR_GETALCPRIORITY);
    AddConstant('WCR_SETALCPRIORITY',WCR_SETALCPRIORITY);
    AddConstant('WCR_GETANSISTATE',WCR_GETANSISTATE);
    AddConstant('WCR_SETANSISTATE',WCR_SETANSISTATE);
    AddConstant('WCR_GETHAND',WCR_GETHAND);
    AddConstant('WCR_SETHAND',WCR_SETHAND);
    AddConstant('WCR_GETDIRECTION',WCR_GETDIRECTION);
    AddConstant('WCR_SETDIRECTION',WCR_SETDIRECTION);
    AddConstant('WCR_INITRECOGNIZER',WCR_INITRECOGNIZER);
    AddConstant('WCR_CLOSERECOGNIZER',WCR_CLOSERECOGNIZER);
    AddConstant('WCR_PRIVATE',WCR_PRIVATE);
    AddConstant('CRUC_NOTIFY',CRUC_NOTIFY);
    AddConstant('CRUC_REMOVE',CRUC_REMOVE);
    AddConstant('WLT_STRING',WLT_STRING);
    AddConstant('WLT_STRINGTABLE',WLT_STRINGTABLE);
    AddConstant('WLT_EMPTY',WLT_EMPTY);
    AddConstant('WLT_WORDLIST',WLT_WORDLIST);
    AddConstant('IEB_DEFAULT',IEB_DEFAULT);
    AddConstant('IEB_BRUSH',IEB_BRUSH);
    AddConstant('IEB_BIT_UL',IEB_BIT_UL);
    AddConstant('IEB_BIT_CENTER',IEB_BIT_CENTER);
    AddConstant('IEB_BIT_TILE',IEB_BIT_TILE);
    AddConstant('IEB_BIT_STRETCH',IEB_BIT_STRETCH);
    AddConstant('IEB_OWNERDRAW',IEB_OWNERDRAW);
    AddConstant('IEDO_NONE',IEDO_NONE);
    AddConstant('IEDO_FAST',IEDO_FAST);
    AddConstant('IEDO_SAVEUPSTROKES',IEDO_SAVEUPSTROKES);
    AddConstant('IEDO_RESERVED',IEDO_RESERVED);
    AddConstant('IEI_MOVE',IEI_MOVE);
    AddConstant('IEI_RESIZE',IEI_RESIZE);
    AddConstant('IEI_CROP',IEI_CROP);
    AddConstant('IEI_DISCARD',IEI_DISCARD);
    AddConstant('IEI_RESERVED',IEI_RESERVED);
    AddConstant('IEGI_ALL',IEGI_ALL);
    AddConstant('IEGI_SELECTION',IEGI_SELECTION);
    AddConstant('IEMODE_READY',IEMODE_READY);
    AddConstant('IEMODE_ERASE',IEMODE_ERASE);
    AddConstant('IEMODE_LASSO',IEMODE_LASSO);
    AddConstant('IEN_NULL',IEN_NULL);
    AddConstant('IEN_PDEVENT',IEN_PDEVENT);
    AddConstant('IEN_PAINT',IEN_PAINT);
    AddConstant('IEN_FOCUS',IEN_FOCUS);
    AddConstant('IEN_SCROLL',IEN_SCROLL);
    AddConstant('IEN_EDIT',IEN_EDIT);
    AddConstant('IEN_PROPERTIES',IEN_PROPERTIES);
    AddConstant('IEN_RESERVED',IEN_RESERVED);
    AddConstant('IER_OK',IER_OK);
    AddConstant('IER_NO',IER_NO);
    AddConstant('IER_YES',IER_YES);
    AddConstant('IER_ERROR',IER_ERROR);
    AddConstant('IER_PARAMERR',IER_PARAMERR);
    AddConstant('IER_OWNERDRAW',IER_OWNERDRAW);
    AddConstant('IER_SECURITY',IER_SECURITY);
    AddConstant('IER_SELECTION',IER_SELECTION);
    AddConstant('IER_SCALE',IER_SCALE);
    AddConstant('IER_MEMERR',IER_MEMERR);
    AddConstant('IER_NOCOMMAND',IER_NOCOMMAND);
    AddConstant('IER_NOGESTURE',IER_NOGESTURE);
    AddConstant('IER_NOPDEVENT',IER_NOPDEVENT);
    AddConstant('IER_NOTINPAINT',IER_NOTINPAINT);
    AddConstant('IER_PENDATA',IER_PENDATA);
    AddConstant('IEREC_NONE',IEREC_NONE);
    AddConstant('IEREC_GESTURE',IEREC_GESTURE);
    AddConstant('IEREC_RESERVED',IEREC_RESERVED);
    AddConstant('IESEC_NOCOPY',IESEC_NOCOPY);
    AddConstant('IESEC_NOCUT',IESEC_NOCUT);
    AddConstant('IESEC_NOPASTE',IESEC_NOPASTE);
    AddConstant('IESEC_NOUNDO',IESEC_NOUNDO);
    AddConstant('IESEC_NOINK',IESEC_NOINK);
    AddConstant('IESEC_NOERASE',IESEC_NOERASE);
    AddConstant('IESEC_NOGET',IESEC_NOGET);
    AddConstant('IESEC_NOSET',IESEC_NOSET);
    AddConstant('IESEC_RESERVED',IESEC_RESERVED);
    AddConstant('IESF_ALL',IESF_ALL);
    AddConstant('IESF_SELECTION',IESF_SELECTION);
    AddConstant('IESF_STROKE',IESF_STROKE);
    AddConstant('IESF_TIPCOLOR',IESF_TIPCOLOR);
    AddConstant('IESF_TIPWIDTH',IESF_TIPWIDTH);
    AddConstant('IESF_PENTIP',IESF_PENTIP);
    AddConstant('IESI_REPLACE',IESI_REPLACE);
    AddConstant('IESI_APPEND',IESI_APPEND);
    AddConstant('IN_PDEVENT',IN_PDEVENT);
    AddConstant('IN_ERASEBKGND',IN_ERASEBKGND);
    AddConstant('IN_PREPAINT',IN_PREPAINT);
    AddConstant('IN_PAINT',IN_PAINT);
    AddConstant('IN_POSTPAINT',IN_POSTPAINT);
    AddConstant('IN_MODECHANGED',IN_MODECHANGED);
    AddConstant('IN_CHANGE',IN_CHANGE);
    AddConstant('IN_UPDATE',IN_UPDATE);
    AddConstant('IN_SETFOCUS',IN_SETFOCUS);
    AddConstant('IN_KILLFOCUS',IN_KILLFOCUS);
    AddConstant('IN_MEMERR',IN_MEMERR);
    AddConstant('IN_HSCROLL',IN_HSCROLL);
    AddConstant('IN_VSCROLL',IN_VSCROLL);
    AddConstant('IN_GESTURE',IN_GESTURE);
    AddConstant('IN_COMMAND',IN_COMMAND);
    AddConstant('IN_CLOSE',IN_CLOSE);
    AddConstant('IN_PROPERTIES',IN_PROPERTIES);
    AddConstant('LRET_DONE',LRET_DONE);
    AddConstant('LRET_ABORT',LRET_ABORT);
    AddConstant('LRET_HRC',LRET_HRC);
    AddConstant('LRET_HPENDATA',LRET_HPENDATA);
    AddConstant('LRET_PRIVATE',LRET_PRIVATE);
    AddConstant('PCMR_OK',PCMR_OK);
    AddConstant('PCMR_ALREADYCOLLECTING',PCMR_ALREADYCOLLECTING);
    AddConstant('PCMR_INVALIDCOLLECTION',PCMR_INVALIDCOLLECTION);
    AddConstant('PCMR_EVENTLOCK',PCMR_EVENTLOCK);
    AddConstant('PCMR_INVALID_PACKETID',PCMR_INVALID_PACKETID);
    AddConstant('PCMR_TERMTIMEOUT',PCMR_TERMTIMEOUT);
    AddConstant('PCMR_TERMRANGE',PCMR_TERMRANGE);
    AddConstant('PCMR_TERMPENUP',PCMR_TERMPENUP);
    AddConstant('PCMR_TERMEX',PCMR_TERMEX);
    AddConstant('PCMR_TERMBOUND',PCMR_TERMBOUND);
    AddConstant('PCMR_APPTERMINATED',PCMR_APPTERMINATED);
    AddConstant('PCMR_TAP',PCMR_TAP);
    AddConstant('PCMR_SELECT',PCMR_SELECT);
    AddConstant('PCMR_OVERFLOW',PCMR_OVERFLOW);
    AddConstant('PCMR_ERROR',PCMR_ERROR);
    AddConstant('PCMR_DISPLAYERR',PCMR_DISPLAYERR);
    AddConstant('PCMR_TERMINVERT',PCMR_TERMINVERT);
    AddConstant('PII_INKCLIPRECT',PII_INKCLIPRECT);
    AddConstant('PII_INKSTOPRECT',PII_INKSTOPRECT);
    AddConstant('PII_INKCLIPRGN',PII_INKCLIPRGN);
    AddConstant('PII_INKSTOPRGN',PII_INKSTOPRGN);
    AddConstant('PII_INKPENTIP',PII_INKPENTIP);
    AddConstant('PII_SAVEBACKGROUND',PII_SAVEBACKGROUND);
    AddConstant('PII_CLIPSTOP',PII_CLIPSTOP);
    AddConstant('PIT_RGNBOUND',PIT_RGNBOUND);
    AddConstant('PIT_RGNEXCLUDE',PIT_RGNEXCLUDE);
    AddConstant('PIT_TIMEOUT',PIT_TIMEOUT);
    AddConstant('PIT_TAPNHOLD',PIT_TAPNHOLD);
    AddConstant('CL_NULL',CL_NULL);
    AddConstant('CL_MINIMUM',CL_MINIMUM);
    AddConstant('CL_MAXIMUM',CL_MAXIMUM);
    AddConstant('cwRcReservedMax',cwRcReservedMax);
    AddConstant('ENUM_MINIMUM',ENUM_MINIMUM);
    AddConstant('ENUM_MAXIMUM',ENUM_MAXIMUM);
    AddConstant('HKP_SETHOOK',HKP_SETHOOK);
    AddConstant('HKP_UNHOOK',HKP_UNHOOK);
    AddConstant('HWR_RESULTS',HWR_RESULTS);
    AddConstant('HWR_APPWIDE',HWR_APPWIDE);
    AddConstant('iSycNull',iSycNull);
    AddConstant('LPDFNULL',LPDFNULL);
    AddConstant('MAXDICTIONARIES',MAXDICTIONARIES);
    AddConstant('wPntAll',wPntAll);
    AddConstant('cbRcLanguageMax',cbRcLanguageMax);
    AddConstant('cbRcUserMax',cbRcUserMax);
    AddConstant('cbRcrgbfAlcMax',cbRcrgbfAlcMax);
    AddConstant('RC_WDEFAULT',RC_WDEFAULT);
    AddConstant('RC_LDEFAULT',RC_LDEFAULT);
    AddConstant('RC_WDEFAULTFLAGS',RC_WDEFAULTFLAGS);
    AddConstant('CWR_REPLACECR',CWR_REPLACECR);
    AddConstant('CWR_STRIPCR',CWR_STRIPCR);
    AddConstant('CWR_STRIPLF',CWR_STRIPLF);
    AddConstant('CWR_REPLACETAB',CWR_REPLACETAB);
    AddConstant('CWR_STRIPTAB',CWR_STRIPTAB);
    AddConstant('CWR_SINGLELINEEDIT',CWR_SINGLELINEEDIT);
    AddConstant('CWR_INSERT',CWR_INSERT);
    AddConstant('CWR_TITLE',CWR_TITLE);
    AddConstant('CWR_KKCONVERT',CWR_KKCONVERT);
    AddConstant('CWR_SIMPLE',CWR_SIMPLE);
    AddConstant('CWR_HEDIT',CWR_HEDIT);
    AddConstant('CWR_KEYBOARD',CWR_KEYBOARD);
    AddConstant('CWR_BOXES',CWR_BOXES);
    AddConstant('CWRK_DEFAULT',CWRK_DEFAULT);
    AddConstant('CWRK_BASIC',CWRK_BASIC);
    AddConstant('CWRK_FULL',CWRK_FULL);
    AddConstant('CWRK_NUMPAD',CWRK_NUMPAD);
    AddConstant('CWRK_TELPAD',CWRK_TELPAD);
    AddConstant('GPMI_OK',GPMI_OK);
    AddConstant('GPMI_INVALIDPMI',GPMI_INVALIDPMI);
    AddConstant('INKWIDTH_MINIMUM',INKWIDTH_MINIMUM);
    AddConstant('INKWIDTH_MAXIMUM',INKWIDTH_MAXIMUM);
    AddConstant('PMI_RCCHANGE',PMI_RCCHANGE);
    AddConstant('PMI_BEDIT',PMI_BEDIT);
    AddConstant('PMI_IMECOLOR',PMI_IMECOLOR);
    AddConstant('PMI_CXTABLET',PMI_CXTABLET);
    AddConstant('PMI_CYTABLET',PMI_CYTABLET);
    AddConstant('PMI_PENTIP',PMI_PENTIP);
    AddConstant('PMI_ENABLEFLAGS',PMI_ENABLEFLAGS);
    AddConstant('PMI_TIMEOUT',PMI_TIMEOUT);
    AddConstant('PMI_TIMEOUTGEST',PMI_TIMEOUTGEST);
    AddConstant('PMI_TIMEOUTSEL',PMI_TIMEOUTSEL);
    AddConstant('PMI_SYSFLAGS',PMI_SYSFLAGS);
    AddConstant('PMI_INDEXFROMRGB',PMI_INDEXFROMRGB);
    AddConstant('PMI_RGBFROMINDEX',PMI_RGBFROMINDEX);
    AddConstant('PMI_SYSREC',PMI_SYSREC);
    AddConstant('PMI_TICKREF',PMI_TICKREF);
    AddConstant('PMI_SAVE',PMI_SAVE);
    AddConstant('PWE_AUTOWRITE',PWE_AUTOWRITE);
    AddConstant('PWE_ACTIONHANDLES',PWE_ACTIONHANDLES);
    AddConstant('PWE_INPUTCURSOR',PWE_INPUTCURSOR);
    AddConstant('PWE_LENS',PWE_LENS);
    AddConstant('PWF_RC1',PWF_RC1);
    AddConstant('PWF_PEN',PWF_PEN);
    AddConstant('PWF_INKDISPLAY',PWF_INKDISPLAY);
    AddConstant('PWF_RECOGNIZER',PWF_RECOGNIZER);
    AddConstant('PWF_BEDIT',PWF_BEDIT);
    AddConstant('PWF_HEDIT',PWF_HEDIT);
    AddConstant('PWF_IEDIT',PWF_IEDIT);
    AddConstant('PWF_ENHANCED',PWF_ENHANCED);
    AddConstant('PWF_FULL',PWF_FULL);
    AddConstant('RPA_DEFAULT',RPA_DEFAULT);
    AddConstant('RPA_HEDIT',RPA_HEDIT);
    AddConstant('RPA_KANJIFIXEDBEDIT',RPA_KANJIFIXEDBEDIT);
    AddConstant('RPA_DBCSPRIORITY',RPA_DBCSPRIORITY);
    AddConstant('PMIR_OK',PMIR_OK);
    AddConstant('PMIR_INDEX',PMIR_INDEX);
    AddConstant('PMIR_VALUE',PMIR_VALUE);
    AddConstant('PMIR_INVALIDBOXEDITINFO',PMIR_INVALIDBOXEDITINFO);
    AddConstant('PMIR_INIERROR',PMIR_INIERROR);
    AddConstant('PMIR_ERROR',PMIR_ERROR);
    AddConstant('PMIR_NA',PMIR_NA);
    AddConstant('SPMI_OK',SPMI_OK);
    AddConstant('SPMI_INVALIDBOXEDITINFO',SPMI_INVALIDBOXEDITINFO);
    AddConstant('SPMI_INIERROR',SPMI_INIERROR);
    AddConstant('SPMI_INVALIDPMI',SPMI_INVALIDPMI);
    AddConstant('RCD_DEFAULT',RCD_DEFAULT);
    AddConstant('RCD_LR',RCD_LR);
    AddConstant('RCD_RL',RCD_RL);
    AddConstant('RCD_TB',RCD_TB);
    AddConstant('RCD_BT',RCD_BT);
    AddConstant('RCIP_ALLANSICHAR',RCIP_ALLANSICHAR);
    AddConstant('RCIP_MASK',RCIP_MASK);
    AddConstant('RCO_NOPOINTEREVENT',RCO_NOPOINTEREVENT);
    AddConstant('RCO_SAVEALLDATA',RCO_SAVEALLDATA);
    AddConstant('RCO_SAVEHPENDATA',RCO_SAVEHPENDATA);
    AddConstant('RCO_NOFLASHUNKNOWN',RCO_NOFLASHUNKNOWN);
    AddConstant('RCO_TABLETCOORD',RCO_TABLETCOORD);
    AddConstant('RCO_NOSPACEBREAK',RCO_NOSPACEBREAK);
    AddConstant('RCO_NOHIDECURSOR',RCO_NOHIDECURSOR);
    AddConstant('RCO_NOHOOK',RCO_NOHOOK);
    AddConstant('RCO_BOXED',RCO_BOXED);
    AddConstant('RCO_SUGGEST',RCO_SUGGEST);
    AddConstant('RCO_DISABLEGESMAP',RCO_DISABLEGESMAP);
    AddConstant('RCO_NOFLASHCURSOR',RCO_NOFLASHCURSOR);
    AddConstant('RCO_BOXCROSS',RCO_BOXCROSS);
    AddConstant('RCO_COLDRECOG',RCO_COLDRECOG);
    AddConstant('RCO_SAVEBACKGROUND',RCO_SAVEBACKGROUND);
    AddConstant('RCO_DODEFAULT',RCO_DODEFAULT);
    AddConstant('RCOR_NORMAL',RCOR_NORMAL);
    AddConstant('RCOR_RIGHT',RCOR_RIGHT);
    AddConstant('RCOR_UPSIDEDOWN',RCOR_UPSIDEDOWN);
    AddConstant('RCOR_LEFT',RCOR_LEFT);
    AddConstant('RCP_LEFTHAND',RCP_LEFTHAND);
    AddConstant('RCP_MAPCHAR',RCP_MAPCHAR);
    AddConstant('RCRT_DEFAULT',RCRT_DEFAULT);
    AddConstant('RCRT_UNIDENTIFIED',RCRT_UNIDENTIFIED);
    AddConstant('RCRT_GESTURE',RCRT_GESTURE);
    AddConstant('RCRT_NOSYMBOLMATCH',RCRT_NOSYMBOLMATCH);
    AddConstant('RCRT_PRIVATE',RCRT_PRIVATE);
    AddConstant('RCRT_NORECOG',RCRT_NORECOG);
    AddConstant('RCRT_ALREADYPROCESSED',RCRT_ALREADYPROCESSED);
    AddConstant('RCRT_GESTURETRANSLATED',RCRT_GESTURETRANSLATED);
    AddConstant('RCRT_GESTURETOKEYS',RCRT_GESTURETOKEYS);
    AddConstant('RRM_STROKE',RRM_STROKE);
    AddConstant('RRM_SYMBOL',RRM_SYMBOL);
    AddConstant('RRM_WORD',RRM_WORD);
    AddConstant('RRM_NEWLINE',RRM_NEWLINE);
    AddConstant('RRM_COMPLETE',RRM_COMPLETE);
    AddConstant('TPT_CLOSEST',TPT_CLOSEST);
    AddConstant('TPT_INTERSECTINK',TPT_INTERSECTINK);
    AddConstant('TPT_TEXTUAL',TPT_TEXTUAL);
    AddConstant('TPT_DEFAULT',TPT_DEFAULT);
    AddConstant('VWM_MOUSEMOVE',VWM_MOUSEMOVE);
    AddConstant('VWM_MOUSELEFTDOWN',VWM_MOUSELEFTDOWN);
    AddConstant('VWM_MOUSELEFTUP',VWM_MOUSELEFTUP);
    AddConstant('VWM_MOUSERIGHTDOWN',VWM_MOUSERIGHTDOWN);
    AddConstant('VWM_MOUSERIGHTUP',VWM_MOUSERIGHTUP);
    AddConstant('WM_RCRESULT',WM_RCRESULT);
    AddConstant('WM_HOOKRCRESULT',WM_HOOKRCRESULT);
    AddConstant('WM_PENMISCINFO',WM_PENMISCINFO);
    AddConstant('WM_GLOBALRCCHANGE',WM_GLOBALRCCHANGE);
    AddConstant('WM_SKB',WM_SKB);
    AddConstant('WM_PENCTL',WM_PENCTL);
    AddConstant('WM_HEDITCTL',WM_HEDITCTL);
    AddConstant('HE_GETRC',HE_GETRC);
    AddConstant('HE_SETRC',HE_SETRC);
    AddConstant('HE_GETINFLATE',HE_GETINFLATE);
    AddConstant('HE_SETINFLATE',HE_SETINFLATE);
    AddConstant('HE_GETUNDERLINE',HE_GETUNDERLINE);
    AddConstant('HE_SETUNDERLINE',HE_SETUNDERLINE);
    AddConstant('HE_GETINKHANDLE',HE_GETINKHANDLE);
    AddConstant('HE_SETINKMODE',HE_SETINKMODE);
    AddConstant('HE_STOPINKMODE',HE_STOPINKMODE);
    AddConstant('HE_GETRCRESULTCODE',HE_GETRCRESULTCODE);
    AddConstant('HE_DEFAULTFONT',HE_DEFAULTFONT);
    AddConstant('HE_CHARPOSITION',HE_CHARPOSITION);
    AddConstant('HE_CHAROFFSET',HE_CHAROFFSET);
    AddConstant('HE_GETBOXLAYOUT',HE_GETBOXLAYOUT);
    AddConstant('HE_SETBOXLAYOUT',HE_SETBOXLAYOUT);
    AddConstant('HE_GETRCRESULT',HE_GETRCRESULT);
    AddConstant('HE_KKCONVERT',HE_KKCONVERT);
    AddConstant('HE_GETKKCONVERT',HE_GETKKCONVERT);
    AddConstant('HE_CANCELKKCONVERT',HE_CANCELKKCONVERT);
    AddConstant('HE_FIXKKCONVERT',HE_FIXKKCONVERT);
    AddConstant('HE_GETKKSTATUS',HE_GETKKSTATUS);
    AddConstant('HE_KKNOCONVERT',HE_KKNOCONVERT);
    AddConstant('HE_SETIMEDEFAULT',HE_SETIMEDEFAULT);
    AddConstant('HE_GETIMEDEFAULT',HE_GETIMEDEFAULT);
    AddConstant('HE_ENABLEALTLIST',HE_ENABLEALTLIST);
    AddConstant('HE_SHOWALTLIST',HE_SHOWALTLIST);
    AddConstant('HE_HIDEALTLIST',HE_HIDEALTLIST);
    AddConstant('HE_GETLENSTYPE',HE_GETLENSTYPE);
    AddConstant('HE_SETLENSTYPE',HE_SETLENSTYPE);
    AddConstant('HEKK_DEFAULT',HEKK_DEFAULT);
    AddConstant('HEKK_CONVERT',HEKK_CONVERT);
    AddConstant('HEKK_CANDIDATE',HEKK_CANDIDATE);
    AddConstant('HEKK_DBCSCHAR',HEKK_DBCSCHAR);
    AddConstant('HEKK_SBCSCHAR',HEKK_SBCSCHAR);
    AddConstant('HEKK_HIRAGANA',HEKK_HIRAGANA);
    AddConstant('HEKK_KATAKANA',HEKK_KATAKANA);
    AddConstant('HEKKR_PRECONVERT',HEKKR_PRECONVERT);
    AddConstant('HEKKR_CONVERT',HEKKR_CONVERT);
    AddConstant('HEKKR_TEMPCONFIRM',HEKKR_TEMPCONFIRM);
    AddConstant('HEP_NORECOG',HEP_NORECOG);
    AddConstant('HEP_RECOG',HEP_RECOG);
    AddConstant('HEP_WAITFORTAP',HEP_WAITFORTAP);
    AddConstant('HN_ENDREC',HN_ENDREC);
    AddConstant('HN_DELAYEDRECOGFAIL',HN_DELAYEDRECOGFAIL);
    AddConstant('HN_RESULT',HN_RESULT);
    AddConstant('HN_RCRESULT',HN_RCRESULT);
    AddConstant('HN_ENDKKCONVERT',HN_ENDKKCONVERT);
    AddConstant('HN_BEGINDIALOG',HN_BEGINDIALOG);
    AddConstant('HN_ENDDIALOG',HN_ENDDIALOG);
    AddConstant('IE_GETMODIFY',IE_GETMODIFY);
    AddConstant('IE_SETMODIFY',IE_SETMODIFY);
    AddConstant('IE_CANUNDO',IE_CANUNDO);
    AddConstant('IE_UNDO',IE_UNDO);
    AddConstant('IE_EMPTYUNDOBUFFER',IE_EMPTYUNDOBUFFER);
    AddConstant('IE_MSGFIRST',IE_MSGFIRST);
    AddConstant('IE_GETINK',IE_GETINK);
    AddConstant('IE_SETINK',IE_SETINK);
    AddConstant('IE_GETPENTIP',IE_GETPENTIP);
    AddConstant('IE_SETPENTIP',IE_SETPENTIP);
    AddConstant('IE_GETERASERTIP',IE_GETERASERTIP);
    AddConstant('IE_SETERASERTIP',IE_SETERASERTIP);
    AddConstant('IE_GETBKGND',IE_GETBKGND);
    AddConstant('IE_SETBKGND',IE_SETBKGND);
    AddConstant('IE_GETGRIDORIGIN',IE_GETGRIDORIGIN);
    AddConstant('IE_SETGRIDORIGIN',IE_SETGRIDORIGIN);
    AddConstant('IE_GETGRIDPEN',IE_GETGRIDPEN);
    AddConstant('IE_SETGRIDPEN',IE_SETGRIDPEN);
    AddConstant('IE_GETGRIDSIZE',IE_GETGRIDSIZE);
    AddConstant('IE_SETGRIDSIZE',IE_SETGRIDSIZE);
    AddConstant('IE_GETMODE',IE_GETMODE);
    AddConstant('IE_SETMODE',IE_SETMODE);
    AddConstant('IE_GETINKRECT',IE_GETINKRECT);
    AddConstant('IE_GETAPPDATA',IE_GETAPPDATA);
    AddConstant('IE_SETAPPDATA',IE_SETAPPDATA);
    AddConstant('IE_GETDRAWOPTS',IE_GETDRAWOPTS);
    AddConstant('IE_SETDRAWOPTS',IE_SETDRAWOPTS);
    AddConstant('IE_GETFORMAT',IE_GETFORMAT);
    AddConstant('IE_SETFORMAT',IE_SETFORMAT);
    AddConstant('IE_GETINKINPUT',IE_GETINKINPUT);
    AddConstant('IE_SETINKINPUT',IE_SETINKINPUT);
    AddConstant('IE_GETNOTIFY',IE_GETNOTIFY);
    AddConstant('IE_SETNOTIFY',IE_SETNOTIFY);
    AddConstant('IE_GETRECOG',IE_GETRECOG);
    AddConstant('IE_SETRECOG',IE_SETRECOG);
    AddConstant('IE_GETSECURITY',IE_GETSECURITY);
    AddConstant('IE_SETSECURITY',IE_SETSECURITY);
    AddConstant('IE_GETSEL',IE_GETSEL);
    AddConstant('IE_SETSEL',IE_SETSEL);
    AddConstant('IE_DOCOMMAND',IE_DOCOMMAND);
    AddConstant('IE_GETCOMMAND',IE_GETCOMMAND);
    AddConstant('IE_GETCOUNT',IE_GETCOUNT);
    AddConstant('IE_GETGESTURE',IE_GETGESTURE);
    AddConstant('IE_GETMENU',IE_GETMENU);
    AddConstant('IE_GETPAINTDC',IE_GETPAINTDC);
    AddConstant('IE_GETPDEVENT',IE_GETPDEVENT);
    AddConstant('IE_GETSELCOUNT',IE_GETSELCOUNT);
    AddConstant('IE_GETSELITEMS',IE_GETSELITEMS);
    AddConstant('IE_GETSTYLE',IE_GETSTYLE);
    AddConstant('CIH_NOGDMSG',CIH_NOGDMSG);
    AddConstant('CIH_NOACTIONHANDLE',CIH_NOACTIONHANDLE);
    AddConstant('CIH_NOEDITTEXT',CIH_NOEDITTEXT);
    AddConstant('CIH_NOFLASHCURSOR',CIH_NOFLASHCURSOR);
    AddConstant('HEAL_DEFAULT',HEAL_DEFAULT);
    AddConstant('BEI_FACESIZE',BEI_FACESIZE);
    AddConstant('BEIF_BOXCROSS',BEIF_BOXCROSS);
    AddConstant('BESC_DEFAULT',BESC_DEFAULT);
    AddConstant('BESC_ROMANFIXED',BESC_ROMANFIXED);
    AddConstant('BESC_KANJIFIXED',BESC_KANJIFIXED);
    AddConstant('BESC_USERDEFINED',BESC_USERDEFINED);
    AddConstant('CIB_NOGDMSG',CIB_NOGDMSG);
    AddConstant('CIB_NOACTIONHANDLE',CIB_NOACTIONHANDLE);
    AddConstant('CIB_NOFLASHCURSOR',CIB_NOFLASHCURSOR);
    AddConstant('CIB_NOWRITING',CIB_NOWRITING);
    AddConstant('BXD_CELLWIDTH',BXD_CELLWIDTH);
    AddConstant('BXD_CELLHEIGHT',BXD_CELLHEIGHT);
    AddConstant('BXD_BASEHEIGHT',BXD_BASEHEIGHT);
    AddConstant('BXD_BASEHORZ',BXD_BASEHORZ);
    AddConstant('BXD_MIDFROMBASE',BXD_MIDFROMBASE);
    AddConstant('BXD_CUSPHEIGHT',BXD_CUSPHEIGHT);
    AddConstant('BXD_ENDCUSPHEIGHT',BXD_ENDCUSPHEIGHT);
    AddConstant('BXDK_CELLWIDTH',BXDK_CELLWIDTH);
    AddConstant('BXDK_CELLHEIGHT',BXDK_CELLHEIGHT);
    AddConstant('BXDK_BASEHEIGHT',BXDK_BASEHEIGHT);
    AddConstant('BXDK_BASEHORZ',BXDK_BASEHORZ);
    AddConstant('BXDK_MIDFROMBASE',BXDK_MIDFROMBASE);
    AddConstant('BXDK_CUSPHEIGHT',BXDK_CUSPHEIGHT);
    AddConstant('BXDK_ENDCUSPHEIGHT',BXDK_ENDCUSPHEIGHT);
    AddConstant('COLOR_BE_INPUT',COLOR_BE_INPUT);
    AddConstant('COLOR_BE_INPUT_TEXT',COLOR_BE_INPUT_TEXT);
    AddConstant('COLOR_BE_CONVERT',COLOR_BE_CONVERT);
    AddConstant('COLOR_BE_CONVERT_TEXT',COLOR_BE_CONVERT_TEXT);
    AddConstant('COLOR_BE_CONVERTED',COLOR_BE_CONVERTED);
    AddConstant('COLOR_BE_CONVERTED_TEXT',COLOR_BE_CONVERTED_TEXT);
    AddConstant('COLOR_BE_UNCONVERT',COLOR_BE_UNCONVERT);
    AddConstant('COLOR_BE_UNCONVERT_TEXT',COLOR_BE_UNCONVERT_TEXT);
    AddConstant('COLOR_BE_CURSOR',COLOR_BE_CURSOR);
    AddConstant('COLOR_BE_CURSOR_TEXT',COLOR_BE_CURSOR_TEXT);
    AddConstant('COLOR_BE_PRECONVERT',COLOR_BE_PRECONVERT);
    AddConstant('COLOR_BE_PRECONVERT_TEXT',COLOR_BE_PRECONVERT_TEXT);
    AddConstant('MAXIMECOLORS',MAXIMECOLORS);
    AddConstant('WM_PENMISC',WM_PENMISC);
    AddConstant('PMSC_BEDITCHANGE',PMSC_BEDITCHANGE);
    AddConstant('PMSC_PENUICHANGE',PMSC_PENUICHANGE);
    AddConstant('PMSC_SUBINPCHANGE',PMSC_SUBINPCHANGE);
    AddConstant('PMSC_KKCTLENABLE',PMSC_KKCTLENABLE);
    AddConstant('PMSC_GETPCMINFO',PMSC_GETPCMINFO);
    AddConstant('PMSC_SETPCMINFO',PMSC_SETPCMINFO);
    AddConstant('PMSC_GETINKINGINFO',PMSC_GETINKINGINFO);
    AddConstant('PMSC_SETINKINGINFO',PMSC_SETINKINGINFO);
    AddConstant('PMSC_GETHRC',PMSC_GETHRC);
    AddConstant('PMSC_SETHRC',PMSC_SETHRC);
    AddConstant('PMSC_GETSYMBOLCOUNT',PMSC_GETSYMBOLCOUNT);
    AddConstant('PMSC_GETSYMBOLS',PMSC_GETSYMBOLS);
    AddConstant('PMSC_SETSYMBOLS',PMSC_SETSYMBOLS);
    AddConstant('PMSC_LOADPW',PMSC_LOADPW);
    AddConstant('PMSC_INKSTOP',PMSC_INKSTOP);
    AddConstant('PMSCL_UNLOADED',PMSCL_UNLOADED);
    AddConstant('PMSCL_LOADED',PMSCL_LOADED);
    AddConstant('PMSCL_UNLOADING',PMSCL_UNLOADING);
    AddConstant('WM_CTLINIT',WM_CTLINIT);
    AddConstant('CTLINIT_HEDIT',CTLINIT_HEDIT);
    AddConstant('CTLINIT_BEDIT',CTLINIT_BEDIT);
    AddConstant('CTLINIT_IEDIT',CTLINIT_IEDIT);
    AddConstant('CTLINIT_MAX',CTLINIT_MAX);
    AddConstant('WM_PENEVENT',WM_PENEVENT);
    AddConstant('PE_PENDOWN',PE_PENDOWN);
    AddConstant('PE_PENUP',PE_PENUP);
    AddConstant('PE_PENMOVE',PE_PENMOVE);
    AddConstant('PE_TERMINATING',PE_TERMINATING);
    AddConstant('PE_TERMINATED',PE_TERMINATED);
    AddConstant('PE_BUFFERWARNING',PE_BUFFERWARNING);
    AddConstant('PE_BEGININPUT',PE_BEGININPUT);
    AddConstant('PE_SETTARGETS',PE_SETTARGETS);
    AddConstant('PE_BEGINDATA',PE_BEGINDATA);
    AddConstant('PE_MOREDATA',PE_MOREDATA);
    AddConstant('PE_ENDDATA',PE_ENDDATA);
    AddConstant('PE_GETPCMINFO',PE_GETPCMINFO);
    AddConstant('PE_GETINKINGINFO',PE_GETINKINGINFO);
    AddConstant('PE_ENDINPUT',PE_ENDINPUT);
    AddConstant('PE_RESULT',PE_RESULT);
  end;
end;

class function TatPenWinLibrary.LibraryName: string;
begin
  result := 'PenWin';
end;

initialization
  RegisterScripterLibrary(TatPenWinLibrary, True);

{$WARNINGS ON}

end.

