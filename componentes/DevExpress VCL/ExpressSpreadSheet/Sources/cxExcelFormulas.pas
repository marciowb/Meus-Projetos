{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxExcelFormulas;

{$I cxVer.inc}

interface
uses
  Classes, SysUtils, Dialogs, dxCore, cxClasses,
  cxExcelAccess, cxExcelConst, cxSSUtils, cxSSTypes, cxSSRes;

type
  TTokenConverter = procedure of object;
  TTokensDefinition = array[0..$FF] of TTokenConverter;

  {TcxFormulaReader}
  TcxFormulaReader = class
  private
    FCol: Integer;
    FConstructBreak: Boolean;
    FDefinitionCount: Integer;
    FOffset: Word;
    FOwner: TcxExcelFileReader;
    FRow: Integer;
    FStringList: TStringList;
    FToken: Byte;
    FTokens: PByteArray;
    FTokensCount: Word;
    FTokensDefinition: TTokensDefinition;
    FUnknownFunction: Boolean;
    function GetLastString: string;
    procedure SetLastString(const Value: string);
    procedure RegistryFunctions;
  protected
    function AreaRefToStr(ACol, ARow: Integer): string;
    procedure ConvertptgAdd_ptgPercent;
    procedure ConvertptgArea;
    procedure ConvertptgAreaN;
    procedure ConvertptgArea3d;
    procedure ConvertptgAreaErr3d;
    procedure ConvertptgAttr;
    procedure ConvertptgBool;
    procedure ConvertptgExp;
    procedure ConvertptgErr;
    procedure ConvertptgFunc;
    procedure ConvertptgFuncVar;
    procedure ConvertptgInt;
    procedure ConvertptgMemFunc;
    procedure ConvertptgMissArg;
    procedure ConvertptgName;
    procedure ConvertptgNum;
    procedure ConvertptgParen;
    procedure ConvertptgRef;
    procedure ConvertptgRefNV;
    procedure ConvertptgRef3d;
    procedure ConvertptgRef3dErr;
    procedure ConvertptgStr;
    procedure ConvertptgTable;
    function DoHashedConvertion(AHashedToken: Byte): Boolean; virtual;
    function GetArguments(ACount: Integer; const AddStr: string = ''): string;
    function SheetNameByRef(APage: Integer): string;
    function StrByPosition(ACol, ARow: Integer; AColAbs, ARowAbs: Boolean): string; overload;
    function StrByPosition(ACol, ARow: Integer): string; overload;
    property CurrentOffset: Word read FOffset;
    property ConstructBreak: Boolean read FConstructBreak write FConstructBreak;
    property LastString: string read GetLastString write SetLastString;
    property Token: Byte read FToken;
    property Tokens: PByteArray read FTokens write FTokens;
    property TokensCount: Word read FTokensCount;
    property Strings: TStringList read FStringList;
  public
    constructor Create(AOwner: TcxExcelFileReader); virtual;
    destructor Destroy; override;
    function ConvertFormulas(ACol, ARow: Integer; ATokens: PByteArray;
      AParsedLen: Word): string; virtual;
    procedure RegistryConverters(AToken: Byte; AConvertFunc: TTokenConverter); virtual;
    property Owner: TcxExcelFileReader read FOwner;
    property UnknownFunction: Boolean read FUnknownFunction;
  end;

  function ListSeparatorEx: Char;

implementation
type
  TcxFileReaderAccess = class(TcxExcelFileReader);
  TcxFileWriterAccess = class(TcxExcelFileWriter);

function ListSeparatorEx: Char;
begin
  Result := dxFormatSettings.ListSeparator;
//  if ((Result = DecimalSeparator) {or (Result = ThousandSeparator))} and
//    ((DecimalSeparator = ','){ or (ThousandSeparator = ',')}) then
  if ((Result = dxFormatSettings.DecimalSeparator) and (dxFormatSettings.DecimalSeparator = ',')) then
    Result := ';';
end;

{TcxFormulaReader}
constructor TcxFormulaReader.Create(AOwner: TcxExcelFileReader);
begin
  FStringList := TStringList.Create;
  FOwner := AOwner;
  FOwner := AOwner;
  FDefinitionCount := 0;
  RegistryFunctions;
end;

destructor TcxFormulaReader.Destroy;
begin
  FStringList.Free;
  inherited;
end;

function TcxFormulaReader.ConvertFormulas(ACol, ARow: Integer;
  ATokens: PByteArray; AParsedLen: Word): string;
begin
  Result := '';
  FStringList.Clear;
  if (ATokens^[0] = ptgExp) and (AParsedLen <= 1) then Exit;
  FCol := ACol;
  FRow := ARow;
  FTokens := ATokens;
  FTokensCount := AParsedLen;
  FOffset := 0;
  FConstructBreak := False;
  FUnknownFunction := False;
  while (FOffset < AParsedLen) and (not FConstructBreak) and not FUnknownFunction do
  begin
    FToken := Tokens^[FOffset];
    Inc(FOffset);
    if not DoHashedConvertion(FToken) then
    begin
      FConstructBreak := True;
      Result := '#' + scxCaclulatorMissingTokens;
    end;
  end;
  if FUnknownFunction then
    Result := scxXLSUnknownFunc
  else
  begin
    if FStringList.Count >= 1  then
      Result := '=' + LastString
    else
      Result := scxXLSFuncCustructErr;
    if (Pos(scxXLSSharedFunc, Result) <> 0) or (Pos('#<', Result) <> 0) then
      Result := '';
  end;
end;

procedure TcxFormulaReader.RegistryConverters(AToken: Byte; AConvertFunc: TTokenConverter);
begin
  FTokensDefinition[AToken] := AConvertFunc;
end;

function TcxFormulaReader.AreaRefToStr(ACol, ARow: Integer): string;
var
  ARetCol, ARetRow: Integer;
begin
  ARetCol := SmallInt(ACol and $FF);
  ARetRow := ARow;
  if (ACol and $4000) <> 0 then
    ARetCol := FCol + Shortint(ARetCol);
  if (ACol and $8000) <> 0 then
    ARetRow := FRow + SmallInt(ARetRow);  //151 149
  Result := StrByPosition(ARetCol, ARetRow, (ACol and $4000) = 0, (ACol and $8000) = 0);
end;

procedure TcxFormulaReader.ConvertptgAdd_ptgPercent;
var
  S: string;
const
  AOperations: array[0..17] of string =
    ('+', '-', '*', '/', '^', '&', '<', '<=', '=', '>=', '>', '<>', ' ', '', ':', '', '-','%');
begin
  AOperations[13] := ListSeparatorEx;
  if Token = ptgPercent then
    S := LastString + AOperations[Token - ptgAdd]
  else
    if Token > ptgUPlus then
    begin
      if FStringList.Count >= 1 then
        S := AOperations[Token - ptgAdd] + LastString
      else
        S := '#' + scxCaclulatorMissingTokens;
    end
    else
      if (Token < ptgUPlus) then
      begin
        if FStringList.Count >= 2 then
        begin
          S := AOperations[Token - ptgAdd] + LastString;
          FStringList.Delete(FStringList.Count - 1);
          S := LastString + S;
        end
        else
          S := '#' + scxCaclulatorMissingTokens;
      end;
  if Token <> ptgUPlus then
    LastString := S;
end;

procedure TcxFormulaReader.ConvertptgArea;
var
  PWords: PWordArray;
begin
  PWords := @FTokens^[FOffset];
  FStringList.Add(StrByPosition(PWords^[2], PWords^[0]) + ':'
    + StrByPosition(PWords^[3], PWords^[1]));
  Inc(FOffset, 8);
end;

procedure TcxFormulaReader.ConvertptgAreaN;
var
  PWords: PWordArray;
begin
  PWords := @FTokens^[FOffset];
  FStringList.Add(AreaRefToStr(PWords^[2], PWords^[0]) + ':'
    + AreaRefToStr(PWords^[3], PWords^[1]));
  Inc(FOffset, 8);
end;

procedure TcxFormulaReader.ConvertptgArea3d;
var
  PWords: PWordArray;
begin
  PWords := @FTokens^[FOffset];
  FStringList.Add(SheetNameByRef(PWords^[0]) + '!' + StrByPosition(PWords^[3],
  PWords^[1]) + ':' + StrByPosition(PWords^[4], PWords^[2]));
  Inc(FOffset, 10);
end;

procedure TcxFormulaReader.ConvertptgAreaErr3d;
begin
  FStringList.Add(SheetNameByRef(PWord(@FTokens^[FOffset])^) + scxRefError);
  Inc(FOffset, 10);
end;

procedure TcxFormulaReader.ConvertptgAttr;
begin
  if (FTokens^[FOffset] and $04) <> 0 then
    FOffset := FOffset + (PWord(@FTokens^[FOffset + 1])^ + 2) * 2 - 3
  else
    if (FTokens^[FOffset] and $10) <> 0 then
      LastString := sxlfSUM +'(' + LastString + ')';
  Inc(FOffset, 3);
end;

procedure TcxFormulaReader.ConvertptgBool;
begin
  FStringList.Add(BoolToStr(Boolean(FTokens^[FOffset])));
  Inc(FOffset, 2);
end;

procedure TcxFormulaReader.ConvertptgExp;
begin
  FStringList.Add('#' + scxXLSSharedFunc + '!');
  Inc(FOffset, 4);
end;

procedure TcxFormulaReader.ConvertptgErr;
begin
  FStringList.Add(XLSErrToStr(FTokens^[FOffset]));
  Inc(FOffset);
  FConstructBreak := True;
end;

procedure TcxFormulaReader.ConvertptgFunc;
var
  ADef: PcxExcelFuncDefinition;
begin
  ADef := FuncDefByToken(PWord(@FTokens^[FOffset])^);
  FUnknownFunction := ADef = nil;
  if not FUnknownFunction then
  begin
    FStringList.Add(ADef.Name + GetArguments(ADef.ParamsCount));
    Inc(FOffset, 2);
  end;
end;

procedure TcxFormulaReader.ConvertptgFuncVar;
var
  I: Byte;
  AToken: Integer;
  S: string; 
  ADef: PcxExcelFuncDefinition;
begin
  I := FTokens^[FOffset] and $7F;
  Inc(FOffset);
  AToken := PWord(@FTokens^[FOffset])^ and $7FFF;
  ADef := FuncDefByToken(AToken);
  FUnknownFunction := ADef = nil;
  if not FUnknownFunction then
  begin
    if (AToken = 1) and (I = 2) then
      S := ListSeparatorEx + '0'
    else
      S := '';
    FStringList.Add(ADef.Name + GetArguments(I, S));
    Inc(FOffset, 2);
  end
end;

procedure TcxFormulaReader.ConvertptgInt;
begin
  FStringList.Add(IntToStr(SmallInt(PWord(@FTokens^[FOffset])^)));
  Inc(FOffset, 2);
end;

procedure TcxFormulaReader.ConvertptgMemFunc;
var
  ALen: Word;
begin
  ALen := PWord(@FTokens^[FOffset])^;
  FStringList.Add('#<ptgMem>');
  Inc(FOffset, ALen + 2);
end;

procedure TcxFormulaReader.ConvertptgMissArg;
begin
  FStringList.Add('0');
end;

procedure TcxFormulaReader.ConvertptgName;
begin
  try
    FStringList.Add(TcxFileReaderAccess(Owner).Names[PWord(@FTokens^[FOffset])^ - 1]);
  except
    ShowMessage(cxGetResourceString(@scxXLSNameRef) + IntToStr(PWord(@FTokens^[FOffset])^ - 1));
  end;
  Inc(FOffset, 4);
end;

procedure TcxFormulaReader.ConvertptgNum;
begin
  FStringList.Add(FloatToStr(PDouble(@FTokens^[FOffset])^));
  Inc(FOffset, 8);
end;

procedure TcxFormulaReader.ConvertptgParen;
begin
  LastString := '(' + LastString + ')';
end;

procedure TcxFormulaReader.ConvertptgRef;
var
  PWords: PWordArray;
begin
  PWords := @FTokens^[FOffset];
  FStringList.Add(StrByPosition(PWords^[1], PWords^[0]));
  Inc(FOffset, 4);
end;

procedure TcxFormulaReader.ConvertptgRefNV;
begin
  FStringList.Add(AreaRefToStr(PWordArray(@FTokens^[FOffset])^[1],
    PWordArray(@FTokens^[FOffset])^[0]));
  Inc(FOffset, 4);
end;

procedure TcxFormulaReader.ConvertptgRef3d;
var
  PWords: PWordArray;
begin
  PWords := @FTokens^[FOffset];
  FStringList.Add(SheetNameByRef(PWords^[0]) + '!' + StrByPosition(PWords^[2], PWords^[1]));
  Inc(FOffset, 6);
end;

procedure TcxFormulaReader.ConvertptgRef3dErr;
begin
  FStringList.Add(SheetNameByRef(PWord(@FTokens^[FOffset])^)  + scxRefError);
  Inc(FOffset, 6);
end;

procedure TcxFormulaReader.ConvertptgStr;
var
  S: AnsiString;
  ASize: Integer;
  WStr: WideString;
begin
  ASize := FTokens^[FOffset];
  Inc(FOffset);
  SetLength(S, ASize);
  try
    if FTokens^[FOffset] = 0 then
      Move(FTokens^[FOffset + 1], S[1], ASize)
    else
      begin
        SetLength(WSTR, ASize);
        Move(FTokens^[FOffset + 1], WSTR[1], ASize * 2);
        ASize := ASize * 2;
        S := dxWideStringToAnsiString(WSTR);
      end;
    S := dxStringToAnsiString('"' + StringReplace(dxAnsiStringToString(S), '"', '""', [rfReplaceAll]) + '"');
    FStringList.Add(dxAnsiStringToString(S));
  finally
   Inc(FOffset, ASize + 1);
  end;
end;

procedure TcxFormulaReader.ConvertptgTable;
begin
//  FStringList.Add('#<ptgTable>');
  Inc(FOffset, 2);
end;

function TcxFormulaReader.DoHashedConvertion(AHashedToken: Byte): Boolean;
begin
  Result := Assigned(FTokensDefinition[AHashedToken]);
  if Result then
    FTokensDefinition[AHashedToken];
end;

function TcxFormulaReader.GetArguments(ACount: Integer; const AddStr: string = ''): string;

  function PopString: string;
  begin
    Result := LastString;
    FStringList.Delete(FStringList.Count -1);
  end;

var
  I: Integer;
begin
  Result := '';
  for I := ACount downto 1 do
    Result := PopString + ListSeparatorEx + Result;
  if ACount > 0 then
    SetLength(Result, Length(Result) - 1);
  Result := '(' + Result + AddStr + ')';
end;

function TcxFormulaReader.SheetNameByRef(APage: Integer): string;
begin
  if Assigned(Owner) then
    with TcxFileReaderAccess(Owner) do
    begin
      APage := XltPage(APage);
      if APage < BoundSheets.Count then
        Result := BoundSheets[APage]
      else
        Result := scxRefError + '3D!';
    end;
    if Pos(' ', Result) <> 0 then
      Result := '''' + Result + '''';
end;

function TcxFormulaReader.StrByPosition(ACol, ARow: Integer; AColAbs, ARowAbs: Boolean): string;
var
  ARowStr, AColStr: string;
begin
  AColStr := TcxSSUtils.ColumnNameByIndex(ACol, False);
  if AColAbs then
    AColStr := '$' + AColStr;
  ARowStr := IntToStr(ARow + 1);
  if ARowAbs then
    ARowStr := '$' + ARowStr;
  Result := AColStr + ARowStr;
end;

function TcxFormulaReader.StrByPosition(ACol, ARow: Integer): string;
begin
  Result :=
    StrByPosition(Byte(ACol and $3FFF), ARow, (ACol and $4000) = 0,  (ACol and $8000) = 0);
end;

function TcxFormulaReader.GetLastString: string;
begin
  Result := FStringList[FStringList.Count - 1];
end;

procedure TcxFormulaReader.RegistryFunctions;
var
  I: Integer;
begin
  for I := ptgAdd to ptgPercent do
    RegistryConverters(I, ConvertptgAdd_ptgPercent);
  RegistryConverters(ptgArea, ConvertptgArea);
  RegistryConverters(ptgAreaV, ConvertptgArea);
  RegistryConverters(ptgAreaA, ConvertptgArea);
  RegistryConverters(ptgAreaN, ConvertptgAreaN);
  RegistryConverters(ptgAreaNA, ConvertptgAreaN);
  RegistryConverters(ptgArea3d, ConvertptgArea3d);
  RegistryConverters(ptgAreaErr3d, ConvertptgAreaErr3d);
  RegistryConverters(ptgAttr, ConvertptgAttr);
  RegistryConverters(ptgBool, ConvertptgBool);
  RegistryConverters(ptgExp, ConvertptgExp);
  RegistryConverters(ptgFunc, ConvertptgFunc);
  RegistryConverters(ptgFuncV, ConvertptgFunc);
  RegistryConverters(ptgFuncA, ConvertptgFunc);
  RegistryConverters(ptgFuncVar, ConvertptgFuncVar);
  RegistryConverters(ptgFuncVarV, ConvertptgFuncVar);
  RegistryConverters(ptgFuncVarA, ConvertptgFuncVar);
  RegistryConverters(ptgInt, ConvertptgInt);
  RegistryConverters(ptgMemFunc, ConvertptgMemFunc);
  RegistryConverters(ptgMemAreaN, ConvertptgMemFunc);
  RegistryConverters(ptgMemAreaA, ConvertptgMemFunc);
  RegistryConverters(ptgMemNoMemN, ConvertptgMemFunc);
  RegistryConverters(ptgName, ConvertptgName);
  RegistryConverters(ptgNameV, ConvertptgName);
  RegistryConverters(ptgNameA, ConvertptgName);
  RegistryConverters(ptgNum, ConvertptgNum);
  RegistryConverters(ptgParen, ConvertptgParen);
  RegistryConverters(ptgRef, ConvertptgRef);
  RegistryConverters(ptgRefV, ConvertptgRef);
  RegistryConverters(ptgRefA, ConvertptgRef);
  RegistryConverters(ptgRefN, ConvertptgRefNV);
  RegistryConverters(ptgRefNA, ConvertptgRefNV);
  RegistryConverters(ptgRefNV, ConvertptgRefNV);
  RegistryConverters(ptgRef3d, ConvertptgRef3d);
  RegistryConverters(ptgRef3dV, ConvertptgRef3d);
  RegistryConverters(ptgRefErr3d, ConvertptgRef3dErr);
  RegistryConverters(ptgRefErr3dV, ConvertptgRef3dErr);
  RegistryConverters(ptgTbl, ConvertptgTable);
  RegistryConverters(ptgStr, ConvertptgStr);
  RegistryConverters(ptgErr, ConvertptgErr);
  RegistryConverters(ptgMissArg, ConvertptgMissArg);
end;

procedure TcxFormulaReader.SetLastString(const Value: string);
begin
  FStringList[FStringList.Count - 1] := Value;
end;

end.
