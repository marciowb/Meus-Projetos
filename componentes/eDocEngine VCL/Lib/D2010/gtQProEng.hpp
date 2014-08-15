// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtqproeng.pas' rev: 21.00

#ifndef GtqproengHPP
#define GtqproengHPP

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

namespace Gtqproeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtQuattroProEngine;
class PASCALIMPLEMENTATION TgtQuattroProEngine : public Gtcstspdeng::TgtCustomSpreadSheetEngine
{
	typedef Gtcstspdeng::TgtCustomSpreadSheetEngine inherited;
	
private:
	Classes::TStream* FOutputStream;
	Classes::TMemoryStream* FQProStream;
	
protected:
	virtual void __fastcall Start(void);
	virtual void __fastcall BeginPage(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall EncodeText(Gtcstdoceng::TgtTextItem* AObject);
	virtual int __fastcall AddColorToColorTable(Graphics::TColor AColor);
	virtual System::Word __fastcall ShowSetupModal(void);
	
public:
	__fastcall virtual TgtQuattroProEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtQuattroProEngine(void);
	
__published:
	__property BackgroundColor = {default=16777215};
	__property Brush;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtqproeng */
using namespace Gtqproeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtqproengHPP
