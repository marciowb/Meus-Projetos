//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSchedulerC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("cxSchedulerC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("designide.bpi");
USEUNIT("cxSchedulerReg.pas");
USERES("cxSchedulerReg.dcr");
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
