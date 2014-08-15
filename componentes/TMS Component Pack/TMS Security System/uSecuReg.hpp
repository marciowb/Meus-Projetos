// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Usecureg.pas' rev: 21.00

#ifndef UsecuregHPP
#define UsecuregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Useccontrol.hpp>	// Pascal unit
#include <Uformpolicy.hpp>	// Pascal unit
#include <Ulogindlg.hpp>	// Pascal unit
#include <Uchangepassworddlg.hpp>	// Pascal unit
#include <Uaboutuilsecurity.hpp>	// Pascal unit
#include <Uformpolicydesigner.hpp>	// Pascal unit
#include <Uformpolicydlg.hpp>	// Pascal unit
#include <Uformpolicydesignerprop.hpp>	// Pascal unit
#include <Usecdlg.hpp>	// Pascal unit
#include <Usecdlgform.hpp>	// Pascal unit
#include <Uproxy.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Usecureg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilFormPolicyEditor;
class PASCALIMPLEMENTATION TuilFormPolicyEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TuilFormPolicyEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TuilFormPolicyEditor(void) { }
	
};


class DELPHICLASS TuilSecManEditor;
class PASCALIMPLEMENTATION TuilSecManEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual int __fastcall GetVerbCount(void);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty Prop, bool &Continue);
	virtual void __fastcall Edit(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TuilSecManEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TuilSecManEditor(void) { }
	
};


class DELPHICLASS TuilDataFieldProperty;
class PASCALIMPLEMENTATION TuilDataFieldProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall GetValues(Classes::TGetStrProc Proc);
	void __fastcall GetValueList(Classes::TStrings* List);
	virtual void __fastcall SetValue(const System::UnicodeString Value)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TuilDataFieldProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TuilDataFieldProperty(void) { }
	
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  SetValue(const System::WideString Value){ Designeditors::TPropertyEditor::SetValue(Value); }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Usecureg */
using namespace Usecureg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UsecuregHPP
