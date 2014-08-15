//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPSLnksC15.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSLnksC15.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("dcldxPSCoreC15.bpi");
USEUNIT("dxPSLnkReg.pas");
USEUNIT("dxPSDBCtrlLnkReg.pas");
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
