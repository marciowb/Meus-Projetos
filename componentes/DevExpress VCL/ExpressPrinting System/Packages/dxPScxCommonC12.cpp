//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USERES("dxPScxCommonC12.res");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("designide.bpi");
USEUNIT("dxPScxCommon.pas");
USEUNIT("dxPScxCommonReg.pas");
USEUNIT("dxPScxDBEditorLnkReg.pas");
USEUNIT("dxPScxDBEditorLnks.pas");
USEUNIT("dxPScxEditorLnks.pas");
USEUNIT("dxPScxEditorLnkReg.pas");
USEUNIT("dxPScxEditorProducers.pas");
USEUNIT("dxPScxImgLnk.pas");
USEUNIT("dxPScxListBoxLnk.pas");
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
