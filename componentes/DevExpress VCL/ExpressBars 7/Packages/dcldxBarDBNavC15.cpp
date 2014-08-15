//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarDBNavC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("dxBarDBNavC15.bpi");
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
