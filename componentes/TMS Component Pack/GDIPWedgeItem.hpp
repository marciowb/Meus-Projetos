// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipwedgeitem.pas' rev: 21.00

#ifndef GdipwedgeitemHPP
#define GdipwedgeitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipwedgeitem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWedgePosition { wpLeft, wpTop, wpBottom, wpRight };
#pragma option pop

typedef Set<TWedgePosition, wpLeft, wpRight>  TWedgePositions;

class DELPHICLASS TWedgeItem;
class PASCALIMPLEMENTATION TWedgeItem : public Gdipimagetextitem::TImageTextItem
{
	typedef Gdipimagetextitem::TImageTextItem inherited;
	
private:
	TWedgePositions FWedgePositions;
	int FWedgeSize;
	Gdipcustomitem::TItemStates FWedgeStates;
	void __fastcall SetWedgePositions(const TWedgePositions Value);
	void __fastcall SetWedgeSize(const int Value);
	void __fastcall SetWedgeStates(const Gdipcustomitem::TItemStates Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall DrawFocus(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	Advgdip::TGPRectF __fastcall GetWedgeRect(const Advgdip::TGPRectF &ARect);
	
public:
	__fastcall virtual TWedgeItem(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual void __fastcall DrawImage(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	
__published:
	__property TWedgePositions WedgePositions = {read=FWedgePositions, write=SetWedgePositions, default=8};
	__property int WedgeSize = {read=FWedgeSize, write=SetWedgeSize, default=6};
	__property Gdipcustomitem::TItemStates WedgeStates = {read=FWedgeStates, write=SetWedgeStates, default=15};
public:
	/* TImageTextItem.Destroy */ inline __fastcall virtual ~TWedgeItem(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipwedgeitem */
using namespace Gdipwedgeitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipwedgeitemHPP
