//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSDBTeeChartC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxPSTeeChartC14.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C14.bpi");
USEPACKAGE("teedb5C14.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C14.bpi");
USEPACKAGE("teedb6C14.bpi");
#elif defined(TEE7)
USEPACKAGE("tee714.bpi");
USEPACKAGE("teedb714.bpi");
#elif defined(TEE8)
USEPACKAGE("tee814.bpi");
USEPACKAGE("teedb814.bpi");
#elif defined(TEE9)
USEPACKAGE("tee914.bpi");
USEPACKAGE("teedb914.bpi");
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
