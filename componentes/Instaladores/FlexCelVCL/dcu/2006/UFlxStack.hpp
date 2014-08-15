// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxstack.pas' rev: 10.00

#ifndef UflxstackHPP
#define UflxstackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxstack
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<WideString >  UFlxStack__2;

class DELPHICLASS TStringStack;
class PASCALIMPLEMENTATION TStringStack : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<WideString >  FList;
	int FListCount;
	
public:
	__fastcall TStringStack(void);
	__fastcall virtual ~TStringStack(void);
	int __fastcall Count(void);
	bool __fastcall AtLeast(int ACount);
	virtual void __fastcall Push(const WideString s);
	void __fastcall Pop(/* out */ WideString &s);
	void __fastcall Peek(/* out */ WideString &s);
};


class DELPHICLASS TFormulaStack;
class PASCALIMPLEMENTATION TFormulaStack : public TStringStack 
{
	typedef TStringStack inherited;
	
public:
	WideString FmSpaces;
	WideString FmPreSpaces;
	WideString FmPostSpaces;
	virtual void __fastcall Push(const WideString s);
public:
	#pragma option push -w-inl
	/* TStringStack.Create */ inline __fastcall TFormulaStack(void) : TStringStack() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TStringStack.Destroy */ inline __fastcall virtual ~TFormulaStack(void) { }
	#pragma option pop
	
};


struct TWhiteSpace
{
	
public:
	Byte Count;
	Byte Kind;
} ;

typedef DynamicArray<TWhiteSpace >  UFlxStack__5;

class DELPHICLASS TWhiteSpaceStack;
class PASCALIMPLEMENTATION TWhiteSpaceStack : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	DynamicArray<TWhiteSpace >  FList;
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

}	/* namespace Uflxstack */
using namespace Uflxstack;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxstack
