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
unit cxWebDsgnChartCtrls;

{$I cxVer.inc}

interface

uses
  Classes,
  {$IFDEF VCL}
  Windows, Controls, Messages, Graphics, StdCtrls,
  {$ELSE}
  Qt, QControls, QGraphics, QStdCtrls,
  {$ENDIF}
  cxWebDsgnIntf, cxWebDsgnIntfImpl, cxWebteeChart, cxWebDsgnCtrls;

type
  TcxWebDesignTeeChart = class(TcxWebDesignControl)
  protected
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebChart; reintroduce; overload;
  public
    property WebChart: TcxCustomWebChart read GetInternalWebControl;
  end;


implementation

uses cxWebCtrlsFactory;

{ TcxWebDesignTeeChart }

procedure TcxWebDesignTeeChart.DrawInterior(var R: TRect);
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp := WebChart.Chart.TeeCreateBitmap(clDefault, R);
    Canvas.Draw(R.Left, R.Top, bmp);
  finally
    bmp.Free;
  end;
end;

function TcxWebDesignTeeChart.GetInternalWebControl: TcxCustomWebChart;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebChart;
end;

initialization
  WebDesignControlsFactory.RegisterDesignControl(TcxCustomWebChart, TcxWebDesignTeeChart);

finalization
  WebDesignControlsFactory.UnregisterDesignControl(TcxWebDesignTeeChart);



end.
