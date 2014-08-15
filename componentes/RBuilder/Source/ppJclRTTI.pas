{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the Project JEDI Code Library (JCL). The original header appears     }
{ in the box below.                                                                                }
{                                                                                                  }
{ original unit: JclRTTI.pas                                                                       }
{                                                                                                  }
{ This unit is a subset of the original. It contains only types, classes and methods,              }
{ required to support the JvInspector and related classes. A prefix of pp has been added           }
{ to all classes and methods to differentiate them from the original. This has been done to        }
{ avoid conflicts for users that install ReportBuilder and the JCL.                                }
{                                                                                                  }
{**************************************************************************************************}

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclRTTI.pas.                                                                }
{                                                                                                  }
{ The Initial Developer of the Original Code is documented in the accompanying                     }
{ help file JCL.chm. Portions created by these individuals are Copyright (C) of these individuals. }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Various RunTime Type Information routines. Includes retrieving RTTI information for different    }
{ types, declaring/generating new types, data conversion to user displayable values and 'is'/'as'  }
{ operator hooking.                                                                                }
{                                                                                                  }
{ Unit owner: Marcel Bestebroer                                                                    }
{ Last modified: July 21, 2001                                                                     }
{                                                                                                  }
{**************************************************************************************************}

unit ppJclRTTI;

interface


uses
  Windows,
  SysUtils,
  TypInfo,
  Classes,

  ppCharacter,

  ppJclBase;

type
  EppJclRTTI = class (EppJclError);


//--------------------------------------------------------------------------------------------------
// TypeInfo writing
//--------------------------------------------------------------------------------------------------

type
  IppJclInfoWriter = interface
    ['{7DAD522D-46EA-11D5-B0C0-4854E825F345}']
    function GetWrap: Integer;
    procedure SetWrap(const Value: Integer);
    procedure Write(const S: string);
    procedure Writeln(const S: string = '');
    procedure Indent;
    procedure Outdent;
    property Wrap: Integer read GetWrap write SetWrap;
  end;

  TppJclInfoWriter = class(TInterfacedObject, IppJclInfoWriter)
  private
    FCurLine: string;
    FIndentLevel: Integer;
    FWrap: Integer;
  protected
    function GetWrap: Integer;
    procedure SetWrap(const Value: Integer);
    procedure DoWrap;
    procedure DoWriteCompleteLines;
    procedure PrimWrite(const S: string); virtual; abstract;

    property CurLine: string read FCurLine write FCurLine;
    property IndentLevel: Integer read FIndentLevel write FIndentLevel;
  public
    constructor Create(const AWrap: Integer = 80);
    destructor Destroy; override;
    procedure Indent;
    procedure Outdent;
    procedure Write(const S: string);
    procedure Writeln(const S: string = '');

    property Wrap: Integer read GetWrap write SetWrap;
  end;

  TppJclInfoStringsWriter = class(TppJclInfoWriter)
  private
    FStrings: TStrings;
  protected
    procedure PrimWrite(const S: string); override;
  public
    constructor Create(const AStrings: TStrings; const AWrap: Integer = 80);

    property Strings: TStrings read FStrings;
  end;
//--------------------------------------------------------------------------------------------------
// TypeInfo retreival
//--------------------------------------------------------------------------------------------------

type
  IppJclBaseInfo = interface
    procedure WriteTo(const Dest: IppJclInfoWriter);
    procedure DeclarationTo(const Dest: IppJclInfoWriter);
  end;

  IppJclTypeInfo = interface(IppJclBaseInfo)
    ['{7DAD5220-46EA-11D5-B0C0-4854E825F345}']
    function GetName: string;
    function GetTypeData: PTypeData;
    function GetTypeInfo: PTypeInfo;
    function GetTypeKind: TTypeKind;

    property Name: string read GetName;
    property TypeData: PTypeData read GetTypeData;
    property TypeInfo: PTypeInfo read GetTypeInfo;
    property TypeKind: TTypeKind read GetTypeKind;
  end;

  // Ordinal types
  IppJclOrdinalTypeInfo = interface(IppJclTypeInfo)
    ['{7DAD5221-46EA-11D5-B0C0-4854E825F345}']
    function GetOrdinalType: TOrdType;

    property OrdinalType: TOrdType read GetOrdinalType;
  end;

  IppJclOrdinalRangeTypeInfo = interface(IppJclOrdinalTypeInfo)
    ['{7DAD5222-46EA-11D5-B0C0-4854E825F345}']
    function GetMinValue: Int64;
    function GetMaxValue: Int64;

    property MinValue: Int64 read GetMinValue;
    property MaxValue: Int64 read GetMaxValue;
  end;

  IppJclEnumerationTypeInfo = interface(IppJclOrdinalRangeTypeInfo)
    ['{7DAD5223-46EA-11D5-B0C0-4854E825F345}']
    function GetBaseType: IppJclEnumerationTypeInfo;
    function GetNames(const I: Integer): string;
    function GetEnumUnitName: string;

    function IndexOfName(const Name: string): Integer;

    property BaseType: IppJclEnumerationTypeInfo read GetBaseType;
    property Names[const I: Integer]: string read GetNames; default;
    property EnumUnitName: string read GetEnumUnitName;
  end;

  IppJclSetTypeInfo = interface(IppJclOrdinalTypeInfo)
    ['{7DAD5224-46EA-11D5-B0C0-4854E825F345}']
    function GetBaseType: IppJclOrdinalTypeInfo;

    procedure GetAsList(const Value;  const WantRanges: Boolean;
      const Strings: TStrings);
    procedure SetAsList(out Value; const Strings: TStrings);

    property BaseType: IppJclOrdinalTypeInfo read GetBaseType;
  end;

  // Float types
  IppJclFloatTypeInfo = interface(IppJclTypeInfo)
    ['{7DAD5225-46EA-11D5-B0C0-4854E825F345}']
    function GetFloatType: TFloatType;

    property FloatType: TFloatType read GetFloatType;
  end;


function JclTypeInfo(const ATypeInfo: PTypeInfo): IppJclTypeInfo;

//--------------------------------------------------------------------------------------------------
// Enumeration types
//--------------------------------------------------------------------------------------------------

const
  PREFIX_CUT_LOWERCASE = 255;
  PREFIX_CUT_EQUAL     = 254;

  MaxPrefixCut = 250;

function ppJclEnumValueToIdent(const TypeInfo: PTypeInfo; const Value): string;
function ppJclGenerateEnumType(const TypeName: ShortString;
  const Literals: array of string): PTypeInfo;
function ppJclGenerateEnumTypeBasedOn(const TypeName: ShortString;
  const BaseType: PTypeInfo; const PrefixCut: Byte): PTypeInfo;
function ppJclGenerateSubRange(const BaseType: PTypeInfo; const TypeName: string;
  const MinValue, MaxValue: Integer): PTypeInfo;

//--------------------------------------------------------------------------------------------------
// Sets
//--------------------------------------------------------------------------------------------------

function ppJclSetToList(const TypeInfo: PTypeInfo; const Value; const WantBrackets: Boolean;
  const WantRanges: Boolean; const Strings: TStrings): string;
function ppJclSetToStr(const TypeInfo: PTypeInfo; const Value;
  const WantBrackets: Boolean = False; const WantRanges: Boolean = False): string;
procedure ppJclStrToSet(const TypeInfo: PTypeInfo; var SetVar; const Value: string);
procedure ppJclIntToSet(const TypeInfo: PTypeInfo; var SetVar; const Value: Integer);
function ppJclSetToInt(const TypeInfo: PTypeInfo; const SetVar): Integer;
function ppJclGenerateSetType(const BaseType: PTypeInfo; const TypeName: ShortString): PTypeInfo;

//--------------------------------------------------------------------------------------------------
// Integer types
//--------------------------------------------------------------------------------------------------

function ppJclStrToTypedInt(Value: string; TypeInfo: PTypeInfo): Integer;
function ppJclTypedIntToStr(Value: Integer; TypeInfo: PTypeInfo): string;


implementation

uses
  ppJclStrings,
  ppJclResources,
  ppJclLogic;


//--------------------------------------------------------------------------------------------------
// TppJclInfoWriter
//--------------------------------------------------------------------------------------------------

function TppJclInfoWriter.GetWrap: Integer;
begin
  Result := FWrap;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.SetWrap(const Value: Integer);
begin
  FWrap := Value;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.DoWrap;
var
  TmpLines: TStringList;
  I: Integer;
  TmpLines2: TStringList;
  EndedInCRLF: Boolean;
begin
  EndedInCRLF := Copy(CurLine, Length(CurLine) - 1, 2) = cCrLf;
  TmpLines := TStringList.Create;
  try
    TmpLines.Text := CurLine;
    TmpLines2 := TStringList.Create;
    try
      I := TmpLines.Count-1;
      if not EndedInCRLF then
        Dec(I);
      while I >= 0 do
      begin
        TmpLines[I] := StringOfChar(' ', 2 * IndentLevel) + TmpLines[I];
        if (Wrap > 0) and (Length(TmpLines[I]) > Wrap) then
        begin
          TmpLines2.Text := WrapText(
            TmpLines[I],
            cCrLf + StringOfChar(' ', 2 * (IndentLevel+1)),
            [#0 .. ' ', '-'],
            Wrap);
          TmpLines.Delete(I);
          TmpLines.Insert(I, Copy(TmpLines2.Text, 1,
            Length(TmpLines2.Text) - 2));
        end;
        Dec(I);
      end;
      CurLine := TmpLines.Text;
      if not EndedInCRLF then
        Delete(FCurLine, Length(FCurLine) - 1, 2);
    finally
      TmpLines2.Free;
    end;
  finally
    TmpLines.Free;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.DoWriteCompleteLines;
var
  CRLFPos: Integer;
begin
  CRLFPos := ppJclStrLastPos(cCrLf, CurLine);
  if CRLFPos > 0 then
  begin
    PrimWrite(Copy(CurLine, 1, CRLFPos-1));
    Delete(FCurLine, 1, CRLFPos+1);
  end;
end;

//--------------------------------------------------------------------------------------------------

constructor TppJclInfoWriter.Create(const AWrap: Integer);
begin
  inherited Create;
  Wrap := AWrap;
end;

//--------------------------------------------------------------------------------------------------

destructor TppJclInfoWriter.Destroy;
begin
  if CurLine <> '' then
    Writeln('');
  inherited Destroy;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.Indent;
begin
  IndentLevel := IndentLevel + 1;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.Outdent;
begin
  IndentLevel := IndentLevel - 1;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.Write(const S: string);
begin
  CurLine := CurLine + S;
  DoWrap;
  DoWriteCompleteLines;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclInfoWriter.Writeln(const S: string);
begin
  Write(S + cCrLf);
end;

//--------------------------------------------------------------------------------------------------
// TppJclInfoStringsWriter
//--------------------------------------------------------------------------------------------------

procedure TppJclInfoStringsWriter.PrimWrite(const S: string);
begin
  Strings.Add(S);
end;

//--------------------------------------------------------------------------------------------------

constructor TppJclInfoStringsWriter.Create(const AStrings: TStrings;
  const AWrap: Integer);
begin
  inherited Create(AWrap);
  FStrings := AStrings;
end;

//--------------------------------------------------------------------------------------------------
// TppJclTypeInfo
//--------------------------------------------------------------------------------------------------

type
  TppJclTypeInfo = class(TInterfacedObject, IppJclTypeInfo)
  private
    FTypeData: PTypeData;
    FTypeInfo: PTypeInfo;
  protected
    function GetName: string;
    function GetTypeData: PTypeData;
    function GetTypeInfo: PTypeInfo;
    function GetTypeKind: TTypeKind;
    procedure WriteTo(const Dest: IppJclInfoWriter); virtual;
    procedure DeclarationTo(const Dest: IppJclInfoWriter); virtual;
  public
    constructor Create(const ATypeInfo: PTypeInfo);

    property Name: string read GetName;
    property TypeData: PTypeData read GetTypeData;
    property TypeInfo: PTypeInfo read GetTypeInfo;
    property TypeKind: TTypeKind read GetTypeKind;
  end;

//--------------------------------------------------------------------------------------------------

function TppJclTypeInfo.GetName: string;
begin
  Result := String(TypeInfo.Name);
end;

//--------------------------------------------------------------------------------------------------

function TppJclTypeInfo.GetTypeData: PTypeData;
begin
  Result := FTypeData;
end;

//--------------------------------------------------------------------------------------------------

function TppJclTypeInfo.GetTypeInfo: PTypeInfo;
begin
  Result := FTypeInfo;
end;

//--------------------------------------------------------------------------------------------------

function TppJclTypeInfo.GetTypeKind: TTypeKind;
begin
  Result := TypeInfo.Kind
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclTypeInfo.WriteTo(const Dest: IppJclInfoWriter);
begin
  Dest.Writeln(ppJclRsRTTIName + Name);
  Dest.Writeln(ppJclRsRTTITypeKind + ppJclEnumValueToIdent(System.TypeInfo(TTypeKind),
    TypeInfo.Kind));
  Dest.Writeln(Format(ppJclRsRTTITypeInfoAt, [TypeInfo]));
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclTypeInfo.DeclarationTo(const Dest: IppJclInfoWriter);
begin
  Dest.Write('// Declaration for ''' + Name + ''' not supported.');
end;

//--------------------------------------------------------------------------------------------------

constructor TppJclTypeInfo.Create(const ATypeInfo: PTypeInfo);
begin
  inherited Create;
  FTypeInfo := ATypeInfo;
  FTypeData := TypInfo.GetTypeData(ATypeInfo);
end;

//--------------------------------------------------------------------------------------------------
// TppJclOrdinalTypeInfo
//--------------------------------------------------------------------------------------------------

type
  TppJclOrdinalTypeInfo = class(TppJclTypeInfo, IppJclOrdinalTypeInfo)
  private
  protected
    function GetOrdinalType: TOrdType;
    procedure WriteTo(const Dest: IppJclInfoWriter); override;
  public
    property OrdinalType: TOrdType read GetOrdinalType;
  end;

//--------------------------------------------------------------------------------------------------

function TppJclOrdinalTypeInfo.GetOrdinalType: TOrdType;
begin
  Result := TypeData.OrdType;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclOrdinalTypeInfo.WriteTo(const Dest: IppJclInfoWriter);
begin
  inherited WriteTo(Dest);
  Dest.Writeln(ppJclRsRTTIOrdinalType + ppJclEnumValueToIdent(
    System.TypeInfo(TOrdType), TypeData.OrdType));
end;

//--------------------------------------------------------------------------------------------------
// TppJclOrdinalRangeTypeInfo
//--------------------------------------------------------------------------------------------------

type
  TppJclOrdinalRangeTypeInfo = class(TppJclOrdinalTypeInfo,
    IppJclOrdinalRangeTypeInfo)
  private
  protected
    function GetMinValue: Int64;
    function GetMaxValue: Int64;
    procedure WriteTo(const Dest: IppJclInfoWriter); override;
    procedure DeclarationTo(const Dest: IppJclInfoWriter); override;
  public
    property MinValue: Int64 read GetMinValue;
    property MaxValue: Int64 read GetMaxValue;
  end;

//--------------------------------------------------------------------------------------------------

function TppJclOrdinalRangeTypeInfo.GetMinValue: Int64;
begin
  if OrdinalType = otULong then
    Result := Longword(TypeData.MinValue)
  else
    Result := TypeData.MinValue;
end;

//--------------------------------------------------------------------------------------------------

function TppJclOrdinalRangeTypeInfo.GetMaxValue: Int64;
begin
  if OrdinalType = otULong then
    Result := Longword(TypeData.MaxValue)
  else
    Result := TypeData.MaxValue;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclOrdinalRangeTypeInfo.WriteTo(const Dest: IppJclInfoWriter);
begin
  inherited WriteTo(Dest);
  Dest.Writeln(ppJclRsRTTIMinValue + IntToStr(MinValue));
  Dest.Writeln(ppJclRsRTTIMaxValue + IntToStr(MaxValue));
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclOrdinalRangeTypeInfo.DeclarationTo(const Dest: IppJclInfoWriter);
begin
  Dest.Write(Name + ' = ');
  if TypeInfo.Kind in [tkChar, tkWChar] then
  begin
    if (MinValue < Ord(' ')) or (MinValue > Ord('~')) then
      Dest.Write('#' + IntToStr(MinValue) + ' .. ')
    else
      Dest.Write('''' + Chr(Byte(MinValue)) + ''' .. ');
    if (MaxValue < Ord(' ')) or (MaxValue > Ord('~')) then
      Dest.Write('#' + IntToStr(MaxValue) + '; // ')
    else
      Dest.Write('''' + Chr(Byte(MaxValue)) + '''; // ');
  end
  else
    Dest.Write(IntToStr(MinValue) + ' .. ' + IntToStr(MaxValue) + '; // ');
  Dest.Write(ppJclEnumValueToIdent(System.TypeInfo(TOrdType), TypeData.OrdType));
  Dest.Writeln('');
end;

//--------------------------------------------------------------------------------------------------
// TppJclEnumerationTypeInfo
//--------------------------------------------------------------------------------------------------

type
  TppJclEnumerationTypeInfo = class(TppJclOrdinalRangeTypeInfo,
    IppJclEnumerationTypeInfo)
  private
  protected
    function GetBaseType: IppJclEnumerationTypeInfo;
    function GetEnumUnitName: string;
    function GetNames(const I: Integer): string;
    function IndexOfName(const Name: string): Integer;
    procedure WriteTo(const Dest: IppJclInfoWriter); override;
    procedure DeclarationTo(const Dest: IppJclInfoWriter); override;
  public
    property BaseType: IppJclEnumerationTypeInfo read GetBaseType;
    property Names[const I: Integer]: string read GetNames; default;
    property EnumUnitName: string read GetEnumUnitName;
  end;

//--------------------------------------------------------------------------------------------------

function TppJclEnumerationTypeInfo.GetBaseType: IppJclEnumerationTypeInfo;
begin
  if TypeData.BaseType^ = TypeInfo then
    Result := Self
  else
    Result := TppJclEnumerationTypeInfo.Create(TypeData.BaseType^);
end;

//--------------------------------------------------------------------------------------------------

function TppJclEnumerationTypeInfo.GetNames(const I: Integer): string;
var
  Base: IppJclEnumerationTypeInfo;
  Idx: Integer;
  P: ^ShortString;
begin
  Base := BaseType;
  Idx := I;
  P := @Base.TypeData.NameList;
  while Idx <> 0 do
  begin
    Inc(Integer(P), Length(P^) + 1);
    Dec(Idx);
  end;
  Result := String(P^);
end;

//--------------------------------------------------------------------------------------------------


function TppJclEnumerationTypeInfo.GetEnumUnitName: string;
var
  I: Integer;
  P: ^ShortString;
begin
  if BaseType.TypeInfo = TypeInfo then
  begin
    I := MaxValue - MinValue;
    P := @TypeData.NameList;
    while I >= 0 do
    begin
      Inc(Integer(P), Length(P^) + 1);
      Dec(I);
    end;
    Result := String(P^);
  end
  else
    Result := String(TypeData.NameList);
end;


//--------------------------------------------------------------------------------------------------

function TppJclEnumerationTypeInfo.IndexOfName(const Name: string): Integer;
begin
  Result := MaxValue;
  while (Result >= MinValue) and not AnsiSameText(Name, Names[Result]) do
    Dec(Result);
  if Result < MinValue then
    Result := -1;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclEnumerationTypeInfo.WriteTo(const Dest: IppJclInfoWriter);
var
  Idx: Integer;
  Prefix: string;
begin
  inherited WriteTo(Dest);
  Dest.Writeln(ppJclRsRTTIUnitName + EnumUnitName);
  Dest.Write(ppJclRsRTTINameList);
  Prefix := '(';
  for Idx := MinValue to MaxValue do
  begin
    Dest.Write(Prefix + Names[Idx]);
    Prefix := ', ';
  end;
  Dest.Writeln(')');
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclEnumerationTypeInfo.DeclarationTo(const Dest: IppJclInfoWriter);
var
  Prefix: string;
  I: Integer;
begin
  if Name[1] <> '.' then
    Dest.Write(Name + ' = ');
  if BaseType.TypeInfo = TypeInfo then
  begin
    Dest.Write('(');
    Prefix := '';
    for I := MinValue to MaxValue do
    begin
      Dest.Write(Prefix + Names[I]);
      Prefix := ', ';
    end;
    Dest.Write(')');
  end
  else
    Dest.Write(Names[MinValue] + ' .. ' + Names[MaxValue]);
  if Name[1] <> '.' then
  begin
    Dest.Write('; // ' + ppJclEnumValueToIdent(System.TypeInfo(TOrdType),
      TypeData.OrdType));
    Dest.Writeln('');
  end;
end;

//--------------------------------------------------------------------------------------------------
// TppJclSetTypeInfo
//--------------------------------------------------------------------------------------------------

type
  TppJclSetTypeInfo = class(TppJclOrdinalTypeInfo, IppJclSetTypeInfo)
  protected
    function GetBaseType: IppJclOrdinalTypeInfo;
    procedure GetAsList(const Value; const WantRanges: Boolean;
      const Strings: TStrings);
    procedure SetAsList(out Value; const Strings: TStrings);
    procedure WriteTo(const Dest: IppJclInfoWriter); override;
    procedure DeclarationTo(const Dest: IppJclInfoWriter); override;
  public
    property BaseType: IppJclOrdinalTypeInfo read GetBaseType;
  end;

//--------------------------------------------------------------------------------------------------

function TppJclSetTypeInfo.GetBaseType: IppJclOrdinalTypeInfo;
begin
  Result := JclTypeInfo(TypeData.CompType^) as IppJclOrdinalTypeInfo;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclSetTypeInfo.GetAsList(const Value; const WantRanges: Boolean;
  const Strings: TStrings);
var
  BaseInfo: IppJclOrdinalRangeTypeInfo;
  FirstBit: Byte;
  LastBit: Byte;
  Bit: Byte;
  StartBit: Integer;

  procedure AddRange;
  var
    FirstOrdNum: Int64;
    LastOrdNum: Int64;
    OrdNum: Int64;
  begin
    FirstOrdNum := (StartBit - FirstBit) + BaseInfo.MinValue;
    LastOrdNum := (Bit - 1 - FirstBit) + BaseInfo.MinValue;
    if WantRanges and (LastOrdNum <> FirstOrdNum) then
    begin
      if BaseInfo.TypeKind = tkEnumeration then
        Strings.Add((BaseInfo as IppJclEnumerationTypeInfo).Names[FirstOrdNum] +
          ' .. ' + (BaseInfo as IppJclEnumerationTypeInfo).Names[LastOrdNum])
      else
        Strings.Add(IntToStr(FirstOrdNum) + ' .. ' + IntToStr(LastOrdNum));
    end
    else
    begin
      OrdNum := FirstOrdNum;
      while OrdNum <= LastOrdNum do
      begin
        if BaseInfo.TypeKind = tkEnumeration then
          Strings.Add((BaseInfo as IppJclEnumerationTypeInfo).Names[OrdNum])
        else
          Strings.Add(IntToStr(OrdNum));
        Inc(OrdNum);
      end;
    end;
  end;

begin
  BaseInfo := BaseType as IppJclOrdinalRangeTypeInfo;
  FirstBit := BaseInfo.MinValue mod 8;
  LastBit := BaseInfo.MaxValue - (BaseInfo.MinValue - FirstBit);
  Bit := FirstBit;
  StartBit := -1;
  while Bit <= LastBit do
  begin
    if ppJclTestBitBuffer(Value, Bit) then
    begin
      if StartBit = -1 then
        StartBit := Bit;
    end
    else
    begin
      if StartBit <> -1 then
      begin
        AddRange;
        StartBit := -1;
      end;
    end;
    Inc(Bit);
  end;
  if StartBit <> -1 then
    AddRange;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclSetTypeInfo.SetAsList(out Value; const Strings: TStrings);
var
  BaseInfo: IppJclOrdinalRangeTypeInfo;
  FirstBit: Integer;
  I: Integer;
  FirstIdent: string;
  LastIdent: string;
  RangePos: Integer;
  FirstOrd: Int64;
  LastOrd: Int64;
  CurOrd: Integer;

  procedure ClearValue;
  var
    LastBit: Integer;
    ByteCount: Integer;
  begin
    LastBit := BaseInfo.MaxValue - BaseInfo.MinValue + 1 + FirstBit;
    ByteCount := (LastBit - FirstBit) div 8;
    if LastBit mod 8 <> 0 then
      Inc(ByteCount);
    FillChar(Value, ByteCount, 0);
  end;

begin
  BaseInfo := BaseType as IppJclOrdinalRangeTypeInfo;
  FirstBit := BaseInfo.MinValue mod 8;
  ClearValue;
  for I := 0 to Strings.Count-1 do
  begin
    if Trim(Strings[I]) <> '' then
    begin
      FirstIdent := Trim(Strings[I]);
      RangePos := Pos('..', FirstIdent);
      if RangePos > 0 then
      begin
        LastIdent := Trim(ppJclStrRestOf(FirstIdent, RangePos + 2));
        FirstIdent := Trim(Copy(FirstIdent, 1, RangePos - 1));
      end
      else
        LastIdent := FirstIdent;
      if BaseInfo.TypeKind = tkEnumeration then
      begin
        FirstOrd := (BaseInfo as IppJclEnumerationTypeInfo).IndexOfName(FirstIdent);
        LastOrd := (BaseInfo as IppJclEnumerationTypeInfo).IndexOfName(LastIdent);
        if FirstOrd = -1 then
          raise EppJclRTTI.CreateResRecFmt(@ppJclRsRTTIUnknownIdentifier, [FirstIdent]);
        if LastOrd = -1 then
          raise EppJclRTTI.CreateResRecFmt(@ppJclRsRTTIUnknownIdentifier, [LastIdent]);
      end
      else
      begin
        FirstOrd := StrToInt(FirstIdent);
        LastOrd := StrToInt(LastIdent);
      end;
      Dec(FirstOrd, BaseInfo.MinValue);
      Dec(LastOrd, BaseInfo.MinValue);
      for CurOrd := FirstOrd to LastOrd do
        ppJclSetBitBuffer(Value, CurOrd + FirstBit);
    end;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclSetTypeInfo.WriteTo(const Dest: IppJclInfoWriter);
begin
  inherited WriteTo(Dest);
  Dest.Writeln(ppJclRsRTTIBasedOn);
  Dest.Indent;
  try
    BaseType.WriteTo(Dest);
  finally
    Dest.Outdent;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclSetTypeInfo.DeclarationTo(const Dest: IppJclInfoWriter);
var
  Base: IppJclOrdinalTypeInfo;
  BaseEnum: IppJclEnumerationTypeInfo;
begin
  if Name[1] <> '.' then
    Dest.Write(Name + ' = set of ');
  Base := BaseType;

  if Base.Name[1] = '.' then
  begin
    if Base.QueryInterface(IppJclEnumerationTypeInfo, BaseEnum) = S_OK then
      BaseEnum.DeclarationTo(Dest)
    else
      Dest.Write(ppJclRsRTTITypeError);
  end
  else
    Dest.Write(Base.Name);
  if Name[1] <> '.' then
  begin
    Dest.Write('; // ' + ppJclEnumValueToIdent(System.TypeInfo(TOrdType),
      TypeData.OrdType));
    Dest.Writeln('');
  end;
end;

//--------------------------------------------------------------------------------------------------
// TppJclFloatTypeInfo
//--------------------------------------------------------------------------------------------------

type
  TppJclFloatTypeInfo = class(TppJclTypeInfo, IppJclFloatTypeInfo)
  protected
    function GetFloatType: TFloatType;
    procedure WriteTo(const Dest: IppJclInfoWriter); override;
    procedure DeclarationTo(const Dest: IppJclInfoWriter); override;
  public
    property FloatType: TFloatType read GetFloatType;
  end;

//--------------------------------------------------------------------------------------------------

function TppJclFloatTypeInfo.GetFloatType: TFloatType;
begin
  Result := TypeData.FloatType;
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclFloatTypeInfo.WriteTo(const Dest: IppJclInfoWriter);
begin
  inherited WriteTo(Dest);
  Dest.Writeln(ppJclRsRTTIFloatType + ppJclEnumValueToIdent(
    System.TypeInfo(TFloatType), TypeData.FloatType));
end;

//--------------------------------------------------------------------------------------------------

procedure TppJclFloatTypeInfo.DeclarationTo(const Dest: IppJclInfoWriter);
var
  S: string;
  FT: TFloatType;
begin
  FT := FloatType;
  S := ppJclStrRestOf(ppJclEnumValueToIdent(System.TypeInfo(TFloatType), FT), 3);
  Dest.Writeln(Name + ' = type ' + S + ';');
end;

//--------------------------------------------------------------------------------------------------
// Typeinfo retreival
//--------------------------------------------------------------------------------------------------

function JclTypeInfo(const ATypeInfo: PTypeInfo): IppJclTypeInfo;
begin
  case ATypeInfo.Kind of
    tkInteger, tkChar, tkWChar:
      Result := TppJclOrdinalRangeTypeInfo.Create(ATypeInfo);
    tkEnumeration:
      Result := TppJclEnumerationTypeInfo.Create(ATypeInfo);
    tkSet:
      Result := TppJclSetTypeInfo.Create(ATypeInfo);
    tkFloat:
      Result := TppJclFloatTypeInfo.Create(ATypeInfo);
//DFM    tkString:
//      Result := TppJclStringTypeInfo.Create(ATypeInfo);
//    tkClass:
//      Result := TppJclClassTypeInfo.Create(ATypeInfo);
//    tkMethod:
//      Result := TppJclEventTypeInfo.Create(ATypeInfo);
//    tkInterface:
//      Result := TppJclInterfaceTypeInfo.Create(ATypeInfo);
//    tkInt64:
//      Result := TppJclInt64TypeInfo.Create(ATypeInfo);
//    tkDynArray:
//      Result := TppJclDynArrayTypeInfo.Create(ATypeInfo);
  else
    Result := TppJclTypeInfo.Create(ATypeInfo);
  end;
end;



//--------------------------------------------------------------------------------------------------
// User generated type info managment
//--------------------------------------------------------------------------------------------------

var
  TypeList: TThreadList;

type
  PTypeItem = ^TTypeItem;
  TTypeItem = record
    TypeInfo: PTypeInfo;
    RefCount: Integer;
  end;

//--------------------------------------------------------------------------------------------------

procedure AddType(const TypeInfo: PTypeInfo);
var
  Item: PTypeItem;
begin
  New(Item);
  try
    Item.TypeInfo := TypeInfo;
    Item.RefCount := 1;
    TypeList.Add(Item);
  except
    Dispose(Item);
    raise;
  end;
end;


//--------------------------------------------------------------------------------------------------

procedure DoRefType(const TypeInfo: PTypeInfo; Add: Integer);
var
  I: Integer;
  List: TList;
begin
  List := TypeList.LockList;
  try
    I := List.Count-1;
    while (I >= 0) and (PTypeItem(List[I]).TypeInfo <> TypeInfo) do
      Dec(I);
    if I > -1 then
      Inc(PTypeItem(List[I]).RefCount, Add);
  finally
    TypeList.UnlockList;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure ReferenceType(const TypeInfo: PTypeInfo);
begin
  DoRefType(TypeInfo, 1);
end;
//--------------------------------------------------------------------------------------------------
// Enumerations
//--------------------------------------------------------------------------------------------------

function ppJclEnumValueToIdent(const TypeInfo: PTypeInfo; const Value): string;
var
  MinEnum: Integer;
  MaxEnum: Integer;
  EnumVal: Int64;
  OrdType: TOrdType;
begin
  OrdType := GetTypeData(TypeInfo).OrdType;
  MinEnum := GetTypeData(TypeInfo).MinValue;
  MaxEnum := GetTypeData(TypeInfo).MaxValue;
  case OrdType of
    otSByte:
      EnumVal := Smallint(Value);
    otUByte:
      EnumVal := Byte(Value);
    otSWord:
      EnumVal := Shortint(Value);
    otUWord:
      EnumVal := Word(Value);
    otSLong:
      EnumVal := Integer(Value);
    otULong:
      EnumVal := Longword(Value);
  else
    EnumVal := 0;
  end;
  // Check range...
  if (EnumVal < MinEnum) or (EnumVal > MaxEnum) then
    Result := Format(LoadResString(@ppJclRsRTTIValueOutOfRange),
      [LoadResString(@ppJclRsRTTIOrdinal) + IntToStr(EnumVal)])
  else
    Result := GetEnumName(TypeInfo, EnumVal);
end;

//--------------------------------------------------------------------------------------------------

function ppJclGenerateEnumType(const TypeName: ShortString;
  const Literals: array of string): PTypeInfo;
type
  PInteger = ^Integer;

var
  StringSize: Integer;
  I: Integer;
  TypeData: PTypeData;
  CurName: PShortString;
begin
  StringSize := 0;
  for I := Low(Literals) to High(Literals) do
    StringSize := StringSize + 1 + Length(Literals[I]);
  Result := AllocMem(SizeOf(TTypeInfo) + SizeOf(TOrdType) +
    (2*SizeOf(Integer)) + SizeOf(PPTypeInfo) +
    StringSize + 1);
  try
    with Result^ do
    begin
      Kind := tkEnumeration;
      Name := TypeName;
    end;
    TypeData := GetTypeData(Result);
    TypeData^.BaseType := AllocMem(SizeOf(Pointer));
    if Length(Literals) < 256 then
      TypeData^.OrdType := otUByte
    else
    if Length(Literals) < 65536 then
      TypeData^.OrdType := otUWord
    else
      TypeData^.OrdType := otULong;
    TypeData^.MinValue := 0;
    TypeData^.MaxValue := Length(Literals)-1;
    TypeData^.BaseType^ := Result;   // No sub-range: basetype points to itself
    CurName := @TypeData^.NameList;
    for I := Low(Literals) to High(Literals) do
    begin
      CurName^ := ShortString(Literals[I]);
      Inc(Integer(CurName), Length(Literals[I])+1);
    end;
    CurName^ := ''; // Unit name unknown
    AddType(Result);
  except
    try
      ReallocMem(Result, 0);
    except
      Result := nil;
    end;
    raise;
  end;
end;

//--------------------------------------------------------------------------------------------------

function ppJclGenerateEnumTypeBasedOn(const TypeName: ShortString;
  const BaseType: PTypeInfo; const PrefixCut: Byte): PTypeInfo;
var
  BaseInfo: IppJclTypeInfo;
  BaseKind: TTypeKind;
  Literals: array of string;
  I: Integer;
  S: string;
begin
  BaseInfo := JclTypeInfo(BaseType);
  BaseKind := BaseInfo.TypeKind;
  if BaseInfo.TypeKind <> tkEnumeration then
    raise EppJclRTTI.CreateResRecFmt(@ppJclRsRTTIInvalidBaseType, [BaseInfo.Name,
      ppJclEnumValueToIdent(System.TypeInfo(TTypeKind), BaseKind)]);
  with BaseInfo as IppJclEnumerationTypeInfo do
  begin
    SetLength(Literals, MaxValue - MinValue + 1);
    for I := MinValue to MaxValue do
    begin
      S := Names[I];
      if PrefixCut = PREFIX_CUT_LOWERCASE then
        while (Length(S) > 0) and ppCharInSet(S[1], ['a' .. 'z']) do
          Delete(S, 1, 1);
      if (PrefixCut > 0) and (PrefixCut < MaxPrefixCut) then
        Delete(S, 1, PrefixCut);
      if S = '' then
        S := Names[I];
      Literals[I- MinValue] := S;
    end;
    if PrefixCut = PREFIX_CUT_EQUAL then
    begin
      S := Literals[High(Literals)];
      I := High(Literals)-1;
      while (I >= 0) and (S > '') do
      begin
        while Copy(Literals[I], 1, Length(S)) <> S do
          Delete(S, Length(S), 1);
        Dec(I);
      end;
      if S > '' then
        for I := Low(Literals) to High(Literals) do
        begin
          Literals[I] := ppJclStrRestOf(Literals[I], Length(S));
          if Literals[I] = '' then
            Literals[I] := Names[I + MinValue];
        end;
    end;
  end;
  Result := ppJclGenerateEnumType(TypeName, Literals);
end;

//--------------------------------------------------------------------------------------------------

function ppJclGenerateSubRange(const BaseType: PTypeInfo; const TypeName: string;
  const MinValue, MaxValue: Integer): PTypeInfo;
var
  TypeData: PTypeData;
begin
  Result := AllocMem(SizeOf(TTypeInfo) + SizeOf(TOrdType) +
    (2*SizeOf(Integer)) + SizeOf(PPTypeInfo));
  try
    with Result^ do
    begin
      Kind := BaseType^.Kind;
      Name := ShortString(TypeName);
    end;
    TypeData := GetTypeData(Result);
    TypeData^.OrdType := GetTypeData(BaseType)^.OrdType;
    TypeData^.MinValue := MinValue;
    TypeData^.MaxValue := MaxValue;
    TypeData^.BaseType := AllocMem(SizeOf(Pointer));
    TypeData^.BaseType^ := BaseType;
    AddType(Result);
  except
    try
      ReallocMem(Result, 0);
    except
      Result := nil;
    end;
    raise;
  end;
  ReferenceType(BaseType);
end;

//--------------------------------------------------------------------------------------------------
// Sets
//--------------------------------------------------------------------------------------------------

function ppJclSetToList(const TypeInfo: PTypeInfo; const Value;
  const WantBrackets: Boolean; const WantRanges: Boolean;
  const Strings: TStrings): string;
var
  SetType: IppJclSetTypeInfo;
  I: Integer;
begin
  I := Strings.Count;
  Result := '';
  SetType := JclTypeInfo(TypeInfo) as IppJclSetTypeInfo;
  SetType.GetAsList(Value, WantRanges, Strings);
  for I := I to Strings.Count-1 do
  begin
    if Result <> '' then
      Result := Result + ', ' + Strings[I]
    else
      Result := Result + Strings[I];
  end;
  if WantBrackets then
    Result := '[' + Result + ']';
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetToStr(const TypeInfo: PTypeInfo; const Value;
  const WantBrackets: Boolean; const WantRanges: Boolean): string;
var
  Dummy: TStringList;
begin
  Dummy := TStringList.Create;
  try
    Result := ppJclSetToList(TypeInfo, Value, WantBrackets, WantRanges,
      Dummy);
  finally
    Dummy.Free;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure ppJclStrToSet(const TypeInfo: PTypeInfo; var SetVar;
  const Value: string);
var
  SetInfo: IppJclSetTypeInfo;
  S: TStrings;
begin
  SetInfo := JclTypeInfo(TypeInfo) as IppJclSetTypeInfo;
  S := TStringList.Create;
  try
    StrToStrings(Value, ',', S);
    if S.Count > 0 then
    begin
      if S[0][1] = '[' then
      begin
        S[0] := Copy(S[0], 2, Length(S[0]));
        S[S.Count-1] := Copy(S[S.Count-1], 1,
          Length(S[S.Count-1]) - 1);
      end;
    end;
    SetInfo.SetAsList(SetVar, S);
  finally
    S.Free;
  end;
end;

//--------------------------------------------------------------------------------------------------

procedure ppJclIntToSet(const TypeInfo: PTypeInfo; var SetVar;
  const Value: Integer);
var
  BitShift: Integer;
  TmpInt64: Int64;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
  CompType: PTypeInfo;
begin
  CompType := GetTypeData(TypeInfo).CompType^;
  EnumMin := GetTypeData(CompType).MinValue;
  EnumMax := GetTypeData(CompType).MaxValue;
  ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
  BitShift := EnumMin mod 8;
  TmpInt64 := Longword(Value) shl BitShift;
  Move(TmpInt64, SetVar, ResBytes);
end;

//--------------------------------------------------------------------------------------------------

function ppJclSetToInt(const TypeInfo: PTypeInfo; const SetVar): Integer;
var
  BitShift: Integer;
  TmpInt64: Int64;
  EnumMin: Integer;
  EnumMax: Integer;
  ResBytes: Integer;
  CompType: PTypeInfo;
begin
  Result := 0;
  TmpInt64 := 0;
  CompType := GetTypeData(TypeInfo).CompType^;
  EnumMin := GetTypeData(CompType).MinValue;
  EnumMax := GetTypeData(CompType).MaxValue;
  ResBytes := (EnumMax div 8) - (EnumMin div 8) + 1;
  if (EnumMax - EnumMin) > 32 then
    raise EppJclRTTI.CreateResRecFmt(@ppJclRsRTTIValueOutOfRange,
      [IntToStr(EnumMax - EnumMin) + ' ' + LoadResString(@ppJclRsRTTIBits)]);
  BitShift := EnumMin mod 8;
  Move(SetVar, TmpInt64, ResBytes + 1);
  TmpInt64 := TmpInt64 shr BitShift;
  Move(TmpInt64, Result, ResBytes);
end;

//--------------------------------------------------------------------------------------------------

function ppJclGenerateSetType(const BaseType: PTypeInfo;
  const TypeName: ShortString): PTypeInfo;
var
  TypeData: PTypeData;
  ValCount: Integer;
begin
  Result := AllocMem(SizeOf(TTypeInfo) + SizeOf(TOrdType) + SizeOf(PPTypeInfo));
  try
    with Result^ do
    begin
      Kind := tkSet;
      Name := TypeName;
    end;
    with GetTypeData(BaseType)^ do
      ValCount := MaxValue - MinValue + (MinValue mod 8);
    TypeData := GetTypeData(Result);
    case ValCount of
      0..8:
        TypeData^.OrdType := otUByte;
      9..16:
        TypeData^.OrdType := otUWord;
      17..32:
        TypeData^.OrdType := otULong;
      33..64:
        Byte(TypeData^.OrdType) := 8;
      65..128:
        Byte(TypeData^.OrdType) := 16;
      129..256:
        Byte(TypeData^.OrdType) := 32;
    else
      Byte(TypeData^.OrdType) := 255;
    end;
    TypeData^.CompType := AllocMem(SizeOf(Pointer));
    TypeData^.CompType^ := BaseType;
    AddType(Result);
  except
    try
      ReallocMem(Result, 0);
    except
      Result := nil;
    end;
    raise;
  end;
  ReferenceType(BaseType);
end;

//--------------------------------------------------------------------------------------------------
// Integers
//--------------------------------------------------------------------------------------------------

function ppJclStrToTypedInt(Value: string; TypeInfo: PTypeInfo): Integer;
var
  Conv: TIdentToInt;
  HaveConversion: Boolean;
//  Info: IppJclTypeInfo;
//  RangeInfo: IppJclOrdinalRangeTypeInfo;
//  TmpVal: Int64;
begin
  // uase registered conversion routine, if needed
  if TypeInfo <> nil then
    Conv := FindIdentToInt(TypeInfo)
  else
    Conv := nil;
  HaveConversion := (@Conv <> nil) and Conv(Value, Result);

  // DFM - no conversion routine, convert string to int
  if not HaveConversion then
      Result := StrToInt(Value)

{DFM  if not HaveConversion then
  begin
    if TypeInfo <> nil then
    begin
      Info := JclTypeInfo(TypeInfo);
      if Info.QueryInterface(IppJclOrdinalRangeTypeInfo, RangeInfo) <> S_OK then
        RangeInfo := nil;
      TmpVal := StrToInt64(Value);
      if (RangeInfo <> nil) and ((TmpVal < RangeInfo.MinValue) or
          (TmpVal > RangeInfo.MaxValue)) then
        raise EConvertError.CreateFmt(LoadResString(@SInvalidInteger), [Value]);
      Result := Integer(TmpVal);
    end
    else
      Result := StrToInt(Value)
  end; }
end;

//--------------------------------------------------------------------------------------------------

function ppJclTypedIntToStr(Value: Integer; TypeInfo: PTypeInfo): string;
var
  Conv: TIntToIdent;
  HaveConversion: Boolean;
begin
  if TypeInfo <> nil then
    Conv := FindIntToIdent(TypeInfo)
  else
    Conv := nil;
  HaveConversion := (@Conv <> nil) and Conv(Value, Result);
  if not HaveConversion then
  begin
    if (TypeInfo <> nil) and (GetTypeData(TypeInfo).OrdType = otULong) then
      Result := IntToStr(Int64(Cardinal(Value)))
    else
      Result := IntToStr(Value)
  end;
end;


end.
