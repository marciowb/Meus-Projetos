// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipimagetextbuttonitem.pas' rev: 21.00

#ifndef GdipimagetextbuttonitemHPP
#define GdipimagetextbuttonitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdipimagetextitem.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdiptextitem.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipimagetextbuttonitem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TItemButtonType { btButton, btExpander };
#pragma option pop

#pragma option push -b-
enum TButtonState { bsNormal, bsDown, bsHovered };
#pragma option pop

#pragma option push -b-
enum TButtonLocation { blRight, blLeft };
#pragma option pop

class DELPHICLASS TImageTextButtonItem;
class PASCALIMPLEMENTATION TImageTextButtonItem : public Gdipimagetextitem::TImageTextItem
{
	typedef Gdipimagetextitem::TImageTextItem inherited;
	
private:
	bool FButtonFocused;
	int FButtonWidth;
	bool FDown;
	Advgdip::TAdvGDIPPicture* FButtonImageUp;
	TItemButtonType FButtonType;
	Advgdip::TAdvGDIPPicture* FButtonImageDown;
	Graphics::TColor FButtonExpanderColor;
	int FButtonHeight;
	System::UnicodeString FButtonHint;
	TButtonLocation FButtonLocation;
	bool FButtonEnabled;
	Controls::TMargins* FButtonMargin;
	bool FButtonGlow;
	TButtonState FButtonState;
	Gdipcustomitem::TItemHintEvent FOnItemButtonHint;
	Gdipcustomitem::TItemEvent FOnInternalButtonClick;
	Gdipcustomitem::TItemEvent FOnButtonClick;
	Gdipcustomitem::TItemHintEvent FOnInternalItemButtonHint;
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall SetButtonImageUp(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetButtonType(const TItemButtonType Value);
	void __fastcall SetButtonImageDown(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetButtonExpanderColor(const Graphics::TColor Value);
	void __fastcall SetButtonLocation(const TButtonLocation Value);
	void __fastcall SetButtonEnabled(const bool Value);
	void __fastcall SetButtonMargin(const Controls::TMargins* Value);
	void __fastcall SetButtonGlow(const bool Value);
	void __fastcall SetButtonHint(const System::UnicodeString Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetButtonState(const TButtonState Value);
	
protected:
	void __fastcall ButtonImageChanged(System::TObject* Sender);
	virtual void __fastcall DrawButton(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DrawButtonGlow(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	void __fastcall ButtonMarginChanged(System::TObject* Sender);
	virtual void __fastcall DoItemButtonHint(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, System::UnicodeString &ButtonHint);
	virtual void __fastcall DoItemButtonClick(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	virtual void __fastcall DoInternalItemButtonClick(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	virtual void __fastcall DoInternalItemButtonHint(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, System::UnicodeString &ButtonHint);
	virtual int __fastcall GetVersionNr(void);
	
public:
	virtual Gdipcustomitem::TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	__fastcall virtual TImageTextButtonItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TImageTextButtonItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall IsButtonAtXY(int pX, int pY);
	virtual Gdipcustomitem::TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const Gdipcustomitem::TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	virtual Advgdip::TGPRectF __fastcall DrawText(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance, bool DoText = true);
	virtual void __fastcall DrawImage(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	__property bool Down = {read=FDown, write=SetDown, nodefault};
	virtual void __fastcall DoCMHintShow(Messages::TMessage &Message, const Gdipcustomitem::TItemInteraction &Interaction);
	virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int pX, int pY, const Gdipcustomitem::TItemInteraction &Interaction, const Gdipcustomitem::TItemAppearance &ItemAppearance);
	virtual void __fastcall ClearItemState(void);
	virtual void __fastcall AssignEvents(Gdipcustomitem::TCustomItem* Item);
	__property Gdipcustomitem::TItemEvent OnInternalItemButtonClick = {read=FOnInternalButtonClick, write=FOnInternalButtonClick};
	__property Gdipcustomitem::TItemHintEvent OnInternalItemButtonHint = {read=FOnInternalItemButtonHint, write=FOnInternalItemButtonHint};
	virtual bool __fastcall ProcessTab(bool Backwards);
	virtual void __fastcall ResetTab(void);
	virtual void __fastcall DoKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall DoKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	__property bool ButtonFocused = {read=FButtonFocused, nodefault};
	
__published:
	__property TButtonState ButtonState = {read=FButtonState, write=SetButtonState, nodefault};
	__property System::UnicodeString ButtonHint = {read=FButtonHint, write=SetButtonHint};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=30};
	__property Advgdip::TAdvGDIPPicture* ButtonImageUp = {read=FButtonImageUp, write=SetButtonImageUp};
	__property Advgdip::TAdvGDIPPicture* ButtonImageDown = {read=FButtonImageDown, write=SetButtonImageDown};
	__property TItemButtonType ButtonType = {read=FButtonType, write=SetButtonType, nodefault};
	__property Graphics::TColor ButtonExpanderColor = {read=FButtonExpanderColor, write=SetButtonExpanderColor, default=0};
	__property TButtonLocation ButtonLocation = {read=FButtonLocation, write=SetButtonLocation, nodefault};
	__property Controls::TMargins* ButtonMargin = {read=FButtonMargin, write=SetButtonMargin};
	__property bool ButtonEnabled = {read=FButtonEnabled, write=SetButtonEnabled, default=1};
	__property bool ButtonGlow = {read=FButtonGlow, write=SetButtonGlow, default=1};
	__property Gdipcustomitem::TItemHintEvent OnItemButtonHint = {read=FOnItemButtonHint, write=FOnItemButtonHint};
	__property Gdipcustomitem::TItemEvent OnItemButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Gdipimagetextbuttonitem */
using namespace Gdipimagetextbuttonitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipimagetextbuttonitemHPP
