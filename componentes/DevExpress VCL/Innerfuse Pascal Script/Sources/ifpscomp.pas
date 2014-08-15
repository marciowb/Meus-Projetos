{ifpscomp is the compiler part of the script engine}
unit ifpscomp;
{

Innerfuse Pascal Script III
Copyright (C) 2000-2002 by Carlo Kok (ck@carlo-kok.com)

Features:

  - Constants
  - Variables
  - Procedures/Functions
  - Procedural Variables
  - If, While, Repeat, For, Case
  - Break/Continue
  - External/Integer Procedures/Functions
  - Arrays, Records
  - Ability to create compiled code that can be used later
  - Debugging Support
  - Importing Delphi Funtions and classes

}
{$I ifps3_def.inc}
interface
uses
  SysUtils, ifps3utl, ifps3common;
const
  {Internal constant: used when a value must be read from an address}
  CVAL_Addr = 0;
  {Internal constant: used when a value is plain data}
  CVAL_Data = 1;
  {Internal constant: used when a value must be read from an address and pushed}
  CVAL_PushAddr = 2;
  {Internal constant: used for function calls}
  CVAL_Proc = 3;
  {Internal constant: used when there are sub calculations}
  CVAL_Eval = 4;
  {Internal constant: same as address except that it has to be freed otherwise}
  CVAL_AllocatedStackReg = 5;
  {Internal constant: A method call}
  CVAL_ClassProcCall = 7;
  {Internal contant: A method call}
  CVAL_ClassMethodCall = 8;
  {Internal constant: Property set method}
  CVAL_ClassPropertyCallSet = 9;
  {Internal constant: Property get method}
  CVAL_ClassPropertyCallGet = 10;
  {Internal Constant: Procedural Call with variable procedure number}
  CVAL_VarProc = 11;
  {Internal Constant: Procedural Pointer}
  CVAL_VarProcPtr = 12;
  {Internal Constant: Array}
  CVAL_Array = 13;
  {Internal Constant: ArrayAllocatedStackRec same as @link(CVAL_AllocatedStackReg)}
  CVAL_ArrayAllocatedStackRec = 14;
  {Internal Constant: Nil}
  CVAL_Nil = 15;
  {Internal Constant; Casting}
  CVAL_Cast = 16;

type
  TIFPSPascalCompiler = class;
  {Internal type used to store the current block type}
  TSubOptType = (tMainBegin, tProcBegin, tSubBegin, tOneLiner, tifOneliner, tRepeat, tTry, tTryEnd);

  {TIFPSExternalClass is used when external classes need to be called}
  TIFPSExternalClass = class;

  TIFPSRegProc = class(TObject)
  private
    FNameHash: Longint;
    FName, FDecl: string;
    FExportName: Boolean;
    FImportDecl: string;
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
    property NameHash: Longint read FNameHash;
    property Decl: string read FDecl write FDecl;
    property ExportName: Boolean read FExportName write FExportName;
    property ImportDecl: string read FImportDecl write FImportDecl;
  end;
  PIFPSRegProc = TIFPSRegProc;
  {The compile time variant}
  PIfRVariant = ^TIfRVariant;
  {The compile time variant}
  TIfRVariant = record
    FType: Cardinal;
    BaseType: TIFPSBaseType;
    case Byte of
      1: (tu8: TbtU8);
      2: (tS8: TbtS8);
      3: (tu16: TbtU16);
      4: (ts16: TbtS16);
      5: (tu32: TbtU32);
      6: (ts32: TbtS32);
      7: (tsingle: TbtSingle);
      8: (tdouble: TbtDouble);
      9: (textended: TbtExtended);
      10: (tstring: Pointer);
      {$IFNDEF NOINT64}
      17: (ts64: Tbts64);
      {$ENDIF}
      19: (tchar: tbtChar);
      {$IFNDEF NOWIDESTRING}
      18: (twidestring: Pointer);
      20: (twidechar: tbtwidechar);
      {$ENDIF}
  end;
  {TIFPSRecordFieldTypeDef is is used to store records}
  TIFPSRecordFieldTypeDef = class
  private
    FFieldNameHash: Longint;
    FFieldName: string;
    FRealFieldOffset: Cardinal;
    FType: Cardinal;
    procedure SetFieldName(const Value: string);
  public
    property FieldNameHash: Longint read FFieldNameHash;
    property FieldName: string read FFieldName write SetFieldName;
    property RealFieldOffset: Cardinal read FRealFieldOffset write FRealFieldOffset;
    property aType: Cardinal read FType write FType;
  end;
  {PIFPSRecordFieldTypeDef is is used to store records}
  PIFPSRecordFieldTypeDef = TIFPSRecordFieldTypeDef;
  {TIFPSType contains a type definition}
  TIFPSType = class(TObject)
  private
    FNameHash: Longint;
    FName: string;
    FBaseType: TIFPSBaseType;
    FDeclarePosition: Cardinal;
    FUsed: Boolean;
    FTypeSize: Cardinal;
    FExportName: Boolean;
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
    property NameHash: Longint read FNameHash;
    property BaseType: TIFPSBaseType read FBaseType write FBaseType;
    property DeclarePosition: Cardinal read FDeclarePosition write FDeclarePosition;
    property Used: Boolean read FUsed;
    property TypeSize: Cardinal read FTypeSize write FTypeSize;
    property ExportName: Boolean read FExportName write FExportName;

    procedure Use;
  end;

  {PIFPSType is a pointer to a @link(TIFPSType) record}
  PIFPSType = TIFPSType;

  TIFPSRecordType = class(TIFPSType)
  private
    FRecordSubVals: TIfList;
  public
    constructor Create;
    destructor Destroy; override;

    function RecValCount: Longint;
    function RecVal(I: Longint): PIFPSRecordFieldTypeDef;

    function AddRecVal: PIFPSRecordFieldTypeDef;
  end;

  TIFPSClassType = class(TIFPSType)
  private
    FClassHelper: TIFPSExternalClass;
  public
    property ClassHelper: TIFPSExternalClass read FClassHelper write FClassHelper;
  end;

  TIFPSProceduralType = class(TIFPSType)
  private
    FProcDef: string;
  public
    property ProcDef: string read FProcDef write FProcDef;
  end;

  TIFPSArrayType = class(TIFPSType)
  private
    FArrayTypeNo: Cardinal;
  public
    property ArrayTypeNo: Cardinal read FArrayTypeNo write FArrayTypeNo;
  end;

  TIFPSTypeLink = class(TIFPSType)
  private
    FLinkTypeNo: Cardinal;
  public
    property LinkTypeNo: Cardinal read FLinkTypeNo write FLinkTypeNo;
  end;

  TIFPSEnumType = class(TIFPSType)
  private
    FHighValue: Cardinal;
  public
    property HighValue: Cardinal read FHighValue write FHighValue;
  end;

  {TIFPSProcVar is used to store procedural variables}
  TIFPSProcVar = class(TObject)
  private
    FNameHash: Longint;
    FName: string;
    FType: Cardinal; // only for calculation types
    FUsed: Boolean;
    FDeclarePosition: Cardinal;
    procedure SetName(const Value: string);
  public
    property NameHash: Longint read FNameHash;
    property Name: string read FName write SetName;
    property AType: Cardinal read FType write FType;
    property Used: Boolean read FUsed;
    property DeclarePosition: Cardinal read FDeclarePosition write FDeclarePosition;
    procedure Use;
  end;
  {@link(TIFPSProcVar)
  PIFPSProcVar is a TIFPSProcVar class}
  PIFPSProcVar = TIFPSProcVar;

  TIFPSProcedure = class(TObject)
  end;

  TIFPSExternalProcedure = class(TIFPSProcedure)
  private
    FRegProc: TIFPSRegProc;
  public
    property RegProc: TIFPSRegProc read FRegProc write FRegProc;
  end;

  TIFPSExportType = (etExportNone, etExportName, etExportDecl);
  TIFPSInternalProcedure = class(TIFPSProcedure)
  private
    FForwarded: Boolean;
    FData: string;
    FNameHash: Longint;
    FDecl, FName: string;
    {Decl: [RESULTTYPE] [PARAM1NAME] [PARAM1TYPE] [PARAM2NAME] ... }
    { @ = Normal Parameter  ! = Var parameter}
    FProcVars: TIfList;
    FUsed: Boolean;
    FDeclarePosition: Cardinal;
    FOutputDeclPosition: Cardinal;
    FResultUsed: Boolean;
    FExport: TIFPSExportType;
    FLabels: TIfStringList; // mi2s(position)+mi2s(namehash)+name   [position=$FFFFFFFF means position unknown]
    FGotos: TIfStringList;
    procedure SetName(const Value: string);  // mi2s(position)+mi2s(destinationnamehash)+destinationname
  public
    constructor Create;
    destructor Destroy; override;

    property Forwarded: Boolean read FForwarded write FForwarded;
    property Data: string read FData write FData;
    property Decl: string read FDecl write FDecl;
    property Name: string read FName write SetName;
    property NameHash: Longint read FNameHash;
    property ProcVars: TIFList read FProcVars;
    property Used: Boolean read FUsed;
    property DeclarePosition: Cardinal read FDeclarePosition write FDeclarePosition;
    property OutputDeclPosition: Cardinal read FOutputDeclPosition write FOutputDeclPosition;
    property ResultUsed: Boolean read FResultUsed;

    property aExport: TIFPSExportType read FExport write FExport;

    property Labels: TIfStringList read FLabels;
    property Gotos: TIfStringList read FGotos;

    procedure Use;
    procedure ResultUse;
  end;
  {PIFPSVar is a pointer to a TIFPSVar record}
  PIFPSVar = ^TIFPSVar;
  {TIFPSVar is used to store global variables}
  TIFPSVar = record
    NameHash: Longint;
    Name: string;
    FType: Cardinal;
    Used: Boolean;
    DeclarePosition: Cardinal;
    exportname: string;
  end;
  {PIFPSContant is a pointer to a TIFPSConstant}
  PIFPSConstant = ^TIFPSConstant;
  {TIFPSContant contains a constant}
  TIFPSConstant = record
    NameHash: Longint;
    Name: string;
    Value: TIfRVariant;
  end;
  {Is used to store the type of a compiler error}
  TIFPSPascalCompilerError = (
    ecUnknownIdentifier,
    ecIdentifierExpected,
    ecCommentError,
    ecStringError,
    ecCharError,
    ecSyntaxError,
    ecUnexpectedEndOfFile,
    ecSemicolonExpected,
    ecBeginExpected,
    ecPeriodExpected,
    ecDuplicateIdentifier,
    ecColonExpected,
    ecUnknownType,
    ecCloseRoundExpected,
    ecTypeMismatch,
    ecInternalError,
    ecAssignmentExpected,
    ecThenExpected,
    ecDoExpected,
    ecNoResult,
    ecOpenRoundExpected,
    ecCommaExpected,
    ecToExpected,
    ecIsExpected,
    ecOfExpected,
    ecCloseBlockExpected,
    ecVariableExpected,
    ecStringExpected,
    ecEndExpected,
    ecUnSetLabel,
    ecNotInLoop,
    ecInvalidJump,
    ecOpenBlockExpected,
    ecWriteOnlyProperty,
    ecReadOnlyProperty,
    ecClassTypeExpected,
    ecCustomError,
    ecDivideByZero,
    ecMathError,
    ecUnsatisfiedForward,
    ecForwardParameterMismatch

    );
  {Used to store the type of a hint}
  TIFPSPascalCompilerHint = (
    ehVariableNotUsed, {param = variable name}
    ehFunctionNotUsed, {param = function name}
    ehCustomHint
    );
  {Is used to store the type of a warning}
  TIFPSPascalCompilerWarning = (
    ewCalculationAlwaysEvaluatesTo,
    ewIsNotNeeded,
    ewCustomWarning
  );
  {Is used to store the type of the messages}
  TIFPSPascalCompilerMessageType = (ptWarning, ptError, ptHint);
  {Contains a pointer to an TIFPSPascalCompilerMessages record}
  PIFPSPascalCompilerMessage = ^TIFPSPascalCompilerMessage;
  {Contains compiler messages}
  TIFPSPascalCompilerMessage = packed record

    ModuleName: string;
    Param: string;
    Position: Cardinal;
    MessageType: TIFPSPascalCompilerMessageType;
    case TIFPSPascalCompilerMessageType of
      ptError: (Error: TIFPSPascalCompilerError);
      ptWarning: (Warning: TIFPSPascalCompilerWarning);
      ptHint: (Hint: TIFPSPascalCompilerHint);
  end;

  {See TIFPSPascalCompiler.OnUseVariable}
  TIFPSOnUseVariable = procedure (Sender: TIFPSPascalCompiler; VarType: TIFPSVariableType; VarNo: Longint; ProcNo, Position: Cardinal; const PropData: string);
  {See TIFPSPascalCompiler.OnUses}
  TIFPSOnUses = function(Sender: TIFPSPascalCompiler; const Name: string): Boolean;
  {See TIFPSPascalCompiler.OnExportCheck}
  TIFPSOnExportCheck = function(Sender: TIFPSPascalCompiler; Proc: TIFPSInternalProcedure; const ProcDecl: string): Boolean;
  {See TIFPSPascalCompiler.OnWriteLine}
  TIFPSOnWriteLineEvent = function (Sender: TIFPSPascalCompiler; Position: Cardinal): Boolean;
  {See TIFPSPascalCompiler.OnExternalProc}
  TIFPSOnExternalProc = function (Sender: TIFPSPascalCompiler; const Name, Decl, FExternal: string): TIFPSRegProc;
  TIFPSPascalCompiler = class
  private
    FLastProgramName: string;
    {$IFNDEF NOWIDESTRING}
    function GetWideString(FUseTypes: TIfList; Src: PIfRVariant;
      var s: Boolean): WideString;
    {$ENDIF}
  protected
    FID: Pointer;
    FOnExportCheck: TIFPSOnExportCheck;
    FBooleanType: Cardinal;
    FRegProcs: TIfList;
    FConstants: TIFList;
    FProcs: TIfList;
    FAvailableTypes: TIfList;
    FUsedTypes: TIfList;
    FVars: TIfList;
    FOutput: string;
    FParser: TIfPascalParser;
    FMessages: TIfList;
    FOnUses: TIFPSOnUses;
    FIsUnit: Boolean;
    FAllowNoBegin: Boolean;
    FAllowNoEnd: Boolean;
    FAllowUnit: Boolean;
    FDebugOutput: string;
    FOnExternalProc: TIFPSOnExternalProc;
    FOnUseVariable: TIFPSOnUseVariable;
    FOnWriteLine: TIFPSOnWriteLineEvent;
    FContinueOffsets, FBreakOffsets: TIfList;
    FAutoFreeList: TIfList;
    function GetType(BaseType: TIFPSBaseType): Cardinal;
    function GetMsgCount: Longint;
    function MakeDecl(decl: string): string;
    function MakeExportDecl(decl: string): string;
    function GetMsg(l: Longint): PIFPSPascalCompilerMessage;
    procedure DefineStandardTypes;
    procedure UpdateRecordFields(r: TIFPSType);
    function GetTypeCopyLink(p: PIFPSType): PIFPSType;
    function GetTypeCopyLinkInt(L: Cardinal): Cardinal;
    function IsIntBoolType(FTypeNo: Cardinal): Boolean;
    function GetUInt(FUseTypes: TIFList; Src: PIfRVariant; var s: Boolean): Cardinal;
    function GetInt(FUseTypes: TIFList; Src: PIfRVariant; var s: Boolean): Longint;
    {$IFNDEF NOINT64}
    function GetInt64(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): Int64;
    {$ENDIF}
    function GetReal(FUseTypes: TIFList; Src: PIfRVariant; var s: Boolean): Extended;
    function GetString(FUseTypes: TIFList; Src: PIfRVariant; var s: Boolean): string;
    function PreCalc(FUseTypes: TIFList; Var1Mod: Byte; var1: PIFRVariant; Var2Mod: Byte;
      Var2: PIfRVariant; Cmd: Byte; Pos: Cardinal): Boolean;
    function ReadConstant(StopOn: TIfPasToken): PIfRVariant;
    procedure WriteDebugData(const s: string);
    function ProcessFunction(AlwaysForward: Boolean): Boolean;
    function IsDuplicate(const s: string): Boolean;
    function DoVarBlock(proc: TIFPSInternalProcedure): Boolean;
    function DoTypeBlock(FParser: TIfPascalParser): Boolean;
    function ReadType(const Name: string; FParser: TIfPascalParser): Cardinal;
    function NewProc(const Name: string): TIFPSInternalProcedure;
    function ProcessLabel(Proc: TIFPSInternalProcedure): Boolean;
    procedure Debug_SavePosition(ProcNo: Cardinal; Proc: TIFPSInternalProcedure; TokenPos: Cardinal);
    procedure Debug_WriteParams(ProcNo: Cardinal; Proc: TIFPSInternalProcedure);
    function ProcessSub(FType: TSubOptType; ProcNo: Cardinal; proc: TIFPSInternalProcedure): Boolean;
    function ProcessLabelForwards(Proc: TIFPSInternalProcedure): Boolean;

    procedure ReplaceTypes(var s: string);
    function AT2UT(L: Cardinal): Cardinal;
    function GetUsedType(No: Cardinal): PIFPSType;
    function GetAvailableType(No: Cardinal): PIFPSType;
    function GetUsedTypeCount: Cardinal;
    function GetAvailableTypeCount: Cardinal;
    function UseAvailableType(No: Cardinal): Cardinal;
    function AddUsedFunction(var Proc: TIFPSInternalProcedure): Cardinal;
    function AddUsedFunction2(var Proc: TIFPSExternalProcedure): Cardinal;
    function CheckCompatProc(FTypeNo, ProcNo: Cardinal): Boolean;
    procedure ParserError(Parser: TObject; Kind: TIFParserErrorKind; Position: Cardinal);
  public
    {Add an object to the auto-free list}
    procedure AddToFreeList(Obj: TObject);
    {Tag}
    property ID: Pointer read FID write FID;
    {Add an error the messages}
    function MakeError(const Module: string; E: TIFPSPascalCompilerError; const
      Param: string): PIFPSPascalCompilerMessage;
    {Add a warning to the messages}
    function MakeWarning(const Module: string; E: TIFPSPascalCompilerWarning;
      const Param: string): PIFPSPascalCompilerMessage;
    {Add a hint to the messages}
    function MakeHint(const Module: string; E: TIFPSPascalCompilerHint;
      const Param: string): PIFPSPascalCompilerMessage;
    {Add a function}
    function AddFunction(const Header: string): TIFPSRegProc;
    {add a type}
    function AddType(const Name: string; const BaseType: TIFPSBaseType): PIFPSType;
    {Add a type declared in a string}
    function AddTypeS(const Name, Decl: string): PIFPSType;
    {Add a type copy type}
    function AddTypeCopy(const Name: string; TypeNo: Cardinal): PIFPSType;
    {Add a type copy type}
    function AddTypeCopyN(const Name, FType: string): PIFPSType;
    {Add a constant}
    function AddConstant(const Name: string; FType: Cardinal): PIFPSConstant;
    {Add a constant}
    function AddConstantN(const Name, FType: string): PIFPSConstant;
    {Add a variable}
    function AddVariable(const Name: string; FType: Cardinal): PIFPSVar;
    {Add a variable}
    function AddVariableN(const Name, FType: string): PIFPSVar;
    {Add an used variable}
    function AddUsedVariable(const Name: string; FType: Cardinal): PIFPSVar;
    {add an used variable (with named type)}
    function AddUsedVariableN(const Name, FType: string): PIFPSVar;
    {Add a variable and export it}
    function AddExportVariableN(const Name, FType: string): PIFPSVar;
    {Add an used variable and export it}
    function AddUsedExportVariableN(const Name, FType: string): PIFPSVar;
    {Search for a type}
    function FindType(const Name: string): Cardinal;
    {Compile a script (s)}
    function Compile(const s: string): Boolean;
    {Return the output}
    function GetOutput(var s: string): Boolean;
	{Return the debugger output}
    function GetDebugOutput(var s: string): Boolean;
    {Clear the current data}
    procedure Clear;
    {Create}
    constructor Create;
	{Destroy the current instance of the script compiler}
    destructor Destroy; override;
    {contains the number of messages}
    property MsgCount: Longint read GetMsgCount;
	{The messages/warnings/errors}
    property Msg[l: Longint]: PIFPSPascalCompilerMessage read GetMsg;
    {OnUses i scalled for each Uses and always first with 'SYSTEM' parameters}
    property OnUses: TIFPSOnUses read FOnUses write FOnUses;
	{OnExportCheck is called for each function to check if it needs to be exported and has the correct parameters}
    property OnExportCheck: TIFPSOnExportCheck read FOnExportCheck write FOnExportCheck;
	{OnWriteLine is called after each line}
    property OnWriteLine: TIFPSOnWriteLineEvent read FOnWriteLine write FOnWriteLine;
	{OnExternalProc is called when an external token is found after a procedure header}
    property OnExternalProc: TIFPSOnExternalProc read FOnExternalProc write FOnExternalProc;
	{The OnUseVariant event is called when a variable is used by the script engine}
    property OnUseVariable: TIFPSOnUseVariable read FOnUseVariable write FOnUseVariable;
	{contains true if the current file is a unit}
    property IsUnit: Boolean read FIsUnit;
	{Allow no main begin/end}
    property AllowNoBegin: Boolean read FAllowNoBegin write FAllowNoBegin;
	{Allow a unit instead of program}
    property AllowUnit: Boolean read FAllowUnit write FAllowUnit;
	{Allow it to have no END on the script (only works when AllowNoBegin is true)}
    property AllowNoEnd: Boolean read FAllowNoEnd write FAllowNoEnd;
    {Last Program or Unit name}
    property LastProgramName: string read FLastProgramName;
  end;
  {Pointer to @link(TIFPSValue) type}
  PIFPSValue = ^TIFPSValue;
  {Type containing types}
  TIFPSValue = packed record
    FType: Byte;
    Modifiers: byte;
    {
      1 = not
      2 = minus
      4 = ignore types (casting)
      8 = override type
      128 = don't free
    }
    FNewTypeNo: Cardinal;
    DPos: Cardinal;
    case Byte of
      CVAL_Nil: ();
      CVAL_Addr: (Address: Cardinal; RecField: TIfList); {i/o}
      CVAL_Data: (FData: PIfRVariant); {i}
      CVAL_PushAddr: (Address_: Cardinal; RecField__: TIfList);
      CVAL_Proc: (Parameters: TIfList; ProcNo: Cardinal);
      CVAL_VarProc: (_Parameters: TIfList; _ProcNo: PIFPSValue);
      CVAL_Eval: (SubItems: TIfList; frestype: Cardinal);
      CVAL_ClassPropertyCallGet,
      CVAL_ClassPropertyCallSet,
      CVAL_ClassMethodCall,
      CVAL_ClassProcCall: (Self: PIFPSValue; ClassProcNo: Cardinal; Params: TIfList);
      CVAL_Array: (ArrayItems: TIfList);
      CVAL_VarProcPtr: (VProcNo: Cardinal);
      CVAL_Cast: (NewTypeNo: Cardinal; Input: PIFPSValue);
  end;
  {Internal type: PCalc_Item}
  PCalc_Item = ^TCalc_Item;
  {Internal type: TCalc_Item}
  TCalc_Item = packed record
    C: Boolean;
    case Boolean of
      False: (OutRec: PIFPSValue);
      True: (calcCmd: Byte);
  end;
  {Internal type: PIFRecField}
  PIFRecField = ^TIFRecField;
  {Internal type: TIFRecField}
  TIFRecField = packed record
    FKind: Byte;
    FType: Cardinal;
    case Byte of
      0: (RecFieldNo: Cardinal);
      1: (ArrayFieldNo: Cardinal);
      2: (ReadArrayFieldNoFrom: PIFPSValue);
      3: (ResultRec: PIFPSValue);
  end;
  {TIFPSExternalClass is used when external classes need to be called}
  TIFPSExternalClass = class
  protected
    SE: TIFPSPascalCompiler;
  public
    {The type used as a class}
    function SelfType: Cardinal; virtual;
	{Create}
    constructor Create(Se: TIFPSPascalCompiler);
    {Find a class function}
    function ClassFunc_Find(const Name: string; var Index: Cardinal): Boolean; virtual;
	{Call a class function}
    function ClassFunc_Call(Index: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
    {Find a function}
    function Func_Find(const Name: string; var Index: Cardinal): Boolean; virtual;
	{Call a function}
    function Func_Call(Index: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
    {Find a variant}
    function Property_Find(const Name: string; var Index: Cardinal): Boolean; virtual;
	{Return the header of an variant}
    function Property_GetHeader(Index: Cardinal; var s: string): Boolean; virtual;
	{Get a variant value}
    function Property_Get(Index: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
	{Set a variant value}
    function Property_Set(Index: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
    {Check if the class is compatible}
    function IsCompatibleWith(Cl: TIFPSExternalClass): Boolean; virtual;
    {Returns the ProcNo for setting a class variable to nil}
    function SetNil(TypeNo: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
    {Return the procno for casting}
    function CastToType(TypeNo, IntoType: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
    {Return the procno for comparing two classes}
    function CompareClass(OtherTypeNo: Cardinal; var ProcNo: Cardinal): Boolean; virtual;
  end;
{Convert a message to a string}
function IFPSMessageToString(x: PIFPSPascalCompilerMessage): string;
{Set the name of an exported variable}
procedure SetVarExportName(P: PIFPSVar; const ExpName: string);


implementation

procedure SetVarExportName(P: PIFPSVar; const ExpName: string);
begin
  if p <> nil then
    p^.exportname := ExpName;
end;
function TIFPSPascalCompiler.GetType(BaseType: TIFPSBaseType): Cardinal;
var
  l: Longint;
  x: PIFPSType;
begin
  for l := 0 to FUsedTypes.Count - 1 do
  begin
    x := FUsedTypes.GetItem(l);
    if (x.BaseType = BaseType) and (x.ClassType = TIFPSType) then
    begin
      Result := l;
      exit;
    end;
  end;
  for l := 0 to FAvailableTypes.Count - 1 do
  begin
    x := FAvailableTypes.GetItem(l);
    if (x.BaseType = BaseType) and (x.ClassType = TIFPSType) then
    begin
      FUsedTypes.Add(x);
      Result := FUsedTypes.Count - 1;
      exit;
    end;
  end;
  X := TIFPSType.Create;
  x.Name := '';
  x.BaseType := BaseType;
  x.TypeSize := 1;
  x.DeclarePosition := Cardinal(-1);
  x.Use;
  FAvailableTypes.Add(x);
  FUsedTypes.Add(x);
  Result := FUsedTypes.Count - 1;
end;

function TIFPSPascalCompiler.MakeDecl(decl: string): string;
var
  s: string;
  c: char;
begin
  s := grfw(decl);
  if s = '-1' then result := '0' else
  result := PIFPSType(FUsedTypes.GetItem(StrToInt(s))).Name;

  while length(decl) > 0 do
  begin
    s := grfw(decl);
    c := s[1];
    s := PIFPSType(FUsedTypes.GetItem(StrToInt(grfw(decl)))).Name;
    result := result +' '+c+s;
  end;
end;


{ TIFPSPascalCompiler }

const
  BtTypeCopy = 255;

function IFPSMessageToString(x: PIFPSPascalCompilerMessage): string;
begin
  case x^.MessageType of
    ptError:
      begin
        case x^.Error of
          ecUnknownIdentifier: Result := 'Unknown identifier ''' + x^.Param +
            '''';
          ecIdentifierExpected: Result := 'Identifier expected';
          ecCommentError: Result := 'Comment error';
          ecStringError: Result := 'String error';
          ecCharError: Result := 'Char error';
          ecSyntaxError: Result := 'Syntax error';
          ecUnexpectedEndOfFile: Result := 'Unexpected end of file';
          ecSemicolonExpected: Result := 'Semicolon ('';'') expected';
          ecBeginExpected: Result := '''BEGIN'' expected';
          ecPeriodExpected: Result := 'period (''.'') expected';
          ecDuplicateIdentifier: Result := 'Duplicate identifier ''' + x^.Param + '''';
          ecColonExpected: Result := 'colon ('':'') expected';
          ecUnknownType: Result := 'Unknown type ''' + x^.Param + '''';
          ecCloseRoundExpected: Result := 'Close round expected';
          ecTypeMismatch: Result := 'Type mismatch';
          ecInternalError: Result := 'Internal error (' + x^.Param + ')';
          ecAssignmentExpected: Result := 'Assignment expected';
          ecThenExpected: Result := '''THEN'' expected';
          ecDoExpected: Result := '''DO'' expected';
          ecNoResult: Result := 'No result';
          ecOpenRoundExpected: Result := 'open round (''('')expected';
          ecCommaExpected: Result := 'comma ('','') expected';
          ecToExpected: Result := '''TO'' expected';
          ecIsExpected: Result := 'is (''='') expected';
          ecOfExpected: Result := '''OF'' expected';
          ecCloseBlockExpected: Result := 'Close block('']'') expected';
          ecVariableExpected: Result := 'Variable Expected';
          ecStringExpected: result := 'String Expected';
          ecEndExpected: Result := '''END'' expected';
          ecUnSetLabel: Result := 'Label '''+x^.Param+''' not set';
          ecNotInLoop: Result := 'Not in a loop';
          ecInvalidJump: Result := 'Invalid jump';
          ecOpenBlockExpected: Result := 'Open Block (''['') expected';
          ecWriteOnlyProperty: Result := 'Write-only property';
          ecReadOnlyProperty: Result := 'Read-only property';
          ecClassTypeExpected: Result := 'Class type expected';
          ecCustomError: Result := x^.Param;
          ecDivideByZero: Result := 'Divide by Zero';
          ecMathError:  Result := 'Math Error';
          ecUnsatisfiedForward: Result := 'Unsatisfied Forward '+ X^.Param;
          ecForwardParameterMismatch: Result := 'Forward Parameter Mismatch';
        else
          Result := 'Unknown error';
        end;
        Result := '[Error] ' + x^.ModuleName + ': ' + Result;
      end;
    ptHint:
      begin
        case x^.Hint of
          ehVariableNotUsed: Result := 'Variable ''' + x^.Param + ''' never used';
          ehFunctionNotUsed: Result := 'Function ''' + x^.Param + ''' never used';
          ehCustomHint: Result := x^.Param;
        else
          Result := 'Unknown hint';
        end;
        Result := '[Hint] ' + x^.ModuleName + ': ' + Result;
      end;
    ptWarning:
      begin
        case x^.Warning of
          ewCustomWarning: Result := x^.Param;
          ewCalculationAlwaysEvaluatesTo: Result := 'Calculation always evaluates to '+x^.Param;
          ewIsNotNeeded: Result := x^.Param +' is not needed';
        end;
        Result := '[Warning] ' + x^.ModuleName + ': ' + Result;
      end;
  else
    Result := 'Unknown message';
  end;
end;

type
  TFuncType = (ftProc, ftFunc);

function mi2s(i: Cardinal): string;
begin
  Result := #0#0#0#0;
  Cardinal((@Result[1])^) := i;
end;




function TIFPSPascalCompiler.AddType(const Name: string; const BaseType: TIFPSBaseType): PIFPSType;
begin
  if FProcs = nil then begin Result := nil; exit;end;

  case BaseType of
    btProcPtr: Result := TIFPSProceduralType.Create;
    BtTypeCopy: Result := TIFPSTypeLink.Create;
    btRecord: Result := TIFPSRecordType.Create;
    btArray: Result := TIFPSArrayType.Create;
    btClass: Result := TIFPSClassType.Create;
  else
    Result := TIFPSType.Create;
  end;
  Result.Name := FastUppercase(Name);
  Result.BaseType := BaseType;
  Result.TypeSize := 1;
  Result.DeclarePosition := Cardinal(-1);
  FAvailableTypes.Add(Result);
end;


function TIFPSPascalCompiler.AddFunction(const Header: string): TIFPSRegProc;

  function FindType(const s: string): Cardinal;
  var
    h, l: Longint;
  begin
    h := MakeHash(s);
    for l := 0 to FAvailableTypes.Count - 1 do
    begin
      if (PIFPSType(FAvailableTypes.GetItem(l)).NameHash = h) and
        (PIFPSType(FAvailableTypes.GetItem(l)).Name = s) then
      begin
        Result := l;
        exit;
      end;
    end;
    Result := Cardinal(-1);
  end;
var
  Parser: TIfPascalParser;
  IsFunction: Boolean;
  VNames, Name, Decl: string;
  modifier: Char;
  VCType: Cardinal;
  x: TIFPSRegProc;
begin
  if FProcs = nil then begin Result := nil; exit;end;
  Parser := TIfPascalParser.Create;
  Parser.SetText(Header);
  if Parser.CurrTokenId = CSTII_Function then
    IsFunction := True
  else if Parser.CurrTokenId = CSTII_Procedure then
    IsFunction := False
  else
  begin
    Parser.Free;
    Result := nil;
    exit;
  end;
  Decl := '';
  Parser.Next;
  if Parser.CurrTokenId <> CSTI_Identifier then
  begin
    Parser.Free;
    Result := nil;
    exit;
  end; {if}
  Name := Parser.GetToken;
  Parser.Next;
  if Parser.CurrTokenId = CSTI_OpenRound then
  begin
    Parser.Next;
    if Parser.CurrTokenId <> CSTI_CloseRound then
    begin
      while True do
      begin
        if Parser.CurrTokenId = CSTII_Const then
        begin
          Modifier := '@';
          Parser.Next;
        end else
        if Parser.CurrTokenId = CSTII_Var then
        begin
          modifier := '!';
          Parser.Next;
        end
        else
          modifier := '@';
        if Parser.CurrTokenId <> CSTI_Identifier then
        begin
          Parser.Free;
          Result := nil;
          exit;
        end;
        VNames := Parser.GetToken + '|';
        Parser.Next;
        while Parser.CurrTokenId = CSTI_Comma do
        begin
          Parser.Next;
          if Parser.CurrTokenId <> CSTI_Identifier then
          begin
            Parser.Free;
            Result := nil;
            exit;
          end;
          VNames := VNames + Parser.GetToken + '|';
          Parser.Next;
        end;
        if Parser.CurrTokenId <> CSTI_Colon then
        begin
          Parser.Free;
          Result := nil;
          exit;
        end;
        Parser.Next;
        VCType := FindType(Parser.GetToken);
        if VCType = Cardinal(-1) then
        begin
          Parser.Free;
          Result := nil;
          exit;
        end;
        while Pos('|', VNames) > 0 do
        begin
          Decl := Decl + ' ' + modifier + copy(VNames, 1, Pos('|', VNames) - 1)
            +
            ' ' + inttostr(VCType);
          Delete(VNames, 1, Pos('|', VNames));
        end;
        Parser.Next;
        if Parser.CurrTokenId = CSTI_CloseRound then
          break;
        if Parser.CurrTokenId <> CSTI_Semicolon then
        begin
          Parser.Free;
          Result := nil;
          exit;
        end;
        Parser.Next;
      end; {while}
    end; {if}
    Parser.Next;
  end; {if}
  if IsFunction then
  begin
    if Parser.CurrTokenId <> CSTI_Colon then
    begin
      Parser.Free;
      Result := nil;
      exit;
    end;

    Parser.Next;
    VCType := FindType(Parser.GetToken);
    if VCType = Cardinal(-1) then
    begin
      Parser.Free;
      Result := nil;
      exit;
    end;
  end
  else
    VCType := Cardinal(-1);
  Decl := inttostr(VCType) + Decl;
  Parser.Free;
  X := TIFPSRegProc.Create;
  x.Name := Name;
  x.ExportName := True;
  x.Decl := Decl;
  Result := x;
  FRegProcs.Add(x);
end;

function TIFPSPascalCompiler.MakeHint(const Module: string; E: TIFPSPascalCompilerHint; const Param: string): PIFPSPascalCompilerMessage;
var
  n: PIFPSPascalCompilerMessage;
begin
  New(n);
  n^.ModuleName := Module;
  n^.Param := Param;
  n^.Position := FParser.CurrTokenPos;
  n^.MessageType := ptHint;
  n^.Hint := E;
  FMessages.Add(n);
  Result := n;
end;
function TIFPSPascalCompiler.MakeError(const Module: string; E:
  TIFPSPascalCompilerError; const Param: string): PIFPSPascalCompilerMessage;
var
  n: PIFPSPascalCompilerMessage;
begin
  New(n);
  n^.ModuleName := Module;
  n^.Param := Param;
  n^.Position := FParser.CurrTokenPos;
  n^.MessageType := ptError;
  n^.Error := E;
  FMessages.Add(n);
  Result := n;
end;

function TIFPSPascalCompiler.MakeWarning(const Module: string; E:
  TIFPSPascalCompilerWarning; const Param: string): PIFPSPascalCompilerMessage;
var
  n: PIFPSPascalCompilerMessage;
begin
  New(n);
  n^.ModuleName := Module;
  n^.Param := Param;
  n^.Position := FParser.CurrTokenPos;
  n^.MessageType := ptWarning;
  n^.Warning := E;
  FMessages.Add(n);
  Result := n;
end;

procedure TIFPSPascalCompiler.Clear;
var
  l: Longint;
  p: PIFPSPascalCompilerMessage;
begin
  FDebugOutput := '';
  FOutput := '';
  for l := 0 to FMessages.Count - 1 do
  begin
    p := FMessages.GetItem(l);
    Dispose(p);
  end;
  FMessages.Clear;
  for L := FAutoFreeList.Count -1 downto 0 do
  begin
    TObject(FAutoFreeList.GetItem(l)).Free;
  end;
  FAutoFreeList.Clear;
end;

procedure CopyVariantContents(Src, Dest: PIfRVariant);
begin
  Dest.BaseType := src.BaseType;
  case src.BaseType of
    btu8, bts8: dest^.tu8 := src^.tu8;
    btu16, bts16: dest^.tu16 := src^.tu16;
    btenum, btu32, bts32: dest^.tu32 := src^.tu32;
    btsingle: Dest^.tsingle := src^.tsingle;
    btdouble: Dest^.tdouble := src^.tdouble;
    btextended: Dest^.textended := src^.textended;
    btchar: Dest^.tchar := src^.tchar;
    {$IFNDEF NOINT64}bts64: dest^.ts64 := src^.ts64;{$ENDIF}
    btstring: tbtstring(dest^.tstring) := tbtstring(src^.tstring);
    {$IFNDEF NOWIDESTRING}
    btwidestring: tbtwidestring(dest^.twidestring) := tbtwidestring(src^.twidestring);
    btwidechar: Dest^.tchar := src^.tchar;
    {$ENDIF}
  end;
end;

procedure InitializeVariant(Vari: PIfRVariant; FType: Cardinal; BaseType: TIFPSBaseType);
begin
  FillChar(vari^, SizeOf(TIfRVariant), 0);
  vari^.FType := FType;
  vari.BaseType := BaseType;
end;

procedure FinalizeVariant(var p: TIfRVariant);
begin
  if p.BaseType = btString then
    finalize(tbtstring(p.tstring))
  {$IFNDEF NOWIDESTRING}
  else if p.BaseType = btWideString then
    finalize(tbtWideString(p.twidestring)); // widestring
  {$ENDIF}
end;

procedure DisposeVariant(p: PIfRVariant);
begin
  if p <> nil then
  begin
    FinalizeVariant(p^);
{$IFDEF DEBUG}    FillChar(p^, sizeof(p^), 0);{$ENDIF}
    Dispose(p);
  end;
end;

type
  PParam = ^TParam;
  TParam = record
    InReg, OutReg: PIFPSValue;
    FType: Cardinal;
    OutRegPos: Cardinal;
  end;

procedure DisposePValue(r: PIFPSValue); forward;

procedure FreeRecFields(List: TIfList);
var
  i: Longint;
  p: PIFRecField;
begin
  if list = nil then
    exit;
  for i := List.Count - 1 downto 0 do
  begin
    p := List.GetItem(i);
    if p^.FKind >= 2 then
    begin
      DisposePValue(p^.ReadArrayFieldNoFrom);
    end;
    Dispose(p);
  end;
  List.Free;
end;

procedure DisposePValue(r: PIFPSValue);
var
  l: Longint;
  p: PCalc_Item;
  P2: PParam;
begin
  if (r <> nil) and ((r^.Modifiers and 128)= 0) then
  begin
    if (r^.FType = CVAL_Array) then
    begin
      for l := 0 to r.ArrayItems.Count -1 do
      begin
        DisposePValue(R.ArrayItems.GetItem(l));
      end;
      r.ArrayItems.Free;
    end else
    if (r^.FType = CVAL_AllocatedStackReg) or (r^.FType = CVAL_Addr) or (r^.FType = CVAL_PushAddr) then
    begin
      FreeRecFields(R^.RecField);
    end
    else if r.FType = CVAL_Data then
      DisposeVariant(r^.FData)
    else if r.FType = CVAL_Eval then
    begin
      for l := 0 to r.SubItems.Count - 1 do
      begin
        p := r.SubItems.GetItem(l);
        if not p^.C then
          DisposePValue(p^.OutRec);
        Dispose(p);
      end;
      r^.SubItems.Free;
    end
    else if (r.FType = CVAL_Proc) or (r.FType = CVAL_varProc)then
    begin
      for l := 0 to r^.Parameters.Count - 1 do
      begin
        P2 := r^.Parameters.GetItem(l);
        if P2^.InReg <> nil then
          DisposePValue(P2^.InReg);
        Dispose(P2);
      end;
      r.Parameters.Free;
      if r.FType = CVAL_VarProc then
        DisposePValue(r._ProcNo);
    end else if (r.FType = CVAL_ClassPropertyCallGet) or (r.FType = CVAL_ClassPropertyCallSet) or (r.FType = CVAL_ClassMethodCall) or (r.FType = CVAL_ClassProcCall) then
    begin
      DisposePValue(r.Self);
      for l := 0 to r^.Params.Count - 1 do
      begin
        P2 := r^.Params.GetItem(l);
        if P2^.InReg <> nil then
          DisposePValue(P2^.InReg);
        Dispose(P2);
      end;
    end;
   {$IFDEF DEBUG}FillChar(r^, sizeof(r^), 0);{$ENDIF}
    Dispose(r);
  end;
end;

function TIFPSPascalCompiler.GetTypeCopyLink(p: PIFPSType): PIFPSType;
begin
  if p.BaseType = BtTypeCopy then
  begin
    Result := FAvailableTypes.GetItem(TIFPSTypeLink(p).LinkTypeNo);
  end else Result := p;
end;

function IsIntType(b: TIFPSBaseType): Boolean;
begin
  case b of
    btU8, btS8, btU16, btS16, btU32, btS32{$IFNDEF NOINT64}, btS64{$ENDIF}: Result := True;
  else
    Result := False;
  end;
end;

function IsRealType(b: TIFPSBaseType): Boolean;
begin
  case b of
    btSingle, btDouble, btExtended: Result := True;
  else
    Result := False;
  end;
end;

function IsIntRealType(b: TIFPSBaseType): Boolean;
begin
  case b of
    btSingle, btDouble, btExtended, btU8, btS8, btU16, btS16, btU32, btS32{$IFNDEF NOINT64}, btS64{$ENDIF}:
      Result := True;
  else
    Result := False;
  end;

end;

function DiffRec(p1, p2: PIFRecField): Boolean;
begin
  Result :=
    (p1^.FKind <> p2^.FKind) or
    (p1^.RecFieldNo <> p2^.RecFieldNo);
end;

function SameReg(x1, x2: PIFPSValue): Boolean;
var
  I: Longint;
begin
  if x1^.FType = x2^.FType then
  begin
    case x1^.FType of
      CVAL_Addr, CVAL_PushAddr, CVAL_AllocatedStackReg, CVAL_AllocatedStackReg +1:
        begin
          if x1^.Address = x2^.Address then
          begin
            if (x1^.RecField = nil) and (x2^.RecField = nil) then
              Result := True
            else if (x1^.RecField <> nil) and (x2^.RecField <> nil) and
              (x1^.RecField.Count = x2^.RecField.Count) then
            begin
              for I := x1^.RecField.Count - 1 downto 0 do
              begin
                if DiffRec(x1^.RecField.GetItem(I), x2^.RecField.GetItem(I))
                  then
                begin
                  Result := False;
                  exit;
                end;
              end;
              Result := True;
            end
            else
              Result := False;
          end
          else
            Result := False;
        end;
    else
      Result := False;
    end;
  end
  else
    Result := False;
end;

function D1(const s: string): string;
begin
  Result := copy(s, 2, Length(s) - 1);
end;

function TIFPSPascalCompiler.AT2UT(L: Cardinal): Cardinal;
var
  i: Longint;
  p: PIFPSType;
begin
  if L = Cardinal(-1) then begin Result := Cardinal(-1); exit; end;
  p := FAvailableTypes.GetItem(L);
  p := GetTypeCopyLink(p);
  if p.Used then
  begin
    for i := 0 to FUsedTypes.Count - 1 do
    begin
      if FUSedTypes.GetItem(I) = P then
      begin
        Result := i;
        exit;
      end;
    end;
  end;
  UpdateRecordFields(p);
  p.Use;
  FUsedTypes.Add(p);
  Result := FUsedTypes.Count - 1;
end;


procedure TIFPSPascalCompiler.ReplaceTypes(var s: string);
var
  NewS: string;
  ts: string;
begin
  ts := GRFW(s);
  if ts <> '-1' then
  begin
    NewS := IntToStr(AT2UT(StrToInt(ts)));
  end
  else
    NewS := '-1';
  while length(s) > 0 do
  begin
    NewS := NewS + ' ' + grfw(s);
    ts := grfw(s);
    NewS := NewS + ' ' + IntToStr(AT2UT(StrToInt(ts)));
  end;
  s := NewS;
end;

function TIFPSPascalCompiler.GetUInt(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): Cardinal;
begin
  case Src.BaseType of
    btU8: Result := Src^.tu8;
    btS8: Result := Src^.ts8;
    btU16: Result := Src^.tu16;
    btS16: Result := Src^.ts16;
    btU32: Result := Src^.tu32;
    btS32: Result := Src^.ts32;
    {$IFNDEF NOINT64}
    bts64: Result := src^.ts64;
    {$ENDIF}
    btChar: Result := ord(Src^.tchar);
    {$IFNDEF NOWIDESTRING}
    btWideChar: Result := ord(tbtwidechar(src^.twidechar));
    {$ENDIF}
    btEnum: Result := src^.tu32;
  else
    begin
      s := False;
      Result := 0;
    end;
  end;
end;

function TIFPSPascalCompiler.GetInt(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): Longint;
begin
  case Src.BaseType of
    btU8: Result := Src^.tu8;
    btS8: Result := Src^.ts8;
    btU16: Result := Src^.tu16;
    btS16: Result := Src^.ts16;
    btU32: Result := Src^.tu32;
    btS32: Result := Src^.ts32;
    {$IFNDEF NOINT64}
    bts64: Result := src^.ts64;
    {$ENDIF}
    btChar: Result := ord(Src^.tchar);
    {$IFNDEF NOWIDESTRING}
    btWideChar: Result := ord(tbtwidechar(src^.twidechar));
    {$ENDIF}
    btEnum: Result := src^.tu32;
  else
    begin
      s := False;
      Result := 0;
    end;
  end;
end;
{$IFNDEF NOINT64}
function TIFPSPascalCompiler.GetInt64(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): Int64;
begin
  case Src.BaseType of
    btU8: Result := Src^.tu8;
    btS8: Result := Src^.ts8;
    btU16: Result := Src^.tu16;
    btS16: Result := Src^.ts16;
    btU32: Result := Src^.tu32;
    btS32: Result := Src^.ts32;
    bts64: Result := src^.ts64;
    btChar: Result := ord(Src^.tchar);
    {$IFNDEF NOWIDESTRING}
    btWideChar: Result := ord(tbtwidechar(src^.twidechar));
    {$ENDIF}
    btEnum: Result := src^.tu32;
  else
    begin
      s := False;
      Result := 0;
    end;
  end;
end;
{$ENDIF}

function TIFPSPascalCompiler.GetReal(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): Extended;
begin
  case Src.BaseType of
    btU8: Result := Src^.tu8;
    btS8: Result := Src^.ts8;
    btU16: Result := Src^.tu16;
    btS16: Result := Src^.ts16;
    btU32: Result := Src^.tu32;
    btS32: Result := Src^.ts32;
    {$IFNDEF NOINT64}
    bts64: Result := src^.ts64;
    {$ENDIF}
    btChar: Result := ord(Src^.tchar);
    {$IFNDEF NOWIDESTRING}
    btWideChar: Result := ord(tbtwidechar(src^.twidechar));
    {$ENDIF}
    btSingle: Result := Src^.tsingle;
    btDouble: Result := Src^.tdouble;
    btExtended: Result := Src^.textended;
  else
    begin
      s := False;
      Result := 0;
    end;
  end;
end;

function TIFPSPascalCompiler.GetString(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): string;
begin
  case Src.BaseType of
    btChar: Result := Src^.tchar;
    btString: Result := tbtstring(src^.tstring);
    {$IFNDEF NOWIDESTRING}
    btWideChar: Result := src^.twidechar;
    btWideString: Result := tbtWideString(src^.twidestring);
    {$ENDIF}
  else
    begin
      s := False;
      Result := '';
    end;
  end;
end;

{$IFNDEF NOWIDESTRING}
function TIFPSPascalCompiler.GetWideString(FUseTypes: TIfList; Src: PIfRVariant; var s: Boolean): WideString;
begin
  case Src.BaseType of
    btChar: Result := Src^.tchar;
    btString: Result := tbtstring(src^.tstring);
    btWideChar: Result := src^.twidechar;
    btWideString: Result := tbtWideString(src^.twidestring);
  else
    begin
      s := False;
      Result := '';
    end;
  end;
end;
{$ENDIF}

function ab(b: Longint): Longint;
begin
  ab := Longint(b = 0);
end;


function TIFPSPascalCompiler.PreCalc(FUseTypes: TIfList; Var1Mod: Byte; var1: PIFRVariant; Var2Mod: Byte; Var2: PIfRVariant; Cmd: Byte; Pos: Cardinal): Boolean;
  { var1=dest, var2=src }
var
  b: Boolean;

  procedure SetBoolean(b: Boolean);
  begin
    FinalizeVariant(var1^);
    if FUseTypes = FAvailableTypes then
      Var1^.FType := FBooleanType
    else
      Var1^.FType := at2ut(FBooleanType);
    var1.BaseType := PIFPSType(FUseTypes.GetItem(at2ut(FBooleanType))).BaseType;
    var1^.tu32 := Ord(b);
  end;

  procedure SetString(const s: string);
  begin
    FinalizeVariant(var1^);
    InitializeVariant(var1, GetType(btString), btString);
    tbtstring(var1^.tstring) := s;
  end;
{$IFNDEF NOWIDESTRING}
  procedure SetWideString(const s: WideString);
  begin
    FinalizeVariant(var1^);
    InitializeVariant(var1, GetType(btWideString), btWideString);
    tbtwidestring(var1^.tstring) := s;
  end;
{$ENDIF}
  procedure MakeFloat(var1: PIfRVariant; NewType: Cardinal);
  var
    vartemp: PIfRVariant;
    b: Boolean;
  begin
    New(vartemp);
    InitializeVariant(vartemp, var1.FType, Var1.BaseType);
    CopyVariantContents(var1, vartemp);
    FinalizeVariant(var1^);
    InitializeVariant(var1, newtype, PIFPSType(FUsedTypes.GetItem(NewType)).BaseType);
    case var1.basetype of
      btSingle:
        begin
          if (vartemp.BaseType = btu8) or (vartemp.BaseType = btu16) or (vartemp.BaseType = btu32) then
            var1^.tsingle := GetUInt(FUsedTypes, vartemp, b)
          else
            var1^.tsingle := GetInt(FUsedTypes, vartemp, b)
        end;
      btDouble:
        begin
          if (vartemp.BaseType = btu8) or (vartemp.BaseType = btu16) or (vartemp.BaseType = btu32) then
            var1^.tdouble := GetUInt(FUsedTypes, vartemp, b)
          else
            var1^.tdouble := GetInt(FUsedTypes, vartemp, b)
        end;
      btExtended:
        begin
          if (vartemp.BaseType = btu8) or (vartemp.BaseType = btu16) or (vartemp.BaseType = btu32) then
            var1^.textended:= GetUInt(FUsedTypes, vartemp, b)
          else
            var1^.textended:= GetInt(FUsedTypes, vartemp, b)
        end;
    end;
    FinalizeVariant(vartemp^);
    DisposeVariant(vartemp);
  end;

begin
  Result := True;
  try
    if (IsRealType(var2.BaseType) and IsIntType(var1.BaseType)) then
      MakeFloat(var1, var2^.FType);
    case Cmd of
      0:
        begin { + }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 + GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 + GetInt(FUseTypes,Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 + GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 + GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 + GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 + GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 + GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: var1^.tsingle := var1^.tsingle + GetReal(FUseTypes, Var2, Result);
            btDouble: var1^.tdouble := var1^.tdouble + GetReal(FUseTypes, Var2, Result);
            btExtended: var1^.textended := var1^.textended + GetReal(FUseTypes, Var2, Result);
            btChar:
              begin
                if var2.BaseType = btchar then
                  var1^.tu8 := var1^.tu8 + GetUInt(FUseTypes, Var2, Result)
                else
                begin
                  SetString(getstring(FUseTypes, Var1, b)+getstring(FUseTypes, Var2, b));
                end;
              end;
            btString: tbtstring(var1^.tstring) := tbtstring(var1^.tstring) + GetString(FUseTypes, Var2, Result);
            {$IFNDEF NOWIDESTRING}
            btwideString: tbtwidestring(var1^.twidestring) := tbtwidestring(var1^.twidestring) + GetWideString(FUseTypes, Var2, Result);
            btWidechar:
              begin
                if (var2.BaseType = btchar) or (var2.BaseType = btwidechar) then
                  var1^.tu16 := var1^.tu16 + GetUInt(FUseTypes, Var2, Result)
                else
                begin
                  SetWideString(GetWideString(FUseTypes, Var1, b)+GetWideString(FUseTypes, Var2, b));
                end;
              end;
            {$ENDIF}
            else b := False;
          end;
        end;
      1:
        begin { - }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 - GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 - GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 - GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 - GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 - GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 - GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 - GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: var1^.tsingle := var1^.tsingle - GetReal(FUseTypes, Var2, Result);
            btDouble: var1^.tdouble := var1^.tdouble - GetReal(FUseTypes,Var2, Result);
            btExtended: var1^.textended := var1^.textended - GetReal(FUseTypes,Var2, Result);
            else b := False;
          end;
        end;
      2:
        begin { * }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 * GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 * GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 * GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 * GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 * GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 * GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 * GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: var1^.tsingle := var1^.tsingle * GetReal(FUseTypes,Var2, Result);
            btDouble: var1^.tdouble := var1^.tdouble * GetReal(FUseTypes,Var2, Result);
            btExtended: var1^.textended := var1^.textended * GetReal(FUseTypes, Var2, Result);
            else b := False;
          end;
        end;
      3:
        begin { / }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 div GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 div GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 div GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 div GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 div GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 div GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 div GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: var1^.tsingle := var1^.tsingle / GetReal(FUseTypes, Var2, Result);
            btDouble: var1^.tdouble := var1^.tdouble / GetReal(FUseTypes, Var2, Result);
            btExtended: var1^.textended := var1^.textended / GetReal(FUseTypes, Var2, Result);
            else b := False;
          end;
        end;
      4:
        begin { MOD }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 mod GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 mod GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 mod GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 mod GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 mod GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 mod GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 mod GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            else b := False;
          end;
        end;
      5:
        begin { SHL }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 shl GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 shl GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 shl GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 shl GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 shl GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 shl GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 shl GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            else b := False;
          end;
        end;
      6:
        begin { SHR }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 shr GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 shr GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 shr GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 shr GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 shr GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 shr GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 shr GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            else b := False;
          end;
        end;
      7:
        begin { AND }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 and GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 and GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 and GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 and GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 and GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 and GetInt(FUseTypes, Var2, Result);
            btEnum: var1^.ts32 := var1^.ts32 and GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 and GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            else b := False;
          end;
        end;
      8:
        begin { OR }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 or GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 or GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 or GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 or GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 or GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 or GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 or GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btEnum: var1^.ts32 := var1^.ts32 or GetInt(FUseTypes, Var2, Result);
            else b := False;
          end;
        end;
      9:
        begin { XOR }
          case var1.BaseType of
            btU8: var1^.tu8 := var1^.tu8 xor GetUInt(FUseTypes, Var2, Result);
            btS8: var1^.ts8 := var1^.ts8 xor GetInt(FUseTypes, Var2, Result);
            btU16: var1^.tu16 := var1^.tu16 xor GetUInt(FUseTypes, Var2, Result);
            btS16: var1^.ts16 := var1^.ts16 xor GetInt(FUseTypes, Var2, Result);
            btU32: var1^.tu32 := var1^.tu32 xor GetUInt(FUseTypes, Var2, Result);
            btS32: var1^.ts32 := var1^.ts32 xor GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: var1^.ts64 := var1^.ts64 xor GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btEnum: var1^.ts32 := var1^.ts32 xor GetInt(FUseTypes, Var2, Result);
            else b := False;
          end;
        end;
      10:
        begin { >= }
          case var1.BaseType of
            btU8: b := var1^.tu8 >= GetUInt(FUseTypes, Var2, Result);
            btS8: b := var1^.ts8 >= GetInt(FUseTypes, Var2, Result);
            btU16: b := var1^.tu16 >= GetUInt(FUseTypes, Var2, Result);
            btS16: b := var1^.ts16 >= GetInt(FUseTypes, Var2, Result);
            btU32: b := var1^.tu32 >= GetUInt(FUseTypes, Var2, Result);
            btS32: b := var1^.ts32 >= GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: b := var1^.ts64 >= GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: b := var1^.tsingle >= GetReal(FUseTypes, Var2, Result);
            btDouble: b := var1^.tdouble >= GetReal(FUseTypes, Var2, Result);
            btExtended: b := var1^.textended >= GetReal(FUseTypes, Var2, Result);
          else
            b := False;
          end;
          SetBoolean(b);
        end;
      11:
        begin { <= }
          case var1.BaseType of
            btU8: b := var1^.tu8 <= GetUInt(FUseTypes, Var2, Result);
            btS8: b := var1^.ts8 <= GetInt(FUseTypes, Var2, Result);
            btU16: b := var1^.tu16 <= GetUInt(FUseTypes, Var2, Result);
            btS16: b := var1^.ts16 <= GetInt(FUseTypes, Var2, Result);
            btU32: b := var1^.tu32 <= GetUInt(FUseTypes, Var2, Result);
            btS32: b := var1^.ts32 <= GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: b := var1^.ts64 <= GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: b := var1^.tsingle <= GetReal(FUseTypes, Var2, Result);
            btDouble: b := var1^.tdouble <= GetReal(FUseTypes, Var2, Result);
            btExtended: b := var1^.textended <= GetReal(FUseTypes, Var2, Result);
          else
            b := False;
          end;
          SetBoolean(b);
        end;
      12:
        begin { > }
          case var1.BaseType of
            btU8: b := var1^.tu8 > GetUInt(FUseTypes, Var2, Result);
            btS8: b := var1^.ts8 > GetInt(FUseTypes, Var2, Result);
            btU16: b := var1^.tu16 > GetUInt(FUseTypes, Var2, Result);
            btS16: b := var1^.ts16 > GetInt(FUseTypes, Var2, Result);
            btU32: b := var1^.tu32 > GetUInt(FUseTypes, Var2, Result);
            btS32: b := var1^.ts32 > GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: b := var1^.ts64 > GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: b := var1^.tsingle > GetReal(FUseTypes, Var2, Result);
            btDouble: b := var1^.tdouble > GetReal(FUseTypes, Var2, Result);
            btExtended: b := var1^.textended > GetReal(FUseTypes, Var2, Result);
          else
            b := False;
          end;
          SetBoolean(b);
        end;
      13:
        begin { < }
          case var1.BaseType of
            btU8: b := var1^.tu8 < GetUInt(FUseTypes, Var2, Result);
            btS8: b := var1^.ts8 < GetInt(FUseTypes, Var2, Result);
            btU16: b := var1^.tu16 < GetUInt(FUseTypes, Var2, Result);
            btS16: b := var1^.ts16 < GetInt(FUseTypes, Var2, Result);
            btU32: b := var1^.tu32 < GetUInt(FUseTypes, Var2, Result);
            btS32: b := var1^.ts32 < GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: b := var1^.ts64 < GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: b := var1^.tsingle < GetReal(FUseTypes, Var2, Result);
            btDouble: b := var1^.tdouble < GetReal(FUseTypes, Var2, Result);
            btExtended: b := var1^.textended < GetReal(FUseTypes, Var2, Result);
          else
            b := False;
          end;
          SetBoolean(b);
        end;
      14:
        begin { <> }
          case var1.BaseType of
            btU8: b := var1^.tu8 <> GetUInt(FUseTypes, Var2, Result);
            btS8: b := var1^.ts8 <> GetInt(FUseTypes, Var2, Result);
            btU16: b := var1^.tu16 <> GetUInt(FUseTypes, Var2, Result);
            btS16: b := var1^.ts16 <> GetInt(FUseTypes, Var2, Result);
            btU32: b := var1^.tu32 <> GetUInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: b := var1^.ts64 <> GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btS32: b := var1^.ts32 <> GetInt(FUseTypes, Var2, Result);
            btSingle: b := var1^.tsingle <> GetReal(FUseTypes, Var2, Result);
            btDouble: b := var1^.tdouble <> GetReal(FUseTypes, Var2, Result);
            btExtended: b := var1^.textended <> GetReal(FUseTypes, Var2, Result);
            btEnum: b := var1^.ts32 <> GetInt(FUseTypes, Var2, Result);
          else
            b := False;
          end;
          SetBoolean(b);
        end;
      15:
        begin { = }
          case var1.BaseType of
            btU8: b := var1^.tu8 = GetUInt(FUseTypes, Var2, Result);
            btS8: b := var1^.ts8 = GetInt(FUseTypes, Var2, Result);
            btU16: b := var1^.tu16 = GetUInt(FUseTypes, Var2, Result);
            btS16: b := var1^.ts16 = GetInt(FUseTypes, Var2, Result);
            btU32: b := var1^.tu32 = GetUInt(FUseTypes, Var2, Result);
            btS32: b := var1^.ts32 = GetInt(FUseTypes, Var2, Result);
            {$IFNDEF NOINT64}btS64: b := var1^.ts64 = GetInt64(FUseTypes, Var2, Result); {$ENDIF}
            btSingle: b := var1^.tsingle = GetReal(FUseTypes, Var2, Result);
            btDouble: b := var1^.tdouble = GetReal(FUseTypes, Var2, Result);
            btExtended: b := var1^.textended = GetReal(FUseTypes, Var2, Result);
            btEnum: b := var1^.ts32 = GetInt(FUseTypes, Var2, Result);
          else
            b := False;
          end;
          SetBoolean(b);
        end;
    end;
  except
    on E: EDivByZero do
    begin
      Result := False;
      MakeError('', ecDivideByZero, '');
      Exit;
    end;
    on E: EZeroDivide do
    begin
      Result := False;
      MakeError('', ecDivideByZero, '');
      Exit;
    end;
    on E: EMathError do
    begin
      Result := False;
      MakeError('', ecMathError, e.Message);
      Exit;
    end;
    on E: Exception do
    begin
      Result := False;
      MakeError('', ecInternalError, E.Message);
      Exit;
    end;
  end;
  if not Result then
    MakeError('', ecTypeMismatch, '')^.Position := Pos;
end;

function TIFPSPascalCompiler.IsDuplicate(const s: string): Boolean;
var
  h, l: Longint;
  x: TIFPSProcedure;
begin
  h := MakeHash(s);
  if (s = 'RESULT') then
  begin
    Result := True;
    exit;
  end;

  for l := 0 to FAvailableTypes.Count - 1 do
  begin
    if (PIFPSType(FAvailableTypes.GetItem(l)).NameHash = h) and
      (PIFPSType(FAvailableTypes.GetItem(l)).Name = s) then
    begin
      Result := True;
      exit;
    end;
  end;

  for l := 0 to FProcs.Count - 1 do
  begin
    x := FProcs.GetItem(l);
    if x.ClassType = TIFPSInternalProcedure then
    begin
      if (h = TIFPSInternalProcedure(x).NameHash) and (s = TIFPSInternalProcedure(x).Name) then
      begin
        Result := True;
        exit;
      end;
    end
    else
    begin
      if (TIFPSExternalProcedure(x).RegProc.NameHash = h) and
        (TIFPSExternalProcedure(x).RegProc.Name = s) then
      begin
        Result := True;
        exit;
      end;
    end;
  end;
  for l := 0 to FVars.Count - 1 do
  begin
    if (PIFPSVar(FVars.GetItem(l))^.NameHash = h) and
      (PIFPSVar(FVars.GetItem(l))^.Name = s) then
    begin
      Result := True;
      exit;
    end;
  end;
  for l := 0 to FConstants.Count -1 do
  begin
    if (PIFPSConstant(FConstants.GetItem(l))^.NameHash = h) and
      (PIFPSConstant(FConstants.GetItem(l))^.Name = s) then
    begin
      Result := TRue;
      exit;
    end;
  end;
  Result := False;
end;


function TIFPSPascalCompiler.ReadType(const Name: string; FParser: TIfPascalParser): Cardinal; // Cardinal(-1) = Invalid
var
  TypeNo: Cardinal;
  h, l: Longint;
  fieldname,s: string;
  RecSubVals: TIfList;
  rvv: PIFPSRecordFieldTypeDef;
  p, p2: PIFPSType;
  function ATNUT(C: Cardinal): Cardinal;
  var
    i: Longint;
    P: PIFPSType;
  begin
    p := FAvailableTypes.GetItem(C);
    for i := 0 to FUsedTypes.Count -1 do
    begin
      if FUsedTypes.GetItem(I) = P then
      begin
        Result := I;
        exit;
      end;
    end;
    result := Cardinal(-1);
  end;
  procedure ClearRecSubVals;
  var
    I: Longint;
  begin
    for I := 0 to RecSubVals.Count - 1 do
      TIFPSRecordFieldTypeDef(RecSubVals.GetItem(I)).Free;
    RecSubVals.Free;
  end;

  procedure MakeRealFieldOffsets;
  var
    I: Longint;
    O: Cardinal;
    rvv: PIFPSRecordFieldTypeDef;
  begin
    O := 0;
    for I := 0 to RecSubVals.Count - 1 do
    begin
      rvv := RecSubVals.GetItem(I);
      rvv.RealFieldOffset := O;
      O := O + PIFPSType(FAvailableTypes.GetItem(rvv.FType)).TypeSize;
    end;
    p.TypeSize := O;
  end;
  function GetTypeCopy(i: Cardinal): Cardinal;
  begin
    if PIFPSType(FAvailableTypes.GetItem(I)).BaseType = btTypeCopy then
      Result := GetTypeCopy(TIFPSTypeLink(FAvailableTypes.GetItem(I)).LinkTypeNo)
    else
      Result := i;
  end;

  function AddProcedure: Cardinal;
  var
    IsFunction: Boolean;
    VNames, Decl: string;
    modifier: Char;
    VCType: Cardinal;
    x: PIFPSType;
//    xp: TIFPSProceduralType;
    begin
    if FParser.CurrTokenId = CSTII_Function then
      IsFunction := True
    else 
      IsFunction := False;
    Decl := '';
    FParser.Next;
    if FParser.CurrTokenId = CSTI_OpenRound then
    begin
      FParser.Next;
      if FParser.CurrTokenId <> CSTI_CloseRound then
      begin
        while True do
        begin
          if FParser.CurrTokenId = CSTII_Const then
          begin
            Modifier := '@';
            FParser.Next;
          end else
          if FParser.CurrTokenId = CSTII_Var then
          begin
            modifier := '!';
            FParser.Next;
          end
          else
            modifier := '@';
          if FParser.CurrTokenId <> CSTI_Identifier then
          begin
            Result := Cardinal(-1);
            if FParser = Self.FParser then
            MakeError('', ecIdentifierExpected, '');
            exit;
          end;
          VNames := FParser.GetToken + '|';
          FParser.Next;
          while FParser.CurrTokenId = CSTI_Comma do
          begin
            FParser.Next;
            if FParser.CurrTokenId <> CSTI_Identifier then
            begin
              Result := Cardinal(-1);
              if FParser = Self.FParser then
              MakeError('', ecIdentifierExpected, '');
              exit;
            end;
            VNames := VNames + FParser.GetToken + '|';
            FParser.Next;
          end;
          if FParser.CurrTokenId <> CSTI_Colon then
          begin
            Result := Cardinal(-1);
            if FParser = Self.FParser then
            MakeError('', ecColonExpected, '');
            exit;
          end;
          FParser.Next;
          if FParser.CurrTokenId <> CSTI_Identifier then
          begin
            Result := Cardinal(-1);
            if FParser = Self.FParser then
            MakeError('', ecIdentifierExpected, '');
            exit;
          end;
          VCType := FindType(FParser.GetToken);
          if VCType = Cardinal(-1) then
          begin
            if FParser = Self.FParser then
            MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
            Result := Cardinal(-1);
            exit;
          end;
          while Pos('|', VNames) > 0 do
          begin
            Decl := Decl + ' ' + modifier + copy(VNames, 1, Pos('|', VNames) - 1) +
              ' ' + inttostr(VCType);
            Delete(VNames, 1, Pos('|', VNames));
          end;
          FParser.Next;
          if FParser.CurrTokenId = CSTI_CloseRound then
            break;
          if FParser.CurrTokenId <> CSTI_Semicolon then
          begin
            if FParser = Self.FParser then
            MakeError('', ecSemicolonExpected, '');
            Result := Cardinal(-1);
            exit;
          end;
          FParser.Next;
        end; {while}
      end; {if}
      FParser.Next;
      end; {if}
      if IsFunction then
      begin
        if FParser.CurrTokenId <> CSTI_Colon then
        begin
          if FParser = Self.FParser then
          MakeError('', ecColonExpected, '');
          Result := Cardinal(-1);
          exit;
        end;
      FParser.Next;
      if FParser.CurrTokenId <> CSTI_Identifier then
      begin
        Result := Cardinal(-1);
        if FParser = Self.FParser then
        MakeError('', ecIdentifierExpected, '');
        exit;
      end;
      VCType := FindType(FParser.GetToken);
      if VCType = Cardinal(-1) then
      begin
        if FParser = Self.FParser then
        MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
        Result := Cardinal(-1);
        exit;
      end;
      FParser.Next;
    end
    else
      VCType := Cardinal(-1);
    Decl := inttostr(VCType) + Decl;
    X := TIFPSProceduralType.Create;
    x.Name := Name;
    x.BaseType := btProcPtr;
    x.DeclarePosition := FParser.CurrTokenPos;
    x.TypeSize := 1;
    TIFPSProceduralType(x).ProcDef := Decl;
    FAvailableTypes.Add(X);
    Result := FAvailableTypes.Count -1;
  end; {AddProcedure}

begin
  if (FParser.CurrTokenID = CSTII_Function) or (FParser.CurrTokenID = CSTII_Procedure) then
  begin
     Result := AddProcedure;
     Exit;
  end else if FParser.CurrTokenId = CSTI_OpenRound then
  begin
    FParser.Next;
    L := 0;
    P := TIFPSEnumType.Create;
    P.Name := Name;
    p.BaseType := btEnum;
    p.TypeSize := 1;
    p.DeclarePosition := FParser.CurrTokenPos;
    FAvailableTypes.Add(p);

    TypeNo := FAvailableTypes.Count -1;
    repeat
      if FParser.CurrTokenId <> CSTI_Identifier then
      begin
        if FParser = Self.FParser then
        MakeError('', ecIdentifierExpected, '');
        Result := Cardinal(-1);
        exit;
      end;
      s := FParser.GetToken;
      if IsDuplicate(s) then
      begin
        if FParser = Self.FParser then
        MakeError('', ecDuplicateIdentifier, s);
        Result := Cardinal(-1);
        Exit;
      end;
      AddConstant(s, TypeNo)^.Value.tu32 := L;
      Inc(L);
      FParser.Next;
      if FParser.CurrTokenId = CSTI_CloseRound then
        Break
      else if FParser.CurrTokenId <> CSTI_Comma then
      begin
        if FParser = Self.FParser then
        MakeError('', ecCloseRoundExpected, '');
        Result := Cardinal(-1);
        Exit;
      end;
      FParser.Next;
    until False;
    FParser.Next;
    TIFPSEnumType(p).HighValue := L-1;
    Result := TypeNo;
    exit;
  end else
  if FParser.CurrTokenId = CSTII_Array then
  begin
    FParser.Next;
    if FParser.CurrTokenId <> CSTII_Of then
    begin
      if FParser = Self.FParser then
      MakeError('', ecOfExpected, '');
      Result := Cardinal(-1);
      exit;
    end;
    FParser.Next;
    L := ReadType('', FParser);
    if L = -1 then
    begin
      if FParser = Self.FParser then
      MakeError('', ecUnknownIdentifier, '');
      Result := Cardinal(-1);
      exit;
    end;
    if Name = '' then
    begin
      TypeNo := ATNUT(l);
      if TypeNo <> Cardinal(-1) then
      begin
        for h := 0 to FUsedTypes.Count -1 do
        begin
          p := FUsedTypes.GetItem(H);
          if (p.BaseType = btArray) and (TIFPSArrayType(p).ArrayTypeNo = TypeNo) and (Copy(p.Name, 1, 1) <> '!') then
          begin
            for l := 0 to FAvailableTypes.Count -1 do
            begin
              if FAvailableTypes.GetItem(L) = P then
              begin
                Result := l;
                exit;
              end;
            end;
            if FParser = Self.FParser then
            MakeError('', ecInternalError, '0001C');
            Result := Cardinal(-1);
            Exit;
          end;
        end;
      end;
      for h := 0 to FAvailableTypes.Count -1 do
      begin
        p := FAvailableTypes.GetItem(H);
        if (p.BaseType = btArray) and (TIFPSArrayType(p).ArrayTypeNo = Cardinal(L)) and (not p.Used) and (Copy(p.Name, 1, 1) <> '!') then
        begin
          Result := H;
          Exit;
        end;
      end;
    end;
    p := TIFPSArrayType.Create;
    p.Name := Name;
    p.BaseType := btArray;
    p.TypeSize := 1;
    p.DeclarePosition := FParser.CurrTokenPos;
    TIFPSArrayType(p).ArrayTypeNo := L;
    FAvailableTypes.Add(p);
    Result := Cardinal(FAvailableTypes.Count -1);
    Exit;
  end
  else if FParser.CurrTokenId = CSTII_Record then
  begin
    FParser.Next;
    RecSubVals := TIfList.Create;
    repeat
      repeat
        if FParser.CurrTokenId <> CSTI_Identifier then
        begin
          ClearRecSubVals;
          if FParser = Self.FParser then
          MakeError('', ecIdentifierExpected, '');
          Result := Cardinal(-1);
          exit;
        end;
        FieldName := FParser.GetToken;
        s := S+FieldName+'|';
        FParser.Next;
        TypeNo := MakeHash(S);
        for l := 0 to RecSubVals.Count - 1 do
        begin
          if (PIFPSRecordFieldTypeDef(RecSubVals.GetItem(l)).FieldNameHash = Longint(TypeNo)) and
            (PIFPSRecordFieldTypeDef(RecSubVals.GetItem(l)).FieldName = s) then
          begin
            if FParser = Self.FParser then
              MakeError('', ecDuplicateIdentifier, FParser.OriginalToken);
            ClearRecSubVals;
            Result := Cardinal(-1);
            exit;
          end;
        end;
        if FParser.CurrTokenID = CSTI_Colon then Break else
        if FParser.CurrTokenID <> CSTI_Comma then
        begin
          if FParser = Self.FParser then
            MakeError('', ecColonExpected, '');
          ClearRecSubVals;
          Result := Cardinal(-1);
          exit;
        end;
        FParser.Next;
      until False;
      FParser.Next;
      l := ReadType('', FParser);
      if L = -1 then
      begin
        ClearRecSubVals;
        Result := Cardinal(-1);
        exit;
      end;
      P := FAvailableTypes.GetItem(L);
      if p.BaseType = BtTypeCopy then
        L := TIFPSTypeLink(p).LinkTypeNo;
      if FParser.CurrTokenId <> CSTI_Semicolon then
      begin
        ClearRecSubVals;
        if FParser = Self.FParser then
        MakeError('', ecSemicolonExpected, '');
        Result := Cardinal(-1);
        exit;
      end; {if}
      FParser.Next;
      while Pos('|', s) > 0 do
      begin
        fieldname := copy(s, 1, pos('|', s)-1);
        Delete(s, 1, length(FieldName)+1);
        rvv := TIFPSRecordFieldTypeDef.Create;
        rvv.FieldName := fieldname;
        rvv.FType := l;
        RecSubVals.Add(rvv);
      end;
    until FParser.CurrTokenId = CSTII_End;
    FParser.Next; // skip CSTII_End
    P := TIFPSRecordType.Create;
    p.Name := Name;
    p.BaseType := btRecord;
    p.DeclarePosition := FParser.CurrTokenPos;
    MakeRealFieldOffsets;
    for l := 0 to RecSubVals.Count -1 do
    begin
      rvv := RecSubVals.GetItem(l);
      with TIFPSRecordType(p).AddRecVal do
      begin
        FieldName := rvv.FieldName;
        RealFieldOffset := rvv.RealFieldOffset;
        FType := rvv.FType;
      end;
      rvv.Free;
    end;
    RecSubVals.Free;
    FAvailableTypes.Add(p);
    Result := FAvailableTypes.Count -1;
    Exit;
  end else if FParser.CurrTokenId = CSTI_Identifier then
  begin
    s := FParser.GetToken;
    h := MakeHash(s);
    TypeNo := Cardinal(-1);
    for l := 0 to FAvailableTypes.Count - 1 do
    begin
      p2 := FAvailableTypes.GetItem(l);
      if (p2.NameHash = h) and (p2.Name = s) then
      begin
        FParser.Next;
        TypeNo := l;
        if p2.BaseType = BtTypeCopy then
          TypeNo := TIFPSTypeLink(p2).LinkTypeNo;
        Break;
      end;
    end;
    if TypeNo = Cardinal(-1) then
    begin
      Result := Cardinal(-1);
      if FParser = Self.FParser then
      MakeError('', ecUnknownType, FParser.OriginalToken);
      exit;
    end;
    if Name <> '' then
    begin
      p := TIFPSTypeLink.Create;
      p.Name := Name;
      p.BaseType := BtTypeCopy;
      p.DeclarePosition := FParser.CurrTokenPos;
      TIFPSTypeLink(p).LinkTypeNo := TypeNo;
      FAvailableTypes.Add(p);
      Result := FAvailableTypes.Count -1;
      Exit;
    end else
    begin
      Result := TypeNo;
      exit;
    end;
  end;
  Result := Cardinal(-1);
  if FParser = Self.FParser then
  MakeError('', ecIdentifierExpected, '');
  Exit;
end;


function TIFPSPascalCompiler.DoVarBlock(proc: TIFPSInternalProcedure): Boolean;
var
  VarName, s: string;
  VarType: Cardinal;
  VarNo: Cardinal;
  v: PIFPSVar;
  vp: PIFPSProcVar;

  function VarIsDuplicate(const s: string): Boolean;
  var
    h, l: Longint;
    x: TIFPSProcedure;
    v: string;
  begin
    h := MakeHash(s);
    if (s = 'RESULT') then
    begin
      Result := True;
      exit;
    end;

    for l := 0 to FAvailableTypes.Count - 1 do
    begin
      if (PIFPSType(FAvailableTypes.GetItem(l)).NameHash = h) and
        (PIFPSType(FAvailableTypes.GetItem(l)).Name = s) then
      begin
        Result := True;
        exit;
      end;
    end;

    for l := 0 to FProcs.Count - 1 do
    begin
      x := FProcs.GetItem(l);
      if x.ClassType = TIFPSInternalProcedure then
      begin
        if (h = TIFPSInternalProcedure(x).NameHash) and (s = TIFPSInternalProcedure(x).Name) then
        begin
          Result := True;
          exit;
        end;
      end
      else
      begin
        if (TIFPSExternalProcedure(x).RegProc.NameHash = h) and (TIFPSExternalProcedure(x).RegProc.Name = s) then
        begin
          Result := True;
          exit;
        end;
      end;
    end;
    if proc <> nil then
    begin
      for l := 0 to proc.ProcVars.Count - 1 do
      begin
        if (PIFPSProcVar(proc.ProcVars.GetItem(l)).NameHash = h) and
          (PIFPSVar(proc.ProcVars.GetItem(l))^.Name = s) then
        begin
          Result := True;
          exit;
        end;
      end;
    end
    else
    begin
      for l := 0 to FVars.Count - 1 do
      begin
        if (PIFPSVar(FVars.GetItem(l))^.NameHash = h) and
          (PIFPSVar(FVars.GetItem(l))^.Name = s) then
        begin
          Result := True;
          exit;
        end;
      end;
    end;
    v := VarName;
    while Pos('|', v) > 0 do
    begin
      if copy(v, 1, Pos('|', v) - 1) = s then
      begin
        Result := True;
        exit;
      end;
      Delete(v, 1, Pos('|', v));
    end;
    for l := 0 to FConstants.Count -1 do
    begin
      if (PIFPSConstant(FConstants.GetItem(l))^.NameHash = h) and
        (PIFPSConstant(FConstants.GetItem(l))^.Name = s) then
      begin
        Result := TRue;
        exit;
      end;
    end;
    Result := False;
  end;

begin
  Result := False;
  FParser.Next; // skip CSTII_Var
  if FParser.CurrTokenId <> CSTI_Identifier then
  begin
    MakeError('', ecIdentifierExpected, '');
    exit;
  end;
  repeat
    if VarIsDuplicate(FParser.GetToken) then
    begin
      MakeError('', ecDuplicateIdentifier, FParser.OriginalToken);
      exit;
    end;
    VarName := FParser.GetToken + '|';
    Varno := 0;
    if @FOnUseVariable <> nil then
    begin
      if Proc <> nil then
        FOnUseVariable(Self, ivtVariable, Proc.ProcVars.Count + VarNo, FProcs.Count -1, FParser.CurrTokenPos, '')
      else
        FOnUseVariable(Self, ivtGlobal, FVars.Count + VarNo, Cardinal(-1), FParser.CurrTokenPos, '')
    end;
    FParser.Next;
    while FParser.CurrTokenId = CSTI_Comma do
    begin
      FParser.Next;
      if FParser.CurrTokenId <> CSTI_Identifier then
      begin
        MakeError('', ecIdentifierExpected, '');
      end;
      if VarIsDuplicate(FParser.GetToken) then
      begin
        MakeError('', ecDuplicateIdentifier, FParser.OriginalToken);
        exit;
      end;
      VarName := VarName + FParser.GetToken + '|';
      Inc(varno);
      if @FOnUseVariable <> nil then
      begin
        if Proc <> nil then
          FOnUseVariable(Self, ivtVariable, Proc.ProcVars.Count + VarNo, FProcs.Count -1, FParser.CurrTokenPos, '')
        else
          FOnUseVariable(Self, ivtGlobal, FVars.Count + VarNo, Cardinal(-1), FParser.CurrTokenPos, '')
      end;
      FParser.Next;
    end;
    if FParser.CurrTokenId <> CSTI_Colon then
    begin
      MakeError('', ecColonExpected, '');
      exit;
    end;
    FParser.Next;
    VarType := at2ut(ReadType('', FParser));
    if VarType = Cardinal(-1) then
    begin
      exit;
    end;
    while Pos('|', VarName) > 0 do
    begin
      s := copy(VarName, 1, Pos('|', VarName) - 1);
      Delete(VarName, 1, Pos('|', VarName));
      if proc = nil then
      begin
        New(v);
        v^.Used := False;
        v^.Name := s;
        v^.NameHash := MakeHash(v^.Name);
        v^.DeclarePosition := FParser.CurrTokenPos;
        
        v^.FType := VarType;
        FVars.Add(v);
      end
      else
      begin
        vp := TIFPSProcVar.Create;
        vp.Name := s;
        vp.aType := VarType;
        vp.DeclarePosition := FParser.CurrTokenPos;
        proc.ProcVars.Add(vp);
      end;
    end;
    if FParser.CurrTokenId <> CSTI_Semicolon then
    begin
      MakeError('', ecSemicolonExpected, '');
      exit;
    end;
    FParser.Next;
  until FParser.CurrTokenId <> CSTI_Identifier;
  Result := True;
end;

function TIFPSPascalCompiler.NewProc(const Name: string): TIFPSInternalProcedure;
begin
  Result := TIFPSInternalProcedure.Create;
  Result.Decl := '-1';
  Result.Name := Name;
  Result.DeclarePosition := FParser.CurrTokenPos;
  FProcs.Add(Result);
end;

function TIFPSPascalCompiler.ProcessLabel(Proc: TIFPSInternalProcedure): Boolean;
var
  CurrLabel: string;
  function IsProcDuplic(const s: string): Boolean;
  var
    i: Longint;
    h: Longint;
    u: string;
  begin
    h := MakeHash(s);
    if s = 'RESULT' then
      Result := True
    else if Proc.Name = s then
      Result := True
    else if IsDuplicate(s) then
      Result := True
    else
    begin
      u := Proc.Decl;
      while Length(u) > 0 do
      begin
        if D1(GRFW(u)) = s then
        begin
          Result := True;
          exit;
        end;
        GRFW(u);
      end;
      for i := 0 to Proc.ProcVars.Count -1 do
      begin
        if (PIFPSProcVar(Proc.ProcVars.GetItem(I)).NameHash = h) and (PIFPSProcVar(Proc.ProcVars.GetItem(I)).Name = s) then
        begin
          Result := True;
          exit;
        end;
      end;
      for i := 0 to Proc.FLabels.Count -1 do
      begin
        u := Proc.FLabels.GetItem(i);
        delete(u, 1, 4);
        if Longint((@u[1])^) = h then
        begin
          delete(u, 1, 4);
          if u = s then
          begin
            Result := True;
            exit;
          end;
        end;
      end;
      Result := False;
    end;
  end;
begin
  FParser.Next;
  while true do
  begin
    if FParser.CurrTokenId <> CSTI_Identifier then
    begin
      MakeError('', ecIdentifierExpected, '');
      Result := False;
      exit;
    end;
    CurrLabel := FParser.GetToken;
    if IsDuplicate(CurrLabel) or IsProcDuplic(CurrLabel) then
    begin
      MakeError('', ecDuplicateIdentifier, '');
      Result := False;
      exit;
    end;
    FParser.Next;
    Proc.FLabels.Add(#$FF#$FF#$FF#$FF+mi2s(MakeHash(CurrLabel))+CurrLabel);
    if FParser.CurrTokenId = CSTI_Semicolon then
    begin
      FParser.Next;
      Break;
    end;
    if FParser.CurrTokenId <> CSTI_Comma then
    begin
      MakeError('', ecCommaExpected, '');
      Result := False;
      exit;
    end;
    FParser.Next;
  end;
  Result := True;
end;

procedure TIFPSPascalCompiler.Debug_SavePosition(ProcNo: Cardinal; Proc: TIFPSInternalProcedure; TokenPos: Cardinal);
begin
  WriteDebugData(#4 + mi2s(ProcNo) + mi2s(Length(Proc.Data)) + mi2s(TokenPos));
end;
procedure TIFPSPascalCompiler.Debug_WriteParams(ProcNo: Cardinal; Proc: TIFPSInternalProcedure);
var
  I: Longint;
  s, d: string;
begin
  s := #2 + mi2s(ProcNo);
  d := Proc.Decl;
  if GRFW(d) <> '-1' then
  begin
    s := s + 'RESULT'+#1;
  end;
  while Length(d) > 0 do
  begin
    s := s + D1(GRFW(d)) + #1;
    GRFW(d);
  end;
  s := s + #0#3 + mi2s(ProcNo);
  for I := 0 to Proc.ProcVars.Count - 1 do
  begin
    s := s + PIFPSProcVar(Proc.ProcVars.GetItem(I)).Name + #1;
  end;
  s := s + #0;
  WriteDebugData(s);
end;



function TIFPSPascalCompiler.ProcessFunction(AlwaysForward: Boolean): Boolean;
var
  FunctionType: TFuncType;
  FunctionName: string;
  FunctionParamNames: string;
  FunctionTempType: Cardinal;
  ParamNo: Cardinal;
  FunctionDecl: string;
  modifier: Char;
  Func: TIFPSInternalProcedure;
  F2: TIFPSProcedure;
  EPos: Cardinal;
  pp: TIFPSRegProc;
  pp2: TIFPSExternalProcedure;
  FuncNo, I: Longint;
  procedure CheckVars(Func: TIFPSInternalProcedure);
  var
    i: Integer;
    p: PIFPSProcVar;
  begin
    for i := 0 to Func.ProcVars.Count -1 do
    begin
      p := Func.ProcVars.GetItem(I);
      if not p.Used then
      begin
        MakeHint('', ehVariableNotUsed, p.Name)^.Position := p.DeclarePosition;
      end;
    end;
    if (not Func.ResultUsed) and (Fw(Func.Decl) <> '-1') then
    begin
      MakeHint('', ehVariableNotUsed, 'RESULT')^.Position := Func.DeclarePosition;
    end;
  end;

  function IsDuplic(const s: string): Boolean;
  var
    i: Longint;
    u: string;
  begin
    if s = 'RESULT' then
      Result := True
    else if FunctionName = s then
      Result := True
    else if IsDuplicate(s) then
      Result := True
    else
    begin
      u := FunctionDecl;
      while Length(u) > 0 do
      begin
        if D1(GRFW(u)) = s then
        begin
          Result := True;
          exit;
        end;
        GRFW(u);
      end;
      u := FunctionParamNames;
      while Pos('|', u) > 0 do
      begin
        if copy(u, 1, Pos('|', u) - 1) = s then
        begin
          Result := True;
          exit;
        end;
        Delete(u, 1, Pos('|', u));
      end;
      if Func = nil then
      begin
        result := False;
        exit;
      end;
      for i := 0 to Func.ProcVars.Count -1 do
      begin
        if s = PIFPSProcVar(Func.ProcVars.GetItem(I)).Name then
        begin
          Result := True;
          exit;
        end;
      end;
      for i := 0 to Func.FLabels.Count -1 do
      begin
        u := Func.FLabels.GetItem(i);
        delete(u, 1, 4);
        if u = s then
        begin
          Result := True;
          exit;
        end;
      end;
      Result := False;
    end;
  end;
  procedure WriteProcVars(t: TIfList);
  var
    l: Longint;
    v: PIFPSProcVar;
  begin
    for l := 0 to t.Count - 1 do
    begin
      v := t.GetItem(l);
      Func.Data := Func.Data  + chr(cm_pt)+ mi2s(v.AType);
    end;
  end;

begin
  if FParser.CurrTokenId = CSTII_Procedure then
    FunctionType := ftProc
  else
    FunctionType := ftFunc;
  Func := nil;
  FParser.Next;
  Result := False;
  if FParser.CurrTokenId <> CSTI_Identifier then
  begin
    MakeError('', ecIdentifierExpected, '');
    exit;
  end;
  EPos := FParser.CurrTokenPos;
  FunctionName := FParser.GetToken;
  FuncNo := -1;
  for i := 0 to FProcs.Count -1 do
  begin
    f2 := FProcs.GetItem(i);
    if (f2.ClassType = TIFPSInternalProcedure) and (TIFPSInternalProcedure(f2).Name = FunctionName) and (TIFPSInternalProcedure(f2).Forwarded) then
    begin
      Func := FProcs.GetItem(i);
      FuncNo := i;
      Break;
    end;
  end;
  if (Func = nil) and IsDuplicate(FunctionName) then
  begin
    MakeError('', ecDuplicateIdentifier, FunctionName);
    exit;
  end;
  FParser.Next;
  FunctionDecl := '';
  if FParser.CurrTokenId = CSTI_OpenRound then
  begin
    FParser.Next;
    if FParser.CurrTokenId = CSTI_CloseRound then
    begin
      FParser.Next;
    end
    else
    begin
      if FunctionType = ftFunc then
        ParamNo := 1
      else
        ParamNo := 0;
      while True do
      begin
        if FParser.CurrTokenId = CSTII_Var then
        begin
          modifier := '!';
          FParser.Next;
        end
        else
          modifier := '@';
        if FParser.CurrTokenId <> CSTI_Identifier then
        begin
          MakeError('', ecIdentifierExpected, '');
          exit;
        end;
        if IsDuplic(FParser.GetToken) then
        begin
          MakeError('', ecDuplicateIdentifier, FParser.OriginalToken);
          exit;
        end;
        FunctionParamNames := FParser.GetToken + '|';
        if @FOnUseVariable <> nil then
        begin
          FOnUseVariable(Self, ivtParam, ParamNo, FProcs.Count, FParser.CurrTokenPos, '');
        end;
        inc(ParamNo);
        FParser.Next;
        while FParser.CurrTokenId = CSTI_Comma do
        begin
          FParser.Next;
          if FParser.CurrTokenId <> CSTI_Identifier then
          begin
            MakeError('', ecIdentifierExpected, '');
            exit;
          end;
          if IsDuplic(FParser.GetToken) then
          begin
            MakeError('', ecDuplicateIdentifier, '');
            exit;
          end;
          if @FOnUseVariable <> nil then
          begin
            FOnUseVariable(Self, ivtParam, ParamNo, FProcs.Count, FParser.CurrTokenPos, '');
          end;
          inc(ParamNo);
          FunctionParamNames := FunctionParamNames + FParser.GetToken +
            '|';
          FParser.Next;
        end;
        if FParser.CurrTokenId <> CSTI_Colon then
        begin
          MakeError('', ecColonExpected, '');
          exit;
        end;
        FParser.Next;
        FunctionTempType := at2ut(ReadType('', FParser));
        if FunctionTempType = Cardinal(-1) then
        begin
          exit;
        end;
        while Pos('|', FunctionParamNames) > 0 do
        begin
          FunctionDecl := FunctionDecl + ' ' + modifier +
            copy(FunctionParamNames, 1, Pos('|', FunctionParamNames) - 1)
            + ' '
            + inttostr(Longint(FunctionTempType));
          Delete(FunctionParamNames, 1, Pos('|', FunctionParamNames));
        end;
        if FParser.CurrTokenId = CSTI_CloseRound then
          break;
        if FParser.CurrTokenId <> CSTI_Semicolon then
        begin
          MakeError('', ecSemicolonExpected, '');
          exit;
        end;
        FParser.Next;
      end;
      FParser.Next;
    end;
  end;
  if FunctionType = ftFunc then
  begin
    if FParser.CurrTokenId <> CSTI_Colon then
    begin
      MakeError('', ecColonExpected, '');
      exit;
    end;
    FParser.Next;
    FunctionTempType := at2ut(ReadType('', FParser));
    if FunctionTempType = Cardinal(-1) then
      exit;
    FunctionDecl := inttostr(Longint(FunctionTempType)) + FunctionDecl;
  end
  else
    FunctionDecl := '-1' + FunctionDecl;
  if FParser.CurrTokenId <> CSTI_Semicolon then
  begin
    MakeError('', ecSemicolonExpected, '');
    exit;
  end;
  FParser.Next;
  if (Func = nil) and (FParser.CurrTokenID = CSTII_External) then
  begin
    FParser.Next;
    if FParser.CurrTokenID <> CSTI_String then
    begin
      MakeError('', ecStringExpected, '');
      exit;
    end;
    FunctionParamNames := FParser.GetToken;
    FunctionParamNames := copy(FunctionParamNames, 2, length(FunctionParamNames) - 2);
    FParser.Next;
    if FParser.CurrTokenID <> CSTI_Semicolon then
    begin
      MakeError('', ecSemicolonExpected, '');
      exit;
    end;
    FParser.Next;
    pp := FOnExternalProc(Self, FunctionName, FunctionDecl, FunctionParamNames);
    if pp = nil then
    begin
      MakeError('', ecCustomError, '');
      exit;
    end;
    pp2 := TIFPSExternalProcedure.Create;
    pp2.RegProc := pp;
    FProcs.Add(pp2);
    FRegProcs.Add(pp);
    Result := True;
    Exit;
  end else if (FParser.CurrTokenID = CSTII_Forward) or AlwaysForward then
  begin
    if Func <> nil then
    begin
      MakeError('', ecBeginExpected, '');
      exit;
    end;
    if not AlwaysForward then
    begin
      FParser.Next;
      if FParser.CurrTokenID  <> CSTI_Semicolon then
      begin
        MakeError('', ecSemicolonExpected, '');
        Exit;
      end;
      FParser.Next;
    end;
    Func := NewProc(FunctionName);
    Func.Forwarded := True;
    Func.DeclarePosition := EPos;
    Func.Decl := FunctionDecl;
    Result := True;
    exit;
  end;
  if (Func = nil) then
  begin
    Func := NewProc(FunctionName);
    Func.Decl := FunctionDecl;
    Func.DeclarePosition := EPos;
    FuncNo := FProcs.Count -1;
  end else begin
    if FunctionDecl <> Func.Decl then
    begin
      MakeError('', ecForwardParameterMismatch, '');
      Result := false;
      exit;
    end;
    Func.Forwarded := False;
  end;
  if FParser.CurrTokenID = CSTII_Export then
  begin
    FParser.Next;
    if FParser.CurrTokenID <> CSTI_Semicolon then
    begin
      MakeError('', ecSemicolonExpected, '');
      exit;
    end;
    FParser.Next;
    Func.FExport := etExportName;
  end;
  while FParser.CurrTokenId <> CSTII_Begin do
  begin
    if FParser.CurrTokenId = CSTII_Var then
    begin
      if not DoVarBlock(Func) then
        exit;
    end else if FParser.CurrTokenId = CSTII_Label then
    begin
      if not ProcessLabel(Func) then
        Exit;
    end else
    begin
      MakeError('', ecBeginExpected, '');
      exit;
    end;
  end;
  Debug_WriteParams(FuncNo, Func);
  WriteProcVars(Func.ProcVars);
  if not ProcessSub(tProcBegin, FuncNo, Func) then
  begin
    exit;
  end;
  CheckVars(Func);
  ProcessLabelForwards(Func);
  Result := True;
end;

function TIFPSPascalCompiler.DoTypeBlock(FParser: TIfPascalParser): Boolean;
var
  VName: string;
begin
  Result := False;
  FParser.Next;
  if FParser.CurrTokenId <> CSTI_Identifier then
  begin
    MakeError('', ecIdentifierExpected, '');
    exit;
  end;
  repeat
    VName := FParser.GetToken;
    if IsDuplicate(VName) then
    begin
      MakeError('', ecDuplicateIdentifier, FParser.OriginalToken);
      exit;
    end;

    FParser.Next;
    if FParser.CurrTokenId <> CSTI_Equal then
    begin
      MakeError('', ecIsExpected, '');
      exit;
    end;
    FParser.Next;
    if ReadType(VName, FParser) = Cardinal(-1) then
    begin
      Exit;
    end;
    if FParser.CurrTokenID <> CSTI_Semicolon then
    begin
      MakeError('', ecSemicolonExpected, '');
      Exit;
    end;
    FParser.Next;
  until FParser.CurrTokenId <> CSTI_Identifier;
  Result := True;
end;


function TIFPSPascalCompiler.ProcessSub(FType: TSubOptType; ProcNo: Cardinal; proc: TIFPSInternalProcedure): Boolean;


  procedure Debug_WriteLineEx(TokenPos: Cardinal);
  var
    b: Boolean;
  begin
    if @FOnWriteLine <> nil then begin
      b := FOnWriteLine(Self, TokenPos);
    end else
      b := true;
    if b then Debug_SavePosition(ProcNo, proc, TokenPos);
  end;

  procedure Debug_WriteLine;
  begin
    Debug_WriteLineEx(FParser.CurrTokenPos);
  end;

  procedure WriteCommand(b: Byte);
  begin
    Proc.Data := Proc.Data + Char(b);
  end;

  procedure WriteByte(b: Byte);
  begin
    Proc.Data := Proc.Data + Char(b);
  end;

  procedure WriteData(const Data; Len: Longint);
  begin
    SetLength(Proc.FData, Length(Proc.FData) + Len);
    Move(Data, Proc.FData[Length(Proc.FData) - Len + 1], Len);
  end;

  function ReadReal(const s: string): PIfRVariant;
  var
    C: Integer;
  begin
    New(Result);
    InitializeVariant(Result, GetType(btExtended), btExtended);
    Val(s, Result^.textended, C);
  end;

  function ReadString: PIfRVariant;
  {$IFNDEF NOWIDESTRING}var wchar: Boolean;{$ENDIF}

    function ParseString: {$IFNDEF NOWIDESTRING}widestring{$ELSE}string{$ENDIF};
    var
      temp3: {$IFNDEF NOWIDESTRING}widestring{$ELSE}string{$ENDIF};

      function ChrToStr(s: string): {$IFNDEF NOWIDESTRING}widechar{$ELSE}char{$ENDIF};
      var
        w: Longint;
      begin
        Delete(s, 1, 1); {First char : #}
        w := StrToInt(s);
        Result := {$IFNDEF NOWIDESTRING}widechar{$ELSE}char{$ENDIF}(w);
        {$IFNDEF NOWIDESTRING}if w > $FF then wchar := true;{$ENDIF}
      end;

      function PString(s: string): string;
      begin
        s := copy(s, 2, Length(s) - 2);
        PString := s;
      end;
    begin
      temp3 := '';
      while (FParser.CurrTokenId = CSTI_String) or (FParser.CurrTokenId = CSTI_Char) do
      begin
        if FParser.CurrTokenId = CSTI_String then
        begin
          temp3 := temp3 + PString(FParser.GetToken);
          FParser.Next;
          if FParser.CurrTokenId = CSTI_String then
            temp3 := temp3 + #39;
        end {if}
        else
        begin
          temp3 := temp3 + ChrToStr(FParser.GetToken);
          FParser.Next;
        end; {else if}
      end; {while}
      ParseString := temp3;
    end;
  {$IFNDEF NOWIDESTRING}
  var
    w: widestring;
    s: string;
  begin
    w := ParseString;
    if wchar then
    begin
      New(Result);
      if Length(w) = 1 then
      begin
        InitializeVariant(Result, GetType(btwidechar), btwidechar);
        Result^.twidechar := w[1];
      end else begin
        InitializeVariant(Result, GetType(btwidestring), btwidestring);
        tbtwidestring(Result^.twidestring) := w;
       end;
    end else begin
      s := w;
      New(Result);
      if Length(s) = 1 then
      begin
        InitializeVariant(Result, GetType(btchar), btchar);
        Result^.tchar := s[1];
      end else begin
        InitializeVariant(Result, GetType(btstring), btstring);
        tbtstring(Result^.tstring) := s;
      end;
    end;
  end;
  {$ELSE}
  var
    s: string;
  begin
    s := ParseString;
    New(Result);
    if Length(s) = 1 then
    begin
      InitializeVariant(Result, GetType(btchar), btchar);
      Result^.tchar := s[1];
    end else begin
      InitializeVariant(Result, GetType(btstring), btstring);
      tbtstring(Result^.tstring) := s;
    end;
  end;
  {$ENDIF}


  function ReadInteger(const s: string): PIfRVariant;
  {$IFNDEF NOINT64}
  var
    R: Int64;
  begin
    r := StrToInt64Def(s, 0);
    New(Result);
    if (r >= Low(Integer)) and (r <= High(Integer)) then
    begin
      InitializeVariant(Result, GetType(bts32), bts32);
      Result^.ts32 := r;
    end else if (r <= $FFFFFFFF) then
    begin
      InitializeVariant(Result, GetType(btu32), btu32);
      Result^.tu32 := r;
    end else
    begin
      InitializeVariant(Result, GetType(bts64), bts64);
      Result^.ts64 := r;
    end;
  end;
  {$ELSE}
  var
    r: Longint;
begin
    r := StrToIntDef(s, 0);
    New(Result);
    InitializeVariant(Result, GetType(bts32), bts32);
    Result^.ts32 := r;
  end;
  {$ENDIF}

  procedure WriteLong(l: Cardinal);
  begin
    WriteData(l, 4);
  end;

  procedure WriteVariant(p: PIfRVariant);
  var
    px: PIFPSType;
  begin
    WriteLong(p^.FType);
    case p.BaseType of
    {$IFNDEF NOWIDESTRING}
    btWideString:
      begin
        WriteLong(Length(tbtWideString(p^.twidestring)));
        WriteData(tbtwidestring(p^.twidestring)[1], 2*Length(tbtWideString(p^.twidestring)));
      end;
    btWideChar: WriteData(p^.twidechar, 2);
    {$ENDIF}
    btSingle: WriteData(p^.tsingle, sizeof(tbtSingle));
    btDouble: WriteData(p^.tsingle, sizeof(tbtDouble));
    btExtended: WriteData(p^.tsingle, sizeof(tbtExtended));
    btChar: WriteData(p^.tchar, 1);
    btString:
      begin
        WriteLong(Length(tbtString(p^.tstring)));
        WriteData(tbtString(p^.tstring)[1], Length(tbtString(p^.tstring)));
      end;
    btenum:
      begin
        px := FUsedTypes.GetItem(p^.FType);
        if TIFPSEnumType(px).HighValue <=256 then
          WriteData(p^.tu32, 1)
        else if TIFPSEnumType(px).HighValue <=65536 then
          WriteData(p^.tu32, 2)
        else
          WriteData(p^.tu32, 4);
      end;
    bts8,btu8: WriteData(p^.tu8, 1);
    bts16,btu16: WriteData(p^.tu16, 2);
    bts32,btu32: WriteData(p^.tu32, 4);
    {$IFNDEF NOINT64}
    bts64: WriteData(p^.ts64, 8);
    {$ENDIF}
    end;
  end;

  function GetParamType(I: Longint): Cardinal;
  var
    u, n: string;
  begin
    u := Proc.Decl;
    Inc(I);
    n := GRFW(u);
    if (I = 0) and (n <> '-1') then
    begin
      Result := StrToIntDef(n, -1);
      exit;
    end
    else if n <> '-1' then
      Inc(I);
    while I < 0 do
    begin
      GRFW(u);
      GRFW(u);
      Inc(I);
    end;
    GRFW(u);
    Result := StrToIntDef(GRFW(u), -1);
  end;
  function GetRecordTypeNo(x: PIFPSValue): Cardinal;
  var
    rr: PIFRecField;
  begin
    rr := x^.RecField.GetItem(x^.RecField.Count - 1);
    if rr^.FKind = 3 then
      rr := x^.RecField.GetItem(x^.RecField.Count - 2);
    Result := rr^.FType;
  end;
{$IFDEF DEBUG}
  var
    rdebug: array of Pointer;
{$ENDIF}
  function AllocStackReg(FType: Cardinal): PIFPSValue;
  var
    x: PIFPSProcVar;
  begin
    x := TIFPSProcVar.Create;
    x.DeclarePosition := FParser.CurrTokenPos;
    x.Name := '';
    x.AType := FType;
    Proc.ProcVars.Add(x);
    New(Result);
    Result^.FType := CVAL_AllocatedStackReg;
    Result^.DPos := FParser.CurrTokenPos;
    Result^.Address := IFPSAddrStackStart + Proc.ProcVars.Count;
    Result^.RecField := nil;
    Result^.Modifiers := 0;
    WriteCommand(Cm_Pt);
    WriteLong(FType);
    {$IFDEF DEBUG}SetLength(rdebug, length(rdebug)+1);rdebug[length(rdebug)-1] := Result; {$ENDIF}
  end;

  function AllocStackReg2(FType: Cardinal): PIFPSValue;
  var
    x: PIFPSProcVar;
  begin
    x := TIFPSProcVar.Create;
    x.DeclarePosition := FParser.CurrTokenPos;
    x.Name := '';
    x.AType := FType;
    Proc.ProcVars.Add(x);
    New(Result);
    Result^.FType := CVAL_AllocatedStackReg;
    Result^.RecField := nil;
    Result^.Modifiers := 0;
    Result^.Address := IFPSAddrStackStart + Proc.ProcVars.Count;
    {$IFDEF DEBUG}SetLength(rdebug, length(rdebug)+1);rdebug[length(rdebug)-1] := Result; {$ENDIF}
  end;
  function WriteCalculation(InData, OutReg: PIFPSValue): Boolean; forward;

  procedure DisposeStackReg(p: PIFPSValue);
  begin
    {$IFDEF DEBUG}
    if (rdebug[length(rdebug)-1] <> p) then
    begin
      asm int 3; end;
    end;
    SetLength(rdebug, length(rdebug)-1);
    {$ENDIF}

    TIFPSProcVar(Proc.ProcVars.GetItem(p^.Address - IFPSAddrStackStart - 1)).Free;
    Proc.ProcVars.Delete(Proc.ProcVars.Count - 1);
    DisposePValue(p);
    WriteCommand(CM_PO);
  end;
  function GetTypeNo(p: PIFPSValue): Cardinal; forward;

  function WriteOutRec(x: PIFPSValue; AllowData: Boolean): Boolean; forward;
  procedure AfterWriteOutRec(var x: PIFPSValue); forward;
  function FindProc(const Name: string): Cardinal; forward;
  function checkCompatType2(p1, p2: PIFPSType): Boolean;
  begin
    if
      ((p1.BaseType = btProcPtr) and (p2 = p1)) or
      (p1.BaseType = btVariant) or
      (p2.BaseType = btVariant) or
      (IsIntType(p1.BaseType) and IsIntType(p2.BaseType)) or
      (IsRealType(p1.BaseType) and IsIntRealType(p2.BaseType)) or
      (((p1.basetype = btPchar) or (p1.BaseType = btString)) and ((p2.BaseType = btString) or (p2.BaseType = btPchar))) or
      (((p1.basetype = btPchar) or (p1.BaseType = btString)) and (p2.BaseType = btChar)) or
      ((p1.BaseType = btArray) and (p2.BaseType = btArray) and CheckCompatType2(FUsedTypes.GetItem(TIFPSArrayType(p1).ArrayTypeNo), FUsedTypes.GetItem(TIFPSArrayType(p2).ArrayTypeNo))) or
      ((p1.BaseType = btChar) and (p2.BaseType = btChar)) or
      {$IFNDEF NOWIDESTRING}
      ((p1.BaseType = btWideChar) and (p2.BaseType = btChar)) or
      ((p1.BaseType = btWideChar) and (p2.BaseType = btWideChar)) or
      ((p1.BaseType = btWidestring) and (p2.BaseType = btChar)) or
      ((p1.BaseType = btWidestring) and (p2.BaseType = btWideChar)) or
      ((p1.BaseType = btWidestring) and ((p2.BaseType = btString) or (p2.BaseType = btPchar))) or
      ((p1.BaseType = btWidestring) and (p2.BaseType = btWidestring)) or
      (((p1.basetype = btPchar) or (p1.BaseType = btString)) and (p2.BaseType = btWideString)) or
      (((p1.basetype = btPchar) or (p1.BaseType = btString)) and (p2.BaseType = btWidechar)) or
      (((p1.basetype = btPchar) or (p1.BaseType = btString)) and (p2.BaseType = btchar)) or
      {$ENDIF}
      ((p1.BaseType = btRecord) and (p2.BaseType = btrecord)) or
      ((p1.BaseType = btEnum) and (p2.BaseType = btEnum))
      then
      Result := True
    else if ((p1.BaseType = btclass) and (p2.BaseType = btClass)) then
    begin

      Result :=TIFPSClassType(p1).ClassHelper.IsCompatibleWith(TIFPSClassType(p2).ClassHelper);
    end else

      Result := False;
  end;

  function CheckCompatType(V1, v2: PIFPSValue): Boolean;
  var
    p1, P2: PIFPSType;
  begin
    if (v1^.Modifiers and 4) <> 0 then
    begin
      Result := True;
      exit;
    end;
    p1 := FUsedTypes.GetItem(GetTypeNo(V1));
    P2 := FUsedTypes.GetItem(GetTypeNo(v2));
    Result := CheckCompatType2(p1, p2);
  end;

  function ProcessFunction(ResModifiers: Byte; ProcNo: Cardinal; InData: TIfList;
    ResultRegister:
    PIFPSValue): Boolean; forward;
  function ProcessVarFunction(ResModifiers: Byte; ProcNo: PIFPSValue; InData: TIfList;
    ResultRegister:
    PIFPSValue): Boolean; forward;

  function MakeNil(NilPos: Cardinal;ivar: PIFPSValue): Boolean;
  var
    Procno: Cardinal;
    PF: PIFPSType;
    Par: TIfList;
    pp: PParam;
  begin
    Pf := FUsedTypes.GetItem(GetTypeNo(IVar));
    if (pf.BaseType <> btClass) or (not TIFPSClassType(pf).ClassHelper.SetNil(GetTypeno(IVar), ProcNo)) or ((Ivar.FType <> CVAL_Addr)and(Ivar.FType <> CVAL_AllocatedStackReg)) then
    begin
      MakeError('', ecTypeMismatch, '')^.Position := nilPos;
      Result := False;
      exit;
    end;
    ivar.FType := CVAL_PushAddr;
    ivar.Modifiers := ivar.modifiers or 128;
    Par := TIfList.Create;
    new(pp);
    pp^.InReg := ivar;
    pp^.OutReg := nil;
    pp^.FType := GetTypeNo(ivar);
    pp^.OutRegPos := NilPos;
    par.add(pp);
    Result := ProcessFunction(0, ProcNo, Par, nil);
    Dispose(pp);
    Par.Free;
    ivar.Modifiers := ivar.modifiers and not 128;
  end;

  function PreWriteOutRec(var X: PIFPSValue; FArrType: Cardinal): Boolean;
  var
    rr: PIFRecField;
    tmpp,
      tmpc: PIFPSValue;
    i: Longint;
  begin
    Result := True;
    if x^.FType = CVAL_NIL then
    begin
      if FArrType = Cardinal(-1) then
      begin
        MakeError('', ecTypeMismatch, '');
        Result := False;
        Exit;
      end;
      tmpp := AllocStackReg(FArrType);
      if not MakeNil(x^.DPos, tmpp) then
      begin
        DisposeStackReg(tmpp);
        Result := False;
        exit;
      end;
      tmpp^.FType := CVAL_ArrayAllocatedStackRec;
      x := tmpp;
    end else
    if x^.FType = CVAL_Array then
    begin
      if FArrType = Cardinal(-1) then
      begin
        MakeError('', ecTypeMismatch, '');
        Result := False;
        Exit;
      end;
      tmpp := AllocStackReg(FArrType);
      tmpp^.FType := CVAL_ArrayAllocatedStackRec;
      tmpc := AllocStackReg(GetType(bts32));
      WriteCommand(CM_A);
      WriteOutrec(tmpc, False);
      WriteByte(1);
      WriteLong(GetType(bts32));
      WriteLong(x^.ArrayItems.Count);
      WriteCommand(CM_PV);
      WriteOutrec(tmpp, False);
      WriteCommand(CM_C);
      WriteLong(FindProc('SETARRAYLENGTH'));
      WriteCommand(CM_PO);
      DisposeStackReg(tmpc);
      new(tmpc);
      tmpc^.FType := CVAL_Addr;
      tmpc^.Modifiers := 0;
      tmpc^.DPos := tmpp^.DPos;
      tmpc^.Address := tmpp^.Address;
      tmpc^.RecField := TIFList.Create;
      new(rr);
      rr^.FKind := 1;
      rr^.FType := TIFPSArrayType(FUsedTypes.GetItem(FArrType)).ArrayTypeNo;
      tmpc^.RecField.Add(rr);
      for i := 0 to x^.ArrayItems.Count -1 do
      begin
        rr^.ArrayFieldNo := i;
        if not WriteCalculation(x^.ArrayItems.GetItem(i), tmpc) then
        begin
          DisposePValue(tmpc);
          DisposeStackReg(tmpp);
          Result := False;
          Exit;
        end;
      end;
      x := tmpp;
    end else if (x^.FType = CVAL_Eval) then
    begin
      tmpp := AllocStackReg(x^.frestype);
      WriteCalculation(x, tmpp);
      if x^.Modifiers = 1 then
      begin
        if (at2ut(FBooleanType) = x^.frestype) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
        WriteByte(0);
        WriteLong(Tmpp^.Address);
      end else
      if x^.Modifiers = 2 then
      begin
        WriteCommand(cm_vm);
        WriteByte(0);
        WriteLong(Tmpp^.Address);
      end;
      tmpp^.DPos := cardinal(x);
      x := tmpp;
      x^.FType := CVAL_AllocatedStackReg + 1;
    end else if (x^.FType = CVAL_Proc) or (x^.FType = CVAL_VarProc) then
    begin
      if x^.FType = CVAL_VarProc then
      begin
        tmpp := AllocStackReg(StrToIntDef(Fw(TIFPSProceduralType(FUsedTypes.GetItem(GetTypeNo(x^._ProcNo))).ProcDef), -1));
      end else if TIFPSProcedure(FProcs.GetItem(x^.ProcNo)).ClassType = TIFPSInternalProcedure then
        tmpp := AllocStackReg(StrToIntDef(Fw(TIFPSInternalProcedure(FProcs.GetItem(x^.ProcNo)).Decl), -1))
      else
        tmpp := AllocStackReg(StrToIntDef(Fw(TIFPSExternalProcedure(FPRocs.GetItem(x^.ProcNo)).RegProc.Decl), -1));
      WriteCalculation(x, tmpp);
      if x^.Modifiers = 1 then
      begin
        if (at2ut(FBooleanType) = GetTypeNo(tmpp)) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
        WriteByte(0);
        WriteLong(Tmpp^.Address);
      end else
      if x^.Modifiers = 2 then
      begin
        WriteCommand(cm_vm);
        WriteByte(0);
        WriteLong(Tmpp^.Address);
      end;
      tmpp^.DPos := cardinal(x);
      x := tmpp;
      x^.FType := CVAL_AllocatedStackReg + 1;
   end else
    if ((x^.FType = CVAL_Addr) or (x^.FType = CVAL_PushAddr)) and (x^.RecField <> nil) then
    begin
      if x^.RecField.Count = 1 then
      begin
        rr := x^.RecField.GetItem(0);
        if rr^.FKind < 2 then
          exit; // there is no need pre-calculate anything
        if rr^.ReadArrayFieldNoFrom^.FType = CVAL_Addr then
          exit;
      end; //if
      rr := x^.RecField.GetItem(x^.RecField.Count-1);
      if rr^.FKind = 3 then
      begin
        Inc(rr^.FType); 
        exit;
      end;

      tmpp := AllocStackReg(GetType(btPointer));
      WriteCommand(cm_sp);
      WriteOutRec(tmpp, True);
      WriteByte(0);
      WriteLong(x^.Address);

      for i := 0 to x^.RecField.Count - 1 do
      begin
        rr := x^.RecField.GetItem(I);
        case rr^.FKind of
          0, 1:
            begin
              WriteCommand(cm_sp);
              WriteOutRec(tmpp, false);
              WriteByte(2);
              WriteLong(tmpp^.Address);
              WriteLong(rr^.RecFieldNo);
            end; // case 0,1
          2:
            begin
              tmpc := AllocStackReg(GetType(btU32));
              if not WriteCalculation(rr^.ReadArrayFieldNoFrom, tmpc) then
              begin
                DisposeStackReg(tmpc);
                DisposeStackReg(tmpp);
                Result := False;
                exit;
              end; //if
              WriteCommand(cm_sp);
              WriteOutRec(tmpp, false);
              WriteByte(3);
              WriteData(tmpp^.Address, 4);
              WriteData(tmpc^.Address, 4);
              DisposeStackReg(tmpc);
            end; // case 2
        end; // case
        //Dispose(rr);
      end; // for
      if x^.Modifiers = 1 then
      begin
        if (at2ut(FBooleanType) = GetTypeNo(tmpp)) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
        WriteByte(0);
        WriteLong(Tmpp^.Address);
      end else
      if x^.Modifiers = 2 then
      begin
        WriteCommand(cm_vm);
        WriteByte(0);
        WriteLong(Tmpp^.Address);
      end;
      new(rr);
      rr^.FKind := 3;
      rr^.ResultRec := tmpp;
      rr^.FType := 1;
      x^.RecField.Add(rr);
    end else if (x^.Modifiers and 3) <> 0 then
    begin
      if x^.FType = CVAL_Addr then
      begin
        tmpp := AllocStackReg(GetTypeNo(x));
        tmpp^.FType := CVAL_AllocatedStackReg + 1;
        WriteCommand(CM_A);
        WriteByte(0);
        WriteLong(tmpp^.Address);
        WriteByte(0);
        WriteLong(x^.Address);
        if x^.Modifiers = 1 then
        begin
        if (at2ut(FBooleanType) = GetTypeNo(x)) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
          WriteByte(0);
          WriteLong(Tmpp^.Address);
        end else
        if x^.Modifiers = 2 then
        begin
          WriteCommand(cm_vm);
          WriteByte(0);
          WriteLong(Tmpp^.Address);
        end;
        tmpp^.DPos := cardinal(x);
        x := tmpp;
      end else if x^.FType = CVAL_PushAddr then
      begin
        if x^.Modifiers = 1 then
        begin
        if (at2ut(FBooleanType) = GetTypeNo(x)) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
          WriteByte(0);
          WriteLong(x^.Address);
        end else
        if x^.Modifiers = 2 then
        begin
          WriteCommand(cm_vm);
          WriteByte(0);
          WriteLong(x^.Address);
        end;
      end;
    end;
  end;

  procedure AfterWriteOutRec(var x: PIFPSValue);
  var
    rr: PIFRecField;
    p: Pointer;
  begin
    if x^.FType = CVAL_ArrayAllocatedStackRec then
    begin
      DisposeStackReg(x);
    end else
    if x^.FType = CVAL_AllocatedStackReg +1 then
    begin
      p := Pointer(x^.DPos);
      DisposeStackReg(x);
      x := p;
    end else if ((x^.FType = CVAL_Addr) or (x^.FType = CVAL_PushAddr)) and (x^.RecField <> nil) then
    begin
      rr := x^.RecField.GetItem(x^.Recfield.Count-1);
      if (rr^.FKind = 3) then
      begin
        Dec(rr^.FType);
        if rr^.FType = 0 then
        begin
          DisposeStackReg(rr^.ResultRec);
          Dispose(Rr);
          x^.RecField.Delete(x^.Recfield.Count-1);
        end;
      end;
    end;
  end; //afterwriteoutrec

  function WriteOutRec(x: PIFPSValue; AllowData: Boolean): Boolean;
  var
    rr: PIFRecField;
  begin
    Result := True;
    case x^.FType of
      CVAL_ArrayAllocatedStackRec, CVAL_Addr, CVAL_PushAddr, CVAL_AllocatedStackReg, CVAL_AllocatedStackReg + 1:
        begin
          if x^.RecField = nil then
          begin
            WriteByte(0);
            WriteData(x^.Address, 4);
          end
          else
          begin
            rr := x^.RecField.GetItem(x^.RecField.Count -1);
            case rr^.FKind of
              0, 1:
                begin
                  WriteByte(2);
                  WriteLong(x^.Address);
                  WriteLong(rr^.RecFieldNo);
                end;
              2:
                begin
                  WriteByte(3);
                  WriteLong(x^.Address);
                  WriteLong(rr^.ReadArrayFieldNoFrom^.Address);
                end;
              3:
                begin
                  WriteByte(0);
                  WriteLong(rr^.ResultRec^.Address);
                end;
            end;
          end;
        end;
      CVAL_Data:
        if AllowData then
        begin
          WriteByte(1);
          WriteVariant(x^.FData)
        end
        else
        begin
          Result := False;
          exit;
        end;
    else
      Result := False;
    end;
  end;

  function GetTypeNo(p: PIFPSValue): Cardinal;
  var
    n: TIFPSProcedure;
  begin
    if (p^.Modifiers and 8) <> 0 then
    begin
      Result := p^.FNewTypeNo;
      exit;
    end;
    if (p^.RecField <> nil) and (p^.FType = CVAL_Addr) then
    begin
      Result := GetRecordTypeNo(p);
    end
    else
      case p^.FType of
        CVAL_Cast:
        begin
          Result := p^.NewTypeNo;
        end;
        CVAL_Array:
        begin
          Result := at2ut(FindType('TVariantArray'));
        end;
        CVAL_ArrayAllocatedStackRec, CVAL_Addr, CVAL_AllocatedStackReg, CVAL_PushAddr:
          begin
            if p^.Address < IFPSAddrNegativeStackStart then
            begin
              if p^.Address < FVars.Count then
              begin
                Result := PIFPSVar(FVars.GetItem(p^.Address))^.FType;
              end
              else
                Result := Cardinal(-1);
            end
            else
            begin
              if p^.Address < IFPSAddrStackStart then
              begin
                Result := GetParamType(p^.Address - IFPSAddrStackStart);
              end
              else
                Result := PIFPSProcVar(Proc.ProcVars.GetItem(p^.Address - 1 -
                  IFPSAddrStackStart)).AType;
            end;
          end;
        CVAL_Data: Result := p^.FData^.FType;
        CVAL_VarProc:
          begin
            Result := StrToIntDef(Fw(TIFPSProceduralType(FUsedTypes.GetItem(GetTypeNo(p^._ProcNo))).ProcDef), -1);
          end;
        CVAL_Proc:
          begin
            n := TIFPSProcedure(FProcs.GetItem(p^.ProcNo));

            if n.ClassType = TIFPSInternalProcedure then
              Result := StrToIntDef(Fw(TIFPSInternalProcedure(n).Decl), -1)
            else
              Result := StrToIntDef(Fw(TIFPSExternalProcedure(n).RegProc.Decl), -1);
          end;
        CVAL_Eval: Result := p^.frestype;
      else
        Result := Cardinal(-1);
      end;
  end;

  function ReadParameters(ProcNo: Cardinal; FSelf: PIFPSValue): PIFPSValue; forward;

  function FindProc(const Name: string): Cardinal;
  var
    l, h: Longint;
    x: TIFPSProcedure;
    xr: TIFPSRegProc;
    temp: string;

  begin
    h := MakeHash(Name);
    for l := 0 to FProcs.Count - 1 do
    begin
      x := FProcs.GetItem(l);
      if x.ClassType = TIFPSInternalProcedure then
      begin
        if (TIFPSInternalProcedure(x).NameHash = h) and
          (TIFPSInternalProcedure(x).Name = Name) then
        begin
          Result := l;
          exit;
        end;
      end
      else
      begin
        if (TIFPSExternalProcedure(x).RegProc.NameHash = h) and
          (TIFPSExternalProcedure(x).RegProc.Name = Name) then
        begin
          Result := l;
          exit;
        end;
      end;
    end;
    for l := 0 to FRegProcs.Count - 1 do
    begin
      xr := FRegProcs.GetItem(l);
      if (xr.NameHash = h) and (xr.Name = Name) then
      begin
        x := TIFPSExternalProcedure.Create;
        TIFPSExternalProcedure(x).RegProc := xr;
        temp := xr.Decl;
        ReplaceTypes(temp);
        xr.Decl := temp;
        FProcs.Add(x);
        Result := FProcs.Count - 1;
        exit;
      end;
    end;
    Result := Cardinal(-1);
  end; {findfunc}

  function calc(endOn: TIfPasToken): PIFPSValue; forward;

  function ReadVarParameters(ProcNoVar: PIFPSValue): PIFPSValue; forward;

  function GetIdentifier(const FType: Byte): PIFPSValue;
    {
      FType:
        0 = Anything
        1 = Only variables
        2 = Not constants
    }
  var
    Temp: PIFPSValue;
    l, h: Longint;
    s, u: string;
    t: PIFPSConstant;
    Temp1: Cardinal;

    procedure CheckProcCall(var x: PIFPSValue);
    begin
      if FParser.CurrTokenId = CSTI_Dereference then
      begin
        if PIFPSType(FUsedTypes.GetItem(GetTypeNo(x))).BaseType <> btProcPtr then
        begin
          MakeError('', ecTypeMismatch, '');
          DisposePValue(x);
          x := nil;
          Exit;
        end;
        FParser.Next;
        x := ReadVarParameters(x);
      end;
    end;

    procedure CheckFurther(var x: PIFPSValue);
    var
      t: Cardinal;
      rr: PIFRecField;
      LastRecType, I, LL: Longint;
      u: PIFPSType;
      Param: PParam;
      NewRecFields: TIfList;
      tmp, tmp3: PIFPSValue;
      tmp2: Boolean;

      function FindSubR(const n: string; FType: PIFPSType): Cardinal;
      var
        h, I: Longint;
        rvv: PIFPSRecordFieldTypeDef;
      begin
        h := MakeHash(n);
        for I := 0 to TIFPSRecordType(FType).RecValCount - 1 do
        begin
          rvv := TIFPSRecordType(FType).RecVal(I);
          if (rvv.FieldNameHash = h) and (rvv.FieldName = n) then
          begin
            Result := I;
            exit;
          end;
        end;
        Result := Cardinal(-1);
      end;

    begin
      if (x^.FType <> CVAL_Addr) and (x^.FType <> CVAL_PushAddr) and (x^.FType <> CVAL_AllocatedStackReg) then
        Exit;
      x.RecField := nil;
      t := GetTypeNo(x);
      u := FUsedTypes.GetItem(t);
      if u.BaseType = btClass then exit;
      while True do
      begin
        if FParser.CurrTokenId = CSTI_OpenBlock then
        begin
          if (u.BaseType = btString) and (x^.FType = CVAL_Addr) then
          begin
            x^.FType := CVAL_PushAddr;
             FParser.Next;
            tmp := Calc(CSTI_CloseBlock);
            if tmp = nil then
            begin
              DisposePValue(x);
              x := nil;
              exit;
            end;
            if not IsIntType(PIFPSType(FUSedTypes.GetItem(GetTypeNo(tmp))).BaseType) then
            begin
              MakeError('', ecTypeMismatch, '');
              DisposePValue(tmp);
              DisposePValue(x);
              x := nil;
              exit;
            end;
            FParser.Next;
            if FParser.CurrTokenId = CSTI_Assignment then
            begin
              l := FindProc('STRSET');
              if l = -1 then
              begin
                MakeError('', ecUnknownIdentifier, 'StrGet');
                DisposePValue(tmp);
                DisposePValue(x);
                x := nil;
                exit;
              end;
              New(tmp3);
              tmp3^.FType :=CVAL_Proc;
              tmp3^.Modifiers := 0;
              tmp3^.DPos := FParser.CurrTokenPos;
              tmp3^.ProcNo := L;
              tmp3^.Parameters := TIfList.Create;
              new(Param);
              tmp3^.Parameters.Add(Param);
              new(Param);
              param^.InReg := tmp;
              Param^.FType := GetTypeNo(tmp);
              Param^.OutReg := nil;
              Param^.OutRegPos := tmp^.DPos;
              tmp3^.Parameters.Add(Param);
              new(Param);
              param^.InReg := x;
              Param^.FType := GetTypeNo(x);
              Param^.OutReg := nil;
              Param^.OutRegPos := tmp^.DPos;
              tmp3^.Parameters.Add(Param);
              Param := tmp3^.Parameters.GetItem(0);
              x := tmp3;
              FParser.Next;
              tmp := Calc(CSTI_SemiColon);
              if tmp = nil then
              begin
                Param := x^.Parameters.GetItem(0);
                x^.Parameters.Delete(0);
                Dispose(Param);
                DisposePValue(x);
                x := nil;
                exit;
              end;
              if PIFPSType(FUsedTypes.GetItem(GetTypeNo(Tmp))).BaseType <> btChar then
              begin
                Param := x^.Parameters.GetItem(0);
                x^.Parameters.Delete(0);
                Dispose(Param);
                MakeError('', ecTypeMismatch, '');
                DisposePValue(Tmp);
                x^.Parameters.Delete(0);
                DisposePValue(x);
                x := nil;
                exit;
              end;
              Param^.InReg := tmp;
              Param^.OutReg := nil;
              param^.FType := GetTypeNo(tmp);
              Param^.OutRegPos := tmp^.DPos;
            end else begin
              l := FindProc('STRGET');
              if l = -1 then
              begin
                MakeError('', ecUnknownIdentifier, 'StrGet');
                DisposePValue(tmp);
                DisposePValue(x);
                x := nil;
                exit;
              end;
              New(tmp3);
              tmp3^.FType :=CVAL_Proc;
              tmp3^.Modifiers := 0;
              tmp3^.DPos := FParser.CurrTokenPos;
              tmp3^.ProcNo := L;
              tmp3^.Parameters := TIfList.Create;
              new(Param);
              param^.InReg := x;
              Param^.FType := GetTypeNo(x);
              Param^.OutReg := nil;
              Param^.OutRegPos := tmp^.DPos;
              tmp3^.Parameters.Add(Param);
              new(Param);
              param^.InReg := tmp;
              Param^.FType := GetTypeNo(tmp);
              Param^.OutReg := nil;
              Param^.OutRegPos := tmp^.DPos;
              tmp3^.Parameters.Add(Param);
              x := tmp3;
            end;
            Break;
          end else if u.BaseType = btArray then
          begin
            FParser.Next;
            tmp := calc(CSTI_CloseBlock);
            if tmp = nil then
            begin
              DisposePValue(x);
              x := nil;
              exit;
            end;
            if not IsIntType(PIFPSType(FUSedTypes.GetItem(GetTypeNo(tmp))).BaseType) then
            begin
              MakeError('', ecTypeMismatch, '');
              DisposePValue(tmp);
              DisposePValue(x);
              x := nil;
              exit;
            end;
            if tmp^.FType = CVAL_Data then
            begin
              if x.RecField = nil then
                x.RecField := TIfList.Create;
              new(rr);
              rr^.FKind := 1;
              rr^.ArrayFieldNo := GetUInt(FUsedTypes, tmp^.FData, tmp2);
              DisposePValue(tmp);
              rr^.FType := TIFPSArrayType(u).ArrayTypeNo;
              u := FUsedTypes.GetItem(rr^.FType);
              x^.RecField.Add(rr);
            end
            else
            begin
              if x.RecField = nil then
                x.RecField := TIfList.Create;
              new(rr);
              rr^.FKind := 2;
              rr^.ReadArrayFieldNoFrom := tmp;
              rr^.FType := TIFPSArrayType(u).ArrayTypeNo;
              u := FUsedTypes.GetItem(rr^.FType);
              x^.RecField.Add(rr);
            end;
            if FParser.CurrTokenId <> CSTI_CloseBlock then
            begin
              MakeError('', ecCloseBlockExpected, '');
              DisposePValue(x);
              x := nil;
              exit;
            end;
            Fparser.Next;
          end else begin
            MakeError('', ecSemicolonExpected, '');
            DisposePValue(x);
            x := nil;
            exit;
          end;
        end
        else if FParser.CurrTokenId = CSTI_Period then
        begin
          FParser.Next;
          if u.BaseType = btRecord then
          begin
            t := FindSubR(FParser.GetToken, u);
            if t = Cardinal(-1) then
            begin
              MakeError('', ecUnknownIdentifier, '');
              DisposePValue(x);
              x := nil;
              exit;
            end;
            FParser.Next;
            if x.RecField = nil then
              x.RecField := TIfList.Create;
            new(rr);
            rr^.FKind := 0;
            rr^.FType := TIFPSRecordType(u).RecVal(t).FType;
            rr^.RecFieldNo := t;
            u := FUsedTypes.GetItem(rr^.FType);
            x^.RecField.Add(rr);
          end
          else
          begin
            DisposePValue(x);
            MakeError('', ecSemicolonExpected, '');
            x := nil;
            exit;
          end;
        end
        else
          break;
      end;
      if x^.RecField = nil then
        exit;
      LL := -1;
      NewRecFields := TIfList.Create;
      if x^.FType = 0 then
      begin
        if x^.Address < IFPSAddrNegativeStackStart then
          LastRecType := PIFPSVar(FVars.GetItem(x^.Address))^.FType
        else if x^.Address < IFPSAddrStackStart then
        begin
          LastRecType := GetParamType(Longint(x^.Address - IFPSAddrStackStart));
        end
        else
          LastRecType := PIFPSProcVar(Proc.ProcVars.GetItem(x^.Address - 1 - IFPSAddrStackStart)).AType;
        i := 0;
        u := FUsedTypes.GetItem(LastRecType);

        while i < Longint(x^.RecField.Count) do
        begin
          rr := x^.RecField.GetItem(I);
          case rr^.FKind of
            0:
              begin
                if LL = -1 then
                  inc(ll);
                LastRecType := rr^.FType;

                LL := LL + Longint(TIFPSRecordType(u).RecVal(rr^.RecFieldNo).RealFieldOffset);
                u := FUsedTypes.GetItem(LastRecType);
                dispose(rr);
              end;
            1:
              begin
                if LL <> -1 then
                begin
                  new(rr);
                  rr^.FKind := 0;
                  rr^.RecFieldNo := LL;
                  rr^.FType := LastRecType;
                  newRecFields.Add(Rr);
                  rr := x^.RecField.GetItem(I);
                end;
                u := FUsedTypes.GetItem(rr^.FType);
                newRecFields.Add(rr);
                LL := -1;
              end;
            2:
              begin
                if LL <> -1 then
                begin
                  new(rr);
                  rr^.FKind := 0;
                  rr^.FType := LastRecType;
                  rr^.RecFieldNo := LL;
                  newRecFields.Add(Rr);
                  rr := x^.RecField.GetItem(I);
                end;
                u := FUsedTypes.GetItem(rr^.FType);
                newRecFields.Add(rr);
                LL := -1;
              end;

          end;
          inc(i);
        end;
        if LL <> -1 then
        begin
          new(rr);
          rr^.FKind := 0;
          rr^.RecFieldNo := LL;
          rr^.FType := LastRecType;
          newRecFields.Add(Rr);
        end;
        x^.RecField.Free;
        x^.RecField := NewRecFields;
      end;
    end;
    function ReadPropertyParameters(Params: TIfList; ParamTypes: string): Boolean;
    var
      CurrParamType: Cardinal;
      Temp: PIFPSValue;
      P: PParam;
    begin
      Delete(ParamTypes, 1, pos(' ', ParamTypes)); // Remove property type
      if FParser.CurrTokenID <> CSTI_OpenBlock then
      begin
        MakeError('', ecOpenBlockExpected, '');
        Result := False;
        exit;
      end;
      FParser.Next;
      while ParamTypes <> '' do
      begin
        CurrParamType := at2ut(StrToIntDef(GRFW(ParamTypes), -1));
        Temp := Calc(CSTI_CloseBlock);
        if temp = nil then
        begin
          Result := False;
          Exit;
        end;
        New(P);
        p^.InReg := Temp;
        p^.OutReg := nil;
        p^.FType := CurrParamType;
        p^.OutRegPos := FParser.CurrTokenPos;
        Params.Add(p);
        if ParamTypes = '' then
        begin
          if FParser.CurrTokenID <> CSTI_CloseBlock then
          begin
            MakeError('', ecCloseBlockExpected, '');
            Result := False;
            Exit;
          end;
          FParser.Next;
        end else begin
          if FParser.CurrTokenId <> CSTI_Comma then
          begin
            MakeError('', ecCommaExpected, '');
            Result := False;
            exit;
          end;
          FParser.Next;
        end;
      end;
      Result := True;
    end;
    procedure CheckClass(var P: PIFPSValue; const VarType: TIFPSVariableType; VarNo: Cardinal);
    var
      Idx, FTypeNo: Cardinal;
      FType: PIFPSType;
      TempP: PIFPSValue;
      Param: PParam;
      s: string;

      pinfo: string;

    begin
      FTypeNo := GetTypeNo(p);
      if FTypeNo = Cardinal(-1) then Exit;
      FType := FUsedTypes.GetItem(FTypeNo);
      if FType.BaseType <> btClass then Exit;
      while FParser.CurrTokenID = CSTI_Period do
      begin
        FParser.Next;
        if FParser.CurrTokenID <> CSTI_Identifier then
        begin
          MakeError('', ecIdentifierExpected, '');
          DisposePValue(p);
          P := nil;
          Exit;
        end;
        s := FParser.GetToken;
        if TIFPSClassType(FType).ClassHelper.Func_Find(s, Idx) then
        begin
          FParser.Next;
          VarNo := Cardinal(-1);
          TIFPSClassType(FType).ClassHelper.Func_Call(Idx, FTypeNo);
          P := ReadParameters(FTypeNo, P);
          if p = nil then
          begin
            Exit;
          end;
        end else if TIFPSClassType(FType).ClassHelper.Property_Find(s, Idx) then
        begin
          if VarNo <> Cardinal(-1) then
          begin
            if pinfo = '' then
              pinfo := s
            else
              pinfo := pinfo + '.' + s;
            if @FOnUseVariable <> nil then
              FOnUseVariable(Self, VarType, VarNo, ProcNo, FParser.CurrTokenPos, PInfo);
          end;
          FParser.Next;
          TIFPSClassType(FType).ClassHelper.Property_GetHeader(Idx, s);
          TempP := P;
          New(P);
          P^.FType := CVAL_Proc;
          p^.Modifiers := 0;
          p^.DPos := FParser.CurrTokenPos;
          P^.Parameters := TIfList.Create;
          new(param);
          Param^.InReg := TempP;
          Param^.OutReg := nil;
          Param^.FType := GetTypeNo(TempP);
          P^.Parameters.Add(Param);
          if pos(' ', s) <> 0 then
          begin
            if not ReadPropertyParameters(P^.Parameters, s) then
            begin
              DisposePValue(P);
              P := nil;
              exit;
            end;
          end; // if
          if FParser.CurrTokenId = CSTI_Assignment then
          begin
            FParser.Next;
            TempP := Calc(CSTI_SemiColon);
            if TempP = nil then
            begin
              DisposePValue(P);
              p := nil;
              exit;
            end;
            new(param);
            Param^.InReg := tempp;
            Param^.OutReg := nil;
            Param^.FType := at2ut(StrToIntDef(fw(s), -1));
            P^.Parameters.Add(Param);
            if not TIFPSClassType(FType).ClassHelper.Property_Set(Idx, p^.ProcNo) then
            begin
              MakeError('', ecReadOnlyProperty, '');
              DisposePValue(p);
              p := nil;
              exit;
            end;
            Exit;
          end else begin
            if not TIFPSClassType(FType).ClassHelper.Property_Get(Idx, p^.ProcNo) then
            begin
              MakeError('', ecWriteOnlyProperty, '');
              DisposePValue(p);
              p := nil;
              exit;
            end;
          end; // if FParser.CurrTokenId = CSTI_Assign
        end else
        begin
          MakeError('', ecUnknownIdentifier, s);
          DisposePValue(p);
          P := nil;
          Exit;
        end;
        FTypeNo := GetTypeNo(p);
        FType := FUsedTypes.GetItem(FTypeNo);
        if (FType = nil) or (FType.BaseType <> btClass) then Exit;
      end; {while}
    end;
    function CheckClassType(const TypeNo, ParserPos: Cardinal): PIFPSValue;
    var
      FType, FType2: PIFPSType;
      ProcNo, Idx: Cardinal;
      PP: PParam;
      Temp: PIFPSValue;
    begin
      FType := FAvailableTypes.GetItem(TypeNo);
      if FParser.CurrTokenID = CSTI_OpenRound then
      begin
        FParser.Next;
        Temp := Calc(CSTI_CloseRound);
        if Temp = nil then
        begin
          Result := nil;
          exit;
        end;
        if FParser.CurrTokenID <> CSTI_CloseRound then
        begin
          DisposePValue(temp);
          MakeError('', ecCloseRoundExpected, '');
          Result := nil;
          exit;
        end;
        FType2 := FUsedTypes.GetItem(GetTypeNo(Temp));
        if (FType.basetype = BtClass) and (ftype2.BaseType = btClass) and (ftype <> ftype2) then
        begin
          if not TIFPSClassType(FType2).ClassHelper.CastToType(GetTypeNo(Temp), AT2UT(TypeNo), ProcNo) then
          begin
            DisposePValue(Temp);
            MakeError('', ecTypeMismatch, '');
            Result := nil;
            exit;
          end;
          New(Result);
          Result^.FType := CVAL_Proc;
          Result^.Modifiers := 8;
          Result^.FNewTypeNo := at2ut(TypeNo);
          Result^.DPos := FParser.CurrTokenPos;
          Result^.Parameters := TIfList.Create;
          Result^.ProcNo := ProcNo;
          New(pp);
          pp^.InReg := Temp;
          pp^.OutReg := nil;
          pp^.FType := GetTypeNo(Temp);
          Result^.Parameters.Add(pp);
          New(pp);
          pp^.OutReg := nil;
          pp^.FType := GetType(btu32);
          New(pp^.InReg);
          pp^.InReg^.FType := CVAL_Data;
          pp^.InReg^.Modifiers := 0;
          pp^.InReg^.DPos := FParser.CurrTokenPos;
          New(pp^.InReg^.FData);
          pp^.InReg^.FData^.FType := pp^.FType;
          pp^.Inreg^.FData.BaseType:= PIFPSType(FUsedTypes.GetItem(pp^.FType)).BaseType;
          pp^.INreg^.FData^.tu32 := at2ut(TypeNo);
          Result^.Parameters.Add(pp);
          FParser.Next;
          Exit;
        end;
        if not checkCompatType2(FType, FType2) then
        begin
          DisposePValue(Temp);
          MakeError('', ecTypeMismatch, '');
          Result := nil;
          exit;
        end;
        FParser.Next;
        New(Result);
        Result^.FType := CVAL_Cast;
        Result^.Modifiers := 0;
        Result^.DPos := FParser.CurrTokenPos;
        Result^.Input := Temp;
        Result^.NewTypeNo := AT2UT(TypeNo);
        exit;
      end;
      if FParser.CurrTokenId <> CSTI_Period then
      begin
        Result := nil;
        MakeError('', ecPeriodExpected, '');
        Exit;
      end;
      if FType.BaseType <> btClass then
      begin
        Result := nil;
        MakeError('', ecClassTypeExpected, '');
        Exit;
      end;
      FParser.Next;
      if not TIFPSClassType(FType).ClassHelper.ClassFunc_Find(FParser.GetToken, Idx) then
      begin
        Result := nil;
        MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
        Exit;
      end;
      FParser.Next;
      TIFPSClassType(FType).ClassHelper.ClassFunc_Call(Idx, ProcNo);
      New(Temp);
      Temp^.FType := CVAL_Data;
      Temp^.Modifiers := 0;
      New(Temp^.FData);
      Temp^.FData^.FType := GetType(btU32);
      Temp^.FData.BaseType := btU32;
      temp^.FData^.tu32 := at2ut(TypeNo);
      Result := ReadParameters(ProcNo, Temp);
      if Result <> nil then
      begin
        Result^.Modifiers := Result^.Modifiers or 8;
        Result^.FNewTypeNo := AT2UT(TypeNo);
      end;
    end;

  var
    vt: TIFPSVariableType;
    vno: Cardinal;

  begin
    s := FParser.GetToken;
    h := MakeHash(s);
    u := proc.Decl;
    if s = 'RESULT' then
    begin
      if GRFW(u) = '-1' then
      begin
        Result := nil;
        MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
      end
      else
      begin
        Proc.ResultUse;
        New(Result);
        Result^.FType := CVAL_Addr;
        Result^.Modifiers := 0;
        Result^.Address := IFPSAddrStackStart - 1;
        Result^.DPos := FParser.CurrTokenPos;
        Result^.RecField := nil;
        vt := ivtParam;
        vno := 0;
        if @FOnUseVariable <> nil then
          FOnUseVariable(Self, vt, vno, ProcNo, FParser.CurrTokenPos, '');
        FParser.Next;
        repeat
          Temp := Result;
          if Result <> nil then CheckFurther(Result);
          if Result <> nil then CheckClass(Result, vt, vno);
          if Result <> nil then CheckProcCall(Result);
          vno := Cardinal(-1);
        until (Result = nil) or (Temp = Result);
      end;
      exit;
    end;
    if GRFW(u) <> '-1' then
      l := -2
    else
      l := -1;
    while Length(u) > 0 do
    begin
      if D1(GRFW(u)) = s then
      begin
        New(Result);
        Result^.FType := CVAL_Addr;
        Result^.Modifiers := 0;
        Result^.Address := IFPSAddrStackStart + Cardinal(l);
        Result^.RecField := nil;
        vt := ivtParam;
        vno := -1 - L;
        if @FOnUseVariable <> nil then
          FOnUseVariable(Self, vt, vno, ProcNo, FParser.CurrTokenPos, '');
        FParser.Next;
        Result^.DPos := FParser.CurrTokenPos;
        repeat
          Temp := Result;
          if Result <> nil then CheckFurther(Result);
          if Result <> nil then CheckClass(Result, vt, vno);
          if Result <> nil then CheckProcCall(Result);
          vno := Cardinal(-1);
        until (Result = nil) or (Temp = Result);
        exit;
      end;
      Dec(l);
      GRFW(u);
    end;

    for l := 0 to Proc.ProcVars.Count - 1 do
    begin
      if (PIFPSProcVar(Proc.ProcVars.GetItem(l)).NameHash = h) and
        (PIFPSProcVar(Proc.ProcVars.GetItem(l)).Name = s) then
      begin
        PIFPSProcVar(Proc.ProcVars.GetItem(l)).Use;
        vno := l;
        vt := ivtVariable;
        if @FOnUseVariable <> nil then
          FOnUseVariable(Self, vt, vno, ProcNo, FParser.CurrTokenPos, '');
        New(Result);
        Result^.FType := CVAL_Addr;
        Result^.Modifiers := 0;
        Result^.Address := IFPSAddrStackStart + Cardinal(l) + 1;
        Result^.DPos := FParser.CurrTokenPos;
        Result^.RecField := nil;

        FParser.Next;
        repeat
          Temp := Result;
          if Result <> nil then CheckFurther(Result);
          if Result <> nil then CheckClass(Result, vt, vno);
          if Result <> nil then CheckProcCall(Result);
          vno := Cardinal(-1);
        until (Result = nil) or (Temp = Result);

        exit;
      end;
    end;

    for l := 0 to FVars.Count - 1 do
    begin
      if (PIFPSVar(FVars.GetItem(l))^.NameHash = h) and
        (PIFPSVar(FVars.GetItem(l))^.Name = s) then
      begin
        PIFPSVar(FVars.GetItem(l))^.Used := True;
        New(Result);
        Result^.FType := CVAL_Addr;
        Result^.Modifiers := 0;
        Result^.Address := l;
        Result^.RecField := nil;
        Result^.DPos := FParser.CurrTokenPos;
        vt := ivtGlobal;
        vno := l;
        if @FOnUseVariable <> nil then
          FOnUseVariable(Self, vt, vno, ProcNo, FParser.CurrTokenPos, '');
        FParser.Next;
        repeat
          Temp := Result;
          if Result <> nil then CheckFurther(Result);
          if Result <> nil then CheckClass(Result, vt, vno);
          if Result <> nil then CheckProcCall(Result);
          vno := Cardinal(-1);
        until (Result = nil) or (Temp = Result);
        exit;
      end;
    end;
    Temp1 := FindType(FParser.GetToken);
    if Temp1 <> Cardinal(-1) then
    begin
      l := FParser.CurrTokenPos;
      if FType = 1 then
      begin
        Result := nil;
        MakeError('', ecVariableExpected, FParser.OriginalToken);
        exit;
      end;
      vt := ivtGlobal;
      vno := Cardinal(-1);
      FParser.Next;
      Result := CheckClassType(Temp1, l);
        repeat
          Temp := Result;
          if Result <> nil then CheckFurther(Result);
          if Result <> nil then CheckClass(Result, vt, vno);
          if Result <> nil then CheckProcCall(Result);
          vno := Cardinal(-1);
        until (Result = nil) or (Temp = Result);

      exit;
    end;
    Temp1 := FindProc(FParser.GetToken);
    if Temp1 <> Cardinal(-1) then
    begin
      l := FParser.CurrTokenPos;
      if FType = 1 then
      begin
        Result := nil;
        MakeError('', ecVariableExpected, FParser.OriginalToken);
        exit;
      end;
      FParser.Next;
      Result := ReadParameters(Temp1, nil);
      if Result = nil then
        exit;
      Result^.DPos := l;
      vt := ivtGlobal;
      vno := Cardinal(-1);
      repeat
        Temp := Result;
        if Result <> nil then CheckFurther(Result);
        if Result <> nil then CheckClass(Result, vt, vno);
        if Result <> nil then CheckProcCall(Result);
        vno := Cardinal(-1);
      until (Result = nil) or (Temp = Result);
      exit;
    end;
    for l := 0 to FConstants.Count -1 do
    begin
      t := PIFPSConstant(FConstants.GetItem(l));
      if (t^.NameHash = h) and (t^.Name = s) then
      begin
        if FType <> 0 then
        begin
          Result := nil;
          MakeError('', ecVariableExpected, FParser.OriginalToken);
          exit;
        end;
        fparser.next;
        new(result);
        Result^.FType := CVAL_Data;
        Result^.DPos := FParser.CurrTokenPos;
        Result^.Modifiers := 0;
        New(Result^.FData);
        InitializeVariant(Result^.FData, at2ut(t^.Value.FType), t^.Value.BaseType);
        CopyVariantContents(@t.Value, Result^.FData);
        exit;
      end;
    end;
    Result := nil;
    MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
  end;
  function ReadVarParameters(ProcNoVar: PIFPSValue): PIFPSValue;
  var
    Decl: string;
    p: PParam;
    Tmp: PIFPSValue;
    FType: Cardinal;
    modifier: Char;

    function IsVarInCompatible(ft1, ft2: PIFPSType): Boolean;
    begin
      ft1 := GetTypeCopyLink(ft1);
      ft2 := GetTypeCopyLink(ft2);
      Result := (ft1 <> ft2);
    end;

    function getfc(const s: string): Char;
    begin
      if Length(s) > 0 then
        Result := s[1]
      else
        Result := #0
    end;
  begin
    Decl := TIFPSProceduralType(FUsedTypes.GetItem(GetTypeNo(ProcnoVar))).ProcDef;
    GRFW(Decl);
    New(Result);
    Result^.FType := CVAL_VarProc;
    Result^.Modifiers := 0;
    Result^._ProcNo := ProcNoVar;
    Result^._Parameters := TIfList.Create;
    if Length(Decl) = 0 then
    begin
      if FParser.CurrTokenId = CSTI_OpenRound then
      begin
        FParser.Next;
        if FParser.CurrTokenId <> CSTI_CloseRound then
        begin
          DisposePValue(Result);
          Result := nil;
          MakeError('', ecCloseRoundExpected, '');
          exit;
        end;
        FParser.Next;
      end;
    end
    else
    begin
      if FParser.CurrTokenId <> CSTI_OpenRound then
      begin
        DisposePValue(Result);
        MakeError('', ecOpenRoundExpected, '');
        Result := nil;
        exit;
      end;
      FParser.Next;
      while Length(Decl) > 0 do
      begin
        modifier := getfc(GRFW(Decl));
        FType := StrToInt(GRFW(Decl));
        if (modifier = '@') then
        begin
          Tmp := calc(CSTI_CloseRound);
          if Tmp = nil then
          begin
            DisposePValue(Result);
            Result := nil;
            exit;
          end;
        end
        else
        begin
          if FParser.CurrTokenId <> CSTI_Identifier then
          begin
            MakeError('', ecIdentifierExpected, '');
            DisposePValue(Result);
            Result := nil;
            exit;
          end;
          Tmp := GetIdentifier(1); // only variables
          if Tmp = nil then
          begin
            DisposePValue(Result);
            Result := nil;
            exit;
          end;
          if ((FType = Cardinal(-1)) and (PIFPSType(FUsedTypes.GetItem(GetTypeNo(Tmp))).BaseType = btArray)) then
          begin
            {nothing}
          end else if IsVarInCompatible(FUsedTypes.GetItem(FType), FUsedTypes.GetItem(GetTypeNo(Tmp))) then
          begin
            MakeError('', ecTypeMismatch, '');
            DisposePValue(Result);
            DisposePValue(Tmp);
            Result := nil;
            exit;
          end;
          Tmp^.FType := Tmp^.FType + CVAL_PushAddr;
        end;
        New(p);
        p^.InReg := Tmp;
        p^.OutReg := nil;
        p^.FType := FType;
        Result._Parameters.Add(p);
        if Length(Decl) = 0 then
        begin
          if FParser.CurrTokenId <> CSTI_CloseRound then
          begin
            MakeError('', ecCloseRoundExpected, '');
            DisposePValue(Result);
            Result := nil;
            exit;
          end; {if}
          FParser.Next;
        end
        else
        begin
          if FParser.CurrTokenId <> CSTI_Comma then
          begin
            MakeError('', ecCommaExpected, '');
            DisposePValue(Result);
            Result := nil;
            exit;
          end; {if}
          FParser.Next;
        end; {else if}
      end; {for}
    end; {else if}
  end;

  function calc(endOn: TIfPasToken): PIFPSValue;
  var
    Items: TIfList;
    p: PCalc_Item;
    x: PParam;
    v, vc: PIFPSValue;
    Pt: PIFPSType;
    C: Byte;
    modifiers: byte;
    L: Cardinal;

    procedure Cleanup;
    var
      p: PCalc_Item;
      l: Longint;
    begin
      for l := 0 to Items.Count - 1 do
      begin
        p := Items.GetItem(l);
        if not p^.C then
        begin
          DisposePValue(p^.OutRec);
        end;
        Dispose(p);
      end;
      Items.Free;
    end;

    function SortItems: Boolean;
    var
      l: Longint;
      tt: Cardinal;
      p, p1, P2, ptemp: PCalc_Item;
      tempt: PIFPSType;
      pp: PParam;
      temps: string;

      function GetResultType(p1, P2: PIFPSValue; Cmd: Byte): Cardinal;
      var
        t1, t2: PIFPSType;
        tt1, tt2: Cardinal;
      begin
        tt1 := GetTypeNo(p1);
        t1 := FUsedTypes.GetItem(tt1);
        tt2 := GetTypeNo(P2);
        t2 := FUsedTypes.GetItem(tt2);
        if (t1 = nil) or (t2 = nil) then
        begin
          Result := Cardinal(-1);
          exit;
        end;
        case Cmd of
          0: {plus}
            begin
              if (t1.BaseType = btVariant) and (
                (t2.BaseType = btVariant) or
                (t2.BaseType = btString) or
                {$IFNDEF NOWIDESTRING}
                (t2.BaseType = btwideString) or
                (t2.BaseType = btwidechar) or
                {$ENDIF}
                (t2.BaseType = btPchar) or
                (t2.BaseType = btChar) or
                (isIntRealType(t2.BaseType))) then
                Result := tt1
              else
              if (t2.BaseType = btVariant) and (
                (t1.BaseType = btVariant) or
                (t1.BaseType = btString) or
                (t1.BaseType = btPchar) or
                (t1.BaseType = btChar) or
                (isIntRealType(t1.BaseType))) then
                Result := tt2
              else if IsIntType(t1.BaseType) and IsIntType(t2.BaseType) then
                Result := tt1
              else if IsIntRealType(t1.BaseType) and
                IsIntRealType(t2.BaseType) then
              begin
                if IsRealType(t1.BaseType) then
                  Result := tt1
                else
                  Result := tt2;
              end
              else if ((t1.BaseType = btString) or (t1.BaseType = btChar)) and ((t2.BaseType = btString) or (t2.BaseType = btChar)) then
                Result := GetType(btString)
              {$IFNDEF NOWIDESTRING}
              else if ((t1.BaseType = btString) or (t1.BaseType = btChar) or (t1.BaseType = btWideString) or (t1.BaseType = btWideChar)) and
              ((t2.BaseType = btString) or (t2.BaseType = btChar) or (t2.BaseType = btWideString) or (t2.BaseType = btWideChar)) then
                Result := GetType(btWideString)
              {$ENDIF}
              else
                Result := Cardinal(-1);
            end;
          1, 2, 3: { -  * / }
            begin
              if (t1.BaseType = btVariant) and (
                (t2.BaseType = btVariant) or
                (isIntRealType(t2.BaseType))) then
                Result := tt1
              else
              if (t2.BaseType = btVariant) and (
                (t1.BaseType = btVariant) or
                (isIntRealType(t1.BaseType))) then
                Result := tt2
              else if IsIntType(t1.BaseType) and IsIntType(t2.BaseType) then
                Result := tt1
              else if IsIntRealType(t1.BaseType) and
                IsIntRealType(t2.BaseType) then
              begin
                if IsRealType(t1.BaseType) then
                  Result := tt1
                else
                  Result := tt2;
              end
              else
                Result := Cardinal(-1);
            end;
          7, 8, 9: {and,or,xor}
            begin
              if (t1.BaseType = btVariant) and (
                (t2.BaseType = btVariant) or
                (isIntType(t2.BaseType))) then
                Result := tt1
              else
              if (t2.BaseType = btVariant) and (
                (t1.BaseType = btVariant) or
                (isIntType(t1.BaseType))) then
                Result := tt2
              else if IsIntType(t1.BaseType) and IsIntType(t2.BaseType) then
                Result := tt1
              else if (tt1 = at2ut(FBooleanType)) and (tt2 = tt1) then
              begin
                Result := tt1;
                if ((p1^.FType = CVAL_Data) or (p2^.FType = CVAL_Data)) then
                begin
                  if cmd = 7 then {and}
                  begin
                    if p1^.FType = CVAL_Data then
                    begin
                      if (p1^.FData^.tu8 <> 0) then
                        MakeWarning('', ewIsNotNeeded, '"True and"')^.Position := p1^.DPos
                      else
                        MakeWarning('', ewCalculationAlwaysEvaluatesTo, 'False')^.Position := p1^.DPos
                    end else begin
                      if (p2^.FData^.tu8 <> 0) then
                        MakeWarning('', ewIsNotNeeded, '"and True"')^.Position := p2^.DPos
                      else
                        MakeWarning('', ewCalculationAlwaysEvaluatesTo, 'False')^.Position := p2^.DPos;
                    end;
                  end else if cmd = 8 then {or}
                  begin
                    if p1^.FType = CVAL_Data then
                    begin
                      if (p1^.FData^.tu8 <> 0) then
                        MakeWarning('', ewCalculationAlwaysEvaluatesTo, 'True')^.Position := p1^.DPos
                      else
                        MakeWarning('', ewIsNotNeeded, '"False or"')^.Position := p1^.DPos
                    end else begin
                      if (p2^.FData^.tu8 <> 0) then
                        MakeWarning('', ewCalculationAlwaysEvaluatesTo, 'True')^.Position := p2^.DPos
                      else
                        MakeWarning('', ewIsNotNeeded, '"or False"')^.Position := p2^.DPos;
                    end;
                  end;
                end;
              end else
                Result := Cardinal(-1);
            end;
          4, 5, 6: {mod,shl,shr}
            begin
              if (t1.BaseType = btVariant) and (
                (t2.BaseType = btVariant) or
                (isIntType(t2.BaseType))) then
                Result := tt1
              else
              if (t2.BaseType = btVariant) and (
                (t1.BaseType = btVariant) or
                (isIntType(t1.BaseType))) then
                Result := tt2
              else if IsIntType(t1.BaseType) and IsIntType(t2.BaseType) then
                Result := tt1
              else
                Result := Cardinal(-1);
            end;
          10, 11, 12, 13: { >=, <=, >, <}
            begin
              if (t1.BaseType = btVariant) and (
                (t2.BaseType = btVariant) or
                (t2.BaseType = btString) or
                (t2.BaseType = btPchar) or
                (t2.BaseType = btChar) or
                (isIntRealType(t2.BaseType))) then
                Result := tt1
              else
              if (t2.BaseType = btVariant) and (
                (t1.BaseType = btVariant) or
                (t1.BaseType = btString) or
                (t1.BaseType = btPchar) or
                (t1.BaseType = btChar) or
                (isIntRealType(t1.BaseType))) then
                Result := tt2
              else if IsIntType(t1.BaseType) and IsIntType(t2.BaseType) then
                Result := at2ut(FBooleanType)
              else if IsIntRealType(t1.BaseType) and
                IsIntRealType(t2.BaseType) then
                Result := at2ut(FBooleanType)
              else if
              ((t1.BaseType = btString) or (t1.BaseType = btChar) {$IFNDEF NOWIDESTRING} or (t1.BaseType = btWideString) or (t1.BaseType = btWideChar){$ENDIF}) and
              ((t2.BaseType = btString) or (t2.BaseType = btChar) {$IFNDEF NOWIDESTRING} or (t2.BaseType = btWideString) or (t2.BaseType = btWideChar){$ENDIF}) then
                Result := at2ut(FBooleanType)
              else if (t1.BaseType = btVariant) or (t2.BaseType = btVariant) then
                Result := at2ut(FBooleanType)
              else
                Result := Cardinal(-1);
            end;
          14, 15: {=, <>}
            begin
              if (t1.BaseType = btVariant) and (
                (t2.BaseType = btVariant) or
                (t2.BaseType = btString) or
                (t2.BaseType = btPchar) or
                (t2.BaseType = btChar) or
                (isIntRealType(t2.BaseType))) then
                Result := tt1
              else
              if (t2.BaseType = btVariant) and (
                (t1.BaseType = btVariant) or
                (t1.BaseType = btString) or
                (t1.BaseType = btPchar) or
                (t1.BaseType = btChar) or
                (isIntRealType(t1.BaseType))) then
                Result := tt2
              else if IsIntType(t1.BaseType) and IsIntType(t2.BaseType) then
                Result := at2ut(FBooleanType)
              else if IsIntRealType(t1.BaseType) and
                IsIntRealType(t2.BaseType) then
                Result := at2ut(FBooleanType)
              else if
              ((t1.BaseType = btString) or (t1.BaseType = btChar) {$IFNDEF NOWIDESTRING} or (t1.BaseType = btWideString) or (t1.BaseType = btWideChar){$ENDIF}) and
              ((t2.BaseType = btString) or (t2.BaseType = btChar) {$IFNDEF NOWIDESTRING} or (t2.BaseType = btWideString) or (t2.BaseType = btWideChar){$ENDIF}) then
                Result := at2ut(FBooleanType)
              else if (t1.BaseType = btEnum) and (t1 = t2) then
                Result := at2ut(FBooleanType)
              else if (t1.BaseType = btVariant) or (t2.BaseType = btVariant) then
                Result := at2ut(FBooleanType)
              else Result := Cardinal(-1);
            end;
        else
          Result := Cardinal(-1);
        end;
      end;
      procedure ApplyModifiers(FData: PIFPSValue);
      begin
        if (FData^.FType = CVAL_Data) then
        begin
          if FData^.Modifiers = 1 then // not
          begin
            FData^.Modifiers := FData^.Modifiers and not 1;
            case FData^.FData.BaseType of
              btEnum: FData^.FData^.tu32 := tbtu32(FData^.FData^.tu32 = 0);
              btU8: FData^.FData^.tu8 := tbtu8(FData^.FData^.tu8 = 0);
              btS8: FData^.FData^.ts8:= tbts8(FData^.FData^.ts8 = 0);
              btU16: FData^.FData^.tu16:= tbtu16(FData^.FData^.tu16 = 0);
              btS16: FData^.FData^.ts16:= tbts16(FData^.FData^.ts16 = 0);
              btU32: FData^.FData^.tu32:= tbtu32(FData^.FData^.tu32 = 0);
              btS32: FData^.FData^.ts32:= tbts32(FData^.FData^.ts32 = 0);
              {$IFNDEF NOINT64}
              bts64: FData^.FData^.ts64 := tbts64(FData^.FData^.ts64 = 0);
              {$ENDIF}
            end;
          end else
          if FData^.Modifiers = 2 then // minus
          begin
            FData^.Modifiers := FData^.Modifiers and not 2;

            case FData^.FData.BaseType of
              btU8:
                begin
                  FData^.FData^.FType := GetType(bts8);
                  FData^.FData.BaseType := btS8;
                  FData^.FData^.ts8:= - FData^.FData^.ts8;
                end;
              btS8: FData^.FData^.ts8:= - FData^.FData^.ts8;
              btU16:
                begin
                  FData^.FData^.FType := GetType(bts16);
                  FData^.FData.BaseType := bts16;
                  FData^.FData^.ts16:= - FData^.FData^.ts16;
                end;
              btS16: FData^.FData^.ts16:= - FData^.FData^.ts16;
              btU32:
                begin
                  FData^.FData^.FType := GetType(bts32);
                  FData^.FData.BaseType := btS32;
                  FData^.FData^.ts32:= - FData^.FData^.ts32;
                end;
              btS32: FData^.FData^.ts32:= - FData^.FData^.ts32;
              {$IFNDEF NOINT64}
              bts64: FData^.FData^.ts64 := - FData^.FData^.ts64;
              {$ENDIF}
              btSingle: FData^.FData^.tsingle := - FData^.FData^.tsingle;
              btDouble: FData^.FData^.tdouble:= - FData^.FData^.tdouble;
              btExtended: FData^.FData^.textended := - FData^.FData^.textended;
            end;
          end;
        end;
      end;
    begin
      SortItems := False;
      if Items.Count = 1 then
      begin
        p1 := Items.GetItem(0);
        ApplyModifiers(p1^.OutRec);
        SortItems := True;
        exit;
      end;
      for l := 0 to (Longint(Items.Count) div 2) do
      begin
        p1 := Items.GetItem(l shl 1);
        if p1^.OutRec^.FType = CVAL_Data then
          ApplyModifiers(P1^.OutRec);
      end;
      l := 0;
      while l < Longint(Items.Count - 1) div 2 do
      begin
        p := Items.GetItem((l shl 1) + 1);
        p1 := Items.GetItem((l shl 1));
        P2 := Items.GetItem((l shl 1) + 2);
        case p^.calcCmd of
          2, 3, 4, 5, 6, 7: {*}
            begin
              if (p1^.OutRec^.FType = CVAL_Data) and (P2^.OutRec^.FType =
                CVAL_Data) then
              begin
                if not PreCalc(FUsedTypes, p1^.OutRec^.Modifiers, p1^.OutRec^.FData, p2^.OutRec^.Modifiers, P2^.OutRec^.FData,
                  p^.calcCmd, P2^.OutRec^.DPos) then
                begin
                  exit;
                end;
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
                DisposePValue(P2^.OutRec);
                Dispose(P2);
                Dispose(p);
              end
              else
              begin
                tt := GetResultType(p1^.OutRec, P2^.OutRec, p^.calcCmd);
                if tt = Cardinal(-1) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position :=
                    P2^.OutRec^.DPos;
                  exit;
                end;
                New(ptemp);
                ptemp^.C := False;
                New(ptemp^.OutRec);
                ptemp^.OutRec^.Modifiers := 0;
                ptemp^.outrec^.DPos := p1^.OutRec^.DPos;
                ptemp^.OutRec^.FType := CVAL_Eval;
                ptemp^.OutRec^.SubItems := TIfList.Create;
                ptemp^.OutRec^.SubItems.Add(p1);
                ptemp^.OutRec^.SubItems.Add(p);
                ptemp^.OutRec^.SubItems.Add(P2);
                ptemp^.OutRec^.frestype := tt;
                Items.SetItem((l shl 1), ptemp);
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
              end;
            end;
        else
          Inc(l);
        end;
      end;
      l := 0;
      while l < Longint(Items.Count - 1) div 2 do
      begin
        p := Items.GetItem((l shl 1) + 1);
        p1 := Items.GetItem((l shl 1));
        P2 := Items.GetItem((l shl 1) + 2);
        case p^.calcCmd of
          0, 1, 8, 9:
            begin
              if (p1^.OutRec^.FType = CVAL_Data) and (P2^.OutRec^.FType =
                CVAL_Data) then
              begin
                if not PreCalc(FUsedTypes, p1^.OutRec^.Modifiers, p1^.OutRec^.FData, p2^.OutRec^.Modifiers, P2^.OutRec^.FData,
                  p^.calcCmd, P2^.OutRec^.DPos) then
                begin
                  exit;
                end;
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
                DisposePValue(P2^.OutRec);
                Dispose(P2);
                Dispose(p);
              end
              else
              begin
                tt := GetResultType(p1^.OutRec, P2^.OutRec, p^.calcCmd);
                if tt = Cardinal(-1) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position :=
                    P2^.OutRec^.DPos;
                  exit;
                end;
                New(ptemp);
                ptemp^.C := False;
                New(ptemp^.OutRec);
                ptemp^.OutRec^.Modifiers := 0;
                ptemp^.outrec^.DPos := p1^.OutRec^.DPos;
                ptemp^.OutRec^.FType := CVAL_Eval;
                ptemp^.OutRec^.SubItems := TIfList.Create;
                ptemp^.OutRec^.SubItems.Add(p1);
                ptemp^.OutRec^.SubItems.Add(p);
                ptemp^.OutRec^.SubItems.Add(P2);
                ptemp^.OutRec^.frestype := tt;
                Items.SetItem((l shl 1), ptemp);
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
              end;
            end;
        else
          Inc(l);
        end;
      end;
      l := 0;
      while l < Longint(Items.Count - 1) div 2 do
      begin
        p := Items.GetItem((l shl 1) + 1);
        p1 := Items.GetItem((l shl 1));
        P2 := Items.GetItem((l shl 1) + 2);
        case p^.calcCmd of
          10, 11, 12, 13, 14, 15:
            begin
              if (p1^.OutRec^.FType <> CVAL_VarProcPtr) and (p2^.OutRec^.FType <> CVAL_VarProcPtr) and
              ((PIFPSType(FUsedTypes.GetItem(GetTypeNo(p1^.OutRec))).BaseType = btclass) or
              (PIFPSType(FUsedTypes.GetItem(GetTypeNo(p2^.OutRec))).BaseType = btclass)) and
              ((p^.CalcCmd = 14) or (p^.CalcCmd = 15)) then
              begin
                if p1^.OutRec^.FType = cval_nil then
                begin
                  ptemp := p1;
                  p1 := p2;
                  p2 := ptemp;
                end;
                tempt := FUsedTypes.GetItem(GetTypeNo(p1^.OutRec));
                if not TIFPSClassType(tempt).ClassHelper.CompareClass(GetTypeNo(p2^.OutRec), tt) then
                begin
                  exit;
                end;
                new(ptemp);
                ptemp^.C := False;
                new(ptemp^.outrec);
                with ptemp^.outrec^ do
                begin
                  FType := CVAL_Proc;
                  if p^.calcCmd = 14 then
                    Modifiers := 1
                  else
                    Modifiers := 0;
                  ProcNo := tt;
                  Parameters := TIfList.Create;
                  new(pp);
                  if TIFPSProcedure(FProcs.GetItem(tt)).ClassType = TIFPSInternalProcedure then
                    temps := TIFPSInternalProcedure(FProcs.GetItem(tt)).Decl
                  else
                    temps := TIFPSExternalProcedure(FProcs.GetItem(tt)).RegProc.Decl;
                  GRFW(temps);
                  pp^.InReg := p1^.OutRec;
                  pp^.OutReg := nil;
                  grfw(temps);
                  pp^.FType := StrToIntDef(grfw(temps), -1);
                  pp^.OutRegPos := p1^.OutRec^.DPos;
                  Parameters.add(pp);
                  new(pp);
                  pp^.InReg := p2^.OutRec;
                  pp^.OutReg := nil;
                  grfw(temps);
                  pp^.FType := StrToIntDef(grfw(temps), -1);
                  pp^.OutRegPos := p2^.OutRec^.DPos;
                  Parameters.add(pp);
                end;
                Items.SetItem((l shl 1), ptemp);
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
                Dispose(P2);
                dispose(p1);
                Dispose(p);
              end else 
              if (p1^.OutRec^.FType = CVAL_Data) and (P2^.OutRec^.FType =
                CVAL_Data) then
              begin
                if not PreCalc(FUsedTypes, p1^.OutRec^.Modifiers, p1^.OutRec^.FData, p2^.OutRec^.Modifiers, P2^.OutRec^.FData,
                  p^.calcCmd, P2^.OutRec^.DPos) then
                begin
                  exit;
                end;
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
                DisposePValue(P2^.OutRec);
                Dispose(P2);
                Dispose(p);
              end
              else
              begin
                tt := GetResultType(p1^.OutRec, P2^.OutRec, p^.calcCmd);
                if tt = Cardinal(-1) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position :=
                    P2^.OutRec^.DPos;
                  exit;
                end;
                New(ptemp);
                ptemp^.C := False;
                New(ptemp^.OutRec);
                ptemp^.OutRec^.Modifiers := 0;
                ptemp^.outrec^.DPos := p1^.OutRec^.DPos;
                ptemp^.OutRec^.FType := CVAL_Eval;
                ptemp^.OutRec^.SubItems := TIfList.Create;
                ptemp^.OutRec^.SubItems.Add(p1);
                ptemp^.OutRec^.SubItems.Add(p);
                ptemp^.OutRec^.SubItems.Add(P2);
                ptemp^.OutRec^.frestype := tt;
                Items.SetItem((l shl 1), ptemp);
                Items.Delete((l shl 1) + 1);
                Items.Delete((l shl 1) + 1);
              end;
            end;
        else
          Inc(l);
        end;
      end;
      SortItems := True;
    end;
  begin
    Items := TIfList.Create;
    calc := nil;
    while True do
    begin
      modifiers := 0;
      if Items.Count and 1 = 0 then
      begin
        if fParser.CurrTokenID = CSTII_Not then
        begin
          FParser.Next;
          modifiers := 1;
        end else // only allow one of these two
        if fParser.CurrTokenID = CSTI_Minus then
        begin
          FParser.Next;
          modifiers := 2;
        end;
        case FParser.CurrTokenId of
          CSTI_AddressOf:
            begin
              if (Modifiers <> 0) then
              begin
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              FParser.Next;
              if FParser.CurrTokenId <> CSTI_Identifier then
              begin
                MakeError('', ecIdentifierExpected, '');
                Cleanup;
                Exit;
              end;
              L := FindProc(FParser.GetToken);
              if L = Cardinal(-1) then
              begin
                MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
                Cleanup;
                Exit;
              end;
              if TIFPSProcedure(FProcs.GetItem(l)).ClassType <> TIFPSInternalProcedure then
              begin
                MakeError('', ecTypeMismatch, FParser.OriginalToken);
                Cleanup;
                Exit;
              end;
              TIFPSInternalProcedure(FProcs.GetItem(L)).aExport := etExportDecl;
              FParser.Next;
              New(v);
              v^.FType := CVAL_VarProcPtr;
              v^.Modifiers := 0;
              v^.DPos := FParser.CurrTokenPos;
              v^.VProcNo := L;
              New(p);
              p^.C := False;
              p^.OutRec := v;
              Items.Add(p);
            end;
          CSTI_OpenBlock:
            begin
              if (Modifiers <> 0) then
              begin
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              New(v);
              v^.FType := CVAL_Array;
              v^.Modifiers := 0;
              v^.DPos := FParser.CurrTokenPos;
              v^.ArrayItems := TIfList.Create;
              New(p);
              p^.C := False;
              p^.OutRec := v;
              Items.Add(p);
              FParser.Next;
              while FParser.CurrTokenId <> CSTI_CloseBlock do
              begin
                vc := calc(CSTI_CloseBlock);
                if vc = nil  then
                begin
                  Cleanup;
                  exit;
                end; {if}
                if vc^.FType = CVAL_Array then
                begin
                  MakeError('', ecIdentifierExpected, '')^.Position := v^.DPos;
                  Cleanup;
                  Exit;
                end;
                v^.ArrayItems.Add(vc);
                if FParser.CurrTokenId = CSTI_Comma then
                begin
                  FParser.Next;
                  Continue;
                end;
              end; {while}
              FParser.Next;
            end; {csti_openblock}
          CSTI_EOF:
            begin
              MakeError('', ecUnexpectedEndOfFile, '');
              Cleanup;
              exit;
            end;
          CSTI_OpenRound:
            begin
              FParser.Next;
              v := calc(CSTI_CloseRound);
              if v = nil then
              begin
                Cleanup;
                exit;
              end;
              if FParser.CurrTokenId <> CSTI_CloseRound then
              begin
                DisposePValue(v);
                MakeError('', ecCloseRoundExpected, '');
                Cleanup;
                exit;
              end;
              if ((Modifiers and 1) <> 0) and (not IsIntBoolType(GetTypeNo(v))) or ((Modifiers and 2) <> 0) and (not IsRealType(PIFPSType(FUsedTypes.GetItem(GetTypeNo(v))).BaseType)) then
              begin
                DisposePValue(v);
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;

              New(p);
              p^.C := False;
              if ((v^.Modifiers and 1) <> 0) or ((modifiers and 1) <> 0) then
              begin
                v^.modifiers := v^.modifiers xor (modifiers and 1);
              end;
              if ((v^.Modifiers and 2) <> 0) or ((modifiers and 2) <> 0) then
              begin
                v^.modifiers := v^.modifiers xor (modifiers and 2);
              end;
              p^.OutRec := v;
              Items.Add(p);

              FParser.Next;
            end;
          CSTII_Chr:
            begin
              if modifiers <> 0then
              begin
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              FParser.Next;
              if FParser.CurrTokenID <> CSTI_OpenRound then
              begin
                MakeError('', ecOpenRoundExpected, '');
                Cleanup;
                exit;
              end;
              FParser.Next;
              v := calc(CSTI_CloseRound);
              if v = nil then
              begin
                Cleanup;
                exit;
              end;
              if FParser.CurrTokenId <> CSTI_CloseRound then
              begin
                DisposePValue(v);
                MakeError('', ecCloseRoundExpected, '');
                Cleanup;
                exit;
              end;
              if not IsIntType(PIFPSType(FUsedTypes.GetItem(GetTypeNo(v))).BaseType) then
              begin
                DisposePValue(v);
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              New(p);
              p^.c := False;
              New(p^.OutRec);
              p^.OutRec^.FType := CVAL_Cast;
              p^.OutRec^.Modifiers := 0;
              p^.OutRec^.DPos := FParser.CurrTokenPos;
              p^.OutRec^.Input := v;
              p^.OutRec^.NewTypeNo := GetType(btChar);
              Items.Add(p);
              FParser.Next;
            end;
          CSTII_Ord:
            begin
              FParser.Next;
              if FParser.CurrTokenID <> CSTI_OpenRound then
              begin
                MakeError('', ecOpenRoundExpected, '');
                Cleanup;
                exit;
              end;
              FParser.Next;
              v := calc(CSTI_CloseRound);
              if v = nil then
              begin
                Cleanup;
                exit;
              end;
              if FParser.CurrTokenId <> CSTI_CloseRound then
              begin
                DisposePValue(v);
                MakeError('', ecCloseRoundExpected, '');
                Cleanup;
                exit;
              end;
              Pt := FUsedTypes.GetItem(GetTypeNo(v));
              New(p);
              p^.c := False;
              if ((v^.Modifiers and 1) <> 0) or ((modifiers and 1) <> 0) then
              begin
                v^.modifiers := v^.modifiers xor (modifiers and 1);
              end;
              if ((v^.Modifiers and 2) <> 0) or ((modifiers and 2) <> 0) then
              begin
                v^.modifiers := v^.modifiers xor (modifiers and 2);
              end;
              New(p^.OutRec);
              p^.OutRec^.FType := CVAL_Cast;
              p^.OutRec^.Modifiers := 0;
              p^.OutRec^.DPos := FParser.CurrTokenPos;
              p^.OutRec^.Input := v;
              if (pt.BaseType = btChar) then
              begin
                p^.OutRec^.NewTypeNo := GetType(btU8);
              end else if (pt.BaseType = btEnum) then
              begin
                if TIFPSEnumType(pt).HighValue <= 256 then
                  p^.OutRec^.NewTypeNo := GetType(btU8)
                else if TIFPSEnumType(pt).HighValue <= 65536 then
                  p^.OutRec^.NewTypeNo := GetType(btU16)
                else
                  p^.OutRec^.NewTypeNo := GetType(btU32);
              end else
              begin
                Dispose(P^.OutRec);
                Dispose(p);
                DisposePValue(v);
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              Items.Add(p);
              FParser.Next;
            end;
         CSTI_String, CSTI_Char:
            begin
              if (Modifiers <> 0) then
              begin
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              New(v);
              v^.FType := CVAL_Data;
              v^.DPos := FParser.CurrTokenPos;
              v^.FData := ReadString;
              v^.Modifiers := modifiers;
              v^.RecField := nil;
              New(p);
              p^.C := False;
              p^.OutRec := v;
              Items.Add(p);

            end;
          CSTI_HexInt, CSTI_Integer:
            begin
              New(v);
              v^.FType := CVAL_Data;
              v^.DPos := FParser.CurrTokenPos;
              v^.FData := ReadInteger(FParser.GetToken);
              v^.Modifiers := modifiers;
              New(p);
              p^.C := False;
              p^.OutRec := v;
              Items.Add(p);

              FParser.Next;
            end;
          CSTI_Real:
            begin
              if ((Modifiers and 1) <> 0)  then
              begin
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              New(v);
              v^.FType := CVAL_Data;
              v^.DPos := FParser.CurrTokenPos;
              v^.FData := ReadReal(FParser.GetToken);
              v^.Modifiers := modifiers;
              New(p);
              p^.C := False;
              p^.OutRec := v;
              Items.Add(p);
              FParser.Next;
            end;
          CSTI_Identifier:
            begin
              if FParser.GetToken = 'LOW' then
                c := 1
              else
                c := 0;
              if (FParser.GetToken = 'HIGH') or (c <> 0) then
              begin
                FParser.Next;
                if FParser.CurrTokenId <> CSTI_OpenRound then
                begin
                  MakeError('', ecOpenRoundExpected, '');
                  Cleanup;
                  Exit;
                end;
                FParser.Next;
                L := FindType(FParser.GetToken);
                if L = Cardinal(-1) then
                begin
                  v := GetIdentifier(1);
                  if v = nil then
                  begin
                    Cleanup;
                    Exit;
                  end;
                  L := GetTypeNo(v);
                  DisposePValue(v);
                end else FParser.Next;
                pt := FAvailableTypes.GetItem(L);
                if pt.BaseType <> btEnum then
                begin
                  MakeError('', ecTypeMismatch, '');
                  Cleanup;
                  Exit;
                end;
                New(v);
                new(v^.FData);
                v^.FType := CVAL_Data;
                v^.DPos := FParser.CurrTokenPos;
                InitializeVariant(v^.FData, AT2UT(L), PIFPSType(FUsedTypes.GetItem(L)).BaseType);
                if c = 1 then
                  v^.FData^.tu32 := 0
                else
                  v^.FData^.tu32 := TIFPSEnumType(pt).HighValue;
                v^.Modifiers := modifiers;
                New(p);
                p^.C := False;
                p^.OutRec := v;
                Items.Add(p);
                if FParser.CurrTokenId <> CSTI_CloseRound then
                begin
                  MakeError('', ecCloseRoundExpected, '');
                  Cleanup;
                  Exit;
                end;
              end else if FParser.GetToken = 'ASSIGNED' then
              begin
                if (Modifiers and 2) <> 0 then
                begin
                  MakeError('', ecTypeMismatch, '');
                  cleanup;
                  exit;
                end;
                FParser.Next;
                if FParser.CurrTokenId <> CSTI_OpenRound then
                begin
                  MakeError('', ecOpenRoundExpected, '');
                  Cleanup;
                  Exit;
                end;
                FParser.Next;
                vc := calc(CSTI_CloseRound);
                if vc = nil then
                begin
                  Cleanup;
                  Exit;
                end;
                Pt := FUsedTypes.GetItem(GetTypeNo(vc));
                if pt = nil then
                begin
                  if vc^.FType <> CVAL_VarProcPtr then
                  begin
                    DisposePValue(vc);
                    MakeError('', ecTypeMismatch, '');
                    Cleanup;
                    exit;
                  end;
                end else
                if (pt.BaseType <> btProcPtr) and (pt.BaseType <> btClass) and (pt.BaseType <> btPChar) and (pt.BaseType <> btString) then
                begin
                  DisposePValue(vc);
                  MakeError('', ecTypeMismatch, '');
                  Cleanup;
                  exit;
                end;
                if FParser.CurrTokenId <> CSTI_CloseRound then
                begin
                  MakeError('', ecCloseRoundExpected, '');
                  Cleanup;
                  Exit;
                end;
                FParser.Next;
                if (vc^.FType =CVAL_VarProcPtr) then
                begin
                  new(v);
                  V^.FType := CVAL_Data;
                  v^.Modifiers := modifiers;
                  New(v^.FData);
                  v^.Fdata^.FType := at2ut(FBooleanType);
                  v^.FData.BaseType := PIFPSType(FAvailableTypes.GetItem(FBooleanType)).BaseType;
                  v^.FData^.tu32 := 1;
                  new(p);
                  p^.C := False;
                  p^.OutRec := v;
                  Items.Add(p);
                end else begin
                  new(v);
                  V^.FType := CVAL_Proc;
                  v^.Modifiers := modifiers;
                  v^.ProcNo := FindProc('!ASSIGNED');
                  V^.Parameters :=TIfList.Create;
                  new(x);
                  X^.InReg := vc;
                  x^.OutReg := nil;
                  x^.FType := GetTypeNo(vc);
                  X^.OutRegPos := FParser.CurrTokenPos;
                  v^.Parameters.Add(x);
                  new(p);
                  p^.C := False;
                  p^.OutRec := v;
                  Items.Add(p);
                end;
              end else if FParser.GetToken = 'NIL' then
              begin
                if modifiers <> 0 then
                begin
                  MakeError('', ecTypeMismatch, '');
                  cleanup;
                  exit;
                end;
                New(v);
                v^.FType := CVAL_Nil;
                v^.DPos := FParser.CurrTokenPos;
                v^.Modifiers := 0;
                New(p);
                p^.C := False;
                p^.OutRec := v;
                Items.Add(p);
                FParser.Next;
              end else begin
                v := GetIdentifier(0);
                if v = nil then
                begin
                  Cleanup;
                  exit;
                end
                else if (GetTypeNo(v) = Cardinal(-1)) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position := v^.DPos;
                  DisposePValue(v);
                  Cleanup;
                  Exit;
                end else
                begin
                  if ((Modifiers and 1) <> 0) and (not IsIntBoolType(GetTypeNo(v))) or ((Modifiers
                  and 2) <> 0) and (not IsIntRealType(PIFPSType(
                  FUsedTypes.GetItem(GetTypeNo(v))).BaseType))
                  then
                  begin
                    DisposePValue(v);
                    MakeError('', ecTypeMismatch, '');
                    Cleanup;
                    exit;
                  end;
                  v^.Modifiers := v^.modifiers or modifiers;
                  New(p);
                  p^.C := False;
                  p^.OutRec := v;
                  Items.Add(p);
                end;
              end;
            end;
        else
          begin
            MakeError('', ecSyntaxError, '');
            Cleanup;
            exit;
          end;
        end; {case}
      end
      else {Items.Count and 1 = 1}
      begin
        if FParser.CurrTokenId = endOn then
          break;
        C := 0;
        case FParser.CurrTokenId of
          CSTI_EOF:
            begin
              MakeError('', ecUnexpectedEndOfFile, '');
              Cleanup;
              exit;
            end;
          CSTI_CloseBlock,
            CSTII_To,
            CSTI_CloseRound,
            CSTI_Semicolon,
            CSTII_Else,
            CSTII_End,
            CSTII_Until,
            CSTI_Comma: break;
          CSTI_Plus: ;
          CSTI_Minus: C := 1;
          CSTI_Multiply: C := 2;
          CSTII_div, CSTI_Divide: C := 3;
          CSTII_mod: C := 4;
          CSTII_shl: C := 5;
          CSTII_shr: C := 6;
          CSTII_and: C := 7;
          CSTII_or: C := 8;
          CSTII_xor: C := 9;
          CSTI_GreaterEqual: C := 10;
          CSTI_LessEqual: C := 11;
          CSTI_Greater: C := 12;
          CSTI_Less: C := 13;
          CSTI_NotEqual: C := 14;
          CSTI_Equal: C := 15;
        else
          begin
            MakeError('', ecSyntaxError, '');
            Cleanup;
            exit;
          end;
        end; {case}
        New(p);
        p^.C := True;
        p^.calcCmd := C;
        Items.Add(p);
        FParser.Next;
      end;
    end;
    if not SortItems then
    begin
      Cleanup;
      exit;
    end;
    if Items.Count = 1 then      
    begin
      p := Items.GetItem(0);
      Result := p^.OutRec;
      Dispose(p);
      Items.Free;
    end
    else
    begin
      New(Result);
      Result^.FType := CVAL_Eval;
      Result^.DPos := 0;
      result^.Modifiers := 0;
      Result^.SubItems := Items;
    end;
  end;

  function ReadParameters(ProcNo: Cardinal; fSelf: PIFPSValue): PIFPSValue;
  var
    Decl: string;
    p: PParam;
    Tmp: PIFPSValue;
    FType: Cardinal;
    modifier: Char;
    PType: PIFPSType;

    function IsVarInCompatible(ft1, ft2: PIFPSType): Boolean;
    begin
      ft1 := GetTypeCopyLink(ft1);
      ft2 := GetTypeCopyLink(ft2);
      Result := (ft1 <> ft2);
    end;

    function getfc(const s: string): Char;
    begin
      if Length(s) > 0 then
        Result := s[1]
      else
        Result := #0
    end;
  begin
    if TIFPSProcedure(FProcs.GetItem(ProcNo)).ClassType = TIFPSInternalProcedure then
      Decl := TIFPSInternalProcedure(FProcs.GetItem(ProcNo)).Decl
    else
      Decl := TIFPSExternalProcedure(FProcs.GetItem(ProcNo)).RegProc.Decl;
    GRFW(Decl);
    New(Result);
    Result^.FType := CVAL_Proc;
    Result^.DPos := FParser.CurrTokenPos;
    Result^.Modifiers := 0;
    Result^.ProcNo := ProcNo;
    Result^.Parameters := TIfList.Create;
    if FSelf <> nil then begin
      new(p);
      p^.InReg := fself;
      p^.OutReg := nil;
      p^.FType := GetTypeNo(fself);
      Result^.Parameters.Add(p);
    end;
    if Length(Decl) = 0 then
    begin
      if FParser.CurrTokenId = CSTI_OpenRound then
      begin
        FParser.Next;
        if FParser.CurrTokenId <> CSTI_CloseRound then
        begin
          DisposePValue(Result);
          Result := nil;
          MakeError('', ecCloseRoundExpected, '');
          exit;
        end;
        FParser.Next;
      end;
    end
    else
    begin
      if FParser.CurrTokenId <> CSTI_OpenRound then
      begin
        DisposePValue(Result);
        MakeError('', ecOpenRoundExpected, '');
        Result := nil;
        exit;
      end;
      FParser.Next;
      while Length(Decl) > 0 do
      begin
        modifier := getfc(GRFW(Decl));
        FType := StrToInt(GRFW(Decl));
        if (modifier = '@') then
        begin
          Tmp := calc(CSTI_CloseRound);
          if Tmp = nil then
          begin
            DisposePValue(Result);
            Result := nil;
            exit;
          end;
        end
        else
        begin
          if FParser.CurrTokenId <> CSTI_Identifier then
          begin
            MakeError('', ecIdentifierExpected, '');
            DisposePValue(Result);
            Result := nil;
            exit;
          end;
          Tmp := GetIdentifier(1); // only variables
          if Tmp = nil then
          begin
            DisposePValue(Result);
            Result := nil;
            exit;
          end;
          PType := PIFPSType(FUsedTypes.GetItem(FType));
          if (FType = Cardinal(-1)) or ((PType.BaseType = btArray) and (TIFPSArrayType(PType).ArrayTypeNo = cardinal(-1)) and (PIFPSType(FUsedTypes.GetItem(GetTypeNo(Tmp))).BaseType = btArray)) then
          begin
            {nothing}
          end else if (PType.BaseType = btArray) and (PIFPSType(FUsedTypes.GetItem(GetTypeNo(Tmp))).BaseType = btArray) then
          begin
            if TIFPSArrayType(FUsedTypes.GetItem(GetTypeNo(Tmp))).ArrayTypeNo <> TIFPSArrayType(FUsedTypes.GetItem(FType)).ArrayTypeNo then
            begin
              MakeError('', ecTypeMismatch, '');
              DisposePValue(Result);
              DisposePValue(Tmp);
              Result := nil;
              exit;
            end;
            {nothing}
          end else if IsVarInCompatible(FUsedTypes.GetItem(FType), FUsedTypes.GetItem(GetTypeNo(Tmp))) then
          begin
            MakeError('', ecTypeMismatch, '');
            DisposePValue(Result);
            DisposePValue(Tmp);
            Result := nil;
            exit;
          end;
          Tmp^.FType := Tmp^.FType + CVAL_PushAddr;
        end;
        New(p);
        p^.InReg := Tmp;
        p^.OutReg := nil;
        p^.FType := FType;
        Result.Parameters.Add(p);
        if Length(Decl) = 0 then
        begin
          if FParser.CurrTokenId <> CSTI_CloseRound then
          begin
            MakeError('', ecCloseRoundExpected, '');
            DisposePValue(Result);
            Result := nil;
            exit;
          end; {if}
          FParser.Next;
        end
        else
        begin
          if FParser.CurrTokenId <> CSTI_Comma then
          begin
            MakeError('', ecCommaExpected, '');
            DisposePValue(Result);
            Result := nil;
            exit;
          end; {if}
          FParser.Next;
        end; {else if}
      end; {for}
    end; {else if}
  end;


  function WriteCalculation(InData, OutReg: PIFPSValue): Boolean;
  var
    l: Longint;
    tmpcalc, p, PT, pt2: PIFPSValue;
    bmodsave: byte;
    C: Byte;

    function CheckOutreg(Where, Outreg: PIFPSValue): Boolean;
    var
      i: Longint;
      P: PCalc_Item;
    begin
      case Where^.FType of
        CVAL_Cast:
          begin
            if CheckOutreg(Where^.Input, Outreg) then
            begin
              Result := True;
              exit;
            end;
          end;
        CVAL_Addr, CVAL_PushAddr, CVAL_AllocatedStackReg:
          begin
            if SameReg(Where, OutReg) then
            begin
              Result := True;
              exit;
            end;
          end;
        CVAL_Eval:
          for i := 0 to Where.SubItems.Count -1 do
          begin
            p := Where.SubItems.GetItem(i);
            if not p^.C then
              if CheckOutreg(p^.OutRec, Outreg) then
              begin
                Result := True;
                Exit;
              end;
          end;
        CVAL_Proc, CVAL_VarProc:
          for i := 0 to Where^.Parameters.Count -1 do
          begin
            if CheckOutreg(PParam(Where^.Parameters.GetItem(i))^.InReg, Outreg) then
            begin
              Result := True;
              Exit;
            end;
          end;
        CVAL_ClassProcCall,
        CVAL_ClassMethodCall,
        CVAL_ClassPropertyCallSet,
        CVAL_ClassPropertyCallGet:
          begin
            if CheckOutreg(Where^.Self, Outreg) then
            begin
              Result := True;
              exit;
            end;
            for i := 0 to Where^.Params.Count -1 do
            begin
              if CheckOutreg(PParam(Where^.Params.GetItem(i))^.InReg, Outreg) then
              begin
                Result := True;
                Exit;
              end;
            end;

          end;
      end;
      Result := False;;
    end;
  begin
    if indata^.FType = CVAL_Cast then
    begin
      if GetTypeNo(OutReg) = Indata^.NewTypeNo then
      begin
        OutReg^.Modifiers := outreg^.modifiers or 4;
        Result := WriteCalculation(Indata^.Input, OutReg);
        OutReg^.Modifiers := outreg^.modifiers and not 4;
        Exit;
      end else begin
        p := AllocStackReg(Indata^.NewTypeNo);
        p^.DPos := InData^.DPos;
        p^.Modifiers := p^.modifiers or 4;
        if not WriteCalculation(Indata^.Input, p) then
        begin
          DisposeStackReg(p);
          Result := False;
          Exit;
        end;
        Result := WriteCalculation(p, outreg);
        DisposeStackReg(p);
        exit;
      end;
    end else
    if InData^.FType = CVAL_VarProcPtr then
    begin
      if not CheckCompatProc(GetTypeNo(OutReg), InData^.VProcNo) then
      begin
        MakeError('', ecTypeMismatch, '')^.Position := InData^.DPos;
        Result := False;
        exit;
      end;
      New(p);
      p^.FType := CVAL_Data;
      p^.Modifiers := 0;
      p^.DPos := Indata^.DPos;
      New(p^.FData);
      InitializeVariant(p^.FData, GetTypeNo(OutReg), btu32);
      p^.FData^.tu32 := Indata^.VProcNo;
      WriteCommand(CM_A);
      WriteOutRec( OutReg, False);
      WriteOutRec(p, True);
      DisposePValue(p);
    end else
    if (InData^.FType = CVAL_Proc) or (InData^.FType = CVAL_VarProc) then
    begin
      if not CheckCompatType(OutReg, InData) then
      begin
        MakeError('', ecTypeMismatch, '')^.Position := InData^.DPos;
        Result := False;
        exit;
      end;

      if InData^.FType = CVAL_VarProc then
      begin
        if not ProcessVarFunction(InData^.Modifiers, InData^._ProcNo, InData^._Parameters, OutReg) then
        begin
          Result := False;
          exit;
        end;
      end else begin
        if not ProcessFunction(InData^.Modifiers, InData^.ProcNo, InData^.Parameters, OutReg) then
        begin
          Result := False;
          exit;
        end;
      end;
      if Indata^.Modifiers = 1 then begin
        PreWriteOutRec(OutReg, Cardinal(-1));
        if (at2ut(FBooleanType) = GetTypeNo(OutReg)) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
        WriteOutRec(OutReg, False);
        AfterWriteOutRec(OutReg);
      end else if Indata^.Modifiers = 2 then begin
        PreWriteOutRec(OutReg, Cardinal(-1));
        WriteCommand(cm_vm);
        WriteOutRec(OutReg, False);
        AfterWriteOutRec(OutReg);
      end;
    end
    else if InData^.FType = CVAL_Eval then
    begin
      if CheckOutreg(InData, OutReg) then
      begin
        tmpcalc := AllocStackReg(GetTypeNo(OutReg));
        if not WriteCalculation(InData, TmpCalc) then
        begin
          DisposeStackReg(tmpcalc);
          Result := False;
          exit;
        end;
        if not WriteCalculation(TmpCalc, OutReg) then
        begin
          DisposeStackReg(tmpcalc);
          Result := False;
          exit;
        end;
        DisposeStackReg(tmpcalc);
      end else begin
        bmodsave := Indata^.Modifiers and 15;
        p := PCalc_Item(InData^.SubItems.GetItem(0))^.OutRec;
        C := PCalc_Item(InData^.SubItems.GetItem(1))^.calcCmd;
        if not PreWriteOutRec(OutReg, Cardinal(-1)) then
        begin
          Result := False;
          exit;
        end;
        if c >= 10 then
        begin
          tmpcalc := p;
        end else begin
          if not WriteCalculation(p, OutReg) then
          begin
            Result := False;
            exit;
          end; {if}
          tmpcalc := nil;
        end;
        for l := 0 to ((InData^.SubItems.Count - 1) div 2) - 1 do
        begin
          p := PCalc_Item(InData^.SubItems.GetItem((l shl 1) + 2))^.OutRec;
          C := PCalc_Item(InData^.SubItems.GetItem((l shl 1) + 1))^.calcCmd;
          if C < 10 then
          begin
            if p^.FType = CVAL_Eval then
            begin
              PreWriteOutRec( OutReg, Cardinal(-1)); {error}
              PT := AllocStackReg(GetTypeNo(OutReg));
              if not WriteCalculation(p, PT) then
              begin
                DisposeStackReg(PT);
                Result := False;
                exit;
              end; {if}
              WriteCommand(CM_CA);
              WriteData(C, 1);
              if not WriteOutRec(OutReg, False) then
              begin
                MakeError('', ecInternalError, '00001');
                DisposeStackReg(pt);
                Result := False;
                exit;
              end; {if}
              if not WriteOutRec(PT, True) then
              begin
                MakeError('', ecInternalError, '00002');
                DisposeStackReg(pt);
                Result := False;
                exit;
              end; {if}
              AfterWriteOutRec(Pt);
              DisposeStackReg(PT);
              AfterWriteOutRec(OutReg);
            end
            else if (p^.FType = CVAL_Proc) or (P^.Ftype = CVAL_VarProc) or (p^.FType = CVAL_Cast) then
            begin
              PT := AllocStackReg(GetTypeNo(OutReg));
              if not WriteCalculation(p, Pt) then
              begin
                DisposeStackReg(Pt);
                Result := False;
                exit;
              end;
              PreWriteOutRec(OutReg, Cardinal(-1)); {error}
              PreWriteOutRec(pt, Cardinal(-1)); {error}
              WriteCommand(CM_CA);
              WriteData(C, 1);
              if not WriteOutRec(OutReg, False) then
              begin
                MakeError('', ecInternalError, '00005');
                Result := False;
                exit;
              end; {if}
              if not WriteOutRec(pt, True) then
              begin
                MakeError('', ecInternalError, '00006');
                Result := False;
                exit;
              end; {if}
              AfterWriteOutRec(p);
              AfterWriteOutRec(OutReg);
              DisposeStackReg(Pt);
            end else begin
              PreWriteOutRec(OutReg, Cardinal(-1)); {error}
              PreWriteOutRec(p, GetTypeNo(Outreg)); {error}
              WriteCommand(CM_CA);
              WriteData(C, 1);
              if not WriteOutRec(OutReg, False) then
              begin
                MakeError('', ecInternalError, '00005');
                Result := False;
                exit;
              end; {if}
              if not WriteOutRec(p, True) then
              begin
                MakeError('', ecInternalError, '00006');
                Result := False;
                exit;
              end; {if}
              AfterWriteOutRec(p);
              AfterWriteOutRec(OutReg);

            end; {else if}
          end
          else
          begin
            C := C - 10;
            if p^.FType = CVAL_Eval then
            begin

              PT := AllocStackReg(p^.frestype);
              if not WriteCalculation(p, PT) then
              begin
                DisposeStackReg(PT);
                Result := False;
                exit;
              end; {if}
              if GetTypeNo(OutReg)<> at2ut(FBooleanType) then
              begin
                PT2 := AllocStackReg(at2ut(FBooleanType));
              end
              else
                PT2 := OutReg;
              PreWriteOutRec(OutReg, Cardinal(-1));
              if tmpcalc <> nil then PreWriteOutRec(Tmpcalc, Cardinal(-1));
              WriteCommand(CM_CO);
              WriteByte(C);
              if (pt2 = OutReg) then
              begin
                if not WriteOutRec(OutReg, False) then
                begin
                  MakeError('', ecInternalError, '00007');
                  Result := False;
                  exit;
                end; {if}
              end
              else
              begin
                if not WriteOutRec(pt2, False) then
                begin
                  MakeError('', ecInternalError, '00007');
                  Result := False;
                  exit;
                end; {if}
              end;
              if tmpcalc <> nil then
              begin
                if not WriteOutRec(tmpcalc, True) then
                begin
                  MakeError('', ecInternalError, '00008');
                  Result := False;
                  exit;
                end; {if}
              end else begin
                if not WriteOutRec(OutReg, False) then
                begin
                  MakeError('', ecInternalError, '00008');
                  Result := False;
                  exit;
                end; {if}
              end;
              if not WriteOutRec(PT, True) then
              begin
                MakeError('', ecInternalError, '00009');
                Result := False;
                exit;
              end; {if}
              if tmpcalc <> nil then begin
                AfterWriteOutRec(Tmpcalc);
                tmpcalc := nil;
              end;
              AfterWriteOutRec(OutReg);
              DisposeStackReg(PT);
              if pt2 <> OutReg then
              begin
                if (OutReg^.FType <> CVAL_Addr) or (OutReg^.Address <
                  IFPSAddrNegativeStackStart) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position :=
                    OutReg^.DPos;
                  DisposeStackReg(PT);
                  Result := False;
                  exit;
                end;
                PIFPSProcVar(Proc.ProcVars.GetItem(OutReg^.Address - 1 -
                  IFPSAddrStackStart)).AType := GetType(btS32);
                WriteCommand(Cm_ST); // set stack type
                WriteLong(PIFPSProcVar(Proc.ProcVars.GetItem(OutReg^.Address
                  - 1 - IFPSAddrStackStart)).AType);
                WriteLong(OutReg^.Address - IFPSAddrStackStart);
                WriteCommand(CM_A); // stack assignment
                WriteCommand(CVAL_Addr);
                WriteLong(OutReg^.Address);
                if not WriteOutRec(pt2, False) then
                begin
                  MakeError('', ecInternalError, '0000A');
                  DisposeStackReg(PT);
                  Result := False;
                  exit;
                end;
                DisposeStackReg(pt2);
              end;

            end
            else if p^.FType = CVAL_Proc then
            begin
              if GetTypeNo(OutReg)<> at2ut(FBooleanType) then
              begin
                PT2 := AllocStackReg(at2ut(FBooleanType));
              end
              else
                PT2 := OutReg;
              if TIFPSProcedure(FProcs.GetItem(p^.ProcNo)).ClassType = TIFPSInternalProcedure then
                PT := AllocStackReg(StrToIntDef(Fw(TIFPSInternalProcedure(FProcs.GetItem(p^.ProcNo)).Decl), -1))
              else
                PT := AllocStackReg(StrToIntDef(Fw(TIFPSExternalProcedure(FProcs.GetItem(p^.ProcNo)).RegProc.Decl), -1));
              if not ProcessFunction(p^.Modifiers, p^.ProcNo, p^.Parameters, PT) then
              begin
                Result := False;
                exit;
              end;
              pt^.Modifiers := p^.modifiers;
              WriteCalculation(pt, pt);
              pt^.Modifiers := 0;
              PreWriteOutRec(OutReg, Cardinal(-1));
              if tmpcalc <> nil then PreWriteOutRec(tmpcalc, Cardinal(-1));
              WriteCommand(CM_CO);
              WriteByte(C);
              if pt2 = Outreg then
              begin
                if not WriteOutRec(OutReg, False) then
                begin
                  MakeError('', ecInternalError, '0000B');
                  Result := False;
                  exit;
                end; {if}
              end
              else
              begin
                if not WriteOutRec(pt2, False) then
                begin
                  MakeError('', ecInternalError, '0000B');
                  Result := False;
                  exit;
                end; {if}
              end;
              if tmpcalc <> nil then
              begin
                if not WriteOutRec(tmpcalc, true) then
                begin
                  MakeError('', ecInternalError, '0000C');
                  Result := False;
                  exit;
                end; {if}
              end else begin
                if not WriteOutRec(OutReg, False) then
                begin
                  MakeError('', ecInternalError, '0000C');
                  Result := False;
                  exit;
                end; {if}
              end;
              if not WriteOutRec(PT, True) then
              begin
                MakeError('', ecInternalError, '0000D');
                Result := False;
                exit;
              end; {if}
              if TmpCalc <> nil then
              begin
                AfterWriteOutRec(TmpCalc);
                tmpcalc := nil;
              end;
              AfterWriteOutRec(OutReg);
              DisposeStackReg(PT);
              if pt2 <> OutReg then
              begin
                if (OutReg^.FType <> CVAL_Addr) or (OutReg^.Address <
                  IFPSAddrNegativeStackStart) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position :=
                    InData^.DPos;
                  DisposeStackReg(pt2);
                  Result := False;
                  exit;
                end;
                PIFPSProcVar(Proc.ProcVars.GetItem(OutReg^.Address - 1 -
                  IFPSAddrStackStart)).AType := GetType(btS32);
                WriteCommand(Cm_ST); // set stack type
                WriteLong(PIFPSProcVar(Proc.ProcVars.GetItem(OutReg^.Address
                  - 1
                  - IFPSAddrStackStart)).AType);
                WriteLong(OutReg^.Address - IFPSAddrStackStart);

                WriteCommand(CM_A); // stack assignment
                WriteCommand(CVAL_Addr);
                WriteLong(OutReg^.Address);
                if not WriteOutRec(pt2, False) then
                begin
                  MakeError('', ecInternalError, '0000E');
                  DisposeStackReg(pt2);
                  Result := False;
                  exit;
                end; {if}
                DisposeStackReg(pt2);
              end;
            end
            else
            begin
              if GetTypeNo(OutReg)<> at2ut(FBooleanType) then
              begin
                PT := AllocStackReg(at2ut(FBooleanType));
              end
              else
                PT := OutReg;
              PreWriteOutRec(OutReg, Cardinal(-1));
              PreWriteOutRec(P, GetTypeNo(Outreg));
              if TmpCalc <> nil then PreWriteOutRec(tmpcalc, Cardinal(-1));

              WriteCommand(CM_CO);
              WriteData(C, 1);
              if Pt = OutReg then
              begin
                if not WriteOutRec(OutReg, False) then
                begin
                  MakeError('', ecInternalError, '0000F');
                  Result := False;
                  exit;
                end; {if}
              end
              else
              begin
                if not WriteOutRec(PT, False) then
                begin
                  MakeError('', ecInternalError, '0000F');
                  Result := False;
                  exit;
                end; {if}
              end;
              if tmpcalc <> nil then
              begin
                if not WriteOutRec(tmpcalc, True) then
                begin
                  MakeError('', ecInternalError, '00010');
                  DisposeStackReg(PT);
                  Result := False;
                  exit;
                end; {if}
              end else begin
                if not WriteOutRec(OutReg, False) then
                begin
                  MakeError('', ecInternalError, '00010');
                  DisposeStackReg(PT);
                  Result := False;
                  exit;
                end; {if}
              end;
              if not WriteOutRec(p, True) then
              begin
                MakeError('', ecInternalError, '00011');
                DisposeStackReg(PT);
                Result := False;
                exit;
              end; {case}
              if TmpCalc <> nil then begin
                AfterWriteOutRec(tmpcalc);
                tmpcalc := nil;
              end;
              AfterWriteOutRec(P);
              AfterWriteOutRec(OutReg);
              if PT <> OutReg then
              begin
                if (OutReg^.FType <> CVAL_Addr) or (OutReg^.Address < IFPSAddrNegativeStackStart) then
                begin
                  MakeError('', ecTypeMismatch, '')^.Position :=
                    InData^.DPos;
                  DisposeStackReg(PT);
                  Result := False;
                  exit;
                end;
                PIFPSProcVar(Proc.ProcVars.GetItem(OutReg^.Address - 1 -
                  IFPSAddrStackStart)).AType := GetType(btS32);
                WriteCommand(Cm_ST); // set stack type
                WriteLong(PIFPSProcVar(Proc.ProcVars.GetItem(OutReg^.Address
                  - 1
                  - IFPSAddrStackStart)).AType);
                WriteLong(OutReg^.Address - IFPSAddrStackStart);

                WriteCommand(CM_A); // stack assignment
                WriteCommand(CVAL_Addr);
                WriteLong(OutReg^.Address);
                if not WriteOutRec(PT, False) then
                begin
                  MakeError('', ecInternalError, '00012');
                  DisposeStackReg(PT);
                  Result := False;
                  exit;
                end; {if}
                DisposeStackReg(PT);
              end;
            end; {else if}
          end;
        end; {for}

        l := outreg^.modifiers;
        OutReg^.Modifiers := outreg^.Modifiers or bmodsave;
        WriteCalculation(OutReg, OutReg);
        outreg^.modifiers := l;
        AfterWriteOutRec(OutReg);
      end; {if}
    end
    else
    begin
      if not SameReg(OutReg, InData) then
      begin
        if (indata^.FType <> CVAL_NIL) and not CheckCompatType(OutReg, InData) then
        begin
          MakeError('', ecTypeMismatch, '')^.Position := InData^.DPos;
          Result := False;
          exit;
        end;
        if not PreWriteOutRec(InData, GetTypeNo(Outreg)) then
        begin
          Result := False;
          exit;
        end;
        if not PreWriteOutRec(OutReg, Cardinal(-1)) then
        begin
          Result := False;
          Exit;
        end;
        WriteCommand(CM_A);
        if not WriteOutRec(OutReg, False) then
        begin
          MakeError('', ecInternalError, '00013');
          AfterWriteOutRec(OutReg);
          AfterWriteOutRec(InData);
          Result := False;
          exit;
        end; {if}
        if not WriteOutRec(InData, True) then
        begin
          MakeError('', ecInternalError, '00014');
          AfterWriteOutRec(OutReg);
          AfterWriteOutRec(InData);
          Result := False;
          exit;
        end; {if}
        AfterWriteOutRec(OutReg);
        AfterWriteOutRec(InData);
      end else if (InData^.Modifiers and 1) <> 0 then begin
        InData^.Modifiers := 0;
        PreWriteOutRec(InData, GetTypeNo(Outreg));
        if (at2ut(FBooleanType) = GetTypeNo(Indata)) then
          WriteCommand(cm_bn)
        else
          WriteCommand(cm_in);
        WriteOutRec(InData, False);
        AfterWriteOutRec(InData);
      end else if (InData^.Modifiers and 2) <> 0 then begin
        InData^.Modifiers := 0;
        PreWriteOutRec(InData, GetTypeNo(Outreg));
        WriteCommand(cm_vm);
        WriteOutRec(InData, False);
        AfterWriteOutRec(InData);
      end;
    end; {if}
    Result := True;
  end; {WriteCalculation}

  function ProcessFunction(ResModifiers: Byte; ProcNo: Cardinal; InData: TIfList;
    ResultRegister:
    PIFPSValue): Boolean;
  var
    res: string;
    Tmp: PParam;
    respointer, tmpreg, resreg: PIFPSValue;
    l: Longint;

    procedure CleanParams;
    var
      l: Longint;
      x: PIFPSValue;
    begin
      for l := 0 to InData.Count - 1 do
      begin
        x := PParam(InData.GetItem(l))^.OutReg;
        if x <> nil then
        begin
          DisposeStackReg(x);
        end;
      end;
      if resreg <> nil then
      begin
        if Cardinal(StrTointDef(Res, -1)) <> GetTypeNo(resreg) then
        begin
          ResultRegister^.Modifiers := ResModifiers;
          if not WriteCalculation(ResultRegister, resreg) then
          begin
            Result := False;
          end;

          DisposeStackReg(ResultRegister);
        end else DisposeStackReg(resreg);
      end;
    end;
  begin
    if TIFPSProcedure(FProcs.GetItem(ProcNo)).ClassType = TIFPSInternalProcedure then
      res := TIFPSInternalProcedure(FProcs.GetItem(ProcNo)).Decl
    else
      res := TIFPSExternalProcedure(FProcs.GetItem(ProcNo)).RegProc.Decl;
    if Pos(' ', res) > 0 then
      res := copy(res, 1, Pos(' ', res) - 1);
    Result := False;
    if (ResModifiers and 8 <> 0) then
    begin
      if (ResultRegister = nil) then
      begin
        MakeError('', ecNoResult, '');
        Exit;
      end else resreg := nil;
    end else
    if (res = '-1') and (ResultRegister <> nil) then
    begin
      MakeError('', ecNoResult, '');
      exit;
    end
    else if (res <> '-1')  then
    begin
      if (ResultRegister = nil) then
      begin
        resreg := AllocStackReg(StrToInt(res));
        ResultRegister := resreg;
      end else if Cardinal(StrTointDef(Res, -1)) <> GetTypeNo(ResultRegister) then
      begin
        resreg := ResultRegister;
        ResultRegister := AllocStackReg(StrToInt(res));
      end else resreg := nil;
    end
    else
      resreg := nil;

    for l := InData.Count - 1 downto 0 do
    begin
      Tmp := InData.GetItem(l);
      if (Tmp^.InReg^.FType = CVAL_PushAddr) then
      begin
        tmpreg := AllocStackReg(GetType(btPointer));
        PreWriteOutRec(Tmp^.InReg, Cardinal(-1));
        WriteCommand(cm_sp);
        WriteOutRec(tmpreg, False);
        WriteOutRec(Tmp^.InReg, False);
        AfterWriteOutRec(Tmp^.InReg);
        Tmp^.OutReg := tmpreg;
      end
      else
      begin
        Tmp^.OutReg := AllocStackReg(Tmp^.FType);
        if not WriteCalculation(Tmp^.InReg, Tmp^.OutReg) then
        begin
          CleanParams;
          exit;
        end;
      end;
      DisposePValue(Tmp^.InReg);
      Tmp^.InReg := nil;
    end; {for}
    if (res <> '-1') or (ResModifiers and 8 <> 0) then
    begin
      respointer := AllocStackReg(GetType(btPointer));
      if not PreWriteOutRec(ResultRegister, Cardinal(-1)) then
      begin
        CleanParams;
        DisposeStackReg(ResPointer);
        exit;
      end;
      Writecommand(cm_sp);
      if not WriteOutRec(ResPointer, False) then
      begin
        CleanParams;
        DisposeStackReg(ResPointer);
        exit;
      end;
      if not WriteOutRec(ResultRegister, False) then
      begin
        CleanParams;
        DisposeStackReg(ResPointer);
        exit;
      end;
      AfterWriteOutRec(ResultRegister);
    end else respointer := nil;
    WriteCommand(Cm_C);
    WriteLong(ProcNo);
    if ResPointer <> nil then
      DisposeStackReg(respointer);
    Result := True;
    CleanParams;
  end; {ProcessFunction}

  function ProcessVarFunction(ResModifiers: Byte; ProcNo: PIFPSValue; InData: TIfList;
    ResultRegister: PIFPSValue): Boolean;
  var
    res: string;
    Tmp: PParam;
    resreg: PIFPSValue;
    l: Longint;

    procedure CleanParams;
    var
      l: Longint;
      x: PIFPSValue;
    begin
      for l := 0 to InData.Count - 1 do
      begin
        x := PParam(InData.GetItem(l))^.OutReg;
        if x <> nil then
        begin
          DisposeStackReg(x);
        end;
      end;
      AfterWriteOutRec(ProcNo);
      if resreg <> nil then
      begin
        if Cardinal(StrTointDef(Res, -1)) <> GetTypeNo(resreg) then
        begin
          ResultRegister^.Modifiers := ResModifiers;
          WriteCalculation(ResultRegister, resreg);
          DisposeStackReg(ResultRegister);
        end else DisposeStackReg(resreg);
      end;
    end;
  begin
    res := TIFPSProceduralType(FUsedTypes.GetItem(GetTypeNo(ProcNo))).ProcDef;
    if Pos(' ', res) > 0 then
      res := copy(res, 1, Pos(' ', res) - 1);
    Result := False;
    if (res = '-1') and (ResultRegister <> nil) then
    begin
      MakeError('', ecNoResult, '');
      exit;
    end
    else if (res <> '-1')  then
    begin
      if (ResultRegister = nil) then
      begin
        resreg := AllocStackReg(StrToInt(res));
        ResultRegister := resreg;
      end else if Cardinal(StrTointDef(Res, -1)) <> GetTypeNo(ResultRegister) then
      begin
        resreg := ResultRegister;
        ResultRegister := AllocStackReg(StrToInt(res));
      end else resreg := nil;
    end
    else
      resreg := nil;

    PreWriteOutRec(ProcNo, Cardinal(-1));
    for l := InData.Count - 1 downto 0 do
    begin
      Tmp := InData.GetItem(l);
      if (Tmp^.InReg^.FType = CVAL_PushAddr) then
      begin
        Tmp^.OutReg := AllocStackReg2(Tmp^.FType);
        PreWriteOutRec(Tmp^.InReg, Cardinal(-1));
        WriteCommand(CM_PV);
        WriteOutRec(Tmp^.InReg, False);
        AfterWriteOutRec(Tmp^.InReg);
      end
      else
      begin
        Tmp^.OutReg := AllocStackReg(Tmp^.FType);
        if not WriteCalculation(Tmp^.InReg, Tmp^.OutReg) then
        begin
          CleanParams;
          exit;
        end;
      end;
      DisposePValue(Tmp^.InReg);
      Tmp^.InReg := nil;
    end; {for}
    if res <> '-1' then
    begin
      WriteCommand(CM_PV);
      if not WriteOutRec(ResultRegister, False) then
      begin
        CleanParams;
        MakeError('', ecInternalError, '00015');
        exit;
      end;
    end;
    WriteCommand(Cm_cv);
    WriteOutRec(ProcNo, True);
    if res <> '-1' then
      WriteCommand(CM_PO);
    Result := True;
    CleanParams;
  end; {ProcessVarFunction}

  function HasInvalidJumps(StartPos, EndPos: Cardinal): Boolean;
  var
    I, J: Longint;
    Ok: LongBool;
    FLabelsInBlock: TIfStringList;
    s: string;
  begin
    FLabelsInBlock := TIfStringList.Create;
    for i := 0 to Proc.FLabels.Count -1 do
    begin
      s := Proc.FLabels.GetItem(I);
      if (Cardinal((@s[1])^) >= StartPos) and (Cardinal((@s[1])^) <= EndPos) then
      begin
        Delete(s, 1, 8);
        FLabelsInBlock.Add(s);
      end;
    end;
    for i := 0 to Proc.FGotos.Count -1 do
    begin
      s := Proc.FGotos.GetItem(I);
      if (Cardinal((@s[1])^) >= StartPos) and (Cardinal((@s[1])^) <= EndPos) then
      begin
        Delete(s, 1, 8);
        OK := False;
        for J := 0 to FLabelsInBlock.Count -1 do
        begin
          if FLabelsInBlock.GetItem(J) = s then
          begin
            Ok := True;
            Break;
          end;
        end;
        if not Ok then
        begin
          MakeError('', ecInvalidJump, '');
          Result := True;
          FLabelsInBlock.Free;
          exit;
        end;
      end else begin
        Delete(s, 1, 4);
        OK := True;
        for J := 0 to FLabelsInBlock.Count -1 do
        begin
          if FLabelsInBlock.GetItem(J) = s then
          begin
            Ok := False;
            Break;
          end;
        end;
        if not Ok then
        begin
          MakeError('', ecInvalidJump, '');
          Result := True;
          FLabelsInBlock.Free;
          exit;
        end;
      end;
    end;
    FLabelsInBlock.Free;
    Result := False;
  end;

  function ProcessFor: Boolean;
    { Process a for x := y to z do }
  var
    SavedTokenPos: Cardinal;
    VVar: PIFPSValue;
    TempVar,
      InitialVal,
      finalVal: PIFPSValue;
    Backwards: Boolean;
    FPos, NPos, EPos, RPos: Longint;
    OldCO, OldBO: TIfList;
    I: Longint;
  begin
    Result := False;
    SavedTokenPos := FParser.CurrTokenPos;
    FParser.Next;
    if FParser.CurrTokenId <> CSTI_Identifier then
    begin
      MakeError('', ecIdentifierExpected, '');
      exit;
    end;
    VVar := GetIdentifier(1);
    if VVar = nil then
      exit;
    case PIFPSType(FUsedTypes.GetItem(GetTypeNo(VVar))).BaseType of
      btU8, btS8, btU16, btS16, btU32, btS32: ;
    else
      begin
        MakeError('', ecTypeMismatch, '');
        DisposePValue(VVar);
        exit;
      end;
    end;
    if FParser.CurrTokenId <> CSTI_Assignment then
    begin
      MakeError('', ecAssignmentExpected, '');
      DisposePValue(VVar);
      exit;
    end;
    FParser.Next;
    InitialVal := calc(CSTII_DownTo);
    if InitialVal = nil then
    begin
      DisposePValue(VVar);
      exit;
    end;
    if FParser.CurrTokenId = CSTII_To then
      Backwards := False
    else if FParser.CurrTokenId = CSTII_DownTo then
      Backwards := True
    else
    begin
      MakeError('', ecToExpected, '');
      DisposePValue(VVar);
      DisposePValue(InitialVal);
      exit;
    end;
    FParser.Next;
    finalVal := calc(CSTII_do);
    if finalVal = nil then
    begin
      DisposePValue(VVar);
      DisposePValue(InitialVal);
      exit;
    end;
    if FParser.CurrTokenId <> CSTII_do then
    begin
      MakeError('', ecDoExpected, '');
      DisposePValue(VVar);
      DisposePValue(InitialVal);
      DisposePValue(finalVal);
      exit;
    end;
    FParser.Next;
    if not WriteCalculation(InitialVal, VVar) then
    begin
      DisposePValue(VVar);
      DisposePValue(InitialVal);
      DisposePValue(finalVal);
      exit;
    end;
    DisposePValue(InitialVal);
    TempVar := AllocStackReg(at2ut(FBooleanType));
    Debug_WriteLineEx(SavedTokenPos);
    NPos := Length(Proc.Data);
    PreWriteOutRec(VVar, Cardinal(-1));
    PreWriteOutRec(finalVal, Cardinal(-1));
    WriteCommand(CM_CO);
    if Backwards then
    begin
      WriteByte(0); { >= }
    end
    else
    begin
      WriteByte(1); { <= }
    end;
    if not WriteOutRec(TempVar, False) then
    begin
      DisposeStackReg(TempVar);
      DisposePValue(VVar);
      DisposePValue(finalVal);
      exit;
    end;
    WriteOutRec(VVar, False);
    WriteOutRec(finalVal, True);
    AfterWriteOutRec(finalVal);
    AfterWriteOutRec(VVar);
    DisposePValue(finalVal);
    WriteCommand(Cm_CNG);
    EPos := Length(Proc.Data);
    WriteLong($12345678);
    WriteOutRec(TempVar, False);
    RPos := Length(Proc.Data);
    OldCO := FContinueOffsets;
    FContinueOffsets := TIfList.Create;
    OldBO := FBreakOffsets;
    FBreakOffsets := TIFList.Create;
    if not ProcessSub(tOneliner, ProcNo, proc) then
    begin
      DisposeStackReg(TempVar);
      DisposePValue(VVar);
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      exit;
    end;
    New(InitialVal);  // ML
    InitialVal^.Modifiers := 0;
    InitialVal^.DPos := FParser.CurrTokenPos;
    InitialVal^.FType := CVAL_Data;
    New(InitialVal^.FData); // ML
    InitializeVariant(InitialVal^.FData, GetTypeNo(VVar), 0);
    InitialVal^.FData.BaseType := PIFPSType(FUsedTypes.GetItem(InitialVal^.FData^.FType)).BaseType;
    case InitialVal^.FData.BaseType of
      btU8, btS8: InitialVal^.FData^.tu8 := 1;
      btU16, btS16: InitialVal^.FData^.tu16 := 1;
      btU32, btS32: InitialVal^.FData^.tu32 := 1;
    else
      begin
        MakeError('', ecInternalError, '00019');
        DisposeStackReg(TempVar);
        DisposePValue(VVar);
        DisposePValue(InitialVal);
        FBreakOffsets.Free;
        FContinueOffsets.Free;
        FContinueOffsets := OldCO;
        FBreakOffsets := OldBo;
        exit;
      end;
    end;
    FPos := Length(Proc.Data);
    PreWriteOutRec(InitialVal, Cardinal(-1));
    PreWriteOutRec(VVar, Cardinal(-1));
    WriteCommand(CM_CA);
    if Backwards then
      WriteByte(1) {-}
    else
      WriteByte(0); {+}
    WriteOutRec(VVar, False);
    WriteOutRec(InitialVal, True);
    AfterWriteOutRec(VVar);
    AfterWriteOutRec(InitialVal);
    DisposePValue(InitialVal);
    WriteCommand(Cm_G);
    WriteLong(Longint(NPos - Length(Proc.Data) - 4));
    Longint((@Proc.Data[EPos + 1])^) := Length(Proc.Data) - RPos;
    for i := 0 to FBreakOffsets.Count -1 do
    begin
      EPos := Cardinal(FBreakOffsets.GetItem(I));
      Longint((@Proc.Data[EPos - 3])^) := Length(Proc.Data) - Longint(EPos);
    end;
    for i := 0 to FContinueOffsets.Count -1 do
    begin
      EPos := Cardinal(FContinueOffsets.GetItem(I));
      Longint((@Proc.Data[EPos - 3])^) := Longint(FPos) - Longint(EPos);
    end;
    FBreakOffsets.Free;
    FContinueOffsets.Free;
    FContinueOffsets := OldCO;
    FBreakOffsets := OldBo;
    DisposeStackReg(TempVar);
    DisposePValue(VVar);
    if HasInvalidJumps(RPos, Length(Proc.Data)) then
    begin
      Result := False;
      exit;
    end;
    Result := True;
  end; {ProcessFor}

  function ProcessWhile: Boolean;
  var
    SavedTokenPos: Cardinal;
    vin, vout: PIFPSValue;
    SPos, EPos: Cardinal;
    OldCo, OldBO: TIfList;
    I: Longint;
  begin
    Result := False;
    SavedTokenPos := FParser.CurrTokenPos;
    FParser.Next;
    vout := calc(CSTII_do);
    if vout = nil then
      exit;
    if FParser.CurrTokenId <> CSTII_do then
    begin
      DisposePValue(vout);
      MakeError('', ecDoExpected, '');
      exit;
    end;
    vin := AllocStackReg(at2ut(FBooleanType));
    Debug_WriteLineEx(SavedTokenPos);
    SPos := Length(Proc.Data); // start position
    OldCo := FContinueOffsets;
    FContinueOffsets := TIfList.Create;
    OldBO := FBreakOffsets;
    FBreakOffsets := TIFList.Create;
    if not WriteCalculation(vout, vin) then
    begin
      DisposePValue(vout);
      DisposeStackReg(vin);
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      exit;
    end;
    DisposePValue(vout);
    FParser.Next; // skip DO
    WriteCommand(Cm_CNG); // only goto if expression is false
    WriteLong($12345678);
    EPos := Length(Proc.Data);
    if not WriteOutRec(vin, False) then
    begin
      MakeError('', ecInternalError, '00017');
      DisposeStackReg(vin);
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      exit;
    end;
    if not ProcessSub(tOneliner, ProcNo, proc) then
    begin
      DisposeStackReg(vin);
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      exit;
    end;
    WriteCommand(Cm_G);
    WriteLong(Longint(SPos) - Length(Proc.Data) - 4);
    Longint((@Proc.Data[EPos - 3])^) := Length(Proc.Data) - Longint(EPos) - 5;
    for i := 0 to FBreakOffsets.Count -1 do
    begin
      EPos := Cardinal(FBreakOffsets.GetItem(I));
      Longint((@Proc.Data[EPos - 3])^) := Length(Proc.Data) - Longint(EPos);
    end;
    for i := 0 to FContinueOffsets.Count -1 do
    begin
      EPos := Cardinal(FContinueOffsets.GetItem(I));
      Longint((@Proc.Data[EPos - 3])^) := Longint(SPos) - Longint(EPos);
    end;
    FBreakOffsets.Free;
    FContinueOffsets.Free;
    FContinueOffsets := OldCO;
    FBreakOffsets := OldBo;
    DisposeStackReg(vin);
    if HasInvalidJumps(EPos, Length(Proc.Data)) then
    begin
      Result := False;
      exit;
    end;
    Result := True;
  end;

  function ProcessRepeat: Boolean;
  var
    vin, vout: PIFPSValue;
    SPos, EPos: Cardinal;
    I: Longint;
    OldCo, OldBO: TIfList;
  begin
    Result := False;
    FParser.Next;
    OldCo := FContinueOffsets;
    FContinueOffsets := TIfList.Create;
    OldBO := FBreakOffsets;
    FBreakOffsets := TIFList.Create;
    vin := AllocStackReg(at2ut(FBooleanType));
    SPos := Length(Proc.Data);
    if not ProcessSub(tRepeat, ProcNo, proc) then
    begin
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      DisposeStackReg(vin);
      exit;
    end;
    FParser.Next; //cstii_until
    vout := calc(CSTI_Semicolon);
    if vout = nil then
    begin
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      DisposeStackReg(vin);
      exit;
    end;
    if not WriteCalculation(vout, vin) then
    begin
      DisposePValue(vout);
      DisposeStackReg(vin);
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      exit;
    end;
    DisposePValue(vout);
    WriteCommand(Cm_CNG);
    WriteLong($12345678);
    EPos := Length(Proc.Data);
    if not WriteOutRec(vin, False) then
    begin
      MakeError('', ecInternalError, '00016');
      DisposeStackReg(vin);
      FBreakOffsets.Free;
      FContinueOffsets.Free;
      FContinueOffsets := OldCO;
      FBreakOffsets := OldBo;
      exit;
    end;
    Longint((@Proc.Data[EPos - 3])^) := Longint(SPos) -
      Length(Proc.Data);
    for i := 0 to FBreakOffsets.Count -1 do
    begin
      EPos := Cardinal(FBreakOffsets.GetItem(I));
      Longint((@Proc.Data[EPos - 3])^) := Length(Proc.Data) - Longint(EPos);
    end;
    for i := 0 to FContinueOffsets.Count -1 do
    begin
      EPos := Cardinal(FContinueOffsets.GetItem(I));
      Longint((@Proc.Data[EPos - 3])^) := Longint(SPos) - Longint(EPos);
    end;
    FBreakOffsets.Free;
    FContinueOffsets.Free;
    FContinueOffsets := OldCO;
    FBreakOffsets := OldBo;
    DisposeStackReg(vin);
    if HasInvalidJumps(SPos, Length(Proc.Data)) then
    begin
      Result := False;
      exit;
    end;
    Result := True;
  end; {ProcessRepeat}

  function ProcessIf: Boolean;
  var
    vout, vin: PIFPSValue;
    SPos, EPos: Cardinal;
  begin
    Result := False;
    Debug_WriteLine;
    FParser.Next;
    vout := calc(CSTII_Then);
    if vout = nil then
      exit;
    if FParser.CurrTokenId <> CSTII_Then then
    begin
      DisposePValue(vout);
      MakeError('', ecThenExpected, '');
      exit;
    end;
    vin := AllocStackReg(at2ut(FBooleanType));
    if not WriteCalculation(vout, vin) then
    begin
      DisposePValue(vout);
      DisposeStackReg(vin);
      exit;
    end;
    DisposePValue(vout);
    WriteCommand(cm_sf);
    if not WriteOutRec(vin, False) then
    begin
      MakeError('', ecInternalError, '00018');
      DisposeStackReg(vin);
      exit;
    end;
    WriteByte(1);
    DisposeStackReg(vin);
    WriteCommand(cm_fg);
    WriteLong($12345678);
    SPos := Length(Proc.Data);
    FParser.Next; // skip then
    if not ProcessSub(tifOneliner, Procno, proc) then
    begin
      exit;
    end;
    if FParser.CurrTokenId = CSTII_Else then
    begin
      WriteCommand(Cm_G);
      WriteLong($12345678);
      EPos := Length(Proc.Data);
      Longint((@Proc.Data[SPos - 3])^) := Length(Proc.Data) -
        Longint(SPos);
      FParser.Next;
      if not ProcessSub(tOneliner, ProcNo, proc) then
      begin
        exit;
      end;
      Longint((@Proc.Data[EPos - 3])^) := Length(Proc.Data) - Longint(EPos);
    end
    else
    begin
      Longint((@Proc.Data[SPos - 3])^) := Length(Proc.Data) -
        Longint(SPos) + 5
        - 5;
    end;
    Result := True;
  end; {ProcessIf}

  function ProcessLabel: Longint; {0 = failed; 1 = successful; 2 = no label}
  var
    I, H: Longint;
    s: string;
  begin
    h := MakeHash(FParser.GetToken);
    for i := 0 to Proc.FLabels.Count -1 do
    begin
      s := Proc.FLabels.GetItem(I);
      delete(s, 1, 4);
      if Longint((@s[1])^) = h then
      begin
        delete(s, 1, 4);
        if s = FParser.GetToken then
        begin
          s := Proc.FLabels.GetItem(I);
          Cardinal((@s[1])^) := Length(Proc.Data);
          Proc.FLabels.SetItem(i, s);
          FParser.Next;
          if fParser.CurrTokenId = CSTI_Colon then
          begin
            Result := 1;
            FParser.Next;
            exit;
          end else begin
            MakeError('', ecColonExpected, '');
            Result := 0;
            Exit;
          end;
        end;
      end;
    end;
    result := 2;
  end;

  function ProcessIdentifier: Boolean;
  var
    vin, vout: PIFPSValue;
  begin
    Result := False;
    Debug_WriteLine;
    vin := GetIdentifier(2);
    if vin <> nil then
    begin
      if vin^.FType < CVAL_Proc then
      begin // assignment needed
        if FParser.CurrTokenId <> CSTI_Assignment then
        begin
          MakeError('', ecAssignmentExpected, '');
          DisposePValue(vin);
          exit;
        end;
        FParser.Next;
        vout := calc(CSTI_Semicolon);
        if vout = nil then
        begin
          DisposePValue(vin);
          exit;
        end;
        if not WriteCalculation(vout, vin) then
        begin
          DisposePValue(vin);
          DisposePValue(vout);
          exit;
        end;
        DisposePValue(vin);
        DisposePValue(vout);
      end
      else if vin^.FType = CVAL_VarProc then
      begin
        Result := ProcessVarFunction(0, Vin^._ProcNo, vin^._Parameters, nil);
        DisposePValue(vin);
        Exit;
      end else
      begin
        Result := ProcessFunction(0, vin^.ProcNo, vin^.Parameters, nil);
        DisposePValue(vin);
        exit;
      end;
    end
    else
    begin
      Result := False;
      exit;
    end;
    Result := True;
  end; {ProcessIdentifier}

  function ProcessCase: Boolean;
  var
    TempRec, CV, Val, CalcItem: PIFPSValue;
    p: PCalc_Item;
    SPos, CurrP: Cardinal;
    I: Longint;
    EndReloc: TIfList;
  begin
    Debug_WriteLine;
    FParser.Next;
    Val := calc(CSTII_of);
    if Val = nil then
    begin
      ProcessCase := False;
      exit;
    end; {if}
    if FParser.CurrTokenId <> CSTII_Of then
    begin
      MakeError('', ecOfExpected, '');
      DisposePValue(Val);
      ProcessCase := False;
      exit;
    end; {if}
    FParser.Next;
    TempRec := AllocStackReg(GetTypeNo(Val));
    if not WriteCalculation(Val, TempRec) then
    begin
      DisposeStackReg(TempRec);
      DisposePValue(Val);
      ProcessCase := False;
      exit;
    end; {if}
    DisposePValue(Val);
    EndReloc := TIfList.Create;
    CalcItem := AllocStackReg(at2ut(FBooleanType));
    SPos := Length(Proc.Data);
    repeat
      Val := calc(CSTI_Colon);
      if (Val = nil) or (FParser.CurrTokenID <> CSTI_Colon) then
      begin
        if FParser.CurrTokenID <> CSTI_Colon then
          MakeError('', ecColonExpected, '');
        DisposeStackReg(CalcItem);
        DisposeStackReg(TempRec);
        EndReloc.Free;
        ProcessCase := False;
        exit;
      end; {if}
      FParser.Next;
      New(cv);
      cv^.DPos := FParser.CurrTokenPos;
      cv^.FType := CVAL_Eval;
      cv^.SubItems:= TIfList.Create;
      cv^.Modifiers := 0;
      new(p);
      p^.C := False;
      p^.OutRec := Val;
      cv^.SubItems.Add(p);
      new(p);
      p^.C := True;
      p^.calcCmd := 15;
      cv^.SubItems.Add(p);
      new(p);
      p^.C := False;
      p^.OutRec := TempRec;
      cv^.SubItems.Add(p);
      if not WriteCalculation(CV, CalcItem) then
      begin
        DisposeStackReg(CalcItem);
        DisposePValue(CV);
        EndReloc.Free;
        ProcessCase := False;
        exit;
      end;
      Cv.SubItems.Delete(2);
      Dispose(p);
      DisposePValue(CV);
      WriteByte(Cm_CNG);
      WriteLong($12345678);
      CurrP := Length(Proc.Data);
      WriteOutRec(CalcItem, False);
      if not ProcessSub(tifOneliner, Procno, proc) then
      begin
        DisposeStackReg(CalcItem);
        DisposeStackReg(TempRec);
        EndReloc.Free;
        ProcessCase := False;
        exit;
      end;
      WriteByte(Cm_G);
      WriteLong($12345678);
      EndReloc.Add(Pointer(Length(Proc.Data)));
      Cardinal((@Proc.Data[CurrP - 3])^) := Cardinal(Length(Proc.Data)) - CurrP - 5;
      if FParser.CurrTokenID = CSTI_Semicolon then FParser.Next;
      if FParser.CurrTokenID = CSTII_Else then
      begin
        FParser.Next;
        if not ProcessSub(tOneliner, Procno, proc) then
        begin
          DisposeStackReg(CalcItem);
          DisposeStackReg(TempRec);
          EndReloc.Free;
          ProcessCase := False;
          exit;
        end;
        if FParser.CurrTokenID = CSTI_Semicolon then FParser.Next;
        if FParser.CurrtokenId <> CSTII_End then
        begin
          MakeError('', ecEndExpected, '');
          DisposeStackReg(CalcItem);
          DisposeStackReg(TempRec);
          EndReloc.Free;
          ProcessCase := False;
          exit;
        end;
      end;
    until FParser.CurrTokenID = CSTII_End;
    FParser.Next;
    for i := 0 to EndReloc.Count -1 do
    begin
      Cardinal((@Proc.Data[Cardinal(EndReloc.GetItem(I))- 3])^) := Cardinal(Length(Proc.Data)) - Cardinal(EndReloc.GetItem(I));
    end;
    DisposeStackReg(CalcItem);
    DisposeStackReg(TempRec);
    EndReloc.Free;
    if HasInvalidJumps(SPos, Length(Proc.Data)) then
    begin
      Result := False;
      exit;
    end;
    Result := True;
  end; {ProcessCase}
  function ProcessGoto: Boolean;
  var
    I, H: Longint;
    s: string;
  begin
    Debug_WriteLine;
    FParser.Next;
    h := MakeHash(FParser.GetToken);
    for i := 0 to Proc.FLabels.Count -1 do
    begin
      s := Proc.FLabels.GetItem(I);
      delete(s, 1, 4);
      if Longint((@s[1])^) = h then
      begin
        delete(s, 1, 4);
        if s = FParser.GetToken then
        begin
          FParser.Next;
          WriteCommand(Cm_G);
          WriteLong($12345678);
          Proc.FGotos.Add(mi2s(length(Proc.Data))+mi2s(i));
          Result := True;
          exit;
        end;
      end;
    end;
    MakeError('', ecUnknownIdentifier, FParser.OriginalToken);
    Result := False;
  end; {ProcessGoto}
  function ProcessTry: Boolean;
  var
    FStartOffset: Cardinal;
  begin
    FParser.Next;
    WriteCommand(cm_puexh);
    FStartOffset := Length(Proc.Data) + 1;
    WriteLong(Cardinal(-1));
    WriteLong(Cardinal(-1));
    WriteLong(Cardinal(-1));
    WriteLong(Cardinal(-1));
    if ProcessSub(tTry, ProcNo, Proc) then
    begin
      WriteCommand(cm_poexh);
      WriteByte(0);
      if FParser.CurrTokenID = CSTII_Except then
      begin
        FParser.Next;
        Cardinal((@Proc.Data[FStartOffset + 4])^) := Cardinal(Length(Proc.Data)) - FStartOffset - 15;
        if ProcessSub(tTryEnd, ProcNo, Proc) then
        begin
          WriteCommand(cm_poexh);
          writeByte(2);
          if FParser.CurrTokenId = CSTII_Finally then
          begin
            Cardinal((@Proc.Data[FStartOffset + 8])^) := Cardinal(Length(Proc.Data)) - FStartOffset - 15;
            FParser.Next;
            if ProcessSub(tTryEnd, ProcNo, Proc) then
            begin
              if FParser.CurrTokenId = CSTII_End then
              begin
                WriteCommand(cm_poexh);
                writeByte(3);
              end else begin
                MakeError('', ecEndExpected, '');
                Result := False;
                exit;
              end;
            end else begin Result := False; exit; end;
          end else if FParser.CurrTokenID <> CSTII_End then
          begin
            MakeError('', ecEndExpected, '');
            Result := False;
            exit;
          end;
          FParser.Next;
        end else begin Result := False; exit; end;
      end else if FParser.CurrTokenId = CSTII_Finally then
      begin
        FParser.Next;
        Cardinal((@Proc.Data[FStartOffset])^) := Cardinal(Length(Proc.Data)) - FStartOffset - 15;
        if ProcessSub(tTryEnd, ProcNo, Proc) then
        begin
          WriteCommand(cm_poexh);
          writeByte(1);
          if FParser.CurrTokenId = CSTII_Except then
          begin
            Cardinal((@Proc.Data[FStartOffset + 4])^) := Cardinal(Length(Proc.Data)) - FStartOffset - 15;
            FParser.Next;
            if ProcessSub(tTryEnd, ProcNo, Proc) then
            begin
              if FParser.CurrTokenId = CSTII_End then
              begin
                WriteCommand(cm_poexh);
                writeByte(2);
              end else begin
                MakeError('', ecEndExpected, '');
                Result := False;
                exit;
              end;
            end else begin Result := False; exit; end;
          end else if FParser.CurrTokenID <> CSTII_End then
          begin
            MakeError('', ecEndExpected, '');
            Result := False;
            exit;
          end;
          FParser.Next;
        end else begin Result := False; exit; end;
      end;
    end else begin Result := False; exit; end;
    Cardinal((@Proc.Data[FStartOffset + 12])^) := Cardinal(Length(Proc.Data)) - FStartOffset - 15;
    Result := True;
  end; {ProcessTry}
begin
  ProcessSub := False;
  if (FType = tProcBegin) or (FType = tMainBegin) or (FType = tSubBegin) then
  begin
    FParser.Next; // skip CSTII_Begin
  end;
  while True do
  begin
    case FParser.CurrTokenId of
      CSTII_break:
        begin
          if FBreakOffsets = nil then
          begin
            MakeError('', ecNotInLoop, '');
            exit;
          end;
          WriteCommand(Cm_G);
          WriteLong($12345678);
          FBreakOffsets.Add(Pointer(Length(Proc.Data)));
          FParser.Next;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_Continue:
        begin
          if FBreakOffsets = nil then
          begin
            MakeError('', ecNotInLoop, '');
            exit;
          end;
          WriteCommand(Cm_G);
          WriteLong($12345678);
          FContinueOffsets.Add(Pointer(Length(Proc.Data)));
          FParser.Next;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_Goto:
        begin
          if not ProcessGoto then
            Exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_Try:
        begin
          if not ProcessTry then
            Exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_Finally, CSTII_Except:
        begin
          if (FType = tTry) or (FType = tTryEnd) then
            Break
          else
            begin
              MakeError('', ecEndExpected, '');
              Exit;
            end;
        end;
      CSTII_Begin:
        begin
          if not ProcessSub(tSubBegin, ProcNo, proc) then
            Exit;
          FParser.Next; // skip END
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTI_Semicolon:
        begin
          FParser.Next;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_until:
        begin
          Debug_WriteLine;
          if FType = tRepeat then
          begin
            break;
          end
          else
          begin
            MakeError('', ecIdentifierExpected, '');
            exit;
          end;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_Else:
        begin
          if FType = tifOneliner then
            break
          else
          begin
            MakeError('', ecIdentifierExpected, '');
            exit;
          end;
        end;
      CSTII_repeat:
        begin
          if not ProcessRepeat then
            exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_For:
        begin
          if not ProcessFor then
            exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_While:
        begin
          if not ProcessWhile then
            exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_Exit:
        begin
          Debug_WriteLine;
          WriteCommand(Cm_R);
          FParser.Next;
        end;
      CSTII_Case:
        begin
          if not ProcessCase then
            exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTII_If:
        begin
          if not ProcessIf then
            exit;
          if (FType = tifOneliner) or (FType = TOneLiner) then
            break;
        end;
      CSTI_Identifier:
        begin
          case ProcessLabel of
            0: Exit;
            1: ;
            else
            begin
              if not ProcessIdentifier then
                exit;
              if (FType = tifOneliner) or (FType = TOneLiner) then
                break;
            end;
          end; {case}
        end;
      CSTII_End:
        begin
          if (FType = tTryEnd) or (FType = tMainBegin) or (FType = tSubBegin) or (FType =
            tifOneliner) or (FType = tProcBegin) or (FType = TOneLiner) then
          begin
            break;
          end
          else
          begin
            MakeError('', ecIdentifierExpected, '');
            exit;
          end;
        end;
      CSTI_EOF:
        begin
          MakeError('', ecUnexpectedEndOfFile, '');
          exit;
        end;
    else
      begin
        MakeError('', ecIdentifierExpected, '');
        exit;
      end;
    end;
  end;
  if (FType = tMainBegin) or (FType = tProcBegin) then
  begin
    Debug_WriteLine;
    WriteCommand(Cm_R);
    FParser.Next; // skip end
    if (FType = tMainBegin) and (FParser.CurrTokenId <> CSTI_Period) then
    begin
      MakeError('', ecPeriodExpected, '');
      exit;
    end;
    if (FType = tProcBegin) and (FParser.CurrTokenId <> CSTI_Semicolon) then
    begin
      MakeError('', ecSemicolonExpected, '');
      exit;
    end;
    FParser.Next;
  end;
  ProcessSub := True;
end;


function TIFPSPascalCompiler.ProcessLabelForwards(Proc: TIFPSInternalProcedure): Boolean;
var
  i: Longint;
  s, s2: string;
begin
  for i := 0 to Proc.FLabels.Count -1 do
  begin
    s := Proc.FLabels.GetItem(i);
    if Longint((@s[1])^) = -1 then
    begin
      delete(s, 1, 8);
      MakeError('', ecUnSetLabel, s);
      Result := False;
      exit;
    end;
  end;
  for i := Proc.FGotos.Count -1 downto 0 do
  begin
    s := Proc.FGotos.GetItem(I);
    s2 := Proc.FLabels.GetItem(Cardinal((@s[5])^));
    Cardinal((@Proc.Data[Cardinal((@s[1])^)-3])^) :=  Cardinal((@s2[1])^) - Cardinal((@s[1])^) ;
  end;
  Result := True;
end;


type
  TCompilerState = (csStart, csProgram, csUnit, csUses, csInterface, csInterfaceUses, csImplementation);

function TIFPSPascalCompiler.Compile(const s: string): Boolean;
var
  Position: TCompilerState;
  i: Longint;

  procedure FreeAll;
  var
    I: Longint;
    PT: PIFPSType;
    pc: PIFPSConstant;
    pv: PIFPSVar;
  begin
    for I := 0 to FRegProcs.Count - 1 do
      TObject(FRegProcs.GetItem(I)).Free;
    FRegProcs.Free;
    for i := 0 to FConstants.Count -1 do
    begin
      pc := FConstants.GetItem(I);
      FinalizeVariant(pc^.Value);
      Dispose(pc);
    end;
    Fconstants.Free;
    for I := 0 to FVars.Count - 1 do
    begin
      pv := FVars.GetItem(I);
      Dispose(pv);
    end;
    FVars.Free;
    for I := 0 to FProcs.Count - 1 do
      TIFPSProcedure(FProcs.GetItem(I)).Free;
    FProcs.Free;
    FProcs := nil;
    for I := 0 to FAvailableTypes.Count - 1 do
    begin
      PT := FAvailableTypes.GetItem(I);
      pt.Free;
    end;
    FAvailableTypes.Free;
    FUsedTypes.Free;
  end;



  procedure MakeOutput;

    procedure WriteByte(b: Byte);
    begin
      FOutput := FOutput + Char(b);
    end;

    procedure WriteData(const Data; Len: Longint);
    var
      l: Longint;
    begin
      if Len < 0 then Len := 0;
      l := Length(FOutput);
      SetLength(FOutput, l + Len);
      Move(Data, FOutput[l + 1], Len);
    end;

    procedure WriteLong(l: Cardinal);
    begin
      WriteData(l, 4);
    end;


    procedure WriteTypes;
    var
      l, n: Longint;
      Tmp: Cardinal;
      x: PIFPSType;
//      xxp: PIFPSProceduralType;
      FExportName: string;
      procedure WriteTypeNo(TypeNo: Cardinal);
      var
        e: PIFPSType;
        i: Integer;
      begin
        e := FUsedTypes.GetItem(TypeNo);
        if e.BaseType = btRecord then
        begin
          for i := 0 to TIFPSRecordType(e).RecValCount -1 do
          begin
            WriteTypeNo(TIFPSRecordType(e).RecVal(i).FType);
          end;
        end else
          WriteData(TypeNo, 4);
      end;
    begin
      for l := 0 to FUsedTypes.Count - 1 do
      begin
        x := FUsedTypes.GetItem(l);
        if x.FExportName then
          FExportName := x.Name
        else
          FExportName := '';
        if x.BaseType = btClass then
        begin
          x := GetTypeCopyLink(FAvailableTypes.GetItem(TIFPSClassType(x).ClassHelper.SelfType));
        end;
        if (x.BaseType = btEnum) then begin
          if TIFPSEnumType(x).HighValue <= 256 then
            x.BaseType := btU8
          else if TIFPSEnumType(x).HighValue <= 65536 then
            x.BaseType := btU16
          else
            x.BaseType := btU32;
        end;
        if FExportName <> '' then
        begin
          WriteByte(x.BaseType + 128);
        end
        else
          WriteByte(X.BaseType);
        if x.BaseType = btArray then
        begin
          WriteLong(Longint(TIFPSArrayType(x).ArrayTypeNo));
        end
        else if x.BaseType = btRecord then
        begin
          n := TIFPSRecordType(x).RecValCount;
          if n <> 0 then
            N := TIFPSRecordType(x).TypeSize;
          WriteData(n, 4);
          for n := 0 to TIFPSRecordType(x).RecValCount - 1 do
          begin
            Tmp := TIFPSRecordType(x).RecVal(n).FType;
            WriteTypeNo(Tmp);
          end;
        end;
        if FExportName <> '' then
        begin
          WriteLong(Length(FExportName));
          WriteData(FExportName[1], length(FExportName));
        end;
      end;
    end;

    procedure WriteVars;
    var
      l: Longint;
      x: PIFPSVar;
    begin
      for l := 0 to FVars.Count - 1 do
      begin
        x := FVars.GetItem(l);
        WriteLong(x^.FType);
        if x^.exportname <> '' then
        begin
          WriteByte(1);
          WriteLong(Length(X^.ExportName));
          WriteData(X^.ExportName[1], length(X^.ExportName));
        end else
          WriteByte(0);
      end;
    end;

    procedure WriteProcs;
    var
      l: Longint;
      xp: TIFPSProcedure;
      xo: TIFPSInternalProcedure;
      xe: TIFPSExternalProcedure;
      s: string;
    begin
      for l := 0 to FProcs.Count - 1 do
      begin
        xp := FProcs.GetItem(l);
        if xp.ClassType = TIFPSInternalProcedure then
        begin
          xo := TIFPSInternalProcedure(xp);
          xo.OutputDeclPosition := Length(FOutput);
          if xo.aExport <> etExportNone then
            WriteByte(2) // exported
          else
            WriteByte(0); // not imported
          WriteLong(0); // offset is unknown at this time
          WriteLong(0); // length is also unknown at this time
          if xo.aExport <> etExportNone then
          begin
            WriteLong(Length(xo.Name));
            WriteData(xo.Name[1], length(xo.Name));
            if xo.FExport = etExportName then
            begin
              WriteLong(0);
            end else begin
              s := MakeExportDecl(xo.Decl);
              WriteLong(Length(s));
              WriteData(s[1], length(S));
            end;
          end;
        end
        else
        begin
          xe := TIFPSExternalProcedure(xp);
          if xe.RegProc.ImportDecl <> '' then
          begin
            WriteByte(3); // imported
            if xe.RegProc.FExportName then
            begin
              WriteByte(Length(xe.RegProc.Name));
              WriteData(xe.RegProc.Name[1], Length(xe.RegProc.Name) and $FF);
            end else begin
              WriteByte(0);
            end;
            WriteLong(Length(xe.RegProc.ImportDecl));
            WriteData(xe.RegProc.ImportDecl[1], Length(xe.RegProc.ImportDecl));
          end else begin
            WriteByte(1); // imported
            WriteByte(Length(xe.RegProc.Name));
            WriteData(xe.RegProc.Name[1], Length(xe.RegProc.Name) and $FF);
          end;
        end;
      end;
    end;

    procedure WriteProcs2;
    var
      l: Longint;
      L2: Cardinal;
      x: TIFPSProcedure;
    begin
      for l := 0 to FProcs.Count - 1 do
      begin
        x := FProcs.GetItem(l);
        if x.ClassType = TIFPSInternalProcedure then
        begin
          if TIFPSInternalProcedure(x).Data = '' then
            TIFPSInternalProcedure(x).Data := Chr(Cm_R);
          L2 := Length(FOutput);
          Move(L2, FOutput[TIFPSInternalProcedure(x).OutputDeclPosition + 2], 4);
          // write position
          WriteData(TIFPSInternalProcedure(x).Data[1], Length(TIFPSInternalProcedure(x).Data));
          L2 := Cardinal(Length(FOutput)) - L2;
          Move(L2, FOutput[TIFPSInternalProcedure(x).OutputDeclPosition + 6], 4); // write length
        end;
      end;
    end;

    function FindMainProc: Cardinal;
    var
      l: Longint;
    begin
      for l := 0 to FProcs.Count - 1 do
      begin
        if (TIFPSProcedure(FProcs.GetItem(l)).ClassType = TIFPSInternalProcedure) and
          (TIFPSInternalProcedure(FProcs.GetItem(l)).Name = IFPSMainProcName) then
        begin
          Result := l;
          exit;
        end;
      end;
      Result := Cardinal(-1);
    end;
    procedure CreateDebugData;
    var
      I: Longint;
      p: TIFPSProcedure;
      pv: PIFPSVar;
      s: string;
    begin
      s := #0;
      for I := 0 to FProcs.Count - 1 do
      begin
        p := FProcs.GetItem(I);
        if p.ClassType = TIFPSInternalProcedure then
        begin
          if TIFPSInternalProcedure(p).Name = IFPSMainProcName then
            s := s + #1
          else
            s := s + TIFPSInternalProcedure(p).Name + #1;
        end
        else
        begin
          s := s+ TIFPSExternalProcedure(p).RegProc.Name + #1;
        end;
      end;
      s := s + #0#1;
      for I := 0 to FVars.Count - 1 do
      begin
        pv := FVars.GetItem(I);
        s := s + pv.Name + #1;
      end;
      s := s + #0;
      WriteDebugData(s);
    end;
  begin
    CreateDebugData;
    WriteLong(IFPSValidHeader);
    WriteLong(IFPSCurrentBuildNo);
    WriteLong(FUsedTypes.Count);
    WriteLong(FProcs.Count);
    WriteLong(FVars.Count);
    WriteLong(FindMainProc);
    WriteLong(0);
    WriteTypes;
    WriteProcs;
    WriteVars;
    WriteProcs2;
  end;

  function CheckExports: Boolean;
  var
    i: Longint;
    p: TIFPSProcedure;
  begin
    if @FOnExportCheck = nil then
    begin
      result := true;
      exit;
    end;
    for i := 0 to FProcs.Count -1 do
    begin
      p := FProcs.GetItem(i);
      if p.ClassType = TIFPSInternalProcedure then
      begin
        if not FOnExportCheck(Self, TIFPSInternalProcedure(p), MakeDecl(TIFPSInternalProcedure(p).Decl)) then
        begin
          Result := false;
          exit;
        end;
      end;
    end;
    Result := True;
  end;
  function DoConstBlock: Boolean;
  var
    CName: string;
    CValue: PIFRVariant;
    Cp: PIFPSConstant;
  begin
    FParser.Next;
    repeat
      if FParser.CurrTokenID <> CSTI_Identifier then
      begin
        MakeError('', ecIdentifierExpected, '');
        Result := False;
        Exit;
      end;
      CName := FParser.GetToken;
      if IsDuplicate(CName) then
      begin
        MakeError('', ecDuplicateIdentifier, '');
        Result := False;
        exit;
      end;
      FParser.Next;
      if FParser.CurrTokenID <> CSTI_Equal then
      begin
        MakeError('', ecIsExpected, '');
        Result := False;
        Exit;
      end;
      FParser.Next;
      CValue := ReadConstant(CSTI_SemiColon);
      if CValue = nil then
      begin
        Result := False;
        Exit;
      end;
      if FParser.CurrTokenID <> CSTI_Semicolon then
      begin
        MakeError('', ecSemicolonExpected, '');
        Result := False;
        exit;
      end;
      New(cp);
      cp^.NameHash := MakeHash(CName);
      cp^.Name := CName;
      InitializeVariant(@cp^.Value, CValue^.FType, PIFPSType(FAvailableTypes.GetItem(CValue^.FType)).BaseType);
      CopyVariantContents(cvalue, @cp^.Value);
      FConstants.Add(cp);
      DisposeVariant(CValue);
      FParser.Next;
    until FParser.CurrTokenId <> CSTI_Identifier;
    Result := True;
  end;
  function ProcessUses: Boolean;
  var
    FUses: TIfStringList;
    I: Longint;
    s: string;
  begin
    FParser.Next;
    FUses := TIfStringList.Create;
    repeat
      if FParser.CurrTokenID <> CSTI_Identifier then
      begin
        MakeError('', ecIdentifierExpected, '');
        FUses.Free;
        Result := False;
        exit;
      end;
      s := FParser.GetToken;
      for i := 0 to FUses.Count -1 do
      begin
        if FUses.GetItem(I) = s then
        begin
          MakeError('', ecDuplicateIdentifier, s);
          FUses.Free;
          Result := False;
          exit;
        end;
      end;
      FUses.Add(s);
      if @FOnUses <> nil then
      begin
        try
          if not OnUses(Self, FParser.GetToken) then
          begin
            FUses.Free;
            Result := False;
            exit;
          end;
        except
          on e: Exception do
          begin
            MakeError('', ecCustomError, e.Message);
            FUses.Free;
            Result := False;
            exit;
          end;
        end;
      end;
      FParser.Next;
      if FParser.CurrTokenID = CSTI_Semicolon then break
      else if FParser.CurrTokenId <> CSTI_Comma then
      begin
        MakeError('', ecSemicolonExpected, '');
        Result := False;
        FUses.Free;
        exit;
      end;
      FParser.Next;
    until False;
    FParser.next;
    Result := True;
  end;
var
  Proc: TIFPSProcedure;

begin
  FIsUnit := False;
  Result := False;
  Clear;
  FParser.SetText(s);

  FProcs := TIfList.Create;
  FConstants := TIFList.Create;
  FVars := TIfList.Create;
  FAvailableTypes := TIfList.Create;
  FUsedTypes := TIfList.Create;
  FRegProcs := TIfList.Create;
  DefineStandardTypes;
  FLastProgramName := '';
  if @FOnUses <> nil then
  begin
    try
      if not OnUses(Self, 'SYSTEM') then
      begin
        FreeAll;
        exit;
      end;
    except
      on e: Exception do
      begin
        MakeError('', ecCustomError, e.Message);
        FreeAll;
        exit;
      end;
    end;
  end;
  Position := csStart;
  Proc := NewProc(IFPSMainProcName);
  repeat
    if FParser.CurrTokenId = CSTI_EOF then
    begin
      if FAllowNoEnd then
        Break
      else
      begin
        MakeError('', ecUnexpectedEndOfFile, '');
        FreeAll;
        exit;
      end;
    end;
    if (FParser.CurrTokenId = CSTII_Program) and (Position = csStart) then
    begin
      Position := csProgram;
      FParser.Next;
      if FParser.CurrTokenId <> CSTI_Identifier then
      begin
        MakeError('', ecIdentifierExpected, '');
        FreeAll;
        exit;
      end;
      FLastProgramName := FParser.GetToken;
      FParser.Next;
      if FParser.CurrTokenId <> CSTI_Semicolon then
      begin
        MakeError('', ecSemicolonExpected, '');
        FreeAll;
        exit;
      end;
      FParser.Next;
    end else
    if (Fparser.CurrTokenID = CSTII_Implementation) and ((Position = csinterface) or (position = csInterfaceUses)) then
    begin
      Position := csImplementation;
      FParser.Next;
    end else
    if (Fparser.CurrTokenID = CSTII_Interface) and (Position = csUnit) then
    begin
      Position := csInterface;
      FParser.Next;
    end else
    if (FParser.CurrTokenId = CSTII_Unit) and (Position = csStart) and (FAllowUnit) then
    begin
      Position := csUnit;
      FIsUnit := True;
      FParser.Next;

      if FParser.CurrTokenId <> CSTI_Identifier then
      begin
        MakeError('', ecIdentifierExpected, '');
        FreeAll;
        exit;
      end;
      FLastProgramName := FParser.GetToken;
      FParser.Next;
      if FParser.CurrTokenId <> CSTI_Semicolon then
      begin
        MakeError('', ecSemicolonExpected, '');
        FreeAll;
        exit;
      end;
      FParser.Next;
    end
    else if (FParser.CurrTokenID = CSTII_Uses) and ((Position < csuses) or (Position = csInterface)) then
    begin
      if Position = csInterface then
        Position := csInterfaceUses
      else
        Position := csUses;
      if not ProcessUses then
      begin
        FreeAll;
        exit;
      end;
    end else if (FParser.CurrTokenId = CSTII_Procedure) or
      (FParser.CurrTokenId = CSTII_Function) then
    begin
      if (Position = csInterface) or (position = csInterfaceUses) then
      begin
        if not ProcessFunction(True) then
        begin
          FreeAll;
          exit;
        end;
      end else begin
        Position := csUses;
        if not ProcessFunction(False) then
        begin
          FreeAll;
          exit;
        end;
      end;
    end
    else if (FParser.CurrTokenId = CSTII_Label) then
    begin
      Position := csUses;
      if not ProcessLabel(TIFPSInternalProcedure(Proc)) then
      begin
        FreeAll;
        exit;
      end;
    end
    else if (FParser.CurrTokenId = CSTII_Var) then
    begin
      Position := csUses;
      if not DoVarBlock(nil) then
      begin
        FreeAll;
        exit;
      end;
    end
    else if (FParser.CurrTokenId = CSTII_Const) then
    begin
      Position := csUses;
      if not DoConstBlock then
      begin
        FreeAll;
        exit;
      end;
    end
    else if (FParser.CurrTokenId = CSTII_Type) then
    begin
      Position := csUses;
      if not DoTypeBlock(FParser) then
      begin
        FreeAll;
        exit;
      end;
    end
    else if (FParser.CurrTokenId = CSTII_Begin) then
    begin
      if ProcessSub(tMainBegin, 0, TIFPSInternalProcedure(Proc)) then
      begin
        break;
      end
      else
      begin
        FreeAll;
        exit;
      end;
    end
    else if (Fparser.CurrTokenId = CSTII_End) and (FAllowNoBegin or FIsUnit) then
    begin
      FParser.Next;
      if FParser.CurrTokenID <> CSTI_Period then
      begin
        MakeError('', ecPeriodExpected, '');
        FreeAll;
        exit;
      end;
      break;
    end else 
    begin
      MakeError('', ecBeginExpected, '');
      FreeAll;
      exit;
    end;
  until False;
  if not ProcessLabelForwards(TIFPSInternalProcedure(Proc)) then
  begin
    FreeAll;
    exit;
  end;
  for i := 0 to FProcs.Count -1 do
  begin
    Proc := FProcs.GetItem(i);
    if (Proc.ClassType = TIFPSInternalProcedure) and (TIFPSInternalProcedure(Proc).Forwarded) then
    begin
      MakeError('', ecUnsatisfiedForward, TIFPSInternalProcedure(Proc).Name).Position := TIFPSInternalProcedure(Proc).DeclarePosition;
      FreeAll;
      Exit;
    end;
  end;
  if not CheckExports then
  begin
    FreeAll;
    exit;
  end;
  for i := 0 to FVars.Count -1 do
  begin
    if not PIFPSVar(FVars.GetItem(I))^.Used then
    begin
      MakeHint('', ehVariableNotUsed, PIFPSVar(FVars.GetItem(I))^.Name)^.Position := PIFPSVar(FVars.GetItem(I))^.DeclarePosition;
    end;
  end;
  MakeOutput;
  FreeAll;
  Result := True;
end;

constructor TIFPSPascalCompiler.Create;
begin
  inherited Create;
  FParser := TIfPascalParser.Create;
  FParser.OnParserError := ParserError;
  FAutoFreeList := TIfList.Create;
  FOutput := '';
  FMessages := TIfList.Create;
end;

destructor TIFPSPascalCompiler.Destroy;
begin
  Clear;
  FAutoFreeList.Free;

  FMessages.Free;
  FParser.Free;
  inherited Destroy;
end;

function TIFPSPascalCompiler.GetOutput(var s: string): Boolean;
begin
  if Length(FOutput) <> 0 then
  begin
    s := FOutput;
    Result := True;
  end
  else
    Result := False;
end;

function TIFPSPascalCompiler.GetMsg(l: Longint):
  PIFPSPascalCompilerMessage;
begin
  Result := FMessages.GetItem(l);
end;

function TIFPSPascalCompiler.GetMsgCount: Longint;
begin
  Result := FMessages.Count;
end;

procedure TIFPSPascalCompiler.DefineStandardTypes;
var
  i: Longint;
begin
  AddType('BYTE', btU8);
  AddTypeS('BOOLEAN', '(False, True)');
  FBooleanType := FAvailableTypes.Count -1;
  AddType('CHAR', btChar);
  {$IFNDEF NOWIDESTRING}
  AddType('WIDECHAR', btWideChar);
  AddType('WIDESTRING', btWideString);
  {$ENDIF}
  AddType('SHORTINT', btS8);
  AddType('WORD', btU16);
  AddType('SMALLINT', btS16);
  AddType('LONGINT', btS32);
  AddType('LONGWORD', btU32);
  AddTypeCopyN('INTEGER', 'LONGINT');
  AddTypeCopyN('CARDINAL', 'LONGWORD');
  AddType('STRING', btString);
  {$IFNDEF NOINT64}
  AddType('INT64', btS64);
  {$ENDIF}
  AddType('SINGLE', btSingle);
  AddType('DOUBLE', btDouble);
  AddType('EXTENDED', btExtended);

  for i := FAvailableTypes.Count -1 downto 0 do AT2UT(i);
  AddType('PCHAR', btPChar);
  AddType('VARIANT', btVariant);
  TIFPSArrayType(AddType('TVARIANTARRAY', btArray)).ArrayTypeNo := FindType('VARIANT');

  with AddFunction('function Assigned(I: Longint): Boolean;') do
  begin
    Name := '!ASSIGNED';
  end;
end;

procedure TIFPSPascalCompiler.UpdateRecordFields(r: TIFPSType);
var
  I: Longint;
  s: string;
begin
  if r.BaseType = btProcPtr then
  begin
    s := TIFPSProceduralType(r).ProcDef;
    ReplaceTypes(s);
    TIFPSProceduralType(r).ProcDef := s;
  end else if PIFPSType(r).BaseType = btRecord then
  begin
    for I := 0 to TIFPSRecordType(r).RecValCount - 1 do
      TIFPSRecordType(r).RecVal(I).FType := AT2UT(TIFPSRecordType(r).RecVal(I).FType);
  end
  else if PIFPSType(r).BaseType = btArray then
  begin

    if TIFPSArrayType(r).FArrayTypeNo <> Cardinal(-1) then
      TIFPSArrayType(r).FArrayTypeNo := AT2UT(TIFPSArrayType(r).FArrayTypeNo);
  end;
end;


function TIFPSPascalCompiler.FindType(const Name: string): Cardinal;
var
  i, n: Longint;
  p: PIFPSType;
  RName: string;
begin
  if FProcs = nil then begin Result := Cardinal(-1); exit;end;
  RName := Fastuppercase(Name);
  n := makehash(rname);
  for i := 0 to FAvailableTypes.Count - 1 do
  begin
    p := FAvailableTypes.GetItem(I);
    if (p.NameHash = n) and (p.name = rname) then
    begin
      result := I;
      exit;
    end;
  end;
  result := Cardinal(-1);
end;

function TIFPSPascalCompiler.AddConstant(const Name: string; FType: Cardinal): PIFPSConstant;
var
  pc: PIFPSConstant;
begin
  if FProcs = nil then begin Result := nil; exit;end;
  FType := GetTypeCopyLinkInt(FType);
  if FType = Cardinal(-1) then begin Result := nil; exit; end;
  new(pc);
  pc^.Name := FastUppercase(name);
  pc^.NameHash := makehash(pc^.name);
  InitializeVariant(@pc^.Value, FType, PIFPSType(FAvailableTypes.GetItem(FType)).BaseType);
  FConstants.Add(pc);
  result := pc;
end;

type
  PConstantVal = ^TConstantVal;
  TConstantVal = record
    b: Boolean;
    case boolean  of
    true: (Rec: PIfRVariant; DeclPos: Cardinal; Modifiers: Byte);
    false: (c: byte);
  end;

function TIFPSPascalCompiler.ReadConstant(StopOn: TIfPasToken): PIfRVariant;
var
  Items: TIfList;
  tmp: PConstantVal;
  Val: PIfRVariant;
  c,
  modifiers: byte;

    function GetType(BaseType: TIFPSBaseType): Cardinal;
    var
      l: Longint;
      x: PIFPSType;
    begin
      for l := 0 to FAvailableTypes.Count - 1 do
      begin
        if PIFPSType(FAvailableTypes.GetItem(l)).BaseType = BaseType then
        begin
          Result := l;
          exit;
        end;
      end;
      x := TIFPSType.Create;
      x.Name := '';
      x.BaseType := BaseType;
      x.TypeSize := 1;
      x.DeclarePosition := Cardinal(-1);
      FAvailableTypes.Add(x);
      FUsedTypes.Add(x);
      Result := FUsedTypes.Count - 1;
    end;

  procedure Cleanup;
  var
    p: PConstantVal;
    l: Longint;
  begin
    for l := 0 to Items.Count - 1 do
    begin
      p := Items.GetItem(l);
      if not p^.b then
      begin
        DisposeVariant(p^.Rec);
      end;
      Dispose(p);
    end;
    Items.Free;
  end;

  function SortItems: Boolean;
  var
    l: Longint;
    p, p1, P2: PConstantVal;
  begin
    SortItems := False;
    if Items.Count = 1 then
    begin
      p1 := Items.GetItem(0);

      if (p1^.Rec^.FType = CVAL_Data) then
      begin

        if p1^.Modifiers = 1 then // not
        begin
          case p1^.Rec.BaseType of
            btU8: p1^.Rec^.tu8 := tbtu8(p1^.Rec^.tu8 = 0);
            btS8: p1^.Rec^.ts8 := tbts8(p1^.Rec^.ts8 = 0);
            btU16: p1^.Rec^.tu16 := tbtu16(p1^.Rec^.tu16 = 0);
            btS16: p1^.Rec^.ts16 := tbts16(p1^.Rec^.ts16 = 0);
            btU32: p1^.Rec^.tu32 := tbtu32(p1^.Rec^.tu32 = 0);
            btS32: p1^.Rec^.ts32 := tbts32(p1^.Rec^.ts32 = 0);
            {$IFNDEF NOINT64}
            btS64: p1^.Rec^.ts64 := tbts64(p1^.Rec^.ts64 = 0);
            {$ENDIF}
          end;
        end else
        if p1^.Modifiers = 2 then // minus
        begin
          case p1^.Rec.BaseType of
            btU8: p1^.Rec^.tu8 := - p1^.Rec^.tu8;
            btS8: p1^.Rec^.ts8 := - p1^.Rec^.ts8;
            btU16: p1^.Rec^.tu16 := - p1^.Rec^.tu16;
            btS16: p1^.Rec^.ts16 := - p1^.Rec^.ts16;
            btU32: p1^.Rec^.tu32 := - p1^.Rec^.tu32;
            btS32: p1^.Rec^.ts32 := - p1^.Rec^.ts32;
            {$IFNDEF NOINT64}
            btS64: p1^.Rec^.ts64 := - p1^.Rec^.ts64;
            {$ENDIF}
            btSingle: p1^.Rec^.tsingle := - p1^.Rec^.tsingle;
            btDouble: p1^.Rec^.tdouble := - p1^.Rec^.tdouble;
            btExtended: p1^.Rec^.textended := - p1^.Rec^.textended;
          end;
        end;
      end;
      SortItems := True;
      exit;
    end;
    l := 0;
    while l < Longint(Items.Count - 1) div 2 do
    begin
      p := Items.GetItem((l shl 1) + 1);
      p1 := Items.GetItem((l shl 1));
      P2 := Items.GetItem((l shl 1) + 2);
      case p^.c of
        2, 3, 4, 5, 6, 7: {*}
          begin
            if not PreCalc(FAvailableTypes, p1^.Modifiers, p1^.Rec, p2^.Modifiers, P2^.Rec, p^.c, p2^.DeclPos) then
            begin
              exit;
            end;
            Items.Delete((l shl 1) + 1);
            Items.Delete((l shl 1) + 1);
            DisposeVariant(p2^.Rec);
            Dispose(P2);
            Dispose(p);
          end;
      else
        Inc(l);
      end;
    end;
    l := 0;
    while l < Longint(Items.Count - 1) div 2 do
    begin
      p := Items.GetItem((l shl 1) + 1);
      p1 := Items.GetItem((l shl 1));
      P2 := Items.GetItem((l shl 1) + 2);
      case p^.c of
        0, 1, 8, 9:
          begin
            if not PreCalc(FAvailableTypes,p1^.Modifiers, p1^.Rec, p2^.Modifiers, P2^.Rec, p^.c, p2^.DeclPos) then
            begin
              exit;
            end;
            Items.Delete((l shl 1) + 1);
            Items.Delete((l shl 1) + 1);
            DisposeVariant(p2^.Rec);
            Dispose(P2);
            Dispose(p);
          end;
      else
        Inc(l);
      end;
    end;
    l := 0;
    while l < Longint(Items.Count - 1) div 2 do
    begin
      p := Items.GetItem((l shl 1) + 1);
      p1 := Items.GetItem((l shl 1));
      P2 := Items.GetItem((l shl 1) + 2);
      case p^.c of
        10, 11, 12, 13, 14, 15:
          begin
            if not PreCalc(FAvailableTypes,p1^.Modifiers, p1^.Rec, p2^.Modifiers, P2^.Rec, p^.c, p2^.DeclPos) then
            begin
              exit;
            end;
            Items.Delete((l shl 1) + 1);
            Items.Delete((l shl 1) + 1);
            DisposeVariant(p2^.Rec);
            Dispose(P2);
            Dispose(p);
          end;
      else
        Inc(l);
      end;
    end;
    SortItems := True;
  end;
  function ReadReal(const s: string): PIfRVariant;
  var
    C: Integer;
  begin
    New(Result);
    InitializeVariant(Result, GetType(btExtended), btExtended);
    System.Val(s, Result^.textended, C);
  end;
  function ReadInteger(const s: string): PIfRVariant;
  {$IFNDEF NOINT64}
  var
    R: Int64;
  begin
    r := StrToInt64Def(s, 0);
    New(Result);
    if (r >= High(Longint)) or (r <= Low(Longint))then
    begin
      InitializeVariant(Result, GetType(bts32), bts32);
      Result^.ts32 := r;
    end else
    begin
      InitializeVariant(Result, GetType(bts64), bts64);
      Result^.ts64 := r;
    end;
  end;
  {$ELSE}
  var
    r: Longint;
  begin
    r := StrToIntDef(s, 0);
    New(Result);
    InitializeVariant(Result, GetType(bts32), bts32);
    Result^.ts32 := r;
  end;
  {$ENDIF}
  function ReadString: PIfRVariant;
  {$IFNDEF NOWIDESTRING}var wchar: Boolean;{$ENDIF}

    function ParseString: {$IFNDEF NOWIDESTRING}widestring{$ELSE}string{$ENDIF};
    var
      temp3: {$IFNDEF NOWIDESTRING}widestring{$ELSE}string{$ENDIF};

      function ChrToStr(s: string): {$IFNDEF NOWIDESTRING}widechar{$ELSE}char{$ENDIF};
      var
        w: Longint;
      begin
        Delete(s, 1, 1); {First char : #}
        w := StrToInt(s);
        Result := {$IFNDEF NOWIDESTRING}widechar{$ELSE}char{$ENDIF}(w);
        {$IFNDEF NOWIDESTRING}if w > $FF then wchar := true;{$ENDIF}
      end;

      function PString(s: string): string;
      begin
        s := copy(s, 2, Length(s) - 2);
        PString := s;
      end;
    begin
      temp3 := '';
      while (FParser.CurrTokenId = CSTI_String) or (FParser.CurrTokenId = CSTI_Char) do
      begin
        if FParser.CurrTokenId = CSTI_String then
        begin
          temp3 := temp3 + PString(FParser.GetToken);
          FParser.Next;
          if FParser.CurrTokenId = CSTI_String then
            temp3 := temp3 + #39;
        end {if}
        else
        begin
          temp3 := temp3 + ChrToStr(FParser.GetToken);
          FParser.Next;
        end; {else if}
      end; {while}
      ParseString := temp3;
    end;
  {$IFNDEF NOWIDESTRING}
  var
    w: widestring;
    s: string;
  begin
    w := ParseString;
    if wchar then
    begin
      New(Result);
      if Length(w) = 1 then
      begin
        InitializeVariant(Result, GetType(btwidechar), btWideChar);
        Result^.twidechar := w[1];
      end else begin
        InitializeVariant(Result, GetType(btwidestring), btWidestring);
        tbtwidestring(result^.twidestring) := w;
      end;
    end else begin
      s := w;
      New(Result);
      if Length(s) = 1 then
      begin
        InitializeVariant(Result, GetType(btChar), btChar);
        Result^.tchar := s[1];
      end else begin
        InitializeVariant(Result, GetType(btstring), btstring);
        tbtstring(Result^.tstring) := s;
      end;
    end;
  end;
  {$ELSE}
  var
    s: string;
  begin
    s := ParseString;
    New(Result);
    if Length(s) = 1 then
    begin
      InitializeVariant(Result, GetType(btChar), btChar);
      Result^.tchar := s[1];
    end else begin
      InitializeVariant(Result, GetType(btstring), btstring);
      tbtstring(Result^.tstring) := s;
    end;
  end;
  {$ENDIF}
  function GetConstantIdentifier: PIfRVariant;
  var
    s: string;
    sh: Longint;
    i: Longint;
    p: PIFPSConstant;
  begin
    s := FParser.GetToken;
    sh := MakeHash(s);
    for i := FConstants.Count -1 downto 0 do
    begin
      p := FConstants.GetItem(I);
      if (p^.NameHash = sh) and (p^.Name = s) then
      begin
        New(Result);
        InitializeVariant(Result, p^.Value.FType, p^.Value.BaseType);
        CopyVariantContents(@P^.Value, Result);
        FParser.Next;
        exit;
      end;
    end;
    MakeError('', ecUnknownIdentifier, '');
    Result := nil;

  end;
begin
  Items := TIfList.Create;
  ReadConstant := nil;
  while True do
  begin
    modifiers := 0;
    if Items.Count and 1 = 0 then
    begin
      if fParser.CurrTokenID = CSTII_Not then
      begin
        FParser.Next;
        modifiers := 1;
      end else // only allow one of these two
      if fParser.CurrTokenID = CSTI_Minus then
      begin
        FParser.Next;
        modifiers := 2;
      end;
      case FParser.CurrTokenId of
        CSTI_EOF:
          begin
            MakeError('', ecUnexpectedEndOfFile, '');
            Cleanup;
            exit;
          end;
        CSTI_OpenRound:
          begin
            FParser.Next;

            val := ReadConstant(CSTI_CloseRound);
            if val = nil then
            begin
              Cleanup;
              exit;
            end;
            if FParser.CurrTokenId <> CSTI_CloseRound then
            begin
              MakeError('', ecCloseRoundExpected, '');
              Cleanup;
              exit;
            end;
            if ((Modifiers and 1) <> 0) and (not IsIntType(PIFPSType(FUsedTypes.GetItem(val^.FType)).BaseType)) or ((Modifiers and 2) <> 0) and (not IsRealType(PIFPSType(FUsedTypes.GetItem(val^.FType)).BaseType)) then
            begin
              DisposeVariant(val);
              MakeError('', ecTypeMismatch, '');
              Cleanup;
              exit;
            end;
            new(tmp);
            tmp^.b := False;
            tmp^.Rec := Val;
            tmp^.DeclPos := FParser.CurrTokenPos;
            tmp^.Modifiers := modifiers;
            Items.Add(tmp);
            FParser.Next;
          end;
        CSTI_Char, CSTI_String:
          begin
            if (Modifiers <> 0) then
            begin
              MakeError('', ecTypeMismatch, '');
              Cleanup;
              exit;
            end;
            val := ReadString;
            new(tmp);
            tmp^.b := False;
            tmp^.Rec := Val;
            tmp^.DeclPos := FParser.CurrTokenPos;
            tmp^.Modifiers := modifiers;
            Items.Add(tmp);
          end;
        CSTI_HexInt, CSTI_Integer:
          begin
            Val := ReadInteger(FParser.GetToken);
            new(tmp);
            tmp^.b := False;
            tmp^.Rec := Val;
            tmp^.DeclPos := FParser.CurrTokenPos;
            tmp^.Modifiers := modifiers;
            Items.Add(tmp);
            FParser.Next;
          end;
        CSTI_Real:
          begin
            if ((Modifiers and 1) <> 0)  then
            begin
              MakeError('', ecTypeMismatch, '');
              Cleanup;
              exit;
            end;
            Val := ReadReal(FParser.GetToken);
            new(tmp);
            tmp^.b := False;
            tmp^.Rec := Val;
            tmp^.DeclPos := FParser.CurrTokenPos;
            tmp^.Modifiers := modifiers;
            Items.Add(tmp);
            FParser.Next;
          end;
        CSTI_Identifier:
          begin
            val := GetConstantIdentifier;
            if val = nil then
            begin
              Cleanup;
              exit;
            end
            else
            begin
              if ((Modifiers and 1) <> 0) and (not IsIntType(PIFPSType(FUsedTypes.GetItem(val^.FType)).BaseType)) or ((Modifiers  and 2) <> 0) and (not IsIntRealType(PIFPSType(FUsedTypes.GetItem(val^.FType)).BaseType))
              then
              begin
                DisposeVariant(val);
                MakeError('', ecTypeMismatch, '');
                Cleanup;
                exit;
              end;
              new(tmp);
              tmp^.b := False;
              tmp^.Rec := Val;
              tmp^.DeclPos := FParser.CurrTokenPos;
              tmp^.Modifiers := modifiers;
              Items.Add(tmp);
            end;
          end;
      else
        begin
          MakeError('', ecSyntaxError, '');
          Cleanup;
          exit;
        end;
      end; {case}
    end
    else {Items.Count and 1 = 1}
    begin
      if FParser.CurrTokenId = StopOn then
        break;
      C := 0;
      case FParser.CurrTokenId of
        CSTI_EOF:
          begin
            MakeError('', ecUnexpectedEndOfFile, '');
            Cleanup;
            exit;
          end;
        CSTI_CloseBlock,
          CSTII_To,
          CSTI_CloseRound,
          CSTI_Semicolon,
          CSTII_Else,
          CSTII_End,
          CSTI_Comma: break;
        CSTI_Plus: ;
        CSTI_Minus: C := 1;
        CSTI_Multiply: C := 2;
        CSTI_Divide: C := 3;
        CSTII_mod: C := 4;
        CSTII_shl: C := 5;
        CSTII_shr: C := 6;
        CSTII_and: C := 7;
        CSTII_or: C := 8;
        CSTII_xor: C := 9;
        CSTI_GreaterEqual: C := 10;
        CSTI_LessEqual: C := 11;
        CSTI_Greater: C := 12;
        CSTI_Less: C := 13;
        CSTI_NotEqual: C := 14;
        CSTI_Equal: C := 15;
      else
        begin
          MakeError('', ecSyntaxError, '');
          Cleanup;
          exit;
        end;
      end; {case}
      new(tmp);
      tmp^.b := True;
      tmp^.c := C;
      Items.Add(tmp);
      FParser.Next;
    end;
  end;
  if not SortItems then
  begin
    Cleanup;
    exit;
  end;
  if Items.Count = 1 then
  begin
    tmp := Items.GetItem(0);
    Result := tmp^.Rec;
    Dispose(tmp);
    Items.Free;
  end
  else
  begin
    MakeError('', ecInternalError, '0001B');
    Cleanup;
    Exit;
  end;
end;

procedure TIFPSPascalCompiler.WriteDebugData(const s: string);
begin
  FDebugOutput := FDebugOutput + s;
end;

function TIFPSPascalCompiler.GetDebugOutput(var s: string): Boolean;
begin
  if Length(FDebugOutput) <> 0 then
  begin
    s := FDebugOutput;
    Result := True;
  end
  else
    Result := False;
end;

function TIFPSPascalCompiler.AddUsedFunction(var Proc: TIFPSInternalProcedure): Cardinal;
begin
  if FProcs = nil then begin Result := Cardinal(-1);exit;end;
  Proc := TIFPSInternalProcedure.Create;
  FProcs.Add(Proc);
  Result := FProcs.Count - 1;
end;

function TIFPSPascalCompiler.GetAvailableType(No: Cardinal): PIFPSType;
begin
  if FProcs = nil then begin Result := nil; exit;end;
  Result := FAvailableTypes.GetItem(No);
end;

function TIFPSPascalCompiler.GetAvailableTypeCount: Cardinal;
begin
  if FProcs = nil then begin Result := Cardinal(-1);exit;end;
  Result := FAvailableTypes.Count;
end;


function TIFPSPascalCompiler.GetUsedType(No: Cardinal): PIFPSType;
begin
  if FProcs = nil then begin Result := nil; exit;end;
  Result := FUsedTypes.GetItem(No);
end;

function TIFPSPascalCompiler.GetUsedTypeCount: Cardinal;
begin
  if FProcs = nil then begin Result := Cardinal(-1);exit;end;
  Result := FUsedTypes.Count;
end;

function TIFPSPascalCompiler.UseAvailableType(No: Cardinal): Cardinal;
var
  I: Longint;
  p: PIFPSType;
begin
  if FProcs = nil then begin Result := Cardinal(-1);exit;end;
  p := FAvailableTypes.GetItem(No);
  if p = nil then
  begin
    Result := Cardinal(-1);
    Exit;
  end;

  for I := 0 to FUsedTypes.Count - 1 do
  begin
    if FUsedTypes.GetItem(I) = p then
    begin
      Result := I;
      exit;
    end;
  end;
  UpdateRecordFields(p);
  FUsedTypes.Add(p);
  Result := FUsedTypes.Count - 1;
end;

function TIFPSPascalCompiler.AddUsedFunction2(var Proc: TIFPSExternalProcedure): Cardinal;
begin
  if FProcs = nil then begin Result := Cardinal(-1);exit;end;
  Proc := TIFPSExternalProcedure.Create;
  FProcs.Add(Proc);
  Result := FProcs.Count -1;
end;

function TIFPSPascalCompiler.AddVariable(const Name: string; FType: Cardinal): PIFPSVar;
var
  P: PIFPSVar;
begin
  if FProcs = nil then begin Result := nil; exit;end;
  if FType = Cardinal(-1) then begin Result := nil; exit; end;
  New(p);
  p^.Name := Fastuppercase(Name);
  p^.Namehash := MakeHash(p^.Name);
  p^.FType := AT2UT(FType);
  p^.Used := False;
  p^.DeclarePosition := 0;
  FVars.Add(p);
  Result := P;
end;


procedure TIFPSPascalCompiler.AddToFreeList(Obj: TObject);
begin
  FAutoFreeList.Add(Obj);
end;

function TIFPSPascalCompiler.AddConstantN(const Name,
  FType: string): PIFPSConstant;
var
  L: Cardinal;
begin
  L := FindType(FType);
  if l = Cardinal(-1) then
    Result := nil
  else
    Result := AddConstant(Name, L);
end;

function TIFPSPascalCompiler.AddTypeCopy(const Name: string;
  TypeNo: Cardinal): PIFPSType;
var
  b: PIFPSType;
begin
  b := FAvailableTypes.GetItem(TypeNo);
  if b.BaseType = btTypeCopy then TypeNo := TIFPSTypeLink(b).FLinkTypeNo;

  Result := AddType(Name, BtTypeCopy);
  TIFPSTypeLink(Result).LinkTypeNo := TypeNo;
end;

function TIFPSPascalCompiler.AddTypeCopyN(const Name,
  FType: string): PIFPSType;
var
  L: Cardinal;
begin
  L := FindType(FType);
  if L = Cardinal(-1) then
    Result := nil
  else
    Result := AddTypeCopy(Name, L);
end;


function TIFPSPascalCompiler.AddUsedVariable(const Name: string;
  FType: Cardinal): PIFPSVar;
begin
  Result := AddVariable(Name, FType);
  if Result <> nil then
    Result^.Used := True;
end;

function TIFPSPascalCompiler.AddUsedVariableN(const Name,
  FType: string): PIFPSVar;
begin
  Result := AddVariable(Name, FindType(FType));
  if Result <> nil then
    Result^.Used := True;
end;

function TIFPSPascalCompiler.AddVariableN(const Name,
  FType: string): PIFPSVar;
begin
  Result := AddVariable(Name, FindType(FType));
end;

function TIFPSPascalCompiler.AddTypeS(const Name, Decl: string): PIFPSType;
var
  Parser: TIfPascalParser;
begin
  Parser := TIfPascalParser.Create;
  Parser.SetText(Decl);
  Result := FAvailableTypes.GetItem(ReadType(FastUppercase(Name), Parser));
  Parser.Free;
end;


function TIFPSPascalCompiler.CheckCompatProc(FTypeNo,
  ProcNo: Cardinal): Boolean;
var
  s1,s2: string;
  P: PIFPSType;

  function c(const e1,e2: string): Boolean;
  begin
    Result := (Length(e1) = 0) or (Length(e2) = 0) or (e1[1] <> e2[1]);  
  end;
begin
  P := FUsedTypes.GetItem(FTypeNo);
  if p.BaseType <> btProcPtr then begin
    Result := False;
    Exit;
  end;

  S1 := TIFPSProceduralType(p).ProcDef;

  if TIFPSProcedure(FProcs.GetItem(ProcNo)).ClassType = TIFPSInternalProcedure then
    s2 := TIFPSInternalProcedure(FProcs.GetItem(ProcNo)).Decl
  else
    s2 := TIFPSExternalProcedure(FProcs.GetItem(ProcNo)).RegProc.Decl;
  if GRFW(s1) <> GRFW(s2) then begin
    Result := False;
    Exit;
  end;
  while Length(s1) > 0 do
  begin
    if c(GRFW(s1), GRFW(s2)) or (GRFW(s1) <> GRFW(s2)) then begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function TIFPSPascalCompiler.MakeExportDecl(decl: string): string;
var
  c: char;
begin
  result := grfw(decl);
  while length(decl) > 0 do
  begin
    c := grfw(decl)[1];
    result := result +' '+c+grfw(decl);
  end;
end;


function TIFPSPascalCompiler.IsIntBoolType(FTypeNo: Cardinal): Boolean;
var
  f: PIFPSType;
begin
  if FTypeNo = at2ut(FBooleanType) then begin Result := True; exit;end;
  f := FUsedTypes.GetItem(FTypeNo);
  
  case f.BaseType of
    btU8, btS8, btU16, btS16, btU32, btS32{$IFNDEF NOINT64}, btS64{$ENDIF}: Result := True;
  else
    Result := False;
  end;
end;

function TIFPSPascalCompiler.AddExportVariableN(const Name,
  FType: string): PIFPSVar;
begin
  Result := AddVariableN(Name, FType);
  if Result <> nil then
    Result^.exportname := FastUppercase(Name);
end;

function TIFPSPascalCompiler.AddUsedExportVariableN(const Name,
  FType: string): PIFPSVar;
begin
  Result := AddUsedVariableN(Name, FType);
  if Result <> nil then
    Result^.exportname := FastUppercase(Name);
end;

procedure TIFPSPascalCompiler.ParserError(Parser: TObject;
  Kind: TIFParserErrorKind; Position: Cardinal);
begin
  case Kind of
    ICOMMENTERROR: MakeError('', ecCommentError, '')^.Position := Position;
    ISTRINGERROR: MakeError('', ecStringError, '')^.Position := Position;
    ICHARERROR: MakeError('', ecCharError, '')^.Position := Position;
  else
    MakeError('', ecSyntaxError, '')^.Position := Position;
  end;
end;

function TIFPSPascalCompiler.GetTypeCopyLinkInt(L: Cardinal): Cardinal;
var
  p: PIFPSType;
  i: Longint;
begin
  p := FAvailableTypes.GetItem(l);
  if p = nil then
  begin
    Result := Cardinal(-1);
    exit;
  end;
  p := GetTypeCopyLink(p);
  for i := 0 to FAvailableTypes.Count -1 do
  begin
    if FAvailableTypes.GetItem(i) = p then
    begin
      Result := i;
      exit;
    end;
  end;
  Result := Cardinal(-1);
end;

{ TIFPSExternalClass }
function TIFPSExternalClass.SetNil(TypeNo: Cardinal; var ProcNo: Cardinal): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.ClassFunc_Call(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.ClassFunc_Find(const Name: string;
  var Index: Cardinal): Boolean;
begin
  Result := False;
end;

constructor TIFPSExternalClass.Create(Se: TIFPSPascalCompiler);
begin
  inherited Create;
  Self.SE := se;
end;

function TIFPSExternalClass.Func_Call(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.Func_Find(const Name: string;
  var Index: Cardinal): Boolean;
begin
  Result := False;
end;


function TIFPSExternalClass.IsCompatibleWith(
  Cl: TIFPSExternalClass): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.Property_Find(const Name: string;
  var Index: Cardinal): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.Property_Get(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
begin
  Result := False;
end;


function TIFPSExternalClass.Property_GetHeader(Index: Cardinal;
  var s: string): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.Property_Set(Index: Cardinal;
  var ProcNo: Cardinal): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.SelfType: Cardinal;
begin
  Result := Cardinal(-1);
end;

function TIFPSExternalClass.CastToType(TypeNo, IntoType: Cardinal;
  var ProcNo: Cardinal): Boolean;
begin
  Result := False;
end;

function TIFPSExternalClass.CompareClass(OtherTypeNo: Cardinal;
  var ProcNo: Cardinal): Boolean;
begin
  Result := false;
end;

{  }

function TransDoubleToStr(D: Double): string;
begin
  SetLength(Result, SizeOf(Double));
  Double((@Result[1])^) := D;
end;

function TransSingleToStr(D: Single): string;
begin
  SetLength(Result, SizeOf(Single));
  Single((@Result[1])^) := D;
end;

function TransExtendedToStr(D: Extended): string;
begin
  SetLength(Result, SizeOf(Extended));
  Extended((@Result[1])^) := D;
end;

function TransLongintToStr(D: Longint): string;
begin
  SetLength(Result, SizeOf(Longint));
  Longint((@Result[1])^) := D;
end;

function TransCardinalToStr(D: Cardinal): string;
begin
  SetLength(Result, SizeOf(Cardinal));
  Cardinal((@Result[1])^) := D;
end;

function TransWordToStr(D: Word): string;
begin
  SetLength(Result, SizeOf(Word));
  Word((@Result[1])^) := D;
end;

function TransSmallIntToStr(D: SmallInt): string;
begin
  SetLength(Result, SizeOf(SmallInt));
  SmallInt((@Result[1])^) := D;
end;

function TransByteToStr(D: Byte): string;
begin
  SetLength(Result, SizeOf(Byte));
  Byte((@Result[1])^) := D;
end;

function TransShortIntToStr(D: ShortInt): string;
begin
  SetLength(Result, SizeOf(ShortInt));
  ShortInt((@Result[1])^) := D;
end;

{ TIFPSType }

procedure TIFPSType.SetName(const Value: string);
begin
  FName := Value;
  FNameHash := MakeHash(Value);
end;

procedure TIFPSType.Use;
begin
  FUsed := True;
end;

{ TIFPSRecordType }

function TIFPSRecordType.AddRecVal: PIFPSRecordFieldTypeDef;
begin
  Result := TIFPSRecordFieldTypeDef.Create;
  FRecordSubVals.Add(Result);
end;

constructor TIFPSRecordType.Create;
begin
  inherited Create;
  FRecordSubVals := TIfList.Create;
end;

destructor TIFPSRecordType.Destroy;
var
  i: Longint;
begin
  for i := FRecordSubVals.Count -1 downto 0 do
    TIFPSRecordFieldTypeDef(FRecordSubVals.GetItem(i)).Free;
  FRecordSubVals.Free;
  inherited Destroy;
end;

function TIFPSRecordType.RecVal(I: Longint): PIFPSRecordFieldTypeDef;
begin
  Result := FRecordSubVals.GetItem(i)
end;

function TIFPSRecordType.RecValCount: Longint;
begin
  Result := FRecordSubVals.Count;
end;


{ TIFPSRegProc }

procedure TIFPSRegProc.SetName(const Value: string);
begin
  FName := Value;
  FNameHash := MakeHash(FName);
end;

{ TIFPSRecordFieldTypeDef }

procedure TIFPSRecordFieldTypeDef.SetFieldName(const Value: string);
begin
  FFieldName := Value;
  FFieldNameHash := MakeHash(FFieldName);
end;

{ TIFPSProcVar }

procedure TIFPSProcVar.SetName(const Value: string);
begin
  FName := Value;
  FNameHash := MakeHash(FName);
end;

procedure TIFPSProcVar.Use;
begin
  FUsed := True;
end;



{ TIFPSInternalProcedure }

constructor TIFPSInternalProcedure.Create;
begin
  inherited Create;
  FProcVars := TIfList.Create;
  FLabels := TIfStringList.Create;
  FGotos := TIfStringList.Create;
end;

destructor TIFPSInternalProcedure.Destroy;
var
  i: Longint;
begin
  for i := FProcVars.Count -1 downto 0 do
    TIFPSProcVar(FProcVars.GetItem(i)).Free;
  FProcVars.Free;
  FGotos.Free;
  FLabels.Free;
  inherited Destroy;
end;

procedure TIFPSInternalProcedure.ResultUse;
begin
  FResultUsed := True;
end;

procedure TIFPSInternalProcedure.SetName(const Value: string);
begin
  FName := Value;
  FNameHash := MakeHash(FName);
end;

procedure TIFPSInternalProcedure.Use;
begin
  FUsed := True;
end;



{

Internal error counter: 0001D (increase and then use)

}
end.
