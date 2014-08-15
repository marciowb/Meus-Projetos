//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxTreeListVCLC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxExportVCLC6.bpi");
USEPACKAGE("cxTreeListVCLC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("dclcxEditorsVCLC6.bpi");
USEPACKAGE("designide.bpi");
USEUNIT("cxDXTLConverter.pas");
USEUNIT("cxTLConverter.pas");
USEFORMNS("cxTLDsgnEdtrs.pas", Cxtldsgnedtrs, cxTreeListBandColumnDesigner);
USEFORMNS("cxTLItemsEdtr.pas", Cxtlitemsedtr, frmItemsEditor);
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
