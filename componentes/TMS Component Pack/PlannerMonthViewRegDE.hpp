// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plannermonthviewregde.pas' rev: 21.00

#ifndef PlannermonthviewregdeHPP
#define PlannermonthviewregdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Plannermonthview.hpp>	// Pascal unit
#include <Planner.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Planstyles.hpp>	// Pascal unit
#include <Advimage.hpp>	// Pascal unit
#include <Advimgde.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plannermonthviewregde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerMonthViewEditor;
class PASCALIMPLEMENTATION TPlannerMonthViewEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TPlannerMonthViewEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPlannerMonthViewEditor(void) { }
	
};


class DELPHICLASS TPMVSkinProperty;
class PASCALIMPLEMENTATION TPMVSkinProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TPMVSkinProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPMVSkinProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Plannermonthviewregde */
using namespace Plannermonthviewregde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannermonthviewregdeHPP
