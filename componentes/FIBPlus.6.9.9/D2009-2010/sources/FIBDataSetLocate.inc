{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ InterBase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2007 Devrace Ltd.                       }
{    Written by Serge Buzadzhy (buzz@devrace.com)               }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page: http://www.fibplus.com/                 }
{    FIBPlus support  : http://www.devrace.com/support/         }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}
{$IFDEF FIB_INTERFACE}
   procedure  GetFieldDataPointer(Field:TField;RecNumber:integer; var IsString:boolean;var OutRes:Pointer);

{$ENDIF}

{$IFDEF FIB_IMPLEMENT}



procedure TFIBCustomDataSet.GetFieldDataPointer(Field:TField;RecNumber:integer; var  IsString:boolean;var OutRes:Pointer);
var
   P1:Pointer;
   fi:PFIBFieldDescr;
   fn:Integer;
   c:Currency;
   OutRes1:Pointer;
begin

 case  FCacheModelOptions.CacheModelKind of
   cmkStandard:
   begin
    if FRecordCount<=RecNumber then
     FetchNext(RecNumber-FRecordCount+1);
    if  Unidirectional then
     RecNumber:=RecNumber mod FCacheModelOptions.FBufferChunks
   end;
   cmkLimitedBufferSize:
   begin
     RecNumber:=RecNumber mod FCacheModelOptions.FBufferChunks
   end;
  end;
  fn:=Field.FieldNo;

  if
  (fn<=0) and (not vCalcFieldsSavedCache
    or    not GetBit(PSavedRecordData(FRecordsCache.PRecBuffer(RecNumber+1,False))^.rdFlags,7))
  then
  begin
// NeedRecalcFields
    vInspectRecno:=RecNumber;
    try
      vTypeDispositionField:=dfRRecNumber;
      IsString:=False;
      if not GetFieldData(Field,OutRes) then // ForceCalculate
       OutRes:=nil
      else
      case Field.DataType of
       ftBCD:
       begin
        BCDToCurr(TBcd(OutRes^), c);
       {$IFDEF D6+}
        if TBCDField(Field).Size<=4 then
          PInt64(OutRes)^:=(PInt64(@c)^ div IE10[4-TBCDField(Field).Size])
        else
          PInt64(OutRes)^:=PInt64(@c)^ *IE10[TBCDField(Field).Size-4];
       {$ELSE} // D5
        PCurrency(OutRes)^:=c
       {$ENDIF}  
       end;
      end;
     finally
      vTypeDispositionField:=dfNormal
     end;
  end;


    if fn>0 then
    begin
      fi:=vFieldDescrList.List.List[fn-1];
      IsString:=fi^.fdStrIndex>-1;

      if  IsString then
      begin

       OutRes:=FRecordsCache.GetStringFieldData(RecNumber,fi^.fdStrIndex);
       if PString(OutRes)^='' then
       begin
       // May be null, may be empty str
        P1:=FRecordsCache.PRecBuffer(RecNumber+1,False);
        if PSavedRecordData(P1).rdFields[fn].fdIsNull then
         OutRes:=nil;
       end;
      end
      else
      begin
        OutRes:=FRecordsCache.GetNonStringFieldData(RecNumber,fi^.fdDataOfs-DiffSizesRecData,P1);
        if PSavedRecordData(P1).rdFields[fn].fdIsNull then
         OutRes:=nil;
      end;
    end
    else
    if vCalcFieldsSavedCache then
    begin // Calc
     OutRes1:=FRecordsCache.GetNonStringFieldData(RecNumber, FBlockReadSize+Field.Offset,P1);
     if OutRes1<>nil then
      if not PBoolean(OutRes1)^ then
       OutRes:=nil
      else
      begin
        Inc(PByte(OutRes1),SizeOf(Boolean));
        IsString:=False;

      case Field.DataType of
       ftBCD:
       begin
        BCDToCurr(TBcd(OutRes1^), c);
       {$IFDEF D6+}
        if TBCDField(Field).Size<=4 then
          PInt64(OutRes)^:=(PInt64(@c)^ div IE10[4-TBCDField(Field).Size])
        else
          PInt64(OutRes)^:=PInt64(@c)^ *IE10[TBCDField(Field).Size-4];
       {$ELSE} // D5
        PCurrency(OutRes)^:=c
       {$ENDIF}
       end;
      else
       OutRes:=OutRes1
      end;

      end
    end;
end;


function TFIBCustomDataSet.InternalLocate(const KeyFields: string;
  KeyValues:array of Variant; Options: TExtLocateOptions;FromBegin:boolean = False;
  LocateKind:TLocateKind = lkStandard; ResyncToCenter:boolean =False
  ): Boolean;

type
  TArrow=(arForward,arBackward);
var
  fl: TList;
  fld_cnt: Integer;
  rc,rc1 :Integer;
  Arrow:TArrow;
  vIgnoreRecChecked:boolean;
  RecI: Integer;
  vDisableCalculateFields:boolean;
  vSortInfos     : array of TSortFieldInfo;
  FinishSearch:boolean;
  NowInFetched:boolean;

  s:Ansistring;
  s1:Ansistring;
  ws:WideString;
  ws1:WideString;
  vCalcBuffer:PAnsiChar;
  
function IsVisibleRecord:boolean;
var
 vBuff:dbPChar;
begin

  if drsInMoveRecord in FRunState then
  begin
   Result := True;
   Exit;
  end;

  if Filtered then
  begin
   vBuff:=AllocRecordBuffer;
   try
    FCurrentRecord:=RecI;
    ReadRecordCache(RecI, vBuff, False);
    Result:=IsVisible(PRecordData(vBuff));
   finally
    FreeMem(vBuff);
   end;
  end
  else
  if FCacheModelOptions.FCacheModelKind=cmkStandard then
  begin
    if UniDirectional then
     vBuff :=FRecordsCache.PRecBuffer((RecI mod BufferChunks) +1,False)-DiffSizesRecData
    else
     vBuff :=FRecordsCache.PRecBuffer(RecI+1,False)-DiffSizesRecData;
    Result:=IsVisibleStat(PRecordData(vBuff));
  end
  else
    Result:=True;  
end;


procedure AdjustOrders(L, R: Integer);
var
  I, J: Integer;
  P: Integer;
  T: TSortFieldInfo;
  P1:Pointer;
  v :Variant;
begin
  repeat
    I := L;
    J := R;
    P := vSortInfos[(L + R) shr 1].InOrderIndex;
    repeat
      while vSortInfos[I].InOrderIndex< P do
        Inc(I);
      while vSortInfos[J].InOrderIndex> P do
        Dec(J);
      if I <= J then
      begin
        if I<>J then
        begin
          T := vSortInfos[I];
          vSortInfos[I] := vSortInfos[J];
          vSortInfos[J] := T;
          P1:=fl.List^[I];
          fl.List^[I]:=fl.List^[J];
          fl.List^[J]:=P1;
          v :=KeyValues[I];
          KeyValues[I]:=KeyValues[J];
          KeyValues[J]:=v;
        end;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      AdjustOrders( L, J);
    L := I;
  until I >= R;
end;

function  InitSortInfos:boolean;
var
   i:integer;
   NeedAdjustOrder:boolean;
   vCallAsSorted:boolean;
begin
  vCallAsSorted:=eloInSortedDS in Options;
  if not vCallAsSorted then
  begin
    Result := False;
    Exit;
  end; 
    
  NeedAdjustOrder:=False;
  SetLength(vSortInfos,fld_cnt);
  for i:=0 to fld_cnt-1 do
  begin
   if IsSortedField(TField(fl.List^[i]),vSortInfos[i]) then
   begin
    if vSortInfos[i].InOrderIndex<>Succ(i) then
       NeedAdjustOrder:=True;
   end
   else
   begin
     Result := False;
     Exit;
   end;
  end;

  if NeedAdjustOrder then
  begin
   AdjustOrders(0,fld_cnt-1);
  end;

  for i:=0 to fld_cnt-1 do
   if (vSortInfos[i].InOrderIndex<>Succ(i)) or
    ((TField(fl.List^[i]).DataType in [ftString,ftWideString,ftGuid]) and
      not (vCallAsSorted and not (eloCaseInsensitive in Options))
    )
   then
   begin
     Result := False;
     Exit;
   end;
  Result:=True;
end;

procedure  AdjustKeys;
var
      i:integer;
      CalcSize:integer;
begin
  vDisableCalculateFields:=True;
  CalcSize:=0;
  for i:=Pred(fl.Count) downto 0 do
  begin

     if TField(fl.List^[i]).FieldKind in [fkCalculated, fkLookup] then
     begin
        vDisableCalculateFields := False;
        Inc(CalcSize,TField(fl.List^[i]).DataSize)
     end;
     if VarIsNull(KeyValues[i]) or VarIsEmpty(KeyValues[i]) then
     begin
       KeyValues[i]:=null;
       Continue
     end
     else
     if VarType(KeyValues[i])= varBoolean then
      if KeyValues[i] then
       KeyValues[i]:=1
      else
       KeyValues[i]:=0;

     case TField(fl.List^[i]).DataType  of
      ftString  :
      begin
       if ((TField(fl.List^[i]).Size+1=TField(fl.List^[i]).DataSize) and
          (TField(fl.List^[i]).FieldKind=fkData))
        or
        ( not (TField(fl.List^[i]) is TFIBStringField) or not TFIBStringField(TField(fl.List^[i])).FNeedUnicodeConvert)
       then
       begin
//Non Unicode Field
         if eloCaseInsensitive in Options then
          KeyValues[i]:=AnsiUpperCase(KeyValues[i])
         else
          KeyValues[i]:=VarAsType(KeyValues[i],varString);
       end
       else
       begin
         if eloCaseInsensitive in Options then
         begin
          KeyValues[i]:=WideUpperCase(KeyValues[i]);
         end
         else
         begin
          KeyValues[i]:=VarAsType(KeyValues[i],varOleStr);
          if Options-[eloInFetchedRecords,eloInSortedDS]=[] then
          begin
           KeyValues[i]:=Utf8Encode(KeyValues[i]) // Будем сравнивать  UTF8 strings.
          end
         end
       end
      end;
      ftSmallint: KeyValues[i]:=VarAsType(KeyValues[i],varSmallInt);
      ftInteger : KeyValues[i]:=VarAsType(KeyValues[i],varInteger);
      ftBoolean : KeyValues[i]:=VarAsType(KeyValues[i],varByte);
      ftFloat   : KeyValues[i]:=VarAsType(KeyValues[i],varDouble);
      ftCurrency: KeyValues[i]:=VarAsType(KeyValues[i],varCurrency);
      ftWideString://,ftString :
      begin
       if Database.NeedUnicodeFieldsTranslation then
       begin
         if eloCaseInsensitive in Options then
         begin
          KeyValues[i]:=WideUpperCase(KeyValues[i]);
         end
         else
         begin
          KeyValues[i]:=VarAsType(KeyValues[i],varOleStr);
          if Options-[eloInFetchedRecords,eloInSortedDS]=[] then
          begin
           KeyValues[i]:=Utf8Encode(KeyValues[i]) // Будем сравнивать  UTF8 strings.
          end
         end
       end
       else
       begin
         if eloCaseInsensitive in Options then
           KeyValues[i]:=AnsiUpperCase(KeyValues[i])
         else
          KeyValues[i]:=VarAsType(KeyValues[i],varString);
       end
      end;
      {$IFDEF D6+}
      ftLargeint   : KeyValues[i]:=VarAsType(KeyValues[i],varInt64);
      {$ELSE}
      ftLargeint   : KeyValues[i]:=VarAsType(KeyValues[i],varInteger);
      {$ENDIF}
      ftBCD        :
       {$IFDEF D6+}
        if TField(fl.List^[i]).Size=0 then
         KeyValues[i]:=VarAsType(KeyValues[i],varInt64)
        else
         KeyValues[i]:=VarAsType(KeyValues[i]*E10[TField(fl.List^[i]).Size],varInt64);
       {$ELSE}
        ;
       {$ENDIF}
      ftTime:
      begin
       KeyValues[i]:= VarAsType(KeyValues[i],varDate);
       KeyValues[i]:= DateTimeToTimeStamp(KeyValues[i]).Time
      end   ;
      ftDate:
      begin
       KeyValues[i]:= VarAsType(KeyValues[i],varDate);
       KeyValues[i]:= DateTimeToTimeStamp(KeyValues[i]).Date
      end;
      ftDateTime:
      begin
       KeyValues[i]:=VarAsType(KeyValues[i],varDate);
      end;
      ftGuid:
        KeyValues[i]:=VarAsType(KeyValues[i],varString);
     end;
  end;
  if CalcSize>0 then
   GetMem(vCalcBuffer,CalcSize)
  else
   vCalcBuffer:=nil
end;


procedure IsFinishSearch;
begin
  case LocateKind of
   lkStandard,lkNext:
   begin
     if FCacheModelOptions.FCacheModelKind=cmkStandard then
     begin
      FinishSearch:=RecI>=FRecordCount;
      if FinishSearch and not (eloInFetchedRecords in Options) then
        FinishSearch:=FetchNext(1)=0;
     end
     else
     begin
      FinishSearch:=RecI>vPartition.EndPartRecordNo
     end;
   end;
   lkPrior:
   begin
    if FCacheModelOptions.FCacheModelKind=cmkStandard then
     FinishSearch:=RecI<0
    else
     FinishSearch:=RecI<vPartition.BeginPartRecordNo
   end;
  end;
end;


function CompareStrAA(const  S1:Ansistring;const S2: AnsiString): Integer;
begin
//  Result :=CompareStr(S1,S2)
   if S1<>S2 then
    Result:=1
   else
    Result:=0
end;


function CompareValues:boolean;
var
  i:integer;
  p:Pointer;
  vIsString:boolean;
  L:integer;
  dt:TDateTime;
  cResult:shortInt;
  inS:boolean;
  inWS:boolean;
  ts:TTimeStamp;
  fi:PFIBFieldDescr;
  dv:Double;
  fn:Integer;  
 {$IFNDEF D6+}
  tempCurrency:Currency;
 {$ENDIF}
  function UDFCompStr(const s:Ansistring):integer;
  begin
   Result:=CompareFieldValues(TField(fl.List^[i]),KeyValues[i],s )
  end;

  function UDFCompWideStr(const s:Widestring):integer;
  begin
   Result:=CompareFieldValues(TField(fl.List^[i]),ws1,s )
  end;

begin
      i := 0; cResult:=0;
      Result := True;
      Arrow :=arForward;
      while (Result  and (i < fld_cnt)) do
      begin
        inS:=False;
        inWS:=False;
        p:=vCalcBuffer;
        GetFieldDataPointer(TField(fl.List^[i]),RecI,vIsString,p);
        fn:=TField(fl.List^[i]).FieldNo;
        if fn>=1 then
         fi:=vFieldDescrList[fn-1]
        else
         fi:=nil;
       {$IFNDEF D6+}
         if (TField(fl.List^[i]).DataType=ftBCD) and (fn>=1) then
         if p<>nil then
         begin
          tempCurrency:=PComp(p)^*E10[-TBCDField(fl.List^[i]).Size];
          p:=@tempCurrency;
         end;
       {$ENDIF}


        if TVarData(KeyValues[i]).VType = varNull then // Мы уже прокастили. varByRef or varVariant не могут быть
        begin
          if p=nil then
          begin
            Inc(i);
            Continue;
          end
          else
          begin
            Result := False;
            if (eloInSortedDS in Options) then
             if FIsClientSorting then
              Arrow:=TArrow(vSortInfos[i].Asc)
             else
              Arrow:=TArrow(vSortInfos[i].NullsFirst);
            Exit;
          end;
        end
        else
        begin
          if p=nil then
          begin
            Result := False;
            if (eloInSortedDS in Options) then
             if FIsClientSorting then
              Arrow:=TArrow(not vSortInfos[i].Asc)
             else
              Arrow:=TArrow(not vSortInfos[i].NullsFirst);
            Exit;
          end;
        end;

        if Result then
        begin
          if (TField(fl.List^[i]).DataType = ftString)
// and not DataBase.NeedUnicodeFieldTranslation(Byte(fi^.fdSubType))
           or ((TField(fl.List^[i]).DataType = ftWideString)  and
            (not Database.NeedUnicodeFieldsTranslation or (Options-[eloInFetchedRecords,eloInSortedDS]=[])))
          then
          begin
            if Options-[eloInFetchedRecords,eloInSortedDS]=[] then
            begin
             s1:=KeyValues[i];
             if vIsString then
             begin
              if poTrimCharFields in Self.Options then
              begin
                 L:=Length(PAnsiString(p)^);
                 if (L>0) and (PAnsiString(p)^[L]<#33)  then
                 begin
                  while (L>0) and (PAnsiString(p)^[L]<#33) do
                   Dec(L);
                  SetLength(s,L);
                  if L>0 then
                   Move(PAnsiString(p)^[1],s[1],L);
                  inS:=True;
                  Result :=s1=s
                 end
                 else
                 begin
                   Result :=s1=PAnsiString(p)^
                 end
              end
              else
              begin
               Result :=s1=PAnsiString(p)^
              end
             end
             else
             begin
              if (TField(fl.List^[i]).FieldKind=fkData) or (TField(fl.List^[i]).DataType = ftString) then
              begin
                L:=StrScan(PAnsiChar(p),#0)-PAnsiChar(p);
                if L>TField(fl.List^[i]).Size then
                 L:=TField(fl.List^[i]).Size;
                if poTrimCharFields in Self.Options then
                while (L>0) and (PAnsiChar(p)[L-1]<#33) do
                 Dec(L);
                SetString(s,PAnsiChar(p),L);
                Result :=s1=s
              end
              else
              begin
                ws1:=KeyValues[i];
                L:=StrScan(PChar(p),#0)-PChar(p);
                if L>TField(fl.List^[i]).Size then
                 L:=TField(fl.List^[i]).Size;
                if poTrimCharFields in Self.Options then
                while (L>0) and (PChar(p)[L-1]<#33) do
                 Dec(L);
                SetString(ws,PChar(p),L);
                Result :=ws1=ws
              end;

              inS:=True;

             end;
            end
            else
            begin
             inS:=True;
             if vIsString then
             begin
//              s:=PAnsiString(p)^;
              SetString(s,PAnsiChar(PAnsiString(p)^),Length(PAnsiString(p)^));
              if (TField(fl.List^[i]) is TFIBStringField) and
               Database.NeedUnicodeFieldTranslation(Byte(TFIBStringField(fl.List^[i]).SqlSubType))
              then
                s:=UTF8Decode(s)
             end
             else
             begin
              L:=StrScan(PAnsiChar(p),#0)-PAnsiChar(p);
              if L>TField(fl.List^[i]).Size then
               L:=TField(fl.List^[i]).Size;

              if poTrimCharFields in Self.Options then
              while (L>0) and (PAnsiChar(p)[L-1]<#33) do
               Dec(L);
               SetString(s,PAnsiChar(p),L);
             end;
             if (eloPartialKey in Options) then
             begin
              if (eloCaseInsensitive in Options) then
               DoAnsiUpperCase(s);
              Result :=IsBeginPartStrWA(KeyValues[i],s)
{//              Result :=IsBeginPartStrWA(string(TVarData(KeyValues[i]).VString),s)
//              vt:=VarType(KeyValues[i]);
              case VarType(KeyValues[i]) of
                varOleStr:Result :=IsBeginPartStrWA(TVarData(KeyValues[i]).VOleStr,s);
                varString:Result :=IsBeginPartStrWA(string(TVarData(KeyValues[i]).VString),s);
                varUString:Result :=IsBeginPartStrWA(string(TVarData(KeyValues[i]).VUString),s);

//              Result :=IsBeginPartStrWA(KeyValues[i],s)}
//              end
             end
             else
             if  (eloWildCards in Options) then
             begin
              if (eloCaseInsensitive in Options) then
               DoAnsiUpperCase(s);
              Result:= SQLMaskCompareAW(s,string(TVarData(KeyValues[i]).VString))
             end
             else
             begin //eloCaseInsensitive in Options
               Result:=AnsiCompareTextWA(TVarData(KeyValues[i]).VString, @s)=0;
             end
            end
          end // ftString
          else
          if (TField(fl.List^[i]).DataType in  [ftString,ftWideString]) then
          begin
          // Options<>[]
            inWS:=True;
            ws1:=TVarData(KeyValues[i]).VOleStr;
            begin
             if vIsString then
              DoUtf8Decode(PAnsiString(p)^,ws)
             else
             begin
              L:=StrScan(PAnsiChar(p),#0)-PAnsiChar(p);
              if L>TField(fl.List^[i]).DataSize-1 then
               L:=TField(fl.List^[i]).DataSize-1;

              if poTrimCharFields in Self.Options then
              while (L>0) and (PAnsiChar(p)[L-1]<#33) do
               Dec(L);
              SetString(s,PAnsiChar(p),L);
              DoUtf8Decode(s,ws);
             end;

             if (eloPartialKey in Options) then
             begin
              if (eloCaseInsensitive in Options) then
               DoWideUpperCase(ws);
              Result :=IsBeginPartStr(ws1,ws)
             end
             else
             if  (eloWildCards in Options) then
             begin
              if (eloCaseInsensitive in Options) then
               DoWideUpperCase(ws);
              Result:= SQLMaskCompare(ws,ws1)
             end
             else
              if (eloCaseInsensitive in Options) then
              {$IFDEF D6+}
               Result:=WideCompareText(ws,ws1)=0 //eloCaseInsensitive in Options
              {$ELSE}
               Result:=ws=ws1
              {$ENDIF}

            end
          end       // ftWideString
          else
          begin
           // Non string fields compare
              case TField(fl.List^[i]).DataType of
               ftSmallInt:
                begin
                   if PSmallInt(P)^=TVarData(KeyValues[i]).VSmallInt then
                    cResult:=0
                   else
                   if PSmallInt(P)^>TVarData(KeyValues[i]).VSmallInt then
                    cResult:=1
                   else
                    cResult:=-1;
                end;
               ftInteger,ftDate,ftTime:
               begin
                 if PInteger(P)^=TVarData(KeyValues[i]).VInteger then
                  cResult:=0
                 else
                 if PInteger(P)^>TVarData(KeyValues[i]).VInteger then
                  cResult:=1
                 else
                  cResult:=-1;
               end;
               ftFloat  :
               begin
                 if fi=nil then
                 begin
                   if Abs(PDouble(P)^-TVarData(KeyValues[i]).VDouble)<1E-11  then
                    cResult:=0
                   else
                   if PDouble(P)^>TVarData(KeyValues[i]).VDouble then
                    cResult:=1
                   else
                    cResult:=-1;
                 end
                 else
                 begin
                  case fi^.fdDataType of
                   SQL_FLOAT:
                     dv:=PSingle(P)^;
                   SQL_LONG :
                     dv:=PLong(P)^*E10[fi^.fdDataScale];
                   SQL_SHORT:
                     dv:=PShort(P)^*E10[fi^.fdDataScale]
                  else
                   dv:=PDouble(P)^
                  end;

                   if Abs(dv-TVarData(KeyValues[i]).VDouble)<1E-11  then
                    cResult:=0
                   else
                   if dv>TVarData(KeyValues[i]).VDouble then
                    cResult:=1
                   else
                    cResult:=-1;
                 end
               end;

               ftBCD    :
               begin
               {$IFNDEF D6+}
               // Приведения варианта к правильному типу не было
                cResult :=ComparePCurrencyAndVariant(p,KeyValues[i]);
               {$ELSE}
                if Int64(P^)=TVarData(KeyValues[i]).VInt64 then
                 cResult:=0
                else
                if Int64(P^)>TVarData(KeyValues[i]).VInt64 then
                 cResult:=1
                else
                 cResult:=-1;
               {$ENDIF}
               end;
               ftBoolean:
               begin
                if Byte(P^)=TVarData(KeyValues[i]).VByte then
                 cResult:=0
                else
                if Byte(P^)>TVarData(KeyValues[i]).VByte then
                 cResult:=1
                else
                 cResult:=-1;
               end;
               ftDateTime :
               begin
                ts:=MSecsToTimeStamp(PDouble(P)^);
    //            ts.Time:=(ts.Time div 1000)*1000; // TDateTime миллисекунды не держит
                dt:=TimeStampToDateTime(ts);
                if dt=TVarData(KeyValues[i]).VDate then
                 cResult:=0
                else
                if dt>TVarData(KeyValues[i]).VDate then
                 cResult:=1
                else
                 cResult:=-1

//                cResult :=ComparePDateAndVariant(@dt,KeyValues[i])
               end   ;
               ftLargeint:
               {$IFDEF D6+}
                if Int64(P^)=TVarData(KeyValues[i]).VInt64 then
                 cResult:=0
                else
                if Int64(P^)>TVarData(KeyValues[i]).VInt64 then
                 cResult:=1
                else
                 cResult:=-1;
               {$ELSE}
                if Int64(P^)=TVarData(KeyValues[i]).VInteger then
                 cResult:=0
                else
                if Int64(P^)>TVarData(KeyValues[i]).VInteger then
                 cResult:=1
                else
                 cResult:=-1;
               {$ENDIF}

               ftGuid:
               begin
                s:=Ansistring(TVarData(KeyValues[i]).VString);
                cResult :=CompareStrAndGuid(P,s);
               end;
              end; 
              Result:=cResult=0
            end;
          end;

         if not Result and (eloInSortedDS in Options) then
         begin
         // for sorted
          case TField(fl.List^[i]).DataType of
           ftString    :
           begin
            if not InS then
//             s:=PAnsiString(p)^;
             SetString(s,PAnsiChar(PAnsiString(p)^),Length(PAnsiString(p)^));
             if eloCaseInsensitive in Options then
              DoAnsiUppercase(s);
             Arrow:=TArrow(vSortInfos[i].Asc xor  (UDFCompStr(s)>0))
           end;
           ftWideString:
           begin
            if not InWs then
            begin
             DoUtf8Decode(KeyValues[i],ws1);
             if InS then
              DoUtf8Decode(s,ws)
             else
              DoUtf8Decode(PAnsiString(p)^,ws);
            end;
             if eloCaseInsensitive in Options then
              DoWideUppercase(ws);
              Arrow:=TArrow(vSortInfos[i].Asc xor  (UDFCompWideStr(ws)>0))
           end;
          else
           Arrow:=TArrow(vSortInfos[i].Asc xor (cResult< 0));
          end  ;
          Exit;
        end;
        Inc(i);
      end;

end;

procedure FindFirst;
var
   GoodRec:Integer;
   sRecI  :Integer;
begin
  // Уже нашли запись по сортированному датасету
  // Позиционируемся на первую удовлетворяющую условию.
  if (LocateKind<>lkStandard) or not (eloInSortedDS in Options) then
    Exit;
  sRecI:=RecI;
  if IsVisibleRecord and (RecI+1<>vIgnoreLocReno) then
   GoodRec:=RecI
  else
   GoodRec:=-1;
  while Result and (RecI>0)  do
  begin
   Dec(RecI);
   if IsVisibleRecord and (RecI+1<>vIgnoreLocReno)  then
   begin
    Result:=CompareValues;
    if Result then
     GoodRec:=RecI;
   end;
  end;
  if GoodRec>-1 then
  begin
    RecI:=GoodRec;
    Result := True;
    Exit;
  end
  else
  begin
   RecI:=sRecI;
   Result := True;
   while Result and(RecI<FRecordCount-1) do
   begin
    Inc(RecI);     
    if IsVisibleRecord and (RecI+1<>vIgnoreLocReno) then
    begin
      Result:=CompareValues;
      if Result then
      begin
       GoodRec:=RecI;
       Break
      end;
    end;
   end;
   if GoodRec>-1 then
   begin
    RecI:=GoodRec;
    Result := True;
   end
   else
    Result :=False
  end;
end;

begin
  CheckActive;
  Result := False;
  if IsEmpty then
   Exit;
  rc:=-1;
  rc1:=-1;
  if State in [dsEdit,dsInsert] then
   Post;
  NowInFetched:=True;
  vIgnoreRecChecked  :=False;
  fl := TList.Create;
  try
    GetFieldList(fl, KeyFields);
    fld_cnt     := fl.Count;
//    SetLength(wsA,fl.Count);
    if fl.Count=0 then
     Exit;


    Result      := False;

    AdjustKeys;
    if InitSortInfos then
      Include(Options,eloInSortedDS)   // Force use SortInfo
    else
      Exclude(Options,eloInSortedDS); // SortInfo not Valid

    if vDisableCalculateFields then
      DisableCalcFields;
    if FromBegin then
    begin
     if FCacheModelOptions.FCacheModelKind=cmkStandard then
      RecI := 0
     else
      RecI :=vPartition.BeginPartRecordNo;
     if RecI+1=vIgnoreLocReno then
     begin
       Inc(RecI);
       if RecI >= FRecordCount then
         Exit;
     end;
    end
    else
    case LocateKind of
     lkNext :
     begin
      RecI :=GetRealRecNo;
      if RecI+1=vIgnoreLocReno then
       Inc(RecI);

      if RecI >= FRecordCount then
      begin
       if FetchNext(RecI-FRecordCount+1)<RecI-FRecordCount+1 then
        Exit;
      end;
     end;
     lkPrior:
     begin
      RecI :=GetRealRecNo-2;
      if RecI+1=vIgnoreLocReno then
       Dec(RecI);
     end;
     lkStandard:RecI :=0;
    end;
    if RecI >= FRecordCount then
     RecI := FRecordCount-1;
    if (eloInSortedDS in Options) then
    begin
      Result:= CompareValues;

      if  not Result then
      begin
        case LocateKind of
         lkStandard,lkNext :
            if Arrow=arBackward then
                   Exit;
         lkPrior: if Arrow=arForward then
                    Exit;
        end;
        RecI:=FRecordCount-1;
        if (RecI+1=vIgnoreLocReno) then
        if RecI=0 then
         Exit // Единственная запись и та не подходит
        else
        begin
          Dec(RecI); // Последняя запись и она должна игнорироваться
          vIgnoreRecChecked:=True
        end;
        Result:=CompareValues;
      end;
      if Result then
      begin
        FindFirst;
        Exit;
      end;

      if Arrow=arForward then
      begin
//     Data no fetched yet
       NowInFetched:=False;
       RecI:=FRecordCount;
       if (eloInFetchedRecords in Options) or (FetchNext(1)= 0) then
        Exit;
      end
      else
      begin
       rc1:=RecI;
       RecI:=0;
       if (vIgnoreLocReno=1) then
        if  not vIgnoreRecChecked  then
        begin
         Inc(RecI);
         vIgnoreRecChecked:=True
        end;
        rc:=RecI
      end;
    end;

    IsFinishSearch;

    while (not Result) and not FinishSearch do
    begin
      if (eloInSortedDS in Options) and NowInFetched then
      begin
       if rc=vIgnoreLocReno then
        Inc(rc);
       if rc1=vIgnoreLocReno then
        Dec(rc1);
       if  (rc>rc1) then
        Break;

       RecI:=((rc1+rc) div 2);
       if (RecI+1=vIgnoreLocReno) then
       begin
         if  vIgnoreRecChecked then
          Exit
         else
         begin
          Inc(RecI);
          vIgnoreRecChecked:=True
         end;
       end;
      end;
      Result:=CompareValues;

      if Result then
      begin
       if (eloInSortedDS in Options) then
       begin
        FindFirst;
        Exit;
       end
       else
        Result:=IsVisibleRecord;
      end;

      if not Result then
       if (eloInFetchedRecords in Options) then
       begin
         case LocateKind of
          lkStandard,lkNext:
          begin
           Inc(RecI);
           IsFinishSearch;
          end;
          lkPrior:
          begin
           Dec(RecI);
           IsFinishSearch;
          end;
         end;
       end
       else
       if not (eloInSortedDS in Options) then
       begin
        if LocateKind=lkPrior then
        begin
           Dec(RecI);
           IsFinishSearch;
        end
        else
        begin
          Inc(RecI);
          IsFinishSearch;
        end;
       end
       else
// eloInSortedDS in Options
       if NowInFetched then
       begin
         case Arrow of
         arForward :
             begin
              if rc=RecI+1 then
                Break
              else
               rc:=RecI+1;
             end;
         else
          if rc1=RecI-1 then
           Break
          else
           rc1:=RecI-1;
         end
       end
       else
       begin
        case Arrow of
         arForward :
         begin
          Inc(RecI);
          IsFinishSearch;
         end;
         arBackward:
          Break
        end
       end
    end;

  finally
    fl.Free;
    FreeMem(vCalcBuffer);
    if vDisableCalculateFields then
      EnableCalcFields;

    if Result then
    begin
       SetRealRecno(RecI+1,ResyncToCenter);
       CursorPosChanged;
    end
    else
    if (eloNearest in Options) and (eloInSortedDS in Options)
    then
    begin
       if  (Arrow=arForward) then
        SetRealRecno(RecI+2,ResyncToCenter)
       else
        SetRealRecno(RecI+1,ResyncToCenter);
       CursorPosChanged;
    end;
  end;
end;



{$ENDIF}
