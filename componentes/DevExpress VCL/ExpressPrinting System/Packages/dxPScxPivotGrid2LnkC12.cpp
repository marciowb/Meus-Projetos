//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
#pragma package(smart_init)

USERES("dxPScxPivotGrid2LnkC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("rtl.bpi");
USEUNIT("dxPScxPivotGrid2LnkReg.pas");
USEFORMNS("dxPScxPivotGrid2Lnk.pas", DxpscxPivotGrid2lnk, dxfmPivotGridReportLinkDesignWindow);
USEPACKAGE("dcldxPSCoreC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("cxPivotGridC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("dclcxEditorsC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("CXLIBRARYC12.bpi");
USEPACKAGE("dxPScxCommonC12.bpi");

//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
 
