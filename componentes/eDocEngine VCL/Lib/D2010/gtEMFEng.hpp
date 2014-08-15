// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtemfeng.pas' rev: 21.00

#ifndef GtemfengHPP
#define GtemfengHPP

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
#include <Gtmetafileeng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstgfxeng.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtemfeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtEMFEngine;
class PASCALIMPLEMENTATION TgtEMFEngine : public Gtmetafileeng::TgtMetafileEngine
{
	typedef Gtmetafileeng::TgtMetafileEngine inherited;
	
protected:
	virtual System::Word __fastcall ShowSetupModal(void);
	
public:
	__fastcall virtual TgtEMFEngine(Classes::TComponent* AOwner);
public:
	/* TgtCustomGraphicsEngine.Destroy */ inline __fastcall virtual ~TgtEMFEngine(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtemfeng */
using namespace Gtemfeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtemfengHPP
