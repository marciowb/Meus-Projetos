//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSchedulerC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExportC10.bpi");
USEPACKAGE("cxSchedulerC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
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
