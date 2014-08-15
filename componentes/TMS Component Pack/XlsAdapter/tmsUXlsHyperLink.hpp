// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlshyperlink.pas' rev: 21.00

#ifndef TmsuxlshyperlinkHPP
#define TmsuxlshyperlinkHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuxlsbaselist.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlshyperlink
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS THLinkRecord;
class DELPHICLASS TScreenTipRecord;
class PASCALIMPLEMENTATION THLinkRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
private:
	TScreenTipRecord* Hint;
	System::UnicodeString __fastcall ReadString(int &Pos, const int OptMask, const int ByteSize);
	System::UnicodeString __fastcall ReadLocalFile(int &Pos);
	void __fastcall SetString(int &Pos, const int OptMask, const System::UnicodeString value);
	void __fastcall SetString2(int &Pos, const Tmsxlsmessages::PArrayOfByte GUID, const System::UnicodeString value, const int ByteCount);
	void __fastcall SetLocalFile(int &Pos, const System::UnicodeString value);
	bool __fastcall IsUrl(int pos);
	bool __fastcall IsFile(int pos);
	bool __fastcall IsUNC(int pos);
	System::UnicodeString __fastcall GetText(int &pos, Tmsuflxmessages::THyperLinkType &HType);
	void __fastcall SetText(int &pos, System::UnicodeString Text, Tmsuflxmessages::THyperLinkType HType);
	void __fastcall ClearData(void);
	int __fastcall GetFirstRow(void);
	int __fastcall GetLastRow(void);
	int __fastcall GetFirstCol(void);
	int __fastcall GetLastCol(void);
	int __fastcall GetOptionFlags(void);
	void __fastcall SetFirstRow(int Value);
	void __fastcall SetLastRow(int Value);
	void __fastcall SetFirstCol(int Value);
	void __fastcall SetLastCol(int Value);
	void __fastcall SetOptionFlags(int Value);
	
protected:
	virtual Tmsuxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	void __fastcall AddHint(const TScreenTipRecord* aHint);
	__fastcall virtual THLinkRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall THLinkRecord(const Tmsuflxmessages::TXlsCellRange &CellRange, const Tmsuflxmessages::THyperLink &HLink);
	__fastcall virtual ~THLinkRecord(void);
	__property int FirstRow = {read=GetFirstRow, write=SetFirstRow, nodefault};
	__property int LastRow = {read=GetLastRow, write=SetLastRow, nodefault};
	__property int FirstCol = {read=GetFirstCol, write=SetFirstCol, nodefault};
	__property int LastCol = {read=GetLastCol, write=SetLastCol, nodefault};
	__property int OptionFlags = {read=GetOptionFlags, write=SetOptionFlags, nodefault};
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* Workbook);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* Workbook, const Tmsuflxmessages::TXlsCellRange &CellRange);
	int __fastcall TotalRangeSize(const Tmsuflxmessages::TXlsCellRange &CellRange);
	virtual int __fastcall TotalSize(void);
	virtual int __fastcall TotalSizeNoHeaders(void);
	Tmsuflxmessages::THyperLink __fastcall GetProperties(void);
	void __fastcall SetProperties(const Tmsuflxmessages::THyperLink &value);
	Tmsuflxmessages::TXlsCellRange __fastcall GetCellRange(void);
	void __fastcall SetCellRange(const Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall ArrangeInsertRange(const Tmsuflxmessages::TXlsCellRange &CellRange, int aRowCount, int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	THLinkRecord* __fastcall Offset(int DeltaRow, int DeltaCol);
};


class PASCALIMPLEMENTATION TScreenTipRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
protected:
	int __fastcall GetFirstRow(void);
	int __fastcall GetLastRow(void);
	int __fastcall GetFirstCol(void);
	int __fastcall GetLastCol(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetFirstRow(int Value);
	void __fastcall SetLastRow(int Value);
	void __fastcall SetFirstCol(int Value);
	void __fastcall SetLastCol(int Value);
	void __fastcall SetText(System::UnicodeString Value);
	
public:
	__fastcall virtual TScreenTipRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	__fastcall TScreenTipRecord(System::UnicodeString aDescription);
	__property int FirstRow = {read=GetFirstRow, write=SetFirstRow, nodefault};
	__property int LastRow = {read=GetLastRow, write=SetLastRow, nodefault};
	__property int FirstCol = {read=GetFirstCol, write=SetFirstCol, nodefault};
	__property int LastCol = {read=GetLastCol, write=SetLastCol, nodefault};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TScreenTipRecord(void) { }
	
};


class DELPHICLASS THLinkList;
class PASCALIMPLEMENTATION THLinkList : public Tmsuxlsbaselist::TBaseList
{
	typedef Tmsuxlsbaselist::TBaseList inherited;
	
public:
	THLinkRecord* operator[](int index) { return Items[index]; }
	
private:
	THLinkRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const THLinkRecord* Value);
	
public:
	__property THLinkRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(THLinkRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, THLinkRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	HIDESBASE void __fastcall Sort(void);
	void __fastcall CopyFrom(THLinkList* aHLinkList);
	void __fastcall CopyObjectsFrom(THLinkList* aHLinkList, const Tmsuflxmessages::TXlsCellRange &CopyRange, int RowOfs, int ColOfs);
	void __fastcall SaveToStream(Tmsuole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(Tmsuole2impl::TOle2File* DataStream, const Tmsuflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRange(const Tmsuflxmessages::TXlsCellRange &SourceRange, int DestRow, int DestCol, int aRowCount, int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteRange(const Tmsuflxmessages::TXlsCellRange &CellRange, int aRowCount, int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
public:
	/* TObjectList.Create */ inline __fastcall THLinkList(void)/* overload */ : Tmsuxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~THLinkList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlshyperlink */
using namespace Tmsuxlshyperlink;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlshyperlinkHPP
