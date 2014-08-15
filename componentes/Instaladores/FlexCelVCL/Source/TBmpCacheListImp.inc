//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TBmpCacheList.GetItems(index: integer): TBmpCache;
begin
  Result := TBmpCache (inherited Items[Index]);
end;

procedure TBmpCacheList.SetItems(index: integer; const Value: TBmpCache);
begin
  inherited Items[Index] := Value;
end;

function TBmpCacheList.Add(aRecord: TBmpCache):integer;
begin
  Result:=inherited Add(aRecord);
  Sorted:=false;  //When we add the list gets unsorted
end;

procedure TBmpCacheList.Insert(Index: Integer; ARecord:TBmpCache);
begin
  inherited Insert(Index, ARecord);
  // We assume that when we insert, we respect the order, so we dont set Sorted=true
end;

function CampareBmpCache(Item1, Item2: Pointer): Integer;
begin
  if TBmpCache(Item1).PageNo < TBmpCache(Item2).PageNo then Result:=-1 else if TBmpCache(Item1).PageNo > TBmpCache(Item2).PageNo then Result:=1 else Result:=0;
end;

procedure TBmpCacheList.Sort;
begin
  inherited Sort(CampareBmpCache);
  Sorted:=true;
end;

function TBmpCacheList.Find(const aItem:integer ; var Index: integer): boolean;
Var
 L, H, I, C: Integer;
 V: integer;
begin
  if not Sorted then Sort;
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    V:=Items[i].PageNo;
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

