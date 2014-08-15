//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSCoreC12.res");
USERES("dxPS.dcr.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("dcldxCoreC12.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
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
