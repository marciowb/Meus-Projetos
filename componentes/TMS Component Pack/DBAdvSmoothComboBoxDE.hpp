// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvsmoothcomboboxde.pas' rev: 21.00

#ifndef DbadvsmoothcomboboxdeHPP
#define DbadvsmoothcomboboxdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Dbadvsmoothcombobox.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Widestrings.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvsmoothcomboboxde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvSmoothComboBoxFieldNameProperty;
class PASCALIMPLEMENTATION TDBAdvSmoothComboBoxFieldNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TDBAdvSmoothComboBoxFieldNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TDBAdvSmoothComboBoxFieldNameProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvsmoothcomboboxde */
using namespace Dbadvsmoothcomboboxde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvsmoothcomboboxdeHPP
