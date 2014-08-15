//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridOLAPC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("adortl.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPivotGridC15.bpi");
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
