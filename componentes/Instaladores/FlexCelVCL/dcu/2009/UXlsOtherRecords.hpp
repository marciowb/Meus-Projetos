// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsotherrecords.pas' rev: 20.00

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
	System::Word __fastcall GetBOFType(void);
	
public:
	__property System::Word BOFType = {read=GetBOFType, nodefault};
	__fastcall virtual TBOFRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBOFRecord(void) { }
	
};


class DELPHICLASS TEOFRecord;
class PASCALIMPLEMENTATION TEOFRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TEOFRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TEOFRecord(void) { }
	
};


class DELPHICLASS TTemplateRecord;
class PASCALIMPLEMENTATION TTemplateRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	__classmethod void __fastcall SaveNewRecord(const Uole2impl::TOle2File* Workbook);
	__classmethod int __fastcall GetSize(const bool HasTemplate);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TTemplateRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TTemplateRecord(void) { }
	
};


class DELPHICLASS TObjRecord;
class PASCALIMPLEMENTATION TObjRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	System::Word ObjId;
	System::Word CmoId;
	__fastcall virtual TObjRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TObjRecord(void) { }
	
};


class DELPHICLASS TTXORecord;
class PASCALIMPLEMENTATION TTXORecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	__fastcall TTXORecord(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TTXORecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TTXORecord(void) { }
	
};


class DELPHICLASS TSSTRecord;
class PASCALIMPLEMENTATION TSSTRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	unsigned Count;
	__fastcall virtual TSSTRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TSSTRecord(void) { }
	
};


class DELPHICLASS TBoundSheetRecord;
class PASCALIMPLEMENTATION TBoundSheetRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	System::UnicodeString __fastcall GetSheetName();
	void __fastcall SetSheetName(const System::UnicodeString Value);
	System::Word __fastcall GetOptionFlags(void);
	void __fastcall SetOptionFlags(const System::Word Value);
	
public:
	__property System::Word OptionFlags = {read=GetOptionFlags, write=SetOptionFlags, nodefault};
	__property System::UnicodeString SheetName = {read=GetSheetName, write=SetSheetName};
	__fastcall TBoundSheetRecord(const System::Word aOptionFlags, const System::UnicodeString aName);
	void __fastcall SetOffset(unsigned aOffset);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TBoundSheetRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBoundSheetRecord(void) { }
	
};


class DELPHICLASS TCodeNameRecord;
class PASCALIMPLEMENTATION TCodeNameRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	System::UnicodeString __fastcall GetSheetName();
	void __fastcall SetSheetName(const System::UnicodeString Value);
	
public:
	__property System::UnicodeString SheetName = {read=GetSheetName, write=SetSheetName};
	__fastcall TCodeNameRecord(const System::UnicodeString aName);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TCodeNameRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCodeNameRecord(void) { }
	
};


class DELPHICLASS TObProjRecord;
class PASCALIMPLEMENTATION TObProjRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TObProjRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TObProjRecord(void) { }
	
};


class DELPHICLASS TRangeRecord;
class PASCALIMPLEMENTATION TRangeRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TRangeRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRangeRecord(void) { }
	
};


class DELPHICLASS TCellMergingRecord;
class PASCALIMPLEMENTATION TCellMergingRecord : public TRangeRecord
{
	typedef TRangeRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TCellMergingRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TRangeRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCellMergingRecord(void) { }
	
};


class DELPHICLASS TDValRecord;
class PASCALIMPLEMENTATION TDValRecord : public TRangeRecord
{
	typedef TRangeRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDValRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : TRangeRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDValRecord(void) { }
	
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
	__fastcall virtual TGutsRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__property int RowLevel = {read=GetRowLevel, write=SetRowLevel, nodefault};
	__property int ColLevel = {read=GetColLevel, write=SetColLevel, nodefault};
	virtual Uxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TGutsRecord(void) { }
	
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
	/* TBaseRecord.Create */ inline __fastcall virtual TPaneRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TPaneRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsotherrecords */
using namespace Uxlsotherrecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsotherrecordsHPP
