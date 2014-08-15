//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxGridC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("cxExportC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
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
USEUNIT("cxGridRows.pas");
USEUNIT("cxGridViewData.pas");
USEUNIT("cxGridDBTableView.pas");
USEUNIT("cxGridDetailsSite.pas");
USEUNIT("cxGridLevel.pas");
USEUNIT("cxExportGrid4Link.pas");
USEUNIT("cxGridTableView.pas");
USEUNIT("cxGridFilterHelpers.pas");
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
