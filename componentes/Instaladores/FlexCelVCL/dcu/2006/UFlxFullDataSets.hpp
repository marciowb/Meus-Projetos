// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxfulldatasets.pas' rev: 10.00

#ifndef UflxfulldatasetsHPP
#define UflxfulldatasetsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxfulldatasets
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFullDataSet;
class PASCALIMPLEMENTATION TFullDataSet : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString Text;
	int RowOffset;
	int Col;
	__fastcall TFullDataSet(const AnsiString aText, const int aRowOffset, const int aCol);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFullDataSet(void) { }
	#pragma option pop
	
};


class DELPHICLASS TFullDataSetList;
class PASCALIMPLEMENTATION TFullDataSetList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TFullDataSet* operator[](int index) { return Items[index]; }
	
private:
	TFullDataSet* __fastcall GetItems(int index);
	
public:
	__property TFullDataSet* Items[int index] = {read=GetItems/*, default*/};
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TFullDataSetList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TFullDataSetList(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflxfulldatasets */
using namespace Uflxfulldatasets;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxfulldatasets
