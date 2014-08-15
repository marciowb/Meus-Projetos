// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsworkbookglobals.pas' rev: 11.00

#ifndef UxlsworkbookglobalsHPP
#define UxlsworkbookglobalsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Uxlsotherrecords.hpp>	// Pascal unit
#include <Uxlschart.hpp>	// Pascal unit
#include <Uxlssst.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlssections.hpp>	// Pascal unit
#include <Uxlsreferences.hpp>	// Pascal unit
#include <Usheetnamelist.hpp>	// Pascal unit
#include <Uxlsescher.hpp>	// Pascal unit
#include <Uxlsformula.hpp>	// Pascal unit
#include <Uescherrecords.hpp>	// Pascal unit
#include <Uxlspalette.hpp>	// Pascal unit
#include <Uxlsxf.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsworkbookglobals
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBoundSheetList;
class PASCALIMPLEMENTATION TBoundSheetList : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Usheetnamelist::TSheetNameList* FSheetNames;
	Uxlsbaserecordlists::TBoundSheetRecordList* FBoundSheets;
	
public:
	__property Uxlsbaserecordlists::TBoundSheetRecordList* BoundSheets = {read=FBoundSheets};
	__fastcall TBoundSheetList(void);
	__fastcall virtual ~TBoundSheetList(void);
	void __fastcall Clear(void);
	void __fastcall Add(const Uxlsotherrecords::TBoundSheetRecord* aRecord);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const int SheetIndex);
	void __fastcall InsertSheet(const int BeforeSheet, const Word OptionFlags, const WideString SheetName);
	void __fastcall DeleteSheet(const int SheetIndex);
};


class DELPHICLASS TWorkbookGlobals;
class PASCALIMPLEMENTATION TWorkbookGlobals : public Uxlssections::TBaseSection 
{
	typedef Uxlssections::TBaseSection inherited;
	
private:
	Uxlssst::TSST* FSST;
	Uxlsreferences::TReferences* FReferences;
	TBoundSheetList* FBoundSheets;
	Uxlsbaserecordlists::TBaseRecordList* FMiscRecords;
	Uxlsbaserecordlists::TNameRecordList* FNames;
	Uxlsescher::TDrawingGroup* FDrawingGroup;
	Uxlsbaserecords::TWindow1Record* FWindow1;
	Uxlsbaserecords::T1904Record* F1904;
	Uxlsbaserecords::TBookBoolRecord* FBookBool;
	Uxlsbaserecords::TPrecisionRecord* FPrecision;
	Uxlsxf::TXFRecordList* FXF;
	Uxlsxf::TFontRecordList* FFonts;
	Uxlsxf::TFormatRecordList* FFormats;
	Uxlspalette::TPaletteRecord* FPaletteCache;
	int FPaletteIndex;
	bool FHasMacro;
	bool FIsXltTemplate;
	WideString FCodeName;
	int __fastcall GetSheetCount(void);
	WideString __fastcall GetSheetName(const int index);
	void __fastcall SetSheetName(const int index, const WideString Value);
	Uflxmessages::TXlsSheetVisible __fastcall GetSheetVisible(const int index);
	void __fastcall SetSheetVisible(const int index, const Uflxmessages::TXlsSheetVisible Value);
	Word __fastcall GetSheetOptionFlags(const int index);
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
	__property Uxlssst::TSST* SST = {read=FSST};
	__property WideString SheetName[int index] = {read=GetSheetName, write=SetSheetName};
	void __fastcall SetFirstSheetVisible(const int index);
	__property Uflxmessages::TXlsSheetVisible SheetVisible[int index] = {read=GetSheetVisible, write=SetSheetVisible};
	__property int SheetCount = {read=GetSheetCount, nodefault};
	__property Word SheetOptionFlags[int index] = {read=GetSheetOptionFlags};
	void __fastcall SheetSetOffset(const int index, const unsigned Offset);
	__property int ActiveSheet = {read=GetActivesheet, write=SetActiveSheet, nodefault};
	__property Uxlsescher::TDrawingGroup* DrawingGroup = {read=FDrawingGroup};
	__property Uxlsreferences::TReferences* References = {read=FReferences};
	__property Uxlsbaserecordlists::TNameRecordList* Names = {read=FNames};
	__property bool HasMacro = {read=FHasMacro, nodefault};
	__property WideString CodeName = {read=FCodeName};
	__property bool IsXltTemplate = {read=FIsXltTemplate, write=FIsXltTemplate, nodefault};
	__fastcall TWorkbookGlobals(void);
	__fastcall virtual ~TWorkbookGlobals(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall Clear(void);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TBOFRecord* First, const Uxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteRowsAndCols(const Word aRow, const Word aRowCount, const Word aCol, const Word aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteSheets(const int SheetIndex, const int SheetCount);
	void __fastcall InsertSheets(const int CopyFrom, int BeforeSheet, const Word OptionFlags, const WideString Name, const int SheetCount);
	__property unsigned ColorPalette[int Index] = {read=GetColorPalette, write=SetColorPalette};
	__property Uxlsxf::TXFRecordList* XF = {read=FXF};
	__property Uxlsxf::TFontRecordList* Fonts = {read=FFonts};
	__property Uxlsxf::TFormatRecordList* Formats = {read=FFormats};
	__property bool Is1904 = {read=GetIs1904, write=SetIs1904, nodefault};
	__property bool PrecisionAsDisplayed = {read=GetPrecisionAsDisplayed, write=SetPrecisionAsDisplayed, nodefault};
	__property bool SaveExternalLinkValues = {read=GetSaveExternalLinkValues, write=SetSaveExternalLinkValues, nodefault};
	void __fastcall DeleteCountry(void);
	/*         class method */ static bool __fastcall IsValidRangeName(TMetaClass* vmt, const WideString Name, int &OptionFlags);
	void __fastcall CheckInternalNames(const int OptionFlags);
	void __fastcall AddName(Uflxmessages::TXlsNamedRange &Range, const void * CellList);
	Uxlsformula::TNameRecord* __fastcall GetName(const int sheet, const WideString aName);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsworkbookglobals */
using namespace Uxlsworkbookglobals;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsworkbookglobals
