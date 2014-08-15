//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxTreeListC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("cxTreeListC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dclcxEditorsC15.bpi");
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
