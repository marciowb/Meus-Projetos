// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtbmpeng.pas' rev: 10.00

#ifndef GtbmpengHPP
#define GtbmpengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gtcstgfxeng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtbmpeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtBMPEngine;
class PASCALIMPLEMENTATION TgtBMPEngine : public Gtcstgfxeng::TgtCustomGraphicsEngine 
{
	typedef Gtcstgfxeng::TgtCustomGraphicsEngine inherited;
	
public:
	__fastcall virtual TgtBMPEngine(Classes::TComponent* AOwner);
	
protected:
	virtual void __fastcall EndPage(void);
	virtual Word __fastcall ShowSetupModal(void);
	
__published:
	__property PixelFormat  = {default=6};
	__property Monochrome  = {default=0};
public:
	#pragma option push -w-inl
	/* TgtCustomGraphicsEngine.Destroy */ inline __fastcall virtual ~TgtBMPEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtbmpeng */
using namespace Gtbmpeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtbmpeng
