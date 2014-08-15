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
{********************************************************************}
{  Read/Write routine for varArray variant                           }
{     based  on System.pas , Delphi 5                                }
{                                                                    }
{     Copyright (c)  04.2000 by                                      }
{     V.A.Pronov  email: VAPronov@usa.net                            }
{             and Serge Buzadzhy                                     }
{     email:  buzz@devrace.com                                       }
{                                                                    }
{********************************************************************}


unit VariantRtn;

interface

{$I FIBPlus.inc}

uses
 {$IFDEF WINDOWS}
   Windows, Messages, SysUtils
   {$IFDEF D6+}, Variants{$ENDIF}
;

 {$ENDIF}
 {$IFDEF LINUX}
   Types, SysUtils, Variants,VarUtils ;
 {$ENDIF}

type
// CallBack procedures definitions
      TProcReadElementValue=procedure (Value:Variant; IndexValue:array of integer;
       const HighBoundInd:integer;
       Var Continue:boolean
      );
      TProcWriteElementValue=
       procedure (OldValue:Variant; IndexValue:array of integer;
        Var NewValue:Variant;  Var Continue:boolean
       );
//  End CallBack procedures definitions


function SafeVarArrayCreate(const Bounds: array of Integer;
 VarType,DimCount: Integer):Variant;

function VarArrayGet(const A: Variant; const Indices: array of Integer;
 const HighBound:integer
):Variant;

procedure VarArrayPut
 (var A: Variant; const Value: Variant; const Indices: array of Integer;
  const HighBound:integer
);


function CycleReadArray(vArray:Variant;CallBackProc:TProcReadElementValue):boolean;
function CycleWriteArray(var vArray:Variant;CallBackProc:TProcWriteElementValue):boolean;

function CompareVarArray1(vArray1,vArray2:Variant):boolean;
function EasyCompareVarArray1(vArray1,vArray2:Variant;HighBound:integer):boolean;
function NeedCastForCompare(const v,v1:Variant):boolean;

{$IFNDEF D6+}
function VarTypeIsNumeric(const AVarType: word): Boolean;
function VarIsNumeric(const V: Variant): Boolean;
{$ENDIF}

function CompareVariantsEQ(const v,v1:Variant):boolean;
function CompareVariants(const v,v1:Variant):Integer;

function ComparePDoubleAndVariant(P:PDouble;const v:Variant):Integer;
function ComparePIntegerAndVariant(P:PInteger;const v:Variant):Integer;
function ComparePInt64AndVariant(P:PInt64;const v:Variant):Integer;
function ComparePByteAndVariant(P:PByte;const v:Variant):Integer;
function ComparePDateAndVariant(P:PDateTime;const v:Variant):Integer;
function ComparePSmallAndVariant(P:PSmallInt;const v:Variant):Integer;
function CompareWideStringAndVariant(P:Pointer;const v:Variant):Integer;
function ComparePCurrencyAndVariant(P:PCurrency;const v:Variant):Integer;
function ComparePShortAndVariant(P:PShortInt;const v:Variant):Integer;

implementation
uses FIBConsts;


{$IFNDEF D6+}
function VarTypeIsNumeric(const AVarType: Word): Boolean;
begin
  Result := AVarType in [varSmallInt, varInteger, varBoolean,
                         varByte, varSingle,varDouble,varCurrency];

end;

function VarIsNumeric(const V: Variant): Boolean;
begin
  Result := VarTypeIsNumeric(TVarData(V).VType);
end;
{$ENDIF}

// CompareRnts
function GetVariantData(const v: Variant):Pointer;
begin
  case TVarData(v).VType of
    varSmallInt:
     result:=@TVarData(v).VSmallInt;
    varInteger:
      result:=@TVarData(v).VInteger;
    varSingle :
      result:=@TVarData(v).VSingle;
{$IFDEF D6+}
    varInt64:
     result:=@TVarData(v).VInt64;

    varShortInt:
      result:=@TVarData(v).VShortInt;
    varWord:
      result:=@TVarData(v).VWord;
    varLongWord:
      result:=@TVarData(v).VLongWord;
{$ENDIF}
    varByte:
      result:=@TVarData(v).VByte;
    varDouble  : result:=@TVarData(v).VDouble;
    varCurrency: result:=@TVarData(v).VCurrency;
    varDate    : result:=@TVarData(v).VDate;
    varOleStr  : result:=TVarData(v).VOleStr;
    varBoolean : result:=@TVarData(v).VBoolean;
    varVariant,varByRef: result:=GetVariantData(PVariant(@TVarData(v).VPointer)^);
    varString  : result:=TVarData(v).VString;
  else
    result := nil;
  end;
end;



{$DEFINE BODY_NUMERIC_COMPARE_EQ}
{$WARNINGS OFF}
function ComparePIntegerAndVariant(P:PInteger;const v:Variant):Integer;
{$I VarFnc.inc}

function ComparePSmallAndVariant(P:PSmallInt;const v:Variant):Integer;
{$I VarFnc.inc}


function ComparePSingleAndVariant(P:PSingle;const v:Variant):Integer;
{$I VarFnc.inc}

function ComparePDoubleAndVariant(P:PDouble;const v:Variant):Integer;
{$I VarFnc.inc}

function ComparePCurrencyAndVariant(P:PCurrency;const v:Variant):Integer;
{$I VarFnc.inc}


function ComparePDateAndVariant(P:PDateTime;const v:Variant):Integer;
{$I VarFnc.inc}


function ComparePInt64AndVariant(P:PInt64;const v:Variant):Integer;
{$DEFINE C_INT64}
{$I VarFnc.inc}
{$UNDEF C_INT64}

function ComparePByteAndVariant(P:PByte;const v:Variant):Integer;
{$I VarFnc.inc}



function ComparePShortAndVariant(P:PShortInt;const v:Variant):Integer;
{$I VarFnc.inc}
{$IFDEF D6+}
function ComparePWordAndVariant(P:PWord;const v:Variant):Integer;
{$I VarFnc.inc}

function ComparePLongWordAndVariant(P:PLongWord;const v:Variant):Integer;
{$I VarFnc.inc}
{$ENDIF}

{$WARNINGS ON}
{$UNDEF BODY_NUMERIC_COMPARE_EQ}

function CompareWideStringAndVariantEQ(P:Pointer;const v:Variant):boolean;
begin
   case VarType(v) of
    varString:    result:=WideString(P)=string(TVarData(v).VString);
    varOleStr:    result:=WideString(P)=WideString(TVarData(v).VOleStr);
   else
     Result := WideString(P)=VarToStr(V);
   end;
end;

function CompareStringAndVariantEQ(P:Pointer;const v:Variant):boolean;
begin
   case VarType(v) of
    varString:    result:=String(P)=String(TVarData(v).VString);
    varOleStr:    result:=String(P)=WideString(TVarData(v).VOleStr);
   else
     result := String(P)=VarToStr(V);   //ломает оптимизировать
   end;
end;


function CompareWideStringAndVariant(P:Pointer;const v:Variant):Integer;
begin
   case VarType(v) of
    varString:
    begin
      if WideString(P)=string(TVarData(v).VString) then
        Result := 0
      else
      if WideString(P)>string(TVarData(v).VString) then
       Result:=1
      else
       Result := -1;
    end;
    varOleStr:
    begin
      if WideString(P)=WideString(TVarData(v).VOleStr) then
        Result := 0
      else
      if WideString(P)>WideString(TVarData(v).VOleStr) then
       Result:=1
      else
       Result := -1;
    end;
   else
    if WideString(P)=VarToStr(V) then
      Result :=0
    else
    if WideString(P)>VarToStr(V) then
       Result:=1
    else
      Result := -1;
   end;
end;

function CompareStringAndVariant(P:Pointer;const v:Variant):Integer;
begin
   case VarType(v) of
    varString:
    begin
     if String(P)=String(TVarData(v).VString) then
      Result :=0
     else
     if String(P)>String(TVarData(v).VString) then
      Result :=1
     else
      Result :=-1
    end;
    varOleStr:
    begin
     if String(P)=WideString(TVarData(v).VOleStr) then
      Result :=0
     else
     if String(P)>WideString(TVarData(v).VOleStr) then
      Result :=1
     else
      Result :=-1
    end;
   else
     if String(P)=VarToStr(V) then
      Result :=0
     else
     if String(P)>VarToStr(V) then
       Result:=1
     else
      Result := -1;
   end;
end;

function CompareVariants(const v,v1:Variant):Integer;
begin
 case TVarData(v).VType of
  varSmallInt:
   result:=ComparePSmallAndVariant(GetVariantData(v),v1);
  varInteger :
   result:=ComparePIntegerAndVariant(GetVariantData(v),v1);
  varSingle  :
   result:=ComparePSingleAndVariant(GetVariantData(v),v1);
  varDouble  :
   result:=ComparePDoubleAndVariant(GetVariantData(v),v1);
  varCurrency:
   result:=ComparePCurrencyAndVariant(GetVariantData(v),v1);
  varDate    :
   result:=ComparePDateAndVariant(GetVariantData(v),v1);
  varOleStr:
    result:=CompareWideStringAndVariant(GetVariantData(v),v1);
{$IFDEF D6+}
  varShortInt:
   result:=ComparePShortAndVariant(GetVariantData(v),v1);
  varByte    :
   result:=ComparePByteAndVariant(GetVariantData(v),v1);
  varWord    :
   result:=ComparePWordAndVariant(GetVariantData(v),v1);
  varLongWord:
   result:=ComparePLongWordAndVariant(GetVariantData(v),v1);
  varInt64   :
   result:=ComparePInt64AndVariant(GetVariantData(v),v1);
{$ENDIF}
  varString  :
   result:=CompareStringAndVariant(GetVariantData(v),v1);
 else
   if v=v1 then
    Result := 0
   else
   if v>v1 then
    Result:=1
   else
    Result:=-1
 end;
end;

function CompareVariantsEQ(const v,v1:Variant):boolean;
begin
 case TVarData(v).VType of
  varSmallInt:
   result:=ComparePSmallAndVariant(GetVariantData(v),v1)=0;
  varInteger :
   result:=ComparePIntegerAndVariant(GetVariantData(v),v1)=0;
  varSingle  :
   result:=ComparePSingleAndVariant(GetVariantData(v),v1)=0;
  varDouble  :
   result:=ComparePDoubleAndVariant(GetVariantData(v),v1)=0;
  varCurrency:
   result:=ComparePCurrencyAndVariant(GetVariantData(v),v1)=0;
  varDate    :
   result:=ComparePDateAndVariant(GetVariantData(v),v1)=0;
  varOleStr:
    result:=CompareWideStringAndVariantEQ(GetVariantData(v),v1);
{$IFDEF D6+}
  varShortInt:
   result:=ComparePShortAndVariant(GetVariantData(v),v1)=0;
  varByte    :
   result:=ComparePByteAndVariant(GetVariantData(v),v1)=0;
  varWord    :
   result:=ComparePWordAndVariant(GetVariantData(v),v1)=0;
  varLongWord:
   result:=ComparePLongWordAndVariant(GetVariantData(v),v1)=0;
  varInt64   :
   result:=ComparePInt64AndVariant(GetVariantData(v),v1)=0;
{$ENDIF}
  varString  :
   result:=CompareStringAndVariantEQ(GetVariantData(v),v1);
 else
   result:=v=v1;
 end;
end;
//////
function NeedCastForCompare(const v,v1:Variant):boolean;
begin
  case VarType(v) of
   varDate:   Result:= not (VarIsNumeric(v1) or (VarType(v1)=varDate));
   varBoolean:Result:= VarType(v1)<>varBoolean;
  else
   case VarType(v1) of
    varDate   : Result:= not (VarIsNumeric(v) {or (VarType(v)=varDate)});
    varBoolean: Result:= True;    
   else
    Result:= (VarIsNumeric(v1) xor VarIsNumeric(v))
   end 
  end;
end;

function EasyCompareVarArray1( vArray1,vArray2:Variant;HighBound:integer)
 :boolean;
var
 j:integer;
 v,v1:Variant;
begin
 Result:=False;
 try
    for j:= HighBound downto 0 do
    begin
      v1:=vArray2[j];
      v :=vArray1[j];
      if VarIsEmpty(v) then  v  := Null;
      if VarIsEmpty(v1) then v1 := Null;

      if (VarIsNull(v) xor VarIsNull(v1)) or (v<>v1) then
       Exit;
    end;
    Result:=True
 except
 end
end;

function CompareVarArray1(vArray1,vArray2:Variant):boolean;
var j,l,h:integer;
begin
 Result:=False;
 try
  if VarIsArray(vArray1) and VarIsArray(vArray2) then
  begin
    h:=VarArrayHighBound(vArray1,1);
    l:=VarArrayLowBound(vArray1,1);
    for j:=l to h do
    begin
      if vArray1[j]<>vArray2[j] then
       Exit;
    end;
    Result:=True
  end
 except
 end
end;

const
  {$IFDEF WINDOWS}
  oleaut = 'oleaut32.dll';
  {$ENDIF}

  MaxDimCount=16;
//
{$IFDEF WINDOWS}
type
  TVarArrayBoundArray = array[0..MaxDimCount-1] of TVarArrayBound;
{$ENDIF}

threadvar
  CurIndex: array[0..MaxDimCount] of Longint;
//  CurIndex: array of Longint;

{$IFDEF WINDOWS}
// Cut from System.pas
function SafeArrayGetElement(VarArray: PVarArray; Indices,
  Data: Pointer): Integer; stdcall;
  external oleaut name 'SafeArrayGetElement';

function SafeArrayPutElement(VarArray: PVarArray; Indices,
  Data: Pointer): Integer; stdcall;
  external oleaut name 'SafeArrayPutElement';

function SafeArrayPtrOfIndex(VarArray: PVarArray; Indices: Pointer;
  var pvData: Pointer): HResult; stdcall;
  external oleaut name 'SafeArrayPtrOfIndex';

function SafeArrayCreate(VarType, DimCount: Integer;
  const Bounds): PVarArray; stdcall;
  external oleaut name 'SafeArrayCreate';

{$ENDIF}


function GetVarArray(const A: Variant): PVarArray;
begin
  if TVarData(A).VType and varByRef <> 0 then
    Result := PVarArray(TVarData(A).VPointer^) else
    Result := TVarData(A).VArray;
end;


// End Cut
  
function NextElements(v: Variant): boolean;
var
  Dimensions: integer;
  i: integer;
begin
  Result := False;
  Dimensions := VarArrayDimCount(v);
  for i := Dimensions-1 downto 0 do
  begin
    if CurIndex[i] = VarArrayHighBound(v,i+1) then
    begin
      CurIndex[i] := VarArrayLowBound(v,i+1);
    end
    else
    begin
      CurIndex[i] := CurIndex[i]+1;
      Result := True;
      Exit;
    end;
  end;
end;


procedure InitializationCurIndexArray(vArray:Variant);
var
  i: integer;
  Dimensions: integer;
begin
  Dimensions := VarArrayDimCount(vArray);
  for i:=0 to Dimensions-1 do
    CurIndex[i]:= VarArrayLowBound(vArray,i+1);
  for i := Dimensions to MaxDimCount do
    CurIndex[i] := 0;
end;



function CycleReadArray(vArray:Variant;CallBackProc:TProcReadElementValue):boolean;
var
  Value: Variant;
  HighBoundInd:integer;
begin
 Result:=false;
 if not Assigned(CallBackProc) then Exit;
 if not VarIsArray(vArray) then Exit;

 InitializationCurIndexArray(vArray);

  HighBoundInd:=VarArrayDimCount(vArray)-1;
  repeat
    Value:= VarArrayGet(vArray, CurIndex,HighBoundInd);
    Result:=true;
    CallBackProc(Value,CurIndex,HighBoundInd,Result);
    if not Result then Exit;
    if not NextElements(vArray) then Break;
  until False;
end;


// Cut from System.pas

procedure VarStringToOleStr(var Dest: Variant; const Source: Variant);
var
  OleStrPtr: PWideChar;
begin
  OleStrPtr := StringToOleStr(string(TVarData(Source).VString));
  VarClear(Dest);
  TVarData(Dest).VType := varOleStr;
  TVarData(Dest).VOleStr := OleStrPtr;
end;                    
// end Cut from System.pas

function CycleWriteArray
 (var vArray:Variant;CallBackProc:TProcWriteElementValue):boolean;
var
  OldValue,NewValue: Variant;
  HighBoundInd:integer;
begin
// vArray - Variant array of Variant
 Result:=false;
 if not Assigned(CallBackProc) then Exit;
 InitializationCurIndexArray(vArray);
 HighBoundInd:=VarArrayDimCount(vArray)-1;
 repeat
    OldValue:=VarArrayGet(vArray, CurIndex,HighBoundInd);
    Result:=true;
    CallBackProc(OldValue,CurIndex,NewValue,Result);
    if not Result then Exit;
    VarArrayPut(vArray, NewValue, CurIndex ,HighBoundInd);
    if not NextElements(vArray) then Break;
 until False;
end;


//Cut From System
function SafeVarArrayCreate(const Bounds: array of Integer;
 VarType,DimCount: Integer):Variant;
var
  I: Integer;
  VarArrayRef: PVarArray;
  VarBounds  : TVarArrayBoundArray;
begin
  if not DimCount>64 then
    raise Exception.Create(reVarArrayCreate);
  for I := 0 to DimCount - 1 do
    with VarBounds[I] do
    begin
      LowBound := Bounds[I * 2];
      ElementCount := Bounds[I * 2 + 1] - LowBound + 1;
    end;
  VarArrayRef := SafeArrayCreate(VarType, DimCount, VarBounds);
  if VarArrayRef = nil then
   raise Exception.Create(reVarArrayCreate);
  VarClear(Result);
  TVarData(Result).VType := VarType or varArray;
  TVarData(Result).VArray := VarArrayRef;
end;


function _VarArrayGet(var A: Variant; IndexCount: Integer;
  Indices: Integer): Variant; cdecl;
var
  VarArrayPtr: PVarArray;
  VarType: Integer;
  P: Pointer;
begin
  if TVarData(A).VType and varArray = 0 then
   raise Exception.Create(reVarNotArray);
  VarArrayPtr := GetVarArray(A);
  if VarArrayPtr^.DimCount <> IndexCount then
     raise Exception.Create(reVarArrayBounds);
  VarType := TVarData(A).VType and varTypeMask;
  VarClear(Result);
  if VarType = varVariant then
  begin

    {$IFDEF WINDOWS}
    if SafeArrayPtrOfIndex(VarArrayPtr, @Indices, P) <> 0 then
    {$ELSE}
    if SafeArrayPtrOfIndex(VarArrayPtr, PVarArrayCoorArray(@Indices), P) <> 0 then
    {$ENDIF}
     raise Exception.Create(reVarArrayBounds);
    Result := PVariant(P)^;
  end
  else
  begin
  {$IFDEF WINDOWS}
  if SafeArrayGetElement(VarArrayPtr, @Indices,
      @TVarData(Result).VPointer) <> 0 then
  {$ELSE}
  if SafeArrayGetElement(VarArrayPtr, PVarArrayCoorArray(@Indices),
      @TVarData(Result).VPointer) <> 0 then
  {$ENDIF}
     raise Exception.Create(reVarArrayBounds);
    TVarData(Result).VType := VarType;
  end;
end;

function VarArrayGet(const A: Variant; const Indices: array of Integer;
 const HighBound:integer
): Variant;
asm
        {     ->EAX     Pointer to A            }
        {       EDX     Pointer to Indices      }
        {       ECX     High bound of Indices   }
        {       [EBP+8] Pointer to result       }

        MOV     ECX,HighBound
        PUSH    EBX

        MOV     EBX,ECX
        INC     EBX
        JLE     @@endLoop
@@loop:
        PUSH    [EDX+ECX*4].Integer
        DEC     ECX
        JNS     @@loop
@@endLoop:
        PUSH    EBX
        PUSH    EAX
        MOV     EAX,[EBP+8]
        PUSH    EAX
        CALL    _VarArrayGet
        LEA     ESP,[ESP+EBX*4+3*4]

        POP     EBX
end;


procedure _VarArrayPut(var A: Variant; const Value: Variant;
  IndexCount: Integer; Indices: Integer); cdecl;
var
  VarArrayPtr: PVarArray;
  VarType: Integer;
  P: Pointer;
  Temp: TVarData;
begin
  if TVarData(A).VType and varArray = 0 then
       raise Exception.Create(reVarNotArray);
  VarArrayPtr := GetVarArray(A);
  if VarArrayPtr^.DimCount <> IndexCount then
       raise Exception.Create(reVarArrayBounds);
  VarType := TVarData(A).VType and varTypeMask;
  if (VarType = varVariant) and (TVarData(Value).VType <> varString) then
  begin
    {$IFDEF WINDOWS}
    if SafeArrayPtrOfIndex(VarArrayPtr, @Indices, P) <> 0 then
    {$ELSE}
    if SafeArrayPtrOfIndex(VarArrayPtr, PVarArrayCoorArray(@Indices), P) <> 0 then
    {$ENDIF}

     raise Exception.Create(reVarArrayBounds);
    PVariant(P)^ := Value;
  end
  else
  begin
    Temp.VType := varEmpty;
    try
      if VarType = varVariant then
      begin
        VarStringToOleStr(Variant(Temp), Value);
        P := @Temp;
      end
      else
      begin
        VarCast(Variant(Temp), Value, VarType);
        case VarType of
          varOleStr, varDispatch, varUnknown:
            P := Temp.VPointer;
        else
          P := @Temp.VPointer;
        end;
      end;
      {$IFDEF WINDOWS}
      if SafeArrayPutElement(VarArrayPtr, @Indices, P) <> 0 then
      {$ELSE}
      if SafeArrayPutElement(VarArrayPtr, PVarArrayCoorArray(@Indices), P) <> 0 then
      {$ENDIF}
     raise Exception.Create(reVarArrayBounds);
    finally
      VarClear(Variant(Temp));
    end;
  end;
end;


procedure VarArrayPut(var A: Variant; const Value: Variant; const Indices: array of Integer;
 const HighBound:integer
);
asm
        {     ->EAX     Pointer to A            }
        {       EDX     Pointer to Value        }
        {       ECX     Pointer to Indices      }
        {       [EBP+8] High bound of Indices   }
// Add HighBound Variable

        PUSH    EBX

//        MOV     EBX,[EBP+8]
        MOV     EBX,HighBound
        TEST    EBX,EBX
        JS      @@endLoop
@@loop:
        PUSH    [ECX+EBX*4].Integer
        DEC     EBX
        JNS     @@loop
@@endLoop:
//        MOV     EBX,[EBP+8]
        MOV     EBX,HighBound
        INC     EBX
        PUSH    EBX
        PUSH    EDX
        PUSH    EAX
        CALL    _VarArrayPut
        LEA     ESP,[ESP+EBX*4+3*4]

        POP     EBX
end;
// end Cut from System.pas
end.





