// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsbaserecords.pas' rev: 21.00

#ifndef TmsuxlsbaserecordsHPP
#define TmsuxlsbaserecordsHPP

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
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsbaserecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseRecord;
class DELPHICLASS TContinueRecord;
class PASCALIMPLEMENTATION TBaseRecord : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Word Id;
	Tmsxlsmessages::ArrayOfByte *Data;
	System::Word DataSize;
	TContinueRecord* Continue;
	void __fastcall SaveDataToStream(const Tmsuole2impl::TOle2File* Workbook, const Tmsxlsmessages::PArrayOfByte aData);
	
protected:
	virtual TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TBaseRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall virtual ~TBaseRecord(void);
	void __fastcall AddContinue(const TContinueRecord* aContinue);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
	TBaseRecord* __fastcall CopyTo(void);
	virtual int __fastcall TotalSize(void);
	virtual int __fastcall TotalSizeNoHeaders(void);
};


typedef TMetaClass* ClassOfTBaseRecord;

class PASCALIMPLEMENTATION TContinueRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TContinueRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TContinueRecord(void) { }
	
};


class DELPHICLASS TIgnoreRecord;
class PASCALIMPLEMENTATION TIgnoreRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	virtual int __fastcall TotalSize(void);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TIgnoreRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TIgnoreRecord(void) { }
	
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
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TSubListRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSubListRecord(void) { }
	
};


class DELPHICLASS TBaseRowColRecord;
class PASCALIMPLEMENTATION TBaseRowColRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
private:
	System::Word __fastcall GetColumn(void);
	System::Word __fastcall GetRow(void);
	void __fastcall SetColumn(System::Word Value);
	void __fastcall SetRow(System::Word Value);
	
public:
	__property System::Word Row = {read=GetRow, write=SetRow, nodefault};
	__property System::Word Column = {read=GetColumn, write=SetColumn, nodefault};
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	__fastcall virtual TBaseRowColRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	virtual __int64 __fastcall FixTotalSize(const bool NeedsRecalc);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBaseRowColRecord(void) { }
	
};


class DELPHICLASS TCellRecord;
class PASCALIMPLEMENTATION TCellRecord : public TBaseRowColRecord
{
	typedef TBaseRowColRecord inherited;
	
private:
	System::Word __fastcall GetXF(void);
	void __fastcall SetXF(const System::Word Value);
	
protected:
	virtual System::Variant __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::Variant &Value);
	
public:
	__property System::Word XF = {read=GetXF, write=SetXF, nodefault};
	__property System::Variant Value = {read=GetValue, write=SetValue};
	__fastcall TCellRecord(const System::Word aId, const System::Word aDataSize, const System::Word aRow, const System::Word aCol, const System::Word aXF);
	virtual bool __fastcall CanJoinNext(const TCellRecord* NextRecord, const int MaxCol);
	virtual void __fastcall SaveFirstMul(const Tmsuole2impl::TOle2File* Workbook, const System::Word JoinedRecordSize);
	virtual void __fastcall SaveMidMul(const Tmsuole2impl::TOle2File* Workbook);
	virtual void __fastcall SaveLastMul(const Tmsuole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSizeFirst(void);
	virtual int __fastcall TotalSizeMid(void);
	virtual int __fastcall TotalSizeLast(void);
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TCellRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRowColRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCellRecord(void) { }
	
};


class DELPHICLASS TRowRecord;
class PASCALIMPLEMENTATION TRowRecord : public TBaseRowColRecord
{
	typedef TBaseRowColRecord inherited;
	
private:
	System::Word __fastcall GetHeight(void);
	System::Word __fastcall GetMaxCol(void);
	System::Word __fastcall GetMinCol(void);
	System::Word __fastcall GetXF(void);
	void __fastcall SetHeight(const System::Word Value);
	void __fastcall SetMaxCol(const System::Word Value);
	void __fastcall SetMinCol(const System::Word Value);
	void __fastcall SetXF(const System::Word Value);
	System::Word __fastcall GetOptions(void);
	void __fastcall SetOptions(const System::Word Value);
	
public:
	__fastcall virtual TRowRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TRowRecord(const System::Word Row);
	HIDESBASE System::Word __fastcall GetRow(void);
	__property System::Word MaxCol = {read=GetMaxCol, write=SetMaxCol, nodefault};
	__property System::Word MinCol = {read=GetMinCol, write=SetMinCol, nodefault};
	__property System::Word Height = {read=GetHeight, write=SetHeight, nodefault};
	__property System::Word XF = {read=GetXF, write=SetXF, nodefault};
	bool __fastcall IsFormatted(void);
	bool __fastcall IsModified(void);
	__property System::Word Options = {read=GetOptions, write=SetOptions, nodefault};
	void __fastcall ManualHeight(void);
	void __fastcall AutoHeight(void);
	void __fastcall Hide(const bool value);
	bool __fastcall IsAutoHeight(void);
	bool __fastcall IsHidden(void);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const int aMinCol, const int aMaxCol);
	void __fastcall SetRowOutlineLevel(const int Level);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRowRecord(void) { }
	
};


#pragma pack(push,1)
struct TDimensionsRec
{
	
public:
	unsigned FirstRow;
	unsigned LastRow;
	System::Word FirstCol;
	System::Word LastCol;
	System::Word Extra;
};
#pragma pack(pop)


typedef TDimensionsRec *PDimensionsRec;

class DELPHICLASS TDimensionsRecord;
class PASCALIMPLEMENTATION TDimensionsRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	PDimensionsRec __fastcall Dim(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDimensionsRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDimensionsRecord(void) { }
	
};


class DELPHICLASS TStringRecord;
class PASCALIMPLEMENTATION TStringRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSize(void);
	System::UnicodeString __fastcall Value(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TStringRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TStringRecord(void) { }
	
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
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TWindow1Record(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TWindow1Record(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TWindow2Record(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TWindow2Record(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TSCLRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSCLRecord(void) { }
	
};


class DELPHICLASS TDefColWidthRecord;
class PASCALIMPLEMENTATION TDefColWidthRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	System::Word __fastcall Width(void);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDefColWidthRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDefColWidthRecord(void) { }
	
};


class DELPHICLASS TStandardWidthRecord;
class PASCALIMPLEMENTATION TStandardWidthRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	System::Word __fastcall Width(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TStandardWidthRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TStandardWidthRecord(void) { }
	
};


class DELPHICLASS TDefRowHeightRecord;
class PASCALIMPLEMENTATION TDefRowHeightRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
public:
	System::Word __fastcall Height(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDefRowHeightRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDefRowHeightRecord(void) { }
	
};


class DELPHICLASS TPageHeaderFooterRecord;
class PASCALIMPLEMENTATION TPageHeaderFooterRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
private:
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetText(const System::UnicodeString Value);
	
public:
	__property System::UnicodeString Text = {read=GetText, write=SetText};
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TPageHeaderFooterRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPageHeaderFooterRecord(void) { }
	
};


class DELPHICLASS TPageHeaderRecord;
class PASCALIMPLEMENTATION TPageHeaderRecord : public TPageHeaderFooterRecord
{
	typedef TPageHeaderFooterRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TPageHeaderRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TPageHeaderFooterRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPageHeaderRecord(void) { }
	
};


class DELPHICLASS TPageFooterRecord;
class PASCALIMPLEMENTATION TPageFooterRecord : public TPageHeaderFooterRecord
{
	typedef TPageHeaderFooterRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TPageFooterRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TPageHeaderFooterRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPageFooterRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TPrintGridLinesRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPrintGridLinesRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TMarginRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMarginRecord(void) { }
	
};


#pragma pack(push,1)
struct TSetupRec
{
	
public:
	System::Word PaperSize;
	System::Word Scale;
	System::Word PageStart;
	System::Word FitWidth;
	System::Word FitHeight;
	System::Word GrBit;
	System::Word Resolution;
	System::Word VResolution;
	double HeaderMargin;
	double FooterMargin;
	System::Word Copies;
};
#pragma pack(pop)


typedef TSetupRec *PSetupRec;

class DELPHICLASS TSetupRecord;
class PASCALIMPLEMENTATION TSetupRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
private:
	TSetupRec __fastcall GetValue(void);
	void __fastcall SetValue(const TSetupRec &Value);
	System::Word __fastcall GetScale(void);
	void __fastcall SetScale(const System::Word Value);
	System::Word __fastcall GetFitHeight(void);
	System::Word __fastcall GetFitWidth(void);
	void __fastcall SetFitHeight(const System::Word Value);
	void __fastcall SetFitWidth(const System::Word Value);
	System::Extended __fastcall GetFooterMargin(void);
	System::Extended __fastcall GetHeaderMargin(void);
	void __fastcall SetFooterMargin(const System::Extended Value);
	void __fastcall SetHeaderMargin(const System::Extended Value);
	System::Word __fastcall GetPrintOptions(void);
	void __fastcall SetPrintOptions(const System::Word Value);
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
	__property System::Word Scale = {read=GetScale, write=SetScale, nodefault};
	__property System::Word PrintOptions = {read=GetPrintOptions, write=SetPrintOptions, nodefault};
	__property System::Word FitWidth = {read=GetFitWidth, write=SetFitWidth, nodefault};
	__property System::Word FitHeight = {read=GetFitHeight, write=SetFitHeight, nodefault};
	__property int PrintPaperSize = {read=GetPrintPaperSize, write=SetPrintPaperSize, nodefault};
	__property int PrintCopies = {read=GetPrintCopies, write=SetPrintCopies, nodefault};
	__property int PrintXResolution = {read=GetPrintXResolution, write=SetPrintXResolution, nodefault};
	__property int PrintYResolution = {read=GetPrintYResolution, write=SetPrintYResolution, nodefault};
	__property System::Extended HeaderMargin = {read=GetHeaderMargin, write=SetHeaderMargin};
	__property System::Extended FooterMargin = {read=GetFooterMargin, write=SetFooterMargin};
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TSetupRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSetupRecord(void) { }
	
};


class DELPHICLASS TPlsRecord;
class PASCALIMPLEMENTATION TPlsRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
private:
	Tmsuflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings(void);
	void __fastcall SetPrinterDriverSettings(const Tmsuflxmessages::TPrinterDriverSettings &Value);
	
public:
	__fastcall TPlsRecord(const Tmsuflxmessages::TPrinterDriverSettings &aPrinterData);
	__property Tmsuflxmessages::TPrinterDriverSettings PrinterData = {read=GetPrinterDriverSettings, write=SetPrinterDriverSettings};
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TPlsRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPlsRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TPrintCenteredRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPrintCenteredRecord(void) { }
	
};


class DELPHICLASS TWsBoolRecord;
class PASCALIMPLEMENTATION TWsBoolRecord : public TBaseRecord
{
	typedef TBaseRecord inherited;
	
private:
	System::Word __fastcall GetValue(void);
	void __fastcall SetValue(const System::Word Value);
	bool __fastcall GetFitToPage(void);
	void __fastcall SetFitToPage(const bool Value);
	bool __fastcall GetOutlineSummaryColsRightOfDetail(void);
	bool __fastcall GetOutlineSummaryRowsBelowDetail(void);
	bool __fastcall GetOutlineAutomaticStyles(void);
	void __fastcall SetOutlineRightOfDetail(const bool Value);
	void __fastcall SetOutlineSummaryRowsBelowDetail(const bool Value);
	void __fastcall SetOutlineAutomaticStyles(const bool Value);
	
public:
	__property System::Word Value = {read=GetValue, write=SetValue, nodefault};
	__property bool FitToPage = {read=GetFitToPage, write=SetFitToPage, nodefault};
	__property bool OutlineSummaryRowsBelowDetail = {read=GetOutlineSummaryRowsBelowDetail, write=SetOutlineSummaryRowsBelowDetail, nodefault};
	__property bool OutlineSummaryColsRightOfDetail = {read=GetOutlineSummaryColsRightOfDetail, write=SetOutlineRightOfDetail, nodefault};
	__property bool OutlineAutomaticStyles = {read=GetOutlineAutomaticStyles, write=SetOutlineAutomaticStyles, nodefault};
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TWsBoolRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TWsBoolRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual T1904Record(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~T1904Record(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TRefModeRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRefModeRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TPrecisionRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPrecisionRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TBookBoolRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBookBoolRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TAutoFilterInfoRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TAutoFilterInfoRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ReadMem(TBaseRecord* &aRecord, int &aPos, const int aSize, const void * pResult);
extern PACKAGE void __fastcall ReadStr(TBaseRecord* &aRecord, int &aPos, System::AnsiString &ShortData, System::UnicodeString &WideData, System::Byte &OptionFlags, System::Byte &ActualOptionFlags, int &DestPos, const int StrLen);
extern PACKAGE TBaseRecord* __fastcall LoadRecords(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader);

}	/* namespace Tmsuxlsbaserecords */
using namespace Tmsuxlsbaserecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsbaserecordsHPP
