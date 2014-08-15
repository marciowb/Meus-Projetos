//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxTreeListC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxExportC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
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
