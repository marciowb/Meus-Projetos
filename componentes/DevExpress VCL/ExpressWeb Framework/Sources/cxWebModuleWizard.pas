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
unit cxWebModuleWizard;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, HTTPApp, ToolsAPI,
  cxWebModule, cxWebWizardUtils;

type

TcxWebPageModuleWizard = class(TcxWebCustomModuleWizard, IOTAFormWizard)
public
  function GetName: string; override;
  function GetIDString: string; override;
  function GetComment: string; override;
  function GetGlyph: Cardinal; override;
  procedure Execute; override;
end;

TcxWebDataModuleWizard = class(TcxWebCustomModuleWizard, IOTAFormWizard)
public
  function GetName: string; override;
  function GetIDString: string; override;
  function GetComment: string; override;
  function GetGlyph: Cardinal; override;
  procedure Execute; override;
end;

TcxWebDataModuleCreator = class(TcxWebModuleCreator)
protected
  function HasHTML: Boolean; override;
end;

TcxWebPageModuleCreator = class(TcxWebModuleCreator)
protected
  function GetProperties: string; override;
end;

procedure Register;

implementation

uses TypInfo,
  {$IFDEF VCL}
  Windows,
  {$ELSE}
  Qt, QGraphics,
  {$ENDIF}
  cxfmWebModuleWizard, cxfmWebDataModuleWizard, cxWebStrs, cxWebDsgnConsts,
  cxWebDsgnUtils;

{TcxWebDataModuleCreator}
function TcxWebDataModuleCreator.HasHTML: Boolean;
begin
  Result := False;
end;

{TcxWebPageModuleCreator}
function TcxWebPageModuleCreator.GetProperties: string;
begin
  Result := Format(' DesignerId = %d ServerScript = %d ', [CreationData.DesignerID, CreationData.ScriptEngine]);
end;


{ TcxWebPageModuleWizard }

procedure TcxWebPageModuleWizard.Execute;
var
  AModuleWizardData: TcxWebModuleWizardData;
  AModuleServices: IOTAModuleServices;
begin
  with AModuleWizardData do
  begin
    ModuleType := wmtPage;
    CacheMode := caDestroy;
    CreateMode := crOnDemand;
    IsPublished := True;
    ScriptEngine := 0;
  end;
  if ShowcxWebNewModuleWizard(@AModuleWizardData) and
    Supports(BorlandIDEServices, IOTAModuleServices, AModuleServices) then
    AModuleServices.CreateModule(TcxWebPageModuleCreator.Create(@AModuleWizardData));
end;

function TcxWebPageModuleWizard.GetName: string;
begin
  Result := scxWebPageModuleWizardName;
end;

function TcxWebPageModuleWizard.GetIDString: string;
begin
  Result := scxWebPageModuleWizardID;
end;

function TcxWebPageModuleWizard.GetComment: string;
begin
  Result := scxWebPageModuleWizardComment;
end;

function TcxWebPageModuleWizard.GetGlyph: Cardinal;
begin
  Result :=
  {$IFDEF VCL}
    LoadIcon(hInstance, scxWebPageModuleWizardIconName);
  {$ELSE}
    GetIconResourceID(scxWebPageModuleWizardIconName);
  {$ENDIF}
end;

{ TcxWebDataModuleWizard }

procedure TcxWebDataModuleWizard.Execute;
var
  AModuleWizardData: TcxWebModuleWizardData;
begin
  with AModuleWizardData do
  begin
    ModuleType := wmtData;
    CacheMode := caDestroy;
    CreateMode := crOnDemand;
    IsPublished := True;
  end;
  if ShowcxWebNewDataModuleWizard(@AModuleWizardData) then
  begin
    (BorlandIDEServices as IOTAModuleServices).CreateModule(TcxWebDataModuleCreator.Create(@AModuleWizardData));
  end;
end;

function TcxWebDataModuleWizard.GetName: string;
begin
  Result := scxWebDataModuleWizardName;
end;

function TcxWebDataModuleWizard.GetIDString: string;
begin
  Result := scxWebDataModuleWizardID;
end;

function TcxWebDataModuleWizard.GetComment: string;
begin
  Result := scxWebDataModuleWizardComment;
end;

function TcxWebDataModuleWizard.GetGlyph: Cardinal;
begin
  Result :=
  {$IFDEF VCL}
    LoadIcon(hInstance, scxWebDataModuleWizardIconName);
  {$ELSE}
    GetIconResourceID(scxWebDataModuleWizardIconName);
  {$ENDIF}
end;

procedure Register;
begin
  RegisterPackageWizard(TcxWebDataModuleWizard.Create);
  RegisterPackageWizard(TcxWebPageModuleWizard.Create);
end;

end.

