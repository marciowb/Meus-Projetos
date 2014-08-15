// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advoutlooklist.pas' rev: 21.00

#ifndef AdvoutlooklistHPP
#define AdvoutlooklistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Outlookgroupedlist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advoutlooklist
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

class DELPHICLASS TProOutlookGroupedList;
class PASCALIMPLEMENTATION TProOutlookGroupedList : public Outlookgroupedlist::TOutlookGroupedList
{
	typedef Outlookgroupedlist::TOutlookGroupedList inherited;
	
public:
	/* TOutlookGroupedList.Create */ inline __fastcall virtual TProOutlookGroupedList(Classes::TComponent* AOwner) : Outlookgroupedlist::TOutlookGroupedList(AOwner) { }
	/* TOutlookGroupedList.Destroy */ inline __fastcall virtual ~TProOutlookGroupedList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProOutlookGroupedList(HWND ParentWindow) : Outlookgroupedlist::TOutlookGroupedList(ParentWindow) { }
	
};


#pragma option push -b-
enum TColumnType { ctText, ctImage, ctURL, ctCheckBox, ctProgress };
#pragma option pop

#pragma option push -b-
enum TGradientDir { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TCheckBoxStyle { cbsClassic, cbsFlat, cbsWinXP, cbsBorland };
#pragma option pop

#pragma option push -b-
enum TURLType { utHTTP, utHTTPS, utFTP, utMailTo, utNNTP };
#pragma option pop

#pragma option push -b-
enum TSortType { stNone, stTextCase, stTextNoCase, stNumeric, stBoolean, stDate, stTime, stDateTime, stCustom, stFloat, stAnsiText, stAnsiTextNoCase };
#pragma option pop

#pragma option push -b-
enum TSortDirection { sdAscending, sdDescending };
#pragma option pop

#pragma option push -b-
enum TDragDropSetting { ddEnabled, ddDisabled };
#pragma option pop

#pragma option push -b-
enum TLookUpMethod { lmDirect, lmIncremental };
#pragma option pop

#pragma option push -b-
enum TGroupColumnDisplay { gdHidden, gdVisible };
#pragma option pop

#pragma option push -b-
enum TAdvOutlookListStyle { olsOffice2003Blue, olsOffice2003Silver, olsOffice2003Olive, olsOffice2003Classic, olsOffice2007Luna, olsOffice2007Obsidian, olsWindowsXP, olsWhidbey, olsCustom, olsOffice2007Silver, olsWindowsVista, olsWindows7, olsTerminal, olsOffice2010Blue, olsOffice2010Silver, olsOffice2010Black };
#pragma option pop

class DELPHICLASS TAdvOutlookColumn;
class PASCALIMPLEMENTATION TAdvOutlookColumn : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FCaption;
	int FWidth;
	int FHeaderImageIndex;
	Classes::TAlignment FAlignment;
	Classes::TAlignment FHeaderAlignment;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FHeaderColorTo;
	Graphics::TColor FColor;
	TColumnType FColumnType;
	Graphics::TFont* FHeaderFont;
	Graphics::TFont* FFont;
	TGradientDir FHeaderGradientDir;
	TURLType FURLType;
	TSortType FSortType;
	System::UnicodeString FHeaderHint;
	bool FHeaderShowHint;
	System::UnicodeString FHint;
	bool FShowHint;
	int FHeaderSecIndex;
	bool FVisible;
	int FGroupImageIndex;
	int FHeaderSecOrgIndex;
	int FTag;
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColumnType(const TColumnType Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetHeaderAlignment(const Classes::TAlignment Value);
	void __fastcall SetHeaderColor(const Graphics::TColor Value);
	void __fastcall SetHeaderColorTo(const Graphics::TColor Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	void __fastcall SetHeaderImageIndex(const int Value);
	void __fastcall SetHeaderGradientDir(const TGradientDir Value);
	void __fastcall SetURLType(const TURLType Value);
	void __fastcall SetSortType(const TSortType Value);
	void __fastcall SetHeaderSecIndex(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetGroupImageIndex(const int Value);
	void __fastcall SetHeaderSecOrgIndex(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetIndex(int Value);
	__property int HeaderSecIndex = {read=FHeaderSecIndex, write=SetHeaderSecIndex, nodefault};
	__property int HeaderSecOrgIndex = {read=FHeaderSecOrgIndex, write=SetHeaderSecOrgIndex, nodefault};
	
public:
	__fastcall virtual TAdvOutlookColumn(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvOutlookColumn(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int Width = {read=FWidth, write=SetWidth, default=50};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property TColumnType ColumnType = {read=FColumnType, write=SetColumnType, default=0};
	__property TURLType URLType = {read=FURLType, write=SetURLType, default=0};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, default=16777215};
	__property Graphics::TColor HeaderColorTo = {read=FHeaderColorTo, write=SetHeaderColorTo, default=-16777201};
	__property TGradientDir HeaderGradientDir = {read=FHeaderGradientDir, write=SetHeaderGradientDir, default=0};
	__property Classes::TAlignment HeaderAlignment = {read=FHeaderAlignment, write=SetHeaderAlignment, default=2};
	__property int HeaderImageIndex = {read=FHeaderImageIndex, write=SetHeaderImageIndex, default=-1};
	__property System::UnicodeString HeaderHint = {read=FHeaderHint, write=FHeaderHint};
	__property bool HeaderShowHint = {read=FHeaderShowHint, write=FHeaderShowHint, default=0};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, default=0};
	__property TSortType SortType = {read=FSortType, write=SetSortType, default=2};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int GroupImageIndex = {read=FGroupImageIndex, write=SetGroupImageIndex, default=-1};
	__property int Tag = {read=FTag, write=FTag, default=0};
};


class DELPHICLASS TAdvOutlookColumns;
class DELPHICLASS TAdvOutlookList;
class PASCALIMPLEMENTATION TAdvOutlookColumns : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvOutlookColumn* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnRefresh;
	TAdvOutlookList* FAdvOutLookList;
	HIDESBASE TAdvOutlookColumn* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvOutlookColumn* Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall Refresh(void);
	void __fastcall UpdateOnIndexChanged(void);
	void __fastcall UpdateOnDeleteItem(int Index);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	__property TAdvOutlookList* AdvOutLookList = {read=FAdvOutLookList, write=FAdvOutLookList};
	
public:
	__fastcall TAdvOutlookColumns(Classes::TComponent* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	HIDESBASE TAdvOutlookColumn* __fastcall Add(void);
	HIDESBASE TAdvOutlookColumn* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
	__property TAdvOutlookColumn* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnRefresh = {read=FOnRefresh, write=FOnRefresh};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvOutlookColumns(void) { }
	
};


struct TOutlookInfo;
typedef TOutlookInfo *POutlookInfo;

#pragma pack(push,1)
struct TOutlookInfo
{
	
public:
	Classes::TStringList* data;
};
#pragma pack(pop)


class DELPHICLASS TOutlookGroup;
class PASCALIMPLEMENTATION TOutlookGroup : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetCaption(const System::UnicodeString Value);
	Classes::TStrings* __fastcall GetChildItem(int Index);
	Outlookgroupedlist::POGLItem __fastcall GetChildOLGItem(int Index);
	int __fastcall GetChildCount(void);
	bool __fastcall GetExpanded(void);
	void __fastcall SetExpanded(const bool Value);
	int __fastcall GetTag(void);
	void __fastcall SetObject(const System::TObject* Value);
	void __fastcall SetTag(const int Value);
	System::TObject* __fastcall GetObject(void);
	
protected:
	Outlookgroupedlist::TOGLItem *OGLItem;
	TAdvOutlookList* List;
	
public:
	int __fastcall ItemIndex(Outlookgroupedlist::POGLItem p);
	Classes::TStrings* __fastcall AddChild(void);
	Classes::TStrings* __fastcall InsertChild(int Index);
	void __fastcall RemoveChild(int Index);
	void __fastcall ClearChilds(void);
	__property System::UnicodeString Caption = {read=GetCaption, write=SetCaption};
	__property Classes::TStrings* ChildItem[int Index] = {read=GetChildItem};
	__property Outlookgroupedlist::POGLItem ChildOGLItem[int Index] = {read=GetChildOLGItem};
	__property int ChildCount = {read=GetChildCount, nodefault};
	__property Outlookgroupedlist::POGLItem ListItem = {read=OGLItem};
	__property bool Expanded = {read=GetExpanded, write=SetExpanded, nodefault};
	__property System::TObject* Data = {read=GetObject, write=SetObject};
	__property int Tag = {read=GetTag, write=SetTag, nodefault};
public:
	/* TObject.Create */ inline __fastcall TOutlookGroup(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TOutlookGroup(void) { }
	
};


class DELPHICLASS TOutlookItem;
class PASCALIMPLEMENTATION TOutlookItem : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	Outlookgroupedlist::TOGLItem *OGLItem;
public:
	/* TObject.Create */ inline __fastcall TOutlookItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TOutlookItem(void) { }
	
};


typedef void __fastcall (__closure *THeaderClickEvent)(System::TObject* Sender, int SectionIndex);

typedef void __fastcall (__closure *THeaderDragDropEvent)(System::TObject* Sender, int FromSection, int ToSection);

typedef void __fastcall (__closure *THeaderResizedEvent)(System::TObject* Sender, int SectionIndex, int NewWidth);

class DELPHICLASS TAdvOutLookHeader;
class PASCALIMPLEMENTATION TAdvOutLookHeader : public Extctrls::THeader
{
	typedef Extctrls::THeader inherited;
	
private:
	TAdvOutlookList* FOutLookList;
	THeaderClickEvent FOnClick;
	THeaderClickEvent FOnRightClick;
	THeaderClickEvent FOnDblClick;
	bool FSectionDragDrop;
	bool FDragging;
	int FDragStart;
	int FOffset;
	THeaderDragDropEvent FOnDragDrop;
	int FMouseOverSec;
	Types::TPoint FMouseDragPos;
	bool FReSizing;
	Extctrls::TSectionEvent FOnSized;
	void __fastcall OwnOnDragDrop(System::TObject* Sender, int FromSection, int ToSection);
	void __fastcall OwnSizing(System::TObject* Sender, int ASection, int AWidth);
	void __fastcall OwnSized(System::TObject* Sender, int ASection, int AWidth);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Message);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	int __fastcall XYToSection(int X, int Y);
	Types::TRect __fastcall GetSectionRect(int X);
	int __fastcall GetColIndex(int SecIndex);
	void __fastcall DrawSortIndicator(Graphics::TCanvas* Canvas, const Types::TRect &SectionRect, int X, int Y);
	
public:
	__fastcall virtual TAdvOutLookHeader(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOutLookHeader(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property bool SectionDragDrop = {read=FSectionDragDrop, write=FSectionDragDrop, nodefault};
	__property THeaderClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property THeaderDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property THeaderClickEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property THeaderClickEvent OnRightClick = {read=FOnRightClick, write=FOnRightClick};
	__property Extctrls::TSectionEvent OnSized = {read=FOnSized, write=FOnSized};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOutLookHeader(HWND ParentWindow) : Extctrls::THeader(ParentWindow) { }
	
};


#pragma option push -b-
enum TProgressStyle { psXP, psClassic };
#pragma option pop

class DELPHICLASS TProgressAppearance;
class PASCALIMPLEMENTATION TProgressAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FUnCompleteFontColor;
	Graphics::TColor FCompleteColor;
	Graphics::TColor FUnCompleteColor;
	Graphics::TColor FCompleteFontColor;
	Classes::TNotifyEvent FOnChange;
	bool FStacked;
	bool FShowPercentage;
	bool FShowBorder;
	bool FCompletionSmooth;
	bool FShowGradient;
	int FLevel2Perc;
	int FLevel1Perc;
	int FSteps;
	Graphics::TColor FLevel3Color;
	Graphics::TColor FLevel1Color;
	Graphics::TColor FLevel0Color;
	Graphics::TColor FLevel3ColorTo;
	Graphics::TColor FLevel2ColorTo;
	Graphics::TColor FLevel0ColorTo;
	Graphics::TColor FLevel1ColorTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FLevel2Color;
	TProgressStyle FStyle;
	void __fastcall SetCompleteColor(const Graphics::TColor Value);
	void __fastcall SetCompleteFontColor(const Graphics::TColor Value);
	void __fastcall SetUnCompleteColor(const Graphics::TColor Value);
	void __fastcall SetUnCompleteFontColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCompletionSmooth(const bool Value);
	void __fastcall SetLevel0Color(const Graphics::TColor Value);
	void __fastcall SetLevel0ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Color(const Graphics::TColor Value);
	void __fastcall SetLevel1ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Perc(const int Value);
	void __fastcall SetLevel2Color(const Graphics::TColor Value);
	void __fastcall SetLevel2ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel2Perc(const int Value);
	void __fastcall SetLevel3Color(const Graphics::TColor Value);
	void __fastcall SetLevel3ColorTo(const Graphics::TColor Value);
	void __fastcall SetShowBorder(const bool Value);
	void __fastcall SetShowGradient(const bool Value);
	void __fastcall SetShowPercentage(const bool Value);
	void __fastcall SetStacked(const bool Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall SetStyle(const TProgressStyle Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TProgressAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor CompleteColor = {read=FCompleteColor, write=SetCompleteColor, default=255};
	__property Graphics::TColor CompleteFontColor = {read=FCompleteFontColor, write=SetCompleteFontColor, default=16711680};
	__property Graphics::TColor UnCompleteColor = {read=FUnCompleteColor, write=SetUnCompleteColor, default=536870911};
	__property Graphics::TColor UnCompleteFontColor = {read=FUnCompleteFontColor, write=SetUnCompleteFontColor, default=-16777208};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, default=65280};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, default=14811105};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, default=65535};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, default=13303807};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, default=5483007};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, default=11064319};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, default=255};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, default=13290239};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, default=70};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, default=90};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=0};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property TProgressStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, default=1};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, default=1};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, default=1};
	__property int Steps = {read=FSteps, write=SetSteps, default=11};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TProgressAppearance(void) { }
	
};


class DELPHICLASS TPreviewSetting;
class PASCALIMPLEMENTATION TPreviewSetting : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FActive;
	int FColumn;
	Classes::TNotifyEvent FOnChange;
	int FHeight;
	Graphics::TFont* FFont;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetColumn(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall OnFontChange(System::TObject* Sender);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TPreviewSetting(void);
	__fastcall virtual ~TPreviewSetting(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property int Column = {read=FColumn, write=SetColumn, default=-1};
	__property int Height = {read=FHeight, write=SetHeight, default=40};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TURLSettings;
class PASCALIMPLEMENTATION TURLSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColor;
	Graphics::TFontStyles FFontStyle;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFontStyle(const Graphics::TFontStyles Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TURLSettings(void);
	__fastcall virtual ~TURLSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16711680};
	__property Graphics::TFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TSortSettings;
class PASCALIMPLEMENTATION TSortSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	int FColumn;
	Graphics::TBitmap* FGlyphDown;
	Graphics::TBitmap* FGlyphUp;
	TSortDirection FDirection;
	bool FEnabled;
	bool FSortGroups;
	void __fastcall OnGlyphChange(System::TObject* Sender);
	void __fastcall SetColumn(const int Value);
	void __fastcall SetDirection(const TSortDirection Value);
	void __fastcall SetGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphUp(const Graphics::TBitmap* Value);
	void __fastcall SetSortGroups(const bool Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TSortSettings(void);
	__fastcall virtual ~TSortSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Column = {read=FColumn, write=SetColumn, default=-1};
	__property TSortDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property Graphics::TBitmap* GlyphUp = {read=FGlyphUp, write=SetGlyphUp};
	__property Graphics::TBitmap* GlyphDown = {read=FGlyphDown, write=SetGlyphDown};
	__property bool SortGroups = {read=FSortGroups, write=SetSortGroups, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TLookUpSettings;
class PASCALIMPLEMENTATION TLookUpSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	int FColumn;
	TLookUpMethod FMethod;
	void __fastcall SetColumn(const int Value);
	void __fastcall SetMethod(const TLookUpMethod Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TLookUpSettings(void);
	__fastcall virtual ~TLookUpSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Column = {read=FColumn, write=SetColumn, default=-1};
	__property TLookUpMethod Method = {read=FMethod, write=SetMethod, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TDrawItemPropEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item, int Column, System::UnicodeString AValue, Graphics::TBrush* ABrush, Graphics::TFont* AFont);

typedef void __fastcall (__closure *TDrawItemValueEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item, int Column, System::UnicodeString &Value);

typedef void __fastcall (__closure *TDrawItemEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item, int Column, System::UnicodeString Value, Graphics::TCanvas* ItemCanvas, const Types::TRect &ItemRect);

typedef void __fastcall (__closure *TURLClickEvent)(System::TObject* sender, Outlookgroupedlist::POGLItem item, int columnIndex, System::UnicodeString URL, bool &Default);

typedef void __fastcall (__closure *TAOLItemClickEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item, int Column);

typedef void __fastcall (__closure *TAOLItemEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item);

typedef void __fastcall (__closure *TAOLHeaderClickEvent)(System::TObject* Sender, int Column);

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item, int Column, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TCheckBoxClickEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item, int Column, bool NewValue);

typedef void __fastcall (__closure *TOnHeaderDragDropEvent)(System::TObject* Sender, int FromCol, int ToCol);

typedef void __fastcall (__closure *TOnCustomCompareEvent)(System::TObject* Sender, Outlookgroupedlist::POGLItem Item1, Outlookgroupedlist::POGLItem Item2, int Column, System::UnicodeString Value1, System::UnicodeString Value2, int &SortResult);

typedef void __fastcall (__closure *TOnSortedEvent)(System::TObject* Sender, int ColumnIndex);

typedef void __fastcall (__closure *TAOLDragOverEvent)(TAdvOutlookList* Sender, const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, Controls::TDragState State, int &Effect, bool &Accept);

typedef void __fastcall (__closure *TAOLDropEvent)(TAdvOutlookList* Sender, const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, Outlookgroupedlist::TClipFormatArray Formats, int &Effect);

typedef void __fastcall (__closure *TAOLGetDataEvent)(TAdvOutlookList* Sender, const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &Medium, HRESULT &Result);

typedef void __fastcall (__closure *TAOLGetClipboardFormatsEvent)(TAdvOutlookList* Sender, Outlookgroupedlist::TFormatEtcArray &Formats);

typedef void __fastcall (__closure *TAOLDragAllowedEvent)(TAdvOutlookList* Sender, Outlookgroupedlist::POGLItem Item, bool &Allowed);

typedef void __fastcall (__closure *TAOLGetCaptionEvent)(TAdvOutlookList* Sender, Outlookgroupedlist::POGLItem Item, System::UnicodeString &Caption);

typedef void __fastcall (__closure *TOnGetItemHintEvent)(TAdvOutlookList* Sender, Outlookgroupedlist::POGLItem Item, int ColumnIndex, System::UnicodeString &HintText);

typedef void __fastcall (__closure *TOnGetGroupHintEvent)(TAdvOutlookList* Sender, Outlookgroupedlist::POGLItem Item, System::UnicodeString &HintText);

typedef void __fastcall (__closure *TOLEItemData)(TAdvOutlookList* Sender, Classes::TStrings* Data);

class PASCALIMPLEMENTATION TAdvOutlookList : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAdvOutlookColumns* FColumns;
	Forms::TFormBorderStyle FBorderStyle;
	Outlookgroupedlist::TOutlookGroupedList* FList;
	TAdvOutLookHeader* FHeader;
	Graphics::TColor FColumnLineColor;
	TURLSettings* FURLSettings;
	Controls::TImageList* FImages;
	TDrawItemEvent FOnDrawItem;
	TDrawItemPropEvent FOnDrawItemProp;
	TDrawItemValueEvent FOnDrawItemValue;
	TCheckBoxStyle FCheckBoxStyle;
	TProgressAppearance* FProgressAppearance;
	TURLClickEvent FOnURLClick;
	TPreviewSetting* FPreviewSettings;
	Graphics::TColor FHeaderBorderColor;
	Graphics::TColor FBorderColor;
	TAOLItemClickEvent FOnItemRightClick;
	TAOLItemClickEvent FOnItemClick;
	TAOLItemClickEvent FOnItemDblClick;
	TAOLItemEvent FOnGroupClick;
	TAOLItemEvent FOnGroupRightClick;
	TAOLHeaderClickEvent FOnHeaderRightClick;
	TAOLHeaderClickEvent FOnHeaderClick;
	TAOLHeaderClickEvent FOnHeaderDblClick;
	TSortSettings* FSortSettings;
	bool FSorting;
	bool FEllipsis;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Picturecontainer::TPictureContainer* FContainer;
	int FHoverHyperLink;
	int FOldHoverHyperLink;
	int FShadowOffset;
	bool FHover;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	Graphics::TColor FShadowColor;
	System::UnicodeString FAnchor;
	TAnchorClick FAnchorExit;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	Types::TRect FCurrHoverRect;
	int FGroupColumn;
	int FCurrentGroupColumn;
	Graphics::TColor FColor;
	TCheckBoxClickEvent FOnCheckBoxClick;
	TDragDropSetting FHeaderDragDrop;
	TDragDropSetting FDragDropSetting;
	TOnHeaderDragDropEvent FOnHeaderDragDrop;
	THeaderResizedEvent FOnHeaderResized;
	int FMouseOverCol;
	int FItemHeight;
	int FPreviewedColumn;
	TAOLDragAllowedEvent FOnOLEDragAllowed;
	TAOLDragOverEvent FOnOLEDragOver;
	TAOLDropEvent FOnOLEDrop;
	TAOLGetClipboardFormatsEvent FOnOLEGetClipboardFormats;
	TAOLGetDataEvent FOnOLEGetData;
	TAOLGetCaptionEvent FOnGetCaption;
	Outlookgroupedlist::TDragDropMode FDragDropMode;
	Classes::TStringList* FDragFileList;
	TOLEItemData FOnOLEGetItemData;
	TOLEItemData FOnOLEItemDrop;
	int FGroupItemHeight;
	TOnCustomCompareEvent FOnCustomCompare;
	TAOLItemEvent FOnGroupDblClick;
	bool FGroupShowCount;
	Classes::TNotifyEvent FOnSelectionChange;
	TOnSortedEvent FOnSorted;
	bool FHideSelection;
	TLookUpSettings* FLookUp;
	System::UnicodeString FLookUpText;
	TGroupColumnDisplay FGroupColumnDisplay;
	Outlookgroupedlist::TOGLDragType FDragType;
	Outlookgroupedlist::TOGLSelectionOptions FSelectionOptions;
	bool FHeaderResize;
	Classes::TList* FGroupList;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionTextColor;
	Controls::TMouseMoveEvent FOnMouseMove;
	Controls::TMouseEvent FOnMouseDown;
	Controls::TMouseEvent FOnMouseUp;
	Graphics::TColor FGroupColor;
	Graphics::TColor FGroupSelectionColor;
	Graphics::TColor FGroupSelectionTextColor;
	Graphics::TFont* FGroupFont;
	Graphics::TFont* FGroupCountFont;
	TAOLItemEvent FOnGroupExpand;
	TAOLItemEvent FOnGroupCollaps;
	TOnGetGroupHintEvent FOnGetGroupHint;
	TOnGetItemHintEvent FOnGetItemHint;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall CMTabStopChanged(Messages::TMessage &Message);
	void __fastcall OnPreviewSettingChange(System::TObject* Sender);
	void __fastcall OnProgressAppearanceChange(System::TObject* Sender);
	void __fastcall OnURLSettingsChange(System::TObject* Sender);
	void __fastcall OnHeaderSized(System::TObject* Sender, int ColIdx, int ColWidth);
	void __fastcall OnListMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnListMouseDownOnItem(Outlookgroupedlist::TOutlookGroupedList* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y, const Outlookgroupedlist::TOGLItemHitInfo &HitInfo);
	void __fastcall OnListMouseUpOnItem(Outlookgroupedlist::TOutlookGroupedList* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y, const Outlookgroupedlist::TOGLItemHitInfo &HitInfo);
	void __fastcall OnListItemDblClick(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item, int X, int Y);
	void __fastcall OnListKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnListKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnListKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OnListCompareItems(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item1, Outlookgroupedlist::POGLItem Item2, Outlookgroupedlist::TOGLSortColumn Column, int &Result);
	void __fastcall OnListGetHint(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item, System::UnicodeString &HintText, Types::TPoint &HintPos);
	void __fastcall OnListGetGroupImageIndex(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item, int &ImageIndex);
	void __fastcall OnListSelectionChange(System::TObject* Sender);
	void __fastcall OnListOLEDragAllowed(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item, bool &Allowed);
	void __fastcall OnListOLEDragOver(Outlookgroupedlist::TOutlookGroupedList* Sender, const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, Controls::TDragState State, int &Effect, bool &Accept);
	void __fastcall OnListOLEDrop(Outlookgroupedlist::TOutlookGroupedList* Sender, const _di_IDataObject DataObject, Classes::TShiftState Shift, const Types::TPoint &Pt, Outlookgroupedlist::TClipFormatArray Formats, int &Effect);
	void __fastcall OnListOLEGetData(Outlookgroupedlist::TOutlookGroupedList* Sender, const tagFORMATETC &FormatEtcIn, /* out */ tagSTGMEDIUM &Medium, HRESULT &Result);
	void __fastcall OnListOLEGetClipboardFormats(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::TFormatEtcArray &Formats);
	void __fastcall OnListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall OnListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall OnColumnRefresh(System::TObject* Sender);
	void __fastcall OnHeaderSectClick(System::TObject* Sender, int SectionIndex);
	void __fastcall OnHeaderSectRightClick(System::TObject* Sender, int SectionIndex);
	void __fastcall OnHeaderSectDblClick(System::TObject* Sender, int SectionIndex);
	void __fastcall OnSortChange(System::TObject* Sender);
	void __fastcall OnGroupCountFontChanged(System::TObject* Sender);
	void __fastcall OnGroupFontChanged(System::TObject* Sender);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	void __fastcall FreeItem(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item);
	void __fastcall DrawItem(Outlookgroupedlist::TOutlookGroupedList* Sender, Graphics::TCanvas* ItemCanvas, const Types::TRect &ItemRect, Outlookgroupedlist::POGLItem Item);
	void __fastcall GetCaption(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item, System::UnicodeString &Caption);
	void __fastcall GetItemHeight(Outlookgroupedlist::TOutlookGroupedList* Sender, const Graphics::TCanvas* OGLCanvas, System::Word &ItemHeight);
	void __fastcall SetColumnLineColor(const Graphics::TColor Value);
	void __fastcall SetURLSettings(const TURLSettings* Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetCheckBoxStyle(const TCheckBoxStyle Value);
	void __fastcall SetProgressAppearance(const TProgressAppearance* Value);
	void __fastcall SetPreviewSettings(const TPreviewSetting* Value);
	void __fastcall SetHeaderBorderColor(const Graphics::TColor Value);
	void __fastcall SetHeaderHeight(const int Value);
	void __fastcall SetItemHeight(const int Value);
	int __fastcall GetHeaderHeight(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetSortSettings(const TSortSettings* Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetHoverFontColor(const Graphics::TColor Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetGroupColumn(const int Value);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionTextColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetHeaderDragDrop(const TDragDropSetting Value);
	void __fastcall SetHeaderResize(const bool Value);
	void __fastcall SetDragDropSetting(const TDragDropSetting Value);
	Outlookgroupedlist::POGLItem __fastcall GetDropTargetGroup(void);
	Outlookgroupedlist::POGLItem __fastcall GetFocusedItem(void);
	void __fastcall SetFocusedItem(const Outlookgroupedlist::POGLItem Value);
	Outlookgroupedlist::POGLItem __fastcall GetRootItem(void);
	void __fastcall SetDragDropMode(const Outlookgroupedlist::TDragDropMode Value);
	TOutlookGroup* __fastcall GetGroup(int Index);
	int __fastcall GetGroupCount(void);
	void __fastcall SetGroupItemHeight(const int Value);
	bool __fastcall GetShowNodes(void);
	void __fastcall SetShowNodes(const bool Value);
	Outlookgroupedlist::POGLItem __fastcall GetFirstGroupItem(void);
	Outlookgroupedlist::POGLItem __fastcall GetFirstSelectedItem(void);
	int __fastcall GetSelectedCount(void);
	void __fastcall SetGroupShowCount(const bool Value);
	void __fastcall SetHideSelection(const bool Value);
	void __fastcall SetLookUp(const TLookUpSettings* Value);
	void __fastcall SetGroupColumnDisplay(const TGroupColumnDisplay Value);
	void __fastcall SetDragType(const Outlookgroupedlist::TOGLDragType Value);
	void __fastcall SetSelectionOptions(const Outlookgroupedlist::TOGLSelectionOptions Value);
	void __fastcall SetGroupColor(const Graphics::TColor Value);
	void __fastcall SetGroupCountFont(const Graphics::TFont* Value);
	void __fastcall SetGroupFont(const Graphics::TFont* Value);
	void __fastcall SetGroupSelectionColor(const Graphics::TColor Value);
	void __fastcall SetGroupSelectionTextColor(const Graphics::TColor Value);
	
protected:
	void __fastcall HeaderChanged(System::TObject* Sender);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall DoExpand(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item);
	void __fastcall DoCollaps(Outlookgroupedlist::TOutlookGroupedList* Sender, Outlookgroupedlist::POGLItem Item);
	virtual bool __fastcall HTMLPaint(Graphics::TCanvas* Canvas, System::UnicodeString s, const Types::TRect &fr, Controls::TImageList* FImages, int xpos, int ypos, int focuslink, int hoverlink, int shadowoffset, bool checkhotspot, bool checkheight, bool print, bool selected, bool blink, bool hoverstyle, double resfactor, Graphics::TColor urlcolor, Graphics::TColor hovercolor, Graphics::TColor hoverfontColor, Graphics::TColor shadowcolor, System::UnicodeString &anchorval, System::UnicodeString &stripval, System::UnicodeString &focusanchor, int &xsize, int &ysize, int &hyperlinks, int &mouselink, Types::TRect &hoverrect);
	System::UnicodeString __fastcall IsAnchor(int x, int y, int Col, const Types::TRect &CellRect, System::UnicodeString CellValue, Types::TRect &HoverRect);
	void __fastcall SortItems(void);
	void __fastcall ToggleCheck(Outlookgroupedlist::POGLItem Item, int ColIndex);
	TAdvOutlookColumn* __fastcall ColAtPoint(const Types::TRect &ItemRect, int X, int Y, Types::TRect &ColRect);
	Types::TRect __fastcall GetCellRect(const Types::TRect &ItemRect, int ColIndex);
	bool __fastcall PtOnItemText(Outlookgroupedlist::POGLItem Item, int ColIndex, const Types::TRect &ColRect, const Types::TPoint &P);
	int __fastcall MapHeaderSecToCol(int SectionIndex);
	int __fastcall MapColToHeaderSec(int ColIndex);
	void __fastcall MoveHeaderSec(int FromIndex, int ToIndex);
	bool __fastcall IsGroupColumn(int ColIndex);
	bool __fastcall IsPreviewColumn(int ColIndex);
	int __fastcall GetHeaderSecIndex(int ColIndex);
	void __fastcall UpdateHeaderSecIndexes(void);
	void __fastcall SetGrouping(void);
	int __fastcall MapColumn(int Column);
	int __fastcall GetLastCol(void);
	void __fastcall Locate(System::UnicodeString s, int Col);
	void __fastcall ListMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property bool Hover = {read=FHover, write=SetHover, nodefault};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, nodefault};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=SetHoverFontColor, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, nodefault};
	__property Picturecontainer::THTMLPictureCache* ImageCache = {read=FImageCache};
	
public:
	__fastcall virtual TAdvOutlookList(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOutlookList(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall TestFill(void);
	virtual void __fastcall SetFocus(void);
	bool __fastcall IsGroupExpanded(Outlookgroupedlist::POGLItem Item);
	bool __fastcall ExpandItem(Outlookgroupedlist::POGLItem Item);
	bool __fastcall CollapseItem(Outlookgroupedlist::POGLItem Item);
	void __fastcall ToggleExpandedItem(Outlookgroupedlist::POGLItem Item);
	TOutlookGroup* __fastcall AddGroup(System::UnicodeString Caption);
	TOutlookGroup* __fastcall InsertGroup(int Index, System::UnicodeString Caption);
	Classes::TStrings* __fastcall AddItem(TOutlookGroup* Group)/* overload */;
	Outlookgroupedlist::POGLItem __fastcall AddItem(Outlookgroupedlist::POGLItem ParentItem = (void *)(0x0))/* overload */;
	void __fastcall DeleteItem(Outlookgroupedlist::POGLItem Item, bool Reindex = true);
	void __fastcall DeleteSelectedItems(bool ReIndex = true);
	void __fastcall DeleteGroup(int Index);
	void __fastcall DeleteAllGroups(void);
	__property TOutlookGroup* Groups[int Index] = {read=GetGroup};
	int __fastcall GroupIndex(TOutlookGroup* Group);
	void __fastcall ClearGroups(void);
	int __fastcall ColumnIndex(int Column);
	__property int GroupColumn = {read=FGroupColumn, write=SetGroupColumn, default=0};
	__property int GroupCount = {read=GetGroupCount, nodefault};
	TOutlookGroup* __fastcall ItemGroup(Outlookgroupedlist::POGLItem Item);
	int __fastcall GetVersionNr(void);
	void __fastcall Sort(void);
	void __fastcall SelectAll(void);
	void __fastcall SelectItem(Outlookgroupedlist::POGLItem Item);
	void __fastcall UnSelectItem(Outlookgroupedlist::POGLItem Item);
	void __fastcall UnselectAll(void);
	bool __fastcall ExpandAll(void);
	bool __fastcall CollapseAll(void);
	bool __fastcall IsItemSelected(Outlookgroupedlist::POGLItem Item);
	bool __fastcall IsGroupItem(Outlookgroupedlist::POGLItem Item);
	bool __fastcall ScrollIntoView(Outlookgroupedlist::POGLItem Item, bool AutoScrollOnExpand = false);
	Classes::TStrings* __fastcall GetItemData(Outlookgroupedlist::POGLItem Item)/* overload */;
	Outlookgroupedlist::POGLItem __fastcall CaptionToItem(System::UnicodeString ACaption, const Outlookgroupedlist::POGLItem GroupItem = (void *)(0x0));
	__property Outlookgroupedlist::POGLItem DropTargetGroup = {read=GetDropTargetGroup};
	__property Outlookgroupedlist::POGLItem FocusedItem = {read=GetFocusedItem, write=SetFocusedItem};
	__property Outlookgroupedlist::POGLItem RootItem = {read=GetRootItem};
	__property Outlookgroupedlist::POGLItem FirstGroupItem = {read=GetFirstGroupItem};
	__property Outlookgroupedlist::POGLItem FirstSelectedItem = {read=GetFirstSelectedItem};
	__property int SelectedCount = {read=GetSelectedCount, nodefault};
	__property Outlookgroupedlist::TOutlookGroupedList* List = {read=FList};
	Outlookgroupedlist::POGLItem __fastcall NextSelectedItem(Outlookgroupedlist::POGLItem Item);
	Outlookgroupedlist::POGLItem __fastcall ItemAtXY(int X, int Y);
	TOutlookGroup* __fastcall GroupAtXY(int X, int Y);
	void __fastcall SetStyle(TAdvOutlookListStyle AStyle);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property TCheckBoxStyle CheckBoxStyle = {read=FCheckBoxStyle, write=SetCheckBoxStyle, default=2};
	__property TAdvOutlookColumns* Columns = {read=FColumns, write=FColumns};
	__property Graphics::TColor ColumnLineColor = {read=FColumnLineColor, write=SetColumnLineColor, default=12632256};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property Constraints;
	__property Outlookgroupedlist::TDragDropMode DragDropMode = {read=FDragDropMode, write=SetDragDropMode, default=0};
	__property TDragDropSetting DragDropSetting = {read=FDragDropSetting, write=SetDragDropSetting, default=0};
	__property int GroupItemHeight = {read=FGroupItemHeight, write=SetGroupItemHeight, nodefault};
	__property bool GroupShowCount = {read=FGroupShowCount, write=SetGroupShowCount, nodefault};
	__property Graphics::TColor HeaderBorderColor = {read=FHeaderBorderColor, write=SetHeaderBorderColor, default=12632256};
	__property TDragDropSetting HeaderDragDrop = {read=FHeaderDragDrop, write=SetHeaderDragDrop, default=0};
	__property int HeaderHeight = {read=GetHeaderHeight, write=SetHeaderHeight, default=20};
	__property bool HeaderResize = {read=FHeaderResize, write=SetHeaderResize, default=1};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=20};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Outlookgroupedlist::TOGLDragType DragType = {read=FDragType, write=SetDragType, default=0};
	__property TLookUpSettings* LookUp = {read=FLookUp, write=SetLookUp};
	__property TGroupColumnDisplay GroupColumnDisplay = {read=FGroupColumnDisplay, write=SetGroupColumnDisplay, nodefault};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property PopupMenu;
	__property TProgressAppearance* ProgressAppearance = {read=FProgressAppearance, write=SetProgressAppearance};
	__property TPreviewSetting* PreviewSettings = {read=FPreviewSettings, write=SetPreviewSettings};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, default=-16777203};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=SetSelectionTextColor, default=-16777202};
	__property Outlookgroupedlist::TOGLSelectionOptions SelectionOptions = {read=FSelectionOptions, write=SetSelectionOptions, default=3};
	__property Graphics::TFont* GroupFont = {read=FGroupFont, write=SetGroupFont};
	__property Graphics::TFont* GroupCountFont = {read=FGroupCountFont, write=SetGroupCountFont};
	__property Graphics::TColor GroupColor = {read=FGroupColor, write=SetGroupColor, default=536870911};
	__property Graphics::TColor GroupSelectionColor = {read=FGroupSelectionColor, write=SetGroupSelectionColor, default=-16777203};
	__property Graphics::TColor GroupSelectionTextColor = {read=FGroupSelectionTextColor, write=SetGroupSelectionTextColor, default=16777215};
	__property ShowHint;
	__property bool ShowNodes = {read=GetShowNodes, write=SetShowNodes, nodefault};
	__property TSortSettings* SortSettings = {read=FSortSettings, write=SetSortSettings};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property TURLSettings* URLSettings = {read=FURLSettings, write=SetURLSettings};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property TDrawItemPropEvent OnDrawItemProp = {read=FOnDrawItemProp, write=FOnDrawItemProp};
	__property TDrawItemValueEvent OnDrawItemValue = {read=FOnDrawItemValue, write=FOnDrawItemValue};
	__property TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TURLClickEvent OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property TAOLHeaderClickEvent OnHeaderClick = {read=FOnHeaderClick, write=FOnHeaderClick};
	__property TAOLHeaderClickEvent OnHeaderRightClick = {read=FOnHeaderRightClick, write=FOnHeaderRightClick};
	__property TAOLHeaderClickEvent OnHeaderDblClick = {read=FOnHeaderDblClick, write=FOnHeaderDblClick};
	__property TOnHeaderDragDropEvent OnHeaderDragDrop = {read=FOnHeaderDragDrop, write=FOnHeaderDragDrop};
	__property THeaderResizedEvent OnHeaderResized = {read=FOnHeaderResized, write=FOnHeaderResized};
	__property TAOLItemClickEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TAOLItemClickEvent OnItemRightClick = {read=FOnItemRightClick, write=FOnItemRightClick};
	__property TAOLItemClickEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TAOLItemEvent OnGroupClick = {read=FOnGroupClick, write=FOnGroupClick};
	__property TAOLItemEvent OnGroupDblClick = {read=FOnGroupDblClick, write=FOnGroupDblClick};
	__property TAOLItemEvent OnGroupRightClick = {read=FOnGroupRightClick, write=FOnGroupRightClick};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property TAOLItemEvent OnGroupExpand = {read=FOnGroupExpand, write=FOnGroupExpand};
	__property TAOLItemEvent OnGroupCollaps = {read=FOnGroupCollaps, write=FOnGroupCollaps};
	__property Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property TCheckBoxClickEvent OnCheckBoxClick = {read=FOnCheckBoxClick, write=FOnCheckBoxClick};
	__property TAOLDragOverEvent OnOLEDragOver = {read=FOnOLEDragOver, write=FOnOLEDragOver};
	__property TAOLDropEvent OnOLEDrop = {read=FOnOLEDrop, write=FOnOLEDrop};
	__property TAOLGetDataEvent OnOLEGetData = {read=FOnOLEGetData, write=FOnOLEGetData};
	__property TAOLGetClipboardFormatsEvent OnOLEGetClipboardFormats = {read=FOnOLEGetClipboardFormats, write=FOnOLEGetClipboardFormats};
	__property TAOLDragAllowedEvent OnOLEDragAllowed = {read=FOnOLEDragAllowed, write=FOnOLEDragAllowed};
	__property TAOLGetCaptionEvent OnGetCaption = {read=FOnGetCaption, write=FOnGetCaption};
	__property TOLEItemData OnOLEGetItemData = {read=FOnOLEGetItemData, write=FOnOLEGetItemData};
	__property TOLEItemData OnOLEItemDrop = {read=FOnOLEItemDrop, write=FOnOLEItemDrop};
	__property TOnCustomCompareEvent OnCustomCompare = {read=FOnCustomCompare, write=FOnCustomCompare};
	__property Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	__property TOnSortedEvent OnSorted = {read=FOnSorted, write=FOnSorted};
	__property TOnGetItemHintEvent OnGetItemHint = {read=FOnGetItemHint, write=FOnGetItemHint};
	__property TOnGetGroupHintEvent OnGetGroupHint = {read=FOnGetGroupHint, write=FOnGetGroupHint};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnKeyPress;
	__property OnKeyDown;
	__property OnKeyUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOutlookList(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


#pragma option push -b-
enum TGaugeOrientation { goHorizontal, goVertical };
#pragma option pop

struct TGaugeSettings
{
	
public:
	Graphics::TColor Level0Color;
	Graphics::TColor Level0ColorTo;
	Graphics::TColor Level1Color;
	Graphics::TColor Level1ColorTo;
	Graphics::TColor Level2Color;
	Graphics::TColor Level2ColorTo;
	Graphics::TColor Level3Color;
	Graphics::TColor Level3ColorTo;
	int Level1Perc;
	int Level2Perc;
	Graphics::TColor BorderColor;
	bool ShowBorder;
	bool Stacked;
	bool ShowPercentage;
	Graphics::TFont* Font;
	bool CompletionSmooth;
	bool ShowGradient;
	int Steps;
	int Position;
	Graphics::TColor BackgroundColor;
	TGaugeOrientation Orientation;
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CHECKBOX_SIZE = 0xf;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x7;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advoutlooklist */
using namespace Advoutlooklist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvoutlooklistHPP
