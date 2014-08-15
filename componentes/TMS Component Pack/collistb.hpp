// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Collistb.pas' rev: 21.00

#ifndef CollistbHPP
#define CollistbHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Collistb
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TColumnType { ctText, ctImage };
#pragma option pop

#pragma option push -b-
enum TEllipsisType { etAtEnd, etInMiddle, etNone };
#pragma option pop

class DELPHICLASS TListBoxColumnItem;
class PASCALIMPLEMENTATION TListBoxColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FWidth;
	Classes::TAlignment FAlignment;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	TColumnType FColumnType;
	TEllipsisType FEllipsis;
	void __fastcall SetWidth(const int value);
	void __fastcall SetAlignment(const Classes::TAlignment value);
	void __fastcall SetFont(const Graphics::TFont* value);
	void __fastcall SetColor(const Graphics::TColor value);
	void __fastcall SetColumnType(const TColumnType Value);
	void __fastcall SetEllipsis(const TEllipsisType Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TListBoxColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TListBoxColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property TColumnType ColumnType = {read=FColumnType, write=SetColumnType, nodefault};
	__property TEllipsisType Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TListBoxColumnCollection;
class DELPHICLASS TColumnListBox;
class PASCALIMPLEMENTATION TListBoxColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TListBoxColumnItem* operator[](int Index) { return Items[Index]; }
	
private:
	TColumnListBox* FOwner;
	HIDESBASE TListBoxColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TListBoxColumnItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TListBoxColumnItem* __fastcall Add(void);
	HIDESBASE TListBoxColumnItem* __fastcall Insert(int index);
	__property TListBoxColumnItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TListBoxColumnCollection(TColumnListBox* aOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TListBoxColumnCollection(void) { }
	
};


class DELPHICLASS TListBoxItem;
class PASCALIMPLEMENTATION TListBoxItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	Classes::TStringList* fStrings;
	int fTag;
	void __fastcall SetImageIndex(const int value);
	void __fastcall SetStrings(const Classes::TStringList* Value);
	void __fastcall StringsChanged(System::TObject* sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TListBoxItem(Classes::TCollection* Collection);
	__fastcall virtual ~TListBoxItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property Classes::TStringList* Strings = {read=fStrings, write=SetStrings};
	__property int Tag = {read=fTag, write=fTag, nodefault};
};


class DELPHICLASS TListBoxItemCollection;
class PASCALIMPLEMENTATION TListBoxItemCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TListBoxItem* operator[](int Index) { return Items[Index]; }
	
private:
	TColumnListBox* FOwner;
	HIDESBASE TListBoxItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TListBoxItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TListBoxItem* __fastcall Add(void);
	HIDESBASE TListBoxItem* __fastcall Insert(int index);
	__property TListBoxItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TListBoxItemCollection(TColumnListBox* aOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	Types::TPoint __fastcall IndexOf(System::UnicodeString s);
	int __fastcall IndexInColumnOf(int col, System::UnicodeString s);
	int __fastcall IndexInRowOf(int row, System::UnicodeString s);
	void __fastcall SaveToFile(System::UnicodeString FileName, bool Unicode = true);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TListBoxItemCollection(void) { }
	
};


class PASCALIMPLEMENTATION TColumnListBox : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	Controls::TImageList* FImages;
	TListBoxColumnCollection* FColumns;
	TListBoxItemCollection* FListBoxItems;
	bool FGridLines;
	int FItemIndex;
	int FUpdateCount;
	int FSortColumn;
	bool FSortedEx;
	bool FLookupIncr;
	int FLookupColumn;
	System::UnicodeString FLookup;
	bool FShowItemHint;
	int FLastHintIdx;
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetItemIndexP(const int Value);
	int __fastcall GetItemIndexP(void);
	void __fastcall SetGridLines(const bool Value);
	void __fastcall BuildItems(void);
	System::UnicodeString __fastcall GetColumnItems(int i, int j);
	void __fastcall SetColumnItems(int i, int j, const System::UnicodeString Value);
	bool __fastcall GetSortedEx(void);
	void __fastcall SetSortedEx(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	System::WideChar __fastcall GetDelimiter(void);
	void __fastcall SetDelimiter(const System::WideChar Value);
	void __fastcall QuickSortList(Classes::TStringList* List, int left, int right);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	virtual int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property Items;
	DYNAMIC void __fastcall DoEnter(void);
	
public:
	__fastcall virtual TColumnListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TColumnListBox(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DeleteSelected(void);
	void __fastcall TestFill(void);
	__property Text;
	void __fastcall Sort(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property System::UnicodeString ColumnItems[int i][int j] = {read=GetColumnItems, write=SetColumnItems};
	__property System::WideChar Delimiter = {read=GetDelimiter, write=SetDelimiter, nodefault};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Cursor = {default=0};
	__property Ctl3D;
	__property TListBoxColumnCollection* Columns = {read=FColumns, write=FColumns};
	__property TListBoxItemCollection* ListBoxItems = {read=FListBoxItems, write=FListBoxItems};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ExtendedSelect = {default=1};
	__property Font;
	__property bool GridLines = {read=FGridLines, write=SetGridLines, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property IntegralHeight = {default=0};
	__property ItemHeight = {default=16};
	__property int ItemIndex = {read=GetItemIndexP, write=SetItemIndexP, nodefault};
	__property bool LookupIncr = {read=FLookupIncr, write=FLookupIncr, nodefault};
	__property int LookupColumn = {read=FLookupColumn, write=FLookupColumn, nodefault};
	__property MultiSelect = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property bool ShowItemHint = {read=FShowItemHint, write=FShowItemHint, nodefault};
	__property int SortColumn = {read=FSortColumn, write=FSortColumn, nodefault};
	__property bool Sorted = {read=GetSortedEx, write=SetSortedEx, nodefault};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TColumnListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Collistb */
using namespace Collistb;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CollistbHPP
