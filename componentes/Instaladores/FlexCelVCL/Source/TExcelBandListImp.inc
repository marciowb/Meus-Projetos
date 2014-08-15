//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TExcelBandList.GetItems(index: integer): TExcelBand;
begin
  Result := inherited Items[Index] as TExcelBand;
end;

procedure TExcelBandList.SetItems(index: integer; const Value: TExcelBand);
begin
  inherited Items[Index] := Value;
end;

function TExcelBandList.Add(aBand: TExcelBand):integer;
begin
  Result:=inherited Add(aBand);
end;

procedure TExcelBandList.Insert(Index: Integer; ABand:TExcelBand);
begin
  inherited Insert(Index, ABand);
end;

