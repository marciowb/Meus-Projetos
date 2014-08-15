//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxScheduler3LnkC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("rtl.bpi");
USEUNIT("dxPScxScheduler3LnkReg.pas");
USEFORMNS("dxPScxScheduler3Lnk.pas", Dxpscxscheduler3lnk, dxfmSchedulerReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("cxSchedulerC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("CXLIBRARYC10.bpi");
USEPACKAGE("dxPScxCommonC10.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 
