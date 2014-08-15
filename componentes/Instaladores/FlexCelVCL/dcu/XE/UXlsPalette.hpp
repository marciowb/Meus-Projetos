// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsPalette.pas' rev: 22.00

#ifndef UxlspaletteHPP
#define UxlspaletteHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <UXlsBaseRecordLists.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlspalette
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPaletteRecord;
class PASCALIMPLEMENTATION TPaletteRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	unsigned __fastcall GetColor(int index);
	void __fastcall SetColor(int index, const unsigned Value);
	System::Word __fastcall GetCount(void);
	
public:
	__property System::Word Count = {read=GetCount, nodefault};
	__property unsigned Color[int index] = {read=GetColor, write=SetColor};
	__fastcall TPaletteRecord(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TPaletteRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPaletteRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE unsigned __fastcall StandardPalette(const int Index);

}	/* namespace Uxlspalette */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlspalette;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlspaletteHPP
