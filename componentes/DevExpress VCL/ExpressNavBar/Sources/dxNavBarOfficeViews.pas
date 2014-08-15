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

unit dxNavBarOfficeViews;

{$I cxVer.inc}

interface

uses
  Windows, Graphics, dxNavBar, dxNavBarStyles, dxNavBarBaseViews,
  dxNavBarCollns;

type
  TdxNavBarOffice1ViewInfo = class(TdxNavBarBaseViewInfo)
  protected
    class function GetGroupCaptionHeightAddon: Integer; override;
    class function GetGroupSeparatorWidth: Integer; override;
  public
    procedure AssignDefaultBackgroundStyle; override;
    procedure AssignDefaultGroupBackgroundStyle; override;
    procedure AssignDefaultGroupHeaderStyle; override;
    procedure AssignDefaultItemStyle; override;
    procedure AssignDefaultItemDisabledStyle; override;
  end;

  TdxNavBarOffice1Painter = class(TdxNavBarBasePainter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    class function ButtonPainterClass: TdxBaseButtonPainterClass; override;
  end;

  TdxNavBarOffice2Painter = class(TdxNavBarOffice1Painter)
  protected
    class function SelectionPainterClass: TdxBaseSelectionPainterClass; override;
  end;

  TdxNavBarOffice3LinkViewInfo = class(TdxNavBarLinkViewInfo)
  public
    function SelectionRect: TRect; override;
  end;

  TdxNavBarOffice3ViewInfo = class(TdxNavBarOffice1ViewInfo)
  protected
    class function GetLinksLargeSeparatorWidth: Integer; override;
    function CanSelectLinkByRect: Boolean; override;
  end;

  TdxNavBarOffice3Painter = class(TdxNavBarOffice2Painter)
  protected
    function CreateViewInfo: TdxNavBarViewInfo; override;
    function CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
      ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo; override;
  end;

implementation

uses
  CommCtrl, ImgList, Buttons,
  dxNavBarViewsFact, dxNavBarGraphics, dxNavBarConsts;

{ TdxNavBarOffice1ViewInfo }

procedure TdxNavBarOffice1ViewInfo.AssignDefaultBackgroundStyle;
begin
  NavBar.DefaultStyles.Background.ResetValues;
  NavBar.DefaultStyles.Background.BackColor := clBtnFace;
  NavBar.DefaultStyles.Background.BackColor2 := clBtnFace;
end;

procedure TdxNavBarOffice1ViewInfo.AssignDefaultGroupBackgroundStyle;
begin
  NavBar.DefaultStyles.GroupBackground.ResetValues;
  NavBar.DefaultStyles.GroupBackground.BackColor := clBtnFace;
  NavBar.DefaultStyles.GroupBackground.BackColor2 := clBtnFace;
end;

procedure TdxNavBarOffice1ViewInfo.AssignDefaultGroupHeaderStyle;
begin
  NavBar.DefaultStyles.GroupHeader.ResetValues;
  NavBar.DefaultStyles.GroupHeader.BackColor := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.BackColor2 := clBtnFace;
  NavBar.DefaultStyles.GroupHeader.Font.Color := clBtnText;
  NavBar.DefaultStyles.GroupHeader.HAlignment := haCenter;
end;

procedure TdxNavBarOffice1ViewInfo.AssignDefaultItemStyle;
begin
  NavBar.DefaultStyles.Item.ResetValues;
  NavBar.DefaultStyles.Item.Font.Color := clBtnText;
  NavBar.DefaultStyles.Item.HAlignment := haCenter;
end;

procedure TdxNavBarOffice1ViewInfo.AssignDefaultItemDisabledStyle;
begin
  with NavBar.DefaultStyles do
  begin
    ItemDisabled.Assign(NavBar.DefaultStyles.Item);
    ItemDisabled.Font.Color := clBtnShadow;
  end;
end;

class function TdxNavBarOffice1ViewInfo.GetGroupCaptionHeightAddon: Integer;
begin
  Result := 8;
end;

class function TdxNavBarOffice1ViewInfo.GetGroupSeparatorWidth: Integer;
begin
  Result := 1;
end;

{ TdxNavBarOffice1Painter }

function TdxNavBarOffice1Painter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarOffice1ViewInfo.Create(Self);
end;

class function TdxNavBarOffice1Painter.ButtonPainterClass: TdxBaseButtonPainterClass;
begin
  Result := TdxNavBarOfficeButtonPainter;
end;

{ TdxNavBarOffice2Painter }

class function TdxNavBarOffice2Painter.SelectionPainterClass: TdxBaseSelectionPainterClass;
begin
  Result := TdxNavBarUltraFlatSelectionPainter;
end;

{ TdxNavBarOffice3LinkViewInfo }

function TdxNavBarOffice3LinkViewInfo.SelectionRect: TRect;
begin
  Result := Rect;
  InflateRect(Result, -1, -1);
end;

{ TdxNavBarOffice3ViewInfo }

class function TdxNavBarOffice3ViewInfo.GetLinksLargeSeparatorWidth: Integer;
begin
  Result := 16;
end;

function TdxNavBarOffice3ViewInfo.CanSelectLinkByRect: Boolean;
begin
  Result := True;
end;

{ TdxNavBarOffice3Painter }

function TdxNavBarOffice3Painter.CreateViewInfo: TdxNavBarViewInfo;
begin
  Result := TdxNavBarOffice3ViewInfo.Create(Self);
end;

function TdxNavBarOffice3Painter.CreateLinkViewInfo(AViewInfo: TdxNavBarGroupViewInfo; ALink: TdxNavBarItemLink;
  ACaptionVisible, AImageVisisble: Boolean): TdxNavBarLinkViewInfo;
begin
  Result := TdxNavBarOffice3LinkViewInfo.Create(AViewInfo, ALink, ACaptionVisible, AImageVisisble);
end;

initialization
  RegisterView(dxNavBarOffice1View, 'Office1View', TdxNavBarOffice1Painter);
  RegisterView(dxNavBarOffice2View, 'Office2View', TdxNavBarOffice2Painter);
  RegisterView(dxNavBarOffice3View, 'Office3View', TdxNavBarOffice3Painter);

finalization
  UnRegisterView(dxNavBarOffice1View);
  UnRegisterView(dxNavBarOffice2View);
  UnRegisterView(dxNavBarOffice3View);

end.
