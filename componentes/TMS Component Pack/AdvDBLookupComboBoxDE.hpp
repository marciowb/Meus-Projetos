// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdblookupcomboboxde.pas' rev: 21.00

#ifndef AdvdblookupcomboboxdeHPP
#define AdvdblookupcomboboxdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advdblookupcombobox.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdblookupcomboboxde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvDBLookupComboBoxEditor;
class PASCALIMPLEMENTATION TAdvDBLookupComboBoxEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TAdvDBLookupComboBoxEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvDBLookupComboBoxEditor(void) { }
	
};


class DELPHICLASS TAdvDBComboFieldNameProperty;
class PASCALIMPLEMENTATION TAdvDBComboFieldNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TAdvDBComboFieldNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TAdvDBComboFieldNameProperty(void) { }
	
};


class DELPHICLASS TAdvDBComboColumnNameProperty;
class PASCALIMPLEMENTATION TAdvDBComboColumnNameProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TAdvDBComboColumnNameProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TAdvDBComboColumnNameProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advdblookupcomboboxde */
using namespace Advdblookupcomboboxde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdblookupcomboboxdeHPP
