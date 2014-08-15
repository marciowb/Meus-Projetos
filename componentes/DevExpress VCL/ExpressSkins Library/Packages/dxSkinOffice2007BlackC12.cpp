//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinOffice2007Black.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxSkinsCoreC12.bpi");
USEUNIT("dxSkinOffice2007Black.pas");
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
