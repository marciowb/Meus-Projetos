//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxObjInsC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxbjInsC6.bpi");
USERES("dxOIReg.dcr");
USEUNIT("dxOIReg.pas");
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
