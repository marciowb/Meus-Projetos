// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Customitemscontainer.pas' rev: 21.00

#ifndef CustomitemscontainerHPP
#define CustomitemscontainerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uxtheme.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdipbase.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Gdipcustomitem.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Customitemscontainer
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
enum TListBorderType { btNormalLeft, btNormalTop, btNormalRight, btNormalBottom, btGradientLeft, btGradientTop, btGradientRight, btGradientBottom };
#pragma option pop

typedef Set<TListBorderType, btNormalLeft, btGradientBottom>  TListBorderTypes;

#pragma option push -b-
enum TListBorderMode { bmNormal, bmTransition };
#pragma option pop

#pragma option push -b-
enum TAutoSizeMode { asmControl, asmItems, asmNone };
#pragma option pop

#pragma option push -b-
enum TAutoSizeType { astWidth, astHeight, astBoth };
#pragma option pop

#pragma option push -b-
enum TListBorderTransition { btLeft, btTop, btRight, btBottom };
#pragma option pop

typedef Set<TListBorderTransition, btLeft, btBottom>  TListBorderTransitions;

#pragma option push -b-
enum TContainerConnection { ccLeft, ccTop, ccRight, ccBottom };
#pragma option pop

#pragma option push -b-
enum TContainerMode { cmNoBorder, cmNormalBorder, cmGradientBorder };
#pragma option pop

typedef void __fastcall (__closure *TDrawEvent)(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, const Advgdip::TGPRectF &ARect);

typedef void __fastcall (__closure *TScrollEvent)(System::TObject* Sender, int ScrollPosition);

typedef void __fastcall (__closure *TExpandEvent)(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool Expand);

class DELPHICLASS TScrollContainer;
class PASCALIMPLEMENTATION TScrollContainer : public Forms::TScrollingWinControl
{
	typedef Forms::TScrollingWinControl inherited;
	
private:
	Graphics::TCanvas* FCanvas;
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintWindow(HDC DC);
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	
public:
	__fastcall virtual TScrollContainer(Classes::TComponent* AOwner);
	__fastcall virtual ~TScrollContainer(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TScrollContainer(HWND ParentWindow) : Forms::TScrollingWinControl(ParentWindow) { }
	
};


class DELPHICLASS THandleAppearance;
class DELPHICLASS TCustomItemsContainer;
class PASCALIMPLEMENTATION THandleAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomItemsContainer* FOwner;
	System::Byte FOpacity;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColor;
	Classes::TNotifyEvent FOnChange;
	int FSize;
	Graphics::TColor FArrowColor;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall THandleAppearance(TCustomItemsContainer* AOwner);
	__fastcall virtual ~THandleAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Graphics::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=0};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=200};
	__property int Size = {read=FSize, write=SetSize, default=35};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TScrollType { stScrollers, stHandles };
#pragma option pop

class PASCALIMPLEMENTATION TCustomItemsContainer : public TScrollContainer
{
	typedef TScrollContainer inherited;
	
public:
	Gdipcustomitem::TCustomItem* operator[](int Index) { return Items[Index]; }
	
private:
	System::UnicodeString FShortCutChars;
	bool FShortCutItemHintShowing;
	Extctrls::TTimer* FScrollTimer;
	bool keepoldcursor;
	Controls::TCursor FoldCursor;
	Extctrls::TTimer* FHandleTimer;
	int FTimeDownOnArrow;
	bool HorzScrollVis;
	bool VertScrollVis;
	bool FHandleHorzLeftDown;
	bool FHandleHorzLeftHover;
	bool FHandleHorzRightDown;
	bool FHandleHorzRightHover;
	bool FHandleVertTopDown;
	bool FHandleVertTopHover;
	bool FHandleVertBottomDown;
	bool FHandleVertBottomHover;
	bool FDrawDragLine;
	Gdipcustomitem::TCustomItem* FDropItem;
	int FOldScrollHPos;
	int FOldScrollVPos;
	bool FMouseDown;
	bool FDragging;
	int FMouseDownOnItemX;
	int FMouseDownOnItemY;
	bool FMouseDownOnItem;
	Gdipcustomitem::TCustomItem* FDragDropItem;
	bool FListUpdating;
	bool FPosListUpdating;
	int FUpdateCount;
	Gdipbase::TCustomBaseList* FList;
	Gdipfill::TGDIPFill* FFill;
	int FListWidth;
	bool FReadOnly;
	Controls::TMargins* FListMargins;
	Classes::TNotifyEvent FOnChange;
	int FMinimumSize;
	int FRows;
	int FColumns;
	int FVerticalSpacing;
	int FHorizontalSpacing;
	TAutoSizeMode FAutoSizeMode;
	TAutoSizeType FAutoSizeType;
	bool FShowFocus;
	TListBorderMode FBorderMode;
	TListBorderTypes FBorderTypes;
	TDrawEvent FOnStartDraw;
	TDrawEvent FOnEndDraw;
	Gdipcustomitem::TItemSelectEvent FOnItemSelect;
	Gdipbase::TItemCompareEvent FOnItemCompare;
	Classes::TNotifyEvent FOnInternalChange;
	bool FReorder;
	THandleAppearance* FHandleAppearance;
	TScrollType FScrollType;
	int FHorzScrollPos;
	int FVertScrollPos;
	bool FThumbTracking;
	Forms::TFormBorderStyle FBorderStyle;
	TScrollEvent FOnVerticalScroll;
	TScrollEvent FOnHorizontalScroll;
	Gdipcustomitem::TItemSelectEvent FOnItemDeSelect;
	TExpandEvent FOnInternalExpand;
	bool FDragLine;
	Graphics::TColor FDragLineColor;
	bool FTransparent;
	bool FIsAppMenu;
	bool FIsMainMenu;
	void __fastcall SetList(const Gdipbase::TCustomBaseList* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetReadOnly(const bool Value);
	Gdipcustomitem::TCustomItem* __fastcall GetItem(int Index);
	void __fastcall SetItem(int Index, const Gdipcustomitem::TCustomItem* Value);
	void __fastcall SetListMargins(const Controls::TMargins* Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetRows(const int Value);
	void __fastcall SetHorizontalSpacing(const int Value);
	void __fastcall SetVerticalSpacing(const int Value);
	void __fastcall SetAutoSizeMode(const TAutoSizeMode Value);
	void __fastcall SetAutoSizeType(const TAutoSizeType Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetBorderMode(const TListBorderMode Value);
	void __fastcall SetBorderTypes(const TListBorderTypes Value);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDrag(Controls::TCMDrag &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Messages::TWMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	Imglist::TCustomImageList* __fastcall GetImageList(void);
	Gdippicturecontainer::TGDIPPictureContainer* __fastcall GetPictureContainer(void);
	void __fastcall SetImageList(const Imglist::TCustomImageList* Value);
	void __fastcall SetPictureContainer(const Gdippicturecontainer::TGDIPPictureContainer* Value);
	void __fastcall Expand(Gdipcustomitem::TCustomItem* Item, bool Expand);
	System::UnicodeString __fastcall GetVersion(void);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	void __fastcall SetReadorder(const bool Value);
	void __fastcall SetHandleAppearance(const THandleAppearance* Value);
	void __fastcall SetScrollType(const TScrollType Value);
	void __fastcall SetHorzScrollPos(const int Value);
	void __fastcall SetVertScrollPos(const int Value);
	Controls::TCursor __fastcall GetCursorEx(void);
	void __fastcall SetCursorEx(const Controls::TCursor Value);
	void __fastcall SetThumbTracking(const bool Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	void __fastcall Scrolling(System::TObject* Sender);
	void __fastcall SetDragLine(const bool Value);
	void __fastcall SetDragLineColor(const Graphics::TColor Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetIsMainMenu(const bool Value);
	
protected:
	__property int HorzScrollPos = {read=FHorzScrollPos, write=SetHorzScrollPos, nodefault};
	__property int VertScrollPos = {read=FVertScrollPos, write=SetVertScrollPos, nodefault};
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall UpdateControl(void);
	HIDESBASE void __fastcall UpdateScrollBars(void);
	void __fastcall UpdateList(void);
	void __fastcall UpdateItemPositions(void);
	void __fastcall UpdateItems(void);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall RefreshList(void);
	void __fastcall ListRefresh(System::TObject* Sender);
	void __fastcall ListChanged(System::TObject* Sender);
	void __fastcall ListItemCompare(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item1, Gdipcustomitem::TCustomItem* Item2, int &Result);
	void __fastcall Anchor(System::UnicodeString Anchor);
	Advgdip::TGPRectF __fastcall GetHandleHorzLeft(void);
	Advgdip::TGPRectF __fastcall GetHandleHorzRight(void);
	Advgdip::TGPRectF __fastcall GetHandleVertTop(void);
	Advgdip::TGPRectF __fastcall GetHandleVertBottom(void);
	bool __fastcall IsHandleHorzLeft(void);
	bool __fastcall IsHandleHorzRight(void);
	bool __fastcall IsHandleVertTop(void);
	bool __fastcall IsHandleVertBottom(void);
	void __fastcall ListItemSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall ListItemDeSelect(System::TObject* Sender, Gdipcustomitem::TCustomItem* Item, bool &Allow);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall HandleChanged(System::TObject* Sender);
	void __fastcall ListMarginsChanged(System::TObject* Sender);
	void __fastcall HandleTimerChanged(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall ReadItemState(Classes::TReader* Reader, Gdipcustomitem::TCustomItem* Item);
	void __fastcall SetItemParentComponent(Classes::TComponent* AParent, Gdipcustomitem::TCustomItem* Item);
	void __fastcall FillPictureNames(Classes::TGetStrProc Proc);
	void __fastcall GetPictures(Gdipcustomitem::TPictureContainerList* APictureList);
	int __fastcall GetTotalRowSize(void);
	int __fastcall GetTotalColumnSize(void);
	Gdipcustomitem::TCustomItem* __fastcall GetMaxColumnBoxItem(void);
	int __fastcall GetShadowOffset(void);
	int __fastcall GetVersionNr(void);
	__property TAutoSizeMode AutoSizeMode = {read=FAutoSizeMode, write=SetAutoSizeMode, default=1};
	__property TAutoSizeType AutoSizeType = {read=FAutoSizeType, write=SetAutoSizeType, default=0};
	__property Gdipbase::TCustomBaseList* List = {read=FList, write=SetList};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int HorizontalSpacing = {read=FHorizontalSpacing, write=SetHorizontalSpacing, default=5};
	__property int VerticalSpacing = {read=FVerticalSpacing, write=SetVerticalSpacing, default=5};
	__property Controls::TMargins* ListMargins = {read=FListMargins, write=SetListMargins};
	__property bool Reorder = {read=FReorder, write=SetReadorder, default=1};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property int Rows = {read=FRows, write=SetRows, default=0};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property TListBorderMode BorderMode = {read=FBorderMode, write=SetBorderMode, default=0};
	__property TListBorderTypes BorderTypes = {read=FBorderTypes, write=SetBorderTypes, default=15};
	__property System::UnicodeString Version = {read=GetVersion};
	__property TDrawEvent OnStartDraw = {read=FOnStartDraw, write=FOnStartDraw};
	__property TDrawEvent OnEndDraw = {read=FOnEndDraw, write=FOnEndDraw};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Gdipbase::TItemCompareEvent OnItemCompare = {read=FOnItemCompare, write=FOnItemCompare};
	__property Gdipcustomitem::TItemSelectEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property Gdipcustomitem::TItemSelectEvent OnItemDeSelect = {read=FOnItemDeSelect, write=FOnItemDeSelect};
	__property THandleAppearance* HandleAppearance = {read=FHandleAppearance, write=SetHandleAppearance};
	__property TScrollType ScrollType = {read=FScrollType, write=SetScrollType, default=0};
	__property Controls::TCursor Cursor = {read=GetCursorEx, write=SetCursorEx, nodefault};
	__property bool ThumbTracking = {read=FThumbTracking, write=SetThumbTracking, default=1};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	
public:
	__fastcall virtual TCustomItemsContainer(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__fastcall virtual ~TCustomItemsContainer(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DblClick(void);
	void __fastcall ApplyDefaultItemStyle(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property bool IsMainMenu = {read=FIsMainMenu, write=SetIsMainMenu, default=0};
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__property Gdipcustomitem::TCustomItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	int __fastcall ItemCount(void);
	__property Graphics::TColor DragLineColor = {read=FDragLineColor, write=SetDragLineColor, default=255};
	__property bool DragLine = {read=FDragLine, write=SetDragLine, default=1};
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawItems(Advgdip::TGPGraphics* g);
	void __fastcall DrawHandles(Advgdip::TGPGraphics* g);
	void __fastcall DrawDragLine(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect);
	void __fastcall Draw(Advgdip::TGPGraphics* g);
	void __fastcall ConnectContainer(TCustomItemsContainer* Container, TContainerConnection Connection, TContainerMode ContainerMode);
	Gdipcustomitem::TCustomItem* __fastcall SelectedDragDropItem(void);
	Gdipcustomitem::TCustomItem* __fastcall DropItem(void);
	Gdipcustomitem::TCustomItem* __fastcall AddDropItem(Gdipcustomitem::TCustomItem* it);
	Gdipcustomitem::TCustomItem* __fastcall AddItem(Gdipcustomitem::TCustomItemClass AClass);
	void __fastcall RemoveItem(int Index);
	void __fastcall ClearItems(void);
	void __fastcall SelectItem(int Index);
	void __fastcall UnSelectItem(int Index);
	void __fastcall VisualizeItem(int Index, bool AllowScrollItem = true, bool AllowSelectItem = true);
	void __fastcall ScrollToItem(int Index);
	Gdipcustomitem::TCustomItem* __fastcall InsertItem(int Index, Gdipcustomitem::TCustomItemClass AClass);
	__property Classes::TNotifyEvent OnInternalChange = {read=FOnInternalChange, write=FOnInternalChange};
	Graphics::TCanvas* __fastcall GetCanvas(void);
	__property TScrollEvent OnVerticalScroll = {read=FOnVerticalScroll, write=FOnVerticalScroll};
	__property TScrollEvent OnHorizontalScroll = {read=FOnHorizontalScroll, write=FOnHorizontalScroll};
	__property TExpandEvent OnInternalExpand = {read=FOnInternalExpand, write=FOnInternalExpand};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=GetPictureContainer, write=SetPictureContainer};
	__property Imglist::TCustomImageList* ImageList = {read=GetImageList, write=SetImageList};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	void __fastcall ChangeStyle(bool AWin7, int AStyle);
	void __fastcall ChangeMenu(Graphics::TColor AColor);
	void __fastcall UpdateMenu(void);
	void __fastcall HideMenu(void);
	void __fastcall ShowShortCutHints(void);
	void __fastcall HideShortCutHints(void);
	void __fastcall ShowMenuShortCuts(void);
	void __fastcall HideMenuShortCuts(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomItemsContainer(HWND ParentWindow) : TScrollContainer(ParentWindow) { }
	
private:
	void *__IWinStyle;	/* Advgdip::IWinStyle */
	void *__IGDIPExpand;	/* Gdipcustomitem::IGDIPExpand */
	void *__IGDIPAnchor;	/* Gdipcustomitem::IGDIPAnchor */
	void *__IPictureContainerSupport;	/* Gdipcustomitem::IPictureContainerSupport */
	void *__IGDIPBase;	/* Gdipcustomitem::IGDIPBase */
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advgdip::_di_IWinStyle()
	{
		Advgdip::_di_IWinStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IWinStyle*(void) { return (IWinStyle*)&__IWinStyle; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IGDIPExpand()
	{
		Gdipcustomitem::_di_IGDIPExpand intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGDIPExpand*(void) { return (IGDIPExpand*)&__IGDIPExpand; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IGDIPAnchor()
	{
		Gdipcustomitem::_di_IGDIPAnchor intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IGDIPAnchor*(void) { return (IGDIPAnchor*)&__IGDIPAnchor; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Gdipcustomitem::_di_IPictureContainerSupport()
	{
		Gdipcustomitem::_di_IPictureContainerSupport intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IPictureContainerSupport*(void) { return (IPictureContainerSupport*)&__IPictureContainerSupport; }
	#endif
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
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x4;
#define s_Edit L"Edit"

}	/* namespace Customitemscontainer */
using namespace Customitemscontainer;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CustomitemscontainerHPP
