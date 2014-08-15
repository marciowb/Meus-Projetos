// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsbaseclientdata.pas' rev: 11.00

#ifndef UxlsbaseclientdataHPP
#define UxlsbaseclientdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlssst.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsbaseclientdata
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseClientData;
class PASCALIMPLEMENTATION TBaseClientData : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	virtual Word __fastcall GetId(void);
	virtual void __fastcall SetId(const Word Value);
	
public:
	Uxlsbaserecords::TBaseRecord* RemainingData;
	__property Word Id = {read=GetId, write=SetId, nodefault};
	virtual void __fastcall ArrangeId(Word &MaxId);
	virtual void __fastcall Clear(void) = 0 ;
	virtual TBaseClientData* __fastcall CopyTo(void) = 0 ;
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsbaserecords::TBaseRecord* First, const Uxlssst::TSST* SST) = 0 ;
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream) = 0 ;
	virtual __int64 __fastcall TotalSize(void) = 0 ;
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOfs, const int ColOfs);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo) = 0 ;
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo) = 0 ;
	/* virtual class method */ virtual TMetaClass* __fastcall ObjRecord(TMetaClass* vmt);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TBaseClientData(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TBaseClientData(void) { }
	#pragma option pop
	
};


typedef TMetaClass* ClassOfTBaseClientData;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsbaseclientdata */
using namespace Uxlsbaseclientdata;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsbaseclientdata
