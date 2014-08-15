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
unit ap_CommDlg;

interface

uses
  Windows,
  Messages,
  ShlObj,
  CommDlg,
  atScript;

{$WARNINGS OFF}

type
  TatCommDlgLibrary = class(TatScripterLibrary)
    procedure __GetOpenFileNameA(AMachine: TatVirtualMachine);
    procedure __GetOpenFileNameW(AMachine: TatVirtualMachine);
    procedure __GetOpenFileName(AMachine: TatVirtualMachine);
    procedure __GetSaveFileNameA(AMachine: TatVirtualMachine);
    procedure __GetSaveFileNameW(AMachine: TatVirtualMachine);
    procedure __GetSaveFileName(AMachine: TatVirtualMachine);
    procedure __GetFileTitleA(AMachine: TatVirtualMachine);
    procedure __GetFileTitleW(AMachine: TatVirtualMachine);
    procedure __GetFileTitle(AMachine: TatVirtualMachine);
    procedure __ChooseColorA(AMachine: TatVirtualMachine);
    procedure __ChooseColorW(AMachine: TatVirtualMachine);
    procedure __ChooseColor(AMachine: TatVirtualMachine);
    procedure __FindTextA(AMachine: TatVirtualMachine);
    procedure __FindTextW(AMachine: TatVirtualMachine);
    procedure __FindText(AMachine: TatVirtualMachine);
    procedure __ReplaceTextA(AMachine: TatVirtualMachine);
    procedure __ReplaceTextW(AMachine: TatVirtualMachine);
    procedure __ReplaceText(AMachine: TatVirtualMachine);
    procedure __ChooseFontA(AMachine: TatVirtualMachine);
    procedure __ChooseFontW(AMachine: TatVirtualMachine);
    procedure __ChooseFont(AMachine: TatVirtualMachine);
    procedure __PrintDlgA(AMachine: TatVirtualMachine);
    procedure __PrintDlgW(AMachine: TatVirtualMachine);
    procedure __PrintDlg(AMachine: TatVirtualMachine);
    procedure __CommDlgExtendedError(AMachine: TatVirtualMachine);
    procedure __PageSetupDlgA(AMachine: TatVirtualMachine);
    procedure __PageSetupDlgW(AMachine: TatVirtualMachine);
    procedure __PageSetupDlg(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagOFNAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhInstance: HINST;
    FnMaxCustFilter: DWORD;
    FnFilterIndex: DWORD;
    FnMaxFile: DWORD;
    FnMaxFileTitle: DWORD;
    FFlags: DWORD;
    FnFileOffset: Word;
    FnFileExtension: Word;
    FlCustData: LPARAM;
  public
    constructor Create(ARecord: tagOFNA);
    function ObjToRec: tagOFNA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hInstance: HINST read FhInstance write FhInstance;
    property nMaxCustFilter: DWORD read FnMaxCustFilter write FnMaxCustFilter;
    property nFilterIndex: DWORD read FnFilterIndex write FnFilterIndex;
    property nMaxFile: DWORD read FnMaxFile write FnMaxFile;
    property nMaxFileTitle: DWORD read FnMaxFileTitle write FnMaxFileTitle;
    property Flags: DWORD read FFlags write FFlags;
    property nFileOffset: Word read FnFileOffset write FnFileOffset;
    property nFileExtension: Word read FnFileExtension write FnFileExtension;
    property lCustData: LPARAM read FlCustData write FlCustData;
  end;
  
  tagOFNWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhInstance: HINST;
    FnMaxCustFilter: DWORD;
    FnFilterIndex: DWORD;
    FnMaxFile: DWORD;
    FnMaxFileTitle: DWORD;
    FFlags: DWORD;
    FnFileOffset: Word;
    FnFileExtension: Word;
    FlCustData: LPARAM;
  public
    constructor Create(ARecord: tagOFNW);
    function ObjToRec: tagOFNW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hInstance: HINST read FhInstance write FhInstance;
    property nMaxCustFilter: DWORD read FnMaxCustFilter write FnMaxCustFilter;
    property nFilterIndex: DWORD read FnFilterIndex write FnFilterIndex;
    property nMaxFile: DWORD read FnMaxFile write FnMaxFile;
    property nMaxFileTitle: DWORD read FnMaxFileTitle write FnMaxFileTitle;
    property Flags: DWORD read FFlags write FFlags;
    property nFileOffset: Word read FnFileOffset write FnFileOffset;
    property nFileExtension: Word read FnFileExtension write FnFileExtension;
    property lCustData: LPARAM read FlCustData write FlCustData;
  end;
  
  _OFNOTIFYAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _OFNOTIFYA);
    function ObjToRec: _OFNOTIFYA;
  published
  end;
  
  _OFNOTIFYWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _OFNOTIFYW);
    function ObjToRec: _OFNOTIFYW;
  published
  end;
  
  _OFNOTIFYEXAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _OFNOTIFYEXA);
    function ObjToRec: _OFNOTIFYEXA;
  published
  end;
  
  _OFNOTIFYEXWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _OFNOTIFYEXW);
    function ObjToRec: _OFNOTIFYEXW;
  published
  end;
  
  tagCHOOSECOLORAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhInstance: HWND;
    FrgbResult: COLORREF;
    FFlags: DWORD;
    FlCustData: LPARAM;
  public
    constructor Create(ARecord: tagCHOOSECOLORA);
    function ObjToRec: tagCHOOSECOLORA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hInstance: HWND read FhInstance write FhInstance;
    property rgbResult: COLORREF read FrgbResult write FrgbResult;
    property Flags: DWORD read FFlags write FFlags;
    property lCustData: LPARAM read FlCustData write FlCustData;
  end;
  
  tagCHOOSECOLORWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhInstance: HWND;
    FrgbResult: COLORREF;
    FFlags: DWORD;
    FlCustData: LPARAM;
  public
    constructor Create(ARecord: tagCHOOSECOLORW);
    function ObjToRec: tagCHOOSECOLORW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hInstance: HWND read FhInstance write FhInstance;
    property rgbResult: COLORREF read FrgbResult write FrgbResult;
    property Flags: DWORD read FFlags write FFlags;
    property lCustData: LPARAM read FlCustData write FlCustData;
  end;
  
  tagFINDREPLACEAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhInstance: HINST;
    FFlags: DWORD;
    FwFindWhatLen: Word;
    FwReplaceWithLen: Word;
    FlCustData: LPARAM;
  public
    constructor Create(ARecord: tagFINDREPLACEA);
    function ObjToRec: tagFINDREPLACEA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hInstance: HINST read FhInstance write FhInstance;
    property Flags: DWORD read FFlags write FFlags;
    property wFindWhatLen: Word read FwFindWhatLen write FwFindWhatLen;
    property wReplaceWithLen: Word read FwReplaceWithLen write FwReplaceWithLen;
    property lCustData: LPARAM read FlCustData write FlCustData;
  end;
  
  tagFINDREPLACEWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhInstance: HINST;
    FFlags: DWORD;
    FwFindWhatLen: Word;
    FwReplaceWithLen: Word;
    FlCustData: LPARAM;
  public
    constructor Create(ARecord: tagFINDREPLACEW);
    function ObjToRec: tagFINDREPLACEW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hInstance: HINST read FhInstance write FhInstance;
    property Flags: DWORD read FFlags write FFlags;
    property wFindWhatLen: Word read FwFindWhatLen write FwFindWhatLen;
    property wReplaceWithLen: Word read FwReplaceWithLen write FwReplaceWithLen;
    property lCustData: LPARAM read FlCustData write FlCustData;
  end;
  
  tagCHOOSEFONTAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWnd;
    FhDC: HDC;
    FiPointSize: Integer;
    FFlags: DWORD;
    FrgbColors: COLORREF;
    FlCustData: LPARAM;
    FhInstance: HINST;
    FnFontType: Word;
    FwReserved: Word;
    FnSizeMin: Integer;
    FnSizeMax: Integer;
  public
    constructor Create(ARecord: tagCHOOSEFONTA);
    function ObjToRec: tagCHOOSEFONTA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property hDC: HDC read FhDC write FhDC;
    property iPointSize: Integer read FiPointSize write FiPointSize;
    property Flags: DWORD read FFlags write FFlags;
    property rgbColors: COLORREF read FrgbColors write FrgbColors;
    property lCustData: LPARAM read FlCustData write FlCustData;
    property hInstance: HINST read FhInstance write FhInstance;
    property nFontType: Word read FnFontType write FnFontType;
    property wReserved: Word read FwReserved write FwReserved;
    property nSizeMin: Integer read FnSizeMin write FnSizeMin;
    property nSizeMax: Integer read FnSizeMax write FnSizeMax;
  end;
  
  tagCHOOSEFONTWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWnd;
    FhDC: HDC;
    FiPointSize: Integer;
    FFlags: DWORD;
    FrgbColors: COLORREF;
    FlCustData: LPARAM;
    FhInstance: HINST;
    FnFontType: Word;
    FwReserved: Word;
    FnSizeMin: Integer;
    FnSizeMax: Integer;
  public
    constructor Create(ARecord: tagCHOOSEFONTW);
    function ObjToRec: tagCHOOSEFONTW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property hDC: HDC read FhDC write FhDC;
    property iPointSize: Integer read FiPointSize write FiPointSize;
    property Flags: DWORD read FFlags write FFlags;
    property rgbColors: COLORREF read FrgbColors write FrgbColors;
    property lCustData: LPARAM read FlCustData write FlCustData;
    property hInstance: HINST read FhInstance write FhInstance;
    property nFontType: Word read FnFontType write FnFontType;
    property wReserved: Word read FwReserved write FwReserved;
    property nSizeMin: Integer read FnSizeMin write FnSizeMin;
    property nSizeMax: Integer read FnSizeMax write FnSizeMax;
  end;
  
  tagPDAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhDevMode: HGLOBAL;
    FhDevNames: HGLOBAL;
    FhDC: HDC;
    FFlags: DWORD;
    FnFromPage: Word;
    FnToPage: Word;
    FnMinPage: Word;
    FnMaxPage: Word;
    FnCopies: Word;
    FhInstance: HINST;
    FlCustData: LPARAM;
    FhPrintTemplate: HGLOBAL;
    FhSetupTemplate: HGLOBAL;
  public
    constructor Create(ARecord: tagPDA);
    function ObjToRec: tagPDA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hDevMode: HGLOBAL read FhDevMode write FhDevMode;
    property hDevNames: HGLOBAL read FhDevNames write FhDevNames;
    property hDC: HDC read FhDC write FhDC;
    property Flags: DWORD read FFlags write FFlags;
    property nFromPage: Word read FnFromPage write FnFromPage;
    property nToPage: Word read FnToPage write FnToPage;
    property nMinPage: Word read FnMinPage write FnMinPage;
    property nMaxPage: Word read FnMaxPage write FnMaxPage;
    property nCopies: Word read FnCopies write FnCopies;
    property hInstance: HINST read FhInstance write FhInstance;
    property lCustData: LPARAM read FlCustData write FlCustData;
    property hPrintTemplate: HGLOBAL read FhPrintTemplate write FhPrintTemplate;
    property hSetupTemplate: HGLOBAL read FhSetupTemplate write FhSetupTemplate;
  end;
  
  tagPDWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhWndOwner: HWND;
    FhDevMode: HGLOBAL;
    FhDevNames: HGLOBAL;
    FhDC: HDC;
    FFlags: DWORD;
    FnFromPage: Word;
    FnToPage: Word;
    FnMinPage: Word;
    FnMaxPage: Word;
    FnCopies: Word;
    FhInstance: HINST;
    FlCustData: LPARAM;
    FhPrintTemplate: HGLOBAL;
    FhSetupTemplate: HGLOBAL;
  public
    constructor Create(ARecord: tagPDW);
    function ObjToRec: tagPDW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hWndOwner: HWND read FhWndOwner write FhWndOwner;
    property hDevMode: HGLOBAL read FhDevMode write FhDevMode;
    property hDevNames: HGLOBAL read FhDevNames write FhDevNames;
    property hDC: HDC read FhDC write FhDC;
    property Flags: DWORD read FFlags write FFlags;
    property nFromPage: Word read FnFromPage write FnFromPage;
    property nToPage: Word read FnToPage write FnToPage;
    property nMinPage: Word read FnMinPage write FnMinPage;
    property nMaxPage: Word read FnMaxPage write FnMaxPage;
    property nCopies: Word read FnCopies write FnCopies;
    property hInstance: HINST read FhInstance write FhInstance;
    property lCustData: LPARAM read FlCustData write FlCustData;
    property hPrintTemplate: HGLOBAL read FhPrintTemplate write FhPrintTemplate;
    property hSetupTemplate: HGLOBAL read FhSetupTemplate write FhSetupTemplate;
  end;
  
  tagDEVNAMESWrapper = class(TatRecordWrapper)
  private
    FwDriverOffset: Word;
    FwDeviceOffset: Word;
    FwOutputOffset: Word;
    FwDefault: Word;
  public
    constructor Create(ARecord: tagDEVNAMES);
    function ObjToRec: tagDEVNAMES;
  published
    property wDriverOffset: Word read FwDriverOffset write FwDriverOffset;
    property wDeviceOffset: Word read FwDeviceOffset write FwDeviceOffset;
    property wOutputOffset: Word read FwOutputOffset write FwOutputOffset;
    property wDefault: Word read FwDefault write FwDefault;
  end;
  
  tagPSDAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhwndOwner: HWND;
    FhDevMode: HGLOBAL;
    FhDevNames: HGLOBAL;
    FFlags: DWORD;
    FhInstance: HINST;
    FlCustData: LPARAM;
    FhPageSetupTemplate: HGLOBAL;
  public
    constructor Create(ARecord: tagPSDA);
    function ObjToRec: tagPSDA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property hDevMode: HGLOBAL read FhDevMode write FhDevMode;
    property hDevNames: HGLOBAL read FhDevNames write FhDevNames;
    property Flags: DWORD read FFlags write FFlags;
    property hInstance: HINST read FhInstance write FhInstance;
    property lCustData: LPARAM read FlCustData write FlCustData;
    property hPageSetupTemplate: HGLOBAL read FhPageSetupTemplate write FhPageSetupTemplate;
  end;
  
  tagPSDWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FhwndOwner: HWND;
    FhDevMode: HGLOBAL;
    FhDevNames: HGLOBAL;
    FFlags: DWORD;
    FhInstance: HINST;
    FlCustData: LPARAM;
    FhPageSetupTemplate: HGLOBAL;
  public
    constructor Create(ARecord: tagPSDW);
    function ObjToRec: tagPSDW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property hDevMode: HGLOBAL read FhDevMode write FhDevMode;
    property hDevNames: HGLOBAL read FhDevNames write FhDevNames;
    property Flags: DWORD read FFlags write FFlags;
    property hInstance: HINST read FhInstance write FhInstance;
    property lCustData: LPARAM read FlCustData write FlCustData;
    property hPageSetupTemplate: HGLOBAL read FhPageSetupTemplate write FhPageSetupTemplate;
  end;
  

implementation

constructor tagOFNAWrapper.Create(ARecord: tagOFNA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhInstance := ARecord.hInstance;
  FnMaxCustFilter := ARecord.nMaxCustFilter;
  FnFilterIndex := ARecord.nFilterIndex;
  FnMaxFile := ARecord.nMaxFile;
  FnMaxFileTitle := ARecord.nMaxFileTitle;
  FFlags := ARecord.Flags;
  FnFileOffset := ARecord.nFileOffset;
  FnFileExtension := ARecord.nFileExtension;
  FlCustData := ARecord.lCustData;
end;

function tagOFNAWrapper.ObjToRec: tagOFNA;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hInstance := FhInstance;
  result.nMaxCustFilter := FnMaxCustFilter;
  result.nFilterIndex := FnFilterIndex;
  result.nMaxFile := FnMaxFile;
  result.nMaxFileTitle := FnMaxFileTitle;
  result.Flags := FFlags;
  result.nFileOffset := FnFileOffset;
  result.nFileExtension := FnFileExtension;
  result.lCustData := FlCustData;
end;

constructor tagOFNWWrapper.Create(ARecord: tagOFNW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhInstance := ARecord.hInstance;
  FnMaxCustFilter := ARecord.nMaxCustFilter;
  FnFilterIndex := ARecord.nFilterIndex;
  FnMaxFile := ARecord.nMaxFile;
  FnMaxFileTitle := ARecord.nMaxFileTitle;
  FFlags := ARecord.Flags;
  FnFileOffset := ARecord.nFileOffset;
  FnFileExtension := ARecord.nFileExtension;
  FlCustData := ARecord.lCustData;
end;

function tagOFNWWrapper.ObjToRec: tagOFNW;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hInstance := FhInstance;
  result.nMaxCustFilter := FnMaxCustFilter;
  result.nFilterIndex := FnFilterIndex;
  result.nMaxFile := FnMaxFile;
  result.nMaxFileTitle := FnMaxFileTitle;
  result.Flags := FFlags;
  result.nFileOffset := FnFileOffset;
  result.nFileExtension := FnFileExtension;
  result.lCustData := FlCustData;
end;

constructor _OFNOTIFYAWrapper.Create(ARecord: _OFNOTIFYA);
begin
  inherited Create;
end;

function _OFNOTIFYAWrapper.ObjToRec: _OFNOTIFYA;
begin
end;

constructor _OFNOTIFYWWrapper.Create(ARecord: _OFNOTIFYW);
begin
  inherited Create;
end;

function _OFNOTIFYWWrapper.ObjToRec: _OFNOTIFYW;
begin
end;

constructor _OFNOTIFYEXAWrapper.Create(ARecord: _OFNOTIFYEXA);
begin
  inherited Create;
end;

function _OFNOTIFYEXAWrapper.ObjToRec: _OFNOTIFYEXA;
begin
end;

constructor _OFNOTIFYEXWWrapper.Create(ARecord: _OFNOTIFYEXW);
begin
  inherited Create;
end;

function _OFNOTIFYEXWWrapper.ObjToRec: _OFNOTIFYEXW;
begin
end;

constructor tagCHOOSECOLORAWrapper.Create(ARecord: tagCHOOSECOLORA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhInstance := ARecord.hInstance;
  FrgbResult := ARecord.rgbResult;
  FFlags := ARecord.Flags;
  FlCustData := ARecord.lCustData;
end;

function tagCHOOSECOLORAWrapper.ObjToRec: tagCHOOSECOLORA;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hInstance := FhInstance;
  result.rgbResult := FrgbResult;
  result.Flags := FFlags;
  result.lCustData := FlCustData;
end;

constructor tagCHOOSECOLORWWrapper.Create(ARecord: tagCHOOSECOLORW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhInstance := ARecord.hInstance;
  FrgbResult := ARecord.rgbResult;
  FFlags := ARecord.Flags;
  FlCustData := ARecord.lCustData;
end;

function tagCHOOSECOLORWWrapper.ObjToRec: tagCHOOSECOLORW;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hInstance := FhInstance;
  result.rgbResult := FrgbResult;
  result.Flags := FFlags;
  result.lCustData := FlCustData;
end;

constructor tagFINDREPLACEAWrapper.Create(ARecord: tagFINDREPLACEA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhInstance := ARecord.hInstance;
  FFlags := ARecord.Flags;
  FwFindWhatLen := ARecord.wFindWhatLen;
  FwReplaceWithLen := ARecord.wReplaceWithLen;
  FlCustData := ARecord.lCustData;
end;

function tagFINDREPLACEAWrapper.ObjToRec: tagFINDREPLACEA;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hInstance := FhInstance;
  result.Flags := FFlags;
  result.wFindWhatLen := FwFindWhatLen;
  result.wReplaceWithLen := FwReplaceWithLen;
  result.lCustData := FlCustData;
end;

constructor tagFINDREPLACEWWrapper.Create(ARecord: tagFINDREPLACEW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhInstance := ARecord.hInstance;
  FFlags := ARecord.Flags;
  FwFindWhatLen := ARecord.wFindWhatLen;
  FwReplaceWithLen := ARecord.wReplaceWithLen;
  FlCustData := ARecord.lCustData;
end;

function tagFINDREPLACEWWrapper.ObjToRec: tagFINDREPLACEW;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hInstance := FhInstance;
  result.Flags := FFlags;
  result.wFindWhatLen := FwFindWhatLen;
  result.wReplaceWithLen := FwReplaceWithLen;
  result.lCustData := FlCustData;
end;

constructor tagCHOOSEFONTAWrapper.Create(ARecord: tagCHOOSEFONTA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhDC := ARecord.hDC;
  FiPointSize := ARecord.iPointSize;
  FFlags := ARecord.Flags;
  FrgbColors := ARecord.rgbColors;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FnFontType := ARecord.nFontType;
  FwReserved := ARecord.wReserved;
  FnSizeMin := ARecord.nSizeMin;
  FnSizeMax := ARecord.nSizeMax;
end;

function tagCHOOSEFONTAWrapper.ObjToRec: tagCHOOSEFONTA;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hDC := FhDC;
  result.iPointSize := FiPointSize;
  result.Flags := FFlags;
  result.rgbColors := FrgbColors;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.nFontType := FnFontType;
  result.wReserved := FwReserved;
  result.nSizeMin := FnSizeMin;
  result.nSizeMax := FnSizeMax;
end;

constructor tagCHOOSEFONTWWrapper.Create(ARecord: tagCHOOSEFONTW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhDC := ARecord.hDC;
  FiPointSize := ARecord.iPointSize;
  FFlags := ARecord.Flags;
  FrgbColors := ARecord.rgbColors;
  FlCustData := ARecord.lCustData;
  FhInstance := ARecord.hInstance;
  FnFontType := ARecord.nFontType;
  FwReserved := ARecord.wReserved;
  FnSizeMin := ARecord.nSizeMin;
  FnSizeMax := ARecord.nSizeMax;
end;

function tagCHOOSEFONTWWrapper.ObjToRec: tagCHOOSEFONTW;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hDC := FhDC;
  result.iPointSize := FiPointSize;
  result.Flags := FFlags;
  result.rgbColors := FrgbColors;
  result.lCustData := FlCustData;
  result.hInstance := FhInstance;
  result.nFontType := FnFontType;
  result.wReserved := FwReserved;
  result.nSizeMin := FnSizeMin;
  result.nSizeMax := FnSizeMax;
end;

constructor tagPDAWrapper.Create(ARecord: tagPDA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhDevMode := ARecord.hDevMode;
  FhDevNames := ARecord.hDevNames;
  FhDC := ARecord.hDC;
  FFlags := ARecord.Flags;
  FnFromPage := ARecord.nFromPage;
  FnToPage := ARecord.nToPage;
  FnMinPage := ARecord.nMinPage;
  FnMaxPage := ARecord.nMaxPage;
  FnCopies := ARecord.nCopies;
  FhInstance := ARecord.hInstance;
  FlCustData := ARecord.lCustData;
  FhPrintTemplate := ARecord.hPrintTemplate;
  FhSetupTemplate := ARecord.hSetupTemplate;
end;

function tagPDAWrapper.ObjToRec: tagPDA;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hDevMode := FhDevMode;
  result.hDevNames := FhDevNames;
  result.hDC := FhDC;
  result.Flags := FFlags;
  result.nFromPage := FnFromPage;
  result.nToPage := FnToPage;
  result.nMinPage := FnMinPage;
  result.nMaxPage := FnMaxPage;
  result.nCopies := FnCopies;
  result.hInstance := FhInstance;
  result.lCustData := FlCustData;
  result.hPrintTemplate := FhPrintTemplate;
  result.hSetupTemplate := FhSetupTemplate;
end;

constructor tagPDWWrapper.Create(ARecord: tagPDW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhWndOwner := ARecord.hWndOwner;
  FhDevMode := ARecord.hDevMode;
  FhDevNames := ARecord.hDevNames;
  FhDC := ARecord.hDC;
  FFlags := ARecord.Flags;
  FnFromPage := ARecord.nFromPage;
  FnToPage := ARecord.nToPage;
  FnMinPage := ARecord.nMinPage;
  FnMaxPage := ARecord.nMaxPage;
  FnCopies := ARecord.nCopies;
  FhInstance := ARecord.hInstance;
  FlCustData := ARecord.lCustData;
  FhPrintTemplate := ARecord.hPrintTemplate;
  FhSetupTemplate := ARecord.hSetupTemplate;
end;

function tagPDWWrapper.ObjToRec: tagPDW;
begin
  result.lStructSize := FlStructSize;
  result.hWndOwner := FhWndOwner;
  result.hDevMode := FhDevMode;
  result.hDevNames := FhDevNames;
  result.hDC := FhDC;
  result.Flags := FFlags;
  result.nFromPage := FnFromPage;
  result.nToPage := FnToPage;
  result.nMinPage := FnMinPage;
  result.nMaxPage := FnMaxPage;
  result.nCopies := FnCopies;
  result.hInstance := FhInstance;
  result.lCustData := FlCustData;
  result.hPrintTemplate := FhPrintTemplate;
  result.hSetupTemplate := FhSetupTemplate;
end;

constructor tagDEVNAMESWrapper.Create(ARecord: tagDEVNAMES);
begin
  inherited Create;
  FwDriverOffset := ARecord.wDriverOffset;
  FwDeviceOffset := ARecord.wDeviceOffset;
  FwOutputOffset := ARecord.wOutputOffset;
  FwDefault := ARecord.wDefault;
end;

function tagDEVNAMESWrapper.ObjToRec: tagDEVNAMES;
begin
  result.wDriverOffset := FwDriverOffset;
  result.wDeviceOffset := FwDeviceOffset;
  result.wOutputOffset := FwOutputOffset;
  result.wDefault := FwDefault;
end;

constructor tagPSDAWrapper.Create(ARecord: tagPSDA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhwndOwner := ARecord.hwndOwner;
  FhDevMode := ARecord.hDevMode;
  FhDevNames := ARecord.hDevNames;
  FFlags := ARecord.Flags;
  FhInstance := ARecord.hInstance;
  FlCustData := ARecord.lCustData;
  FhPageSetupTemplate := ARecord.hPageSetupTemplate;
end;

function tagPSDAWrapper.ObjToRec: tagPSDA;
begin
  result.lStructSize := FlStructSize;
  result.hwndOwner := FhwndOwner;
  result.hDevMode := FhDevMode;
  result.hDevNames := FhDevNames;
  result.Flags := FFlags;
  result.hInstance := FhInstance;
  result.lCustData := FlCustData;
  result.hPageSetupTemplate := FhPageSetupTemplate;
end;

constructor tagPSDWWrapper.Create(ARecord: tagPSDW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FhwndOwner := ARecord.hwndOwner;
  FhDevMode := ARecord.hDevMode;
  FhDevNames := ARecord.hDevNames;
  FFlags := ARecord.Flags;
  FhInstance := ARecord.hInstance;
  FlCustData := ARecord.lCustData;
  FhPageSetupTemplate := ARecord.hPageSetupTemplate;
end;

function tagPSDWWrapper.ObjToRec: tagPSDW;
begin
  result.lStructSize := FlStructSize;
  result.hwndOwner := FhwndOwner;
  result.hDevMode := FhDevMode;
  result.hDevNames := FhDevNames;
  result.Flags := FFlags;
  result.hInstance := FhInstance;
  result.lCustData := FlCustData;
  result.hPageSetupTemplate := FhPageSetupTemplate;
end;



procedure TatCommDlgLibrary.__GetOpenFileNameA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOpenFilenameA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOFNAWrapper) then 
  Param0Rec := tagOFNAWrapper.Create(Param0);
Param0 := tagOFNAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.GetOpenFileNameA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOFNAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__GetOpenFileNameW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOpenFilenameW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOFNWWrapper) then 
  Param0Rec := tagOFNWWrapper.Create(Param0);
Param0 := tagOFNWWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.GetOpenFileNameW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOFNWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__GetOpenFileName(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOpenFilename;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOFNAWrapper) then 
  Param0Rec := tagOFNAWrapper.Create(Param0);
Param0 := tagOFNAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.GetOpenFileName(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOFNAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__GetSaveFileNameA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOpenFilenameA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOFNAWrapper) then 
  Param0Rec := tagOFNAWrapper.Create(Param0);
Param0 := tagOFNAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.GetSaveFileNameA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOFNAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__GetSaveFileNameW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOpenFilenameW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOFNWWrapper) then 
  Param0Rec := tagOFNWWrapper.Create(Param0);
Param0 := tagOFNWWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.GetSaveFileNameW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOFNWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__GetSaveFileName(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TOpenFilename;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagOFNAWrapper) then 
  Param0Rec := tagOFNAWrapper.Create(Param0);
Param0 := tagOFNAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.GetSaveFileName(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagOFNAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__GetFileTitleA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CommDlg.GetFileTitleA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommDlgLibrary.__GetFileTitleW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CommDlg.GetFileTitleW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommDlgLibrary.__GetFileTitle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CommDlg.GetFileTitle(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommDlgLibrary.__ChooseColorA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TChooseColorA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCHOOSECOLORAWrapper) then 
  Param0Rec := tagCHOOSECOLORAWrapper.Create(Param0);
Param0 := tagCHOOSECOLORAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.ChooseColorA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCHOOSECOLORAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ChooseColorW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TChooseColorW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCHOOSECOLORWWrapper) then 
  Param0Rec := tagCHOOSECOLORWWrapper.Create(Param0);
Param0 := tagCHOOSECOLORWWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.ChooseColorW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCHOOSECOLORWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ChooseColor(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TChooseColor;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCHOOSECOLORAWrapper) then 
  Param0Rec := tagCHOOSECOLORAWrapper.Create(Param0);
Param0 := tagCHOOSECOLORAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.ChooseColor(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCHOOSECOLORAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__FindTextA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFindReplaceA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFINDREPLACEAWrapper) then 
  Param0Rec := tagFINDREPLACEAWrapper.Create(Param0);
Param0 := tagFINDREPLACEAWrapper(Param0Rec).ObjToRec;
AResult := Integer(CommDlg.FindTextA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFINDREPLACEAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__FindTextW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFindReplaceW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFINDREPLACEWWrapper) then 
  Param0Rec := tagFINDREPLACEWWrapper.Create(Param0);
Param0 := tagFINDREPLACEWWrapper(Param0Rec).ObjToRec;
AResult := Integer(CommDlg.FindTextW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFINDREPLACEWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__FindText(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFindReplace;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFINDREPLACEAWrapper) then 
  Param0Rec := tagFINDREPLACEAWrapper.Create(Param0);
Param0 := tagFINDREPLACEAWrapper(Param0Rec).ObjToRec;
AResult := Integer(CommDlg.FindText(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFINDREPLACEAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ReplaceTextA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFindReplaceA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFINDREPLACEAWrapper) then 
  Param0Rec := tagFINDREPLACEAWrapper.Create(Param0);
Param0 := tagFINDREPLACEAWrapper(Param0Rec).ObjToRec;
AResult := Integer(CommDlg.ReplaceTextA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFINDREPLACEAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ReplaceTextW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFindReplaceW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFINDREPLACEWWrapper) then 
  Param0Rec := tagFINDREPLACEWWrapper.Create(Param0);
Param0 := tagFINDREPLACEWWrapper(Param0Rec).ObjToRec;
AResult := Integer(CommDlg.ReplaceTextW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFINDREPLACEWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ReplaceText(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFindReplace;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagFINDREPLACEAWrapper) then 
  Param0Rec := tagFINDREPLACEAWrapper.Create(Param0);
Param0 := tagFINDREPLACEAWrapper(Param0Rec).ObjToRec;
AResult := Integer(CommDlg.ReplaceText(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagFINDREPLACEAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ChooseFontA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TChooseFontA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCHOOSEFONTAWrapper) then 
  Param0Rec := tagCHOOSEFONTAWrapper.Create(Param0);
Param0 := tagCHOOSEFONTAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.ChooseFontA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCHOOSEFONTAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ChooseFontW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TChooseFontW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCHOOSEFONTWWrapper) then 
  Param0Rec := tagCHOOSEFONTWWrapper.Create(Param0);
Param0 := tagCHOOSEFONTWWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.ChooseFontW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCHOOSEFONTWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__ChooseFont(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TChooseFont;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCHOOSEFONTAWrapper) then 
  Param0Rec := tagCHOOSEFONTAWrapper.Create(Param0);
Param0 := tagCHOOSEFONTAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.ChooseFont(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagCHOOSEFONTAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__PrintDlgA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPrintDlgA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPDAWrapper) then 
  Param0Rec := tagPDAWrapper.Create(Param0);
Param0 := tagPDAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.PrintDlgA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPDAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__PrintDlgW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPrintDlgW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPDWWrapper) then 
  Param0Rec := tagPDWWrapper.Create(Param0);
Param0 := tagPDWWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.PrintDlgW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPDWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__PrintDlg(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPrintDlg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPDAWrapper) then 
  Param0Rec := tagPDAWrapper.Create(Param0);
Param0 := tagPDAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.PrintDlg(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPDAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__CommDlgExtendedError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CommDlg.CommDlgExtendedError);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCommDlgLibrary.__PageSetupDlgA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPageSetupDlgA;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPSDAWrapper) then 
  Param0Rec := tagPSDAWrapper.Create(Param0);
Param0 := tagPSDAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.PageSetupDlgA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPSDAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__PageSetupDlgW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPageSetupDlgW;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPSDWWrapper) then 
  Param0Rec := tagPSDWWrapper.Create(Param0);
Param0 := tagPSDWWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.PageSetupDlgW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPSDWWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.__PageSetupDlg(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPageSetupDlg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagPSDAWrapper) then 
  Param0Rec := tagPSDAWrapper.Create(Param0);
Param0 := tagPSDAWrapper(Param0Rec).ObjToRec;
AResult := CommDlg.PageSetupDlg(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagPSDAWrapper.Create(Param0)));
  end;
end;

procedure TatCommDlgLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetOpenFileNameA',1,tkVariant,nil,__GetOpenFileNameA,false,0).SetVarArgs([0]);
    DefineMethod('GetOpenFileNameW',1,tkVariant,nil,__GetOpenFileNameW,false,0).SetVarArgs([0]);
    DefineMethod('GetOpenFileName',1,tkVariant,nil,__GetOpenFileName,false,0).SetVarArgs([0]);
    DefineMethod('GetSaveFileNameA',1,tkVariant,nil,__GetSaveFileNameA,false,0).SetVarArgs([0]);
    DefineMethod('GetSaveFileNameW',1,tkVariant,nil,__GetSaveFileNameW,false,0).SetVarArgs([0]);
    DefineMethod('GetSaveFileName',1,tkVariant,nil,__GetSaveFileName,false,0).SetVarArgs([0]);
    DefineMethod('GetFileTitleA',3,tkInteger,nil,__GetFileTitleA,false,0);
    DefineMethod('GetFileTitleW',3,tkInteger,nil,__GetFileTitleW,false,0);
    DefineMethod('GetFileTitle',3,tkInteger,nil,__GetFileTitle,false,0);
    DefineMethod('ChooseColorA',1,tkVariant,nil,__ChooseColorA,false,0).SetVarArgs([0]);
    DefineMethod('ChooseColorW',1,tkVariant,nil,__ChooseColorW,false,0).SetVarArgs([0]);
    DefineMethod('ChooseColor',1,tkVariant,nil,__ChooseColor,false,0).SetVarArgs([0]);
    DefineMethod('FindTextA',1,tkInteger,nil,__FindTextA,false,0).SetVarArgs([0]);
    DefineMethod('FindTextW',1,tkInteger,nil,__FindTextW,false,0).SetVarArgs([0]);
    DefineMethod('FindText',1,tkInteger,nil,__FindText,false,0).SetVarArgs([0]);
    DefineMethod('ReplaceTextA',1,tkInteger,nil,__ReplaceTextA,false,0).SetVarArgs([0]);
    DefineMethod('ReplaceTextW',1,tkInteger,nil,__ReplaceTextW,false,0).SetVarArgs([0]);
    DefineMethod('ReplaceText',1,tkInteger,nil,__ReplaceText,false,0).SetVarArgs([0]);
    DefineMethod('ChooseFontA',1,tkVariant,nil,__ChooseFontA,false,0).SetVarArgs([0]);
    DefineMethod('ChooseFontW',1,tkVariant,nil,__ChooseFontW,false,0).SetVarArgs([0]);
    DefineMethod('ChooseFont',1,tkVariant,nil,__ChooseFont,false,0).SetVarArgs([0]);
    DefineMethod('PrintDlgA',1,tkVariant,nil,__PrintDlgA,false,0).SetVarArgs([0]);
    DefineMethod('PrintDlgW',1,tkVariant,nil,__PrintDlgW,false,0).SetVarArgs([0]);
    DefineMethod('PrintDlg',1,tkVariant,nil,__PrintDlg,false,0).SetVarArgs([0]);
    DefineMethod('CommDlgExtendedError',0,tkInteger,nil,__CommDlgExtendedError,false,0);
    DefineMethod('PageSetupDlgA',1,tkVariant,nil,__PageSetupDlgA,false,0).SetVarArgs([0]);
    DefineMethod('PageSetupDlgW',1,tkVariant,nil,__PageSetupDlgW,false,0).SetVarArgs([0]);
    DefineMethod('PageSetupDlg',1,tkVariant,nil,__PageSetupDlg,false,0).SetVarArgs([0]);
    AddConstant('OFN_READONLY',OFN_READONLY);
    AddConstant('OFN_OVERWRITEPROMPT',OFN_OVERWRITEPROMPT);
    AddConstant('OFN_HIDEREADONLY',OFN_HIDEREADONLY);
    AddConstant('OFN_NOCHANGEDIR',OFN_NOCHANGEDIR);
    AddConstant('OFN_SHOWHELP',OFN_SHOWHELP);
    AddConstant('OFN_ENABLEHOOK',OFN_ENABLEHOOK);
    AddConstant('OFN_ENABLETEMPLATE',OFN_ENABLETEMPLATE);
    AddConstant('OFN_ENABLETEMPLATEHANDLE',OFN_ENABLETEMPLATEHANDLE);
    AddConstant('OFN_NOVALIDATE',OFN_NOVALIDATE);
    AddConstant('OFN_ALLOWMULTISELECT',OFN_ALLOWMULTISELECT);
    AddConstant('OFN_EXTENSIONDIFFERENT',OFN_EXTENSIONDIFFERENT);
    AddConstant('OFN_PATHMUSTEXIST',OFN_PATHMUSTEXIST);
    AddConstant('OFN_FILEMUSTEXIST',OFN_FILEMUSTEXIST);
    AddConstant('OFN_CREATEPROMPT',OFN_CREATEPROMPT);
    AddConstant('OFN_SHAREAWARE',OFN_SHAREAWARE);
    AddConstant('OFN_NOREADONLYRETURN',OFN_NOREADONLYRETURN);
    AddConstant('OFN_NOTESTFILECREATE',OFN_NOTESTFILECREATE);
    AddConstant('OFN_NONETWORKBUTTON',OFN_NONETWORKBUTTON);
    AddConstant('OFN_NOLONGNAMES',OFN_NOLONGNAMES);
    AddConstant('OFN_EXPLORER',OFN_EXPLORER);
    AddConstant('OFN_NODEREFERENCELINKS',OFN_NODEREFERENCELINKS);
    AddConstant('OFN_LONGNAMES',OFN_LONGNAMES);
    AddConstant('OFN_ENABLEINCLUDENOTIFY',OFN_ENABLEINCLUDENOTIFY);
    AddConstant('OFN_ENABLESIZING',OFN_ENABLESIZING);
    AddConstant('OFN_SHAREFALLTHROUGH',OFN_SHAREFALLTHROUGH);
    AddConstant('OFN_SHARENOWARN',OFN_SHARENOWARN);
    AddConstant('OFN_SHAREWARN',OFN_SHAREWARN);
    AddConstant('CDN_FIRST',CDN_FIRST);
    AddConstant('CDN_LAST',CDN_LAST);
    AddConstant('CDN_INITDONE',CDN_INITDONE);
    AddConstant('CDN_SELCHANGE',CDN_SELCHANGE);
    AddConstant('CDN_FOLDERCHANGE',CDN_FOLDERCHANGE);
    AddConstant('CDN_SHAREVIOLATION',CDN_SHAREVIOLATION);
    AddConstant('CDN_HELP',CDN_HELP);
    AddConstant('CDN_FILEOK',CDN_FILEOK);
    AddConstant('CDN_TYPECHANGE',CDN_TYPECHANGE);
    AddConstant('CDN_INCLUDEITEM',CDN_INCLUDEITEM);
    AddConstant('CDM_FIRST',CDM_FIRST);
    AddConstant('CDM_LAST',CDM_LAST);
    AddConstant('CDM_GETSPEC',CDM_GETSPEC);
    AddConstant('CDM_GETFILEPATH',CDM_GETFILEPATH);
    AddConstant('CDM_GETFOLDERPATH',CDM_GETFOLDERPATH);
    AddConstant('CDM_GETFOLDERIDLIST',CDM_GETFOLDERIDLIST);
    AddConstant('CDM_SETCONTROLTEXT',CDM_SETCONTROLTEXT);
    AddConstant('CDM_HIDECONTROL',CDM_HIDECONTROL);
    AddConstant('CDM_SETDEFEXT',CDM_SETDEFEXT);
    AddConstant('CC_RGBINIT',CC_RGBINIT);
    AddConstant('CC_FULLOPEN',CC_FULLOPEN);
    AddConstant('CC_PREVENTFULLOPEN',CC_PREVENTFULLOPEN);
    AddConstant('CC_SHOWHELP',CC_SHOWHELP);
    AddConstant('CC_ENABLEHOOK',CC_ENABLEHOOK);
    AddConstant('CC_ENABLETEMPLATE',CC_ENABLETEMPLATE);
    AddConstant('CC_ENABLETEMPLATEHANDLE',CC_ENABLETEMPLATEHANDLE);
    AddConstant('CC_SOLIDCOLOR',CC_SOLIDCOLOR);
    AddConstant('CC_ANYCOLOR',CC_ANYCOLOR);
    AddConstant('FR_DOWN',FR_DOWN);
    AddConstant('FR_WHOLEWORD',FR_WHOLEWORD);
    AddConstant('FR_MATCHCASE',FR_MATCHCASE);
    AddConstant('FR_FINDNEXT',FR_FINDNEXT);
    AddConstant('FR_REPLACE',FR_REPLACE);
    AddConstant('FR_REPLACEALL',FR_REPLACEALL);
    AddConstant('FR_DIALOGTERM',FR_DIALOGTERM);
    AddConstant('FR_SHOWHELP',FR_SHOWHELP);
    AddConstant('FR_ENABLEHOOK',FR_ENABLEHOOK);
    AddConstant('FR_ENABLETEMPLATE',FR_ENABLETEMPLATE);
    AddConstant('FR_NOUPDOWN',FR_NOUPDOWN);
    AddConstant('FR_NOMATCHCASE',FR_NOMATCHCASE);
    AddConstant('FR_NOWHOLEWORD',FR_NOWHOLEWORD);
    AddConstant('FR_ENABLETEMPLATEHANDLE',FR_ENABLETEMPLATEHANDLE);
    AddConstant('FR_HIDEUPDOWN',FR_HIDEUPDOWN);
    AddConstant('FR_HIDEMATCHCASE',FR_HIDEMATCHCASE);
    AddConstant('FR_HIDEWHOLEWORD',FR_HIDEWHOLEWORD);
    AddConstant('CF_SCREENFONTS',CF_SCREENFONTS);
    AddConstant('CF_PRINTERFONTS',CF_PRINTERFONTS);
    AddConstant('CF_BOTH',CF_BOTH);
    AddConstant('CF_SHOWHELP',CF_SHOWHELP);
    AddConstant('CF_ENABLEHOOK',CF_ENABLEHOOK);
    AddConstant('CF_ENABLETEMPLATE',CF_ENABLETEMPLATE);
    AddConstant('CF_ENABLETEMPLATEHANDLE',CF_ENABLETEMPLATEHANDLE);
    AddConstant('CF_INITTOLOGFONTSTRUCT',CF_INITTOLOGFONTSTRUCT);
    AddConstant('CF_USESTYLE',CF_USESTYLE);
    AddConstant('CF_EFFECTS',CF_EFFECTS);
    AddConstant('CF_APPLY',CF_APPLY);
    AddConstant('CF_ANSIONLY',CF_ANSIONLY);
    AddConstant('CF_SCRIPTSONLY',CF_SCRIPTSONLY);
    AddConstant('CF_NOVECTORFONTS',CF_NOVECTORFONTS);
    AddConstant('CF_NOOEMFONTS',CF_NOOEMFONTS);
    AddConstant('CF_NOSIMULATIONS',CF_NOSIMULATIONS);
    AddConstant('CF_LIMITSIZE',CF_LIMITSIZE);
    AddConstant('CF_FIXEDPITCHONLY',CF_FIXEDPITCHONLY);
    AddConstant('CF_WYSIWYG',CF_WYSIWYG);
    AddConstant('CF_FORCEFONTEXIST',CF_FORCEFONTEXIST);
    AddConstant('CF_SCALABLEONLY',CF_SCALABLEONLY);
    AddConstant('CF_TTONLY',CF_TTONLY);
    AddConstant('CF_NOFACESEL',CF_NOFACESEL);
    AddConstant('CF_NOSTYLESEL',CF_NOSTYLESEL);
    AddConstant('CF_NOSIZESEL',CF_NOSIZESEL);
    AddConstant('CF_SELECTSCRIPT',CF_SELECTSCRIPT);
    AddConstant('CF_NOSCRIPTSEL',CF_NOSCRIPTSEL);
    AddConstant('CF_NOVERTFONTS',CF_NOVERTFONTS);
    AddConstant('SIMULATED_FONTTYPE',SIMULATED_FONTTYPE);
    AddConstant('PRINTER_FONTTYPE',PRINTER_FONTTYPE);
    AddConstant('SCREEN_FONTTYPE',SCREEN_FONTTYPE);
    AddConstant('BOLD_FONTTYPE',BOLD_FONTTYPE);
    AddConstant('ITALIC_FONTTYPE',ITALIC_FONTTYPE);
    AddConstant('REGULAR_FONTTYPE',REGULAR_FONTTYPE);
    AddConstant('OPENTYPE_FONTTYPE',OPENTYPE_FONTTYPE);
    AddConstant('TYPE1_FONTTYPE',TYPE1_FONTTYPE);
    AddConstant('DSIG_FONTTYPE',DSIG_FONTTYPE);
    AddConstant('WM_CHOOSEFONT_GETLOGFONT',WM_CHOOSEFONT_GETLOGFONT);
    AddConstant('WM_CHOOSEFONT_SETLOGFONT',WM_CHOOSEFONT_SETLOGFONT);
    AddConstant('WM_CHOOSEFONT_SETFLAGS',WM_CHOOSEFONT_SETFLAGS);
    AddConstant('LBSELCHSTRING',LBSELCHSTRING);
    AddConstant('SHAREVISTRING',SHAREVISTRING);
    AddConstant('FILEOKSTRING',FILEOKSTRING);
    AddConstant('COLOROKSTRING',COLOROKSTRING);
    AddConstant('SETRGBSTRING',SETRGBSTRING);
    AddConstant('FINDMSGSTRING',FINDMSGSTRING);
    AddConstant('HELPMSGSTRING',HELPMSGSTRING);
    AddConstant('CD_LBSELNOITEMS',CD_LBSELNOITEMS);
    AddConstant('CD_LBSELCHANGE',CD_LBSELCHANGE);
    AddConstant('CD_LBSELSUB',CD_LBSELSUB);
    AddConstant('CD_LBSELADD',CD_LBSELADD);
    AddConstant('PD_ALLPAGES',PD_ALLPAGES);
    AddConstant('PD_SELECTION',PD_SELECTION);
    AddConstant('PD_PAGENUMS',PD_PAGENUMS);
    AddConstant('PD_NOSELECTION',PD_NOSELECTION);
    AddConstant('PD_NOPAGENUMS',PD_NOPAGENUMS);
    AddConstant('PD_COLLATE',PD_COLLATE);
    AddConstant('PD_PRINTTOFILE',PD_PRINTTOFILE);
    AddConstant('PD_PRINTSETUP',PD_PRINTSETUP);
    AddConstant('PD_NOWARNING',PD_NOWARNING);
    AddConstant('PD_RETURNDC',PD_RETURNDC);
    AddConstant('PD_RETURNIC',PD_RETURNIC);
    AddConstant('PD_RETURNDEFAULT',PD_RETURNDEFAULT);
    AddConstant('PD_SHOWHELP',PD_SHOWHELP);
    AddConstant('PD_ENABLEPRINTHOOK',PD_ENABLEPRINTHOOK);
    AddConstant('PD_ENABLESETUPHOOK',PD_ENABLESETUPHOOK);
    AddConstant('PD_ENABLEPRINTTEMPLATE',PD_ENABLEPRINTTEMPLATE);
    AddConstant('PD_ENABLESETUPTEMPLATE',PD_ENABLESETUPTEMPLATE);
    AddConstant('PD_ENABLEPRINTTEMPLATEHANDLE',PD_ENABLEPRINTTEMPLATEHANDLE);
    AddConstant('PD_ENABLESETUPTEMPLATEHANDLE',PD_ENABLESETUPTEMPLATEHANDLE);
    AddConstant('PD_USEDEVMODECOPIES',PD_USEDEVMODECOPIES);
    AddConstant('PD_USEDEVMODECOPIESANDCOLLATE',PD_USEDEVMODECOPIESANDCOLLATE);
    AddConstant('PD_DISABLEPRINTTOFILE',PD_DISABLEPRINTTOFILE);
    AddConstant('PD_HIDEPRINTTOFILE',PD_HIDEPRINTTOFILE);
    AddConstant('PD_NONETWORKBUTTON',PD_NONETWORKBUTTON);
    AddConstant('DN_DEFAULTPRN',DN_DEFAULTPRN);
    AddConstant('WM_PSD_PAGESETUPDLG',WM_PSD_PAGESETUPDLG);
    AddConstant('WM_PSD_FULLPAGERECT',WM_PSD_FULLPAGERECT);
    AddConstant('WM_PSD_MINMARGINRECT',WM_PSD_MINMARGINRECT);
    AddConstant('WM_PSD_MARGINRECT',WM_PSD_MARGINRECT);
    AddConstant('WM_PSD_GREEKTEXTRECT',WM_PSD_GREEKTEXTRECT);
    AddConstant('WM_PSD_ENVSTAMPRECT',WM_PSD_ENVSTAMPRECT);
    AddConstant('WM_PSD_YAFULLPAGERECT',WM_PSD_YAFULLPAGERECT);
    AddConstant('PSD_DEFAULTMINMARGINS',PSD_DEFAULTMINMARGINS);
    AddConstant('PSD_INWININIINTLMEASURE',PSD_INWININIINTLMEASURE);
    AddConstant('PSD_MINMARGINS',PSD_MINMARGINS);
    AddConstant('PSD_MARGINS',PSD_MARGINS);
    AddConstant('PSD_INTHOUSANDTHSOFINCHES',PSD_INTHOUSANDTHSOFINCHES);
    AddConstant('PSD_INHUNDREDTHSOFMILLIMETERS',PSD_INHUNDREDTHSOFMILLIMETERS);
    AddConstant('PSD_DISABLEMARGINS',PSD_DISABLEMARGINS);
    AddConstant('PSD_DISABLEPRINTER',PSD_DISABLEPRINTER);
    AddConstant('PSD_NOWARNING',PSD_NOWARNING);
    AddConstant('PSD_DISABLEORIENTATION',PSD_DISABLEORIENTATION);
    AddConstant('PSD_RETURNDEFAULT',PSD_RETURNDEFAULT);
    AddConstant('PSD_DISABLEPAPER',PSD_DISABLEPAPER);
    AddConstant('PSD_SHOWHELP',PSD_SHOWHELP);
    AddConstant('PSD_ENABLEPAGESETUPHOOK',PSD_ENABLEPAGESETUPHOOK);
    AddConstant('PSD_ENABLEPAGESETUPTEMPLATE',PSD_ENABLEPAGESETUPTEMPLATE);
    AddConstant('PSD_ENABLEPAGESETUPTEMPLATEHANDLE',PSD_ENABLEPAGESETUPTEMPLATEHANDLE);
    AddConstant('PSD_ENABLEPAGEPAINTHOOK',PSD_ENABLEPAGEPAINTHOOK);
    AddConstant('PSD_DISABLEPAGEPAINTING',PSD_DISABLEPAGEPAINTING);
    AddConstant('PSD_NONETWORKBUTTON',PSD_NONETWORKBUTTON);
    AddConstant('CDERR_DIALOGFAILURE',CDERR_DIALOGFAILURE);
    AddConstant('CDERR_GENERALCODES',CDERR_GENERALCODES);
    AddConstant('CDERR_STRUCTSIZE',CDERR_STRUCTSIZE);
    AddConstant('CDERR_INITIALIZATION',CDERR_INITIALIZATION);
    AddConstant('CDERR_NOTEMPLATE',CDERR_NOTEMPLATE);
    AddConstant('CDERR_NOHINSTANCE',CDERR_NOHINSTANCE);
    AddConstant('CDERR_LOADSTRFAILURE',CDERR_LOADSTRFAILURE);
    AddConstant('CDERR_FINDRESFAILURE',CDERR_FINDRESFAILURE);
    AddConstant('CDERR_LOADRESFAILURE',CDERR_LOADRESFAILURE);
    AddConstant('CDERR_LOCKRESFAILURE',CDERR_LOCKRESFAILURE);
    AddConstant('CDERR_MEMALLOCFAILURE',CDERR_MEMALLOCFAILURE);
    AddConstant('CDERR_MEMLOCKFAILURE',CDERR_MEMLOCKFAILURE);
    AddConstant('CDERR_NOHOOK',CDERR_NOHOOK);
    AddConstant('CDERR_REGISTERMSGFAIL',CDERR_REGISTERMSGFAIL);
    AddConstant('PDERR_PRINTERCODES',PDERR_PRINTERCODES);
    AddConstant('PDERR_SETUPFAILURE',PDERR_SETUPFAILURE);
    AddConstant('PDERR_PARSEFAILURE',PDERR_PARSEFAILURE);
    AddConstant('PDERR_RETDEFFAILURE',PDERR_RETDEFFAILURE);
    AddConstant('PDERR_LOADDRVFAILURE',PDERR_LOADDRVFAILURE);
    AddConstant('PDERR_GETDEVMODEFAIL',PDERR_GETDEVMODEFAIL);
    AddConstant('PDERR_INITFAILURE',PDERR_INITFAILURE);
    AddConstant('PDERR_NODEVICES',PDERR_NODEVICES);
    AddConstant('PDERR_NODEFAULTPRN',PDERR_NODEFAULTPRN);
    AddConstant('PDERR_DNDMMISMATCH',PDERR_DNDMMISMATCH);
    AddConstant('PDERR_CREATEICFAILURE',PDERR_CREATEICFAILURE);
    AddConstant('PDERR_PRINTERNOTFOUND',PDERR_PRINTERNOTFOUND);
    AddConstant('PDERR_DEFAULTDIFFERENT',PDERR_DEFAULTDIFFERENT);
    AddConstant('CFERR_CHOOSEFONTCODES',CFERR_CHOOSEFONTCODES);
    AddConstant('CFERR_NOFONTS',CFERR_NOFONTS);
    AddConstant('CFERR_MAXLESSTHANMIN',CFERR_MAXLESSTHANMIN);
    AddConstant('FNERR_FILENAMECODES',FNERR_FILENAMECODES);
    AddConstant('FNERR_SUBCLASSFAILURE',FNERR_SUBCLASSFAILURE);
    AddConstant('FNERR_INVALIDFILENAME',FNERR_INVALIDFILENAME);
    AddConstant('FNERR_BUFFERTOOSMALL',FNERR_BUFFERTOOSMALL);
    AddConstant('FRERR_FINDREPLACECODES',FRERR_FINDREPLACECODES);
    AddConstant('FRERR_BUFFERLENGTHZERO',FRERR_BUFFERLENGTHZERO);
    AddConstant('CCERR_CHOOSECOLORCODES',CCERR_CHOOSECOLORCODES);
  end;
end;

class function TatCommDlgLibrary.LibraryName: string;
begin
  result := 'CommDlg';
end;

initialization
  RegisterScripterLibrary(TatCommDlgLibrary, True);

{$WARNINGS ON}

end.

