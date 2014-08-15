//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPageControlC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
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
