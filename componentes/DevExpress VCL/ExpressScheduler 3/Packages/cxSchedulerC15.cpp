//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxSchedulerC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEUNIT("cxScheduler.pas");
USEUNIT("cxSchedulerAggregateStorage.pas");
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
USEUNIT("cxSchedulerHolidaysLocationHolidayEditor.pas");
USEUNIT("cxSchedulerHolidays.pas");
USEUNIT("cxSchedulerHolidaysEditor.pas");
USEUNIT("cxSchedulerHolidaysLocationEditor.pas");
USEUNIT("cxSchedulerGanttView.pas");
USEUNIT("cxSchedulerTaskDependencyEditor.pas");

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
