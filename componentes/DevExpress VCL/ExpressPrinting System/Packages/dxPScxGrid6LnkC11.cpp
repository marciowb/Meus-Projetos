//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxGridC11.bpi");
USERES("dxPScxGrid6LnkC11.res");
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
