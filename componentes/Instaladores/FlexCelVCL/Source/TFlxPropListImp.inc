//************************************************************************************//
//  File created automatically by GenerateRecords.xls                                 //
//  modified by hand                                                             //
//************************************************************************************//

function TFlxPropList.GetItems(index: string): variant;
var
  idx: integer;
begin
  if Find(index, idx) then Result:= (inherited items[idx] as TFlxProp).Value
  else Result := unassigned;
end;

procedure TFlxPropList.SetItems(index: string; const Value: variant);
var
  idx: integer;
begin
  if Find(index, idx) then
    if VarIsEmpty(Value) then delete(idx) else (inherited items[idx] as TFlxProp).Value:=Value
  else
    if not VarIsEmpty(Value) then Add(TFlxProp.Create(index, Value));
end;

function TFlxPropList.Add(aRecord: TFlxProp):integer;
begin
  Result:=inherited Add(aRecord);
  Sorted:=false;  //When we add the list gets unsorted
end;

procedure TFlxPropList.Insert(Index: Integer; ARecord:TFlxProp);
begin
  inherited Insert(Index, ARecord);
  // We assume that when we insert, we respect the order, so we dont set Sorted=true
end;

function CompareFlxProps(Item1, Item2: Pointer): Integer;
begin
  if Uppercase(TFlxProp(Item1).Name) < Uppercase(TFlxProp(Item2).Name) then Result:=-1 else if Uppercase(TFlxProp(Item1).Name) > UpperCase(TFlxProp(Item2).Name) then Result:=1 else Result:=0;
end;

procedure TFlxPropList.Sort;
begin
  inherited Sort(CompareFlxProps);
  Sorted:=true;
end;

function TFlxPropList.Find(const aItem:string ; var Index: integer): boolean;
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
    if UpperCase((inherited items[i] as TFlxProp).Name) < UpperCase(aItem) then C:=-1 else if UpperCase((inherited items[i] as TFlxProp).Name)>UpperCase(aItem) then C:=1 else C:=0;
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

