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
USERES("dxPScxGridLnkC11.res");
USEUNIT("dxPScxGridLnkReg.pas");
USEUNIT("dxPScxGridLnkPredefinedStyleSheets.pas");
USEFORMNS("dxPScxGridLnk.pas", Dxpscxgridlnk, dxfmGridReportLinkDesignWindow);
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
