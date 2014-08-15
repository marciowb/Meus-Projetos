//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxComnC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEUNIT("dxRgKeya.pas");
USEUNIT("dxRegEd.pas");
USEUNIT("dxCommon.pas");
USEFORMNS("dxRgKeya.pas", dxRgKeya, frmdxAddNewRegKey);
USEFORMNS("dxRegEd.pas", dxRegEd, frmdxLibREgPathEditor);
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
