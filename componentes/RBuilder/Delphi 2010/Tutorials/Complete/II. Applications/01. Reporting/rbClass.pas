{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996-2000 Digital Metaphors Corporation            }
{                                                                              }
{******************************************************************************}

unit rbClass;

interface

uses Forms, ppReport;

type

   {Note: TrbReportForm is the ancestor for all report forms used in the main
         tutorial project.

         1. Defines a single public property - Report.

         2. Defines a single protected method - GetReport.

         3. The GetReport method is declared as 'virtual; abstract'
  
               virtual   - the method can be overridden by descendants

               abstract  - the method is not implemented by the ancestor and
                           therefore MUST be implemented by descendants.

         4. Descendant forms must override the GetReport method to return the
            TppReport object residing on the form.


  { TrbReportForm }

  TrbReportForm = class(TForm)
  protected
    function GetReport: TppReport; virtual; abstract;

  public
    property Report: TppReport read GetReport;

  end; {class, TrbReportForm}


implementation

end.
 
