// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlscellrecords.pas' rev: 10.00

#ifndef UxlscellrecordsHPP
#define UxlscellrecordsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlscellrecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBlankRecord;
class PASCALIMPLEMENTATION TBlankRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
public:
	__fastcall TBlankRecord(const Word aRow, const Word aCol, const Word aXF);
	virtual bool __fastcall CanJoinNext(const Uxlsbaserecords::TCellRecord* NextRecord, const int MaxCol);
	virtual void __fastcall SaveFirstMul(const Uole2impl::TOle2File* Workbook, const Word JoinedRecordSize);
	virtual void __fastcall SaveMidMul(const Uole2impl::TOle2File* Workbook);
	virtual void __fastcall SaveLastMul(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSizeFirst(void);
	virtual int __fastcall TotalSizeMid(void);
	virtual int __fastcall TotalSizeLast(void);
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TBlankRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBlankRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBoolErrRecord;
class PASCALIMPLEMENTATION TBoolErrRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
protected:
	virtual Variant __fastcall GetValue();
	virtual void __fastcall SetValue(const Variant &Value);
	WideString __fastcall ErrcodeToString(const int ErrCode);
	int __fastcall StringToErrcode(const WideString ErrStr);
	
public:
	__fastcall TBoolErrRecord(const Word aRow, const Word aCol, const Word aXF);
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TBoolErrRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBoolErrRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TNumberRecord;
class PASCALIMPLEMENTATION TNumberRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
protected:
	virtual Variant __fastcall GetValue();
	virtual void __fastcall SetValue(const Variant &Value);
	
public:
	__fastcall TNumberRecord(const Word aRow, const Word aCol, const Word aXF);
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TNumberRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TNumberRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRKRecord;
class PASCALIMPLEMENTATION TRKRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
protected:
	virtual Variant __fastcall GetValue();
	virtual void __fastcall SetValue(const Variant &Value);
	
public:
	__fastcall TRKRecord(const Word aRow, const Word aCol, const Word aXF);
	virtual bool __fastcall CanJoinNext(const Uxlsbaserecords::TCellRecord* NextRecord, const int MaxCol);
	virtual void __fastcall SaveFirstMul(const Uole2impl::TOle2File* Workbook, const Word JoinedRecordSize);
	virtual void __fastcall SaveMidMul(const Uole2impl::TOle2File* Workbook);
	virtual void __fastcall SaveLastMul(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSizeFirst(void);
	virtual int __fastcall TotalSizeMid(void);
	virtual int __fastcall TotalSizeLast(void);
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TRKRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRKRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMultipleValueRecord;
class PASCALIMPLEMENTATION TMultipleValueRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	virtual bool __fastcall Eof(void) = 0 ;
	virtual Uxlsbaserecords::TCellRecord* __fastcall ExtractOneRecord(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TMultipleValueRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMultipleValueRecord(void) { }
	#pragma option pop
	
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
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TMulBlankRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TMultipleValueRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMulBlankRecord(void) { }
	#pragma option pop
	
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
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TMulRKRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TMultipleValueRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TMulRKRecord(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall EncodeRK(const double Value, /* out */ int &RK);
extern PACKAGE bool __fastcall IsRK(const double Value);

}	/* namespace Uxlscellrecords */
using namespace Uxlscellrecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlscellrecords
