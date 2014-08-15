//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxSchedulerC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxSkinsCoreC12.bpi");
USEPACKAGE("cxSchedulerC12.bpi");
USEUNIT("dxSkinscxSchedulerPainter.pas");
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
