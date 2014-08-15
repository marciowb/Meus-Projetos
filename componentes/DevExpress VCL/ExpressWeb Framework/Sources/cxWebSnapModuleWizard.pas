{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Snap Support                                            }
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
unit cxWebSnapModuleWizard;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils, HTTPApp, ToolsAPI,
  cxWebSnapModule, cxWebWizardUtils, cxWebModuleWizard;

type

TcxWebSnapPageModuleWizard = class(TcxWebCustomModuleWizard, IOTAFormWizard)
public
  function GetName: string; override;
  function GetIDString: string; override;
  function GetComment: string; override;
  function GetGlyph: Cardinal; override;
  procedure Execute; override;
end;

procedure Register;

implementation

uses TypInfo,
  {$IFDEF VCL}
  Windows,
  {$ELSE}
  Qt,
  {$ENDIF}
  cxfmWebModuleWizard, cxWebSnapDsgnConsts, cxWebDsgnUtils;

type

TcxWebSnapModuleCreator = class(TcxWebPageModuleCreator)
protected
  function GetSourceFactoryString: string; override;
  function GetAncestorName: string; override;
  function GetInterfaceUses: string; override;
  function GetImplementUses: string; override;
end;

{ TcxWebSnapModuleCreator }
function TcxWebSnapModuleCreator.GetSourceFactoryString: string;

  function GetPageInfoParamsAsText: string;
  begin
    with CreationData^ do
      Result := 'crOnDemand, ' + GetEnumName(TypeInfo(TWebModuleCacheMode), Integer(CacheMode));
  end;

var
  APageInfoSt: string;
begin
  APageInfoSt := 'TWebPageInfo.Create([';
  with CreationData^ do
  begin
     if IsPublished then
       APageInfoSt := APageInfoSt + 'wpPublished';
     APageInfoSt := APageInfoSt + '],';
     APageInfoSt := APageInfoSt + '''.html'''
  end;
  APageInfoSt := APageInfoSt + ')';
  Result := Format('TWebPageModuleFactory.Create(T%s, %s, %s)',
        [ModuleClassName,  APageInfoSt, GetPageInfoParamsAsText]);
end;

function TcxWebSnapModuleCreator.GetAncestorName: string;
begin
  Result := TcxWebSnapPageModule.ClassName;
end;

function TcxWebSnapModuleCreator.GetImplementUses: string;
begin
  Result := 'WebReq, WebCntxt, WebFact, Variants;';
end;

function TcxWebSnapModuleCreator.GetInterfaceUses: string;
begin
  Result := 'SysUtils, Classes, HTTPApp, cxWebSnapModule;';
end;

{ TcxWebPageModuleWizard }

procedure TcxWebSnapPageModuleWizard.Execute;
var
  AModuleWizardData: TcxWebModuleWizardData;
begin
  with AModuleWizardData do
  begin
    ModuleType := wmtPage;
    CacheMode := caDestroy;
    CreateMode := crOnDemand;
    IsPublished := True;
  end;
  if ShowcxWebNewModuleWizard(@AModuleWizardData) then
  begin
    (BorlandIDEServices as IOTAModuleServices).CreateModule(TcxWebSnapModuleCreator.Create(@AModuleWizardData));
  end;
end;

function TcxWebSnapPageModuleWizard.GetName: string;
begin
  Result := scxWebSnapPageModuleWizardName;
end;

function TcxWebSnapPageModuleWizard.GetIDString: string;
begin
  Result := scxWebSnapPageModuleWizardID;
end;

function TcxWebSnapPageModuleWizard.GetComment: string;
begin
  Result := scxWebSnapPageModuleWizardComment;
end;

function TcxWebSnapPageModuleWizard.GetGlyph: Cardinal;
begin
  Result :=
  {$IFDEF VCL}
    LoadIcon(hInstance, scxWebSnapPageModuleWizardIconName);
  {$ELSE}
    GetIconResourceID(scxWebSnapPageModuleWizardIconName);
  {$ENDIF}
end;

procedure Register;
begin
  RegisterPackageWizard(TcxWebSnapPageModuleWizard.Create);
end;

end.

