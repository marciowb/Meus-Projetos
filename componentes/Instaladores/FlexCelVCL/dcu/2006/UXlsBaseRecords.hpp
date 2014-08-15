// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsbaserecords.pas' rev: 10.00

#ifndef UxlsbaserecordsHPP
#define UxlsbaserecordsHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsbaserecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseRecord;
class DELPHICLASS TContinueRecord;
class PASCALIMPLEMENTATION TBaseRecord : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Word Id;
	Xlsmessages::ArrayOfByte *Data;
	Word DataSize;
	TContinueRecord* Continue;
	void __fastcall SaveDataToStream(const Uole2impl::TOle2File* Workbook, const Xlsmessages::PArrayOfByte aData);
	
protected:
	virtual TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TBaseRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall virtual ~TBaseRecord(void);
	void __fastcall AddContinue(const TContinueRecord* aContinue);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
	TBaseRecord* __fastcall CopyTo(void);
	virtual int __fastcall TotalSize(void);
	virtual int __fastcall TotalSizeNoHeaders(void);
};


class PASCALIMPLEMENTATION TContinueRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TContinueRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TContinueRecord(void) { }
	#pragma option pop
	
};



typedef TMetaClass* ClassOfTBaseRecord;

class DELPHICLASS TIgnoreRecord;
class PASCALIMPLEMENTATION TIgnoreRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	virtual int __fastcall TotalSize(void);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TIgnoreRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TIgnoreRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSubListRecord;
class PASCALIMPLEMENTATION TSubListRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	Contnrs::TObjectList* FSubList;
	
protected:
	virtual TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall TSubListRecord(const Contnrs::TObjectList* aSubList);
	virtual int __fastcall TotalSize(void);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TSubListRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSubListRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBaseRowColRecord;
class PASCALIMPLEMENTATION TBaseRowColRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	Word __fastcall GetColumn(void);
	Word __fastcall GetRow(void);
	void __fastcall SetColumn(Word Value);
	void __fastcall SetRow(Word Value);
	
public:
	__property Word Row = {read=GetRow, write=SetRow, nodefault};
	__property Word Column = {read=GetColumn, write=SetColumn, nodefault};
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	__fastcall virtual TBaseRowColRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	virtual __int64 __fastcall FixTotalSize(const bool NeedsRecalc);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBaseRowColRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCellRecord;
class PASCALIMPLEMENTATION TCellRecord : public TBaseRowColRecord 
{
	typedef TBaseRowColRecord inherited;
	
private:
	Word __fastcall GetXF(void);
	void __fastcall SetXF(const Word Value);
	
protected:
	virtual Variant __fastcall GetValue();
	virtual void __fastcall SetValue(const Variant &Value);
	
public:
	__property Word XF = {read=GetXF, write=SetXF, nodefault};
	__property Variant Value = {read=GetValue, write=SetValue};
	__fastcall TCellRecord(const Word aId, const Word aDataSize, const Word aRow, const Word aCol, const Word aXF);
	virtual bool __fastcall CanJoinNext(const TCellRecord* NextRecord, const int MaxCol);
	virtual void __fastcall SaveFirstMul(const Uole2impl::TOle2File* Workbook, const Word JoinedRecordSize);
	virtual void __fastcall SaveMidMul(const Uole2impl::TOle2File* Workbook);
	virtual void __fastcall SaveLastMul(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSizeFirst(void);
	virtual int __fastcall TotalSizeMid(void);
	virtual int __fastcall TotalSizeLast(void);
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TCellRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRowColRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCellRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRowRecord;
class PASCALIMPLEMENTATION TRowRecord : public TBaseRowColRecord 
{
	typedef TBaseRowColRecord inherited;
	
private:
	Word __fastcall GetHeight(void);
	Word __fastcall GetMaxCol(void);
	Word __fastcall GetMinCol(void);
	Word __fastcall GetXF(void);
	void __fastcall SetHeight(const Word Value);
	void __fastcall SetMaxCol(const Word Value);
	void __fastcall SetMinCol(const Word Value);
	void __fastcall SetXF(const Word Value);
	Word __fastcall GetOptions(void);
	void __fastcall SetOptions(const Word Value);
	
public:
	__fastcall virtual TRowRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TRowRecord(const Word Row);
	HIDESBASE Word __fastcall GetRow(void);
	__property Word MaxCol = {read=GetMaxCol, write=SetMaxCol, nodefault};
	__property Word MinCol = {read=GetMinCol, write=SetMinCol, nodefault};
	__property Word Height = {read=GetHeight, write=SetHeight, nodefault};
	__property Word XF = {read=GetXF, write=SetXF, nodefault};
	bool __fastcall IsFormatted(void);
	bool __fastcall IsModified(void);
	__property Word Options = {read=GetOptions, write=SetOptions, nodefault};
	void __fastcall ManualHeight(void);
	void __fastcall AutoHeight(void);
	void __fastcall Hide(const bool value);
	bool __fastcall IsAutoHeight(void);
	bool __fastcall IsHidden(void);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int aMinCol, const int aMaxCol);
	void __fastcall SetRowOutlineLevel(const int Level);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRowRecord(void) { }
	#pragma option pop
	
};


#pragma pack(push,1)
struct TDimensionsRec
{
	
public:
	unsigned FirstRow;
	unsigned LastRow;
	Word FirstCol;
	Word LastCol;
	Word Extra;
} ;
#pragma pack(pop)

typedef TDimensionsRec *PDimensionsRec;

class DELPHICLASS TDimensionsRecord;
class PASCALIMPLEMENTATION TDimensionsRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	PDimensionsRec __fastcall Dim(void);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TDimensionsRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDimensionsRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TStringRecord;
class PASCALIMPLEMENTATION TStringRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSize(void);
	WideString __fastcall Value();
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TStringRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TStringRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TWindow1Record;
class PASCALIMPLEMENTATION TWindow1Record : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	int __fastcall GetActiveSheet(void);
	void __fastcall SetActiveSheet(const int Value);
	int __fastcall GetFirstSheetVisible(void);
	void __fastcall SetFirstSheetVisible(const int Value);
	void __fastcall MakeMoreThan1(const int p);
	
public:
	__property int ActiveSheet = {read=GetActiveSheet, write=SetActiveSheet, nodefault};
	__property int FirstSheetVisible = {read=GetFirstSheetVisible, write=SetFirstSheetVisible, nodefault};
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TWindow1Record(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TWindow1Record(void) { }
	#pragma option pop
	
};


class DELPHICLASS TWindow2Record;
class PASCALIMPLEMENTATION TWindow2Record : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetSelected(void);
	void __fastcall SetSelected(const bool Value);
	bool __fastcall GetShowGridLines(void);
	void __fastcall SetShowGridLines(const bool Value);
	bool __fastcall GetShowGridHeaders(void);
	void __fastcall SetShowGridHeaders(const bool Value);
	void __fastcall SetSheetZoom(const int Value);
	int __fastcall GetSheetZoom(void);
	bool __fastcall GetIsFrozen(void);
	bool __fastcall GetIsFrozenButNoSplit(void);
	void __fastcall SetIsFrozen(const bool value);
	void __fastcall SetIsFrozenButNoSplit(const bool value);
	
protected:
	virtual TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__property bool Selected = {read=GetSelected, write=SetSelected, nodefault};
	__property bool ShowGridLines = {read=GetShowGridLines, write=SetShowGridLines, nodefault};
	__property bool ShowGridHeaders = {read=GetShowGridHeaders, write=SetShowGridHeaders, nodefault};
	__property int SheetZoom = {read=GetSheetZoom, write=SetSheetZoom, nodefault};
	__property bool IsFrozen = {read=GetIsFrozen, write=SetIsFrozen, nodefault};
	__property bool IsFrozenButNoSplit = {read=GetIsFrozenButNoSplit, write=SetIsFrozenButNoSplit, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TWindow2Record(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TWindow2Record(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSCLRecord;
class PASCALIMPLEMENTATION TSCLRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	int __fastcall GetZoom(void);
	void __fastcall SetZoom(const int Value);
	
public:
	__fastcall TSCLRecord(const int aZoom);
	__property int Zoom = {read=GetZoom, write=SetZoom, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TSCLRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSCLRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDefColWidthRecord;
class PASCALIMPLEMENTATION TDefColWidthRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	Word __fastcall Width(void);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TDefColWidthRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDefColWidthRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TStandardWidthRecord;
class PASCALIMPLEMENTATION TStandardWidthRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	Word __fastcall Width(void);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TStandardWidthRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TStandardWidthRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDefRowHeightRecord;
class PASCALIMPLEMENTATION TDefRowHeightRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
public:
	Word __fastcall Height(void);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TDefRowHeightRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDefRowHeightRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPageHeaderFooterRecord;
class PASCALIMPLEMENTATION TPageHeaderFooterRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	WideString __fastcall GetText();
	void __fastcall SetText(const WideString Value);
	
public:
	__property WideString Text = {read=GetText, write=SetText};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPageHeaderFooterRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPageHeaderFooterRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPageHeaderRecord;
class PASCALIMPLEMENTATION TPageHeaderRecord : public TPageHeaderFooterRecord 
{
	typedef TPageHeaderFooterRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPageHeaderRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TPageHeaderFooterRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPageHeaderRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPageFooterRecord;
class PASCALIMPLEMENTATION TPageFooterRecord : public TPageHeaderFooterRecord 
{
	typedef TPageHeaderFooterRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPageFooterRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TPageHeaderFooterRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPageFooterRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPrintGridLinesRecord;
class PASCALIMPLEMENTATION TPrintGridLinesRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetValue(void);
	void __fastcall SetValue(const bool Value);
	
public:
	__property bool Value = {read=GetValue, write=SetValue, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPrintGridLinesRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPrintGridLinesRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMarginRecord;
class PASCALIMPLEMENTATION TMarginRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	double __fastcall GetValue(void);
	void __fastcall SetValue(const double Value);
	
public:
	__property double Value = {read=GetValue, write=SetValue};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TMarginRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMarginRecord(void) { }
	#pragma option pop
	
};


#pragma pack(push,1)
struct TSetupRec
{
	
public:
	Word PaperSize;
	Word Scale;
	Word PageStart;
	Word FitWidth;
	Word FitHeight;
	Word GrBit;
	Word Resolution;
	Word VResolution;
	double HeaderMargin;
	double FooterMargin;
	Word Copies;
} ;
#pragma pack(pop)

typedef TSetupRec *PSetupRec;

class DELPHICLASS TSetupRecord;
class PASCALIMPLEMENTATION TSetupRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	TSetupRec __fastcall GetValue();
	void __fastcall SetValue(const TSetupRec &Value);
	Word __fastcall GetScale(void);
	void __fastcall SetScale(const Word Value);
	Word __fastcall GetFitHeight(void);
	Word __fastcall GetFitWidth(void);
	void __fastcall SetFitHeight(const Word Value);
	void __fastcall SetFitWidth(const Word Value);
	Extended __fastcall GetFooterMargin(void);
	Extended __fastcall GetHeaderMargin(void);
	void __fastcall SetFooterMargin(const Extended Value);
	void __fastcall SetHeaderMargin(const Extended Value);
	Word __fastcall GetPrintOptions(void);
	void __fastcall SetPrintOptions(const Word Value);
	int __fastcall GetPrintCopies(void);
	int __fastcall GetPrintPaperSize(void);
	int __fastcall GetPrintXResolution(void);
	int __fastcall GetPrintYResolution(void);
	void __fastcall SetPrintCopies(const int Value);
	void __fastcall SetPrintPaperSize(const int Value);
	void __fastcall SetPrintXResolution(const int Value);
	void __fastcall SetPrintYResolution(const int Value);
	
public:
	__property TSetupRec Value = {read=GetValue, write=SetValue};
	__property Word Scale = {read=GetScale, write=SetScale, nodefault};
	__property Word PrintOptions = {read=GetPrintOptions, write=SetPrintOptions, nodefault};
	__property Word FitWidth = {read=GetFitWidth, write=SetFitWidth, nodefault};
	__property Word FitHeight = {read=GetFitHeight, write=SetFitHeight, nodefault};
	__property int PrintPaperSize = {read=GetPrintPaperSize, write=SetPrintPaperSize, nodefault};
	__property int PrintCopies = {read=GetPrintCopies, write=SetPrintCopies, nodefault};
	__property int PrintXResolution = {read=GetPrintXResolution, write=SetPrintXResolution, nodefault};
	__property int PrintYResolution = {read=GetPrintYResolution, write=SetPrintYResolution, nodefault};
	__property Extended HeaderMargin = {read=GetHeaderMargin, write=SetHeaderMargin};
	__property Extended FooterMargin = {read=GetFooterMargin, write=SetFooterMargin};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TSetupRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSetupRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPlsRecord;
class PASCALIMPLEMENTATION TPlsRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	Uflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings();
	void __fastcall SetPrinterDriverSettings(const Uflxmessages::TPrinterDriverSettings &Value);
	
public:
	__fastcall TPlsRecord(const Uflxmessages::TPrinterDriverSettings &aPrinterData);
	__property Uflxmessages::TPrinterDriverSettings PrinterData = {read=GetPrinterDriverSettings, write=SetPrinterDriverSettings};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPlsRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPlsRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPrintCenteredRecord;
class PASCALIMPLEMENTATION TPrintCenteredRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetCentered(void);
	void __fastcall SetCentered(const bool Value);
	
public:
	__property bool Centered = {read=GetCentered, write=SetCentered, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPrintCenteredRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPrintCenteredRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TWsBoolRecord;
class PASCALIMPLEMENTATION TWsBoolRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	Word __fastcall GetValue(void);
	void __fastcall SetValue(const Word Value);
	bool __fastcall GetFitToPage(void);
	void __fastcall SetFitToPage(const bool Value);
	bool __fastcall GetOutlineSummaryColsRightOfDetail(void);
	bool __fastcall GetOutlineSummaryRowsBelowDetail(void);
	bool __fastcall GetOutlineAutomaticStyles(void);
	void __fastcall SetOutlineRightOfDetail(const bool Value);
	void __fastcall SetOutlineSummaryRowsBelowDetail(const bool Value);
	void __fastcall SetOutlineAutomaticStyles(const bool Value);
	
public:
	__property Word Value = {read=GetValue, write=SetValue, nodefault};
	__property bool FitToPage = {read=GetFitToPage, write=SetFitToPage, nodefault};
	__property bool OutlineSummaryRowsBelowDetail = {read=GetOutlineSummaryRowsBelowDetail, write=SetOutlineSummaryRowsBelowDetail, nodefault};
	__property bool OutlineSummaryColsRightOfDetail = {read=GetOutlineSummaryColsRightOfDetail, write=SetOutlineRightOfDetail, nodefault};
	__property bool OutlineAutomaticStyles = {read=GetOutlineAutomaticStyles, write=SetOutlineAutomaticStyles, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TWsBoolRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TWsBoolRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS T1904Record;
class PASCALIMPLEMENTATION T1904Record : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetIs1904(void);
	void __fastcall SetIs1904(const bool Value);
	
public:
	__property bool Is1904 = {read=GetIs1904, write=SetIs1904, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual T1904Record(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~T1904Record(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRefModeRecord;
class PASCALIMPLEMENTATION TRefModeRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetIsR1C1(void);
	void __fastcall SetIsR1C1(const bool Value);
	
public:
	__property bool IsR1C1 = {read=GetIsR1C1, write=SetIsR1C1, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TRefModeRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRefModeRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPrecisionRecord;
class PASCALIMPLEMENTATION TPrecisionRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetPrecisionAsDisplayed(void);
	void __fastcall SetPrecisionAsDisplayed(const bool Value);
	
public:
	__property bool PrecisionAsDisplayed = {read=GetPrecisionAsDisplayed, write=SetPrecisionAsDisplayed, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPrecisionRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPrecisionRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBookBoolRecord;
class PASCALIMPLEMENTATION TBookBoolRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	bool __fastcall GetSaveExternalLinkValues(void);
	void __fastcall SetSaveExternalLinkValues(const bool Value);
	
public:
	__property bool SaveExternalLinkValues = {read=GetSaveExternalLinkValues, write=SetSaveExternalLinkValues, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TBookBoolRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBookBoolRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TAutoFilterInfoRecord;
class PASCALIMPLEMENTATION TAutoFilterInfoRecord : public TBaseRecord 
{
	typedef TBaseRecord inherited;
	
private:
	int __fastcall Get_DropDownCount(void);
	void __fastcall Set_DropDownCount(const int value);
	
public:
	__property int DropDownCount = {read=Get_DropDownCount, write=Set_DropDownCount, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TAutoFilterInfoRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TAutoFilterInfoRecord(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ReadMem(TBaseRecord* &aRecord, int &aPos, const int aSize, const void * pResult);
extern PACKAGE void __fastcall ReadStr(TBaseRecord* &aRecord, int &aPos, AnsiString &ShortData, WideString &WideData, Byte &OptionFlags, Byte &ActualOptionFlags, int &DestPos, const int StrLen);
extern PACKAGE TBaseRecord* __fastcall LoadRecords(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader);

}	/* namespace Uxlsbaserecords */
using namespace Uxlsbaserecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsbaserecords
