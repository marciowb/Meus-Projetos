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

unit dxfmMnPg;

interface

{$I cxVer.inc}

uses
  Windows, Classes, Controls, ImgList, Graphics, cxGeometry;

function dxChooseMultiplePages(AImageList: TCustomImageList; AImageIndex: Integer; 
  AOrigin: TPoint; AYShift: Integer; AMaxColCount, AMaxRowCount: Integer;
  var AColCount, ARowCount: Integer): Boolean;

implementation

uses
  cxControls, Messages, SysUtils, Forms, CommCtrl, Math, cxClasses, dxPSGlbl,
  dxPSEngn, dxPSRes, dxPSUtl, cxGraphics, cxLookAndFeelPainters;

const
  CellSize = 26;

type
  TdxGrowDirection = (gdTopLeft, gdTopRight, gdBottomRight, gdBottomLeft);

  TfmPageChooser = class(TCustomForm)
  private
    FColCount: Integer;
    FDesktop: TRect;
    FGrowDirection: TdxGrowDirection;
    FilCell: TCustomImageList;
    FImageIndex: Integer;
    FIsMousePressed: Boolean;
    FIsTextAtBottom: Boolean;
    FLastMousePos: TPoint;
    FMaxColCount: Integer;
    FMaxRowCount: Integer;
    FResult: TModalResult;
    FRowCount: Integer;
    FSelectedColCount: Integer;
    FSelectedRowCount: Integer;
    function GetBottomBounds: TRect;
    function GetBottomHeight: Integer;
    function GetCellBounds(ACol, ARow: Integer): TRect;
    function GetCellHeight: Integer;
    function GetCellWidth: Integer;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetSelectedBounds: TRect;
    function IsSelectedCell(ACol, ARow: Integer): Boolean;
    procedure SetColCount(Value: Integer);
    procedure SetRowCount(Value: Integer);
    procedure SetSelectedCells(ACol, ARow: Integer);
    procedure SetSelectedColCount(Value: Integer);
    procedure SetSelectedRowCount(Value: Integer);
    
    procedure DoSelectCells(X, Y: Integer);
    procedure ProcessKey(var Key: Word);    
    procedure ProcessSelect(AColCount, ARowCount: Integer; GrowFlag: Boolean);    
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawBottomPart(ACanvas: TcxCanvas; const R: TRect);
    procedure DrawCell(ACanvas: TcxCanvas; ACol, ARow: Integer);
    procedure DrawCells(ACanvas: TcxCanvas);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    property BottomBounds: TRect read GetBottomBounds;
    property BottomHeight: Integer read GetBottomHeight;
    property CellHeight: Integer read GetCellHeight;
    property CellWidth: Integer read GetCellWidth;
    property ColCount: Integer read FColCount write SetColCount;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
    property MaxColCount: Integer read FMaxColCount;
    property MaxRowCount: Integer read FMaxRowCount;
    property RowCount: Integer read FRowCount write SetRowCount;
    property SelectedBounds: TRect read GetSelectedBounds;
    property SelectedColCount: Integer read FSelectedColCount write SetSelectedColCount;
    property SelectedRowCount: Integer read FSelectedRowCount write SetSelectedRowCount;
  public
    constructor CreateEx(const P: TPoint);
    property Height;
    property MouseCapture;
    property Width;
  end;

function dxChooseMultiplePages(AImageList: TCustomImageList; AImageIndex: Integer; 
  AOrigin: TPoint; AYShift: Integer; AMaxColCount, AMaxRowCount: Integer;
  var AColCount, ARowCount: Integer): Boolean;
var
  AForm: TfmPageChooser;
begin
  AForm := TfmPageChooser.CreateEx(AOrigin);
  try
    with AForm do
    begin
      FilCell := AImageList;
      FImageIndex := AImageIndex;
      FMaxColCount := AMaxColCount;
      FMaxRowCount := AMaxRowCount;

      if (AOrigin.Y + AColCount * CellWidth + 4 {non client} + 2 {frame} > FDesktop.Bottom) then
        if (AOrigin.X + AColCount * CellWidth + 4 {non client} + 2 {frame} > FDesktop.Right) then
          FGrowDirection := gdTopLeft
        else
          FGrowDirection := gdTopRight
      else
        if (AOrigin.X + AColCount * CellWidth + 4 {non client} + 2 {frame} > FDesktop.Right) then
          FGrowDirection := gdBottomLeft
        else
          FGrowDirection := gdBottomRight;
          
      if (FGrowDirection in [gdTopLeft, gdBottomLeft]) then
        Left := FDesktop.Right - Width;
        
      if (FGrowDirection in [gdTopLeft, gdTopRight]) then
        Top := Top - Height - AYShift;
      FIsTextAtBottom := FGrowDirection in [gdBottomRight, gdBottomLeft];
      ColCount := AColCount;
      RowCount := ARowCount;

      Show;
      MouseCapture := True;
      try
        while FResult = mrNone do Application.ProcessMessages;
      finally
        MouseCapture := False;
      end;
      Result := (FResult = mrOK) and (SelectedColCount > 0) and (SelectedRowCount > 0);
      if Result then
      begin
        AColCount := SelectedColCount;
        ARowCount := SelectedRowCount;
      end;
    end
  finally
    AForm.Free;
  end;
end;

{ TfmPageChooser }

constructor TfmPageChooser.CreateEx(const P: TPoint);
begin
  CreateNew(nil, 0);
{$IFDEF DELPHI9}
  Position := poDesigned;
  PopupMode := pmAuto;
{$ENDIF}
  BorderStyle := bsNone;
  BorderIcons := [];
  FIsMousePressed := False;
  FIsTextAtBottom := True;
  FDesktop := GetDesktopWorkArea(P);
  SetBounds(P.X, P.Y, Width, Height);
end;

procedure TfmPageChooser.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style or CS_SAVEBITS;
end;

procedure TfmPageChooser.DrawBottomPart(ACanvas: TcxCanvas; const R: TRect);

  function GetText: string;
  begin
    if (SelectedRowCount > 0) and (SelectedColCount > 0) then
      Result := Format('%d x %d %s', [SelectedRowCount, SelectedColCount, cxGetResourceString(@sdxPages)])
    else
      Result := cxGetResourceString(@sdxCancel);
  end;

begin
  if RectVisible(ACanvas.Handle, R) then
  begin
    ACanvas.SaveState;
    try
      ACanvas.Brush.Style := bsClear;
      ACanvas.DrawTexT(GetText, R, taCenter, vaCenter, False, False);
    finally
      ACanvas.RestoreState;
    end;
  end;
end;

procedure TfmPageChooser.DrawCell(ACanvas: TcxCanvas; ACol, ARow: Integer);
var
  R: TRect;
begin
  R := GetCellBounds(ACol, ARow);
  if RectVisible(ACanvas.Handle, R) then
  begin
    InflateRect(R, -1, -1);
    if IsSelectedCell(ACol, ARow) then
      ACanvas.FillRect(R, LookAndFeelPainter.DefaultSelectionColor);
    InflateRect(R, -4, -4);
    if (FilCell <> nil) and (FImageIndex > -1) and (FImageIndex < FilCell.Count) then
      FilCell.Draw(ACanvas.Canvas, R.Left, R.Top, FImageIndex);
  end;
end;

procedure TfmPageChooser.DrawCells(ACanvas: TcxCanvas);
var
  ARow, ACol: Integer;
begin
  for ACol := 0 to ColCount - 1 do
  begin
    for ARow := 0 to RowCount - 1 do
      DrawCell(ACanvas, ACol, ARow);
  end;
end;

procedure TfmPageChooser.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ssAlt in Shift) or (Key = VK_ESCAPE) then
    FResult := mrCancel
  else 
    if Key = VK_RETURN then
      FResult := mrOk
    else 
      if Key in [VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN] then 
        ProcessKey(Key);
end;

procedure TfmPageChooser.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if PtInRect(ClientRect, Point(X, Y)) then
    FIsMousePressed := True
  else
    FResult := mrCancel;
end;
                           
procedure TfmPageChooser.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (FLastMousePos.X <> X) or (FLastMousePos.Y <> Y) then 
  begin 
    DoSelectCells(X, Y);
    FLastMousePos := Point(X, Y);
  end;  
end;

procedure TfmPageChooser.Paint;
var
  ACanvas: TcxCanvas;
begin
  ACanvas := TcxCanvas.Create(Canvas);
  try
    ACanvas.FillRect(ClientRect, LookAndFeelPainter.DefaultContentColor);
    DrawCells(ACanvas);
    DrawBottomPart(ACanvas, BottomBounds);
  finally
    ACanvas.Free;
  end;
end;

function TfmPageChooser.GetBottomBounds: TRect;
begin
  Result := ClientRect;
  InflateRect(Result, -1, -1);
  with Result do 
    if FIsTextAtBottom then
      Top := Bottom - BottomHeight
    else
      Bottom := Top + BottomHeight;
end;

function TfmPageChooser.GetBottomHeight: Integer;
begin
  Result := MulDiv(-Font.Height, PixelsPerInch, 72) + 6;
end;

function TfmPageChooser.GetCellBounds(ACol, ARow: Integer): TRect;
var
  CR: TRect;
  ATop, ALeft: Integer;
begin
  Windows.GetClientRect(Handle, CR);
  case FGrowDirection of
    gdTopLeft:
      begin
        ALeft := CR.Right - (ACol + 1) * CellWidth - 1;
        ATop := CR.Bottom - (ARow + 1) * CellHeight - 1;
        if FIsTextAtBottom then Dec(ATop, BottomHeight);
      end;

    gdTopRight:
      begin
        ALeft := 1 + ACol * CellWidth;
        ATop := CR.Bottom - (ARow + 1) * CellHeight - 1;
        if FIsTextAtBottom then Dec(ATop, BottomHeight);
      end;

    gdBottomRight:
      begin
        ALeft := 1 + ACol * CellWidth;
        ATop := 1 + ARow * CellHeight;
        if not FIsTextAtBottom then Inc(ATop, BottomHeight);
      end;

  else {gdBottomLeft}
    begin
      ALeft := CR.Right - (ACol + 1) * CellWidth - 1;
      ATop := 1 + ARow * CellHeight;
      if not FIsTextAtBottom then Inc(ATop, BottomHeight);
    end;
  end;
  Result := Bounds(ALeft, ATop, CellWidth, CellHeight);
end;

function TfmPageChooser.GetCellHeight: Integer;
begin
  if FilCell <> nil then
    Result := MulDiv(FilCell.Height, 3, 2) + 2
  else
    Result := CellSize;
end;

function TfmPageChooser.GetCellWidth: Integer;
begin
  if FilCell <> nil then
    Result := MulDiv(FilCell.Width, 3, 2) + 2
  else
    Result := CellSize;
end;

function TfmPageChooser.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := dxPSEngine.DialogsLookAndFeel.Painter;
end;

function TfmPageChooser.GetSelectedBounds: TRect;
var
  ALeft, ATop, ARight, ABottom: Integer;
begin
  Result := cxNullRect;
  if (SelectedColCount > 0) or (SelectedRowCount > 0) then
  begin
    case FGrowDirection of
      gdTopLeft:
        begin
          with GetCellBounds(SelectedColCount - 1, SelectedRowCount - 1) do
          begin
            ALeft := Left;
            ATop := Top;
          end;
          with GetCellBounds(0, 0) do
          begin
            ARight := Right;
            ABottom := Bottom;
          end;
        end;

      gdTopRight:
        begin
          with GetCellBounds(0, 0) do
          begin
            ALeft := Left;
            ABottom := Bottom;
          end;
          with GetCellBounds(SelectedColCount - 1, SelectedRowCount - 1) do
          begin
            ARight := Right;
            ATop := Top;
          end;
        end;

      gdBottomRight:
        begin
          with GetCellBounds(0, 0) do
          begin
            ALeft := Left;
            ATop := Top;
          end;
          with GetCellBounds(SelectedColCount - 1, SelectedRowCount - 1) do
          begin
            ARight := Right;
            ABottom := Bottom;
          end;
        end;

    else {gdBottomLeft}
      begin
        with GetCellBounds(SelectedColCount - 1, SelectedRowCount - 1) do
        begin
          ALeft := Left;
          ABottom := Bottom;
        end;
        with GetCellBounds(0, 0) do
        begin
          ARight := Right;
          ATop := Top;
        end;
      end;
    end;
    Result := Rect(ALeft, ATop, ARight, ABottom);
  end;
end;

function TfmPageChooser.IsSelectedCell(ACol, ARow: Integer): Boolean;
begin
  Result := (ACol < SelectedColCount) and (ARow < SelectedRowCount);
end;

procedure TfmPageChooser.SetColCount(Value: Integer);
var
  NewWidth, OldLeft: Integer;
begin
  if (FColCount = 0) or ((Value > FColCount) and (Value <= MaxColCount)) then
  begin
    FColCount := Value;
    NewWidth := Value * CellWidth + 2 {frame};
    if FGrowDirection in [gdTopLeft, gdBottomLeft] then
    begin
      Inc(NewWidth, 4 {non client});
      SetBounds(Left - (NewWidth - Width), Top, NewWidth, Height);
      Inc(FLastMousePos.X, CellWidth);
    end
    else
    begin
      OldLeft := Left; // Bug in Delphi 8 :-)))
      ClientWidth := NewWidth;
      Left := OldLeft;
    end;  
    SelectedColCount := FColCount - 1;
    UpdateWindow(Handle);
  end;
end;

procedure TfmPageChooser.SetRowCount(Value: Integer);
var
  NewHeight, OldTop: Integer;
  R1, R2: TRect;
begin
  if (FRowCount = 0) or ((Value > FRowCount) and (Value <= MaxRowCount)) then
  begin
    FRowCount := Value;
    NewHeight := Value * CellHeight + BottomHeight + 2;
    if (FGrowDirection in [gdTopLeft, gdTopRight]) then
    begin
      Inc(NewHeight, 4 {not client});
      SetBounds(Left, Top - (NewHeight - Height), Width, NewHeight);
      Inc(FLastMousePos.Y, CellWidth);
    end
    else
    begin
      OldTop := Top; // Bug in Delphi 8 :-)))
      ClientHeight := NewHeight;
      Top := OldTop;
   end;   

    if SelectedColCount < ColCount then
    begin
      R1 := GetCellBounds(SelectedColCount - 1, SelectedRowCount - 1);
      if not (FGrowDirection in [gdTopLeft, gdBottomLeft]) then
        OffsetRect(R1, CellWidth, CellHeight);
      R2 := GetCellBounds(ColCount - 1, RowCount - 1);
      if not (FGrowDirection in [gdTopLeft, gdBottomLeft]) then
        OffsetRect(R2, CellWidth, CellHeight);
      UnionRect(R1, R1, R2);
      InvalidateRect(Handle, @R1, False);
    end;
    SelectedRowCount := FRowCount - 1;
  end;
end;

procedure TfmPageChooser.SetSelectedCells(ACol, ARow: Integer);
var
  Rgn1, Rgn2: HRGN;
begin
  Rgn1 := CreateRectRgnIndirect(SelectedBounds);
  Rgn2 := CreateRectRgnIndirect(BottomBounds);
  CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
  DeleteObject(Rgn2);  
  FSelectedColCount := ACol;
  FSelectedRowCount := ARow;
  Rgn2 := CreateRectRgnIndirect(SelectedBounds);
  CombineRgn(Rgn1, Rgn1, Rgn2, RGN_XOR);
  DeleteObject(Rgn2);
  InvalidateRgn(Handle, Rgn1, False);
  Rgn2 := CreateRectRgnIndirect(BottomBounds);
  CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
  DeleteObject(Rgn2);
  InvalidateRgn(Handle, Rgn1, False);
  DeleteObject(Rgn1);
end;

procedure TfmPageChooser.SetSelectedColCount(Value: Integer);
begin
  SetSelectedCells(Value, SelectedRowCount);
end;

procedure TfmPageChooser.SetSelectedRowCount(Value: Integer);
begin
  SetSelectedCells(SelectedColCount, Value);
end;

procedure TfmPageChooser.DoSelectCells(X, Y: Integer);
var
  AColCount, ARowCount: Integer;
begin
  if FGrowDirection in [gdTopLeft, gdBottomLeft] then
    AColCount := Ceil((Width - X - 2 {frame} - 4 {non client}) / CellWidth)
  else
    AColCount := Ceil(X / CellWidth);

  if FIsTextAtBottom then
    ARowCount := Ceil(Y / CellHeight)
  else
    ARowCount := Ceil((Height - Y - 2 {frame} - 4 {non client}) / CellHeight);

  if (FGrowDirection in [gdTopRight, gdBottomRight]) and
    (Left + (AColCount * CellWidth + 2 {frame}) + 4 {non client} > FDesktop.Right) then 
     Dec(AColCount);
  if (FGrowDirection in [gdTopLeft, gdTopRight]) and
    (Top + (ARowCount * CellHeight + BottomHeight + 2 {frame}) + 4 {non client} > FDesktop.Bottom) then 
    Dec(ARowCount);
  ProcessSelect(AColCount, ARowCount, FIsMousePressed);  
end;

procedure TfmPageChooser.ProcessKey(var Key: Word);
var
  AColCount, ARowCount: Integer;
begin
  AColCount := 0;
  ARowCount := 0;
  case Key of 
    VK_LEFT:
      if FGrowDirection in [gdTopLeft, gdBottomLeft] then 
      begin
        AColCount := SelectedColCount + 1;
        ARowCount := SelectedRowCount;
        if ARowCount = 0 then ARowCount := 1;
      end
      else
      begin
        AColCount := SelectedColCount - 1;
        if AColCount < 1 then AColCount := 1;            
        ARowCount := SelectedRowCount;
      end;
    VK_UP:
      if FGrowDirection in [gdTopRight, gdTopLeft] then 
      begin
        ARowCount := SelectedRowCount + 1;
        AColCount := SelectedColCount;
        if AColCount = 0 then AColCount := 1;
      end
      else
      begin
        ARowCount := SelectedRowCount - 1;
        if ARowCount < 1 then ARowCount := 1;
        AColCount := SelectedColCount;
      end;  
    VK_RIGHT:
      if FGrowDirection in [gdTopLeft, gdBottomLeft] then 
      begin
        AColCount := SelectedColCount - 1;
        if AColCount < 1 then AColCount := 1;            
        ARowCount := SelectedRowCount;
      end
      else
      begin
        AColCount := SelectedColCount + 1;
        ARowCount := SelectedRowCount;
        if ARowCount = 0 then ARowCount := 1;
      end;
    VK_DOWN:
      if FGrowDirection in [gdTopRight, gdTopLeft] then 
      begin
        ARowCount := SelectedRowCount - 1;
        if ARowCount < 1 then ARowCount := 1;
        AColCount := SelectedColCount;
      end
      else
      begin
        ARowCount := SelectedRowCount + 1;
        AColCount := SelectedColCount;
        if AColCount = 0 then AColCount := 1;
      end;
  end;
  ProcessSelect(AColCount, ARowCount, True);
  Key := 0;
end;

procedure TfmPageChooser.ProcessSelect(AColCount, ARowCount: Integer; GrowFlag: Boolean);
begin
  if GrowFlag then
  begin
    if (SelectedRowCount <> 0) and (SelectedColCount <> 0) then
    begin
      RowCount := ARowCount;
      ColCount := AColCount;
    end
  end
  else
  begin
    if AColCount > ColCount then AColCount := 0;
    if ARowCount > RowCount then ARowCount := 0;
  end;

  if AColCount < 0 then
    AColCount := 0
  else 
    if AColCount > ColCount then
      AColCount := ColCount;

  if ARowCount < 0 then
    ARowCount := 0
  else 
    if ARowCount > RowCount then
      ARowCount := RowCount;

  SetSelectedCells(AColCount, ARowCount);
end;

procedure TfmPageChooser.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TfmPageChooser.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  FResult := mrCancel;
end;

procedure TfmPageChooser.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  if SelectedRowCount * SelectedColCount > 0 then
    FResult := mrOk
  else
    FResult := mrCancel;
end;

procedure TfmPageChooser.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  InflateRect(Message.CalcSize_Params^.rgrc[0],
    -LookAndFeelPainter.BorderSize, -LookAndFeelPainter.BorderSize);
end;

procedure TfmPageChooser.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  inherited;
  FResult := mrCancel;
end;

procedure TfmPageChooser.WMNCPaint(var Message: TWMNCPaint);

  procedure DoDrawFrame(ACanvas: TCanvas; const R: TRect);
  var
    AcxCanvas: TcxCanvas;
  begin
    AcxCanvas := TcxCanvas.Create(ACanvas);
    try
      LookAndFeelPainter.DrawBorder(AcxCanvas, R);
    finally
      AcxCanvas.Free;
    end;
  end;

var
  ACanvas: TCanvas;
  R: TRect;
begin
  ACanvas := TCanvas.Create;
  try
    ACanvas.Lock;
    ACanvas.Handle := GetWindowDC(Handle);
    try
      R := cxGetWindowRect(Handle);
      OffsetRect(R, -R.Left, -R.Top);
      DoDrawFrame(ACanvas, R);
    finally
      ReleaseDC(Handle, ACanvas.Handle);
      ACanvas.Handle := 0;
      ACanvas.Unlock;
    end;
  finally
    ACanvas.Free;
  end;
end;

end.

