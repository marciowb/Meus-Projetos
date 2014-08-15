// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpolypager.pas' rev: 21.00

#ifndef AdvpolypagerHPP
#define AdvpolypagerHPP

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
#include <Customitemscontainer.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Advverticalpolylist.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpolypager
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvDesignList;
class DELPHICLASS TAdvPolyPager;
class PASCALIMPLEMENTATION TAdvDesignList : public Advverticalpolylist::TAdvVerticalPolyList
{
	typedef Advverticalpolylist::TAdvVerticalPolyList inherited;
	
private:
	TAdvPolyPager* FOwner;
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	
protected:
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
public:
	/* TAdvVerticalPolyList.Create */ inline __fastcall virtual TAdvDesignList(Classes::TComponent* AOwner) : Advverticalpolylist::TAdvVerticalPolyList(AOwner) { }
	
public:
	/* TCustomItemsContainer.Destroy */ inline __fastcall virtual ~TAdvDesignList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDesignList(HWND ParentWindow) : Advverticalpolylist::TAdvVerticalPolyList(ParentWindow) { }
	
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


class DELPHICLASS TAdvPolyPage;
class PASCALIMPLEMENTATION TAdvPolyPage : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FPageIndex;
	bool FTabVisible;
	TAdvPolyPager* FAdvPolyPager;
	Controls::TCaption FCaption;
	bool FTabEnabled;
	int FImageIndex;
	bool FUpdatingParent;
	Classes::TNotifyEvent FOnShow;
	Classes::TNotifyEvent FOnHide;
	Gdipfill::TGDIPFill* FPageAppearance;
	Gdipcustomitem::TCustomItem* FItemLink;
	int FPlaceHolderBorderWidth;
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	void __fastcall OnPageAppearanceChanged(System::TObject* Sender);
	void __fastcall SetAdvPolyPager(const TAdvPolyPager* Value);
	void __fastcall SetTabVisible(const bool Value);
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetTabEnabled(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	int __fastcall GetPageIndex(void);
	void __fastcall SetPageIndex(const int Value);
	void __fastcall SetPageAppearance(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetItemLink(const Gdipcustomitem::TCustomItem* Value);
	void __fastcall SetPlaceHolderBorderWidth(const int Value);
	
protected:
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall DrawPlaceHolder(Advgdip::TGPGraphics* g);
	
public:
	__fastcall virtual TAdvPolyPage(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPolyPage(void);
	__property TAdvPolyPager* AdvPolyPager = {read=FAdvPolyPager, write=SetAdvPolyPager};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int PlaceHolderBorderWidth = {read=FPlaceHolderBorderWidth, write=SetPlaceHolderBorderWidth, default=5};
	__property Gdipfill::TGDIPFill* PageAppearance = {read=FPageAppearance, write=SetPageAppearance};
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property bool TabEnabled = {read=FTabEnabled, write=SetTabEnabled, default=1};
	__property ShowHint;
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property Gdipcustomitem::TCustomItem* ItemLink = {read=FItemLink, write=SetItemLink};
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvPolyPage(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
enum TAdvPolyPosition { tpTopRight, tpTopCenter, tpTopLeft, tpLeftTop, tpLeftBottom, tpLeftCenter, tpRightTop, tpRightBottom, tpRightCenter, tpBottomLeft, tpBottomRight, tpBottomCenter };
#pragma option pop

class PASCALIMPLEMENTATION TAdvPolyPager : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
public:
	Gdipcustomitem::TCustomItem* operator[](int Index) { return Items[Index]; }
	
private:
	Gdipcustomitem::TCustomItem* FSelItem;
	bool BlockChange;
	TAdvDesignList* FList;
	bool Ffocused;
	int FPageMargin;
	int FOffSetY;
	int FOffSetX;
	TDbgList* FAdvPolyPages;
	bool FPropertiesLoaded;
	int FActivePageIndex;
	int FHotPageIndex;
	int FDownPageIndex;
	int FOldHotPageIndex;
	Classes::TNotifyEvent FOnChange;
	TTabChangingEvent FOnChanging;
	int FTabOffSet;
	Classes::TWndMethod FFormWndProc;
	bool FTabReorder;
	TTabMovedEvent FOnTabMoved;
	TDrawTabEvent FOnDrawTab;
	bool FConstructed;
	bool FDesignTime;
	Gdipfill::TGDIPFill* FFill;
	Gdipcustomitem::TItemSelectEvent FOnListItemSelect;
	Gdipcustomitem::TItemSelectEvent FOnListItemDeSelect;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetPagePosition(TAdvPolyPage* Poly);
	void __fastcall SetAllPagesPosition(void);
	int __fastcall GetAdvPolyPageCount(void);
	TAdvPolyPage* __fastcall GetAdvPolyPages(int index);
	Menus::TPopupMenu* __fastcall GetPopupMenuEx(void);
	void __fastcall SetPopupMenuEx(const Menus::TPopupMenu* Value);
	TAdvPolyPage* __fastcall GetActivePage(void);
	int __fastcall GetActivePageIndex(void);
	void __fastcall SetActivePage(const TAdvPolyPage* Value);
	void __fastcall SetActivePageIndex(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetPageMargin(const int Value);
	void __fastcall SetList(const Gdipbase::TCustomBaseList* Value);
	Gdipbase::TCustomBaseList* __fastcall GetList(void);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	Customitemscontainer::TAutoSizeMode __fastcall GetAutoSizeMode(void);
	Customitemscontainer::TAutoSizeType __fastcall GetAutoSizeType(void);
	Customitemscontainer::TListBorderMode __fastcall GetBorderMode(void);
	Customitemscontainer::TListBorderTypes __fastcall GetBorderTypes(void);
	Customitemscontainer::THandleAppearance* __fastcall GetHandleAppearance(void);
	int __fastcall GetHorizontalSpacing(void);
	Imglist::TCustomImageList* __fastcall GetImages(void);
	Gdipfill::TGDIPFill* __fastcall GetListFill(void);
	Controls::TMargins* __fastcall GetListMargins(void);
	Gdippicturecontainer::TGDIPPictureContainer* __fastcall GetPictureContainer(void);
	bool __fastcall GetReadOnly(void);
	bool __fastcall GetReorder(void);
	Customitemscontainer::TScrollType __fastcall GetScrollType(void);
	bool __fastcall GetShowFocus(void);
	bool __fastcall GetThumbTracking(void);
	int __fastcall GetVerticalSpacing(void);
	void __fastcall SetAutoSizeMode(const Customitemscontainer::TAutoSizeMode Value);
	void __fastcall SetAutoSizeType(const Customitemscontainer::TAutoSizeType Value);
	void __fastcall SetBorderMode(const Customitemscontainer::TListBorderMode Value);
	void __fastcall SetBorderTypes(const Customitemscontainer::TListBorderTypes Value);
	void __fastcall SetHandleAppearance(const Customitemscontainer::THandleAppearance* Value);
	void __fastcall SetHorizontalSpacing(const int Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetListFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetListMargins(const Controls::TMargins* Value);
	void __fastcall SetPictureContainer(const Gdippicturecontainer::TGDIPPictureContainer* Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetReorder(const bool Value);
	void __fastcall SetScrollType(const Customitemscontainer::TScrollType Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetThumbTracking(const bool Value);
	void __fastcall SetVerticalSpacing(const int Value);
	Gdipcustomitem::TCustomItem* __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const Gdipcustomitem::TCustomItem* Value);
	
protected:
	void __fastcall FillChanged(System::TObject* Sender);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual void __fastcall Paint(void);
	void __fastcall ListItemSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall ListItemDesignTimeSelect(System::TObject* Sender, int Index);
	void __fastcall ListItemDeSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall ListItemExpand(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool Expand);
	void __fastcall ListEndDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, const Advgdip::TGPRectF &ARect);
	void __fastcall ListMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListScroll(System::TObject* Sender, int ScrollPos);
	int __fastcall PageFromItem(Gdipcustomitem::TCustomItem* Item);
	void __fastcall ListItemDestroy(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	void __fastcall UpdateMe(int PropID);
	void __fastcall ChangeActivePage(int PageIndex);
	bool __fastcall CanShowTab(int PageIndex);
	int __fastcall GetVisibleTabCount(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	int __fastcall IsActivePageNeighbour(int PageIndex);
	bool __fastcall UseOldDrawing(void);
	Types::TRect __fastcall GetPolyRect(void);
	void __fastcall ReadItemState(Classes::TReader* Reader, Gdipcustomitem::TCustomItem* Item);
	void __fastcall SetItemParentComponent(Classes::TComponent* AParent, Gdipcustomitem::TCustomItem* Item);
	Gdipcustomitem::TCustomItem* __fastcall GetSelectedItem(void);
	
public:
	__fastcall virtual TAdvPolyPager(Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TAdvPolyPager(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	void __fastcall Init(void);
	int __fastcall GetVersionNr(void);
	int __fastcall AddAdvPolyPage(TAdvPolyPage* Poly, Gdipcustomitem::TCustomItem* Item = (Gdipcustomitem::TCustomItem*)(0x0))/* overload */;
	int __fastcall AddAdvPolyPage(Controls::TCaption PageCaption, Gdipcustomitem::TCustomItem* Item = (Gdipcustomitem::TCustomItem*)(0x0))/* overload */;
	void __fastcall RemoveAdvPolyPage(TAdvPolyPage* Poly);
	void __fastcall MoveAdvPolyPage(int CurIndex, int NewIndex);
	TAdvPolyPage* __fastcall FindNextPage(TAdvPolyPage* CurPage, bool GoForward, bool CheckTabVisible);
	void __fastcall SelectNextPage(bool GoForward);
	int __fastcall IndexOfPage(TAdvPolyPage* Poly);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int AdvPolyPageCount = {read=GetAdvPolyPageCount, nodefault};
	__property TAdvPolyPage* AdvPolyPages[int index] = {read=GetAdvPolyPages};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	System::UnicodeString __fastcall GetThemeID(void);
	Gdipcustomitem::TCustomItem* __fastcall AddItem(Gdipcustomitem::TCustomItemClass AClass);
	void __fastcall RemoveItem(int Index);
	void __fastcall SelectItem(int Index);
	void __fastcall VisualizeItem(int Index, bool AllowScrollItem = true, bool AllowSelectItem = true);
	void __fastcall ScrollToItem(int Index);
	Gdipcustomitem::TCustomItem* __fastcall InsertItem(int Index, Gdipcustomitem::TCustomItemClass AClass);
	void __fastcall ClearItems(void);
	void __fastcall ClearPages(void);
	__property Gdipcustomitem::TCustomItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	
__published:
	__property Gdipbase::TCustomBaseList* List = {read=GetList, write=SetList};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property TAdvPolyPage* ActivePage = {read=GetActivePage, write=SetActivePage};
	__property Constraints;
	__property Color = {default=-16777211};
	__property int PageMargin = {read=FPageMargin, write=SetPageMargin, default=1};
	__property Menus::TPopupMenu* PopupMenu = {read=GetPopupMenuEx, write=SetPopupMenuEx};
	__property ShowHint;
	__property bool TabReorder = {read=FTabReorder, write=FTabReorder, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Visible = {default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TDrawTabEvent OnDrawTab = {read=FOnDrawTab, write=FOnDrawTab};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
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
	__property Customitemscontainer::TAutoSizeMode ListAutoSizeMode = {read=GetAutoSizeMode, write=SetAutoSizeMode, nodefault};
	__property Customitemscontainer::TAutoSizeType ListAutoSizeType = {read=GetAutoSizeType, write=SetAutoSizeType, nodefault};
	__property Gdipfill::TGDIPFill* ListFill = {read=GetListFill, write=SetListFill};
	__property int ListHorizontalSpacing = {read=GetHorizontalSpacing, write=SetHorizontalSpacing, nodefault};
	__property int ListVerticalSpacing = {read=GetVerticalSpacing, write=SetVerticalSpacing, nodefault};
	__property Controls::TMargins* ListMargins = {read=GetListMargins, write=SetListMargins};
	__property bool ListReadOnly = {read=GetReadOnly, write=SetReadOnly, nodefault};
	__property bool ListReorder = {read=GetReorder, write=SetReorder, nodefault};
	__property bool ListShowFocus = {read=GetShowFocus, write=SetShowFocus, nodefault};
	__property Customitemscontainer::TListBorderMode ListBorderMode = {read=GetBorderMode, write=SetBorderMode, nodefault};
	__property Customitemscontainer::TListBorderTypes ListBorderTypes = {read=GetBorderTypes, write=SetBorderTypes, nodefault};
	__property Gdippicturecontainer::TGDIPPictureContainer* ListPictureContainer = {read=GetPictureContainer, write=SetPictureContainer};
	__property Imglist::TCustomImageList* ListImages = {read=GetImages, write=SetImages};
	__property Gdipcustomitem::TItemSelectEvent OnListItemSelect = {read=FOnListItemSelect, write=FOnListItemSelect};
	__property Gdipcustomitem::TItemSelectEvent OnListItemDeSelect = {read=FOnListItemDeSelect, write=FOnListItemDeSelect};
	__property Customitemscontainer::THandleAppearance* ListHandleAppearance = {read=GetHandleAppearance, write=SetHandleAppearance};
	__property Customitemscontainer::TScrollType ListScrollType = {read=GetScrollType, write=SetScrollType, nodefault};
	__property bool ListThumbTracking = {read=GetThumbTracking, write=SetThumbTracking, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPolyPager(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__IGDIPBase;	/* Gdipcustomitem::IGDIPBase */
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IGDIPBase()
	{
		Gdipcustomitem::_di_IGDIPBase intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGDIPBase*(void) { return (IGDIPBase*)&__IGDIPBase; }
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

}	/* namespace Advpolypager */
using namespace Advpolypager;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpolypagerHPP
