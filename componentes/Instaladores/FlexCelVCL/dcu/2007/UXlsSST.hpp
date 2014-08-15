// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlssst.pas' rev: 11.00

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
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlssst
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TExtraData
{
	
public:
	Word Refs;
	unsigned AbsStreamPos;
	Word RecordStreamPos;
	unsigned PosInTable;
} ;
#pragma pack(pop)

typedef TExtraData *PExtraData;

typedef int TiSSTEntry;

typedef Xlsmessages::ArrayOfByte *PiSSTEntry;

typedef DynamicArray<Byte >  UXlsSST__1;

#pragma pack(push,4)
struct TMemSST
{
	
public:
	int UsedSize;
	DynamicArray<Byte >  Buffer;
} ;
#pragma pack(pop)

class DELPHICLASS TSST;
class PASCALIMPLEMENTATION TSST : public Classes::TList 
{
	typedef Classes::TList inherited;
	
public:
	int operator[](int index) { return Items[index]; }
	
private:
	int __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const int Value);
	
public:
	__property int Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(int aRecord);
	HIDESBASE void __fastcall Insert(int Index, int aRecord);
	
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
	int __fastcall AddString(const WideString s, const Uflxmessages::TRTFRunList RTFRuns);
	HIDESBASE void __fastcall Sort(void);
	__int64 __fastcall TotalSize(void);
	void __fastcall FixRefs(void);
	Xlsmessages::PArrayOfByte __fastcall GetEntry(const int aEntry);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TSST(void) { }
	#pragma option pop
	
};


class DELPHICLASS TLabelSSTRecord;
class PASCALIMPLEMENTATION TLabelSSTRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
private:
	int pSSTEntry;
	TSST* SST;
	WideString __fastcall GetAsString();
	void __fastcall SetAsString(const WideString Value);
	WideString __fastcall GetAsRTF();
	void __fastcall SetAsRTF(const WideString Value);
	Uflxmessages::TRichString __fastcall GetAsRichString();
	void __fastcall SetAsRichString(const Uflxmessages::TRichString &Value);
	
protected:
	virtual Variant __fastcall GetValue();
	virtual void __fastcall SetValue(const Variant &Value);
	virtual Uxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TLabelSSTRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TLabelSSTRecord(const Word aRow, const Word aCol, const Word aXF, const TSST* aSST);
	void __fastcall AttachToSST(const TSST* aSST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
	__fastcall virtual ~TLabelSSTRecord(void);
	__property WideString AsString = {read=GetAsString, write=SetAsString};
	__property Uflxmessages::TRichString AsRichString = {read=GetAsRichString, write=SetAsRichString};
	__property WideString AsRTF = {read=GetAsRTF, write=SetAsRTF};
};


class DELPHICLASS TLabelRecord;
class PASCALIMPLEMENTATION TLabelRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
public:
	virtual Variant __fastcall GetValue();
public:
	#pragma option push -w-inl
	/* TCellRecord.CreateFromData */ inline __fastcall TLabelRecord(const Word aId, const Word aDataSize, const Word aRow, const Word aCol, const Word aXF) : Uxlsbaserecords::TCellRecord(aId, aDataSize, aRow, aCol, aXF) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TLabelRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TLabelRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRStringRecord;
class PASCALIMPLEMENTATION TRStringRecord : public Uxlsbaserecords::TCellRecord 
{
	typedef Uxlsbaserecords::TCellRecord inherited;
	
private:
	Uflxmessages::TRichString __fastcall GetAsRichString();
	
public:
	virtual Variant __fastcall GetValue();
	__property Uflxmessages::TRichString AsRichString = {read=GetAsRichString};
public:
	#pragma option push -w-inl
	/* TCellRecord.CreateFromData */ inline __fastcall TRStringRecord(const Word aId, const Word aDataSize, const Word aRow, const Word aCol, const Word aXF) : Uxlsbaserecords::TCellRecord(aId, aDataSize, aRow, aCol, aXF) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TRStringRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TCellRecord(aId, aData, aDataSize) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TRStringRecord(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlssst */
using namespace Uxlssst;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlssst
