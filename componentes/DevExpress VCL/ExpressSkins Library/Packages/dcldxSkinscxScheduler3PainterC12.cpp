//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxSchedulerC12.res");
USEPACKAGE("dxSkinscxScheduler3PainterC12.bpi");
USEPACKAGE("cxSchedulerC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dcldxSkinsCoreC12.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC12.bpi");
USEUNIT("dxSkinscxScheduler3PainterReg.pas");
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
