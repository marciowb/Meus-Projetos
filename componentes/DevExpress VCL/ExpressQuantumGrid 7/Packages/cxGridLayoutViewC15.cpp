//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxGridLayoutViewC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxGridC15.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxLayoutControlC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");

USEUNIT("cxGridLayoutView.pas"); 
USEUNIT("cxGridDBLayoutView.pas"); 
USEUNIT("cxGridLayoutViewCustomizationForm");
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
