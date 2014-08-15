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
unit cxWebteeChart;

interface

{$I cxVer.inc}
{$I cxWebTeeChart.inc}

uses Classes, Chart, TeEngine, TeeProcs, TeCanvas,
  {$IFDEF VCL}
  Windows, Graphics, Forms,
  {$ELSE}
  Qt, QGraphics, QForms,
  {$ENDIF}
  cxWebStdCtrls, cxWebData, cxWebDataUtils;

type
  TcxCustomWebChart = class(TcxCustomWebImage)
  private
    FForm: TForm;
    FChart : TCustomChart;

    procedure DoSeriesRead(Component: TComponent);
    procedure ReadSeries(Stream: TStream);
    procedure WriteSeries(Stream: TStream);
    function GetChartJPEGStream: TMemoryStream;

    function GetMonochrome: Boolean;
    function GetBackImageInside: Boolean;
    function GetAxisVisible: Boolean;
    function GetClipPoints: Boolean;
    function GetView3DWalls: Boolean;
    function GetView3D: Boolean;
    function GetMarginTop: Integer;
    function GetMarginBottom: Integer;
    function GetMarginLeft: Integer;
    function GetMarginRight: Integer;
    function GetChart3DPercent: Integer;
    function GetPage: LongInt;
    function GetMaxPointsPerPage: LongInt;
    function GetBottomAxis: TChartAxis;
    function GetTopAxis: TChartAxis;
    function GetDepthAxis: TChartDepthAxis;
    function GetLeftAxis: TChartAxis;
    function GetRightAxis: TChartAxis;
    function GetGradient: TChartGradient;
    function GetLegend: TChartLegend;
    function GetFrame: TChartPen;
    function GetSeriesList: TChartSeriesList;
    function GetFoot: TChartTitle;
    function GetTitle: TChartTitle;
    function GetLeftWall: {$IFDEF TEE8}TChartLeftWall{$ELSE}TChartWall{$ENDIF};
    function GetBackWall: TChartWall;
    function GetBottomWall: {$IFDEF TEE8}TChartBottomWall{$ELSE}TChartWall{$ENDIF};
    function GetBackImage: {$IFDEF TEE7}TBackImage{$ELSE}TPicture{$ENDIF};
    function GetBackImageMode: TTeeBackImageMode;
    function GetView3DOptions: TView3dOptions;

    procedure SetAxisVisible(const Value: Boolean);
    procedure SetBackImage(const Value: {$IFDEF TEE7}TBackImage{$ELSE}TPicture{$ENDIF});
    procedure SetBackImageInside(const Value: Boolean);
    procedure SetBackImageMode(const Value: TTeeBackImageMode);
    procedure SetBackWall(const Value: TChartWall);
    procedure SetBottomAxis(const Value: TChartAxis);
    procedure SetBottomWall(const Value: {$IFDEF TEE8}TChartBottomWall{$ELSE}TChartWall{$ENDIF});
    procedure SetChart3DPercent(const Value: Integer);
    procedure SetClipPoints(const Value: Boolean);
    procedure SetDepthAxis(const Value: TChartDepthAxis);
    procedure SetFoot(const Value: TChartTitle);
    procedure SetFrame(const Value: TChartPen);
    procedure SetGradient(const Value: TChartGradient);
    procedure SetLeftAxis(const Value: TChartAxis);
    procedure SetLeftWall(const Value: {$IFDEF TEE8}TChartLeftWall{$ELSE}TChartWall{$ENDIF});
    procedure SetLegend(const Value: TChartLegend);
    procedure SetMarginBottom(const Value: Integer);
    procedure SetMarginLeft(const Value: Integer);
    procedure SetMarginRight(const Value: Integer);
    procedure SetMarginTop(const Value: Integer);
    procedure SetMaxPointsPerPage(const Value: LongInt);
    procedure SetMonochrome(const Value: Boolean);
    procedure SetPage(const Value: LongInt);
    procedure SetRightAxis(const Value: TChartAxis);
    procedure SetTitle(const Value: TChartTitle);
    procedure SetTopAxis(const Value: TChartAxis);
    procedure SetView3D(const Value: Boolean);
    procedure SetView3DOptions(const Value: TView3dOptions);
    procedure SetView3DWalls(const Value: Boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function CreateChart(AOwner: TComponent): TCustomChart; virtual; abstract;
    procedure DoBeforeRender; override;
    procedure DoAfterRender; override;

    property BackImage: {$IFDEF TEE7}TBackImage{$ELSE}TPicture{$ENDIF} read GetBackImage write SetBackImage;
    property BackImageInside: Boolean read GetBackImageInside write SetBackImageInside;
    property BackImageMode: TTeeBackImageMode read GetBackImageMode write SetBackImageMode;
    property BackWall: TChartWall read GetBackWall write SetBackWall;
    property BottomWall: {$IFDEF TEE8}TChartBottomWall{$ELSE}TChartWall{$ENDIF} read GetBottomWall write SetBottomWall;
    property Foot: TChartTitle read GetFoot write SetFoot;
    property Gradient: TChartGradient read GetGradient write SetGradient;
    property LeftWall: {$IFDEF TEE8}TChartLeftWall{$ELSE}TChartWall{$ENDIF} read GetLeftWall write SetLeftWall;
    property Legend: TChartLegend read GetLegend write SetLegend;
    property MarginBottom: Integer read GetMarginBottom write SetMarginBottom;
    property MarginLeft: Integer read GetMarginLeft write SetMarginLeft;
    property MarginRight: Integer read GetMarginRight write SetMarginRight;
    property MarginTop: Integer read GetMarginTop write SetMarginTop;
    property Title: TChartTitle read GetTitle write SetTitle;
    property AxisVisible: Boolean read GetAxisVisible write SetAxisVisible;
    property BottomAxis: TChartAxis read GetBottomAxis write SetBottomAxis;
    property Chart3DPercent: Integer read GetChart3DPercent write SetChart3DPercent;
    property ClipPoints: Boolean read GetClipPoints write SetClipPoints;
    property DepthAxis: TChartDepthAxis read GetDepthAxis write SetDepthAxis;
    property Frame: TChartPen read GetFrame write SetFrame;
    property LeftAxis: TChartAxis read GetLeftAxis write SetLeftAxis;
    property MaxPointsPerPage: LongInt read GetMaxPointsPerPage write SetMaxPointsPerPage;
    property Monochrome: Boolean read GetMonochrome write SetMonochrome;
    property Page: LongInt read GetPage write SetPage;
    property RightAxis: TChartAxis read GetRightAxis write SetRightAxis;
    property TopAxis: TChartAxis read GetTopAxis write SetTopAxis;
    property View3D: Boolean read GetView3D write SetView3D;
    property View3DOptions: TView3dOptions read GetView3DOptions write SetView3DOptions;
    property View3DWalls: Boolean read GetView3DWalls write SetView3DWalls;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Chart: TCustomChart read FChart;
    property SeriesList: TChartSeriesList read GetSeriesList;
  end;

  TcxWebChart = class(TcxCustomWebChart)
  private
    function GetChart: TChart;
  protected
    function CreateChart(AOwner: TComponent): TCustomChart; override;
  public
    property Chart: TChart read GetChart;
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

uses Series,
  {$IFDEF VCL}
  jpeg, Controls,
  {$ELSE}
  QControls,
  {$ENDIF}
  cxWebFileCacheManager, cxWebControls;

{ TcxCustomWebChart }

constructor TcxCustomWebChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FForm := TForm.CreateNew(nil);
  FForm.SetBounds(0, 0, 10, 10);
  FChart := CreateChart(self);
  FChart.Parent := FForm;
  DisplayStyle := wdsStretch;
end;

destructor TcxCustomWebChart.Destroy;
begin
  FChart.Free;
  FChart := nil;
  FForm.Free;
  FForm := nil;
  inherited Destroy;
end;

procedure TcxCustomWebChart.DoBeforeRender;
var
  AStream: TMemoryStream;
begin
  FChart.SetBounds(0, 0, Width, Height);
  AStream := GetChartJPEGStream;
  try
    BeginUpdateDesignerContext;
    PictureURL := TcxWebFileCacheManager.Instance.Add('', AStream);
  finally
    AStream.Free;
    CancelUpdateDesignerContext;
  end;
end;

procedure TcxCustomWebChart.DoAfterRender;
begin

end;


procedure TcxCustomWebChart.DefineProperties(Filer: TFiler);
begin
  Filer.DefineBinaryProperty('Series', ReadSeries, WriteSeries, Chart.SeriesCount > 0);
  inherited DefineProperties(Filer);
end;

procedure TcxCustomWebChart.DoSeriesRead(Component: TComponent);
begin
  Chart.AddSeries(Component as TChartSeries);
  if not Assigned((Component as TChartSeries).DataSource) then
    (Component as TChartSeries).FillSampleValues((Component as TChartSeries).NumSampleValues);
end;

procedure TcxCustomWebChart.ReadSeries(Stream: TStream);
var
  AReader: TReader;
begin
  AReader := TReader.Create(Stream, 4096);
  try
    AReader.ReadComponents(Chart, Chart, DoSeriesRead);
  finally
    AReader.Free;
  end;
end;

procedure TcxCustomWebChart.WriteSeries(Stream: TStream);
var
  AWriter: TWriter;
  I: Integer;
begin
  AWriter := TWriter.Create(Stream, 4096);
  try
    AWriter.Root := Chart;
    for I := 0 to Chart.SeriesCount - 1 do
    begin
      AWriter.WriteSignature;
      AWriter.WriteComponent(Chart.Series[I]);
    end;
    AWriter.WriteListEnd;
  finally
    AWriter.Free;
  end;
end;

function TcxCustomWebChart.GetChartJPEGStream: TMemoryStream;
var
  jpeg: TJPEGImage;
  bmp: TBitmap;
begin
  Result := TMemoryStream.Create;
  jpeg := TJPEGImage.Create;
  try
    bmp := Chart.TeeCreateBitmap(clDefault, Chart.GetRectangle);
    try
      jpeg.Assign(bmp);
      jpeg.SaveToStream(result);
    finally
      bmp.Free;
    end;
  finally
    jpeg.Free;
  end;
end;

function TcxCustomWebChart.GetMonochrome: Boolean;
begin
  Result := Chart.Monochrome;
end;

function TcxCustomWebChart.GetBackImageInside: Boolean;
begin
  Result := Chart.BackImageInside;
end;

function TcxCustomWebChart.GetAxisVisible: Boolean;
begin
  Result := Chart.AxisVisible;
end;

function TcxCustomWebChart.GetClipPoints: Boolean;
begin
  Result := Chart.ClipPoints;
end;

function TcxCustomWebChart.GetView3DWalls: Boolean;
begin
  Result := Chart.View3DWalls;
end;

function TcxCustomWebChart.GetView3D: Boolean;
begin
  Result := Chart.View3D;
end;

function TcxCustomWebChart.GetMarginTop: Integer;
begin
  Result := Chart.MarginTop;
end;

function TcxCustomWebChart.GetMarginBottom: Integer;
begin
  Result := Chart.MarginBottom;
end;

function TcxCustomWebChart.GetMarginLeft: Integer;
begin
  Result := Chart.MarginLeft;
end;

function TcxCustomWebChart.GetMarginRight: Integer;
begin
  Result := Chart.MarginRight;
end;

function TcxCustomWebChart.GetChart3DPercent: Integer;
begin
  Result := Chart.Chart3DPercent;
end;

function TcxCustomWebChart.GetPage: LongInt;
begin
  Result := Chart.Page;
end;

function TcxCustomWebChart.GetMaxPointsPerPage: LongInt;
begin
  Result := Chart.MaxPointsPerPage;
end;

function TcxCustomWebChart.GetBottomAxis: TChartAxis;
begin
  Result := Chart.BottomAxis;
end;

function TcxCustomWebChart.GetTopAxis: TChartAxis;
begin
  Result := Chart.TopAxis;
end;

function TcxCustomWebChart.GetDepthAxis: TChartDepthAxis;
begin
  Result := Chart.DepthAxis;
end;

function TcxCustomWebChart.GetLeftAxis: TChartAxis;
begin
  Result := Chart.LeftAxis;
end;

function TcxCustomWebChart.GetRightAxis: TChartAxis;
begin
  Result := Chart.RightAxis;
end;

function TcxCustomWebChart.GetGradient: TChartGradient;
begin
  Result := Chart.Gradient;
end;

function TcxCustomWebChart.GetLegend: TChartLegend;
begin
  Result := Chart.Legend;
end;

function TcxCustomWebChart.GetFrame: TChartPen;
begin
  Result := Chart.Frame;
end;

function TcxCustomWebChart.GetSeriesList: TChartSeriesList;
begin
  Result := Chart.SeriesList;
end;

function TcxCustomWebChart.GetFoot: TChartTitle;
begin
  Result := Chart.Foot;
end;

function TcxCustomWebChart.GetTitle: TChartTitle;
begin
  Result := Chart.Title;
end;

function TcxCustomWebChart.GetLeftWall: {$IFDEF TEE8}TChartLeftWall{$ELSE}TChartWall{$ENDIF};
begin
  Result := Chart.LeftWall;
end;

function TcxCustomWebChart.GetBackWall: TChartWall;
begin
  Result := Chart.BackWall;
end;

function TcxCustomWebChart.GetBottomWall: {$IFDEF TEE8}TChartBottomWall{$ELSE}TChartWall{$ENDIF};
begin
  Result := Chart.BottomWall;
end;

function TcxCustomWebChart.GetBackImage: {$IFDEF TEE7}TBackImage{$ELSE}TPicture{$ENDIF};
begin
  Result := Chart.BackImage;
end;

function TcxCustomWebChart.GetBackImageMode: TTeeBackImageMode;
begin
  Result := Chart.BackImageMode;
end;

function TcxCustomWebChart.GetView3DOptions: TView3dOptions;
begin
  Result := Chart.View3DOptions;
end;

procedure TcxCustomWebChart.SetAxisVisible(const Value: Boolean);
begin
  Chart.AxisVisible := Value;
end;

procedure TcxCustomWebChart.SetBackImage(const Value: {$IFDEF TEE7}TBackImage{$ELSE}TPicture{$ENDIF});
begin
  Chart.BackImage := Value;
end;

procedure TcxCustomWebChart.SetBackImageInside(const Value: Boolean);
begin
  Chart.BackImageInside := Value;
end;

procedure TcxCustomWebChart.SetBackImageMode(
  const Value: TTeeBackImageMode);
begin
  Chart.BackImageMode := Value;
end;

procedure TcxCustomWebChart.SetBackWall(const Value: TChartWall);
begin
//TODO  Chart.BackWall := Value;
end;

procedure TcxCustomWebChart.SetBottomAxis(const Value: TChartAxis);
begin
  Chart.BottomAxis := Value;
end;

procedure TcxCustomWebChart.SetBottomWall(const Value: {$IFDEF TEE8}TChartBottomWall{$ELSE}TChartWall{$ENDIF});
begin
  Chart.BottomWall := Value;
end;

procedure TcxCustomWebChart.SetChart3DPercent(const Value: Integer);
begin
  Chart.Chart3DPercent := Value;
end;

procedure TcxCustomWebChart.SetClipPoints(const Value: Boolean);
begin
  Chart.ClipPoints := Value;
end;

procedure TcxCustomWebChart.SetDepthAxis(const Value: TChartDepthAxis);
begin
  Chart.DepthAxis := Value;
end;

procedure TcxCustomWebChart.SetFoot(const Value: TChartTitle);
begin
  Chart.Foot := Value;
end;

procedure TcxCustomWebChart.SetFrame(const Value: TChartPen);
begin
  Chart.Frame := Value;
end;

procedure TcxCustomWebChart.SetGradient(const Value: TChartGradient);
begin
  Chart.Gradient := Value;
end;

procedure TcxCustomWebChart.SetLeftAxis(const Value: TChartAxis);
begin
  Chart.LeftAxis := Value;
end;

procedure TcxCustomWebChart.SetLeftWall(const Value: {$IFDEF TEE8}TChartLeftWall{$ELSE}TChartWall{$ENDIF});
begin
  Chart.LeftWall := Value;
end;

procedure TcxCustomWebChart.SetLegend(const Value: TChartLegend);
begin
  Chart.Legend := Value;
end;

procedure TcxCustomWebChart.SetMarginBottom(const Value: Integer);
begin
  Chart.MarginBottom := Value;
end;

procedure TcxCustomWebChart.SetMarginLeft(const Value: Integer);
begin
  Chart.MarginLeft := Value;
end;

procedure TcxCustomWebChart.SetMarginRight(const Value: Integer);
begin
  Chart.MarginRight := Value;
end;

procedure TcxCustomWebChart.SetMarginTop(const Value: Integer);
begin
  Chart.MarginTop := Value;
end;

procedure TcxCustomWebChart.SetMaxPointsPerPage(const Value: LongInt);
begin
  Chart.MaxPointsPerPage := Value;
end;

procedure TcxCustomWebChart.SetMonochrome(const Value: Boolean);
begin
  Chart.Monochrome := Value;
end;

procedure TcxCustomWebChart.SetPage(const Value: LongInt);
begin
  Chart.Page := Value;
end;

procedure TcxCustomWebChart.SetRightAxis(const Value: TChartAxis);
begin
  Chart.RightAxis := Value;
end;

procedure TcxCustomWebChart.SetTitle(const Value: TChartTitle);
begin
  Chart.Title := Value;
end;

procedure TcxCustomWebChart.SetTopAxis(const Value: TChartAxis);
begin
  Chart.TopAxis := Value;
end;

procedure TcxCustomWebChart.SetView3D(const Value: Boolean);
begin
  Chart.View3D := Value;
end;

procedure TcxCustomWebChart.SetView3DOptions(const Value: TView3dOptions);
begin
  Chart.View3DOptions := Value;
end;

procedure TcxCustomWebChart.SetView3DWalls(const Value: Boolean);
begin
  Chart.View3DWalls := Value;
end;

{ TcxWebteeChart }

function TcxWebChart.CreateChart(AOwner: TComponent): TCustomChart;
begin
  Result := TChart.Create(AOwner);
end;


function TcxWebChart.GetChart: TChart;
begin
  Result := FChart as TChart;
end;

initialization
  RegisterClasses([TPieSeries]);

end.

