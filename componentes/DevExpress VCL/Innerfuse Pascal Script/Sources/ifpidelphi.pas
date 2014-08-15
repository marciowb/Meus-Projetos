{Delphi function importer (compiletime)}
unit ifpidelphi;
{
  Innerfuse Pascal Script Call unit
  You may not copy a part of this unit, only use it as whole, with
  Innerfuse Pascal Script Script Engine.
}
{$I ifps3_def.inc}
interface
uses
  ifps3utl, ifps3common, ifpscomp;


{ Register a normal Delphi function at runtime. Decl should be the exact declaration of the
  function. But since the const keyword is not support yet, you should leave that out.}
function RegisterDelphiFunctionC(SE: TIFPSPascalCompiler; const Decl: string): Boolean;
function RegisterDelphiFunctionC2(SE: TIFPSPascalCompiler; const Decl: string): TIFPSRegProc;

type
  TFuncType = (ftProc, ftConstructor);

function ParseMethod(Owner: TIFPSPascalCompiler; const FClassName: string; const Decl: string; var DName, DStr: string; var Func: TFuncType): Boolean;

implementation

type
  TComp = class(TIFPSPascalCompiler);

function ParseMethod(Owner: TIFPSPascalCompiler; const FClassName: string; const Decl: string; var DName, DStr: string; var Func: TFuncType): Boolean;
var
  Parser: TIfPascalParser;
  tt: PIFPSType;
  FuncType: Byte;
  VNames, Name, NDecl: string;
  modifier: Char;
  VCType: Cardinal;

  function FindAdd(const Name, Decl: string): Cardinal;
  begin
    Result := Owner.FindType(Name);
    if Result = Cardinal(-1) then
    begin
      tt := Owner.AddTypeS(Name, Decl);
      tt.ExportName := True;
      Result := TComp(Owner).FAvailableTypes.Count -1;
    end;
  end;

begin
  Parser := TIfPascalParser.Create;
  Parser.SetText(Decl);
  if Parser.CurrTokenId = CSTII_Function then
    FuncType:= 0
  else if Parser.CurrTokenId = CSTII_Procedure then
    FuncType := 1
  else if (Parser.CurrTokenId = CSTII_Constructor) and (FClassName <> '') then
    FuncType := 2
  else
  begin
    Parser.Free;
    Result := False;
    exit;
  end;
  NDecl := '';
  Parser.Next;
  if Parser.CurrTokenId <> CSTI_Identifier then
  begin
    Parser.Free;
    Result := False;
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
          modifier := '@';
          Parser.Next;
        end
        else
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
          Result := False;
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
            Result := False;
            exit;
          end;
          VNames := VNames + Parser.GetToken + '|';
          Parser.Next;
        end;
        if Parser.CurrTokenId <> CSTI_Colon then
        begin
          Parser.Free;
          Result := False;
          exit;
        end;
        Parser.Next;
        if Parser.CurrTokenID = CSTII_Array then
        begin
          Parser.nExt;
          if Parser.CurrTokenId <> CSTII_Of then
          begin
            Parser.Free;
            Result := False;
            exit;
          end;
          Parser.Next;
          if Parser.CurrTokenId = CSTII_Const then
            VCType := FindAdd('!OPENARRAYOFCONST', 'array of variant')
          else begin
            VCType := Owner.FindType(Parser.GetToken);
            if VCType = Cardinal(-1) then
            begin
              Parser.Free;
              Result := False;
              exit;
            end;
            case TComp(Owner).GetAvailableType(VCType).BaseType of
              btU8: VCType := FindAdd('!OPENARRAYOFU8', 'array of byte');
              btS8: VCType := FindAdd('!OPENARRAYOFS8', 'array of ShortInt');
              btU16: VCType := FindAdd('!OPENARRAYOFU16', 'array of SmallInt');
              btS16: VCType := FindAdd('!OPENARRAYOFS16', 'array of Word');
              btU32: VCType := FindAdd('!OPENARRAYOFU32', 'array of Cardinal');
              btS32: VCType := FindAdd('!OPENARRAYOFS32', 'array of Longint');
              btSingle: VCType := FindAdd('!OPENARRAYOFSINGLE', 'array of Single');
              btDouble: VCType := FindAdd('!OPENARRAYOFDOUBLE', 'array of Double');
              btExtended: VCType := FindAdd('!OPENARRAYOFEXTENDED', 'array of Extended');
              btString: VCType := FindAdd('!OPENARRAYOFSTRING', 'array of String');
              btPChar: VCType := FindAdd('!OPENARRAYOFPCHAR', 'array of PChar');
              btVariant: VCType := FindAdd('!OPENARRAYOFVARIANT', 'array of variant');
            {$IFNDEF NOINT64}btS64:  VCType := FindAdd('!OPENARRAYOFS64', 'array of Int64');{$ENDIF}
              btChar: VCType := FindAdd('!OPENARRAYOFCHAR', 'array of Char');
            {$IFNDEF NOWIDESTRING}
              btWideString: VCType := FindAdd('!OPENARRAYOFWIDESTRING', 'array of WideString');
              btWideChar: VCType := FindAdd('!OPENARRAYOFWIDECHAR', 'array of WideChar');
            {$ENDIF}
            else
              begin
                Parser.Free;
                Result := False;
                exit;
              end;
            end;
          end;
        end else begin
          VCType := Owner.FindType(Parser.GetToken);
          if VCType = Cardinal(-1) then
          begin
            Parser.Free;
            Result := False;
            exit;
          end;
        end;
        while Pos('|', VNames) > 0 do
        begin
          NDecl := NDecl + ' ' + modifier + copy(VNames, 1, Pos('|', VNames) - 1)
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
          Result := False;
          exit;
        end;
        Parser.Next;
      end; {while}
    end; {if}
    Parser.Next;
  end; {if}
  if FuncType = 0 then
  begin
    if Parser.CurrTokenId <> CSTI_Colon then
    begin
      Parser.Free;
      Result := False;
      exit;
    end;

    Parser.Next;
    VCType := Owner.FindType(Parser.GetToken);
    if VCType = Cardinal(-1) then
    begin
      Parser.Free;
      Result := False;
      exit;
    end;
  end
  else if FuncType = 2 then {constructor}
  begin
    VCType := Owner.FindType(FClassName)
  end else
    VCType := Cardinal(-1);
  NDecl := inttostr(VCType) + NDecl;
  Parser.Free;
  DName := Name;
  DStr := NDecl;
  if FuncType = 2 then
    Func := ftConstructor
  else
    Func := ftProc;
  Result := True;
end;                         

function RegisterDelphiFunctionC(SE: TIFPSPascalCompiler; const Decl: string): Boolean;
begin
  Result := RegisterDelphiFunctionC2(SE, Decl) <> nil;
end;

function RegisterDelphiFunctionC2(SE: TIFPSPascalCompiler; const Decl: string): TIFPSRegProc;
var
  p: TIFPSRegProc;
  DName, s: string;
  FT: TFuncType;

begin
  if not ParseMethod(SE, '', Decl, DName, s, FT) then begin Result := nil; exit; end;

  p := TIFPSRegProc.Create;
  P.Name := DName;
  p.ExportName := True;
  p.Decl := s;

  TComp(SE).FRegProcs.Add(p);

  if GRFW(s) = '-1' then
  begin
    p.ImportDecl := p.ImportDecl + #0;
  end else
    p.ImportDecl := p.ImportDecl + #1;
  while length(s) > 0 do
  begin
    if s[1] = '!' then
      p.ImportDecl := p.ImportDecl + #1
    else
      p.ImportDecl := p.ImportDecl + #0;
    grfw(s);
    grfw(s);
  end;
  p.ExportName := True;
  Result := p;
end;

end.

