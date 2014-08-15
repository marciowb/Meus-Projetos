// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipmenude.pas' rev: 21.00

#ifndef GdipmenudeHPP
#define GdipmenudeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advsmoothmegamenueditor.hpp>	// Pascal unit
#include <Gdipmenu.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipmenude
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGDIPMenuProperty;
class PASCALIMPLEMENTATION TGDIPMenuProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TGDIPMenuProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TGDIPMenuProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gdipmenude */
using namespace Gdipmenude;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipmenudeHPP
