//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxExtEditorsVCLC6.bpi");
USEPACKAGE("cxExportVClC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEUNIT("cxCustomPivotGrid.pas");
USEUNIT("cxPivotGrid.pas");
USEUNIT("cxDBPivotGrid.pas");
USEUNIT("cxPivotGridStrs.pas");
USEUNIT("cxPivotGridCustomization.pas");
USEUNIT("cxExportPivotGridLink.pas");
USEUNIT("cxPivotGridStyleSheetsPreview.pas");
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
