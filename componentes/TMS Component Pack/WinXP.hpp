// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winxp.pas' rev: 21.00

#ifndef WinxpHPP
#define WinxpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winxp
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinXP;
class PASCALIMPLEMENTATION TWinXP : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
public:
	__fastcall virtual TWinXP(Classes::TComponent* AOwner);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TWinXP(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Winxp */
using namespace Winxp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WinxpHPP
