//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  Do not modify by hand                                                             //
//************************************************************************************//

function TFlxMasterList.GetItems(index: integer): TFlxRecordList;
begin
  Result := TFlxRecordList (inherited Items[Index]);
end;

procedure TFlxMasterList.SetItems(index: integer; const Value: TFlxRecordList);
begin
  inherited Items[Index] := Value;
end;

function TFlxMasterList.Add(aRecord: TFlxRecordList):integer;
begin
  Result:=inherited Add(aRecord);
  Sorted:=false;  //When we add the list gets unsorted
end;

procedure TFlxMasterList.Insert(Index: Integer; ARecord:TFlxRecordList);
begin
  inherited Insert(Index, ARecord);
  // We assume that when we insert, we respect the order, so we dont set Sorted=true
end;

function CompareMasterRecords(Item1, Item2: Pointer): Integer;
begin
  if TFlxRecordList(Item1).ListName < TFlxRecordList(Item2).ListName then Result:=-1 else if TFlxRecordList(Item1).ListName > TFlxRecordList(Item2).ListName then Result:=1 else Result:=0;
end;

procedure TFlxMasterList.Sort;
begin
  inherited Sort(CompareMasterRecords);
  Sorted:=true;
end;

function TFlxMasterList.Find(const aItem:widestring ; var Index: integer): boolean;
Var
 L, H, I, C: Integer;
 V: widestring;
begin
  if not Sorted then Sort;
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    V:=Items[i].ListName;
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

