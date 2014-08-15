// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuflxformats.pas' rev: 21.00

#ifndef TmsuflxformatsHPP
#define TmsuflxformatsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuflxformats
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum THFlxAlignment { fha_general, fha_left, fha_center, fha_right, fha_fill, fha_justify, fha_center_across_selection };
#pragma option pop

#pragma option push -b-
enum TVFlxAlignment { fva_top, fva_center, fva_bottom, fva_justify, fva_distributed };
#pragma option pop

#pragma option push -b-
enum TFlxBorderStyle { fbs_None, fbs_Thin, fbs_Medium, fbs_Dashed, fbs_Dotted, fbs_Thick, fbs_Double, fbs_Hair, fbs_Medium_dashed, fbs_Dash_dot, fbs_Medium_dash_dot, fbs_Dash_dot_dot, fbs_Medium_dash_dot_dot, fbs_Slanted_dash_dot };
#pragma option pop

typedef ShortInt TFlxPatternStyle;

#pragma option push -b-
enum TFlxDiagonalBorder { fdb_None, fdb_DiagDown, fdb_DiagUp, fdb_Both };
#pragma option pop

#pragma option push -b-
enum TFlxFontStyle { flsBold, flsItalic, flsStrikeOut, flsSuperscript, flsSubscript };
#pragma option pop

#pragma option push -b-
enum TFlxUnderline { fu_None, fu_Single, fu_Double, fu_SingleAccounting, fu_DoubleAccounting };
#pragma option pop

typedef Set<TFlxFontStyle, flsBold, flsSubscript>  SetOfTFlxFontStyle;

struct TFlxFont
{
	
public:
	System::UnicodeString Name;
	System::Word Size20;
	int ColorIndex;
	SetOfTFlxFontStyle Style;
	TFlxUnderline Underline;
	System::Byte Family;
	System::Byte CharSet;
};


struct TFlxOneBorder
{
	
public:
	TFlxBorderStyle Style;
	int ColorIndex;
};


struct TFlxBorders
{
	
public:
	TFlxOneBorder Left;
	TFlxOneBorder Right;
	TFlxOneBorder Top;
	TFlxOneBorder Bottom;
	TFlxOneBorder Diagonal;
	TFlxDiagonalBorder DiagonalStyle;
};


struct TFlxFillPattern
{
	
public:
	TFlxPatternStyle Pattern;
	int FgColorIndex;
	int BgColorIndex;
};


struct TFlxFormat
{
	
public:
	TFlxFont Font;
	TFlxBorders Borders;
	System::UnicodeString Format;
	TFlxFillPattern FillPattern;
	THFlxAlignment HAlignment;
	TVFlxAlignment VAlignment;
	bool Locked;
	bool Hidden;
	int Parent;
	bool WrapText;
	bool ShrinkToFit;
	System::Byte Rotation;
	System::Byte Indent;
};


typedef TFlxFormat *PFlxFormat;

//-- var, const, procedure ---------------------------------------------------
static const ShortInt TFlxPatternStyle_Automatic = 0x0;
static const ShortInt TFlxPatternStyle_None = 0x1;
static const ShortInt TFlxPatternStyle_Solid = 0x2;
static const ShortInt TFlxPatternStyle_Gray50 = 0x3;
static const ShortInt TFlxPatternStyle_Gray75 = 0x4;
static const ShortInt TFlxPatternStyle_Gray25 = 0x5;
static const ShortInt TFlxPatternStyle_Horizontal = 0x6;
static const ShortInt TFlxPatternStyle_Vertical = 0x7;
static const ShortInt TFlxPatternStyle_Down = 0x8;
static const ShortInt TFlxPatternStyle_Up = 0x9;
static const ShortInt TFlxPatternStyle_Checker = 0xa;
static const ShortInt TFlxPatternStyle_SemiGray75 = 0xb;
static const ShortInt TFlxPatternStyle_LightHorizontal = 0xc;
static const ShortInt TFlxPatternStyle_LightVertical = 0xd;
static const ShortInt TFlxPatternStyle_LightDown = 0xe;
static const ShortInt TFlxPatternStyle_LightUp = 0xf;
static const ShortInt TFlxPatternStyle_Grid = 0x10;
static const ShortInt TFlxPatternStyle_CrissCross = 0x11;
static const ShortInt TFlxPatternStyle_Gray16 = 0x12;
static const ShortInt TFlxPatternStyle_Gray8 = 0x13;

}	/* namespace Tmsuflxformats */
using namespace Tmsuflxformats;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuflxformatsHPP
