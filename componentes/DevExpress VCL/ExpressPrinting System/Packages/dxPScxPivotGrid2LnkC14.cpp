//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxPivotGrid2LnkC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("rtl.bpi");
USEUNIT("dxPScxPivotGrid2LnkReg.pas");
USEFORMNS("dxPScxPivotGrid2Lnk.pas", DxpscxPivotGrid2lnk, dxfmPivotGridReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC14.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("cxPivotGridC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("CXLIBRARYC14.bpi");
USEPACKAGE("dxPScxCommonC14.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 
