//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCorec5.res");
USERES("dxPS.dcr");
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dcldb50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEUNIT("dxPSReg.pas");
USEUNIT("dxPSPrVwDsg.pas");
USEUNIT("dxPSDsgProxies");
USEUNIT("dxPSDsgUtils");
USEFORMNS("dxPSfmLnkDsg.pas", Dxpsfmlnkdsg, dxfmReportLinkDesignWindow);
USEFORMNS("dxPSfmLnkAdde.pas", Dxpsfmlnkadde, fmAddEmptyReportLink);
USEFORMNS("dxPSfmStlDsg.pas", Dxpsfmstldsg, dxfmPrintStylesDesignWindow);
USEFORMNS("dxPSfmStlAdd.pas", Dxpsfmstladd, dxfmSelectStyleClass);
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("dxPSCoreC5.bpi");
USEUNIT("dxPSDBBasedXplorerReg.pas");
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
