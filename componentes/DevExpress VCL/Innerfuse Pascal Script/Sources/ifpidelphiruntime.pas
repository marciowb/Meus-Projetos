{Delphi function importer (runtime)}
unit ifpidelphiruntime;
{
  Innerfuse Pascal Script Call unit
  You may not copy a part of this unit, only use it as whole, with
  Innerfuse Pascal Script Script Engine.
}
{$I ifps3_def.inc}
interface
uses
  ifpicall, ifps3, ifps3utl, ifps3common;
type
  {The calling convention}
  TDelphiCallingConvention = (cdRegister, cdPascal, CdCdecl, CdStdCall);

{Register a delphi function}
procedure RegisterDelphiFunctionR(Se: TIFPSExec; ProcPtr: pointer; const  Name: string; cc: TDelphiCallingConvention);
{
  SE is the Script executer.
  ProcPtr is a pointer to the proc to be called.
  Name is the name of that proc (uppercased).
  CC is the calling convention.

}

{See source}
{$IFDEF D4PLUS}
var
{$ELSE}
const
{$ENDIF}
  DelphiRPFunc: PResourcePtrSupportFuncs = nil;

//  This will be automaticly set when you use ifpiclassruntime.pas.


implementation

function p1(Caller: TIFPSExec; p: PIFProcRec; Global, Stack: TIfList): Boolean;
var
  i: Integer;
  MyList: TIfList;
  n: PIFVariant;
  CurrStack: Cardinal;
  s: string;
begin
  s := P^.ExportDecl;
  if length(s) = 0 then begin Result := False; exit; end;
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
    result := InnerfuseCall(Caller, nil, p^.Ext1, TCallingconvention(p^.ext2), MyList, n, DelphiRPFunc);
  except
    result := false;
  end;
  MyList.Free;
end;

procedure RegisterDelphiFunctionR(Se: TIFPSExec; ProcPtr: pointer; const  Name: string; cc: TDelphiCallingConvention);
begin
  Se.RegisterFunctionName(Name, p1, ProcPtr, Pointer(cc));
end;

end.
