// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Customeditorde.pas' rev: 21.00

#ifndef CustomeditordeHPP
#define CustomeditordeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Customeditor.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Customeditorde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCustomEditorProp;
class PASCALIMPLEMENTATION TCustomEditorProp : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TCustomEditorProp(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TCustomEditorProp(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Customeditorde */
using namespace Customeditorde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomeditordeHPP
