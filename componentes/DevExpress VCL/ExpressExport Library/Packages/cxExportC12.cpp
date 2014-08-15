//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxExportC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEUNIT("cxXLSExport.pas");
USEUNIT("cxHtmlXmlTxtExport.pas");
USEUNIT("cxExport.pas");
USEUNIT("cxExportStrs.pas");
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
