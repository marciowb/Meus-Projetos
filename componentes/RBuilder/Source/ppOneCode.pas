{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }


{******************************************************************************}
{
  This unit is Copyright Digital Metaphors Corporation, all rights reserverd

******************************************************************************}

{

  This unit is a derivative work of OneCode.cs, which is open source licensed
  under the Apache License, version 2.0.

  OneCode.cs
  Copyright 2007 Vassilis Petroulias [DRDigit]

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
                                                                               }
{******************************************************************************}

unit ppOneCode;

interface

uses
  SysUtils;

type

{

  Intelligent Mail BarCode Specification:

  https://ribbs.usps.gov/intelligentmail_mailpieces/documents/tech_guides/SPUSPS-B-3200E001.pdf

  Intelligent Mail BarCode Format:

  ------------------------------------------------------------------------------
  Type            Field                    Digits                     Example
  -------------   -------                  --------------             ----------
  Tracking Code	  Barcode Identifier	     2 (2nd digit must be 0–4)  01
                  Special Services	       3	                        234
                  Customer Identifier	     6	                        567094
                  Sequence Number	         9	                        987654321
  Routing Code	  Delivery Point ZIP Code	 0, 5, 9, or 11	            01234567891
  ------------------------------------------------------------------------------

  Complete string from data above:

  0123456709498765432101234567891

  Output is the Encoded Data

  AADTFFDFTDADTAADAATFDTDDAAADDTDTTDAFADADDDTFFFDDTTTADFAAADFTDAADA

  The output describes a 4 state bar code:

  F - Full bar
  T - Tracker (short bar with no ascender or descender)
  A - Ascender
  D - Descender



Test 1 - no routing
--------------------------------------------------------
01234567094987654321

ATTFATTDTTADTAATTDTDTATTDAFDDFADFDFTFFFFFTATFAAAATDFFTDAADFTFDTDT

Test 2 - 5 digit routing
--------------------------------------------------------
0123456709498765432101234

DTTAFADDTTFTDTFTFDTDDADADAFADFATDDFTAAAFDTTADFAAATDFDTDFADDDTDFFT

Test 3 - 9 digit routing
--------------------------------------------------------

01234567094987654321012345678

ADFTTAFDTTTTFATTADTAAATFTFTATDAAAFDDADATATDTDTTDFDTDATADADTDFFTFA

Test 4 - 11 digit routing
--------------------------------------------------------
0123456709498765432101234567891

AADTFFDFTDADTAADAATFDTDDAAADDTDTTDAFADADDDTFFFDDTTTADFAAADFTDAADA

}


  TppIntegerArray = array of Integer;
  TppCodeWordArray = array of array of Int64;

  TppOneCode = class
  private
    FCodewordArray: TppCodeWordArray;
    FEntries2Of13: Int64;
    FEntries5Of13: Int64;
    FTable2Of13: TppIntegerArray;
    FTable2Of13Size: Integer;
    FTable5Of13Size: Integer;
    FTable5Of13: TppIntegerArray;

    function EncodeData(aSource: String): String;
    function OneCodeInfo(aTopic: Byte): TppIntegerArray; overload;
    function OneCodeInfo: TppCodeWordArray; overload;
    function OneCodeInitializeNof13Table(aAi: TppIntegerArray; aI, aJ: Integer): Boolean;
    function OneCodeMathAdd(aByteArray: TppIntegerArray; aI, aJ: Integer): Boolean;
    function OneCodeMathDivide(aValue: String): Boolean;
    function OneCodeMathFcs(aByteArray: TppIntegerArray): Integer;
    function OneCodeMathMultiply(aByteArray: TppIntegerArray; aI, aJ: Integer): Boolean;
    function OneCodeMathReverse(aValue: Integer): Integer;
    function TrimOff(aSource, aBad: String): String;

    constructor Create;

  public
    class function Bars(aSource: String): String;
  end;


implementation

const
  cBarTopCharIndexArray: array[0..64] of Integer = (4, 0, 2, 6, 3, 5, 1, 9, 8, 7, 1, 2, 0, 6, 4, 8, 2, 9, 5, 3, 0, 1, 3, 7, 4, 6, 8, 9, 2, 0, 5, 1, 9, 4, 3, 8, 6, 7, 1, 2, 4, 3, 9, 5, 7, 8, 3, 0, 2, 1, 4, 0, 9, 1, 7, 0, 2, 4, 6, 3, 7, 1, 9, 5, 8);
  cBarBottomCharIndexArray: array[0..64] of Integer = (7, 1, 9, 5, 8, 0, 2, 4, 6, 3, 5, 8, 9, 7, 3, 0, 6, 1, 7, 4, 6, 8, 9, 2, 5, 1, 7, 5, 4, 3, 8, 7, 6, 0, 2, 5, 4, 9, 3, 0, 1, 6, 8, 2, 0, 4, 5, 9, 6, 7, 5, 2, 6, 3, 8, 5, 1, 9, 8, 7, 4, 0, 2, 6, 3);
  cBarTopCharShiftArray: array[0..64] of Integer = (3, 0, 8, 11, 1, 12, 8, 11, 10, 6, 4, 12, 2, 7, 9, 6, 7, 9, 2, 8, 4, 0, 12, 7, 10, 9, 0, 7, 10, 5, 7, 9, 6, 8, 2, 12, 1, 4, 2, 0, 1, 5, 4, 6, 12, 1, 0, 9, 4, 7, 5, 10, 2, 6, 9, 11, 2, 12, 6, 7, 5, 11, 0, 3, 2);
  cBarBottomCharShiftArray: array[0..64] of Integer = (2, 10, 12, 5, 9, 1, 5, 4, 3, 9, 11, 5, 10, 1, 6, 3, 4, 1, 10, 0, 2, 11, 8, 6, 1, 12, 3, 8, 6, 4, 4, 11, 0, 6, 1, 9, 11, 5, 3, 7, 3, 10, 7, 11, 8, 2, 10, 3, 5, 8, 0, 3, 12, 11, 8, 4, 5, 1, 3, 0, 7, 12, 9, 8, 10);


{------------------------------------------------------------------------------}
{ TppOneCode.Create }

constructor TppOneCode.Create;
begin
  inherited;

  FTable2Of13Size := 78;
  FTable5Of13Size := 1287;

  FTable2Of13 := OneCodeInfo(1);
  FTable5Of13 := OneCodeInfo(2);
  FCodewordArray := OneCodeInfo();


end;

{------------------------------------------------------------------------------}
{ TppOneCode.Bars }

class function TppOneCode.Bars(aSource: String): String;
var
  lOneCode: TppOneCode;
begin

  Result := '';

  lOneCode := TppOneCode.Create;

  try
    Result := lOneCode.EncodeData(aSource);
  finally
    lOneCode.Free;
  end;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.EncodeData }

function TppOneCode.EncodeData(aSource: String): String;
var
  liFcs: Integer;
  liL: Int64;
  ldV: Int64;
  lsEncoded: String;
  lsDs: String;
  lsZip: String;
  lByteArray: TppIntegerArray;
  lAi: TppIntegerArray;
  lAi1: TppIntegerArray;
  liIndex: Integer;
  lAd: TppCodeWordArray;
begin

  Result := '';

  if (aSource = '') then Exit;

  // remove spaces, '-' and '.'s
  aSource := TrimOff(aSource, ' -.');

  // if (!Regex.IsMatch(source, "^[0-9][0-4]([0-9]{18})|([0-9]{23})|([0-9]{27})|([0-9]{29})$")) return String.Empty;

  lsEncoded := '';
  lsDs := '';

  lsZip := Copy(aSource, 21, Length(aSource));

  SetLength(lByteArray, 14);
  SetLength(lAi, 66);
  SetLength(lAi1, 66);

  SetLength(lAd, 11);

  liL := StrToIntDef(lsZip, 0);

  if (Length(lsZip) = 5) then
    liL := liL + 1
  else if (Length(lsZip) = 9) then
    liL := liL + 100001
  else if (Length(lsZip) = 11) then
    liL := liL + 1000100001;

  ldV := liL * 10 + StrToInt(aSource[1]);
  ldV := ldV * 5 + StrToInt(aSource[2]);

  lsDs := IntToStr(ldv) + Copy(aSource, 3, 18);

  lByteArray[12] := (liL and 255);
  lByteArray[11] := ((liL shr 8) and 255);
  lByteArray[10] := ((liL shr 16) and 255);
  lByteArray[9] := ((liL shr 24) and 255);
  lByteArray[8] := ((liL shr 32) and 255);

  OneCodeMathMultiply(lByteArray, 13, 10);
  OneCodeMathAdd(lByteArray, 13, StrToInt(aSource[1]));
  OneCodeMathMultiply(lByteArray, 13, 5);
  OneCodeMathAdd(lByteArray, 13, StrToInt(aSource[2]));

  for liIndex := 3 to 20 do
    begin
      OneCodeMathMultiply(lByteArray, 13, 10);
      OneCodeMathAdd(lByteArray, 13, StrToInt(aSource[liIndex]));
    end;

  liFcs := OneCodeMathFcs(lByteArray);

  for liIndex := 0 to 9 do
    begin
      FCodewordArray[liIndex][0] := FEntries2Of13 + FEntries5Of13;
      FCodewordArray[liIndex][1] := 0;

    end;
    
  FCodewordArray[0][0] := 659;
  FCodewordArray[9][0] := 636;

  OneCodeMathDivide(lsDs);
  FCodewordArray[9][1] := FCodewordArray[9][1] * 2;

  if ((liFcs shr 10) <> 0) then
    FCodeWordArray[0][1] := FCodeWordArray[0][1] + 659;

  for liIndex := 0 to 9 do
    SetLength(lAd[liIndex], 3);

  for liIndex := 0 to 9 do
    begin
      if (FCodewordArray[liIndex][1] >= (FEntries2Of13 + FEntries5Of13)) then Exit;

      lAd[liIndex][0] := 8192;

      if (FCodewordArray[liIndex][1] >= FEntries2Of13) then
        lAd[liIndex][1] := FTable2Of13[(FCodewordArray[liIndex][1] - FEntries2Of13)]
      else
        lAd[liIndex][1] := FTable5Of13[(FCodewordArray[liIndex][1])]

    end;


  for liIndex := 0 to 9 do
    if ((liFcs and (1 shl liIndex)) <> 0) then
      lAd[liIndex][1] := not (lAd[liIndex][1]) and 8191;

  for liIndex := 0 to 64 do
    begin
      lAi[liIndex] := ((lAd[cBarTopCharIndexArray[liIndex]][1]) shr cBarTopCharShiftArray[liIndex]) and 1;
      lAi1[liIndex] := ((lAd[cBarBottomCharIndexArray[liIndex]][1]) shr cBarBottomCharShiftArray[liIndex]) and 1;
    end;

  lsEncoded := '';

  for liIndex := 0 to 64 do
    if (lAi[liIndex] = 0) then
      begin
        if (lAi1[liIndex] = 0) then
          lsEncoded := lsEncoded + 'T'
        else
          lsEncoded := lsEncoded + 'D';
      end
    else
      begin
        if (lAi1[liIndex] = 0) then
          lsEncoded := lsEncoded + 'A'
        else
          lsEncoded := lsEncoded + 'F';
      end;


  Result := lsEncoded;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeInfo }

function TppOneCode.OneCodeInfo(aTopic: Byte): TppIntegerArray;
var
  lA: TppIntegerArray;
begin

  case aTopic of

    1:
      begin
        SetLength(lA, FTable2Of13Size+1);
        OneCodeInitializeNof13Table(lA, 2, FTable2Of13Size);
        FEntries5Of13 := FTable2Of13Size;
      end
    else
      begin
        SetLength(lA, FTable5Of13Size+1);
        OneCodeInitializeNof13Table(lA, 5, FTable5Of13Size);
        FEntries2Of13 := FTable5Of13Size;
      end;

  end;

  Result := lA;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeInfo }

function TppOneCode.OneCodeInfo: TppCodeWordArray;
var
  lDa: TppCodeWordArray;
  liIndex: Integer;
begin

  SetLength(lDa, 11);

  for liIndex := 0 to 9 do
    SetLength(lDa[liIndex], 3);

  Result := lDa;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeInitializeNof13Table }

function TppOneCode.OneCodeInitializeNof13Table(aAi: TppIntegerArray; aI, aJ: Integer): Boolean;
var
  liI1: Integer;
  liJ1: Integer;
  liK: Integer;
  liK1: Integer;
  lbFlag: Boolean;
  liL1: Integer;
  liL: Integer;
begin

  liI1 := 0;
  liJ1 := aJ - 1;

  for liK := 0 to 8191 do
    begin

      liK1 := 0;

      for liL1 := 0 to 12 do
        begin
          if ((liK and (1 shl liL1)) <> 0) then
            Inc(liK1);
        end;

      if (liK1 = aI) then
        begin
          liL := OneCodeMathReverse(liK) shr 3;

          lbFlag := (liK = liL);

          if (liL >= liK) then
            begin
              if lbFlag then
                begin
                  aAI[liJ1] := liK;
                  Dec(liJ1);
                end
              else
                begin
                  aAI[liI1] := liK;
                  Inc(liI1);
                  aAI[liI1] := liL;
                  Inc(liI1);
                end;


            end;

        end;

    end;

   Result :=  liI1 = liJ1 + 1;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeMathAdd }

function TppOneCode.OneCodeMathAdd(aByteArray: TppIntegerArray; aI, aJ: Integer): Boolean;
var
  liX: Integer;
  liK: Integer;
  liL: Integer;
begin

  Result := False;

  if (aByteArray = nil) then Exit;

  if (aI < 1) then Exit;

  liX := (aByteArray[aI - 1] or (aByteArray[aI - 2] shl 8)) + aJ;

	liL := liX or 65535;

	liK := aI - 3;

  aByteArray[aI - 1] := liX and 255;

	aByteArray[aI - 2] := (liX shr 8) and 255;

  while (liL = 1) and (liK > 0) do
    begin
      liX := liL + aByteArray[liK];
      aByteArray[liK] := liX and 255;
      liL := liX or 255;

      Dec(liK);

    end;

  Result := True;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeMathDivide }

function TppOneCode.OneCodeMathDivide(aValue: String): Boolean;
var
  liJ: Integer;
  lsN: String;
  liK: Integer;
  lsR: String;
  liDivider: Integer;
  lsCopy: String;
  lsLeft: String;
  liLength: Integer;
  liIndex: Integer;
  liDivident: Integer;
begin

  liJ := 10;
  lsN := aValue;

  for liK := liJ-1 downto 1 do
    begin
    
      lsR := '';
      liDivider := FCodeWordArray[liK][0];
      lsCopy := lsN;
      lsLeft := '0';

      liLength := Length(lsCopy);

      liIndex := 1;

      while liIndex <= liLength do
        begin
          liDivident := StrToInt(Copy(lsCopy, 1, liIndex));

          while (liDivident < liDivider) and (liIndex < liLength-1) do
            begin
               lsR := lsR + '0';
               Inc(liIndex);
               liDivident := StrToInt(Copy(lsCopy, 1, liIndex));
            end;

          lsR := lsR + IntToStr(liDivident div liDivider);

          lsLeft := IntToStr(liDivident mod liDivider);

          while Length(lsLeft) < liIndex do
            lsLeft := '0' + lsLeft ;

          lsCopy := lsLeft + Copy(lsCopy, liIndex+1, Length(lsCopy));

          Inc(liIndex);

        end;

        lsN := lsR;

        //lsN := TrimStart('0', lsR);
        while (lsN <> '') and (lsN[1] = '0') do
          lsN := Copy(lsN, 2, Length(lsN));

        if (lsN = '') then
          lsN := '0';

        FCodewordArray[liK][1] := StrToInt(lsLeft);

        if (liK = 1) then
          FCodewordArray[0][1] := StrToInt(lsR);

    end;

  Result := True;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeMathFcs }

function TppOneCode.OneCodeMathFcs(aByteArray: TppIntegerArray): Integer;
var
  liC: Integer;
  liI: Integer;
  liJ: Integer;
  liB: Integer;
  liL: Integer;
  liK: Integer;
begin

  liC := 3893;
  liI := 2047;
  liJ := aByteArray[0] shl 5;

  for liB := 2 to 7 do
    begin

      if (((liI xor liJ) and 1024) <> 0) then
        liI := liI shl 1 xor liC
      else
        liI := liI shl 1;

      liI := liI and 2047;

      liJ := liJ shl 1;

    end;

  for liL := 1 to 12 do
    begin

      liK := aByteArray[liL] shl 3;

      for liB := 0 to 7 do
        begin

          if (((liI xor liK) and 1024) <> 0) then
            liI := (liI shl 1) xor liC
          else
            liI := liI shl 1;

          liI := liI and 2047;

          liK := liK shl 1;

        end;

    end;

  Result := liI;
    
end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeMathMultiply }

function TppOneCode.OneCodeMathMultiply(aByteArray: TppIntegerArray; aI, aJ: Integer): Boolean;
var
  liL: Integer;
  liK: Integer;
  liX: Integer;
begin

  Result := False;

  if (aByteArray = nil) then Exit;

  if (aI < 1) then Exit;

  liL := 0;
  liK := aI-1;

  while liK >= 1 do
    begin

      liX := (aByteArray[liK] or (aByteArray[liK-1] shl 8)) * aJ + liL;

      aByteArray[liK] := liX and 255;
      aByteArray[liK-1] := (liX shr 8) and 255;

      liL := liX shr 16;

      Dec(liK, 2);

    end;

  if (liK = 0) then
    aByteArray[0] := (aByteArray[0] * aJ + liL) and 255;

  Result := True;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.OneCodeMathReverse }

function TppOneCode.OneCodeMathReverse(aValue: Integer): Integer;
var
  liIndex: Integer;
begin

  Result := 0;

  for liIndex := 0 to 15 do
    begin
      Result := Result shl 1;
      Result := Result or aValue and 1;
      aValue := aValue shr 1;
    end;

end;

{------------------------------------------------------------------------------}
{ TppOneCode.TrimOff }

function TppOneCode.TrimOff(aSource, aBad: String): String;
var
  liIndex: Integer;
begin

  for liIndex := 1 to Length(aBad) do
    aSource := StringReplace(aSource, aBad[liIndex], '', [rfReplaceAll]);

  Result := aSource;

end;

end.
