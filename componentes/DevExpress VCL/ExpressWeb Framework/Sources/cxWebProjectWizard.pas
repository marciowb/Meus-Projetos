{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebProjectWizard;

interface

{$I cxVer.inc}

{$IFDEF VCL}
{$DEFINE WADAPP}
{$ENDIF}

{$IFDEF KYLIX3}
{$DEFINE WADAPP}
{$ENDIF}

uses
  Classes, SysUtils, HTTPApp, ToolsAPI,
  cxWebModule, cxWebWizardUtils;

type

TcxWebProjectModuleWizard = class(TcxWebCustomModuleWizard, IOTAProjectWizard)
public
  function GetName: string; override;
  function GetIDString: string; override;
  function GetComment: string; override;
  function GetGlyph: Cardinal; override;
  procedure Execute; override;
end;

function GetApplicationModuleTypeName(AType: TcxWebAppModuleType): String;
function GetApplicationModuleTypeClass(AType: TcxWebAppModuleType): TcxWebModuleCreatorClass;
function GetApplicationModuleType(AType: TcxWebAppModuleType): TcxWebModuleType;

procedure Register;

implementation

uses
  {$IFDEF VCL}
  Windows, Forms,
  {$ELSE}
  Qt, QForms,
  {$ENDIF}
  cxWebDsgnConsts, cxWebDsgnUtils, cxfmWebProjectWizard, cxWebModuleWizard,
  cxWebFramesetWizard;

procedure Register;
begin
  RegisterPackageWizard(TcxWebProjectModuleWizard.Create);
end;

function GetNewProjectPath: string;
const
  DelphiPath = 'Bin\Delphi32.exe';  //????
  ProjectPath = 'Bin';
begin
  Result := Application.ExeName;
  Result := Copy(Result, 1, Length(Result) - Length(DelphiPath)) + ProjectPath;
  if DirectoryExists(Result) then
    Result := Result + '\'
  else
  begin
    if Pos(':', Result) > 0 then
      Result := Copy(Result, 1, Pos(':', Result));
  end;  
end;

function GetNewProjectFileName: string;
var
  ModuleServices: IOTAModuleServices;
  Module:  IOTAModule;
  ProjectGroup: IOTAProjectGroup;
  Strings: TStrings;
  j: Integer;
begin
  ModuleServices := BorlandIDEServices as IOTAModuleServices;
  for j := 0 to ModuleServices.ModuleCount - 1 do
  begin
    Module := ModuleServices.Modules[j];
    if Module.QueryInterface(IOTAProjectGroup, ProjectGroup) = S_OK then
      Break;
  end;
  Result := '';
  j := 0;
  if ProjectGroup <> nil then
  begin
    Strings := TStringList.Create;
    try
      for j := 0 to ProjectGroup.ProjectCount - 1 do
        Strings.Add(UpperCase(ExtractFileName(ProjectGroup.Projects[j].FileName)));
      for j := 0 to ProjectGroup.ProjectCount - 1 do
        if Strings.IndexOf(Format('PROJECT%d.DPR', [j + 1])) = -1 then
          Break;
     finally
       Strings.Free;
     end;
  end;
  Inc(j);
  Result := Format('%sProject%d.dpr', [GetNewProjectPath, j]);
end;


type
TcxWebProjectCreator = class(TInterfacedObject, IOTACreator,
        IOTAProjectCreator, IOTAProjectCreator50)
private
  FCreationData: PcxWebApplicationWizardData;

  function GetProjectSource(AProjectName: String): String;
protected
  { IOTACreator }
  function GetCreatorType: string;
  function GetExisting: Boolean;
  function GetFileSystem: string;
  function GetOwner: IOTAModule;
  function GetUnnamed: Boolean;
  { IOTAProjectCreator }
  function GetFileName: string;
  function GetOptionFileName: string;
  function GetShowSource: Boolean;
  procedure NewDefaultModule;
  function NewOptionSource(const ProjectName: string): IOTAFile;
  procedure NewProjectResource(const Project: IOTAProject);
  function NewProjectSource(const ProjectName: string): IOTAFile;
  { IOTAProjectCreator50 }
  procedure NewDefaultProjectModule(const Project: IOTAProject);
public
  constructor Create(ACreationData: PcxWebApplicationWizardData);
end;

{ TcxWebProjectCreator }
constructor TcxWebProjectCreator.Create(ACreationData: PcxWebApplicationWizardData);
begin
  inherited Create;
  FCreationData := ACreationData;
end;

function TcxWebProjectCreator.GetProjectSource(AProjectName: String): String;
var
  AAplicationTypeSt: String;
  AProjectExportsSt: String;
begin
  Result := GetProgramType(FCreationData^.AppType)  + ' ' + AProjectName + ';' +  CRLF + CRLF;
  AAplicationTypeSt := GetApplicationType(FCreationData^.AppType);
  if AAplicationTypeSt <> '' then
    Result := Result + '{$APPTYPE ' + AAplicationTypeSt + '}' + CRLF;
  Result := Result + 'uses' + CRLF + GetProjectUsesUnits(FCreationData^.AppType) + CRLF + CRLF;
  Result := Result + '{$R *.res}' + CRLF + CRLF;
  AProjectExportsSt := GetProjectExports(FCreationData^.AppType, AProjectName);
  if AProjectExportsSt <> '' then
    Result := Result + 'exports' + CRLF + AProjectExportsSt + CRLF + CRLF;
  Result := Result + 'begin'  + CRLF;
  {$IFDEF VCL}
  if FCreationData^.AppType = wapISAPI then
  Result := Result + '  CoInitFlags := COINIT_MULTITHREADED;' + CRLF;
  {$ENDIF}
  Result := Result + '  Application.Initialize;'+ CRLF
        + GetProjectInitialization(FCreationData^.AppType)
        + '  Application.Run;'+ CRLF + 'end.';
end;

{ IOTACreator }
function TcxWebProjectCreator.GetCreatorType: string;
begin
  Result := GetAOTApplicationType(FCreationData^.AppType);
end;

function TcxWebProjectCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TcxWebProjectCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TcxWebProjectCreator.GetOwner: IOTAModule;
begin
  Result := GetCurrentProjectGroup;
end;

function TcxWebProjectCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

{ IOTAProjectCreator }
function TcxWebProjectCreator.GetFileName: string;
begin
  Result := GetNewProjectFileName;
end;

function TcxWebProjectCreator.GetOptionFileName: string;
begin
  Result := '';
end;

function TcxWebProjectCreator.GetShowSource: Boolean;
begin
  Result := False;
end;

procedure TcxWebProjectCreator.NewDefaultModule;
var
  AModuleWizardData: TcxWebModuleWizardData;
  AModuleClass: TcxWebModuleCreatorClass;
begin
  {$IFDEF WADAPP}
  if FCreationData^.AppType = wapDebug then
   (BorlandIDEServices as IOTAModuleServices).CreateModule(TcxWebDebugMainModuleCreator.Create(FCreationData^.ClassName));
  {$ENDIF}
  with AModuleWizardData do
  begin
    ModuleType := wmtHomeData;
    CacheMode :=  FCreationData^.CacheMode;
    IsPublished := FCreationData^.IsPublished;
    CreateMode := crAlways;
    DesignerID := FCreationData^.DesignerID;
    HTMLTemplate := FCreationData^.HTMLTemplate;
    ScriptEngine := FCreationData^.ScriptEngine;
  end;
  (BorlandIDEServices as IOTAModuleServices).CreateModule(TcxWebDataModuleCreator.Create(@AModuleWizardData));
  AModuleClass := GetApplicationModuleTypeClass(FCreationData^.AppModuleType);
  if AModuleClass <> nil then
  begin
    AModuleWizardData.ModuleType := GetApplicationModuleType(FCreationData^.AppModuleType);
    (BorlandIDEServices as IOTAModuleServices).CreateModule(AModuleClass.Create(@AModuleWizardData));
  end;
end;

function TcxWebProjectCreator.NewOptionSource(const ProjectName: string): IOTAFile;
begin
  Result := nil;
end;

procedure TcxWebProjectCreator.NewProjectResource(const Project: IOTAProject);
begin

end;

function TcxWebProjectCreator.NewProjectSource(const ProjectName: string): IOTAFile;
begin
  Result := TOTAFile.Create(GetProjectSource(ProjectName));
end;

{ IOTAProjectCreator50 }
procedure TcxWebProjectCreator.NewDefaultProjectModule(const Project: IOTAProject);
begin
end;

{ TcxWebProjectModuleWizard }
function TcxWebProjectModuleWizard.GetName: string;
begin
  Result := scxWebProjectWizardName;
end;

function TcxWebProjectModuleWizard.GetIDString: string;
begin
  Result := scxWebProjectWizardID;
end;

function TcxWebProjectModuleWizard.GetComment: string;
begin
  Result := scxWebProjectWizardComment;
end;

function TcxWebProjectModuleWizard.GetGlyph: Cardinal;
begin
  Result :=
  {$IFDEF VCL}
    LoadIcon(hInstance, scxWebProjectWizardIconName);
  {$ELSE}
    GetIconResourceID(scxWebProjectWizardIconName);
  {$ENDIF}
end;

procedure TcxWebProjectModuleWizard.Execute;
var
  ApplicationWizardData: PcxWebApplicationWizardData;
begin
  New(ApplicationWizardData);
  try
    with ApplicationWizardData^ do
    begin
      AppType := TcxWebAppType(0);
      AppModuleType := wamtPage;
      CacheMode := caDestroy;
      CreateMode := crOnDemand;
    end;
    if ShowcxWebNewProjectWizard(ApplicationWizardData) then
    begin
      if GetCurrentProjectGroup = nil then
        (BorlandIDEServices as IOTAModuleServices).CloseAll;
      (BorlandIDEServices as IOTAModuleServices).CreateModule(TcxWebProjectCreator.Create(ApplicationWizardData));
    end;
  finally
    Dispose(ApplicationWizardData);
  end;
end;

function GetApplicationModuleTypeName(AType: TcxWebAppModuleType): string;
const
  ASt: Array[TcxWebAppModuleType] of String =
   ('Do not create', 'Page module', 'Frameset module', 'Data module');
begin
  Result := ASt[AType];
end;

function GetApplicationModuleTypeClass(AType: TcxWebAppModuleType): TcxWebModuleCreatorClass;
const
  WebModules: Array[TcxWebAppModuleType] of TcxWebModuleCreatorClass
   =  (nil, TcxWebPageModuleCreator, TcxWebFramesetCreator, TcxWebDataModuleCreator);
begin
  Result := WebModules[AType];
end;

function GetApplicationModuleType(AType: TcxWebAppModuleType): TcxWebModuleType;
const
  WebModuleTypes: Array[TcxWebAppModuleType] of TcxWebModuleType
   =  (wmtPage, wmtPage, wmtFrameset, wmtData);
begin
  Result := WebModuleTypes[AType];
end;

end.
