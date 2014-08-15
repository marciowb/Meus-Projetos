// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuflxmessages.pas' rev: 21.00

#ifndef TmsuflxmessagesHPP
#define TmsuflxmessagesHPP

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
#include <Pngimage.hpp>	// Pascal unit
#include <Zlib.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuflxmessages
{
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString UTF16String;

typedef System::WideChar UTF16Char;

typedef System::PByte PAddress;

#pragma pack(push,1)
struct TClientAnchor
{
	
public:
	System::Word Flag;
	System::Word Col1;
	System::Word Dx1;
	System::Word Row1;
	System::Word Dy1;
	System::Word Col2;
	System::Word Dx2;
	System::Word Row2;
	System::Word Dy2;
};
#pragma pack(pop)


typedef TClientAnchor *PClientAnchor;

typedef DynamicArray<System::UnicodeString> WidestringArray;

typedef DynamicArray<System::WideChar> WideCharArray;

typedef DynamicArray<bool> BooleanArray;

typedef DynamicArray<System::Byte> ByteArray;

struct TPrinterDriverSettings
{
	
private:
	typedef DynamicArray<System::Byte> _TPrinterDriverSettings__1;
	
	
public:
	System::Word OperatingEnviroment;
	_TPrinterDriverSettings__1 Data;
};


typedef int TExcelPaperSize;

typedef ShortInt TColorPaletteRange;

struct TXlsCellRange
{
	
public:
	int Left;
	int Top;
	int Right;
	int Bottom;
};


struct TXlsNamedRange
{
	
public:
	System::UnicodeString Name;
	System::UnicodeString RangeFormula;
	int OptionFlags;
	int NameSheetIndex;
};


#pragma pack(push,1)
struct TXlsMargins
{
	
public:
	System::Extended Left;
	System::Extended Top;
	System::Extended Right;
	System::Extended Bottom;
	System::Extended Header;
	System::Extended Footer;
};
#pragma pack(pop)


#pragma option push -b-
enum TXlsSheetVisible { sv_Visible, sv_Hidden, sv_VeryHidden };
#pragma option pop

struct TRTFRun
{
	
public:
	System::Word FirstChar;
	System::Word FontIndex;
};


typedef DynamicArray<TRTFRun> TRTFRunList;

struct TRichString
{
	
public:
	System::UnicodeString Value;
	TRTFRunList RTFRuns;
};


#pragma option push -b-
enum THyperLinkType { hl_URL, hl_LocalFile, hl_UNC, hl_CurrentWorkbook };
#pragma option pop

struct THyperLink
{
	
public:
	THyperLinkType LinkType;
	System::UnicodeString Description;
	System::UnicodeString TargetFrame;
	System::UnicodeString TextMark;
	System::UnicodeString Text;
	System::UnicodeString Hint;
};


typedef void __fastcall (__closure *TOnGetFileNameEvent)(System::TObject* Sender, const int FileFormat, Sysutils::TFileName &Filename);

typedef void __fastcall (__closure *TOnGetOutStreamEvent)(System::TObject* Sender, const int FileFormat, Classes::TStream* &OutStream);

#pragma option push -b-
enum TXlsImgTypes { xli_Emf, xli_Wmf, xli_Jpeg, xli_Png, xli_Bmp, xli_Unknown };
#pragma option pop

typedef StaticArray<System::Variant, 134217727> VariantArray;

typedef DynamicArray<System::Variant> ArrayOfVariant;

struct TXlsCellValue
{
	
public:
	System::Variant Value;
	int XF;
	bool IsFormula;
};


typedef Sysutils::TFormatSettings *PFormatSettings;

#pragma option push -b-
enum TFlxAnchorType { at_MoveAndResize, at_MoveAndDontResize, at_DontMoveAndDontResize };
#pragma option pop

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
	System::UnicodeString FileName;
};


//-- var, const, procedure ---------------------------------------------------
static const Word FLX_VAR_LOCALE_USER_DEFAULT = 0x400;
extern PACKAGE System::ResourceString _FieldStr;
#define Tmsuflxmessages_FieldStr System::LoadResourceString(&Tmsuflxmessages::_FieldStr)
extern PACKAGE System::ResourceString _DataSetStr;
#define Tmsuflxmessages_DataSetStr System::LoadResourceString(&Tmsuflxmessages::_DataSetStr)
extern PACKAGE System::ResourceString _VarStr;
#define Tmsuflxmessages_VarStr System::LoadResourceString(&Tmsuflxmessages::_VarStr)
extern PACKAGE System::ResourceString _StrOpen;
#define Tmsuflxmessages_StrOpen System::LoadResourceString(&Tmsuflxmessages::_StrOpen)
extern PACKAGE System::ResourceString _StrClose;
#define Tmsuflxmessages_StrClose System::LoadResourceString(&Tmsuflxmessages::_StrClose)
extern PACKAGE System::ResourceString _ExtrasDelim;
#define Tmsuflxmessages_ExtrasDelim System::LoadResourceString(&Tmsuflxmessages::_ExtrasDelim)
extern PACKAGE System::ResourceString _MarkedRowStr;
#define Tmsuflxmessages_MarkedRowStr System::LoadResourceString(&Tmsuflxmessages::_MarkedRowStr)
extern PACKAGE System::ResourceString _HPageBreakStr;
#define Tmsuflxmessages_HPageBreakStr System::LoadResourceString(&Tmsuflxmessages::_HPageBreakStr)
extern PACKAGE System::ResourceString _FullDataSetStr;
#define Tmsuflxmessages_FullDataSetStr System::LoadResourceString(&Tmsuflxmessages::_FullDataSetStr)
extern PACKAGE System::ResourceString _MainTxt;
#define Tmsuflxmessages_MainTxt System::LoadResourceString(&Tmsuflxmessages::_MainTxt)
extern PACKAGE System::ResourceString _RecordCountPrefix;
#define Tmsuflxmessages_RecordCountPrefix System::LoadResourceString(&Tmsuflxmessages::_RecordCountPrefix)
extern PACKAGE System::ResourceString _DefaultDateTimeFormat;
#define Tmsuflxmessages_DefaultDateTimeFormat System::LoadResourceString(&Tmsuflxmessages::_DefaultDateTimeFormat)
extern PACKAGE System::ResourceString _FlexCelVersion;
#define Tmsuflxmessages_FlexCelVersion System::LoadResourceString(&Tmsuflxmessages::_FlexCelVersion)
extern PACKAGE System::ResourceString _ErrNoAdapter;
#define Tmsuflxmessages_ErrNoAdapter System::LoadResourceString(&Tmsuflxmessages::_ErrNoAdapter)
extern PACKAGE System::ResourceString _ErrTooManySheets;
#define Tmsuflxmessages_ErrTooManySheets System::LoadResourceString(&Tmsuflxmessages::_ErrTooManySheets)
extern PACKAGE System::ResourceString _ErrNoDataSet;
#define Tmsuflxmessages_ErrNoDataSet System::LoadResourceString(&Tmsuflxmessages::_ErrNoDataSet)
extern PACKAGE System::ResourceString _ErrNoPropDefined;
#define Tmsuflxmessages_ErrNoPropDefined System::LoadResourceString(&Tmsuflxmessages::_ErrNoPropDefined)
extern PACKAGE System::ResourceString _ErrBadProp;
#define Tmsuflxmessages_ErrBadProp System::LoadResourceString(&Tmsuflxmessages::_ErrBadProp)
extern PACKAGE System::ResourceString _ErrTooManyDimensions;
#define Tmsuflxmessages_ErrTooManyDimensions System::LoadResourceString(&Tmsuflxmessages::_ErrTooManyDimensions)
extern PACKAGE System::ResourceString _ErrIndexOutBounds;
#define Tmsuflxmessages_ErrIndexOutBounds System::LoadResourceString(&Tmsuflxmessages::_ErrIndexOutBounds)
extern PACKAGE System::ResourceString _ErrInvalidDrawingType;
#define Tmsuflxmessages_ErrInvalidDrawingType System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidDrawingType)
extern PACKAGE System::ResourceString _ErrNoOpenFile;
#define Tmsuflxmessages_ErrNoOpenFile System::LoadResourceString(&Tmsuflxmessages::_ErrNoOpenFile)
extern PACKAGE System::ResourceString _ErrCantFindFile;
#define Tmsuflxmessages_ErrCantFindFile System::LoadResourceString(&Tmsuflxmessages::_ErrCantFindFile)
extern PACKAGE System::ResourceString _ErrNoTemplate;
#define Tmsuflxmessages_ErrNoTemplate System::LoadResourceString(&Tmsuflxmessages::_ErrNoTemplate)
extern PACKAGE System::ResourceString _ErrDocumentNotSaved;
#define Tmsuflxmessages_ErrDocumentNotSaved System::LoadResourceString(&Tmsuflxmessages::_ErrDocumentNotSaved)
extern PACKAGE System::ResourceString _ErrFieldNil;
#define Tmsuflxmessages_ErrFieldNil System::LoadResourceString(&Tmsuflxmessages::_ErrFieldNil)
extern PACKAGE System::ResourceString _ErrDupField;
#define Tmsuflxmessages_ErrDupField System::LoadResourceString(&Tmsuflxmessages::_ErrDupField)
extern PACKAGE System::ResourceString _ErrFieldNotFound;
#define Tmsuflxmessages_ErrFieldNotFound System::LoadResourceString(&Tmsuflxmessages::_ErrFieldNotFound)
extern PACKAGE System::ResourceString _ErrInvalidColumnCount;
#define Tmsuflxmessages_ErrInvalidColumnCount System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidColumnCount)
extern PACKAGE System::ResourceString _MsgAbout;
#define Tmsuflxmessages_MsgAbout System::LoadResourceString(&Tmsuflxmessages::_MsgAbout)
extern PACKAGE System::ResourceString _TxtDatasets;
#define Tmsuflxmessages_TxtDatasets System::LoadResourceString(&Tmsuflxmessages::_TxtDatasets)
extern PACKAGE System::ResourceString _TxtProperties;
#define Tmsuflxmessages_TxtProperties System::LoadResourceString(&Tmsuflxmessages::_TxtProperties)
extern PACKAGE System::ResourceString _TxtExtras;
#define Tmsuflxmessages_TxtExtras System::LoadResourceString(&Tmsuflxmessages::_TxtExtras)
extern PACKAGE System::ResourceString _TxtFileModified;
#define Tmsuflxmessages_TxtFileModified System::LoadResourceString(&Tmsuflxmessages::_TxtFileModified)
extern PACKAGE System::ResourceString _TxtFileModifiedCaption;
#define Tmsuflxmessages_TxtFileModifiedCaption System::LoadResourceString(&Tmsuflxmessages::_TxtFileModifiedCaption)
extern PACKAGE System::ResourceString _TxtEditing;
#define Tmsuflxmessages_TxtEditing System::LoadResourceString(&Tmsuflxmessages::_TxtEditing)
extern PACKAGE System::ResourceString _TxtEditTemplate;
#define Tmsuflxmessages_TxtEditTemplate System::LoadResourceString(&Tmsuflxmessages::_TxtEditTemplate)
extern PACKAGE System::ResourceString _TxtRefreshTemplate;
#define Tmsuflxmessages_TxtRefreshTemplate System::LoadResourceString(&Tmsuflxmessages::_TxtRefreshTemplate)
extern PACKAGE System::ResourceString _TxtTemplateStoreRefreshed;
#define Tmsuflxmessages_TxtTemplateStoreRefreshed System::LoadResourceString(&Tmsuflxmessages::_TxtTemplateStoreRefreshed)
extern PACKAGE System::ResourceString _TxtDeleteRange;
#define Tmsuflxmessages_TxtDeleteRange System::LoadResourceString(&Tmsuflxmessages::_TxtDeleteRange)
extern PACKAGE System::ResourceString _TxtDeleteRangeCaption;
#define Tmsuflxmessages_TxtDeleteRangeCaption System::LoadResourceString(&Tmsuflxmessages::_TxtDeleteRangeCaption)
extern PACKAGE System::ResourceString _TxtNamedRangeFormula;
#define Tmsuflxmessages_TxtNamedRangeFormula System::LoadResourceString(&Tmsuflxmessages::_TxtNamedRangeFormula)
extern PACKAGE System::ResourceString _ErrComponentIsNotXlsDataSet;
#define Tmsuflxmessages_ErrComponentIsNotXlsDataSet System::LoadResourceString(&Tmsuflxmessages::_ErrComponentIsNotXlsDataSet)
extern PACKAGE System::ResourceString _ErrUseFasterAdapter;
#define Tmsuflxmessages_ErrUseFasterAdapter System::LoadResourceString(&Tmsuflxmessages::_ErrUseFasterAdapter)
extern PACKAGE System::ResourceString _TxtTrue;
#define Tmsuflxmessages_TxtTrue System::LoadResourceString(&Tmsuflxmessages::_TxtTrue)
extern PACKAGE System::ResourceString _TxtFalse;
#define Tmsuflxmessages_TxtFalse System::LoadResourceString(&Tmsuflxmessages::_TxtFalse)
extern PACKAGE System::ResourceString _ErrInvalidWmf;
#define Tmsuflxmessages_ErrInvalidWmf System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidWmf)
extern PACKAGE System::ResourceString _TxtSepLog;
#define Tmsuflxmessages_TxtSepLog System::LoadResourceString(&Tmsuflxmessages::_TxtSepLog)
extern PACKAGE System::ResourceString _TxtCheckHeader;
#define Tmsuflxmessages_TxtCheckHeader System::LoadResourceString(&Tmsuflxmessages::_TxtCheckHeader)
extern PACKAGE System::ResourceString _TxtError;
#define Tmsuflxmessages_TxtError System::LoadResourceString(&Tmsuflxmessages::_TxtError)
extern PACKAGE System::ResourceString _TxtOK;
#define Tmsuflxmessages_TxtOK System::LoadResourceString(&Tmsuflxmessages::_TxtOK)
extern PACKAGE System::ResourceString _ErrInvalidRangeName;
#define Tmsuflxmessages_ErrInvalidRangeName System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidRangeName)
extern PACKAGE System::ResourceString _ErrRangeNameNotFound;
#define Tmsuflxmessages_ErrRangeNameNotFound System::LoadResourceString(&Tmsuflxmessages::_ErrRangeNameNotFound)
extern PACKAGE System::ResourceString _ErrRangeNameInvalidType;
#define Tmsuflxmessages_ErrRangeNameInvalidType System::LoadResourceString(&Tmsuflxmessages::_ErrRangeNameInvalidType)
extern PACKAGE System::ResourceString _ErrCheckCellDots;
#define Tmsuflxmessages_ErrCheckCellDots System::LoadResourceString(&Tmsuflxmessages::_ErrCheckCellDots)
extern PACKAGE System::ResourceString _ErrCheckDotCommandsCol;
#define Tmsuflxmessages_ErrCheckDotCommandsCol System::LoadResourceString(&Tmsuflxmessages::_ErrCheckDotCommandsCol)
extern PACKAGE System::ResourceString _ErrInvalidCellDB;
#define Tmsuflxmessages_ErrInvalidCellDB System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidCellDB)
extern PACKAGE System::ResourceString _ErrInvalidCellDB2;
#define Tmsuflxmessages_ErrInvalidCellDB2 System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidCellDB2)
extern PACKAGE System::ResourceString _ErrInvalidField;
#define Tmsuflxmessages_ErrInvalidField System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidField)
extern PACKAGE System::ResourceString _ErrInvalidPagesField;
#define Tmsuflxmessages_ErrInvalidPagesField System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidPagesField)
extern PACKAGE System::ResourceString _ErrFieldOutsideRange;
#define Tmsuflxmessages_ErrFieldOutsideRange System::LoadResourceString(&Tmsuflxmessages::_ErrFieldOutsideRange)
extern PACKAGE System::ResourceString _ErrInvalidImageDB;
#define Tmsuflxmessages_ErrInvalidImageDB System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidImageDB)
extern PACKAGE System::ResourceString _ErrInvalidImageField;
#define Tmsuflxmessages_ErrInvalidImageField System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidImageField)
extern PACKAGE System::ResourceString _ErrInvalidImageType;
#define Tmsuflxmessages_ErrInvalidImageType System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidImageType)
extern PACKAGE System::ResourceString _ErrTemplateNotRefreshed;
#define Tmsuflxmessages_ErrTemplateNotRefreshed System::LoadResourceString(&Tmsuflxmessages::_ErrTemplateNotRefreshed)
extern PACKAGE System::ResourceString _ErrNoAdvStrGrid;
#define Tmsuflxmessages_ErrNoAdvStrGrid System::LoadResourceString(&Tmsuflxmessages::_ErrNoAdvStrGrid)
extern PACKAGE System::ResourceString _ErrInvalidSheetName;
#define Tmsuflxmessages_ErrInvalidSheetName System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidSheetName)
extern PACKAGE System::ResourceString _ErrInvalidNameForARange;
#define Tmsuflxmessages_ErrInvalidNameForARange System::LoadResourceString(&Tmsuflxmessages::_ErrInvalidNameForARange)
extern PACKAGE System::ResourceString _xls_Emf;
#define Tmsuflxmessages_xls_Emf System::LoadResourceString(&Tmsuflxmessages::_xls_Emf)
extern PACKAGE System::ResourceString _xls_Wmf;
#define Tmsuflxmessages_xls_Wmf System::LoadResourceString(&Tmsuflxmessages::_xls_Wmf)
extern PACKAGE System::ResourceString _xls_Jpeg;
#define Tmsuflxmessages_xls_Jpeg System::LoadResourceString(&Tmsuflxmessages::_xls_Jpeg)
extern PACKAGE System::ResourceString _xls_Png;
#define Tmsuflxmessages_xls_Png System::LoadResourceString(&Tmsuflxmessages::_xls_Png)
static const Word Date1904Diff = 0x5b6;
static const ShortInt TExcelPaperSize_Undefined = 0x0;
static const ShortInt TExcelPaperSize_Letter = 0x1;
static const ShortInt TExcelPaperSize_Lettersmall = 0x2;
static const ShortInt TExcelPaperSize_Tabloid = 0x3;
static const ShortInt TExcelPaperSize_Ledger = 0x4;
static const ShortInt TExcelPaperSize_Legal = 0x5;
static const ShortInt TExcelPaperSize_Statement = 0x6;
static const ShortInt TExcelPaperSize_Executive = 0x7;
static const ShortInt TExcelPaperSize_A3 = 0x8;
static const ShortInt TExcelPaperSize_A4 = 0x9;
static const ShortInt TExcelPaperSize_A4small = 0xa;
static const ShortInt TExcelPaperSize_A5 = 0xb;
static const ShortInt TExcelPaperSize_B4_JIS = 0xc;
static const ShortInt TExcelPaperSize_B5_JIS = 0xd;
static const ShortInt TExcelPaperSize_Folio = 0xe;
static const ShortInt TExcelPaperSize_Quarto = 0xf;
static const ShortInt TExcelPaperSize_s10x14 = 0x10;
static const ShortInt TExcelPaperSize_s11x17 = 0x11;
static const ShortInt TExcelPaperSize_Note = 0x12;
static const ShortInt TExcelPaperSize_Envelope9 = 0x13;
static const ShortInt TExcelPaperSize_Envelope10 = 0x14;
static const ShortInt TExcelPaperSize_Envelope11 = 0x15;
static const ShortInt TExcelPaperSize_Envelope12 = 0x16;
static const ShortInt TExcelPaperSize_Envelope14 = 0x17;
static const ShortInt TExcelPaperSize_C = 0x18;
static const ShortInt TExcelPaperSize_D = 0x19;
static const ShortInt TExcelPaperSize_E = 0x1a;
static const ShortInt TExcelPaperSize_EnvelopeDL = 0x1b;
static const ShortInt TExcelPaperSize_EnvelopeC5 = 0x1c;
static const ShortInt TExcelPaperSize_EnvelopeC3 = 0x1d;
static const ShortInt TExcelPaperSize_EnvelopeC4 = 0x1e;
static const ShortInt TExcelPaperSize_EnvelopeC6 = 0x1f;
static const ShortInt TExcelPaperSize_EnvelopeC6_C5 = 0x20;
static const ShortInt TExcelPaperSize_B4_ISO = 0x21;
static const ShortInt TExcelPaperSize_B5_ISO = 0x22;
static const ShortInt TExcelPaperSize_B6_ISO = 0x23;
static const ShortInt TExcelPaperSize_EnvelopeItaly = 0x24;
static const ShortInt TExcelPaperSize_EnvelopeMonarch = 0x25;
static const ShortInt TExcelPaperSize_s63_4Envelope = 0x26;
static const ShortInt TExcelPaperSize_USStandardFanfold = 0x27;
static const ShortInt TExcelPaperSize_GermanStdFanfold = 0x28;
static const ShortInt TExcelPaperSize_GermanLegalFanfold = 0x29;
static const ShortInt TExcelPaperSize_B4_ISO_2 = 0x2a;
static const ShortInt TExcelPaperSize_JapanesePostcard = 0x2b;
static const ShortInt TExcelPaperSize_s9x11 = 0x2c;
static const ShortInt TExcelPaperSize_s10x11 = 0x2d;
static const ShortInt TExcelPaperSize_s15x11 = 0x2e;
static const ShortInt TExcelPaperSize_EnvelopeInvite = 0x2f;
static const ShortInt TExcelPaperSize_LetterExtra = 0x32;
static const ShortInt TExcelPaperSize_LegalExtra = 0x33;
static const ShortInt TExcelPaperSize_TabloidExtra = 0x34;
static const ShortInt TExcelPaperSize_A4Extra = 0x35;
static const ShortInt TExcelPaperSize_LetterTransverse = 0x36;
static const ShortInt TExcelPaperSize_A4Transverse = 0x37;
static const ShortInt TExcelPaperSize_LetterExtraTransv = 0x38;
static const ShortInt TExcelPaperSize_SuperA_A4 = 0x39;
static const ShortInt TExcelPaperSize_SuperB_A3 = 0x3a;
static const ShortInt TExcelPaperSize_LetterPlus = 0x3b;
static const ShortInt TExcelPaperSize_A4Plus = 0x3c;
static const ShortInt TExcelPaperSize_A5Transverse = 0x3d;
static const ShortInt TExcelPaperSize_B5_JIS_Transverse = 0x3e;
static const ShortInt TExcelPaperSize_A3Extra = 0x3f;
static const ShortInt TExcelPaperSize_A5Extra = 0x40;
static const ShortInt TExcelPaperSize_B5_ISO_Extra = 0x41;
static const ShortInt TExcelPaperSize_A2 = 0x42;
static const ShortInt TExcelPaperSize_A3Transverse = 0x43;
static const ShortInt TExcelPaperSize_A3ExtraTransverse = 0x44;
static const ShortInt TExcelPaperSize_DblJapanesePostcard = 0x45;
static const ShortInt TExcelPaperSize_A6 = 0x46;
static const ShortInt TExcelPaperSize_LetterRotated = 0x4b;
static const ShortInt TExcelPaperSize_A3Rotated = 0x4c;
static const ShortInt TExcelPaperSize_A4Rotated = 0x4d;
static const ShortInt TExcelPaperSize_A5Rotated = 0x4e;
static const ShortInt TExcelPaperSize_B4_JIS_Rotated = 0x4f;
static const ShortInt TExcelPaperSize_B5_JIS_Rotated = 0x50;
static const ShortInt TExcelPaperSize_JapanesePostcardRot = 0x51;
static const ShortInt TExcelPaperSize_DblJapPostcardRot = 0x52;
static const ShortInt TExcelPaperSize_A6Rotated = 0x53;
static const ShortInt TExcelPaperSize_B6_JIS = 0x58;
static const ShortInt TExcelPaperSize_B6_JIS_Rotated = 0x59;
static const ShortInt TExcelPaperSize_s12x11 = 0x5a;
extern PACKAGE int DefColWidthAdapt;
static const ShortInt fpo_LeftToRight = 0x1;
static const ShortInt fpo_Orientation = 0x2;
static const ShortInt fpo_NoPls = 0x4;
static const ShortInt fpo_NoColor = 0x8;
static const ShortInt fpo_Draft = 0x10;
static const ShortInt fpo_Notes = 0x20;
static const ShortInt fpo_NoOrient = 0x40;
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
extern PACKAGE System::Extended ColMult;
extern PACKAGE System::Extended RowMult;
extern PACKAGE System::UnicodeString __fastcall EncodeColumn(const int C);
extern PACKAGE System::UnicodeString __fastcall SearchPathStr(const System::UnicodeString AFileName)/* overload */;
extern PACKAGE System::UnicodeString __fastcall SearchPathStr(const System::UnicodeString AFilePath, const System::UnicodeString AFileName)/* overload */;
extern PACKAGE void __fastcall EnsureAMPM(PFormatSettings &FormatSettings);
extern PACKAGE PFormatSettings __fastcall GetDefaultLocaleFormatSettings(void);
extern PACKAGE bool __fastcall TryStrToFloatInvariant(const System::UnicodeString s, /* out */ System::Extended &i);
extern PACKAGE System::UnicodeString __fastcall WideUpperCase98(const System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall StringReplaceSkipQuotes(const System::UnicodeString S, const System::UnicodeString OldPattern, const System::UnicodeString NewPattern);
extern PACKAGE bool __fastcall FlxTryStrToDateTime(const System::UnicodeString S, /* out */ System::TDateTime &Value, /* out */ System::UnicodeString &dFormat, /* out */ bool &HasDate, /* out */ bool &HasTime, const System::UnicodeString DateFormat = L"", const System::UnicodeString TimeFormat = L"");
extern PACKAGE System::UnicodeString __fastcall TryFormatDateTime [[deprecated("Use TryFormatDateTime1904 instead")]](const System::UnicodeString Fmt, System::TDateTime value);
extern PACKAGE System::UnicodeString __fastcall TryFormatDateTime1904(const System::UnicodeString Fmt, System::TDateTime value, const bool Dates1904, const Sysutils::TFormatSettings &LocalSettings)/* overload */;
extern PACKAGE System::UnicodeString __fastcall TryFormatDateTime1904(const System::UnicodeString Fmt, System::TDateTime value, const bool Dates1904)/* overload */;
extern PACKAGE TXlsCellRange __fastcall OffsetRange(const TXlsCellRange &CellRange, const int DeltaRow, const int DeltaCol);
extern PACKAGE void __fastcall InitializeNamedRange(/* out */ TXlsNamedRange &NamedRange);
extern PACKAGE System::UnicodeString __fastcall VariantToString(const System::Variant &v);

}	/* namespace Tmsuflxmessages */
using namespace Tmsuflxmessages;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuflxmessagesHPP
