//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPScxExtCommonC14.res");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPScxCommonC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxPSLnksC14.bpi");
USEUNIT("dxPScxCheckListBoxLnk.pas");
USEUNIT("dxPScxExtComCtrlsLnk.pas");
USEUNIT("dxPScxExtCommon.pas");
USEUNIT("dxPScxExtDBEditorLnks.pas");
USEUNIT("dxPScxExtEditorProducers.pas");
USEUNIT("dxPScxMCListBoxLnk.pas");
USEFORMNS("dxPScxCheckListBoxLnk.pas", dxPScxCheckListBoxLnk, cxfmCheckListBoxDesignWindow);
USEFORMNS("dxPScxMCListBoxLnk.pas", dxPScxMCListBoxLnk, cxfmMCListBoxDesignWindow);
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
