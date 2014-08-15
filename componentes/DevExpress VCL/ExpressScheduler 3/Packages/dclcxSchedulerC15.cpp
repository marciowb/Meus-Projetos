//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSchedulerC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("cxSchedulerC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dclcxEditorsC15.bpi");
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
