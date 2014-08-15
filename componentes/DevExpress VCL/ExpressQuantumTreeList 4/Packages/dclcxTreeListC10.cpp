//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxTreeListC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExportC10.bpi");
USEPACKAGE("cxTreeListC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
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
