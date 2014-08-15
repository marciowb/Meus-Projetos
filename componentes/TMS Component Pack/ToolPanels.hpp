// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Toolpanels.pas' rev: 21.00

#ifndef ToolpanelsHPP
#define ToolpanelsHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Toolpanels
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TPanelState { psClosed, psOpened, psDocked };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

class DELPHICLASS TToolPanel;
class DELPHICLASS TAdvToolPanel;
class PASCALIMPLEMENTATION TToolPanel : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FTag;
	TAdvToolPanel* FPanel;
	System::UnicodeString FCaption;
	bool FVisible;
	int FImageIndex;
	TPanelState FState;
	int FOpenWidth;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetState(const TPanelState Value);
	void __fastcall SetOpenWidth(const int Value);
	
public:
	__fastcall virtual TToolPanel(Classes::TCollection* Collection);
	__fastcall virtual ~TToolPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TAdvToolPanel* Panel = {read=FPanel, write=FPanel};
	
__published:
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property TPanelState State = {read=FState, write=SetState, nodefault};
	__property int OpenWidth = {read=FOpenWidth, write=SetOpenWidth, nodefault};
};


class DELPHICLASS TToolPanels;
class DELPHICLASS TAdvToolPanelTab;
class PASCALIMPLEMENTATION TToolPanels : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TToolPanel* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvToolPanelTab* FOwner;
	HIDESBASE TToolPanel* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TToolPanel* Value);
	
public:
	__fastcall TToolPanels(TAdvToolPanelTab* AOwner);
	HIDESBASE TToolPanel* __fastcall Add(void);
	HIDESBASE TToolPanel* __fastcall Insert(int index);
	__property TToolPanel* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TAdvToolPanelTab* Panel = {read=FOwner};
	void __fastcall Move(int FromIndex, int ToIndex);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TToolPanels(void) { }
	
};


class DELPHICLASS TToolPanelGlyphs;
class PASCALIMPLEMENTATION TToolPanelGlyphs : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TBitmap* FCloseGlyphHot;
	Graphics::TBitmap* FLockGlyphDown;
	Graphics::TBitmap* FLockGlyphHot;
	Graphics::TBitmap* FLockGlyphNormal;
	Graphics::TBitmap* FCloseGlyphDown;
	Graphics::TBitmap* FCloseGlyphNormal;
	Classes::TNotifyEvent FOnChange;
	Graphics::TBitmap* FUnLockGlyphDown;
	Graphics::TBitmap* FUnLockGlyphHot;
	Graphics::TBitmap* FUnLockGlyphNormal;
	void __fastcall SetCloseGlyphNormal(const Graphics::TBitmap* Value);
	void __fastcall SetCloseGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetCloseGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall SetLockGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetLockGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall SetLockGlyphNormal(const Graphics::TBitmap* Value);
	void __fastcall SetUnLockGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetUnLockGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall SetUnLockGlyphNormal(const Graphics::TBitmap* Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TToolPanelGlyphs(void);
	__fastcall virtual ~TToolPanelGlyphs(void);
	
__published:
	__property Graphics::TBitmap* CloseGlyphNormal = {read=FCloseGlyphNormal, write=SetCloseGlyphNormal};
	__property Graphics::TBitmap* CloseGlyphDown = {read=FCloseGlyphDown, write=SetCloseGlyphDown};
	__property Graphics::TBitmap* CloseGlyphHot = {read=FCloseGlyphHot, write=SetCloseGlyphHot};
	__property Graphics::TBitmap* LockGlyphNormal = {read=FLockGlyphNormal, write=SetLockGlyphNormal};
	__property Graphics::TBitmap* LockGlyphDown = {read=FLockGlyphDown, write=SetLockGlyphDown};
	__property Graphics::TBitmap* LockGlyphHot = {read=FLockGlyphHot, write=SetLockGlyphHot};
	__property Graphics::TBitmap* UnLockGlyphNormal = {read=FUnLockGlyphNormal, write=SetUnLockGlyphNormal};
	__property Graphics::TBitmap* UnLockGlyphDown = {read=FUnLockGlyphDown, write=SetUnLockGlyphDown};
	__property Graphics::TBitmap* UnLockGlyphHot = {read=FUnLockGlyphHot, write=SetUnLockGlyphHot};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TSectionCorners { scRectangle, scRoundLeft, scRoundRight, scRoundLeftRight };
#pragma option pop

class DELPHICLASS TSectionLayout;
class PASCALIMPLEMENTATION TSectionLayout : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionColorTo;
	Graphics::TColor FBackGroundColor;
	Graphics::TColor FBackGroundColorTo;
	Graphics::TColor FBorderColor;
	int FBorderWidth;
	Classes::TNotifyEvent FOnChange;
	TGradientDirection FBackGroundGradientDir;
	TGradientDirection FCaptionGradientDirection;
	Graphics::TColor FItemFontColor;
	bool FUnderLineCaption;
	Graphics::TColor FItemHoverTextColor;
	bool FItemHoverUnderline;
	Graphics::TColor FCaptionFontColor;
	int FSpacing;
	int FIndent;
	bool FCaptionRounded;
	TSectionCorners FCorners;
	void __fastcall SetBackGroundColor(const Graphics::TColor Value);
	void __fastcall SetBackGroundColorTo(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetCaptionColorTo(const Graphics::TColor Value);
	void __fastcall SetBackGroundGradientDir(const TGradientDirection Value);
	void __fastcall SetCaptionGradientDirection(const TGradientDirection Value);
	void __fastcall SetItemFontColor(const Graphics::TColor Value);
	void __fastcall SetUnderLineCaption(const bool Value);
	void __fastcall SetItemHoverTextColor(const Graphics::TColor Value);
	void __fastcall SetItemHoverUnderline(const bool Value);
	void __fastcall SetCaptionFontColor(const Graphics::TColor Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetCaptionRounded(const bool Value);
	void __fastcall SetCorners(const TSectionCorners Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TSectionLayout(void);
	__fastcall virtual ~TSectionLayout(void);
	
__published:
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, nodefault};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=SetCaptionColorTo, nodefault};
	__property Graphics::TColor CaptionFontColor = {read=FCaptionFontColor, write=SetCaptionFontColor, nodefault};
	__property bool CaptionRounded = {read=FCaptionRounded, write=SetCaptionRounded, nodefault};
	__property TSectionCorners Corners = {read=FCorners, write=SetCorners, nodefault};
	__property Graphics::TColor BackGroundColor = {read=FBackGroundColor, write=SetBackGroundColor, nodefault};
	__property Graphics::TColor BackGroundColorTo = {read=FBackGroundColorTo, write=SetBackGroundColorTo, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property TGradientDirection CaptionGradientDir = {read=FCaptionGradientDirection, write=SetCaptionGradientDirection, default=0};
	__property TGradientDirection BackGroundGradientDir = {read=FBackGroundGradientDir, write=SetBackGroundGradientDir, default=0};
	__property int Indent = {read=FIndent, write=SetIndent, nodefault};
	__property int Spacing = {read=FSpacing, write=SetSpacing, nodefault};
	__property Graphics::TColor ItemFontColor = {read=FItemFontColor, write=SetItemFontColor, nodefault};
	__property Graphics::TColor ItemHoverTextColor = {read=FItemHoverTextColor, write=SetItemHoverTextColor, nodefault};
	__property bool ItemHoverUnderline = {read=FItemHoverUnderline, write=SetItemHoverUnderline, nodefault};
	__property bool UnderLineCaption = {read=FUnderLineCaption, write=SetUnderLineCaption, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TSectionItem;
class PASCALIMPLEMENTATION TSectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	System::UnicodeString FCaption;
	System::UnicodeString FHint;
	bool FEnabled;
	int FTag;
	System::TObject* FObject;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TSectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TSectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TSectionItems;
class DELPHICLASS TAdvToolPanelSection;
class PASCALIMPLEMENTATION TSectionItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TSectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvToolPanel* FOwner;
	Classes::TNotifyEvent FOnItemAdd;
	Classes::TNotifyEvent FOnItemDelete;
	TAdvToolPanelSection* FAdvToolPanelSection;
	HIDESBASE TSectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TSectionItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property TAdvToolPanelSection* AdvToolPanelSection = {read=FAdvToolPanelSection, write=FAdvToolPanelSection};
	
public:
	__fastcall TSectionItems(TAdvToolPanel* AOwner);
	HIDESBASE TSectionItem* __fastcall Add(void);
	HIDESBASE TSectionItem* __fastcall Insert(int Index);
	__property TSectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnItemAdd = {read=FOnItemAdd, write=FOnItemAdd};
	__property Classes::TNotifyEvent OnItemDelete = {read=FOnItemDelete, write=FOnItemDelete};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSectionItems(void) { }
	
};


class PASCALIMPLEMENTATION TAdvToolPanelSection : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FHeight;
	int FActHeight;
	System::UnicodeString FCaption;
	TSectionItems* FSectionItems;
	int FCaptionImageIndex;
	bool FNode;
	bool FExpanded;
	bool FDraw;
	bool FAutosize;
	int FSectionItemHeight;
	bool FInternalCall;
	Classes::TList* FControlList;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetCaptionImageIndex(const int Value);
	void __fastcall SetNode(const bool Value);
	void __fastcall SetExpanded(const bool Value);
	__property int ActualHeight = {read=FActHeight, nodefault};
	void __fastcall SetDraw(const bool Value);
	void __fastcall SetAutosize(const bool Value);
	void __fastcall OnSectionItemsAdd(System::TObject* Sender);
	void __fastcall OnSectionItemsDelete(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	__property Classes::TList* ControlList = {read=FControlList};
	
public:
	__fastcall virtual TAdvToolPanelSection(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvToolPanelSection(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=1};
	
__published:
	__property bool Autosize = {read=FAutosize, write=SetAutosize, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Draw = {read=FDraw, write=SetDraw, nodefault};
	__property TSectionItems* SectionItems = {read=FSectionItems, write=FSectionItems};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property bool Node = {read=FNode, write=SetNode, default=0};
	__property int CaptionImageIndex = {read=FCaptionImageIndex, write=SetCaptionImageIndex, nodefault};
};


class DELPHICLASS TAdvToolPanelSections;
class PASCALIMPLEMENTATION TAdvToolPanelSections : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvToolPanelSection* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvToolPanel* FOwner;
	HIDESBASE TAdvToolPanelSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvToolPanelSection* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvToolPanelSections(TAdvToolPanel* AOwner);
	HIDESBASE TAdvToolPanelSection* __fastcall Add(void);
	HIDESBASE TAdvToolPanelSection* __fastcall Insert(int Index);
	__property TAdvToolPanelSection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvToolPanelSections(void) { }
	
};


typedef void __fastcall (__closure *TOnItemClick)(System::TObject* Sender, int SectionIndex, int ItemIndex);

typedef void __fastcall (__closure *TOnCaptionButtonClick)(System::TObject* Sender, const Types::TRect &CaptionButtonRect);

typedef void __fastcall (__closure *TNodeExpandEvent)(System::TObject* Sender, int SectionIndex);

typedef TNodeExpandEvent TNodeCollapseEvent;

#pragma option push -b-
enum TTPBackGroundPosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpTiled, bpStretched, bpCenter };
#pragma option pop

#pragma option push -b-
enum TToolPanelStyle { esOffice2003Blue, esOffice2003Silver, esOffice2003Olive, esOffice2003Classic, esOffice2007Luna, esOffice2007Obsidian, esWindowsXP, esWhidbey, esCustom, esOffice2007Silver, esWindowsVista, esWindows7, esTerminal, esOffice2010Blue, esOffice2010Silver, esOffice2010Black };
#pragma option pop

class PASCALIMPLEMENTATION TAdvToolPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	int FImageIndex;
	TAdvToolPanelTab* FTab;
	int FOpenWidth;
	bool FMouseDown;
	bool FLocked;
	Graphics::TBitmap* FCloseGlyph;
	Graphics::TBitmap* FLockedGlyph;
	Graphics::TBitmap* FUnLockedGlyph;
	bool FCanSize;
	bool FHidden;
	System::UnicodeString FCLoseHint;
	System::UnicodeString FLockHint;
	System::UnicodeString FUnlockHint;
	bool FActive;
	Graphics::TColor FFocusCaptionColor;
	Graphics::TColor FFocusCaptionFontColor;
	Graphics::TColor FNoFocusCaptionColor;
	Graphics::TColor FNoFocusCaptionFontColor;
	bool FDocking;
	bool FShowCaption;
	bool FAllowDocking;
	bool FRestored;
	System::UnicodeString FTabName;
	bool FShowClose;
	bool FShowLock;
	bool FForceResize;
	bool FAutoLock;
	Graphics::TColor FNoFocusCaptionColorTo;
	Graphics::TColor FFocusCaptionColorTo;
	TGradientDirection FCaptionGradientDirection;
	bool FShowCaptionBorder;
	bool FDockDots;
	bool FCaptionButton;
	TOnCaptionButtonClick FOnCaptionBtnClick;
	Classes::TNotifyEvent FOnCaptionDblClick;
	bool FButton3D;
	Graphics::TColor FHoverButtonColor;
	Graphics::TColor FDownButtonColor;
	Graphics::TColor FHoverButtonColorTo;
	Graphics::TColor FDownButtonColorTo;
	TAdvToolPanelSections* FSections;
	bool FSizing;
	int FSizeSection;
	int FSizeHeight;
	int FSizeY;
	TSectionLayout* FSectionLayout;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	Controls::TImageList* FSectionImages;
	TNodeExpandEvent FOnNodeCollapse;
	TNodeExpandEvent FOnNodeExpand;
	bool FOldFloating;
	int FHoverSectionIndex;
	int FHoverSectionItemIndex;
	Types::TRect FHoverSectionItemRect;
	TOnItemClick FOnItemClick;
	Graphics::TBitmap* FBackGround;
	TTPBackGroundPosition FBackGroundPosition;
	TToolPanelStyle FStyle;
	bool FBackgroundTransparent;
	Classes::TNotifyEvent FOnLock;
	Classes::TNotifyEvent FOnUnlock;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMEXITSIZEMOVE(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMENTERSIZEMOVE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	MESSAGE void __fastcall WMLDblClk(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Message);
	void __fastcall SetLocked(const bool Value);
	System::UnicodeString __fastcall GetCaptionEx(void);
	void __fastcall SetCaptionEx(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetHidden(const bool Value);
	bool __fastcall GetIsVisible(void);
	void __fastcall SetFocusCaptionColor(const Graphics::TColor Value);
	void __fastcall SetFocusCaptionFontColor(const Graphics::TColor Value);
	void __fastcall SetNoFocusCaptionColor(const Graphics::TColor Value);
	void __fastcall SetNoFocusCaptionFontColor(const Graphics::TColor Value);
	void __fastcall SetDocking(const bool Value);
	HIDESBASE void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetOpenWidth(const int Value);
	void __fastcall SetShowClose(const bool Value);
	void __fastcall SetShowLock(const bool Value);
	void __fastcall SetCaptionGradientDirection(const TGradientDirection Value);
	void __fastcall SetFocusCaptionColorTo(const Graphics::TColor Value);
	void __fastcall SetNoFocusCaptionColorTo(const Graphics::TColor Value);
	void __fastcall SetShowCaptionBorder(const bool Value);
	void __fastcall SetDockDots(const bool Value);
	void __fastcall SetCaptionButton(const bool Value);
	void __fastcall CaptionButtonClick(const Types::TRect &CaptionBtnRect);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SectionLayoutChanged(System::TObject* Sender);
	Types::TRect __fastcall SectionRect(int SectionIndex, bool Actual);
	Types::TRect __fastcall NodeBtnRect(int SectionIndex);
	void __fastcall SetBackground(const Graphics::TBitmap* Value);
	void __fastcall SetBackGroundPosition(const TTPBackGroundPosition value);
	void __fastcall SetBackgroundTransparent(bool Value);
	void __fastcall SetStyle(const TToolPanelStyle Value);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SetColorEx(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetColorEx(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	int __fastcall GetVersionNr(void);
	int __fastcall GetSectionHeight(void);
	void __fastcall SetSectionImages(Controls::TImageList* Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	__property bool Restored = {read=FRestored, write=FRestored, default=0};
	__property System::UnicodeString TabName = {read=FTabName, write=FTabName};
	bool __fastcall HasFocusControl(void);
	void __fastcall UpdateControlPos(int SectionIndex, int Diff);
	void __fastcall UpdateControlPosBelowSection(int SectionIndex, int Diff);
	int __fastcall PtOnAnyItem(int X, int Y, int &SectionIndex, Types::TRect &ItemRect);
	__property int SectionHeight = {read=GetSectionHeight, nodefault};
	
public:
	__fastcall virtual TAdvToolPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolPanel(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall DoEndDock(System::TObject* Target, int X, int Y);
	DYNAMIC void __fastcall DoStartDock(Controls::TDragObject* &DragObject);
	__property TAdvToolPanelTab* Tab = {read=FTab, write=FTab};
	__property bool Locked = {read=FLocked, write=SetLocked, nodefault};
	__property bool Hidden = {read=FHidden, write=SetHidden, nodefault};
	__property bool Docking = {read=FDocking, write=SetDocking, nodefault};
	__property bool IsVisible = {read=GetIsVisible, nodefault};
	void __fastcall SetTopMost(void);
	
__published:
	__property Align = {default=0};
	__property Alignment = {default=2};
	__property bool AllowDocking = {read=FAllowDocking, write=FAllowDocking, default=1};
	__property bool AutoLock = {read=FAutoLock, write=FAutoLock, default=0};
	__property Graphics::TBitmap* Background = {read=FBackGround, write=SetBackground};
	__property bool BackgroundTransparent = {read=FBackgroundTransparent, write=SetBackgroundTransparent, nodefault};
	__property TTPBackGroundPosition BackGroundPosition = {read=FBackGroundPosition, write=SetBackGroundPosition, nodefault};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property bool Button3D = {read=FButton3D, write=FButton3D, default=1};
	__property Graphics::TColor HoverButtonColor = {read=FHoverButtonColor, write=FHoverButtonColor, nodefault};
	__property Graphics::TColor HoverButtonColorTo = {read=FHoverButtonColorTo, write=FHoverButtonColorTo, nodefault};
	__property Graphics::TColor DownButtonColor = {read=FDownButtonColor, write=FDownButtonColor, nodefault};
	__property Graphics::TColor DownButtonColorTo = {read=FDownButtonColorTo, write=FDownButtonColorTo, nodefault};
	__property bool CaptionButton = {read=FCaptionButton, write=SetCaptionButton, nodefault};
	__property Graphics::TColor Color = {read=GetColorEx, write=SetColorEx, default=16771030};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property Cursor = {default=0};
	__property bool DockDots = {read=FDockDots, write=SetDockDots, nodefault};
	__property Hint;
	__property PopupMenu;
	__property bool CanSize = {read=FCanSize, write=FCanSize, default=1};
	__property System::UnicodeString Caption = {read=GetCaptionEx, write=SetCaptionEx};
	__property Font;
	__property TGradientDirection CaptionGradientDirection = {read=FCaptionGradientDirection, write=SetCaptionGradientDirection, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Graphics::TColor FocusCaptionFontColor = {read=FFocusCaptionFontColor, write=SetFocusCaptionFontColor, nodefault};
	__property Graphics::TColor FocusCaptionColor = {read=FFocusCaptionColor, write=SetFocusCaptionColor, nodefault};
	__property Graphics::TColor FocusCaptionColorTo = {read=FFocusCaptionColorTo, write=SetFocusCaptionColorTo, nodefault};
	__property Graphics::TColor NoFocusCaptionFontColor = {read=FNoFocusCaptionFontColor, write=SetNoFocusCaptionFontColor, nodefault};
	__property Graphics::TColor NoFocusCaptionColor = {read=FNoFocusCaptionColor, write=SetNoFocusCaptionColor, nodefault};
	__property Graphics::TColor NoFocusCaptionColorTo = {read=FNoFocusCaptionColorTo, write=SetNoFocusCaptionColorTo, nodefault};
	__property int OpenWidth = {read=FOpenWidth, write=SetOpenWidth, default=150};
	__property System::UnicodeString CloseHint = {read=FCLoseHint, write=FCLoseHint};
	__property System::UnicodeString LockHint = {read=FLockHint, write=FLockHint};
	__property System::UnicodeString UnlockHint = {read=FUnlockHint, write=FUnlockHint};
	__property TAdvToolPanelSections* Sections = {read=FSections, write=FSections};
	__property TSectionLayout* SectionLayout = {read=FSectionLayout, write=FSectionLayout};
	__property Controls::TImageList* SectionImages = {read=FSectionImages, write=SetSectionImages};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool ShowCaptionBorder = {read=FShowCaptionBorder, write=SetShowCaptionBorder, default=1};
	__property bool ShowClose = {read=FShowClose, write=SetShowClose, default=1};
	__property bool ShowLock = {read=FShowLock, write=SetShowLock, default=1};
	__property ShowHint;
	__property TToolPanelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TOnCaptionButtonClick OnCaptionBtnClick = {read=FOnCaptionBtnClick, write=FOnCaptionBtnClick};
	__property Classes::TNotifyEvent OnCaptionDblClick = {read=FOnCaptionDblClick, write=FOnCaptionDblClick};
	__property OnClick;
	__property OnDblClick;
	__property OnCanResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property TOnItemClick OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property Classes::TNotifyEvent OnLock = {read=FOnLock, write=FOnLock};
	__property Classes::TNotifyEvent OnUnlock = {read=FOnUnlock, write=FOnUnlock};
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseLeave;
	__property OnMouseEnter;
	__property TNodeExpandEvent OnNodeExpand = {read=FOnNodeExpand, write=FOnNodeExpand};
	__property TNodeExpandEvent OnNodeCollapse = {read=FOnNodeCollapse, write=FOnNodeCollapse};
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
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


class DELPHICLASS TToolPanelForm;
class PASCALIMPLEMENTATION TToolPanelForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	
public:
	__fastcall virtual TToolPanelForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TToolPanelForm(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TToolPanelForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TToolPanelForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TPanelPosition { ppLeft, ppRight, ppTop, ppBottom };
#pragma option pop

#pragma option push -b-
enum TSlideSpeed { ssSlow, ssMedium, ssFast, ssInstant };
#pragma option pop

#pragma option push -b-
enum TAutoOpenCloseSpeed { aocSlow, aocMedium, aocFast, aocVerySlow, aocVeryFast };
#pragma option pop

typedef void __fastcall (__closure *TTabEvent)(System::TObject* Sender, int Index, TAdvToolPanel* APanel);

typedef void __fastcall (__closure *TAllowTabEvent)(System::TObject* Sender, int Index, TAdvToolPanel* APanel, bool &Allow);

#pragma option push -b-
enum TPanelPersistLocation { pplINIFile, pplRegistry };
#pragma option pop

class DELPHICLASS TPanelPersistence;
class PASCALIMPLEMENTATION TPanelPersistence : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAutoSave;
	bool FAutoLoad;
	System::UnicodeString FINIFile;
	TPanelPersistLocation FLocation;
	System::UnicodeString FRegistryKey;
	
__published:
	__property bool AutoLoad = {read=FAutoLoad, write=FAutoLoad, default=0};
	__property bool AutoSave = {read=FAutoSave, write=FAutoSave, default=0};
	__property System::UnicodeString INIFile = {read=FINIFile, write=FINIFile};
	__property System::UnicodeString RegistryUserKey = {read=FRegistryKey, write=FRegistryKey};
	__property TPanelPersistLocation Location = {read=FLocation, write=FLocation, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPanelPersistence(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TPanelPersistence(void) : Classes::TPersistent() { }
	
};


#pragma option push -b-
enum TTextDirection { tdTopToBottom, tdBottomToTop };
#pragma option pop

class PASCALIMPLEMENTATION TAdvToolPanelTab : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	TToolPanels* FPanels;
	Controls::TImageList* FImages;
	bool FRollInBusy;
	bool FRollInOut;
	int FRollOutPanel;
	int FRollInCandidate;
	int FTimerID;
	int FTimerCount;
	int FTimerRollIn;
	bool FTimerEnable;
	TPanelPosition FPosition;
	TToolPanelForm* FPanelForm;
	Classes::TWndMethod FFormWndProc;
	int FDesignViewPanel;
	Graphics::TColor FTabColor;
	Types::TPoint FLastMousePos;
	bool FAutoDock;
	TAutoOpenCloseSpeed FAutoOpenCloseSpeed;
	TSlideSpeed FSlideSpeed;
	int FPaintOffset;
	Graphics::TBitmap* FUpDown;
	Graphics::TColor FColorTo;
	Graphics::TColor FTabColorTo;
	Graphics::TColor FTabBorderColor;
	int FHoverPanel;
	int FMousePanel;
	Graphics::TColor FTabHoverColor;
	Graphics::TColor FTabHoverColorTo;
	int FTabWidth;
	Graphics::TBitmap* FTabGlyph;
	TTabEvent FOnTabLeave;
	TTabEvent FOnTabEnter;
	TTabEvent FOnTabRightClick;
	TTabEvent FOnTabLeftClick;
	TTabEvent FOnTabSlideIn;
	TTabEvent FOnTabSlideInDone;
	TTabEvent FOnTabSlideOut;
	TTabEvent FOnTabSlideOutDone;
	TPanelPersistence* FPersist;
	TTabEvent FOnTabHide;
	TAllowTabEvent FOnAllowTabHide;
	TToolPanelGlyphs* FPanelGlyphs;
	bool FAutoThemeAdapt;
	TToolPanelStyle FStyle;
	bool FMouseInControl;
	bool FAutoOpenOnMouseEnter;
	bool FParentHooked;
	bool FDisableParentHook;
	bool FRollInOutActive;
	bool FRestored;
	bool FWMDestroy;
	TTextDirection FTextDirection;
	int __fastcall GetPanelFromTab(int x, int y);
	int __fastcall GetTabSize(void);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Message);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	void __fastcall SetPosition(const TPanelPosition Value);
	void __fastcall SubclassProc(Messages::TMessage &Msg);
	void __fastcall SetTabColor(const Graphics::TColor Value);
	void __fastcall SetAutoDock(const bool Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetTabColorTo(const Graphics::TColor Value);
	void __fastcall SetTabBorderColor(const Graphics::TColor Value);
	void __fastcall SetTabWidth(const int Value);
	void __fastcall SetTabGlyph(const Graphics::TBitmap* Value);
	void __fastcall ThemeAdapt(void);
	void __fastcall SetStyle(const TToolPanelStyle Value);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SetTextDirection(const TTextDirection Value);
	
protected:
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall LockChange(TAdvToolPanel* APanel);
	void __fastcall RollInOut(int Index);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall ResetTimer(void);
	void __fastcall EnableTimer(bool Enabled);
	void __fastcall INISaveState(void);
	void __fastcall REGSaveState(void);
	bool __fastcall INIRestoreState(void);
	bool __fastcall REGRestoreState(void);
	void __fastcall IRollIn(TAdvToolPanel* APanel);
	void __fastcall IRollOut(TAdvToolPanel* APanel);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	__property bool Restored = {read=FRestored, write=FRestored, nodefault};
	
public:
	__fastcall virtual TAdvToolPanelTab(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolPanelTab(void);
	void __fastcall UpdatePanels(int Index);
	void __fastcall UnHookParent(void);
	void __fastcall HookParent(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall DockOver(Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DockDrop(Controls::TDragDockObject* Source, int X, int Y);
	void __fastcall RemovePanel(TAdvToolPanel* APanel);
	void __fastcall InsertPanel(TAdvToolPanel* APanel);
	void __fastcall UpdatePanel(TAdvToolPanel* APanel);
	void __fastcall UnHidePanel(TAdvToolPanel* APanel);
	void __fastcall UnHidePanels(void);
	void __fastcall RollIn(TAdvToolPanel* APanel);
	void __fastcall RollOut(TAdvToolPanel* APanel);
	int __fastcall PanelsInTab(void);
	TAdvToolPanel* __fastcall CreatePanel(void);
	__property TToolPanels* Panels = {read=FPanels, write=FPanels};
	void __fastcall NextPanel(void);
	void __fastcall PrevPanel(void);
	int __fastcall PanelIndex(TAdvToolPanel* APanel);
	TAdvToolPanel* __fastcall PanelByName(System::UnicodeString AName);
	void __fastcall SaveState(void);
	void __fastcall RestoreState(void);
	int __fastcall NumPanelsLocked(void);
	__property bool DisableParentHook = {read=FDisableParentHook, write=FDisableParentHook, nodefault};
	
__published:
	__property Alignment = {default=2};
	__property bool AutoDock = {read=FAutoDock, write=SetAutoDock, default=1};
	__property TAutoOpenCloseSpeed AutoOpenCloseSpeed = {read=FAutoOpenCloseSpeed, write=FAutoOpenCloseSpeed, default=1};
	__property bool AutoOpenOnMouseEnter = {read=FAutoOpenOnMouseEnter, write=FAutoOpenOnMouseEnter, default=1};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property Color = {default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Font;
	__property Hint;
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property TToolPanelGlyphs* PanelGlyphs = {read=FPanelGlyphs, write=FPanelGlyphs};
	__property ParentFont = {default=1};
	__property TPanelPersistence* Persist = {read=FPersist, write=FPersist};
	__property PopupMenu;
	__property TPanelPosition Position = {read=FPosition, write=SetPosition, nodefault};
	__property TSlideSpeed SlideSpeed = {read=FSlideSpeed, write=FSlideSpeed, default=1};
	__property TToolPanelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Graphics::TColor TabBorderColor = {read=FTabBorderColor, write=SetTabBorderColor, default=8421504};
	__property Graphics::TColor TabColor = {read=FTabColor, write=SetTabColor, default=-16777201};
	__property Graphics::TColor TabColorTo = {read=FTabColorTo, write=SetTabColorTo, default=536870911};
	__property Graphics::TColor TabHoverColor = {read=FTabHoverColor, write=FTabHoverColor, default=536870911};
	__property Graphics::TColor TabHoverColorTo = {read=FTabHoverColorTo, write=FTabHoverColorTo, default=536870911};
	__property int TabWidth = {read=FTabWidth, write=SetTabWidth, default=23};
	__property Graphics::TBitmap* TabGlyph = {read=FTabGlyph, write=SetTabGlyph};
	__property TTextDirection TextDirection = {read=FTextDirection, write=SetTextDirection, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnDockOver;
	__property OnDockDrop;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property TTabEvent OnTabEnter = {read=FOnTabEnter, write=FOnTabEnter};
	__property TTabEvent OnTabLeave = {read=FOnTabLeave, write=FOnTabLeave};
	__property TTabEvent OnTabLeftClick = {read=FOnTabLeftClick, write=FOnTabLeftClick};
	__property TTabEvent OnTabRightClick = {read=FOnTabRightClick, write=FOnTabRightClick};
	__property TTabEvent OnTabSlideOut = {read=FOnTabSlideOut, write=FOnTabSlideOut};
	__property TTabEvent OnTabSlideIn = {read=FOnTabSlideIn, write=FOnTabSlideIn};
	__property TTabEvent OnTabSlideOutDone = {read=FOnTabSlideOutDone, write=FOnTabSlideOutDone};
	__property TTabEvent OnTabSlideInDone = {read=FOnTabSlideInDone, write=FOnTabSlideInDone};
	__property TTabEvent OnTabHide = {read=FOnTabHide, write=FOnTabHide};
	__property TAllowTabEvent OnAllowTabHide = {read=FOnAllowTabHide, write=FOnAllowTabHide};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolPanelTab(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
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
static const ShortInt SECTION_HEIGHT = 0x10;
static const ShortInt NODEBTN_SIZE = 0x8;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Toolpanels */
using namespace Toolpanels;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ToolpanelsHPP
