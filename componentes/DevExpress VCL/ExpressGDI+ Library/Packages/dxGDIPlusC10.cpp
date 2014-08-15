//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dxGDIPlusC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10");
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
