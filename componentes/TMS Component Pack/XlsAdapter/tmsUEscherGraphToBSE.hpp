// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsueschergraphtobse.pas' rev: 21.00

#ifndef TmsueschergraphtobseHPP
#define TmsueschergraphtobseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuescherrecords.hpp>	// Pascal unit
#include <Tmsuxlsmd5.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsueschergraphtobse
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Tmsuescherrecords::TEscherBSERecord* __fastcall ConvertGraphicToBSE(const Tmsuflxmessages::ByteArray Data, const Tmsuflxmessages::TXlsImgTypes DataType, const Tmsuescherrecords::PEscherDwgGroupCache DwgGroupCache, const Tmsuescherrecords::PEscherDwgCache DwgCache);

}	/* namespace Tmsueschergraphtobse */
using namespace Tmsueschergraphtobse;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsueschergraphtobseHPP
