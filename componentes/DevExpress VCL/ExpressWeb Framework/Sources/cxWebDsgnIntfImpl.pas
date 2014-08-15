{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebDsgnIntfImpl;

interface

{$I cxVer.inc}

uses Classes, SysUtils,
  {$IFDEF VCL}
  Controls, Windows, Graphics,
  {$ELSE}
  QControls, QGraphics, Types,
  {$ENDIF}
  cxWebIntf, cxWebDsgnIntf;

type
  TcxWebDesignerControlHelper = class
  private
    FSelected: Boolean;

    FOwner: TCustomControl;
    FWebControl: IcxWebControl;
    FDesignerSurface: TWinControl;
  private
    procedure InvalidateSelectionMarks;
  protected
    procedure BoundsChanged;
    procedure ParentChanged;
    procedure UpdateContext;
    function GetDesignerSurface: TWinControl;
    function GetImplementor: TWinControl;
    function GetSelected: Boolean;
    function GetWebControl: IcxWebControl;

    procedure SetDesignerSurface(Value: TWinControl);
    procedure SetSelected(Value: Boolean);
    procedure SetWebControl(Value: IcxWebControl);

    property Owner: TCustomControl read FOwner;
  public
    constructor Create(AOwner: TCustomControl);
    procedure DrawSelectionMarks;

    property WebControl: IcxWebControl read GetWebControl write SetWebControl;
  end;

implementation

{ TcxWebDesignerControlHelper }

uses
  cxWebDsgnConsts;

constructor TcxWebDesignerControlHelper.Create(AOwner: TCustomControl);
begin
  FOwner := AOwner;
end;

procedure TcxWebDesignerControlHelper.BoundsChanged;
begin
  if (WebControl <> nil) and (Owner <> nil) then
    Owner.BoundsRect := WebControl.BoundsRect;
end;

function TcxWebDesignerControlHelper.GetDesignerSurface: TWinControl;
begin
  Result := FDesignerSurface;
end;

function TcxWebDesignerControlHelper.GetSelected: Boolean;
begin
  Result := FSelected;
end;

function TcxWebDesignerControlHelper.GetImplementor: TWinControl;
begin
  Result := FOwner;
end;

function TcxWebDesignerControlHelper.GetWebControl: IcxWebControl;
begin
  Result := FWebControl;
end;

procedure TcxWebDesignerControlHelper.ParentChanged;
var
  AWebControl: IcxWebControl;
  AWebDesignerControl: IcxWebDesignerControl;
begin
  if (WebControl = nil) or (WebControl.Parent = nil) then
    Owner.Parent := nil
  else
  begin
    if Supports(WebControl.Parent, IcxWebControl, AWebControl) and
      (AWebControl.DesignerControl <> nil) and
      Supports(AWebControl.DesignerControl, IcxWebDesignerControl, AWebDesignerControl) then
      Owner.Parent := AWebDesignerControl.Implementor
    else Owner.Parent := GetDesignerSurface;
    WebControl.UpdateControlPosition;
  end;  
end;

procedure TcxWebDesignerControlHelper.SetDesignerSurface(Value: TWinControl);
begin
  if GetDesignerSurface = nil then
    FDesignerSurface := Value;
end;

procedure TcxWebDesignerControlHelper.SetSelected(Value: Boolean);
begin
  if (GetSelected <> Value) then
  begin
    FSelected := Value;
    InvalidateSelectionMarks;
  end;
end;

procedure TcxWebDesignerControlHelper.SetWebControl(Value: IcxWebControl);
begin
  if WebControl = nil then
    FWebControl := Value;
end;
procedure TcxWebDesignerControlHelper.UpdateContext;

  procedure InvalidateControl(AControl: TControl);
  var
    RepaintIntf: IcxWebDesignerControlRepaint;
  begin
    if Supports(AControl, IcxWebDesignerControlRepaint, RepaintIntf) then
      RepaintIntf.RepaintControl;
  end;

var
  R: TRect;
  I: Integer;
begin
  if Owner <> nil then
  begin
    Owner.Invalidate;
    for I := 0 to Owner.ControlCount - 1 do
      InvalidateControl(Owner.Controls[I]);
    if Owner.Parent <> nil then
      with Owner.Parent do
        for I := ControlCount - 1 downto 0 do
        begin
          if Controls[I] = Self.Owner then break;
          if IntersectRect(R, Self.Owner.BoundsRect, Controls[I].BoundsRect) then
            InvalidateControl(Controls[I]);
        end;
  end;
end;

procedure TcxWebDesignerControlHelper.InvalidateSelectionMarks;
var
  R: TRect;
begin
  if (Owner = nil) or not Owner.HandleAllocated then
    Exit;

  R := Bounds(0, 0, cxMarkSize, cxMarkSize);
  with Owner do
  begin
    {$IFDEF VCL}InvalidateRect(Handle, @R, False);{$ELSE}InvalidateRect(R, False);{$ENDIF}
    R := Bounds(ClientWidth - cxMarkSize, 0, cxMarkSize, cxMarkSize);
    {$IFDEF VCL}InvalidateRect(Handle, @R, False);{$ELSE}InvalidateRect(R, False);{$ENDIF}
    R := Bounds(ClientWidth - cxMarkSize, ClientHeight - cxMarkSize, cxMarkSize, cxMarkSize);
    {$IFDEF VCL}InvalidateRect(Handle, @R, False);{$ELSE}InvalidateRect(R, False);{$ENDIF}
    R := Bounds(0, ClientHeight - cxMarkSize, cxMarkSize, cxMarkSize);
    {$IFDEF VCL}InvalidateRect(Handle, @R, False);{$ELSE}InvalidateRect(R, False);{$ENDIF}
  end;
end;

type
  TDummyCustomControl = class(TCustomControl)
  end;

procedure TcxWebDesignerControlHelper.DrawSelectionMarks;
var
  R: TRect;
begin
  if not GetSelected then exit;
  with TDummyCustomControl(Owner).Canvas do
  begin
    Brush.Color := clBtnShadow;
    R := Owner.ClientRect;
    FillRect(Bounds(R.Left, R.Top, cxMarkSize, cxMarkSize));
    FillRect(Bounds(R.Right - cxMarkSize, 0, cxMarkSize, cxMarkSize));
    FillRect(Bounds(R.Right - cxMarkSize, R.Bottom - cxMarkSize, cxMarkSize, cxMarkSize));
    FillRect(Bounds(R.Left, R.Bottom - cxMarkSize, cxMarkSize, cxMarkSize));
  end;
end;


end.
