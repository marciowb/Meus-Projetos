//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USERES("dxPScxExtCommonC14.res");
USEPACKAGE("dxPSLnksC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
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
