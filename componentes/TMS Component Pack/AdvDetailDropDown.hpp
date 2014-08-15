// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdetaildropdown.pas' rev: 21.00

#ifndef AdvdetaildropdownHPP
#define AdvdetaildropdownHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Asghtmle.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdetaildropdown
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDetailItem;
class PASCALIMPLEMENTATION TDetailItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	bool FEnabled;
	Graphics::TPicture* FImage;
	Types::TRect FRect;
	System::UnicodeString FNotes;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetImage(const Graphics::TPicture* Value);
	void __fastcall SetImageIndex(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	__property Types::TRect Rect = {read=FRect, write=FRect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	
public:
	__fastcall virtual TDetailItem(Classes::TCollection* Collection);
	__fastcall virtual ~TDetailItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Graphics::TPicture* Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Notes = {read=FNotes, write=FNotes};
};


class DELPHICLASS TDetailItems;
class PASCALIMPLEMENTATION TDetailItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TDetailItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TDetailItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDetailItem* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TDetailItems(Classes::TPersistent* AOwner);
	__property TDetailItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TDetailItem* __fastcall Add(void);
	HIDESBASE TDetailItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	int __fastcall IndexOf(System::UnicodeString AValue);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDetailItems(void) { }
	
};


class DELPHICLASS TAdvDetailDropDown;
class PASCALIMPLEMENTATION TAdvDetailDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	Advdropdown::TAdvCustomItemSelector* FItemSelector;
	Advdropdown::TItemLayout FLayout;
	TDetailItems* FItems;
	int FItemIndex;
	Classes::TNotifyEvent FOnSelect;
	Advdropdown::TOnDrawSelectedItem FOnDrawSelectedImage;
	Advdropdown::TItemAppearance* FItemAppearance;
	bool FInternalCall;
	Extctrls::TTimer* FKeyTimer;
	System::UnicodeString FCurSearch;
	int FOldItemIndex;
	int FItemHeight;
	Graphics::TFont* FCaptionFont;
	Graphics::TFont* FNotesFont;
	bool FWorkMode;
	bool FItemChange;
	int FItemIdx;
	int FItemSel;
	System::UnicodeString FOldValue;
	bool FMatchCase;
	bool FMatchStart;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall OnItemsChanged(System::TObject* Sender);
	void __fastcall OnSelectorItemSelect(System::TObject* Sender);
	void __fastcall OnKeyTimerTime(System::TObject* Sender);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetLayout(const Advdropdown::TItemLayout Value);
	void __fastcall SetItems(const TDetailItems* Value);
	void __fastcall AssignedItemsToItemSelector(void);
	void __fastcall SetSelectorProperties(void);
	void __fastcall SetItemAppearance(const Advdropdown::TItemAppearance* Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetNotesFont(const Graphics::TFont* Value);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall DoHideDropDown(bool Cancelled);
	virtual void __fastcall DoShowDropDown(void);
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall SetSelectionColorStyle(const Advdropdown::TSelectionColorStyle Value);
	void __fastcall DrawItem(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R, int Index);
	void __fastcall ItemSize(System::TObject* Sender, tagSIZE &ASize);
	void __fastcall DropDownResize(System::TObject* Sender);
	virtual void __fastcall OnDropDownSizing(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall HandleMouseWheelDown(void);
	virtual void __fastcall HandleMouseWheelUp(void);
	
public:
	__fastcall virtual TAdvDetailDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvDetailDropDown(void);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall SelectPrevious(void);
	__property bool MatchCase = {read=FMatchCase, write=FMatchCase, default=0};
	__property bool MatchStart = {read=FMatchStart, write=FMatchStart, default=1};
	
__published:
	__property TDetailItems* Items = {read=FItems, write=SetItems};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property int ItemHeight = {read=FItemHeight, write=FItemHeight, default=22};
	__property Advdropdown::TItemLayout Layout = {read=FLayout, write=SetLayout, default=1};
	__property Advdropdown::TItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Graphics::TFont* NotesFont = {read=FNotesFont, write=SetNotesFont};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownColor = {default=16777215};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownButtonGlyph;
	__property EditorEnabled = {default=1};
	__property Enabled = {default=1};
	__property Font;
	__property Images;
	__property Version;
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property Advdropdown::TOnDrawSelectedItem OnDrawSelectedImage = {read=FOnDrawSelectedImage, write=FOnDrawSelectedImage};
	__property OnEnter;
	__property OnExit;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnBeforeDropDown;
	__property OnDropDown;
	__property OnDropUp;
	__property OnDropDownHeaderButtonClick;
	__property OnDropDownFooterButtonClick;
	__property OnDrawHeader;
	__property OnDrawFooter;
	__property OnGetHeaderText;
	__property OnGetFooterText;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDetailDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advdetaildropdown */
using namespace Advdetaildropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdetaildropdownHPP
