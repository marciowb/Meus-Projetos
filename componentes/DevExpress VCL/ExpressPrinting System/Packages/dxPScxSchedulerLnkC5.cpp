//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dxPScxSchedulerLnkC5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("dxPScxSchedulerLnkReg.pas");
USEFORMNS("dxPScxSchedulerLnk.pas", Dxpscxschedulerlnk, dxfmSchedulerReportLinkDesignWindow);
USEPACKAGE("dcldxPSCorec5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("cxSchedulerC5.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
USEPACKAGE("dclcxEditorsC5.bpi");
USEPACKAGE("dclcxLibraryVCLC5.bpi");
USEPACKAGE("CXLIBRARYVCLC5.bpi");
USEPACKAGE("dxPScxCommonC5.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
