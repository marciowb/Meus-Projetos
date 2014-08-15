{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxNavBarXPViews;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, dxNavBarCollns,
  dxNavBar, dxNavBarStyles, dxNavBarBaseViews, dxNavBarOfficeViews,
  dxNavBarExplorerViews;

type
  TdxNavBarXP1GroupViewInfo = class(TdxNavBarGroupViewInfo)
  private
    function IsDefaultBgColor: Boolean;
    function IsDefaultCaptionColor: Boolean;
  public
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
  end;

  TdxNavBarXP1ViewInfo = class(TdxNavBarBaseViewInfo)
  public
    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
  end;

  TdxNavBarXP1Painter = class(TdxNavBarFlatPainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
      ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; override;

    class function ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass; override;
    class function SelectionPainterClass: TdxBaseSelectionPainterClass; override;
  public
    procedure DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo); override;
  end;

  TdxNavBarXP2Painter = class(TdxNavBarOffice1Painter)
  protected
    class function BackgroundPainterClass: TdxBaseBackgroundPainterClass; override;
    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
    class function GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass; override;
    class function ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass; override;
    class function SelectionPainterClass: TdxBaseSelectionPainterClass; override;
  end;

  TdxNavBarXPExplorerBarLinkViewInfo = class(TdxNavBarLinkViewInfo)
  public
    function Font: TFont; override;
    function FontColor: TColor; override;
  end;

  TdxNavBarXPExplorerBarGroupViewInfo = class(TdxNavBarGroupViewInfo)
  public
    function BorderColor: TColor; override;
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;
    function CaptionBackColor: TColor; override;
    function CaptionBackColor2: TColor; override;
    function CaptionAlphaBlend: Byte; override;
    function CaptionAlphaBlend2: Byte; override;
    function CaptionGradientMode: TdxBarStyleGradientMode; override;
    function CaptionFont: TFont; override;
    function CaptionFontColor: TColor; override;
  end;

  TdxNavBarXPExplorerBarViewInfo = class(TdxNavBarExplorerBarViewInfo)
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;
  public
    class function GetGroupCaptionHeightAddon: Integer; override;
    class function GetGroupCaptionSignSize: Integer; override;

    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;
  end;

  TdxNavBarXPExplorerBarPainter = class(TdxNavBarExplorerBarPainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
      ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; override;
    function CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
      ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo; override;

    class function BackgroundPainterClass: TdxBaseBackgroundPainterClass; override;
    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
    class function SignPainterClass: TdxBaseSignPainterClass; override;
  end;

implementation

uses
  CommCtrl, ImgList, Buttons,
  dxNavBarViewsFact, dxNavBarGraphics, dxNavBarConsts,
  dxThemeConsts, dxUxTheme, dxThemeManager;

{ TdxNavBarXP1GroupViewInfo }

function TdxNavBarXP1GroupViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarXP1GroupViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarXP1GroupViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := LightLightColor(clInactiveCaption)
  else Result := inherited BgBackColor;
end;

function TdxNavBarXP1GroupViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := clInactiveCaption
  else Result := inherited BgBackColor2;
end;

function TdxNavBarXP1GroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmHorizontal
  else Result := inherited BgGradientMode;
end;

function TdxNavBarXP1GroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else Result := inherited CaptionAlphaBlend;
end;

function TdxNavBarXP1GroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else Result := inherited CaptionAlphaBlend2;
end;

function TdxNavBarXP1GroupViewInfo.CaptionBackColor: TColor;
begin
  if IsDefaultCaptionColor then
    Result := clActiveCaption
  else Result := inherited CaptionBackColor;
end;

function TdxNavBarXP1GroupViewInfo.CaptionBackColor2: TColor;
begin
  if IsDefaultCaptionColor then
  begin
    if Group = NavBar.HotTrackedGroup then
      Result := clActiveCaption
    else Result := DarkColor(clActiveCaption);
  end
  else Result := inherited CaptionBackColor2;
end;

function TdxNavBarXP1GroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultCaptionColor then
    Result := gmHorizontal
  else Result := inherited CaptionGradientMode;
end;

function TdxNavBarXP1GroupViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone);
end;

function TdxNavBarXP1GroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavBarXP1ViewInfo }

procedure TdxNavBarXP1ViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clAppWorkSpace;
  NavBar.DefaultStyles.Background.BackColor2 := clAppWorkSpace;
end;

procedure TdxNavBarXP1ViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clNone;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clNone;
end;

procedure TdxNavBarXP1ViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clCaptionText;
  NavBar.DefaultStyles.GroupHeader.HAlignment := haCenter;
end;

procedure TdxNavBarXP1ViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clBtnText;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarXP1ViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clBtnShadow;
end;

{ TdxNavBarXP1Painter }

procedure TdxNavBarXP1Painter.DrawGroupCaptionButton(AGroupViewInfo: TdxNavBarGroupViewInfo);
var
  Color1, Color2: TColor;
begin
  with AGroupViewInfo do
  begin
    Color1 := LightLightColor(CaptionBackColor);
    if NavBar.HotTrackedGroup = Group then
      Color2 := LightColor(CaptionBackColor)
    else Color2 := CaptionBackColor;
    ButtonPainterClass.DrawButton(Canvas, CaptionRect, CaptionImage,
      Color1, Color2, CaptionAlphaBlend, CaptionAlphaBlend2,
      CaptionGradientMode, CaptionBorderColor, State);
  end;
end;

function TdxNavBarXP1Painter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarXP1ViewInfo.Create(Self);
end;

function TdxNavBarXP1Painter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarXP1GroupViewInfo.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

class function TdxNavBarXP1Painter.ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass;
begin
  Result := TdxNavBarXPScrollButtonsPainter;
end;

class function TdxNavBarXP1Painter.SelectionPainterClass: TdxBaseSelectionPainterClass;
begin
  Result := TdxNavBarXPSelectionPainter;
end;

{ TdxNavBarXP2Painter }

class function TdxNavBarXP2Painter.BackgroundPainterClass: TdxBaseBackgroundPainterClass;
begin
  Result := TdxNavBarXPBackgroundPainter;
end;

class function TdxNavBarXP2Painter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarXPButtonPainter;
end;

class function TdxNavBarXP2Painter.GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass;
begin
  Result := TdxNavBarXPGroupBackgroundPainter;
end;

class function TdxNavBarXP2Painter.ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass;
begin
  Result := TdxNavBarXPScrollButtonsPainter;
end;

class function TdxNavBarXP2Painter.SelectionPainterClass: TdxBaseSelectionPainterClass;
begin
  Result := TdxNavBarXPSelectionPainter;
end;

{ TdxNavBarXPExplorerBarLinkViewInfo }

function TdxNavBarXPExplorerBarLinkViewInfo.Font: TFont;
var
  AFont: TFont;
begin
  Result := inherited Font;
  if (OpenTheme(totExplorerBar) <> 0) and CheckShellInstance then
  begin
    if sHotTracked in State then
      AFont := dxXPExplorerBarItemFontHot
    else AFont := dxXPExplorerBarItemFont;
    if AFont <> nil then
    begin
      Result.Assign(AFont);
      if sDisabled in State then
        Result.Style := Result.Style - [fsUnderline];
    end;
  end;
end;

function TdxNavBarXPExplorerBarLinkViewInfo.FontColor: TColor;
begin
  Result := inherited FontColor;
  if (OpenTheme(totExplorerBar) <> 0) and CheckShellInstance then
  begin
    Result := Font.Color;
    if sDisabled in State then
      Result := LightColor(Result);
  end;
end;

{ TdxNavBarXPExplorerBarGroupViewInfo }

function TdxNavBarXPExplorerBarGroupViewInfo.BorderColor: TColor;
var
  APart: Integer;
  AColor: COLORREF;
begin
  APart := EBP_NORMALGROUPBACKGROUND;
  if dxXPExplorerBarGroupBorderColor <> clNone then
    Result := dxXPExplorerBarGroupBorderColor
  else if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_BORDERCOLOR, AColor)) then
    Result := AColor
  else Result := inherited BorderColor;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.BgBackColor: TColor;
var
  APart: Integer;
  AColor: COLORREF;
begin
  APart := EBP_NORMALGROUPBACKGROUND;
  if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_FILLCOLOR, AColor)) then
    Result := AColor
  else if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_GRADIENTCOLOR1, AColor)) then
    Result := AColor
  else Result := inherited BgBackColor;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.BgBackColor2: TColor;
var
  APart: Integer;
  AColor: COLORREF;
begin
  APart := EBP_NORMALGROUPBACKGROUND;
  if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_FILLCOLOR, AColor)) then
    Result := AColor
  else if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_GRADIENTCOLOR2, AColor)) then
    Result := AColor
  else Result := inherited BgBackColor2;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.BgAlphaBlend: Byte;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.BgAlphaBlend2: Byte;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := gmHorizontal
  else Result := inherited BgGradientMode;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionBackColor: TColor;
var
  APart: Integer;
  AColor: COLORREF;
begin
  if sSpecial in State then
    APart := EBP_SPECIALGROUPHEAD
  else APart := EBP_NORMALGROUPHEAD;
  if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_FILLCOLOR, AColor)) then
    Result := AColor
  else if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_GRADIENTCOLOR1, AColor)) then
    Result := AColor
  else Result := inherited CaptionBackColor;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionBackColor2: TColor;
var
  APart: Integer;
  AColor: COLORREF;
begin
  if sSpecial in State then
    APart := EBP_SPECIALGROUPHEAD
  else APart := EBP_NORMALGROUPHEAD;
  if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_FILLCOLOR, AColor)) then
    Result := AColor
  else if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), APart, 0, TMT_GRADIENTCOLOR2, AColor)) then
    Result := AColor
  else Result := inherited CaptionBackColor2;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := 255
  else Result := inherited CaptionAlphaBlend;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := 255
  else Result := inherited CaptionAlphaBlend2;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := gmHorizontal
  else Result := inherited CaptionGradientMode;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionFont: TFont;
var
  AFont: TFont;
begin
  Result := inherited CaptionFont;
  if (OpenTheme(totExplorerBar) <> 0) and CheckShellInstance then
  begin
    if sHotTracked in State then
      AFont := dxXPExplorerBarGroupHeaderFontHot
    else AFont := dxXPExplorerBarGroupHeaderFont;
    if AFont <> nil then
    begin
      Result.Assign(AFont);
      Result.Style := Result.Style - [fsUnderline];
    end;
  end;
end;

function TdxNavBarXPExplorerBarGroupViewInfo.CaptionFontColor: TColor;
begin
  if (OpenTheme(totExplorerBar) <> 0) and CheckShellInstance then
  begin
    Result := CaptionFont.Color;
    if sSpecial in State then Result := clWhite;
  end
  else Result := inherited CaptionFontColor;
end;

{ TdxNavBarXPExplorerBarViewInfo }

class function TdxNavBarXPExplorerBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  if OpenTheme(totExplorerBar) = 0 then
    Result := inherited GetGroupCaptionHeightAddon
  else Result := 12;
end;

class function TdxNavBarXPExplorerBarViewInfo.GetGroupCaptionSignSize: Integer;
begin
  if OpenTheme(totExplorerBar) = 0 then
    Result := inherited GetGroupCaptionSignSize
  else Result := 22;
end;

function TdxNavBarXPExplorerBarViewInfo.BgBackColor: TColor;
var
  AColor: COLORREF;
begin
  if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), EBP_HEADERBACKGROUND, -1, TMT_GRADIENTCOLOR1, AColor)) then
    Result := AColor
  else Result := inherited BgBackColor;
end;

function TdxNavBarXPExplorerBarViewInfo.BgBackColor2: TColor;
var
  AColor: COLORREF;
begin
  if (OpenTheme(totExplorerBar) <> 0) and not Failed(GetThemeColor(OpenTheme(totExplorerBar), EBP_HEADERBACKGROUND, -1, TMT_GRADIENTCOLOR2, AColor)) then
    Result := AColor
  else Result := inherited BgBackColor2;
end;

function TdxNavBarXPExplorerBarViewInfo.BgAlphaBlend: Byte;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarXPExplorerBarViewInfo.BgAlphaBlend2: Byte;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarXPExplorerBarViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if OpenTheme(totExplorerBar) <> 0 then
    Result := gmVertical
  else Result := inherited BgGradientMode;
end;

procedure TdxNavBarXPExplorerBarViewInfo.CreateColors;
begin
  CreateXPExplorerBarColors;
end;

procedure TdxNavBarXPExplorerBarViewInfo.RefreshColors;
begin
  RefreshXPExplorerBarColors;
end;

procedure TdxNavBarXPExplorerBarViewInfo.ReleaseColors;
begin
  ReleaseXPExplorerBarColors;
end;

{ TdxNavBarXPExplorerBarPainter }

function TdxNavBarXPExplorerBarPainter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarXPExplorerBarGroupViewInfo.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

function TdxNavBarXPExplorerBarPainter.CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarXPExplorerBarLinkViewInfo.Create(AViewInfo, ALink, ACaptionVisible, AImageVisisble);
end;

function TdxNavBarXPExplorerBarPainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarXPExplorerBarViewInfo.Create(Self);
end;

class function TdxNavBarXPExplorerBarPainter.BackgroundPainterClass: TdxBaseBackgroundPainterClass;
begin
  Result := TdxNavBarXPExplorerBarBackgroundPainter;
end;

class function TdxNavBarXPExplorerBarPainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarXPExplorerBarButtonPainter;
end;

class function TdxNavBarXPExplorerBarPainter.SignPainterClass: TdxBaseSignPainterClass;
begin
  Result := TdxNavBarXPExplorerBarSignPainter;
end;

initialization
  RegisterView(dxNavBarXP1View, 'XP1View', TdxNavBarXP1Painter);
  RegisterView(dxNavBarXP2View, 'XP2View', TdxNavBarXP2Painter);
  RegisterView(dxNavBarXPExplorerBarView, 'XPExplorerBarView', TdxNavBarXPExplorerBarPainter);

finalization
  UnRegisterView(dxNavBarXP1View);
  UnRegisterView(dxNavBarXP2View);
  UnRegisterView(dxNavBarXPExplorerBarView);

end.
