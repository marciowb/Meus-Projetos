// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UEscherGraphToBSE.pas' rev: 22.00

#ifndef UeschergraphtobseHPP
#define UeschergraphtobseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UEscherRecords.hpp>	// Pascal unit
#include <UXlsMD5.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ueschergraphtobse
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Uescherrecords::TEscherBSERecord* __fastcall ConvertGraphicToBSE(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType, const Uescherrecords::PEscherDwgGroupCache DwgGroupCache, const Uescherrecords::PEscherDwgCache DwgCache);

}	/* namespace Ueschergraphtobse */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ueschergraphtobse;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UeschergraphtobseHPP
