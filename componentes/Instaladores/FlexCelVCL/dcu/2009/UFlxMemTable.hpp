// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxmemtable.pas' rev: 20.00

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
typedef void __fastcall (__closure *TFlxMemTableOnGetDataEvent)(System::TObject* Sender, const System::WideString FieldName, const int RecordPos, System::Variant &Value);

typedef void __fastcall (__closure *TOnVirtualRecordCountEvent)(System::TObject* Sender, int &RecordCount);

class DELPHICLASS TFlxMemTableField;
class DELPHICLASS TFlxMemTable;
class PASCALIMPLEMENTATION TFlxMemTableField : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TFlxMemTable* FMemTable;
	int FieldIndex;
	
public:
	__fastcall TFlxMemTableField(const TFlxMemTable* aMemTable, const int aFieldIndex);
	System::Variant __fastcall Value();
	Uxlsdb::_di_IXlsDataSet __fastcall DataSet();
	bool __fastcall IsTDateTimeField(void);
	bool __fastcall IsTMemoField(void);
	System::Extended __fastcall AsFloat(void);
	bool __fastcall Visible(void);
	System::UnicodeString __fastcall DisplayName();
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxMemTableField(void) { }
	
private:
	void *__IXlsField;	/* Uxlsdb::IXlsField */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Uxlsdb::_di_IXlsField()
	{
		Uxlsdb::_di_IXlsField intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IXlsField*(void) { return (IXlsField*)&__IXlsField; }
	#endif
	
};


class DELPHICLASS TFlxDbMemColumn;
class PASCALIMPLEMENTATION TFlxDbMemColumn : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName();
	virtual void __fastcall SetDisplayName(const System::UnicodeString Value);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetDisplayName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TFlxDbMemColumn(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TFlxDbMemColumn(void) { }
	
};


class DELPHICLASS TFlxDbMemColumnList;
class PASCALIMPLEMENTATION TFlxDbMemColumnList : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	bool __fastcall Find(const System::UnicodeString Name, /* out */ int &Index);
public:
	/* TOwnedCollection.Create */ inline __fastcall TFlxDbMemColumnList(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TFlxDbMemColumnList(void) { }
	
};


class DELPHICLASS TFlxRecord;
class PASCALIMPLEMENTATION TFlxRecord : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Uflxmessages::ArrayOfVariant Value;
	TFlxMemTable* ParentList;
	__fastcall TFlxRecord(const TFlxMemTable* aParentList, System::Variant const *aValue, const int aValue_Size);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxRecord(void) { }
	
};


class DELPHICLASS TFlxRecordList;
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
	bool __fastcall Find(const System::Variant &aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	
private:
	TFlxMemTable* MemTable;
	System::UnicodeString FListName;
	int FPosition;
	System::Variant __fastcall GetValue(int FieldIndex);
	
public:
	__fastcall TFlxRecordList(const TFlxMemTable* aMemTable, const System::UnicodeString aListName);
	__property int Position = {read=FPosition, nodefault};
	virtual void __fastcall Clear(void);
	__property System::Variant Value[int FieldIndex] = {read=GetValue};
	__property System::UnicodeString ListName = {read=FListName};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TFlxRecordList(void) { }
	
};


class DELPHICLASS TFlxMasterList;
class PASCALIMPLEMENTATION TFlxMasterList : public Contnrs::TObjectList
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TFlxRecordList* operator[](int index) { return Items[index]; }
	
private:
	TFlxMemTable* MemTable;
	int __fastcall GetPosition(System::UnicodeString MasterCat);
	System::Variant __fastcall GetValue(System::UnicodeString MasterCat, int FieldIndex);
	void __fastcall SetPosition(System::UnicodeString MasterCat, const int Value);
	int __fastcall GetRecordCount(System::UnicodeString MasterCat);
	TFlxRecordList* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TFlxRecordList* Value);
	
public:
	__property TFlxRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TFlxRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFlxRecordList* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const System::WideString aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	__fastcall TFlxMasterList(const TFlxMemTable* aMemTable);
	void __fastcall AddRecord(const System::UnicodeString MasterCat, const TFlxRecord* Rec);
	void __fastcall SortData(void);
	__property int Position[System::UnicodeString MasterCat] = {read=GetPosition, write=SetPosition};
	__property System::Variant Value[System::UnicodeString MasterCat][int FieldIndex] = {read=GetValue};
	__property int RecordCount[System::UnicodeString MasterCat] = {read=GetRecordCount};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TFlxMasterList(void) { }
	
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
	System::UnicodeString FMasterField;
	int FVirtualPos;
	TFlxMemTableOnGetDataEvent FOnGetData;
	TOnVirtualRecordCountEvent FOnVirtualRecordCount;
	System::UnicodeString FIndexFieldNames;
	Classes::TDuplicates FDuplicates;
	bool FCaseInsensitive;
	System::Variant __fastcall MastValue();
	void __fastcall SetMasterField(const System::UnicodeString Value);
	void __fastcall SetMasterTable(const TFlxMemTable* Value);
	int __fastcall GetVirtualRecordCount(void);
	void __fastcall SetDuplicates(const Classes::TDuplicates Value);
	void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TFlxMemTable(Classes::TComponent* AOwner);
	__fastcall virtual ~TFlxMemTable(void);
	void __fastcall Clear(void);
	void __fastcall AddRecord(System::Variant const *aValues, const int aValues_Size);
	int __fastcall IndexFieldPos(void);
	virtual bool __fastcall FindKey(System::Variant const *KeyValues, const int KeyValues_Size);
	
__published:
	__property TFlxDbMemColumnList* Columns = {read=FColumns, write=FColumns};
	__property TFlxMemTable* MasterTable = {read=FMasterTable, write=SetMasterTable};
	__property System::UnicodeString MasterField = {read=FMasterField, write=SetMasterField};
	__property System::UnicodeString IndexFieldNames = {read=FIndexFieldNames, write=SetIndexFieldNames};
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
	System::UnicodeString __fastcall DsName();
	Uxlsdb::_di_IXlsField __fastcall FieldByName(const System::UnicodeString Name);
	int __fastcall FieldCount(void);
	int __fastcall FieldVisibleCount(void);
private:
	void *__IXlsDataSet;	/* Uxlsdb::IXlsDataSet */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Uxlsdb::_di_IXlsDataSet()
	{
		Uxlsdb::_di_IXlsDataSet intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IXlsDataSet*(void) { return (IXlsDataSet*)&__IXlsDataSet; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IInterface*(void) { return (IInterface*)&__IXlsDataSet; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflxmemtable */
using namespace Uflxmemtable;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflxmemtableHPP
