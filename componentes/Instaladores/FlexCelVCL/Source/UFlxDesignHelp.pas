unit UFlxDesignHelp;
{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}

interface
{$IFNDEF FLX_FPC}
uses
{$IFDEF  VER130}
   Windows,
{$ENDIF}
  ToolsAPI;
{$ENDIF}
//------------------------------------------------------------//
  function GetActiveProjectFileName: string;
//------------------------------------------------------------//

implementation
{$IFNDEF FLX_FPC}
function FindModuleInterface(AInterface: TGUID): IUnknown;
var
  I: Integer;
begin
  Result := nil;
  with BorlandIDEServices as IOTAModuleServices do
    for I := 0 to ModuleCount - 1 do
      if (Modules[I].QueryInterface(AInterface, Result) = S_OK) then
        Break;
end;

function GetActiveProject: IOTAProject;
var
  ProjectGroup: IOTAProjectGroup;
begin
  ProjectGroup := FindModuleInterface(IOTAProjectGroup) as IOTAProjectGroup;
  if Assigned(ProjectGroup) then
    Result := ProjectGroup.ActiveProject
  else
    Result := FindModuleInterface(IOTAProject) as IOTAProject;
end;

function GetActiveProjectFileName: string;
var
  Project: IOTAProject;
begin
  Result := '';
  Project := GetActiveProject;
  if Assigned(Project) then
    Result := Project.FileName;
end;
{$ELSE}

function GetActiveProjectFileName: string;
begin
  Result := '';
end;
{$ENDIF}
end.
