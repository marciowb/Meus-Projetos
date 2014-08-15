// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxrowcomments.pas' rev: 10.00

#ifndef UflxrowcommentsHPP
#define UflxrowcommentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxrowcomments
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCommentRowPos;
class PASCALIMPLEMENTATION TCommentRowPos : public Classes::TList 
{
	typedef Classes::TList inherited;
	
public:
	int operator[](int index) { return Items[index]; }
	
private:
	int __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const int Value);
	
public:
	int Row;
	HIDESBASE void __fastcall Add(const int i);
	__property int Items[int index] = {read=GetItems, write=SetItems/*, default*/};
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TCommentRowPos(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TCommentRowPos(void) : Classes::TList() { }
	#pragma option pop
	
};


class DELPHICLASS TRowComments;
class PASCALIMPLEMENTATION TRowComments : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TCommentRowPos* operator[](int aRow) { return Items[aRow]; }
	
private:
	TCommentRowPos* EmptySlot;
	TCommentRowPos* __fastcall GetItems(int aRow);
	bool __fastcall Find(const int aRow, /* out */ int &Index);
	
public:
	__fastcall TRowComments(void);
	__fastcall virtual ~TRowComments(void);
	HIDESBASE void __fastcall Add(const int aRow, const int aPos);
	__property TCommentRowPos* Items[int aRow] = {read=GetItems/*, default*/};
	HIDESBASE void __fastcall Delete(const int aRow, const int aCol);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflxrowcomments */
using namespace Uflxrowcomments;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxrowcomments
