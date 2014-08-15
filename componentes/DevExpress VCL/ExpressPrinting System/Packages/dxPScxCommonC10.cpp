//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USERES("dxPScxCommonC10.res");
USEPACKAGE("dxPSLnksC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
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
