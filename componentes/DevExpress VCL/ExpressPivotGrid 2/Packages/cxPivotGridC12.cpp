//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxExportC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
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
