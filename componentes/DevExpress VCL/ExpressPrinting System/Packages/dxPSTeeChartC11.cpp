//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSTeeChartC11.res");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C11.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C11.bpi");
#elif defined(TEE7)
USEPACKAGE("tee711.bpi");
#elif defined(TEE8)
USEPACKAGE("tee811.bpi");
#elif defined(TEE9)
USEPACKAGE("tee911.bpi");
#endif
USEUNIT("dxPSTCLnk.pas");
USEUNIT("dxPSTCLnkReg.pas");
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
