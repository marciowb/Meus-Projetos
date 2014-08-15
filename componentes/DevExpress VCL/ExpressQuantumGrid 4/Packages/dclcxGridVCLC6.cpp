//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxGridVCLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxGridVCLC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dclcxEditorsVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEFORMNS("cxGridViewLayoutEditor.pas", Cxgridviewlayouteditor, cxGridViewLayoutEditor);
USEUNIT("cxCardViewEditor.pas");
USEUNIT("cxCustomTableViewEditor.pas");
USEUNIT("cxDBGridConverter.pas");
USEUNIT("cxDXGridConverter.pas");
USEFORMNS("cxGridEditor.pas", Cxgrideditor, cxGridEditor);
USEFORMNS("cxGridImportDialog.pas", Cxgridimportdialog, ImportDialog);
USEFORMNS("cxGridPredefinedStyles.pas", Cxgridpredefinedstyles, cxdmGridPredefinedStyles); /* TDataModule: File Type */
USEUNIT("cxGridReg.pas");
USERES("cxGridReg.dcr");
USEUNIT("cxGridStructureNavigator.pas");
USEUNIT("cxGridStyleSheetsPreview.pas");
USEUNIT("cxBandedTableViewEditor.pas");
USEUNIT("cxTableViewEditor.pas");
USEFORMNS("cxViewEditor.pas", Cxvieweditor, cxViewEditor);
USEUNIT("cxWWGridConverter.pas");
USEUNIT("cxGridConverter.pas");
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
