//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCoreC15.res");
USERES("dxPS.dcr.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dcldxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEUNIT("dxPSDsgProxies.pas");
USEUNIT("dxPSDsgUtils.pas");
USEUNIT("dxPSPrVwDsg.pas");
USEUNIT("dxPSfmLnkDsg.pas");
USEUNIT("dxPSfmLnkAdde.pas");
USEUNIT("dxPSfmStlAdd.pas");
USEUNIT("dxPSfmStlDsg.pas");
USEUNIT("dxPSReg.pas");
USEUNIT("dxPSDBBasedXplorerReg.pas");
USEFORMNS("dxPSfmLnkDsg.pas", dxPSfmLnkDsg, dxfmReportLinkDesignWindow);
USEFORMNS("dxPSfmLnkAdde.pas", dxPSfmLnkAdde, dxfmAddReportLinkClass);
USEFORMNS("dxPSfmStlAdd.pas", dxPSfmStlAdd, dxfmSelectStyleClass);
USEFORMNS("dxPSfmStlDsg.pas", dxPSfmStlDsg, dxfmPrintStylesDesignWindow);
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
