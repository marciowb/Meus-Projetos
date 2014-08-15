//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxGridVCLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxExportVCLC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEUNIT("cxGridStrs.pas");
USEFORMNS("cxFilterDialog.pas", Cxfilterdialog, cxFilterDialog);
USEUNIT("cxDBExtLookupComboBox.pas");
USEUNIT("cxGrid.pas");
USEUNIT("cxGridBandedTableView.pas");
USEUNIT("cxGridCardView.pas");
USEUNIT("cxGridCommon.pas");
USEUNIT("cxGridCustomTableView.pas");
USEUNIT("cxGridCustomView.pas");
USEUNIT("cxGridDBBandedTableView.pas");
USEUNIT("cxGridDBCardView.pas");
USEUNIT("cxGridDBDataDefinitions.pas");
USEUNIT("cxGridDBTableView.pas");
USEUNIT("cxGridDetailsSite.pas");
USEUNIT("cxGridLevel.pas");
USEUNIT("cxGridRows.pas");
USEUNIT("cxExportGrid4Link.pas");
USEUNIT("cxGridTableView.pas");
USEUNIT("cxGridFilterHelpers.pas");
USEUNIT("cxGridViewData.pas");
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
