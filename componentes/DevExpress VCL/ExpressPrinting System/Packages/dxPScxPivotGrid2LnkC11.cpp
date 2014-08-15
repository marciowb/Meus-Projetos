//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxPivotGrid2LnkC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("rtl.bpi");
USEUNIT("dxPScxPivotGrid2LnkReg.pas");
USEFORMNS("dxPScxPivotGrid2Lnk.pas", DxpscxPivotGrid2lnk, dxfmPivotGridReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("cxPivotGridC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("CXLIBRARYC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 
