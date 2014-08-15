//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxPScxExtCommonC12.res");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxExtCommonC12.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("dxPScxCommonC12.bpi");
USEPACKAGE("dcldxPSCoreC12.bpi");
USEUNIT("dxPScxExtDBEditorLnkReg.pas");
USEUNIT("dxPScxExtEditorLnkReg.pas");
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
