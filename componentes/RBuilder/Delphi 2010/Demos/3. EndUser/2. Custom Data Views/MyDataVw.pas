{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit myDataVw;

interface

uses
  Classes, SysUtils, Forms, ExtCtrls,  DB, DBTables,  Controls,  Dialogs,
  ppClass, ppReport, ppDB, ppDBPipe, ppDBBDE, ppClasUt, ppTypes, ppUtils, ppComm,
  daDataView, daDB, daDBBDE, daSQL, dvDesign;

type

  {TdvCustomAutoSearchDataView
     - ancestor for AutoSearch templates declared below
     - descends from BDEQueryTemplateDataView which contains a single
          TQuery, TDataSource, BDEPipeline
     - adds functionality to support AutoSearch criteria }

  TdvCustomAutoSearchDataView = class(TdaBDEQueryTemplateDataView)
    private
      FDesignRequested: Boolean;

    protected
      procedure CreateSearchCriteria; virtual;
      procedure SetReport(aReport: TppCustomReport); override;

     public
      constructor Create(aOwner: TComponent); override;

      procedure Design; override;


  end; {class, TdvCustomAutoSearchDataView}


  {TdvCustomTemplateDataView
     - ancestor for custom AskAtRuntime templates declared below
     - descends from BDEQueryTemplateDataView which contains a single
          TQuery, TDataSource, BDEPipeline
     - adds functionality to display the 'AskAtRuntime' Design dialog    }

  TdvCustomTemplateDataView = class(TdaBDEQueryTemplateDataView)
    private
      FAskAtRunTime: Boolean;
      FShowDialog: Boolean;
      FTimer: TTimer;

      procedure AfterLoadededEvent(Sender: TObject);
    protected
      procedure Loaded; override;
      procedure AfterLoaded; virtual;
      procedure RefreshQuery; override;
      procedure SetActive(aValue: Boolean); override;


    public
      constructor Create(aOwner: TComponent); override;

      procedure Design; override;

      property ShowDialog: Boolean read FShowDialog write FShowDialog;

    published
      property AskAtRunTime: boolean read FAskAtRunTime write FAskAtRunTime default False;

    end; {class, TdvCustomTemplateDataView}



  { TdvCustomerAutoSearch:
     - single query dataview with AutoSearch on company and contact fields
     - the end-user can use the built-in autosearch dialog to specify the criteria values }

  TdvCustomerAutoSearch = class(TdvCustomAutoSearchDataView)
    private

    protected
      procedure CreateSearchCriteria; override;

    public
      constructor Create(aOwner: TComponent); override;

      class function ClassDescription: String; override;

      procedure DefineSelectedFields; override;

    published

  end; {class, TdvCustomerAutoSearch}


  { TdvCustomer:
     - single query dataview with custom ask at runtime support
     - defines selected fields from a single table
     - the end-user can define search and sort criteria via the Design dialog
       displayed by the ancestor }

  TdvCustomer = class(TdvCustomTemplateDataView)
    private

    protected

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure DefineSelectedFields; override;

    published


  end; {class, TdvCustomer}


  { TdvBiolife:
     - single query with lookup table for optimized blob handling
           note: SQL queries containing BLOB fields are very slow in Paradox
                 This data view demonstrates how a query can be linked to a TTable.
                 The BLOB fields are then retrieved from the TTable
     - the end-user can define search and sort criteria via the Design dialog
       displayed by the ancestor }

  TdvBioLife = class(TdvCustomTemplateDataView)
    private
      FBlobTable: TTable;
      FBLOBDataSource: TDataSource;
      FBLOBDataPipeline: TppBDEPipeline;

    protected

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure DefineSelectedFields; override;
      procedure CreateDataPipelines; override;
      procedure CreatePipelineFields(aDataPipeline: TppDataPipeline); override;

      procedure ConnectPipelinesToData; override;

    published
      {publish DataPipelines - must be read/write}
      property BLOBDataPipeline: TppBDEPipeline read FBLOBDataPipeline write FBLOBDataPipeline;

      {publish DataSources - must be read only (i.e. do NOT declare "write FDataSource")}
      property BLOBDataSource: TDataSource read FBLOBDataSource;

  end; {class, TdvBioLife}


  { TdvOrder:
     - master/detail/detail example (customer/order/items)
     - master query with detail and lookup tables and a second detail table
     - the end-user can define search and sort criteria via the Design dialog
       displayed by the ancestor }

  TdvOrder = class(TdvCustomTemplateDataView)
    private
      FDetailTable: TTable;
      FDetailDataSource: TDataSource;
      FDetailDataPipeline: TppBDEPipeline;

      FLookupTable: TTable;
      FLookupDataSource: TDataSource;
      FLookupDataPipeline: TppBDEPipeline;

      FDetail2Table: TTable;
      FDetail2DataSource: TDataSource;
      FDetail2DataPipeline: TppBDEPipeline;

    protected

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure DefineSelectedFields; override;
      procedure CreateDataPipelines; override;
      procedure CreatePipelineFields(aDataPipeline: TppDataPipeline); override;

      procedure ConnectPipelinesToData; override;
      procedure ConnectReportToPipelines;override;
      
    published
      {publish DataPipelines - must be read/write}
      property DetailDataPipeline: TppBDEPipeline read FDetailDataPipeline write FDetailDataPipeline;
      property Detail2DataPipeline: TppBDEPipeline read FDetail2DataPipeline write FDetail2DataPipeline;
      property LookupDataPipeline: TppBDEPipeline read FLookupDataPipeline write FLookupDataPipeline;

      {publish DataSources - must be read only (i.e. do NOT declare "write FDataSource")}
      property DetailDataSource: TDataSource read FDetailDataSource;
      property Detail2DataSource: TDataSource read FDetail2DataSource;
      property LookupDataSource: TDataSource read FLookupDataSource;


  end; {class, TdvOrder}


  { TdvInvoice:
     - single query joining four tables from the database  (customer/orders/items/parts)
     - adds a calculated TField that is calculated in the OnCalcFields event of the TQuery
     - the end-user can define search and sort criteria via the Design dialog
       displayed by the ancestor }

  TdvInvoice = class(TdvCustomTemplateDataView)
    private

      procedure CalcFieldsEvent(DataSet: TDataset);

    protected

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function ClassDescription: String; override;

      procedure ConnectPipelinesToData; override;

      procedure CreatePipelineFields(aDataPipeline: TppDataPipeline); override;
      procedure DefineSelectedFields; override;

    published


  end; {class, TdvInvoice}



  {utility routines }
  procedure daCreateDefaultTFields(aDataSet: TDataSet);
  procedure daCreateLookupTField(aDataSet, aLookupDataSet: TDataSet; aKeyFields, aLookupKeyFields, aLookupResultField: String; aFieldName: String);
  procedure daCreateCalculatedTField(aDataSet: TDataSet; aFieldClass: TFieldClass; aFieldName: String);


implementation


{******************************************************************************
 *
 ** U T I L I T Y  R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ daCreateDefaultTFields}

procedure daCreateDefaultTFields(aDataSet: TDataSet);
var
  liFieldDef: Integer;
  lField: TField;

 begin

  if aDataSet = nil then Exit;

  {make sure dataset not open}
  if aDataSet.Active then
    aDataSet.Close;

  {initialize the fielddef list to reflect current state of dataset}
  aDataSet.FieldDefs.Update;

  {create a persistent TField object for each field in the dataset}
  for liFieldDef := 0 to aDataSet.FieldDefs.Count-1 do
    begin
      lField :=  aDataSet.FieldDefs[liFieldDef].CreateField(aDataSet);
      lField.DataSet := aDataSet;
    end;

end; {procedure, daCreateDefaultTFields}



{------------------------------------------------------------------------------}
{ daCreateLookupTField }

procedure daCreateLookupTField(aDataSet, aLookupDataSet: TDataSet; aKeyFields, aLookupKeyFields, aLookupResultField: String; aFieldName: String);
var
  lField: TField;
  lResultField: TField;

 begin

  if (aDataSet = nil) or (aLookupDataSet = nil) then Exit;


  {make sure dataset not open}
  if aDataSet.Active then
    aDataSet.Close;

  if (aDataSet.FieldCount = 0) then
    daCreateDefaultTFields(aDataSet);

  if not (aLookupDataSet.Active) then
    aLookupDataSet.Open;

  lResultField := aLookupDataSet.FindField(aLookupResultField);

  if (lResultField = nil) then Exit;

  lField := TFieldClass(lResultField.ClassType).Create(aDataSet);
  lField.FieldKind := fkLookup;
  lField.LookupDataSet      := aLookupDataSet;
  lField.LookupKeyFields    := aLookupKeyFields;
  lField.LookupResultField  := aLookupResultField;
  lField.KeyFields          := aKeyFields;
  lField.FieldName  := aFieldName;
  lField.DataSet    := aDataSet;

end; {procedure, daCreateLookupTField}

{------------------------------------------------------------------------------}
{ daCreateCalculatedTField }

procedure daCreateCalculatedTField(aDataSet: TDataSet; aFieldClass: TFieldClass; aFieldName: String);
var
  lField: TField;

 begin

  if aDataSet = nil then Exit;

  {make sure dataset not open}
  if aDataSet.Active then
    aDataSet.Close;

  if (aDataSet.FieldCount = 0) then
    daCreateDefaultTFields(aDataSet);

  lField := aFieldClass.Create(aDataSet);
  lField.FieldKind := fkCalculated;

  lField.FieldName  := aFieldName;
  lField.DataSet    := aDataSet;

end; {procedure, daCreateCalculatedTField}



{******************************************************************************
 *
 ** A U T O S E A R C H   D A T A V I E W 
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomAutoSearchDataView.Create }

constructor TdvCustomAutoSearchDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  {specify the available toolbar options for the dataview}
  EditOptions := [ppemSearch, ppemPreview];
  EnabledOptions := EditOptions;

  FDesignRequested := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvCustomAutoSearchDataView.CreateSearchCriteria }

procedure TdvCustomAutoSearchDataView.CreateSearchCriteria;
begin

  {note: descendants can create autosearch criteria here}


end; {procedure, CreateSearchCriteria}

{------------------------------------------------------------------------------}
{ TdvCustomAutoSearchDataView.Design }

procedure TdvCustomAutoSearchDataView.Design;
begin

  if (DataPipelineCount = 0) then
    Init;

  {when the dataview is created by end-user, the report designer will call the
  Design method is prior to connecting the dataview to the report.
  For AutoSearch, we need the report to be assigned. Therefore we need to set a flag
  here to indicate to the SetReport method that the design dialog needs to be displayed }

  if (Report = nil) then
    FDesignRequested := True

  else if (Report.MainReport <> nil) then
    TppReport(Report.MainReport).DisplayAutoSearchDialog;


end; {procedure, Design}

{------------------------------------------------------------------------------}
{ TdvCustomAutoSearchDataView.SetReport }

procedure TdvCustomAutoSearchDataView.SetReport(aReport: TppCustomReport);
begin

  inherited SetReport(aReport);

  if (aReport = nil) then Exit;

  {create the search criteria}
  CreateSearchCriteria;

  {display the design dialog, if needed}
  if FDesignRequested then
    begin
      Design;

      FDesignRequested := False;
    end;

end; {procedure, SetReport}


{******************************************************************************
 *
 ** T E M P L A T E   D A T A V I E W
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.Create }

constructor TdvCustomTemplateDataView.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  EditOptions := [ppemSearch, ppemSort, ppemPreview];
  EnabledOptions := EditOptions;

  FAskAtRunTime := True;
  FShowDialog := False;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.Loaded }

procedure TdvCustomTemplateDataView.Loaded;
begin

  inherited Loaded;

  {intialize the Query object}
  SQLChanged;

  {initialize Ask at Runtime}
  FShowDialog := FAskAtRuntime;

  FTimer := TTimer.Create(Self);
  FTimer.Interval := 100;
  FTimer.OnTimer  := AfterLoadededEvent;

end; {procedure, Loaded}

{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.AfterLoadededEvent }

procedure TdvCustomTemplateDataView.AfterLoadededEvent(Sender: TObject);
begin

  FTimer.Free;
  FTimer := nil;

  AfterLoaded;

end; {procedure, AfterLoadededEvent}

{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.AfterLoaded }

procedure TdvCustomTemplateDataView.AfterLoaded;
var
  lModified: Boolean;
begin

  if (Report <> nil) and
     (Report.ComponentDesigner <> nil) and (Report.ComponentDesigner.Visible) then
    begin
      lModified := Report.Modified;
      SetActive(True);

      if (lModified <> Report.Modified) then
        Report.Modified := lModified;

    end;

end; {procedure, AfterLoaded}

{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.SetActive }

procedure TdvCustomTemplateDataView.SetActive(aValue: Boolean);
begin

  if aValue and (DataPipelineCount = 0) then
    Init;

  if FShowDialog and aValue then
    begin
      FShowDialog := False;

      Design;
    end

  else if FAskAtRuntime and not aValue then
    FShowDialog := True;

  inherited SetActive(aValue);

end; {procedure, SetActive}

{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.Design }

procedure TdvCustomTemplateDataView.Design;
var
  lForm: TdvDesignDataDialog;
begin

  if (DataPipelineCount = 0) then
    Init;

  {show design dialog here}
  lForm := TdvDesignDataDialog.Create(Application);
  lForm.DataView := Self;
  lForm.Caption  := 'Data Selection - ' + Description;

  if (lForm.ShowModal = mrOK) then
    {add search and sort criteria to the master query}
    DefineDataSelection;

   {set FShowDialog to False to suppress the automatic ask at runtime
    behavior the next time the DataView is set to active }
  FShowDialog := False;

  lForm.Release;

end; {procedure, Design}

{------------------------------------------------------------------------------}
{ TdvCustomTemplateDataView.RefreshQuery }

procedure TdvCustomTemplateDataView.RefreshQuery;
begin
  {override ancestor and do nothing, because
   for this dataview class we are using the datapipeline fields to store
   the search expression info and therefore do not want to regenerate
   the SQL and recreate the fields}

end; {procedure, RefreshQuery}

{******************************************************************************
 *
 ** CustomerAutoSearch - single query with AutoSearch on Company and Contact
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomerAutoSearch.Create }

constructor TdvCustomerAutoSearch.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DatabaseName := 'DBDemos';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvCustomerAutoSearch.ClassDescription }

class function TdvCustomerAutoSearch.ClassDescription: String;
begin
  Result := 'Customer AutoSearch';
end; {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdvCustomerAutoSearch.DefineSelectedFields }

procedure TdvCustomerAutoSearch.DefineSelectedFields;
var
  lCustomerTable: TdaTable;

begin

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
{ TdvCustomerAutoSearch.CreateSearchCriteria }

procedure TdvCustomerAutoSearch.CreateSearchCriteria;
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



{******************************************************************************
 *
 ** CUSTOMER - single query
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvCustomer.Create }

constructor TdvCustomer.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DatabaseName := 'DBDemos';

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvCustomer.Destroy }

destructor TdvCustomer.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TdvCustomer.ClassDescription }

class function TdvCustomer.ClassDescription: String;
begin
  Result := 'Customer';
end;  {class function, ClassDescription}


{------------------------------------------------------------------------------}
{ TdvCustomer.DefineSelectedFields }

procedure TdvCustomer.DefineSelectedFields;
var
  lCustomerTable: TdaTable;

begin

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

{******************************************************************************
 *
 ** BIOLIFE - single query with lookup table for optimized BLOB handling
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvBiolife.Create }

constructor TdvBiolife.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  {always specify this first}
  DatabaseName := 'DBDemos';

  {create lookup table for blob fields and link to the query datasource}
  FBLOBTable := CreateTable('biolife.db');
  FBLOBTable.MasterSource := DataSource;
  FBLOBTable.MasterFields := 'Species No';

  {create datasource for the blob lookup table}
  FBLOBDataSource := TDataSource.Create(Self);
  FBLOBDataSource.DataSet := FBLOBTable;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvBiolife.Destroy }

destructor TdvBiolife.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TdvBioLife.ClassDescription }

class function TdvBioLife.ClassDescription: String;
begin
  Result := 'BioLife';
end;  {class function, ClassDescription}



{------------------------------------------------------------------------------}
{ TdvBioLife.DefineSelectedFields }

procedure TdvBioLife.DefineSelectedFields;
var
  lBiolifeTable: TdaTable;
  lLinkField: TdaField;

begin

  inherited DefineSelectedFields;

  lBiolifeTable := AddSelectTable('biolife.db');

  {AddSelectField parameters: TableName, FieldName, FieldAlias, Searchable, Sortable}
  AddSelectField(lBiolifeTable, 'Category',     '',                 True,  True);
  AddSelectField(lBiolifeTable, 'Common_Name',  'Common Name',      False, True);
  AddSelectField(lBiolifeTable, 'Species Name', '',                 True,  True);
  AddSelectField(lBiolifeTable, 'Length (cm)',  '',                 False, True);
  AddSelectField(lBiolifeTable, 'Length_in',    'Length (in)',      False, True);

  {need to make sure the linking field's SQLFieldName is unchanged, the default
   behavior is that the SQLFieldName will be Species_No }
  lLinkField := AddSelectField(lBiolifeTable, 'Species No',   '',                 True,  True);
  lLinkField.SQLFieldName := 'Species No';


end; {procedure, DefineSelectedFields}



{------------------------------------------------------------------------------}
{ TdvBioLife.CreateDataPipelines }

procedure TdvBioLife.CreateDataPipelines;
begin

  inherited CreateDataPipelines;

  {create the lookup pipeline
     note: call CreateDataPipeline defined in ancestor }

  FBLOBDataPipeline := CreateDataPipeline;
  FBLOBDataPipeline.UserName := 'plLookup';

end; {procedure, CreateDataPipelines}


{------------------------------------------------------------------------------}
{ TdvBiolife.CreatePipelineFields }

procedure TdvBiolife.CreatePipelineFields(aDataPipeline: TppDataPipeline);
begin

  inherited CreatePipelineFields(aDataPipeline);

  {create lookup pipeline fields }
  if aDataPipeline = FBLOBDataPipeline then
    begin
      CreatePipelineField('Biolife', 'Notes',        '',  aDataPipeline,     False, False);
      CreatePipelineField('Biolife', 'Graphic',      '',  aDataPipeline,    False, False);
    end;

end; {procedure, CreatePipelineFields}

{------------------------------------------------------------------------------}
{ TdvBiolife.ConnectPipelinesToData }

procedure TdvBiolife.ConnectPipelinesToData;
begin

  inherited ConnectPipelinesToData;

  {connect datapipeline to datasource here}
  FBLOBDataPipeline.DataSource := FBlobDataSource;

  {setting this prop will cause DataTree to draw the pipelines nested}
  FBLOBDataPipeline.MasterDataPipeline := DataPipeline;


end; {procedure, ConnectPipelinesToData}


{******************************************************************************
 *
 ** ORDER - master query with detail and lookup tables
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvOrder.Create }

constructor TdvOrder.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DatabaseName := 'DBDemos';

  FDetailTable := CreateTable('orders.db');

  {link the detail table to the master}
  FDetailTable.IndexName := 'CustNo';
  FDetailTable.MasterFields := 'CustNo';
  FDetailTable.MasterSource := DataSource;

  FDetailDataSource := CreateDataSource;
  FDetailDataSource.DataSet := FDetailTable;

  FLookupTable := CreateTable('employee.db');
  FLookupTable.IndexFieldNames := 'EmpNo';

  {create a second detail table: master/detail/detail (customers/orders/items}
  FDetail2Table := CreateTable('items.db');

  {link the 2nd detail to 1st detail}
  FDetail2Table.IndexName := 'ByOrderNo';
  FDetail2Table.MasterFields := 'OrderNo';
  FDetail2Table.MasterSource := FDetailDataSource;

  FDetail2DataSource := CreateDataSource;
  FDetail2DataSource.DataSet := FDetail2Table;

  {create lookup fields: MasterDataSet, LookupDataSet, KeyFields, LookupKeyFields, LookupResultField, FieldName}
  daCreateDefaultTFields(FDetailTable);

  daCreateLookupTField(FDetailTable, FLookupTable, 'EmpNo', 'EmpNo', 'FirstName', 'EmployeeFirstName');
  daCreateLookupTField(FDetailTable, FLookupTable, 'EmpNo', 'EmpNo', 'LastName', 'EmployeeLastName');


end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvOrder.Destroy }

destructor TdvOrder.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TdvOrder.ClassDescription }

class function TdvOrder.ClassDescription: String;
begin
  Result := 'Order';
end;  {class function, ClassDescription}



{------------------------------------------------------------------------------}
{ TdvOrder.DefineSelectedFields }

procedure TdvOrder.DefineSelectedFields;
var
  lCustomerTable: TdaTable;

begin

  inherited DefineSelectedFields;

  lCustomerTable := AddSelectTable('customer.db');

  {AddSelectField parameters: TableName, FieldName, FieldAlias, Searchable, Sortable}
  AddSelectField(lCustomerTable, 'Company',         'Company',        True,  True);
  AddSelectField(lCustomerTable, 'Contact',         'Contact Name',   True,  True);
  AddSelectField(lCustomerTable, 'CustNo',          'No',             False, True);
  AddSelectField(lCustomerTable, 'Addr1',           'Address Line 1', False, True);
  AddSelectField(lCustomerTable, 'Addr2',           'Address Line 2', False, True);
  AddSelectField(lCustomerTable, 'City',            'City',           True,  True);
  AddSelectField(lCustomerTable, 'State',           'State',          False, True);
  AddSelectField(lCustomerTable, 'Zip',             'Zip Code',       False, True);
  AddSelectField(lCustomerTable, 'Country',         'Country',        False, True);
  AddSelectField(lCustomerTable, 'Fax',             'Fax No',         False, True);
  AddSelectField(lCustomerTable, 'Phone',           'Phone No',       False, True);
  AddSelectField(lCustomerTable, 'LastInvoiceDate', 'Last Invoice Date', False, True);
  AddSelectField(lCustomerTable, 'TaxRate',         'Tax Rate',       False, True);


end; {procedure, DefineSelectedFields}



{------------------------------------------------------------------------------}
{ TdvOrder.CreateDataPipelines }

procedure TdvOrder.CreateDataPipelines;
begin

  inherited CreateDataPipelines;

  DataPipeline.UserName := 'plCustomer';

  {create the lookup pipeline
     note: call CreateDataPipeline defined in ancestor }
  FDetailDataPipeline := CreateDataPipeline;
  FDetailDataPipeline.UserName := 'plOrders';

  FDetail2DataPipeline := CreateDataPipeline;


  FDetail2DataPipeline.UserName := 'plItems';

end; {procedure, CreateDataPipelines}


{------------------------------------------------------------------------------}
{ TdvOrder.CreatePipelineFields }

procedure TdvOrder.CreatePipelineFields(aDataPipeline: TppDataPipeline);
begin

  inherited CreatePipelineFields(aDataPipeline);

  {create detail pipeline fields}
   if aDataPipeline = FDetailDataPipeline then
    begin

      CreatePipelineField('Orders', 'AmountPaid',      'Amount Paid',         aDataPipeline, False, False);
      CreatePipelineField('Orders', 'Freight',         'Freight',             aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ItemsTotal',      'Items Total',         aDataPipeline, False, False);
      CreatePipelineField('Orders', 'OrderNo',         'Order No',            aDataPipeline, False, False);
      CreatePipelineField('Orders', 'PaymentMethod',   'Payment Method',      aDataPipeline, False, False);
      CreatePipelineField('Orders', 'PO',              'PO',                  aDataPipeline, False, False);
      CreatePipelineField('Orders', 'SaleDate',        'Sale Date',           aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipDate',        'Ship Date',           aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipVia',         'Ship Via',            aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToAddr1',     'Ship To: Address 1',  aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToAddr2',     'Ship To: Address 2',  aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToCity',      'Ship To: City',       aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToState',     'Ship To: State',      aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToZip',       'Ship To: Zip',        aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToCountry',   'Ship To: Country',    aDataPipeline, False, False);
      CreatePipelineField('Orders', 'ShipToContact',   'Ship To: Contact',    aDataPipeline, False, False);

      CreatePipelineField('Orders', 'EmpNo',              'Sold By: Employee No',    aDataPipeline, False, False);
      CreatePipelineField('Orders', 'EmployeeFirstName',  'Sold By: First Name',    aDataPipeline, False, False);
      CreatePipelineField('Orders', 'EmployeeLastName',   'Sold By: Last Name',    aDataPipeline, False, False);

    end
   else if aDataPipeline = FDetail2DataPipeline then
    begin

      CreatePipelineField('Items', 'ItemNo',         'Item No',     aDataPipeline, False, False);
      CreatePipelineField('Items', 'PartNo',         'Part No',     aDataPipeline, False, False);
      CreatePipelineField('Items', 'Qty',            'Quantity',    aDataPipeline, False, False);
      CreatePipelineField('Items', 'Discount',       'Discount',    aDataPipeline, False, False);

    end;


end; {procedure, CreatePipelineFields}

{------------------------------------------------------------------------------}
{ TdvOrder.ConnectPipelinesToData }

procedure TdvOrder.ConnectPipelinesToData;
begin

  inherited ConnectPipelinesToData;

  {connect datapipeline to datasource here}
  FDetailDataPipeline.DataSource  := FDetailDataSource;
  FDetail2DataPipeline.DataSource := FDetail2DataSource;

  {setting this prop will cause DataTree to draw the pipelines nested}
  FDetailDataPipeline.MasterDataPipeline  := DataPipeline;
  FDetail2DataPipeline.MasterDataPipeline := FDetailDataPipeline;


end; {procedure, ConnectPipelinesToData}

{------------------------------------------------------------------------------}
{ TdvOrder.ConnectReportToPipelines }

procedure TdvOrder.ConnectReportToPipelines;
begin

  {descendants should add code here to set the initial datapipeline for the report.
  the end-user can modify this and save the results}
  Report.DataPipeline := DataPipeline;

end; {procedure, ConnectReportToPipelines}


{******************************************************************************
 *
 ** INVOICE - single query with calculated field support
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdvInvoice.Create }

constructor TdvInvoice.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  DatabaseName := 'DBDemos';

  {assign even-handler to OnCalcFields event }
  Query.OnCalcFields := CalcFieldsEvent;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdvInvoice.Destroy }

destructor TdvInvoice.Destroy;
begin

  inherited Destroy;

end; {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TdvInvoice.ClassDescription }

class function TdvInvoice.ClassDescription: String;
begin
  Result := 'Invoice';
end;  {class function, ClassDescription}

{------------------------------------------------------------------------------}
{ TdvInvoice.DefineSelectedFields }

procedure TdvInvoice.DefineSelectedFields;
var
  lCustomerTable: TdaTable;
  lOrderTable: TdaTable;
  lItemTable: TdaTable;
  lPartTable: TdaTable;

begin

  inherited DefineSelectedFields;

  {add tables for the SQL select 'From' clause}
  lCustomerTable := AddSelectTable('customer.db');
  lOrderTable    := AddSelectTable('orders.db');
  lItemTable     := AddSelectTable('items.db');
  lPartTable     := AddSelectTable('parts.db');

  {add table join definitions}
  lOrderTable.AddTableJoin(lCustomerTable, 'CustNo',  'CustNo',  dajoEqual);
  lItemTable.AddTableJoin(lOrderTable,     'OrderNo', 'OrderNo', dajoEqual);
  lPartTable.AddTableJoin(lItemTable,      'PartNo',  'PartNo',  dajoEqual);


  {AddSelectField parameters: TableName, FieldName, FieldAlias, Searchable, Sortable}

  {customer fields}
  AddSelectField(lCustomerTable, 'Company',         'Company',        True,  True);
  AddSelectField(lCustomerTable, 'Contact',         'Contact Name',   True,  True);
  AddSelectField(lCustomerTable, 'CustNo',          'No',             False, True);
  AddSelectField(lCustomerTable, 'Addr1',           'Address Line 1', False, True);
  AddSelectField(lCustomerTable, 'Addr2',           'Address Line 2', False, True);
  AddSelectField(lCustomerTable, 'City',            'City',           True,  True);
  AddSelectField(lCustomerTable, 'State',           'State',          False, True);
  AddSelectField(lCustomerTable, 'Zip',             'Zip Code',       False, True);
  AddSelectField(lCustomerTable, 'Country',         'Country',        False, True);
  AddSelectField(lCustomerTable, 'Fax',             'Fax No',         False, True);
  AddSelectField(lCustomerTable, 'Phone',           'Phone No',       False, True);
  AddSelectField(lCustomerTable, 'LastInvoiceDate', 'Last Invoice Date', False, True);
  AddSelectField(lCustomerTable, 'TaxRate',         'Tax Rate',       False, True);


  {order fields}
  AddSelectField(lOrderTable, 'AmountPaid',      'Amount Paid',          False, False);
  AddSelectField(lOrderTable, 'EmpNo',           'Employee No.',         False, False);
  AddSelectField(lOrderTable, 'Freight',         '',                     False, False);
  AddSelectField(lOrderTable, 'ItemsTotal',      'Items Total',          False, False);
  AddSelectField(lOrderTable, 'OrderNo',         'Order No.',            False, False);
  AddSelectField(lOrderTable, 'PaymentMethod',   'Payment Method',       False, False);
  AddSelectField(lOrderTable, 'PO',              '',                     False, False);
  AddSelectField(lOrderTable, 'SaleDate',        'Sale Date',            False, False);
  AddSelectField(lOrderTable, 'ShipDate',        'Ship Date',            False, False);
  AddSelectField(lOrderTable, 'ShipToAddr1',     'Ship To: Address 1',   False, False);
  AddSelectField(lOrderTable, 'ShipToAddr2',     'Ship To: Address 2',   False, False);
  AddSelectField(lOrderTable, 'ShipToCity',      'Ship To: City',        False, False);
  AddSelectField(lOrderTable, 'ShipToState',     'Ship To: State',       False, False);
  AddSelectField(lOrderTable, 'ShipToZip',       'Ship To: Zip',         False, False);
  AddSelectField(lOrderTable, 'ShipToCountry',   'Ship To: Country',     False, False);
  AddSelectField(lOrderTable, 'ShipToContact',   'Ship To: Contact',     False, False);

  {item fields}
  AddSelectField(lItemTable, 'Discount',        '',                      False, False);
  AddSelectField(lItemTable, 'ItemNo',          'Item No.',              False, False);
  AddSelectField(lItemTable, 'Qty',             'Quantity',              False, False);
  AddSelectField(lItemTable, 'PartNo',          'Part No.',              False, False);

  {part fields}
  AddSelectField(lPartTable, 'Cost',            '',                      False, False);
  AddSelectField(lPartTable, 'Description',     '',                      False, False);
  AddSelectField(lPartTable, 'ListPrice',       'List Price',            False, False);
  AddSelectField(lPartTable, 'OnHand',          'On Hand',               False, False);
  AddSelectField(lPartTable, 'OnOrder',         'On Order',              False, False);
  AddSelectField(lPartTable, 'VendorNo',        'Vendor No.',            False, False);


  {add calculated field}
  BuildSQL;
  daCreateCalculatedTField(Query, TCurrencyField, 'ItemTotal');


end; {procedure, DefineSelectedFields}

{------------------------------------------------------------------------------}
{ TdvInvoice.CreatePipelineFields }

procedure TdvInvoice.CreatePipelineFields(aDataPipeline: TppDataPipeline);
begin

  inherited CreatePipelineFields(aDataPipeline);

  {add the calculated field to the pipeline}
   if aDataPipeline = DataPipeline then
    begin
      CreatePipelineField('Items', 'ItemTotal', 'Item Total', aDataPipeline, False, False);
    end;

end; {procedure, CreatePipelineFields}

{------------------------------------------------------------------------------}
{ TdvInvoice.ConnectPipelinesToData }

procedure TdvInvoice.ConnectPipelinesToData;
begin

  inherited ConnectPipelinesToData;

  {add calculated field}
  if Query.SQL.Text <> '' then

    if (Query.FindField('ItemTotal') = nil) then
      daCreateCalculatedTField(Query, TCurrencyField, 'ItemTotal');

end; {procedure, ConnectPipelinesToData}


{------------------------------------------------------------------------------}
{ TdvInvoice.CalcFieldsEvent }

procedure TdvInvoice.CalcFieldsEvent(DataSet: TDataset);
begin
  Query.FieldByName('ItemTotal').AsFloat := Query.FieldByName('Qty').AsFloat * Query.FieldByName('ListPrice').AsFloat;

end; {procedure, CalcFieldsEvent}


initialization

  {register the dataviews }
  daRegisterDataView(TdvCustomerAutoSearch);
  daRegisterDataView(TdvCustomer);
  daRegisterDataView(TdvBioLife);
  daRegisterDataView(TdvOrder);
  daRegisterDataView(TdvInvoice);

finalization

  daUnRegisterDataView(TdvCustomerAutoSearch);
  daUnRegisterDataView(TdvCustomer);
  daUnRegisterDataView(TdvBioLife);
  daUnRegisterDataView(TdvOrder);
  daUnRegisterDataView(TdvInvoice);


end.
