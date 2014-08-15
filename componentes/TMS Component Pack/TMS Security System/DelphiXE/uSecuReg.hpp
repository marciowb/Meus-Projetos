// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uSecuReg.pas' rev: 22.00

#ifndef UsecuregHPP
#define UsecuregHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <uSecControl.hpp>	// Pascal unit
#include <uFormPolicy.hpp>	// Pascal unit
#include <uLoginDlg.hpp>	// Pascal unit
#include <uChangePasswordDlg.hpp>	// Pascal unit
#include <uAboutUILSecurity.hpp>	// Pascal unit
#include <uFormPolicyDesigner.hpp>	// Pascal unit
#include <uFormPolicyDlg.hpp>	// Pascal unit
#include <uFormPolicyDesignerProp.hpp>	// Pascal unit
#include <uSecDlg.hpp>	// Pascal unit
#include <uSecDlgForm.hpp>	// Pascal unit
#include <uProxy.hpp>	// Pascal unit

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
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Usecureg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UsecuregHPP
