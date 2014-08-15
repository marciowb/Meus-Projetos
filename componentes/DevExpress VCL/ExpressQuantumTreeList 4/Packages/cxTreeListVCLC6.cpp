//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxTreeListVCLC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxExportVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEUNIT("cxTLStrs.pas");
USEUNIT("cxExportTL4Link.pas");
USEUNIT("cxTL.pas");
USEUNIT("cxTLData.pas");
USEUNIT("cxTLIntf.pas");
USEUNIT("cxDBTL.pas");
USEUNIT("cxTLStyleSheetPreview.pas");
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
