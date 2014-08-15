//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSkinsCoreC12.res");
USERES("dxSkinsReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxSkinsCoreC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEUNIT("dxSkinsReg.pas");
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
