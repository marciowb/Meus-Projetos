//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarDBNavC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxBarC10.bpi");
USEPACKAGE("dxBarDBNavC10.bpi");
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
