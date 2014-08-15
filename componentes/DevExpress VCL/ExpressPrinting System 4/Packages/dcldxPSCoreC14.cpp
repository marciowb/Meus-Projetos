//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCoreC14.res");
USERES("dxPS.dcr.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dcldxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
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
