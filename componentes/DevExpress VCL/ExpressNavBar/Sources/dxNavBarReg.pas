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

unit dxNavBarReg;

{$I cxVer.inc}

interface

procedure Register;

implementation

uses
  Classes, Windows, Graphics, Controls, Forms, ImgList, SysUtils, Math,
{$IFDEF DELPHI6}
  Types, VCLEditors, DesignIntf, DesignEditors,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  ToolsAPI,
  dxCoreReg, cxLibraryReg, cxPropEditors, dxNavBar, dxNavBarBase, dxNavBarCollns, dxNavBarStyles,
  dxNavBarConsts, dxNavBarDsgnConsts, dxfmNavBarDsgnEditor, dxNavBarViewsFact;

type
  TdxNavBarViewProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TdxNavBarViewStyleProperty }

  TdxNavBarViewStyleProperty = class(TClassProperty)
  protected
    function HasSubProperties: Boolean;
    function View: Integer;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TdxImageIndexProperty = class(TIntegerProperty{$IFDEF DELPHI6}, ICustomPropertyListDrawing{$ENDIF})
  protected
    function GetCollectionItem: TdxNavBarComponentCollectionItem; virtual;
    function GetImages: TCustomImageList; virtual;
    function GetNavBar: TdxCustomNavBar; virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer); {$IFNDEF DELPHI6}override;{$ENDIF}
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6}override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6}override;{$ENDIF}
  end;

  TdxSmallImageIndexProperty = class(TdxImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

  TdxLargeImageIndexProperty = class(TdxImageIndexProperty)
  protected
    function GetImages: TCustomImageList; override;
  end;

  TdxNavBarCursorProperty = class(TCursorProperty{$IFDEF DELPHI6}, ICustomPropertyListDrawing{$ENDIF})
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;

    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer); {$IFNDEF DELPHI6} override;{$ENDIF}
    procedure ListMeasureWidth(const Value: string;
      ACanvas: TCanvas; var AWidth: Integer); {$IFNDEF DELPHI6} override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6} override;{$ENDIF}
  end;

  TdxNavBarComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

{ TdxNavBarViewProperty }

function TdxNavBarViewProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

function TdxNavBarViewProperty.GetValue: string;
var
  AValue: Integer;
begin
  AValue := GetOrdValue;
  if (0 <= AValue) and (AValue < dxNavBarViewsFactory.Count) then
    Result := dxNavBarViewsFactory.Names[AValue]
  else Result := '';
end;

procedure TdxNavBarViewProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to dxNavBarViewsFactory.Count - 1 do
    Proc(dxNavBarViewsFactory.Names[I]);
end;

procedure TdxNavBarViewProperty.SetValue(const Value: string);
var
  AValue: Integer;
begin
  AValue := dxNavBarViewsFactory.IndexOfName(Value);
  if AValue > -1 then SetOrdValue(AValue);
end;

{ TdxNavBarViewStyleProperty }

function TdxNavBarViewStyleProperty.HasSubProperties: Boolean;
begin
  Result := View in [dxNavBarSkinExplorerBarView, dxNavBarSkinNavigatorPaneView];
end;

function TdxNavBarViewStyleProperty.View: Integer;
begin
  if GetComponent(0) is TdxNavBar then
    Result := (GetComponent(0) as TdxNavBar).View
  else
    Result := -1;
end;

function TdxNavBarViewStyleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, paSubProperties);
  Result := Result - [paReadOnly] + [paValueList, paSortList, paRevertable] +
    {$IFDEF DELPHI6}[paVolatileSubProperties] {$ELSE } [] {$ENDIF};
end;

function TdxNavBarViewStyleProperty.GetValue: string;
var
  AValue: Integer;
begin
  AValue := View;
  if (0 <= AValue) and (AValue < dxNavBarViewsFactory.Count) then
    Result := dxNavBarViewsFactory.Names[AValue]
  else
    Result := '';
end;

procedure TdxNavBarViewStyleProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to dxNavBarViewsFactory.Count - 1 do
    Proc(dxNavBarViewsFactory.Names[I]);
end;

procedure TdxNavBarViewStyleProperty.SetValue(const Value: string);
begin
  {$IFNDEF DELPHI7}
    ObjectInspectorCollapseProperty;
  {$ENDIF}
  (GetComponent(0) as TdxNavBar).View := dxNavBarViewsFactory.IndexOfName(Value);
  Modified;
end;

{ TdxImageIndexProperty  }

function TdxImageIndexProperty.GetCollectionItem: TdxNavBarComponentCollectionItem;
begin
  Result := GetComponent(0) as TdxNavBarComponentCollectionItem;
end;

function TdxImageIndexProperty.GetImages: TCustomImageList;
begin
  Result := nil;
end;

function TdxImageIndexProperty.GetNavBar: TdxCustomNavBar;
begin
  Result := GetCollectionItem.GetParentComponent as TdxCustomNavBar;
end;

function TdxImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

procedure TdxImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  Proc('-1');
  if GetImages = nil then Exit;
  for I := 0 to GetImages.Count - 1 do
    Proc(IntToStr(I));
end;

procedure TdxImageIndexProperty.ListMeasureWidth(const Value: string; ACanvas: TCanvas;
  var AWidth: Integer);
begin
  inherited;
  if GetImages <> nil then Inc(AWidth, 1 + GetImages.Width + 1);
end;

procedure TdxImageIndexProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas;
  var AHeight: Integer);
begin
  inherited;
  if (GetImages <> nil) and (AHeight < 1 + GetImages.Height + 1) then
    AHeight := 1 + GetImages.Height + 1;
end;

procedure TdxImageIndexProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
var
  ATextRect: TRect;
  PrevBrushColor: TColor;
begin
  ATextRect := ARect;
  if GetImages <> nil then
  begin
    Inc(ATextRect.Left, 1 + GetImages.Width + 1);
    with ARect do
    begin
      PrevBrushColor := ACanvas.Brush.Color;
      ACanvas.Brush.Color := clWindow;
      ACanvas.FillRect(Rect(Left, Top, ATextRect.Left, Bottom));
      ACanvas.Brush.Color := PrevBrushColor;
    end;
    GetImages.Draw(ACanvas, ARect.Left + 1, ARect.Top + 1, StrToInt(Value));
  end;
  with ATextRect, ACanvas do
    ACanvas.TextRect(ATextRect, Left + 1, (Top + Bottom - TextHeight(Value)) div 2, Value);
end;

{ TdxSmallImageIndexProperty }

function TdxSmallImageIndexProperty.GetImages: TCustomImageList;
begin
  if GetNavBar <> nil then
    Result := GetNavBar.SmallImages
  else Result := nil;
end;

{ TdxLargeImageIndexProperty }

function TdxLargeImageIndexProperty.GetImages: TCustomImageList;
begin
  if GetNavBar <> nil then
    Result := GetNavBar.LargeImages
  else Result := nil;
end;

{ TdxNavBarCursorProperty }

function TdxNavBarCursorProperty.GetValue: string;
begin
  if not IntToIdent(TCursor(GetOrdValue), Result, dxNavBarCursors) then
    Result := inherited GetValue;
end;

procedure TdxNavBarCursorProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  inherited;
  for I := Low(dxNavBarCursors) to High(dxNavBarCursors) do
    Proc(dxNavBarCursors[I].Name);
end;

procedure TdxNavBarCursorProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToInt(Value, NewValue, dxNavBarCursors) then
    SetOrdValue(NewValue)
  else inherited SetValue(Value);
end;

procedure TdxNavBarCursorProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas;
  var AHeight: Integer);
begin
  AHeight := Max(ACanvas.TextHeight('Wg'), GetSystemMetrics(SM_CYCURSOR) + 4);
end;

procedure TdxNavBarCursorProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + GetSystemMetrics(SM_CXCURSOR) + 4;
end;

procedure TdxNavBarCursorProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
var
  Right: Integer;
  CursorIndex: Integer;
  CursorHandle: THandle;
{$IFNDEF DELPHI6}
  R: TRect;
{$ENDIF}
begin
  Right := ARect.Left + GetSystemMetrics(SM_CXCURSOR) + 4;
  with ACanvas do
  begin
    if not Classes.IdentToInt(Value, CursorIndex, dxNavBarCursors) then
      if not IdentToCursor(Value, CursorIndex) then
        CursorIndex := StrToInt(Value);
    ACanvas.FillRect(ARect);
    CursorHandle := Screen.Cursors[CursorIndex];
    if CursorHandle <> 0 then
      DrawIconEx(ACanvas.Handle, ARect.Left + 2, ARect.Top + 2, CursorHandle,
        0, 0, 0, 0, DI_NORMAL or DI_DEFAULTSIZE);
    {$IFDEF DELPHI6}
    DefaultPropertyListDrawValue(Value, ACanvas, Rect(Right, ARect.Top,
      ARect.Right, ARect.Bottom), ASelected);
    {$ELSE}
    R := ARect;
    R.Left := Right + 4;
    ACanvas.TextRect(R, R.Left + 1, R.Top + 1, Value);
    {$ENDIF}
  end;
end;

{ TdxNavBarComponentEditor }

function TdxNavBarComponentEditor.GetProductMajorVersion: string;
begin
  Result := dxNavBarMajorVersion;
end;

function TdxNavBarComponentEditor.GetProductName: string;
begin
  Result := sdxProductName;
end;

function TdxNavBarComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := sdxEditor;
end;

function TdxNavBarComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TdxNavBarComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  dxShowNavBarDesigner(TdxCustomNavBar(Component), Designer);
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}
  RegisterComponents(dxLibraryProductPage, [TdxNavBar]);
  RegisterClasses([TdxNavBarPainter]);
  RegisterNoIconProc([TdxNavBarGroup, TdxNavBarItem, TdxNavBarStyleItem]);
  RegisterPropertyEditor(TypeInfo(Integer), TdxNavBar, 'View', nil);
  RegisterPropertyEditor(TypeInfo(TdxNavBarPainter), TdxNavBar, 'ViewStyle', TdxNavBarViewStyleProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TdxNavBarGroup, 'LargeImageIndex',  TdxLargeImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TdxNavBarGroup, 'SmallImageIndex',  TdxSmallImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TdxNavBarItem, 'LargeImageIndex',  TdxLargeImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TdxNavBarItem, 'SmallImageIndex',  TdxSmallImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TCursor), TdxCustomNavBar, 'DragCursor',  TdxNavBarCursorProperty);
  RegisterPropertyEditor(TypeInfo(TCursor), TdxCustomNavBar, 'DragCopyCursor',  TdxNavBarCursorProperty);
  RegisterPropertyEditor(TypeInfo(TCursor), TdxCustomNavBar, 'HotTrackedGroupCursor',  TdxNavBarCursorProperty);
  RegisterPropertyEditor(TypeInfo(TCursor), TdxCustomNavBar, 'HotTrackedLinkCursor',  TdxNavBarCursorProperty);
  RegisterComponentEditor(TdxNavBar, TdxNavBarComponentEditor);
end;

end.

