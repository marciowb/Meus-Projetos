// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlssst.pas' rev: 21.00

#ifndef TmsuxlssstHPP
#define TmsuxlssstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsotherrecords.hpp>	// Pascal unit
#include <Tmsuxlsstrings.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Generics.collections.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit
#include <Generics.defaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlssst
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

typedef Tmsxlsmessages::PArrayOfByte PiSSTEntry;

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
	bool __fastcall Find(const Tmsxlsmessages::PArrayOfByte s, int &Index);
	void __fastcall Load(const Tmsuxlsotherrecords::TSSTRecord* aSSTRecord);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall WriteExtSST(const Tmsuole2impl::TOle2File* DataStream);
	int __fastcall AddString(const System::UnicodeString s, const Tmsuflxmessages::TRTFRunList RTFRuns);
	HIDESBASE void __fastcall Sort(void);
	__int64 __fastcall TotalSize(void);
	void __fastcall FixRefs(void);
	Tmsxlsmessages::PArrayOfByte __fastcall GetEntry(const int aEntry);
public:
	/* TList<Integer>.Destroy */ inline __fastcall virtual ~TSST(void) { }
	
};


class DELPHICLASS TLabelSSTRecord;
class PASCALIMPLEMENTATION TLabelSSTRecord : public Tmsuxlsbaserecords::TCellRecord
{
	typedef Tmsuxlsbaserecords::TCellRecord inherited;
	
private:
	int pSSTEntry;
	TSST* SST;
	System::UnicodeString __fastcall GetAsString(void);
	void __fastcall SetAsString(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetAsRTF(void);
	void __fastcall SetAsRTF(const System::UnicodeString Value);
	Tmsuflxmessages::TRichString __fastcall GetAsRichString(void);
	void __fastcall SetAsRichString(const Tmsuflxmessages::TRichString &Value);
	
protected:
	virtual System::Variant __fastcall GetValue(void);
	virtual void __fastcall SetValue(const System::Variant &Value);
	virtual Tmsuxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TLabelSSTRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TLabelSSTRecord(const System::Word aRow, const System::Word aCol, const System::Word aXF, const TSST* aSST);
	void __fastcall AttachToSST(const TSST* aSST);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
	__fastcall virtual ~TLabelSSTRecord(void);
	__property System::UnicodeString AsString = {read=GetAsString, write=SetAsString};
	__property Tmsuflxmessages::TRichString AsRichString = {read=GetAsRichString, write=SetAsRichString};
	__property System::UnicodeString AsRTF = {read=GetAsRTF, write=SetAsRTF};
};


class DELPHICLASS TLabelRecord;
class PASCALIMPLEMENTATION TLabelRecord : public Tmsuxlsbaserecords::TCellRecord
{
	typedef Tmsuxlsbaserecords::TCellRecord inherited;
	
public:
	virtual System::Variant __fastcall GetValue(void);
public:
	/* TCellRecord.CreateFromData */ inline __fastcall TLabelRecord(const System::Word aId, const System::Word aDataSize, const System::Word aRow, const System::Word aCol, const System::Word aXF) : Tmsuxlsbaserecords::TCellRecord(aId, aDataSize, aRow, aCol, aXF) { }
	
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TLabelRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TLabelRecord(void) { }
	
};


class DELPHICLASS TRStringRecord;
class PASCALIMPLEMENTATION TRStringRecord : public Tmsuxlsbaserecords::TCellRecord
{
	typedef Tmsuxlsbaserecords::TCellRecord inherited;
	
private:
	Tmsuflxmessages::TRichString __fastcall GetAsRichString(void);
	
public:
	virtual System::Variant __fastcall GetValue(void);
	__property Tmsuflxmessages::TRichString AsRichString = {read=GetAsRichString};
public:
	/* TCellRecord.CreateFromData */ inline __fastcall TRStringRecord(const System::Word aId, const System::Word aDataSize, const System::Word aRow, const System::Word aCol, const System::Word aXF) : Tmsuxlsbaserecords::TCellRecord(aId, aDataSize, aRow, aCol, aXF) { }
	
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TRStringRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRStringRecord(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlssst */
using namespace Tmsuxlssst;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlssstHPP
