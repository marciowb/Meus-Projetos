// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Webconnect.pas' rev: 21.00

#ifndef WebconnectHPP
#define WebconnectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Webconnect
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWebConnectType { wctModem, wctLan, wctNone };
#pragma option pop

class DELPHICLASS TWebConnect;
class PASCALIMPLEMENTATION TWebConnect : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FConnect;
	bool FPrompt;
	bool FActive;
	void __fastcall SetConnect(const bool Value);
	bool __fastcall GetConnectedState(void);
	TWebConnectType __fastcall GetWebConnectType(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
public:
	__property bool Connected = {read=GetConnectedState, nodefault};
	__property TWebConnectType ConnectionType = {read=GetWebConnectType, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=FActive, nodefault};
	__property bool Connect = {read=FConnect, write=SetConnect, nodefault};
	__property bool Prompt = {read=FPrompt, write=FPrompt, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TComponent.Create */ inline __fastcall virtual TWebConnect(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TWebConnect(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Webconnect */
using namespace Webconnect;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WebconnectHPP
