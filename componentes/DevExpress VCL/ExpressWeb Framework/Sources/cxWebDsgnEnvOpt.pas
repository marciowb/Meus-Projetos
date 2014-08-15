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
unit cxWebDsgnEnvOpt;

{$I cxVer.inc}

interface

uses Classes, DesignIntf,
  {$IFDEF VCL}
  Graphics,
  {$ELSE}
  QGraphics,
  {$ENDIF}
  cxWebDsgnTypes;

type
  TcxWebDesignerEnvironmentOptions = class
  protected
  public
    class function GetGridColor: TColor;
    class function GetSurfaceColor: TColor;
    class function GetGridSizeX(DelphiDesigner: IDesigner): TcxDesignerGridSize;
    class function GetGridSizeY(DelphiDesigner: IDesigner): TcxDesignerGridSize;
    class function GetShowExtendedHints(DelphiDesigner: IDesigner): Boolean;
    class function GetShowGrid(DelphiDesigner: IDesigner): Boolean;
    class function GetShowHints(DelphiDesigner: IDesigner): Boolean;
    class function GetSnapControlsToGrid(DelphiDesigner: IDesigner): Boolean;
    class function GetDividerPos(DelphiDesigner: IDesigner): Integer;
    class procedure SetDividerPos(DelphiDesigner: IDesigner; const Value: Integer);
  end;

implementation

uses
  SysUtils, ToolsAPI,
  cxWebDsgnConsts;

{ TcxWebDesignerEnvironmentOptions }
class function TcxWebDesignerEnvironmentOptions.GetGridColor: TColor;
begin
  Result := clcxWebDesignerGridColor;
end;

class function TcxWebDesignerEnvironmentOptions.GetSurfaceColor: TColor;
begin
  Result := clcxWebDesignerSurfaceColor;
end;

class function TcxWebDesignerEnvironmentOptions.GetGridSizeX(DelphiDesigner: IDesigner): TcxDesignerGridSize;
begin
  Result := DelphiDesigner.GetIDEOptions.ReadInteger('Form Design', 'Grid Size X', 8);
end;

class function TcxWebDesignerEnvironmentOptions.GetGridSizeY(DelphiDesigner: IDesigner): TcxDesignerGridSize;
begin
  Result := DelphiDesigner.GetIDEOptions.ReadInteger('Form Design', 'Grid Size Y', 8);
end;

class function TcxWebDesignerEnvironmentOptions.GetShowExtendedHints(DelphiDesigner: IDesigner): Boolean;
var
  St: string;
begin
  St := DelphiDesigner.GetIDEOptions.ReadString('Form Design', 'Show Extended Control Hints', 'True');
  Result := SameText(St, 'True') or SameText(St, '-1');
end;

class function TcxWebDesignerEnvironmentOptions.GetShowGrid(DelphiDesigner: IDesigner): Boolean;
var
  St: string;
begin
  St := DelphiDesigner.GetIDEOptions.ReadString('Form Design', 'Display Grid', 'True');
  Result := SameText(St, 'True') or SameText(St, '-1');
end;

class function TcxWebDesignerEnvironmentOptions.GetShowHints(DelphiDesigner: IDesigner): Boolean;
var
  St: string;
begin
  St := DelphiDesigner.GetIDEOptions.ReadString('Form Design', 'Show Designer Hints', 'True');
  Result := SameText(St, 'True') or SameText(St, '-1');
end;

class function TcxWebDesignerEnvironmentOptions.GetSnapControlsToGrid(DelphiDesigner: IDesigner): Boolean;
var
  St: string;
begin
  St := DelphiDesigner.GetIDEOptions.ReadString('Form Design', 'Snap to Grid', 'True');
  Result := SameText(St, 'True') or SameText(St, '-1');
end;

const
  DividerPositionSt = 'Divider Position'; //do not localize

class function TcxWebDesignerEnvironmentOptions.GetDividerPos(DelphiDesigner: IDesigner): Integer;
begin
  Result := DelphiDesigner.GetIDEOptions.ReadInteger('Form Design', DividerPositionSt, 100);
end;

class procedure TcxWebDesignerEnvironmentOptions.SetDividerPos(DelphiDesigner: IDesigner; const Value: Integer);
begin
  DelphiDesigner.GetIDEOptions.WriteInteger('Form Design', DividerPositionSt, Value);
end;


end.
