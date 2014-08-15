// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Imagepicker.pas' rev: 21.00

#ifndef ImagepickerHPP
#define ImagepickerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advcombo.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Imagepicker
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImagePickerItem;
class PASCALIMPLEMENTATION TImagePickerItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	System::UnicodeString FCaption;
	int FTag;
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TImagePickerItem(Classes::TCollection* Collection);
	__fastcall virtual ~TImagePickerItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TImagePickerItemCollection;
class DELPHICLASS TImagePicker;
class PASCALIMPLEMENTATION TImagePickerItemCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TImagePickerItem* operator[](int Index) { return Items[Index]; }
	
private:
	TImagePicker* FOwner;
	HIDESBASE TImagePickerItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TImagePickerItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TImagePickerItem* __fastcall Add(void);
	HIDESBASE TImagePickerItem* __fastcall Insert(int index);
	__property TImagePickerItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TImagePickerItemCollection(TImagePicker* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	int __fastcall IndexOf(System::UnicodeString s);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TImagePickerItemCollection(void) { }
	
};


class PASCALIMPLEMENTATION TImagePicker : public Advcombo::TAdvCustomCombo
{
	typedef Advcombo::TAdvCustomCombo inherited;
	
private:
	Controls::TImageList* FImages;
	int FDropHeight;
	int FEditHeight;
	TImagePickerItemCollection* FImagePickerItems;
	int FEditColumn;
	int FItemIndex;
	int FUpdateCount;
	System::UnicodeString FLookup;
	bool FLookupIncr;
	bool FSortedEx;
	bool FDropped;
	bool FShowCaption;
	void __fastcall SetEditHeight(int Value);
	int __fastcall GetEditHeight(void);
	void __fastcall SetImages(const Controls::TImageList* Value);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	void __fastcall SetItemIndexEx(const int Value);
	int __fastcall GetItemIndexEx(void);
	void __fastcall BuildItems(void);
	bool __fastcall GetSortedEx(void);
	void __fastcall SetSortedEx(const bool Value);
	void __fastcall Sort(void);
	System::WideChar __fastcall GetDelimiter(void);
	void __fastcall SetDelimiter(const System::WideChar Value);
	Classes::TStrings* __fastcall GetComboItems(void);
	void __fastcall SetComboItems(const Classes::TStrings* Value);
	TImagePickerItem* __fastcall GetSelection(void);
	System::UnicodeString __fastcall GetCaption(System::UnicodeString Value);
	void __fastcall SetShowCaption(const bool Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall SetStyle(Stdctrls::TComboBoxStyle Value);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property Classes::TStrings* ComboItems = {read=GetComboItems, write=SetComboItems};
	
public:
	__fastcall virtual TImagePicker(Classes::TComponent* AOwner);
	__fastcall virtual ~TImagePicker(void);
	virtual void __fastcall Loaded(void);
	__property Text;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SelectByCaption(const System::UnicodeString Value);
	void __fastcall SelectByImageIdx(const int Value);
	void __fastcall SelectByTag(const int Value);
	__property System::WideChar Delimiter = {read=GetDelimiter, write=SetDelimiter, nodefault};
	__property TImagePickerItem* Selection = {read=GetSelection};
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property Color;
	__property Ctl3D;
	__property TImagePickerItemCollection* Items = {read=FImagePickerItems, write=FImagePickerItems};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property int EditHeight = {read=GetEditHeight, write=SetEditHeight, nodefault};
	__property int DropHeight = {read=FDropHeight, write=FDropHeight, nodefault};
	__property DropWidth;
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Enabled;
	__property Etched = {default=0};
	__property Flat = {default=0};
	__property FlatLineColor = {default=0};
	__property FocusBorder = {default=0};
	__property Font;
	__property int ItemIndex = {read=GetItemIndexEx, write=SetItemIndexEx, nodefault};
	__property ItemHeight;
	__property bool LookupIncr = {read=FLookupIncr, write=FLookupIncr, default=0};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=0};
	__property bool Sorted = {read=GetSortedEx, write=SetSortedEx, nodefault};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TImagePicker(HWND ParentWindow) : Advcombo::TAdvCustomCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const WideChar COLUMN_DELIMITER = (WideChar)(0x7c);
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Imagepicker */
using namespace Imagepicker;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ImagepickerHPP
