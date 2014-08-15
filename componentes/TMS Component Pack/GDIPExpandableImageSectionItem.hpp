// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipexpandableimagesectionitem.pas' rev: 21.00

#ifndef GdipexpandableimagesectionitemHPP
#define GdipexpandableimagesectionitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipimagesectionitem.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdipsectionitem.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipexpandableimagesectionitem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TExpanderState { esNormal, esDown, esHovered };
#pragma option pop

class DELPHICLASS TExpandableImageSectionItem;
class PASCALIMPLEMENTATION TExpandableImageSectionItem : public Gdipimagesectionitem::TImageSectionItem
{
	typedef Gdipimagesectionitem::TImageSectionItem inherited;
	
private:
	bool FExpanderVisible;
	int FExpanderSize;
	Gdipcustomitem::TItemLocation FExpanderLocation;
	bool FExpanded;
	Graphics::TColor FExpanderColor;
	Graphics::TColor FExpanderHoverColor;
	Graphics::TColor FExpanderDownColor;
	Graphics::TColor FExpanderBorderColor;
	TExpanderState FExpanderState;
	Gdipcustomitem::TItemEvent FOnInternalItemExpand;
	Gdipcustomitem::TItemEvent FOnItemExpand;
	int FExpanderTop;
	int FExpanderLeft;
	void __fastcall SetExpanderVisible(const bool Value);
	void __fastcall SetExpanderLocation(const Gdipcustomitem::TItemLocation Value);
	void __fastcall SetExpanderSize(const int Value);
	void __fastcall SetExpanded(const bool Value);
	void __fastcall SetExpanderColor(const Graphics::TColor Value);
	void __fastcall SetExpanderBorderColor(const Graphics::TColor Value);
	void __fastcall SetExpanderDownColor(const Graphics::TColor Value);
	void __fastcall SetExpanderHoverColor(const Graphics::TColor Value);
	void __fastcall SetExpanderState(const TExpanderState Value);
	void __fastcall SetExpanderLeft(const int Value);
	void __fastcall SetExpanderTop(const int Value);
	
protected:
	virtual void __fastcall DrawExpander(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoItemExpand(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	virtual void __fastcall DoInternalItemExpand(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	__property Gdipcustomitem::TItemEvent OnInternalItemExpand = {read=FOnInternalItemExpand, write=FOnInternalItemExpand};
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TExpandableImageSectionItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TExpandableImageSectionItem(void);
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	bool __fastcall IsExpanderAtXY(int pX, int pY);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Gdipcustomitem::TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	__property TExpanderState ExpanderState = {read=FExpanderState, write=SetExpanderState, nodefault};
	virtual void __fastcall ClearItemState(void);
	virtual void __fastcall DoMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall AssignEvents(Gdipcustomitem::TCustomItem* Item);
	
__published:
	__property int ExpanderLeft = {read=FExpanderLeft, write=SetExpanderLeft, default=0};
	__property int ExpanderTop = {read=FExpanderTop, write=SetExpanderTop, default=0};
	__property bool ExpanderVisible = {read=FExpanderVisible, write=SetExpanderVisible, default=1};
	__property int ExpanderSize = {read=FExpanderSize, write=SetExpanderSize, default=14};
	__property Gdipcustomitem::TItemLocation ExpanderLocation = {read=FExpanderLocation, write=SetExpanderLocation, default=5};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=1};
	__property Graphics::TColor ExpanderColor = {read=FExpanderColor, write=SetExpanderColor, default=12632256};
	__property Graphics::TColor ExpanderBorderColor = {read=FExpanderBorderColor, write=SetExpanderBorderColor, default=0};
	__property Graphics::TColor ExpanderDownColor = {read=FExpanderDownColor, write=SetExpanderDownColor, default=8421504};
	__property Graphics::TColor ExpanderHoverColor = {read=FExpanderHoverColor, write=SetExpanderHoverColor, nodefault};
	__property Gdipcustomitem::TItemEvent OnItemExpand = {read=FOnItemExpand, write=FOnItemExpand};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipexpandableimagesectionitem */
using namespace Gdipexpandableimagesectionitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipexpandableimagesectionitemHPP
