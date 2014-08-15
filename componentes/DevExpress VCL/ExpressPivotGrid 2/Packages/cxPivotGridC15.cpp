//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
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
