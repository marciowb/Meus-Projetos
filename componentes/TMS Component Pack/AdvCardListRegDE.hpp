// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcardlistregde.pas' rev: 21.00

#ifndef AdvcardlistregdeHPP
#define AdvcardlistregdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advcardlist.hpp>	// Pascal unit
#include <Advcardlistgradient.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcardlistregde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvCardListEditor;
class PASCALIMPLEMENTATION TAdvCardListEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TAdvCardListEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvCardListEditor(void) { }
	
};


class DELPHICLASS TAdvCardTemplateEditor;
class PASCALIMPLEMENTATION TAdvCardTemplateEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TAdvCardTemplateEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvCardTemplateEditor(void) { }
	
};


class DELPHICLASS TAdvGradientProperty;
class PASCALIMPLEMENTATION TAdvGradientProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual void __fastcall Edit(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TAdvGradientProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TAdvGradientProperty(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Advcardlistregde */
using namespace Advcardlistregde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcardlistregdeHPP
