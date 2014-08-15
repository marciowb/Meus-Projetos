//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxTreeListC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEUNIT("cxTLStrs.pas");
USEUNIT("cxTL.pas");
USEUNIT("cxTLData.pas");
USEUNIT("cxDBTL.pas");
USEUNIT("cxTLStyleSheetPreview.pas");
USEUNIT("cxTLExportLink.pas");
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
