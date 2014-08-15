//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxCoreC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEUNIT("dxCore.pas");
USEUNIT("dxMessages.pas");
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
