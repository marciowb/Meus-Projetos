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

unit dxPSdxOCLnk;

interface

{$I cxVer.inc}

uses
  Classes, Windows, Graphics, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls,
  dxOrgChr, dxPSCore, dxPSGraphicLnk, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters;

type
  TCustomdxOrgChartReportLink = class(TCustomdxGraphicReportLink)
  private
    FFullExpand: Boolean;
    FUseMetafile: Boolean;
    function GetOrgChart: TdxOrgChart;
    procedure SetFullExpand(Value: Boolean);
  protected
    function GetGraphic: TGraphic; override;
    function GetGraphicClass: TGraphicClass; override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;    
    property OrgChart: TdxOrgChart read GetOrgChart;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(Source: TPersistent); override;
    property Color;
    property FullExpand: Boolean read FFullExpand write SetFullExpand default False;
    property Transparent;
    property UseMetafile: Boolean read FUseMetafile write FUseMetafile default True;
  end;

  TdxOrgChartReportLink = class(TCustomdxOrgChartReportLink)
  public
    property OrgChart;
  published
    property BorderColor;
    property Color;
    property DrawBorder;
    property FullExpand;
    property Transparent;
    property TransparentColor;
    property UseMetafile;
  end;

  TdxOCReportLinkDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshOptions: TTabSheet;
    pnlOptions: TPanel;
    chbxFullExpand: TCheckBox;
    pnlPreview: TPanel;
    chbxDrawBorder: TCheckBox;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    chbxTransparent: TCheckBox;
    gbxBorder: TGroupBox;
    lblGridLinesColor: TLabel;
    bvlLineColorHolder: TBevel;
    ocPreview: TdxOrgChart;
    lblPreview: TLabel;
    stTransparent: TStaticText;
    stDrawBorder: TStaticText;
    procedure lblColorClick(Sender: TObject);
    procedure chbxFullExpandClick(Sender: TObject);
    procedure chbxDrawBorderClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
    procedure stDrawBorderClick(Sender: TObject);
  private
    FOCBmp: TBitmap;
    procedure ccbxColorChange(Sender: TObject);
    procedure CreateControls;
    function GetReportLink: TCustomdxOrgChartReportLink;
    procedure pbxPreviewPaint(Sender: TObject);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    ccbxColor: TCustomComboBox;
    ccbxGridLineColor: TCustomComboBox;
    FPreviewBox: TCustomControl;
    procedure DoInitialize; override;
   {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
   {$ENDIF}
    procedure LoadStrings; override;
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); override;
    procedure UpdatePreview; override;
    procedure UpdateControlsState; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ReportLink: TCustomdxOrgChartReportLink read GetReportLink;
  end;

  PdxOrgChartGetAsGraphicData = ^TdxOrgChartGetAsGraphicData;
  TdxOrgChartGetAsGraphicData = record
    OrgChart: TdxCustomOrgChart;
    GraphicClass: TGraphicClass;
    FullExpand: Boolean;
    Transparent: Boolean;
    TransparentColor: TColor;
    Enhanced: Boolean;
  end;
    
function dxGetOrgChartAsGraphic(const AData: TdxOrgChartGetAsGraphicData): TGraphic;
  
implementation

{$R *.DFM}

uses
  SysUtils, Messages, cxClasses, dxPSRes, dxPSUtl, dxPSGlbl, dxExtCtrls;

type
  TdxOrgChartAccess = class(TdxCustomOrgChart);
  
procedure ProcessPaintMessages;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_NOREMOVE) do
  begin
    case Integer(GetMessage(Msg, 0, WM_PAINT, WM_PAINT)) of
      0: begin
           PostQuitMessage(Msg.wParam);
           Break;
         end;
     -1: Break;
    end;
    DispatchMessage(Msg);
  end;
end;

function dxGetOrgChartAsGraphic(const AData: TdxOrgChartGetAsGraphicData): TGraphic;

  function CreateGraphic(out ACanvas: TCanvas; out AIsBitmap, AIsMetaFile: Boolean): TGraphic;
  begin
    AIsBitmap := AData.GraphicClass.InheritsFrom(TBitmap);
    AIsMetafile := AData.GraphicClass.InheritsFrom(TMetafile);
    if AIsMetafile then 
      Result := TMetafile.Create
    else
      Result := TBitmap.Create;
      
    Result.Width := AData.OrgChart.FullWidth;
    Result.Height := AData.OrgChart.FullHeight;
    if Result is TBitmap then
      ACanvas := TBitmap(Result).Canvas
    else
    begin
      TMetafile(Result).Enhanced := AData.Enhanced;
      ACanvas := TMetafileCanvas.Create(TMetaFile(Result), 0);
    end;
  end;

  procedure DrawOrgChart(ACanvas: TCanvas; AIsMetaFile: Boolean);
  var
    ASavedAntialiazing: Boolean;
    ASavedBorderStyle: TBorderStyle;
    ASavedColor: TColor;
    ASavedLeftEdge, ASavedTopEdge: Integer;
    ASavedOptions: TdxOcOptions;
    ASavedSelected: TdxOcNode;
  begin
    with TdxOrgChartAccess(AData.OrgChart) do
    begin
      ASavedAntialiazing := Antialiasing;
      ASavedBorderStyle := BorderStyle;
      ASavedSelected := Selected;
      ASavedOptions := Options;
      ASavedLeftEdge := LeftEdge;
      ASavedTopEdge := TopEdge;
      ASavedColor := Color;
      try
        LeftEdge := 0;
        TopEdge := 0;
        Selected := nil;
        Color := clNone;
        BorderStyle := bsNone;
        Antialiasing := Antialiasing and not AIsMetaFile;
        Options := Options - [ocAnimate];
        ControlState := ControlState + [csPaintCopy];
        MoveWindowOrg(ACanvas.Handle, LeftEdge, TopEdge);
        PaintWindow(ACanvas.Handle);
        MoveWindowOrg(ACanvas.Handle, -LeftEdge, -TopEdge);
        ControlState := ControlState - [csPaintCopy];
      finally
        Color := ASavedColor;
        BorderStyle := ASavedBorderStyle;
        Antialiasing := ASavedAntialiazing;
        LeftEdge := ASavedLeftEdge;
        TopEdge := ASavedTopEdge;
        Options := ASavedOptions;
        Selected := ASavedSelected;
      end;
    end;
  end;

var
  ACanvas: TCanvas;
  AGraphic: TGraphic;
  AIsBitmap, AIsMetaFile: Boolean;
begin
  Result := nil;
  if Assigned(AData.OrgChart) and Assigned(AData.GraphicClass) then
  try
    if AData.FullExpand then
    begin
      AData.OrgChart.FullExpand;
      ProcessPaintMessages;
    end;

    AGraphic := CreateGraphic(ACanvas, AIsBitmap, AIsMetaFile);
    try
      if not AIsMetafile and AData.Transparent then 
      begin
        ACanvas.Brush.Color := AData.TransparentColor;
        ACanvas.FillRect(Rect(0, 0, AGraphic.Width, AGraphic.Height));
      end;
      DrawOrgChart(ACanvas, AIsMetaFile);
      if AIsBitmap and AData.Transparent then
        TBitmap(AGraphic).TransparentColor := AData.TransparentColor;
    finally
      if AIsMetafile then
        FreeAndNil(ACanvas);
    end;

    if AIsMetafile or AIsBitmap then
      Result := AGraphic
    else
    begin
      Result := dxPSUtl.CreateGraphic(AData.GraphicClass);
      Result.Assign(AGraphic);
      FreeAndNil(AGraphic);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;  
end;
  
{ TCustomdxOrgChartReportLink }

constructor TCustomdxOrgChartReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FFullExpand := False;
  FUseMetafile := True;
end;

procedure TCustomdxOrgChartReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomdxOrgChartReportLink then
    with TCustomdxOrgChartReportLink(Source) do 
    begin
      Self.FullExpand := FullExpand;
      Self.UseMetafile := UseMetafile;
    end;
end;

function TCustomdxOrgChartReportLink.GetGraphic: TGraphic;
var
  Data: TdxOrgChartGetAsGraphicData;
begin
  Result := nil;
  if (OrgChart = nil) or (OrgChart.Count = 0) then Exit;
  FillChar(Data, SizeOf(TdxOrgChartGetAsGraphicData), 0);
  Data.OrgChart := OrgChart;
  Data.GraphicClass := GetGraphicClass;
  Data.FullExpand := FullExpand;
  Data.Transparent := Transparent;
  Data.TransparentColor := TransparentColor;
  Data.Enhanced := True;
  Result := dxGetOrgChartAsGraphic(Data);
end;

function TCustomdxOrgChartReportLink.GetGraphicClass: TGraphicClass;
const
  GraphicClasses: array[Boolean] of TGraphicClass = (TBitmap, TMetafile);
begin
  Result := GraphicClasses[UseMetafile];
end;

procedure TCustomdxOrgChartReportLink.InternalRestoreDefaults;
begin
  inherited;
  FullExpand := False;
  UseMetafile := True;
end;

procedure TCustomdxOrgChartReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  if OrgChart <> nil then TransparentColor := OrgChart.Color;
end;

procedure TCustomdxOrgChartReportLink.SetFullExpand(Value: Boolean);
begin
  if FFullExpand <> Value then
  begin
    FFullExpand := Value;
    LinkModified(True);
  end;
end;

function TCustomdxOrgChartReportLink.GetOrgChart: TdxOrgChart;
begin
  Result := TdxOrgChart(Component);
end;

{ TdxOCReportLinkDesignWindow }

constructor TdxOCReportLinkDesignWindow.Create(AOwner: TComponent);

  function CreatePreviewBitmap: TBitmap;
  begin
    Result := TBitmap.Create;
    try
      ocPreview.FullExpand;
      Result.Width := ocPreview.FullWidth + 1;
      Result.Height := ocPreview.FullHeight + 1;
      Control_PaintWindow(ocPreview, Result.Canvas.Handle);
    except
      FreeAndNil(Result);
      raise;
    end;  
  end;
  
begin
  HelpContext := dxhcOrgChartReportLinkDesigner;
  inherited;
  CreateControls;
  PageControl1.ActivePage := PageControl1.Pages[0];

  FOCBmp := CreatePreviewBitmap;
end;

destructor TdxOCReportLinkDesignWindow.Destroy;
begin
  FreeAndNil(FOCBmp);
  inherited;
end;

procedure TdxOCReportLinkDesignWindow.CreateControls;
var
  R: TRect;
begin
  ccbxColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(ccbxColor) do
  begin
    BoundsRect := bvlColorHolder.BoundsRect;
    Tag := MakeTTag(0);
    Parent := gbxTransparent;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultColor;
//    DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  lblColor.FocusControl := ccbxColor;

  ccbxGridLineColor := TdxPSColorCombo.Create(Self);
  with TdxPSColorCombo(ccbxGridLineColor) do
  begin
    BoundsRect := bvlLineColorHolder.BoundsRect;
    Tag := MakeTTag(1);
    Parent := gbxBorder;
    ColorTypes := [ctPure];
    ShowColorName := True;
    ShowAutoColor := True;
    AutoColor := dxDefaultGridLineColor;
//    DropDownCount := Items.Count;
    OnChange := ccbxColorChange;
  end;
  lblGridLinesColor.FocusControl := ccbxGridLineColor;
  FPreviewBox := TdxPSPaintPanel.Create(Self);
  with TdxPSPaintPanel(FPreviewBox) do
  begin
    Parent := pnlPreview;
    R := pnlPreview.BoundsRect;
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -4, -4);
    BoundsRect := R;
    EdgeInner := esNone;
    EdgeOuter := esNone;
    OnPaint := pbxPreviewPaint;
  end;
end;

{$IFDEF DELPHI7}
function TdxOCReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TdxOCReportLinkDesignWindow.LoadStrings;
var
  Item: TdxOcNode;
begin
  inherited;
  tshOptions.Caption := cxGetResourceString(@sdxOptions);

  Item := ocPreview.Items[0];
  Item.Text := cxGetResourceString(@sdxCorporateHeadquarters); 
  Item[0].Text := cxGetResourceString(@sdxSalesAndMarketing);
  Item[0].Items[0].Text := cxGetResourceString(@sdxFieldOfficeCanada);
  Item[1].Text := cxGetResourceString(@sdxEngineering);
  
  stDrawBorder.Caption := ' ' + cxGetResourceString(@sdxBorderLines) + ' ';
  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));
end;

procedure TdxOCReportLinkDesignWindow.DoInitialize;
begin
  inherited;
  gbxTransparent.Visible := not ReportLink.UseMetafile;
  chbxTransparent.Visible := not ReportLink.UseMetafile;
  stTransparent.Visible := not ReportLink.UseMetafile;
  if ReportLink.UseMetafile then 
  begin
    stDrawBorder.BoundsRect := stTransparent.BoundsRect;
    chbxDrawBorder.BoundsRect := chbxTransparent.BoundsRect;
    gbxBorder.BoundsRect := gbxTransparent.BoundsRect;
  end;
    
  chbxFullExpand.Checked := ReportLink.FullExpand;
  chbxDrawBorder.Checked := ReportLink.DrawBorder;
  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(ccbxColor).ColorValue := ReportLink.Color;
  TdxPSColorCombo(ccbxGridLineColor).ColorValue := ReportLink.BorderColor;
end;

procedure TdxOCReportLinkDesignWindow.UpdateControlsState;
begin
  inherited;
  ccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := not chbxTransparent.Checked;
  ccbxGridLineColor.Enabled := chbxDrawBorder.Checked;
  lblGridLinesColor.Enabled := chbxDrawBorder.Checked;
end;

procedure TdxOCReportLinkDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TdxOCReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
var
  OffsetX, OffsetY: Integer;
begin
  inherited;
  OffsetRect(R, -R.Left, -R.Top);
  InflateRect(R, -4, -4);
  
  ACanvas.Brush.Style := bsSolid;
  { border }
  if ReportLink.DrawBorder then
  begin
    InflateRect(R, 1, 1);
    ACanvas.Brush.Color := ReportLink.BorderColor;
    ACanvas.FrameRect(R);
    InflateRect(R, -1, -1);
  end;
  { interior }
  if not ReportLink.Transparent then
  begin
    ACanvas.Brush.Color := ReportLink.Color;
    ACanvas.FillRect(R);
  end;
  { charts }
  OffsetX := R.Left + (R.Right - R.Left - FOCBmp.Width) div 2;
  OffsetY := R.Top + (R.Bottom - R.Top - FOCBmp.Height) div 2;
  ACanvas.Brush.Style := bsClear;
  ACanvas.BrushCopy(Bounds(OffsetX, OffsetY, FOCBmp.Width, FOCBmp.Height),
    FOCBmp, Rect(0, 0, FOCBmp.Width, FOCBmp.Height),
    FOCBmp.Canvas.Pixels[0, FOCBmp.Height - 1]);
end;

function TdxOCReportLinkDesignWindow.GetReportLink: TCustomdxOrgChartReportLink;
begin
  Result := inherited ReportLink as TCustomdxOrgChartReportLink;
end;

procedure TdxOCReportLinkDesignWindow.ccbxColorChange(Sender: TObject);
var
  AColor: TColor;
begin
  if LockControlsUpdate then Exit;
  AColor := TdxPSColorCombo(Sender).ColorValue;
  case TTagToInt(TdxPSColorCombo(Sender).Tag) of
    0: ReportLink.Color := AColor;
    1: ReportLink.BorderColor := AColor;
  end;
  Modified := True;
  UpdatePreview; 
end;

procedure TdxOCReportLinkDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;
  
procedure TdxOCReportLinkDesignWindow.lblColorClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxOCReportLinkDesignWindow.chbxFullExpandClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.FullExpand := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview; 
end;

procedure TdxOCReportLinkDesignWindow.chbxDrawBorderClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.DrawBorder := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview; 
end;

procedure TdxOCReportLinkDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.Transparent := TCheckBox(Sender).Checked;
  Modified := True;
  UpdatePreview; 
end;

procedure TdxOCReportLinkDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxOCReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;

procedure TdxOCReportLinkDesignWindow.stDrawBorderClick(Sender: TObject);
begin
  if chbxDrawBorder.CanFocus then ActiveControl := chbxDrawBorder;
  chbxDrawBorder.Checked := not chbxDrawBorder.Checked;
end;

procedure TdxOCReportLinkDesignWindow.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with PageControl1 do
    for I := 0 to PageCount - 1 do
      if IsAccel(Message.CharCode, Pages[I].Caption) then
      begin
        Message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

initialization
  dxPSRegisterReportLink(TdxOrgChartReportLink, TdxOrgChart, TdxOCReportLinkDesignWindow);

finalization
  dxPSUnregisterReportLink(TdxOrgChartReportLink, TdxOrgChart, TdxOCReportLinkDesignWindow);

end.

 
