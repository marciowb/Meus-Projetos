// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlssst.pas' rev: 20.00

#ifndef UxlssstHPP
#define UxlssstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsotherrecords.hpp>	// Pascal unit
#include <Uxlsstrings.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Generics.collections.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit
#include <Generics.defaults.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlssst
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TExtraData
{
	
public:
	System::Word Refs;
	unsigned AbsStreamPos;
	System::Word RecordStreamPos;
	unsigned PosInTable;
};
#pragma pack(pop)


typedef TExtraData *PExtraData;

typedef int TiSSTEntry;

typedef Xlsmessages::PArrayOfByte PiSSTEntry;

struct TMemSST
{
	
private:
	typedef DynamicArray<System::Byte> _TMemSST__1;
	
	
public:
	int UsedSize;
	_TMemSST__1 Buffer;
};


class DELPHICLASS TSST;
class PASCALIMPLEMENTATION TSST : public Generics_collections::TList__1<int>
{
	typedef Generics_collections::TList__1<int> inherited;
	
private:
	TMemSST MemSST;
	void __fastcall QuickSort(int L, int R);
	__int64 __fastcall SSTRecordSize(void);
	__int64 __fastcall ExtSSTRecordSize(void);
	
public:
	__fastcall TSST(void);
	bool __fastcall Find(const Xlsmessages::PArrayOfByte s, int &Index);
	void __fastcall Load(const Uxlsotherrecords::TSSTRecord* aSSTRecord);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall WriteExtSST(const Uole2impl::TOle2File* DataStream);
	int __fastcall AddString(const System::UnicodeString s, const Uflxmessages::TRTFRunList RTFRuns);
	HIDESBASE void __fastcall Sort(void);
	__int64 __fastcall TotalSize(void);
	void __fastcall FixRefs(void);
	Xlsmessages::PArrayOfByte __fastcall GetEntry(const int aEntry);
public:
	/* TList<Integer>.Destroy */ inline __fastcall virtual ~TSST(void) { }
	
};


class DELPHICLASS TLabelSSTRecord;
class PASCALIMPLEMENTATION TLabelSSTRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
private:
	int pSSTEntry;
	TSST* SST;
	System::UnicodeString __fastcall GetAsString();
	void __fastcall SetAsString(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetAsRTF();
	void __fastcall SetAsRTF(const System::UnicodeString Value);
	Uflxmessages::TRichString __fastcall GetAsRichString();
	void __fastcall SetAsRichString(const Uflxmessages::TRichString &Value);
	
protected:
	virtual System::Variant __fastcall GetValue();
	virtual void __fastcall SetValue(const System::Variant &Value);
	virtual Uxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TLabelSSTRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TLabelSSTRecord(const System::Word aRow, const System::Word aCol, const System::Word aXF, const TSST* aSST);
	void __fastcall AttachToSST(const TSST* aSST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
	__fastcall virtual ~TLabelSSTRecord(void);
	__property System::UnicodeString AsString = {read=GetAsString, write=SetAsString};
	__property Uflxmessages::TRichString AsRichString = {read=GetAsRichString, write=SetAsRichString};
	__property System::UnicodeString AsRTF = {read=GetAsRTF, write=SetAsRTF};
};


class DELPHICLASS TLabelRecord;
class PASCALIMPLEMENTATION TLabelRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
public:
	virtual System::Variant __fastcall GetValue();
public:
	/* TCellRecord.CreateFromData */ inline __fastcall TLabelRecord(const System::Word aId, const System::Word aDataSize, const System::Word aRow, const System::Word aCol, const System::Word aXF) : Uxlsbaserecords::TCellRecord(aId, aDataSize, aRow, aCol, aXF) { }
	
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TLabelRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TLabelRecord(void) { }
	
};


class DELPHICLASS TRStringRecord;
class PASCALIMPLEMENTATION TRStringRecord : public Uxlsbaserecords::TCellRecord
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
private:
	Uflxmessages::TRichString __fastcall GetAsRichString();
	
public:
	virtual System::Variant __fastcall GetValue();
	__property Uflxmessages::TRichString AsRichString = {read=GetAsRichString};
public:
	/* TCellRecord.CreateFromData */ inline __fastcall TRStringRecord(const System::Word aId, const System::Word aDataSize, const System::Word aRow, const System::Word aCol, const System::Word aXF) : Uxlsbaserecords::TCellRecord(aId, aDataSize, aRow, aCol, aXF) { }
	
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TRStringRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRStringRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlssst */
using namespace Uxlssst;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlssstHPP
