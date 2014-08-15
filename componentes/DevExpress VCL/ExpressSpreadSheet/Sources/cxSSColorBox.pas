{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxSSColorBox;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
  Windows, Forms, Controls, StdCtrls, Graphics, Dialogs, cxControls, cxClasses,
  cxGraphics, cxExcelConst, {$IFNDEF cxLib10} cxLookAndFeelPainters, {$ENDIF}
  cxSSRes, cxSSPainterWrapper, cxSSTypes;

type
  TcxColorBoxHitType = (cbhNone, cbhBrush, cbhColor, cbhAutomatic);

  TcxSSColorBoxInfo = packed record
    ColorPalette: Pointer;
    HalfSpace: Integer;
    DisplayRect: TRect;
    HitType: TcxColorBoxHitType;
    HitIndex,
    SelectedBrush,
    SelectedColor: SmallInt;
    Bevels: array of TRect;
    AutomaticColor: ShortInt;
    AutomaticRect: TRect;
    BrushBricks: array of TRect;
    ColorBricks: array of TRect;
  end;

  TcxSSColorPanel = class;

  { TcxSSColorBoxViewInfo }
  TcxSSColorBoxViewInfo = class
  private
    FViewInfo: TcxSSColorBoxInfo;
    FOwner: TcxSSColorPanel;
  protected
    procedure InvalidateBrick(AType: TcxColorBoxHitType; AIndex: Integer); virtual;
    procedure InvalidateRect(ARect: TRect); virtual;
  public
    constructor Create(const AOwner: TcxSSColorPanel); virtual;
    function HitTest(X, Y: Integer; var AHitIndex: SmallInt): TcxColorBoxHitType; virtual;
    procedure ReCalcViewInfo; virtual;
    procedure SetHitBrick(const AType: TcxColorBoxHitType;
      const AIndex: Shortint); virtual;
    function SetSelected(const AType: TcxColorBoxHitType;
      const AIndex: Shortint): Boolean; virtual;
    property ViewInfo: TcxSSColorBoxInfo read FViewInfo;
  end;

  { TcxSSExcelColorBoxPainter }
  TcxSSExcelColorBoxPainter = class
  public
    class procedure Paint(ACanvas: TcxCanvasWrapper; const AViewInfo: TcxSSColorBoxInfo); virtual;
  end;

  {TcxSSColorPanel}
  TcxSSColorPanel = class(TcxControl)
  private
    FColorsPalette: TcxExcelPalette;
    FIsAssignedPalette: Boolean;
    FIncludeBrushes: Boolean;
    FOnChange: TNotifyEvent;
    FViewInfo: TcxSSColorBoxViewInfo;
    FCanvasWrapper: TcxCanvasWrapper;
    function GetAutomaticColor: Byte;
    function GetColorsPalette: PcxExcelPalette;
    function GetIncludeBrushes: Boolean;
    function GetSelectedBrush: TcxSSFillStyle;
    function GetSelectedColor: Byte;
    procedure SetAutomaticColor(const Value: Byte);
    procedure SetIncludeBrushes(const Value: Boolean);
    procedure SetSelectedBrush(const Value: TcxSSFillStyle);
    procedure SetSelectedColor(const Value: Byte);
    procedure SetPalette(const Value: PcxExcelPalette);
  protected
    procedure Change;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure Resize; override;
    property CanvasWrapper: TcxCanvasWrapper read FCanvasWrapper;
    property ClientRect: TRect read GetClientRect;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ColorPalette: PcxExcelPalette read GetColorsPalette write SetPalette;
  published
    property AutomaticColor: Byte read GetAutomaticColor write SetAutomaticColor;
    property IncludeBrushes: Boolean read GetIncludeBrushes write SetIncludeBrushes;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property SelectedBrush: TcxSSFillStyle read GetSelectedBrush write SetSelectedBrush;
    property SelectedColor: Byte read GetSelectedColor write SetSelectedColor;
    property Align;
    property Font;
    property Height;
    property Left;
    property Top;
    property Width;
  end;

  { TcxColorComboBox }
  TcxSSColorComboBox = class(TcxControl)
  private
    FButtonDown: Boolean;
    FButtonRect: TRect;
    FColorPanel: TcxSSColorPanel;
    FPopupWindow: TcxPopupWindow;
    FOnChange: TNotifyEvent;
    FCanvasWrapper: TcxCanvasWrapper;
    function GetAutomaticColor: Byte;
    function GetColorPalette: PcxExcelPalette;
    function GetIncludeBrushes: Boolean;
    function GetFont: TFont;
    function GetSelectedBrush: TcxSSFillStyle;
    function GetSelectedColor: Byte;
    procedure SetAutomaticColor(const Value: Byte);
    procedure SetColorPalette(const Value: PcxExcelPalette);
    procedure SetIncludeBrushes(const Value: Boolean);
    procedure SetFont(AFont: TFont);
    procedure SetSelectedBrush(const Value: TcxSSFillStyle);
    procedure SetSelectedColor(const Value: Byte);
  protected
    procedure DoOnChange(Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure OnHidePopup(Sender: TObject); virtual;
    procedure Resize; override;
    procedure Paint; override;
    procedure ShowPopup; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CanvasWrapper: TcxCanvasWrapper read FCanvasWrapper;
    property ColorPalette: PcxExcelPalette read GetColorPalette write SetColorPalette;
  published
    property AutomaticColor: Byte read GetAutomaticColor write SetAutomaticColor;
    property IncludeBrushes: Boolean read GetIncludeBrushes write SetIncludeBrushes;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property SelectedBrush: TcxSSFillStyle read GetSelectedBrush write SetSelectedBrush;
    property SelectedColor: Byte read GetSelectedColor write SetSelectedColor;
    property Align;
    property Font read GetFont write SetFont;
    property Height;
    property Left;
    property Top;
    property Width;
  end;

  { TcxSSColorPropertyEditor }
  TcxSSColorPropertyEditor = class(TForm)
  protected
    class function CreateColorEditor: TForm;
  public
    class function Execute(var AColor: TcxSSColor): Boolean;
  end;

implementation
type
  TcxCustomPropertyEditorForm = class(TForm)
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  TCanvasWrapperAccess = class(TcxCanvasWrapper);

function ColorToRealColor(AIndex: Byte): Byte;
begin
  Result := 0;
  Inc(AIndex, 8);
  while (Result < High(ExcelColorIndexes)) and (ExcelColorIndexes[Result] <> AIndex) do
    Inc(Result);
end;

procedure FrameRect(ACanvas: TcxCanvas; ARect: TRect; ATopColor, ABottomColor: TColor);
begin
  ACanvas.Brush.Color := ATopColor;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left + 1, ARect.Bottom - 1));
  ACanvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Top + 1));
  ACanvas.Brush.Color := ABottomColor;
  ACanvas.FillRect(Rect(ARect.Right - 1, ARect.Top, ARect.Right, ARect.Bottom));
  ACanvas.FillRect(Rect(ARect.Left, ARect.Bottom - 1, ARect.Right, ARect.Bottom));
end;

procedure TwoFrameRect(ACanvas: TcxCanvas; var ARect: TRect; ATopColor1, ATopColor2, ABottomColor1, ABottomColor2: TColor);
begin
  FrameRect(ACanvas, ARect, ATopColor1, ABottomColor1);
  InflateRect(ARect, -1, -1);
  FrameRect(ACanvas, ARect, ATopColor2, ABottomColor2);
  InflateRect(ARect, -1, -1);
end;

{ TcxSSColorBoxViewInfo }
constructor TcxSSColorBoxViewInfo.Create(const AOwner: TcxSSColorPanel);
begin
  FOwner := AOwner;
  FViewInfo.HitIndex := -1;
end;

function TcxSSColorBoxViewInfo.HitTest(X, Y: Integer;
  var AHitIndex: SmallInt): TcxColorBoxHitType;

  function FindInBricks(const APoint: TPoint; const ABricks: array of TRect;
    const ACount: Byte; var AIndex: SmallInt): Boolean;
  var
    I: SmallInt;
    ARect: TRect;
  begin
    Result := False;
    if Length(ABricks) = 0 then Exit;
    for I := 0 to ACount do
    begin
       ARect := ABricks[I];
       InflateRect(ARect, 3, 3);
       if PtInRect(ARect, APoint) then
       begin
         Result := True;
         AIndex := I;
       end;
    end;
  end;

begin
  Result := cbhNone;
  AHitIndex := -1;
  if FindInBricks(Point(X, Y),  FViewInfo.BrushBricks,
    Integer(High(TcxSSFillStyle)), AHitIndex) then
  begin
    Result := cbhBrush
  end
  else
  begin
    if FindInBricks(Point(X, Y),  FViewInfo.ColorBricks,
      High(TcxExcelPalette), AHitIndex) then
        Result := cbhColor
    else
      if PtInRect(FViewInfo.AutomaticRect, Point(X, Y)) then
        Result := cbhAutomatic;
  end;
end;

procedure TcxSSColorBoxViewInfo.RecalcViewInfo;

  procedure IncF(var AValue: Double; const AIncr: Double);
  begin
    AValue := AValue + AIncr;
  end;

var
  ARect: TRect;
  ASpaceWidth, ASpaceHeight: Double;
  I, J: Integer;
  AHeight, AWidth: Double;

begin
  ARect := FOwner.ClientRect;
  with FViewInfo do
  begin
    DisplayRect := ARect;
    SetLength(ColorBricks, High(TcxExcelPalette) + 1);
    if FOwner.IncludeBrushes then
    begin
      SetLength(BrushBricks, Byte(High(TcxSSFillStyle)) + 1);
      SetLength(Bevels, 2);
      ASpaceHeight := ARect.Bottom / 42;
    end
    else
    begin
      SetLength(BrushBricks, 0);
      SetLength(Bevels, 1);
      ASpaceHeight := ARect.Right / 26;
    end;
  end;
  ASpaceWidth := ARect.Right / 25;
  FViewInfo.HalfSpace := Round(ASpaceWidth / 2);
  AHeight := 0;
  if FOwner.IncludeBrushes then
  begin
    IncF(AHeight, ASpaceHeight);
    for J := 0 to 2 do
    begin
      AWidth := 0;
      for I := 0 to 5 do
      begin
        FViewInfo.BrushBricks[I + J * 6] := Rect(Round(AWidth + ASpaceWidth), Round(AHeight),
          Round(AWidth + ASpaceWidth * 4), Round(AHeight + ASpaceHeight * 3));
        IncF(AWidth, ASpaceWidth * 4);
      end;
      IncF(AHeight, ASpaceHeight * 4);
    end;
    FViewInfo.Bevels[1] := Rect(Round(ASpaceWidth), Round(AHeight + ASpaceHeight),
      Round(ARect.Right - ASpaceWidth), Round(AHeight + ASpaceHeight + 1));
    IncF(AHeight, ASpaceHeight + 2);
  end;
  with FViewInfo do
  begin
    IncF(AHeight, ASpaceHeight);
    AutomaticRect := Rect(Round(ASpaceWidth), Round(AHeight),
      Round(ARect.Right - ASpaceWidth), Round(AHeight + ASpaceHeight * 4));
    AutomaticColor := FOwner.AutomaticColor;
    IncF(AHeight, ASpaceHeight * 4);
  end;

  for J := 0 to 6 do
  begin
    IncF(AHeight, ASpaceWidth);
    if J = 5 then
    begin
      FViewInfo.Bevels[0] := Rect(Round(ASpaceWidth), Round(AHeight),
        Round(ARect.Right - ASpaceWidth), Round(AHeight) + 1);
      IncF(AHeight, ASpaceHeight + 2);
    end;
    AWidth := 0;
    for I := 0 to 7 do
    begin
      FViewInfo.ColorBricks[J * 8 + I] := Rect(Round(AWidth + ASpaceWidth), Round(AHeight),
        Round(AWidth + ASpaceWidth * 3), Round(AHeight + ASpaceHeight * 2));
      IncF(AWidth, ASpaceWidth * 3);
    end;
    IncF(AHeight, ASpaceHeight * 2);
  end;
  InvalidateRect(FViewInfo.DisplayRect);
end;

function TcxSSColorBoxViewInfo.SetSelected(const AType: TcxColorBoxHitType;
  const AIndex: Shortint): Boolean;
begin
  Result := False;
  with FViewInfo do
  begin
    case AType of
      cbhBrush:
        if SelectedBrush <> AIndex then
        begin
          InvalidateBrick(cbhBrush, SelectedBrush);
          InvalidateBrick(AType, AIndex);
          SelectedBrush := AIndex;
          Result := True;
        end;
      cbhColor:
        if SelectedColor <> AIndex then
        begin
          if SelectedColor = - 1 then
            InvalidateBrick(cbhAutomatic, 0)
          else
            InvalidateBrick(cbhColor, SelectedColor);
          InvalidateBrick(AType, AIndex);
          SelectedColor := AIndex;
          Result := True;
        end;
      cbhAutomatic:
        if SelectedColor <> - 1 then
        begin
          InvalidateBrick(cbhColor, SelectedColor);
          InvalidateBrick(AType, AIndex);
          SelectedColor := -1;
          Result := True;
        end;
    end;
  end;
  FOwner.Change;
end;

procedure TcxSSColorBoxViewInfo.SetHitBrick(const AType: TcxColorBoxHitType;
  const AIndex: Shortint);
begin
  if (FViewInfo.HitType = AType) and (FViewInfo.HitIndex = AIndex) then Exit;
  InvalidateBrick(FViewInfo.HitType, FViewInfo.HitIndex);
  FViewInfo.HitType := AType;
  FViewInfo.HitIndex := AIndex;
  InvalidateBrick(FViewInfo.HitType, FViewInfo.HitIndex);
end;

procedure TcxSSColorBoxViewInfo.InvalidateBrick(AType: TcxColorBoxHitType; AIndex: Integer);
var
  ARect: TRect;
begin
  ARect := Rect(0, 0, 0, 0);
  case AType of
    cbhBrush:
      if (FViewInfo.BrushBricks <> nil) and
        ((AIndex >= 0) and (AIndex <= Integer(High(TcxSSFillStyle))))  then
          ARect := FViewInfo.BrushBricks[AIndex];
    cbhColor:
      if (FViewInfo.ColorBricks <> nil) and
        ((AIndex >= 0) and (AIndex <= (High(TcxExcelPalette)))) then
          ARect := FViewInfo.ColorBricks[AIndex];
    cbhAutomatic:
      ARect := FViewInfo.AutomaticRect;
  end;
  if not IsRectEmpty(ARect) then
  begin
    InflateRect(ARect, 3, 3);
    InvalidateRect(ARect);
  end;
end;

procedure TcxSSColorBoxViewInfo.InvalidateRect(ARect: TRect);
begin
  InflateRect(ARect, 3, 3);
  FOwner.InvalidateRect(ARect, True);
end;

{ TcxSSExcelColorBoxPainter }
class procedure TcxSSExcelColorBoxPainter.Paint(ACanvas: TcxCanvasWrapper;
  const AViewInfo: TcxSSColorBoxInfo);

  procedure DrawBrick(const AIndex: SmallInt; const IsColor: Boolean = True);
  var
    ARect: TRect;
    IsSelected, IsHitted: Boolean;
    AColor: TColor;
  begin
    IsHitted := AViewInfo.HitIndex = AIndex;
    if IsColor then
    begin
      ARect := AViewInfo.ColorBricks[AIndex];
      AColor := PcxExcelPalette(AViewInfo.ColorPalette)^[ExcelColorIndexes[AIndex] - 8];
      IsHitted := IsHitted and (AViewInfo.HitType = cbhColor);
      IsSelected := AViewInfo.SelectedColor = AIndex;
    end
    else
    begin
      ARect := AViewInfo.BrushBricks[AIndex];
      AColor := clWhite;
      IsHitted := IsHitted and (AViewInfo.HitType = cbhBrush);
      IsSelected := AViewInfo.SelectedBrush = AIndex;
    end;
    Inc(ARect.Left, 1);
    Inc(ARect.Top, 1);
    if not IsColor then
      ACanvas.FillRect(ARect, TcxSSFillStyle(AIndex), ACanvas.GetNativeColor(AColor), cxBlackColor)
    else
      ACanvas.FillRect(ARect, fsSolid,
        PcxExcelPalette(AViewInfo.ColorPalette)^[ExcelColorIndexes[AIndex] - 8],
          PcxExcelPalette(AViewInfo.ColorPalette)^[ExcelColorIndexes[AIndex] - 8]);
    if IsColor then
    begin
      InflateRect(ARect, 1, 1);
      ACanvas.FrameRect(ARect, cxBtnShadowColor, cxBtnShadowColor);
    end;
    ACanvas.ExcludeClipRect(ARect);
    if IsSelected or IsHitted then
    begin
      InflateRect(ARect, 3, 3);
      ACanvas.FillRect(ARect, fsSolid, cxBtnFaceColor, cxBtnFaceColor);
      if IsSelected then
      begin
        ACanvas.FillRect(ARect, fsGray50, cxWhiteColor, cxBtnFaceColor);
        ACanvas.FrameRect(ARect, cxBtnShadowColor, cxBtnHighLightColor);
      end
      else
        ACanvas.FrameRect(ARect, cxBtnHighLightColor, cxBtnShadowColor);
    end;
    ACanvas.ExcludeClipRect(ARect);
  end;

  procedure DrawAutomatic;
  var
    ARect: TRect;
    ARect1: TRect;
    AHeight: Integer;
  begin
    with AViewInfo do
    begin
      ARect := AutomaticRect;
      InflateRect(ARect, -3, -3);
      ARect1 := ARect;
      InflateRect(ARect1, -HalfSpace, -HalfSpace);
      ARect1.Right := ARect1.Left + (ARect1.Bottom - ARect1.Top);
      InflateRect(ARect1, -1, -1);
      ACanvas.FillRect(ARect, fsSolid, AutomaticColor, 0, False);// {PcxExcelPalette(AViewInfo.ColorPalette)^[}AutomaticColor{]}, 0, False);
      InflateRect(ARect1, 1, 1);
      ACanvas.FrameRect(ARect1, cxBtnShadowColor);
      ACanvas.ExcludeClipRect(ARect1);
      if SelectedColor = -1 then
      begin
        ACanvas.FillRect(ARect, fsGray50, cxWhiteColor, cxBtnFaceColor);
        InflateRect(ARect, 1, 1);
        ACanvas.FrameRect(ARect, cxBtnShadowColor, cxBtnHighLightColor);
        InflateRect(ARect, -2, -2);
        ACanvas.FrameRect(ARect, cxBtnShadowColor);
        InflateRect(ARect, 2, 2);
      end
      else
      begin
        ACanvas.FillRect(ARect, fsSolid, cxBtnFaceColor, 0);
        InflateRect(ARect, 1, 1);
        if HitType = cbhAutomatic then
          ACanvas.FrameRect(ARect, cxBtnHighLightColor, cxBtnShadowColor)
        else
          ACanvas.FrameRect(ARect, cxBtnShadowColor, cxBtnShadowColor);
      end;
      ARect1.BottomRight := ARect.BottomRight;
      ARect1.Top := ARect.Top;
      AHeight := (ARect.Bottom - ARect.Top - 4);
      if AHeight < 2 then  AHeight := 2;
      while ACanvas.Canvas.TextHeight(cxGetResourceString(@scxColorBoxAutomatic)) > AHeight do
      begin
        ACanvas.Canvas.Font.Size := ACanvas.Canvas.Font.Size - 1;
        if ACanvas.Canvas.Font.Size <= 1 then Break;
      end;
      while ACanvas.Canvas.TextHeight(cxGetResourceString(@scxColorBoxAutomatic)) < AHeight  do
        ACanvas.Canvas.Font.Size := ACanvas.Canvas.Font.Size + 1;
      if ACanvas.Canvas.Font.Size < 2 then ACanvas.Canvas.Font.Size := 2;
//      ACanvas.Canvas.Font.Color := clBlack;
      ACanvas.SetTextColor(clBlack);
      ACanvas.DrawText(cxGetResourceString(@scxColorBoxAutomatic), ARect);
      ACanvas.ExcludeClipRect(ARect);
    end;
  end;

var
  I: Integer;

begin
  with AViewInfo do
  begin
    if BrushBricks <> nil then
      for I := 0 to Integer(High(TcxSSFillStyle)) do
        DrawBrick(I, False);
    for I := 0 to High(TcxExcelPalette) do
      DrawBrick(I);

    for I := 0 to Length(Bevels) - 1 do
    with Bevels[I] do
    begin
      ACanvas.FillRect(Rect(Left, Top + 0, Right, Top + 1), fsSolid, cxBtnShadowColor, 0);
      ACanvas.FillRect(Rect(Left, Top + 1, Right, Top + 2), fsSolid, cxBtnHighLightColor, 0);
      ACanvas.ExcludeClipRect(Bevels[I]);
    end;
    DrawAutomatic;
  end;
end;

{TcxSSColorPanel}
constructor TcxSSColorPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Keys := [kArrows];
  FIncludeBrushes := True;
  FViewInfo := TcxSSColorBoxViewInfo.Create(Self);
  PInteger(@FViewInfo.ViewInfo.ColorPalette)^ := Integer(@FColorsPalette);
  FColorsPalette := cxExcelStdColors;
  FIsAssignedPalette := False;
  FCanvasWrapper := TcxCanvasWrapper.Create(@FColorsPalette);
  Width := 158;
  Height := 250;
end;

destructor TcxSSColorPanel.Destroy;
begin
  FCanvasWrapper.Free;
  FViewInfo.Free;
  inherited Destroy;
end;

procedure TcxSSColorPanel.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TcxSSColorPanel.KeyDown(var Key: Word; Shift: TShiftState);
var
  AViewInfo: TcxSSColorBoxInfo;
  APos: Integer;

  procedure SetHitPos(APos: Integer);
  var
    AHitType: TcxColorBoxHitType;
  begin
    if APos < 0 then
       if IncludeBrushes then
         APos := 56 + 18
       else
         APos := 56
    else
      if (IncludeBrushes and (APos > (56 + 18))) or
        (not IncludeBrushes and (APos > 56)) then APos := 0;
    if IncludeBrushes then
    begin
      if APos > 18 then
      begin
        APos := APos - 19;
        AHitType := cbhColor
      end
      else
      begin
        if APos = 18 then
          AHitType := cbhAutomatic
        else
          AHitType := cbhBrush
      end;
    end
    else
    begin
      if APos > 0 then
      begin
        APos := APos - 1;
        AHitType := cbhColor
      end
      else
        AHitType := cbhAutomatic
    end;
    FViewInfo.SetHitBrick(AHitType, APos);
  end;

begin
  AViewInfo := FViewInfo.ViewInfo;
  case AViewInfo.HitType of
    cbhNone:
    begin
      AViewInfo.HitType := cbhColor;
      APos := 0;
    end;
    cbhBrush:
      APos := AViewInfo.HitIndex;
    cbhColor:
    begin
      APos := AViewInfo.HitIndex + 1;
      if IncludeBrushes then
        Inc(APos, 18);
    end;
    cbhAutomatic:
      if IncludeBrushes then
        APos := 18
      else
        APos := 0;
  else
    begin
      APos := 0;
      AViewInfo.HitType := cbhColor;
    end;
  end;
  case Key of
    VK_UP:
      if IncludeBrushes then
      begin
        if APos <= 18 then
          SetHitPos(APos - 6)
        else
          if APos > 26 then
            SetHitPos(APos - 8)
          else
            SetHitPos(18);
      end
      else
      begin
        if APos > 8 then
          SetHitPos(APos - 8)
        else
          if APos > 1 then
            SetHitPos(1)
          else
            SetHitPos(-1);
      end;
    VK_DOWN:
      if IncludeBrushes then
      begin
        if APos <= 12 then
          SetHitPos(APos + 6)
        else
          if APos = 18  then
            SetHitPos(APos + 1)
          else
            SetHitPos(APos + 8)
      end
      else
      begin
        if APos > 0 then
          SetHitPos(APos + 8)
        else
          SetHitPos(1)
      end;
    VK_RIGHT:
        SetHitPos(APos + 1);
    VK_LEFT:
        SetHitPos(APos - 1);
    VK_RETURN:
        if AViewInfo.HitType <> cbhNone then
          FViewInfo.SetSelected(AViewInfo.HitType, AViewInfo.HitIndex);
  else
     if Parent is TcxPopupWindow then (Parent as TcxPopupWindow).CloseUp;
  end;
end;

procedure TcxSSColorPanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
end;

procedure TcxSSColorPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AHitTest: TcxColorBoxHitType;
  AIndex: SmallInt;
begin
  inherited;
  AHitTest := FViewInfo.HitTest(X, Y, AIndex);
  if AHitTest <> cbhNone then
    if FViewInfo.SetSelected(AHitTest, AIndex) then Change;
end;

procedure TcxSSColorPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxColorBoxHitType;
  AIndex: SmallInt;
begin
  inherited;
  AHitTest := FViewInfo.HitTest(X, Y, AIndex);
  FViewInfo.SetHitBrick(AHitTest, AIndex);
end;

procedure TcxSSColorPanel.Paint;
begin
  FCanvasWrapper.BeginPaint(Canvas.Canvas);
  try
    Canvas.Font.Assign(Font); 
    TcxSSExcelColorBoxPainter.Paint(FCanvasWrapper, FViewInfo.ViewInfo);
    cxDrawThemeParentBackground(Self, Canvas, ClientRect);
  finally
    FCanvasWrapper.EndPaint;
  end;
  inherited;
end;

procedure TcxSSColorPanel.Resize;
begin
  inherited;
  FViewInfo.RecalcViewInfo;
end;

function TcxSSColorPanel.GetAutomaticColor: Byte;
begin
  with FViewInfo.ViewInfo do
    Result := AutomaticColor;
end;

function TcxSSColorPanel.GetColorsPalette: PcxExcelPalette;
begin
  Result := @FColorsPalette
end;

function TcxSSColorPanel.GetIncludeBrushes: Boolean;
begin
  Result := FIncludeBrushes;
end;

function TcxSSColorPanel.GetSelectedBrush: TcxSSFillStyle;
begin
  if IncludeBrushes then
    Result := TcxSSFillStyle(FViewInfo.ViewInfo.SelectedBrush)
  else
    Result := Low(TcxSSFillStyle);
end;

function TcxSSColorPanel.GetSelectedColor: Byte;
begin
  with FViewInfo.ViewInfo do
  if SelectedColor < 0 then
    Result := $40
  else
    Result := ExcelColorIndexes[SelectedColor] - 8;
end;

procedure TcxSSColorPanel.SetAutomaticColor(const Value: Byte);
begin
  FViewInfo.FViewInfo.AutomaticColor := Value;
  FViewInfo.ReCalcViewInfo;
end;

procedure TcxSSColorPanel.SetIncludeBrushes(const Value: Boolean);
begin
  if FIncludebrushes = Value then Exit;
  FIncludeBrushes := Value;
  FViewInfo.ReCalcViewInfo;
end;

procedure TcxSSColorPanel.SetSelectedBrush(const Value: TcxSSFillStyle);
begin
  FViewInfo.FViewInfo.SelectedBrush := Byte(Value);
  FViewInfo.ReCalcViewInfo;
end;

procedure TcxSSColorPanel.SetSelectedColor(const Value: Byte);
begin
  if Value = AutomaticColor then
    FViewInfo.FViewInfo.SelectedColor := -1
  else
    FViewInfo.SetSelected(cbhColor, ColorToRealColor(Value));
  FViewInfo.ReCalcViewInfo;
end;

procedure TcxSSColorPanel.SetPalette(const Value: PcxExcelPalette);
begin
  FColorsPalette := Value^;
  FViewInfo.FViewInfo.ColorPalette := @FColorsPalette;
  FCanvasWrapper.PaletteChanged;
  Invalidate;
end;

{ TcxColorComboBox }
constructor TcxSSColorComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Keys := [kArrows];
  FPopupWindow := TcxPopupWindow.Create;
  FPopupWindow.OwnerParent := Self;
  FPopupWindow.BorderStyle := pbs3D;
  FPopupWindow.OnHide := OnHidePopup;
  FPopupWindow.OnDeactivate := OnHidePopup;
  FPopupWindow.Adjustable := False;
  FColorPanel := TcxSSColorPanel.Create(Self);
  FColorPanel.Parent := FPopupWindow;
  FCanvasWrapper := TcxCanvasWrapper.Create(@FColorPanel.FColorsPalette);
  FColorPanel.OnChange := DoOnChange;
  FColorPanel.Visible := True;
  IncludeBrushes := True;
end;

destructor TcxSSColorComboBox.Destroy;
begin
  FPopupWindow.Free;
  FCanvasWrapper.Free;
  inherited;
end;

procedure TcxSSColorComboBox.DoOnChange(Sender: TObject);
begin
  InvalidateRect(ClientRect, False);
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TcxSSColorComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = vk_Up) or (Key = VK_Down) or (Key = VK_Return) then ShowPopup;
end;

procedure TcxSSColorComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TcxSSColorComboBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if PtInRect(FButtonRect, Point(X, Y)) then ShowPopup;
end;

procedure TcxSSColorComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TcxSSColorComboBox.OnHidePopup(Sender: TObject);
begin
  SetCaptureControl(nil);
  if FButtonDown then
  begin
    FButtonDown := False;
    InvalidateRect(FButtonRect, False);
  end;
end;

procedure TcxSSColorComboBox.Paint;
var
  ARect: TRect;
  ABoxRect: TRect;

  procedure DrawButton(ARect: TRect);

    procedure DrawTriangle(ARect: TRect);
    var
      Cx, Cy: Integer;
      H: Integer;
      APoints: array[0..2] of TPoint;
    begin
      H := Round(ClientHeight/4);
      if Odd(H) then Dec(H);
      CX := (ARect.Left + ARect.Right) div 2 - 1;
      CY := (ARect.Top + ARect.Bottom) div 2 - 2;
      if FButtonDown then
      begin
        Inc(CX);
        Inc(CY);
      end;
      APoints[0] := Point(CX - H div 2, CY - H div 4);
      APoints[1] := Point(CX + H div 2, CY - H div 4);
      APoints[2] := Point(CX, CY + H div 4 + 1);
      Canvas.Brush.Color := clBlack;
      Canvas.Polygon(APoints);
    end;

  begin
    InflateRect(ARect, -2, -2);
    if FButtonDown then
    begin
      FrameRect(Canvas, ARect, clBtnShadow, clBtnShadow);
      InflateRect(ARect, -1, -1);
    end
    else
      TwoFrameRect(Canvas, ARect, clBtnFace, clBtnHighLight, clBlack, clBtnShadow);
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(ARect);
    InflateRect(ARect, 2, 2);
    DrawTriangle(ARect);
    Canvas.ExcludeClipRect(ARect);
  end;

begin
  ARect := ClientRect;
  ABoxRect := ARect;
  Canvas.Brush.Style := bsSolid;
  ABoxRect.Left := ABoxRect.Right - (ABoxRect.Bottom - ABoxRect.Top);
  FButtonRect := ABoxRect;
  DrawButton(ABoxRect);
  TwoFrameRect(Canvas, ARect, clBtnShadow, clBlack, clBtnHighLight, clBtnFace);
  ABoxRect := ARect;
  ABoxRect.Right := FButtonRect.Left;
  InflateRect(ABoxRect, -4, -4);
  FCanvasWrapper.BeginPaint(Canvas.Canvas);
  FColorPanel.FCanvasWrapper.WindowColor := FCanvasWrapper.WindowColor;
  if FColorPanel.SelectedBrush = fsSolid then
    FCanvasWrapper.FillRect(ABoxRect, FColorPanel.SelectedBrush, FColorPanel.SelectedColor, 1, False)
  else
    FCanvasWrapper.FillRect(ABoxRect, FColorPanel.SelectedBrush,
      cxWhiteColor, ColorToRgb(ColorPalette^[FColorPanel.SelectedColor]));
  InflateRect(ABoxRect, 1, 1);
  with FCanvasWrapper do
    FrameRect(ABoxRect, cxBtnHighLightColor, cxBtnHighLightColor);
  InflateRect(ABoxRect, 1, 1);
  FCanvasWrapper.FrameRect(ABoxRect, cxBlackColor, cxBlackColor);
  FCanvasWrapper.ExcludeClipRect(ABoxRect);
  with FCanvasWrapper do
    FillRect(ARect, fsSolid, GetNativeColor(clWindow), GetNativeColor(clWindow));
  FCanvasWrapper.EndPaint;
  inherited Paint;
end;

procedure TcxSSColorComboBox.Resize;
begin
  inherited Resize;
  if IncludeBrushes then
    FColorPanel.SetBounds(7, 5, 158, 280)
  else
    FColorPanel.SetBounds(7, 5, 158, 175);
  FPopupWindow.Width := FColorPanel.Width + 10;
  FPopupWindow.Height := FColorPanel.Height + 10;
  FPopupWindow.OwnerBounds := ClientRect;
  FPopupWindow.BorderStyle := pbs3D;
end;

procedure TcxSSColorComboBox.ShowPopup;
begin
  FButtonDown := True;
  InvalidateRect(FButtonRect, False);
  FPopupWindow.OwnerBounds := ClientRect;
  Resize;
  FPopupWindow.Popup;
end;

function TcxSSColorComboBox.GetAutomaticColor: Byte;
begin
  Result := FColorPanel.GetAutomaticColor;
end;

function TcxSSColorComboBox.GetColorPalette: PcxExcelPalette;
begin
  Result := FColorPanel.ColorPalette;
end;

function TcxSSColorComboBox.GetIncludeBrushes: Boolean;
begin
  Result := FColorPanel.IncludeBrushes;
end;

function TcxSSColorComboBox.GetFont: TFont;
begin
  Result := FColorPanel.Font
end;

function TcxSSColorComboBox.GetSelectedBrush: TcxSSFillStyle;
begin
  Result := FColorPanel.SelectedBrush;
end;

function TcxSSColorComboBox.GetSelectedColor: Byte;
begin
  Result := FColorPanel.SelectedColor;
end;

procedure TcxSSColorComboBox.SetAutomaticColor(const Value: Byte);
begin
  FColorPanel.AutomaticColor := Value;
end;

procedure TcxSSColorComboBox.SetColorPalette(const Value: PcxExcelPalette);
begin
  FColorPanel.ColorPalette := Value;
end;

procedure TcxSSColorComboBox.SetIncludeBrushes(const Value: Boolean);
begin
  FColorPanel.IncludeBrushes := Value;
end;

procedure TcxSSColorComboBox.SetFont(AFont: TFont);
begin
  FColorPanel.Font.Assign(AFont);
end;

procedure TcxSSColorComboBox.SetSelectedBrush(const Value: TcxSSFillStyle);
begin
  FColorPanel.SelectedBrush := Value;
end;

procedure TcxSSColorComboBox.SetSelectedColor(const Value: Byte);
begin
  FColorPanel.SelectedColor := Value;
end;

{ TcxCustomPropertyEditorForm }
procedure TcxCustomPropertyEditorForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_ESCAPE then
    ModalResult := mrCancel
  else
    if Key = VK_Return then
      ModalResult := mrOk;
end;

{ TcxSSColorPropertyEditor }
class function TcxSSColorPropertyEditor.Execute(var AColor: TcxSSColor): Boolean;
var
  I: Integer;
  AColorBox: TcxSSColorPanel;
begin
  with CreateColorEditor do
  try
    AColorBox := TcxSSColorPanel(Components[0]);
    if AColor <= 55 then
      AColorBox.SelectedColor := AColor;
    Result := (ShowModal = mrOk) and (AColorBox <> nil);
    if Result then
    begin
      AColor := AColorBox.SelectedColor;
      for I := 0 to ComponentCount - 1 do
        if (Components[I] is TCheckBox) and TCheckBox(Components[I]).Checked then
          AColor := 56;
    end;
  finally
    Free;
  end;
end;

class function TcxSSColorPropertyEditor.CreateColorEditor: TForm;
begin
  Result := TcxCustomPropertyEditorForm.CreateNew(nil);
  with Result do
  begin
    BorderIcons := [biSystemMenu];
    BorderStyle :=  bsDialog ;
    Caption := cxGetResourceString(@scxColorEditorCaption);
    SetBounds(300, 155, 180, 270);
  end;
  with TcxSSColorPanel.Create(Result) do
  begin
    Parent := Result;
    IncludeBrushes := False;
    SetBounds(7, 5, 158, 175);
    Visible := True;
  end;
  with TButton.Create(Result) do
  begin
    Parent := Result;
    SetBounds(10, 210, 70, 22);
    Caption := cxGetResourceString(@scxFormOk);
    ModalResult := mrOk;
  end;
  with TButton.Create(Result) do
  begin
    Parent := Result;
    SetBounds(90, 210, 70, 22);
    Caption := cxGetResourceString(@scxFormCancel);
    ModalResult := mrCancel;
  end;
  with TCheckBox.Create(Result) do
  begin
    Parent := Result;
    SetBounds(25, 183, 100, 20);
    Caption := cxGetResourceString(@scxUseDefaultColor);
  end;
  Result.KeyPreview := True;
end;

end.
