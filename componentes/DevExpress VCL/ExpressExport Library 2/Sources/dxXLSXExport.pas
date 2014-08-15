
{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressExport                                               }
{                                                                   }
{       Copyright (c) 2009-2010 Developer Express Inc.              }
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

unit dxXLSXExport;

{$I cxVer.inc}

interface

uses
  Windows, cxExport, Types, SysUtils, Classes, Graphics, dxCore, cxClasses,
  RTLConsts, Variants, {$IFNDEF NONDB} FMTBcd, SqlTimSt, {$ENDIF} ZLib,
  cxExportStrs, XMLDoc, XMLIntf, dxGdiPlusClasses;

type
  EdxPackedStreamReader = class(Exception);
  EdxPackedStreamWriter = class(Exception);
  TdxXLSXIntenalDocument = class;

  PdxPackedFileEntry = ^TdxPackedFileEntry;
  TdxPackedFileEntry = packed record
    Sign: Integer;
    VersionToExtract: Word;
    Flag: Word;
    Method: Word;
    DateTime: Cardinal;
    CRC32: Integer;
    PackedSize: Integer;
    OriginalSize: Integer;
    NameLength: Word;
    ExtraLength: Word;
  end;

  PdxPackedDataDescriptor = ^TdxPackedDataDescriptor;
  TdxPackedDataDescriptor = packed record
    CRC32: Integer;
    PackedSize: Integer;
    OriginalSize: Integer;
  end;

  PdxPackedCentralDirEntry = ^TdxPackedCentralDirEntry;
  TdxPackedCentralDirEntry = packed record
    Sign: Integer;
    Version: Word;
    VersionToExtract: Word;
    Flag: Word;
    Method: Word;
    DateTime: Cardinal;
    CRC32: Integer;
    PackedSize: Integer;
    OriginalSize: Integer;
    NameLength: Word;
    ExtraLength: Word;
    CommentLength: Word;
    DiskStart: Word;
    IntAttributes: Word;
    ExtAttributes: Integer;
    RelativeOffset: Integer;
  end;

  PdxPackedEndOfDir = ^TdxPackedEndOfDir;
  TdxPackedEndOfDir = packed record
    Sign: Integer;
    DiskNumber: Word;
    NumberOfDiskStart: Word;
    DirStart: Word;
    DirEntryCount: Word;
    DirSize: Integer;
    DirOffset: Integer;
    CommentLength: Word;
  end;

  TdxPackedItem = class
  private
    FAttributes: Integer;
    FCRC32: LongWord;
    FData: PWordArray;
    FDateTime: Cardinal; 
    FName: AnsiString;
    FNext: TdxPackedItem;
    FPackedSize: Integer;
    FRelativeOffset: Integer;
    FSize: Integer;
    function GetIsDirectory: Boolean;
  public
    constructor Create(APrev: TdxPackedItem); virtual;
    destructor Destroy; override;
    procedure Pack;
    procedure SaveTo(const APath: string);
    procedure Unpack;

    property Attributes: Integer read FAttributes;
    property CRC32: LongWord read FCRC32;
    property Data: PWordArray read FData write FData;
    property DateTime: Cardinal read FDateTime;
    property IsDirectory: Boolean read GetIsDirectory;
    property Name: AnsiString read FName;
    property Next: TdxPackedItem read FNext;
    property PackedSize: Integer read FPackedSize;
    property RelativeOffset: Integer read FRelativeOffset; 
    property Size: Integer read FSize;
  end;

  { TdxPackedStream }

  TdxForEachMethod = procedure of object;

  TdxPackedStream = class
  private
    FCurrent: TdxPackedItem;
    FRoot: TdxPackedItem;
    FStream: TStream;
  protected
    function Add: TdxPackedItem;
    procedure ForEach(AProc: TdxForEachMethod);
    procedure ReadItems; virtual;
    procedure WriteItems; virtual;
  public
    constructor Create(AStream: TStream); virtual;
    destructor Destroy; override;

    property Current: TdxPackedItem read FCurrent write FCurrent;
    property Stream: TStream read FStream;
    property Root: TdxPackedItem read FRoot;
  end;

  { TdxPackedStreamReader }

  TdxPackedStreamReader = class(TdxPackedStream)
  protected
    procedure Check(AValue: Boolean; const AMessage: string = '');
    procedure DoReadCentralDirectory;
    procedure DoReadItem;
    procedure InitializeItem(AItem: TdxPackedItem; const ADirData: TdxPackedCentralDirEntry);
    procedure ReadItems; override;
  end;

  { TdxPackedStreamWriter }

  TdxPackedStreamWriter = class(TdxPackedStream)
  protected
    procedure DoWriteCentralDirectory; virtual;
    procedure DoWriteItem; virtual;
    procedure InitializeItem(AItem: TdxPackedItem; const AName: string; AStream: TStream);
    procedure WriteItems; override;
  public
    procedure AddDirectory(const APath, ARelativeDir: string);
    procedure AddFile(const AFileName, ARelativeDir: string; AStream: TStream = nil);
    procedure AddImage(const APath: string; AImage: TdxPNGImage; AIndex: Integer);
    procedure AddIntenalDocument(ADocument: TdxXLSXIntenalDocument);
  end;

  { TdxSharedObjectsList }

  TdxSharedObject = class
    Hash: Cardinal;
    Index: Integer;
    Next: TdxSharedObject;
    Prev: TdxSharedObject;
    RefCount: Integer;
    function IsEqual(const AObject: TdxSharedObject): Boolean; virtual; 
  end;

  TdxSharedObjectClass = class of TdxSharedObject;

  TdxSharedObjectsList = class
  private
    FCount: Integer;
    FFirst: TdxSharedObject;
    FLast: TdxSharedObject;
    FUniqueCount: Integer;
  protected
    function InsertItem(AItem, ANext: TdxSharedObject): TdxSharedObject;
  public
    destructor Destroy; override;
    function Add(ACandidate: TdxSharedObject): TdxSharedObject;
    procedure Clear;
    procedure Relese(AItem: TdxSharedObject);

    property Count: Integer read FCount;
    property First: TdxSharedObject read FFirst;
    property Last: TdxSharedObject read FLast;
    property UniqueCount: Integer read FUniqueCount;
  end;

  { TdxSharedFont }

  TdxSharedFont = class(TdxSharedObject)
  public
    Style: PcxCacheCellStyle;
    constructor Create(const AStyle: PcxCacheCellStyle);
    function DataSize: Integer;
    function IsEqual(const AObject: TdxSharedObject): Boolean; override;
  end;

  { TdxSharedBrush }

  TdxSharedBrush = class(TdxSharedObject)
  public
    Style: TcxBrushStyle;
    constructor Create(const AStyle: PcxCacheCellStyle);
    function IsEqual(const AObject: TdxSharedObject): Boolean; override;
    
    property Color: Cardinal read Hash write Hash;
  end;

  { TdxSharedCellBorders }
  
  TdxSharedCellBorders = class(TdxSharedObject)
  public
    Style: PcxCacheCellStyle;
    constructor Create(const AStyle: PcxCacheCellStyle);
    function IsEmpty: Boolean;
    function IsEqual(const AObject: TdxSharedObject): Boolean; override;
  end;

  { TdxSharedStyle }

  TdxSharedStyle = class(TdxSharedObject)
  public
    Font: TdxSharedObject;
    Borders: TdxSharedObject;
    Brush: TdxSharedObject;
    Format: Integer;
    Style: PcxCacheCellStyle;
    constructor Create( AStyle: PcxCacheCellStyle; AFont, ABrush, ABorders: TdxSharedObject);
    function IsEqual(const AObject: TdxSharedObject): Boolean; override;
  end;

  { TdxSharedStringTable }

  TdxSharedAnsiString = class(TdxSharedObject)
  public
    Text: AnsiString;
    constructor Create(const AText: AnsiString);
    function IsEqual(const AObject: TdxSharedObject): Boolean; override;
  end;

  TdxSharedUnicodeString = class(TdxSharedObject)
  public
    Text: WideString;
    constructor Create(const AText: WideString);
    function IsEqual(const AObject: TdxSharedObject): Boolean; override;
  end;

  TdxSharedStringTable = class(TdxSharedObjectsList)
  public
    function AddAnsiString(const S: AnsiString): TdxSharedObject;
    function AddUnicodeString(const S: WideString): TdxSharedObject;
  end;

  TdxXLSXIntenalDocument = class
  protected
    constructor CreateInstance(const ADocName, ARelation,
      ANamespace, ARootName: Widestring);
  public
    Document: IXMLDocument;
    DocumentName: string;
    Namespace: Widestring;
    Root: IXMLNode;
    function AddNode(AParent: IXMLNode; const AName: Widestring;
      const AAttributes, AAttributesValues: array of Widestring): IXMLNode; overload;
    function AddNode(const AName: Widestring;
      const AAttributes, AAttributesValues: array of Widestring): IXMLNode; overload;
    procedure SaveToFile(const APath: string);
    procedure SaveToStream(AStream: TStream); virtual;
  end;

  TdxXLSXRels = class(TdxXLSXIntenalDocument)
  private
    FCount: Integer;
  public
    constructor Create(ADocName: string);
    procedure Add(const AType, ATarget: Widestring; AIdPrefix: WideString = 'rId');
  end;

  TdxXLSXContentTypes = class(TdxXLSXIntenalDocument)
  public
    constructor Create;
  end;

  TdxXLSXWorkbook = class(TdxXLSXIntenalDocument)
  private
    FCount: Integer;
    FSheets: IXMLNode;
  public
    constructor Create;
    procedure AddSheet(const AName: Widestring);
  end;

  TdxXLSXSharedStrings = class(TdxXLSXIntenalDocument)
  public
    constructor Create(const ACount, AUniqueCount: Integer);
    procedure Add(const AValue: Widestring);
  end;

  TdxAddSharedObjectProc = function(const AObject: TdxSharedObject): Boolean of object;

  TdxXLSXStyles = class(TdxXLSXIntenalDocument)
  private
    FBorders: IXMLNode;
    FFonts: IXMLNode;
    FFormats: IXMLNode;
    FNumFormats: IXMLNode;
    FNumFormatsCount: Integer;
    FPatterns: IXMLNode;
  protected
    function AddCellBorders(const AObject: TdxSharedObject): Boolean;
    function AddFont(const AObject: TdxSharedObject): Boolean;
    function AddNumFormat(const AFormat: string; const FormatID: Byte = 0): Integer;
    function AddPattern(const AObject: TdxSharedObject): Boolean;
    procedure AddSharedObjects(ANode: IXMLNode; AList: TdxSharedObjectsList;
      AddProc: TdxAddSharedObjectProc; ACount: Integer = 0);
    function AddStyle(const AObject: TdxSharedObject): Boolean;
    procedure Initialize;
  public
    constructor Create;
    procedure AddBorders(ABorders: TdxSharedObjectsList);
    procedure AddBrushes(ABrushes: TdxSharedObjectsList);
    procedure AddFonts(AFonts: TdxSharedObjectsList);
    procedure AddStyles(AStyles: TdxSharedObjectsList);
    procedure SaveToStream(AStream: TStream); override;
  end;

  TdxXLSXDrawing = class(TdxXLSXIntenalDocument)
  private
    FIndex: Integer;
    FRels: TdxXLSXRels;
  public
    constructor Create(ARels: TdxXLSXRels);
    procedure AddImage(ACol, ARow: Integer; AImage: TdxPNGImage);
    property Index: Integer read FIndex;
  end;

  TdxXLSXSheet = class(TdxXLSXIntenalDocument)
  private
    FColCount: Integer;
    FColumns: IXMLNode;
    FData: IXMLNode;
    FRowCount: Integer;
  public
    constructor Create(const ARowCount, AColCount: Integer; AGridlines: Boolean);
    function AddCell(AParentRow: IXMLNode; const ARow, ACol, AStyleIndex: Integer): IXMLNode;
    procedure SetDataAsBoolean(ACell: IXMLNode; const AValue: Boolean);
    procedure SetDataAsCurrency(ACell: IXMLNode; const AValue: Currency);
    procedure SetDataAsFloat(ACell: IXMLNode; const AValue: Double);
    procedure SetDataAsInteger(ACell: IXMLNode; const AValue: Integer);
    procedure SetDataAsString(ACell: IXMLNode; const ASSTIndex: Integer);
    procedure AddMergeCells(const ARefs: TStringList);

    function AddRowHeight(const ARow, AHeight: Integer): IXMLNode;
    procedure SetColumnWidth(const AColumn: Integer; AWidth: Integer);
  end;

  { TdxXLSXCell }

  TdxXLSXCellDataType = (cdtNone, cdtBoolean, cdtInteger, cdtCurrency, cdtFloat, cdtDateTime, cdtString, cdtImage);

  TdxXLSXCell = class
    Col, Row: Integer;
    Style: Integer;
    Data: Pointer;
    DataType: TdxXLSXCellDataType;
    destructor Destroy; override;
    procedure Clear;
  end;

  { TdxXLSXExportProvider }

  TdxXLSXExportProvider = class(TcxCustomExportProvider, IcxExportProvider)
  private
    FCells: TcxObjectList;
    FColCount: Integer;
    FCols: TList;
    FContentTypes: TdxXLSXContentTypes;
    FDrawing: TdxXLSXDrawing;
    FImagesCount: Integer;
    FMergedCells: TStringList;
    FName: WideString;
    FRels: TdxXLSXRels;
    FRowCount: Integer;
    FRows: TList;
    FSharedStrings: TdxXLSXSharedStrings;
    FSheet: TdxXLSXSheet;
    FSST: TdxSharedStringTable;
    FStream: TStream;
    FStyleCache: TcxExportStyleManager;
    FStyles: TdxXLSXStyles;
    FWorkbook: TdxXLSXWorkbook;
    FWorkbookRels: TdxXLSXRels;
    FWriter: TdxPackedStreamWriter;
    FXMLItems: TcxObjectList; 
    function GetCell(ACol, ARow: Integer): TdxXLSXCell;
  protected
    procedure AddStructureItem(AItem: TdxXLSXIntenalDocument; var Instance);
    procedure Commit;
    function CheckPos(const ACol, ARow: Integer): Boolean;
    procedure CreateXMLStructure;
    function GetCellStyle(const ACol, ARow: Integer): PcxCacheCellStyle;
    function GetStyle(AStyleIndex: Integer): PcxCacheCellStyle;
    function InitCellData(const ACol, ARow: Integer; ADataType: TdxXLSXCellDataType): TdxXLSXCell;  
    procedure InitializeProvider;
    function RegisterStyle(const AStyle: TcxCacheCellStyle): Integer;
    procedure SetCellDataBoolean(const ACol, ARow: Integer; const AValue: Boolean);
    procedure SetCellDataCurrency(const ACol, ARow: Integer; const AValue: Currency);
    procedure SetCellDataDateTime(const ACol, ARow: Integer; const AValue: TDateTime);
    procedure SetCellDataDouble(const ACol, ARow: Integer; const AValue: Double);
    procedure SetCellDataInteger(const ACol, ARow: Integer; const AValue: Integer);
    procedure SetCellDataString(const ACol, ARow: Integer; const AText: string);
    procedure SetCellDataWideString(const ACol, ARow: Integer; const AText: Widestring);
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
    procedure ValidateNativeStyle(var AStyleIndex: Integer; const ADataType: TdxXLSXCellDataType; const Data: Pointer);  
    //
    procedure WriteData;
    procedure WriteSharedStrings;
    procedure WriteSheetLayout;
    procedure WriteStyles;
    // export graphic extension
    procedure SetCellDataGraphic(const ACol, ARow: Integer; var AGraphic: TGraphic);
    procedure SetCellPNGImage(const ACol, ARow: Integer; APNGImage: TObject);
    function SupportGraphic: Boolean;

    property Cells[ACol, ARow: Integer]: TdxXLSXCell read GetCell;
    property ColCount: Integer read FColCount;
    property Cols: TList read FCols;
    property ContentTypes: TdxXLSXContentTypes read FContentTypes;
    property Drawing: TdxXLSXDrawing read FDrawing;
    property ImagesCount: Integer read FImagesCount;   
    property MergedCells: TStringList read FMergedCells;
    property Name: WideString read FName write FName;
    property Rels: TdxXLSXRels read FRels;
    property RowCount: Integer read FRowCount;
    property Rows: TList read FRows;
    property SharedStrings: TdxXLSXSharedStrings read FSharedStrings;
    property Sheet: TdxXLSXSheet read FSheet;
    property SST: TdxSharedStringTable read FSST;
    property StyleCache: TcxExportStyleManager read FStyleCache;
    property Styles: TdxXLSXStyles read FStyles;
    property Workbook: TdxXLSXWorkbook read FWorkbook;
    property WorkbookRels: TdxXLSXRels read FWorkbookRels;
    property Writer: TdxPackedStreamWriter read FWriter;
    property XMLItems: TcxObjectList read FXMLItems; 
  public
    constructor Create(const AFileName: string); override;
    destructor Destroy; override;
    class function ExportType: Integer; override;
    class function ExportName: string; override;
  end;

function dxRefToString(const ACol, ARow: Integer): string;
function dxColumnToString(ACol: Integer): string;

implementation

uses
  cxXLSExport, StrUtils;

const
  ZLibVersion   = $9C78;
  FileHeader    = $04034B50;
  DirFileHeader = $02014B50;
  EndOfDir      = $06054B50;

const
  // xml strings
  sAlignment = 'alignment';
  sApplyAlign = 'applyAlignment';
  sApplyFont = 'applyFont';
  sApplyFill  = 'applyFill';
  sBGColor = 'bgColor';
  sBorder = 'border';
  sBorderID = 'borderId';
  sBorders = 'borders';
  sBottom = 'bottom';
  sCellStyleXfs = 'cellStyleXfs';
  sCellXfs = 'cellXfs';
  sCenter = 'center';
  sCharset = 'charset';
  sCol = 'col';
  sColor = 'color';
  sColumns = 'cols';
  sContentType = 'ContentType';
  sCount = 'count';
  sCustomHeight = 'customHeight';
  sCustomWidth = 'customWidth';
  sDefault = 'Default';
  sDiagonal = 'diagonal';
  sDimension = 'dimension';
  sExtension = 'Extension';
  sFGColor = 'fgColor';
  sFill = 'fill';
  sFillID = 'fillId';
  sFills = 'fills';
  sFont = 'font';
  sFontID = 'fontId';
  sFonts = 'fonts';
  sFormatCode = 'formatCode';
  sHorizontal = 'horizontal';
  sHt = 'ht';
  sID = 'Id';
  sIndexed = 'indexed';
  sLeft = 'left';
  sMax = 'max';
  sMedium = 'medium';
  sMergeCell = 'mergeCell';
  sMergeCells = 'mergeCells';
  sMin = 'min';
  sName = 'name';
  sNamespace = 'xmlns';
  sNone = 'none';
  sNumFmt = 'numFmt';
  sNumFmtID = 'numFmtId';
  sNumFmts = 'numFmts';
  sOverride = 'Override';
  sPartName = 'PartName';
  sPatternFill = 'patternFill';
  sPatternType = 'patternType';
  sR = 'r';
  sRef = 'ref';
  sRelationship = 'Relationship';
  sRelationships = 'Relationships';
  sRGB = 'rgb';
  sRID = 'r:id';
  sRight = 'right';
  sRow = 'row';
  sSheet = 'sheet';
  sSheetData = 'sheetData';
  sSheetID = 'sheetId';
  sSheets = 'sheets';
  sSheetView  = 'sheetView';
  sSheetViews = 'sheetViews';
  sShowGridLines = 'showGridLines';
  sSize = 'sz';
  sSolid = 'solid';
  sSpans = 'spans';
  sSST = 'sst';
  sStyle = 'style';
  sStyleSheet = 'styleSheet';
  sTarget = 'Target';
  sThick = 'thick';
  sThin = 'thin';
  sTop = 'top';
  sType = 'Type';
  sTypes = 'Types';
  sUniqueCount = 'uniqueCount';
  sVal = 'val';
  sVertical = 'vertical';
  sWidth = 'width';
  sWorkbook = 'workbook';
  sWorkbookViewID = 'workbookViewId';
  sWorkSheet = 'worksheet';
  sWrapText = 'wrapText';
  sXDR = 'xdr'; 
  sXF = 'xf';
  sXFID = 'xfId';

  cxExcelDefaultColumnWidth = 64;
  cxExcelDefaultRowHeight = 20;

  // other
  sOfficeDocument = 'application/vnd.openxmlformats-officedocument.';
  sPackage        = 'application/vnd.openxmlformats-package.';
  sBaseURL = 'http://schemas.openxmlformats.org/';

  ContentTypesTemplate: array[0..6, 0..4] of Widestring =
  ((sDefault, sExtension, sContentType, 'png', 'image/png'),
   (sDefault, sExtension, sContentType, 'xml', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml'),
   (sDefault, sExtension, sContentType, 'rels', 'application/vnd.openxmlformats-package.relationships+xml'),
   (sOverride, sPartName, sContentType, '/xl/drawings/drawing0.xml', 'application/vnd.openxmlformats-officedocument.drawing+xml'),
   (sOverride, sPartName, sContentType, '/xl/worksheets/sheet0.xml', 'application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml'),
   (sOverride, sPartName, sContentType, '/xl/sharedStrings.xml', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml'),
   (sOverride, sPartName, sContentType, '/xl/styles.xml', 'application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml'));

  CRCTable: array[0..255] of Cardinal =
   ($00000000, $77073096, $EE0E612C, $990951BA, $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988, $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE, $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC, $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172, $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940, $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116, $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924, $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,

    $76DC4190, $01DB7106, $98D220BC, $EFD5102A, $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818, $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E, $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C, $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2, $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0, $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086, $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,

    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A, $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8, $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE, $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC, $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252, $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60, $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236, $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,

    $9B64C2B0, $EC63F226, $756AA39C, $026D930A, $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38, $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E, $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C, $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94, $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);

var
  ZRec: TZStreamRec;

function dxColorToText(AColor: Integer): WideString;
begin
  with TRGBQuad(ColorToRgb(AColor)) do
    AColor := Rgb(rgbRed, rgbGreen, rgbBlue);
  Result := IntToHex(AColor or Integer($FF000000), 8);
end;

function dxColumnToString(ACol: Integer): string;
const
  DIGSTR: string[26]=('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
begin
  Result := '';
  if ACol >= 26 then
    Result := Result + dxColumnToString(ACol div 26 - 1);
  Result := Result + Char(Byte('A') + ACol mod 26);
end;

function dxRefToString(const ACol, ARow: Integer): string;
begin
  Result := dxColumnToString(ACol) + IntToStr(ARow + 1);
end;

function dxAreaRefToString(const ALeft, ATop, ARight, ABottom: Integer): string;
begin
  Result := dxRefToString(ALeft, ATop) +  ':' + dxRefToString(ARight, ABottom);
end;

function dxCRC32(AData: PByte; ACount: Integer): Cardinal;
var
  I: Integer;
begin
  Result := $FFFFFFFF;
  for i := 0 to ACount - 1 do
  begin
    Result := (Result shr 8) xor CRCTable[Byte(Result) xor AData^];
    Inc(AData);
  end;
  Result := Result xor $FFFFFFFF;
end;

procedure InitializeZRec;
begin
  FillChar(ZRec, SizeOf(ZRec), 0);
  ZRec.zalloc := zlibAllocMem;
  ZRec.zfree := zlibFreeMem;
end;

procedure Check(AResult: Integer);
begin
  if AResult < 0 then
    raise EZlibError.Create(SInvalidImage);
end;

{ TdxPackedItem }

constructor TdxPackedItem.Create(APrev: TdxPackedItem);
begin
  if APrev <> nil then
    APrev.FNext := Self;
  FDateTime := DateTimeToFileDate(Now); 
end;

destructor TdxPackedItem.Destroy;
begin
  FreeMem(FData);
  FreeAndNil(FNext);
  inherited Destroy;
end;

procedure TdxPackedItem.Pack;
var
  P: Pointer;
begin
  FPackedSize := 0;
  if FSize > 0 then
  try
    P := nil;
    FCRC32 := dxCRC32(@FData^, Size);
  {$IFDEF DELPHI12}
    ZCompress(FData, FSize, P, FPackedSize);
  {$ELSE}
    CompressBuf(FData, FSize, P, FPackedSize);
  {$ENDIF}
    Dec(FPackedSize, 6);
    ExchangeLongWords(P, FData);
  finally
    FreeMem(P);
  end;
  if Assigned(Next) then
    Next.Pack;
end;

procedure TdxPackedItem.SaveTo(const APath: string);
var
  S: string;
begin
  S := APath;
  if (Length(S) > 0) and (S[Length(S)] <> '\') then
    S := S + '\';
  if IsDirectory then
    ForceDirectories(S + dxAnsiStringToString(Name))
  else
  begin
    ForceDirectories(S + ExtractFilePath(dxAnsiStringToString(Name)));
    if Size = 0  then Exit;  
    with TFileStream.Create(S + dxAnsiStringToString(Name), fmCreate) do
    try
      WriteBuffer(Data^[1], FSize);
    finally
      Free;
    end;
  end;
end;

procedure TdxPackedItem.Unpack;
var
  P: PWordArray;
begin
  if (FData <> nil) and (PackedSize <> 0) then
  begin
    InitializeZRec;
    GetMem(P, Size + 2);
    ZRec.next_out := @P^[1];
    ZRec.avail_out := Size;
    ZRec.next_in := @FData^;
    ZRec.avail_in := FPackedSize;
    try
      Check(InflateInit_(ZRec, zlib_version, sizeof(ZRec)));
      while (ZRec.avail_out > 0) do
        Check(Inflate(ZRec, 0));
      P^[0] := ZLibVersion;
      ExchangeLongWords(P, FData);
    finally
      InflateEnd(ZRec);
      FreeMem(P);
    end;
  end;
  if Assigned(Next) then
    Next.Unpack;
end;

function TdxPackedItem.GetIsDirectory: Boolean;
begin
  Result := Attributes and faDirectory = faDirectory;
end;

{ TdxPackedStream }

constructor TdxPackedStream.Create(AStream: TStream);
begin
  FStream := AStream;
  FRoot := TdxPackedItem.Create(nil);
  ReadItems;
  FCurrent := FRoot.FNext;
end;

destructor TdxPackedStream.Destroy;
begin
  WriteItems;
  FreeAndNil(FRoot);
  inherited Destroy;
end;

function TdxPackedStream.Add: TdxPackedItem;
begin
  if FCurrent = nil then
    FCurrent := Root;
  Result := TdxPackedItem.Create(FCurrent);
  FCurrent := Result;
end;

procedure TdxPackedStream.ForEach(AProc: TdxForEachMethod);
begin
  FCurrent := Root.Next;
  while FCurrent <> nil do
  begin
    AProc;
    FCurrent := FCurrent.Next;
  end;
end;

procedure TdxPackedStream.ReadItems;
begin
end;

procedure TdxPackedStream.WriteItems;
begin
end;

{ TdxPackedStreamReader }

procedure TdxPackedStreamReader.Check(AValue: Boolean; const AMessage: string = '');
begin
  if not AValue then
    raise EdxPackedStreamReader.Create(AMessage);
end;

procedure TdxPackedStreamReader.DoReadCentralDirectory;
var
  I: Integer;
  ADirData: TdxPackedCentralDirEntry;
  AEndOfDir: TdxPackedEndOfDir;
begin
  Stream.Position := Stream.Size;
  repeat
    Stream.Position := Stream.Position - SizeOf(TdxPackedEndOfDir);
    Stream.ReadBuffer(AEndOfDir, SizeOf(AEndOfDir));
    Stream.Position := Stream.Position - 1
  until (AEndOfDir.Sign = EndOfDir) or (Stream.Position < SizeOf(AEndOfDir));
  Check(AEndOfDir.Sign = EndOfDir);
  Stream.Position := AEndOfDir.DirOffset;
  for I := 0 to AEndOfDir.DirEntryCount - 1 do
  begin
    Stream.ReadBuffer(ADirData, SizeOf(ADirData));
    Check(ADirData.Sign = DirFileHeader);
    InitializeItem(Add, ADirData);
    Stream.Position := Stream.Position +
      ADirData.NameLength + ADirData.ExtraLength + ADirData.CommentLength
  end;
end;

procedure TdxPackedStreamReader.DoReadItem;
var
  AFileData: TdxPackedFileEntry;
begin
  Stream.Read(AFileData, SizeOf(AFileData));
  Check((AFileData.Sign = FileHeader) and (Current.FSize = AFileData.OriginalSize)
   and (Current.PackedSize = AFileData.PackedSize));
  SetLength(Current.FName, AFileData.NameLength);
  if AFileData.NameLength > 0 then
    Stream.ReadBuffer(Current.FName[1], AFileData.NameLength);
  Stream.Position := Stream.Position + AFileData.ExtraLength;
  if Current.PackedSize > 0 then
  begin
    Inc(Current.FPackedSize, 2);
    GetMem(Current.FData, Current.PackedSize);
    Current.FData^[0] := ZLibVersion;
    Stream.ReadBuffer(Current.FData^[1], AFileData.PackedSize);
  end;
  if AFileData.Flag and 8 = 8 then
    Stream.Position := Stream.Position + SizeOf(TdxPackedDataDescriptor);
end;

procedure TdxPackedStreamReader.InitializeItem(AItem: TdxPackedItem;
  const ADirData: TdxPackedCentralDirEntry);
begin
  AItem.FAttributes := ADirData.ExtAttributes;
  AItem.FPackedSize := ADirData.PackedSize;
  AItem.FSize := ADirData.OriginalSize;
  AItem.FCRC32 := ADirData.CRC32;
end;

procedure TdxPackedStreamReader.ReadItems;
begin
  DoReadCentralDirectory;
  Stream.Position := 0;
  ForEach(DoReadItem);
  Root.Unpack;
end;

{ TdxPackedStreamWriter }

procedure TdxPackedStreamWriter.AddDirectory(const APath, ARelativeDir: string);
begin
  InitializeItem(Add, APath, nil);
end;

procedure TdxPackedStreamWriter.AddFile(
  const AFileName, ARelativeDir: string; AStream: TStream = nil);
begin
  if AStream = nil then
  begin
    AStream := TFileStream.Create(ARelativeDir + AFileName, fmOpenRead or fmShareDenyNone);
    try
      AddFile(AFileName, '', AStream);
    finally
      AStream.Free;
    end;
  end
  else
    InitializeItem(Add, AFileName, AStream);
end;

procedure TdxPackedStreamWriter.AddImage(
  const APath: string; AImage: TdxPNGImage; AIndex: Integer);
var
  AStream: TMemoryStream;
begin
  AStream := TMemoryStream.Create();
  try
    AImage.Handle.SaveToStream(AStream);
    AStream.Position := 0;
    AddFile(APath + Format('image%d.png', [AIndex]), '', AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxPackedStreamWriter.AddIntenalDocument(ADocument: TdxXLSXIntenalDocument);
var
  AStream: TStream; 
begin
  AStream := TMemoryStream.Create;
  try
    ADocument.SaveToStream(AStream);
    AStream.Position := 0;
    AddFile(ADocument.DocumentName, '', AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxPackedStreamWriter.DoWriteCentralDirectory;
var
  AEndOfDir: TdxPackedEndOfDir;
  ADirData: TdxPackedCentralDirEntry;
begin
  FillChar(AEndOfDir, SizeOf(AEndOfDir), 0);
  FillChar(ADirData, SizeOf(ADirData), 0);
  AEndOfDir.Sign := EndOfDir;
  AEndOfDir.DirOffset := Stream.Size;
  ADirData.Sign := DirFileHeader;
  ADirData.Version := 20;
  ADirData.VersionToExtract := 20;
  ADirData.Method := 8;
  FCurrent := FRoot.Next;
  while Current <> nil do
  begin
    Inc(AEndOfDir.DirEntryCount);
    ADirData.CRC32 := Current.CRC32;
    ADirData.PackedSize := Current.PackedSize;
    ADirData.OriginalSize := Current.Size;
    ADirData.ExtAttributes := Current.FAttributes;
    ADirData.DateTime := Current.DateTime;
    ADirData.NameLength := Length(Current.Name);
    ADirData.RelativeOffset := Current.RelativeOffset;
    Stream.WriteBuffer(ADirData, SizeOf(ADirData));
    Stream.WriteBuffer(Current.Name[1], ADirData.NameLength);
    Current := Current.Next;
  end;
  AEndOfDir.DirStart := AEndOfDir.DirEntryCount;
  AEndOfDir.DirSize := Stream.Position - AEndOfDir.DirOffset;
  Stream.Write(AEndOfDir, SizeOf(AEndOfDir));
end;

procedure TdxPackedStreamWriter.DoWriteItem;
var
  AFileData: TdxPackedFileEntry;
begin
  FillChar(AFileData, SizeOf(AFileData), 0);
  AFileData.Sign := FileHeader;
  AFileData.VersionToExtract := 20;
  AFileData.Method := 8;
  AFileData.DateTime := Current.DateTime;
  AFileData.CRC32 := Current.CRC32;
  AFileData.PackedSize := Current.PackedSize;
  AFileData.OriginalSize := Current.Size;
  AFileData.NameLength := Length(Current.Name);
  Current.FRelativeOffset := Stream.Position;
  Stream.WriteBuffer(AFileData, SizeOf(AFileData));
  Stream.WriteBuffer(Current.Name[1], AFileData.NameLength);
  if Current.PackedSize > 0 then
    Stream.WriteBuffer(Current.Data^[1], Current.PackedSize);
end;

procedure TdxPackedStreamWriter.InitializeItem(
  AItem: TdxPackedItem; const AName: string; AStream: TStream);
begin
  AItem.FName := dxStringToAnsiString(AName);
  if AStream <> nil then
  begin
    AItem.FSize := AStream.Size;
    GetMem(AItem.FData, AStream.Size);
    AStream.ReadBuffer(AItem.FData^, AStream.Size);
  end
  else
    AItem.FAttributes := faDirectory;
end;

procedure TdxPackedStreamWriter.WriteItems;
begin
  Root.Pack;
  ForEach(DoWriteItem);
  DoWriteCentralDirectory;
end;

{ TdxSharedObject }

function TdxSharedObject.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  Result := Hash = AObject.Hash; 
end;

{ TdxSharedObjectList }

destructor TdxSharedObjectsList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TdxSharedObjectsList.Add(ACandidate: TdxSharedObject): TdxSharedObject;
var
  AIsObjectUnique: Boolean;
begin
  Result := nil;
  AIsObjectUnique := True;
  if (FFirst <> nil) and (FLast.Hash >= ACandidate.Hash) then
  begin
    if FLast.Hash = ACandidate.Hash then
    begin
      Result := FLast;
      while AIsObjectUnique and (Result <> nil) and (Result.Hash = ACandidate.Hash) do
      begin
        AIsObjectUnique := not ((Result.Hash = ACandidate.Hash) and
          (Result.ClassType = ACandidate.ClassType) and Result.IsEqual(ACandidate));
        if AIsObjectUnique then
          Result := Result.Prev;
      end
    end
    else
    begin
      Result := FFirst;
      while AIsObjectUnique and (Result <> nil) and (Result.Hash <= ACandidate.Hash) do
      begin
        AIsObjectUnique := not ((Result.Hash = ACandidate.Hash) and
          (Result.ClassType = ACandidate.ClassType) and Result.IsEqual(ACandidate));
        if AIsObjectUnique then
          Result := Result.Next;
      end;
    end;
  end;
  if AIsObjectUnique then
  begin
    Result := InsertItem(ACandidate, Result);
    Inc(FUniqueCount);
  end
  else
    ACandidate.Free;
  Inc(Result.RefCount);
  Inc(FCount);
end;

procedure TdxSharedObjectsList.Clear;
var
  AItem: TdxSharedObject;
begin
  while FFirst <> nil do
  begin
    AItem := FFirst;
    FFirst := FFirst.Next;
    AItem.Free;
  end;
  FLast := nil;
  FCount := 0;
  FUniqueCount := 0;
end;

procedure TdxSharedObjectsList.Relese(AItem: TdxSharedObject);
begin
  Dec(FCount);
  Dec(AItem.RefCount);
  if AItem.RefCount = 0 then
  begin
    if AItem.Prev <> nil then
      AItem.Prev.Next := AItem.Next;
    if AItem.Next <> nil then
      AItem.Next.Prev := AItem.Prev;
    if AItem = FFirst then
      FFirst := AItem.Next;
    if AItem = FLast then
      FLast := AItem.Prev;
    Dec(FUniqueCount);
    AItem.Free;
  end;
end;

function TdxSharedObjectsList.InsertItem(AItem, ANext: TdxSharedObject): TdxSharedObject;
begin
  AItem.Next := ANext;
  if ANext <> nil then
  begin
    AItem.Prev := ANext.Prev;
    ANext.Prev := AItem;
  end
  else
  begin
    AItem.Prev := FLast;
    FLast := AItem;
  end;
  if AItem.Prev <> nil then
    AItem.Prev.Next := AItem
  else
    FFirst := AItem;
  Result := AItem;
end;

{ TdxSharedFont }

constructor TdxSharedFont.Create(const AStyle: PcxCacheCellStyle);
begin
  Style := AStyle;
  Hash := dxCRC32(@AStyle^.FontName, SizeOf(DataSize));
end;

function TdxSharedFont.DataSize: Integer;
begin
  Result := 64 + SizeOf(TcxFontStyles) + SizeOf(Integer) * 3;
end;

function TdxSharedFont.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  Result := CompareMem(@Style^.FontName,
    @TdxSharedFont(AObject).Style^.FontName, DataSize);
end;

{TdxSharedBrush}

constructor TdxSharedBrush.Create(
  const AStyle: PcxCacheCellStyle);
begin
  Color := AStyle^.BrushBkColor;
  Style := AStyle^.BrushStyle;
end;

function TdxSharedBrush.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  Result := Style = TdxSharedBrush(AObject).Style;
end;

{ TdxSharedCellBorders }

constructor TdxSharedCellBorders.Create(const AStyle: PcxCacheCellStyle);
var
  I: Integer;
begin
  Style := AStyle;
  for I := 0 to 3 do
    with Style^.Borders[I] do 
    begin
      if IsDefault then
        Width := 0;
      IsDefault := Width = 0;
    end;
  Hash := dxCRC32(@Style^.Borders, SizeOf(Style^.Borders));
end;

function TdxSharedCellBorders.IsEmpty: Boolean;
begin
  with Style^ do  
    Result := Borders[0].IsDefault and Borders[1].IsDefault and 
      Borders[2].IsDefault and Borders[3].IsDefault;
end;

function TdxSharedCellBorders.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  Result := CompareMem(@Style^.Borders,
    @TdxSharedCellBorders(AObject).Style^.Borders, SizeOf(Style^.Borders));
end;

constructor TdxSharedStyle.Create(AStyle: PcxCacheCellStyle;
  AFont, ABrush, ABorders: TdxSharedObject);
begin
  Font := AFont;
  Borders := ABorders;
  Brush := ABrush;
  Style := AStyle;
  Hash := dxCRC32(@Font, SizeOf(Integer) * 3);
end;

function TdxSharedStyle.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  with TdxSharedStyle(AObject) do
    Result := (Self.Font = Font) and (Self.Borders = Borders) and
      (Self.Brush = Brush) and (Self.Style^.Format = Style^.Format);
end;

{ TdxSharedAnsiString }

constructor TdxSharedAnsiString.Create(const AText: AnsiString);
begin
  Text := AText;
  if Length(Text) > 0 then
    Hash := dxCRC32(@Text[1], Length(Text));
end;

function TdxSharedAnsiString.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  Result := Text = TdxSharedAnsiString(AObject).Text;
end;

{ TdxSharedUnicodeString }

constructor TdxSharedUnicodeString.Create(const AText: WideString);
begin
  Text := AText;
  if Length(Text) > 0 then
    Hash := dxCRC32(@Text[1], Length(Text));
end;

function TdxSharedUnicodeString.IsEqual(const AObject: TdxSharedObject): Boolean;
begin
  Result := Text = TdxSharedUnicodeString(AObject).Text;
end;

{ TdxSharedStringTable }

function TdxSharedStringTable.AddAnsiString(
  const S: AnsiString): TdxSharedObject;
begin
  Result := Add(TdxSharedAnsiString.Create(S));
end;

function TdxSharedStringTable.AddUnicodeString(
  const S: WideString): TdxSharedObject;
begin
  Result := Add(TdxSharedUnicodeString.Create(S));
end;

{ TdxXLSXIntenalDocument }

constructor TdxXLSXIntenalDocument.CreateInstance(const ADocName,
  ARelation, ANamespace, ARootName: Widestring);
begin
  Document := TXMLDocument.Create(nil);
  DocumentName := ADocName;
  Document.Options := [doNodeAutoIndent];
  Document.Active := True;
  Document.Encoding := 'UTF-8';
  Document.Version := '1.0';
  Document.StandAlone := 'yes';
  if ANameSpace <> '' then
    Namespace := sBaseURL + ANameSpace;
  Root := Document.AddChild(ARootName, NameSpace);
  if Length(ARelation) > 0 then
    Root.SetAttribute('xmlns:r', sBaseURL + ARelation);
  if Length(ANamespace) > 0 then
    Root.SetAttribute(sNamespace, NameSpace);
end;

function TdxXLSXIntenalDocument.AddNode(AParent: IXMLNode; const AName: Widestring;
  const AAttributes, AAttributesValues: array of Widestring): IXMLNode;
var
  I: Integer;
begin
  Result := AParent.AddChild(AName);
  for I := Low(AAttributes) to High(AAttributes) do
    Result.SetAttribute(AAttributes[I], AAttributesValues[I]);
end;

function TdxXLSXIntenalDocument.AddNode(const AName: Widestring;
  const AAttributes, AAttributesValues: array of Widestring): IXMLNode;
begin
  Result := AddNode(Root, AName, AAttributes, AAttributesValues);
end;

procedure TdxXLSXIntenalDocument.SaveToFile(const APath: string);
var
  AStream: TStream;
begin
  ForceDirectories(ExtractFileDir(APath + DocumentName));
  AStream := TFileStream.Create(APath + DocumentName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxXLSXIntenalDocument.SaveToStream(AStream: TStream);
begin
  Document.SaveToStream(AStream);
end;

{ TdxXLSXRels }

constructor TdxXLSXRels.Create(ADocName: string);
begin
  inherited CreateInstance(ADocName, '', 'package/2006/relationships', sRelationships);
end;

procedure TdxXLSXRels.Add(const AType, ATarget: Widestring; AIdPrefix: WideString = 'rId');
begin
  if AIdPrefix = 'rId' then
  begin
    AIdPrefix := AIdPrefix + IntToStr(FCount);
    Inc(FCount);
  end;
  AddNode(sRelationship, [sID, sType, sTarget], [AIdPrefix, AType, ATarget]);
end;

{ TdxXLSXContentTypes }

constructor TdxXLSXContentTypes.Create;
var
  I: Integer;
begin
  inherited CreateInstance('[Content_Types].xml', '', 'package/2006/content-types', sTypes);
  for I := Low(ContentTypesTemplate) to High(ContentTypesTemplate) do
    AddNode(ContentTypesTemplate[I, 0], [ContentTypesTemplate[I, 1], ContentTypesTemplate[I, 2]],
      [ContentTypesTemplate[I, 3], ContentTypesTemplate[I, 4]]);
end;

{ TdxXLSXWorkbook }

constructor TdxXLSXWorkbook.Create;
begin
  inherited CreateInstance('xl\workbook.xml', 'officeDocument/2006/relationships',
    'spreadsheetml/2006/main', sWorkbook);
  AddNode('workbookPr', ['date1904'], ['0']);
  FSheets := AddNode(sSheets, [], []);
end;

procedure TdxXLSXWorkbook.AddSheet(const AName: Widestring);
begin
  Inc(FCount);
  AddNode(FSheets, sSheet, [sRID, sSheetID, sName], ['rId' +
    IntToStr(FCount - 1), IntToStr(FCount), AName]);
end;

{ TdxXLSXSharedStrings }

constructor TdxXLSXSharedStrings.Create(const ACount, AUniqueCount: Integer);
begin
  inherited CreateInstance('xl\sharedStrings.xml', '',
    'spreadsheetml/2006/main', sSST);
  Root.SetAttribute(sCount, IntToStr(ACount));
  Root.SetAttribute(sUniqueCount, IntToStr(AUniqueCount));
end;

procedure TdxXLSXSharedStrings.Add(const AValue: Widestring);
var
  ANode: IXMLNode;
begin
  ANode := Root.AddChild('si');
  ANode.AddChild('t').Text := AValue; 
end;

{ TdxXLSXStyles }

constructor TdxXLSXStyles.Create;
begin
  inherited CreateInstance('xl\styles.xml', '',
    'spreadsheetml/2006/main', sStyleSheet);
  FNumFormats := Root.AddChild(sNumFmts);
  FFonts := Root.AddChild(sFonts);
  FPatterns := Root.AddChild(sFills);
  FBorders := Root.AddChild(sBorders);
{  AddNode(AddNode(Root, sCellStyleXfs, [sCount], ['1']),
    sXF, [sNumFmtID, sFontID, sFillID, sBorderID], ['0', '0', '0', '0']);}
  FFormats := Root.AddChild(sCellXfs);
  Initialize;
end;

procedure TdxXLSXStyles.AddSharedObjects(ANode: IXMLNode;
  AList: TdxSharedObjectsList; AddProc: TdxAddSharedObjectProc; ACount: Integer = 0);
var
  AObject: TdxSharedObject;
begin
  AObject := AList.FLast;
  if AObject = nil then Exit;
  repeat
    AObject.Index := ACount;
    if AddProc(AObject) then 
      Inc(ACount);
    AObject := AObject.Prev;
  until AObject = nil;
  ANode.SetAttribute(sCount, IntToStr(ACount));
end;

function TdxXLSXStyles.AddStyle(const AObject: TdxSharedObject): Boolean;
var
  AStyle: TdxSharedStyle;
  ANode: IXMLNode;
const
  AAlignToString: array[TcxAlignText] of WideString = (sLeft, sCenter, sRight);
begin
  Result := True;
  AStyle := AObject as TdxSharedStyle;
  ANode := AddNode(FFormats, sXF, [sNumFmtID, sFontID, sFillID, sBorderID, sXFID, sApplyAlign],
    [IntToStr(AStyle.Format), IntToStr(AStyle.Font.Index), IntToStr(AStyle.Brush.Index), IntToStr(AStyle.Borders.Index), '0', '1']);
{  if AStyle.BrushStyle = cbsSolid then
    ANode.SetAttribute(sApplyFill, '1');}
  AddNode(ANode, sAlignment, [sHorizontal, sVertical, sWrapText], [AAlignToString[AStyle.Style^.AlignText], sTop, '1']);
{  ANode := AddNode(FFormats, sXF, [sNumFmtID], ['0']);  }
end;

procedure TdxXLSXStyles.AddBorders(ABorders: TdxSharedObjectsList);
begin
  AddSharedObjects(FBorders, ABorders, AddCellBorders, 1);
end;

procedure TdxXLSXStyles.AddBrushes(ABrushes: TdxSharedObjectsList);
begin
  AddSharedObjects(FPatterns, ABrushes, AddPattern, 2);
end;

procedure TdxXLSXStyles.AddFonts(AFonts: TdxSharedObjectsList);
begin
  AddSharedObjects(FFonts, AFonts, AddFont, 1);
end;

procedure TdxXLSXStyles.AddStyles(AStyles: TdxSharedObjectsList);
begin
  AddSharedObjects(FFormats, AStyles, AddStyle, 1);
end;

procedure TdxXLSXStyles.SaveToStream(AStream: TStream);
begin
  FNumFormats.SetAttribute(sCount, IntToStr(FNumFormatsCount));
{  FFonts.SetAttribute(sCount, IntToStr(FFontCount));
  FPatterns.SetAttribute(sCount, IntToStr(FPatternCount));
  FBorders.SetAttribute(sCount, IntToStr(FBordersCount));
  FFormats.SetAttribute(sCount, IntToStr(FFormatCount));}
  inherited SaveToStream(AStream);
end;

function TdxXLSXStyles.AddCellBorders(const AObject: TdxSharedObject): Boolean;
var
  I: Integer;
  AValue: Widestring;
  ANode, ASubNode: IXMLNode;
  ABorder: ^TcxCellBorders;
  ACellBorders: TdxSharedCellBorders;
const
  AIndexes: array[0..3] of Integer = (0, 2, 1, 3);
  ABorders: array[0..3] of Widestring = (sLeft, sRight, sTop, sBottom);
begin
  ACellBorders := AObject as TdxSharedCellBorders;
  Result := not ACellBorders.IsEmpty;
  if not Result then
  begin
    ACellBorders.Index := 0;
    Exit;
  end;
  ANode := FBorders.AddChild(sBorder);
  for I := 0 to 3 do
  begin
    ASubNode := ANode.AddChild(ABorders[I]);
    ABorder := @ACellBorders.Style^.Borders[AIndexes[I]];
    if not ABorder^.IsDefault and (ABorder^.Width > 0) then
    begin
      case ABorder^.Width of
        0:
          AValue := '';
        1:
          AValue := sThin;
        2:
          AValue := sMedium;
      else
        AValue := sThick;
      end;
      if AValue <> '' then
      begin
        ASubNode.SetAttribute(sStyle, AValue);
        AddNode(ASubNode, sColor, [sRGB], [dxColorToText(ABorder^.Color)]);
      end;
    end;
  end;
  ANode.AddChild(sDiagonal);
end;

function TdxXLSXStyles.AddFont(const AObject: TdxSharedObject): Boolean;
var
  AName: string;
  AFontNode: IXMLNode;
  AFont: TdxSharedFont;
  AFontStyle: TcxFontStyle;
const
  ExcelFontStyles: array[TcxFontStyle] of WideString = ('b', 'i', 'u', 'strike');
begin
  Result := True;
  AFont := AObject as TdxSharedFont;
  AName := PChar(@AFont.Style^.FontName);
  AFontNode := FFonts.AddChild(sFont);
  for AFontStyle := cfsBold to cfsStrikeOut do
    if AFontStyle in AFont.Style^.FontStyle then
      AFontNode.AddChild(ExcelFontStyles[AFontStyle]);
  AFontNode.AddChild(sSize).SetAttribute(sVal, IntToStr(AFont.Style^.FontSize));
  AFontNode.AddChild(sColor).SetAttribute(sRGB, dxColorToText(AFont.Style^.FontColor));
  AFontNode.AddChild(sName).SetAttribute(sVal, AName);
  if AFont.Style^.FontCharset <> 0 then
    AFontNode.AddChild(sCharset).SetAttribute(sVal, IntToStr(AFont.Style^.FontCharset));
end;

function TdxXLSXStyles.AddNumFormat(
  const AFormat: string; const FormatID: Byte = 0): Integer;
var
  I: Integer;
  S: string;
const
  Reserved: array[0..3] of string = (' ', '-', '(', ')');
begin
  Result := FormatID;
  if FormatID = 0 then
  begin
    Result := $A4 + FNumFormatsCount;
    S := AFormat;
    for I := 0 to High(Reserved) do
      S := StringReplace(S, Reserved[I], '\' + Reserved[I], [rfReplaceAll]);
  end;
  AddNode(FNumFormats, sNumFmt, [sNumFmtId, sFormatCode], [IntToStr(Result), AFormat]);
  Inc(FNumFormatsCount);
end;

procedure TdxXLSXStyles.Initialize;
var
  ANode: IXMLNode; 
begin
  AddNumFormat('"$"#,##0.00_);\("$"#,##0.00\)', $07);
  ANode := FFonts.AddChild(sFont);
  ANode.AddChild(sSize).SetAttribute(sVal, '11');
  ANode.AddChild(sName).SetAttribute(sVal, 'Calibri');
  FPatterns.AddChild(sFill).AddChild(sPatternFill).SetAttribute(sPatternType, sNone);
  FPatterns.AddChild(sFill).AddChild(sPatternFill).SetAttribute(sPatternType, 'gray125');
  ANode := FBorders.AddChild(sBorder);
  ANode.AddChild(sLeft);
  ANode.AddChild(sRight);
  ANode.AddChild(sTop);
  ANode.AddChild(sBottom);
  AddNode(FFormats, sXF, [sNumFmtID, sFontID, sFillID, sBorderID, sXFID], ['0', '0', '0', '0', '0']);
end;

function TdxXLSXStyles.AddPattern(const AObject: TdxSharedObject): Boolean;
var
  AStyle: TdxSharedBrush;
  APattern, AFill: IXMLNode;
begin
  Result := False;
  AStyle := AObject as TdxSharedBrush;
  if AStyle.Style <> cbsClear then
  begin
    APattern := FPatterns.AddChild(sFill);
    AFill := APattern.AddChild(sPatternFill);
    AFill.SetAttribute(sPatternType, sSolid);
    AFill.AddChild(sFGColor).SetAttribute(sRGB, dxColorToText(AStyle.Color));
    Result := True;
  end
  else
    AObject.Index := 0;
end;

{ TdxXLSXDrawing }

constructor TdxXLSXDrawing.Create(ARels: TdxXLSXRels);
begin
 inherited CreateInstance('xl\drawings\drawing0.xml', '', '', 'xdr:wsDr');
 FRels := ARels;
 Inc(FRels.FCount);
 Root.SetAttribute('xmlns:xdr', sBaseURL + 'drawingml/2006/spreadsheetDrawing');
 Root.SetAttribute('xmlns:a', sBaseURL + 'drawingml/2006/main');
end;

procedure TdxXLSXDrawing.AddImage(ACol, ARow: Integer; AImage: TdxPNGImage);
var
  AAnchor, APicNode, ANode: IXMLNode;
begin
  Inc(FIndex);
  FRels.Add(sBaseURL + 'officeDocument/2006/relationships/image', Format('/xl/media/image%d.png', [Index]));
  AAnchor := Root.AddChild('xdr:oneCellAnchor');
  ANode := AAnchor.AddChild('xdr:from');
  ANode.AddChild('xdr:col').Text := IntTostr(ACol);
  ANode.AddChild('xdr:colOff').Text := '0';
  ANode.AddChild('xdr:row').Text := IntTostr(ARow);
  ANode.AddChild('xdr:rowOff').Text := '0';
  ANode := AAnchor.AddChild('xdr:ext');
  ANode.SetAttribute('cx', AImage.Width * 9525);
  ANode.SetAttribute('cy', AImage.Height * 9525);
  APicNode := AAnchor.AddChild('xdr:pic');

  ANode := APicNode.AddChild('xdr:nvPicPr');
  with ANode.AddChild('xdr:cNvPr') do
  begin
    SetAttribute('id', FIndex);
    SetAttribute('name', Format('Picture %d', [FIndex]));
  end;
  ANode.AddChild('xdr:cNvPicPr');

  ANode := APicNode.AddChild('xdr:blipFill');
  with ANode.AddChild('a:blip') do
  begin
    SetAttribute('xmlns:r', sBaseURL + 'officeDocument/2006/relationships');
    SetAttribute('r:embed', Format('rId%d', [FIndex]));
  end;
  ANode.AddChild('a:srcRect');
  ANode.AddChild('a:stretch').AddChild('a:fillRect');

  ANode := APicNode.AddChild('xdr:spPr');
  ANode.AddChild('a:prstGeom').SetAttribute('prst', 'rect');
  AAnchor.AddChild('xdr:clientData');
end;

{ TdxXLSXSheet }

constructor TdxXLSXSheet.Create(
  const ARowCount, AColCount: Integer; AGridlines: Boolean);
begin
  inherited CreateInstance('xl\worksheets\sheet0.xml',
    'officeDocument/2006/relationships', 'spreadsheetml/2006/main', sWorkSheet);
  AddNode(sDimension, [sRef], ['A1:' + dxRefToString(AColCount - 1, ARowCount - 1)]);
  AddNode(AddNode(sSheetViews, [], []), sSheetView,
    [sShowGridLines, sWorkbookViewID], [IntToStr(Byte(AGridLines)), '0']);
  FColumns := Root.AddChild(sColumns);
  FData := Root.AddChild(sSheetData);
  FColCount := AColCount;
  FRowCount := ARowCount;  
end;

function TdxXLSXSheet.AddCell(
  AParentRow: IXMLNode; const ARow, ACol, AStyleIndex: Integer): IXMLNode;
begin
  Result := AddNode(AParentRow, 'c', ['r', 's'],
    [dxRefToString(ACol, ARow), IntToStr(AStyleIndex)]);
end;

procedure TdxXLSXSheet.SetDataAsBoolean(ACell: IXMLNode; const AValue: Boolean);
begin
  ACell.SetAttribute('t', 'b');
  SetDataAsInteger(ACell, Byte(AValue));
end;

procedure TdxXLSXSheet.SetDataAsCurrency(ACell: IXMLNode; const AValue: Currency);
begin
  ACell.AddChild('v').Text := FloatToStr(AValue);
end;

procedure TdxXLSXSheet.SetDataAsFloat(ACell: IXMLNode; const AValue: Double);
begin
  ACell.AddChild('v').Text := FloatToStr(AValue);
end;

procedure TdxXLSXSheet.SetDataAsInteger(ACell: IXMLNode; const AValue: Integer);
begin
  ACell.AddChild('v').Text := IntToStr(AValue);
end;

procedure TdxXLSXSheet.SetDataAsString(ACell: IXMLNode; const ASSTIndex: Integer);
begin
  ACell.SetAttribute('t', 's');
  ACell.AddChild('v').Text := IntToStr(ASSTIndex);
end;

procedure TdxXLSXSheet.AddMergeCells(const ARefs: TStringList);
var
  I: Integer;
  AMergeCells: IXMLNode;
begin
  if ARefs.Count = 0 then Exit; 
  AMergeCells := AddNode(Root, sMergeCells, [sCount], [IntToStr(ARefs.Count)]);
  for I := 0 to ARefs.Count - 1 do
    AddNode(AMergeCells, sMergeCell, [sRef], [ARefs[I]]);
end;

function TdxXLSXSheet.AddRowHeight(const ARow, AHeight: Integer): IXMLNode;
begin
  Result := AddNode(FData, sRow, [sR, sSpans, sHt, sCustomHeight],
    [IntToStr(ARow), '1:' + IntToStr(FColCount), FloatToStr(AHeight * 75 / 100), '1']);
end;

procedure TdxXLSXSheet.SetColumnWidth(const AColumn: Integer; AWidth: Integer);
begin
  AddNode(FColumns, sCol, [sMin, sMax, sWidth, sCustomWidth],
   [IntToStr(AColumn), IntToStr(AColumn), FloatToStr(AWidth / 7.1), '1']);
end;

{ TdxXLSXCell }

destructor TdxXLSXCell.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TdxXLSXCell.Clear;
begin
  if DataType in [cdtCurrency, cdtFloat] then
    FreeMem(Data)
  else
    if DataType = cdtImage then
      TObject(Data).Free;
  DataType := cdtNone;
end;

{ TdxXLSXExportProvider }

constructor TdxXLSXExportProvider.Create(const AFileName: string);
begin
  inherited Create(AFileName);
  FCells := TcxObjectList.Create;
  FName := cxExtractFileNameEx(ChangeFileExt(AFileName, ''));
  FStream := cxFileStreamClass.Create(cxUnicodeToStr(FileName), fmCreate);
  FSST := TdxSharedStringTable.Create;
  FCols := TList.Create;
  FRows := TList.Create;
  FStyleCache := TcxExportStyleManager.GetInstance(AFileName);
  FMergedCells := TStringList.Create;
  InitializeProvider;
end;

destructor TdxXLSXExportProvider.Destroy;
begin
  FCells.Free;
  FSST.Free;
  FStream.Free;
  FCols.Free;
  FRows.Free;
  if Assigned(FStyleCache) then
    FStyleCache.Clear;
  FMergedCells.Free;
  inherited Destroy;
end;

class function TdxXLSXExportProvider.ExportType: Integer;
begin
  Result := cxExportToXLSX;
end;

class function TdxXLSXExportProvider.ExportName: string;
begin
  Result := cxGetResString(@scxExportToXlsx);
end;

procedure TdxXLSXExportProvider.AddStructureItem(AItem: TdxXLSXIntenalDocument; var Instance);
begin
  TdxXLSXIntenalDocument(Instance) := AItem;
  FXMLItems.Add(AItem); 
end;

procedure TdxXLSXExportProvider.Commit;
var
  I: Integer;
begin
  FXMLItems := TcxObjectList.Create;
  try
    FWriter := TdxPackedStreamWriter.Create(FStream);
    try
      CreateXMLStructure;
      for I := 0 to FXMLItems.Count - 1 do
      begin
        FWriter.AddIntenalDocument(FXMLItems[I] as TdxXLSXIntenalDocument);
      end;
    finally
      FreeAndNil(FWriter);
    end;
    FreeAndNil(FStream);
  finally
    FXMLItems.Free;
  end;
end;

function TdxXLSXExportProvider.CheckPos(const ACol, ARow: Integer): Boolean;
begin
  Result := (ACol >= 0) and (ACol < ColCount) and
    (ARow >= 0) and (ARow < RowCount);
end;

procedure TdxXLSXExportProvider.CreateXMLStructure;
var
  ADrawingRels: TdxXLSXRels;
begin
  AddStructureItem(TdxXLSXRels.Create('_rels\.rels'), FRels);
  AddStructureItem(TdxXLSXContentTypes.Create(), FContentTypes);
  AddStructureItem(TdxXLSXWorkbook.Create, FWorkbook);
  AddStructureItem(TdxXLSXSharedStrings.Create(SST.Count, SST.UniqueCount), FSharedStrings);
  AddStructureItem(TdxXLSXStyles.Create, FStyles);
  AddStructureItem(TdxXLSXSheet.Create(RowCount, ColCount, False), FSheet);
  AddStructureItem(TdxXLSXRels.Create('xl\_rels\workbook.xml.rels'), FWorkbookRels);
  // initialize documents
  Rels.Add(sBaseURL + 'officeDocument/2006/relationships/officeDocument', 'xl/workbook.xml');
  Workbook.AddSheet(cxExtractFileNameEx(ChangeFileExt(FileName, '')));
  WorkbookRels.Add(sBaseURL + 'officeDocument/2006/relationships/styles', '/xl/styles.xml', 'rIdSR');
  WorkbookRels.Add(sBaseURL + 'officeDocument/2006/relationships/worksheet', '/xl/worksheets/sheet0.xml');
  WorkbookRels.Add(sBaseURL + 'officeDocument/2006/relationships/sharedStrings', '/xl/sharedStrings.xml', 'rIdSS');
  if ImagesCount > 0 then
  begin
    AddStructureItem(TdxXLSXRels.Create('xl\worksheets\_rels\sheet0.xml.rels'), ADrawingRels);
    ADrawingRels.Add(sBaseURL + 'officeDocument/2006/relationships/drawing', '/xl/drawings/drawing0.xml');
    AddStructureItem(TdxXLSXRels.Create('xl\drawings\_rels\drawing0.xml.rels'), ADrawingRels);
    AddStructureItem(TdxXLSXDrawing.Create(ADrawingRels), FDrawing);
  end;
  WriteStyles;
  WriteSharedStrings;
  WriteSheetLayout;
  WriteData;
end;

function TdxXLSXExportProvider.GetCellStyle(
  const ACol, ARow: Integer): PcxCacheCellStyle;
begin
  Result := StyleCache.GetStyle(Cells[ACol, ARow].Style);
end;

function TdxXLSXExportProvider.GetStyle(
  AStyleIndex: Integer): PcxCacheCellStyle;
begin
  if AStyleIndex >= FStyleCache.Count then 
    Result := @DefaultCellStyle 
  else
    Result := FStyleCache.GetStyle(AStyleIndex);
end;

function TdxXLSXExportProvider.InitCellData(
  const ACol, ARow: Integer; ADataType: TdxXLSXCellDataType): TdxXLSXCell;
const
  AValueSize: array[TdxXLSXCellDataType] of Byte = (0, SizeOf(Boolean), SizeOf(Integer),
    SizeOf(Currency), SizeOf(Double), SizeOf(TDateTime), SizeOf(Integer), SizeOf(Pointer)); 
begin
  Result := Cells[ACol, ARow];
  if Result.DataType = cdtString then
    FSST.Relese(Result.Data);
  Result.Clear;
  Result.DataType := ADataType;
  if AValueSize[ADataType] > 4 then
    GetMem(Result.Data, AValueSize[ADataType]);
end;

procedure TdxXLSXExportProvider.InitializeProvider;
var
  I: Integer; 
  AStyle: TcxCacheCellStyle;
begin
  AStyle := DefaultCellStyle;
  AStyle.AlignText := catLeft;
  AStyle.BrushStyle := cbsClear;
  for I := 0 to 3 do
    AStyle.Borders[I].IsDefault := True;
  dxStringToBytes('Calibri', AStyle.FontName);
  AStyle.FontSize := 11;
  FStyleCache.RegisterStyle(AStyle);
  FStyleCache.RegisterStyle(DefaultCellStyle);
end;

function TdxXLSXExportProvider.RegisterStyle(
  const AStyle: TcxCacheCellStyle): Integer;
begin
  Result := StyleCache.RegisterStyle(AStyle);
end;

procedure TdxXLSXExportProvider.SetCellDataBoolean(
  const ACol, ARow: Integer; const AValue: Boolean);
begin
  InitCellData(ACol, ARow, cdtBoolean).Data := Pointer(AValue);
end;

procedure TdxXLSXExportProvider.SetCellDataCurrency(
  const ACol, ARow: Integer; const AValue: Currency);
begin
  with InitCellData(ACol, ARow, cdtCurrency) do
  begin
    PCurrency(Data)^ := AValue;
    ValidateNativeStyle(Style, cdtCurrency, Data);
  end;
end;

procedure TdxXLSXExportProvider.SetCellDataDateTime(
  const ACol, ARow: Integer; const AValue: TDateTime);
begin
  with InitCellData(ACol, ARow, cdtDateTime) do
  begin
    PDateTime(Data)^ := AValue;
    ValidateNativeStyle(Style, cdtDateTime, Data);
  end;
end;

procedure TdxXLSXExportProvider.SetCellDataDouble(
  const ACol, ARow: Integer; const AValue: Double);
begin
  PDouble(InitCellData(ACol, ARow, cdtFloat).Data)^ := AValue;
end;

procedure TdxXLSXExportProvider.SetCellDataInteger(
  const ACol, ARow: Integer; const AValue: Integer);
begin
  InitCellData(ACol, ARow, cdtInteger).Data := Pointer(AValue);
end;

procedure TdxXLSXExportProvider.SetCellDataString(
  const ACol, ARow: Integer; const AText: string);
begin
{$IFDEF DELPHI12}
  InitCellData(ACol, ARow, cdtString).Data := FSST.AddUnicodeString(AText);
{$ELSE}
  InitCellData(ACol, ARow, cdtString).Data := FSST.AddAnsiString(AText);
{$ENDIF}
end;

procedure TdxXLSXExportProvider.SetCellDataWideString(
  const ACol, ARow: Integer; const AText: Widestring);
begin
  InitCellData(ACol, ARow, cdtString).Data := FSST.AddUnicodeString(AText);
end;

procedure TdxXLSXExportProvider.SetCellStyle(
  const ACol, ARow, AStyleIndex: Integer);
begin
  if not CheckPos(ACol, ARow) then Exit;
  GetCell(ACol, ARow).Style := AStyleIndex;
end;

procedure TdxXLSXExportProvider.SetCellStyle(
  const ACol, ARow, AExampleCol, AExampleRow: Integer);
begin
  if not CheckPos(ACol, ARow) then Exit;
  SetCellStyle(ACol, ARow, GetCellStyle(AExampleCol, AExampleRow)^);
end;

procedure TdxXLSXExportProvider.SetCellStyle(
  const ACol, ARow: Integer; const AStyle: TcxCacheCellStyle);
begin
  if not CheckPos(ACol, ARow) then Exit;
  SetCellStyle(ACol, ARow, RegisterStyle(AStyle));
end;

procedure TdxXLSXExportProvider.SetCellStyleEx(
  const ACol, ARow, H, W: Integer; const AStyleIndex: Integer);
var
  I, J: Integer;
begin
  for I := ACol to ACol + W - 1 do
    for J := ARow to ARow + H - 1 do
      Cells[I, J].Style := AStyleIndex;
  if (H > 1) or (W > 1) then
    SetCellUnion(ACol, ARow, H, W);
end;

procedure TdxXLSXExportProvider.SetCellUnion(
  const ACol, ARow: Integer; H, W: Integer);
begin
  MergedCells.Add(dxAreaRefToString(ACol, ARow, ACol + W - 1, ARow + H - 1));
end;

procedure TdxXLSXExportProvider.SetCellValue(
  const ACol, ARow: Integer; const AValue: Variant);
begin
  cxSetCellNativeValue(ACol, ARow, AValue, Self);
end;

procedure TdxXLSXExportProvider.SetColumnWidth(
  const ACol, AWidth: Integer);
begin
  Cols[ACol] := Pointer(AWidth);
end;

procedure TdxXLSXExportProvider.SetDefaultStyle(
  const AStyle: TcxCacheCellStyle);
begin
end;

procedure TdxXLSXExportProvider.SetRange(
  const AColCount, ARowCount: Integer; IsVisible: Boolean = True);
var
  I: Integer;
begin
  FColCount := AColCount;
  FRowCount := ARowCount;
  FCells.Count := AColCount * ARowCount;
  FCols.Count := AColCount;
  FRows.Count := ARowCount;
  for I := 0 to AColCount - 1 do
    FCols.List^[I] := Pointer(cxExcelDefaultColumnWidth);
  for I := 0 to ARowCount - 1 do
    FRows.List^[I] := Pointer(cxExcelDefaultRowHeight);
  for I := 0 to AColCount * ARowCount - 1 do
    FCells.List^[I] := TdxXLSXCell.Create;
end;

procedure TdxXLSXExportProvider.SetRowHeight(const ARow, AHeight: Integer);
begin
  Rows[ARow] := Pointer(AHeight);
end;

procedure TdxXLSXExportProvider.ValidateNativeStyle(var AStyleIndex: Integer;
  const ADataType: TdxXLSXCellDataType; const Data: Pointer);
var
  AStyle: TcxCacheCellStyle;
begin
  AStyle := GetStyle(AStyleIndex)^;
  if (AStyle.Format <> 0) or not (ADataType in [cdtCurrency, cdtDateTime]) then Exit;
  if ADataType = cdtCurrency then
    AStyle.Format := NativeFormats[3] 
  else
    AStyle.Format := NativeFormats[cxXlsGetDateTimeFormat(PDouble(Data)^) xor $1000];
  AStyleIndex := RegisterStyle(AStyle);
end;

procedure TdxXLSXExportProvider.WriteStyles;
var
  I: Integer;
  AStyle: PcxCacheCellStyle;
  ASharedStyle: TdxSharedObject;
  AStyles, AFonts, ABrushes, ABorders: TdxSharedObjectsList;
begin
  AStyles := TdxSharedObjectsList.Create;
  AFonts := TdxSharedObjectsList.Create;
  ABrushes := TdxSharedObjectsList.Create;
  ABorders := TdxSharedObjectsList.Create;
  try
    for I := 0 to StyleCache.Count - 1 do
    begin
      AStyle := StyleCache.GetStyle(I);
      ASharedStyle := TdxSharedStyle.Create(AStyle, AFonts.Add(TdxSharedFont.Create(AStyle)),
        ABrushes.Add(TdxSharedBrush.Create(AStyle)), ABorders.Add(TdxSharedCellBorders.Create(AStyle)));
      AStyle.Format := Integer(AStyles.Add(ASharedStyle));
    end;
    Styles.AddFonts(AFonts);
    Styles.AddBrushes(ABrushes);
    Styles.AddBorders(ABorders);
    Styles.AddStyles(AStyles);
    for I := 0 to StyleCache.Count - 1 do
      with StyleCache.GetStyle(I)^ do 
        Format := TdxSharedObject(Format).Index;
  finally
    ABorders.Free;
    ABrushes.Free;
    AFonts.Free;
    AStyles.Free;
  end;
end;

procedure TdxXLSXExportProvider.WriteData;
var
  AXMLCell: IXMLNode; 
  ACell: TdxXLSXCell;
  ARowNode: IXMLNode;
  ACol, ARow: Integer;
begin
  for ARow := 0 to RowCount - 1 do
  begin
    ARowNode := Sheet.AddRowHeight(ARow + 1, Integer(Rows[ARow]));
    for ACol := 0 to ColCount - 1 do
    begin
      ACell := Cells[ACol, ARow];
      AXMLCell := Sheet.AddCell(ARowNode, ARow, ACol, StyleCache.GetStyle(ACell.Style).Format);
      case ACell.DataType of
        cdtBoolean:
          Sheet.SetDataAsBoolean(AXMLCell, Boolean(ACell.Data));
        cdtInteger:
          Sheet.SetDataAsInteger(AXMLCell, Integer(ACell.Data));
        cdtCurrency:
          Sheet.SetDataAsCurrency(AXMLCell, PCurrency(ACell.Data)^);
        cdtFloat:
          Sheet.SetDataAsFloat(AXMLCell, PDouble(ACell.Data)^);
        cdtDateTime:
          Sheet.SetDataAsFloat(AXMLCell, PDateTime(ACell.Data)^);
        cdtString:
          Sheet.SetDataAsString(AXMLCell, TdxSharedObject(ACell.Data).Index);
        cdtImage:
        begin
          Drawing.AddImage(ACol, ARow, TdxPNGImage(ACell.Data));
          Writer.AddImage('xl\media\', TdxPNGImage(ACell.Data), Drawing.Index);
        end;
      end;
    end;
  end;
end;

procedure TdxXLSXExportProvider.WriteSharedStrings;
var
  AIndex: Integer; 
  AText: TdxSharedObject; 
begin
  AIndex := 0;
  AText := SST.First;
  while AText <> nil do
  begin
    AText.Index := AIndex;
    if AText is TdxSharedUnicodeString then
      SharedStrings.Add(TdxSharedUnicodeString(AText).Text)
    else
      SharedStrings.Add(dxAnsiStringToWideString(TdxSharedAnsiString(AText).Text));
    AText := AText.Next;
    Inc(AIndex);
  end;
end;

procedure TdxXLSXExportProvider.WriteSheetLayout;
var
  I: Integer;
begin
  for I := 0 to ColCount - 1 do
    Sheet.SetColumnWidth(I + 1, Integer(Cols[I]));
  Sheet.AddMergeCells(MergedCells);
  if ImagesCount > 0 then
    Sheet.AddNode('drawing', ['r:id'], ['rId0']);
end;

// export graphic extension
procedure TdxXLSXExportProvider.SetCellDataGraphic(
  const ACol, ARow: Integer; var AGraphic: TGraphic);
begin
//  SetCellPNGImage();
end;

procedure TdxXLSXExportProvider.SetCellPNGImage(const ACol, ARow: Integer;
  APNGImage: TObject);
begin
  InitCellData(ACol, ARow, cdtImage).Data := APNGImage;
  Inc(FImagesCount);
end;

function TdxXLSXExportProvider.SupportGraphic: Boolean;
begin
  Result := True;  
end;

function TdxXLSXExportProvider.GetCell(ACol, ARow: Integer): TdxXLSXCell;
begin
  Result := TdxXLSXCell(FCells[FColCount * ARow + ACol]);
end;

initialization
  TcxExport.RegisterProviderClass(TdxXLSXExportProvider);

end.
