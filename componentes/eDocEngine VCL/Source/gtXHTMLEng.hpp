// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtxhtmleng.pas' rev: 10.00

#ifndef GtxhtmlengHPP
#define GtxhtmlengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gthtmleng.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtexhtmleng.hpp>	// Pascal unit
#include <Gtcsthtmleng.hpp>	// Pascal unit
#include <Gtcstplneng.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtxhtmleng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtXHTMLEngine;
class PASCALIMPLEMENTATION TgtXHTMLEngine : public Gthtmleng::TgtHTMLEngine 
{
	typedef Gthtmleng::TgtHTMLEngine inherited;
	
protected:
	virtual AnsiString __fastcall AddXHTMLHeader();
	virtual Word __fastcall ShowSetupModal(void);
	
public:
	__fastcall virtual TgtXHTMLEngine(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TgtExHTMLEngine.Destroy */ inline __fastcall virtual ~TgtXHTMLEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtxhtmleng */
using namespace Gtxhtmleng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtxhtmleng
