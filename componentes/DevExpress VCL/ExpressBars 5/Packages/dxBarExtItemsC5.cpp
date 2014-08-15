//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarExtItemsC5.res");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dxBarC5.bpi");
USEPACKAGE("dxcomnC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEUNIT("dxBarExtItems.pas");
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
