//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxPScxCommonC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxGridC12.bpi");
USERES("dxPScxGrid6LnkC12.res");
USEUNIT("dxPScxGrid6LnkReg.pas");
USEUNIT("dxPScxGrid6LnkPredefinedStyleSheets.pas");
USEFORMNS("dxPScxGrid6Lnk.pas", DxpscxGrid6Lnk, dxfmGridReportLinkDesignWindow);
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
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
