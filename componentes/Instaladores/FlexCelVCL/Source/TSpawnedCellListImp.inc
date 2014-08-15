//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TSpawnedCellList.GetItems(index: integer): TSpawnedCell;
begin
  Result := TSpawnedCell (inherited Items[Index]);
end;

procedure TSpawnedCellList.SetItems(index: integer; const Value: TSpawnedCell);
begin
  inherited Items[Index] := Value;
end;

function TSpawnedCellList.Add(aRecord: TSpawnedCell):integer;
begin
  Result:=inherited Add(aRecord);
  Sorted:=false;  //When we add the list gets unsorted
end;

procedure TSpawnedCellList.Insert(Index: Integer; ARecord:TSpawnedCell);
begin
  inherited Insert(Index, ARecord);
  // We assume that when we insert, we respect the order, so we dont set Sorted=true
end;

function CompareSapwnedCells(Item1, Item2: Pointer): Integer;
begin
  if TSpawnedCell(Item1).RowCol < TSpawnedCell(Item2).RowCol then Result:=-1 else if TSpawnedCell(Item1).RowCol > TSpawnedCell(Item2).RowCol then Result:=1 else Result:=0;
end;

procedure TSpawnedCellList.Sort;
begin
  inherited Sort(CompareSapwnedCells);
  Sorted:=true;
end;

function TSpawnedCellList.Find(const aItem:int64 ; var Index: integer): boolean;
Var
 L, H, I, C: Integer;
 V: int64;
begin
  if not Sorted then Sort;
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    V:=Items[i].RowCol;
    if V < aItem then C:=-1 else if V > aItem then C:=1 else C:=0;
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

