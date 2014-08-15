//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dxGDIPlusC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
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
