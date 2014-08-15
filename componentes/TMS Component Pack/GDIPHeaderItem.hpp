// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipheaderitem.pas' rev: 21.00

#ifndef GdipheaderitemHPP
#define GdipheaderitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipimagesectionitem.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Gdipsectionitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipheaderitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS THeaderItem;
class PASCALIMPLEMENTATION THeaderItem : public Gdipimagesectionitem::TImageSectionItem
{
	typedef Gdipimagesectionitem::TImageSectionItem inherited;
	
private:
	Graphics::TColor FHeaderColor;
	void __fastcall SetHeaderColor(const Graphics::TColor Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	__fastcall virtual THeaderItem(Classes::TComponent* AOwner);
	__fastcall virtual ~THeaderItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual bool __fastcall FirstTab(bool Backwards);
	
__published:
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, default=13224393};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipheaderitem */
using namespace Gdipheaderitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipheaderitemHPP
