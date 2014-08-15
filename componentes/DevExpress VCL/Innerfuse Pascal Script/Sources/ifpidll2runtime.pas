unit ifpidll2runtime;

{$I ifps3_def.inc}
interface
uses
  ifpicall, ifps3, ifps3utl, ifps3common;
{Register the dll runtime library}
procedure RegisterDLLRuntime(Caller: TIFPSExec);
{Process a dll import (no need to call this function)}
function ProcessDllImport(Caller: TIFPSExec; P: PIFProcRec): Boolean;

implementation
uses
  {$IFDEF LINUX}
  LibC;
  {$ELSE}
  Windows;
  {$ENDIF}

{
p^.Ext1 contains the pointer to the Proc function
p^.ExportDecl:
  'dll:'+DllName+#0+FunctionName+#0+chr(Cc)+VarParams
}

type
  PLoadedDll = ^TLoadedDll;
  TLoadedDll = record
    dllnamehash: Longint;
    dllname: string;
    {$IFDEF LINUX}
    dllhandle: Pointer;
    {$ELSE}
    dllhandle: THandle;
    {$ENDIF}
  end;


procedure DllFree(Sender: TIFPSExec; P: PLoadedDll);
begin
  {$IFDEF LINUX}
  dlclose(p^.dllhandle);
  {$ELSE}
  FreeLibrary(p^.dllhandle);
  {$ENDIF}
  Dispose(p);
end;



function DllProc(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;

var
  i: Integer;
  MyList: TIfList;
  n: PIFVariant;
  CurrStack: Cardinal;
  cc: TCallingConvention;
  s: string;
begin
  s := p^.ExportDecl;
  delete(S, 1, pos(#0, s));
  delete(S, 1, pos(#0, s));
  if length(S) < 2 then
  begin
    Result := False;
    exit;
  end;
  cc := TCallingConvention(s[1]);
  delete(s, 1, 1);
  CurrStack := Stack.Count - Cardinal(length(s));
  if s[1] = #0 then inc(CurrStack);
  MyList := tIfList.Create;
  for i := 2 to length(s) do
  begin
    MyList.Add(nil);
  end;
  for i := length(s) downto 2 do
  begin
    n :=rp(Stack.GetItem(CurrStack));
    if s[i] <> #0 then
    begin
      n^.RefCount := n^.RefCount or IFPSAddrStackStart;
    end;
    MyList.SetItem(i - 2, n);
    inc(CurrStack);
  end;
  try
    if s[1] <> #0 then
    begin
      n := rp(Stack.GetItem(CurrStack));
    end else n := nil;
    InnerfuseCall(Caller, nil, p^.Ext1, cc, MyList, n, nil);
    result := true;
  except
    result := false;
  end;
  MyList.Free;
end;

function ProcessDllImport(Caller: TIFPSExec; P: PIFProcRec): Boolean;
var
  s, s2: string;
  h, i: Longint;
  ph: PLoadedDll;
  {$IFDEF LINUX}
  dllhandle: Pointer;
  {$ELSE}
  dllhandle: THandle;
  {$ENDIF}
begin
  s := p^.ExportDecl;
  Delete(s, 1, 4);
  s2 := copy(s, 1, pos(#0, s)-1);
  delete(s, 1, length(s2)+1);
  h := makehash(s2);
  i := 2147483647; // maxint
  dllhandle := 0;
  repeat
    ph := Caller.FindProcResource2(@dllFree, i);
    if i = -1 then
    begin
      {$IFDEF LINUX}
      dllhandle := dlopen(PChar(s2), RTLD_LAZY);
      {$ELSE}
      dllhandle := LoadLibrary(Pchar(s2));
      {$ENDIF}
      if dllhandle = {$IFDEF LINUX}nil{$ELSE}0{$ENDIF}then
      begin
        Result := False;
        exit;
      end;
      new(ph);
      ph^.dllnamehash := h;
      ph^.dllname := s2;
      ph^.dllhandle := dllhandle;
      Caller.AddResource(@DllFree, ph);
    end;
    if (ph^.dllnamehash = h) and (ph^.dllname = s2) then
    begin
      dllhandle := ph^.dllhandle;
    end;
    dec(i);
  until dllhandle <> {$IFDEF LINUX}nil{$ELSE}0{$ENDIF};
  {$IFDEF LINUX}
  p^.Ext1 := dlsym(dllhandle, pchar(copy(s, 1, pos(#0, s)-1)));
  {$ELSE}
  p^.Ext1 := GetProcAddress(dllhandle, pchar(copy(s, 1, pos(#0, s)-1)));
  {$ENDIF}
  p^.ProcPtr := DllProc;
  Result := p^.Ext1 <> nil;
end;

procedure RegisterDLLRuntime(Caller: TIFPSExec);
begin
  Caller.AddSpecialProcImport('dll', @ProcessDllImport, nil);
end;
end.
