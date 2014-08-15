//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxSchedulerC11.res");
USEPACKAGE("cxSchedulerC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxSkinscxSchedulerPainterC11.bpi");
USEPACKAGE("dcldxSkinsCoreC11.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC11.bpi");
USEUNIT("dxSkinscxSchedulerPainterReg.pas");
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
