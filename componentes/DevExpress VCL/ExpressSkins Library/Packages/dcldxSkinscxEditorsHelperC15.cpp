//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxEditorsHelperC15.res");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dcldxSkinsCoreC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC15.bpi");
USEUNIT("dxSkinscxEditorsHelperReg.pas");
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
