//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSTeeChartC15.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("dxPSTeeChartC15.bpi");
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
USEPACKAGE("dcldxPSCoreC15.bpi");
#ifndef TEEPRO
USEPACKAGE("tee.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5C15.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6C15.bpi");
#elif defined(TEE7)
USEPACKAGE("tee715.bpi");
#elif defined(TEE8)
USEPACKAGE("tee815.bpi");
#elif defined(TEE9)
USEPACKAGE("tee915.bpi");
#endif
USEUNIT("dxPSTCLnkReg.pas");
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
