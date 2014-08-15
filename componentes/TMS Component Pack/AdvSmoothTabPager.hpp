// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothtabpager.pas' rev: 21.00

#ifndef AdvsmoothtabpagerHPP
#define AdvsmoothtabpagerHPP

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
#include <Math.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothtabpager
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothTabSettings;
class PASCALIMPLEMENTATION TAdvSmoothTabSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FLeftMargin;
	int FRightMargin;
	Classes::TNotifyEvent FOnChange;
	int FHeight;
	int FStartMargin;
	int FEndMargin;
	int FSpacing;
	int FWidth;
	void __fastcall SetLeftMargin(const int Value);
	void __fastcall SetRightMargin(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetStartMargin(const int Value);
	void __fastcall SetEndMargin(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	void __fastcall Changed(void);
	__property int EndMargin = {read=FEndMargin, write=SetEndMargin, nodefault};
	
public:
	__fastcall TAdvSmoothTabSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property int LeftMargin = {read=FLeftMargin, write=SetLeftMargin, default=4};
	__property int RightMargin = {read=FRightMargin, write=SetRightMargin, default=4};
	__property int StartMargin = {read=FStartMargin, write=SetStartMargin, default=60};
	__property int Height = {read=FHeight, write=SetHeight, default=26};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvSmoothTabSettings(void) { }
	
};


class DELPHICLASS TDbgList;
class PASCALIMPLEMENTATION TDbgList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	void * operator[](int Index) { return Items[Index]; }
	
private:
	void * __fastcall GetItemsEx(int Index);
	void __fastcall SetItemsEx(int Index, const void * Value);
	
public:
	__property void * Items[int Index] = {read=GetItemsEx, write=SetItemsEx/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TDbgList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDbgList(void) : Classes::TList() { }
	
};


class DELPHICLASS TProWinControl;
class PASCALIMPLEMENTATION TProWinControl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TProWinControl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TProWinControl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TProWinControl(void) { }
	
};


class DELPHICLASS TAdvSmoothTabStatus;
class DELPHICLASS TAdvSmoothTabAppearance;
class PASCALIMPLEMENTATION TAdvSmoothTabStatus : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothTabAppearance* FOwner;
	int FOffsetTop;
	int FOffsetLeft;
	bool FVisible;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPStatus* FAppearance;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetAppearance(const Gdipfill::TGDIPStatus* Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetOffsetLeft(const int Value);
	void __fastcall SetOffsetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothTabStatus(TAdvSmoothTabAppearance* AOwner);
	__fastcall virtual ~TAdvSmoothTabStatus(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int OffsetLeft = {read=FOffsetLeft, write=SetOffsetLeft, default=0};
	__property int OffsetTop = {read=FOffsetTop, write=SetOffsetTop, default=0};
	__property Gdipfill::TGDIPStatus* Appearance = {read=FAppearance, write=SetAppearance};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothTabPage;
class PASCALIMPLEMENTATION TAdvSmoothTabAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothTabPage* FOwner;
	Advgdip::TAdvGDIPPicture* FPicture;
	bool FBevel;
	int FVerticalSpacing;
	Graphics::TColor FColor;
	Gdipfill::TGDIPButton* FAppearance;
	Graphics::TColor FBevelColor;
	bool FShadow;
	TAdvSmoothTabStatus* FStatus;
	int FHorizontalSpacing;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorSelected;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorHot;
	Graphics::TColor FBevelColorDisabled;
	Graphics::TColor FBevelColorSelected;
	Graphics::TColor FBevelColorDown;
	Graphics::TColor FBevelColorHot;
	void __fastcall SetAppearance(const Gdipfill::TGDIPButton* Value);
	void __fastcall SetBevel(const bool Value);
	void __fastcall SetBevelColor(const Graphics::TColor Value);
	void __fastcall SetStatus(const TAdvSmoothTabStatus* Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetHorizontalSpacing(const int Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetShadow(const bool Value);
	void __fastcall SetVerticalSpacing(const int Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorSelected(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetBevelColorDisabled(const Graphics::TColor Value);
	void __fastcall SetBevelColorDown(const Graphics::TColor Value);
	void __fastcall SetBevelColorSelected(const Graphics::TColor Value);
	void __fastcall SetBevelColorHot(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall StatusChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothTabAppearance(TAdvSmoothTabPage* AOwner);
	__fastcall virtual ~TAdvSmoothTabAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPButton* Appearance = {read=FAppearance, write=SetAppearance};
	__property TAdvSmoothTabStatus* Status = {read=FStatus, write=SetStatus};
	__property bool Bevel = {read=FBevel, write=SetBevel, default=1};
	__property Graphics::TColor BevelColor = {read=FBevelColor, write=SetBevelColor, default=8421504};
	__property Graphics::TColor BevelColorDown = {read=FBevelColorDown, write=SetBevelColorDown, default=8421504};
	__property Graphics::TColor BevelColorSelected = {read=FBevelColorSelected, write=SetBevelColorSelected, default=11196927};
	__property Graphics::TColor BevelColorHot = {read=FBevelColorHot, write=SetBevelColorHot, default=16777215};
	__property Graphics::TColor BevelColorDisabled = {read=FBevelColorDisabled, write=SetBevelColorDisabled, default=5526612};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=8421504};
	__property Graphics::TColor ColorSelected = {read=FColorSelected, write=SetColorSelected, default=11196927};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, default=16777215};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, default=5526612};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Shadow = {read=FShadow, write=SetShadow, default=0};
	__property int HorizontalSpacing = {read=FHorizontalSpacing, write=SetHorizontalSpacing, default=0};
	__property int VerticalSpacing = {read=FVerticalSpacing, write=SetVerticalSpacing, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothTabPager;
class PASCALIMPLEMENTATION TAdvSmoothTabPage : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDesignTime;
	int FPageIndex;
	bool FTabVisible;
	TAdvSmoothTabPager* FAdvSmoothTabPager;
	Controls::TCaption FCaption;
	bool FTabEnabled;
	int FImageIndex;
	bool FUpdatingParent;
	Classes::TNotifyEvent FOnShow;
	Classes::TNotifyEvent FOnHide;
	TAdvSmoothTabAppearance* FTabAppearance;
	Gdipfill::TGDIPFill* FPageAppearance;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Controls::TCMControlListChange &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	void __fastcall OnTabAppearanceChanged(System::TObject* Sender);
	void __fastcall OnPageAppearanceChanged(System::TObject* Sender);
	void __fastcall SetAdvSmoothTabPager(const TAdvSmoothTabPager* Value);
	void __fastcall SetTabVisible(const bool Value);
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetTabEnabled(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	int __fastcall GetPageIndex(void);
	void __fastcall SetPageIndex(const int Value);
	void __fastcall SetTabAppearance(const TAdvSmoothTabAppearance* Value);
	void __fastcall SetPageAppearance(const Gdipfill::TGDIPFill* Value);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	
public:
	__fastcall virtual TAdvSmoothTabPage(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothTabPage(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TAdvSmoothTabPager* AdvSmoothTabPager = {read=FAdvSmoothTabPager, write=SetAdvSmoothTabPager};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Gdipfill::TGDIPFill* PageAppearance = {read=FPageAppearance, write=SetPageAppearance};
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property bool TabEnabled = {read=FTabEnabled, write=SetTabEnabled, default=1};
	__property ShowHint;
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property TAdvSmoothTabAppearance* TabAppearance = {read=FTabAppearance, write=SetTabAppearance};
	__property Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property PopupMenu;
	__property OnContextPopup;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDragOver;
	__property OnDragDrop;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnExit;
	__property OnEnter;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTabPage(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


typedef void __fastcall (__closure *TTabChangingEvent)(System::TObject* Sender, int FromPage, int ToPage, bool &AllowChange);

typedef void __fastcall (__closure *TOnClosePage)(System::TObject* Sender, int PageIndex, bool &Allow);

typedef void __fastcall (__closure *TOnClosedPage)(System::TObject* Sender, int PageIndex);

typedef void __fastcall (__closure *TOnPageListClick)(System::TObject* Sender, int X, int Y);

typedef void __fastcall (__closure *TTabMovedEvent)(System::TObject* Sender, int FromPos, int ToPos);

typedef void __fastcall (__closure *TDrawTabEvent)(System::TObject* Sender, int TabIndex, const Types::TRect &TabRect);

#pragma option push -b-
enum TAdvSmoothTabPosition { tpTopRight, tpTopCenter, tpTopLeft, tpLeftTop, tpLeftBottom, tpLeftCenter, tpRightTop, tpRightBottom, tpRightCenter, tpBottomLeft, tpBottomRight, tpBottomCenter };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothTabPager : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool Ffocused;
	int FPageMargin;
	int FOffSetY;
	int FOffSetX;
	TDbgList* FAdvSmoothTabPages;
	bool FPropertiesLoaded;
	TAdvSmoothTabSettings* FTabSettings;
	int FActivePageIndex;
	int FHotPageIndex;
	int FDownPageIndex;
	int FOldHotPageIndex;
	Classes::TNotifyEvent FOnChange;
	TTabChangingEvent FOnChanging;
	TAdvSmoothTabPosition FTabPosition;
	int FTabOffSet;
	Classes::TWndMethod FFormWndProc;
	bool FTabReorder;
	TTabMovedEvent FOnTabMoved;
	TDrawTabEvent FOnDrawTab;
	bool FConstructed;
	bool FDesignTime;
	bool FShowFocus;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Controls::TCMControlListChange &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	void __fastcall OnTabSettingsChanged(System::TObject* Sender);
	void __fastcall OnEnterTab(int PageIndex);
	void __fastcall OnExitTab(int PageIndex);
	void __fastcall SetPagePosition(TAdvSmoothTabPage* SmoothTab);
	void __fastcall SetAllPagesPosition(void);
	int __fastcall GetAdvSmoothTabPageCount(void);
	TAdvSmoothTabPage* __fastcall GetAdvSmoothTabPages(int index);
	Menus::TPopupMenu* __fastcall GetPopupMenuEx(void);
	void __fastcall SetPopupMenuEx(const Menus::TPopupMenu* Value);
	TAdvSmoothTabPage* __fastcall GetActivePage(void);
	int __fastcall GetActivePageIndex(void);
	void __fastcall SetActivePage(const TAdvSmoothTabPage* Value);
	void __fastcall SetActivePageIndex(const int Value);
	void __fastcall SetTabSettings(const TAdvSmoothTabSettings* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SeTAdvSmoothTabPosition(const TAdvSmoothTabPosition Value);
	void __fastcall SetPageMargin(const int Value);
	void __fastcall SetShowFocus(const bool Value);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall DrawTab(int PageIndex);
	void __fastcall DrawAllTabs(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	void __fastcall SetSmoothTabBounds(TAdvSmoothTabPage* SmoothTab, int &ALeft, int &ATop, int &AWidth, int &AHeight);
	void __fastcall UpdateMe(int PropID);
	void __fastcall ChangeActivePage(int PageIndex);
	bool __fastcall CanShowTab(int PageIndex);
	int __fastcall GetVisibleTabCount(void);
	void __fastcall InvalidateTab(int PageIndex);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	Types::TRect __fastcall GetSmoothTabRect(void);
	Types::TRect __fastcall GetTabsArea(void);
	Types::TRect __fastcall GetTabsRect(void);
	Types::TRect __fastcall GetTabRect(int StartIndex, int PageIndex, int totalsize)/* overload */;
	Types::TRect __fastcall GetTabRect(int PageIndex)/* overload */;
	Types::TRect __fastcall GetTabRect(TAdvSmoothTabPage* Page)/* overload */;
	int __fastcall PTOnTab(int X, int Y);
	int __fastcall IsActivePageNeighbour(int PageIndex);
	bool __fastcall UseOldDrawing(void);
	
public:
	__fastcall virtual TAdvSmoothTabPager(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TAdvSmoothTabPager(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall Init(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	int __fastcall GetVersionNr(void);
	int __fastcall AddAdvSmoothTabPage(TAdvSmoothTabPage* SmoothTab)/* overload */;
	int __fastcall AddAdvSmoothTabPage(Controls::TCaption PageCaption)/* overload */;
	void __fastcall RemoveAdvSmoothTabPage(TAdvSmoothTabPage* SmoothTab);
	void __fastcall MoveAdvSmoothTabPage(int CurIndex, int NewIndex);
	TAdvSmoothTabPage* __fastcall FindNextPage(TAdvSmoothTabPage* CurPage, bool GoForward, bool CheckTabVisible);
	void __fastcall SelectNextPage(bool GoForward);
	int __fastcall IndexOfPage(TAdvSmoothTabPage* SmoothTab);
	int __fastcall IndexOfTabAt(int X, int Y);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int AdvSmoothTabPageCount = {read=GetAdvSmoothTabPageCount, nodefault};
	__property TAdvSmoothTabPage* AdvSmoothTabPages[int index] = {read=GetAdvSmoothTabPages};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property TAdvSmoothTabPage* ActivePage = {read=GetActivePage, write=SetActivePage};
	__property Constraints;
	__property Color = {default=-16777211};
	__property int PageMargin = {read=FPageMargin, write=SetPageMargin, default=1};
	__property Menus::TPopupMenu* PopupMenu = {read=GetPopupMenuEx, write=SetPopupMenuEx};
	__property ShowHint;
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property TAdvSmoothTabPosition TabPosition = {read=FTabPosition, write=SeTAdvSmoothTabPosition, default=1};
	__property TAdvSmoothTabSettings* TabSettings = {read=FTabSettings, write=SetTabSettings};
	__property bool TabReorder = {read=FTabReorder, write=FTabReorder, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Visible = {default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TDrawTabEvent OnDrawTab = {read=FOnDrawTab, write=FOnDrawTab};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property TTabMovedEvent OnTabMoved = {read=FOnTabMoved, write=FOnTabMoved};
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTabPager(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x5;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothtabpager */
using namespace Advsmoothtabpager;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothtabpagerHPP
