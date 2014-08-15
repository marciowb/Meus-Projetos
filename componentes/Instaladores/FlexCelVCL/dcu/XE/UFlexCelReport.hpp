// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlexCelReport.pas' rev: 22.00

#ifndef UflexcelreportHPP
#define UflexcelreportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <UCustomFlexCelReport.hpp>	// Pascal unit
#include <UXlsDB.hpp>	// Pascal unit
#include <UXlsTDataSet.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <UExcelAdapter.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UFlxFullDataSets.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelreport
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TCalcRecordCount { cr_None, cr_Count, cr_SlowCount };
#pragma option pop

typedef void __fastcall (__closure *TRecordCountEvent)(System::TObject* Sender, const Db::TDataSet* DataSet, int &RecordCount);

class DELPHICLASS TFlexCelReport;
class PASCALIMPLEMENTATION TFlexCelReport : public Ucustomflexcelreport::TCustomFlexCelReport
{
	typedef Ucustomflexcelreport::TCustomFlexCelReport inherited;
	
private:
	Classes::TComponent* FDataModule;
	TCalcRecordCount FCalcRecordCount;
	Classes::TComponent* FPagesDataSet;
	TRecordCountEvent FOnRecordCount;
	void __fastcall SetPagesDataSet(const Classes::TComponent* Value);
	void __fastcall SetOnRecordCount(const TRecordCountEvent Value);
	void __fastcall SetDataModule(const Classes::TComponent* Value);
	int __fastcall RecordCount(const Db::TDataSet* DbSet);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual Uxlsdb::_di_IXlsDataSet __fastcall GetPagesDataSet(void);
	virtual Uxlsdb::_di_IXlsDataSet __fastcall GetDataSet(const System::UnicodeString DataSetName);
	__fastcall virtual TFlexCelReport(Classes::TComponent* AOwner);
	__fastcall virtual ~TFlexCelReport(void);
	virtual Classes::TComponent* __fastcall DesignDataModule(void);
	
__published:
	__property Classes::TComponent* DataModule = {read=FDataModule, write=SetDataModule};
	__property TCalcRecordCount CalcRecordCount = {read=FCalcRecordCount, write=FCalcRecordCount, default=1};
	__property Classes::TComponent* PagesDataSet = {read=FPagesDataSet, write=SetPagesDataSet};
	__property TRecordCountEvent OnRecordCount = {read=FOnRecordCount, write=SetOnRecordCount};
};


typedef TMetaClass* ClassOfTFlexCelReport;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelreport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflexcelreport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflexcelreportHPP
