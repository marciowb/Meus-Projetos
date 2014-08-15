//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSkinsCoreC14.res");
USERES("dxSkinsReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxSkinsCoreC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
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
