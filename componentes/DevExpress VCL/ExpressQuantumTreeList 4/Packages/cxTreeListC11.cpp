//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxTreeListC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
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
