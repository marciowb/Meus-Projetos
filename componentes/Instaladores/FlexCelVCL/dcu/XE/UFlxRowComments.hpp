// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlxRowComments.pas' rev: 22.00

#ifndef UflxrowcommentsHPP
#define UflxrowcommentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Generics.Collections.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Generics.Defaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxrowcomments
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCommentRowPos;
class PASCALIMPLEMENTATION TCommentRowPos : public Generics_collections::TList__1<int>
{
	typedef Generics_collections::TList__1<int> inherited;
	
public:
	int Row;
public:
	/* {Generics_Collections}TList<System_Integer>.Create */ inline __fastcall TCommentRowPos(void)/* overload */ : Generics_collections::TList__1<int>() { }
	/* {Generics_Collections}TList<System_Integer>.Destroy */ inline __fastcall virtual ~TCommentRowPos(void) { }
	
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
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflxrowcomments;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflxrowcommentsHPP
