{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				                                  }
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

unit cxSSFormulas;

interface

{$I cxVer.inc}

uses
   Windows,  Classes, SysUtils, Math, cxClasses,
  {$IFDEF DELPHI6} Variants, Types, {$ENDIF}
  Dialogs, dxCore, cxExcelConst, cxSSData, cxSSUtils, cxSSTypes, cxSSRes;

type
  ECalculationError = class(EdxException);
  TcxSSFunctionHandler = class;

  TcxFormulasCacheClass = class of TcxSSFormulasCache;

  { TcxFormulasCache }
  TcxSSFormulasCache = class
  private
    FCalculationError: Boolean;
    FCycled: Boolean;
  {$IFDEF DEBUGCALCULATION}
    FCyclingStack: TStringList;
    FTraceIndent: Integer; 
  {$ENDIF}
    FDefinedNames: TcxSSNamesDef;
    FDefinedSheets: TcxSSSheetsDef;
    FHandlerError: Boolean;
    FIsLoading: Boolean;
    FFuncList: TList;
    FFuncHandler: TcxSSFunctionHandler;
    FOwner: TObject;
    FRCRefStyle: Boolean;
    FUpdating: Boolean;
    function GetDataStorage(APage: Integer): TcxSSDataStorage;
    function GetFuncCount: Integer;
    function GetFuncRec(AIndex: Integer): TcxSSFuncRec;
    function GetListener: TObject;
    function GetLock: Boolean;
    procedure SetCycled(const Value: Boolean);
    procedure SetLock(const Value: Boolean);
  protected
    FLockRef: Integer;
    function CalculationError: Boolean;
    function CreateCalculator: TcxSSFunctionHandler;
    procedure DoRecalc;
    function GetCellValue(Sender: TcxSSFunctionHandler;
      APage: Word; ACol, ARow: Integer; var AValue: Boolean): Boolean; overload;
    function GetCellValue(Sender: TcxSSFunctionHandler;
      APage: Word; ACol, ARow: Integer; var AValue: Double): Boolean; overload;
    function GetCellValue(Sender: TcxSSFunctionHandler;
      APage: Word; ACol, ARow: Integer; var AValue: string): Boolean; overload;
    function GetNames: TcxSSNamesDef;
    function GetSheets: TcxSSSheetsDef;
    function RCReference: Boolean;
  {$IFDEF DEBUGCALCULATION}
    function TraceIn(APrefix: string; APage: Word; ACol, ARow: Integer): TObject;
    procedure TraceOut(AHandle: TObject);
  {$ENDIF}

    property Cycled: Boolean read FCycled write SetCycled;
    property DataStorages[APage: Integer]: TcxSSDataStorage read GetDataStorage;
    property HandlerError: Boolean read FHandlerError write FHandlerError;
    property Listener: TObject read GetListener;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;
    procedure Add(AFunction: PcxSSFuncRec); virtual;
    function AddFunction(ADataStorage: TcxSSDataStorage;
      ACol, ARow: Integer): Boolean; virtual;
    procedure Clear;
    function Clone(AFuncRecPtr: PcxSSFuncRec): PcxSSFuncRec; virtual;
    function DeleteName(const AName: string): Boolean; virtual;
    function DefineName(const AName: string; APage: Word;
      const AArea: TRange; Validate: Boolean = True): Integer; virtual;
    procedure DestroyFunction(AFuncRecPtr: PcxSSFuncRec); virtual;
    procedure Evaluate(AFuncRecPtr: PcxSSFuncRec); virtual;
    function FuncRecToDisplayText(AFuncRecPtr: PcxSSFuncRec;
      var AColor: Word; AHasFormat: Boolean = True): string;
    function GetFuncValue(AFuncRecPtr: PcxSSFuncRec): Variant;
    procedure ReCalc; virtual;
    function SpreadSheetTokensToExcelTokens(
      const AFunction: PcxSSFuncRec): TcxStackItem;
    procedure UpdateExternalLinks(AFuncRecPtr: PcxSSFuncRec; DR, DC: Integer);
    procedure UpdateOnExchangeSheets(const ASheet1, ASheet2: Integer); virtual;
    procedure UpdateOnDeleteSheet(const ASheet: Integer); virtual;
    procedure UpdateRef(const ASheet: Integer; const ARect: TRect; IsDelete, IsColumn: Boolean);
    function ValidateRef(AFuncRecPtr: PcxSSFuncRec): Boolean;
    property DefinedNames: TcxSSNamesDef read FDefinedNames;
    property IsLoading: Boolean read FIsLoading write FIsLoading;
    property FuncCount: Integer read GetFuncCount;
    property FuncHandler: TcxSSFunctionHandler read FFuncHandler;
    property FuncList: TList read FFuncList;
    property FuncRec[Index: Integer]: TcxSSFuncRec read GetFuncRec; default;
    property Lock: Boolean read GetLock write SetLock;
    property Names: TcxSSNamesDef read GetNames;
    property Owner: TObject read FOwner;
    property RCRefStyle: Boolean read FRCRefStyle write FRCRefStyle;
    property Sheets: TcxSSSheetsDef read GetSheets;
    property Updating: Boolean read FUpdating write FUpdating;
  end;

  PcxSSFormulaRec = PcxSSFuncRec;

  PcxSSFunction = ^TcxSSFunction;
  TcxSSFunction = procedure(Sender: TcxSSFunctionHandler);

  TcxValueType = (vtString, vtFloat, vtBoolean);
  TcxValueTypes = set of TcxValueType;

  TcxStringFuncCallBack = procedure(Sender: TcxSSFunctionHandler; const Value: string);
  TcxFloatFuncCallBack = procedure(Sender: TcxSSFunctionHandler; const Value: Double);

  PcxFuncDefinition = ^TcxFuncDefinition;
  TcxFuncDefinition = {$IFNDEF DELPHI12} packed {$ENDIF} record
    Token: Word;
    Name: string;
    Definition: TcxSSFunction;
    case Params: TcxSSFuncParams of
      fpVariable, fpFixed:
        (ParamsCount: Byte);
  end;

  { TcxSSErrorCode }
  TcxSSErrorCode = (ecNone, ecNull, ecDivZero, ecValue, ecRefErr, ecName, ecNUM, ecNA);

  TcxStackItems = array of TcxStackItem;

  { TcxTokensStack }
  TcxTokensStack = class
  private
    FStackItems: TcxStackItems;
    function GetItemsCount: Integer;
  protected
    function StackCreateItem(const AData; ASize: Integer): TcxStackItem;
    function StackCreateTokenItem(AToken: Byte;
      const AData; ASize: Integer): TcxStackItem;
    function StackGetBooleanItem(const AValue: Boolean): TcxStackItem;
    function StackGetByteItem(const AValue: Byte): TcxStackItem;
    function StackGetWordItem(const AValue: Word): TcxStackItem;
    function StackGetFloatItem(const AValue: Double): TcxStackItem;
    function StackGetLongStringItem(const AValue: WideString): TcxStackItem;
    function StackGetStringItem(const AValue: string): TcxStackItem;
    function StackItemAlloc(const ASize: Integer): TcxStackItem;
    class procedure StackItemEmpty(var AStack: TcxStackItem);
    function StackUnion(ASrc1, ASrc2: TcxStackItem): TcxStackItem;
    function StackUnions(const AStackItems: array of TcxStackItem): TcxStackItem;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clear;
    class function Clone(AItem: TcxStackItem): TcxStackItem;
    procedure Pop;
    procedure StackAdd(const AItem: TcxStackItem);
    procedure StackAddFuncItem(AFuncToken: Word; ABeginParams: Integer);
    procedure StackCombine(APos1, APos2: Integer);
    procedure StackCombineForward;
    procedure StackCombines(AFromPos: Integer); overload;
    procedure StackCombines(const APosition, AItemsCount: Integer); overload;
    function StackGetItemAt(APosition: Integer;
      NeedRemove: Boolean = True): TcxStackItem;
    class procedure StackItemClear(var AStack: TcxStackItem);
    function StackTokensToStr(ATokens: PByteArray): string;
    function StackItemSize(const AStackItem: TcxStackItem): Integer;
    function StackItemType(const AStackItem: TcxStackItem): Byte;
    function StackPopItem: TcxStackItem; overload;
    function StackPopItem(var AItem: TcxStackItem): TcxStackItem; overload;
    function StackPopItems(ACount: Integer): TcxStackItem;
    function StackTokensToItem(const ATokens: PByteArray): TcxStackItem;
    function TokensSize(ATokens: PByteArray): Integer; virtual;
    property ItemsCount: Integer read GetItemsCount;
    property StackItems: TcxStackItems read FStackItems;
  end;

  TcxStackItemObject = class
  public
    Item: TcxStackItem;
    Priority: Integer;
    destructor Destroy; override;
  end;

  { TcxSpreadSheetExpressionParser }

  TcxSpreadSheetExpressionParser = class
  protected
    Handler: TcxSSFunctionHandler;
    function CheckUnaryOperation(var AItem: TcxStackItem; var AToken: Byte; APrevPriority, APrevToken: Integer): Boolean; 
    function CreateFuncItem(AParamsCount: Byte; AFuncID: Word): TcxStackItem;
    function IsArea(ACode: Byte): Boolean;
    function PopAll(AList: TcxObjectList): TcxStackItem;
  public
    constructor Create(AHandler: TcxSSFunctionHandler);
    function DoParse(var AExpression: string; var AParamsCount: Byte): TcxStackItem;
    function GetNextItemFromString(var AString, ASubExp: string; var AItem: TcxStackItem): Byte;
    function CompareStackPriority(AList: TcxObjectList; APriority: Integer): Boolean;
    function Priority(AToken: Byte): Integer;
    procedure Push(AList: TcxObjectList; const AItem: TcxStackItem; APriority: Integer = -1);
    function Pop(AList: TcxObjectList): TcxStackItem;
    procedure PopAndPush(ASource, ADest: TcxObjectList);
  end;

  TcxSSResultType = (rtString, rtValue);

  { TcxSSFunctionHandler }
  TcxSSFunctionHandler = class
  private
    FCallBackIndex: Integer;
    FCol: Integer;
    FErrorCode: TcxSSErrorCode;
    FExtraChars: array[0..14] of Byte;
    FFloatValue: Double;
    FFuncHasResult: Boolean;
    FFuncPtr: PcxSSFuncRec;
    FIsValueAssigned: Boolean;
    FOwner: TcxSSFormulasCache;
    FPage: Integer;
    FParamsCount: Integer;
    FResultType: TcxSSResultType;
    FRow: Integer;
    FStringValue: string;
    FStack: TcxTokensStack;
    FStringList: TStringList;
    function IsArea(ACode: Byte): Boolean;
    function IsExtraChar(ACode: Byte): Boolean;
    function CheckColReference(var AString: string; var ACol: Integer;
      var AbsCol: Boolean): Boolean;
    function CheckColRowReference(var AString: string; var ACol, ARow: Integer;
      var AbsCol, AbsRow: Boolean): Boolean;
    function CheckColumnAndRow(ACol, ARow: Integer;
      AColOfs, ARowOfs: Integer; AbsCol, AbsRow: Boolean; var Col, Row: Integer): Boolean;
    function CheckNameReference(var AString: string;
      var ANameIndex: SmallInt): Boolean;
    function CheckOrdinalOperation(const AString: string): Byte;
    function CheckRowReference(var AString: string; var ARow: Integer;
      var AbsRow: Boolean): Boolean;
    procedure EvaluateOrdinal(AToken: Byte);
    procedure EvaluateFunction(ATokens: PByteArray);
    function GetColumnFromStr(var AString: string; var AValue: Integer): Boolean;
    function GetIntFromStr(var AString: string; var AValue: Integer): Boolean;
    function GetExtraChars: string;
    function GetError: Boolean;
    function GetReferenceFromString(var AReference: TcxStackItem;
      const AString: string): Boolean;
    procedure GetRefParams(ATokens: PByteArray; var APage, ACol, ARow: Integer);
    procedure OrdinalBooleanEvaluate(const AOperation: Byte);
    procedure OrdinalIntersectEvaluate;
    procedure OrdinalMainEvaluate(const AOperation: Byte);
    function ptgRefToStr(AIndex: Word): string; overload;
    function ptgRefToStr(AIsAbsolute: PBoolArray;
      ATokens: PIntArray): string; overload;
    function ptgRefToStr(ASheet: Word;
      AIsAbsolute: PBoolArray; ATokens: PIntArray): string; overload;
    function ptgRefToStr(ASheet: Word;
      const AbsCol, AbsRow: Boolean; const ACol, ARow: Integer): string; overload;
    function ptgRefToStr(const AbsCol, AbsRow: Boolean;
      ACol, ARow: Integer): string; overload;
    procedure RestorePosition;
    procedure SetAbsolutePosition;
    procedure SetFloatValue(const Value: Double);
    procedure SetFuncVarFromTokens(ATokens: PByteArray);
    procedure SetOrdinalFromTokens(ATokens: PByteArray);
    procedure SetReferenceFromTokens(ATokens: PByteArray);
    procedure SetStringFromTokens(ATokens: PByteArray);
    procedure SetStringValue(const Value: string);
    function StackAreaToExcelTokens(ATokens: PByteArray): TcxStackItem;
    procedure StackTokensToArea(ATokens: PByteArray;
      var APage: Word; var ARange: TRange);
  protected
    procedure CheckExtraChars; virtual;
    function CheckString(const AString: string;
      var ACheckedString: string): Boolean; virtual;
    function CheckStringItem(const AString: string;
      var AStackItem: TcxStackItem): Byte;
    function DoParse(var AString: string): TcxStackItem; virtual;
    procedure EnumCellsAreas(ATokens: PByteArray;
      AFunc: Pointer; AValueType: TcxValueTypes); virtual;
    function GetAreaInfo(ATokens: PByteArray; var APage: Integer; var ARange: TRange): Boolean;
    function GetNextStackItemFromString(var AString, ASubExp: string;
      var AStackItem: TcxStackItem): Byte; virtual;
    function GetSubExpression(var AString: string): string;
    function GetSubString(var AString: string): string; virtual;
    function GetUnknownItem(var AStackItem: TcxStackItem;
      const AString: string): Byte; virtual;
    procedure Initialize(AFormulaPtr: PcxSSFormulaRec; ClearResult: Boolean = True); virtual;
    procedure ShowMessage(const AMessage: string);
    class function ValidSheetName(const ASheetName: string): string;
    property ExtraChars: string read GetExtraChars;
    property FuncHasResult: Boolean read FFuncHasResult write FFuncHasResult;
    property Owner: TcxSSFormulasCache read Fowner;
    property ResultType: TcxSSResultType read FResultType write FResultType;
    property Stack: TcxTokensStack read FStack;
  public
    constructor Create(AOwner: TcxSSFormulasCache); virtual;
    destructor Destroy; override;
    function CheckCondition(ACondition: Boolean; AErrCode: TcxSSErrorCode): Boolean;
    function GetBooleanParameter: Boolean; virtual;
    function GetFloatParameter: Double; virtual;
    function GetStringParameter: string; overload; virtual;
    function GetStringParameter(var AType: Byte): string; overload; virtual;
    procedure EvaluateExpression(AFormulaPtr: PcxSSFormulaRec); virtual;
    procedure EnumParamValues(AFunc: Pointer; AValueTypes: TcxValueTypes); virtual;
    class function ErrorCodeToStr(ACode: TcxSSErrorCode): string;
    procedure SetBooleanResult(const Value: Boolean);
    procedure SetError(ACode: TcxSSErrorCode);
    procedure SetFloatResult(const Value: Double);
    procedure SetStringResult(const Value: string);
    procedure StringToTokens(const AExpression: string;
      AFormulaPtr: PcxSSFormulaRec); virtual;
    function TokensToExcelFormat(AFormulaPtr: PcxSSFormulaRec): TcxStackItem; virtual;
    function TokensToString(AFormulaPtr: PcxSSFormulaRec): string; virtual;
    class function FuncDefByToken(const AToken: Word;
      var ADef: TcxFuncDefinition): Boolean;
    class function FuncDefByName(const AName: string;
      var ADef: TcxFuncDefinition): Boolean;
    class function RegisterFunctions(
      const AFuncList: array of TcxFuncDefinition): Integer;
    property CallBackIndex: Integer read FCallBackIndex;
    property Col: Integer read FCol;
    property Error: Boolean read GetError;
    property ErrorCode: TcxSSErrorCode read FErrorCode;
    property FloatValue: Double read FFloatValue write SetFloatValue;
    property IsValueAssigned: Boolean read FIsValueAssigned;
    property Page: Integer read FPage;
    property ParamsCount: Integer read FParamsCount;
    property Row: Integer read FRow;
    property StringValue: string read FStringValue write SetStringValue;
  end;

implementation
uses
  cxSSheet, cxExcelFormulas;

type
  TcxSSBookAccess = class(TcxCustomSpreadSheetBook);
  TcxSSSheetAccess = class(TcxSSBookSheet);
  TcxSSListenerAccess = class (TcxSSListener);

const
  MinDateTime: TDateTime = -657434.0;      
  MaxDateTime: TDateTime =  2958465.99999;

const
  ptgLStr = $F7;

  AOperation: array[0..17] of string = ('+', '-', '*', '/', '^', '&',
    '<', '<=', '=', '>=', '>', '<>', ' ', ',', ':', '', '-', '%');
  ValueIncr: array[Boolean] of ShortInt = (-1, 1);
  NullStackItem: TcxStackItem = (Size: 0; Tokens: nil);
  Operations: array[0..18] of Byte =
    (ptgAdd, ptgSub, ptgMul, ptgDiv, ptgPower, ptgConcat,
     ptgLT, ptgLE, ptgEQ, ptgGE, ptgGT, ptgNE, ptgIsect,
     ptgUnion, ptgRange, ptgUplus, ptgUminus, ptgPercent, ptgParen);
  OperationStackItems: array[0..18] of TcxStackItem =
    ((Size: 1; Tokens: @Operations[0]),  (Size: 1; Tokens: @Operations[1]),
     (Size: 1; Tokens: @Operations[2]),  (Size: 1; Tokens: @Operations[3]),
     (Size: 1; Tokens: @Operations[4]),  (Size: 1; Tokens: @Operations[5]),
     (Size: 1; Tokens: @Operations[6]),  (Size: 1; Tokens: @Operations[7]),
     (Size: 1; Tokens: @Operations[8]),  (Size: 1; Tokens: @Operations[9]),
     (Size: 1; Tokens: @Operations[10]), (Size: 1; Tokens: @Operations[11]),
     (Size: 1; Tokens: @Operations[12]), (Size: 1; Tokens: @Operations[13]),
     (Size: 1; Tokens: @Operations[14]), (Size: 1; Tokens: @Operations[15]),
     (Size: 1; Tokens: @Operations[16]), (Size: 1; Tokens: @Operations[17]),
     (Size: 1; Tokens: @Operations[18]));

procedure IncAMonth(var Year, Month, Day: Word; NumberOfMonths: Integer = 1);
var
  DayTable: PDayTable;
  Sign: Integer;
begin
  if NumberOfMonths >= 0 then Sign := 1 else Sign := -1;
  Year := Year + (NumberOfMonths div 12);
  NumberOfMonths := NumberOfMonths mod 12;
  Inc(Month, NumberOfMonths);
  if Word(Month-1) > 11 then    // if Month <= 0, word(Month-1) > 11)
  begin
    Inc(Year, Sign);
    Inc(Month, -12 * Sign);
  end;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if Day > DayTable^[Month] then Day := DayTable^[Month];
end;

procedure ShowMessage(const S: string);
begin
  Dialogs.ShowMessage(S);
end;

procedure ReallocMem(var P: PByteArray; ASize: Integer);
begin
  ASize := ((ASize div 1024) + 1) * 1024;
  System.ReallocMem(P, ASize);
end;

{ TcxFormulasCache }
constructor TcxSSFormulasCache.Create(AOwner: TObject);
begin
{$IFDEF DEBUGCALCULATION}
  FCyclingStack := TStringList.Create;
{$ENDIF}
  FFuncList := TList.Create;
  FLockRef := 0;
  FFuncHandler := CreateCalculator;
  SetLength(FDefinedNames, 0);
  FOwner := AOwner;
  FRCRefStyle := False;
  FCycled := False;
end;

destructor TcxSSFormulasCache.Destroy;
begin
{$IFDEF DEBUGCALCULATION}
  FCyclingStack.Free;
{$ENDIF}
  SetLength(FDefinedNames, 0);
  try
    Clear;
    FFuncList.Free;
    FFuncHandler.Free;
  finally
    inherited Destroy;
  end;
end;

procedure TcxSSFormulasCache.Add(AFunction: PcxSSFuncRec);
begin
  FFuncList.Add(AFunction);
end;

function TcxSSFormulasCache.AddFunction(ADataStorage: TcxSSDataStorage;
  ACol, ARow: Integer): Boolean;
var
  ACell: TcxSSCellRec;
  ACycledState: Boolean;
begin
  ACell := ADataStorage[ACol, ARow];
  New(PcxSSFuncRec(ACell.FuncRecPtr));
  FillChar(ACell.FuncRecPtr^, SizeOf(TcxSSFuncRec), 0);
  ACell.FuncRecPtr^.IterationCount := 0;
  ACycledState := Cycled;
  try
    with ACell do
    begin
      FillChar(FuncRecPtr^.FuncTree, SizeOf(FuncRecPtr^.FuncTree), 0);
      FuncRecPtr^.Col := ACol;
      FuncRecPtr^.Row := ARow;
      FuncRecPtr^.Page := ADataStorage.CurrentPage;
      FuncRecPtr^.States := fsSource;
      try
        try
          FFuncHandler.StringToTokens(Text, FuncRecPtr);
        except
          FHandlerError := True;
          try
            FFuncHandler.FStack.StackItemClear(FuncRecPtr^.FuncTree);
          finally
            FuncRecPtr^.IsBadFunction := True;
          end;
        end;
      finally
        if FHandlerError and not IsLoading then
          ShowMessage(cxGetResourceString(@scxCaclulatorStringExpression));
      end;
      if FuncRecPtr <> nil then
      begin
        if FuncRecPtr^.FuncTree.Size = 0 then
        begin
          DataType := dtText;
          Dispose(FuncRecPtr);
          FuncRecPtr := nil;
        end
        else
        begin
          ACell.Text := FFuncHandler.TokensToString(FuncRecPtr);
          if not FHandlerError then
            FFuncList.Add(FuncRecPtr);
          ACell.DataType := dtFunction;
        end;
      end;
      Result := (FuncRecPtr <> nil) and (FuncRecPtr^.States = fsSource);
    end;
  finally
    if FHandlerError then
    begin
      ACell.DataType := dtText;
      FreeMem(ACell.FuncRecPtr);
    end;
    FHandlerError := False;
    ADataStorage[ACol, ARow] := ACell;
    if (not FHandlerError) and Cycled and (ACycledState <> Cycled) then
      ShowMessage(cxGetResourceString(@scxCaclulatorCyclingError));
  end;
end;

function TcxSSFormulasCache.Clone(AFuncRecPtr: PcxSSFuncRec): PcxSSFuncRec;
begin
  if AFuncRecPtr <> nil then
  begin
    New(Result);
    Result^ := AFuncRecPtr^;
    with Result^ do
    begin
      FuncTree := TcxTokensStack.Clone(FuncTree);
      CalcResult := TcxTokensStack.Clone(FuncTree);
    end;
    FFuncList.Add(Result);
  end
  else
    Result := nil;
end;

procedure TcxSSFormulasCache.Clear;
begin
  SetLength(FDefinedNames, 0);
  try
    while FFuncList.Count <> 0 do
      DestroyFunction(FFuncList[0]);
  finally
    FFuncList.Clear;
  end;
  FFuncList.Clear;
  FLockRef := 0;
end;

function TcxSSFormulasCache.DeleteName(const AName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(FDefinedNames) - 1 do
    if (AnsiCompareText(AName, FDefinedNames[I].Name) = 0) and not FDefinedNames[I].IsDeleted then
    begin
      Result := True;
      FDefinedNames[I].IsDeleted := True;
      TRect(FDefinedNames[I].Definition.Area) := Rect(-1, -1, -1, -1); 
      Break;
    end;
end;

function TcxSSFormulasCache.DefineName(const AName: string;
  APage: Word; const AArea: TRange; Validate: Boolean = True): Integer;
var
  I: Integer;
  AChars: string;

begin
  Result := -1;
  AChars := ' ()&@#%^+-*/\|,.;{}[]''"?';
  if Validate then
  begin
    for I := 1 to Length(AName) do
      if Pos(AName[I], AChars) <> 0 then
         Exit;
    for I := 0 to Length(FDefinedNames) - 1 do
      if (AnsiCompareText(AName, FDefinedNames[I].Name) = 0) and not FDefinedNames[I].IsDeleted then
        Exit;
    for I := 0 to Length(FDefinedSheets) - 1 do
      if AnsiCompareText(AName, FFuncHandler.ValidSheetName(FDefinedSheets[I].SheetName)) = 0 then
        Exit;
  end;
  SetLength(FDefinedNames, Length(FDefinedNames) + 1);
  with FDefinedNames[Length(FDefinedNames) - 1] do
  begin
    Name := AName;
    Definition.Page := APage;
    Definition.Area := AArea;
  end;
  Result := Length(FDefinedNames) - 1;
end;

procedure TcxSSFormulasCache.DestroyFunction(AFuncRecPtr: PcxSSFuncRec);
var
  AIndex: Integer;
begin
  AIndex := FFuncList.IndexOf(AFuncRecPtr);
  try
    if (AFuncRecPtr <> nil) and (AIndex >= 0) then
    begin
      try
        with AFuncRecPtr^ do
        begin
          FFuncHandler.Stack.StackItemClear(FuncTree);
          FFuncHandler.Stack.StackItemClear(CalcResult);
        end;
      finally
        Dispose(AFuncRecPtr);
      end;
    end;
  finally
    if AIndex >= 0 then
       FFuncList.Delete(AIndex);
  end;
end;

procedure TcxSSFormulasCache.Evaluate(AFuncRecPtr: PcxSSFuncRec);
var
  FCalculator: TcxSSFunctionHandler;
{$IFDEF DEBUGCALCULATION}
  AHandle: TObject; 
{$ENDIF}
begin
  if Lock or (AFuncRecPtr = nil) or AFuncRecPtr^.IsBadFunction or Cycled then Exit;
  with AFuncRecPtr^ do
  begin
    if IsBusy > 0 then
    begin
      Cycled := True;
      Exit;
    end;
    Inc(IterationCount);
    try
      if IterationCount > 1 then
      begin
        FCalculationError := True;
        ShowMessage(cxGetResourceString(@scxCaclulatorCyclingError));
      end
      else
      begin
        FCalculator := CreateCalculator;
        Inc(IsBusy);
        try
          if FuncTree.Size = 0 then
            FCalculator.StringToTokens(DataStorages[Page][Col, Row].Text, AFuncRecPtr);
          States := fsSource;
          if FuncTree.Size > 0 then
          begin
          {$IFDEF DEBUGCALCULATION}
            AHandle := TraceIn('Call ->', Page, Col, Row);
          {$ENDIF}
            FCalculator.EvaluateExpression(AFuncRecPtr);
          {$IFDEF DEBUGCALCULATION}
            TraceOut(AHandle);
          {$ENDIF}
          end;
        finally
          Dec(IsBusy);
          FCalculator.Free;
        end;
      end;
    finally
      Dec(IterationCount)
    end;
  end;
end;

function TcxSSFormulasCache.FuncRecToDisplayText(AFuncRecPtr: PcxSSFuncRec;
  var AColor: Word; AHasFormat: Boolean = True): string;

  function FormatResult: string;
  begin
    with AFuncRecPtr^ do
    begin
      if CalcResult.Size > 0 then
      begin
        if States <> fsError then
        begin
          case FFuncHandler.Stack.StackItemType(CalcResult) of
            ptgNum:
            if AHasFormat then
              Result := TcxSSUtils.FormatText(PDouble(@CalcResult.Tokens^[1])^,
                DataStorages[Page][Col, Row].StylePtr^.FormatIndex,
                   TcxSSBookAccess(Owner).Precision, AColor)
            else
              Result := FloatToStr(PDouble(@CalcResult.Tokens^[1])^);
            ptgLStr, ptgStr:
              Result := FFuncHandler.Stack.StackTokensToStr(CalcResult.Tokens);
            ptgBool:
              Result := BoolToStr(Boolean(CalcResult.Tokens^[1]));
          else
            Result := TcxSSFunctionHandler.ErrorCodeToStr(ecValue);
          end;
        end
        else
          Result := TcxSSFunctionHandler.ErrorCodeToStr(
            TcxSSErrorCode(CalcResult.Tokens^[0]));
      end
      else
        Result := '0';
    end
  end;

begin
  Result := '';
  if FFuncList.IndexOf(AFuncRecPtr)< 0 then Exit;
  with AFuncRecPtr^ do
  begin
    if IsBadFunction then
    begin
      Result := TcxSSSheetAccess(TcxSSBookAccess(Owner).Pages[Page]).DataStorage[Col, Row].Text;
      Exit;
    end;
    if TcxSSBookAccess(Owner).ShowFormulas then
    begin
      Result :=  FFuncHandler.TokensToString(AFuncRecPtr);
      if  FFuncHandler.ErrorCode <> ecNone then
        Result := DataStorages[Page][Col, Row].Text;
    end
    else
    begin
      try
        if CalcResult.Size = 0 then
        try
          Evaluate(AFuncRecPtr);
        except
          States := fsError;
        end;
      finally
        Result := FormatResult
      end;
    end;
  end;
end;

function TcxSSFormulasCache.GetFuncValue(AFuncRecPtr: PcxSSFuncRec): Variant;

  function SetError(ErrCode: TcxSSErrorCode) : Variant;
  begin
    Result := Integer(ErrCode);
    TVarData(Result).VType := varError;
  end;

const
  Empty: Double = 0;
begin
  if (AFuncRecPtr <> nil) and (AFuncRecPtr^.CalcResult.Size > 0) then
  begin
    if AFuncRecPtr.States <> fsError then
    begin
      with AFuncRecPtr^.CalcResult do
      begin
        if Tokens[0] = ptgBool then
          Result := Boolean(Tokens[1])
        else
        begin
          if Tokens[0] = ptgNum then
            Result := Double(PDouble(@Tokens[1])^)
          else
          begin
            if Tokens[0] = ptgStr then
              Result := string(FFuncHandler.Stack.StackTokensToStr(@Tokens[0]))
            else
              Result := Empty;
          end;
        end;
      end;
    end
    else
      Result := SetError(TcxSSErrorCode(AFuncRecPtr^.CalcResult.Tokens[0]));
  end
  else
  begin
    if (AFuncRecPtr <> nil) and (AFuncRecPtr^.States = fsSource) then
      Result := 0
    else
      Result := SetError(ecName);
  end;
end;

procedure TcxSSFormulasCache.ReCalc;
begin
  if Lock or (FFuncList.Count = 0) then Exit;
  DoRecalc;
end;

function TcxSSFormulasCache.SpreadSheetTokensToExcelTokens(
  const AFunction: PcxSSFuncRec): TcxStackItem;
begin
  Result := FFuncHandler.TokensToExcelFormat(AFunction);
end;

procedure TcxSSFormulasCache.UpdateExternalLinks(AFuncRecPtr: PcxSSFuncRec; DR, DC: Integer);
var
  AOfs: Integer;
  ATokens: PByteArray;
begin
  if AFuncRecPtr = nil then Exit;
  if (DC = 0) and (DR = 0) then Exit;
  AOfs := 0;
  while AOfs < AFuncRecPtr^.FuncTree.Size do
  begin
    ATokens := AFuncRecPtr^.FuncTree.Tokens;
    case ATokens^[AOfs] of
      ptgRef3D:
      begin
        if ATokens^[AOfs + 4] = 0 then
          Inc(PInteger(@ATokens^[AOfs + 9])^, DC);
        if ATokens^[AOfs + 3] = 0 then
          Inc(PInteger(@ATokens^[AOfs + 5])^, DR);
      end;
      ptgArea3D:
      begin
        if ATokens^[AOfs + 3] = 0 then
          Inc(PInteger(@ATokens^[AOfs + 7])^, DR);
        if ATokens^[AOfs + 4] = 0 then
          Inc(PInteger(@ATokens^[AOfs + 11])^, DR);
        if ATokens^[AOfs + 5] = 0 then
          Inc(PInteger(@ATokens^[AOfs + 15])^, DC);
        if ATokens^[AOfs + 6] = 0 then
          Inc(PInteger(@ATokens^[AOfs + 19])^, DC);
      end;
    end;
    Inc(AOfs, FuncHandler.Stack.TokensSize(@ATokens^[AOfs]));
  end;
end;

function TcxSSFormulasCache.ValidateRef(AFuncRecPtr: PcxSSFuncRec): Boolean;
var
  AAbsCol, AAbsRow, APosCol, APosRow: Integer;
  AOfs: Integer;
  ATokens, ATok: PByteArray;
  IsErr: Boolean;
begin
  Result := True; 
  if AFuncRecPtr = nil then Exit;
  AOfs := 0;
  IsErr := False;
  APosCol := AFuncRecPtr^.Col;
  APosRow := AFuncRecPtr^.Row;
  while AOfs < AFuncRecPtr^.FuncTree.Size do
  begin
    ATokens := AFuncRecPtr^.FuncTree.Tokens;
    ATok := Pointer(Integer(@ATokens[AOfs]) + 1);
    if IsErr then Break;
    with FFuncHandler do
    begin
      case ATokens^[AOfs] of
      ptgRef:
        IsErr := not (CheckColumnAndRow(APosCol, APosRow, PInteger(@ATok^[6])^, PInteger(@ATok^[2])^,
          Boolean(ATok^[1]), Boolean(ATok^[0]), AAbsCol, AAbsRow));
      ptgArea:
        IsErr := not (CheckColumnAndRow(APosCol, APosRow, PInteger(@ATok^[12])^, PInteger(@ATok^[4])^,
           Boolean(ATok^[2]), Boolean(ATok^[0]), AAbsCol, AAbsRow) and
            CheckColumnAndRow(APosCol, APosRow, PInteger(@ATok^[16])^, PInteger(@ATok^[8])^,
              Boolean(ATok^[3]), Boolean(ATok^[1]), AAbsCol, AAbsRow));

      end;
    end;
    Inc(AOfs, FuncHandler.Stack.TokensSize(@ATokens^[AOfs]));
  end;
  Result := not IsErr;
end;

procedure TcxSSFormulasCache.UpdateOnExchangeSheets(const ASheet1, ASheet2: Integer);

  procedure UpdateRefInNames;
  var
    I: Integer;
  begin
    for I := 0 to Length(FDefinedNames) - 1 do
    with FDefinedNames[I].Definition do
    begin
      if Page = ASheet1 then
        Page := ASheet2
      else
        if Page = ASheet2 then
          Page := ASheet1;
    end;
  end;

  procedure UpdateRefInFunctions(AFuncTree: TcxStackItem);
  var
    AOffset: Integer;
    AItem: TcxStackItem;
  begin
    if AFuncTree.Size > 0 then
    begin
      AOffset := 0;
      FillChar(AItem, SizeOf(AItem), 0);
      while AOffset < AFuncTree.Size do
      begin
        if AFuncTree.Tokens^[AOffset] in [ptgArea3D, ptgRef3D] then
        begin
          if PWord(@AFuncTree.Tokens^[AOffset + 1])^ = ASheet1 then
            PWord(@AFuncTree.Tokens^[AOffset + 1])^ := ASheet2
          else
            if PWord(@AFuncTree.Tokens^[AOffset + 1])^ = ASheet2 then
              PWord(@AFuncTree.Tokens^[AOffset + 1])^ := ASheet1
        end;
        Inc(AOffset, FFuncHandler.FStack.TokensSize(@AFuncTree.Tokens^[AOffset]));
      end;
    end;
  end;

var
  I: Integer;
begin
  for I := 0 to FFuncList.Count - 1 do
  begin
    if PcxSSFuncRec(FFuncList[I])^.Page = ASheet1 then
      PcxSSFuncRec(FFuncList[I])^.Page := ASheet2
    else
      if PcxSSFuncRec(FFuncList[I])^.Page = ASheet2 then
        PcxSSFuncRec(FFuncList[I])^.Page := ASheet1;
    UpdateRefInFunctions(PcxSSFuncRec(FFuncList[I])^.FuncTree);
  end;
  UpdateRefInNames;
end;

procedure TcxSSFormulasCache.UpdateRef(const ASheet: Integer;
  const ARect: TRect; IsDelete, IsColumn: Boolean);
var
  I: Integer;
  ACell: TcxSSCellRec;
  AC, AR: Integer;
  CellCol, CellRow: Integer;
  RefCheck: Boolean;
  AOffset: Integer;
  AItem: TcxStackItem;
  DW, DH: Integer;
  IsErr: Boolean;

  procedure CheckRef(var ACol, ARow: Integer; IsAbsCol, IsAbsRow: Boolean; MayZero: Boolean = False);
  begin
    if IsColumn then
    begin
      if not IsAbsCol then
        ACol := AC + ACol;
      if ((ARect.Left = ACol) and not IsDelete) or (ARect.Left < ACol) then
        ACol := ACol - ValueIncr[IsDelete] * DW;
      if not IsAbsCol then
        ACol := ACol - CellCol;
    end;
    if not IsColumn then
    begin
      if not IsAbsRow then
          ARow := AR + ARow;
      if ((ARect.Top = ARow) and not IsDelete) or (ARect.Top < ARow) then
        ARow := ARow - ValueIncr[IsDelete] * DH;
      if not IsAbsRow then
        ARow := ARow - CellRow;
    end;
    IsErr := (not IsAbsCol and ((CellCol + ACol) < 0)) or (not IsAbsRow and ((CellRow + ARow) < 0));
  end;

  function IsAreaValid(AC1, AR1, AC2, AR2: Integer; AbsC1, AbsR1, AbsC2, AbsR2: Boolean): Boolean;
  var
    R: TRect;
  begin
    R := Rect(AC1, AR1, AC2, AR2);
    with R do
    begin
      if not AbsC1 then
        Left := Left + CellCol;
      if not AbsC2 then
        Right := Right + CellCol;
      if not AbsR1 then
        Top := Top + CellRow;
      if not AbsR1 then
        Bottom := Bottom + CellRow;
    end;
    with ARect do
      Result := (Right < Left) or (Bottom < Top) or (Left < 0) or (Top < 0); 
  end;

  procedure CheckReference(ATokens: PByteArray; IsRef, AIsAbs: Boolean);
  begin
    if not IsRef then
    begin
      CheckRef(PInteger(@ATokens[12])^, PInteger(@ATokens[4])^, Boolean(ATokens[2]), Boolean(ATokens[0]));
      if not IsErr then
         CheckRef(PInteger(@ATokens[16])^, PInteger(@ATokens[8])^, Boolean(ATokens[3]), Boolean(ATokens[1]));
      IsErr := IsErr or IsAreaValid(PInteger(@ATokens[12])^, PInteger(@ATokens[4])^,
        PInteger(@ATokens[16])^, PInteger(@ATokens[8])^, Boolean(ATokens[2]),
          Boolean(ATokens[0]), Boolean(ATokens[3]), Boolean(ATokens[1]));
    end
    else
      CheckRef(PInteger(@ATokens[6])^, PInteger(@ATokens[2])^, Boolean(ATokens[1]) or AIsAbs, Boolean(ATokens[0]) or AIsAbs);
  end;

  procedure UpdateRefInNames;

    procedure CorrectOnDelete(var A, B: Integer; const C, D: Integer);
    begin
      if D <= B then
      begin
        Dec(B, D - C + 1);
        if D < A then
          Dec(A, D - C + 1)
        else
          if C < A then
            A := C;
      end
      else
        if C <= B then
          B := C - 1;
      A := Max(0, A);
    end;

    procedure CorrectOnInsert(var A, B: Integer; const C, D: Integer);
    begin
      if C <= B then
        Inc(B, D - C + 1);
      if C <= A then
        Inc(A, D - C + 1);
    end;

  var
    I: Integer;
  begin
    for I := 0 to Length(FDefinedNames) - 1 do
    begin
      if FDefinedNames[I].IsDeleted then Continue;
      with FDefinedNames[I].Definition do
      begin
        if Page <> ASheet then Continue;
        if IsDelete then
        begin
          if IsColumn then
            CorrectOnDelete(Area.Left, Area.Right, ARect.Left, ARect.Right)
          else
            CorrectOnDelete(Area.Top, Area.Bottom, ARect.Top, ARect.Bottom)
        end
        else
        begin
          if IsColumn then
            CorrectOnInsert(Area.Left, Area.Right, ARect.Left, ARect.Right)
          else
            CorrectOnInsert(Area.Top, Area.Bottom, ARect.Top, ARect.Bottom)
        end;
        if (Area.Left > Area.Right) or (Area.Top > Area.Bottom) then
        begin
          FDefinedNames[I].IsDeleted := True;
          TRect(Area) := Rect(-1, -1, -1, -1);
        end;
      end;
    end;
  end;

begin
  DW := (ARect.Right - ARect.Left) + 1;
  DH := (ARect.Bottom - ARect.Top) + 1;
  UpdateRefInNames;
  IsErr := False;
  I := 0;
  while I < FFuncList.Count do
  begin
    with PcxSSFuncRec(FFuncList[I])^ do
    begin
      AC := Col;
      AR := Row;
      if (ASheet = Page) and IsDelete and ((IsColumn and (AC >= ARect.Left) and (AC <= ARect.Right)) or
         (not IsColumn and (AR >= ARect.Top) and (AR <= ARect.Bottom)))  then
      begin
        Inc(I);
        Continue;
      end;
      if Page = ASheet then
      begin
        if IsColumn then
        begin
          if Col >= ARect.Left then
            Col := Col - ValueIncr[IsDelete] * DW;
        end
        else
        begin
          if Row >= ARect.Top then
            Row := Row - ValueIncr[IsDelete]* DH;
        end
      end;
      CellCol := Col;
      CellRow := Row;
      RefCheck := Page = ASheet;
      if FuncTree.Size > 0 then
      begin
        AOffset := 0;
        FillChar(AItem, SizeOf(AItem), 0);
        while AOffset < FuncTree.Size do
        begin
          case FuncTree.Tokens^[AOffset] of
            ptgArea, ptgRef:
              if RefCheck then
                CheckReference(@FuncTree.Tokens^[AOffset + 1], FuncTree.Tokens^[AOffset] = ptgRef, False);
            ptgArea3D, ptgRef3D:
              if PWord(@FuncTree.Tokens^[AOffset + 1])^ = ASheet then
                CheckReference(@FuncTree.Tokens^[AOffset + 3], FuncTree.Tokens^[AOffset] = ptgRef3D, True);
          end;
          Inc(AOffset, FFuncHandler.FStack.TokensSize(@FuncTree.Tokens^[AOffset]));
        end;
      end;
    end;
    try
      with PcxSSFuncRec(FFuncList[I])^ do
      begin
        ACell := DataStorages[Page][AC, AR];
        if IsErr then
        begin
          ACell.Text := scxRefError;
          ACell.DataType := dtText;
        end
        else
          ACell.Text := FFuncHandler.TokensToString(PcxSSFuncRec(FFuncList[I]));
        DataStorages[Page][AC, AR] := ACell;
      end;
      if IsErr then
        DestroyFunction(PcxSSFuncRec(FFuncList[I]))
      else
        Inc(I);
    finally
      IsErr := False;
    end;
  end;
end;

procedure TcxSSFormulasCache.UpdateOnDeleteSheet(const ASheet: Integer);

  procedure UpdateRefInNames;
  var
    I: Integer;
  begin
    for I := 0 to Length(FDefinedNames) - 1 do
      with FDefinedNames[I].Definition do
      begin
        if Page >= ASheet then
          Dec(Page);
      end;
  end;

  procedure UpdateRefInFunctions(AFuncTree: TcxStackItem);
  var
    AOffset: Integer;
    AItem: TcxStackItem;
  begin
    if AFuncTree.Size > 0 then
    begin
      AOffset := 0;
      FillChar(AItem, SizeOf(AItem), 0);
      while AOffset < AFuncTree.Size do
      begin
        if AFuncTree.Tokens^[AOffset] in [ptgArea3D, ptgRef3D] then
        begin
          if PWord(@AFuncTree.Tokens^[AOffset + 1])^ >= ASheet then
            Dec(PWord(@AFuncTree.Tokens^[AOffset + 1])^);
        end;
        Inc(AOffset, FFuncHandler.FStack.TokensSize(@AFuncTree.Tokens^[AOffset]));
      end;
    end;
  end;

var
  I: Integer;
begin
  for I := 0 to FFuncList.Count - 1 do
  begin
    if PcxSSFuncRec(FFuncList[I])^.Page >= ASheet then
      Dec(PcxSSFuncRec(FFuncList[I])^.Page);
    UpdateRefInFunctions(PcxSSFuncRec(FFuncList[I])^.FuncTree);
    if PcxSSFuncRec(FFuncList[I])^.Page < 0 then
      raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetInvalidSheetNumber));
  end;
  UpdateRefInNames;
end;

function TcxSSFormulasCache.CalculationError: Boolean;
begin
  Result := FCalculationError;
end;

function TcxSSFormulasCache.CreateCalculator: TcxSSFunctionHandler;
begin
  Result := TcxSSFunctionHandler.Create(Self);
end;

procedure TcxSSFormulasCache.DoRecalc;
var
  I: Integer;
  CycledState: Boolean;
begin
  CycledState := Cycled;
{$IFDEF DEBUGCALCULATION}
  if not Cycled then
    FCyclingStack.Clear;
{$ENDIF}
  try
    Cycled := False;
    FCalculationError := False;
    for I := 0 to FFuncList.Count - 1 do
      TcxTokensStack.StackItemClear(PcxSSFuncRec(FFuncList[I])^.CalcResult);
    for I := 0 to FFuncList.Count - 1 do
    begin
      if PcxSSFuncRec(FFuncList[I])^.IsBusy > 0 then
        Continue;
      Evaluate(FFuncList[I]);
      Inc(PcxSSFuncRec(FFuncList[I])^.IsBusy);
    end;
    for I := 0 to FFuncList.Count - 1 do
      PcxSSFuncRec(FFuncList[I])^.IsBusy := 0;
  finally
    if Cycled and (CycledState <> Cycled) then
    begin
   {$IFDEF DEBUGCALCULATION}
      FCyclingStack.SaveToFile('TraceInfo.txt');
   {$ENDIF}
      ShowMessage(cxGetResourceString(@scxCaclulatorCyclingError));
    end;
    FCalculationError := False;
    for I := 0 to FFuncList.Count - 1 do
      PcxSSFuncRec(FFuncList[I])^.IsBusy := 0;
  end;
end;

function TcxSSFormulasCache.GetCellValue(Sender: TcxSSFunctionHandler;
 APage: Word; ACol, ARow: Integer; var AValue: Boolean): Boolean;
var
  F: Double;
  ACell: TcxSSCellRec;
{$IFDEF DEBUGCALCULATION}
  AHandle: TObject;
begin
  AHandle := TraceIn('Ref ->', APage, ACol, ARow);
  try
{$ELSE}
begin
{$ENDIF}
    ACell := DataStorages[APage][ACol, ARow];
    Result := False;
    AValue := False;
    if ACell.DataType = dtFunction then
    begin
      if ACell.FuncRecPtr^.CalcResult.Size = 0 then
        Evaluate(ACell.FuncRecPtr);
      if ACell.FuncRecPtr^.CalcResult.Size <> 0 then
      begin
        if ACell.FuncRecPtr^.States = fsSource then
        begin
          Result := FFuncHandler.Stack.StackItemType(ACell.FuncRecPtr^.CalcResult) = ptgBool;
          if Result then
            AValue := Boolean(ACell.FuncRecPtr^.CalcResult.Tokens^[1])
          else
          begin
            Result := FFuncHandler.Stack.StackItemType(ACell.FuncRecPtr^.CalcResult) = ptgNum;
            if PDouble(@ACell.FuncRecPtr^.CalcResult.Tokens^[1])^ <> 0 then
              AValue := True;
          end;
        end;
      end;
    end
    else
      begin
        Result := cxTryStrToBool(ACell.Text, AValue);
        if not Result then
        begin
          Result := cxTryStrToFloat(ACell.Text, F);
          if Result then
            AValue := F <> 0;
        end;
      end;
{$IFDEF DEBUGCALCULATION}
  finally
    TraceOut(AHandle);
  end;
{$ENDIF}
end;

function TcxSSFormulasCache.GetCellValue(Sender: TcxSSFunctionHandler;
  APage: Word; ACol, ARow: Integer; var AValue: Double): Boolean;
var
  AStrValue: string;
  ABool: Boolean;
begin
  Result := True;
  AValue := 0;
  if GetCellValue(Sender, APage, ACol, ARow, AStrValue) then
  begin
    if AStrValue <> '' then
      if not cxTryStrToFloat(AStrValue, AValue) then
        if cxTryStrToBool(AStrValue, ABool) then
          AValue := Byte(ABool)
        else
          Result := False;
  end;
end;

function TcxSSFormulasCache.GetCellValue(Sender: TcxSSFunctionHandler;
 APage: Word; ACol, ARow: Integer; var AValue: string): Boolean;
var
  ACell: TcxSSCellRec;
{$IFDEF DEBUGCALCULATION}
  AHandle: TObject;
begin
  AHandle := TraceIn('Ref ->',APage, ACol, ARow);
  try
{$ELSE}
begin
{$ENDIF}
    ACell := DataStorages[APage][ACol, ARow];
    case ACell.DataType of
      dtFunction:
      with ACell.FuncRecPtr^ do
      begin
        if CalcResult.Size = 0 then
          Evaluate(ACell.FuncRecPtr);
        if not CalculationError and (CalcResult.Size > 0) and (States = fsSource) then
        begin
          if ACell.FuncRecPtr^.States = fsSource then
          begin
            case FFuncHandler.Stack.StackItemType(ACell.FuncRecPtr^.CalcResult) of
              ptgNum:
                AValue := FloatToStr(PDouble(@ACell.FuncRecPtr^.CalcResult.Tokens^[1])^);
              ptgStr:
                AValue := Sender.Stack.StackTokensToStr(ACell.FuncRecPtr^.CalcResult.Tokens);
              ptgBool:
                AValue := BoolToStr(Boolean(ACell.FuncRecPtr^.CalcResult.Tokens^[1]));
            end;
          end;
        end
        else
        begin
          if States = fsError then
            AValue := scxValueError
          else
            AValue := '';
        end;
      end
    else
      AValue := ACell.Text;
    end;
    Result := AValue <> '';
{$IFDEF DEBUGCALCULATION}
  finally
    TraceOut(AHandle);
  end;
{$ENDIF}
end;

function TcxSSFormulasCache.GetNames: TcxSSNamesDef;
begin
  Result := FDefinedNames;
end;

function TcxSSFormulasCache.GetSheets: TcxSSSheetsDef;
var
  I: Integer;
begin
  with TcxSSBookAccess(Owner) do
  begin
    SetLength(Result, PageCount);
    for I := 0 to PageCount - 1 do
    with Result[I] do
    begin
      SheetName := FFuncHandler.ValidSheetName(Pages[I].Caption);
      SheetIndex := I;
    end;
  end;
end;

function TcxSSFormulasCache.RCReference: Boolean;
begin
  Result := FRCRefStyle;
end;

{$IFDEF DEBUGCALCULATION}
function TcxSSFormulasCache.TraceIn(
  APrefix: string; APage: Word; ACol, ARow: Integer): TObject;
var
  S: string;
  I: Integer;
begin
  if Cycled then Exit; 
  Result := TObject(FTraceIndent);
  S := APrefix + Sheets[APage].SheetName + '!' +
    TcxSSUtils.ColumnNameByIndex(ACol) + IntToStr(ARow + 1);
  for I := 0 to FTraceIndent - 1 do
    S := ' ' + S;
  FCyclingStack.AddObject(S, TObject(FCyclingStack.Count));
  Inc(FTraceIndent);
end;

procedure TcxSSFormulasCache.TraceOut(AHandle: TObject);
var
  S: string;
  I: Integer;
begin
  Dec(FTraceIndent);
  if not Cycled then
    FCyclingStack.Delete(FCyclingStack.Count - 1);
  Exit; 

{  S := 'Trace out';
  if not Cycled then
      FCyclingStack.Delete(FCyclingStack.Count - 1);
    S := 'Cycled ' + S
    while FTraceIndent < Integer(FCyclingStack.Objects[FCyclingStack.Count - 1]) do
      FCyclingStack.Delete(FCyclingStack.Count - 1);

  for I := 0 to FTraceIndent - 1 do
    S := ' ' + S;
  with FCyclingStack do
    FCyclingStack.Add(S);}
end;
{$ENDIF}

function TcxSSFormulasCache.GetDataStorage(APage: Integer): TcxSSDataStorage;
begin
  Result := TcxSSSheetAccess(TcxSSBookAccess(Owner).Pages[APage]).DataStorage;
end;

function TcxSSFormulasCache.GetFuncCount: Integer;
begin
  Result := FFuncList.Count;
end;

function TcxSSFormulasCache.GetFuncRec(AIndex: Integer): TcxSSFuncRec;
begin
  Result := PcxSSFuncRec(FFuncList[AIndex])^
end;
function TcxSSFormulasCache.GetListener: TObject;
begin
  Result := TcxSSBookAccess(Owner).Listener
end;

function TcxSSFormulasCache.GetLock: Boolean;
begin
  Result := not FUpdating and (FLockRef > 0);
end;

procedure TcxSSFormulasCache.SetCycled(const Value: Boolean);
begin
  if FCycled <> Value then
    FCycled := Value;
end;

procedure TcxSSFormulasCache.SetLock(const Value: Boolean);
begin
  if Value then
    Inc(FLockRef)
  else
    Dec(FLockRef);
end;

{ TcxTokensStack }
constructor TcxTokensStack.Create;
begin
  SetLength(FStackItems, 0);
end;

destructor TcxTokensStack.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TcxTokensStack.Clear;
var
  I: Integer;
begin
  try
    for I := 0 to ItemsCount - 1 do
      StackItemClear(FStackItems[I]);
  finally
    SetLength(FStackItems, 0);
  end;
end;

class function TcxTokensStack.Clone(AItem: TcxStackItem): TcxStackItem;
begin
  Result := AItem;
  with Result  do
  begin
    if Size > 0 then
    begin
      Tokens := AllocMem(Size);
      Move(AItem.Tokens^, Tokens^, Size);
    end;
  end;
end;

procedure TcxTokensStack.Pop;
begin
  if ItemsCount > 0 then
  begin
    StackItemClear(FStackItems[Length(FStackItems) - 1]);
    SetLength(FStackItems, Length(FStackItems) - 1); 
  end;
end;

procedure TcxTokensStack.StackAdd(const AItem: TcxStackItem);
begin
  SetLength(FStackItems, ItemsCount + 1);
  FStackItems[ItemsCount - 1] := AItem;
end;

procedure TcxTokensStack.StackAddFuncItem(AFuncToken: Word;
  ABeginParams: Integer);
var
  ASize: Integer;
  I: Integer;
  AStackItem: TcxStackItem;
begin
  ASize := 4;
  for I := ABeginParams to High(FStackItems) do
    Inc(ASize, FStackItems[I].Size);
  AStackItem := StackItemAlloc(ASize);
  ASize := 0;
  with AStackItem do
  begin
     for I := ABeginParams to High(FStackItems) do
     begin
       Move(FStackItems[I].Tokens^, Tokens^[ASize], FStackItems[I].Size);
       Inc(ASize, FStackItems[I].Size);
       FreeMem(FStackItems[I].Tokens);
     end;
    Tokens^[ASize] := ptgFuncVarV;
    Tokens^[ASize + 1] := Length(FStackItems) - ABeginParams;
    PWord(@Tokens^[ASize + 2])^ := AFuncToken;
  end;
  SetLength(FStackItems, ABeginParams + 1);
  FStackItems[ABeginParams] := AStackItem;
end;

procedure TcxTokensStack.StackCombine(APos1, APos2: Integer);
begin
  FStackItems[APos1] := StackUnion(FStackItems[APos1], StackGetItemAt(APos2));
end;

procedure TcxTokensStack.StackCombineForward;
begin
  FStackItems[ItemsCount - 2] :=
    StackUnion(StackGetItemAt(ItemsCount - 1), FStackItems[ItemsCount - 2]);
end;

procedure TcxTokensStack.StackCombines(const APosition, AItemsCount: Integer);
var
  AStackItems: array of TcxStackItem;
  I: Integer;
begin
  SetLength(AStackItems, AItemsCount);
  AStackItems[0] := FStackItems[APosition];
  for I := 1 to  AItemsCount - 1 do
    AStackItems[I] := StackGetItemAt(APosition + 1);
  FStackItems[APosition] := StackUnions(AStackItems);
end;

procedure TcxTokensStack.StackCombines(AFromPos: Integer);
begin
  FStackItems[AFromPos] := StackUnions([FStackItems[AFromPos],
    FStackItems[AFromPos + 2], FStackItems[AFromPos + 1]]);
  if ((AFromPos + 3) < Length(FStackItems)) then
    Move(FStackItems[AFromPos + 3], FStackItems[AFromPos + 1],
      (ItemsCount - AFromPos - 3) * SizeOf(TcxStackItem));
  SetLength(FStackItems, ItemsCount - 2);
end;

function TcxTokensStack.StackGetItemAt(APosition: Integer;
  NeedRemove: Boolean = True): TcxStackItem;
begin
  Result := FStackItems[APosition];
  if NeedRemove then
  begin
    if APosition < High(FStackItems) then
      Move(FStackItems[APosition + 1], FStackItems[APosition],
        (High(FStackItems) - APosition) * SizeOf(TcxStackItem));
    SetLength(FStackItems, Length(FStackItems) - 1);
  end;
end;

class procedure TcxTokensStack.StackItemClear(var AStack: TcxStackItem);
begin
  try
    if AStack.Size <> 0 then
      FreeMem(AStack.Tokens);
  finally
    StackItemEmpty(AStack);
  end;
end;

function TcxTokensStack.StackItemSize(const AStackItem: TcxStackItem): Integer;
begin
  if AStackItem.Size > 0 then
    Result := TokensSize(AStackItem.Tokens)
  else
    Result := 0;
end;

function TcxTokensStack.StackTokensToStr(ATokens: PByteArray): string;
var
  AWStr: WideString;
begin
  if ATokens^[0] = ptgLStr then
    SetLength(AWStr, PWord(@ATokens^[1])^)
  else
    SetLength(AWStr, ATokens^[1]);
  if Length(AWStr) > 0 then
    Move(ATokens^[3], AWStr[1], ATokens^[1] shl 1);
  Result := AWStr;
end;

function TcxTokensStack.StackItemType(const AStackItem: TcxStackItem): Byte;
var
  AOffset: Integer;
begin
  Result := 0;
  AOffset := 0;
  while AOffset < AStackItem.Size do
  begin
    Result := AStackItem.Tokens^[AOffset];
    Inc(AOffset, TokensSize(@AStackItem.Tokens^[AOffset]));
  end;
  if (Result = ptgIsect) and (AStackItem.Size > 1) then
    Result := AStackItem.Tokens^[0];
end;

function TcxTokensStack.StackPopItem: TcxStackItem;
begin
  if ItemsCount > 0 then
  begin
    Result := FStackItems[ItemsCount - 1];
    SetLength(FStackItems, ItemsCount - 1);
  end
  else
    raise ECalculationError.Create(cxGetResourceString(@scxCaclulatorStringExpression));
end;

function TcxTokensStack.StackPopItem(var AItem: TcxStackItem): TcxStackItem;
var
  AOffset: Integer;
begin
  StackItemEmpty(Result);
  AOffset := 0;
  while AItem.Size < (AOffset + TokensSize(@AItem.Tokens^[AOffset])) do
    Inc(AOffset, TokensSize(@AItem.Tokens[AOffset]));
  Result := StackItemAlloc(AItem.Size - AOffset);
  if Result.Size > 0 then
  begin
    Move(AItem.Tokens^[AOffset], Result.Tokens^, Result.Size);
    ReallocMem(AItem.Tokens, AOffset);
  end;
  if AOffset = 0 then
    AItem.Tokens := nil;
end;

function TcxTokensStack.StackPopItems(ACount: Integer): TcxStackItem;
var
  ASize, I: Integer;
begin
  if ACount > ItemsCount then
    raise EdxException.Create(cxGetResourceString(@scxCaclulatorMissingParamters));
  ASize := 0;
  for I := 0 to ACount - 1 do
    Inc(ASize, FStackItems[ItemsCount - 1 - I].Size);
  Result := StackItemAlloc(ASize);
  ASize := 0;
  for I := 1 to ACount do
  begin
    with FStackItems[ItemsCount - I] do
    begin
      if Size > 0 then
      try
        Move(Tokens^, Result.Tokens^[ASize], Size);
        Inc(ASize, Size);
      finally
        StackItemClear(FStackItems[ItemsCount - I]);
      end;
    end;
  end;
  SetLength(FStackItems, ItemsCount - ACount);
end;

function TcxTokensStack.StackTokensToItem(
  const ATokens: PByteArray): TcxStackItem;
begin
  Result := StackItemAlloc(TokensSize(ATokens));
  Move(ATokens^, Result.Tokens^, Result.Size);
end;

function TcxTokensStack.TokensSize(ATokens: PByteArray): Integer;
begin
  Result := 0;
  if ATokens^[0] in [ptgName, ptgArea3D, ptgRef3D] then
    Inc(Result, 2);
  case ATokens^[0] of
    ptgArea, ptgArea3D:
      Inc(Result, 20);
    ptgRef, ptgRef3D:
      Inc(Result, 10);
    ptgNum:
      Inc(Result, 8);
    ptgBool:
      Inc(Result);
    ptgStr:
      Inc(Result, ATokens^[1] shl 1 + 2);
    ptgLStr:
      Inc(Result, PWord(@ATokens^[1])^ shl 1 + 2);
    ptgFuncVarV:
      Result := 3;
  end;
  Inc(Result);
end;

function TcxTokensStack.StackCreateItem(const AData;
  ASize: Integer): TcxStackItem;
begin
  Result := StackItemAlloc(ASize);
  Move(AData, Result.Tokens^, ASize);
end;

function TcxTokensStack.StackCreateTokenItem(AToken: Byte;
  const AData; ASize: Integer): TcxStackItem;
begin
  Result := StackItemAlloc(ASize + 1);
  Result.Tokens^[0] := AToken;
  Move(AData, Result.Tokens^[1], ASize);
end;

function TcxTokensStack.StackGetBooleanItem(
  const AValue: Boolean): TcxStackItem;
begin
  Result := StackCreateTokenItem(ptgBool, AValue, SizeOf(AValue));
end;

function TcxTokensStack.StackGetByteItem(
  const AValue: Byte): TcxStackItem;
begin
  Result := StackCreateItem(AValue, SizeOf(AValue));
end;

function TcxTokensStack.StackGetWordItem(
  const AValue: Word): TcxStackItem;
begin
  Result := StackCreateItem(AValue, SizeOf(AValue));
end;

function TcxTokensStack.StackGetFloatItem(
  const AValue: Double): TcxStackItem;
begin
  Result := StackCreateTokenItem(ptgNum, AValue, SizeOf(AValue));
end;

function TcxTokensStack.StackGetLongStringItem(
  const AValue: WideString): TcxStackItem;
var
  ALen: Word;
begin
  ALen := Length(AValue);
  Result := StackItemAlloc(3 + ALen * 2);
  PWord(@Result.Tokens^[1])^ := ALen;
  Move(AValue[1], Result.Tokens^[3], ALen * 2);
  Result.Tokens^[0] := ptgLStr;
end;

function TcxTokensStack.StackGetStringItem(
  const AValue: string): TcxStackItem;
var
  AW: WideString;
  ALen: Byte;
begin
  if Length(AValue) > $FF - 2 then
    Result := StackGetLongStringItem(AValue)
  else
  begin
    if Length(AValue) > 0 then
    begin
      AW := AValue;
      ALen := Length(AValue);
      Result := StackItemAlloc(3 + ALen * 2);
      with Result do
      begin
        Tokens^[1] := ALen;
        Tokens^[2] := 1;
        Move(AW[1], Tokens^[3], ALen * 2);
      end;
    end
    else
      Result := StackItemAlloc(3);
    Result.Tokens^[0] := ptgStr;
  end;
end;

function TcxTokensStack.StackItemAlloc(const ASize: Integer): TcxStackItem;
begin
  Result.Tokens := AllocMem(ASize);
  Result.Size := ASize;
end;

class procedure TcxTokensStack.StackItemEmpty(var AStack: TcxStackItem);
begin
  FillChar(AStack, SizeOf(AStack), 0);
end;

function TcxTokensStack.StackUnion(ASrc1,
  ASrc2: TcxStackItem): TcxStackItem;
begin
  Result.Size := ASrc1.Size + ASrc2.Size;
  Result.Tokens := AllocMem(Result.Size);
  if ASrc1.Size > 0 then
    Move(ASrc1.Tokens^, Result.Tokens^, ASrc1.Size);
  if ASrc2.Size > 0 then
    Move(ASrc2.Tokens^, Result.Tokens^[ASrc1.Size], ASrc2.Size);
  StackItemClear(ASrc1);
  StackItemClear(ASrc2);
end;

function TcxTokensStack.StackUnions(
  const AStackItems: array of TcxStackItem): TcxStackItem;
var
  I, ASize: Integer;
  AItem: TcxStackItem;
begin
  ASize := 0;
  for I := Low(AStackItems) to High(AStackItems) do
    Inc(ASize, AStackItems[I].Size);
  Result := StackItemAlloc(ASize);
  ASize := 0;
  for I := Low(AStackItems) to High(AStackItems) do
  begin
    AItem := AStackItems[I];
    if AItem.Size > 0 then
    try
      Move(AItem.Tokens^, Result.Tokens^[ASize], AItem.Size);
      Inc(ASize, AItem.Size);
    finally
      StackItemClear(AItem);
    end;
  end;
end;

function TcxTokensStack.GetItemsCount: Integer;
begin
  Result := Length(FStackItems);
end;

{ TcxStackItemObject }

destructor TcxStackItemObject.Destroy;
begin
  if (Item.Size = 1) and (Item.Tokens^[0] in [ptgAdd..ptgParen]) then
  else
    FreeMem(Item.Tokens);
  inherited Destroy;
end;

{ TcxSpreadSheetExpressionParser }

constructor TcxSpreadSheetExpressionParser.Create(AHandler: TcxSSFunctionHandler);
begin
  Handler := AHandler;
end;

function TcxSpreadSheetExpressionParser.DoParse(
  var AExpression: string; var AParamsCount: Byte): TcxStackItem;
var
  ASubStr: string;
  Source, Dest: TcxObjectList;
  APriority: Integer;
  AListCount, AToken, APrevToken: Byte;
  AItem: TcxStackItem;
begin
  Result := NullStackItem;
  AParamsCount := 1;
  AToken := 0;
  Source := TcxObjectList.Create;
  try
    Dest := TcxObjectList.Create;
    try
      APriority := MaxInt;
      while (Length(AExpression) > 0) and not Handler.Error and not Handler.Owner.FHandlerError do
      begin
        APrevToken := AToken;
        AToken := GetNextItemFromString(AExpression, ASubStr, AItem);
        if (AToken = ptgIsect) and (not IsArea(AToken) or not IsArea(APrevToken)) then
          Continue;
        if AToken = ptgUnion then
        begin
          while Source.Count > 0 do PopAndPush(Source, Dest);
          Inc(AParamsCount);
          Continue;
        end;
        if not CheckUnaryOperation(AItem, AToken, APriority, APrevToken) then
          Continue;
        APriority := Priority(AToken);
        if APriority = -1 then
        begin
          Push(Dest, AItem);
          Continue;
        end;
        if AToken in [ptgParen, ptgFuncVarV] then
        begin
          AListCount := 0;
          if Length(ASubStr) > 0 then
            Push(Dest, DoParse(ASubStr, AListCount));
          if AToken = ptgParen then
            Push(Dest, OperationStackItems[18])
          else
            Push(Dest, CreateFuncItem(AListCount, AItem.Size));
        end
        else
        begin
          while CompareStackPriority(Source, APriority) do
            PopAndPush(Source, Dest);
          Push(Source, AItem, APriority);
        end;
      end;
      // finalize translation
      while Source.Count > 0 do PopAndPush(Source, Dest);
      Result := PopAll(Dest);
    finally
      Dest.Free;
    end;
  finally
    Source.Free;
  end;
end;

function TcxSpreadSheetExpressionParser.GetNextItemFromString(
  var AString, ASubExp: string; var AItem: TcxStackItem): Byte;
begin
  Result := Handler.GetNextStackItemFromString(AString, ASubExp, AItem);
end;

function TcxSpreadSheetExpressionParser.CompareStackPriority(
  AList: TcxObjectList; APriority: Integer): Boolean;
var
  APrior: Integer;
begin
  if AList.Count > 0 then
    APrior := TcxStackItemObject(AList.List^[AList.Count - 1]).Priority
  else
    APrior := -MaxInt;
  Result := APrior >= APriority;
  if Result and (APriority = 6) then
    Result := APriority <> APrior;
end;

function TcxSpreadSheetExpressionParser.Priority(AToken: Byte): Integer;
begin
  case AToken of
    ptgParen:
      Result := 0;
    ptgFuncVarV:
      Result := 1;
    ptgConcat..ptgRange:
      Result := 2;
    ptgAdd..ptgSub:
      Result := 3;
    ptgMul..ptgDiv:
      Result := 4;
    ptgPower:
      Result := 5;
    ptgUPlus, ptgUMinus:
      Result := 6;
  else
    Result := -1;
  end;
end;

procedure TcxSpreadSheetExpressionParser.Push(AList: TcxObjectList;
  const AItem: TcxStackItem; APriority: Integer = -1);
var
  AObject: TcxStackItemObject;
begin
  AObject := TcxStackItemObject.Create;
  AObject.Item := AItem;
  AObject.Priority := APriority;
  AList.Add(AObject);
end;

function TcxSpreadSheetExpressionParser.Pop(AList: TcxObjectList): TcxStackItem;
begin
  Result := NullStackItem;
  if AList.Count > 0 then
  begin
    with TcxStackItemObject(AList.List^[AList.Count - 1]) do
    begin
      Result := Item;
      Free;
    end;
    AList.Delete(AList.Count - 1);
  end;
end;

procedure TcxSpreadSheetExpressionParser.PopAndPush(ASource, ADest: TcxObjectList);
begin
  if ASource.Count > 0 then 
  begin
    with TcxStackItemObject(ASource.Last) do
    begin
      if not ((Item.Size = 1) and (Item.Tokens^[0] = ptgUnion)) then
        ADest.Add(ASource.Last)
      else
        Free;
    end;
    ASource.Delete(ASource.Count - 1);
  end;
end;

function TcxSpreadSheetExpressionParser.CheckUnaryOperation(
  var AItem: TcxStackItem; var AToken: Byte; APrevPriority, APrevToken: Integer): Boolean;
begin
  if (AToken in [ptgAdd, ptgSub]) and ((APrevPriority >= 2) or (APrevToken = ptgUnion)) then
  begin
    Inc(AToken, $F);
    AItem := OperationStackItems[AToken - ptgAdd];
  end;
  Result := AToken <> ptgUPlus;
end;

function TcxSpreadSheetExpressionParser.CreateFuncItem(
  AParamsCount: Byte; AFuncID: Word): TcxStackItem;
begin
  Result.Size := 4;
  Result.Tokens := AllocMem(4);
  Result.Tokens^[0] := ptgFuncVarV;
  Result.Tokens^[1] := AParamsCount;
  PWord(@Result.Tokens^[2])^ := AFuncID;
end;

function TcxSpreadSheetExpressionParser.IsArea(ACode: Byte): Boolean;
begin
  Result := ACode in [ptgRef, ptgRef3D, ptgName, ptgArea, ptgArea3D];
end;

function TcxSpreadSheetExpressionParser.PopAll(AList: TcxObjectList): TcxStackItem;
var
  I, ASize: Integer;
begin
  Result := NullStackItem;
  try
    ASize := 0;
    for I := 0 to AList.Count - 1 do
      with TcxStackItemObject(AList.List^[I]).Item do
      begin
      {$IFDEF DEBUG}
        Assert((Size <> 0) and (Tokens <> nil) , 'Invalid parsing');
      {$ENDIF}
        Inc(ASize, TcxStackItemObject(AList.List^[I]).Item.Size);
      end;
    if ASize > 0 then
    begin
      Result.Tokens := AllocMem(ASize);
      Result.Size := ASize;
      ASize := 0;
      for I := 0 to AList.Count - 1 do
        with TcxStackItemObject(AList.List^[I]).Item do
        begin
          Move(Tokens^, Result.Tokens^[ASize], Size);
          Inc(ASize, Size);
        end;
    end;
  finally
    AList.Clear;
  end;
end;

{ TcxSSFunctionHandler }

constructor TcxSSFunctionHandler.Create(AOwner: TcxSSFormulasCache);
begin
  FStack := TcxTokensStack.Create;
  FStringList := TStringList.Create;
  FOwner := AOwner;
end;

destructor TcxSSFunctionHandler.Destroy;
begin
  FStack.Free;
  FStringList.Free;
  inherited Destroy;
end;

function TcxSSFunctionHandler.CheckCondition(ACondition: Boolean;
  AErrCode: TcxSSErrorCode): Boolean;
begin
  Result := ACondition;
  if not Result then
    SetError(AErrCode);
end;

function TcxSSFunctionHandler.GetBooleanParameter: Boolean;
var
  AItem: TcxStackItem;
  APage, ACol, ARow: Integer;
begin
  FillChar(AItem, SizeOf(TcxStackItem), 0);
  with FStack do
  try
    if ItemsCount = 0 then
      SetError(ecValue)
    else
      AItem := StackPopItem;
    if AItem.Size > 0 then
    begin
      case StackItemType(AItem) of
        ptgBool:
          Result := Boolean(AItem.Tokens[1]);
        ptgNum:
          Result := PDouble(@AItem.Tokens^[1])^ <> 0;
        ptgStr, ptgLStr:
          if not cxTryStrToBool(StackTokensToStr(AItem.Tokens), Result) then
            Result := False;
        ptgName, ptgRef, ptgRef3D:
        begin
          GetRefParams(AItem.Tokens, APage, ACol, ARow);
          if not Error then
            Owner.GetCellValue(Self, APage, ACol, ARow, Result);
        end;
      else
        SetError(ecValue);
      end;
    end
    else
      SetError(ecValue);
  finally
    StackItemClear(AItem);
  end;
end;

function TcxSSFunctionHandler.GetFloatParameter: Double;
var
  AItem: TcxStackItem;
  APage, ACol, ARow: Integer;
begin
  FillChar(AItem, SizeOf(TcxStackItem), 0);
  with FStack do
  try
    if ItemsCount = 0 then
      SetError(ecValue)
    else
      AItem := StackPopItem;
    if AItem.Size > 0 then
    begin
      case StackItemType(AItem) of
        ptgBool:
          Result := Byte(AItem.Tokens[1]);
        ptgNum:
          Result := PDouble(@AItem.Tokens^[1])^;
        ptgStr, ptgLStr:
          if not cxTryStrToFloat(StackTokensToStr(AItem.Tokens), Result) then
            if not cxTryStrToDateTime(StackTokensToStr(AItem.Tokens), TDateTime(Result)) then
              SetError(ecValue);
        ptgName, ptgRef, ptgRef3D:
        begin
          GetRefParams(AItem.Tokens, APage, ACol, ARow);
          if not Error and not Owner.GetCellValue(Self, APage, ACol, ARow, Result) then
            SetError(ecName);
        end;
      else
        SetError(ecValue);
      end;
    end
    else
      SetError(ecValue);
  finally
    StackItemClear(AItem);
  end;
end;

function TcxSSFunctionHandler.GetStringParameter: string;
var
  AType: Byte;
begin
  Result := GetStringParameter(AType);
end;

function TcxSSFunctionHandler.GetStringParameter(var AType: Byte): string;
var
  AItem: TcxStackItem;
  APage, ACol, ARow: Integer;
begin
  FillChar(AItem, SizeOf(TcxStackItem), 0);
  with FStack do
  try
    if ItemsCount = 0 then
      SetError(ecValue)
    else
      AItem := StackPopItem;
    if AItem.Size > 0 then
    begin
      AType := StackItemType(AItem);
      case AType of
        ptgBool:
          Result := BoolToStr(Boolean(AItem.Tokens[1]));
        ptgNum:
          Result := FloatToStr(PDouble(@AItem.Tokens^[1])^);
        ptgStr:
          Result := StackTokensToStr(AItem.Tokens);
        ptgLStr:
          Result := StackTokensToStr(AItem.Tokens);
        ptgName, ptgRef, ptgRef3D:
        begin
          GetRefParams(AItem.Tokens, APage, ACol, ARow);
          if not Error and (APage = $FFFF) then
            SetError(ecRefErr);
          if not Error then
            Owner.GetCellValue(Self, APage, ACol, ARow, Result);
        end;
      else
        SetError(ecValue);
      end;
    end
    else
      SetError(ecValue);
  finally
    StackItemClear(AItem);
  end;
end;

procedure TcxSSFunctionHandler.EvaluateExpression(AFormulaPtr: PcxSSFormulaRec);

  procedure MakeResult;
  var
    AFloat: Double;
    ABool: Boolean;
    S: string;
  begin
    if not Error then
    begin
      S := GetStringParameter;
      AFloat := 0;
      if ResultType = rtString then
          SetStringResult(S)
      else
        if (S = '') or cxTryStrToFloat(S, AFloat) then
          SetFloatResult(AFloat)
        else
        begin
          if cxTryStrToBool(S, ABool) then
            FStack.StackAdd(FStack.StackGetBooleanItem(ABool))
          else
            SetStringResult(S);
        end;
      FFuncPtr^.CalcResult := FStack.StackPopItem;
    end
    else
    begin
      FFuncPtr^.States := fsError;
      FFuncPtr^.CalcResult := FStack.StackGetByteItem(Byte(FErrorCode));
    end;
    FStack.Clear;
  end;

var
  AOffset: Integer;
  AToken: Byte;
begin
  FResultType := rtValue;
  Initialize(AFormulaPtr);
  with AFormulaPtr^ do
  begin
    if FuncTree.Size > 0 then
    try
      AOffset := 0;
      while AOffset < FuncTree.Size do
      begin
        AToken := FuncTree.Tokens^[AOffset];
        case AToken of
          ptgAdd..ptgPercent:
            EvaluateOrdinal(AToken);
          ptgFuncVarV:
            EvaluateFunction(@FuncTree.Tokens^[AOffset]);
          ptgParen:;
        else
          with FStack do
            StackAdd(StackTokensToItem(@FuncTree.Tokens^[AOffset]));
        end;
        Inc(AOffset, FStack.TokensSize(@FuncTree.Tokens^[AOffset]));
      end;
    finally
      MakeResult;
    end;
  end;
end;

procedure TcxSSFunctionHandler.EnumParamValues(AFunc: Pointer;
  AValueTypes: TcxValueTypes);
var
  I: Integer;
  AFloatValue: Double;
begin
  FFloatValue := 0;
  FStringValue := '';
  FIsValueAssigned := False;
  FCallBackIndex := 0;
  for I := FParamsCount - 1 downto 0 do
  with FStack.StackPopItem do
  try
    if IsArea(Tokens^[0]) then
      EnumCellsAreas(Tokens, AFunc, AValueTypes)
    else
      case Tokens^[0] of
        ptgNum:
        begin
          if vtString in AValueTypes then
            TcxStringFuncCallBack(AFunc)(Self, FloatToStr(PDouble(@Tokens^[1])^))
          else
            TcxFloatFuncCallBack(AFunc)(Self, PDouble(@Tokens^[1])^);
          Inc(FCallBackIndex);
        end;
        ptgBool:
        begin
          if vtString in AValueTypes then
            TcxStringFuncCallBack(AFunc)(Self, BoolToStr(Boolean(Tokens^[1])))
          else
            TcxFloatFuncCallBack(AFunc)(Self, Tokens^[1]);
          Inc(FCallBackIndex);
        end;
        ptgStr, ptgLStr:
        begin
          if vtString in AValueTypes then
          begin
            TcxStringFuncCallBack(AFunc)(Self, FStack.StackTokensToStr(Tokens));
            Inc(FCallBackIndex);
          end
          else
          begin
            if cxTryStrToFloat(FStack.StackTokensToStr(Tokens), AFloatValue) then
            begin
              TcxFloatFuncCallBack(AFunc)(Self, AFloatValue);
              Inc(FCallBackIndex);
            end
            else
              SetError(ecValue);
          end;
        end;
      else
        ShowMessage(cxGetResourceString(@scxCaclulatorUnknownToken));
      end;
  finally
    FreeMem(Tokens);
  end;
end;

class function TcxSSFunctionHandler.ErrorCodeToStr(
  ACode: TcxSSErrorCode): string;
begin
  Result := '';
  case ACode of
    ecNull:
      Result := scxNullError;
    ecDivZero:
      Result := scxDivZeroError;
    ecValue:
      Result := scxValueError;
    ecRefErr:
      Result := scxRefError;
    ecNUM:
      Result := scxNumError;
    ecName:
      Result := scxNameError;
    ecNA:
      Result := scxNAError;
  end;
end;

procedure TcxSSFunctionHandler.SetBooleanResult(const Value: Boolean);
begin
  ResultType := rtValue;
  FuncHasResult := True;
  with FStack do
    StackAdd(StackGetBooleanItem(Value));
end;

procedure TcxSSFunctionHandler.SetError(ACode: TcxSSErrorCode);
begin
  ResultType := rtValue; 
  FErrorCode := ACode;
end;

procedure TcxSSFunctionHandler.SetStringResult(const Value: string);
begin
  ResultType := rtString;
  FuncHasResult := True;
  with FStack do
    StackAdd(StackGetStringItem(Value));
end;

procedure TcxSSFunctionHandler.SetFloatResult(const Value: Double);
begin
  ResultType := rtValue; 
  FuncHasResult := True;
  with FStack do
    StackAdd(StackGetFloatItem(Value));
end;

procedure TcxSSFunctionHandler.StringToTokens(const AExpression: string;
  AFormulaPtr: PcxSSFormulaRec);
var
  AStringExpression: string;
begin
  if not Owner.FHandlerError then
  begin
    Initialize(AFormulaPtr);
    with AFormulaPtr^ do
    try
      FStack.StackItemClear(FuncTree);
      try
        if CheckString(AExpression, AStringExpression) then
        try
          FuncTree := DoParse(AStringExpression);
          if (FErrorCode <> ecNone) and not Owner.IsLoading then
            ShowMessage(cxGetResourceString(@scxCaclulatorStringExpression));
        finally
          if not Owner.FHandlerError then
          begin
            if (FStack.ItemsCount > 0) then
            begin
              FStack.StackItemClear(FuncTree);
              ShowMessage(cxGetResourceString(@scxCaclulatorStringExpression));
            end;
          end;
        end;
      except
        FStack.StackItemEmpty(FuncTree);
        FStack.StackItemEmpty(CalcResult);
        ShowMessage(cxGetResourceString(@scxCaclulatorStringExpression));
      end
    finally
      FStack.Clear;
    end;
  end;
end;

function TcxSSFunctionHandler.TokensToExcelFormat(
  AFormulaPtr: PcxSSFormulaRec): TcxStackItem;
var
  W: WideString;
  AOffset: Integer;
  AItem: TcxStackItem;
begin
  FErrorCode := ecNone;
  FillChar(Result, SizeOf(Result), 0);
  Initialize(AFormulaPtr, False);
  with AFormulaPtr^ do
  begin
    if FuncTree.Size > 0 then
    begin
      AOffset := 0;
      FillChar(AItem, SizeOf(AItem), 0);
      while AOffset < FuncTree.Size do
      begin
        case FuncTree.Tokens^[AOffset] of
          ptgArea, ptgArea3D, ptgRef, ptgRef3D:
            AItem := StackAreaToExcelTokens(@FuncTree.Tokens^[AOffset]);
          ptgName:
          begin
            AItem := FStack.StackItemAlloc(5);
            AItem.Tokens^[0] := ptgNameV;
            PWord(@AItem.Tokens^[1])^ := PWord(@FuncTree.Tokens^[AOffset + 1])^ + 1;
          end;
          ptgLStr:
          begin
            SetLength(W, PWord(@FuncTree.Tokens^[AOffset + 1])^);
            Move(Pointer(@FuncTree.Tokens^[AOffset + 3])^, W[1], Length(W) * 2);
            SetLength(W, $FF - 2);  
            Result := FStack.StackGetStringItem(W);
          end;
        else
          AItem := FStack.StackTokensToItem(@FuncTree.Tokens^[AOffset]);
        end;
        Inc(AOffset, FStack.TokensSize(@FuncTree.Tokens^[AOffset]));
        Result := FStack.StackUnion(Result, AItem);
      end;
    end;
  end;
end;

function TcxSSFunctionHandler.TokensToString(
  AFormulaPtr: PcxSSFormulaRec): string;
var
  ATokens: PByteArray;
  AOffset: Integer;
  Res: TcxStackItem;
begin
  Result := '';
  Res := AFormulaPtr^.CalcResult;
  FillChar(AFormulaPtr^.CalcResult, SizeOf(TcxStackItem), 0);
  Initialize(AFormulaPtr);
  with AFormulaPtr^ do
  begin
    if FuncTree.Size > 0 then
    try
      AOffset := 0;
      while AOffset < FuncTree.Size do
      begin
        ATokens := @FuncTree.Tokens^[AOffset];
        case ATokens^[0] of
          ptgAdd..ptgPercent:
            SetOrdinalFromTokens(ATokens);
          ptgNum:
            FStringList.Add(FloatToStr(PDouble(@ATokens^[1])^));
          ptgName, ptgArea3D, ptgArea, ptgRef, ptgRef3D:
            SetReferenceFromTokens(ATokens);
          ptgStr, ptgLStr:
            SetStringFromTokens(ATokens);
          ptgBool:
            FStringList.Add(BoolToStr(Boolean(ATokens^[1])));
          ptgFuncVarV:
            SetFuncVarFromTokens(ATokens);
          ptgParen:
            FStringList[FStringList.Count - 1] := '(' + FStringList[FStringList.Count - 1] + ')';
        end;
        Inc(AOffset, FStack.TokensSize(ATokens));
      end;
    finally
      if FStringList.Count = 1 then
        Result := '=' + FStringList[0]
      else
        ShowMessage(cxGetResourceString(@scxCaclulatorConstructFormula));
      AFormulaPtr^.CalcResult := Res; 
    end;
  end;
end;

class function TcxSSFunctionHandler.FuncDefByToken(const AToken: Word;
  var ADef: TcxFuncDefinition): Boolean;
var
  D: PcxFuncDefinition;
begin
  D := Pointer(cxExcelConst.FuncDefByToken(AToken));
  Result := D <> nil;
  if Result then
    ADef := D^;
end;

class function TcxSSFunctionHandler.FuncDefByName(const AName: string;
  var ADef: TcxFuncDefinition): Boolean;
var
  D: PcxFuncDefinition;
begin
  D := Pointer(cxExcelConst.FuncDefByName(AName));
  Result := D <> nil;
  if Result then
    ADef := D^;
end;

class function TcxSSFunctionHandler.RegisterFunctions(
  const AFuncList: array of TcxFuncDefinition): Integer;
var
  I: Integer;
  ADef: PcxFuncDefinition;
begin
  Result := 0;
  for I := Low(AFuncList) to High(AFuncList) do
  begin
    with AFuncList[I] do
      ADef := Pointer(cxExcelConst.RegisterFunction(Name, Token, ParamsCount));
    if ADef <> nil then
    begin
      ADef^.Definition := AFuncList[I].Definition;
      Inc(Result);
    end;
  end;
end;

procedure TcxSSFunctionHandler.CheckExtraChars;
var
  AChars: string;
  APos: Integer;

  function GetNextMinCharCode: Byte;
  var
    I, APos: Integer;
  begin
    Result := Byte(AChars[1]);
    APos := 1;
    for I := 1 to Length(AChars) do
      if Result > Byte(AChars[I]) then
      begin
        APos := I;
        Result := Byte(AChars[I]);
      end;
    Delete(AChars, APos, 1);
  end;

begin
  AChars := '+-*/^<=>&%"() ' + ListSeparatorEx;
  APos := 0;
  while AChars <> '' do
  begin
    FExtraChars[APos] := GetNextMinCharCode;
    Inc(APos);
  end;
  AOperation[ptgUnion - 3] := ListSeparatorEx;
end;

function TcxSSFunctionHandler.CheckString(const AString: string;
  var ACheckedString: string): Boolean;
var
  APos: Integer;
  ACount, AStrCount: Integer;
begin
  APos := 1;
  while dxCharInSet(AString[APos], [' ', '=']) do
    Inc(APos);
  ACheckedString := Copy(AString, APos, Length(AString) - APos + 1);
  while (Length(ACheckedString) > 0) and
    (ACheckedString[Length(ACheckedString)] = ' ') do
      SetLength(ACheckedString, Length(ACheckedString) - 1);
  ACount := 0;
  AStrCount := 0;
  APos := 1;
  while APos <= Length(ACheckedString) do
  begin
    case ACheckedString[APos] of
      '(':
        Inc(ACount);
      ')':
        Dec(ACount);
      '"':
      begin
        Inc(AStrCount);
        Inc(APos);
        while APos <= Length(ACheckedString) do
        begin
          if ACheckedString[APos] = '"' then
          begin
            Dec(AStrCount);
            Break
          end
          else
            Inc(APos);
        end;
      end;
      '!':
      begin
        Inc(APos);
        while (APos <= Length(ACheckedString)) and (ACheckedString[APos] = ' ') do
          Delete(ACheckedString, APos, 1); 
        Dec(APos);
      end;
    end;
    Inc(APos);
  end;
  Result := (ACount = 0) and (AStrCount = 0);
  if not Result then
  begin
    if ACount <> 0 then
      ShowMessage(cxGetResourceString(@scxCaclulatorErrorSymbol))
    else
      ShowMessage(cxGetResourceString(@scxCaclulatorErrorString));
  end;
end;

function TcxSSFunctionHandler.CheckStringItem(const AString: string;
  var AStackItem: TcxStackItem): Byte;
var
  AFloat: Double;
  ABool: Boolean;
begin
  Result := 0;
  if Length(AString) > 0 then
  begin
    Result := $FF;
    if Length(AString) <= 2 then
    begin
      Result := CheckOrdinalOperation(AString);
      if Result <> $FF then
        AStackItem := OperationStackItems[Result]
    end;
    if Result = $FF then
    begin
      if cxTryStrToFloat(AString, AFloat) then
        AStackItem := FStack.StackGetFloatItem(AFloat)
      else
        if cxTryStrToBool(AString, ABool) then
          AStackItem := FStack.StackGetBooleanItem(ABool)
        else
          if not GetReferenceFromString(AStackItem, AString) then
            Result := GetUnknownItem(AStackItem, AString);
    end; 
  end;
  if AStackItem.Size > 0 then
    Result := AStackItem.Tokens^[0];
end;

function TcxSSFunctionHandler.DoParse(var AString: string): TcxStackItem;
var
  AToken: Byte;
begin
  FillChar(Result, SizeOf(Result), 0);
  with TcxSpreadSheetExpressionParser.Create(Self) do
  try
    Result := DoParse(AString, AToken);
  finally
    Free;
  end;
end;

function TcxSSFunctionHandler.GetAreaInfo(ATokens: PByteArray;
  var APage: Integer; var ARange: TRange): Boolean;
  
  function GetPage: Word;
  begin
    Result := PWord(ATokens)^;
    Inc(Integer(ATokens), 2);
  end;

var
  AToken: Byte;
begin
  AToken := ATokens[0];
  Inc(Integer(ATokens));
  APage := FPage;
  Result := IsArea(AToken);
  if not Result then Exit;
  if AToken in [ptgRef3D, ptgArea3D, ptgName] then
  begin
    APage := GetPage;
    SetAbsolutePosition;
  end;
  case AToken of
    ptgRef, ptgRef3D:
    begin
      if not (CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[6])^, PInteger(@ATokens^[2])^,
        Boolean(ATokens^[1]), Boolean(ATokens^[0]), ARange.Left, ARange.Top)) then
          SetError(ecRefErr);
      ARange.BottomRight := ARange.TopLeft;
    end;
    ptgArea, ptgArea3D:
      if not (CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[12])^, PInteger(@ATokens^[4])^,
         Boolean(ATokens^[2]), Boolean(ATokens^[0]), ARange.Left, ARange.Top) and
          CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[16])^, PInteger(@ATokens^[8])^,
            Boolean(ATokens^[3]), Boolean(ATokens^[1]), ARange.Right, ARange.Bottom)) then
              SetError(ecRefErr);
    ptgName:
      if (APage < Length(Owner.GetNames)) and not Owner.GetNames[APage].IsDeleted then
        with Owner.GetNames[APage] do
        begin
          ARange := Definition.Area;
          APage := Definition.Page;
        end
      else
        SetError(ecRefErr);
  end;
  RestorePosition;
end;

procedure TcxSSFunctionHandler.EnumCellsAreas(ATokens: PByteArray;
  AFunc: Pointer; AValueType: TcxValueTypes);
var
  ARange: TRange;
  APage, I, J: Integer;
  AFloatValue: Double;
  AStringValue: string;
begin
  if not GetAreaInfo(ATokens, APage, ARange) then Exit;
  if vtString in AValueType then
  begin
    for J := ARange.Top to ARange.Bottom do
      for I := ARange.Left to ARange.Right do
      begin
        Owner.GetCellValue(Self, APage, I, J, AStringValue);
        TcxStringFuncCallBack(AFunc)(Self, AStringValue);
        Inc(FCallBackIndex);
      end;
  end
  else
  begin
    for J := ARange.Top to ARange.Bottom do
      for I := ARange.Left to ARange.Right do
         if Owner.GetCellValue(Self, APage, I, J, AFloatValue) then
         begin
           TcxFloatFuncCallBack(AFunc)(Self, AFloatValue);
           Inc(FCallBackIndex);
         end;
  end;
end;

function TcxSSFunctionHandler.GetNextStackItemFromString(
  var AString, ASubExp: string; var AStackItem: TcxStackItem): Byte;
var
  APos: Integer;
  AKeyCode: Byte;
  AFuncDef: TcxFuncDefinition;

  function CheckNames: Boolean;
  var
    ALen, I: Integer;
    ANames: TcxSSNamesDef;
    ASheets: TcxSSSheetsDef;
  begin
    ANames := Owner.Names;
    ASheets := Owner.Sheets;
    Result := False;
    ALen := -1;
    for I := 0 to Length(ANames) - 1 do
    begin
      with ANames[I] do
      begin
        if (AnsiCompareText(Name, Copy(AString, 1, Length(Name))) = 0) and
          (ALen < Length(Name)) then ALen := Length(Name);
      end;
    end;
    if (ALen > 0) and ((ALen >= Length(AString)) or not dxCharInSet(AString[ALen + 1], ['1'..'9'])) then
    begin
      Result := True;
      APos := ALen + 1;
      Exit;
    end;
    ALen := -1;
    for I := 0 to Length(ASheets) - 1 do
    begin
      with ASheets[I] do
      begin
        if (AnsiCompareText(SheetName, Copy(AString, 1, Length(SheetName))) = 0) and (ALen < Length(SheetName)) then
          ALen := Length(SheetName);
      end;
    end;
    if ALen > 0 then
      APos := ALen + 1;
  end;

begin
  Result := 0;
  APos := 1;
  ASubExp := '';
  FStack.StackItemEmpty(AStackItem);
  if not CheckNames then
  begin
    while APos <= Length(AString) do
    begin
      if IsExtraChar(Byte(AString[APos])) then
      begin
        if Byte(AString[APos]) = Byte('-') then
        begin
          if (APos > 2) and (Byte(AString[APos - 1]) = Byte('[')) then
//          if (APos > 2) and (Byte(AString[APos - 1]) = Byte('E')) then
          begin
            Inc(APos);
            Continue;
          end;
        end;
        Break;
      end;
      Inc(APos);
    end;
  end;
  if APos > Length(AString) then
  begin
    Dec(APos);
    Result := CheckStringItem(Copy(AString, 1, APos), AStackItem);
    Delete(AString, 1, APos);
  end
  else
  begin
    AKeyCode := Byte(AString[APos]);
    if (APos = 1) and ((AKeyCode = Byte('<')) or (AKeyCode = Byte('>'))) then
    begin
      if (Byte(AString[2]) = Byte('=')) or (Byte(AString[2]) = Byte('>')) then
        Inc(APos);
    end
    else
    begin
      if APos <> 1 then
        Dec(APos);
    end;
    if AKeyCode = Byte('(') then
    begin
      if APos = 1 then
        Result := ptgParen
      else
      begin
        if FuncDefByName(Copy(AString, 1, APos), AFuncDef) then
        begin
          AStackItem.Size := AFuncDef.Token;
          Result := ptgFuncVarV;
          Delete(AString, 1, APos);
        end
        else
          SetError(ecName);
      end;
      ASubExp := GetSubExpression(AString);
    end
    else
      if AKeyCode = Byte('"') then
      begin
        Result := ptgStr;
        AStackItem := FStack.StackGetStringItem(GetSubString(AString));
      end
      else
      begin
        if (UpCase(AString[APos]) = 'E') and (APos > 1) and
          cxTryStrToFloat(Copy(AString, 1, APos - 1)) then
        begin
          if (AKeyCode = Byte('+')) or (AKeyCode = Byte('-')) then
          begin
            Inc(APos);
            if Byte(AString[APos]) = AKeyCode then
              Inc(APos);
            while (APos <= Length(AString)) and (Byte(AString[APos]) >= Byte('0'))
              and (Byte(AString[APos]) <= Byte('9')) do Inc(APos);
            Dec(APos);
          end;
        end;
        Result := CheckStringItem(Copy(AString, 1, APos), AStackItem);
        Delete(AString, 1, APos);
      end;
  end;
end;

function TcxSSFunctionHandler.GetSubExpression(var AString: string): string;
var
  APos: Integer;
  ACount: Integer;
begin
  ACount := 0;
  APos := 0;
  repeat
    Inc(APos);
    if AString[APos] = '"' then
    begin
      Inc(APos);
      while (AString[APos] <> '"') and (APos < Length(AString)) do Inc(APos);
    end;
    if AString[APos] = '(' then
      Inc(ACount)
    else
      if AString[APos] = ')' then
        Dec(ACount);
  until ACount = 0;
  if (APos - 2) > 0 then
    Result := Copy(AString, 2, APos - 2)
  else
    Result := '';
  Delete(AString, 1, Length(Result) + 2);
end;

function TcxSSFunctionHandler.GetSubString(var AString: string): string;
var
  APos: Integer;
  ACount: Integer;
begin
  APos := 2;
  Result := '';
  while APos <= Length(AString) do
  begin
    if AString[APos] = '"' then
    begin
      if (APos < Length(AString)) and (AString[APos + 1] = '"') then
      begin
        Inc(APos, 2);
        Continue;
      end;
      ACount := 0;
      while ((APos + ACount) <= Length(AString)) and (AString[APos + ACount] = '"') do
        Inc(ACount);
      if (ACount div 2) > 0 then
      begin
        Delete(AString, APos, ACount div 2);
        Inc(APos, ACount div 2);
      end;
      if Odd(ACount) then
      begin
        Result := Copy(AString, 2, APos - 2);
        Delete(AString, 1, Length(Result) + 2);
        Break;
      end;
    end;
    Inc(APos);
  end;
  Result := StringReplace(Result, '""', '"', [rfReplaceAll]);
end;

function TcxSSFunctionHandler.GetUnknownItem(var AStackItem: TcxStackItem;
  const AString: string): Byte;
begin
  Result := 0;
  SetError(ecName);
  ShowMessage(cxGetResourceString(@scxCaclulatorUnknownExpression) + ' - ' + AString);
end;

procedure TcxSSFunctionHandler.Initialize(AFormulaPtr: PcxSSFormulaRec;
  ClearResult: Boolean = True);
begin
  with AFormulaPtr^ do
  begin
    FErrorCode := ecNone;
    FStack.Clear;
    if ClearResult then
      FStack.StackItemClear(CalcResult);
    FStringList.Clear;
    CheckExtraChars;
  end;
  FFuncPtr := AFormulaPtr;
  RestorePosition;
end;

procedure TcxSSFunctionHandler.ShowMessage(const AMessage: string);
begin
  if (Owner <> nil) and (Owner.FIsLoading) then
    Owner.FHandlerError := True
  else
   Dialogs.ShowMessage(AMessage);
end;

class function TcxSSFunctionHandler.ValidSheetName(const ASheetName: string): string;
begin
  if Pos(' ', ASheetName) <> 0 then
    Result := '''' + ASheetName + ''''
  else
    Result := ASheetName;
end;

function TcxSSFunctionHandler.IsArea(ACode: Byte): Boolean;
begin
  Result := ACode in [ptgRef, ptgRef3D, ptgName, ptgArea, ptgArea3D];
end;

function TcxSSFunctionHandler.IsExtraChar(ACode: Byte): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (ACode >= FExtraChars[0]) and (ACode <= FExtraChars[14]) then
  begin
    for I := 0 to 14 do
    begin
      if Result or (FExtraChars[I] > ACode) then
        Break
      else
        Result := FExtraChars[I] = ACode;
    end;
  end;
end;

function TcxSSFunctionHandler.CheckColReference(var AString: string;
  var ACol: Integer; var AbsCol: Boolean): Boolean;

  procedure GetRef;
  begin
    AbsCol := AString[1] = '$';
    if AbsCol then
      Delete(AString, 1, 1);
    Result := GetColumnFromStr(AString, ACol);
    if not AbsCol then
      ACol := ACol - FCol;
  end;

  procedure GetRCRef;
  begin
    if AString[1] = 'C' then
    begin
      Delete(AString, 1, 1);
      AbsCol := (Length(AString) <> 0) and dxCharInSet(AString[1], ['1'..'9']);
      if (Length(AString) > 0) and (AString[1] <> ':') then
      begin
        if AbsCol then
        begin
          Result := GetIntFromStr(AString, ACol);
//          if Result then Inc(ACol);
        end
        else
          if AString[1] = '[' then
          begin
            Delete(AString, 1, 1);
            Result := GetIntFromStr(AString, ACol);
            Delete(AString, 1, 1);
          end;
      end
      else
      begin
        ACol := 0;
        Result := True;
      end;
    end
  end;

begin
  AbsCol := False;
  ACol := 0;
  Result := False;
  if Length(AString) <> 0 then
  begin
    if not Owner.RCReference then
      GetRef
    else
      GetRCRef;
  end;
end;

function TcxSSFunctionHandler.CheckColRowReference(var AString: string;
  var ACol, ARow: Integer; var AbsCol, AbsRow: Boolean): Boolean;
begin
  ACol := 0;
  ARow := 0;
  AbsCol := False;
  AbsRow := False;
  Result := False;
  if Length(AString) = 0 then Exit;
  if Owner.RCReference then
  begin
    if AString[1] = 'R' then
      Result := CheckRowReference(AString, ARow, AbsRow)
    else
      Result := True;
    Result := Result and CheckColReference(AString, ACol, AbsCol);
  end
  else
    Result := CheckColReference(AString, ACol, AbsCol) and
      CheckRowReference(AString, ARow, AbsRow);
end;
                                             
function TcxSSFunctionHandler.CheckColumnAndRow(ACol, ARow: Integer; AColOfs,
  ARowOfs: Integer; AbsCol, AbsRow: Boolean; var Col, Row: Integer): Boolean;
begin
  Col := AColOfs;
  Row := ARowOfs;
  if not AbsCol then
    Col := Col + ACol;
  if not AbsRow then
    Row := Row + ARow;
  Result := (Col >= 0) and (Row >= 0)
end;

function TcxSSFunctionHandler.CheckNameReference(var AString: string;
  var ANameIndex: SmallInt): Boolean;
var
  AName: string;
  ANames: TcxSSNamesDef;
  ASheets: TcxSSSheetsDef;
  APos: Integer;
  IsRef3D: Boolean;
  I: Integer;
begin
  ASheets := nil;
  APos := Pos('!', AString);
  IsRef3D := APos <> 0;
  if APos = 0 then
    APos := Pos(':', AString);
  Result := False;
  ANameIndex := -1;
  if APos > 0 then
    AName := Copy(AString, 1, APos - 1)
  else
  begin
    AName := AString;
    APos := Length(AString);
  end;
  if Assigned(Owner) then
    ANames := Owner.GetNames
  else
    SetLength(ANames, 0);
  for I := Length(ANames) - 1 downto 0 do
    if AnsiCompareText(ANames[I].Name, AName) = 0 then
    begin
      ANameIndex := I;
      Result := True;
      Break;
    end;
  if not Result and IsRef3D and Assigned(Owner) then
  begin
    ASheets := Owner.GetSheets;
    for I := 0 to Length(ASheets) - 1 do
      if AnsiCompareText(ASheets[I].SheetName, AName) = 0 then
      begin
        ANameIndex := I;
        Result := True;
        Break;
      end;
  end;
  if Result then
    Delete(AString, 1, APos);
end;

function TcxSSFunctionHandler.CheckOrdinalOperation(const AString: string): Byte;
var
  AEndPos: Integer;
const
  StartPos: array[Boolean] of Byte = (0, 6);
  EndPos: array[Boolean] of Byte = (High(AOperation), 11);
begin
  Result := $FF;
  if Length(AString) > 2 then Exit;
  Result := StartPos[Length(AString) = 2];
  AEndPos := EndPos[Length(AString) = 2];
  while (Result <= AEndPos) do
  begin
    if AOperation[Result] = AString then
      Exit;
    Inc(Result);
  end;
  Result := $FF;
end;

function TcxSSFunctionHandler.CheckRowReference(var AString: string;
  var ARow: Integer; var AbsRow: Boolean): Boolean;

  procedure GetRowRef;
  begin
    AbsRow := AString[1] = '$';
    if AbsRow then Delete(AString, 1, 1);
    Result := GetIntFromStr(AString, ARow);
    if not AbsRow then
      ARow := ARow - FRow;
  end;

  procedure GetRowRCRef;
  begin
    if AString[1] = 'R' then
    begin
      Delete(AString, 1, 1);
      AbsRow := (Length(AString) <> 0) and dxCharInSet(AString[1], ['1'..'9']);
      if Length(AString) > 0 then
      begin
        if AbsRow then
        begin
          Result := GetIntFromStr(AString, ARow);
{          if Result then
            Inc(ARow);}
        end
        else
          if AString[1] = '[' then
          begin
            Delete(AString, 1, 1);
            Result := GetIntFromStr(AString, ARow);
            Delete(AString, 1, 1);
          end;
      end
      else
      begin
        ARow := 0;
        Result := True;
      end;
    end
  end;

begin
  AbsRow := False;
  ARow := 0;
  Result := False;
  if Length(AString) <> 0 then
  begin
    if not Owner.RCReference then
      GetRowRef
    else
      GetRowRCRef;
  end;
end;

procedure TcxSSFunctionHandler.EvaluateOrdinal(AToken: Byte);
var
  AStringValue: string;
begin
  if AToken in [ptgAdd..ptgPower, ptgUPlus..ptgPercent] then
    OrdinalMainEvaluate(AToken)
  else
    if AToken in [ptgLT..ptgNE] then
      OrdinalBooleanEvaluate(AToken)
    else
      if AToken = ptgIsect then
        OrdinalIntersectEvaluate
      else
        if AToken = ptgConcat then
        begin
          AStringValue := GetStringParameter;
          SetStringResult(GetStringParameter + AStringValue);
        end
        else
          ShowMessage(cxGetResourceString(@scxCaclulatorUnknownToken));
end;

procedure TcxSSFunctionHandler.EvaluateFunction(ATokens: PByteArray);
var
  ADef: TcxFuncDefinition;
begin
  FIsValueAssigned := False;
  with FStack do
  try
    FParamsCount := ATokens^[1];
    if CheckCondition(FuncDefByToken(PWord(@ATokens^[2])^, ADef), ecValue) then
    begin
      FFuncHasResult := False;
      TcxSSFunction(ADef.Definition)(Self);
      if not FuncHasResult then
        raise ECalculationError.Create(cxGetResourceString(@scxCaclulatorFuncNeedResult));
    end;
  finally
    FIsValueAssigned := False;
  end;
end;

function TcxSSFunctionHandler.GetColumnFromStr(var AString: string;
  var AValue: Integer): Boolean;
var
  I: Integer;
begin
  I := 1;
  while (I <= Length(AString)) and dxCharInSet(AString[I], ['A'..'Z']) do Inc(I);
  AValue := 0;
  try
    if (I - 1)  = 0 then
      Result := False
    else
      try
        AValue := TcxSSUtils.ColumnIndexByName(dxStringToShortString(Copy((AString), 1, I - 1)));
        Result := True;
      except
        AValue := 0;
        Result := False;
      end;
  finally
    Delete(AString, 1, I - 1);
  end;
end;

function TcxSSFunctionHandler.GetIntFromStr(var AString: string;
  var AValue: Integer): Boolean;
var
  I: Integer;
begin
  I := 1;
  while (I <= Length(AString)) and dxCharInSet(AString[I], ['-', '0'..'9']) do Inc(I);
  AValue := 0;
  if (I - 1)  = 0 then
    Result := False
  else
    Result := cxTryStrToInt(Copy(AString, 1, I - 1), AValue);
  Delete(AString, 1, I - 1);
  if Result and (AValue > 0) then Dec(AValue);
end;

function TcxSSFunctionHandler.GetError: Boolean;
begin
  Result := FErrorCode <> ecNone;
end;

function TcxSSFunctionHandler.GetExtraChars;
begin
  SetLength(Result, Length(FExtraChars));
  Move(FExtraChars[0], Result[1], Length(FExtraChars));
end;

function TcxSSFunctionHandler.GetReferenceFromString(
  var AReference: TcxStackItem; const AString: string): Boolean;
var
  ASize: Byte;
  AToken: Byte;
  ATokens: array[0..22] of Byte;

  function CheckReferences(AStringExpr: string): Boolean;
  begin
{    AToken := ptgRef;
    S := AStringExpr;
    Result := CheckColRowReference(S, PInteger(@ATokens[6])^,
      PInteger(@ATokens[2])^, PBoolean(@ATokens[1])^, PBoolean(@ATokens[0])^);
    ASize := 10;
    if (S = '') and Result then Exit;                               }
    Result := CheckNameReference(AStringExpr, PSmallInt(@ATokens)^);
    if Result then
    begin
      if (Length(AStringExpr) > 0) then
      begin
         SetAbsolutePosition;
         if Pos(':', AStringExpr) <> 0 then
         begin
           AToken := ptgArea3D;
           Result := CheckColRowReference(AStringExpr, PInteger(@ATokens[14])^,
             PInteger(@ATokens[6])^, PBoolean(@ATokens[4])^, PBoolean(@ATokens[2])^);
           Delete(AStringExpr, 1, 1);
           if Pos('!', AStringExpr) <> 0 then
           begin
             PInteger(@ATokens[18])^ := PInteger(@ATokens[14])^;
             PInteger(@ATokens[10])^ := PInteger(@ATokens[6])^;
             ATokens[5] := ATokens[4];
             ATokens[3] := ATokens[2];
           end
           else
             Result := Result and CheckColRowReference(AStringExpr, PInteger(@ATokens[18])^,
               PInteger(@ATokens[10])^, PBoolean(@ATokens[5])^, PBoolean(@ATokens[3])^);
           ASize := 22;
         end
         else
         begin
           AToken := ptgRef3D;
           Result := CheckColRowReference(AStringExpr, PInteger(@ATokens[8])^,
             PInteger(@ATokens[4])^, PBoolean(@ATokens[3])^, PBoolean(@ATokens[2])^);
           ASize := 12;
         end;
         RestorePosition;
      end
      else
      begin
        AToken := ptgName;
        ASize := 2;
      end;
    end
    else
    begin
      if Pos(':', AStringExpr) <> 0 then
      begin
        AToken := ptgArea;
        Result := CheckColRowReference(AStringExpr, PInteger(@ATokens[12])^,
          PInteger(@ATokens[4])^, PBoolean(@ATokens[2])^, PBoolean(@ATokens[0])^);
        Delete(AStringExpr, 1, 1);
        Result := Result and CheckColRowReference(AStringExpr, PInteger(@ATokens[16])^,
          PInteger(@ATokens[8])^, PBoolean(@ATokens[3])^, PBoolean(@ATokens[1])^);
        ASize := 20;
      end
      else
      begin
        AToken := ptgRef;
        Result := CheckColRowReference(AStringExpr, PInteger(@ATokens[6])^,
          PInteger(@ATokens[2])^, PBoolean(@ATokens[1])^, PBoolean(@ATokens[0])^);
        ASize := 10;
      end;
    end;
  end;

begin
  Result := CheckReferences(AnsiUpperCase(AString));
  if Result then
  begin
    AReference := FStack.StackItemAlloc(ASize + 1);
    AReference.Tokens^[0] := AToken;
    Move(ATokens, AReference.Tokens^[1], ASize);
  end;
end;

procedure TcxSSFunctionHandler.GetRefParams(ATokens: PByteArray;
  var APage, ACol, ARow: Integer);
var
  AToken: Byte;
begin
  AToken := ATokens^[0];
  Inc(Integer(ATokens));
  if AToken in [ptgRef3D, ptgName] then
  begin
    APage := PWord(ATokens)^;
    Inc(Integer(ATokens), 2);
    SetAbsolutePosition;
  end
  else
    APage := FPage;
  case AToken of
  ptgName:
    begin
      if (APage < Length(Owner.GetNames)) and not Owner.GetNames[APage].IsDeleted then
      begin
        with Owner.GetNames[APage].Definition do
        begin
          if (Area.Top < 0) or (Area.Bottom < 0) or (Page >= Length(Owner.GetSheets)) then
            SetError(ecRefErr)
          else
            if Area.TopLeft <> Area.BottomRight then
              SetError(ecValue)
            else
            begin
              APage := Page;
              ACol := Area.Left;
              ARow := Area.Top;
            end;
        end
      end
      else
        SetError(ecRefErr);
    end;
  ptgRef, ptgRef3d:
    CheckCondition(CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[6])^,
      PInteger(@ATokens^[2])^, Boolean(ATokens^[1]), Boolean(ATokens^[0]),
        ACol, ARow), ecRefErr);
  end;
  RestorePosition;
end;

function TcxSSFunctionHandler.ptgRefToStr(AIndex: Word): string;
begin
  Result := Owner.GetNames[AIndex].Name;
end;

function TcxSSFunctionHandler.ptgRefToStr(AIsAbsolute: PBoolArray;
  ATokens: PIntArray): string;
begin
  Result := ptgRefToStr(AIsAbsolute^[2], AIsAbsolute^[0], ATokens^[2], ATokens^[0]) +
    ':' + ptgRefToStr(AIsAbsolute^[3], AIsAbsolute^[1], ATokens^[3], ATokens^[1]);
end;

function TcxSSFunctionHandler.ptgRefToStr(ASheet: Word; AIsAbsolute: PBoolArray;
  ATokens: PIntArray): string;
begin
  SetAbsolutePosition;
  Result := Owner.GetSheets[ASheet].SheetName +
    '!' + ptgRefToStr(AIsAbsolute, ATokens);
  RestorePosition;
end;

function TcxSSFunctionHandler.ptgRefToStr(ASheet: Word; const AbsCol, AbsRow: Boolean;
  const ACol, ARow: Integer): string;
var
  AName: string;
begin
  SetAbsolutePosition;
  if ASheet > Length(Owner.GetSheets) then
    AName := scxRefError
  else
    AName := Owner.GetSheets[ASheet].SheetName;
  Result := AName + '!' + ptgRefToStr(AbsCol, AbsRow, ACol, ARow);
  RestorePosition;
end;

function TcxSSFunctionHandler.ptgRefToStr(const AbsCol, AbsRow: Boolean;
  ACol, ARow: Integer): string;

  function RCItemStr(AItem: Integer; IsAbsolute: Boolean): string;
  begin
    if not IsAbsolute then
    begin
      if AItem <> 0 then
        Result := '[' + IntToStr(AItem) + ']'
    end
    else
      Result := IntToStr(AItem + 1);
  end;

const
  AbsChars: array[Boolean] of string = ('', '$');

begin
  if not Owner.RCReference then
  begin
    if not AbsCol then ACol := ACol + FCol;
    if not AbsRow then ARow := ARow + FRow;
  end;
  if not Owner.RCReference then
    Result := AbsChars[AbsCol] + TcxSSUtils.ColumnNameByIndex(ACol) +
      AbsChars[AbsRow] + TcxSSUtils.RowNameByIndex(ARow)
  else
    Result := 'R' + RCItemStr(ARow, AbsRow) + 'C' + RCItemStr(ACol, AbsCol);
end;

procedure TcxSSFunctionHandler.OrdinalBooleanEvaluate(const AOperation: Byte);

  function StringCompare(const AString1, AString2: string): Boolean;
  var
    ACompareResult: Integer;
  begin
    ACompareResult := AnsiCompareText(AString1, AString2);
    case AOperation of
      ptgLT:
        Result := ACompareResult < 0;
      ptgLE:
        Result :=  ACompareResult <= 0;
      ptgEQ:
        Result := ACompareResult = 0;
      ptgGE:
        Result :=  ACompareResult >= 0;
      ptgGT:
        Result :=  ACompareResult > 0;
      ptgNE:
        Result :=  ACompareResult <> 0;
    else
      Result := False;
    end;
  end;

  function FloatCompare(const AValue1, AValue2: Double): Boolean;
  begin
    case AOperation of
      ptgLT:
        Result := AValue1 < AValue2;
      ptgLE:
        Result := AValue1 <= AValue2;
      ptgEQ:
        Result := AValue1 = AValue2;
      ptgGE:
        Result := AValue1 >= AValue2;
      ptgGT:
        Result := AValue1 > AValue2;
      ptgNE:
        Result := AValue1 <> AValue2;
    else
      Result := False;
    end;
  end;

var
  AStringValue, ANextValue: string;
  AFloat1, AFloat2: Double;
  ABool1, ABool2: Boolean;
  ABoolValue: Boolean;
begin
  AFloat2 := 0;
  AStringValue := GetStringParameter;
  ANextValue := GetStringParameter;
  if cxTryStrToFloat(AStringValue, AFloat1) and
    ((ANextValue = '') or cxTryStrToFloat(ANextValue, AFloat2)) then
    ABoolValue := FloatCompare(AFloat2, AFloat1)
  else
    if cxTryStrToBool(AStringValue, ABool1) and cxTryStrToBool(ANextValue, ABool2) then
      ABoolValue := FloatCompare(Byte(ABool2), Byte(ABool1))
    else
      ABoolValue := StringCompare(ANextValue, AStringValue);
  SetBooleanResult(ABoolValue);
end;

procedure TcxSSFunctionHandler.OrdinalIntersectEvaluate;
var
  APages: array[0..1] of Word;
  ARanges: array[0..1] of TRange;
  I: Integer;
  AStackItem: TcxStackItem; 
begin
  for I := 0 to 1 do
    with FStack.StackPopItem do
    begin
      StackTokensToArea(Tokens, APages[I], ARanges[I]);
      FreeMem(Tokens);
    end;
  if not Error and (APages[0] = APages[1]) and
    TcxSSUtils.IntersectRange(ARanges[0], ARanges[0], ARanges[1]) then
  begin
    AStackItem := FStack.StackItemAlloc(23);
    with AStackItem do
    begin
      Tokens^[0] := ptgArea3D;
      PWord(@Tokens^[1])^ := APages[0];
      FillChar(Tokens^[3], 4, 1);
      PInteger(@Tokens^[7])^ := ARanges[0].Top;
      PInteger(@Tokens^[11])^ := ARanges[0].Bottom;
      PInteger(@Tokens^[15])^ := ARanges[0].Left;
      PInteger(@Tokens^[19])^ := ARanges[0].Right;
    end;
    FStack.StackAdd(AStackItem);
  end
  else
    if not Error then
      SetError(ecRefErr);
end;

procedure TcxSSFunctionHandler.OrdinalMainEvaluate(const AOperation: Byte);
var
  AFloatValue, ANextValue: Double;
begin
  AFloatValue := GetFloatParameter;
  if not (AOperation in [ptgUPlus..ptgPercent]) then
    ANextValue := GetFloatParameter
  else
    ANextValue := 0;
  if not Error then
  begin
     case AOperation of
       ptgAdd:
         AFloatValue := ANextValue + AFloatValue;
       ptgSub:
         AFloatValue := ANextValue - AFloatValue;
       ptgMul:
         AFloatValue := ANextValue * AFloatValue;
       ptgDiv:
         if CheckCondition(AFloatValue <> 0, ecDivZero) then
           AFloatValue := ANextValue/AFloatValue
         else
         begin
           SetStringResult(scxDivZeroError);
           Exit;
         end;
       ptgPower:
         AFloatValue := Power(ANextValue, AFloatValue);
       ptgUMinus:
         AFloatValue := -AFloatValue;
       ptgPercent:
         AFloatValue := AFloatValue / 100;
     end;
     SetFloatResult(AFloatValue);
  end
  else
    SetFloatResult(ANextValue);
end;

procedure TcxSSFunctionHandler.SetFuncVarFromTokens(ATokens: PByteArray);

  function GetFuncParams(AParamsCount: Byte): string;
  var
    I: Integer;
  begin
    Result := '';
    with FStringList do
    begin
      if AParamsCount > Count then
        AParamsCount := Count;
      for I := 0 to AParamsCount - 1 do
      begin
        if Result <> '' then
           Result :=  FStringList[Count - 1] + ListSeparatorEx + Result
        else
          Result :=  FStringList[Count - 1];
        Delete(Count - 1);
      end;
    end;
  end;

var
  AFuncDef: TcxFuncDefinition;
begin
  FuncDefByToken(PWord(@ATokens^[2])^, AFuncDef);
  if AFuncDef.Params = fpNone then
    FStringList.Add(AFuncDef.Name + '()')
  else
    FStringList.Add(AFuncDef.Name + '(' + GetFuncParams(ATokens^[1]) + ')');
end;

procedure TcxSSFunctionHandler.SetFloatValue(const Value: Double);
begin
  FFloatValue := Value;
  FIsValueAssigned := True;
end;

procedure TcxSSFunctionHandler.RestorePosition;
begin
  FCol := FFuncPtr^.Col;
  FRow := FFuncPtr^.Row;
  FPage := FFuncPtr^.Page;
end;

procedure TcxSSFunctionHandler.SetAbsolutePosition;
begin
  FCol := 0;
  FRow := 0;
  FPage := 0;
end;

procedure TcxSSFunctionHandler.SetOrdinalFromTokens(ATokens: PByteArray);
var
  AToken: Byte;
  S: string;
begin
  AOperation[ptgUnion - 3] := ListSeparatorEx;
  AToken := ATokens^[0] - ptgAdd;
  if AToken = (ptgPercent - ptgAdd) then
    S := FStringList[FStringList.Count - 1] + AOperation[AToken]
  else
    if AToken >= (ptgUPlus - ptgAdd) then
    begin
      if FStringList.Count >= 1 then
        S := AOperation[AToken] + FStringList[FStringList.Count - 1]
      else
        S := cxGetResourceString(@scxCaclulatorMissingTokens);
    end
    else
    begin
      if FStringList.Count >= 2 then
      begin
        S := FStringList[FStringList.Count - 2] + AOperation[AToken] +
          FStringList[FStringList.Count - 1];
        FStringList.Delete(FStringList.Count - 1);
      end
      else
        S := cxGetResourceString(@scxCaclulatorMissingTokens);
    end;
  if AToken <> (ptgUPlus - ptgAdd) then
    FStringList[FStringList.Count - 1] := S;
end;

procedure TcxSSFunctionHandler.SetReferenceFromTokens(ATokens: PByteArray);
var
  AReference: string;
  AToken: Byte;
begin
  AToken := ATokens^[0];
  Inc(Integer(ATokens));
  case AToken of
    ptgName:
      AReference := ptgRefToStr(PWord(ATokens)^);
    ptgRef:
      AReference := ptgRefToStr(Boolean(ATokens^[1]), PBoolean(ATokens)^,
        PInteger(@ATokens^[6])^, PInteger(@ATokens^[2])^);
    ptgArea:
      AReference := ptgRefToStr(PBoolArray(ATokens), PIntArray(@ATokens^[4]));
    ptgArea3D:
      AReference := ptgRefToStr(PWord(ATokens)^, PBoolArray(@ATokens^[2]),
        PIntArray(@ATokens^[6]));
    ptgRef3D:
      AReference := ptgRefToStr(PWord(ATokens)^, Boolean(ATokens^[3]),
        Boolean(ATokens^[2]), PInteger(@ATokens^[8])^, PInteger(@ATokens^[4])^);
  end;
  FStringList.Add(AReference);
end;

procedure TcxSSFunctionHandler.SetStringFromTokens(ATokens: PByteArray);
var
  S: string;
  I: Integer;
begin
  S := FStack.StackTokensToStr(ATokens);
  I := 2;
  while I < Length(S) do
  begin
    if S[I] = '"' then
    begin
      Insert('"', S, I);
      Inc(I, 1);
    end;
    Inc(I);
  end;
  S := StringReplace(S, '"', '""', [rfReplaceAll]);
  FStringList.Add('"' + S + '"');
end;

procedure TcxSSFunctionHandler.SetStringValue(const Value: string);
begin
  FStringValue := Value;
  FIsValueAssigned := True;
end;

function TcxSSFunctionHandler.StackAreaToExcelTokens(ATokens: PByteArray): TcxStackItem;
var
  AToken: Byte;
  ACol1, ARow1, ACol2, ARow2: Integer;

  procedure CheckRef(var AColOfs, ARowOfs: Integer; AColAbs, ARowAbs: Boolean);
  begin
    if not ARowAbs then
      Inc(ARowOfs, FRow);
    if not AColAbs then
      Inc(AColOfs, FCol);
    if not AColAbs then
      AColOfs := AColOfs or $4000;
    if not ARowAbs then
      AColOfs := AColOfs or $8000;
  end;

begin
  AToken := ATokens^[0];
  Inc(Integer(ATokens));
  Result := FStack.StackGetByteItem(AToken);
  if AToken in [ptgArea3D, ptgRef3D] then
  begin
    Result := FStack.StackUnion(Result, FStack.StackGetWordItem(PWord(ATokens)^{ + 1}));
    Inc(Integer(ATokens), 2);
    SetAbsolutePosition;
  end;
  case AToken of
    ptgRef, ptgRef3D:
      begin
        ACol1 := PInteger(@ATokens^[6])^;
        ARow1 := PInteger(@ATokens^[2])^;
        CheckRef(ACol1, ARow1, Boolean(ATokens^[1]), Boolean(ATokens^[0]));
        Result := FStack.StackUnions([Result, FStack.StackGetWordItem(ARow1 and $FFFF),
          FStack.StackGetWordItem(ACol1 and $FFFF)]);
        Result.Tokens^[0] := Result.Tokens^[0] + $20;
      end;
    ptgArea, ptgArea3D:
      begin
        ARow1 := PInteger(@ATokens^[4])^;
        ARow2 := PInteger(@ATokens^[8])^;
        ACol1 := PInteger(@ATokens^[12])^;
        ACol2 := PInteger(@ATokens^[16])^;
        CheckRef(ACol1, ARow1, Boolean(ATokens^[2]), Boolean(ATokens^[0]));
        CheckRef(ACol2, ARow2, Boolean(ATokens^[3]), Boolean(ATokens^[1]));
        Result := FStack.StackUnions([Result,
          FStack.StackGetWordItem(ARow1 and $FFFF), FStack.StackGetWordItem(ARow2 and $FFFF),
            FStack.StackGetWordItem(ACol1 and $FFFF), FStack.StackGetWordItem(ACol2 and $FFFF)]);
      end;
  end;
  RestorePosition;
end;

procedure TcxSSFunctionHandler.StackTokensToArea(ATokens: PByteArray;
  var APage: Word; var ARange: TRange);
var
  AToken: Byte;
begin
  FillChar(ARange, 0, 0);
  AToken := ATokens^[0];
  APage := FPage;
  Inc(Integer(ATokens));
  if  AToken in [ptgName, ptgArea3D, ptgRef3D] then
  begin
    APage := PWord(@ATokens^[0])^;
    Inc(Integer(ATokens), 2);
  end;
  case AToken of
    ptgRef, ptgRef3D:
    begin
      CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[6])^, PInteger(@ATokens^[2])^,
        Boolean(ATokens^[1]), Boolean(ATokens^[0]), ARange.Left, ARange.Top);
      ARange.BottomRight := ARange.TopLeft;
    end;
    ptgArea, ptgArea3D:
    begin
      CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[12])^, PInteger(@ATokens^[4])^,
        Boolean(ATokens^[2]), Boolean(ATokens^[0]), ARange.Left, ARange.Top);
      CheckColumnAndRow(FCol, FRow, PInteger(@ATokens^[16])^, PInteger(@ATokens^[8])^,
        Boolean(ATokens^[3]), Boolean(ATokens^[1]), ARange.Right, ARange.Bottom);
    end;
    ptgName:
      with Owner.GetNames[APage].Definition do
      begin
        APage := Page;
        ARange := Area;
      end;
  else
    ShowMessage(cxGetResourceString(@scxCaclulatorUnknownToken));
  end;
end;

{*****************************************************************}
{$IFNDEF DELPHI6}
function IsZero(const Value: Double): Boolean;
begin
  Result := Abs(Value) <= ((1E-19) * 1000);
end;
{$ENDIF}

procedure xlfnABS(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Abs(Sender.GetFloatParameter));
end;

procedure xlfnACOS(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcCos(Sender.GetFloatParameter));
end;

procedure xlfnACOSH(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcCosH(Sender.GetFloatParameter));
end;

procedure xlfnAND(Sender: TcxSSFunctionHandler);

  procedure fnAnd(Sender: TcxSSFunctionHandler; const Value: string);
  var
    B: Boolean;
    F: Double;
  begin
    if not Sender.IsValueAssigned then
      Sender.FloatValue := 1;

    if Sender.FloatValue > 0 then
    begin
      if cxTryStrToFloat(Value, F) then
      begin
        if F = 0 then 
          Sender.FloatValue := 0;
      end
      else
        if not cxTryStrToBool(Value, B) or not B then
          Sender.FloatValue := 0;
    end;
  end;

begin
  with Sender do
  begin
    Sender.FloatValue := 1;
    EnumParamValues(@fnAnd, [vtString]);
    SetBooleanResult(Sender.FloatValue > 0);
  end;
end;

procedure xlfnASIN(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcSin(Sender.GetFloatParameter));
end;

procedure xlfnASINH(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcSinH(Sender.GetFloatParameter));
end;

procedure xlfnATAN(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcTan(Sender.GetFloatParameter));
end;

procedure xlfnATAN2(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcTan2(Sender.GetFloatParameter,
    Sender.GetFloatParameter));
end;

procedure xlfnATANH(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(ArcTanH(Sender.GetFloatParameter));
end;

procedure xlfnCOS(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Cos(Sender.GetFloatParameter));
end;

procedure xlfnCOSH(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(CosH(Sender.GetFloatParameter));
end;

procedure xlfnCOUNT(Sender: TcxSSFunctionHandler);

  procedure fnCount(Sender: TcxSSFunctionHandler; const Value: string);
  begin
    if cxTryStrToFloat(Value) then 
      Sender.FloatValue := Sender.FloatValue + 1;
  end;

begin
  with Sender do
  begin
    EnumParamValues(@fnCount, [vtString]);
    SetFloatResult(Sender.FloatValue);
  end;
end;

procedure xlfnCOUNTA(Sender: TcxSSFunctionHandler);

  procedure fnCountA(Sender: TcxSSFunctionHandler; const Value: string);
  begin
    if Value <> '' then
      Sender.FloatValue := Sender.FloatValue + 1;
  end;

begin
  with Sender do
  begin
    EnumParamValues(@fnCountA, [vtString]);
    SetFloatResult(Sender.FloatValue);
  end;
end;

procedure xlfnCOUNTBLANK(Sender: TcxSSFunctionHandler);

  procedure fnCountBlank(Sender: TcxSSFunctionHandler; const Value: string);
  begin
   if Value = '' then
      Sender.FloatValue := Sender.FloatValue + 1;
  end;

begin
  with Sender do
  begin
    EnumParamValues(@fnCountBlank, [vtString]);
    SetFloatResult(Sender.FloatValue);
  end;
end;

var
  Criteria: string;

procedure xlfnCOUNTIF(Sender: TcxSSFunctionHandler);

  procedure fnCountIF(Sender: TcxSSFunctionHandler; const Value: string);

    function IfCompare(const Value: string): Boolean;
    begin
      if (Length(Criteria) > 0) and dxCharInSet(Criteria[1], ['>', '<']) then
      begin
        if Criteria[1] = '>' then
        begin
          if (Length(Criteria) > 1) and (Criteria[2] = '=') then
            Result := AnsiCompareText(Value, Copy(Criteria, 3, Length(Criteria) - 2)) >= 0
          else
            Result := AnsiCompareText(Value, Copy(Criteria, 2, Length(Criteria) - 1)) > 0;
        end
        else
        begin
          if (Length(Criteria) > 1) and (Criteria[2] = '=') then
            Result := AnsiCompareText(Value, Copy(Criteria, 3, Length(Criteria) - 2)) <= 0
          else
            Result := AnsiCompareText(Value, Copy(Criteria, 2, Length(Criteria) - 1)) < 0;
        end;
      end
      else
        Result := AnsiCompareText(Value, Criteria) = 0;
    end;

  begin
    with Sender do
    begin
      if IfCompare(Value) then
        FloatValue := FloatValue + 1;
    end;
  end;

begin
  with Sender do
  begin
    Criteria := GetStringParameter;
    FParamsCount := FParamsCount - 1;
    EnumParamValues(@fnCountIf, [vtString]);
    SetFloatResult(FloatValue);
    StringValue := '';
  end;
end;

procedure xlfnDATE(Sender: TcxSSFunctionHandler);
var
  Year, Month, Day, ADay, AMonth: Word;
  ADate: TDateTime;
const
  cxDateDelta = DateDelta + 366; // TODO: Excel DateTime bug
begin
  Day := 0;
  Month := 0;
  Year := 0;
  with Sender do
  try
    Day := Word(Round(GetFloatParameter()));
    Month := Word(Round(GetFloatParameter()));
    Year := Word(Round(GetFloatParameter()));
  finally
    ADay := 1;
    AMonth := 1;
    IncAMonth(Year, AMonth, ADay, Month - 1);
    ADate := EncodeDate(Year, AMonth, ADay) + (Day - 1);
    SetFloatResult(ADate);
  end;
end;

procedure xlfnDAY(Sender: TcxSSFunctionHandler);
var
  I, Day: Word;
  ADate: Double;
begin
  with Sender do
  begin
    if CheckCondition(cxTryStrToFloat(GetStringParameter, ADate), ecValue) then
    begin
      DecodeDate(ADate, I, I, Day); 
      SetFloatResult(Day);
    end;
  end;
end;

procedure xlfnDOLLAR(Sender: TcxSSFunctionHandler);
var
  Value: Double;
  Digits: Word;
  S: string;
begin
  Value := 0;
  Digits := dxFormatSettings.CurrencyDecimals;
  S := '';
  with Sender do
  try
    dxFormatSettings.CurrencyDecimals := Round(GetFloatParameter);
    Value := GetFloatParameter;
  finally
    SetStringResult(Format('%m', [Value]));
    dxFormatSettings.CurrencyDecimals := Digits;
  end;
end;

procedure xlfnEXP(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Exp(Sender.GetFloatParameter));
end;

procedure xlfnFACT(Sender: TcxSSFunctionHandler);

  function Factorial(Value: Double): Double;
  begin
    Result := 1;
    while Value > 0 do
    begin
     Result := Result * Value;
     Value := Value - 1;
    end;
  end;

begin
  with Sender do
    SetFloatResult(Factorial(Floor(GetFloatParameter)));
end;

procedure xlfnINT(Sender: TcxSSFunctionHandler);
begin
  with Sender do
    SetFloatResult(Floor(GetFloatParameter));
end;

procedure xlfnIF(Sender: TcxSSFunctionHandler);

  function IsError(Value: Boolean; const S: string): Boolean;
  begin
    Result := Value and ((scxNullError = S) or (scxDivZeroError = S) or
      (scxValueError = S) or (scxNameError = S) or (scxNumError = S) or
      (scxRefError = S) or (scxNAError = S));
  end;

  procedure SetResult(AType: Byte; const AResult: string);
  var
    V: Boolean;
    AVal: Double;
  begin
    case AType of
      ptgBool:
      begin
         if cxTryStrToBool(AResult, V) then
           Sender.SetBooleanResult(V)
         else
           Sender.SetBooleanResult(False)
      end;
      ptgNum:
      begin
        cxTryStrToFloat(AResult, AVal);
        Sender.SetFloatResult(AVal);
      end
      else
        Sender.SetStringResult(AResult);
    end;
  end;

var
  ACondition: Boolean;
  AValue: Double;
  AFirstType, ASecondType: Byte;
  AFirstParam, ASecondParam: string;
begin
  ACondition := False;
  AFirstParam := '';
  with Sender do
  try
    ASecondParam := GetStringParameter(ASecondType);
    AFirstParam := GetStringParameter(AFirstType);
    ACondition := GetBooleanParameter;
  finally
    if ACondition then
    begin
      if cxTryStrToFloat(AFirstParam, AValue) then
        SetFloatResult(AValue)
      else
        SetResult(AFirstType, AFirstParam)
    end
    else
    begin
      if cxTryStrToFloat(ASecondParam, AValue) then
        SetFloatResult(AValue)
      else
        SetResult(ASecondType, ASecondParam);
    end;
    if Error and not IsError(ACondition, AFirstParam) or
      not IsError(not ACondition, AFirstParam) then FErrorCode := ecNone
  end;
end;

procedure xlfnLN(Sender: TcxSSFunctionHandler);
var
  AValue: Double;
begin
  AValue := Sender.GetFloatParameter;
  if AValue = 0 then
  begin
    Sender.SetStringResult(scxDivZeroError);
    Exit;
  end
  else
    Sender.SetFloatResult(Ln(AValue));
end;

procedure xlfnLOG(Sender: TcxSSFunctionHandler);
var
  Number, Base: Double;
begin
  with Sender do
  begin
    if FParamsCount > 1 then
      Base := GetFloatParameter
    else
      Base := 10;
    Number := GetFloatParameter;
    if CheckCondition((Base > 0) and (Number > 0), ecNum) then
    begin
      Base := LogN(Base, Number);
      SetFloatResult(Base);
    end;
  end;
end;

procedure xlfnLOG10(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Log10(Sender.GetFloatParameter));
end;

procedure xlfnMAX(Sender: TcxSSFunctionHandler);

  procedure fnMax(Sender: TcxSSFunctionHandler; const Value: Double);
  begin
    with Sender do
    begin
      if not IsValueAssigned or (Value > FloatValue) then
        FloatValue := Value;
    end;
  end;

begin
  with Sender do
  try
    EnumParamValues(@fnMax, [vtFloat]);
  finally
    SetFloatResult(FloatValue);
  end;
end;

procedure xlfnMIN(Sender: TcxSSFunctionHandler);

  procedure fnMin(Sender: TcxSSFunctionHandler; const Value: Double);
  begin
    with Sender do
    begin
      if not IsValueAssigned or (Value < FloatValue) then
        FloatValue := Value;
    end;
  end;

begin
  with Sender do
  try
    EnumParamValues(@fnMin, [vtFloat]);
  finally
    SetFloatResult(FloatValue);
  end;
end;

procedure xlfnMOD(Sender: TcxSSFunctionHandler);
var
  Val1, Val2: Double;
begin
  Val1 := 1;
  with Sender do
  try
    Val2 := GetFloatParameter;
    Val1 := GetFloatParameter;
    if Sender.CheckCondition(Val2 <> 0, ecDivZero) then
    begin
      while Val1 >= Val2 do
        Val1 := Val1 - Val2;
      Val1 := Floor(Val1);
    end;
  finally
    SetFloatResult(Val1);
  end;
end;

procedure xlfnMONTH(Sender: TcxSSFunctionHandler);
var
  ADate: TDateTime;
  Year, Month, Day: Word;
begin
  Month := 0;
  with Sender do
  try
    ADate := GetFloatParameter;
    if (ADate < MinDateTime) or (ADate > MaxDateTime) then
      Sender.SetError(ecNum)
    else
      DecodeDate(ADate, Year, Month, Day);
  finally
    SetFloatResult(Month);
  end;
end;

procedure xlfnNOT(Sender: TcxSSFunctionHandler);
begin
  Sender.SetBooleanResult(not Sender.GetBooleanParameter);
end;

procedure xlfnNOW(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Now);
end;

procedure xlfnODD(Sender: TcxSSFunctionHandler);
var
  Value: Double;
begin
  Value := 0;
  with Sender do
  try
    Value := GetFloatParameter;
    if (Abs(Value) - Abs(Trunc(Value))) <> 0 then
    begin
      Value := Value + ValueIncr[Value >= 0];
      Value := Trunc(Value);
    end;
    if not Odd(Trunc(Value)) then
      Value := Value + ValueIncr[Value >= 0];
  finally
    SetFloatResult(Value);
  end;
end;

procedure xlfnOR(Sender: TcxSSFunctionHandler);

  procedure fnOr(Sender: TcxSSFunctionHandler; const Value: string);
  var
    B: Boolean;
    F: Double;
  begin
    if cxTryStrToFloat(Value, F) and (F <> 0) then
      Sender.FloatValue := 1
    else
      if cxTryStrToBool(Value, B) and B then
        Sender.FloatValue := 1
  end;

begin
  with Sender do
  begin
    Sender.FloatValue := 0;
    EnumParamValues(@fnOr, [vtString]);
    SetBooleanResult(Sender.FloatValue > 0);
  end;
end;

procedure xlfnPI(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Pi);
end;

procedure xlfnPOWER(Sender: TcxSSFunctionHandler);
var
  Exponent, Base: Double;
begin
  Base := 0;
  Exponent := 0;
  try
    Exponent := Sender.GetFloatParameter;
    Base := Sender.GetFloatParameter;
  finally
    Sender.SetFloatResult(Power(Base, Exponent));
  end;
end;

procedure xlfnRADIANS(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(DegToRad(Sender.GetFloatParameter));
end;

procedure xlfnRAND(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Random);
end;

procedure xlfnROUND(Sender: TcxSSFunctionHandler);

const
  LimitFracValue: Extended = 0.5;

  function xlRound(const AValue: Double; ADigits: Integer): Double;
  var
    APrecision: Double;
    ATempValue: Extended;
    AMode: TFPUPrecisionMode;
  begin
    try
      APrecision := IntPower(10, ADigits);
    except
      on EOverflow do
        APrecision := 100;
    end;
    AMode := Math.SetPrecisionMode(pmExtended);
    ATempValue := Int(AValue * APrecision);
    if CompareValue(Abs(AValue * APrecision), Abs(ATempValue + Sign(AValue) * LimitFracValue)) <> -1 then
      ATempValue := ATempValue + Sign(AValue);
    Result := ATempValue / APrecision;
    Math.SetPrecisionMode(AMode);
  end;

var
  AValue: Double;
  ADigits: Integer;
begin
  AValue := 0;
  with Sender do
  try
    ADigits := Round(GetFloatParameter);
    AValue := GetFloatParameter;
    AValue := xlRound(AValue, ADigits);
  finally
    Sender.SetFloatResult(AValue);
  end;
end;

procedure xlfnROUNDDOWN(Sender: TcxSSFunctionHandler);
var
  AValue: Double;
  ADigits: Integer;
  I: Integer;
begin
  AValue := 0;
  with Sender do
  try
    ADigits := Round(GetFloatParameter);
    AValue := GetFloatParameter;
    for I := 0 to ADigits - 1 do
      AValue := AValue * 10;
    AValue := Floor(AValue);
    for I := 0 to ADigits - 1 do
      AValue := AValue/10;
  finally
    Sender.SetFloatResult(AValue);
  end;
end;

procedure xlfnROUNDUP(Sender: TcxSSFunctionHandler);
var
  AValue: Double;
  ADigits: Integer;
  I: Integer;
begin
  AValue := 0;
  with Sender do
  try
    ADigits := Round(GetFloatParameter);
    AValue := GetFloatParameter;
    for I := 0 to ADigits - 1 do
      AValue := AValue * 10;
    AValue := Ceil(AValue);
    for I := 0 to ADigits - 1 do
      AValue := AValue/10;
  finally
    Sender.SetFloatResult(AValue);
  end;
end;

procedure xlfnSIGN(Sender: TcxSSFunctionHandler);
var
  AResult, AValue: Double;
begin
  AResult := 0;
  with Sender do
  try
    AValue := GetFloatParameter;
    if AValue > 0 then
      AResult := 1
    else
      if AValue < 0 then
        AResult := -1
      else
        AResult := 0;
  finally
    SetFloatResult(AResult);
  end;
end;

procedure xlfnSIN(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Sin(Sender.GetFloatParameter));
end;

procedure xlfnSINH(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(SinH(Sender.GetFloatParameter));
end;

procedure xlfnSQRT(Sender: TcxSSFunctionHandler);
var
  AParam: Double;
begin
  AParam := Sender.GetFloatParameter;
  if AParam < 0 then
    Sender.SetError(ecNum)
  else
    Sender.SetFloatResult(SQRT(AParam));
end;

procedure xlfnSUM(Sender: TcxSSFunctionHandler);

  procedure fnSum(Sender: TcxSSFunctionHandler; const Value: Double);
  begin
    with Sender do
      FloatValue := FloatValue + Value;
  end;

begin
  with Sender do
  try
    EnumParamValues(@fnSum, [vtFloat]);
  finally
    SetFloatResult(FloatValue);
  end;
end;

procedure xlfnSUMSQ(Sender: TcxSSFunctionHandler);

  procedure fnSumSQ(Sender: TcxSSFunctionHandler; const Value: Double);
  begin
    with Sender do
      FloatValue := FloatValue + Value * Value;
  end;

begin
  with Sender do
  try
    EnumParamValues(@fnSumSQ, [vtFloat]);
  finally
    SetFloatResult(FloatValue);
  end;
end;

procedure xlfnTAN(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Tan(Sender.GetFloatParameter));
end;

procedure xlfnTANH(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(TanH(Sender.GetFloatParameter));
end;

procedure xlfnTIME(Sender: TcxSSFunctionHandler);
var
  ATime: TDateTime;
const
  H: Word = 0;
  M: Word = 0;
  S: Word = 0;
begin
  with Sender do
  try
    S := Round(GetFloatParameter);
    M := Round(GetFloatParameter);
    H := Round(GetFloatParameter);
  finally
    if CheckCondition(TryEncodeTime(H, M, S, 0, ATime), ecValue) then
      SetFloatResult(ATime);
  end;
end;

procedure xlfnTODAY(Sender: TcxSSFunctionHandler);
begin
  Sender.SetFloatResult(Date);
end;

procedure xlfnTRUNC(Sender: TcxSSFunctionHandler);
var
  AValue: Double;
  ADigits: Integer;
  I: Integer;
begin
  AValue := 0;
  with Sender do
  try
    if FParamsCount > 1 then
      ADigits := Round(GetFloatParameter)
    else
      ADigits := 0;
    AValue := GetFloatParameter;
    for I := 0 to ADigits - 1 do
      AValue := AValue * 10;
    AValue := Trunc(AValue);
    for I := 0 to ADigits - 1 do
      AValue := AValue/10;
  finally
    SetFloatResult(AValue);
  end;
end;

procedure xlfnYEAR(Sender: TcxSSFunctionHandler);
var
  ATime: Double;
  AYear, AValue: Word;
begin
  ATime := Sender.GetFloatParameter;
  DecodeDate(ATime, AYear, AValue, AValue);
  Sender.SetFloatResult(AYear);
end;

procedure xlfnWeekDay(Sender: TcxSSFunctionHandler);
var
  AType: Byte;
  ADay: Byte;
begin
  ADay := 0;
  with Sender do
  try
    AType := 1;
    if FParamsCount > 1 then
      AType := Round(GetFloatParameter) and $FF;
    if not (AType in [1, 2, 3]) then
      AType := 1;
    ADay := DayOfWeek(Sender.GetFloatParameter);
    if AType > 1 then
    begin
      Dec(ADay);
      if ADay = 0 then
        ADay := 7;
    end;
    if AType = 3 then Dec(ADay);
  finally
    SetFloatResult(ADay);
  end;
end;

procedure xlfnFALSE(Sender: TcxSSFunctionHandler);
begin
  Sender.SetBooleanResult(False);
end;

procedure xlfnTRUE(Sender: TcxSSFunctionHandler);
begin
  Sender.SetBooleanResult(True);
end;

procedure CopyStackParamsEntry(Sender: TcxSSFunctionHandler);
var
  I, C: Integer;
  AItem: TcxStackItem;
begin
  with Sender do
  begin
    C := Length(Stack.FStackItems) - 1;
    for I := 0 to FParamsCount - 1 do
    with Stack.FStackItems[C - I] do
    begin
      AItem := FStack.StackItemAlloc(Size);
      Move(Tokens^, AItem.Tokens^, Size);
      FStack.StackAdd(AItem);
    end;
  end;
end;

procedure xlfnAVERAGE(Sender: TcxSSFunctionHandler);
var
  ACount, ASum: Double;
begin
  CopyStackParamsEntry(Sender);
  with Sender do
  begin
    xlfnCount(Sender);
    ACount := GetFloatParameter;
    xlfnSum(Sender);
    ASum := GetFloatParameter;
    if CheckCondition(ACount > 0, ecDivZero) then
      FloatValue := ASum/ACount
    else
      FloatValue := 0;
    SetFloatResult(FloatValue);
  end;
end;

procedure xlfnAVERAGEA(Sender: TcxSSFunctionHandler);
var
  ACountA, ASum: Double;
begin
  CopyStackParamsEntry(Sender);
  with Sender do
  begin
    xlfnCountA(Sender);
    ACountA := GetFloatParameter;
    xlfnSum(Sender);
    ASum := FloatValue;
    if CheckCondition(ACountA > 0, ecDivZero) then
      FloatValue := ASum/ACountA
    else
      FloatValue := 0;
    SetFloatResult(FloatValue);
  end;
end;

procedure xlfnEven(Sender: TcxSSFunctionHandler);
var
  Value: Double;
begin
  Value := 0;
  with Sender do
  try
    Value := GetFloatParameter;
    if (Abs(Value) - Abs(Trunc(Value))) <> 0 then
    begin
      Value := Value + ValueIncr[Value >= 0];
      Value := Trunc(Value);
    end;
    if Odd(Trunc(Value)) then
      Value := Value + ValueIncr[Value >= 0];
  finally
    SetFloatResult(Value);
  end;
end;

procedure xlfnTrim(Sender: TcxSSFunctionHandler);
var
  S: string;
  APos: Integer; 
begin
  S := '';
  with Sender do
  try
    S := Trim(GetStringParameter);
    repeat
      APos := Pos('  ', S);
      if APos > 0 then
        Delete(S, APos, 1);
    until APos = 0; 
  finally
    SetStringResult(S);
  end;
end;

function GetValues(Sender: TcxSSFunctionHandler;
  var Base, Divider: Double; var Digits: Integer): Boolean;
begin
  Result := False;
  with Sender do
  begin
    if CheckCondition(FParamsCount >= 2, ecName) then
    begin
      Divider := GetFloatParameter;
      Base := GetFloatParameter;
      if CheckCondition(not IsZero(Divider), ecDivZero) and
        CheckCondition(((Divider >=0) and (Base > 0)) or
         ((Divider <= 0) and (Base < 0)), ecNum) then
      begin
        Digits := 0;
        while not IsZero(Frac(Divider * Power(10, Digits))) do Inc(Digits);
        Divider := Abs(Divider * Power(10, Digits));
        Base := Base * Power(10, Digits);
        Result := True;
      end;
    end
  end;
end;

procedure xlfnCeiling(Sender: TcxSSFunctionHandler);
var
  Digits: Integer;
  Base, Divider: Double;
begin
  if GetValues(Sender, Base, Divider, Digits) then
  try
    Base := Base / Divider;
    if not IsZero(Frac(Base)) then
      Base := Trunc(Base) + ValueIncr[Base > 0];
    Base := Base * Divider / Power(10, Digits);
  finally
    Sender.SetFloatResult(Base);
  end;
end;

procedure xlfnFloor(Sender: TcxSSFunctionHandler);
var
  Digits: Integer;
  Base, Divider: Double;
begin
  if GetValues(Sender, Base, Divider, Digits) then
  try
    Base := Base / Divider;
    if not IsZero(Frac(Base)) then
      Base := Trunc(Base);
    Base := Base * Divider / Power(10, Digits);
  finally
    Sender.SetFloatResult(Base);
  end;
end;

procedure xlfnConcatenate(Sender: TcxSSFunctionHandler);

  procedure fnConcate(Sender: TcxSSFunctionHandler; const Value: string);
  begin
    with Sender do
      StringValue := Value + StringValue;
  end;

begin
  with Sender do
  try
    EnumParamValues(@fnConcate, [vtString]);
  finally
    SetStringResult(StringValue);
  end;
end;

procedure xlfnDegrees(Sender: TcxSSFunctionHandler);
begin
  with Sender do
    SetFloatResult(RadToDeg(GetFloatParameter));
end;

procedure xlfnFixed(Sender: TcxSSFunctionHandler);
var
  HasDelimiter: Boolean;
  V: Double;
  CountZero: Integer;
begin
  V := 0; 
  HasDelimiter := True;
  with Sender do
  try
    if FParamsCount > 2 then
      HasDelimiter := not GetBooleanParameter;
    CountZero := Round(GetFloatParameter);
    V := GetFloatParameter;
    if CountZero >= 0 then
    begin
      CountZero := Abs(CountZero);
      V := Round(V * Power(10, CountZero));
      V := V / Power(10, CountZero);
    end;
  finally
    if HasDelimiter then
    begin
      SetFloatResult(V);
    end
    else
      SetFloatResult(V);
  end;
end;

function TryDecodeTime(Sender: TcxSSFunctionHandler; NeedItem: Byte): Boolean;
var
  TimeItems: array[0..3] of Word;
  S: string;
  ATime: Double;
begin
  with Sender do
  begin
    S := GetStringParameter;
    ATime := 0;
    Result := (Trim(S) = '') or cxTryStrToFloat(S, ATime);
    if Result then
    begin
      DecodeTime(ATime, TimeItems[0], TimeItems[1], TimeItems[2], TimeItems[3]);
      SetFloatResult(TimeItems[NeedItem]);
    end
    else
      SetError(ecValue);
  end;
end;

procedure xlfnHour(Sender: TcxSSFunctionHandler);
begin
  TryDecodeTime(Sender, 0);
end;

procedure xlfnMinute(Sender: TcxSSFunctionHandler);
begin
  TryDecodeTime(Sender, 1);
end;

procedure xlfnSecond(Sender: TcxSSFunctionHandler);
begin
  TryDecodeTime(Sender, 2);
end;

procedure xlfnIsBlank(Sender: TcxSSFunctionHandler);

  procedure fnBlank(Sender: TcxSSFunctionHandler; const Value: string);
  begin
    if (Value <> '') then
      Sender.StringValue := Value;
    Sender.FloatValue := Sender.FloatValue - 1;
  end;

begin
  with Sender do
  try
    EnumParamValues(@fnBlank, [vtString]);
  finally
    SetBooleanResult((FloatValue = -1) and (StringValue = ''));
  end;
end;

procedure xlfnIsNa(Sender: TcxSSFunctionHandler);
begin
  with Sender do
  begin
    SetBooleanResult(Trim(GetStringParameter) = scxNullError);
    FErrorCode := ecNone;
  end;
end;

procedure xlfnIsLogical(Sender: TcxSSFunctionHandler);
begin
  with Sender do
  begin
    SetBooleanResult(cxTryStrToBool(Sender.GetStringParameter));
    FErrorCode := ecNone;
  end;
end;

procedure xlfnIsErr(Sender: TcxSSFunctionHandler);
var
  S: string;
begin
  S := '';
  with Sender do
  try
    S := GetStringParameter;
  finally
    SetBooleanResult(Error or (S = scxValueError));
    FErrorCode := ecNone;
  end;
end;

procedure xlfnIsError(Sender: TcxSSFunctionHandler);
begin
  xlfnIsErr(Sender);
end;

procedure xlfnIsNonText(Sender: TcxSSFunctionHandler);
var
  S: string;
begin
  S := '';
  with Sender do
  try
    S := Trim(GetStringParameter);
  finally
    SetBooleanResult((S = '') or cxTryStrToFloat(S) or cxTryStrToBool(S));
  end;
end;

procedure xlfnIsNumber(Sender: TcxSSFunctionHandler);
begin
  with Sender do
  begin
    SetBooleanResult(cxTryStrToFloat(GetStringParameter));
    FErrorCode := ecNone;
  end;
end;

procedure xlfnIsText(Sender: TcxSSFunctionHandler);
var
  S: string;
begin
  S := '';
  with Sender do
  try
    S := Trim(GetStringParameter);
  finally
    SetBooleanResult((S <> '') and not (cxTryStrToFloat(S) or cxTryStrToBool(S)));
    FErrorCode := ecNone;
  end;
end;

procedure xlfnLen(Sender: TcxSSFunctionHandler);
begin
  with Sender do
    SetFloatResult(Length(GetStringParameter));
end;

procedure xlfnLeft(Sender: TcxSSFunctionHandler);
var
  S: string;
  Len: Integer;
begin
  with Sender do
  try
    if FParamsCount > 1 then
    begin
      Len := Round(GetFloatParameter);
      S := GetStringParameter;
      if CheckCondition(Len >= 0, ecValue) then
      begin
        if S <> '' then
          S := Copy(S, 1, Min(Length(S), Len));
      end
      else
        Exit;
    end
    else
    begin
      S := GetStringParameter;
      if Length(S) > 0 then
        S := S[1];
    end;
  finally
    SetStringResult(S);
  end;
end;

procedure xlfnRight(Sender: TcxSSFunctionHandler);
var
  S, Value: string;
  Len: Integer;
  I: Integer;
begin
  with Sender do
  try
    Value := '';
    if FParamsCount > 1 then
    begin
      Len := Round(GetFloatParameter);
      S := GetStringParameter;
      if CheckCondition(Len >= 0, ecValue) then
      begin
        for I := Max(Length(S) - Len + 1, 1) to Length(S) do
          Value := Value + S[I]
      end
      else
        Exit;
    end
    else
    begin
      Value := GetStringParameter;
      if Length(Value) > 0 then
        Value := Value[Length(Value)];
    end;
  finally
    SetStringResult(Value);
  end;
end;

procedure xlfnMid(Sender: TcxSSFunctionHandler);
var
  SPos, Len: Integer;
  S: string;
begin
  with Sender do
  begin
    if CheckCondition(FParamsCount = 3, ecValue) then
    begin
      Len := Trunc(GetFloatParameter);
      SPos := Trunc(GetFloatParameter);
      S := GetStringParameter;
      if CheckCondition((SPos > 0) and (Len > 0) and (SPos <= Length(S)), ecValue) then
        SetStringResult(Copy(S, SPos, Len))
    end;
  end;
end;

procedure xlfnPMT(Sender: TcxSSFunctionHandler);
var
  ATime: TPaymentTime;
  APeriodsCount: Integer;
  ARate, APresentValue, AFutureValue: Double;
begin
  ATime := ptEndOfPeriod;
  AFutureValue := 0;
  with Sender do
  begin
    if (ParamsCount > 4) and (Round(GetFloatParameter) > 0) then
      ATime := ptStartOfPeriod;
    if ParamsCount >= 4 then
      AFutureValue := GetFloatParameter;
    APresentValue := GetFloatParameter;
    APeriodsCount := Round(GetFloatParameter);
    ARate := GetFloatParameter;
    Sender.SetFloatResult(Payment(ARate, APeriodsCount, APresentValue, AFutureValue, ATime));
  end;
end;

procedure xlfnLower(Sender: TcxSSFunctionHandler);
begin
  with Sender do
    SetStringResult(AnsiLowerCase(GetStringParameter));
end;

procedure xlfnUpper(Sender: TcxSSFunctionHandler);
begin
  with Sender do
    SetStringResult(AnsiUpperCase(GetStringParameter));
end;

const
   XLSDefaultFunctions: array[0..80] of TcxSSFunction =
   (xlfnABS, xlfnAcos, xlfnAcosh, xlfnAnd, xlfnAsin, xlfnAsinh, xlfnAtan, xlfnAtan2,
    xlfnAtanh, xlfnAverage, xlfnAverageA, xlfnCos, xlfnCosh, xlfnCount, xlfnCounta,
    xlfnCountblank, xlfnCountif, xlfnDate, xlfnDay, xlfnDollar, xlfnExp, xlfnFact,
    xlfnInt, xlfnIF, xlfnLn, xlfnLog, xlfnLog10, xlfnMax, xlfnMin, xlfnMod, xlfnMonth,
    xlfnNot, xlfnNow, xlfnOdd, xlfnOr, xlfnPi, xlfnPower, xlfnRadians, xlfnRand,
    xlfnRound, xlfnRounddown, xlfnRoundup, xlfnSign, xlfnSin, xlfnSinh, xlfnSqrt,
    xlfnSum, xlfnSumsq, xlfnTan, xlfnTanh, xlfnTime, xlfnToday, xlfnTrunc, xlfnYear,
    xlfnWeekDay, xlfnFalse, xlfnTrue, xlfnTrim, xlfnEven, xlfnCeiling, xlfnFloor,
    xlfnConcatenate, xlfnDegrees, xlfnFixed, xlfnHour, xlfnMinute, xlfnSecond,
    xlfnIsLogical, xlfnIsErr, xlfnIsError, xlfnIsNonText, xlfnIsBlank, xlfnIsNa,
    xlfnIsNumber, xlfnIsText, xlfnLen, xlfnLeft, xlfnRight, xlfnMid, xlfnLower,
    xlfnUpper);

var
  I: Integer;

initialization
  for I := 0 to High(XLSDefaultFunctions) do
    DefaultXLSFunctions[I].Definition := TcxProc(XLSDefaultFunctions[I]);

end.
