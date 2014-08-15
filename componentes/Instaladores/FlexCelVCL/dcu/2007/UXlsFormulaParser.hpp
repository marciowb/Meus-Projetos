// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsformulaparser.pas' rev: 11.00

#ifndef UxlsformulaparserHPP
#define UxlsformulaparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Xlsformulamessages.hpp>	// Pascal unit
#include <Uflxstack.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uxlsreferences.hpp>	// Pascal unit
#include <Uxlsrowcolentries.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsformulaparser
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE WideString __fastcall RPNToString(const Xlsmessages::PArrayOfByte RPN, const int atPos, const Uxlsrowcolentries::TCellList* CellList);

}	/* namespace Uxlsformulaparser */
using namespace Uxlsformulaparser;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsformulaparser
