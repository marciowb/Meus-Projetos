//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USERES("dxPScxExtCommonC11.res");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
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
