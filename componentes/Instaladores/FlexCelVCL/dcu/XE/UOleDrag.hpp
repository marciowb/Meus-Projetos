// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UOleDrag.pas' rev: 22.00

#ifndef UoledragHPP
#define UoledragHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit

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
	/* TObject.Create */ inline __fastcall TFlxDropSource(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxDropSource(void) { }
	
private:
	void *__IDropSource;	/* IDropSource */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IDropSource()
	{
		_di_IDropSource intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IDropSource*(void) { return (IDropSource*)&__IDropSource; }
	#endif
	
};


class DELPHICLASS TFlxEnumformatEtc;
class PASCALIMPLEMENTATION TFlxEnumformatEtc : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FIndex;
	
public:
	HRESULT __stdcall Next(int celt, /* out */ void *elt, System::PLongInt pceltFetched);
	HRESULT __stdcall Skip(int celt);
	HRESULT __stdcall Reset(void);
	HRESULT __stdcall Clone(/* out */ _di_IEnumFORMATETC &Enum);
	__fastcall TFlxEnumformatEtc(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxEnumformatEtc(void) { }
	
private:
	void *__IEnumFORMATETC;	/* IEnumFORMATETC */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IEnumFORMATETC()
	{
		_di_IEnumFORMATETC intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IEnumFORMATETC*(void) { return (IEnumFORMATETC*)&__IEnumFORMATETC; }
	#endif
	
};


class DELPHICLASS TFlxDataObject;
class PASCALIMPLEMENTATION TFlxDataObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::UnicodeString FText;
	
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
	__fastcall TFlxDataObject(const System::UnicodeString aText);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TFlxDataObject(void) { }
	
private:
	void *__IDataObject;	/* IDataObject */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IDataObject()
	{
		_di_IDataObject intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IDataObject*(void) { return (IDataObject*)&__IDataObject; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uoledrag */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uoledrag;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UoledragHPP
