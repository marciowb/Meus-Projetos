//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USERES("dxPScxExtCommonC12.res");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEUNIT("dxPScxCheckListBoxLnk.pas");
USEUNIT("dxPScxExtComCtrlsLnk.pas");
USEUNIT("dxPScxExtCommon.pas");
USEUNIT("dxPScxExtDBEditorLnkReg.pas");
USEUNIT("dxPScxExtDBEditorLnks.pas");
USEUNIT("dxPScxExtEditorLnkReg.pas");
USEUNIT("dxPScxExtEditorProducers.pas");
USEUNIT("dxPScxMCListBoxLnk.pas");
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
