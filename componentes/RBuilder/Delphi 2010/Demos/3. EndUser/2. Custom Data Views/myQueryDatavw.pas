{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myQueryDatavw;

interface

uses
  Classes, SysUtils, Forms, ExtCtrls,  DB, DBTables,  Controls,  Dialogs,
  ppClass, ppReport, ppDB, ppDBPipe, ppDBBDE, ppClasUt, ppTypes, ppUtils, ppComm,
  daDataView, daDB, daDBBDE, daSQL;

type


  {TdvCustomQueryDataView
     - ancestor for Query templates declared below
     - descends from BDEQueryTemplateDataView which contains a single
          TQuery, TDataSource, BDEPipeline
     - adds functionality to support Query Designer }

  TdvCustomQueryDataView = class(TdaBDEQueryTemplateDataView)
    private

    protected
      procedure CreateSearchCriteria; virtual;
      procedure SetReport(aReport: TppCustomReport); override;

    public
      class function DataDesignerClass: TClass; override;

    published

  end; {class, TdvCustomAutoSearchDataView}


  { TdvCustomerQuery:
     - single query dataview on customer, end-user can use the Query Designer
       to further customize the query as desired }

  TdvCustomerQuery = class(TdvCustomQueryDataView)
    private

    protected
      procedure CreateSearchCriteria; override;

    public
      constructor Create(aOwner: TComponent); override;

      class function ClassDescription: String; override;

      procedure DefineSelectedFields; override;

    published

  end; {class, TdvCustomerQuery}


implementation


{******************************************************************************
 *
 ** Q U E R Y   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomQueryDataView.DataDesignerClass }

class function TdvCustomQueryDataView.DataDesignerClass: TClass;
begin
  Result := GetClass('TdaQueryDesigner');
end; {class function, DataDesignerClass}

{------------------------------------------------------------------------------}
{ TdvCustomQueryDataView.CreateSearchCriteria }

procedure TdvCustomQueryDataView.CreateSearchCriteria;
begin

  {note: descendants can create autosearch criteria here}


end; {procedure, CreateSearchCriteria}

{------------------------------------------------------------------------------}
{ TdvCustomQueryDataView.SetReport }

procedure TdvCustomQueryDataView.SetReport(aReport: TppCustomReport);
begin

  inherited SetReport(aReport);

  if (aReport = nil) then Exit;

  {create the search criteria}
  CreateSearchCriteria;

end; {procedure, SetReport}

{******************************************************************************
 *
 ** CustomerQuery - single query with Query Designer support
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomerQuery.Create }

constructor TdvCustomerQuery.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DatabaseName := 'DBDemos';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvCustomerQuery.ClassDescription }

class function TdvCustomerQuery.ClassDescription: String;
begin
  Result := 'Customer QueryDesign';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdvCustomerQuery.DefineSelectedFields }

procedure TdvCustomerQuery.DefineSelectedFields;
var
  lCustomerTable: TdaTable;

begin

  if SQL.SelectFieldCount > 0 then Exit;

  inherited DefineSelectedFields;

  lCustomerTable := AddSelectTable('customer.db');

  {AddSelectField parameters: Table, FieldName, FieldAlias, Searchable, Sortable}
  AddSelectField(lCustomerTable, 'Company',         '',                   True,  True);
  AddSelectField(lCustomerTable, 'Contact',         'Contact Name',       True,  True);
  AddSelectField(lCustomerTable, 'CustNo',          'Customer No.',       False, True);
  AddSelectField(lCustomerTable, 'Addr1',           'Address Line 1',     False, True);
  AddSelectField(lCustomerTable, 'Addr2',           'Address Line 2',     False, True);
  AddSelectField(lCustomerTable, 'City',            '',                   True,  True);
  AddSelectField(lCustomerTable, 'State',           '',                   False, True);
  AddSelectField(lCustomerTable, 'Zip',             'Zip Code',           False, True);
  AddSelectField(lCustomerTable, 'Country',         '',                   False, True);
  AddSelectField(lCustomerTable, 'Fax',             'Fax No.',            False, True);
  AddSelectField(lCustomerTable, 'Phone',           'Phone No.',          False, True);
  AddSelectField(lCustomerTable, 'LastInvoiceDate', 'Last Invoice Date',  False, True);
  AddSelectField(lCustomerTable, 'TaxRate',         'Tax Rate',           False, True);

end; {procedure, DefineSelectedFields}


{------------------------------------------------------------------------------}
{ TdvCustomerQuery.CreateSearchCriteria }

procedure TdvCustomerQuery.CreateSearchCriteria;
var
  lMainReport: TppReport;
begin

  inherited CreateSearchCriteria;

  if (Report = nil) or (Report.MainReport = nil) then Exit;

  {check whether criteria already exist}
  if (SQL.CriteriaCount > 0) then Exit;

  lMainReport := TppReport(Report.MainReport);

  {create autosearch criteria}
  lMainReport.CreateAutoSearchCriteria(DataPipeline.UserName, 'Company', soLike, 'S', False);
  lMainReport.CreateAutoSearchCriteria(DataPipeline.UserName, 'Contact', soLike, '', False);

  {update the Report.ShowAutoSearchDialog}
  lMainReport.ShowAutoSearchDialog := True;

end; {procedure, CreateSearchCriteria}




initialization

  {register the dataviews }
  daRegisterDataView(TdvCustomerQuery);

finalization

  daUnRegisterDataView(TdvCustomerQuery);


end.
