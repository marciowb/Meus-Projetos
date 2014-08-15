// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uoledrag.pas' rev: 10.00

#ifndef UoledragHPP
#define UoledragHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uoledrag
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlxDropSource;
class PASCALIMPLEMENTATION TFlxDropSource : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
public:
	HRESULT __stdcall QueryContinueDrag(BOOL fEscapePressed, int grfKeyState);
	HRESULT __stdcall GiveFeedback(int dwEffect);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TFlxDropSource(void) : System::TInterfacedObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxDropSource(void) { }
	#pragma option pop
	
private:
	void *__IDropSource;	/* IDropSource */
	
public:
	operator IDropSource*(void) { return (IDropSource*)&__IDropSource; }
	
};


class DELPHICLASS TFlxEnumformatEtc;
class PASCALIMPLEMENTATION TFlxEnumformatEtc : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FIndex;
	
public:
	HRESULT __stdcall Next(int celt, /* out */ void *elt, PLongint pceltFetched);
	HRESULT __stdcall Skip(int celt);
	HRESULT __stdcall Reset(void);
	HRESULT __stdcall Clone(/* out */ _di_IEnumFORMATETC &Enum);
	__fastcall TFlxEnumformatEtc(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxEnumformatEtc(void) { }
	#pragma option pop
	
private:
	void *__IEnumFORMATETC;	/* IEnumFORMATETC */
	
public:
	operator IEnumFORMATETC*(void) { return (IEnumFORMATETC*)&__IEnumFORMATETC; }
	
};


class DELPHICLASS TFlxDataObject;
class PASCALIMPLEMENTATION TFlxDataObject : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	AnsiString FText;
	
public:
	HRESULT __stdcall GetData(const tagFORMATETC &formatetcIn, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall GetDataHere(const tagFORMATETC &formatetc, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall QueryGetData(const tagFORMATETC &formatetc);
	HRESULT __stdcall GetCanonicalFormatEtc(const tagFORMATETC &formatetc, /* out */ tagFORMATETC &formatetcOut);
	HRESULT __stdcall SetData(const tagFORMATETC &formatetc, tagSTGMEDIUM &medium, BOOL fRelease);
	HRESULT __stdcall EnumFormatEtc(int dwDirection, /* out */ _di_IEnumFORMATETC &enumFormatEtc);
	HRESULT __stdcall DAdvise(const tagFORMATETC &formatetc, int advf, const _di_IAdviseSink advSink, /* out */ int &dwConnection);
	HRESULT __stdcall DUnadvise(int dwConnection);
	HRESULT __stdcall EnumDAdvise(/* out */ _di_IEnumSTATDATA &enumAdvise);
	__fastcall TFlxDataObject(const AnsiString aText);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxDataObject(void) { }
	#pragma option pop
	
private:
	void *__IDataObject;	/* IDataObject */
	
public:
	operator IDataObject*(void) { return (IDataObject*)&__IDataObject; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uoledrag */
using namespace Uoledrag;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uoledrag
