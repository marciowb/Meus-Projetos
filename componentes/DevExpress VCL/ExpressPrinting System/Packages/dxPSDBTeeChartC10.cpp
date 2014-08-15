//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSDBTeeChartC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxPSTeeChartC10.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C10.bpi");
USEPACKAGE("teedb5C10.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C10.bpi");
USEPACKAGE("teedb6C10.bpi");
#elif defined(TEE7)
USEPACKAGE("tee710.bpi");
USEPACKAGE("teedb710.bpi");
#elif defined(TEE8)
USEPACKAGE("tee810.bpi");
USEPACKAGE("teedb810.bpi");
#elif defined(TEE9)
USEPACKAGE("tee910.bpi");
USEPACKAGE("teedb910.bpi");
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
