// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Slstbox.pas' rev: 21.00

#ifndef SlstboxHPP
#define SlstboxHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Richedit.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Slstbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS ESectionListBoxError;
class PASCALIMPLEMENTATION ESectionListBoxError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ESectionListBoxError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ESectionListBoxError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ESectionListBoxError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ESectionListBoxError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ESectionListBoxError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ESectionListBoxError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ESectionListBoxError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ESectionListBoxError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ESectionListBoxError(void) { }
	
};


#pragma option push -b-
enum TListNodeType { lnFlat, ln3D, lnGlyph };
#pragma option pop

#pragma option push -b-
enum TSListScrollStyle { slsNormal, slsFlat, slsEncarta };
#pragma option pop

#pragma option push -b-
enum TListSectionState { lssExpanded, lssContracted };
#pragma option pop

#pragma option push -b-
enum TActiveSection { asFull, asNodeOnly };
#pragma option pop

#pragma option push -b-
enum TSectionFocus { sfDash, sf3D, sfNone };
#pragma option pop

#pragma option push -b-
enum TSectionLines { slNone, slVertical, slHorizontal, slBoth };
#pragma option pop

#pragma option push -b-
enum TSectionControlType { scText, scCheckbox, scRadiobutton };
#pragma option pop

#pragma option push -b-
enum TSortDirection { sdNone, sdAscending, sdDescending };
#pragma option pop

#pragma option push -b-
enum TFontUsage { fuSubItems, fuSection, fuBoth };
#pragma option pop

#pragma option push -b-
enum TVAlignment { vtaCenter, vtaTop, vtaBottom };
#pragma option pop

typedef void __fastcall (__closure *TExpandSectionEvent)(System::TObject* Sender, int SectionIdx);

typedef void __fastcall (__closure *TContractSectionEvent)(System::TObject* Sender, int SectionIdx);

typedef void __fastcall (__closure *TSubItemClickEvent)(System::TObject* Sender, int SectionIdx, int subitemidx);

typedef void __fastcall (__closure *TInsertSubItemEvent)(System::TObject* Sender, int SectionIdx, int subitemidx, System::UnicodeString &subitem);

class DELPHICLASS TListSection;
typedef void __fastcall (__closure *TInsertSectionEvent)(System::TObject* Sender, int SectionIdx, TListSection* section);

typedef void __fastcall (__closure *TDeleteSubItemEvent)(System::TObject* Sender, int SectionIdx, int subitemidx, bool &allow);

typedef void __fastcall (__closure *TDeleteSectionEvent)(System::TObject* Sender, int SectionIdx, bool &allow);

typedef void __fastcall (__closure *TDrawItemEvent)(System::TObject* Sender, TListSection* section, int SectionIdx, int subitemidx, Graphics::TCanvas* Canvas, const Types::TRect &arect, Windows::TOwnerDrawState astate);

typedef void __fastcall (__closure *TDrawItemPropEvent)(System::TObject* Sender, TListSection* section, int SectionIdx, int subitemidx, Graphics::TCanvas* Canvas);

typedef void __fastcall (__closure *TEditEvent)(System::TObject* Sender, int SectionIdx, int subitemidx, System::UnicodeString &s);

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, int index, System::UnicodeString anchor);

typedef void __fastcall (__closure *TAnchorEvent)(System::TObject* Sender, int index, System::UnicodeString anchor);

class DELPHICLASS TSectionListStrings;
class PASCALIMPLEMENTATION TSectionListStrings : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	TListSection* FListSection;
	
public:
	virtual int __fastcall Add(const System::UnicodeString S);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	virtual void __fastcall InsertObject(int Index, const System::UnicodeString S, System::TObject* AObject);
	__property OnChange;
public:
	/* TStringList.Create */ inline __fastcall TSectionListStrings(void)/* overload */ : Classes::TStringList() { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TSectionListStrings(void) { }
	
};


class PASCALIMPLEMENTATION TListSection : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TAlignment FAlignment;
	TVAlignment FVAlignment;
	bool FAutoEdit;
	bool FAutoSize;
	System::UnicodeString FCaption;
	bool FFixed;
	Classes::TStringList* FSubItems;
	TListSectionState FState;
	Graphics::TColor FColor;
	int FImageIndex;
	TSectionLines FLines;
	Graphics::TFont* FFont;
	TFontUsage FFontUsage;
	bool FEndEllipsis;
	TSectionControlType FControlType;
	int FRadioIndex;
	TSortDirection FSortDirection;
	bool FSortShow;
	int FTag;
	bool FOwnerdraw;
	bool FReadOnly;
	int FItemHeight;
	void __fastcall SetAlignment(const Classes::TAlignment value);
	void __fastcall SetVAlignment(const TVAlignment value);
	void __fastcall SetAutoSize(const bool value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(Graphics::TFont* value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetLines(const TSectionLines Value);
	void __fastcall SetFixed(const bool value);
	void __fastcall SetState(const TListSectionState value);
	void __fastcall SetSubItems(const Classes::TStringList* Value);
	void __fastcall AddSubItems(const System::UnicodeString S);
	void __fastcall ClearSubItems(void);
	void __fastcall DeleteSubItems(int Index);
	void __fastcall InsertSubItems(int Index, const System::UnicodeString S);
	short __fastcall GetSubItemImageIdx(int i);
	void __fastcall SetSubItemImageIdx(int i, const short Value);
	bool __fastcall GetSubItemCheckState(int i);
	void __fastcall SetSubItemCheckState(int i, const bool Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SubItemsChanged(System::TObject* Sender);
	void __fastcall SetFontUsage(TFontUsage value);
	void __fastcall SetEndEllipsis(bool value);
	void __fastcall SetRadioIndex(int value);
	void __fastcall SetControlType(TSectionControlType value);
	void __fastcall SetSortDirection(TSortDirection value);
	void __fastcall SetSortShow(bool value);
	void __fastcall SetOwnerDraw(bool value);
	void __fastcall SetReadOnly(bool value);
	void __fastcall SetItemHeight(int value);
	void __fastcall QuickSortItems(int left, int right);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TListSection(Classes::TCollection* Collection);
	__fastcall virtual ~TListSection(void);
	virtual void __fastcall Assign(Classes::TPersistent* source);
	__property short SubItemImageIdx[int i] = {read=GetSubItemImageIdx, write=SetSubItemImageIdx};
	__property bool SubItemCheckState[int i] = {read=GetSubItemCheckState, write=SetSubItemCheckState};
	void __fastcall SortSubItems(void);
	void __fastcall Focus(void);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property bool AutoEdit = {read=FAutoEdit, write=FAutoEdit, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Fixed = {read=FFixed, write=SetFixed, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property TListSectionState State = {read=FState, write=SetState, nodefault};
	__property Classes::TStringList* SubItems = {read=FSubItems, write=SetSubItems};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property TSectionLines Lines = {read=FLines, write=SetLines, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TFontUsage FontUsage = {read=FFontUsage, write=SetFontUsage, nodefault};
	__property bool EndEllipsis = {read=FEndEllipsis, write=SetEndEllipsis, nodefault};
	__property TSectionControlType ControlType = {read=FControlType, write=SetControlType, nodefault};
	__property int RadioIndex = {read=FRadioIndex, write=SetRadioIndex, nodefault};
	__property TSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, nodefault};
	__property bool SortShow = {read=FSortShow, write=SetSortShow, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property bool OwnerDraw = {read=FOwnerdraw, write=SetOwnerDraw, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, nodefault};
};


class DELPHICLASS TListSectionCollection;
class DELPHICLASS TSectionListBox;
class PASCALIMPLEMENTATION TListSectionCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TListSection* operator[](int Index) { return Items[Index]; }
	
private:
	TSectionListBox* FOwner;
	HIDESBASE TListSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TListSection* Value);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	__fastcall TListSectionCollection(TSectionListBox* AOwner);
	HIDESBASE TListSection* __fastcall Add(void);
	HIDESBASE TListSection* __fastcall Insert(int index);
	void __fastcall SwapSections(int idx1, int idx2);
	int __fastcall IndexOf(System::UnicodeString SectionText);
	__property TListSection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TSectionListBox* ListOwner = {read=FOwner};
	int __fastcall InsertSection(TListSection* ASection);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	int __fastcall GetListIndex(TListSection* ASection);
	int __fastcall ExpandSection(TListSection* ASection);
	int __fastcall ContractSection(TListSection* ASection);
	int __fastcall RemoveSection(TListSection* ASection);
	int __fastcall UpdateSection(TListSection* ASection);
	void __fastcall InsertInSection(TListSection* ASection, int index, const System::UnicodeString S);
	void __fastcall AddToSection(TListSection* ASection, const System::UnicodeString S);
	void __fastcall DeleteFromSection(TListSection* ASection, int index);
	void __fastcall ClearSection(TListSection* ASection);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TListSectionCollection(void) { }
	
};


#pragma option push -b-
enum TTabType { tableft, tabright };
#pragma option pop

class DELPHICLASS TTabPositionItem;
class PASCALIMPLEMENTATION TTabPositionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FTabPosition;
	TTabType FTabType;
	void __fastcall SetTabPosition(int value);
	void __fastcall SetTabType(TTabType value);
	
__published:
	__property int TabPosition = {read=FTabPosition, write=SetTabPosition, nodefault};
	__property TTabType TabType = {read=FTabType, write=SetTabType, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TTabPositionItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TTabPositionItem(void) { }
	
};


class DELPHICLASS TTabPositionCollection;
class PASCALIMPLEMENTATION TTabPositionCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TSectionListBox* FOwner;
	TTabPositionItem* __fastcall GetTabPos(int i);
	void __fastcall SetTabPos(int i, TTabPositionItem* tabpos);
	
public:
	__fastcall TTabPositionCollection(TSectionListBox* aOwner);
	HIDESBASE TTabPositionItem* __fastcall Add(void);
	__property TTabPositionItem* Items[int Index] = {read=GetTabPos, write=SetTabPos};
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTabPositionCollection(void) { }
	
};


class DELPHICLASS TURLSettings;
class PASCALIMPLEMENTATION TURLSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FURLAware;
	Graphics::TColor FURLColor;
	bool FURLFull;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetURLAware(bool value);
	void __fastcall SetURLColor(Graphics::TColor value);
	void __fastcall SetURLFull(bool value);
	
public:
	__fastcall TURLSettings(void);
	__fastcall virtual ~TURLSettings(void);
	
__published:
	__property bool URLAware = {read=FURLAware, write=SetURLAware, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, nodefault};
	__property bool URLFull = {read=FURLFull, write=SetURLFull, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TSectionMemo;
class PASCALIMPLEMENTATION TSectionMemo : public Stdctrls::TMemo
{
	typedef Stdctrls::TMemo inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	
protected:
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	int SectionIdx;
	int SubItemIdx;
	int ItemIdx;
	TListSection* FListSection;
public:
	/* TCustomMemo.Create */ inline __fastcall virtual TSectionMemo(Classes::TComponent* AOwner) : Stdctrls::TMemo(AOwner) { }
	/* TCustomMemo.Destroy */ inline __fastcall virtual ~TSectionMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSectionMemo(HWND ParentWindow) : Stdctrls::TMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TSectionListBox : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	bool FHasScrollBar;
	bool FFlat;
	bool FWordWrap;
	Graphics::TBitmap* FWallpaper;
	short FImageSpacing;
	int FDtStyle;
	bool FFullFocus;
	bool FScrollTrack;
	Graphics::TFont* FSectionFont;
	int FSectionIndent;
	TListSectionCollection* FSections;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Picturecontainer::TPictureContainer* FContainer;
	int FSectionHeight;
	int FSubItemIndent;
	int FSubItemHeight;
	TTabPositionCollection* FTabPositions;
	TExpandSectionEvent FOnExpandSection;
	TContractSectionEvent FOnContractSection;
	TContractSectionEvent FOnSectionRClick;
	TContractSectionEvent FOnSectionClick;
	TContractSectionEvent FOnSectionDblClk;
	TSubItemClickEvent FOnChange;
	TSubItemClickEvent FOnSubItemClick;
	TSubItemClickEvent FOnCheckBoxClick;
	TSubItemClickEvent FOnRadioClick;
	TSubItemClickEvent FOnSubItemRClick;
	TSubItemClickEvent FOnSubItemDblClk;
	TSubItemClickEvent FOnSubItemRDblClk;
	TInsertSubItemEvent FOnInsertSubItem;
	TDeleteSubItemEvent FOnDeleteSubItem;
	TInsertSectionEvent FOnInsertSection;
	TDeleteSectionEvent FOnDeleteSection;
	TDrawItemEvent FOnDrawItem;
	TDrawItemPropEvent FOnDrawItemProp;
	TEditEvent FOnStartEdit;
	TEditEvent FOnEndEdit;
	TAnchorClick FAnchorClick;
	TAnchorEvent FAnchorEnter;
	TAnchorEvent FAnchorExit;
	Controls::TCursor FOldCursor;
	Comctrls::TRichEdit* FRichEdit;
	TSectionMemo* FMemo;
	Controls::TImageList* FSectionImages;
	Controls::TImageList* FSubItemImages;
	TURLSettings* FURLSettings;
	int FUpdateCount;
	bool FOneExpanded;
	bool FExpandDisable;
	Graphics::TBitmap* FExpandGlyph;
	bool FContractDisable;
	Graphics::TBitmap* FContractGlyph;
	Graphics::TColor FSectionColor;
	TActiveSection FActiveSection;
	TListNodeType FNodeType;
	TSectionFocus FSectionFocus;
	TSListScrollStyle FScrollStyle;
	Graphics::TColor FScrollColor;
	int FScrollWidth;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionTextColor;
	bool FTabSelect;
	bool FTabMove;
	bool FTabPosMove;
	int FTabPos;
	int FOldTabPos;
	System::UnicodeString FOldAnchor;
	int FOldScrollPos;
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDBlClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	void __fastcall SetSections(TListSectionCollection* value);
	void __fastcall SetTabPositions(TTabPositionCollection* value);
	void __fastcall SetTabPosMove(bool value);
	void __fastcall SetSectionHeight(int value);
	int __fastcall GetSectionHeight(void);
	void __fastcall SetSectionFont(Graphics::TFont* value);
	void __fastcall SetWordWrap(const bool value);
	void __fastcall SetOneExpanded(const bool value);
	void __fastcall SetURLSettings(TURLSettings* value);
	void __fastcall ToggleSectionState(int idx);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetFlat(const bool value);
	void __fastcall SetWallpaper(Graphics::TBitmap* Value);
	void __fastcall WallPaperChanged(void);
	void __fastcall SetImageSpacing(const short value);
	void __fastcall SetSectionIndent(const int Value);
	void __fastcall SetSubItemIndent(const int Value);
	void __fastcall SetSubItemHeight(const int Value);
	void __fastcall SetSectionImages(const Controls::TImageList* Value);
	void __fastcall SetSubItemImages(const Controls::TImageList* Value);
	void __fastcall SetSectionColor(const Graphics::TColor Value);
	int __fastcall LinesInText(System::UnicodeString s, bool multiline, int height);
	void __fastcall SetContractGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetExpandGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetNodeType(const TListNodeType Value);
	void __fastcall UpdateStyle(void);
	void __fastcall UpdateVScrollBar(void);
	void __fastcall UpdateHScrollBar(void);
	void __fastcall UpdateColor(void);
	void __fastcall UpdateWidth(void);
	void __fastcall SetScrollStyle(const TSListScrollStyle Value);
	void __fastcall SetScrollColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetScrollWidth(const int Value);
	void __fastcall FlatSetScrollPos(int code, int pos, BOOL fRedraw);
	void __fastcall FlatSetScrollProp(int index, int newValue, BOOL fRedraw);
	void __fastcall FlatSetScrollInfo(int code, tagSCROLLINFO &scrollinfo, BOOL fRedraw);
	void __fastcall FlatShowScrollBar(int code, BOOL show);
	void __fastcall QuickSortSections(int left, int right);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	bool FDestroyed;
	bool FExpandContractBusy;
	__property Items;
	virtual int __fastcall GetVersionNr(void);
	void __fastcall UpdateHeight(int Index);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyPress(System::WideChar &ch);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall UpdateHorzScrollbar(void);
	void __fastcall DoPaint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual TListSectionCollection* __fastcall CreateSections(void);
	virtual System::UnicodeString __fastcall GetDisplText(TListSection* ListSection, int Index);
	Picturecontainer::THTMLPictureCache* __fastcall GetImageCache(void);
	
public:
	__fastcall virtual TSectionListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TSectionListBox(void);
	TListSection* __fastcall GetActiveSection(void);
	TListSection* __fastcall GetItemSection(int idx);
	int __fastcall GetItemSectionIndex(int idx);
	bool __fastcall GetItemAtXY(int x, int y, int &SectionIdx, int &subitemidx);
	int __fastcall GetSectionListIndex(int idx);
	System::UnicodeString __fastcall GetSectionSubItem(int SectionIdx, int subitemidx);
	System::UnicodeString __fastcall GetRichSectionSubItem(int SectionIdx, int subitemidx);
	bool __fastcall GetListItemIndex(int listindex, int &SectionIdx, int &subitemidx);
	bool __fastcall GetSelection(int &SectionIdx, int &subitemidx, System::UnicodeString &selstring);
	bool __fastcall GetSelectedItem(int &SectionIdx, int &subitemidx);
	bool __fastcall SetSelection(int SectionIdx, int subitemidx);
	bool __fastcall IsSection(int idx);
	void __fastcall UpdateItemHeight(void);
	void __fastcall FocusSection(TListSection* section);
	void __fastcall ExpandAll(void);
	void __fastcall ContractAll(void);
	void __fastcall SortAll(void);
	void __fastcall SortAllSubItems(void);
	void __fastcall SortAllSections(void);
	virtual void __fastcall DeleteSelected(void);
	void __fastcall SaveToFile(System::UnicodeString filename);
	void __fastcall LoadFromFile(System::UnicodeString filename);
	void __fastcall SaveToInifile(System::UnicodeString filename);
	void __fastcall LoadFromInifile(System::UnicodeString filename);
	void __fastcall OptimizeTabs(int padding);
	virtual void __fastcall Clear(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	bool __fastcall StartEdit(int idx);
	void __fastcall StringToRich(System::UnicodeString s, Comctrls::TRichEdit* richeditor);
	System::UnicodeString __fastcall RichToString(Comctrls::TRichEdit* richeditor);
	void __fastcall RichPaint(Graphics::TCanvas* Canvas, const Types::TRect &ARect, System::UnicodeString s, bool sel);
	__property Comctrls::TRichEdit* RichEdit = {read=FRichEdit};
	bool __fastcall HasScrollBar(void);
	void __fastcall HilightInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightInList(void);
	void __fastcall HiLightInSection(int SectionIdx, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHiLightInSection(int SectionIdx);
	void __fastcall HilightInSubItem(int SectionIdx, int SubItemIdx, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightInSubItem(int SectionIdx, int SubItemIdx);
	void __fastcall MarkInList(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInList(void);
	void __fastcall MarkInSection(int SectionIdx, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInSection(int SectionIdx);
	void __fastcall MarkInSubItem(int SectionIdx, int SubItemIdx, System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkInSubItem(int SectionIdx, int SubItemIdx);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property TListSectionCollection* Sections = {read=FSections, write=SetSections};
	__property TTabPositionCollection* TabPositions = {read=FTabPositions, write=SetTabPositions};
	__property bool TabPosMove = {read=FTabPosMove, write=SetTabPosMove, nodefault};
	__property Align = {default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property Graphics::TBitmap* Wallpaper = {read=FWallpaper, write=SetWallpaper};
	__property bool OneExpanded = {read=FOneExpanded, write=SetOneExpanded, nodefault};
	__property bool FullFocus = {read=FFullFocus, write=FFullFocus, nodefault};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Enabled = {default=1};
	__property ExtendedSelect = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property IntegralHeight = {default=0};
	__property short ImageSpacing = {read=FImageSpacing, write=SetImageSpacing, nodefault};
	__property MultiSelect = {default=0};
	__property int SubItemHeight = {read=FSubItemHeight, write=SetSubItemHeight, nodefault};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TabWidth = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property TSubItemClickEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TExpandSectionEvent OnExpandSection = {read=FOnExpandSection, write=FOnExpandSection};
	__property TContractSectionEvent OnContractSection = {read=FOnContractSection, write=FOnContractSection};
	__property TContractSectionEvent OnSectionClick = {read=FOnSectionClick, write=FOnSectionClick};
	__property TContractSectionEvent OnSectionRClick = {read=FOnSectionRClick, write=FOnSectionRClick};
	__property TContractSectionEvent OnSectionDblClk = {read=FOnSectionDblClk, write=FOnSectionDblClk};
	__property TSubItemClickEvent OnSubItemClick = {read=FOnSubItemClick, write=FOnSubItemClick};
	__property TSubItemClickEvent OnCheckBoxClick = {read=FOnCheckBoxClick, write=FOnCheckBoxClick};
	__property TSubItemClickEvent OnRadioClick = {read=FOnRadioClick, write=FOnRadioClick};
	__property TSubItemClickEvent OnSubItemRClick = {read=FOnSubItemRClick, write=FOnSubItemRClick};
	__property TSubItemClickEvent OnSubItemDblClk = {read=FOnSubItemDblClk, write=FOnSubItemDblClk};
	__property TSubItemClickEvent OnSubItemRDblClk = {read=FOnSubItemRDblClk, write=FOnSubItemRDblClk};
	__property TInsertSubItemEvent OnInsertSubItem = {read=FOnInsertSubItem, write=FOnInsertSubItem};
	__property TDeleteSubItemEvent OnDeleteSubItem = {read=FOnDeleteSubItem, write=FOnDeleteSubItem};
	__property TInsertSectionEvent OnInsertSection = {read=FOnInsertSection, write=FOnInsertSection};
	__property TDeleteSectionEvent OnDeleteSection = {read=FOnDeleteSection, write=FOnDeleteSection};
	__property TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TDrawItemPropEvent OnDrawItemProp = {read=FOnDrawItemProp, write=FOnDrawItemProp};
	__property TEditEvent OnStartEdit = {read=FOnStartEdit, write=FOnStartEdit};
	__property TEditEvent OnEndEdit = {read=FOnEndEdit, write=FOnEndEdit};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorEvent OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorEvent OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property int SectionHeight = {read=GetSectionHeight, write=SetSectionHeight, default=14};
	__property Graphics::TFont* SectionFont = {read=FSectionFont, write=SetSectionFont};
	__property int SectionIndent = {read=FSectionIndent, write=SetSectionIndent, nodefault};
	__property Controls::TImageList* SectionImages = {read=FSectionImages, write=SetSectionImages};
	__property Controls::TImageList* SubItemImages = {read=FSubItemImages, write=SetSubItemImages};
	__property int SubItemIndent = {read=FSubItemIndent, write=SetSubItemIndent, nodefault};
	__property TURLSettings* URLSettings = {read=FURLSettings, write=SetURLSettings};
	__property OnStartDrag;
	__property bool ExpandDisable = {read=FExpandDisable, write=FExpandDisable, nodefault};
	__property Graphics::TBitmap* ExpandGlyph = {read=FExpandGlyph, write=SetExpandGlyph};
	__property bool ContractDisable = {read=FContractDisable, write=FContractDisable, nodefault};
	__property Graphics::TBitmap* ContractGlyph = {read=FContractGlyph, write=SetContractGlyph};
	__property Graphics::TColor SectionColor = {read=FSectionColor, write=SetSectionColor, nodefault};
	__property TActiveSection ActiveSection = {read=FActiveSection, write=FActiveSection, nodefault};
	__property TListNodeType NodeType = {read=FNodeType, write=SetNodeType, nodefault};
	__property TSectionFocus SectionFocus = {read=FSectionFocus, write=FSectionFocus, nodefault};
	__property bool ScrollTrack = {read=FScrollTrack, write=FScrollTrack, default=1};
	__property TSListScrollStyle ScrollStyle = {read=FScrollStyle, write=SetScrollStyle, nodefault};
	__property Graphics::TColor ScrollColor = {read=FScrollColor, write=SetScrollColor, nodefault};
	__property int ScrollWidth = {read=FScrollWidth, write=SetScrollWidth, nodefault};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=FSelectionColor, nodefault};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=FSelectionTextColor, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TSectionListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x9;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x4;

}	/* namespace Slstbox */
using namespace Slstbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SlstboxHPP
