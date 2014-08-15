{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbFrmJIT;

interface
  
{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6} Variants,{$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppDB, ppComm, ppRelatv, ppTxPipe, ppVar, ppBands, ppCtrls, ppPrnabl,
  ppClass, ppCache, ppProd, ppReport, StdCtrls, Grids, ppDBJIT, ppTypes, rbClass;

type

  {Note: This form is setup to run as part of the main tutorial project.
         It descends from TrbReportForm which is defined in rbClass.pas.

         You will need to add rbClass.pas to any project that uses this form.
         The rbClass.pas unit is part of the main tutorial project. }



  TfrmPrintFromStringGrid = class(TrbReportForm)
    plCustomerTxt: TppTextPipeline;
    plCustomerppField1: TppField;
    plCustomerppField2: TppField;
    plCustomerppField3: TppField;
    plCustomerppField4: TppField;
    plCustomerppField5: TppField;
    plCustomerppField6: TppField;
    plCustomerppField7: TppField;
    plCustomerppField8: TppField;
    rbCustomerList: TppReport;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel9: TppLabel;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppFooterBand1: TppFooterBand;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    btnPreview: TButton;
    grCustomer: TStringGrid;
    plCustomer: TppJITPipeline;
    plCustomerppField9: TppField;
    plCustomerppField10: TppField;
    plCustomerppField11: TppField;
    plCustomerppField12: TppField;
    plCustomerppField13: TppField;
    plCustomerppField14: TppField;
    plCustomerppField15: TppField;
    plCustomerppField16: TppField;
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    function plCustomerGetFieldValue(aFieldName: String): Variant;
  private
    { Private declarations }
  protected
    function GetReport: TppReport; override;
  public
    { Public declarations }
  end;

  {utility routines}
  procedure PipeDataToGrid(aPipeline: TppDataPipeline; aGrid: TStringGrid);
  function GetGridFieldValue(aGrid: TStringGrid; aRowIndex: Integer; const aFieldName: String; aDataType: TppDataType): Variant;

var
  frmPrintFromStringGrid: TfrmPrintFromStringGrid;

implementation

{$R *.DFM}

{******************************************************************************}
{*
{* U T I L I T Y   F U N C T I O N S
{*
{******************************************************************************}

{------------------------------------------------------------------------------}
{PipeDataToGrid}

procedure PipeDataToGrid(aPipeline: TppDataPipeline; aGrid: TStringGrid);
var
  liRow: Integer;
  liRecordCount: Integer;
  liField: Integer;

begin

  if not aPipeline.Active then
    aPipeline.Open;

  liRecordCount := 0;
  aPipeline.First;

  {calc number of records in the pipe}
  while not aPipeline.EOF do
    begin
      Inc(liRecordCount);
      aPipeline.Next;

    end;

  {set row and column size for the string grid}
  aGrid.RowCount := liRecordCount+1;
  aGrid.ColCount := aPipeline.FieldCount+1;

  {load field names into the title row}
  for liField := 0 to aPipeline.FieldCount-1 do
    aGrid.Cells[liField+1, 0] := aPipeline.Fields[liField].FieldName;


  liRow := 1;
  aPipeline.First;

  {load the grid with data from the pipeline}
  while not aPipeline.EOF do
    begin

      for liField := 0 to aPipeline.FieldCount-1 do
        aGrid.Cells[liField+1, liRow] := aPipeline.Fields[liField].AsString;

      aGrid.Objects[0, liRow] := TObject(aPipeline.GetBookMark);

      aPipeline.Next;

      Inc(liRow);


    end;


end; {procedure, PipeDataToGrid}

{------------------------------------------------------------------------------}
{GetGridFieldValue }

function GetGridFieldValue(aGrid: TStringGrid; aRowIndex: Integer; const aFieldName: String; aDataType: TppDataType): Variant;
var
  liFieldIndex: Integer;
  lFieldList: TStrings;
  lsResult: String;
  lcSeparator: Char;

begin
  {default Value}
  Result := Null;

  {check range}
  if (aRowIndex < 0) or (aRowIndex > aGrid.RowCount) then Exit;

  {the field list is stored in row[0] of the grid}
  lFieldList   := aGrid.Rows[0];

  {find the column index of the field}
  liFieldIndex := lFieldList.IndexOf(aFieldName);

  {get the data from the grid cell}
  lsResult := aGrid.Cells[liFieldIndex, aRowIndex];

  {convert to proper datatype}
  try

    case aDataType of

      dtInteger, dtLongint:
        Result := StrToInt(lsResult);

      dtDouble:
        begin

          {note:  The Orders ascii text file contains data with US formatted numeric data.
                  Therefore need to override DecimalSeparator to enable
                  this demo to run for international settings }
          lcSeparator := DecimalSeparator;

          try
             DecimalSeparator := '.';

            if lsResult = '' then
              Result := 0.0
            else
              Result := StrToFloat(lsResult);
          finally
            {restore international settings}
            DecimalSeparator := lcSeparator;
          end;

        end;

      else
        Result := lsResult;

    end; {case, datatype}

  except
    Result := '';

  end;


end; {function, GetGridFieldValue}


{******************************************************************************}
{*
{* F O R M   E V E N T   H A N D L E R S
{*
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TfrmPrintFromStringGrid.GetReport }

function TfrmPrintFromStringGrid.GetReport: TppReport;
begin
  Result := rbCustomerList;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TfrmPrintFromStringGrid.FormCreate }

procedure TfrmPrintFromStringGrid.FormCreate(Sender: TObject);
begin
  plCustomerTxt.FileName := ExtractFilePath(paramStr(0)) + 'Customer.txt';

  PipeDataToGrid(plCustomerTxt, grCustomer);

  plCustomer.InitialIndex := 1;
  plCustomer.RecordCount  := grCustomer.RowCount-1;

end;

{------------------------------------------------------------------------------}
{ TfrmPrintFromStringGrid.btnPreviewClick }

procedure TfrmPrintFromStringGrid.btnPreviewClick(Sender: TObject);
begin
  rbCustomerList.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmPrintFromStringGrid.plCustomerGetFieldValue }

function TfrmPrintFromStringGrid.plCustomerGetFieldValue(aFieldName: String): Variant;
begin
  Result := GetGridFieldValue(grCustomer, plCustomer.REcordIndex, aFieldName, plCustomer.GetFieldDataType(aFieldName));
end;

end.
