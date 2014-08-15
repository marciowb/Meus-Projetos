// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothexpanderbuttonpanelde.pas' rev: 21.00

#ifndef AdvsmoothexpanderbuttonpaneldeHPP
#define AdvsmoothexpanderbuttonpaneldeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advsmoothfillpreview.hpp>	// Pascal unit
#include <Advsmoothexpanderbuttonpanel.hpp>	// Pascal unit
#include <Advsmoothfilleditor.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothexpanderbuttonpanelde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothExpanderButtonPanelEditor;
class PASCALIMPLEMENTATION TAdvSmoothExpanderButtonPanelEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
protected:
	virtual void __fastcall EditProperty(const Designintf::_di_IProperty PropertyEditor, bool &Continue);
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TAdvSmoothExpanderButtonPanelEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothExpanderButtonPanelEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advsmoothexpanderbuttonpanelde */
using namespace Advsmoothexpanderbuttonpanelde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothexpanderbuttonpaneldeHPP
