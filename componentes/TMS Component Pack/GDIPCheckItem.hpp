// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipcheckitem.pas' rev: 21.00

#ifndef GdipcheckitemHPP
#define GdipcheckitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipgraphicitem.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipcheckitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCheckItem;
class PASCALIMPLEMENTATION TCheckItem : public Gdipgraphicitem::TGraphicItem
{
	typedef Gdipgraphicitem::TGraphicItem inherited;
	
private:
	Gdipcustomitem::TItemCheckEvent FOnInternalItemCheckChanged;
	Gdipcustomitem::TItemCheckEvent FOnItemCheckChanged;
	bool FChecked;
	void __fastcall SetChecked(const bool Value);
	
protected:
	virtual void __fastcall DoInternalItemCheckChanged(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool Checked);
	virtual void __fastcall DoItemCheckChanged(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool Checked);
	__property Gdipcustomitem::TItemCheckEvent OnInternalItemCheckChanged = {read=FOnInternalItemCheckChanged, write=FOnInternalItemCheckChanged};
	virtual int __fastcall GetVersionNr(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	__classmethod virtual bool __fastcall Display();
	virtual void __fastcall AssignEvents(Gdipcustomitem::TCustomItem* Item);
	
__published:
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property Gdipcustomitem::TItemCheckEvent OnItemCheckChanged = {read=FOnItemCheckChanged, write=FOnItemCheckChanged};
public:
	/* TGraphicItem.Create */ inline __fastcall virtual TCheckItem(Classes::TComponent* AOwner) : Gdipgraphicitem::TGraphicItem(AOwner) { }
	/* TGraphicItem.Destroy */ inline __fastcall virtual ~TCheckItem(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipcheckitem */
using namespace Gdipcheckitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipcheckitemHPP
