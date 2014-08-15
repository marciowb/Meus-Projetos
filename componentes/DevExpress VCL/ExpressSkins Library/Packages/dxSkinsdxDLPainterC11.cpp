//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsdxDLPainterC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxSkinsCoreC11.bpi");
USEPACKAGE("dxDockingC11.bpi");
USEUNIT("dxSkinsdxDockControlPainter.pas");
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
