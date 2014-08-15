// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlxFullDataSets.pas' rev: 22.00

#ifndef UflxfulldatasetsHPP
#define UflxfulldatasetsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
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
	System::UnicodeString Text;
	int RowOffset;
	int Col;
	__fastcall TFullDataSet(const System::UnicodeString aText, const int aRowOffset, const int aCol);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFullDataSet(void) { }
	
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
	/* TObjectList.Create */ inline __fastcall TFullDataSetList(void)/* overload */ : Contnrs::TObjectList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TFullDataSetList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflxfulldatasets */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflxfulldatasets;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflxfulldatasetsHPP
