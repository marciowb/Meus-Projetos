//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxEdtrC6.res");
USERES("dxEdReg.dcr");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dclstd.bpi");
USEUNIT("dxEdReg.pas");
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
