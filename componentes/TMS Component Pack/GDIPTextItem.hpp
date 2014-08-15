// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdiptextitem.pas' rev: 21.00

#ifndef GdiptextitemHPP
#define GdiptextitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdiptextitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTextItem;
class PASCALIMPLEMENTATION TTextItem : public Gdipcustomitem::TCustomItem
{
	typedef Gdipcustomitem::TCustomItem inherited;
	
private:
	System::UnicodeString FCaption;
	Controls::TMargins* FCaptionMargin;
	Graphics::TColor FCaptionColor;
	int FCaptionTop;
	int FCaptionLeft;
	Gdipcustomitem::TItemLocation FCaptionLocation;
	bool FWordWrap;
	bool FEllipsis;
	System::Byte FCaptionOpacity;
	int FCaptionSize;
	int FDescriptionSize;
	Controls::TMargins* FDescriptionMargin;
	System::Byte FDescriptionOpacity;
	System::UnicodeString FDescription;
	Graphics::TColor FDescriptionColor;
	int FDescriptionTop;
	int FDescriptionLeft;
	Gdipcustomitem::TItemLocation FDescriptionLocation;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCaptionMargin(const Controls::TMargins* Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetCaptionLocation(const Gdipcustomitem::TItemLocation Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetCaptionOpacity(const System::Byte Value);
	void __fastcall SetCaptionSize(const int Value);
	void __fastcall SetDescription(const System::UnicodeString Value);
	void __fastcall SetDescriptionColor(const Graphics::TColor Value);
	void __fastcall SetDescriptionMargin(const Controls::TMargins* Value);
	void __fastcall SetDescriptionOpacity(const System::Byte Value);
	void __fastcall SetDescriptionSize(const int Value);
	void __fastcall SetDescriptionLeft(const int Value);
	void __fastcall SetDescriptionLocation(const Gdipcustomitem::TItemLocation Value);
	void __fastcall SetDescriptionTop(const int Value);
	
protected:
	void __fastcall CaptionMarginChanged(System::TObject* Sender);
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TTextItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TTextItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual Gdipcustomitem::TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual void __fastcall UseCaption(System::UnicodeString ACaption);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Controls::TMargins* CaptionMargin = {read=FCaptionMargin, write=SetCaptionMargin};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=536870911};
	__property System::Byte CaptionOpacity = {read=FCaptionOpacity, write=SetCaptionOpacity, default=255};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Gdipcustomitem::TItemLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=3};
	__property int CaptionSize = {read=FCaptionSize, write=SetCaptionSize, default=-1};
	__property System::UnicodeString Description = {read=FDescription, write=SetDescription};
	__property Controls::TMargins* DescriptionMargin = {read=FDescriptionMargin, write=SetDescriptionMargin};
	__property Graphics::TColor DescriptionColor = {read=FDescriptionColor, write=SetDescriptionColor, default=8421504};
	__property System::Byte DescriptionOpacity = {read=FDescriptionOpacity, write=SetDescriptionOpacity, default=255};
	__property int DescriptionSize = {read=FDescriptionSize, write=SetDescriptionSize, default=-1};
	__property Gdipcustomitem::TItemLocation DescriptionLocation = {read=FDescriptionLocation, write=SetDescriptionLocation, default=0};
	__property int DescriptionLeft = {read=FDescriptionLeft, write=SetDescriptionLeft, default=0};
	__property int DescriptionTop = {read=FDescriptionTop, write=SetDescriptionTop, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdiptextitem */
using namespace Gdiptextitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdiptextitemHPP
