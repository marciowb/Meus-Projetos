// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmenuutil.pas' rev: 21.00

#ifndef AdvmenuutilHPP
#define AdvmenuutilHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmenuutil
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EInvalidPropertyIndex;
class PASCALIMPLEMENTATION EInvalidPropertyIndex : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EInvalidPropertyIndex(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EInvalidPropertyIndex(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EInvalidPropertyIndex(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EInvalidPropertyIndex(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EInvalidPropertyIndex(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidPropertyIndex(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EInvalidPropertyIndex(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidPropertyIndex(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EInvalidPropertyIndex(void) { }
	
};


class DELPHICLASS ERequireOwner;
class PASCALIMPLEMENTATION ERequireOwner : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ERequireOwner(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ERequireOwner(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ERequireOwner(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ERequireOwner(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ERequireOwner(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ERequireOwner(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ERequireOwner(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ERequireOwner(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ERequireOwner(void) { }
	
};


struct TColorQuad
{
	
public:
	System::Byte Red;
	System::Byte Green;
	System::Byte Blue;
	System::Byte Alpha;
};


struct TSmallColorQuad
{
	
public:
	System::Byte Red;
	System::Byte Green;
	System::Byte Blue;
};


struct TLargeColorQuad
{
	
public:
	int Red;
	int Green;
	int Blue;
	int Alpha;
};


struct T24bitScanLineElement
{
	
public:
	System::Byte Blue;
	System::Byte Green;
	System::Byte Red;
};


struct T32bitScanLineElement
{
	
public:
	System::Byte Blue;
	System::Byte Green;
	System::Byte Red;
	System::Byte Alpha;
};


typedef StaticArray<T24bitScanLineElement, 21846> T24bitQuadScanLine;

typedef T24bitQuadScanLine *P24bitQuadScanLine;

typedef StaticArray<T32bitScanLineElement, 21846> T32bitQuadScanLine;

typedef T32bitQuadScanLine *P32bitQuadScanLine;

typedef Byte TOpacity;

typedef BOOL __stdcall (*TSetLayeredWindowAttributes)(unsigned hWnd, unsigned crKey, System::Byte bAlpha, unsigned dwFlags);

typedef BOOL __stdcall (*TUpdateLayeredWindow)(unsigned hWnd, HDC hdcDst, Types::PPoint pptDst, Types::PSize psize, HDC hdcSrc, Types::PPoint pptSrc, unsigned crKey, Windows::PBlendFunction pblend, unsigned dwFlags);

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _SInvalidPropertyIndexAt;
#define Advmenuutil_SInvalidPropertyIndexAt System::LoadResourceString(&Advmenuutil::_SInvalidPropertyIndexAt)
extern PACKAGE System::ResourceString _SInvalidPropertyIndex;
#define Advmenuutil_SInvalidPropertyIndex System::LoadResourceString(&Advmenuutil::_SInvalidPropertyIndex)
extern PACKAGE System::ResourceString _SRequireOwner;
#define Advmenuutil_SRequireOwner System::LoadResourceString(&Advmenuutil::_SRequireOwner)
static const ShortInt LWA_ALPHA = 0x2;
static const ShortInt LWA_COLORKEY = 0x1;
static const ShortInt ULW_COLORKEY = 0x1;
static const ShortInt ULW_ALPHA = 0x2;
static const ShortInt ULW_OPAQUE = 0x4;
static const ShortInt AC_SRC_ALPHA = 0x1;
static const int WS_EX_LAYERED = 0x80000;
extern PACKAGE Types::TRect NilRect;
extern PACKAGE TUpdateLayeredWindow UpdateLayeredWindow;
extern PACKAGE TSetLayeredWindowAttributes SetLayeredWindowAttributes;
extern PACKAGE HFONT __fastcall CreateRotatedFont(Graphics::TFont* F, const int Angle);
extern PACKAGE bool __fastcall RectInRect(const Types::TRect &Source, const Types::TRect &Target);
extern PACKAGE int __fastcall RectWidth(const Types::TRect &ARect);
extern PACKAGE int __fastcall RectHeight(const Types::TRect &ARect);
extern PACKAGE Types::TPoint __fastcall CenterPoint(const Types::TRect &Rect);
extern PACKAGE void __fastcall CenterRect(Types::TRect &Rect, const int Width, const int Height);
extern PACKAGE Types::TRect __fastcall BitmapRect(const Graphics::TBitmap* ABitmap);
extern PACKAGE void __fastcall ColorToRGBVal(Graphics::TColor AColor, int &R, int &G, int &B);
extern PACKAGE T24bitScanLineElement __fastcall ColorTo24bitScanLineElement(Graphics::TColor Color);
extern PACKAGE T32bitScanLineElement __fastcall ColorTo32bitScanLineElement(Graphics::TColor Color);
extern PACKAGE Graphics::TColor __fastcall RGB(System::Byte Red, System::Byte Green, System::Byte Blue, System::Byte Alpha = (System::Byte)(0x0));
extern PACKAGE int __fastcall Min(int Value1, int Value2);
extern PACKAGE int __fastcall Max(int Value1, int Value2);
extern PACKAGE bool __fastcall SupportsLayeredWindows(void);
extern PACKAGE bool __fastcall SetWindowLayered(unsigned Handle, bool Value);

}	/* namespace Advmenuutil */
using namespace Advmenuutil;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmenuutilHPP
