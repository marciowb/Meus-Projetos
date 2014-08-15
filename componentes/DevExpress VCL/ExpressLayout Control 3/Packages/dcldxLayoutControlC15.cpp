//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxLayoutControlC15.res");
USERES("dxLayoutControlReg.dcr.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxLayoutControlC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("dcldxCoreC15.bpi");
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
