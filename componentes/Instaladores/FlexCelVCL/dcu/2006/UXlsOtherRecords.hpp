// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsotherrecords.pas' rev: 10.00

#ifndef UxlsotherrecordsHPP
#define UxlsotherrecordsHPP

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
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsstrings.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsotherrecords
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBOFRecord;
class PASCALIMPLEMENTATION TBOFRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	Word __fastcall GetBOFType(void);
	
public:
	__property Word BOFType = {read=GetBOFType, nodefault};
	__fastcall virtual TBOFRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBOFRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEOFRecord;
class PASCALIMPLEMENTATION TEOFRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TEOFRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TEOFRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TTemplateRecord;
class PASCALIMPLEMENTATION TTemplateRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	/*         class method */ static void __fastcall SaveNewRecord(TMetaClass* vmt, const Uole2impl::TOle2File* Workbook);
	/*         class method */ static int __fastcall GetSize(TMetaClass* vmt, const bool HasTemplate);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TTemplateRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TTemplateRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TObjRecord;
class PASCALIMPLEMENTATION TObjRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	Word ObjId;
	Word CmoId;
	__fastcall virtual TObjRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TObjRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TTXORecord;
class PASCALIMPLEMENTATION TTXORecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	__fastcall TTXORecord(void);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TTXORecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TTXORecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSSTRecord;
class PASCALIMPLEMENTATION TSSTRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	unsigned Count;
	__fastcall virtual TSSTRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSSTRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBoundSheetRecord;
class PASCALIMPLEMENTATION TBoundSheetRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	WideString __fastcall GetSheetName();
	void __fastcall SetSheetName(const WideString Value);
	Word __fastcall GetOptionFlags(void);
	void __fastcall SetOptionFlags(const Word Value);
	
public:
	__property Word OptionFlags = {read=GetOptionFlags, write=SetOptionFlags, nodefault};
	__property WideString SheetName = {read=GetSheetName, write=SetSheetName};
	__fastcall TBoundSheetRecord(const Word aOptionFlags, const WideString aName);
	void __fastcall SetOffset(unsigned aOffset);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TBoundSheetRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBoundSheetRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCodeNameRecord;
class PASCALIMPLEMENTATION TCodeNameRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	WideString __fastcall GetSheetName();
	void __fastcall SetSheetName(const WideString Value);
	
public:
	__property WideString SheetName = {read=GetSheetName, write=SetSheetName};
	__fastcall TCodeNameRecord(const WideString aName);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TCodeNameRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCodeNameRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TObProjRecord;
class PASCALIMPLEMENTATION TObProjRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TObProjRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TObProjRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRangeRecord;
class PASCALIMPLEMENTATION TRangeRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TRangeRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRangeRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCellMergingRecord;
class PASCALIMPLEMENTATION TCellMergingRecord : public TRangeRecord 
{
	typedef TRangeRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TCellMergingRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TRangeRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCellMergingRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDValRecord;
class PASCALIMPLEMENTATION TDValRecord : public TRangeRecord 
{
	typedef TRangeRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TDValRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TRangeRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDValRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TGutsRecord;
class PASCALIMPLEMENTATION TGutsRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	int __fastcall GetColLevel(void);
	int __fastcall GetRowLevel(void);
	void __fastcall SetColLevel(const int Value);
	void __fastcall SetRowLevel(const int Value);
	
public:
	bool RecalcNeeded;
	__fastcall virtual TGutsRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__property int RowLevel = {read=GetRowLevel, write=SetRowLevel, nodefault};
	__property int ColLevel = {read=GetColLevel, write=SetColLevel, nodefault};
	virtual Uxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TGutsRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TPaneRecord;
class PASCALIMPLEMENTATION TPaneRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	int __fastcall Get_RowSplit(void);
	void __fastcall Set_RowSplit(const int value);
	int __fastcall Get_ColSplit(void);
	void __fastcall Set_ColSplit(const int value);
	int __fastcall Get_FirstVisibleRow(void);
	void __fastcall Set_FirstVisibleRow(const int value);
	int __fastcall Get_FirstVisibleCol(void);
	void __fastcall Set_FirstVisibleCol(const int value);
	int __fastcall Get_ActivePane(void);
	void __fastcall Set_ActivePane(const int value);
	
public:
	void __fastcall EnsureSelectedVisible(void);
	__property int RowSplit = {read=Get_RowSplit, write=Set_RowSplit, nodefault};
	__property int ColSplit = {read=Get_ColSplit, write=Set_ColSplit, nodefault};
	__property int FirstVisibleRow = {read=Get_FirstVisibleRow, write=Set_FirstVisibleRow, nodefault};
	__property int FirstVisibleCol = {read=Get_FirstVisibleCol, write=Set_FirstVisibleCol, nodefault};
	__property int ActivePane = {read=Get_ActivePane, write=Set_ActivePane, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TPaneRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPaneRecord(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsotherrecords */
using namespace Uxlsotherrecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsotherrecords
