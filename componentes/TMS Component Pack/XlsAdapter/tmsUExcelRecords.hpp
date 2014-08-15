// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuexcelrecords.pas' rev: 21.00

#ifndef TmsuexcelrecordsHPP
#define TmsuexcelrecordsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsotherrecords.hpp>	// Pascal unit
#include <Tmsuxlssst.hpp>	// Pascal unit
#include <Tmsuxlsreferences.hpp>	// Pascal unit
#include <Tmsusheetnamelist.hpp>	// Pascal unit
#include <Tmsuxlsformula.hpp>	// Pascal unit
#include <Tmsuxlsescher.hpp>	// Pascal unit
#include <Tmsuxlsclientdata.hpp>	// Pascal unit
#include <Tmsuxlssheet.hpp>	// Pascal unit
#include <Tmsuxlsworkbookglobals.hpp>	// Pascal unit
#include <Tmsuxlsbaselist.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuexcelrecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSheetList;
class PASCALIMPLEMENTATION TSheetList : public Tmsuxlsbaselist::TBaseList
{
	typedef Tmsuxlsbaselist::TBaseList inherited;
	
public:
	Tmsuxlssheet::TSheet* operator[](int index) { return Items[index]; }
	
private:
	Tmsuxlssheet::TSheet* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Tmsuxlssheet::TSheet* Value);
	
public:
	__property Tmsuxlssheet::TSheet* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Tmsuxlssheet::TSheet* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Tmsuxlssheet::TSheet* aRecord);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteSheets(const int SheetIndex, const int SheetCount);
public:
	/* TObjectList.Create */ inline __fastcall TSheetList(void)/* overload */ : Tmsuxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSheetList(void) { }
	
};


class DELPHICLASS TWorkbook;
class PASCALIMPLEMENTATION TWorkbook : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Tmsuxlsworkbookglobals::TWorkbookGlobals* FGlobals;
	TSheetList* FSheets;
	void __fastcall FixBoundSheetsOffset(const bool NeedsRecalc);
	void __fastcall FixRows(void);
	Tmsuxlssheet::TWorkSheet* __fastcall GetWorkSheets(int index);
	int __fastcall GetActiveSheet(void);
	void __fastcall SetActiveSheet(const int Value);
	void __fastcall FixRangeBoundSheetsOffset(const int SheetIndex, const Tmsuflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	void __fastcall FixCodeNames(void);
	bool __fastcall GetIsXltTemplate(void);
	void __fastcall SetIsXltTemplate(const bool Value);
	
public:
	__property Tmsuxlsworkbookglobals::TWorkbookGlobals* Globals = {read=FGlobals, write=FGlobals};
	__property TSheetList* Sheets = {read=FSheets, write=FSheets};
	bool __fastcall IsWorksheet(const int Index);
	__property Tmsuxlssheet::TWorkSheet* WorkSheets[int index] = {read=GetWorkSheets};
	__property bool IsXltTemplate = {read=GetIsXltTemplate, write=SetIsXltTemplate, nodefault};
	__property int ActiveSheet = {read=GetActiveSheet, write=SetActiveSheet, nodefault};
	__fastcall TWorkbook(void);
	__fastcall virtual ~TWorkbook(void);
	void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream, const bool NeedsRecalc);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const int SheetIndex, const Tmsuflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	void __fastcall InsertAndCopyRowsAndCols(const int SheetNo, const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const bool OnlyFormulas);
	void __fastcall DeleteRowsAndCols(const int SheetNo, const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount);
	void __fastcall InsertSheets(const int CopyFrom, const int InsertBefore, int SheetCount);
	void __fastcall DeleteSheets(const int SheetPos, const int SheetCount);
	void __fastcall InsertHPageBreak(const int SheetNo, const System::Word aRow);
	void __fastcall InsertVPageBreak(const int SheetNo, const System::Word aCol);
	void __fastcall RestoreObjectCoords(int dSheet);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuexcelrecords */
using namespace Tmsuexcelrecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuexcelrecordsHPP
