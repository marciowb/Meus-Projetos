//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsCoreC12.res");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
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
