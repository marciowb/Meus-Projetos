// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflxutils.pas' rev: 10.00

#ifndef UflxutilsHPP
#define UflxutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall MatchNearestColor(const Uexceladapter::TExcelFile* Workbook, const Graphics::TColor aColor, const Uflxmessages::BooleanArray UsedColors);
extern PACKAGE void __fastcall CalcImgCells(const Uexceladapter::TExcelFile* Workbook, const int Row, const int Col, const int dh, const int dw, const Extended ImgHeightInPixels, const Extended ImgWidthInPixels, /* out */ Uflxmessages::TImageProperties &Props);
extern PACKAGE void __fastcall CalcImgDimentions(const Uexceladapter::TExcelFile* Workbook, const Uflxmessages::TClientAnchor &Anchor, /* out */ Extended &XOfsPixel, /* out */ Extended &YOfsPixel, /* out */ Extended &w, /* out */ Extended &h)/* overload */;
extern PACKAGE void __fastcall CalcImgDimentions(const Uexceladapter::TExcelFile* Workbook, const Uflxmessages::TClientAnchor &Anchor, /* out */ int &w, /* out */ int &h)/* overload */;
extern PACKAGE void __fastcall CalcImgDimentions(const Uexceladapter::TExcelFile* Workbook, const Uflxmessages::TClientAnchor &Anchor, /* out */ Extended &w, /* out */ Extended &h)/* overload */;

}	/* namespace Uflxutils */
using namespace Uflxutils;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflxutils
