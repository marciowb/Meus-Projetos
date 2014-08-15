// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmulticolumndropdown.pas' rev: 21.00

#ifndef AdvmulticolumndropdownHPP
#define AdvmulticolumndropdownHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Advutil.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmulticolumndropdown
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TColumnType { ctText, ctImage };
#pragma option pop

typedef void __fastcall (__closure *TGetCellTextEvent)(System::TObject* Sender, int Column, int Row, System::UnicodeString &Text);

typedef void __fastcall (__closure *TDrawCellEvent)(System::TObject* Sender, int Column, int Row, Graphics::TCanvas* ACanvas, const Types::TRect &ARect);

typedef void __fastcall (__closure *TGetCellPropEvent)(System::TObject* Sender, int Column, int Row, Graphics::TFont* Font, Graphics::TColor &AColor, Graphics::TColor &AColorTo);

class DELPHICLASS TDropDownColumn;
class PASCALIMPLEMENTATION TDropDownColumn : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FWordwrap;
	int FWidth;
	bool FAutoSize;
	System::UnicodeString FHeader;
	Classes::TAlignment FAlignment;
	Graphics::TColor FColor;
	TColumnType FColumnType;
	Graphics::TFont* FFont;
	bool FEllipsis;
	void __fastcall SetFont(const Graphics::TFont* Value);
	
public:
	__fastcall virtual TDropDownColumn(Classes::TCollection* Collection);
	__fastcall virtual ~TDropDownColumn(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Width = {read=FWidth, write=FWidth, default=80};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=16777215};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=FEllipsis, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TColumnType ColumnType = {read=FColumnType, write=FColumnType, default=0};
	__property System::UnicodeString Header = {read=FHeader, write=FHeader};
	__property bool Wordwrap = {read=FWordwrap, write=FWordwrap, default=0};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=0};
};


class DELPHICLASS TDropDownColumns;
class PASCALIMPLEMENTATION TDropDownColumns : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TDropDownColumn* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TDropDownColumn* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDropDownColumn* Value);
	
public:
	__fastcall TDropDownColumns(Classes::TPersistent* AOwner);
	__property TDropDownColumn* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TDropDownColumn* __fastcall Add(void);
	HIDESBASE TDropDownColumn* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDropDownColumns(void) { }
	
};


class DELPHICLASS TDropDownItem;
class PASCALIMPLEMENTATION TDropDownItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	Classes::TStringList* FText;
	void __fastcall SetText(const Classes::TStringList* Value);
	
public:
	__fastcall virtual TDropDownItem(Classes::TCollection* Collection);
	__fastcall virtual ~TDropDownItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property Classes::TStringList* Text = {read=FText, write=SetText};
};


class DELPHICLASS TDropDownItems;
class PASCALIMPLEMENTATION TDropDownItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TDropDownItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TDropDownItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDropDownItem* Value);
	
public:
	__fastcall TDropDownItems(Classes::TPersistent* AOwner);
	__property TDropDownItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TDropDownItem* __fastcall Add(void);
	HIDESBASE TDropDownItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDropDownItems(void) { }
	
};


class DELPHICLASS TAdvColGrid;
class DELPHICLASS TAdvMultiColumnDropDown;
class PASCALIMPLEMENTATION TAdvColGrid : public Grids::TStringGrid
{
	typedef Grids::TStringGrid inherited;
	
private:
	TAdvMultiColumnDropDown* FAdvDropDown;
	TDropDownColumns* FColumns;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FHeaderColorTo;
	Graphics::TColor FLineColor;
	Imglist::TCustomImageList* FImages;
	TDrawCellEvent FOnDrawCell;
	TGetCellPropEvent FOnGetCellProp;
	TGetCellTextEvent FOnGetCellText;
	int FHeaderHeight;
	Graphics::TFont* FHeaderFont;
	Graphics::TColor FFixedLineColor;
	int FGridLineWidth;
	Classes::TNotifyEvent FOnSelect;
	int FOldRow;
	bool FMouseWheelSelection;
	bool FConfirmSelection;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	void __fastcall SetHeaderColor(const Graphics::TColor Value);
	void __fastcall SetHeaderColorTo(const Graphics::TColor Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetColumns(const TDropDownColumns* Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	void __fastcall SetHeaderHeight(const int Value);
	void __fastcall SetAdvDropDown(const TAdvMultiColumnDropDown* Value);
	HIDESBASE Types::TRect __fastcall CellRect(int c, int r);
	HIDESBASE void __fastcall SetGridLineWidth(const int Value);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SelectionChanged(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	void __fastcall AutoSizeColumn(int ACol);
	void __fastcall AutoSizeColumns(void);
	void __fastcall DoWordWrap(void);
	HIDESBASE void __fastcall Initialize(TAdvMultiColumnDropDown* DropDown);
	int __fastcall GetDesiredWidth(void);
	__property TAdvMultiColumnDropDown* AdvDropDown = {read=FAdvDropDown, write=SetAdvDropDown};
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TAdvColGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvColGrid(void);
	
__published:
	__property TDropDownColumns* Columns = {read=FColumns, write=SetColumns};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=8421504};
	__property Graphics::TColor FixedLineColor = {read=FFixedLineColor, write=FFixedLineColor, nodefault};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, nodefault};
	__property Graphics::TColor HeaderColorTo = {read=FHeaderColorTo, write=SetHeaderColorTo, nodefault};
	__property int HeaderHeight = {read=FHeaderHeight, write=SetHeaderHeight, nodefault};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property int GridLineWidth = {read=FGridLineWidth, write=SetGridLineWidth, default=1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TGetCellTextEvent OnGetCellText = {read=FOnGetCellText, write=FOnGetCellText};
	__property TDrawCellEvent OnDrawCell = {read=FOnDrawCell, write=FOnDrawCell};
	__property TGetCellPropEvent OnGetCellProp = {read=FOnGetCellProp, write=FOnGetCellProp};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvColGrid(HWND ParentWindow) : Grids::TStringGrid(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvMultiColumnDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	bool FShowing;
	bool FColumnSizing;
	int FLookupColumn;
	Graphics::TColor FHeaderColorTo;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FLineColor;
	TDropDownItems* FItems;
	TDropDownColumns* FColumns;
	int FItemIndex;
	int FHeaderHeight;
	Graphics::TFont* FHeaderFont;
	TAdvColGrid* FAdvColGrid;
	Graphics::TColor FFixedLineColor;
	bool workmode;
	System::UnicodeString FLookupStr;
	System::UnicodeString FOldValue;
	bool FReturnIsTab;
	Classes::TStringList* FLookupItems;
	bool FMatchCase;
	bool FMatchStart;
	bool FItemChange;
	int FItemIdx;
	int FItemSel;
	Classes::TNotifyEvent FOnSelect;
	TDrawCellEvent FOnDropDownDrawItem;
	TGetCellPropEvent FOnDropDownGetItemProp;
	TGetCellTextEvent FOnDropDownGetItemText;
	int FOldItemIndex;
	bool FDropDownAutoWidth;
	bool FColumnSizeWithDropDown;
	Graphics::TColor FSelectionTextColor;
	int FDropDownRowHeight;
	System::UnicodeString FLookupEntry;
	bool FCaseSensitive;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall OnColGridSelectCell(System::TObject* Sender, int ACol, int ARow, bool &CanSelect);
	void __fastcall OnColGridSelect(System::TObject* Sender);
	void __fastcall OnColGridKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	int __fastcall GetRowCount(void);
	void __fastcall SetLookupColumn(const int Value);
	void __fastcall SetItems(const TDropDownItems* Value);
	void __fastcall SetColumns(const TDropDownColumns* Value);
	System::UnicodeString __fastcall GetTextEx(void);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetTextEx(const System::UnicodeString Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	void __fastcall SetHeaderHeight(const int Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall UpdateLookupList(void);
	void __fastcall SyncColWidths(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	virtual void __fastcall DoShowDropDown(void);
	virtual void __fastcall SetSelectionColorStyle(const Advdropdown::TSelectionColorStyle Value);
	virtual void __fastcall SetCenterControl(void);
	virtual void __fastcall OnDropDownControlKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyPress(System::WideChar &Key);
	virtual void __fastcall OnDropDownSizing(void);
	virtual void __fastcall HandleMouseWheelDown(void);
	virtual void __fastcall HandleMouseWheelUp(void);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall SelectPrevious(void);
	void __fastcall SelectNextPage(void);
	void __fastcall SelectPrevPage(void);
	bool __fastcall LookupInColumn(System::UnicodeString value, System::UnicodeString &lookup, int &row);
	int __fastcall DoKeyLookup(System::WideChar ch);
	
public:
	__fastcall virtual TAdvMultiColumnDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMultiColumnDropDown(void);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property int RowCount = {read=GetRowCount, nodefault};
	__property System::UnicodeString Text = {read=GetTextEx, write=SetTextEx};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property bool MatchCase = {read=FMatchCase, write=FMatchCase, default=0};
	__property bool MatchStart = {read=FMatchStart, write=FMatchStart, default=1};
	int __fastcall GetItemIndex(System::UnicodeString value);
	
__published:
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, default=0};
	__property bool DropDownAutoWidth = {read=FDropDownAutoWidth, write=FDropDownAutoWidth, default=1};
	__property int DropDownRowHeight = {read=FDropDownRowHeight, write=FDropDownRowHeight, default=22};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=8421504};
	__property Graphics::TColor FixedLineColor = {read=FFixedLineColor, write=FFixedLineColor, nodefault};
	__property bool ColumnSizing = {read=FColumnSizing, write=FColumnSizing, default=0};
	__property bool ColumnSizeWithDropDown = {read=FColumnSizeWithDropDown, write=FColumnSizeWithDropDown, default=1};
	__property TDropDownColumns* Columns = {read=FColumns, write=SetColumns};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=FHeaderColor, nodefault};
	__property Graphics::TColor HeaderColorTo = {read=FHeaderColorTo, write=FHeaderColorTo, nodefault};
	__property int HeaderHeight = {read=FHeaderHeight, write=SetHeaderHeight, nodefault};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property int LookupColumn = {read=FLookupColumn, write=SetLookupColumn, default=0};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=FSelectionTextColor, default=0};
	__property TDropDownItems* Items = {read=FItems, write=SetItems};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, nodefault};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownColor = {default=16777215};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownSizeable = {default=1};
	__property EditorEnabled = {default=1};
	__property Enabled = {default=1};
	__property Font;
	__property DropDownButtonGlyph;
	__property Images;
	__property Version;
	__property ReadOnly = {default=0};
	__property SelectionColor;
	__property SelectionColorTo;
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property OnEnter;
	__property OnExit;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnBeforeDropDown;
	__property OnDropDown;
	__property OnDropUp;
	__property OnDropDownHeaderButtonClick;
	__property OnDropDownFooterButtonClick;
	__property OnDrawHeader;
	__property OnDrawFooter;
	__property OnGetHeaderText;
	__property OnGetFooterText;
	__property TGetCellTextEvent OnDropDownGetItemText = {read=FOnDropDownGetItemText, write=FOnDropDownGetItemText};
	__property TDrawCellEvent OnDropDownDrawItem = {read=FOnDropDownDrawItem, write=FOnDropDownDrawItem};
	__property TGetCellPropEvent OnDropDownGetItemProp = {read=FOnDropDownGetItemProp, write=FOnDropDownGetItemProp};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMultiColumnDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advmulticolumndropdown */
using namespace Advmulticolumndropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmulticolumndropdownHPP
