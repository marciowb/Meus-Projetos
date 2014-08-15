// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipradioitem.pas' rev: 21.00

#ifndef GdipradioitemHPP
#define GdipradioitemHPP

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
#include <Gdipcheckitem.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipradioitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRadioItem;
class PASCALIMPLEMENTATION TRadioItem : public Gdipcheckitem::TCheckItem
{
	typedef Gdipcheckitem::TCheckItem inherited;
	
private:
	int FGroupIndex;
	void __fastcall SetGroupIndex(const int Value);
	
protected:
	void __fastcall GlobalCheck(Gdipcustomitem::TCustomItem* Item);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TRadioItem(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall DrawGraphic(Advgdip::TGPGraphics* g, const Types::TRect &R, const Gdipcustomitem::TItemAppearance &ItemAppearance, Gdipgraphicitem::TGraphicKind Kind, bool Checked);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	__classmethod virtual bool __fastcall Display();
	
__published:
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
public:
	/* TGraphicItem.Destroy */ inline __fastcall virtual ~TRadioItem(void) { }
	
private:
	void *__IGDIPGlobalCheck;	/* Gdipcustomitem::IGDIPGlobalCheck */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IGDIPGlobalCheck()
	{
		Gdipcustomitem::_di_IGDIPGlobalCheck intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGDIPGlobalCheck*(void) { return (IGDIPGlobalCheck*)&__IGDIPGlobalCheck; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipradioitem */
using namespace Gdipradioitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipradioitemHPP
