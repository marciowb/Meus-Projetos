//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPivotGridC10.res");
USERES("cxPivotGridReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExtEditorsC10.bpi");
USEPACKAGE("cxPivotGridC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
USEPACKAGE("dxThemeC10.bpi");

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
