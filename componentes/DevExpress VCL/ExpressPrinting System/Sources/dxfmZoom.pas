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

unit dxfmZoom;

interface

{$I cxVer.inc}

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls, 
  ComCtrls, Commctrl, Buttons, ImgList, dxExtCtrls, dxPreVw, dxPSForm;

type
  TfmZoom = class(TCustomdxPSForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxPreview: TGroupBox;
    btnHelp: TButton;
    Panel1: TPanel;
    stxtFontPreview: TStaticText;
    gbxZoomTo: TGroupBox;
    rbtn500: TRadioButton;
    rbtn200: TRadioButton;
    rbtn150: TRadioButton;
    rbtn100: TRadioButton;
    rbtn75: TRadioButton;
    rbtn50: TRadioButton;
    rbtn10: TRadioButton;
    rbtn25: TRadioButton;
    rbtnTwoPages: TRadioButton;
    rbtnWholePage: TRadioButton;
    rbtnPageWidth: TRadioButton;
    rbtnFourPages: TRadioButton;
    rbtnManyPages: TRadioButton;
    lblPercent: TLabel;
    bvlPercentHolder: TBevel;
    bvlFontPreviewHolder: TBevel;
    bvlPreviewHolder: TBevel;
    btnManyPages: TBitBtn;
    ilStub: TImageList;
    procedure lblPercentClick(Sender: TObject);
    procedure rbtnClick(Sender: TObject);
    procedure btnManyPagesClick(Sender: TObject);
  private
    FModified: Boolean;
    FpnlFontPreview: TCustomControl;
    FpnlPreview: TCustomControl;
    FPreview: TdxPreview;
    FPreviewOwnerSize: TPoint;
    FsePercent: TCustomEdit;
    FUpdateCount: Integer;
    procedure FontPreviewPaint(Sender: TObject);
    procedure PercentButtonClick(Sender: TObject; ButtonType: TdxButtonType; Button: TUDBtnType);
    procedure PercentChange(Sender: TObject);
    procedure PercentExit(Sender: TObject);
    procedure PreviewPaint(Sender: TObject);
    procedure SetZoomFactor(Value: Integer);
    procedure ZoomKeyPress(Sender: TObject; var Key: Char);
  protected
    procedure BeginUpdate;
    procedure EndUpdate;
    
    procedure CreateControls; virtual;
    procedure InitControls; virtual;    
    procedure InitPreview(APreview: TdxPreview);
    procedure LoadStrings; virtual;
    procedure UpdateControlsState;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean;  
  end;

function dxZoomDlg(APreview: TdxPreview): Boolean;

implementation

{$R *.DFM}

uses
  //Variants,
  Math, cxClasses, dxPSGlbl, dxPSImgs, dxPSRes, dxPSUtl, dxfmMnPg,
  dxCore, cxDrawTextUtils;
  
type
  TdxPreviewAccess = class(TdxPreview);
  
function dxZoomDlg(APreview: TdxPreview): Boolean;
var
  Form: TfmZoom;
begin
  Form := TfmZoom.Create(nil);
  try
    with Form do
    begin
      CreateControls;
      InitPreview(APreview);
      if (APreview.Owner <> nil) and (APreview.Owner is TControl) then
        FPreviewOwnerSize := MakePoint(TControl(APreview.Owner).Width, TControl(APreview.Owner).Height)
      else
        FPreviewOwnerSize := MakePoint(APreview.Width, APreview.Height);
      Result := Execute;
      if Result then
      begin
        APreview.ZoomMode := FPreview.ZoomMode;
        APreview.SetPageXYCount(FPreview.ColCount, FPreview.RowCount);
        APreview.ZoomFactor := FPreview.ZoomFactor;
      end;
    end;
  finally
    Form.Free;
  end;
end;

{ TfmZoom }

constructor TfmZoom.Create(AOwner: TComponent);
begin
  inherited;
  HelpContext := dxhcZoomDlg;
  if HelpContext <> 0 then
    BorderIcons := BorderIcons + [biHelp];
  btnHelp.Visible := HelpContext <> 0;
  if not btnHelp.Visible then
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnHelp.BoundsRect;
  end;
  FPreview := TdxPreview.Create(Self);
  FPreview.Visible := False;
  FPreview.MinZoomFactor := 10;
  FPreview.Parent := Self;
end;

function TfmZoom.Execute: Boolean;
begin
  LoadStrings;
  InitControls;
  FModified := False;
  UpdateControlsState;
  Result := (ShowModal = mrOK) and FModified;
end;

procedure TfmZoom.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TfmZoom.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    FpnlFontPreview.Invalidate;
    FpnlPreview.Invalidate;
  end;
end;

procedure TfmZoom.CreateControls;
begin
  FsePercent := TdxPSSpinEdit.Create(Self);
  with TdxPSSpinEdit(FsePercent) do
  begin
    Parent := gbxZoomTo;
    BoundsRect := bvlPercentHolder.BoundsRect;
    MinValue := FPreview.MinZoomFactor;
    MaxValue := FPreview.MaxZoomFactor;
    Value := FPreview.ZoomFactor;
    LegendText := PercentSymbol;
    OnKeyPress := ZoomKeyPress;
    OnButtonClick := PercentButtonClick;
    OnExit := PercentExit;
    OnChange := PercentChange;
  end;
  lblPercent.FocusControl := FsePercent;

  FpnlPreview := TdxPSPaintPanel.Create(Self);
  with TdxPSPaintPanel(FpnlPreview) do
  begin
    Parent := gbxPreview;
    BoundsRect := bvlPreviewHolder.BoundsRect;
    OnPaint := PreviewPaint;
    EdgeInner := esNone;
    EdgeOuter := esNone;
  end;

  FpnlFontPreview := TdxPSPaintPanel.Create(Self);
  with TdxPSPaintPanel(FpnlFontPreview) do
  begin
    Parent := gbxPreview;
    BoundsRect := bvlFontPreviewHolder.BoundsRect;
    OnPaint := FontPreviewPaint;
    EdgeInner := esNone;
    EdgeOuter := esNone;
  end;
end;

procedure TfmZoom.InitControls;
var
  I: Integer;
  Control: TControl;
begin
  case FPreview.ZoomMode of
    pzmNone:
      begin
        rbtn500.Checked := FPreview.ZoomFactor = 500;
        rbtn200.Checked := FPreview.ZoomFactor = 200;
        rbtn150.Checked := FPreview.ZoomFactor = 150;
        rbtn100.Checked := FPreview.ZoomFactor = 100;
        rbtn75.Checked := FPreview.ZoomFactor = 75;
        rbtn50.Checked := FPreview.ZoomFactor = 50;
        rbtn25.Checked := FPreview.ZoomFactor = 25;
        rbtn10.Checked := FPreview.ZoomFactor = 10;
        for I := 0 to gbxZoomTo.ControlCount - 1 do
        begin
          Control := gbxZoomTo.Controls[I];
          if (Control is TRadioButton) and TRadioButton(Control).Checked then 
          begin 
            ActiveControl := TWinControl(Control);
            Break;
          end;
        end; 
        TdxPSSpinEdit(FsePercent).Value := FPreview.ZoomFactor;
      end;
      
    pzmPageWidth:
      rbtnPageWidth.Checked := True;
      
    pzmPages:
      begin
        rbtnWholePage.Checked := FPreview.ColCount = 1;
        rbtnTwoPages.Checked := FPreview.ColCount = 2;
        rbtnFourPages.Checked := FPreview.ColCount = 4;
        rbtnManyPages.Checked := not (FPreview.ColCount in [1, 2, 4]);
      end;  
  end;
  rbtnTwoPages.Enabled := FPreview.PageCount > 1;
  rbtnFourPages.Enabled := FPreview.PageCount > 3;
end;

procedure TfmZoom.InitPreview(APreview: TdxPreview);
var
  I: Integer;
begin
  FPreview.MeasurementUnits := APreview.MeasurementUnits;
  FPreview.Orientation := APreview.Orientation;
  FPreview.OriginalPageSize := APreview.OriginalPageSize;
  for I := 0 to APreview.PageCount - 1 do
    TdxPreviewAccess(FPreview).CreatePage;
  FPreview.PageXCount := APreview.PageXCount;
  FPreview.PageYCount := APreview.PageYCount;
  FPreview.Width := APreview.Width;
  FPreview.Height := APreview.Height;
  FPreview.ZoomFactor := APreview.ZoomFactor;
  FPreview.ZoomMode := APreview.ZoomMode;
end;

procedure TfmZoom.LoadStrings;
begin
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);

  Caption := cxGetResourceString(@sdxZoomDlgCaption);
  gbxZoomTo.Caption := cxGetResourceString(@sdxZoomDlgZoomTo);
  rbtnPageWidth.Caption := cxGetResourceString(@sdxZoomDlgPageWidth);
  rbtnWholePage.Caption := cxGetResourceString(@sdxZoomDlgWholePage);
  rbtnTwoPages.Caption := cxGetResourceString(@sdxZoomDlgTwoPages);
  rbtnFourPages.Caption := cxGetResourceString(@sdxZoomDlgFourPages);
  rbtnManyPages.Caption := cxGetResourceString(@sdxZoomDlgManyPages);
  lblPercent.Caption := cxGetResourceString(@sdxZoomDlgPercent);
  gbxPreview.Caption := cxGetResourceString(@sdxZoomDlgPreview);
  stxtFontPreview.Caption := cxGetResourceString(@sdxZoomDlgFontPreview);
end;

procedure TfmZoom.UpdateControlsState;
begin
  //btnOK.Enabled := FModified;
end;

procedure TfmZoom.SetZoomFactor(Value: Integer);
begin
  TdxPSSpinEdit(FsePercent).AsInteger := Value;
  FPreview.ZoomFactor := Value;
  FpnlFontPreview.Invalidate;
  FpnlPreview.Invalidate;
end;

procedure TfmZoom.lblPercentClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
end;

procedure TfmZoom.rbtnClick(Sender: TObject);
const
  cZoomFactors: array[0..7] of Integer = (500, 200, 150, 100, 75, 50, 25, 10);
var
  T: Longint;
begin
  T := TTagToInt(TComponent(Sender).Tag);
  if T < 8 then
  begin
    TdxPSSpinEdit(FsePercent).AsInteger := cZoomFactors[T];
    FPreview.ZoomMode := pzmNone;
    SetZoomFactor(cZoomFactors[T]);
  end
  else 
    if T < 12 then
    begin
      SetZoomFactor(FPreview.ZoomFactor);
      if T = 8 then
        FPreview.ZoomMode := pzmPageWidth
      else
      begin
        FPreview.ZoomMode := pzmPages;
        case T of
          9: FPreview.SetPageXYCount(1, 1);
          10: FPreview.SetPageXYCount(2, 1);
          11: FPreview.SetPageXYCount(2, 2);
        end;
      end;
      SetZoomFactor(FPreview.ZoomFactor);
    end
    else
      SetZoomFactor(FPreview.ZoomFactor);
  FModified := True;
  UpdateControlsState;
end;

procedure TfmZoom.PercentChange(Sender: TObject);
begin
  FModified := True;
  UpdateControlsState;
end;

procedure TfmZoom.PercentExit(Sender: TObject);
begin
  SetZoomFactor(TdxPSSpinEdit(Sender).AsInteger);
end;

procedure TfmZoom.ZoomKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then
  begin
    SetZoomFactor(TdxPSSpinEdit(Sender).AsInteger);
    UpdateControlsState;
  end;
end;

procedure TfmZoom.PercentButtonClick(Sender: TObject; ButtonType: TdxButtonType; Button: TUDBtnType);
begin
  BeginUpdate;
  try
    with TdxPSSpinEdit(Sender) do 
    begin 
      SetZoomFactor(AsInteger);
      rbtn500.Checked := AsInteger = 500;
      rbtn200.Checked := AsInteger = 200;
      rbtn150.Checked := AsInteger = 150;
      rbtn100.Checked := AsInteger = 100;
      rbtn75.Checked := AsInteger = 75;
      rbtn50.Checked := AsInteger = 50;
      rbtn25.Checked := AsInteger = 25;
      rbtn10.Checked := AsInteger = 10;
    end;  
  finally
    EndUpdate;
  end;
end;

procedure TfmZoom.btnManyPagesClick(Sender: TObject);
var
  AOrigin: TPoint;
  AYShift: Integer;
  AMaxColCount, AMaxRowCount: Integer;
  ARowCount, AColCount: Integer;
begin
  AOrigin := TButton(Sender).ClientOrigin;
  AYShift := TButton(Sender).Height;
  Inc(AOrigin.Y, AYShift);
  {
  AMaxColCount := Floor((FPreview.Width - 2 * FPreview.Indent) /
    (FPreview.Indent + MulDiv(FPreview.PageSize.X, FPreview.MinZoomFactor, 100)));
  AMaxRowCount := Floor((FPreview.Height - 2 * FPreview.Indent) /
    (FPreview.Indent + MulDiv(FPreview.PageSize.Y, FPreview.MinZoomFactor, 100)));
   } 
  AMaxColCount := FPreview.Width div MulDiv(FPreview.PageSize.X, FPreview.MinZoomFactor, 100);
  AMaxRowCount := FPreview.Height div MulDiv(FPreview.PageSize.Y, 2 * FPreview.MinZoomFactor, 100);
  if AMaxColCount = 0 then 
    AMaxColCount := 1;
  if AMaxRowCount = 0 then 
    AMaxRowCount := 1;
    
  if AMaxColCount > 3 then
    AColCount := 3
  else
    AColCount := AMaxColCount;
    
  if AMaxRowCount > 3 then
    ARowCount := 2
  else
    ARowCount := AMaxRowCount;
    
  if dxChooseMultiplePages(ilStub, 0, AOrigin, AYShift, AMaxColCount,
    AMaxRowCount, AColCount, ARowCount) then
  begin
    FPreview.ZoomMode := pzmPages;
    FPreview.SetPageXYCount(AColCount, ARowCount);
    if rbtnManyPages.Checked then
    begin
      SetZoomFactor(FPreview.ZoomFactor);
      FModified := True;
      UpdateControlsState;
    end
    else
      rbtnManyPages.Checked := True;
  end;
end;

procedure TfmZoom.PreviewPaint(Sender: TObject);
const
  ScreenRect: TRect = (Left: 12; Top: 10; Right: 170; Bottom: 93);
  Offset: TPoint = (X: 10; Y: 2);
var
  ADesktop, DestR, R, R2: TRect;
  I, AWidth, AHeight, W, H, V: Integer;
  DC: HDC;
  Rgn: HRGN;

  function MapRect(const ARect: TRect): TRect;
  begin
    Result := ScaleRect(ARect, DestR.Right - DestR.Left, FPreview.Width,
      DestR.Right - DestR.Left, FPreview.Width);
  end;

  procedure DrawBorder;
  var
    R2: TRect;
  begin
    R2 := R;
    FrameRect(DC, R2, GetSysColorBrush(COLOR_3DDKSHADOW));
    InflateRect(R2, -1, -1);
    FrameRect(DC, R2, GetSysColorBrush(COLOR_3DDKSHADOW));
    InflateRect(R2, -1, -1);
    FillRect(DC, R2, HBRUSH(COLOR_BTNSHADOW + 1));
  end;

  procedure DrawMonitor;
  var
    R2, R3: TRect;
    L: Integer;
    Pen: HPEN;
    Brush: HBRUSH;
  begin
    { Monitor }
    R2 := R;
    R2.Bottom := MulDiv(R2.Bottom, 104, 122);
    DrawEdge(DC, R2, EDGE_RAISED, BF_RECT);
    InflateRect(R2, -11, -10);
    Dec(R2.Bottom);
    DrawEdge(DC, R2, BDR_SUNKENOUTER, BF_RECT or BF_MONO);
    Inc(R2.Bottom);
    InflateRect(R2, 11, 10);
    { Under Screen Side Borders }
    L := R.Left + MulDiv(R.Right - R.Left, 35, R.Right - R.Left);
    FillRect(DC, MakeBounds(L + 1, R2.Bottom, 1, 4), GetSysColorBrush(COLOR_3DDKSHADOW));
    FillRect(DC, MakeBounds(R.Right - L - 1, R2.Bottom, 1, 4), GetSysColorBrush(COLOR_3DDKSHADOW));
    R2 := MakeRect(L, R2.Bottom, R.Right - L, MulDiv(R.Bottom, 108, 122));
    { Interior }
    R3 := R2;
    InflateRect(R2, -3, 0);
    Inc(R2.Left);
    Dec(R2.Bottom);
    FillRect(DC, MakeRect(R2.Left, R2.Top, R2.Right, R2.Top + 2), GetSysColorBrush(COLOR_BTNSHADOW));
    FillRect(DC, MakeBounds(R2.Right, R2.Top, 2, 4), GetSysColorBrush(COLOR_BTNSHADOW));
    FillRect(DC, MakeBounds(R2.Left - 2, R2.Bottom - 1, 2, 2), GetSysColorBrush(COLOR_BTNHIGHLIGHT));
    Dec(R2.Left);
    InflateRect(R2, -3, 0);
    OffsetRect(R2, 0, 6);
    Dec(R2.Bottom);
    { Right Side }
    MoveToEx(DC, R3.Right - 1, R3.Bottom - 1, nil);
    LineTo(DC, R2.Right - 1, R2.Bottom + 1);
    Pen := SelectObject(DC, CreatePen(PS_SOLID, 0, GetSysColor(COLOR_BTNSHADOW)));
    MoveToEx(DC, R3.Right - 2, R3.Bottom - 1, nil);
    LineTo(DC, R2.Right - 2, R2.Bottom + 1);
    MoveToEx(DC, R3.Right - 2, R3.Bottom - 2, nil);
    LineTo(DC, R2.Right - 2, R2.Bottom);
    MoveToEx(DC, R3.Right - 2, R3.Bottom - 3, nil);
    LineTo(DC, R2.Right - 2, R2.Bottom - 1);
    DeleteObject(SelectObject(DC, Pen));
    { Left Side }
    MoveToEx(DC, R3.Left + 1, R3.Bottom - 1, nil);
    LineTo(DC, R2.Left + 1, R2.Bottom + 1);
    Pen := SelectObject(DC, CreatePen(PS_SOLID, 0, GetSysColor(COLOR_BTNHIGHLIGHT)));
    MoveToEx(DC, R3.Left + 2, R3.Bottom - 1, nil);
    LineTo(DC, R2.Left + 2, R2.Bottom + 1);
    MoveToEx(DC, R3.Left + 2, R3.Bottom - 2, nil);
    LineTo(DC, R2.Left + 2, R2.Bottom);
    DeleteObject(SelectObject(DC, Pen));
    R3 := R2;
    { Button }
    R2 := MakeBounds(R2.Right - 19, R2.Top - 5, 10, 4);
    DrawEdge(DC, R2, BDR_RAISEDINNER, BF_LEFT or BF_RIGHT or BF_BOTTOM);
    FillRect(DC, MakeBounds(R2.Left, R2.Top, 10, 1), HBRUSH(COLOR_BTNFACE + 1));
    { Spot }
    InflateRect(R2, -3, 0);
    OffsetRect(R2, -11, 0);
    DrawEdge(DC, R2, BDR_SUNKENOUTER, BF_RECT or BF_SOFT);
    InflateRect(R2, -1, -1);
    Brush := CreateSolidBrush(clLime);
    FillRect(DC, R2, Brush);
    DeleteObject(Brush);
    R2 := R3;

    FillRect(DC, R2, GetSysColorBrush(COLOR_BTNSHADOW));
    OffsetRect(R2, 0, 2);
    Dec(R2.Bottom);
    FillRect(DC, R2, GetSysColorBrush(COLOR_3DDKSHADOW));
    InflateRect(R2, -4, 0);
    Inc(R2.Top, 1);
    Inc(R2.Bottom, 4);
    DrawEdge(DC, R2, BDR_SUNKENOUTER, BF_FLAT or BF_MONO or BF_LEFT or BF_RIGHT);
    R3 := R2;
    { Interior }
    InflateRect(R2, -1, -1);
    OffsetRect(R2, 0, -1);
    Inc(R2.Left, 2);
    FillRect(DC, R2, HBRUSH(COLOR_BTNSHADOW + 1));
    FillRect(DC, MakeBounds(R2.Right - 2, R2.Bottom, 2, 2), GetSysColorBrush(COLOR_BTNSHADOW));
    FillRect(DC, MakeBounds(R2.Left - 2, R2.Bottom, 2, 2), GetSysColorBrush(COLOR_BTNHIGHLIGHT));
    { Bottom }
    R2 := R3;
    InflateRect(R2, (R2.Left - R.Left) div 2, 0);
    OffsetRect(R2, 0, 4);
    Inc(R2.Bottom, 1);
    DrawButtonFace(TdxPSPaintPanel(Sender).Canvas, R2, 0, bsWin31, True, False, False);
    Inc(R2.Left);
    Inc(R2.Top);
    DrawEdge(DC, R2, EDGE_RAISED, BF_SOFT or BF_RECT);
    SetPixel(DC, R2.Right - 1, R2.Bottom - 1, GetSysColor(COLOR_BTNFACE));
  end;

begin
  if FUpdateCount <> 0 then Exit;
  ADesktop := GetDesktopWorkArea;
  with TdxPSPaintPanel(Sender) do
  begin
    Windows.GetClientRect(Handle, R);
    DC := Canvas.Handle;
  end;
  FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  DrawMonitor;
  AWidth := MulDiv(ScreenRect.Right - ScreenRect.Left - 2 * Offset.X,
    FPreviewOwnerSize.X, ADesktop.Right - ADesktop.Left);
  AHeight := MulDiv(ScreenRect.Bottom - ScreenRect.Top - 2 * Offset.Y,
    FPreviewOwnerSize.Y, ADesktop.Bottom - ADesktop.Top);

  with ScreenRect do
  begin
    W := Right - Left;
    H := Bottom - Top;
    if AWidth / AHeight > W / H then
    begin
      V := MulDiv(AHeight, W, AWidth);
      R := Bounds(Left, Top + (H - V) div 2, W, V);
    end
    else
    begin
      V := MulDiv(AWidth, H, AHeight);
      R := Bounds(Left + (W - V) div 2, Top, V, H);
    end;
  end;
  DestR := R;
  DrawBorder;

  InflateRect(R, -1, -1);
  Dec(R.Top);

  Rgn := dxPSUtl.IntersectCliprect(DC, R);

  FPreview.CalcPagesBounds(FPreview.TopPos, FPreview.VirtualWidth, FPreview.VirtualHeight);
  for I := 0 to FPreview.PageCount - 1 do
  begin
    R := MapRect(FPreview.Pages[I].Bounds);
    OffsetRect(R, 0, 4);
    if (R.Right - R.Left) < (DestR.Right - DestR.Left) then
      OffsetRect(R, 1, 0);
    OffsetRect(R, DestR.Left, DestR.Top);
    if IntersectRect(R2, R, DestR) then
      DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT or BF_MIDDLE or BF_MONO);
  end;

  dxPSUtl.RestoreClipRgn(DC, Rgn);
end;

procedure TfmZoom.FontPreviewPaint(Sender: TObject);
const
  Format = CXTO_PATTERNEDTEXT or CXTO_CENTER_HORIZONTALLY or CXTO_WORDBREAK or CXTO_CHARBREAK;
var
  Template, S: string;
  I: Integer;
  R: TRect;
begin
  if FUpdateCount <> 0 then Exit;
  
  Template := cxGetResourceString(@sdxZoomDlgFontPreviewString);
  S := '';
  for I := 0 to 6 do
  begin
    S := S + Template;
    if I <> 6 then S := S + #13#10;
  end;  

  with TdxPSPaintPanel(Sender), Canvas do
  begin
    R := ClientRect;  
    Inc(R.Top, 2);
    
    Brush.Color := clWindowText;
    FrameRect(R);
    InflateRect(R, -1, -1);
    Brush.Color := clWindow;
    FillRect(R);    
    
    Font.Size := Round(12 * FPreview.ZoomFactor / 100);
    Font.Name := 'Times New Roman';
    cxTextOut(Handle, S, R, Format, nil, 0, 0);
  end;
end;

end.

