// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Linelibrary.pas' rev: 21.00

#ifndef LinelibraryHPP
#define LinelibraryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Hotspotimage.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Linelibrary
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLineSelected { lsNotSelected, lsPoint1, lsPoint2, lsLine };
#pragma option pop

#pragma option push -b-
enum TLineOrientation { loPoint, loHorizontal, loVertical };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Types::TPoint __fastcall AddPoints(const Types::TPoint &PointA, const Types::TPoint &PointB)/* overload */;
extern PACKAGE Hotspotimage::TRealPoint __fastcall AddPoints(const Hotspotimage::TRealPoint &PointA, const Hotspotimage::TRealPoint &PointB)/* overload */;
extern PACKAGE Hotspotimage::TRealPoint __fastcall AddPoints(const Hotspotimage::TRealPoint &PointA, const Types::TPoint &PointB)/* overload */;
extern PACKAGE Types::TPoint __fastcall SubtractPoints(const Types::TPoint &PointA, const Types::TPoint &PointB)/* overload */;
extern PACKAGE Hotspotimage::TRealPoint __fastcall SubtractPoints(const Hotspotimage::TRealPoint &PointA, const Hotspotimage::TRealPoint &PointB)/* overload */;
extern PACKAGE void __fastcall CalcLineParameters(const Types::TPoint &PointA, const Types::TPoint &PointB, double &Slope, double &Intercept, TLineOrientation &LineOrientation);
extern PACKAGE bool __fastcall NearLine(const Types::TPoint &Target, const Types::TPoint &Point1, const Types::TPoint &Point2);
extern PACKAGE void __fastcall RestrictCursorToDrawingArea(const Extctrls::TImage* Image);
extern PACKAGE void __fastcall RemoveCursorRestrictions(void);
extern PACKAGE bool __fastcall SquareContainsPoint(const Types::TPoint &SquareCenter, const int SquareHalfSize, const Types::TPoint &TestPoint);

}	/* namespace Linelibrary */
using namespace Linelibrary;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LinelibraryHPP
