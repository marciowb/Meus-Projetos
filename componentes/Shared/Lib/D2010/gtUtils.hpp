// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtutils.pas' rev: 21.00

#ifndef GtutilsHPP
#define GtutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Syncobjs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtutils
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS THackWinControl;
class PASCALIMPLEMENTATION THackWinControl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual THackWinControl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall THackWinControl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~THackWinControl(void) { }
	
};


typedef DynamicArray<System::Byte> TgtByteArray;

#pragma option push -b-
enum TStringSeachOption { soDown, soMatchCase, soWholeWord };
#pragma option pop

typedef Set<TStringSeachOption, soDown, soWholeWord>  TStringSearchOptions;

struct TgtRect
{
	
public:
	double Left;
	double Top;
	double Right;
	double Bottom;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Set<char, 0, 255>  WordDelimiters;
extern PACKAGE Syncobjs::TCriticalSection* LockDecimalSep;
extern PACKAGE void __fastcall GetSupportedCharSets(const System::UnicodeString FaceName, Classes::TList* CharSets);
extern PACKAGE System::AnsiString __fastcall GetHexOfStr(System::AnsiString AString);
extern PACKAGE System::UnicodeString __fastcall ColorToPDFColor(Graphics::TColor AColor);
extern PACKAGE tagSIZE __fastcall TextSize(const System::UnicodeString Text, Graphics::TFont* AFont);
extern PACKAGE System::UnicodeString __fastcall RightStr(const System::UnicodeString AText, const int ACount);
extern PACKAGE System::UnicodeString __fastcall LeftStr(const System::UnicodeString AText, const int ACount);
extern PACKAGE System::UnicodeString __fastcall MidStr(const System::UnicodeString AText, const int AStart, const int ACount);
extern PACKAGE int __fastcall PosEx(const System::UnicodeString SubStr, const System::UnicodeString S, unsigned Offset = (unsigned)(0x1));
extern PACKAGE System::WideChar * __fastcall SearchBuf(System::WideChar * Buf, int BufLen, int SelStart, int SelLength, System::UnicodeString SearchString, TStringSearchOptions Options = (TStringSearchOptions() << soDown ));
extern PACKAGE bool __fastcall TryStrToInt(const System::UnicodeString S, /* out */ int &Value);
extern PACKAGE System::WideString __fastcall ReplaceString(const System::WideString S, const System::WideString OldPattern, const System::WideString NewPattern)/* overload */;
extern PACKAGE System::UnicodeString __fastcall ReplaceStringPos(const System::UnicodeString S, int Offset, System::UnicodeString OldPattern, System::UnicodeString NewPattern);
extern PACKAGE bool __fastcall AnsiContainsText(const System::UnicodeString AText, const System::UnicodeString ASubText);
extern PACKAGE System::UnicodeString __fastcall StringToEscapeString(System::UnicodeString AString);
extern PACKAGE System::UnicodeString __fastcall ConvertTabsToSpaces(System::UnicodeString Str, Graphics::TFont* Fonts, Classes::TStringList* TabsStops);
extern PACKAGE void __fastcall FreeAndNil(void *Obj);
extern PACKAGE int __fastcall IfThen(bool AValue, const int ATrue, const int AFalse = 0x0)/* overload */;
extern PACKAGE __int64 __fastcall IfThen(bool AValue, const __int64 ATrue, const __int64 AFalse = 0x000000000)/* overload */;
extern PACKAGE double __fastcall IfThen(bool AValue, const double ATrue, const double AFalse = 0.000000E+00)/* overload */;
extern PACKAGE System::UnicodeString __fastcall IfThen(bool AValue, const System::UnicodeString ATrue, const System::UnicodeString AFalse = L"")/* overload */;
extern PACKAGE System::Extended __fastcall DegreesToRadians(System::Extended Degrees);
extern PACKAGE System::Extended __fastcall PixelsToPoints(System::Extended X);
extern PACKAGE System::Extended __fastcall PointsToPixels(System::Extended X);
extern PACKAGE System::Extended __fastcall RadiansToDegrees(System::Extended Radians);
extern PACKAGE System::UnicodeString __fastcall ColorBGRToRGB(Graphics::TColor AColor);
extern PACKAGE void __fastcall CheckSysColor(Graphics::TColor &Color);
extern PACKAGE void __fastcall SetControlsEnabled(Controls::TWinControl* AControl, bool AState);
extern PACKAGE bool __fastcall IsHex(System::UnicodeString AString);
extern PACKAGE TgtByteArray __fastcall HexToByteArray(System::UnicodeString AHex);
extern PACKAGE int __fastcall HexToByteValue(System::UnicodeString AHex, /* out */ System::Byte &AByte);
extern PACKAGE System::UnicodeString __fastcall HexToByteString(System::UnicodeString AHex);
extern PACKAGE void __fastcall EscapeStringToByteArray(System::AnsiString AEscapeString, System::Byte *AByte, const int AByte_Size);
extern PACKAGE void __fastcall EscapeStringToString(System::UnicodeString AEscapeString, System::UnicodeString &AString);
extern PACKAGE void __fastcall OctalToByteValue(System::UnicodeString AOctal, /* out */ System::Byte &AByte);
extern PACKAGE bool __fastcall IsOctal(System::UnicodeString AString);
extern PACKAGE System::UnicodeString __fastcall FloatToStrLocale(double Value);
extern PACKAGE System::UnicodeString __fastcall FloatToStrFLocale(System::Extended Value, Sysutils::TFloatFormat Format, int Precision, int Digits);
extern PACKAGE double __fastcall StrToFloatLocale(System::UnicodeString AString);
extern PACKAGE TgtRect __fastcall gtRect(double Left, double Top, double Right, double Bottom)/* overload */;
extern PACKAGE TgtRect __fastcall gtRect(const TgtRect &ARect, double AFactor)/* overload */;
extern PACKAGE TgtRect __fastcall gtRect(const TgtRect &ARect, double AXFactor, double AYFactor)/* overload */;

}	/* namespace Gtutils */
using namespace Gtutils;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtutilsHPP
