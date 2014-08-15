//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridOLAPC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("adortl.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPivotGridC14.bpi");
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
