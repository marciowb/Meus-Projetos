//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSchedulerC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExportC12.bpi");
USEPACKAGE("cxSchedulerC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dclcxEditorsC12.bpi");
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
