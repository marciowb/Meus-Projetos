//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxObjInsC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxInsC6.bpi");
USEUNIT("dxOI");
USEUNIT("dxOIPictureEd");
USEUNIT("dxOIStringsEd");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
    return 1;
}
//---------------------------------------------------------------------------
