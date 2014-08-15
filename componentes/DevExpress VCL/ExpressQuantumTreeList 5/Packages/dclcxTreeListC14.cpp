//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxTreeListC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("cxTreeListC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
USEPACKAGE("designide.bpi");
USEFORMNS("cxTLEditor.pas", Cxtldsgnedtrs, cxTreeListBandColumnDesigner);
USEFORMNS("cxTLItemsEditor.pas", Cxtlitemsedtr, frmItemsEditor);
USEFORMNS("cxTLPredefinedStyles.pas", Cxtlpredefinedstyles, cxdmTreeListPredefinedStyles); /* TDataModule: DesignClass */
USEUNIT("cxTLReg.pas");
USERES("cxTLReg.dcr");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
