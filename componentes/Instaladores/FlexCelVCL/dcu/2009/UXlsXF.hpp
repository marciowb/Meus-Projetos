// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsxf.pas' rev: 20.00

#ifndef UxlsxfHPP
#define UxlsxfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit
#include <Uxlsstrings.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsxf
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TXFDat
{
	
public:
	System::Word Font;
	System::Word Format;
	System::Word Options4;
	System::Word Options6;
	System::Word Options8;
	System::Word Options10;
	System::Word Options12;
	unsigned Options14;
	System::Word Options18;
};
#pragma pack(pop)


typedef TXFDat *PXFDat;

class DELPHICLASS TXFRecord;
class DELPHICLASS TFontRecordList;
class DELPHICLASS TFormatRecordList;
class PASCALIMPLEMENTATION TXFRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	int __fastcall CellPattern(void);
	int __fastcall CellFgColorIndex(void);
	int __fastcall CellBgColorIndex(void);
	int __fastcall FontIndex(void);
	int __fastcall FormatIndex(void);
	int __fastcall GetActualFontIndex(const TFontRecordList* FontList);
	Uflxformats::TFlxBorderStyle __fastcall GetBorderStyle(const int aPos, const System::Byte FirstBit);
	int __fastcall GetBorderColorIndex(const int aPos, const System::Byte FirstBit);
	Uflxformats::TFlxBorderStyle __fastcall GetBorderStyleExt(const int aPos, const System::Byte FirstBit);
	int __fastcall GetBorderColorIndexExt(const int aPos, const System::Byte FirstBit);
	Uflxformats::TFlxDiagonalBorder __fastcall DiagonalStyle(void);
	Uflxformats::TVFlxAlignment __fastcall VAlign(void);
	Uflxformats::THFlxAlignment __fastcall HAlign(void);
	void __fastcall FillMisc(/* out */ bool &Locked, /* out */ bool &Hidden, /* out */ int &Parent, /* out */ bool &WrapText, /* out */ bool &ShrinkToFit, /* out */ System::Byte &Rotation, /* out */ System::Byte &Indent);
	__fastcall TXFRecord(const Uflxformats::TFlxFormat &Fmt, const TFontRecordList* FontList, const TFormatRecordList* FormatList);
	Uflxformats::TFlxFormat __fastcall FlxFormat(const TFontRecordList* FontList, const TFormatRecordList* FormatList);
	void __fastcall FillUsedColors(const Uflxmessages::BooleanArray UsedColors, const TFontRecordList* FontList);
	int __fastcall Rotation(void);
	bool __fastcall WrapText(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TXFRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TXFRecord(void) { }
	
};


class DELPHICLASS TXFRecordList;
class PASCALIMPLEMENTATION TXFRecordList : public Uxlsbaserecordlists::TBaseRecordList
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	TXFRecord* operator[](int index) { return Items[index]; }
	
private:
	TXFRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TXFRecord* Value);
	
public:
	__property TXFRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TXFRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TXFRecord* aRecord);
	bool __fastcall FindFormat(const TXFRecord* XF, /* out */ int &Index);
	Uflxmessages::BooleanArray __fastcall GetUsedColors(const int ColorCount, const TFontRecordList* FontList);
public:
	/* TObjectList.Create */ inline __fastcall TXFRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TXFRecordList(void) { }
	
};


#pragma pack(push,1)
struct TFontDat
{
	
public:
	System::Word Height;
	System::Word GrBit;
	System::Word ColorIndex;
	System::Word BoldStyle;
	System::Word SuperSub;
	System::Byte Underline;
	System::Byte Family;
	System::Byte CharSet;
	System::Byte Reserved;
};
#pragma pack(pop)


typedef TFontDat *PFontDat;

class DELPHICLASS TFontRecord;
class PASCALIMPLEMENTATION TFontRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	System::UnicodeString __fastcall Name();
	int __fastcall Height(void);
	int __fastcall ColorIndex(void);
	System::Byte __fastcall Family(void);
	System::Byte __fastcall Charset(void);
	Uflxformats::SetOfTFlxFontStyle __fastcall Style(void);
	Uflxformats::TFlxUnderline __fastcall Underline(void);
	__fastcall TFontRecord(const Uflxformats::TFlxFont &aFont);
	Uflxformats::TFlxFont __fastcall FlxFont();
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TFontRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TFontRecord(void) { }
	
};


class PASCALIMPLEMENTATION TFontRecordList : public Uxlsbaserecordlists::TBaseRecordList
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	TFontRecord* operator[](int index) { return Items[index]; }
	
private:
	TFontRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TFontRecord* Value);
	
public:
	__property TFontRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TFontRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFontRecord* aRecord);
	int __fastcall AddFont(const Uflxformats::TFlxFont &aFont);
public:
	/* TObjectList.Create */ inline __fastcall TFontRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TFontRecordList(void) { }
	
};


class DELPHICLASS TStyleRecord;
class PASCALIMPLEMENTATION TStyleRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TStyleRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TStyleRecord(void) { }
	
};


class DELPHICLASS TFormatRecord;
class PASCALIMPLEMENTATION TFormatRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	int __fastcall FormatId(void);
	System::UnicodeString __fastcall Value();
	__fastcall TFormatRecord(const System::UnicodeString Fmt, const int NewID);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TFormatRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TFormatRecord(void) { }
	
};


class PASCALIMPLEMENTATION TFormatRecordList : public Uxlsbaserecordlists::TBaseRecordList
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	System::UnicodeString operator[](int index) { return Format[index]; }
	
private:
	System::UnicodeString __fastcall GetFormat(int FormatId);
	TFormatRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TFormatRecord* Value);
	
public:
	__property TFormatRecord* Items[int index] = {read=GetItems, write=SetItems};
	HIDESBASE int __fastcall Add(TFormatRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFormatRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const int aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	__property System::UnicodeString Format[int index] = {read=GetFormat/*, default*/};
	int __fastcall AddFormat(const System::UnicodeString Fmt);
public:
	/* TObjectList.Create */ inline __fastcall TFormatRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TFormatRecordList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::UnicodeString __fastcall XlsBuiltInFormats(const int z);

}	/* namespace Uxlsxf */
using namespace Uxlsxf;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsxfHPP
