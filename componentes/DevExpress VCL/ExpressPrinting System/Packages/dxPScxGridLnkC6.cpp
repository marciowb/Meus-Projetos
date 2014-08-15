//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCorec6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxPScxCommonC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxGridVCLC6.bpi");
USERES("dxPScxGridLnkc6.res");
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
