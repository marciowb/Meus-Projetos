// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsworkbookglobals.pas' rev: 21.00

#ifndef TmsuxlsworkbookglobalsHPP
#define TmsuxlsworkbookglobalsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsotherrecords.hpp>	// Pascal unit
#include <Tmsuxlschart.hpp>	// Pascal unit
#include <Tmsuxlssst.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuxlssections.hpp>	// Pascal unit
#include <Tmsuxlsreferences.hpp>	// Pascal unit
#include <Tmsusheetnamelist.hpp>	// Pascal unit
#include <Tmsuxlsescher.hpp>	// Pascal unit
#include <Tmsuxlsformula.hpp>	// Pascal unit
#include <Tmsuescherrecords.hpp>	// Pascal unit
#include <Tmsuxlspalette.hpp>	// Pascal unit
#include <Tmsuxlsxf.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsworkbookglobals
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBoundSheetList;
class PASCALIMPLEMENTATION TBoundSheetList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Tmsusheetnamelist::TSheetNameList* FSheetNames;
	Tmsuxlsbaserecordlists::TBoundSheetRecordList* FBoundSheets;
	
public:
	__property Tmsuxlsbaserecordlists::TBoundSheetRecordList* BoundSheets = {read=FBoundSheets};
	__fastcall TBoundSheetList(void);
	__fastcall virtual ~TBoundSheetList(void);
	void __fastcall Clear(void);
	void __fastcall Add(const Tmsuxlsotherrecords::TBoundSheetRecord* aRecord);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const int SheetIndex);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const int SheetIndex);
	void __fastcall InsertSheet(const int BeforeSheet, const System::Word OptionFlags, const System::UnicodeString SheetName);
	void __fastcall DeleteSheet(const int SheetIndex);
};


class DELPHICLASS TWorkbookGlobals;
class PASCALIMPLEMENTATION TWorkbookGlobals : public Tmsuxlssections::TBaseSection
{
	typedef Tmsuxlssections::TBaseSection inherited;
	
private:
	Tmsuxlssst::TSST* FSST;
	Tmsuxlsreferences::TReferences* FReferences;
	TBoundSheetList* FBoundSheets;
	Tmsuxlsbaserecordlists::TBaseRecordList* FMiscRecords;
	Tmsuxlsbaserecordlists::TNameRecordList* FNames;
	Tmsuxlsescher::TDrawingGroup* FDrawingGroup;
	Tmsuxlsbaserecords::TWindow1Record* FWindow1;
	Tmsuxlsbaserecords::T1904Record* F1904;
	Tmsuxlsbaserecords::TBookBoolRecord* FBookBool;
	Tmsuxlsbaserecords::TPrecisionRecord* FPrecision;
	Tmsuxlsxf::TXFRecordList* FXF;
	Tmsuxlsxf::TFontRecordList* FFonts;
	Tmsuxlsxf::TFormatRecordList* FFormats;
	Tmsuxlspalette::TPaletteRecord* FPaletteCache;
	int FPaletteIndex;
	bool FHasMacro;
	bool FIsXltTemplate;
	System::UnicodeString FCodeName;
	int __fastcall GetSheetCount(void);
	System::UnicodeString __fastcall GetSheetName(const int index);
	void __fastcall SetSheetName(const int index, const System::UnicodeString Value);
	Tmsuflxmessages::TXlsSheetVisible __fastcall GetSheetVisible(const int index);
	void __fastcall SetSheetVisible(const int index, const Tmsuflxmessages::TXlsSheetVisible Value);
	System::Word __fastcall GetSheetOptionFlags(const int index);
	int __fastcall GetActivesheet(void);
	void __fastcall SetActiveSheet(const int Value);
	unsigned __fastcall GetColorPalette(int Index);
	void __fastcall SetColorPalette(int Index, const unsigned Value);
	bool __fastcall GetIs1904(void);
	bool __fastcall GetPrecisionAsDisplayed(void);
	bool __fastcall GetSaveExternalLinkValues(void);
	void __fastcall SetIs1904(const bool Value);
	void __fastcall SetPrecisionAsDisplayed(const bool Value);
	void __fastcall SetSaveExternalLinkValues(const bool Value);
	
public:
	__property Tmsuxlssst::TSST* SST = {read=FSST};
	__property System::UnicodeString SheetName[const int index] = {read=GetSheetName, write=SetSheetName};
	void __fastcall SetFirstSheetVisible(const int index);
	__property Tmsuflxmessages::TXlsSheetVisible SheetVisible[const int index] = {read=GetSheetVisible, write=SetSheetVisible};
	__property int SheetCount = {read=GetSheetCount, nodefault};
	__property System::Word SheetOptionFlags[const int index] = {read=GetSheetOptionFlags};
	void __fastcall SheetSetOffset(const int index, const unsigned Offset);
	__property int ActiveSheet = {read=GetActivesheet, write=SetActiveSheet, nodefault};
	__property Tmsuxlsescher::TDrawingGroup* DrawingGroup = {read=FDrawingGroup};
	__property Tmsuxlsreferences::TReferences* References = {read=FReferences};
	__property Tmsuxlsbaserecordlists::TNameRecordList* Names = {read=FNames};
	__property bool HasMacro = {read=FHasMacro, nodefault};
	__property System::UnicodeString CodeName = {read=FCodeName};
	__property bool IsXltTemplate = {read=FIsXltTemplate, write=FIsXltTemplate, nodefault};
	__fastcall TWorkbookGlobals(void);
	__fastcall virtual ~TWorkbookGlobals(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Tmsuflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall Clear(void);
	virtual void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader, const Tmsuxlsotherrecords::TBOFRecord* First, const Tmsuxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const int SheetIndex, const Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteSheets(const int SheetIndex, const int SheetCount);
	void __fastcall InsertSheets(const int CopyFrom, int BeforeSheet, const System::Word OptionFlags, const System::UnicodeString Name, const int SheetCount);
	__property unsigned ColorPalette[int Index] = {read=GetColorPalette, write=SetColorPalette};
	__property Tmsuxlsxf::TXFRecordList* XF = {read=FXF};
	__property Tmsuxlsxf::TFontRecordList* Fonts = {read=FFonts};
	__property Tmsuxlsxf::TFormatRecordList* Formats = {read=FFormats};
	__property bool Is1904 = {read=GetIs1904, write=SetIs1904, nodefault};
	__property bool PrecisionAsDisplayed = {read=GetPrecisionAsDisplayed, write=SetPrecisionAsDisplayed, nodefault};
	__property bool SaveExternalLinkValues = {read=GetSaveExternalLinkValues, write=SetSaveExternalLinkValues, nodefault};
	void __fastcall DeleteCountry(void);
	__classmethod bool __fastcall IsValidRangeName(const System::UnicodeString Name, int &OptionFlags);
	void __fastcall CheckInternalNames(const int OptionFlags);
	void __fastcall AddName(Tmsuflxmessages::TXlsNamedRange &Range, const void * CellList);
	Tmsuxlsformula::TNameRecord* __fastcall GetName(const int sheet, const System::UnicodeString aName);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsworkbookglobals */
using namespace Tmsuxlsworkbookglobals;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsworkbookglobalsHPP
