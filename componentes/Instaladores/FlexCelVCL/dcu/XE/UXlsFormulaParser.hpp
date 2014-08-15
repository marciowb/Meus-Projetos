// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsFormulaParser.pas' rev: 22.00

#ifndef UxlsformulaparserHPP
#define UxlsformulaparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <XlsFormulaMessages.hpp>	// Pascal unit
#include <UFlxStack.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <UXlsBaseRecordLists.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UXlsReferences.hpp>	// Pascal unit
#include <UXlsRowColEntries.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsformulaparser
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::UnicodeString __fastcall RPNToString(const Xlsmessages::PArrayOfByte RPN, const int atPos, const Uxlsrowcolentries::TCellList* CellList);

}	/* namespace Uxlsformulaparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlsformulaparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsformulaparserHPP
