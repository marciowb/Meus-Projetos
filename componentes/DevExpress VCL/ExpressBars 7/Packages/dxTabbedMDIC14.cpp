//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxTabbedMDIC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEUNIT("dxTabbedMDI.pas");
USEUNIT("dxTabbedMDIStrs.pas");
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
