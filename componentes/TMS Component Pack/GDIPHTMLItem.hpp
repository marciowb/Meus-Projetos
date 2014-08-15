// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdiphtmlitem.pas' rev: 21.00

#ifndef GdiphtmlitemHPP
#define GdiphtmlitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdiphtmlitem
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAnchorEvent)(System::TObject* Sender, System::UnicodeString Anchor);

struct TAnchorRecord
{
	
public:
	System::UnicodeString CaptionAnchor;
	System::UnicodeString DescriptionAnchor;
};


class DELPHICLASS THTMLItem;
class PASCALIMPLEMENTATION THTMLItem : public Gdipimagetextitem::TImageTextItem
{
	typedef Gdipimagetextitem::TImageTextItem inherited;
	
private:
	Advgdip::TGPBitmap* FHTMLCache;
	bool FRefreshHTMLCache;
	TAnchorEvent FOnCaptionAnchorClick;
	TAnchorEvent FOnDescriptionAnchorClick;
	TAnchorEvent FOnInternalCaptionAnchorClick;
	TAnchorEvent FOnInternalDescriptionAnchorClick;
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	virtual void __fastcall UseCaption(System::UnicodeString ACaption);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual void __fastcall Changed(void);
	__fastcall virtual ~THTMLItem(void);
	virtual void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	TAnchorRecord __fastcall GetAnchorAtXY(int pX, int pY, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	__property TAnchorEvent OnInternalCaptionAnchorClick = {read=FOnInternalCaptionAnchorClick, write=FOnInternalCaptionAnchorClick};
	__property TAnchorEvent OnInternalDescriptionAnchorClick = {read=FOnInternalDescriptionAnchorClick, write=FOnInternalDescriptionAnchorClick};
	virtual void __fastcall AssignEvents(Gdipcustomitem::TCustomItem* Item);
	
__published:
	__property TAnchorEvent OnCaptionAnchorClick = {read=FOnCaptionAnchorClick, write=FOnCaptionAnchorClick};
	__property TAnchorEvent OnDescriptionAnchorClick = {read=FOnDescriptionAnchorClick, write=FOnDescriptionAnchorClick};
public:
	/* TImageTextItem.Create */ inline __fastcall virtual THTMLItem(Classes::TComponent* AOwner) : Gdipimagetextitem::TImageTextItem(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdiphtmlitem */
using namespace Gdiphtmlitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdiphtmlitemHPP
