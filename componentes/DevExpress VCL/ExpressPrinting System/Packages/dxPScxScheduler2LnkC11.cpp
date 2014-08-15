//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxScheduler2LnkC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEUNIT("dxPScxScheduler2LnkReg.pas");
USEFORMNS("dxPScxScheduler2Lnk.pas", Dxpscxscheduler2lnk, dxfmSchedulerReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("cxSchedulerC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("CXLIBRARYC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 
