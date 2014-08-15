//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEUNIT("cxCustomPivotGrid.pas");
USEUNIT("cxPivotGrid.pas");
USEUNIT("cxDBPivotGrid.pas");
USEUNIT("cxPivotGridStrs.pas");
USEUNIT("cxPivotGridCustomization.pas");
USEUNIT("cxExportPivotGridLink.pas");
USEUNIT("cxPivotGridSummaryDataSet.pas");
USEUNIT("cxPivotGridDrillDownDataSet.pas");
USEUNIT("cxPivotGridCustomDataSet.pas");
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
