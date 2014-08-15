// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficeselectorsregde.pas' rev: 21.00

#ifndef AdvofficeselectorsregdeHPP
#define AdvofficeselectorsregdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advofficeselectors.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficeselectorsregde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvOfficeScrollSelectorEditor;
class PASCALIMPLEMENTATION TAdvOfficeScrollSelectorEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TAdvOfficeScrollSelectorEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvOfficeScrollSelectorEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Advofficeselectorsregde */
using namespace Advofficeselectorsregde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficeselectorsregdeHPP
