
{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressExport                                               }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSEXPORT AND ALL                }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxXLSExport;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Math,
{$IFDEF WIN32}
  Windows,
{$ELSE}
  Types,
{$ENDIF}
  dxCore, cxExport, cxExportStrs, Graphics;

type
  TxlsExportOptimization = (optBySize, optBySpeed);
  { TcxColorItemType }
  TcxColorItemType = (ciFontColor, ciBrushBKColor, ciBrushFGColor, ciBorderColor);

  TcxXLSCellsData = class;
  TcxXLSRecordsList = class;
  TcxXLSSharedStringTable = class;
  TcxXLSWorkBookWriter = class;

  TcxMergeRect = packed record
    Top, Bottom, Left, Right: Word;
  end;

  { TcxXLSCell }
  PcxXLSCell = ^TcxXLSCell;
  TcxXLSCell = packed record
    RecType: Word;
    RecSize: Word;
    Row: Word;
    Col: Word;
    XF: Word;
    case Integer of
      1: (VarWords: array[0..$FFFF shr 1 - 1] of Word);
      2: (VarBytes: array[0..$FFFF - 1] of Byte);
      3: (SSTIndex: Integer);
      4: (Num: Double);
      5: (StrLen: Word; case StrType: Boolean of
           False: (StrDataA: array[0..255] of AnsiChar);
           True: (StrDataW: array[0..127] of WideChar));
      6: (BoolErrValue, ErrFlag: Boolean);
  end;

  PcxUnionCellsArray = ^TcxUnionCellsArray;
  TcxUnionCellsArray = array[0..MaxInt div SizeOf(TcxMergeRect) - 1] of TcxMergeRect;

  {SST block types}
  TSSTBlock = packed record
    StringCount: Word;
    StringOffset: Word;
    RecType: Word;
    DataSize: Word;
    Data: array[0..8191] of Byte;
  end;

  TExtSSTBlock = packed record
    StreamOffset: Integer;
    StringOffset: Word;
    Reserved: Word;
  end;

  TExtSST = packed record
    RecType: Word;
    DataSize: Word;
    StringPerBlock: Word;
    Data: array[0..255] of TExtSSTBlock;
  end;

  TSSSTStringInfo = packed record
    HashCode: Word;
    StrSize: Word;
    Block: Word;
    Offset: Word;
  end;

  TSSTList = array of TSSTBlock;
  TSSSTStringsInfo = array of TSSSTStringInfo;

  { TSSTStringTable }
  TcxXLSSharedStringTable = class
  private
    FExtSST: TExtSST;
    FSST: TSSTList;
    FOptimaze: Boolean;
    FStringsInfo: TSSSTStringsInfo;
    function GetStringCount: Integer;
    function GetUniqueStringCount: Integer;
  protected
    procedure AddStringToBlock(ASource: Pointer; var ADest: TSSTBlock; ASize: Word);
    procedure CreateExtSST(ASSTOffset: Integer);
    function GetPackedSize: Integer;
    function IndexOf(const AString: WideString): Integer;
    procedure InsertStr(const AString: WideString);
    property ExtSST: TExtSST read FExtSST;
    property SST: TSSTList read FSST;
    property StringsInfo: TSSSTStringsInfo read FStringsInfo;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Add(AString: WideString): Integer;
    procedure Clear;
    procedure SaveToStream(AStream: TStream; APosition: Integer = -1); virtual;
    property PackedSize: Integer read GetPackedSize;
    property TotalStringCount: Integer read GetStringCount;
    property UniqueStringCount: Integer read GetUniqueStringCount;
  end;
  
  { TcxOLEFileHeader }
  PcxOLEFileHeader = ^TcxOLEFileHeader;
  TcxOLEFileHeader = packed record
    Signature       : Int64;
    CLSID           : array[0..1] of Int64;
    OLEVersion      : Integer;
    ByteOrder       : Word;
    SectorShift     : Word;
    MiniSectorShift : Word;
    Reserved        : Word;
    Reserved1       : LongInt;
    Reserved2       : LongInt;
    CountSectFAT    : LongInt;
    SectDIRStart    : LongInt;
    TransSignature  : LongInt;
    MiniSectorCutOff: LongInt;
    SectMiniFATStart: LongInt;
    CountSectMiniFAT: LongInt;
    SectDIFStart    : Longint;
    CountSectDIF    : LongInt;
    SectFAT         : array[0..108] of Integer;
  end;

  { TcxOLEDIREntryType }
  TcxOLEDIREntryType = (ET_INVALID, ET_STORAGE, ET_STREAM, ET_LOCKBYTES, ET_PROPERTY, ET_ROOT);

  { TcxOLEDIREntry }
  PcxOLEDIREntry = ^TcxOLEDIREntry;
  TcxOLEDIREntry = record
     Name       : array[0..64 - 1] of Byte;
     NameLen    : Word;
     EntryType  : TcxOLEDIREntryType;
     BFlag      : Byte;
     LeftSib    : LongWord;
     RightSib   : LongWord;
     ChildSib   : LongWord;
     Guid       : TGUID;
     UserFlag   : LongInt;
     C_M_Time   : array[0..1] of TTimeStamp;
     StartSector: LongInt;
     Size       : LongInt;
     Reserved   : LongInt
  end;

  { TcxFATSector }
  PcxFATSector = ^TcxFATSector;
  TcxFATSector = packed array[0..512 div SizeOf(Integer) - 1] of Integer;

  PcxFATSectors = ^TcxFATSectors;
  TcxFATSectors = packed array[0..MaxInt div SizeOf(TcxFATSector) - 1] of TcxFATSector;

  { TcxWorkBookReader }
  TcxXLSWorkBookWriter = class
  protected
    FBuffer: PByteArray;
    FBufferSize: Integer;
    FCapacity: Integer;
    FFATBlockCount: Integer;
    FIsSmallFile: Boolean;
    FSectCount: Integer;
    FStreamSize: Integer;
    procedure CreateLocalFAT;
    function GetDIFSector(ASector: Integer): PcxFATSector;
    function GetDIREntry(AIndex: Integer): PcxOLEDIREntry;
    function GetHeader: PcxOleFileHeader;
    function GetFATSector(ASector: Integer): PcxFATSector;
  protected
    procedure Check(ACondition: Boolean);
    procedure CreateDIF; virtual;
    procedure CreateDIR; virtual;
    procedure CreateFAT; virtual;
    procedure CreateHeader; virtual;
    procedure CreateSmallFAT; virtual;
    procedure ReallocBuffer(const ASize: Integer);
    property IsSmallFile: Boolean read FIsSmallFile;
    property DIR[AEntry: Integer]: PcxOLEDIREntry read GetDIREntry;
    property DIF[ASector: Integer]: PcxFATSector read GetDIFSector;
    property FAT[ASector: Integer]: PcxFATSector read GetFATSector;
    property Header: PcxOleFileHeader read GetHeader;
    property Memory: PByteArray read FBuffer;
    property Size: Integer read FBufferSize;
  public
    procedure CreateOLEStream(ADataSize: Integer; ADstStream: TStream);
  end;

  { TcxCacheExportXLS }
  TcxXLSExportProvider = class(TcxCustomExportProvider, IcxExportProvider, IcxNameExportProvider)
  private
    FCells: TcxXLSCellsData;
    FColStyles: TcxXLSRecordsList;
    FFonts: TcxXLSRecordsList;
    FMaxCol: Integer;
    FMaxRow: Integer;
    FStyles: TcxXLSRecordsList;
    FStyleCache: TcxExportStyleManager;
    FUnionCells: PcxUnionCellsArray;
    FUnionCellsCapacity: Integer;
    FUnionCellsCount: Integer;
    FUsedColors: Integer;
    FPalette: array[0..55] of Integer;
    FRowStyles: TcxXLSRecordsList;
    FSheetName: WideString;
    FSST: TcxXLSSharedStringTable;
    FStream: TStream;
    FVisibleGrid: Boolean;
    FWorkBookWriter: TcxXLSWorkBookWriter;
    //
    FRangeNameBytes: array of Byte;
    FRangeName: AnsiString;
    FNamedRange: TRect;
  protected
    procedure Commit; virtual;
    function GetCellStyle(const ACol, ARow: Integer): PcxCacheCellStyle;
    function GetStyle(AStyleIndex: Integer): PcxCacheCellStyle;
    function PlaceParsedString(const ACol, ARow: Integer; const AText: string): Boolean;
    function RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
    procedure SetCellDataBoolean(const ACol, ARow: Integer; const AValue: Boolean); virtual;
    procedure SetCellDataCurrency(const ACol, ARow: Integer; const AValue: Currency); virtual;
    procedure SetCellDataDateTime(const ACol, ARow: Integer; const AValue: TDateTime); virtual;
    procedure SetCellDataDouble(const ACol, ARow: Integer; const AValue: Double); virtual;
    procedure SetCellDataInteger(const ACol, ARow: Integer; const AValue: Integer); virtual;
    procedure SetCellDataString(const ACol, ARow: Integer; const AText: string); virtual;
    procedure SetCellDataWideString(const ACol, ARow: Integer; const AText: Widestring); virtual;
    procedure SetCellStyle(const ACol, ARow, AStyleIndex: Integer); overload;
    procedure SetCellStyle(const ACol, ARow, AExampleCol, AExampleRow: Integer); overload;
    procedure SetCellStyle(const ACol, ARow: Integer; const AStyle: TcxCacheCellStyle); overload;
    procedure SetCellStyleEx(const ACol, ARow, H, W: Integer; const AStyleIndex: Integer);
    procedure SetCellUnion(const ACol, ARow: Integer; H, W: Integer);
    procedure SetCellValue(const ACol, ARow: Integer; const AValue: Variant);
    procedure SetColumnWidth(const ACol, AWidth: Integer);
    procedure SetDefaultStyle(const AStyle: TcxCacheCellStyle);
    procedure SetRange(const AColCount, ARowCount: Integer; IsVisible: Boolean = True);
    procedure SetRowHeight(const ARow, AHeight: Integer);
    // export graphic extension
    procedure SetCellDataGraphic(const ACol, ARow: Integer; var AGraphic: TGraphic);
    procedure SetCellPNGImage(const ACol, ARow: Integer; APNGImage: TObject);
    function SupportGraphic: Boolean;
    // IcxNameExportProvider
    procedure SetName(const AName: string);
    procedure SetRangeName(const AName: AnsiString; const ARange: TRect);
  protected
    function CalculateStoredSize: Integer; dynamic;
//    function xlsCellIsMerge(ACol, ARow: Integer; var XFStyle: Word): Boolean;
    function xlsCheckColor(const AColor: Integer; AItemType: TcxColorItemType): Word;
    function xlsCheckPos(const ACol, ARow: Integer): Boolean;
    procedure xlsCreateStyles;
    function xlsRegisterFont(const AStyle: TcxCacheCellStyle): Integer;
    function xlsRegisterStyle(const AStyle: TcxCacheCellStyle;
      var AType: Word; IsMerge: Boolean = False): Integer;
    procedure xlsWriteBuf(const RecData: array of Byte); overload;
    procedure xlsWriteBuf(const RecID: Word; const RecData: array of Byte); overload;
    procedure xlsWriteBuf(const RecID, DataSize: Word; const RecData: array of Byte); overload;
    procedure xlsWriteBuffer(const ARecData: array of Word); overload;
    procedure xlsWriteBuffer(const RecID, DataSize: Word; const RecData); overload;
    procedure xlsWriteHeader;
    procedure xlsWriteWorkBook;
    property DataStream: TStream read FStream;
  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;
    class function ExportType: Integer; override;
    class function ExportName: string; override;
  end;

  { TxlsCellsData }
  TcxXLSCellsData = class
  private
    FCellsList: array of PcxXLSCell;
    FCellPerCol: Integer;
    function GetFullSize: Integer;
  protected
    function GetCell(const ACol, ARow: Integer): PcxXLSCell;
    function PrepareCellStyle(var AType: Word): Word;
    function ReallocCellData(const ACol, ARow: Integer; AVarDataSize: Integer = 0): PcxXLSCell;
    procedure SetCellDataBoolean(const ACol, ARow: Integer; const AValue: Boolean);
    procedure SetCellDataBlank(const ACol, ARow: Integer);
    procedure SetCellDataCurrency(const ACol, ARow: Integer; const AValue: Currency);
    procedure SetCellDataDateTime(const ACol, ARow: Integer; const AValue: TDateTime);
    procedure SetCellDataDouble(const ACol, ARow: Integer; const AValue: Double);
    procedure SetCellDataInteger(const ACol, ARow: Integer; const AValue: Integer);
    procedure SetCellDataStringA(const ACol, ARow: Integer; const AText: string);
    procedure SetCellDataStringW(const ACol, ARow: Integer; const AText: Widestring);
    procedure SetCellDataSSTString(const ACol, ARow, AIndex: Integer);
    procedure SetRange(const AColCount, ARowCount: Integer);
    property FullSize: Integer read GetFullSize;
  public
    destructor Destroy; override;
    procedure SaveToStream(AStream: TStream);
  end;

  { TxlsRecordList }
  TcxXLSRecordsList = class(TList)
  private
    FID: Word;
    function GetFullSize: Integer;
    function GetItem(AIndex: Integer): Pointer;
    function GetItemSize(AIndex: Integer): Integer;
    function GetRealItem(AIndex: Integer): Pointer;
  public
    constructor Create(const RecordID: Word);
    destructor Destroy; override;
    function AddData(const AData; DataSize: Word): Integer;
    function AddUniqueData(var AData: PByteArray): Integer;
    procedure Clear; override;
    procedure SaveToStream(AStream: TStream);
    property Items[AIndex: Integer]: Pointer read GetItem;
    property ItemSize[AIndex: Integer]: Integer read GetItemSize;
    property FullSize: Integer read GetFullSize;
  end;

  function cxXlsGetDateTimeFormat(var AValue: Double): Word;

const
  NativeFormats: array[0..3] of Word = ($16, $0E, $15, $07); //native styles DateTime, Date, Time, Currency
  XLS_Currency   = $1003;              // not native Excel constant for currency
  XLS_DateTime   = $1000;              // not native Excel constant for datetime
  XLS_Date       = $1001;              // not native Excel constant for datetime
  XLS_Time       = $1002;              // not native Excel constant for datetime
  Optimization: TxlsExportOptimization = optBySpeed;
  NeedStringParse: Boolean = False;

implementation

var
  cxBlankCharCode: Integer;
  cxThousandCharCode: Integer;
  cxDecimalCharCode: Integer;

const
  ScaledFactor: Double = 1;

  cxXLSMaxColumn    = $FF;
  cxXLSMaxRow       = $FFFF;
  cxXLSMaxBlockSize = 8192;
  cxXLSBlankCellSize      =  10;
  cxXLSMaxLenShortStringA = $FF;
  cxXLSMaxLenShortStringW = cxXLSMaxLenShortStringA shr 1;

  XLS_Font       = $0031;              // Font Description
  XLS_XF         = $00E0;              // Extended Format
  XLS_COLINFO    = $007D;              // Column Formatting Information
  XLS_Row        = $0208;              // Describes a Row
  XLS_Palette    = $0092;              // Color Palette Definition
  XLS_BoundSheet = $0085;              // Sheet Information
  XLS_MergeCells = $00E5;              // Merged Cells
  XLS_MergeState = $2000;              // not native Excel constant for merged cell
  XLS_BoolErr    = $0205;              // Cell Value - Boolean
  XLS_Blank      = $0201;              // Cell Value, Blank Cell
  XLS_Number     = $0203;              // Cell Value, Floating-Point Number
  XLS_Label      = $0204;              // Cell Value, String Constant
  XLS_LabelSST   = $00FD;              // Cell Value, String Constant/SST
  XLS_ExtSST     = $00FF;              // Extended Shared String Table
  XLS_SST        = $00FC;              // Shared String Table
  XLS_Continue   = $003C;              // Continues Long Records
  XLS_NAME       = $0018;              // Named cells range

  ptgArea3d    = $3B;

  cxXLS_BOF: array[0..19] of Byte =
    ($09, $08, $10, $00, $00, $06, $05, $00, $BB, $0D,
     $CC, $07, $00, $00, $00, $00, $06, $00, $00, $00);
  cxXLS_EOF: array[0..3] of Byte =
    ($0A, $00, $00, $00);
  cxXLS_WINDOW1: array[0..21] of Byte =
    ($3D, $00, $12, $00, $E0, $01, $69, $00, $CC, $42, $7F,
     $26, $38, $00, $00, $00, $00, $00, $01, $00, $58, $02);
  cxXLS_WINDOW2: array[0..21] of Byte =
    ($3E, $02, $12, $00, $B6, $06, $00, $00, $00, $00, $40,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00);
  cxXLS_Font: array[0..29] of Byte =
   ($31, $00, $1A, $00, $C8, 00, $00, $00, $FF, $7F, $90, $01, $00, $00, $00,
    $00, $00, $00, $05, $01, $41, $00, $72, $00, $69, $00, $61, $00, $6C, $00);
  cxXLS_TabID: array[0..5] of Byte =
    ($3D, $01, $02, $00, $00, $00);
  cxXLS_SupBook: array[0..7] of Byte =
    ($AE, $01, $04, $00, $01, $00, $01, $04);
  cxXLS_ExternSheet: array[0..11] of Byte =
    ($17, $00, $08, $00, $01, $00, $00, $00, $00, $00, $00, $00);
  cxXLS_Dimension: array[0..17] of Byte =
    ($00, $02, $0E, $00, $00, $00, $00, $00, $01,
     $00, $00, $00, $00, $00, $01, $00, $00, $00);

  cxXLS_STYLE: array[0..48 - 1] of Byte =
 ($93, $02, $04, $00, $10, $80, $03, $FF, $93, $02, $04, $00, $11, $80, $06, $FF,
  $93, $02, $04, $00, $10, $80, $04, $FF, $93, $02, $04, $00, $10, $80, $07, $FF,
  $93, $02, $04, $00, $00, $80, $00, $FF, $93, $02, $04, $00, $10, $80, $05, $FF);

  cxXLS_XF: packed array[0..16, 0..23] of Byte =
   (($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $01, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $01, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $02, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $02, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $F5, $FF, $20, $00,
     $00, $F4, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $00, $00, $00, $00, $01, $00, $20, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20),
    ($E0, $00, $14, $00, $01, $00, $2b, $00, $F5, $FF, $20, $00,
     $00, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20));

  cxXLS_Palette: array[0..55] of Integer =
    ($000000, $FFFFFF, $0000FF, $00FF00, $FF0000, $00FFFF, $FF00FF, $FFFF00,
     $000080, $008000, $800000, $008080, $800080, $808000, $C0C0C0, $808080,
     $FF9999, $663399, $CCFFFF, $FFFFCC, $660066, $8080FF, $CC6600, $FFCCCC,
     $800000, $FF00FF, $00FFFF, $FFFF00, $800080, $000080, $808000, $FF0000,
     $FFCC00, $FFFFCC, $CCFFCC, $99FFFF, $FFCC99, $CC99FF, $FF99CC, $99CCFF,
     $FF6633, $CCCC33, $00CC99, $00CCFF, $0099FF, $0066FF, $996666, $969696,
     $663300, $669933, $003300, $003333, $003399, $663399, $993333, $333333);

  cxXLSDefaultDataSize = SizeOf(cxXLS_BOF) * 2 + SizeOf(cxXLS_EOF) * 2 +
    SizeOf(cxXLS_WINDOW1) + SizeOf(cxXLS_WINDOW2) + SizeOf(cxXLS_Font) * 5 +
    SizeOf(cxXLS_TabID) +  SizeOf(cxXLS_SupBook) + SizeOf(cxXLS_ExternSheet) +
    (SizeOf(cxXLS_Palette) + 6) + SizeOf(cxXLS_STYLE) + SizeOf(cxXLS_Dimension) + 12 +
    SizeOf(cxXLS_XF);

// OLE data control codes
  oleSignature     = Int64($E11AB1A1E011CFD0);  // header signature
  oleDIFBlock      = Integer($FFFFFFFC);        // double inDIRect FAT
  oleSpecBlock     = Integer($FFFFFFFD);        // special block begining
  oleEndOfChain    = Integer($FFFFFFFE);        // end of chain
  oleUnused        = Integer($FFFFFFFF);        // unused
  oleEmpty         = Integer($00000000);        // empty
  oleDLLVersion    = Integer($0003003E);        // specification version
  olePlatformOrder = Word($FFFE);               // order for intel platform
  oleSectorsInMasterFAT   = 109;                // sectors in master FAT from header
  oleBlockIDPerBigBlock   = 128;                // id cound in big block
  oleMaxBlockIdInBigBlock = 127;                // id cound in big block
  oleContinueFATItem      = 126;                // id continue DIF block item
  oleBigBlockShift        = 9;                  // big block shift
  oleSmallBlockShift      = 6;                  // small block shift
  oleReservedSectorCount  = 2;                  // header and DIRecotry sectors
  oleMiniSectorMaxSize    = Integer($000001000);// max minisector size
  oleSmallBlockSize = 1 shl oleSmallBlockShift; // size of small block
  oleBigBlockSize   = 1 shl oleBigBlockShift;   // size of big block in bytes
  oleDIRBlockSize   = SizeOf(TcxOLEDIREntry);   // size of DIRectory block in bytes
  oleIndexSize      = SizeOf(Integer);          // size of index

  oleRoot       : WideString = 'Root Entry';
  oleWorkbook   : WideString = 'Workbook';
  oleInvalidName: WideString = '';

  cxNegInfinity = -1/0;

  // Default OLE Storage header template
  oleHeaderTemplate: TcxOLEFileHeader =
    (Signature       : oleSignature;
     CLSID           : (oleEmpty, oleEmpty);
     OLEVersion      : oleDLLVersion;
     ByteOrder       : olePlatformOrder;
     SectorShift     : oleBigBlockShift;
     MiniSectorShift : oleSmallBlockShift;
     Reserved        : oleEmpty;
     Reserved1       : oleEmpty;
     Reserved2       : oleEmpty;
     CountSectFAT    : 1;
     SectDIRStart    : 1;
     TransSignature  : oleEmpty;
     MiniSectorCutOff: oleMiniSectorMaxSize;
     SectMiniFATStart: oleEndOfChain;
     CountSectMiniFAT: oleEmpty;
     SectDIFStart    : oleEndOfChain;
     CountSectDIF    : oleEmpty);

function cxXlsGetDateTimeFormat(var AValue: Double): Word;
begin
  if (Int(AValue) <> 0) and (Round(Int(AValue)) <= 60) then
    AValue := AValue - 1;
  Result := XLS_DateTime;
  if Int(AValue) = 0 then
    Result := XLS_Time
  else
    if (Frac(AValue) = 0) then
      Result := XLS_Date;
end;

function RoundDiv(const Number, Denominator: Integer): Integer;
begin
  Result := Number div Denominator;
  if (Number mod Denominator) <> 0 then
    Inc(Result);
end;

procedure FixSetRecType(var AType: Word; NewType: Word);
begin
 if (AType and XLS_MergeState) = XLS_MergeState then
   AType := NewType or XLS_MergeState
 else
   AType := NewType;
end;

// string conversion routines
procedure SetControlCodes;
begin
  if dxFormatSettings.ThousandSeparator = '' then
    dxFormatSettings.ThousandSeparator := ',';
  cxBlankCharCode := Integer(' ') -  Integer('0');
  cxThousandCharCode := Integer(dxFormatSettings.ThousandSeparator) - Integer('0');
  cxDecimalCharCode := Integer(dxFormatSettings.DecimalSeparator) - Integer('0');
end;

function cxTryStrToFloat(const AString: string; out Value: Double): Boolean;
var
  ARet: Extended;
begin
   Result := TextToFloat(PChar(AString), ARet, fvExtended) and
     (ARet > MinDouble) and (ARet < MaxDouble);
   if Result then
     Value := ARet
   else
     Value := 0;
end;
{
function cxTryStrToInt(const AString: string; out Value: Integer): Boolean;
var
  ErrCode: Integer;
  S: string;
begin
  S := Trim(AString);
  Val(S, Value, ErrCode);
  Result := ErrCode = 0;
  if not Result then Value := 0;
end;
}

{$IFNDEF DELPHI6}
function DateTimeFromStr(const strIn: WideString; lcid: DWORD; dwFlags: Longint;
  out dateOut: TDateTime): HRESULT; stdcall; external 'oleaut32.dll' name 'VarDateFromStr';
{$ENDIF}

function cxTryStrToDateTime(const S: string; out ADateTime: TDateTime): Boolean;
begin
  {$IFNDEF DELPHI6}
  Result := DateTimeFromStr(S, $400, 0, ADateTime) = 0;
  {$ELSE}
  Result := TryStrToDateTime(S, ADateTime);
  {$ENDIF}
end;

function cxTryStrToBool(const AString: string; var Value: Boolean): Boolean;
var
  AStr: string;
begin
  AStr := AnsiUpperCase(AString);
  Value := AStr = cxGetResString(@scxBoolTrue);
  Result := (AStr = cxGetResString(@scxBoolTrue)) or (AStr = cxGetResString(@scxBoolTrue));
end;

function cxTryStrToCurr(const S: string; var Value: Currency): Boolean;
var
  APos, Code: Integer;
  IntPart, FrucPart: Double;
  HasCurrencyStr: Boolean;
  HasThousandSeparator: Boolean;

  function CheckCurrencyStr: Boolean;
  var
    CharCount: Integer;
  begin
    Result := not HasCurrencyStr and (Length(dxFormatSettings.CurrencyString) > 0);
    CharCount := 0;
    while Result and (APos <= Length(S)) do
    begin
      if CharCount < Length(dxFormatSettings.CurrencyString) then
      begin
        Result := S[APos + CharCount] = dxFormatSettings.CurrencyString[CharCount + 1];
        if Result then
          Inc(CharCount);
      end
      else
      begin
        HasCurrencyStr := CharCount = Length(dxFormatSettings.CurrencyString);
        Result := HasCurrencyStr;
        if Result then
          Inc(APos, CharCount - 1);
        Break;
      end;
    end;
  end;

  function ScanIntPart: Boolean;
  var
    NumCount: Integer;
  begin
    Result := APos <= Length(S);
    if Result then
    begin
      NumCount := 0;
      HasThousandSeparator := False;
      IntPart := 0;
      while Result and (APos <= Length(S)) do
      begin
        Code := Integer(S[APos]) - Integer('0');
        if (Code >= 0) and (Code <= 9) then
        begin
          IntPart := IntPart * 10 + Code;
          if HasThousandSeparator then Inc(NumCount);
        end
        else
        begin
          if Code = cxDecimalCharCode then
            Break
          else
            if Code = cxThousandCharCode then
            begin
              Result := not HasThousandSeparator or (NumCount = 3);
              HasThousandSeparator := True;
              NumCount := 0;
            end
            else
              Result := (Code = cxBlankCharCode) or CheckCurrencyStr;
        end;
        Inc(APos);
      end;
    end;
  end;

  function ScanFrucPart: Boolean;
  var
    C: Double;
  begin
    Result := True;
    Inc(APos);
    FrucPart := 0;
    C := 0.1;
    while Result and (APos <= Length(S)) do
    begin
      Code := Integer(S[APos]) - Integer('0');
      if (Code >= 0) and (Code <= 9) then
      begin
        FrucPart := FrucPart + Code * C;
        C := C / 10;
      end
      else
        Result := (Code = cxBlankCharCode) or
          (CheckCurrencyStr and (APos = Length(S)));
      Inc(APos);
    end;
  end;

begin
  APos := 1;
  HasCurrencyStr := False;
  Result := ScanIntPart and ScanFrucPart and
    (((dxFormatSettings.ThousandSeparator <> '') and HasThousandSeparator) or HasCurrencyStr);
  if Result then
    Value := IntPart + FrucPart
  else
    Value := 0;
end;

{ TcxXLSExportProvider }
constructor TcxXLSExportProvider.Create(const AFileName: string);
begin
  FSheetName := cxExtractFileNameEx(ChangeFileExt(AFileName, ''));
  inherited Create(AFileName);
  SetControlCodes;
  if FileExists(AFileName) then
    SysUtils.DeleteFile(AFileName);
  FStream := cxFileStreamClass.Create(cxUnicodeToStr(FileName), fmCreate);
  FFonts := TcxXLSRecordsList.Create(XLS_Font);
  FStyles := TcxXLSRecordsList.Create(XLS_XF);
  FCells := TcxXLSCellsData.Create;
  FColStyles := TcxXLSRecordsList.Create(XLS_ColInfo);
  FRowStyles := TcxXLSRecordsList.Create(XLS_Row);
  FStyleCache := TcxExportStyleManager.GetInstance(AFileName);
  FSST := TcxXLSSharedStringTable.Create;
  FWorkBookWriter := TcxXLSWorkBookWriter.Create;
  FMaxCol := -1;
  FMaxRow := -1;
  FUsedColors := High(FPalette);
  Move(cxXLS_Palette, FPalette[0], SizeOf(cxXLS_Palette));
end;

destructor TcxXLSExportProvider.Destroy;
begin
  FCells.Free;
  FWorkBookWriter.Free;
  FStream.Free;
  FColStyles.Free;
  FRowStyles.Free;
  FSST.Free;
  FFonts.Free;
  if Assigned(FStyleCache) then
    FStyleCache.Clear;
  FStyles.Free;
  FreeMem(FUnionCells);
  inherited Destroy;
end;

class function TcxXLSExportProvider.ExportType: Integer;
begin
  Result := cxExportToExcel;
end;

class function TcxXLSExportProvider.ExportName: string;
begin
  Result := cxGetResString(@scxExportToExcel);
end;

procedure TcxXLSExportProvider.Commit;
begin
  xlsWriteHeader;
  xlsWriteWorkBook;
  FreeAndNil(FStream);
end;

function TcxXLSExportProvider.GetCellStyle(const ACol, ARow: Integer): PcxCacheCellStyle;
begin
  Result := nil;
  if xlsCheckPos(ACol, ARow) then
  begin
    with FCells.GetCell(ACol, ARow)^ do
    begin
      if XF > $10 then
        Result := FStyleCache.GetStyle(XF - $10)
      else
        Result := FStyleCache.GetStyle(0);
    end;
  end;
end;

function TcxXLSExportProvider.PlaceParsedString(const ACol, ARow: Integer;
  const AText: string): Boolean;
var
  AFloat: Double;
  ACur: Currency;
  ABool: Boolean;
  ADT: TDateTime;
begin
  Result := True;
  if cxTryStrToFloat(AText, AFloat) then
    SetCellDataDouble(ACol, ARow, AFloat)
  else
    if cxTryStrToDateTime(AText, ADT) then
      SetCellDataDateTime(ACol, ARow, ADt)
    else
      if cxTryStrToCurr(AText, ACur) then
        SetCellDataCurrency(ACol, ARow, ACur)
      else
        if cxTryStrToBool(AText, ABool) then
          SetCellDataBoolean(ACol, ARow, ABool)
      else
        Result := False;
end;

function TcxXLSExportProvider.GetStyle(AStyleIndex: Integer): PcxCacheCellStyle;
begin
  Result := FStyleCache.GetStyle(AStyleIndex);
end;

function TcxXLSExportProvider.RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
begin
  Result := FStyleCache.RegisterStyle(AStyle);
end;

procedure TcxXLSExportProvider.SetCellDataBoolean(const ACol, ARow: Integer; const AValue: Boolean);
begin
  if xlsCheckPos(ACol, ARow) then
    FCells.SetCellDataBoolean(ACol, ARow, AValue);
end;

procedure TcxXLSExportProvider.SetCellDataCurrency(const ACol, ARow: Integer;
  const AValue: Currency);
begin
  if xlsCheckPos(ACol, ARow) then
    FCells.SetCellDataCurrency(ACol, ARow, AValue);
end;

procedure TcxXLSExportProvider.SetCellDataDateTime(const ACol, ARow: Integer;
  const AValue: TDateTime);
begin
  if xlsCheckPos(ACol, ARow) then
    FCells.SetCellDataDateTime(ACol, ARow, AValue);
end;

procedure TcxXLSExportProvider.SetCellDataDouble(const ACol, ARow: Integer;
  const AValue: Double);
begin
  if xlsCheckPos(ACol, ARow) then
    FCells.SetCellDataDouble(ACol, ARow, AValue);
end;

procedure TcxXLSExportProvider.SetCellDataInteger(const ACol, ARow: Integer;
  const AValue: Integer);
begin
  if xlsCheckPos(ACol, ARow) then
    FCells.SetCellDataInteger(ACol, ARow, AValue);
end;

procedure TcxXLSExportProvider.SetCellDataString(const ACol, ARow: Integer;
  const AText: string);

  function TextToUnicode: WideString;
  begin
    Result := cxStrToUnicode(cxValidateStr(AText), GetCellStyle(ACol, ARow)^.FontCharset);
  end;

var
  ALen: Integer;

begin
  ALen := Length(AText);
  if xlsCheckPos(ACol, ARow) and (ALen <> 0) then
  begin
    if not (NeedStringParse and PlaceParsedString(ACol, ARow, AText)) then
    begin
      if (Optimization = optBySize) or (cxStrUnicodeNeeded(AText)) then
      begin
        if (Optimization <> optBySize) and (ALen <= cxXLSMaxLenShortStringW) then
          FCells.SetCellDataStringW(ACol, ARow, TextToUnicode)
        else
          FCells.SetCellDataSSTString(ACol, ARow, FSST.Add(TextToUnicode));
      end
      else
      begin
        if ALen <= cxXLSMaxLenShortStringA then
        begin
          if ALen = 0 then
            FCells.SetCellDataBlank(ACol, ARow)
          else
          {$IFDEF DELPHI12}
            FCells.SetCellDataStringW(ACol, ARow, cxValidateStr(AText));
          {$ELSE}
            FCells.SetCellDataStringA(ACol, ARow, cxValidateStr(AText));
          {$ENDIF}
        end
        else
          FCells.SetCellDataSSTString(ACol, ARow, FSST.Add(cxValidateStr(AText)));
      end;
    end;
  end;
end;

procedure TcxXLSExportProvider.SetCellDataWideString(const ACol, ARow: Integer;
  const AText: Widestring);
var
  ALen: Integer;
begin
  ALen := Length(AText);
  if xlsCheckPos(ACol, ARow) and (ALen <> 0) then
  begin
    if not (NeedStringParse and PlaceParsedString(ACol, ARow, AText)) then
    begin
      if (Optimization <> optBySize) and (ALen <= cxXLSMaxLenShortStringW) then
      begin
        if ALen = 0 then
          FCells.SetCellDataBlank(ACol, ARow)
        else
          FCells.SetCellDataStringW(ACol, ARow, cxValidateStr(AText));
      end
      else
        FCells.SetCellDataSSTString(ACol, ARow, FSST.Add(cxValidateStr(AText)));
    end;
  end;
end;

procedure TcxXLSExportProvider.SetCellStyle(const ACol, ARow, AStyleIndex: Integer);
begin
  if xlsCheckPos(ACol, ARow) then
    with FCells.GetCell(ACol, ARow)^ do
    begin
      if RecType and XLS_MergeState <> XLS_MergeState then
        XF := AStyleIndex + $10;
    end;
end;

procedure TcxXLSExportProvider.SetCellStyle(const ACol, ARow, AExampleCol, AExampleRow: Integer);
begin
 if xlsCheckPos(AExampleCol, AExampleRow) then
   SetCellStyle(ACol, ARow, GetCellStyle(AExampleCol, AExampleRow)^);
end;

procedure TcxXLSExportProvider.SetCellStyle(const ACol, ARow: Integer; const AStyle: TcxCacheCellStyle);
begin
 if xlsCheckPos(ACol, ARow) then
   SetCellStyle(ACol, ARow, RegisterStyle(AStyle));
end;

// TODO: grid export optimization
procedure TcxXLSExportProvider.SetCellStyleEx(
  const ACol, ARow, H, W: Integer; const AStyleIndex: Integer);
var
  I, J, AUnionStyleID, AW, AH: Integer;
begin
  if (ACol >= cxXLSMaxColumn) or (ARow >= cxXLSMaxRow) then Exit;
  AW := Min(W, cxXLSMaxColumn + 1 - ACol);
  AH := Min(H, cxXLSMaxRow + 1 - ARow);
  if (H = 1) and (W = 1) then
    SetCellStyle(ACol, ARow, AStyleIndex)
  else
  begin
    SetCellUnion(ACol, ARow, H, W);
    with FCells.GetCell(ACol, ARow)^ do
    begin
      AUnionStyleID := xlsRegisterStyle(FStyleCache.Items[AStyleIndex], RecType, True);
      RecType := RecType or XLS_MergeState;
      XF := AUnionStyleID;
    end;
    for I := ACol to ACol + AW - 1 do
      for J := ARow to ARow + AH - 1 do
        if (I = ACol) and (J = ARow) then
          Continue
        else
          with FCells.GetCell(I, J)^ do
          begin
            RecType := RecType or XLS_MergeState;
            XF := AUnionStyleID;
          end;
  end;
end;

procedure TcxXLSExportProvider.SetCellUnion(const ACol, ARow: Integer; H, W: Integer);
begin
  W := Min(W, cxXLSMaxColumn + 1 - ACol);
  H := Min(H, cxXLSMaxRow + 1 - ARow);
  if FUnionCellsCount = FUnionCellsCapacity then
  begin
    FUnionCellsCapacity := (FUnionCellsCapacity shr 1 + 1) shl 2;
    ReallocMem(FUnionCells, FUnionCellsCapacity * SizeOf(TcxMergeRect));
  end;
  with FUnionCells^[FUnionCellsCount] do
  begin
    Top := ARow and $FFFF;
    Bottom := (ARow + H - 1) and $FFFF;
    Left := ACol and $00FF;
    Right := (ACol + W - 1) and $00FF;
  end;
  Inc(FUnionCellsCount);
end;

procedure TcxXLSExportProvider.SetCellValue(const ACol, ARow: Integer; const AValue: Variant);
begin
  cxSetCellNativeValue(ACol, ARow, AValue, Self);
end;

procedure TcxXLSExportProvider.SetColumnWidth(const ACol, AWidth: Integer);
var
  AColInfo: PWordArray;
const
  ColRecSize = 11;
begin
  if ACol > cxXLSMaxColumn then Exit;
  AColInfo := AllocMem(ColRecSize + SizeOf(Word) + 1);
  AColInfo^[0] := ColRecSize;
  AColInfo^[1] := ACol;
  AColInfo^[2] := ACol;
  AColInfo^[3] := Round(AWidth * 36.6 / ScaledFactor);
  AColInfo^[4] := $000F;
  FColStyles.Add(AColInfo);
end;

procedure TcxXLSExportProvider.SetDefaultStyle(const AStyle: TcxCacheCellStyle);
begin
  RegisterStyle(AStyle);
end;

procedure TcxXLSExportProvider.SetRange(const AColCount, ARowCount: Integer; IsVisible: Boolean = True);
begin
  FMaxCol := Min(AColCount, cxXLSMaxColumn + 1);
  FMaxRow := Min(ARowCount, cxXLSMaxRow + 1);
  FColStyles.Capacity := FMaxCol;
  FRowStyles.Capacity := FMaxRow;
  FVisibleGrid := IsVisible;
  FCells.SetRange(FMaxCol, FMaxRow);
end;

procedure TcxXLSExportProvider.SetRowHeight(const ARow, AHeight: Integer);
var
  ARowInfo: PWordArray;
const
  RowRecSize = 16;
begin
  if ARow >= cxXLSMaxRow then Exit;
  ARowInfo := AllocMem(RowRecSize + SizeOf(Word));
  ARowInfo^[0] := RowRecSize;
  ARowInfo^[1] := ARow;
  ARowInfo^[3] := $0100;
  ARowInfo^[4] := Round(AHeight * 20 / (1.325 * ScaledFactor));
  ARowInfo^[7] := $01C0;
  ARowInfo^[8] := $0F;
  FRowStyles.Add(ARowInfo);
end;

procedure TcxXLSExportProvider.SetCellDataGraphic(
  const ACol, ARow: Integer; var AGraphic: TGraphic);
begin
end;

procedure TcxXLSExportProvider.SetCellPNGImage(
  const ACol, ARow: Integer; APNGImage: TObject);
begin
end;

function TcxXLSExportProvider.SupportGraphic: Boolean;
begin
  Result := False;
end;

procedure TcxXLSExportProvider.SetName(const AName: string);
begin
  FSheetName := cxStrToUnicode(AName);
end;

procedure TcxXLSExportProvider.SetRangeName(const AName: AnsiString; const ARange: TRect);
var
  I: Integer;
  ANameDef: array of Byte;

  procedure CreateNameDef;
  begin
      SetLength(ANameDef, 11);
      ANameDef[0] := ptgArea3D;
      PWord(@ANameDef[1])^ := 0;
      PWord(@ANameDef[3])^ := ARange.Top and $FFFF;
      PWord(@ANameDef[5])^ := ARange.Bottom and $FFFF;
      PWord(@ANameDef[7])^ := ARange.Left and $FF;
      PWord(@ANameDef[9])^ := ARange.Right and $FF;
  end;

begin
  FRangeName := AName;
  FNamedRange := ARange;
  if AName <> '' then
  begin
    SetLength(FRangeNameBytes, 19 + Length(AName) + 11);
    FillChar(FRangeNameBytes[0], Length(FRangeNameBytes), 0);
    PWordArray(@FRangeNameBytes[0])^[0] := XLS_NAME;
    PWordArray(@FRangeNameBytes[0])^[1] := Length(FRangeNameBytes) - 4;
    PWordArray(@FRangeNameBytes[0])^[2] := 0;
    FRangeNameBytes[7] := Length(AName);
    PWordArray(@FRangeNameBytes[8])^[0] := 11;
    FRangeNameBytes[18] := 0;
    Move(AName[1], FRangeNameBytes[19], Length(AName));
    I := 18 + Length(AName) + 2;

    FRangeNameBytes[I - 1] := ptgArea3d;
    PWordArray(@FRangeNameBytes[I])^[0] := 0;
    PWordArray(@FRangeNameBytes[I])^[1] := ARange.Top and $FFFF;
    PWordArray(@FRangeNameBytes[I])^[2] := ARange.Bottom and $FFFF;
    PWordArray(@FRangeNameBytes[I])^[3] := ARange.Left and $FF;
    PWordArray(@FRangeNameBytes[I])^[4] := ARange.Right and $FF;
  end
  else
    SetLength(FRangeNameBytes, 0);
end;

function TcxXLSExportProvider.CalculateStoredSize: Integer;
var
  ASize: Integer;
begin
  Result := cxXLSDefaultDataSize;
  Inc(Result, FStyles.GetFullSize);
  Inc(Result, FFonts.GetFullSize);
  Inc(Result, Length(FRangeNameBytes));
  Inc(Result, Length(FSheetName) * 2);
  Inc(Result, FSST.PackedSize);
  Inc(Result, FColStyles.FullSize);
  Inc(Result, FRowStyles.FullSize);
  Inc(Result, FCells.FullSize);
  if FUnionCellsCount > 0 then
  begin
    ASize := FUnionCellsCount shl 3;
    Result := Result  + ASize + (Ceil(ASize / $2000) * 6);
  end;
end;

function TcxXLSExportProvider.xlsCheckColor(const AColor: Integer;
  AItemType: TcxColorItemType): Word;
var
  I, C: Integer;
const
  DefaultColorValue: array[TcxColorItemType] of Word = ($7FFF, $40, $40, $40);
begin
  Result := 0;   
  case AItemType of
    ciFontColor:
      if AColor = 0 then
        Result := $7FFF;
    ciBrushBKColor:
      if AColor = cxWindowColor then
        Result := $40;
    ciBrushFGColor, ciBorderColor:
      if AColor = 0 then
        Result := $40;
  end;
  if Result > 0 then Exit;
  for I := High(FPalette) downto 0 do
  begin
    if FPalette[I] = AColor then
    begin
      if I <= FUsedColors then
      begin
        if I <> FUsedColors then
        begin
          C := FPalette[FUsedColors];
          FPalette[FUsedColors] := FPalette[I];
          FPalette[I] := C;
        end;
        Result := FUsedColors + 8;
        Dec(FUsedColors);
      end
      else
        Result := I + 8;
      Exit;
    end;
  end;
  if FUsedColors >= 0 then
  begin
    FPalette[FUsedColors] := AColor;
    Result := FUsedColors + 8;
    Dec(FUsedColors);
  end
  else
    Result := DefaultColorValue[AItemType];
end;

function TcxXLSExportProvider.xlsCheckPos(const ACol, ARow: Integer): Boolean;
begin
  if (FMaxCol < 0) or (FMaxRow < 0) then
    raise EcxExportData.Create(cxGetResString(@scxInvalidCellDimension));
  Result := (ACol < FMaxCol) and (ARow < FMaxRow) and (ACol >= 0) and (ARow >= 0);
end;

procedure TcxXLSExportProvider.xlsCreateStyles;
var
  I: Integer;
begin
  for I := 0 to Length(FCells.FCellsList) - 1 do
  begin
    with FCells.FCellsList[I]^  do
    begin
      if (XF >= $10) and ((RecType and XLS_MergeState) <> XLS_MergeState) then
        XF := xlsRegisterStyle(FStyleCache.Items[XF - $10], RecType);
    end;
  end;
end;

function TcxXLSExportProvider.xlsRegisterFont(const AStyle: TcxCacheCellStyle): Integer;
var
  AFont: PByteArray;
  AWName: WideString;
  ASize: Integer;
const
  ABold: array[Boolean] of Word = ($190, $2BC);
  AItalic: array[Boolean] of Word = (0, $02);
  AStrikeOut: array[Boolean] of Word = (0, $08);
begin
  with AStyle do
  begin
    ASize := StrLen(PChar(@AStyle.FontName)) shl 1 + 16;
    AWName := PChar(@AStyle.FontName);
    AFont := AllocMem(ASize + 6);
    PWord(AFont)^ := ASize;
    PWord(@AFont^[2])^ := FontSize * 20;
    PWord(@AFont^[4])^ := AItalic[cfsItalic in FontStyle] or AStrikeOut[cfsStrikeOut in FontStyle];
    PWord(@AFont^[6])^ := xlsCheckColor(FontColor, ciFontColor);
    PWord(@AFont^[8])^ := ABold[cfsBold in FontStyle];
    AFont^[12] := Byte(cfsUnderLine in FontStyle); 
    AFont^[14] := Byte(FontCharset);
    AFont^[16] := Length(AWName);
    AFont^[17] := 1;
    Move(AWName[1], AFont^[18], AFont^[16] shl 1);
    PInteger(@AFont^[ASize + 2])^ := cxExport.GetHashCode(AFont^[2], ASize);
  end;
  Result := FFonts.AddUniqueData(AFont) + 6;
end;

function TcxXLSExportProvider.xlsRegisterStyle(const AStyle: TcxCacheCellStyle;
  var AType: Word; IsMerge: Boolean = False): Integer;

  function GetPackedFillStyle(AStyle: Byte; AFgColor, ABkColor: Integer): Integer;
  begin
    Result := 0;
    AFgColor := xlsCheckColor(AFGColor, ciBrushBKColor);
    ABkColor := $41;
    if AFgColor <> $40 then
      PWordArray(@Result)^[0] := AStyle shl 10;
    PWordArray(@Result)^[1] := (ABkColor and $7F shl 7) or (AFgColor and $7F);
  end;

var
  XF: PByteArray;
  I, W: Byte;
const
  AColorShift: array[0..3] of Byte = (0, 7, 16, 23);
  ALeftRightBorders: array[0..3] of Byte = (0, 2, 1, 3);
  BordersWidth: array[Boolean] of Byte = (1, 5);
  XFStyleState = $0400 or $0800 or $1000 or $2000 or $4000 or $8000;
  XFSize = 20;
begin
  XF := AllocMem(26);
  Move(cxXLS_XF[15, 2], XF^, 22);
  PWord(@XF^[2])^ := xlsRegisterFont(AStyle) and $FFFF;
  PWord(@XF^[4])^ := FCells.PrepareCellStyle(AType);
  PWord(@XF^[10])^ := PWord(@XF^[10])^ or XFStyleState;
  with AStyle do
  begin
    PWord(@XF^[8])^ := (Byte(AlignText) + 1) or $8;
    PWord(@XF^[10])^ := PWord(@XF^[10])^ or (Byte(IsMerge) shl 5);
    for I := 0 to 3 do
    begin
      with Borders[ALeftRightBorders[I]] do
      begin
        if not IsDefault and (Width > 0) then
        begin
          if Width = 2 then
            W := 2
          else
            W := BordersWidth[Width > 2];
          PWord(@XF^[12])^ := PWord(@XF^[12])^ or (W shl (4 * I));
          PInteger(@XF^[14])^ := PInteger(@XF^[14])^ or
            xlsCheckColor(Color, ciBorderColor) shl AColorShift[I];
        end;
      end;
    end;
    if Byte(BrushStyle) <> 0 then
      PInteger(@XF[18])^ := GetPackedFillStyle(Byte(BrushStyle), BrushBkColor, BrushFGColor);
  end;
  PInteger(@XF^[22])^ := cxExport.GetHashCode(XF^[2], 20);
  Result := FStyles.AddUniqueData(XF);
  Inc(Result, $11);
end;

procedure TcxXLSExportProvider.xlsWriteBuf(const RecData: array of Byte);
begin
  FStream.Write(RecData[0], Length(RecData));
end;

procedure TcxXLSExportProvider.xlsWriteBuf(const RecID: Word;
  const RecData: array of Byte);
begin
  FStream.WriteBuffer(RecID, SizeOf(RecID));
  FStream.Write(RecData[0], Length(RecData));
end;

procedure TcxXLSExportProvider.xlsWriteBuf(const RecID, DataSize: Word;
  const RecData: array of Byte);
begin
  FStream.WriteBuffer(RecID, SizeOf(RecID));
  FStream.WriteBuffer(DataSize, SizeOf(DataSize));
  FStream.WriteBuffer(RecData, DataSize);
end;

procedure TcxXLSExportProvider.xlsWriteBuffer(const ARecData: array of Word);
begin
  FStream.WriteBuffer(ARecData[0], Length(ARecData) shl 1);
end;

procedure TcxXLSExportProvider.xlsWriteBuffer(const RecID, DataSize: Word; const RecData);
begin
  FStream.WriteBuffer(RecID, SizeOf(RecID));
  FStream.Write(RecData, DataSize);
end;

procedure TcxXLSExportProvider.xlsWriteHeader;
var
  B: Byte;
  I, APos: Integer;
  ASheetPos: Integer;
begin
  xlsCreateStyles;
  FWorkBookWriter.CreateOLEStream(CalculateStoredSize, FStream);
  APos := FStream.Position;
  cxXLS_BOF[6] := $05;
  xlsWriteBuf(cxXLS_BOF);
  xlsWriteBuf(cxXLS_TabID);
  xlsWriteBuf(cxXLS_Window1);
  for I := 0 to 4 do
    xlsWriteBuf(cxXLS_Font);
  FFonts.SaveToStream(FStream);
  FStream.WriteBuffer(cxXLS_XF, SizeOf(cxXLS_XF));
  FStyles.SaveToStream(FStream);
  xlsWriteBuffer([XLS_Palette, SizeOf(FPalette) + 2, 56]);
  FStream.WriteBuffer(FPalette, SizeOf(FPalette));
  FStream.WriteBuffer(cxXLS_STYLE[0], SizeOf(cxXLS_STYLE));
  ASheetPos := FStream.Position + 4;
  xlsWriteBuffer([XLS_BoundSheet, Length(FSheetName) * 2 + 8, 0, 0, 0]);
  B := Length(FSheetName);
  FStream.WriteBuffer(B, SizeOf(B));
  B := 1;
  FStream.WriteBuffer(B, SizeOf(B));
  FStream.WriteBuffer(FSheetName[1], Length(FSheetName) * 2);
  //
  FSST.SaveToStream(FStream);
  xlsWriteBuf(cxXLS_SupBook);
  xlsWriteBuf(cxXLS_ExternSheet);
// define range name
  if Length(FRangeNameBytes) > 0 then
    FStream.WriteBuffer(FRangeNameBytes[0], Length(FRangeNameBytes));
//
  xlsWriteBuf(cxXLS_EOF);
  //
  FStream.Seek(ASheetPos, soFrombeginning);
  ASheetPos := FStream.Size - APos;
  FStream.WriteBuffer(ASheetPos, SizeOf(ASheetPos));
  FStream.Seek(0, soFromEnd);
end;

procedure TcxXLSExportProvider.xlsWriteWorkBook;
var
  I: Integer;
  C, ASize: Word;
const
  VisibleGridState: array[Boolean] of Word = ($6B4, $6B6);
begin
  // bof
  cxXLS_BOF[6] := $10;
  xlsWriteBuf(cxXLS_BOF);
  // dimension
  PIntArray(@cxXLS_Dimension)^[2] := FMaxRow{ + 1};
  PWordArray(@cxXLS_Dimension)^[7] := FMaxCol{ + 1};
  xlsWriteBuf(cxXLS_Dimension);
  // window 2
  PWordArray(@cxXLS_WINDOW2)^[2] := VisibleGridState[FVisibleGrid];
  xlsWriteBuf(cxXLS_WINDOW2);
  // Column, Row formatting and cells data
  FColStyles.SaveToStream(FStream);
  FRowStyles.SaveToStream(FStream);
  FCells.SaveToStream(FStream);
  if FUnionCellsCount > 0 then
  begin
    C := Min(FUnionCellsCount, 1024);
    ASize := C shl 3 + 2;
    xlsWriteBuffer([XLS_MergeCells, ASize, C]);
    for I := 1 to FUnionCellsCount do
    begin
      FStream.WriteBuffer(FUnionCells^[I - 1], SizeOf(TcxMergeRect));
      if (I mod 1024) = 0 then
      begin
        C := Min(FUnionCellsCount - I, 1024);
        ASize := C shl 3 + 2;
        xlsWriteBuffer([XLS_MergeCells, ASize, C]);
      end;
    end;
  end;
  xlsWriteBuf(cxXLS_EOF);
end;

{ TxlsCellsData }
destructor TcxXLSCellsData.Destroy;
var
  I: Integer;
begin
  try
    for I := 0 to Length(FCellsList) - 1 do
      FreeMem(FCellsList[I]);
  finally
    inherited Destroy;
  end;
end;

procedure TcxXLSCellsData.SaveToStream(AStream: TStream);
var
  I: Integer;
  ACell: PcxXLSCell;
begin
  for I := 0 to Length(FCellsList) - 1 do
  begin
    ACell := FCellsList[I];
    ACell^.RecType := ACell^.RecType and not XLS_MergeState;
    if ACell^.RecType <> 0 then
      AStream.WriteBuffer(ACell^, ACell^.RecSize + 4);
  end;
end;

function TcxXLSCellsData.GetCell(const ACol, ARow: Integer): PcxXLSCell;
begin
  Result := FCellsList[FCellPerCol * ACol + ARow];
end;

function TcxXLSCellsData.PrepareCellStyle(var AType: Word): Word;
begin
  if (AType and $1000) <> 0 then
  begin
    Result := NativeFormats[AType xor $1000];
    AType := XLS_Number;
  end
  else
    Result := 0;
end;

function TcxXLSCellsData.ReallocCellData(const ACol, ARow: Integer; AVarDataSize: Integer = 0): PcxXLSCell;
var
  AIndex: Integer;
begin
  AIndex := FCellPerCol * ACol + ARow;
  Result := FCellsList[AIndex];
  ReallocMem(Result, cxXLSBlankCellSize + AVarDataSize);
  FCellsList[AIndex] := Result;
  Result^.RecSize := AVarDataSize + 6;
end;

procedure TcxXLSCellsData.SetCellDataBoolean(const ACol, ARow: Integer;
  const AValue: Boolean);
begin
  with GetCell(ACol, ARow)^ do
  begin
    FixSetRecType(RecType, XLS_BoolErr);
    RecSize := cxXLSBlankCellSize + 2;
    BoolErrValue := AValue;
    ErrFlag := False;
  end;
end;

procedure TcxXLSCellsData.SetCellDataBlank(const ACol, ARow: Integer);
begin
  with GetCell(ACol, ARow)^ do
  begin
    if RecType <> XLS_Blank then
    begin
      FixSetRecType(RecType, XLS_Blank);
      RecSize := cxXLSBlankCellSize
    end;
  end;
end;

procedure TcxXLSCellsData.SetCellDataCurrency(const ACol, ARow: Integer;
  const AValue: Currency);
begin
  with GetCell(ACol, ARow)^ do
  begin
    FixSetRecType(RecType, XLS_Currency);
    RecSize := cxXLSBlankCellSize + SizeOf(Double);
    Num := AValue;
  end;
end;

procedure TcxXLSCellsData.SetCellDataDateTime(const ACol, ARow: Integer;
  const AValue: TDateTime);
var
  V: Double;
begin
  with GetCell(ACol, ARow)^ do
  begin
    V := AValue;
    FixSetRecType(RecType, cxXlsGetDateTimeFormat(V));
    RecSize := cxXLSBlankCellSize + SizeOf(Double);
    Num := V;
  end;
end;

procedure TcxXLSCellsData.SetCellDataDouble(
  const ACol, ARow: Integer; const AValue: Double);
begin
  with GetCell(ACol, ARow)^ do
  begin
    FixSetRecType(RecType, XLS_Number);
    RecSize := cxXLSBlankCellSize + SizeOf(Double);
    Num := AValue;
  end;
end;

procedure TcxXLSCellsData.SetCellDataInteger(
  const ACol, ARow: Integer; const AValue: Integer);
begin
  SetCellDataDouble(ACol, ARow, AValue);
end;

procedure TcxXLSCellsData.SetCellDataStringA(
  const ACol, ARow: Integer; const AText: string);
begin
  with ReallocCellData(ACol, ARow, Length(AText) + 3)^ do
  begin
    FixSetRecType(RecType, XLS_Label);
    StrLen := Length(AText);
    StrType := False;
    Move(AText[1], StrDataA[0], StrLen);
  end;
end;

procedure TcxXLSCellsData.SetCellDataStringW(
  const ACol, ARow: Integer; const AText: Widestring);
begin
  with ReallocCellData(ACol, ARow, Length(AText) shl 1 + 3)^ do
  begin
    FixSetRecType(RecType, XLS_Label);
    StrLen := Length(AText);
    StrType := True;
    Move(AText[1], StrDataA[0], StrLen shl 1);
  end;
end;

procedure TcxXLSCellsData.SetCellDataSSTString(const ACol, ARow, AIndex: Integer);
begin
  with GetCell(ACol, ARow)^ do
  begin
    FixSetRecType(RecType, XLS_LabelSST);
    Inc(RecSize, SizeOf(Integer));
    SSTIndex := AIndex;
  end;
end;

procedure TcxXLSCellsData.SetRange(const AColCount, ARowCount: Integer);
var
  I, J, AIndex: Integer;
begin
  SetLength(FCellsList, AColCount * ARowCount);
  AIndex := 0;
  FCellPerCol := ARowCount;
  for I := 0 to AColCount - 1 do
    for J := 0 to ARowCount - 1 do
    begin
      GetMem(FCellsList[AIndex], cxXLSBlankCellSize + SizeOf(Double));
      with FCellsList[AIndex]^ do
      begin
        RecType := XLS_Blank;
        RecSize := 6;
        Col := I;
        Row := J;
        XF := $10;
      end;
      Inc(AIndex);
    end;
end;

function TcxXLSCellsData.GetFullSize: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(FCellsList) - 1 do
  begin
    with FCellsList[I]^ do
    begin
      if RecType <> 0 then
      begin
        Inc(Result, RecSize);
        Inc(Result, 4);
      end;
    end;
  end;
end;

{ TSSTStringTable }
constructor TcxXLSSharedStringTable.Create;
begin
  FOptimaze := Optimization = optBySize;
  Clear;
end;

destructor TcxXLSSharedStringTable.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TcxXLSSharedStringTable.Add(AString: WideString): Integer;
begin
  if Length(AString) > 4096 then
    SetLength(AString, 4096);
  Result := IndexOf(AString);
  if Result = -1 then
  begin
    Result := UniqueStringCount;
    InsertStr(AString);
    Inc(PInteger(@FSST[0].Data[4])^);
  end;
  Inc(PInteger(@FSST[0].Data[0])^);
end;

procedure TcxXLSSharedStringTable.Clear;
begin
  SetLength(FSST, 0);
  SetLength(FStringsInfo, 0);
  FillChar(FExtSST, SizeOf(FExtSST), 0);
  FExtSST.RecType := XLS_ExtSST;
end;

procedure TcxXLSSharedStringTable.SaveToStream(AStream: TStream; APosition: Integer = -1);
var
  I: Integer;
begin
  if APosition = -1 then
    APosition := AStream.Position;
  CreateExtSST(APosition);
  with AStream do
  begin
    for I := 0 to Length(FSST) - 1 do
      if FExtSST.DataSize > 0 then
        WriteBuffer(FSST[I].RecType, FSST[I].DataSize + 4);
    if FExtSST.DataSize > 0 then
      WriteBuffer(FExtSST.RecType, FExtSST.DataSize + 4);
  end;
end;

procedure TcxXLSSharedStringTable.AddStringToBlock(ASource: Pointer; var ADest: TSSTBlock; ASize: Word);
begin
  with ADest do
  begin
    Data[DataSize] := 1;
    Inc(DataSize, 1);
    Move(ASource^, Data[DataSize], ASize);
    Inc(DataSize, ASize);
  end;
end;

procedure TcxXLSSharedStringTable.CreateExtSST(ASSTOffset: Integer);

  function GetSkipSize(ABlock: Word): Integer;
  var
    I: Integer;
  begin
    Result := 4;
    for I := 1 to ABlock - 1 do
      Result := Result + FSST[I].DataSize;
  end;

var
  ABlocksCount: Integer;
  AStringCount: Word;
  I: Integer;
begin
  if Length(FSST) = 0 then Exit;
  AStringCount := 8;
  ABlocksCount := 1;
  while (UniqueStringCount - AStringCount * ABlocksCount) > 0 do
  begin
     Inc(AStringCount, 8);
     if ABlocksCount < 127 then
       if (UniqueStringCount - AStringCount * ABlocksCount) > 0 then Inc(ABlocksCount);
  end;
  while ((ABlocksCount - 1)*  AStringCount) > UniqueStringCount do
    Dec(ABlocksCount);
  FExtSST.DataSize := 2 + ABlocksCount * 8;
  FExtSST.StringPerBlock := AStringCount;
  for I := 0 to ABlocksCount - 1 do
  with FStringsInfo[I * AStringCount] do
    FExtSST.Data[I].StreamOffset := ASSTOffset + GetSkipSize(Block) + Offset;
end;

function TcxXLSSharedStringTable.GetPackedSize: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(FSST) - 1 do
    Inc(Result, FSST[I].DataSize + 4);
  if Result <> 0 then
  begin
    CreateExtSST(0);
    Inc(Result,  FExtSST.DataSize + 4);
  end;
end;

function TcxXLSSharedStringTable.IndexOf(const AString: WideString): Integer;

  function CheckString(ABlock, AOffset, ASize: Word): Boolean;
  var
    AStrPtr: PByteArray;
    ALen: Integer;
    AStrPos: Integer;
  begin
    AStrPtr := @AString[1];
    if (ASize + AOffset) <= FSST[ABlock].DataSize then
      Result := CompareMem(@FSST[ABlock].Data[AOffset], AStrPtr, ASize)
    else
    begin
      Result := True;
      AStrPos := 0;
      while ASize > 0 do
      begin
         with FSST[ABlock] do
         begin
           ALen := (DataSize - AOffset);
           if  ALen < ASize then
           begin
             Result := Result and CompareMem(@Data[AOffset], @AStrPtr^[AStrPos], ALen);
             Dec(ASize, ALen);
             Inc(AStrPos, ALen);
             AOffset := 1;
             Inc(ABlock);
           end
           else
           begin
             Result := Result and CompareMem(@Data[AOffset], @AStrPtr^[AStrPos], ASize);
             Break;
           end;
         end;
      end;
    end;
  end;

var
  I: Integer;
  ASrcLen: Word;
  AHashCode: Word;

begin
  if not FOptimaze then
  begin
    Result := -1;
    Exit; 
  end;
  ASrcLen := Length(AString);
  if ASrcLen > 32768 then
    ASrcLen := 32768;
  Result := -1;
  ASrcLen := ASrcLen shl 1;
  AHashCode := cxExport.GetHashCode(Pointer(@AString[1])^, ASrcLen);
  for I := 0 to UniqueStringCount - 1 do
  begin
    with FStringsInfo[I] do
    begin
      if (HashCode = AHashCode) and (ASrcLen = StrSize) then
        if CheckString(Block, Offset + 3, StrSize) then
        begin
          Result := I;
          Break;
        end;
    end;
  end;
end;

procedure TcxXLSSharedStringTable.InsertStr(const AString: WideString);

  function AddBlock: Integer;
  begin
    Result := Length(FSST);
    SetLength(FSST, Result + 1);
    FillChar(FSST[Result], SizeOf(TSSTBlock), 0);
    FSST[Result].RecType := XLS_Continue;
  end;

  procedure AddStringInfo(ABlock, AOffset, ASize: Word);
  var
    AInfoCount: Integer;
    AInfoIndex: Integer;
  begin
    AInfoCount := Length(FStringsInfo);
    AInfoIndex := UniqueStringCount;
    if AInfoCount <= UniqueStringCount then
      SetLength(FStringsInfo, AInfoCount + 512);
    with FStringsInfo[AInfoIndex] do
    begin
      HashCode := cxExport.GetHashCode(Pointer(@AString[1])^, ASize);
      StrSize := ASize;
      Block := ABlock;
      Offset := AOffset;
    end;
  end;

var
  AEndBlock: SmallInt;
  AStrSize: Word;
  AWriteSize: Word;
  AOffset: Word;

begin
  AEndBlock := Length(FSST) - 1;
  if AEndBlock  < 0 then
  begin
    AEndBlock := AddBlock;
    with FSST[AEndBlock] do
    begin
      RecType := XLS_SST;
      DataSize := 8;
      StringOffset := 8;
    end;
  end;
  AStrSize := Length(AString);
  if  AStrSize > 32768 then
    AStrSize := 32768;
  AStrSize := AStrSize shl 1;

  if (FSST[AEndBlock].DataSize + 4) > cxXLSMaxBlockSize then
    AEndBlock := AddBlock;
  AWriteSize := cxXLSMaxBlockSize - (FSST[AEndBlock].DataSize + 3);
  if AWriteSize > AStrSize then
    AWriteSize := AStrSize
  else
  begin
    if (AWriteSize and $1) <> 0 then
       Dec(AWriteSize);
  end;
  with FSST[AEndBlock] do
  begin
    if StringCount = 0 then
      StringOffset := DataSize;
    AddStringInfo(AEndBlock, DataSize, AStrSize);
    Inc(StringCount);
    PWord(@Data[DataSize])^ := AStrSize shr 1;
    Inc(DataSize, 2);
  end;
  AddStringToBlock(@AString[1], FSST[AEndBlock], AWriteSize);
  AOffset := 0;
  while (AStrSize - AWriteSize) > 0 do
  begin
    Inc(AOffset, AWriteSize);
    Dec(AStrSize, AWriteSize);
    AEndBlock := AddBlock;
    if AStrSize > (cxXLSMaxBlockSize - 1) then
      AWriteSize := cxXLSMaxBlockSize - 1
    else
      AWriteSize := AStrSize;
    AddStringToBlock(@PByteArray(@AString[1])^[AOffset], FSST[AEndBlock], AWriteSize);
  end;
end;

function TcxXLSSharedStringTable.GetStringCount: Integer;
begin
  if Length(FSST) > 0 then
    Result := PIntArray(@FSST[0].Data)^[0]
  else
    Result := 0;
end;

function TcxXLSSharedStringTable.GetUniqueStringCount: Integer;
begin
  if Length(FSST) > 0 then
    Result := PIntArray(@FSST[0].Data)^[1]
  else
    Result := 0;
end;

{ TxlsRecordList }

constructor TcxXLSRecordsList.Create(const RecordID: Word);
begin
  inherited Create;
  FID := RecordID;
end;

destructor TcxXLSRecordsList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TcxXLSRecordsList.AddData(const AData; DataSize: Word): Integer;
var
  NewData: PByteArray;
begin
  GetMem(NewData, DataSize + SizeOf(Word) + SizeOf(Integer));
  PWord(NewData)^ := DataSize;
  PInteger(@NewData[DataSize + SizeOf(Word)])^ := cxExport.GetHashCode(AData, DataSize);
  System.Move(AData, NewData^[SizeOf(Word)], DataSize);
  Result := Add(NewData);
end;

function TcxXLSRecordsList.AddUniqueData(var AData: PByteArray): Integer;
var
  I: Integer;
  Item: PByteArray;
  AHashCode: Integer;
  ASize: Word;
begin
  AHashCode := PInteger(@AData^[PWord(AData)^ + 2])^;
  ASize := PWord(AData)^;
  for I := 0 to Count - 1 do
  begin
    Item := inherited Items[I];
    if (AHashCode = PInteger(@Item^[PWord(Item)^ + 2])^) and
      CompareMem(Item, AData, ASize) then
    begin
      Result := I;
      FreeMem(AData);
      AData := nil;
      Exit;
    end;
  end;
  Result := Add(AData); 
end;

procedure TcxXLSRecordsList.Clear;
var
  I: Integer;
begin
  try
    for I := 0 to Count - 1 do
      FreeMem(inherited Items[I]);
  finally
    inherited Clear;
  end;
end;

procedure TcxXLSRecordsList.SaveToStream(AStream: TStream);
var
  I: Integer;
  AItem: Pointer;
begin
  for I := 0 to Count - 1 do
  begin
    AStream.WriteBuffer(FID, SizeOf(Word));
    AItem := GetRealItem(I);
    AStream.WriteBuffer(AItem^, PWord(AItem)^ + SizeOf(Word));
  end;
end;

function TcxXLSRecordsList.GetFullSize: Integer;
var
  I: Integer;
begin
  Result := Count shl 2;
  for I := 0 to Count - 1 do
    Inc(Result, PWord(inherited Items[I])^);
end;

function TcxXLSRecordsList.GetItem(AIndex: Integer): Pointer;
begin
  Result := inherited Items[AIndex];
  Inc(Integer(Result), SizeOf(Word));
end;

function TcxXLSRecordsList.GetItemSize(AIndex: Integer): Integer;
begin
  Result := PWord(inherited Items[AIndex])^;
end;

function TcxXLSRecordsList.GetRealItem(AIndex: Integer): Pointer;
begin
  Result := inherited Items[AIndex];
end;

{ TcxWorkBookReader }
procedure TcxXLSWorkBookWriter.CreateOLEStream(ADataSize: Integer;
  ADstStream: TStream);
var
  ASize: Integer;
begin
  FBuffer := nil;
  Check((ADataSize > 0) and (ADstStream <> nil));
  FStreamSize := ADataSize;
  FSectCount := RoundDIV(FStreamSize,  oleBigBlockSize);
  ASize := RoundDIV(FSectCount, oleBlockIDPerBigBlock) + 3;
  FIsSmallFile := FStreamSize < oleMiniSectorMaxSize;
  if not IsSmallFile then
    ReallocBuffer(oleBigBlockSize * (ASize + RoundDiv(ASize, oleMaxBlockIDInBigBlock)))
  else
    ReallocBuffer(4 shl oleBigBlockShift);
  CreateHeader;
  CreateDIR;
  CreateFAT;
  try
    ADstStream.WriteBuffer(FBuffer^, Size);
  finally
    ReallocBuffer(oleEmpty);
  end;
end;

procedure TcxXLSWorkBookWriter.Check(ACondition: Boolean);
begin
  if not ACondition then
    raise EcxExportData.Create(cxGetResString(@scxWorkbookWrite));
end;

procedure TcxXLSWorkBookWriter.CreateDIF;
var
  I, AId: Integer;
  ACurDIF: PcxFATSector;
  ACurSect: Integer;
  AIndex, ASectorID: Integer;
begin
  AIndex := 0;
  ACurSect := 0;
  ACurDIF := DIF[ACurSect];
  AId := 0;
  with Header^ do
  begin
    for I := oleSectorsInMasterFAT - 1 to CountSectFAT - 2 do
    begin
      ASectorID := I - 108;
      if AIndex = oleMaxBlockIdInBigBlock then
      begin
        ACurDIF^[oleMaxBlockIdInBigBlock] := ASectorID + 111 + AId;
        ACurDIF := DIF[ACurSect + 1];
        AIndex := 0;
        Inc(ACurSect);
      end;
      if ((ASectorID + AId - 1) mod oleBlockIDPerBigBlock) = 0 then
        Inc(AId);
      ACurDIF^[AIndex] := ASectorID + 110 + AId;
      Inc(AIndex);
    end;
    FillChar(ACurDIF^[AIndex], (oleBlockIDPerBigBlock - AIndex) * oleIndexSize, oleUnused);
  end;
end;

procedure TcxXLSWorkBookWriter.CreateDIR;

  procedure CreateEntry(const AName: WideString;
    AType: TcxOLEDIREntryType; AEntry: PcxOLEDIREntry);
  begin
    with AEntry^ do
    begin
      EntryType := AType;
      BFlag := Byte(AType = ET_STREAM);
      LeftSib := LongWord(oleUnused);
      RightSib := LongWord(oleUnused);
      ChildSib := LongWord(oleUnused);
      if AType in [ET_STREAM, ET_ROOT] then
      begin
        NameLen := (Length(AName) + 1) * 2;
        if NameLen > 2 then
          Move(AName[1], Name, NameLen - 2);
      end;
    end;
  end;

begin
  FillChar(DIR[0]^, oleBigBlockSize, oleEmpty);
  CreateEntry(oleRoot, ET_ROOT, DIR[0]);
  CreateEntry(oleWorkBook, ET_STREAM, DIR[1]);
  DIR[0]^.ChildSib := 1;
  if not IsSmallFile then
  begin
    DIR[0]^.StartSector := oleEndOfChain;
    with Header^ do
      DIR[1]^.StartSector := CountSectFAT + CountSectDIF + 1;
  end
  else
  begin
    DIR[0]^.StartSector := 3;
    DIR[0]^.Size := FSectCount shl oleBigBlockShift;
  end;
  DIR[1]^.Size := FStreamSize;
end;

procedure TcxXLSWorkBookWriter.CreateFAT;
var
  I: Integer;
begin
  with Header^ do
  begin
    if not FIsSmallFile then
    begin
      for I := 0 to Min(CountSectFAT, oleSectorsInMasterFAT) - 1 do
      begin
        if I = 0 then
          Header^.SectFAT[0] := 0
        else
          Header^.SectFAT[I] := I + 1;
      end;
      if CountSectDIF > 0 then
        CreateDIF;
      CreateLocalFAT;
    end
    else
    begin
      SectFAT[0] := 0;
      CreateSmallFAT;
    end;
  end;
end;

procedure TcxXLSWorkBookWriter.CreateHeader;
var
  ACount: Integer;
begin
  with Header^ do
  begin
    Move(oleHeaderTemplate, Header^, oleBigBlockSize - SizeOf(SectFAT));
    FillChar(SectFAT, SizeOf(SectFAT), oleUnused);
    if not FIsSmallFile then
    begin
      CountSectFAT := RoundDIV(FSectCount + 3, oleMaxBlockIdInBigBlock);
      if CountSectFAT > oleSectorsInMasterFAT then
      begin
        ACount := CountSectFAT - oleSectorsInMasterFAT;
        CountSectDIF := RoundDIV(ACount, oleMaxBlockIdInBigBlock);
        SectDIFStart := oleSectorsInMasterFAT + oleReservedSectorCount;
      end;
      ReallocBuffer((CountSectFAT + CountSectDIF + oleReservedSectorCount) shl oleBigBlockShift);
    end
    else
    begin
      SectMiniFATStart := 2;
      CountSectMiniFAT := 1;
    end;
  end;
end;

procedure TcxXLSWorkBookWriter.CreateSmallFAT;
var
  ABigFAT: PcxFATSector;
  ASmallFAT: PcxFATSector;
  ABlockCount: Integer;
  I: Integer;
begin
  ABigFAT := @FBuffer^[oleBigBlockSize];
  ASmallFAT := @FBuffer^[3 shl oleBigBlockShift];
  ABlockCount := RoundDiv(FStreamSize, oleSmallBlockSize);
  FillChar(ABigFAT^, oleBigBlockSize, oleUnused);
  ABigFAT^[0] := oleSpecBlock;
  ABigFAT^[1] := oleEndOfChain;
  ABigFAT^[2] := oleEndOfChain;
  I := 3;
  while (I - 3) < (FSectCount - 1) do
  begin
    ABigFAT^[I] := I + 1;
    Inc(I);
  end;
  ABigFAT^[I] := oleEndOfChain;
  for I := 0 to ABlockCount - 2 do
    ASmallFAT^[I] := I + 1;
  ASmallFAT^[ABlockCount - 1] := oleEndOfChain;
  FillChar(ASmallFAT^[ABlockCount],
    (oleBlockIDPerBigBlock - ABlockCount) * oleIndexSize, oleUnused);
end;

procedure TcxXLSWorkBookWriter.ReallocBuffer(const ASize: Integer);
begin
  FBufferSize := (RoundDIV(ASize, oleMiniSectorMaxSize) + 1) * oleMiniSectorMaxSize;
  try
    if FBufferSize > FCapacity then
    begin
      FCapacity := FBufferSize;
      ReallocMem(FBuffer, FCapacity);
    end
  finally
    if ASize = 0 then
    begin
      FreeMem(FBuffer, FCapacity);
      FBuffer := nil;
    end;
    FBufferSize := ASize;
  end;
end;

procedure TcxXLSWorkBookWriter.CreateLocalFAT;
var
  I: Integer;
  AIndex: Integer;
  ASector: Integer;
  ACurSector: PcxFATSector;
  ADIF: Integer;

  procedure IncCurrentIndexAndSetValue(const Value: Integer);
  begin
    ACurSector^[AIndex] := Value;
    if AIndex = oleMaxBlockIdInBigBlock then
    begin
      Inc(ASector);
      ACurSector := FAT[ASector];
      AIndex := 0;
    end
    else
      Inc(AIndex);
  end;

begin
  AIndex := 0;
  ASector := 0;
  ADIF := 0;
  ACurSector := FAT[ASector];
  IncCurrentIndexAndSetValue(oleSpecBlock);
  IncCurrentIndexAndSetValue(oleEndOfChain);
  with Header^ do
  begin
    for I := 1 to CountSectFAT + CountSectDIF - 1 do
    begin
      if CountSectDIF > 0 then
        if (ADIF + SectDIFStart - 1) = I then
        begin
          Inc(ADIF, oleBlockIDPerBigBlock);
          IncCurrentIndexAndSetValue(oleDIFBlock);
          Continue;
        end;
      IncCurrentIndexAndSetValue(oleSpecBlock);
    end;
  end;
  with DIR[1]^ do
    for I := StartSector + 1 to StartSector + FSectCount - 1 do
      IncCurrentIndexAndSetValue(I);
  IncCurrentIndexAndSetValue(oleEndOfChain);
  if AIndex <> 0 then
  begin
    I := oleBlockIDPerBigBlock - AIndex;
    if I > 0 then
      FillChar(ACurSector^[AIndex], I * 4, oleUnused);
  end;
end;

function TcxXLSWorkBookWriter.GetDIFSector(ASector: Integer): PcxFATSector;
begin
  Result := @PcxFATSectors(FBuffer)^[Header^.SectDIFStart +
    (ASector * oleBlockIDPerBigBlock) + 1];
end;

function TcxXLSWorkBookWriter.GetDIREntry(AIndex: Integer): PcxOLEDIREntry;
begin
  Result := @FBuffer[oleReservedSectorCount shl oleBigBlockShift +
    AIndex * oleDIRBlockSize];
end;

function TcxXLSWorkBookWriter.GetHeader: PcxOleFileHeader;
begin
  Result := PcxOleFileHeader(FBuffer);
end;

function TcxXLSWorkBookWriter.GetFATSector(ASector: Integer): PcxFATSector;
var
  ADIFBlock: Integer;
begin
  if ASector = 0 then
    Result := @PcxFATSectors(FBuffer)^[1]
  else
  begin
    if ASector < oleSectorsInMasterFAT then
      Result := @PcxFATSectors(FBuffer)^[ASector + 2]
    else
    begin
      ASector := ASector - oleSectorsInMasterFAT;
      ADIFBlock := 0;
      while (ASector - oleMaxBlockIdInBigBlock) >= 0 do
      begin
        Dec(ASector, oleMaxBlockIdInBigBlock);
        Inc(ADIFBlock);
      end;
      Result := @PcxFATSectors(FBuffer)^[DIF[ADIFBlock]^[ASector] + 1];
    end;
  end;
end;

{$IFDEF WIN32}
var
  DC: HDC;
{$ENDIF}

initialization
  TcxExport.RegisterProviderClass(TcxXLSExportProvider);

{$IFDEF WIN32}
  DC := GetDC(0);
  try
    ScaledFactor := GetDeviceCaps(DC, LOGPIXELSY) / 96;
    if ScaledFactor < 1 then ScaledFactor := 1;  
  finally
    ReleaseDC(0, DC)
  end;
{$ENDIF}

end.                                   
