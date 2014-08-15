// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvsmoothlistboxde.pas' rev: 21.00

#ifndef DbadvsmoothlistboxdeHPP
#define DbadvsmoothlistboxdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dbadvsmoothlistbox.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Widestrings.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvsmoothlistboxde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvSmoothListBoxFieldNameProperty;
class PASCALIMPLEMENTATION TDBAdvSmoothListBoxFieldNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TDBAdvSmoothListBoxFieldNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TDBAdvSmoothListBoxFieldNameProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvsmoothlistboxde */
using namespace Dbadvsmoothlistboxde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvsmoothlistboxdeHPP
