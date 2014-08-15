//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxEdtrC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxComnC6.bpi");
USEUNIT("dxCalc.pas");
USEUNIT("dxCntner.pas");
USEUNIT("dxEditor.pas");
USEUNIT("dxExEdtr.pas");
USEUNIT("dxGrDate.pas");
USEUNIT("dxEdStr.pas");
USEUNIT("dxUtils.pas");
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
