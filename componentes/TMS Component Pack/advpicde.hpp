// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpicde.pas' rev: 21.00

#ifndef AdvpicdeHPP
#define AdvpicdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Advpicture.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpicde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvPictureProperty;
class PASCALIMPLEMENTATION TAdvPictureProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TAdvPictureProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TAdvPictureProperty(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advpicde */
using namespace Advpicde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpicdeHPP
