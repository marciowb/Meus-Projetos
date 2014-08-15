//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxGridC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxExportC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEUNIT("cxGridStrs.pas");
USEFORMNS("cxFilterDialog.pas", Cxfilterdialog, cxFilterDialog);
USEUNIT("cxDBExtLookupComboBox.pas");
USEUNIT("cxGrid.pas");
USEUNIT("cxGridChartView.pas");
USEUNIT("cxGridBandedTableView.pas");
USEUNIT("cxGridCardView.pas");
USEUNIT("cxGridCommon.pas");
USEUNIT("cxGridCustomTableView.pas");
USEUNIT("cxGridCustomView.pas");
USEUNIT("cxGridDBChartView.pas");
USEUNIT("cxGridDBBandedTableView.pas");
USEUNIT("cxGridDBCardView.pas");
USEUNIT("cxGridDBDataDefinitions.pas");
USEUNIT("cxGridRows.pas");
USEUNIT("cxGridDBTableView.pas");
USEUNIT("cxGridDetailsSite.pas");
USEUNIT("cxGridLevel.pas");
USEUNIT("cxGridExportLink.pas");
USEUNIT("cxGridTableView.pas");
USEUNIT("cxGridFilterHelpers.pas");
USEUNIT("cxGridCustomPopUpMenu.pas");
USEUNIT("cxGridFooterPopupMenuItems.pas");
USEUNIT("cxGridHeaderPopupMenuItems.pas");
USEUNIT("cxGridGroupRowPopupMenuItems.pas");
USEUNIT("cxGridMenuOperations.pas");
USEUNIT("cxGridPopUpMenu.pas");
USEUNIT("cxGridStdPopUpMenu.pas");
USEUNIT("cxGridUIBandedTableHelper.pas");
USEUNIT("cxGridUICardHelper.pas");
USEUNIT("cxGridUICustomTableHelper.pas");
USEUNIT("cxGridUIHelper.pas");
USEUNIT("cxGridUITableHelper.pas");
USEUNIT("cxGridPopupMenuConsts.pas");
USEUNIT("cxGridStyleSheetsPreview.pas");
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
