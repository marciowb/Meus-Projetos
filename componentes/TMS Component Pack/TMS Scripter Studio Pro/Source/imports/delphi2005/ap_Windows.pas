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
unit ap_Windows;

interface

uses
  Types,
  Windows,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatWindowsLibrary = class(TatScripterLibrary)
    procedure __GetCurrentTime(AMachine: TatVirtualMachine);
    procedure __FreeModule(AMachine: TatVirtualMachine);
    procedure __InterlockedCompareExchange(AMachine: TatVirtualMachine);
    procedure __InterlockedExchangeAdd(AMachine: TatVirtualMachine);
    procedure __FreeLibrary(AMachine: TatVirtualMachine);
    procedure __GetVersion(AMachine: TatVirtualMachine);
    procedure __ExitProcess(AMachine: TatVirtualMachine);
    procedure __ExitThread(AMachine: TatVirtualMachine);
    procedure __LockFile(AMachine: TatVirtualMachine);
    procedure __UnlockFile(AMachine: TatVirtualMachine);
    procedure __GetFileType(AMachine: TatVirtualMachine);
    procedure __FindClose(AMachine: TatVirtualMachine);
    procedure __CloseHandle(AMachine: TatVirtualMachine);
    procedure __FileTimeToLocalFileTime(AMachine: TatVirtualMachine);
    procedure __FileTimeToSystemTime(AMachine: TatVirtualMachine);
    procedure __FileTimeToDosDateTime(AMachine: TatVirtualMachine);
    procedure __GetTickCount(AMachine: TatVirtualMachine);
    procedure __OpenFile(AMachine: TatVirtualMachine);
    procedure __LoadLibrary(AMachine: TatVirtualMachine);
    procedure __GetCommandLine(AMachine: TatVirtualMachine);
    procedure __FindResource(AMachine: TatVirtualMachine);
    procedure __SetCurrentDirectory(AMachine: TatVirtualMachine);
    procedure __GetCurrentDirectory(AMachine: TatVirtualMachine);
    procedure __RemoveDirectory(AMachine: TatVirtualMachine);
    procedure __GetFileAttributes(AMachine: TatVirtualMachine);
    procedure __DeleteFile(AMachine: TatVirtualMachine);
    procedure __FindFirstFile(AMachine: TatVirtualMachine);
    procedure __FindNextFile(AMachine: TatVirtualMachine);
    procedure __CopyFile(AMachine: TatVirtualMachine);
    procedure __MoveFile(AMachine: TatVirtualMachine);
    procedure __AdjustTokenPrivileges(AMachine: TatVirtualMachine);
    procedure __CopyMetaFile(AMachine: TatVirtualMachine);
    procedure __CopyEnhMetaFile(AMachine: TatVirtualMachine);
    procedure __EndPath(AMachine: TatVirtualMachine);
    procedure __OffsetViewportOrgEx(AMachine: TatVirtualMachine);
    procedure __OffsetWindowOrgEx(AMachine: TatVirtualMachine);
    procedure __ExitWindows(AMachine: TatVirtualMachine);
    procedure __FlashWindow(AMachine: TatVirtualMachine);
    procedure __CloseWindow(AMachine: TatVirtualMachine);
    procedure __EndDialog(AMachine: TatVirtualMachine);
    procedure __OpenClipboard(AMachine: TatVirtualMachine);
    procedure __CloseClipboard(AMachine: TatVirtualMachine);
    procedure __GetClipboardFormatName(AMachine: TatVirtualMachine);
    procedure __CharToOem(AMachine: TatVirtualMachine);
    procedure __CharToOemA(AMachine: TatVirtualMachine);
    procedure __CharToOemW(AMachine: TatVirtualMachine);
    procedure __OemToChar(AMachine: TatVirtualMachine);
    procedure __CharToOemBuff(AMachine: TatVirtualMachine);
    procedure __CharToOemBuffA(AMachine: TatVirtualMachine);
    procedure __CharToOemBuffW(AMachine: TatVirtualMachine);
    procedure __CharUpper(AMachine: TatVirtualMachine);
    procedure __CharUpperA(AMachine: TatVirtualMachine);
    procedure __CharUpperW(AMachine: TatVirtualMachine);
    procedure __CharUpperBuff(AMachine: TatVirtualMachine);
    procedure __CharUpperBuffA(AMachine: TatVirtualMachine);
    procedure __CharUpperBuffW(AMachine: TatVirtualMachine);
    procedure __CharLower(AMachine: TatVirtualMachine);
    procedure __CharLowerA(AMachine: TatVirtualMachine);
    procedure __CharLowerW(AMachine: TatVirtualMachine);
    procedure __CharLowerBuff(AMachine: TatVirtualMachine);
    procedure __CharLowerBuffA(AMachine: TatVirtualMachine);
    procedure __CharLowerBuffW(AMachine: TatVirtualMachine);
    procedure __CharNext(AMachine: TatVirtualMachine);
    procedure __CharNextA(AMachine: TatVirtualMachine);
    procedure __CharNextW(AMachine: TatVirtualMachine);
    procedure __CharPrev(AMachine: TatVirtualMachine);
    procedure __CharPrevA(AMachine: TatVirtualMachine);
    procedure __CharPrevW(AMachine: TatVirtualMachine);
    procedure __CharNextExA(AMachine: TatVirtualMachine);
    procedure __CharNextEx(AMachine: TatVirtualMachine);
    procedure __CharPrevEx(AMachine: TatVirtualMachine);
    procedure __CharPrevExA(AMachine: TatVirtualMachine);
    procedure __AnsiToOem(AMachine: TatVirtualMachine);
    procedure __OemToAnsi(AMachine: TatVirtualMachine);
    procedure __AnsiToOemBuff(AMachine: TatVirtualMachine);
    procedure __AnsiUpper(AMachine: TatVirtualMachine);
    procedure __AnsiUpperBuff(AMachine: TatVirtualMachine);
    procedure __AnsiLower(AMachine: TatVirtualMachine);
    procedure __AnsiLowerBuff(AMachine: TatVirtualMachine);
    procedure __AnsiNext(AMachine: TatVirtualMachine);
    procedure __AnsiPrev(AMachine: TatVirtualMachine);
    procedure __GetWindowDC(AMachine: TatVirtualMachine);
    procedure __MessageBox(AMachine: TatVirtualMachine);
    procedure __MessageBoxEx(AMachine: TatVirtualMachine);
    procedure __MessageBeep(AMachine: TatVirtualMachine);
    procedure __GetCaretPos(AMachine: TatVirtualMachine);
    procedure __ClientToScreen(AMachine: TatVirtualMachine);
    procedure __ScreenToClient(AMachine: TatVirtualMachine);
    procedure __FrameRect(AMachine: TatVirtualMachine);
    procedure __CopyRect(AMachine: TatVirtualMachine);
    procedure __FindWindow(AMachine: TatVirtualMachine);
    procedure __GetWindowThreadProcessId(AMachine: TatVirtualMachine);
    procedure __CopyImage(AMachine: TatVirtualMachine);
    procedure __CopyIcon(AMachine: TatVirtualMachine);
    procedure __LoadString(AMachine: TatVirtualMachine);
    procedure __HtmlHelp(AMachine: TatVirtualMachine);
    procedure __HtmlHelpA(AMachine: TatVirtualMachine);
    procedure __HtmlHelpW(AMachine: TatVirtualMachine);
    procedure __FoldString(AMachine: TatVirtualMachine);
    procedure __RegOverridePredefKey(AMachine: TatVirtualMachine);
    procedure __RegOpenUserClassesRoot(AMachine: TatVirtualMachine);
    procedure __RegOpenCurrentUser(AMachine: TatVirtualMachine);
    procedure __RegDisablePredefinedCache(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _LARGE_INTEGERWrapper = class(TatRecordWrapper)
  private
    FLowPart: DWORD;
    FHighPart: Longint;
    FQuadPart: LONGLONG;
  public
    constructor Create(ARecord: _LARGE_INTEGER);
    function ObjToRec: _LARGE_INTEGER;
  published
    property LowPart: DWORD read FLowPart write FLowPart;
    property HighPart: Longint read FHighPart write FHighPart;
    property QuadPart: LONGLONG read FQuadPart write FQuadPart;
  end;
  
  ULARGE_INTEGERWrapper = class(TatRecordWrapper)
  private
    FLowPart: DWORD;
    FHighPart: DWORD;
    FQuadPart: LONGLONG;
  public
    constructor Create(ARecord: ULARGE_INTEGER);
    function ObjToRec: ULARGE_INTEGER;
  published
    property LowPart: DWORD read FLowPart write FLowPart;
    property HighPart: DWORD read FHighPart write FHighPart;
    property QuadPart: LONGLONG read FQuadPart write FQuadPart;
  end;
  
  _LIST_ENTRYWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _LIST_ENTRY);
    function ObjToRec: _LIST_ENTRY;
  published
  end;
  
  _FLOATING_SAVE_AREAWrapper = class(TatRecordWrapper)
  private
    FControlWord: DWORD;
    FStatusWord: DWORD;
    FTagWord: DWORD;
    FErrorOffset: DWORD;
    FErrorSelector: DWORD;
    FDataOffset: DWORD;
    FDataSelector: DWORD;
    FCr0NpxState: DWORD;
  public
    constructor Create(ARecord: _FLOATING_SAVE_AREA);
    function ObjToRec: _FLOATING_SAVE_AREA;
  published
    property ControlWord: DWORD read FControlWord write FControlWord;
    property StatusWord: DWORD read FStatusWord write FStatusWord;
    property TagWord: DWORD read FTagWord write FTagWord;
    property ErrorOffset: DWORD read FErrorOffset write FErrorOffset;
    property ErrorSelector: DWORD read FErrorSelector write FErrorSelector;
    property DataOffset: DWORD read FDataOffset write FDataOffset;
    property DataSelector: DWORD read FDataSelector write FDataSelector;
    property Cr0NpxState: DWORD read FCr0NpxState write FCr0NpxState;
  end;
  
  _CONTEXTWrapper = class(TatRecordWrapper)
  private
    FContextFlags: DWORD;
    FDr0: DWORD;
    FDr1: DWORD;
    FDr2: DWORD;
    FDr3: DWORD;
    FDr6: DWORD;
    FDr7: DWORD;
    FSegGs: DWORD;
    FSegFs: DWORD;
    FSegEs: DWORD;
    FSegDs: DWORD;
    FEdi: DWORD;
    FEsi: DWORD;
    FEbx: DWORD;
    FEdx: DWORD;
    FEcx: DWORD;
    FEax: DWORD;
    FEbp: DWORD;
    FEip: DWORD;
    FSegCs: DWORD;
    FEFlags: DWORD;
    FEsp: DWORD;
    FSegSs: DWORD;
  public
    constructor Create(ARecord: _CONTEXT);
    function ObjToRec: _CONTEXT;
  published
    property ContextFlags: DWORD read FContextFlags write FContextFlags;
    property Dr0: DWORD read FDr0 write FDr0;
    property Dr1: DWORD read FDr1 write FDr1;
    property Dr2: DWORD read FDr2 write FDr2;
    property Dr3: DWORD read FDr3 write FDr3;
    property Dr6: DWORD read FDr6 write FDr6;
    property Dr7: DWORD read FDr7 write FDr7;
    property SegGs: DWORD read FSegGs write FSegGs;
    property SegFs: DWORD read FSegFs write FSegFs;
    property SegEs: DWORD read FSegEs write FSegEs;
    property SegDs: DWORD read FSegDs write FSegDs;
    property Edi: DWORD read FEdi write FEdi;
    property Esi: DWORD read FEsi write FEsi;
    property Ebx: DWORD read FEbx write FEbx;
    property Edx: DWORD read FEdx write FEdx;
    property Ecx: DWORD read FEcx write FEcx;
    property Eax: DWORD read FEax write FEax;
    property Ebp: DWORD read FEbp write FEbp;
    property Eip: DWORD read FEip write FEip;
    property SegCs: DWORD read FSegCs write FSegCs;
    property EFlags: DWORD read FEFlags write FEFlags;
    property Esp: DWORD read FEsp write FEsp;
    property SegSs: DWORD read FSegSs write FSegSs;
  end;
  
  _LDT_ENTRYWrapper = class(TatRecordWrapper)
  private
    FLimitLow: Word;
    FBaseLow: Word;
    FBaseMid: Byte;
    FFlags1: Byte;
    FFlags2: Byte;
    FBaseHi: Byte;
    FFlags: Longint;
  public
    constructor Create(ARecord: _LDT_ENTRY);
    function ObjToRec: _LDT_ENTRY;
  published
    property LimitLow: Word read FLimitLow write FLimitLow;
    property BaseLow: Word read FBaseLow write FBaseLow;
    property BaseMid: Byte read FBaseMid write FBaseMid;
    property Flags1: Byte read FFlags1 write FFlags1;
    property Flags2: Byte read FFlags2 write FFlags2;
    property BaseHi: Byte read FBaseHi write FBaseHi;
    property Flags: Longint read FFlags write FFlags;
  end;
  
  _EXCEPTION_RECORDWrapper = class(TatRecordWrapper)
  private
    FExceptionCode: DWORD;
    FExceptionFlags: DWORD;
    FNumberParameters: DWORD;
  public
    constructor Create(ARecord: _EXCEPTION_RECORD);
    function ObjToRec: _EXCEPTION_RECORD;
  published
    property ExceptionCode: DWORD read FExceptionCode write FExceptionCode;
    property ExceptionFlags: DWORD read FExceptionFlags write FExceptionFlags;
    property NumberParameters: DWORD read FNumberParameters write FNumberParameters;
  end;
  
  _EXCEPTION_POINTERSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _EXCEPTION_POINTERS);
    function ObjToRec: _EXCEPTION_POINTERS;
  published
  end;
  
  _MEMORY_BASIC_INFORMATIONWrapper = class(TatRecordWrapper)
  private
    FAllocationProtect: DWORD;
    FRegionSize: DWORD;
    FState: DWORD;
    FProtect: DWORD;
    FType_9: DWORD;
  public
    constructor Create(ARecord: _MEMORY_BASIC_INFORMATION);
    function ObjToRec: _MEMORY_BASIC_INFORMATION;
  published
    property AllocationProtect: DWORD read FAllocationProtect write FAllocationProtect;
    property RegionSize: DWORD read FRegionSize write FRegionSize;
    property State: DWORD read FState write FState;
    property Protect: DWORD read FProtect write FProtect;
    property Type_9: DWORD read FType_9 write FType_9;
  end;
  
  _GENERIC_MAPPINGWrapper = class(TatRecordWrapper)
  private
    FGenericRead: ACCESS_MASK;
    FGenericWrite: ACCESS_MASK;
    FGenericExecute: ACCESS_MASK;
    FGenericAll: ACCESS_MASK;
  public
    constructor Create(ARecord: _GENERIC_MAPPING);
    function ObjToRec: _GENERIC_MAPPING;
  published
    property GenericRead: ACCESS_MASK read FGenericRead write FGenericRead;
    property GenericWrite: ACCESS_MASK read FGenericWrite write FGenericWrite;
    property GenericExecute: ACCESS_MASK read FGenericExecute write FGenericExecute;
    property GenericAll: ACCESS_MASK read FGenericAll write FGenericAll;
  end;
  
  _LUID_AND_ATTRIBUTESWrapper = class(TatRecordWrapper)
  private
    FLuid: TLargeInteger;
    FAttributes: DWORD;
  public
    constructor Create(ARecord: _LUID_AND_ATTRIBUTES);
    function ObjToRec: _LUID_AND_ATTRIBUTES;
  published
    property Luid: TLargeInteger read FLuid write FLuid;
    property Attributes: DWORD read FAttributes write FAttributes;
  end;
  
  _SID_IDENTIFIER_AUTHORITYWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _SID_IDENTIFIER_AUTHORITY);
    function ObjToRec: _SID_IDENTIFIER_AUTHORITY;
  published
  end;
  
  _SID_AND_ATTRIBUTESWrapper = class(TatRecordWrapper)
  private
    FAttributes: DWORD;
  public
    constructor Create(ARecord: _SID_AND_ATTRIBUTES);
    function ObjToRec: _SID_AND_ATTRIBUTES;
  published
    property Attributes: DWORD read FAttributes write FAttributes;
  end;
  
  _ACLWrapper = class(TatRecordWrapper)
  private
    FAclRevision: Byte;
    FSbz1: Byte;
    FAclSize: Word;
    FAceCount: Word;
    FSbz2: Word;
  public
    constructor Create(ARecord: _ACL);
    function ObjToRec: _ACL;
  published
    property AclRevision: Byte read FAclRevision write FAclRevision;
    property Sbz1: Byte read FSbz1 write FSbz1;
    property AclSize: Word read FAclSize write FAclSize;
    property AceCount: Word read FAceCount write FAceCount;
    property Sbz2: Word read FSbz2 write FSbz2;
  end;
  
  _SECURITY_DESCRIPTORWrapper = class(TatRecordWrapper)
  private
    FRevision: Byte;
    FSbz1: Byte;
    FControl: SECURITY_DESCRIPTOR_CONTROL;
  public
    constructor Create(ARecord: _SECURITY_DESCRIPTOR);
    function ObjToRec: _SECURITY_DESCRIPTOR;
  published
    property Revision: Byte read FRevision write FRevision;
    property Sbz1: Byte read FSbz1 write FSbz1;
    property Control: SECURITY_DESCRIPTOR_CONTROL read FControl write FControl;
  end;
  
  _OBJECT_TYPE_LISTWrapper = class(TatRecordWrapper)
  private
    FLevel: WORD;
    FSbz: WORD;
  public
    constructor Create(ARecord: _OBJECT_TYPE_LIST);
    function ObjToRec: _OBJECT_TYPE_LIST;
  published
    property Level: WORD read FLevel write FLevel;
    property Sbz: WORD read FSbz write FSbz;
  end;
  
  _PRIVILEGE_SETWrapper = class(TatRecordWrapper)
  private
    FPrivilegeCount: DWORD;
    FControl: DWORD;
  public
    constructor Create(ARecord: _PRIVILEGE_SET);
    function ObjToRec: _PRIVILEGE_SET;
  published
    property PrivilegeCount: DWORD read FPrivilegeCount write FPrivilegeCount;
    property Control: DWORD read FControl write FControl;
  end;
  
  _TOKEN_GROUPSWrapper = class(TatRecordWrapper)
  private
    FGroupCount: DWORD;
  public
    constructor Create(ARecord: _TOKEN_GROUPS);
    function ObjToRec: _TOKEN_GROUPS;
  published
    property GroupCount: DWORD read FGroupCount write FGroupCount;
  end;
  
  _TOKEN_PRIVILEGESWrapper = class(TatRecordWrapper)
  private
    FPrivilegeCount: DWORD;
  public
    constructor Create(ARecord: _TOKEN_PRIVILEGES);
    function ObjToRec: _TOKEN_PRIVILEGES;
  published
    property PrivilegeCount: DWORD read FPrivilegeCount write FPrivilegeCount;
  end;
  
  _SECURITY_QUALITY_OF_SERVICEWrapper = class(TatRecordWrapper)
  private
    FLength: DWORD;
    FImpersonationLevel: TSecurityImpersonationLevel;
    FContextTrackingMode: SECURITY_CONTEXT_TRACKING_MODE;
    FEffectiveOnly: Boolean;
  public
    constructor Create(ARecord: _SECURITY_QUALITY_OF_SERVICE);
    function ObjToRec: _SECURITY_QUALITY_OF_SERVICE;
  published
    property Length: DWORD read FLength write FLength;
    property ImpersonationLevel: TSecurityImpersonationLevel read FImpersonationLevel write FImpersonationLevel;
    property ContextTrackingMode: SECURITY_CONTEXT_TRACKING_MODE read FContextTrackingMode write FContextTrackingMode;
    property EffectiveOnly: Boolean read FEffectiveOnly write FEffectiveOnly;
  end;
  
  _IMAGE_DOS_HEADERWrapper = class(TatRecordWrapper)
  private
    Fe_magic: Word;
    Fe_cblp: Word;
    Fe_cp: Word;
    Fe_crlc: Word;
    Fe_cparhdr: Word;
    Fe_minalloc: Word;
    Fe_maxalloc: Word;
    Fe_ss: Word;
    Fe_sp: Word;
    Fe_csum: Word;
    Fe_ip: Word;
    Fe_cs: Word;
    Fe_lfarlc: Word;
    Fe_ovno: Word;
    Fe_oemid: Word;
    Fe_oeminfo: Word;
    F_lfanew: LongInt;
  public
    constructor Create(ARecord: _IMAGE_DOS_HEADER);
    function ObjToRec: _IMAGE_DOS_HEADER;
  published
    property e_magic: Word read Fe_magic write Fe_magic;
    property e_cblp: Word read Fe_cblp write Fe_cblp;
    property e_cp: Word read Fe_cp write Fe_cp;
    property e_crlc: Word read Fe_crlc write Fe_crlc;
    property e_cparhdr: Word read Fe_cparhdr write Fe_cparhdr;
    property e_minalloc: Word read Fe_minalloc write Fe_minalloc;
    property e_maxalloc: Word read Fe_maxalloc write Fe_maxalloc;
    property e_ss: Word read Fe_ss write Fe_ss;
    property e_sp: Word read Fe_sp write Fe_sp;
    property e_csum: Word read Fe_csum write Fe_csum;
    property e_ip: Word read Fe_ip write Fe_ip;
    property e_cs: Word read Fe_cs write Fe_cs;
    property e_lfarlc: Word read Fe_lfarlc write Fe_lfarlc;
    property e_ovno: Word read Fe_ovno write Fe_ovno;
    property e_oemid: Word read Fe_oemid write Fe_oemid;
    property e_oeminfo: Word read Fe_oeminfo write Fe_oeminfo;
    property _lfanew: LongInt read F_lfanew write F_lfanew;
  end;
  
  _IMAGE_FILE_HEADERWrapper = class(TatRecordWrapper)
  private
    FMachine: Word;
    FNumberOfSections: Word;
    FTimeDateStamp: DWORD;
    FPointerToSymbolTable: DWORD;
    FNumberOfSymbols: DWORD;
    FSizeOfOptionalHeader: Word;
    FCharacteristics: Word;
  public
    constructor Create(ARecord: _IMAGE_FILE_HEADER);
    function ObjToRec: _IMAGE_FILE_HEADER;
  published
    property Machine: Word read FMachine write FMachine;
    property NumberOfSections: Word read FNumberOfSections write FNumberOfSections;
    property TimeDateStamp: DWORD read FTimeDateStamp write FTimeDateStamp;
    property PointerToSymbolTable: DWORD read FPointerToSymbolTable write FPointerToSymbolTable;
    property NumberOfSymbols: DWORD read FNumberOfSymbols write FNumberOfSymbols;
    property SizeOfOptionalHeader: Word read FSizeOfOptionalHeader write FSizeOfOptionalHeader;
    property Characteristics: Word read FCharacteristics write FCharacteristics;
  end;
  
  _IMAGE_EXPORT_DIRECTORYWrapper = class(TatRecordWrapper)
  private
    FCharacteristics: DWord;
    FTimeDateStamp: DWord;
    FMajorVersion: Word;
    FMinorVersion: Word;
    FName: DWord;
    FBase: DWord;
    FNumberOfFunctions: DWord;
    FNumberOfNames: DWord;
  public
    constructor Create(ARecord: _IMAGE_EXPORT_DIRECTORY);
    function ObjToRec: _IMAGE_EXPORT_DIRECTORY;
  published
    property Characteristics: DWord read FCharacteristics write FCharacteristics;
    property TimeDateStamp: DWord read FTimeDateStamp write FTimeDateStamp;
    property MajorVersion: Word read FMajorVersion write FMajorVersion;
    property MinorVersion: Word read FMinorVersion write FMinorVersion;
    property Name: DWord read FName write FName;
    property Base: DWord read FBase write FBase;
    property NumberOfFunctions: DWord read FNumberOfFunctions write FNumberOfFunctions;
    property NumberOfNames: DWord read FNumberOfNames write FNumberOfNames;
  end;
  
  _IMAGE_DATA_DIRECTORYWrapper = class(TatRecordWrapper)
  private
    FVirtualAddress: DWORD;
    FSize: DWORD;
  public
    constructor Create(ARecord: _IMAGE_DATA_DIRECTORY);
    function ObjToRec: _IMAGE_DATA_DIRECTORY;
  published
    property VirtualAddress: DWORD read FVirtualAddress write FVirtualAddress;
    property Size: DWORD read FSize write FSize;
  end;
  
  _IMAGE_OPTIONAL_HEADERWrapper = class(TatRecordWrapper)
  private
    FMagic: Word;
    FMajorLinkerVersion: Byte;
    FMinorLinkerVersion: Byte;
    FSizeOfCode: DWORD;
    FSizeOfInitializedData: DWORD;
    FSizeOfUninitializedData: DWORD;
    FAddressOfEntryPoint: DWORD;
    FBaseOfCode: DWORD;
    FBaseOfData: DWORD;
    FImageBase: DWORD;
    FSectionAlignment: DWORD;
    FFileAlignment: DWORD;
    FMajorOperatingSystemVersion: Word;
    FMinorOperatingSystemVersion: Word;
    FMajorImageVersion: Word;
    FMinorImageVersion: Word;
    FMajorSubsystemVersion: Word;
    FMinorSubsystemVersion: Word;
    FWin32VersionValue: DWORD;
    FSizeOfImage: DWORD;
    FSizeOfHeaders: DWORD;
    FCheckSum: DWORD;
    FSubsystem: Word;
    FDllCharacteristics: Word;
    FSizeOfStackReserve: DWORD;
    FSizeOfStackCommit: DWORD;
    FSizeOfHeapReserve: DWORD;
    FSizeOfHeapCommit: DWORD;
    FLoaderFlags: DWORD;
    FNumberOfRvaAndSizes: DWORD;
  public
    constructor Create(ARecord: _IMAGE_OPTIONAL_HEADER);
    function ObjToRec: _IMAGE_OPTIONAL_HEADER;
  published
    property Magic: Word read FMagic write FMagic;
    property MajorLinkerVersion: Byte read FMajorLinkerVersion write FMajorLinkerVersion;
    property MinorLinkerVersion: Byte read FMinorLinkerVersion write FMinorLinkerVersion;
    property SizeOfCode: DWORD read FSizeOfCode write FSizeOfCode;
    property SizeOfInitializedData: DWORD read FSizeOfInitializedData write FSizeOfInitializedData;
    property SizeOfUninitializedData: DWORD read FSizeOfUninitializedData write FSizeOfUninitializedData;
    property AddressOfEntryPoint: DWORD read FAddressOfEntryPoint write FAddressOfEntryPoint;
    property BaseOfCode: DWORD read FBaseOfCode write FBaseOfCode;
    property BaseOfData: DWORD read FBaseOfData write FBaseOfData;
    property ImageBase: DWORD read FImageBase write FImageBase;
    property SectionAlignment: DWORD read FSectionAlignment write FSectionAlignment;
    property FileAlignment: DWORD read FFileAlignment write FFileAlignment;
    property MajorOperatingSystemVersion: Word read FMajorOperatingSystemVersion write FMajorOperatingSystemVersion;
    property MinorOperatingSystemVersion: Word read FMinorOperatingSystemVersion write FMinorOperatingSystemVersion;
    property MajorImageVersion: Word read FMajorImageVersion write FMajorImageVersion;
    property MinorImageVersion: Word read FMinorImageVersion write FMinorImageVersion;
    property MajorSubsystemVersion: Word read FMajorSubsystemVersion write FMajorSubsystemVersion;
    property MinorSubsystemVersion: Word read FMinorSubsystemVersion write FMinorSubsystemVersion;
    property Win32VersionValue: DWORD read FWin32VersionValue write FWin32VersionValue;
    property SizeOfImage: DWORD read FSizeOfImage write FSizeOfImage;
    property SizeOfHeaders: DWORD read FSizeOfHeaders write FSizeOfHeaders;
    property CheckSum: DWORD read FCheckSum write FCheckSum;
    property Subsystem: Word read FSubsystem write FSubsystem;
    property DllCharacteristics: Word read FDllCharacteristics write FDllCharacteristics;
    property SizeOfStackReserve: DWORD read FSizeOfStackReserve write FSizeOfStackReserve;
    property SizeOfStackCommit: DWORD read FSizeOfStackCommit write FSizeOfStackCommit;
    property SizeOfHeapReserve: DWORD read FSizeOfHeapReserve write FSizeOfHeapReserve;
    property SizeOfHeapCommit: DWORD read FSizeOfHeapCommit write FSizeOfHeapCommit;
    property LoaderFlags: DWORD read FLoaderFlags write FLoaderFlags;
    property NumberOfRvaAndSizes: DWORD read FNumberOfRvaAndSizes write FNumberOfRvaAndSizes;
  end;
  
  _IMAGE_ROM_OPTIONAL_HEADERWrapper = class(TatRecordWrapper)
  private
    FMagic: Word;
    FMajorLinkerVersion: Byte;
    FMinorLinkerVersion: Byte;
    FSizeOfCode: DWORD;
    FSizeOfInitializedData: DWORD;
    FSizeOfUninitializedData: DWORD;
    FAddressOfEntryPoint: DWORD;
    FBaseOfCode: DWORD;
    FBaseOfData: DWORD;
    FBaseOfBss: DWORD;
    FGprMask: DWORD;
    FGpValue: DWORD;
  public
    constructor Create(ARecord: _IMAGE_ROM_OPTIONAL_HEADER);
    function ObjToRec: _IMAGE_ROM_OPTIONAL_HEADER;
  published
    property Magic: Word read FMagic write FMagic;
    property MajorLinkerVersion: Byte read FMajorLinkerVersion write FMajorLinkerVersion;
    property MinorLinkerVersion: Byte read FMinorLinkerVersion write FMinorLinkerVersion;
    property SizeOfCode: DWORD read FSizeOfCode write FSizeOfCode;
    property SizeOfInitializedData: DWORD read FSizeOfInitializedData write FSizeOfInitializedData;
    property SizeOfUninitializedData: DWORD read FSizeOfUninitializedData write FSizeOfUninitializedData;
    property AddressOfEntryPoint: DWORD read FAddressOfEntryPoint write FAddressOfEntryPoint;
    property BaseOfCode: DWORD read FBaseOfCode write FBaseOfCode;
    property BaseOfData: DWORD read FBaseOfData write FBaseOfData;
    property BaseOfBss: DWORD read FBaseOfBss write FBaseOfBss;
    property GprMask: DWORD read FGprMask write FGprMask;
    property GpValue: DWORD read FGpValue write FGpValue;
  end;
  
  _IMAGE_NT_HEADERSWrapper = class(TatRecordWrapper)
  private
    FSignature: DWORD;
  public
    constructor Create(ARecord: _IMAGE_NT_HEADERS);
    function ObjToRec: _IMAGE_NT_HEADERS;
  published
    property Signature: DWORD read FSignature write FSignature;
  end;
  
  _IMAGE_ROM_HEADERSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _IMAGE_ROM_HEADERS);
    function ObjToRec: _IMAGE_ROM_HEADERS;
  published
  end;
  
  TISHMiscWrapper = class(TatRecordWrapper)
  private
    FPhysicalAddress: DWORD;
    FVirtualSize: DWORD;
  public
    constructor Create(ARecord: TISHMisc);
    function ObjToRec: TISHMisc;
  published
    property PhysicalAddress: DWORD read FPhysicalAddress write FPhysicalAddress;
    property VirtualSize: DWORD read FVirtualSize write FVirtualSize;
  end;
  
  _IMAGE_SECTION_HEADERWrapper = class(TatRecordWrapper)
  private
    FVirtualAddress: DWORD;
    FSizeOfRawData: DWORD;
    FPointerToRawData: DWORD;
    FPointerToRelocations: DWORD;
    FPointerToLinenumbers: DWORD;
    FNumberOfRelocations: Word;
    FNumberOfLinenumbers: Word;
    FCharacteristics: DWORD;
  public
    constructor Create(ARecord: _IMAGE_SECTION_HEADER);
    function ObjToRec: _IMAGE_SECTION_HEADER;
  published
    property VirtualAddress: DWORD read FVirtualAddress write FVirtualAddress;
    property SizeOfRawData: DWORD read FSizeOfRawData write FSizeOfRawData;
    property PointerToRawData: DWORD read FPointerToRawData write FPointerToRawData;
    property PointerToRelocations: DWORD read FPointerToRelocations write FPointerToRelocations;
    property PointerToLinenumbers: DWORD read FPointerToLinenumbers write FPointerToLinenumbers;
    property NumberOfRelocations: Word read FNumberOfRelocations write FNumberOfRelocations;
    property NumberOfLinenumbers: Word read FNumberOfLinenumbers write FNumberOfLinenumbers;
    property Characteristics: DWORD read FCharacteristics write FCharacteristics;
  end;
  
  IMAGE_LOAD_CONFIG_DIRECTORYWrapper = class(TatRecordWrapper)
  private
    FCharacteristics: DWORD;
    FTimeDateStamp: DWORD;
    FMajorVersion: Word;
    FMinorVersion: Word;
    FGlobalFlagsClear: DWORD;
    FGlobalFlagsSet: DWORD;
    FCriticalSectionDefaultTimeout: DWORD;
    FDeCommitFreeBlockThreshold: DWORD;
    FDeCommitTotalFreeThreshold: DWORD;
    FMaximumAllocationSize: DWORD;
    FVirtualMemoryThreshold: DWORD;
    FProcessHeapFlags: DWORD;
    FProcessAffinityMask: DWORD;
  public
    constructor Create(ARecord: IMAGE_LOAD_CONFIG_DIRECTORY);
    function ObjToRec: IMAGE_LOAD_CONFIG_DIRECTORY;
  published
    property Characteristics: DWORD read FCharacteristics write FCharacteristics;
    property TimeDateStamp: DWORD read FTimeDateStamp write FTimeDateStamp;
    property MajorVersion: Word read FMajorVersion write FMajorVersion;
    property MinorVersion: Word read FMinorVersion write FMinorVersion;
    property GlobalFlagsClear: DWORD read FGlobalFlagsClear write FGlobalFlagsClear;
    property GlobalFlagsSet: DWORD read FGlobalFlagsSet write FGlobalFlagsSet;
    property CriticalSectionDefaultTimeout: DWORD read FCriticalSectionDefaultTimeout write FCriticalSectionDefaultTimeout;
    property DeCommitFreeBlockThreshold: DWORD read FDeCommitFreeBlockThreshold write FDeCommitFreeBlockThreshold;
    property DeCommitTotalFreeThreshold: DWORD read FDeCommitTotalFreeThreshold write FDeCommitTotalFreeThreshold;
    property MaximumAllocationSize: DWORD read FMaximumAllocationSize write FMaximumAllocationSize;
    property VirtualMemoryThreshold: DWORD read FVirtualMemoryThreshold write FVirtualMemoryThreshold;
    property ProcessHeapFlags: DWORD read FProcessHeapFlags write FProcessHeapFlags;
    property ProcessAffinityMask: DWORD read FProcessAffinityMask write FProcessAffinityMask;
  end;
  
  IMAGE_RUNTIME_FUNCTION_ENTRYWrapper = class(TatRecordWrapper)
  private
    FBeginAddress: DWORD;
    FEndAddress: DWORD;
    FPrologEndAddress: DWORD;
  public
    constructor Create(ARecord: IMAGE_RUNTIME_FUNCTION_ENTRY);
    function ObjToRec: IMAGE_RUNTIME_FUNCTION_ENTRY;
  published
    property BeginAddress: DWORD read FBeginAddress write FBeginAddress;
    property EndAddress: DWORD read FEndAddress write FEndAddress;
    property PrologEndAddress: DWORD read FPrologEndAddress write FPrologEndAddress;
  end;
  
  _IMAGE_DEBUG_DIRECTORYWrapper = class(TatRecordWrapper)
  private
    FCharacteristics: DWORD;
    FTimeDateStamp: DWORD;
    FMajorVersion: Word;
    FMinorVersion: Word;
    F_Type: DWORD;
    FSizeOfData: DWORD;
    FAddressOfRawData: DWORD;
    FPointerToRawData: DWORD;
  public
    constructor Create(ARecord: _IMAGE_DEBUG_DIRECTORY);
    function ObjToRec: _IMAGE_DEBUG_DIRECTORY;
  published
    property Characteristics: DWORD read FCharacteristics write FCharacteristics;
    property TimeDateStamp: DWORD read FTimeDateStamp write FTimeDateStamp;
    property MajorVersion: Word read FMajorVersion write FMajorVersion;
    property MinorVersion: Word read FMinorVersion write FMinorVersion;
    property _Type: DWORD read F_Type write F_Type;
    property SizeOfData: DWORD read FSizeOfData write FSizeOfData;
    property AddressOfRawData: DWORD read FAddressOfRawData write FAddressOfRawData;
    property PointerToRawData: DWORD read FPointerToRawData write FPointerToRawData;
  end;
  
  _IMAGE_COFF_SYMBOLS_HEADERWrapper = class(TatRecordWrapper)
  private
    FNumberOfSymbols: DWORD;
    FLvaToFirstSymbol: DWORD;
    FNumberOfLinenumbers: DWORD;
    FLvaToFirstLinenumber: DWORD;
    FRvaToFirstByteOfCode: DWORD;
    FRvaToLastByteOfCode: DWORD;
    FRvaToFirstByteOfData: DWORD;
    FRvaToLastByteOfData: DWORD;
  public
    constructor Create(ARecord: _IMAGE_COFF_SYMBOLS_HEADER);
    function ObjToRec: _IMAGE_COFF_SYMBOLS_HEADER;
  published
    property NumberOfSymbols: DWORD read FNumberOfSymbols write FNumberOfSymbols;
    property LvaToFirstSymbol: DWORD read FLvaToFirstSymbol write FLvaToFirstSymbol;
    property NumberOfLinenumbers: DWORD read FNumberOfLinenumbers write FNumberOfLinenumbers;
    property LvaToFirstLinenumber: DWORD read FLvaToFirstLinenumber write FLvaToFirstLinenumber;
    property RvaToFirstByteOfCode: DWORD read FRvaToFirstByteOfCode write FRvaToFirstByteOfCode;
    property RvaToLastByteOfCode: DWORD read FRvaToLastByteOfCode write FRvaToLastByteOfCode;
    property RvaToFirstByteOfData: DWORD read FRvaToFirstByteOfData write FRvaToFirstByteOfData;
    property RvaToLastByteOfData: DWORD read FRvaToLastByteOfData write FRvaToLastByteOfData;
  end;
  
  _FPO_DATAWrapper = class(TatRecordWrapper)
  private
    FulOffStart: DWORD;
    FcbProcSize: DWORD;
    FcdwLocals: DWORD;
    FcdwParams: Word;
    FcbProlog: Byte;
    FOtherStuff: Byte;
  public
    constructor Create(ARecord: _FPO_DATA);
    function ObjToRec: _FPO_DATA;
  published
    property ulOffStart: DWORD read FulOffStart write FulOffStart;
    property cbProcSize: DWORD read FcbProcSize write FcbProcSize;
    property cdwLocals: DWORD read FcdwLocals write FcdwLocals;
    property cdwParams: Word read FcdwParams write FcdwParams;
    property cbProlog: Byte read FcbProlog write FcbProlog;
    property OtherStuff: Byte read FOtherStuff write FOtherStuff;
  end;
  
  _IMAGE_DEBUG_MISCWrapper = class(TatRecordWrapper)
  private
    FDataType: DWORD;
    FLength: DWORD;
    FUnicode: ByteBool;
  public
    constructor Create(ARecord: _IMAGE_DEBUG_MISC);
    function ObjToRec: _IMAGE_DEBUG_MISC;
  published
    property DataType: DWORD read FDataType write FDataType;
    property Length: DWORD read FLength write FLength;
    property Unicode: ByteBool read FUnicode write FUnicode;
  end;
  
  _IMAGE_FUNCTION_ENTRYWrapper = class(TatRecordWrapper)
  private
    FStartingAddress: DWORD;
    FEndingAddress: DWORD;
    FEndOfPrologue: DWORD;
  public
    constructor Create(ARecord: _IMAGE_FUNCTION_ENTRY);
    function ObjToRec: _IMAGE_FUNCTION_ENTRY;
  published
    property StartingAddress: DWORD read FStartingAddress write FStartingAddress;
    property EndingAddress: DWORD read FEndingAddress write FEndingAddress;
    property EndOfPrologue: DWORD read FEndOfPrologue write FEndOfPrologue;
  end;
  
  _RTL_CRITICAL_SECTION_DEBUGWrapper = class(TatRecordWrapper)
  private
    FType_18: Word;
    FCreatorBackTraceIndex: Word;
    FEntryCount: DWORD;
    FContentionCount: DWORD;
  public
    constructor Create(ARecord: _RTL_CRITICAL_SECTION_DEBUG);
    function ObjToRec: _RTL_CRITICAL_SECTION_DEBUG;
  published
    property Type_18: Word read FType_18 write FType_18;
    property CreatorBackTraceIndex: Word read FCreatorBackTraceIndex write FCreatorBackTraceIndex;
    property EntryCount: DWORD read FEntryCount write FEntryCount;
    property ContentionCount: DWORD read FContentionCount write FContentionCount;
  end;
  
  _RTL_CRITICAL_SECTIONWrapper = class(TatRecordWrapper)
  private
    FLockCount: Longint;
    FRecursionCount: Longint;
    FOwningThread: THandle;
    FLockSemaphore: THandle;
    FReserved: DWORD;
  public
    constructor Create(ARecord: _RTL_CRITICAL_SECTION);
    function ObjToRec: _RTL_CRITICAL_SECTION;
  published
    property LockCount: Longint read FLockCount write FLockCount;
    property RecursionCount: Longint read FRecursionCount write FRecursionCount;
    property OwningThread: THandle read FOwningThread write FOwningThread;
    property LockSemaphore: THandle read FLockSemaphore write FLockSemaphore;
    property Reserved: DWORD read FReserved write FReserved;
  end;
  
  _POINTLWrapper = class(TatRecordWrapper)
  private
    Fx: Longint;
    Fy: Longint;
  public
    constructor Create(ARecord: _POINTL);
    function ObjToRec: _POINTL;
  published
    property x: Longint read Fx write Fx;
    property y: Longint read Fy write Fy;
  end;
  
  _OVERLAPPEDWrapper = class(TatRecordWrapper)
  private
    FInternal: DWORD;
    FInternalHigh: DWORD;
    FOffset: DWORD;
    FOffsetHigh: DWORD;
    FhEvent: THandle;
  public
    constructor Create(ARecord: _OVERLAPPED);
    function ObjToRec: _OVERLAPPED;
  published
    property Internal: DWORD read FInternal write FInternal;
    property InternalHigh: DWORD read FInternalHigh write FInternalHigh;
    property Offset: DWORD read FOffset write FOffset;
    property OffsetHigh: DWORD read FOffsetHigh write FOffsetHigh;
    property hEvent: THandle read FhEvent write FhEvent;
  end;
  
  _SECURITY_ATTRIBUTESWrapper = class(TatRecordWrapper)
  private
    FnLength: DWORD;
    FbInheritHandle: BOOL;
  public
    constructor Create(ARecord: _SECURITY_ATTRIBUTES);
    function ObjToRec: _SECURITY_ATTRIBUTES;
  published
    property nLength: DWORD read FnLength write FnLength;
    property bInheritHandle: BOOL read FbInheritHandle write FbInheritHandle;
  end;
  
  _PROCESS_INFORMATIONWrapper = class(TatRecordWrapper)
  private
    FhProcess: THandle;
    FhThread: THandle;
    FdwProcessId: DWORD;
    FdwThreadId: DWORD;
  public
    constructor Create(ARecord: _PROCESS_INFORMATION);
    function ObjToRec: _PROCESS_INFORMATION;
  published
    property hProcess: THandle read FhProcess write FhProcess;
    property hThread: THandle read FhThread write FhThread;
    property dwProcessId: DWORD read FdwProcessId write FdwProcessId;
    property dwThreadId: DWORD read FdwThreadId write FdwThreadId;
  end;
  
  _FILETIMEWrapper = class(TatRecordWrapper)
  private
    FdwLowDateTime: DWORD;
    FdwHighDateTime: DWORD;
  public
    constructor Create(ARecord: _FILETIME);
    function ObjToRec: _FILETIME;
  published
    property dwLowDateTime: DWORD read FdwLowDateTime write FdwLowDateTime;
    property dwHighDateTime: DWORD read FdwHighDateTime write FdwHighDateTime;
  end;
  
  _SYSTEMTIMEWrapper = class(TatRecordWrapper)
  private
    FwYear: Word;
    FwMonth: Word;
    FwDayOfWeek: Word;
    FwDay: Word;
    FwHour: Word;
    FwMinute: Word;
    FwSecond: Word;
    FwMilliseconds: Word;
  public
    constructor Create(ARecord: _SYSTEMTIME);
    function ObjToRec: _SYSTEMTIME;
  published
    property wYear: Word read FwYear write FwYear;
    property wMonth: Word read FwMonth write FwMonth;
    property wDayOfWeek: Word read FwDayOfWeek write FwDayOfWeek;
    property wDay: Word read FwDay write FwDay;
    property wHour: Word read FwHour write FwHour;
    property wMinute: Word read FwMinute write FwMinute;
    property wSecond: Word read FwSecond write FwSecond;
    property wMilliseconds: Word read FwMilliseconds write FwMilliseconds;
  end;
  
  _COMMPROPWrapper = class(TatRecordWrapper)
  private
    FwPacketLength: Word;
    FwPacketVersion: Word;
    FdwServiceMask: DWORD;
    FdwReserved1: DWORD;
    FdwMaxTxQueue: DWORD;
    FdwMaxRxQueue: DWORD;
    FdwMaxBaud: DWORD;
    FdwProvSubType: DWORD;
    FdwProvCapabilities: DWORD;
    FdwSettableParams: DWORD;
    FdwSettableBaud: DWORD;
    FwSettableData: Word;
    FwSettableStopParity: Word;
    FdwCurrentTxQueue: DWORD;
    FdwCurrentRxQueue: DWORD;
    FdwProvSpec1: DWORD;
    FdwProvSpec2: DWORD;
  public
    constructor Create(ARecord: _COMMPROP);
    function ObjToRec: _COMMPROP;
  published
    property wPacketLength: Word read FwPacketLength write FwPacketLength;
    property wPacketVersion: Word read FwPacketVersion write FwPacketVersion;
    property dwServiceMask: DWORD read FdwServiceMask write FdwServiceMask;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
    property dwMaxTxQueue: DWORD read FdwMaxTxQueue write FdwMaxTxQueue;
    property dwMaxRxQueue: DWORD read FdwMaxRxQueue write FdwMaxRxQueue;
    property dwMaxBaud: DWORD read FdwMaxBaud write FdwMaxBaud;
    property dwProvSubType: DWORD read FdwProvSubType write FdwProvSubType;
    property dwProvCapabilities: DWORD read FdwProvCapabilities write FdwProvCapabilities;
    property dwSettableParams: DWORD read FdwSettableParams write FdwSettableParams;
    property dwSettableBaud: DWORD read FdwSettableBaud write FdwSettableBaud;
    property wSettableData: Word read FwSettableData write FwSettableData;
    property wSettableStopParity: Word read FwSettableStopParity write FwSettableStopParity;
    property dwCurrentTxQueue: DWORD read FdwCurrentTxQueue write FdwCurrentTxQueue;
    property dwCurrentRxQueue: DWORD read FdwCurrentRxQueue write FdwCurrentRxQueue;
    property dwProvSpec1: DWORD read FdwProvSpec1 write FdwProvSpec1;
    property dwProvSpec2: DWORD read FdwProvSpec2 write FdwProvSpec2;
  end;
  
  _COMSTATWrapper = class(TatRecordWrapper)
  private
    FFlags: TComStateFlags;
    FcbInQue: DWORD;
    FcbOutQue: DWORD;
  public
    constructor Create(ARecord: _COMSTAT);
    function ObjToRec: _COMSTAT;
  published
    property Flags: TComStateFlags read FFlags write FFlags;
    property cbInQue: DWORD read FcbInQue write FcbInQue;
    property cbOutQue: DWORD read FcbOutQue write FcbOutQue;
  end;
  
  _DCBWrapper = class(TatRecordWrapper)
  private
    FDCBlength: DWORD;
    FBaudRate: DWORD;
    FFlags: Longint;
    FwReserved: Word;
    FXonLim: Word;
    FXoffLim: Word;
    FByteSize: Byte;
    FParity: Byte;
    FStopBits: Byte;
    FXonChar: CHAR;
    FXoffChar: CHAR;
    FErrorChar: CHAR;
    FEofChar: CHAR;
    FEvtChar: CHAR;
    FwReserved1: Word;
  public
    constructor Create(ARecord: _DCB);
    function ObjToRec: _DCB;
  published
    property DCBlength: DWORD read FDCBlength write FDCBlength;
    property BaudRate: DWORD read FBaudRate write FBaudRate;
    property Flags: Longint read FFlags write FFlags;
    property wReserved: Word read FwReserved write FwReserved;
    property XonLim: Word read FXonLim write FXonLim;
    property XoffLim: Word read FXoffLim write FXoffLim;
    property ByteSize: Byte read FByteSize write FByteSize;
    property Parity: Byte read FParity write FParity;
    property StopBits: Byte read FStopBits write FStopBits;
    property XonChar: CHAR read FXonChar write FXonChar;
    property XoffChar: CHAR read FXoffChar write FXoffChar;
    property ErrorChar: CHAR read FErrorChar write FErrorChar;
    property EofChar: CHAR read FEofChar write FEofChar;
    property EvtChar: CHAR read FEvtChar write FEvtChar;
    property wReserved1: Word read FwReserved1 write FwReserved1;
  end;
  
  _COMMTIMEOUTSWrapper = class(TatRecordWrapper)
  private
    FReadIntervalTimeout: DWORD;
    FReadTotalTimeoutMultiplier: DWORD;
    FReadTotalTimeoutConstant: DWORD;
    FWriteTotalTimeoutMultiplier: DWORD;
    FWriteTotalTimeoutConstant: DWORD;
  public
    constructor Create(ARecord: _COMMTIMEOUTS);
    function ObjToRec: _COMMTIMEOUTS;
  published
    property ReadIntervalTimeout: DWORD read FReadIntervalTimeout write FReadIntervalTimeout;
    property ReadTotalTimeoutMultiplier: DWORD read FReadTotalTimeoutMultiplier write FReadTotalTimeoutMultiplier;
    property ReadTotalTimeoutConstant: DWORD read FReadTotalTimeoutConstant write FReadTotalTimeoutConstant;
    property WriteTotalTimeoutMultiplier: DWORD read FWriteTotalTimeoutMultiplier write FWriteTotalTimeoutMultiplier;
    property WriteTotalTimeoutConstant: DWORD read FWriteTotalTimeoutConstant write FWriteTotalTimeoutConstant;
  end;
  
  _COMMCONFIGWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FwVersion: Word;
    FwReserved: Word;
    FdwProviderSubType: DWORD;
    FdwProviderOffset: DWORD;
    FdwProviderSize: DWORD;
  public
    constructor Create(ARecord: _COMMCONFIG);
    function ObjToRec: _COMMCONFIG;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property wVersion: Word read FwVersion write FwVersion;
    property wReserved: Word read FwReserved write FwReserved;
    property dwProviderSubType: DWORD read FdwProviderSubType write FdwProviderSubType;
    property dwProviderOffset: DWORD read FdwProviderOffset write FdwProviderOffset;
    property dwProviderSize: DWORD read FdwProviderSize write FdwProviderSize;
  end;
  
  _SYSTEM_INFOWrapper = class(TatRecordWrapper)
  private
    FdwOemId: DWORD;
    FwProcessorArchitecture: Word;
    FwReserved: Word;
    FdwPageSize: DWORD;
    FdwActiveProcessorMask: DWORD;
    FdwNumberOfProcessors: DWORD;
    FdwProcessorType: DWORD;
    FdwAllocationGranularity: DWORD;
    FwProcessorLevel: Word;
    FwProcessorRevision: Word;
  public
    constructor Create(ARecord: _SYSTEM_INFO);
    function ObjToRec: _SYSTEM_INFO;
  published
    property dwOemId: DWORD read FdwOemId write FdwOemId;
    property wProcessorArchitecture: Word read FwProcessorArchitecture write FwProcessorArchitecture;
    property wReserved: Word read FwReserved write FwReserved;
    property dwPageSize: DWORD read FdwPageSize write FdwPageSize;
    property dwActiveProcessorMask: DWORD read FdwActiveProcessorMask write FdwActiveProcessorMask;
    property dwNumberOfProcessors: DWORD read FdwNumberOfProcessors write FdwNumberOfProcessors;
    property dwProcessorType: DWORD read FdwProcessorType write FdwProcessorType;
    property dwAllocationGranularity: DWORD read FdwAllocationGranularity write FdwAllocationGranularity;
    property wProcessorLevel: Word read FwProcessorLevel write FwProcessorLevel;
    property wProcessorRevision: Word read FwProcessorRevision write FwProcessorRevision;
  end;
  
  _MEMORYSTATUSWrapper = class(TatRecordWrapper)
  private
    FdwLength: DWORD;
    FdwMemoryLoad: DWORD;
    FdwTotalPhys: DWORD;
    FdwAvailPhys: DWORD;
    FdwTotalPageFile: DWORD;
    FdwAvailPageFile: DWORD;
    FdwTotalVirtual: DWORD;
    FdwAvailVirtual: DWORD;
  public
    constructor Create(ARecord: _MEMORYSTATUS);
    function ObjToRec: _MEMORYSTATUS;
  published
    property dwLength: DWORD read FdwLength write FdwLength;
    property dwMemoryLoad: DWORD read FdwMemoryLoad write FdwMemoryLoad;
    property dwTotalPhys: DWORD read FdwTotalPhys write FdwTotalPhys;
    property dwAvailPhys: DWORD read FdwAvailPhys write FdwAvailPhys;
    property dwTotalPageFile: DWORD read FdwTotalPageFile write FdwTotalPageFile;
    property dwAvailPageFile: DWORD read FdwAvailPageFile write FdwAvailPageFile;
    property dwTotalVirtual: DWORD read FdwTotalVirtual write FdwTotalVirtual;
    property dwAvailVirtual: DWORD read FdwAvailVirtual write FdwAvailVirtual;
  end;
  
  _EXCEPTION_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
    FdwFirstChance: DWORD;
  public
    constructor Create(ARecord: _EXCEPTION_DEBUG_INFO);
    function ObjToRec: _EXCEPTION_DEBUG_INFO;
  published
    property dwFirstChance: DWORD read FdwFirstChance write FdwFirstChance;
  end;
  
  _CREATE_THREAD_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
    FhThread: THandle;
  public
    constructor Create(ARecord: _CREATE_THREAD_DEBUG_INFO);
    function ObjToRec: _CREATE_THREAD_DEBUG_INFO;
  published
    property hThread: THandle read FhThread write FhThread;
  end;
  
  _CREATE_PROCESS_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
    FhFile: THandle;
    FhProcess: THandle;
    FhThread: THandle;
    FdwDebugInfoFileOffset: DWORD;
    FnDebugInfoSize: DWORD;
    FfUnicode: Word;
  public
    constructor Create(ARecord: _CREATE_PROCESS_DEBUG_INFO);
    function ObjToRec: _CREATE_PROCESS_DEBUG_INFO;
  published
    property hFile: THandle read FhFile write FhFile;
    property hProcess: THandle read FhProcess write FhProcess;
    property hThread: THandle read FhThread write FhThread;
    property dwDebugInfoFileOffset: DWORD read FdwDebugInfoFileOffset write FdwDebugInfoFileOffset;
    property nDebugInfoSize: DWORD read FnDebugInfoSize write FnDebugInfoSize;
    property fUnicode: Word read FfUnicode write FfUnicode;
  end;
  
  _EXIT_THREAD_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
    FdwExitCode: DWORD;
  public
    constructor Create(ARecord: _EXIT_THREAD_DEBUG_INFO);
    function ObjToRec: _EXIT_THREAD_DEBUG_INFO;
  published
    property dwExitCode: DWORD read FdwExitCode write FdwExitCode;
  end;
  
  _EXIT_PROCESS_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
    FdwExitCode: DWORD;
  public
    constructor Create(ARecord: _EXIT_PROCESS_DEBUG_INFO);
    function ObjToRec: _EXIT_PROCESS_DEBUG_INFO;
  published
    property dwExitCode: DWORD read FdwExitCode write FdwExitCode;
  end;
  
  _LOAD_DLL_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
    FhFile: THandle;
    FdwDebugInfoFileOffset: DWORD;
    FnDebugInfoSize: DWORD;
    FfUnicode: Word;
  public
    constructor Create(ARecord: _LOAD_DLL_DEBUG_INFO);
    function ObjToRec: _LOAD_DLL_DEBUG_INFO;
  published
    property hFile: THandle read FhFile write FhFile;
    property dwDebugInfoFileOffset: DWORD read FdwDebugInfoFileOffset write FdwDebugInfoFileOffset;
    property nDebugInfoSize: DWORD read FnDebugInfoSize write FnDebugInfoSize;
    property fUnicode: Word read FfUnicode write FfUnicode;
  end;
  
  _UNLOAD_DLL_DEBUG_INFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _UNLOAD_DLL_DEBUG_INFO);
    function ObjToRec: _UNLOAD_DLL_DEBUG_INFO;
  published
  end;
  
  _OUTPUT_DEBUG_STRING_INFOWrapper = class(TatRecordWrapper)
  private
    FfUnicode: Word;
    FnDebugStringLength: Word;
  public
    constructor Create(ARecord: _OUTPUT_DEBUG_STRING_INFO);
    function ObjToRec: _OUTPUT_DEBUG_STRING_INFO;
  published
    property fUnicode: Word read FfUnicode write FfUnicode;
    property nDebugStringLength: Word read FnDebugStringLength write FnDebugStringLength;
  end;
  
  _RIP_INFOWrapper = class(TatRecordWrapper)
  private
    FdwError: DWORD;
    FdwType: DWORD;
  public
    constructor Create(ARecord: _RIP_INFO);
    function ObjToRec: _RIP_INFO;
  published
    property dwError: DWORD read FdwError write FdwError;
    property dwType: DWORD read FdwType write FdwType;
  end;
  
  _DEBUG_EVENTWrapper = class(TatRecordWrapper)
  private
    FdwDebugEventCode: DWORD;
    FdwProcessId: DWORD;
    FdwThreadId: DWORD;
  public
    constructor Create(ARecord: _DEBUG_EVENT);
    function ObjToRec: _DEBUG_EVENT;
  published
    property dwDebugEventCode: DWORD read FdwDebugEventCode write FdwDebugEventCode;
    property dwProcessId: DWORD read FdwProcessId write FdwProcessId;
    property dwThreadId: DWORD read FdwThreadId write FdwThreadId;
  end;
  
  _OFSTRUCTWrapper = class(TatRecordWrapper)
  private
    FcBytes: Byte;
    FfFixedDisk: Byte;
    FnErrCode: Word;
    FReserved1: Word;
    FReserved2: Word;
  public
    constructor Create(ARecord: _OFSTRUCT);
    function ObjToRec: _OFSTRUCT;
  published
    property cBytes: Byte read FcBytes write FcBytes;
    property fFixedDisk: Byte read FfFixedDisk write FfFixedDisk;
    property nErrCode: Word read FnErrCode write FnErrCode;
    property Reserved1: Word read FReserved1 write FReserved1;
    property Reserved2: Word read FReserved2 write FReserved2;
  end;
  
  _PROCESS_HEAP_ENTRYWrapper = class(TatRecordWrapper)
  private
    FcbData: DWORD;
    FcbOverhead: Byte;
    FiRegionIndex: Byte;
    FwFlags: Word;
    FhMem: THandle;
    FdwCommittedSize: DWORD;
    FdwUnCommittedSize: DWORD;
  public
    constructor Create(ARecord: _PROCESS_HEAP_ENTRY);
    function ObjToRec: _PROCESS_HEAP_ENTRY;
  published
    property cbData: DWORD read FcbData write FcbData;
    property cbOverhead: Byte read FcbOverhead write FcbOverhead;
    property iRegionIndex: Byte read FiRegionIndex write FiRegionIndex;
    property wFlags: Word read FwFlags write FwFlags;
    property hMem: THandle read FhMem write FhMem;
    property dwCommittedSize: DWORD read FdwCommittedSize write FdwCommittedSize;
    property dwUnCommittedSize: DWORD read FdwUnCommittedSize write FdwUnCommittedSize;
  end;
  
  _BY_HANDLE_FILE_INFORMATIONWrapper = class(TatRecordWrapper)
  private
    FdwFileAttributes: DWORD;
    FdwVolumeSerialNumber: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
    FnNumberOfLinks: DWORD;
    FnFileIndexHigh: DWORD;
    FnFileIndexLow: DWORD;
  public
    constructor Create(ARecord: _BY_HANDLE_FILE_INFORMATION);
    function ObjToRec: _BY_HANDLE_FILE_INFORMATION;
  published
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property dwVolumeSerialNumber: DWORD read FdwVolumeSerialNumber write FdwVolumeSerialNumber;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
    property nNumberOfLinks: DWORD read FnNumberOfLinks write FnNumberOfLinks;
    property nFileIndexHigh: DWORD read FnFileIndexHigh write FnFileIndexHigh;
    property nFileIndexLow: DWORD read FnFileIndexLow write FnFileIndexLow;
  end;
  
  _TIME_ZONE_INFORMATIONWrapper = class(TatRecordWrapper)
  private
    FBias: Longint;
    FStandardBias: Longint;
    FDaylightBias: Longint;
  public
    constructor Create(ARecord: _TIME_ZONE_INFORMATION);
    function ObjToRec: _TIME_ZONE_INFORMATION;
  published
    property Bias: Longint read FBias write FBias;
    property StandardBias: Longint read FStandardBias write FStandardBias;
    property DaylightBias: Longint read FDaylightBias write FDaylightBias;
  end;
  
  _RECOVERY_AGENT_INFORMATIONAWrapper = class(TatRecordWrapper)
  private
    FNextEntryOffset: DWORD;
    FAgentNameLength: DWORD;
  public
    constructor Create(ARecord: _RECOVERY_AGENT_INFORMATIONA);
    function ObjToRec: _RECOVERY_AGENT_INFORMATIONA;
  published
    property NextEntryOffset: DWORD read FNextEntryOffset write FNextEntryOffset;
    property AgentNameLength: DWORD read FAgentNameLength write FAgentNameLength;
  end;
  
  _RECOVERY_AGENT_INFORMATIONWWrapper = class(TatRecordWrapper)
  private
    FNextEntryOffset: DWORD;
    FAgentNameLength: DWORD;
  public
    constructor Create(ARecord: _RECOVERY_AGENT_INFORMATIONW);
    function ObjToRec: _RECOVERY_AGENT_INFORMATIONW;
  published
    property NextEntryOffset: DWORD read FNextEntryOffset write FNextEntryOffset;
    property AgentNameLength: DWORD read FAgentNameLength write FAgentNameLength;
  end;
  
  _WIN32_STREAM_IDWrapper = class(TatRecordWrapper)
  private
    FdwStreamId: DWORD;
    FdwStreamAttributes: DWORD;
    FSize: TLargeInteger;
    FdwStreamNameSize: DWORD;
  public
    constructor Create(ARecord: _WIN32_STREAM_ID);
    function ObjToRec: _WIN32_STREAM_ID;
  published
    property dwStreamId: DWORD read FdwStreamId write FdwStreamId;
    property dwStreamAttributes: DWORD read FdwStreamAttributes write FdwStreamAttributes;
    property Size: TLargeInteger read FSize write FSize;
    property dwStreamNameSize: DWORD read FdwStreamNameSize write FdwStreamNameSize;
  end;
  
  _STARTUPINFOAWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FdwX: DWORD;
    FdwY: DWORD;
    FdwXSize: DWORD;
    FdwYSize: DWORD;
    FdwXCountChars: DWORD;
    FdwYCountChars: DWORD;
    FdwFillAttribute: DWORD;
    FdwFlags: DWORD;
    FwShowWindow: Word;
    FcbReserved2: Word;
    FhStdInput: THandle;
    FhStdOutput: THandle;
    FhStdError: THandle;
  public
    constructor Create(ARecord: _STARTUPINFOA);
    function ObjToRec: _STARTUPINFOA;
  published
    property cb: DWORD read Fcb write Fcb;
    property dwX: DWORD read FdwX write FdwX;
    property dwY: DWORD read FdwY write FdwY;
    property dwXSize: DWORD read FdwXSize write FdwXSize;
    property dwYSize: DWORD read FdwYSize write FdwYSize;
    property dwXCountChars: DWORD read FdwXCountChars write FdwXCountChars;
    property dwYCountChars: DWORD read FdwYCountChars write FdwYCountChars;
    property dwFillAttribute: DWORD read FdwFillAttribute write FdwFillAttribute;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property wShowWindow: Word read FwShowWindow write FwShowWindow;
    property cbReserved2: Word read FcbReserved2 write FcbReserved2;
    property hStdInput: THandle read FhStdInput write FhStdInput;
    property hStdOutput: THandle read FhStdOutput write FhStdOutput;
    property hStdError: THandle read FhStdError write FhStdError;
  end;
  
  _STARTUPINFOWWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FdwX: DWORD;
    FdwY: DWORD;
    FdwXSize: DWORD;
    FdwYSize: DWORD;
    FdwXCountChars: DWORD;
    FdwYCountChars: DWORD;
    FdwFillAttribute: DWORD;
    FdwFlags: DWORD;
    FwShowWindow: Word;
    FcbReserved2: Word;
    FhStdInput: THandle;
    FhStdOutput: THandle;
    FhStdError: THandle;
  public
    constructor Create(ARecord: _STARTUPINFOW);
    function ObjToRec: _STARTUPINFOW;
  published
    property cb: DWORD read Fcb write Fcb;
    property dwX: DWORD read FdwX write FdwX;
    property dwY: DWORD read FdwY write FdwY;
    property dwXSize: DWORD read FdwXSize write FdwXSize;
    property dwYSize: DWORD read FdwYSize write FdwYSize;
    property dwXCountChars: DWORD read FdwXCountChars write FdwXCountChars;
    property dwYCountChars: DWORD read FdwYCountChars write FdwYCountChars;
    property dwFillAttribute: DWORD read FdwFillAttribute write FdwFillAttribute;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property wShowWindow: Word read FwShowWindow write FwShowWindow;
    property cbReserved2: Word read FcbReserved2 write FcbReserved2;
    property hStdInput: THandle read FhStdInput write FhStdInput;
    property hStdOutput: THandle read FhStdOutput write FhStdOutput;
    property hStdError: THandle read FhStdError write FhStdError;
  end;
  
  _WIN32_FIND_DATAAWrapper = class(TatRecordWrapper)
  private
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
    FdwReserved0: DWORD;
    FdwReserved1: DWORD;
  public
    constructor Create(ARecord: _WIN32_FIND_DATAA);
    function ObjToRec: _WIN32_FIND_DATAA;
  published
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
    property dwReserved0: DWORD read FdwReserved0 write FdwReserved0;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
  end;
  
  _WIN32_FIND_DATAWWrapper = class(TatRecordWrapper)
  private
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
    FdwReserved0: DWORD;
    FdwReserved1: DWORD;
  public
    constructor Create(ARecord: _WIN32_FIND_DATAW);
    function ObjToRec: _WIN32_FIND_DATAW;
  published
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
    property dwReserved0: DWORD read FdwReserved0 write FdwReserved0;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
  end;
  
  _WIN32_FILE_ATTRIBUTE_DATAWrapper = class(TatRecordWrapper)
  private
    FdwFileAttributes: DWORD;
    FnFileSizeHigh: DWORD;
    FnFileSizeLow: DWORD;
  public
    constructor Create(ARecord: _WIN32_FILE_ATTRIBUTE_DATA);
    function ObjToRec: _WIN32_FILE_ATTRIBUTE_DATA;
  published
    property dwFileAttributes: DWORD read FdwFileAttributes write FdwFileAttributes;
    property nFileSizeHigh: DWORD read FnFileSizeHigh write FnFileSizeHigh;
    property nFileSizeLow: DWORD read FnFileSizeLow write FnFileSizeLow;
  end;
  
  tagHW_PROFILE_INFOAWrapper = class(TatRecordWrapper)
  private
    FdwDockInfo: DWORD;
  public
    constructor Create(ARecord: tagHW_PROFILE_INFOA);
    function ObjToRec: tagHW_PROFILE_INFOA;
  published
    property dwDockInfo: DWORD read FdwDockInfo write FdwDockInfo;
  end;
  
  tagHW_PROFILE_INFOWWrapper = class(TatRecordWrapper)
  private
    FdwDockInfo: DWORD;
  public
    constructor Create(ARecord: tagHW_PROFILE_INFOW);
    function ObjToRec: tagHW_PROFILE_INFOW;
  published
    property dwDockInfo: DWORD read FdwDockInfo write FdwDockInfo;
  end;
  
  _OSVERSIONINFOAWrapper = class(TatRecordWrapper)
  private
    FdwOSVersionInfoSize: DWORD;
    FdwMajorVersion: DWORD;
    FdwMinorVersion: DWORD;
    FdwBuildNumber: DWORD;
    FdwPlatformId: DWORD;
  public
    constructor Create(ARecord: _OSVERSIONINFOA);
    function ObjToRec: _OSVERSIONINFOA;
  published
    property dwOSVersionInfoSize: DWORD read FdwOSVersionInfoSize write FdwOSVersionInfoSize;
    property dwMajorVersion: DWORD read FdwMajorVersion write FdwMajorVersion;
    property dwMinorVersion: DWORD read FdwMinorVersion write FdwMinorVersion;
    property dwBuildNumber: DWORD read FdwBuildNumber write FdwBuildNumber;
    property dwPlatformId: DWORD read FdwPlatformId write FdwPlatformId;
  end;
  
  _OSVERSIONINFOWWrapper = class(TatRecordWrapper)
  private
    FdwOSVersionInfoSize: DWORD;
    FdwMajorVersion: DWORD;
    FdwMinorVersion: DWORD;
    FdwBuildNumber: DWORD;
    FdwPlatformId: DWORD;
  public
    constructor Create(ARecord: _OSVERSIONINFOW);
    function ObjToRec: _OSVERSIONINFOW;
  published
    property dwOSVersionInfoSize: DWORD read FdwOSVersionInfoSize write FdwOSVersionInfoSize;
    property dwMajorVersion: DWORD read FdwMajorVersion write FdwMajorVersion;
    property dwMinorVersion: DWORD read FdwMinorVersion write FdwMinorVersion;
    property dwBuildNumber: DWORD read FdwBuildNumber write FdwBuildNumber;
    property dwPlatformId: DWORD read FdwPlatformId write FdwPlatformId;
  end;
  
  _SYSTEM_POWER_STATUSWrapper = class(TatRecordWrapper)
  private
    FACLineStatus: Byte;
    FBatteryFlag: Byte;
    FBatteryLifePercent: Byte;
    FReserved1: Byte;
    FBatteryLifeTime: DWORD;
    FBatteryFullLifeTime: DWORD;
  public
    constructor Create(ARecord: _SYSTEM_POWER_STATUS);
    function ObjToRec: _SYSTEM_POWER_STATUS;
  published
    property ACLineStatus: Byte read FACLineStatus write FACLineStatus;
    property BatteryFlag: Byte read FBatteryFlag write FBatteryFlag;
    property BatteryLifePercent: Byte read FBatteryLifePercent write FBatteryLifePercent;
    property Reserved1: Byte read FReserved1 write FReserved1;
    property BatteryLifeTime: DWORD read FBatteryLifeTime write FBatteryLifeTime;
    property BatteryFullLifeTime: DWORD read FBatteryFullLifeTime write FBatteryFullLifeTime;
  end;
  
  _WIN_CERTIFICATEWrapper = class(TatRecordWrapper)
  private
    FdwLength: DWORD;
    FwRevision: Word;
    FwCertificateType: Word;
  public
    constructor Create(ARecord: _WIN_CERTIFICATE);
    function ObjToRec: _WIN_CERTIFICATE;
  published
    property dwLength: DWORD read FdwLength write FdwLength;
    property wRevision: Word read FwRevision write FwRevision;
    property wCertificateType: Word read FwCertificateType write FwCertificateType;
  end;
  
  _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper = class(TatRecordWrapper)
  private
    FhClientToken: THandle;
  public
    constructor Create(ARecord: _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT);
    function ObjToRec: _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT;
  published
    property hClientToken: THandle read FhClientToken write FhClientToken;
  end;
  
  _WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _WIN_TRUST_ACTDATA_SUBJECT_ONLY);
    function ObjToRec: _WIN_TRUST_ACTDATA_SUBJECT_ONLY;
  published
  end;
  
  _WIN_TRUST_SUBJECT_FILEWrapper = class(TatRecordWrapper)
  private
    FhFile: THandle;
  public
    constructor Create(ARecord: _WIN_TRUST_SUBJECT_FILE);
    function ObjToRec: _WIN_TRUST_SUBJECT_FILE;
  published
    property hFile: THandle read FhFile write FhFile;
  end;
  
  _WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper = class(TatRecordWrapper)
  private
    FhFile: THandle;
  public
    constructor Create(ARecord: _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY);
    function ObjToRec: _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY;
  published
    property hFile: THandle read FhFile write FhFile;
  end;
  
  _WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper = class(TatRecordWrapper)
  private
    FhClientToken: THandle;
  public
    constructor Create(ARecord: _WIN_SPUB_TRUSTED_PUBLISHER_DATA);
    function ObjToRec: _WIN_SPUB_TRUSTED_PUBLISHER_DATA;
  published
    property hClientToken: THandle read FhClientToken write FhClientToken;
  end;
  
  tagXFORMWrapper = class(TatRecordWrapper)
  private
    FeM11: Single;
    FeM12: Single;
    FeM21: Single;
    FeM22: Single;
    FeDx: Single;
    FeDy: Single;
  public
    constructor Create(ARecord: tagXFORM);
    function ObjToRec: tagXFORM;
  published
    property eM11: Single read FeM11 write FeM11;
    property eM12: Single read FeM12 write FeM12;
    property eM21: Single read FeM21 write FeM21;
    property eM22: Single read FeM22 write FeM22;
    property eDx: Single read FeDx write FeDx;
    property eDy: Single read FeDy write FeDy;
  end;
  
  tagBITMAPWrapper = class(TatRecordWrapper)
  private
    FbmType: Longint;
    FbmWidth: Longint;
    FbmHeight: Longint;
    FbmWidthBytes: Longint;
    FbmPlanes: Word;
    FbmBitsPixel: Word;
  public
    constructor Create(ARecord: tagBITMAP);
    function ObjToRec: tagBITMAP;
  published
    property bmType: Longint read FbmType write FbmType;
    property bmWidth: Longint read FbmWidth write FbmWidth;
    property bmHeight: Longint read FbmHeight write FbmHeight;
    property bmWidthBytes: Longint read FbmWidthBytes write FbmWidthBytes;
    property bmPlanes: Word read FbmPlanes write FbmPlanes;
    property bmBitsPixel: Word read FbmBitsPixel write FbmBitsPixel;
  end;
  
  tagRGBTRIPLEWrapper = class(TatRecordWrapper)
  private
    FrgbtBlue: Byte;
    FrgbtGreen: Byte;
    FrgbtRed: Byte;
  public
    constructor Create(ARecord: tagRGBTRIPLE);
    function ObjToRec: tagRGBTRIPLE;
  published
    property rgbtBlue: Byte read FrgbtBlue write FrgbtBlue;
    property rgbtGreen: Byte read FrgbtGreen write FrgbtGreen;
    property rgbtRed: Byte read FrgbtRed write FrgbtRed;
  end;
  
  tagRGBQUADWrapper = class(TatRecordWrapper)
  private
    FrgbBlue: Byte;
    FrgbGreen: Byte;
    FrgbRed: Byte;
    FrgbReserved: Byte;
  public
    constructor Create(ARecord: tagRGBQUAD);
    function ObjToRec: tagRGBQUAD;
  published
    property rgbBlue: Byte read FrgbBlue write FrgbBlue;
    property rgbGreen: Byte read FrgbGreen write FrgbGreen;
    property rgbRed: Byte read FrgbRed write FrgbRed;
    property rgbReserved: Byte read FrgbReserved write FrgbReserved;
  end;
  
  tagCIEXYZWrapper = class(TatRecordWrapper)
  private
    FciexyzX: FXPT2DOT30;
    FciexyzY: FXPT2DOT30;
    FciexyzZ: FXPT2DOT30;
  public
    constructor Create(ARecord: tagCIEXYZ);
    function ObjToRec: tagCIEXYZ;
  published
    property ciexyzX: FXPT2DOT30 read FciexyzX write FciexyzX;
    property ciexyzY: FXPT2DOT30 read FciexyzY write FciexyzY;
    property ciexyzZ: FXPT2DOT30 read FciexyzZ write FciexyzZ;
  end;
  
  tagICEXYZTRIPLEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagICEXYZTRIPLE);
    function ObjToRec: tagICEXYZTRIPLE;
  published
  end;
  
  tagLOGCOLORSPACEAWrapper = class(TatRecordWrapper)
  private
    FlcsSignature: DWORD;
    FlcsVersion: DWORD;
    FlcsSize: DWORD;
    FlcsCSType: LCSCSTYPE;
    FlcsIntent: LCSGAMUTMATCH;
    FlcsGammaRed: DWORD;
    FlcsGammaGreen: DWORD;
    FlcsGammaBlue: DWORD;
  public
    constructor Create(ARecord: tagLOGCOLORSPACEA);
    function ObjToRec: tagLOGCOLORSPACEA;
  published
    property lcsSignature: DWORD read FlcsSignature write FlcsSignature;
    property lcsVersion: DWORD read FlcsVersion write FlcsVersion;
    property lcsSize: DWORD read FlcsSize write FlcsSize;
    property lcsCSType: LCSCSTYPE read FlcsCSType write FlcsCSType;
    property lcsIntent: LCSGAMUTMATCH read FlcsIntent write FlcsIntent;
    property lcsGammaRed: DWORD read FlcsGammaRed write FlcsGammaRed;
    property lcsGammaGreen: DWORD read FlcsGammaGreen write FlcsGammaGreen;
    property lcsGammaBlue: DWORD read FlcsGammaBlue write FlcsGammaBlue;
  end;
  
  tagLOGCOLORSPACEWWrapper = class(TatRecordWrapper)
  private
    FlcsSignature: DWORD;
    FlcsVersion: DWORD;
    FlcsSize: DWORD;
    FlcsCSType: LCSCSTYPE;
    FlcsIntent: LCSGAMUTMATCH;
    FlcsGammaRed: DWORD;
    FlcsGammaGreen: DWORD;
    FlcsGammaBlue: DWORD;
  public
    constructor Create(ARecord: tagLOGCOLORSPACEW);
    function ObjToRec: tagLOGCOLORSPACEW;
  published
    property lcsSignature: DWORD read FlcsSignature write FlcsSignature;
    property lcsVersion: DWORD read FlcsVersion write FlcsVersion;
    property lcsSize: DWORD read FlcsSize write FlcsSize;
    property lcsCSType: LCSCSTYPE read FlcsCSType write FlcsCSType;
    property lcsIntent: LCSGAMUTMATCH read FlcsIntent write FlcsIntent;
    property lcsGammaRed: DWORD read FlcsGammaRed write FlcsGammaRed;
    property lcsGammaGreen: DWORD read FlcsGammaGreen write FlcsGammaGreen;
    property lcsGammaBlue: DWORD read FlcsGammaBlue write FlcsGammaBlue;
  end;
  
  tagBITMAPCOREHEADERWrapper = class(TatRecordWrapper)
  private
    FbcSize: DWORD;
    FbcWidth: Word;
    FbcHeight: Word;
    FbcPlanes: Word;
    FbcBitCount: Word;
  public
    constructor Create(ARecord: tagBITMAPCOREHEADER);
    function ObjToRec: tagBITMAPCOREHEADER;
  published
    property bcSize: DWORD read FbcSize write FbcSize;
    property bcWidth: Word read FbcWidth write FbcWidth;
    property bcHeight: Word read FbcHeight write FbcHeight;
    property bcPlanes: Word read FbcPlanes write FbcPlanes;
    property bcBitCount: Word read FbcBitCount write FbcBitCount;
  end;
  
  tagBITMAPINFOHEADERWrapper = class(TatRecordWrapper)
  private
    FbiSize: DWORD;
    FbiWidth: Longint;
    FbiHeight: Longint;
    FbiPlanes: Word;
    FbiBitCount: Word;
    FbiCompression: DWORD;
    FbiSizeImage: DWORD;
    FbiXPelsPerMeter: Longint;
    FbiYPelsPerMeter: Longint;
    FbiClrUsed: DWORD;
    FbiClrImportant: DWORD;
  public
    constructor Create(ARecord: tagBITMAPINFOHEADER);
    function ObjToRec: tagBITMAPINFOHEADER;
  published
    property biSize: DWORD read FbiSize write FbiSize;
    property biWidth: Longint read FbiWidth write FbiWidth;
    property biHeight: Longint read FbiHeight write FbiHeight;
    property biPlanes: Word read FbiPlanes write FbiPlanes;
    property biBitCount: Word read FbiBitCount write FbiBitCount;
    property biCompression: DWORD read FbiCompression write FbiCompression;
    property biSizeImage: DWORD read FbiSizeImage write FbiSizeImage;
    property biXPelsPerMeter: Longint read FbiXPelsPerMeter write FbiXPelsPerMeter;
    property biYPelsPerMeter: Longint read FbiYPelsPerMeter write FbiYPelsPerMeter;
    property biClrUsed: DWORD read FbiClrUsed write FbiClrUsed;
    property biClrImportant: DWORD read FbiClrImportant write FbiClrImportant;
  end;
  
  BITMAPV4HEADERWrapper = class(TatRecordWrapper)
  private
    FbV4Size: DWORD;
    FbV4Width: Longint;
    FbV4Height: Longint;
    FbV4Planes: Word;
    FbV4BitCount: Word;
    FbV4V4Compression: DWORD;
    FbV4SizeImage: DWORD;
    FbV4XPelsPerMeter: Longint;
    FbV4YPelsPerMeter: Longint;
    FbV4ClrUsed: DWORD;
    FbV4ClrImportant: DWORD;
    FbV4RedMask: DWORD;
    FbV4GreenMask: DWORD;
    FbV4BlueMask: DWORD;
    FbV4AlphaMask: DWORD;
    FbV4CSType: DWORD;
    FbV4GammaRed: DWORD;
    FbV4GammaGreen: DWORD;
    FbV4GammaBlue: DWORD;
  public
    constructor Create(ARecord: BITMAPV4HEADER);
    function ObjToRec: BITMAPV4HEADER;
  published
    property bV4Size: DWORD read FbV4Size write FbV4Size;
    property bV4Width: Longint read FbV4Width write FbV4Width;
    property bV4Height: Longint read FbV4Height write FbV4Height;
    property bV4Planes: Word read FbV4Planes write FbV4Planes;
    property bV4BitCount: Word read FbV4BitCount write FbV4BitCount;
    property bV4V4Compression: DWORD read FbV4V4Compression write FbV4V4Compression;
    property bV4SizeImage: DWORD read FbV4SizeImage write FbV4SizeImage;
    property bV4XPelsPerMeter: Longint read FbV4XPelsPerMeter write FbV4XPelsPerMeter;
    property bV4YPelsPerMeter: Longint read FbV4YPelsPerMeter write FbV4YPelsPerMeter;
    property bV4ClrUsed: DWORD read FbV4ClrUsed write FbV4ClrUsed;
    property bV4ClrImportant: DWORD read FbV4ClrImportant write FbV4ClrImportant;
    property bV4RedMask: DWORD read FbV4RedMask write FbV4RedMask;
    property bV4GreenMask: DWORD read FbV4GreenMask write FbV4GreenMask;
    property bV4BlueMask: DWORD read FbV4BlueMask write FbV4BlueMask;
    property bV4AlphaMask: DWORD read FbV4AlphaMask write FbV4AlphaMask;
    property bV4CSType: DWORD read FbV4CSType write FbV4CSType;
    property bV4GammaRed: DWORD read FbV4GammaRed write FbV4GammaRed;
    property bV4GammaGreen: DWORD read FbV4GammaGreen write FbV4GammaGreen;
    property bV4GammaBlue: DWORD read FbV4GammaBlue write FbV4GammaBlue;
  end;
  
  BITMAPV5HEADERWrapper = class(TatRecordWrapper)
  private
    FbV5Size: DWORD;
    FbV5Width: Longint;
    FbV5Height: Longint;
    FbV5Planes: Word;
    FbV5BitCount: Word;
    FbV5Compression: DWORD;
    FbV5SizeImage: DWORD;
    FbV5XPelsPerMeter: Longint;
    FbV5YPelsPerMeter: Longint;
    FbV5ClrUsed: DWORD;
    FbV5ClrImportant: DWORD;
    FbV5RedMask: DWORD;
    FbV5GreenMask: DWORD;
    FbV5BlueMask: DWORD;
    FbV5AlphaMask: DWORD;
    FbV5CSType: DWORD;
    FbV5GammaRed: DWORD;
    FbV5GammaGreen: DWORD;
    FbV5GammaBlue: DWORD;
    FbV5Intent: DWORD;
    FbV5ProfileData: DWORD;
    FbV5ProfileSize: DWORD;
    FbV5Reserved: DWORD;
  public
    constructor Create(ARecord: BITMAPV5HEADER);
    function ObjToRec: BITMAPV5HEADER;
  published
    property bV5Size: DWORD read FbV5Size write FbV5Size;
    property bV5Width: Longint read FbV5Width write FbV5Width;
    property bV5Height: Longint read FbV5Height write FbV5Height;
    property bV5Planes: Word read FbV5Planes write FbV5Planes;
    property bV5BitCount: Word read FbV5BitCount write FbV5BitCount;
    property bV5Compression: DWORD read FbV5Compression write FbV5Compression;
    property bV5SizeImage: DWORD read FbV5SizeImage write FbV5SizeImage;
    property bV5XPelsPerMeter: Longint read FbV5XPelsPerMeter write FbV5XPelsPerMeter;
    property bV5YPelsPerMeter: Longint read FbV5YPelsPerMeter write FbV5YPelsPerMeter;
    property bV5ClrUsed: DWORD read FbV5ClrUsed write FbV5ClrUsed;
    property bV5ClrImportant: DWORD read FbV5ClrImportant write FbV5ClrImportant;
    property bV5RedMask: DWORD read FbV5RedMask write FbV5RedMask;
    property bV5GreenMask: DWORD read FbV5GreenMask write FbV5GreenMask;
    property bV5BlueMask: DWORD read FbV5BlueMask write FbV5BlueMask;
    property bV5AlphaMask: DWORD read FbV5AlphaMask write FbV5AlphaMask;
    property bV5CSType: DWORD read FbV5CSType write FbV5CSType;
    property bV5GammaRed: DWORD read FbV5GammaRed write FbV5GammaRed;
    property bV5GammaGreen: DWORD read FbV5GammaGreen write FbV5GammaGreen;
    property bV5GammaBlue: DWORD read FbV5GammaBlue write FbV5GammaBlue;
    property bV5Intent: DWORD read FbV5Intent write FbV5Intent;
    property bV5ProfileData: DWORD read FbV5ProfileData write FbV5ProfileData;
    property bV5ProfileSize: DWORD read FbV5ProfileSize write FbV5ProfileSize;
    property bV5Reserved: DWORD read FbV5Reserved write FbV5Reserved;
  end;
  
  tagBITMAPINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagBITMAPINFO);
    function ObjToRec: tagBITMAPINFO;
  published
  end;
  
  tagBITMAPCOREINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagBITMAPCOREINFO);
    function ObjToRec: tagBITMAPCOREINFO;
  published
  end;
  
  tagBITMAPFILEHEADERWrapper = class(TatRecordWrapper)
  private
    FbfType: Word;
    FbfSize: DWORD;
    FbfReserved1: Word;
    FbfReserved2: Word;
    FbfOffBits: DWORD;
  public
    constructor Create(ARecord: tagBITMAPFILEHEADER);
    function ObjToRec: tagBITMAPFILEHEADER;
  published
    property bfType: Word read FbfType write FbfType;
    property bfSize: DWORD read FbfSize write FbfSize;
    property bfReserved1: Word read FbfReserved1 write FbfReserved1;
    property bfReserved2: Word read FbfReserved2 write FbfReserved2;
    property bfOffBits: DWORD read FbfOffBits write FbfOffBits;
  end;
  
  tagFONTSIGNATUREWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagFONTSIGNATURE);
    function ObjToRec: tagFONTSIGNATURE;
  published
  end;
  
  tagCHARSETINFOWrapper = class(TatRecordWrapper)
  private
    FciCharset: UINT;
    FciACP: UINT;
  public
    constructor Create(ARecord: tagCHARSETINFO);
    function ObjToRec: tagCHARSETINFO;
  published
    property ciCharset: UINT read FciCharset write FciCharset;
    property ciACP: UINT read FciACP write FciACP;
  end;
  
  tagLOCALESIGNATUREWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagLOCALESIGNATURE);
    function ObjToRec: tagLOCALESIGNATURE;
  published
  end;
  
  tagHANDLETABLEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagHANDLETABLE);
    function ObjToRec: tagHANDLETABLE;
  published
  end;
  
  tagMETARECORDWrapper = class(TatRecordWrapper)
  private
    FrdSize: DWORD;
    FrdFunction: Word;
  public
    constructor Create(ARecord: tagMETARECORD);
    function ObjToRec: tagMETARECORD;
  published
    property rdSize: DWORD read FrdSize write FrdSize;
    property rdFunction: Word read FrdFunction write FrdFunction;
  end;
  
  tagMETAFILEPICTWrapper = class(TatRecordWrapper)
  private
    Fmm: Longint;
    FxExt: Longint;
    FyExt: Longint;
    FhMF: HMETAFILE;
  public
    constructor Create(ARecord: tagMETAFILEPICT);
    function ObjToRec: tagMETAFILEPICT;
  published
    property mm: Longint read Fmm write Fmm;
    property xExt: Longint read FxExt write FxExt;
    property yExt: Longint read FyExt write FyExt;
    property hMF: HMETAFILE read FhMF write FhMF;
  end;
  
  tagMETAHEADERWrapper = class(TatRecordWrapper)
  private
    FmtType: Word;
    FmtHeaderSize: Word;
    FmtVersion: Word;
    FmtSize: DWORD;
    FmtNoObjects: Word;
    FmtMaxRecord: DWORD;
    FmtNoParameters: Word;
  public
    constructor Create(ARecord: tagMETAHEADER);
    function ObjToRec: tagMETAHEADER;
  published
    property mtType: Word read FmtType write FmtType;
    property mtHeaderSize: Word read FmtHeaderSize write FmtHeaderSize;
    property mtVersion: Word read FmtVersion write FmtVersion;
    property mtSize: DWORD read FmtSize write FmtSize;
    property mtNoObjects: Word read FmtNoObjects write FmtNoObjects;
    property mtMaxRecord: DWORD read FmtMaxRecord write FmtMaxRecord;
    property mtNoParameters: Word read FmtNoParameters write FmtNoParameters;
  end;
  
  tagENHMETARECORDWrapper = class(TatRecordWrapper)
  private
    FiType: DWORD;
    FnSize: DWORD;
  public
    constructor Create(ARecord: tagENHMETARECORD);
    function ObjToRec: tagENHMETARECORD;
  published
    property iType: DWORD read FiType write FiType;
    property nSize: DWORD read FnSize write FnSize;
  end;
  
  tagENHMETAHEADERWrapper = class(TatRecordWrapper)
  private
    FiType: DWORD;
    FnSize: DWORD;
    FdSignature: DWORD;
    FnVersion: DWORD;
    FnBytes: DWORD;
    FnRecords: DWORD;
    FnHandles: Word;
    FsReserved: Word;
    FnDescription: DWORD;
    FoffDescription: DWORD;
    FnPalEntries: DWORD;
    FcbPixelFormat: DWORD;
    FoffPixelFormat: DWORD;
    FbOpenGL: DWORD;
  public
    constructor Create(ARecord: tagENHMETAHEADER);
    function ObjToRec: tagENHMETAHEADER;
  published
    property iType: DWORD read FiType write FiType;
    property nSize: DWORD read FnSize write FnSize;
    property dSignature: DWORD read FdSignature write FdSignature;
    property nVersion: DWORD read FnVersion write FnVersion;
    property nBytes: DWORD read FnBytes write FnBytes;
    property nRecords: DWORD read FnRecords write FnRecords;
    property nHandles: Word read FnHandles write FnHandles;
    property sReserved: Word read FsReserved write FsReserved;
    property nDescription: DWORD read FnDescription write FnDescription;
    property offDescription: DWORD read FoffDescription write FoffDescription;
    property nPalEntries: DWORD read FnPalEntries write FnPalEntries;
    property cbPixelFormat: DWORD read FcbPixelFormat write FcbPixelFormat;
    property offPixelFormat: DWORD read FoffPixelFormat write FoffPixelFormat;
    property bOpenGL: DWORD read FbOpenGL write FbOpenGL;
  end;
  
  tagTEXTMETRICAWrapper = class(TatRecordWrapper)
  private
    FtmHeight: Longint;
    FtmAscent: Longint;
    FtmDescent: Longint;
    FtmInternalLeading: Longint;
    FtmExternalLeading: Longint;
    FtmAveCharWidth: Longint;
    FtmMaxCharWidth: Longint;
    FtmWeight: Longint;
    FtmOverhang: Longint;
    FtmDigitizedAspectX: Longint;
    FtmDigitizedAspectY: Longint;
    FtmFirstChar: AnsiChar;
    FtmLastChar: AnsiChar;
    FtmDefaultChar: AnsiChar;
    FtmBreakChar: AnsiChar;
    FtmItalic: Byte;
    FtmUnderlined: Byte;
    FtmStruckOut: Byte;
    FtmPitchAndFamily: Byte;
    FtmCharSet: Byte;
  public
    constructor Create(ARecord: tagTEXTMETRICA);
    function ObjToRec: tagTEXTMETRICA;
  published
    property tmHeight: Longint read FtmHeight write FtmHeight;
    property tmAscent: Longint read FtmAscent write FtmAscent;
    property tmDescent: Longint read FtmDescent write FtmDescent;
    property tmInternalLeading: Longint read FtmInternalLeading write FtmInternalLeading;
    property tmExternalLeading: Longint read FtmExternalLeading write FtmExternalLeading;
    property tmAveCharWidth: Longint read FtmAveCharWidth write FtmAveCharWidth;
    property tmMaxCharWidth: Longint read FtmMaxCharWidth write FtmMaxCharWidth;
    property tmWeight: Longint read FtmWeight write FtmWeight;
    property tmOverhang: Longint read FtmOverhang write FtmOverhang;
    property tmDigitizedAspectX: Longint read FtmDigitizedAspectX write FtmDigitizedAspectX;
    property tmDigitizedAspectY: Longint read FtmDigitizedAspectY write FtmDigitizedAspectY;
    property tmFirstChar: AnsiChar read FtmFirstChar write FtmFirstChar;
    property tmLastChar: AnsiChar read FtmLastChar write FtmLastChar;
    property tmDefaultChar: AnsiChar read FtmDefaultChar write FtmDefaultChar;
    property tmBreakChar: AnsiChar read FtmBreakChar write FtmBreakChar;
    property tmItalic: Byte read FtmItalic write FtmItalic;
    property tmUnderlined: Byte read FtmUnderlined write FtmUnderlined;
    property tmStruckOut: Byte read FtmStruckOut write FtmStruckOut;
    property tmPitchAndFamily: Byte read FtmPitchAndFamily write FtmPitchAndFamily;
    property tmCharSet: Byte read FtmCharSet write FtmCharSet;
  end;
  
  tagTEXTMETRICWWrapper = class(TatRecordWrapper)
  private
    FtmHeight: Longint;
    FtmAscent: Longint;
    FtmDescent: Longint;
    FtmInternalLeading: Longint;
    FtmExternalLeading: Longint;
    FtmAveCharWidth: Longint;
    FtmMaxCharWidth: Longint;
    FtmWeight: Longint;
    FtmOverhang: Longint;
    FtmDigitizedAspectX: Longint;
    FtmDigitizedAspectY: Longint;
    FtmItalic: Byte;
    FtmUnderlined: Byte;
    FtmStruckOut: Byte;
    FtmPitchAndFamily: Byte;
    FtmCharSet: Byte;
  public
    constructor Create(ARecord: tagTEXTMETRICW);
    function ObjToRec: tagTEXTMETRICW;
  published
    property tmHeight: Longint read FtmHeight write FtmHeight;
    property tmAscent: Longint read FtmAscent write FtmAscent;
    property tmDescent: Longint read FtmDescent write FtmDescent;
    property tmInternalLeading: Longint read FtmInternalLeading write FtmInternalLeading;
    property tmExternalLeading: Longint read FtmExternalLeading write FtmExternalLeading;
    property tmAveCharWidth: Longint read FtmAveCharWidth write FtmAveCharWidth;
    property tmMaxCharWidth: Longint read FtmMaxCharWidth write FtmMaxCharWidth;
    property tmWeight: Longint read FtmWeight write FtmWeight;
    property tmOverhang: Longint read FtmOverhang write FtmOverhang;
    property tmDigitizedAspectX: Longint read FtmDigitizedAspectX write FtmDigitizedAspectX;
    property tmDigitizedAspectY: Longint read FtmDigitizedAspectY write FtmDigitizedAspectY;
    property tmItalic: Byte read FtmItalic write FtmItalic;
    property tmUnderlined: Byte read FtmUnderlined write FtmUnderlined;
    property tmStruckOut: Byte read FtmStruckOut write FtmStruckOut;
    property tmPitchAndFamily: Byte read FtmPitchAndFamily write FtmPitchAndFamily;
    property tmCharSet: Byte read FtmCharSet write FtmCharSet;
  end;
  
  tagNEWTEXTMETRICAWrapper = class(TatRecordWrapper)
  private
    FtmHeight: Longint;
    FtmAscent: Longint;
    FtmDescent: Longint;
    FtmInternalLeading: Longint;
    FtmExternalLeading: Longint;
    FtmAveCharWidth: Longint;
    FtmMaxCharWidth: Longint;
    FtmWeight: Longint;
    FtmOverhang: Longint;
    FtmDigitizedAspectX: Longint;
    FtmDigitizedAspectY: Longint;
    FtmFirstChar: AnsiChar;
    FtmLastChar: AnsiChar;
    FtmDefaultChar: AnsiChar;
    FtmBreakChar: AnsiChar;
    FtmItalic: Byte;
    FtmUnderlined: Byte;
    FtmStruckOut: Byte;
    FtmPitchAndFamily: Byte;
    FtmCharSet: Byte;
    FntmFlags: DWORD;
    FntmSizeEM: UINT;
    FntmCellHeight: UINT;
    FntmAvgWidth: UINT;
  public
    constructor Create(ARecord: tagNEWTEXTMETRICA);
    function ObjToRec: tagNEWTEXTMETRICA;
  published
    property tmHeight: Longint read FtmHeight write FtmHeight;
    property tmAscent: Longint read FtmAscent write FtmAscent;
    property tmDescent: Longint read FtmDescent write FtmDescent;
    property tmInternalLeading: Longint read FtmInternalLeading write FtmInternalLeading;
    property tmExternalLeading: Longint read FtmExternalLeading write FtmExternalLeading;
    property tmAveCharWidth: Longint read FtmAveCharWidth write FtmAveCharWidth;
    property tmMaxCharWidth: Longint read FtmMaxCharWidth write FtmMaxCharWidth;
    property tmWeight: Longint read FtmWeight write FtmWeight;
    property tmOverhang: Longint read FtmOverhang write FtmOverhang;
    property tmDigitizedAspectX: Longint read FtmDigitizedAspectX write FtmDigitizedAspectX;
    property tmDigitizedAspectY: Longint read FtmDigitizedAspectY write FtmDigitizedAspectY;
    property tmFirstChar: AnsiChar read FtmFirstChar write FtmFirstChar;
    property tmLastChar: AnsiChar read FtmLastChar write FtmLastChar;
    property tmDefaultChar: AnsiChar read FtmDefaultChar write FtmDefaultChar;
    property tmBreakChar: AnsiChar read FtmBreakChar write FtmBreakChar;
    property tmItalic: Byte read FtmItalic write FtmItalic;
    property tmUnderlined: Byte read FtmUnderlined write FtmUnderlined;
    property tmStruckOut: Byte read FtmStruckOut write FtmStruckOut;
    property tmPitchAndFamily: Byte read FtmPitchAndFamily write FtmPitchAndFamily;
    property tmCharSet: Byte read FtmCharSet write FtmCharSet;
    property ntmFlags: DWORD read FntmFlags write FntmFlags;
    property ntmSizeEM: UINT read FntmSizeEM write FntmSizeEM;
    property ntmCellHeight: UINT read FntmCellHeight write FntmCellHeight;
    property ntmAvgWidth: UINT read FntmAvgWidth write FntmAvgWidth;
  end;
  
  tagNEWTEXTMETRICWWrapper = class(TatRecordWrapper)
  private
    FtmHeight: Longint;
    FtmAscent: Longint;
    FtmDescent: Longint;
    FtmInternalLeading: Longint;
    FtmExternalLeading: Longint;
    FtmAveCharWidth: Longint;
    FtmMaxCharWidth: Longint;
    FtmWeight: Longint;
    FtmOverhang: Longint;
    FtmDigitizedAspectX: Longint;
    FtmDigitizedAspectY: Longint;
    FtmItalic: Byte;
    FtmUnderlined: Byte;
    FtmStruckOut: Byte;
    FtmPitchAndFamily: Byte;
    FtmCharSet: Byte;
    FntmFlags: DWORD;
    FntmSizeEM: UINT;
    FntmCellHeight: UINT;
    FntmAvgWidth: UINT;
  public
    constructor Create(ARecord: tagNEWTEXTMETRICW);
    function ObjToRec: tagNEWTEXTMETRICW;
  published
    property tmHeight: Longint read FtmHeight write FtmHeight;
    property tmAscent: Longint read FtmAscent write FtmAscent;
    property tmDescent: Longint read FtmDescent write FtmDescent;
    property tmInternalLeading: Longint read FtmInternalLeading write FtmInternalLeading;
    property tmExternalLeading: Longint read FtmExternalLeading write FtmExternalLeading;
    property tmAveCharWidth: Longint read FtmAveCharWidth write FtmAveCharWidth;
    property tmMaxCharWidth: Longint read FtmMaxCharWidth write FtmMaxCharWidth;
    property tmWeight: Longint read FtmWeight write FtmWeight;
    property tmOverhang: Longint read FtmOverhang write FtmOverhang;
    property tmDigitizedAspectX: Longint read FtmDigitizedAspectX write FtmDigitizedAspectX;
    property tmDigitizedAspectY: Longint read FtmDigitizedAspectY write FtmDigitizedAspectY;
    property tmItalic: Byte read FtmItalic write FtmItalic;
    property tmUnderlined: Byte read FtmUnderlined write FtmUnderlined;
    property tmStruckOut: Byte read FtmStruckOut write FtmStruckOut;
    property tmPitchAndFamily: Byte read FtmPitchAndFamily write FtmPitchAndFamily;
    property tmCharSet: Byte read FtmCharSet write FtmCharSet;
    property ntmFlags: DWORD read FntmFlags write FntmFlags;
    property ntmSizeEM: UINT read FntmSizeEM write FntmSizeEM;
    property ntmCellHeight: UINT read FntmCellHeight write FntmCellHeight;
    property ntmAvgWidth: UINT read FntmAvgWidth write FntmAvgWidth;
  end;
  
  tagNEWTEXTMETRICEXAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNEWTEXTMETRICEXA);
    function ObjToRec: tagNEWTEXTMETRICEXA;
  published
  end;
  
  tagNEWTEXTMETRICEXWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNEWTEXTMETRICEXW);
    function ObjToRec: tagNEWTEXTMETRICEXW;
  published
  end;
  
  tagPELARRAYWrapper = class(TatRecordWrapper)
  private
    FpaXCount: Longint;
    FpaYCount: Longint;
    FpaXExt: Longint;
    FpaYExt: Longint;
    FpaRGBs: Byte;
  public
    constructor Create(ARecord: tagPELARRAY);
    function ObjToRec: tagPELARRAY;
  published
    property paXCount: Longint read FpaXCount write FpaXCount;
    property paYCount: Longint read FpaYCount write FpaYCount;
    property paXExt: Longint read FpaXExt write FpaXExt;
    property paYExt: Longint read FpaYExt write FpaYExt;
    property paRGBs: Byte read FpaRGBs write FpaRGBs;
  end;
  
  tagLOGBRUSHWrapper = class(TatRecordWrapper)
  private
    FlbStyle: UINT;
    FlbColor: COLORREF;
    FlbHatch: Longint;
  public
    constructor Create(ARecord: tagLOGBRUSH);
    function ObjToRec: tagLOGBRUSH;
  published
    property lbStyle: UINT read FlbStyle write FlbStyle;
    property lbColor: COLORREF read FlbColor write FlbColor;
    property lbHatch: Longint read FlbHatch write FlbHatch;
  end;
  
  tagLOGPENWrapper = class(TatRecordWrapper)
  private
    FlopnStyle: UINT;
    FlopnColor: COLORREF;
  public
    constructor Create(ARecord: tagLOGPEN);
    function ObjToRec: tagLOGPEN;
  published
    property lopnStyle: UINT read FlopnStyle write FlopnStyle;
    property lopnColor: COLORREF read FlopnColor write FlopnColor;
  end;
  
  tagEXTLOGPENWrapper = class(TatRecordWrapper)
  private
    FelpPenStyle: DWORD;
    FelpWidth: DWORD;
    FelpBrushStyle: UINT;
    FelpColor: COLORREF;
    FelpHatch: Longint;
    FelpNumEntries: DWORD;
  public
    constructor Create(ARecord: tagEXTLOGPEN);
    function ObjToRec: tagEXTLOGPEN;
  published
    property elpPenStyle: DWORD read FelpPenStyle write FelpPenStyle;
    property elpWidth: DWORD read FelpWidth write FelpWidth;
    property elpBrushStyle: UINT read FelpBrushStyle write FelpBrushStyle;
    property elpColor: COLORREF read FelpColor write FelpColor;
    property elpHatch: Longint read FelpHatch write FelpHatch;
    property elpNumEntries: DWORD read FelpNumEntries write FelpNumEntries;
  end;
  
  tagPALETTEENTRYWrapper = class(TatRecordWrapper)
  private
    FpeRed: Byte;
    FpeGreen: Byte;
    FpeBlue: Byte;
    FpeFlags: Byte;
  public
    constructor Create(ARecord: tagPALETTEENTRY);
    function ObjToRec: tagPALETTEENTRY;
  published
    property peRed: Byte read FpeRed write FpeRed;
    property peGreen: Byte read FpeGreen write FpeGreen;
    property peBlue: Byte read FpeBlue write FpeBlue;
    property peFlags: Byte read FpeFlags write FpeFlags;
  end;
  
  tagLOGPALETTEWrapper = class(TatRecordWrapper)
  private
    FpalVersion: Word;
    FpalNumEntries: Word;
  public
    constructor Create(ARecord: tagLOGPALETTE);
    function ObjToRec: tagLOGPALETTE;
  published
    property palVersion: Word read FpalVersion write FpalVersion;
    property palNumEntries: Word read FpalNumEntries write FpalNumEntries;
  end;
  
  TMaxLogPaletteWrapper = class(TatRecordWrapper)
  private
    FpalVersion: Word;
    FpalNumEntries: Word;
  public
    constructor Create(ARecord: TMaxLogPalette);
    function ObjToRec: TMaxLogPalette;
  published
    property palVersion: Word read FpalVersion write FpalVersion;
    property palNumEntries: Word read FpalNumEntries write FpalNumEntries;
  end;
  
  tagLOGFONTAWrapper = class(TatRecordWrapper)
  private
    FlfHeight: Longint;
    FlfWidth: Longint;
    FlfEscapement: Longint;
    FlfOrientation: Longint;
    FlfWeight: Longint;
    FlfItalic: Byte;
    FlfUnderline: Byte;
    FlfStrikeOut: Byte;
    FlfCharSet: Byte;
    FlfOutPrecision: Byte;
    FlfClipPrecision: Byte;
    FlfQuality: Byte;
    FlfPitchAndFamily: Byte;
  public
    constructor Create(ARecord: tagLOGFONTA);
    function ObjToRec: tagLOGFONTA;
  published
    property lfHeight: Longint read FlfHeight write FlfHeight;
    property lfWidth: Longint read FlfWidth write FlfWidth;
    property lfEscapement: Longint read FlfEscapement write FlfEscapement;
    property lfOrientation: Longint read FlfOrientation write FlfOrientation;
    property lfWeight: Longint read FlfWeight write FlfWeight;
    property lfItalic: Byte read FlfItalic write FlfItalic;
    property lfUnderline: Byte read FlfUnderline write FlfUnderline;
    property lfStrikeOut: Byte read FlfStrikeOut write FlfStrikeOut;
    property lfCharSet: Byte read FlfCharSet write FlfCharSet;
    property lfOutPrecision: Byte read FlfOutPrecision write FlfOutPrecision;
    property lfClipPrecision: Byte read FlfClipPrecision write FlfClipPrecision;
    property lfQuality: Byte read FlfQuality write FlfQuality;
    property lfPitchAndFamily: Byte read FlfPitchAndFamily write FlfPitchAndFamily;
  end;
  
  tagLOGFONTWWrapper = class(TatRecordWrapper)
  private
    FlfHeight: Longint;
    FlfWidth: Longint;
    FlfEscapement: Longint;
    FlfOrientation: Longint;
    FlfWeight: Longint;
    FlfItalic: Byte;
    FlfUnderline: Byte;
    FlfStrikeOut: Byte;
    FlfCharSet: Byte;
    FlfOutPrecision: Byte;
    FlfClipPrecision: Byte;
    FlfQuality: Byte;
    FlfPitchAndFamily: Byte;
  public
    constructor Create(ARecord: tagLOGFONTW);
    function ObjToRec: tagLOGFONTW;
  published
    property lfHeight: Longint read FlfHeight write FlfHeight;
    property lfWidth: Longint read FlfWidth write FlfWidth;
    property lfEscapement: Longint read FlfEscapement write FlfEscapement;
    property lfOrientation: Longint read FlfOrientation write FlfOrientation;
    property lfWeight: Longint read FlfWeight write FlfWeight;
    property lfItalic: Byte read FlfItalic write FlfItalic;
    property lfUnderline: Byte read FlfUnderline write FlfUnderline;
    property lfStrikeOut: Byte read FlfStrikeOut write FlfStrikeOut;
    property lfCharSet: Byte read FlfCharSet write FlfCharSet;
    property lfOutPrecision: Byte read FlfOutPrecision write FlfOutPrecision;
    property lfClipPrecision: Byte read FlfClipPrecision write FlfClipPrecision;
    property lfQuality: Byte read FlfQuality write FlfQuality;
    property lfPitchAndFamily: Byte read FlfPitchAndFamily write FlfPitchAndFamily;
  end;
  
  tagENUMLOGFONTAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMLOGFONTA);
    function ObjToRec: tagENUMLOGFONTA;
  published
  end;
  
  tagENUMLOGFONTWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMLOGFONTW);
    function ObjToRec: tagENUMLOGFONTW;
  published
  end;
  
  tagENUMLOGFONTEXAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMLOGFONTEXA);
    function ObjToRec: tagENUMLOGFONTEXA;
  published
  end;
  
  tagENUMLOGFONTEXWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMLOGFONTEXW);
    function ObjToRec: tagENUMLOGFONTEXW;
  published
  end;
  
  tagPANOSEWrapper = class(TatRecordWrapper)
  private
    FbFamilyType: Byte;
    FbSerifStyle: Byte;
    FbWeight: Byte;
    FbProportion: Byte;
    FbContrast: Byte;
    FbStrokeVariation: Byte;
    FbArmStyle: Byte;
    FbLetterform: Byte;
    FbMidline: Byte;
    FbXHeight: Byte;
  public
    constructor Create(ARecord: tagPANOSE);
    function ObjToRec: tagPANOSE;
  published
    property bFamilyType: Byte read FbFamilyType write FbFamilyType;
    property bSerifStyle: Byte read FbSerifStyle write FbSerifStyle;
    property bWeight: Byte read FbWeight write FbWeight;
    property bProportion: Byte read FbProportion write FbProportion;
    property bContrast: Byte read FbContrast write FbContrast;
    property bStrokeVariation: Byte read FbStrokeVariation write FbStrokeVariation;
    property bArmStyle: Byte read FbArmStyle write FbArmStyle;
    property bLetterform: Byte read FbLetterform write FbLetterform;
    property bMidline: Byte read FbMidline write FbMidline;
    property bXHeight: Byte read FbXHeight write FbXHeight;
  end;
  
  tagEXTLOGFONTAWrapper = class(TatRecordWrapper)
  private
    FelfVersion: DWORD;
    FelfStyleSize: DWORD;
    FelfMatch: DWORD;
    FelfReserved: DWORD;
    FelfCulture: DWORD;
  public
    constructor Create(ARecord: tagEXTLOGFONTA);
    function ObjToRec: tagEXTLOGFONTA;
  published
    property elfVersion: DWORD read FelfVersion write FelfVersion;
    property elfStyleSize: DWORD read FelfStyleSize write FelfStyleSize;
    property elfMatch: DWORD read FelfMatch write FelfMatch;
    property elfReserved: DWORD read FelfReserved write FelfReserved;
    property elfCulture: DWORD read FelfCulture write FelfCulture;
  end;
  
  tagEXTLOGFONTWWrapper = class(TatRecordWrapper)
  private
    FelfVersion: DWORD;
    FelfStyleSize: DWORD;
    FelfMatch: DWORD;
    FelfReserved: DWORD;
    FelfCulture: DWORD;
  public
    constructor Create(ARecord: tagEXTLOGFONTW);
    function ObjToRec: tagEXTLOGFONTW;
  published
    property elfVersion: DWORD read FelfVersion write FelfVersion;
    property elfStyleSize: DWORD read FelfStyleSize write FelfStyleSize;
    property elfMatch: DWORD read FelfMatch write FelfMatch;
    property elfReserved: DWORD read FelfReserved write FelfReserved;
    property elfCulture: DWORD read FelfCulture write FelfCulture;
  end;
  
  _devicemodeAWrapper = class(TatRecordWrapper)
  private
    FdmSpecVersion: Word;
    FdmDriverVersion: Word;
    FdmSize: Word;
    FdmDriverExtra: Word;
    FdmFields: DWORD;
    FdmOrientation: SHORT;
    FdmPaperSize: SHORT;
    FdmPaperLength: SHORT;
    FdmPaperWidth: SHORT;
    FdmScale: SHORT;
    FdmCopies: SHORT;
    FdmDefaultSource: SHORT;
    FdmPrintQuality: SHORT;
    FdmColor: SHORT;
    FdmDuplex: SHORT;
    FdmYResolution: SHORT;
    FdmTTOption: SHORT;
    FdmCollate: SHORT;
    FdmLogPixels: Word;
    FdmBitsPerPel: DWORD;
    FdmPelsWidth: DWORD;
    FdmPelsHeight: DWORD;
    FdmDisplayFlags: DWORD;
    FdmDisplayFrequency: DWORD;
    FdmICMMethod: DWORD;
    FdmICMIntent: DWORD;
    FdmMediaType: DWORD;
    FdmDitherType: DWORD;
    FdmICCManufacturer: DWORD;
    FdmICCModel: DWORD;
    FdmPanningWidth: DWORD;
    FdmPanningHeight: DWORD;
  public
    constructor Create(ARecord: _devicemodeA);
    function ObjToRec: _devicemodeA;
  published
    property dmSpecVersion: Word read FdmSpecVersion write FdmSpecVersion;
    property dmDriverVersion: Word read FdmDriverVersion write FdmDriverVersion;
    property dmSize: Word read FdmSize write FdmSize;
    property dmDriverExtra: Word read FdmDriverExtra write FdmDriverExtra;
    property dmFields: DWORD read FdmFields write FdmFields;
    property dmOrientation: SHORT read FdmOrientation write FdmOrientation;
    property dmPaperSize: SHORT read FdmPaperSize write FdmPaperSize;
    property dmPaperLength: SHORT read FdmPaperLength write FdmPaperLength;
    property dmPaperWidth: SHORT read FdmPaperWidth write FdmPaperWidth;
    property dmScale: SHORT read FdmScale write FdmScale;
    property dmCopies: SHORT read FdmCopies write FdmCopies;
    property dmDefaultSource: SHORT read FdmDefaultSource write FdmDefaultSource;
    property dmPrintQuality: SHORT read FdmPrintQuality write FdmPrintQuality;
    property dmColor: SHORT read FdmColor write FdmColor;
    property dmDuplex: SHORT read FdmDuplex write FdmDuplex;
    property dmYResolution: SHORT read FdmYResolution write FdmYResolution;
    property dmTTOption: SHORT read FdmTTOption write FdmTTOption;
    property dmCollate: SHORT read FdmCollate write FdmCollate;
    property dmLogPixels: Word read FdmLogPixels write FdmLogPixels;
    property dmBitsPerPel: DWORD read FdmBitsPerPel write FdmBitsPerPel;
    property dmPelsWidth: DWORD read FdmPelsWidth write FdmPelsWidth;
    property dmPelsHeight: DWORD read FdmPelsHeight write FdmPelsHeight;
    property dmDisplayFlags: DWORD read FdmDisplayFlags write FdmDisplayFlags;
    property dmDisplayFrequency: DWORD read FdmDisplayFrequency write FdmDisplayFrequency;
    property dmICMMethod: DWORD read FdmICMMethod write FdmICMMethod;
    property dmICMIntent: DWORD read FdmICMIntent write FdmICMIntent;
    property dmMediaType: DWORD read FdmMediaType write FdmMediaType;
    property dmDitherType: DWORD read FdmDitherType write FdmDitherType;
    property dmICCManufacturer: DWORD read FdmICCManufacturer write FdmICCManufacturer;
    property dmICCModel: DWORD read FdmICCModel write FdmICCModel;
    property dmPanningWidth: DWORD read FdmPanningWidth write FdmPanningWidth;
    property dmPanningHeight: DWORD read FdmPanningHeight write FdmPanningHeight;
  end;
  
  _devicemodeWWrapper = class(TatRecordWrapper)
  private
    FdmSpecVersion: Word;
    FdmDriverVersion: Word;
    FdmSize: Word;
    FdmDriverExtra: Word;
    FdmFields: DWORD;
    FdmOrientation: SHORT;
    FdmPaperSize: SHORT;
    FdmPaperLength: SHORT;
    FdmPaperWidth: SHORT;
    FdmScale: SHORT;
    FdmCopies: SHORT;
    FdmDefaultSource: SHORT;
    FdmPrintQuality: SHORT;
    FdmColor: SHORT;
    FdmDuplex: SHORT;
    FdmYResolution: SHORT;
    FdmTTOption: SHORT;
    FdmCollate: SHORT;
    FdmLogPixels: Word;
    FdmBitsPerPel: DWORD;
    FdmPelsWidth: DWORD;
    FdmPelsHeight: DWORD;
    FdmDisplayFlags: DWORD;
    FdmDisplayFrequency: DWORD;
    FdmICMMethod: DWORD;
    FdmICMIntent: DWORD;
    FdmMediaType: DWORD;
    FdmDitherType: DWORD;
    FdmICCManufacturer: DWORD;
    FdmICCModel: DWORD;
    FdmPanningWidth: DWORD;
    FdmPanningHeight: DWORD;
  public
    constructor Create(ARecord: _devicemodeW);
    function ObjToRec: _devicemodeW;
  published
    property dmSpecVersion: Word read FdmSpecVersion write FdmSpecVersion;
    property dmDriverVersion: Word read FdmDriverVersion write FdmDriverVersion;
    property dmSize: Word read FdmSize write FdmSize;
    property dmDriverExtra: Word read FdmDriverExtra write FdmDriverExtra;
    property dmFields: DWORD read FdmFields write FdmFields;
    property dmOrientation: SHORT read FdmOrientation write FdmOrientation;
    property dmPaperSize: SHORT read FdmPaperSize write FdmPaperSize;
    property dmPaperLength: SHORT read FdmPaperLength write FdmPaperLength;
    property dmPaperWidth: SHORT read FdmPaperWidth write FdmPaperWidth;
    property dmScale: SHORT read FdmScale write FdmScale;
    property dmCopies: SHORT read FdmCopies write FdmCopies;
    property dmDefaultSource: SHORT read FdmDefaultSource write FdmDefaultSource;
    property dmPrintQuality: SHORT read FdmPrintQuality write FdmPrintQuality;
    property dmColor: SHORT read FdmColor write FdmColor;
    property dmDuplex: SHORT read FdmDuplex write FdmDuplex;
    property dmYResolution: SHORT read FdmYResolution write FdmYResolution;
    property dmTTOption: SHORT read FdmTTOption write FdmTTOption;
    property dmCollate: SHORT read FdmCollate write FdmCollate;
    property dmLogPixels: Word read FdmLogPixels write FdmLogPixels;
    property dmBitsPerPel: DWORD read FdmBitsPerPel write FdmBitsPerPel;
    property dmPelsWidth: DWORD read FdmPelsWidth write FdmPelsWidth;
    property dmPelsHeight: DWORD read FdmPelsHeight write FdmPelsHeight;
    property dmDisplayFlags: DWORD read FdmDisplayFlags write FdmDisplayFlags;
    property dmDisplayFrequency: DWORD read FdmDisplayFrequency write FdmDisplayFrequency;
    property dmICMMethod: DWORD read FdmICMMethod write FdmICMMethod;
    property dmICMIntent: DWORD read FdmICMIntent write FdmICMIntent;
    property dmMediaType: DWORD read FdmMediaType write FdmMediaType;
    property dmDitherType: DWORD read FdmDitherType write FdmDitherType;
    property dmICCManufacturer: DWORD read FdmICCManufacturer write FdmICCManufacturer;
    property dmICCModel: DWORD read FdmICCModel write FdmICCModel;
    property dmPanningWidth: DWORD read FdmPanningWidth write FdmPanningWidth;
    property dmPanningHeight: DWORD read FdmPanningHeight write FdmPanningHeight;
  end;
  
  _DISPLAY_DEVICEAWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FStateFlags: DWORD;
  public
    constructor Create(ARecord: _DISPLAY_DEVICEA);
    function ObjToRec: _DISPLAY_DEVICEA;
  published
    property cb: DWORD read Fcb write Fcb;
    property StateFlags: DWORD read FStateFlags write FStateFlags;
  end;
  
  _DISPLAY_DEVICEWWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FStateFlags: DWORD;
  public
    constructor Create(ARecord: _DISPLAY_DEVICEW);
    function ObjToRec: _DISPLAY_DEVICEW;
  published
    property cb: DWORD read Fcb write Fcb;
    property StateFlags: DWORD read FStateFlags write FStateFlags;
  end;
  
  _RGNDATAHEADERWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FiType: DWORD;
    FnCount: DWORD;
    FnRgnSize: DWORD;
  public
    constructor Create(ARecord: _RGNDATAHEADER);
    function ObjToRec: _RGNDATAHEADER;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property iType: DWORD read FiType write FiType;
    property nCount: DWORD read FnCount write FnCount;
    property nRgnSize: DWORD read FnRgnSize write FnRgnSize;
  end;
  
  _RGNDATAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _RGNDATA);
    function ObjToRec: _RGNDATA;
  published
  end;
  
  _ABCWrapper = class(TatRecordWrapper)
  private
    FabcA: Integer;
    FabcB: UINT;
    FabcC: Integer;
  public
    constructor Create(ARecord: _ABC);
    function ObjToRec: _ABC;
  published
    property abcA: Integer read FabcA write FabcA;
    property abcB: UINT read FabcB write FabcB;
    property abcC: Integer read FabcC write FabcC;
  end;
  
  _ABCFLOATWrapper = class(TatRecordWrapper)
  private
    FabcfA: Single;
    FabcfB: Single;
    FabcfC: Single;
  public
    constructor Create(ARecord: _ABCFLOAT);
    function ObjToRec: _ABCFLOAT;
  published
    property abcfA: Single read FabcfA write FabcfA;
    property abcfB: Single read FabcfB write FabcfB;
    property abcfC: Single read FabcfC write FabcfC;
  end;
  
  _OUTLINETEXTMETRICAWrapper = class(TatRecordWrapper)
  private
    FotmSize: UINT;
    FotmFiller: Byte;
    FotmfsSelection: UINT;
    FotmfsType: UINT;
    FotmsCharSlopeRise: Integer;
    FotmsCharSlopeRun: Integer;
    FotmItalicAngle: Integer;
    FotmEMSquare: UINT;
    FotmAscent: Integer;
    FotmDescent: Integer;
    FotmLineGap: UINT;
    FotmsCapEmHeight: UINT;
    FotmsXHeight: UINT;
    FotmMacAscent: Integer;
    FotmMacDescent: Integer;
    FotmMacLineGap: UINT;
    FotmusMinimumPPEM: UINT;
    FotmsStrikeoutSize: UINT;
    FotmsStrikeoutPosition: Integer;
    FotmsUnderscoreSize: Integer;
    FotmsUnderscorePosition: Integer;
  public
    constructor Create(ARecord: _OUTLINETEXTMETRICA);
    function ObjToRec: _OUTLINETEXTMETRICA;
  published
    property otmSize: UINT read FotmSize write FotmSize;
    property otmFiller: Byte read FotmFiller write FotmFiller;
    property otmfsSelection: UINT read FotmfsSelection write FotmfsSelection;
    property otmfsType: UINT read FotmfsType write FotmfsType;
    property otmsCharSlopeRise: Integer read FotmsCharSlopeRise write FotmsCharSlopeRise;
    property otmsCharSlopeRun: Integer read FotmsCharSlopeRun write FotmsCharSlopeRun;
    property otmItalicAngle: Integer read FotmItalicAngle write FotmItalicAngle;
    property otmEMSquare: UINT read FotmEMSquare write FotmEMSquare;
    property otmAscent: Integer read FotmAscent write FotmAscent;
    property otmDescent: Integer read FotmDescent write FotmDescent;
    property otmLineGap: UINT read FotmLineGap write FotmLineGap;
    property otmsCapEmHeight: UINT read FotmsCapEmHeight write FotmsCapEmHeight;
    property otmsXHeight: UINT read FotmsXHeight write FotmsXHeight;
    property otmMacAscent: Integer read FotmMacAscent write FotmMacAscent;
    property otmMacDescent: Integer read FotmMacDescent write FotmMacDescent;
    property otmMacLineGap: UINT read FotmMacLineGap write FotmMacLineGap;
    property otmusMinimumPPEM: UINT read FotmusMinimumPPEM write FotmusMinimumPPEM;
    property otmsStrikeoutSize: UINT read FotmsStrikeoutSize write FotmsStrikeoutSize;
    property otmsStrikeoutPosition: Integer read FotmsStrikeoutPosition write FotmsStrikeoutPosition;
    property otmsUnderscoreSize: Integer read FotmsUnderscoreSize write FotmsUnderscoreSize;
    property otmsUnderscorePosition: Integer read FotmsUnderscorePosition write FotmsUnderscorePosition;
  end;
  
  _OUTLINETEXTMETRICWWrapper = class(TatRecordWrapper)
  private
    FotmSize: UINT;
    FotmFiller: Byte;
    FotmfsSelection: UINT;
    FotmfsType: UINT;
    FotmsCharSlopeRise: Integer;
    FotmsCharSlopeRun: Integer;
    FotmItalicAngle: Integer;
    FotmEMSquare: UINT;
    FotmAscent: Integer;
    FotmDescent: Integer;
    FotmLineGap: UINT;
    FotmsCapEmHeight: UINT;
    FotmsXHeight: UINT;
    FotmMacAscent: Integer;
    FotmMacDescent: Integer;
    FotmMacLineGap: UINT;
    FotmusMinimumPPEM: UINT;
    FotmsStrikeoutSize: UINT;
    FotmsStrikeoutPosition: Integer;
    FotmsUnderscoreSize: Integer;
    FotmsUnderscorePosition: Integer;
  public
    constructor Create(ARecord: _OUTLINETEXTMETRICW);
    function ObjToRec: _OUTLINETEXTMETRICW;
  published
    property otmSize: UINT read FotmSize write FotmSize;
    property otmFiller: Byte read FotmFiller write FotmFiller;
    property otmfsSelection: UINT read FotmfsSelection write FotmfsSelection;
    property otmfsType: UINT read FotmfsType write FotmfsType;
    property otmsCharSlopeRise: Integer read FotmsCharSlopeRise write FotmsCharSlopeRise;
    property otmsCharSlopeRun: Integer read FotmsCharSlopeRun write FotmsCharSlopeRun;
    property otmItalicAngle: Integer read FotmItalicAngle write FotmItalicAngle;
    property otmEMSquare: UINT read FotmEMSquare write FotmEMSquare;
    property otmAscent: Integer read FotmAscent write FotmAscent;
    property otmDescent: Integer read FotmDescent write FotmDescent;
    property otmLineGap: UINT read FotmLineGap write FotmLineGap;
    property otmsCapEmHeight: UINT read FotmsCapEmHeight write FotmsCapEmHeight;
    property otmsXHeight: UINT read FotmsXHeight write FotmsXHeight;
    property otmMacAscent: Integer read FotmMacAscent write FotmMacAscent;
    property otmMacDescent: Integer read FotmMacDescent write FotmMacDescent;
    property otmMacLineGap: UINT read FotmMacLineGap write FotmMacLineGap;
    property otmusMinimumPPEM: UINT read FotmusMinimumPPEM write FotmusMinimumPPEM;
    property otmsStrikeoutSize: UINT read FotmsStrikeoutSize write FotmsStrikeoutSize;
    property otmsStrikeoutPosition: Integer read FotmsStrikeoutPosition write FotmsStrikeoutPosition;
    property otmsUnderscoreSize: Integer read FotmsUnderscoreSize write FotmsUnderscoreSize;
    property otmsUnderscorePosition: Integer read FotmsUnderscorePosition write FotmsUnderscorePosition;
  end;
  
  tagPOLYTEXTAWrapper = class(TatRecordWrapper)
  private
    Fx: Integer;
    Fy: Integer;
    Fn: UINT;
    FuiFlags: UINT;
  public
    constructor Create(ARecord: tagPOLYTEXTA);
    function ObjToRec: tagPOLYTEXTA;
  published
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property n: UINT read Fn write Fn;
    property uiFlags: UINT read FuiFlags write FuiFlags;
  end;
  
  tagPOLYTEXTWWrapper = class(TatRecordWrapper)
  private
    Fx: Integer;
    Fy: Integer;
    Fn: UINT;
    FuiFlags: UINT;
  public
    constructor Create(ARecord: tagPOLYTEXTW);
    function ObjToRec: tagPOLYTEXTW;
  published
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property n: UINT read Fn write Fn;
    property uiFlags: UINT read FuiFlags write FuiFlags;
  end;
  
  _FIXEDWrapper = class(TatRecordWrapper)
  private
    Ffract: Word;
    Fvalue: SHORT;
  public
    constructor Create(ARecord: _FIXED);
    function ObjToRec: _FIXED;
  published
    property fract: Word read Ffract write Ffract;
    property value: SHORT read Fvalue write Fvalue;
  end;
  
  _MAT2Wrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MAT2);
    function ObjToRec: _MAT2;
  published
  end;
  
  _GLYPHMETRICSWrapper = class(TatRecordWrapper)
  private
    FgmBlackBoxX: UINT;
    FgmBlackBoxY: UINT;
    FgmCellIncX: SHORT;
    FgmCellIncY: SHORT;
  public
    constructor Create(ARecord: _GLYPHMETRICS);
    function ObjToRec: _GLYPHMETRICS;
  published
    property gmBlackBoxX: UINT read FgmBlackBoxX write FgmBlackBoxX;
    property gmBlackBoxY: UINT read FgmBlackBoxY write FgmBlackBoxY;
    property gmCellIncX: SHORT read FgmCellIncX write FgmCellIncX;
    property gmCellIncY: SHORT read FgmCellIncY write FgmCellIncY;
  end;
  
  tagPOINTFXWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagPOINTFX);
    function ObjToRec: tagPOINTFX;
  published
  end;
  
  tagTTPOLYCURVEWrapper = class(TatRecordWrapper)
  private
    FwType: Word;
    Fcpfx: Word;
  public
    constructor Create(ARecord: tagTTPOLYCURVE);
    function ObjToRec: tagTTPOLYCURVE;
  published
    property wType: Word read FwType write FwType;
    property cpfx: Word read Fcpfx write Fcpfx;
  end;
  
  tagTTPOLYGONHEADERWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    FdwType: DWORD;
  public
    constructor Create(ARecord: tagTTPOLYGONHEADER);
    function ObjToRec: tagTTPOLYGONHEADER;
  published
    property cb: DWORD read Fcb write Fcb;
    property dwType: DWORD read FdwType write FdwType;
  end;
  
  tagGCP_RESULTSAWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FnGlyphs: UINT;
    FnMaxFit: Integer;
  public
    constructor Create(ARecord: tagGCP_RESULTSA);
    function ObjToRec: tagGCP_RESULTSA;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property nGlyphs: UINT read FnGlyphs write FnGlyphs;
    property nMaxFit: Integer read FnMaxFit write FnMaxFit;
  end;
  
  tagGCP_RESULTSWWrapper = class(TatRecordWrapper)
  private
    FlStructSize: DWORD;
    FnGlyphs: UINT;
    FnMaxFit: Integer;
  public
    constructor Create(ARecord: tagGCP_RESULTSW);
    function ObjToRec: tagGCP_RESULTSW;
  published
    property lStructSize: DWORD read FlStructSize write FlStructSize;
    property nGlyphs: UINT read FnGlyphs write FnGlyphs;
    property nMaxFit: Integer read FnMaxFit write FnMaxFit;
  end;
  
  _RASTERIZER_STATUSWrapper = class(TatRecordWrapper)
  private
    FnSize: SHORT;
    FwFlags: SHORT;
    FnLanguageID: SHORT;
  public
    constructor Create(ARecord: _RASTERIZER_STATUS);
    function ObjToRec: _RASTERIZER_STATUS;
  published
    property nSize: SHORT read FnSize write FnSize;
    property wFlags: SHORT read FwFlags write FwFlags;
    property nLanguageID: SHORT read FnLanguageID write FnLanguageID;
  end;
  
  tagPIXELFORMATDESCRIPTORWrapper = class(TatRecordWrapper)
  private
    FnSize: Word;
    FnVersion: Word;
    FdwFlags: DWORD;
    FiPixelType: Byte;
    FcColorBits: Byte;
    FcRedBits: Byte;
    FcRedShift: Byte;
    FcGreenBits: Byte;
    FcGreenShift: Byte;
    FcBlueBits: Byte;
    FcBlueShift: Byte;
    FcAlphaBits: Byte;
    FcAlphaShift: Byte;
    FcAccumBits: Byte;
    FcAccumRedBits: Byte;
    FcAccumGreenBits: Byte;
    FcAccumBlueBits: Byte;
    FcAccumAlphaBits: Byte;
    FcDepthBits: Byte;
    FcStencilBits: Byte;
    FcAuxBuffers: Byte;
    FiLayerType: Byte;
    FbReserved: Byte;
    FdwLayerMask: DWORD;
    FdwVisibleMask: DWORD;
    FdwDamageMask: DWORD;
  public
    constructor Create(ARecord: tagPIXELFORMATDESCRIPTOR);
    function ObjToRec: tagPIXELFORMATDESCRIPTOR;
  published
    property nSize: Word read FnSize write FnSize;
    property nVersion: Word read FnVersion write FnVersion;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iPixelType: Byte read FiPixelType write FiPixelType;
    property cColorBits: Byte read FcColorBits write FcColorBits;
    property cRedBits: Byte read FcRedBits write FcRedBits;
    property cRedShift: Byte read FcRedShift write FcRedShift;
    property cGreenBits: Byte read FcGreenBits write FcGreenBits;
    property cGreenShift: Byte read FcGreenShift write FcGreenShift;
    property cBlueBits: Byte read FcBlueBits write FcBlueBits;
    property cBlueShift: Byte read FcBlueShift write FcBlueShift;
    property cAlphaBits: Byte read FcAlphaBits write FcAlphaBits;
    property cAlphaShift: Byte read FcAlphaShift write FcAlphaShift;
    property cAccumBits: Byte read FcAccumBits write FcAccumBits;
    property cAccumRedBits: Byte read FcAccumRedBits write FcAccumRedBits;
    property cAccumGreenBits: Byte read FcAccumGreenBits write FcAccumGreenBits;
    property cAccumBlueBits: Byte read FcAccumBlueBits write FcAccumBlueBits;
    property cAccumAlphaBits: Byte read FcAccumAlphaBits write FcAccumAlphaBits;
    property cDepthBits: Byte read FcDepthBits write FcDepthBits;
    property cStencilBits: Byte read FcStencilBits write FcStencilBits;
    property cAuxBuffers: Byte read FcAuxBuffers write FcAuxBuffers;
    property iLayerType: Byte read FiLayerType write FiLayerType;
    property bReserved: Byte read FbReserved write FbReserved;
    property dwLayerMask: DWORD read FdwLayerMask write FdwLayerMask;
    property dwVisibleMask: DWORD read FdwVisibleMask write FdwVisibleMask;
    property dwDamageMask: DWORD read FdwDamageMask write FdwDamageMask;
  end;
  
  tagWCRANGEWrapper = class(TatRecordWrapper)
  private
    FcGlyphs: SHORT;
  public
    constructor Create(ARecord: tagWCRANGE);
    function ObjToRec: tagWCRANGE;
  published
    property cGlyphs: SHORT read FcGlyphs write FcGlyphs;
  end;
  
  tagGLYPHSETWrapper = class(TatRecordWrapper)
  private
    FcbThis: DWORD;
    FflAccel: DWORD;
    FcGlyphsSupported: DWORD;
    FcRanges: DWORD;
  public
    constructor Create(ARecord: tagGLYPHSET);
    function ObjToRec: tagGLYPHSET;
  published
    property cbThis: DWORD read FcbThis write FcbThis;
    property flAccel: DWORD read FflAccel write FflAccel;
    property cGlyphsSupported: DWORD read FcGlyphsSupported write FcGlyphsSupported;
    property cRanges: DWORD read FcRanges write FcRanges;
  end;
  
  tagDESIGNVECTORWrapper = class(TatRecordWrapper)
  private
    FdvReserved: DWORD;
    FdvNumAxes: DWORD;
  public
    constructor Create(ARecord: tagDESIGNVECTOR);
    function ObjToRec: tagDESIGNVECTOR;
  published
    property dvReserved: DWORD read FdvReserved write FdvReserved;
    property dvNumAxes: DWORD read FdvNumAxes write FdvNumAxes;
  end;
  
  tagAXISINFOAWrapper = class(TatRecordWrapper)
  private
    FaxMinValue: Longint;
    FaxMaxValue: Longint;
  public
    constructor Create(ARecord: tagAXISINFOA);
    function ObjToRec: tagAXISINFOA;
  published
    property axMinValue: Longint read FaxMinValue write FaxMinValue;
    property axMaxValue: Longint read FaxMaxValue write FaxMaxValue;
  end;
  
  tagAXISINFOWWrapper = class(TatRecordWrapper)
  private
    FaxMinValue: Longint;
    FaxMaxValue: Longint;
  public
    constructor Create(ARecord: tagAXISINFOW);
    function ObjToRec: tagAXISINFOW;
  published
    property axMinValue: Longint read FaxMinValue write FaxMinValue;
    property axMaxValue: Longint read FaxMaxValue write FaxMaxValue;
  end;
  
  tagAXESLISTAWrapper = class(TatRecordWrapper)
  private
    FaxlReserved: DWORD;
    FaxlNumAxes: DWORD;
  public
    constructor Create(ARecord: tagAXESLISTA);
    function ObjToRec: tagAXESLISTA;
  published
    property axlReserved: DWORD read FaxlReserved write FaxlReserved;
    property axlNumAxes: DWORD read FaxlNumAxes write FaxlNumAxes;
  end;
  
  tagAXESLISTWWrapper = class(TatRecordWrapper)
  private
    FaxlReserved: DWORD;
    FaxlNumAxes: DWORD;
  public
    constructor Create(ARecord: tagAXESLISTW);
    function ObjToRec: tagAXESLISTW;
  published
    property axlReserved: DWORD read FaxlReserved write FaxlReserved;
    property axlNumAxes: DWORD read FaxlNumAxes write FaxlNumAxes;
  end;
  
  tagENUMLOGFONTEXDVAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMLOGFONTEXDVA);
    function ObjToRec: tagENUMLOGFONTEXDVA;
  published
  end;
  
  tagENUMLOGFONTEXDVWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMLOGFONTEXDVW);
    function ObjToRec: tagENUMLOGFONTEXDVW;
  published
  end;
  
  tagENUMTEXTMETRICAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMTEXTMETRICA);
    function ObjToRec: tagENUMTEXTMETRICA;
  published
  end;
  
  tagENUMTEXTMETRICWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagENUMTEXTMETRICW);
    function ObjToRec: tagENUMTEXTMETRICW;
  published
  end;
  
  _TRIVERTEXWrapper = class(TatRecordWrapper)
  private
    Fx: Longint;
    Fy: Longint;
    FRed: COLOR16;
    FGreen: COLOR16;
    FBlue: COLOR16;
    FAlpha: COLOR16;
  public
    constructor Create(ARecord: _TRIVERTEX);
    function ObjToRec: _TRIVERTEX;
  published
    property x: Longint read Fx write Fx;
    property y: Longint read Fy write Fy;
    property Red: COLOR16 read FRed write FRed;
    property Green: COLOR16 read FGreen write FGreen;
    property Blue: COLOR16 read FBlue write FBlue;
    property Alpha: COLOR16 read FAlpha write FAlpha;
  end;
  
  _GRADIENT_TRIANGLEWrapper = class(TatRecordWrapper)
  private
    FVertex1: ULONG;
    FVertex2: ULONG;
    FVertex3: ULONG;
  public
    constructor Create(ARecord: _GRADIENT_TRIANGLE);
    function ObjToRec: _GRADIENT_TRIANGLE;
  published
    property Vertex1: ULONG read FVertex1 write FVertex1;
    property Vertex2: ULONG read FVertex2 write FVertex2;
    property Vertex3: ULONG read FVertex3 write FVertex3;
  end;
  
  _GRADIENT_RECTWrapper = class(TatRecordWrapper)
  private
    FUpperLeft: ULONG;
    FLowerRight: ULONG;
  public
    constructor Create(ARecord: _GRADIENT_RECT);
    function ObjToRec: _GRADIENT_RECT;
  published
    property UpperLeft: ULONG read FUpperLeft write FUpperLeft;
    property LowerRight: ULONG read FLowerRight write FLowerRight;
  end;
  
  _BLENDFUNCTIONWrapper = class(TatRecordWrapper)
  private
    FBlendOp: BYTE;
    FBlendFlags: BYTE;
    FSourceConstantAlpha: BYTE;
    FAlphaFormat: BYTE;
  public
    constructor Create(ARecord: _BLENDFUNCTION);
    function ObjToRec: _BLENDFUNCTION;
  published
    property BlendOp: BYTE read FBlendOp write FBlendOp;
    property BlendFlags: BYTE read FBlendFlags write FBlendFlags;
    property SourceConstantAlpha: BYTE read FSourceConstantAlpha write FSourceConstantAlpha;
    property AlphaFormat: BYTE read FAlphaFormat write FAlphaFormat;
  end;
  
  tagDIBSECTIONWrapper = class(TatRecordWrapper)
  private
    FdshSection: THandle;
    FdsOffset: DWORD;
  public
    constructor Create(ARecord: tagDIBSECTION);
    function ObjToRec: tagDIBSECTION;
  published
    property dshSection: THandle read FdshSection write FdshSection;
    property dsOffset: DWORD read FdsOffset write FdsOffset;
  end;
  
  tagCOLORADJUSTMENTWrapper = class(TatRecordWrapper)
  private
    FcaSize: Word;
    FcaFlags: Word;
    FcaIlluminantIndex: Word;
    FcaRedGamma: Word;
    FcaGreenGamma: Word;
    FcaBlueGamma: Word;
    FcaReferenceBlack: Word;
    FcaReferenceWhite: Word;
    FcaContrast: SHORT;
    FcaBrightness: SHORT;
    FcaColorfulness: SHORT;
    FcaRedGreenTint: SHORT;
  public
    constructor Create(ARecord: tagCOLORADJUSTMENT);
    function ObjToRec: tagCOLORADJUSTMENT;
  published
    property caSize: Word read FcaSize write FcaSize;
    property caFlags: Word read FcaFlags write FcaFlags;
    property caIlluminantIndex: Word read FcaIlluminantIndex write FcaIlluminantIndex;
    property caRedGamma: Word read FcaRedGamma write FcaRedGamma;
    property caGreenGamma: Word read FcaGreenGamma write FcaGreenGamma;
    property caBlueGamma: Word read FcaBlueGamma write FcaBlueGamma;
    property caReferenceBlack: Word read FcaReferenceBlack write FcaReferenceBlack;
    property caReferenceWhite: Word read FcaReferenceWhite write FcaReferenceWhite;
    property caContrast: SHORT read FcaContrast write FcaContrast;
    property caBrightness: SHORT read FcaBrightness write FcaBrightness;
    property caColorfulness: SHORT read FcaColorfulness write FcaColorfulness;
    property caRedGreenTint: SHORT read FcaRedGreenTint write FcaRedGreenTint;
  end;
  
  _DOCINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: Integer;
    FfwType: DWORD;
  public
    constructor Create(ARecord: _DOCINFOA);
    function ObjToRec: _DOCINFOA;
  published
    property cbSize: Integer read FcbSize write FcbSize;
    property fwType: DWORD read FfwType write FfwType;
  end;
  
  _DOCINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: Integer;
    FfwType: DWORD;
  public
    constructor Create(ARecord: _DOCINFOW);
    function ObjToRec: _DOCINFOW;
  published
    property cbSize: Integer read FcbSize write FcbSize;
    property fwType: DWORD read FfwType write FfwType;
  end;
  
  tagKERNINGPAIRWrapper = class(TatRecordWrapper)
  private
    FwFirst: Word;
    FwSecond: Word;
    FiKernAmount: Integer;
  public
    constructor Create(ARecord: tagKERNINGPAIR);
    function ObjToRec: tagKERNINGPAIR;
  published
    property wFirst: Word read FwFirst write FwFirst;
    property wSecond: Word read FwSecond write FwSecond;
    property iKernAmount: Integer read FiKernAmount write FiKernAmount;
  end;
  
  tagEMRWrapper = class(TatRecordWrapper)
  private
    FiType: DWORD;
    FnSize: DWORD;
  public
    constructor Create(ARecord: tagEMR);
    function ObjToRec: tagEMR;
  published
    property iType: DWORD read FiType write FiType;
    property nSize: DWORD read FnSize write FnSize;
  end;
  
  tagEMRTEXTWrapper = class(TatRecordWrapper)
  private
    FnChars: DWORD;
    FoffString: DWORD;
    FfOptions: DWORD;
    FoffDx: DWORD;
  public
    constructor Create(ARecord: tagEMRTEXT);
    function ObjToRec: tagEMRTEXT;
  published
    property nChars: DWORD read FnChars write FnChars;
    property offString: DWORD read FoffString write FoffString;
    property fOptions: DWORD read FfOptions write FfOptions;
    property offDx: DWORD read FoffDx write FoffDx;
  end;
  
  tagABORTPATHWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagABORTPATH);
    function ObjToRec: tagABORTPATH;
  published
  end;
  
  tagEMRSELECTCLIPPATHWrapper = class(TatRecordWrapper)
  private
    FiMode: DWORD;
  public
    constructor Create(ARecord: tagEMRSELECTCLIPPATH);
    function ObjToRec: tagEMRSELECTCLIPPATH;
  published
    property iMode: DWORD read FiMode write FiMode;
  end;
  
  tagEMRSETMITERLIMITWrapper = class(TatRecordWrapper)
  private
    FeMiterLimit: Single;
  public
    constructor Create(ARecord: tagEMRSETMITERLIMIT);
    function ObjToRec: tagEMRSETMITERLIMIT;
  published
    property eMiterLimit: Single read FeMiterLimit write FeMiterLimit;
  end;
  
  tagEMRRESTOREDCWrapper = class(TatRecordWrapper)
  private
    FiRelative: Longint;
  public
    constructor Create(ARecord: tagEMRRESTOREDC);
    function ObjToRec: tagEMRRESTOREDC;
  published
    property iRelative: Longint read FiRelative write FiRelative;
  end;
  
  tagEMRSETARCDIRECTIONWrapper = class(TatRecordWrapper)
  private
    FiArcDirection: DWORD;
  public
    constructor Create(ARecord: tagEMRSETARCDIRECTION);
    function ObjToRec: tagEMRSETARCDIRECTION;
  published
    property iArcDirection: DWORD read FiArcDirection write FiArcDirection;
  end;
  
  tagEMRSETMAPPERFLAGSWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagEMRSETMAPPERFLAGS);
    function ObjToRec: tagEMRSETMAPPERFLAGS;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagEMRSETTEXTCOLORWrapper = class(TatRecordWrapper)
  private
    FcrColor: COLORREF;
  public
    constructor Create(ARecord: tagEMRSETTEXTCOLOR);
    function ObjToRec: tagEMRSETTEXTCOLOR;
  published
    property crColor: COLORREF read FcrColor write FcrColor;
  end;
  
  tagEMRSELECTOBJECTWrapper = class(TatRecordWrapper)
  private
    FihObject: DWORD;
  public
    constructor Create(ARecord: tagEMRSELECTOBJECT);
    function ObjToRec: tagEMRSELECTOBJECT;
  published
    property ihObject: DWORD read FihObject write FihObject;
  end;
  
  tagEMRSETCOLORSPACEWrapper = class(TatRecordWrapper)
  private
    FihCS: DWORD;
  public
    constructor Create(ARecord: tagEMRSETCOLORSPACE);
    function ObjToRec: tagEMRSETCOLORSPACE;
  published
    property ihCS: DWORD read FihCS write FihCS;
  end;
  
  tagEMRSELECTPALETTEWrapper = class(TatRecordWrapper)
  private
    FihPal: DWORD;
  public
    constructor Create(ARecord: tagEMRSELECTPALETTE);
    function ObjToRec: tagEMRSELECTPALETTE;
  published
    property ihPal: DWORD read FihPal write FihPal;
  end;
  
  tagEMRRESIZEPALETTEWrapper = class(TatRecordWrapper)
  private
    FihPal: DWORD;
    FcEntries: DWORD;
  public
    constructor Create(ARecord: tagEMRRESIZEPALETTE);
    function ObjToRec: tagEMRRESIZEPALETTE;
  published
    property ihPal: DWORD read FihPal write FihPal;
    property cEntries: DWORD read FcEntries write FcEntries;
  end;
  
  tagEMRSETPALETTEENTRIESWrapper = class(TatRecordWrapper)
  private
    FihPal: DWORD;
    FiStart: DWORD;
    FcEntries: DWORD;
  public
    constructor Create(ARecord: tagEMRSETPALETTEENTRIES);
    function ObjToRec: tagEMRSETPALETTEENTRIES;
  published
    property ihPal: DWORD read FihPal write FihPal;
    property iStart: DWORD read FiStart write FiStart;
    property cEntries: DWORD read FcEntries write FcEntries;
  end;
  
  tagEMRSETCOLORADJUSTMENTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRSETCOLORADJUSTMENT);
    function ObjToRec: tagEMRSETCOLORADJUSTMENT;
  published
  end;
  
  tagEMRGDICOMMENTWrapper = class(TatRecordWrapper)
  private
    FcbData: DWORD;
  public
    constructor Create(ARecord: tagEMRGDICOMMENT);
    function ObjToRec: tagEMRGDICOMMENT;
  published
    property cbData: DWORD read FcbData write FcbData;
  end;
  
  tagEMREOFWrapper = class(TatRecordWrapper)
  private
    FnPalEntries: DWORD;
    FoffPalEntries: DWORD;
    FnSizeLast: DWORD;
  public
    constructor Create(ARecord: tagEMREOF);
    function ObjToRec: tagEMREOF;
  published
    property nPalEntries: DWORD read FnPalEntries write FnPalEntries;
    property offPalEntries: DWORD read FoffPalEntries write FoffPalEntries;
    property nSizeLast: DWORD read FnSizeLast write FnSizeLast;
  end;
  
  tagEMRLINETOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRLINETO);
    function ObjToRec: tagEMRLINETO;
  published
  end;
  
  tagEMROFFSETCLIPRGNWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMROFFSETCLIPRGN);
    function ObjToRec: tagEMROFFSETCLIPRGN;
  published
  end;
  
  tagEMRFILLPATHWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRFILLPATH);
    function ObjToRec: tagEMRFILLPATH;
  published
  end;
  
  tagEMREXCLUDECLIPRECTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMREXCLUDECLIPRECT);
    function ObjToRec: tagEMREXCLUDECLIPRECT;
  published
  end;
  
  tagEMRSETVIEWPORTORGEXWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRSETVIEWPORTORGEX);
    function ObjToRec: tagEMRSETVIEWPORTORGEX;
  published
  end;
  
  tagEMRSETVIEWPORTEXTEXWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRSETVIEWPORTEXTEX);
    function ObjToRec: tagEMRSETVIEWPORTEXTEX;
  published
  end;
  
  tagEMRSCALEVIEWPORTEXTEXWrapper = class(TatRecordWrapper)
  private
    FxNum: Longint;
    FxDenom: Longint;
    FyNum: Longint;
    FyDenom: Longint;
  public
    constructor Create(ARecord: tagEMRSCALEVIEWPORTEXTEX);
    function ObjToRec: tagEMRSCALEVIEWPORTEXTEX;
  published
    property xNum: Longint read FxNum write FxNum;
    property xDenom: Longint read FxDenom write FxDenom;
    property yNum: Longint read FyNum write FyNum;
    property yDenom: Longint read FyDenom write FyDenom;
  end;
  
  tagEMRSETWORLDTRANSFORMWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRSETWORLDTRANSFORM);
    function ObjToRec: tagEMRSETWORLDTRANSFORM;
  published
  end;
  
  tagEMRMODIFYWORLDTRANSFORMWrapper = class(TatRecordWrapper)
  private
    FiMode: DWORD;
  public
    constructor Create(ARecord: tagEMRMODIFYWORLDTRANSFORM);
    function ObjToRec: tagEMRMODIFYWORLDTRANSFORM;
  published
    property iMode: DWORD read FiMode write FiMode;
  end;
  
  tagEMRSETPIXELVWrapper = class(TatRecordWrapper)
  private
    FcrColor: COLORREF;
  public
    constructor Create(ARecord: tagEMRSETPIXELV);
    function ObjToRec: tagEMRSETPIXELV;
  published
    property crColor: COLORREF read FcrColor write FcrColor;
  end;
  
  tagEMREXTFLOODFILLWrapper = class(TatRecordWrapper)
  private
    FcrColor: COLORREF;
    FiMode: DWORD;
  public
    constructor Create(ARecord: tagEMREXTFLOODFILL);
    function ObjToRec: tagEMREXTFLOODFILL;
  published
    property crColor: COLORREF read FcrColor write FcrColor;
    property iMode: DWORD read FiMode write FiMode;
  end;
  
  tagEMRELLIPSEWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRELLIPSE);
    function ObjToRec: tagEMRELLIPSE;
  published
  end;
  
  tagEMRROUNDRECTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRROUNDRECT);
    function ObjToRec: tagEMRROUNDRECT;
  published
  end;
  
  tagEMRARCWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRARC);
    function ObjToRec: tagEMRARC;
  published
  end;
  
  tagEMRANGLEARCWrapper = class(TatRecordWrapper)
  private
    FnRadius: DWORD;
    FeStartAngle: Single;
    FeSweepAngle: Single;
  public
    constructor Create(ARecord: tagEMRANGLEARC);
    function ObjToRec: tagEMRANGLEARC;
  published
    property nRadius: DWORD read FnRadius write FnRadius;
    property eStartAngle: Single read FeStartAngle write FeStartAngle;
    property eSweepAngle: Single read FeSweepAngle write FeSweepAngle;
  end;
  
  tagEMRPOLYLINEWrapper = class(TatRecordWrapper)
  private
    Fcptl: DWORD;
  public
    constructor Create(ARecord: tagEMRPOLYLINE);
    function ObjToRec: tagEMRPOLYLINE;
  published
    property cptl: DWORD read Fcptl write Fcptl;
  end;
  
  tagEMRPOLYLINE16Wrapper = class(TatRecordWrapper)
  private
    Fcpts: DWORD;
  public
    constructor Create(ARecord: tagEMRPOLYLINE16);
    function ObjToRec: tagEMRPOLYLINE16;
  published
    property cpts: DWORD read Fcpts write Fcpts;
  end;
  
  tagEMRPOLYDRAWWrapper = class(TatRecordWrapper)
  private
    Fcptl: DWORD;
  public
    constructor Create(ARecord: tagEMRPOLYDRAW);
    function ObjToRec: tagEMRPOLYDRAW;
  published
    property cptl: DWORD read Fcptl write Fcptl;
  end;
  
  tagEMRPOLYDRAW16Wrapper = class(TatRecordWrapper)
  private
    Fcpts: DWORD;
  public
    constructor Create(ARecord: tagEMRPOLYDRAW16);
    function ObjToRec: tagEMRPOLYDRAW16;
  published
    property cpts: DWORD read Fcpts write Fcpts;
  end;
  
  tagEMRPOLYPOLYLINEWrapper = class(TatRecordWrapper)
  private
    FnPolys: DWORD;
    Fcptl: DWORD;
  public
    constructor Create(ARecord: tagEMRPOLYPOLYLINE);
    function ObjToRec: tagEMRPOLYPOLYLINE;
  published
    property nPolys: DWORD read FnPolys write FnPolys;
    property cptl: DWORD read Fcptl write Fcptl;
  end;
  
  tagEMRPOLYPOLYLINE16Wrapper = class(TatRecordWrapper)
  private
    FnPolys: DWORD;
    Fcpts: DWORD;
  public
    constructor Create(ARecord: tagEMRPOLYPOLYLINE16);
    function ObjToRec: tagEMRPOLYPOLYLINE16;
  published
    property nPolys: DWORD read FnPolys write FnPolys;
    property cpts: DWORD read Fcpts write Fcpts;
  end;
  
  tagEMRINVERTRGNWrapper = class(TatRecordWrapper)
  private
    FcbRgnData: DWORD;
  public
    constructor Create(ARecord: tagEMRINVERTRGN);
    function ObjToRec: tagEMRINVERTRGN;
  published
    property cbRgnData: DWORD read FcbRgnData write FcbRgnData;
  end;
  
  tagEMRFILLRGNWrapper = class(TatRecordWrapper)
  private
    FcbRgnData: DWORD;
    FihBrush: DWORD;
  public
    constructor Create(ARecord: tagEMRFILLRGN);
    function ObjToRec: tagEMRFILLRGN;
  published
    property cbRgnData: DWORD read FcbRgnData write FcbRgnData;
    property ihBrush: DWORD read FihBrush write FihBrush;
  end;
  
  tagEMRFRAMERGNWrapper = class(TatRecordWrapper)
  private
    FcbRgnData: DWORD;
    FihBrush: DWORD;
  public
    constructor Create(ARecord: tagEMRFRAMERGN);
    function ObjToRec: tagEMRFRAMERGN;
  published
    property cbRgnData: DWORD read FcbRgnData write FcbRgnData;
    property ihBrush: DWORD read FihBrush write FihBrush;
  end;
  
  tagEMRGRADIENTFILLWrapper = class(TatRecordWrapper)
  private
    FnVer: DWORD;
    FnTri: DWORD;
    FulMode: ULONG;
  public
    constructor Create(ARecord: tagEMRGRADIENTFILL);
    function ObjToRec: tagEMRGRADIENTFILL;
  published
    property nVer: DWORD read FnVer write FnVer;
    property nTri: DWORD read FnTri write FnTri;
    property ulMode: ULONG read FulMode write FulMode;
  end;
  
  tagEMREXTSELECTCLIPRGNWrapper = class(TatRecordWrapper)
  private
    FcbRgnData: DWORD;
    FiMode: DWORD;
  public
    constructor Create(ARecord: tagEMREXTSELECTCLIPRGN);
    function ObjToRec: tagEMREXTSELECTCLIPRGN;
  published
    property cbRgnData: DWORD read FcbRgnData write FcbRgnData;
    property iMode: DWORD read FiMode write FiMode;
  end;
  
  tagEMREXTTEXTOUTAWrapper = class(TatRecordWrapper)
  private
    FiGraphicsMode: DWORD;
    FexScale: Single;
    FeyScale: Single;
  public
    constructor Create(ARecord: tagEMREXTTEXTOUTA);
    function ObjToRec: tagEMREXTTEXTOUTA;
  published
    property iGraphicsMode: DWORD read FiGraphicsMode write FiGraphicsMode;
    property exScale: Single read FexScale write FexScale;
    property eyScale: Single read FeyScale write FeyScale;
  end;
  
  tagEMRPOLYTEXTOUTAWrapper = class(TatRecordWrapper)
  private
    FiGraphicsMode: DWORD;
    FexScale: Single;
    FeyScale: Single;
    FcStrings: Longint;
  public
    constructor Create(ARecord: tagEMRPOLYTEXTOUTA);
    function ObjToRec: tagEMRPOLYTEXTOUTA;
  published
    property iGraphicsMode: DWORD read FiGraphicsMode write FiGraphicsMode;
    property exScale: Single read FexScale write FexScale;
    property eyScale: Single read FeyScale write FeyScale;
    property cStrings: Longint read FcStrings write FcStrings;
  end;
  
  tagEMRBITBLTWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FcxDest: Longint;
    FcyDest: Longint;
    FdwRop: DWORD;
    FxSrc: Longint;
    FySrc: Longint;
    FcrBkColorSrc: COLORREF;
    FiUsageSrc: DWORD;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
  public
    constructor Create(ARecord: tagEMRBITBLT);
    function ObjToRec: tagEMRBITBLT;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property cxDest: Longint read FcxDest write FcxDest;
    property cyDest: Longint read FcyDest write FcyDest;
    property dwRop: DWORD read FdwRop write FdwRop;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property crBkColorSrc: COLORREF read FcrBkColorSrc write FcrBkColorSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
  end;
  
  tagEMRSTRETCHBLTWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FcxDest: Longint;
    FcyDest: Longint;
    FdwRop: DWORD;
    FxSrc: Longint;
    FySrc: Longint;
    FcrBkColorSrc: COLORREF;
    FiUsageSrc: DWORD;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FcxSrc: Longint;
    FcySrc: Longint;
  public
    constructor Create(ARecord: tagEMRSTRETCHBLT);
    function ObjToRec: tagEMRSTRETCHBLT;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property cxDest: Longint read FcxDest write FcxDest;
    property cyDest: Longint read FcyDest write FcyDest;
    property dwRop: DWORD read FdwRop write FdwRop;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property crBkColorSrc: COLORREF read FcrBkColorSrc write FcrBkColorSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property cxSrc: Longint read FcxSrc write FcxSrc;
    property cySrc: Longint read FcySrc write FcySrc;
  end;
  
  tagEMRMASKBLTWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FcxDest: Longint;
    FcyDest: Longint;
    FdwRop: DWORD;
    FxSrc: Longint;
    FySrc: Longint;
    FcrBkColorSrc: COLORREF;
    FiUsageSrc: DWORD;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FxMask: Longint;
    FyMask: Longint;
    FiUsageMask: DWORD;
    FoffBmiMask: DWORD;
    FcbBmiMask: DWORD;
    FoffBitsMask: DWORD;
    FcbBitsMask: DWORD;
  public
    constructor Create(ARecord: tagEMRMASKBLT);
    function ObjToRec: tagEMRMASKBLT;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property cxDest: Longint read FcxDest write FcxDest;
    property cyDest: Longint read FcyDest write FcyDest;
    property dwRop: DWORD read FdwRop write FdwRop;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property crBkColorSrc: COLORREF read FcrBkColorSrc write FcrBkColorSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property xMask: Longint read FxMask write FxMask;
    property yMask: Longint read FyMask write FyMask;
    property iUsageMask: DWORD read FiUsageMask write FiUsageMask;
    property offBmiMask: DWORD read FoffBmiMask write FoffBmiMask;
    property cbBmiMask: DWORD read FcbBmiMask write FcbBmiMask;
    property offBitsMask: DWORD read FoffBitsMask write FoffBitsMask;
    property cbBitsMask: DWORD read FcbBitsMask write FcbBitsMask;
  end;
  
  tagEMRPLGBLTWrapper = class(TatRecordWrapper)
  private
    FxSrc: Longint;
    FySrc: Longint;
    FcxSrc: Longint;
    FcySrc: Longint;
    FcrBkColorSrc: COLORREF;
    FiUsageSrc: DWORD;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FxMask: Longint;
    FyMask: Longint;
    FiUsageMask: DWORD;
    FoffBmiMask: DWORD;
    FcbBmiMask: DWORD;
    FoffBitsMask: DWORD;
    FcbBitsMask: DWORD;
  public
    constructor Create(ARecord: tagEMRPLGBLT);
    function ObjToRec: tagEMRPLGBLT;
  published
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property cxSrc: Longint read FcxSrc write FcxSrc;
    property cySrc: Longint read FcySrc write FcySrc;
    property crBkColorSrc: COLORREF read FcrBkColorSrc write FcrBkColorSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property xMask: Longint read FxMask write FxMask;
    property yMask: Longint read FyMask write FyMask;
    property iUsageMask: DWORD read FiUsageMask write FiUsageMask;
    property offBmiMask: DWORD read FoffBmiMask write FoffBmiMask;
    property cbBmiMask: DWORD read FcbBmiMask write FcbBmiMask;
    property offBitsMask: DWORD read FoffBitsMask write FoffBitsMask;
    property cbBitsMask: DWORD read FcbBitsMask write FcbBitsMask;
  end;
  
  tagEMRSETDIBITSTODEVICEWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FxSrc: Longint;
    FySrc: Longint;
    FcxSrc: Longint;
    FcySrc: Longint;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FiUsageSrc: DWORD;
    FiStartScan: DWORD;
    FcScans: DWORD;
  public
    constructor Create(ARecord: tagEMRSETDIBITSTODEVICE);
    function ObjToRec: tagEMRSETDIBITSTODEVICE;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property cxSrc: Longint read FcxSrc write FcxSrc;
    property cySrc: Longint read FcySrc write FcySrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property iStartScan: DWORD read FiStartScan write FiStartScan;
    property cScans: DWORD read FcScans write FcScans;
  end;
  
  tagEMRSTRETCHDIBITSWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FxSrc: Longint;
    FySrc: Longint;
    FcxSrc: Longint;
    FcySrc: Longint;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FiUsageSrc: DWORD;
    FdwRop: DWORD;
    FcxDest: Longint;
    FcyDest: Longint;
  public
    constructor Create(ARecord: tagEMRSTRETCHDIBITS);
    function ObjToRec: tagEMRSTRETCHDIBITS;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property cxSrc: Longint read FcxSrc write FcxSrc;
    property cySrc: Longint read FcySrc write FcySrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property dwRop: DWORD read FdwRop write FdwRop;
    property cxDest: Longint read FcxDest write FcxDest;
    property cyDest: Longint read FcyDest write FcyDest;
  end;
  
  tagEMRALPHABLENDWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FcxDest: Longint;
    FcyDest: Longint;
    FdwRop: DWORD;
    FxSrc: Longint;
    FySrc: Longint;
    FcrBkColorSrc: COLORREF;
    FiUsageSrc: DWORD;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FcxSrc: Longint;
    FcySrc: Longint;
  public
    constructor Create(ARecord: tagEMRALPHABLEND);
    function ObjToRec: tagEMRALPHABLEND;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property cxDest: Longint read FcxDest write FcxDest;
    property cyDest: Longint read FcyDest write FcyDest;
    property dwRop: DWORD read FdwRop write FdwRop;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property crBkColorSrc: COLORREF read FcrBkColorSrc write FcrBkColorSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property cxSrc: Longint read FcxSrc write FcxSrc;
    property cySrc: Longint read FcySrc write FcySrc;
  end;
  
  tagEMRTRANSPARENTBLTWrapper = class(TatRecordWrapper)
  private
    FxDest: Longint;
    FyDest: Longint;
    FcxDest: Longint;
    FcyDest: Longint;
    FdwRop: DWORD;
    FxSrc: Longint;
    FySrc: Longint;
    FcrBkColorSrc: COLORREF;
    FiUsageSrc: DWORD;
    FoffBmiSrc: DWORD;
    FcbBmiSrc: DWORD;
    FoffBitsSrc: DWORD;
    FcbBitsSrc: DWORD;
    FcxSrc: Longint;
    FcySrc: Longint;
  public
    constructor Create(ARecord: tagEMRTRANSPARENTBLT);
    function ObjToRec: tagEMRTRANSPARENTBLT;
  published
    property xDest: Longint read FxDest write FxDest;
    property yDest: Longint read FyDest write FyDest;
    property cxDest: Longint read FcxDest write FcxDest;
    property cyDest: Longint read FcyDest write FcyDest;
    property dwRop: DWORD read FdwRop write FdwRop;
    property xSrc: Longint read FxSrc write FxSrc;
    property ySrc: Longint read FySrc write FySrc;
    property crBkColorSrc: COLORREF read FcrBkColorSrc write FcrBkColorSrc;
    property iUsageSrc: DWORD read FiUsageSrc write FiUsageSrc;
    property offBmiSrc: DWORD read FoffBmiSrc write FoffBmiSrc;
    property cbBmiSrc: DWORD read FcbBmiSrc write FcbBmiSrc;
    property offBitsSrc: DWORD read FoffBitsSrc write FoffBitsSrc;
    property cbBitsSrc: DWORD read FcbBitsSrc write FcbBitsSrc;
    property cxSrc: Longint read FcxSrc write FcxSrc;
    property cySrc: Longint read FcySrc write FcySrc;
  end;
  
  tagEMREXTCREATEFONTINDIRECTWWrapper = class(TatRecordWrapper)
  private
    FihFont: DWORD;
  public
    constructor Create(ARecord: tagEMREXTCREATEFONTINDIRECTW);
    function ObjToRec: tagEMREXTCREATEFONTINDIRECTW;
  published
    property ihFont: DWORD read FihFont write FihFont;
  end;
  
  tagEMRCREATEPALETTEWrapper = class(TatRecordWrapper)
  private
    FihPal: DWORD;
  public
    constructor Create(ARecord: tagEMRCREATEPALETTE);
    function ObjToRec: tagEMRCREATEPALETTE;
  published
    property ihPal: DWORD read FihPal write FihPal;
  end;
  
  tagEMRCREATECOLORSPACEWrapper = class(TatRecordWrapper)
  private
    FihCS: DWORD;
  public
    constructor Create(ARecord: tagEMRCREATECOLORSPACE);
    function ObjToRec: tagEMRCREATECOLORSPACE;
  published
    property ihCS: DWORD read FihCS write FihCS;
  end;
  
  tagEMRCREATEPENWrapper = class(TatRecordWrapper)
  private
    FihPen: DWORD;
  public
    constructor Create(ARecord: tagEMRCREATEPEN);
    function ObjToRec: tagEMRCREATEPEN;
  published
    property ihPen: DWORD read FihPen write FihPen;
  end;
  
  tagEMREXTCREATEPENWrapper = class(TatRecordWrapper)
  private
    FihPen: DWORD;
    FoffBmi: DWORD;
    FcbBmi: DWORD;
    FoffBits: DWORD;
    FcbBits: DWORD;
  public
    constructor Create(ARecord: tagEMREXTCREATEPEN);
    function ObjToRec: tagEMREXTCREATEPEN;
  published
    property ihPen: DWORD read FihPen write FihPen;
    property offBmi: DWORD read FoffBmi write FoffBmi;
    property cbBmi: DWORD read FcbBmi write FcbBmi;
    property offBits: DWORD read FoffBits write FoffBits;
    property cbBits: DWORD read FcbBits write FcbBits;
  end;
  
  tagEMRCREATEBRUSHINDIRECTWrapper = class(TatRecordWrapper)
  private
    FihBrush: DWORD;
  public
    constructor Create(ARecord: tagEMRCREATEBRUSHINDIRECT);
    function ObjToRec: tagEMRCREATEBRUSHINDIRECT;
  published
    property ihBrush: DWORD read FihBrush write FihBrush;
  end;
  
  tagEMRCREATEMONOBRUSHWrapper = class(TatRecordWrapper)
  private
    FihBrush: DWORD;
    FiUsage: DWORD;
    FoffBmi: DWORD;
    FcbBmi: DWORD;
    FoffBits: DWORD;
    FcbBits: DWORD;
  public
    constructor Create(ARecord: tagEMRCREATEMONOBRUSH);
    function ObjToRec: tagEMRCREATEMONOBRUSH;
  published
    property ihBrush: DWORD read FihBrush write FihBrush;
    property iUsage: DWORD read FiUsage write FiUsage;
    property offBmi: DWORD read FoffBmi write FoffBmi;
    property cbBmi: DWORD read FcbBmi write FcbBmi;
    property offBits: DWORD read FoffBits write FoffBits;
    property cbBits: DWORD read FcbBits write FcbBits;
  end;
  
  tagEMRCREATEDIBPATTERNBRUSHPTWrapper = class(TatRecordWrapper)
  private
    FihBrush: DWORD;
    FiUsage: DWORD;
    FoffBmi: DWORD;
    FcbBmi: DWORD;
    FoffBits: DWORD;
    FcbBits: DWORD;
  public
    constructor Create(ARecord: tagEMRCREATEDIBPATTERNBRUSHPT);
    function ObjToRec: tagEMRCREATEDIBPATTERNBRUSHPT;
  published
    property ihBrush: DWORD read FihBrush write FihBrush;
    property iUsage: DWORD read FiUsage write FiUsage;
    property offBmi: DWORD read FoffBmi write FoffBmi;
    property cbBmi: DWORD read FcbBmi write FcbBmi;
    property offBits: DWORD read FoffBits write FoffBits;
    property cbBits: DWORD read FcbBits write FcbBits;
  end;
  
  tagEMRFORMATWrapper = class(TatRecordWrapper)
  private
    FdSignature: DWORD;
    FnVersion: DWORD;
    FcbData: DWORD;
    FoffData: DWORD;
  public
    constructor Create(ARecord: tagEMRFORMAT);
    function ObjToRec: tagEMRFORMAT;
  published
    property dSignature: DWORD read FdSignature write FdSignature;
    property nVersion: DWORD read FnVersion write FnVersion;
    property cbData: DWORD read FcbData write FcbData;
    property offData: DWORD read FoffData write FoffData;
  end;
  
  tagEMRGLSRECORDWrapper = class(TatRecordWrapper)
  private
    FcbData: DWORD;
  public
    constructor Create(ARecord: tagEMRGLSRECORD);
    function ObjToRec: tagEMRGLSRECORD;
  published
    property cbData: DWORD read FcbData write FcbData;
  end;
  
  tagEMRGLSBOUNDEDRECORDWrapper = class(TatRecordWrapper)
  private
    FcbData: DWORD;
  public
    constructor Create(ARecord: tagEMRGLSBOUNDEDRECORD);
    function ObjToRec: tagEMRGLSBOUNDEDRECORD;
  published
    property cbData: DWORD read FcbData write FcbData;
  end;
  
  tagEMRPIXELFORMATWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagEMRPIXELFORMAT);
    function ObjToRec: tagEMRPIXELFORMAT;
  published
  end;
  
  _POINTFLOATWrapper = class(TatRecordWrapper)
  private
    Fx: Single;
    Fy: Single;
  public
    constructor Create(ARecord: _POINTFLOAT);
    function ObjToRec: _POINTFLOAT;
  published
    property x: Single read Fx write Fx;
    property y: Single read Fy write Fy;
  end;
  
  _GLYPHMETRICSFLOATWrapper = class(TatRecordWrapper)
  private
    FgmfBlackBoxX: Single;
    FgmfBlackBoxY: Single;
    FgmfCellIncX: Single;
    FgmfCellIncY: Single;
  public
    constructor Create(ARecord: _GLYPHMETRICSFLOAT);
    function ObjToRec: _GLYPHMETRICSFLOAT;
  published
    property gmfBlackBoxX: Single read FgmfBlackBoxX write FgmfBlackBoxX;
    property gmfBlackBoxY: Single read FgmfBlackBoxY write FgmfBlackBoxY;
    property gmfCellIncX: Single read FgmfCellIncX write FgmfCellIncX;
    property gmfCellIncY: Single read FgmfCellIncY write FgmfCellIncY;
  end;
  
  tagLAYERPLANEDESCRIPTORWrapper = class(TatRecordWrapper)
  private
    FnSize: Word;
    FnVersion: Word;
    FdwFlags: DWORD;
    FiPixelType: Byte;
    FcColorBits: Byte;
    FcRedBits: Byte;
    FcRedShift: Byte;
    FcGreenBits: Byte;
    FcGreenShift: Byte;
    FcBlueBits: Byte;
    FcBlueShift: Byte;
    FcAlphaBits: Byte;
    FcAlphaShift: Byte;
    FcAccumBits: Byte;
    FcAccumRedBits: Byte;
    FcAccumGreenBits: Byte;
    FcAccumBlueBits: Byte;
    FcAccumAlphaBits: Byte;
    FcDepthBits: Byte;
    FcStencilBits: Byte;
    FcAuxBuffers: Byte;
    FiLayerPlane: Byte;
    FbReserved: Byte;
    FcrTransparent: COLORREF;
  public
    constructor Create(ARecord: tagLAYERPLANEDESCRIPTOR);
    function ObjToRec: tagLAYERPLANEDESCRIPTOR;
  published
    property nSize: Word read FnSize write FnSize;
    property nVersion: Word read FnVersion write FnVersion;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iPixelType: Byte read FiPixelType write FiPixelType;
    property cColorBits: Byte read FcColorBits write FcColorBits;
    property cRedBits: Byte read FcRedBits write FcRedBits;
    property cRedShift: Byte read FcRedShift write FcRedShift;
    property cGreenBits: Byte read FcGreenBits write FcGreenBits;
    property cGreenShift: Byte read FcGreenShift write FcGreenShift;
    property cBlueBits: Byte read FcBlueBits write FcBlueBits;
    property cBlueShift: Byte read FcBlueShift write FcBlueShift;
    property cAlphaBits: Byte read FcAlphaBits write FcAlphaBits;
    property cAlphaShift: Byte read FcAlphaShift write FcAlphaShift;
    property cAccumBits: Byte read FcAccumBits write FcAccumBits;
    property cAccumRedBits: Byte read FcAccumRedBits write FcAccumRedBits;
    property cAccumGreenBits: Byte read FcAccumGreenBits write FcAccumGreenBits;
    property cAccumBlueBits: Byte read FcAccumBlueBits write FcAccumBlueBits;
    property cAccumAlphaBits: Byte read FcAccumAlphaBits write FcAccumAlphaBits;
    property cDepthBits: Byte read FcDepthBits write FcDepthBits;
    property cStencilBits: Byte read FcStencilBits write FcStencilBits;
    property cAuxBuffers: Byte read FcAuxBuffers write FcAuxBuffers;
    property iLayerPlane: Byte read FiLayerPlane write FiLayerPlane;
    property bReserved: Byte read FbReserved write FbReserved;
    property crTransparent: COLORREF read FcrTransparent write FcrTransparent;
  end;
  
  _WGLSWAPWrapper = class(TatRecordWrapper)
  private
    Fhdc: HDC;
    FuiFlags: UINT;
  public
    constructor Create(ARecord: _WGLSWAP);
    function ObjToRec: _WGLSWAP;
  published
    property hdc: HDC read Fhdc write Fhdc;
    property uiFlags: UINT read FuiFlags write FuiFlags;
  end;
  
  tagCREATESTRUCTAWrapper = class(TatRecordWrapper)
  private
    FhInstance: HINST;
    FhMenu: HMENU;
    FhwndParent: HWND;
    Fcy: Integer;
    Fcx: Integer;
    Fy: Integer;
    Fx: Integer;
    Fstyle: Longint;
    FdwExStyle: DWORD;
  public
    constructor Create(ARecord: tagCREATESTRUCTA);
    function ObjToRec: tagCREATESTRUCTA;
  published
    property hInstance: HINST read FhInstance write FhInstance;
    property hMenu: HMENU read FhMenu write FhMenu;
    property hwndParent: HWND read FhwndParent write FhwndParent;
    property cy: Integer read Fcy write Fcy;
    property cx: Integer read Fcx write Fcx;
    property y: Integer read Fy write Fy;
    property x: Integer read Fx write Fx;
    property style: Longint read Fstyle write Fstyle;
    property dwExStyle: DWORD read FdwExStyle write FdwExStyle;
  end;
  
  tagCREATESTRUCTWWrapper = class(TatRecordWrapper)
  private
    FhInstance: HINST;
    FhMenu: HMENU;
    FhwndParent: HWND;
    Fcy: Integer;
    Fcx: Integer;
    Fy: Integer;
    Fx: Integer;
    Fstyle: Longint;
    FdwExStyle: DWORD;
  public
    constructor Create(ARecord: tagCREATESTRUCTW);
    function ObjToRec: tagCREATESTRUCTW;
  published
    property hInstance: HINST read FhInstance write FhInstance;
    property hMenu: HMENU read FhMenu write FhMenu;
    property hwndParent: HWND read FhwndParent write FhwndParent;
    property cy: Integer read Fcy write Fcy;
    property cx: Integer read Fcx write Fcx;
    property y: Integer read Fy write Fy;
    property x: Integer read Fx write Fx;
    property style: Longint read Fstyle write Fstyle;
    property dwExStyle: DWORD read FdwExStyle write FdwExStyle;
  end;
  
  tagCBT_CREATEWNDAWrapper = class(TatRecordWrapper)
  private
    FhwndInsertAfter: HWND;
  public
    constructor Create(ARecord: tagCBT_CREATEWNDA);
    function ObjToRec: tagCBT_CREATEWNDA;
  published
    property hwndInsertAfter: HWND read FhwndInsertAfter write FhwndInsertAfter;
  end;
  
  tagCBTACTIVATESTRUCTWrapper = class(TatRecordWrapper)
  private
    FfMouse: BOOL;
    FhWndActive: HWND;
  public
    constructor Create(ARecord: tagCBTACTIVATESTRUCT);
    function ObjToRec: tagCBTACTIVATESTRUCT;
  published
    property fMouse: BOOL read FfMouse write FfMouse;
    property hWndActive: HWND read FhWndActive write FhWndActive;
  end;
  
  tagEVENTMSGWrapper = class(TatRecordWrapper)
  private
    Fmessage: UINT;
    FparamL: UINT;
    FparamH: UINT;
    Ftime: DWORD;
    Fhwnd: HWND;
  public
    constructor Create(ARecord: tagEVENTMSG);
    function ObjToRec: tagEVENTMSG;
  published
    property message: UINT read Fmessage write Fmessage;
    property paramL: UINT read FparamL write FparamL;
    property paramH: UINT read FparamH write FparamH;
    property time: DWORD read Ftime write Ftime;
    property hwnd: HWND read Fhwnd write Fhwnd;
  end;
  
  tagCWPSTRUCTWrapper = class(TatRecordWrapper)
  private
    FlParam: LPARAM;
    FwParam: WPARAM;
    Fmessage: UINT;
    Fhwnd: HWND;
  public
    constructor Create(ARecord: tagCWPSTRUCT);
    function ObjToRec: tagCWPSTRUCT;
  published
    property lParam: LPARAM read FlParam write FlParam;
    property wParam: WPARAM read FwParam write FwParam;
    property message: UINT read Fmessage write Fmessage;
    property hwnd: HWND read Fhwnd write Fhwnd;
  end;
  
  tagCWPRETSTRUCTWrapper = class(TatRecordWrapper)
  private
    FlResult: LRESULT;
    FlParam: LPARAM;
    FwParam: WPARAM;
    Fmessage: UINT;
    Fhwnd: HWND;
  public
    constructor Create(ARecord: tagCWPRETSTRUCT);
    function ObjToRec: tagCWPRETSTRUCT;
  published
    property lResult: LRESULT read FlResult write FlResult;
    property lParam: LPARAM read FlParam write FlParam;
    property wParam: WPARAM read FwParam write FwParam;
    property message: UINT read Fmessage write Fmessage;
    property hwnd: HWND read Fhwnd write Fhwnd;
  end;
  
  tagDEBUGHOOKINFOWrapper = class(TatRecordWrapper)
  private
    FidThread: DWORD;
    FidThreadInstaller: DWORD;
    FlParam: LPARAM;
    FwParam: WPARAM;
    Fcode: Integer;
  public
    constructor Create(ARecord: tagDEBUGHOOKINFO);
    function ObjToRec: tagDEBUGHOOKINFO;
  published
    property idThread: DWORD read FidThread write FidThread;
    property idThreadInstaller: DWORD read FidThreadInstaller write FidThreadInstaller;
    property lParam: LPARAM read FlParam write FlParam;
    property wParam: WPARAM read FwParam write FwParam;
    property code: Integer read Fcode write Fcode;
  end;
  
  tagMOUSEHOOKSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
    FwHitTestCode: UINT;
    FdwExtraInfo: DWORD;
  public
    constructor Create(ARecord: tagMOUSEHOOKSTRUCT);
    function ObjToRec: tagMOUSEHOOKSTRUCT;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
    property wHitTestCode: UINT read FwHitTestCode write FwHitTestCode;
    property dwExtraInfo: DWORD read FdwExtraInfo write FdwExtraInfo;
  end;
  
  tagHARDWAREHOOKSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
    Fmessage: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagHARDWAREHOOKSTRUCT);
    function ObjToRec: tagHARDWAREHOOKSTRUCT;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
    property message: UINT read Fmessage write Fmessage;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagMOUSEMOVEPOINTWrapper = class(TatRecordWrapper)
  private
    Fx: Integer;
    Fy: Integer;
    Ftime: DWORD;
    FdwExtraInfo: DWORD;
  public
    constructor Create(ARecord: tagMOUSEMOVEPOINT);
    function ObjToRec: tagMOUSEMOVEPOINT;
  published
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property time: DWORD read Ftime write Ftime;
    property dwExtraInfo: DWORD read FdwExtraInfo write FdwExtraInfo;
  end;
  
  tagUSEROBJECTFLAGSWrapper = class(TatRecordWrapper)
  private
    FfInherit: BOOL;
    FfReserved: BOOL;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagUSEROBJECTFLAGS);
    function ObjToRec: tagUSEROBJECTFLAGS;
  published
    property fInherit: BOOL read FfInherit write FfInherit;
    property fReserved: BOOL read FfReserved write FfReserved;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagWNDCLASSEXAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    Fstyle: UINT;
    FcbClsExtra: Integer;
    FcbWndExtra: Integer;
    FhInstance: HINST;
    FhIcon: HICON;
    FhCursor: HCURSOR;
    FhbrBackground: HBRUSH;
    FhIconSm: HICON;
  public
    constructor Create(ARecord: tagWNDCLASSEXA);
    function ObjToRec: tagWNDCLASSEXA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property style: UINT read Fstyle write Fstyle;
    property cbClsExtra: Integer read FcbClsExtra write FcbClsExtra;
    property cbWndExtra: Integer read FcbWndExtra write FcbWndExtra;
    property hInstance: HINST read FhInstance write FhInstance;
    property hIcon: HICON read FhIcon write FhIcon;
    property hCursor: HCURSOR read FhCursor write FhCursor;
    property hbrBackground: HBRUSH read FhbrBackground write FhbrBackground;
    property hIconSm: HICON read FhIconSm write FhIconSm;
  end;
  
  tagWNDCLASSEXWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    Fstyle: UINT;
    FcbClsExtra: Integer;
    FcbWndExtra: Integer;
    FhInstance: HINST;
    FhIcon: HICON;
    FhCursor: HCURSOR;
    FhbrBackground: HBRUSH;
    FhIconSm: HICON;
  public
    constructor Create(ARecord: tagWNDCLASSEXW);
    function ObjToRec: tagWNDCLASSEXW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property style: UINT read Fstyle write Fstyle;
    property cbClsExtra: Integer read FcbClsExtra write FcbClsExtra;
    property cbWndExtra: Integer read FcbWndExtra write FcbWndExtra;
    property hInstance: HINST read FhInstance write FhInstance;
    property hIcon: HICON read FhIcon write FhIcon;
    property hCursor: HCURSOR read FhCursor write FhCursor;
    property hbrBackground: HBRUSH read FhbrBackground write FhbrBackground;
    property hIconSm: HICON read FhIconSm write FhIconSm;
  end;
  
  tagWNDCLASSAWrapper = class(TatRecordWrapper)
  private
    Fstyle: UINT;
    FcbClsExtra: Integer;
    FcbWndExtra: Integer;
    FhInstance: HINST;
    FhIcon: HICON;
    FhCursor: HCURSOR;
    FhbrBackground: HBRUSH;
  public
    constructor Create(ARecord: tagWNDCLASSA);
    function ObjToRec: tagWNDCLASSA;
  published
    property style: UINT read Fstyle write Fstyle;
    property cbClsExtra: Integer read FcbClsExtra write FcbClsExtra;
    property cbWndExtra: Integer read FcbWndExtra write FcbWndExtra;
    property hInstance: HINST read FhInstance write FhInstance;
    property hIcon: HICON read FhIcon write FhIcon;
    property hCursor: HCURSOR read FhCursor write FhCursor;
    property hbrBackground: HBRUSH read FhbrBackground write FhbrBackground;
  end;
  
  tagWNDCLASSWWrapper = class(TatRecordWrapper)
  private
    Fstyle: UINT;
    FcbClsExtra: Integer;
    FcbWndExtra: Integer;
    FhInstance: HINST;
    FhIcon: HICON;
    FhCursor: HCURSOR;
    FhbrBackground: HBRUSH;
  public
    constructor Create(ARecord: tagWNDCLASSW);
    function ObjToRec: tagWNDCLASSW;
  published
    property style: UINT read Fstyle write Fstyle;
    property cbClsExtra: Integer read FcbClsExtra write FcbClsExtra;
    property cbWndExtra: Integer read FcbWndExtra write FcbWndExtra;
    property hInstance: HINST read FhInstance write FhInstance;
    property hIcon: HICON read FhIcon write FhIcon;
    property hCursor: HCURSOR read FhCursor write FhCursor;
    property hbrBackground: HBRUSH read FhbrBackground write FhbrBackground;
  end;
  
  tagMSGWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
    Fmessage: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
    Ftime: DWORD;
  public
    constructor Create(ARecord: tagMSG);
    function ObjToRec: tagMSG;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
    property message: UINT read Fmessage write Fmessage;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
    property time: DWORD read Ftime write Ftime;
  end;
  
  tagMINMAXINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagMINMAXINFO);
    function ObjToRec: tagMINMAXINFO;
  published
  end;
  
  tagCOPYDATASTRUCTWrapper = class(TatRecordWrapper)
  private
    FdwData: DWORD;
    FcbData: DWORD;
  public
    constructor Create(ARecord: tagCOPYDATASTRUCT);
    function ObjToRec: tagCOPYDATASTRUCT;
  published
    property dwData: DWORD read FdwData write FdwData;
    property cbData: DWORD read FcbData write FcbData;
  end;
  
  tagMDINEXTMENUWrapper = class(TatRecordWrapper)
  private
    FhmenuIn: HMENU;
    FhmenuNext: HMENU;
    FhwndNext: HWND;
  public
    constructor Create(ARecord: tagMDINEXTMENU);
    function ObjToRec: tagMDINEXTMENU;
  published
    property hmenuIn: HMENU read FhmenuIn write FhmenuIn;
    property hmenuNext: HMENU read FhmenuNext write FhmenuNext;
    property hwndNext: HWND read FhwndNext write FhwndNext;
  end;
  
  tagWINDOWPOSWrapper = class(TatRecordWrapper)
  private
    Fhwnd: HWND;
    FhwndInsertAfter: HWND;
    Fx: Integer;
    Fy: Integer;
    Fcx: Integer;
    Fcy: Integer;
    Fflags: UINT;
  public
    constructor Create(ARecord: tagWINDOWPOS);
    function ObjToRec: tagWINDOWPOS;
  published
    property hwnd: HWND read Fhwnd write Fhwnd;
    property hwndInsertAfter: HWND read FhwndInsertAfter write FhwndInsertAfter;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property cx: Integer read Fcx write Fcx;
    property cy: Integer read Fcy write Fcy;
    property flags: UINT read Fflags write Fflags;
  end;
  
  tagNCCALCSIZE_PARAMSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagNCCALCSIZE_PARAMS);
    function ObjToRec: tagNCCALCSIZE_PARAMS;
  published
  end;
  
  tagTRACKMOUSEEVENTWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwFlags: DWORD;
    FhwndTrack: HWND;
    FdwHoverTime: DWORD;
  public
    constructor Create(ARecord: tagTRACKMOUSEEVENT);
    function ObjToRec: tagTRACKMOUSEEVENT;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property hwndTrack: HWND read FhwndTrack write FhwndTrack;
    property dwHoverTime: DWORD read FdwHoverTime write FdwHoverTime;
  end;
  
  tagACCELWrapper = class(TatRecordWrapper)
  private
    FfVirt: Word;
    Fkey: Word;
    Fcmd: Word;
  public
    constructor Create(ARecord: tagACCEL);
    function ObjToRec: tagACCEL;
  published
    property fVirt: Word read FfVirt write FfVirt;
    property key: Word read Fkey write Fkey;
    property cmd: Word read Fcmd write Fcmd;
  end;
  
  tagPAINTSTRUCTWrapper = class(TatRecordWrapper)
  private
    Fhdc: HDC;
    FfErase: BOOL;
    FfRestore: BOOL;
    FfIncUpdate: BOOL;
  public
    constructor Create(ARecord: tagPAINTSTRUCT);
    function ObjToRec: tagPAINTSTRUCT;
  published
    property hdc: HDC read Fhdc write Fhdc;
    property fErase: BOOL read FfErase write FfErase;
    property fRestore: BOOL read FfRestore write FfRestore;
    property fIncUpdate: BOOL read FfIncUpdate write FfIncUpdate;
  end;
  
  tagWINDOWPLACEMENTWrapper = class(TatRecordWrapper)
  private
    Flength: UINT;
    Fflags: UINT;
    FshowCmd: UINT;
  public
    constructor Create(ARecord: tagWINDOWPLACEMENT);
    function ObjToRec: tagWINDOWPLACEMENT;
  published
    property length: UINT read Flength write Flength;
    property flags: UINT read Fflags write Fflags;
    property showCmd: UINT read FshowCmd write FshowCmd;
  end;
  
  tagNMHDRWrapper = class(TatRecordWrapper)
  private
    FhwndFrom: HWND;
    FidFrom: UINT;
    Fcode: Integer;
  public
    constructor Create(ARecord: tagNMHDR);
    function ObjToRec: tagNMHDR;
  published
    property hwndFrom: HWND read FhwndFrom write FhwndFrom;
    property idFrom: UINT read FidFrom write FidFrom;
    property code: Integer read Fcode write Fcode;
  end;
  
  tagSTYLESTRUCTWrapper = class(TatRecordWrapper)
  private
    FstyleOld: DWORD;
    FstyleNew: DWORD;
  public
    constructor Create(ARecord: tagSTYLESTRUCT);
    function ObjToRec: tagSTYLESTRUCT;
  published
    property styleOld: DWORD read FstyleOld write FstyleOld;
    property styleNew: DWORD read FstyleNew write FstyleNew;
  end;
  
  tagMEASUREITEMSTRUCTWrapper = class(TatRecordWrapper)
  private
    FCtlType: UINT;
    FCtlID: UINT;
    FitemID: UINT;
    FitemWidth: UINT;
    FitemHeight: UINT;
    FitemData: DWORD;
  public
    constructor Create(ARecord: tagMEASUREITEMSTRUCT);
    function ObjToRec: tagMEASUREITEMSTRUCT;
  published
    property CtlType: UINT read FCtlType write FCtlType;
    property CtlID: UINT read FCtlID write FCtlID;
    property itemID: UINT read FitemID write FitemID;
    property itemWidth: UINT read FitemWidth write FitemWidth;
    property itemHeight: UINT read FitemHeight write FitemHeight;
    property itemData: DWORD read FitemData write FitemData;
  end;
  
  tagDRAWITEMSTRUCTWrapper = class(TatRecordWrapper)
  private
    FCtlType: UINT;
    FCtlID: UINT;
    FitemID: UINT;
    FitemAction: UINT;
    FitemState: UINT;
    FhwndItem: HWND;
    FhDC: HDC;
    FitemData: DWORD;
  public
    constructor Create(ARecord: tagDRAWITEMSTRUCT);
    function ObjToRec: tagDRAWITEMSTRUCT;
  published
    property CtlType: UINT read FCtlType write FCtlType;
    property CtlID: UINT read FCtlID write FCtlID;
    property itemID: UINT read FitemID write FitemID;
    property itemAction: UINT read FitemAction write FitemAction;
    property itemState: UINT read FitemState write FitemState;
    property hwndItem: HWND read FhwndItem write FhwndItem;
    property hDC: HDC read FhDC write FhDC;
    property itemData: DWORD read FitemData write FitemData;
  end;
  
  tagDELETEITEMSTRUCTWrapper = class(TatRecordWrapper)
  private
    FCtlType: UINT;
    FCtlID: UINT;
    FitemID: UINT;
    FhwndItem: HWND;
    FitemData: UINT;
  public
    constructor Create(ARecord: tagDELETEITEMSTRUCT);
    function ObjToRec: tagDELETEITEMSTRUCT;
  published
    property CtlType: UINT read FCtlType write FCtlType;
    property CtlID: UINT read FCtlID write FCtlID;
    property itemID: UINT read FitemID write FitemID;
    property hwndItem: HWND read FhwndItem write FhwndItem;
    property itemData: UINT read FitemData write FitemData;
  end;
  
  tagCOMPAREITEMSTRUCTWrapper = class(TatRecordWrapper)
  private
    FCtlType: UINT;
    FCtlID: UINT;
    FhwndItem: HWND;
    FitemID1: UINT;
    FitemData1: DWORD;
    FitemID2: UINT;
    FitemData2: DWORD;
    FdwLocaleId: DWORD;
  public
    constructor Create(ARecord: tagCOMPAREITEMSTRUCT);
    function ObjToRec: tagCOMPAREITEMSTRUCT;
  published
    property CtlType: UINT read FCtlType write FCtlType;
    property CtlID: UINT read FCtlID write FCtlID;
    property hwndItem: HWND read FhwndItem write FhwndItem;
    property itemID1: UINT read FitemID1 write FitemID1;
    property itemData1: DWORD read FitemData1 write FitemData1;
    property itemID2: UINT read FitemID2 write FitemID2;
    property itemData2: DWORD read FitemData2 write FitemData2;
    property dwLocaleId: DWORD read FdwLocaleId write FdwLocaleId;
  end;
  
  tagBROADCASTSYSMSGWrapper = class(TatRecordWrapper)
  private
    FuiMessage: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagBROADCASTSYSMSG);
    function ObjToRec: tagBROADCASTSYSMSG;
  published
    property uiMessage: UINT read FuiMessage write FuiMessage;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  FLASHWINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    Fhwnd: HWND;
    FdwFlags: DWORD;
    FuCount: UINT;
    FdwTimeout: DWORD;
  public
    constructor Create(ARecord: FLASHWINFO);
    function ObjToRec: FLASHWINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property hwnd: HWND read Fhwnd write Fhwnd;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property uCount: UINT read FuCount write FuCount;
    property dwTimeout: DWORD read FdwTimeout write FdwTimeout;
  end;
  
  DLGTEMPLATEWrapper = class(TatRecordWrapper)
  private
    Fstyle: DWORD;
    FdwExtendedStyle: DWORD;
    Fcdit: Word;
    Fx: SHORT;
    Fy: SHORT;
    Fcx: SHORT;
    Fcy: SHORT;
  public
    constructor Create(ARecord: DLGTEMPLATE);
    function ObjToRec: DLGTEMPLATE;
  published
    property style: DWORD read Fstyle write Fstyle;
    property dwExtendedStyle: DWORD read FdwExtendedStyle write FdwExtendedStyle;
    property cdit: Word read Fcdit write Fcdit;
    property x: SHORT read Fx write Fx;
    property y: SHORT read Fy write Fy;
    property cx: SHORT read Fcx write Fcx;
    property cy: SHORT read Fcy write Fcy;
  end;
  
  DLGITEMTEMPLATEWrapper = class(TatRecordWrapper)
  private
    Fstyle: DWORD;
    FdwExtendedStyle: DWORD;
    Fx: SHORT;
    Fy: SHORT;
    Fcx: SHORT;
    Fcy: SHORT;
    Fid: Word;
  public
    constructor Create(ARecord: DLGITEMTEMPLATE);
    function ObjToRec: DLGITEMTEMPLATE;
  published
    property style: DWORD read Fstyle write Fstyle;
    property dwExtendedStyle: DWORD read FdwExtendedStyle write FdwExtendedStyle;
    property x: SHORT read Fx write Fx;
    property y: SHORT read Fy write Fy;
    property cx: SHORT read Fcx write Fcx;
    property cy: SHORT read Fcy write Fcy;
    property id: Word read Fid write Fid;
  end;
  
  tagMOUSEINPUTWrapper = class(TatRecordWrapper)
  private
    Fdx: Longint;
    Fdy: Longint;
    FmouseData: DWORD;
    FdwFlags: DWORD;
    Ftime: DWORD;
    FdwExtraInfo: DWORD;
  public
    constructor Create(ARecord: tagMOUSEINPUT);
    function ObjToRec: tagMOUSEINPUT;
  published
    property dx: Longint read Fdx write Fdx;
    property dy: Longint read Fdy write Fdy;
    property mouseData: DWORD read FmouseData write FmouseData;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property time: DWORD read Ftime write Ftime;
    property dwExtraInfo: DWORD read FdwExtraInfo write FdwExtraInfo;
  end;
  
  tagKEYBDINPUTWrapper = class(TatRecordWrapper)
  private
    FwVk: WORD;
    FwScan: WORD;
    FdwFlags: DWORD;
    Ftime: DWORD;
    FdwExtraInfo: DWORD;
  public
    constructor Create(ARecord: tagKEYBDINPUT);
    function ObjToRec: tagKEYBDINPUT;
  published
    property wVk: WORD read FwVk write FwVk;
    property wScan: WORD read FwScan write FwScan;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property time: DWORD read Ftime write Ftime;
    property dwExtraInfo: DWORD read FdwExtraInfo write FdwExtraInfo;
  end;
  
  tagHARDWAREINPUTWrapper = class(TatRecordWrapper)
  private
    FuMsg: DWORD;
    FwParamL: WORD;
    FwParamH: WORD;
  public
    constructor Create(ARecord: tagHARDWAREINPUT);
    function ObjToRec: tagHARDWAREINPUT;
  published
    property uMsg: DWORD read FuMsg write FuMsg;
    property wParamL: WORD read FwParamL write FwParamL;
    property wParamH: WORD read FwParamH write FwParamH;
  end;
  
  tagINPUTWrapper = class(TatRecordWrapper)
  private
    FItype: DWORD;
  public
    constructor Create(ARecord: tagINPUT);
    function ObjToRec: tagINPUT;
  published
    property Itype: DWORD read FItype write FItype;
  end;
  
  tagLASTINPUTINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwTime: DWORD;
  public
    constructor Create(ARecord: tagLASTINPUTINFO);
    function ObjToRec: tagLASTINPUTINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwTime: DWORD read FdwTime write FdwTime;
  end;
  
  tagTPMPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
  public
    constructor Create(ARecord: tagTPMPARAMS);
    function ObjToRec: tagTPMPARAMS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
  end;
  
  tagMENUINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FfMask: DWORD;
    FdwStyle: DWORD;
    FcyMax: UINT;
    FhbrBack: HBRUSH;
    FdwContextHelpID: DWORD;
    FdwMenuData: DWORD;
  public
    constructor Create(ARecord: tagMENUINFO);
    function ObjToRec: tagMENUINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property fMask: DWORD read FfMask write FfMask;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property cyMax: UINT read FcyMax write FcyMax;
    property hbrBack: HBRUSH read FhbrBack write FhbrBack;
    property dwContextHelpID: DWORD read FdwContextHelpID write FdwContextHelpID;
    property dwMenuData: DWORD read FdwMenuData write FdwMenuData;
  end;
  
  tagMENUGETOBJECTINFOWrapper = class(TatRecordWrapper)
  private
    FdwFlags: DWORD;
    FuPos: UINT;
    Fhmenu: HMENU;
  public
    constructor Create(ARecord: tagMENUGETOBJECTINFO);
    function ObjToRec: tagMENUGETOBJECTINFO;
  published
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property uPos: UINT read FuPos write FuPos;
    property hmenu: HMENU read Fhmenu write Fhmenu;
  end;
  
  tagMENUITEMINFOAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FfMask: UINT;
    FfType: UINT;
    FfState: UINT;
    FwID: UINT;
    FhSubMenu: HMENU;
    FhbmpChecked: HBITMAP;
    FhbmpUnchecked: HBITMAP;
    FdwItemData: DWORD;
    Fcch: UINT;
    FhbmpItem: HBITMAP;
  public
    constructor Create(ARecord: tagMENUITEMINFOA);
    function ObjToRec: tagMENUITEMINFOA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property fMask: UINT read FfMask write FfMask;
    property fType: UINT read FfType write FfType;
    property fState: UINT read FfState write FfState;
    property wID: UINT read FwID write FwID;
    property hSubMenu: HMENU read FhSubMenu write FhSubMenu;
    property hbmpChecked: HBITMAP read FhbmpChecked write FhbmpChecked;
    property hbmpUnchecked: HBITMAP read FhbmpUnchecked write FhbmpUnchecked;
    property dwItemData: DWORD read FdwItemData write FdwItemData;
    property cch: UINT read Fcch write Fcch;
    property hbmpItem: HBITMAP read FhbmpItem write FhbmpItem;
  end;
  
  tagMENUITEMINFOWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FfMask: UINT;
    FfType: UINT;
    FfState: UINT;
    FwID: UINT;
    FhSubMenu: HMENU;
    FhbmpChecked: HBITMAP;
    FhbmpUnchecked: HBITMAP;
    FdwItemData: DWORD;
    Fcch: UINT;
    FhbmpItem: HBITMAP;
  public
    constructor Create(ARecord: tagMENUITEMINFOW);
    function ObjToRec: tagMENUITEMINFOW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property fMask: UINT read FfMask write FfMask;
    property fType: UINT read FfType write FfType;
    property fState: UINT read FfState write FfState;
    property wID: UINT read FwID write FwID;
    property hSubMenu: HMENU read FhSubMenu write FhSubMenu;
    property hbmpChecked: HBITMAP read FhbmpChecked write FhbmpChecked;
    property hbmpUnchecked: HBITMAP read FhbmpUnchecked write FhbmpUnchecked;
    property dwItemData: DWORD read FdwItemData write FdwItemData;
    property cch: UINT read Fcch write Fcch;
    property hbmpItem: HBITMAP read FhbmpItem write FhbmpItem;
  end;
  
  tagDROPSTRUCTWrapper = class(TatRecordWrapper)
  private
    FhwndSource: HWND;
    FhwndSink: HWND;
    FwFmt: DWORD;
    FdwData: DWORD;
    FdwControlData: DWORD;
  public
    constructor Create(ARecord: tagDROPSTRUCT);
    function ObjToRec: tagDROPSTRUCT;
  published
    property hwndSource: HWND read FhwndSource write FhwndSource;
    property hwndSink: HWND read FhwndSink write FhwndSink;
    property wFmt: DWORD read FwFmt write FwFmt;
    property dwData: DWORD read FdwData write FdwData;
    property dwControlData: DWORD read FdwControlData write FdwControlData;
  end;
  
  tagDRAWTEXTPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiTabLength: Integer;
    FiLeftMargin: Integer;
    FiRightMargin: Integer;
    FuiLengthDrawn: UINT;
  public
    constructor Create(ARecord: tagDRAWTEXTPARAMS);
    function ObjToRec: tagDRAWTEXTPARAMS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iTabLength: Integer read FiTabLength write FiTabLength;
    property iLeftMargin: Integer read FiLeftMargin write FiLeftMargin;
    property iRightMargin: Integer read FiRightMargin write FiRightMargin;
    property uiLengthDrawn: UINT read FuiLengthDrawn write FuiLengthDrawn;
  end;
  
  tagHELPINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiContextType: Integer;
    FiCtrlId: Integer;
    FhItemHandle: THandle;
    FdwContextId: DWORD;
  public
    constructor Create(ARecord: tagHELPINFO);
    function ObjToRec: tagHELPINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iContextType: Integer read FiContextType write FiContextType;
    property iCtrlId: Integer read FiCtrlId write FiCtrlId;
    property hItemHandle: THandle read FhItemHandle write FhItemHandle;
    property dwContextId: DWORD read FdwContextId write FdwContextId;
  end;
  
  tagMSGBOXPARAMSAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FhwndOwner: HWND;
    FhInstance: HINST;
    FdwStyle: DWORD;
    FdwContextHelpId: DWORD;
    FdwLanguageId: DWORD;
  public
    constructor Create(ARecord: tagMSGBOXPARAMSA);
    function ObjToRec: tagMSGBOXPARAMSA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property hInstance: HINST read FhInstance write FhInstance;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property dwContextHelpId: DWORD read FdwContextHelpId write FdwContextHelpId;
    property dwLanguageId: DWORD read FdwLanguageId write FdwLanguageId;
  end;
  
  tagMSGBOXPARAMSWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FhwndOwner: HWND;
    FhInstance: HINST;
    FdwStyle: DWORD;
    FdwContextHelpId: DWORD;
    FdwLanguageId: DWORD;
  public
    constructor Create(ARecord: tagMSGBOXPARAMSW);
    function ObjToRec: tagMSGBOXPARAMSW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property hInstance: HINST read FhInstance write FhInstance;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property dwContextHelpId: DWORD read FdwContextHelpId write FdwContextHelpId;
    property dwLanguageId: DWORD read FdwLanguageId write FdwLanguageId;
  end;
  
  MENUITEMTEMPLATEHEADERWrapper = class(TatRecordWrapper)
  private
    FversionNumber: Word;
    Foffset: Word;
  public
    constructor Create(ARecord: MENUITEMTEMPLATEHEADER);
    function ObjToRec: MENUITEMTEMPLATEHEADER;
  published
    property versionNumber: Word read FversionNumber write FversionNumber;
    property offset: Word read Foffset write Foffset;
  end;
  
  MENUITEMTEMPLATEWrapper = class(TatRecordWrapper)
  private
    FmtOption: Word;
    FmtID: Word;
  public
    constructor Create(ARecord: MENUITEMTEMPLATE);
    function ObjToRec: MENUITEMTEMPLATE;
  published
    property mtOption: Word read FmtOption write FmtOption;
    property mtID: Word read FmtID write FmtID;
  end;
  
  _ICONINFOWrapper = class(TatRecordWrapper)
  private
    FfIcon: BOOL;
    FxHotspot: DWORD;
    FyHotspot: DWORD;
    FhbmMask: HBITMAP;
    FhbmColor: HBITMAP;
  public
    constructor Create(ARecord: _ICONINFO);
    function ObjToRec: _ICONINFO;
  published
    property fIcon: BOOL read FfIcon write FfIcon;
    property xHotspot: DWORD read FxHotspot write FxHotspot;
    property yHotspot: DWORD read FyHotspot write FyHotspot;
    property hbmMask: HBITMAP read FhbmMask write FhbmMask;
    property hbmColor: HBITMAP read FhbmColor write FhbmColor;
  end;
  
  tagCURSORSHAPEWrapper = class(TatRecordWrapper)
  private
    FxHotSpot: Integer;
    FyHotSpot: Integer;
    Fcx: Integer;
    Fcy: Integer;
    FcbWidth: Integer;
    FPlanes: Byte;
    FBitsPixel: Byte;
  public
    constructor Create(ARecord: tagCURSORSHAPE);
    function ObjToRec: tagCURSORSHAPE;
  published
    property xHotSpot: Integer read FxHotSpot write FxHotSpot;
    property yHotSpot: Integer read FyHotSpot write FyHotSpot;
    property cx: Integer read Fcx write Fcx;
    property cy: Integer read Fcy write Fcy;
    property cbWidth: Integer read FcbWidth write FcbWidth;
    property Planes: Byte read FPlanes write FPlanes;
    property BitsPixel: Byte read FBitsPixel write FBitsPixel;
  end;
  
  tagSCROLLINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FfMask: UINT;
    FnMin: Integer;
    FnMax: Integer;
    FnPage: UINT;
    FnPos: Integer;
    FnTrackPos: Integer;
  public
    constructor Create(ARecord: tagSCROLLINFO);
    function ObjToRec: tagSCROLLINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property fMask: UINT read FfMask write FfMask;
    property nMin: Integer read FnMin write FnMin;
    property nMax: Integer read FnMax write FnMax;
    property nPage: UINT read FnPage write FnPage;
    property nPos: Integer read FnPos write FnPos;
    property nTrackPos: Integer read FnTrackPos write FnTrackPos;
  end;
  
  tagMDICREATESTRUCTAWrapper = class(TatRecordWrapper)
  private
    FhOwner: THandle;
    Fx: Integer;
    Fy: Integer;
    Fcx: Integer;
    Fcy: Integer;
    Fstyle: DWORD;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagMDICREATESTRUCTA);
    function ObjToRec: tagMDICREATESTRUCTA;
  published
    property hOwner: THandle read FhOwner write FhOwner;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property cx: Integer read Fcx write Fcx;
    property cy: Integer read Fcy write Fcy;
    property style: DWORD read Fstyle write Fstyle;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagMDICREATESTRUCTWWrapper = class(TatRecordWrapper)
  private
    FhOwner: THandle;
    Fx: Integer;
    Fy: Integer;
    Fcx: Integer;
    Fcy: Integer;
    Fstyle: DWORD;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: tagMDICREATESTRUCTW);
    function ObjToRec: tagMDICREATESTRUCTW;
  published
    property hOwner: THandle read FhOwner write FhOwner;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property cx: Integer read Fcx write Fcx;
    property cy: Integer read Fcy write Fcy;
    property style: DWORD read Fstyle write Fstyle;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  tagCLIENTCREATESTRUCTWrapper = class(TatRecordWrapper)
  private
    FhWindowMenu: THandle;
    FidFirstChild: UINT;
  public
    constructor Create(ARecord: tagCLIENTCREATESTRUCT);
    function ObjToRec: tagCLIENTCREATESTRUCT;
  published
    property hWindowMenu: THandle read FhWindowMenu write FhWindowMenu;
    property idFirstChild: UINT read FidFirstChild write FidFirstChild;
  end;
  
  tagMULTIKEYHELPAWrapper = class(TatRecordWrapper)
  private
    FmkSize: DWORD;
    FmkKeylist: AnsiChar;
  public
    constructor Create(ARecord: tagMULTIKEYHELPA);
    function ObjToRec: tagMULTIKEYHELPA;
  published
    property mkSize: DWORD read FmkSize write FmkSize;
    property mkKeylist: AnsiChar read FmkKeylist write FmkKeylist;
  end;
  
  tagMULTIKEYHELPWWrapper = class(TatRecordWrapper)
  private
    FmkSize: DWORD;
  public
    constructor Create(ARecord: tagMULTIKEYHELPW);
    function ObjToRec: tagMULTIKEYHELPW;
  published
    property mkSize: DWORD read FmkSize write FmkSize;
  end;
  
  tagHELPWININFOAWrapper = class(TatRecordWrapper)
  private
    FwStructSize: Integer;
    Fx: Integer;
    Fy: Integer;
    Fdx: Integer;
    Fdy: Integer;
    FwMax: Integer;
  public
    constructor Create(ARecord: tagHELPWININFOA);
    function ObjToRec: tagHELPWININFOA;
  published
    property wStructSize: Integer read FwStructSize write FwStructSize;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property dx: Integer read Fdx write Fdx;
    property dy: Integer read Fdy write Fdy;
    property wMax: Integer read FwMax write FwMax;
  end;
  
  tagHELPWININFOWWrapper = class(TatRecordWrapper)
  private
    FwStructSize: Integer;
    Fx: Integer;
    Fy: Integer;
    Fdx: Integer;
    Fdy: Integer;
    FwMax: Integer;
  public
    constructor Create(ARecord: tagHELPWININFOW);
    function ObjToRec: tagHELPWININFOW;
  published
    property wStructSize: Integer read FwStructSize write FwStructSize;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property dx: Integer read Fdx write Fdx;
    property dy: Integer read Fdy write Fdy;
    property wMax: Integer read FwMax write FwMax;
  end;
  
  _HHN_NOTIFYWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _HHN_NOTIFY);
    function ObjToRec: _HHN_NOTIFY;
  published
  end;
  
  _HH_POPUPWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
    FhInst: HINST;
    FidString: UINT;
    FclrForeground: TColorRef;
    FclrBackground: TColorRef;
  public
    constructor Create(ARecord: _HH_POPUP);
    function ObjToRec: _HH_POPUP;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
    property hInst: HINST read FhInst write FhInst;
    property idString: UINT read FidString write FidString;
    property clrForeground: TColorRef read FclrForeground write FclrForeground;
    property clrBackground: TColorRef read FclrBackground write FclrBackground;
  end;
  
  _HH_AKLINKWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
    FfReserved: Boolean;
    FfIndexOnFail: Boolean;
  public
    constructor Create(ARecord: _HH_AKLINK);
    function ObjToRec: _HH_AKLINK;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
    property fReserved: Boolean read FfReserved write FfReserved;
    property fIndexOnFail: Boolean read FfIndexOnFail write FfIndexOnFail;
  end;
  
  _HH_ENUM_ITWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
    FiType: Integer;
  public
    constructor Create(ARecord: _HH_ENUM_IT);
    function ObjToRec: _HH_ENUM_IT;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
    property iType: Integer read FiType write FiType;
  end;
  
  _HH_ENUM_CATWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
  public
    constructor Create(ARecord: _HH_ENUM_CAT);
    function ObjToRec: _HH_ENUM_CAT;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
  end;
  
  _HH_SET_INFOTYPEWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
  public
    constructor Create(ARecord: _HH_SET_INFOTYPE);
    function ObjToRec: _HH_SET_INFOTYPE;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
  end;
  
  _HH_FTS_QUERYWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
    FfUniCodeStrings: Boolean;
    FiProximity: longint;
    FfStemmedSearch: Boolean;
    FfTitleOnly: Boolean;
    FfExecute: Boolean;
  public
    constructor Create(ARecord: _HH_FTS_QUERY);
    function ObjToRec: _HH_FTS_QUERY;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
    property fUniCodeStrings: Boolean read FfUniCodeStrings write FfUniCodeStrings;
    property iProximity: longint read FiProximity write FiProximity;
    property fStemmedSearch: Boolean read FfStemmedSearch write FfStemmedSearch;
    property fTitleOnly: Boolean read FfTitleOnly write FfTitleOnly;
    property fExecute: Boolean read FfExecute write FfExecute;
  end;
  
  _HH_WINTYPEWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Integer;
    FfUniCodeStrings: Boolean;
    FfsValidMembers: DWord;
    FfsWinProperties: DWord;
    FdwStyles: DWord;
    FdwExStyles: DWord;
    FnShowState: Integer;
    FhwndHelp: HWND;
    FhwndCaller: HWND;
    FhwndToolBar: HWND;
    FhwndNavigation: HWND;
    FhwndHTML: HWND;
    FiNavWidth: Integer;
    FfsToolBarFlags: DWord;
    FfNotExpanded: Boolean;
    FcurNavType: Integer;
    FtabPos: Integer;
    FidNotify: Integer;
    FcHistory: Integer;
    FcbInfoTYpes: Integer;
    FpszCustomTabs: Integer;
  public
    constructor Create(ARecord: _HH_WINTYPE);
    function ObjToRec: _HH_WINTYPE;
  published
    property cbStruct: Integer read FcbStruct write FcbStruct;
    property fUniCodeStrings: Boolean read FfUniCodeStrings write FfUniCodeStrings;
    property fsValidMembers: DWord read FfsValidMembers write FfsValidMembers;
    property fsWinProperties: DWord read FfsWinProperties write FfsWinProperties;
    property dwStyles: DWord read FdwStyles write FdwStyles;
    property dwExStyles: DWord read FdwExStyles write FdwExStyles;
    property nShowState: Integer read FnShowState write FnShowState;
    property hwndHelp: HWND read FhwndHelp write FhwndHelp;
    property hwndCaller: HWND read FhwndCaller write FhwndCaller;
    property hwndToolBar: HWND read FhwndToolBar write FhwndToolBar;
    property hwndNavigation: HWND read FhwndNavigation write FhwndNavigation;
    property hwndHTML: HWND read FhwndHTML write FhwndHTML;
    property iNavWidth: Integer read FiNavWidth write FiNavWidth;
    property fsToolBarFlags: DWord read FfsToolBarFlags write FfsToolBarFlags;
    property fNotExpanded: Boolean read FfNotExpanded write FfNotExpanded;
    property curNavType: Integer read FcurNavType write FcurNavType;
    property tabPos: Integer read FtabPos write FtabPos;
    property idNotify: Integer read FidNotify write FidNotify;
    property cHistory: Integer read FcHistory write FcHistory;
    property cbInfoTYpes: Integer read FcbInfoTYpes write FcbInfoTYpes;
    property pszCustomTabs: Integer read FpszCustomTabs write FpszCustomTabs;
  end;
  
  _HH_NTRACKWrapper = class(TatRecordWrapper)
  private
    FidAction: Integer;
  public
    constructor Create(ARecord: _HH_NTRACK);
    function ObjToRec: _HH_NTRACK;
  published
    property idAction: Integer read FidAction write FidAction;
  end;
  
  tagNONCLIENTMETRICSAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiBorderWidth: Integer;
    FiScrollWidth: Integer;
    FiScrollHeight: Integer;
    FiCaptionWidth: Integer;
    FiCaptionHeight: Integer;
    FiSmCaptionWidth: Integer;
    FiSmCaptionHeight: Integer;
    FiMenuWidth: Integer;
    FiMenuHeight: Integer;
  public
    constructor Create(ARecord: tagNONCLIENTMETRICSA);
    function ObjToRec: tagNONCLIENTMETRICSA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iBorderWidth: Integer read FiBorderWidth write FiBorderWidth;
    property iScrollWidth: Integer read FiScrollWidth write FiScrollWidth;
    property iScrollHeight: Integer read FiScrollHeight write FiScrollHeight;
    property iCaptionWidth: Integer read FiCaptionWidth write FiCaptionWidth;
    property iCaptionHeight: Integer read FiCaptionHeight write FiCaptionHeight;
    property iSmCaptionWidth: Integer read FiSmCaptionWidth write FiSmCaptionWidth;
    property iSmCaptionHeight: Integer read FiSmCaptionHeight write FiSmCaptionHeight;
    property iMenuWidth: Integer read FiMenuWidth write FiMenuWidth;
    property iMenuHeight: Integer read FiMenuHeight write FiMenuHeight;
  end;
  
  tagNONCLIENTMETRICSWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiBorderWidth: Integer;
    FiScrollWidth: Integer;
    FiScrollHeight: Integer;
    FiCaptionWidth: Integer;
    FiCaptionHeight: Integer;
    FiSmCaptionWidth: Integer;
    FiSmCaptionHeight: Integer;
    FiMenuWidth: Integer;
    FiMenuHeight: Integer;
  public
    constructor Create(ARecord: tagNONCLIENTMETRICSW);
    function ObjToRec: tagNONCLIENTMETRICSW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iBorderWidth: Integer read FiBorderWidth write FiBorderWidth;
    property iScrollWidth: Integer read FiScrollWidth write FiScrollWidth;
    property iScrollHeight: Integer read FiScrollHeight write FiScrollHeight;
    property iCaptionWidth: Integer read FiCaptionWidth write FiCaptionWidth;
    property iCaptionHeight: Integer read FiCaptionHeight write FiCaptionHeight;
    property iSmCaptionWidth: Integer read FiSmCaptionWidth write FiSmCaptionWidth;
    property iSmCaptionHeight: Integer read FiSmCaptionHeight write FiSmCaptionHeight;
    property iMenuWidth: Integer read FiMenuWidth write FiMenuWidth;
    property iMenuHeight: Integer read FiMenuHeight write FiMenuHeight;
  end;
  
  tagMINIMIZEDMETRICSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiWidth: Integer;
    FiHorzGap: Integer;
    FiVertGap: Integer;
    FiArrange: Integer;
  public
    constructor Create(ARecord: tagMINIMIZEDMETRICS);
    function ObjToRec: tagMINIMIZEDMETRICS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iWidth: Integer read FiWidth write FiWidth;
    property iHorzGap: Integer read FiHorzGap write FiHorzGap;
    property iVertGap: Integer read FiVertGap write FiVertGap;
    property iArrange: Integer read FiArrange write FiArrange;
  end;
  
  tagICONMETRICSAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiHorzSpacing: Integer;
    FiVertSpacing: Integer;
    FiTitleWrap: Integer;
  public
    constructor Create(ARecord: tagICONMETRICSA);
    function ObjToRec: tagICONMETRICSA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iHorzSpacing: Integer read FiHorzSpacing write FiHorzSpacing;
    property iVertSpacing: Integer read FiVertSpacing write FiVertSpacing;
    property iTitleWrap: Integer read FiTitleWrap write FiTitleWrap;
  end;
  
  tagICONMETRICSWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiHorzSpacing: Integer;
    FiVertSpacing: Integer;
    FiTitleWrap: Integer;
  public
    constructor Create(ARecord: tagICONMETRICSW);
    function ObjToRec: tagICONMETRICSW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iHorzSpacing: Integer read FiHorzSpacing write FiHorzSpacing;
    property iVertSpacing: Integer read FiVertSpacing write FiVertSpacing;
    property iTitleWrap: Integer read FiTitleWrap write FiTitleWrap;
  end;
  
  tagANIMATIONINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FiMinAnimate: Integer;
  public
    constructor Create(ARecord: tagANIMATIONINFO);
    function ObjToRec: tagANIMATIONINFO;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property iMinAnimate: Integer read FiMinAnimate write FiMinAnimate;
  end;
  
  tagSERIALKEYSAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiBaudRate: UINT;
    FiPortState: UINT;
    FiActive: UINT;
  public
    constructor Create(ARecord: tagSERIALKEYSA);
    function ObjToRec: tagSERIALKEYSA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iBaudRate: UINT read FiBaudRate write FiBaudRate;
    property iPortState: UINT read FiPortState write FiPortState;
    property iActive: UINT read FiActive write FiActive;
  end;
  
  tagSERIALKEYSWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiBaudRate: UINT;
    FiPortState: UINT;
    FiActive: UINT;
  public
    constructor Create(ARecord: tagSERIALKEYSW);
    function ObjToRec: tagSERIALKEYSW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iBaudRate: UINT read FiBaudRate write FiBaudRate;
    property iPortState: UINT read FiPortState write FiPortState;
    property iActive: UINT read FiActive write FiActive;
  end;
  
  tagHIGHCONTRASTAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagHIGHCONTRASTA);
    function ObjToRec: tagHIGHCONTRASTA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagHIGHCONTRASTWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagHIGHCONTRASTW);
    function ObjToRec: tagHIGHCONTRASTW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagFILTERKEYSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiWaitMSec: DWORD;
    FiDelayMSec: DWORD;
    FiRepeatMSec: DWORD;
    FiBounceMSec: DWORD;
  public
    constructor Create(ARecord: tagFILTERKEYS);
    function ObjToRec: tagFILTERKEYS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iWaitMSec: DWORD read FiWaitMSec write FiWaitMSec;
    property iDelayMSec: DWORD read FiDelayMSec write FiDelayMSec;
    property iRepeatMSec: DWORD read FiRepeatMSec write FiRepeatMSec;
    property iBounceMSec: DWORD read FiBounceMSec write FiBounceMSec;
  end;
  
  tagSTICKYKEYSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagSTICKYKEYS);
    function ObjToRec: tagSTICKYKEYS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagMOUSEKEYSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiMaxSpeed: DWORD;
    FiTimeToMaxSpeed: DWORD;
    FiCtrlSpeed: DWORD;
    FdwReserved1: DWORD;
    FdwReserved2: DWORD;
  public
    constructor Create(ARecord: tagMOUSEKEYS);
    function ObjToRec: tagMOUSEKEYS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iMaxSpeed: DWORD read FiMaxSpeed write FiMaxSpeed;
    property iTimeToMaxSpeed: DWORD read FiTimeToMaxSpeed write FiTimeToMaxSpeed;
    property iCtrlSpeed: DWORD read FiCtrlSpeed write FiCtrlSpeed;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
    property dwReserved2: DWORD read FdwReserved2 write FdwReserved2;
  end;
  
  tagACCESSTIMEOUTWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiTimeOutMSec: DWORD;
  public
    constructor Create(ARecord: tagACCESSTIMEOUT);
    function ObjToRec: tagACCESSTIMEOUT;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iTimeOutMSec: DWORD read FiTimeOutMSec write FiTimeOutMSec;
  end;
  
  tagSOUNDSENTRYAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiFSTextEffect: DWORD;
    FiFSTextEffectMSec: DWORD;
    FiFSTextEffectColorBits: DWORD;
    FiFSGrafEffect: DWORD;
    FiFSGrafEffectMSec: DWORD;
    FiFSGrafEffectColor: DWORD;
    FiWindowsEffect: DWORD;
    FiWindowsEffectMSec: DWORD;
    FiWindowsEffectOrdinal: DWORD;
  public
    constructor Create(ARecord: tagSOUNDSENTRYA);
    function ObjToRec: tagSOUNDSENTRYA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iFSTextEffect: DWORD read FiFSTextEffect write FiFSTextEffect;
    property iFSTextEffectMSec: DWORD read FiFSTextEffectMSec write FiFSTextEffectMSec;
    property iFSTextEffectColorBits: DWORD read FiFSTextEffectColorBits write FiFSTextEffectColorBits;
    property iFSGrafEffect: DWORD read FiFSGrafEffect write FiFSGrafEffect;
    property iFSGrafEffectMSec: DWORD read FiFSGrafEffectMSec write FiFSGrafEffectMSec;
    property iFSGrafEffectColor: DWORD read FiFSGrafEffectColor write FiFSGrafEffectColor;
    property iWindowsEffect: DWORD read FiWindowsEffect write FiWindowsEffect;
    property iWindowsEffectMSec: DWORD read FiWindowsEffectMSec write FiWindowsEffectMSec;
    property iWindowsEffectOrdinal: DWORD read FiWindowsEffectOrdinal write FiWindowsEffectOrdinal;
  end;
  
  tagSOUNDSENTRYWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
    FiFSTextEffect: DWORD;
    FiFSTextEffectMSec: DWORD;
    FiFSTextEffectColorBits: DWORD;
    FiFSGrafEffect: DWORD;
    FiFSGrafEffectMSec: DWORD;
    FiFSGrafEffectColor: DWORD;
    FiWindowsEffect: DWORD;
    FiWindowsEffectMSec: DWORD;
    FiWindowsEffectOrdinal: DWORD;
  public
    constructor Create(ARecord: tagSOUNDSENTRYW);
    function ObjToRec: tagSOUNDSENTRYW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property iFSTextEffect: DWORD read FiFSTextEffect write FiFSTextEffect;
    property iFSTextEffectMSec: DWORD read FiFSTextEffectMSec write FiFSTextEffectMSec;
    property iFSTextEffectColorBits: DWORD read FiFSTextEffectColorBits write FiFSTextEffectColorBits;
    property iFSGrafEffect: DWORD read FiFSGrafEffect write FiFSGrafEffect;
    property iFSGrafEffectMSec: DWORD read FiFSGrafEffectMSec write FiFSGrafEffectMSec;
    property iFSGrafEffectColor: DWORD read FiFSGrafEffectColor write FiFSGrafEffectColor;
    property iWindowsEffect: DWORD read FiWindowsEffect write FiWindowsEffect;
    property iWindowsEffectMSec: DWORD read FiWindowsEffectMSec write FiWindowsEffectMSec;
    property iWindowsEffectOrdinal: DWORD read FiWindowsEffectOrdinal write FiWindowsEffectOrdinal;
  end;
  
  tagTOGGLEKEYSWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: tagTOGGLEKEYS);
    function ObjToRec: tagTOGGLEKEYS;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  tagGUITHREADINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fflags: DWORD;
    FhwndActive: HWND;
    FhwndFocus: HWND;
    FhwndCapture: HWND;
    FhwndMenuOwner: HWND;
    FhwndMoveSize: HWND;
    FhwndCaret: HWND;
  public
    constructor Create(ARecord: tagGUITHREADINFO);
    function ObjToRec: tagGUITHREADINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property flags: DWORD read Fflags write Fflags;
    property hwndActive: HWND read FhwndActive write FhwndActive;
    property hwndFocus: HWND read FhwndFocus write FhwndFocus;
    property hwndCapture: HWND read FhwndCapture write FhwndCapture;
    property hwndMenuOwner: HWND read FhwndMenuOwner write FhwndMenuOwner;
    property hwndMoveSize: HWND read FhwndMoveSize write FhwndMoveSize;
    property hwndCaret: HWND read FhwndCaret write FhwndCaret;
  end;
  
  tagCURSORINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    Fflags: DWORD;
    FhCursor: HCURSOR;
  public
    constructor Create(ARecord: tagCURSORINFO);
    function ObjToRec: tagCURSORINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property flags: DWORD read Fflags write Fflags;
    property hCursor: HCURSOR read FhCursor write FhCursor;
  end;
  
  tagWINDOWINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdwStyle: DWORD;
    FdwExStyle: DWORD;
    FdwOtherStuff: DWORD;
    FcxWindowBorders: UINT;
    FcyWindowBorders: UINT;
    FatomWindowType: TAtom;
    FwCreatorVersion: WORD;
  public
    constructor Create(ARecord: tagWINDOWINFO);
    function ObjToRec: tagWINDOWINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dwStyle: DWORD read FdwStyle write FdwStyle;
    property dwExStyle: DWORD read FdwExStyle write FdwExStyle;
    property dwOtherStuff: DWORD read FdwOtherStuff write FdwOtherStuff;
    property cxWindowBorders: UINT read FcxWindowBorders write FcxWindowBorders;
    property cyWindowBorders: UINT read FcyWindowBorders write FcyWindowBorders;
    property atomWindowType: TAtom read FatomWindowType write FatomWindowType;
    property wCreatorVersion: WORD read FwCreatorVersion write FwCreatorVersion;
  end;
  
  tagTITLEBARINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
  public
    constructor Create(ARecord: tagTITLEBARINFO);
    function ObjToRec: tagTITLEBARINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
  end;
  
  tagMENUBARINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FhMenu: HMENU;
    FhwndMenu: HWND;
    FFocusedBits: BYTE;
  public
    constructor Create(ARecord: tagMENUBARINFO);
    function ObjToRec: tagMENUBARINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property hMenu: HMENU read FhMenu write FhMenu;
    property hwndMenu: HWND read FhwndMenu write FhwndMenu;
    property FocusedBits: BYTE read FFocusedBits write FFocusedBits;
  end;
  
  tagSCROLLBARINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FdxyLineButton: Integer;
    FxyThumbTop: Integer;
    FxyThumbBottom: Integer;
    Fbogus: Integer;
  public
    constructor Create(ARecord: tagSCROLLBARINFO);
    function ObjToRec: tagSCROLLBARINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property dxyLineButton: Integer read FdxyLineButton write FdxyLineButton;
    property xyThumbTop: Integer read FxyThumbTop write FxyThumbTop;
    property xyThumbBottom: Integer read FxyThumbBottom write FxyThumbBottom;
    property bogus: Integer read Fbogus write Fbogus;
  end;
  
  tagCOMBOBOXINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FstateButton: DWORD;
    FhwndCombo: HWND;
    FhwndItem: HWND;
    FhwndList: HWND;
  public
    constructor Create(ARecord: tagCOMBOBOXINFO);
    function ObjToRec: tagCOMBOBOXINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property stateButton: DWORD read FstateButton write FstateButton;
    property hwndCombo: HWND read FhwndCombo write FhwndCombo;
    property hwndItem: HWND read FhwndItem write FhwndItem;
    property hwndList: HWND read FhwndList write FhwndList;
  end;
  
  tagALTTABINFOWrapper = class(TatRecordWrapper)
  private
    FcbSize: DWORD;
    FcItems: Integer;
    FcColumns: Integer;
    FcRows: Integer;
    FiColFocus: Integer;
    FiRowFocus: Integer;
    FcxItem: Integer;
    FcyItem: Integer;
  public
    constructor Create(ARecord: tagALTTABINFO);
    function ObjToRec: tagALTTABINFO;
  published
    property cbSize: DWORD read FcbSize write FcbSize;
    property cItems: Integer read FcItems write FcItems;
    property cColumns: Integer read FcColumns write FcColumns;
    property cRows: Integer read FcRows write FcRows;
    property iColFocus: Integer read FiColFocus write FiColFocus;
    property iRowFocus: Integer read FiRowFocus write FiRowFocus;
    property cxItem: Integer read FcxItem write FcxItem;
    property cyItem: Integer read FcyItem write FcyItem;
  end;
  
  _cpinfoWrapper = class(TatRecordWrapper)
  private
    FMaxCharSize: UINT;
  public
    constructor Create(ARecord: _cpinfo);
    function ObjToRec: _cpinfo;
  published
    property MaxCharSize: UINT read FMaxCharSize write FMaxCharSize;
  end;
  
  _numberfmtAWrapper = class(TatRecordWrapper)
  private
    FNumDigits: UINT;
    FLeadingZero: UINT;
    FGrouping: UINT;
    FNegativeOrder: UINT;
  public
    constructor Create(ARecord: _numberfmtA);
    function ObjToRec: _numberfmtA;
  published
    property NumDigits: UINT read FNumDigits write FNumDigits;
    property LeadingZero: UINT read FLeadingZero write FLeadingZero;
    property Grouping: UINT read FGrouping write FGrouping;
    property NegativeOrder: UINT read FNegativeOrder write FNegativeOrder;
  end;
  
  _numberfmtWWrapper = class(TatRecordWrapper)
  private
    FNumDigits: UINT;
    FLeadingZero: UINT;
    FGrouping: UINT;
    FNegativeOrder: UINT;
  public
    constructor Create(ARecord: _numberfmtW);
    function ObjToRec: _numberfmtW;
  published
    property NumDigits: UINT read FNumDigits write FNumDigits;
    property LeadingZero: UINT read FLeadingZero write FLeadingZero;
    property Grouping: UINT read FGrouping write FGrouping;
    property NegativeOrder: UINT read FNegativeOrder write FNegativeOrder;
  end;
  
  _currencyfmtAWrapper = class(TatRecordWrapper)
  private
    FNumDigits: UINT;
    FLeadingZero: UINT;
    FGrouping: UINT;
    FNegativeOrder: UINT;
    FPositiveOrder: UINT;
  public
    constructor Create(ARecord: _currencyfmtA);
    function ObjToRec: _currencyfmtA;
  published
    property NumDigits: UINT read FNumDigits write FNumDigits;
    property LeadingZero: UINT read FLeadingZero write FLeadingZero;
    property Grouping: UINT read FGrouping write FGrouping;
    property NegativeOrder: UINT read FNegativeOrder write FNegativeOrder;
    property PositiveOrder: UINT read FPositiveOrder write FPositiveOrder;
  end;
  
  _currencyfmtWWrapper = class(TatRecordWrapper)
  private
    FNumDigits: UINT;
    FLeadingZero: UINT;
    FGrouping: UINT;
    FNegativeOrder: UINT;
    FPositiveOrder: UINT;
  public
    constructor Create(ARecord: _currencyfmtW);
    function ObjToRec: _currencyfmtW;
  published
    property NumDigits: UINT read FNumDigits write FNumDigits;
    property LeadingZero: UINT read FLeadingZero write FLeadingZero;
    property Grouping: UINT read FGrouping write FGrouping;
    property NegativeOrder: UINT read FNegativeOrder write FNegativeOrder;
    property PositiveOrder: UINT read FPositiveOrder write FPositiveOrder;
  end;
  
  _COORDWrapper = class(TatRecordWrapper)
  private
    FX: SHORT;
    FY: SHORT;
  public
    constructor Create(ARecord: _COORD);
    function ObjToRec: _COORD;
  published
    property X: SHORT read FX write FX;
    property Y: SHORT read FY write FY;
  end;
  
  _SMALL_RECTWrapper = class(TatRecordWrapper)
  private
    FLeft: SHORT;
    FTop: SHORT;
    FRight: SHORT;
    FBottom: SHORT;
  public
    constructor Create(ARecord: _SMALL_RECT);
    function ObjToRec: _SMALL_RECT;
  published
    property Left: SHORT read FLeft write FLeft;
    property Top: SHORT read FTop write FTop;
    property Right: SHORT read FRight write FRight;
    property Bottom: SHORT read FBottom write FBottom;
  end;
  
  _KEY_EVENT_RECORDWrapper = class(TatRecordWrapper)
  private
    FbKeyDown: BOOL;
    FwRepeatCount: Word;
    FwVirtualKeyCode: Word;
    FwVirtualScanCode: Word;
    FdwControlKeyState: DWORD;
    FAsciiChar: CHAR;
  public
    constructor Create(ARecord: _KEY_EVENT_RECORD);
    function ObjToRec: _KEY_EVENT_RECORD;
  published
    property bKeyDown: BOOL read FbKeyDown write FbKeyDown;
    property wRepeatCount: Word read FwRepeatCount write FwRepeatCount;
    property wVirtualKeyCode: Word read FwVirtualKeyCode write FwVirtualKeyCode;
    property wVirtualScanCode: Word read FwVirtualScanCode write FwVirtualScanCode;
    property dwControlKeyState: DWORD read FdwControlKeyState write FdwControlKeyState;
    property AsciiChar: CHAR read FAsciiChar write FAsciiChar;
  end;
  
  _MOUSE_EVENT_RECORDWrapper = class(TatRecordWrapper)
  private
    FdwButtonState: DWORD;
    FdwControlKeyState: DWORD;
    FdwEventFlags: DWORD;
  public
    constructor Create(ARecord: _MOUSE_EVENT_RECORD);
    function ObjToRec: _MOUSE_EVENT_RECORD;
  published
    property dwButtonState: DWORD read FdwButtonState write FdwButtonState;
    property dwControlKeyState: DWORD read FdwControlKeyState write FdwControlKeyState;
    property dwEventFlags: DWORD read FdwEventFlags write FdwEventFlags;
  end;
  
  _WINDOW_BUFFER_SIZE_RECORDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _WINDOW_BUFFER_SIZE_RECORD);
    function ObjToRec: _WINDOW_BUFFER_SIZE_RECORD;
  published
  end;
  
  _MENU_EVENT_RECORDWrapper = class(TatRecordWrapper)
  private
    FdwCommandId: UINT;
  public
    constructor Create(ARecord: _MENU_EVENT_RECORD);
    function ObjToRec: _MENU_EVENT_RECORD;
  published
    property dwCommandId: UINT read FdwCommandId write FdwCommandId;
  end;
  
  _FOCUS_EVENT_RECORDWrapper = class(TatRecordWrapper)
  private
    FbSetFocus: BOOL;
  public
    constructor Create(ARecord: _FOCUS_EVENT_RECORD);
    function ObjToRec: _FOCUS_EVENT_RECORD;
  published
    property bSetFocus: BOOL read FbSetFocus write FbSetFocus;
  end;
  
  _INPUT_RECORDWrapper = class(TatRecordWrapper)
  private
    FEventType: Word;
    FReserved: Word;
  public
    constructor Create(ARecord: _INPUT_RECORD);
    function ObjToRec: _INPUT_RECORD;
  published
    property EventType: Word read FEventType write FEventType;
    property Reserved: Word read FReserved write FReserved;
  end;
  
  _CHAR_INFOWrapper = class(TatRecordWrapper)
  private
    FAttributes: Word;
    FAsciiChar: CHAR;
  public
    constructor Create(ARecord: _CHAR_INFO);
    function ObjToRec: _CHAR_INFO;
  published
    property Attributes: Word read FAttributes write FAttributes;
    property AsciiChar: CHAR read FAsciiChar write FAsciiChar;
  end;
  
  _CONSOLE_SCREEN_BUFFER_INFOWrapper = class(TatRecordWrapper)
  private
    FwAttributes: Word;
  public
    constructor Create(ARecord: _CONSOLE_SCREEN_BUFFER_INFO);
    function ObjToRec: _CONSOLE_SCREEN_BUFFER_INFO;
  published
    property wAttributes: Word read FwAttributes write FwAttributes;
  end;
  
  _CONSOLE_CURSOR_INFOWrapper = class(TatRecordWrapper)
  private
    FdwSize: DWORD;
    FbVisible: BOOL;
  public
    constructor Create(ARecord: _CONSOLE_CURSOR_INFO);
    function ObjToRec: _CONSOLE_CURSOR_INFO;
  published
    property dwSize: DWORD read FdwSize write FdwSize;
    property bVisible: BOOL read FbVisible write FbVisible;
  end;
  
  tagVS_FIXEDFILEINFOWrapper = class(TatRecordWrapper)
  private
    FdwSignature: DWORD;
    FdwStrucVersion: DWORD;
    FdwFileVersionMS: DWORD;
    FdwFileVersionLS: DWORD;
    FdwProductVersionMS: DWORD;
    FdwProductVersionLS: DWORD;
    FdwFileFlagsMask: DWORD;
    FdwFileFlags: DWORD;
    FdwFileOS: DWORD;
    FdwFileType: DWORD;
    FdwFileSubtype: DWORD;
    FdwFileDateMS: DWORD;
    FdwFileDateLS: DWORD;
  public
    constructor Create(ARecord: tagVS_FIXEDFILEINFO);
    function ObjToRec: tagVS_FIXEDFILEINFO;
  published
    property dwSignature: DWORD read FdwSignature write FdwSignature;
    property dwStrucVersion: DWORD read FdwStrucVersion write FdwStrucVersion;
    property dwFileVersionMS: DWORD read FdwFileVersionMS write FdwFileVersionMS;
    property dwFileVersionLS: DWORD read FdwFileVersionLS write FdwFileVersionLS;
    property dwProductVersionMS: DWORD read FdwProductVersionMS write FdwProductVersionMS;
    property dwProductVersionLS: DWORD read FdwProductVersionLS write FdwProductVersionLS;
    property dwFileFlagsMask: DWORD read FdwFileFlagsMask write FdwFileFlagsMask;
    property dwFileFlags: DWORD read FdwFileFlags write FdwFileFlags;
    property dwFileOS: DWORD read FdwFileOS write FdwFileOS;
    property dwFileType: DWORD read FdwFileType write FdwFileType;
    property dwFileSubtype: DWORD read FdwFileSubtype write FdwFileSubtype;
    property dwFileDateMS: DWORD read FdwFileDateMS write FdwFileDateMS;
    property dwFileDateLS: DWORD read FdwFileDateLS write FdwFileDateLS;
  end;
  
  val_contextWrapper = class(TatRecordWrapper)
  private
    Fvaluelen: Integer;
  public
    constructor Create(ARecord: val_context);
    function ObjToRec: val_context;
  published
    property valuelen: Integer read Fvaluelen write Fvaluelen;
  end;
  
  pvalueAWrapper = class(TatRecordWrapper)
  private
    Fpv_valuelen: BOOL;
    Fpv_type: DWORD;
  public
    constructor Create(ARecord: pvalueA);
    function ObjToRec: pvalueA;
  published
    property pv_valuelen: BOOL read Fpv_valuelen write Fpv_valuelen;
    property pv_type: DWORD read Fpv_type write Fpv_type;
  end;
  
  pvalueWWrapper = class(TatRecordWrapper)
  private
    Fpv_valuelen: BOOL;
    Fpv_type: DWORD;
  public
    constructor Create(ARecord: pvalueW);
    function ObjToRec: pvalueW;
  published
    property pv_valuelen: BOOL read Fpv_valuelen write Fpv_valuelen;
    property pv_type: DWORD read Fpv_type write Fpv_type;
  end;
  
  provider_infoWrapper = class(TatRecordWrapper)
  private
    Fpi_flags: DWORD;
  public
    constructor Create(ARecord: provider_info);
    function ObjToRec: provider_info;
  published
    property pi_flags: DWORD read Fpi_flags write Fpi_flags;
  end;
  
  value_entAWrapper = class(TatRecordWrapper)
  private
    Fve_valuelen: DWORD;
    Fve_valueptr: DWORD;
    Fve_type: DWORD;
  public
    constructor Create(ARecord: value_entA);
    function ObjToRec: value_entA;
  published
    property ve_valuelen: DWORD read Fve_valuelen write Fve_valuelen;
    property ve_valueptr: DWORD read Fve_valueptr write Fve_valueptr;
    property ve_type: DWORD read Fve_type write Fve_type;
  end;
  
  value_entWWrapper = class(TatRecordWrapper)
  private
    Fve_valuelen: DWORD;
    Fve_valueptr: DWORD;
    Fve_type: DWORD;
  public
    constructor Create(ARecord: value_entW);
    function ObjToRec: value_entW;
  published
    property ve_valuelen: DWORD read Fve_valuelen write Fve_valuelen;
    property ve_valueptr: DWORD read Fve_valueptr write Fve_valueptr;
    property ve_type: DWORD read Fve_type write Fve_type;
  end;
  
  _NETRESOURCEAWrapper = class(TatRecordWrapper)
  private
    FdwScope: DWORD;
    FdwType: DWORD;
    FdwDisplayType: DWORD;
    FdwUsage: DWORD;
  public
    constructor Create(ARecord: _NETRESOURCEA);
    function ObjToRec: _NETRESOURCEA;
  published
    property dwScope: DWORD read FdwScope write FdwScope;
    property dwType: DWORD read FdwType write FdwType;
    property dwDisplayType: DWORD read FdwDisplayType write FdwDisplayType;
    property dwUsage: DWORD read FdwUsage write FdwUsage;
  end;
  
  _NETRESOURCEWWrapper = class(TatRecordWrapper)
  private
    FdwScope: DWORD;
    FdwType: DWORD;
    FdwDisplayType: DWORD;
    FdwUsage: DWORD;
  public
    constructor Create(ARecord: _NETRESOURCEW);
    function ObjToRec: _NETRESOURCEW;
  published
    property dwScope: DWORD read FdwScope write FdwScope;
    property dwType: DWORD read FdwType write FdwType;
    property dwDisplayType: DWORD read FdwDisplayType write FdwDisplayType;
    property dwUsage: DWORD read FdwUsage write FdwUsage;
  end;
  
  _CONNECTDLGSTRUCTAWrapper = class(TatRecordWrapper)
  private
    FcbStructure: DWORD;
    FhwndOwner: HWND;
    FdwFlags: DWORD;
    FdwDevNum: DWORD;
  public
    constructor Create(ARecord: _CONNECTDLGSTRUCTA);
    function ObjToRec: _CONNECTDLGSTRUCTA;
  published
    property cbStructure: DWORD read FcbStructure write FcbStructure;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwDevNum: DWORD read FdwDevNum write FdwDevNum;
  end;
  
  _DISCDLGSTRUCTAWrapper = class(TatRecordWrapper)
  private
    FcbStructure: DWORD;
    FhwndOwner: HWND;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: _DISCDLGSTRUCTA);
    function ObjToRec: _DISCDLGSTRUCTA;
  published
    property cbStructure: DWORD read FcbStructure write FcbStructure;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  _DISCDLGSTRUCTWWrapper = class(TatRecordWrapper)
  private
    FcbStructure: DWORD;
    FhwndOwner: HWND;
    FdwFlags: DWORD;
  public
    constructor Create(ARecord: _DISCDLGSTRUCTW);
    function ObjToRec: _DISCDLGSTRUCTW;
  published
    property cbStructure: DWORD read FcbStructure write FcbStructure;
    property hwndOwner: HWND read FhwndOwner write FhwndOwner;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
  end;
  
  _UNIVERSAL_NAME_INFOAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _UNIVERSAL_NAME_INFOA);
    function ObjToRec: _UNIVERSAL_NAME_INFOA;
  published
  end;
  
  _UNIVERSAL_NAME_INFOWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _UNIVERSAL_NAME_INFOW);
    function ObjToRec: _UNIVERSAL_NAME_INFOW;
  published
  end;
  
  _REMOTE_NAME_INFOAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _REMOTE_NAME_INFOA);
    function ObjToRec: _REMOTE_NAME_INFOA;
  published
  end;
  
  _REMOTE_NAME_INFOWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _REMOTE_NAME_INFOW);
    function ObjToRec: _REMOTE_NAME_INFOW;
  published
  end;
  
  _NETINFOSTRUCTWrapper = class(TatRecordWrapper)
  private
    FcbStructure: DWORD;
    FdwProviderVersion: DWORD;
    FdwStatus: DWORD;
    FdwCharacteristics: DWORD;
    FdwHandle: DWORD;
    FwNetType: Word;
    FdwPrinters: DWORD;
    FdwDrives: DWORD;
  public
    constructor Create(ARecord: _NETINFOSTRUCT);
    function ObjToRec: _NETINFOSTRUCT;
  published
    property cbStructure: DWORD read FcbStructure write FcbStructure;
    property dwProviderVersion: DWORD read FdwProviderVersion write FdwProviderVersion;
    property dwStatus: DWORD read FdwStatus write FdwStatus;
    property dwCharacteristics: DWORD read FdwCharacteristics write FdwCharacteristics;
    property dwHandle: DWORD read FdwHandle write FdwHandle;
    property wNetType: Word read FwNetType write FwNetType;
    property dwPrinters: DWORD read FdwPrinters write FdwPrinters;
    property dwDrives: DWORD read FdwDrives write FdwDrives;
  end;
  
  _NETCONNECTINFOSTRUCTWrapper = class(TatRecordWrapper)
  private
    FcbStructure: DWORD;
    FdwFlags: DWORD;
    FdwSpeed: DWORD;
    FdwDelay: DWORD;
    FdwOptDataSize: DWORD;
  public
    constructor Create(ARecord: _NETCONNECTINFOSTRUCT);
    function ObjToRec: _NETCONNECTINFOSTRUCT;
  published
    property cbStructure: DWORD read FcbStructure write FcbStructure;
    property dwFlags: DWORD read FdwFlags write FdwFlags;
    property dwSpeed: DWORD read FdwSpeed write FdwSpeed;
    property dwDelay: DWORD read FdwDelay write FdwDelay;
    property dwOptDataSize: DWORD read FdwOptDataSize write FdwOptDataSize;
  end;
  
  DDEACKWrapper = class(TatRecordWrapper)
  private
    FFlags: Word;
  public
    constructor Create(ARecord: DDEACK);
    function ObjToRec: DDEACK;
  published
    property Flags: Word read FFlags write FFlags;
  end;
  
  DDEADVISEWrapper = class(TatRecordWrapper)
  private
    FFlags: Word;
    FcfFormat: SmallInt;
  public
    constructor Create(ARecord: DDEADVISE);
    function ObjToRec: DDEADVISE;
  published
    property Flags: Word read FFlags write FFlags;
    property cfFormat: SmallInt read FcfFormat write FcfFormat;
  end;
  
  DDEDATAWrapper = class(TatRecordWrapper)
  private
    FFlags: Word;
    FcfFormat: SmallInt;
  public
    constructor Create(ARecord: DDEDATA);
    function ObjToRec: DDEDATA;
  published
    property Flags: Word read FFlags write FFlags;
    property cfFormat: SmallInt read FcfFormat write FcfFormat;
  end;
  
  DDEPOKEWrapper = class(TatRecordWrapper)
  private
    FFlags: Word;
    FcfFormat: SmallInt;
  public
    constructor Create(ARecord: DDEPOKE);
    function ObjToRec: DDEPOKE;
  published
    property Flags: Word read FFlags write FFlags;
    property cfFormat: SmallInt read FcfFormat write FcfFormat;
  end;
  

implementation

constructor _LARGE_INTEGERWrapper.Create(ARecord: _LARGE_INTEGER);
begin
  inherited Create;
  FLowPart := ARecord.LowPart;
  FHighPart := ARecord.HighPart;
  FQuadPart := ARecord.QuadPart;
end;

function _LARGE_INTEGERWrapper.ObjToRec: _LARGE_INTEGER;
begin
  result.LowPart := FLowPart;
  result.HighPart := FHighPart;
  result.QuadPart := FQuadPart;
end;

constructor ULARGE_INTEGERWrapper.Create(ARecord: ULARGE_INTEGER);
begin
  inherited Create;
  FLowPart := ARecord.LowPart;
  FHighPart := ARecord.HighPart;
  FQuadPart := ARecord.QuadPart;
end;

function ULARGE_INTEGERWrapper.ObjToRec: ULARGE_INTEGER;
begin
  result.LowPart := FLowPart;
  result.HighPart := FHighPart;
  result.QuadPart := FQuadPart;
end;

constructor _LIST_ENTRYWrapper.Create(ARecord: _LIST_ENTRY);
begin
  inherited Create;
end;

function _LIST_ENTRYWrapper.ObjToRec: _LIST_ENTRY;
begin
end;

constructor _FLOATING_SAVE_AREAWrapper.Create(ARecord: _FLOATING_SAVE_AREA);
begin
  inherited Create;
  FControlWord := ARecord.ControlWord;
  FStatusWord := ARecord.StatusWord;
  FTagWord := ARecord.TagWord;
  FErrorOffset := ARecord.ErrorOffset;
  FErrorSelector := ARecord.ErrorSelector;
  FDataOffset := ARecord.DataOffset;
  FDataSelector := ARecord.DataSelector;
  FCr0NpxState := ARecord.Cr0NpxState;
end;

function _FLOATING_SAVE_AREAWrapper.ObjToRec: _FLOATING_SAVE_AREA;
begin
  result.ControlWord := FControlWord;
  result.StatusWord := FStatusWord;
  result.TagWord := FTagWord;
  result.ErrorOffset := FErrorOffset;
  result.ErrorSelector := FErrorSelector;
  result.DataOffset := FDataOffset;
  result.DataSelector := FDataSelector;
  result.Cr0NpxState := FCr0NpxState;
end;

constructor _CONTEXTWrapper.Create(ARecord: _CONTEXT);
begin
  inherited Create;
  FContextFlags := ARecord.ContextFlags;
  FDr0 := ARecord.Dr0;
  FDr1 := ARecord.Dr1;
  FDr2 := ARecord.Dr2;
  FDr3 := ARecord.Dr3;
  FDr6 := ARecord.Dr6;
  FDr7 := ARecord.Dr7;
  FSegGs := ARecord.SegGs;
  FSegFs := ARecord.SegFs;
  FSegEs := ARecord.SegEs;
  FSegDs := ARecord.SegDs;
  FEdi := ARecord.Edi;
  FEsi := ARecord.Esi;
  FEbx := ARecord.Ebx;
  FEdx := ARecord.Edx;
  FEcx := ARecord.Ecx;
  FEax := ARecord.Eax;
  FEbp := ARecord.Ebp;
  FEip := ARecord.Eip;
  FSegCs := ARecord.SegCs;
  FEFlags := ARecord.EFlags;
  FEsp := ARecord.Esp;
  FSegSs := ARecord.SegSs;
end;

function _CONTEXTWrapper.ObjToRec: _CONTEXT;
begin
  result.ContextFlags := FContextFlags;
  result.Dr0 := FDr0;
  result.Dr1 := FDr1;
  result.Dr2 := FDr2;
  result.Dr3 := FDr3;
  result.Dr6 := FDr6;
  result.Dr7 := FDr7;
  result.SegGs := FSegGs;
  result.SegFs := FSegFs;
  result.SegEs := FSegEs;
  result.SegDs := FSegDs;
  result.Edi := FEdi;
  result.Esi := FEsi;
  result.Ebx := FEbx;
  result.Edx := FEdx;
  result.Ecx := FEcx;
  result.Eax := FEax;
  result.Ebp := FEbp;
  result.Eip := FEip;
  result.SegCs := FSegCs;
  result.EFlags := FEFlags;
  result.Esp := FEsp;
  result.SegSs := FSegSs;
end;

constructor _LDT_ENTRYWrapper.Create(ARecord: _LDT_ENTRY);
begin
  inherited Create;
  FLimitLow := ARecord.LimitLow;
  FBaseLow := ARecord.BaseLow;
  FBaseMid := ARecord.BaseMid;
  FFlags1 := ARecord.Flags1;
  FFlags2 := ARecord.Flags2;
  FBaseHi := ARecord.BaseHi;
  FFlags := ARecord.Flags;
end;

function _LDT_ENTRYWrapper.ObjToRec: _LDT_ENTRY;
begin
  result.LimitLow := FLimitLow;
  result.BaseLow := FBaseLow;
  result.BaseMid := FBaseMid;
  result.Flags1 := FFlags1;
  result.Flags2 := FFlags2;
  result.BaseHi := FBaseHi;
  result.Flags := FFlags;
end;

constructor _EXCEPTION_RECORDWrapper.Create(ARecord: _EXCEPTION_RECORD);
begin
  inherited Create;
  FExceptionCode := ARecord.ExceptionCode;
  FExceptionFlags := ARecord.ExceptionFlags;
  FNumberParameters := ARecord.NumberParameters;
end;

function _EXCEPTION_RECORDWrapper.ObjToRec: _EXCEPTION_RECORD;
begin
  result.ExceptionCode := FExceptionCode;
  result.ExceptionFlags := FExceptionFlags;
  result.NumberParameters := FNumberParameters;
end;

constructor _EXCEPTION_POINTERSWrapper.Create(ARecord: _EXCEPTION_POINTERS);
begin
  inherited Create;
end;

function _EXCEPTION_POINTERSWrapper.ObjToRec: _EXCEPTION_POINTERS;
begin
end;

constructor _MEMORY_BASIC_INFORMATIONWrapper.Create(ARecord: _MEMORY_BASIC_INFORMATION);
begin
  inherited Create;
  FAllocationProtect := ARecord.AllocationProtect;
  FRegionSize := ARecord.RegionSize;
  FState := ARecord.State;
  FProtect := ARecord.Protect;
  FType_9 := ARecord.Type_9;
end;

function _MEMORY_BASIC_INFORMATIONWrapper.ObjToRec: _MEMORY_BASIC_INFORMATION;
begin
  result.AllocationProtect := FAllocationProtect;
  result.RegionSize := FRegionSize;
  result.State := FState;
  result.Protect := FProtect;
  result.Type_9 := FType_9;
end;

constructor _GENERIC_MAPPINGWrapper.Create(ARecord: _GENERIC_MAPPING);
begin
  inherited Create;
  FGenericRead := ARecord.GenericRead;
  FGenericWrite := ARecord.GenericWrite;
  FGenericExecute := ARecord.GenericExecute;
  FGenericAll := ARecord.GenericAll;
end;

function _GENERIC_MAPPINGWrapper.ObjToRec: _GENERIC_MAPPING;
begin
  result.GenericRead := FGenericRead;
  result.GenericWrite := FGenericWrite;
  result.GenericExecute := FGenericExecute;
  result.GenericAll := FGenericAll;
end;

constructor _LUID_AND_ATTRIBUTESWrapper.Create(ARecord: _LUID_AND_ATTRIBUTES);
begin
  inherited Create;
  FLuid := ARecord.Luid;
  FAttributes := ARecord.Attributes;
end;

function _LUID_AND_ATTRIBUTESWrapper.ObjToRec: _LUID_AND_ATTRIBUTES;
begin
  result.Luid := FLuid;
  result.Attributes := FAttributes;
end;

constructor _SID_IDENTIFIER_AUTHORITYWrapper.Create(ARecord: _SID_IDENTIFIER_AUTHORITY);
begin
  inherited Create;
end;

function _SID_IDENTIFIER_AUTHORITYWrapper.ObjToRec: _SID_IDENTIFIER_AUTHORITY;
begin
end;

constructor _SID_AND_ATTRIBUTESWrapper.Create(ARecord: _SID_AND_ATTRIBUTES);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
end;

function _SID_AND_ATTRIBUTESWrapper.ObjToRec: _SID_AND_ATTRIBUTES;
begin
  result.Attributes := FAttributes;
end;

constructor _ACLWrapper.Create(ARecord: _ACL);
begin
  inherited Create;
  FAclRevision := ARecord.AclRevision;
  FSbz1 := ARecord.Sbz1;
  FAclSize := ARecord.AclSize;
  FAceCount := ARecord.AceCount;
  FSbz2 := ARecord.Sbz2;
end;

function _ACLWrapper.ObjToRec: _ACL;
begin
  result.AclRevision := FAclRevision;
  result.Sbz1 := FSbz1;
  result.AclSize := FAclSize;
  result.AceCount := FAceCount;
  result.Sbz2 := FSbz2;
end;

constructor _SECURITY_DESCRIPTORWrapper.Create(ARecord: _SECURITY_DESCRIPTOR);
begin
  inherited Create;
  FRevision := ARecord.Revision;
  FSbz1 := ARecord.Sbz1;
  FControl := ARecord.Control;
end;

function _SECURITY_DESCRIPTORWrapper.ObjToRec: _SECURITY_DESCRIPTOR;
begin
  result.Revision := FRevision;
  result.Sbz1 := FSbz1;
  result.Control := FControl;
end;

constructor _OBJECT_TYPE_LISTWrapper.Create(ARecord: _OBJECT_TYPE_LIST);
begin
  inherited Create;
  FLevel := ARecord.Level;
  FSbz := ARecord.Sbz;
end;

function _OBJECT_TYPE_LISTWrapper.ObjToRec: _OBJECT_TYPE_LIST;
begin
  result.Level := FLevel;
  result.Sbz := FSbz;
end;

constructor _PRIVILEGE_SETWrapper.Create(ARecord: _PRIVILEGE_SET);
begin
  inherited Create;
  FPrivilegeCount := ARecord.PrivilegeCount;
  FControl := ARecord.Control;
end;

function _PRIVILEGE_SETWrapper.ObjToRec: _PRIVILEGE_SET;
begin
  result.PrivilegeCount := FPrivilegeCount;
  result.Control := FControl;
end;

constructor _TOKEN_GROUPSWrapper.Create(ARecord: _TOKEN_GROUPS);
begin
  inherited Create;
  FGroupCount := ARecord.GroupCount;
end;

function _TOKEN_GROUPSWrapper.ObjToRec: _TOKEN_GROUPS;
begin
  result.GroupCount := FGroupCount;
end;

constructor _TOKEN_PRIVILEGESWrapper.Create(ARecord: _TOKEN_PRIVILEGES);
begin
  inherited Create;
  FPrivilegeCount := ARecord.PrivilegeCount;
end;

function _TOKEN_PRIVILEGESWrapper.ObjToRec: _TOKEN_PRIVILEGES;
begin
  result.PrivilegeCount := FPrivilegeCount;
end;

constructor _SECURITY_QUALITY_OF_SERVICEWrapper.Create(ARecord: _SECURITY_QUALITY_OF_SERVICE);
begin
  inherited Create;
  FLength := ARecord.Length;
  FImpersonationLevel := ARecord.ImpersonationLevel;
  FContextTrackingMode := ARecord.ContextTrackingMode;
  FEffectiveOnly := ARecord.EffectiveOnly;
end;

function _SECURITY_QUALITY_OF_SERVICEWrapper.ObjToRec: _SECURITY_QUALITY_OF_SERVICE;
begin
  result.Length := FLength;
  result.ImpersonationLevel := FImpersonationLevel;
  result.ContextTrackingMode := FContextTrackingMode;
  result.EffectiveOnly := FEffectiveOnly;
end;

constructor _IMAGE_DOS_HEADERWrapper.Create(ARecord: _IMAGE_DOS_HEADER);
begin
  inherited Create;
  Fe_magic := ARecord.e_magic;
  Fe_cblp := ARecord.e_cblp;
  Fe_cp := ARecord.e_cp;
  Fe_crlc := ARecord.e_crlc;
  Fe_cparhdr := ARecord.e_cparhdr;
  Fe_minalloc := ARecord.e_minalloc;
  Fe_maxalloc := ARecord.e_maxalloc;
  Fe_ss := ARecord.e_ss;
  Fe_sp := ARecord.e_sp;
  Fe_csum := ARecord.e_csum;
  Fe_ip := ARecord.e_ip;
  Fe_cs := ARecord.e_cs;
  Fe_lfarlc := ARecord.e_lfarlc;
  Fe_ovno := ARecord.e_ovno;
  Fe_oemid := ARecord.e_oemid;
  Fe_oeminfo := ARecord.e_oeminfo;
  F_lfanew := ARecord._lfanew;
end;

function _IMAGE_DOS_HEADERWrapper.ObjToRec: _IMAGE_DOS_HEADER;
begin
  result.e_magic := Fe_magic;
  result.e_cblp := Fe_cblp;
  result.e_cp := Fe_cp;
  result.e_crlc := Fe_crlc;
  result.e_cparhdr := Fe_cparhdr;
  result.e_minalloc := Fe_minalloc;
  result.e_maxalloc := Fe_maxalloc;
  result.e_ss := Fe_ss;
  result.e_sp := Fe_sp;
  result.e_csum := Fe_csum;
  result.e_ip := Fe_ip;
  result.e_cs := Fe_cs;
  result.e_lfarlc := Fe_lfarlc;
  result.e_ovno := Fe_ovno;
  result.e_oemid := Fe_oemid;
  result.e_oeminfo := Fe_oeminfo;
  result._lfanew := F_lfanew;
end;

constructor _IMAGE_FILE_HEADERWrapper.Create(ARecord: _IMAGE_FILE_HEADER);
begin
  inherited Create;
  FMachine := ARecord.Machine;
  FNumberOfSections := ARecord.NumberOfSections;
  FTimeDateStamp := ARecord.TimeDateStamp;
  FPointerToSymbolTable := ARecord.PointerToSymbolTable;
  FNumberOfSymbols := ARecord.NumberOfSymbols;
  FSizeOfOptionalHeader := ARecord.SizeOfOptionalHeader;
  FCharacteristics := ARecord.Characteristics;
end;

function _IMAGE_FILE_HEADERWrapper.ObjToRec: _IMAGE_FILE_HEADER;
begin
  result.Machine := FMachine;
  result.NumberOfSections := FNumberOfSections;
  result.TimeDateStamp := FTimeDateStamp;
  result.PointerToSymbolTable := FPointerToSymbolTable;
  result.NumberOfSymbols := FNumberOfSymbols;
  result.SizeOfOptionalHeader := FSizeOfOptionalHeader;
  result.Characteristics := FCharacteristics;
end;

constructor _IMAGE_EXPORT_DIRECTORYWrapper.Create(ARecord: _IMAGE_EXPORT_DIRECTORY);
begin
  inherited Create;
  FCharacteristics := ARecord.Characteristics;
  FTimeDateStamp := ARecord.TimeDateStamp;
  FMajorVersion := ARecord.MajorVersion;
  FMinorVersion := ARecord.MinorVersion;
  FName := ARecord.Name;
  FBase := ARecord.Base;
  FNumberOfFunctions := ARecord.NumberOfFunctions;
  FNumberOfNames := ARecord.NumberOfNames;
end;

function _IMAGE_EXPORT_DIRECTORYWrapper.ObjToRec: _IMAGE_EXPORT_DIRECTORY;
begin
  result.Characteristics := FCharacteristics;
  result.TimeDateStamp := FTimeDateStamp;
  result.MajorVersion := FMajorVersion;
  result.MinorVersion := FMinorVersion;
  result.Name := FName;
  result.Base := FBase;
  result.NumberOfFunctions := FNumberOfFunctions;
  result.NumberOfNames := FNumberOfNames;
end;

constructor _IMAGE_DATA_DIRECTORYWrapper.Create(ARecord: _IMAGE_DATA_DIRECTORY);
begin
  inherited Create;
  FVirtualAddress := ARecord.VirtualAddress;
  FSize := ARecord.Size;
end;

function _IMAGE_DATA_DIRECTORYWrapper.ObjToRec: _IMAGE_DATA_DIRECTORY;
begin
  result.VirtualAddress := FVirtualAddress;
  result.Size := FSize;
end;

constructor _IMAGE_OPTIONAL_HEADERWrapper.Create(ARecord: _IMAGE_OPTIONAL_HEADER);
begin
  inherited Create;
  FMagic := ARecord.Magic;
  FMajorLinkerVersion := ARecord.MajorLinkerVersion;
  FMinorLinkerVersion := ARecord.MinorLinkerVersion;
  FSizeOfCode := ARecord.SizeOfCode;
  FSizeOfInitializedData := ARecord.SizeOfInitializedData;
  FSizeOfUninitializedData := ARecord.SizeOfUninitializedData;
  FAddressOfEntryPoint := ARecord.AddressOfEntryPoint;
  FBaseOfCode := ARecord.BaseOfCode;
  FBaseOfData := ARecord.BaseOfData;
  FImageBase := ARecord.ImageBase;
  FSectionAlignment := ARecord.SectionAlignment;
  FFileAlignment := ARecord.FileAlignment;
  FMajorOperatingSystemVersion := ARecord.MajorOperatingSystemVersion;
  FMinorOperatingSystemVersion := ARecord.MinorOperatingSystemVersion;
  FMajorImageVersion := ARecord.MajorImageVersion;
  FMinorImageVersion := ARecord.MinorImageVersion;
  FMajorSubsystemVersion := ARecord.MajorSubsystemVersion;
  FMinorSubsystemVersion := ARecord.MinorSubsystemVersion;
  FWin32VersionValue := ARecord.Win32VersionValue;
  FSizeOfImage := ARecord.SizeOfImage;
  FSizeOfHeaders := ARecord.SizeOfHeaders;
  FCheckSum := ARecord.CheckSum;
  FSubsystem := ARecord.Subsystem;
  FDllCharacteristics := ARecord.DllCharacteristics;
  FSizeOfStackReserve := ARecord.SizeOfStackReserve;
  FSizeOfStackCommit := ARecord.SizeOfStackCommit;
  FSizeOfHeapReserve := ARecord.SizeOfHeapReserve;
  FSizeOfHeapCommit := ARecord.SizeOfHeapCommit;
  FLoaderFlags := ARecord.LoaderFlags;
  FNumberOfRvaAndSizes := ARecord.NumberOfRvaAndSizes;
end;

function _IMAGE_OPTIONAL_HEADERWrapper.ObjToRec: _IMAGE_OPTIONAL_HEADER;
begin
  result.Magic := FMagic;
  result.MajorLinkerVersion := FMajorLinkerVersion;
  result.MinorLinkerVersion := FMinorLinkerVersion;
  result.SizeOfCode := FSizeOfCode;
  result.SizeOfInitializedData := FSizeOfInitializedData;
  result.SizeOfUninitializedData := FSizeOfUninitializedData;
  result.AddressOfEntryPoint := FAddressOfEntryPoint;
  result.BaseOfCode := FBaseOfCode;
  result.BaseOfData := FBaseOfData;
  result.ImageBase := FImageBase;
  result.SectionAlignment := FSectionAlignment;
  result.FileAlignment := FFileAlignment;
  result.MajorOperatingSystemVersion := FMajorOperatingSystemVersion;
  result.MinorOperatingSystemVersion := FMinorOperatingSystemVersion;
  result.MajorImageVersion := FMajorImageVersion;
  result.MinorImageVersion := FMinorImageVersion;
  result.MajorSubsystemVersion := FMajorSubsystemVersion;
  result.MinorSubsystemVersion := FMinorSubsystemVersion;
  result.Win32VersionValue := FWin32VersionValue;
  result.SizeOfImage := FSizeOfImage;
  result.SizeOfHeaders := FSizeOfHeaders;
  result.CheckSum := FCheckSum;
  result.Subsystem := FSubsystem;
  result.DllCharacteristics := FDllCharacteristics;
  result.SizeOfStackReserve := FSizeOfStackReserve;
  result.SizeOfStackCommit := FSizeOfStackCommit;
  result.SizeOfHeapReserve := FSizeOfHeapReserve;
  result.SizeOfHeapCommit := FSizeOfHeapCommit;
  result.LoaderFlags := FLoaderFlags;
  result.NumberOfRvaAndSizes := FNumberOfRvaAndSizes;
end;

constructor _IMAGE_ROM_OPTIONAL_HEADERWrapper.Create(ARecord: _IMAGE_ROM_OPTIONAL_HEADER);
begin
  inherited Create;
  FMagic := ARecord.Magic;
  FMajorLinkerVersion := ARecord.MajorLinkerVersion;
  FMinorLinkerVersion := ARecord.MinorLinkerVersion;
  FSizeOfCode := ARecord.SizeOfCode;
  FSizeOfInitializedData := ARecord.SizeOfInitializedData;
  FSizeOfUninitializedData := ARecord.SizeOfUninitializedData;
  FAddressOfEntryPoint := ARecord.AddressOfEntryPoint;
  FBaseOfCode := ARecord.BaseOfCode;
  FBaseOfData := ARecord.BaseOfData;
  FBaseOfBss := ARecord.BaseOfBss;
  FGprMask := ARecord.GprMask;
  FGpValue := ARecord.GpValue;
end;

function _IMAGE_ROM_OPTIONAL_HEADERWrapper.ObjToRec: _IMAGE_ROM_OPTIONAL_HEADER;
begin
  result.Magic := FMagic;
  result.MajorLinkerVersion := FMajorLinkerVersion;
  result.MinorLinkerVersion := FMinorLinkerVersion;
  result.SizeOfCode := FSizeOfCode;
  result.SizeOfInitializedData := FSizeOfInitializedData;
  result.SizeOfUninitializedData := FSizeOfUninitializedData;
  result.AddressOfEntryPoint := FAddressOfEntryPoint;
  result.BaseOfCode := FBaseOfCode;
  result.BaseOfData := FBaseOfData;
  result.BaseOfBss := FBaseOfBss;
  result.GprMask := FGprMask;
  result.GpValue := FGpValue;
end;

constructor _IMAGE_NT_HEADERSWrapper.Create(ARecord: _IMAGE_NT_HEADERS);
begin
  inherited Create;
  FSignature := ARecord.Signature;
end;

function _IMAGE_NT_HEADERSWrapper.ObjToRec: _IMAGE_NT_HEADERS;
begin
  result.Signature := FSignature;
end;

constructor _IMAGE_ROM_HEADERSWrapper.Create(ARecord: _IMAGE_ROM_HEADERS);
begin
  inherited Create;
end;

function _IMAGE_ROM_HEADERSWrapper.ObjToRec: _IMAGE_ROM_HEADERS;
begin
end;

constructor TISHMiscWrapper.Create(ARecord: TISHMisc);
begin
  inherited Create;
  FPhysicalAddress := ARecord.PhysicalAddress;
  FVirtualSize := ARecord.VirtualSize;
end;

function TISHMiscWrapper.ObjToRec: TISHMisc;
begin
  result.PhysicalAddress := FPhysicalAddress;
  result.VirtualSize := FVirtualSize;
end;

constructor _IMAGE_SECTION_HEADERWrapper.Create(ARecord: _IMAGE_SECTION_HEADER);
begin
  inherited Create;
  FVirtualAddress := ARecord.VirtualAddress;
  FSizeOfRawData := ARecord.SizeOfRawData;
  FPointerToRawData := ARecord.PointerToRawData;
  FPointerToRelocations := ARecord.PointerToRelocations;
  FPointerToLinenumbers := ARecord.PointerToLinenumbers;
  FNumberOfRelocations := ARecord.NumberOfRelocations;
  FNumberOfLinenumbers := ARecord.NumberOfLinenumbers;
  FCharacteristics := ARecord.Characteristics;
end;

function _IMAGE_SECTION_HEADERWrapper.ObjToRec: _IMAGE_SECTION_HEADER;
begin
  result.VirtualAddress := FVirtualAddress;
  result.SizeOfRawData := FSizeOfRawData;
  result.PointerToRawData := FPointerToRawData;
  result.PointerToRelocations := FPointerToRelocations;
  result.PointerToLinenumbers := FPointerToLinenumbers;
  result.NumberOfRelocations := FNumberOfRelocations;
  result.NumberOfLinenumbers := FNumberOfLinenumbers;
  result.Characteristics := FCharacteristics;
end;

constructor IMAGE_LOAD_CONFIG_DIRECTORYWrapper.Create(ARecord: IMAGE_LOAD_CONFIG_DIRECTORY);
begin
  inherited Create;
  FCharacteristics := ARecord.Characteristics;
  FTimeDateStamp := ARecord.TimeDateStamp;
  FMajorVersion := ARecord.MajorVersion;
  FMinorVersion := ARecord.MinorVersion;
  FGlobalFlagsClear := ARecord.GlobalFlagsClear;
  FGlobalFlagsSet := ARecord.GlobalFlagsSet;
  FCriticalSectionDefaultTimeout := ARecord.CriticalSectionDefaultTimeout;
  FDeCommitFreeBlockThreshold := ARecord.DeCommitFreeBlockThreshold;
  FDeCommitTotalFreeThreshold := ARecord.DeCommitTotalFreeThreshold;
  FMaximumAllocationSize := ARecord.MaximumAllocationSize;
  FVirtualMemoryThreshold := ARecord.VirtualMemoryThreshold;
  FProcessHeapFlags := ARecord.ProcessHeapFlags;
  FProcessAffinityMask := ARecord.ProcessAffinityMask;
end;

function IMAGE_LOAD_CONFIG_DIRECTORYWrapper.ObjToRec: IMAGE_LOAD_CONFIG_DIRECTORY;
begin
  result.Characteristics := FCharacteristics;
  result.TimeDateStamp := FTimeDateStamp;
  result.MajorVersion := FMajorVersion;
  result.MinorVersion := FMinorVersion;
  result.GlobalFlagsClear := FGlobalFlagsClear;
  result.GlobalFlagsSet := FGlobalFlagsSet;
  result.CriticalSectionDefaultTimeout := FCriticalSectionDefaultTimeout;
  result.DeCommitFreeBlockThreshold := FDeCommitFreeBlockThreshold;
  result.DeCommitTotalFreeThreshold := FDeCommitTotalFreeThreshold;
  result.MaximumAllocationSize := FMaximumAllocationSize;
  result.VirtualMemoryThreshold := FVirtualMemoryThreshold;
  result.ProcessHeapFlags := FProcessHeapFlags;
  result.ProcessAffinityMask := FProcessAffinityMask;
end;

constructor IMAGE_RUNTIME_FUNCTION_ENTRYWrapper.Create(ARecord: IMAGE_RUNTIME_FUNCTION_ENTRY);
begin
  inherited Create;
  FBeginAddress := ARecord.BeginAddress;
  FEndAddress := ARecord.EndAddress;
  FPrologEndAddress := ARecord.PrologEndAddress;
end;

function IMAGE_RUNTIME_FUNCTION_ENTRYWrapper.ObjToRec: IMAGE_RUNTIME_FUNCTION_ENTRY;
begin
  result.BeginAddress := FBeginAddress;
  result.EndAddress := FEndAddress;
  result.PrologEndAddress := FPrologEndAddress;
end;

constructor _IMAGE_DEBUG_DIRECTORYWrapper.Create(ARecord: _IMAGE_DEBUG_DIRECTORY);
begin
  inherited Create;
  FCharacteristics := ARecord.Characteristics;
  FTimeDateStamp := ARecord.TimeDateStamp;
  FMajorVersion := ARecord.MajorVersion;
  FMinorVersion := ARecord.MinorVersion;
  F_Type := ARecord._Type;
  FSizeOfData := ARecord.SizeOfData;
  FAddressOfRawData := ARecord.AddressOfRawData;
  FPointerToRawData := ARecord.PointerToRawData;
end;

function _IMAGE_DEBUG_DIRECTORYWrapper.ObjToRec: _IMAGE_DEBUG_DIRECTORY;
begin
  result.Characteristics := FCharacteristics;
  result.TimeDateStamp := FTimeDateStamp;
  result.MajorVersion := FMajorVersion;
  result.MinorVersion := FMinorVersion;
  result._Type := F_Type;
  result.SizeOfData := FSizeOfData;
  result.AddressOfRawData := FAddressOfRawData;
  result.PointerToRawData := FPointerToRawData;
end;

constructor _IMAGE_COFF_SYMBOLS_HEADERWrapper.Create(ARecord: _IMAGE_COFF_SYMBOLS_HEADER);
begin
  inherited Create;
  FNumberOfSymbols := ARecord.NumberOfSymbols;
  FLvaToFirstSymbol := ARecord.LvaToFirstSymbol;
  FNumberOfLinenumbers := ARecord.NumberOfLinenumbers;
  FLvaToFirstLinenumber := ARecord.LvaToFirstLinenumber;
  FRvaToFirstByteOfCode := ARecord.RvaToFirstByteOfCode;
  FRvaToLastByteOfCode := ARecord.RvaToLastByteOfCode;
  FRvaToFirstByteOfData := ARecord.RvaToFirstByteOfData;
  FRvaToLastByteOfData := ARecord.RvaToLastByteOfData;
end;

function _IMAGE_COFF_SYMBOLS_HEADERWrapper.ObjToRec: _IMAGE_COFF_SYMBOLS_HEADER;
begin
  result.NumberOfSymbols := FNumberOfSymbols;
  result.LvaToFirstSymbol := FLvaToFirstSymbol;
  result.NumberOfLinenumbers := FNumberOfLinenumbers;
  result.LvaToFirstLinenumber := FLvaToFirstLinenumber;
  result.RvaToFirstByteOfCode := FRvaToFirstByteOfCode;
  result.RvaToLastByteOfCode := FRvaToLastByteOfCode;
  result.RvaToFirstByteOfData := FRvaToFirstByteOfData;
  result.RvaToLastByteOfData := FRvaToLastByteOfData;
end;

constructor _FPO_DATAWrapper.Create(ARecord: _FPO_DATA);
begin
  inherited Create;
  FulOffStart := ARecord.ulOffStart;
  FcbProcSize := ARecord.cbProcSize;
  FcdwLocals := ARecord.cdwLocals;
  FcdwParams := ARecord.cdwParams;
  FcbProlog := ARecord.cbProlog;
  FOtherStuff := ARecord.OtherStuff;
end;

function _FPO_DATAWrapper.ObjToRec: _FPO_DATA;
begin
  result.ulOffStart := FulOffStart;
  result.cbProcSize := FcbProcSize;
  result.cdwLocals := FcdwLocals;
  result.cdwParams := FcdwParams;
  result.cbProlog := FcbProlog;
  result.OtherStuff := FOtherStuff;
end;

constructor _IMAGE_DEBUG_MISCWrapper.Create(ARecord: _IMAGE_DEBUG_MISC);
begin
  inherited Create;
  FDataType := ARecord.DataType;
  FLength := ARecord.Length;
  FUnicode := ARecord.Unicode;
end;

function _IMAGE_DEBUG_MISCWrapper.ObjToRec: _IMAGE_DEBUG_MISC;
begin
  result.DataType := FDataType;
  result.Length := FLength;
  result.Unicode := FUnicode;
end;

constructor _IMAGE_FUNCTION_ENTRYWrapper.Create(ARecord: _IMAGE_FUNCTION_ENTRY);
begin
  inherited Create;
  FStartingAddress := ARecord.StartingAddress;
  FEndingAddress := ARecord.EndingAddress;
  FEndOfPrologue := ARecord.EndOfPrologue;
end;

function _IMAGE_FUNCTION_ENTRYWrapper.ObjToRec: _IMAGE_FUNCTION_ENTRY;
begin
  result.StartingAddress := FStartingAddress;
  result.EndingAddress := FEndingAddress;
  result.EndOfPrologue := FEndOfPrologue;
end;

constructor _RTL_CRITICAL_SECTION_DEBUGWrapper.Create(ARecord: _RTL_CRITICAL_SECTION_DEBUG);
begin
  inherited Create;
  FType_18 := ARecord.Type_18;
  FCreatorBackTraceIndex := ARecord.CreatorBackTraceIndex;
  FEntryCount := ARecord.EntryCount;
  FContentionCount := ARecord.ContentionCount;
end;

function _RTL_CRITICAL_SECTION_DEBUGWrapper.ObjToRec: _RTL_CRITICAL_SECTION_DEBUG;
begin
  result.Type_18 := FType_18;
  result.CreatorBackTraceIndex := FCreatorBackTraceIndex;
  result.EntryCount := FEntryCount;
  result.ContentionCount := FContentionCount;
end;

constructor _RTL_CRITICAL_SECTIONWrapper.Create(ARecord: _RTL_CRITICAL_SECTION);
begin
  inherited Create;
  FLockCount := ARecord.LockCount;
  FRecursionCount := ARecord.RecursionCount;
  FOwningThread := ARecord.OwningThread;
  FLockSemaphore := ARecord.LockSemaphore;
  FReserved := ARecord.Reserved;
end;

function _RTL_CRITICAL_SECTIONWrapper.ObjToRec: _RTL_CRITICAL_SECTION;
begin
  result.LockCount := FLockCount;
  result.RecursionCount := FRecursionCount;
  result.OwningThread := FOwningThread;
  result.LockSemaphore := FLockSemaphore;
  result.Reserved := FReserved;
end;

constructor _POINTLWrapper.Create(ARecord: _POINTL);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
end;

function _POINTLWrapper.ObjToRec: _POINTL;
begin
  result.x := Fx;
  result.y := Fy;
end;

constructor _OVERLAPPEDWrapper.Create(ARecord: _OVERLAPPED);
begin
  inherited Create;
  FInternal := ARecord.Internal;
  FInternalHigh := ARecord.InternalHigh;
  FOffset := ARecord.Offset;
  FOffsetHigh := ARecord.OffsetHigh;
  FhEvent := ARecord.hEvent;
end;

function _OVERLAPPEDWrapper.ObjToRec: _OVERLAPPED;
begin
  result.Internal := FInternal;
  result.InternalHigh := FInternalHigh;
  result.Offset := FOffset;
  result.OffsetHigh := FOffsetHigh;
  result.hEvent := FhEvent;
end;

constructor _SECURITY_ATTRIBUTESWrapper.Create(ARecord: _SECURITY_ATTRIBUTES);
begin
  inherited Create;
  FnLength := ARecord.nLength;
  FbInheritHandle := ARecord.bInheritHandle;
end;

function _SECURITY_ATTRIBUTESWrapper.ObjToRec: _SECURITY_ATTRIBUTES;
begin
  result.nLength := FnLength;
  result.bInheritHandle := FbInheritHandle;
end;

constructor _PROCESS_INFORMATIONWrapper.Create(ARecord: _PROCESS_INFORMATION);
begin
  inherited Create;
  FhProcess := ARecord.hProcess;
  FhThread := ARecord.hThread;
  FdwProcessId := ARecord.dwProcessId;
  FdwThreadId := ARecord.dwThreadId;
end;

function _PROCESS_INFORMATIONWrapper.ObjToRec: _PROCESS_INFORMATION;
begin
  result.hProcess := FhProcess;
  result.hThread := FhThread;
  result.dwProcessId := FdwProcessId;
  result.dwThreadId := FdwThreadId;
end;

constructor _FILETIMEWrapper.Create(ARecord: _FILETIME);
begin
  inherited Create;
  FdwLowDateTime := ARecord.dwLowDateTime;
  FdwHighDateTime := ARecord.dwHighDateTime;
end;

function _FILETIMEWrapper.ObjToRec: _FILETIME;
begin
  result.dwLowDateTime := FdwLowDateTime;
  result.dwHighDateTime := FdwHighDateTime;
end;

constructor _SYSTEMTIMEWrapper.Create(ARecord: _SYSTEMTIME);
begin
  inherited Create;
  FwYear := ARecord.wYear;
  FwMonth := ARecord.wMonth;
  FwDayOfWeek := ARecord.wDayOfWeek;
  FwDay := ARecord.wDay;
  FwHour := ARecord.wHour;
  FwMinute := ARecord.wMinute;
  FwSecond := ARecord.wSecond;
  FwMilliseconds := ARecord.wMilliseconds;
end;

function _SYSTEMTIMEWrapper.ObjToRec: _SYSTEMTIME;
begin
  result.wYear := FwYear;
  result.wMonth := FwMonth;
  result.wDayOfWeek := FwDayOfWeek;
  result.wDay := FwDay;
  result.wHour := FwHour;
  result.wMinute := FwMinute;
  result.wSecond := FwSecond;
  result.wMilliseconds := FwMilliseconds;
end;

constructor _COMMPROPWrapper.Create(ARecord: _COMMPROP);
begin
  inherited Create;
  FwPacketLength := ARecord.wPacketLength;
  FwPacketVersion := ARecord.wPacketVersion;
  FdwServiceMask := ARecord.dwServiceMask;
  FdwReserved1 := ARecord.dwReserved1;
  FdwMaxTxQueue := ARecord.dwMaxTxQueue;
  FdwMaxRxQueue := ARecord.dwMaxRxQueue;
  FdwMaxBaud := ARecord.dwMaxBaud;
  FdwProvSubType := ARecord.dwProvSubType;
  FdwProvCapabilities := ARecord.dwProvCapabilities;
  FdwSettableParams := ARecord.dwSettableParams;
  FdwSettableBaud := ARecord.dwSettableBaud;
  FwSettableData := ARecord.wSettableData;
  FwSettableStopParity := ARecord.wSettableStopParity;
  FdwCurrentTxQueue := ARecord.dwCurrentTxQueue;
  FdwCurrentRxQueue := ARecord.dwCurrentRxQueue;
  FdwProvSpec1 := ARecord.dwProvSpec1;
  FdwProvSpec2 := ARecord.dwProvSpec2;
end;

function _COMMPROPWrapper.ObjToRec: _COMMPROP;
begin
  result.wPacketLength := FwPacketLength;
  result.wPacketVersion := FwPacketVersion;
  result.dwServiceMask := FdwServiceMask;
  result.dwReserved1 := FdwReserved1;
  result.dwMaxTxQueue := FdwMaxTxQueue;
  result.dwMaxRxQueue := FdwMaxRxQueue;
  result.dwMaxBaud := FdwMaxBaud;
  result.dwProvSubType := FdwProvSubType;
  result.dwProvCapabilities := FdwProvCapabilities;
  result.dwSettableParams := FdwSettableParams;
  result.dwSettableBaud := FdwSettableBaud;
  result.wSettableData := FwSettableData;
  result.wSettableStopParity := FwSettableStopParity;
  result.dwCurrentTxQueue := FdwCurrentTxQueue;
  result.dwCurrentRxQueue := FdwCurrentRxQueue;
  result.dwProvSpec1 := FdwProvSpec1;
  result.dwProvSpec2 := FdwProvSpec2;
end;

constructor _COMSTATWrapper.Create(ARecord: _COMSTAT);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FcbInQue := ARecord.cbInQue;
  FcbOutQue := ARecord.cbOutQue;
end;

function _COMSTATWrapper.ObjToRec: _COMSTAT;
begin
  result.Flags := FFlags;
  result.cbInQue := FcbInQue;
  result.cbOutQue := FcbOutQue;
end;

constructor _DCBWrapper.Create(ARecord: _DCB);
begin
  inherited Create;
  FDCBlength := ARecord.DCBlength;
  FBaudRate := ARecord.BaudRate;
  FFlags := ARecord.Flags;
  FwReserved := ARecord.wReserved;
  FXonLim := ARecord.XonLim;
  FXoffLim := ARecord.XoffLim;
  FByteSize := ARecord.ByteSize;
  FParity := ARecord.Parity;
  FStopBits := ARecord.StopBits;
  FXonChar := ARecord.XonChar;
  FXoffChar := ARecord.XoffChar;
  FErrorChar := ARecord.ErrorChar;
  FEofChar := ARecord.EofChar;
  FEvtChar := ARecord.EvtChar;
  FwReserved1 := ARecord.wReserved1;
end;

function _DCBWrapper.ObjToRec: _DCB;
begin
  result.DCBlength := FDCBlength;
  result.BaudRate := FBaudRate;
  result.Flags := FFlags;
  result.wReserved := FwReserved;
  result.XonLim := FXonLim;
  result.XoffLim := FXoffLim;
  result.ByteSize := FByteSize;
  result.Parity := FParity;
  result.StopBits := FStopBits;
  result.XonChar := FXonChar;
  result.XoffChar := FXoffChar;
  result.ErrorChar := FErrorChar;
  result.EofChar := FEofChar;
  result.EvtChar := FEvtChar;
  result.wReserved1 := FwReserved1;
end;

constructor _COMMTIMEOUTSWrapper.Create(ARecord: _COMMTIMEOUTS);
begin
  inherited Create;
  FReadIntervalTimeout := ARecord.ReadIntervalTimeout;
  FReadTotalTimeoutMultiplier := ARecord.ReadTotalTimeoutMultiplier;
  FReadTotalTimeoutConstant := ARecord.ReadTotalTimeoutConstant;
  FWriteTotalTimeoutMultiplier := ARecord.WriteTotalTimeoutMultiplier;
  FWriteTotalTimeoutConstant := ARecord.WriteTotalTimeoutConstant;
end;

function _COMMTIMEOUTSWrapper.ObjToRec: _COMMTIMEOUTS;
begin
  result.ReadIntervalTimeout := FReadIntervalTimeout;
  result.ReadTotalTimeoutMultiplier := FReadTotalTimeoutMultiplier;
  result.ReadTotalTimeoutConstant := FReadTotalTimeoutConstant;
  result.WriteTotalTimeoutMultiplier := FWriteTotalTimeoutMultiplier;
  result.WriteTotalTimeoutConstant := FWriteTotalTimeoutConstant;
end;

constructor _COMMCONFIGWrapper.Create(ARecord: _COMMCONFIG);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FwVersion := ARecord.wVersion;
  FwReserved := ARecord.wReserved;
  FdwProviderSubType := ARecord.dwProviderSubType;
  FdwProviderOffset := ARecord.dwProviderOffset;
  FdwProviderSize := ARecord.dwProviderSize;
end;

function _COMMCONFIGWrapper.ObjToRec: _COMMCONFIG;
begin
  result.dwSize := FdwSize;
  result.wVersion := FwVersion;
  result.wReserved := FwReserved;
  result.dwProviderSubType := FdwProviderSubType;
  result.dwProviderOffset := FdwProviderOffset;
  result.dwProviderSize := FdwProviderSize;
end;

constructor _SYSTEM_INFOWrapper.Create(ARecord: _SYSTEM_INFO);
begin
  inherited Create;
  FdwOemId := ARecord.dwOemId;
  FwProcessorArchitecture := ARecord.wProcessorArchitecture;
  FwReserved := ARecord.wReserved;
  FdwPageSize := ARecord.dwPageSize;
  FdwActiveProcessorMask := ARecord.dwActiveProcessorMask;
  FdwNumberOfProcessors := ARecord.dwNumberOfProcessors;
  FdwProcessorType := ARecord.dwProcessorType;
  FdwAllocationGranularity := ARecord.dwAllocationGranularity;
  FwProcessorLevel := ARecord.wProcessorLevel;
  FwProcessorRevision := ARecord.wProcessorRevision;
end;

function _SYSTEM_INFOWrapper.ObjToRec: _SYSTEM_INFO;
begin
  result.dwOemId := FdwOemId;
  result.wProcessorArchitecture := FwProcessorArchitecture;
  result.wReserved := FwReserved;
  result.dwPageSize := FdwPageSize;
  result.dwActiveProcessorMask := FdwActiveProcessorMask;
  result.dwNumberOfProcessors := FdwNumberOfProcessors;
  result.dwProcessorType := FdwProcessorType;
  result.dwAllocationGranularity := FdwAllocationGranularity;
  result.wProcessorLevel := FwProcessorLevel;
  result.wProcessorRevision := FwProcessorRevision;
end;

constructor _MEMORYSTATUSWrapper.Create(ARecord: _MEMORYSTATUS);
begin
  inherited Create;
  FdwLength := ARecord.dwLength;
  FdwMemoryLoad := ARecord.dwMemoryLoad;
  FdwTotalPhys := ARecord.dwTotalPhys;
  FdwAvailPhys := ARecord.dwAvailPhys;
  FdwTotalPageFile := ARecord.dwTotalPageFile;
  FdwAvailPageFile := ARecord.dwAvailPageFile;
  FdwTotalVirtual := ARecord.dwTotalVirtual;
  FdwAvailVirtual := ARecord.dwAvailVirtual;
end;

function _MEMORYSTATUSWrapper.ObjToRec: _MEMORYSTATUS;
begin
  result.dwLength := FdwLength;
  result.dwMemoryLoad := FdwMemoryLoad;
  result.dwTotalPhys := FdwTotalPhys;
  result.dwAvailPhys := FdwAvailPhys;
  result.dwTotalPageFile := FdwTotalPageFile;
  result.dwAvailPageFile := FdwAvailPageFile;
  result.dwTotalVirtual := FdwTotalVirtual;
  result.dwAvailVirtual := FdwAvailVirtual;
end;

constructor _EXCEPTION_DEBUG_INFOWrapper.Create(ARecord: _EXCEPTION_DEBUG_INFO);
begin
  inherited Create;
  FdwFirstChance := ARecord.dwFirstChance;
end;

function _EXCEPTION_DEBUG_INFOWrapper.ObjToRec: _EXCEPTION_DEBUG_INFO;
begin
  result.dwFirstChance := FdwFirstChance;
end;

constructor _CREATE_THREAD_DEBUG_INFOWrapper.Create(ARecord: _CREATE_THREAD_DEBUG_INFO);
begin
  inherited Create;
  FhThread := ARecord.hThread;
end;

function _CREATE_THREAD_DEBUG_INFOWrapper.ObjToRec: _CREATE_THREAD_DEBUG_INFO;
begin
  result.hThread := FhThread;
end;

constructor _CREATE_PROCESS_DEBUG_INFOWrapper.Create(ARecord: _CREATE_PROCESS_DEBUG_INFO);
begin
  inherited Create;
  FhFile := ARecord.hFile;
  FhProcess := ARecord.hProcess;
  FhThread := ARecord.hThread;
  FdwDebugInfoFileOffset := ARecord.dwDebugInfoFileOffset;
  FnDebugInfoSize := ARecord.nDebugInfoSize;
  FfUnicode := ARecord.fUnicode;
end;

function _CREATE_PROCESS_DEBUG_INFOWrapper.ObjToRec: _CREATE_PROCESS_DEBUG_INFO;
begin
  result.hFile := FhFile;
  result.hProcess := FhProcess;
  result.hThread := FhThread;
  result.dwDebugInfoFileOffset := FdwDebugInfoFileOffset;
  result.nDebugInfoSize := FnDebugInfoSize;
  result.fUnicode := FfUnicode;
end;

constructor _EXIT_THREAD_DEBUG_INFOWrapper.Create(ARecord: _EXIT_THREAD_DEBUG_INFO);
begin
  inherited Create;
  FdwExitCode := ARecord.dwExitCode;
end;

function _EXIT_THREAD_DEBUG_INFOWrapper.ObjToRec: _EXIT_THREAD_DEBUG_INFO;
begin
  result.dwExitCode := FdwExitCode;
end;

constructor _EXIT_PROCESS_DEBUG_INFOWrapper.Create(ARecord: _EXIT_PROCESS_DEBUG_INFO);
begin
  inherited Create;
  FdwExitCode := ARecord.dwExitCode;
end;

function _EXIT_PROCESS_DEBUG_INFOWrapper.ObjToRec: _EXIT_PROCESS_DEBUG_INFO;
begin
  result.dwExitCode := FdwExitCode;
end;

constructor _LOAD_DLL_DEBUG_INFOWrapper.Create(ARecord: _LOAD_DLL_DEBUG_INFO);
begin
  inherited Create;
  FhFile := ARecord.hFile;
  FdwDebugInfoFileOffset := ARecord.dwDebugInfoFileOffset;
  FnDebugInfoSize := ARecord.nDebugInfoSize;
  FfUnicode := ARecord.fUnicode;
end;

function _LOAD_DLL_DEBUG_INFOWrapper.ObjToRec: _LOAD_DLL_DEBUG_INFO;
begin
  result.hFile := FhFile;
  result.dwDebugInfoFileOffset := FdwDebugInfoFileOffset;
  result.nDebugInfoSize := FnDebugInfoSize;
  result.fUnicode := FfUnicode;
end;

constructor _UNLOAD_DLL_DEBUG_INFOWrapper.Create(ARecord: _UNLOAD_DLL_DEBUG_INFO);
begin
  inherited Create;
end;

function _UNLOAD_DLL_DEBUG_INFOWrapper.ObjToRec: _UNLOAD_DLL_DEBUG_INFO;
begin
end;

constructor _OUTPUT_DEBUG_STRING_INFOWrapper.Create(ARecord: _OUTPUT_DEBUG_STRING_INFO);
begin
  inherited Create;
  FfUnicode := ARecord.fUnicode;
  FnDebugStringLength := ARecord.nDebugStringLength;
end;

function _OUTPUT_DEBUG_STRING_INFOWrapper.ObjToRec: _OUTPUT_DEBUG_STRING_INFO;
begin
  result.fUnicode := FfUnicode;
  result.nDebugStringLength := FnDebugStringLength;
end;

constructor _RIP_INFOWrapper.Create(ARecord: _RIP_INFO);
begin
  inherited Create;
  FdwError := ARecord.dwError;
  FdwType := ARecord.dwType;
end;

function _RIP_INFOWrapper.ObjToRec: _RIP_INFO;
begin
  result.dwError := FdwError;
  result.dwType := FdwType;
end;

constructor _DEBUG_EVENTWrapper.Create(ARecord: _DEBUG_EVENT);
begin
  inherited Create;
  FdwDebugEventCode := ARecord.dwDebugEventCode;
  FdwProcessId := ARecord.dwProcessId;
  FdwThreadId := ARecord.dwThreadId;
end;

function _DEBUG_EVENTWrapper.ObjToRec: _DEBUG_EVENT;
begin
  result.dwDebugEventCode := FdwDebugEventCode;
  result.dwProcessId := FdwProcessId;
  result.dwThreadId := FdwThreadId;
end;

constructor _OFSTRUCTWrapper.Create(ARecord: _OFSTRUCT);
begin
  inherited Create;
  FcBytes := ARecord.cBytes;
  FfFixedDisk := ARecord.fFixedDisk;
  FnErrCode := ARecord.nErrCode;
  FReserved1 := ARecord.Reserved1;
  FReserved2 := ARecord.Reserved2;
end;

function _OFSTRUCTWrapper.ObjToRec: _OFSTRUCT;
begin
  result.cBytes := FcBytes;
  result.fFixedDisk := FfFixedDisk;
  result.nErrCode := FnErrCode;
  result.Reserved1 := FReserved1;
  result.Reserved2 := FReserved2;
end;

constructor _PROCESS_HEAP_ENTRYWrapper.Create(ARecord: _PROCESS_HEAP_ENTRY);
begin
  inherited Create;
  FcbData := ARecord.cbData;
  FcbOverhead := ARecord.cbOverhead;
  FiRegionIndex := ARecord.iRegionIndex;
  FwFlags := ARecord.wFlags;
  FhMem := ARecord.hMem;
  FdwCommittedSize := ARecord.dwCommittedSize;
  FdwUnCommittedSize := ARecord.dwUnCommittedSize;
end;

function _PROCESS_HEAP_ENTRYWrapper.ObjToRec: _PROCESS_HEAP_ENTRY;
begin
  result.cbData := FcbData;
  result.cbOverhead := FcbOverhead;
  result.iRegionIndex := FiRegionIndex;
  result.wFlags := FwFlags;
  result.hMem := FhMem;
  result.dwCommittedSize := FdwCommittedSize;
  result.dwUnCommittedSize := FdwUnCommittedSize;
end;

constructor _BY_HANDLE_FILE_INFORMATIONWrapper.Create(ARecord: _BY_HANDLE_FILE_INFORMATION);
begin
  inherited Create;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FdwVolumeSerialNumber := ARecord.dwVolumeSerialNumber;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
  FnNumberOfLinks := ARecord.nNumberOfLinks;
  FnFileIndexHigh := ARecord.nFileIndexHigh;
  FnFileIndexLow := ARecord.nFileIndexLow;
end;

function _BY_HANDLE_FILE_INFORMATIONWrapper.ObjToRec: _BY_HANDLE_FILE_INFORMATION;
begin
  result.dwFileAttributes := FdwFileAttributes;
  result.dwVolumeSerialNumber := FdwVolumeSerialNumber;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
  result.nNumberOfLinks := FnNumberOfLinks;
  result.nFileIndexHigh := FnFileIndexHigh;
  result.nFileIndexLow := FnFileIndexLow;
end;

constructor _TIME_ZONE_INFORMATIONWrapper.Create(ARecord: _TIME_ZONE_INFORMATION);
begin
  inherited Create;
  FBias := ARecord.Bias;
  FStandardBias := ARecord.StandardBias;
  FDaylightBias := ARecord.DaylightBias;
end;

function _TIME_ZONE_INFORMATIONWrapper.ObjToRec: _TIME_ZONE_INFORMATION;
begin
  result.Bias := FBias;
  result.StandardBias := FStandardBias;
  result.DaylightBias := FDaylightBias;
end;

constructor _RECOVERY_AGENT_INFORMATIONAWrapper.Create(ARecord: _RECOVERY_AGENT_INFORMATIONA);
begin
  inherited Create;
  FNextEntryOffset := ARecord.NextEntryOffset;
  FAgentNameLength := ARecord.AgentNameLength;
end;

function _RECOVERY_AGENT_INFORMATIONAWrapper.ObjToRec: _RECOVERY_AGENT_INFORMATIONA;
begin
  result.NextEntryOffset := FNextEntryOffset;
  result.AgentNameLength := FAgentNameLength;
end;

constructor _RECOVERY_AGENT_INFORMATIONWWrapper.Create(ARecord: _RECOVERY_AGENT_INFORMATIONW);
begin
  inherited Create;
  FNextEntryOffset := ARecord.NextEntryOffset;
  FAgentNameLength := ARecord.AgentNameLength;
end;

function _RECOVERY_AGENT_INFORMATIONWWrapper.ObjToRec: _RECOVERY_AGENT_INFORMATIONW;
begin
  result.NextEntryOffset := FNextEntryOffset;
  result.AgentNameLength := FAgentNameLength;
end;

constructor _WIN32_STREAM_IDWrapper.Create(ARecord: _WIN32_STREAM_ID);
begin
  inherited Create;
  FdwStreamId := ARecord.dwStreamId;
  FdwStreamAttributes := ARecord.dwStreamAttributes;
  FSize := ARecord.Size;
  FdwStreamNameSize := ARecord.dwStreamNameSize;
end;

function _WIN32_STREAM_IDWrapper.ObjToRec: _WIN32_STREAM_ID;
begin
  result.dwStreamId := FdwStreamId;
  result.dwStreamAttributes := FdwStreamAttributes;
  result.Size := FSize;
  result.dwStreamNameSize := FdwStreamNameSize;
end;

constructor _STARTUPINFOAWrapper.Create(ARecord: _STARTUPINFOA);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwX := ARecord.dwX;
  FdwY := ARecord.dwY;
  FdwXSize := ARecord.dwXSize;
  FdwYSize := ARecord.dwYSize;
  FdwXCountChars := ARecord.dwXCountChars;
  FdwYCountChars := ARecord.dwYCountChars;
  FdwFillAttribute := ARecord.dwFillAttribute;
  FdwFlags := ARecord.dwFlags;
  FwShowWindow := ARecord.wShowWindow;
  FcbReserved2 := ARecord.cbReserved2;
  FhStdInput := ARecord.hStdInput;
  FhStdOutput := ARecord.hStdOutput;
  FhStdError := ARecord.hStdError;
end;

function _STARTUPINFOAWrapper.ObjToRec: _STARTUPINFOA;
begin
  result.cb := Fcb;
  result.dwX := FdwX;
  result.dwY := FdwY;
  result.dwXSize := FdwXSize;
  result.dwYSize := FdwYSize;
  result.dwXCountChars := FdwXCountChars;
  result.dwYCountChars := FdwYCountChars;
  result.dwFillAttribute := FdwFillAttribute;
  result.dwFlags := FdwFlags;
  result.wShowWindow := FwShowWindow;
  result.cbReserved2 := FcbReserved2;
  result.hStdInput := FhStdInput;
  result.hStdOutput := FhStdOutput;
  result.hStdError := FhStdError;
end;

constructor _STARTUPINFOWWrapper.Create(ARecord: _STARTUPINFOW);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwX := ARecord.dwX;
  FdwY := ARecord.dwY;
  FdwXSize := ARecord.dwXSize;
  FdwYSize := ARecord.dwYSize;
  FdwXCountChars := ARecord.dwXCountChars;
  FdwYCountChars := ARecord.dwYCountChars;
  FdwFillAttribute := ARecord.dwFillAttribute;
  FdwFlags := ARecord.dwFlags;
  FwShowWindow := ARecord.wShowWindow;
  FcbReserved2 := ARecord.cbReserved2;
  FhStdInput := ARecord.hStdInput;
  FhStdOutput := ARecord.hStdOutput;
  FhStdError := ARecord.hStdError;
end;

function _STARTUPINFOWWrapper.ObjToRec: _STARTUPINFOW;
begin
  result.cb := Fcb;
  result.dwX := FdwX;
  result.dwY := FdwY;
  result.dwXSize := FdwXSize;
  result.dwYSize := FdwYSize;
  result.dwXCountChars := FdwXCountChars;
  result.dwYCountChars := FdwYCountChars;
  result.dwFillAttribute := FdwFillAttribute;
  result.dwFlags := FdwFlags;
  result.wShowWindow := FwShowWindow;
  result.cbReserved2 := FcbReserved2;
  result.hStdInput := FhStdInput;
  result.hStdOutput := FhStdOutput;
  result.hStdError := FhStdError;
end;

constructor _WIN32_FIND_DATAAWrapper.Create(ARecord: _WIN32_FIND_DATAA);
begin
  inherited Create;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
  FdwReserved0 := ARecord.dwReserved0;
  FdwReserved1 := ARecord.dwReserved1;
end;

function _WIN32_FIND_DATAAWrapper.ObjToRec: _WIN32_FIND_DATAA;
begin
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
  result.dwReserved0 := FdwReserved0;
  result.dwReserved1 := FdwReserved1;
end;

constructor _WIN32_FIND_DATAWWrapper.Create(ARecord: _WIN32_FIND_DATAW);
begin
  inherited Create;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
  FdwReserved0 := ARecord.dwReserved0;
  FdwReserved1 := ARecord.dwReserved1;
end;

function _WIN32_FIND_DATAWWrapper.ObjToRec: _WIN32_FIND_DATAW;
begin
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
  result.dwReserved0 := FdwReserved0;
  result.dwReserved1 := FdwReserved1;
end;

constructor _WIN32_FILE_ATTRIBUTE_DATAWrapper.Create(ARecord: _WIN32_FILE_ATTRIBUTE_DATA);
begin
  inherited Create;
  FdwFileAttributes := ARecord.dwFileAttributes;
  FnFileSizeHigh := ARecord.nFileSizeHigh;
  FnFileSizeLow := ARecord.nFileSizeLow;
end;

function _WIN32_FILE_ATTRIBUTE_DATAWrapper.ObjToRec: _WIN32_FILE_ATTRIBUTE_DATA;
begin
  result.dwFileAttributes := FdwFileAttributes;
  result.nFileSizeHigh := FnFileSizeHigh;
  result.nFileSizeLow := FnFileSizeLow;
end;

constructor tagHW_PROFILE_INFOAWrapper.Create(ARecord: tagHW_PROFILE_INFOA);
begin
  inherited Create;
  FdwDockInfo := ARecord.dwDockInfo;
end;

function tagHW_PROFILE_INFOAWrapper.ObjToRec: tagHW_PROFILE_INFOA;
begin
  result.dwDockInfo := FdwDockInfo;
end;

constructor tagHW_PROFILE_INFOWWrapper.Create(ARecord: tagHW_PROFILE_INFOW);
begin
  inherited Create;
  FdwDockInfo := ARecord.dwDockInfo;
end;

function tagHW_PROFILE_INFOWWrapper.ObjToRec: tagHW_PROFILE_INFOW;
begin
  result.dwDockInfo := FdwDockInfo;
end;

constructor _OSVERSIONINFOAWrapper.Create(ARecord: _OSVERSIONINFOA);
begin
  inherited Create;
  FdwOSVersionInfoSize := ARecord.dwOSVersionInfoSize;
  FdwMajorVersion := ARecord.dwMajorVersion;
  FdwMinorVersion := ARecord.dwMinorVersion;
  FdwBuildNumber := ARecord.dwBuildNumber;
  FdwPlatformId := ARecord.dwPlatformId;
end;

function _OSVERSIONINFOAWrapper.ObjToRec: _OSVERSIONINFOA;
begin
  result.dwOSVersionInfoSize := FdwOSVersionInfoSize;
  result.dwMajorVersion := FdwMajorVersion;
  result.dwMinorVersion := FdwMinorVersion;
  result.dwBuildNumber := FdwBuildNumber;
  result.dwPlatformId := FdwPlatformId;
end;

constructor _OSVERSIONINFOWWrapper.Create(ARecord: _OSVERSIONINFOW);
begin
  inherited Create;
  FdwOSVersionInfoSize := ARecord.dwOSVersionInfoSize;
  FdwMajorVersion := ARecord.dwMajorVersion;
  FdwMinorVersion := ARecord.dwMinorVersion;
  FdwBuildNumber := ARecord.dwBuildNumber;
  FdwPlatformId := ARecord.dwPlatformId;
end;

function _OSVERSIONINFOWWrapper.ObjToRec: _OSVERSIONINFOW;
begin
  result.dwOSVersionInfoSize := FdwOSVersionInfoSize;
  result.dwMajorVersion := FdwMajorVersion;
  result.dwMinorVersion := FdwMinorVersion;
  result.dwBuildNumber := FdwBuildNumber;
  result.dwPlatformId := FdwPlatformId;
end;

constructor _SYSTEM_POWER_STATUSWrapper.Create(ARecord: _SYSTEM_POWER_STATUS);
begin
  inherited Create;
  FACLineStatus := ARecord.ACLineStatus;
  FBatteryFlag := ARecord.BatteryFlag;
  FBatteryLifePercent := ARecord.BatteryLifePercent;
  FReserved1 := ARecord.Reserved1;
  FBatteryLifeTime := ARecord.BatteryLifeTime;
  FBatteryFullLifeTime := ARecord.BatteryFullLifeTime;
end;

function _SYSTEM_POWER_STATUSWrapper.ObjToRec: _SYSTEM_POWER_STATUS;
begin
  result.ACLineStatus := FACLineStatus;
  result.BatteryFlag := FBatteryFlag;
  result.BatteryLifePercent := FBatteryLifePercent;
  result.Reserved1 := FReserved1;
  result.BatteryLifeTime := FBatteryLifeTime;
  result.BatteryFullLifeTime := FBatteryFullLifeTime;
end;

constructor _WIN_CERTIFICATEWrapper.Create(ARecord: _WIN_CERTIFICATE);
begin
  inherited Create;
  FdwLength := ARecord.dwLength;
  FwRevision := ARecord.wRevision;
  FwCertificateType := ARecord.wCertificateType;
end;

function _WIN_CERTIFICATEWrapper.ObjToRec: _WIN_CERTIFICATE;
begin
  result.dwLength := FdwLength;
  result.wRevision := FwRevision;
  result.wCertificateType := FwCertificateType;
end;

constructor _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper.Create(ARecord: _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT);
begin
  inherited Create;
  FhClientToken := ARecord.hClientToken;
end;

function _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECTWrapper.ObjToRec: _WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT;
begin
  result.hClientToken := FhClientToken;
end;

constructor _WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper.Create(ARecord: _WIN_TRUST_ACTDATA_SUBJECT_ONLY);
begin
  inherited Create;
end;

function _WIN_TRUST_ACTDATA_SUBJECT_ONLYWrapper.ObjToRec: _WIN_TRUST_ACTDATA_SUBJECT_ONLY;
begin
end;

constructor _WIN_TRUST_SUBJECT_FILEWrapper.Create(ARecord: _WIN_TRUST_SUBJECT_FILE);
begin
  inherited Create;
  FhFile := ARecord.hFile;
end;

function _WIN_TRUST_SUBJECT_FILEWrapper.ObjToRec: _WIN_TRUST_SUBJECT_FILE;
begin
  result.hFile := FhFile;
end;

constructor _WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper.Create(ARecord: _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY);
begin
  inherited Create;
  FhFile := ARecord.hFile;
end;

function _WIN_TRUST_SUBJECT_FILE_AND_DISPLAYWrapper.ObjToRec: _WIN_TRUST_SUBJECT_FILE_AND_DISPLAY;
begin
  result.hFile := FhFile;
end;

constructor _WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper.Create(ARecord: _WIN_SPUB_TRUSTED_PUBLISHER_DATA);
begin
  inherited Create;
  FhClientToken := ARecord.hClientToken;
end;

function _WIN_SPUB_TRUSTED_PUBLISHER_DATAWrapper.ObjToRec: _WIN_SPUB_TRUSTED_PUBLISHER_DATA;
begin
  result.hClientToken := FhClientToken;
end;

constructor tagXFORMWrapper.Create(ARecord: tagXFORM);
begin
  inherited Create;
  FeM11 := ARecord.eM11;
  FeM12 := ARecord.eM12;
  FeM21 := ARecord.eM21;
  FeM22 := ARecord.eM22;
  FeDx := ARecord.eDx;
  FeDy := ARecord.eDy;
end;

function tagXFORMWrapper.ObjToRec: tagXFORM;
begin
  result.eM11 := FeM11;
  result.eM12 := FeM12;
  result.eM21 := FeM21;
  result.eM22 := FeM22;
  result.eDx := FeDx;
  result.eDy := FeDy;
end;

constructor tagBITMAPWrapper.Create(ARecord: tagBITMAP);
begin
  inherited Create;
  FbmType := ARecord.bmType;
  FbmWidth := ARecord.bmWidth;
  FbmHeight := ARecord.bmHeight;
  FbmWidthBytes := ARecord.bmWidthBytes;
  FbmPlanes := ARecord.bmPlanes;
  FbmBitsPixel := ARecord.bmBitsPixel;
end;

function tagBITMAPWrapper.ObjToRec: tagBITMAP;
begin
  result.bmType := FbmType;
  result.bmWidth := FbmWidth;
  result.bmHeight := FbmHeight;
  result.bmWidthBytes := FbmWidthBytes;
  result.bmPlanes := FbmPlanes;
  result.bmBitsPixel := FbmBitsPixel;
end;

constructor tagRGBTRIPLEWrapper.Create(ARecord: tagRGBTRIPLE);
begin
  inherited Create;
  FrgbtBlue := ARecord.rgbtBlue;
  FrgbtGreen := ARecord.rgbtGreen;
  FrgbtRed := ARecord.rgbtRed;
end;

function tagRGBTRIPLEWrapper.ObjToRec: tagRGBTRIPLE;
begin
  result.rgbtBlue := FrgbtBlue;
  result.rgbtGreen := FrgbtGreen;
  result.rgbtRed := FrgbtRed;
end;

constructor tagRGBQUADWrapper.Create(ARecord: tagRGBQUAD);
begin
  inherited Create;
  FrgbBlue := ARecord.rgbBlue;
  FrgbGreen := ARecord.rgbGreen;
  FrgbRed := ARecord.rgbRed;
  FrgbReserved := ARecord.rgbReserved;
end;

function tagRGBQUADWrapper.ObjToRec: tagRGBQUAD;
begin
  result.rgbBlue := FrgbBlue;
  result.rgbGreen := FrgbGreen;
  result.rgbRed := FrgbRed;
  result.rgbReserved := FrgbReserved;
end;

constructor tagCIEXYZWrapper.Create(ARecord: tagCIEXYZ);
begin
  inherited Create;
  FciexyzX := ARecord.ciexyzX;
  FciexyzY := ARecord.ciexyzY;
  FciexyzZ := ARecord.ciexyzZ;
end;

function tagCIEXYZWrapper.ObjToRec: tagCIEXYZ;
begin
  result.ciexyzX := FciexyzX;
  result.ciexyzY := FciexyzY;
  result.ciexyzZ := FciexyzZ;
end;

constructor tagICEXYZTRIPLEWrapper.Create(ARecord: tagICEXYZTRIPLE);
begin
  inherited Create;
end;

function tagICEXYZTRIPLEWrapper.ObjToRec: tagICEXYZTRIPLE;
begin
end;

constructor tagLOGCOLORSPACEAWrapper.Create(ARecord: tagLOGCOLORSPACEA);
begin
  inherited Create;
  FlcsSignature := ARecord.lcsSignature;
  FlcsVersion := ARecord.lcsVersion;
  FlcsSize := ARecord.lcsSize;
  FlcsCSType := ARecord.lcsCSType;
  FlcsIntent := ARecord.lcsIntent;
  FlcsGammaRed := ARecord.lcsGammaRed;
  FlcsGammaGreen := ARecord.lcsGammaGreen;
  FlcsGammaBlue := ARecord.lcsGammaBlue;
end;

function tagLOGCOLORSPACEAWrapper.ObjToRec: tagLOGCOLORSPACEA;
begin
  result.lcsSignature := FlcsSignature;
  result.lcsVersion := FlcsVersion;
  result.lcsSize := FlcsSize;
  result.lcsCSType := FlcsCSType;
  result.lcsIntent := FlcsIntent;
  result.lcsGammaRed := FlcsGammaRed;
  result.lcsGammaGreen := FlcsGammaGreen;
  result.lcsGammaBlue := FlcsGammaBlue;
end;

constructor tagLOGCOLORSPACEWWrapper.Create(ARecord: tagLOGCOLORSPACEW);
begin
  inherited Create;
  FlcsSignature := ARecord.lcsSignature;
  FlcsVersion := ARecord.lcsVersion;
  FlcsSize := ARecord.lcsSize;
  FlcsCSType := ARecord.lcsCSType;
  FlcsIntent := ARecord.lcsIntent;
  FlcsGammaRed := ARecord.lcsGammaRed;
  FlcsGammaGreen := ARecord.lcsGammaGreen;
  FlcsGammaBlue := ARecord.lcsGammaBlue;
end;

function tagLOGCOLORSPACEWWrapper.ObjToRec: tagLOGCOLORSPACEW;
begin
  result.lcsSignature := FlcsSignature;
  result.lcsVersion := FlcsVersion;
  result.lcsSize := FlcsSize;
  result.lcsCSType := FlcsCSType;
  result.lcsIntent := FlcsIntent;
  result.lcsGammaRed := FlcsGammaRed;
  result.lcsGammaGreen := FlcsGammaGreen;
  result.lcsGammaBlue := FlcsGammaBlue;
end;

constructor tagBITMAPCOREHEADERWrapper.Create(ARecord: tagBITMAPCOREHEADER);
begin
  inherited Create;
  FbcSize := ARecord.bcSize;
  FbcWidth := ARecord.bcWidth;
  FbcHeight := ARecord.bcHeight;
  FbcPlanes := ARecord.bcPlanes;
  FbcBitCount := ARecord.bcBitCount;
end;

function tagBITMAPCOREHEADERWrapper.ObjToRec: tagBITMAPCOREHEADER;
begin
  result.bcSize := FbcSize;
  result.bcWidth := FbcWidth;
  result.bcHeight := FbcHeight;
  result.bcPlanes := FbcPlanes;
  result.bcBitCount := FbcBitCount;
end;

constructor tagBITMAPINFOHEADERWrapper.Create(ARecord: tagBITMAPINFOHEADER);
begin
  inherited Create;
  FbiSize := ARecord.biSize;
  FbiWidth := ARecord.biWidth;
  FbiHeight := ARecord.biHeight;
  FbiPlanes := ARecord.biPlanes;
  FbiBitCount := ARecord.biBitCount;
  FbiCompression := ARecord.biCompression;
  FbiSizeImage := ARecord.biSizeImage;
  FbiXPelsPerMeter := ARecord.biXPelsPerMeter;
  FbiYPelsPerMeter := ARecord.biYPelsPerMeter;
  FbiClrUsed := ARecord.biClrUsed;
  FbiClrImportant := ARecord.biClrImportant;
end;

function tagBITMAPINFOHEADERWrapper.ObjToRec: tagBITMAPINFOHEADER;
begin
  result.biSize := FbiSize;
  result.biWidth := FbiWidth;
  result.biHeight := FbiHeight;
  result.biPlanes := FbiPlanes;
  result.biBitCount := FbiBitCount;
  result.biCompression := FbiCompression;
  result.biSizeImage := FbiSizeImage;
  result.biXPelsPerMeter := FbiXPelsPerMeter;
  result.biYPelsPerMeter := FbiYPelsPerMeter;
  result.biClrUsed := FbiClrUsed;
  result.biClrImportant := FbiClrImportant;
end;

constructor BITMAPV4HEADERWrapper.Create(ARecord: BITMAPV4HEADER);
begin
  inherited Create;
  FbV4Size := ARecord.bV4Size;
  FbV4Width := ARecord.bV4Width;
  FbV4Height := ARecord.bV4Height;
  FbV4Planes := ARecord.bV4Planes;
  FbV4BitCount := ARecord.bV4BitCount;
  FbV4V4Compression := ARecord.bV4V4Compression;
  FbV4SizeImage := ARecord.bV4SizeImage;
  FbV4XPelsPerMeter := ARecord.bV4XPelsPerMeter;
  FbV4YPelsPerMeter := ARecord.bV4YPelsPerMeter;
  FbV4ClrUsed := ARecord.bV4ClrUsed;
  FbV4ClrImportant := ARecord.bV4ClrImportant;
  FbV4RedMask := ARecord.bV4RedMask;
  FbV4GreenMask := ARecord.bV4GreenMask;
  FbV4BlueMask := ARecord.bV4BlueMask;
  FbV4AlphaMask := ARecord.bV4AlphaMask;
  FbV4CSType := ARecord.bV4CSType;
  FbV4GammaRed := ARecord.bV4GammaRed;
  FbV4GammaGreen := ARecord.bV4GammaGreen;
  FbV4GammaBlue := ARecord.bV4GammaBlue;
end;

function BITMAPV4HEADERWrapper.ObjToRec: BITMAPV4HEADER;
begin
  result.bV4Size := FbV4Size;
  result.bV4Width := FbV4Width;
  result.bV4Height := FbV4Height;
  result.bV4Planes := FbV4Planes;
  result.bV4BitCount := FbV4BitCount;
  result.bV4V4Compression := FbV4V4Compression;
  result.bV4SizeImage := FbV4SizeImage;
  result.bV4XPelsPerMeter := FbV4XPelsPerMeter;
  result.bV4YPelsPerMeter := FbV4YPelsPerMeter;
  result.bV4ClrUsed := FbV4ClrUsed;
  result.bV4ClrImportant := FbV4ClrImportant;
  result.bV4RedMask := FbV4RedMask;
  result.bV4GreenMask := FbV4GreenMask;
  result.bV4BlueMask := FbV4BlueMask;
  result.bV4AlphaMask := FbV4AlphaMask;
  result.bV4CSType := FbV4CSType;
  result.bV4GammaRed := FbV4GammaRed;
  result.bV4GammaGreen := FbV4GammaGreen;
  result.bV4GammaBlue := FbV4GammaBlue;
end;

constructor BITMAPV5HEADERWrapper.Create(ARecord: BITMAPV5HEADER);
begin
  inherited Create;
  FbV5Size := ARecord.bV5Size;
  FbV5Width := ARecord.bV5Width;
  FbV5Height := ARecord.bV5Height;
  FbV5Planes := ARecord.bV5Planes;
  FbV5BitCount := ARecord.bV5BitCount;
  FbV5Compression := ARecord.bV5Compression;
  FbV5SizeImage := ARecord.bV5SizeImage;
  FbV5XPelsPerMeter := ARecord.bV5XPelsPerMeter;
  FbV5YPelsPerMeter := ARecord.bV5YPelsPerMeter;
  FbV5ClrUsed := ARecord.bV5ClrUsed;
  FbV5ClrImportant := ARecord.bV5ClrImportant;
  FbV5RedMask := ARecord.bV5RedMask;
  FbV5GreenMask := ARecord.bV5GreenMask;
  FbV5BlueMask := ARecord.bV5BlueMask;
  FbV5AlphaMask := ARecord.bV5AlphaMask;
  FbV5CSType := ARecord.bV5CSType;
  FbV5GammaRed := ARecord.bV5GammaRed;
  FbV5GammaGreen := ARecord.bV5GammaGreen;
  FbV5GammaBlue := ARecord.bV5GammaBlue;
  FbV5Intent := ARecord.bV5Intent;
  FbV5ProfileData := ARecord.bV5ProfileData;
  FbV5ProfileSize := ARecord.bV5ProfileSize;
  FbV5Reserved := ARecord.bV5Reserved;
end;

function BITMAPV5HEADERWrapper.ObjToRec: BITMAPV5HEADER;
begin
  result.bV5Size := FbV5Size;
  result.bV5Width := FbV5Width;
  result.bV5Height := FbV5Height;
  result.bV5Planes := FbV5Planes;
  result.bV5BitCount := FbV5BitCount;
  result.bV5Compression := FbV5Compression;
  result.bV5SizeImage := FbV5SizeImage;
  result.bV5XPelsPerMeter := FbV5XPelsPerMeter;
  result.bV5YPelsPerMeter := FbV5YPelsPerMeter;
  result.bV5ClrUsed := FbV5ClrUsed;
  result.bV5ClrImportant := FbV5ClrImportant;
  result.bV5RedMask := FbV5RedMask;
  result.bV5GreenMask := FbV5GreenMask;
  result.bV5BlueMask := FbV5BlueMask;
  result.bV5AlphaMask := FbV5AlphaMask;
  result.bV5CSType := FbV5CSType;
  result.bV5GammaRed := FbV5GammaRed;
  result.bV5GammaGreen := FbV5GammaGreen;
  result.bV5GammaBlue := FbV5GammaBlue;
  result.bV5Intent := FbV5Intent;
  result.bV5ProfileData := FbV5ProfileData;
  result.bV5ProfileSize := FbV5ProfileSize;
  result.bV5Reserved := FbV5Reserved;
end;

constructor tagBITMAPINFOWrapper.Create(ARecord: tagBITMAPINFO);
begin
  inherited Create;
end;

function tagBITMAPINFOWrapper.ObjToRec: tagBITMAPINFO;
begin
end;

constructor tagBITMAPCOREINFOWrapper.Create(ARecord: tagBITMAPCOREINFO);
begin
  inherited Create;
end;

function tagBITMAPCOREINFOWrapper.ObjToRec: tagBITMAPCOREINFO;
begin
end;

constructor tagBITMAPFILEHEADERWrapper.Create(ARecord: tagBITMAPFILEHEADER);
begin
  inherited Create;
  FbfType := ARecord.bfType;
  FbfSize := ARecord.bfSize;
  FbfReserved1 := ARecord.bfReserved1;
  FbfReserved2 := ARecord.bfReserved2;
  FbfOffBits := ARecord.bfOffBits;
end;

function tagBITMAPFILEHEADERWrapper.ObjToRec: tagBITMAPFILEHEADER;
begin
  result.bfType := FbfType;
  result.bfSize := FbfSize;
  result.bfReserved1 := FbfReserved1;
  result.bfReserved2 := FbfReserved2;
  result.bfOffBits := FbfOffBits;
end;

constructor tagFONTSIGNATUREWrapper.Create(ARecord: tagFONTSIGNATURE);
begin
  inherited Create;
end;

function tagFONTSIGNATUREWrapper.ObjToRec: tagFONTSIGNATURE;
begin
end;

constructor tagCHARSETINFOWrapper.Create(ARecord: tagCHARSETINFO);
begin
  inherited Create;
  FciCharset := ARecord.ciCharset;
  FciACP := ARecord.ciACP;
end;

function tagCHARSETINFOWrapper.ObjToRec: tagCHARSETINFO;
begin
  result.ciCharset := FciCharset;
  result.ciACP := FciACP;
end;

constructor tagLOCALESIGNATUREWrapper.Create(ARecord: tagLOCALESIGNATURE);
begin
  inherited Create;
end;

function tagLOCALESIGNATUREWrapper.ObjToRec: tagLOCALESIGNATURE;
begin
end;

constructor tagHANDLETABLEWrapper.Create(ARecord: tagHANDLETABLE);
begin
  inherited Create;
end;

function tagHANDLETABLEWrapper.ObjToRec: tagHANDLETABLE;
begin
end;

constructor tagMETARECORDWrapper.Create(ARecord: tagMETARECORD);
begin
  inherited Create;
  FrdSize := ARecord.rdSize;
  FrdFunction := ARecord.rdFunction;
end;

function tagMETARECORDWrapper.ObjToRec: tagMETARECORD;
begin
  result.rdSize := FrdSize;
  result.rdFunction := FrdFunction;
end;

constructor tagMETAFILEPICTWrapper.Create(ARecord: tagMETAFILEPICT);
begin
  inherited Create;
  Fmm := ARecord.mm;
  FxExt := ARecord.xExt;
  FyExt := ARecord.yExt;
  FhMF := ARecord.hMF;
end;

function tagMETAFILEPICTWrapper.ObjToRec: tagMETAFILEPICT;
begin
  result.mm := Fmm;
  result.xExt := FxExt;
  result.yExt := FyExt;
  result.hMF := FhMF;
end;

constructor tagMETAHEADERWrapper.Create(ARecord: tagMETAHEADER);
begin
  inherited Create;
  FmtType := ARecord.mtType;
  FmtHeaderSize := ARecord.mtHeaderSize;
  FmtVersion := ARecord.mtVersion;
  FmtSize := ARecord.mtSize;
  FmtNoObjects := ARecord.mtNoObjects;
  FmtMaxRecord := ARecord.mtMaxRecord;
  FmtNoParameters := ARecord.mtNoParameters;
end;

function tagMETAHEADERWrapper.ObjToRec: tagMETAHEADER;
begin
  result.mtType := FmtType;
  result.mtHeaderSize := FmtHeaderSize;
  result.mtVersion := FmtVersion;
  result.mtSize := FmtSize;
  result.mtNoObjects := FmtNoObjects;
  result.mtMaxRecord := FmtMaxRecord;
  result.mtNoParameters := FmtNoParameters;
end;

constructor tagENHMETARECORDWrapper.Create(ARecord: tagENHMETARECORD);
begin
  inherited Create;
  FiType := ARecord.iType;
  FnSize := ARecord.nSize;
end;

function tagENHMETARECORDWrapper.ObjToRec: tagENHMETARECORD;
begin
  result.iType := FiType;
  result.nSize := FnSize;
end;

constructor tagENHMETAHEADERWrapper.Create(ARecord: tagENHMETAHEADER);
begin
  inherited Create;
  FiType := ARecord.iType;
  FnSize := ARecord.nSize;
  FdSignature := ARecord.dSignature;
  FnVersion := ARecord.nVersion;
  FnBytes := ARecord.nBytes;
  FnRecords := ARecord.nRecords;
  FnHandles := ARecord.nHandles;
  FsReserved := ARecord.sReserved;
  FnDescription := ARecord.nDescription;
  FoffDescription := ARecord.offDescription;
  FnPalEntries := ARecord.nPalEntries;
  FcbPixelFormat := ARecord.cbPixelFormat;
  FoffPixelFormat := ARecord.offPixelFormat;
  FbOpenGL := ARecord.bOpenGL;
end;

function tagENHMETAHEADERWrapper.ObjToRec: tagENHMETAHEADER;
begin
  result.iType := FiType;
  result.nSize := FnSize;
  result.dSignature := FdSignature;
  result.nVersion := FnVersion;
  result.nBytes := FnBytes;
  result.nRecords := FnRecords;
  result.nHandles := FnHandles;
  result.sReserved := FsReserved;
  result.nDescription := FnDescription;
  result.offDescription := FoffDescription;
  result.nPalEntries := FnPalEntries;
  result.cbPixelFormat := FcbPixelFormat;
  result.offPixelFormat := FoffPixelFormat;
  result.bOpenGL := FbOpenGL;
end;

constructor tagTEXTMETRICAWrapper.Create(ARecord: tagTEXTMETRICA);
begin
  inherited Create;
  FtmHeight := ARecord.tmHeight;
  FtmAscent := ARecord.tmAscent;
  FtmDescent := ARecord.tmDescent;
  FtmInternalLeading := ARecord.tmInternalLeading;
  FtmExternalLeading := ARecord.tmExternalLeading;
  FtmAveCharWidth := ARecord.tmAveCharWidth;
  FtmMaxCharWidth := ARecord.tmMaxCharWidth;
  FtmWeight := ARecord.tmWeight;
  FtmOverhang := ARecord.tmOverhang;
  FtmDigitizedAspectX := ARecord.tmDigitizedAspectX;
  FtmDigitizedAspectY := ARecord.tmDigitizedAspectY;
  FtmFirstChar := ARecord.tmFirstChar;
  FtmLastChar := ARecord.tmLastChar;
  FtmDefaultChar := ARecord.tmDefaultChar;
  FtmBreakChar := ARecord.tmBreakChar;
  FtmItalic := ARecord.tmItalic;
  FtmUnderlined := ARecord.tmUnderlined;
  FtmStruckOut := ARecord.tmStruckOut;
  FtmPitchAndFamily := ARecord.tmPitchAndFamily;
  FtmCharSet := ARecord.tmCharSet;
end;

function tagTEXTMETRICAWrapper.ObjToRec: tagTEXTMETRICA;
begin
  result.tmHeight := FtmHeight;
  result.tmAscent := FtmAscent;
  result.tmDescent := FtmDescent;
  result.tmInternalLeading := FtmInternalLeading;
  result.tmExternalLeading := FtmExternalLeading;
  result.tmAveCharWidth := FtmAveCharWidth;
  result.tmMaxCharWidth := FtmMaxCharWidth;
  result.tmWeight := FtmWeight;
  result.tmOverhang := FtmOverhang;
  result.tmDigitizedAspectX := FtmDigitizedAspectX;
  result.tmDigitizedAspectY := FtmDigitizedAspectY;
  result.tmFirstChar := FtmFirstChar;
  result.tmLastChar := FtmLastChar;
  result.tmDefaultChar := FtmDefaultChar;
  result.tmBreakChar := FtmBreakChar;
  result.tmItalic := FtmItalic;
  result.tmUnderlined := FtmUnderlined;
  result.tmStruckOut := FtmStruckOut;
  result.tmPitchAndFamily := FtmPitchAndFamily;
  result.tmCharSet := FtmCharSet;
end;

constructor tagTEXTMETRICWWrapper.Create(ARecord: tagTEXTMETRICW);
begin
  inherited Create;
  FtmHeight := ARecord.tmHeight;
  FtmAscent := ARecord.tmAscent;
  FtmDescent := ARecord.tmDescent;
  FtmInternalLeading := ARecord.tmInternalLeading;
  FtmExternalLeading := ARecord.tmExternalLeading;
  FtmAveCharWidth := ARecord.tmAveCharWidth;
  FtmMaxCharWidth := ARecord.tmMaxCharWidth;
  FtmWeight := ARecord.tmWeight;
  FtmOverhang := ARecord.tmOverhang;
  FtmDigitizedAspectX := ARecord.tmDigitizedAspectX;
  FtmDigitizedAspectY := ARecord.tmDigitizedAspectY;
  FtmItalic := ARecord.tmItalic;
  FtmUnderlined := ARecord.tmUnderlined;
  FtmStruckOut := ARecord.tmStruckOut;
  FtmPitchAndFamily := ARecord.tmPitchAndFamily;
  FtmCharSet := ARecord.tmCharSet;
end;

function tagTEXTMETRICWWrapper.ObjToRec: tagTEXTMETRICW;
begin
  result.tmHeight := FtmHeight;
  result.tmAscent := FtmAscent;
  result.tmDescent := FtmDescent;
  result.tmInternalLeading := FtmInternalLeading;
  result.tmExternalLeading := FtmExternalLeading;
  result.tmAveCharWidth := FtmAveCharWidth;
  result.tmMaxCharWidth := FtmMaxCharWidth;
  result.tmWeight := FtmWeight;
  result.tmOverhang := FtmOverhang;
  result.tmDigitizedAspectX := FtmDigitizedAspectX;
  result.tmDigitizedAspectY := FtmDigitizedAspectY;
  result.tmItalic := FtmItalic;
  result.tmUnderlined := FtmUnderlined;
  result.tmStruckOut := FtmStruckOut;
  result.tmPitchAndFamily := FtmPitchAndFamily;
  result.tmCharSet := FtmCharSet;
end;

constructor tagNEWTEXTMETRICAWrapper.Create(ARecord: tagNEWTEXTMETRICA);
begin
  inherited Create;
  FtmHeight := ARecord.tmHeight;
  FtmAscent := ARecord.tmAscent;
  FtmDescent := ARecord.tmDescent;
  FtmInternalLeading := ARecord.tmInternalLeading;
  FtmExternalLeading := ARecord.tmExternalLeading;
  FtmAveCharWidth := ARecord.tmAveCharWidth;
  FtmMaxCharWidth := ARecord.tmMaxCharWidth;
  FtmWeight := ARecord.tmWeight;
  FtmOverhang := ARecord.tmOverhang;
  FtmDigitizedAspectX := ARecord.tmDigitizedAspectX;
  FtmDigitizedAspectY := ARecord.tmDigitizedAspectY;
  FtmFirstChar := ARecord.tmFirstChar;
  FtmLastChar := ARecord.tmLastChar;
  FtmDefaultChar := ARecord.tmDefaultChar;
  FtmBreakChar := ARecord.tmBreakChar;
  FtmItalic := ARecord.tmItalic;
  FtmUnderlined := ARecord.tmUnderlined;
  FtmStruckOut := ARecord.tmStruckOut;
  FtmPitchAndFamily := ARecord.tmPitchAndFamily;
  FtmCharSet := ARecord.tmCharSet;
  FntmFlags := ARecord.ntmFlags;
  FntmSizeEM := ARecord.ntmSizeEM;
  FntmCellHeight := ARecord.ntmCellHeight;
  FntmAvgWidth := ARecord.ntmAvgWidth;
end;

function tagNEWTEXTMETRICAWrapper.ObjToRec: tagNEWTEXTMETRICA;
begin
  result.tmHeight := FtmHeight;
  result.tmAscent := FtmAscent;
  result.tmDescent := FtmDescent;
  result.tmInternalLeading := FtmInternalLeading;
  result.tmExternalLeading := FtmExternalLeading;
  result.tmAveCharWidth := FtmAveCharWidth;
  result.tmMaxCharWidth := FtmMaxCharWidth;
  result.tmWeight := FtmWeight;
  result.tmOverhang := FtmOverhang;
  result.tmDigitizedAspectX := FtmDigitizedAspectX;
  result.tmDigitizedAspectY := FtmDigitizedAspectY;
  result.tmFirstChar := FtmFirstChar;
  result.tmLastChar := FtmLastChar;
  result.tmDefaultChar := FtmDefaultChar;
  result.tmBreakChar := FtmBreakChar;
  result.tmItalic := FtmItalic;
  result.tmUnderlined := FtmUnderlined;
  result.tmStruckOut := FtmStruckOut;
  result.tmPitchAndFamily := FtmPitchAndFamily;
  result.tmCharSet := FtmCharSet;
  result.ntmFlags := FntmFlags;
  result.ntmSizeEM := FntmSizeEM;
  result.ntmCellHeight := FntmCellHeight;
  result.ntmAvgWidth := FntmAvgWidth;
end;

constructor tagNEWTEXTMETRICWWrapper.Create(ARecord: tagNEWTEXTMETRICW);
begin
  inherited Create;
  FtmHeight := ARecord.tmHeight;
  FtmAscent := ARecord.tmAscent;
  FtmDescent := ARecord.tmDescent;
  FtmInternalLeading := ARecord.tmInternalLeading;
  FtmExternalLeading := ARecord.tmExternalLeading;
  FtmAveCharWidth := ARecord.tmAveCharWidth;
  FtmMaxCharWidth := ARecord.tmMaxCharWidth;
  FtmWeight := ARecord.tmWeight;
  FtmOverhang := ARecord.tmOverhang;
  FtmDigitizedAspectX := ARecord.tmDigitizedAspectX;
  FtmDigitizedAspectY := ARecord.tmDigitizedAspectY;
  FtmItalic := ARecord.tmItalic;
  FtmUnderlined := ARecord.tmUnderlined;
  FtmStruckOut := ARecord.tmStruckOut;
  FtmPitchAndFamily := ARecord.tmPitchAndFamily;
  FtmCharSet := ARecord.tmCharSet;
  FntmFlags := ARecord.ntmFlags;
  FntmSizeEM := ARecord.ntmSizeEM;
  FntmCellHeight := ARecord.ntmCellHeight;
  FntmAvgWidth := ARecord.ntmAvgWidth;
end;

function tagNEWTEXTMETRICWWrapper.ObjToRec: tagNEWTEXTMETRICW;
begin
  result.tmHeight := FtmHeight;
  result.tmAscent := FtmAscent;
  result.tmDescent := FtmDescent;
  result.tmInternalLeading := FtmInternalLeading;
  result.tmExternalLeading := FtmExternalLeading;
  result.tmAveCharWidth := FtmAveCharWidth;
  result.tmMaxCharWidth := FtmMaxCharWidth;
  result.tmWeight := FtmWeight;
  result.tmOverhang := FtmOverhang;
  result.tmDigitizedAspectX := FtmDigitizedAspectX;
  result.tmDigitizedAspectY := FtmDigitizedAspectY;
  result.tmItalic := FtmItalic;
  result.tmUnderlined := FtmUnderlined;
  result.tmStruckOut := FtmStruckOut;
  result.tmPitchAndFamily := FtmPitchAndFamily;
  result.tmCharSet := FtmCharSet;
  result.ntmFlags := FntmFlags;
  result.ntmSizeEM := FntmSizeEM;
  result.ntmCellHeight := FntmCellHeight;
  result.ntmAvgWidth := FntmAvgWidth;
end;

constructor tagNEWTEXTMETRICEXAWrapper.Create(ARecord: tagNEWTEXTMETRICEXA);
begin
  inherited Create;
end;

function tagNEWTEXTMETRICEXAWrapper.ObjToRec: tagNEWTEXTMETRICEXA;
begin
end;

constructor tagNEWTEXTMETRICEXWWrapper.Create(ARecord: tagNEWTEXTMETRICEXW);
begin
  inherited Create;
end;

function tagNEWTEXTMETRICEXWWrapper.ObjToRec: tagNEWTEXTMETRICEXW;
begin
end;

constructor tagPELARRAYWrapper.Create(ARecord: tagPELARRAY);
begin
  inherited Create;
  FpaXCount := ARecord.paXCount;
  FpaYCount := ARecord.paYCount;
  FpaXExt := ARecord.paXExt;
  FpaYExt := ARecord.paYExt;
  FpaRGBs := ARecord.paRGBs;
end;

function tagPELARRAYWrapper.ObjToRec: tagPELARRAY;
begin
  result.paXCount := FpaXCount;
  result.paYCount := FpaYCount;
  result.paXExt := FpaXExt;
  result.paYExt := FpaYExt;
  result.paRGBs := FpaRGBs;
end;

constructor tagLOGBRUSHWrapper.Create(ARecord: tagLOGBRUSH);
begin
  inherited Create;
  FlbStyle := ARecord.lbStyle;
  FlbColor := ARecord.lbColor;
  FlbHatch := ARecord.lbHatch;
end;

function tagLOGBRUSHWrapper.ObjToRec: tagLOGBRUSH;
begin
  result.lbStyle := FlbStyle;
  result.lbColor := FlbColor;
  result.lbHatch := FlbHatch;
end;

constructor tagLOGPENWrapper.Create(ARecord: tagLOGPEN);
begin
  inherited Create;
  FlopnStyle := ARecord.lopnStyle;
  FlopnColor := ARecord.lopnColor;
end;

function tagLOGPENWrapper.ObjToRec: tagLOGPEN;
begin
  result.lopnStyle := FlopnStyle;
  result.lopnColor := FlopnColor;
end;

constructor tagEXTLOGPENWrapper.Create(ARecord: tagEXTLOGPEN);
begin
  inherited Create;
  FelpPenStyle := ARecord.elpPenStyle;
  FelpWidth := ARecord.elpWidth;
  FelpBrushStyle := ARecord.elpBrushStyle;
  FelpColor := ARecord.elpColor;
  FelpHatch := ARecord.elpHatch;
  FelpNumEntries := ARecord.elpNumEntries;
end;

function tagEXTLOGPENWrapper.ObjToRec: tagEXTLOGPEN;
begin
  result.elpPenStyle := FelpPenStyle;
  result.elpWidth := FelpWidth;
  result.elpBrushStyle := FelpBrushStyle;
  result.elpColor := FelpColor;
  result.elpHatch := FelpHatch;
  result.elpNumEntries := FelpNumEntries;
end;

constructor tagPALETTEENTRYWrapper.Create(ARecord: tagPALETTEENTRY);
begin
  inherited Create;
  FpeRed := ARecord.peRed;
  FpeGreen := ARecord.peGreen;
  FpeBlue := ARecord.peBlue;
  FpeFlags := ARecord.peFlags;
end;

function tagPALETTEENTRYWrapper.ObjToRec: tagPALETTEENTRY;
begin
  result.peRed := FpeRed;
  result.peGreen := FpeGreen;
  result.peBlue := FpeBlue;
  result.peFlags := FpeFlags;
end;

constructor tagLOGPALETTEWrapper.Create(ARecord: tagLOGPALETTE);
begin
  inherited Create;
  FpalVersion := ARecord.palVersion;
  FpalNumEntries := ARecord.palNumEntries;
end;

function tagLOGPALETTEWrapper.ObjToRec: tagLOGPALETTE;
begin
  result.palVersion := FpalVersion;
  result.palNumEntries := FpalNumEntries;
end;

constructor TMaxLogPaletteWrapper.Create(ARecord: TMaxLogPalette);
begin
  inherited Create;
  FpalVersion := ARecord.palVersion;
  FpalNumEntries := ARecord.palNumEntries;
end;

function TMaxLogPaletteWrapper.ObjToRec: TMaxLogPalette;
begin
  result.palVersion := FpalVersion;
  result.palNumEntries := FpalNumEntries;
end;

constructor tagLOGFONTAWrapper.Create(ARecord: tagLOGFONTA);
begin
  inherited Create;
  FlfHeight := ARecord.lfHeight;
  FlfWidth := ARecord.lfWidth;
  FlfEscapement := ARecord.lfEscapement;
  FlfOrientation := ARecord.lfOrientation;
  FlfWeight := ARecord.lfWeight;
  FlfItalic := ARecord.lfItalic;
  FlfUnderline := ARecord.lfUnderline;
  FlfStrikeOut := ARecord.lfStrikeOut;
  FlfCharSet := ARecord.lfCharSet;
  FlfOutPrecision := ARecord.lfOutPrecision;
  FlfClipPrecision := ARecord.lfClipPrecision;
  FlfQuality := ARecord.lfQuality;
  FlfPitchAndFamily := ARecord.lfPitchAndFamily;
end;

function tagLOGFONTAWrapper.ObjToRec: tagLOGFONTA;
begin
  result.lfHeight := FlfHeight;
  result.lfWidth := FlfWidth;
  result.lfEscapement := FlfEscapement;
  result.lfOrientation := FlfOrientation;
  result.lfWeight := FlfWeight;
  result.lfItalic := FlfItalic;
  result.lfUnderline := FlfUnderline;
  result.lfStrikeOut := FlfStrikeOut;
  result.lfCharSet := FlfCharSet;
  result.lfOutPrecision := FlfOutPrecision;
  result.lfClipPrecision := FlfClipPrecision;
  result.lfQuality := FlfQuality;
  result.lfPitchAndFamily := FlfPitchAndFamily;
end;

constructor tagLOGFONTWWrapper.Create(ARecord: tagLOGFONTW);
begin
  inherited Create;
  FlfHeight := ARecord.lfHeight;
  FlfWidth := ARecord.lfWidth;
  FlfEscapement := ARecord.lfEscapement;
  FlfOrientation := ARecord.lfOrientation;
  FlfWeight := ARecord.lfWeight;
  FlfItalic := ARecord.lfItalic;
  FlfUnderline := ARecord.lfUnderline;
  FlfStrikeOut := ARecord.lfStrikeOut;
  FlfCharSet := ARecord.lfCharSet;
  FlfOutPrecision := ARecord.lfOutPrecision;
  FlfClipPrecision := ARecord.lfClipPrecision;
  FlfQuality := ARecord.lfQuality;
  FlfPitchAndFamily := ARecord.lfPitchAndFamily;
end;

function tagLOGFONTWWrapper.ObjToRec: tagLOGFONTW;
begin
  result.lfHeight := FlfHeight;
  result.lfWidth := FlfWidth;
  result.lfEscapement := FlfEscapement;
  result.lfOrientation := FlfOrientation;
  result.lfWeight := FlfWeight;
  result.lfItalic := FlfItalic;
  result.lfUnderline := FlfUnderline;
  result.lfStrikeOut := FlfStrikeOut;
  result.lfCharSet := FlfCharSet;
  result.lfOutPrecision := FlfOutPrecision;
  result.lfClipPrecision := FlfClipPrecision;
  result.lfQuality := FlfQuality;
  result.lfPitchAndFamily := FlfPitchAndFamily;
end;

constructor tagENUMLOGFONTAWrapper.Create(ARecord: tagENUMLOGFONTA);
begin
  inherited Create;
end;

function tagENUMLOGFONTAWrapper.ObjToRec: tagENUMLOGFONTA;
begin
end;

constructor tagENUMLOGFONTWWrapper.Create(ARecord: tagENUMLOGFONTW);
begin
  inherited Create;
end;

function tagENUMLOGFONTWWrapper.ObjToRec: tagENUMLOGFONTW;
begin
end;

constructor tagENUMLOGFONTEXAWrapper.Create(ARecord: tagENUMLOGFONTEXA);
begin
  inherited Create;
end;

function tagENUMLOGFONTEXAWrapper.ObjToRec: tagENUMLOGFONTEXA;
begin
end;

constructor tagENUMLOGFONTEXWWrapper.Create(ARecord: tagENUMLOGFONTEXW);
begin
  inherited Create;
end;

function tagENUMLOGFONTEXWWrapper.ObjToRec: tagENUMLOGFONTEXW;
begin
end;

constructor tagPANOSEWrapper.Create(ARecord: tagPANOSE);
begin
  inherited Create;
  FbFamilyType := ARecord.bFamilyType;
  FbSerifStyle := ARecord.bSerifStyle;
  FbWeight := ARecord.bWeight;
  FbProportion := ARecord.bProportion;
  FbContrast := ARecord.bContrast;
  FbStrokeVariation := ARecord.bStrokeVariation;
  FbArmStyle := ARecord.bArmStyle;
  FbLetterform := ARecord.bLetterform;
  FbMidline := ARecord.bMidline;
  FbXHeight := ARecord.bXHeight;
end;

function tagPANOSEWrapper.ObjToRec: tagPANOSE;
begin
  result.bFamilyType := FbFamilyType;
  result.bSerifStyle := FbSerifStyle;
  result.bWeight := FbWeight;
  result.bProportion := FbProportion;
  result.bContrast := FbContrast;
  result.bStrokeVariation := FbStrokeVariation;
  result.bArmStyle := FbArmStyle;
  result.bLetterform := FbLetterform;
  result.bMidline := FbMidline;
  result.bXHeight := FbXHeight;
end;

constructor tagEXTLOGFONTAWrapper.Create(ARecord: tagEXTLOGFONTA);
begin
  inherited Create;
  FelfVersion := ARecord.elfVersion;
  FelfStyleSize := ARecord.elfStyleSize;
  FelfMatch := ARecord.elfMatch;
  FelfReserved := ARecord.elfReserved;
  FelfCulture := ARecord.elfCulture;
end;

function tagEXTLOGFONTAWrapper.ObjToRec: tagEXTLOGFONTA;
begin
  result.elfVersion := FelfVersion;
  result.elfStyleSize := FelfStyleSize;
  result.elfMatch := FelfMatch;
  result.elfReserved := FelfReserved;
  result.elfCulture := FelfCulture;
end;

constructor tagEXTLOGFONTWWrapper.Create(ARecord: tagEXTLOGFONTW);
begin
  inherited Create;
  FelfVersion := ARecord.elfVersion;
  FelfStyleSize := ARecord.elfStyleSize;
  FelfMatch := ARecord.elfMatch;
  FelfReserved := ARecord.elfReserved;
  FelfCulture := ARecord.elfCulture;
end;

function tagEXTLOGFONTWWrapper.ObjToRec: tagEXTLOGFONTW;
begin
  result.elfVersion := FelfVersion;
  result.elfStyleSize := FelfStyleSize;
  result.elfMatch := FelfMatch;
  result.elfReserved := FelfReserved;
  result.elfCulture := FelfCulture;
end;

constructor _devicemodeAWrapper.Create(ARecord: _devicemodeA);
begin
  inherited Create;
  FdmSpecVersion := ARecord.dmSpecVersion;
  FdmDriverVersion := ARecord.dmDriverVersion;
  FdmSize := ARecord.dmSize;
  FdmDriverExtra := ARecord.dmDriverExtra;
  FdmFields := ARecord.dmFields;
  FdmOrientation := ARecord.dmOrientation;
  FdmPaperSize := ARecord.dmPaperSize;
  FdmPaperLength := ARecord.dmPaperLength;
  FdmPaperWidth := ARecord.dmPaperWidth;
  FdmScale := ARecord.dmScale;
  FdmCopies := ARecord.dmCopies;
  FdmDefaultSource := ARecord.dmDefaultSource;
  FdmPrintQuality := ARecord.dmPrintQuality;
  FdmColor := ARecord.dmColor;
  FdmDuplex := ARecord.dmDuplex;
  FdmYResolution := ARecord.dmYResolution;
  FdmTTOption := ARecord.dmTTOption;
  FdmCollate := ARecord.dmCollate;
  FdmLogPixels := ARecord.dmLogPixels;
  FdmBitsPerPel := ARecord.dmBitsPerPel;
  FdmPelsWidth := ARecord.dmPelsWidth;
  FdmPelsHeight := ARecord.dmPelsHeight;
  FdmDisplayFlags := ARecord.dmDisplayFlags;
  FdmDisplayFrequency := ARecord.dmDisplayFrequency;
  FdmICMMethod := ARecord.dmICMMethod;
  FdmICMIntent := ARecord.dmICMIntent;
  FdmMediaType := ARecord.dmMediaType;
  FdmDitherType := ARecord.dmDitherType;
  FdmICCManufacturer := ARecord.dmICCManufacturer;
  FdmICCModel := ARecord.dmICCModel;
  FdmPanningWidth := ARecord.dmPanningWidth;
  FdmPanningHeight := ARecord.dmPanningHeight;
end;

function _devicemodeAWrapper.ObjToRec: _devicemodeA;
begin
  result.dmSpecVersion := FdmSpecVersion;
  result.dmDriverVersion := FdmDriverVersion;
  result.dmSize := FdmSize;
  result.dmDriverExtra := FdmDriverExtra;
  result.dmFields := FdmFields;
  result.dmOrientation := FdmOrientation;
  result.dmPaperSize := FdmPaperSize;
  result.dmPaperLength := FdmPaperLength;
  result.dmPaperWidth := FdmPaperWidth;
  result.dmScale := FdmScale;
  result.dmCopies := FdmCopies;
  result.dmDefaultSource := FdmDefaultSource;
  result.dmPrintQuality := FdmPrintQuality;
  result.dmColor := FdmColor;
  result.dmDuplex := FdmDuplex;
  result.dmYResolution := FdmYResolution;
  result.dmTTOption := FdmTTOption;
  result.dmCollate := FdmCollate;
  result.dmLogPixels := FdmLogPixels;
  result.dmBitsPerPel := FdmBitsPerPel;
  result.dmPelsWidth := FdmPelsWidth;
  result.dmPelsHeight := FdmPelsHeight;
  result.dmDisplayFlags := FdmDisplayFlags;
  result.dmDisplayFrequency := FdmDisplayFrequency;
  result.dmICMMethod := FdmICMMethod;
  result.dmICMIntent := FdmICMIntent;
  result.dmMediaType := FdmMediaType;
  result.dmDitherType := FdmDitherType;
  result.dmICCManufacturer := FdmICCManufacturer;
  result.dmICCModel := FdmICCModel;
  result.dmPanningWidth := FdmPanningWidth;
  result.dmPanningHeight := FdmPanningHeight;
end;

constructor _devicemodeWWrapper.Create(ARecord: _devicemodeW);
begin
  inherited Create;
  FdmSpecVersion := ARecord.dmSpecVersion;
  FdmDriverVersion := ARecord.dmDriverVersion;
  FdmSize := ARecord.dmSize;
  FdmDriverExtra := ARecord.dmDriverExtra;
  FdmFields := ARecord.dmFields;
  FdmOrientation := ARecord.dmOrientation;
  FdmPaperSize := ARecord.dmPaperSize;
  FdmPaperLength := ARecord.dmPaperLength;
  FdmPaperWidth := ARecord.dmPaperWidth;
  FdmScale := ARecord.dmScale;
  FdmCopies := ARecord.dmCopies;
  FdmDefaultSource := ARecord.dmDefaultSource;
  FdmPrintQuality := ARecord.dmPrintQuality;
  FdmColor := ARecord.dmColor;
  FdmDuplex := ARecord.dmDuplex;
  FdmYResolution := ARecord.dmYResolution;
  FdmTTOption := ARecord.dmTTOption;
  FdmCollate := ARecord.dmCollate;
  FdmLogPixels := ARecord.dmLogPixels;
  FdmBitsPerPel := ARecord.dmBitsPerPel;
  FdmPelsWidth := ARecord.dmPelsWidth;
  FdmPelsHeight := ARecord.dmPelsHeight;
  FdmDisplayFlags := ARecord.dmDisplayFlags;
  FdmDisplayFrequency := ARecord.dmDisplayFrequency;
  FdmICMMethod := ARecord.dmICMMethod;
  FdmICMIntent := ARecord.dmICMIntent;
  FdmMediaType := ARecord.dmMediaType;
  FdmDitherType := ARecord.dmDitherType;
  FdmICCManufacturer := ARecord.dmICCManufacturer;
  FdmICCModel := ARecord.dmICCModel;
  FdmPanningWidth := ARecord.dmPanningWidth;
  FdmPanningHeight := ARecord.dmPanningHeight;
end;

function _devicemodeWWrapper.ObjToRec: _devicemodeW;
begin
  result.dmSpecVersion := FdmSpecVersion;
  result.dmDriverVersion := FdmDriverVersion;
  result.dmSize := FdmSize;
  result.dmDriverExtra := FdmDriverExtra;
  result.dmFields := FdmFields;
  result.dmOrientation := FdmOrientation;
  result.dmPaperSize := FdmPaperSize;
  result.dmPaperLength := FdmPaperLength;
  result.dmPaperWidth := FdmPaperWidth;
  result.dmScale := FdmScale;
  result.dmCopies := FdmCopies;
  result.dmDefaultSource := FdmDefaultSource;
  result.dmPrintQuality := FdmPrintQuality;
  result.dmColor := FdmColor;
  result.dmDuplex := FdmDuplex;
  result.dmYResolution := FdmYResolution;
  result.dmTTOption := FdmTTOption;
  result.dmCollate := FdmCollate;
  result.dmLogPixels := FdmLogPixels;
  result.dmBitsPerPel := FdmBitsPerPel;
  result.dmPelsWidth := FdmPelsWidth;
  result.dmPelsHeight := FdmPelsHeight;
  result.dmDisplayFlags := FdmDisplayFlags;
  result.dmDisplayFrequency := FdmDisplayFrequency;
  result.dmICMMethod := FdmICMMethod;
  result.dmICMIntent := FdmICMIntent;
  result.dmMediaType := FdmMediaType;
  result.dmDitherType := FdmDitherType;
  result.dmICCManufacturer := FdmICCManufacturer;
  result.dmICCModel := FdmICCModel;
  result.dmPanningWidth := FdmPanningWidth;
  result.dmPanningHeight := FdmPanningHeight;
end;

constructor _DISPLAY_DEVICEAWrapper.Create(ARecord: _DISPLAY_DEVICEA);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FStateFlags := ARecord.StateFlags;
end;

function _DISPLAY_DEVICEAWrapper.ObjToRec: _DISPLAY_DEVICEA;
begin
  result.cb := Fcb;
  result.StateFlags := FStateFlags;
end;

constructor _DISPLAY_DEVICEWWrapper.Create(ARecord: _DISPLAY_DEVICEW);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FStateFlags := ARecord.StateFlags;
end;

function _DISPLAY_DEVICEWWrapper.ObjToRec: _DISPLAY_DEVICEW;
begin
  result.cb := Fcb;
  result.StateFlags := FStateFlags;
end;

constructor _RGNDATAHEADERWrapper.Create(ARecord: _RGNDATAHEADER);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FiType := ARecord.iType;
  FnCount := ARecord.nCount;
  FnRgnSize := ARecord.nRgnSize;
end;

function _RGNDATAHEADERWrapper.ObjToRec: _RGNDATAHEADER;
begin
  result.dwSize := FdwSize;
  result.iType := FiType;
  result.nCount := FnCount;
  result.nRgnSize := FnRgnSize;
end;

constructor _RGNDATAWrapper.Create(ARecord: _RGNDATA);
begin
  inherited Create;
end;

function _RGNDATAWrapper.ObjToRec: _RGNDATA;
begin
end;

constructor _ABCWrapper.Create(ARecord: _ABC);
begin
  inherited Create;
  FabcA := ARecord.abcA;
  FabcB := ARecord.abcB;
  FabcC := ARecord.abcC;
end;

function _ABCWrapper.ObjToRec: _ABC;
begin
  result.abcA := FabcA;
  result.abcB := FabcB;
  result.abcC := FabcC;
end;

constructor _ABCFLOATWrapper.Create(ARecord: _ABCFLOAT);
begin
  inherited Create;
  FabcfA := ARecord.abcfA;
  FabcfB := ARecord.abcfB;
  FabcfC := ARecord.abcfC;
end;

function _ABCFLOATWrapper.ObjToRec: _ABCFLOAT;
begin
  result.abcfA := FabcfA;
  result.abcfB := FabcfB;
  result.abcfC := FabcfC;
end;

constructor _OUTLINETEXTMETRICAWrapper.Create(ARecord: _OUTLINETEXTMETRICA);
begin
  inherited Create;
  FotmSize := ARecord.otmSize;
  FotmFiller := ARecord.otmFiller;
  FotmfsSelection := ARecord.otmfsSelection;
  FotmfsType := ARecord.otmfsType;
  FotmsCharSlopeRise := ARecord.otmsCharSlopeRise;
  FotmsCharSlopeRun := ARecord.otmsCharSlopeRun;
  FotmItalicAngle := ARecord.otmItalicAngle;
  FotmEMSquare := ARecord.otmEMSquare;
  FotmAscent := ARecord.otmAscent;
  FotmDescent := ARecord.otmDescent;
  FotmLineGap := ARecord.otmLineGap;
  FotmsCapEmHeight := ARecord.otmsCapEmHeight;
  FotmsXHeight := ARecord.otmsXHeight;
  FotmMacAscent := ARecord.otmMacAscent;
  FotmMacDescent := ARecord.otmMacDescent;
  FotmMacLineGap := ARecord.otmMacLineGap;
  FotmusMinimumPPEM := ARecord.otmusMinimumPPEM;
  FotmsStrikeoutSize := ARecord.otmsStrikeoutSize;
  FotmsStrikeoutPosition := ARecord.otmsStrikeoutPosition;
  FotmsUnderscoreSize := ARecord.otmsUnderscoreSize;
  FotmsUnderscorePosition := ARecord.otmsUnderscorePosition;
end;

function _OUTLINETEXTMETRICAWrapper.ObjToRec: _OUTLINETEXTMETRICA;
begin
  result.otmSize := FotmSize;
  result.otmFiller := FotmFiller;
  result.otmfsSelection := FotmfsSelection;
  result.otmfsType := FotmfsType;
  result.otmsCharSlopeRise := FotmsCharSlopeRise;
  result.otmsCharSlopeRun := FotmsCharSlopeRun;
  result.otmItalicAngle := FotmItalicAngle;
  result.otmEMSquare := FotmEMSquare;
  result.otmAscent := FotmAscent;
  result.otmDescent := FotmDescent;
  result.otmLineGap := FotmLineGap;
  result.otmsCapEmHeight := FotmsCapEmHeight;
  result.otmsXHeight := FotmsXHeight;
  result.otmMacAscent := FotmMacAscent;
  result.otmMacDescent := FotmMacDescent;
  result.otmMacLineGap := FotmMacLineGap;
  result.otmusMinimumPPEM := FotmusMinimumPPEM;
  result.otmsStrikeoutSize := FotmsStrikeoutSize;
  result.otmsStrikeoutPosition := FotmsStrikeoutPosition;
  result.otmsUnderscoreSize := FotmsUnderscoreSize;
  result.otmsUnderscorePosition := FotmsUnderscorePosition;
end;

constructor _OUTLINETEXTMETRICWWrapper.Create(ARecord: _OUTLINETEXTMETRICW);
begin
  inherited Create;
  FotmSize := ARecord.otmSize;
  FotmFiller := ARecord.otmFiller;
  FotmfsSelection := ARecord.otmfsSelection;
  FotmfsType := ARecord.otmfsType;
  FotmsCharSlopeRise := ARecord.otmsCharSlopeRise;
  FotmsCharSlopeRun := ARecord.otmsCharSlopeRun;
  FotmItalicAngle := ARecord.otmItalicAngle;
  FotmEMSquare := ARecord.otmEMSquare;
  FotmAscent := ARecord.otmAscent;
  FotmDescent := ARecord.otmDescent;
  FotmLineGap := ARecord.otmLineGap;
  FotmsCapEmHeight := ARecord.otmsCapEmHeight;
  FotmsXHeight := ARecord.otmsXHeight;
  FotmMacAscent := ARecord.otmMacAscent;
  FotmMacDescent := ARecord.otmMacDescent;
  FotmMacLineGap := ARecord.otmMacLineGap;
  FotmusMinimumPPEM := ARecord.otmusMinimumPPEM;
  FotmsStrikeoutSize := ARecord.otmsStrikeoutSize;
  FotmsStrikeoutPosition := ARecord.otmsStrikeoutPosition;
  FotmsUnderscoreSize := ARecord.otmsUnderscoreSize;
  FotmsUnderscorePosition := ARecord.otmsUnderscorePosition;
end;

function _OUTLINETEXTMETRICWWrapper.ObjToRec: _OUTLINETEXTMETRICW;
begin
  result.otmSize := FotmSize;
  result.otmFiller := FotmFiller;
  result.otmfsSelection := FotmfsSelection;
  result.otmfsType := FotmfsType;
  result.otmsCharSlopeRise := FotmsCharSlopeRise;
  result.otmsCharSlopeRun := FotmsCharSlopeRun;
  result.otmItalicAngle := FotmItalicAngle;
  result.otmEMSquare := FotmEMSquare;
  result.otmAscent := FotmAscent;
  result.otmDescent := FotmDescent;
  result.otmLineGap := FotmLineGap;
  result.otmsCapEmHeight := FotmsCapEmHeight;
  result.otmsXHeight := FotmsXHeight;
  result.otmMacAscent := FotmMacAscent;
  result.otmMacDescent := FotmMacDescent;
  result.otmMacLineGap := FotmMacLineGap;
  result.otmusMinimumPPEM := FotmusMinimumPPEM;
  result.otmsStrikeoutSize := FotmsStrikeoutSize;
  result.otmsStrikeoutPosition := FotmsStrikeoutPosition;
  result.otmsUnderscoreSize := FotmsUnderscoreSize;
  result.otmsUnderscorePosition := FotmsUnderscorePosition;
end;

constructor tagPOLYTEXTAWrapper.Create(ARecord: tagPOLYTEXTA);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fn := ARecord.n;
  FuiFlags := ARecord.uiFlags;
end;

function tagPOLYTEXTAWrapper.ObjToRec: tagPOLYTEXTA;
begin
  result.x := Fx;
  result.y := Fy;
  result.n := Fn;
  result.uiFlags := FuiFlags;
end;

constructor tagPOLYTEXTWWrapper.Create(ARecord: tagPOLYTEXTW);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fn := ARecord.n;
  FuiFlags := ARecord.uiFlags;
end;

function tagPOLYTEXTWWrapper.ObjToRec: tagPOLYTEXTW;
begin
  result.x := Fx;
  result.y := Fy;
  result.n := Fn;
  result.uiFlags := FuiFlags;
end;

constructor _FIXEDWrapper.Create(ARecord: _FIXED);
begin
  inherited Create;
  Ffract := ARecord.fract;
  Fvalue := ARecord.value;
end;

function _FIXEDWrapper.ObjToRec: _FIXED;
begin
  result.fract := Ffract;
  result.value := Fvalue;
end;

constructor _MAT2Wrapper.Create(ARecord: _MAT2);
begin
  inherited Create;
end;

function _MAT2Wrapper.ObjToRec: _MAT2;
begin
end;

constructor _GLYPHMETRICSWrapper.Create(ARecord: _GLYPHMETRICS);
begin
  inherited Create;
  FgmBlackBoxX := ARecord.gmBlackBoxX;
  FgmBlackBoxY := ARecord.gmBlackBoxY;
  FgmCellIncX := ARecord.gmCellIncX;
  FgmCellIncY := ARecord.gmCellIncY;
end;

function _GLYPHMETRICSWrapper.ObjToRec: _GLYPHMETRICS;
begin
  result.gmBlackBoxX := FgmBlackBoxX;
  result.gmBlackBoxY := FgmBlackBoxY;
  result.gmCellIncX := FgmCellIncX;
  result.gmCellIncY := FgmCellIncY;
end;

constructor tagPOINTFXWrapper.Create(ARecord: tagPOINTFX);
begin
  inherited Create;
end;

function tagPOINTFXWrapper.ObjToRec: tagPOINTFX;
begin
end;

constructor tagTTPOLYCURVEWrapper.Create(ARecord: tagTTPOLYCURVE);
begin
  inherited Create;
  FwType := ARecord.wType;
  Fcpfx := ARecord.cpfx;
end;

function tagTTPOLYCURVEWrapper.ObjToRec: tagTTPOLYCURVE;
begin
  result.wType := FwType;
  result.cpfx := Fcpfx;
end;

constructor tagTTPOLYGONHEADERWrapper.Create(ARecord: tagTTPOLYGONHEADER);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwType := ARecord.dwType;
end;

function tagTTPOLYGONHEADERWrapper.ObjToRec: tagTTPOLYGONHEADER;
begin
  result.cb := Fcb;
  result.dwType := FdwType;
end;

constructor tagGCP_RESULTSAWrapper.Create(ARecord: tagGCP_RESULTSA);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FnGlyphs := ARecord.nGlyphs;
  FnMaxFit := ARecord.nMaxFit;
end;

function tagGCP_RESULTSAWrapper.ObjToRec: tagGCP_RESULTSA;
begin
  result.lStructSize := FlStructSize;
  result.nGlyphs := FnGlyphs;
  result.nMaxFit := FnMaxFit;
end;

constructor tagGCP_RESULTSWWrapper.Create(ARecord: tagGCP_RESULTSW);
begin
  inherited Create;
  FlStructSize := ARecord.lStructSize;
  FnGlyphs := ARecord.nGlyphs;
  FnMaxFit := ARecord.nMaxFit;
end;

function tagGCP_RESULTSWWrapper.ObjToRec: tagGCP_RESULTSW;
begin
  result.lStructSize := FlStructSize;
  result.nGlyphs := FnGlyphs;
  result.nMaxFit := FnMaxFit;
end;

constructor _RASTERIZER_STATUSWrapper.Create(ARecord: _RASTERIZER_STATUS);
begin
  inherited Create;
  FnSize := ARecord.nSize;
  FwFlags := ARecord.wFlags;
  FnLanguageID := ARecord.nLanguageID;
end;

function _RASTERIZER_STATUSWrapper.ObjToRec: _RASTERIZER_STATUS;
begin
  result.nSize := FnSize;
  result.wFlags := FwFlags;
  result.nLanguageID := FnLanguageID;
end;

constructor tagPIXELFORMATDESCRIPTORWrapper.Create(ARecord: tagPIXELFORMATDESCRIPTOR);
begin
  inherited Create;
  FnSize := ARecord.nSize;
  FnVersion := ARecord.nVersion;
  FdwFlags := ARecord.dwFlags;
  FiPixelType := ARecord.iPixelType;
  FcColorBits := ARecord.cColorBits;
  FcRedBits := ARecord.cRedBits;
  FcRedShift := ARecord.cRedShift;
  FcGreenBits := ARecord.cGreenBits;
  FcGreenShift := ARecord.cGreenShift;
  FcBlueBits := ARecord.cBlueBits;
  FcBlueShift := ARecord.cBlueShift;
  FcAlphaBits := ARecord.cAlphaBits;
  FcAlphaShift := ARecord.cAlphaShift;
  FcAccumBits := ARecord.cAccumBits;
  FcAccumRedBits := ARecord.cAccumRedBits;
  FcAccumGreenBits := ARecord.cAccumGreenBits;
  FcAccumBlueBits := ARecord.cAccumBlueBits;
  FcAccumAlphaBits := ARecord.cAccumAlphaBits;
  FcDepthBits := ARecord.cDepthBits;
  FcStencilBits := ARecord.cStencilBits;
  FcAuxBuffers := ARecord.cAuxBuffers;
  FiLayerType := ARecord.iLayerType;
  FbReserved := ARecord.bReserved;
  FdwLayerMask := ARecord.dwLayerMask;
  FdwVisibleMask := ARecord.dwVisibleMask;
  FdwDamageMask := ARecord.dwDamageMask;
end;

function tagPIXELFORMATDESCRIPTORWrapper.ObjToRec: tagPIXELFORMATDESCRIPTOR;
begin
  result.nSize := FnSize;
  result.nVersion := FnVersion;
  result.dwFlags := FdwFlags;
  result.iPixelType := FiPixelType;
  result.cColorBits := FcColorBits;
  result.cRedBits := FcRedBits;
  result.cRedShift := FcRedShift;
  result.cGreenBits := FcGreenBits;
  result.cGreenShift := FcGreenShift;
  result.cBlueBits := FcBlueBits;
  result.cBlueShift := FcBlueShift;
  result.cAlphaBits := FcAlphaBits;
  result.cAlphaShift := FcAlphaShift;
  result.cAccumBits := FcAccumBits;
  result.cAccumRedBits := FcAccumRedBits;
  result.cAccumGreenBits := FcAccumGreenBits;
  result.cAccumBlueBits := FcAccumBlueBits;
  result.cAccumAlphaBits := FcAccumAlphaBits;
  result.cDepthBits := FcDepthBits;
  result.cStencilBits := FcStencilBits;
  result.cAuxBuffers := FcAuxBuffers;
  result.iLayerType := FiLayerType;
  result.bReserved := FbReserved;
  result.dwLayerMask := FdwLayerMask;
  result.dwVisibleMask := FdwVisibleMask;
  result.dwDamageMask := FdwDamageMask;
end;

constructor tagWCRANGEWrapper.Create(ARecord: tagWCRANGE);
begin
  inherited Create;
  FcGlyphs := ARecord.cGlyphs;
end;

function tagWCRANGEWrapper.ObjToRec: tagWCRANGE;
begin
  result.cGlyphs := FcGlyphs;
end;

constructor tagGLYPHSETWrapper.Create(ARecord: tagGLYPHSET);
begin
  inherited Create;
  FcbThis := ARecord.cbThis;
  FflAccel := ARecord.flAccel;
  FcGlyphsSupported := ARecord.cGlyphsSupported;
  FcRanges := ARecord.cRanges;
end;

function tagGLYPHSETWrapper.ObjToRec: tagGLYPHSET;
begin
  result.cbThis := FcbThis;
  result.flAccel := FflAccel;
  result.cGlyphsSupported := FcGlyphsSupported;
  result.cRanges := FcRanges;
end;

constructor tagDESIGNVECTORWrapper.Create(ARecord: tagDESIGNVECTOR);
begin
  inherited Create;
  FdvReserved := ARecord.dvReserved;
  FdvNumAxes := ARecord.dvNumAxes;
end;

function tagDESIGNVECTORWrapper.ObjToRec: tagDESIGNVECTOR;
begin
  result.dvReserved := FdvReserved;
  result.dvNumAxes := FdvNumAxes;
end;

constructor tagAXISINFOAWrapper.Create(ARecord: tagAXISINFOA);
begin
  inherited Create;
  FaxMinValue := ARecord.axMinValue;
  FaxMaxValue := ARecord.axMaxValue;
end;

function tagAXISINFOAWrapper.ObjToRec: tagAXISINFOA;
begin
  result.axMinValue := FaxMinValue;
  result.axMaxValue := FaxMaxValue;
end;

constructor tagAXISINFOWWrapper.Create(ARecord: tagAXISINFOW);
begin
  inherited Create;
  FaxMinValue := ARecord.axMinValue;
  FaxMaxValue := ARecord.axMaxValue;
end;

function tagAXISINFOWWrapper.ObjToRec: tagAXISINFOW;
begin
  result.axMinValue := FaxMinValue;
  result.axMaxValue := FaxMaxValue;
end;

constructor tagAXESLISTAWrapper.Create(ARecord: tagAXESLISTA);
begin
  inherited Create;
  FaxlReserved := ARecord.axlReserved;
  FaxlNumAxes := ARecord.axlNumAxes;
end;

function tagAXESLISTAWrapper.ObjToRec: tagAXESLISTA;
begin
  result.axlReserved := FaxlReserved;
  result.axlNumAxes := FaxlNumAxes;
end;

constructor tagAXESLISTWWrapper.Create(ARecord: tagAXESLISTW);
begin
  inherited Create;
  FaxlReserved := ARecord.axlReserved;
  FaxlNumAxes := ARecord.axlNumAxes;
end;

function tagAXESLISTWWrapper.ObjToRec: tagAXESLISTW;
begin
  result.axlReserved := FaxlReserved;
  result.axlNumAxes := FaxlNumAxes;
end;

constructor tagENUMLOGFONTEXDVAWrapper.Create(ARecord: tagENUMLOGFONTEXDVA);
begin
  inherited Create;
end;

function tagENUMLOGFONTEXDVAWrapper.ObjToRec: tagENUMLOGFONTEXDVA;
begin
end;

constructor tagENUMLOGFONTEXDVWWrapper.Create(ARecord: tagENUMLOGFONTEXDVW);
begin
  inherited Create;
end;

function tagENUMLOGFONTEXDVWWrapper.ObjToRec: tagENUMLOGFONTEXDVW;
begin
end;

constructor tagENUMTEXTMETRICAWrapper.Create(ARecord: tagENUMTEXTMETRICA);
begin
  inherited Create;
end;

function tagENUMTEXTMETRICAWrapper.ObjToRec: tagENUMTEXTMETRICA;
begin
end;

constructor tagENUMTEXTMETRICWWrapper.Create(ARecord: tagENUMTEXTMETRICW);
begin
  inherited Create;
end;

function tagENUMTEXTMETRICWWrapper.ObjToRec: tagENUMTEXTMETRICW;
begin
end;

constructor _TRIVERTEXWrapper.Create(ARecord: _TRIVERTEX);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
  FRed := ARecord.Red;
  FGreen := ARecord.Green;
  FBlue := ARecord.Blue;
  FAlpha := ARecord.Alpha;
end;

function _TRIVERTEXWrapper.ObjToRec: _TRIVERTEX;
begin
  result.x := Fx;
  result.y := Fy;
  result.Red := FRed;
  result.Green := FGreen;
  result.Blue := FBlue;
  result.Alpha := FAlpha;
end;

constructor _GRADIENT_TRIANGLEWrapper.Create(ARecord: _GRADIENT_TRIANGLE);
begin
  inherited Create;
  FVertex1 := ARecord.Vertex1;
  FVertex2 := ARecord.Vertex2;
  FVertex3 := ARecord.Vertex3;
end;

function _GRADIENT_TRIANGLEWrapper.ObjToRec: _GRADIENT_TRIANGLE;
begin
  result.Vertex1 := FVertex1;
  result.Vertex2 := FVertex2;
  result.Vertex3 := FVertex3;
end;

constructor _GRADIENT_RECTWrapper.Create(ARecord: _GRADIENT_RECT);
begin
  inherited Create;
  FUpperLeft := ARecord.UpperLeft;
  FLowerRight := ARecord.LowerRight;
end;

function _GRADIENT_RECTWrapper.ObjToRec: _GRADIENT_RECT;
begin
  result.UpperLeft := FUpperLeft;
  result.LowerRight := FLowerRight;
end;

constructor _BLENDFUNCTIONWrapper.Create(ARecord: _BLENDFUNCTION);
begin
  inherited Create;
  FBlendOp := ARecord.BlendOp;
  FBlendFlags := ARecord.BlendFlags;
  FSourceConstantAlpha := ARecord.SourceConstantAlpha;
  FAlphaFormat := ARecord.AlphaFormat;
end;

function _BLENDFUNCTIONWrapper.ObjToRec: _BLENDFUNCTION;
begin
  result.BlendOp := FBlendOp;
  result.BlendFlags := FBlendFlags;
  result.SourceConstantAlpha := FSourceConstantAlpha;
  result.AlphaFormat := FAlphaFormat;
end;

constructor tagDIBSECTIONWrapper.Create(ARecord: tagDIBSECTION);
begin
  inherited Create;
  FdshSection := ARecord.dshSection;
  FdsOffset := ARecord.dsOffset;
end;

function tagDIBSECTIONWrapper.ObjToRec: tagDIBSECTION;
begin
  result.dshSection := FdshSection;
  result.dsOffset := FdsOffset;
end;

constructor tagCOLORADJUSTMENTWrapper.Create(ARecord: tagCOLORADJUSTMENT);
begin
  inherited Create;
  FcaSize := ARecord.caSize;
  FcaFlags := ARecord.caFlags;
  FcaIlluminantIndex := ARecord.caIlluminantIndex;
  FcaRedGamma := ARecord.caRedGamma;
  FcaGreenGamma := ARecord.caGreenGamma;
  FcaBlueGamma := ARecord.caBlueGamma;
  FcaReferenceBlack := ARecord.caReferenceBlack;
  FcaReferenceWhite := ARecord.caReferenceWhite;
  FcaContrast := ARecord.caContrast;
  FcaBrightness := ARecord.caBrightness;
  FcaColorfulness := ARecord.caColorfulness;
  FcaRedGreenTint := ARecord.caRedGreenTint;
end;

function tagCOLORADJUSTMENTWrapper.ObjToRec: tagCOLORADJUSTMENT;
begin
  result.caSize := FcaSize;
  result.caFlags := FcaFlags;
  result.caIlluminantIndex := FcaIlluminantIndex;
  result.caRedGamma := FcaRedGamma;
  result.caGreenGamma := FcaGreenGamma;
  result.caBlueGamma := FcaBlueGamma;
  result.caReferenceBlack := FcaReferenceBlack;
  result.caReferenceWhite := FcaReferenceWhite;
  result.caContrast := FcaContrast;
  result.caBrightness := FcaBrightness;
  result.caColorfulness := FcaColorfulness;
  result.caRedGreenTint := FcaRedGreenTint;
end;

constructor _DOCINFOAWrapper.Create(ARecord: _DOCINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfwType := ARecord.fwType;
end;

function _DOCINFOAWrapper.ObjToRec: _DOCINFOA;
begin
  result.cbSize := FcbSize;
  result.fwType := FfwType;
end;

constructor _DOCINFOWWrapper.Create(ARecord: _DOCINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfwType := ARecord.fwType;
end;

function _DOCINFOWWrapper.ObjToRec: _DOCINFOW;
begin
  result.cbSize := FcbSize;
  result.fwType := FfwType;
end;

constructor tagKERNINGPAIRWrapper.Create(ARecord: tagKERNINGPAIR);
begin
  inherited Create;
  FwFirst := ARecord.wFirst;
  FwSecond := ARecord.wSecond;
  FiKernAmount := ARecord.iKernAmount;
end;

function tagKERNINGPAIRWrapper.ObjToRec: tagKERNINGPAIR;
begin
  result.wFirst := FwFirst;
  result.wSecond := FwSecond;
  result.iKernAmount := FiKernAmount;
end;

constructor tagEMRWrapper.Create(ARecord: tagEMR);
begin
  inherited Create;
  FiType := ARecord.iType;
  FnSize := ARecord.nSize;
end;

function tagEMRWrapper.ObjToRec: tagEMR;
begin
  result.iType := FiType;
  result.nSize := FnSize;
end;

constructor tagEMRTEXTWrapper.Create(ARecord: tagEMRTEXT);
begin
  inherited Create;
  FnChars := ARecord.nChars;
  FoffString := ARecord.offString;
  FfOptions := ARecord.fOptions;
  FoffDx := ARecord.offDx;
end;

function tagEMRTEXTWrapper.ObjToRec: tagEMRTEXT;
begin
  result.nChars := FnChars;
  result.offString := FoffString;
  result.fOptions := FfOptions;
  result.offDx := FoffDx;
end;

constructor tagABORTPATHWrapper.Create(ARecord: tagABORTPATH);
begin
  inherited Create;
end;

function tagABORTPATHWrapper.ObjToRec: tagABORTPATH;
begin
end;

constructor tagEMRSELECTCLIPPATHWrapper.Create(ARecord: tagEMRSELECTCLIPPATH);
begin
  inherited Create;
  FiMode := ARecord.iMode;
end;

function tagEMRSELECTCLIPPATHWrapper.ObjToRec: tagEMRSELECTCLIPPATH;
begin
  result.iMode := FiMode;
end;

constructor tagEMRSETMITERLIMITWrapper.Create(ARecord: tagEMRSETMITERLIMIT);
begin
  inherited Create;
  FeMiterLimit := ARecord.eMiterLimit;
end;

function tagEMRSETMITERLIMITWrapper.ObjToRec: tagEMRSETMITERLIMIT;
begin
  result.eMiterLimit := FeMiterLimit;
end;

constructor tagEMRRESTOREDCWrapper.Create(ARecord: tagEMRRESTOREDC);
begin
  inherited Create;
  FiRelative := ARecord.iRelative;
end;

function tagEMRRESTOREDCWrapper.ObjToRec: tagEMRRESTOREDC;
begin
  result.iRelative := FiRelative;
end;

constructor tagEMRSETARCDIRECTIONWrapper.Create(ARecord: tagEMRSETARCDIRECTION);
begin
  inherited Create;
  FiArcDirection := ARecord.iArcDirection;
end;

function tagEMRSETARCDIRECTIONWrapper.ObjToRec: tagEMRSETARCDIRECTION;
begin
  result.iArcDirection := FiArcDirection;
end;

constructor tagEMRSETMAPPERFLAGSWrapper.Create(ARecord: tagEMRSETMAPPERFLAGS);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
end;

function tagEMRSETMAPPERFLAGSWrapper.ObjToRec: tagEMRSETMAPPERFLAGS;
begin
  result.dwFlags := FdwFlags;
end;

constructor tagEMRSETTEXTCOLORWrapper.Create(ARecord: tagEMRSETTEXTCOLOR);
begin
  inherited Create;
  FcrColor := ARecord.crColor;
end;

function tagEMRSETTEXTCOLORWrapper.ObjToRec: tagEMRSETTEXTCOLOR;
begin
  result.crColor := FcrColor;
end;

constructor tagEMRSELECTOBJECTWrapper.Create(ARecord: tagEMRSELECTOBJECT);
begin
  inherited Create;
  FihObject := ARecord.ihObject;
end;

function tagEMRSELECTOBJECTWrapper.ObjToRec: tagEMRSELECTOBJECT;
begin
  result.ihObject := FihObject;
end;

constructor tagEMRSETCOLORSPACEWrapper.Create(ARecord: tagEMRSETCOLORSPACE);
begin
  inherited Create;
  FihCS := ARecord.ihCS;
end;

function tagEMRSETCOLORSPACEWrapper.ObjToRec: tagEMRSETCOLORSPACE;
begin
  result.ihCS := FihCS;
end;

constructor tagEMRSELECTPALETTEWrapper.Create(ARecord: tagEMRSELECTPALETTE);
begin
  inherited Create;
  FihPal := ARecord.ihPal;
end;

function tagEMRSELECTPALETTEWrapper.ObjToRec: tagEMRSELECTPALETTE;
begin
  result.ihPal := FihPal;
end;

constructor tagEMRRESIZEPALETTEWrapper.Create(ARecord: tagEMRRESIZEPALETTE);
begin
  inherited Create;
  FihPal := ARecord.ihPal;
  FcEntries := ARecord.cEntries;
end;

function tagEMRRESIZEPALETTEWrapper.ObjToRec: tagEMRRESIZEPALETTE;
begin
  result.ihPal := FihPal;
  result.cEntries := FcEntries;
end;

constructor tagEMRSETPALETTEENTRIESWrapper.Create(ARecord: tagEMRSETPALETTEENTRIES);
begin
  inherited Create;
  FihPal := ARecord.ihPal;
  FiStart := ARecord.iStart;
  FcEntries := ARecord.cEntries;
end;

function tagEMRSETPALETTEENTRIESWrapper.ObjToRec: tagEMRSETPALETTEENTRIES;
begin
  result.ihPal := FihPal;
  result.iStart := FiStart;
  result.cEntries := FcEntries;
end;

constructor tagEMRSETCOLORADJUSTMENTWrapper.Create(ARecord: tagEMRSETCOLORADJUSTMENT);
begin
  inherited Create;
end;

function tagEMRSETCOLORADJUSTMENTWrapper.ObjToRec: tagEMRSETCOLORADJUSTMENT;
begin
end;

constructor tagEMRGDICOMMENTWrapper.Create(ARecord: tagEMRGDICOMMENT);
begin
  inherited Create;
  FcbData := ARecord.cbData;
end;

function tagEMRGDICOMMENTWrapper.ObjToRec: tagEMRGDICOMMENT;
begin
  result.cbData := FcbData;
end;

constructor tagEMREOFWrapper.Create(ARecord: tagEMREOF);
begin
  inherited Create;
  FnPalEntries := ARecord.nPalEntries;
  FoffPalEntries := ARecord.offPalEntries;
  FnSizeLast := ARecord.nSizeLast;
end;

function tagEMREOFWrapper.ObjToRec: tagEMREOF;
begin
  result.nPalEntries := FnPalEntries;
  result.offPalEntries := FoffPalEntries;
  result.nSizeLast := FnSizeLast;
end;

constructor tagEMRLINETOWrapper.Create(ARecord: tagEMRLINETO);
begin
  inherited Create;
end;

function tagEMRLINETOWrapper.ObjToRec: tagEMRLINETO;
begin
end;

constructor tagEMROFFSETCLIPRGNWrapper.Create(ARecord: tagEMROFFSETCLIPRGN);
begin
  inherited Create;
end;

function tagEMROFFSETCLIPRGNWrapper.ObjToRec: tagEMROFFSETCLIPRGN;
begin
end;

constructor tagEMRFILLPATHWrapper.Create(ARecord: tagEMRFILLPATH);
begin
  inherited Create;
end;

function tagEMRFILLPATHWrapper.ObjToRec: tagEMRFILLPATH;
begin
end;

constructor tagEMREXCLUDECLIPRECTWrapper.Create(ARecord: tagEMREXCLUDECLIPRECT);
begin
  inherited Create;
end;

function tagEMREXCLUDECLIPRECTWrapper.ObjToRec: tagEMREXCLUDECLIPRECT;
begin
end;

constructor tagEMRSETVIEWPORTORGEXWrapper.Create(ARecord: tagEMRSETVIEWPORTORGEX);
begin
  inherited Create;
end;

function tagEMRSETVIEWPORTORGEXWrapper.ObjToRec: tagEMRSETVIEWPORTORGEX;
begin
end;

constructor tagEMRSETVIEWPORTEXTEXWrapper.Create(ARecord: tagEMRSETVIEWPORTEXTEX);
begin
  inherited Create;
end;

function tagEMRSETVIEWPORTEXTEXWrapper.ObjToRec: tagEMRSETVIEWPORTEXTEX;
begin
end;

constructor tagEMRSCALEVIEWPORTEXTEXWrapper.Create(ARecord: tagEMRSCALEVIEWPORTEXTEX);
begin
  inherited Create;
  FxNum := ARecord.xNum;
  FxDenom := ARecord.xDenom;
  FyNum := ARecord.yNum;
  FyDenom := ARecord.yDenom;
end;

function tagEMRSCALEVIEWPORTEXTEXWrapper.ObjToRec: tagEMRSCALEVIEWPORTEXTEX;
begin
  result.xNum := FxNum;
  result.xDenom := FxDenom;
  result.yNum := FyNum;
  result.yDenom := FyDenom;
end;

constructor tagEMRSETWORLDTRANSFORMWrapper.Create(ARecord: tagEMRSETWORLDTRANSFORM);
begin
  inherited Create;
end;

function tagEMRSETWORLDTRANSFORMWrapper.ObjToRec: tagEMRSETWORLDTRANSFORM;
begin
end;

constructor tagEMRMODIFYWORLDTRANSFORMWrapper.Create(ARecord: tagEMRMODIFYWORLDTRANSFORM);
begin
  inherited Create;
  FiMode := ARecord.iMode;
end;

function tagEMRMODIFYWORLDTRANSFORMWrapper.ObjToRec: tagEMRMODIFYWORLDTRANSFORM;
begin
  result.iMode := FiMode;
end;

constructor tagEMRSETPIXELVWrapper.Create(ARecord: tagEMRSETPIXELV);
begin
  inherited Create;
  FcrColor := ARecord.crColor;
end;

function tagEMRSETPIXELVWrapper.ObjToRec: tagEMRSETPIXELV;
begin
  result.crColor := FcrColor;
end;

constructor tagEMREXTFLOODFILLWrapper.Create(ARecord: tagEMREXTFLOODFILL);
begin
  inherited Create;
  FcrColor := ARecord.crColor;
  FiMode := ARecord.iMode;
end;

function tagEMREXTFLOODFILLWrapper.ObjToRec: tagEMREXTFLOODFILL;
begin
  result.crColor := FcrColor;
  result.iMode := FiMode;
end;

constructor tagEMRELLIPSEWrapper.Create(ARecord: tagEMRELLIPSE);
begin
  inherited Create;
end;

function tagEMRELLIPSEWrapper.ObjToRec: tagEMRELLIPSE;
begin
end;

constructor tagEMRROUNDRECTWrapper.Create(ARecord: tagEMRROUNDRECT);
begin
  inherited Create;
end;

function tagEMRROUNDRECTWrapper.ObjToRec: tagEMRROUNDRECT;
begin
end;

constructor tagEMRARCWrapper.Create(ARecord: tagEMRARC);
begin
  inherited Create;
end;

function tagEMRARCWrapper.ObjToRec: tagEMRARC;
begin
end;

constructor tagEMRANGLEARCWrapper.Create(ARecord: tagEMRANGLEARC);
begin
  inherited Create;
  FnRadius := ARecord.nRadius;
  FeStartAngle := ARecord.eStartAngle;
  FeSweepAngle := ARecord.eSweepAngle;
end;

function tagEMRANGLEARCWrapper.ObjToRec: tagEMRANGLEARC;
begin
  result.nRadius := FnRadius;
  result.eStartAngle := FeStartAngle;
  result.eSweepAngle := FeSweepAngle;
end;

constructor tagEMRPOLYLINEWrapper.Create(ARecord: tagEMRPOLYLINE);
begin
  inherited Create;
  Fcptl := ARecord.cptl;
end;

function tagEMRPOLYLINEWrapper.ObjToRec: tagEMRPOLYLINE;
begin
  result.cptl := Fcptl;
end;

constructor tagEMRPOLYLINE16Wrapper.Create(ARecord: tagEMRPOLYLINE16);
begin
  inherited Create;
  Fcpts := ARecord.cpts;
end;

function tagEMRPOLYLINE16Wrapper.ObjToRec: tagEMRPOLYLINE16;
begin
  result.cpts := Fcpts;
end;

constructor tagEMRPOLYDRAWWrapper.Create(ARecord: tagEMRPOLYDRAW);
begin
  inherited Create;
  Fcptl := ARecord.cptl;
end;

function tagEMRPOLYDRAWWrapper.ObjToRec: tagEMRPOLYDRAW;
begin
  result.cptl := Fcptl;
end;

constructor tagEMRPOLYDRAW16Wrapper.Create(ARecord: tagEMRPOLYDRAW16);
begin
  inherited Create;
  Fcpts := ARecord.cpts;
end;

function tagEMRPOLYDRAW16Wrapper.ObjToRec: tagEMRPOLYDRAW16;
begin
  result.cpts := Fcpts;
end;

constructor tagEMRPOLYPOLYLINEWrapper.Create(ARecord: tagEMRPOLYPOLYLINE);
begin
  inherited Create;
  FnPolys := ARecord.nPolys;
  Fcptl := ARecord.cptl;
end;

function tagEMRPOLYPOLYLINEWrapper.ObjToRec: tagEMRPOLYPOLYLINE;
begin
  result.nPolys := FnPolys;
  result.cptl := Fcptl;
end;

constructor tagEMRPOLYPOLYLINE16Wrapper.Create(ARecord: tagEMRPOLYPOLYLINE16);
begin
  inherited Create;
  FnPolys := ARecord.nPolys;
  Fcpts := ARecord.cpts;
end;

function tagEMRPOLYPOLYLINE16Wrapper.ObjToRec: tagEMRPOLYPOLYLINE16;
begin
  result.nPolys := FnPolys;
  result.cpts := Fcpts;
end;

constructor tagEMRINVERTRGNWrapper.Create(ARecord: tagEMRINVERTRGN);
begin
  inherited Create;
  FcbRgnData := ARecord.cbRgnData;
end;

function tagEMRINVERTRGNWrapper.ObjToRec: tagEMRINVERTRGN;
begin
  result.cbRgnData := FcbRgnData;
end;

constructor tagEMRFILLRGNWrapper.Create(ARecord: tagEMRFILLRGN);
begin
  inherited Create;
  FcbRgnData := ARecord.cbRgnData;
  FihBrush := ARecord.ihBrush;
end;

function tagEMRFILLRGNWrapper.ObjToRec: tagEMRFILLRGN;
begin
  result.cbRgnData := FcbRgnData;
  result.ihBrush := FihBrush;
end;

constructor tagEMRFRAMERGNWrapper.Create(ARecord: tagEMRFRAMERGN);
begin
  inherited Create;
  FcbRgnData := ARecord.cbRgnData;
  FihBrush := ARecord.ihBrush;
end;

function tagEMRFRAMERGNWrapper.ObjToRec: tagEMRFRAMERGN;
begin
  result.cbRgnData := FcbRgnData;
  result.ihBrush := FihBrush;
end;

constructor tagEMRGRADIENTFILLWrapper.Create(ARecord: tagEMRGRADIENTFILL);
begin
  inherited Create;
  FnVer := ARecord.nVer;
  FnTri := ARecord.nTri;
  FulMode := ARecord.ulMode;
end;

function tagEMRGRADIENTFILLWrapper.ObjToRec: tagEMRGRADIENTFILL;
begin
  result.nVer := FnVer;
  result.nTri := FnTri;
  result.ulMode := FulMode;
end;

constructor tagEMREXTSELECTCLIPRGNWrapper.Create(ARecord: tagEMREXTSELECTCLIPRGN);
begin
  inherited Create;
  FcbRgnData := ARecord.cbRgnData;
  FiMode := ARecord.iMode;
end;

function tagEMREXTSELECTCLIPRGNWrapper.ObjToRec: tagEMREXTSELECTCLIPRGN;
begin
  result.cbRgnData := FcbRgnData;
  result.iMode := FiMode;
end;

constructor tagEMREXTTEXTOUTAWrapper.Create(ARecord: tagEMREXTTEXTOUTA);
begin
  inherited Create;
  FiGraphicsMode := ARecord.iGraphicsMode;
  FexScale := ARecord.exScale;
  FeyScale := ARecord.eyScale;
end;

function tagEMREXTTEXTOUTAWrapper.ObjToRec: tagEMREXTTEXTOUTA;
begin
  result.iGraphicsMode := FiGraphicsMode;
  result.exScale := FexScale;
  result.eyScale := FeyScale;
end;

constructor tagEMRPOLYTEXTOUTAWrapper.Create(ARecord: tagEMRPOLYTEXTOUTA);
begin
  inherited Create;
  FiGraphicsMode := ARecord.iGraphicsMode;
  FexScale := ARecord.exScale;
  FeyScale := ARecord.eyScale;
  FcStrings := ARecord.cStrings;
end;

function tagEMRPOLYTEXTOUTAWrapper.ObjToRec: tagEMRPOLYTEXTOUTA;
begin
  result.iGraphicsMode := FiGraphicsMode;
  result.exScale := FexScale;
  result.eyScale := FeyScale;
  result.cStrings := FcStrings;
end;

constructor tagEMRBITBLTWrapper.Create(ARecord: tagEMRBITBLT);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FcxDest := ARecord.cxDest;
  FcyDest := ARecord.cyDest;
  FdwRop := ARecord.dwRop;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcrBkColorSrc := ARecord.crBkColorSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
end;

function tagEMRBITBLTWrapper.ObjToRec: tagEMRBITBLT;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.cxDest := FcxDest;
  result.cyDest := FcyDest;
  result.dwRop := FdwRop;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.crBkColorSrc := FcrBkColorSrc;
  result.iUsageSrc := FiUsageSrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
end;

constructor tagEMRSTRETCHBLTWrapper.Create(ARecord: tagEMRSTRETCHBLT);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FcxDest := ARecord.cxDest;
  FcyDest := ARecord.cyDest;
  FdwRop := ARecord.dwRop;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcrBkColorSrc := ARecord.crBkColorSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FcxSrc := ARecord.cxSrc;
  FcySrc := ARecord.cySrc;
end;

function tagEMRSTRETCHBLTWrapper.ObjToRec: tagEMRSTRETCHBLT;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.cxDest := FcxDest;
  result.cyDest := FcyDest;
  result.dwRop := FdwRop;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.crBkColorSrc := FcrBkColorSrc;
  result.iUsageSrc := FiUsageSrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.cxSrc := FcxSrc;
  result.cySrc := FcySrc;
end;

constructor tagEMRMASKBLTWrapper.Create(ARecord: tagEMRMASKBLT);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FcxDest := ARecord.cxDest;
  FcyDest := ARecord.cyDest;
  FdwRop := ARecord.dwRop;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcrBkColorSrc := ARecord.crBkColorSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FxMask := ARecord.xMask;
  FyMask := ARecord.yMask;
  FiUsageMask := ARecord.iUsageMask;
  FoffBmiMask := ARecord.offBmiMask;
  FcbBmiMask := ARecord.cbBmiMask;
  FoffBitsMask := ARecord.offBitsMask;
  FcbBitsMask := ARecord.cbBitsMask;
end;

function tagEMRMASKBLTWrapper.ObjToRec: tagEMRMASKBLT;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.cxDest := FcxDest;
  result.cyDest := FcyDest;
  result.dwRop := FdwRop;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.crBkColorSrc := FcrBkColorSrc;
  result.iUsageSrc := FiUsageSrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.xMask := FxMask;
  result.yMask := FyMask;
  result.iUsageMask := FiUsageMask;
  result.offBmiMask := FoffBmiMask;
  result.cbBmiMask := FcbBmiMask;
  result.offBitsMask := FoffBitsMask;
  result.cbBitsMask := FcbBitsMask;
end;

constructor tagEMRPLGBLTWrapper.Create(ARecord: tagEMRPLGBLT);
begin
  inherited Create;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcxSrc := ARecord.cxSrc;
  FcySrc := ARecord.cySrc;
  FcrBkColorSrc := ARecord.crBkColorSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FxMask := ARecord.xMask;
  FyMask := ARecord.yMask;
  FiUsageMask := ARecord.iUsageMask;
  FoffBmiMask := ARecord.offBmiMask;
  FcbBmiMask := ARecord.cbBmiMask;
  FoffBitsMask := ARecord.offBitsMask;
  FcbBitsMask := ARecord.cbBitsMask;
end;

function tagEMRPLGBLTWrapper.ObjToRec: tagEMRPLGBLT;
begin
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.cxSrc := FcxSrc;
  result.cySrc := FcySrc;
  result.crBkColorSrc := FcrBkColorSrc;
  result.iUsageSrc := FiUsageSrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.xMask := FxMask;
  result.yMask := FyMask;
  result.iUsageMask := FiUsageMask;
  result.offBmiMask := FoffBmiMask;
  result.cbBmiMask := FcbBmiMask;
  result.offBitsMask := FoffBitsMask;
  result.cbBitsMask := FcbBitsMask;
end;

constructor tagEMRSETDIBITSTODEVICEWrapper.Create(ARecord: tagEMRSETDIBITSTODEVICE);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcxSrc := ARecord.cxSrc;
  FcySrc := ARecord.cySrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FiStartScan := ARecord.iStartScan;
  FcScans := ARecord.cScans;
end;

function tagEMRSETDIBITSTODEVICEWrapper.ObjToRec: tagEMRSETDIBITSTODEVICE;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.cxSrc := FcxSrc;
  result.cySrc := FcySrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.iUsageSrc := FiUsageSrc;
  result.iStartScan := FiStartScan;
  result.cScans := FcScans;
end;

constructor tagEMRSTRETCHDIBITSWrapper.Create(ARecord: tagEMRSTRETCHDIBITS);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcxSrc := ARecord.cxSrc;
  FcySrc := ARecord.cySrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FdwRop := ARecord.dwRop;
  FcxDest := ARecord.cxDest;
  FcyDest := ARecord.cyDest;
end;

function tagEMRSTRETCHDIBITSWrapper.ObjToRec: tagEMRSTRETCHDIBITS;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.cxSrc := FcxSrc;
  result.cySrc := FcySrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.iUsageSrc := FiUsageSrc;
  result.dwRop := FdwRop;
  result.cxDest := FcxDest;
  result.cyDest := FcyDest;
end;

constructor tagEMRALPHABLENDWrapper.Create(ARecord: tagEMRALPHABLEND);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FcxDest := ARecord.cxDest;
  FcyDest := ARecord.cyDest;
  FdwRop := ARecord.dwRop;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcrBkColorSrc := ARecord.crBkColorSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FcxSrc := ARecord.cxSrc;
  FcySrc := ARecord.cySrc;
end;

function tagEMRALPHABLENDWrapper.ObjToRec: tagEMRALPHABLEND;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.cxDest := FcxDest;
  result.cyDest := FcyDest;
  result.dwRop := FdwRop;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.crBkColorSrc := FcrBkColorSrc;
  result.iUsageSrc := FiUsageSrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.cxSrc := FcxSrc;
  result.cySrc := FcySrc;
end;

constructor tagEMRTRANSPARENTBLTWrapper.Create(ARecord: tagEMRTRANSPARENTBLT);
begin
  inherited Create;
  FxDest := ARecord.xDest;
  FyDest := ARecord.yDest;
  FcxDest := ARecord.cxDest;
  FcyDest := ARecord.cyDest;
  FdwRop := ARecord.dwRop;
  FxSrc := ARecord.xSrc;
  FySrc := ARecord.ySrc;
  FcrBkColorSrc := ARecord.crBkColorSrc;
  FiUsageSrc := ARecord.iUsageSrc;
  FoffBmiSrc := ARecord.offBmiSrc;
  FcbBmiSrc := ARecord.cbBmiSrc;
  FoffBitsSrc := ARecord.offBitsSrc;
  FcbBitsSrc := ARecord.cbBitsSrc;
  FcxSrc := ARecord.cxSrc;
  FcySrc := ARecord.cySrc;
end;

function tagEMRTRANSPARENTBLTWrapper.ObjToRec: tagEMRTRANSPARENTBLT;
begin
  result.xDest := FxDest;
  result.yDest := FyDest;
  result.cxDest := FcxDest;
  result.cyDest := FcyDest;
  result.dwRop := FdwRop;
  result.xSrc := FxSrc;
  result.ySrc := FySrc;
  result.crBkColorSrc := FcrBkColorSrc;
  result.iUsageSrc := FiUsageSrc;
  result.offBmiSrc := FoffBmiSrc;
  result.cbBmiSrc := FcbBmiSrc;
  result.offBitsSrc := FoffBitsSrc;
  result.cbBitsSrc := FcbBitsSrc;
  result.cxSrc := FcxSrc;
  result.cySrc := FcySrc;
end;

constructor tagEMREXTCREATEFONTINDIRECTWWrapper.Create(ARecord: tagEMREXTCREATEFONTINDIRECTW);
begin
  inherited Create;
  FihFont := ARecord.ihFont;
end;

function tagEMREXTCREATEFONTINDIRECTWWrapper.ObjToRec: tagEMREXTCREATEFONTINDIRECTW;
begin
  result.ihFont := FihFont;
end;

constructor tagEMRCREATEPALETTEWrapper.Create(ARecord: tagEMRCREATEPALETTE);
begin
  inherited Create;
  FihPal := ARecord.ihPal;
end;

function tagEMRCREATEPALETTEWrapper.ObjToRec: tagEMRCREATEPALETTE;
begin
  result.ihPal := FihPal;
end;

constructor tagEMRCREATECOLORSPACEWrapper.Create(ARecord: tagEMRCREATECOLORSPACE);
begin
  inherited Create;
  FihCS := ARecord.ihCS;
end;

function tagEMRCREATECOLORSPACEWrapper.ObjToRec: tagEMRCREATECOLORSPACE;
begin
  result.ihCS := FihCS;
end;

constructor tagEMRCREATEPENWrapper.Create(ARecord: tagEMRCREATEPEN);
begin
  inherited Create;
  FihPen := ARecord.ihPen;
end;

function tagEMRCREATEPENWrapper.ObjToRec: tagEMRCREATEPEN;
begin
  result.ihPen := FihPen;
end;

constructor tagEMREXTCREATEPENWrapper.Create(ARecord: tagEMREXTCREATEPEN);
begin
  inherited Create;
  FihPen := ARecord.ihPen;
  FoffBmi := ARecord.offBmi;
  FcbBmi := ARecord.cbBmi;
  FoffBits := ARecord.offBits;
  FcbBits := ARecord.cbBits;
end;

function tagEMREXTCREATEPENWrapper.ObjToRec: tagEMREXTCREATEPEN;
begin
  result.ihPen := FihPen;
  result.offBmi := FoffBmi;
  result.cbBmi := FcbBmi;
  result.offBits := FoffBits;
  result.cbBits := FcbBits;
end;

constructor tagEMRCREATEBRUSHINDIRECTWrapper.Create(ARecord: tagEMRCREATEBRUSHINDIRECT);
begin
  inherited Create;
  FihBrush := ARecord.ihBrush;
end;

function tagEMRCREATEBRUSHINDIRECTWrapper.ObjToRec: tagEMRCREATEBRUSHINDIRECT;
begin
  result.ihBrush := FihBrush;
end;

constructor tagEMRCREATEMONOBRUSHWrapper.Create(ARecord: tagEMRCREATEMONOBRUSH);
begin
  inherited Create;
  FihBrush := ARecord.ihBrush;
  FiUsage := ARecord.iUsage;
  FoffBmi := ARecord.offBmi;
  FcbBmi := ARecord.cbBmi;
  FoffBits := ARecord.offBits;
  FcbBits := ARecord.cbBits;
end;

function tagEMRCREATEMONOBRUSHWrapper.ObjToRec: tagEMRCREATEMONOBRUSH;
begin
  result.ihBrush := FihBrush;
  result.iUsage := FiUsage;
  result.offBmi := FoffBmi;
  result.cbBmi := FcbBmi;
  result.offBits := FoffBits;
  result.cbBits := FcbBits;
end;

constructor tagEMRCREATEDIBPATTERNBRUSHPTWrapper.Create(ARecord: tagEMRCREATEDIBPATTERNBRUSHPT);
begin
  inherited Create;
  FihBrush := ARecord.ihBrush;
  FiUsage := ARecord.iUsage;
  FoffBmi := ARecord.offBmi;
  FcbBmi := ARecord.cbBmi;
  FoffBits := ARecord.offBits;
  FcbBits := ARecord.cbBits;
end;

function tagEMRCREATEDIBPATTERNBRUSHPTWrapper.ObjToRec: tagEMRCREATEDIBPATTERNBRUSHPT;
begin
  result.ihBrush := FihBrush;
  result.iUsage := FiUsage;
  result.offBmi := FoffBmi;
  result.cbBmi := FcbBmi;
  result.offBits := FoffBits;
  result.cbBits := FcbBits;
end;

constructor tagEMRFORMATWrapper.Create(ARecord: tagEMRFORMAT);
begin
  inherited Create;
  FdSignature := ARecord.dSignature;
  FnVersion := ARecord.nVersion;
  FcbData := ARecord.cbData;
  FoffData := ARecord.offData;
end;

function tagEMRFORMATWrapper.ObjToRec: tagEMRFORMAT;
begin
  result.dSignature := FdSignature;
  result.nVersion := FnVersion;
  result.cbData := FcbData;
  result.offData := FoffData;
end;

constructor tagEMRGLSRECORDWrapper.Create(ARecord: tagEMRGLSRECORD);
begin
  inherited Create;
  FcbData := ARecord.cbData;
end;

function tagEMRGLSRECORDWrapper.ObjToRec: tagEMRGLSRECORD;
begin
  result.cbData := FcbData;
end;

constructor tagEMRGLSBOUNDEDRECORDWrapper.Create(ARecord: tagEMRGLSBOUNDEDRECORD);
begin
  inherited Create;
  FcbData := ARecord.cbData;
end;

function tagEMRGLSBOUNDEDRECORDWrapper.ObjToRec: tagEMRGLSBOUNDEDRECORD;
begin
  result.cbData := FcbData;
end;

constructor tagEMRPIXELFORMATWrapper.Create(ARecord: tagEMRPIXELFORMAT);
begin
  inherited Create;
end;

function tagEMRPIXELFORMATWrapper.ObjToRec: tagEMRPIXELFORMAT;
begin
end;

constructor _POINTFLOATWrapper.Create(ARecord: _POINTFLOAT);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
end;

function _POINTFLOATWrapper.ObjToRec: _POINTFLOAT;
begin
  result.x := Fx;
  result.y := Fy;
end;

constructor _GLYPHMETRICSFLOATWrapper.Create(ARecord: _GLYPHMETRICSFLOAT);
begin
  inherited Create;
  FgmfBlackBoxX := ARecord.gmfBlackBoxX;
  FgmfBlackBoxY := ARecord.gmfBlackBoxY;
  FgmfCellIncX := ARecord.gmfCellIncX;
  FgmfCellIncY := ARecord.gmfCellIncY;
end;

function _GLYPHMETRICSFLOATWrapper.ObjToRec: _GLYPHMETRICSFLOAT;
begin
  result.gmfBlackBoxX := FgmfBlackBoxX;
  result.gmfBlackBoxY := FgmfBlackBoxY;
  result.gmfCellIncX := FgmfCellIncX;
  result.gmfCellIncY := FgmfCellIncY;
end;

constructor tagLAYERPLANEDESCRIPTORWrapper.Create(ARecord: tagLAYERPLANEDESCRIPTOR);
begin
  inherited Create;
  FnSize := ARecord.nSize;
  FnVersion := ARecord.nVersion;
  FdwFlags := ARecord.dwFlags;
  FiPixelType := ARecord.iPixelType;
  FcColorBits := ARecord.cColorBits;
  FcRedBits := ARecord.cRedBits;
  FcRedShift := ARecord.cRedShift;
  FcGreenBits := ARecord.cGreenBits;
  FcGreenShift := ARecord.cGreenShift;
  FcBlueBits := ARecord.cBlueBits;
  FcBlueShift := ARecord.cBlueShift;
  FcAlphaBits := ARecord.cAlphaBits;
  FcAlphaShift := ARecord.cAlphaShift;
  FcAccumBits := ARecord.cAccumBits;
  FcAccumRedBits := ARecord.cAccumRedBits;
  FcAccumGreenBits := ARecord.cAccumGreenBits;
  FcAccumBlueBits := ARecord.cAccumBlueBits;
  FcAccumAlphaBits := ARecord.cAccumAlphaBits;
  FcDepthBits := ARecord.cDepthBits;
  FcStencilBits := ARecord.cStencilBits;
  FcAuxBuffers := ARecord.cAuxBuffers;
  FiLayerPlane := ARecord.iLayerPlane;
  FbReserved := ARecord.bReserved;
  FcrTransparent := ARecord.crTransparent;
end;

function tagLAYERPLANEDESCRIPTORWrapper.ObjToRec: tagLAYERPLANEDESCRIPTOR;
begin
  result.nSize := FnSize;
  result.nVersion := FnVersion;
  result.dwFlags := FdwFlags;
  result.iPixelType := FiPixelType;
  result.cColorBits := FcColorBits;
  result.cRedBits := FcRedBits;
  result.cRedShift := FcRedShift;
  result.cGreenBits := FcGreenBits;
  result.cGreenShift := FcGreenShift;
  result.cBlueBits := FcBlueBits;
  result.cBlueShift := FcBlueShift;
  result.cAlphaBits := FcAlphaBits;
  result.cAlphaShift := FcAlphaShift;
  result.cAccumBits := FcAccumBits;
  result.cAccumRedBits := FcAccumRedBits;
  result.cAccumGreenBits := FcAccumGreenBits;
  result.cAccumBlueBits := FcAccumBlueBits;
  result.cAccumAlphaBits := FcAccumAlphaBits;
  result.cDepthBits := FcDepthBits;
  result.cStencilBits := FcStencilBits;
  result.cAuxBuffers := FcAuxBuffers;
  result.iLayerPlane := FiLayerPlane;
  result.bReserved := FbReserved;
  result.crTransparent := FcrTransparent;
end;

constructor _WGLSWAPWrapper.Create(ARecord: _WGLSWAP);
begin
  inherited Create;
  Fhdc := ARecord.hdc;
  FuiFlags := ARecord.uiFlags;
end;

function _WGLSWAPWrapper.ObjToRec: _WGLSWAP;
begin
  result.hdc := Fhdc;
  result.uiFlags := FuiFlags;
end;

constructor tagCREATESTRUCTAWrapper.Create(ARecord: tagCREATESTRUCTA);
begin
  inherited Create;
  FhInstance := ARecord.hInstance;
  FhMenu := ARecord.hMenu;
  FhwndParent := ARecord.hwndParent;
  Fcy := ARecord.cy;
  Fcx := ARecord.cx;
  Fy := ARecord.y;
  Fx := ARecord.x;
  Fstyle := ARecord.style;
  FdwExStyle := ARecord.dwExStyle;
end;

function tagCREATESTRUCTAWrapper.ObjToRec: tagCREATESTRUCTA;
begin
  result.hInstance := FhInstance;
  result.hMenu := FhMenu;
  result.hwndParent := FhwndParent;
  result.cy := Fcy;
  result.cx := Fcx;
  result.y := Fy;
  result.x := Fx;
  result.style := Fstyle;
  result.dwExStyle := FdwExStyle;
end;

constructor tagCREATESTRUCTWWrapper.Create(ARecord: tagCREATESTRUCTW);
begin
  inherited Create;
  FhInstance := ARecord.hInstance;
  FhMenu := ARecord.hMenu;
  FhwndParent := ARecord.hwndParent;
  Fcy := ARecord.cy;
  Fcx := ARecord.cx;
  Fy := ARecord.y;
  Fx := ARecord.x;
  Fstyle := ARecord.style;
  FdwExStyle := ARecord.dwExStyle;
end;

function tagCREATESTRUCTWWrapper.ObjToRec: tagCREATESTRUCTW;
begin
  result.hInstance := FhInstance;
  result.hMenu := FhMenu;
  result.hwndParent := FhwndParent;
  result.cy := Fcy;
  result.cx := Fcx;
  result.y := Fy;
  result.x := Fx;
  result.style := Fstyle;
  result.dwExStyle := FdwExStyle;
end;

constructor tagCBT_CREATEWNDAWrapper.Create(ARecord: tagCBT_CREATEWNDA);
begin
  inherited Create;
  FhwndInsertAfter := ARecord.hwndInsertAfter;
end;

function tagCBT_CREATEWNDAWrapper.ObjToRec: tagCBT_CREATEWNDA;
begin
  result.hwndInsertAfter := FhwndInsertAfter;
end;

constructor tagCBTACTIVATESTRUCTWrapper.Create(ARecord: tagCBTACTIVATESTRUCT);
begin
  inherited Create;
  FfMouse := ARecord.fMouse;
  FhWndActive := ARecord.hWndActive;
end;

function tagCBTACTIVATESTRUCTWrapper.ObjToRec: tagCBTACTIVATESTRUCT;
begin
  result.fMouse := FfMouse;
  result.hWndActive := FhWndActive;
end;

constructor tagEVENTMSGWrapper.Create(ARecord: tagEVENTMSG);
begin
  inherited Create;
  Fmessage := ARecord.message;
  FparamL := ARecord.paramL;
  FparamH := ARecord.paramH;
  Ftime := ARecord.time;
  Fhwnd := ARecord.hwnd;
end;

function tagEVENTMSGWrapper.ObjToRec: tagEVENTMSG;
begin
  result.message := Fmessage;
  result.paramL := FparamL;
  result.paramH := FparamH;
  result.time := Ftime;
  result.hwnd := Fhwnd;
end;

constructor tagCWPSTRUCTWrapper.Create(ARecord: tagCWPSTRUCT);
begin
  inherited Create;
  FlParam := ARecord.lParam;
  FwParam := ARecord.wParam;
  Fmessage := ARecord.message;
  Fhwnd := ARecord.hwnd;
end;

function tagCWPSTRUCTWrapper.ObjToRec: tagCWPSTRUCT;
begin
  result.lParam := FlParam;
  result.wParam := FwParam;
  result.message := Fmessage;
  result.hwnd := Fhwnd;
end;

constructor tagCWPRETSTRUCTWrapper.Create(ARecord: tagCWPRETSTRUCT);
begin
  inherited Create;
  FlResult := ARecord.lResult;
  FlParam := ARecord.lParam;
  FwParam := ARecord.wParam;
  Fmessage := ARecord.message;
  Fhwnd := ARecord.hwnd;
end;

function tagCWPRETSTRUCTWrapper.ObjToRec: tagCWPRETSTRUCT;
begin
  result.lResult := FlResult;
  result.lParam := FlParam;
  result.wParam := FwParam;
  result.message := Fmessage;
  result.hwnd := Fhwnd;
end;

constructor tagDEBUGHOOKINFOWrapper.Create(ARecord: tagDEBUGHOOKINFO);
begin
  inherited Create;
  FidThread := ARecord.idThread;
  FidThreadInstaller := ARecord.idThreadInstaller;
  FlParam := ARecord.lParam;
  FwParam := ARecord.wParam;
  Fcode := ARecord.code;
end;

function tagDEBUGHOOKINFOWrapper.ObjToRec: tagDEBUGHOOKINFO;
begin
  result.idThread := FidThread;
  result.idThreadInstaller := FidThreadInstaller;
  result.lParam := FlParam;
  result.wParam := FwParam;
  result.code := Fcode;
end;

constructor tagMOUSEHOOKSTRUCTWrapper.Create(ARecord: tagMOUSEHOOKSTRUCT);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
  FwHitTestCode := ARecord.wHitTestCode;
  FdwExtraInfo := ARecord.dwExtraInfo;
end;

function tagMOUSEHOOKSTRUCTWrapper.ObjToRec: tagMOUSEHOOKSTRUCT;
begin
  result.hwnd := Fhwnd;
  result.wHitTestCode := FwHitTestCode;
  result.dwExtraInfo := FdwExtraInfo;
end;

constructor tagHARDWAREHOOKSTRUCTWrapper.Create(ARecord: tagHARDWAREHOOKSTRUCT);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
  Fmessage := ARecord.message;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
end;

function tagHARDWAREHOOKSTRUCTWrapper.ObjToRec: tagHARDWAREHOOKSTRUCT;
begin
  result.hwnd := Fhwnd;
  result.message := Fmessage;
  result.wParam := FwParam;
  result.lParam := FlParam;
end;

constructor tagMOUSEMOVEPOINTWrapper.Create(ARecord: tagMOUSEMOVEPOINT);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Ftime := ARecord.time;
  FdwExtraInfo := ARecord.dwExtraInfo;
end;

function tagMOUSEMOVEPOINTWrapper.ObjToRec: tagMOUSEMOVEPOINT;
begin
  result.x := Fx;
  result.y := Fy;
  result.time := Ftime;
  result.dwExtraInfo := FdwExtraInfo;
end;

constructor tagUSEROBJECTFLAGSWrapper.Create(ARecord: tagUSEROBJECTFLAGS);
begin
  inherited Create;
  FfInherit := ARecord.fInherit;
  FfReserved := ARecord.fReserved;
  FdwFlags := ARecord.dwFlags;
end;

function tagUSEROBJECTFLAGSWrapper.ObjToRec: tagUSEROBJECTFLAGS;
begin
  result.fInherit := FfInherit;
  result.fReserved := FfReserved;
  result.dwFlags := FdwFlags;
end;

constructor tagWNDCLASSEXAWrapper.Create(ARecord: tagWNDCLASSEXA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fstyle := ARecord.style;
  FcbClsExtra := ARecord.cbClsExtra;
  FcbWndExtra := ARecord.cbWndExtra;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FhCursor := ARecord.hCursor;
  FhbrBackground := ARecord.hbrBackground;
  FhIconSm := ARecord.hIconSm;
end;

function tagWNDCLASSEXAWrapper.ObjToRec: tagWNDCLASSEXA;
begin
  result.cbSize := FcbSize;
  result.style := Fstyle;
  result.cbClsExtra := FcbClsExtra;
  result.cbWndExtra := FcbWndExtra;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.hCursor := FhCursor;
  result.hbrBackground := FhbrBackground;
  result.hIconSm := FhIconSm;
end;

constructor tagWNDCLASSEXWWrapper.Create(ARecord: tagWNDCLASSEXW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fstyle := ARecord.style;
  FcbClsExtra := ARecord.cbClsExtra;
  FcbWndExtra := ARecord.cbWndExtra;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FhCursor := ARecord.hCursor;
  FhbrBackground := ARecord.hbrBackground;
  FhIconSm := ARecord.hIconSm;
end;

function tagWNDCLASSEXWWrapper.ObjToRec: tagWNDCLASSEXW;
begin
  result.cbSize := FcbSize;
  result.style := Fstyle;
  result.cbClsExtra := FcbClsExtra;
  result.cbWndExtra := FcbWndExtra;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.hCursor := FhCursor;
  result.hbrBackground := FhbrBackground;
  result.hIconSm := FhIconSm;
end;

constructor tagWNDCLASSAWrapper.Create(ARecord: tagWNDCLASSA);
begin
  inherited Create;
  Fstyle := ARecord.style;
  FcbClsExtra := ARecord.cbClsExtra;
  FcbWndExtra := ARecord.cbWndExtra;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FhCursor := ARecord.hCursor;
  FhbrBackground := ARecord.hbrBackground;
end;

function tagWNDCLASSAWrapper.ObjToRec: tagWNDCLASSA;
begin
  result.style := Fstyle;
  result.cbClsExtra := FcbClsExtra;
  result.cbWndExtra := FcbWndExtra;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.hCursor := FhCursor;
  result.hbrBackground := FhbrBackground;
end;

constructor tagWNDCLASSWWrapper.Create(ARecord: tagWNDCLASSW);
begin
  inherited Create;
  Fstyle := ARecord.style;
  FcbClsExtra := ARecord.cbClsExtra;
  FcbWndExtra := ARecord.cbWndExtra;
  FhInstance := ARecord.hInstance;
  FhIcon := ARecord.hIcon;
  FhCursor := ARecord.hCursor;
  FhbrBackground := ARecord.hbrBackground;
end;

function tagWNDCLASSWWrapper.ObjToRec: tagWNDCLASSW;
begin
  result.style := Fstyle;
  result.cbClsExtra := FcbClsExtra;
  result.cbWndExtra := FcbWndExtra;
  result.hInstance := FhInstance;
  result.hIcon := FhIcon;
  result.hCursor := FhCursor;
  result.hbrBackground := FhbrBackground;
end;

constructor tagMSGWrapper.Create(ARecord: tagMSG);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
  Fmessage := ARecord.message;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
  Ftime := ARecord.time;
end;

function tagMSGWrapper.ObjToRec: tagMSG;
begin
  result.hwnd := Fhwnd;
  result.message := Fmessage;
  result.wParam := FwParam;
  result.lParam := FlParam;
  result.time := Ftime;
end;

constructor tagMINMAXINFOWrapper.Create(ARecord: tagMINMAXINFO);
begin
  inherited Create;
end;

function tagMINMAXINFOWrapper.ObjToRec: tagMINMAXINFO;
begin
end;

constructor tagCOPYDATASTRUCTWrapper.Create(ARecord: tagCOPYDATASTRUCT);
begin
  inherited Create;
  FdwData := ARecord.dwData;
  FcbData := ARecord.cbData;
end;

function tagCOPYDATASTRUCTWrapper.ObjToRec: tagCOPYDATASTRUCT;
begin
  result.dwData := FdwData;
  result.cbData := FcbData;
end;

constructor tagMDINEXTMENUWrapper.Create(ARecord: tagMDINEXTMENU);
begin
  inherited Create;
  FhmenuIn := ARecord.hmenuIn;
  FhmenuNext := ARecord.hmenuNext;
  FhwndNext := ARecord.hwndNext;
end;

function tagMDINEXTMENUWrapper.ObjToRec: tagMDINEXTMENU;
begin
  result.hmenuIn := FhmenuIn;
  result.hmenuNext := FhmenuNext;
  result.hwndNext := FhwndNext;
end;

constructor tagWINDOWPOSWrapper.Create(ARecord: tagWINDOWPOS);
begin
  inherited Create;
  Fhwnd := ARecord.hwnd;
  FhwndInsertAfter := ARecord.hwndInsertAfter;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
  Fflags := ARecord.flags;
end;

function tagWINDOWPOSWrapper.ObjToRec: tagWINDOWPOS;
begin
  result.hwnd := Fhwnd;
  result.hwndInsertAfter := FhwndInsertAfter;
  result.x := Fx;
  result.y := Fy;
  result.cx := Fcx;
  result.cy := Fcy;
  result.flags := Fflags;
end;

constructor tagNCCALCSIZE_PARAMSWrapper.Create(ARecord: tagNCCALCSIZE_PARAMS);
begin
  inherited Create;
end;

function tagNCCALCSIZE_PARAMSWrapper.ObjToRec: tagNCCALCSIZE_PARAMS;
begin
end;

constructor tagTRACKMOUSEEVENTWrapper.Create(ARecord: tagTRACKMOUSEEVENT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FhwndTrack := ARecord.hwndTrack;
  FdwHoverTime := ARecord.dwHoverTime;
end;

function tagTRACKMOUSEEVENTWrapper.ObjToRec: tagTRACKMOUSEEVENT;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.hwndTrack := FhwndTrack;
  result.dwHoverTime := FdwHoverTime;
end;

constructor tagACCELWrapper.Create(ARecord: tagACCEL);
begin
  inherited Create;
  FfVirt := ARecord.fVirt;
  Fkey := ARecord.key;
  Fcmd := ARecord.cmd;
end;

function tagACCELWrapper.ObjToRec: tagACCEL;
begin
  result.fVirt := FfVirt;
  result.key := Fkey;
  result.cmd := Fcmd;
end;

constructor tagPAINTSTRUCTWrapper.Create(ARecord: tagPAINTSTRUCT);
begin
  inherited Create;
  Fhdc := ARecord.hdc;
  FfErase := ARecord.fErase;
  FfRestore := ARecord.fRestore;
  FfIncUpdate := ARecord.fIncUpdate;
end;

function tagPAINTSTRUCTWrapper.ObjToRec: tagPAINTSTRUCT;
begin
  result.hdc := Fhdc;
  result.fErase := FfErase;
  result.fRestore := FfRestore;
  result.fIncUpdate := FfIncUpdate;
end;

constructor tagWINDOWPLACEMENTWrapper.Create(ARecord: tagWINDOWPLACEMENT);
begin
  inherited Create;
  Flength := ARecord.length;
  Fflags := ARecord.flags;
  FshowCmd := ARecord.showCmd;
end;

function tagWINDOWPLACEMENTWrapper.ObjToRec: tagWINDOWPLACEMENT;
begin
  result.length := Flength;
  result.flags := Fflags;
  result.showCmd := FshowCmd;
end;

constructor tagNMHDRWrapper.Create(ARecord: tagNMHDR);
begin
  inherited Create;
  FhwndFrom := ARecord.hwndFrom;
  FidFrom := ARecord.idFrom;
  Fcode := ARecord.code;
end;

function tagNMHDRWrapper.ObjToRec: tagNMHDR;
begin
  result.hwndFrom := FhwndFrom;
  result.idFrom := FidFrom;
  result.code := Fcode;
end;

constructor tagSTYLESTRUCTWrapper.Create(ARecord: tagSTYLESTRUCT);
begin
  inherited Create;
  FstyleOld := ARecord.styleOld;
  FstyleNew := ARecord.styleNew;
end;

function tagSTYLESTRUCTWrapper.ObjToRec: tagSTYLESTRUCT;
begin
  result.styleOld := FstyleOld;
  result.styleNew := FstyleNew;
end;

constructor tagMEASUREITEMSTRUCTWrapper.Create(ARecord: tagMEASUREITEMSTRUCT);
begin
  inherited Create;
  FCtlType := ARecord.CtlType;
  FCtlID := ARecord.CtlID;
  FitemID := ARecord.itemID;
  FitemWidth := ARecord.itemWidth;
  FitemHeight := ARecord.itemHeight;
  FitemData := ARecord.itemData;
end;

function tagMEASUREITEMSTRUCTWrapper.ObjToRec: tagMEASUREITEMSTRUCT;
begin
  result.CtlType := FCtlType;
  result.CtlID := FCtlID;
  result.itemID := FitemID;
  result.itemWidth := FitemWidth;
  result.itemHeight := FitemHeight;
  result.itemData := FitemData;
end;

constructor tagDRAWITEMSTRUCTWrapper.Create(ARecord: tagDRAWITEMSTRUCT);
begin
  inherited Create;
  FCtlType := ARecord.CtlType;
  FCtlID := ARecord.CtlID;
  FitemID := ARecord.itemID;
  FitemAction := ARecord.itemAction;
  FitemState := ARecord.itemState;
  FhwndItem := ARecord.hwndItem;
  FhDC := ARecord.hDC;
  FitemData := ARecord.itemData;
end;

function tagDRAWITEMSTRUCTWrapper.ObjToRec: tagDRAWITEMSTRUCT;
begin
  result.CtlType := FCtlType;
  result.CtlID := FCtlID;
  result.itemID := FitemID;
  result.itemAction := FitemAction;
  result.itemState := FitemState;
  result.hwndItem := FhwndItem;
  result.hDC := FhDC;
  result.itemData := FitemData;
end;

constructor tagDELETEITEMSTRUCTWrapper.Create(ARecord: tagDELETEITEMSTRUCT);
begin
  inherited Create;
  FCtlType := ARecord.CtlType;
  FCtlID := ARecord.CtlID;
  FitemID := ARecord.itemID;
  FhwndItem := ARecord.hwndItem;
  FitemData := ARecord.itemData;
end;

function tagDELETEITEMSTRUCTWrapper.ObjToRec: tagDELETEITEMSTRUCT;
begin
  result.CtlType := FCtlType;
  result.CtlID := FCtlID;
  result.itemID := FitemID;
  result.hwndItem := FhwndItem;
  result.itemData := FitemData;
end;

constructor tagCOMPAREITEMSTRUCTWrapper.Create(ARecord: tagCOMPAREITEMSTRUCT);
begin
  inherited Create;
  FCtlType := ARecord.CtlType;
  FCtlID := ARecord.CtlID;
  FhwndItem := ARecord.hwndItem;
  FitemID1 := ARecord.itemID1;
  FitemData1 := ARecord.itemData1;
  FitemID2 := ARecord.itemID2;
  FitemData2 := ARecord.itemData2;
  FdwLocaleId := ARecord.dwLocaleId;
end;

function tagCOMPAREITEMSTRUCTWrapper.ObjToRec: tagCOMPAREITEMSTRUCT;
begin
  result.CtlType := FCtlType;
  result.CtlID := FCtlID;
  result.hwndItem := FhwndItem;
  result.itemID1 := FitemID1;
  result.itemData1 := FitemData1;
  result.itemID2 := FitemID2;
  result.itemData2 := FitemData2;
  result.dwLocaleId := FdwLocaleId;
end;

constructor tagBROADCASTSYSMSGWrapper.Create(ARecord: tagBROADCASTSYSMSG);
begin
  inherited Create;
  FuiMessage := ARecord.uiMessage;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
end;

function tagBROADCASTSYSMSGWrapper.ObjToRec: tagBROADCASTSYSMSG;
begin
  result.uiMessage := FuiMessage;
  result.wParam := FwParam;
  result.lParam := FlParam;
end;

constructor FLASHWINFOWrapper.Create(ARecord: FLASHWINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fhwnd := ARecord.hwnd;
  FdwFlags := ARecord.dwFlags;
  FuCount := ARecord.uCount;
  FdwTimeout := ARecord.dwTimeout;
end;

function FLASHWINFOWrapper.ObjToRec: FLASHWINFO;
begin
  result.cbSize := FcbSize;
  result.hwnd := Fhwnd;
  result.dwFlags := FdwFlags;
  result.uCount := FuCount;
  result.dwTimeout := FdwTimeout;
end;

constructor DLGTEMPLATEWrapper.Create(ARecord: DLGTEMPLATE);
begin
  inherited Create;
  Fstyle := ARecord.style;
  FdwExtendedStyle := ARecord.dwExtendedStyle;
  Fcdit := ARecord.cdit;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
end;

function DLGTEMPLATEWrapper.ObjToRec: DLGTEMPLATE;
begin
  result.style := Fstyle;
  result.dwExtendedStyle := FdwExtendedStyle;
  result.cdit := Fcdit;
  result.x := Fx;
  result.y := Fy;
  result.cx := Fcx;
  result.cy := Fcy;
end;

constructor DLGITEMTEMPLATEWrapper.Create(ARecord: DLGITEMTEMPLATE);
begin
  inherited Create;
  Fstyle := ARecord.style;
  FdwExtendedStyle := ARecord.dwExtendedStyle;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
  Fid := ARecord.id;
end;

function DLGITEMTEMPLATEWrapper.ObjToRec: DLGITEMTEMPLATE;
begin
  result.style := Fstyle;
  result.dwExtendedStyle := FdwExtendedStyle;
  result.x := Fx;
  result.y := Fy;
  result.cx := Fcx;
  result.cy := Fcy;
  result.id := Fid;
end;

constructor tagMOUSEINPUTWrapper.Create(ARecord: tagMOUSEINPUT);
begin
  inherited Create;
  Fdx := ARecord.dx;
  Fdy := ARecord.dy;
  FmouseData := ARecord.mouseData;
  FdwFlags := ARecord.dwFlags;
  Ftime := ARecord.time;
  FdwExtraInfo := ARecord.dwExtraInfo;
end;

function tagMOUSEINPUTWrapper.ObjToRec: tagMOUSEINPUT;
begin
  result.dx := Fdx;
  result.dy := Fdy;
  result.mouseData := FmouseData;
  result.dwFlags := FdwFlags;
  result.time := Ftime;
  result.dwExtraInfo := FdwExtraInfo;
end;

constructor tagKEYBDINPUTWrapper.Create(ARecord: tagKEYBDINPUT);
begin
  inherited Create;
  FwVk := ARecord.wVk;
  FwScan := ARecord.wScan;
  FdwFlags := ARecord.dwFlags;
  Ftime := ARecord.time;
  FdwExtraInfo := ARecord.dwExtraInfo;
end;

function tagKEYBDINPUTWrapper.ObjToRec: tagKEYBDINPUT;
begin
  result.wVk := FwVk;
  result.wScan := FwScan;
  result.dwFlags := FdwFlags;
  result.time := Ftime;
  result.dwExtraInfo := FdwExtraInfo;
end;

constructor tagHARDWAREINPUTWrapper.Create(ARecord: tagHARDWAREINPUT);
begin
  inherited Create;
  FuMsg := ARecord.uMsg;
  FwParamL := ARecord.wParamL;
  FwParamH := ARecord.wParamH;
end;

function tagHARDWAREINPUTWrapper.ObjToRec: tagHARDWAREINPUT;
begin
  result.uMsg := FuMsg;
  result.wParamL := FwParamL;
  result.wParamH := FwParamH;
end;

constructor tagINPUTWrapper.Create(ARecord: tagINPUT);
begin
  inherited Create;
  FItype := ARecord.Itype;
end;

function tagINPUTWrapper.ObjToRec: tagINPUT;
begin
  result.Itype := FItype;
end;

constructor tagLASTINPUTINFOWrapper.Create(ARecord: tagLASTINPUTINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwTime := ARecord.dwTime;
end;

function tagLASTINPUTINFOWrapper.ObjToRec: tagLASTINPUTINFO;
begin
  result.cbSize := FcbSize;
  result.dwTime := FdwTime;
end;

constructor tagTPMPARAMSWrapper.Create(ARecord: tagTPMPARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
end;

function tagTPMPARAMSWrapper.ObjToRec: tagTPMPARAMS;
begin
  result.cbSize := FcbSize;
end;

constructor tagMENUINFOWrapper.Create(ARecord: tagMENUINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FdwStyle := ARecord.dwStyle;
  FcyMax := ARecord.cyMax;
  FhbrBack := ARecord.hbrBack;
  FdwContextHelpID := ARecord.dwContextHelpID;
  FdwMenuData := ARecord.dwMenuData;
end;

function tagMENUINFOWrapper.ObjToRec: tagMENUINFO;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.dwStyle := FdwStyle;
  result.cyMax := FcyMax;
  result.hbrBack := FhbrBack;
  result.dwContextHelpID := FdwContextHelpID;
  result.dwMenuData := FdwMenuData;
end;

constructor tagMENUGETOBJECTINFOWrapper.Create(ARecord: tagMENUGETOBJECTINFO);
begin
  inherited Create;
  FdwFlags := ARecord.dwFlags;
  FuPos := ARecord.uPos;
  Fhmenu := ARecord.hmenu;
end;

function tagMENUGETOBJECTINFOWrapper.ObjToRec: tagMENUGETOBJECTINFO;
begin
  result.dwFlags := FdwFlags;
  result.uPos := FuPos;
  result.hmenu := Fhmenu;
end;

constructor tagMENUITEMINFOAWrapper.Create(ARecord: tagMENUITEMINFOA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FfType := ARecord.fType;
  FfState := ARecord.fState;
  FwID := ARecord.wID;
  FhSubMenu := ARecord.hSubMenu;
  FhbmpChecked := ARecord.hbmpChecked;
  FhbmpUnchecked := ARecord.hbmpUnchecked;
  FdwItemData := ARecord.dwItemData;
  Fcch := ARecord.cch;
  FhbmpItem := ARecord.hbmpItem;
end;

function tagMENUITEMINFOAWrapper.ObjToRec: tagMENUITEMINFOA;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.fType := FfType;
  result.fState := FfState;
  result.wID := FwID;
  result.hSubMenu := FhSubMenu;
  result.hbmpChecked := FhbmpChecked;
  result.hbmpUnchecked := FhbmpUnchecked;
  result.dwItemData := FdwItemData;
  result.cch := Fcch;
  result.hbmpItem := FhbmpItem;
end;

constructor tagMENUITEMINFOWWrapper.Create(ARecord: tagMENUITEMINFOW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FfType := ARecord.fType;
  FfState := ARecord.fState;
  FwID := ARecord.wID;
  FhSubMenu := ARecord.hSubMenu;
  FhbmpChecked := ARecord.hbmpChecked;
  FhbmpUnchecked := ARecord.hbmpUnchecked;
  FdwItemData := ARecord.dwItemData;
  Fcch := ARecord.cch;
  FhbmpItem := ARecord.hbmpItem;
end;

function tagMENUITEMINFOWWrapper.ObjToRec: tagMENUITEMINFOW;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.fType := FfType;
  result.fState := FfState;
  result.wID := FwID;
  result.hSubMenu := FhSubMenu;
  result.hbmpChecked := FhbmpChecked;
  result.hbmpUnchecked := FhbmpUnchecked;
  result.dwItemData := FdwItemData;
  result.cch := Fcch;
  result.hbmpItem := FhbmpItem;
end;

constructor tagDROPSTRUCTWrapper.Create(ARecord: tagDROPSTRUCT);
begin
  inherited Create;
  FhwndSource := ARecord.hwndSource;
  FhwndSink := ARecord.hwndSink;
  FwFmt := ARecord.wFmt;
  FdwData := ARecord.dwData;
  FdwControlData := ARecord.dwControlData;
end;

function tagDROPSTRUCTWrapper.ObjToRec: tagDROPSTRUCT;
begin
  result.hwndSource := FhwndSource;
  result.hwndSink := FhwndSink;
  result.wFmt := FwFmt;
  result.dwData := FdwData;
  result.dwControlData := FdwControlData;
end;

constructor tagDRAWTEXTPARAMSWrapper.Create(ARecord: tagDRAWTEXTPARAMS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiTabLength := ARecord.iTabLength;
  FiLeftMargin := ARecord.iLeftMargin;
  FiRightMargin := ARecord.iRightMargin;
  FuiLengthDrawn := ARecord.uiLengthDrawn;
end;

function tagDRAWTEXTPARAMSWrapper.ObjToRec: tagDRAWTEXTPARAMS;
begin
  result.cbSize := FcbSize;
  result.iTabLength := FiTabLength;
  result.iLeftMargin := FiLeftMargin;
  result.iRightMargin := FiRightMargin;
  result.uiLengthDrawn := FuiLengthDrawn;
end;

constructor tagHELPINFOWrapper.Create(ARecord: tagHELPINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiContextType := ARecord.iContextType;
  FiCtrlId := ARecord.iCtrlId;
  FhItemHandle := ARecord.hItemHandle;
  FdwContextId := ARecord.dwContextId;
end;

function tagHELPINFOWrapper.ObjToRec: tagHELPINFO;
begin
  result.cbSize := FcbSize;
  result.iContextType := FiContextType;
  result.iCtrlId := FiCtrlId;
  result.hItemHandle := FhItemHandle;
  result.dwContextId := FdwContextId;
end;

constructor tagMSGBOXPARAMSAWrapper.Create(ARecord: tagMSGBOXPARAMSA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhwndOwner := ARecord.hwndOwner;
  FhInstance := ARecord.hInstance;
  FdwStyle := ARecord.dwStyle;
  FdwContextHelpId := ARecord.dwContextHelpId;
  FdwLanguageId := ARecord.dwLanguageId;
end;

function tagMSGBOXPARAMSAWrapper.ObjToRec: tagMSGBOXPARAMSA;
begin
  result.cbSize := FcbSize;
  result.hwndOwner := FhwndOwner;
  result.hInstance := FhInstance;
  result.dwStyle := FdwStyle;
  result.dwContextHelpId := FdwContextHelpId;
  result.dwLanguageId := FdwLanguageId;
end;

constructor tagMSGBOXPARAMSWWrapper.Create(ARecord: tagMSGBOXPARAMSW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhwndOwner := ARecord.hwndOwner;
  FhInstance := ARecord.hInstance;
  FdwStyle := ARecord.dwStyle;
  FdwContextHelpId := ARecord.dwContextHelpId;
  FdwLanguageId := ARecord.dwLanguageId;
end;

function tagMSGBOXPARAMSWWrapper.ObjToRec: tagMSGBOXPARAMSW;
begin
  result.cbSize := FcbSize;
  result.hwndOwner := FhwndOwner;
  result.hInstance := FhInstance;
  result.dwStyle := FdwStyle;
  result.dwContextHelpId := FdwContextHelpId;
  result.dwLanguageId := FdwLanguageId;
end;

constructor MENUITEMTEMPLATEHEADERWrapper.Create(ARecord: MENUITEMTEMPLATEHEADER);
begin
  inherited Create;
  FversionNumber := ARecord.versionNumber;
  Foffset := ARecord.offset;
end;

function MENUITEMTEMPLATEHEADERWrapper.ObjToRec: MENUITEMTEMPLATEHEADER;
begin
  result.versionNumber := FversionNumber;
  result.offset := Foffset;
end;

constructor MENUITEMTEMPLATEWrapper.Create(ARecord: MENUITEMTEMPLATE);
begin
  inherited Create;
  FmtOption := ARecord.mtOption;
  FmtID := ARecord.mtID;
end;

function MENUITEMTEMPLATEWrapper.ObjToRec: MENUITEMTEMPLATE;
begin
  result.mtOption := FmtOption;
  result.mtID := FmtID;
end;

constructor _ICONINFOWrapper.Create(ARecord: _ICONINFO);
begin
  inherited Create;
  FfIcon := ARecord.fIcon;
  FxHotspot := ARecord.xHotspot;
  FyHotspot := ARecord.yHotspot;
  FhbmMask := ARecord.hbmMask;
  FhbmColor := ARecord.hbmColor;
end;

function _ICONINFOWrapper.ObjToRec: _ICONINFO;
begin
  result.fIcon := FfIcon;
  result.xHotspot := FxHotspot;
  result.yHotspot := FyHotspot;
  result.hbmMask := FhbmMask;
  result.hbmColor := FhbmColor;
end;

constructor tagCURSORSHAPEWrapper.Create(ARecord: tagCURSORSHAPE);
begin
  inherited Create;
  FxHotSpot := ARecord.xHotSpot;
  FyHotSpot := ARecord.yHotSpot;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
  FcbWidth := ARecord.cbWidth;
  FPlanes := ARecord.Planes;
  FBitsPixel := ARecord.BitsPixel;
end;

function tagCURSORSHAPEWrapper.ObjToRec: tagCURSORSHAPE;
begin
  result.xHotSpot := FxHotSpot;
  result.yHotSpot := FyHotSpot;
  result.cx := Fcx;
  result.cy := Fcy;
  result.cbWidth := FcbWidth;
  result.Planes := FPlanes;
  result.BitsPixel := FBitsPixel;
end;

constructor tagSCROLLINFOWrapper.Create(ARecord: tagSCROLLINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FfMask := ARecord.fMask;
  FnMin := ARecord.nMin;
  FnMax := ARecord.nMax;
  FnPage := ARecord.nPage;
  FnPos := ARecord.nPos;
  FnTrackPos := ARecord.nTrackPos;
end;

function tagSCROLLINFOWrapper.ObjToRec: tagSCROLLINFO;
begin
  result.cbSize := FcbSize;
  result.fMask := FfMask;
  result.nMin := FnMin;
  result.nMax := FnMax;
  result.nPage := FnPage;
  result.nPos := FnPos;
  result.nTrackPos := FnTrackPos;
end;

constructor tagMDICREATESTRUCTAWrapper.Create(ARecord: tagMDICREATESTRUCTA);
begin
  inherited Create;
  FhOwner := ARecord.hOwner;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
  Fstyle := ARecord.style;
  FlParam := ARecord.lParam;
end;

function tagMDICREATESTRUCTAWrapper.ObjToRec: tagMDICREATESTRUCTA;
begin
  result.hOwner := FhOwner;
  result.x := Fx;
  result.y := Fy;
  result.cx := Fcx;
  result.cy := Fcy;
  result.style := Fstyle;
  result.lParam := FlParam;
end;

constructor tagMDICREATESTRUCTWWrapper.Create(ARecord: tagMDICREATESTRUCTW);
begin
  inherited Create;
  FhOwner := ARecord.hOwner;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
  Fstyle := ARecord.style;
  FlParam := ARecord.lParam;
end;

function tagMDICREATESTRUCTWWrapper.ObjToRec: tagMDICREATESTRUCTW;
begin
  result.hOwner := FhOwner;
  result.x := Fx;
  result.y := Fy;
  result.cx := Fcx;
  result.cy := Fcy;
  result.style := Fstyle;
  result.lParam := FlParam;
end;

constructor tagCLIENTCREATESTRUCTWrapper.Create(ARecord: tagCLIENTCREATESTRUCT);
begin
  inherited Create;
  FhWindowMenu := ARecord.hWindowMenu;
  FidFirstChild := ARecord.idFirstChild;
end;

function tagCLIENTCREATESTRUCTWrapper.ObjToRec: tagCLIENTCREATESTRUCT;
begin
  result.hWindowMenu := FhWindowMenu;
  result.idFirstChild := FidFirstChild;
end;

constructor tagMULTIKEYHELPAWrapper.Create(ARecord: tagMULTIKEYHELPA);
begin
  inherited Create;
  FmkSize := ARecord.mkSize;
  FmkKeylist := ARecord.mkKeylist;
end;

function tagMULTIKEYHELPAWrapper.ObjToRec: tagMULTIKEYHELPA;
begin
  result.mkSize := FmkSize;
  result.mkKeylist := FmkKeylist;
end;

constructor tagMULTIKEYHELPWWrapper.Create(ARecord: tagMULTIKEYHELPW);
begin
  inherited Create;
  FmkSize := ARecord.mkSize;
end;

function tagMULTIKEYHELPWWrapper.ObjToRec: tagMULTIKEYHELPW;
begin
  result.mkSize := FmkSize;
end;

constructor tagHELPWININFOAWrapper.Create(ARecord: tagHELPWININFOA);
begin
  inherited Create;
  FwStructSize := ARecord.wStructSize;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fdx := ARecord.dx;
  Fdy := ARecord.dy;
  FwMax := ARecord.wMax;
end;

function tagHELPWININFOAWrapper.ObjToRec: tagHELPWININFOA;
begin
  result.wStructSize := FwStructSize;
  result.x := Fx;
  result.y := Fy;
  result.dx := Fdx;
  result.dy := Fdy;
  result.wMax := FwMax;
end;

constructor tagHELPWININFOWWrapper.Create(ARecord: tagHELPWININFOW);
begin
  inherited Create;
  FwStructSize := ARecord.wStructSize;
  Fx := ARecord.x;
  Fy := ARecord.y;
  Fdx := ARecord.dx;
  Fdy := ARecord.dy;
  FwMax := ARecord.wMax;
end;

function tagHELPWININFOWWrapper.ObjToRec: tagHELPWININFOW;
begin
  result.wStructSize := FwStructSize;
  result.x := Fx;
  result.y := Fy;
  result.dx := Fdx;
  result.dy := Fdy;
  result.wMax := FwMax;
end;

constructor _HHN_NOTIFYWrapper.Create(ARecord: _HHN_NOTIFY);
begin
  inherited Create;
end;

function _HHN_NOTIFYWrapper.ObjToRec: _HHN_NOTIFY;
begin
end;

constructor _HH_POPUPWrapper.Create(ARecord: _HH_POPUP);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FhInst := ARecord.hInst;
  FidString := ARecord.idString;
  FclrForeground := ARecord.clrForeground;
  FclrBackground := ARecord.clrBackground;
end;

function _HH_POPUPWrapper.ObjToRec: _HH_POPUP;
begin
  result.cbStruct := FcbStruct;
  result.hInst := FhInst;
  result.idString := FidString;
  result.clrForeground := FclrForeground;
  result.clrBackground := FclrBackground;
end;

constructor _HH_AKLINKWrapper.Create(ARecord: _HH_AKLINK);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FfReserved := ARecord.fReserved;
  FfIndexOnFail := ARecord.fIndexOnFail;
end;

function _HH_AKLINKWrapper.ObjToRec: _HH_AKLINK;
begin
  result.cbStruct := FcbStruct;
  result.fReserved := FfReserved;
  result.fIndexOnFail := FfIndexOnFail;
end;

constructor _HH_ENUM_ITWrapper.Create(ARecord: _HH_ENUM_IT);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FiType := ARecord.iType;
end;

function _HH_ENUM_ITWrapper.ObjToRec: _HH_ENUM_IT;
begin
  result.cbStruct := FcbStruct;
  result.iType := FiType;
end;

constructor _HH_ENUM_CATWrapper.Create(ARecord: _HH_ENUM_CAT);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
end;

function _HH_ENUM_CATWrapper.ObjToRec: _HH_ENUM_CAT;
begin
  result.cbStruct := FcbStruct;
end;

constructor _HH_SET_INFOTYPEWrapper.Create(ARecord: _HH_SET_INFOTYPE);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
end;

function _HH_SET_INFOTYPEWrapper.ObjToRec: _HH_SET_INFOTYPE;
begin
  result.cbStruct := FcbStruct;
end;

constructor _HH_FTS_QUERYWrapper.Create(ARecord: _HH_FTS_QUERY);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FfUniCodeStrings := ARecord.fUniCodeStrings;
  FiProximity := ARecord.iProximity;
  FfStemmedSearch := ARecord.fStemmedSearch;
  FfTitleOnly := ARecord.fTitleOnly;
  FfExecute := ARecord.fExecute;
end;

function _HH_FTS_QUERYWrapper.ObjToRec: _HH_FTS_QUERY;
begin
  result.cbStruct := FcbStruct;
  result.fUniCodeStrings := FfUniCodeStrings;
  result.iProximity := FiProximity;
  result.fStemmedSearch := FfStemmedSearch;
  result.fTitleOnly := FfTitleOnly;
  result.fExecute := FfExecute;
end;

constructor _HH_WINTYPEWrapper.Create(ARecord: _HH_WINTYPE);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FfUniCodeStrings := ARecord.fUniCodeStrings;
  FfsValidMembers := ARecord.fsValidMembers;
  FfsWinProperties := ARecord.fsWinProperties;
  FdwStyles := ARecord.dwStyles;
  FdwExStyles := ARecord.dwExStyles;
  FnShowState := ARecord.nShowState;
  FhwndHelp := ARecord.hwndHelp;
  FhwndCaller := ARecord.hwndCaller;
  FhwndToolBar := ARecord.hwndToolBar;
  FhwndNavigation := ARecord.hwndNavigation;
  FhwndHTML := ARecord.hwndHTML;
  FiNavWidth := ARecord.iNavWidth;
  FfsToolBarFlags := ARecord.fsToolBarFlags;
  FfNotExpanded := ARecord.fNotExpanded;
  FcurNavType := ARecord.curNavType;
  FtabPos := ARecord.tabPos;
  FidNotify := ARecord.idNotify;
  FcHistory := ARecord.cHistory;
  FcbInfoTYpes := ARecord.cbInfoTYpes;
  FpszCustomTabs := ARecord.pszCustomTabs;
end;

function _HH_WINTYPEWrapper.ObjToRec: _HH_WINTYPE;
begin
  result.cbStruct := FcbStruct;
  result.fUniCodeStrings := FfUniCodeStrings;
  result.fsValidMembers := FfsValidMembers;
  result.fsWinProperties := FfsWinProperties;
  result.dwStyles := FdwStyles;
  result.dwExStyles := FdwExStyles;
  result.nShowState := FnShowState;
  result.hwndHelp := FhwndHelp;
  result.hwndCaller := FhwndCaller;
  result.hwndToolBar := FhwndToolBar;
  result.hwndNavigation := FhwndNavigation;
  result.hwndHTML := FhwndHTML;
  result.iNavWidth := FiNavWidth;
  result.fsToolBarFlags := FfsToolBarFlags;
  result.fNotExpanded := FfNotExpanded;
  result.curNavType := FcurNavType;
  result.tabPos := FtabPos;
  result.idNotify := FidNotify;
  result.cHistory := FcHistory;
  result.cbInfoTYpes := FcbInfoTYpes;
  result.pszCustomTabs := FpszCustomTabs;
end;

constructor _HH_NTRACKWrapper.Create(ARecord: _HH_NTRACK);
begin
  inherited Create;
  FidAction := ARecord.idAction;
end;

function _HH_NTRACKWrapper.ObjToRec: _HH_NTRACK;
begin
  result.idAction := FidAction;
end;

constructor tagNONCLIENTMETRICSAWrapper.Create(ARecord: tagNONCLIENTMETRICSA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiBorderWidth := ARecord.iBorderWidth;
  FiScrollWidth := ARecord.iScrollWidth;
  FiScrollHeight := ARecord.iScrollHeight;
  FiCaptionWidth := ARecord.iCaptionWidth;
  FiCaptionHeight := ARecord.iCaptionHeight;
  FiSmCaptionWidth := ARecord.iSmCaptionWidth;
  FiSmCaptionHeight := ARecord.iSmCaptionHeight;
  FiMenuWidth := ARecord.iMenuWidth;
  FiMenuHeight := ARecord.iMenuHeight;
end;

function tagNONCLIENTMETRICSAWrapper.ObjToRec: tagNONCLIENTMETRICSA;
begin
  result.cbSize := FcbSize;
  result.iBorderWidth := FiBorderWidth;
  result.iScrollWidth := FiScrollWidth;
  result.iScrollHeight := FiScrollHeight;
  result.iCaptionWidth := FiCaptionWidth;
  result.iCaptionHeight := FiCaptionHeight;
  result.iSmCaptionWidth := FiSmCaptionWidth;
  result.iSmCaptionHeight := FiSmCaptionHeight;
  result.iMenuWidth := FiMenuWidth;
  result.iMenuHeight := FiMenuHeight;
end;

constructor tagNONCLIENTMETRICSWWrapper.Create(ARecord: tagNONCLIENTMETRICSW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiBorderWidth := ARecord.iBorderWidth;
  FiScrollWidth := ARecord.iScrollWidth;
  FiScrollHeight := ARecord.iScrollHeight;
  FiCaptionWidth := ARecord.iCaptionWidth;
  FiCaptionHeight := ARecord.iCaptionHeight;
  FiSmCaptionWidth := ARecord.iSmCaptionWidth;
  FiSmCaptionHeight := ARecord.iSmCaptionHeight;
  FiMenuWidth := ARecord.iMenuWidth;
  FiMenuHeight := ARecord.iMenuHeight;
end;

function tagNONCLIENTMETRICSWWrapper.ObjToRec: tagNONCLIENTMETRICSW;
begin
  result.cbSize := FcbSize;
  result.iBorderWidth := FiBorderWidth;
  result.iScrollWidth := FiScrollWidth;
  result.iScrollHeight := FiScrollHeight;
  result.iCaptionWidth := FiCaptionWidth;
  result.iCaptionHeight := FiCaptionHeight;
  result.iSmCaptionWidth := FiSmCaptionWidth;
  result.iSmCaptionHeight := FiSmCaptionHeight;
  result.iMenuWidth := FiMenuWidth;
  result.iMenuHeight := FiMenuHeight;
end;

constructor tagMINIMIZEDMETRICSWrapper.Create(ARecord: tagMINIMIZEDMETRICS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiWidth := ARecord.iWidth;
  FiHorzGap := ARecord.iHorzGap;
  FiVertGap := ARecord.iVertGap;
  FiArrange := ARecord.iArrange;
end;

function tagMINIMIZEDMETRICSWrapper.ObjToRec: tagMINIMIZEDMETRICS;
begin
  result.cbSize := FcbSize;
  result.iWidth := FiWidth;
  result.iHorzGap := FiHorzGap;
  result.iVertGap := FiVertGap;
  result.iArrange := FiArrange;
end;

constructor tagICONMETRICSAWrapper.Create(ARecord: tagICONMETRICSA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiHorzSpacing := ARecord.iHorzSpacing;
  FiVertSpacing := ARecord.iVertSpacing;
  FiTitleWrap := ARecord.iTitleWrap;
end;

function tagICONMETRICSAWrapper.ObjToRec: tagICONMETRICSA;
begin
  result.cbSize := FcbSize;
  result.iHorzSpacing := FiHorzSpacing;
  result.iVertSpacing := FiVertSpacing;
  result.iTitleWrap := FiTitleWrap;
end;

constructor tagICONMETRICSWWrapper.Create(ARecord: tagICONMETRICSW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiHorzSpacing := ARecord.iHorzSpacing;
  FiVertSpacing := ARecord.iVertSpacing;
  FiTitleWrap := ARecord.iTitleWrap;
end;

function tagICONMETRICSWWrapper.ObjToRec: tagICONMETRICSW;
begin
  result.cbSize := FcbSize;
  result.iHorzSpacing := FiHorzSpacing;
  result.iVertSpacing := FiVertSpacing;
  result.iTitleWrap := FiTitleWrap;
end;

constructor tagANIMATIONINFOWrapper.Create(ARecord: tagANIMATIONINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FiMinAnimate := ARecord.iMinAnimate;
end;

function tagANIMATIONINFOWrapper.ObjToRec: tagANIMATIONINFO;
begin
  result.cbSize := FcbSize;
  result.iMinAnimate := FiMinAnimate;
end;

constructor tagSERIALKEYSAWrapper.Create(ARecord: tagSERIALKEYSA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiBaudRate := ARecord.iBaudRate;
  FiPortState := ARecord.iPortState;
  FiActive := ARecord.iActive;
end;

function tagSERIALKEYSAWrapper.ObjToRec: tagSERIALKEYSA;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iBaudRate := FiBaudRate;
  result.iPortState := FiPortState;
  result.iActive := FiActive;
end;

constructor tagSERIALKEYSWWrapper.Create(ARecord: tagSERIALKEYSW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiBaudRate := ARecord.iBaudRate;
  FiPortState := ARecord.iPortState;
  FiActive := ARecord.iActive;
end;

function tagSERIALKEYSWWrapper.ObjToRec: tagSERIALKEYSW;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iBaudRate := FiBaudRate;
  result.iPortState := FiPortState;
  result.iActive := FiActive;
end;

constructor tagHIGHCONTRASTAWrapper.Create(ARecord: tagHIGHCONTRASTA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagHIGHCONTRASTAWrapper.ObjToRec: tagHIGHCONTRASTA;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagHIGHCONTRASTWWrapper.Create(ARecord: tagHIGHCONTRASTW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagHIGHCONTRASTWWrapper.ObjToRec: tagHIGHCONTRASTW;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagFILTERKEYSWrapper.Create(ARecord: tagFILTERKEYS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiWaitMSec := ARecord.iWaitMSec;
  FiDelayMSec := ARecord.iDelayMSec;
  FiRepeatMSec := ARecord.iRepeatMSec;
  FiBounceMSec := ARecord.iBounceMSec;
end;

function tagFILTERKEYSWrapper.ObjToRec: tagFILTERKEYS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iWaitMSec := FiWaitMSec;
  result.iDelayMSec := FiDelayMSec;
  result.iRepeatMSec := FiRepeatMSec;
  result.iBounceMSec := FiBounceMSec;
end;

constructor tagSTICKYKEYSWrapper.Create(ARecord: tagSTICKYKEYS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagSTICKYKEYSWrapper.ObjToRec: tagSTICKYKEYS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagMOUSEKEYSWrapper.Create(ARecord: tagMOUSEKEYS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiMaxSpeed := ARecord.iMaxSpeed;
  FiTimeToMaxSpeed := ARecord.iTimeToMaxSpeed;
  FiCtrlSpeed := ARecord.iCtrlSpeed;
  FdwReserved1 := ARecord.dwReserved1;
  FdwReserved2 := ARecord.dwReserved2;
end;

function tagMOUSEKEYSWrapper.ObjToRec: tagMOUSEKEYS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iMaxSpeed := FiMaxSpeed;
  result.iTimeToMaxSpeed := FiTimeToMaxSpeed;
  result.iCtrlSpeed := FiCtrlSpeed;
  result.dwReserved1 := FdwReserved1;
  result.dwReserved2 := FdwReserved2;
end;

constructor tagACCESSTIMEOUTWrapper.Create(ARecord: tagACCESSTIMEOUT);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiTimeOutMSec := ARecord.iTimeOutMSec;
end;

function tagACCESSTIMEOUTWrapper.ObjToRec: tagACCESSTIMEOUT;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iTimeOutMSec := FiTimeOutMSec;
end;

constructor tagSOUNDSENTRYAWrapper.Create(ARecord: tagSOUNDSENTRYA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiFSTextEffect := ARecord.iFSTextEffect;
  FiFSTextEffectMSec := ARecord.iFSTextEffectMSec;
  FiFSTextEffectColorBits := ARecord.iFSTextEffectColorBits;
  FiFSGrafEffect := ARecord.iFSGrafEffect;
  FiFSGrafEffectMSec := ARecord.iFSGrafEffectMSec;
  FiFSGrafEffectColor := ARecord.iFSGrafEffectColor;
  FiWindowsEffect := ARecord.iWindowsEffect;
  FiWindowsEffectMSec := ARecord.iWindowsEffectMSec;
  FiWindowsEffectOrdinal := ARecord.iWindowsEffectOrdinal;
end;

function tagSOUNDSENTRYAWrapper.ObjToRec: tagSOUNDSENTRYA;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iFSTextEffect := FiFSTextEffect;
  result.iFSTextEffectMSec := FiFSTextEffectMSec;
  result.iFSTextEffectColorBits := FiFSTextEffectColorBits;
  result.iFSGrafEffect := FiFSGrafEffect;
  result.iFSGrafEffectMSec := FiFSGrafEffectMSec;
  result.iFSGrafEffectColor := FiFSGrafEffectColor;
  result.iWindowsEffect := FiWindowsEffect;
  result.iWindowsEffectMSec := FiWindowsEffectMSec;
  result.iWindowsEffectOrdinal := FiWindowsEffectOrdinal;
end;

constructor tagSOUNDSENTRYWWrapper.Create(ARecord: tagSOUNDSENTRYW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
  FiFSTextEffect := ARecord.iFSTextEffect;
  FiFSTextEffectMSec := ARecord.iFSTextEffectMSec;
  FiFSTextEffectColorBits := ARecord.iFSTextEffectColorBits;
  FiFSGrafEffect := ARecord.iFSGrafEffect;
  FiFSGrafEffectMSec := ARecord.iFSGrafEffectMSec;
  FiFSGrafEffectColor := ARecord.iFSGrafEffectColor;
  FiWindowsEffect := ARecord.iWindowsEffect;
  FiWindowsEffectMSec := ARecord.iWindowsEffectMSec;
  FiWindowsEffectOrdinal := ARecord.iWindowsEffectOrdinal;
end;

function tagSOUNDSENTRYWWrapper.ObjToRec: tagSOUNDSENTRYW;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
  result.iFSTextEffect := FiFSTextEffect;
  result.iFSTextEffectMSec := FiFSTextEffectMSec;
  result.iFSTextEffectColorBits := FiFSTextEffectColorBits;
  result.iFSGrafEffect := FiFSGrafEffect;
  result.iFSGrafEffectMSec := FiFSGrafEffectMSec;
  result.iFSGrafEffectColor := FiFSGrafEffectColor;
  result.iWindowsEffect := FiWindowsEffect;
  result.iWindowsEffectMSec := FiWindowsEffectMSec;
  result.iWindowsEffectOrdinal := FiWindowsEffectOrdinal;
end;

constructor tagTOGGLEKEYSWrapper.Create(ARecord: tagTOGGLEKEYS);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwFlags := ARecord.dwFlags;
end;

function tagTOGGLEKEYSWrapper.ObjToRec: tagTOGGLEKEYS;
begin
  result.cbSize := FcbSize;
  result.dwFlags := FdwFlags;
end;

constructor tagGUITHREADINFOWrapper.Create(ARecord: tagGUITHREADINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fflags := ARecord.flags;
  FhwndActive := ARecord.hwndActive;
  FhwndFocus := ARecord.hwndFocus;
  FhwndCapture := ARecord.hwndCapture;
  FhwndMenuOwner := ARecord.hwndMenuOwner;
  FhwndMoveSize := ARecord.hwndMoveSize;
  FhwndCaret := ARecord.hwndCaret;
end;

function tagGUITHREADINFOWrapper.ObjToRec: tagGUITHREADINFO;
begin
  result.cbSize := FcbSize;
  result.flags := Fflags;
  result.hwndActive := FhwndActive;
  result.hwndFocus := FhwndFocus;
  result.hwndCapture := FhwndCapture;
  result.hwndMenuOwner := FhwndMenuOwner;
  result.hwndMoveSize := FhwndMoveSize;
  result.hwndCaret := FhwndCaret;
end;

constructor tagCURSORINFOWrapper.Create(ARecord: tagCURSORINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  Fflags := ARecord.flags;
  FhCursor := ARecord.hCursor;
end;

function tagCURSORINFOWrapper.ObjToRec: tagCURSORINFO;
begin
  result.cbSize := FcbSize;
  result.flags := Fflags;
  result.hCursor := FhCursor;
end;

constructor tagWINDOWINFOWrapper.Create(ARecord: tagWINDOWINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwStyle := ARecord.dwStyle;
  FdwExStyle := ARecord.dwExStyle;
  FdwOtherStuff := ARecord.dwOtherStuff;
  FcxWindowBorders := ARecord.cxWindowBorders;
  FcyWindowBorders := ARecord.cyWindowBorders;
  FatomWindowType := ARecord.atomWindowType;
  FwCreatorVersion := ARecord.wCreatorVersion;
end;

function tagWINDOWINFOWrapper.ObjToRec: tagWINDOWINFO;
begin
  result.cbSize := FcbSize;
  result.dwStyle := FdwStyle;
  result.dwExStyle := FdwExStyle;
  result.dwOtherStuff := FdwOtherStuff;
  result.cxWindowBorders := FcxWindowBorders;
  result.cyWindowBorders := FcyWindowBorders;
  result.atomWindowType := FatomWindowType;
  result.wCreatorVersion := FwCreatorVersion;
end;

constructor tagTITLEBARINFOWrapper.Create(ARecord: tagTITLEBARINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
end;

function tagTITLEBARINFOWrapper.ObjToRec: tagTITLEBARINFO;
begin
  result.cbSize := FcbSize;
end;

constructor tagMENUBARINFOWrapper.Create(ARecord: tagMENUBARINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FhMenu := ARecord.hMenu;
  FhwndMenu := ARecord.hwndMenu;
  FFocusedBits := ARecord.FocusedBits;
end;

function tagMENUBARINFOWrapper.ObjToRec: tagMENUBARINFO;
begin
  result.cbSize := FcbSize;
  result.hMenu := FhMenu;
  result.hwndMenu := FhwndMenu;
  result.FocusedBits := FFocusedBits;
end;

constructor tagSCROLLBARINFOWrapper.Create(ARecord: tagSCROLLBARINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdxyLineButton := ARecord.dxyLineButton;
  FxyThumbTop := ARecord.xyThumbTop;
  FxyThumbBottom := ARecord.xyThumbBottom;
  Fbogus := ARecord.bogus;
end;

function tagSCROLLBARINFOWrapper.ObjToRec: tagSCROLLBARINFO;
begin
  result.cbSize := FcbSize;
  result.dxyLineButton := FdxyLineButton;
  result.xyThumbTop := FxyThumbTop;
  result.xyThumbBottom := FxyThumbBottom;
  result.bogus := Fbogus;
end;

constructor tagCOMBOBOXINFOWrapper.Create(ARecord: tagCOMBOBOXINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FstateButton := ARecord.stateButton;
  FhwndCombo := ARecord.hwndCombo;
  FhwndItem := ARecord.hwndItem;
  FhwndList := ARecord.hwndList;
end;

function tagCOMBOBOXINFOWrapper.ObjToRec: tagCOMBOBOXINFO;
begin
  result.cbSize := FcbSize;
  result.stateButton := FstateButton;
  result.hwndCombo := FhwndCombo;
  result.hwndItem := FhwndItem;
  result.hwndList := FhwndList;
end;

constructor tagALTTABINFOWrapper.Create(ARecord: tagALTTABINFO);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FcItems := ARecord.cItems;
  FcColumns := ARecord.cColumns;
  FcRows := ARecord.cRows;
  FiColFocus := ARecord.iColFocus;
  FiRowFocus := ARecord.iRowFocus;
  FcxItem := ARecord.cxItem;
  FcyItem := ARecord.cyItem;
end;

function tagALTTABINFOWrapper.ObjToRec: tagALTTABINFO;
begin
  result.cbSize := FcbSize;
  result.cItems := FcItems;
  result.cColumns := FcColumns;
  result.cRows := FcRows;
  result.iColFocus := FiColFocus;
  result.iRowFocus := FiRowFocus;
  result.cxItem := FcxItem;
  result.cyItem := FcyItem;
end;

constructor _cpinfoWrapper.Create(ARecord: _cpinfo);
begin
  inherited Create;
  FMaxCharSize := ARecord.MaxCharSize;
end;

function _cpinfoWrapper.ObjToRec: _cpinfo;
begin
  result.MaxCharSize := FMaxCharSize;
end;

constructor _numberfmtAWrapper.Create(ARecord: _numberfmtA);
begin
  inherited Create;
  FNumDigits := ARecord.NumDigits;
  FLeadingZero := ARecord.LeadingZero;
  FGrouping := ARecord.Grouping;
  FNegativeOrder := ARecord.NegativeOrder;
end;

function _numberfmtAWrapper.ObjToRec: _numberfmtA;
begin
  result.NumDigits := FNumDigits;
  result.LeadingZero := FLeadingZero;
  result.Grouping := FGrouping;
  result.NegativeOrder := FNegativeOrder;
end;

constructor _numberfmtWWrapper.Create(ARecord: _numberfmtW);
begin
  inherited Create;
  FNumDigits := ARecord.NumDigits;
  FLeadingZero := ARecord.LeadingZero;
  FGrouping := ARecord.Grouping;
  FNegativeOrder := ARecord.NegativeOrder;
end;

function _numberfmtWWrapper.ObjToRec: _numberfmtW;
begin
  result.NumDigits := FNumDigits;
  result.LeadingZero := FLeadingZero;
  result.Grouping := FGrouping;
  result.NegativeOrder := FNegativeOrder;
end;

constructor _currencyfmtAWrapper.Create(ARecord: _currencyfmtA);
begin
  inherited Create;
  FNumDigits := ARecord.NumDigits;
  FLeadingZero := ARecord.LeadingZero;
  FGrouping := ARecord.Grouping;
  FNegativeOrder := ARecord.NegativeOrder;
  FPositiveOrder := ARecord.PositiveOrder;
end;

function _currencyfmtAWrapper.ObjToRec: _currencyfmtA;
begin
  result.NumDigits := FNumDigits;
  result.LeadingZero := FLeadingZero;
  result.Grouping := FGrouping;
  result.NegativeOrder := FNegativeOrder;
  result.PositiveOrder := FPositiveOrder;
end;

constructor _currencyfmtWWrapper.Create(ARecord: _currencyfmtW);
begin
  inherited Create;
  FNumDigits := ARecord.NumDigits;
  FLeadingZero := ARecord.LeadingZero;
  FGrouping := ARecord.Grouping;
  FNegativeOrder := ARecord.NegativeOrder;
  FPositiveOrder := ARecord.PositiveOrder;
end;

function _currencyfmtWWrapper.ObjToRec: _currencyfmtW;
begin
  result.NumDigits := FNumDigits;
  result.LeadingZero := FLeadingZero;
  result.Grouping := FGrouping;
  result.NegativeOrder := FNegativeOrder;
  result.PositiveOrder := FPositiveOrder;
end;

constructor _COORDWrapper.Create(ARecord: _COORD);
begin
  inherited Create;
  FX := ARecord.X;
  FY := ARecord.Y;
end;

function _COORDWrapper.ObjToRec: _COORD;
begin
  result.X := FX;
  result.Y := FY;
end;

constructor _SMALL_RECTWrapper.Create(ARecord: _SMALL_RECT);
begin
  inherited Create;
  FLeft := ARecord.Left;
  FTop := ARecord.Top;
  FRight := ARecord.Right;
  FBottom := ARecord.Bottom;
end;

function _SMALL_RECTWrapper.ObjToRec: _SMALL_RECT;
begin
  result.Left := FLeft;
  result.Top := FTop;
  result.Right := FRight;
  result.Bottom := FBottom;
end;

constructor _KEY_EVENT_RECORDWrapper.Create(ARecord: _KEY_EVENT_RECORD);
begin
  inherited Create;
  FbKeyDown := ARecord.bKeyDown;
  FwRepeatCount := ARecord.wRepeatCount;
  FwVirtualKeyCode := ARecord.wVirtualKeyCode;
  FwVirtualScanCode := ARecord.wVirtualScanCode;
  FdwControlKeyState := ARecord.dwControlKeyState;
  FAsciiChar := ARecord.AsciiChar;
end;

function _KEY_EVENT_RECORDWrapper.ObjToRec: _KEY_EVENT_RECORD;
begin
  result.bKeyDown := FbKeyDown;
  result.wRepeatCount := FwRepeatCount;
  result.wVirtualKeyCode := FwVirtualKeyCode;
  result.wVirtualScanCode := FwVirtualScanCode;
  result.dwControlKeyState := FdwControlKeyState;
  result.AsciiChar := FAsciiChar;
end;

constructor _MOUSE_EVENT_RECORDWrapper.Create(ARecord: _MOUSE_EVENT_RECORD);
begin
  inherited Create;
  FdwButtonState := ARecord.dwButtonState;
  FdwControlKeyState := ARecord.dwControlKeyState;
  FdwEventFlags := ARecord.dwEventFlags;
end;

function _MOUSE_EVENT_RECORDWrapper.ObjToRec: _MOUSE_EVENT_RECORD;
begin
  result.dwButtonState := FdwButtonState;
  result.dwControlKeyState := FdwControlKeyState;
  result.dwEventFlags := FdwEventFlags;
end;

constructor _WINDOW_BUFFER_SIZE_RECORDWrapper.Create(ARecord: _WINDOW_BUFFER_SIZE_RECORD);
begin
  inherited Create;
end;

function _WINDOW_BUFFER_SIZE_RECORDWrapper.ObjToRec: _WINDOW_BUFFER_SIZE_RECORD;
begin
end;

constructor _MENU_EVENT_RECORDWrapper.Create(ARecord: _MENU_EVENT_RECORD);
begin
  inherited Create;
  FdwCommandId := ARecord.dwCommandId;
end;

function _MENU_EVENT_RECORDWrapper.ObjToRec: _MENU_EVENT_RECORD;
begin
  result.dwCommandId := FdwCommandId;
end;

constructor _FOCUS_EVENT_RECORDWrapper.Create(ARecord: _FOCUS_EVENT_RECORD);
begin
  inherited Create;
  FbSetFocus := ARecord.bSetFocus;
end;

function _FOCUS_EVENT_RECORDWrapper.ObjToRec: _FOCUS_EVENT_RECORD;
begin
  result.bSetFocus := FbSetFocus;
end;

constructor _INPUT_RECORDWrapper.Create(ARecord: _INPUT_RECORD);
begin
  inherited Create;
  FEventType := ARecord.EventType;
  FReserved := ARecord.Reserved;
end;

function _INPUT_RECORDWrapper.ObjToRec: _INPUT_RECORD;
begin
  result.EventType := FEventType;
  result.Reserved := FReserved;
end;

constructor _CHAR_INFOWrapper.Create(ARecord: _CHAR_INFO);
begin
  inherited Create;
  FAttributes := ARecord.Attributes;
  FAsciiChar := ARecord.AsciiChar;
end;

function _CHAR_INFOWrapper.ObjToRec: _CHAR_INFO;
begin
  result.Attributes := FAttributes;
  result.AsciiChar := FAsciiChar;
end;

constructor _CONSOLE_SCREEN_BUFFER_INFOWrapper.Create(ARecord: _CONSOLE_SCREEN_BUFFER_INFO);
begin
  inherited Create;
  FwAttributes := ARecord.wAttributes;
end;

function _CONSOLE_SCREEN_BUFFER_INFOWrapper.ObjToRec: _CONSOLE_SCREEN_BUFFER_INFO;
begin
  result.wAttributes := FwAttributes;
end;

constructor _CONSOLE_CURSOR_INFOWrapper.Create(ARecord: _CONSOLE_CURSOR_INFO);
begin
  inherited Create;
  FdwSize := ARecord.dwSize;
  FbVisible := ARecord.bVisible;
end;

function _CONSOLE_CURSOR_INFOWrapper.ObjToRec: _CONSOLE_CURSOR_INFO;
begin
  result.dwSize := FdwSize;
  result.bVisible := FbVisible;
end;

constructor tagVS_FIXEDFILEINFOWrapper.Create(ARecord: tagVS_FIXEDFILEINFO);
begin
  inherited Create;
  FdwSignature := ARecord.dwSignature;
  FdwStrucVersion := ARecord.dwStrucVersion;
  FdwFileVersionMS := ARecord.dwFileVersionMS;
  FdwFileVersionLS := ARecord.dwFileVersionLS;
  FdwProductVersionMS := ARecord.dwProductVersionMS;
  FdwProductVersionLS := ARecord.dwProductVersionLS;
  FdwFileFlagsMask := ARecord.dwFileFlagsMask;
  FdwFileFlags := ARecord.dwFileFlags;
  FdwFileOS := ARecord.dwFileOS;
  FdwFileType := ARecord.dwFileType;
  FdwFileSubtype := ARecord.dwFileSubtype;
  FdwFileDateMS := ARecord.dwFileDateMS;
  FdwFileDateLS := ARecord.dwFileDateLS;
end;

function tagVS_FIXEDFILEINFOWrapper.ObjToRec: tagVS_FIXEDFILEINFO;
begin
  result.dwSignature := FdwSignature;
  result.dwStrucVersion := FdwStrucVersion;
  result.dwFileVersionMS := FdwFileVersionMS;
  result.dwFileVersionLS := FdwFileVersionLS;
  result.dwProductVersionMS := FdwProductVersionMS;
  result.dwProductVersionLS := FdwProductVersionLS;
  result.dwFileFlagsMask := FdwFileFlagsMask;
  result.dwFileFlags := FdwFileFlags;
  result.dwFileOS := FdwFileOS;
  result.dwFileType := FdwFileType;
  result.dwFileSubtype := FdwFileSubtype;
  result.dwFileDateMS := FdwFileDateMS;
  result.dwFileDateLS := FdwFileDateLS;
end;

constructor val_contextWrapper.Create(ARecord: val_context);
begin
  inherited Create;
  Fvaluelen := ARecord.valuelen;
end;

function val_contextWrapper.ObjToRec: val_context;
begin
  result.valuelen := Fvaluelen;
end;

constructor pvalueAWrapper.Create(ARecord: pvalueA);
begin
  inherited Create;
  Fpv_valuelen := ARecord.pv_valuelen;
  Fpv_type := ARecord.pv_type;
end;

function pvalueAWrapper.ObjToRec: pvalueA;
begin
  result.pv_valuelen := Fpv_valuelen;
  result.pv_type := Fpv_type;
end;

constructor pvalueWWrapper.Create(ARecord: pvalueW);
begin
  inherited Create;
  Fpv_valuelen := ARecord.pv_valuelen;
  Fpv_type := ARecord.pv_type;
end;

function pvalueWWrapper.ObjToRec: pvalueW;
begin
  result.pv_valuelen := Fpv_valuelen;
  result.pv_type := Fpv_type;
end;

constructor provider_infoWrapper.Create(ARecord: provider_info);
begin
  inherited Create;
  Fpi_flags := ARecord.pi_flags;
end;

function provider_infoWrapper.ObjToRec: provider_info;
begin
  result.pi_flags := Fpi_flags;
end;

constructor value_entAWrapper.Create(ARecord: value_entA);
begin
  inherited Create;
  Fve_valuelen := ARecord.ve_valuelen;
  Fve_valueptr := ARecord.ve_valueptr;
  Fve_type := ARecord.ve_type;
end;

function value_entAWrapper.ObjToRec: value_entA;
begin
  result.ve_valuelen := Fve_valuelen;
  result.ve_valueptr := Fve_valueptr;
  result.ve_type := Fve_type;
end;

constructor value_entWWrapper.Create(ARecord: value_entW);
begin
  inherited Create;
  Fve_valuelen := ARecord.ve_valuelen;
  Fve_valueptr := ARecord.ve_valueptr;
  Fve_type := ARecord.ve_type;
end;

function value_entWWrapper.ObjToRec: value_entW;
begin
  result.ve_valuelen := Fve_valuelen;
  result.ve_valueptr := Fve_valueptr;
  result.ve_type := Fve_type;
end;

constructor _NETRESOURCEAWrapper.Create(ARecord: _NETRESOURCEA);
begin
  inherited Create;
  FdwScope := ARecord.dwScope;
  FdwType := ARecord.dwType;
  FdwDisplayType := ARecord.dwDisplayType;
  FdwUsage := ARecord.dwUsage;
end;

function _NETRESOURCEAWrapper.ObjToRec: _NETRESOURCEA;
begin
  result.dwScope := FdwScope;
  result.dwType := FdwType;
  result.dwDisplayType := FdwDisplayType;
  result.dwUsage := FdwUsage;
end;

constructor _NETRESOURCEWWrapper.Create(ARecord: _NETRESOURCEW);
begin
  inherited Create;
  FdwScope := ARecord.dwScope;
  FdwType := ARecord.dwType;
  FdwDisplayType := ARecord.dwDisplayType;
  FdwUsage := ARecord.dwUsage;
end;

function _NETRESOURCEWWrapper.ObjToRec: _NETRESOURCEW;
begin
  result.dwScope := FdwScope;
  result.dwType := FdwType;
  result.dwDisplayType := FdwDisplayType;
  result.dwUsage := FdwUsage;
end;

constructor _CONNECTDLGSTRUCTAWrapper.Create(ARecord: _CONNECTDLGSTRUCTA);
begin
  inherited Create;
  FcbStructure := ARecord.cbStructure;
  FhwndOwner := ARecord.hwndOwner;
  FdwFlags := ARecord.dwFlags;
  FdwDevNum := ARecord.dwDevNum;
end;

function _CONNECTDLGSTRUCTAWrapper.ObjToRec: _CONNECTDLGSTRUCTA;
begin
  result.cbStructure := FcbStructure;
  result.hwndOwner := FhwndOwner;
  result.dwFlags := FdwFlags;
  result.dwDevNum := FdwDevNum;
end;

constructor _DISCDLGSTRUCTAWrapper.Create(ARecord: _DISCDLGSTRUCTA);
begin
  inherited Create;
  FcbStructure := ARecord.cbStructure;
  FhwndOwner := ARecord.hwndOwner;
  FdwFlags := ARecord.dwFlags;
end;

function _DISCDLGSTRUCTAWrapper.ObjToRec: _DISCDLGSTRUCTA;
begin
  result.cbStructure := FcbStructure;
  result.hwndOwner := FhwndOwner;
  result.dwFlags := FdwFlags;
end;

constructor _DISCDLGSTRUCTWWrapper.Create(ARecord: _DISCDLGSTRUCTW);
begin
  inherited Create;
  FcbStructure := ARecord.cbStructure;
  FhwndOwner := ARecord.hwndOwner;
  FdwFlags := ARecord.dwFlags;
end;

function _DISCDLGSTRUCTWWrapper.ObjToRec: _DISCDLGSTRUCTW;
begin
  result.cbStructure := FcbStructure;
  result.hwndOwner := FhwndOwner;
  result.dwFlags := FdwFlags;
end;

constructor _UNIVERSAL_NAME_INFOAWrapper.Create(ARecord: _UNIVERSAL_NAME_INFOA);
begin
  inherited Create;
end;

function _UNIVERSAL_NAME_INFOAWrapper.ObjToRec: _UNIVERSAL_NAME_INFOA;
begin
end;

constructor _UNIVERSAL_NAME_INFOWWrapper.Create(ARecord: _UNIVERSAL_NAME_INFOW);
begin
  inherited Create;
end;

function _UNIVERSAL_NAME_INFOWWrapper.ObjToRec: _UNIVERSAL_NAME_INFOW;
begin
end;

constructor _REMOTE_NAME_INFOAWrapper.Create(ARecord: _REMOTE_NAME_INFOA);
begin
  inherited Create;
end;

function _REMOTE_NAME_INFOAWrapper.ObjToRec: _REMOTE_NAME_INFOA;
begin
end;

constructor _REMOTE_NAME_INFOWWrapper.Create(ARecord: _REMOTE_NAME_INFOW);
begin
  inherited Create;
end;

function _REMOTE_NAME_INFOWWrapper.ObjToRec: _REMOTE_NAME_INFOW;
begin
end;

constructor _NETINFOSTRUCTWrapper.Create(ARecord: _NETINFOSTRUCT);
begin
  inherited Create;
  FcbStructure := ARecord.cbStructure;
  FdwProviderVersion := ARecord.dwProviderVersion;
  FdwStatus := ARecord.dwStatus;
  FdwCharacteristics := ARecord.dwCharacteristics;
  FdwHandle := ARecord.dwHandle;
  FwNetType := ARecord.wNetType;
  FdwPrinters := ARecord.dwPrinters;
  FdwDrives := ARecord.dwDrives;
end;

function _NETINFOSTRUCTWrapper.ObjToRec: _NETINFOSTRUCT;
begin
  result.cbStructure := FcbStructure;
  result.dwProviderVersion := FdwProviderVersion;
  result.dwStatus := FdwStatus;
  result.dwCharacteristics := FdwCharacteristics;
  result.dwHandle := FdwHandle;
  result.wNetType := FwNetType;
  result.dwPrinters := FdwPrinters;
  result.dwDrives := FdwDrives;
end;

constructor _NETCONNECTINFOSTRUCTWrapper.Create(ARecord: _NETCONNECTINFOSTRUCT);
begin
  inherited Create;
  FcbStructure := ARecord.cbStructure;
  FdwFlags := ARecord.dwFlags;
  FdwSpeed := ARecord.dwSpeed;
  FdwDelay := ARecord.dwDelay;
  FdwOptDataSize := ARecord.dwOptDataSize;
end;

function _NETCONNECTINFOSTRUCTWrapper.ObjToRec: _NETCONNECTINFOSTRUCT;
begin
  result.cbStructure := FcbStructure;
  result.dwFlags := FdwFlags;
  result.dwSpeed := FdwSpeed;
  result.dwDelay := FdwDelay;
  result.dwOptDataSize := FdwOptDataSize;
end;

constructor DDEACKWrapper.Create(ARecord: DDEACK);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function DDEACKWrapper.ObjToRec: DDEACK;
begin
  result.Flags := FFlags;
end;

constructor DDEADVISEWrapper.Create(ARecord: DDEADVISE);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FcfFormat := ARecord.cfFormat;
end;

function DDEADVISEWrapper.ObjToRec: DDEADVISE;
begin
  result.Flags := FFlags;
  result.cfFormat := FcfFormat;
end;

constructor DDEDATAWrapper.Create(ARecord: DDEDATA);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FcfFormat := ARecord.cfFormat;
end;

function DDEDATAWrapper.ObjToRec: DDEDATA;
begin
  result.Flags := FFlags;
  result.cfFormat := FcfFormat;
end;

constructor DDEPOKEWrapper.Create(ARecord: DDEPOKE);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FcfFormat := ARecord.cfFormat;
end;

function DDEPOKEWrapper.ObjToRec: DDEPOKE;
begin
  result.Flags := FFlags;
  result.cfFormat := FcfFormat;
end;



procedure TatWindowsLibrary.__GetCurrentTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetCurrentTime);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FreeModule(AMachine: TatVirtualMachine);
  var
  Param0: HINST;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Windows.FreeModule(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatWindowsLibrary.__InterlockedCompareExchange(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(Windows.InterlockedCompareExchange(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatWindowsLibrary.__InterlockedExchangeAdd(AMachine: TatVirtualMachine);
  var
  Param0: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := Integer(Windows.InterlockedExchangeAdd(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatWindowsLibrary.__FreeLibrary(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.FreeLibrary(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__ExitProcess(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Windows.ExitProcess(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatWindowsLibrary.__ExitThread(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Windows.ExitThread(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatWindowsLibrary.__LockFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.LockFile(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__UnlockFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.UnlockFile(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetFileType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetFileType(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FindClose(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.FindClose(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CloseHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CloseHandle(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FileTimeToLocalFileTime(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _FILETIMEWrapper) then 
  Param1Rec := _FILETIMEWrapper.Create(Param1);
Param1 := _FILETIMEWrapper(Param1Rec).ObjToRec;
AResult := Windows.FileTimeToLocalFileTime(_FILETIMEWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_FILETIMEWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__FileTimeToSystemTime(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSystemTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SYSTEMTIMEWrapper) then 
  Param1Rec := _SYSTEMTIMEWrapper.Create(Param1);
Param1 := _SYSTEMTIMEWrapper(Param1Rec).ObjToRec;
AResult := Windows.FileTimeToSystemTime(_FILETIMEWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SYSTEMTIMEWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__FileTimeToDosDateTime(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Windows.FileTimeToDosDateTime(_FILETIMEWrapper(integer(GetInputArg(0))).ObjToRec,Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWindowsLibrary.__GetTickCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetTickCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__OpenFile(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOFStruct;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _OFSTRUCTWrapper) then 
  Param1Rec := _OFSTRUCTWrapper.Create(Param1);
Param1 := _OFSTRUCTWrapper(Param1Rec).ObjToRec;
AResult := Integer(Windows.OpenFile(PChar(VarToStr(GetInputArg(0))),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_OFSTRUCTWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__LoadLibrary(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.LoadLibrary(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetCommandLine(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.GetCommandLine);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FindResource(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.FindResource(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__SetCurrentDirectory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.SetCurrentDirectory(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetCurrentDirectory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetCurrentDirectory(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__RemoveDirectory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.RemoveDirectory(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetFileAttributes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetFileAttributes(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__DeleteFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.DeleteFile(PChar(VarToStr(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FindFirstFile(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TWIN32FindData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _WIN32_FIND_DATAAWrapper) then 
  Param1Rec := _WIN32_FIND_DATAAWrapper.Create(Param1);
Param1 := _WIN32_FIND_DATAAWrapper(Param1Rec).ObjToRec;
AResult := Integer(Windows.FindFirstFile(PChar(VarToStr(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_WIN32_FIND_DATAAWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__FindNextFile(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TWIN32FindData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _WIN32_FIND_DATAAWrapper) then 
  Param1Rec := _WIN32_FIND_DATAAWrapper.Create(Param1);
Param1 := _WIN32_FIND_DATAAWrapper(Param1Rec).ObjToRec;
AResult := Windows.FindNextFile(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_WIN32_FIND_DATAAWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__CopyFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CopyFile(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__MoveFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.MoveFile(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AdjustTokenPrivileges(AMachine: TatVirtualMachine);
  var
  Param4Rec: TObject;
  Param4: TTokenPrivileges;
  Param5: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is _TOKEN_PRIVILEGESWrapper) then 
  Param4Rec := _TOKEN_PRIVILEGESWrapper.Create(Param4);
Param4 := _TOKEN_PRIVILEGESWrapper(Param4Rec).ObjToRec;
Param5 := VarToInteger(GetInputArg(5));
AResult := Windows.AdjustTokenPrivileges(VarToInteger(GetInputArg(0)),GetInputArg(1),_TOKEN_PRIVILEGESWrapper(integer(GetInputArg(2))).ObjToRec,VarToInteger(GetInputArg(3)),Param4,Param5);
    ReturnOutputArg(AResult);
    SetInputArg(4,integer(_TOKEN_PRIVILEGESWrapper.Create(Param4)));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatWindowsLibrary.__CopyMetaFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CopyMetaFile(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CopyEnhMetaFile(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CopyEnhMetaFile(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__EndPath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.EndPath(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__OffsetViewportOrgEx(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Windows.OffsetViewportOrgEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatWindowsLibrary.__OffsetWindowOrgEx(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Windows.OffsetWindowOrgEx(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatWindowsLibrary.__ExitWindows(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.ExitWindows(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FlashWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.FlashWindow(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CloseWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CloseWindow(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__EndDialog(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.EndDialog(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__OpenClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.OpenClipboard(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CloseClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CloseClipboard;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetClipboardFormatName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetClipboardFormatName(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharToOem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CharToOem(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharToOemA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CharToOemA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharToOemW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CharToOemW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__OemToChar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.OemToChar(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharToOemBuff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CharToOemBuff(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharToOemBuffA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CharToOemBuffA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharToOemBuffW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.CharToOemBuffW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharUpper(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharUpper(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharUpperA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharUpperA(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharUpperW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Windows.CharUpperW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharUpperBuff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CharUpperBuff(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharUpperBuffA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CharUpperBuffA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharUpperBuffW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CharUpperBuffW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharLower(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharLower(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharLowerA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharLowerA(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharLowerW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Windows.CharLowerW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharLowerBuff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CharLowerBuff(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharLowerBuffA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CharLowerBuffA(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharLowerBuffW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CharLowerBuffW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharNext(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharNextA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharNextA(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharNextW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Windows.CharNextW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharPrev(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharPrev(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharPrevA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharPrevA(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharPrevW(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(Windows.CharPrevW(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharNextExA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharNextExA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharNextEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharNextEx(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharPrevEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharPrevEx(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CharPrevExA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.CharPrevExA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiToOem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.AnsiToOem(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__OemToAnsi(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.OemToAnsi(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiToOemBuff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.AnsiToOemBuff(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiUpper(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.AnsiUpper(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiUpperBuff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.AnsiUpperBuff(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiLower(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.AnsiLower(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiLowerBuff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.AnsiLowerBuff(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.AnsiNext(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__AnsiPrev(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Windows.AnsiPrev(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetWindowDC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.GetWindowDC(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__MessageBox(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.MessageBox(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__MessageBoxEx(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.MessageBoxEx(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__MessageBeep(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Windows.MessageBeep(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetCaretPos(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TPoint;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TPointWrapper) then 
  Param0Rec := TPointWrapper.Create(Param0);
Param0 := TPointWrapper(Param0Rec).ObjToRec;
AResult := Windows.GetCaretPos(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TPointWrapper.Create(Param0)));
  end;
end;

procedure TatWindowsLibrary.__ClientToScreen(AMachine: TatVirtualMachine);
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
AResult := Windows.ClientToScreen(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__ScreenToClient(AMachine: TatVirtualMachine);
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
AResult := Windows.ScreenToClient(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TPointWrapper.Create(Param1)));
  end;
end;

procedure TatWindowsLibrary.__FrameRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.FrameRect(VarToInteger(GetInputArg(0)),TRectWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CopyRect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRectWrapper) then 
  Param0Rec := TRectWrapper.Create(Param0);
Param0 := TRectWrapper(Param0Rec).ObjToRec;
AResult := Windows.CopyRect(Param0,TRectWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRectWrapper.Create(Param0)));
  end;
end;

procedure TatWindowsLibrary.__FindWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.FindWindow(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__GetWindowThreadProcessId(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Windows.GetWindowThreadProcessId(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatWindowsLibrary.__CopyImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CopyImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__CopyIcon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.CopyIcon(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__LoadString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.LoadString(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__HtmlHelp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.HtmlHelp(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__HtmlHelpA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.HtmlHelpA(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__HtmlHelpW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.HtmlHelpW(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__FoldString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.FoldString(VarToInteger(GetInputArg(0)),PChar(VarToStr(GetInputArg(1))),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__RegOverridePredefKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.RegOverridePredefKey(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__RegOpenUserClassesRoot(AMachine: TatVirtualMachine);
  var
  Param3: HKEY;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(Windows.RegOpenUserClassesRoot(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWindowsLibrary.__RegOpenCurrentUser(AMachine: TatVirtualMachine);
  var
  Param1: HKEY;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(Windows.RegOpenCurrentUser(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatWindowsLibrary.__RegDisablePredefinedCache(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Windows.RegDisablePredefinedCache);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetCurrentTime',0,tkInteger,nil,__GetCurrentTime,false,0);
    DefineMethod('FreeModule',1,tkVariant,nil,__FreeModule,false,0).SetVarArgs([0]);
    DefineMethod('InterlockedCompareExchange',3,tkInteger,nil,__InterlockedCompareExchange,false,0).SetVarArgs([0]);
    DefineMethod('InterlockedExchangeAdd',2,tkInteger,nil,__InterlockedExchangeAdd,false,0).SetVarArgs([0]);
    DefineMethod('FreeLibrary',1,tkVariant,nil,__FreeLibrary,false,0);
    DefineMethod('GetVersion',0,tkInteger,nil,__GetVersion,false,0);
    DefineMethod('ExitProcess',1,tkNone,nil,__ExitProcess,false,0);
    DefineMethod('ExitThread',1,tkNone,nil,__ExitThread,false,0);
    DefineMethod('LockFile',5,tkVariant,nil,__LockFile,false,0);
    DefineMethod('UnlockFile',5,tkVariant,nil,__UnlockFile,false,0);
    DefineMethod('GetFileType',1,tkInteger,nil,__GetFileType,false,0);
    DefineMethod('FindClose',1,tkVariant,nil,__FindClose,false,0);
    DefineMethod('CloseHandle',1,tkVariant,nil,__CloseHandle,false,0);
    DefineMethod('FileTimeToLocalFileTime',2,tkVariant,nil,__FileTimeToLocalFileTime,false,0).SetVarArgs([1]);
    DefineMethod('FileTimeToSystemTime',2,tkVariant,nil,__FileTimeToSystemTime,false,0).SetVarArgs([1]);
    DefineMethod('FileTimeToDosDateTime',3,tkVariant,nil,__FileTimeToDosDateTime,false,0).SetVarArgs([1,2]);
    DefineMethod('GetTickCount',0,tkInteger,nil,__GetTickCount,false,0);
    DefineMethod('OpenFile',3,tkInteger,nil,__OpenFile,false,0).SetVarArgs([1]);
    DefineMethod('LoadLibrary',1,tkInteger,nil,__LoadLibrary,false,0);
    DefineMethod('GetCommandLine',0,tkVariant,nil,__GetCommandLine,false,0);
    DefineMethod('FindResource',3,tkInteger,nil,__FindResource,false,0);
    DefineMethod('SetCurrentDirectory',1,tkVariant,nil,__SetCurrentDirectory,false,0);
    DefineMethod('GetCurrentDirectory',2,tkInteger,nil,__GetCurrentDirectory,false,0);
    DefineMethod('RemoveDirectory',1,tkVariant,nil,__RemoveDirectory,false,0);
    DefineMethod('GetFileAttributes',1,tkInteger,nil,__GetFileAttributes,false,0);
    DefineMethod('DeleteFile',1,tkVariant,nil,__DeleteFile,false,0);
    DefineMethod('FindFirstFile',2,tkInteger,nil,__FindFirstFile,false,0).SetVarArgs([1]);
    DefineMethod('FindNextFile',2,tkVariant,nil,__FindNextFile,false,0).SetVarArgs([1]);
    DefineMethod('CopyFile',3,tkVariant,nil,__CopyFile,false,0);
    DefineMethod('MoveFile',2,tkVariant,nil,__MoveFile,false,0);
    DefineMethod('AdjustTokenPrivileges',6,tkVariant,nil,__AdjustTokenPrivileges,false,0).SetVarArgs([4,5]);
    DefineMethod('CopyMetaFile',2,tkInteger,nil,__CopyMetaFile,false,0);
    DefineMethod('CopyEnhMetaFile',2,tkInteger,nil,__CopyEnhMetaFile,false,0);
    DefineMethod('EndPath',1,tkVariant,nil,__EndPath,false,0);
    DefineMethod('OffsetViewportOrgEx',4,tkVariant,nil,__OffsetViewportOrgEx,false,0).SetVarArgs([3]);
    DefineMethod('OffsetWindowOrgEx',4,tkVariant,nil,__OffsetWindowOrgEx,false,0).SetVarArgs([3]);
    DefineMethod('ExitWindows',2,tkVariant,nil,__ExitWindows,false,0);
    DefineMethod('FlashWindow',2,tkVariant,nil,__FlashWindow,false,0);
    DefineMethod('CloseWindow',1,tkVariant,nil,__CloseWindow,false,0);
    DefineMethod('EndDialog',2,tkVariant,nil,__EndDialog,false,0);
    DefineMethod('OpenClipboard',1,tkVariant,nil,__OpenClipboard,false,0);
    DefineMethod('CloseClipboard',0,tkVariant,nil,__CloseClipboard,false,0);
    DefineMethod('GetClipboardFormatName',3,tkInteger,nil,__GetClipboardFormatName,false,0);
    DefineMethod('CharToOem',2,tkVariant,nil,__CharToOem,false,0);
    DefineMethod('CharToOemA',2,tkVariant,nil,__CharToOemA,false,0);
    DefineMethod('CharToOemW',2,tkVariant,nil,__CharToOemW,false,0);
    DefineMethod('OemToChar',2,tkVariant,nil,__OemToChar,false,0);
    DefineMethod('CharToOemBuff',3,tkVariant,nil,__CharToOemBuff,false,0);
    DefineMethod('CharToOemBuffA',3,tkVariant,nil,__CharToOemBuffA,false,0);
    DefineMethod('CharToOemBuffW',3,tkVariant,nil,__CharToOemBuffW,false,0);
    DefineMethod('CharUpper',1,tkVariant,nil,__CharUpper,false,0);
    DefineMethod('CharUpperA',1,tkVariant,nil,__CharUpperA,false,0);
    DefineMethod('CharUpperW',1,tkVariant,nil,__CharUpperW,false,0);
    DefineMethod('CharUpperBuff',2,tkInteger,nil,__CharUpperBuff,false,0);
    DefineMethod('CharUpperBuffA',2,tkInteger,nil,__CharUpperBuffA,false,0);
    DefineMethod('CharUpperBuffW',2,tkInteger,nil,__CharUpperBuffW,false,0);
    DefineMethod('CharLower',1,tkVariant,nil,__CharLower,false,0);
    DefineMethod('CharLowerA',1,tkVariant,nil,__CharLowerA,false,0);
    DefineMethod('CharLowerW',1,tkVariant,nil,__CharLowerW,false,0);
    DefineMethod('CharLowerBuff',2,tkInteger,nil,__CharLowerBuff,false,0);
    DefineMethod('CharLowerBuffA',2,tkInteger,nil,__CharLowerBuffA,false,0);
    DefineMethod('CharLowerBuffW',2,tkInteger,nil,__CharLowerBuffW,false,0);
    DefineMethod('CharNext',1,tkVariant,nil,__CharNext,false,0);
    DefineMethod('CharNextA',1,tkVariant,nil,__CharNextA,false,0);
    DefineMethod('CharNextW',1,tkVariant,nil,__CharNextW,false,0);
    DefineMethod('CharPrev',2,tkVariant,nil,__CharPrev,false,0);
    DefineMethod('CharPrevA',2,tkVariant,nil,__CharPrevA,false,0);
    DefineMethod('CharPrevW',2,tkVariant,nil,__CharPrevW,false,0);
    DefineMethod('CharNextExA',3,tkVariant,nil,__CharNextExA,false,0);
    DefineMethod('CharNextEx',3,tkVariant,nil,__CharNextEx,false,0);
    DefineMethod('CharPrevEx',4,tkVariant,nil,__CharPrevEx,false,0);
    DefineMethod('CharPrevExA',4,tkVariant,nil,__CharPrevExA,false,0);
    DefineMethod('AnsiToOem',2,tkVariant,nil,__AnsiToOem,false,0);
    DefineMethod('OemToAnsi',2,tkVariant,nil,__OemToAnsi,false,0);
    DefineMethod('AnsiToOemBuff',3,tkVariant,nil,__AnsiToOemBuff,false,0);
    DefineMethod('AnsiUpper',1,tkVariant,nil,__AnsiUpper,false,0);
    DefineMethod('AnsiUpperBuff',2,tkInteger,nil,__AnsiUpperBuff,false,0);
    DefineMethod('AnsiLower',1,tkVariant,nil,__AnsiLower,false,0);
    DefineMethod('AnsiLowerBuff',2,tkInteger,nil,__AnsiLowerBuff,false,0);
    DefineMethod('AnsiNext',1,tkVariant,nil,__AnsiNext,false,0);
    DefineMethod('AnsiPrev',2,tkVariant,nil,__AnsiPrev,false,0);
    DefineMethod('GetWindowDC',1,tkInteger,nil,__GetWindowDC,false,0);
    DefineMethod('MessageBox',4,tkInteger,nil,__MessageBox,false,0);
    DefineMethod('MessageBoxEx',5,tkInteger,nil,__MessageBoxEx,false,0);
    DefineMethod('MessageBeep',1,tkVariant,nil,__MessageBeep,false,0);
    DefineMethod('GetCaretPos',1,tkVariant,nil,__GetCaretPos,false,0).SetVarArgs([0]);
    DefineMethod('ClientToScreen',2,tkVariant,nil,__ClientToScreen,false,0).SetVarArgs([1]);
    DefineMethod('ScreenToClient',2,tkVariant,nil,__ScreenToClient,false,0).SetVarArgs([1]);
    DefineMethod('FrameRect',3,tkInteger,nil,__FrameRect,false,0);
    DefineMethod('CopyRect',2,tkVariant,nil,__CopyRect,false,0).SetVarArgs([0]);
    DefineMethod('FindWindow',2,tkInteger,nil,__FindWindow,false,0);
    DefineMethod('GetWindowThreadProcessId',2,tkInteger,nil,__GetWindowThreadProcessId,false,0).SetVarArgs([1]);
    DefineMethod('CopyImage',5,tkInteger,nil,__CopyImage,false,0);
    DefineMethod('CopyIcon',1,tkInteger,nil,__CopyIcon,false,0);
    DefineMethod('LoadString',4,tkInteger,nil,__LoadString,false,0);
    DefineMethod('HtmlHelp',4,tkInteger,nil,__HtmlHelp,false,0);
    DefineMethod('HtmlHelpA',4,tkInteger,nil,__HtmlHelpA,false,0);
    DefineMethod('HtmlHelpW',4,tkInteger,nil,__HtmlHelpW,false,0);
    DefineMethod('FoldString',5,tkInteger,nil,__FoldString,false,0);
    DefineMethod('RegOverridePredefKey',2,tkInteger,nil,__RegOverridePredefKey,false,0);
    DefineMethod('RegOpenUserClassesRoot',4,tkInteger,nil,__RegOpenUserClassesRoot,false,0).SetVarArgs([3]);
    DefineMethod('RegOpenCurrentUser',2,tkInteger,nil,__RegOpenCurrentUser,false,0).SetVarArgs([1]);
    DefineMethod('RegDisablePredefinedCache',0,tkInteger,nil,__RegDisablePredefinedCache,false,0);
    AddConstant('AclInfoPad',AclInfoPad);
    AddConstant('AclRevisionInformation',AclRevisionInformation);
    AddConstant('AclSizeInformation',AclSizeInformation);
    AddConstant('SecurityAnonymous',SecurityAnonymous);
    AddConstant('SecurityIdentification',SecurityIdentification);
    AddConstant('SecurityImpersonation',SecurityImpersonation);
    AddConstant('SecurityDelegation',SecurityDelegation);
    AddConstant('TokenTPad',TokenTPad);
    AddConstant('TokenPrimary',TokenPrimary);
    AddConstant('TokenImpersonation',TokenImpersonation);
    AddConstant('TokenICPad',TokenICPad);
    AddConstant('TokenUser',TokenUser);
    AddConstant('TokenGroups',TokenGroups);
    AddConstant('TokenPrivileges',TokenPrivileges);
    AddConstant('TokenOwner',TokenOwner);
    AddConstant('TokenPrimaryGroup',TokenPrimaryGroup);
    AddConstant('TokenDefaultDacl',TokenDefaultDacl);
    AddConstant('TokenSource',TokenSource);
    AddConstant('TokenType',TokenType);
    AddConstant('TokenImpersonationLevel',TokenImpersonationLevel);
    AddConstant('TokenStatistics',TokenStatistics);
    AddConstant('fCtlHold',fCtlHold);
    AddConstant('fDsrHold',fDsrHold);
    AddConstant('fRlsHold',fRlsHold);
    AddConstant('fXoffHold',fXoffHold);
    AddConstant('fXOffSent',fXOffSent);
    AddConstant('fEof',fEof);
    AddConstant('fTxim',fTxim);
    AddConstant('GetFileExInfoStandard',GetFileExInfoStandard);
    AddConstant('GetFileExMaxInfoLevel',GetFileExMaxInfoLevel);
    AddConstant('FindExInfoStandard',FindExInfoStandard);
    AddConstant('FindExInfoMaxInfoLevel',FindExInfoMaxInfoLevel);
    AddConstant('FindExSearchNameMatch',FindExSearchNameMatch);
    AddConstant('FindExSearchLimitToDirectories',FindExSearchLimitToDirectories);
    AddConstant('FindExSearchLimitToDevices',FindExSearchLimitToDevices);
    AddConstant('FindExSearchMaxSearchOp',FindExSearchMaxSearchOp);
    AddConstant('SEMAPHORE_MODIFY_STATE',SEMAPHORE_MODIFY_STATE);
    AddConstant('SEMAPHORE_ALL_ACCESS',SEMAPHORE_ALL_ACCESS);
    AddConstant('IMAGE_LIBRARY_PROCESS_INIT',IMAGE_LIBRARY_PROCESS_INIT);
    AddConstant('IMAGE_LIBRARY_PROCESS_TERM',IMAGE_LIBRARY_PROCESS_TERM);
    AddConstant('IMAGE_LIBRARY_THREAD_INIT',IMAGE_LIBRARY_THREAD_INIT);
    AddConstant('IMAGE_LIBRARY_THREAD_TERM',IMAGE_LIBRARY_THREAD_TERM);
    AddConstant('IMAGE_DLLCHARACTERISTICS_NO_BIND',IMAGE_DLLCHARACTERISTICS_NO_BIND);
    AddConstant('IMAGE_DLLCHARACTERISTICS_WDM_DRIVER',IMAGE_DLLCHARACTERISTICS_WDM_DRIVER);
    AddConstant('IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE',IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE);
    AddConstant('IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT',IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT);
    AddConstant('IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR',IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR);
    AddConstant('HEAP_NO_SERIALIZE',HEAP_NO_SERIALIZE);
    AddConstant('HEAP_GROWABLE',HEAP_GROWABLE);
    AddConstant('HEAP_GENERATE_EXCEPTIONS',HEAP_GENERATE_EXCEPTIONS);
    AddConstant('HEAP_ZERO_MEMORY',HEAP_ZERO_MEMORY);
    AddConstant('HEAP_REALLOC_IN_PLACE_ONLY',HEAP_REALLOC_IN_PLACE_ONLY);
    AddConstant('HEAP_TAIL_CHECKING_ENABLED',HEAP_TAIL_CHECKING_ENABLED);
    AddConstant('HEAP_FREE_CHECKING_ENABLED',HEAP_FREE_CHECKING_ENABLED);
    AddConstant('HEAP_DISABLE_COALESCE_ON_FREE',HEAP_DISABLE_COALESCE_ON_FREE);
    AddConstant('HEAP_CREATE_ALIGN_16',HEAP_CREATE_ALIGN_16);
    AddConstant('HEAP_CREATE_ENABLE_TRACING',HEAP_CREATE_ENABLE_TRACING);
    AddConstant('HEAP_CREATE_ENABLE_EXECUTE',HEAP_CREATE_ENABLE_EXECUTE);
    AddConstant('HEAP_MAXIMUM_TAG',HEAP_MAXIMUM_TAG);
    AddConstant('HEAP_PSEUDO_TAG_FLAG',HEAP_PSEUDO_TAG_FLAG);
    AddConstant('HEAP_TAG_SHIFT',HEAP_TAG_SHIFT);
    AddConstant('RPC_E_NO_CONTEXT',RPC_E_NO_CONTEXT);
    AddConstant('RPC_E_TIMEOUT',RPC_E_TIMEOUT);
    AddConstant('AC_SRC_ALPHA',AC_SRC_ALPHA);
    AddConstant('VK_LBUTTON',VK_LBUTTON);
    AddConstant('VK_RBUTTON',VK_RBUTTON);
    AddConstant('VK_CANCEL',VK_CANCEL);
    AddConstant('VK_MBUTTON',VK_MBUTTON);
    AddConstant('VK_XBUTTON1',VK_XBUTTON1);
    AddConstant('VK_XBUTTON2',VK_XBUTTON2);
    AddConstant('VK_BACK',VK_BACK);
    AddConstant('VK_TAB',VK_TAB);
    AddConstant('VK_CLEAR',VK_CLEAR);
    AddConstant('VK_RETURN',VK_RETURN);
    AddConstant('VK_SHIFT',VK_SHIFT);
    AddConstant('VK_CONTROL',VK_CONTROL);
    AddConstant('VK_MENU',VK_MENU);
    AddConstant('VK_PAUSE',VK_PAUSE);
    AddConstant('VK_CAPITAL',VK_CAPITAL);
    AddConstant('VK_KANA',VK_KANA);
    AddConstant('VK_HANGUL',VK_HANGUL);
    AddConstant('VK_JUNJA',VK_JUNJA);
    AddConstant('VK_FINAL',VK_FINAL);
    AddConstant('VK_HANJA',VK_HANJA);
    AddConstant('VK_KANJI',VK_KANJI);
    AddConstant('VK_CONVERT',VK_CONVERT);
    AddConstant('VK_NONCONVERT',VK_NONCONVERT);
    AddConstant('VK_ACCEPT',VK_ACCEPT);
    AddConstant('VK_MODECHANGE',VK_MODECHANGE);
    AddConstant('VK_ESCAPE',VK_ESCAPE);
    AddConstant('VK_SPACE',VK_SPACE);
    AddConstant('VK_PRIOR',VK_PRIOR);
    AddConstant('VK_NEXT',VK_NEXT);
    AddConstant('VK_END',VK_END);
    AddConstant('VK_HOME',VK_HOME);
    AddConstant('VK_LEFT',VK_LEFT);
    AddConstant('VK_UP',VK_UP);
    AddConstant('VK_RIGHT',VK_RIGHT);
    AddConstant('VK_DOWN',VK_DOWN);
    AddConstant('VK_SELECT',VK_SELECT);
    AddConstant('VK_PRINT',VK_PRINT);
    AddConstant('VK_EXECUTE',VK_EXECUTE);
    AddConstant('VK_SNAPSHOT',VK_SNAPSHOT);
    AddConstant('VK_INSERT',VK_INSERT);
    AddConstant('VK_DELETE',VK_DELETE);
    AddConstant('VK_HELP',VK_HELP);
    AddConstant('VK_LWIN',VK_LWIN);
    AddConstant('VK_RWIN',VK_RWIN);
    AddConstant('VK_APPS',VK_APPS);
    AddConstant('VK_SLEEP',VK_SLEEP);
    AddConstant('VK_NUMPAD0',VK_NUMPAD0);
    AddConstant('VK_NUMPAD1',VK_NUMPAD1);
    AddConstant('VK_NUMPAD2',VK_NUMPAD2);
    AddConstant('VK_NUMPAD3',VK_NUMPAD3);
    AddConstant('VK_NUMPAD4',VK_NUMPAD4);
    AddConstant('VK_NUMPAD5',VK_NUMPAD5);
    AddConstant('VK_NUMPAD6',VK_NUMPAD6);
    AddConstant('VK_NUMPAD7',VK_NUMPAD7);
    AddConstant('VK_NUMPAD8',VK_NUMPAD8);
    AddConstant('VK_NUMPAD9',VK_NUMPAD9);
    AddConstant('VK_MULTIPLY',VK_MULTIPLY);
    AddConstant('VK_ADD',VK_ADD);
    AddConstant('VK_SEPARATOR',VK_SEPARATOR);
    AddConstant('VK_SUBTRACT',VK_SUBTRACT);
    AddConstant('VK_DECIMAL',VK_DECIMAL);
    AddConstant('VK_DIVIDE',VK_DIVIDE);
    AddConstant('VK_F1',VK_F1);
    AddConstant('VK_F2',VK_F2);
    AddConstant('VK_F3',VK_F3);
    AddConstant('VK_F4',VK_F4);
    AddConstant('VK_F5',VK_F5);
    AddConstant('VK_F6',VK_F6);
    AddConstant('VK_F7',VK_F7);
    AddConstant('VK_F8',VK_F8);
    AddConstant('VK_F9',VK_F9);
    AddConstant('VK_F10',VK_F10);
    AddConstant('VK_F11',VK_F11);
    AddConstant('VK_F12',VK_F12);
    AddConstant('VK_F13',VK_F13);
    AddConstant('VK_F14',VK_F14);
    AddConstant('VK_F15',VK_F15);
    AddConstant('VK_F16',VK_F16);
    AddConstant('VK_F17',VK_F17);
    AddConstant('VK_F18',VK_F18);
    AddConstant('VK_F19',VK_F19);
    AddConstant('VK_F20',VK_F20);
    AddConstant('VK_F21',VK_F21);
    AddConstant('VK_F22',VK_F22);
    AddConstant('VK_F23',VK_F23);
    AddConstant('VK_F24',VK_F24);
    AddConstant('VK_NUMLOCK',VK_NUMLOCK);
    AddConstant('VK_SCROLL',VK_SCROLL);
    AddConstant('VK_LSHIFT',VK_LSHIFT);
    AddConstant('VK_RSHIFT',VK_RSHIFT);
    AddConstant('VK_LCONTROL',VK_LCONTROL);
    AddConstant('VK_RCONTROL',VK_RCONTROL);
    AddConstant('VK_LMENU',VK_LMENU);
    AddConstant('VK_RMENU',VK_RMENU);
    AddConstant('VK_BROWSER_BACK',VK_BROWSER_BACK);
    AddConstant('VK_BROWSER_FORWARD',VK_BROWSER_FORWARD);
    AddConstant('VK_BROWSER_REFRESH',VK_BROWSER_REFRESH);
    AddConstant('VK_BROWSER_STOP',VK_BROWSER_STOP);
    AddConstant('VK_BROWSER_SEARCH',VK_BROWSER_SEARCH);
    AddConstant('VK_BROWSER_FAVORITES',VK_BROWSER_FAVORITES);
    AddConstant('VK_BROWSER_HOME',VK_BROWSER_HOME);
    AddConstant('VK_VOLUME_MUTE',VK_VOLUME_MUTE);
    AddConstant('VK_VOLUME_DOWN',VK_VOLUME_DOWN);
    AddConstant('VK_VOLUME_UP',VK_VOLUME_UP);
    AddConstant('VK_MEDIA_NEXT_TRACK',VK_MEDIA_NEXT_TRACK);
    AddConstant('VK_MEDIA_PREV_TRACK',VK_MEDIA_PREV_TRACK);
    AddConstant('VK_MEDIA_STOP',VK_MEDIA_STOP);
    AddConstant('VK_MEDIA_PLAY_PAUSE',VK_MEDIA_PLAY_PAUSE);
    AddConstant('VK_LAUNCH_MAIL',VK_LAUNCH_MAIL);
    AddConstant('VK_LAUNCH_MEDIA_SELECT',VK_LAUNCH_MEDIA_SELECT);
    AddConstant('VK_LAUNCH_APP1',VK_LAUNCH_APP1);
    AddConstant('VK_LAUNCH_APP2',VK_LAUNCH_APP2);
    AddConstant('VK_OEM_1',VK_OEM_1);
    AddConstant('VK_OEM_PLUS',VK_OEM_PLUS);
    AddConstant('VK_OEM_COMMA',VK_OEM_COMMA);
    AddConstant('VK_OEM_MINUS',VK_OEM_MINUS);
    AddConstant('VK_OEM_PERIOD',VK_OEM_PERIOD);
    AddConstant('VK_OEM_2',VK_OEM_2);
    AddConstant('VK_OEM_3',VK_OEM_3);
    AddConstant('VK_OEM_4',VK_OEM_4);
    AddConstant('VK_OEM_5',VK_OEM_5);
    AddConstant('VK_OEM_6',VK_OEM_6);
    AddConstant('VK_OEM_7',VK_OEM_7);
    AddConstant('VK_OEM_8',VK_OEM_8);
    AddConstant('VK_OEM_102',VK_OEM_102);
    AddConstant('VK_PACKET',VK_PACKET);
    AddConstant('VK_PROCESSKEY',VK_PROCESSKEY);
    AddConstant('VK_ATTN',VK_ATTN);
    AddConstant('VK_CRSEL',VK_CRSEL);
    AddConstant('VK_EXSEL',VK_EXSEL);
    AddConstant('VK_EREOF',VK_EREOF);
    AddConstant('VK_PLAY',VK_PLAY);
    AddConstant('VK_ZOOM',VK_ZOOM);
    AddConstant('VK_NONAME',VK_NONAME);
    AddConstant('VK_PA1',VK_PA1);
    AddConstant('VK_OEM_CLEAR',VK_OEM_CLEAR);
    AddConstant('WTS_CONSOLE_CONNECT',WTS_CONSOLE_CONNECT);
    AddConstant('WTS_CONSOLE_DISCONNECT',WTS_CONSOLE_DISCONNECT);
    AddConstant('WTS_REMOTE_CONNECT',WTS_REMOTE_CONNECT);
    AddConstant('WTS_REMOTE_DISCONNECT',WTS_REMOTE_DISCONNECT);
    AddConstant('WTS_SESSION_LOGON',WTS_SESSION_LOGON);
    AddConstant('WTS_SESSION_LOGOFF',WTS_SESSION_LOGOFF);
    AddConstant('WTS_SESSION_LOCK',WTS_SESSION_LOCK);
    AddConstant('WTS_SESSION_UNLOCK',WTS_SESSION_UNLOCK);
    AddConstant('HSHELL_APPCOMMAND',HSHELL_APPCOMMAND);
    AddConstant('HSHELL_WINDOWREPLACED',HSHELL_WINDOWREPLACED);
    AddConstant('UNICODE_NOCHAR',UNICODE_NOCHAR);
    AddConstant('UISF_ACTIVE',UISF_ACTIVE);
    AddConstant('PBT_APMQUERYSUSPEND',PBT_APMQUERYSUSPEND);
    AddConstant('PBT_APMQUERYSTANDBY',PBT_APMQUERYSTANDBY);
    AddConstant('PBT_APMQUERYSUSPENDFAILED',PBT_APMQUERYSUSPENDFAILED);
    AddConstant('PBT_APMQUERYSTANDBYFAILED',PBT_APMQUERYSTANDBYFAILED);
    AddConstant('PBT_APMSUSPEND',PBT_APMSUSPEND);
    AddConstant('PBT_APMSTANDBY',PBT_APMSTANDBY);
    AddConstant('PBT_APMRESUMECRITICAL',PBT_APMRESUMECRITICAL);
    AddConstant('PBT_APMRESUMESUSPEND',PBT_APMRESUMESUSPEND);
    AddConstant('PBT_APMRESUMESTANDBY',PBT_APMRESUMESTANDBY);
    AddConstant('PBTF_APMRESUMEFROMFAILURE',PBTF_APMRESUMEFROMFAILURE);
    AddConstant('PBT_APMBATTERYLOW',PBT_APMBATTERYLOW);
    AddConstant('PBT_APMPOWERSTATUSCHANGE',PBT_APMPOWERSTATUSCHANGE);
    AddConstant('PBT_APMOEMEVENT',PBT_APMOEMEVENT);
    AddConstant('PBT_APMRESUMEAUTOMATIC',PBT_APMRESUMEAUTOMATIC);
    AddConstant('ICON_SMALL2',ICON_SMALL2);
    AddConstant('WS_EX_LAYERED',WS_EX_LAYERED);
    AddConstant('WS_EX_NOINHERITLAYOUT',WS_EX_NOINHERITLAYOUT);
    AddConstant('WS_EX_LAYOUTRTL',WS_EX_LAYOUTRTL);
    AddConstant('WS_EX_COMPOSITED',WS_EX_COMPOSITED);
    AddConstant('WS_EX_NOACTIVATE',WS_EX_NOACTIVATE);
    AddConstant('CS_DROPSHADOW',CS_DROPSHADOW);
    AddConstant('DC_BUTTONS',DC_BUTTONS);
    AddConstant('LWA_COLORKEY',LWA_COLORKEY);
    AddConstant('LWA_ALPHA',LWA_ALPHA);
    AddConstant('ULW_COLORKEY',ULW_COLORKEY);
    AddConstant('ULW_ALPHA',ULW_ALPHA);
    AddConstant('ULW_OPAQUE',ULW_OPAQUE);
    AddConstant('SM_XVIRTUALSCREEN',SM_XVIRTUALSCREEN);
    AddConstant('SM_YVIRTUALSCREEN',SM_YVIRTUALSCREEN);
    AddConstant('SM_CXVIRTUALSCREEN',SM_CXVIRTUALSCREEN);
    AddConstant('SM_CYVIRTUALSCREEN',SM_CYVIRTUALSCREEN);
    AddConstant('SM_CMONITORS',SM_CMONITORS);
    AddConstant('SM_SAMEDISPLAYFORMAT',SM_SAMEDISPLAYFORMAT);
    AddConstant('SM_IMMENABLED',SM_IMMENABLED);
    AddConstant('SM_CXFOCUSBORDER',SM_CXFOCUSBORDER);
    AddConstant('SM_CYFOCUSBORDER',SM_CYFOCUSBORDER);
    AddConstant('COLOR_MENUHILIGHT',COLOR_MENUHILIGHT);
    AddConstant('COLOR_MENUBAR',COLOR_MENUBAR);
    AddConstant('IDTRYAGAIN',IDTRYAGAIN);
    AddConstant('IDCONTINUE',IDCONTINUE);
    AddConstant('HH_DISPLAY_TOPIC',HH_DISPLAY_TOPIC);
    AddConstant('HH_HELP_FINDER',HH_HELP_FINDER);
    AddConstant('HH_DISPLAY_TOC',HH_DISPLAY_TOC);
    AddConstant('HH_DISPLAY_INDEX',HH_DISPLAY_INDEX);
    AddConstant('HH_DISPLAY_SEARCH',HH_DISPLAY_SEARCH);
    AddConstant('HH_SET_WIN_TYPE',HH_SET_WIN_TYPE);
    AddConstant('HH_GET_WIN_TYPE',HH_GET_WIN_TYPE);
    AddConstant('HH_GET_WIN_HANDLE',HH_GET_WIN_HANDLE);
    AddConstant('HH_ENUM_INFO_TYPE',HH_ENUM_INFO_TYPE);
    AddConstant('HH_SET_INFO_TYPE',HH_SET_INFO_TYPE);
    AddConstant('HH_SYNC',HH_SYNC);
    AddConstant('HH_KEYWORD_LOOKUP',HH_KEYWORD_LOOKUP);
    AddConstant('HH_DISPLAY_TEXT_POPUP',HH_DISPLAY_TEXT_POPUP);
    AddConstant('HH_HELP_CONTEXT',HH_HELP_CONTEXT);
    AddConstant('HH_TP_HELP_CONTEXTMENU',HH_TP_HELP_CONTEXTMENU);
    AddConstant('HH_TP_HELP_WM_HELP',HH_TP_HELP_WM_HELP);
    AddConstant('HH_CLOSE_ALL',HH_CLOSE_ALL);
    AddConstant('HH_ALINK_LOOKUP',HH_ALINK_LOOKUP);
    AddConstant('HH_GET_LAST_ERROR',HH_GET_LAST_ERROR);
    AddConstant('HH_ENUM_CATEGORY',HH_ENUM_CATEGORY);
    AddConstant('HH_ENUM_CATEGORY_IT',HH_ENUM_CATEGORY_IT);
    AddConstant('HH_RESET_IT_FILTER',HH_RESET_IT_FILTER);
    AddConstant('HH_SET_INCLUSIVE_FILTER',HH_SET_INCLUSIVE_FILTER);
    AddConstant('HH_SET_EXCLUSIVE_FILTER',HH_SET_EXCLUSIVE_FILTER);
    AddConstant('HH_INITIALIZE',HH_INITIALIZE);
    AddConstant('HH_UNINITIALIZE',HH_UNINITIALIZE);
    AddConstant('HH_SET_QUERYSERVICE',HH_SET_QUERYSERVICE);
    AddConstant('HH_PRETRANSLATEMESSAGE',HH_PRETRANSLATEMESSAGE);
    AddConstant('HH_GLOBALPROPERTY',HH_GLOBALPROPERTY);
    AddConstant('HHWIN_PROP_TAB_AUTOHIDESHOW',HHWIN_PROP_TAB_AUTOHIDESHOW);
    AddConstant('HHWIN_PROP_ONTOP',HHWIN_PROP_ONTOP);
    AddConstant('HHWIN_PROP_NOTITLEBAR',HHWIN_PROP_NOTITLEBAR);
    AddConstant('HHWIN_PROP_NODEF_STYLES',HHWIN_PROP_NODEF_STYLES);
    AddConstant('HHWIN_PROP_NODEF_EXSTYLES',HHWIN_PROP_NODEF_EXSTYLES);
    AddConstant('HHWIN_PROP_TRI_PANE',HHWIN_PROP_TRI_PANE);
    AddConstant('HHWIN_PROP_NOTB_TEXT',HHWIN_PROP_NOTB_TEXT);
    AddConstant('HHWIN_PROP_POST_QUIT',HHWIN_PROP_POST_QUIT);
    AddConstant('HHWIN_PROP_AUTO_SYNC',HHWIN_PROP_AUTO_SYNC);
    AddConstant('HHWIN_PROP_TRACKING',HHWIN_PROP_TRACKING);
    AddConstant('HHWIN_PROP_TAB_SEARCH',HHWIN_PROP_TAB_SEARCH);
    AddConstant('HHWIN_PROP_TAB_HISTORY',HHWIN_PROP_TAB_HISTORY);
    AddConstant('HHWIN_PROP_TAB_FAVORITES',HHWIN_PROP_TAB_FAVORITES);
    AddConstant('HHWIN_PROP_CHANGE_TITLE',HHWIN_PROP_CHANGE_TITLE);
    AddConstant('HHWIN_PROP_NAV_ONLY_WIN',HHWIN_PROP_NAV_ONLY_WIN);
    AddConstant('HHWIN_PROP_NO_TOOLBAR',HHWIN_PROP_NO_TOOLBAR);
    AddConstant('HHWIN_PROP_MENU',HHWIN_PROP_MENU);
    AddConstant('HHWIN_PROP_TAB_ADVSEARCH',HHWIN_PROP_TAB_ADVSEARCH);
    AddConstant('HHWIN_PROP_USER_POS',HHWIN_PROP_USER_POS);
    AddConstant('HHWIN_PROP_TAB_CUSTOM1',HHWIN_PROP_TAB_CUSTOM1);
    AddConstant('HHWIN_PROP_TAB_CUSTOM2',HHWIN_PROP_TAB_CUSTOM2);
    AddConstant('HHWIN_PROP_TAB_CUSTOM3',HHWIN_PROP_TAB_CUSTOM3);
    AddConstant('HHWIN_PROP_TAB_CUSTOM4',HHWIN_PROP_TAB_CUSTOM4);
    AddConstant('HHWIN_PROP_TAB_CUSTOM5',HHWIN_PROP_TAB_CUSTOM5);
    AddConstant('HHWIN_PROP_TAB_CUSTOM6',HHWIN_PROP_TAB_CUSTOM6);
    AddConstant('HHWIN_PROP_TAB_CUSTOM7',HHWIN_PROP_TAB_CUSTOM7);
    AddConstant('HHWIN_PROP_TAB_CUSTOM8',HHWIN_PROP_TAB_CUSTOM8);
    AddConstant('HHWIN_PROP_TAB_CUSTOM9',HHWIN_PROP_TAB_CUSTOM9);
    AddConstant('HHWIN_PROP_TB_MARGIN',HHWIN_PROP_TB_MARGIN);
    AddConstant('HHWIN_PARAM_PROPERTIES',HHWIN_PARAM_PROPERTIES);
    AddConstant('HHWIN_PARAM_STYLES',HHWIN_PARAM_STYLES);
    AddConstant('HHWIN_PARAM_EXSTYLES',HHWIN_PARAM_EXSTYLES);
    AddConstant('HHWIN_PARAM_RECT',HHWIN_PARAM_RECT);
    AddConstant('HHWIN_PARAM_NAV_WIDTH',HHWIN_PARAM_NAV_WIDTH);
    AddConstant('HHWIN_PARAM_SHOWSTATE',HHWIN_PARAM_SHOWSTATE);
    AddConstant('HHWIN_PARAM_INFOTYPES',HHWIN_PARAM_INFOTYPES);
    AddConstant('HHWIN_PARAM_TB_FLAGS',HHWIN_PARAM_TB_FLAGS);
    AddConstant('HHWIN_PARAM_EXPANSION',HHWIN_PARAM_EXPANSION);
    AddConstant('HHWIN_PARAM_TABPOS',HHWIN_PARAM_TABPOS);
    AddConstant('HHWIN_PARAM_TABORDER',HHWIN_PARAM_TABORDER);
    AddConstant('HHWIN_PARAM_HISTORY_COUNT',HHWIN_PARAM_HISTORY_COUNT);
    AddConstant('HHWIN_PARAM_CUR_TAB',HHWIN_PARAM_CUR_TAB);
    AddConstant('HHWIN_BUTTON_EXPAND',HHWIN_BUTTON_EXPAND);
    AddConstant('HHWIN_BUTTON_BACK',HHWIN_BUTTON_BACK);
    AddConstant('HHWIN_BUTTON_FORWARD',HHWIN_BUTTON_FORWARD);
    AddConstant('HHWIN_BUTTON_STOP',HHWIN_BUTTON_STOP);
    AddConstant('HHWIN_BUTTON_REFRESH',HHWIN_BUTTON_REFRESH);
    AddConstant('HHWIN_BUTTON_HOME',HHWIN_BUTTON_HOME);
    AddConstant('HHWIN_BUTTON_BROWSE_FWD',HHWIN_BUTTON_BROWSE_FWD);
    AddConstant('HHWIN_BUTTON_BROWSE_BCK',HHWIN_BUTTON_BROWSE_BCK);
    AddConstant('HHWIN_BUTTON_NOTES',HHWIN_BUTTON_NOTES);
    AddConstant('HHWIN_BUTTON_CONTENTS',HHWIN_BUTTON_CONTENTS);
    AddConstant('HHWIN_BUTTON_SYNC',HHWIN_BUTTON_SYNC);
    AddConstant('HHWIN_BUTTON_OPTIONS',HHWIN_BUTTON_OPTIONS);
    AddConstant('HHWIN_BUTTON_PRINT',HHWIN_BUTTON_PRINT);
    AddConstant('HHWIN_BUTTON_INDEX',HHWIN_BUTTON_INDEX);
    AddConstant('HHWIN_BUTTON_SEARCH',HHWIN_BUTTON_SEARCH);
    AddConstant('HHWIN_BUTTON_HISTORY',HHWIN_BUTTON_HISTORY);
    AddConstant('HHWIN_BUTTON_FAVORITES',HHWIN_BUTTON_FAVORITES);
    AddConstant('HHWIN_BUTTON_JUMP1',HHWIN_BUTTON_JUMP1);
    AddConstant('HHWIN_BUTTON_JUMP2',HHWIN_BUTTON_JUMP2);
    AddConstant('HHWIN_BUTTON_ZOOM',HHWIN_BUTTON_ZOOM);
    AddConstant('HHWIN_BUTTON_TOC_NEXT',HHWIN_BUTTON_TOC_NEXT);
    AddConstant('HHWIN_BUTTON_TOC_PREV',HHWIN_BUTTON_TOC_PREV);
    AddConstant('HHWIN_DEF_BUTTONS',HHWIN_DEF_BUTTONS);
    AddConstant('IDTB_EXPAND',IDTB_EXPAND);
    AddConstant('IDTB_CONTRACT',IDTB_CONTRACT);
    AddConstant('IDTB_STOP',IDTB_STOP);
    AddConstant('IDTB_REFRESH',IDTB_REFRESH);
    AddConstant('IDTB_BACK',IDTB_BACK);
    AddConstant('IDTB_HOME',IDTB_HOME);
    AddConstant('IDTB_SYNC',IDTB_SYNC);
    AddConstant('IDTB_PRINT',IDTB_PRINT);
    AddConstant('IDTB_OPTIONS',IDTB_OPTIONS);
    AddConstant('IDTB_FORWARD',IDTB_FORWARD);
    AddConstant('IDTB_NOTES',IDTB_NOTES);
    AddConstant('IDTB_BROWSE_FWD',IDTB_BROWSE_FWD);
    AddConstant('IDTB_BROWSE_BACK',IDTB_BROWSE_BACK);
    AddConstant('IDTB_CONTENTS',IDTB_CONTENTS);
    AddConstant('IDTB_INDEX',IDTB_INDEX);
    AddConstant('IDTB_SEARCH',IDTB_SEARCH);
    AddConstant('IDTB_HISTORY',IDTB_HISTORY);
    AddConstant('IDTB_FAVORITES',IDTB_FAVORITES);
    AddConstant('IDTB_JUMP1',IDTB_JUMP1);
    AddConstant('IDTB_JUMP2',IDTB_JUMP2);
    AddConstant('IDTB_CUSTOMIZE',IDTB_CUSTOMIZE);
    AddConstant('IDTB_ZOOM',IDTB_ZOOM);
    AddConstant('IDTB_TOC_NEXT',IDTB_TOC_NEXT);
    AddConstant('IDTB_TOC_PREV',IDTB_TOC_PREV);
    AddConstant('HHN_FIRST',HHN_FIRST);
    AddConstant('HHN_LAST',HHN_LAST);
    AddConstant('HHN_NACVOMPLITE',HHN_NACVOMPLITE);
    AddConstant('HHN_TRACK',HHN_TRACK);
    AddConstant('HHN_WINDOW_CREATE',HHN_WINDOW_CREATE);
    AddConstant('SPI_GETMENUSHOWDELAY',SPI_GETMENUSHOWDELAY);
    AddConstant('SPI_SETMENUSHOWDELAY',SPI_SETMENUSHOWDELAY);
    AddConstant('SPI_GETKEYBOARDCUES',SPI_GETKEYBOARDCUES);
    AddConstant('SPI_SETKEYBOARDCUES',SPI_SETKEYBOARDCUES);
    AddConstant('SPI_GETMENUFADE',SPI_GETMENUFADE);
    AddConstant('SPI_SETMENUFADE',SPI_SETMENUFADE);
    AddConstant('SPI_GETSELECTIONFADE',SPI_GETSELECTIONFADE);
    AddConstant('SPI_SETSELECTIONFADE',SPI_SETSELECTIONFADE);
    AddConstant('SPI_GETTOOLTIPANIMATION',SPI_GETTOOLTIPANIMATION);
    AddConstant('SPI_SETTOOLTIPANIMATION',SPI_SETTOOLTIPANIMATION);
    AddConstant('SPI_GETTOOLTIPFADE',SPI_GETTOOLTIPFADE);
    AddConstant('SPI_SETTOOLTIPFADE',SPI_SETTOOLTIPFADE);
    AddConstant('SPI_GETCURSORSHADOW',SPI_GETCURSORSHADOW);
    AddConstant('SPI_SETCURSORSHADOW',SPI_SETCURSORSHADOW);
    AddConstant('SPI_GETMOUSESONAR',SPI_GETMOUSESONAR);
    AddConstant('SPI_SETMOUSESONAR',SPI_SETMOUSESONAR);
    AddConstant('SPI_GETMOUSECLICKLOCK',SPI_GETMOUSECLICKLOCK);
    AddConstant('SPI_SETMOUSECLICKLOCK',SPI_SETMOUSECLICKLOCK);
    AddConstant('SPI_GETMOUSEVANISH',SPI_GETMOUSEVANISH);
    AddConstant('SPI_SETMOUSEVANISH',SPI_SETMOUSEVANISH);
    AddConstant('SPI_GETFLATMENU',SPI_GETFLATMENU);
    AddConstant('SPI_SETFLATMENU',SPI_SETFLATMENU);
    AddConstant('SPI_GETDROPSHADOW',SPI_GETDROPSHADOW);
    AddConstant('SPI_SETDROPSHADOW',SPI_SETDROPSHADOW);
    AddConstant('SPI_GETUIEFFECTS',SPI_GETUIEFFECTS);
    AddConstant('SPI_SETUIEFFECTS',SPI_SETUIEFFECTS);
    AddConstant('SPI_GETCARETWIDTH',SPI_GETCARETWIDTH);
    AddConstant('SPI_SETCARETWIDTH',SPI_SETCARETWIDTH);
    AddConstant('SPI_GETMOUSECLICKLOCKTIME',SPI_GETMOUSECLICKLOCKTIME);
    AddConstant('SPI_SETMOUSECLICKLOCKTIME',SPI_SETMOUSECLICKLOCKTIME);
    AddConstant('SPI_GETFONTSMOOTHINGTYPE',SPI_GETFONTSMOOTHINGTYPE);
    AddConstant('SPI_SETFONTSMOOTHINGTYPE',SPI_SETFONTSMOOTHINGTYPE);
    AddConstant('FE_FONTSMOOTHINGSTANDARD',FE_FONTSMOOTHINGSTANDARD);
    AddConstant('FE_FONTSMOOTHINGCLEARTYPE',FE_FONTSMOOTHINGCLEARTYPE);
    AddConstant('FE_FONTSMOOTHINGDOCKING',FE_FONTSMOOTHINGDOCKING);
    AddConstant('SPI_GETFONTSMOOTHINGCONTRAST',SPI_GETFONTSMOOTHINGCONTRAST);
    AddConstant('SPI_SETFONTSMOOTHINGCONTRAST',SPI_SETFONTSMOOTHINGCONTRAST);
    AddConstant('SPI_GETFOCUSBORDERWIDTH',SPI_GETFOCUSBORDERWIDTH);
    AddConstant('SPI_SETFOCUSBORDERWIDTH',SPI_SETFOCUSBORDERWIDTH);
    AddConstant('SPI_GETFOCUSBORDERHEIGHT',SPI_GETFOCUSBORDERHEIGHT);
    AddConstant('SPI_SETFOCUSBORDERHEIGHT',SPI_SETFOCUSBORDERHEIGHT);
    AddConstant('LCID_ALTERNATE_SORTS',LCID_ALTERNATE_SORTS);
    AddConstant('CSTR_LESS_THAN',CSTR_LESS_THAN);
    AddConstant('CSTR_EQUAL',CSTR_EQUAL);
    AddConstant('CSTR_GREATER_THAN',CSTR_GREATER_THAN);
    AddConstant('CP_THREAD_ACP',CP_THREAD_ACP);
    AddConstant('CP_SYMBOL',CP_SYMBOL);
  end;
end;

class function TatWindowsLibrary.LibraryName: string;
begin
  result := 'Windows';
end;

initialization
  RegisterScripterLibrary(TatWindowsLibrary, True);

{$WARNINGS ON}

end.

