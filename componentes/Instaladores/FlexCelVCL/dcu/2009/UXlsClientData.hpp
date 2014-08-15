// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsclientdata.pas' rev: 20.00

#ifndef UxlsclientdataHPP
#define UxlsclientdataHPP

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
#include <Uxlssheet.hpp>	// Pascal unit
#include <Uxlsbaseclientdata.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsclientdata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMsObj;
class PASCALIMPLEMENTATION TMsObj : public Uxlsbaseclientdata::TBaseClientData
{
	typedef Uxlsbaseclientdata::TBaseClientData inherited;
	
private:
	Uxlsotherrecords::TObjRecord* FObjRecord;
	Uxlssheet::TFlxChart* FChart;
	Uxlsbaserecords::TBaseRecord* FImData;
	bool HasPictFmla;
	bool __fastcall Get_IsAutoFilter(void);
	
protected:
	virtual System::Word __fastcall GetId(void);
	virtual void __fastcall SetId(const System::Word Value);
	void __fastcall ScanRecord(Uxlsbaserecords::TBaseRecord* myRecord);
	
public:
	virtual void __fastcall ArrangeId(System::Word &MaxId);
	__fastcall TMsObj(void);
	__fastcall TMsObj(System::Word &MaxId, System::Byte const *data, const int data_Size);
	__classmethod TMsObj* __fastcall CreateEmptyImg(System::Word &MaxId);
	__classmethod TMsObj* __fastcall CreateEmptyNote(System::Word &MaxId);
	__classmethod TMsObj* __fastcall CreateEmptyAutoFilter(System::Word &MaxId);
	__fastcall virtual ~TMsObj(void);
	virtual void __fastcall Clear(void);
	virtual Uxlsbaseclientdata::TBaseClientData* __fastcall CopyTo(void);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsbaserecords::TBaseRecord* First, const Uxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual __int64 __fastcall TotalSize(void);
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOfs, const int ColOfs);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
	__classmethod virtual Uxlsbaserecords::ClassOfTBaseRecord __fastcall ObjRecord();
	__property bool IsAutoFilter = {read=Get_IsAutoFilter, nodefault};
};


class DELPHICLASS TTXO;
class PASCALIMPLEMENTATION TTXO : public Uxlsbaseclientdata::TBaseClientData
{
	typedef Uxlsbaseclientdata::TBaseClientData inherited;
	
private:
	Uxlsotherrecords::TTXORecord* FTXO;
	System::UnicodeString __fastcall GetValue();
	void __fastcall SetValue(const System::UnicodeString aValue);
	void __fastcall ScanRecord(System::UnicodeString &Value, Uflxmessages::TRTFRunList &RTFRuns);
	
public:
	__fastcall TTXO(void);
	__fastcall TTXO(const int Dummy);
	__fastcall virtual ~TTXO(void);
	virtual void __fastcall Clear(void);
	virtual Uxlsbaseclientdata::TBaseClientData* __fastcall CopyTo(void);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsbaserecords::TBaseRecord* First, const Uxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual __int64 __fastcall TotalSize(void);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
	__classmethod virtual Uxlsbaserecords::ClassOfTBaseRecord __fastcall ObjRecord();
	__property System::UnicodeString Value = {read=GetValue, write=SetValue};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsclientdata */
using namespace Uxlsclientdata;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsclientdataHPP
