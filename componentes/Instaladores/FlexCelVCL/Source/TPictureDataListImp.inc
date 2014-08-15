//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TPictureDataList.GetItems(index: integer): TPictureData;
begin
  Result := TPictureData (inherited Items[Index]);
end;

procedure TPictureDataList.SetItems(index: integer; const Value: TPictureData);
begin
  inherited Items[Index] := Value;
end;

function TPictureDataList.Add(aRecord: TPictureData):integer;
begin
  Result:=inherited Add(aRecord);
end;

procedure TPictureDataList.Insert(Index: Integer; ARecord:TPictureData);
begin
  inherited Insert(Index, ARecord);
end;

