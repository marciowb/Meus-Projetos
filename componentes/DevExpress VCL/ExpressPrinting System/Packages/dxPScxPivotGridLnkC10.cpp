//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxPivotGridLnkC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEUNIT("dxPScxPivotGridLnkReg.pas");
USEFORMNS("dxPScxPivotGridLnk.pas", DxpscxPivotGridlnk, dxfmPivotGridReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("cxPivotGridC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("CXLIBRARYC10.bpi");
USEPACKAGE("dxPScxCommonC10.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 
