{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppCTEng;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  TypInfo,
  ExtCtrls,

  ppComm,
  ppRelatv,
  ppClass,
  ppStrtch,
  ppDevice,
  ppDB,
  ppTypes,
  ppUtils,
  ppCTCell,
  ppCTMain,
  ppDrwCmd,
  ppPrintr;

type

  {@TppCrossTabEngine }
  TppCrossTabEngine = class(TObject)
    private
      FAllDataTraversed: Boolean;
      FCrossTab: TppCrossTab;
      FDataPipeline: TppDataPipeline;
      FDataPipelineState: TppDataPipelineStates;
      FElementList: TList;
      FFirstRecord: Boolean;
      FMatrix: TppMatrix;
      FPipelineBookmark: Longint;
      FPipelineTraversalCount: Integer;
      FPipelineRecordNo: Integer;
      FRecordCount: Integer;
      FStatus: String;
      FValueCoords: TList;

      procedure AddFieldLabels;
      procedure BuildElementList;
      procedure CalcValue(aValueDef: TppValueDef);
      procedure CalcValues(aColumn, aRow: Integer);
      function  FindColumnValue(aColumn, aColumnDef: Integer; var aColumnFound: Boolean): Integer;
      function  FindRowValue(aRow, aRowDef: Integer; var aRowFound: Boolean): Integer;
      function  FindGrandTotalColumn: Integer;
      function  FindGrandTotalRow(aValueDef: Integer): Integer;
      function  FindSubTotalColumn(aColumn, aRow, aColumnDef: Integer): Integer;
      function  FindSubTotalRow(aColumn, aRow, aRowDef, aValueDef: Integer): Integer;
      procedure FreeValueCoords;
      function  GetElement(aIndex: Integer): TppElement;
      function  GetValue(aValue: Variant): Variant;
      function  GetLastDataColumn: Integer;
      function  GetLastDataRow: Integer;
      procedure GotoNextRecord;
      procedure InitCalcGrid;
      procedure InitDataPipelines;
      function  InsertColumn(aColumn, aColumnDef: Integer): Integer;
      function  InsertRow(aRow, aRowDef: Integer): Integer;
      procedure InsertSubTotalColumns(aColumn, aColumnDef: Integer);
      procedure InsertSubTotalRows(aRow, aRowDef: Integer);
      procedure RestoreDataPipelines;
      procedure SetStatus(const aStatus: String);
      function  SkipRecord: Boolean;
      function  SkipSubTotalColumns(var aColumn: Integer; aColumnDef: Integer; aParentLabel: Variant): Boolean;
      function  SkipSubTotalRows(var aRow: Integer; aRowDef: Integer; aParentLabel: Variant): Boolean;
      procedure UpdateColumnHeaders(aColumn: Integer);
      procedure UpdateElementIndexOfColumn(aColumn: Integer);
      procedure UpdateElementIndexOfRow(aRow: Integer);
      procedure UpdateElementIndexOfSubTotalColumn(aColumn, aColumnDef: Integer);
      procedure UpdateElementIndexOfSubTotalRow(aRow, aRowDef, aValueDef: Integer);
      procedure UpdateRowHeaders(aRow: Integer);
      function  ValidateFields: Boolean;
      procedure ValueDefToSubTotalRow(aRow, aRowDef, aValueDef: Integer);
      function RowParentLabelMatch(aRowDef, aColumn, aRow: Integer): Boolean;
      function RowParentLabelsMatch(aRowDef, aColumn, aRow: Integer): Boolean;
      function ColumnParentLabelMatch(aColumnDef, aColumn, aRow: Integer): Boolean;
      function ColumnParentLabelsMatch(aColumnDef, aColumn, aRow: Integer): Boolean;
      function CompareDimensionValues(aDimension: TppDimension; aValue1, aValue2: Variant): Integer;

    public
      constructor Create(aCrossTab: TppCrossTab);
      destructor Destroy; override;

      procedure Calc;
      procedure Clear;

      property Elements[aIndex: Integer]: TppElement read GetElement;
      property Matrix: TppMatrix read FMatrix;
      property Status: String read FStatus;

  end; {class, TppCrossTabEngine}


implementation


{******************************************************************************
 *
 ** C R O S S T A B   E N G I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.Create }

constructor TppCrossTabEngine.Create(aCrossTab: TppCrossTab);
begin

  inherited Create;

  FCrossTab := aCrossTab;

  FAllDataTraversed := False;
  FElementList := TList.Create;
  FFirstRecord := False;
  FMatrix := nil;
  FRecordCount := 1;
  FValueCoords := TList.Create;

  FStatus := ppLoadStr(69); {'Calculating Crosstab: Record <count>.'}
  FStatus := ppSetMessageParameters(FStatus);
  FStatus := Format(FStatus, [IntToStr(1)]);

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.Destroy }

destructor TppCrossTabEngine.Destroy;
begin

  FreeValueCoords;
  
  FElementList.Free;
  FValueCoords.Free;
  FMatrix.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.Clear }

procedure TppCrossTabEngine.Clear;
begin

  FreeValueCoords;

  FElementList.Clear;

  FMatrix.Free;

  FMatrix := nil;

  FRecordCount := 1;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.SetStatus }

procedure TppCrossTabEngine.SetStatus(const aStatus: String);
begin
  FStatus := aStatus;

  FCrossTab.ProcessMessages;
   
end; {procedure, SetStatus}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.Calc }

procedure TppCrossTabEngine.Calc;
var
  liColumn: Integer;
  liColumnDef: Integer;
  liRow: Integer;
  liRowDef: Integer;
  lbFound: Boolean;
begin

  FCrossTab.DoBeforeCalc;

  InitDataPipelines;

  Clear;

  if FAllDataTraversed then Exit;

  InitCalcGrid;

  while not(FAllDataTraversed) do
    begin

      {locate column of anchor value cell, add new column labels}
      liColumn := FMatrix.RowHeaderCount;
      liColumnDef := 0;
      lbFound := True;

      while (lbFound) and (liColumnDef < FCrossTab.ColumnDefCount) do
        begin
          liColumn := FindColumnValue(liColumn, liColumnDef, lbFound);

          if (lbFound) then
            Inc(liColumnDef);
        end;

      {add any new column entries required}
      if not(lbFound) then
        liColumn := InsertColumn(liColumn, liColumnDef);

      {locate row of anchor value cell, add new row labels}
      liRow := FCrossTab.ColumnDefCount;
      liRowDef := 0;
      lbFound := True;

      while (lbFound) and (liRowDef < FCrossTab.RowDefCount) do
        begin
          liRow := FindRowValue(liRow, liRowDef, lbFound);

          if (lbFound) then
            Inc(liRowDef);
        end;

      {add any new row entries required}
      if not(lbFound) then
        liRow := InsertRow(liRow, liRowDef);

      {calc value cells based on field values}
      CalcValues(liColumn, liRow);

      GotoNextRecord;
    end;

  FreeValueCoords;

  AddFieldLabels;

  RestoreDataPipelines;

  FCrossTab.DoAfterCalc;

end; {procedure, Calc}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FindColumnValue }

function TppCrossTabEngine.FindColumnValue(aColumn, aColumnDef: Integer; var aColumnFound: Boolean): Integer;
var
  liColumn: Integer;
  liRow: Integer;
  lParentLabel: Variant;
  lLabel: Variant;
  lCurrentLabel: Variant;
  liLastDataColumn: Integer;
  liCompare: Integer;
begin

  Result := -1;
  aColumnFound := False;

  if (aColumnDef = 0) then
    lParentLabel := ''
  else
    lParentLabel := GetValue(FCrossTab.ColumnDefs[aColumnDef - 1].GetValue);

  liLastDataColumn := GetLastDataColumn;

  lLabel := GetValue(FCrossTab.ColumnDefs[aColumnDef].GetValue);

  liColumn := aColumn;
  liRow := aColumnDef;

  while (Result = -1) and (liColumn < liLastDataColumn) do
    begin

      {get current label}
      lCurrentLabel := GetValue(FMatrix.Value[liColumn, liRow]);

      if not(ColumnParentLabelsMatch(aColumnDef, liColumn, liRow)) then
        Result := liColumn

      {if empty value found, set column headers, insert subtotal columns and return column}
      else if (FMatrix.IsEmpty[liColumn, liRow]) then
        begin
          aColumnFound := True;

          UpdateColumnHeaders(liColumn);

          InsertSubTotalColumns(liColumn, aColumnDef);

          Result := liColumn;
        end
      else
        begin
          // compare the dimensionvalues
          liCompare := CompareDimensionValues(FCrossTab.ColumnDefs[aColumnDef], lCurrentLabel, lLabel);

          if liCompare = 0 then
            aColumnFound := True;  // found a match

          if liCompare >= 0 then
             Result := liColumn // return this column index
          else
            Inc(liColumn); // keep looking

        end;

      {skip subtotal columns}
      if (Result = -1) and SkipSubTotalColumns(liColumn, aColumnDef, lParentLabel) then
        Result := liColumn;

      {if this is the last data column, return column}
      if (Result = -1) and (liColumn >= liLastDataColumn) then
        Result := liLastDataColumn;

    end;

end; {function, FindColumnValue}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.ColumnParentLabelsMatch }

function TppCrossTabEngine.ColumnParentLabelsMatch(aColumnDef, aColumn, aRow: Integer): Boolean;
begin

  Result := True;

  while Result and (aRow > 0) do
    begin
      Result := ColumnParentLabelMatch(aColumnDef, aColumn, aRow);

      Dec(aRow);
      Dec(aColumnDef);
    end;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.ColumnParentLabelMatch }

function TppCrossTabEngine.ColumnParentLabelMatch(aColumnDef, aColumn, aRow: Integer): Boolean;
var
  lParentLabel: Variant;
  lCurrentParentLabel: Variant;
begin

  Result := True;

  if (aColumnDef > 0) then
    begin
      {get value from data pipeline}
      lParentLabel := GetValue(FCrossTab.ColumnDefs[aColumnDef - 1].GetValue);

      {get value from the matrix}
      lCurrentParentLabel := GetValue(FMatrix.Value[aColumn, aRow-1]);

      {if parent has changed, return row}
      if (ppAnsiCompareVariant(lCurrentParentLabel, lParentLabel) <> 0) then
        Result := False;

   end;

end;



{------------------------------------------------------------------------------}
{ TppCrossTabEngine.GetLastDataColumn }

function TppCrossTabEngine.GetLastDataColumn: Integer;
begin

  Result := FMatrix.ColumnCount;

  if (FCrossTab.ColumnDefCount = 0) then Exit;

   while (Result > 0) and (FMatrix.IsTotalColumn(Result - 1)) do
    Dec(Result);

end; {function, GetLastDataColumn}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.GetLastDataRow }

function TppCrossTabEngine.GetLastDataRow: Integer;
begin

  Result := FMatrix.RowCount;

  if (FCrossTab.RowDefCount = 0) then Exit;

  while (Result > 0) and (FMatrix.IsTotalRow(Result - 1)) and (FMatrix.DefIndex[FMatrix.RowHeaderCount - 1, Result - 1] = -1) do
    Dec(Result);

end; {function, GetLastDataRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.SkipSubTotalColumns }

function TppCrossTabEngine.SkipSubTotalColumns(var aColumn: Integer; aColumnDef: Integer; aParentLabel: Variant): Boolean;
var
  liLastColumn: Integer;
  lbSkippingColumns: Boolean;
  liColumn: Integer;
  liRow: Integer;
  lTotalLabel: Variant;
  lbAscending: Boolean;
begin

  Result := False;

  liRow := aColumnDef;
  liColumn := aColumn;

  if (FCrossTab.ColumnDefCount > 0) then
    liLastColumn := FMatrix.ColumnCount - 1
  else
    liLastColumn := FMatrix.ColumnCount;

  lbSkippingColumns := True;

  while (liColumn < liLastColumn) and (lbSkippingColumns) do
    begin

      if not(FMatrix.IsTotalColumn(liColumn)) then
        lbSkippingColumns := False

      else if (aColumnDef > 0) and (FMatrix.DefIndex[liColumn, liRow] = (aColumnDef - 1)) then
        begin
          lTotalLabel := GetValue(FMatrix.Value[liColumn, liRow]);

          lbAscending := (FCrossTab.ColumnDefs[aColumnDef - 1].SortType = soAscending);

          if (lbAscending and (ppAnsiCompareVariant(aParentLabel, lTotalLabel) <= 0)) or
             (not(lbAscending) and (ppAnsiCompareVariant(aParentLabel, lTotalLabel) >= 0)) then
            begin
              lbSkippingColumns := False;

              aColumn := liColumn;

              Result := True;
            end
          else
            Inc(liColumn);
        end

      else if (FMatrix.DefIndex[liColumn, liRow] >= aColumnDef) or (FMatrix.DefIndex[liColumn, liRow] = -1) then
        Inc(liColumn)

      else if (FMatrix.DefIndex[liColumn, liRow] < aColumnDef) then
        begin
          lbSkippingColumns := False;

          aColumn := liColumn;

          Result := True;
        end;

    end;

  aColumn := liColumn;

end; {function, SkipSubTotalColumns}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.InsertColumn }

function TppCrossTabEngine.InsertColumn(aColumn, aColumnDef: Integer): Integer;
begin

  if (aColumn = -1) then
    aColumn := 0;

  Result := aColumn;

  FMatrix.InsertColumns(aColumn, 1, FCrossTab.ValueDefs[0].GetDataType);

  UpdateElementIndexOfColumn(aColumn);

  UpdateColumnHeaders(aColumn);

  InsertSubTotalColumns(aColumn, aColumnDef);

end; {function, InsertColumn}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.UpdateElementIndexOfColumn }

procedure TppCrossTabEngine.UpdateElementIndexOfColumn(aColumn: Integer);
var
  liRow: Integer;
  liCopyColumn: Integer;
  lElement: TppElement;
  liStartRow: Integer;
  liEndRow: Integer;
  liValueDef: Integer;
begin

  {set column header element index}
  for liRow := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      lElement := FCrossTab.ColumnDefs[liRow];

      FMatrix.ElementIndex[aColumn, liRow] := lElement.ElementIndex;
    end;

  {set value element index}
  liStartRow := FMatrix.ColumnHeaderCount;
  liEndRow := (FMatrix.RowCount - FCrossTab.VisibleRowGrandTotalCount) - 1;

  liCopyColumn := FMatrix.RowHeaderCount;

  if (liCopyColumn = aColumn) then
    liCopyColumn := FMatrix.FirstDataColumn(aColumn + 1);

  for liRow := liStartRow to liEndRow do
    FMatrix.ElementIndex[aColumn, liRow] := FMatrix.ElementIndex[liCopyColumn, liRow];

  {set element index for row grand total}
  if (FCrossTab.RowDefCount > 0) then
    begin
      for liRow := liEndRow + 1 to FMatrix.RowCount - 1 do
        begin
          liValueDef := liRow - (liEndRow + 1);

          lElement := FCrossTab.RowGrandTotals[liValueDef].TotalDef;

          FMatrix.ElementIndex[aColumn, liRow] := lElement.ElementIndex;
        end;
    end;

end; {procedure, UpdateElementIndexOfColumn}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FindSubTotalColumn }

function TppCrossTabEngine.FindSubTotalColumn(aColumn, aRow, aColumnDef: Integer): Integer;
var
  lbFound: Boolean;
  liLabelRow: Integer;
begin

  Result := -1;

  if not(FCrossTab.ColumnDefs[aColumnDef].SubTotals[0].CaptionDef.Visible) then Exit;

  liLabelRow := aColumnDef;

  lbFound := False;

  repeat

    if (FMatrix.IsTotalColumn(aColumn)) and
       (FMatrix.DefIndex[aColumn, liLabelRow] = aColumnDef) then
      lbFound := True
    else
      Inc(aColumn);

  until lbFound or (aColumn = FMatrix.ColumnCount);

  if (lbFound) then
    Result := aColumn
  else
    Result := -1;

end; {function, FindSubTotalColumn}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.InsertSubTotalColumns }

procedure TppCrossTabEngine.InsertSubTotalColumns(aColumn, aColumnDef: Integer);
var
  liColumn: Integer;
  liStartColumn: Integer;
  liEndColumn: Integer;
  liColumnDef: Integer;
  lsCaption: String;
  lValue: Variant;
  lSubTotal: TppTotalCaptionDef;
begin

  if (FCrossTab.ColumnDefCount = 1) then Exit;

  if (aColumnDef = FCrossTab.ColumnDefCount - 1) then Exit;

  {create subtotal rows for the aColumnDef dimension and each dimension nested within aColumnDef}
  liStartColumn := aColumn + 1;
  liEndColumn := liStartColumn + (FCrossTab.ColumnDefCount - 2) - aColumnDef;

  for liColumn := liStartColumn to liEndColumn do
    begin
      liColumnDef := (liColumn - liStartColumn) + aColumnDef;

      lSubTotal := FCrossTab.ColumnDefs[liColumnDef].SubTotals[0].CaptionDef;

      if (lSubTotal.Visible) then
        begin
          lValue := GetValue(FCrossTab.ColumnDefs[liColumnDef].GetValue);
          lsCaption := FCrossTab.ColumnDefs[liColumnDef].GetCaption;

          FMatrix.InsertTotalColumn(liStartColumn, liColumnDef, dtInteger, lValue, lsCaption, True);

          {set element index here}
          UpdateElementIndexOfSubTotalColumn(liStartColumn, liColumnDef);
        end;
    end;

end; {procedure, InsertSubTotalColumns}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.UpdateElementIndexOfSubTotalColumn }

procedure TppCrossTabEngine.UpdateElementIndexOfSubTotalColumn(aColumn, aColumnDef: Integer);
var
  liRow: Integer;
  lElement: TppElement;
  lColumnDef: TppColumnDef;
  liStartRow: Integer;
  liEndRow: Integer;
  liElementIndex: Integer;
  liValueDef: Integer;
begin

  {set parent row headers}
  for liRow := 0 to aColumnDef - 1 do
    begin
      lColumnDef := FCrossTab.ColumnDefs[liRow];

      FMatrix.Value[aColumn, liRow] := lColumnDef.GetValue;
      FMatrix.DefIndex[aColumn, liRow] := liRow;
      FMatrix.ElementIndex[aColumn, liRow] := lColumnDef.ElementIndex;
    end;

  lColumnDef := FCrossTab.ColumnDefs[aColumnDef];
  lElement := lColumnDef.SubTotals[0].CaptionDef;

  {set column header element index}
  for liRow := aColumnDef to FMatrix.ColumnHeaderCount - 1 do
    FMatrix.ElementIndex[aColumn, liRow] := lElement.ElementIndex;

  {set value element index}
  liStartRow := FMatrix.ColumnHeaderCount;
  liEndRow := (FMatrix.RowCount - FCrossTab.VisibleRowGrandTotalCount) - 1;

  for liRow := liStartRow to liEndRow do
    begin
      liElementIndex := FMatrix.ElementIndex[FMatrix.RowHeaderCount, liRow];

      lElement := GetElement(liElementIndex);

      if (lElement is TppValueDef) then
        begin
          liValueDef := FCrossTab.IndexOfChild(TppValueDef(lElement));

          lElement := lColumnDef.SubTotals[liValueDef].TotalDef;

          FMatrix.ElementIndex[aColumn, liRow] := lElement.ElementIndex;
        end;
    end;

end; {procedure, UpdateElementIndexOfSubTotalColumn}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.UpdateColumnHeaders }

procedure TppCrossTabEngine.UpdateColumnHeaders(aColumn: Integer);
var
  liColumnDef: Integer;
  liRow: Integer;
  lValue: Variant;
begin

  for liColumnDef := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      liRow := liColumnDef;

      lValue := FCrossTab.ColumnDefs[liColumnDef].GetValue;

      FMatrix.Value[aColumn, liRow] := lValue;
    end;

end; {function, UpdateColumnHeaders}



{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FindRowValue }

function TppCrossTabEngine.FindRowValue(aRow, aRowDef: Integer; var aRowFound: Boolean): Integer;
var
  liColumn: Integer;
  liRow: Integer;
  lParentLabel: Variant;
  lLabel: Variant;
  lCurrentLabel: Variant;
  liLastDataRow: Integer;
  lbAscending: Boolean;
  lbNullsFirst: Boolean;


begin

  Result := -1;
  aRowFound := False;

  if (aRowDef = 0) then
    lParentLabel := ''
  else
    lParentLabel := GetValue(FCrossTab.RowDefs[aRowDef - 1].GetValue);

  liLastDataRow := GetLastDataRow;

  lLabel := GetValue(FCrossTab.RowDefs[aRowDef].GetValue);

  lbAscending := (FCrossTab.RowDefs[aRowDef].SortType = soAscending);
  lbNullsFirst := (FCrossTab.RowDefs[aRowDef].NullOrder = ctnoFirst);

  liColumn := aRowDef;
  liRow := aRow;

  while (Result = -1) and (liRow <= FMatrix.RowCount) do
    begin
      {get current label}
      lCurrentLabel := GetValue(FMatrix.Value[liColumn, liRow]);

      if not(RowParentLabelsMatch(aRowDef, liColumn, liRow)) then
        Result := liRow

      {if empty value found, set row headers, insert subtotal rows and return row}
      else if (FMatrix.IsEmpty[liColumn, liRow]) then
        begin
          aRowFound := True;

          UpdateRowHeaders(liRow);

          InsertSubTotalRows(liRow, aRowDef);

          Result := liRow;
        end

      {if match found, return row}
      else if (lCurrentLabel = lLabel) then
        begin
          aRowFound := True;
          Result := liRow;
        end

      else if VarIsNull(lLabel) then
        begin
          if lbNullsFirst then
            Result := liRow
          else
            Inc(liRow);
        end

      else if VarIsNull(lCurrentLabel) then
        begin
          if lbNullsFirst then
            Inc(liRow)
          else
            Result := liRow;
        end

      else if lbAscending and (ppAnsiCompareVariant(lLabel, lCurrentLabel) < 0) then
        Result := liRow

      else if not(lbAscending) and (ppAnsiCompareVariant(lLabel, lCurrentLabel) > 0) then
        Result := liRow

      {goto next row}
      else
        Inc(liRow);

      {skip subtotal rows}
      if (Result = -1) and SkipSubTotalRows(liRow, aRowDef, lParentLabel) then
        Result := liRow;

      {if this is the last data row, return row}
      if (Result = -1) and (liRow >= liLastDataRow) then
        Result := liLastDataRow;
    end;

end; {function, FindRowValue}


{------------------------------------------------------------------------------}
{ TppCrossTabEngine.RowParentLabelsMatch }

function TppCrossTabEngine.RowParentLabelsMatch(aRowDef, aColumn, aRow: Integer): Boolean;
begin

  Result := True;

  while Result and (aColumn > 0) do
    begin
      Result := RowParentLabelMatch(aRowDef, aColumn, aRow);

      Dec(aColumn);
      Dec(aRowDef);
    end;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.RowParentLabelMatch }

function TppCrossTabEngine.RowParentLabelMatch(aRowDef, aColumn, aRow: Integer): Boolean;
var
  lParentLabel: Variant;
  lCurrentParentLabel: Variant;
begin

  Result := True;

  if (aRowDef > 0) then
    begin
      {get value from data pipeline}
      lParentLabel := GetValue(FCrossTab.RowDefs[aRowDef - 1].GetValue);

      {get value from the matrix}
      lCurrentParentLabel := GetValue(FMatrix.Value[aColumn - 1, aRow]);

      {if parent has changed, return row}
      if (ppAnsiCompareVariant(lCurrentParentLabel, lParentLabel) <> 0) then
        Result := False;

   end;

end;

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.SkipSubTotalRows }

function TppCrossTabEngine.SkipSubTotalRows(var aRow: Integer; aRowDef: Integer; aParentLabel: Variant): Boolean;
var
  liLastRow: Integer;
  lbSkippingRows: Boolean;
  liColumn: Integer;
  liRow: Integer;
  lTotalLabel: Variant;
  lbAscending: Boolean;
begin

  Result := False;

  liColumn := aRowDef;
  liRow := aRow;

  liLastRow := FMatrix.RowCount - FCrossTab.VisibleRowGrandTotalCount;

  lbSkippingRows := True;

  while (liRow < liLastRow) and (lbSkippingRows) do
    begin

      if not(FMatrix.IsTotalRow(liRow)) then
        lbSkippingRows := False

      else if (aRowDef > 0) and (FMatrix.DefIndex[liColumn, liRow] = (aRowDef - 1)) then
        begin
          lTotalLabel := GetValue(FMatrix.Value[liColumn, liRow]);

          lbAscending := (FCrossTab.RowDefs[aRowDef - 1].SortType = soAscending);

          if (lbAscending and (ppAnsiCompareVariant(aParentLabel, lTotalLabel) <= 0)) or
             (not(lbAscending) and (ppAnsiCompareVariant(aParentLabel, lTotalLabel) >= 0)) then
            begin
              lbSkippingRows := False;

              aRow := liRow;

              Result := True;
            end
          else
            Inc(liRow);
        end

      else if (FMatrix.DefIndex[liColumn, liRow] >= aRowDef) or (FMatrix.DefIndex[liColumn, liRow] = -1) then
        Inc(liRow)

      else if (FMatrix.DefIndex[liColumn, liRow] < aRowDef) then
        begin
          lbSkippingRows := False;

          aRow := liRow;

          Result := True;
        end;

    end;

  aRow := liRow;

end; {function, SkipSubTotalRows}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FindSubTotalRow }

function TppCrossTabEngine.FindSubTotalRow(aColumn, aRow, aRowDef, aValueDef: Integer): Integer;
var
  lbFound: Boolean;
  liLabelColumn: Integer;
begin

  Result := -1;

  if not(FCrossTab.RowDefs[aRowDef].SubTotals[aValueDef].CaptionDef.Visible) then Exit;

  liLabelColumn := aRowDef;

  lbFound := False;

  repeat

    if (FMatrix.IsTotalRow(aRow)) and (FMatrix.DefIndex[liLabelColumn, aRow] = aRowDef) then
      begin
        if (FCrossTab.ValueDefCount = 1) then
          lbFound := True

        else if (FMatrix.ValueDefIndex[liLabelColumn, aRow] = aValueDef) then
          lbFound := True

        else
          Inc(aRow);
      end

    else
      Inc(aRow);

  until lbFound or (aRow = FMatrix.RowCount);

  if (lbFound) then
    Result := aRow
  else
    Result := -1;

end; {function, FindSubTotalRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.InsertRow }

function TppCrossTabEngine.InsertRow(aRow, aRowDef: Integer): Integer;
var
  liIndex: Integer;
begin

  if (aRow = -1) then
    aRow := 0;

  Result := aRow;

  for liIndex := FCrossTab.ValueDefCount - 1 downto 0 do
    FMatrix.InsertRows(aRow, 1, FCrossTab.ValueDefs[liIndex].GetDataType);

  UpdateElementIndexOfRow(aRow);

  UpdateRowHeaders(aRow);

  InsertSubTotalRows(aRow, aRowDef);

end; {function, InsertRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.UpdateElementIndexOfRow }

procedure TppCrossTabEngine.UpdateElementIndexOfRow(aRow: Integer);
var
  liColumn: Integer;
  liRow: Integer;
  lElement: TppElement;
  liStartColumn: Integer;
  liEndColumn: Integer;
  liStartRow: Integer;
  liEndRow: Integer;
  lValueDef: TppValueDef;
  liValueDef: Integer;
  lbColumnGrandTotal: Boolean;
begin

  {set element index for row headers}
  for liColumn := 0 to FCrossTab.RowDefCount - 1 do
    begin
      for liRow := aRow to aRow + (FCrossTab.ValueDefCount - 1) do
        begin
          lElement := FCrossTab.RowDefs[liColumn];

          FMatrix.ElementIndex[liColumn, liRow] := lElement.ElementIndex;
        end;
    end;

  {set element index for values and value headers}
  liStartColumn := FMatrix.RowHeaderCount;

  lbColumnGrandTotal := FCrossTab.ColumnGrandTotals[0].CaptionDef.Visible;

  if (FCrossTab.ColumnDefCount > 0) and lbColumnGrandTotal then
    liEndColumn := (FMatrix.ColumnCount - 1) - 1
  else
    liEndColumn := FMatrix.ColumnCount - 1;


  for liColumn := liStartColumn to liEndColumn do
    begin
      liStartRow := aRow;
      liEndRow := aRow + (FCrossTab.ValueDefCount - 1);

      for liRow := liStartRow to liEndRow do
        begin
          liValueDef := liRow - liStartRow;

          lValueDef := FCrossTab.ValueDefs[liValueDef];

          lElement := lValueDef;
          FMatrix.ElementIndex[liColumn, liRow] := lElement.ElementIndex;

          {value def needs a caption def}
          if (FCrossTab.ValueDefCount > 1) and (liColumn = liStartColumn) then
           begin
             lElement := lValueDef.CaptionDef;

             FMatrix.ElementIndex[liColumn - 1, liRow] := lElement.ElementIndex;
           end;

          {set element index for column grand total}
          if (FCrossTab.ColumnDefCount > 0) and lbColumnGrandTotal then
            begin
              lElement := FCrossTab.ColumnGrandTotals[liValueDef].TotalDef;
              FMatrix.ElementIndex[liEndColumn + 1, liRow] := lElement.ElementIndex;
            end;
        end;
    end;

end; {function, UpdateElementIndexOfRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.InsertSubTotalRows }

procedure TppCrossTabEngine.InsertSubTotalRows(aRow, aRowDef: Integer);
var
  liStartRow: Integer;
  liEndRow: Integer;
  liRow: Integer;
  liRowDef: Integer;
  liValueDef: Integer;
begin

  if (FCrossTab.RowDefCount = 1) then Exit;

  if (aRowDef = FCrossTab.RowDefCount - 1) then Exit;

  {create subtotal rows for the aRowDef dimension and each dimension nested within aRowDef}
  liStartRow := aRow + FCrossTab.ValueDefCount;
  liEndRow := liStartRow + (FCrossTab.RowDefCount - 2) - aRowDef;

  for liRow := liStartRow to liEndRow do
    begin
      liRowDef := (liRow - liStartRow) + aRowDef;

      for liValueDef := FCrossTab.ValueDefCount - 1 downto 0 do
        ValueDefToSubTotalRow(liStartRow, liRowDef, liValueDef);
    end;

end; {procedure, InsertSubTotalRows}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.ValueDefToSubTotalRow }

procedure TppCrossTabEngine.ValueDefToSubTotalRow(aRow, aRowDef, aValueDef: Integer);
var
  lRowDefValue: Variant;
  lsRowDefCaption: String;
  lsValueDefCaption: String;
  liValueDef: Integer;
  lValueDataType: TppDataType;
  lbIsSubTotal: Boolean;
  lSubTotal: TppTotalCaptionDef;
begin

  lValueDataType := FCrossTab.ValueDefs[aValueDef].GetDataType;

  if (FCrossTab.ValueDefCount = 1) then
    begin
      lRowDefValue := FCrossTab.RowDefs[aRowDef].GetValue;
      lsRowDefCaption := FCrossTab.RowDefs[aRowDef].GetCaption;
      liValueDef := -1;
      lsValueDefCaption := '';
      lbIsSubTotal := True;

      lSubTotal := FCrossTab.RowDefs[aRowDef].SubTotals[0].CaptionDef;
    end

  else
    begin
      lRowDefValue := FCrossTab.RowDefs[aRowDef].GetValue;
      lsRowDefCaption := FCrossTab.RowDefs[aRowDef].GetCaption;
      liValueDef := aValueDef;
      lsValueDefCaption := FCrossTab.ValueDefs[liValueDef].GetName;
      lbIsSubTotal := True;

      lSubTotal := FCrossTab.RowDefs[aRowDef].SubTotals[liValueDef].CaptionDef;
    end;


  if lSubTotal.Visible then
    begin
      FMatrix.InsertTotalRow(aRow, aRowDef, liValueDef, lValueDataType, lRowDefValue, lsRowDefCaption, lsValueDefCaption, lbIsSubTotal);

      UpdateElementIndexOfSubTotalRow(aRow, aRowDef, aValueDef);
    end;

end; {procedure, ValueDefToSubTotalRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.UpdateElementIndexOfSubTotalRow }

procedure TppCrossTabEngine.UpdateElementIndexOfSubTotalRow(aRow, aRowDef, aValueDef: Integer);
var
  liColumn: Integer;
  lRowDef: TppRowDef;
  lElement: TppElement;
  liStartColumn: Integer;
  liEndColumn: Integer;
begin

  {set parent row headers}
  for liColumn := 0 to aRowDef - 1 do
    begin
      lRowDef := FCrossTab.RowDefs[liColumn];

      FMatrix.Value[liColumn, aRow] := lRowDef.GetValue;
      FMatrix.DefIndex[liColumn, aRow] := liColumn;
      FMatrix.ElementIndex[liColumn, aRow] := lRowDef.ElementIndex;
    end;


  lRowDef := FCrossTab.RowDefs[aRowDef];

  {set row headers}
  for liColumn := aRowDef to FMatrix.RowHeaderCount - 1 do
    begin
      lElement := lRowDef.SubTotals[aValueDef].CaptionDef;

      FMatrix.ElementIndex[liColumn, aRow] := lElement.ElementIndex;
    end;

  {set values}
  liStartColumn := FMatrix.RowHeaderCount;
  liEndColumn := FMatrix.ColumnCount - 1;

  for liColumn := liStartColumn to liEndColumn do
    begin
      lElement := lRowDef.SubTotals[aValueDef].TotalDef;

      FMatrix.ElementIndex[liColumn, aRow] := lElement.ElementIndex;
    end;

end; {procedure, UpdateElementIndexOfSubTotalRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.UpdateRowHeaders }

procedure TppCrossTabEngine.UpdateRowHeaders(aRow: Integer);
var
  liRowDef: Integer;
  liColumn: Integer;
  liRow: Integer;
  liValueDef: Integer;
  lRowDef: TppRowDef;
begin

  for liRowDef := 0 to FCrossTab.RowDefCount - 1 do
    begin
      lRowDef := FCrossTab.RowDefs[liRowDef];

      liColumn := liRowDef;

      FMatrix.Value[liColumn, aRow] := lRowDef.GetValue;
      FMatrix.ElementIndex[liColumn, aRow] := lRowDef.ElementIndex;

      if (FCrossTab.ValueDefCount > 1) then
        begin

          for liValueDef := 1 to FCrossTab.ValueDefCount - 1 do
            begin
              liRow := aRow + liValueDef;

              FMatrix.Value[liColumn, liRow] := lRowDef.GetValue;
              FMatrix.ElementIndex[liColumn, liRow] := lRowDef.ElementIndex;
            end;

        end;

    end;

  if (FCrossTab.ValueDefCount > 1) then
    begin
      liColumn := FCrossTab.RowDefCount;

      for liValueDef := 0 to FCrossTab.ValueDefCount - 1 do
        begin
          liRow := aRow + liValueDef;

          FMatrix.Value[liColumn, liRow] := FCrossTab.ValueDefs[liValueDef].GetName;
        end;

    end;

end; {procedure, UpdateRowHeaders}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.CalcValues }

procedure TppCrossTabEngine.CalcValues(aColumn, aRow: Integer);
var
  liValueDef: Integer;
  liColumnDef: Integer;
  liColumn: Integer;
  liRow: Integer;
  liRowDef: Integer;
  liGrandTotalColumn: Integer;
  liGrandTotalRow: Integer;
begin

  for liValueDef := 0 to FCrossTab.ValueDefCount - 1 do
    begin

      FreeValueCoords;

      liGrandTotalColumn := FindGrandTotalColumn;
      liGrandTotalRow := FindGrandTotalRow(liValueDef);

      {get value cell}
      FValueCoords.Add(TppCoordinate.Create(aColumn, aRow));

      {get corresponding column sub total cells}
      if (FCrossTab.ColumnDefCount > 1) then
        begin

          for liColumnDef := 0 to FCrossTab.ColumnDefCount - 2 do
            begin
              liColumn := FindSubTotalColumn(aColumn, aRow, liColumnDef);

              if (liColumn <> -1) then
                begin
                  FValueCoords.Add(TppColumnSubTotalCoordinate.Create(liColumn, aRow, liColumnDef));

                  {get corresponding row grand total cell}
                  if (FCrossTab.RowDefCount > 0) and (liGrandTotalRow <> - 1) then
                    FValueCoords.Add(TppColumnSubTotalCoordinate.Create(liColumn, liGrandTotalRow, liColumnDef));
                end;
            end;
        end;

      {get corresponding row sub total cells}
      if (FCrossTab.RowDefCount > 1) then
        begin

          for liRowDef := 0 to FCrossTab.RowDefCount - 2 do
            begin
              liRow := FindSubTotalRow(aColumn, aRow, liRowDef, liValueDef);

              if (liRow <> -1) then
                begin
                  FValueCoords.Add(TppRowSubTotalCoordinate.Create(aColumn, liRow, liRowDef));

                  {get corresponding column grand total cell}
                  if (FCrossTab.ColumnDefCount > 0) and (liGrandTotalColumn <> - 1) then
                    FValueCoords.Add(TppRowSubTotalCoordinate.Create(liGrandTotalColumn, liRow, liRowDef));
                end;
            end;

        end;

      {get corresponding column grand total cell}
      if (liGrandTotalColumn <> -1) then
        FValueCoords.Add(TppCoordinate.Create(liGrandTotalColumn, aRow));

      {get corresponding row grand total cell}
      if (liGrandTotalRow <> -1) then
        FValueCoords.Add(TppCoordinate.Create(aColumn, liGrandTotalRow));

      {get intersection grand total cell}
      if (liGrandTotalColumn <> -1) and (liGrandTotalRow <> -1) then
        FValueCoords.Add(TppCoordinate.Create(liGrandTotalColumn, liGrandTotalRow));

      {calculate the value}
      CalcValue(FCrossTab.ValueDefs[liValueDef]);

      {trigger summary level events here, passing FValueCoords}

      Inc(aRow);
    end;

end; {procedure, CalcValues}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FindGrandTotalColumn }

function TppCrossTabEngine.FindGrandTotalColumn: Integer;
begin

  Result := -1;

  if (FCrossTab.ColumnDefCount > 0) and FCrossTab.ColumnGrandTotals[0].CaptionDef.Visible then
    Result := FMatrix.ColumnCount - 1;

end; {function, FindGrandTotalColumn}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FindGrandTotalRow }

function TppCrossTabEngine.FindGrandTotalRow(aValueDef: Integer): Integer;
var
  liRow: Integer;
  liStartRow: Integer;
  liValueDef: Integer;
begin

  Result := -1;

  if (FCrossTab.RowDefCount > 0) and FCrossTab.RowGrandTotals[aValueDef].CaptionDef.Visible then
    begin
      liStartRow := FMatrix.RowCount - 1;
      liRow := liStartRow;

      liValueDef := FMatrix.ValueDefIndex[0, liRow];

      while ((liStartRow - liRow) < FCrossTab.ValueDefCount) and (liValueDef <> -1) and (Result = -1) do
        begin
          if (liValueDef = aValueDef) then
            Result := liRow
          else
            Dec(liRow);

          liValueDef := FMatrix.ValueDefIndex[0, liRow];
        end;
    end;

end; {function, FindGrandTotalRow}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.CalcValue }

procedure TppCrossTabEngine.CalcValue(aValueDef: TppValueDef);
var
  lCellValue: Variant;
  lbCellIsNull: Boolean;
  lCurrentCellValue: Variant;
  lCurrentValue: Variant;
  liIndex: Integer;
  lCoordinate: TppCoordinate;

  procedure CalcValue;
  var
    lCellSum: Variant;
    lCellCount: Variant;
  begin

    case aValueDef.CalcType of
      dcCount:
        begin
          lCellValue := lCurrentCellValue + 1;
        end;

      dcMinimum:
        begin
          if (lbCellIsNull) or (lCurrentValue < lCurrentCellValue) then
            lCellValue := lCurrentValue
          else
            lCellValue := lCurrentCellValue;
        end;

      dcMaximum:
        begin
          if (lbCellIsNull) or (lCurrentValue > lCurrentCellValue) then
            lCellValue := lCurrentValue
          else
            lCellValue := lCurrentCellValue;
        end;

      dcSum:
        begin
          lCellValue := lCurrentCellValue + lCurrentValue;
        end;

      dcAverage:
        begin
          lCellSum := FMatrix.Sum[lCoordinate.Column, lCoordinate.Row];
          lCellSum := lCellSum + lCurrentValue;
          FMatrix.Sum[lCoordinate.Column, lCoordinate.Row] := lCellSum;

          lCellCount := FMatrix.Count[lCoordinate.Column, lCoordinate.Row];
          lCellCount := lCellCount + 1;
          FMatrix.Count[lCoordinate.Column, lCoordinate.Row] := lCellCount;

          lCellValue := lCellSum / lCellCount;
        end;

    end; {case, CalcType}

  end; {procedure, CalcValue}

begin

  {get value triggers OnGetValue event}
  lCurrentValue := aValueDef.GetValue;

  {if value is not a valid type, and calc type not count, then exit}
  if (aValueDef.CalcType <> dcCount) and not(VarType(lCurrentValue) in varNumerics) then Exit;

  {if OnGetValue has set SkipRecord, then exit}
  if aValueDef.Skip then Exit;


  for liIndex := 0 to FValueCoords.Count - 1 do
    begin
      lCoordinate := TppCoordinate(FValueCoords[liIndex]);

      lbCellIsNull := FMatrix.IsNull[lCoordinate.Column, lCoordinate.Row];

      lCurrentCellValue := FMatrix.Value[lCoordinate.Column, lCoordinate.Row];

      CalcValue;

      aValueDef.DoOnCalcValue(lCellValue);

      FMatrix.Value[lCoordinate.Column, lCoordinate.Row] := lCellValue;
    end;

end; {procedure, CalcValue}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.AddFieldLabels }

procedure TppCrossTabEngine.AddFieldLabels;
var
  liColumn: Integer;
  liRow: Integer;
  lsCaption: String;
  liIndex: Integer;
  liRow2: Integer;
  liColumn2: Integer;
  lCaption: TppValueCaptionDef;
begin

  {insert field label row}
  FMatrix.ColumnHeaderCount := FMatrix.ColumnHeaderCount + 1;
  FMatrix.InsertRows(0, 1, dtInteger);

  for liColumn := 0 to FMatrix.ColumnCount - 1 do
    FMatrix.CaptionVisible[liColumn, 0] := False;

  for liRow := 0 to FMatrix.ColumnHeaderCount - 1 do
    for liColumn := 0 to FMatrix.RowHeaderCount - 1 do
      FMatrix.CaptionVisible[liColumn, liRow] := False;
    
  {insert additional row or column for single value crosstab}
  if (FCrossTab.ValueDefCount = 1) then
    begin
      if (FCrossTab.ColumnDefCount = 0) and (FCrossTab.RowDefCount = 0) then
        {do nothing}

      else if (FCrossTab.ColumnDefCount = 0) then
        begin
          FMatrix.ColumnHeaderCount := FMatrix.ColumnHeaderCount + 1;
          FMatrix.InsertRows(0,1, dtInteger);

          for liColumn := 0 to FMatrix.ColumnCount - 1 do
            FMatrix.CaptionVisible[liColumn, 0] := False;
        end

      else if (FCrossTab.RowDefCount = 0) then
        begin
          FMatrix.RowHeaderCount := FMatrix.RowHeaderCount + 1;
          FMatrix.InsertColumns(0,1, dtInteger);

          for liRow := 0 to FMatrix.RowCount - 1 do
            FMatrix.CaptionVisible[0, liRow] := False;
        end;
    end;

  {add value captions}
  if (FCrossTab.ValueDefCount = 1) then
    begin
      lCaption := FCrossTab.ValueDefs[0].CaptionDef;

      if (FCrossTab.RowDefCount > 0) then
        begin
          liRow := 0;

          for liColumn := 0 to FCrossTab.RowDefCount - 1 do
            begin
              FMatrix.CaptionVisible[liColumn, liRow] := True;
              FMatrix.Value[liColumn, liRow] := lCaption.GetName;
              FMatrix.ElementIndex[liColumn, liRow] := lCaption.ElementIndex;

              if (liColumn > 0) then
                begin
                  FMatrix.CaptionVisible[liColumn, liRow] := False;

                  FMatrix.Borders[liColumn - 1, liRow, btRight] := False;
                  FMatrix.Borders[liColumn, liRow, btLeft] := False;
                end;
            end;

          if (FCrossTab.ColumnDefCount = 0) then
            begin
              lsCaption := ppLoadStr(70); {'Total'}
              liColumn := FCrossTab.RowDefCount;
              liRow := 1;

              FMatrix.CaptionVisible[liColumn, liRow] := True;
              FMatrix.Value[liColumn, liRow] := lsCaption;
              FMatrix.ElementIndex[liColumn, liRow] := lCaption.ElementIndex;
            end;
        end

      else if (FCrossTab.ColumnDefCount > 0) then
        begin
          liColumn := 0;

          for liRow := 0 to FCrossTab.ColumnDefCount do
            begin
              FMatrix.CaptionVisible[liColumn, liRow] := True;
              FMatrix.Value[liColumn, liRow] := lCaption.GetName;
              FMatrix.ElementIndex[liColumn, liRow] := lCaption.ElementIndex;

              if (liRow > 0) then
                begin
                  FMatrix.CaptionVisible[liColumn, liRow] := False;

                  FMatrix.Borders[liColumn, liRow - 1, btBottom] := False;
                  FMatrix.Borders[liColumn, liRow, btTop] := False;
                end;
            end;

          if (FCrossTab.RowDefCount = 0) then
            begin
              lsCaption := ppLoadStr(70); {'Total'}
              liColumn := 0;
              liRow := FCrossTab.ColumnDefCount + 1;

              FMatrix.CaptionVisible[liColumn, liRow] := True;
              FMatrix.Value[liColumn, liRow] := lsCaption;
              FMatrix.ElementIndex[liColumn, liRow] := lCaption.ElementIndex;
            end;

        end

      else
        begin
          FMatrix.CaptionVisible[0,0] := True;
          FMatrix.Value[0,0] := lCaption.GetName;
          FMatrix.ElementIndex[0,0] := lCaption.ElementIndex;
        end

    end
  else
    begin
      lsCaption := ppLoadStr(71); {'Data'}
      liColumn := FCrossTab.RowDefCount;
      liRow := FCrossTab.ColumnDefCount;

      FMatrix.CaptionVisible[liColumn, liRow] := True;
      FMatrix.Value[liColumn, liRow] := lsCaption;
      FMatrix.ElementIndex[liColumn, liRow] := FCrossTab.ValueDefs[0].CaptionDef.ElementIndex;

      for liRow2 := 0 to liRow - 1 do
        for liColumn2 := 0 to FMatrix.RowHeaderCount - 1 do
          FMatrix.CaptionVisible[liColumn2, liRow2] := False;

      if (liRow > 0) then
        begin
          FMatrix.Borders[liColumn, liRow, btTop] := False;
          FMatrix.Borders[liColumn, liRow - 1, btBottom] := False;
        end;

      {hide borders of anchor cell}
      for liColumn := 0 to FCrossTab.RowDefCount do
        for liRow := 0 to FCrossTab.ColumnDefCount - 1 do
          begin
            if (liRow > 0) then
              FMatrix.Borders[liColumn, liRow, btTop] := False;

            if (liRow < FCrossTab.ColumnDefCount) then
              FMatrix.Borders[liColumn, liRow, btBottom] := False;

            if (liColumn > 0) then
              FMatrix.Borders[liColumn, liRow, btLeft] := False;

            if (liColumn < FCrossTab.RowDefCount) then
              FMatrix.Borders[liColumn, liRow, btRight] := False;
          end;

      if (FCrossTab.ColumnDefCount = 0) then
        begin
          lsCaption := ppLoadStr(70); {'Total'}
          liColumn := FCrossTab.RowDefCount + 1;
          liRow := 0;

          lCaption := FCrossTab.ValueDefs[0].CaptionDef;

          FMatrix.CaptionVisible[liColumn, liRow] := True;
          FMatrix.Value[liColumn, liRow] := lsCaption;
          FMatrix.ElementIndex[liColumn, liRow] := lCaption.ElementIndex;
        end;

      if (FCrossTab.RowDefCount = 0) then
        begin
          liColumn := 0;
          liRow := FCrossTab.ColumnDefCount + 1;

          for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
            begin
              lCaption := FCrossTab.ValueDefs[liIndex].CaptionDef;

              FMatrix.CaptionVisible[liColumn, liRow] := True;
              FMatrix.Value[liColumn, liRow] := lCaption.GetName;
              FMatrix.ElementIndex[liColumn, liRow] := lCaption.ElementIndex;

              Inc(liRow);
            end;
        end;
    end;

  {add column dimension captions}
  for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      lsCaption := FCrossTab.ColumnDefs[liIndex].GetName;
      liColumn := FMatrix.RowHeaderCount + liIndex;
      liRow := 0;

      if (liColumn < FMatrix.ColumnCount) then
        begin
          FMatrix.CaptionVisible[liColumn, liRow] := True;
          FMatrix.Value[liColumn, liRow] := lsCaption;
          FMatrix.ElementIndex[liColumn, liRow] := FCrossTab.ColumnDefs[liIndex].ElementIndex;
        end;
    end;

  {add row dimension captions}
  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    begin
      lsCaption := FCrossTab.RowDefs[liIndex].GetName;
      liColumn := liIndex;

      if (FCrossTab.ValueDefCount = 1) and (FCrossTab.ColumnDefCount = 0) then
        liRow := 1
      else
        liRow := FCrossTab.ColumnDefCount;

      if (liRow < FMatrix.RowCount) then
        begin
          FMatrix.CaptionVisible[liColumn, liRow] := True;
          FMatrix.Value[liColumn, liRow] := lsCaption;
          FMatrix.ElementIndex[liColumn, liRow] := FCrossTab.RowDefs[liIndex].ElementIndex;
        end;
    end;

end; {procedure, AddFieldLabels}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.BuildElementList }

procedure TppCrossTabEngine.BuildElementList;
var
  liIndex: Integer;
  liIndex2: Integer;
  lDimension: TppDimension;
  lTotal: TppTotal;
  lValueDef: TppValueDef;

  procedure AddElement(aElement: TppElement);
  begin
    aElement.ElementIndex := FElementList.Add(aElement);
  end;

begin

  FElementList.Clear;

  for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      lDimension := FCrossTab.ColumnDefs[liIndex];

      AddElement(lDimension);

      for liIndex2 := 0 to lDimension.SubTotalCount - 1 do
        begin
          AddElement(lDimension.SubTotals[liIndex2].CaptionDef);
          AddElement(lDimension.SubTotals[liIndex2].TotalDef);
        end;
    end;

  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    begin
      lDimension := FCrossTab.RowDefs[liIndex];

      AddElement(lDimension);

      for liIndex2 := 0 to lDimension.SubTotalCount - 1 do
        begin
          lTotal := lDimension.SubTotals[liIndex2];

          AddElement(lTotal.CaptionDef);
          AddElement(lTotal.TotalDef);
        end;
    end;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lValueDef := FCrossTab.ValueDefs[liIndex];

      AddElement(lValueDef);

      AddElement(lValueDef.CaptionDef)
    end;

  for liIndex := 0 to FCrossTab.ColumnGrandTotalCount - 1 do
    begin
      lTotal := FCrossTab.ColumnGrandTotals[liIndex];

      AddElement(lTotal.CaptionDef);
      AddElement(lTotal.TotalDef);
    end;

  for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
    begin
      lTotal := FCrossTab.RowGrandTotals[liIndex];

      AddElement(lTotal.CaptionDef);
      AddElement(lTotal.TotalDef);
    end;

end; {procedure, BuildElementList}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.CompareDimensionValues }

function TppCrossTabEngine.CompareDimensionValues(aDimension: TppDimension; aValue1, aValue2: Variant): Integer;
begin

  if (aValue1 = aValue2) then
    Result := 0 // match found

  else if VarIsNull(aValue1) then
    begin
      if aDimension.NullOrder = ctnoFirst then
        Result := -1
      else
        Result := 1;
    end
  else if VarIsNull(aValue2) then
    begin
      if aDimension.NullOrder = ctnoFirst then
        Result := 1
      else
        Result := -1;
    end
  else if (aDimension.SortType = soNone) then
    Result := -1

  else if (aDimension.SortType = soAscending) then
    Result := ppAnsiCompareVariant(aValue1, aValue2)

  else if (aDimension.SortType = soDescending) then
    Result := ppAnsiCompareVariant(aValue2, aValue1);

  if aDimension.SortType = soNone then
    FCrossTab.DoOnCompareDimensionValues(aDimension, aValue1, aValue2,  Result);

end;

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.GetValue }

function TppCrossTabEngine.GetValue(aValue: Variant): Variant;
begin

  if ppVariantIsString(aValue) then
    Result := Uppercase(aValue)
  else
    Result := aValue;

end; {function, GetValue}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.GetElement }

function TppCrossTabEngine.GetElement(aIndex: Integer): TppElement;
begin
  Result := TppElement(FElementList[aIndex]);
end; {function, GetElement}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.FreeValueCoords }

procedure TppCrossTabEngine.FreeValueCoords;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FValueCoords.Count - 1 do
    TObject(FValueCoords[liIndex]).Free;

  FValueCoords.Clear;

end; {procedure, FreeValueCoords}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.InitCalcGrid }

procedure TppCrossTabEngine.InitCalcGrid;
var
  liIndex: Integer;
  liColumn: Integer;
  liRow: Integer;
  lElement: TppElement;
  liStartRow: Integer;
  liEndRow: Integer;
  liValueDef: Integer;
  lTotal: TppTotalCaptionDef;
  lbColumnGrandTotal: Boolean;
begin

  BuildElementList;

  FMatrix := TppMatrix.Create;

  FMatrix.ColumnHeaderCount := FCrossTab.ColumnDefCount;
  FMatrix.RowHeaderCount := FCrossTab.RowDefCount;

  {if more than one value, add row for value labels}
  if (FCrossTab.ValueDefCount > 1) then
    FMatrix.RowHeaderCount := FMatrix.RowHeaderCount + 1;

  {append columns or rows as necessary}
  if (FMatrix.RowHeaderCount > 0) then
    FMatrix.AppendColumns(FMatrix.RowHeaderCount + 1, FCrossTab.ValueDefs[0].GetDataType)

  else if (FMatrix.ColumnHeaderCount > 0) then
    FMatrix.AppendRows(FMatrix.ColumnHeaderCount + 1, FCrossTab.ValueDefs[0].GetDataType);

  {add rows in which additional values will be placed}
  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      if (liIndex = 0) then
        begin
          if (FCrossTab.ColumnDefCount = 0) and (FCrossTab.RowDefCount = 0) then
            FMatrix.AppendRows(1, FCrossTab.ValueDefs[liIndex].GetDataType);
        end
      else
        FMatrix.AppendRows(1, FCrossTab.ValueDefs[liIndex].GetDataType);
    end;

  lbColumnGrandTotal := False;
  
  {add column grand total}
  if (FCrossTab.ColumnDefCount > 0) then
    begin
      lTotal := FCrossTab.ColumnGrandTotals[0].CaptionDef;

      lbColumnGrandTotal := lTotal.Visible;

      if (lbColumnGrandTotal) then
        begin
          FMatrix.InsertTotalColumn(FMatrix.ColumnCount, -1, dtInteger, '', ppLoadStr(72), False); {'Grand Total'}

          lElement := FCrossTab.ColumnGrandTotals[0].CaptionDef;
          liColumn := FMatrix.ColumnCount - 1;

          for liRow := 0 to FMatrix.ColumnHeaderCount - 1 do
            FMatrix.ElementIndex[liColumn, liRow] := lElement.ElementIndex;

          for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
            begin
              lElement := FCrossTab.ColumnGrandTotals[liIndex].TotalDef;
              FMatrix.ElementIndex[liColumn, liIndex + FCrossTab.ColumnDefCount] := lElement.ElementIndex;
            end;
        end;
    end;

  {add row grand total}
  if (FCrossTab.RowDefCount > 0) then
    begin
      for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
        begin
          lTotal := FCrossTab.RowGrandTotals[liIndex].CaptionDef;

          if not(lTotal.Visible) then Continue;

          if (FCrossTab.ValueDefCount = 1) then
            FMatrix.InsertTotalRow(FMatrix.RowCount, -1, liIndex, FCrossTab.ValueDefs[liIndex].GetDataType, '', '', ppLoadStr(72), False) {'Grand Total'}
          else
            FMatrix.InsertTotalRow(FMatrix.RowCount, -1, liIndex, FCrossTab.ValueDefs[liIndex].GetDataType, '', ppLoadStr(70), FCrossTab.ValueDefs[liIndex].GetName, False); {'Total'}

          liRow := (FMatrix.RowCount - 1);

          lElement := FCrossTab.RowGrandTotals[liIndex].CaptionDef;

          for liColumn := 0 to FMatrix.RowHeaderCount - 1 do
            FMatrix.ElementIndex[liColumn, liRow] := lElement.ElementIndex;

          lElement := FCrossTab.RowGrandTotals[liIndex].TotalDef;
          FMatrix.ElementIndex[FMatrix.RowHeaderCount, liRow] := lElement.ElementIndex;

          {set element index for intersection totals}
          if (FCrossTab.ColumnDefCount > 0) and lbColumnGrandTotal then
            begin
              lElement := FCrossTab.ColumnGrandTotals[liIndex].TotalDef;
              FMatrix.ElementIndex[FMatrix.RowHeaderCount + 1, liRow] := lElement.ElementIndex;
            end;

        end;
    end;

  {if multiple value defs, initialize value def labels}
  if (FCrossTab.RowDefCount = 0) and (FCrossTab.ValueDefCount > 1) then
    UpdateRowHeaders(FMatrix.ColumnHeaderCount);

  {set element index for column headers}
  liColumn := FMatrix.RowHeaderCount;

  for liRow := 0 to FCrossTab.ColumnDefCount - 1 do
    FMatrix.ElementIndex[liColumn, liRow] := FCrossTab.ColumnDefs[liRow].ElementIndex;

  {set element index for row headers}
  liRow := FMatrix.ColumnHeaderCount;

  for liColumn := 0 to FCrossTab.RowDefCount - 1 do
    FMatrix.ElementIndex[liColumn, liRow] := FCrossTab.RowDefs[liColumn].ElementIndex;

  {set element index for value headers and values}
  liColumn := FMatrix.RowHeaderCount;

  liStartRow := FCrossTab.ColumnDefCount;
  liEndRow := liStartRow + FCrossTab.ValueDefCount - 1;

  for liRow := liStartRow to liEndRow  do
    begin
      liValueDef := liRow - liStartRow;

      lElement := FCrossTab.ValueDefs[liValueDef];

      FMatrix.ElementIndex[liColumn, liRow] := lElement.ElementIndex;

      if (FCrossTab.ValueDefCount > 1) and (liColumn > 0) then
        FMatrix.ElementIndex[liColumn - 1, liRow] := FCrossTab.ValueDefs[liValueDef].CaptionDef.ElementIndex;
    end;

end; {procedure, InitCalcGrid}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.InitDataPipelines }

procedure TppCrossTabEngine.InitDataPipelines;
var
  lbSkipRecord: Boolean;
begin

  FDataPipeline := FCrossTab.DataPipeline;

  FAllDataTraversed := True;

  if (FDataPipeline = nil) then Exit;

  if not(FDataPipeline.Active) then
    FDataPipeline.Open;

  if (FDataPipeline.Active) and not(ValidateFields) then Exit;

  FDataPipelineState := FDataPipeline.State;
  FPipelineBookmark := FDataPipeline.GetBookmark;
  FPipelineTraversalCount := FDataPipeline.TraversalCount;
  FPipelineRecordNo := FDataPipeline.RecordNo;

  FDataPipeline.First;

  {skip records}
  lbSkipRecord := SkipRecord;

  while lbSkipRecord and not(FDataPipeline.EOF) do
    begin
      FDataPipeline.Next;

      lbSkipRecord := SkipRecord;
    end;

  FAllDataTraversed := (ppdaNoRecords in FDataPipeline.State) or FDataPipeline.EOF;
  FFirstRecord := True;

end; {procedure, InitDataPipelines}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.ValidateFields }

function TppCrossTabEngine.ValidateFields: Boolean;
var
  lFieldNames: TStringList;
  liIndex: Integer;
  lsFieldAlias: String;
  lsMessage1: String;
  lsMessage2: String;
begin

  Result := False;

  lFieldNames := TStringList.Create;

  if not(FDataPipeline.GetFieldNames(lFieldNames)) then
    begin
      lFieldNames.Free;

      Exit;
    end;

  lsFieldAlias := '';
  liIndex := 0;

  while (liIndex < FCrossTab.ColumnDefCount) and (lsFieldAlias = '') do
    begin
      if (lFieldNames.IndexOf(FCrossTab.ColumnDefs[liIndex].FieldName) = -1) then
        lsFieldAlias := FCrossTab.ColumnDefs[liIndex].FieldAlias
      else
        Inc(liIndex);
    end;

  liIndex := 0;

  while (liIndex < FCrossTab.RowDefCount) and (lsFieldAlias = '') do
    begin
      if (lFieldNames.IndexOf(FCrossTab.RowDefs[liIndex].FieldName) = -1) then
        lsFieldAlias := FCrossTab.RowDefs[liIndex].FieldAlias
      else
        Inc(liIndex);
    end;

  liIndex := 0;

  while (liIndex < FCrossTab.ValueDefCount) and (lsFieldAlias = '') do
    begin
      if (lFieldNames.IndexOf(FCrossTab.ValueDefs[liIndex].FieldName) = -1) then
        lsFieldAlias := FCrossTab.ValueDefs[liIndex].FieldAlias
      else
        Inc(liIndex);
    end;

  lFieldNames.Free;

  if (lsFieldAlias <> '') then
    begin
      Result := False;

      {'CrossTab: <name> references field <name>'}
      lsMessage1 := ppLoadStr(73);
      lsMessage1 := ppSetMessageParameters(lsMessage1);
      lsMessage1 := Format(lsMessage1, [FCrossTab.UserName, lsFieldAlias]);

      {'which is not a field of data pipeline: <name>.'}
      lsMessage2 := ppLoadStr(74);
      lsMessage2 := ppSetMessageParameters(lsMessage2);
      lsMessage2 := Format(lsMessage2, [FDataPipeline.UserName]);

      FCrossTab.Band.Report.RaiseException(EPrintError.Create(lsMessage1 + lsMessage2));
    end
  else
    Result := True;

end; {procedure, ValidateFields}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.RestoreDataPipelines }

procedure TppCrossTabEngine.RestoreDataPipelines;
begin
  FDataPipeline.GotoBookmark(FPipelineBookmark);
  FDataPipeline.FreeBookmark(FPipelineBookmark);
  FDataPipeline.State := FDataPipelineState;
  FDataPipeline.TraversalCount := FPipelineTraversalCount;
  FDataPipeline.RecordNo := FPipelineRecordNo;


end; {procedure, RestoreDataPipelines}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.GotoNextRecord }

procedure TppCrossTabEngine.GotoNextRecord;
var
  lbSkipRecord: Boolean;
begin

  FDataPipeline.Next;

  lbSkipRecord := SkipRecord;

  while lbSkipRecord and not(FDataPipeline.EOF) do
    begin
      FDataPipeline.Next;

      lbSkipRecord := SkipRecord;
    end;

  Inc(FRecordCount);

  FAllDataTraversed := FDataPipeline.EOF;
  FFirstRecord := False;

  if (FRecordCount mod 100) = 0 then
    begin
      FStatus := ppLoadStr(69); {'Calculating Crosstab: Record <count>.'}
      FStatus := ppSetMessageParameters(FStatus);
      FStatus := Format(FStatus, [IntToStr(FRecordCount)]);
      
      SetStatus(FStatus);
    end;

end; {procedure, GotoNextRecord}

{------------------------------------------------------------------------------}
{ TppCrossTabEngine.SkipRecord }

function TppCrossTabEngine.SkipRecord: Boolean;
var
  lbSkipRecord: Boolean;
  liIndex: Integer;
begin

  lbSkipRecord := False;

  FCrossTab.DoOnTraverseRecord(FDataPipeline, lbSkipRecord);

  liIndex := 0;

  while not(lbSkipRecord) and (liIndex < FCrossTab.ColumnDefCount) do
    begin
      if (FCrossTab.ColumnDefs[liIndex].Skip) then
        lbSkipRecord := True
      else
        Inc(liIndex);
    end;

  liIndex := 0;

  while not(lbSkipRecord) and (liIndex < FCrossTab.RowDefCount) do
    begin
      if (FCrossTab.RowDefs[liIndex].Skip) then
        lbSkipRecord := True
      else
        Inc(liIndex);
    end;

  Result := lbSkipRecord;
  
end; {procedure, SkipRecord}

end.
