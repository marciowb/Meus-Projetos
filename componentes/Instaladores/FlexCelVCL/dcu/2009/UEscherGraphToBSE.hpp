// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ueschergraphtobse.pas' rev: 20.00

#ifndef UeschergraphtobseHPP
#define UeschergraphtobseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uescherrecords.hpp>	// Pascal unit
#include <Uxlsmd5.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ueschergraphtobse
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Uescherrecords::TEscherBSERecord* __fastcall ConvertGraphicToBSE(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType, const Uescherrecords::PEscherDwgGroupCache DwgGroupCache, const Uescherrecords::PEscherDwgCache DwgCache);

}	/* namespace Ueschergraphtobse */
using namespace Ueschergraphtobse;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UeschergraphtobseHPP
