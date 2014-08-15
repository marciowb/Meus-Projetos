unit atMemoInterface;

interface

{$I ASCRIPT.INC}

uses
  AdvMemo, atScript, Classes
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}                            
  ;


type

  /// Summary:
  ///   A deprecated component used to make memo and scripter integration easier
  /// Description:
  ///   TatMemoInterface is a component that provides GetCompletion and GetTokenHint methods to be used in TAdvMemo
  ///   event handlers. In OnGetCompletion event of TAdvMemo, you can call TatMemoInterface.GetCompletion method
  ///   to automatically provide the completion list. 
  TatMemoInterface = class(TComponent)    
  private
    FMemo: TAdvCustomMemo;
    FScripter: TatCustomScripter;
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    /// Summary:
    ///   Returns the AHint value to be displayed according to the token provided by AToken
    /// Example:
    ///   GetTokenHint('MyVar', MyHint);
    function GetTokenHint(AToken: string; var AHint: string): boolean;
    
    /// Summary:
    ///   Returns a completion list in AList parameter. AToken parameter is not used, the cursor position
    ///   of the memo is used to know the context of code completion   
    /// Example:
    ///   GetCompletion('Button1.', MyCompletionList);
    procedure GetCompletion(AToken: string; AList: TStringList);
  published
    /// Summary:
    ///   Points to the scripter component used to create the code completion list 
    property Scripter: TatCustomScripter read FScripter write FScripter;
    
    /// Summary:
    ///   Points to the memo component used to create the code completion list. The memo is used to retrieve the
    ///   source code and also the memo position, in order to know the context of code completion.
    ///   This property is used by method GetCompletion.
    property Memo: TAdvCustomMemo read FMemo write FMemo;
  end;

implementation

{ TatMemoInterface }

procedure TatMemoInterface.GetCompletion(AToken: string;
  AList: TStringList);
var
  e,l: integer;
  tp: integer;
  sl: tstringlist;
  s,r:string;
  no: TObject;

begin
  if not Assigned(Memo) then
    Exit;
  if not Assigned(Scripter) then
    Exit;

  if (Memo.Lines.Text <> Scripter.SourceCode.Text) and not Scripter.Running then
  begin
    Scripter.CurrentScript.Refactor.BeginRefactor;
    Scripter.SourceCode := Memo.Lines;
    Scripter.CurrentScript.Refactor.EndRefactor;
  end;

  AList.Clear;
  Memo.TextFromPos(Memo.CurX,Memo.CurY,tp);
  sl := CreateCodeCompletionList(Scripter,
    Memo.Lines.Text,tp + 1,e,l);

  for e := 1 to sl.Count do
  begin
    s := sl.Strings[e - 1];
    l := pos(' ',s);
    if l > 0 then
    begin
      r := copy(s,1,l - 1);
      delete(s,1,l);
    end
    else
      r := '';

    while pos('.',s) > 0 do
    begin
      delete(s,1,pos('.',s));
    end;

    {$WARNINGS OFF}
    case integer(sl.Objects[e - 1]) of
    {$WARNINGS ON}
    0: sl.Strings[e - 1] := 'property ' + s;
    1,17: sl.Strings[e - 1] := 'procedure ' + s;
    2,18: sl.Strings[e - 1] := 'function ' + s;
    3,19: sl.Strings[e - 1] := 'event ' + s;
    16: sl.Strings[e - 1] := 'var ' + s
    else
      sl.Strings[e - 1] := s;
    end;
    // (ttNone, ttVar, ttProp, ttEvent, ttMethod, ttFunc, ttProc);
    {$WARNINGS OFF}
    case integer(sl.Objects[e - 1]) of
    {$WARNINGS ON}
    0: no := TObject(ttProp);
    1: no := TObject(ttMethod);
    2: no := TObject(ttMethod);
    3: no := TObject(ttEvent);
    16: no := TObject(ttVar);
    17: no := TObject(ttProc);
    18: no := TObject(ttFunc);
    19: no := TObject(ttEvent)
    else
      no := TObject(ttNone);
    end;
    sl.Objects[e - 1] := no;
  end;
  AList.AddStrings(sl);
  sl.Free;
end;

function TatMemoInterface.GetTokenHint(AToken: string; var AHint: string): boolean;
var
  v: variant;
  s: string;
  {$IFDEF DELPHI6_LVL}
  vt: TVarType;
  {$ELSE}
  vt: Integer;
  {$ENDIF}
begin
  Result := false;

  try
    v := EvaluateWatch(Scripter,AToken);

    Result := v <> null;

    if v <> null then
    begin
      s := v;
      AHint := 'value = ' + s;
      vt := vartype(v);
      case vt of
      varInteger: AHint := AHint + ': integer';
      varDouble: AHint := AHint + ': double';
      varString: AHint := AHint + ': string';
      varByte: AHint := AHint + ': byte';
      {$IFDEF DELPHI6_LVL}
      varWord: AHint := AHint + ': word';
      {$ENDIF}
      varBoolean: AHint := AHint + ': boolean';
      varDate: AHint := AHint + ': TDateTime';
      varArray: AHint := AHint + ': array';
      end;
    end;
  except
  end;

end;

procedure TatMemoInterface.Notification(AComponent: TComponent;AOperation: TOperation);
begin
  if (AOperation = opRemove) and (AComponent = FScripter) then
    FScripter := nil;
  if (AOperation = opRemove) and (AComponent = FMemo) then
    FMemo := nil;
  inherited;
end;

end.
