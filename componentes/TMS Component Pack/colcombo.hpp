// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Colcombo.pas' rev: 21.00

#ifndef ColcomboHPP
#define ColcomboHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Advcombo.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Colcombo
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TColumnType { ctText, ctImage };
#pragma option pop

class DELPHICLASS TComboColumnItem;
class PASCALIMPLEMENTATION TComboColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FWidth;
	Classes::TAlignment FAlignment;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	TColumnType FColumnType;
	void __fastcall SetWidth(const int Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColumnType(const TColumnType Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TComboColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TComboColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property TColumnType ColumnType = {read=FColumnType, write=SetColumnType, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TComboColumnCollection;
class DELPHICLASS TColumnComboBox;
class PASCALIMPLEMENTATION TComboColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TColumnComboBox* FOwner;
	HIDESBASE TComboColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TComboColumnItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TComboColumnItem* __fastcall Add(void);
	HIDESBASE TComboColumnItem* __fastcall Insert(int index);
	__property TComboColumnItem* Items[int Index] = {read=GetItem, write=SetItem};
	__fastcall TComboColumnCollection(TColumnComboBox* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TComboColumnCollection(void) { }
	
};


class DELPHICLASS TComboItem;
class PASCALIMPLEMENTATION TComboItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	Classes::TStringList* FStrings;
	int FTag;
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetStrings(const Classes::TStringList* Value);
	void __fastcall StringsChanged(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TComboItem(Classes::TCollection* Collection);
	__fastcall virtual ~TComboItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property Classes::TStringList* Strings = {read=FStrings, write=SetStrings};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TComboItemCollection;
class PASCALIMPLEMENTATION TComboItemCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TComboItem* operator[](int Index) { return Items[Index]; }
	
private:
	TColumnComboBox* FOwner;
	HIDESBASE TComboItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TComboItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TComboItem* __fastcall Add(void);
	HIDESBASE TComboItem* __fastcall Insert(int index);
	__property TComboItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TComboItemCollection(TColumnComboBox* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	Types::TPoint __fastcall IndexOf(System::UnicodeString s);
	int __fastcall IndexInColumnOf(int col, System::UnicodeString s);
	int __fastcall IndexInRowOf(int row, System::UnicodeString s);
	void __fastcall SaveToFile(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TComboItemCollection(void) { }
	
};


#pragma option push -b-
enum TLabelPosition { lpLeftTop, lpLeftCenter, lpLeftBottom, lpTopLeft, lpBottomLeft, lpLeftTopLeft, lpLeftCenterLeft, lpLeftBottomLeft, lpTopCenter, lpBottomCenter, lpRightTop, lpRightCenter, lpRighBottom, lpTopRight, lpBottomRight };
#pragma option pop

class PASCALIMPLEMENTATION TColumnComboBox : public Advcombo::TAdvCustomCombo
{
	typedef Advcombo::TAdvCustomCombo inherited;
	
private:
	Controls::TImageList* FImages;
	int FDropHeight;
	TComboColumnCollection* FColumns;
	TComboItemCollection* fComboItems;
	bool FGridLines;
	int FEditColumn;
	int FItemIndex;
	int FSelItemIndex;
	int FUpdateCount;
	System::UnicodeString FLookup;
	int FLookupColumn;
	bool FLookupIncr;
	int FSortColumn;
	bool FSortedEx;
	bool FDropped;
	bool FShowItemHint;
	int FDropWidth;
	bool FDisableSelChange;
	bool FShowLookup;
	int FProgChange;
	Stdctrls::TLabel* FLabel;
	Graphics::TFont* FLabelFont;
	TLabelPosition FLabelPosition;
	int FLabelMargin;
	bool FLabelTransparent;
	bool FFocusLabel;
	bool FLabelAlwaysEnabled;
	Classes::TNotifyEvent FOnLabelClick;
	Classes::TNotifyEvent FOnLabelDblClick;
	bool FParentFnt;
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE void __fastcall SetDropWidth(int Value);
	int __fastcall GetDropWidth(void);
	void __fastcall SetEditHeight(int Value);
	int __fastcall GetEditHeight(void);
	void __fastcall SetImages(const Controls::TImageList* Value);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	void __fastcall SetItemIndexP(const int Value);
	int __fastcall GetItemIndexP(void);
	void __fastcall SetGridLines(const bool Value);
	void __fastcall SetEditColumn(const int Value);
	void __fastcall BuildItems(void);
	System::UnicodeString __fastcall GetColumnItems(int i, int j);
	void __fastcall SetColumnItems(int i, int j, const System::UnicodeString Value);
	bool __fastcall GetSortedEx(void);
	void __fastcall SetSortedEx(const bool Value);
	void __fastcall Sort(void);
	System::WideChar __fastcall GetDelimiter(void);
	void __fastcall SetDelimiter(const System::WideChar Value);
	void __fastcall QuickSortList(Classes::TStringList* List, int left, int right);
	System::UnicodeString __fastcall GetEditText(void);
	System::UnicodeString __fastcall GetVersion(void);
	HIDESBASE void __fastcall SetVersion(const System::UnicodeString Value);
	HIDESBASE void __fastcall SetLabelCaption(const System::UnicodeString value);
	HIDESBASE System::UnicodeString __fastcall GetLabelCaption(void);
	HIDESBASE void __fastcall SetLabelPosition(const TLabelPosition value);
	HIDESBASE void __fastcall SetLabelMargin(const int value);
	HIDESBASE void __fastcall SetLabelTransparent(const bool value);
	HIDESBASE void __fastcall UpdateLabel(void);
	HIDESBASE void __fastcall LabelFontChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetLabelFont(const Graphics::TFont* Value);
	HIDESBASE void __fastcall SetLabelAlwaysEnabled(const bool Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall SetStyle(Stdctrls::TComboBoxStyle Value);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property Items;
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	HIDESBASE Stdctrls::TLabel* __fastcall CreateLabel(void);
	void __fastcall LabelClick(System::TObject* Sender);
	void __fastcall LabelDblClick(System::TObject* Sender);
	
public:
	__fastcall virtual TColumnComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TColumnComboBox(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Text;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property System::UnicodeString ColumnItems[int i][int j] = {read=GetColumnItems, write=SetColumnItems};
	__property System::WideChar Delimiter = {read=GetDelimiter, write=SetDelimiter, nodefault};
	__property System::UnicodeString EditText = {read=GetEditText};
	__property Stdctrls::TLabel* EditLabel = {read=FLabel};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property DragKind = {default=0};
	__property Color;
	__property Ctl3D;
	__property TComboColumnCollection* Columns = {read=FColumns, write=FColumns};
	__property TComboItemCollection* ComboItems = {read=fComboItems, write=fComboItems};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property int EditColumn = {read=FEditColumn, write=SetEditColumn, nodefault};
	__property int EditHeight = {read=GetEditHeight, write=SetEditHeight, nodefault};
	__property int DropWidth = {read=GetDropWidth, write=SetDropWidth, nodefault};
	__property int DropHeight = {read=FDropHeight, write=FDropHeight, nodefault};
	__property DropDownCount = {default=8};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Enabled;
	__property Etched = {default=0};
	__property Flat = {default=0};
	__property FlatParentColor = {default=1};
	__property FlatLineColor = {default=0};
	__property FocusBorder = {default=0};
	__property bool FocusLabel = {read=FFocusLabel, write=FFocusLabel, default=0};
	__property Font;
	__property bool GridLines = {read=FGridLines, write=SetGridLines, nodefault};
	__property int ItemIndex = {read=GetItemIndexP, write=SetItemIndexP, nodefault};
	__property bool LookupIncr = {read=FLookupIncr, write=FLookupIncr, default=0};
	__property int LookupColumn = {read=FLookupColumn, write=FLookupColumn, nodefault};
	__property System::UnicodeString LabelCaption = {read=GetLabelCaption, write=SetLabelCaption};
	__property TLabelPosition LabelPosition = {read=FLabelPosition, write=SetLabelPosition, default=0};
	__property int LabelMargin = {read=FLabelMargin, write=SetLabelMargin, default=4};
	__property bool LabelTransparent = {read=FLabelTransparent, write=SetLabelTransparent, default=0};
	__property bool LabelAlwaysEnabled = {read=FLabelAlwaysEnabled, write=SetLabelAlwaysEnabled, default=0};
	__property Graphics::TFont* LabelFont = {read=FLabelFont, write=SetLabelFont};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property bool ShowLookup = {read=FShowLookup, write=FShowLookup, default=0};
	__property bool ShowItemHint = {read=FShowItemHint, write=FShowItemHint, default=0};
	__property int SortColumn = {read=FSortColumn, write=FSortColumn, nodefault};
	__property bool Sorted = {read=GetSortedEx, write=SetSortedEx, default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible;
	__property OnChange;
	__property OnClick;
	__property OnCloseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnSelect;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Classes::TNotifyEvent OnLabelClick = {read=FOnLabelClick, write=FOnLabelClick};
	__property Classes::TNotifyEvent OnLabelDblClick = {read=FOnLabelDblClick, write=FOnLabelDblClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TColumnComboBox(HWND ParentWindow) : Advcombo::TAdvCustomCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const WideChar COLUMN_DELIMITER = (WideChar)(0x7c);
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Colcombo */
using namespace Colcombo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ColcomboHPP
