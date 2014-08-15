unit IFPS3CompExec;

interface

uses
  SysUtils, Classes, ifps3, ifps3debug, ifps3utl,
  ifps3common, ifpscomp, ifpidelphi, ifpidelphiruntime, ifpidll2,
  ifpidll2runtime, ifpiclass, ifpiclassruntime;


type
  TDelphiCallingConvention = ifpidelphiruntime.TDelphiCallingConvention;
  TIFPSCompileTimeClassesImporter = ifpiclass.TIFPSCompileTimeClassesImporter;
  TIFPSRuntimeClassImporter = ifpiclassruntime.TIFPSRuntimeClassImporter;
const
  cdRegister = ifpidelphiruntime.cdRegister;
  cdPascal = ifpidelphiruntime.cdPascal;
  CdCdecl = ifpidelphiruntime.CdCdecl;
  CdStdCall = ifpidelphiruntime.CdStdCall;
type
  TIFPS3CompExec = class;
  TIFPS3Plugin = class(TComponent)
  private
    FCompExec: TIFPS3CompExec;
  protected
    procedure SetCompiler(Value: TIFPS3CompExec); virtual;
    procedure CompOnUses; virtual; abstract;
    procedure ExecOnUses; virtual; abstract;
  public
    destructor Destroy; override;
  published
    property CompExec: TIFPS3CompExec read FCompExec write SetCompiler;
  end;
  TIFPS3DllPlugin = class(TIFPS3Plugin)
  protected
    procedure CompOnUses; override;
    procedure ExecOnUses; override;
  end;
  TIFPS3ClOnCompImport = procedure (Sender: TObject; x: TIFPSCompileTimeClassesImporter) of object;
  TIFPS3ClOnExecImport = procedure (Sender: TObject; x: TIFPSRuntimeClassImporter) of object;
  TIFPS3ClassesPlugin = class(TIFPS3Plugin)
  private
    FOnCompImport: TIFPS3ClOnCompImport;
    FOnExecImport: TIFPS3ClOnExecImport;
    RI: TIFPSRuntimeClassImporter;
  protected
    procedure CompOnUses; override;
    procedure ExecOnUses; override;
  public
    destructor Destroy; override;
    function SetVarToInstance(const VarName: string; cl: TObject): Boolean;
  published
    property OnCompImport: TIFPS3ClOnCompImport read FOnCompImport write FOnCompImport;
    property OnExecImport: TIFPS3ClOnExecImport read FOnExecImport write FOnExecImport;
  end;


  TIFPS3CompOptions = set of (icAllowNoBegin, icAllowUnit, icAllowNoEnd);
  TIFPS3CompExecEvent = procedure (Sender: TIFPS3CompExec) of object;
  TIFPS3CompExec = class(TComponent)
  private
    FCanAdd: Boolean;
    FComp: TIFPSPascalCompiler;
    FCompOptions: TIFPS3CompOptions;
    FExec: TIFPSDebugExec;
    FScript: TStrings;
    FPlugins: TList;
    FOnLine: TNotifyEvent;
    FUseDebugInfo: Boolean;
    FOnAfterExecute, FOnCompile, FOnExecute: TIFPS3CompExecEvent;
    procedure SetScript(const Value: TStrings);
    function GetCompMsg(i: Integer): PIFPSPascalCompilerMessage;
    function GetCompMsgCount: Longint;
    function GetAbout: string;
    function ScriptUses(Sender: TIFPSPascalCompiler; const Name: string): Boolean;
    procedure LoadExec;
    function GetExecErrorByteCodePosition: Cardinal;
    function GetExecErrorCode: TIFError;
    function GetExecErrorParam: string;
    function GetExecErrorProcNo: Cardinal;
    function GetExecErrorString: string;
    function GetExecErrorPosition: Cardinal;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Compile: Boolean;
    function Execute: Boolean;

    procedure GetPosXY(const Position: Longint; var X, Y: Longint);

    property Comp: TIFPSPascalCompiler read FComp;
    property Exec: TIFPSDebugExec read FExec;

    property CompilerMessageCount: Longint read GetCompMsgCount;
    property CompilerMessages[i: Longint]: PIFPSPascalCompilerMessage read GetCompMsg;

    function CompilerErrorToStr(I: Longint): string;

    property ExecErrorProcNo: Cardinal read GetExecErrorProcNo;
    property ExecErrorByteCodePosition: Cardinal read GetExecErrorByteCodePosition;
    property ExecErrorPosition: Cardinal read GetExecErrorPosition;

    property ExecErrorCode: TIFError read GetExecErrorCode;
    property ExecErrorParam: string read GetExecErrorParam;
    property ExecErrorToString: string read GetExecErrorString;

    function AddFunctionEx(Ptr: Pointer; const Decl: string; CallingConv: TDelphiCallingConvention): Boolean;
    function AddFunction(Ptr: Pointer; const Decl: string): Boolean;

    function AddRegisteredVariable(const VarName, VarType: string): Boolean;
    function GetVariable(const Name: string): PIFVariant; 
  published
    property About: string read GetAbout;
    property Script: TStrings read FScript write SetScript;
    property CompilerOptions: TIFPS3CompOptions read FCompOptions write FCompOptions;
    property OnLine: TNotifyEvent read FOnLine write FOnLine;
    property OnCompile: TIFPS3CompExecEvent read FOnCompile write FOnCompile;
    property OnExecute: TIFPS3CompExecEvent read FOnExecute write FOnExecute;
    property OnAfterExecute: TIFPS3CompExecEvent read FOnAfterExecute write FOnAfterExecute;
    property UseDebugInfo: Boolean read FUseDebugInfo write FUseDebugInfo default True;
  end;

procedure Register;

implementation
uses
  ifps3lib_std, ifps3lib_stdr;

procedure Register;
begin
  RegisterComponents('Innerfuse', [TIFPS3CompExec, TIFPS3DllPlugin, TIFPS3ClassesPlugin]);
end;

function CompScriptUses(Sender: TIFPSPascalCompiler; const Name: string): Boolean;
begin
  Result := TIFPS3CompExec(Sender.ID).ScriptUses(Sender, Name);
end;

procedure ExecOnLine(Sender: TIFPSExec);
begin
  if assigned(TIFPS3CompExec(Sender.ID).FOnLine) then
  begin
    TIFPS3CompExec(Sender.ID).FOnLine(Sender.Id);
  end;
end;
{ TIFPS3CompilerPlugin }

destructor TIFPS3Plugin.Destroy;
begin
  SetCompiler(nil);
  inherited Destroy;
end;

procedure TIFPS3Plugin.SetCompiler(Value: TIFPS3CompExec);
begin
  if FCompExec <> Value then
  begin
    if FCompExec <> nil then
    begin
      FCompExec.FPlugins.Remove(Self);
    end;
    FCompExec := Value;
    if FCompExec <> nil then
    begin
      FCompExec.FPlugins.Add(Self);
    end;
  end;
end;

{ TIFPS3CompExec }

function TIFPS3CompExec.AddFunction(Ptr: Pointer;
  const Decl: string): Boolean;
begin
  Result := AddFunctionEx(Ptr, Decl, cdRegister);
end;

function TIFPS3CompExec.AddFunctionEx(Ptr: Pointer; const Decl: string;
  CallingConv: TDelphiCallingConvention): Boolean;
var
  P: TIFPSRegProc;
begin
  if not FCanAdd then begin Result := False; exit; end;
  p := RegisterDelphiFunctionC2(Comp, Decl);
  if p <> nil then
  begin
    RegisterDelphiFunctionR(Exec, Ptr, p.Name, CallingConv);
    Result := True;
  end else Result := False;
end;

function TIFPS3CompExec.AddRegisteredVariable(const VarName,
  VarType: string): Boolean;
var
  FVar: PIFPSVar;
begin
  if not FCanAdd then begin Result := False; exit; end;
  FVar := FComp.AddUsedVariableN(varname, vartype);
  if fvar = nil then
    result := False
  else begin
    fvar^.exportname := fvar^.Name;
    Result := True;
  end;
end;

function TIFPS3CompExec.Compile: Boolean;
var
  i: Longint;
begin
  FExec.Clear;
  FExec.ClearFunctionList;
  RegisterStandardLibrary_R(Exec);
  for i := 0 to FPlugins.Count -1 do
  begin
    TIFPS3Plugin(FPlugins[i]).ExecOnUses;
  end;
  FCanAdd := True;
  FComp.AllowNoBegin := icAllowNoBegin in FCompOptions;
  FComp.AllowUnit := icAllowUnit in FCompOptions;
  FComp.AllowNoEnd := icAllowNoEnd in FCompOptions;
  if FComp.Compile(FScript.Text) then
  begin
    FCanAdd := False;
    LoadExec;
    Result := True;
  end else Result := False;
end;

function TIFPS3CompExec.CompilerErrorToStr(I: Integer): string;
begin
  Result := IFPSMessageToString(CompilerMessages[i]); 
end;

constructor TIFPS3CompExec.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FComp := TIFPSPascalCompiler.Create;
  FExec := TIFPSDebugExec.Create;
  FScript := TStringList.Create;
  FPlugins := TList.Create;

  FComp.ID := Self;
  FComp.OnUses := CompScriptUses;
  FExec.Id := Self;
  FExec.OnRunLine:= ExecOnLine;
  
  FUseDebugInfo := True;
end;

destructor TIFPS3CompExec.Destroy;
var
  i: Longint;
begin
  for i := FPlugins.count -1 downto 0 do
  begin
    TIFPS3Plugin(FPlugins[i]).SetCompiler(nil);
  end;
  FPlugins.Free;
  FScript.Free;
  FExec.Free;
  FComp.Free;
  inherited Destroy;
end;

function TIFPS3CompExec.Execute: Boolean;
begin
  if @FOnExecute <> nil then
    FOnExecute(Self);
  Result := FExec.RunScript and (FExec.ExceptionCode = erNoError) ;
  if @FOnAfterExecute <> nil then
    FOnAfterExecute(Self);
end;

function TIFPS3CompExec.GetAbout: string;
begin
  Result := TIFPSExec.About;
end;

function TIFPS3CompExec.GetCompMsg(i: Integer): PIFPSPascalCompilerMessage;
begin
  Result := FComp.Msg[i];
end;

function TIFPS3CompExec.GetCompMsgCount: Longint;
begin
  Result := FComp.MsgCount;
end;

function TIFPS3CompExec.GetExecErrorByteCodePosition: Cardinal;
begin
  Result := Exec.ExceptionPos;
end;

function TIFPS3CompExec.GetExecErrorCode: TIFError;
begin
  Result := Exec.ExceptionCode;
end;

function TIFPS3CompExec.GetExecErrorParam: string;
begin
  Result := Exec.ExceptionString;
end;

function TIFPS3CompExec.GetExecErrorPosition: Cardinal;
begin
  Result := FExec.TranslatePosition(Exec.ExceptionProcNo, Exec.ExceptionPos);
end;

function TIFPS3CompExec.GetExecErrorProcNo: Cardinal;
begin
  Result := Exec.ExceptionProcNo;
end;

function TIFPS3CompExec.GetExecErrorString: string;
begin
  Result := TIFErrorToString(Exec.ExceptionCode, Exec.ExceptionString);
end;

procedure TIFPS3CompExec.GetPosXY(const Position: Integer; var X,
  Y: Integer);
var
  s: string;
  Pos, I: Longint;
begin
  s := FScript.Text;
  if Position > Length(s) then Pos := Length(s) else Pos := Position;
  x := 1;
  y := 1;
  i := 1;
  while i <= Pos do
  begin
    if (s[i] = #13) or (s[i] = #10) then
    begin
      if ((s[i+1] = #13) or (s[i+1] = #10)) and (s[i] <> s[i+1]) then
      inc(i);
      x := 1;
      inc(y);
    end else inc(x);
    inc(i);
  end;
end;

function TIFPS3CompExec.GetVariable(const Name: string): PIFVariant;
begin
  Result := FExec.GetVar2(name);
end;

procedure TIFPS3CompExec.LoadExec;
var
  s: string;
begin
  FComp.GetOutput(s);
  FExec.LoadData(s);
  if FUseDebugInfo then
  begin
    FComp.GetDebugOutput(s);
    FExec.LoadDebugData(s);
  end;
end;

function TIFPS3CompExec.ScriptUses(Sender: TIFPSPascalCompiler;
  const Name: string): Boolean;
var
  i: Longint;
begin
  if Name = 'SYSTEM' then
  begin
    RegisterStandardLibrary_C(Comp);
    for i := 0 to FPlugins.Count -1 do
    begin
      TIFPS3Plugin(FPlugins[i]).CompOnUses;
    end;
    if assigned(FOnCompile) then
      FOnCompile(Self);
    Result := True;
  end else begin
    Sender.MakeError('', ecUnknownIdentifier, Name);
    Result := False;
  end;
end;

procedure TIFPS3CompExec.SetScript(const Value: TStrings);
begin
  FScript.Assign(Value);
end;


{ TIFPS3DllPlugin }

procedure TIFPS3DllPlugin.CompOnUses;
begin
  CompExec.Comp.OnExternalProc := DllExternalProc;
end;

procedure TIFPS3DllPlugin.ExecOnUses;
begin
  RegisterDLLRuntime(CompExec.Exec);
end;

{ TIFPS3ClassesPlugin }

procedure TIFPS3ClassesPlugin.CompOnUses;
var
  x: TIFPSCompileTimeClassesImporter;
begin
  x := TIFPSCompileTimeClassesImporter.Create(FCompExec.Comp, True);
  if assigned(FOnCompImport) then
    FOnCompImport(Self, x);
end;

destructor TIFPS3ClassesPlugin.Destroy;
begin
  RI.Free;
  inherited Destroy;
end;

procedure TIFPS3ClassesPlugin.ExecOnUses;
begin
  if ri <> nil then
  begin
    RI.Free;
    RI := nil;
  end;
  RI := TIFPSRuntimeClassImporter.Create;
  if assigned(FOnExecImport) then
    FOnExecImport(Self, RI);
  RegisterClassLibraryRuntime(FCompExec.Exec, RI);
end;

function TIFPS3ClassesPlugin.SetVarToInstance(const VarName: string; cl: TObject): Boolean;
var
  p: PIFVariant;
begin
  if FCompExec = nil then begin Result := False; exit; end;
  p := FCompExec.GetVariable(VarName);
  if p <> nil then
  begin
    SetVariantToClass(p, cl);
    result := true;
  end else result := false;
end;



end.
