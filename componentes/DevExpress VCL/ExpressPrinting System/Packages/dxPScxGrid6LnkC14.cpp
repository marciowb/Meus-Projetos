//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxPScxCommonC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxGridC14.bpi");
USERES("dxPScxGrid6LnkC14.res");
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
