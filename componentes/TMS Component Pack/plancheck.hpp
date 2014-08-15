// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plancheck.pas' rev: 21.00

#ifndef PlancheckHPP
#define PlancheckHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plancheck
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerCheck;
class PASCALIMPLEMENTATION TPlannerCheck : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FGotoItem;
	bool FAutoCorrect;
	bool FAutoMarkError;
	bool FUseCorrect;
	bool FUseMarkError;
	
protected:
	System::UnicodeString __fastcall HiLight(System::UnicodeString s, System::UnicodeString h, System::UnicodeString tag, bool DoCase);
	System::UnicodeString __fastcall ReplaceOnce(const System::UnicodeString S, const System::UnicodeString OldPattern, const System::UnicodeString NewPattern);
	
public:
	virtual System::UnicodeString __fastcall MarkError(System::UnicodeString s);
	virtual System::UnicodeString __fastcall Correct(System::UnicodeString s);
	virtual void __fastcall StartCheck(void);
	virtual void __fastcall StopCheck(void);
	
__published:
	__property bool AutoCorrect = {read=FAutoCorrect, write=FAutoCorrect, nodefault};
	__property bool AutoMarkError = {read=FAutoMarkError, write=FAutoMarkError, nodefault};
	__property bool GotoItem = {read=FGotoItem, write=FGotoItem, nodefault};
	__property bool UseCorrect = {read=FUseCorrect, write=FUseCorrect, nodefault};
	__property bool UseMarkError = {read=FUseMarkError, write=FUseMarkError, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TPlannerCheck(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TPlannerCheck(void) { }
	
};


class DELPHICLASS TCapitalPlannerCheck;
class PASCALIMPLEMENTATION TCapitalPlannerCheck : public TPlannerCheck
{
	typedef TPlannerCheck inherited;
	
public:
	virtual System::UnicodeString __fastcall Correct(System::UnicodeString s);
public:
	/* TComponent.Create */ inline __fastcall virtual TCapitalPlannerCheck(Classes::TComponent* AOwner) : TPlannerCheck(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCapitalPlannerCheck(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Plancheck */
using namespace Plancheck;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlancheckHPP
