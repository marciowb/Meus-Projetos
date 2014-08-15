//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("cxGridC5.bpi");
USEPACKAGE("dclcxLibraryVCLC5.bpi");
USEPACKAGE("dxPScxCommonC5.bpi");
USERES("dxPScxGridLnkC5.res");
USEUNIT("dxPScxGridLnkReg.pas");
USEUNIT("dxPScxGridLnkPredefinedStyleSheets.pas");
USEFORMNS("dxPScxGridLnk.pas", Dxpscxgridlnk, dxfmGridReportLinkDesignWindow);
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
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
