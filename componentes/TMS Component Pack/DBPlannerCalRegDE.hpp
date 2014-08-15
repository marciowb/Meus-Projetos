// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbplannercalregde.pas' rev: 21.00

#ifndef DbplannercalregdeHPP
#define DbplannercalregdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dbplannercal.hpp>	// Pascal unit
#include <Dbplannercalde.hpp>	// Pascal unit
#include <Dbplannerdatepicker.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbplannercalregde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBPlannerCalendarEditProperty;
class PASCALIMPLEMENTATION TDBPlannerCalendarEditProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TDBPlannerCalendarEditProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TDBPlannerCalendarEditProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Dbplannercalregde */
using namespace Dbplannercalregde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbplannercalregdeHPP
