//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxCommonC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("dxPSLnksC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("cxDataC15.bpi");
USEUNIT("dxPScxCommon.pas");
USEUNIT("dxPScxDBEditorLnks.pas");
USEUNIT("dxPScxEditorLnks.pas");
USEUNIT("dxPScxEditorProducers.pas");
USEUNIT("dxPScxImgLnk.pas");
USEUNIT("dxPScxListBoxLnk.pas");
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
