//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TFlxRecordList.GetItems(index: integer): TFlxRecord;
begin
  Result := TFlxRecord (inherited Items[Index]);
end;

procedure TFlxRecordList.SetItems(index: integer; const Value: TFlxRecord);
begin
  inherited Items[Index] := Value;
end;

function TFlxRecordList.Add(aRecord: TFlxRecord):integer;
begin
  Result:=inherited Add(aRecord);
  Sorted:=false;  //When we add the list gets unsorted
end;

procedure TFlxRecordList.Insert(Index: Integer; ARecord:TFlxRecord);
begin
  inherited Insert(Index, ARecord);
  // We assume that when we insert, we respect the order, so we dont set Sorted=true
end;

function CompareFlxRecords(Item1, Item2: Pointer): Integer;
begin
  if (TFlxRecord(Item1).ParentList.CaseInsensitive) then
  Result:=CompareText(TFlxRecord(Item1).Value[TFlxRecord(Item1).ParentList.IndexFieldPos], TFlxRecord(Item1).Value[TFlxRecord(Item2).ParentList.IndexFieldPos]) 
else
    Result:=CompareStr(TFlxRecord(Item1).Value[TFlxRecord(Item1).ParentList.IndexFieldPos], TFlxRecord(Item1).Value[TFlxRecord(Item2).ParentList.IndexFieldPos]) 

end;

procedure TFlxRecordList.Sort;
begin
  inherited Sort(CompareFlxRecords);
  Sorted:=true;
end;

function TFlxRecordList.Find(const aItem:variant ; var Index: integer): boolean;
Var
 L, H, I, C: Integer;
begin
  if not Sorted then Sort;
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    if MemTable.CaseInsensitive then
  C:=CompareText(Items[i].Value[MemTable.IndexFieldPos], aItem)
else
  C:=CompareStr(Items[i].Value[MemTable.IndexFieldPos], aItem);

    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      If C = 0 Then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

