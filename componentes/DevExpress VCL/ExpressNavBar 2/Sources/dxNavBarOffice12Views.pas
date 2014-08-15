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

unit dxNavBarOffice12Views;

{$I cxVer.inc}

interface

uses
  Windows, cxGraphics, SysUtils, Classes, cxClasses, cxControls, dxNavBar, dxNavBarSkinBasedViews,
  dxSkinsCore, dxSkinInfo, cxScrollBar, cxLookAndFeels, cxLookAndFeelPainters;

type
  TdxNavBarOffice12PainterHelper = class(TdxNavBarSkinBasedPainterHelper)
  protected
    function GetFullSkinName: TdxSkinName; override;
    function GetSkinsCount: Integer; override;
    function GetSkinNames(AIndex: Integer): TdxSkinName; override;
    procedure SetSkinName(AValue: TdxSkinName); override;
  end;

  TdxNavBarOffice12NavPanePainter = class(TdxNavBarSkinBasedNavPanePainter)
  protected
    class function GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass; override;

    function GetDefaultColorSchemeName: TdxSkinName; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ColorSchemeName;
  end;

  TdxNavBarOffice12ExplorerBarPainter = class(TdxNavBarSkinBasedExplorerBarPainter)
  protected
    class function GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass; override;
    function CreatecxScrollBar: TcxScrollBar; override;
    function GetcxScrollBarClass: TcxScrollBarClass; override;
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; const R: TRect;
      APart: TcxScrollBarPart; AState: TcxButtonState);
    function ScrollBarMinimalThumbSize: Integer;
    function IsGroupCaptionButtonCompositeDraw(AGroupViewInfo: TdxNavBarGroupViewInfo): Boolean; override;

    function GetDefaultColorSchemeName: TdxSkinName; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo); override;
  published
    property ColorSchemeName;
  end;

implementation

{$R *.res}

uses
  dxNavBarBase, dxNavBarViewsFact, dxNavBarConsts;

const
  AColorSchemeCount = 3;
  AColorSchemeNames: array [0..AColorSchemeCount - 1] of TdxSkinName = ('Blue', 'Black', 'Silver');

var
  ADefaultColorSchemeName: TdxSkinName;

{ TdxNavBarOffice12PainterHelper }

function TdxNavBarOffice12PainterHelper.GetFullSkinName: TdxSkinName;
begin
  Result := 'Office12_' + SkinName;
end;

function TdxNavBarOffice12PainterHelper.GetSkinsCount: Integer;
begin
  Result := AColorSchemeCount;
end;

function TdxNavBarOffice12PainterHelper.GetSkinNames(AIndex: Integer): TdxSkinName;
begin
  Result := AColorSchemeNames[AIndex];
end;

procedure TdxNavBarOffice12PainterHelper.SetSkinName(AValue: TdxSkinName);
begin
  inherited;
  ADefaultColorSchemeName := AValue;
end;

{ TdxNavBarOffice12NavPanePainter }

procedure TdxNavBarOffice12NavPanePainter.Assign(Source: TPersistent);
begin
  if Source is TdxNavBarOffice12NavPanePainter then
    ColorSchemeName := TdxNavBarOffice12NavPanePainter(Source).ColorSchemeName
  else
    inherited;
end;

class function TdxNavBarOffice12NavPanePainter.GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass;
begin
  Result := TdxNavBarOffice12PainterHelper;
end;

function TdxNavBarOffice12NavPanePainter.GetDefaultColorSchemeName: TdxSkinName;
begin
  Result := ADefaultColorSchemeName;
end;

type
  TdxNavBarcxOffice12ScrollBar = class(TcxControlScrollBar)
  private
    FNavBarPainter: TdxNavBarOffice12ExplorerBarPainter;
  protected
    procedure DrawScrollBarPart(ACanvas: TcxCanvas; const R: TRect;
      APart: TcxScrollBarPart; AState: TcxButtonState); override;
    function IsButtonHotTrack: Boolean; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    function ScrollBarMinimalThumbSize: Integer; override;
  public
    constructor Create(APainter: TdxNavBarOffice12ExplorerBarPainter); reintroduce; virtual;
  end;

{ TdxNavBarcxOffice12ScrollBar }

constructor TdxNavBarcxOffice12ScrollBar.Create(APainter: TdxNavBarOffice12ExplorerBarPainter);
begin
  inherited Create(nil);
  FNavBarPainter := APainter;
end;

procedure TdxNavBarcxOffice12ScrollBar.DrawScrollBarPart(
  ACanvas: TcxCanvas; const R: TRect; APart: TcxScrollBarPart;
  AState: TcxButtonState);
begin
  if FNavBarPainter <> nil then
    FNavBarPainter.DrawScrollBarPart(ACanvas, R, APart, AState)
  else
    inherited;
end;

function TdxNavBarcxOffice12ScrollBar.IsButtonHotTrack: Boolean;
begin
  Result := True;
end;

procedure TdxNavBarcxOffice12ScrollBar.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
//do nothing
end;

function TdxNavBarcxOffice12ScrollBar.ScrollBarMinimalThumbSize: Integer;
begin
  if FNavBarPainter <> nil then
    Result := FNavBarPainter.ScrollBarMinimalThumbSize
  else
    Result := inherited ScrollBarMinimalThumbSize;
end;

{ TdxNavBarOffice12ExplorerBarPainter }

procedure TdxNavBarOffice12ExplorerBarPainter.Assign(Source: TPersistent);
begin
  if Source is TdxNavBarOffice12ExplorerBarPainter then
    ColorSchemeName := TdxNavBarOffice12ExplorerBarPainter(Source).ColorSchemeName
  else
    inherited;
end;

procedure TdxNavBarOffice12ExplorerBarPainter.DrawItemSelection(ALinkViewInfo: TdxNavBarLinkViewInfo);
begin
end;

class function TdxNavBarOffice12ExplorerBarPainter.GetSkinPainterHelperClass: TdxNavBarSkinBasedPainterHelperClass;
begin
  Result := TdxNavBarOffice12PainterHelper;
end;

function TdxNavBarOffice12ExplorerBarPainter.CreatecxScrollBar: TcxScrollBar;
begin
  Result := TdxNavBarcxOffice12ScrollBar.Create(Self);
end;

function TdxNavBarOffice12ExplorerBarPainter.GetcxScrollBarClass: TcxScrollBarClass;
begin
  Result := TdxNavBarcxOffice12ScrollBar;
end;

procedure TdxNavBarOffice12ExplorerBarPainter.DrawScrollBarPart(ACanvas: TcxCanvas; const R: TRect;
  APart: TcxScrollBarPart; AState: TcxButtonState);
const
  ButtonState2SkinState: array[TcxButtonState] of TdxSkinElementState =
   (esNormal, esNormal, esHot, esPressed, esDisabled);
var
  AInfo: TdxSkinScrollInfo;
begin
  if FSkinBasedPainterHelper = nil then
    Exit;
  AInfo := FSkinBasedPainterHelper.NavBarScrollBarElements(False, APart);
  if (AInfo <> nil) and (AInfo.Element <> nil) then
    AInfo.Element.Draw(ACanvas.Handle, R, AInfo.ImageIndex, ButtonState2SkinState[AState]);
end;

function TdxNavBarOffice12ExplorerBarPainter.ScrollBarMinimalThumbSize: Integer;
var
  AInfo: TdxSkinScrollInfo;
begin
  Result := 0;
  if FSkinBasedPainterHelper = nil then
    Exit;
  AInfo := FSkinBasedPainterHelper.NavBarScrollBarElements(False, sbpThumbnail);
  if (AInfo <> nil) and (AInfo.Element <> nil) then
    Result := AInfo.Element.Size.cy;
end;

function TdxNavBarOffice12ExplorerBarPainter.IsGroupCaptionButtonCompositeDraw(
  AGroupViewInfo: TdxNavBarGroupViewInfo): Boolean;
begin
  Result := (ViewInfo.GroupCount > 0) and (ViewInfo.Groups[0] = AGroupViewInfo);
end;

function TdxNavBarOffice12ExplorerBarPainter.GetDefaultColorSchemeName: TdxSkinName;
begin
  Result := ADefaultColorSchemeName;
end;

initialization
  ADefaultColorSchemeName := AColorSchemeNames[0];
  RegisterView(dxNavBarOffice12NavigatorPaneView, 'Office12NavigationPaneView', TdxNavBarOffice12NavPanePainter);
  RegisterView(dxNavBarOffice12ExplorerBarView, 'Office12ExplorerBarView', TdxNavBarOffice12ExplorerBarPainter);

finalization
  UnRegisterView(dxNavBarOffice12NavigatorPaneView);
  UnRegisterView(dxNavBarOffice12ExplorerBarView);
end.

