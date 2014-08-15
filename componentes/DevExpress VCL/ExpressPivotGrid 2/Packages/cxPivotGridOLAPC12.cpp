//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxPivotGridOLAPC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("adortl.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPivotGridC12.bpi");
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
