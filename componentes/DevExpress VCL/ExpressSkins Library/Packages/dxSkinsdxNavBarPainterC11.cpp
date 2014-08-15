//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsdxNavBarPainterC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxSkinsCoreC11.bpi");
USEPACKAGE("dxNavBarC11.bpi");
USEUNIT("dxSkinsdxNavBarPainter.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
