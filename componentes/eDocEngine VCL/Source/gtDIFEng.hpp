// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtdifeng.pas' rev: 10.00

#ifndef GtdifengHPP
#define GtdifengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstspdeng.hpp>	// Pascal unit
#include <Gtconsts.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdocutils.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtdifeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtDIFEngine;
class PASCALIMPLEMENTATION TgtDIFEngine : public Gtcstspdeng::TgtCustomSpreadSheetEngine 
{
	typedef Gtcstspdeng::TgtCustomSpreadSheetEngine inherited;
	
private:
	Classes::TStream* FOutputStream;
	Classes::TMemoryStream* FDIFStream;
	int FLastRowNo;
	int FLastColumnNo;
	
protected:
	virtual void __fastcall Start(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual Word __fastcall ShowSetupModal(void);
	
public:
	__fastcall virtual TgtDIFEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtDIFEngine(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtdifeng */
using namespace Gtdifeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtdifeng
