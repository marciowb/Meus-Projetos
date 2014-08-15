{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Application Module                                      }
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
unit cxWebDBteeChart;

interface

{$I cxVer.inc}

uses Classes, cxWebStdCtrls, cxWebData, cxWebDataUtils, Chart, DBChart,
  cxWebteeChart;

type
  TcxWebDBChart = class(TcxCustomWebChart)
  private
    function GetDBChart: TDBChart;
  protected
    function CreateChart(AOwner: TComponent): TCustomChart; override;
  public
    property DBChart: TDBChart read GetDBChart;
  published
    property AltText;

    property BackImage;
    property BackImageInside;
    property BackImageMode;
    property BackWall;
    property BottomWall;
    property Foot;
    property Gradient;
    property LeftWall;
    property Legend;
    property MarginBottom;
    property MarginLeft;
    property MarginRight;
    property MarginTop;
    property Title;
    property AxisVisible;
    property BottomAxis;
    property Chart3DPercent;
    property ClipPoints;
    property DepthAxis;
    property Frame;
    property LeftAxis;
    property MaxPointsPerPage;
    property Monochrome;
    property Page;
    property RightAxis;
    property TopAxis;
    property View3D;
    property View3DOptions;
    property View3DWalls;
  end;

implementation

{ TcxWebDBChart }

function TcxWebDBChart.CreateChart(AOwner: TComponent): TCustomChart;
begin
  Result := TDBChart.Create(AOwner);
end;

function TcxWebDBChart.GetDBChart: TDBChart;
begin
  Result := Chart as TDBChart;
end;

end.
