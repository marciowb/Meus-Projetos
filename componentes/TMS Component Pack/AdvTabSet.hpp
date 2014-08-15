// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtabset.pas' rev: 21.00

#ifndef AdvtabsetHPP
#define AdvtabsetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtabset
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TScrollBtn { sbLeft, sbRight };
#pragma option pop

#pragma option push -b-
enum TScrollPosition { spHorizontal, spVertical };
#pragma option pop

class DELPHICLASS TScroller;
class PASCALIMPLEMENTATION TScroller : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FMin;
	int FMax;
	int FPosition;
	Classes::TNotifyEvent FOnClick;
	int FChange;
	Graphics::TColor FArrowColor;
	TScrollPosition FScrollPosition;
	Graphics::TBitmap* Bitmap;
	bool Pressed;
	bool Down;
	TScrollBtn Current;
	int pWidth;
	int pHeight;
	void __fastcall SetMin(int Value);
	void __fastcall SetMax(int Value);
	void __fastcall SetPosition(int Value);
	void __fastcall SetArrowColor(Graphics::TColor Value);
	void __fastcall SetScrollPosition(TScrollPosition Value);
	bool __fastcall CanScrollLeft(void);
	bool __fastcall CanScrollRight(void);
	HIDESBASE void __fastcall DoMouseDown(int X);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall DrawSBLeftDIS(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBLeftDN(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBLeft(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBRightDIS(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBRight(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBRightDN(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBTopDIS(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBTopDN(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBTop(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBBottomDIS(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBBottom(Graphics::TCanvas* aCanvas);
	void __fastcall DrawSBBottomDN(Graphics::TCanvas* aCanvas);
	
public:
	__fastcall virtual TScroller(Classes::TComponent* AOwner);
	__fastcall virtual ~TScroller(void);
	virtual void __fastcall Paint(void);
	
__published:
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Max = {read=FMax, write=SetMax, default=0};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property int Change = {read=FChange, write=FChange, default=1};
	__property Graphics::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=-16777195};
	__property TScrollPosition ScrollPosition = {read=FScrollPosition, write=SetScrollPosition, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TScroller(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TTabList;
class DELPHICLASS TAdvCustomTabSet;
class PASCALIMPLEMENTATION TTabList : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	TAdvCustomTabSet* Tabs;
	
public:
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	virtual void __fastcall Delete(int Index);
	virtual int __fastcall Add(const System::UnicodeString S);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual void __fastcall Clear(void);
	virtual void __fastcall AddStrings(Classes::TStrings* Strings);
public:
	/* TStringList.Create */ inline __fastcall TTabList(void)/* overload */ : Classes::TStringList() { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TTabList(void) { }
	
};


#pragma option push -b-
enum TEdgePart { epSelectedLeft, epUnselectedLeft, epSelectedRight, epUnselectedRight };
#pragma option pop

#pragma option push -b-
enum TEdgeType { etNone, etFirstIsSel, etFirstNotSel, etLastIsSel, etLastNotSel, etNotSelToSel, etSelToNotSel, etNotSelToNotSel };
#pragma option pop

#pragma option push -b-
enum TTabStyle { tsStandard, tsOwnerDraw };
#pragma option pop

#pragma option push -b-
enum TAdvTabStyle { tsClassic, tsDotNet };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TAdvTabPosition { pLeft, pRight, pTop, pBottom };
#pragma option pop

#pragma option push -b-
enum TCloseButtonPos { cbTabs, cbTabSet };
#pragma option pop

#pragma option push -b-
enum TShowScroller { ssAuto, ssAlways };
#pragma option pop

#pragma option push -b-
enum TClosePosition { cpLeft, cpRight };
#pragma option pop

typedef void __fastcall (__closure *TMeasureTabEvent)(System::TObject* Sender, int Index, int &TabWidth);

typedef void __fastcall (__closure *TDrawTabEvent)(System::TObject* Sender, Graphics::TCanvas* TabCanvas, const Types::TRect &R, int Index, bool Selected);

typedef void __fastcall (__closure *TTabChangeEvent)(System::TObject* Sender, int NewTab, bool &AllowChange);

typedef void __fastcall (__closure *TTabChangedEvent)(System::TObject* Sender, int NewTab);

typedef ShortInt TTabOverlapSize;

typedef int TMarginSize;

typedef void __fastcall (__closure *TMarginChange)(TMarginSize NewValue, TMarginSize OldValue, int Index);

typedef void __fastcall (__closure *TTabCloseEvent)(System::TObject* Sender, int TabIndex);

typedef void __fastcall (__closure *TTabMovedEvent)(System::TObject* Sender, int FromPos, int ToPos);

typedef void __fastcall (__closure *TCanCloseEvent)(System::TObject* Sender, int TabIndex, bool &CanClose);

typedef void __fastcall (__closure *TDrawTabSetBackgroundEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &Rect);

class DELPHICLASS TTabCollectionItem;
class PASCALIMPLEMENTATION TTabCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	bool FVisible;
	bool FShowClose;
	int FTag;
	System::TObject* FObject;
	Graphics::TColor FTextColor;
	Graphics::TColor FTabColor;
	Graphics::TColor FTabColorTo;
	TGradientDirection FTabGradientDirection;
	TGradientDirection FHoverGradientDirection;
	int FImageIndex;
	int FIndexInAdvTabSet;
	int FDispOrder;
	bool FEnable;
	int FVisIndex;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetShowClose(const bool Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTabColor(const Graphics::TColor Value);
	void __fastcall SetTabColorTo(const Graphics::TColor Value);
	void __fastcall SetTabGradientDirection(TGradientDirection value);
	void __fastcall SetHoverGradientDirection(TGradientDirection value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetEnable(const bool Value);
	
protected:
	Forms::TForm* FChildForm;
	Classes::TNotifyEvent FOnActivateForm;
	Classes::TNotifyEvent FOnDestroyForm;
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetIndex(int Value);
	__property int VisIndex = {read=FVisIndex, nodefault};
	
public:
	bool __fastcall MoveItemInTabSetTo(int ItemIndexOfTabSet);
	__fastcall virtual TTabCollectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TTabCollectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::TObject* AObject = {read=FObject, write=FObject};
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property bool Enable = {read=FEnable, write=SetEnable, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property bool ShowClose = {read=FShowClose, write=SetShowClose, nodefault};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property Graphics::TColor TabColor = {read=FTabColor, write=SetTabColor, nodefault};
	__property Graphics::TColor TabColorTo = {read=FTabColorTo, write=SetTabColorTo, nodefault};
	__property TGradientDirection HoverGradientDirection = {read=FHoverGradientDirection, write=SetHoverGradientDirection, default=0};
	__property TGradientDirection TabGradientDirection = {read=FTabGradientDirection, write=SetTabGradientDirection, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TTabCollection;
class PASCALIMPLEMENTATION TTabCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TTabCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvCustomTabSet* FOwner;
	HIDESBASE TTabCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TTabCollectionItem* Value);
	
protected:
	void __fastcall UpdateItemsIndexesInTabSet(void);
	void __fastcall ValidateVisTabIndexes(void);
	
public:
	__fastcall TTabCollection(TAdvCustomTabSet* AOwner);
	__property TTabCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TAdvCustomTabSet* AdvTabSet = {read=FOwner};
	HIDESBASE TTabCollectionItem* __fastcall Add(void);
	HIDESBASE TTabCollectionItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTabCollection(void) { }
	
};


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


class PASCALIMPLEMENTATION TAdvCustomTabSet : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FStartMargin;
	int FEndMargin;
	Classes::TStrings* FTabs;
	int FTabIndex;
	int FFirstIndex;
	int FVisibleTabs;
	Graphics::TColor FSelectedColor;
	Graphics::TColor FUnselectedColor;
	Graphics::TColor FBackgroundColor;
	bool FDitherBackground;
	bool FAutoScroll;
	TTabStyle FStyle;
	int FOwnerDrawHeight;
	TMeasureTabEvent FOnMeasureTab;
	TDrawTabEvent FOnDrawTab;
	TTabChangeEvent FOnChange;
	TTabChangedEvent FOnChanged;
	TTabCollection* FAdvTabs;
	Graphics::TColor FSelectedColorTo;
	Graphics::TColor FUnSelectedColorTo;
	Graphics::TColor FTextColor;
	Graphics::TColor FTabBorderColor;
	Graphics::TBitmap* FTabBackGround;
	Graphics::TBitmap* FTabBackGroundSelected;
	TGradientDirection FGradientDirection;
	TGradientDirection FHoverGradientDirection;
	Graphics::TColor FTabHoverColor;
	Graphics::TColor FTabHoverColorTo;
	Graphics::TColor FTabHoverBorder;
	Imglist::TCustomImageList* FImages;
	TTabMargin* FTabMargin;
	TTabOverlapSize FTabOverlap;
	bool FShowFocus;
	TTabCloseEvent FOnTabClose;
	TCanCloseEvent FOnCanClose;
	TDrawTabSetBackgroundEvent FOnDrawTabSetBackground;
	TAdvTabStyle FAdvTabStyle;
	TTabMovedEvent FOnTabMoved;
	TAdvTabPosition FTabPosition;
	TCloseButtonPos FCloseButtonAt;
	bool FTabRearrange;
	TShowScroller FShowScroller;
	int FLowerSelected;
	bool FHoverClosedButton;
	Classes::TStringList* FDuplicateTabs;
	int FHoverTab;
	bool FCloseButtonDown;
	Controls::TImageList* ImageList;
	Graphics::TBitmap* MemBitmap;
	Graphics::TBitmap* BrushBitmap;
	Classes::TList* TabPositions;
	int FTabHeight;
	TScroller* FScroller;
	bool FDoFix;
	bool FSoftTop;
	Graphics::TFont* FActiveFont;
	Graphics::TBitmap* FCloseGlyph;
	Graphics::TBitmap* FDisableCloseGlyph;
	bool FFreeOnClose;
	TClosePosition FClosePosition;
	void __fastcall SetSelectedColor(Graphics::TColor Value);
	void __fastcall SetUnselectedColor(Graphics::TColor Value);
	void __fastcall SetBackgroundColor(Graphics::TColor Value);
	void __fastcall SetDitherBackground(bool Value);
	void __fastcall SetAutoScroll(bool Value);
	void __fastcall SetStartMargin(int Value);
	void __fastcall SetEndMargin(int Value);
	void __fastcall SetTabIndex(int Value);
	void __fastcall SetFirstIndex(int Value);
	void __fastcall SetTabList(Classes::TStrings* Value);
	void __fastcall SetTabStyle(TTabStyle Value);
	void __fastcall SetTabHeight(int Value);
	void __fastcall SetSelectedColorTo(Graphics::TColor Value);
	void __fastcall SetUnSelectedColorTo(Graphics::TColor Value);
	void __fastcall SetTextColor(Graphics::TColor Value);
	void __fastcall SetTabBorderColor(Graphics::TColor Value);
	void __fastcall SetTabBackGround(const Graphics::TBitmap* Value);
	void __fastcall SetTabBackGroundSelected(const Graphics::TBitmap* Value);
	void __fastcall SetGradientDirection(TGradientDirection Value);
	void __fastcall SetHoverGradientDirection(TGradientDirection value);
	void __fastcall SetTabMargin(TTabMargin* Value);
	void __fastcall SetTabOverlap(TTabOverlapSize Value);
	void __fastcall SetImages(Imglist::TCustomImageList* value);
	void __fastcall SetAdvTabStyle(TAdvTabStyle Value);
	void __fastcall SetTabPosition(TAdvTabPosition Value);
	void __fastcall SetCloseButtonAt(TCloseButtonPos Value);
	void __fastcall SetLowerSelected(int Value);
	void __fastcall SetShowScroller(TShowScroller Value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	void __fastcall CreateBrushPattern(Graphics::TBitmap* Bitmap);
	int __fastcall CalcTabPositions(int Start, int Stop, Graphics::TCanvas* Canvas, int First);
	void __fastcall CreateScroller(void);
	void __fastcall InitBitmaps(void);
	void __fastcall DoneBitmaps(void);
	void __fastcall CreateEdgeParts(void);
	void __fastcall FixTabPos(void);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	void __fastcall ScrollClick(System::TObject* Sender);
	void __fastcall ReadIntData(Classes::TReader* Reader);
	void __fastcall ReadBoolData(Classes::TReader* Reader);
	void __fastcall SetSoftTop(const bool Value);
	void __fastcall DrawCloseGlyph(Graphics::TCanvas* Canvas, const Types::TPoint &P, bool IsEnable);
	void __fastcall DrawCloseButton(Graphics::TCanvas* Canvas, const Types::TRect &Rect, bool Active);
	void __fastcall DrawHoverCloseButton(const Types::TRect &Rect);
	void __fastcall DrawDownCloseButton(const Types::TRect &Rect);
	bool __fastcall IsOnButton(int TabIndex, int X, int Y)/* overload */;
	bool __fastcall IsOnButton(int TabIndex, int X, int Y, Types::TRect &aRect)/* overload */;
	void __fastcall TabMarginChange(TMarginSize NewValue, TMarginSize OldValue, int Index);
	void __fastcall SetOriginalTabWidth(void);
	void __fastcall IncTabWidth(int w);
	void __fastcall DrawCrossAtTabSet(bool IsEnable);
	void __fastcall DrawCloseButtonAtTabSet(bool IsEnable);
	void __fastcall DrawDownCloseButtonAtTabSet(void);
	bool __fastcall IsOnCloseButtonAtTabSet(int X, int Y);
	void __fastcall CloseButtonClick(void);
	void __fastcall SetActiveFont(const Graphics::TFont* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall CloseGlyphOnChange(System::TObject* Sender);
	void __fastcall SetCloseGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetClosePosition(const TClosePosition Value);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawTab(Graphics::TCanvas* TabCanvas, const Types::TRect &R, int Index, bool Selected);
	bool __fastcall CanChange(int NewIndex);
	virtual void __fastcall MeasureTab(int Index, int &TabWidth);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall AdjustTabWidth(void);
	__property Classes::TStringList* DuplicateTabs = {read=FDuplicateTabs};
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Loaded(void);
	__property TScroller* Scroller = {read=FScroller};
	__property Classes::TStrings* Tabs = {read=FTabs, write=SetTabList};
	__property TTabStyle Style = {read=FStyle, write=SetTabStyle, default=1};
	__property bool DitherBackground = {read=FDitherBackground, write=SetDitherBackground, default=0};
	void __fastcall UpdateScroller(void);
	virtual void __fastcall ChangeActiveTab(int Value);
	virtual void __fastcall BeforeCloseTab(TTabCollectionItem* Tab, Forms::TCloseAction &CloseAction);
	virtual bool __fastcall CanCloseTab(int TabIdx, Forms::TCloseAction &CloseAction);
	__property bool AutoScroll = {read=FAutoScroll, write=SetAutoScroll, default=1};
	__property Graphics::TFont* ActiveFont = {read=FActiveFont, write=SetActiveFont};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=-16777201};
	__property Graphics::TBitmap* CloseGlyph = {read=FCloseGlyph, write=SetCloseGlyph};
	__property int EndMargin = {read=FEndMargin, write=SetEndMargin, default=5};
	__property int StartMargin = {read=FStartMargin, write=SetStartMargin, default=5};
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, default=-16777201};
	__property bool SoftTop = {read=FSoftTop, write=SetSoftTop, default=0};
	__property TTabCollection* AdvTabs = {read=FAdvTabs, write=FAdvTabs};
	__property TClosePosition ClosePosition = {read=FClosePosition, write=SetClosePosition, default=0};
	__property bool FreeOnClose = {read=FFreeOnClose, write=FFreeOnClose, nodefault};
	__property Graphics::TColor SelectedColorTo = {read=FSelectedColorTo, write=SetSelectedColorTo, default=536870911};
	__property Graphics::TColor UnSelectedColorTo = {read=FUnSelectedColorTo, write=SetUnSelectedColorTo, default=536870911};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property Graphics::TColor TabBorderColor = {read=FTabBorderColor, write=SetTabBorderColor, default=8421504};
	__property Graphics::TBitmap* TabBackGround = {read=FTabBackGround, write=SetTabBackGround};
	__property Graphics::TBitmap* TabBackGroundSelected = {read=FTabBackGroundSelected, write=SetTabBackGroundSelected};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
	__property TGradientDirection HoverGradientDirection = {read=FHoverGradientDirection, write=SetHoverGradientDirection, default=0};
	__property Graphics::TColor TabHoverColor = {read=FTabHoverColor, write=FTabHoverColor, default=536870911};
	__property Graphics::TColor TabHoverColorTo = {read=FTabHoverColorTo, write=FTabHoverColorTo, default=536870911};
	__property Graphics::TColor TabHoverBorder = {read=FTabHoverBorder, write=FTabHoverBorder, default=536870911};
	__property TTabMargin* TabMargin = {read=FTabMargin, write=SetTabMargin};
	__property TTabOverlapSize TabOverlap = {read=FTabOverlap, write=SetTabOverlap, nodefault};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=0};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TAdvTabStyle TabStyle = {read=FAdvTabStyle, write=SetAdvTabStyle, default=0};
	__property TAdvTabPosition TabPosition = {read=FTabPosition, write=SetTabPosition, default=2};
	__property TCloseButtonPos CloseButtonAt = {read=FCloseButtonAt, write=SetCloseButtonAt, default=0};
	__property bool TabRearrange = {read=FTabRearrange, write=FTabRearrange, default=0};
	__property TShowScroller ShowScroller = {read=FShowScroller, write=SetShowScroller, default=1};
	__property int LowerSelected = {read=FLowerSelected, write=SetLowerSelected, default=2};
	__property int TabHeight = {read=FOwnerDrawHeight, write=SetTabHeight, default=20};
	__property int TabIndex = {read=FTabIndex, write=SetTabIndex, default=-1};
	__property Graphics::TColor UnselectedColor = {read=FUnselectedColor, write=SetUnselectedColor, default=-16777211};
	__property int VisibleTabs = {read=FVisibleTabs, nodefault};
	__property TTabMovedEvent OnTabMoved = {read=FOnTabMoved, write=FOnTabMoved};
	__property TTabCloseEvent OnTabClose = {read=FOnTabClose, write=FOnTabClose};
	__property TCanCloseEvent OnCanClose = {read=FOnCanClose, write=FOnCanClose};
	__property TTabChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TTabChangedEvent OnChanged = {read=FOnChanged, write=FOnChanged};
	__property TMeasureTabEvent OnMeasureTab = {read=FOnMeasureTab, write=FOnMeasureTab};
	__property TDrawTabSetBackgroundEvent OnDrawTabSetBackground = {read=FOnDrawTabSetBackground, write=FOnDrawTabSetBackground};
	
public:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TAdvCustomTabSet(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomTabSet(void);
	int __fastcall ItemAtPos(const Types::TPoint &Pos);
	Types::TRect __fastcall ItemRect(int Item);
	int __fastcall ItemIndex(int Pos);
	int __fastcall ItemWidth(int Index);
	Types::TRect __fastcall MinClientRect(void)/* overload */;
	Types::TRect __fastcall MinClientRect(bool IncludeScroller)/* overload */;
	Types::TRect __fastcall MinClientRect(int TabCount, bool IncludeScroller = false)/* overload */;
	HIDESBASE void __fastcall SelectNext(bool Direction);
	int __fastcall DisplToRealTabIndex(int tab);
	int __fastcall RealToDisplTabIndex(int tab);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	__property Canvas;
	__property int FirstIndex = {read=FFirstIndex, write=SetFirstIndex, default=0};
	__property int VersionNr = {read=GetVersionNr, nodefault};
	
__published:
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomTabSet(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvTabSet;
class PASCALIMPLEMENTATION TAdvTabSet : public TAdvCustomTabSet
{
	typedef TAdvCustomTabSet inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoScroll = {default=1};
	__property ActiveFont;
	__property BackgroundColor = {default=-16777201};
	__property CloseGlyph;
	__property ClosePosition = {default=0};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property EndMargin = {default=5};
	__property Font;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property StartMargin = {default=5};
	__property SelectedColor = {default=-16777201};
	__property SoftTop = {default=0};
	__property AdvTabs;
	__property FreeOnClose;
	__property SelectedColorTo = {default=536870911};
	__property UnSelectedColorTo = {default=536870911};
	__property TextColor = {default=0};
	__property TabBorderColor = {default=8421504};
	__property TabBackGround;
	__property TabBackGroundSelected;
	__property GradientDirection;
	__property HoverGradientDirection = {default=0};
	__property TabHoverColor = {default=536870911};
	__property TabHoverColorTo = {default=536870911};
	__property TabHoverBorder = {default=536870911};
	__property TabMargin;
	__property TabOverlap;
	__property ShowFocus = {default=0};
	__property Images;
	__property TabStyle = {default=0};
	__property TabPosition = {default=2};
	__property CloseButtonAt = {default=0};
	__property TabRearrange = {default=0};
	__property ShowScroller = {default=1};
	__property LowerSelected = {default=2};
	__property TabHeight = {default=20};
	__property TabIndex = {default=-1};
	__property UnselectedColor = {default=-16777211};
	__property Visible = {default=1};
	__property VisibleTabs;
	__property OnTabMoved;
	__property OnTabClose;
	__property OnCanClose;
	__property OnClick;
	__property OnChange;
	__property OnChanged;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMeasureTab;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnDrawTabSetBackground;
public:
	/* TAdvCustomTabSet.Create */ inline __fastcall virtual TAdvTabSet(Classes::TComponent* AOwner) : TAdvCustomTabSet(AOwner) { }
	/* TAdvCustomTabSet.Destroy */ inline __fastcall virtual ~TAdvTabSet(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTabSet(HWND ParentWindow) : TAdvCustomTabSet(ParentWindow) { }
	
};


class DELPHICLASS TAdvMDITabSet;
class PASCALIMPLEMENTATION TAdvMDITabSet : public TAdvCustomTabSet
{
	typedef TAdvCustomTabSet inherited;
	
private:
	bool FInternalDelete;
	int __fastcall GetAdvTabCount(void);
	void __fastcall OnChildFormActivate(System::TObject* Sender);
	void __fastcall OnChildFormDestroy(System::TObject* Sender);
	
protected:
	TTabCollectionItem* __fastcall GetAdvTabs(int index);
	void __fastcall Change(void);
	virtual void __fastcall ChangeActiveTab(int Value);
	virtual void __fastcall BeforeCloseTab(TTabCollectionItem* Tab, Forms::TCloseAction &CloseAction);
	virtual bool __fastcall CanCloseTab(int TabIdx, Forms::TCloseAction &CloseAction);
	
public:
	__fastcall virtual TAdvMDITabSet(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMDITabSet(void);
	TTabCollectionItem* __fastcall AddTab(Forms::TForm* ChildForm);
	Forms::TForm* __fastcall GetChildForm(TTabCollectionItem* Tab);
	__property int AdvTabCount = {read=GetAdvTabCount, nodefault};
	__property TTabCollectionItem* AdvTab[int index] = {read=GetAdvTabs};
	TTabCollectionItem* __fastcall GetTab(Forms::TForm* AChild);
	__property TabIndex = {default=-1};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoScroll = {default=1};
	__property ActiveFont;
	__property BackgroundColor = {default=-16777201};
	__property CloseGlyph;
	__property ClosePosition = {default=0};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property EndMargin = {default=5};
	__property Font;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property StartMargin = {default=5};
	__property SelectedColor = {default=-16777201};
	__property SoftTop = {default=0};
	__property SelectedColorTo = {default=536870911};
	__property UnSelectedColorTo = {default=536870911};
	__property TextColor = {default=0};
	__property TabBorderColor = {default=8421504};
	__property TabBackGround;
	__property TabBackGroundSelected;
	__property GradientDirection;
	__property HoverGradientDirection = {default=0};
	__property TabHoverColor = {default=536870911};
	__property TabHoverColorTo = {default=536870911};
	__property TabHoverBorder = {default=536870911};
	__property TabMargin;
	__property TabOverlap;
	__property ShowFocus = {default=0};
	__property Images;
	__property TabStyle = {default=0};
	__property TabPosition = {default=2};
	__property CloseButtonAt = {default=0};
	__property TabRearrange = {default=0};
	__property ShowScroller = {default=1};
	__property LowerSelected = {default=2};
	__property TabHeight = {default=20};
	__property UnselectedColor = {default=-16777211};
	__property Visible = {default=1};
	__property VisibleTabs;
	__property OnTabMoved;
	__property OnTabClose;
	__property OnCanClose;
	__property OnClick;
	__property OnChange;
	__property OnChanged;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMeasureTab;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnDrawTabSetBackground;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMDITabSet(HWND ParentWindow) : TAdvCustomTabSet(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CloseButtonWidth = 0xe;
static const ShortInt CloseButtonHeight = 0xd;
static const ShortInt ScrollLength = 0x18;
static const ShortInt ScrollWidth = 0xd;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x7;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x3;

}	/* namespace Advtabset */
using namespace Advtabset;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtabsetHPP
