{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSGraphicLnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Graphics, ExtCtrls, dxPSGlbl, dxPSCore, dxBkgnd;

type  
  TCustomdxGraphicReportLink = class(TBasedxReportLink)
  private
    FBorderColor: TColor;    
    FCenter: Boolean;
    FDrawBorder: Boolean;
    FProportional: Boolean;
    FStretch: Boolean;
    FTransparentColor: TColor;
    procedure SetBorderColor(Value: TColor);
    procedure SetCenter(Value: Boolean);
    procedure SetDrawBorder(Value: Boolean);
    procedure SetProportional(Value: Boolean);
    procedure SetStretch(Value: Boolean);
    procedure SetTransparentColor(Value: TColor);
  protected
    function GetAlwaysBufferedGraphics: Boolean; override;
    function GetCriticalSize(AReportCells: TdxReportCells): Integer; override;
    function CalculateActualScaleFactor: Integer; override;
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure InternalRestoreDefaults; override;

    function GetGraphic: TGraphic; virtual;
    function GetGraphicClass: TGraphicClass; virtual;
    function GetGraphicHeight: Integer; virtual;
    function GetGraphicWidth: Integer; virtual;
    function GetDrawMode: TdxGraphicDrawMode; virtual;
    procedure InitializeGraphicItem(AnItem: TdxReportCellGraphic); virtual;
    
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property Center: Boolean read FCenter write SetCenter default False;
    property DrawBorder: Boolean read FDrawBorder write SetDrawBorder default False;
    property DrawMode: TdxGraphicDrawMode read GetDrawMode;
    property GraphicHeight: Integer read GetGraphicHeight;
    property GraphicWidth: Integer read GetGraphicWidth;
    property Proportional: Boolean read FProportional write SetProportional default False;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property TransparentColor: TColor read FTransparentColor write SetTransparentColor default clWindow;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    class function Aggregable: Boolean; override;
  end;

  TCustomdxPictureReportLink = class(TCustomdxGraphicReportLink)
  protected
    function GetGraphic: TGraphic; override;
    function GetGraphicHeight: Integer; override;
    function GetGraphicWidth: Integer; override;
    function GetPicture: TPicture; virtual;
    
    property Picture: TPicture read GetPicture;
  public
    function DataProviderPresent: Boolean; override;
  end;
  
  TdxPictureReportLink = class(TCustomdxPictureReportLink)
  private
    FPicture: TPicture;
    procedure SetPicture(Value: TPicture);
    procedure PictureChanged(Sender: TObject);
  protected
    function GetPicture: TPicture; override;
    procedure SetComponent(Value: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property BorderColor;
    property DrawBorder;            
    property Picture write SetPicture;
    property Transparent;
    property TransparentColor;  
  end;

implementation

uses
  SysUtils, cxClasses, dxPSUtl, dxPSRes;
  
const 
  CellSidesMap: array[Boolean] of TdxCellSides = ([], csAll);
  
{ TCustomdxGraphicReportLink }

constructor TCustomdxGraphicReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FBorderColor := dxDefaultGridLineColor;
  FCenter := False;
  FDrawBorder := False;
  FProportional := False;
  FStretch := False;
  FTransparentColor := clWindow;
end;

procedure TCustomdxGraphicReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomdxGraphicReportLink then
    with TCustomdxGraphicReportLink(Source) do 
    begin
      Self.BorderColor := BorderColor;
      Self.Center := Center;
      Self.DrawBorder := DrawBorder;
      Self.Proportional := Proportional;
      Self.Stretch := Stretch;
      Self.TransparentColor := TransparentColor;
    end;
end;

class function TCustomdxGraphicReportLink.Aggregable: Boolean;
begin
  Result := True;//}False;
end;

function TCustomdxGraphicReportLink.GetAlwaysBufferedGraphics: Boolean;
begin
  Result := False;
end;

function TCustomdxGraphicReportLink.GetCriticalSize(AReportCells: TdxReportCells): Integer;
begin
  with AReportCells.BoundsRect do
  begin
    Result := Right - Left;
    if Result < Bottom - Top then
      Result := Bottom - Top;
  end;    
end;

function TCustomdxGraphicReportLink.CalculateActualScaleFactor: Integer;
var
  PaintW, PaintH: Integer;
begin
  if (ReportWidth <> 0) and (ReportHeight <> 0) then
  begin
    with RealPrinterPage do
    begin
      PaintW := PaintRectLoMetric.Right - PaintRectLoMetric.Left;
      PaintH := PaintRectLoMetric.Bottom - PaintRectLoMetric.Top;
      if ReportTitle.Mode <> tmNone then
        Dec(PaintH, MulDiv(Renderer.RenderInfo.TitleHeight, 254, FUnitsPerInch));

      PaintW := FitToPagesByWide * MulDiv(PaintW, FUnitsPerInch, 254);
      PaintH := FitToPagesByTall * MulDiv(PaintH, FUnitsPerInch, 254);
    end;  
    if ReportWidth / ReportHeight >  PaintW / PaintH then
      Result := MulDiv(PaintW, 100, ReportWidth) - 1
    else
      Result := MulDiv(PaintH, 100, ReportHeight) - 1;
  end
  else
    Result := 1;
end;

procedure TCustomdxGraphicReportLink.ConstructReport(AReportCells: TdxReportCells);
var
  Graphic: TGraphic;
  Cell: TdxReportCell;
  Data: TdxReportCellGraphic;
begin
  inherited;
  Graphic := GetGraphic;
  if Graphic <> nil then 
  try
    AReportCells.Cells.Color := Color;
    AReportCells.Cells.CellSides := CellSidesMap[DrawBorder];
    AReportCells.BorderColor := BorderColor;

    Cell := TdxReportCell.Create(AReportCells.Cells);
    Cell.CellSides := []; 

    Data := TdxReportCellGraphic.Create(Cell);
    Data.BoundsRect := MakeRect(0, 0, GraphicWidth, GraphicHeight);
    Data.Image := Graphic;
    InitializeGraphicItem(Data);

    Cell.BoundsRect := Data.BoundsRect;
    AReportCells.Cells.BoundsRect := Cell.BoundsRect;
    AReportCells.DoProgress(100);
  finally
    Graphic.Free;
  end;  
end;

procedure TCustomdxGraphicReportLink.InternalRestoreDefaults;
begin
  inherited;
  BorderColor := dxDefaultGridLineColor;
  Center := False;
  DrawBorder := False;
  Proportional := False;
  Stretch := False;
  TransparentColor := clWindow;
end;

function TCustomdxGraphicReportLink.GetGraphic: TGraphic;
begin
  Result := nil;
end;

function TCustomdxGraphicReportLink.GetGraphicClass: TGraphicClass;
begin
  Result := nil;
end;

function TCustomdxGraphicReportLink.GetGraphicHeight: Integer;
var
  Graphic: TGraphic;
begin
  Graphic := GetGraphic;
  if Graphic <> nil then
  try
    Result := Graphic.Height;
  finally
    Graphic.Free;
  end
  else
    Result := 0;  
end;

function TCustomdxGraphicReportLink.GetGraphicWidth: Integer;
var
  Graphic: TGraphic;
begin
  Graphic := GetGraphic;
  if Graphic <> nil then
    try
      Result := Graphic.Width;
    finally
      Graphic.Free;
    end  
  else
    Result := 0;  
end;

function TCustomdxGraphicReportLink.GetDrawMode: TdxGraphicDrawMode;
begin
  if Stretch then
    if Proportional then
      if Center then 
        Result := gdmCenterAndStretchProportional 
      else
        Result := gdmStretchProportional 
    else
      Result := gdmStretch    
  else
    if Center then
      Result := gdmCenter 
    else
      Result := gdmNone;
end;

procedure TCustomdxGraphicReportLink.InitializeGraphicItem(AnItem: TdxReportCellGraphic);
const
  ImageBufferingMap: array[Boolean] of TdxCellImageBuffering = (cibAlways, cibNone);
begin
  AnItem.Color := Color;
  AnItem.CellSides := CellSidesMap[DrawBorder];
  AnItem.ImageBuffering := ImageBufferingMap[(GetGraphicClass <> nil) and GetGraphicClass.InheritsFrom(TMetafile)];
  AnItem.ImageTransparent := Transparent;
  AnItem.Transparent := True;
end;

procedure TCustomdxGraphicReportLink.SetBorderColor(Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxGraphicReportLink.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxGraphicReportLink.SetDrawBorder(Value: Boolean);
begin
  if FDrawBorder <> Value then
  begin
    FDrawBorder := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxGraphicReportLink.SetProportional(Value: Boolean);
begin
  if FProportional <> Value then
  begin
    FProportional := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxGraphicReportLink.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxGraphicReportLink.SetTransparentColor(Value: TColor);
begin
  if FTransparentColor <> Value then 
  begin
    FTransparentColor := Value;
    LinkModified(True);
  end;
end;

{ TCustomdxPictureReportLink }

function TCustomdxPictureReportLink.DataProviderPresent: Boolean;
begin
  if DataSource = rldsComponent then
    Result := (Picture <> nil) and (Picture.Graphic <> nil) and not Picture.Graphic.Empty
  else
    Result := inherited DataProviderPresent;
end;

function TCustomdxPictureReportLink.GetGraphic: TGraphic;

  function CalculateGraphicBounds(ADest, AGraphic: TGraphic): TRect;
  var
    X, Y, V: Integer;
  begin
    case DrawMode of  
      gdmNone, 
      gdmCenter:
        begin
          Result := MakeBounds(0, 0, AGraphic.Width, AGraphic.Height);
          if DrawMode = gdmCenter then
          begin
            X := Result.Left + (ADest.Width - AGraphic.Width) div 2;
            Y := Result.Top + (ADest.Height - AGraphic.Height) div 2;
            OffsetRect(Result, X, Y);
          end;  
        end;
          
      gdmStretchProportional, 
      gdmCenterAndStretchProportional:
        begin                       
          if AGraphic.Width / AGraphic.Height > ADest.Width / ADest.Height then
          begin
            V := MulDiv(AGraphic.Height, ADest.Width, AGraphic.Width);
            Result := MakeBounds(0, 0, ADest.Width, V);
          end
          else
          begin
            V := MulDiv(AGraphic.Width, ADest.Height, AGraphic.Height);
            Result := MakeBounds(0, 0, V, ADest.Height);
          end;
          if DrawMode = gdmCenterAndStretchProportional then 
            if Result.Right - Result.Left = ADest.Width then
              OffsetRect(Result, 0, (ADest.Height - (Result.Bottom - Result.Top)) div 2)
            else
              OffsetRect(Result, (ADest.Width - (Result.Right - Result.Left)) div 2, 0);
        end;
    else // gdmStretch
      Result := MakeBounds(0, 0, ADest.Width, ADest.Height);
    end;
  end;
  
var
  R: TRect;  
begin
  if DataProviderPresent then 
  begin
    Result := TBitmap.Create;
    with TBitmap(Result) do 
    try
      Height := GraphicHeight;
      Width := GraphicWidth;
      if Self.Transparent then 
      begin
        Canvas.Brush.Color := TransparentColor;
        Canvas.FillRect(MakeRect(0, 0, Width, Height));
      end;
      if Picture.Graphic <> nil then 
      begin
        R := CalculateGraphicBounds(Result, Picture.Graphic);
        Canvas.StretchDraw(R, Picture.Graphic);  
      end;
      
      Transparent := Self.Transparent;
      if Transparent then
        TransparentColor := Self.TransparentColor;
      HandleType := bmDIB;
    except  
      Free;
      raise;
    end
  end  
  else  
    Result := inherited GetGraphic;
end;

function TCustomdxPictureReportLink.GetGraphicHeight: Integer; 
begin
  if Picture <> nil then
    Result := Picture.Height
  else
    Result := inherited GetGraphicHeight;
end;

function TCustomdxPictureReportLink.GetGraphicWidth: Integer; 
begin
  if Picture <> nil then
    Result := Picture.Width
  else
    Result := inherited GetGraphicWidth;
end;

function TCustomdxPictureReportLink.GetPicture: TPicture;
begin
  Result := nil;
end;

{ TdxPictureReportLink }

constructor TdxPictureReportLink.Create(AOwner: TComponent);
begin
  inherited;
  ReportDocument.Description := cxGetResourceString(@sdxTPicture);
  Transparent := False;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  LinkModified(False);
end;

destructor TdxPictureReportLink.Destroy;
begin
  FreeAndNil(FPicture);
  inherited;
end;

procedure TdxPictureReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxPictureReportLink then 
    Picture := TdxPictureReportLink(Source).Picture;
end;

function TdxPictureReportLink.GetPicture: TPicture;
begin
  Result := FPicture;
end;

procedure TdxPictureReportLink.SetPicture(Value: TPicture);
begin
  Picture.Assign(Value);
end;

procedure TdxPictureReportLink.SetComponent(Value: TComponent);
begin
end;

procedure TdxPictureReportLink.PictureChanged(Sender: TObject);
begin
  LinkModified(True);
  DesignerModified;
  DesignerUpdate(False);
end;

initialization
  dxPSRegisterReportLink(TdxPictureReportLink, nil, nil);

finalization
  dxPSUnregisterReportLink(TdxPictureReportLink, nil, nil);

end.
