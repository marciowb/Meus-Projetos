// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Utextdelim.pas' rev: 20.00

#ifndef UtextdelimHPP
#define UtextdelimHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Uflxnumberformat.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Utextdelim
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum XLSColumnImportTypes { xct_general, xct_text, xct_skip };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall SaveRangeAsTextDelim(const Classes::TStream* OutStream, const Uexceladapter::TExcelFile* Workbook, const System::WideChar Delim, const Uflxmessages::TXlsCellRange &Range, const Sysutils::TEncoding* Encoding)/* overload */;
extern PACKAGE void __fastcall SaveAsTextDelim(const Classes::TStream* OutStream, const Uexceladapter::TExcelFile* Workbook, const System::WideChar Delim, const Sysutils::TEncoding* Encoding)/* overload */;
extern PACKAGE void __fastcall LoadFromTextDelim(const Classes::TStream* InStream, const Uexceladapter::TExcelFile* Workbook, const System::WideChar Delim, const int FirstRow, const int FirstCol, XLSColumnImportTypes const *ColumnFormats, const int ColumnFormats_Size, const Sysutils::TEncoding* Encoding, const bool DetectBOM = false)/* overload */;
extern PACKAGE void __fastcall LoadFromTextDelim(const Classes::TStreamReader* Sr, const Uexceladapter::TExcelFile* Workbook, const System::WideChar Delim, const int FirstRow, const int FirstCol, XLSColumnImportTypes const *ColumnFormats, const int ColumnFormats_Size)/* overload */;
extern PACKAGE void __fastcall SaveAsTextDelim(const Classes::TStream* OutStream, const Uexceladapter::TExcelFile* Workbook, const System::WideChar Delim)/* overload */;
extern PACKAGE void __fastcall SaveRangeAsTextDelim(const Classes::TStream* OutStream, const Uexceladapter::TExcelFile* Workbook, const System::WideChar Delim, const Uflxmessages::TXlsCellRange &Range)/* overload */;
extern PACKAGE void __fastcall LoadFromTextDelim(const Classes::TStream* InStream, const Uexceladapter::TExcelFile* Workbook, const System::WideChar aDelim, const int FirstRow, const int FirstCol, XLSColumnImportTypes const *ColumnFormats, const int ColumnFormats_Size)/* overload */;

}	/* namespace Utextdelim */
using namespace Utextdelim;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UtextdelimHPP
