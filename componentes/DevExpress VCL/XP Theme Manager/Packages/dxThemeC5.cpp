//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dxThemeC5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("dxUxTheme.pas");
USEUNIT("dxThemeManager.pas");
USEUNIT("dxThemeConsts.pas");
USEUNIT("dxOffice11.pas");
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
