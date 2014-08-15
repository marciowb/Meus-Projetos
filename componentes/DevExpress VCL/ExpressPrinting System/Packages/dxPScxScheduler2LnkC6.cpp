//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxScheduler2LnkC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEUNIT("dxPScxScheduler2LnkReg.pas");
USEFORMNS("dxPScxScheduler2Lnk.pas", Dxpscxscheduler2lnk, dxfmSchedulerReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("cxSchedulerVCLC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("dclcxEditorsVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("CXLIBRARYVCLC6.bpi");
USEPACKAGE("dxPScxCommonC6.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 