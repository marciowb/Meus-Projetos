//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPivotGridC15.res");
USERES("cxPivotGridReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPivotGridC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("dclcxEditorsC15.bpi");
USEPACKAGE("dxThemeC15.bpi");

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
