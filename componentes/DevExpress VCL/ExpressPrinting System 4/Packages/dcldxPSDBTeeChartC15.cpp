//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSDBTeeChartC15.res");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("dcldxPSTeeChartC15.bpi");
USEPACKAGE("dxPSDBTeeChartC15.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSTeeChartC15.bpi");
USEPACKAGE("dcldxPSCoreC15.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
USEPACKAGE("teedb.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C15.bpi");
USEPACKAGE("teedb5C15.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C15.bpi");
USEPACKAGE("teedb6C15.bpi");
#elif defined(TEE7)
USEPACKAGE("tee715.bpi");
USEPACKAGE("teedb715.bpi");
#elif defined(TEE8)
USEPACKAGE("tee815.bpi");
USEPACKAGE("teedb815.bpi");
#elif defined(TEE9)
USEPACKAGE("tee915.bpi");
USEPACKAGE("teedb915.bpi");
#endif
USEUNIT("dxPSDBTCLnkReg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
