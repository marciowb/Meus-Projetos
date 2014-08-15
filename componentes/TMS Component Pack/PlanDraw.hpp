// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plandraw.pas' rev: 21.00

#ifndef PlandrawHPP
#define PlandrawHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Planner.hpp>	// Pascal unit
#include <Planutil.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plandraw
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSimpleShape { ssCircle, ssTriangle, ssHArrow, ssVArrow, ssTriangles, ssCircles, ssSquares };
#pragma option pop

class DELPHICLASS TShapeDrawTool;
class PASCALIMPLEMENTATION TShapeDrawTool : public Planner::TCustomItemDrawTool
{
	typedef Planner::TCustomItemDrawTool inherited;
	
private:
	TSimpleShape FShape;
	void __fastcall SetShape(const TSimpleShape Value);
	
public:
	virtual void __fastcall DrawItem(Planner::TPlannerItem* PlannerItem, Graphics::TCanvas* Canvas, const Types::TRect &Rect, bool Selected, bool Print);
	
__published:
	__property TSimpleShape Shape = {read=FShape, write=SetShape, nodefault};
public:
	/* TComponent.Create */ inline __fastcall virtual TShapeDrawTool(Classes::TComponent* AOwner) : Planner::TCustomItemDrawTool(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TShapeDrawTool(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Plandraw */
using namespace Plandraw;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlandrawHPP
