// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtfilters.pas' rev: 21.00

#ifndef GtfiltersHPP
#define GtfiltersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtutils.hpp>	// Pascal unit
#include <Gtdzlib.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtfilters
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtFilter;
class PASCALIMPLEMENTATION TgtFilter : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual Classes::TMemoryStream* __fastcall Encode(Classes::TMemoryStream* AStream, Gtdzlib::TCompressionLevel ALevel)/* overload */;
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString AString, Gtdzlib::TCompressionLevel ALevel)/* overload */;
	virtual Classes::TMemoryStream* __fastcall Encode(Classes::TMemoryStream* AStream)/* overload */;
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString AString)/* overload */;
	virtual Classes::TMemoryStream* __fastcall Decode(Classes::TMemoryStream* AStream) = 0 /* overload */;
	virtual System::UnicodeString __fastcall Decode(const System::UnicodeString AString) = 0 /* overload */;
public:
	/* TObject.Create */ inline __fastcall TgtFilter(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtFilter(void) { }
	
};


class DELPHICLASS TgtAscii85Filter;
class PASCALIMPLEMENTATION TgtAscii85Filter : public TgtFilter
{
	typedef TgtFilter inherited;
	
public:
	virtual Classes::TMemoryStream* __fastcall Encode(Classes::TMemoryStream* AStream)/* overload */;
	virtual Classes::TMemoryStream* __fastcall Decode(Classes::TMemoryStream* AStream)/* overload */;
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString AString)/* overload */;
	virtual System::UnicodeString __fastcall Decode(const System::UnicodeString AString)/* overload */;
public:
	/* TObject.Create */ inline __fastcall TgtAscii85Filter(void) : TgtFilter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtAscii85Filter(void) { }
	
	
/* Hoisted overloads: */
	
protected:
	inline Classes::TMemoryStream* __fastcall  Encode(Classes::TMemoryStream* AStream, Gtdzlib::TCompressionLevel ALevel){ return TgtFilter::Encode(AStream, ALevel); }
	inline System::UnicodeString __fastcall  Encode(const System::UnicodeString AString, Gtdzlib::TCompressionLevel ALevel){ return TgtFilter::Encode(AString, ALevel); }
	
};


class DELPHICLASS TgtAsciiHexFilter;
class PASCALIMPLEMENTATION TgtAsciiHexFilter : public TgtFilter
{
	typedef TgtFilter inherited;
	
public:
	virtual Classes::TMemoryStream* __fastcall Encode(Classes::TMemoryStream* AStream)/* overload */;
	virtual Classes::TMemoryStream* __fastcall Decode(Classes::TMemoryStream* AStream)/* overload */;
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString AString)/* overload */;
	virtual System::UnicodeString __fastcall Decode(const System::UnicodeString AString)/* overload */;
public:
	/* TObject.Create */ inline __fastcall TgtAsciiHexFilter(void) : TgtFilter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtAsciiHexFilter(void) { }
	
	
/* Hoisted overloads: */
	
protected:
	inline Classes::TMemoryStream* __fastcall  Encode(Classes::TMemoryStream* AStream, Gtdzlib::TCompressionLevel ALevel){ return TgtFilter::Encode(AStream, ALevel); }
	inline System::UnicodeString __fastcall  Encode(const System::UnicodeString AString, Gtdzlib::TCompressionLevel ALevel){ return TgtFilter::Encode(AString, ALevel); }
	
};


class DELPHICLASS TgtFlateFilter;
class PASCALIMPLEMENTATION TgtFlateFilter : public TgtFilter
{
	typedef TgtFilter inherited;
	
public:
	virtual Classes::TMemoryStream* __fastcall Encode(Classes::TMemoryStream* AStream, Gtdzlib::TCompressionLevel ALevel)/* overload */;
	virtual Classes::TMemoryStream* __fastcall Decode(Classes::TMemoryStream* AStream)/* overload */;
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString AString, Gtdzlib::TCompressionLevel ALevel)/* overload */;
	virtual System::UnicodeString __fastcall Decode(const System::UnicodeString AString)/* overload */;
public:
	/* TObject.Create */ inline __fastcall TgtFlateFilter(void) : TgtFilter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtFlateFilter(void) { }
	
	
/* Hoisted overloads: */
	
protected:
	inline Classes::TMemoryStream* __fastcall  Encode(Classes::TMemoryStream* AStream){ return TgtFilter::Encode(AStream); }
	inline System::UnicodeString __fastcall  Encode(const System::UnicodeString AString){ return TgtFilter::Encode(AString); }
	
};


class DELPHICLASS TgtRLEFilter;
class PASCALIMPLEMENTATION TgtRLEFilter : public TgtFilter
{
	typedef TgtFilter inherited;
	
public:
	virtual Classes::TMemoryStream* __fastcall Encode(Classes::TMemoryStream* AStream)/* overload */;
	virtual Classes::TMemoryStream* __fastcall Decode(Classes::TMemoryStream* AStream)/* overload */;
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString AString)/* overload */;
	virtual System::UnicodeString __fastcall Decode(const System::UnicodeString AString)/* overload */;
public:
	/* TObject.Create */ inline __fastcall TgtRLEFilter(void) : TgtFilter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TgtRLEFilter(void) { }
	
	
/* Hoisted overloads: */
	
protected:
	inline Classes::TMemoryStream* __fastcall  Encode(Classes::TMemoryStream* AStream, Gtdzlib::TCompressionLevel ALevel){ return TgtFilter::Encode(AStream, ALevel); }
	inline System::UnicodeString __fastcall  Encode(const System::UnicodeString AString, Gtdzlib::TCompressionLevel ALevel){ return TgtFilter::Encode(AString, ALevel); }
	
};


class DELPHICLASS TgtLZWFilter;
class PASCALIMPLEMENTATION TgtLZWFilter : public TgtFilter
{
	typedef TgtFilter inherited;
	
private:
	Classes::TStringList* LZWDictionary;
	void __fastcall InitializeTable(void);
	
public:
	__fastcall TgtLZWFilter(void);
	__fastcall virtual ~TgtLZWFilter(void);
	virtual Classes::TMemoryStream* __fastcall Decode(Classes::TMemoryStream* AStream)/* overload */;
	virtual System::UnicodeString __fastcall Decode(const System::UnicodeString AString)/* overload */;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtfilters */
using namespace Gtfilters;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtfiltersHPP
