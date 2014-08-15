//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarDBNavC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxBarC5.bpi");
USEPACKAGE("dxBarDBNavC5.bpi");
USEUNIT("dxBarDBNavReg.pas");
USERES("dxBarDBNavReg.dcr");
USEFORMNS("dxBarDBCheckLinksEd.pas", Dxbardbchecklinksed, dxBarDBCheckLinksEditor);
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
