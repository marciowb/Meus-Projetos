//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsDesignHelper.res");
USERES("dcldxSkinsDesignHelperC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxSkinsCoreC12.bpi");
USEPACKAGE("dcldxSkinsCoreC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
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
