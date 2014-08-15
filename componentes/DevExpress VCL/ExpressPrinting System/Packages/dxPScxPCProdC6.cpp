//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USERES("dxPScxPCProdC6.res");
USEPACKAGE("cxPageControlVCLC6.bpi");
USEUNIT("dxPScxPageControlProducer.pas");
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
