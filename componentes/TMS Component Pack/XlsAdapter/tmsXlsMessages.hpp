// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsxlsmessages.pas' rev: 21.00

#ifndef TmsxlsmessagesHPP
#define TmsxlsmessagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsxlsmessages
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<System::Byte, 1073741824> ArrayOfByte;

typedef ArrayOfByte *PArrayOfByte;

#pragma pack(push,1)
struct TRecordHeader
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

struct TSheetInfo
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
#define Tmsxlsmessages_ErrFileIsNotXLS System::LoadResourceString(&Tmsxlsmessages::_ErrFileIsNotXLS)
extern PACKAGE System::ResourceString _ErrCantReadFile;
#define Tmsxlsmessages_ErrCantReadFile System::LoadResourceString(&Tmsxlsmessages::_ErrCantReadFile)
extern PACKAGE System::ResourceString _ErrExcelInvalid;
#define Tmsxlsmessages_ErrExcelInvalid System::LoadResourceString(&Tmsxlsmessages::_ErrExcelInvalid)
extern PACKAGE System::ResourceString _ErrCantWriteOutput;
#define Tmsxlsmessages_ErrCantWriteOutput System::LoadResourceString(&Tmsxlsmessages::_ErrCantWriteOutput)
extern PACKAGE System::ResourceString _ErrCantWrite;
#define Tmsxlsmessages_ErrCantWrite System::LoadResourceString(&Tmsxlsmessages::_ErrCantWrite)
extern PACKAGE System::ResourceString _ErrFileNotFound;
#define Tmsxlsmessages_ErrFileNotFound System::LoadResourceString(&Tmsxlsmessages::_ErrFileNotFound)
extern PACKAGE System::ResourceString _ErrStreamNotFound;
#define Tmsxlsmessages_ErrStreamNotFound System::LoadResourceString(&Tmsxlsmessages::_ErrStreamNotFound)
extern PACKAGE System::ResourceString _ErrExtRefsNotSupported;
#define Tmsxlsmessages_ErrExtRefsNotSupported System::LoadResourceString(&Tmsxlsmessages::_ErrExtRefsNotSupported)
extern PACKAGE System::ResourceString _ErrWrongExcelRecord;
#define Tmsxlsmessages_ErrWrongExcelRecord System::LoadResourceString(&Tmsxlsmessages::_ErrWrongExcelRecord)
extern PACKAGE System::ResourceString _ErrBadToken;
#define Tmsxlsmessages_ErrBadToken System::LoadResourceString(&Tmsxlsmessages::_ErrBadToken)
extern PACKAGE System::ResourceString _ErrBadFormula;
#define Tmsxlsmessages_ErrBadFormula System::LoadResourceString(&Tmsxlsmessages::_ErrBadFormula)
extern PACKAGE System::ResourceString _ErrBadName;
#define Tmsxlsmessages_ErrBadName System::LoadResourceString(&Tmsxlsmessages::_ErrBadName)
extern PACKAGE System::ResourceString _ErrBadCF;
#define Tmsxlsmessages_ErrBadCF System::LoadResourceString(&Tmsxlsmessages::_ErrBadCF)
extern PACKAGE System::ResourceString _ErrBadChartFormula;
#define Tmsxlsmessages_ErrBadChartFormula System::LoadResourceString(&Tmsxlsmessages::_ErrBadChartFormula)
extern PACKAGE System::ResourceString _Err3DRef;
#define Tmsxlsmessages_Err3DRef System::LoadResourceString(&Tmsxlsmessages::_Err3DRef)
extern PACKAGE System::ResourceString _ErrReadingRecord;
#define Tmsxlsmessages_ErrReadingRecord System::LoadResourceString(&Tmsxlsmessages::_ErrReadingRecord)
extern PACKAGE System::ResourceString _ErrInvalidVersion;
#define Tmsxlsmessages_ErrInvalidVersion System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidVersion)
extern PACKAGE System::ResourceString _ErrTooManyEntries;
#define Tmsxlsmessages_ErrTooManyEntries System::LoadResourceString(&Tmsxlsmessages::_ErrTooManyEntries)
extern PACKAGE System::ResourceString _ErrRecordNotSupported;
#define Tmsxlsmessages_ErrRecordNotSupported System::LoadResourceString(&Tmsxlsmessages::_ErrRecordNotSupported)
extern PACKAGE System::ResourceString _ErrSectionNotLoaded;
#define Tmsxlsmessages_ErrSectionNotLoaded System::LoadResourceString(&Tmsxlsmessages::_ErrSectionNotLoaded)
extern PACKAGE System::ResourceString _ErrInvalidContinue;
#define Tmsxlsmessages_ErrInvalidContinue System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidContinue)
extern PACKAGE System::ResourceString _ErrStringTooLarge;
#define Tmsxlsmessages_ErrStringTooLarge System::LoadResourceString(&Tmsxlsmessages::_ErrStringTooLarge)
extern PACKAGE System::ResourceString _ErrInvalidDrawing;
#define Tmsxlsmessages_ErrInvalidDrawing System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidDrawing)
extern PACKAGE System::ResourceString _ErrInvalidCF;
#define Tmsxlsmessages_ErrInvalidCF System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidCF)
extern PACKAGE System::ResourceString _ErrDuplicatedSheetName;
#define Tmsxlsmessages_ErrDuplicatedSheetName System::LoadResourceString(&Tmsxlsmessages::_ErrDuplicatedSheetName)
extern PACKAGE System::ResourceString _ErrDupRow;
#define Tmsxlsmessages_ErrDupRow System::LoadResourceString(&Tmsxlsmessages::_ErrDupRow)
extern PACKAGE System::ResourceString _ErrRowMissing;
#define Tmsxlsmessages_ErrRowMissing System::LoadResourceString(&Tmsxlsmessages::_ErrRowMissing)
extern PACKAGE System::ResourceString _ErrBadCopyRows;
#define Tmsxlsmessages_ErrBadCopyRows System::LoadResourceString(&Tmsxlsmessages::_ErrBadCopyRows)
extern PACKAGE System::ResourceString _ErrInvalidSheetNo;
#define Tmsxlsmessages_ErrInvalidSheetNo System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidSheetNo)
extern PACKAGE System::ResourceString _ErrBadRowCount;
#define Tmsxlsmessages_ErrBadRowCount System::LoadResourceString(&Tmsxlsmessages::_ErrBadRowCount)
extern PACKAGE System::ResourceString _ErrEscherNotLoaded;
#define Tmsxlsmessages_ErrEscherNotLoaded System::LoadResourceString(&Tmsxlsmessages::_ErrEscherNotLoaded)
extern PACKAGE System::ResourceString _ErrLoadingEscher;
#define Tmsxlsmessages_ErrLoadingEscher System::LoadResourceString(&Tmsxlsmessages::_ErrLoadingEscher)
extern PACKAGE System::ResourceString _ErrBStroreDuplicated;
#define Tmsxlsmessages_ErrBStroreDuplicated System::LoadResourceString(&Tmsxlsmessages::_ErrBStroreDuplicated)
extern PACKAGE System::ResourceString _ErrDgDuplicated;
#define Tmsxlsmessages_ErrDgDuplicated System::LoadResourceString(&Tmsxlsmessages::_ErrDgDuplicated)
extern PACKAGE System::ResourceString _ErrDggDuplicated;
#define Tmsxlsmessages_ErrDggDuplicated System::LoadResourceString(&Tmsxlsmessages::_ErrDggDuplicated)
extern PACKAGE System::ResourceString _ErrsolverDuplicated;
#define Tmsxlsmessages_ErrsolverDuplicated System::LoadResourceString(&Tmsxlsmessages::_ErrsolverDuplicated)
extern PACKAGE System::ResourceString _ErrChangingEscher;
#define Tmsxlsmessages_ErrChangingEscher System::LoadResourceString(&Tmsxlsmessages::_ErrChangingEscher)
extern PACKAGE System::ResourceString _ErrInternal;
#define Tmsxlsmessages_ErrInternal System::LoadResourceString(&Tmsxlsmessages::_ErrInternal)
extern PACKAGE System::ResourceString _ErrCantCopyPictFmla;
#define Tmsxlsmessages_ErrCantCopyPictFmla System::LoadResourceString(&Tmsxlsmessages::_ErrCantCopyPictFmla)
extern PACKAGE System::ResourceString _ErrInvalidErrStr;
#define Tmsxlsmessages_ErrInvalidErrStr System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidErrStr)
extern PACKAGE System::ResourceString _ErrInvalidCellValue;
#define Tmsxlsmessages_ErrInvalidCellValue System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidCellValue)
extern PACKAGE System::ResourceString _ErrCantWriteToFile;
#define Tmsxlsmessages_ErrCantWriteToFile System::LoadResourceString(&Tmsxlsmessages::_ErrCantWriteToFile)
extern PACKAGE System::ResourceString _ErrShrFmlaNotFound;
#define Tmsxlsmessages_ErrShrFmlaNotFound System::LoadResourceString(&Tmsxlsmessages::_ErrShrFmlaNotFound)
extern PACKAGE System::ResourceString _ErrInvalidStrLenLength;
#define Tmsxlsmessages_ErrInvalidStrLenLength System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidStrLenLength)
extern PACKAGE System::ResourceString _ErrInvalidStringRecord;
#define Tmsxlsmessages_ErrInvalidStringRecord System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidStringRecord)
extern PACKAGE System::ResourceString _ErrNotImplemented;
#define Tmsxlsmessages_ErrNotImplemented System::LoadResourceString(&Tmsxlsmessages::_ErrNotImplemented)
extern PACKAGE System::ResourceString _BaseSheetName;
#define Tmsxlsmessages_BaseSheetName System::LoadResourceString(&Tmsxlsmessages::_BaseSheetName)
extern PACKAGE System::ResourceString _ErrNoDataSet;
#define Tmsxlsmessages_ErrNoDataSet System::LoadResourceString(&Tmsxlsmessages::_ErrNoDataSet)
extern PACKAGE System::ResourceString _ErrReportNotFound;
#define Tmsxlsmessages_ErrReportNotFound System::LoadResourceString(&Tmsxlsmessages::_ErrReportNotFound)
extern PACKAGE System::ResourceString _ErrTooManyPageBreaks;
#define Tmsxlsmessages_ErrTooManyPageBreaks System::LoadResourceString(&Tmsxlsmessages::_ErrTooManyPageBreaks)
extern PACKAGE System::ResourceString _ErrInvalidRow;
#define Tmsxlsmessages_ErrInvalidRow System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidRow)
extern PACKAGE System::ResourceString _ErrInvalidCol;
#define Tmsxlsmessages_ErrInvalidCol System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidCol)
extern PACKAGE System::ResourceString _ErrXlsIndexOutBounds;
#define Tmsxlsmessages_ErrXlsIndexOutBounds System::LoadResourceString(&Tmsxlsmessages::_ErrXlsIndexOutBounds)
extern PACKAGE System::ResourceString _ErrFileIsPasswordProtected;
#define Tmsxlsmessages_ErrFileIsPasswordProtected System::LoadResourceString(&Tmsxlsmessages::_ErrFileIsPasswordProtected)
extern PACKAGE System::ResourceString _ErrNotAString;
#define Tmsxlsmessages_ErrNotAString System::LoadResourceString(&Tmsxlsmessages::_ErrNotAString)
extern PACKAGE System::ResourceString _ErrUnexpectedEof;
#define Tmsxlsmessages_ErrUnexpectedEof System::LoadResourceString(&Tmsxlsmessages::_ErrUnexpectedEof)
extern PACKAGE System::ResourceString _ErrUnexpectedChar;
#define Tmsxlsmessages_ErrUnexpectedChar System::LoadResourceString(&Tmsxlsmessages::_ErrUnexpectedChar)
extern PACKAGE System::ResourceString _ErrUnterminatedString;
#define Tmsxlsmessages_ErrUnterminatedString System::LoadResourceString(&Tmsxlsmessages::_ErrUnterminatedString)
extern PACKAGE System::ResourceString _ErrMissingParen;
#define Tmsxlsmessages_ErrMissingParen System::LoadResourceString(&Tmsxlsmessages::_ErrMissingParen)
extern PACKAGE System::ResourceString _ErrFormulaTooLong;
#define Tmsxlsmessages_ErrFormulaTooLong System::LoadResourceString(&Tmsxlsmessages::_ErrFormulaTooLong)
extern PACKAGE System::ResourceString _ErrUnexpectedId;
#define Tmsxlsmessages_ErrUnexpectedId System::LoadResourceString(&Tmsxlsmessages::_ErrUnexpectedId)
extern PACKAGE System::ResourceString _ErrFunctionNotFound;
#define Tmsxlsmessages_ErrFunctionNotFound System::LoadResourceString(&Tmsxlsmessages::_ErrFunctionNotFound)
extern PACKAGE System::ResourceString _ErrInvalidNumberOfParams;
#define Tmsxlsmessages_ErrInvalidNumberOfParams System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidNumberOfParams)
extern PACKAGE System::ResourceString _ErrFormulaInvalid;
#define Tmsxlsmessages_ErrFormulaInvalid System::LoadResourceString(&Tmsxlsmessages::_ErrFormulaInvalid)
extern PACKAGE System::ResourceString _ErrFormulaStart;
#define Tmsxlsmessages_ErrFormulaStart System::LoadResourceString(&Tmsxlsmessages::_ErrFormulaStart)
extern PACKAGE System::ResourceString _ErrHiddenSheetSelected;
#define Tmsxlsmessages_ErrHiddenSheetSelected System::LoadResourceString(&Tmsxlsmessages::_ErrHiddenSheetSelected)
extern PACKAGE System::ResourceString _ErrNoSheetVisible;
#define Tmsxlsmessages_ErrNoSheetVisible System::LoadResourceString(&Tmsxlsmessages::_ErrNoSheetVisible)
extern PACKAGE System::ResourceString _ErrCantDeleteSheetWithMacros;
#define Tmsxlsmessages_ErrCantDeleteSheetWithMacros System::LoadResourceString(&Tmsxlsmessages::_ErrCantDeleteSheetWithMacros)
extern PACKAGE System::ResourceString _ErrInvalidSheet;
#define Tmsxlsmessages_ErrInvalidSheet System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidSheet)
extern PACKAGE System::ResourceString _WorkbookStrS;
#define Tmsxlsmessages_WorkbookStrS System::LoadResourceString(&Tmsxlsmessages::_WorkbookStrS)
extern PACKAGE System::ResourceString _ErrInvalidStream;
#define Tmsxlsmessages_ErrInvalidStream System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidStream)
extern PACKAGE System::ResourceString _ErrEofReached;
#define Tmsxlsmessages_ErrEofReached System::LoadResourceString(&Tmsxlsmessages::_ErrEofReached)
extern PACKAGE System::ResourceString _ErrInvalidPropertySector;
#define Tmsxlsmessages_ErrInvalidPropertySector System::LoadResourceString(&Tmsxlsmessages::_ErrInvalidPropertySector)
extern PACKAGE System::ResourceString _xlerr_Null;
#define Tmsxlsmessages_xlerr_Null System::LoadResourceString(&Tmsxlsmessages::_xlerr_Null)
extern PACKAGE System::ResourceString _xlerr_Div0;
#define Tmsxlsmessages_xlerr_Div0 System::LoadResourceString(&Tmsxlsmessages::_xlerr_Div0)
extern PACKAGE System::ResourceString _xlerr_Value;
#define Tmsxlsmessages_xlerr_Value System::LoadResourceString(&Tmsxlsmessages::_xlerr_Value)
extern PACKAGE System::ResourceString _xlerr_Ref;
#define Tmsxlsmessages_xlerr_Ref System::LoadResourceString(&Tmsxlsmessages::_xlerr_Ref)
extern PACKAGE System::ResourceString _xlerr_Name;
#define Tmsxlsmessages_xlerr_Name System::LoadResourceString(&Tmsxlsmessages::_xlerr_Name)
extern PACKAGE System::ResourceString _xlerr_Num;
#define Tmsxlsmessages_xlerr_Num System::LoadResourceString(&Tmsxlsmessages::_xlerr_Num)
extern PACKAGE System::ResourceString _xlerr_NA;
#define Tmsxlsmessages_xlerr_NA System::LoadResourceString(&Tmsxlsmessages::_xlerr_NA)
static const ShortInt xlerrcode_Null = 0x0;
static const ShortInt xlerrcode_Div0 = 0x7;
static const ShortInt xlerrcode_Value = 0xf;
static const ShortInt xlerrcode_Ref = 0x17;
static const ShortInt xlerrcode_Name = 0x1d;
static const ShortInt xlerrcode_Num = 0x24;
static const ShortInt xlerrcode_NA = 0x2a;
static const Word MaxRecordDataSize = 0x201f;
static const Word MaxExternSheetDataSize = 0x201c;
static const Word MaxHPageBreaks = 0x401;
static const Word MaxVPageBreaks = 0x401;
static const Byte Max_Columns = 0xff;
static const Word Max_Rows = 0xffff;
static const Word MaxSheets = 0xfde8;
static const Word xlr_BofVersion = 0x600;
static const ShortInt xlb_Globals = 0x5;
static const ShortInt xlb_Worksheet = 0x10;
static const ShortInt xlb_Chart = 0x20;
static const ShortInt xlr_INTEGER = 0x2;
static const ShortInt xlr_FORMULA = 0x6;
static const ShortInt xlr_EOF = 0xa;
static const ShortInt xlr_CALCCOUNT = 0xc;
static const ShortInt xlr_CALCMODE = 0xd;
static const ShortInt xlr_PRECISION = 0xe;
static const ShortInt xlr_REFMODE = 0xf;
static const ShortInt xlr_DELTA = 0x10;
static const ShortInt xlr_ITERATION = 0x11;
static const ShortInt xlr_PROTECT = 0x12;
static const ShortInt xlr_PASSWORD = 0x13;
static const ShortInt xlr_HEADER = 0x14;
static const ShortInt xlr_FOOTER = 0x15;
static const ShortInt xlr_EXTERNCOUNT = 0x16;
static const ShortInt xlr_EXTERNSHEET = 0x17;
static const ShortInt xlr_NAME = 0x18;
static const ShortInt xlr_WINDOWPROTECT = 0x19;
static const ShortInt xlr_VERTICALPAGEBREAKS = 0x1a;
static const ShortInt xlr_HORIZONTALPAGEBREAKS = 0x1b;
static const ShortInt xlr_NOTE = 0x1c;
static const ShortInt xlr_SELECTION = 0x1d;
static const ShortInt xlr_FORMATCOUNT = 0x1f;
static const ShortInt xlr_COLUMNDEFAULT = 0x20;
static const ShortInt xlr_1904 = 0x22;
static const ShortInt xlr_COLWIDTH = 0x24;
static const ShortInt xlr_LEFTMARGIN = 0x26;
static const ShortInt xlr_RIGHTMARGIN = 0x27;
static const ShortInt xlr_TOPMARGIN = 0x28;
static const ShortInt xlr_BOTTOMMARGIN = 0x29;
static const ShortInt xlr_PRINTHEADERS = 0x2a;
static const ShortInt xlr_PRINTGRIDLINES = 0x2b;
static const ShortInt xlr_FILEPASS = 0x2f;
static const ShortInt xlr_PRINTSIZE = 0x33;
static const ShortInt xlr_CONTINUE = 0x3c;
static const ShortInt xlr_WINDOW1 = 0x3d;
static const ShortInt xlr_BACKUP = 0x40;
static const ShortInt xlr_PANE = 0x41;
static const ShortInt xlr_CODEPAGE = 0x42;
static const ShortInt xlr_IXFE = 0x44;
static const ShortInt xlr_PLS = 0x4d;
static const ShortInt xlr_DCON = 0x50;
static const ShortInt xlr_DCONREF = 0x51;
static const ShortInt xlr_DCONNAME = 0x53;
static const ShortInt xlr_DEFCOLWIDTH = 0x55;
static const ShortInt xlr_BUILTINFMTCNT = 0x56;
static const ShortInt xlr_XCT = 0x59;
static const ShortInt xlr_CRN = 0x5a;
static const ShortInt xlr_FILESHARING = 0x5b;
static const ShortInt xlr_WRITEACCESS = 0x5c;
static const ShortInt xlr_OBJ = 0x5d;
static const ShortInt xlr_UNCALCED = 0x5e;
static const ShortInt xlr_SAFERECALC = 0x5f;
static const ShortInt xlr_TEMPLATE = 0x60;
static const ShortInt xlr_OBJPROTECT = 0x63;
static const ShortInt xlr_COLINFO = 0x7d;
static const ShortInt xlr_IMDATA = 0x7f;
static const Byte xlr_GUTS = 0x80;
static const Byte xlr_WSBOOL = 0x81;
static const Byte xlr_GRIDSET = 0x82;
static const Byte xlr_HCENTER = 0x83;
static const Byte xlr_VCENTER = 0x84;
static const Byte xlr_BOUNDSHEET = 0x85;
static const Byte xlr_WRITEPROT = 0x86;
static const Byte xlr_ADDIN = 0x87;
static const Byte xlr_EDG = 0x88;
static const Byte xlr_PUB = 0x89;
static const Byte xlr_COUNTRY = 0x8c;
static const Byte xlr_HIDEOBJ = 0x8d;
static const Byte xlr_BUNDLESOFFSET = 0x8e;
static const Byte xlr_BUNDLEHEADER = 0x8f;
static const Byte xlr_SORT = 0x90;
static const Byte xlr_SUB = 0x91;
static const Byte xlr_PALETTE = 0x92;
static const Byte xlr_LHRECORD = 0x94;
static const Byte xlr_LHNGRAPH = 0x95;
static const Byte xlr_SOUND = 0x96;
static const Byte xlr_LPR = 0x98;
static const Byte xlr_STANDARDWIDTH = 0x99;
static const Byte xlr_FNGROUPNAME = 0x9a;
static const Byte xlr_FILTERMODE = 0x9b;
static const Byte xlr_FNGROUPCOUNT = 0x9c;
static const Byte xlr_AUTOFILTERINFO = 0x9d;
static const Byte xlr_AUTOFILTER = 0x9e;
static const Byte xlr_SCL = 0xa0;
static const Byte xlr_SETUP = 0xa1;
static const Byte xlr_COORDLIST = 0xa9;
static const Byte xlr_GCW = 0xab;
static const Byte xlr_SCENMAN = 0xae;
static const Byte xlr_SCENARIO = 0xaf;
static const Byte xlr_SXVIEW = 0xb0;
static const Byte xlr_SXVD = 0xb1;
static const Byte xlr_SXVI = 0xb2;
static const Byte xlr_SXIVD = 0xb4;
static const Byte xlr_SXLI = 0xb5;
static const Byte xlr_SXPI = 0xb6;
static const Byte xlr_DOCROUTE = 0xb8;
static const Byte xlr_RECIPNAME = 0xb9;
static const Byte xlr_MULRK = 0xbd;
static const Byte xlr_MULBLANK = 0xbe;
static const Byte xlr_MMS = 0xc1;
static const Byte xlr_ADDMENU = 0xc2;
static const Byte xlr_DELMENU = 0xc3;
static const Byte xlr_SXDI = 0xc5;
static const Byte xlr_SXDB = 0xc6;
static const Byte xlr_SXFIELD = 0xc7;
static const Byte xlr_SXINDEXLIST = 0xc8;
static const Byte xlr_SXDOUBLE = 0xc9;
static const Byte xlr_SXSTRING = 0xcd;
static const Byte xlr_SXDATETIME = 0xce;
static const Byte xlr_SXTBL = 0xd0;
static const Byte xlr_SXTBRGITEM = 0xd1;
static const Byte xlr_SXTBPG = 0xd2;
static const Byte xlr_OBPROJ = 0xd3;
static const Byte xlr_SXIDSTM = 0xd5;
static const Byte xlr_RSTRING = 0xd6;
static const Byte xlr_DBCELL = 0xd7;
static const Byte xlr_BOOKBOOL = 0xda;
static const Byte xlr_SXEXTPARAMQRY = 0xdc;
static const Byte xlr_SCENPROTECT = 0xdd;
static const Byte xlr_OLESIZE = 0xde;
static const Byte xlr_UDDESC = 0xdf;
static const Byte xlr_INTERFACEHDR = 0xe1;
static const Byte xlr_INTERFACEEND = 0xe2;
static const Byte xlr_SXVS = 0xe3;
static const Byte xlr_CELLMERGING = 0xe5;
static const Byte xlr_BITMAP = 0xe9;
static const Byte xlr_MSODRAWINGGROUP = 0xeb;
static const Byte xlr_MSODRAWING = 0xec;
static const Byte xlr_MSODRAWINGSELECTION = 0xed;
static const Byte xlr_PHONETIC = 0xef;
static const Byte xlr_SXRULE = 0xf0;
static const Byte xlr_SXEX = 0xf1;
static const Byte xlr_SXFILT = 0xf2;
static const Byte xlr_SXNAME = 0xf6;
static const Byte xlr_SXSELECT = 0xf7;
static const Byte xlr_SXPAIR = 0xf8;
static const Byte xlr_SXFMLA = 0xf9;
static const Byte xlr_SXFORMAT = 0xfb;
static const Byte xlr_SST = 0xfc;
static const Byte xlr_LABELSST = 0xfd;
static const Byte xlr_EXTSST = 0xff;
static const Word xlr_SXVDEX = 0x100;
static const Word xlr_SXFORMULA = 0x103;
static const Word xlr_SXDBEX = 0x122;
static const Word xlr_CHTRINSERT = 0x137;
static const Word xlr_CHTRINFO = 0x138;
static const Word xlr_CHTRCELLCONTENT = 0x13b;
static const Word xlr_TABID = 0x13d;
static const Word xlr_CHTRMOVERANGE = 0x140;
static const Word xlr_CHTRINSERTTAB = 0x14d;
static const Word xlr_USESELFS = 0x160;
static const Word xlr_XL5MODIFY = 0x162;
static const Word xlr_CHTRHEADER = 0x196;
static const Word xlr_USERBVIEW = 0x1a9;
static const Word xlr_USERSVIEWBEGIN = 0x1aa;
static const Word xlr_USERSVIEWEND = 0x1ab;
static const Word xlr_QSI = 0x1ad;
static const Word xlr_SUPBOOK = 0x1ae;
static const Word xlr_PROT4REV = 0x1af;
static const Word xlr_DSF = 0x161;
static const Word xlr_CONDFMT = 0x1b0;
static const Word xlr_CF = 0x1b1;
static const Word xlr_DVAL = 0x1b2;
static const Word xlr_DCONBIN = 0x1b5;
static const Word xlr_TXO = 0x1b6;
static const Word xlr_REFRESHALL = 0x1b7;
static const Word xlr_HLINK = 0x1b8;
static const Word xlr_CODENAME = 0x1ba;
static const Word xlr_SXFDBTYPE = 0x1bb;
static const Word xlr_PROT4REVPASS = 0x1bc;
static const Word xlr_DV = 0x1be;
static const Word xlr_XL9FILE = 0x1c0;
static const Word xlr_RECALCID = 0x1c1;
static const Word xlr_DIMENSIONS = 0x200;
static const Word xlr_BLANK = 0x201;
static const Word xlr_NUMBER = 0x203;
static const Word xlr_LABEL = 0x204;
static const Word xlr_BOOLERR = 0x205;
static const Word xlr_STRING = 0x207;
static const Word xlr_ROW = 0x208;
static const Word xlr_INDEX = 0x20b;
static const Word xlr_ARRAY = 0x221;
static const ShortInt xlr_EXTERNNAME = 0x23;
static const Word xlr_EXTERNNAME2 = 0x223;
static const Word xlr_DEFAULTROWHEIGHT = 0x225;
static const ShortInt xlr_FONT = 0x31;
static const Word xlr_TABLE = 0x236;
static const Word xlr_WINDOW2 = 0x23e;
static const Word xlr_RK = 0x27e;
static const Word xlr_STYLE = 0x293;
static const Word xlr_FORMAT = 0x41e;
static const Byte xlr_XF = 0xe0;
static const Word xlr_SHRFMLA = 0x4bc;
static const Word xlr_SCREENTIP = 0x800;
static const Word xlr_WEBQRYSETTINGS = 0x803;
static const Word xlr_WEBQRYTABLES = 0x804;
static const Word xlr_BOF = 0x809;
static const Word xlr_UNITS = 0x1001;
static const Word xlr_ChartChart = 0x1002;
static const Word xlr_ChartSeries = 0x1003;
static const Word xlr_ChartDataformat = 0x1006;
static const Word xlr_ChartLineformat = 0x1007;
static const Word xlr_ChartMarkerformat = 0x1009;
static const Word xlr_ChartAreaformat = 0x100a;
static const Word xlr_ChartPieformat = 0x100b;
static const Word xlr_ChartAttachedlabel = 0x100c;
static const Word xlr_ChartSeriestext = 0x100d;
static const Word xlr_ChartChartformat = 0x1014;
static const Word xlr_ChartLegend = 0x1015;
static const Word xlr_ChartSerieslist = 0x1016;
static const Word xlr_ChartBar = 0x1017;
static const Word xlr_ChartLine = 0x1018;
static const Word xlr_ChartPie = 0x1019;
static const Word xlr_ChartArea = 0x101a;
static const Word xlr_ChartScatter = 0x101b;
static const Word xlr_ChartChartline = 0x101c;
static const Word xlr_ChartAxis = 0x101d;
static const Word xlr_ChartTick = 0x101e;
static const Word xlr_ChartValuerange = 0x101f;
static const Word xlr_ChartCatserrange = 0x1020;
static const Word xlr_ChartAxislineformat = 0x1021;
static const Word xlr_ChartFormatlink = 0x1022;
static const Word xlr_ChartDefaulttext = 0x1024;
static const Word xlr_ChartText = 0x1025;
static const Word xlr_ChartFontx = 0x1026;
static const Word xlr_ChartObjectLink = 0x1027;
static const Word xlr_ChartFrame = 0x1032;
static const Word xlr_BEGIN = 0x1033;
static const Word xlr_END = 0x1034;
static const Word xlr_ChartPlotarea = 0x1035;
static const Word xlr_Chart3D = 0x103a;
static const Word xlr_ChartPicf = 0x103c;
static const Word xlr_ChartDropbar = 0x103d;
static const Word xlr_ChartRadar = 0x103e;
static const Word xlr_ChartSurface = 0x103f;
static const Word xlr_ChartRadararea = 0x1040;
static const Word xlr_ChartAxisparent = 0x1041;
static const Word xlr_ChartLegendxn = 0x1043;
static const Word xlr_ChartShtprops = 0x1044;
static const Word xlr_ChartSertocrt = 0x1045;
static const Word xlr_ChartAxesused = 0x1046;
static const Word xlr_ChartSbaseref = 0x1048;
static const Word xlr_ChartSerparent = 0x104a;
static const Word xlr_ChartSerauxtrend = 0x104b;
static const Word xlr_ChartIfmt = 0x104e;
static const Word xlr_ChartPos = 0x104f;
static const Word xlr_ChartAlruns = 0x1050;
static const Word xlr_ChartAI = 0x1051;
static const Word xlr_ChartSerauxerrbar = 0x105b;
static const Word xlr_ChartClrClient = 0x105c;
static const Word xlr_ChartSerfmt = 0x105d;
static const Word xlr_Chart3DDataFormat = 0x105f;
static const Word xlr_ChartFbi = 0x1060;
static const Word xlr_ChartBoppop = 0x1061;
static const Word xlr_ChartAxcext = 0x1062;
static const Word xlr_ChartDat = 0x1063;
static const Word xlr_ChartPlotgrowth = 0x1064;
static const Word xlr_ChartSiindex = 0x1065;
static const Word xlr_ChartGelframe = 0x1066;
static const Word xlr_ChartBoppcustom = 0x1067;
static const ShortInt tk_Arrayformula = 0x1;
static const ShortInt tk_Table = 0x2;
#define tk_BinaryOps (Set<Byte, 0, 255> () << 0x3 << 0x4 << 0x5 << 0x6 << 0x7 << 0x8 << 0x9 << 0xa << 0xb << 0xc << 0xd << 0xe << 0xf << 0x10 << 0x11 )
#define tk_UnaryOps (Set<Byte, 0, 255> () << 0x12 << 0x13 << 0x14 << 0x15 )
static const ShortInt tk_MissArg = 0x16;
static const ShortInt tk_Str = 0x17;
static const ShortInt tk_Attr = 0x19;
static const ShortInt tk_Err = 0x1c;
static const ShortInt tk_Bool = 0x1d;
static const ShortInt tk_Int = 0x1e;
static const ShortInt tk_Num = 0x1f;
static const ShortInt tk_MemFunc = 0x29;
#define tk_Func (Set<Byte, 0, 255> () << 0x21 << 0x41 << 0x61 )
#define tk_FuncVar (Set<Byte, 0, 255> () << 0x22 << 0x42 << 0x62 )
#define tk_Array (Set<Byte, 0, 255> () << 0x20 << 0x40 << 0x60 )
#define tk_Name (Set<Byte, 0, 255> () << 0x23 << 0x43 << 0x63 )
#define tk_Ref (Set<Byte, 0, 255> () << 0x24 << 0x44 << 0x64 )
#define tk_Area (Set<Byte, 0, 255> () << 0x25 << 0x45 << 0x65 )
#define tk_RefErr (Set<Byte, 0, 255> () << 0x2a << 0x4a << 0x6a )
#define tk_AreaErr (Set<Byte, 0, 255> () << 0x2b << 0x4b << 0x6b )
#define tk_RefN (Set<Byte, 0, 255> () << 0x2c << 0x4c << 0x6c )
#define tk_AreaN (Set<Byte, 0, 255> () << 0x2d << 0x4d << 0x6d )
#define tk_NameX (Set<Byte, 0, 255> () << 0x39 << 0x59 << 0x79 )
#define tk_Ref3D (Set<Byte, 0, 255> () << 0x3a << 0x5a << 0x7a )
#define tk_Area3D (Set<Byte, 0, 255> () << 0x3b << 0x5b << 0x7b )
#define tk_Ref3DErr (Set<Byte, 0, 255> () << 0x3c << 0x5c << 0x7c )
#define tk_Area3DErr (Set<Byte, 0, 255> () << 0x3d << 0x5d << 0x7d )
static const ShortInt tk_RefToRefErr = 0x6;
static const ShortInt tk_AreaToAreaErr = 0x6;
static const ShortInt tk_Ref3DToRef3DErr = 0x2;
static const ShortInt tk_Area3DToArea3DErr = 0x2;
#define tk_Operand (Set<int, -2147483648, 2147483647> () << 0x20 << 0x23 << 0x24 << 0x25 << 0x2a << 0x2b << 0x2c << 0x2d << 0x39 << 0x3a << 0x3b << 0x3c << 0x3d << 0x40 << 0x43 << 0x44 << 0x45 << 0x4a << 0x4b << 0x4c << 0x4d << 0x59 << 0x5a << 0x5b << 0x5c << 0x5d << 0x60 << 0x63 << 0x64 << 0x65 << 0x6a << 0x6b << 0x6c << 0x6d << 0x79 << 0x7a << 0x7b << 0x7c << 0x7d )
static const ShortInt ftEnd = 0x0;
static const ShortInt ftMacro = 0x4;
static const ShortInt ftButton = 0x5;
static const ShortInt ftGmo = 0x6;
static const ShortInt ftCf = 0x7;
static const ShortInt ftPioGrbit = 0x8;
static const ShortInt ftPictFmla = 0x9;
static const ShortInt ftCbls = 0xa;
static const ShortInt ftRbo = 0xb;
static const ShortInt ftSbs = 0xc;
static const ShortInt ftNts = 0xd;
static const ShortInt ftSbsFmla = 0xe;
static const ShortInt ftGboData = 0xf;
static const ShortInt ftEdoData = 0x10;
static const ShortInt ftRboData = 0x11;
static const ShortInt ftCblsData = 0x12;
static const ShortInt ftLbsData = 0x13;
static const ShortInt ftCblsFmla = 0x14;
static const ShortInt ftCmo = 0x15;
static const ShortInt xlcmo_Group = 0x0;
static const ShortInt xlcmo_Line = 0x1;
static const ShortInt xlcmo_Rectangle = 0x2;
static const ShortInt xlcmo_Oval = 0x3;
static const ShortInt xlcmo_Arc = 0x4;
static const ShortInt xlcmo_Chart = 0x5;
static const ShortInt xlcmo_TextBox = 0x6;
static const ShortInt xlcmo_Button = 0x7;
static const ShortInt xlcmo_Picture = 0x8;
static const ShortInt xlcmo_Polygon = 0x9;
static const ShortInt xlcmo_CheckBox = 0xb;
static const ShortInt xlcmo_Option = 0xc;
static const ShortInt xlcmo_Edit = 0xd;
static const ShortInt xlcmo_Label = 0xe;
static const ShortInt xlcmo_Dialog = 0xf;
static const ShortInt xlcmo_Spinner = 0x10;
static const ShortInt xlcmo_Scroll = 0x11;
static const ShortInt xlcmo_List = 0x12;
static const ShortInt xlcmo_Group1 = 0x13;
static const ShortInt xlcmo_Combo = 0x14;
static const ShortInt xlcmo_Comment = 0x19;
static const ShortInt xlcmo_MSDrawingx = 0x1e;
static const Word MsofbtDggContainer = 0xf000;
static const Word MsofbtDgg = 0xf006;
static const Word MsofbtCLSID = 0xf016;
static const Word MsofbtOPT = 0xf00b;
static const Word MsofbtColorMRU = 0xf11a;
static const Word MsofbtSplitMenuColors = 0xf11e;
static const Word MsofbtBstoreContainer = 0xf001;
static const Word MsofbtBSE = 0xf007;
static const Word MsofbtDgContainer = 0xf002;
static const Word MsofbtDg = 0xf008;
static const Word MsofbtRegroupItem = 0xf118;
static const Word MsofbtColorScheme = 0xf120;
static const Word MsofbtSpgrContainer = 0xf003;
static const Word MsofbtSpContainer = 0xf004;
static const Word MsofbtSpgr = 0xf009;
static const Word MsofbtSp = 0xf00a;
static const Word MsofbtTextbox = 0xf00c;
static const Word MsofbtClientTextbox = 0xf00d;
static const Word MsofbtAnchor = 0xf00e;
static const Word MsofbtChildAnchor = 0xf00f;
static const Word MsofbtClientAnchor = 0xf010;
static const Word MsofbtClientData = 0xf011;
static const Word MsofbtOleObject = 0xf11f;
static const Word MsofbtDeletedPspl = 0xf11d;
static const Word MsofbtSolverContainer = 0xf005;
static const Word MsofbtConnectorRule = 0xf012;
static const Word MsofbtAlignRule = 0xf013;
static const Word MsofbtArcRule = 0xf014;
static const Word MsofbtClientRule = 0xf015;
static const Word MsofbtCalloutRule = 0xf017;
static const Word MsofbtSelection = 0xf119;
static const ShortInt msobiUNKNOWN = 0x0;
static const Word msobiWMF = 0x216;
static const Word msobiEMF = 0x3d4;
static const Word msobiPICT = 0x542;
static const Word msobiPNG = 0x6e0;
static const Word msobiJFIF = 0x46a;
static const Word msobiJPEG = 0x46a;
static const Word msobiDIB = 0x7a8;
static const Word msobiClient = 0x800;
static const ShortInt msoblipERROR = 0x0;
static const ShortInt msoblipUNKNOWN = 0x1;
static const ShortInt msoblipEMF = 0x2;
static const ShortInt msoblipWMF = 0x3;
static const ShortInt msoblipPICT = 0x4;
static const ShortInt msoblipJPEG = 0x5;
static const ShortInt msoblipPNG = 0x6;
static const ShortInt msoblipDIB = 0x7;
extern PACKAGE StaticArray<System::Byte, 6> XlsImgConv;
extern PACKAGE StaticArray<System::Word, 6> XlsBlipHeaderConv;
extern PACKAGE StaticArray<System::Word, 6> XlsBlipSignConv;
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

}	/* namespace Tmsxlsmessages */
using namespace Tmsxlsmessages;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsxlsmessagesHPP
