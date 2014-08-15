// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsnotes.pas' rev: 21.00

#ifndef TmsuxlsnotesHPP
#define TmsuxlsnotesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsrowcolentries.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsescher.hpp>	// Pascal unit
#include <Tmsuescherrecords.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsnotes
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TNoteRecord;
class PASCALIMPLEMENTATION TNoteRecord : public Tmsuxlsbaserecords::TBaseRowColRecord
{
	typedef Tmsuxlsbaserecords::TBaseRowColRecord inherited;
	
private:
	Tmsuescherrecords::TEscherClientDataRecord* Dwg;
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	virtual Tmsuxlsbaserecords::TBaseRecord* __fastcall DoCopyTo(void);
	
public:
	__fastcall TNoteRecord(const int aRow, const int aCol, const System::UnicodeString aTxt, const Tmsuxlsescher::TDrawing* Drawing, const Tmsuflxmessages::TImageProperties &Properties, const System::TObject* sSheet);
	__fastcall virtual ~TNoteRecord(void);
	virtual void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall FixDwgIds(const Tmsuxlsescher::TDrawing* Drawing);
	__property System::UnicodeString Text = {read=GetText, write=SetText};
public:
	/* TBaseRowColRecord.Create */ inline __fastcall virtual TNoteRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TBaseRowColRecord(aId, aData, aDataSize) { }
	
};


class DELPHICLASS TNoteRecordList;
class PASCALIMPLEMENTATION TNoteRecordList : public Tmsuxlsbaserecordlists::TBaseRowColRecordList
{
	typedef Tmsuxlsbaserecordlists::TBaseRowColRecordList inherited;
	
public:
	TNoteRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE TNoteRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const TNoteRecord* Value);
	
public:
	__property TNoteRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TNoteRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TNoteRecord* aRecord);
	void __fastcall FixDwgIds(const Tmsuxlsescher::TDrawing* Drawing);
public:
	/* TObjectList.Create */ inline __fastcall TNoteRecordList(void)/* overload */ : Tmsuxlsbaserecordlists::TBaseRowColRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TNoteRecordList(void) { }
	
};


class DELPHICLASS TNoteList;
class PASCALIMPLEMENTATION TNoteList : public Tmsuxlsrowcolentries::TBaseRowColList
{
	typedef Tmsuxlsrowcolentries::TBaseRowColList inherited;
	
public:
	TNoteRecordList* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE TNoteRecordList* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const TNoteRecordList* Value);
	
public:
	__property TNoteRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TNoteRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TNoteRecordList* aRecord);
	__fastcall TNoteList(void);
	void __fastcall FixDwgIds(const Tmsuxlsescher::TDrawing* Drawing);
	void __fastcall AddNewComment(const int Row, const int Col, const System::UnicodeString Txt, const Tmsuxlsescher::TDrawing* Drawing, const Tmsuflxmessages::TImageProperties &Properties, const System::TObject* sSheet);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TNoteList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsnotes */
using namespace Tmsuxlsnotes;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsnotesHPP
