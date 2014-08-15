unit atWebScripter;

interface

{
  What's new:
  24 July 2003 Version 2.4.8:
    What's new:
      - AfterCompile event added, this is only executed in the ContentFrom....
        methods after SourceCode is compiled. This is the place to save
        your compiled code if you like.
      - Scripter property removed, since only one scripter is created in the
        ContentFrom... and ContentFromCompiled... methods.

  24 May 2003 Version 2.4.7:
    What's new:
      - BeforeExecute and AfterExecute Events added

  07 May 2003 Version 2.4.6:
    What's changed:
      - Component renamed to TatWebScripter to be compatible with Bruno's notation.
        (Also the Eventnames and filenames are changed)

    What's new:
      - <@Language=VBScript%> and <@Language=Pascal%> are supported to
        set the language through the script. :-)
        WARNING: This has to be the first characters encountered !
                 (except Linebreaks), if placed somewhere else,
                 a scripting error will occur.
      - <!--# . . . --> will also trigger the Directive handler to be more
        compatible with MS-ASP :-)
        WARNING It will only be triggered in HTML blocks, not in Script-blocks !
      - TatPageProducer included to support the PageProducer mechanism

  14 Apr 2003 Version 1.0.0:
    - Initial version.

  Designed and developed by Any Key Software Solutions.
}

uses
  SysUtils, Classes, atScript, atPascal, atBasic, atHTMLParse; 

type
  TScripterNotifyEvent = procedure (Sender: TObject; AScripter: TatCustomScripter) of object;
  TatWebScripter = class(TComponent)
  private
    { Private declarations }
    FWebScript: TStringList;
    FOutput: TStringList;

    FLanguage: TatLanguage;
    FOnExecuteEvent: TExecuteEventProc;
    FOnDebugHook: TNotifyEvent;
    FOnDirective: TDirectiveEvent;
    FOnCompileError: TScriptErrorEvent;
    FOnSetEvent: TSetEventProc;
    FOnSettingEvent: TSettingEventProc;
    FOnUnsettingEvent: TUnsetEventProc;
    FAfterPreCompile: TAfterPreCompileEvent;
    FOnInitScripter: TScripterNotifyEvent;
    FBeforeExecute: TScripterNotifyEvent;
    FAfterExecute: TScripterNotifyEvent;
    FAfterCompile: TScripterNotifyEvent;

    procedure atCompileError(Sender: TObject; var msg: String; row, col: Integer; var ShowException: Boolean);
    procedure atDebugHook(Sender: TObject);
    procedure atExecuteEvent(AEventDispatcher: TatEventDispatcher; var AExecute: Boolean);
    procedure atSetEvent(AEventDispatcher: TatEventDispatcher);
    procedure atSettingEvent(Sender, AInstance: TObject;
      APropName, ARoutineName: String; AScripter: TatCustomScripter;
      APlacement: TatEventPlacement; var AProcede: Boolean);
    procedure atUnsettingEvent(AEventDispatcher: TatEventDispatcher; var AProcede: Boolean);


    function GetWebScript: TStrings;
    procedure SetWebScript(const Value: TStrings);
  protected
    { Protected declarations }
    procedure Script_Write(AMachine: TatVirtualMachine);
    procedure Script_WriteLn(AMachine: TatVirtualMachine);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitScripter(AScripter: TatCustomScripter);
    procedure Clear;
    function Content: string;
    function ContentFromString(const S: string): string;
    function ContentFromFile(const AFileName: string): string;
    function ContentFromStream(AStream: TStream): string;

    function ContentFromCompiledStream(AStream: TStream): string;
    function ContentFromCompiledFile(const AFileName: string): string;

    property Output: TStringList read FOutput;
  published
    { Published declarations }
    property Language: TatLanguage read FLanguage write FLanguage;
    property WebScript: TStrings read GetWebScript write SetWebScript;

    property AfterPreCompile: TAfterPreCompileEvent read FAfterPreCompile write FAfterPreCompile;
    property AfterCompile: TScripterNotifyEvent read FAfterCompile write FAfterCompile;
    property AfterExecute: TScripterNotifyEvent read FAfterExecute write FAfterExecute;
    property BeforeExecute: TScripterNotifyEvent read FBeforeExecute write FBeforeExecute;
    property OnCompileError: TScriptErrorEvent read FOnCompileError write FOnCompileError;
    property OnDebugHook: TNotifyEvent read FOnDebugHook write FOnDebugHook;
    property OnDirective: TDirectiveEvent read FOnDirective write FOnDirective;
    property OnExecuteEvent: TExecuteEventProc read FOnExecuteEvent write FOnExecuteEvent;
    property OnInitScripter: TScripterNotifyEvent read FOnInitScripter write FOnInitScripter;
    property OnSetEvent: TSetEventProc read FOnSetEvent write FOnSetEvent;
    property OnSettingEvent: TSettingEventProc read FOnSettingEvent write FOnSettingEvent;
    property OnUnsettingEvent: TUnsetEventProc read FOnUnsettingEvent write FOnUnsettingEvent;
  end;

implementation

{==============================================================================}

type
  TatScripterClass = class of TatCustomScripter;

const
  AScripterClasses: array[TatLanguage] of TatScripterClass = (TatPascalScripter, TatBasicScripter);

{ TatWebScripter }

constructor TatWebScripter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOutput := TStringList.Create;
  FWebScript := TStringList.Create;
end;

destructor TatWebScripter.Destroy;
begin
  FOutput.Free;
  FWebScript.Free;

  inherited Destroy;
end;

{=== Scripter event handlers ==================================================}

procedure TatWebScripter.atCompileError(Sender: TObject;
  var msg: String; row, col: Integer; var ShowException: Boolean);
begin
  ShowException := False;
  FOutput.Add(Format('["%s" on Line %d Column %d]', [msg, row, col]));

  if Assigned(FOnCompileError) then
    FOnCompileError(Sender, msg, row, col, ShowException);
end;

procedure TatWebScripter.atDebugHook(Sender: TObject);
begin
  if Assigned(FOnDebugHook) then
    FOnDebugHook(Sender);
end;

procedure TatWebScripter.atExecuteEvent(AEventDispatcher: TatEventDispatcher; var AExecute: Boolean);
begin
  if Assigned(FOnExecuteEvent) then
    FOnExecuteEvent(AEventDispatcher, AExecute);
end;

procedure TatWebScripter.atSetEvent(AEventDispatcher: TatEventDispatcher);
begin
  if Assigned(FOnSetEvent) then
    FOnSetEvent(AEventDispatcher);
end;

procedure TatWebScripter.atSettingEvent(Sender, AInstance: TObject;
  APropName, ARoutineName: String; AScripter: TatCustomScripter;
  APlacement: TatEventPlacement; var AProcede: Boolean);
begin
  if Assigned(FOnSettingEvent) then
    FOnSettingEvent(Sender, AInstance, APropName, ARoutineName, AScripter, APlacement, AProcede);
end;

procedure TatWebScripter.atUnsettingEvent(AEventDispatcher: TatEventDispatcher; var AProcede: Boolean);
begin
  if Assigned(FOnUnsettingEvent) then
    FOnUnSettingEvent(AEventDispatcher, AProcede);
end;

{==============================================================================}

function TatWebScripter.GetWebScript: TStrings;
begin
  Result := FWebScript;
end;

procedure TatWebScripter.SetWebScript(const Value: TStrings);
begin
  if Value <> FWebScript then
  begin
    Clear;
    FWebScript.Assign(Value);
  end;
end;

procedure TatWebScripter.Clear;
begin
  FWebScript.Clear;
  FOutput.Clear;
end;

function TatWebScripter.Content: string;
var
  InStream: TStream;
  S: string;
begin
  Result := '';

  //InStream := TStringStream.Create(FWebScript.Text);
  InStream := TMemoryStream.Create;
  S := FWebScript.Text;
  InStream.WriteBuffer(PChar(S)^, Length(S) * SizeOf(Char));
  InStream.Position := 0;
  try
    Result := ContentFromStream(InStream);
  finally
    InStream.Free;
    Result := FOutput.Text;
  end;
end;

function TatWebScripter.ContentFromString(const S: string): string;
var
  InStream: TStream;
begin
//  InStream := TStringStream.Create(S);
  InStream := TMemoryStream.Create;
  InStream.Write(PChar(S)^, Length(S) * SizeOf(Char));
  InStream.Position := 0;
  try
    Result := ContentFromStream(InStream);
  finally
    InStream.Free;
  end;
end;

function TatWebScripter.ContentFromFile(const AFileName: string): string;
var
  InStream: TStream;
begin
  InStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Result := ContentFromStream(InStream);
  finally
    InStream.Free;
  end;
end;

function TatWebScripter.ContentFromStream(AStream: TStream): string;
var
  Scripter: TatCustomScripter;
  bOptionExplicit: Boolean;
  SLCode: TStringList;
begin
  FOutput.Clear;
  SLCode := TStringList.Create;
  try
    bOptionExplicit := False;
    ParseWebScript(AStream, SLCode, FLanguage, bOptionExplicit, Self, FOnDirective);
    Scripter := AScripterClasses[FLanguage].Create(nil);
    try
      InitScripter(Scripter);
      Scripter.OptionExplicit := bOptionExplicit;
      Scripter.SourceCode.Assign(SLCode);

      if Assigned(FAfterPreCompile) then
        FAfterPreCompile(Self, FLanguage, Scripter.SourceCode);
      try
        Scripter.Compile;
        if Scripter.Compiled then
        begin
          if Assigned(FAfterCompile) then
           FAfterCompile(Self, Scripter);

          if Assigned(FBeforeExecute) then
            FBeforeExecute(Self, Scripter);
          Scripter.Execute;

          if Assigned(FAfterExecute) then
            FAfterExecute(Self, Scripter);
        end;
      except
        on E: Exception do
          FOutput.Text := FOutput.Text + E.Message;
      end;
    finally
      Scripter.Free;
    end;
  finally
    Result := FOutput.Text;
    SLCode.Free;
  end;
end;

function TatWebScripter.ContentFromCompiledFile(const AFileName: string): string;
var
  InStream: TStream;
begin
  InStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    InStream.Position := 0;
    Result := ContentFromCompiledStream(InStream);
  finally
    InStream.Free;
  end;
end;

function TatWebScripter.ContentFromCompiledStream(AStream: TStream): string;
var
  Scripter: TatCustomScripter;
begin
  Clear;
  Scripter := AScripterClasses[FLanguage].Create(nil);
  try
    InitScripter(Scripter);
    Scripter.LoadCodeFromStream(AStream);
    try
      if Assigned(FBeforeExecute) then
        FBeforeExecute(Self, Scripter);

      if Scripter.Compiled then
        Scripter.Execute;

      if Assigned(FAfterExecute) then
        FAfterExecute(Self, Scripter);
    except
      on E: Exception do
      begin
        FOutput.Text := FOutput.Text + E.Message;
      end;
    end;
  finally
    Result := FOutput.Text;
    Scripter.Free;
  end;
end;

procedure TatWebScripter.InitScripter(AScripter: TatCustomScripter);
begin
  with AScripter do
  begin
    OnCompileError   := atCompileError;
    OnDebugHook      := atDebugHook;
    OnExecuteEvent   := atExecuteEvent;
    OnSetEvent       := atSetEvent;
    OnSettingEvent   := atSettingEvent;
    OnUnsettingEvent := atUnsettingEvent;

    AddComponent(Self);
    SystemLibrary.DefineMethod('Write', 1, tkNone, nil, Script_Write);
    SystemLibrary.DefineMethod('WriteLn', 1, tkNone, nil, Script_WriteLn);

    if Assigned(FOnInitScripter) then
      FOnInitScripter(Self, AScripter);
  end;
end;

procedure TatWebScripter.Script_Write(AMachine: TatVirtualMachine);
begin
  with AMachine do
    FOutput.Text := FOutPut.Text + GetInputArgAsString(0);
end;

procedure TatWebScripter.Script_WriteLn(AMachine: TatVirtualMachine);
begin
  with AMachine do
    FOutput.Add(GetInputArgAsString(0));
end;

end.
