// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlspalette.pas' rev: 21.00

#ifndef TmsuxlspaletteHPP
#define TmsuxlspaletteHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlspalette
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPaletteRecord;
class PASCALIMPLEMENTATION TPaletteRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
private:
	unsigned __fastcall GetColor(int index);
	void __fastcall SetColor(int index, const unsigned Value);
	System::Word __fastcall GetCount(void);
	
public:
	__property System::Word Count = {read=GetCount, nodefault};
	__property unsigned Color[int index] = {read=GetColor, write=SetColor};
	__fastcall TPaletteRecord(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TPaletteRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPaletteRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE unsigned __fastcall StandardPalette(const int Index);

}	/* namespace Tmsuxlspalette */
using namespace Tmsuxlspalette;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlspaletteHPP
