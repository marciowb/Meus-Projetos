//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSTeeChartC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C10.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C10.bpi");
#elif defined(TEE7)
USEPACKAGE("tee710.bpi");
#elif defined(TEE8)
USEPACKAGE("tee810.bpi");
#elif defined(TEE9)
USEPACKAGE("tee910.bpi");
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
