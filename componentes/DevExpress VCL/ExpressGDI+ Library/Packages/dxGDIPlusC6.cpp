//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dxGDIPlusC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEUNIT("dxGDIPlusClasses.pas");
USEUNIT("dxGDIPlusAPI.pas");
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
