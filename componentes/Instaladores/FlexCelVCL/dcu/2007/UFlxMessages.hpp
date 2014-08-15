// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxmessages.pas' rev: 11.00

#ifndef UflxmessagesHPP
#define UflxmessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Varutils.hpp>	// Pascal unit
#include <Flxpngimage.hpp>	// Pascal unit
#include <Flxzlibpas.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxmessages
{
//-- type declarations -------------------------------------------------------
typedef WideString UTF16String;

typedef WideChar UTF16Char;

typedef char *PAddress;

typedef unsigned UInt32;

typedef int Int32;

typedef Word UInt16;

typedef short Int16;

typedef TPNGObject TPngImage;
;

#pragma pack(push,1)
struct TClientAnchor
{
	
public:
	Word Flag;
	Word Col1;
	Word Dx1;
	Word Row1;
	Word Dy1;
	Word Col2;
	Word Dx2;
	Word Row2;
	Word Dy2;
} ;
#pragma pack(pop)

typedef TClientAnchor *PClientAnchor;

typedef DynamicArray<WideString >  WidestringArray;

typedef DynamicArray<WideChar >  WideCharArray;

typedef DynamicArray<bool >  BooleanArray;

typedef DynamicArray<Byte >  ByteArray;

typedef DynamicArray<Byte >  UFlxMessages__1;

#pragma pack(push,4)
struct TPrinterDriverSettings
{
	
public:
	Word OperatingEnviroment;
	DynamicArray<Byte >  Data;
} ;
#pragma pack(pop)

typedef int TExcelPaperSize;

typedef Shortint TColorPaletteRange;

#pragma pack(push,4)
struct TXlsCellRange
{
	
public:
	int Left;
	int Top;
	int Right;
	int Bottom;
} ;
#pragma pack(pop)

#pragma pack(push,4)
struct TXlsNamedRange
{
	
public:
	AnsiString Name;
	AnsiString RangeFormula;
	int OptionFlags;
	int NameSheetIndex;
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TXlsMargins
{
	
public:
	Extended Left;
	Extended Top;
	Extended Right;
	Extended Bottom;
	Extended Header;
	Extended Footer;
} ;
#pragma pack(pop)

#pragma option push -b-
enum TXlsSheetVisible { sv_Visible, sv_Hidden, sv_VeryHidden };
#pragma option pop

#pragma pack(push,2)
struct TRTFRun
{
	
public:
	Word FirstChar;
	Word FontIndex;
} ;
#pragma pack(pop)

typedef DynamicArray<TRTFRun >  TRTFRunList;

#pragma pack(push,4)
struct TRichString
{
	
public:
	WideString Value;
	DynamicArray<TRTFRun >  RTFRuns;
} ;
#pragma pack(pop)

#pragma option push -b-
enum THyperLinkType { hl_URL, hl_LocalFile, hl_UNC, hl_CurrentWorkbook };
#pragma option pop

#pragma pack(push,4)
struct THyperLink
{
	
public:
	THyperLinkType LinkType;
	WideString Description;
	WideString TargetFrame;
	WideString TextMark;
	WideString Text;
	WideString Hint;
} ;
#pragma pack(pop)

typedef void __fastcall (__closure *TOnGetFileNameEvent)(System::TObject* Sender, const int FileFormat, AnsiString &Filename);

typedef void __fastcall (__closure *TOnGetOutStreamEvent)(System::TObject* Sender, const int FileFormat, Classes::TStream* &OutStream);

#pragma option push -b-
enum TXlsImgTypes { xli_Emf, xli_Wmf, xli_Jpeg, xli_Png, xli_Bmp, xli_Unknown };
#pragma option pop

typedef Variant VariantArray[134217727];

typedef DynamicArray<Variant >  ArrayOfVariant;

struct TXlsCellValue
{
	
public:
	Variant Value;
	int XF;
	bool IsFormula;
} ;

typedef Sysutils::TFormatSettings *PFormatSettings;

#pragma option push -b-
enum TFlxAnchorType { at_MoveAndResize, at_MoveAndDontResize, at_DontMoveAndDontResize };
#pragma option pop

#pragma pack(push,4)
struct TImageProperties
{
	
public:
	int Col1;
	int dx1;
	int Row1;
	int dy1;
	int Col2;
	int dx2;
	int Row2;
	int dy2;
	WideString FileName;
} ;
#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const Word FLX_VAR_LOCALE_USER_DEFAULT = 0x400;
extern PACKAGE System::ResourceString _FieldStr;
#define Uflxmessages_FieldStr System::LoadResourceString(&Uflxmessages::_FieldStr)
extern PACKAGE System::ResourceString _DataSetStr;
#define Uflxmessages_DataSetStr System::LoadResourceString(&Uflxmessages::_DataSetStr)
extern PACKAGE System::ResourceString _VarStr;
#define Uflxmessages_VarStr System::LoadResourceString(&Uflxmessages::_VarStr)
extern PACKAGE System::ResourceString _StrOpen;
#define Uflxmessages_StrOpen System::LoadResourceString(&Uflxmessages::_StrOpen)
extern PACKAGE System::ResourceString _StrClose;
#define Uflxmessages_StrClose System::LoadResourceString(&Uflxmessages::_StrClose)
extern PACKAGE System::ResourceString _ExtrasDelim;
#define Uflxmessages_ExtrasDelim System::LoadResourceString(&Uflxmessages::_ExtrasDelim)
extern PACKAGE System::ResourceString _MarkedRowStr;
#define Uflxmessages_MarkedRowStr System::LoadResourceString(&Uflxmessages::_MarkedRowStr)
extern PACKAGE System::ResourceString _HPageBreakStr;
#define Uflxmessages_HPageBreakStr System::LoadResourceString(&Uflxmessages::_HPageBreakStr)
extern PACKAGE System::ResourceString _FullDataSetStr;
#define Uflxmessages_FullDataSetStr System::LoadResourceString(&Uflxmessages::_FullDataSetStr)
extern PACKAGE System::ResourceString _MainTxt;
#define Uflxmessages_MainTxt System::LoadResourceString(&Uflxmessages::_MainTxt)
extern PACKAGE System::ResourceString _RecordCountPrefix;
#define Uflxmessages_RecordCountPrefix System::LoadResourceString(&Uflxmessages::_RecordCountPrefix)
extern PACKAGE System::ResourceString _DefaultDateTimeFormat;
#define Uflxmessages_DefaultDateTimeFormat System::LoadResourceString(&Uflxmessages::_DefaultDateTimeFormat)
extern PACKAGE System::ResourceString _FlexCelVersion;
#define Uflxmessages_FlexCelVersion System::LoadResourceString(&Uflxmessages::_FlexCelVersion)
extern PACKAGE System::ResourceString _ErrNoAdapter;
#define Uflxmessages_ErrNoAdapter System::LoadResourceString(&Uflxmessages::_ErrNoAdapter)
extern PACKAGE System::ResourceString _ErrTooManySheets;
#define Uflxmessages_ErrTooManySheets System::LoadResourceString(&Uflxmessages::_ErrTooManySheets)
extern PACKAGE System::ResourceString _ErrNoDataSet;
#define Uflxmessages_ErrNoDataSet System::LoadResourceString(&Uflxmessages::_ErrNoDataSet)
extern PACKAGE System::ResourceString _ErrNoPropDefined;
#define Uflxmessages_ErrNoPropDefined System::LoadResourceString(&Uflxmessages::_ErrNoPropDefined)
extern PACKAGE System::ResourceString _ErrBadProp;
#define Uflxmessages_ErrBadProp System::LoadResourceString(&Uflxmessages::_ErrBadProp)
extern PACKAGE System::ResourceString _ErrTooManyDimensions;
#define Uflxmessages_ErrTooManyDimensions System::LoadResourceString(&Uflxmessages::_ErrTooManyDimensions)
extern PACKAGE System::ResourceString _ErrIndexOutBounds;
#define Uflxmessages_ErrIndexOutBounds System::LoadResourceString(&Uflxmessages::_ErrIndexOutBounds)
extern PACKAGE System::ResourceString _ErrInvalidDrawingType;
#define Uflxmessages_ErrInvalidDrawingType System::LoadResourceString(&Uflxmessages::_ErrInvalidDrawingType)
extern PACKAGE System::ResourceString _ErrNoOpenFile;
#define Uflxmessages_ErrNoOpenFile System::LoadResourceString(&Uflxmessages::_ErrNoOpenFile)
extern PACKAGE System::ResourceString _ErrCantFindFile;
#define Uflxmessages_ErrCantFindFile System::LoadResourceString(&Uflxmessages::_ErrCantFindFile)
extern PACKAGE System::ResourceString _ErrNoTemplate;
#define Uflxmessages_ErrNoTemplate System::LoadResourceString(&Uflxmessages::_ErrNoTemplate)
extern PACKAGE System::ResourceString _ErrDocumentNotSaved;
#define Uflxmessages_ErrDocumentNotSaved System::LoadResourceString(&Uflxmessages::_ErrDocumentNotSaved)
extern PACKAGE System::ResourceString _ErrFieldNil;
#define Uflxmessages_ErrFieldNil System::LoadResourceString(&Uflxmessages::_ErrFieldNil)
extern PACKAGE System::ResourceString _ErrDupField;
#define Uflxmessages_ErrDupField System::LoadResourceString(&Uflxmessages::_ErrDupField)
extern PACKAGE System::ResourceString _ErrFieldNotFound;
#define Uflxmessages_ErrFieldNotFound System::LoadResourceString(&Uflxmessages::_ErrFieldNotFound)
extern PACKAGE System::ResourceString _ErrInvalidColumnCount;
#define Uflxmessages_ErrInvalidColumnCount System::LoadResourceString(&Uflxmessages::_ErrInvalidColumnCount)
extern PACKAGE System::ResourceString _MsgAbout;
#define Uflxmessages_MsgAbout System::LoadResourceString(&Uflxmessages::_MsgAbout)
extern PACKAGE System::ResourceString _TxtDatasets;
#define Uflxmessages_TxtDatasets System::LoadResourceString(&Uflxmessages::_TxtDatasets)
extern PACKAGE System::ResourceString _TxtProperties;
#define Uflxmessages_TxtProperties System::LoadResourceString(&Uflxmessages::_TxtProperties)
extern PACKAGE System::ResourceString _TxtExtras;
#define Uflxmessages_TxtExtras System::LoadResourceString(&Uflxmessages::_TxtExtras)
extern PACKAGE System::ResourceString _TxtFileModified;
#define Uflxmessages_TxtFileModified System::LoadResourceString(&Uflxmessages::_TxtFileModified)
extern PACKAGE System::ResourceString _TxtFileModifiedCaption;
#define Uflxmessages_TxtFileModifiedCaption System::LoadResourceString(&Uflxmessages::_TxtFileModifiedCaption)
extern PACKAGE System::ResourceString _TxtEditing;
#define Uflxmessages_TxtEditing System::LoadResourceString(&Uflxmessages::_TxtEditing)
extern PACKAGE System::ResourceString _TxtEditTemplate;
#define Uflxmessages_TxtEditTemplate System::LoadResourceString(&Uflxmessages::_TxtEditTemplate)
extern PACKAGE System::ResourceString _TxtRefreshTemplate;
#define Uflxmessages_TxtRefreshTemplate System::LoadResourceString(&Uflxmessages::_TxtRefreshTemplate)
extern PACKAGE System::ResourceString _TxtTemplateStoreRefreshed;
#define Uflxmessages_TxtTemplateStoreRefreshed System::LoadResourceString(&Uflxmessages::_TxtTemplateStoreRefreshed)
extern PACKAGE System::ResourceString _TxtDeleteRange;
#define Uflxmessages_TxtDeleteRange System::LoadResourceString(&Uflxmessages::_TxtDeleteRange)
extern PACKAGE System::ResourceString _TxtDeleteRangeCaption;
#define Uflxmessages_TxtDeleteRangeCaption System::LoadResourceString(&Uflxmessages::_TxtDeleteRangeCaption)
extern PACKAGE System::ResourceString _TxtNamedRangeFormula;
#define Uflxmessages_TxtNamedRangeFormula System::LoadResourceString(&Uflxmessages::_TxtNamedRangeFormula)
extern PACKAGE System::ResourceString _ErrComponentIsNotXlsDataSet;
#define Uflxmessages_ErrComponentIsNotXlsDataSet System::LoadResourceString(&Uflxmessages::_ErrComponentIsNotXlsDataSet)
extern PACKAGE System::ResourceString _ErrUseFasterAdapter;
#define Uflxmessages_ErrUseFasterAdapter System::LoadResourceString(&Uflxmessages::_ErrUseFasterAdapter)
extern PACKAGE System::ResourceString _TxtTrue;
#define Uflxmessages_TxtTrue System::LoadResourceString(&Uflxmessages::_TxtTrue)
extern PACKAGE System::ResourceString _TxtFalse;
#define Uflxmessages_TxtFalse System::LoadResourceString(&Uflxmessages::_TxtFalse)
extern PACKAGE System::ResourceString _ErrInvalidWmf;
#define Uflxmessages_ErrInvalidWmf System::LoadResourceString(&Uflxmessages::_ErrInvalidWmf)
extern PACKAGE System::ResourceString _TxtSepLog;
#define Uflxmessages_TxtSepLog System::LoadResourceString(&Uflxmessages::_TxtSepLog)
extern PACKAGE System::ResourceString _TxtCheckHeader;
#define Uflxmessages_TxtCheckHeader System::LoadResourceString(&Uflxmessages::_TxtCheckHeader)
extern PACKAGE System::ResourceString _TxtError;
#define Uflxmessages_TxtError System::LoadResourceString(&Uflxmessages::_TxtError)
extern PACKAGE System::ResourceString _TxtOK;
#define Uflxmessages_TxtOK System::LoadResourceString(&Uflxmessages::_TxtOK)
extern PACKAGE System::ResourceString _ErrInvalidRangeName;
#define Uflxmessages_ErrInvalidRangeName System::LoadResourceString(&Uflxmessages::_ErrInvalidRangeName)
extern PACKAGE System::ResourceString _ErrRangeNameNotFound;
#define Uflxmessages_ErrRangeNameNotFound System::LoadResourceString(&Uflxmessages::_ErrRangeNameNotFound)
extern PACKAGE System::ResourceString _ErrRangeNameInvalidType;
#define Uflxmessages_ErrRangeNameInvalidType System::LoadResourceString(&Uflxmessages::_ErrRangeNameInvalidType)
extern PACKAGE System::ResourceString _ErrCheckCellDots;
#define Uflxmessages_ErrCheckCellDots System::LoadResourceString(&Uflxmessages::_ErrCheckCellDots)
extern PACKAGE System::ResourceString _ErrCheckDotCommandsCol;
#define Uflxmessages_ErrCheckDotCommandsCol System::LoadResourceString(&Uflxmessages::_ErrCheckDotCommandsCol)
extern PACKAGE System::ResourceString _ErrInvalidCellDB;
#define Uflxmessages_ErrInvalidCellDB System::LoadResourceString(&Uflxmessages::_ErrInvalidCellDB)
extern PACKAGE System::ResourceString _ErrInvalidCellDB2;
#define Uflxmessages_ErrInvalidCellDB2 System::LoadResourceString(&Uflxmessages::_ErrInvalidCellDB2)
extern PACKAGE System::ResourceString _ErrInvalidField;
#define Uflxmessages_ErrInvalidField System::LoadResourceString(&Uflxmessages::_ErrInvalidField)
extern PACKAGE System::ResourceString _ErrInvalidPagesField;
#define Uflxmessages_ErrInvalidPagesField System::LoadResourceString(&Uflxmessages::_ErrInvalidPagesField)
extern PACKAGE System::ResourceString _ErrFieldOutsideRange;
#define Uflxmessages_ErrFieldOutsideRange System::LoadResourceString(&Uflxmessages::_ErrFieldOutsideRange)
extern PACKAGE System::ResourceString _ErrInvalidImageDB;
#define Uflxmessages_ErrInvalidImageDB System::LoadResourceString(&Uflxmessages::_ErrInvalidImageDB)
extern PACKAGE System::ResourceString _ErrInvalidImageField;
#define Uflxmessages_ErrInvalidImageField System::LoadResourceString(&Uflxmessages::_ErrInvalidImageField)
extern PACKAGE System::ResourceString _ErrInvalidImageType;
#define Uflxmessages_ErrInvalidImageType System::LoadResourceString(&Uflxmessages::_ErrInvalidImageType)
extern PACKAGE System::ResourceString _ErrTemplateNotRefreshed;
#define Uflxmessages_ErrTemplateNotRefreshed System::LoadResourceString(&Uflxmessages::_ErrTemplateNotRefreshed)
extern PACKAGE System::ResourceString _ErrNoAdvStrGrid;
#define Uflxmessages_ErrNoAdvStrGrid System::LoadResourceString(&Uflxmessages::_ErrNoAdvStrGrid)
extern PACKAGE System::ResourceString _ErrInvalidSheetName;
#define Uflxmessages_ErrInvalidSheetName System::LoadResourceString(&Uflxmessages::_ErrInvalidSheetName)
extern PACKAGE System::ResourceString _ErrInvalidNameForARange;
#define Uflxmessages_ErrInvalidNameForARange System::LoadResourceString(&Uflxmessages::_ErrInvalidNameForARange)
extern PACKAGE System::ResourceString _xls_Emf;
#define Uflxmessages_xls_Emf System::LoadResourceString(&Uflxmessages::_xls_Emf)
extern PACKAGE System::ResourceString _xls_Wmf;
#define Uflxmessages_xls_Wmf System::LoadResourceString(&Uflxmessages::_xls_Wmf)
extern PACKAGE System::ResourceString _xls_Jpeg;
#define Uflxmessages_xls_Jpeg System::LoadResourceString(&Uflxmessages::_xls_Jpeg)
extern PACKAGE System::ResourceString _xls_Png;
#define Uflxmessages_xls_Png System::LoadResourceString(&Uflxmessages::_xls_Png)
static const Word Date1904Diff = 0x5b6;
static const Shortint TExcelPaperSize_Undefined = 0x0;
static const Shortint TExcelPaperSize_Letter = 0x1;
static const Shortint TExcelPaperSize_Lettersmall = 0x2;
static const Shortint TExcelPaperSize_Tabloid = 0x3;
static const Shortint TExcelPaperSize_Ledger = 0x4;
static const Shortint TExcelPaperSize_Legal = 0x5;
static const Shortint TExcelPaperSize_Statement = 0x6;
static const Shortint TExcelPaperSize_Executive = 0x7;
static const Shortint TExcelPaperSize_A3 = 0x8;
static const Shortint TExcelPaperSize_A4 = 0x9;
static const Shortint TExcelPaperSize_A4small = 0xa;
static const Shortint TExcelPaperSize_A5 = 0xb;
static const Shortint TExcelPaperSize_B4_JIS = 0xc;
static const Shortint TExcelPaperSize_B5_JIS = 0xd;
static const Shortint TExcelPaperSize_Folio = 0xe;
static const Shortint TExcelPaperSize_Quarto = 0xf;
static const Shortint TExcelPaperSize_s10x14 = 0x10;
static const Shortint TExcelPaperSize_s11x17 = 0x11;
static const Shortint TExcelPaperSize_Note = 0x12;
static const Shortint TExcelPaperSize_Envelope9 = 0x13;
static const Shortint TExcelPaperSize_Envelope10 = 0x14;
static const Shortint TExcelPaperSize_Envelope11 = 0x15;
static const Shortint TExcelPaperSize_Envelope12 = 0x16;
static const Shortint TExcelPaperSize_Envelope14 = 0x17;
static const Shortint TExcelPaperSize_C = 0x18;
static const Shortint TExcelPaperSize_D = 0x19;
static const Shortint TExcelPaperSize_E = 0x1a;
static const Shortint TExcelPaperSize_EnvelopeDL = 0x1b;
static const Shortint TExcelPaperSize_EnvelopeC5 = 0x1c;
static const Shortint TExcelPaperSize_EnvelopeC3 = 0x1d;
static const Shortint TExcelPaperSize_EnvelopeC4 = 0x1e;
static const Shortint TExcelPaperSize_EnvelopeC6 = 0x1f;
static const Shortint TExcelPaperSize_EnvelopeC6_C5 = 0x20;
static const Shortint TExcelPaperSize_B4_ISO = 0x21;
static const Shortint TExcelPaperSize_B5_ISO = 0x22;
static const Shortint TExcelPaperSize_B6_ISO = 0x23;
static const Shortint TExcelPaperSize_EnvelopeItaly = 0x24;
static const Shortint TExcelPaperSize_EnvelopeMonarch = 0x25;
static const Shortint TExcelPaperSize_s63_4Envelope = 0x26;
static const Shortint TExcelPaperSize_USStandardFanfold = 0x27;
static const Shortint TExcelPaperSize_GermanStdFanfold = 0x28;
static const Shortint TExcelPaperSize_GermanLegalFanfold = 0x29;
static const Shortint TExcelPaperSize_B4_ISO_2 = 0x2a;
static const Shortint TExcelPaperSize_JapanesePostcard = 0x2b;
static const Shortint TExcelPaperSize_s9x11 = 0x2c;
static const Shortint TExcelPaperSize_s10x11 = 0x2d;
static const Shortint TExcelPaperSize_s15x11 = 0x2e;
static const Shortint TExcelPaperSize_EnvelopeInvite = 0x2f;
static const Shortint TExcelPaperSize_LetterExtra = 0x32;
static const Shortint TExcelPaperSize_LegalExtra = 0x33;
static const Shortint TExcelPaperSize_TabloidExtra = 0x34;
static const Shortint TExcelPaperSize_A4Extra = 0x35;
static const Shortint TExcelPaperSize_LetterTransverse = 0x36;
static const Shortint TExcelPaperSize_A4Transverse = 0x37;
static const Shortint TExcelPaperSize_LetterExtraTransv = 0x38;
static const Shortint TExcelPaperSize_SuperA_A4 = 0x39;
static const Shortint TExcelPaperSize_SuperB_A3 = 0x3a;
static const Shortint TExcelPaperSize_LetterPlus = 0x3b;
static const Shortint TExcelPaperSize_A4Plus = 0x3c;
static const Shortint TExcelPaperSize_A5Transverse = 0x3d;
static const Shortint TExcelPaperSize_B5_JIS_Transverse = 0x3e;
static const Shortint TExcelPaperSize_A3Extra = 0x3f;
static const Shortint TExcelPaperSize_A5Extra = 0x40;
static const Shortint TExcelPaperSize_B5_ISO_Extra = 0x41;
static const Shortint TExcelPaperSize_A2 = 0x42;
static const Shortint TExcelPaperSize_A3Transverse = 0x43;
static const Shortint TExcelPaperSize_A3ExtraTransverse = 0x44;
static const Shortint TExcelPaperSize_DblJapanesePostcard = 0x45;
static const Shortint TExcelPaperSize_A6 = 0x46;
static const Shortint TExcelPaperSize_LetterRotated = 0x4b;
static const Shortint TExcelPaperSize_A3Rotated = 0x4c;
static const Shortint TExcelPaperSize_A4Rotated = 0x4d;
static const Shortint TExcelPaperSize_A5Rotated = 0x4e;
static const Shortint TExcelPaperSize_B4_JIS_Rotated = 0x4f;
static const Shortint TExcelPaperSize_B5_JIS_Rotated = 0x50;
static const Shortint TExcelPaperSize_JapanesePostcardRot = 0x51;
static const Shortint TExcelPaperSize_DblJapPostcardRot = 0x52;
static const Shortint TExcelPaperSize_A6Rotated = 0x53;
static const Shortint TExcelPaperSize_B6_JIS = 0x58;
static const Shortint TExcelPaperSize_B6_JIS_Rotated = 0x59;
static const Shortint TExcelPaperSize_s12x11 = 0x5a;
extern PACKAGE int DefColWidthAdapt;
static const Shortint fpo_LeftToRight = 0x1;
static const Shortint fpo_Orientation = 0x2;
static const Shortint fpo_NoPls = 0x4;
static const Shortint fpo_NoColor = 0x8;
static const Shortint fpo_Draft = 0x10;
static const Shortint fpo_Notes = 0x20;
static const Shortint fpo_NoOrient = 0x40;
static const Byte fpo_UsePage = 0x80;
static const char InternalNameRange_Consolidate_Area = '\x0';
static const char InternalNameRange_Auto_Open = '\x1';
static const char InternalNameRange_Auto_Close = '\x2';
static const char InternalNameRange_Extract = '\x3';
static const char InternalNameRange_Database = '\x4';
static const char InternalNameRange_Criteria = '\x5';
static const char InternalNameRange_Print_Area = '\x6';
static const char InternalNameRange_Print_Titles = '\x7';
static const char InternalNameRange_Recorder = '\x8';
static const char InternalNameRange_Data_Form = '\x9';
static const char InternalNameRange_Auto_Activate = '\xa';
static const char InternalNameRange_Auto_Deactivate = '\xb';
static const char InternalNameRange_Sheet_Title = '\xc';
static const char InternalNameRange_Filter_DataBase = '\xd';
extern PACKAGE Extended ColMult;
extern PACKAGE Extended RowMult;
extern PACKAGE AnsiString __fastcall EncodeColumn(const int C);
extern PACKAGE AnsiString __fastcall SearchPathStr(const AnsiString AFileName)/* overload */;
extern PACKAGE AnsiString __fastcall SearchPathStr(const AnsiString AFilePath, const AnsiString AFileName)/* overload */;
extern PACKAGE void __fastcall EnsureAMPM(PFormatSettings &FormatSettings);
extern PACKAGE PFormatSettings __fastcall GetDefaultLocaleFormatSettings(void);
extern PACKAGE PFormatSettings __fastcall InvariantFormatSettings(void);
extern PACKAGE bool __fastcall TryStrToFloatInvariant(const AnsiString s, /* out */ Extended &i);
extern PACKAGE WideString __fastcall WideUpperCase98(const WideString s);
extern PACKAGE WideString __fastcall StringReplaceSkipQuotes(const WideString S, const WideString OldPattern, const WideString NewPattern);
extern PACKAGE bool __fastcall FlxTryStrToDateTime(const WideString S, /* out */ System::TDateTime &Value, /* out */ WideString &dFormat, /* out */ bool &HasDate, /* out */ bool &HasTime, const WideString DateFormat = L"", const WideString TimeFormat = L"", const PFormatSettings FormatSettings = (void *)(0x0));
extern PACKAGE AnsiString __fastcall TryFormatDateTime(const AnsiString Fmt, System::TDateTime value);
extern PACKAGE AnsiString __fastcall TryFormatDateTime1904(const AnsiString Fmt, System::TDateTime value, const bool Dates1904, const Sysutils::TFormatSettings &LocalSettings)/* overload */;
extern PACKAGE AnsiString __fastcall TryFormatDateTime1904(const AnsiString Fmt, System::TDateTime value, const bool Dates1904)/* overload */;
extern PACKAGE TXlsCellRange __fastcall OffsetRange(const TXlsCellRange &CellRange, const int DeltaRow, const int DeltaCol);
extern PACKAGE void __fastcall InitializeNamedRange(/* out */ TXlsNamedRange &NamedRange);
extern PACKAGE WideString __fastcall VariantToString(const Variant &v);

}	/* namespace Uflxmessages */
using namespace Uflxmessages;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxmessages
