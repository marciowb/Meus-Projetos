//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCoreC12.res");
USERES("dxPS.dcr");
USEPACKAGE("dxcomnC12.bpi");
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
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
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
