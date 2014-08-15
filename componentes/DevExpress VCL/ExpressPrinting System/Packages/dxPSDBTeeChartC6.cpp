//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSDBTeeChartC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxPSTeeChartC6.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5c6.bpi");
USEPACKAGE("teedb5c6.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6c6.bpi");
USEPACKAGE("teedb6c6.bpi");
#elif defined(TEE7)
USEPACKAGE("tee7c6.bpi");
USEPACKAGE("teedb7c6.bpi");
#elif defined(TEE8)
USEPACKAGE("tee8c6.bpi");
USEPACKAGE("teedb8c6.bpi");
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
