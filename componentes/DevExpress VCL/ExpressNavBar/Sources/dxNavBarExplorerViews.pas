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

unit dxNavBarExplorerViews;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, dxNavBar, dxNavBarBase, dxNavBarCollns, dxNavBarStyles;

type
  TdxNavBarExplorerBarViewInfo = class(TdxNavBarViewInfo)
  protected
    class function GetGroupBorderWidth: Integer; override;
    class function GetGroupCaptionHeightAddon: Integer; override;
    class function GetGroupCaptionSignSize: Integer; override;
    class function GetGroupSeparatorWidth: Integer; override;
    class function GetGroupHorizontalEdge: Integer; override;

    function CanHasActiveGroup: Boolean; override;
    function CanHasSpecialGroup: Boolean; override;
    function CanHasImageInGroupCaption: Boolean; override;
    function CanHasSignInGroupCaption: Boolean; override;
    function CanHasGroupViewAsIconView: Boolean; override;
    function CanHasGroupWithNoCaption: Boolean; override;
    function CanHasVisibleItemsInGroup(AGroup: TdxNavBarGroup): Boolean; override;
  public
    procedure CreateInfo; override;
    procedure CalculateBounds; override;
    procedure CorrectScrollInfo; virtual;

    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultGroupHeaderActiveStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
    procedure AssignDefaultItemHotTrackedStyle; override;

    procedure DoGroupActivate(AGroup: TdxNavBarGroup); override;
    procedure DoGroupDeactivate(AGroup: TdxNavBarGroup); override;
    function IsGroupActive(AGroup: TdxNavBarGroup): Boolean; override;
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink); override;
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup); override;
  end;

  TdxNavBarExplorerBarPainter = class(TdxNavBarPainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;

    class function BackgroundPainterClass: TdxBaseBackgroundPainterClass; override;
    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
    class function DropTargetGroupPainterClass: TdxBaseDropTargetGroupPainterClass; override;
    class function DropTargetLinkPainterClass: TdxBaseDropTargetLinkPainterClass; override;
    class function GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass; override;
    class function GroupBorderPainterClass: TdxBaseGroupBorderPainterClass; override;
    class function ImagePainterClass: TdxBaseImagePainterClass; override;
    class function SignPainterClass: TdxBaseSignPainterClass; override;
  end;

  TdxNavBarUltraFlatExplorerBarPainter = class(TdxNavBarExplorerBarPainter)
  protected
    class function SelectionPainterClass: TdxBaseSelectionPainterClass; override;
  end;

  TdxNavBarAdvExplorerBarLinkViewInfo = class(TdxNavBarLinkViewInfo)
  public
    function FontColor: TColor; override;
  end;

  TdxNavBarAdvExplorerBarGroupViewInfo = class(TdxNavBarGroupViewInfo)
  private
    function IsDefaultBgColor: Boolean;
    function IsDefaultCaptionColor: Boolean;
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
    function CaptionFontColor: TColor; override;
    function CaptionSignColor: TColor; override;
  end;

  TdxNavBarAdvExplorerBarViewInfo = class(TdxNavBarExplorerBarViewInfo)
  private
    function IsDefaultBgColor: Boolean;
  protected
    procedure CreateColors; override;
    procedure RefreshColors; override;
    procedure ReleaseColors; override;

    class function GetGroupCaptionHeightAddon: Integer; override;
    class function GetGroupCaptionSignSize: Integer; override;
  public
    function BgBackColor: TColor; override;
    function BgBackColor2: TColor; override;
    function BgAlphaBlend: Byte; override;
    function BgAlphaBlend2: Byte; override;
    function BgGradientMode: TdxBarStyleGradientMode; override;

    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultGroupHeaderActiveStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
  end;

  TdxNavBarAdvExplorerBarPainter = class(TdxNavBarExplorerBarPainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    function CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
      ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo; override;
    function CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
      ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo; override;

    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
    class function SignPainterClass: TdxBaseSignPainterClass; override;
  end;

implementation

uses
  CommCtrl, ImgList,
  dxNavBarViewsFact, dxNavBarGraphics, dxNavBarConsts;

function GetColor(ANormalColor, AHotColor: TColor;
  AState: TdxNavBarObjectStates): TColor;
begin
  if sDisabled in AState then
    Result := LightLightColor(ANormalColor)
  else
    if AState * [sHotTracked, sPressed, sSelected] <> [] then
      Result := AHotColor
    else
      Result := ANormalColor;
end;

{ TdxNavBarExplorerBarViewInfo }

class function TdxNavBarExplorerBarViewInfo.GetGroupBorderWidth: Integer;
begin
  Result := 1;
end;

class function TdxNavBarExplorerBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 12;
end;

class function TdxNavBarExplorerBarViewInfo.GetGroupCaptionSignSize: Integer;
begin
  Result := 18;
end;

class function TdxNavBarExplorerBarViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 4;
end;

class function TdxNavBarExplorerBarViewInfo.GetGroupHorizontalEdge: Integer;
begin
  Result := 10;
end;

function TdxNavBarExplorerBarViewInfo.CanHasActiveGroup: Boolean;
begin
  Result := False;
end;

function TdxNavBarExplorerBarViewInfo.CanHasSpecialGroup: Boolean;
begin
  Result := True;
end;

function TdxNavBarExplorerBarViewInfo.CanHasImageInGroupCaption: Boolean;
begin
  Result := True;
end;

function TdxNavBarExplorerBarViewInfo.CanHasSignInGroupCaption: Boolean;
begin
  Result := True;
end;

function TdxNavBarExplorerBarViewInfo.CanHasGroupViewAsIconView: Boolean;
begin
  Result := False;
end;

function TdxNavBarExplorerBarViewInfo.CanHasGroupWithNoCaption: Boolean;
begin
  Result := True;
end;

function TdxNavBarExplorerBarViewInfo.CanHasVisibleItemsInGroup(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := AGroup.Expanded;
end;

procedure TdxNavBarExplorerBarViewInfo.CreateInfo;
var
  I: Integer;
begin
  ClearGroups;
  for I := 0 to NavBar.Groups.Count - 1 do
    if NavBar.Groups[I].Visible then
      AddGroup(Self, NavBar.Groups[I], True, True);
end;

procedure TdxNavBarExplorerBarViewInfo.CalculateBounds;
begin
  inherited;
  CorrectScrollInfo;
  AdjustControlsBounds;
end;

procedure TdxNavBarExplorerBarViewInfo.CorrectScrollInfo;
var
  I, AHeight: Integer;
  ADelta: Double;
  AOldVisible: Boolean;
  AMin, AMax, APageSize: Integer;
begin
  AOldVisible := NavBar.ScrollBar.Visible;
  if GroupCount > 0 then
  begin
    AHeight := Groups[GroupCount - 1].Rect.Bottom + GetSpaceBetweenGroups;
    if AHeight > ClientHeight then
    begin
      ADelta := (ClientHeight * NavBar.ScrollBar.Height) / AHeight;
      APageSize := Round(ADelta);
      AMin := 0;
      AMax := AHeight - ClientHeight + Round(ADelta);

      NavBar.ScrollBar.SmallChange := GetGroupCaptionSignSize;
      NavBar.ScrollBar.SetScrollParams(AMin, AMax, NavBar.ScrollBar.Position, APageSize);
      NavBar.ScrollBar.Visible := True;
    end
    else
      NavBar.ScrollBar.Visible := False;
  end
  else
    NavBar.ScrollBar.Visible := False;

  if AOldVisible = NavBar.ScrollBar.Visible then
  begin
    for I := 0 to GroupCount - 1 do
      Groups[I].CorrectBounds(0, - NavBar.ScrollPosition);
  end
  else CalculateBounds;
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clWindow;
  NavBar.DefaultStyles.Background.BackColor2 := clWindow;
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clWindow;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clWindow;
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clBtnText;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActive.Assign(NavBar.DefaultStyles.GroupHeader);
  NavBar.DefaultStyles.GroupHeaderActive.BackColor := clActiveCaption;
  NavBar.DefaultStyles.GroupHeaderActive.BackColor2 := clActiveCaption;
  NavBar.DefaultStyles.GroupHeaderActive.Font.Color := clCaptionText;
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clWindowText;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemDisabled.Font.Color := clGrayText;
end;

procedure TdxNavBarExplorerBarViewInfo.AssignDefaultItemHotTrackedStyle;
begin
  NavBar.DefaultStyles.ItemHotTracked.Assign(NavBar.DefaultStyles.Item);
  NavBar.DefaultStyles.ItemHotTracked.Font.Style := NavBar.DefaultStyles.ItemHotTracked.Font.Style + [fsUnderline];
end;

procedure TdxNavBarExplorerBarViewInfo.DoGroupActivate(AGroup: TdxNavBarGroup);
begin
  if AGroup.Expandable and not AGroup.Expanded then
    AGroup.Expanded := True;
end;

procedure TdxNavBarExplorerBarViewInfo.DoGroupDeactivate(AGroup: TdxNavBarGroup);
begin
  if AGroup.Expandable and AGroup.Expanded then
    AGroup.Expanded := False;
end;

function TdxNavBarExplorerBarViewInfo.IsGroupActive(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := AGroup.Expanded;
end;

procedure TdxNavBarExplorerBarViewInfo.MakeLinkVisible(ALink: TdxNavBarItemLink);
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  if not ALink.Group.Expanded then
  begin
    ALink.Group.Expanded := True;
    CreateInfo;
    CalculateBounds;
  end;
  AGroupViewInfo := GetGroupViewInfoByGroup(ALink.Group);
  if AGroupViewInfo <> nil then
  begin
    ALinkViewInfo := AGroupViewInfo.GetLinkViewInfoByLink(ALink);
    if ALinkViewInfo <> nil then
    begin
      NavBar.ScrollBar.Position := NavBar.ScrollBar.Position + ALinkViewInfo.Rect.Top - 2;
      NavBar.InvalidateAll(doRecreate);
    end;
  end;
end;

procedure TdxNavBarExplorerBarViewInfo.MakeGroupVisible(AGroup: TdxNavBarGroup);
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
begin
  if not AGroup.Expanded then
  begin
    AGroup.Expanded := True;
    CreateInfo;
    CalculateBounds;
  end;
  AGroupViewInfo := GetGroupViewInfoByGroup(AGroup);
  if AGroupViewInfo <> nil then
  begin
    NavBar.ScrollBar.Position := NavBar.ScrollBar.Position + AGroupViewInfo.Rect.Top - 2;
    NavBar.InvalidateAll(doRecreate);
  end;
end;

{ TdxNavBarExplorerBarPainter }

function TdxNavBarExplorerBarPainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarExplorerBarViewInfo.Create(Self);
end;

class function TdxNavBarExplorerBarPainter.BackgroundPainterClass: TdxBaseBackgroundPainterClass;
begin
  Result := TdxNavBarBackgroundPainter;
end;

class function TdxNavBarExplorerBarPainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarExplorerButtonPainter;
end;

class function TdxNavBarExplorerBarPainter.DropTargetGroupPainterClass: TdxBaseDropTargetGroupPainterClass;
begin
  Result := TdxNavBarDropTargetGroupPainter;
end;

class function TdxNavBarExplorerBarPainter.DropTargetLinkPainterClass: TdxBaseDropTargetLinkPainterClass;
begin
  Result := TdxNavBarDropTargetLinkPainter;
end;

class function TdxNavBarExplorerBarPainter.GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass;
begin
  Result := TdxNavBarGroupBackgroundPainter;
end;

class function TdxNavBarExplorerBarPainter.GroupBorderPainterClass: TdxBaseGroupBorderPainterClass;
begin
  Result := TdxNavBarExplorerBarBorderPainter;
end;

class function TdxNavBarExplorerBarPainter.ImagePainterClass: TdxBaseImagePainterClass;
begin
  Result := TdxNavBarImagePainter;
end;

class function TdxNavBarExplorerBarPainter.SignPainterClass: TdxBaseSignPainterClass;
begin
  Result := TdxNavBarExplorerBarSignPainter;
end;

{ TdxNavBarUltraFlatExplorerBarPainter }

class function TdxNavBarUltraFlatExplorerBarPainter.SelectionPainterClass: TdxBaseSelectionPainterClass;
begin
  Result := TdxNavBarUltraFlatSelectionPainter;
end;

{ TdxNavBarAdvExplorerBarLinkViewInfo }

function TdxNavBarAdvExplorerBarLinkViewInfo.FontColor: TColor;
begin
  Result := Font.Color;
  if Result = clNone then
    Result := GetColor(dxAdvExplorerBarFontColor, dxAdvExplorerBarFontHotColor, State);
end;

{ TdxNavBarAdvExplorerBarGroupViewInfo }

function TdxNavBarAdvExplorerBarGroupViewInfo.BorderColor: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited BorderColor
  else if BgBackColor <> clWhite then
    Result := clWhite
  else Result := LightLightColor(clHighlight);
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := dxAdvExplorerBarGroupBackgroundColor
  else
    Result := inherited BgBackColor;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := dxAdvExplorerBarGroupBackgroundColor
  else
    Result := inherited BgBackColor2;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmHorizontal
  else Result := inherited BgGradientMode;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionAlphaBlend: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else Result := inherited CaptionAlphaBlend;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionAlphaBlend2: Byte;
begin
  if IsDefaultCaptionColor then
    Result := 255
  else Result := inherited CaptionAlphaBlend2;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionBackColor: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor
  else
    if sSpecial in State then
      Result := dxAdvExplorerBarSpecialGroupCaptionColor1
    else
      Result := dxAdvExplorerBarGroupCaptionColor1;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionBackColor2: TColor;
begin
  if not IsDefaultCaptionColor then
    Result := inherited CaptionBackColor2
  else
    if sSpecial in State then
      Result := dxAdvExplorerBarSpecialGroupCaptionColor2
    else
      Result := dxAdvExplorerBarGroupCaptionColor2;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionFontColor: TColor;
begin
  Result := CaptionFont.Color;
  if Result = clNone then
    if sSpecial in State then
      Result := GetColor(dxAdvExplorerBarSpecialGroupFontColor,
        dxAdvExplorerBarSpecialGroupFontHotColor, State)
    else
      Result := GetColor(dxAdvExplorerBarGroupFontColor,
        dxAdvExplorerBarGroupFontHotColor, State);
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionSignColor: TColor;
begin
  if sSpecial in State then
  begin
    if not IsDefaultCaptionColor then
      Result := CaptionBackColor2
    else
      Result := GetColor(dxAdvExplorerBarSpecialGroupCaptionSignColor,
        dxAdvExplorerBarSpecialGroupCaptionSignHotColor, State)
  end
  else
  begin
    if CaptionFont.Color = clNone then
      Result := GetColor(dxAdvExplorerBarGroupCaptionSignColor,
        dxAdvExplorerBarGroupCaptionSignHotColor, State)
    else
      Result := CaptionFontColor;
  end;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.CaptionGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultCaptionColor then
    Result := gmHorizontal
  else Result := inherited CaptionGradientMode;
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone);
end;

function TdxNavBarAdvExplorerBarGroupViewInfo.IsDefaultCaptionColor: Boolean;
begin
  Result := (inherited CaptionBackColor = clNone) or (inherited CaptionBackColor2 = clNone);
end;

{ TdxNavAdvBarExplorerBarViewInfo }

function TdxNavBarAdvExplorerBarViewInfo.BgAlphaBlend: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend;
end;

function TdxNavBarAdvExplorerBarViewInfo.BgAlphaBlend2: Byte;
begin
  if IsDefaultBgColor then
    Result := 255
  else Result := inherited BgAlphaBlend2;
end;

function TdxNavBarAdvExplorerBarViewInfo.BgBackColor: TColor;
begin
  if IsDefaultBgColor then
    Result := dxAdvExplorerBarBackgroundColor1
  else
    Result := inherited BgBackColor;
end;

function TdxNavBarAdvExplorerBarViewInfo.BgBackColor2: TColor;
begin
  if IsDefaultBgColor then
    Result := dxAdvExplorerBarBackgroundColor2
  else
    Result := inherited BgBackColor2;
end;

function TdxNavBarAdvExplorerBarViewInfo.BgGradientMode: TdxBarStyleGradientMode;
begin
  if IsDefaultBgColor then
    Result := gmVertical//gmHorizontal
  else Result := inherited BgGradientMode;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clNone;
  NavBar.DefaultStyles.Background.BackColor2 := clNone;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clNone;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clNone;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.AssignDefaultGroupHeaderActiveStyle;
begin
  NavBar.DefaultStyles.GroupHeaderActive.Assign(NavBar.DefaultStyles.GroupHeader);
  NavBar.DefaultStyles.GroupHeaderActive.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeaderActive.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeaderActive.Font.Color := clNone;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clNone;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clNone;
  NavBar.DefaultStyles.GroupHeader.Font.Style := [fsBold];
end;

procedure TdxNavBarAdvExplorerBarViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clNone;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.AssignDefaultItemDisabledStyle;
begin
  NavBar.DefaultStyles.ItemDisabled.Assign(NavBar.DefaultStyles.Item);
end;

procedure TdxNavBarAdvExplorerBarViewInfo.CreateColors;
begin
  CreateAdvExplorerBarColors;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.RefreshColors;
begin
  RefreshAdvExplorerBarColors;
end;

procedure TdxNavBarAdvExplorerBarViewInfo.ReleaseColors;
begin
  ReleaseAdvExplorerBarColors;
end;

class function TdxNavBarAdvExplorerBarViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 12;
end;

class function TdxNavBarAdvExplorerBarViewInfo.GetGroupCaptionSignSize: Integer;
begin
  Result := 22;
end;

function TdxNavBarAdvExplorerBarViewInfo.IsDefaultBgColor: Boolean;
begin
  Result := (inherited BgBackColor = clNone) or (inherited BgBackColor2 = clNone);
end;

{ TdxNavBarAdvExplorerBarPainter }

function TdxNavBarAdvExplorerBarPainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarAdvExplorerBarViewInfo.Create(Self);
end;

class function TdxNavBarAdvExplorerBarPainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarAdvExplorerButtonPainter;
end;

function TdxNavBarAdvExplorerBarPainter.CreateGroupViewInfo(AViewInfo: TdxNavBarViewInfo; AGroup: TdxNavBarGroup;
  ACaptionVisible, AItemsVisible: Boolean): TdxNavBarGroupViewInfo;
begin
  Result := TdxNavBarAdvExplorerBarGroupViewInfo.Create(AViewInfo, AGroup, ACaptionVisible, AItemsVisible);
end;

function TdxNavBarAdvExplorerBarPainter.CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarAdvExplorerBarLinkViewInfo.Create(AViewInfo, ALink, ACaptionVisible, AImageVisisble);
end;

class function TdxNavBarAdvExplorerBarPainter.SignPainterClass: TdxBaseSignPainterClass;
begin
  Result := TdxNavBarAdvExplorerBarSignPainter;
end;

initialization
  RegisterView(dxNavBarExplorerBarView, 'ExplorerBarView', TdxNavBarExplorerBarPainter);
  RegisterView(dxNavBarUltraFlatExplorerView, 'UltraFlatExplorerBarView', TdxNavBarUltraFlatExplorerBarPainter);
  RegisterView(dxNavBarAdvExplorerBarView, 'AdvExplorerBarView', TdxNavBarAdvExplorerBarPainter);

finalization
  UnRegisterView(dxNavBarExplorerBarView);
  UnRegisterView(dxNavBarUltraFlatExplorerView);
  UnRegisterView(dxNavBarAdvExplorerBarView);

end.
