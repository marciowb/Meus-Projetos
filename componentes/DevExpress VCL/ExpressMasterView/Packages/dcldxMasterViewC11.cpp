//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxMasterViewC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxMasterViewC11.bpi");
USEUNIT("dxMasterViewColumnClassEditor.pas");
USEUNIT("dxMasterViewDesigner.pas");
USEUNIT("dxMasterViewImageColumnEditor.pas");
USEUNIT("dxMasterViewReg.pas");
USERES("dxMasterViewReg.dcr");
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
