// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsformulaparser.pas' rev: 21.00

#ifndef TmsuxlsformulaparserHPP
#define TmsuxlsformulaparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsxlsformulamessages.hpp>	// Pascal unit
#include <Tmsuflxstack.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuxlsreferences.hpp>	// Pascal unit
#include <Tmsuxlsrowcolentries.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsformulaparser
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::UnicodeString __fastcall RPNToString(const Tmsxlsmessages::PArrayOfByte RPN, const int atPos, const Tmsuxlsrowcolentries::TCellList* CellList);

}	/* namespace Tmsuxlsformulaparser */
using namespace Tmsuxlsformulaparser;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsformulaparserHPP
