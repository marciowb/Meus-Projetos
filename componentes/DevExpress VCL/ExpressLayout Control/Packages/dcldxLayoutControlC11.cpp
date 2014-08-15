//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlReg.dcr");
USERES("dcldxLayoutControlC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxComnC11.bpi");
USEPACKAGE("dxLayoutControlC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEUNIT("dxLayoutDesignCommon.pas");
USEFORMNS("dxLayoutDesignForm.pas", dxLayoutDesignForm, DesignForm);
USEFORMNS("dxLayoutLookAndFeelListDesignForm.pas", dxLayoutLookAndFeelListDesignForm, LookAndFeelListDesignForm);
USEUNIT("dxLayoutControlReg.pas");
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
