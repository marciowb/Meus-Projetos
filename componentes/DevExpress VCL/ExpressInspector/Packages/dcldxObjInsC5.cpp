//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxObjInsC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dxbjInsC5.bpi");
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
