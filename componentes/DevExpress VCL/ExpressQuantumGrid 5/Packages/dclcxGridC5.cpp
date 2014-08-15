//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxGridC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
USEPACKAGE("cxGridC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("dclcxLibraryVCLC5.bpi");
USEPACKAGE("dclcxEditorsC5.bpi");
USEPACKAGE("cxPageControlC5.bpi");
USEFORMNS("cxGridViewLayoutEditor.pas", Cxgridviewlayouteditor, cxGridViewLayoutEditor);
USEUNIT("cxCardViewEditor.pas");
USEUNIT("cxCustomTableViewEditor.pas");
USEUNIT("cxDBGridConverter.pas");
USEUNIT("cxDXGridConverter.pas");
USEFORMNS("cxGridEditor.pas", Cxgrideditor, cxGridEditor);
USEFORMNS("cxGridImportDialog.pas", Cxgridimportdialog, ImportDialog);
USEFORMNS("cxGridPredefinedStyles.pas", Cxgridpredefinedstyles, cxdmGridPredefinedStyles); /* TDataModule: File Type */
USEFORMNS("cxImageComboBoxItemsEditor.pas", Cximagecomboboxitemseditor, fmImageComboBoxItemsEditor);
USEUNIT("cxGridReg.pas");
USERES("cxGridReg.dcr");
USEUNIT("cxGridStructureNavigator.pas");
USEUNIT("cxChartViewEditor.pas");
USEUNIT("cxBandedTableViewEditor.pas");
USEUNIT("cxTableViewEditor.pas");
USEFORMNS("cxViewEditor.pas", Cxvieweditor, cxViewEditor);
USEUNIT("cxWWGridConverter.pas");
USEUNIT("cxGridConverter.pas");
USEUNIT("cxGridPopupMenuReg.pas");
USERES("cxGridPopupMenuReg.dcr");
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
