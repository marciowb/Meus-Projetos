//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxSchedulerC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExtEditorsC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxExportC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEUNIT("cxScheduler.pas");
USEUNIT("cxSchedulerCustomControls.pas");
USEUNIT("cxSchedulerCustomResourceView.pas");
USEUNIT("cxSchedulerDateNavigator.pas");
USEUNIT("cxSchedulerDayView.pas");
USEUNIT("cxSchedulerDBStorage.pas");
USEUNIT("cxSchedulerDialogs.pas");
USEUNIT("cxSchedulerEventEditor.pas");
USEUNIT("cxSchedulerGoToDateDialog.pas");
USEUNIT("cxSchedulerRecurrenceEditor.pas");
USEUNIT("cxSchedulerRecurrenceSelectionDialog.pas");
USEUNIT("cxSchedulerResourcesLayoutEditor.pas");
USEUNIT("cxSchedulerStorage.pas");
USEUNIT("cxSchedulerStrs.pas");
USEUNIT("cxSchedulerUtils.pas");
USEUNIT("cxExportSchedulerLink.pas");
USEUNIT("cxSchedulerReminderWindow.pas");
USEUNIT("cxSchedulerTimeGridView.pas");
USEUNIT("cxSchedulerYearView.pas");
USEUNIT("cxSchedulerWeekView.pas");
USEUNIT("cxSchedulerOutlookExchange.pas");
USEUNIT("cxDateNavigator.pas");

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
