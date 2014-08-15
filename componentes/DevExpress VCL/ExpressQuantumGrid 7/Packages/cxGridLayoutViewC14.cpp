//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxGridLayoutViewC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxGridC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxLayoutControlC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");

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
