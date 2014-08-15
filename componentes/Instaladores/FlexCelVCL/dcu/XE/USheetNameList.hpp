// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'USheetNameList.pas' rev: 22.00

#ifndef UsheetnamelistHPP
#define UsheetnamelistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Usheetnamelist
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TWideContainer
{
	
public:
	System::UnicodeString S;
	int n;
};


typedef TWideContainer *PWideContainer;

class DELPHICLASS TSheetNameList;
class PASCALIMPLEMENTATION TSheetNameList : public Classes::TList
{
	typedef Classes::TList inherited;
	
protected:
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	System::UnicodeString __fastcall GetFullName(const System::UnicodeString S, const int N);
	
public:
	HIDESBASE void __fastcall Add(const System::UnicodeString aName);
	System::UnicodeString __fastcall AddUniqueName(const System::UnicodeString aName);
	__classmethod System::UnicodeString __fastcall MakeValidSheetName(const System::UnicodeString aName);
	void __fastcall DeleteSheet(const System::UnicodeString SheetName);
	void __fastcall Rename(const System::UnicodeString OldName, const System::UnicodeString NewName);
	virtual bool __fastcall FindRootString(const System::UnicodeString S, /* out */ int &Index);
	virtual bool __fastcall FindFullString(const System::UnicodeString S, /* out */ int &Index);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSheetNameList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TSheetNameList(void) : Classes::TList() { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Usheetnamelist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Usheetnamelist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UsheetnamelistHPP
