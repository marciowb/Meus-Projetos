// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uformpolicydesignerprop.pas' rev: 21.00

#ifndef UformpolicydesignerpropHPP
#define UformpolicydesignerpropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Toolwin.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Uformpolicy.hpp>	// Pascal unit
#include <Uformpolicydesigner.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uformpolicydesignerprop
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilFormPolicyProperty;
class PASCALIMPLEMENTATION TuilFormPolicyProperty : public Designeditors::TPropertyEditor
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual bool __fastcall AllEqual(void);
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
	void __fastcall AddComponents(Uformpolicydesigner::TfrmFormPolicy* AForm);
	void __fastcall AddPolicies(Uformpolicydesigner::TfrmFormPolicy* AForm, Uformpolicy::TuilPolicy* APolicy);
	void __fastcall SavePolicies(Uformpolicydesigner::TfrmFormPolicy* AForm, Uformpolicy::TuilPolicy* Policies);
	void __fastcall AddToList(Uformpolicydesigner::TfrmFormPolicy* AForm, System::UnicodeString CompName, System::UnicodeString ClassName);
	int __fastcall GetClassImage(System::UnicodeString AClassName);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TuilFormPolicyProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TuilFormPolicyProperty(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uformpolicydesignerprop */
using namespace Uformpolicydesignerprop;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UformpolicydesignerpropHPP
