// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gradientlabel.pas' rev: 21.00

#ifndef GradientlabelHPP
#define GradientlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gradientlabel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TVAlignment { vaTop, vaCenter, vaBottom };
#pragma option pop

#pragma option push -b-
enum TEllipsType { etNone, etEndEllips, etPathEllips };
#pragma option pop

#pragma option push -b-
enum TGradientType { gtFullHorizontal, gtFullVertical, gtBottomLine, gtCenterLine, gtTopLine };
#pragma option pop

#pragma option push -b-
enum TGradientOrientation { goHorizontal, goVertical };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdLeftToRight, gdRightToLeft };
#pragma option pop

class DELPHICLASS TGradientLabel;
class PASCALIMPLEMENTATION TGradientLabel : public Stdctrls::TLabel
{
	typedef Stdctrls::TLabel inherited;
	
private:
	Graphics::TColor FColorTo;
	TEllipsType FEllipsType;
	TVAlignment FValignment;
	int FIndent;
	TGradientType FGradientType;
	bool FTransparentText;
	int FLineWidth;
	TGradientOrientation FOrientation;
	TGradientDirection FGradientDirection;
	void __fastcall SetOrientation(const TGradientOrientation Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetEllipsType(const TEllipsType Value);
	void __fastcall SetVAlignment(const TVAlignment Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetGradientType(const TGradientType Value);
	void __fastcall SetTransparentText(const bool Value);
	void __fastcall SetLineWidth(const int Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	
protected:
	virtual void __fastcall Paint(void);
	System::UnicodeString __fastcall GetVersionComp(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	Graphics::TColor __fastcall GetColor(void);
	Graphics::TColor __fastcall GetColorTo(void);
	
public:
	__fastcall virtual TGradientLabel(Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColor, nodefault};
	__property TEllipsType EllipsType = {read=FEllipsType, write=SetEllipsType, nodefault};
	__property TGradientType GradientType = {read=FGradientType, write=SetGradientType, nodefault};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
	__property int Indent = {read=FIndent, write=SetIndent, nodefault};
	__property int LineWidth = {read=FLineWidth, write=SetLineWidth, nodefault};
	__property TGradientOrientation Orientation = {read=FOrientation, write=SetOrientation, nodefault};
	__property bool TransparentText = {read=FTransparentText, write=SetTransparentText, nodefault};
	__property TVAlignment VAlignment = {read=FValignment, write=SetVAlignment, nodefault};
	__property System::UnicodeString Version = {read=GetVersionComp, write=SetVersion};
public:
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TGradientLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Gradientlabel */
using namespace Gradientlabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GradientlabelHPP
