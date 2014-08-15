//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSkinsDesignHelperC11.res");
USERES("dxSkinsDesignHelper.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxSkinsCoreC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dcldxSkinsCoreC12.bpi");
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
