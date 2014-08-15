// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothmegamenu.pas' rev: 21.00

#ifndef AdvsmoothmegamenuHPP
#define AdvsmoothmegamenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmooththeme.hpp>	// Pascal unit
#include <Gdipmenu.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothmegamenu
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	void __fastcall PaintCtrls(HDC DC, Controls::TControl* First);
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothMegaMenuTextRenderingHint { tAntiAlias, tAntiAliasGridFit, tClearType };
#pragma option pop

class DELPHICLASS TAdvSmoothMegaMenuItemForm;
class DELPHICLASS TAdvSmoothMegaMenu;
class DELPHICLASS TAdvSmoothMegaMenuItem;
class PASCALIMPLEMENTATION TAdvSmoothMegaMenuItemForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FFloatingEvent;
	int FPosX;
	int FPosY;
	int FParentLeft;
	int FParentTop;
	Advgdip::TGPBitmap* FMainBuffer;
	TAdvSmoothMegaMenu* FMenu;
	TAdvSmoothMegaMenuItem* FMenuItem;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall DoCMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &MSG);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Msg);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoCreate(void);
	virtual void __fastcall DoDestroy(void);
	DYNAMIC void __fastcall Paint(void);
	void __fastcall FormShow(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	bool __fastcall IsFormFloating(void);
	void __fastcall Draw(Advgdip::TGPGraphics* graphics);
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* graphics);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateForm(void);
	void __fastcall ClearControls(void);
	void __fastcall AssignControls(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(System::Byte Alpha);
	void __fastcall UpdateWindow(void);
	HIDESBASE void __fastcall SetPosition(int PosX = 0xffffffff, int PosY = 0xffffffff);
	void __fastcall DoItemSelection(System::Word Key, const Gdipmenu::TCurrentItem &SelectedItem, int &sec, int &secit);
	
public:
	void __fastcall Init(void);
	__fastcall virtual TAdvSmoothMegaMenuItemForm(Classes::TComponent* AOwner, int Dummy);
	__property TAdvSmoothMegaMenu* Menu = {read=FMenu, write=FMenu};
	__property TAdvSmoothMegaMenuItem* MenuItem = {read=FMenuItem, write=FMenuItem};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothMegaMenuItemForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothMegaMenuItemForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothMegaMenuItemForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothMegaMenuMargin;
class PASCALIMPLEMENTATION TAdvSmoothMegaMenuMargin : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothMegaMenu* FOwner;
	int FRight;
	int FBottom;
	int FTop;
	int FLeft;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetBottom(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetRight(const int Value);
	void __fastcall SetTop(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvSmoothMegaMenuMargin(TAdvSmoothMegaMenu* AOwner);
	__fastcall virtual ~TAdvSmoothMegaMenuMargin(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Left = {read=FLeft, write=SetLeft, default=3};
	__property int Top = {read=FTop, write=SetTop, default=3};
	__property int Bottom = {read=FBottom, write=SetBottom, default=3};
	__property int Right = {read=FRight, write=SetRight, default=3};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TAdvSmoothMegaMenuItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FFormDestroying;
	bool FFloating;
	TAdvSmoothMegaMenuItemForm* frm;
	Advgdip::TGPRectF FItemRect;
	Advgdip::TGPRectF FCaptionRect;
	TAdvSmoothMegaMenu* FOwner;
	bool FEnabled;
	int FWidth;
	int FHeight;
	Gdipmenu::TGDIPMenu* FMenu;
	bool FSeparator;
	System::UnicodeString FGraphicLeftDisabledName;
	System::UnicodeString FGraphicLeftSelectedName;
	System::UnicodeString FGraphicLeftName;
	System::UnicodeString FGraphicRightSelectedName;
	System::UnicodeString FGraphicLeftHoverName;
	System::UnicodeString FGraphicRightName;
	System::UnicodeString FGraphicRightHoverName;
	System::UnicodeString FGraphicRightDisabledName;
	Graphics::TFont* FCaptionFont;
	int FCaptionTop;
	int FCaptionLeft;
	System::UnicodeString FCaption;
	Gdipmenu::TGDIPMenuLocation FCaptionLocation;
	int FMenuHeight;
	bool FMenuAutoSize;
	int FMenuWidth;
	bool FPersistSelection;
	int FGraphicLeftHoverIndex;
	int FGraphicRightIndex;
	int FGraphicRightHoverIndex;
	int FGraphicLeftDisabledIndex;
	int FGraphicLeftSelectedIndex;
	int FGraphicRightDisabledIndex;
	int FGraphicLeftIndex;
	int FGraphicRightSelectedIndex;
	bool FVisible;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetMenu(const Gdipmenu::TGDIPMenu* Value);
	void __fastcall SetSeparator(const bool Value);
	void __fastcall SetGraphicLeftDisabledName(const System::UnicodeString Value);
	void __fastcall SetGraphicLeftHoverName(const System::UnicodeString Value);
	void __fastcall SetGraphicLeftName(const System::UnicodeString Value);
	void __fastcall SetGraphicLeftSelectedName(const System::UnicodeString Value);
	void __fastcall SetGraphicRightHoverName(const System::UnicodeString Value);
	void __fastcall SetGraphicRightName(const System::UnicodeString Value);
	void __fastcall SetGraphicRightSelectedName(const System::UnicodeString Value);
	void __fastcall SetGraphicRightDisabledName(const System::UnicodeString Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionLocation(const Gdipmenu::TGDIPMenuLocation Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetMenuAutoSize(const bool Value);
	void __fastcall SetMenuHeight(const int Value);
	void __fastcall SetMenuWidth(const int Value);
	Gdipmenu::TGDIPMenuSection* __fastcall GetSections(int Index);
	void __fastcall SetSections(int Index, const Gdipmenu::TGDIPMenuSection* Value);
	void __fastcall SetPersistSelection(const bool Value);
	Gdipmenu::TGDIPMenuSectionItem* __fastcall GetSectionItems(int SectionIndex, int SectionItemIndex);
	void __fastcall SetSectionItems(int SectionIndex, int SectionItemIndex, const Gdipmenu::TGDIPMenuSectionItem* Value);
	void __fastcall SetGraphicLeftDisabledIndex(const int Value);
	void __fastcall SetGraphicLeftHoverIndex(const int Value);
	void __fastcall SetGraphicLeftIndex(const int Value);
	void __fastcall SetGraphicLeftSelectedIndex(const int Value);
	void __fastcall SetGraphicRightDisabledIndex(const int Value);
	void __fastcall SetGraphicRightHoverIndex(const int Value);
	void __fastcall SetGraphicRightIndex(const int Value);
	void __fastcall SetGraphicRightSelectedIndex(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall MenuChanged(System::TObject* Sender);
	void __fastcall CaptionChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g);
	System::UnicodeString __fastcall DrawMenuItemHTMLText(Advgdip::TGPGraphics* g, Graphics::TFont* f, Gdipmenu::TGDIPMenuHTMLText* HTML, Gdipmenu::TGDIPMenuLocation Location, const Advgdip::TGPRectF &r, Advgdip::TGPRectF &htmlr, System::UnicodeString str, bool DoCalculate = false, bool DoAnchor = false, int fX = 0xffffffff, int fY = 0xffffffff);
	bool __fastcall IsFormMoving(void);
	void __fastcall UpdateFormSize(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TAdvSmoothMegaMenuItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothMegaMenuItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	bool __fastcall IsFloating(void);
	TAdvSmoothMegaMenu* __fastcall GetMenu(void);
	void __fastcall OpenMenu(void);
	void __fastcall CloseMenu(bool CloseFloating = false);
	void __fastcall FloatMenu(int X = 0xffffffff, int Y = 0xffffffff);
	void __fastcall SetMenuPosition(int X, int Y);
	__property Gdipmenu::TGDIPMenuSection* Sections[int Index] = {read=GetSections, write=SetSections};
	__property Gdipmenu::TGDIPMenuSectionItem* SectionItems[int SectionIndex][int SectionItemIndex] = {read=GetSectionItems, write=SetSectionItems};
	
__published:
	__property Gdipmenu::TGDIPMenu* Menu = {read=FMenu, write=SetMenu};
	__property bool MenuAutoSize = {read=FMenuAutoSize, write=SetMenuAutoSize, nodefault};
	__property int MenuWidth = {read=FMenuWidth, write=SetMenuWidth, default=250};
	__property int MenuHeight = {read=FMenuHeight, write=SetMenuHeight, default=150};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Gdipmenu::TGDIPMenuLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=4};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=75};
	__property int Height = {read=FHeight, write=SetHeight, default=30};
	__property bool Separator = {read=FSeparator, write=SetSeparator, default=0};
	__property System::UnicodeString GraphicLeftName = {read=FGraphicLeftName, write=SetGraphicLeftName};
	__property System::UnicodeString GraphicRightName = {read=FGraphicRightName, write=SetGraphicRightName};
	__property System::UnicodeString GraphicLeftSelectedName = {read=FGraphicLeftSelectedName, write=SetGraphicLeftSelectedName};
	__property System::UnicodeString GraphicRightSelectedName = {read=FGraphicRightSelectedName, write=SetGraphicRightSelectedName};
	__property System::UnicodeString GraphicLeftHoverName = {read=FGraphicLeftHoverName, write=SetGraphicLeftHoverName};
	__property System::UnicodeString GraphicRightHoverName = {read=FGraphicRightHoverName, write=SetGraphicRightHoverName};
	__property System::UnicodeString GraphicLeftDisabledName = {read=FGraphicLeftDisabledName, write=SetGraphicLeftDisabledName};
	__property System::UnicodeString GraphicRightDisabledName = {read=FGraphicRightDisabledName, write=SetGraphicRightDisabledName};
	__property int GraphicLeftIndex = {read=FGraphicLeftIndex, write=SetGraphicLeftIndex, default=-1};
	__property int GraphicRightIndex = {read=FGraphicRightIndex, write=SetGraphicRightIndex, default=-1};
	__property int GraphicLeftSelectedIndex = {read=FGraphicLeftSelectedIndex, write=SetGraphicLeftSelectedIndex, default=-1};
	__property int GraphicRightSelectedIndex = {read=FGraphicRightSelectedIndex, write=SetGraphicRightSelectedIndex, default=-1};
	__property int GraphicLeftHoverIndex = {read=FGraphicLeftHoverIndex, write=SetGraphicLeftHoverIndex, default=-1};
	__property int GraphicRightHoverIndex = {read=FGraphicRightHoverIndex, write=SetGraphicRightHoverIndex, default=-1};
	__property int GraphicLeftDisabledIndex = {read=FGraphicLeftDisabledIndex, write=SetGraphicLeftDisabledIndex, default=-1};
	__property int GraphicRightDisabledIndex = {read=FGraphicRightDisabledIndex, write=SetGraphicRightDisabledIndex, default=-1};
	__property bool PersistSelection = {read=FPersistSelection, write=SetPersistSelection, default=0};
};


class DELPHICLASS TAdvSmoothMegaMenuItems;
class PASCALIMPLEMENTATION TAdvSmoothMegaMenuItems : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TAdvSmoothMegaMenuItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothMegaMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothMegaMenuItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothMegaMenuItem* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	__fastcall TAdvSmoothMegaMenuItems(TAdvSmoothMegaMenu* AOwner);
	__property TAdvSmoothMegaMenuItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TAdvSmoothMegaMenuItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothMegaMenuItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothMegaMenuItems(void) { }
	
};


class DELPHICLASS TAdvSmoothMegaMenuAppearance;
class PASCALIMPLEMENTATION TAdvSmoothMegaMenuAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothMegaMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FMenuItemSeparatorFill;
	Gdipfill::TGDIPFill* FMenuItemFillHover;
	Graphics::TFont* FMenuItemFontDisabled;
	Graphics::TFont* FMenuItemFontSelected;
	Graphics::TFont* FMenuItemFont;
	Gdipfill::TGDIPFill* FMenuItemFillDisabled;
	Gdipfill::TGDIPFill* FMenuItemFillSelected;
	int FMenuItemSpacing;
	Graphics::TFont* FMenuItemFontHover;
	Gdipfill::TGDIPFill* FMenuItemFill;
	TAdvSmoothMegaMenuMargin* FMargin;
	int FMenuItemSeparatorHeight;
	int FMenuItemSeparatorWidth;
	Graphics::TColor FMenuItemShadowColor;
	Graphics::TColor FMenuItemURLColor;
	int FMenuItemShadowOffset;
	void __fastcall SetMenuItemFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMenuItemFillDisabled(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMenuItemFillHover(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMenuItemFillSelected(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMenuItemFont(const Graphics::TFont* Value);
	void __fastcall SetMenuItemFontDisabled(const Graphics::TFont* Value);
	void __fastcall SetMenuItemFontHover(const Graphics::TFont* Value);
	void __fastcall SetMenuItemFontSelected(const Graphics::TFont* Value);
	void __fastcall SetMenuItemSeparatorFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMenuItemSpacing(const int Value);
	void __fastcall SetMargin(const TAdvSmoothMegaMenuMargin* Value);
	void __fastcall SetMenuItemSeparatorHeight(const int Value);
	void __fastcall SetMenuItemSeparatorWidth(const int Value);
	void __fastcall SetMenuItemShadowColor(const Graphics::TColor Value);
	void __fastcall SetMenuItemShadowOffset(const int Value);
	void __fastcall SetMenuItemURLColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall MarginChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothMegaMenuAppearance(TAdvSmoothMegaMenu* AOwner);
	__fastcall virtual ~TAdvSmoothMegaMenuAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SaveToFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	void __fastcall LoadFromFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor MenuItemURLColor = {read=FMenuItemURLColor, write=SetMenuItemURLColor, default=16711680};
	__property Graphics::TColor MenuItemShadowColor = {read=FMenuItemShadowColor, write=SetMenuItemShadowColor, default=8421504};
	__property int MenuItemShadowOffset = {read=FMenuItemShadowOffset, write=SetMenuItemShadowOffset, default=5};
	__property Gdipfill::TGDIPFill* MenuItemFill = {read=FMenuItemFill, write=SetMenuItemFill};
	__property Gdipfill::TGDIPFill* MenuItemFillSelected = {read=FMenuItemFillSelected, write=SetMenuItemFillSelected};
	__property Gdipfill::TGDIPFill* MenuItemFillHover = {read=FMenuItemFillHover, write=SetMenuItemFillHover};
	__property Gdipfill::TGDIPFill* MenuItemFillDisabled = {read=FMenuItemFillDisabled, write=SetMenuItemFillDisabled};
	__property Graphics::TFont* MenuItemFont = {read=FMenuItemFont, write=SetMenuItemFont};
	__property Graphics::TFont* MenuItemFontSelected = {read=FMenuItemFontSelected, write=SetMenuItemFontSelected};
	__property Graphics::TFont* MenuItemFontHover = {read=FMenuItemFontHover, write=SetMenuItemFontHover};
	__property Graphics::TFont* MenuItemFontDisabled = {read=FMenuItemFontDisabled, write=SetMenuItemFontDisabled};
	__property Gdipfill::TGDIPFill* MenuItemSeparatorFill = {read=FMenuItemSeparatorFill, write=SetMenuItemSeparatorFill};
	__property int MenuItemSeparatorWidth = {read=FMenuItemSeparatorWidth, write=SetMenuItemSeparatorWidth, default=3};
	__property int MenuItemSeparatorHeight = {read=FMenuItemSeparatorHeight, write=SetMenuItemSeparatorHeight, default=50};
	__property int MenuItemSpacing = {read=FMenuItemSpacing, write=SetMenuItemSpacing, default=0};
	__property TAdvSmoothMegaMenuMargin* Margin = {read=FMargin, write=SetMargin};
};


#pragma option push -b-
enum TAdvSmoothMegaMenuDirection { mdVertical, mdHorizontal };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemClickEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemEnterEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemLeaveEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemChangeEvent)(System::TObject* Sender, int OldItemIndex, int NewItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemFloatChangeEvent)(System::TObject* Sender, bool Floating, TAdvSmoothMegaMenuItem* Menu);

#pragma option push -b-
enum TAdvSmoothMegaMenuAutoSize { asControlSize, asCaptionSize, asCustom };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothMegaMenuSubItemCheckChangedEvent)(System::TObject* Sender, TAdvSmoothMegaMenu* Menu, TAdvSmoothMegaMenuItem* MenuItem, Gdipmenu::TGDIPMenuSectionItem* item);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuSubItemEditChanged)(System::TObject* Sender, TAdvSmoothMegaMenu* Menu, TAdvSmoothMegaMenuItem* MenuItem, System::UnicodeString Text, Gdipmenu::TGDIPMenuSectionItem* item);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuSubItemEvent)(System::TObject* Sender, TAdvSmoothMegaMenu* Menu, TAdvSmoothMegaMenuItem* MenuItem, Gdipmenu::TGDIPMenuSectionItem* Item, System::UnicodeString Text);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemDropDownEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuItemCloseUpEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMegaMenuSubItemAnchorEvent)(System::TObject* Sender, TAdvSmoothMegaMenu* Menu, TAdvSmoothMegaMenuItem* MenuItem, Gdipmenu::TGDIPMenuSectionItem* Item, System::UnicodeString Anchor);

class PASCALIMPLEMENTATION TAdvSmoothMegaMenu : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAdvSmoothMegaMenuItem* FMenuItemRecall;
	bool SelectOnly;
	bool FMenuAutoOpen;
	bool FMenuIsOpen;
	bool FFocused;
	Advstyleif::TTMSStyle Fstyle;
	bool FDesignTime;
	bool FConstructed;
	bool FMouseLeave;
	bool MouseLeave;
	bool MouseEnter;
	int FFocusedItem;
	int FLastHoveredItem;
	int FHoveredItem;
	int FSelectedItem;
	TAdvSmoothMegaMenuAppearance* FAppearance;
	TAdvSmoothMegaMenuItems* FMenuItems;
	TAdvSmoothMegaMenuDirection FDirection;
	bool FTransparent;
	TAdvSmoothMegaMenuItemLeaveEvent FOnItemLeave;
	TAdvSmoothMegaMenuItemEnterEvent FOnItemEnter;
	TAdvSmoothMegaMenuItemClickEvent FOnItemClick;
	Gdipfill::TGDIPFill* FBackGroundFill;
	TAdvSmoothMegaMenuAutoSize FAutoSize;
	Gdippicturecontainer::TGDIPPictureContainer* FPictureContainer;
	Controls::TImageList* FImageList;
	TAdvSmoothMegaMenuSubItemEvent FOnSubItemClick;
	TAdvSmoothMegaMenuSubItemEvent FOnSubItemHover;
	bool FAllowSelection;
	TAdvSmoothMegaMenuSubItemEditChanged FOnSubItemEditChanged;
	TAdvSmoothMegaMenuSubItemCheckChangedEvent FOnSubItemCheckChanged;
	TAdvSmoothMegaMenuItemFloatChangeEvent FOnFloatChanged;
	Gdipmenu::TGDIPMenuSectionItemAppearance* FDefaultSectionItemAppearance;
	Gdipmenu::TGDIPMenuTopLayerItems* FDefaultTopLayerItems;
	Gdipmenu::TGDIPMenuSections* FDefaultSections;
	Gdipmenu::TGDIPMenuTopLayerItem* FDefaultTopLayerItem;
	Gdipmenu::TGDIPMenuSection* FDefaultSection;
	Gdipfill::TGDIPFill* FDefaultMenuTearOffFill;
	Gdipfill::TGDIPFill* FDefaultMenuContentFill;
	TAdvSmoothMegaMenuSubItemAnchorEvent FOnSubItemAnchorClick;
	bool FAutoOpenMenus;
	bool FPersistSelection;
	TAdvSmoothMegaMenuTextRenderingHint FTextRendering;
	bool FOpenMenusOnClick;
	TAdvSmoothMegaMenuItemDropDownEvent FOnMenuItemDropDown;
	TAdvSmoothMegaMenuItemCloseUpEvent FOnMenuItemCloseUp;
	void __fastcall SetAppearance(const TAdvSmoothMegaMenuAppearance* Value);
	void __fastcall SetMenuItems(const TAdvSmoothMegaMenuItems* Value);
	void __fastcall SetDirection(const TAdvSmoothMegaMenuDirection Value);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetBackGroundFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetAS(const TAdvSmoothMegaMenuAutoSize Value);
	void __fastcall SetPictureContainer(const Gdippicturecontainer::TGDIPPictureContainer* Value);
	void __fastcall SetDefaultSectionItemAppearance(const Gdipmenu::TGDIPMenuSectionItemAppearance* Value);
	void __fastcall SetDefaultSection(const Gdipmenu::TGDIPMenuSection* Value);
	void __fastcall SetDefaultTopLayerItem(const Gdipmenu::TGDIPMenuTopLayerItem* Value);
	void __fastcall SetDefaultMenuContentFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDefaultMenuTearOffFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetAllowSelection(const bool Value);
	void __fastcall SetAutoOpenMenus(const bool Value);
	void __fastcall SetPersistSelection(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetTextRendering(const TAdvSmoothMegaMenuTextRenderingHint Value);
	void __fastcall SetOpenMenusOnClick(const bool Value);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall MenuItemsChanged(System::TObject* Sender);
	void __fastcall InitItemRects(void);
	Types::TRect __fastcall InsideRect(void);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawMenuItems(Advgdip::TGPGraphics* g);
	int __fastcall XYToItem(int X, int Y);
	void __fastcall DoItemClick(System::TObject* Sender, int ItemIndex);
	void __fastcall DoItemEnter(System::TObject* Sender, int ItemIndex);
	void __fastcall DoItemLeave(System::TObject* Sender, int ItemIndex);
	void __fastcall DoDropDown(System::TObject* Sender, int ItemIndex);
	void __fastcall DoCloseUp(System::TObject* Sender, int ItemIndex);
	void __fastcall DoMenuSubItemClick(System::TObject* Sender, Gdipmenu::TGDIPMenuSectionItem* Item, System::UnicodeString Text);
	void __fastcall DoMenuSubItemHover(System::TObject* Sender, Gdipmenu::TGDIPMenuSectionItem* Item, System::UnicodeString Text);
	void __fastcall DoMenuSubItemEditChanged(System::TObject* Sender, System::UnicodeString Text, Gdipmenu::TGDIPMenuSectionItem* item);
	void __fastcall DoMenuSubItemCheckChanged(System::TObject* Sender, Gdipmenu::TGDIPMenuSectionItem* item);
	void __fastcall DoMenuSubItemAnchor(System::TObject* Sender, Gdipmenu::TGDIPMenuSectionItem* Item, System::UnicodeString Anchor);
	void __fastcall ShowItemForm(int item);
	void __fastcall GetLocation(double &x, double &y, const Advgdip::TGPRectF &rectangle, double objectwidth, double objectheight, Gdipmenu::TGDIPMenuLocation location);
	void __fastcall InitPreview(void);
	TAdvSmoothMegaMenuItem* __fastcall GetMenuItemFromSubMenu(Gdipmenu::TGDIPMenuSectionItem* Item);
	int __fastcall GetVersionNr(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TAdvSmoothMegaMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothMegaMenu(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall ApplyMenuItemDefault(int MenuItem, int Section, int TopLayerItem);
	void __fastcall ApplyDFstyle(void);
	void __fastcall SaveToFile(System::UnicodeString Filename);
	void __fastcall LoadFromFile(System::UnicodeString Filename, bool ApplyDefaultStyles = true);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeId(void);
	Gdippicturecontainer::TGDIPPictureContainer* __fastcall GetPictureContainer(void);
	Imglist::TCustomImageList* __fastcall GetImageList(void);
	Gdipmenu::TGDIPMenuSectionItemAppearance* __fastcall GetDefaultItemAppearance(void);
	Gdipmenu::TGDIPMenuSection* __fastcall GetDefaultSection(void);
	Gdipmenu::TGDIPMenuTopLayerItem* __fastcall GetDefaultTopLayerItem(void);
	Gdipmenu::TGDIPMenu* __fastcall GetFirstMenu(void);
	Gdipmenu::TGDIPMenu* __fastcall GetNextMenu(Gdipmenu::TGDIPMenu* Menu);
	Gdipmenu::TGDIPMenu* __fastcall GetPreviousMenu(Gdipmenu::TGDIPMenu* Menu);
	bool __fastcall HasMultipleMenus(void);
	
__published:
	__property bool OpenMenusOnClick = {read=FOpenMenusOnClick, write=SetOpenMenusOnClick, default=0};
	__property bool AutoOpenMenus = {read=FAutoOpenMenus, write=SetAutoOpenMenus, default=0};
	__property Gdipfill::TGDIPFill* DefaultMenuContentFill = {read=FDefaultMenuContentFill, write=SetDefaultMenuContentFill};
	__property Gdipfill::TGDIPFill* DefaultMenuTearOffFill = {read=FDefaultMenuTearOffFill, write=SetDefaultMenuTearOffFill};
	__property Gdipmenu::TGDIPMenuSectionItemAppearance* DefaultSectionItemAppearance = {read=FDefaultSectionItemAppearance, write=SetDefaultSectionItemAppearance};
	__property Gdipmenu::TGDIPMenuSection* DefaultSection = {read=FDefaultSection, write=SetDefaultSection};
	__property Gdipmenu::TGDIPMenuTopLayerItem* DefaultTopLayerItem = {read=FDefaultTopLayerItem, write=SetDefaultTopLayerItem};
	__property bool AllowSelection = {read=FAllowSelection, write=SetAllowSelection, default=1};
	__property bool PersistSelection = {read=FPersistSelection, write=SetPersistSelection, default=1};
	__property TAdvSmoothMegaMenuAutoSize AutoSize = {read=FAutoSize, write=SetAS, default=0};
	__property TAdvSmoothMegaMenuAppearance* ItemAppearance = {read=FAppearance, write=SetAppearance};
	__property TAdvSmoothMegaMenuItems* MenuItems = {read=FMenuItems, write=SetMenuItems};
	__property Gdipfill::TGDIPFill* BackGroundFill = {read=FBackGroundFill, write=SetBackGroundFill};
	__property TAdvSmoothMegaMenuDirection Direction = {read=FDirection, write=SetDirection, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Controls::TImageList* ImageList = {read=FImageList, write=FImageList};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FPictureContainer, write=SetPictureContainer};
	__property TAdvSmoothMegaMenuSubItemEvent OnMenuSubItemClick = {read=FOnSubItemClick, write=FOnSubItemClick};
	__property TAdvSmoothMegaMenuSubItemEvent OnMenuSubItemHover = {read=FOnSubItemHover, write=FOnSubItemHover};
	__property TAdvSmoothMegaMenuSubItemEditChanged OnMenuSubItemEditChanged = {read=FOnSubItemEditChanged, write=FOnSubItemEditChanged};
	__property TAdvSmoothMegaMenuSubItemCheckChangedEvent OnMenuSubItemCheckChanged = {read=FOnSubItemCheckChanged, write=FOnSubItemCheckChanged};
	__property TAdvSmoothMegaMenuSubItemAnchorEvent OnMenuSubItemAnchorClick = {read=FOnSubItemAnchorClick, write=FOnSubItemAnchorClick};
	__property TAdvSmoothMegaMenuItemClickEvent OnMenuItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TAdvSmoothMegaMenuItemEnterEvent OnMenuItemEnter = {read=FOnItemEnter, write=FOnItemEnter};
	__property TAdvSmoothMegaMenuItemLeaveEvent OnMenuItemLeave = {read=FOnItemLeave, write=FOnItemLeave};
	__property TAdvSmoothMegaMenuItemFloatChangeEvent OnMenuItemFloatChanged = {read=FOnFloatChanged, write=FOnFloatChanged};
	__property TAdvSmoothMegaMenuItemDropDownEvent OnMenuItemDropDown = {read=FOnMenuItemDropDown, write=FOnMenuItemDropDown};
	__property TAdvSmoothMegaMenuItemCloseUpEvent OnMenuItemCloseUp = {read=FOnMenuItemCloseUp, write=FOnMenuItemCloseUp};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvSmoothMegaMenuTextRenderingHint TextRendering = {read=FTextRendering, write=SetTextRendering, default=2};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property Align = {default=0};
	__property ShowHint;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseDown;
	__property OnStartDock;
	__property OnStartDrag;
	__property PopupMenu;
	__property Visible = {default=1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothMegaMenu(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ITMSMegaMenu;	/* Gdipmenu::ITMSMegaMenu */
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipmenu::_di_ITMSMegaMenu()
	{
		Gdipmenu::_di_ITMSMegaMenu intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSMegaMenu*(void) { return (ITMSMegaMenu*)&__ITMSMegaMenu; }
	#endif
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
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x8;
static const ShortInt BLD_VER = 0x0;
static const Word WM_RECALLFLOATINGFORM = 0x46f;

}	/* namespace Advsmoothmegamenu */
using namespace Advsmoothmegamenu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothmegamenuHPP
