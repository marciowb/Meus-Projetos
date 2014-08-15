// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsStrings.pas' rev: 22.00

#ifndef UxlsstringsHPP
#define UxlsstringsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsstrings
{
//-- type declarations -------------------------------------------------------
typedef System::ShortInt TStrLenLength;

typedef System::ShortInt TCharSize;

class DELPHICLASS TExcelString;
class PASCALIMPLEMENTATION TExcelString : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TStrLenLength StrLenLength;
	
public:
	System::Word StrLen;
	System::Byte OptionFlags;
	System::UnicodeString WideData;
	System::AnsiString ShortData;
	System::Word NumberRichTextFormats;
	Xlsmessages::ArrayOfByte *RichTextFormats;
	unsigned FarEastDataSize;
	Xlsmessages::ArrayOfByte *FarEastData;
	System::UnicodeString __fastcall GetValue(void);
	__fastcall TExcelString(const TStrLenLength aStrLenLength, Uxlsbaserecords::TBaseRecord* &aRecord, int &Ofs)/* overload */;
	__fastcall TExcelString(const TStrLenLength aStrLenLength, const System::UnicodeString s, const bool ForceWide)/* overload */;
	__fastcall virtual ~TExcelString(void);
	void __fastcall SaveToStream(const Classes::TStream* DataStream)/* overload */;
	void __fastcall SaveToStream(const Classes::TStream* DataStream, const bool IncludeLen)/* overload */;
	TCharSize __fastcall GetCharSize(void);
	bool __fastcall HasRichText(void);
	bool __fastcall HasFarInfo(void);
	int __fastcall Compare(const TExcelString* Str2);
	__int64 __fastcall TotalSize(void);
	void __fastcall CopyToPtr(const Xlsmessages::PArrayOfByte Ptr, const int aPos)/* overload */;
	void __fastcall CopyToPtr(const Xlsmessages::PArrayOfByte Ptr, const int aPos, const bool IncludeLen)/* overload */;
	__property System::UnicodeString Value = {read=GetValue};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsstrings */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlsstrings;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsstringsHPP
