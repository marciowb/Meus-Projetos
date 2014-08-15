// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planproppref.pas' rev: 21.00

#ifndef PlanpropprefHPP
#define PlanpropprefHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Planproppref
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall StoreProperties(Classes::TComponent* AComponent, Classes::TStream* AStream, bool Position);
extern PACKAGE void __fastcall RestoreProperties(Classes::TComponent* AComponent, Classes::TStream* AStream, bool Position);
extern PACKAGE void __fastcall StorePropertiesToFile(Classes::TComponent* AComponent, System::UnicodeString FileName);
extern PACKAGE void __fastcall RestorePropertiesToFile(Classes::TComponent* AComponent, System::UnicodeString FileName);

}	/* namespace Planproppref */
using namespace Planproppref;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlanpropprefHPP
