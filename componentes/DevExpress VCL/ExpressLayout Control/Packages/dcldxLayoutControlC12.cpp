//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlReg.dcr");
USERES("dcldxLayoutControlC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("dxLayoutControlC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
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
