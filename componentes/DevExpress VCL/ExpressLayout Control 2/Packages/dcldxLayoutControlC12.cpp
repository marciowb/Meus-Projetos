//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxLayoutControlC12.res");
USERES("dxLayoutControlReg.dcr.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxLayoutControlC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("dcldxCoreC12.bpi");
USEUNIT("dxLayoutLookAndFeelListDesignForm.pas");
USEUNIT("dxLayoutImport.pas");
USEUNIT("dxLayoutControlReg.pas");
USEFORMNS("dxLayoutLookAndFeelListDesignForm.pas", dxLayoutLookAndFeelListDesignForm, dxLayoutLookAndFeelListDesignForm);
USEFORMNS("dxLayoutImport.pas", dxLayoutImport, fmImport);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
