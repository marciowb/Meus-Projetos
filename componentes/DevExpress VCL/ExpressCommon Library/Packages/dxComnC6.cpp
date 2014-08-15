//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxComnC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEUNIT("dxCommon.pas");
USEUNIT("dxreged.pas");
USEUNIT("dxrgkeya.pas");
USEFORMNS("dxreged.pas", dxreged, frmdxLibREgPathEditor);
USEFORMNS("dxrgkeya.pas", dxrgkeya, frmdxAddNewRegKey);
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
