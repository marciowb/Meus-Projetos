// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsescher.pas' rev: 21.00

#ifndef TmsuxlsescherHPP
#define TmsuxlsescherHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsotherrecords.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuescherrecords.hpp>	// Pascal unit
#include <Tmsuxlssst.hpp>	// Pascal unit
#include <Tmsubreaklist.hpp>	// Pascal unit
#include <Tmsuescherotherrecords.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsescher
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TXlsEscherRecord;
class PASCALIMPLEMENTATION TXlsEscherRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TXlsEscherRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TXlsEscherRecord(void) { }
	
};


class DELPHICLASS TDrawingGroupRecord;
class PASCALIMPLEMENTATION TDrawingGroupRecord : public TXlsEscherRecord
{
	typedef TXlsEscherRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDrawingGroupRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TXlsEscherRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDrawingGroupRecord(void) { }
	
};


class DELPHICLASS TDrawingRecord;
class PASCALIMPLEMENTATION TDrawingRecord : public TXlsEscherRecord
{
	typedef TXlsEscherRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDrawingRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TXlsEscherRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDrawingRecord(void) { }
	
};


class DELPHICLASS TDrawingSelectionRecord;
class PASCALIMPLEMENTATION TDrawingSelectionRecord : public TXlsEscherRecord
{
	typedef TXlsEscherRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TDrawingSelectionRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TXlsEscherRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TDrawingSelectionRecord(void) { }
	
};


class DELPHICLASS TDrawingGroup;
class PASCALIMPLEMENTATION TDrawingGroup : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Tmsuescherrecords::TEscherContainerRecord* FDggContainer;
	Tmsuescherrecords::TEscherDwgGroupCache FRecordCache;
	Tmsuescherrecords::PEscherDwgGroupCache __fastcall GetRecordCache(void);
	
public:
	__property Tmsuescherrecords::PEscherDwgGroupCache RecordCache = {read=GetRecordCache};
	__fastcall TDrawingGroup(void);
	void __fastcall Clear(void);
	__fastcall virtual ~TDrawingGroup(void);
	void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader, const TDrawingGroupRecord* First);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	__int64 __fastcall TotalSize(void);
	void __fastcall AddDwg(void);
	void __fastcall EnsureDwgGroup(void);
};


class DELPHICLASS TDrawing;
class PASCALIMPLEMENTATION TDrawing : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Tmsuescherrecords::TEscherContainerRecord* FDgContainer;
	Tmsuescherrecords::TEscherDwgCache FRecordCache;
	TDrawingGroup* FDrawingGroup;
	System::UnicodeString __fastcall GetDrawingName(int index);
	int __fastcall GetDrawingRow(int index);
	void __fastcall CreateBasicDrawingInfo(void);
	
public:
	void __fastcall Clear(void);
	__fastcall TDrawing(const TDrawingGroup* aDrawingGroup);
	__fastcall virtual ~TDrawing(void);
	void __fastcall CopyFrom(const TDrawing* aDrawing, const System::TObject* dSheet);
	void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader, const TDrawingRecord* First, const Tmsuxlssst::TSST* SST);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	__int64 __fastcall TotalSize(void);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const System::TObject* dSheet);
	void __fastcall ArrangeCopySheet(const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int RowCount, const int FirstCol, const int LastCol, const int DestCol, const int ColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const System::TObject* dSheet);
	void __fastcall DeleteRows(const System::Word aRow, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const System::TObject* dSheet);
	void __fastcall DeleteCols(const System::Word aCol, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const System::TObject* dSheet);
	Tmsuescherrecords::TEscherClientDataRecord* __fastcall FindObjId(const System::Word ObjId);
	int __fastcall DrawingCount(void);
	void __fastcall AssignDrawing(const int Index, const Tmsuflxmessages::ByteArray Data, const Tmsuflxmessages::TXlsImgTypes DataType);
	Tmsuflxmessages::TClientAnchor __fastcall GetAnchor(const int Index);
	void __fastcall SetAnchor(const int Index, const Tmsuflxmessages::TClientAnchor &aAnchor, const System::TObject* sSheet);
	void __fastcall GetDrawingFromStream(const int Index, const Classes::TStream* Data, /* out */ Tmsuflxmessages::TXlsImgTypes &DataType);
	__property int DrawingRow[int index] = {read=GetDrawingRow};
	__property System::UnicodeString DrawingName[int index] = {read=GetDrawingName};
	void __fastcall DeleteImage(const int Index);
	void __fastcall ClearImage(const int Index);
	void __fastcall AddImage(Tmsuflxmessages::ByteArray Data, Tmsuflxmessages::TXlsImgTypes DataType, const Tmsuflxmessages::TImageProperties &Properties, const Tmsuflxmessages::TFlxAnchorType Anchor, const System::TObject* sSheet);
	void __fastcall RemoveAutoFilter(void);
	void __fastcall AddAutoFilter(const int Row, const int Col1, const int Col2, const System::TObject* sSheet)/* overload */;
	void __fastcall AddAutoFilter(const int Row, const int Col, const System::TObject* sSheet)/* overload */;
	Tmsuescherrecords::TEscherClientDataRecord* __fastcall AddNewComment(const Tmsuflxmessages::TImageProperties &Properties, const System::TObject* sSheet);
	void __fastcall SaveObjectCoords(const System::TObject* sSheet);
	void __fastcall RestoreObjectCoords(const System::TObject* dSheet);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsescher */
using namespace Tmsuxlsescher;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsescherHPP
