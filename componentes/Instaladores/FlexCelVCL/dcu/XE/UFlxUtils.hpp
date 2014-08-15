// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlxUtils.pas' rev: 22.00

#ifndef UflxutilsHPP
#define UflxutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <UExcelAdapter.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflxutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall MatchNearestColor(const Uexceladapter::TExcelFile* Workbook, const Graphics::TColor aColor, const Uflxmessages::BooleanArray UsedColors);
extern PACKAGE void __fastcall CalcImgCells(const Uexceladapter::TExcelFile* Workbook, const int Row, const int Col, const int dh, const int dw, const System::Extended ImgHeightInPixels, const System::Extended ImgWidthInPixels, /* out */ Uflxmessages::TImageProperties &Props);
extern PACKAGE void __fastcall CalcImgDimentions(const Uexceladapter::TExcelFile* Workbook, const Uflxmessages::TClientAnchor &Anchor, /* out */ System::Extended &XOfsPixel, /* out */ System::Extended &YOfsPixel, /* out */ System::Extended &w, /* out */ System::Extended &h)/* overload */;
extern PACKAGE void __fastcall CalcImgDimentions(const Uexceladapter::TExcelFile* Workbook, const Uflxmessages::TClientAnchor &Anchor, /* out */ int &w, /* out */ int &h)/* overload */;
extern PACKAGE void __fastcall CalcImgDimentions(const Uexceladapter::TExcelFile* Workbook, const Uflxmessages::TClientAnchor &Anchor, /* out */ System::Extended &w, /* out */ System::Extended &h)/* overload */;

}	/* namespace Uflxutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflxutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflxutilsHPP
