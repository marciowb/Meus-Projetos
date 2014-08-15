// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uVBScriptLibrary.pas' rev: 22.00

#ifndef UvbscriptlibraryHPP
#define UvbscriptlibraryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uvbscriptlibrary
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatVBScriptLibrary;
class PASCALIMPLEMENTATION TatVBScriptLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
private:
	void __fastcall __Asc(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Atn(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CBool(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CByte(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CCur(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CDate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CDbl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CInt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CreateObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CSng(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DateValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Day(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Hex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Hour(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InStr(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Fix(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Int(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsArray(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsDate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsEmpty(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsNull(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsNumeric(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LBound(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LCase(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UBound(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __UCase(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Left(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Len(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Log(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __LTrim(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RTrim(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Mid(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Minute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Month(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MonthName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Replace(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Right(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Rnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Second(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Sgn(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Space(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StrComp(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __String(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Timer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TimeSerial(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TimeValue(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Weekday(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __WeekdayName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Year(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DateSerial(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FormatNumber(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FormatCurrency(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FormatDateTime(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MsgBox(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InputBox(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DatePart(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Redim(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __RedimPreserve(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Split(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Join(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StrReverse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Randomize(Atscript::TatVirtualMachine* AMachine);
	
protected:
	virtual void __fastcall Init(void);
	
public:
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatVBScriptLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatVBScriptLibrary(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uvbscriptlibrary */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uvbscriptlibrary;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UvbscriptlibraryHPP
