//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsCoreC15.res");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEUNIT("dxSkinsCore.pas");
USEUNIT("dxSkinsForm.pas");
USEUNIT("dxSkinsDefaultPainters.pas");
USEUNIT("dxSkinsLookAndFeelPainter.pas");
USEUNIT("dxSkinsStrs.pas");
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
