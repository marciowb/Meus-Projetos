//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSDBTeeChartC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSTeeChartC11.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C11.bpi");
USEPACKAGE("teedb5C11.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C11.bpi");
USEPACKAGE("teedb6C11.bpi");
#elif defined(TEE7)
USEPACKAGE("tee711.bpi");
USEPACKAGE("teedb711.bpi");
#elif defined(TEE8)
USEPACKAGE("tee811.bpi");
USEPACKAGE("teedb811.bpi");
#elif defined(TEE9)
USEPACKAGE("tee911.bpi");
USEPACKAGE("teedb911.bpi");
#endif
USEUNIT("dxPSDBTCLnk.pas");
USEUNIT("dxPSDBTCLnkReg.pas");
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
