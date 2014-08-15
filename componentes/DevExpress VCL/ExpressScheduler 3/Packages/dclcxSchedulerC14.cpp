//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSchedulerC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("cxSchedulerC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
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
