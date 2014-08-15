//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPivotGridC11.res");
USERES("cxPivotGridReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
USEPACKAGE("cxPivotGridC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("dxThemeC11.bpi");

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
