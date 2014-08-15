// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtmetafileeng.pas' rev: 10.00

#ifndef GtmetafileengHPP
#define GtmetafileengHPP

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
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtmetafileeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtMetafileEngine;
class PASCALIMPLEMENTATION TgtMetafileEngine : public Gtcstgfxeng::TgtCustomGraphicsEngine 
{
	typedef Gtcstgfxeng::TgtCustomGraphicsEngine inherited;
	
private:
	bool FEnhanced;
	void __fastcall SetEnhanced(const bool Value);
	
public:
	__fastcall virtual TgtMetafileEngine(Classes::TComponent* AOwner);
	
protected:
	virtual void __fastcall EndPage(void);
	__property bool Enhanced = {read=FEnhanced, write=SetEnhanced, nodefault};
public:
	#pragma option push -w-inl
	/* TgtCustomGraphicsEngine.Destroy */ inline __fastcall virtual ~TgtMetafileEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtmetafileeng */
using namespace Gtmetafileeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtmetafileeng
