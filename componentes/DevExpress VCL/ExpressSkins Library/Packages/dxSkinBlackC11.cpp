//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinBlack.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxSkinsCoreC11.bpi");
USEUNIT("dxSkinBlack.pas");
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
