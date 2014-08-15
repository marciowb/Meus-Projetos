//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSTeeChartC14.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxPSTeeChartC14.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dcldxPSCoreC14.bpi");
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
