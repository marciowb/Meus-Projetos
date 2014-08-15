{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
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

unit dxfchreg;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI6}DesignIntf,DesignEditors{$ELSE}DsgnIntf{$ENDIF}, dxFlChrt, dxFcEdit;

procedure Register;

implementation
{$R *.RES}

const
  dxfchVersion = '1.54';

type
  TdxFlowChartEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TdxFlowChartEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if ShowFlowChartEditor(TdxFlowChart(Component),'ExpressFlowChart Editor') then Designer.Modified;
  end;
end;

function TdxFlowChartEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Editor...';
    1: Result := '-';
    2: Result := 'ExpressFlowChart ' + dxfchVersion;
    3: Result := 'Developer Express Inc.'
  end;
end;

function TdxFlowChartEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

procedure Register;
begin
  RegisterComponents('ExpressFlowChart', [TdxFlowChart]);
  RegisterComponentEditor(TdxFlowChart,TdxFlowChartEditor);
end;

end.
