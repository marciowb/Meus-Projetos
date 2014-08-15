// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtpngeng.pas' rev: 21.00

#ifndef GtpngengHPP
#define GtpngengHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit
#include <Gtcstgfxeng.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtdzlib.hpp>	// Pascal unit
#include <Gtfilters.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtdocresstrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtpngeng
{
//-- type declarations -------------------------------------------------------
typedef ShortInt TgtPercentage;

#pragma option push -b-
enum TgtPNGColorType { ctGrayscale, ctRGB, ctRGBA, ctGrayAlpha };
#pragma option pop

#pragma option push -b-
enum TgtPNGTxtKeyWord { tkTitle, tkAuthor, tkDescription, tkCopyright, tkCreateTime, tkSoftware, tkDisclaimer, tkWarning, tkSource, tkComment };
#pragma option pop

#pragma option push -b-
enum TgtPNGUnitSpecifier { usNone, usMeter };
#pragma option pop

class DELPHICLASS TgtPNGPixelDimensions;
class PASCALIMPLEMENTATION TgtPNGPixelDimensions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	unsigned FXPixelsPerUnit;
	unsigned FYPixelsPerUnit;
	TgtPNGUnitSpecifier FUnitSpecifier;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetUnitSpecifier(const TgtPNGUnitSpecifier Value);
	void __fastcall SetXPixelsPerUnit(const unsigned Value);
	void __fastcall SetYPixelsPerUnit(const unsigned Value);
	
public:
	__fastcall TgtPNGPixelDimensions(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property unsigned XPixelsPerUnit = {read=FXPixelsPerUnit, write=SetXPixelsPerUnit, default=1};
	__property unsigned YPixelsPerUnit = {read=FYPixelsPerUnit, write=SetYPixelsPerUnit, default=1};
	__property TgtPNGUnitSpecifier UnitSpecifier = {read=FUnitSpecifier, write=SetUnitSpecifier, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TgtPNGPixelDimensions(void) { }
	
};


class DELPHICLASS TgtPNGTransparency;
class PASCALIMPLEMENTATION TgtPNGTransparency : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TgtPNGColorType FColorType;
	bool FEnabled;
	Byte FImageAlpha;
	Graphics::TColor FTransColor;
	TgtPercentage __fastcall GetAlphaPercent(void);
	void __fastcall SetAlphaPercent(const TgtPercentage Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetTransColor(const Graphics::TColor Value);
	
public:
	__fastcall TgtPNGTransparency(TgtPNGColorType AColorType);
	System::Byte __fastcall GetAlphaValue(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property TgtPercentage ImageAlpha = {read=GetAlphaPercent, write=SetAlphaPercent, default=0};
	__property Graphics::TColor TransColor = {read=FTransColor, write=SetTransColor, default=16777215};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TgtPNGTransparency(void) { }
	
};


class DELPHICLASS TgtPNGEngine;
class PASCALIMPLEMENTATION TgtPNGEngine : public Gtcstgfxeng::TgtCustomGraphicsEngine
{
	typedef Gtcstgfxeng::TgtCustomGraphicsEngine inherited;
	
private:
	StaticArray<unsigned, 256> FCrcTable;
	TgtPNGTransparency* FTransparency;
	TgtPNGPixelDimensions* FPixelDimensions;
	TgtPNGColorType FColorType;
	void __fastcall WritezTXt(Gtclasses::TgtExtMemStream* AStream, TgtPNGTxtKeyWord AKeyword, System::UnicodeString AString);
	void __fastcall SetColorType(const TgtPNGColorType Value);
	void __fastcall SetTransparency(const TgtPNGTransparency* Value);
	void __fastcall GetRGB(const int AColor, /* out */ System::Byte &ARed, /* out */ System::Byte &AGreen, /* out */ System::Byte &ABlue);
	unsigned __fastcall GetCRC(Gtclasses::TgtExtMemStream* AStream);
	void __fastcall SetPixelDimensions(const TgtPNGPixelDimensions* Value);
	
protected:
	virtual void __fastcall EndPage(void);
	virtual System::Word __fastcall ShowSetupModal(void);
	
public:
	__fastcall virtual TgtPNGEngine(Classes::TComponent* AOwner);
	__fastcall virtual ~TgtPNGEngine(void);
	
__published:
	__property TgtPNGColorType ColorType = {read=FColorType, write=SetColorType, default=1};
	__property TgtPNGTransparency* Transparency = {read=FTransparency, write=SetTransparency};
	__property TgtPNGPixelDimensions* PixelDimensions = {read=FPixelDimensions, write=SetPixelDimensions};
	__property DocInfo;
	__property FileExtension;
	__property FileDescription;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Gtpngeng */
using namespace Gtpngeng;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtpngengHPP
