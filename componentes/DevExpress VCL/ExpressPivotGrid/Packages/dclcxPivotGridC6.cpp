//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPivotGridC6.res");
USERES("cxPivotGridReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxExtEditorsVCLC6.bpi");
USEPACKAGE("cxPivotGridC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("dclcxEditorsVCLC6.bpi");
USEPACKAGE("dxThemeC6.bpi");

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
