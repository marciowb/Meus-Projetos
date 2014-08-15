//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USERES("dxPScxCommonC6.res");
USEPACKAGE("dxPSLnksC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
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
