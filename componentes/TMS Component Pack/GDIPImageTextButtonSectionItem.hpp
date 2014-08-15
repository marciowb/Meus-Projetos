// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipimagetextbuttonsectionitem.pas' rev: 21.00

#ifndef GdipimagetextbuttonsectionitemHPP
#define GdipimagetextbuttonsectionitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdipimagetextbuttonitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipimagetextbuttonsectionitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImageTextButtonSectionItem;
class PASCALIMPLEMENTATION TImageTextButtonSectionItem : public Gdipimagetextbuttonitem::TImageTextButtonItem
{
	typedef Gdipimagetextbuttonitem::TImageTextButtonItem inherited;
	
private:
	Graphics::TColor FLineColor;
	int FLineSize;
	Controls::TMargins* FLineMargin;
	Graphics::TPenStyle FLineStyle;
	System::Byte FLineOpacity;
	Gdipcustomitem::TItemLineLocations FLineLocation;
	bool FLineVisible;
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetLineLocation(const Gdipcustomitem::TItemLineLocations Value);
	void __fastcall SetLineMargin(const Controls::TMargins* Value);
	void __fastcall SetLineOpacity(const System::Byte Value);
	void __fastcall SetLineSize(const int Value);
	void __fastcall SetLineStyle(const Graphics::TPenStyle Value);
	void __fastcall SetLineVisible(const bool Value);
	
protected:
	virtual void __fastcall DrawLine(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	void __fastcall LineMarginChanged(System::TObject* Sender);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TImageTextButtonSectionItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TImageTextButtonSectionItem(void);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Gdipcustomitem::TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	virtual bool __fastcall FirstTab(bool Backwards);
	virtual bool __fastcall IsSection(void);
	
__published:
	__property Graphics::TPenStyle LineStyle = {read=FLineStyle, write=SetLineStyle, default=2};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=12632256};
	__property Gdipcustomitem::TItemLineLocations LineLocation = {read=FLineLocation, write=SetLineLocation, default=8};
	__property Controls::TMargins* LineMargin = {read=FLineMargin, write=SetLineMargin};
	__property int LineSize = {read=FLineSize, write=SetLineSize, default=2};
	__property System::Byte LineOpacity = {read=FLineOpacity, write=SetLineOpacity, default=255};
	__property bool LineVisible = {read=FLineVisible, write=SetLineVisible, default=1};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipimagetextbuttonsectionitem */
using namespace Gdipimagetextbuttonsectionitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipimagetextbuttonsectionitemHPP
