// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtdocutils.pas' rev: 21.00

#ifndef GtdocutilsHPP
#define GtdocutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gtclasses.hpp>	// Pascal unit
#include <Gtdocconsts.hpp>	// Pascal unit
#include <Gtcstdoceng.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtdocutils
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EInvalidPageNumber;
class PASCALIMPLEMENTATION EInvalidPageNumber : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EInvalidPageNumber(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EInvalidPageNumber(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EInvalidPageNumber(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EInvalidPageNumber(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EInvalidPageNumber(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidPageNumber(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EInvalidPageNumber(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidPageNumber(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EInvalidPageNumber(void) { }
	
};


class DELPHICLASS EFileCreateError;
class PASCALIMPLEMENTATION EFileCreateError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EFileCreateError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EFileCreateError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EFileCreateError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EFileCreateError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EFileCreateError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EFileCreateError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EFileCreateError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EFileCreateError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EFileCreateError(void) { }
	
};


class DELPHICLASS EUnsupportedGraphics;
class PASCALIMPLEMENTATION EUnsupportedGraphics : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EUnsupportedGraphics(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EUnsupportedGraphics(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EUnsupportedGraphics(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EUnsupportedGraphics(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EUnsupportedGraphics(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EUnsupportedGraphics(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EUnsupportedGraphics(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EUnsupportedGraphics(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EUnsupportedGraphics(void) { }
	
};


class DELPHICLASS EInvalidEngineState;
class PASCALIMPLEMENTATION EInvalidEngineState : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EInvalidEngineState(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EInvalidEngineState(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EInvalidEngineState(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EInvalidEngineState(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EInvalidEngineState(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidEngineState(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EInvalidEngineState(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidEngineState(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EInvalidEngineState(void) { }
	
};


struct TgtRotatedTextValues
{
	
public:
	int ATextWidth;
	int ATextHeight;
	int ATextWidthGap;
	int ATextHeightGap;
	int ATotalWidth;
	int ATotalHeight;
	int AposX;
	int AposY;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE double __fastcall CalculateNativeUnitFactor(Gtcstdoceng::TgtUnitType UnitType);
extern PACKAGE System::UnicodeString __fastcall ReverseString(const System::UnicodeString AText);
extern PACKAGE System::UnicodeString __fastcall GetJustifiedText(System::UnicodeString AString, Graphics::TFont* AFont, double AWidth);
extern PACKAGE System::UnicodeString __fastcall GetFileNameFromPath(System::UnicodeString AString);
extern PACKAGE System::AnsiString __fastcall RemoveTerminalCRLF(System::AnsiString AString);
extern PACKAGE System::UnicodeString __fastcall RevHexBytes(System::UnicodeString S);
extern PACKAGE void __fastcall Swap(double &A, double &B);
extern PACKAGE void __fastcall gtAngleText(System::UnicodeString AText, int AAngleDegree, Graphics::TBitmap* ABitmap, double &PosX, double &PosY);
extern PACKAGE void __fastcall CalculateTextPositions(Graphics::TCanvas* ACanvas, int AAngleDegree, System::UnicodeString Atext, TgtRotatedTextValues &AgtRotatedTextValues);
extern PACKAGE void __fastcall SetTextAngle(Graphics::TCanvas* ACanvas, int AAngleDegree);
extern PACKAGE Graphics::TBitmap* __fastcall GetRotatedBitmap(Graphics::TBitmap* ABitmap, double &AX, double &AY, double Angle, Graphics::TColor ABackgroundColor = (Graphics::TColor)(0xffffff));
extern PACKAGE int __fastcall GetFilePathFromText(System::UnicodeString AString, int APos);

}	/* namespace Gtdocutils */
using namespace Gtdocutils;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtdocutilsHPP
