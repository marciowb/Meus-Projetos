//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsDesignHelper.res");
USERES("dcldxSkinsDesignHelperC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxSkinsCoreC15.bpi");
USEPACKAGE("dcldxSkinsCoreC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEUNIT("dxSkinsDesignHelperReg.pas");
USEUNIT("dxSkinsDesignHelper.pas");
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
