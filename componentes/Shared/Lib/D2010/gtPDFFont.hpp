// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtpdffont.pas' rev: 21.00

#ifndef GtpdffontHPP
#define GtpdffontHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtpdffont
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtFontType { ftTrueType, ftType1, ftStdType1 };
#pragma option pop

class DELPHICLASS TgtPDFFontInfo;
class PASCALIMPLEMENTATION TgtPDFFontInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int FfiFontObjRef;
	StaticArray<int, 224> FfiWidths;
	int FfiFlags;
	Types::TRect FfiFontBBox;
	double FfiAscent;
	double FfiDescent;
	double FfiCapHeight;
	int FfiAvgWidth;
	int FfiMaxWidth;
	int FfiStemV;
	int FfiItalicAngle;
	double FfiStrikeoutSize;
	double FfiStrikeoutPosition;
	double FfiUnderscoreSize;
	double FfiUnderscorePosition;
	TgtFontType FfiType;
	bool FfiIsFixedPitch;
	__fastcall TgtPDFFontInfo(Graphics::TFont* AFont);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TgtPDFFontInfo(void) { }
	
};


class DELPHICLASS TgtPDFFont;
class PASCALIMPLEMENTATION TgtPDFFont : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef StaticArray<System::UnicodeString, 10> _TgtPDFFont__1;
	
	typedef DynamicArray<unsigned> _TgtPDFFont__2;
	
	
private:
	System::UnicodeString FBaseFont;
	System::UnicodeString FPDFCMap;
	bool FSubset;
	_TgtPDFFont__1 FRequiredTables;
	Classes::TList* FIncludedCharCode;
	Gtclasses::TgtExtMemStream* FOutFont;
	Gtclasses::TgtExtMemStream* FTableData;
	Gtclasses::TgtExtMemStream* FGlyfOut;
	Gtclasses::TgtExtMemStream* FLocaOut;
	int FTableOutCount;
	_TgtPDFFont__2 FTableOffset;
	_TgtPDFFont__2 FTableLength;
	_TgtPDFFont__2 FTableChecksum;
	unsigned FLocaOffset;
	unsigned FGlyfOffset;
	System::Word FNumGlyphs;
	bool FLocaIsLong;
	void __fastcall FillFontMetrics(bool ASubset = false, bool ACharset = true);
	bool __fastcall IsTrueType(bool ACharset = true);
	System::UnicodeString __fastcall SetBaseFont(void);
	bool __fastcall IsAnsiCharset(void);
	int __fastcall GetCodePage(Graphics::TFontCharset AFontCharset);
	System::WideString __fastcall StringToUnicodeString(System::AnsiString AStr, Graphics::TFontCharset AFontCharset);
	void __fastcall GetFontCMapDetails(void);
	void __fastcall ReadGlyphWidths(void);
	void __fastcall SetSubset(const bool Value);
	void __fastcall ReadTable(Gtclasses::TgtExtMemStream* AStream);
	int __fastcall GetCheckSum(Gtclasses::TgtExtMemStream* AStream);
	bool __fastcall HasChar(System::Word ACharCode);
	bool __fastcall IsTableNeeded(System::UnicodeString AString);
	void __fastcall SubsetInitialize(void);
	void __fastcall SubsetFinalize(void);
	bool __fastcall WriteLocaAndGlyf(Gtclasses::TgtExtMemStream* AStream);
	void __fastcall WriteTable(void);
	
protected:
	Graphics::TFont* FFont;
	TgtPDFFontInfo* FFontInfo;
	
public:
	Classes::TList* FCID;
	Classes::TList* FCharCode;
	Classes::TStringList* FWidths;
	__fastcall TgtPDFFont(Graphics::TFont* AFont, int AFontObjRef, bool ASubset, bool ACharset);
	__fastcall virtual ~TgtPDFFont(void);
	void __fastcall AddString(System::UnicodeString AString);
	void __fastcall AddCharCodes(System::UnicodeString ACharCode);
	void __fastcall GetFontFile2Subset(Gtclasses::TgtExtMemStream* &AStream);
	System::UnicodeString __fastcall GetCIDFontDictionary(System::UnicodeString AFontDescriptorRef);
	void __fastcall GetCMap(Classes::TMemoryStream* AMemStream);
	System::UnicodeString __fastcall GetFontDescriptor(System::UnicodeString AFontFile2Obj);
	System::UnicodeString __fastcall GetGlyphIndiciesA(System::WideString AStr, Graphics::TFontCharset ACharset);
	System::UnicodeString __fastcall GetGlyphIndiciesW(System::WideString AStr, Graphics::TFontCharset ACharset);
	System::UnicodeString __fastcall GetGlyphIndiciesForNonANSI(System::WideString AStr, Graphics::TFontCharset ACharset);
	System::UnicodeString __fastcall GetType0FontDictionary(int AFontNo, System::UnicodeString AUnicodeObjRef, System::UnicodeString ADesFontObjRef);
	__property Classes::TStringList* Widths = {read=FWidths};
	void __fastcall GetFontFile2(Classes::TMemoryStream* &AStream);
	bool __fastcall IsEqual(Graphics::TFont* AFont);
	__property TgtPDFFontInfo* FontInfo = {read=FFontInfo};
	__property System::UnicodeString BaseFont = {read=FBaseFont};
	__property Graphics::TFont* Font = {read=FFont};
	__property bool Subset = {read=FSubset, write=SetSubset, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Graphics::TFontCharset __fastcall GetACPCharset(void);

}	/* namespace Gtpdffont */
using namespace Gtpdffont;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtpdffontHPP
