//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USERES("dxPScxPCProdC12.res");
USEPACKAGE("cxPageControlC12.bpi");
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
