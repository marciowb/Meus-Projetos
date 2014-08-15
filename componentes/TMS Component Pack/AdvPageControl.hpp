// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpagecontrol.pas' rev: 21.00

#ifndef AdvpagecontrolHPP
#define AdvpagecontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpagecontrol
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TTabStyle { tsClassic, tsDotNet, tsDelphi };
#pragma option pop

#pragma option push -b-
enum TClosePosition { cpLeft, cpRight };
#pragma option pop

typedef int TMarginSize;

typedef void __fastcall (__closure *TMarginChange)(TMarginSize NewValue, TMarginSize OldValue, int Index);

class DELPHICLASS TTabMargin;
class PASCALIMPLEMENTATION TTabMargin : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TMarginSize FLeftMargin;
	TMarginSize FTopMargin;
	TMarginSize FRightMargin;
	TMarginChange FOnMarginChange;
	void __fastcall SetMargin(int Index, TMarginSize Value);
	
protected:
	__property TMarginChange OnMarginChange = {read=FOnMarginChange, write=FOnMarginChange};
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TMarginSize LeftMargin = {read=FLeftMargin, write=SetMargin, index=0, default=0};
	__property TMarginSize TopMargin = {read=FTopMargin, write=SetMargin, index=1, default=0};
	__property TMarginSize RightMargin = {read=FRightMargin, write=SetMargin, index=2, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTabMargin(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TTabMargin(void) : Classes::TPersistent() { }
	
};


typedef void __fastcall (__closure *TCanCloseEvent)(System::TObject* Sender, bool &CanClose);

typedef void __fastcall (__closure *TCanChangeEvent)(System::TObject* Sender, int FromPage, int ToPage, bool &AllowChange);

class DELPHICLASS TAdvTabSheet;
class DELPHICLASS TAdvPageControl;
class PASCALIMPLEMENTATION TAdvTabSheet : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	System::UnicodeString FTabCaption;
	Graphics::TColor FTextColor;
	Graphics::TColor FTabColor;
	Graphics::TColor FTabColorTo;
	bool FShowClose;
	TGradientDirection FTabGradientDirection;
	TGradientDirection FHoverGradientDirection;
	Imglist::TImageIndex FImageIndex;
	Imglist::TImageIndex FImageIndexDummy;
	TAdvPageControl* FAdvPageControl;
	bool FTabVisible;
	bool FTabShowing;
	bool FHighlighted;
	Classes::TNotifyEvent FOnHide;
	Classes::TNotifyEvent FOnShow;
	Classes::TNotifyEvent FOnClose;
	TCanCloseEvent FOnCanClose;
	bool FTabEnable;
	Graphics::TColor FColorTo;
	Controls::TCaption __fastcall GetCaption(void);
	void __fastcall SetCaption(Controls::TCaption Value);
	int __fastcall GetPageIndex(void);
	int __fastcall GetTabIndex(void);
	void __fastcall SetHighlighted(bool Value);
	Imglist::TImageIndex __fastcall GetImageIndex(void);
	void __fastcall SetImageIndex(Imglist::TImageIndex Value);
	void __fastcall SetAdvPageControl(TAdvPageControl* AAdvPageControl);
	void __fastcall SetPageIndex(int Value);
	void __fastcall SetTabShowing(bool Value);
	void __fastcall SetTabVisible(bool Value);
	void __fastcall UpdateTabShowing(void);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	void __fastcall CloseButtonClick(System::TObject* Sender);
	bool __fastcall CanCloseClick(System::TObject* Sender);
	void __fastcall SetShowClose(bool value);
	void __fastcall SetTabGradientDirection(TGradientDirection value);
	void __fastcall SetHoverGradientDirection(TGradientDirection value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTabColor(const Graphics::TColor Value);
	void __fastcall SetTabColorTo(const Graphics::TColor Value);
	void __fastcall SetTabEnable(const bool Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoHide(void);
	DYNAMIC void __fastcall DoShow(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall Paint(void);
	__property System::UnicodeString TabCaption = {read=FTabCaption};
	__property Imglist::TImageIndex ImageIndexDummy = {read=FImageIndexDummy, nodefault};
	
public:
	__fastcall virtual TAdvTabSheet(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvTabSheet(void);
	__property TAdvPageControl* AdvPageControl = {read=FAdvPageControl, write=SetAdvPageControl};
	__property int TabIndex = {read=GetTabIndex, nodefault};
	void __fastcall SelectFirstControl(void);
	
__published:
	__property BorderWidth = {default=0};
	__property Controls::TCaption Caption = {read=GetCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Height = {stored=false};
	__property bool Highlighted = {read=FHighlighted, write=SetHighlighted, default=0};
	__property Imglist::TImageIndex ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=0};
	__property Left = {stored=false};
	__property Constraints;
	__property TGradientDirection HoverGradientDirection = {read=FHoverGradientDirection, write=SetHoverGradientDirection, default=0};
	__property TGradientDirection TabGradientDirection = {read=FTabGradientDirection, write=SetTabGradientDirection, default=0};
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property bool ShowClose = {read=FShowClose, write=SetShowClose, default=0};
	__property bool TabEnable = {read=FTabEnable, write=SetTabEnable, default=1};
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property Graphics::TColor TabColor = {read=FTabColor, write=SetTabColor, nodefault};
	__property Graphics::TColor TabColorTo = {read=FTabColorTo, write=SetTabColorTo, nodefault};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property Top = {stored=false};
	__property Visible = {stored=false, default=1};
	__property Width = {stored=false};
	__property TCanCloseEvent OnCanClose = {read=FOnCanClose, write=FOnCanClose};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTabSheet(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


typedef ShortInt TTabOverlapSize;

class PASCALIMPLEMENTATION TAdvPageControl : public Comctrls::TCustomTabControl
{
	typedef Comctrls::TCustomTabControl inherited;
	
private:
	Classes::TList* FPages;
	TAdvTabSheet* FActivePage;
	TAdvTabSheet* FNewDockSheet;
	TAdvTabSheet* FUndockingPage;
	TTabMargin* FTabMargin;
	Classes::TStringList* FClosedTabList;
	Classes::TNotifyEvent FOnChange;
	Imglist::TCustomImageList* FImages;
	Imglist::TCustomImageList* FDummyImages;
	Graphics::TColor FDefaultTextColor;
	Graphics::TColor FDefaultTabColor;
	Graphics::TColor FDefaultTabColorTo;
	Graphics::TColor FActiveColor;
	Graphics::TColor FActiveColorTo;
	bool FTabBorder3D;
	Graphics::TColor FTabBorderColor;
	Graphics::TColor FTabHoverColor;
	Graphics::TColor FTabHoverColorTo;
	Graphics::TColor FTabHoverBorder;
	bool FShowFocus;
	bool FHoverClosedButton;
	TTabOverlapSize FTabOverlap;
	bool FTabSheet3D;
	Graphics::TColor FTabSheetBorderColor;
	Graphics::TColor FTabBackGroundColor;
	bool FTabSplitLine;
	bool FRoundEdges;
	int FHoverTab;
	Graphics::TBitmap* FTabBackGround;
	Graphics::TBitmap* FTabBackGroundActive;
	TTabStyle FTabStyle;
	int FLowerActive;
	bool FPropertiesLoaded;
	bool FFreeOnClose;
	Graphics::TFont* FActiveFont;
	TCanChangeEvent FOnCanChange;
	Graphics::TBitmap* FCloseGlyph;
	bool FFullRefresh;
	Comctrls::TDrawTabEvent FOnDrawTab;
	int FUpdateCount;
	TClosePosition FClosePosition;
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	void __fastcall ActiveFontChangeEvent(System::TObject* Sender);
	void __fastcall UpdateTabForActiveFont(TAdvTabSheet* Page);
	void __fastcall ChangeActivePage(TAdvTabSheet* Page);
	void __fastcall DeleteTab(TAdvTabSheet* Page, int Index);
	int __fastcall GetActivePageIndex(void);
	Controls::TControl* __fastcall GetDockClientFromMousePos(const Types::TPoint &MousePos);
	TAdvTabSheet* __fastcall GetPage(int Index);
	int __fastcall GetPageCount(void);
	void __fastcall InsertPage(TAdvTabSheet* Page);
	void __fastcall InsertTab(TAdvTabSheet* Page);
	void __fastcall MoveTab(int CurIndex, int NewIndex);
	void __fastcall RemovePage(TAdvTabSheet* Page);
	void __fastcall SetActivePage(TAdvTabSheet* Page);
	void __fastcall SetActivePageIndex(const int Value);
	void __fastcall SetDefaultTextColor(const Graphics::TColor Value);
	void __fastcall SetDefaultTabColor(const Graphics::TColor Value);
	void __fastcall SetDefaultTabColorTo(const Graphics::TColor Value);
	void __fastcall SetActiveColor(const Graphics::TColor Value);
	void __fastcall SetActiveColorTo(const Graphics::TColor Value);
	void __fastcall SetTabBorder3D(bool Value);
	void __fastcall SetTabBorderColor(const Graphics::TColor Value);
	void __fastcall SetTabBackGround(const Graphics::TBitmap* Value);
	void __fastcall SetTabBackGroundActive(const Graphics::TBitmap* Value);
	HIDESBASE void __fastcall SetImages(Imglist::TCustomImageList* value);
	void __fastcall SetTabMargin(TTabMargin* Value);
	void __fastcall SetTabOverlap(TTabOverlapSize Value);
	void __fastcall SetTabSheet3D(bool Value);
	void __fastcall SetTabSheetBorderColor(Graphics::TColor Value);
	void __fastcall SetTabBackGroundColor(Graphics::TColor Value);
	void __fastcall SetTabSplitLine(bool Value);
	void __fastcall SetRoundEdges(bool Value);
	void __fastcall SetTabStyle(TTabStyle Value);
	void __fastcall SetLowerActive(int Value);
	Comctrls::TTabPosition __fastcall GetTabPosition(void);
	HIDESBASE void __fastcall SetTabPosition(Comctrls::TTabPosition Value);
	void __fastcall SetTabMargins(void);
	void __fastcall DrawCloseGlyph(const Types::TPoint &P);
	void __fastcall DrawCloseButton(const Types::TRect &Rect, bool Active);
	void __fastcall DrawHoverCloseButton(const Types::TRect &Rect);
	void __fastcall DrawDownCloseButton(const Types::TRect &Rect);
	bool __fastcall IsOnButton(int TabIndex, int X, int Y);
	void __fastcall TabMarginChange(TMarginSize NewValue, TMarginSize OldValue, int Index);
	void __fastcall UpdateTab(TAdvTabSheet* Page);
	void __fastcall UpdateTabHighlights(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDockClient(Controls::TCMDockClient &Message);
	MESSAGE void __fastcall CMDockNotification(Controls::TCMDockNotification &Message);
	HIDESBASE MESSAGE void __fastcall CMUnDockClient(Controls::TCMUnDockClient &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	void __fastcall SetActiveFont(const Graphics::TFont* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetCloseGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetClosePosition(const TClosePosition Value);
	
protected:
	virtual bool __fastcall CanShowTab(int TabIndex);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoAddDockClient(Controls::TControl* Client, const Types::TRect &ARect);
	DYNAMIC void __fastcall DockOver(Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DoRemoveDockClient(Controls::TControl* Client);
	virtual int __fastcall GetImageIndex(int TabIndex);
	TAdvTabSheet* __fastcall GetPageFromDockClient(Controls::TControl* Client);
	DYNAMIC void __fastcall GetSiteInfo(Controls::TControl* Client, Types::TRect &InfluenceRect, const Types::TPoint &MousePos, bool &CanDock);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	virtual void __fastcall ShowControl(Controls::TControl* AControl);
	virtual void __fastcall UpdateActivePage(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall TabChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall DrawAllTabs(Graphics::TCanvas* Canvas);
	Types::TRect __fastcall TabRectEx(int i);
	int __fastcall IndexOfTabAtEx(int X, int Y);
	DYNAMIC bool __fastcall CanChange(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
public:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TAdvPageControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPageControl(void);
	TAdvTabSheet* __fastcall FindNextPage(TAdvTabSheet* CurPage, bool GoForward, bool CheckTabVisible);
	void __fastcall SelectNextPage(bool GoForward);
	void __fastcall OpenAllClosedTabs(void);
	bool __fastcall OpenClosedTab(System::UnicodeString TabName);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int PageCount = {read=GetPageCount, nodefault};
	__property TAdvTabSheet* Pages[int Index] = {read=GetPage};
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property bool FullRefresh = {read=FFullRefresh, write=FFullRefresh, nodefault};
	
__published:
	__property TAdvTabSheet* ActivePage = {read=FActivePage, write=SetActivePage};
	__property Graphics::TFont* ActiveFont = {read=FActiveFont, write=SetActiveFont};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property Graphics::TBitmap* CloseGlyph = {read=FCloseGlyph, write=SetCloseGlyph};
	__property TClosePosition ClosePosition = {read=FClosePosition, write=SetClosePosition, default=0};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HotTrack = {default=0};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property MultiLine = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RaggedRight = {default=0};
	__property ScrollOpposite = {default=0};
	__property ShowHint;
	__property bool FreeOnClose = {read=FFreeOnClose, write=FFreeOnClose, default=0};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=0};
	__property Graphics::TColor DefaultTextColor = {read=FDefaultTextColor, write=SetDefaultTextColor, default=0};
	__property Graphics::TColor DefaultTabColor = {read=FDefaultTabColor, write=SetDefaultTabColor, default=-16777201};
	__property Graphics::TColor DefaultTabColorTo = {read=FDefaultTabColorTo, write=SetDefaultTabColorTo, default=536870911};
	__property Graphics::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, default=-16777201};
	__property Graphics::TColor ActiveColorTo = {read=FActiveColorTo, write=SetActiveColorTo, default=536870911};
	__property bool TabBorder3D = {read=FTabBorder3D, write=SetTabBorder3D, default=0};
	__property Graphics::TColor TabBorderColor = {read=FTabBorderColor, write=SetTabBorderColor, default=8421504};
	__property bool TabSheet3D = {read=FTabSheet3D, write=SetTabSheet3D, default=0};
	__property Graphics::TColor TabSheetBorderColor = {read=FTabSheetBorderColor, write=SetTabSheetBorderColor, default=8421504};
	__property Graphics::TColor TabHoverColor = {read=FTabHoverColor, write=FTabHoverColor, default=536870911};
	__property Graphics::TColor TabHoverColorTo = {read=FTabHoverColorTo, write=FTabHoverColorTo, default=536870911};
	__property Graphics::TColor TabHoverBorder = {read=FTabHoverBorder, write=FTabHoverBorder, default=536870911};
	__property Graphics::TColor TabBackGroundColor = {read=FTabBackGroundColor, write=SetTabBackGroundColor, nodefault};
	__property Graphics::TBitmap* TabBackGround = {read=FTabBackGround, write=SetTabBackGround};
	__property Graphics::TBitmap* TabBackGroundActive = {read=FTabBackGroundActive, write=SetTabBackGroundActive};
	__property TTabMargin* TabMargin = {read=FTabMargin, write=SetTabMargin};
	__property TTabOverlapSize TabOverlap = {read=FTabOverlap, write=SetTabOverlap, nodefault};
	__property bool TabSplitLine = {read=FTabSplitLine, write=SetTabSplitLine, default=0};
	__property bool RoundEdges = {read=FRoundEdges, write=SetRoundEdges, default=0};
	__property TTabStyle TabStyle = {read=FTabStyle, write=SetTabStyle, default=0};
	__property int LowerActive = {read=FLowerActive, write=SetLowerActive, default=2};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TabHeight = {default=0};
	__property TabOrder = {default=-1};
	__property TabPosition = {read=GetTabPosition, write=SetTabPosition, default=0};
	__property TabStop = {default=1};
	__property TabWidth = {default=0};
	__property Visible = {default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnChanging;
	__property TCanChangeEvent OnCanChange = {read=FOnCanChange, write=FOnCanChange};
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property Comctrls::TDrawTabEvent OnDrawTab = {read=FOnDrawTab, write=FOnDrawTab};
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetImageIndex;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPageControl(HWND ParentWindow) : Comctrls::TCustomTabControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CloseButtonWidth = 0xe;
static const ShortInt CloseButtonHeight = 0xd;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x6;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advpagecontrol */
using namespace Advpagecontrol;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpagecontrolHPP
