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

unit cxWebteeChartReg;

interface

{$I cxVer.inc}
{$I cxWebTeeChart.inc}

procedure Register;

implementation

uses Classes, SysUtils, DesignIntf, DesignEditors, Chart,
  {$IFDEF TEEPRO}TeeChartReg, DBEditCh,{$ELSE} ChartReg,{$ENDIF}
  {$IFDEF VCL}
  Windows, Graphics, Forms,
  {$ELSE}
  Qt, QGraphics, QForms,
  {$ENDIF}
  cxWebteeChart, cxWebDsgnUtils;

type
  TcxWebChartCompEditor = class(TComponentEditor)
  protected
    function Chart: TCustomChart;
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;


{ TcxWebChartCompEditor }
function TcxWebChartCompEditor.Chart: TCustomChart;
begin
  Result := (Component as TcxCustomWebChart).Chart;
end;

procedure TcxWebChartCompEditor.Edit;
begin
  EditChartDesign(Chart{$IFNDEF TEEPRO}, Designer{$ENDIF});
  Designer.Modified;
end;

procedure TcxWebChartCompEditor.ExecuteVerb(Index : Integer);
begin
  Edit;
end;

function TcxWebChartCompEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

function TcxWebChartCompEditor.GetVerb(Index : Integer) : string;
begin
  Result := 'Chart Edit...'; //TODO
end;

procedure Register;
begin
  cxRegisterWebComponents('EWF Controls', [TcxWebChart], True);
  RegisterComponentEditor(TcxCustomWebChart, TcxWebChartCompEditor);
end;


end.
