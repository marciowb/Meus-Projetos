// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advstyleif.pas' rev: 21.00

#ifndef AdvstyleifHPP
#define AdvstyleifHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advstyleif
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TTMSStyle { tsOffice2003Blue, tsOffice2003Silver, tsOffice2003Olive, tsOffice2003Classic, tsOffice2007Luna, tsOffice2007Obsidian, tsWindowsXP, tsWhidbey, tsCustom, tsOffice2007Silver, tsWindowsVista, tsWindows7, tsTerminal, tsOffice2010Blue, tsOffice2010Silver, tsOffice2010Black };
#pragma option pop

__interface ITMSStyle;
typedef System::DelphiInterface<ITMSStyle> _di_ITMSStyle;
__interface  INTERFACE_UUID("{11AC2DDC-C087-4298-AB6E-EA1B5017511B}") ITMSStyle  : public System::IInterface 
{
	
public:
	virtual void __fastcall SetComponentStyle(TTMSStyle AStyle) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall IsVista(void);

}	/* namespace Advstyleif */
using namespace Advstyleif;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvstyleifHPP
