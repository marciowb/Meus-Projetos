unit ifps3debug;
{

Innerfuse Pascal Script III
Copyright (C) 2000-2002 by Carlo Kok (ck@carlo-kok.com)

}
{$I ifps3_def.inc}
interface
uses
  ifps3, ifps3utl;

type
  {The current debugging mode}
  TDebugMode = (dmRun, dmStepOver, dmStepInto, dmPaused);
  {The TIFPSCustomDebugExec class is used to load and use compiler debug information}
  TIFPSCustomDebugExec = class(TIFPSExec)
  protected
    FDebugDataForProcs: TIfList;
    FLastProc: PIFProcRec;
    FCurrentDebugProc: Pointer;
    FProcNames: TIFStringList;
    FGlobalVarNames: TIfStringList;
    FCurrentSourcePos: Cardinal;
    function GetCurrentProcParams: TIfStringList;
    function GetCurrentProcVars: TIfStringList;
  protected
    procedure ClearDebug; virtual;
  public
    {The current proc no}
    function GetCurrentProcNo: Cardinal;
    {Get the current position}
    function GetCurrentPosition: Cardinal;
    {Translate a position to a real position}
    function TranslatePosition(Proc, Position: Cardinal): Cardinal;
    {Load debug data in the scriptengine}
    procedure LoadDebugData(const Data: string);
	{Clear the debugdata and the current script}
    procedure Clear; override;
    {Contains the names of the global variables}
    property GlobalVarNames: TIfStringList read FGlobalVarNames;
	{Contains the names of the procedures}
    property ProcNames: TIfStringList read FProcNames;
	{The variables in the current proc (could be nil)}
    property CurrentProcVars: TIfStringList read GetCurrentProcVars;
	{The paramters of the current proc (could be nil)}
    property CurrentProcParams: TIfStringList read GetCurrentProcParams;
    {Get global variable no I}
    function GetGlobalVar(I: Cardinal): PIfVariant;
	{Get Proc variable no I}
    function GetProcVar(I: Cardinal): PIfVariant;
	{Get proc param no I}
    function GetProcParam(I: Cardinal): PIfVariant;
    {Create an instance of the debugger}
    constructor Create;
	{destroy the current instance of the debugger}
    destructor Destroy; override;
  end;
  TIFPSDebugExec = class;
  {see TIFPSDebugExec.OnSourceLine}
  TOnSourceLine = procedure (Sender: TIFPSDebugExec; Position: Cardinal);
  {see TIFPSDebugExec.OnIdleCall}
  TOnIdleCall = procedure (Sender: TIFPSDebugExec);
  {The TIFPSCustomDebugExec class is used to load and use compiler debug information}
  TIFPSDebugExec = class(TIFPSCustomDebugExec)
  private
    FDebugMode: TDebugMode;
    FStepOverStackBase: Cardinal;
    FOnIdleCall: TOnIdleCall;
    FOnSourceLine: TOnSourceLine;
  protected
    procedure SourceChanged;
    procedure ClearDebug; override;
    procedure RunLine; override;
  public
    function LoadData(const s: string): Boolean; override;
    procedure Pause; override;
    procedure Run;
    procedure StepInto;
    procedure StepOver;
    procedure Stop; override;
	{Contains the current debugmode}
    property DebugMode: TDebugMode read FDebugMode;
    {OnSourceLine is called after passing each source line}
    property OnSourceLine: TOnSourceLine read FOnSourceLine write FOnSourceLine;
	{OnIdleCall is called when the script is paused}
    property OnIdleCall: TOnIdleCall read FOnIdleCall write FOnIdleCall;
  end;

implementation

type
  PPositionData = ^TPositionData;
  TPositionData = packed record
    Position,
    SourcePosition: Cardinal;
  end;
  PFunctionInfo = ^TFunctionInfo;
  TFunctionInfo = packed record
    Func: PIFProcRec;
    FParamNames: TIfStringList;
    FVariableNames: TIfStringList;
    FPositionTable: TIfList;
  end;

{ TIFPSCustomDebugExec }

procedure TIFPSCustomDebugExec.Clear;
begin
  inherited Clear;
  if FGlobalVarNames <> nil then ClearDebug;
end;

procedure TIFPSCustomDebugExec.ClearDebug;
var
  i, j: Longint;
  p: PFunctionInfo;
begin
  FCurrentDebugProc := nil;
  FLastProc := nil;
  FProcNames.Clear;
  FGlobalVarNames.Clear;
  FCurrentSourcePos := Cardinal(-1);
  for i := 0 to FDebugDataForProcs.Count -1 do
  begin
    p := FDebugDataForProcs.GetItem(I);
    for j := 0 to p^.FPositionTable.Count -1 do
    begin
      Dispose(PPositionData(P^.FPositionTable.GetItem(J)));
    end;
    p^.FPositionTable.Free;
    p^.FParamNames.Free;
    p^.FVariableNames.Free;
    Dispose(p);
  end;
  FDebugDataForProcs.Clear;
end;

constructor TIFPSCustomDebugExec.Create;
begin
  inherited Create;
  FCurrentSourcePos := Cardinal(-1);
  FDebugDataForProcs := TIfList.Create;
  FLastProc := nil;
  FCurrentDebugProc := nil;
  FProcNames := TIFStringList.Create;
  FGlobalVarNames := TIfStringList.Create;
end;

destructor TIFPSCustomDebugExec.Destroy;
begin
  Clear;
  FDebugDataForProcs.Free;
  FProcNames.Free;
  FGlobalVarNames.Free;
  FGlobalVarNames := nil;
  inherited Destroy;
end;

function TIFPSCustomDebugExec.GetCurrentPosition: Cardinal;
begin
  Result := TranslatePosition(GetCurrentProcNo, 0);
end;

function TIFPSCustomDebugExec.GetCurrentProcNo: Cardinal;
var
  i: Longint;
begin
  for i := 0 to FProcs.Count -1 do
  begin
    if FProcs.GetItem(i) = FCurrProc then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := Cardinal(-1);
end;

function TIFPSCustomDebugExec.GetCurrentProcParams: TIfStringList;
begin
  if FCurrentDebugProc <> nil then
  begin
    Result := PFunctionInfo(FCurrentDebugProc)^.FParamNames;
  end else Result := nil;
end;

function TIFPSCustomDebugExec.GetCurrentProcVars: TIfStringList;
begin
  if FCurrentDebugProc <> nil then
  begin
    Result := PFunctionInfo(FCurrentDebugProc)^.FVariableNames;
  end else Result := nil;
end;

function TIFPSCustomDebugExec.GetGlobalVar(I: Cardinal): PIfVariant;
begin
  Result := FGlobalVars.GetItem(I);
end;

function TIFPSCustomDebugExec.GetProcParam(I: Cardinal): PIfVariant;
begin
  Result := FStack.GetItem(Cardinal(Longint(FCurrStackBase) - Longint(I) - 1));
end;

function TIFPSCustomDebugExec.GetProcVar(I: Cardinal): PIfVariant;
begin
  Result := FStack.GetItem(Cardinal(Longint(FCurrStackBase) + Longint(I) + 1));
end;

function GetProcDebugInfo(FProcs: TIFList; Proc: PIFProcRec): PFunctionInfo;
var
  i: Longint;
  c: PFunctionInfo;
begin
  if Proc = nil then
  begin
    Result := nil;
    exit;
  end;
  for i := 0 to FProcs.Count -1 do
  begin
    c := FProcs.GetItem(I);
    if c^.Func = Proc then
    begin
      Result := c;
      exit;
    end;
  end;
  new(c);
  c^.Func := Proc;
  c^.FPositionTable := TIfList.Create;
  c^.FVariableNames := TIfStringList.Create;
  c^.FParamNames := TIfStringList.Create;
  FProcs.Add(c);
  REsult := c;
end;

procedure TIFPSCustomDebugExec.LoadDebugData(const Data: string);
var
  CP, I: Longint;
  c: char;
  CurrProcNo, LastProcNo: Cardinal;
  LastProc: PFunctionInfo;
  NewLoc: PPositionData;
begin
  ClearDebug;
  if FStatus = isNotLoaded then exit;
  CP := 1;
  LastProcNo := Cardinal(-1);
  LastProc := nil;
  while CP <= length(Data) do
  begin
    c := Data[CP];
    inc(cp);
    case c of
      #0:
        begin
          i := cp;
          if i > length(data) then exit;
          while Data[i] <> #0 do
          begin
            if Data[i] = #1 then
            begin
              FProcNames.Add(Copy(Data, cp, i-cp));
              cp := I + 1;
            end;
            inc(I);
            if I > length(data) then exit;
          end;
          cp := i + 1;
        end;
      #1:
        begin
          i := cp;
          if i > length(data) then exit;
          while Data[i] <> #0 do
          begin
            if Data[i] = #1 then
            begin
              FGlobalVarNames.Add(Copy(Data, cp, i-cp));
              cp := I + 1;
            end;
            inc(I);
            if I > length(data) then exit;
          end;
          cp := i + 1;
        end;
      #2:
        begin
          if cp + 4 > Length(data) then exit;
          CurrProcNo := Cardinal((@Data[cp])^);
          if CurrProcNo = Cardinal(-1) then Exit;
          if CurrProcNo <> LastProcNo then
          begin
            LastProcNo := CurrProcNo;
            LastProc := GetProcDebugInfo(FDebugDataForProcs, FProcs.GetItem(CurrProcNo));
            if LastProc = nil then exit;
          end;
          inc(cp, 4);

          i := cp;
          if i > length(data) then exit;
          while Data[i] <> #0 do
          begin
            if Data[i] = #1 then
            begin
              LastProc^.FParamNames.Add(Copy(Data, cp, i-cp));
              cp := I + 1;
            end;
            inc(I);
            if I > length(data) then exit;
          end;
          cp := i + 1;
        end;
      #3:
        begin
          if cp + 4 > Length(data) then exit;
          CurrProcNo := Cardinal((@Data[cp])^);
          if CurrProcNo = Cardinal(-1) then Exit;
          if CurrProcNo <> LastProcNo then
          begin
            LastProcNo := CurrProcNo;
            LastProc := GetProcDebugInfo(FDebugDataForProcs, FProcs.GetItem(CurrProcNo));
            if LastProc = nil then exit;
          end;
          inc(cp, 4);

          i := cp;
          if i > length(data) then exit;
          while Data[i] <> #0 do
          begin
            if Data[i] = #1 then
            begin
              LastProc^.FVariableNames.Add(Copy(Data, cp, i-cp));
              cp := I + 1;
            end;
            inc(I);
            if I > length(data) then exit;
          end;
          cp := i + 1;
        end;
      #4:
        begin
          if cp + 4 > Length(data) then exit;
          CurrProcNo := Cardinal((@Data[cp])^);
          if CurrProcNo = Cardinal(-1) then Exit;
          if CurrProcNo <> LastProcNo then
          begin
            LastProcNo := CurrProcNo;
            LastProc := GetProcDebugInfo(FDebugDataForProcs, FProcs.GetItem(CurrProcNo));
            if LastProc = nil then exit;
          end;
          inc(cp, 4);
          if cp + 8 > Length(data) then exit;
          new(NewLoc);
          NewLoc^.Position := Cardinal((@Data[Cp])^);
          NewLoc^.SourcePosition := Cardinal((@Data[Cp+4])^);
          inc(cp, 8);
          LastProc^.FPositionTable.Add(NewLoc);
        end;
      else
        begin
          ClearDebug;
          Exit;
        end;
    end;

  end;
end;






function TIFPSCustomDebugExec.TranslatePosition(Proc, Position: Cardinal): Cardinal;
// Made by Martijn Laan (mlaan@wintax.nl)
var
  i: LongInt;
  fi: PFunctionInfo;
  pt: TIfList;
  r: PPositionData;
  LastSourcePosition: Cardinal;
  pp: PIFProcRec;
begin
  fi := nil;
  pp := FProcs.GetItem(Proc);
  for i := 0 to FDebugDataForProcs.Count -1 do
  begin
    fi := FDebugDataForProcs.GetItem(i);
    if fi^.Func = pp then
      Break;
    fi := nil;
  end;
  LastSourcePosition := 0;
  if fi <> nil then begin
    pt := fi^.FPositionTable;
    for i := 0 to pt.Count -1 do
    begin
      r := pt.GetItem(I);
      if r^.Position >= Position then
      begin
        if r^.Position = Position then
          Result := r^.SourcePosition
        else
          Result := LastSourcePosition;
        exit;
      end else
        LastSourcePosition := r^.SourcePosition;
    end;
  end;
  Result := LastSourcePosition;
end;

{ TIFPSDebugExec }
procedure TIFPSDebugExec.ClearDebug;
begin
  inherited;
  FDebugMode := dmRun;
end;

function TIFPSDebugExec.LoadData(const s: string): Boolean;
begin
  Result := inherited LoadData(s);
  FDebugMode := dmRun;
end;

procedure TIFPSDebugExec.RunLine;
var
  i: Longint;
  pt: TIfList;
  r: PPositionData;
begin
  inherited RunLine;
  if FCurrProc <> FLastProc then
  begin
    FLastProc := FCurrProc;
    FCurrentDebugProc := nil;
    for i := 0 to FDebugDataForProcs.Count -1 do
    begin
      if PFunctionInfo(FDebugDataForProcs.GetItem(I))^.Func = FLastProc then
      begin
        FCurrentDebugProc := FDebugDataForProcs.GetItem(I);
        break;
      end;
    end;
  end;
  if FCurrentDebugProc <> nil then
  begin
    pt := PFunctionInfo(FCurrentDebugProc)^.FPositionTable;
    for i := 0 to pt.Count -1 do
    begin
      r := pt.GetItem(I);
      if r^.Position = FCurrentPosition then
      begin
        FCurrentSourcePos := r^.SourcePosition;
        SourceChanged;
        break;
      end;
    end;
  end else
  begin
    FCurrentSourcePos := Cardinal(-1);
  end;
  while FDebugMode = dmPaused do
  begin
    if @FOnIdleCall <> nil then
    begin
      FOnIdleCall(Self);
    end else break; // endless loop
  end;
end;


procedure TIFPSDebugExec.SourceChanged;
begin
  case FDebugMode of
    dmStepInto:
      begin
        FDebugMode := dmPaused;
      end;
    dmStepOver:
      begin
        if FCurrStackBase <= FStepOverStackBase then
        begin
          FDebugMode := dmPaused;
        end;
      end;
  end;
  if @FOnSourceLine <> nil then
    FOnSourceLine(Self, FCurrentSourcePos);
end;


procedure TIFPSDebugExec.Pause;
begin
  FDebugMode := dmPaused;
end;

procedure TIFPSDebugExec.Stop;
begin
  FDebugMode := dmRun;
  inherited Stop;
end;

procedure TIFPSDebugExec.Run;
begin
  FDebugMode := dmRun;
end;

procedure TIFPSDebugExec.StepInto;
begin
  FDebugMode := dmStepInto;
end;

procedure TIFPSDebugExec.StepOver;
begin
  FDebugMode := dmStepOver;
  FStepOverStackBase := FCurrStackBase;
end;


end.
