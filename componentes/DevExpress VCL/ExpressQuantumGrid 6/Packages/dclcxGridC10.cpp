//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxGridC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxGridC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("cxPageControlC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
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
