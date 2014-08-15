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
unit cxWebDsgnModule;

{$I cxVer.inc}

interface

uses
  {$IFDEF VCL}
  Controls, Forms, Windows, Graphics, ShellAPI, VCLEditors,
  {$ELSE}
  QControls, QForms, Qt, QGraphics, CLXEditors,
  {$ENDIF}
  Classes, DesignIntf, DesignEditors;

type
  TcxCustomWebPageModuleDesigner = class(TCustomModule, ICustomDesignForm
  {$IFDEF DELPHI9}, ICustomDesignForm80{$ENDIF})
  public
    { ICustomDesignForm }
    procedure CreateDesignerForm(const Designer: IDesigner; Root: TComponent;
      out DesignForm: TCustomForm; out ComponentContainer: TWinControl); {$IFDEF DELPHI9} overload; {$ENDIF}
    {$IFDEF DELPHI9}
    { ICustomDesignForm80 }
    procedure CreateDesignerForm(const Designer: IDesigner; Root: TComponent;
      out DesignForm: IHostForm; out ComponentContainer: TWinControl); overload;
    {$ENDIF}

    procedure ExecuteVerb(Index: Integer); override;
    function GetAttributes: TCustomModuleAttributes; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    class function DesignClass: TComponentClass; override;
    function ValidateComponentClass(ComponentClass: TComponentClass): Boolean; override;
  end;

implementation

uses SysUtils, cxWebModule, cxWebDsgnConsts, cxfmWebDsgn;

function TcxCustomWebPageModuleDesigner.GetAttributes: TCustomModuleAttributes;
begin
  Result := [cmaVirtualSize];
end;

procedure TcxCustomWebPageModuleDesigner.ExecuteVerb(Index: Integer);
begin
  {$IFDEF VCL}
  ShellExecute(0, nil, PChar(scxCompanyWebPage), nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

function TcxCustomWebPageModuleDesigner.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := cxGetProductText;
    1: Result := scxCompanyWebPage;
    2: Result := scxCompanyName;
  else  
    Result := '-';    
  end;
end;

function TcxCustomWebPageModuleDesigner.GetVerbCount: Integer;
begin
  Result := 4;
end;

class function TcxCustomWebPageModuleDesigner.DesignClass: TComponentClass;
begin
  Result := TcxCustomWebPageModule;
end;

function TcxCustomWebPageModuleDesigner.ValidateComponentClass(ComponentClass: TComponentClass): Boolean;
begin
  Result := inherited ValidateComponentClass(ComponentClass) and
    not ComponentClass.InheritsFrom(TControl);
end;

{ ICustomDesignForm }
procedure TcxCustomWebPageModuleDesigner.CreateDesignerForm(const Designer: IDesigner;
  Root: TComponent; out DesignForm: TCustomForm; out ComponentContainer: TWinControl);
begin
  DesignForm := TcxWebModuleDesignWindow.CreateEx(nil, Designer, ComponentContainer);
end;

{$IFDEF DELPHI9}
{ ICustomDesignForm80 }
procedure TcxCustomWebPageModuleDesigner.CreateDesignerForm(const Designer: IDesigner; Root: TComponent;
  out DesignForm: IHostForm; out ComponentContainer: TWinControl);
begin
{  if Assigned(CreateDesignerFormProc) then
    CreateDesignerFormProc(Self, Designer, Root, DesignForm, ComponentContainer)
  else
}
  begin
    DesignForm := nil;
    ComponentContainer := nil;
  end;
end;
{$ENDIF}


end.
