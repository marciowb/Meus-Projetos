// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsreferences.pas' rev: 21.00

#ifndef TmsuxlsreferencesHPP
#define TmsuxlsreferencesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsbaselist.hpp>	// Pascal unit
#include <Tmsuxlsstrings.hpp>	// Pascal unit
#include <Tmsxlsformulamessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsreferences
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExternNameRecord;
class PASCALIMPLEMENTATION TExternNameRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
public:
	System::UnicodeString __fastcall Name(void);
	System::Byte __fastcall NameLength(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TExternNameRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TExternNameRecord(void) { }
	
};


class DELPHICLASS TExternNameRecordList;
class PASCALIMPLEMENTATION TExternNameRecordList : public Tmsuxlsbaserecordlists::TBaseRecordList
{
	typedef Tmsuxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	/* TObjectList.Create */ inline __fastcall TExternNameRecordList(void)/* overload */ : Tmsuxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TExternNameRecordList(void) { }
	
};


class DELPHICLASS TSupBookRecord;
class PASCALIMPLEMENTATION TSupBookRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
private:
	TExternNameRecordList* FExternNameList;
	
public:
	bool __fastcall IsLocal(void);
	bool __fastcall IsAddIn(void);
	void __fastcall InsertSheets(const int SheetCount);
	System::UnicodeString __fastcall BookName(void);
	System::UnicodeString __fastcall SheetName(const int SheetIndex, const System::TObject* Globals);
	void __fastcall AddExternName(const TExternNameRecord* ExternNameRecord);
	
protected:
	virtual Tmsuxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TSupBookRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TSupBookRecord(const int SheetCount);
	__fastcall virtual ~TSupBookRecord(void);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSize(void);
	virtual int __fastcall TotalSizeNoHeaders(void);
};


class DELPHICLASS TExternSheetRecord;
class PASCALIMPLEMENTATION TExternSheetRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TExternSheetRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TExternSheetRecord(void) { }
	
};


class DELPHICLASS TExternRef;
class PASCALIMPLEMENTATION TExternRef : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Word SupBookRecord;
	System::Word FirstSheet;
	System::Word LastSheet;
	__fastcall TExternRef(const System::Word aSupBookRecord, const System::Word aFirstSheet, const System::Word aLastSheet);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TExternRef(void) { }
	
};


class DELPHICLASS TSupBookRecordList;
class PASCALIMPLEMENTATION TSupBookRecordList : public Tmsuxlsbaserecordlists::TBaseRecordList
{
	typedef Tmsuxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	TSupBookRecord* operator[](int index) { return Items[index]; }
	
private:
	TSupBookRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TSupBookRecord* Value);
	
public:
	__property TSupBookRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TSupBookRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TSupBookRecord* aRecord);
	HIDESBASE __int64 __fastcall TotalSize(void);
public:
	/* TObjectList.Create */ inline __fastcall TSupBookRecordList(void)/* overload */ : Tmsuxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSupBookRecordList(void) { }
	
};


class DELPHICLASS TExternRefList;
class PASCALIMPLEMENTATION TExternRefList : public Tmsuxlsbaselist::TBaseList
{
	typedef Tmsuxlsbaselist::TBaseList inherited;
	
public:
	TExternRef* operator[](int index) { return Items[index]; }
	
private:
	TExternRef* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TExternRef* Value);
	
public:
	__property TExternRef* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TExternRef* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TExternRef* aRecord);
	void __fastcall Load(const TExternSheetRecord* aRecord);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	__int64 __fastcall TotalSize(void);
	void __fastcall InsertSheets(const int BeforeSheet, const int SheetCount, int LocalSupBook);
public:
	/* TObjectList.Create */ inline __fastcall TExternRefList(void)/* overload */ : Tmsuxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TExternRefList(void) { }
	
};


class DELPHICLASS TReferences;
class PASCALIMPLEMENTATION TReferences : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TSupBookRecordList* FSupBooks;
	TExternRefList* FExternRefs;
	int LocalSupBook;
	
public:
	__fastcall TReferences(void);
	__fastcall virtual ~TReferences(void);
	__int64 __fastcall TotalSize(void);
	void __fastcall Clear(void);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall AddSupBook(const TSupBookRecord* aRecord);
	void __fastcall AddExternRef(const TExternSheetRecord* aRecord);
	void __fastcall AddExternName(const TExternNameRecord* aRecord);
	void __fastcall InsertSheets(const int BeforeSheet, const int SheetCount);
	int __fastcall GetSheet(const System::Word SheetRef);
	int __fastcall SetSheet(const System::Word Sheet);
	int __fastcall AddSheet(int SheetCount, int FirstSheet, int LastSheet);
	System::UnicodeString __fastcall GetSheetName(const System::Word SheetRef, const System::TObject* Globals);
	System::UnicodeString __fastcall GetName(const int SheetRef, const int NameIndex, const System::TObject* Globals);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsreferences */
using namespace Tmsuxlsreferences;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsreferencesHPP
