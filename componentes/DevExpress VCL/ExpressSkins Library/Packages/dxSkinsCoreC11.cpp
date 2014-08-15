//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsCoreC11.res");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
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
