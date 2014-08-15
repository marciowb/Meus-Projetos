// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'XlsMessages.pas' rev: 22.00

#ifndef XlsmessagesHPP
#define XlsmessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Xlsmessages
{
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::Byte, 1073741824> ArrayOfByte;

typedef ArrayOfByte *PArrayOfByte;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TRecordHeader
{
	
public:
	System::Word Id;
	System::Word Size;
};
#pragma pack(pop)


typedef TRecordHeader *PRecordHeader;

class DELPHICLASS EExcelException;
class PASCALIMPLEMENTATION EExcelException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EExcelException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EExcelException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EExcelException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EExcelException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EExcelException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EExcelException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EExcelException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EExcelException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EExcelException(void) { }
	
};


typedef int __fastcall (__closure *TGetSheet)(const System::Word aSheetRef);

struct DECLSPEC_DRECORD TSheetInfo
{
	
public:
	int InsSheet;
	int FormulaSheet;
	TGetSheet GetSheet;
	TGetSheet SetSheet;
	System::TObject* Names;
};


typedef System::Word *pWord;

typedef unsigned *pLongWord;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _ErrFileIsNotXLS;
#define Xlsmessages_ErrFileIsNotXLS System::LoadResourceString(&Xlsmessages::_ErrFileIsNotXLS)
extern PACKAGE System::ResourceString _ErrCantReadFile;
#define Xlsmessages_ErrCantReadFile System::LoadResourceString(&Xlsmessages::_ErrCantReadFile)
extern PACKAGE System::ResourceString _ErrExcelInvalid;
#define Xlsmessages_ErrExcelInvalid System::LoadResourceString(&Xlsmessages::_ErrExcelInvalid)
extern PACKAGE System::ResourceString _ErrCantWriteOutput;
#define Xlsmessages_ErrCantWriteOutput System::LoadResourceString(&Xlsmessages::_ErrCantWriteOutput)
extern PACKAGE System::ResourceString _ErrCantWrite;
#define Xlsmessages_ErrCantWrite System::LoadResourceString(&Xlsmessages::_ErrCantWrite)
extern PACKAGE System::ResourceString _ErrFileNotFound;
#define Xlsmessages_ErrFileNotFound System::LoadResourceString(&Xlsmessages::_ErrFileNotFound)
extern PACKAGE System::ResourceString _ErrStreamNotFound;
#define Xlsmessages_ErrStreamNotFound System::LoadResourceString(&Xlsmessages::_ErrStreamNotFound)
extern PACKAGE System::ResourceString _ErrExtRefsNotSupported;
#define Xlsmessages_ErrExtRefsNotSupported System::LoadResourceString(&Xlsmessages::_ErrExtRefsNotSupported)
extern PACKAGE System::ResourceString _ErrWrongExcelRecord;
#define Xlsmessages_ErrWrongExcelRecord System::LoadResourceString(&Xlsmessages::_ErrWrongExcelRecord)
extern PACKAGE System::ResourceString _ErrBadToken;
#define Xlsmessages_ErrBadToken System::LoadResourceString(&Xlsmessages::_ErrBadToken)
extern PACKAGE System::ResourceString _ErrBadFormula;
#define Xlsmessages_ErrBadFormula System::LoadResourceString(&Xlsmessages::_ErrBadFormula)
extern PACKAGE System::ResourceString _ErrBadName;
#define Xlsmessages_ErrBadName System::LoadResourceString(&Xlsmessages::_ErrBadName)
extern PACKAGE System::ResourceString _ErrBadCF;
#define Xlsmessages_ErrBadCF System::LoadResourceString(&Xlsmessages::_ErrBadCF)
extern PACKAGE System::ResourceString _ErrBadChartFormula;
#define Xlsmessages_ErrBadChartFormula System::LoadResourceString(&Xlsmessages::_ErrBadChartFormula)
extern PACKAGE System::ResourceString _Err3DRef;
#define Xlsmessages_Err3DRef System::LoadResourceString(&Xlsmessages::_Err3DRef)
extern PACKAGE System::ResourceString _ErrReadingRecord;
#define Xlsmessages_ErrReadingRecord System::LoadResourceString(&Xlsmessages::_ErrReadingRecord)
extern PACKAGE System::ResourceString _ErrInvalidVersion;
#define Xlsmessages_ErrInvalidVersion System::LoadResourceString(&Xlsmessages::_ErrInvalidVersion)
extern PACKAGE System::ResourceString _ErrTooManyEntries;
#define Xlsmessages_ErrTooManyEntries System::LoadResourceString(&Xlsmessages::_ErrTooManyEntries)
extern PACKAGE System::ResourceString _ErrRecordNotSupported;
#define Xlsmessages_ErrRecordNotSupported System::LoadResourceString(&Xlsmessages::_ErrRecordNotSupported)
extern PACKAGE System::ResourceString _ErrSectionNotLoaded;
#define Xlsmessages_ErrSectionNotLoaded System::LoadResourceString(&Xlsmessages::_ErrSectionNotLoaded)
extern PACKAGE System::ResourceString _ErrInvalidContinue;
#define Xlsmessages_ErrInvalidContinue System::LoadResourceString(&Xlsmessages::_ErrInvalidContinue)
extern PACKAGE System::ResourceString _ErrStringTooLarge;
#define Xlsmessages_ErrStringTooLarge System::LoadResourceString(&Xlsmessages::_ErrStringTooLarge)
extern PACKAGE System::ResourceString _ErrInvalidDrawing;
#define Xlsmessages_ErrInvalidDrawing System::LoadResourceString(&Xlsmessages::_ErrInvalidDrawing)
extern PACKAGE System::ResourceString _ErrInvalidCF;
#define Xlsmessages_ErrInvalidCF System::LoadResourceString(&Xlsmessages::_ErrInvalidCF)
extern PACKAGE System::ResourceString _ErrDuplicatedSheetName;
#define Xlsmessages_ErrDuplicatedSheetName System::LoadResourceString(&Xlsmessages::_ErrDuplicatedSheetName)
extern PACKAGE System::ResourceString _ErrDupRow;
#define Xlsmessages_ErrDupRow System::LoadResourceString(&Xlsmessages::_ErrDupRow)
extern PACKAGE System::ResourceString _ErrRowMissing;
#define Xlsmessages_ErrRowMissing System::LoadResourceString(&Xlsmessages::_ErrRowMissing)
extern PACKAGE System::ResourceString _ErrBadCopyRows;
#define Xlsmessages_ErrBadCopyRows System::LoadResourceString(&Xlsmessages::_ErrBadCopyRows)
extern PACKAGE System::ResourceString _ErrInvalidSheetNo;
#define Xlsmessages_ErrInvalidSheetNo System::LoadResourceString(&Xlsmessages::_ErrInvalidSheetNo)
extern PACKAGE System::ResourceString _ErrBadRowCount;
#define Xlsmessages_ErrBadRowCount System::LoadResourceString(&Xlsmessages::_ErrBadRowCount)
extern PACKAGE System::ResourceString _ErrEscherNotLoaded;
#define Xlsmessages_ErrEscherNotLoaded System::LoadResourceString(&Xlsmessages::_ErrEscherNotLoaded)
extern PACKAGE System::ResourceString _ErrLoadingEscher;
#define Xlsmessages_ErrLoadingEscher System::LoadResourceString(&Xlsmessages::_ErrLoadingEscher)
extern PACKAGE System::ResourceString _ErrBStroreDuplicated;
#define Xlsmessages_ErrBStroreDuplicated System::LoadResourceString(&Xlsmessages::_ErrBStroreDuplicated)
extern PACKAGE System::ResourceString _ErrDgDuplicated;
#define Xlsmessages_ErrDgDuplicated System::LoadResourceString(&Xlsmessages::_ErrDgDuplicated)
extern PACKAGE System::ResourceString _ErrDggDuplicated;
#define Xlsmessages_ErrDggDuplicated System::LoadResourceString(&Xlsmessages::_ErrDggDuplicated)
extern PACKAGE System::ResourceString _ErrsolverDuplicated;
#define Xlsmessages_ErrsolverDuplicated System::LoadResourceString(&Xlsmessages::_ErrsolverDuplicated)
extern PACKAGE System::ResourceString _ErrChangingEscher;
#define Xlsmessages_ErrChangingEscher System::LoadResourceString(&Xlsmessages::_ErrChangingEscher)
extern PACKAGE System::ResourceString _ErrInternal;
#define Xlsmessages_ErrInternal System::LoadResourceString(&Xlsmessages::_ErrInternal)
extern PACKAGE System::ResourceString _ErrCantCopyPictFmla;
#define Xlsmessages_ErrCantCopyPictFmla System::LoadResourceString(&Xlsmessages::_ErrCantCopyPictFmla)
extern PACKAGE System::ResourceString _ErrInvalidErrStr;
#define Xlsmessages_ErrInvalidErrStr System::LoadResourceString(&Xlsmessages::_ErrInvalidErrStr)
extern PACKAGE System::ResourceString _ErrInvalidCellValue;
#define Xlsmessages_ErrInvalidCellValue System::LoadResourceString(&Xlsmessages::_ErrInvalidCellValue)
extern PACKAGE System::ResourceString _ErrCantWriteToFile;
#define Xlsmessages_ErrCantWriteToFile System::LoadResourceString(&Xlsmessages::_ErrCantWriteToFile)
extern PACKAGE System::ResourceString _ErrShrFmlaNotFound;
#define Xlsmessages_ErrShrFmlaNotFound System::LoadResourceString(&Xlsmessages::_ErrShrFmlaNotFound)
extern PACKAGE System::ResourceString _ErrInvalidStrLenLength;
#define Xlsmessages_ErrInvalidStrLenLength System::LoadResourceString(&Xlsmessages::_ErrInvalidStrLenLength)
extern PACKAGE System::ResourceString _ErrInvalidStringRecord;
#define Xlsmessages_ErrInvalidStringRecord System::LoadResourceString(&Xlsmessages::_ErrInvalidStringRecord)
extern PACKAGE System::ResourceString _ErrNotImplemented;
#define Xlsmessages_ErrNotImplemented System::LoadResourceString(&Xlsmessages::_ErrNotImplemented)
extern PACKAGE System::ResourceString _BaseSheetName;
#define Xlsmessages_BaseSheetName System::LoadResourceString(&Xlsmessages::_BaseSheetName)
extern PACKAGE System::ResourceString _ErrNoDataSet;
#define Xlsmessages_ErrNoDataSet System::LoadResourceString(&Xlsmessages::_ErrNoDataSet)
extern PACKAGE System::ResourceString _ErrReportNotFound;
#define Xlsmessages_ErrReportNotFound System::LoadResourceString(&Xlsmessages::_ErrReportNotFound)
extern PACKAGE System::ResourceString _ErrTooManyPageBreaks;
#define Xlsmessages_ErrTooManyPageBreaks System::LoadResourceString(&Xlsmessages::_ErrTooManyPageBreaks)
extern PACKAGE System::ResourceString _ErrInvalidRow;
#define Xlsmessages_ErrInvalidRow System::LoadResourceString(&Xlsmessages::_ErrInvalidRow)
extern PACKAGE System::ResourceString _ErrInvalidCol;
#define Xlsmessages_ErrInvalidCol System::LoadResourceString(&Xlsmessages::_ErrInvalidCol)
extern PACKAGE System::ResourceString _ErrXlsIndexOutBounds;
#define Xlsmessages_ErrXlsIndexOutBounds System::LoadResourceString(&Xlsmessages::_ErrXlsIndexOutBounds)
extern PACKAGE System::ResourceString _ErrFileIsPasswordProtected;
#define Xlsmessages_ErrFileIsPasswordProtected System::LoadResourceString(&Xlsmessages::_ErrFileIsPasswordProtected)
extern PACKAGE System::ResourceString _ErrNotAString;
#define Xlsmessages_ErrNotAString System::LoadResourceString(&Xlsmessages::_ErrNotAString)
extern PACKAGE System::ResourceString _ErrUnexpectedEof;
#define Xlsmessages_ErrUnexpectedEof System::LoadResourceString(&Xlsmessages::_ErrUnexpectedEof)
extern PACKAGE System::ResourceString _ErrUnexpectedChar;
#define Xlsmessages_ErrUnexpectedChar System::LoadResourceString(&Xlsmessages::_ErrUnexpectedChar)
extern PACKAGE System::ResourceString _ErrUnterminatedString;
#define Xlsmessages_ErrUnterminatedString System::LoadResourceString(&Xlsmessages::_ErrUnterminatedString)
extern PACKAGE System::ResourceString _ErrMissingParen;
#define Xlsmessages_ErrMissingParen System::LoadResourceString(&Xlsmessages::_ErrMissingParen)
extern PACKAGE System::ResourceString _ErrFormulaTooLong;
#define Xlsmessages_ErrFormulaTooLong System::LoadResourceString(&Xlsmessages::_ErrFormulaTooLong)
extern PACKAGE System::ResourceString _ErrUnexpectedId;
#define Xlsmessages_ErrUnexpectedId System::LoadResourceString(&Xlsmessages::_ErrUnexpectedId)
extern PACKAGE System::ResourceString _ErrFunctionNotFound;
#define Xlsmessages_ErrFunctionNotFound System::LoadResourceString(&Xlsmessages::_ErrFunctionNotFound)
extern PACKAGE System::ResourceString _ErrInvalidNumberOfParams;
#define Xlsmessages_ErrInvalidNumberOfParams System::LoadResourceString(&Xlsmessages::_ErrInvalidNumberOfParams)
extern PACKAGE System::ResourceString _ErrFormulaInvalid;
#define Xlsmessages_ErrFormulaInvalid System::LoadResourceString(&Xlsmessages::_ErrFormulaInvalid)
extern PACKAGE System::ResourceString _ErrFormulaStart;
#define Xlsmessages_ErrFormulaStart System::LoadResourceString(&Xlsmessages::_ErrFormulaStart)
extern PACKAGE System::ResourceString _ErrHiddenSheetSelected;
#define Xlsmessages_ErrHiddenSheetSelected System::LoadResourceString(&Xlsmessages::_ErrHiddenSheetSelected)
extern PACKAGE System::ResourceString _ErrNoSheetVisible;
#define Xlsmessages_ErrNoSheetVisible System::LoadResourceString(&Xlsmessages::_ErrNoSheetVisible)
extern PACKAGE System::ResourceString _ErrCantDeleteSheetWithMacros;
#define Xlsmessages_ErrCantDeleteSheetWithMacros System::LoadResourceString(&Xlsmessages::_ErrCantDeleteSheetWithMacros)
extern PACKAGE System::ResourceString _ErrInvalidSheet;
#define Xlsmessages_ErrInvalidSheet System::LoadResourceString(&Xlsmessages::_ErrInvalidSheet)
extern PACKAGE System::ResourceString _WorkbookStrS;
#define Xlsmessages_WorkbookStrS System::LoadResourceString(&Xlsmessages::_WorkbookStrS)
extern PACKAGE System::ResourceString _ErrInvalidStream;
#define Xlsmessages_ErrInvalidStream System::LoadResourceString(&Xlsmessages::_ErrInvalidStream)
extern PACKAGE System::ResourceString _ErrEofReached;
#define Xlsmessages_ErrEofReached System::LoadResourceString(&Xlsmessages::_ErrEofReached)
extern PACKAGE System::ResourceString _ErrInvalidPropertySector;
#define Xlsmessages_ErrInvalidPropertySector System::LoadResourceString(&Xlsmessages::_ErrInvalidPropertySector)
extern PACKAGE System::ResourceString _xlerr_Null;
#define Xlsmessages_xlerr_Null System::LoadResourceString(&Xlsmessages::_xlerr_Null)
extern PACKAGE System::ResourceString _xlerr_Div0;
#define Xlsmessages_xlerr_Div0 System::LoadResourceString(&Xlsmessages::_xlerr_Div0)
extern PACKAGE System::ResourceString _xlerr_Value;
#define Xlsmessages_xlerr_Value System::LoadResourceString(&Xlsmessages::_xlerr_Value)
extern PACKAGE System::ResourceString _xlerr_Ref;
#define Xlsmessages_xlerr_Ref System::LoadResourceString(&Xlsmessages::_xlerr_Ref)
extern PACKAGE System::ResourceString _xlerr_Name;
#define Xlsmessages_xlerr_Name System::LoadResourceString(&Xlsmessages::_xlerr_Name)
extern PACKAGE System::ResourceString _xlerr_Num;
#define Xlsmessages_xlerr_Num System::LoadResourceString(&Xlsmessages::_xlerr_Num)
extern PACKAGE System::ResourceString _xlerr_NA;
#define Xlsmessages_xlerr_NA System::LoadResourceString(&Xlsmessages::_xlerr_NA)
static const System::ShortInt xlerrcode_Null = 0x0;
static const System::ShortInt xlerrcode_Div0 = 0x7;
static const System::ShortInt xlerrcode_Value = 0xf;
static const System::ShortInt xlerrcode_Ref = 0x17;
static const System::ShortInt xlerrcode_Name = 0x1d;
static const System::ShortInt xlerrcode_Num = 0x24;
static const System::ShortInt xlerrcode_NA = 0x2a;
static const System::Word MaxRecordDataSize = 0x201f;
static const System::Word MaxExternSheetDataSize = 0x201c;
static const System::Word MaxHPageBreaks = 0x401;
static const System::Word MaxVPageBreaks = 0x401;
static const System::Byte Max_Columns = 0xff;
static const System::Word Max_Rows = 0xffff;
static const System::Word MaxSheets = 0xfde8;
static const System::Word xlr_BofVersion = 0x600;
static const System::ShortInt xlb_Globals = 0x5;
static const System::ShortInt xlb_Worksheet = 0x10;
static const System::ShortInt xlb_Chart = 0x20;
static const System::ShortInt xlr_INTEGER = 0x2;
static const System::ShortInt xlr_FORMULA = 0x6;
static const System::ShortInt xlr_EOF = 0xa;
static const System::ShortInt xlr_CALCCOUNT = 0xc;
static const System::ShortInt xlr_CALCMODE = 0xd;
static const System::ShortInt xlr_PRECISION = 0xe;
static const System::ShortInt xlr_REFMODE = 0xf;
static const System::ShortInt xlr_DELTA = 0x10;
static const System::ShortInt xlr_ITERATION = 0x11;
static const System::ShortInt xlr_PROTECT = 0x12;
static const System::ShortInt xlr_PASSWORD = 0x13;
static const System::ShortInt xlr_HEADER = 0x14;
static const System::ShortInt xlr_FOOTER = 0x15;
static const System::ShortInt xlr_EXTERNCOUNT = 0x16;
static const System::ShortInt xlr_EXTERNSHEET = 0x17;
static const System::ShortInt xlr_NAME = 0x18;
static const System::ShortInt xlr_WINDOWPROTECT = 0x19;
static const System::ShortInt xlr_VERTICALPAGEBREAKS = 0x1a;
static const System::ShortInt xlr_HORIZONTALPAGEBREAKS = 0x1b;
static const System::ShortInt xlr_NOTE = 0x1c;
static const System::ShortInt xlr_SELECTION = 0x1d;
static const System::ShortInt xlr_FORMATCOUNT = 0x1f;
static const System::ShortInt xlr_COLUMNDEFAULT = 0x20;
static const System::ShortInt xlr_1904 = 0x22;
static const System::ShortInt xlr_COLWIDTH = 0x24;
static const System::ShortInt xlr_LEFTMARGIN = 0x26;
static const System::ShortInt xlr_RIGHTMARGIN = 0x27;
static const System::ShortInt xlr_TOPMARGIN = 0x28;
static const System::ShortInt xlr_BOTTOMMARGIN = 0x29;
static const System::ShortInt xlr_PRINTHEADERS = 0x2a;
static const System::ShortInt xlr_PRINTGRIDLINES = 0x2b;
static const System::ShortInt xlr_FILEPASS = 0x2f;
static const System::ShortInt xlr_PRINTSIZE = 0x33;
static const System::ShortInt xlr_CONTINUE = 0x3c;
static const System::ShortInt xlr_WINDOW1 = 0x3d;
static const System::ShortInt xlr_BACKUP = 0x40;
static const System::ShortInt xlr_PANE = 0x41;
static const System::ShortInt xlr_CODEPAGE = 0x42;
static const System::ShortInt xlr_IXFE = 0x44;
static const System::ShortInt xlr_PLS = 0x4d;
static const System::ShortInt xlr_DCON = 0x50;
static const System::ShortInt xlr_DCONREF = 0x51;
static const System::ShortInt xlr_DCONNAME = 0x53;
static const System::ShortInt xlr_DEFCOLWIDTH = 0x55;
static const System::ShortInt xlr_BUILTINFMTCNT = 0x56;
static const System::ShortInt xlr_XCT = 0x59;
static const System::ShortInt xlr_CRN = 0x5a;
static const System::ShortInt xlr_FILESHARING = 0x5b;
static const System::ShortInt xlr_WRITEACCESS = 0x5c;
static const System::ShortInt xlr_OBJ = 0x5d;
static const System::ShortInt xlr_UNCALCED = 0x5e;
static const System::ShortInt xlr_SAFERECALC = 0x5f;
static const System::ShortInt xlr_TEMPLATE = 0x60;
static const System::ShortInt xlr_OBJPROTECT = 0x63;
static const System::ShortInt xlr_COLINFO = 0x7d;
static const System::ShortInt xlr_IMDATA = 0x7f;
static const System::Byte xlr_GUTS = 0x80;
static const System::Byte xlr_WSBOOL = 0x81;
static const System::Byte xlr_GRIDSET = 0x82;
static const System::Byte xlr_HCENTER = 0x83;
static const System::Byte xlr_VCENTER = 0x84;
static const System::Byte xlr_BOUNDSHEET = 0x85;
static const System::Byte xlr_WRITEPROT = 0x86;
static const System::Byte xlr_ADDIN = 0x87;
static const System::Byte xlr_EDG = 0x88;
static const System::Byte xlr_PUB = 0x89;
static const System::Byte xlr_COUNTRY = 0x8c;
static const System::Byte xlr_HIDEOBJ = 0x8d;
static const System::Byte xlr_BUNDLESOFFSET = 0x8e;
static const System::Byte xlr_BUNDLEHEADER = 0x8f;
static const System::Byte xlr_SORT = 0x90;
static const System::Byte xlr_SUB = 0x91;
static const System::Byte xlr_PALETTE = 0x92;
static const System::Byte xlr_LHRECORD = 0x94;
static const System::Byte xlr_LHNGRAPH = 0x95;
static const System::Byte xlr_SOUND = 0x96;
static const System::Byte xlr_LPR = 0x98;
static const System::Byte xlr_STANDARDWIDTH = 0x99;
static const System::Byte xlr_FNGROUPNAME = 0x9a;
static const System::Byte xlr_FILTERMODE = 0x9b;
static const System::Byte xlr_FNGROUPCOUNT = 0x9c;
static const System::Byte xlr_AUTOFILTERINFO = 0x9d;
static const System::Byte xlr_AUTOFILTER = 0x9e;
static const System::Byte xlr_SCL = 0xa0;
static const System::Byte xlr_SETUP = 0xa1;
static const System::Byte xlr_COORDLIST = 0xa9;
static const System::Byte xlr_GCW = 0xab;
static const System::Byte xlr_SCENMAN = 0xae;
static const System::Byte xlr_SCENARIO = 0xaf;
static const System::Byte xlr_SXVIEW = 0xb0;
static const System::Byte xlr_SXVD = 0xb1;
static const System::Byte xlr_SXVI = 0xb2;
static const System::Byte xlr_SXIVD = 0xb4;
static const System::Byte xlr_SXLI = 0xb5;
static const System::Byte xlr_SXPI = 0xb6;
static const System::Byte xlr_DOCROUTE = 0xb8;
static const System::Byte xlr_RECIPNAME = 0xb9;
static const System::Byte xlr_MULRK = 0xbd;
static const System::Byte xlr_MULBLANK = 0xbe;
static const System::Byte xlr_MMS = 0xc1;
static const System::Byte xlr_ADDMENU = 0xc2;
static const System::Byte xlr_DELMENU = 0xc3;
static const System::Byte xlr_SXDI = 0xc5;
static const System::Byte xlr_SXDB = 0xc6;
static const System::Byte xlr_SXFIELD = 0xc7;
static const System::Byte xlr_SXINDEXLIST = 0xc8;
static const System::Byte xlr_SXDOUBLE = 0xc9;
static const System::Byte xlr_SXSTRING = 0xcd;
static const System::Byte xlr_SXDATETIME = 0xce;
static const System::Byte xlr_SXTBL = 0xd0;
static const System::Byte xlr_SXTBRGITEM = 0xd1;
static const System::Byte xlr_SXTBPG = 0xd2;
static const System::Byte xlr_OBPROJ = 0xd3;
static const System::Byte xlr_SXIDSTM = 0xd5;
static const System::Byte xlr_RSTRING = 0xd6;
static const System::Byte xlr_DBCELL = 0xd7;
static const System::Byte xlr_BOOKBOOL = 0xda;
static const System::Byte xlr_SXEXTPARAMQRY = 0xdc;
static const System::Byte xlr_SCENPROTECT = 0xdd;
static const System::Byte xlr_OLESIZE = 0xde;
static const System::Byte xlr_UDDESC = 0xdf;
static const System::Byte xlr_INTERFACEHDR = 0xe1;
static const System::Byte xlr_INTERFACEEND = 0xe2;
static const System::Byte xlr_SXVS = 0xe3;
static const System::Byte xlr_CELLMERGING = 0xe5;
static const System::Byte xlr_BITMAP = 0xe9;
static const System::Byte xlr_MSODRAWINGGROUP = 0xeb;
static const System::Byte xlr_MSODRAWING = 0xec;
static const System::Byte xlr_MSODRAWINGSELECTION = 0xed;
static const System::Byte xlr_PHONETIC = 0xef;
static const System::Byte xlr_SXRULE = 0xf0;
static const System::Byte xlr_SXEX = 0xf1;
static const System::Byte xlr_SXFILT = 0xf2;
static const System::Byte xlr_SXNAME = 0xf6;
static const System::Byte xlr_SXSELECT = 0xf7;
static const System::Byte xlr_SXPAIR = 0xf8;
static const System::Byte xlr_SXFMLA = 0xf9;
static const System::Byte xlr_SXFORMAT = 0xfb;
static const System::Byte xlr_SST = 0xfc;
static const System::Byte xlr_LABELSST = 0xfd;
static const System::Byte xlr_EXTSST = 0xff;
static const System::Word xlr_SXVDEX = 0x100;
static const System::Word xlr_SXFORMULA = 0x103;
static const System::Word xlr_SXDBEX = 0x122;
static const System::Word xlr_CHTRINSERT = 0x137;
static const System::Word xlr_CHTRINFO = 0x138;
static const System::Word xlr_CHTRCELLCONTENT = 0x13b;
static const System::Word xlr_TABID = 0x13d;
static const System::Word xlr_CHTRMOVERANGE = 0x140;
static const System::Word xlr_CHTRINSERTTAB = 0x14d;
static const System::Word xlr_USESELFS = 0x160;
static const System::Word xlr_XL5MODIFY = 0x162;
static const System::Word xlr_CHTRHEADER = 0x196;
static const System::Word xlr_USERBVIEW = 0x1a9;
static const System::Word xlr_USERSVIEWBEGIN = 0x1aa;
static const System::Word xlr_USERSVIEWEND = 0x1ab;
static const System::Word xlr_QSI = 0x1ad;
static const System::Word xlr_SUPBOOK = 0x1ae;
static const System::Word xlr_PROT4REV = 0x1af;
static const System::Word xlr_DSF = 0x161;
static const System::Word xlr_CONDFMT = 0x1b0;
static const System::Word xlr_CF = 0x1b1;
static const System::Word xlr_DVAL = 0x1b2;
static const System::Word xlr_DCONBIN = 0x1b5;
static const System::Word xlr_TXO = 0x1b6;
static const System::Word xlr_REFRESHALL = 0x1b7;
static const System::Word xlr_HLINK = 0x1b8;
static const System::Word xlr_CODENAME = 0x1ba;
static const System::Word xlr_SXFDBTYPE = 0x1bb;
static const System::Word xlr_PROT4REVPASS = 0x1bc;
static const System::Word xlr_DV = 0x1be;
static const System::Word xlr_XL9FILE = 0x1c0;
static const System::Word xlr_RECALCID = 0x1c1;
static const System::Word xlr_DIMENSIONS = 0x200;
static const System::Word xlr_BLANK = 0x201;
static const System::Word xlr_NUMBER = 0x203;
static const System::Word xlr_LABEL = 0x204;
static const System::Word xlr_BOOLERR = 0x205;
static const System::Word xlr_STRING = 0x207;
static const System::Word xlr_ROW = 0x208;
static const System::Word xlr_INDEX = 0x20b;
static const System::Word xlr_ARRAY = 0x221;
static const System::ShortInt xlr_EXTERNNAME = 0x23;
static const System::Word xlr_EXTERNNAME2 = 0x223;
static const System::Word xlr_DEFAULTROWHEIGHT = 0x225;
static const System::ShortInt xlr_FONT = 0x31;
static const System::Word xlr_TABLE = 0x236;
static const System::Word xlr_WINDOW2 = 0x23e;
static const System::Word xlr_RK = 0x27e;
static const System::Word xlr_STYLE = 0x293;
static const System::Word xlr_FORMAT = 0x41e;
static const System::Byte xlr_XF = 0xe0;
static const System::Word xlr_SHRFMLA = 0x4bc;
static const System::Word xlr_SCREENTIP = 0x800;
static const System::Word xlr_WEBQRYSETTINGS = 0x803;
static const System::Word xlr_WEBQRYTABLES = 0x804;
static const System::Word xlr_BOF = 0x809;
static const System::Word xlr_UNITS = 0x1001;
static const System::Word xlr_ChartChart = 0x1002;
static const System::Word xlr_ChartSeries = 0x1003;
static const System::Word xlr_ChartDataformat = 0x1006;
static const System::Word xlr_ChartLineformat = 0x1007;
static const System::Word xlr_ChartMarkerformat = 0x1009;
static const System::Word xlr_ChartAreaformat = 0x100a;
static const System::Word xlr_ChartPieformat = 0x100b;
static const System::Word xlr_ChartAttachedlabel = 0x100c;
static const System::Word xlr_ChartSeriestext = 0x100d;
static const System::Word xlr_ChartChartformat = 0x1014;
static const System::Word xlr_ChartLegend = 0x1015;
static const System::Word xlr_ChartSerieslist = 0x1016;
static const System::Word xlr_ChartBar = 0x1017;
static const System::Word xlr_ChartLine = 0x1018;
static const System::Word xlr_ChartPie = 0x1019;
static const System::Word xlr_ChartArea = 0x101a;
static const System::Word xlr_ChartScatter = 0x101b;
static const System::Word xlr_ChartChartline = 0x101c;
static const System::Word xlr_ChartAxis = 0x101d;
static const System::Word xlr_ChartTick = 0x101e;
static const System::Word xlr_ChartValuerange = 0x101f;
static const System::Word xlr_ChartCatserrange = 0x1020;
static const System::Word xlr_ChartAxislineformat = 0x1021;
static const System::Word xlr_ChartFormatlink = 0x1022;
static const System::Word xlr_ChartDefaulttext = 0x1024;
static const System::Word xlr_ChartText = 0x1025;
static const System::Word xlr_ChartFontx = 0x1026;
static const System::Word xlr_ChartObjectLink = 0x1027;
static const System::Word xlr_ChartFrame = 0x1032;
static const System::Word xlr_BEGIN = 0x1033;
static const System::Word xlr_END = 0x1034;
static const System::Word xlr_ChartPlotarea = 0x1035;
static const System::Word xlr_Chart3D = 0x103a;
static const System::Word xlr_ChartPicf = 0x103c;
static const System::Word xlr_ChartDropbar = 0x103d;
static const System::Word xlr_ChartRadar = 0x103e;
static const System::Word xlr_ChartSurface = 0x103f;
static const System::Word xlr_ChartRadararea = 0x1040;
static const System::Word xlr_ChartAxisparent = 0x1041;
static const System::Word xlr_ChartLegendxn = 0x1043;
static const System::Word xlr_ChartShtprops = 0x1044;
static const System::Word xlr_ChartSertocrt = 0x1045;
static const System::Word xlr_ChartAxesused = 0x1046;
static const System::Word xlr_ChartSbaseref = 0x1048;
static const System::Word xlr_ChartSerparent = 0x104a;
static const System::Word xlr_ChartSerauxtrend = 0x104b;
static const System::Word xlr_ChartIfmt = 0x104e;
static const System::Word xlr_ChartPos = 0x104f;
static const System::Word xlr_ChartAlruns = 0x1050;
static const System::Word xlr_ChartAI = 0x1051;
static const System::Word xlr_ChartSerauxerrbar = 0x105b;
static const System::Word xlr_ChartClrClient = 0x105c;
static const System::Word xlr_ChartSerfmt = 0x105d;
static const System::Word xlr_Chart3DDataFormat = 0x105f;
static const System::Word xlr_ChartFbi = 0x1060;
static const System::Word xlr_ChartBoppop = 0x1061;
static const System::Word xlr_ChartAxcext = 0x1062;
static const System::Word xlr_ChartDat = 0x1063;
static const System::Word xlr_ChartPlotgrowth = 0x1064;
static const System::Word xlr_ChartSiindex = 0x1065;
static const System::Word xlr_ChartGelframe = 0x1066;
static const System::Word xlr_ChartBoppcustom = 0x1067;
static const System::ShortInt tk_Arrayformula = 0x1;
static const System::ShortInt tk_Table = 0x2;
#define tk_BinaryOps (System::Set<System::Byte, 0, 255> () << 0x3 << 0x4 << 0x5 << 0x6 << 0x7 << 0x8 << 0x9 << 0xa << 0xb << 0xc << 0xd << 0xe << 0xf << 0x10 << 0x11 )
#define tk_UnaryOps (System::Set<System::Byte, 0, 255> () << 0x12 << 0x13 << 0x14 << 0x15 )
static const System::ShortInt tk_MissArg = 0x16;
static const System::ShortInt tk_Str = 0x17;
static const System::ShortInt tk_Attr = 0x19;
static const System::ShortInt tk_Err = 0x1c;
static const System::ShortInt tk_Bool = 0x1d;
static const System::ShortInt tk_Int = 0x1e;
static const System::ShortInt tk_Num = 0x1f;
static const System::ShortInt tk_MemFunc = 0x29;
#define tk_Func (System::Set<System::Byte, 0, 255> () << 0x21 << 0x41 << 0x61 )
#define tk_FuncVar (System::Set<System::Byte, 0, 255> () << 0x22 << 0x42 << 0x62 )
#define tk_Array (System::Set<System::Byte, 0, 255> () << 0x20 << 0x40 << 0x60 )
#define tk_Name (System::Set<System::Byte, 0, 255> () << 0x23 << 0x43 << 0x63 )
#define tk_Ref (System::Set<System::Byte, 0, 255> () << 0x24 << 0x44 << 0x64 )
#define tk_Area (System::Set<System::Byte, 0, 255> () << 0x25 << 0x45 << 0x65 )
#define tk_RefErr (System::Set<System::Byte, 0, 255> () << 0x2a << 0x4a << 0x6a )
#define tk_AreaErr (System::Set<System::Byte, 0, 255> () << 0x2b << 0x4b << 0x6b )
#define tk_RefN (System::Set<System::Byte, 0, 255> () << 0x2c << 0x4c << 0x6c )
#define tk_AreaN (System::Set<System::Byte, 0, 255> () << 0x2d << 0x4d << 0x6d )
#define tk_NameX (System::Set<System::Byte, 0, 255> () << 0x39 << 0x59 << 0x79 )
#define tk_Ref3D (System::Set<System::Byte, 0, 255> () << 0x3a << 0x5a << 0x7a )
#define tk_Area3D (System::Set<System::Byte, 0, 255> () << 0x3b << 0x5b << 0x7b )
#define tk_Ref3DErr (System::Set<System::Byte, 0, 255> () << 0x3c << 0x5c << 0x7c )
#define tk_Area3DErr (System::Set<System::Byte, 0, 255> () << 0x3d << 0x5d << 0x7d )
static const System::ShortInt tk_RefToRefErr = 0x6;
static const System::ShortInt tk_AreaToAreaErr = 0x6;
static const System::ShortInt tk_Ref3DToRef3DErr = 0x2;
static const System::ShortInt tk_Area3DToArea3DErr = 0x2;
#define tk_Operand (System::Set<int, -2147483648, 2147483647> () << 0x20 << 0x23 << 0x24 << 0x25 << 0x2a << 0x2b << 0x2c << 0x2d << 0x39 << 0x3a << 0x3b << 0x3c << 0x3d << 0x40 << 0x43 << 0x44 << 0x45 << 0x4a << 0x4b << 0x4c << 0x4d << 0x59 << 0x5a << 0x5b << 0x5c << 0x5d << 0x60 << 0x63 << 0x64 << 0x65 << 0x6a << 0x6b << 0x6c << 0x6d << 0x79 << 0x7a << 0x7b << 0x7c << 0x7d )
static const System::ShortInt ftEnd = 0x0;
static const System::ShortInt ftMacro = 0x4;
static const System::ShortInt ftButton = 0x5;
static const System::ShortInt ftGmo = 0x6;
static const System::ShortInt ftCf = 0x7;
static const System::ShortInt ftPioGrbit = 0x8;
static const System::ShortInt ftPictFmla = 0x9;
static const System::ShortInt ftCbls = 0xa;
static const System::ShortInt ftRbo = 0xb;
static const System::ShortInt ftSbs = 0xc;
static const System::ShortInt ftNts = 0xd;
static const System::ShortInt ftSbsFmla = 0xe;
static const System::ShortInt ftGboData = 0xf;
static const System::ShortInt ftEdoData = 0x10;
static const System::ShortInt ftRboData = 0x11;
static const System::ShortInt ftCblsData = 0x12;
static const System::ShortInt ftLbsData = 0x13;
static const System::ShortInt ftCblsFmla = 0x14;
static const System::ShortInt ftCmo = 0x15;
static const System::ShortInt xlcmo_Group = 0x0;
static const System::ShortInt xlcmo_Line = 0x1;
static const System::ShortInt xlcmo_Rectangle = 0x2;
static const System::ShortInt xlcmo_Oval = 0x3;
static const System::ShortInt xlcmo_Arc = 0x4;
static const System::ShortInt xlcmo_Chart = 0x5;
static const System::ShortInt xlcmo_TextBox = 0x6;
static const System::ShortInt xlcmo_Button = 0x7;
static const System::ShortInt xlcmo_Picture = 0x8;
static const System::ShortInt xlcmo_Polygon = 0x9;
static const System::ShortInt xlcmo_CheckBox = 0xb;
static const System::ShortInt xlcmo_Option = 0xc;
static const System::ShortInt xlcmo_Edit = 0xd;
static const System::ShortInt xlcmo_Label = 0xe;
static const System::ShortInt xlcmo_Dialog = 0xf;
static const System::ShortInt xlcmo_Spinner = 0x10;
static const System::ShortInt xlcmo_Scroll = 0x11;
static const System::ShortInt xlcmo_List = 0x12;
static const System::ShortInt xlcmo_Group1 = 0x13;
static const System::ShortInt xlcmo_Combo = 0x14;
static const System::ShortInt xlcmo_Comment = 0x19;
static const System::ShortInt xlcmo_MSDrawingx = 0x1e;
static const System::Word MsofbtDggContainer = 0xf000;
static const System::Word MsofbtDgg = 0xf006;
static const System::Word MsofbtCLSID = 0xf016;
static const System::Word MsofbtOPT = 0xf00b;
static const System::Word MsofbtColorMRU = 0xf11a;
static const System::Word MsofbtSplitMenuColors = 0xf11e;
static const System::Word MsofbtBstoreContainer = 0xf001;
static const System::Word MsofbtBSE = 0xf007;
static const System::Word MsofbtDgContainer = 0xf002;
static const System::Word MsofbtDg = 0xf008;
static const System::Word MsofbtRegroupItem = 0xf118;
static const System::Word MsofbtColorScheme = 0xf120;
static const System::Word MsofbtSpgrContainer = 0xf003;
static const System::Word MsofbtSpContainer = 0xf004;
static const System::Word MsofbtSpgr = 0xf009;
static const System::Word MsofbtSp = 0xf00a;
static const System::Word MsofbtTextbox = 0xf00c;
static const System::Word MsofbtClientTextbox = 0xf00d;
static const System::Word MsofbtAnchor = 0xf00e;
static const System::Word MsofbtChildAnchor = 0xf00f;
static const System::Word MsofbtClientAnchor = 0xf010;
static const System::Word MsofbtClientData = 0xf011;
static const System::Word MsofbtOleObject = 0xf11f;
static const System::Word MsofbtDeletedPspl = 0xf11d;
static const System::Word MsofbtSolverContainer = 0xf005;
static const System::Word MsofbtConnectorRule = 0xf012;
static const System::Word MsofbtAlignRule = 0xf013;
static const System::Word MsofbtArcRule = 0xf014;
static const System::Word MsofbtClientRule = 0xf015;
static const System::Word MsofbtCalloutRule = 0xf017;
static const System::Word MsofbtSelection = 0xf119;
static const System::ShortInt msobiUNKNOWN = 0x0;
static const System::Word msobiWMF = 0x216;
static const System::Word msobiEMF = 0x3d4;
static const System::Word msobiPICT = 0x542;
static const System::Word msobiPNG = 0x6e0;
static const System::Word msobiJFIF = 0x46a;
static const System::Word msobiJPEG = 0x46a;
static const System::Word msobiDIB = 0x7a8;
static const System::Word msobiClient = 0x800;
static const System::ShortInt msoblipERROR = 0x0;
static const System::ShortInt msoblipUNKNOWN = 0x1;
static const System::ShortInt msoblipEMF = 0x2;
static const System::ShortInt msoblipWMF = 0x3;
static const System::ShortInt msoblipPICT = 0x4;
static const System::ShortInt msoblipJPEG = 0x5;
static const System::ShortInt msoblipPNG = 0x6;
static const System::ShortInt msoblipDIB = 0x7;
extern PACKAGE System::StaticArray<System::Byte, 6> XlsImgConv;
extern PACKAGE System::StaticArray<System::Word, 6> XlsBlipHeaderConv;
extern PACKAGE System::StaticArray<System::Word, 6> XlsBlipSignConv;
extern PACKAGE void __fastcall IncWord(const PArrayOfByte Pdata, const int tPos, const int Offset, const int Max);
extern PACKAGE void __fastcall IncByte(const PArrayOfByte Pdata, const int tPos, const int Offset, const int Max);
extern PACKAGE void __fastcall IncMax(System::Word &X, int N, int Max);
extern PACKAGE void __fastcall IncLongWord(const PArrayOfByte Pdata, const int tPos, const __int64 Offset);
extern PACKAGE void __fastcall IncMaxMin(System::Word &X, int N, int Max, int Min);
extern PACKAGE System::Word __fastcall GetWord(const PArrayOfByte Pdata, const int tPos);
extern PACKAGE unsigned __fastcall GetLongWord(const PArrayOfByte Pdata, const int tPos);
extern PACKAGE void __fastcall SetLongWord(const PArrayOfByte Pdata, const int tPos, const unsigned number);
extern PACKAGE void __fastcall SetWord(const PArrayOfByte Pdata, const int tPos, const System::Word number);
extern PACKAGE __int64 __fastcall GetStrLen(const bool Length16Bit, const PArrayOfByte Pdata, const int tPos, const bool UseExtStrLen, const unsigned ExtStrLen);
extern PACKAGE void __fastcall GetSimpleString(const bool Length16Bit, const PArrayOfByte Pdata, const int tPos, const bool UseExtStrLen, const unsigned ExtStrLen, System::UnicodeString &St, int &StSize);
extern PACKAGE bool __fastcall IsWide(const System::UnicodeString W);
extern PACKAGE System::AnsiString __fastcall WideStringToStringNoCodePage(const System::UnicodeString W);
extern PACKAGE void __fastcall CompressBestUnicode(const System::UnicodeString w, const PArrayOfByte PData, const int PDataPos);
extern PACKAGE System::UnicodeString __fastcall StringToWideStringNoCodePage(const System::AnsiString s);

}	/* namespace Xlsmessages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Xlsmessages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// XlsmessagesHPP
