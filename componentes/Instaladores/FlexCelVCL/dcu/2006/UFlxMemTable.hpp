// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxmemtable.pas' rev: 10.00

#ifndef UflxmemtableHPP
#define UflxmemtableHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uxlsdb.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxmemtable
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TFlxMemTableOnGetDataEvent)(System::TObject* Sender, const WideString FieldName, const int RecordPos, Variant &Value);

typedef void __fastcall (__closure *TOnVirtualRecordCountEvent)(System::TObject* Sender, int &RecordCount);

class DELPHICLASS TFlxMemTableField;
class DELPHICLASS TFlxMemTable;
class DELPHICLASS TFlxDbMemColumnList;
class PASCALIMPLEMENTATION TFlxDbMemColumnList : public Classes::TOwnedCollection 
{
	typedef Classes::TOwnedCollection inherited;
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	bool __fastcall Find(const AnsiString Name, /* out */ int &Index);
public:
	#pragma option push -w-inl
	/* TOwnedCollection.Create */ inline __fastcall TFlxDbMemColumnList(Classes::TPersistent* AOwner, TMetaClass* ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TFlxDbMemColumnList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TFlxMasterList;
class DELPHICLASS TFlxRecordList;
class DELPHICLASS TFlxRecord;
class PASCALIMPLEMENTATION TFlxMasterList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TFlxRecordList* operator[](int index) { return Items[index]; }
	
private:
	TFlxMemTable* MemTable;
	int __fastcall GetPosition(WideString MasterCat);
	Variant __fastcall GetValue(WideString MasterCat, int FieldIndex);
	void __fastcall SetPosition(WideString MasterCat, const int Value);
	int __fastcall GetRecordCount(WideString MasterCat);
	TFlxRecordList* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TFlxRecordList* Value);
	
public:
	__property TFlxRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TFlxRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFlxRecordList* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const WideString aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	__fastcall TFlxMasterList(const TFlxMemTable* aMemTable);
	void __fastcall AddRecord(const WideString MasterCat, const TFlxRecord* Rec);
	void __fastcall SortData(void);
	__property int Position[WideString MasterCat] = {read=GetPosition, write=SetPosition};
	__property Variant Value[WideString MasterCat][int FieldIndex] = {read=GetValue};
	__property int RecordCount[WideString MasterCat] = {read=GetRecordCount};
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TFlxMasterList(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TFlxMemTable : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TNotifyEvent FOnLast;
	Classes::TNotifyEvent FOnNext;
	Classes::TNotifyEvent FOnFirst;
	TFlxDbMemColumnList* FColumns;
	TFlxMasterList* FData;
	bool FActive;
	TFlxMemTable* FMasterTable;
	AnsiString FMasterField;
	int FVirtualPos;
	TFlxMemTableOnGetDataEvent FOnGetData;
	TOnVirtualRecordCountEvent FOnVirtualRecordCount;
	AnsiString FIndexFieldNames;
	Classes::TDuplicates FDuplicates;
	bool FCaseInsensitive;
	Variant __fastcall MastValue();
	void __fastcall SetMasterField(const AnsiString Value);
	void __fastcall SetMasterTable(const TFlxMemTable* Value);
	int __fastcall GetVirtualRecordCount(void);
	void __fastcall SetDuplicates(const Classes::TDuplicates Value);
	void __fastcall SetIndexFieldNames(const AnsiString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TFlxMemTable(Classes::TComponent* AOwner);
	__fastcall virtual ~TFlxMemTable(void);
	void __fastcall Clear(void);
	void __fastcall AddRecord(Variant const * aValues, const int aValues_Size);
	int __fastcall IndexFieldPos(void);
	virtual bool __fastcall FindKey(Variant const * KeyValues, const int KeyValues_Size);
	
__published:
	__property TFlxDbMemColumnList* Columns = {read=FColumns, write=FColumns};
	__property TFlxMemTable* MasterTable = {read=FMasterTable, write=SetMasterTable};
	__property AnsiString MasterField = {read=FMasterField, write=SetMasterField};
	__property AnsiString IndexFieldNames = {read=FIndexFieldNames, write=SetIndexFieldNames};
	__property Classes::TDuplicates Duplicates = {read=FDuplicates, write=SetDuplicates, default=1};
	__property bool CaseInsensitive = {read=FCaseInsensitive, write=FCaseInsensitive, default=1};
	__property TOnVirtualRecordCountEvent OnVirtualRecordCount = {read=FOnVirtualRecordCount, write=FOnVirtualRecordCount};
	__property Classes::TNotifyEvent OnFirst = {read=FOnFirst, write=FOnFirst};
	__property Classes::TNotifyEvent OnNext = {read=FOnNext, write=FOnNext};
	__property Classes::TNotifyEvent OnLast = {read=FOnLast, write=FOnLast};
	__property TFlxMemTableOnGetDataEvent OnGetData = {read=FOnGetData, write=FOnGetData};
	
public:
	Uxlsdb::_di_IXlsField __fastcall GetFields(int index);
	bool __fastcall GetActive(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	__property bool Active = {read=GetActive, nodefault};
	int __fastcall RecordCount(void);
	void __fastcall First(void);
	void __fastcall Next(void);
	void __fastcall Last(void);
	bool __fastcall Eof(void);
	AnsiString __fastcall DsName();
	Uxlsdb::_di_IXlsField __fastcall FieldByName(const AnsiString Name);
	int __fastcall FieldCount(void);
	int __fastcall FieldVisibleCount(void);
private:
	void *__IXlsDataSet;	/* Uxlsdb::IXlsDataSet */
	
public:
	operator IXlsDataSet*(void) { return (IXlsDataSet*)&__IXlsDataSet; }
	operator IInterface*(void) { return (IInterface*)&__IXlsDataSet; }
	
};


class PASCALIMPLEMENTATION TFlxMemTableField : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	TFlxMemTable* FMemTable;
	int FieldIndex;
	
public:
	__fastcall TFlxMemTableField(const TFlxMemTable* aMemTable, const int aFieldIndex);
	Variant __fastcall Value();
	Uxlsdb::_di_IXlsDataSet __fastcall DataSet();
	bool __fastcall IsTDateTimeField(void);
	bool __fastcall IsTMemoField(void);
	Extended __fastcall AsFloat(void);
	bool __fastcall Visible(void);
	AnsiString __fastcall DisplayName();
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxMemTableField(void) { }
	#pragma option pop
	
private:
	void *__IXlsField;	/* Uxlsdb::IXlsField */
	
public:
	operator IXlsField*(void) { return (IXlsField*)&__IXlsField; }
	
};


class DELPHICLASS TFlxDbMemColumn;
class PASCALIMPLEMENTATION TFlxDbMemColumn : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	AnsiString FName;
	
protected:
	virtual AnsiString __fastcall GetDisplayName();
	virtual void __fastcall SetDisplayName(const AnsiString Value);
	
__published:
	__property AnsiString Name = {read=FName, write=SetDisplayName};
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TFlxDbMemColumn(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TFlxDbMemColumn(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TFlxRecord : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	DynamicArray<Variant >  Value;
	TFlxMemTable* ParentList;
	__fastcall TFlxRecord(const TFlxMemTable* aParentList, Variant const * aValue, const int aValue_Size);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxRecord(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TFlxRecordList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TFlxRecord* operator[](int index) { return Items[index]; }
	
private:
	TFlxRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TFlxRecord* Value);
	
public:
	__property TFlxRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TFlxRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFlxRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const Variant &aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	
private:
	TFlxMemTable* MemTable;
	WideString FListName;
	int FPosition;
	Variant __fastcall GetValue(int FieldIndex);
	
public:
	__fastcall TFlxRecordList(const TFlxMemTable* aMemTable, const WideString aListName);
	__property int Position = {read=FPosition, nodefault};
	virtual void __fastcall Clear(void);
	__property Variant Value[int FieldIndex] = {read=GetValue};
	__property WideString ListName = {read=FListName};
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TFlxRecordList(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflxmemtable */
using namespace Uflxmemtable;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxmemtable
