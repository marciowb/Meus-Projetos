// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipcustomitemde.pas' rev: 21.00

#ifndef GdipcustomitemdeHPP
#define GdipcustomitemdeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdipgraphicitem.hpp>	// Pascal unit
#include <Gdipbuttonbaritem.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Designintf.hpp>	// Pascal unit
#include <Designeditors.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipcustomitemde
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPictureContainerTextProperty;
class PASCALIMPLEMENTATION TPictureContainerTextProperty : public Designeditors::TStringProperty
{
	typedef Designeditors::TStringProperty inherited;
	
private:
	int maxheight;
	int maxwidth;
	
protected:
	void __fastcall ListBoxClick(System::TObject* Sender);
	void __fastcall ListBoxDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall ListBoxMeasureItem(Controls::TWinControl* Control, int Index, int &Height);
	
public:
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	HIDESBASE void __fastcall Edit(const Designintf::_di_IPropertyHost Host, bool DblClick)/* overload */;
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TPictureContainerTextProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TPictureContainerTextProperty(void) { }
	
private:
	void *__IProperty80;	/* Designintf::IProperty80 */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Designintf::_di_IProperty80()
	{
		Designintf::_di_IProperty80 intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IProperty80*(void) { return (IProperty80*)&__IProperty80; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gdipcustomitemde */
using namespace Gdipcustomitemde;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipcustomitemdeHPP
