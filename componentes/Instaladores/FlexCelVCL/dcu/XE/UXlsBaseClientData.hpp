// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsBaseClientData.pas' rev: 22.00

#ifndef UxlsbaseclientdataHPP
#define UxlsbaseclientdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <UXlsSST.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UOle2Impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsbaseclientdata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseClientData;
class PASCALIMPLEMENTATION TBaseClientData : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual System::Word __fastcall GetId(void);
	virtual void __fastcall SetId(const System::Word Value);
	
public:
	Uxlsbaserecords::TBaseRecord* RemainingData;
	__property System::Word Id = {read=GetId, write=SetId, nodefault};
	virtual void __fastcall ArrangeId(System::Word &MaxId);
	virtual void __fastcall Clear(void) = 0 ;
	virtual TBaseClientData* __fastcall CopyTo(void) = 0 ;
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsbaserecords::TBaseRecord* First, const Uxlssst::TSST* SST) = 0 ;
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream) = 0 ;
	virtual __int64 __fastcall TotalSize(void) = 0 ;
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOfs, const int ColOfs);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo) = 0 ;
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo) = 0 ;
	__classmethod virtual Uxlsbaserecords::ClassOfTBaseRecord __fastcall ObjRecord();
public:
	/* TObject.Create */ inline __fastcall TBaseClientData(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TBaseClientData(void) { }
	
};


typedef TMetaClass* ClassOfTBaseClientData;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsbaseclientdata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlsbaseclientdata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsbaseclientdataHPP
