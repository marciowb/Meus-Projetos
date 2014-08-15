{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         Command-line Unit - ECmdLine           }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ECmdLine;

{$I Exceptions.inc}

interface

function Execute: Integer;

implementation

uses
  SysUtils,
  Windows,
  EBaseModule,
  ECore,
  EConsts,
  Classes;

const
  EL_OPT_CFG = '--el_config';
  EL_OPT_EXE = '--el_alter_exe';

procedure WriteLine(Msg: AnsiString);
var
  Dummy: DWord;
begin
  msg := (Msg + #13#10);
  WriteFile(GetStdHandle(STD_OUTPUT_HANDLE), Msg[1], Length(Msg), Dummy, nil);
end;

procedure ErrorFmt(const Msg: AnsiString; const Args: array of const);
begin
  WriteLine(Format(Msg, Args));
  Halt(1);
end;

function ExecWait(const Prog, Params: AnsiString): Integer;
var
  ProcInfo: TProcessInformation;
  hProcess: THandle;
  StartInfo: _STARTUPINFOA;
  Cmd: AnsiString;
begin
  Result := 1;
  if (not FileExists(Prog)) then
    ErrorFmt('File not found: "%s"', [Prog]);
  Cmd := Prog + ' ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), 0);
  if not CreateProcessA(nil, PAnsiChar(Cmd), nil, nil, False,
    CREATE_DEFAULT_ERROR_MODE + NORMAL_PRIORITY_CLASS, nil, nil,
    StartInfo, ProcInfo) then
    ErrorFmt('Cannot execute the "%s" command.', [Cmd]);
  hProcess := ProcInfo.hProcess; // Save the process handle.

  //Close the thread handle as soon as it is no longer needed.
  CloseHandle(ProcInfo.hThread);
  WaitForSingleObject(hProcess, INFINITE);
  GetExitCodeProcess(hProcess, DWord(Result));
  CloseHandle(hProcess);
end;

function ProjectExists(ProjectName: AnsiString): Boolean;
begin
  ProjectName := Trim(ProjectName);
  Result := FileExists(ProjectName);
  if not Result then
  begin
    if (ProjectName <> '') and (ProjectName[length(ProjectName)] <> '.') then
      Result := FileExists(ProjectName + CurrentPersonality.GetOptionValue(otCmdLineProjectExt, ''));
  end;
end;

function ExpandProjectName(ProjectName: AnsiString): AnsiString;
begin
  ProjectName := Trim(ProjectName);
  if (not FileExists(ProjectName)) then
    ProjectName := (ProjectName + CurrentPersonality.GetOptionValue(otCmdLineProjectExt, ''));
  Result := ExpandFileName(ProjectName);
  if (not FileExists(Result)) then Result := '';
end;

function Execute: Integer;
var
  Params, Project, S, Compiler: AnsiString;
  I, Idx: Integer;
  ParamsList: TStringList;
  OnlyAlterEXE: Boolean;
{$IFNDEF CBuilder}
  AppDir, CurrDelphiVer: AnsiString;
{$ELSE}
  NextIsProject: Boolean;
{$ENDIF}

  function FindCompiler(Cmp: AnsiString): AnsiString;
  var
    ExtCmp: AnsiString;
  begin
    ExtCmp := ExtractFilePath(ParamStr(0)) + Cmp;
    if (FileExists(ExtCmp)) then Result := ExtCmp
    else
      Result := RADDir + '\Bin\' + Cmp;
  end;

{$IFDEF CBuilder}
  procedure SetCBuilderProject(const S: AnsiString);
  var
    Bpr, {$IFDEF Delphi9Down} Bpk, {$ENDIF} PName: AnsiString;
  begin
    if (not ProjectExists(S)) then Exit;

    PName := GetCppFileOptionValue(ExpandProjectName(S), 'MAINSOURCE');
    if (PName = '') then PName := ChangeFileExt(S, '.cpp');
        
    if (ExtractFilePath(PName) = '') and (ExtractFilePath(S) <> '') then
      PName := ExtractFilePath(S) + PName;
    if (PName <> '') then
    begin
{$IFDEF Delphi10Up}
  {$IFDEF Delphi11Up}
      Bpr := ExpandProjectName(ChangeFileExt(PName, '.cbproj'));
  {$ELSE}
      Bpr := ExpandProjectName(ChangeFileExt(PName, '.bdsproj'));
  {$ENDIF}
      if (Bpr <> '') then Project := Bpr;
{$ELSE}
      Bpr := ExpandProjectName(ChangeFileExt(PName, '.bpr'));
      Bpk := ExpandProjectName(ChangeFileExt(PName, '.bpk'));
      if ((Bpr <> '') and (Bpk <> '')) then
        ErrorFmt('Duplicate file: "%s" - "%s"', [Bpr, Bpk])
      else
      begin
        if (Bpr <> '') then Project := Bpr
        else
          if (Bpk <> '') then Project := Bpk;
      end;
{$ENDIF}
    end;
  end;
{$ENDIF}

  function IsEurekaLog6Up(const FileName: AnsiString): Boolean;
  var
    Size: DWord;
    Data: Pointer;
    HModule: THandle;

    function GetResourceData(Module: THandle; ResName,
      ResType: PAnsiChar; var Size: DWord): Pointer;
    var
      InfoBlock: HRSRC;
      GlobalMemoryBlock: HGLOBAL;
    begin
      Result := nil;
      InfoBlock := FindResourceA(Module, ResName, ResType);
      if (InfoBlock <> 0) then
      begin
        Size := SizeofResource(Module, InfoBlock);
        GlobalMemoryBlock := LoadResource(Module, InfoBlock);
        if (GlobalMemoryBlock <> 0) then Result := LockResource(GlobalMemoryBlock);
      end;
    end;

  begin
    Result := False;
    HModule := LoadLibraryExA(PAnsiChar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);
    if (HModule = 0) then Exit;

    try
      Data := GetResourceData(HModule, 'ELDATA', RT_RCDATA, Size);
      Result := (Data <> nil);
    finally
      FreeLibrary(HModule);
    end;
  end;


begin
  Result := 1;
  OnlyAlterEXE := False;
{$IFNDEF CBuilder}
  // Current Delphi version...
  CurrDelphiVer := Copy(Real_RADVersionString, 1, Length(Real_RADVersionString) - 2);

  // EurekaLog installed dir + other search dirs...
  AppDir := (ReadKey(HKEY_CURRENT_USER, 'Software\EurekaLog', 'AppDir') +
    '\Delphi' + CurrDelphiVer);

  Params := '"-U' + AppDir + '" -GD -$D+'; // (Map File = Detailed) + (Debug Info)

  Compiler := FindCompiler('dcc32.exe');
{$ELSE}
  Params := '';
  Compiler := FindCompiler('make.exe');
  NextIsProject := False;
{$ENDIF}

  Project := '';
  ParamsList := TStringList.Create;
  try
    for I := 1 to ParamCount do
    begin
      if (Copy(LowerCase(ParamStr(I)), 1, Length(EL_OPT_EXE)) = EL_OPT_EXE) then
      begin
        OnlyAlterEXE := True;
        Project := Copy(ParamStr(I), Length(EL_OPT_EXE) + 1, Length(ParamStr(I)));
        Idx := Pos(';', Project);
        if (Idx > 0) then
        begin
          MasterCompiledFile := Copy(Project, Idx + 1, MaxInt);
          if (not FileExists(MasterCompiledFile)) then
            ErrorFmt('Compiled file "%s" not found.', [MasterCompiledFile]);
          
          Project := Copy(Project, 1, Idx - 1);
        end;
{$IFDEF CBuilder}
        Project := ExpandProjectName(Project);
        SetCBuilderProject(Project);
{$ENDIF}
        if (not FileExists(Project)) then
          ErrorFmt('Project file "%s" not found.', [Project]);
      end
      else
        if (Copy(LowerCase(ParamStr(I)), 1, Length(EL_OPT_CFG)) <> EL_OPT_CFG) then
          ParamsList.Add(ParamStr(I))
        else
        begin
          MasterOptionsFile :=
            Copy(ParamStr(I), Length(EL_OPT_CFG) + 1, Length(ParamStr(I)));
          if (not FileExists(MasterOptionsFile)) then
            ErrorFmt('Options file "%s" not found.', [MasterOptionsFile]);
        end;
    end;

    if (Project = '') then
      for I := 0 to (ParamsList.Count - 1) do
      begin
{$IFNDEF CBuilder}
        if ((not (AnsiString(ParamsList[I])[1] in ['/', '-'])) and
          ProjectExists(ParamsList[I])) then
          Project := ExpandProjectName(ParamsList[I]);
{$ELSE}
        if (Copy(ParamsList[I], 1, 2) = '-f') then
        begin
          S := Trim(Copy(ParamsList[I], 3, Length(ParamsList[I])));
          if (S = '') then NextIsProject := True
          else SetCBuilderProject(S);
        end
        else
          if (NextIsProject) then
          begin
            NextIsProject := False;
            SetCBuilderProject(ParamsList[I]);
          end;
{$ENDIF}
        S := ParamsList[I];
        if (Pos(' ', S) > 0) and (Pos('"', S) <> 1) then S := '"' + S + '"';
        Params := (Params + ' ' + S);
      end;

  finally
    ParamsList.Free;
  end;

  if (Project = '') or (not FileExists(Project)) then
    ErrorFmt('Project file: "%s" not found!', [Project])
  else
  begin
    if (not OnlyAlterEXE) then
    begin
{$IFDEF Delphi11}
  {$IFDEF CBuilder}
      ErrorFmt('From "C++Builder 2007" this tool can be used only ' +
        'with the ''' + EL_OPT_EXE + ''' option!' + #13#10 +
        'Instead use the MSBuild tool.', []);
  {$ENDIF}
{$ENDIF}
      WriteLine('EurekaLog Command-Line Compiler v. ' + EurekaLogVersion + ' for ' +
{$IFNDEF CBuilder}
        'Delphi '
{$ELSE}
        'C++Builder '
{$ENDIF}
        + Real_RADVersionString + #13#10 + '-------------------------------');
      WriteLine('Loading EurekaLog options...');
      ModuleOptions.AddModule(TBaseModule, Project, ltLoadModuleOptions);
      WriteLine('EurekaLog preprocessor start...');
      ModuleOptions.CurrentModule.BeforeCompile;
      WriteLine('Compiling...');
      ExitCode := ExecWait(Compiler, Params);
      if (ExitCode = 0) then
      begin
        WriteLine('EurekaLog postprocessor start...');
        ModuleOptions.CurrentModule.AfterCompile;
        if (ModuleOptions.CurrentModule.ActivateLog) then WriteLine('EurekaLog data added.')
        else WriteLine('The current project has EurekaLog disabled!');
        WriteLine('EurekaLog postprocessor end.');
      end
      else
        WriteLine('ERROR - Exit Code: ' + IntToStr(ExitCode));
      Result := ExitCode;
    end
    else
    begin
      EBaseModule.Compiled := True;
      WriteLine('Loading EurekaLog options...');
      ModuleOptions.AddModule(TBaseModule, Project, ltLoadModuleOptions);
      if (IsEurekaLog6Up(ModuleOptions.CurrentModule.CompiledFile)) then
      begin
        WriteLine('EurekaLog data is already present.');
        Result := 0;
        Exit;
      end;

      if (not FileExists(ModuleOptions.CurrentModule.CompiledFile)) then
        ErrorFmt('Compiled file ''%s'' not found.',
          [ModuleOptions.CurrentModule.CompiledFile]);
      if (not FileExists(ModuleOptions.CurrentModule.MapFile)) then
        ErrorFmt('Map file ''%s'' not found.',
          [ModuleOptions.CurrentModule.MapFile]);
      WriteLine('EurekaLog postprocessor start...');
      ModuleOptions.CurrentModule.AfterCompile;
      if (ModuleOptions.CurrentModule.ActivateLog) then WriteLine('EurekaLog data added.')
      else WriteLine('The current project has EurekaLog disabled!');
      WriteLine('EurekaLog postprocessor end.');
      Result := 0;
    end;
  end;
end;

end.

