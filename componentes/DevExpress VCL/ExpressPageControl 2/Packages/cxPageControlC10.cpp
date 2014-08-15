//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPageControlC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEUNIT("cxPC.pas");
USEUNIT("cxPCConsts.pas");
USEUNIT("cxPCGoDialog.pas");
USEUNIT("cxPCPainters.pas");
USEUNIT("cxPCPaintersFactory.pas");

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
