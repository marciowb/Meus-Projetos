// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflexcelreportnodb.pas' rev: 11.00

#ifndef UflexcelreportnodbHPP
#define UflexcelreportnodbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Ucustomflexcelreport.hpp>	// Pascal unit
#include <Uxlsdb.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uflxfulldatasets.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelreportnodb
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlexCelReportNoDB;
class PASCALIMPLEMENTATION TFlexCelReportNoDB : public Ucustomflexcelreport::TCustomFlexCelReport 
{
	typedef Ucustomflexcelreport::TCustomFlexCelReport inherited;
	
private:
	Classes::TComponent* FDataModule;
	Classes::TComponent* FPagesDataSet;
	void __fastcall SetPagesDataSet(const Classes::TComponent* Value);
	void __fastcall SetDataModule(const Classes::TComponent* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual Uxlsdb::_di_IXlsDataSet __fastcall GetPagesDataSet();
	virtual Uxlsdb::_di_IXlsDataSet __fastcall GetDataSet(const AnsiString DataSetName);
	__fastcall virtual TFlexCelReportNoDB(Classes::TComponent* AOwner);
	__fastcall virtual ~TFlexCelReportNoDB(void);
	virtual Classes::TComponent* __fastcall DesignDataModule(void);
	
__published:
	__property Classes::TComponent* DataModule = {read=FDataModule, write=SetDataModule};
	__property Classes::TComponent* PagesDataSet = {read=FPagesDataSet, write=SetPagesDataSet};
};


typedef TMetaClass* ClassOfTFlexCelReportNoDB;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelreportnodb */
using namespace Uflexcelreportnodb;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflexcelreportnodb
