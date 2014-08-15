//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSDBTeeChartC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxPSTeeChartC12.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C12.bpi");
USEPACKAGE("teedb5C12.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C12.bpi");
USEPACKAGE("teedb6C12.bpi");
#elif defined(TEE7)
USEPACKAGE("tee712.bpi");
USEPACKAGE("teedb712.bpi");
#elif defined(TEE8)
USEPACKAGE("tee812.bpi");
USEPACKAGE("teedb812.bpi");
#elif defined(TEE9)
USEPACKAGE("tee912.bpi");
USEPACKAGE("teedb912.bpi");
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
