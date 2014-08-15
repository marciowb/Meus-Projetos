// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuflxstack.pas' rev: 21.00

#ifndef TmsuflxstackHPP
#define TmsuflxstackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuflxstack
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TStringStack;
class PASCALIMPLEMENTATION TStringStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef DynamicArray<System::UnicodeString> _TStringStack__1;
	
	
private:
	_TStringStack__1 FList;
	int FListCount;
	
public:
	__fastcall TStringStack(void);
	__fastcall virtual ~TStringStack(void);
	int __fastcall Count(void);
	bool __fastcall AtLeast(int ACount);
	virtual void __fastcall Push(const System::UnicodeString s);
	void __fastcall Pop(/* out */ System::UnicodeString &s);
	void __fastcall Peek(/* out */ System::UnicodeString &s);
};


class DELPHICLASS TFormulaStack;
class PASCALIMPLEMENTATION TFormulaStack : public TStringStack
{
	typedef TStringStack inherited;
	
public:
	System::UnicodeString FmSpaces;
	System::UnicodeString FmPreSpaces;
	System::UnicodeString FmPostSpaces;
	virtual void __fastcall Push(const System::UnicodeString s);
public:
	/* TStringStack.Create */ inline __fastcall TFormulaStack(void) : TStringStack() { }
	/* TStringStack.Destroy */ inline __fastcall virtual ~TFormulaStack(void) { }
	
};


struct TWhiteSpace
{
	
public:
	System::Byte Count;
	System::Byte Kind;
};


class DELPHICLASS TWhiteSpaceStack;
class PASCALIMPLEMENTATION TWhiteSpaceStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef DynamicArray<TWhiteSpace> _TWhiteSpaceStack__1;
	
	
private:
	_TWhiteSpaceStack__1 FList;
	int FListCount;
	
public:
	__fastcall TWhiteSpaceStack(void);
	__fastcall virtual ~TWhiteSpaceStack(void);
	int __fastcall Count(void);
	bool __fastcall AtLeast(int ACount);
	virtual void __fastcall Push(const TWhiteSpace s);
	void __fastcall Pop(/* out */ TWhiteSpace &s);
	void __fastcall Peek(/* out */ TWhiteSpace &s);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuflxstack */
using namespace Tmsuflxstack;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuflxstackHPP
