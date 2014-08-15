//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPScxCommonC12.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC12.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("dcldxPSCoreC12.bpi");
USEUNIT("dxPScxCommonReg.pas");
USEUNIT("dxPScxDBEditorLnkReg.pas");
USEUNIT("dxPScxEditorLnkReg.pas");
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
