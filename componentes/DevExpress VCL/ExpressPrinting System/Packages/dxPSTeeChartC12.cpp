//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSTeeChartC12.res");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C12.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C12.bpi");
#elif defined(TEE7)
USEPACKAGE("tee712.bpi");
#elif defined(TEE8)
USEPACKAGE("tee812.bpi");
#elif defined(TEE9)
USEPACKAGE("tee912.bpi");
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
