// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlxMessages.pas' rev: 22.00

#ifndef UflxmessagesHPP
#define UflxmessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <VarUtils.hpp>	// Pascal unit
#include <pngimage.hpp>	// Pascal unit
#include <ZLib.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxmessages
{
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString UTF16String;

typedef System::WideChar UTF16Char;

typedef System::PByte PAddress;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TClientAnchor
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

typedef System::DynamicArray<System::UnicodeString> WidestringArray;

typedef System::DynamicArray<System::WideChar> WideCharArray;

typedef System::DynamicArray<bool> BooleanArray;

typedef System::DynamicArray<System::Byte> ByteArray;

struct DECLSPEC_DRECORD TPrinterDriverSettings
{
	
private:
	typedef System::DynamicArray<System::Byte> _TPrinterDriverSettings__1;
	
	
public:
	System::Word OperatingEnviroment;
	_TPrinterDriverSettings__1 Data;
};


typedef int TExcelPaperSize;

typedef System::ShortInt TColorPaletteRange;

struct DECLSPEC_DRECORD TXlsCellRange
{
	
public:
	int Left;
	int Top;
	int Right;
	int Bottom;
};


struct DECLSPEC_DRECORD TXlsNamedRange
{
	
public:
	System::UnicodeString Name;
	System::UnicodeString RangeFormula;
	int OptionFlags;
	int NameSheetIndex;
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD TXlsMargins
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

struct DECLSPEC_DRECORD TRTFRun
{
	
public:
	System::Word FirstChar;
	System::Word FontIndex;
};


typedef System::DynamicArray<TRTFRun> TRTFRunList;

struct DECLSPEC_DRECORD TRichString
{
	
public:
	System::UnicodeString Value;
	TRTFRunList RTFRuns;
};


#pragma option push -b-
enum THyperLinkType { hl_URL, hl_LocalFile, hl_UNC, hl_CurrentWorkbook };
#pragma option pop

struct DECLSPEC_DRECORD THyperLink
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

typedef System::StaticArray<System::Variant, 134217727> VariantArray;

typedef System::DynamicArray<System::Variant> ArrayOfVariant;

struct DECLSPEC_DRECORD TXlsCellValue
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

struct DECLSPEC_DRECORD TImageProperties
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
static const System::Word FLX_VAR_LOCALE_USER_DEFAULT = 0x400;
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
static const System::Word Date1904Diff = 0x5b6;
static const System::ShortInt TExcelPaperSize_Undefined = 0x0;
static const System::ShortInt TExcelPaperSize_Letter = 0x1;
static const System::ShortInt TExcelPaperSize_Lettersmall = 0x2;
static const System::ShortInt TExcelPaperSize_Tabloid = 0x3;
static const System::ShortInt TExcelPaperSize_Ledger = 0x4;
static const System::ShortInt TExcelPaperSize_Legal = 0x5;
static const System::ShortInt TExcelPaperSize_Statement = 0x6;
static const System::ShortInt TExcelPaperSize_Executive = 0x7;
static const System::ShortInt TExcelPaperSize_A3 = 0x8;
static const System::ShortInt TExcelPaperSize_A4 = 0x9;
static const System::ShortInt TExcelPaperSize_A4small = 0xa;
static const System::ShortInt TExcelPaperSize_A5 = 0xb;
static const System::ShortInt TExcelPaperSize_B4_JIS = 0xc;
static const System::ShortInt TExcelPaperSize_B5_JIS = 0xd;
static const System::ShortInt TExcelPaperSize_Folio = 0xe;
static const System::ShortInt TExcelPaperSize_Quarto = 0xf;
static const System::ShortInt TExcelPaperSize_s10x14 = 0x10;
static const System::ShortInt TExcelPaperSize_s11x17 = 0x11;
static const System::ShortInt TExcelPaperSize_Note = 0x12;
static const System::ShortInt TExcelPaperSize_Envelope9 = 0x13;
static const System::ShortInt TExcelPaperSize_Envelope10 = 0x14;
static const System::ShortInt TExcelPaperSize_Envelope11 = 0x15;
static const System::ShortInt TExcelPaperSize_Envelope12 = 0x16;
static const System::ShortInt TExcelPaperSize_Envelope14 = 0x17;
static const System::ShortInt TExcelPaperSize_C = 0x18;
static const System::ShortInt TExcelPaperSize_D = 0x19;
static const System::ShortInt TExcelPaperSize_E = 0x1a;
static const System::ShortInt TExcelPaperSize_EnvelopeDL = 0x1b;
static const System::ShortInt TExcelPaperSize_EnvelopeC5 = 0x1c;
static const System::ShortInt TExcelPaperSize_EnvelopeC3 = 0x1d;
static const System::ShortInt TExcelPaperSize_EnvelopeC4 = 0x1e;
static const System::ShortInt TExcelPaperSize_EnvelopeC6 = 0x1f;
static const System::ShortInt TExcelPaperSize_EnvelopeC6_C5 = 0x20;
static const System::ShortInt TExcelPaperSize_B4_ISO = 0x21;
static const System::ShortInt TExcelPaperSize_B5_ISO = 0x22;
static const System::ShortInt TExcelPaperSize_B6_ISO = 0x23;
static const System::ShortInt TExcelPaperSize_EnvelopeItaly = 0x24;
static const System::ShortInt TExcelPaperSize_EnvelopeMonarch = 0x25;
static const System::ShortInt TExcelPaperSize_s63_4Envelope = 0x26;
static const System::ShortInt TExcelPaperSize_USStandardFanfold = 0x27;
static const System::ShortInt TExcelPaperSize_GermanStdFanfold = 0x28;
static const System::ShortInt TExcelPaperSize_GermanLegalFanfold = 0x29;
static const System::ShortInt TExcelPaperSize_B4_ISO_2 = 0x2a;
static const System::ShortInt TExcelPaperSize_JapanesePostcard = 0x2b;
static const System::ShortInt TExcelPaperSize_s9x11 = 0x2c;
static const System::ShortInt TExcelPaperSize_s10x11 = 0x2d;
static const System::ShortInt TExcelPaperSize_s15x11 = 0x2e;
static const System::ShortInt TExcelPaperSize_EnvelopeInvite = 0x2f;
static const System::ShortInt TExcelPaperSize_LetterExtra = 0x32;
static const System::ShortInt TExcelPaperSize_LegalExtra = 0x33;
static const System::ShortInt TExcelPaperSize_TabloidExtra = 0x34;
static const System::ShortInt TExcelPaperSize_A4Extra = 0x35;
static const System::ShortInt TExcelPaperSize_LetterTransverse = 0x36;
static const System::ShortInt TExcelPaperSize_A4Transverse = 0x37;
static const System::ShortInt TExcelPaperSize_LetterExtraTransv = 0x38;
static const System::ShortInt TExcelPaperSize_SuperA_A4 = 0x39;
static const System::ShortInt TExcelPaperSize_SuperB_A3 = 0x3a;
static const System::ShortInt TExcelPaperSize_LetterPlus = 0x3b;
static const System::ShortInt TExcelPaperSize_A4Plus = 0x3c;
static const System::ShortInt TExcelPaperSize_A5Transverse = 0x3d;
static const System::ShortInt TExcelPaperSize_B5_JIS_Transverse = 0x3e;
static const System::ShortInt TExcelPaperSize_A3Extra = 0x3f;
static const System::ShortInt TExcelPaperSize_A5Extra = 0x40;
static const System::ShortInt TExcelPaperSize_B5_ISO_Extra = 0x41;
static const System::ShortInt TExcelPaperSize_A2 = 0x42;
static const System::ShortInt TExcelPaperSize_A3Transverse = 0x43;
static const System::ShortInt TExcelPaperSize_A3ExtraTransverse = 0x44;
static const System::ShortInt TExcelPaperSize_DblJapanesePostcard = 0x45;
static const System::ShortInt TExcelPaperSize_A6 = 0x46;
static const System::ShortInt TExcelPaperSize_LetterRotated = 0x4b;
static const System::ShortInt TExcelPaperSize_A3Rotated = 0x4c;
static const System::ShortInt TExcelPaperSize_A4Rotated = 0x4d;
static const System::ShortInt TExcelPaperSize_A5Rotated = 0x4e;
static const System::ShortInt TExcelPaperSize_B4_JIS_Rotated = 0x4f;
static const System::ShortInt TExcelPaperSize_B5_JIS_Rotated = 0x50;
static const System::ShortInt TExcelPaperSize_JapanesePostcardRot = 0x51;
static const System::ShortInt TExcelPaperSize_DblJapPostcardRot = 0x52;
static const System::ShortInt TExcelPaperSize_A6Rotated = 0x53;
static const System::ShortInt TExcelPaperSize_B6_JIS = 0x58;
static const System::ShortInt TExcelPaperSize_B6_JIS_Rotated = 0x59;
static const System::ShortInt TExcelPaperSize_s12x11 = 0x5a;
extern PACKAGE int DefColWidthAdapt;
static const System::ShortInt fpo_LeftToRight = 0x1;
static const System::ShortInt fpo_Orientation = 0x2;
static const System::ShortInt fpo_NoPls = 0x4;
static const System::ShortInt fpo_NoColor = 0x8;
static const System::ShortInt fpo_Draft = 0x10;
static const System::ShortInt fpo_Notes = 0x20;
static const System::ShortInt fpo_NoOrient = 0x40;
static const System::Byte fpo_UsePage = 0x80;
static const char InternalNameRange_Consolidate_Area = '\0';
static const char InternalNameRange_Auto_Open = '\x01';
static const char InternalNameRange_Auto_Close = '\x02';
static const char InternalNameRange_Extract = '\x03';
static const char InternalNameRange_Database = '\x04';
static const char InternalNameRange_Criteria = '\x05';
static const char InternalNameRange_Print_Area = '\x06';
static const char InternalNameRange_Print_Titles = '\x07';
static const char InternalNameRange_Recorder = '\x08';
static const char InternalNameRange_Data_Form = '\x09';
static const char InternalNameRange_Auto_Activate = '\x0a';
static const char InternalNameRange_Auto_Deactivate = '\x0b';
static const char InternalNameRange_Sheet_Title = '\x0c';
static const char InternalNameRange_Filter_DataBase = '\x0d';
extern PACKAGE System::Extended ColMult;
extern PACKAGE System::Extended RowMult;
extern PACKAGE System::UnicodeString __fastcall EncodeColumn(const int C);
extern PACKAGE System::UnicodeString __fastcall SearchPathStr(const System::UnicodeString AFileName)/* overload */;
extern PACKAGE System::UnicodeString __fastcall SearchPathStr(const System::UnicodeString AFilePath, const System::UnicodeString AFileName)/* overload */;
extern PACKAGE void __fastcall EnsureAMPM(PFormatSettings &FormatSettings);
extern PACKAGE PFormatSettings __fastcall GetDefaultLocaleFormatSettings(void);
extern PACKAGE PFormatSettings __fastcall InvariantFormatSettings(void);
extern PACKAGE bool __fastcall TryStrToFloatInvariant(const System::UnicodeString s, /* out */ System::Extended &i);
extern PACKAGE System::UnicodeString __fastcall WideUpperCase98(const System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall StringReplaceSkipQuotes(const System::UnicodeString S, const System::UnicodeString OldPattern, const System::UnicodeString NewPattern);
extern PACKAGE bool __fastcall FlxTryStrToDateTime(const System::UnicodeString S, /* out */ System::TDateTime &Value, /* out */ System::UnicodeString &dFormat, /* out */ bool &HasDate, /* out */ bool &HasTime, const System::UnicodeString DateFormat = L"", const System::UnicodeString TimeFormat = L"", const PFormatSettings FormatSettings = (PFormatSettings)(0x0));
extern PACKAGE System::UnicodeString __fastcall TryFormatDateTime [[deprecated("Use TryFormatDateTime1904 instead")]](const System::UnicodeString Fmt, System::TDateTime value);
extern PACKAGE System::UnicodeString __fastcall TryFormatDateTime1904(const System::UnicodeString Fmt, System::TDateTime value, const bool Dates1904, const Sysutils::TFormatSettings &LocalSettings)/* overload */;
extern PACKAGE System::UnicodeString __fastcall TryFormatDateTime1904(const System::UnicodeString Fmt, System::TDateTime value, const bool Dates1904)/* overload */;
extern PACKAGE TXlsCellRange __fastcall OffsetRange(const TXlsCellRange &CellRange, const int DeltaRow, const int DeltaCol);
extern PACKAGE void __fastcall InitializeNamedRange(/* out */ TXlsNamedRange &NamedRange);
extern PACKAGE System::UnicodeString __fastcall VariantToString(const System::Variant &v);

}	/* namespace Uflxmessages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflxmessages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflxmessagesHPP
