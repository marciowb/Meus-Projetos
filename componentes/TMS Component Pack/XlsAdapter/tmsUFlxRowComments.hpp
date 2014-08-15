// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuflxrowcomments.pas' rev: 21.00

#ifndef TmsuflxrowcommentsHPP
#define TmsuflxrowcommentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Generics.collections.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Generics.defaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuflxrowcomments
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCommentRowPos;
class PASCALIMPLEMENTATION TCommentRowPos : public Generics_collections::TList__1<int>
{
	typedef Generics_collections::TList__1<int> inherited;
	
public:
	int Row;
public:
	/* TList<Integer>.Create */ inline __fastcall TCommentRowPos(void)/* overload */ : Generics_collections::TList__1<int>() { }
	/* TList<Integer>.Destroy */ inline __fastcall virtual ~TCommentRowPos(void) { }
	
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

}	/* namespace Tmsuflxrowcomments */
using namespace Tmsuflxrowcomments;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuflxrowcommentsHPP
