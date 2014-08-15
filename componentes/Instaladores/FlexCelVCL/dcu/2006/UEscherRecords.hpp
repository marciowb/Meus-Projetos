// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uescherrecords.pas' rev: 10.00

#ifndef UescherrecordsHPP
#define UescherrecordsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Uxlsbaseclientdata.hpp>	// Pascal unit
#include <Ubreaklist.hpp>	// Pascal unit
#include <Uxlsbaselist.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uescherrecords
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TEscherRecordHeader
{
	
public:
	Word Pre;
	Word Id;
	int Size;
} ;
#pragma pack(pop)

class DELPHICLASS TEscherRecordCache;
class DELPHICLASS TEscherRecord;
class PASCALIMPLEMENTATION TEscherRecordCache : public Uxlsbaselist::TBaseList 
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	TEscherRecord* operator[](int index) { return Items[index]; }
	
private:
	TEscherRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TEscherRecord* Value);
	
public:
	__property TEscherRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TEscherRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TEscherRecord* aRecord);
	__fastcall TEscherRecordCache(void);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool Forced, const System::TObject* dSheet);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TEscherRecordCache(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEscherObjCache;
class DELPHICLASS TEscherClientDataRecord;
class PASCALIMPLEMENTATION TEscherObjCache : public TEscherRecordCache 
{
	typedef TEscherRecordCache inherited;
	
public:
	TEscherClientDataRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE TEscherClientDataRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const TEscherClientDataRecord* Value);
	
public:
	__property TEscherClientDataRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TEscherClientDataRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TEscherClientDataRecord* aRecord);
	void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
public:
	#pragma option push -w-inl
	/* TEscherRecordCache.Create */ inline __fastcall TEscherObjCache(void) : TEscherRecordCache() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TEscherObjCache(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEscherAnchorCache;
class DELPHICLASS TEscherClientAnchorRecord;
class PASCALIMPLEMENTATION TEscherAnchorCache : public TEscherRecordCache 
{
	typedef TEscherRecordCache inherited;
	
public:
	TEscherClientAnchorRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE TEscherClientAnchorRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const TEscherClientAnchorRecord* Value);
	
public:
	__property TEscherClientAnchorRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TEscherClientAnchorRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TEscherClientAnchorRecord* aRecord);
public:
	#pragma option push -w-inl
	/* TEscherRecordCache.Create */ inline __fastcall TEscherAnchorCache(void) : TEscherRecordCache() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TEscherAnchorCache(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEscherShapeCache;
class DELPHICLASS TEscherSPRecord;
class PASCALIMPLEMENTATION TEscherShapeCache : public TEscherRecordCache 
{
	typedef TEscherRecordCache inherited;
	
public:
	TEscherSPRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE TEscherSPRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const TEscherSPRecord* Value);
	
public:
	__property TEscherSPRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TEscherSPRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TEscherSPRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const unsigned aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
public:
	#pragma option push -w-inl
	/* TEscherRecordCache.Create */ inline __fastcall TEscherShapeCache(void) : TEscherRecordCache() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TEscherShapeCache(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEscherOPTCache;
class DELPHICLASS TEscherOPTRecord;
class PASCALIMPLEMENTATION TEscherOPTCache : public TEscherRecordCache 
{
	typedef TEscherRecordCache inherited;
	
public:
	TEscherOPTRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE TEscherOPTRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const TEscherOPTRecord* Value);
	
public:
	__property TEscherOPTRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TEscherOPTRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TEscherOPTRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const int aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
public:
	#pragma option push -w-inl
	/* TEscherRecordCache.Create */ inline __fastcall TEscherOPTCache(void) : TEscherRecordCache() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TEscherOPTCache(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEscherDgRecord;
class DELPHICLASS TEscherDataRecord;
class DELPHICLASS TEscherContainerRecord;
struct TEscherDwgCache;
typedef TEscherDwgCache *PEscherDwgCache;

struct TEscherDwgGroupCache;
typedef TEscherDwgGroupCache *PEscherDwgGroupCache;

typedef TMetaClass* ClassOfTEscherRecord;

class DELPHICLASS TEscherSpgrContainerRecord;
class PASCALIMPLEMENTATION TEscherRecord : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TEscherContainerRecord* FParent;
	void __fastcall IncNextPos(int &NextPos, const int Size, int &RealSize, const Ubreaklist::TBreakList* BreakList);
	void __fastcall CheckSplit(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	void __fastcall WriteNewRecord(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	
protected:
	TEscherDwgCache *DwgCache;
	TEscherDwgGroupCache *DwgGroupCache;
	
public:
	Word Pre;
	Word Id;
	int TotalDataSize;
	int LoadedDataSize;
	TEscherRecord* CopiedTo;
	
protected:
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	Word __fastcall Instance(void);
	Word __fastcall Version(void);
	
public:
	__fastcall virtual TEscherRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	virtual void __fastcall AfterCreate(void);
	virtual void __fastcall Load(Uxlsbaserecords::TBaseRecord* &aRecord, int &aPos) = 0 ;
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	TEscherRecord* __fastcall CopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	virtual __int64 __fastcall TotalSizeNoSplit(void);
	virtual bool __fastcall Loaded(void);
	bool __fastcall IsContainer(const Word aPre);
	virtual bool __fastcall WaitingClientData(/* out */ TMetaClass* &ClientType);
	virtual void __fastcall AssignClientData(const Uxlsbaseclientdata::TBaseClientData* aClientData);
	virtual void __fastcall SplitRecords(int &NextPos, int &RealSize, int &NextDwg, const Ubreaklist::TBreakList* BreakList);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool Forced, const System::TObject* dSheet);
	virtual void __fastcall ClearCopiedTo(void);
	TEscherRecord* __fastcall FindRoot(void);
	virtual TEscherRecord* __fastcall FindRec(const TMetaClass* RecClass);
	TEscherSpgrContainerRecord* __fastcall Patriarch(void);
	TEscherRecord* __fastcall CopyDwg(const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	virtual int __fastcall CompareRec(const TEscherRecord* aRecord);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TEscherRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEscherRecordList;
class PASCALIMPLEMENTATION TEscherRecordList : public Uxlsbaselist::TBaseList 
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	TEscherRecord* operator[](int index) { return Items[index]; }
	
private:
	TEscherRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TEscherRecord* Value);
	
public:
	__property TEscherRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TEscherRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TEscherRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const TEscherRecord* aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	void __fastcall CopyFrom(const TEscherRecordList* aEscherRecordList, const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	__int64 __fastcall TotalSizeNoSplit(void);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TEscherRecordList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TEscherRecordList(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TEscherContainerRecord : public TEscherRecord 
{
	typedef TEscherRecord inherited;
	
protected:
	TEscherRecordList* FContainedRecords;
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	
public:
	__property TEscherRecordList* ContainedRecords = {read=FContainedRecords};
	__fastcall virtual TEscherContainerRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherContainerRecord(void);
	virtual void __fastcall Load(Uxlsbaserecords::TBaseRecord* &aRecord, int &aPos);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	virtual __int64 __fastcall TotalSizeNoSplit(void);
	virtual bool __fastcall WaitingClientData(/* out */ TMetaClass* &ClientType);
	virtual void __fastcall AssignClientData(const Uxlsbaseclientdata::TBaseClientData* aClientData);
	TEscherRecord* __fastcall LastRecord(void);
	virtual void __fastcall SplitRecords(int &NextPos, int &RealSize, int &NextDwg, const Ubreaklist::TBreakList* BreakList);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool Forced, const System::TObject* dSheet);
	virtual void __fastcall ClearCopiedTo(void);
	virtual TEscherRecord* __fastcall FindRec(const TMetaClass* RecClass);
};



class PASCALIMPLEMENTATION TEscherDataRecord : public TEscherRecord 
{
	typedef TEscherRecord inherited;
	
protected:
	Xlsmessages::ArrayOfByte *Data;
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	
public:
	__fastcall virtual TEscherDataRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherDataRecord(void);
	virtual void __fastcall Load(Uxlsbaserecords::TBaseRecord* &aRecord, int &aPos);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	virtual __int64 __fastcall TotalSizeNoSplit(void);
	virtual void __fastcall SplitRecords(int &NextPos, int &RealSize, int &NextDwg, const Ubreaklist::TBreakList* BreakList);
	virtual int __fastcall CompareRec(const TEscherRecord* aRecord);
	void __fastcall ClearData(void);
};


struct TDg;
typedef TDg *PDg;

class PASCALIMPLEMENTATION TEscherDgRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
private:
	TDg *Dg;
	
public:
	__fastcall virtual TEscherDgRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherDgRecord(const unsigned csp, const unsigned cspidCur, const __int64 FirstShapeId, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherDgRecord(void);
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	unsigned __fastcall IncMaxShapeId(void);
	void __fastcall DecShapeCount(void);
};


class DELPHICLASS TEscherSolverContainerRecord;
class PASCALIMPLEMENTATION TEscherSolverContainerRecord : public TEscherContainerRecord 
{
	typedef TEscherContainerRecord inherited;
	
public:
	unsigned MaxRuleId;
	__fastcall virtual TEscherSolverContainerRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherSolverContainerRecord(void);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	unsigned __fastcall IncMaxRuleId(void);
	void __fastcall CheckMax(const unsigned aRuleId);
	void __fastcall DeleteRef(const TEscherSPRecord* Shape);
	void __fastcall FixPointers(void);
	void __fastcall ArrangeCopyRowsAndCols(const System::TObject* dSheet);
};


struct TEscherDwgCache
{
	
public:
	bool Destroying;
	Word MaxObjId;
	TEscherDgRecord* Dg;
	TEscherSolverContainerRecord* Solver;
	TEscherSpgrContainerRecord* Patriarch;
	TEscherAnchorCache* Anchor;
	TEscherShapeCache* Shape;
	TEscherObjCache* Obj;
	TEscherOPTCache* Blip;
} ;

class DELPHICLASS TEscherBStoreRecord;
class PASCALIMPLEMENTATION TEscherBStoreRecord : public TEscherContainerRecord 
{
	typedef TEscherContainerRecord inherited;
	
public:
	__fastcall virtual TEscherBStoreRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherBStoreRecord(void);
	void __fastcall AddRef(const int BlipPos);
	void __fastcall Release(const int BlipPos);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
};


class DELPHICLASS TEscherDggRecord;
struct TDgg;
typedef TDgg *PDgg;

class PASCALIMPLEMENTATION TEscherDggRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
private:
	void __fastcall GetNewCluster(int &DgId, const bool GetNewId, const __int64 ShapeCount, /* out */ __int64 &FirstShapeId);
	
public:
	TDgg *FDgg;
	__fastcall virtual TEscherDggRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherDggRecord(const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherDggRecord(void);
	__int64 __fastcall AddImage(const int DgId, const __int64 LastImageId);
	void __fastcall AddNewCluster(int DgId, const __int64 ShapeCount, /* out */ __int64 &FirstShapeId);
	void __fastcall DestroyClusters(const int DgId);
	void __fastcall GetNewDgIdAndCluster(/* out */ int &DgId, /* out */ __int64 &FirstShapeId);
	bool __fastcall IsEmpty(void);
	void __fastcall RemoveImage(const int DgId);
};


struct TEscherDwgGroupCache
{
	
public:
	TEscherBStoreRecord* BStore;
	TEscherDggRecord* Dgg;
} ;

class DELPHICLASS TEscherSpContainerRecord;
class PASCALIMPLEMENTATION TEscherSpContainerRecord : public TEscherContainerRecord 
{
	typedef TEscherContainerRecord inherited;
	
public:
	TEscherSPRecord* SP;
	TEscherOPTRecord* Opt;
	TEscherClientAnchorRecord* ClientAnchor;
	int __fastcall Row(void);
	int __fastcall Col(void);
public:
	#pragma option push -w-inl
	/* TEscherContainerRecord.Create */ inline __fastcall virtual TEscherSpContainerRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent) : TEscherContainerRecord(aEscherHeader, aDwgGroupCache, aDwgCache, aParent) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TEscherContainerRecord.Destroy */ inline __fastcall virtual ~TEscherSpContainerRecord(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TEscherSpgrContainerRecord : public TEscherContainerRecord 
{
	typedef TEscherContainerRecord inherited;
	
public:
	__fastcall virtual TEscherSpgrContainerRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherSpgrContainerRecord(void);
};


class PASCALIMPLEMENTATION TEscherClientDataRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
public:
	Uxlsbaseclientdata::TBaseClientData* ClientData;
	
protected:
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	
public:
	__fastcall virtual TEscherClientDataRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherClientDataRecord(const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherClientDataRecord(void);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	virtual __int64 __fastcall TotalSizeNoSplit(void);
	virtual bool __fastcall Loaded(void);
	virtual bool __fastcall WaitingClientData(/* out */ TMetaClass* &ClientType);
	virtual void __fastcall SplitRecords(int &NextPos, int &RealSize, int &NextDwg, const Ubreaklist::TBreakList* BreakList);
	virtual void __fastcall AssignClientData(const Uxlsbaseclientdata::TBaseClientData* aClientData);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOfs, const int ColOfs);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool Forced, const System::TObject* dSheet);
	Word __fastcall ObjId(void);
};


class DELPHICLASS TEscherSplitMenuRecord;
class PASCALIMPLEMENTATION TEscherSplitMenuRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
public:
	__fastcall TEscherSplitMenuRecord(const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
public:
	#pragma option push -w-inl
	/* TEscherDataRecord.Create */ inline __fastcall virtual TEscherSplitMenuRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent) : TEscherDataRecord(aEscherHeader, aDwgGroupCache, aDwgCache, aParent) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TEscherDataRecord.Destroy */ inline __fastcall virtual ~TEscherSplitMenuRecord(void) { }
	#pragma option pop
	
};


struct TAbsoluteAnchorRect
{
	
public:
	int x1;
	int x2;
	int y1;
	int y2;
} ;

class PASCALIMPLEMENTATION TEscherClientAnchorRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
private:
	Uflxmessages::TClientAnchor *Anchor;
	TAbsoluteAnchorRect SaveRect;
	
public:
	__fastcall virtual TEscherClientAnchorRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherClientAnchorRecord(const Uflxmessages::TClientAnchor &aAnchor, const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent, const System::TObject* sSheet);
	__fastcall virtual ~TEscherClientAnchorRecord(void);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool Forced, const System::TObject* dSheet);
	bool __fastcall AllowCopy(const int FirstRow, const int LastRow, const int FirstCol, const int LastCol);
	bool __fastcall AllowDelete(const int FirstRow, const int LastRow, const int FirstCol, const int LastCol);
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	int __fastcall Row(void);
	int __fastcall Col(void);
	Uflxmessages::TClientAnchor __fastcall GetAnchor();
	void __fastcall SetAnchor(const Uflxmessages::TClientAnchor &aAnchor, const System::TObject* sSheet);
	void __fastcall RestoreObjectCoords(const System::TObject* dSheet);
	void __fastcall SaveObjectCoords(const System::TObject* sSheet);
};


class DELPHICLASS TEscherBSERecord;
class PASCALIMPLEMENTATION TEscherBSERecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
public:
	int BStorePos;
	void __fastcall AddRef(void);
	void __fastcall Release(void);
	unsigned __fastcall References(void);
	virtual int __fastcall CompareRec(const TEscherRecord* aRecord);
	void __fastcall CopyFromData(const void * BSEHeader, const TEscherRecordHeader &BlipHeader, const Classes::TMemoryStream* BlipData);
	void __fastcall SaveGraphicToStream(const Classes::TStream* aData, /* out */ Uflxmessages::TXlsImgTypes &aDataType);
public:
	#pragma option push -w-inl
	/* TEscherDataRecord.Create */ inline __fastcall virtual TEscherBSERecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent) : TEscherDataRecord(aEscherHeader, aDwgGroupCache, aDwgCache, aParent) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TEscherDataRecord.Destroy */ inline __fastcall virtual ~TEscherBSERecord(void) { }
	#pragma option pop
	
};


#pragma pack(push,1)
struct TDg
{
	
public:
	unsigned ShapeCount;
	unsigned MaxSpId;
} ;
#pragma pack(pop)

#pragma pack(push,1)
struct TDgg
{
	
public:
	unsigned MaxShapeId;
	unsigned FIDclCount;
	unsigned ShapesSaved;
	unsigned DwgSaved;
} ;
#pragma pack(pop)

typedef unsigned *PLongWord;

class PASCALIMPLEMENTATION TEscherSPRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
public:
	unsigned *ShapeId;
	
protected:
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	
public:
	__fastcall virtual TEscherSPRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherSPRecord(const unsigned Pre, const unsigned aShapeId, const unsigned Flags, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherSPRecord(void);
};


typedef DynamicArray<TEscherBSERecord* >  UEscherRecords__22;

typedef DynamicArray<unsigned >  UEscherRecords__32;

class PASCALIMPLEMENTATION TEscherOPTRecord : public TEscherDataRecord 
{
	typedef TEscherDataRecord inherited;
	
private:
	DynamicArray<TEscherBSERecord* >  BlipPtr;
	DynamicArray<unsigned >  BlipPos;
	WideString FShapeName;
	WideString __fastcall GetShapeName();
	int __fastcall AddImg(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType);
	
protected:
	virtual TEscherRecord* __fastcall DoCopyTo(const PEscherDwgCache NewDwgCache, const int RowOfs, const int ColOfs, const System::TObject* dSheet);
	
public:
	__fastcall virtual TEscherOPTRecord(const TEscherRecordHeader &aEscherHeader, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherOPTRecord(const Uflxmessages::ByteArray aPict, const Uflxmessages::TXlsImgTypes aPicType, const WideString PicName, const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall TEscherOPTRecord(const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent, const int Dummy);
	__fastcall TEscherOPTRecord(const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent, const int Dummy1, int Dummy2);
	__fastcall TEscherOPTRecord(const PEscherDwgGroupCache aDwgGroupCache, const PEscherDwgCache aDwgCache, const TEscherContainerRecord* aParent);
	__fastcall virtual ~TEscherOPTRecord(void);
	virtual void __fastcall AfterCreate(void);
	__property WideString ShapeName = {read=GetShapeName};
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream, const Ubreaklist::TBreakList* BreakList);
	int __fastcall Row(void);
	int __fastcall Col(void);
	Uflxmessages::TClientAnchor __fastcall GetAnchor();
	void __fastcall SetAnchor(const Uflxmessages::TClientAnchor &aAnchor, const System::TObject* sSheet);
	void __fastcall ChangeRef(const TEscherBSERecord* aBSE);
	void __fastcall ReplaceImg(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType);
	void __fastcall GetImageFromStream(const Classes::TStream* Data, /* out */ Uflxmessages::TXlsImgTypes &DataType);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uescherrecords */
using namespace Uescherrecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uescherrecords
