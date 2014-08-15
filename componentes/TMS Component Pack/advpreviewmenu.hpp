// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpreviewmenu.pas' rev: 21.00

#ifndef AdvpreviewmenuHPP
#define AdvpreviewmenuHPP

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
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpreviewmenu
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TProCustomGlowButton;
class PASCALIMPLEMENTATION TProCustomGlowButton : public Advglowbutton::TAdvCustomGlowButton
{
	typedef Advglowbutton::TAdvCustomGlowButton inherited;
	
public:
	/* TAdvCustomGlowButton.Create */ inline __fastcall virtual TProCustomGlowButton(Classes::TComponent* AOwner) : Advglowbutton::TAdvCustomGlowButton(AOwner) { }
	/* TAdvCustomGlowButton.Destroy */ inline __fastcall virtual ~TProCustomGlowButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProCustomGlowButton(HWND ParentWindow) : Advglowbutton::TAdvCustomGlowButton(ParentWindow) { }
	
};


#pragma option push -b-
enum TDrawPosition { dwpLeft, dwpTop, dwpRight, dwpBottom };
#pragma option pop

#pragma option push -b-
enum TVAlign { tvaTop, tvaCenter };
#pragma option pop

class DELPHICLASS TButtonItemActionLink;
class DELPHICLASS TButtonCollectionItem;
class PASCALIMPLEMENTATION TButtonItemActionLink : public Actnlist::TActionLink
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TButtonCollectionItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHelpContextLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsShortCutLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TButtonItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TButtonItemActionLink(void) { }
	
};


typedef TMetaClass* TButtonItemActionLinkClass;

typedef void __fastcall (__closure *TButtonItemClickEvent)(System::TObject* Sender, TButtonCollectionItem* Button);

class PASCALIMPLEMENTATION TButtonCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	bool FVisible;
	int FTag;
	int FImageIndex;
	bool FEnabled;
	Gdipicture::TGDIPPicture* FIPicture;
	Gdipicture::TGDIPPicture* FIDisabledPicture;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Graphics::TFont* FFont;
	int FWidth;
	TButtonItemClickEvent FOnClick;
	TButtonItemActionLink* FActionLink;
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	Classes::TBasicAction* __fastcall GetAction(void);
	void __fastcall SetAction(const Classes::TBasicAction* Value);
	void __fastcall DoActionChange(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetIndex(int Value);
	void __fastcall Refresh(void);
	DYNAMIC TButtonItemActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	__property TButtonItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	
public:
	__fastcall virtual TButtonCollectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TButtonCollectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Gdipicture::TGDIPPicture* DisabledPicture = {read=FIDisabledPicture, write=SetDisabledPicture};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property TButtonItemClickEvent OnClick = {read=FOnClick, write=FOnClick};
};


class DELPHICLASS TButtonCollection;
class DELPHICLASS TAdvPreviewMenu;
class PASCALIMPLEMENTATION TButtonCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TButtonCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	TAdvPreviewMenu* FPreviewMenu;
	HIDESBASE TButtonCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TButtonCollectionItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TButtonCollection(Classes::TPersistent* AOwner);
	__property TButtonCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TButtonCollectionItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TButtonCollectionItem* __fastcall Insert(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TButtonCollection(void) { }
	
};


class DELPHICLASS TSubItemActionLink;
class DELPHICLASS TAdvPreviewSubMenuItem;
class PASCALIMPLEMENTATION TSubItemActionLink : public Actnlist::TActionLink
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TAdvPreviewSubMenuItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHelpContextLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsShortCutLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TSubItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TSubItemActionLink(void) { }
	
};


typedef TMetaClass* TSubItemActionLinkClass;

class PASCALIMPLEMENTATION TAdvPreviewSubMenuItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FTitle;
	int FImageIndex;
	bool FEnabled;
	Gdipicture::TGDIPPicture* FIPicture;
	Gdipicture::TGDIPPicture* FIDisabledPicture;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Classes::TStringList* FNotes;
	Menus::TPopupMenu* FSubMenu;
	System::UnicodeString FShortCutHint;
	bool FShortCutHintShowing;
	Classes::TNotifyEvent FOnClick;
	bool FVisible;
	TSubItemActionLink* FActionLink;
	int FTag;
	System::WideString FWideTitle;
	System::WideString FWideNotes;
	bool FSeparator;
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetNotes(const Classes::TStringList* Value);
	void __fastcall SetSubMenu(const Menus::TPopupMenu* Value);
	Classes::TBasicAction* __fastcall GetAction(void);
	void __fastcall SetAction(Classes::TBasicAction* Value);
	void __fastcall DoActionChange(System::TObject* Sender);
	bool __fastcall IsTitleStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsOnClickStored(void);
	bool __fastcall IsVisibleStored(void);
	void __fastcall SetWideTitle(const System::WideString Value);
	void __fastcall SetWideNotes(const System::WideString Value);
	void __fastcall SetSeparator(const bool Value);
	
protected:
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	void __fastcall Loaded(void);
	DYNAMIC TSubItemActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	__property TSubItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetIndex(int Value);
	__property bool ShortCutHintShowing = {read=FShortCutHintShowing, write=FShortCutHintShowing, nodefault};
	
public:
	__fastcall virtual TAdvPreviewSubMenuItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvPreviewSubMenuItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall InitiateAction(void);
	void __fastcall Click(void);
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle, stored=IsTitleStored};
	__property System::WideString WideTitle = {read=FWideTitle, write=SetWideTitle};
	__property Classes::TStringList* Notes = {read=FNotes, write=SetNotes};
	__property System::WideString WideNotes = {read=FWideNotes, write=SetWideNotes};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property Gdipicture::TGDIPPicture* DisabledPicture = {read=FIDisabledPicture, write=SetDisabledPicture};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property bool Separator = {read=FSeparator, write=SetSeparator, default=0};
	__property Menus::TPopupMenu* SubMenu = {read=FSubMenu, write=SetSubMenu};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHint, write=FShortCutHint};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Visible = {read=FVisible, write=FVisible, stored=IsVisibleStored, nodefault};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
};


class DELPHICLASS TAdvPreviewSubMenuItems;
class PASCALIMPLEMENTATION TAdvPreviewSubMenuItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvPreviewSubMenuItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	TAdvPreviewMenu* FPreviewMenu;
	HIDESBASE TAdvPreviewSubMenuItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvPreviewSubMenuItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvPreviewSubMenuItems(Classes::TPersistent* AOwner);
	__property TAdvPreviewSubMenuItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TAdvPreviewSubMenuItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TAdvPreviewSubMenuItem* __fastcall Insert(int Index);
	void __fastcall InitiateActions(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvPreviewSubMenuItems(void) { }
	
};


class DELPHICLASS TItemActionLink;
class DELPHICLASS TAdvPreviewMenuItem;
class PASCALIMPLEMENTATION TItemActionLink : public Actnlist::TActionLink
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TAdvPreviewMenuItem* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHelpContextLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsShortCutLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual bool __fastcall IsOnExecuteLinked(void);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetVisible(bool Value);
	virtual void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TItemActionLink(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TItemActionLink(void) { }
	
};


typedef TMetaClass* TItemActionLinkClass;

class PASCALIMPLEMENTATION TAdvPreviewMenuItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	int FTag;
	int FImageIndex;
	bool FEnabled;
	Gdipicture::TGDIPPicture* FIPicture;
	Gdipicture::TGDIPPicture* FIDisabledPicture;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	TAdvPreviewSubMenuItems* FSubItems;
	System::UnicodeString FSubMenuCaption;
	bool FSeparator;
	int FSubMenuItemSpacing;
	int FSubMenuItemIndex;
	bool FCanSelect;
	System::UnicodeString FShortCutSubItemsHint;
	System::UnicodeString FShortCutHint;
	bool FShortCutHintShowing;
	bool FShortCutSubItemHintShowing;
	Classes::TNotifyEvent FOnClick;
	bool FVisible;
	TItemActionLink* FActionLink;
	System::WideString FWideCaption;
	System::WideString FWideSubMenuCaption;
	int FSubMenuItemHeight;
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetSubItems(const TAdvPreviewSubMenuItems* Value);
	void __fastcall SetSubMenuCaption(const System::UnicodeString Value);
	void __fastcall SetSeparator(const bool Value);
	void __fastcall SetSubMenuItemSpacing(const int Value);
	void __fastcall SetSubMenuItemIndex(const int Value);
	Classes::TBasicAction* __fastcall GetAction(void);
	void __fastcall SetAction(Classes::TBasicAction* Value);
	void __fastcall DoActionChange(System::TObject* Sender);
	bool __fastcall IsCaptionStored(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsImageIndexStored(void);
	bool __fastcall IsOnClickStored(void);
	bool __fastcall IsVisibleStored(void);
	void __fastcall SetWideCaption(const System::WideString Value);
	void __fastcall SetWideSubMenuCaption(const System::WideString Value);
	void __fastcall SetSubMenuItemHeight(const int Value);
	
protected:
	virtual void __fastcall AssignTo(Classes::TPersistent* Dest);
	void __fastcall Loaded(void);
	DYNAMIC TItemActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	__property TItemActionLink* ActionLink = {read=FActionLink, write=FActionLink};
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetIndex(int Value);
	__property bool ShortCutHintShowing = {read=FShortCutHintShowing, write=FShortCutHintShowing, nodefault};
	__property bool ShortCutSubItemHintShowing = {read=FShortCutSubItemHintShowing, write=FShortCutSubItemHintShowing, nodefault};
	__property int SubMenuItemIndex = {read=FSubMenuItemIndex, write=SetSubMenuItemIndex, nodefault};
	
public:
	__fastcall virtual TAdvPreviewMenuItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvPreviewMenuItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall InitiateAction(void);
	void __fastcall Click(void);
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property bool CanSelect = {read=FCanSelect, write=FCanSelect, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, stored=IsImageIndexStored, default=-1};
	__property Gdipicture::TGDIPPicture* DisabledPicture = {read=FIDisabledPicture, write=SetDisabledPicture};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property TAdvPreviewSubMenuItems* SubItems = {read=FSubItems, write=SetSubItems};
	__property System::UnicodeString SubMenuCaption = {read=FSubMenuCaption, write=SetSubMenuCaption};
	__property int SubMenuItemHeight = {read=FSubMenuItemHeight, write=SetSubMenuItemHeight, default=0};
	__property System::WideString WideSubMenuCaption = {read=FWideSubMenuCaption, write=SetWideSubMenuCaption};
	__property bool Separator = {read=FSeparator, write=SetSeparator, nodefault};
	__property int SubMenuItemSpacing = {read=FSubMenuItemSpacing, write=SetSubMenuItemSpacing, nodefault};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHint, write=FShortCutHint};
	__property System::UnicodeString ShortCutSubItemsHint = {read=FShortCutSubItemsHint, write=FShortCutSubItemsHint};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool Visible = {read=FVisible, write=FVisible, stored=IsVisibleStored, nodefault};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick, stored=IsOnClickStored};
};


class DELPHICLASS TAdvPreviewMenuItems;
class PASCALIMPLEMENTATION TAdvPreviewMenuItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvPreviewMenuItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	HIDESBASE TAdvPreviewMenuItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvPreviewMenuItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall MoveItem(int FromIndex, int ToIndex);
	
public:
	__fastcall TAdvPreviewMenuItems(Classes::TPersistent* AOwner);
	__property TAdvPreviewMenuItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TAdvPreviewMenuItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TAdvPreviewMenuItem* __fastcall Insert(int Index);
	void __fastcall InitiateActions(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvPreviewMenuItems(void) { }
	
};


class DELPHICLASS TAdvCustomPreviewMenuPanel;
class PASCALIMPLEMENTATION TAdvCustomPreviewMenuPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TComponent* FOwner;
	Classes::TNotifyEvent FOnShouldHide;
	bool FShowBorder;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	virtual void __fastcall InitializeAndUpdate(void);
	
public:
	__fastcall virtual TAdvCustomPreviewMenuPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomPreviewMenuPanel(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomPreviewMenuPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TButtonClickEvent)(System::TObject* Sender, int ButtonIndex);

typedef void __fastcall (__closure *TMenuItemClickEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TSubMenuItemClickEvent)(System::TObject* Sender, int ItemIndex, int SubMenuItemIndex);

typedef void __fastcall (__closure *TMenuDrawItemEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int ItemIndex, const Types::TRect &R);

typedef void __fastcall (__closure *TSubMenuDrawItemEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int ItemIndex, int SubMenuItemIndex, const Types::TRect &R);

typedef void __fastcall (__closure *TDrawButtonFrameTopEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R);

class DELPHICLASS TMenuItemScroller;
class PASCALIMPLEMENTATION TMenuItemScroller : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FMin;
	int FMax;
	int FPosition;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	bool __fastcall GetVisible(void);
	
public:
	__fastcall TMenuItemScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=GetVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMenuItemScroller(void) { }
	
};


class DELPHICLASS TAdvPreviewMenuPanel;
class PASCALIMPLEMENTATION TAdvPreviewMenuPanel : public TAdvCustomPreviewMenuPanel
{
	typedef TAdvCustomPreviewMenuPanel inherited;
	
private:
	Classes::TComponent* FOwner;
	TAdvPreviewMenu* FAdvPreviewMenu;
	Types::TRect FLeftFrameRect;
	Types::TRect FRightFrameRect;
	int FItemIndex;
	int FItemHot;
	int FItemDown;
	int FItemHeight;
	int FImageSpace;
	int FLineSpace;
	Classes::TList* FButtonList;
	int FSubMenuItem;
	int FSubMenuItemHeight;
	int FSubMenuItemHot;
	int FSubMenuItemDown;
	int FSubMenuCaptionHeight;
	Menus::TPopupMenu* FSubMenuPopup;
	bool FInternalHideSubMenuPopup;
	int FHintItemIndex;
	int FHintSubMenuItemIndex;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FIgnoreMouseDown;
	bool FShortCutItemHintShowing;
	bool FShortCutSubMenuItemHintShowing;
	System::UnicodeString FShortCutChars;
	bool FButtonPartHot;
	bool FDropDownPartHot;
	bool FInternalClick;
	Extctrls::TTimer* FMouseTimer;
	bool FMouseSetHot;
	int FMouseItemHot;
	TMenuItemScroller* FSubMenuScroller;
	int FSubMenuVisibleItemCount;
	int FTopSubMenuItem;
	bool FSubMenuScollUpHot;
	bool FSubMenuScollUpDown;
	bool FSubMenuScollDownHot;
	bool FSubMenuScollDownDown;
	bool FSubMenuScrolling;
	int FSelectedItem;
	int FSelectedSubItem;
	int FHintItem;
	int FHintSubItem;
	int FButtonHot;
	Types::TRect FPopupOverlapRect;
	bool FShowingPopupMenu;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	void __fastcall OnButtonKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OnButtonKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnButtonClick(System::TObject* Sender);
	void __fastcall OnButtonInternalClick(System::TObject* Sender);
	void __fastcall OnButtonMouseEnter(System::TObject* Sender);
	void __fastcall OnMouseTimer(System::TObject* Sender);
	void __fastcall SetItemHot(const int Value);
	void __fastcall SetSubMenuItemHot(const int Value);
	void __fastcall SetSubMenuItem(const int Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetButtonHot(const int Value);
	
protected:
	bool FEditorCreated;
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall DrawShortCutHint(Graphics::TCanvas* Canvas, System::UnicodeString ShortCutHint, const Types::TPoint &Pt, bool Shaded);
	void __fastcall DrawItems(void);
	void __fastcall DrawItem(int Index, bool RefreshItem = false);
	void __fastcall RefreshItem(int Index);
	void __fastcall DrawSubMenuItems(Graphics::TCanvas* ACanvas = (Graphics::TCanvas*)(0x0));
	void __fastcall DrawSubMenuItem(int AIndex, bool RefreshItem = false, Graphics::TCanvas* ACanvas = (Graphics::TCanvas*)(0x0));
	void __fastcall DrawRightFrame(Graphics::TCanvas* ACanvas, bool WithItems = true);
	void __fastcall DrawUpScrollBtn(void);
	void __fastcall DrawDownScrollBtn(void);
	int __fastcall ItemAtPos(int X, int Y);
	void __fastcall SelectItem(int Index);
	TAdvPreviewSubMenuItems* __fastcall GetSubMenuItems(void);
	int __fastcall SubMenuItemAtPos(int X, int Y)/* overload */;
	int __fastcall SubMenuItemAtPos(int X, int Y, TAdvPreviewSubMenuItem* &SubItem)/* overload */;
	void __fastcall SelectSubMenuItem(int Index);
	void __fastcall HideMenuWindow(void);
	void __fastcall InternalClickSubItem(int SubIndex);
	void __fastcall CheckKeyPress(System::Word Key);
	void __fastcall CheckMouseMove(int X, int Y);
	Types::TRect __fastcall GetPopupMenuOverlapRect(Menus::TPopupMenu* Menu, Types::TPoint &P);
	void __fastcall ShowSubMenuPopup(int AIndex);
	void __fastcall HideSubMenuPopup(void);
	bool __fastcall IsFirstItem(int Index, bool CheckEnable, bool CheckVisible);
	bool __fastcall IsLastItem(int Index, bool CheckEnable, bool CheckVisible);
	void __fastcall ItemHotNext(void);
	void __fastcall ItemHotPrevious(void);
	void __fastcall ItemHotLast(void);
	bool __fastcall IsFirstSubMenuItem(int Index, bool CheckEnable, bool CheckVisible);
	bool __fastcall IsLastSubMenuItem(int Index, bool CheckEnable, bool CheckVisible);
	void __fastcall SubMenuItemHotNext(void);
	void __fastcall SubMenuItemHotPrevious(void);
	void __fastcall SubMenuItemHotLast(void);
	bool __fastcall IsFirstButton(int Index, bool CheckEnable, bool CheckVisible);
	bool __fastcall IsLastButton(int Index, bool CheckEnable, bool CheckVisible);
	void __fastcall ButtonHotNext(void);
	void __fastcall ButtonHotPrevious(void);
	void __fastcall ButtonHotLast(void);
	void __fastcall ShowAllItemsShortCutHint(void);
	void __fastcall HideAllItemsShortCutHint(void);
	void __fastcall ShowItemShortCutHint(int Index);
	void __fastcall HideItemShortCutHint(int Index);
	void __fastcall DrawItemShortCutHint(int Index);
	void __fastcall DrawItemSubItemShortCutHint(int Index);
	void __fastcall ShowItemSubItemShortCutHint(int Index);
	void __fastcall HideItemSubItemShortCutHint(int Index);
	void __fastcall ShowAllSubMenuItemsShortCutHint(void);
	void __fastcall HideAllSubMenuItemsShortCutHint(void);
	void __fastcall DrawSubMenuItemShortCutHint(int Index);
	void __fastcall ShowSubMenuItemShortCutHint(int Index);
	void __fastcall HideSubMenuItemShortCutHint(int Index);
	void __fastcall InvalidateTopFrame(void);
	void __fastcall InvalidateLeftFrame(void);
	void __fastcall InvalidateRightFrame(void);
	Types::TRect __fastcall GetTopFrameRect(void);
	Types::TRect __fastcall GetItemFramesRect(void);
	Types::TRect __fastcall GetLeftFrameRect(void);
	Types::TRect __fastcall GetRightFrameRect(void);
	Types::TRect __fastcall GetItemRect(int Index);
	Types::TRect __fastcall GetItemDropDownRect(int Index);
	int __fastcall GetItemHeight(void);
	void __fastcall GetMaxItemSize(int &AHeight, int &AWidth);
	int __fastcall RealIndexToVisItemIndex(int Index);
	int __fastcall VisIndexToRealItemIndex(int Index);
	int __fastcall VisibleItemsCount(void);
	Types::TRect __fastcall GetUpScrollBtnRect(void);
	Types::TRect __fastcall GetDownScrollBtnRect(void);
	Types::TRect __fastcall GetSubMenuCaptionRect(void);
	Types::TRect __fastcall GetSubMenuItemRect(int Index);
	int __fastcall GetSubMenuItemHeight(void);
	void __fastcall GetSubMenuMaxItemSize(int Index, int &AHeight, int &AWidth, TAdvPreviewSubMenuItems* SubMenuItems = (TAdvPreviewSubMenuItems*)(0x0))/* overload */;
	void __fastcall GetSubMenuMaxItemSize(int &AHeight, int &AWidth)/* overload */;
	void __fastcall CalculateSubMenuItemSize(void);
	int __fastcall RealIndexToVisSubItemIndex(int Index);
	int __fastcall VisIndexToRealSubItemIndex(int Index);
	int __fastcall VisibleSubItemCount(int ItemIndex);
	void __fastcall InitializeScroller(void);
	void __fastcall UpdateScroller(void);
	void __fastcall ChangeTopSubMenuItemTo(int Value);
	int __fastcall ScrollSubMenu(int Value);
	void __fastcall InvalidateSubMenuScroller(void);
	void __fastcall SubMenuScrollUpClick(void);
	void __fastcall SubMenuScrollDownClick(void);
	void __fastcall SubMenuScrollInView(int Index);
	void __fastcall SetSelectedItem(int Index);
	__property int SelectedItem = {read=FSelectedItem, nodefault};
	void __fastcall SetSelectedSubItem(int Index);
	__property int SelectedSubItem = {read=FSelectedSubItem, nodefault};
	__property int ItemHot = {read=FItemHot, write=SetItemHot, nodefault};
	__property int SubMenuItem = {read=FSubMenuItem, write=SetSubMenuItem, nodefault};
	__property int SubMenuItemHot = {read=FSubMenuItemHot, write=SetSubMenuItemHot, nodefault};
	__property int ButtonHot = {read=FButtonHot, write=SetButtonHot, nodefault};
	
public:
	__fastcall virtual TAdvPreviewMenuPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPreviewMenuPanel(void);
	virtual void __fastcall InitializeAndUpdate(void);
	
__published:
	__property TAdvPreviewMenu* AdvPreviewMenu = {read=FAdvPreviewMenu, write=FAdvPreviewMenu};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPreviewMenuPanel(HWND ParentWindow) : TAdvCustomPreviewMenuPanel(ParentWindow) { }
	
};


class DELPHICLASS TPreviewMenuWindow;
class PASCALIMPLEMENTATION TPreviewMenuWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	bool FHideOnDeActivate;
	Classes::TComponent* FOwner;
	bool FShowBorder;
	Extctrls::TTimer* FHideTimer;
	Graphics::TColor FBorderColor;
	TAdvCustomPreviewMenuPanel* FPreviewMenuPanel;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
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
	void __fastcall SetRegion(void);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	__property TAdvCustomPreviewMenuPanel* PreviewMenuPanel = {read=FPreviewMenuPanel, write=FPreviewMenuPanel};
	
public:
	__fastcall virtual TPreviewMenuWindow(Classes::TComponent* AOwner);
	__fastcall virtual TPreviewMenuWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TPreviewMenuWindow(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TWinControl.CreateParented */ inline __fastcall TPreviewMenuWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TVistaBackground;
class PASCALIMPLEMENTATION TVistaBackground : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FBorderColor;
	Advglowbutton::TGDIPGradient FGradientMirror;
	Advglowbutton::TGDIPGradient FGradient;
	Graphics::TColor FCaptionBackground;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirror(const Advglowbutton::TGDIPGradient Value);
	
public:
	__fastcall TVistaBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor CaptionBackground = {read=FCaptionBackground, write=FCaptionBackground, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Advglowbutton::TGDIPGradient Gradient = {read=FGradient, write=SetGradient, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, nodefault};
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TVistaBackground(void) { }
	
};


class DELPHICLASS TSelectionAppearance;
class PASCALIMPLEMENTATION TSelectionAppearance : public Advglowbutton::TGlowButtonAppearance
{
	typedef Advglowbutton::TGlowButtonAppearance inherited;
	
private:
	Graphics::TColor FTextColor;
	Graphics::TColor FTextColorDisabled;
	Graphics::TColor FTextColorDown;
	Graphics::TColor FTextColorHot;
	Graphics::TColor FTextColorChecked;
	bool FRounded;
	Graphics::TFont* FFont;
	Graphics::TFont* FSubItemFont;
	Graphics::TFont* FSubItemTitleFont;
	bool FSystemFont;
	Graphics::TFont* FSubMenuCaptionFont;
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTextColorChecked(const Graphics::TColor Value);
	void __fastcall SetTextColorDisabled(const Graphics::TColor Value);
	void __fastcall SetTextColorDown(const Graphics::TColor Value);
	void __fastcall SetTextColorHot(const Graphics::TColor Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSubItemFont(const Graphics::TFont* Value);
	void __fastcall SetSubItemTitleFont(const Graphics::TFont* Value);
	HIDESBASE void __fastcall SetSystemFont(const bool Value);
	void __fastcall SetSubMenuCaptionFont(const Graphics::TFont* Value);
	
public:
	__fastcall TSelectionAppearance(void);
	__fastcall virtual ~TSelectionAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* SubMenuCaptionFont = {read=FSubMenuCaptionFont, write=SetSubMenuCaptionFont};
	__property Graphics::TFont* SubItemTitleFont = {read=FSubItemTitleFont, write=SetSubItemTitleFont};
	__property Graphics::TFont* SubItemFont = {read=FSubItemFont, write=SetSubItemFont};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor TextColorHot = {read=FTextColorHot, write=SetTextColorHot, nodefault};
	__property Graphics::TColor TextColorDown = {read=FTextColorDown, write=SetTextColorDown, nodefault};
	__property Graphics::TColor TextColorChecked = {read=FTextColorChecked, write=SetTextColorChecked, nodefault};
	__property Graphics::TColor TextColorDisabled = {read=FTextColorDisabled, write=SetTextColorDisabled, nodefault};
	__property bool Rounded = {read=FRounded, write=SetRounded, nodefault};
};


class DELPHICLASS TAdvCustomPreviewMenuStyler;
class PASCALIMPLEMENTATION TAdvCustomPreviewMenuStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advglowbutton::TGlowButtonAppearance* FButtonAppearance;
	TSelectionAppearance* FMenuItemAppearance;
	TVistaBackground* FFrameAppearance;
	Graphics::TColor FRightFrameColor;
	Graphics::TColor FLeftFrameColor;
	Graphics::TColor FRightFrameBorderColor;
	void __fastcall SetButtonAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetFrameAppearance(const TVistaBackground* Value);
	void __fastcall SetMenuItemAppearance(const TSelectionAppearance* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall Change(int PropID = 0x0);
	__property TVistaBackground* FrameAppearance = {read=FFrameAppearance, write=SetFrameAppearance};
	__property Graphics::TColor LeftFrameColor = {read=FLeftFrameColor, write=FLeftFrameColor, nodefault};
	__property Graphics::TColor RightFrameColor = {read=FRightFrameColor, write=FRightFrameColor, nodefault};
	__property Graphics::TColor RightFrameBorderColor = {read=FRightFrameBorderColor, write=FRightFrameBorderColor, nodefault};
	__property TSelectionAppearance* MenuItemAppearance = {read=FMenuItemAppearance, write=SetMenuItemAppearance};
	__property Advglowbutton::TGlowButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	
public:
	__fastcall virtual TAdvCustomPreviewMenuStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomPreviewMenuStyler(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
};


class PASCALIMPLEMENTATION TAdvPreviewMenu : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Graphics::TColor FMenuShapeColor;
	Graphics::TColor FMenuButtonColor;
	Graphics::TColor FMenuButtonColorTo;
	Graphics::TColor FMenuButtonColorMirror;
	Graphics::TColor FMenuButtonColorMirrorTo;
	Graphics::TColor FMenuButtonInnerBorderColor;
	Graphics::TColor FMenuButtonBorderColor;
	System::UnicodeString FMenuText;
	bool FMenuDefaultShape;
	Gdipicture::TGDIPPicture* FMenuPicture;
	Classes::TComponent* FOwner;
	Controls::TImageList* FButtonImages;
	TAdvPreviewMenuItems* FMenuItems;
	TAdvCustomPreviewMenuStyler* FStyler;
	TAdvCustomPreviewMenuStyler* FInternalStyler;
	TAdvCustomPreviewMenuStyler* FCurrentStyler;
	int FMenuSpacing;
	TPreviewMenuWindow* FPreviewMenuWindow;
	TAdvPreviewMenuPanel* FAdvPreviewMenuPanel;
	TButtonCollection* FButtons;
	int FButtonSpacing;
	int FButtonHeight;
	int FTopFrameHeight;
	int FOffSetX;
	Imglist::TCustomImageList* FMenuImages;
	Imglist::TCustomImageList* FSubMenuImages;
	bool FShowHint;
	TButtonClickEvent FOnButtonClick;
	TMenuItemClickEvent FOnMenuItemClick;
	TSubMenuItemClickEvent FOnSubMenuItemClick;
	TMenuDrawItemEvent FOnMenuDrawItem;
	TSubMenuDrawItemEvent FOnSubMenuDrawItem;
	int FSubMenuItemSpacing;
	System::UnicodeString FSubMenuCaption;
	TAdvPreviewSubMenuItems* FSubMenuItems;
	TDrawButtonFrameTopEvent FOnDrawButtonFrameTop;
	Classes::TNotifyEvent FOnPreviewHide;
	int FSubMenuWidth;
	int FMenuWidth;
	System::WideString FWideSubMenuCaption;
	bool FMenuShowing;
	int FSubMenuItemHeight;
	Advgdip::TAntiAlias FAntiAlias;
	Graphics::TFont* FMenuFont;
	void __fastcall OnPreviewMenuWindowHide(System::TObject* Sender);
	void __fastcall OnPreviewMenuWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall SetButtonImages(const Controls::TImageList* Value);
	void __fastcall SetMenuItems(const TAdvPreviewMenuItems* Value);
	void __fastcall SetStyler(const TAdvCustomPreviewMenuStyler* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetButtons(const TButtonCollection* Value);
	int __fastcall GetBottomFrameHeight(void);
	void __fastcall SetMenuImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetSubMenuImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetSubMenuItems(const TAdvPreviewSubMenuItems* Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetSubMenuItemHeight(const int Value);
	void __fastcall SetMenuFont(const Graphics::TFont* Value);
	
protected:
	bool FEditorCreated;
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateActions(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall InvalidateTopFrame(void);
	void __fastcall InvalidateMenu(void);
	void __fastcall DrawMenuItem(int Index);
	void __fastcall InitializeMenu(void);
	void __fastcall GetMenuSize(int &W, int &H);
	__property int TopFrameHeight = {read=FTopFrameHeight, nodefault};
	__property int BottomFrameHeight = {read=GetBottomFrameHeight, nodefault};
	__property int OffSetX = {read=FOffSetX, nodefault};
	__property bool Visible = {read=GetVisible, nodefault};
	__property Classes::TNotifyEvent OnPreviewHide = {read=FOnPreviewHide, write=FOnPreviewHide};
	int __fastcall GetTopFrameHeight(void);
	int __fastcall GetOffsetX(void);
	
public:
	__fastcall virtual TAdvPreviewMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPreviewMenu(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall GetVersionNr(void);
	void __fastcall ShowMenu(int X, int Y);
	void __fastcall HideMenu(void);
	void __fastcall SetMenuButtonAppearance(Graphics::TColor BorderColor, Graphics::TColor InnerBorderColor, Graphics::TColor Color, Graphics::TColor ColorTo, Graphics::TColor ColorMirror, Graphics::TColor ColorMirrorTo, Graphics::TColor ShapeColor, bool DefaultShape, Gdipicture::TGDIPPicture* Picture, System::UnicodeString AText, Graphics::TFont* AFont);
	void __fastcall ChangeStyle(bool AWin7, int AStyle);
	void __fastcall ShowShortCutHints(void);
	void __fastcall HideShortCutHints(void);
	__property TDrawButtonFrameTopEvent OnDrawButtonFrameTop = {read=FOnDrawButtonFrameTop, write=FOnDrawButtonFrameTop};
	
__published:
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=FAntiAlias, default=1};
	__property TButtonCollection* Buttons = {read=FButtons, write=SetButtons};
	__property int ButtonSpacing = {read=FButtonSpacing, write=FButtonSpacing, nodefault};
	__property int ButtonHeight = {read=FButtonHeight, write=FButtonHeight, nodefault};
	__property TAdvPreviewMenuItems* MenuItems = {read=FMenuItems, write=SetMenuItems};
	__property int MenuSpacing = {read=FMenuSpacing, write=FMenuSpacing, nodefault};
	__property Imglist::TCustomImageList* MenuImages = {read=FMenuImages, write=SetMenuImages};
	__property int MenuWidth = {read=FMenuWidth, write=FMenuWidth, nodefault};
	__property System::UnicodeString MenuText = {read=FMenuText, write=FMenuText};
	__property Graphics::TFont* MenuFont = {read=FMenuFont, write=SetMenuFont};
	__property int SubMenuWidth = {read=FSubMenuWidth, write=FSubMenuWidth, nodefault};
	__property TAdvPreviewSubMenuItems* SubMenuItems = {read=FSubMenuItems, write=SetSubMenuItems};
	__property System::UnicodeString SubMenuCaption = {read=FSubMenuCaption, write=FSubMenuCaption};
	__property int SubMenuItemHeight = {read=FSubMenuItemHeight, write=SetSubMenuItemHeight, default=0};
	__property System::WideString WideSubMenuCaption = {read=FWideSubMenuCaption, write=FWideSubMenuCaption};
	__property int SubMenuItemSpacing = {read=FSubMenuItemSpacing, write=FSubMenuItemSpacing, nodefault};
	__property Imglist::TCustomImageList* SubMenuImages = {read=FSubMenuImages, write=SetSubMenuImages};
	__property Controls::TImageList* ButtonImages = {read=FButtonImages, write=SetButtonImages};
	__property TAdvCustomPreviewMenuStyler* Styler = {read=FStyler, write=SetStyler};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TButtonClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property TMenuItemClickEvent OnMenuItemClick = {read=FOnMenuItemClick, write=FOnMenuItemClick};
	__property TSubMenuItemClickEvent OnSubMenuItemClick = {read=FOnSubMenuItemClick, write=FOnSubMenuItemClick};
	__property TMenuDrawItemEvent OnMenuDrawItem = {read=FOnMenuDrawItem, write=FOnMenuDrawItem};
	__property TSubMenuDrawItemEvent OnSubMenuDrawItem = {read=FOnSubMenuDrawItem, write=FOnSubMenuDrawItem};
};


class DELPHICLASS TPreviewMenuControl;
class PASCALIMPLEMENTATION TPreviewMenuControl : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TComponent* FOwner;
	TAdvPreviewMenu* FAdvPreviewMenu;
	TAdvPreviewMenuPanel* FAdvPreviewMenuPanel;
	void __fastcall OnPreviewPanelResize(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall CreatePreviewMenu(void);
	void __fastcall DestroyPreviewMenu(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TPreviewMenuControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TPreviewMenuControl(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall AssignMenu(TAdvPreviewMenu* PreviewMenu);
	void __fastcall MoveMenuItemUp(void);
	void __fastcall MoveMenuItemDown(void);
	__property TAdvPreviewMenu* AdvPreviewMenu = {read=FAdvPreviewMenu};
	__property TAdvPreviewMenuPanel* AdvPreviewMenuPanel = {read=FAdvPreviewMenuPanel};
	__property OnResize;
public:
	/* TWinControl.CreateParented */ inline __fastcall TPreviewMenuControl(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x5;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
static const ShortInt MENUARROW_WIDTH = 0x18;
static const ShortInt MINITEM_HEIGHT = 0xc;
static const ShortInt SHADOW_WIDTH = 0x4;
static const ShortInt SCROLL_HEIGHT = 0xa;
extern PACKAGE bool ForceEnableAction;

}	/* namespace Advpreviewmenu */
using namespace Advpreviewmenu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpreviewmenuHPP
