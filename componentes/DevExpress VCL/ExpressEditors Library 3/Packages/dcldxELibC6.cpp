//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxELibC6.res");
USERES("dxEdLReg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("dxELibC6.bpi");
USEPACKAGE("dclstd.bpi");
USEUNIT("dxImgEd.pas");
USEUNIT("dxEdLReg.pas");
USEFORMNS("dxImgEd.pas", dxImgEd, FImageValuesEdit);
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
