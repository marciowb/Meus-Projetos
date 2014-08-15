// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advgridcsvpager.pas' rev: 21.00

#ifndef AdvgridcsvpagerHPP
#define AdvgridcsvpagerHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Advutil.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advgridcsvpager
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TLocalAdvGrid;
class PASCALIMPLEMENTATION TLocalAdvGrid : public Advgrid::TAdvStringGrid
{
	typedef Advgrid::TAdvStringGrid inherited;
	
public:
	/* TAdvStringGrid.Create */ inline __fastcall virtual TLocalAdvGrid(Classes::TComponent* AOwner) : Advgrid::TAdvStringGrid(AOwner) { }
	/* TAdvStringGrid.Destroy */ inline __fastcall virtual ~TLocalAdvGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLocalAdvGrid(HWND ParentWindow) : Advgrid::TAdvStringGrid(ParentWindow) { }
	
};


class DELPHICLASS TAdvGridCSVPager;
class PASCALIMPLEMENTATION TAdvGridCSVPager : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	int FPageSize;
	System::UnicodeString FFileName;
	Advgrid::TAdvStringGrid* FGrid;
	bool FOpened;
	int FPage;
	int FPageCount;
	System::TextFile FFile;
	System::WideChar FOldDelimiter;
	int FTotalRows;
	bool FAutoNumber;
	int __fastcall GetPage(void);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetGrid(const Advgrid::TAdvStringGrid* Value);
	void __fastcall SetPage(const int Value);
	void __fastcall SetPageSize(const int Value);
	int __fastcall JumpPages(int I);
	int __fastcall GetFirstRow(void);
	int __fastcall GetLastRow(void);
	void __fastcall SetAutoNumber(const bool Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall LoadPage(void);
	void __fastcall GoToPage(int PageNo);
	void __fastcall MoveBy(int I);
	
public:
	__fastcall virtual TAdvGridCSVPager(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridCSVPager(void);
	void __fastcall First(void);
	void __fastcall Last(void);
	void __fastcall Next(void);
	void __fastcall Prev(void);
	void __fastcall Reload(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	void __fastcall SavePage(void);
	bool __fastcall BOF(void);
	bool __fastcall EOF(void);
	int __fastcall Pages(void);
	__property int Page = {read=GetPage, write=SetPage, nodefault};
	__property bool IsOpen = {read=FOpened, write=FOpened, nodefault};
	__property int FirstRow = {read=GetFirstRow, nodefault};
	__property int LastRow = {read=GetLastRow, nodefault};
	__property int TotalRows = {read=FTotalRows, nodefault};
	
__published:
	__property bool AutoNumber = {read=FAutoNumber, write=SetAutoNumber, nodefault};
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
	__property int PageSize = {read=FPageSize, write=SetPageSize, default=15};
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=SetGrid};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advgridcsvpager */
using namespace Advgridcsvpager;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvgridcsvpagerHPP
