//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxPScxCommonC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxGridC10.bpi");
USERES("dxPScxGrid6LnkC10.res");
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
