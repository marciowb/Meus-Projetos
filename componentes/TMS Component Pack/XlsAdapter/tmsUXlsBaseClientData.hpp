// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsbaseclientdata.pas' rev: 21.00

#ifndef TmsuxlsbaseclientdataHPP
#define TmsuxlsbaseclientdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlssst.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsbaseclientdata
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
	Tmsuxlsbaserecords::TBaseRecord* RemainingData;
	__property System::Word Id = {read=GetId, write=SetId, nodefault};
	virtual void __fastcall ArrangeId(System::Word &MaxId);
	virtual void __fastcall Clear(void) = 0 ;
	virtual TBaseClientData* __fastcall CopyTo(void) = 0 ;
	virtual void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader, const Tmsuxlsbaserecords::TBaseRecord* First, const Tmsuxlssst::TSST* SST) = 0 ;
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream) = 0 ;
	virtual __int64 __fastcall TotalSize(void) = 0 ;
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOfs, const int ColOfs);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo) = 0 ;
	virtual void __fastcall ArrangeCopySheet(const Tmsxlsmessages::TSheetInfo &SheetInfo) = 0 ;
	__classmethod virtual Tmsuxlsbaserecords::ClassOfTBaseRecord __fastcall ObjRecord();
public:
	/* TObject.Create */ inline __fastcall TBaseClientData(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TBaseClientData(void) { }
	
};


typedef TMetaClass* ClassOfTBaseClientData;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsbaseclientdata */
using namespace Tmsuxlsbaseclientdata;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsbaseclientdataHPP
