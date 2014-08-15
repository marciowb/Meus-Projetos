// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advgradient.pas' rev: 21.00

#ifndef AdvgradientHPP
#define AdvgradientHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advgradient
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TGradientStyle;
class PASCALIMPLEMENTATION TGradientStyle : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColorTo;
	Graphics::TColor FColorFrom;
	Graphics::TColor FBorderColor;
	Classes::TNotifyEvent FOnChange;
	bool FDirection;
	Graphics::TColor FColorMirrorFrom;
	Graphics::TColor FColorMirrorTo;
	bool FRounded;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColorFrom(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorFrom(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const bool Value);
	void __fastcall SetRounded(const bool Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TGradientStyle(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Graphics::TCanvas* Canvas, const Types::TRect &Rect);
	void __fastcall SetStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777203};
	__property Graphics::TColor ColorFrom = {read=FColorFrom, write=SetColorFrom, default=-16777203};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorMirrorFrom = {read=FColorMirrorFrom, write=SetColorMirrorFrom, default=536870911};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, default=536870911};
	__property bool Direction = {read=FDirection, write=SetDirection, default=0};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGradientStyle(void) { }
	
};


#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TGradientPart { gpFull, gpLeft, gpRight, gpMiddle };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);
extern PACKAGE void __fastcall DrawVistaGradient(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, Graphics::TColor ColorMirrorFrom, Graphics::TColor ColorMirrorTo, TGradientDirection Direction, Graphics::TColor BorderColor, bool Fill = true);
extern PACKAGE void __fastcall DrawSelectionGradient(Graphics::TCanvas* canvas, Graphics::TColor color1, Graphics::TColor color2, Graphics::TColor mircolor1, Graphics::TColor mircolor2, Graphics::TColor bordercolor, Graphics::TColor edgecolor, Graphics::TColor bkgcolor, const Types::TRect &r, TGradientPart part);

}	/* namespace Advgradient */
using namespace Advgradient;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvgradientHPP
