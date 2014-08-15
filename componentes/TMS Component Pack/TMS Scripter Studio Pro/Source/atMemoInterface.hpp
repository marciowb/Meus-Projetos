// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMemoInterface.pas' rev: 22.00

#ifndef AtmemointerfaceHPP
#define AtmemointerfaceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <AdvMemo.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmemointerface
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatMemoInterface;
class PASCALIMPLEMENTATION TatMemoInterface : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advmemo::TAdvCustomMemo* FMemo;
	Atscript::TatCustomScripter* FScripter;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	bool __fastcall GetTokenHint(System::UnicodeString AToken, System::UnicodeString &AHint);
	void __fastcall GetCompletion(System::UnicodeString AToken, Classes::TStringList* AList);
	
__published:
	__property Atscript::TatCustomScripter* Scripter = {read=FScripter, write=FScripter};
	__property Advmemo::TAdvCustomMemo* Memo = {read=FMemo, write=FMemo};
public:
	/* TComponent.Create */ inline __fastcall virtual TatMemoInterface(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TatMemoInterface(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmemointerface */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmemointerface;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmemointerfaceHPP
