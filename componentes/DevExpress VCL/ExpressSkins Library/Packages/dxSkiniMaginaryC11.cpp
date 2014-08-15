//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkiniMaginary.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxSkinsCoreC11.bpi");
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
