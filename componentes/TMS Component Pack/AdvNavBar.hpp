// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advnavbar.pas' rev: 21.00

#ifndef AdvnavbarHPP
#define AdvnavbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advnavbar
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TBottomIconAlign { biLeft, biRight };
#pragma option pop

#pragma option push -b-
enum TDefaultTabPosition { tpTop, tpBottom };
#pragma option pop

class DELPHICLASS TAdvNavBarPanelSection;
class DELPHICLASS TAdvNavBarPanel;
class PASCALIMPLEMENTATION TAdvNavBarPanelSection : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FHeight;
	System::UnicodeString FCaption;
	int FTag;
	Controls::TWinControl* FControl;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetControl(const Controls::TWinControl* Value);
	void __fastcall UpdateControlBounds(void);
	TAdvNavBarPanel* __fastcall GetOwnerPanel(void);
	
public:
	__fastcall virtual TAdvNavBarPanelSection(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvNavBarPanelSection(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property int Height = {read=FHeight, write=SetHeight, default=48};
	__property int Tag = {read=FTag, write=FTag, default=0};
};


class DELPHICLASS TAdvNavBarPanelSections;
class PASCALIMPLEMENTATION TAdvNavBarPanelSections : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvNavBarPanelSection* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvNavBarPanel* FOwner;
	HIDESBASE TAdvNavBarPanelSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvNavBarPanelSection* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvNavBarPanelSections(TAdvNavBarPanel* AOwner);
	HIDESBASE TAdvNavBarPanelSection* __fastcall Add(void);
	HIDESBASE TAdvNavBarPanelSection* __fastcall Insert(int Index);
	__property TAdvNavBarPanelSection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvNavBarPanelSections(void) { }
	
};


class DELPHICLASS TAdvNavBar;
class PASCALIMPLEMENTATION TAdvNavBarPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Graphics::TFontStyles FFontStyles;
	TAdvNavBar* FAdvNavBar;
	Graphics::TColor FTextColor;
	int FImageIndex;
	int FPanelIndex;
	System::UnicodeString FCaption;
	System::UnicodeString FCollapsedCaption;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	TAdvNavBarPanelSections* FSections;
	bool FSizing;
	int FSizeSection;
	int FSizeHeight;
	int FSizeY;
	bool FTabVisible;
	bool FSectionSizing;
	System::UnicodeString FCaptionHint;
	Classes::TAlignment FCaptionAlignment;
	void __fastcall SetAdvNavBar(TAdvNavBar* Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCollapsedCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetFPanelIndex(const int Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	bool __fastcall GetEnable(void);
	void __fastcall SetEnable(const bool Value);
	bool __fastcall GetTabVisible(void);
	void __fastcall SetTabVisible(const bool Value);
	System::UnicodeString __fastcall GetAdjustedCaption(void);
	void __fastcall UpdateControlBounds(void);
	void __fastcall SetCaptionAlignment(const Classes::TAlignment Value);
	void __fastcall SetFontStyles(const Graphics::TFontStyles Value);
	
protected:
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	void __fastcall SetPosInAdvNavBar(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvNavBarPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvNavBarPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TAdvNavBar* AdvNavBar = {read=FAdvNavBar, write=SetAdvNavBar};
	__property bool TabVisible = {read=GetTabVisible, write=SetTabVisible, nodefault};
	__property System::UnicodeString AdjustedCaption = {read=GetAdjustedCaption};
	
__published:
	__property System::UnicodeString Caption = {read=GetCaption, write=SetCaption};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property System::UnicodeString CaptionHint = {read=FCaptionHint, write=FCaptionHint};
	__property Graphics::TFontStyles CaptionStyle = {read=FFontStyles, write=SetFontStyles, nodefault};
	__property System::UnicodeString CollapsedCaption = {read=FCollapsedCaption, write=SetCollapsedCaption};
	__property Color = {default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property Font;
	__property Hint;
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int PanelIndex = {read=FPanelIndex, write=SetFPanelIndex, nodefault};
	__property PopupMenu;
	__property TAdvNavBarPanelSections* Sections = {read=FSections, write=FSections};
	__property bool SectionSizing = {read=FSectionSizing, write=FSectionSizing, default=0};
	__property ShowHint;
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property bool Enabled = {read=GetEnable, write=SetEnable, default=1};
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnExit;
	__property OnEnter;
	__property OnResize;
	__property OnStartDrag;
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvNavBarPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class DELPHICLASS TExchangeScroller;
class PASCALIMPLEMENTATION TExchangeScroller : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FMin;
	int FMax;
	int FPosition;
	bool FVisible;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TExchangeScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TExchangeScroller(void) { }
	
};


#pragma option push -b-
enum TAdvNavBarStyle { esOffice2003Blue, esOffice2003Silver, esOffice2003Olive, esOffice2003Classic, esOffice2007Luna, esOffice2007Obsidian, esWindowsXP, esWhidbey, esCustom, esOffice2007Silver, esWindowsVista, esWindows7, esTerminal, esOffice2010Blue, esOffice2010Silver, esOffice2010Black };
#pragma option pop

typedef void __fastcall (__closure *TOnPanelActivate)(System::TObject* Sender, int OldActivePanel, int NewActivePanel, bool &Allow);

typedef void __fastcall (__closure *TSplitterMove)(System::TObject* Sender, int OldSplitterPosition, int NewSplitterPosition);

#pragma option push -b-
enum TPanelOrder { poBottomToTop, poTopToBottom };
#pragma option pop

class PASCALIMPLEMENTATION TAdvNavBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TList* FAdvNavBarPanel;
	Classes::TList* FDupAdvNavBarPanel;
	Classes::TList* FTempAdvNavBarPanel;
	int FSeparatorLine;
	int FCaptionTabHeight;
	Graphics::TColor FActiveColor;
	Graphics::TColor FActiveColorTo;
	Graphics::TColor FDefaultTabColor;
	Graphics::TColor FDefaultTabColorTo;
	Graphics::TColor FDefaultTextColor;
	int FActiveTabIndex;
	int FHoverTabIndex;
	int FDownTabIndex;
	Graphics::TColor FSplitterColor;
	Graphics::TColor FSplitterColorTo;
	Controls::TCursor FOldCursor;
	bool FMouseCaptured;
	bool FCheckForSplitterMove;
	int FDisplayCaptionTabsCount;
	Graphics::TColor FHoverTabColor;
	Graphics::TColor FHoverTabColorTo;
	Graphics::TColor FDownTabColorTo;
	Graphics::TColor FDownTabColor;
	Imglist::TCustomImageList* FImages;
	int FMinClientHeight;
	TGradientDirection FDefaultGradientDirection;
	int FFixedBtnMargin;
	TBottomIconAlign FBottomIconAlign;
	int FSplitterPosition;
	int FTempSplitterPos;
	bool FPropertiesLoaded;
	TExchangeScroller* FScroller;
	bool FScrollerHoverLeftBtn;
	bool FScrollerDownLeftBtn;
	bool FScrollerHoverRightBtn;
	bool FScrollerDownRightBtn;
	bool FPopupIndicatorHover;
	bool FPopupIndicatorDown;
	TAdvNavBarPanel* FActivePanel;
	bool FPropertiesCreated;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionColorTo;
	Graphics::TFont* FCaptionFont;
	Graphics::TColor FBorderColor;
	TAdvNavBarStyle FStyle;
	Graphics::TColor FSectionColorTo;
	Graphics::TColor FSectionColor;
	Graphics::TFont* FSectionFont;
	TOnPanelActivate FOnTPanelActivate;
	TSplitterMove FOnSplitterMove;
	bool FPopupIndicator;
	Classes::TNotifyEvent FOnPopupMenuClick;
	System::UnicodeString FOriginalHint;
	bool FSplitterInternalCall;
	bool FAutoThemeAdapt;
	TDefaultTabPosition FDefaultTabPosition;
	bool FInternalCall;
	Graphics::TColor FDownTextColor;
	Graphics::TColor FHoverTextColor;
	Imglist::TCustomImageList* FSmallImages;
	int FOldSplitterPosForSizeChange;
	bool FInternalSplitterMove;
	bool FMouseDown;
	int FUpdateCount;
	bool FCollapsed;
	int FPreCollapsedWidth;
	bool FIsCollapsing;
	System::UnicodeString FCollapsedCaption;
	bool FAllowCollaps;
	bool FHoverCollapsedCaption;
	bool FDownCollapsedCaption;
	bool FCollapsDown;
	int FCollapsedWidth;
	Graphics::TColor FHoverTabMirrorColor;
	Graphics::TColor FHoverTabMirrorColorTo;
	Graphics::TColor FDownTabMirrorColor;
	Graphics::TColor FDownTabMirrorColorTo;
	Graphics::TColor FActiveMirrorColor;
	Graphics::TColor FActiveMirrorColorTo;
	Graphics::TColor FDefaultTabMirrorColor;
	Graphics::TColor FDefaultTabMirrorColorTo;
	Graphics::TColor FCollapsedDownColor;
	Graphics::TColor FCollapsedDownColorTo;
	Graphics::TColor FCollapsedHoverColor;
	Graphics::TColor FCollapsedHoverColorTo;
	Classes::TNotifyEvent FOnCollapsedClick;
	Classes::TNotifyEvent FOnCollapsChange;
	int FCaptionHintIndex;
	bool FShowSplitter;
	bool FHoverCollapsBtn;
	bool FDoEraseBkg;
	Classes::TAlignment FCaptionAlignment;
	bool FReverseOrder;
	Graphics::TColor FSplitterBorderColor;
	bool FCaptionVisible;
	bool FShowShortCutBar;
	Forms::TFormBorderStyle FBorderStyle;
	void __fastcall SetCaptionTabHeight(int Value);
	void __fastcall ShowAdvNavBarPanel(int PanelIndex);
	void __fastcall SetAllAdvNavBarPanelPosition(void);
	void __fastcall DrawAllCaptionTabs(void);
	void __fastcall DrawCaptionTab(int Index);
	void __fastcall DrawFixedTab(void);
	void __fastcall DrawCaption(void);
	void __fastcall DrawAllFixedTabButtons(void);
	void __fastcall DrawFixedTabButton(int Index);
	void __fastcall DrawScrollButtons(void);
	void __fastcall DrawScrollBtnLeft(const Types::TRect &R);
	void __fastcall DrawScrollBtnRight(const Types::TRect &R);
	void __fastcall DrawCollapsButton(bool Collaps);
	bool __fastcall PtInCollapsButton(int X, int Y);
	void __fastcall DrawPopupIndicator(void);
	void __fastcall RefreshCaptionTabOrButton(int index);
	void __fastcall DrawSplitter(void);
	void __fastcall SetActiveColor(const Graphics::TColor Value);
	void __fastcall SetActiveColorTo(const Graphics::TColor Value);
	void __fastcall SetDefaultTabColor(const Graphics::TColor Value);
	void __fastcall SetDefaultTabColorTo(const Graphics::TColor Value);
	void __fastcall SetDefaultTextColor(const Graphics::TColor Value);
	void __fastcall SetActiveTabIndex(const int Value);
	int __fastcall GetActiveTabIndex(void);
	Types::TRect __fastcall GetSplitterRect(void);
	Types::TRect __fastcall GetCaptionRect(void);
	bool __fastcall PtOnSplitter(const Types::TPoint &P);
	void __fastcall UpdateScroller(void);
	bool __fastcall MoveSplitterTo(int Y);
	int __fastcall MoveSplitterInTabs(int TabCount);
	Types::TRect __fastcall GetFixedTabRect(void);
	Types::TRect __fastcall FixedTabButtonRect(int index);
	int __fastcall FixedBtnMinIndex(void);
	int __fastcall FixedBtnMaxIndex(void);
	int __fastcall GetFixedTabButtonCount(void);
	int __fastcall GetFixedTabButtonMaxCount(void);
	bool __fastcall PtOnScrollLeftBtn(int X, int Y);
	bool __fastcall PtOnScrollRightBtn(int X, int Y);
	bool __fastcall PtOnPopupIndicator(int X, int Y);
	void __fastcall ShowScrollButtons(void);
	void __fastcall HideScrollButtons(void);
	void __fastcall ScrollLeftBtnClick(void);
	void __fastcall ScrollRightBtnClick(void);
	void __fastcall SetHoverTabColor(const Graphics::TColor Value);
	void __fastcall SetHoverTabColorTo(const Graphics::TColor Value);
	void __fastcall SetDownTabColor(const Graphics::TColor Value);
	void __fastcall SetDownTabColorTo(const Graphics::TColor Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetMinClientHeight(const int Value);
	void __fastcall SetDefaultGradientDirection(const TGradientDirection Value);
	void __fastcall SetBottomIconAlign(const TBottomIconAlign Value);
	void __fastcall SetSplitterPosition(const int Value);
	void __fastcall SetActivePanel(const TAdvNavBarPanel* Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetCaptionColorTo(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetSectionFont(const Graphics::TFont* Value);
	void __fastcall SetSplitterColor(const Graphics::TColor Value);
	void __fastcall SetSplitterColorTo(const Graphics::TColor Value);
	void __fastcall SetStyle(const TAdvNavBarStyle Value);
	void __fastcall SetSectionColor(const Graphics::TColor Value);
	void __fastcall SetSectionColorTo(const Graphics::TColor Value);
	void __fastcall SetPopupIndicator(const bool Value);
	void __fastcall ThemeAdapt(void);
	void __fastcall SetDefaultTabPosition(const TDefaultTabPosition Value);
	int __fastcall GetDupIndex(int Index);
	int __fastcall GetDisplayIndex(int Index);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetDownTextColor(const Graphics::TColor Value);
	void __fastcall SetHoverTextColor(const Graphics::TColor Value);
	void __fastcall SetSmallImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetCollapsed(const bool Value);
	void __fastcall SetCollapsedCaption(const System::UnicodeString Value);
	void __fastcall DrawCollapsedCaption(void);
	void __fastcall SetAllowCollaps(const bool Value);
	void __fastcall SetDownTabMirrorColor(const Graphics::TColor Value);
	void __fastcall SetDownTabMirrorColorTo(const Graphics::TColor Value);
	void __fastcall SetHoverTabMirrorColor(const Graphics::TColor Value);
	void __fastcall SetHoverTabMirrorColorTo(const Graphics::TColor Value);
	void __fastcall SetActiveMirrorColor(const Graphics::TColor Value);
	void __fastcall SetActiveMirrorColorTo(const Graphics::TColor Value);
	void __fastcall SetDefaultTabMirrorColor(const Graphics::TColor Value);
	void __fastcall SetDefaultTabMirrorColorTo(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Controls::TCMHintShow &Msg);
	void __fastcall SetShowSplitter(const bool Value);
	HIDESBASE void __fastcall FontChanged(System::TObject* sender);
	void __fastcall SetCaptionAlignment(const Classes::TAlignment Value);
	int __fastcall CaptionTabMaxIndex(void);
	void __fastcall SetReverseOrder(const bool Value);
	TPanelOrder __fastcall GetPanelOrder(void);
	void __fastcall SetPanelOrder(const TPanelOrder Value);
	void __fastcall SetSplitterBorderColor(const Graphics::TColor Value);
	void __fastcall SetCaptionVisible(const bool Value);
	void __fastcall SetShowShortCutBar(const bool Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	Types::TRect __fastcall CaptionTabRect(int Index);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SetAdvNavBarPanelPosition(TAdvNavBarPanel* AAdvNavBarPanel);
	__property int CaptionTabHeight = {read=FCaptionTabHeight, write=SetCaptionTabHeight, nodefault};
	virtual Types::TRect __fastcall GetClientRect(void);
	void __fastcall InsertAdvNavBarPanel(TAdvNavBarPanel* Value);
	void __fastcall RemoveAdvNavBarPanel(TAdvNavBarPanel* Value);
	TAdvNavBarPanel* __fastcall GetPanel(int Index);
	int __fastcall GetPanelCount(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall UpdateList(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall DoChange(void);
	virtual bool __fastcall CanResize(int &NewWidth, int &NewHeight);
	int __fastcall SplitterHeight(void);
	DYNAMIC void __fastcall Click(void);
	bool __fastcall IsOffice2010(void);
	int __fastcall GetIndicatorWidth(void);
	int __fastcall GetCaptionHeight(void);
	int __fastcall GetCaptionTabHeight(void);
	int __fastcall GetFixedCaptionTabHeight(void);
	
public:
	__fastcall virtual TAdvNavBar(Classes::TComponent* Aowner);
	__fastcall virtual ~TAdvNavBar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual TAdvNavBarPanel* __fastcall CreatePanel(void);
	TAdvNavBarPanel* __fastcall AddPanel(void);
	TAdvNavBarPanel* __fastcall InsertPanel(int Index);
	void __fastcall RemovePanel(int Index);
	void __fastcall MovePanel(int FromIndex, int ToIndex);
	__property TAdvNavBarPanel* Panels[int Index] = {read=GetPanel};
	__property int PanelCount = {read=GetPanelCount, nodefault};
	__property bool DoEraseBkg = {read=FDoEraseBkg, write=FDoEraseBkg, nodefault};
	void __fastcall SelectNextPanel(void);
	void __fastcall SelectPreviousPanel(void);
	int __fastcall IndexOfTabAt(int X, int Y);
	int __fastcall IndexOfCaptionTabAt(int X, int Y);
	int __fastcall IndexOfBtnAt(int X, int Y);
	int __fastcall FindNextPanelIndex(int CurIndex, bool GoForward);
	TAdvNavBarPanel* __fastcall FindNextPanel(TAdvNavBarPanel* CurPanel, bool GoForward);
	__property TAdvNavBarPanel* ActivePanel = {read=FActivePanel, write=SetActivePanel};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Graphics::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, default=-16777201};
	__property Graphics::TColor ActiveColorTo = {read=FActiveColorTo, write=SetActiveColorTo, default=536870911};
	__property Graphics::TColor ActiveMirrorColor = {read=FActiveMirrorColor, write=SetActiveMirrorColor, default=536870911};
	__property Graphics::TColor ActiveMirrorColorTo = {read=FActiveMirrorColorTo, write=SetActiveMirrorColorTo, default=536870911};
	__property int ActiveTabIndex = {read=GetActiveTabIndex, write=SetActiveTabIndex, nodefault};
	__property bool AllowCollaps = {read=FAllowCollaps, write=SetAllowCollaps, default=0};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property TBottomIconAlign BottomIconAlign = {read=FBottomIconAlign, write=SetBottomIconAlign, default=1};
	__property bool CaptionVisible = {read=FCaptionVisible, write=SetCaptionVisible, default=1};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=8421504};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=SetCaptionColorTo, default=536870911};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property bool Collapsed = {read=FCollapsed, write=SetCollapsed, default=0};
	__property System::UnicodeString CollapsedCaption = {read=FCollapsedCaption, write=SetCollapsedCaption};
	__property int CollapsedWidth = {read=FCollapsedWidth, write=FCollapsedWidth, default=40};
	__property Graphics::TColor CollapsedHoverColor = {read=FCollapsedHoverColor, write=FCollapsedHoverColor, default=-16777192};
	__property Graphics::TColor CollapsedHoverColorTo = {read=FCollapsedHoverColorTo, write=FCollapsedHoverColorTo, default=536870911};
	__property Graphics::TColor CollapsedDownColor = {read=FCollapsedDownColor, write=FCollapsedDownColor, default=12632256};
	__property Graphics::TColor CollapsedDownColorTo = {read=FCollapsedDownColorTo, write=FCollapsedDownColorTo, default=536870911};
	__property Constraints;
	__property TGradientDirection DefaultGradientDirection = {read=FDefaultGradientDirection, write=SetDefaultGradientDirection, nodefault};
	__property Graphics::TColor DefaultTextColor = {read=FDefaultTextColor, write=SetDefaultTextColor, default=0};
	__property Graphics::TColor DefaultTabColor = {read=FDefaultTabColor, write=SetDefaultTabColor, default=16777215};
	__property Graphics::TColor DefaultTabColorTo = {read=FDefaultTabColorTo, write=SetDefaultTabColorTo, default=-16777201};
	__property Graphics::TColor DefaultTabMirrorColor = {read=FDefaultTabMirrorColor, write=SetDefaultTabMirrorColor, default=536870911};
	__property Graphics::TColor DefaultTabMirrorColorTo = {read=FDefaultTabMirrorColorTo, write=SetDefaultTabMirrorColorTo, default=536870911};
	__property TDefaultTabPosition DefaultTabPosition = {read=FDefaultTabPosition, write=SetDefaultTabPosition, default=1};
	__property Graphics::TColor DownTabColor = {read=FDownTabColor, write=SetDownTabColor, nodefault};
	__property Graphics::TColor DownTabColorTo = {read=FDownTabColorTo, write=SetDownTabColorTo, nodefault};
	__property Graphics::TColor DownTabMirrorColor = {read=FDownTabMirrorColor, write=SetDownTabMirrorColor, nodefault};
	__property Graphics::TColor DownTabMirrorColorTo = {read=FDownTabMirrorColorTo, write=SetDownTabMirrorColorTo, nodefault};
	__property Graphics::TColor DownTextColor = {read=FDownTextColor, write=SetDownTextColor, default=0};
	__property Font;
	__property Graphics::TColor HoverTabColor = {read=FHoverTabColor, write=SetHoverTabColor, nodefault};
	__property Graphics::TColor HoverTabColorTo = {read=FHoverTabColorTo, write=SetHoverTabColorTo, nodefault};
	__property Graphics::TColor HoverTabMirrorColor = {read=FHoverTabMirrorColor, write=SetHoverTabMirrorColor, nodefault};
	__property Graphics::TColor HoverTabMirrorColorTo = {read=FHoverTabMirrorColorTo, write=SetHoverTabMirrorColorTo, nodefault};
	__property Graphics::TColor HoverTextColor = {read=FHoverTextColor, write=SetHoverTextColor, default=0};
	__property int MinClientHeight = {read=FMinClientHeight, write=SetMinClientHeight, default=60};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TPanelOrder PanelOrder = {read=GetPanelOrder, write=SetPanelOrder, default=0};
	__property bool PopupIndicator = {read=FPopupIndicator, write=SetPopupIndicator, default=1};
	__property PopupMenu;
	__property Graphics::TColor SectionColor = {read=FSectionColor, write=SetSectionColor, nodefault};
	__property Graphics::TColor SectionColorTo = {read=FSectionColorTo, write=SetSectionColorTo, nodefault};
	__property Graphics::TFont* SectionFont = {read=FSectionFont, write=SetSectionFont};
	__property ShowHint;
	__property bool ShowSplitter = {read=FShowSplitter, write=SetShowSplitter, default=1};
	__property bool ShowShortCutBar = {read=FShowShortCutBar, write=SetShowShortCutBar, default=1};
	__property Imglist::TCustomImageList* SmallImages = {read=FSmallImages, write=SetSmallImages};
	__property int SplitterPosition = {read=FSplitterPosition, write=SetSplitterPosition, nodefault};
	__property Graphics::TColor SplitterColor = {read=FSplitterColor, write=SetSplitterColor, nodefault};
	__property Graphics::TColor SplitterColorTo = {read=FSplitterColorTo, write=SetSplitterColorTo, nodefault};
	__property Graphics::TColor SplitterBorderColor = {read=FSplitterBorderColor, write=SetSplitterBorderColor, default=536870911};
	__property TAdvNavBarStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Visible = {default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnCollapsChange = {read=FOnCollapsChange, write=FOnCollapsChange};
	__property Classes::TNotifyEvent OnCollapsedClick = {read=FOnCollapsedClick, write=FOnCollapsedClick};
	__property TOnPanelActivate OnPanelActivate = {read=FOnTPanelActivate, write=FOnTPanelActivate};
	__property TSplitterMove OnSplitterMove = {read=FOnSplitterMove, write=FOnSplitterMove};
	__property Classes::TNotifyEvent OnPopupMenuClick = {read=FOnPopupMenuClick, write=FOnPopupMenuClick};
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnExit;
	__property OnEnter;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnResize;
	__property OnCanResize;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvNavBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt CaptionHeight = 0x1b;
static const ShortInt DefSplitterHeight = 0x7;
static const ShortInt ScrollerWidth = 0x14;
static const ShortInt FixedBtnWidth = 0x18;
static const ShortInt SectionHeight = 0x10;
static const ShortInt IndicatorWidth = 0x14;
static const ShortInt IndicatorWidthOffice2010 = 0xe;
static const ShortInt DefCollapsedWidth = 0x28;
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advnavbar */
using namespace Advnavbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvnavbarHPP
