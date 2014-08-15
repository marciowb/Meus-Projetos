// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advgridworkbook.pas' rev: 21.00

#ifndef AdvgridworkbookHPP
#define AdvgridworkbookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Tabs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advgridworkbook
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TSheetChangeEvent)(System::TObject* Sender, int NewSheet, bool &AllowChange);

class DELPHICLASS TTabLook;
class PASCALIMPLEMENTATION TTabLook : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FDitherBackground;
	Graphics::TColor FSelectColor;
	Graphics::TColor FUnSelectColor;
	Graphics::TColor FBackgroundColor;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetDitherBackground(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSelectColor(const Graphics::TColor Value);
	void __fastcall SetUnSelectColor(const Graphics::TColor Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	
public:
	__fastcall TTabLook(void);
	__fastcall virtual ~TTabLook(void);
	
__published:
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, default=-16777201};
	__property Graphics::TColor UnSelectColor = {read=FUnSelectColor, write=SetUnSelectColor, default=16777215};
	__property bool DitherBackground = {read=FDitherBackground, write=SetDitherBackground, default=1};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=-16777201};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TGridSheet;
class PASCALIMPLEMENTATION TGridSheet : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TMemoryStream* FData;
	int FTag;
	System::UnicodeString FName;
	int FCol;
	int FRow;
	int FLeftCol;
	int FTopRow;
	Advobj::TIntList* FColWidths;
	Advobj::TIntList* FRowHeights;
	int FSortColumn;
	void __fastcall SetName(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	
public:
	__fastcall virtual TGridSheet(Classes::TCollection* Collection);
	__fastcall virtual ~TGridSheet(void);
	__property Classes::TMemoryStream* Data = {read=FData};
	__property int Col = {read=FCol, write=FCol, nodefault};
	__property int Row = {read=FRow, write=FRow, nodefault};
	__property int TopRow = {read=FTopRow, write=FTopRow, nodefault};
	__property int LeftCol = {read=FLeftCol, write=FLeftCol, nodefault};
	__property Advobj::TIntList* ColWidths = {read=FColWidths};
	__property Advobj::TIntList* RowHeights = {read=FRowHeights};
	__property int SortColumn = {read=FSortColumn, write=FSortColumn, nodefault};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TGridSheetCollection;
class DELPHICLASS TAdvGridWorkbook;
class PASCALIMPLEMENTATION TGridSheetCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TGridSheet* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvGridWorkbook* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TGridSheet* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TGridSheet* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TGridSheetCollection(TAdvGridWorkbook* AOwner);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TGridSheet* __fastcall Add(void);
	HIDESBASE TGridSheet* __fastcall Insert(int Index);
	__property TGridSheet* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGridSheetCollection(void) { }
	
};


class PASCALIMPLEMENTATION TAdvGridWorkbook : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Tabs::TTabSet* FTabSet;
	Advgrid::TAdvStringGrid* FGrid;
	int FActiveSheet;
	bool FAutoCreated;
	bool FWinCreated;
	TGridSheetCollection* FSheets;
	int FDefaultColCount;
	int FDefaultRowCount;
	int FDefaultRowHeight;
	int FDefaultColWidth;
	TSheetChangeEvent FOnSheetChange;
	TTabLook* FTabLook;
	void __fastcall NCPaintProc(void);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	void __fastcall TabChange(System::TObject* Sender, int NewTab, bool &AllowChange);
	void __fastcall SheetChange(System::TObject* Sender);
	void __fastcall TabLookChange(System::TObject* Sender);
	TGridSheetCollection* __fastcall GetSheets(void);
	void __fastcall SetSheets(const TGridSheetCollection* Value);
	void __fastcall SetActiveSheet(const int Value);
	void __fastcall StoreActiveSheet(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TAdvGridWorkbook(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__fastcall virtual ~TAdvGridWorkbook(void);
	virtual void __fastcall CreateWnd(void);
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid};
	void __fastcall RemoveSheet(int Index);
	void __fastcall InsertSheet(int Index, System::UnicodeString SheetName);
	void __fastcall AddSheet(System::UnicodeString SheetName);
	
__published:
	__property int ActiveSheet = {read=FActiveSheet, write=SetActiveSheet, nodefault};
	__property TGridSheetCollection* Sheets = {read=GetSheets, write=SetSheets};
	__property TTabLook* TabLook = {read=FTabLook, write=FTabLook};
	__property TSheetChangeEvent OnSheetChange = {read=FOnSheetChange, write=FOnSheetChange};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGridWorkbook(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x3;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;
#define DATE_VER L"Apr, 2006"

}	/* namespace Advgridworkbook */
using namespace Advgridworkbook;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvgridworkbookHPP
