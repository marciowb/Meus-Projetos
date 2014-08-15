// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advstickypopupmenu.pas' rev: 21.00

#ifndef AdvstickypopupmenuHPP
#define AdvstickypopupmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advmenus.hpp>	// Pascal unit
#include <Atbxpvs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advstickypopupmenu
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TStickyMenuItemStyle { isMenuItem, isCheckBox, isRadioButton, isSplitter, isControlItem };
#pragma option pop

#pragma option push -b-
enum TAdvControlStyle { csClassic, csFlat, csTMS, csGlyph, csTheme, csWinXP, csBorland };
#pragma option pop

#pragma option push -b-
enum TDisplayRelative { drScreen, drForm };
#pragma option pop

typedef void __fastcall (__closure *TItemClickEvent)(System::TObject* Sender, int Index);

typedef void __fastcall (__closure *TCheckClickEvent)(System::TObject* Sender, int Index, bool Checked);

typedef void __fastcall (__closure *TOnDrawImage)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &ARect, bool Selected);

typedef void __fastcall (__closure *TOnDrawItem)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &ARect, bool Selected);

typedef void __fastcall (__closure *TOnHideQuery)(System::TObject* Sender, bool &CanHide);

class DELPHICLASS TStickyMenuItem;
class PASCALIMPLEMENTATION TStickyMenuItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FHideOnClick;
	bool FEnabled;
	int FImageIndex;
	int FTag;
	System::UnicodeString FCaption;
	Classes::TComponent* FControl;
	System::TObject* FItemObject;
	TStickyMenuItemStyle FStyle;
	bool FAutoCheck;
	bool FChecked;
	Classes::TNotifyEvent FOnClick;
	TOnDrawImage FOnDrawImage;
	TOnDrawItem FOnDrawItem;
	int FGroupIndex;
	bool FVisible;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetControl(const Classes::TComponent* Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetHideOnClick(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetItemObject(const System::TObject* Value);
	void __fastcall SetStyle(const TStickyMenuItemStyle Value);
	void __fastcall SetAutoCheck(const bool Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall UpdateExclusive(void);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	void __fastcall Click(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TStickyMenuItem(Classes::TCollection* Collection);
	__fastcall virtual ~TStickyMenuItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::TObject* ItemObject = {read=FItemObject, write=SetItemObject};
	
__published:
	__property bool AutoCheck = {read=FAutoCheck, write=SetAutoCheck, default=1};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property TStickyMenuItemStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property Classes::TComponent* Control = {read=FControl, write=SetControl};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool HideOnClick = {read=FHideOnClick, write=SetHideOnClick, default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TOnDrawImage OnDrawImage = {read=FOnDrawImage, write=FOnDrawImage};
	__property TOnDrawItem OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
};


class DELPHICLASS TStickyMenuItems;
class DELPHICLASS TAdvStickyPopupMenu;
class PASCALIMPLEMENTATION TStickyMenuItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TStickyMenuItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvStickyPopupMenu* FOwner;
	Classes::TNotifyEvent FOnVisibleChanged;
	HIDESBASE TStickyMenuItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TStickyMenuItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnVisibleChanged = {read=FOnVisibleChanged, write=FOnVisibleChanged};
	
public:
	__fastcall TStickyMenuItems(Classes::TPersistent* AOwner);
	__property TStickyMenuItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TStickyMenuItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TStickyMenuItem* __fastcall Insert(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TStickyMenuItems(void) { }
	
};


class DELPHICLASS TButtonBarItem;
class PASCALIMPLEMENTATION TButtonBarItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	int FTag;
	System::UnicodeString FCaption;
	bool FHideOnClick;
	Classes::TNotifyEvent FOnClick;
	bool FEnabled;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	int __fastcall GetLeft(void);
	int __fastcall GetWidth(void);
	void __fastcall SetHideOnClick(const bool Value);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	void __fastcall Click(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TButtonBarItem(Classes::TCollection* Collection);
	__fastcall virtual ~TButtonBarItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int Width = {read=GetWidth, nodefault};
	__property int Left = {read=GetLeft, nodefault};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool HideOnClick = {read=FHideOnClick, write=SetHideOnClick, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
};


class DELPHICLASS TButtonBar;
class PASCALIMPLEMENTATION TButtonBar : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TButtonBarItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvStickyPopupMenu* FOwner;
	HIDESBASE TButtonBarItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TButtonBarItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TButtonBar(Classes::TPersistent* AOwner);
	__property TButtonBarItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TButtonBarItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TButtonBarItem* __fastcall Insert(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TButtonBar(void) { }
	
};


class DELPHICLASS TAdvStickyMenuPanel;
class PASCALIMPLEMENTATION TAdvStickyMenuPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TComponent* FOwner;
	Classes::TNotifyEvent FOnShouldHide;
	bool FShowBorder;
	TAdvStickyPopupMenu* FAdvStickyPopupMenu;
	int FButtonIndexHot;
	int FButtonIndexDown;
	int FMenuItemIndexHot;
	int FMenuItemIndexDown;
	bool FMouseOnIconBar;
	bool FDonotHideMenu;
	int FUpdateCount;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	void __fastcall OnMenuItemsVisibleChanged(System::TObject* Sender);
	Advmenus::TCustomAdvMenuStyler* __fastcall GetStyler(void);
	void __fastcall ButtonClick(int Index);
	void __fastcall MenuItemClick(int Index);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall DrawIconBar(Graphics::TCanvas* Canvas);
	void __fastcall DrawButtonBar(Graphics::TCanvas* Canvas);
	void __fastcall DrawButton(Graphics::TCanvas* Canvas, int Index);
	void __fastcall DrawItemsBackGround(Graphics::TCanvas* Canvas);
	void __fastcall DrawItems(Graphics::TCanvas* Canvas);
	void __fastcall DrawItem(Graphics::TCanvas* Canvas, int Index);
	void __fastcall InvalidateButton(int Index);
	int __fastcall ButtonAtPos(int X, int Y);
	int __fastcall ItemAtPos(int X, int Y);
	void __fastcall SelectItem(int Index);
	void __fastcall HideMenuWindow(void);
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	bool __fastcall ButtonBarVisible(void);
	int __fastcall GetTotalButtonsWidth(void);
	int __fastcall GetButtonBarHeight(void);
	TStickyMenuItem* __fastcall GetMaxItemWidth(int &ItemWidth);
	int __fastcall GetTotalItemsHeight(void);
	Types::TRect __fastcall GetButtonBarRect(void);
	Types::TRect __fastcall GetButtonRect(int Index);
	Types::TRect __fastcall GetClientRectEx(void);
	int __fastcall GetItemHeight(void);
	Types::TRect __fastcall GetItemsRect(void);
	Types::TRect __fastcall GetItemRect(int Index, Types::TRect &ItemWithCtrlRect)/* overload */;
	Types::TRect __fastcall GetItemRect(int Index)/* overload */;
	void __fastcall InitializeAndUpdate(void);
	TStickyMenuItem* __fastcall FindMenuItemFromAccel(System::Word Accel);
	TButtonBarItem* __fastcall FindButtonFromAccel(System::Word Accel);
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	TButtonBar* __fastcall ButtonBar(void);
	TStickyMenuItems* __fastcall MenuItems(void);
	__property Advmenus::TCustomAdvMenuStyler* Styler = {read=GetStyler};
	
public:
	__fastcall virtual TAdvStickyMenuPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvStickyMenuPanel(void);
	Types::TRect __fastcall GetIconBarRect(void);
	void __fastcall InvalidateMenuItem(int Index);
	__property int MenuItemIndexHot = {read=FMenuItemIndexHot, nodefault};
	__property TAdvStickyPopupMenu* AdvStickyPopupMenu = {read=FAdvStickyPopupMenu, write=FAdvStickyPopupMenu};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvStickyMenuPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvStickyMenuWindow;
class PASCALIMPLEMENTATION TAdvStickyMenuWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	bool FHideOnDeActivate;
	Classes::TComponent* FOwner;
	bool FShowBorder;
	Extctrls::TTimer* FHideTimer;
	Graphics::TColor FBorderColor;
	TAdvStickyMenuPanel* FAdvStickyMenuPanel;
	TOnHideQuery FOnHideQuery;
	TAdvStickyPopupMenu* FAdvStickyPopupMenu;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall UpdateSize(void);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	__property TAdvStickyMenuPanel* AdvStickyMenuPanel = {read=FAdvStickyMenuPanel, write=FAdvStickyMenuPanel};
	__property TAdvStickyPopupMenu* AdvStickyPopupMenu = {read=FAdvStickyPopupMenu, write=FAdvStickyPopupMenu};
	
public:
	__fastcall virtual TAdvStickyMenuWindow(Classes::TComponent* AOwner);
	__fastcall virtual TAdvStickyMenuWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TAdvStickyMenuWindow(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TOnHideQuery OnHideQuery = {read=FOnHideQuery, write=FOnHideQuery};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvStickyMenuWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvStickyPopupMenu : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TComponent* FOwner;
	Advmenus::TCustomAdvMenuStyler* FStyler;
	Advmenus::TCustomAdvMenuStyler* FInternalStyler;
	Advmenus::TCustomAdvMenuStyler* FCurrentStyler;
	Imglist::TCustomImageList* FButtonImages;
	TStickyMenuItems* FMenuItems;
	TButtonBar* FButtonBar;
	TAdvStickyMenuPanel* FStickyMenuPanel;
	TAdvStickyMenuWindow* FStickyMenuWindow;
	Imglist::TCustomImageList* FItemImages;
	int FItemOffSetX;
	int FItemOffSetY;
	int FItemMarginX;
	int FItemMarginY;
	bool FIsVisible;
	TItemClickEvent FOnRadioClick;
	TCheckClickEvent FOnCheckClick;
	TItemClickEvent FOnButtonClick;
	TItemClickEvent FOnItemClick;
	TDisplayRelative FDisplayRelative;
	Classes::TNotifyEvent FOnMenuHide;
	Classes::TNotifyEvent FOnMenuShow;
	bool FShowButtonBar;
	TOnHideQuery FOnMenuHideQuery;
	void __fastcall OnStickyMenuWindowHide(System::TObject* Sender);
	void __fastcall OnStickyMenuWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall OnStickyMenuWindowHideQuery(System::TObject* Sender, bool &CanHide);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetButtonImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetStyler(const Advmenus::TCustomAdvMenuStyler* Value);
	void __fastcall SetMenuItems(const TStickyMenuItems* Value);
	void __fastcall SetButtonBar(const TButtonBar* Value);
	void __fastcall SetItemImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetShowButtonBar(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall InitializeMenu(void);
	
public:
	__fastcall virtual TAdvStickyPopupMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvStickyPopupMenu(void);
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	int __fastcall GetVersionNr(void);
	void __fastcall ShowMenu(int X, int Y);
	void __fastcall HideMenu(void);
	__property bool IsVisible = {read=FIsVisible, write=FIsVisible, nodefault};
	__property TAdvStickyMenuPanel* MenuPanel = {read=FStickyMenuPanel};
	
__published:
	__property TButtonBar* ButtonBar = {read=FButtonBar, write=SetButtonBar};
	__property TDisplayRelative DisplayRelative = {read=FDisplayRelative, write=FDisplayRelative, default=0};
	__property Imglist::TCustomImageList* ButtonImages = {read=FButtonImages, write=SetButtonImages};
	__property Imglist::TCustomImageList* ItemImages = {read=FItemImages, write=SetItemImages};
	__property TStickyMenuItems* MenuItems = {read=FMenuItems, write=SetMenuItems};
	__property bool ShowButtonBar = {read=FShowButtonBar, write=SetShowButtonBar, default=1};
	__property Advmenus::TCustomAdvMenuStyler* Styler = {read=FStyler, write=SetStyler};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TOnHideQuery OnMenuHideQuery = {read=FOnMenuHideQuery, write=FOnMenuHideQuery};
	__property TItemClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property TItemClickEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TCheckClickEvent OnCheckClick = {read=FOnCheckClick, write=FOnCheckClick};
	__property TItemClickEvent OnRadioClick = {read=FOnRadioClick, write=FOnRadioClick};
	__property Classes::TNotifyEvent OnMenuShow = {read=FOnMenuShow, write=FOnMenuShow};
	__property Classes::TNotifyEvent OnMenuHide = {read=FOnMenuHide, write=FOnMenuHide};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;
static const ShortInt BTNOFFSET_X = 0x4;
static const ShortInt BTN_SPACE = 0x1;
static const ShortInt IMG_GAP = 0x3;
static const ShortInt ITEM_SPACE = 0x1;
static const ShortInt MIN_MENUWIDTH = 0x50;
static const ShortInt MIN_MENUHEIGHT = 0x32;
static const ShortInt ROUND_RADIUS = 0x2;
static const ShortInt CHECK_SIZE = 0xf;
static const ShortInt RADIO_SIZE = 0xa;
static const ShortInt SEPARATOR_SIZE = 0x5;

}	/* namespace Advstickypopupmenu */
using namespace Advstickypopupmenu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvstickypopupmenuHPP
