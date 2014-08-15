// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlssections.pas' rev: 20.00

#ifndef UxlssectionsHPP
#define UxlssectionsHPP

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
#include <Uxlssst.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

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
using namespace Uxlssections;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlssectionsHPP
