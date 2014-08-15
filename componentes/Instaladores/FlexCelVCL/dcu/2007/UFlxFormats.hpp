// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxformats.pas' rev: 11.00

#ifndef UflxformatsHPP
#define UflxformatsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxformats
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

typedef Shortint TFlxPatternStyle;

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

#pragma pack(push,4)
struct TFlxFont
{
	
public:
	WideString Name;
	Word Size20;
	int ColorIndex;
	SetOfTFlxFontStyle Style;
	TFlxUnderline Underline;
	Byte Family;
	Byte CharSet;
} ;
#pragma pack(pop)

#pragma pack(push,4)
struct TFlxOneBorder
{
	
public:
	TFlxBorderStyle Style;
	int ColorIndex;
} ;
#pragma pack(pop)

#pragma pack(push,4)
struct TFlxBorders
{
	
public:
	TFlxOneBorder Left;
	TFlxOneBorder Right;
	TFlxOneBorder Top;
	TFlxOneBorder Bottom;
	TFlxOneBorder Diagonal;
	TFlxDiagonalBorder DiagonalStyle;
} ;
#pragma pack(pop)

#pragma pack(push,4)
struct TFlxFillPattern
{
	
public:
	TFlxPatternStyle Pattern;
	int FgColorIndex;
	int BgColorIndex;
} ;
#pragma pack(pop)

#pragma pack(push,4)
struct TFlxFormat
{
	
public:
	TFlxFont Font;
	TFlxBorders Borders;
	WideString Format;
	TFlxFillPattern FillPattern;
	THFlxAlignment HAlignment;
	TVFlxAlignment VAlignment;
	bool Locked;
	bool Hidden;
	int Parent;
	bool WrapText;
	bool ShrinkToFit;
	Byte Rotation;
	Byte Indent;
} ;
#pragma pack(pop)

typedef TFlxFormat *PFlxFormat;

//-- var, const, procedure ---------------------------------------------------
static const Shortint TFlxPatternStyle_Automatic = 0x0;
static const Shortint TFlxPatternStyle_None = 0x1;
static const Shortint TFlxPatternStyle_Solid = 0x2;
static const Shortint TFlxPatternStyle_Gray50 = 0x3;
static const Shortint TFlxPatternStyle_Gray75 = 0x4;
static const Shortint TFlxPatternStyle_Gray25 = 0x5;
static const Shortint TFlxPatternStyle_Horizontal = 0x6;
static const Shortint TFlxPatternStyle_Vertical = 0x7;
static const Shortint TFlxPatternStyle_Down = 0x8;
static const Shortint TFlxPatternStyle_Up = 0x9;
static const Shortint TFlxPatternStyle_Checker = 0xa;
static const Shortint TFlxPatternStyle_SemiGray75 = 0xb;
static const Shortint TFlxPatternStyle_LightHorizontal = 0xc;
static const Shortint TFlxPatternStyle_LightVertical = 0xd;
static const Shortint TFlxPatternStyle_LightDown = 0xe;
static const Shortint TFlxPatternStyle_LightUp = 0xf;
static const Shortint TFlxPatternStyle_Grid = 0x10;
static const Shortint TFlxPatternStyle_CrissCross = 0x11;
static const Shortint TFlxPatternStyle_Gray16 = 0x12;
static const Shortint TFlxPatternStyle_Gray8 = 0x13;

}	/* namespace Uflxformats */
using namespace Uflxformats;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxformats
