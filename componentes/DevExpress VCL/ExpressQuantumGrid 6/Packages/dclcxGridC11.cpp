//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxGridC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxGridC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
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
