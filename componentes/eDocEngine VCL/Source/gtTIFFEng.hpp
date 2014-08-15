// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gttiffeng.pas' rev: 10.00

#ifndef GttiffengHPP
#define GttiffengHPP

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
#include <Gtdzlib.hpp>	// Pascal unit
#include <Gtfilters.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtcstgfxeng.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gttiffeng
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TgtTIFFCompressionType { ctNone, ctPackBits, ctZip };
#pragma option pop

class DELPHICLASS TgtTIFFEngine;
class PASCALIMPLEMENTATION TgtTIFFEngine : public Gtcstgfxeng::TgtCustomGraphicsEngine 
{
	typedef Gtcstgfxeng::TgtCustomGraphicsEngine inherited;
	
private:
	Classes::TStream* FTIFFStream;
	Classes::TList* FImgSizes;
	Classes::TList* FHeights;
	Classes::TList* FWidths;
	bool FGrayscale;
	bool FMultiPage;
	int FImageCount;
	TgtTIFFCompressionType FTIFFCompressionType;
	void __fastcall InitTIFF(void);
	void __fastcall CreateTIFF(void);
	void __fastcall EndTIFF(void);
	void __fastcall WriteWord(Word * ABuf, const int ABuf_Size, Classes::TStream* AStream);
	void __fastcall SetGrayscale(const bool Value);
	void __fastcall SetTIFFCompressionType(const TgtTIFFCompressionType Value);
	void __fastcall SetMultiPage(const bool Value);
	
public:
	__fastcall virtual TgtTIFFEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtTIFFEngine(void);
	
protected:
	virtual Word __fastcall ShowSetupModal(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall Start(void);
	virtual void __fastcall Finish(void);
	
__published:
	__property bool Grayscale = {read=FGrayscale, write=SetGrayscale, default=0};
	__property TgtTIFFCompressionType CompressionType = {read=FTIFFCompressionType, write=SetTIFFCompressionType, default=2};
	__property bool MultiPage = {read=FMultiPage, write=SetMultiPage, default=1};
	__property DocInfo ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gttiffeng */
using namespace Gttiffeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gttiffeng
