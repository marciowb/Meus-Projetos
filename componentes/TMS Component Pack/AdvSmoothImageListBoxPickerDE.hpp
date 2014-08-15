// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothimagelistboxpickerde.pas' rev: 21.00

#ifndef AdvsmoothimagelistboxpickerdeHPP
#define AdvsmoothimagelistboxpickerdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advsmoothimagelistboxpicker.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothimagelistboxpickerde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothImageListBoxPickerEditor;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxPickerEditor : public Designeditors::TDefaultEditor
{
	typedef Designeditors::TDefaultEditor inherited;
	
public:
	virtual System::UnicodeString __fastcall GetVerb(int index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall ExecuteVerb(int Index);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TAdvSmoothImageListBoxPickerEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TDefaultEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothImageListBoxPickerEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advsmoothimagelistboxpickerde */
using namespace Advsmoothimagelistboxpickerde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothimagelistboxpickerdeHPP
