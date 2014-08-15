// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdiplargebuttoneditem.pas' rev: 21.00

#ifndef GdiplargebuttoneditemHPP
#define GdiplargebuttoneditemHPP

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
#include <Gdipimagetextbuttonitem.hpp>	// Pascal unit
#include <Gdipimagetextbuttonsectionitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdiplargebuttoneditem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonCaptionLocation { bclBottom, bclTop };
#pragma option pop

class DELPHICLASS TLargeButtonedItem;
class PASCALIMPLEMENTATION TLargeButtonedItem : public Gdipimagetextbuttonsectionitem::TImageTextButtonSectionItem
{
	typedef Gdipimagetextbuttonsectionitem::TImageTextButtonSectionItem inherited;
	
private:
	System::UnicodeString FButtonCaption;
	TButtonCaptionLocation FButtonCaptionLocation;
	int FButtonCaptionSize;
	Graphics::TColor FButtonCaptionColor;
	System::Byte FButtonCaptionOpacity;
	void __fastcall SetButtonCaption(const System::UnicodeString Value);
	void __fastcall SetButtonCaptionLocation(const TButtonCaptionLocation Value);
	void __fastcall SetButtonCaptionSize(const int Value);
	void __fastcall SetButtonCaptionColor(const Graphics::TColor Value);
	void __fastcall SetButtonCaptionOpacity(const System::Byte Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	__fastcall virtual TLargeButtonedItem(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall DrawButton(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	
__published:
	__property System::UnicodeString ButtonCaption = {read=FButtonCaption, write=SetButtonCaption};
	__property TButtonCaptionLocation ButtonCaptionLocation = {read=FButtonCaptionLocation, write=SetButtonCaptionLocation, default=0};
	__property int ButtonCaptionSize = {read=FButtonCaptionSize, write=SetButtonCaptionSize, default=-1};
	__property Graphics::TColor ButtonCaptionColor = {read=FButtonCaptionColor, write=SetButtonCaptionColor, default=536870911};
	__property System::Byte ButtonCaptionOpacity = {read=FButtonCaptionOpacity, write=SetButtonCaptionOpacity, default=255};
public:
	/* TImageTextButtonSectionItem.Destroy */ inline __fastcall virtual ~TLargeButtonedItem(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdiplargebuttoneditem */
using namespace Gdiplargebuttoneditem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdiplargebuttoneditemHPP
