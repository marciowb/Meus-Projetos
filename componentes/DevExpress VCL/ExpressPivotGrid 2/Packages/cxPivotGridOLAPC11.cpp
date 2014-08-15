//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridOLAPC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("adortl.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
USEPACKAGE("cxPivotGridC11.bpi");
USEFORM("cxPivotGridOLAPConnectionDesigner.pas", frmConnectionDesigner);
USEUNIT("cxADOMDInt.pas");
USEUNIT("cxPivotGridOLAPDataSource.pas");
USEUNIT("cxPivotGridOLAPQueryBuilder.pas");
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
