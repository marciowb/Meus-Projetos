// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsreferences.pas' rev: 11.00

#ifndef UxlsreferencesHPP
#define UxlsreferencesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Uxlsbaselist.hpp>	// Pascal unit
#include <Uxlsstrings.hpp>	// Pascal unit
#include <Xlsformulamessages.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsreferences
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExternNameRecord;
class PASCALIMPLEMENTATION TExternNameRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	WideString __fastcall Name();
	Byte __fastcall NameLength(void);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TExternNameRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TExternNameRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TExternNameRecordList;
class PASCALIMPLEMENTATION TExternNameRecordList : public Uxlsbaserecordlists::TBaseRecordList 
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TExternNameRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TExternNameRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSupBookRecord;
class PASCALIMPLEMENTATION TSupBookRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	TExternNameRecordList* FExternNameList;
	
public:
	bool __fastcall IsLocal(void);
	bool __fastcall IsAddIn(void);
	void __fastcall InsertSheets(const int SheetCount);
	WideString __fastcall BookName();
	WideString __fastcall SheetName(const int SheetIndex, const System::TObject* Globals);
	void __fastcall AddExternName(const TExternNameRecord* ExternNameRecord);
	
protected:
	virtual Uxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TSupBookRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TSupBookRecord(const int SheetCount);
	__fastcall virtual ~TSupBookRecord(void);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* Workbook);
	virtual int __fastcall TotalSize(void);
	virtual int __fastcall TotalSizeNoHeaders(void);
};


class DELPHICLASS TExternSheetRecord;
class PASCALIMPLEMENTATION TExternSheetRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TExternSheetRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TExternSheetRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TExternRef;
class PASCALIMPLEMENTATION TExternRef : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Word SupBookRecord;
	Word FirstSheet;
	Word LastSheet;
	__fastcall TExternRef(const Word aSupBookRecord, const Word aFirstSheet, const Word aLastSheet);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TExternRef(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSupBookRecordList;
class PASCALIMPLEMENTATION TSupBookRecordList : public Uxlsbaserecordlists::TBaseRecordList 
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
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
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TSupBookRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TSupBookRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TExternRefList;
class PASCALIMPLEMENTATION TExternRefList : public Uxlsbaselist::TBaseList 
{
	typedef Uxlsbaselist::TBaseList inherited;
	
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
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	__int64 __fastcall TotalSize(void);
	void __fastcall InsertSheets(const int BeforeSheet, const int SheetCount, int LocalSupBook);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TExternRefList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TExternRefList(void) { }
	#pragma option pop
	
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
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall AddSupBook(const TSupBookRecord* aRecord);
	void __fastcall AddExternRef(const TExternSheetRecord* aRecord);
	void __fastcall AddExternName(const TExternNameRecord* aRecord);
	void __fastcall InsertSheets(const int BeforeSheet, const int SheetCount);
	int __fastcall GetSheet(const Word SheetRef);
	int __fastcall SetSheet(const Word Sheet);
	int __fastcall AddSheet(int SheetCount, int FirstSheet, int LastSheet);
	WideString __fastcall GetSheetName(const Word SheetRef, const System::TObject* Globals);
	WideString __fastcall GetName(const int SheetRef, const int NameIndex, const System::TObject* Globals);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsreferences */
using namespace Uxlsreferences;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsreferences
