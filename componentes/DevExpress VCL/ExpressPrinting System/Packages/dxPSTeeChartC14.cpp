//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSTeeChartC14.res");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C14.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C14.bpi");
#elif defined(TEE7)
USEPACKAGE("tee714.bpi");
#elif defined(TEE8)
USEPACKAGE("tee814.bpi");
#elif defined(TEE9)
USEPACKAGE("tee914.bpi");
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
