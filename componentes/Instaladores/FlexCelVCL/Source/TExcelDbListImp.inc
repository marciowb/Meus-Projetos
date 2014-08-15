//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TExcelDbList.GetItems(index: integer): IXlsDataSet;
begin
  Result := IXlsDataSet(inherited Items[Index]) ;
end;

procedure TExcelDbList.SetItems(index: integer; const Value: IXlsDataSet);
begin
  inherited Items[Index] := Value;
end;

function TExcelDbList.Add(aDataSet: IXlsDataSet):integer;
begin
  Result:=inherited Add(aDataSet);
end;

procedure TExcelDbList.Insert(Index: Integer; ADataSet:IXlsDataSet);
begin
  inherited Insert(Index, ADataSet);
end;

