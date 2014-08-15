//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
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
