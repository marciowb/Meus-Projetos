// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtdocconsts.pas' rev: 21.00

#ifndef GtdocconstsHPP
#define GtdocconstsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtdocconsts
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<System::UnicodeString, 9> Gtdocconsts__1;

struct Gtdocconsts__2
{
	
public:
	System::UnicodeString ISOCode;
	int WinCode;
};


typedef StaticArray<Gtdocconsts__2, 14> Gtdocconsts__3;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE StaticArray<Graphics::TColor, 2> EditColor;
static const int CInchesToEMU = 0xdf3e0;
#define CVersion L"2.5.2"
#define CCopyright L"Copyright \u00a9 2002-2008 Gnostice Information Technologi"\
	L"es Private Limited"
static const ShortInt CMaxPages = 0x5;
static const int CBackgroundColor = 16777215;
extern PACKAGE StaticArray<int, 2> CFontFixedPitch;
extern PACKAGE StaticArray<int, 2> CFontSerif;
extern PACKAGE StaticArray<int, 2> CFontSymbolic;
extern PACKAGE StaticArray<int, 2> CFontScript;
extern PACKAGE StaticArray<int, 2> CFontNonSymbolic;
extern PACKAGE StaticArray<int, 2> CFontItalic;
static const ShortInt CRootObjNo = 0x1;
static const ShortInt CPagesTreeObjNo = 0x2;
static const ShortInt CInfoObjNo = 0x3;
static const ShortInt CProcSetObjNo = 0x4;
static const ShortInt CResourcesObjNo = 0x5;
static const ShortInt CLastReservedObjNo = 0x5;
#define CAdobePDFSchemaURI L"http://ns.adobe.com/pdf/1.3/"
#define CBasicSchemaURI L"http://ns.adobe.com/xap/1.0/"
#define CDublinCoreSchemaURI L"http://purl.org/dc/elements/1.1/"
#define CJobTicketSchemaURI L"http://ns.adobe.com/xap/1.0/bj/"
#define CRightsManageSchemaURI L"http://ns.adobe.com/xap/1.0/rights/"
#define CPagedTextSchemaURI L"http://ns.adobe.com/xap/1.0/t/pg/"
#define CXMPPacketHeader L"<?xpacket begin='' id='W5M0MpCehiHzreSzNTczkc9d'?>\r\n"
#define CXMPPacketTrailer L"<?xpacket end='w'?>\r\n"
#define CXmpMetaHeader L"<x:xmpmeta xmlns:x='adobe:ns:meta/'>\r\n"
#define CXMPMetaTrailer L"</x:xmpmeta>\r\n"
#define CRDFHeader1 L"<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-synta"\
	L"x-ns#'\r\n"
#define CRDFHeader2 L"xmlns:iX='http://ns.adobe.com/iX/1.0/'>"
#define CRDFTrailer L"</rdf:RDF>\r\n"
#define CRDFDesHeader L"<rdf:Description about=''"
#define CRDFDesTrailor L"</rdf:Description>\r\n"
#define CAdobePDFNamePrefix L"pdf"
#define CBasicNamePrefix L"xmp"
#define CDublinCoreNamePrefix L"dc"
#define CJobTicketNamePrefix L"xmpBJ"
#define CRightsManageNamePrefix L"xmpRights"
#define CPagedTextNamePrefix L"xmpTPg"
static const int CLinkForeColor = 0xff0000;
static const int CLinkBackColor = 0xffffff;
static const int CLinkHoverForeColor = 0xffffff;
static const int CLinkHoverBackColor = 0xff0000;
#define CNavNormalColor L"#0000FF"
#define CNavNormalBackground L"#FFFFFF"
#define CNavHoverColor L"#FFFFFF"
#define CNavHoverBackground L"#0000FF"
static const ShortInt CPageEndLineWidth = 0x2;
#define CmmToInch  (2.540000E+01)
extern PACKAGE Gtdocconsts__1 CLineStyle;
#define CHTMLNoTranslateText L"\u0001\u0001\u0001"
extern PACKAGE Gtdocconsts__3 CANSICodePageIDs;
static const ShortInt CDirCountSize = 0x2;
static const ShortInt CIFDOffsetSize = 0x4;
static const System::Word CBitsPerSample = 0x8;
static const System::Word CByteOrder = 0x4949;
static const System::Word CTIFFId = 0x2a;
static const System::Word CDirSize = 0xc;
static const System::Word CTagWidth = 0x100;
static const System::Word CTagLength = 0x101;
static const System::Word CTagBitsPerSample = 0x102;
static const System::Word CTagCompression = 0x103;
static const System::Word CTagPhotometricInterpretation = 0x106;
static const System::Word CTagImageDesc = 0x10e;
static const System::Word CTagStripOffsets = 0x111;
static const System::Word CTagSamplesPerPixel = 0x115;
static const System::Word CTagRowsPerStrip = 0x116;
static const System::Word CTagStripByteCounts = 0x117;
static const System::Word CTagXRes = 0x11a;
static const System::Word CTagYRes = 0x11b;
static const System::Word CTagSoftware = 0x131;
static const System::Word CTagArtist = 0x13b;
static const System::Word CTagCopyright = 0x8298;
static const System::Word CTypeAscii = 0x2;
static const System::Word CTypeShort = 0x3;
static const System::Word CTypeLong = 0x4;
static const System::Word CTypeRational = 0x5;
static const ShortInt CExcel_BOF = 0x9;
static const Word CExcel_BIFF7 = 0x809;
static const Word CExcel_BIFF7_BOF = 0x809;
static const ShortInt CExcel_DocType = 0x10;
static const ShortInt CExcel_Rec_Size_BOF = 0x8;
static const ShortInt CExcel_EOF = 0xa;
static const ShortInt CExcel_Rec_Size_EOF = 0x0;
static const Word CExcel_DIM = 0x200;
static const ShortInt CExcel_Rec_Size_DIM = 0xa;
static const ShortInt CExcel_Cell_Int = 0x2;
static const ShortInt CExcel_Rec_Size_Cell_Int = 0xb;
static const Word CExcel_Cell_Double = 0x203;
static const ShortInt CExcel_Rec_Size_Cell_Double = 0xe;
static const Word CExcel_Cell_Label = 0x204;
static const ShortInt CExcel_Rec_Size_Cell_Label = 0x8;
static const ShortInt CExcel_Cell_Column = 0x24;
static const ShortInt CExcel_Rec_Size_Cell_Column = 0x4;
static const Word CExcel_Column_Width = 0x100;
static const ShortInt CExcel_ColInfo = 0x7d;
static const ShortInt CExcel_RightMargin = 0x27;
static const ShortInt CExcel_LeftMargin = 0x26;
static const ShortInt CExcel_TopMargin = 0x28;
static const ShortInt CExcel_BottomMargin = 0x29;
static const Byte CExcel_Setup = 0xa1;
#define CSheet_StdCharsPerCell  (8.430000E+00)
#define COLEPadBytes L"52006f006f007400200045006e00740072007900000000000000000000"\
	L"0000000000000000000000000000000000000000000000000000000000"\
	L"00000000000016000501ffffffffffffffff0200000010080200000000"\
	L"00C0000000000000460000000000000000000000000000000000000000"\
	L"feffffff000000000000000042006f006f006b00000000000000000000"\
	L"0000000000000000000000000000000000000000000000000000000000"\
	L"0000000000000000000000000000000000000a000201ffffffffffffff"\
	L"ffffffffff000000000000000000000000000000000000000000000000"\
	L"0000000000000000000000000000000000100000000000000500530075"\
	L"006d006d0061007200790049006e0066006f0072006d00610074006900"\
	L"6f006e0000000000000000000000000000000000000000000000000000"\
	L"00280002010100000003000000ffffffff000000000000000000000000"\
	L"0000000000000000000000000000000000000000000000000000000000"\
	L"10000000000000050044006f00630075006d0065006e00740053007500"\
	L"6d006d0061007200790049006e0066006F0072006d006100740069006f"\
	L"006e000000000000000000000038000201ffffffffffffffffffffffff"\
	L"0000000000000000000000000000000000000000000000000000000000"\
	L"00000000000000100000000010000000000000"
static const Word CSummaryInfoSize = 0x1000;
static const Word CDocumentSummaryInfoSize = 0x1000;
extern PACKAGE System::Extended CStandardHeight;
static const Word CMaxRowHeight = 0x199;
static const Word CMaxColWidth = 0x100;
static const ShortInt CQpro_BOF = 0x0;
static const ShortInt CQpro_BOF_LEN = 0x2;
static const ShortInt CQPro_EOF = 0x1;
static const ShortInt CQPro_EOF_LEN = 0x0;
static const Word CQpro_REVISION = 0x1001;
static const Byte CQPro_BOP = 0xca;
static const ShortInt CQPro_BOP_LEN = 0x1;
static const Byte CQPro_EOP = 0xcb;
static const ShortInt CQPro_EOP_LEN = 0x1;
static const ShortInt CQPro_DIMENSION = 0x7;
static const ShortInt CQPro_DIMENSION_LEN = 0x8;
static const ShortInt CQPro_STRING = 0xf;
static const ShortInt CQPro_STRING_LEN = 0x7;
static const ShortInt CQPro_NUMBER = 0xe;
static const ShortInt CQPro_NUMBER_LENGTH = 0xe;
static const ShortInt CQPro_MARGIN = 0x28;
static const ShortInt CQPro_MARGIN_LENGTH = 0xc;
static const Byte CQPro_Orientation = 0xf7;
static const ShortInt CQPro_Orientation_LENGTH = 0x1;
static const Word CQPro_PrintBegin = 0x109;
static const Byte CQPro_PrintEnd = 0xfb;
static const Byte CQPro_Font = 0xcf;
static const ShortInt CQPro_Font_LENGTH = 0x24;
static const Byte CQPro_Color = 0xe8;
static const Byte CQPro_CellAttrib = 0xce;
static const Word CLOTUS_REVISION = 0x404;
static const ShortInt CLOTUS_BOF = 0x0;
static const ShortInt CLOTUS_BOF_LEN = 0x2;
static const ShortInt CLOTUS_EOF = 0x1;
static const ShortInt CLOTUS_EOF_LEN = 0x0;
static const ShortInt CLOTUS_RANGE = 0x6;
static const ShortInt CLOTUS_RANGE_LEN = 0x8;
static const ShortInt CLOTUS_STRING = 0xf;
static const ShortInt CLOTUS_STRING_LEN = 0x6;
static const ShortInt CLOTUS_NUMBER = 0xe;
static const ShortInt CLOTUS_PAGE = 0x28;
static const ShortInt CLOTUS_PAGE_LENGTH = 0xa;

}	/* namespace Gtdocconsts */
using namespace Gtdocconsts;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtdocconstsHPP
