// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UExcelRecords.pas' rev: 22.00

#ifndef UexcelrecordsHPP
#define UexcelrecordsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <UXlsBaseRecordLists.hpp>	// Pascal unit
#include <UXlsOtherRecords.hpp>	// Pascal unit
#include <UXlsSST.hpp>	// Pascal unit
#include <UXlsReferences.hpp>	// Pascal unit
#include <USheetNameList.hpp>	// Pascal unit
#include <UXlsFormula.hpp>	// Pascal unit
#include <UXlsEscher.hpp>	// Pascal unit
#include <UXlsClientData.hpp>	// Pascal unit
#include <UXlsSheet.hpp>	// Pascal unit
#include <UXlsWorkbookGlobals.hpp>	// Pascal unit
#include <UXlsBaseList.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UOle2Impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uexcelrecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSheetList;
class PASCALIMPLEMENTATION TSheetList : public Uxlsbaselist::TBaseList
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	Uxlssheet::TSheet* operator[](int index) { return Items[index]; }
	
private:
	Uxlssheet::TSheet* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlssheet::TSheet* Value);
	
public:
	__property Uxlssheet::TSheet* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlssheet::TSheet* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlssheet::TSheet* aRecord);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteSheets(const int SheetIndex, const int SheetCount);
public:
	/* TObjectList.Create */ inline __fastcall TSheetList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSheetList(void) { }
	
};


class DELPHICLASS TWorkbook;
class PASCALIMPLEMENTATION TWorkbook : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Uxlsworkbookglobals::TWorkbookGlobals* FGlobals;
	TSheetList* FSheets;
	void __fastcall FixBoundSheetsOffset(const bool NeedsRecalc);
	void __fastcall FixRows(void);
	Uxlssheet::TWorkSheet* __fastcall GetWorkSheets(int index);
	int __fastcall GetActiveSheet(void);
	void __fastcall SetActiveSheet(const int Value);
	void __fastcall FixRangeBoundSheetsOffset(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	void __fastcall FixCodeNames(void);
	bool __fastcall GetIsXltTemplate(void);
	void __fastcall SetIsXltTemplate(const bool Value);
	
public:
	__property Uxlsworkbookglobals::TWorkbookGlobals* Globals = {read=FGlobals, write=FGlobals};
	__property TSheetList* Sheets = {read=FSheets, write=FSheets};
	bool __fastcall IsWorksheet(const int Index);
	__property Uxlssheet::TWorkSheet* WorkSheets[int index] = {read=GetWorkSheets};
	__property bool IsXltTemplate = {read=GetIsXltTemplate, write=SetIsXltTemplate, nodefault};
	__property int ActiveSheet = {read=GetActiveSheet, write=SetActiveSheet, nodefault};
	__fastcall TWorkbook(void);
	__fastcall virtual ~TWorkbook(void);
	void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const bool NeedsRecalc);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	void __fastcall InsertAndCopyRowsAndCols(const int SheetNo, const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const bool OnlyFormulas);
	void __fastcall DeleteRowsAndCols(const int SheetNo, const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount);
	void __fastcall InsertSheets(const int CopyFrom, const int InsertBefore, int SheetCount);
	void __fastcall DeleteSheets(const int SheetPos, const int SheetCount);
	void __fastcall InsertHPageBreak(const int SheetNo, const System::Word aRow);
	void __fastcall InsertVPageBreak(const int SheetNo, const System::Word aCol);
	void __fastcall RestoreObjectCoords(int dSheet);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uexcelrecords */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uexcelrecords;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UexcelrecordsHPP
