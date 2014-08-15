// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsDB.pas' rev: 22.00

#ifndef UxlsdbHPP
#define UxlsdbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsdb
{
//-- type declarations -------------------------------------------------------
typedef Classes::TComponent TFlxDataSet;

__interface IXlsField;
typedef System::DelphiInterface<IXlsField> _di_IXlsField;
__interface  INTERFACE_UUID("{ACD0F8B5-596E-4C27-B383-8425BDB9051F}") IXlsField  : public System::IInterface 
{
	
public:
	virtual System::Variant __fastcall Value(void) = 0 ;
	virtual bool __fastcall IsTDateTimeField(void) = 0 ;
	virtual bool __fastcall IsTMemoField(void) = 0 ;
	virtual System::Extended __fastcall AsFloat(void) = 0 ;
	virtual bool __fastcall Visible(void) = 0 ;
	virtual System::UnicodeString __fastcall DisplayName(void) = 0 ;
};

__interface IXlsDataSet;
typedef System::DelphiInterface<IXlsDataSet> _di_IXlsDataSet;
__interface  INTERFACE_UUID("{35524AD4-16B3-4CCC-A69D-90CFC892003B}") IXlsDataSet  : public System::IInterface 
{
	
public:
	virtual _di_IXlsField __fastcall GetFields(int index) = 0 ;
	virtual bool __fastcall GetActive(void) = 0 ;
	virtual void __fastcall Open(void) = 0 ;
	virtual void __fastcall Close(void) = 0 ;
	__property bool Active = {read=GetActive};
	virtual int __fastcall RecordCount(void) = 0 ;
	virtual void __fastcall First(void) = 0 ;
	virtual void __fastcall Next(void) = 0 ;
	virtual void __fastcall Last(void) = 0 ;
	virtual bool __fastcall Eof(void) = 0 ;
	virtual System::UnicodeString __fastcall DsName(void) = 0 ;
	virtual _di_IXlsField __fastcall FieldByName(const System::UnicodeString Name) = 0 ;
	virtual int __fastcall FieldCount(void) = 0 ;
	virtual int __fastcall FieldVisibleCount(void) = 0 ;
	__property _di_IXlsField Fields[int index] = {read=GetFields};
};

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsdb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlsdb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsdbHPP
