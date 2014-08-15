program ScriptRunner;

uses
  Forms,
  Dialogs,
  SysUtils,
  atScript,
  atPascal,
  {$IFNDEF VER130}
  Variants,
  {$ENDIF}
  uScriptLib in '..\ide\uScriptLib.pas';

{$R *.res}

var
  AFile: string;
  ARoutine: string;
  AScr: TatPascalScripter;
  AResult: Variant;

{$IFDEF VER130}
function AnsiDequotedStr(S: string; Quote: Char): string;
var
  TempS: PChar;
begin
  TempS := PChar(S);
  result := AnsiExtractQuotedStr(TempS, Quote);
end;
{$ENDIF}

begin
  Application.Initialize;

  AScr := TatPascalScripter.Create(Application);
  try
    try
      AResult := 0;
      AddScripterLibraries(AScr);
      if ParamCount >= 1 then
      begin
        AFile := ParamStr(1);
        AFile := AnsiDequotedStr(AFile, '"');
        if FileExists(AFile) then
        begin
          AScr.SourceCode.LoadFromFile(AFile);
          AScr.Compile;
          if ParamCount >= 2 then
            ARoutine := ParamStr(2)
          else
            ARoutine := '';
          ARoutine := AnsiDequotedstr(ARoutine, '"');
          if ARoutine = '' then
            AResult := AScr.Execute
          else
            AResult := AScr.ExecuteSubRoutine(ARoutine);
        end else
          ShowMessage('Script file not found.');
      end else
      begin
        ShowMessage('No script specified on the command line.');
      end;
      if not VarIsEmpty(AResult) and not VarIsNull(AResult)
        {$IFNDEF VER130}
        and not VarIsClear(AResult)
        {$ENDIF}
        and
        (VarType(AResult) = varInteger) and (AResult <> 0) then
        Application.Run;
    except
      Application.ShowException(nil);
    end;
  finally
    AScr.Free;
  end;
end.
