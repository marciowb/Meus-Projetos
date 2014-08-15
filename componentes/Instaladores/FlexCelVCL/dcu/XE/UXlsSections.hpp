// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsSections.pas' rev: 22.00

#ifndef UxlssectionsHPP
#define UxlssectionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <UXlsBaseRecordLists.hpp>	// Pascal unit
#include <UXlsOtherRecords.hpp>	// Pascal unit
#include <UXlsSST.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UOle2Impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlssections
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseSection;
class PASCALIMPLEMENTATION TBaseSection : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Uxlsotherrecords::TBOFRecord* FBOF;
	Uxlsotherrecords::TEOFRecord* FEOF;
	
protected:
	__property Uxlsotherrecords::TBOFRecord* sBOF = {read=FBOF, write=FBOF};
	__property Uxlsotherrecords::TEOFRecord* sEOF = {read=FEOF, write=FEOF};
	
public:
	__fastcall TBaseSection(void);
	__fastcall virtual ~TBaseSection(void);
	virtual void __fastcall Clear(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TBOFRecord* First, const Uxlssst::TSST* SST) = 0 ;
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream) = 0 ;
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange) = 0 ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlssections */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlssections;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlssectionsHPP
