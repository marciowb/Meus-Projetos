//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsdxBarPainterC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxSkinsCoreC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEUNIT("dxSkinsdxBarPainter.pas");
USEUNIT("dxSkinsdxStatusBarPainter.pas");
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
