// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuflxutils.pas' rev: 21.00

#ifndef TmsuflxutilsHPP
#define TmsuflxutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Tmsuexceladapter.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuflxutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall MatchNearestColor(const Tmsuexceladapter::TExcelFile* Workbook, const Graphics::TColor aColor, const Tmsuflxmessages::BooleanArray UsedColors);
extern PACKAGE void __fastcall CalcImgCells(const Tmsuexceladapter::TExcelFile* Workbook, const int Row, const int Col, const int dh, const int dw, const System::Extended ImgHeightInPixels, const System::Extended ImgWidthInPixels, /* out */ Tmsuflxmessages::TImageProperties &Props);
extern PACKAGE void __fastcall CalcImgDimentions(const Tmsuexceladapter::TExcelFile* Workbook, const Tmsuflxmessages::TClientAnchor &Anchor, /* out */ System::Extended &XOfsPixel, /* out */ System::Extended &YOfsPixel, /* out */ System::Extended &w, /* out */ System::Extended &h)/* overload */;
extern PACKAGE void __fastcall CalcImgDimentions(const Tmsuexceladapter::TExcelFile* Workbook, const Tmsuflxmessages::TClientAnchor &Anchor, /* out */ int &w, /* out */ int &h)/* overload */;
extern PACKAGE void __fastcall CalcImgDimentions(const Tmsuexceladapter::TExcelFile* Workbook, const Tmsuflxmessages::TClientAnchor &Anchor, /* out */ System::Extended &w, /* out */ System::Extended &h)/* overload */;

}	/* namespace Tmsuflxutils */
using namespace Tmsuflxutils;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuflxutilsHPP
