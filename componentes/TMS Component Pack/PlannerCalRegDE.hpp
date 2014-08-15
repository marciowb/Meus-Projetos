// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plannercalregde.pas' rev: 21.00

#ifndef PlannercalregdeHPP
#define PlannercalregdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Plannercal.hpp>	// Pascal unit
#include <Plannerdatepicker.hpp>	// Pascal unit
#include <Plannermaskdatepicker.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Planstyles.hpp>	// Pascal unit
#include <Advimage.hpp>	// Pascal unit
#include <Advimgde.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plannercalregde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerCalendarEditProperty;
class PASCALIMPLEMENTATION TPlannerCalendarEditProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TPlannerCalendarEditProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPlannerCalendarEditProperty(void) { }
	
};


class DELPHICLASS TPlannerCalendarEditor;
class PASCALIMPLEMENTATION TPlannerCalendarEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TPlannerCalendarEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPlannerCalendarEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Plannercalregde */
using namespace Plannercalregde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannercalregdeHPP
