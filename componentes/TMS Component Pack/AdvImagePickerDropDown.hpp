// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advimagepickerdropdown.pas' rev: 21.00

#ifndef AdvimagepickerdropdownHPP
#define AdvimagepickerdropdownHPP

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
#include <Advstyleif.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advimagepickerdropdown
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImageItem;
class PASCALIMPLEMENTATION TImageItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	bool FEnabled;
	Graphics::TPicture* FImage;
	Types::TRect FRect;
	System::UnicodeString FHint;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetImage(const Graphics::TPicture* Value);
	void __fastcall SetImageIndex(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	__property Types::TRect Rect = {read=FRect, write=FRect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	
public:
	__fastcall virtual TImageItem(Classes::TCollection* Collection);
	__fastcall virtual ~TImageItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Graphics::TPicture* Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
};


class DELPHICLASS TImageItems;
class PASCALIMPLEMENTATION TImageItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TImageItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TImageItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TImageItem* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TImageItems(Classes::TPersistent* AOwner);
	__property TImageItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TImageItem* __fastcall Add(void);
	HIDESBASE TImageItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TImageItems(void) { }
	
};


class DELPHICLASS TAdvImagePickerDropDown;
class PASCALIMPLEMENTATION TAdvImagePickerDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	Advdropdown::TAdvCustomItemSelector* FItemSelector;
	int FColumns;
	Advdropdown::TItemLayout FLayout;
	TImageItems* FItems;
	int FItemIndex;
	Classes::TNotifyEvent FOnSelect;
	Advdropdown::TOnDrawSelectedItem FOnDrawSelectedImage;
	Advdropdown::TItemAppearance* FItemAppearance;
	bool FInternalCall;
	Extctrls::TTimer* FKeyTimer;
	System::UnicodeString FCurSearch;
	int FOldItemIndex;
	Advdropdown::TDrawItemEvent FOnDrawItem;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall DrawSelectedImage(void);
	void __fastcall OnItemsChanged(System::TObject* Sender);
	void __fastcall OnSelectorItemSelect(System::TObject* Sender);
	void __fastcall OnKeyTimerTime(System::TObject* Sender);
	void __fastcall OnItemSelectorDrawItem(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R, int Index);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetLayout(const Advdropdown::TItemLayout Value);
	void __fastcall SetItems(const TImageItems* Value);
	void __fastcall AssignedItemsToItemSelector(void);
	void __fastcall SetSelectorProperties(void);
	void __fastcall SetItemAppearance(const Advdropdown::TItemAppearance* Value);
	int __fastcall GetImageIndex(void);
	void __fastcall SetImageIndex(const int Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall SetSelectionColorStyle(const Advdropdown::TSelectionColorStyle Value);
	virtual void __fastcall HandleMouseWheelDown(void);
	virtual void __fastcall HandleMouseWheelUp(void);
	virtual void __fastcall DrawBackGround(void);
	
public:
	__fastcall virtual TAdvImagePickerDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvImagePickerDropDown(void);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall SelectPrevious(void);
	void __fastcall AddImagesFromFolder(System::UnicodeString AFolder, bool SetImageCaption = false);
	void __fastcall AddImagesFromImageList(void);
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, nodefault};
	
__published:
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property TImageItems* Items = {read=FItems, write=SetItems};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property Advdropdown::TItemLayout Layout = {read=FLayout, write=SetLayout, default=1};
	__property Advdropdown::TItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
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
	__property Cursor = {default=-2};
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
	__property DropDownSizeable = {default=1};
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
	__property Advdropdown::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvImagePickerDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advimagepickerdropdown */
using namespace Advimagepickerdropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvimagepickerdropdownHPP
