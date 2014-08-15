{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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
unit dxRibbonMiniToolbar;

{$I cxVer.inc}

interface

uses
  Windows, Forms, Messages, Classes, SysUtils, Graphics,
  Controls, ExtCtrls, ImgList, IniFiles, Contnrs,
  dxCore, cxClasses, cxGraphics, cxControls, cxContainer, cxLookAndFeels,
  dxBar, dxBarSkinConsts, dxRibbon, cxGeometry, Math, Types;

type
  TdxRibbonMiniToolbarPainter = class;

  TdxRibbonCustomMiniToolbar = class(TdxBarCustomPopupComponent)
  private
    FBar: TdxBar;
    FRibbonHolder: TdxRibbonHolderComponent;
    FPainter: TdxRibbonMiniToolbarPainter;
    function GetRibbon: TdxCustomRibbon;
    procedure SetRibbon(const Value: TdxCustomRibbon);

    procedure MiniToolbarDestroy(Sender: TObject);
  protected
    function CreateBarControl: TCustomdxBarControl; override;
    function GetControlClass: TCustomdxBarControlClass; override;
    function GetItemLinksClass: TdxBarItemLinksClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Popup; overload;
    procedure Popup(const P: TPoint); overload;

    property Ribbon: TdxCustomRibbon read GetRibbon write SetRibbon;
  end;

  TdxRibbonMiniToolbar = class(TdxRibbonCustomMiniToolbar)
  published
    property ItemLinks;
    property Ribbon;
  end;

  TdxRibbonMiniToolbarControl = class(TdxBarPopupControl)
  private
    AWasMouseOver: Boolean;
    function GetAlphaBlendValue: Integer;
  protected
    // TCustomdxBarControl
    function GetItemControlDefaultViewLevel(
      AItemControl: TdxBarItemControl): TdxBarItemViewLevel; override;
    function GetPaintType: TdxBarPaintType; override;
    procedure DrawContentBackground; override;
    procedure FillBackground(ADC: HDC; const ARect: TRect; ABrush: HBRUSH; AColor: TColor;
      AIsClientArea: Boolean); override;
    procedure SetLayeredAttributes; override;

    // TdxBarControl
    procedure DoNCPaint(DC: HDC); override;

    // TdxBarPopupControl
    function GetPopupPosition(const ASize: TSize; const AOwnerRect: TRect; APopupDirection: TXDirection): TPoint; override;
    function GetPopupSize: TSize; override;

    function AlwaisTrackMouse: Boolean; override;
    procedure TrackMouse; override;
  public
    procedure CloseUp; override;
  end;

  { TdxRibbonMiniToolbarPainter }

  TdxRibbonMiniToolbarPainter = class(TdxRibbonBarPainter)
  protected
    procedure DrawToolbarContentPart(ABarControl: TdxBarControl; ACanvas: TcxCanvas); override;
    procedure DrawToolbarNonContentPart(ABarControl: TdxBarControl; DC: HDC); override;
  public
    function GetToolbarContentOffsets(ABar: TdxBar;
      ADockingStyle: TdxBarDockingStyle; AHasSizeGrip: Boolean): TRect; override;
  end;

implementation

type
  TdxBarManagerAccess = class(TdxBarManager);
  TCustomdxBarControlAccess = class(TCustomdxBarControl);
  TdxCustomRibbonAccess = class(TdxCustomRibbon);
  TdxBarPainterAccess = class(TdxBarPainter);

{ TdxRibbonCustomMiniToolbar }

constructor TdxRibbonCustomMiniToolbar.Create(AOwner: TComponent);
begin
  inherited;
  FRibbonHolder := TdxRibbonHolderComponent.Create(Self);
end;

destructor TdxRibbonCustomMiniToolbar.Destroy;
begin
  FreeAndNil(FRibbonHolder);
  inherited;
end;

procedure TdxRibbonCustomMiniToolbar.Popup;
begin
  Popup(GetMouseCursorPos);
end;

procedure TdxRibbonCustomMiniToolbar.Popup(const P: TPoint);

  function CanShowBar: Boolean;
  begin
    Result := TdxBarManagerAccess(BarManager).IsOwnerVisible and IsFormActive(BarManager.ParentForm);
  end;

begin
  if CanShowBar then
  begin
    ItemLinks.CreateBarControl;

  //  TCustomdxBarControlAccess(ItemLinks.BarControl.ParentBar).FMarkState := msPressed;
    BarDesignController.ShowQuickControl((ItemLinks.BarControl as TdxBarPopupControl), FPainter, cxRect(P, P));
  end;
end;

function TdxRibbonCustomMiniToolbar.CreateBarControl: TCustomdxBarControl;
begin
  if csDesigning in ComponentState then
    Result := inherited CreateBarControl
  else
  begin
    FBar := BarDesignController.AddInternalBar(BarManager);
    FBar.Visible := False;
    FBar.ItemLinks.CreateBarControl;

    Result := inherited CreateBarControl;
    (Result as TdxRibbonMiniToolbarControl).InitializeForPopup(FBar.Control, FBar);

    Result.OnDestroy := MiniToolbarDestroy;

    FPainter := TdxRibbonMiniToolbarPainter.Create(Integer(Ribbon));
  end;
end;

function TdxRibbonCustomMiniToolbar.GetControlClass: TCustomdxBarControlClass;
begin
  if csDesigning in ComponentState then
    Result := inherited GetControlClass
  else
    Result := TdxRibbonMiniToolbarControl;
end;

function TdxRibbonCustomMiniToolbar.GetItemLinksClass: TdxBarItemLinksClass;
begin
  if csDesigning in ComponentState then
    Result := inherited GetItemLinksClass
  else
    Result := TdxBarControlItemLinks;
end;

function TdxRibbonCustomMiniToolbar.GetRibbon: TdxCustomRibbon;
begin
  Result := FRibbonHolder.Ribbon;
end;

procedure TdxRibbonCustomMiniToolbar.SetRibbon(const Value: TdxCustomRibbon);
begin
  FRibbonHolder.Ribbon := Value;
end;

procedure TdxRibbonCustomMiniToolbar.MiniToolbarDestroy(Sender: TObject);
begin
  FreeAndNil(FPainter);
  FreeAndNil(FBar);
end;

{ TdxRibbonMiniToolbarControl }

procedure TdxRibbonMiniToolbarControl.CloseUp;
begin
//  inherited;
  Free;
end;

function TdxRibbonMiniToolbarControl.AlwaisTrackMouse: Boolean;
begin
  Result := True;
end;

procedure TdxRibbonMiniToolbarControl.TrackMouse;
var
  AAlpha: Integer;
begin
  AAlpha := GetAlphaBlendValue;
  if AAlpha = -1 then
    CloseUp
  else
    cxSetLayeredWindowAttributes(Handle, AAlpha);
end;

function TdxRibbonMiniToolbarControl.GetAlphaBlendValue: Integer;
var
  AMousePos: TPoint;
  AMouseDistance: TPoint;
  AMinMouseDistance: Integer;
  ABoundsRect: TRect;
  ALimitVisibility: Integer;
begin
  if SelectedControl <> nil then
    Result := 255
  else
  begin
    AMousePos := GetMouseCursorPos;
    ABoundsRect := BoundsRect;
    AMouseDistance.X := Max(ABoundsRect.Left - AMousePos.X, AMousePos.X - ABoundsRect.Right);
    AMouseDistance.Y := Max(ABoundsRect.Top - AMousePos.Y, AMousePos.Y - ABoundsRect.Bottom);
    AMinMouseDistance := Max(AMouseDistance.X, AMouseDistance.Y);

    if AMinMouseDistance <= 0 then
    begin
      AWasMouseOver := True;
      Result := 255;
    end
    else
    begin
      if AMinMouseDistance > 176 then
        Result := -1
      else
      begin
        if AWasMouseOver then
          ALimitVisibility := cxGetValueCurrentDPI(84)
        else
          ALimitVisibility := cxGetValueCurrentDPI(13);
        if AMinMouseDistance > ALimitVisibility then
          Result := 0
        else
          Result := MulDiv(255, ALimitVisibility - AMinMouseDistance, ALimitVisibility);
      end;
    end;
  end;
end;

function TdxRibbonMiniToolbarControl.GetPopupPosition(const ASize: TSize; const AOwnerRect: TRect; APopupDirection: TXDirection): TPoint;
begin
  Result := Point(AOwnerRect.Right, AOwnerRect.Bottom - ASize.cy - cxGetValueCurrentDPI(11));
end;

function TdxRibbonMiniToolbarControl.GetPopupSize: TSize;
begin
//#DG TODO
   Result := GetSizeForHeight(dsNone, cxGetValueCurrentDPI(50), True);

  with Painter.GetToolbarContentOffsets(Bar, DockingStyle, False) do
  begin
    Inc(Result.cx, Left + Right);
    Inc(Result.cy, Top + Bottom);
  end;
end;

function TdxRibbonMiniToolbarControl.GetPaintType: TdxBarPaintType;
begin
  //Result := ptMenu; exit;
  Result := inherited GetPaintType;
end;

procedure TdxRibbonMiniToolbarControl.DrawContentBackground;
begin
inherited; exit;
//Painter.DrawToolbarContentPart(Self, Canvas);
  Canvas.FillRect(ClientRect, clred);
end;

procedure TdxRibbonMiniToolbarControl.FillBackground(ADC: HDC; const ARect: TRect;
  ABrush: HBRUSH; AColor: TColor; AIsClientArea: Boolean);
begin
  exit;
  {
  cxPaintCanvas.BeginPaint(ADC);
  try
    cxPaintCanvas.SetClipRegion(TcxRegion.Create(ARect), roIntersect);
    Painter.DrawToolbarContentPart(Self, cxPaintCanvas);
  finally
    cxPaintCanvas.EndPaint;
  end;
  }
end;

procedure TdxRibbonMiniToolbarControl.SetLayeredAttributes;
begin
  cxSetLayeredWindowAttributes(Handle, 0);
end;

procedure TdxRibbonMiniToolbarControl.DoNCPaint(DC: HDC);
begin
  TdxBarPainterAccess(Painter).DrawToolbarNonContentPart(Self, DC);
end;

function TdxRibbonMiniToolbarControl.GetItemControlDefaultViewLevel(AItemControl: TdxBarItemControl): TdxBarItemViewLevel;
begin
  Result := AItemControl.ViewInfo.MinPossibleViewLevel;
end;

{ TdxRibbonMiniToolbarPainter }

procedure TdxRibbonMiniToolbarPainter.DrawToolbarContentPart(ABarControl: TdxBarControl; ACanvas: TcxCanvas);
begin
//  Skin.DrawBackground(ACanvas.Handle, ABarControl.ClientRect, DXBAR_MENUCONTENT);
  Skin.DrawBackground(ACanvas.Handle, ABarControl.ClientRect, DXBAR_MINITOOLBAR_BACKGROUND);
//  Skin.DrawBackground(ACanvas.Handle, ABarControl.ClientRect, DXBAR_DROPDOWNBORDER);
end;

procedure TdxRibbonMiniToolbarPainter.DrawToolbarNonContentPart(ABarControl: TdxBarControl; DC: HDC);
begin
  Skin.DrawBackground(DC, TCustomdxBarControlAccess(ABarControl).NCRect, DXBAR_DROPDOWNBORDER);
end;

function TdxRibbonMiniToolbarPainter.GetToolbarContentOffsets(ABar: TdxBar;
  ADockingStyle: TdxBarDockingStyle; AHasSizeGrip: Boolean): TRect;
var
  AOffset: Integer;
begin
  AOffset := SubMenuControlBorderSize;
  Result := Rect(AOffset, AOffset, AOffset, AOffset);
end;

end.
