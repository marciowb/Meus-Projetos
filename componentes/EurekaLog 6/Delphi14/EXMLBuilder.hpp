// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Exmlbuilder.pas' rev: 21.00

#ifndef ExmlbuilderHPP
#define ExmlbuilderHPP

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

namespace Exmlbuilder
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TXMLItems;
class DELPHICLASS TXMLItem;
class PASCALIMPLEMENTATION TXMLItems : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	TXMLItem* operator[](int Index) { return Items[Index]; }
	
private:
	TXMLItem* __fastcall GetItem(int Index);
	
public:
	__fastcall virtual ~TXMLItems(void);
	TXMLItem* __fastcall AddItem(const System::AnsiString ItemName);
	__property TXMLItem* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TObject.Create */ inline __fastcall TXMLItems(void) : Classes::TList() { }
	
};


class PASCALIMPLEMENTATION TXMLItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::AnsiString FName;
	System::AnsiString FValue;
	System::AnsiString FEncodedValue;
	System::AnsiString FFields;
	System::AnsiString FSpaces;
	TXMLItems* FItems;
	TXMLItem* FParent;
	System::AnsiString __fastcall GetXMLText(void);
	void __fastcall SetValue(const System::AnsiString Value);
	
protected:
	System::AnsiString __fastcall EncodedString(const System::AnsiString Value);
	void __fastcall AppendXMLText(System::AnsiString &Text);
	
public:
	__fastcall TXMLItem(System::AnsiString AName);
	__fastcall virtual ~TXMLItem(void);
	void __fastcall SaveXMLToFile(const System::AnsiString FileName);
	void __fastcall AddField(const System::AnsiString FieldName, const System::AnsiString FieldValue);
	TXMLItem* __fastcall AddItem(const System::AnsiString ItemName);
	__property System::AnsiString Name = {read=FName, write=FName};
	__property System::AnsiString Value = {read=FValue, write=SetValue};
	__property TXMLItem* Parent = {read=FParent, write=FParent};
	__property System::AnsiString XMLText = {read=GetXMLText};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Exmlbuilder */
using namespace Exmlbuilder;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ExmlbuilderHPP
