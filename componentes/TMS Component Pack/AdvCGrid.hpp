// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcgrid.pas' rev: 21.00

#ifndef AdvcgridHPP
#define AdvcgridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcgrid
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TColumnPopupEvent)(System::TObject* Sender, int ACol, int ARow, Menus::TPopupMenu* PopupMenu);

typedef void __fastcall (__closure *TAfterColumnMoved)(System::TObject* Sender, int FromIndex, int ToIndex);

#pragma option push -b-
enum TColumnPopupType { cpFixedCellsRClick, cpFixedCellsLClick, cpNormalCellsRClick, cpNormalCellsLClick, cpAllCellsRClick, cpAllCellsLClick };
#pragma option pop

class DELPHICLASS TGridColumnItem;
class PASCALIMPLEMENTATION TGridColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FWidth;
	Classes::TAlignment FAlignment;
	System::UnicodeString FColumnHeader;
	Advobj::TSortStyle FSortStyle;
	System::UnicodeString FSortPrefix;
	System::UnicodeString FSortSuffix;
	System::UnicodeString FEditMask;
	int FEditLength;
	Advgrid::TEditLink* FEditLink;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	Advobj::TEditorType FEditorType;
	bool FFixed;
	bool FReadOnly;
	Classes::TStringList* FComboItems;
	int FDropDownCount;
	int FSpinMin;
	int FSpinMax;
	int FSpinStep;
	bool FPassword;
	Graphics::TFont* FPrintFont;
	Graphics::TColor FPrintColor;
	Advobj::TCellBorders FBorders;
	Graphics::TPen* FBorderPen;
	Advobj::TCellBorders FPrintBorders;
	Graphics::TPen* FPrintBorderPen;
	int FTag;
	int FDefIdx;
	System::UnicodeString FName;
	System::UnicodeString FCheckFalse;
	System::UnicodeString FCheckTrue;
	bool FShowBands;
	Classes::TStringList* FFilter;
	int FMaxSize;
	int FMinSize;
	int FAutoMinSize;
	int FAutoMaxSize;
	TColumnPopupType FColumnPopupType;
	Menus::TPopupMenu* FColumnPopup;
	bool FFilterCaseSensitive;
	System::UnicodeString FFloatFormat;
	Classes::TAlignment FHeaderAlignment;
	Graphics::TFont* FHeaderFont;
	bool FPrintBorderCustom;
	bool FPrintFontCustom;
	void __fastcall SetWidth(const int Value);
	int __fastcall GetWidth(void);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetColumnHeader(const System::UnicodeString Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFixed(const bool Value);
	void __fastcall SetPassword(const bool Value);
	void __fastcall SetComboItems(const Classes::TStringList* Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall PenChanged(System::TObject* Sender);
	void __fastcall SetBorders(const Advobj::TCellBorders Value);
	void __fastcall SetBorderPen(const Graphics::TPen* Value);
	System::UnicodeString __fastcall GetRows(int idx);
	void __fastcall SetRows(int idx, const System::UnicodeString Value);
	System::TDateTime __fastcall GetDates(int idx);
	double __fastcall GetFloats(int idx);
	int __fastcall GetInts(int idx);
	void __fastcall SetDates(int idx, const System::TDateTime Value);
	void __fastcall SetFloats(int idx, const double Value);
	void __fastcall SetInts(int idx, const int Value);
	System::TDateTime __fastcall GetTimes(int idx);
	void __fastcall SetTimes(int idx, const System::TDateTime Value);
	void __fastcall SetEditorType(const Advobj::TEditorType Value);
	void __fastcall SetShowBands(const bool Value);
	void __fastcall SetFilter(const Classes::TStringList* Value);
	void __fastcall FilterChanged(System::TObject* Sender);
	void __fastcall SetFloatFormat(const System::UnicodeString Value);
	void __fastcall SetHeaderAlignment(const Classes::TAlignment Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	void __fastcall SetPrintFont(const Graphics::TFont* Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TGridColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TGridColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignVisuals(Classes::TPersistent* Source);
	__property int DefIdx = {read=FDefIdx, write=FDefIdx, nodefault};
	__property System::UnicodeString Rows[int idx] = {read=GetRows, write=SetRows};
	__property int Ints[int idx] = {read=GetInts, write=SetInts};
	__property double Floats[int idx] = {read=GetFloats, write=SetFloats};
	__property System::TDateTime Dates[int idx] = {read=GetDates, write=SetDates};
	__property System::TDateTime Times[int idx] = {read=GetTimes, write=SetTimes};
	
__published:
	__property int AutoMinSize = {read=FAutoMinSize, write=FAutoMinSize, nodefault};
	__property int AutoMaxSize = {read=FAutoMaxSize, write=FAutoMaxSize, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Advobj::TCellBorders Borders = {read=FBorders, write=SetBorders, nodefault};
	__property Graphics::TPen* BorderPen = {read=FBorderPen, write=SetBorderPen};
	__property System::UnicodeString CheckFalse = {read=FCheckFalse, write=FCheckFalse};
	__property System::UnicodeString CheckTrue = {read=FCheckTrue, write=FCheckTrue};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Menus::TPopupMenu* ColumnPopup = {read=FColumnPopup, write=FColumnPopup};
	__property TColumnPopupType ColumnPopupType = {read=FColumnPopupType, write=FColumnPopupType, nodefault};
	__property Classes::TStringList* ComboItems = {read=FComboItems, write=SetComboItems};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, nodefault};
	__property int EditLength = {read=FEditLength, write=FEditLength, nodefault};
	__property Advgrid::TEditLink* EditLink = {read=FEditLink, write=FEditLink};
	__property System::UnicodeString EditMask = {read=FEditMask, write=FEditMask};
	__property Advobj::TEditorType Editor = {read=FEditorType, write=SetEditorType, nodefault};
	__property Classes::TStringList* Filter = {read=FFilter, write=SetFilter};
	__property bool FilterCaseSensitive = {read=FFilterCaseSensitive, write=FFilterCaseSensitive, nodefault};
	__property bool Fixed = {read=FFixed, write=SetFixed, nodefault};
	__property System::UnicodeString FloatFormat = {read=FFloatFormat, write=SetFloatFormat};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Header = {read=FColumnHeader, write=SetColumnHeader};
	__property Classes::TAlignment HeaderAlignment = {read=FHeaderAlignment, write=SetHeaderAlignment, nodefault};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property int MinSize = {read=FMinSize, write=FMinSize, nodefault};
	__property int MaxSize = {read=FMaxSize, write=FMaxSize, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property bool Password = {read=FPassword, write=SetPassword, nodefault};
	__property bool PrintBorderCustom = {read=FPrintBorderCustom, write=FPrintBorderCustom, default=1};
	__property Advobj::TCellBorders PrintBorders = {read=FPrintBorders, write=FPrintBorders, nodefault};
	__property Graphics::TPen* PrintBorderPen = {read=FPrintBorderPen, write=FPrintBorderPen};
	__property Graphics::TColor PrintColor = {read=FPrintColor, write=FPrintColor, nodefault};
	__property bool PrintFontCustom = {read=FPrintFontCustom, write=FPrintFontCustom, default=1};
	__property Graphics::TFont* PrintFont = {read=FPrintFont, write=SetPrintFont};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, nodefault};
	__property bool ShowBands = {read=FShowBands, write=SetShowBands, nodefault};
	__property Advobj::TSortStyle SortStyle = {read=FSortStyle, write=FSortStyle, nodefault};
	__property System::UnicodeString SortPrefix = {read=FSortPrefix, write=FSortPrefix};
	__property System::UnicodeString SortSuffix = {read=FSortSuffix, write=FSortSuffix};
	__property int SpinMax = {read=FSpinMax, write=FSpinMax, nodefault};
	__property int SpinMin = {read=FSpinMin, write=FSpinMin, nodefault};
	__property int SpinStep = {read=FSpinStep, write=FSpinStep, nodefault};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
};


class DELPHICLASS TGridColumnCollection;
class DELPHICLASS TAdvColumnGrid;
class PASCALIMPLEMENTATION TGridColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TGridColumnItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvColumnGrid* FOwner;
	bool FNoRecursiveUpdate;
	HIDESBASE TGridColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TGridColumnItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	HIDESBASE TGridColumnItem* __fastcall Add(void);
	HIDESBASE TGridColumnItem* __fastcall Insert(int index);
	__property TGridColumnItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__fastcall TGridColumnCollection(TAdvColumnGrid* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall SetOrganization(void);
	void __fastcall ResetOrganization(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGridColumnCollection(void) { }
	
};


class PASCALIMPLEMENTATION TAdvColumnGrid : public Advgrid::TAdvStringGrid
{
	typedef Advgrid::TAdvStringGrid inherited;
	
private:
	TGridColumnCollection* FColumnCollection;
	TGridColumnItem* FSaveCol;
	bool FColMoving;
	Advgrid::TCellGraphic* FCellGraphic;
	bool FAutoFilterDisplay;
	TColumnPopupEvent FOnColumnPopup;
	TAfterColumnMoved FOnAfterColumnMoved;
	void __fastcall SetColumnCollection(const TGridColumnCollection* Value);
	TGridColumnCollection* __fastcall GetColumnCollection(void);
	int __fastcall GetColCount(void);
	HIDESBASE void __fastcall SetColCount(const int Value);
	void __fastcall SynchHeaders(void);
	void __fastcall SynchColumns(void);
	TGridColumnItem* __fastcall GetColumnByName(System::UnicodeString AValue);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	DYNAMIC void __fastcall ColWidthsChanged(void);
	virtual void __fastcall CellsLoaded(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall FilterSelect(System::TObject* Sender, int ItemIndex);
	virtual bool __fastcall GetFilter(int ACol);
	virtual void __fastcall UpdateColSize(int ACol, int &NewWidth);
	virtual void __fastcall UpdateAutoColSize(int ACol, int &NewWidth);
	virtual void __fastcall UpdateColHeaders(void);
	DYNAMIC System::UnicodeString __fastcall GetEditMask(int ACol, int ARow);
	DYNAMIC int __fastcall GetEditLimit(void);
	virtual Advgrid::TCellType __fastcall GetCellType(int ACol, int ARow);
	virtual Advgrid::TCellGraphic* __fastcall GetCellGraphic(int ACol, int ARow);
	virtual void __fastcall GetCellColor(int ACol, int ARow, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);
	virtual void __fastcall GetCellPrintColor(int ACol, int ARow, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);
	virtual void __fastcall GetCellBorder(int ACol, int ARow, Graphics::TPen* APen, Advobj::TCellBorders &borders);
	virtual void __fastcall GetCellPrintBorder(int ACol, int ARow, Graphics::TPen* APen, Advobj::TCellBorders &borders);
	virtual void __fastcall GetCellAlign(int ACol, int ARow, Classes::TAlignment &HAlign, Advobj::TVAlignment &VAlign);
	virtual void __fastcall GetColFormat(int ACol, Advobj::TSortStyle &ASortStyle, System::UnicodeString &aPrefix, System::UnicodeString &aSuffix);
	virtual void __fastcall GetCellEditor(int ACol, int ARow, Advobj::TEditorType &AEditor);
	virtual bool __fastcall HasCombo(int ACol, int ARow);
	virtual void __fastcall GetCellFixed(int ACol, int ARow, bool &IsFixed);
	virtual void __fastcall GetCellReadOnly(int ACol, int ARow, bool &IsReadOnly);
	virtual void __fastcall GetCellPassword(int ACol, int ARow, bool &IsPassword);
	virtual System::UnicodeString __fastcall GetFormattedCell(int ACol, int ARow);
	virtual System::UnicodeString __fastcall GetCheckTrue(int ACol, int ARow);
	virtual System::UnicodeString __fastcall GetCheckFalse(int ACol, int ARow);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual TGridColumnCollection* __fastcall CreateColumns(void);
	virtual void __fastcall GetDefaultProps(int ACol, int ARow, Graphics::TFont* AFont, Graphics::TBrush* ABrush, Graphics::TColor &AColorTo, Graphics::TColor &AMirrorColor, Graphics::TColor &AMirrorColorTo, Classes::TAlignment &HA, Advobj::TVAlignment &VA, bool &WW, Advobj::TCellGradientDirection &GD);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	
public:
	__fastcall virtual TAdvColumnGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvColumnGrid(void);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	void __fastcall SaveColumnsToStream(Classes::TStream* st);
	void __fastcall LoadColumnsFromStream(Classes::TStream* st);
	__property TGridColumnItem* ColumnByName[System::UnicodeString AValue] = {read=GetColumnByName};
	void __fastcall SaveColumnPositions(System::UnicodeString Key, System::UnicodeString Section);
	void __fastcall LoadColumnPositions(System::UnicodeString Key, System::UnicodeString Section);
	virtual void __fastcall SaveColPositions(void);
	virtual void __fastcall LoadColPositions(void);
	virtual void __fastcall RemoveCols(int ColIndex, int CCount);
	virtual void __fastcall InsertCols(int ColIndex, int CCount);
	virtual void __fastcall Group(int Colindex);
	virtual void __fastcall UnGroup(void);
	
__published:
	__property bool AutoFilterDisplay = {read=FAutoFilterDisplay, write=FAutoFilterDisplay, default=0};
	__property TGridColumnCollection* Columns = {read=GetColumnCollection, write=SetColumnCollection};
	__property int ColCount = {read=GetColCount, write=SetColCount, nodefault};
	__property TAfterColumnMoved OnAfterColumnMoved = {read=FOnAfterColumnMoved, write=FOnAfterColumnMoved};
	__property TColumnPopupEvent OnColumnPopup = {read=FOnColumnPopup, write=FOnColumnPopup};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvColumnGrid(HWND ParentWindow) : Advgrid::TAdvStringGrid(ParentWindow) { }
	
};


class DELPHICLASS TAdvColumnGridIO;
class PASCALIMPLEMENTATION TAdvColumnGridIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TGridColumnCollection* FItems;
	
public:
	__fastcall virtual TAdvColumnGridIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvColumnGridIO(void);
	
__published:
	__property TGridColumnCollection* Items = {read=FItems, write=FItems};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x3;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x1;
#define DATE_VER L"Jun, 2010"

}	/* namespace Advcgrid */
using namespace Advcgrid;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcgridHPP
