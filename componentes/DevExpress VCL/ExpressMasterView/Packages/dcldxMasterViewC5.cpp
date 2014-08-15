//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxMasterViewC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLX50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxMasterViewc5.bpi");
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
