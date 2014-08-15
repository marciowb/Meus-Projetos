// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothcombobox.pas' rev: 21.00

#ifndef AdvsmoothcomboboxHPP
#define AdvsmoothcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmoothlistbox.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothcombobox
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSmoothComboBoxButtonState { bsDown, bsUp, bsHover };
#pragma option pop

class DELPHICLASS TAdvSmoothComboBoxButtonAppearance;
class DELPHICLASS TAdvSmoothComboBox;
class PASCALIMPLEMENTATION TAdvSmoothComboBoxButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothComboBoxButtonState FButtonState;
	int FButtonWidth;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FFill;
	Gdipfill::TGDIPFill* FFillDown;
	Gdipfill::TGDIPFill* FFillHover;
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFillDown(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFillHover(const Gdipfill::TGDIPFill* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothComboBoxButtonAppearance(TAdvSmoothComboBox* AOwner);
	__fastcall virtual ~TAdvSmoothComboBoxButtonAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Width = {read=FButtonWidth, write=SetButtonWidth, default=30};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdipfill::TGDIPFill* FillDown = {read=FFillDown, write=SetFillDown};
	__property Gdipfill::TGDIPFill* FillHover = {read=FFillHover, write=SetFillHover};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TAdvSmoothComboBox : public Advsmoothlistbox::TAdvSmoothListBox
{
	typedef Advsmoothlistbox::TAdvSmoothListBox inherited;
	
private:
	int FTimerCount;
	System::UnicodeString FLookupKey;
	bool FFocused;
	bool FMouseDown;
	int FClickY;
	int FClickX;
	bool FListBoxMouseDown;
	bool FListBoxMouseMoved;
	bool FDesignTime;
	bool FConstructed;
	bool CancelThisBtnClick;
	Extctrls::TTimer* FTimer;
	bool FDeactivating;
	Forms::TForm* LstParent;
	Gdipfill::TGDIPFill* FFill;
	Advsmoothlistbox::TAdvSmoothListBox* FListBox;
	TAdvSmoothComboBoxButtonAppearance* FButtonAppearance;
	bool FAutoHeight;
	int FDropDownHeight;
	int FDropDownWidth;
	Classes::TNotifyEvent FOnCloseUp;
	Classes::TNotifyEvent FOnDropDown;
	bool FSkipKeyScrolling;
	HIDESBASE void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	HIDESBASE void __fastcall SetSelectedItemIndex(const int Value);
	void __fastcall SetButtonAppearance(const TAdvSmoothComboBoxButtonAppearance* Value);
	HIDESBASE void __fastcall HideParent(void);
	HIDESBASE Controls::TWinControl* __fastcall GetParentEx(void);
	HIDESBASE void __fastcall SetParentEx(const Controls::TWinControl* Value);
	void __fastcall SetAutoHeight(const bool Value);
	void __fastcall SetDropDownHeight(const int Value);
	void __fastcall SetDropDownWidth(const int Value);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
public:
	__fastcall virtual TAdvSmoothComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothComboBox(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignCombo(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	HIDESBASE virtual void __fastcall DropDown(void);
	__property Controls::TWinControl* Parent = {read=GetParentEx, write=SetParentEx};
	void __fastcall CancelBtnClick(void);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
protected:
	int FSelectedItemIndex;
	virtual void __fastcall SetInternalSelectedItemIndex(int Value);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall ButtonAppearanceChanged(System::TObject* Sender);
	HIDESBASE void __fastcall DrawBackGround(void);
	void __fastcall DrawButton(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall DoButtonClick(void);
	void __fastcall LstParentDeactivate(System::TObject* Sender);
	HIDESBASE Types::TRect __fastcall InsideRect(void);
	Types::TRect __fastcall GetItemRectangle(void);
	Types::TRect __fastcall GetButtonRectangle(void);
	HIDESBASE void __fastcall TimerEvent(System::TObject* Sender);
	virtual void __fastcall ItemAppearanceChanged(System::TObject* Sender);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall DoGraphicMouseDown(int X, int Y);
	void __fastcall DoGraphicMouseUp(int X, int Y);
	void __fastcall ItemChanged(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemChanged(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListBoxMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListBoxMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListBoxKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListBoxKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListBoxKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall ListBoxItemClick(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemSelected(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemSelectionChanged(System::TObject* Sender, int previousitemindex, int itemindex);
	void __fastcall ListBoxItemChecked(System::TObject* Sender, int itemindex, bool checked);
	void __fastcall ListBoxItemRadioClick(System::TObject* Sender, int itemindex, bool checked);
	void __fastcall ListBoxItemImageClick(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemButtonClick(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxScroll(System::TObject* Sender, double CurrentPosition, double EndPosition);
	void __fastcall ListBoxShowDetail(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxHideDetail(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemText(System::TObject* Sender, int itemindex, System::UnicodeString &itemcaption, System::UnicodeString &iteminfo, System::UnicodeString &itemnotes);
	void __fastcall ListBoxItemBkgDraw(System::TObject* Sender, Graphics::TCanvas* Canvas, int itemindex, const Types::TRect &itemRect, bool &defaultdraw);
	void __fastcall ListBoxItemDraw(System::TObject* Sender, Graphics::TCanvas* Canvas, int itemindex, const Types::TRect &itemRect, bool &defaultdraw);
	void __fastcall ListBoxAnchorClick(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall ListBoxItemAnchorClick(System::TObject* Sender, System::UnicodeString Anchor, int itemindex);
	void __fastcall ListBoxItemCaptionClick(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemInfoClick(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemMouseLeave(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxItemMouseEnter(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxLookUpClick(System::TObject* Sender, int lookupindex, System::UnicodeString lookupvalue);
	void __fastcall ListBoxItemHint(System::TObject* Sender, int itemindex, System::UnicodeString &hint);
	void __fastcall ListBoxFooterClick(System::TObject* Sender, int X, int Y);
	void __fastcall ListBoxHeaderClick(System::TObject* Sender, int X, int Y);
	void __fastcall ListBoxItemDragStart(System::TObject* Sender, int DragItemIndex, bool &allowdrag);
	void __fastcall ListBoxItemDragDrop(System::TObject* Sender, int DragItemIndex, int DropItemIndex, bool &allowdrop);
	void __fastcall ListBoxItemDragEnd(System::TObject* Sender, int DragItemIndex);
	void __fastcall ListBoxItemDragOver(System::TObject* Sender, int DragItemIndex, int DropItemIndex);
	void __fastcall ListBoxItemDblClick(System::TObject* Sender, int itemindex);
	void __fastcall ListBoxMouseActivate(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y, int HitTest, Controls::TMouseActivate &MouseActivate);
	void __fastcall ListboxMouseEnter(System::TObject* Sender);
	void __fastcall ListboxMouseLeave(System::TObject* Sender);
	void __fastcall ListBoxEnter(System::TObject* Sender);
	void __fastcall ListBoxExit(System::TObject* Sender);
	void __fastcall ListBoxClick(System::TObject* Sender);
	void __fastcall ListBoxDblClick(System::TObject* Sender);
	void __fastcall ListBoxDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall ListBoxDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall ListBoxStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall ListBoxEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall ListBoxResize(System::TObject* Sender);
	virtual Advsmoothlistbox::TAdvSmoothListBox* __fastcall CreateListBox(void);
	__property bool SkipKeyScrolling = {read=FSkipKeyScrolling, write=FSkipKeyScrolling, nodefault};
	__property Advsmoothlistbox::TAdvSmoothListBox* ListBox = {read=FListBox};
	
__published:
	__property Gdipfill::TGDIPFill* ItemBackGroundFill = {read=FFill, write=SetFill};
	__property int SelectedItemIndex = {read=FSelectedItemIndex, write=SetSelectedItemIndex, default=-1};
	__property TAdvSmoothComboBoxButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	__property bool AutoHeight = {read=FAutoHeight, write=SetAutoHeight, default=1};
	__property int DropDownHeight = {read=FDropDownHeight, write=SetDropDownHeight, default=350};
	__property int DropDownWidth = {read=FDropDownWidth, write=SetDropDownWidth, default=250};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothComboBox(HWND ParentWindow) : Advsmoothlistbox::TAdvSmoothListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Advsmoothcombobox */
using namespace Advsmoothcombobox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothcomboboxHPP
