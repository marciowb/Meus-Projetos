// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advutil.pas' rev: 21.00

#ifndef AdvutilHPP
#define AdvutilHPP

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
#include <Grids.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advutil
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAutoType { atNumeric, atFloat, atString, atDate, atTime, atScientific };
#pragma option pop

#pragma option push -b-
enum TTextType { ttText, ttHTML, ttRTF, ttFormula, ttURL, ttUnicode };
#pragma option pop

#pragma option push -b-
enum TGradientPart { gpFull, gpLeft, gpRight, gpMiddle };
#pragma option pop

#pragma option push -b-
enum TCellShape { csRectangle, csCircle, csTriangleLeft, csTriangleRight, csTriangleUp, csTriangleDown, csDiamond, csLineVert, csLineHorz, csRoundRect, csEllips, csSquare, csRoundSquare, csStar, csArrowUp, csArrowDown, csArrowLeft, csArrowRight, csHalfStar };
#pragma option pop

typedef DynamicArray<System::WideChar> TCharSet;

#pragma option push -b-
enum TGaugeOrientation { goHorizontal, goVertical };
#pragma option pop

struct TGaugeSettings
{
	
public:
	Graphics::TColor Level0Color;
	Graphics::TColor Level0ColorTo;
	Graphics::TColor Level1Color;
	Graphics::TColor Level1ColorTo;
	Graphics::TColor Level2Color;
	Graphics::TColor Level2ColorTo;
	Graphics::TColor Level3Color;
	Graphics::TColor Level3ColorTo;
	int Level1Perc;
	int Level2Perc;
	Graphics::TColor BorderColor;
	bool ShowBorder;
	bool Stacked;
	bool ShowPercentage;
	Graphics::TFont* Font;
	Graphics::TColor FontColor;
	bool CompletionSmooth;
	bool ShowGradient;
	int Steps;
	int Position;
	Graphics::TColor BackgroundColor;
	TGaugeOrientation Orientation;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall DrawSelectionGradient(Graphics::TCanvas* Canvas, Graphics::TColor color1, Graphics::TColor color2, Graphics::TColor mircolor1, Graphics::TColor mircolor2, Graphics::TColor linecolortop, Graphics::TColor linecolorbottom, Graphics::TColor bordercolor, Graphics::TColor edgecolor, Graphics::TColor bkgcolor, const Types::TRect &r, TGradientPart part);
extern PACKAGE System::UnicodeString __fastcall CSVQuotes(const System::UnicodeString S);
extern PACKAGE int __fastcall CheckLimits(int Value, int LowLimit, int UpLimit);
extern PACKAGE Graphics::TColor __fastcall DarkenColor(Graphics::TColor Color);
extern PACKAGE int __fastcall FIPos(System::UnicodeString su, System::UnicodeString s);
extern PACKAGE int __fastcall VarCharPos(System::WideChar ch, const System::UnicodeString s, int &Res);
extern PACKAGE int __fastcall VarCharPosNC(System::WideChar ch, const System::UnicodeString s, int &Res);
extern PACKAGE int __fastcall CharPos(System::WideChar ch, const System::UnicodeString s);
extern PACKAGE bool __fastcall IsInGridRect(const Grids::TGridRect &rc, int c, int r);
extern PACKAGE System::UnicodeString __fastcall GetToken(System::UnicodeString &s, System::UnicodeString separator);
extern PACKAGE int __fastcall Max(int i1, int i2);
extern PACKAGE int __fastcall Min(int i1, int i2);
extern PACKAGE System::UnicodeString __fastcall StringListToText(Classes::TStringList* st);
extern PACKAGE int __fastcall VarPos(System::UnicodeString su, System::UnicodeString s, int &respos);
extern PACKAGE System::WideChar __fastcall FirstChar(TCharSet charset, System::UnicodeString s, int &spos);
extern PACKAGE bool __fastcall NameToCell(System::UnicodeString s, Types::TPoint &cell);
extern PACKAGE bool __fastcall IsURL(const System::UnicodeString s);
extern PACKAGE void __fastcall StripURLProtocol(System::UnicodeString &s);
extern PACKAGE TTextType __fastcall TextType(System::UnicodeString s, bool allowhtml);
extern PACKAGE bool __fastcall CheckNum(System::WideChar ch);
extern PACKAGE bool __fastcall CheckSignedNum(System::WideChar ch);
extern PACKAGE System::UnicodeString __fastcall RemoveSeps(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall HTMLLineBreaks(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall HTMLColor(unsigned l);
extern PACKAGE TAutoType __fastcall IsType(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall CLFToLF(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall LFToCLF(System::UnicodeString s);
extern PACKAGE void __fastcall StringToPassword(System::UnicodeString &s, System::WideChar passwordchar);
extern PACKAGE void __fastcall StringToOem(System::UnicodeString &s);
extern PACKAGE void __fastcall OemToString(System::UnicodeString &s);
extern PACKAGE System::UnicodeString __fastcall DoubleToSingleChar(System::WideChar ch, const System::UnicodeString s);
extern PACKAGE void __fastcall LineFeedsToCSV(System::UnicodeString &s);
extern PACKAGE void __fastcall LineFeedsToCSVNQ(System::UnicodeString &s);
extern PACKAGE void __fastcall CSVToLineFeeds(System::UnicodeString &s);
extern PACKAGE void __fastcall LineFeedsToJava(System::UnicodeString &s);
extern PACKAGE void __fastcall JavaToLineFeeds(System::UnicodeString &s);
extern PACKAGE bool __fastcall MatchStrEx(System::UnicodeString s1, System::UnicodeString s2, bool DoCase);
extern PACKAGE bool __fastcall MatchStr(System::UnicodeString s1, System::UnicodeString s2, bool DoCase);
extern PACKAGE bool __fastcall Matches(System::WideChar * s0a, System::WideChar * s1a);
extern PACKAGE System::UnicodeString __fastcall LfToFile(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall FileToLf(System::UnicodeString s, bool multiline);
extern PACKAGE System::UnicodeString __fastcall GetNextLine(System::UnicodeString &s, bool multiline);
extern PACKAGE int __fastcall LinesInText(System::UnicodeString s, bool multiline);
extern PACKAGE System::UnicodeString __fastcall RectString(const Types::TRect &r);
extern PACKAGE System::UnicodeString __fastcall FixDecimalSeparator(System::UnicodeString s);
extern PACKAGE System::TDateTime __fastcall GetNextDate(System::TDateTime d, System::Word dye, System::Word dmo, System::Word dda, System::TDateTime dtv);
extern PACKAGE void __fastcall DrawBitmapResourceTransp(Graphics::TCanvas* Canvas, Graphics::TColor bkColor, const Types::TRect &r, System::UnicodeString ResName);
extern PACKAGE void __fastcall DrawBitmapTransp(Graphics::TCanvas* Canvas, Graphics::TBitmap* bmp, Graphics::TColor bkcolor, const Types::TRect &r);
extern PACKAGE int __fastcall SinglePos(System::WideChar p, System::UnicodeString s, int &sp);
extern PACKAGE int __fastcall NumSingleChar(System::WideChar p, System::UnicodeString s);
extern PACKAGE int __fastcall NumChar(System::WideChar p, System::UnicodeString s);
extern PACKAGE int __fastcall NumCharInStr(System::WideChar p, System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall LineFeedsToXLS(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall CRToLF(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall ShiftCase(System::UnicodeString Name);
extern PACKAGE System::TDateTime __fastcall StrToShortdateUS(System::UnicodeString s);
extern PACKAGE System::TDateTime __fastcall StrToShortDateEU(System::UnicodeString s);
extern PACKAGE void __fastcall DrawErrorLines(Controls::TWinControl* Parent, Graphics::TCanvas* Canvas, System::UnicodeString TmpStr, const Types::TRect &Rect, int Height, int ErrPos, int ErrLen);
extern PACKAGE void __fastcall DrawRangeIndicator(Graphics::TCanvas* Canvas, const Types::TRect &r, int Value, int Range, bool ShowValue, Graphics::TColor NegColor, Graphics::TColor PosColor);
extern PACKAGE void __fastcall DrawProgressLin(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color1, Graphics::TColor TColor1, Graphics::TColor Color2, Graphics::TColor TColor2, double pd, int Mx, int My, int Min, int Max, System::UnicodeString Fmt, Graphics::TColor BorderColor, bool print);
extern PACKAGE void __fastcall DrawProgressPie(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color, int p, bool print);
extern PACKAGE void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);
extern PACKAGE void __fastcall DrawVistaGradient(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, Graphics::TColor ColorMirrorFrom, Graphics::TColor ColorMirrorTo, bool Direction, Graphics::TColor BorderColor, bool LeftRightBorder = false, bool Fill = true);
extern PACKAGE Graphics::TColor __fastcall GradientAt(Graphics::TColor FromColor, Graphics::TColor ToColor, int Left, int Right, int Pos);
extern PACKAGE void __fastcall DrawComboButton(Graphics::TCanvas* Canvas, unsigned Handle, const Types::TRect &ARect, bool WinXP, bool Flat, bool Enabled);
extern PACKAGE void __fastcall DrawSpinButtons(Graphics::TCanvas* Canvas, unsigned Handle, const Types::TRect &ARect, bool WinXP, bool Flat, bool Enabled);
extern PACKAGE System::WideString __fastcall DecodeWideStr(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall EncodeWideStr(System::WideString s);
extern PACKAGE int __fastcall StrPosWide(System::WideString SubStr, System::WideString Str);
extern PACKAGE bool __fastcall IsDateStr(System::UnicodeString s);
extern PACKAGE void __fastcall MakeFragment(System::UnicodeString &HTML);
extern PACKAGE bool __fastcall DynaLink_UpdateLayeredWindow(unsigned hwnd, unsigned hdcDst, Types::PPoint pptDst, Types::PPoint size, unsigned hdcSrc, Types::PPoint pptSrc, unsigned crKey, _BLENDFUNCTION &pblend, unsigned dwFlags);
extern PACKAGE bool __fastcall DynaLink_SetLayeredWindowAttributes(unsigned HWND, unsigned crKey, System::Byte bAlpha, unsigned dwFlags);
extern PACKAGE void __fastcall DrawTriangle(Graphics::TCanvas* Canvas, int X, int Y, Graphics::TColor Color);
extern PACKAGE void __fastcall DrawGauge(Graphics::TCanvas* Canvas, const Types::TRect &R, int Position, const TGaugeSettings &Settings);
extern PACKAGE void __fastcall DrawShape(Graphics::TCanvas* Canvas, int X, int Y, int Width, int Height, TCellShape Shape, Graphics::TColor FillColor, Graphics::TColor LineColor);
extern PACKAGE bool __fastcall MakeHTMLHyperlink(const System::UnicodeString Value, const System::UnicodeString LinkType, System::UnicodeString &ValueWithLink);

}	/* namespace Advutil */
using namespace Advutil;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvutilHPP
