//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPivotGridC12.res");
USERES("cxPivotGridReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPivotGridC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("dclcxEditorsC12.bpi");
USEPACKAGE("dxThemeC12.bpi");

USEFORM("cxPivotGridPredefinedStyles.pas", TcxdmPivotGridPredefinedStyles);  
USEFORM("cxPivotGridDesigner.pas", frmPivotGridDesigner);
USEUNIT("cxPivotGridReg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
