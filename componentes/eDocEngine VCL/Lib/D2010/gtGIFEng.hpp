// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtgifeng.pas' rev: 21.00

#ifndef GtgifengHPP
#define GtgifengHPP

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
#include <Jpeg.hpp>	// Pascal unit
#include <Gtcstgfxeng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtgifeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtGIFEngine;
class PASCALIMPLEMENTATION TgtGIFEngine : public Gtcstgfxeng::TgtCustomGraphicsEngine
{
	typedef Gtcstgfxeng::TgtCustomGraphicsEngine inherited;
	
public:
	__fastcall virtual TgtGIFEngine(Classes::TComponent* AOwner);
	
protected:
	virtual System::Word __fastcall ShowSetupModal(void);
	virtual void __fastcall EndPage(void);
	
__published:
	__property Monochrome = {default=0};
	__property PixelFormat = {default=6};
public:
	/* TgtCustomGraphicsEngine.Destroy */ inline __fastcall virtual ~TgtGIFEngine(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtgifeng */
using namespace Gtgifeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtgifengHPP
