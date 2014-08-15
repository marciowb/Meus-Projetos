
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid filter class (abstract)                  }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxFilter;

interface

{$I dxTLVer.inc}

uses
  Classes{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxAbstractOperator }
  
  TdxAbstractOperator = class
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; virtual; abstract;
    function OperatorString: string; virtual; abstract;
  end;

  TdxAbstractOperatorClass = class of TdxAbstractOperator;

  { TdxNullOperator }
  
  TdxNullOperator = class(TdxAbstractOperator)
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; override;
    function OperatorString: string; override;
  end;

  { TdxEqualOperator }
  
  TdxEqualOperator = class(TdxAbstractOperator)
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; override;
    function OperatorString: string; override;
  end;

  { TdxGreaterOperator }

  TdxGreaterOperator = class(TdxAbstractOperator)
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; override;
    function OperatorString: string; override;
  end;

  { TdxLessOperator }
  
  TdxLessOperator = class(TdxAbstractOperator)
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; override;
    function OperatorString: string; override;
  end;

  { TdxGreaterEqualOperator }
  
  TdxGreaterEqualOperator = class(TdxAbstractOperator)
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; override;
    function OperatorString: string; override;
  end;

  { TdxLessEqualOperator }

  TdxLessEqualOperator = class(TdxAbstractOperator)
  public
    function CompareValues(const Value1, Value2: Variant): Boolean; override;
    function OperatorString: string; override;
  end;

  { TdxCustomCriteriaItem }

  TdxCriteriaItemList = class;

  TdxCustomCriteriaItem = class
  private
    FIsNot: Boolean;
    FParent: TdxCriteriaItemList;
    function GetIsItemList: Boolean; virtual; abstract;
  protected
    procedure ReadData(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual; 
  public
    constructor Create(AOwner: TdxCriteriaItemList); virtual;
    destructor Destroy; override;
    property IsItemList: Boolean read GetIsItemList;
    property IsNot: Boolean read FIsNot write FIsNot default False;
    property Parent: TdxCriteriaItemList read FParent;
  end;

  { TdxCriteriaItemList }

  TdxOperatorType = (otIsNull, otEqual, otGreater, otLess, otGreaterEqual, otLessEqual);
  TdxBoolOperator = (boAnd, boOr);

  TdxCriteriaItem = class;
  TdxCriteria = class;

  TdxCriteriaItemList = class(TdxCustomCriteriaItem)
  private
    FBoolOperator: TdxBoolOperator;
    FCriteria: TdxCriteria;
    FDestroying: Boolean;
    FList: TList;
    function GetCount: Integer;
    function GetCriteria: TdxCriteria;
    function GetItem(AIndex: Integer): TdxCustomCriteriaItem;
  protected
    function GetIsItemList: Boolean; override;
    procedure WriteData(Stream: TStream); override;
  public
    constructor Create(AOwner: TdxCriteriaItemList); override;
    destructor Destroy; override;
    function AddItem(const AID: string; AOperator: TdxOperatorType;
      const AValue: Variant; const ADisplayValue: string): TdxCriteriaItem;
    function AddList(ABoolOperator: TdxBoolOperator): TdxCriteriaItemList;
    procedure Clear;
    property BoolOperator: TdxBoolOperator read FBoolOperator write FBoolOperator default boAnd;
    property Count: Integer read GetCount;
    property Criteria: TdxCriteria read GetCriteria;
    property Destroying: Boolean read FDestroying;
    property Items[Index: Integer]: TdxCustomCriteriaItem read GetItem; default;
  end;

  { TdxCriteriaItem }

  TdxCriteriaItem = class(TdxCustomCriteriaItem)
  private
    FDisplayValue: string;
    FID: string;
    FOperator: TdxOperatorType;
    FValue: Variant;
  protected
    function GetCaption: string; virtual;
    function GetDataValue(AData: Pointer): Variant; virtual; abstract;
    function GetIsItemList: Boolean; override;
    function GetText: string; virtual; abstract;
    procedure WriteData(Stream: TStream); override;
  public
    property DisplayValue: string read FDisplayValue write FDisplayValue;
    property ID: string read FID write FID;
    property Operator: TdxOperatorType read FOperator write FOperator;
    property Value: Variant read FValue write FValue;
  end;

  { TdxCriteria }

  TdxCriteriaItemClass = class of TdxCriteriaItem;

  TdxCriteria = class
  private
    FRoot: TdxCriteriaItemList;
    procedure ReadItem(Stream: TStream; AItemList: TdxCriteriaItemList);
  protected
    function DoFilterData(AData: Pointer): Boolean;
    function GetFilterText(AIsCaption: Boolean): string;
    function GetItemClass: TdxCriteriaItemClass; virtual;
    function PrepareValue(const AValue: Variant): Variant; virtual;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function FilterCaption: string;
    function FilterText: string;
    function FindItemByName(const AName: string): TdxCriteriaItem;
    procedure Prepare; virtual;
    procedure RemoveItemByName(const AName: string);
    property Root: TdxCriteriaItemList read FRoot;
  end;

function VarEqualNull(const AValue: Variant): Boolean;

implementation

uses
   Consts, SysUtils{$IFDEF DELPHI6}, RTLConsts{$ENDIF};

const
  OperatorClasses: array [TdxOperatorType] of TdxAbstractOperatorClass =
    (TdxNullOperator, TdxEqualOperator, TdxGreaterOperator, TdxLessOperator,
     TdxGreaterEqualOperator, TdxLessEqualOperator);

var
  OperatorClassList: array [TdxOperatorType] of TdxAbstractOperator;

function VarEqualNull(const AValue: Variant): Boolean;
begin
  Result := VarIsNull(AValue) or ((VarType(AValue) = varString) and (AValue = ''){TODO Soft Null?});
end;

{$IFDEF DELPHI6}
function VarCompare(const V1, V2: Variant): Integer;
begin
  try
    if V1 = V2 then
      Result := 0
    else
      if VarIsNull(V1) then
        Result := -1
      else
        if VarIsNull(V2) then
          Result := 1
        else
          if V1 < V2 then
            Result := -1
          else
            Result := 1;
  except
    on EVariantError do
      Result := -1;
  end
end;
{$ENDIF}

// Stream routines
procedure ReadString(Stream: TStream; var S: string);
var
  L: Integer;
begin
  Stream.ReadBuffer(L, SizeOf(L));
  SetString(S, PChar(nil), L);
  Stream.ReadBuffer(Pointer(S)^, L);
end;

procedure WriteString(Stream: TStream; const S: string);
var
  L: Integer;
begin
  L := Length(S);
  Stream.WriteBuffer(L, SizeOf(L));
  Stream.WriteBuffer(S[1], L);
end;

procedure ReadVariant(Stream: TStream; var Value: Variant);
const
  ValTtoVarT: array[TValueType] of Integer = (varNull, varError, varByte,
    varSmallInt, varInteger, varDouble, varString, varError, varBoolean,
    varBoolean, varError, varError, varString, varEmpty, varError
  {$IFDEF DELPHI4}, varSingle, varCurrency, varDate, varOleStr
  {$IFDEF DELPHI5}, varError{$IFDEF DELPHI6}, varError{$ENDIF}{$ENDIF}{$ENDIF});
var
  ValType: TValueType;

  procedure Read(var Buffer; Count: Integer);
  begin
    Stream.ReadBuffer(Buffer, Count);
  end;

  function ReadInteger: Longint;
  var
    S: Shortint;
    I: Smallint;
  begin
    case ValType of
      vaInt8:
        begin
          Read(S, SizeOf(S));
          Result := S;
        end;
      vaInt16:
        begin
          Read(I, SizeOf(I));
          Result := I;
        end;
    else {vaInt32}
      Read(Result, SizeOf(Result));
    end;
  end;

  function ReadFloat: Extended;
  begin
    Read(Result, SizeOf(Result));
  end;

  function ReadSingle: Single;
  begin
    Read(Result, SizeOf(Result));
  end;

  function ReadCurrency: Currency;
  begin
    Read(Result, SizeOf(Result));
  end;

  function ReadDate: TDateTime;
  begin
    Read(Result, SizeOf(Result));
  end;

  function ReadString: string;
  var
    L: Integer;
  begin
    L := 0;
    case ValType of
      vaString:
        Read(L, SizeOf(Byte));
    else {vaLString}
      Read(L, SizeOf(Integer));
    end;
    SetString(Result, PChar(nil), L);
    Read(Pointer(Result)^, L);
  end;

  function ReadWideString: WideString;
  var
    L: Integer;
  begin
    L := 0;
    Read(L, SizeOf(Integer));
    SetLength(Result, L);
    Read(Pointer(Result)^, L * 2);
  end;

begin
  Read(ValType, SizeOf(ValType));
  case ValType of
    vaNil:
      VarClear(Value);
    vaNull:
      Value := Null;
    vaInt8:
      TVarData(Value).VByte := Byte(ReadInteger);
    vaInt16:
      TVarData(Value).VSmallint := Smallint(ReadInteger);
    vaInt32:
      TVarData(Value).VInteger := ReadInteger;
    vaExtended:
      TVarData(Value).VDouble := ReadFloat;
    vaString, vaLString:
      Value := ReadString;
    vaFalse, vaTrue:
      TVarData(Value).VBoolean := ValType = vaTrue;
  {$IFDEF DELPHI4}
    vaWString:
      Value := ReadWideString;
    vaSingle:
      TVarData(Value).VSingle := ReadSingle;
    vaCurrency:
      TVarData(Value).VCurrency := ReadCurrency;
    vaDate:
      TVarData(Value).VDate := ReadDate;
  {$ENDIF}
  else
    raise EReadError.Create(SReadError);
  end;
  TVarData(Value).VType := ValTtoVarT[ValType];
end;

procedure WriteVariant(Stream: TStream; const AValue: Variant);

  procedure Write(const Buffer; Count: Integer);
  begin
    Stream.WriteBuffer(Buffer, Count);
  end;

  procedure WriteValue(Value: TValueType);
  begin
    Write(Value, SizeOf(Value));
  end;

  procedure WriteString(const Value: string);
  var
    L: Integer;
  begin
    L := Length(Value);
    if L <= 255 then
    begin
      WriteValue(vaString);
      Write(L, SizeOf(Byte));
    end else
    begin
      WriteValue(vaLString);
      Write(L, SizeOf(Integer));
    end;
    Write(Pointer(Value)^, L);
  end;

  procedure WriteInteger(Value: Longint);
  begin
    if (Value >= Low(ShortInt)) and (Value <= High(ShortInt)) then
    begin
      WriteValue(vaInt8);
      Write(Value, SizeOf(Shortint));
    end
    else
    if (Value >= Low(SmallInt)) and (Value <= High(SmallInt)) then
    begin
      WriteValue(vaInt16);
      Write(Value, SizeOf(Smallint));
    end
    else
    begin
      WriteValue(vaInt32);
      Write(Value, SizeOf(Integer));
    end;
  end;

  procedure WriteFloat(const Value: Extended);
  begin
    WriteValue(vaExtended);
    Write(Value, SizeOf(Extended));
  end;

  {$IFDEF DELPHI4}
  procedure WriteWideString(const Value: WideString);
  var
    L: Integer;
  begin
    WriteValue(vaWString);
    L := Length(Value);
    Write(L, SizeOf(Integer));
    Write(Pointer(Value)^, L * 2);
  end;

  procedure WriteSingle(const Value: Single);
  begin
    WriteValue(vaSingle);
    Write(Value, SizeOf(Single));
  end;

  procedure WriteCurrency(const Value: Currency);
  begin
    WriteValue(vaCurrency);
    Write(Value, SizeOf(Currency));
  end;

  procedure WriteDate(const Value: TDateTime);
  begin
    WriteValue(vaDate);
    Write(Value, SizeOf(TDateTime));
  end;
  {$ENDIF}

var
  VType: Integer;
begin
  if VarIsArray(AValue) then
    raise EWriteError.Create(SWriteError);
  VType := VarType(AValue);
  case VType and varTypeMask of
    varEmpty:
      WriteValue(vaNil);
    varNull:
      WriteValue(vaNull);
    varString:
      WriteString(AValue);
    varByte, varSmallInt, varInteger:
      WriteInteger(AValue);
    varDouble:
      WriteFloat(AValue);
    varBoolean:
      if AValue then
        WriteValue(vaTrue)
      else
        WriteValue(vaFalse);
    {$IFDEF DELPHI4}
    varOleStr:
      WriteWideString(AValue);
    varSingle:
      WriteSingle(AValue);
    varCurrency:
      WriteCurrency(AValue);
    varDate:
      WriteDate(AValue);
    {$ENDIF}  
  else
    try
      WriteString(AValue);
    except
      raise EWriteError.Create(SWriteError);
    end;
  end;
end;

{ TdxNullOperator }

function TdxNullOperator.CompareValues(const Value1, Value2: Variant): Boolean;
begin
  Result := VarEqualNull(Value1);
end;

function TdxNullOperator.OperatorString: string;
begin
  Result := 'Is Null';
end;

{ TdxEqualOperator }

function TdxEqualOperator.CompareValues(const Value1, Value2: Variant): Boolean;
begin
  Result := (Value1 = Value2); // TODO Soft Compare ? or (VarEqualNull(Value1) and VarEqualNull(Value2));
end;

function TdxEqualOperator.OperatorString: string;
begin
  Result := '=';
end;

{ TdxGreaterOperator }

function TdxGreaterOperator.CompareValues(const Value1, Value2: Variant): Boolean;
begin
  {$IFNDEF DELPHI6}
  Result := (Value1 > Value2);
  {$ELSE}
  Result := VarCompare(Value1, Value2) > 0;
  {$ENDIF}
end;

function TdxGreaterOperator.OperatorString: string;
begin
  Result := '>';
end;

{ TdxLessOperator }

function TdxLessOperator.CompareValues(const Value1, Value2: Variant): Boolean;
begin
  {$IFNDEF DELPHI6}
  Result := (Value1 < Value2);
  {$ELSE}
  Result := VarCompare(Value1, Value2) < 0;
  {$ENDIF}
end;

function TdxLessOperator.OperatorString: string;
begin
  Result := '<';
end;

{ TdxGreaterEqualOperator }

function TdxGreaterEqualOperator.CompareValues(const Value1, Value2: Variant): Boolean;
begin
  {$IFNDEF DELPHI6}
  Result := (Value1 >= Value2);
  {$ELSE}
  Result := VarCompare(Value1, Value2) >= 0;
  {$ENDIF}
end;

function TdxGreaterEqualOperator.OperatorString: string;
begin
  Result := '>=';
end;

{ TdxLessEqualOperator }

function TdxLessEqualOperator.CompareValues(const Value1, Value2: Variant): Boolean;
begin
  {$IFNDEF DELPHI6}
  Result := (Value1 <= Value2);
  {$ELSE}
  Result := VarCompare(Value1, Value2) <= 0;
  {$ENDIF}
end;

function TdxLessEqualOperator.OperatorString: string;
begin
  Result := '<=';
end;

{ TdxCustomCriteriaItem }

constructor TdxCustomCriteriaItem.Create(AOwner: TdxCriteriaItemList);
begin
  inherited Create;
  FParent := AOwner;
  IsNot := False;
end;

destructor TdxCustomCriteriaItem.Destroy;
begin
  if (FParent <> nil) and not FParent.Destroying then
    FParent.FList.Remove(Self);
  inherited Destroy;
end;

procedure TdxCustomCriteriaItem.ReadData(Stream: TStream);
begin
end;

procedure TdxCustomCriteriaItem.WriteData(Stream: TStream);
var
  ABooleanValue: Boolean;
begin
  ABooleanValue := IsItemList;
  Stream.WriteBuffer(ABooleanValue, SizeOf(ABooleanValue));
  ABooleanValue := IsNot;
  Stream.WriteBuffer(ABooleanValue, SizeOf(ABooleanValue));
end;

{ TdxCriteriaItemList }

constructor TdxCriteriaItemList.Create(AOwner: TdxCriteriaItemList);
begin
  inherited Create(AOwner);
  FList := TList.Create;
  FCriteria := nil;
  FDestroying := False;
  FBoolOperator := boAnd;
end;

destructor TdxCriteriaItemList.Destroy;
begin
  FDestroying := True;
  Clear;
  FList.Free;
  inherited Destroy;
end;

function TdxCriteriaItemList.AddItem(const AID: string; AOperator: TdxOperatorType;
  const AValue: Variant; const ADisplayValue: string): TdxCriteriaItem;
begin
  Result := Criteria.GetItemClass.Create(Self);
  Result.DisplayValue := ADisplayValue;
  Result.ID := AID;
  Result.Operator := AOperator;
  Result.Value := AValue;
  FList.Add(Result);
end;

function TdxCriteriaItemList.AddList(ABoolOperator: TdxBoolOperator) : TdxCriteriaItemList;
begin
  Result := TdxCriteriaItemList.Create(Self);
  Result.FBoolOperator := ABoolOperator;
  FList.Add(Result);
end;

procedure TdxCriteriaItemList.Clear;
var
  I: Integer;
  OldDestroying: Boolean;
begin
  OldDestroying := FDestroying;
  FDestroying := True;
  for I := 0 to Count - 1 do
    Items[I].Free;
  FList.Clear;
  FDestroying := OldDestroying;
end;

function TdxCriteriaItemList.GetIsItemList: Boolean;
begin
  Result := True;
end;

procedure TdxCriteriaItemList.WriteData(Stream: TStream);
var
  I: Integer;
  ABoolOperator: TdxBoolOperator;
begin
  inherited WriteData(Stream);
  ABoolOperator := BoolOperator;
  Stream.WriteBuffer(ABoolOperator, SizeOf(ABoolOperator));
  I := Count;
  Stream.WriteBuffer(I, SizeOf(I));
  for I := 0 to Count - 1 do
    Items[I].WriteData(Stream);
end;

function TdxCriteriaItemList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TdxCriteriaItemList.GetCriteria: TdxCriteria;
begin
  if FCriteria = nil then
    Result := FParent.GetCriteria
  else
    Result := FCriteria;
end;

function TdxCriteriaItemList.GetItem(AIndex: Integer): TdxCustomCriteriaItem;
begin
  if (AIndex > -1) and (AIndex < Count) then
    Result := TdxCustomCriteriaItem(FList[AIndex])
  else
    Result := nil;
end;

{ TdxCriteriaItem }

function TdxCriteriaItem.GetCaption: string;
begin
  Result := FID;
end;

function TdxCriteriaItem.GetIsItemList: Boolean;
begin
  Result := False;
end;

procedure TdxCriteriaItem.WriteData(Stream: TStream);
begin
  inherited WriteData(Stream);
  WriteString(Stream, DisplayValue);
  WriteString(Stream, ID);
  Stream.WriteBuffer(Operator, SizeOf(Operator));
  WriteVariant(Stream, Value);
end;

{ TdxCriteria }

constructor TdxCriteria.Create;
begin
  inherited Create;
  FRoot := TdxCriteriaItemList.Create(nil);
  FRoot.FCriteria := Self;
end;

destructor TdxCriteria.Destroy;
begin
  FRoot.Free;
  FRoot := nil;
  inherited Destroy;
end;

procedure TdxCriteria.Clear;
begin
  Root.Clear;
  Root.IsNot := False;
  Root.BoolOperator := boAnd;
end;

function TdxCriteria.FilterCaption: string;
begin
  Result := GetFilterText(True);
end;

function TdxCriteria.FilterText: string;
begin
  Result := GetFilterText(False);
end;

function TdxCriteria.FindItemByName(const AName: string): TdxCriteriaItem;

  procedure FindInBranch(Branch: TdxCriteriaItemList);
  var
    I: integer;
  begin
    for I := 0 to Branch.Count - 1 do
    begin
      if Result <> nil then
        Break;
      if TdxCustomCriteriaItem(Branch.Items[I]).IsItemList then
        FindInBranch(TdxCriteriaItemList(Branch.Items[I]))
      else
        if TdxCriteriaItem(Branch.Items[I]).ID = AName then
        begin
          Result := TdxCriteriaItem(Branch.Items[I]);
          Break;
        end;
    end;
  end;

begin
  Result := nil;
  FindInBranch(Root);
end;

procedure TdxCriteria.Prepare;
begin
end;

procedure TdxCriteria.RemoveItemByName(const AName: string);

  procedure CheckEmptyList(AParent: TdxCriteriaItemList); // TODO move to Destroy ?
  var
    ANewParent: TdxCriteriaItemList;
    AItem: TdxCustomCriteriaItem;
  begin
    if AParent = FRoot then Exit;
    if AParent.Count = 0 then
      AParent.Free
    else
      if AParent.Count = 1 then // Move
      begin
        ANewParent := AParent.Parent;
        AItem := AParent.Items[0];
        ANewParent.FList.Remove(AParent);
        ANewParent.FList.Add(AItem);
        AItem.FParent := ANewParent;
        AParent.FList.Clear;
        AParent.Free;
      end;
  end;

var
  AItem: TdxCriteriaItem;
  AParent: TdxCriteriaItemList;
begin
  AItem := FindItemByName(AName);  // TODO Item List
  while AItem <> nil do
  begin
    AParent := AItem.Parent;
    AItem.Free;
    CheckEmptyList(AParent);
    AItem := FindItemByName(AName);
  end;
end;

function TdxCriteria.DoFilterData(AData: Pointer): Boolean;

  function Compare(AItem: TdxCriteriaItem): Boolean;
  var
    V1, V2: Variant;
  begin
    V1 := PrepareValue(AItem.GetDataValue(AData));
    V2 := PrepareValue(AItem.Value);
    Result := OperatorClassList[AItem.Operator].CompareValues(V1, V2);
  end;

  function DoFilterBranch(Branch: TdxCriteriaItemList): Boolean;
  var
    I: Integer;
    Item: TdxCriteriaItem;
    ExpResult: Boolean;
  begin
    Result := True;
    for I := 0 to Branch.Count - 1 do
      if Branch.Items[I].IsItemList then
      begin
        ExpResult := DoFilterBranch(TdxCriteriaItemList(Branch.Items[I]));
        if Branch.BoolOperator = boAnd then
          Result := Result and ExpResult
        else
          Result := Result or ExpResult;
      end
      else
      begin
        Item := TdxCriteriaItem(Branch.Items[I]);
//        ExpResult := OperatorClassList[Item.Operator].CompareValues(Item.GetDataValue(AData), Item.Value);
        ExpResult := Compare(Item);
        if Branch.Items[I].IsNot then
          ExpResult := not ExpResult;
        if I = 0 then
          Result := ExpResult
        else
          if Branch.BoolOperator = boAnd then
            Result := Result and ExpResult
          else
            Result := Result or ExpResult;
      end;
    if Branch.IsNot then
      Result := not Result;
  end;

begin
  Result := DoFilterBranch(Root);
end;

function TdxCriteria.GetFilterText(AIsCaption: Boolean): string;

  function GetCriteriaText(AItem: TdxCriteriaItem): string;
  begin
    if AIsCaption then
      Result := AItem.GetCaption
    else
      Result := AItem.GetText;
  end;

  function GetCriteriaValue(AItem: TdxCriteriaItem): string;
  var
    AVarType: Integer;
  begin
    if AIsCaption then
      Result := AItem.DisplayValue
    else
    begin
      Result := VarToStr(AItem.Value);
      AVarType := VarType(AItem.Value);
      if  (AVarType = varString) or (AVarType = varDate) then
        Result := '''' + Result + '''';
    end;
  end;

  function BoolOpToStr(BoolOp: TdxBoolOperator): string;
  begin
    if BoolOp = boAnd then
      Result := 'AND'
    else
      Result := 'OR';
  end;

  function FilterSubString(Branch: TdxCriteriaItemList): string;
  var
    I: Integer;
    SubExp: string;
    AItem: TdxCriteriaItem;
  begin
    Result := '';
    for I := 0 to Branch.Count - 1 do
    begin
      if Branch.Items[I].IsItemList then
        Result := Result + '(' + FilterSubString(TdxCriteriaItemList(Branch.Items[I])) + ')'
      else
      begin
        AItem := TdxCriteriaItem(Branch.Items[I]);
        SubExp := GetCriteriaText(AItem);
        // TODO = NULL is Blank + SQL
        SubExp := SubExp +  ' ' + OperatorClassList[AItem.Operator].OperatorString;
        if AItem.Operator <> otIsNull then
          SubExp := SubExp + ' ' + GetCriteriaValue(AItem);

        if AItem.IsNot then
          SubExp := 'NOT (' + SubExp + ')';
        Result := Result + '(' + SubExp + ')';
      end;
      if I < Branch.Count - 1 then
        Result := Result + ' ' + BoolOpToStr(Branch.BoolOperator) + ' ';
    end;
    if Branch.IsNot then
      Result := 'NOT (' + Result + ')';
  end;

begin
  Result := FilterSubString(Root);
end;

function TdxCriteria.GetItemClass: TdxCriteriaItemClass;
begin
  Result := TdxCriteriaItem;
end;

function TdxCriteria.PrepareValue(const AValue: Variant): Variant;
begin
  Result := AValue;
end;

procedure TdxCriteria.ReadData(Stream: TStream);
var
  I, ItemCount: Integer;
begin
  Clear;
  Stream.ReadBuffer(ItemCount, SizeOf(ItemCount));
  for I := 0 to ItemCount - 1 do
    ReadItem(Stream, Root);
end;

procedure TdxCriteria.WriteData(Stream: TStream);
var
  I: Integer;
begin
  I := Root.Count;
  Stream.WriteBuffer(I, SizeOf(I));
  for I := 0 to Root.Count - 1 do
    Root.Items[I].WriteData(Stream);
end;

procedure TdxCriteria.ReadItem(Stream: TStream; AItemList: TdxCriteriaItemList);
var
  I, ItemCount: Integer;
  AItem: TdxCustomCriteriaItem;
  AIsItemList, AIsNot: Boolean;
  ABoolOperator: TdxBoolOperator;
  ADisplayValue, AID: string;
  AOperator: TdxOperatorType;
  AValue: Variant;
begin
  Stream.ReadBuffer(AIsItemList, SizeOf(AIsItemList));
  Stream.ReadBuffer(AIsNot, SizeOf(AIsNot));
  if AIsItemList then
  begin
    Stream.ReadBuffer(ABoolOperator, SizeOf(ABoolOperator));
    AItem := AItemList.AddList(ABoolOperator);
    Stream.ReadBuffer(ItemCount, SizeOf(ItemCount));
    for I := 0 to ItemCount - 1 do
      ReadItem(Stream, TdxCriteriaItemList(AItem));
  end
  else
  begin
    ReadString(Stream, ADisplayValue);
    ReadString(Stream, AID);
    Stream.ReadBuffer(AOperator, SizeOf(AOperator));
    ReadVariant(Stream, AValue);
    AItem := AItemList.AddItem(AID, AOperator, AValue, ADisplayValue);
  end;
  AItem.IsNot := AIsNot;
  AItem.ReadData(Stream);
end;

procedure CreateOperatorClassList;
var
  I: TdxOperatorType;
begin
  for I := Low(TdxOperatorType) to High(TdxOperatorType) do
    OperatorClassList[I] := OperatorClasses[I].Create;
end;

procedure DestroyOperatorClassList;
var
  I: TdxOperatorType;
begin
  for I := Low(TdxOperatorType) to High(TdxOperatorType) do
    OperatorClassList[I].Free;
end;

initialization
  CreateOperatorClassList;

finalization
  DestroyOperatorClassList;

end.
