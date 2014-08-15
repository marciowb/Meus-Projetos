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

unit dxNavBarBaseViews;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, dxNavBar, dxNavBarBase, dxNavBarCollns, dxNavBarStyles;

type
  TdxNavBarBaseViewInfo = class(TdxNavBarViewInfo)
  protected
    function GetActiveGroupMinHeight: Integer; virtual;
  public
    procedure CalculateBounds; override;
    procedure CorrectBounds; virtual;

    procedure DoGroupActivate(AGroup: TdxNavBarGroup); override;
    procedure DoGroupDeactivate(AGroup: TdxNavBarGroup); override;
    function IsGroupActive(AGroup: TdxNavBarGroup): Boolean; override;
    procedure MakeLinkVisible(ALink: TdxNavBarItemLink); override;
    procedure MakeGroupVisible(AGroup: TdxNavBarGroup); override;
  end;

  TdxNavBarBasePainter = class(TdxNavBarPainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;

    class function BackgroundPainterClass: TdxBaseBackgroundPainterClass; override;
    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
    class function DropTargetGroupPainterClass: TdxBaseDropTargetGroupPainterClass; override;
    class function DropTargetLinkPainterClass: TdxBaseDropTargetLinkPainterClass; override;
    class function GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass; override;
    class function ImagePainterClass: TdxBaseImagePainterClass; override;
    class function ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass; override;
    class function SelectionPainterClass: TdxBaseSelectionPainterClass; override;
  end;

  TdxNavBarFlatPainter = class(TdxNavBarBasePainter)
  protected
    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
  end;

implementation

uses
  CommCtrl, ImgList,
  dxNavBarViewsFact, dxNavBarGraphics, dxNavBarConsts;

{ TdxNavBarBaseViewInfo }

procedure TdxNavBarBaseViewInfo.CalculateBounds;
begin
  inherited;
  CorrectBounds;
  AdjustControlsBounds;
end;

procedure TdxNavBarBaseViewInfo.CorrectBounds;
var
  I, ActiveGroupViewInfoIndex: Integer;
  OffsetY, MinHeight: Integer;
begin
  if (GroupCount = 0) or (ActiveGroupViewInfo = nil) then exit;

  ActiveGroupViewInfoIndex := IndexOfGroupViewInfo(ActiveGroupViewInfo);
  OffsetY := ClientHeight - Groups[GroupCount - 1].Rect.Bottom;
  MinHeight := GetActiveGroupMinHeight;
  if (ActiveGroupViewInfo.ItemsRect.Bottom + OffsetY < ActiveGroupViewInfo.ItemsRect.Top + MinHeight) then
    OffsetY := ActiveGroupViewInfo.ItemsRect.Top + MinHeight - ActiveGroupViewInfo.ItemsRect.Bottom;
  ActiveGroupViewInfo.CorrectActiveGroupBounds(0, OffsetY);
  for I := ActiveGroupViewInfoIndex + 1 to GroupCount - 1 do
    Groups[I].CorrectBounds(0, OffsetY);
  CalculateScrollButtonsBounds;
end;

function TdxNavBarBaseViewInfo.GetActiveGroupMinHeight: Integer;
var
  ATopVisibleLinkViewInfo: TdxNavBarLinkViewInfo;
begin
  if ActiveGroupViewInfo <> nil then
  begin
    Result := 2 * GetScrollButtonVerticalSize + 3 * GetScrollButtonVerticalEdge;
    if ActiveGroupViewInfo.ItemCount > ActiveGroupViewInfo.Group.TopVisibleLinkIndex then
    begin
      ATopVisibleLinkViewInfo := ActiveGroupViewInfo.Items[ActiveGroupViewInfo.Group.TopVisibleLinkIndex];
      if Result < ATopVisibleLinkViewInfo.Rect.Bottom  - ATopVisibleLinkViewInfo.Rect.Top + GetGroupCaptionSeparatorWidth then
        Result := ATopVisibleLinkViewInfo.Rect.Bottom - ATopVisibleLinkViewInfo.Rect.Top + GetGroupCaptionSeparatorWidth;
    end;
  end
  else Result := 0;
end;

procedure TdxNavBarBaseViewInfo.DoGroupActivate(AGroup: TdxNavBarGroup);
begin
  if NavBar.ActiveGroupIndex <> AGroup.Index then
    NavBar.ActiveGroup := AGroup;
end;

procedure TdxNavBarBaseViewInfo.DoGroupDeactivate(AGroup: TdxNavBarGroup);
begin
end;

function TdxNavBarBaseViewInfo.IsGroupActive(AGroup: TdxNavBarGroup): Boolean;
begin
  Result := AGroup = NavBar.ActiveGroup;
end;

procedure TdxNavBarBaseViewInfo.MakeLinkVisible(ALink: TdxNavBarItemLink);
var
  AGroupViewInfo: TdxNavBarGroupViewInfo;
  ALinkViewInfo: TdxNavBarLinkViewInfo;
begin
  if NavBar.ActiveGroup <> ALink.Group then
  begin
    NavBar.ActiveGroup := ALink.Group;
    CreateInfo;
    CalculateBounds;
  end;
  AGroupViewInfo := GetGroupViewInfoByGroup(ALink.Group);
  if AGroupViewInfo <> nil then
  begin
    ALinkViewInfo := AGroupViewInfo.GetLinkViewInfoByLink(ALink);
    if ALinkViewInfo <> nil then
    begin
      ALink.Group.TopVisibleLinkIndex := AGroupViewInfo.IndexOfLinkViewInfo(ALinkViewInfo);
      NavBar.InvalidateAll(doRecreate);
    end;
  end;
end;

procedure TdxNavBarBaseViewInfo.MakeGroupVisible(AGroup: TdxNavBarGroup);
begin
  NavBar.ActiveGroup := AGroup;
end;

{ TdxNavBarBasePainter }

function TdxNavBarBasePainter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarBaseViewInfo.Create(Self);
end;

class function TdxNavBarBasePainter.BackgroundPainterClass: TdxBaseBackgroundPainterClass;
begin
  Result := TdxNavBarBackgroundPainter;
end;

class function TdxNavBarBasePainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarButtonPainter;
end;

class function TdxNavBarBasePainter.DropTargetGroupPainterClass: TdxBaseDropTargetGroupPainterClass;
begin
  Result := TdxNavBarDropTargetGroupPainter;
end;

class function TdxNavBarBasePainter.DropTargetLinkPainterClass: TdxBaseDropTargetLinkPainterClass;
begin
  Result := TdxNavBarDropTargetLinkPainter;
end;

class function TdxNavBarBasePainter.GroupBackgroundPainterClass: TdxBaseGroupBackgroundPainterClass;
begin
  Result := TdxNavBarGroupBackgroundPainter;
end;

class function TdxNavBarBasePainter.ScrollButtonsPainterClass: TdxBaseScrollButtonsPainterClass;
begin
  Result := TdxNavBarScrollButtonsPainter;
end;

class function TdxNavBarBasePainter.ImagePainterClass: TdxBaseImagePainterClass;
begin
  Result := TdxNavBarImagePainter;
end;

class function TdxNavBarBasePainter.SelectionPainterClass: TdxBaseSelectionPainterClass;
begin
  Result := TdxNavBarSelectionPainter;
end;

{ TdxNavBarFlatPainter }

class function TdxNavBarFlatPainter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarFlatButtonPainter;
end;

initialization
  RegisterView(dxNavBarBaseView, 'BaseView', TdxNavBarBasePainter);
  RegisterView(dxNavBarFlatView, 'FlatView', TdxNavBarFlatPainter);

finalization
  UnRegisterView(dxNavBarBaseView);
  UnRegisterView(dxNavBarFlatView);

end.
