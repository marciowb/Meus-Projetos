{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0139;

interface

{$IFDEF VER150}
  {$DEFINE Delphi7}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE Delphi6}
{$ENDIF}

uses
  Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppBands, ppClass, ppProd, ppReport, StdCtrls, ppDB, ppComm, ppCache,
  ppTxPipe, ppCtrls, ppPrnabl, ExtCtrls, Grids, ppDBJIT,
  dmUtil, ppVar, ppTypes, ppRelatv, ppStrtch, ppSubRpt;

type
  Tfrm0139 = class(TdmCustomForm)
    TxtPipeCustomer: TppTextPipeline;
    ppField26: TppField;
    ppField25: TppField;
    ppField24: TppField;
    ppField23: TppField;
    ppField22: TppField;
    ppField21: TppField;
    ppField20: TppField;
    ppField19: TppField;
    ppField18: TppField;
    ppField17: TppField;
    ppField2: TppField;
    ppField1: TppField;
    ppField13: TppField;
    TxtPipeOrder: TppTextPipeline;
    ppField47: TppField;
    ppField46: TppField;
    ppField45: TppField;
    ppField44: TppField;
    ppField43: TppField;
    ppField42: TppField;
    ppField41: TppField;
    ppField40: TppField;
    ppField39: TppField;
    ppField38: TppField;
    ppField37: TppField;
    ppField36: TppField;
    ppField35: TppField;
    ppReport1: TppReport;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    gridMaster: TStringGrid;
    GridDetail: TStringGrid;
    JITMaster: TppJITPipeline;
    JITDetail: TppJITPipeline;
    ppField3: TppField;
    ppField4: TppField;
    Contact: TppField;
    Address1: TppField;
    Address2: TppField;
    ppField8: TppField;
    ppField9: TppField;
    ppField10: TppField;
    ppField5: TppField;
    ppField6: TppField;
    ppField7: TppField;
    ppField11: TppField;
    ppField12: TppField;
    ppField14: TppField;
    ppField15: TppField;
    ppField16: TppField;
    ppField27: TppField;
    ppField28: TppField;
    ppField29: TppField;
    ppField30: TppField;
    ppField31: TppField;
    ppField32: TppField;
    ppField33: TppField;
    ppField34: TppField;
    ppField48: TppField;
    ppField49: TppField;
    Shape1: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ppOrderListHeaderBand1: TppHeaderBand;
    ppOrderListLabel1: TppLabel;
    ppOrderListLabel2: TppLabel;
    ppOrderListShape1: TppShape;
    ppOrderListLabel3: TppLabel;
    ppOrderListLabel4: TppLabel;
    ppOrderListDBText1: TppDBText;
    ppOrderListDBText2: TppDBText;
    ppOrderListDetailBand1: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppOrderListDBText3: TppDBText;
    ppOrderListDBText4: TppDBText;
    ppOrderListDBText5: TppDBText;
    ppOrderListDBText6: TppDBText;
    ppOrderListDBText7: TppDBText;
    ppOrderListDBText8: TppDBText;
    ppOrderListLine2: TppLine;
    ppOrderListLine1: TppLine;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppOrderListShape2: TppShape;
    ppOrderListLabel5: TppLabel;
    ppOrderListLabel6: TppLabel;
    ppOrderListShape3: TppShape;
    ppOrderListShape4: TppShape;
    ppOrderListLabel7: TppLabel;
    ppOrderListLabel8: TppLabel;
    ppOrderListLabel9: TppLabel;
    ppOrderListLabel10: TppLabel;
    ppOrderListShape5: TppShape;
    ppOrderListLabel11: TppLabel;
    ppOrderListLabel12: TppLabel;
    ppOrderListLabel13: TppLabel;
    ppOrderListLabel15: TppLabel;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppOrderListLine4: TppLine;
    ppOrderListLine3: TppLine;
    ppOrderListDBText9: TppDBText;
    ppOrderListLabel14: TppLabel;
    ppOrderListDBCalc1: TppDBCalc;
    ppOrderListFooterBand1: TppFooterBand;
    ppOrderListCalc1: TppSystemVariable;
    ppOrderListCalc2: TppSystemVariable;
    ppOrderListCalc3: TppSystemVariable;
    ppDBText1: TppDBText;
    procedure FormCreate(Sender: TObject);
    function JITMasterGetFieldValue(aFieldName: String): Variant;
    function JITDetailGetFieldValue(aFieldName: String): Variant;

  private

  protected
    function GetReport: TppProducer; override;

  public

  end;

  {utility routines}
  procedure PipeDataToGrid(aPipeline: TppDataPipeline; aGrid: TStringGrid);
  function GetGridFieldValue(aGrid: TStringGrid; aRowIndex: Integer; const aFieldName: String; aDataType: TppDataType): Variant;


var
  frm0139: Tfrm0139;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{Tfrm0139.FormCreate}

procedure Tfrm0139.FormCreate(Sender: TObject);
var
  lsCurrentDir: String;

begin

  lsCurrentDir := ExtractFilePath(ParamStr(0));

  {note: as a convenience, use text pipelines to load data to grids}
  TxtPipeCustomer.FileName := lsCurrentDir + 'customer.txt';
  TxtPipeOrder.FileName    := lsCurrentDir + 'order.txt';

  PipeDataToGrid(TxtPipeCustomer, GridMaster);
  PipeDataToGrid(TxtPipeOrder, GridDetail);

  {intitialize index and count for master and detail data}
  JITMaster.InitialIndex := 1;
  JITDetail.InitialIndex := 1;

  JITMaster.RecordCount := GridMaster.RowCount-1;
  JITDetail.RecordCount := GridDetail.RowCount-1;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{Tfrm0139.GetReport }

function Tfrm0139.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

{------------------------------------------------------------------------------}
{Tfrm0139.JITMasterGetFieldValue }

function Tfrm0139.JITMasterGetFieldValue(aFieldName: String): Variant;
begin
  Result := GetGridFieldValue(gridMaster, JITMaster.RecordIndex, aFieldName, JITMaster.GetFieldDataType(aFieldName));

end; {procedure, JITMasterGetFieldValue}


{------------------------------------------------------------------------------}
{Tfrm0139.JITDetailGetFieldValue }

function Tfrm0139.JITDetailGetFieldValue(aFieldName: String): Variant;
begin
  Result := GetGridFieldValue(gridDetail, JITDetail.RecordIndex, aFieldName, JITDetail.GetFieldDataType(aFieldName));

end; {procedure, JITDetailGetFieldValue}


{******************************************************************************
*
*  U T I L I T Y   R O U T I N E S
*
*******************************************************************************}

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






end.
