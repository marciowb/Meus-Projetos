//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxSchedulerC15.res");
USEPACKAGE("dxSkinscxScheduler3PainterC15.bpi");
USEPACKAGE("cxSchedulerC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dcldxSkinsCoreC15.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC15.bpi");
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
