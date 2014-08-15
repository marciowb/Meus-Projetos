
{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
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
unit cxExcelAccess;

{$I cxVer.inc}

interface
uses
  Classes, SysUtils, Math,
  {$IFDEF DELPHI6} Variants, {$ENDIF}  Windows,
  Graphics, Dialogs, cxSSTypes, cxClasses, cxControls,
  cxSSUtils, cxExcelConst, cxSSIntf, cxSSRes, dxCore;

type
  EcxExcelDataReader = class(EdxException);
  EcxExcelDataWriter = class(EdxException);

  TSSTStringTable = class;

  TcxStringArray = array of string;
  TcxProgressEvent = procedure (Sender: TObject; APercent: Byte) of object;

  { TcxExcelFileReader }
  TcxExcelFileReader = class
  private
    FBoundSheets: TStringList;
    FCurrentSheet: IcxBookSheet;
    FCurrentPage: Integer;
    FExtRecordSize: Integer;
    FFontArray: array of TcxSSFontRec;
    FFuncConverter: TObject;
    FHasUnknownFunction: Boolean;
    FNames: TcxStringArray;
    FOnProgress: TcxProgressEvent;
    FOwner: IcxSpreadSheetBook;
    FPixelsPerInch: Integer;
    FProgress: Integer;
    FReader: TObject;
    FSharedStringTable: TStringList;
    FStyleList: TStringList;
    FSheetXlt: array of Word;
    FStandardColWidth: Integer;
    FXFRecords: array of TcxSSCellStyleRec;
    function ConvertBrushStyles(ABrushStyle: Byte): TcxSSFillStyle;
    function GetDataSize: Integer;
    function GetMemoryData: Pointer;
  protected
    procedure DoReadRecords; virtual;
    procedure DoReadUnknownRecord(var ARec: TBiffRecHeader); virtual;
    procedure ProgressUpdate(APos: Pointer);
    function XltPage(const APage: Word): Word;
    property BoundSheets: TStringList read FBoundSheets;
    property CurrentSheet: IcxBookSheet read FCurrentSheet;
    property DataSize: Integer read GetDataSize;
    property MemoryData: Pointer read GetMemoryData;
    property Names: TcxStringArray read FNames;
    property Owner: IcxSpreadSheetBook read FOwner;
    property StandardColWidth: Integer read FStandardColWidth;
    property Styles: TStringList read FStyleList;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;
    function AssignStream(AStream: TStream): Boolean;
    procedure OpenStream;
    property PixelsPerInch: Integer read FPixelsPerInch write FPixelsPerInch;
    property HasUnknownFunction: Boolean read FHasUnknownFunction;
    property OnProgress: TcxProgressEvent read FOnProgress write FOnProgress;
  end;

  { TcxExcelFileWriter }
  TcxExcelFileWriter = class(TComponent)
  private
    FCurrentFont: Word;
    FCurrentFormat: TxlsDataFormat;
    FCurrentStyle: Word;
    FCurrentStylePtr: PxlsTreeNode;
    FFontsList: TList;
    FPageCount: Integer;
    FPalette: TcxExcelPalette;
    FPixelsPerInch: Integer;
    FStorage: TxlsFileStorage;
    FStylesList: TList;
    FSST: TSSTStringTable;
    procedure CreateDefaultFonts;
    procedure CreateDefaultStyles;
    procedure SetBlank(ACol, ARow: Word);
    procedure SetBoolErr(ACol, ARow: Word; ABoolValue: Boolean);
    procedure SetDouble(ACol, ARow: Word; ADoubleValue: Double);
    procedure SetSSTString(ACol, ARow: Word; const AStringValue: WideString);
    procedure SetWString(ACol, ARow: Word; const AStringValue: WideString);
  protected
    DefUnLockStyle: Integer;
    function CalculateNodeSize(ANode: PxlsTreeNode; IsRoot: Boolean = False): Integer;
    procedure ClearSheets(var APage: PxlsTreeNode); virtual;
    procedure ClearStorage; virtual;
    procedure ClearTree(var ANode: PxlsTreeNode); virtual;
    function CompareXlsNodes(ANode1, ANode2: PxlsTreeNode): Boolean; virtual;
    procedure CreateFont(AFont: PcxSSFontRec);
    procedure CreateStorage; virtual;
    procedure CreateStyle(AStyle: PcxSSCellStyleRec);
    function CreateXlsListNode(const AType, ASize: Word;
      const APrevNode: PxlsTreeNode = nil): PxlsTreeNode;
    function FindNode(ANode: PxlsTreeNode; AType: Word): PxlsTreeNode; virtual;
    procedure FreeData; virtual;
    function GetEnd(ANode: PxlsTreeNode): PxlsTreeNode;
    function GetRoot(ANode: PxlsTreeNode): PxlsTreeNode;
    procedure SelectPage(APage: Word);
    procedure SetPageDimension(APage: PxlsTreeNode; const AMaxCol, AMaxRow: Integer);
    procedure StoreTreeNode(AStream: TStream; ANode: PxlsTreeNode;
      const IsRoot: Boolean = False);
    function UnionNodes(AFirstNode, ALastNode: PxlsTreeNode): PxlsTreeNode; virtual;
    property CurrentStyle: Word read FCurrentStyle;
    property CurrentFont: Word read FCurrentFont;
    property CurrentFormat: TxlsDataFormat read FCurrentFormat;
    property FontsList: TList read FFontsList;
    property StylesList: TList read FStylesList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddSheet(const ACaption: WideString;
      VisibleGrid: Boolean = True; Visible: Boolean = True); virtual;
    procedure Clear;
    procedure DefineName(APName: PcxSSNameDefinition); virtual;
    procedure SaveToStream(AStream: TStream); virtual;
    procedure SetCellFunction(APage: Word; ACol, ARow: Word; const Value: TcxStackItem;
      AExprSize: Word; const AParsedExpr: PByteArray);
    procedure SetCellValue(APage: Word; ACol, ARow: Word;
      const AValue: Variant; IsText: Boolean = False);
    procedure SetColStyle(APage, ACol, AWidth: Word; IsLocked: Boolean; IsHidden: Boolean = False); virtual;
    procedure SetDefaultColWidth(APage, ASize: Word);
    procedure SetDefaultRowHeight(APage, ASize: Word);
    procedure SetDefaultStyle(AStyle: PcxSSCellStyleRec);
    procedure SetMergedCells(APage: Word; const ARects: array of TRect);
    procedure SetProtection(APage: Integer; IsProtect: Boolean);
    procedure SetPalette(APalette: PcxExcelPalette);
    procedure SetRowStyle(APage, ARow, AHeight: Word; IsHidden: Boolean = False); virtual;
    procedure SelectStyle(AStyle: PcxSSCellStyleRec); virtual;
    property PageCount: Integer read FPageCount write FPageCount;
    property PixelsPerInch: Integer read FPixelsPerInch write FPixelsPerInch;
  end;

  { TSSTStringTable }
  TSSTStringTable = class
  private
    FExtSST: TExtSST;
    FSST: TSSTList;
    FStringsInfo: TSSSTStringsInfo;
    function GetStringCount: Integer;
    function GetUniqueStringCount: Integer;
  protected
    procedure CreateExtSST(ASSTOffset: Integer); virtual;
    function GetPackedSize: Integer; virtual;
    function IndexOf(const AString: WideString): Integer; virtual;
    procedure InsertStr(const AString: WideString); virtual;
    property ExtSST: TExtSST read FExtSST;
    property SST: TSSTList read FSST;
    property StringsInfo: TSSSTStringsInfo read FStringsInfo;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Add(const AString: WideString): Integer;
    procedure Clear;
    procedure SaveToStream(AStream: TStream; APosition: Integer = -1); virtual;
    property PackedSize: Integer read GetPackedSize;
    property TotalStringCount: Integer read GetStringCount;
    property UniqueStringCount: Integer read GetUniqueStringCount;
  end;

implementation

uses
  cxExcelFormulas, Types;

type
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
  TcxOLEDIREntry = packed record
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
  TcxWorkBookWriter = class
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

  { TcxWorkBookReader }
  TcxWorkBookReader = class
  private
    FBuffer: Pointer;
    FCurrentDIF: Integer;
    FCurrentFAT: Integer;
    FDIRSector: array[0..3] of TcxOLEDIREntry;
    FDIF: TcxFATSector;
    FFAT: TcxFATSector;
    FHeader: TcxOLEFileHeader;
    FLinSect: array of Integer;
    FIsError: Boolean;
    FIsSmallFile: Boolean;
    FSectCount: Integer;
    FStream: TStream;
    FStreamStart: Integer; 
    FWorkBookDIR: Integer;
    function GetBufferSize: Integer;
    function GetDIFSector(ASector: Integer): PcxFATSector;
    function GetDIREntry(AEntry: Integer): PcxOLEDIREntry;
    function GetFATSector(ASector: Integer): PcxFATSector;
    procedure GetSector(ASector: Integer; var AData: TcxFATSector);
    function GetSmallFATSector(ASector: Integer): TcxFATSector;
  protected
    procedure CreateStreamSectorChain; virtual;
    function IsSpecialSector(ASector: Integer): Boolean;
    procedure ReadBuffer(var ABuf; const ASize: Integer; APos: Integer);
    procedure ReadStreamData; virtual;
    procedure ReadWorkBookStream; virtual;
    property DIF[ASector: Integer]: PcxFATSector read GetDIFSector;
    property DIR[AEntry: Integer]: PcxOLEDIREntry read GetDIREntry;
    property FAT[ASector: Integer]: PcxFATSector read GetFATSector;
    property Header: TcxOleFileHeader read FHeader;
    property SmallFAT[ASector: Integer]: TcxFATSector read GetSmallFATSector;
    property IsSmallFile: Boolean read FIsSmallFile;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
    property Memory: Pointer read FBuffer;
    property Size: Integer read GetBufferSize;
  end;

// OLE data control codes
const
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

  SectorSize: array[Boolean] of Integer = (oleBigBlockSize, oleSmallBlockSize);

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

  FillStyles: array[0..17] of Byte = ($01, $03, $02, $04, $11, $12,
     $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10);

  MaxBlockSize = 8192;
  ScaledFactor: Double = 1;
  ScreenResolution: Integer = 96;

procedure AddStringToBlock(ASource: Pointer; var ADest: TSSTBlock; ASize: Word);
begin
  with ADest do
  begin
    Data[DataSize] := 1;
    Inc(DataSize);
    Move(ASource^, Data[DataSize], ASize);
    Inc(DataSize, ASize);
  end;
end;

function ConvertRkNumber(AValue: Integer): string;
var
  AV: Double;
begin
  AV := 0;
  PIntArray(@AV)^[1] := Integer(AValue and $FFFFFFFC);
  case AValue and 3 of
    1:
      AV := AV / 100;
    2:
      AV := Integer(AValue and $FFFFFFFC) / 4;
    3:
      AV := Integer(AValue and $FFFFFFFC) / 400;
  end;
  Result := FloatToStr(AV);
end;

function FillStyleToXlsFillStyle(AStyle: TcxSSFillStyle; ABkColor, AFgColor: Word): Integer;
begin
  Result := 0;
  Inc(ABkColor, 8);
  Inc(AFgColor, 8);
  if AFgColor = $41 then
    AFgColor := $40;
  if not ((AStyle = fsSolid) and
   ((AFgColor = $40) or ((ABkColor in [$40, $41]) and (AFgColor = 9)))) then
  begin
    PWordArray(@Result)^[0] := FillStyles[Byte(AStyle)] shl 10;
    PWordArray(@Result)^[1] := (ABkColor and $7F shl 7) or (AFgColor and $7F);
  end;
end;

function GetHashCode(const Buffer; Count: Integer): Word; assembler;
asm
  MOV ECX,EDX
  MOV EDX,EAX
  XOR EAX,EAX
@@1:
  ROL AX,5
  XOR AL,[EDX]
  INC EDX
  DEC ECX
  JNE @@1
end;

procedure IncPtr(var ASrc: PByteArray; ALen: Integer = 1);
begin
  ASrc := Pointer(Integer(ASrc) + ALen);
end;

function ReadExcelString2(var ASource: PByteArray; ALen: Integer): string; overload;
var
  AKey: Integer;
  AFormatCount: Word;
  AWStr: WideString;
  AStr: AnsiString;
  StartPos: Integer;
  IsUnicode: Boolean;
begin
  StartPos := 0;
  Result := '';
  AKey := ASource^[StartPos];
  AFormatCount := 0;
  if (AKey and $08) <> 0 then
  begin
    AFormatCount := PWordArray(@ASource^[StartPos + 1])^[0];
    Inc(StartPos, 2)
  end;
  IsUnicode := AKey and $01 <> 0;
  Inc(StartPos, 1);
  if ALen > 0 then
  begin
    if IsUnicode then
    begin
      SetLength(AWStr, ALen);
      Move(ASource^[StartPos], AWStr[1], ALen * SizeOf(WideChar));
      Result := AWStr;
      Inc(StartPos, ALen * 2);
    end
    else
    begin
      SetLength(AStr, ALen);
      Move(ASource^[StartPos], AStr[1], ALen);
      Result := dxAnsiStringToString(AStr);
      Inc(StartPos, ALen);
    end;
  end;
  Inc(StartPos, AFormatCount * 4);
  IncPtr(ASource, StartPos);
end;

function ReadExcelString(const AData: Pointer): string;
var
  AChars: PByteArray;
begin
  AChars := @PWordArray(AData)^[1];
  Result := ReadExcelString2(AChars, PWordArray(AData)^[0]);
end;

function ReadExcelString1(const AData: Pointer; ALen: Byte): string;
var
  AChars: PByteArray;
begin
  AChars := AData;
  Result := ReadExcelString2(AChars, ALen);
end;

function RoundDiv(const Number, Denominator: Integer): Integer;
begin
  Result := Number div Denominator;
  if (Number mod Denominator) <> 0 then
    Inc(Result);
end;

function XlsColorToColor(AIndex: Word; ADefault: Word): Word;
begin
  if AIndex = 0 then
    Result := ADefault
  else
    Result := AIndex - 8;
end;

{ TcxExcelFileReader }
constructor TcxExcelFileReader.Create(AOwner: TObject);
begin
  FReader := nil;
  FSharedStringTable := TStringList.Create;
  if not {$IFNDEF DELPHI5}cxSSTypes.{$ENDIF}Supports(AOwner, IcxSpreadSheetBook, FOwner) then
    FOwner := nil;
  FFuncConverter := TcxFormulaReader.Create(Self);
  FPixelsPerInch := ScreenResolution;
  FBoundSheets := TStringList.Create;
end;

destructor TcxExcelFileReader.Destroy;
begin
  FBoundSheets.Free;
  FSharedStringTable.Free;
  FFuncConverter.Free;
  FStyleList.Free;
  inherited Destroy;
end;

function TcxExcelFileReader.AssignStream(AStream: TStream): Boolean;
begin
  FReader := TcxWorkBookReader.Create(AStream);
  Result := (MemoryData <> nil) and (DataSize > 0)
end;

procedure TcxExcelFileReader.OpenStream;
begin
  FHasUnknownFunction := False;
  if FReader <> nil then
  try
    DoReadRecords; 
  finally
    FreeAndNil(FReader);
  end;
end;

procedure TcxExcelFileReader.DoReadRecords;
var
  ABiffRecHeader: PBiffRecHeader;
  APosition: Integer;

  function ConstructFormula(ACol, ARow: Integer; Tokens: PByteArray; ParsedLen: Word): string;
  begin
    Result := TcxFormulaReader(FFuncConverter).ConvertFormulas(ACol, ARow, Tokens, ParsedLen);
    FHasUnknownFunction := FHasUnknownFunction or TcxFormulaReader(FFuncConverter).UnknownFunction;
  end;

  procedure ReadFontInfo(AData: Pointer);
  var
    ACount: Word;
  begin
    ACount := Length(FFontArray);
    SetLength(FFontArray, ACount + 1);
    with FFontArray[ACount] do
    begin
      if (PWordArray(AData)^[1] and $2) <> 0 then
        Include(Style, fsItalic);
      if (PWordArray(AData)^[1] and $8) <> 0 then
        Include(Style, fsStrikeOut);
      if PWordArray(AData)^[3] <> $190 then
        Include(Style, fsBold);
      if PByteArray(AData)^[10] <> 0 then
        Include(Style, fsUnderline);
       Size := Round(PWordArray(AData)^[0] / 20);
      Charset := TFontCharset(PByteArray(AData)^[12]);
      if Integer(Charset) = 0 then
        Charset := DEFAULT_CHARSET;
      Name := ReadExcelString1(@PByteArray(AData)^[15], PByteArray(AData)^[14]);
      FontColor := XlsColorToColor(PWordArray(AData)^[2], cxSSDefaultColorValue);
    end;
  end;
  
var
  ASheetIndex: Integer;

  procedure ReadBoundSheet(AData: Pointer);
  var
    AFlag: Byte;
    Position: Integer;
  begin
    AFlag := (PWordArray(AData)^[2] shr 8) and 3;
    if AFlag in [0, 1] then
      Position := PInteger(AData)^
    else
      Position := 0;
    FBoundSheets.AddObject(ReadExcelString1(@PByteArray(AData)^[7],
       PByteArray(AData)^[6]), Pointer(Position));
    if AFlag in [0, 1] then
    begin
      Owner.AddSheet(FBoundSheets[FBoundSheets.Count - 1], AFlag = 1);
      if PWordArray(AData)^[2] in [1, 2] then
        Owner.SetPageVisible(ASheetIndex, False);
      Inc(ASheetIndex);
    end;
  end;

//  procedure ReadBoundSheet(AData: Pointer);
//  var
//    Position: Integer;
//  begin
//    if PWordArray(AData)^[2] = 0 then
//      Position := PInteger(AData)^
//    else
//      Position := 0;
//    FBoundSheets.AddObject(ReadExcelString1(@PByteArray(AData)^[7],
//      PByteArray(AData)^[6]), Pointer(Position));
//    if PWordArray(AData)^[2] = 0 then
//      Owner.AddSheet(FBoundSheets[FBoundSheets.Count - 1], (PByteArray(AData)^[5] and $01) <> 0);
//  end;

  procedure ReadColumnFormatInfo(AData: Pointer);
  var
    I: Integer;
    DC0: HDC;
    ALocked: Boolean;
    AWidth: Double;
    AWords: PWordArray;
    S: TSize;
  begin
    AWords := AData;
    DC0 := GetDC(0);
    with FXFRecords[AWords^[3]].FontPtr^ do
    begin
      if FontHandle <> 0 then
      begin
        FontHandle := SelectObject(DC0, FontHandle);
        if GetTextExtentPoint32(DC0, '1', 1, S) then
          AWidth := AWords^[2] * S.cx /256
        else
          AWidth := AWords^[2] / 36.6 * ScaledFactor;
      end
      else
        AWidth := AWords^[2] / 36.6 * ScaledFactor;
      FontHandle := SelectObject(DC0, FontHandle);
    end;
    ReleaseDC(0, DC0);
    for I := AWords^[0] to AWords^[1] do
    begin
      ALocked := cLocked in FXFRecords[AWords^[3]].CellState;
      FCurrentSheet.SetColRowSize(htCol, I,
         Round(AWidth), ALocked, not Boolean(AWords^[4] and $01));
    end;
  end;

  procedure ReadRowFormatInfo(AData: Pointer);
  begin
    if (PWordArray(AData)^[6] and $80) = $80 then Exit;
    FCurrentSheet.SetColRowSize(htRow, PWordArray(AData)^[0],
      Round(PWordArray(AData)^[3] / 20 * 1.325 * ScaledFactor), False,
         (PWordArray(AData)^[6] and $20) = 0)
  end;

  procedure ReadStdColWidth(AData: Pointer);
  begin
     FCurrentSheet.SetDefaultSize(htCol, Round(PWord(AData)^ / 262 * 8.25 * ScaledFactor));
  end;

  procedure ReadDefaultColWidth(AData: Pointer);
  begin
    FCurrentSheet.SetDefaultSize(htCol, Round(PWord(AData)^ * 8.38 * ScaledFactor));
  end;

  procedure ReadDefaultRowHeight(AData: Pointer);
  begin
    FCurrentSheet.SetDefaultSize(htRow, Round(PWordArray(AData)^[1] / 12.7));
  end;

  procedure ReadSST(ASSTData: Pointer; ASize: Integer);
  var
    BufSize: Word;
    StartPtr: Pointer;
    ACurrentPtr: Pointer;

    function ReadStringChars(ALen: Integer; IsWideChar: Boolean): string;
    var
      AString: AnsiString;
      AWChars: WideString;
      AEndsCount: Integer;
      ACount: Integer;
    begin
      ACount := ALen;
      AEndsCount := (Integer(StartPtr) + BufSize) - Integer(ACurrentPtr);
      try
        if IsWideChar then
        begin
          while (ACount * 2) > AEndsCount do Dec(ACount);
          SetLength(AWChars, ACount);
          Move(ACurrentPtr^, AWChars[1], ACount * 2);
          Result := dxWideStringToString(AWChars);
          Inc(Integer(ACurrentPtr), ACount);
        end
        else
        begin
          if ACount > AEndsCount then
            ACount := AEndsCount;
          SetLength(AString, ACount);
          Move(ACurrentPtr^, AString[1], ACount);
          Result := dxAnsiStringToString(AString);
        end;
      finally
        Inc(Integer(ACurrentPtr), ACount)
      end;
      if (ALen - ACount) > 0 then
      begin
        if PWord(ACurrentPtr)^ <> brcContinue then
          raise EdxException.Create(cxGetResourceString(@scxSpreadSheetErrorReadSST));
        StartPtr := @PWordArray(ACurrentPtr)^[2];
        BufSize := PWordArray(ACurrentPtr)^[1];
        ACurrentPtr := StartPtr;
        IsWideChar := PByte(ACurrentPtr)^ <> 0;
        Inc(Integer(ACurrentPtr));
        Result := Result + ReadStringChars(ALen - ACount, IsWideChar);
      end;
    end;

    function ReadNextString: string;
    var
      ALen: Word;
      AOptions: Byte;
      FormatTokens: Word;

      procedure ReadMultiByteChars;
      var
        ExtRstLen: Integer;
      begin
        if (AOptions and $08) <> 0 then
        begin
          FormatTokens := PWord(ACurrentPtr)^;
          Inc(Integer(ACurrentPtr), 2);
        end;
        ExtRstLen := PInteger(ACurrentPtr)^;
        Inc(Integer(ACurrentPtr), SizeOf(Integer));
        Result  := ReadStringChars(ALen, (AOptions and $01) <> 0);
        Inc(Integer(ACurrentPtr), ExtRstLen);
      end;

    begin
      Result := '';
      FormatTokens := 0;
      if ((Integer(StartPtr) + BufSize) - Integer(ACurrentPtr)) < 3 then
      begin
        if PWord(ACurrentPtr)^ <> brcContinue then
          raise EdxException.Create(cxGetResourceString(@scxSpreadSheetErrorReadSST));
        StartPtr := @PWordArray(ACurrentPtr)^[2];
        BufSize := PWordArray(ACurrentPtr)^[1];
        ACurrentPtr := StartPtr;
      end;
      ALen := PWord(ACurrentPtr)^;
      Inc(Integer(ACurrentPtr), 2);
      AOptions := PByte(ACurrentPtr)^;
      Inc(Integer(ACurrentPtr));
      if ALen <> 0 then
      try
        if (AOptions and $04) <> 0 then
          ReadMultiByteChars
        else
        begin
          if (AOptions and $08) <> 0 then
          begin
            FormatTokens := PWord(ACurrentPtr)^;
            Inc(Integer(ACurrentPtr), 2);
          end;
          Result := ReadStringChars(ALen, (AOptions and $01) <> 0);
        end;
      finally
        FormatTokens := FormatTokens * 4;
        if  FormatTokens > (Integer(StartPtr) + BufSize - Integer(ACurrentPtr)) then
        begin
          FormatTokens := FormatTokens - (Integer(StartPtr) + BufSize - Integer(ACurrentPtr));
          if PWord(@PByteArray(StartPtr)^[BufSize])^ <> brcContinue then
            raise EdxException.Create(cxGetResourceString(@scxSpreadSheetErrorReadSST));
          ACurrentPtr := @PByteArray(StartPtr)^[BufSize + 4];
          BufSize := PWord(@PByteArray(StartPtr)^[BufSize + 2])^;
          StartPtr := ACurrentPtr;
        end;
        Inc(Integer(ACurrentPtr), FormatTokens);
      end;
    end;

  var
    I: Integer;
    AbsPtr: Integer;
    AStringCount: Integer;
  begin
    AStringCount := PIntArray(ASSTData)^[1];
    FSharedStringTable.Clear;
    FSharedStringTable.Capacity := AStringCount;
    StartPtr := @PIntArray(ASSTData)^[2];
    BufSize := ASize - 8;
    ACurrentPtr := StartPtr;
    AbsPtr := Integer(StartPtr);
    for I := 0 to AStringCount - 1 do
    begin
      ProgressUpdate(StartPtr);
      FSharedStringTable.Add(ReadNextString);
      if (Integer(ACurrentPtr) - Integer(AbsPtr)) > FExtRecordSize then
        raise EdxException.Create(cxGetResourceString(@scxExcelImportUndefinedString));
    end;
  end;

  procedure ReadStyleInfo(AData: Pointer);
  var
    S: AnsiString;
    N: Word;
    I: Integer;
  begin
    N := PWord(AData)^;
    SetLength(S, PByteArray(AData)^[2]);
    Move(PByteArray(AData)^[3 + 2], S[1], Length(S));
    if FStyleList = nil then
    begin
      FStyleList := TStringList.Create;
      for I := 0 to High(ExcelDefaultFormats) do
        FStyleList.AddObject(ExcelDefaultFormats[I], TObject(I));
    end;
    if N > $31 then
      FStyleList.AddObject(dxAnsiStringToString(S), TObject(N));
  end;

  procedure ReadXFRecord(AData: Pointer);
  var
    ACount: Integer;
    AXFData: PWordArray;
    ASide: TcxSSEdgeBorder;
    I: Integer;
  begin
    AXFData := AData;
    ACount := Length(FXFRecords);
    SetLength(FXFRecords, ACount + 1);
    with FXFRecords[ACount] do
    begin
      if AXFData[0] >= 4 then Dec(AXFData[0]);
      if AXFData[0] >= Length(FFontArray) then
        FontPtr := @FFontArray[Length(FFontArray) - 1]
      else
        FontPtr := @FFontArray[AXFData[0]];
      if (AXFData^[4] and $00010) <> 0 then
        Include(CellState, cMerge);
      if (AXFData^[4] and $0010) <> 0 then
        Include(CellState, cShrinkToFit);
      if (AXFData^[2] and $1) <> 0 then
        Include(CellState, cLocked);
      if (AXFData^[3] and $7) >= 6 then
        HorzAlign := haCenter
      else
        HorzAlign := TcxHorzTextAlign(AXFData^[3] and $7);
      VertAlign := TcxVertTextAlign(AXFData^[3] shr 4 and $7);
      WordBreak := (AXFData^[3] and $0008) <> 0;
      Borders[eLeft].Style := TcxSSEdgeLineStyle(AXFData^[5] and $000F);
      Borders[eRight].Style := TcxSSEdgeLineStyle((AXFData^[5] and $00F0) shr 4);
      Borders[eTop].Style := TcxSSEdgeLineStyle((AXFData^[5] and $0F00) shr 8);
      Borders[eBottom].Style := TcxSSEdgeLineStyle((AXFData^[5] and $F000) shr 12);
      for ASide := eLeft to eBottom do
        if Byte(Borders[ASide].Style) >= Byte(lsNone) then
          Borders[ASide].Style := lsDefault;
      Borders[eLeft].Color :=
        XlsColorToColor(AXFData^[6] and $007F, cxSSDefaultColorValue);
      Borders[eRight].Color :=
        XlsColorToColor((AXFData^[6] and $3F80) shr 7, cxSSDefaultColorValue);
      Borders[eTop].Color :=
        XlsColorToColor(AXFData^[7] and $007F, cxSSDefaultColorValue);
      Borders[eBottom].Color :=
        XlsColorToColor((AXFData^[7] and $3F80) shr 7, cxSSDefaultColorValue);
      BrushStyle := ConvertBrushStyles(AXFData^[8] shr 10 and $003F);
      if (AXFData^[8] shr 10 and $003F) <> 0 then
      begin
        if BrushStyle <> fsSolid then
        begin
          BrushBkColor := AXFData^[9] shr 7 and $7F - 8;
          BrushFgColor := AXFData^[9] and $7F - 8;
        end
        else
        begin
          BrushBkColor := AXFData^[9] and $7F - 8;
          BrushFgColor := AXFData^[9] shr 7 and $7F - 8;
        end;
      end
      else
      begin
        BrushBkColor := cxSSDefaultColorValue;
        BrushFgColor := cxSSDefaultColorValue;
      end;
      FormatIndex := AXFData^[1];
      if (FormatIndex > $31) then
      begin
        I := FStyleList.Count - 1;
        while I >= 0 do 
        begin
          if Integer(FStyleList.Objects[I]) = FormatIndex then
          begin
            CheckFormat(FStyleList[I], FormatIndex);
            Break;
          end
          else
            Dec(I);
        end;
        if I < 0 then
          FormatIndex := 0;
      end;
    end;
    if ACount = 15 then
      Owner.SetDefaultStyle(@FXFRecords[ACount])
  end;

  procedure ReadColors(AData: Pointer);
  begin
    if PWord(AData)^ >= 55 then
      Owner.SetPalette(@PWordArray(AData)^[1]);
  end;

  procedure ReadMergedCells(AData: Pointer);
  var
    I, ACount: Integer;
    ARect: TRect;
    ACoords: PWordArray;
  begin
    ACoords := AData;
    ACount := ACoords^[0];
    Inc(Integer(ACoords), 2);
    for I := 0  to ACount - 1 do
    begin
      with ARect do
      begin
        Top := ACoords^[0];
        Bottom := ACoords^[1];
        Left := ACoords^[2];
        Right := ACoords^[3];
      end;
      Inc(Integer(ACoords), 4 * 2);
      CurrentSheet.SetMergedCells(ARect, True);
    end;
  end;

  procedure AddCell(ACol, ARow: Integer; AText: string;
    AStyleIndex: Integer; IsFormula: Boolean = False; IsBlank: Boolean = False);
  begin
    with FCurrentSheet.GetCell(ACol, ARow) do
    begin
      if (AStyleIndex <> -1) and (AStyleIndex < Length(FXFRecords)) then
        GetCellStyle.SetCellStyle(@FXFRecords[AStyleIndex]);
      if IsFormula and (Pos(scxRefError, AText) <> 0) then
      begin
        IsFormula := False;
        AText := scxRefError;
      end;
      if (AText <> '') or IsBlank then
        SetTextEx(AText, IsFormula, False);
    end;
  end;

  procedure ReadBoolErr(AData: Pointer);
  var
    S: string;
  begin
    if PByteArray(AData)^[7] = 0 then
      S := BoolToStr(Boolean(PByteArray(AData)^[6]))
    else
      S := XLSErrToStr(PByteArray(AData)^[6]);
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0], S, PWordArray(AData)^[2]);
  end;

  procedure ReadLabelSST(AData: Pointer);
  begin
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0],
      FSharedStringTable[PInteger(@PByteArray(AData)^[6])^], PWordArray(AData)^[2]);
  end;

  procedure ReadBlank(AData: Pointer);
  begin
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0], '', PWordArray(AData)^[2], False, True);
  end;

  procedure ReadMulBlank(AData: Pointer; ASize: Integer);
  var
    I: Integer;
    ARow: Integer;
    AColFirst, AColLast: Integer;
  begin
    ARow := PWordArray(AData)^[0];
    AColFirst := PWordArray(AData)^[1];
    AColLast := AColFirst + (ASize div 2 - 4);
    Inc(Integer(AData), 4);
    for I := AColFirst to  AColLast do
    begin
      AddCell(I, ARow, '', PWord(AData)^);
      Inc(Integer(AData), 2);
    end;
  end;

  procedure ReadNumber(AData: Pointer);
  begin
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0],
      FloatToStr(PDouble(@PWordArray(AData)^[3])^), PWordArray(AData)^[2])
  end;

  procedure ReadRK(AData: Pointer);
  begin
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0],
      ConvertRkNumber(PInteger(@PWordArray(AData)^[3])^), PWordArray(AData)^[2]);
  end;

  procedure ReadMulRk(AData: Pointer; ASize: Integer);
  var
    I, ARow: Integer;
    AFirstCol, ALastCol: Integer;
  begin
    ARow := PWordArray(AData)^[0];
    AFirstCol := PWordArray(AData)^[1];
    ALastCol := AFirstCol + (ASize - 6) div 6 - 1;
    Inc(Integer(AData), 4);
    for I := AFirstCol to ALastCol do
    begin
      AddCell(I, ARow, ConvertRkNumber(PInteger(@PByteArray(AData)^[2])^), PWord(AData)^);
      Inc(Integer(AData), 6);
    end;
  end;

  procedure ReadSimpleLabel(AData: Pointer);
  begin
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0],
      ReadExcelString(@PWordArray(AData)^[3]), PWordArray(AData)^[2]);
  end;

  procedure ReadName(AData: Pointer);

    function CheckPage(APage: Integer): Integer;
    begin
      if APage >= FBoundSheets.Count then
        Result := 0
      else
        Result := APage;
    end;

    function ReadNameDefinition(ATokens: PByteArray; ALen: Word;
      var ADef: TcxSSNameDefinition): Boolean;
    var
      PWords: PWordArray;
    begin
      Result := True;
      case ATokens^[0] of
        ptgArea, ptgAreaV:
          with ADef.Definition do
          begin
            Page := FCurrentPage;
            PWords := @ATokens^[1];
            Area := TRange(Rect(PWords^[2], PWords^[0], PWords^[3], PWords^[1]));
          end;
        ptgArea3d, ptgArea3dV:
          with ADef.Definition do
          begin
            Page := XltPage(CheckPage(PWord(@ATokens^[1])^));
            PWords := @ATokens^[1];
            Area := TRange(Rect(PWords^[3] and $3FFF, PWords^[1],
              PWords^[4] and $3FFF, PWords^[2]));
          end;
        ptgRef3d, ptgRef3dV:
          with ADef.Definition do
          begin
            PWords := @ATokens^[1];
            Page := XltPage(CheckPage(PWords^[0]));
            Area := TRange(Rect(PWords^[2], PWords^[1], PWords^[2], PWords^[1]));
          end;
        ptgRef, ptgRefV:
          with ADef.Definition do
          begin
            Page := FCurrentPage;
            PWords := @ATokens^[1];
            Area := TRange(Rect(PWords^[1], PWords^[0], PWords^[1], PWords^[0]));
          end;
      else
        Result := False;
      end;
    end;

  var
    ACount: Integer;
    ANameDef: TcxSSnameDefinition;
  begin
    ACount := Length(FNames);
    SetLength(FNames, ACount + 1);
    FNames[ACount] := ReadExcelString1(@PByteArray(AData)^[14], PByteArray(AData)^[3]);
    if (PWordArray(AData)^[2] > 0) and (PWord(AData)^ = 0) and
       ReadNameDefinition(@PByteArray(AData)^[PByteArray(AData)^[3] + 15], PWordArray(AData)^[2], ANameDef) then
           Owner.DefineName(FNames[ACount], ANameDef.Definition.Page, TRect(ANameDef.Definition.Area));
  end;

  procedure ReadFormula(AData: Pointer);
  begin
    AddCell(PWordArray(AData)^[1], PWordArray(AData)^[0],
       ConstructFormula(PWordArray(AData)^[1], PWordArray(AData)^[0],
          @PWordArray(AData)^[11], PWordArray(AData)^[10]), PWordArray(AData)^[2], True)
  end;

  procedure ReadSharedFormula(AData: Pointer);
  var
    I, J: Integer;
  begin
    for J := PWordArray(AData)^[0] to PWordArray(AData)^[1] do
      for I := PByteArray(AData)^[4] to PByteArray(AData)^[5] do
      begin
        AddCell(I, J, ConstructFormula(I, J, @PWordArray(AData)^[5],
          PWordArray(AData)^[4]), -1, True);
      end;
  end;

  procedure ReadFormulaArray(AData: Pointer);
  var
    I, J: Integer;
  begin
    for J := PWordArray(AData)^[0] to PWordArray(AData)^[1] do
      for I := PByteArray(AData)^[4] to PByteArray(AData)^[5] do
      begin
         with CurrentSheet.GetCell(I, J) do
           SetText(ConstructFormula(I, J, @PWordArray(AData)^[7], PWordArray(AData)^[6]));
      end;
  end;

  procedure ReadGridSet(AData: Pointer);
  begin
  end;

  procedure ReadViewHeaders(AData: Pointer);
  begin
  end;

  procedure ReadDimension(AData: Pointer);
  begin
    CurrentSheet.SetPageDimension(Min(PWordArray(AData)^[5], 255),
        Min(PIntArray(AData)^[1], 65535));
  end;

  procedure ReadExternSheet(AData: pointer);
  var
    PWords: PWordArray;
    I: Integer;
  begin
    PWords := @PWordArray(AData)^[2];
    SetLength(FSheetXlt, (FExtRecordSize - 2) div 6);
    for I := 0 to Length(FSheetXlt) - 1 do
      FSheetXlt[I] := PWords^[I * 3];
  end;

  procedure ReadForFile(AData: Pointer);
  var
    I: Integer;
    S: string;
  begin
    for I := 0 to ABiffRecHeader^.RecSize div 2 - 1 do
    begin
      if I <> 0 then
        S := S + ', ';
      S := S + IntToHex(PWordArray(AData)^[I], 4);
    end;
  end;

  function ReadBofRecord: PBiffRecHeader;
  var
    ANextRec: PBiffRecHeader;
  begin
    FExtRecordSize := 0;
    if (APosition + 4) <= DataSize then
    begin
      Result := Pointer(Integer(MemoryData) + APosition);
      FExtRecordSize := Result^.RecSize;
      ANextRec := Pointer(Integer(Result) + Result^.RecSize + 4);
      while ANextRec^.RecType = brcContinue do
      begin
        FExtRecordSize := FExtRecordSize + ANextRec^.RecSize + 4;
        ANextRec := Pointer(Integer(ANextRec) + ANextRec^.RecSize + 4);
      end;
    end
    else
      Result := nil;
    Inc(APosition, FExtRecordSize + 4);
  end;

  procedure ReadWindow2(AData: Pointer);
  var
    AFlag: Word;
  begin
    AFlag := PWord(AData)^;
    FCurrentSheet.SetViewInformation(Rect(0, 0, 0, 0), (AFlag and $1) <> 0,
      (AFlag and $2) <> 0, True, True);
  end;

  function IsValidPage(APosition: Integer): Boolean;
  var
    I: Integer; 
  begin
    Result := False;
    for I := 0 to FBoundSheets.Count - 1 do
    begin
      Result := Integer(FBoundSheets.Objects[I]) = APosition;
      if Result then Break
    end;
  end;

  procedure ReadProtection(AData: Pointer);
  begin
    if FCurrentSheet <> nil then
      FCurrentSheet.SetProtection(Boolean(PWord(AData)^ and $1))
    else
      Owner.SetProtection(Boolean(PWord(AData)^ and $1));
  end;

var
  APage: Integer;
begin
  if Owner = nil then
    Exit;
  ASheetIndex := 0;
  FCurrentPage := -1;
  APosition := 0;
  APage := -2;
  FProgress := -1;
  ABiffRecHeader := MemoryData;
  try
    while ((APosition + 4) < DataSize)and(FCurrentPage < Owner.GetPageCount) do
    begin
      ProgressUpdate(ABiffRecHeader);
      ABiffRecHeader := ReadBofRecord;
      case ABiffRecHeader^.RecType of
        brcBof:
        begin
          Inc(APage);
          if APage >= 0 then
          begin
            while not IsValidPage(APosition - SizeOf(BOF) - 4)  do
            begin
              ABiffRecHeader := ReadBofRecord;
              if ABiffRecHeader = nil then Break;
            end;
            if ABiffRecHeader = nil then Break;
            {while PWord(@ABiffRecHeader^.RecData[2])^ <> $10 do
            begin
              APosition := Integer(FBoundSheets.Objects[APage]);
              ABiffRecHeader :=  Pointer(Integer(MemoryData) + Integer(FBoundSheets.Objects[APage]));
              ProgressUpdate(ABiffRecHeader);
              Inc(APage);
            end;}
            Inc(FCurrentPage);
          end;
          if (FCurrentPage >= 0) and (FCurrentPage < Owner.GetPageCount) then
            FCurrentSheet := Owner.GetSheet(FCurrentPage);
        end;
        brcBoundSheet:
          ReadBoundSheet(@ABiffRecHeader^.RecData);
        brcPrintgridlines:
          ReadGridSet(@ABiffRecHeader^.RecData);
        brcPrintHeaders:
          ReadViewHeaders(@ABiffRecHeader^.RecData);
        brcProtect:
          ReadProtection(@ABiffRecHeader^.RecData);
        brcFont:
          ReadFontInfo(@ABiffRecHeader^.RecData);
        brcColInfo:
          ReadColumnFormatInfo(@ABiffRecHeader^.RecData);
        brcROW:
          ReadRowFormatInfo(@ABiffRecHeader^.RecData);
        brcDefColWidth:
          ReadDefaultColWidth(@ABiffRecHeader^.RecData);
        brcSTANDARDWIDTH:
          ReadStdColWidth(@ABiffRecHeader^.RecData);
        brcDefaultRowHeight:
          ReadDefaultRowHeight(@ABiffRecHeader^.RecData);
        brcSST:
          ReadSST(@ABiffRecHeader^.RecData, ABiffRecHeader.RecSize);
        brcDIMENSIONS:
          ReadDimension(@ABiffRecHeader^.RecData);
        brcBlank  :
          ReadBlank(@ABiffRecHeader^.RecData);
        brcBoolErr:
          ReadBoolErr(@ABiffRecHeader^.RecData);
        brcMergeCells:
          ReadMergedCells(@ABiffRecHeader^.RecData);
        brcLabelSST:
          ReadLabelSST(@ABiffRecHeader^.RecData);
        brcLabel:
          ReadSimpleLabel(@ABiffRecHeader^.RecData);
        brcNumber:
          ReadNumber(@ABiffRecHeader^.RecData);
        brcMULBLANK:
          ReadMulBlank(@ABiffRecHeader^.RecData, FExtRecordSize);
        brcMulRk:
          ReadMulRk(@ABiffRecHeader^.RecData, FExtRecordSize);
        brcRK:
          ReadRk(@ABiffRecHeader^.RecData);
        brcRString:
          ReadSimpleLabel(@ABiffRecHeader^.RecData);
        brcArray:
          ReadFormulaArray(@ABiffRecHeader^.RecData);
        brcSHRFMLA:
          ReadSharedFormula(@ABiffRecHeader^.RecData);
        brcFORMULA:
          ReadFormula(@ABiffRecHeader^.RecData);
        brcName:
          ReadName(@ABiffRecHeader^.RecData);
        brcExternSheet:
          ReadExternSheet(@ABiffRecHeader^.RecData);
        brcFORMAT:
          ReadStyleInfo(@ABiffRecHeader^.RecData);
        brcXF:
          ReadXFRecord(@ABiffRecHeader^.RecData);
        brcPALETTE:
          ReadColors(@ABiffRecHeader^.RecData);
        brcIndex:
          ReadForFile(@ABiffRecHeader^.RecData);
        brcWindow2:
          ReadWindow2(@ABiffRecHeader^.RecData);
        brcFILEPASS:
        begin
          if ABiffRecHeader^.RecType = brcFILEPASS then
            raise EdxException.Create(cxGetResourceString(@scxSpreadSheetInvalidStreamFormat));
        end;
      else
        DoReadUnknownRecord(ABiffRecHeader^);
      end;
      ProgressUpdate(ABiffRecHeader);
    end;
  finally
    ProgressUpdate(Pointer(Integer(MemoryData) + DataSize));
  end;
end;

procedure TcxExcelFileReader.DoReadUnknownRecord(var ARec: TBiffRecHeader);
begin
end;

procedure TcxExcelFileReader.ProgressUpdate(APos: Pointer);
var
  ALeft: Byte;
begin
  ALeft :=
    Round((Integer(APos) - Integer(MemoryData)) * 100 / DataSize);
  if ALeft <> FProgress then
  begin
    FProgress := ALeft;
    if Assigned(FOnProgress) then
      FOnProgress(Self, FProgress);
  end;
end;

function TcxExcelFileReader.XltPage(const APage: Word): Word;
begin
 if APage < Length(FSheetXlt) then
   Result := FSheetXlt[APage]
 else
   Result := APage;
 if Result >= BoundSheets.Count then
   Result := APage;
end;

function TcxExcelFileReader.ConvertBrushStyles(ABrushStyle: Byte): TcxSSFillStyle;
var
  I: Byte;
begin
  Result := fsSolid;
  for I := 0 to High(FillStyles) do
    if FillStyles[I] = ABrushStyle then
    begin
      Result := TcxSSFillStyle(I);
      Break;
    end;
end;

function TcxExcelFileReader.GetDataSize: Integer;
begin
  if FReader <> nil then
    Result := TcxWorkBookReader(FReader).Size
  else
    Result := 0;
end;

function TcxExcelFileReader.GetMemoryData: Pointer;
begin
  if (FReader <> nil) and (TcxWorkBookReader(FReader).Memory <> nil) then
    Result := TcxWorkBookReader(FReader).Memory
  else
    Result := nil;
end;

{ TcxExcelFileWriter }
constructor TcxExcelFileWriter.Create(AOwner: TComponent);
begin
  FPixelsPerInch := ScreenResolution;
  FSST := TSSTStringTable.Create;
  CreateStorage;
end;

destructor TcxExcelFileWriter.Destroy;
begin
  FreeData;
  FSST.Free;
  inherited Destroy;
end;

procedure TcxExcelFileWriter.AddSheet(const ACaption: WideString;
  VisibleGrid: Boolean = True; Visible: Boolean = True);

  function AddBoundSheet: PxlsTreeNode;
  begin
    Result := GetRoot(FStorage.RootHeader);
    while Result^.Next^.RecType <> brcSUPBOOK do
      Result := Result^.Next;
    Result := CreateXlsListNode(brcBoundSheet, 8 + Length(ACaption) * 2, Result);
    Result^.ByteData[9] := Byte(not Visible);
    Result^.ByteData[10] := Length(ACaption);
    Result^.ByteData[11] := IsUnicodeStr;
    Move(ACaption[1], Result^.ByteData[12], Result^.ByteData[10] * 2);
  end;

var
  ANode: PxlsTreeNode;
  APageId: Integer;

begin
  FStorage.Pages := GetEnd(FStorage.Pages);
  FStorage.Pages := CreateXlsListNode(0, SizeOf(TxlsSheetInfo), FStorage.Pages);
  FillChar(FStorage.Pages^.SheetInfo, SizeOf(TxlsSheetInfo), 0);
  with FStorage.Pages^ do
  begin
    Move(BOF, SheetInfo.BOF[4], SizeOf(BOF));
    PWord(@SheetInfo.BOF)^ := $0809;
    PWordArray(@SheetInfo.BOF)^[1] := SizeOf(BOF);
    SheetInfo.BOF[6] := $10;
    SheetNodesList := CreateXlsListNode(brcIndex, 16, SheetNodesList);
    SheetInfo.LinkToIndex := SheetNodesList;
    SheetNodesList := CreateXlsListNode(brcDIMENSIONS, 14, SheetNodesList);
    SheetInfo.LinkToDimension := SheetNodesList;
    SheetNodesList := CreateXlsListNode(brcWINDOW2, 18, SheetNodesList);
    SheetInfo.LinkToWindow2 := SheetNodesList;
    if Prev <> nil then
    begin
      SheetInfo.SheetId := Prev^.SheetInfo.SheetId + 1;
      SheetInfo.LinkToWindow2^.IntData[1] := $B6;
    end
    else
    begin
      SheetInfo.SheetId := 0;
      SheetInfo.LinkToWindow2^.IntData[1] := $6B6;
    end;
    if not VisibleGrid then
      SheetInfo.LinkToWindow2^.WordData[2] :=
        SheetInfo.LinkToWindow2^.WordData[2] and not $2;
    APageId := SheetInfo.SheetId;
    SheetInfo.LinkToBoundSheet := AddBoundSheet;
  end;
  ANode := GetRoot(FStorage.RootHeader);
  while ANode^.RecType <> brcTABID do ANode := ANode^.Next;
  ANode^.RecSize := (APageId + 1) * 2;
  ANode^.WordData[2 + APageId] := APageId + 1;
  ANode := GetEnd(ANode);
  while (ANode <> nil) and (ANode^.RecType <> brcSUPBOOK) do ANode := ANode^.Prev;
  if ANode <> nil then ANode^.WordData[2] := APageId + 1;
  while ANode^.RecType <> brcExternSheet do ANode := ANode^.Next;
  if ANode <> nil then
  with ANode^ do
  begin
    Inc(WordData[2]);
    WordData[4 + APageId * 3] := APageId;
    WordData[5 + APageId * 3] := APageId;
    ANode.RecSize := (APageId + 1) * 6 + 2;
  end;
  ANode := CreateXlsListNode(brcRefMode, 2, GetEnd(FStorage.Pages).SheetNodesList);
  ANode.WordData[2] := 1;
end;

procedure TcxExcelFileWriter.Clear;
begin
  try
    ClearStorage;
  finally
    CreateStorage;
  end;
end;

procedure TcxExcelFileWriter.DefineName(APName: PcxSSNameDefinition);
var
  ANode: PxlsTreeNode;
  ANameDef: array of Byte;

  procedure CreateNameDef;
  begin
    with APName^.Definition do
    begin
      SetLength(ANameDef, 11);
      ANameDef[0] := ptgArea3D;
      if Page >= PageCount then
        PWord(@ANameDef[1])^ := 0
      else
        PWord(@ANameDef[1])^ := Page;
      PWord(@ANameDef[3])^ := Area.Top and $FFFF;
      PWord(@ANameDef[5])^ := Area.Bottom and $FFFF;
      PWord(@ANameDef[7])^ := Area.Left and $FF;
      PWord(@ANameDef[9])^ := Area.Right and $FF;
    end;
  end;

begin
  SetLength(ANameDef, 0);
  CreateNameDef;
  ANode := GetEnd(FStorage.RootHeader);
  ANode := CreateXlsListNode(brcName, Length(APName^.Name) +  Length(ANameDef) + 15, ANode);
  with ANode^ do
  begin
    WordData[2] := Byte(APName^.IsDeleted);
    ByteData[7] := Length(APName^.Name);
    PWord(@ByteData[8])^ := Length(ANameDef);
    ByteData[18] := 0;  // todo: code flag
    Move(dxStringToAnsiString(APName^.Name)[1], ByteData[19], Length(APName^.Name));
    if Length(ANameDef) > 0 then
      Move(ANameDef[0], ByteData[18 + Length(APName^.Name) + 1], Length(ANameDef));
  end;
  SetLength(ANameDef, 0);
end;

procedure TcxExcelFileWriter.SaveToStream(AStream: TStream);

  function SetSheetSizeToBoundSheet: Integer;
  var
    ANode: PxlsTreeNode;
  begin
    Result := CalculateNodeSize(GetRoot(FStorage.RootHeader), True) +
      + FSST.PackedSize;
    ANode := GetRoot(FStorage.Pages);
    while ANode <> nil do
    begin
      PInteger(@ANode^.SheetInfo.LinkToBoundSheet^.WordData[2])^ := Result;
      Result := Result + CalculateNodeSize(ANode);
      ANode := ANode^.Next;
    end;
  end;

var
  I: Integer;
  ANode: PxlsTreeNode;
  ASize: Integer;
const
  AEmpty: Byte = 0;
begin
  ASize := SetSheetSizeToBoundSheet;
  with TcxWorkBookWriter.Create do
  try
    CreateOLEStream(ASize, AStream);
    StoreTreeNode(AStream, FStorage.RootHeader, True);
    ANode := GetRoot(FStorage.Pages);
    while ANode <> nil do
    begin
      StoreTreeNode(AStream, ANode);
      ANode := ANode^.Next;
    end;
    if (ASize mod oleBigBlockSize) > 0 then
      for I := 0 to oleBigBlockSize - (ASize mod oleBigBlockSize) - 1 do
        AStream.WriteBuffer(AEmpty, SizeOf(Byte));
  finally
    Free;
  end;
end;

procedure TcxExcelFileWriter.SetCellFunction(APage: Word; ACol, ARow: Word;
  const Value: TcxStackItem; AExprSize: Word; const AParsedExpr: PByteArray);
var
  ANode: PxlsTreeNode;
begin
  SelectPage(APage);
  SetPageDimension(FStorage.Pages, ACol, ARow);
  ANode := CreateXlsListNode(brcFORMULA, AExprSize + 22, GetEnd(FStorage.Pages^.SheetNodesList));
  begin
    ANode^.WordData[2] := ARow;
    ANode^.WordData[3] := ACol;
    ANode^.WordData[4] := FCurrentStyle;
    ANode^.WordData[9] := 3;
    ANode^.WordData[12] := AExprSize;
    Move(AParsedExpr^, ANode^.WordData[13], AExprSize);
  end;
end;

procedure TcxExcelFileWriter.SetCellValue(APage: Word; ACol, ARow: Word;
  const AValue: Variant; IsText: Boolean = False);
var
  AFloatValue: Double;
  AWString: WideString;
begin
  SelectPage(APage);
  FStorage.Pages^.SheetNodesList := GetEnd(FStorage.Pages^.SheetNodesList);
  SetPageDimension(FStorage.Pages, ACol, ARow);
  case VarType(AValue) of
    varEmpty:
      SetBlank(ACol, ARow);
    varSmallint, varInteger, varByte, varDate, varSingle, varDouble, varCurrency:
      SetDouble(ACol, ARow, AValue);
    varOleStr, varString{$IFDEF DELPHI12}, varUString {$ENDIF}:
    begin
      AWString := AValue;
      if AWString = '' then
        SetBlank(ACol, ARow)
      else
        begin
          if not IsText and cxTryStrToFloat(AWString, AFloatValue) then
            SetDouble(ACol, ARow, AFloatValue)
          else
            begin
              if Length(AWString) > 250 then
                SetSSTString(ACol, ARow, AWString)
              else
                SetWString(ACol, ARow, AWString);
            end;
        end;
    end;
    varBoolean:
      SetBoolErr(ACol, ARow, AValue);
  end;
end;

procedure TcxExcelFileWriter.SetColStyle(APage, ACol, AWidth: Word; IsLocked: Boolean;
  IsHidden: Boolean = False);
var
  ANode: PxlsTreeNode;
begin
  SelectPage(APage);
  ANode := GetEnd(FStorage.Pages^.SheetNodesList);
  ANode := CreateXlsListNode(brcColInfo, 11, ANode);
  with ANode^ do
  begin
    WordData[2] := ACol;
    WordData[3] := ACol;
    WordData[4] := Round(AWidth * 36.6 / ScaledFactor);
    if IsLocked then
      WordData[5] := DefUnLockStyle
    else
      WordData[5] := 1;
    WordData[6] := Byte(IsHidden);
  end;
end;

procedure TcxExcelFileWriter.SetDefaultColWidth(APage, ASize: Word);
var
  ANode: PxlsTreeNode;
begin
  SelectPage(APage);
  ANode := GetEnd(FStorage.Pages.SheetNodesList);
  ANode := CreateXlsListNode(brcDefColWidth, 4, ANode);
  with ANode^ do
    WordData[2] := Round(ASize / 8.38);
end;

procedure TcxExcelFileWriter.SetDefaultRowHeight(APage, ASize: Word);
begin
end;

procedure TcxExcelFileWriter.SetDefaultStyle(AStyle: PcxSSCellStyleRec);
var
  DefStyle: TcxSSCellStyleRec;
begin
  DefStyle := AStyle^;
  with FCurrentStylePtr^.Prev^ do
  begin
    WordData[4] := (WordData[4] and not $1) or Byte(cLocked in AStyle^.CellState);
    WordData[5] := Byte(AStyle^.HorzAlign) or (Byte(AStyle^.WordBreak) shl 3)
      or (Byte(AStyle^.VertAlign) shl 4);
    CreateFont(AStyle^.FontPtr);
    WordData[2] := FCurrentFont;
  end;
  CreateStyle(@DefStyle);
  DefUnLockStyle := FCurrentStyle;
  with FCurrentStylePtr^ do
    WordData[4] := (WordData[4] and not $1) or Byte(not (cLocked in AStyle^.CellState));
end;

procedure TcxExcelFileWriter.SetMergedCells(APage: Word; const ARects: array of TRect);
var
  ANode: PxlsTreeNode;
  I, ACount, Offset: Integer;

  function AddMergedNode(ACount: Integer; AParent: PxlsTreeNode;
    IsParent: Boolean = False): PxlsTreeNode;
  begin
    Result := CreateXlsListNode(brcMergeCells, ACount shl 3 + 2, AParent);
    Result^.WordData[2] := ACount;
    Offset := 0;
  end;

  procedure WriteRect(AData: PWordArray; const ARect: TRect);
  begin
    with ARect do
    begin
      AData^[0] := Top and $FFFF;
      AData^[1] := Bottom and $FFFF;
      AData^[2] := Left and $FF;
      AData^[3] := Right and $FF;
    end;
  end;

begin
  ACount := Length(ARects);
  if ACount > 0 then
  begin
    SelectPage(APage);
    ANode := AddMergedNode(Min(ACount, 1024), GetEnd(FStorage.Pages^.SheetNodesList), True);
    for I := 1 to ACount do
    begin
      WriteRect(@ANode^.WordData[3 + Offset * 4], ARects[I - 1]);
      Inc(Offset);
      if (I mod 1024) = 0 then
        ANode := AddMergedNode(Min(ACount - I, 1024), ANode);
    end;
  end;
end;

procedure TcxExcelFileWriter.SetPalette(APalette: PcxExcelPalette);
var
  I: Integer;
  APalNode: PxlsTreeNode;
const
  APredefinedStyles: array[0..5, 0..3] of Byte =
  (($10, $80, $03, $FF),
   ($11, $80, $06, $FF),
   ($10, $80, $04, $FF), // currency
   ($10, $80, $07, $FF), // currency
   ($00, $80, $00, $FF),
   ($10, $80, $05, $FF));// perncent
begin
  FPalette := APalette^;
  APalNode := FindNode(GetRoot(FStorage.RootHeader), brcPalette);
  if APalNode^.RecType <> brcPalette then
  begin
    while APalNode^.RecType <> brcXF do APalNode := APalNode^.Prev;
    APalNode := CreateXlsListNode(brcPalette, SizeOf(TcxExcelPalette) + 2, APalNode);
    APalNode^.WordData[2] := SizeOf(TcxExcelPalette) div 4;
  end;
  Move(APalette^, APalNode^.WordData[3], SizeOf(TcxExcelPalette));
  // TODO: Style dialog in MsExcel generate AV bug
  if (APalNode.Next = nil) or (APalNode.Next.RecType <> brcSTYLE) then
  begin
    for I := Low(APredefinedStyles) to High(APredefinedStyles) do
    begin
      APalNode := CreateXlsListNode(brcStyle, 4, APalNode);
      Move(APredefinedStyles[I], APalNode^.ByteData[4], 4);
    end;
  end;
end;

procedure TcxExcelFileWriter.SetProtection(APage: Integer; IsProtect: Boolean);
var
  ANode: PxlsTreeNode;
begin
  if APage < 0 then
   ANode := GetEnd(FStorage.RootHeader)
  else
  begin
    SelectPage(APage);
    ANode := GetEnd(FStorage.Pages^.SheetNodesList);
  end;
  ANode := CreateXlsListNode(brcProtect, SizeOf(Word), ANode);
  ANode^.WordData[2] := Byte(IsProtect);
end;

procedure TcxExcelFileWriter.SetRowStyle(APage, ARow, AHeight: Word;
  IsHidden: Boolean = False);
var
  ANode: PxlsTreeNode;
begin
  SelectPage(APage);
  ANode := GetEnd(FStorage.Pages^.SheetNodesList);
  ANode := CreateXlsListNode(brcRow, 16, ANode);
  with ANode^ do
  begin
    WordData[2] := ARow;
    WordData[3] := 0;
    WordData[4] := 256;
    WordData[5] := Round((AHeight * 20) / (1.325 * ScaledFactor)); 
    WordData[8] := 320 and not $80;
    if IsHidden then
      WordData[8] :=  WordData[8] or $20;
    WordData[9] := 16;
  end;
end;

procedure TcxExcelFileWriter.SelectStyle(AStyle: PcxSSCellStyleRec);
begin
  CreateStyle(AStyle);
end;

function TcxExcelFileWriter.CalculateNodeSize(ANode: PxlsTreeNode;
  IsRoot: Boolean = False): Integer;
begin
  Result := 0;
  if (ANode <> nil) and (not IsRoot) then
  begin
    Result := SizeOf(BOF) + 4;
    ANode := GetRoot(ANode^.SheetNodesList);
  end;
  while ANode <> nil do
  begin
    Inc(Result, ANode^.WordData[1] + 4);
    ANode := ANode^.Next;
  end;
  Inc(Result, 4);
end;

procedure TcxExcelFileWriter.ClearSheets(var APage: PxlsTreeNode);

  procedure DoClear(var ANode: PxlsTreeNode);
  begin
    if ANode <> nil then
    try
      with ANode^ do
      begin
        if Next <> nil then
          DoClear(Next);
        ClearTree(SheetNodesList);
      end;
    finally
      FreeMem(ANode);
    end;
  end;

begin
  APage := GetRoot(APage);
  try
    DoClear(APage);
  finally
    APage := nil;
  end;
end;

procedure TcxExcelFileWriter.ClearStorage;
begin
  try
    ClearTree(FStorage.RootHeader);
    ClearSheets(FStorage.Pages);
    FSST.Clear;
  finally
    FillChar(FStorage, SizeOf(FStorage), 0);
    FStylesList.Free;
    FFontsList.Free;
  end;
end;

procedure TcxExcelFileWriter.ClearTree(var ANode: PxlsTreeNode);
begin
  if ANode <> nil then
  try
    ANode := GetEnd(ANode);
    while ANode^.Prev <> nil do
    begin
      ANode := ANode^.Prev;
      FreeMem(ANode^.Next);
    end;
  finally
    FreeMem(ANode);
    ANode := nil;
  end;
end;

function TcxExcelFileWriter.CompareXlsNodes(ANode1, ANode2: PxlsTreeNode): Boolean;
begin
  Result := (ANode1^.RecType = ANode2^.RecType) and (ANode1^.RecSize = ANode2^.RecSize)
    and CompareMem(@ANode1^.ByteData, @ANode2^.ByteData, ANode1^.RecSize)
end;

procedure TcxExcelFileWriter.CreateFont(AFont: PcxSSFontRec);
var
  AFonts,
  AFontNode: PxlsTreeNode;
  AIndex: Integer;
  AWName: WideString;
const
  ABold: array[Boolean] of Word = ($190, $2BC);
  AItalic: array[Boolean] of Word = (0, $02);
  AStrikeOut: array[Boolean] of Word = (0, 9);
begin
  AIndex := FFontsList.IndexOf(AFont);
  if AIndex < 0 then
  begin
    with AFont^ do
    begin
      AFontNode := CreateXlsListNode(brcFont, Length(Name) * 2 + 16);
      AFontNode^.WordData[2] := Size * 20;
      AFontNode^.WordData[3] := AItalic[fsItalic in Style] + AStrikeOut[fsStrikeOut in Style];
      AFontNode^.WordData[5] := ABold[fsBold in Style];
      AFontNode^.ByteData[14] := Byte(fsUnderline in Style);
      if Integer(Charset) = 1 then
        AFontNode^.ByteData[16] := 0
      else                                       
        AFontNode^.ByteData[16] := Byte(Charset);
      AFontNode^.WordData[4] := FontColor + 8;
      if AFontNode^.WordData[4] > 64 then
        AFontNode^.WordData[4] := 32767;
      AWName := Name;
      AFontNode^.ByteData[18] := Length(AWName);
      AFontNode^.ByteData[19] := 1;
      Move(AWName[1], AFontNode^.ByteData[20], AFontNode^.ByteData[18] * 2);
      AFonts := FindNode(GetRoot(FStorage.RootHeader), brcFont);
      FCurrentFont := 2;
      while (AFonts^.Next <> nil) and (AFonts^.Next^.RecType = brcFont) do
      begin
        AFonts := AFonts^.Next;
        Inc(FCurrentFont);
      end;
      UnionNodes(AFonts, AFontNode);
      FFontsList.Add(AFont);
    end;
  end
  else
    FCurrentFont := AIndex + 5;
end;

procedure TcxExcelFileWriter.CreateStorage;
begin
  FStylesList := TList.Create;
  FFontsList := TList.Create;
  FStorage.RootHeader := CreateXlsListNode(brcBOF, SizeOf(BOF));
  Move(BOF, FStorage.RootHeader.ByteData[4], SizeOf(BOF));
  FStorage.RootHeader.ByteData[6] := $05;
  FStorage.RootHeader := CreateXlsListNode(brcTABID, 1024, FStorage.RootHeader);
  FStorage.RootHeader := CreateXlsListNode(brcWINDOW1, SizeOf(WINDOW1), FStorage.RootHeader);
  Move(WINDOW1, FStorage.RootHeader.ByteData[4], SizeOf(WINDOW1));
  CreateDefaultFonts;
  CreateDefaultStyles;
  FCurrentFont := 0;
  FCurrentFormat := $31;
  FCurrentStyle := 0;
  FStorage.RootHeader := CreateXlsListNode(brcSUPBOOK, 4, GetEnd(FStorage.RootHeader));
  with FStorage.RootHeader^ do
  begin
    WordData[2] := $0015;
    WordData[3] := $0401;
  end;
  FStorage.RootHeader := CreateXlsListNode(brcExternSheet, 1024, FStorage.RootHeader);
end;

procedure TcxExcelFileWriter.CreateStyle(AStyle: PcxSSCellStyleRec);
var
  AIndex: Integer;
  I: Byte;
  AFillStyle: Integer;
  ALineStyle: TcxSSEdgeLineStyle;
  AColor: Word;
const
  ALocked: array[Boolean] of Byte = (0, 1);
  AHidden: array[Boolean] of Byte = (0, 2);
  AColorShift: array[0..3] of Byte = (0, 7, 16, 23);
  ALeftRightBorders: array[0..3] of TcxSSEdgeBorder = (eLeft, eRight, eTop, eBottom);
  XFStyleState = $0400 or $0800 or $1000 or $2000 or $4000 or $8000;
begin
  AIndex := FStylesList.IndexOf(AStyle);
  if AIndex < 0 then
  begin
    FCurrentStylePtr := CreateXlsListNode(brcXF, SizeOf(DefaultStylesTable[0]), FCurrentStylePtr);
    with FCurrentStylePtr^ do
    begin
      CreateFont(AStyle^.FontPtr);
      Move(DefaultStylesTable[15], WordData[2], SizeOf(DefaultStylesTable[0]));
      WordData[2] := FCurrentFont;
      FCurrentFormat := AStyle^.FormatIndex;
      WordData[3] := FCurrentFormat;
      WordData[4] := ALocked[cLocked in AStyle^.CellState] or AHidden[False];
      WordData[5] := Byte(AStyle^.HorzAlign) or (Byte(AStyle^.WordBreak) shl 3)
        or (Byte(AStyle^.VertAlign) shl 4);
      for I := 0 to 3 do
        with AStyle^.Borders[ALeftRightBorders[I]] do
        begin
          ALineStyle := Style;
          if Byte(ALineStyle) >= Byte(lsNone) then
            ALineStyle := lsDefault;
          WordData[7] := WordData[7] or Byte(ALineStyle) shl (4 * I);
          AColor := Color + 8;
          if AColor > 64 then
            AColor := 64;
          IntData[4] := IntData[4] or AColor shl AColorShift[I];
        end;
      with AStyle^ do
      begin
        if BrushStyle <> fsSolid then
          AFillStyle := FillStyleToXlsFillStyle(BrushStyle, BrushBkColor, BrushFGColor)
        else
          AFillStyle := FillStyleToXlsFillStyle(BrushStyle, BrushFGColor, BrushBkColor);
      end;
      PWord(@ByteData[12])^ := PWord(@ByteData[12])^ or XFStyleState;
      if AFillStyle <> 0 then
      begin
        PInteger(@WordData[10])^ := PInteger(@WordData[10])^ and not $FFFFFF00;
        PInteger(@WordData[10])^ := PInteger(@WordData[10])^ or AFillStyle;
      end;
     if cMerge in AStyle^.CellState then
        ByteData[12] := ByteData[12] or $20;
      FCurrentStyle := Length(DefaultStylesTable) + FStylesList.Add(AStyle);
    end
  end
  else
    FCurrentStyle := Length(DefaultStylesTable) + AIndex;
end;

function TcxExcelFileWriter.CreateXlsListNode(const AType, ASize: Word;
  const APrevNode: PxlsTreeNode): PxlsTreeNode;
begin
  Result := AllocMem(ASize + SizeOf(Word) * 2 + SizeOf(Pointer) * 2);
  Result^.Prev := APrevNode;
  Result^.RecType := AType;
  Result^.RecSize := ASize;
  if APrevNode <> nil then
  begin
    Result^.Next := APrevNode^.Next;
    if Result^.Next <> nil then
      Result^.Next^.Prev := Result;
    APrevNode^.Next := Result;
  end;
end;

function TcxExcelFileWriter.FindNode(ANode: PxlsTreeNode; AType: Word): PxlsTreeNode;
begin
  Result := ANode;
  while (Result <> nil) and (Result^.Next <> nil) and (Result^.RecType <> AType) do
    Result := Result^.Next;
end;

procedure TcxExcelFileWriter.FreeData;
begin
  ClearStorage;
end;

function TcxExcelFileWriter.GetEnd(ANode: PxlsTreeNode): PxlsTreeNode;
begin
  Result := ANode;
  while (Result <> nil) and (Result^.Next <> nil) do
    Result := Result^.Next;
end;

function TcxExcelFileWriter.GetRoot(ANode: PxlsTreeNode): PxlsTreeNode;
begin
  Result := ANode;
  while (Result <> nil) and (Result^.Prev <> nil) do
    Result := Result^.Prev;
end;

procedure TcxExcelFileWriter.SelectPage(APage: Word);
begin
  with FStorage do
  begin
    while (Pages^.Next <> nil) and (Pages^.SheetInfo.SheetId < APage) do
       Pages := Pages^.Next;
    while (Pages^.Prev <> nil) and (Pages^.SheetInfo.SheetId > APage) do
       Pages := Pages^.Prev;
    Pages^.SheetNodesList := GetEnd(Pages^.SheetNodesList);
  end;
end;

procedure TcxExcelFileWriter.SetPageDimension(APage: PxlsTreeNode;
  const AMaxCol, AMaxRow: Integer);
begin
  if APage <> nil then
  begin
    with APage^.SheetInfo.LinkToDimension^ do
    begin
      if IntData[2] <= AMaxRow then
        IntData[2] := AMaxRow + 1;
      if WordData[7] <= AMaxCol then
        WordData[7] := AMaxCol + 1;
    end;
  end; 
end;

procedure TcxExcelFileWriter.StoreTreeNode(AStream: TStream;
  ANode: PxlsTreeNode; const IsRoot: Boolean = False);
var
  APos: Integer;
begin
  with AStream do
  begin
    if IsRoot then
      APos := AStream.Position
    else
      APos := 0;
    if not IsRoot then
    begin
      WriteBuffer(ANode^.SheetInfo.BOF, SizeOf(ANode^.SheetInfo.BOF));
      ANode := ANode^.SheetNodesList;
    end;
    ANode := GetRoot(ANode);
    while ANode <> nil do
    begin
      WriteBuffer(ANode^.ByteData, ANode^.WordData[1] + 4);
      ANode := ANode^.Next;
    end;
    if ISRoot then
      FSST.SaveToStream(AStream, AStream.Position - APos);
    WriteBuffer(EOF_REC, SizeOf(EOF_REC));
  end;
end;

function TcxExcelFileWriter.UnionNodes(AFirstNode, ALastNode: PxlsTreeNode): PxlsTreeNode;
var
  ABeginNode, AEndNode: PxlsTreeNode;
begin
  ABeginNode := GetRoot(ALastNode);
  AEndNode := GetEnd(ALastNode);
  Result := AFirstNode;
  if Result <> nil then
  begin
    if Result^.Next <> nil then
    begin
      Result^.Next^.Prev := AEndNode;
      AEndNode^.Next := Result^.Next;
    end;
    ABeginNode^.Prev := Result;
    Result^.Next := ABeginNode;
  end
  else
    Result := ALastNode;
end;

procedure TcxExcelFileWriter.CreateDefaultStyles;

  procedure AddFormat(const AFormat: array of Byte);
  begin
    FStorage.RootHeader := CreateXlsListNode(brcFORMAT, Length(AFormat), FStorage.RootHeader);
    with FStorage.RootHeader^ do
       Move(AFormat[0], WordData[2], Length(AFormat));
  end;

var
  I: Integer;
  AXFSize: Byte;

const
  DDMMYY: array[0..12]  of Byte =
    (164, 0, 8, 0, 0, 100, 100, 47, 109, 109, 47, 121, 121);
  DDMMMMYY: array[0..16] of Byte =
   (165, 0, 12, 0, 0, 100, 100, 92, 46, 109, 109, 109, 109, 92, 46, 121, 121);

begin
  FPalette := cxExcelStdColors;
  AXFSize := SizeOf(DefaultStylesTable[0]);
  AddFormat(DDMMYY);
  AddFormat(DDMMMMYY);
  for I := 0 to High(DefaultStylesTable) do
  begin
    FStorage.RootHeader := CreateXlsListNode(brcXF, AXFSize, FStorage.RootHeader);
    Move(DefaultStylesTable[I], FStorage.RootHeader^.ByteData[4], AXFSize);
  end;
  FCurrentStylePtr := FStorage.RootHeader;
end;

procedure TcxExcelFileWriter.CreateDefaultFonts;
var
  I: Integer;
begin
  for I := 0 to 3 do
  begin
    FStorage.RootHeader := CreateXlsListNode(brcFont,
      SizeOf(DefaultFont), FStorage.RootHeader);
    Move(DefaultFont, FStorage.RootHeader.ByteData[4], SizeOf(DefaultFont));
  end;
end;

procedure TcxExcelFileWriter.SetBlank(ACol, ARow: Word);
begin
  with CreateXlsListNode(brcBlank, 6, FStorage.Pages^.SheetNodesList)^ do
  begin
    WordData[2] := ARow;
    WordData[3] := ACol;
    WordData[4] := FCurrentStyle;
  end;
end;

procedure TcxExcelFileWriter.SetBoolErr(ACol, ARow: Word; ABoolValue: Boolean);
begin
  with CreateXlsListNode(brcNumber, 8, FStorage.Pages^.SheetNodesList)^ do
  begin
    WordData[2] := ARow;
    WordData[3] := ACol;
    WordData[4] := FCurrentStyle;
    ByteData[10] := 1;
    ByteData[11] := Byte(ABoolValue);
  end;
end;

procedure TcxExcelFileWriter.SetDouble(ACol, ARow: Word; ADoubleValue: Double);
begin
  with CreateXlsListNode(brcNumber, 14, FStorage.Pages^.SheetNodesList)^ do
  begin
    WordData[2] := ARow;
    WordData[3] := ACol;
    WordData[4] := FCurrentStyle;
    PDouble(@ByteData[10])^ := ADoubleValue;
  end;
end;

procedure TcxExcelFileWriter.SetSSTString(ACol, ARow: Word; const AStringValue: WideString);
begin
  with CreateXlsListNode(brcLabelSST, 10, FStorage.Pages^.SheetNodesList)^ do
  begin
    WordData[2] := ARow;
    WordData[3] := ACol;
    WordData[4] := FCurrentStyle;
    WordData[5] := FSST.Add(AStringValue);
  end;
end;

procedure TcxExcelFileWriter.SetWString(ACol, ARow: Word; const AStringValue: WideString);
begin
  with CreateXlsListNode(brcLabel, 9 + Length(AStringValue) * 2, FStorage.Pages^.SheetNodesList)^ do
  begin
    WordData[2] := ARow;
    WordData[3] := ACol;
    WordData[4] := FCurrentStyle;
    WordData[5] := Length(AStringValue);
    ByteData[12] := IsUnicodeStr;
    Move(AStringValue[1], ByteData[13], Length(AStringValue) * 2);
  end;
end;

{ TSSTStringTable }
constructor TSSTStringTable.Create;
begin
  Clear;
end;

destructor TSSTStringTable.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TSSTStringTable.Add(const AString: WideString): Integer;
begin
  Result := IndexOf(AString);
  if Result = -1 then
  begin
    Result := UniqueStringCount;
    InsertStr(AString);
    Inc(PInteger(@FSST[0].Data[4])^);
  end;
  Inc(PInteger(@FSST[0].Data[0])^);
end;

procedure TSSTStringTable.Clear;
begin
  SetLength(FSST, 0);
  SetLength(FStringsInfo, 0);
  FillChar(FExtSST, SizeOf(FExtSST), 0);
  FExtSST.RecType := brcExtSST;
end;

procedure TSSTStringTable.SaveToStream(AStream: TStream; APosition: Integer = -1);
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

procedure TSSTStringTable.CreateExtSST(ASSTOffset: Integer);

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

function TSSTStringTable.GetPackedSize: Integer;
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

function TSSTStringTable.IndexOf(const AString: WideString): Integer;

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
  ASrcLen := Length(AString);
  if ASrcLen > 32768 then
    ASrcLen := 32768;
  Result := -1;
  ASrcLen := ASrcLen shl 1;
  AHashCode := cxExcelAccess.GetHashCode(Pointer(@AString[1])^, ASrcLen);
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

procedure TSSTStringTable.InsertStr(const AString: WideString);

  function AddBlock: Integer;
  begin
    Result := Length(FSST);
    SetLength(FSST, Result + 1);
    FillChar(FSST[Result], SizeOf(TSSTBlock), 0);
    FSST[Result].RecType := brcContinue;
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
      HashCode := cxExcelAccess.GetHashCode(Pointer(@AString[1])^, ASize);
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
      RecType := brcSST;
      DataSize := 8;
      StringOffset := 8;
    end;
  end;
  AStrSize := Length(AString);
  if  AStrSize > 32768 then
    AStrSize := 32768;
  AStrSize := AStrSize shl 1;

  if (FSST[AEndBlock].DataSize + 4) > MaxBlockSize then
    AEndBlock := AddBlock;
  AWriteSize := MaxBlockSize - (FSST[AEndBlock].DataSize + 3);
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
    if AStrSize > (MaxBlockSize - 12) then
      AWriteSize := MaxBlockSize - 12
    else
      AWriteSize := AStrSize;                         
    AddStringToBlock(@PByteArray(@AString[1])^[AOffset], FSST[AEndBlock], AWriteSize);
  end;
end;

function TSSTStringTable.GetStringCount: Integer;
begin
  if Length(FSST) > 0 then
    Result := PIntArray(@FSST[0].Data)^[0]
  else
    Result := 0;
end;

function TSSTStringTable.GetUniqueStringCount: Integer;
begin
  if Length(FSST) > 0 then
    Result := PIntArray(@FSST[0].Data)^[1]
  else
    Result := 0;
end;

{ TcxWorkBookReader }
procedure TcxWorkBookWriter.CreateOLEStream(ADataSize: Integer;
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
    if ADstStream.InheritsFrom(TMemoryStream) then
      TMemoryStream(ADstStream).SetSize(Size + FSectCount shl oleBigBlockShift);
    ADstStream.WriteBuffer(FBuffer^, Size);
  finally
    ReallocBuffer(oleEmpty);
  end;
end;

procedure TcxWorkBookWriter.Check(ACondition: Boolean);
begin
  if not ACondition then
    raise EcxExcelDataWriter.Create(cxGetResourceString(@scxWorkbookWrite));
end;

procedure TcxWorkBookWriter.CreateDIF;
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

procedure TcxWorkBookWriter.CreateDIR;

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
        NameLen := (Length(AName) + 1) shl 1;
        if NameLen <> 1 then
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

procedure TcxWorkBookWriter.CreateFAT;
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

procedure TcxWorkBookWriter.CreateHeader;
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

procedure TcxWorkBookWriter.CreateSmallFAT;
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

procedure TcxWorkBookWriter.ReallocBuffer(const ASize: Integer);
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

procedure TcxWorkBookWriter.CreateLocalFAT;
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

function TcxWorkBookWriter.GetDIFSector(ASector: Integer): PcxFATSector;
begin
  Result := @PcxFATSectors(FBuffer)^[Header^.SectDIFStart +
    (ASector * oleBlockIDPerBigBlock) + 1];
end;

function TcxWorkBookWriter.GetDIREntry(AIndex: Integer): PcxOLEDIREntry;
begin
  Result := @FBuffer[oleReservedSectorCount shl oleBigBlockShift +
    AIndex * oleDIRBlockSize];
end;

function TcxWorkBookWriter.GetHeader: PcxOleFileHeader;
begin
  Result := PcxOleFileHeader(FBuffer);
end;

function TcxWorkBookWriter.GetFATSector(ASector: Integer): PcxFATSector;
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

{ TcxWorkBookReader }
constructor TcxWorkBookReader.Create(AStream: TStream);
begin
  FStream := AStream;
  FCurrentDIF := -1;
  FCurrentFAT := -1;
  FBuffer := nil;
  FStreamStart := AStream.Position; 
  ReadWorkBookStream;
end;

destructor TcxWorkBookReader.Destroy;
begin
  try
    FreeMem(FBuffer);
  finally
    inherited Destroy;
  end;
end;

procedure TcxWorkBookReader.CreateStreamSectorChain;
var
  AIndex: Integer;
  IsBreak: Boolean;
  AValue: Integer;

  procedure AddItemToChain(AItem: Integer);
  begin
    if not IsSpecialSector(AItem) then
    begin
      AValue := AItem;
      if not IsSmallFile then Inc(AItem);
      FLinSect[AIndex] := AItem;
      Inc(AIndex);
    end
    else
      Inc(AValue);
    IsBreak := AIndex >= FSectCount;
  end;

begin
  AIndex := 0;
  SetLength(FLinSect, FSectCount);
  AddItemToChain(DIR[FWorkBookDIR]^.StartSector);
  while not IsBreak do
  begin
    if not IsSmallFile then
      AddItemToChain(FAT[AValue div oleBlockIDPerBigBlock]^[AValue mod oleBlockIDPerBigBlock])
    else
      AddItemToChain(SmallFAT[0][AValue]);
  end;
end;

function TcxWorkBookReader.IsSpecialSector(ASector: Integer): Boolean;
begin
  Result := (ASector = oleDIFBlock) or (ASector = oleSpecBlock) or
   (ASector = oleEndOfChain) or (ASector = oleUnused);
end;

procedure TcxWorkBookReader.ReadBuffer(var ABuf;
  const ASize: Integer; APos: Integer);
var
  ACount: Integer;
begin
  Inc(APos, FStreamStart);
  if APos >= 0 then
  begin
    FIsError := not (APos < FStream.Size);
    if not FIsError then
      FStream.Seek(APos, soFromBeginning)
    else
      Exit;
  end;
  ACount := FStream.Read(ABuf, ASize);
  if ACount <> ASize then
    FillChar(PByteArray(@ABuf)^[ACount], (ASize - ACount) * SizeOf(Integer), oleEmpty);
end;

procedure TcxWorkBookReader.ReadStreamData;
var
  AData: Pointer;
  APos: Integer;
  I: Integer;
begin
  AData := FBuffer;
  for I := 0 to FSectCount - 1 do
  begin
    if IsSmallFile then
      APos := $0800 + FLinSect[I] shl oleSmallBlockShift
    else
      APos := FLinSect[I] shl oleBigBlockShift;
    ReadBuffer(AData^, SectorSize[IsSmallFile], APos);
    if not FIsError then
      Inc(Integer(AData), SectorSize[IsSmallFile]);
  end;
end;

procedure TcxWorkBookReader.ReadWorkBookStream;
var
  I: Integer;
begin
  FWorkBookDIR := -1;
  GetSector(-1, TcxFATSector(FHeader));
  if FIsError then Exit;
  GetSector(Header.SectDIRStart, TcxFATSector(FDIRSector));
  if FIsError then Exit;
  for I := 0 to 3 do
  with DIR[I]^ do
  begin
    if (((NameLen shr 1) - 1)  = Length(oleWorkbook)) and
      CompareMem(@Name[0], @oleWorkbook[1], NameLen - 2) then
    begin
      FWorkBookDIR := I;
      FIsSmallFile := Size < oleMiniSectorMaxSize;
      FSectCount := RoundDIV(Size, SectorSize[IsSmallFile]);
      FBuffer := AllocMem((FSectCount + 10) * SectorSize[IsSmallFile]);
      Break;
    end;
  end;
  FIsError := not ((FWorkBookDIR >= 0) and (Header.Signature = oleSignature));
  if not FIsError then
  begin
    CreateStreamSectorChain;
    ReadStreamData;
  end;
  if FIsError then
  begin
    FreeMem(FBuffer);
    FBuffer := nil;
  end;
end;

function TcxWorkBookReader.GetBufferSize: Integer;
begin
  Result := FDIRSector[FWorkBookDIR].Size;
end;

function TcxWorkBookReader.GetDIFSector(ASector: Integer): PcxFATSector;
var
  ADIFStart: Integer;
  I: Integer;
const
  DIFSectorPos = oleMaxBlockIdInBigBlock * SizeOf(Integer);
begin
  Result := nil;
  if ASector <> FCurrentDIF then
  begin
    FCurrentDIF := ASector;
    ADIFStart := Header.SectDIFStart;
    for I := 0 to ASector - 1 do
    begin
      if FIsError then Exit;
      ReadBuffer(ADIFStart, SizeOf(ADIFStart),
        (ADIFStart + 1) shl oleBigBlockShift + DIFSectorPos);
    end;
    GetSector(ADIFStart, FDIF);
  end;
  Result := @FDIF;
end;

function TcxWorkBookReader.GetDIREntry(AEntry: Integer): PcxOLEDIREntry;
begin
  Result := @FDIRSector[AEntry]
end;

function TcxWorkBookReader.GetFATSector(ASector: Integer): PcxFATSector;
begin
  Result := nil;
  if ASector >= oleSectorsInMasterFAT then
  begin
    ASector := ASector - oleSectorsInMasterFAT;
    ASector := DIF[ASector div oleMaxBlockIdInBigBlock]^[ASector mod oleMaxBlockIdInBigBlock];
  end
  else
    ASector := Header.SectFAT[ASector];
  if ASector <> FCurrentFAT then
  begin
    FCurrentFAT := ASector;
    GetSector(ASector, FFAT);
    if FIsError then Exit;
  end;
  Result := @FFAT;
end;

procedure TcxWorkBookReader.GetSector(ASector: Integer; var AData: TcxFATSector);
begin
  ReadBuffer(AData, oleBigBlockSize, (ASector + 1) shl oleBigBlockShift);
end;

function TcxWorkBookReader.GetSmallFATSector(ASector: Integer): TcxFATSector;
begin
  GetSector(Header.SectMiniFATStart + ASector, Result);
end;

var
  DC: HDC;

initialization
  DC := GetDC(0);
  try
    ScreenResolution := GetDeviceCaps(DC, LOGPIXELSY);
    ScaledFactor := ScreenResolution / 96;
  finally
    ReleaseDC(0, DC)
  end;

finalization

end.

