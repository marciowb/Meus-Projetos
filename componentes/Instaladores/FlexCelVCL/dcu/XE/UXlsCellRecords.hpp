// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsCellRecords.pas' rev: 22.00

#ifndef UxlscellrecordsHPP
#define UxlscellrecordsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <UOle2Impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlscellrecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBlankRecord;
class PASCALIMPLEMENTATION TBlankRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
public:
	__fastcall TBlankRecord(const System::Word aRow, const System::Word aCol, const System::Word aXF);
	virtual bool __fastcall CanJoinNext(const Uxlsbaserecords::TCellRecord* NextRecord, const int MaxCol);
	virtual void __fastcall SaveFirstMul(const Uole2impl::TOle2File* Workbook, const System::Word JoinedRecordSize);
	virtual void __fastcall SaveMidMul(const Uole2impl::TOle2File* Workbook);
	virtual void __fastcall SaveLastMul(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSizeFirst(void);
	virtual int __fastcall TotalSizeMid(void);
	virtual int __fastcall TotalSizeLast(void);
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TBlankRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBlankRecord(void) { }
	
};


class DELPHICLASS TBoolErrRecord;
class PASCALIMPLEMENTATION TBoolErrRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
protected:
	virtual System::Variant __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::Variant &Value);
	System::UnicodeString __fastcall ErrcodeToString(const int ErrCode);
	int __fastcall StringToErrcode(const System::UnicodeString ErrStr);
	
public:
	__fastcall TBoolErrRecord(const System::Word aRow, const System::Word aCol, const System::Word aXF);
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TBoolErrRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBoolErrRecord(void) { }
	
};


class DELPHICLASS TNumberRecord;
class PASCALIMPLEMENTATION TNumberRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
protected:
	virtual System::Variant __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::Variant &Value);
	
public:
	__fastcall TNumberRecord(const System::Word aRow, const System::Word aCol, const System::Word aXF);
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TNumberRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TNumberRecord(void) { }
	
};


class DELPHICLASS TRKRecord;
class PASCALIMPLEMENTATION TRKRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
protected:
	virtual System::Variant __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::Variant &Value);
	
public:
	__fastcall TRKRecord(const System::Word aRow, const System::Word aCol, const System::Word aXF);
	virtual bool __fastcall CanJoinNext(const Uxlsbaserecords::TCellRecord* NextRecord, const int MaxCol);
	virtual void __fastcall SaveFirstMul(const Uole2impl::TOle2File* Workbook, const System::Word JoinedRecordSize);
	virtual void __fastcall SaveMidMul(const Uole2impl::TOle2File* Workbook);
	virtual void __fastcall SaveLastMul(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSizeFirst(void);
	virtual int __fastcall TotalSizeMid(void);
	virtual int __fastcall TotalSizeLast(void);
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TRKRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRKRecord(void) { }
	
};


class DELPHICLASS TMultipleValueRecord;
class PASCALIMPLEMENTATION TMultipleValueRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	virtual bool __fastcall Eof(void) = 0 ;
	virtual Uxlsbaserecords::TCellRecord* __fastcall ExtractOneRecord(void) = 0 ;
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TMultipleValueRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMultipleValueRecord(void) { }
	
};


class DELPHICLASS TMulBlankRecord;
class PASCALIMPLEMENTATION TMulBlankRecord : public TMultipleValueRecord
{
	typedef TMultipleValueRecord inherited;
	
private:
	int CurrentCol;
	
public:
	virtual bool __fastcall Eof(void);
	virtual Uxlsbaserecords::TCellRecord* __fastcall ExtractOneRecord(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TMulBlankRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TMultipleValueRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMulBlankRecord(void) { }
	
};


class DELPHICLASS TMulRKRecord;
class PASCALIMPLEMENTATION TMulRKRecord : public TMultipleValueRecord
{
	typedef TMultipleValueRecord inherited;
	
private:
	int CurrentCol;
	
public:
	virtual bool __fastcall Eof(void);
	virtual Uxlsbaserecords::TCellRecord* __fastcall ExtractOneRecord(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TMulRKRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TMultipleValueRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMulRKRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall EncodeRK(const double Value, /* out */ int &RK);
extern PACKAGE bool __fastcall IsRK(const double Value);

}	/* namespace Uxlscellrecords */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlscellrecords;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlscellrecordsHPP
