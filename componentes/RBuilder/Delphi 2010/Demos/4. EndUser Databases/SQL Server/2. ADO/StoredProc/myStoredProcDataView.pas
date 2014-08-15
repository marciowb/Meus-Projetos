{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2005                    BBBBB   }

unit MyStoredProcDataView;

interface

uses
  Classes, SysUtils, Forms, ExtCtrls,  DB, DBTables,  Controls,  Dialogs,
  ppClass, ppReport, ppDB, ppDBPipe, ppClasUt, ppTypes, ppUtils, ppComm,
  daDataView, daDB, daSQL, daADO, ppRTTI;

type

  { TdvCustomStoredProcDataView }
  TdvCustomStoredProcDataView = class(TdaADOStoredProcTemplateDataView)
    private

    protected
      procedure ReportGetAutoSearchValuesEvent; virtual; abstract;

    public
      constructor Create(aOwner: TComponent); override;

      class function DataDesignerClass: TClass; override;

      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

  end; {class, TdvCustomStoredProcDataView}

  { TdvCustOrdersDetailStoredProc }
  TdvCustOrdersDetailStoredProc = class(TdvCustomStoredProcDataView)
    private

    protected
      procedure SetReport(aReport: TppCustomReport); override;
      procedure ReportGetAutoSearchValuesEvent; override;

    public
      constructor Create(aOwner: TComponent); override;

      class function ClassDescription: String; override;

  end; {class, TdvCustOrdersDetailStoredProc}

  { TdvEmpSalesStoredProc }
  TdvEmpSalesStoredProc = class(TdvCustomStoredProcDataView)
    private

    protected
      procedure SetReport(aReport: TppCustomReport); override;
      procedure ReportGetAutoSearchValuesEvent; override;

    public
      constructor Create(aOwner: TComponent); override;

      class function ClassDescription: String; override;

  end; {class, TdvCustOrdersDetailStoredProc}

implementation

uses
  ADODB,
  ppASField;

{******************************************************************************
 *
 ** Custom Stored Procedure DataView
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomStoredProcDataView.Create }

constructor TdvCustomStoredProcDataView.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  EditOptions := [ppemPreview];
  EnabledOptions := EditOptions;

end;

{------------------------------------------------------------------------------}
{ TdvCustomStoredProcDataView.DataDesignerClass }

class function TdvCustomStoredProcDataView.DataDesignerClass: TClass;
begin
  Result := GetClass('TdaQueryDesigner');
end; {class function, DataDesignerClass}

{------------------------------------------------------------------------------}
{ TdvCustomStoredProcDataView.EventNotify }

procedure TdvCustomStoredProcDataView.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  inherited EventNotify(aCommunicator, aEventID, aParams);

  if (aCommunicator = Report) then

    case aEventID of
      ciReportGetAutoSearchValues:
        ReportGetAutoSearchValuesEvent;

    end

end; {procedure, EventNotify}

{******************************************************************************
 *
 ** CustOrdersDetailStoredProc - single stored procedure with Query Designer support
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustOrdersDetailStoredProc.Create }

constructor TdvCustOrdersDetailStoredProc.Create(aOwner: TComponent);
var
  lDataBase: TComponent;
begin

  inherited Create(aOwner);

  lDataBase := Owner.FindComponent('euDatabase');

  StoredProc.Connection := TAdoConnection(lDataBase);

  StoredProc.ProcedureName := 'CustOrdersDetail;1';

  StoredProc.Parameters.CreateParameter('@OrderID', ftInteger, pdInput, 0, 0);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvCustOrdersDetailStoredProc.ClassDescription }

class function TdvCustOrdersDetailStoredProc.ClassDescription: String;
begin
  Result := 'CustOrdersDetail Stored Procedure';

end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdvCustOrdersDetailStoredProc.ReportGetAutoSearchValuesEvent }

procedure TdvCustOrdersDetailStoredProc.ReportGetAutoSearchValuesEvent;
var
  lMainReport: TppReport;
  lAutoSearchField: TppAutoSearchField;
begin

  lMainReport := TppReport(Report.MainReport);

  lAutoSearchField := lMainReport.AutoSearchFieldByName('OrderID');

  StoredProc.Active := False;

  StoredProc.Parameters.ParamByName('@OrderID').Value := lAutoSearchField.Value;

end; {procedure, ReportGetAutoSearchValuesEvent}

{------------------------------------------------------------------------------}
{ TdvCustOrdersDetailStoredProc.SetReport }

procedure TdvCustOrdersDetailStoredProc.SetReport(aReport: TppCustomReport);
var
  lMainReport: TppReport;
begin

  inherited SetReport(aReport);

  if Report <> nil then
    begin
      lMainReport := TppReport(Report.MainReport);
      lMainReport.ShowAutoSearchDialog := True;

      lMainReport.CreateAutoSearchField('StoredProc', 'OrderID', 'OrderID', dtInteger, soEqual, '', True);
    end;

end; {procedure, SetReport}

{******************************************************************************
 *
 ** EmpSalesStoredProc - single stored procedure with Query Designer support
 *
{******************************************************************************}

class function TdvEmpSalesStoredProc.ClassDescription: String;
begin
  Result := 'Employee Sales by Country Stored Procedure';

end;

constructor TdvEmpSalesStoredProc.Create(aOwner: TComponent);
var
  lDataBase: TComponent;
begin

  inherited Create(aOwner);

  lDataBase := Owner.FindComponent('euDatabase');

  StoredProc.Connection := TAdoConnection(lDataBase);

  StoredProc.ProcedureName := 'Employee Sales by Country;1';

  StoredProc.Parameters.CreateParameter('@Beginning_Date', ftDateTime, pdInput, 0, 0);
  StoredProc.Parameters.CreateParameter('@Ending_Date', ftDateTime, pdInput, 0, 0);

end;

procedure TdvEmpSalesStoredProc.ReportGetAutoSearchValuesEvent;
var
  lMainReport: TppReport;
  lAutoSearchField1: TppAutoSearchField;
  lAutoSearchField2: TppAutoSearchField;
begin

  lMainReport := TppReport(Report.MainReport);

  lAutoSearchField1 := lMainReport.AutoSearchFieldByName('Beginning_Date');
  lAutoSearchField2 := lMainReport.AutoSearchFieldByName('Ending_Date');

  StoredProc.Active := False;

  StoredProc.Parameters.ParamByName('@Beginning_Date').Value := lAutoSearchField1.Value;
  StoredProc.Parameters.ParamByName('@Ending_Date').Value := lAutoSearchField2.Value;

end;

procedure TdvEmpSalesStoredProc.SetReport(aReport: TppCustomReport);
var
  lMainReport: TppReport;
begin

  inherited SetReport(aReport);

  if Report <> nil then
    begin
      lMainReport := TppReport(Report.MainReport);
      lMainReport.ShowAutoSearchDialog := True;

      lMainReport.CreateAutoSearchField('StoredProc1', 'Beginning_Date', 'Beginning Date', dtDateTime, soEqual, '', True);
      lMainReport.CreateAutoSearchField('StoredProc1', 'Ending_Date', 'Ending Date', dtDateTime, soEqual, '', True);
    end;

end;

initialization

  {register the dataviews }
  daRegisterDataView(TdvCustOrdersDetailStoredProc);
  daRegisterDataView(TdvEmpSalesStoredProc);

finalization

  daUnRegisterDataView(TdvCustOrdersDetailStoredProc);
  daUnRegisterDataView(TdvEmpSalesStoredProc);

end.
