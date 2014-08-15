//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxExportC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("xmlrtl.bpi");
USEPACKAGE("dxGdiPlusC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEUNIT("cxXLSExport.pas");
USEUNIT("dxXLSXExport.pas");
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
