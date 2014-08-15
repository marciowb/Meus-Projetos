//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxExportC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
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
