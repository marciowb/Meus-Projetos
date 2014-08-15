// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtjpegeng.pas' rev: 10.00

#ifndef GtjpegengHPP
#define GtjpegengHPP

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

namespace Gtjpegeng
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TgtJPEGEngine;
class PASCALIMPLEMENTATION TgtJPEGEngine : public Gtcstgfxeng::TgtCustomGraphicsEngine 
{
	typedef Gtcstgfxeng::TgtCustomGraphicsEngine inherited;
	
private:
	bool FProgressiveEncoding;
	Jpeg::TJPEGQualityRange FQuality;
	void __fastcall SetProgressiveEncoding(const bool Value);
	void __fastcall SetQuality(const Jpeg::TJPEGQualityRange Value);
	
public:
	__fastcall virtual TgtJPEGEngine(Classes::TComponent* AOwner);
	
protected:
	virtual void __fastcall EndPage(void);
	virtual Word __fastcall ShowSetupModal(void);
	
__published:
	__property bool ProgressiveEncoding = {read=FProgressiveEncoding, write=SetProgressiveEncoding, default=0};
	__property Jpeg::TJPEGQualityRange Quality = {read=FQuality, write=SetQuality, default=100};
	__property Monochrome  = {default=0};
	__property PixelFormat  = {default=6};
public:
	#pragma option push -w-inl
	/* TgtCustomGraphicsEngine.Destroy */ inline __fastcall virtual ~TgtJPEGEngine(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtjpegeng */
using namespace Gtjpegeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gtjpegeng
