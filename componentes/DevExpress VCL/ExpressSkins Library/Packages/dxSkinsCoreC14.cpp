//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsCoreC14.res");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
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
