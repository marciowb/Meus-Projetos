// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ezip.pas' rev: 21.00

#ifndef EzipHPP
#define EzipHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ezip
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TZipExtractor;
class PASCALIMPLEMENTATION TZipExtractor : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	Classes::TMemoryStream* FStream;
	int FBytesToGo;
	
public:
	__fastcall TZipExtractor(const System::AnsiString InputName, const System::AnsiString OutDir, const System::AnsiString Password);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TZipExtractor(void) { }
	
};


class DELPHICLASS TZipWriter;
class PASCALIMPLEMENTATION TZipWriter : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	unsigned FZipHandle;
	System::AnsiString FPassword;
	
public:
	__fastcall TZipWriter(const System::AnsiString FileName, const System::AnsiString Password);
	__fastcall virtual ~TZipWriter(void);
	void __fastcall AddFile(const System::AnsiString FileName, const System::AnsiString ArchiveFileName);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ezip */
using namespace Ezip;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EzipHPP
