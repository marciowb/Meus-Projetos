// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlssections.pas' rev: 21.00

#ifndef TmsuxlssectionsHPP
#define TmsuxlssectionsHPP

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
#include <Tmsuxlssst.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlssections
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseSection;
class PASCALIMPLEMENTATION TBaseSection : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Tmsuxlsotherrecords::TBOFRecord* FBOF;
	Tmsuxlsotherrecords::TEOFRecord* FEOF;
	
protected:
	__property Tmsuxlsotherrecords::TBOFRecord* sBOF = {read=FBOF, write=FBOF};
	__property Tmsuxlsotherrecords::TEOFRecord* sEOF = {read=FEOF, write=FEOF};
	
public:
	__fastcall TBaseSection(void);
	__fastcall virtual ~TBaseSection(void);
	virtual void __fastcall Clear(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Tmsuflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader, const Tmsuxlsotherrecords::TBOFRecord* First, const Tmsuxlssst::TSST* SST) = 0 ;
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream) = 0 ;
	virtual void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const int SheetIndex, const Tmsuflxmessages::TXlsCellRange &CellRange) = 0 ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlssections */
using namespace Tmsuxlssections;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlssectionsHPP
