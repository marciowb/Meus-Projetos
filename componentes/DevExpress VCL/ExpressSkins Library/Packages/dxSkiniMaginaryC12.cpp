//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkiniMaginary.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxSkinsCoreC12.bpi");
USEUNIT("dxSkiniMaginary.pas");
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
