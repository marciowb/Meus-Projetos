unit atScripter;

interface
uses Classes, atScript, atPascal, atBasic;

type
  {Indicates the language/syntax of the script.} 
  TScriptLanguage = (
    slPascal,  //Pascal language 
    slBasic    //Basic language
  );

  /// Summary:
  ///   Main scripter component used to execute scripts, supporting several languages.
  /// Description:
  ///   TatScripter component is a TatCustomScripter descendant that effectively implement the script languages.
  ///   Alternatively to the deprecated TatPascalScripter and TatBasicScripter components, which only deal with one
  ///   language type, TatScripter component can create and execute scripts in all languages supported by Scripter Studio
  ///   package. You can use AddScript method to add a new script and define its language.
  ///   Most of properties, methods, collections you will use in TatScripter are implemented in its abstract ancestor,
  ///   TatCustomScripter.
  /// See Also:
  ///   TatCustomScripter
  TatScripter = class(TatCustomScripter)
  private
    FDefaultLanguage: TScriptLanguage;
    function LanguageToClass(ALanguage: TScriptLanguage): TScriptClass;
  protected
    procedure DefineInternalClasses; override;
    function DefaultScriptClass: TScriptClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// Summary:
    ///   Adds a new script object in Scripts collection with the specified language.
    /// Description:
    ///   Use AddScript method to create a new script in Scripts collection. You can use this method as an alternative to
    ///   Scripts.Add, which uses DefaultLanguage property to know which language the created script will support.
    ///   Depending on the language, AddScript creates a TatScript descendant (for example, TatPascalScript for pascal language.
    /// Parameters:
    ///   ALanguage - Specifies the language of the script to be created.
    /// See Also:
    ///   DefaultLanguage
    function AddScript(ALanguage: TScriptLanguage): TatScript;
  published
    /// Summary:
    ///   Specifies the default language for next scripts added to the collection.
    /// Description:
    ///   Use DefaultLanguage to specify the language of the next scripts created in the scripter component using Scripts.Add
    ///   method. Note that changing DefaultLanguage does not change the language of existing script objects, it will only
    ///   be used for the next scripts that will be created.
    ///   Alternatively you can use AddScript method to add a script specifying the language of the script as a parameter.
    /// See Also:
    ///   TatScripts.Add; AddScript
    property DefaultLanguage: TScriptLanguage read FDefaultLanguage write FDefaultLanguage;

    property SourceCode;
    property Compiled;
    property SaveCompiledCode;
    property EventSupport;
    property EventSetMode;
    property EventUnsetMode;
    property OnDebugHook;
    property OnExecHook; 
    property OnCompileError;
    property OnRuntimeError;
    property OnExecuteEvent;
    property OnSettingEvent;
    property OnSetEvent;
    property OnUnsettingEvent;
    property ShortBooleanEval;
    property LibOptions;
    property CallExecHookEvent;
    property OnUnknownElement;
    property OnBreakpointStop;
  end;

implementation

{ TatScripter }

function TatScripter.AddScript(ALanguage: TScriptLanguage): TatScript;
begin
  result := LanguageToClass(ALanguage).Create(Scripts);
end;

constructor TatScripter.Create(AOwner: TComponent);
begin
  FDefaultLanguage := slPascal;
  ShortBooleanEval := true;
  OptionExplicit := true;
  inherited Create(AOwner);
   if Assigned(OnGlobalScripterCreate) then
     OnGlobalScripterCreate(Self);
end;

function TatScripter.DefaultScriptClass: TScriptClass;
begin
  result := LanguageToClass(FDefaultLanguage);
end;

procedure TatScripter.DefineInternalClasses;
begin
  inherited;
  ScriptClass := TatScript; //Do not create a specific script language
  MachineClass := TatVirtualMachine;
end;

destructor TatScripter.Destroy;
begin
  inherited;

end;

function TatScripter.LanguageToClass(ALanguage: TScriptLanguage): TScriptClass;
begin
  Case ALanguage of
    slBasic: result := TatBasicScript;
  else
    //slPascal
    result := TatPascalScript;
  end;
end;

end.
