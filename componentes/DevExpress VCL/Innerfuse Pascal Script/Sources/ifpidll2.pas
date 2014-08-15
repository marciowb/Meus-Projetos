{Dll library (compiler)}
unit ifpidll2;

{$I ifps3_def.inc}
interface
{

  Function FindWindow(c1, c2: PChar): Cardinal; external 'FindWindow@user32.dll stdcall';

}
uses
  ifps3common, ifpscomp, ifps3utl;

{Assign this to the TIFPSCompiler.OnExternal event} 
function DllExternalProc(Sender: TIFPSPascalCompiler; const Name, Decl, FExternal: string): TIFPSRegProc;
type
  {Used to store the possible calling conventions}
  TDllCallingConvention = (clRegister, clPascal, ClCdecl, ClStdCall);

var
{The default CC}
  DefaultCC: TDllCallingConvention;
implementation

function DllExternalProc(Sender: TIFPSPascalCompiler; const Name, Decl, FExternal: string): TIFPSRegProc;
var
  FuncName,
  FuncCC,
  s: string;
  CC: TDllCallingConvention;

begin
  FuncCC := FExternal;
  if (pos('@', FuncCC) = 0) then
  begin
    Sender.MakeError('', ecCustomError, 'Invalid External');
    Result := nil;
    exit;
  end;
  FuncName := copy(FuncCC, 1, pos('@', FuncCC)-1)+#0;
  delete(FuncCc, 1, length(FuncName));
  if pos(' ', Funccc) <> 0 then
  begin
    FuncName := copy(FuncCc, 1, pos(' ',FuncCC)-1)+#0+FuncName;
    Delete(FuncCC, 1, pos(' ', FuncCC));
    FuncCC := FastUpperCase(FuncCC);
    if FuncCC = 'STDCALL' then cc := ClStdCall else
    if FuncCC = 'CDECL' then cc := ClCdecl else
    if FuncCC = 'REGISTER' then cc := clRegister else
    if FuncCC = 'PASCAL' then cc := clPascal else
    begin
      Sender.MakeError('', ecCustomError, 'Invalid Calling Convention');
      Result := nil;
      exit;
    end;
  end else
  begin
    FuncName := FuncCC+#0+FuncName;
    FuncCC := '';
    cc := DefaultCC;
  end;
  FuncName := 'dll:'+FuncName+char(cc);
  s := Decl;
  if GRFW(s) = '-1' then
  begin
    FuncName := FuncName + #0;
  end else
    FuncName := FuncName + #1;
  while length(s) > 0 do
  begin
    FuncCC := grfw(s);
    if funcCC[1] = '!' then
      FuncName := FuncName + #1
    else
      FuncName := FuncName + #0;
    grfw(s);
  end;
  Result := TIFPSRegProc.Create;
  Result.ImportDecl := FuncName;
  Result.Decl := Decl;
  Result.Name := Name;
  Result.ExportName := False;
end;

begin
  DefaultCc := clRegister;
end.

