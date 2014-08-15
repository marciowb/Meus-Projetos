// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipsplitteritem.pas' rev: 21.00

#ifndef GdipsplitteritemHPP
#define GdipsplitteritemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipsplitteritem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLineGradient { lgLeftToRight, lgRightToLeft, lgCenter };
#pragma option pop

class DELPHICLASS TSplitterItem;
class PASCALIMPLEMENTATION TSplitterItem : public Gdipcustomitem::TCustomItem
{
	typedef Gdipcustomitem::TCustomItem inherited;
	
private:
	Graphics::TColor FLineColor;
	int FLineSize;
	Controls::TMargins* FLineMargin;
	System::Byte FLineOpacity;
	bool FLineVisible;
	TLineGradient FLineGradient;
	Graphics::TColor FLineColorTo;
	System::Byte FLineOpacityTo;
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetLineMargin(const Controls::TMargins* Value);
	void __fastcall SetLineOpacity(const System::Byte Value);
	void __fastcall SetLineSize(const int Value);
	void __fastcall SetLineVisible(const bool Value);
	void __fastcall SetLineColorTo(const Graphics::TColor Value);
	void __fastcall SetLineGradient(const TLineGradient Value);
	void __fastcall SetLineOpacityTo(const System::Byte Value);
	
protected:
	virtual void __fastcall DrawLine(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	void __fastcall LineMarginChanged(System::TObject* Sender);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TSplitterItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TSplitterItem(void);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Gdipcustomitem::TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	virtual bool __fastcall IsSection(void);
	virtual bool __fastcall IsFocusable(void);
	virtual bool __fastcall FirstTab(bool Backwards);
	
__published:
	__property TLineGradient LineGradient = {read=FLineGradient, write=SetLineGradient, default=0};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=12632256};
	__property Graphics::TColor LineColorTo = {read=FLineColorTo, write=SetLineColorTo, default=16777215};
	__property Controls::TMargins* LineMargin = {read=FLineMargin, write=SetLineMargin};
	__property int LineSize = {read=FLineSize, write=SetLineSize, default=1};
	__property System::Byte LineOpacity = {read=FLineOpacity, write=SetLineOpacity, default=255};
	__property System::Byte LineOpacityTo = {read=FLineOpacityTo, write=SetLineOpacityTo, default=255};
	__property bool LineVisible = {read=FLineVisible, write=SetLineVisible, default=1};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipsplitteritem */
using namespace Gdipsplitteritem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipsplitteritemHPP
