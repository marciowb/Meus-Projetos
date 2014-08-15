// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Usheetnamelist.pas' rev: 10.00

#ifndef UsheetnamelistHPP
#define UsheetnamelistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Usheetnamelist
{
//-- type declarations -------------------------------------------------------
struct TWideContainer
{
	
public:
	WideString S;
	int n;
} ;

typedef TWideContainer *PWideContainer;

class DELPHICLASS TSheetNameList;
class PASCALIMPLEMENTATION TSheetNameList : public Classes::TList 
{
	typedef Classes::TList inherited;
	
protected:
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	WideString __fastcall GetFullName(const WideString S, const int N);
	
public:
	HIDESBASE void __fastcall Add(const WideString aName);
	WideString __fastcall AddUniqueName(const WideString aName);
	/*         class method */ static WideString __fastcall MakeValidSheetName(TMetaClass* vmt, const WideString aName);
	void __fastcall DeleteSheet(const WideString SheetName);
	void __fastcall Rename(const WideString OldName, const WideString NewName);
	virtual bool __fastcall FindRootString(const WideString S, /* out */ int &Index);
	virtual bool __fastcall FindFullString(const WideString S, /* out */ int &Index);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TSheetNameList(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TSheetNameList(void) : Classes::TList() { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Usheetnamelist */
using namespace Usheetnamelist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Usheetnamelist
