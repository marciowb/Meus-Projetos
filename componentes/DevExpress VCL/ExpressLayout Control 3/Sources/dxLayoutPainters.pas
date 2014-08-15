
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl main components                     }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit dxLayoutPainters;

{$I cxVer.inc}

interface

uses
  Classes, Types, Windows, Graphics, dxLayoutLookAndFeels, dxLayoutContainer,
  cxLookAndFeels, cxLookAndFeelPainters, dxLayoutCommon;

type
  TdxLayoutGroupStandardViewInfo = class;
  TdxLayoutGroupWebViewInfo = class;
  TdxLayoutGroupCaptionStandardViewInfo = class;

  { Painters }

  TdxLayoutGroupStandardPainter = class(TdxLayoutGroupPainter)
  private
    function GetViewInfo: TdxLayoutGroupStandardViewInfo;
  protected
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    procedure DoDrawBorders; override;
    procedure DrawFrame; virtual;
    property ViewInfo: TdxLayoutGroupStandardViewInfo read GetViewInfo;
  end;

  TdxLayoutGroupOfficePainter = class(TdxLayoutGroupStandardPainter)
  protected
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    procedure DrawFrame; override;
  end;

  TdxLayoutGroupWebPainter = class(TdxLayoutGroupPainter)
  private
    function GetLayoutLookAndFeel: TdxLayoutWebLookAndFeel;
    function GetViewInfo: TdxLayoutGroupWebViewInfo;
  protected
    procedure DoDrawBorders; override;
    function HasCaptionBackground: Boolean; override;
    function CanDrawCaptionSeparator: Boolean; virtual;
    procedure DoDrawCaptionSeparator; virtual;
    procedure DrawCaptionSeparator;
    procedure DrawFrame; virtual;
    property LayoutLookAndFeel: TdxLayoutWebLookAndFeel read GetLayoutLookAndFeel;
    property ViewInfo: TdxLayoutGroupWebViewInfo read GetViewInfo;
  end;

  TdxLayoutGroupCaptionStandardPainter = class(TdxLayoutGroupCaptionPainter)
  private
    function GetViewInfo: TdxLayoutGroupCaptionStandardViewInfo;
  protected
    procedure DoDrawText; override;
    property ViewInfo: TdxLayoutGroupCaptionStandardViewInfo read GetViewInfo;
  end;

  { ViewInfos }

  // standard

  TdxLayoutGroupCaptionStandardViewInfo = class(TdxLayoutGroupCaptionViewInfo)
  private
    function GetItemViewInfo: TdxLayoutGroupStandardViewInfo;
  protected
    function GetContentOffsets: TRect; override;
    function GetTextAreaBounds: TRect; override;
    property ItemViewInfo: TdxLayoutGroupStandardViewInfo read GetItemViewInfo;
  end;

  TdxLayoutGroupStandardViewInfo = class(TdxLayoutGroupViewInfo)
  private
    function GetCaptionViewInfo: TdxLayoutGroupCaptionStandardViewInfo;
    function GetStandardLookAndFeel: TdxLayoutStandardLookAndFeel;
  protected
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetMinVisibleHeight: Integer; override;
    function GetMinVisibleWidth: Integer; override;
    function GetButtonsViewInfoOffset: Integer; override;
    function GetCaptionViewInfoOffset: Integer; override;

    function GetFrameBounds: TRect; virtual;

    property CaptionViewInfoOffset: Integer read GetCaptionViewInfoOffset;
    property LayoutLookAndFeel: TdxLayoutStandardLookAndFeel read GetStandardLookAndFeel;
  public
    property CaptionViewInfo: TdxLayoutGroupCaptionStandardViewInfo read GetCaptionViewInfo;
    property FrameBounds: TRect read GetFrameBounds;
  end;

  // office
  TdxLayoutGroupOfficeViewInfo = class;

  TdxLayoutGroupCaptionOfficeViewInfo = class(TdxLayoutGroupCaptionViewInfo)
  private
    function GetGroupViewInfo: TdxLayoutGroupOfficeViewInfo;
  protected
    function GetContentOffsets: TRect; override;
  public
    function GetTextAreaBounds: TRect; override;
    property GroupViewInfo: TdxLayoutGroupOfficeViewInfo read GetGroupViewInfo;
  end;

  TdxLayoutGroupOfficeViewInfo = class(TdxLayoutGroupStandardViewInfo)
  protected
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetCaptionViewInfoOffset: Integer; override;
    function GetFrameBounds: TRect; override;
    function GetMinVisibleHeight: Integer; override;
    function GetMinVisibleWidth: Integer; override;
  end;

  // web

  TdxLayoutGroupCaptionWebViewInfo = class(TdxLayoutGroupCaptionViewInfo)
  private
    function GetItemViewInfo: TdxLayoutGroupWebViewInfo;
    function GetWebLookAndFeel: TdxLayoutWebLookAndFeel;
    function GetOptionsEx: TdxLayoutWebLookAndFeelGroupCaptionOptions;
    function GetSeparatorWidth: Integer;
  protected
    function GetAlignHorz: TAlignment; override;
    function GetAlignVert: TdxAlignmentVert; override;
    function GetColor: TColor; override;
    function IsDefaultColor: Boolean; override;

    property ItemViewInfo: TdxLayoutGroupWebViewInfo read GetItemViewInfo;
    property LookAndFeel: TdxLayoutWebLookAndFeel read GetWebLookAndFeel;
    property Options: TdxLayoutWebLookAndFeelGroupCaptionOptions read GetOptionsEx;
  public
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;

    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  TdxLayoutGroupWebViewInfo = class(TdxLayoutGroupViewInfo)
  private
    function GetCaptionViewInfo: TdxLayoutGroupCaptionWebViewInfo;
    function GetWebLookAndFeel: TdxLayoutWebLookAndFeel;
    function GetOptionsEx: TdxLayoutWebLookAndFeelGroupOptions;
  protected
    procedure CalculateButtonsViewInfoBounds; override;
    procedure CalculateCaptionViewInfoBounds; override;
    function CanDrawSpecificBackground: Boolean; override;
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetCaptionViewInfoOffset: Integer; override;
    function GetMinVisibleHeight: Integer; override;
    function GetMinVisibleWidth: Integer; override;
    function GetRestSpaceBounds: TRect; override;

    function GetCaptionSeparatorAreaBounds: TRect; virtual;
    function GetCaptionSeparatorBounds: TRect; virtual;

    function HasCaptionSeparator: Boolean;

    property LookAndFeel: TdxLayoutWebLookAndFeel read GetWebLookAndFeel;
    property Options: TdxLayoutWebLookAndFeelGroupOptions read GetOptionsEx;
  public
    property CaptionSeparatorAreaBounds: TRect read GetCaptionSeparatorAreaBounds;
    property CaptionSeparatorBounds: TRect read GetCaptionSeparatorBounds;
    property CaptionViewInfo: TdxLayoutGroupCaptionWebViewInfo read GetCaptionViewInfo;
  end;

  { TdxLayoutGroupCaptionCxLookAndFeelViewInfo }

  TdxLayoutGroupCaptionCxLookAndFeelViewInfo = class(TdxLayoutGroupCaptionStandardViewInfo)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    function GetContentOffsets: TRect; override;
  public
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  end;

  { TdxLayoutGroupCxLookAndFeelViewInfo }

  TdxLayoutGroupCxLookAndFeelViewInfo = class(TdxLayoutGroupStandardViewInfo)
  private
    function GetCXLookAndFeel: TdxLayoutCxLookAndFeel;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
    function GetCaptionViewInfo: TdxLayoutGroupCaptionCxLookAndFeelViewInfo;
  protected
    function CanDrawBackground: Boolean; override;
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
    function GetFrameBounds: TRect; override;
    function IsTransparent: Boolean; override;
    //
    property LayoutLookAndFeel: TdxLayoutCxLookAndFeel read GetCXLookAndFeel;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    property CaptionViewInfo: TdxLayoutGroupCaptionCxLookAndFeelViewInfo read GetCaptionViewInfo;
  end;

  { TdxLayoutGroupCaptionCxLookAndFeelPainter }

  TdxLayoutGroupCaptionCxLookAndFeelPainter = class(TdxLayoutGroupCaptionPainter)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  public
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  end;

  { TdxLayoutGroupCxLookAndFeelPainter }

  TdxLayoutGroupCxLookAndFeelPainter = class(TdxLayoutGroupStandardPainter)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    function CanDrawBackground: Boolean; override;
    function GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass; override;
    function HasCaptionBackground: Boolean; override;
    procedure DrawFrame; override;
  public
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  end;

  { TdxLayoutItemCaptionCxLookAndFeelViewInfo }

  TdxLayoutItemCaptionCxLookAndFeelViewInfo = class(TdxLayoutItemCaptionViewInfo)
  private
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  public
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  end;

  { TdxLayoutItemCxLookAndFeelViewInfo }

  TdxLayoutItemCxLookAndFeelViewInfo = class(TdxLayoutItemViewInfo)
  protected
    function CanDrawBackground: Boolean; override;
    function GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass; override;
  end;

  { TdxLayoutGroupSkinLookAndFeelViewInfo }

  TdxLayoutGroupSkinLookAndFeelViewInfo = class(TdxLayoutGroupCxLookAndFeelViewInfo)
  protected
    function GetBorderWidth(ASide: TdxLayoutSide): Integer; override;
  end;

implementation

uses
{$IFDEF DELPHI7}
  UxTheme, Themes,
{$ENDIF}
  Math, cxGraphics, cxGeometry;

const
  dxCaptionPositionMap: array[Boolean, TdxLayoutSide] of TcxGroupBoxCaptionPosition =
    ((cxgpCenter, cxgpCenter, cxgpCenter, cxgpCenter),
    (cxgpLeft, cxgpRight, cxgpTop, cxgpBottom));

type
  TdxCustomLayoutItemCaptionViewInfoAccess = class(TdxCustomLayoutItemCaptionViewInfo);
  TdxCustomLayoutLookAndFeelAccess = class(TdxCustomLayoutLookAndFeel);

{ TdxLayoutGroupStandardPainter }

function TdxLayoutGroupStandardPainter.GetViewInfo: TdxLayoutGroupStandardViewInfo;
begin
  Result := TdxLayoutGroupStandardViewInfo(inherited ViewInfo);
end;

function TdxLayoutGroupStandardPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutGroupCaptionStandardPainter;
end;

procedure TdxLayoutGroupStandardPainter.DoDrawBorders;
begin
  inherited;
  DrawFrame;
end;

procedure TdxLayoutGroupStandardPainter.DrawFrame;
var
  R: TRect;
begin
{$IFDEF DELPHI7}
  if ThemeServices.ThemesEnabled then
  begin
    ThemeServices.DrawElement(Canvas.Handle, ThemeServices.GetElementDetails(tbGroupBoxNormal),
      ViewInfo.FrameBounds);
    Exit;
  end;  
{$ENDIF}
  R := ViewInfo.FrameBounds;
  Canvas.DrawEdge(R, True, True);
  InflateRect(R, -1, -1);
  Canvas.DrawEdge(R, False, False);
end;

{ TdxLayoutGroupOfficePainter }

function TdxLayoutGroupOfficePainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutGroupCaptionPainter;
end;

procedure TdxLayoutGroupOfficePainter.DrawFrame;
const
  BordersMap: array[Boolean] of TcxBorders = ([bTop], [bLeft]);
var
  R: TRect;
begin
  R := ViewInfo.FrameBounds;
  with Canvas do
  begin
    DrawEdge(R, True, True, BordersMap[ViewInfo.IsVerticalCaption]);
    if ViewInfo.IsVerticalCaption then
      Inc(R.Left)
    else
      Inc(R.Top);
    DrawEdge(R, False, False, BordersMap[ViewInfo.IsVerticalCaption]);
  end;
end;

{ TdxLayoutGroupWebPainter }

function TdxLayoutGroupWebPainter.GetLayoutLookAndFeel: TdxLayoutWebLookAndFeel;
begin
  Result := TdxLayoutWebLookAndFeel(inherited LayoutLookAndFeel);
end;

function TdxLayoutGroupWebPainter.GetViewInfo: TdxLayoutGroupWebViewInfo;
begin
  Result := TdxLayoutGroupWebViewInfo(inherited ViewInfo);
end;

procedure TdxLayoutGroupWebPainter.DoDrawBorders;
begin
  DrawFrame;
  DrawCaptionSeparator;
  inherited;
end;

procedure TdxLayoutGroupWebPainter.DoDrawCaptionSeparator;
begin
  with Canvas do
  begin
    Brush.Color := ViewInfo.Color;
    FillRect(ViewInfo.CaptionSeparatorAreaBounds);
    Brush.Color := ViewInfo.Options.GetFrameColor;
    FillRect(ViewInfo.CaptionSeparatorBounds);
  end;
end;

function TdxLayoutGroupWebPainter.HasCaptionBackground: Boolean;
begin
  Result := False;
end;

function TdxLayoutGroupWebPainter.CanDrawCaptionSeparator: Boolean;
begin
  Result := ViewInfo.HasCaptionSeparator;
end;

procedure TdxLayoutGroupWebPainter.DrawCaptionSeparator;
begin
  if CanDrawCaptionSeparator then
    DoDrawCaptionSeparator;
end;

procedure TdxLayoutGroupWebPainter.DrawFrame;
var
  R: TRect;
  I: Integer;
begin
  if not ViewInfo.CaptionViewInfo.IsTransparent then
  begin
    Canvas.Brush.Color := ViewInfo.CaptionViewInfo.Color;
    R := cxRectInflate(ViewInfo.Bounds, -ViewInfo.Options.FrameWidth, -ViewInfo.Options.FrameWidth);
    case ViewInfo.CaptionSide of
      sdLeft:
        R.Right := R.Left + Max(ViewInfo.CaptionViewInfo.CalculateWidth, ViewInfo.ButtonsViewInfo.CalculateWidth);
      sdRight:
        R.Left := R.Right - Max(ViewInfo.CaptionViewInfo.CalculateWidth, ViewInfo.ButtonsViewInfo.CalculateWidth);
      sdTop:
        R.Bottom := R.Top + Max(ViewInfo.CaptionViewInfo.CalculateHeight, ViewInfo.ButtonsViewInfo.CalculateHeight);
      sdBottom:
        R.Top := R.Bottom - Max(ViewInfo.CaptionViewInfo.CalculateHeight, ViewInfo.ButtonsViewInfo.CalculateHeight);
    end;
    Canvas.FillRect(R);
  end;
  R := ViewInfo.Bounds;
  for I := 1 to ViewInfo.Options.FrameWidth do
  begin
    Canvas.FrameRect(R, ViewInfo.Options.GetFrameColor);
    InflateRect(R, -1, -1);
  end;
end;

{ TdxLayoutGroupCaptionStandardPainter }

procedure TdxLayoutGroupCaptionStandardPainter.DoDrawText;
const
  Enableds: array[Boolean] of Integer = (DTT_GRAYED, 0);
var
  ABitmap: TcxAlphaBitmap;
begin
  if (ViewInfo.TextColor = clDefault) and ThemeServices.ThemesEnabled then
  begin
    if ViewInfo.GetRotationAngle = ra0 then
      with ViewInfo do
        ThemeServices.DrawText(Canvas.Handle, ThemeServices.GetElementDetails(tbGroupBoxNormal),
          Text, TextAreaBounds, cxFlagsToDTFlags(CalculateTextFlags), Enableds[Enabled])
    else
    begin
      ABitmap := TcxAlphaBitmap.CreateSize(cxRectRotate(ViewInfo.TextAreaBounds), True);
      try
        with ViewInfo do
        begin
          PrepareCanvas(ABitmap.cxCanvas);
          ThemeServices.DrawText(ABitmap.cxCanvas.Handle, ThemeServices.GetElementDetails(tbGroupBoxNormal),
            Text, ABitmap.ClientRect, cxFlagsToDTFlags(CalculateTextFlags), Enableds[Enabled]);
          ABitmap.Rotate(ViewInfo.GetRotationAngle);
          cxDrawImage(Canvas.Handle, TextAreaBounds, TextAreaBounds, ABitmap, nil, -1, idmNormal);
        end;
      finally
        ABitmap.Free;
      end;
    end;
  end
  else
    inherited;
end;

function TdxLayoutGroupCaptionStandardPainter.GetViewInfo: TdxLayoutGroupCaptionStandardViewInfo;
begin
  Result := inherited ViewInfo as TdxLayoutGroupCaptionStandardViewInfo;
end;

{ TdxLayoutGroupStandardCaptionViewInfo }

function TdxLayoutGroupCaptionStandardViewInfo.GetItemViewInfo: TdxLayoutGroupStandardViewInfo;
begin
  Result := TdxLayoutGroupStandardViewInfo(inherited ItemViewInfo);
end;

function TdxLayoutGroupCaptionStandardViewInfo.GetContentOffsets: TRect;
begin
  if CaptionSide in [sdTop, sdBottom] then
    Result := Rect(2, 0, 2, 0)
  else
    Result := Rect(0, 2, 0, 2);
end;

function TdxLayoutGroupCaptionStandardViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if IsTextVisible and IsImageVisible and (GetTextHeight < GetImageHeight) then
    Result := cxRectOffset(Result, 0, (GetImageHeight - GetTextHeight) div 2);
end;

{ TdxLayoutGroupStandardViewInfo }

function TdxLayoutGroupStandardViewInfo.GetCaptionViewInfo: TdxLayoutGroupCaptionStandardViewInfo;
begin
  Result := TdxLayoutGroupCaptionStandardViewInfo(inherited CaptionViewInfo);
end;

function TdxLayoutGroupStandardViewInfo.GetStandardLookAndFeel: TdxLayoutStandardLookAndFeel;
begin
  Result := TdxLayoutStandardLookAndFeel(inherited LayoutLookAndFeel);
end;

function TdxLayoutGroupStandardViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutGroupCaptionStandardViewInfo;
end;

function TdxLayoutGroupStandardViewInfo.GetMinVisibleHeight: Integer;
begin
  Result := inherited GetMinVisibleHeight;
  if CaptionViewInfo.IsVerticalCaption then
  begin
    if HasCaption then
      Inc(Result, 2 * CaptionViewInfoOffset)
    else
      if HasButtons then
        Inc(Result, 2 * ButtonsViewInfoOffset);
  end;
end;

function TdxLayoutGroupStandardViewInfo.GetMinVisibleWidth: Integer;
begin
  Result := inherited GetMinVisibleWidth;
  if not CaptionViewInfo.IsVerticalCaption then
  begin
    if HasCaption then
      Inc(Result, 2 * CaptionViewInfoOffset)
    else
      if HasButtons then
        Inc(Result, 2 * ButtonsViewInfoOffset);
  end;
end;

function TdxLayoutGroupStandardViewInfo.GetButtonsViewInfoOffset: Integer;
begin
  Result := CaptionViewInfoOffset;
end;

function TdxLayoutGroupStandardViewInfo.GetCaptionViewInfoOffset: Integer;
begin
  Result := LayoutLookAndFeel.HDLUToPixels(CaptionViewInfo.Font, 7) - 2;
end;

function TdxLayoutGroupStandardViewInfo.GetFrameBounds: TRect;
var
  AIndent: Integer;
begin
  Result := Bounds;
  AIndent := LayoutLookAndFeel.VDLUToPixels(CaptionViewInfo.Font, 4) -
    LayoutLookAndFeel.FrameWidths[CaptionSide, CaptionSide] div 2;
  case CaptionSide of
    sdTop, sdBottom:
      AIndent := AIndent + (TdxCustomLayoutItemCaptionViewInfoAccess(CaptionViewInfo).GetAvailableHeight -
        TdxCustomLayoutItemCaptionViewInfoAccess(CaptionViewInfo).GetAvailableTextHeight) div 2;
    sdLeft, sdRight:
      AIndent := AIndent + (TdxCustomLayoutItemCaptionViewInfoAccess(CaptionViewInfo).GetAvailableWidth -
        TdxCustomLayoutItemCaptionViewInfoAccess(CaptionViewInfo).GetAvailableTextWidth) div 2;
  end;
  case CaptionSide of
    sdLeft:
      Result.Left := FCaptionAreaBounds.Left + AIndent;
    sdTop:
      Result.Top := FCaptionAreaBounds.Top + AIndent;
    sdRight:
      Result.Right := FCaptionAreaBounds.Right - AIndent;
    sdBottom:
      Result.Bottom := FCaptionAreaBounds.Bottom - AIndent;
  end;
end;

{ TdxLayoutGroupOfficeCaptionViewInfo }

function TdxLayoutGroupCaptionOfficeViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if IsTextVisible and IsImageVisible then
    if not IsVerticalCaption and (GetTextHeight < GetImageHeight) then
      Result := cxRectOffset(Result, 0, (GetImageHeight - GetTextHeight) div 2, CaptionSide = sdTop)
    else
      if IsVerticalCaption and (GetTextWidth < GetImageWidth) then
        Result := cxRectOffset(Result, 0, (GetImageWidth - GetTextWidth) div 2, CaptionSide = sdLeft)
end;

function TdxLayoutGroupCaptionOfficeViewInfo.GetContentOffsets: TRect;
var
  AOffset: Integer;
begin
  AOffset := LayoutLookAndFeel.HDLUToPixels(Font, 5);
  if IsVerticalCaption then
  begin
    Result := Rect(0, AOffset, 0, AOffset);
    if AlignVert = tavTop then
      Result.Top := 0;
    if AlignVert = tavBottom then
      Result.Bottom := 0;
  end
  else
  begin
    Result := Rect(AOffset, 0, AOffset, 0);
    if AlignHorz = taLeftJustify then
      Result.Left := 0;
    if AlignHorz = taRightJustify then
      Result.Right := 0;
  end;
end;

function TdxLayoutGroupCaptionOfficeViewInfo.GetGroupViewInfo: TdxLayoutGroupOfficeViewInfo;
begin
  Result := TdxLayoutGroupOfficeViewInfo(inherited GroupViewInfo);
end;

{ TdxLayoutGroupOfficeViewInfo }

function TdxLayoutGroupOfficeViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutGroupCaptionOfficeViewInfo;
end;

function TdxLayoutGroupOfficeViewInfo.GetCaptionViewInfoOffset: Integer;
begin
  Result := 0;
end;

function TdxLayoutGroupOfficeViewInfo.GetFrameBounds: TRect;
const
  BorderWidth = 2;
begin
  Result := inherited GetFrameBounds;
  case CaptionSide of
    sdLeft:
      Result.Right := Result.Left + BorderWidth;
    sdRight:
      Result.Left := Result.Right - BorderWidth;
    sdTop:
      Result.Bottom := Result.Top + BorderWidth;
    sdBottom:
      Result.Top := Result.Bottom - BorderWidth;
  end; 
end;

function TdxLayoutGroupOfficeViewInfo.GetMinVisibleHeight: Integer;
begin
  Result := inherited GetMinVisibleHeight;
  if (HasCaption or HasButtons) and IsVerticalCaption then
    Inc(Result, 20);
end;

function TdxLayoutGroupOfficeViewInfo.GetMinVisibleWidth: Integer;
begin
  Result := inherited GetMinVisibleWidth;
  if (HasCaption or HasButtons) and not IsVerticalCaption then
    Inc(Result, 20);
end;

{ TdxLayoutGroupCaptionWebViewInfo }

function TdxLayoutGroupCaptionWebViewInfo.GetItemViewInfo: TdxLayoutGroupWebViewInfo;
begin
  Result := TdxLayoutGroupWebViewInfo(inherited ItemViewInfo);
end;

function TdxLayoutGroupCaptionWebViewInfo.GetWebLookAndFeel: TdxLayoutWebLookAndFeel;
begin
  Result := TdxLayoutWebLookAndFeel(inherited LayoutLookAndFeel);
end;

function TdxLayoutGroupCaptionWebViewInfo.GetOptionsEx: TdxLayoutWebLookAndFeelGroupCaptionOptions;
begin
  Result := TdxLayoutWebLookAndFeelGroupCaptionOptions(inherited Options);
end;

function TdxLayoutGroupCaptionWebViewInfo.GetSeparatorWidth: Integer;
begin
  Result := Options.SeparatorWidth;
end;

function TdxLayoutGroupCaptionWebViewInfo.GetAlignHorz: TAlignment;
begin
  if IsVerticalCaption then
    Result := taCenter
  else
    Result := inherited GetAlignHorz;
end;

function TdxLayoutGroupCaptionWebViewInfo.GetAlignVert: TdxAlignmentVert;
begin
  if IsVerticalCaption then
    Result := inherited GetAlignVert
  else
    Result := tavCenter;
end;

function TdxLayoutGroupCaptionWebViewInfo.GetColor: TColor;
begin
  Result := Options.GetColor;
end;

function TdxLayoutGroupCaptionWebViewInfo.IsDefaultColor: Boolean;
begin
  Result := Options.Color = clDefault;
end;

function TdxLayoutGroupCaptionWebViewInfo.CalculateHeight: Integer;
begin
  if Visible and not IsVerticalCaption then
    Result := LookAndFeel.VDLUToPixels(Font, 11{12}) + Max(GetAvailableTextHeight, GetImageHeight) - GetAvailableTextHeight
  else
    Result := inherited CalculateHeight;
end;

function TdxLayoutGroupCaptionWebViewInfo.CalculateWidth: Integer;
begin
  if Visible and IsVerticalCaption then
    Result := LookAndFeel.VDLUToPixels(Font, 11{12}) + Max(GetAvailableTextWidth, GetImageWidth) - GetAvailableTextWidth
  else
    Result := inherited CalculateWidth;
end;

{ TdxLayoutGroupWebViewInfo }

function TdxLayoutGroupWebViewInfo.GetCaptionViewInfo: TdxLayoutGroupCaptionWebViewInfo;
begin
  Result := TdxLayoutGroupCaptionWebViewInfo(inherited CaptionViewInfo);
end;

function TdxLayoutGroupWebViewInfo.GetWebLookAndFeel: TdxLayoutWebLookAndFeel;
begin
  Result := TdxLayoutWebLookAndFeel(inherited LayoutLookAndFeel);
end;

function TdxLayoutGroupWebViewInfo.GetOptionsEx: TdxLayoutWebLookAndFeelGroupOptions;
begin
  Result := TdxLayoutWebLookAndFeelGroupOptions(inherited Options);
end;

procedure TdxLayoutGroupWebViewInfo.CalculateButtonsViewInfoBounds;
begin
  inherited;
  if IsVerticalCaption then
    FButtonsAreaBounds := cxRectOffset(FButtonsAreaBounds, Options.FrameWidth, -Options.FrameWidth, CaptionSide = sdLeft)
  else
    FButtonsAreaBounds := cxRectOffset(FButtonsAreaBounds, -Options.FrameWidth, Options.FrameWidth, CaptionSide = sdTop);
end;

procedure TdxLayoutGroupWebViewInfo.CalculateCaptionViewInfoBounds;
begin
  inherited;
  if IsVerticalCaption then
  begin
    FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, Options.FrameWidth, 0, CaptionSide = sdLeft);
    if CaptionViewInfo.AlignVert in [tavTop, tavBottom] then
      FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, 0, Options.FrameWidth, CaptionViewInfo.AlignVert = tavTop);
  end
  else
  begin
    FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, 0, Options.FrameWidth, CaptionSide = sdTop);
    if CaptionViewInfo.AlignHorz in [taLeftJustify, taRightJustify] then
      FCaptionAreaBounds := cxRectOffset(FCaptionAreaBounds, Options.FrameWidth, 0, CaptionViewInfo.AlignHorz = taLeftJustify);
  end;
end;

function TdxLayoutGroupWebViewInfo.CanDrawSpecificBackground: Boolean;
begin
  Result := False;
end;

function TdxLayoutGroupWebViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutGroupCaptionWebViewInfo;
end;

function TdxLayoutGroupWebViewInfo.GetCaptionViewInfoOffset: Integer;
begin
  if Options.OffsetCaption then
    Result := LookAndFeel.VDLUToPixels(CaptionViewInfo.Font, 5)
  else
    Result := LookAndFeel.DLUToPixels(CaptionViewInfo.Font, 2);
end;

function TdxLayoutGroupWebViewInfo.GetMinVisibleHeight: Integer;
begin
  Result := inherited GetMinVisibleHeight;
  if IsVerticalCaption then
  begin
    if HasCaption then
      Inc(Result, 2 * CaptionViewInfoOffset)
    else
      if HasButtons then
        Inc(Result, 2 * ButtonsViewInfoOffset);
    Inc(Result, 2 * Options.FrameWidth);
  end
  else
    if HasCaptionSeparator then
      Inc(Result, CaptionViewInfo.SeparatorWidth);
end;

function TdxLayoutGroupWebViewInfo.GetMinVisibleWidth: Integer;
begin
  Result := inherited GetMinVisibleWidth;
  if not IsVerticalCaption then
  begin
    if HasCaption then
      Inc(Result, 2 * CaptionViewInfoOffset)
    else
      if HasButtons then
        Inc(Result, 2 * ButtonsViewInfoOffset);
    Inc(Result, 2 * Options.FrameWidth);
  end
  else
    if HasCaptionSeparator then
      Inc(Result, CaptionViewInfo.SeparatorWidth);
end;

function TdxLayoutGroupWebViewInfo.GetRestSpaceBounds: TRect;
var
  ACaptionWidth: Integer;
  ACaptionHeight: Integer;
begin
  Result := cxRectInflate(inherited GetRestSpaceBounds, -Options.FrameWidth, -Options.FrameWidth);
  case CaptionSide of
    sdLeft:
      begin
        ACaptionWidth := Max(cxRectWidth(CaptionViewInfo.Bounds), cxRectWidth(ButtonsViewInfo.Bounds));
        if HasCaption or HasButtons then
          Inc(Result.Left, ACaptionWidth);
        if HasCaptionSeparator then
          Inc(Result.Left, CaptionViewInfo.SeparatorWidth);
      end;
    sdRight:
      begin
        ACaptionWidth := Max(cxRectWidth(CaptionViewInfo.Bounds), cxRectWidth(ButtonsViewInfo.Bounds));
        if HasCaption or HasButtons then
          Dec(Result.Right, ACaptionWidth);
        if HasCaptionSeparator then
          Dec(Result.Right, CaptionViewInfo.SeparatorWidth);
      end;
    sdTop:
      begin
        ACaptionHeight := Max(cxRectHeight(CaptionViewInfo.Bounds), cxRectHeight(ButtonsViewInfo.Bounds));
        if HasCaption or HasButtons then
          Inc(Result.Top, ACaptionHeight);
        if HasCaptionSeparator then
          Inc(Result.Top, CaptionViewInfo.SeparatorWidth);
      end;
    sdBottom:
      begin
        ACaptionHeight := Max(cxRectHeight(CaptionViewInfo.Bounds), cxRectHeight(ButtonsViewInfo.Bounds));
        if HasCaption or HasButtons then
          Dec(Result.Bottom, ACaptionHeight);
        if HasCaptionSeparator then
          Dec(Result.Bottom, CaptionViewInfo.SeparatorWidth);
      end;
  end;
end;

function TdxLayoutGroupWebViewInfo.GetCaptionSeparatorAreaBounds: TRect;
begin
  Result := RestSpaceBounds;
  case CaptionSide of
    sdLeft:
      begin
        Result.Right := Result.Left;
        Dec(Result.Left, CaptionViewInfo.SeparatorWidth);
      end;
    sdRight:
      begin
        Result.Left := Result.Right;
        Inc(Result.Right, CaptionViewInfo.SeparatorWidth);
      end;
    sdTop:
      begin
        Result.Bottom := Result.Top;
        Dec(Result.Top, CaptionViewInfo.SeparatorWidth);
      end;
    sdBottom:
      begin
        Result.Top := Result.Bottom;
        Inc(Result.Bottom, CaptionViewInfo.SeparatorWidth);
      end;
  end;
end;

function TdxLayoutGroupWebViewInfo.GetCaptionSeparatorBounds: TRect;
begin
  Result := CaptionSeparatorAreaBounds;
  if not Options.OffsetCaption and not Options.OffsetItems and
    (Options.FrameWidth = 0) and (CaptionViewInfo.Color = Color) then
  begin
    Result.Left := ClientBounds.Left;
    Result.Right := ClientBounds.Right;
  end;
end;

function TdxLayoutGroupWebViewInfo.HasCaptionSeparator: Boolean;
begin
  Result := IsExpanded and Options.HasCaptionSeparator(HasCaption or HasButtons);
end;

{ TdxLayoutGroupCaptionCxLookAndFeelViewInfo }

function TdxLayoutGroupCaptionCxLookAndFeelViewInfo.GetContentOffsets: TRect;
begin
  Result := LookAndFeelPainter.GroupBoxBorderSize(True, dxCaptionPositionMap[True, CaptionSide]);
  if IsVerticalCaption then
  begin
    Result.Top := 2;
    Result.Bottom := 2;
  end
  else
  begin
    Result.Left := 2;
    Result.Right := 2;
  end;
end;

function TdxLayoutGroupCaptionCxLookAndFeelViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TdxLayoutCxLookAndFeel(LayoutLookAndFeel).LookAndFeel.Painter;
end;

{ TdxLayoutGroupCxLookAndFeelViewInfo }

function TdxLayoutGroupCxLookAndFeelViewInfo.CanDrawBackground: Boolean;
begin
  Result := inherited CanDrawBackground and not (IsSkinPainterUsed and Group.IsRoot);
end;

function TdxLayoutGroupCxLookAndFeelViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutGroupCaptionCxLookAndFeelViewInfo;
end;

function TdxLayoutGroupCxLookAndFeelViewInfo.GetFrameBounds: TRect;
begin
  if IsSkinPainterUsed then
  begin
    Result := Bounds;
    if HasCaption or HasButtons then
    begin
      case CaptionSide of
        sdLeft:
          Result.Left := Result.Left + Max(CaptionViewInfo.GetAvailableWidth, ButtonsViewInfo.CalculateWidth);
        sdRight:
          Result.Right := Result.Right - Max(CaptionViewInfo.GetAvailableWidth, ButtonsViewInfo.CalculateWidth);
        sdTop:
          Result.Top := Result.Top + Max(CaptionViewInfo.GetAvailableHeight, ButtonsViewInfo.CalculateHeight);
        sdBottom:
          Result.Bottom := Result.Bottom - Max(CaptionViewInfo.GetAvailableHeight, ButtonsViewInfo.CalculateHeight);
      end;
    end;
  end
  else
    Result := inherited GetFrameBounds;
end;

function TdxLayoutGroupCxLookAndFeelViewInfo.IsTransparent: Boolean;
begin
  Result := TdxCustomLayoutLookAndFeelAccess(LayoutLookAndFeel).IsGroupTransparent;
end;

function TdxLayoutGroupCxLookAndFeelViewInfo.GetCXLookAndFeel: TdxLayoutCxLookAndFeel;
begin
  Result := TdxLayoutCxLookAndFeel(inherited LayoutLookAndFeel);
end;

function TdxLayoutGroupCxLookAndFeelViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LayoutLookAndFeel.LookAndFeelPainter;
end;

function TdxLayoutGroupCxLookAndFeelViewInfo.GetCaptionViewInfo: TdxLayoutGroupCaptionCxLookAndFeelViewInfo;
begin
  Result := inherited CaptionViewInfo as TdxLayoutGroupCaptionCxLookAndFeelViewInfo;
end;

{ TdxLayoutGroupCaptionCxLookAndFeelPainter }

function TdxLayoutGroupCaptionCxLookAndFeelPainter.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TdxLayoutCxLookAndFeel(LayoutLookAndFeel).LookAndFeelPainter;
end;

{ TdxLayoutGroupCxLookAndFeelPainter }

procedure TdxLayoutGroupCxLookAndFeelPainter.DrawFrame;
var
  R: TRect;
  AHasCaption: Boolean;
begin
  R := ViewInfo.FrameBounds;
  AHasCaption := ViewInfo.HasCaption or ViewInfo.HasButtons;
  LookAndFeelPainter.DrawGroupBoxFrame(Canvas, R, ViewInfo.Enabled, dxCaptionPositionMap[AHasCaption, ViewInfo.CaptionSide]);
  if ViewInfo.IsSkinPainterUsed and AHasCaption then
  begin
    R := ViewInfo.Bounds;
    case ViewInfo.CaptionSide of
      sdLeft:
        R.Right := ViewInfo.FrameBounds.Left;
      sdRight:
        R.Left := ViewInfo.FrameBounds.Right;
      sdTop:
        R.Bottom := ViewInfo.FrameBounds.Top;
      sdBottom:
        R.Top := ViewInfo.FrameBounds.Bottom;
    end;
    LookAndFeelPainter.DrawGroupBoxCaption(Canvas, R, dxCaptionPositionMap[True, ViewInfo.CaptionSide]);
  end;
end;

function TdxLayoutGroupCxLookAndFeelPainter.CanDrawBackground: Boolean;
begin
  Result := not ViewInfo.IsSkinPainterUsed and inherited CanDrawBackground;
end;

function TdxLayoutGroupCxLookAndFeelPainter.GetCaptionPainterClass: TdxCustomLayoutItemCaptionPainterClass;
begin
  Result := TdxLayoutGroupCaptionCxLookAndFeelPainter;
end;

function TdxLayoutGroupCxLookAndFeelPainter.HasCaptionBackground: Boolean;
begin
  Result := not ViewInfo.IsSkinPainterUsed;
end;

function TdxLayoutGroupCxLookAndFeelPainter.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TdxLayoutCxLookAndFeel(LayoutLookAndFeel).LookAndFeelPainter;
end;

{ TdxLayoutItemCxLookAndFeelViewInfo }

function TdxLayoutItemCxLookAndFeelViewInfo.CanDrawBackground: Boolean;
begin
  Result := False;
end;

function TdxLayoutItemCxLookAndFeelViewInfo.GetCaptionViewInfoClass: TdxCustomLayoutItemCaptionViewInfoClass;
begin
  Result := TdxLayoutItemCaptionCxLookAndFeelViewInfo;
end;

{ TdxLayoutItemCaptionCxLookAndFeelViewInfo }

function TdxLayoutItemCaptionCxLookAndFeelViewInfo.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TdxLayoutCxLookAndFeel(LayoutLookAndFeel).LookAndFeelPainter;
end;

{ TdxLayoutGroupSkinLookAndFeelViewInfo }

function TdxLayoutGroupSkinLookAndFeelViewInfo.GetBorderWidth(ASide: TdxLayoutSide): Integer;
begin
  if IsSkinPainterUsed and not IsExpanded and (ASide = CaptionSide) then
  begin
    if IsVerticalCaption then
      Result := Max(CaptionViewInfo.GetAvailableWidth, ButtonsViewInfo.CalculateWidth)
    else
      Result := Max(CaptionViewInfo.GetAvailableHeight, ButtonsViewInfo.CalculateHeight)
  end
  else
    Result := inherited GetBorderWidth(ASide);
end;

end.
