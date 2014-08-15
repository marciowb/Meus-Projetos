//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxObjInsC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxInsC5.bpi");
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
