//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSTeeChartC6.res");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5c6.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6c6.bpi");
#elif defined(TEE7)
USEPACKAGE("tee7c6.bpi");
#elif defined(TEE8)
USEPACKAGE("tee8c6.bpi");
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
