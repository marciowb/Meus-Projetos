// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gtconsts.pas' rev: 21.00

#ifndef GtconstsHPP
#define GtconstsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gtconsts
{
//-- type declarations -------------------------------------------------------
typedef StaticArray<System::UnicodeString, 64> Gtconsts__1;

typedef StaticArray<System::UnicodeString, 64> Gtconsts__2;

typedef StaticArray<System::UnicodeString, 40> Gtconsts__3;

typedef StaticArray<System::UnicodeString, 40> Gtconsts__4;

typedef StaticArray<System::UnicodeString, 27> Gtconsts__5;

typedef StaticArray<System::UnicodeString, 27> Gtconsts__6;

typedef StaticArray<System::UnicodeString, 13> Gtconsts__7;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int CPixelsPerInch;
extern PACKAGE double CPointsToPixels;
static const WideChar NUL = (WideChar)(0x0);
static const WideChar TAB = (WideChar)(0x9);
static const WideChar BS = (WideChar)(0x8);
static const WideChar LF = (WideChar)(0xa);
static const WideChar FF = (WideChar)(0xc);
static const WideChar CR = (WideChar)(0xd);
static const WideChar SP = (WideChar)(0x20);
#define CRLF L"\r\n"
static const char NBSP = '\xa0';
static const Word CM_GTBASE = 0xbf00;
static const ShortInt CInchesToPoints = 0x48;
static const Extended CMMToPoints = 2.834640E+00;
static const Extended CMMToInches = 3.937000E-02;
static const Extended CTwipsToPoints = 5.000000E-02;
static const Word CANSIWinCode = 0x4e4;
extern PACKAGE Gtconsts__1 CWhiteCodes;
extern PACKAGE StaticArray<int, 64> CWhiteCodesLength;
extern PACKAGE Gtconsts__2 CBlackCodes;
extern PACKAGE StaticArray<int, 64> CBlackCodesLength;
extern PACKAGE Gtconsts__3 CWhiteMakeUpCodes;
extern PACKAGE StaticArray<int, 40> CWhiteMakeUpCodesLength;
extern PACKAGE Gtconsts__4 CBlackMakeUpCodes;
extern PACKAGE StaticArray<int, 40> CBlackMakeUpCodesLength;
extern PACKAGE Gtconsts__5 CWhiteRunLengthCode;
extern PACKAGE StaticArray<int, 27> CWhiteRunLengthCodeLength;
extern PACKAGE Gtconsts__6 CBlackRunLengthCode;
extern PACKAGE StaticArray<int, 27> CBlackRunLengthCodeLength;
extern PACKAGE Gtconsts__7 CRunLengthCode;
extern PACKAGE StaticArray<int, 13> CRunLengthCodeLength;

}	/* namespace Gtconsts */
using namespace Gtconsts;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GtconstsHPP
