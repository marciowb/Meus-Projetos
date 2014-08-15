// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planutil.pas' rev: 21.00

#ifndef PlanutilHPP
#define PlanutilHPP

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
#include <Planhtml.hpp>	// Pascal unit
#include <Strutils.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Planutil
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TArrowDirection { adUp, adDown, adRight, adLeft };
#pragma option pop

#pragma option push -b-
enum TVAlignment { vtaCenter, vtaTop, vtaBottom };
#pragma option pop

class DELPHICLASS TDateTimeObject;
class PASCALIMPLEMENTATION TDateTimeObject : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::TDateTime FDT;
	__property System::TDateTime DT = {read=FDT, write=FDT};
public:
	/* TObject.Create */ inline __fastcall TDateTimeObject(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TDateTimeObject(void) { }
	
};


class DELPHICLASS TDateTimeList;
class PASCALIMPLEMENTATION TDateTimeList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	System::TDateTime operator[](int index) { return Items[index]; }
	
private:
	System::TDateTime __fastcall GetDT(int index);
	void __fastcall SetDT(int index, const System::TDateTime Value);
	
public:
	__property System::TDateTime Items[int index] = {read=GetDT, write=SetDT/*, default*/};
	HIDESBASE void __fastcall Add(System::TDateTime Value);
	HIDESBASE void __fastcall Insert(int Index, System::TDateTime Value);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	__fastcall virtual ~TDateTimeList(void);
public:
	/* TObject.Create */ inline __fastcall TDateTimeList(void) : Classes::TList() { }
	
};


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
	bool CompletionSmooth;
	bool ShowGradient;
	int Steps;
	int Position;
	Graphics::TColor BackgroundColor;
	TGaugeOrientation Orientation;
	System::UnicodeString CompletionFormat;
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall DynaLink_UpdateLayeredWindow(unsigned hwnd, unsigned hdcDst, Types::PPoint pptDst, Types::PPoint size, unsigned hdcSrc, Types::PPoint pptSrc, unsigned crKey, _BLENDFUNCTION &pblend, unsigned dwFlags);
extern PACKAGE bool __fastcall DynaLink_SetLayeredWindowAttributes(unsigned HWND, unsigned crKey, System::Byte bAlpha, unsigned dwFlags);
extern PACKAGE double __fastcall CanvasToHTMLFactor(Graphics::TCanvas* ScreenCanvas, Graphics::TCanvas* Canvas);
extern PACKAGE int __fastcall PrinterDrawString(Graphics::TCanvas* Canvas, System::UnicodeString Value, Types::TRect &Rect, unsigned Format);
extern PACKAGE System::TDateTime __fastcall EndOfMonth(System::TDateTime dt);
extern PACKAGE System::Word __fastcall NextMonth(System::Word mo);
extern PACKAGE int __fastcall Limit(int Value, int vmin, int vmax);
extern PACKAGE void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);
extern PACKAGE System::Word __fastcall DaysInMonth(System::Word mo, System::Word ye);
extern PACKAGE System::UnicodeString __fastcall HTMLStrip(System::UnicodeString s);
extern PACKAGE unsigned __fastcall AlignToFlag(Classes::TAlignment alignment);
extern PACKAGE unsigned __fastcall VAlignToFlag(TVAlignment VAlignment);
extern PACKAGE unsigned __fastcall WordWrapToFlag(System::UnicodeString s, bool ww);
extern PACKAGE void __fastcall RectLine(Graphics::TCanvas* canvas, const Types::TRect &r, Graphics::TColor Color, int width);
extern PACKAGE void __fastcall RectLineEx(Graphics::TCanvas* Canvas, const Types::TRect &R, Graphics::TColor Color, int Width);
extern PACKAGE void __fastcall RectLineExEx(Graphics::TCanvas* Canvas, const Types::TRect &R, Graphics::TColor Color, int Width);
extern PACKAGE void __fastcall RectLineExExEx(Graphics::TCanvas* Canvas, const Types::TRect &R, Graphics::TColor Color, int Width);
extern PACKAGE void __fastcall RectHorz(Graphics::TCanvas* canvas, const Types::TRect &r, Graphics::TColor Color, Graphics::TColor pencolor);
extern PACKAGE void __fastcall RectHorzEx(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color, Graphics::TColor BKColor, Graphics::TColor PenColor1, Graphics::TColor PenColor2, int PenWidth, Graphics::TBrushStyle BrushStyle);
extern PACKAGE void __fastcall RectVert(Graphics::TCanvas* canvas, const Types::TRect &r, Graphics::TColor Color, Graphics::TColor pencolor);
extern PACKAGE void __fastcall RectVertEx(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color, Graphics::TColor BKColor, Graphics::TColor PenColor, int PenWidth, Graphics::TBrushStyle BrushStyle);
extern PACKAGE System::UnicodeString __fastcall LFToCLF(System::UnicodeString s);
extern PACKAGE void __fastcall DrawArrow(Graphics::TCanvas* Canvas, Graphics::TColor Color, int X, int Y, TArrowDirection ADir);
extern PACKAGE bool __fastcall MatchStr(System::UnicodeString s1, System::UnicodeString s2, bool DoCase);
extern PACKAGE void __fastcall DrawBitmapTransp(const Types::TRect &DstRect, Graphics::TCanvas* Canvas, Graphics::TBitmap* Bitmap, Graphics::TColor BKColor, const Types::TRect &SrcRect);
extern PACKAGE void __fastcall DrawBumpVert(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color);
extern PACKAGE void __fastcall DrawBumpHorz(Graphics::TCanvas* Canvas, const Types::TRect &r, Graphics::TColor Color);
extern PACKAGE Graphics::TColor __fastcall BlendColor(Graphics::TColor Col1, Graphics::TColor Col2, int BlendFactor);
extern PACKAGE void __fastcall DrawGauge(Graphics::TCanvas* Canvas, const Types::TRect &R, int Position, const TGaugeSettings &Settings);
extern PACKAGE void __fastcall BitmapStretch(Graphics::TBitmap* bmp, Graphics::TCanvas* Canvas, int x, int y, int width);
extern PACKAGE void __fastcall BitmapStretchHeight(Graphics::TBitmap* bmp, Graphics::TCanvas* canvas, int x, int y, int height, int width);

}	/* namespace Planutil */
using namespace Planutil;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlanutilHPP
