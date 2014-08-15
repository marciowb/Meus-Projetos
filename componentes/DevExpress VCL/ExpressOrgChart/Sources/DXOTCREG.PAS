{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express OrgChart                                            }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSORGCHART AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxotcreg;

interface
{$I cxVer.inc}
uses   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI6}
    DesignIntf,
    DesignEditors,
   {$ELSE}
     DsgnIntf,
  {$ENDIF}
  dxorgchr, dxorgced;

procedure Register;

implementation

{$R *.RES}

const
  dxotcVersion = '1.54';

type
  TdxOrgChartEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TdxOrgChartEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if ShowOrgChartEditor(TdxOrgChart(Component)) then Designer.Modified;
  end;
end;

function TdxOrgChartEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Items Editor...';
    1: Result := '-';
    2: Result := 'ExpressOrgChart ' + dxotcVersion;
    3: Result := 'Developer Express Inc.';
  end;
end;

function TdxOrgChartEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  
  RegisterComponents('ExpressOrgChart',[TdxOrgChart]);
  RegisterComponentEditor(TdxOrgChart,TdxOrgChartEditor);
end;

end.
