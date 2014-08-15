//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCoreC11.res");
USERES("dxPS.dcr");
USEPACKAGE("dxcomnC11.bpi");
USEUNIT("dxPSReg.pas");
USEUNIT("dxPSPrVwDsg.pas");
USEUNIT("dxPSDsgProxies.pas");
USEUNIT("dxPSDsgUtils.pas");
USEUNIT("dxPSDBBasedXplorerReg.pas");
USEFORMNS("dxPSfmLnkDsg.pas", Dxpsfmlnkdsg, dxfmReportLinkDesignWindow);
USEFORMNS("dxPSfmLnkAdde.pas", Dxpsfmlnkadde, fmAddEmptyReportLink);
USEFORMNS("dxPSfmStlDsg.pas", Dxpsfmstldsg, dxfmPrintStylesDesignWindow);
USEFORMNS("dxPSfmStlAdd.pas", Dxpsfmstladd, dxfmSelectStyleClass);
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
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
