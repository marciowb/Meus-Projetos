// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtdocconsts.pas' rev: 10.00

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
typedef AnsiString gtDocConsts__1[9];

struct gtDocConsts__2
{
	
public:
	AnsiString ISOCode;
	int WinCode;
} ;

typedef gtDocConsts__2 gtDocConsts__3[14];

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Graphics::TColor EditColor[2];
static const int CInchesToEMU = 0xdf3e0;
#define CVersion "2.5.2"
#define CCopyright "Copyright © 2002-2008 Gnostice Information Technologies Pr"\
	"ivate Limited"
static const Shortint CMaxPages = 0x5;
static const int CBackgroundColor = 16777215;
extern PACKAGE int CFontFixedPitch[2];
extern PACKAGE int CFontSerif[2];
extern PACKAGE int CFontSymbolic[2];
extern PACKAGE int CFontScript[2];
extern PACKAGE int CFontNonSymbolic[2];
extern PACKAGE int CFontItalic[2];
static const Shortint CRootObjNo = 0x1;
static const Shortint CPagesTreeObjNo = 0x2;
static const Shortint CInfoObjNo = 0x3;
static const Shortint CProcSetObjNo = 0x4;
static const Shortint CResourcesObjNo = 0x5;
static const Shortint CLastReservedObjNo = 0x5;
#define CAdobePDFSchemaURI "http://ns.adobe.com/pdf/1.3/"
#define CBasicSchemaURI "http://ns.adobe.com/xap/1.0/"
#define CDublinCoreSchemaURI "http://purl.org/dc/elements/1.1/"
#define CJobTicketSchemaURI "http://ns.adobe.com/xap/1.0/bj/"
#define CRightsManageSchemaURI "http://ns.adobe.com/xap/1.0/rights/"
#define CPagedTextSchemaURI "http://ns.adobe.com/xap/1.0/t/pg/"
#define CXMPPacketHeader "<?xpacket begin='' id='W5M0MpCehiHzreSzNTczkc9d'?>\r\n"
#define CXMPPacketTrailer "<?xpacket end='w'?>\r\n"
#define CXmpMetaHeader "<x:xmpmeta xmlns:x='adobe:ns:meta/'>\r\n"
#define CXMPMetaTrailer "</x:xmpmeta>\r\n"
#define CRDFHeader1 "<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-synta"\
	"x-ns#'\r\n"
#define CRDFHeader2 "xmlns:iX='http://ns.adobe.com/iX/1.0/'>"
#define CRDFTrailer "</rdf:RDF>\r\n"
#define CRDFDesHeader "<rdf:Description about=''"
#define CRDFDesTrailor "</rdf:Description>\r\n"
#define CAdobePDFNamePrefix "pdf"
#define CBasicNamePrefix "xmp"
#define CDublinCoreNamePrefix "dc"
#define CJobTicketNamePrefix "xmpBJ"
#define CRightsManageNamePrefix "xmpRights"
#define CPagedTextNamePrefix "xmpTPg"
static const int CLinkForeColor = 0xff0000;
static const int CLinkBackColor = 0xffffff;
static const int CLinkHoverForeColor = 0xffffff;
static const int CLinkHoverBackColor = 0xff0000;
#define CNavNormalColor "#0000FF"
#define CNavNormalBackground "#FFFFFF"
#define CNavHoverColor "#FFFFFF"
#define CNavHoverBackground "#0000FF"
static const Shortint CPageEndLineWidth = 0x2;
#define CmmToInch  (2.540000E+01)
extern PACKAGE AnsiString CLineStyle[9];
#define CHTMLNoTranslateText "\x01\x01\x01"
extern PACKAGE gtDocConsts__2 CANSICodePageIDs[14];
static const Shortint CDirCountSize = 0x2;
static const Shortint CIFDOffsetSize = 0x4;
static const Word CBitsPerSample = 0x8;
static const Word CByteOrder = 0x4949;
static const Word CTIFFId = 0x2a;
static const Word CDirSize = 0xc;
static const Word CTagWidth = 0x100;
static const Word CTagLength = 0x101;
static const Word CTagBitsPerSample = 0x102;
static const Word CTagCompression = 0x103;
static const Word CTagPhotometricInterpretation = 0x106;
static const Word CTagImageDesc = 0x10e;
static const Word CTagStripOffsets = 0x111;
static const Word CTagSamplesPerPixel = 0x115;
static const Word CTagRowsPerStrip = 0x116;
static const Word CTagStripByteCounts = 0x117;
static const Word CTagXRes = 0x11a;
static const Word CTagYRes = 0x11b;
static const Word CTagSoftware = 0x131;
static const Word CTagArtist = 0x13b;
static const Word CTagCopyright = 0x8298;
static const Word CTypeAscii = 0x2;
static const Word CTypeShort = 0x3;
static const Word CTypeLong = 0x4;
static const Word CTypeRational = 0x5;
static const Shortint CExcel_BOF = 0x9;
static const Word CExcel_BIFF7 = 0x809;
static const Word CExcel_BIFF7_BOF = 0x809;
static const Shortint CExcel_DocType = 0x10;
static const Shortint CExcel_Rec_Size_BOF = 0x8;
static const Shortint CExcel_EOF = 0xa;
static const Shortint CExcel_Rec_Size_EOF = 0x0;
static const Word CExcel_DIM = 0x200;
static const Shortint CExcel_Rec_Size_DIM = 0xa;
static const Shortint CExcel_Cell_Int = 0x2;
static const Shortint CExcel_Rec_Size_Cell_Int = 0xb;
static const Word CExcel_Cell_Double = 0x203;
static const Shortint CExcel_Rec_Size_Cell_Double = 0xe;
static const Word CExcel_Cell_Label = 0x204;
static const Shortint CExcel_Rec_Size_Cell_Label = 0x8;
static const Shortint CExcel_Cell_Column = 0x24;
static const Shortint CExcel_Rec_Size_Cell_Column = 0x4;
static const Word CExcel_Column_Width = 0x100;
static const Shortint CExcel_ColInfo = 0x7d;
static const Shortint CExcel_RightMargin = 0x27;
static const Shortint CExcel_LeftMargin = 0x26;
static const Shortint CExcel_TopMargin = 0x28;
static const Shortint CExcel_BottomMargin = 0x29;
static const Byte CExcel_Setup = 0xa1;
#define CSheet_StdCharsPerCell  (8.430000E+00)
#define COLEPadBytes "52006f006f007400200045006e00740072007900000000000000000000"\
	"0000000000000000000000000000000000000000000000000000000000"\
	"00000000000016000501ffffffffffffffff0200000010080200000000"\
	"00C0000000000000460000000000000000000000000000000000000000"\
	"feffffff000000000000000042006f006f006b00000000000000000000"\
	"0000000000000000000000000000000000000000000000000000000000"\
	"0000000000000000000000000000000000000a000201ffffffffffffff"\
	"ffffffffff000000000000000000000000000000000000000000000000"\
	"0000000000000000000000000000000000100000000000000500530075"\
	"006d006d0061007200790049006e0066006f0072006d00610074006900"\
	"6f006e0000000000000000000000000000000000000000000000000000"\
	"00280002010100000003000000ffffffff000000000000000000000000"\
	"0000000000000000000000000000000000000000000000000000000000"\
	"10000000000000050044006f00630075006d0065006e00740053007500"\
	"6d006d0061007200790049006e0066006F0072006d006100740069006f"\
	"006e000000000000000000000038000201ffffffffffffffffffffffff"\
	"0000000000000000000000000000000000000000000000000000000000"\
	"00000000000000100000000010000000000000"
static const Word CSummaryInfoSize = 0x1000;
static const Word CDocumentSummaryInfoSize = 0x1000;
extern PACKAGE Extended CStandardHeight;
static const Word CMaxRowHeight = 0x199;
static const Word CMaxColWidth = 0x100;
static const Shortint CQpro_BOF = 0x0;
static const Shortint CQpro_BOF_LEN = 0x2;
static const Shortint CQPro_EOF = 0x1;
static const Shortint CQPro_EOF_LEN = 0x0;
static const Word CQpro_REVISION = 0x1001;
static const Byte CQPro_BOP = 0xca;
static const Shortint CQPro_BOP_LEN = 0x1;
static const Byte CQPro_EOP = 0xcb;
static const Shortint CQPro_EOP_LEN = 0x1;
static const Shortint CQPro_DIMENSION = 0x7;
static const Shortint CQPro_DIMENSION_LEN = 0x8;
static const Shortint CQPro_STRING = 0xf;
static const Shortint CQPro_STRING_LEN = 0x7;
static const Shortint CQPro_NUMBER = 0xe;
static const Shortint CQPro_NUMBER_LENGTH = 0xe;
static const Shortint CQPro_MARGIN = 0x28;
static const Shortint CQPro_MARGIN_LENGTH = 0xc;
static const Byte CQPro_Orientation = 0xf7;
static const Shortint CQPro_Orientation_LENGTH = 0x1;
static const Word CQPro_PrintBegin = 0x109;
static const Byte CQPro_PrintEnd = 0xfb;
static const Byte CQPro_Font = 0xcf;
static const Shortint CQPro_Font_LENGTH = 0x24;
static const Byte CQPro_Color = 0xe8;
static const Byte CQPro_CellAttrib = 0xce;
static const Word CLOTUS_REVISION = 0x404;
static const Shortint CLOTUS_BOF = 0x0;
static const Shortint CLOTUS_BOF_LEN = 0x2;
static const Shortint CLOTUS_EOF = 0x1;
static const Shortint CLOTUS_EOF_LEN = 0x0;
static const Shortint CLOTUS_RANGE = 0x6;
static const Shortint CLOTUS_RANGE_LEN = 0x8;
static const Shortint CLOTUS_STRING = 0xf;
static const Shortint CLOTUS_STRING_LEN = 0x6;
static const Shortint CLOTUS_NUMBER = 0xe;
static const Shortint CLOTUS_PAGE = 0x28;
static const Shortint CLOTUS_PAGE_LENGTH = 0xa;

}	/* namespace Gtdocconsts */
using namespace Gtdocconsts;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtdocconsts
