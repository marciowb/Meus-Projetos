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
unit cxWebReg;

interface

{$I cxVer.inc}

procedure Register;

implementation

uses
  Classes, SysUtils, ToolsAPI, TypInfo, DB,  Math,
  DesignIntf, DesignEditors, ColnEdit,
  {$IFDEF VCL}
  Windows, Graphics, ComCtrls, ExtDlgs, ImgList, ActnList, DMForm, Forms, VCLEditors,
  {$ELSE}
  Qt, Types, QGraphics, QComCtrls, QDialogs, QImgList, QActnList, Clxdmsurface,
  QForms, CLXEditors,
  {$ENDIF}
  cxWebDsgnBaseModules, cxWebModule, cxWebDsgnModule, cxWebDsgnConsts, cxWebProd,
  cxWebModuleWizard,  cxWebDsgnUtils, cxfmWebStyleDsgn, cxfmWebGridsDsgn,
  cxfmWebTVDsgn, cxfmWebMenusDsgn, cxWebIntf,  cxWebGraphics, cxWebTypes,
  cxWebColors, cxWebClasses,  cxWebControls, cxWebImgList, cxWebStdCtrls,
  cxWebMenus, cxWebMainMenu, cxWebTV, cxWebGrids,  cxWebDateEdit, cxWebCalendar,
  cxWebData, cxWebDataNavigator, cxWebExtData, cxWebDataCtrls, cxWebDsgnFactory,
  cxWebDsgnIntf, cxWebTable, cxWebDBTable, cxWebDBGrid, cxWebDBLookup,
  cxWebExtCtrls, cxWebNavBar, cxWebScript;

const
  scxUndefined = 'Undefined';
  sInternetToolBar = 'InternetToolBar'; // has forgotten by Borland ???

type
  TcxWebTreeViewEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebTreeViewItemsProperty = class(TComponentProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  TcxWebStyleIndexProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  TcxWebColorProperty = class(TIntegerProperty
  {$IFDEF VCL}, ICustomPropertyDrawing, ICustomPropertyListDrawing{$ENDIF})
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    {$IFDEF VCL}
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
    {$ENDIF}
  end;

  TcxWebBorderWidthProperty = class(TEnumProperty
  {$IFDEF VCL}, ICustomPropertyDrawing, ICustomPropertyListDrawing{$ENDIF})
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    {$IFDEF VCL}
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
      var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
      var AHeight: Integer);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);
    {$ENDIF}
  end;

  TcxWebBordersColorProperty = class(TcxWebColorProperty)
  public
    function GetValue: string; override;
  end;

  TcxWebBordersStyleProperty = class(TEnumProperty)
  public
    function GetValue: string; override;
  end;

  TcxWebBordersWidthProperty = class(TcxWebBorderWidthProperty)
  public
    function GetValue: string; override;
  end;

  TcxCustomEventTypeProperty = class(TIntegerProperty)
  protected
    function EventHelper: TcxWebEventsHelper;
    function WebComponent: TcxWebComponent;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TcxWebStyleComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebDataFieldsProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetDataSource: TcxCustomWebDataSource; virtual;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TcxWebDataBindingFieldsProperty = class(TcxWebDataFieldsProperty)
  public
    function GetDataSource: TcxCustomWebDataSource; override;
  end;

  TcxWebLookupFieldsProperty = class(TcxWebDataFieldsProperty)
  public
    function GetDataSource: TcxCustomWebDataSource; override;
  end;

  TcxWebGridColumnFieldsProperty = class(TcxWebDataFieldsProperty)
  public
    function GetDataSource: TcxCustomWebDataSource; override;
  end;

  TcxDataSetStdFieldsProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetDataSet: TDataSet; virtual;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TcxDataSetDBDataControllerFieldsProperty = class(TcxDataSetStdFieldsProperty)
  public
    function GetDataSet: TDataSet; override;
  end;

  TcxWebURLTargetProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TcxWebGridsColumnEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebMenusEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxMenuItemProperty = class(TComponentProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  TcxWebImageFileNameProperty = class(TStringProperty)
  protected
    function GetFileName: string; virtual;
    procedure SetFileName(const Value: string); virtual;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  TcxWebImageListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebDataNavigatorButtonsEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebTableColumnsEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebNavBarGroupsEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebDataSourceEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TcxWebDesignerIDProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TcxServerScriptProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

 { TcxWebTreeViewEditor }

procedure TcxWebTreeViewEditor.ExecuteVerb(Index: Integer);
begin
  if (Index = 0) and ShowcxWebTreeViewEditor(TcxWebTreeView(Component)) then
    Designer.Modified;
end;

function TcxWebTreeViewEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Items Editor...';
    1: Result := '-';
  end;
end;

function TcxWebTreeViewEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;


{ TcxWebTreeViewItemsProperty }

function TcxWebTreeViewItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TcxWebTreeViewItemsProperty.GetValue: string;
begin
  Result := '(' + TcxWebTreeItem.ClassName + ')';
end;

procedure TcxWebTreeViewItemsProperty.Edit;
begin
  ShowcxWebTreeViewEditor(GetComponent(0) as TcxWebTreeView);
end;


{ TcxWebStyleIndexProperty }

function TcxWebStyleIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [];
end;


{ TcxWebColorProperty }

function TcxWebColorProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

function TcxWebColorProperty.GetValue: string;
begin
  Result := cxWebColorToString(TcxWebColor(GetOrdValue));
end;

procedure TcxWebColorProperty.GetValues(Proc: TGetStrProc);
begin
  cxGetWebColorValues(Proc);
end;

procedure TcxWebColorProperty.SetValue(const Value: string);
begin
  SetOrdValue(cxStringToWebColor(Value));
end;
{$IFDEF VCL}
procedure TcxWebColorProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + ACanvas.TextHeight('Wg');
end;

procedure TcxWebColorProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := 2 + ACanvas.TextHeight('Wg') + 2;
end;

procedure TcxWebColorProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, GetName);
end;

procedure TcxWebColorProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
var
  S: string;
begin
  S := GetVisualValue;
  if (S = '') or SameText(S, scxUndefined) then
    ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, S)
  else
    ListDrawValue(S, ACanvas, ARect, True)
end;

procedure TcxWebColorProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  R: TRect;
  PrevBrushColor: TColor;
begin
  R := ARect;
  PrevBrushColor := ACanvas.Brush.Color;
  try
    R.Right := R.Left + (R.Bottom - R.Top);
    ACanvas.FrameRect(R);
    InflateRect(R, -1, -1);
    ACanvas.Brush.Color := clBtnShadow;
    ACanvas.FrameRect(R);
    InflateRect(R, -1, -1);
    ACanvas.Brush.Color := cxStringToWebColor(Value);
    ACanvas.FillRect(R);
    InflateRect(R, 2, 2);
  finally
    ACanvas.Brush.Color := PrevBrushColor;
    R := ARect;
    R.Left := R.Left + R.Bottom - R.Top;
    ACanvas.TextRect(R, R.Left + 2, R.Top + 1, Value);
  end;
end;
{$ENDIF}

{ TcxWebBorderWidthProperty }

function TcxWebBorderWidthProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

function TcxWebBorderWidthProperty.GetValue: string;
begin
  Result := cxWebWidthToString(TcxWebBorderWidth(GetOrdValue));
end;

procedure TcxWebBorderWidthProperty.GetValues(Proc: TGetStrProc);
begin
  cxWebGetWidthValues(Proc);
end;

procedure TcxWebBorderWidthProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if cxWebIdentToWidth(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;

{$IFDEF VCL}
procedure TcxWebBorderWidthProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + ACanvas.TextHeight('Wg');
end;

procedure TcxWebBorderWidthProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := 2 + ACanvas.TextHeight('Wg') + 2;
end;

procedure TcxWebBorderWidthProperty.PropDrawName(ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
begin
  ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, GetName);
end;

procedure TcxWebBorderWidthProperty.PropDrawValue(ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
var
  S: string;
  Width: Integer;
begin
  S := GetVisualValue;
  if (S = '') or not cxWebIdentToWidth(Value, Width) or SameText(S, scxUndefined) then
    ACanvas.TextRect(ARect, ARect.Left + 1, ARect.Top + 1, S)
  else
    ListDrawValue(S, ACanvas, ARect, True)
end;

procedure TcxWebBorderWidthProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
const
  Offset = 10;
var
  R, R2: TRect;
  PrevBrushColor: TColor;
  Width: Integer;
begin
  R := ARect;
  PrevBrushColor := ACanvas.Brush.Color;
  try
    R.Right := Offset + R.Left + (R.Bottom - R.Top);
    ACanvas.FrameRect(R);
    InflateRect(R, -1, -1);
    ACanvas.Brush.Color := clBtnShadow;
    ACanvas.FrameRect(R);

    InflateRect(R, -1, -1);
    ACanvas.Brush.Color := clWindow;
    ACanvas.FillRect(R);

    if not cxWebIdentToWidth(Value, Width) then
      Width := StrToInt(Value);
    R2 := Rect(R.Left + 1, R.Top + (R.Bottom - R.Top - Width) div 2, R.Right - 1,
      R.Top + (R.Bottom - R.Top + Width) div 2);
    ACanvas.Brush.Color := clWindowText;
    ACanvas.FillRect(R2);

    InflateRect(R, 2, 2);
  finally
    ACanvas.Brush.Color := PrevBrushColor;
    R := ARect;
    R.Left := R.Left + (R.Bottom - R.Top) + Offset;
    ACanvas.TextRect(R, R.Left + 2, R.Top + 1, Value);
  end;
end;
{$ENDIF}

{ TcxWebBordersColorProperty }

function TcxWebBordersColorProperty.GetValue: string;
begin
  if (PropCount = 1) and not (GetComponent(0) as TcxWebBorders).SameColors then
    Result := scxUndefined
  else
    Result := inherited GetValue;
end;


{ TcxWebBordersStyleProperty }

function TcxWebBordersStyleProperty.GetValue: string;
begin
  if (PropCount = 1) and not (GetComponent(0) as TcxWebBorders).SameStyles then
    Result := scxUndefined
  else
    Result := inherited GetValue;
end;


{ TcxWebBordersWidthProperty }

function TcxWebBordersWidthProperty.GetValue: string;
begin
  if (PropCount = 1) and not (GetComponent(0) as TcxWebBorders).SameWidths then
    Result := scxUndefined
  else
    Result := inherited GetValue;
end;

{ TcxCustomEventTypeProperty }

function TcxCustomEventTypeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

function TcxCustomEventTypeProperty.GetValue: string;
begin
  if EventHelper <> nil then
    Result := GetEnumName(EventHelper.EventTypeInfo, GetOrdValue)
  else Result := '';
end;

procedure TcxCustomEventTypeProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  if EventHelper <> nil then
    for I := EventHelper.MinEventValue to EventHelper.MaxEventValue do
      Proc(GetEnumName(EventHelper.EventTypeInfo, I));
end;

procedure TcxCustomEventTypeProperty.SetValue(const Value: string);
var
  OrdValue: Integer;
begin
  if EventHelper <> nil then
  begin
    OrdValue := GetEnumValue(EventHelper.EventTypeInfo, Value);
    if (EventHelper.MinEventValue <= OrdValue) and (OrdValue <= EventHelper.MaxEventValue) then
    SetOrdValue(OrdValue);
  end;
end;

type
  TcxWebComponentAccess = class(TcxWebComponent);

function TcxCustomEventTypeProperty.EventHelper: TcxWebEventsHelper;
begin
  if WebComponent <> nil then
    Result := TcxWebComponentAccess(WebComponent).WebEventsHelper
  else Result := nil;
end;

function TcxCustomEventTypeProperty.WebComponent: TcxWebComponent;
begin
  Result := (TcxCustomEventItem(GetComponent(0)).Collection.Owner) as TcxWebComponent;
end;

{ TcxWebStyleComponentEditor }

procedure TcxWebStyleComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    cxShowWebStylesDesigner(TcxWebStyleController(Component), Designer);
end;

function TcxWebStyleComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Styles Editor...'
  else
    Result := '-';
end;

function TcxWebStyleComponentEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxDataControllerFieldsProperty }

function TcxWebDataFieldsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

function TcxWebDataFieldsProperty.GetDataSource: TcxCustomWebDataSource;
begin
  Result := GetComponent(0) as TcxCustomWebDataSource;
end;

type
  TcxCustomWebDataSourceAccess = class(TcxCustomWebDataSource);

procedure TcxWebDataFieldsProperty.GetValueList(List: TStrings);
var
  I: Integer;
  ADataSource: TcxCustomWebDataSource;
begin
  ADataSource := GetDataSource;
  if ADataSource <> nil then
  begin
    TcxCustomWebDataSourceAccess(ADataSource).UpdateDefaultFields;
    for I := 0 to ADataSource.Fields.Count - 1 do
      List.Add(ADataSource.Fields[I].Name);
  end;
end;

procedure TcxWebDataFieldsProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ TcxWebDataBindingFieldsProperty }

function TcxWebDataBindingFieldsProperty.GetDataSource: TcxCustomWebDataSource;
begin
  Result := TcxAbstractWebDataBinding(GetComponent(0)).DataSource;
end;


{ TcxWebLookupFieldsProperty }

function TcxWebLookupFieldsProperty.GetDataSource: TcxCustomWebDataSource;
begin
  Result := TcxWebLookupDataBinding(GetComponent(0)).ListSource;
end;

{ TcxWebGridColumnFieldsProperty }

function TcxWebGridColumnFieldsProperty.GetDataSource: TcxCustomWebDataSource;
begin
  Result := TcxWebGridColumnDataBinding(GetComponent(0)).ListSource;
end;

{ TcxDataSetStdFieldsProperty }

function TcxDataSetStdFieldsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

function TcxDataSetStdFieldsProperty.GetDataSet: TDataSet;
begin
  Result := (GetComponent(0) as TcxStdWebDataField).DataSet;
end;

procedure TcxDataSetStdFieldsProperty.GetValueList(List: TStrings);
var
  I: Integer;
  DataSet: TDataSet;
begin
  DataSet := GetDataSet;
  if DataSet <> nil then
    for I := 0 to DataSet.Fields.Count - 1 do
      List.Add(DataSet.Fields[I].FieldName);
end;

procedure TcxDataSetStdFieldsProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ TcxDataSetDBDataControllerFieldsProperty }

function TcxDataSetDBDataControllerFieldsProperty.GetDataSet: TDataSet;
begin
  Result := (GetComponent(0) as TcxWebDBDataControllerField).DataSet;
end;

{ TcxWebURLTargetProperty }

function TcxWebURLTargetProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TcxWebURLTargetProperty.GetValues(Proc: TGetStrProc);
const
  cxWebTargets: array[TcxWebStandardTarget] of string = ('_blank', '_media', '_parent', '_search', '_self', '_top');
var
  I: TcxWebStandardTarget;
begin
  for I := Low(TcxWebStandardTarget) to High(TcxWebStandardTarget) do
    Proc(cxWebTargets[I]);
end;

{ TcxWebGridsColumnEditor }

procedure TcxWebGridsColumnEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    cxShowWebGridsColumnDesigner(TcxCustomWebGrid(Component), Designer);
end;

function TcxWebGridsColumnEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Columns Editor...'
  else
    Result := '-';
end;

function TcxWebGridsColumnEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxWebMenusEditor }

procedure TcxWebMenusEditor.ExecuteVerb(Index: Integer);
var
  MenuIntf: IcxWebMenu;
begin
  if Index = 0 then
  begin
    if Component.GetInterface(IcxWebMenu, MenuIntf) then
      cxShowWebMenusDesigner(MenuIntf.MenuHelper, Designer);
  end;
end;

function TcxWebMenusEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Menu Editor...'
  else
    Result := '-';
end;

function TcxWebMenusEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxMenuItemProperty }

function TcxMenuItemProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TcxMenuItemProperty.GetValue: string;
begin
  Result := '(' + TcxWebMenuItem.ClassName + ')';
end;

procedure TcxMenuItemProperty.Edit;
var
  MenuIntf: IcxWebMenu;
begin
  if GetComponent(0).GetInterface(IcxWebMenu, MenuIntf) then
    cxShowWebMenusDesigner(MenuIntf.MenuHelper, Designer);
end;

{ TcxWebImageListItemFileNameProperty }

procedure TcxWebImageFileNameProperty.Edit;
var
  ADialog: {$IFDEF VCL}TOpenPictureDialog{$ELSE}TOpenDialog{$ENDIF};
begin
  ADialog := {$IFDEF VCL}TOpenPictureDialog{$ELSE}TOpenDialog{$ENDIF}.Create(nil);
  {$IFNDEF VCL}
  ADialog.Options := [ofPathMustExist, ofFileMustExist, ofEnableSizing, ofHideReadOnly, ofPreview];
  ADialog.Title := 'Load Picture';
  ADialog.Filter := 'All (*.jpg;*.ddw;*.bmp;*.png;*.xpm;*.ico)|*.jpg;*.ddw;*.bmp;*.png;*.xpm;*.ico';
  {$ENDIF}
  ADialog.FileName := GetFileName;
  if ADialog.Execute then SetFileName(ADialog.FileName);
  ADialog.Free;
end;

function TcxWebImageFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TcxWebImageFileNameProperty.GetValue: string;
begin
  Result := GetFileName;
end;

function TcxWebImageFileNameProperty.GetFileName: string;
begin
  Result := (GetComponent(0) as TcxCustomWebImage).DesignPicturePath;
end;

procedure TcxWebImageFileNameProperty.SetFileName(const Value: string);
begin
  (GetComponent(0) as TcxCustomWebImage).DesignPicturePath := Value;
end;

{ TcxWebImageListEditor }

procedure TcxWebImageListEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowCollectionEditor(Designer, Component,
        TcxWebImageList(Component).Images, 'Images');
end;

function TcxWebImageListEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'ImageList Editor...'
  else
    Result := '-';
end;

function TcxWebImageListEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxWebDataNavigatorButtonsEditor }

procedure TcxWebDataNavigatorButtonsEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowCollectionEditor(Designer, Component,
        TcxCustomWebDataNavigator(Component).Buttons, 'Buttons');
end;

function TcxWebDataNavigatorButtonsEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Buttons Editor...'
  else
    Result := '-';
end;

function TcxWebDataNavigatorButtonsEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxWebTableColumnsEditor }

procedure TcxWebTableColumnsEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowCollectionEditor(Designer, Component,
        TcxCustomWebTable(Component).Columns, 'Columns');
end;

function TcxWebTableColumnsEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Columns Editor...'
  else
    Result := '-';
end;

function TcxWebTableColumnsEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxWebNavBarGroupsEditor }

procedure TcxWebNavBarGroupsEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowCollectionEditor(Designer, Component,
        TcxWebNavBar(Component).Groups, 'Groups');
end;

function TcxWebNavBarGroupsEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Groups Editor...'
  else
    Result := '-';
end;

function TcxWebNavBarGroupsEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TcxWebDataSourceEditor }

procedure TcxWebDataSourceEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowCollectionEditor(Designer, Component,
        TcxWebDataSource(Component).Fields, 'Fields');
end;

function TcxWebDataSourceEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Fields Editor...'
  else Result := '-';
end;

function TcxWebDataSourceEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

var
  ModuleWizard: IOTAWizard;

type
  TToolButtonAccess = class(TToolButton);

  TToolExecutor = class
  public
    class procedure Execute(Sender: TObject);
  end;

class procedure TToolExecutor.Execute(Sender: TObject);
begin
  if ModuleWizard <> nil then ModuleWizard.Execute;
end;

{$IFDEF VCL}
procedure cxRegisterWebWizardInternetBarItem;
const
  SeparatorName: string = 'btncxWebWizardSeparator';
  ButtonName: string = 'btncxWebWizardButton';
  ActionName: string = 'actcxWebWizard';
var
  ToolBar: TToolBar;

  procedure AddSeparator;
  var
    Separator: TToolButton;
  begin
    Separator := TToolButton(ToolBar.FindComponent(SeparatorName));
    if Separator <> nil then Separator.Free;

    Separator := TToolButton.Create(ToolBar);
    Separator.Name := SeparatorName;
    TToolButtonAccess(Separator).SetToolBar(ToolBar);
    Separator.Style := tbsSeparator;
    Separator.Width := 6;
  end;

  procedure AddButton;

    function CreateAction(ABitmap: TBitmap): TAction;
    begin
      Result := TAction(Application.FindComponent(ActionName));
      if Result <> nil then Result.Free;

      Result := TAction.Create(Application);
      Result.Name := ActionName;
      Result.ImageIndex :=
        (BorlandIDEServices as INTAServices40).AddMasked(ABitmap, ABitmap.Canvas.Pixels[0, ABitmap.Height - 1]);
      Result.OnExecute := TToolExecutor.Execute;
      Result.Hint := scxNewWebModuleHint;
    end;

  var
    ToolButton: TToolButton;
    Bitmap: TBitmap;
  begin
    ToolButton := TToolButton(ToolBar.FindComponent(ButtonName));
    if ToolButton <> nil then ToolButton.Free;

    ToolButton := TToolButton.Create(ToolBar);
    ToolButton.Name := ButtonName;
    ToolButton.ParentShowHint := True;
    TToolButtonAccess(ToolButton).SetToolBar(ToolBar);
    Bitmap := TBitmap.Create;
    try
      Bitmap.LoadFromResourceName(hInstance, 'TCXWEBMODULE');
      ToolButton.Action := CreateAction(Bitmap);
    finally
      Bitmap.Free;
    end;
  end;

begin
  ToolBar := (BorlandIDEServices as INTAServices40).ToolBar[sInternetToolBar];
  if ToolBar <> nil then
  begin
    AddSeparator;
    AddButton;
  end;
end;
{$ENDIF}

{TcxWebDesignerIDProperty}
function TcxWebDesignerIDProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

function TcxWebDesignerIDProperty.GetValue: string;
var
  AWebDesignerClass: TcxAbstractWebDesignerClass;
begin
  AWebDesignerClass := WebDesignerFactory.GetDesignerByID(GetOrdValue);
  if AWebDesignerClass <> nil then
    Result := AWebDesignerClass.GetName
  else Result := '';
end;

procedure TcxWebDesignerIDProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
begin
  for i := 0 to WebDesignerFactory.Count - 1 do
    Proc(WebDesignerFactory[i].GetName);
end;

procedure TcxWebDesignerIDProperty.SetValue(const Value: string);
var
  AWebDesignerClass: TcxAbstractWebDesignerClass;
begin
  AWebDesignerClass := WebDesignerFactory.GetDesignerByName(Value);
  if (AWebDesignerClass <> nil) and (CompareText(AWebDesignerClass.GetName, Value) = 0) then
    SetOrdValue(AWebDesignerClass.GetID);
end;

{ TcxServerScriptProperty }

function TcxServerScriptProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList, paRevertable];
end;

function TcxServerScriptProperty.GetValue: string;
begin
  if GetOrdValue <> 0 then
  begin
    Result := AvailableScriptEngines.GetEngineName(TcxScriptEngine(GetOrdValue));
    if Result = '' then
      Result := inherited GetValue + ' (unknown)';
  end
  else
    Result := '';
end;

procedure TcxServerScriptProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  with AvailableScriptEngines do
    for I := 0 to Count - 1 do
      Proc(GetEngineName(Engine[I]));
end;

procedure TcxServerScriptProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  if Value <> '' then
  begin
    I := AvailableScriptEngines.IndexOfName(Value);
    if I <> -1 then
      SetOrdValue(AvailableScriptEngines.Engine[I])
    else inherited SetValue(Value);
  end
  else
    SetOrdValue(0);
end;

const
  cxWebStandardControls: array[0..17] of TComponentClass =
   (TcxWebCustomControl, TcxWebLabel, TcxWebURLLabel, TcxWebEdit, TcxWebMemo, TcxWebButton,
    TcxWebListBox, TcxWebComboBox, TcxWebCheckBox, TcxWebRadioGroup, TcxWebPanel,
    TcxWebImage, TcxWebTreeView, TcxWebMainMenu, TcxWebCalendar, TcxWebDateEdit,
    TcxWebTable, TcxWebNavBar);
  cxWebDBControls: array[0..14] of TComponentClass =
   (TcxWebDBLabel, TcxWebDBEdit, TcxWebDBMemo, TcxWebDBListBox, TcxWebDBComboBox,
    TcxWebDBCheckBox, TcxWebDBRadioGroup, TcxWebDBImage, TcxWebDBCalendar,
    TcxWebDBDateEdit, TcxWebDBDataNavigator, TcxWebDBGrid, TcxWebDBTable,
    TcxWebDBLookup, TcxWebExtDBLookup);
  cxWebInvisibleControls: array[0..6] of TComponentClass =
   (TcxWebPopupMenu, TcxWebImageList, TcxWebStyleController,
    TcxStdWebDataSource, TcxWebDataSource, TcxWebDBDataSource,  TcxWebTimer);
 cxWebNoIconComponents: array[0..3] of TComponentClass =
   (TcxWebModulePageProducer, TcxWebStyleItem, TcxWebMenuItem, TcxWebColumn);

procedure Register;
begin
  RegisterCustomModule(TcxWebPageModule, TcxCustomWebPageModuleDesigner);
  RegisterCustomModule(TcxWebFramesetModule, TcxCustomWebPageModuleDesigner);
  RegisterCustomModule(TcxWebDataModule, TDataModuleCustomModule);
  RegisterCustomModule(TcxWebHomeDataModule, TDataModuleCustomModule);
  cxWebRegisterBasePageModule(TcxWebPageModule);
  cxWebRegisterBasePageModule(TcxWebFramesetModule);

  cxRegisterWebComponents('EWF Controls', cxWebStandardControls, True);
  cxRegisterWebComponents('EWF Data Controls', cxWebDBControls, True);
  cxRegisterWebComponents('EWF Components', cxWebInvisibleControls, False);
  RegisterNoIcon(cxWebNoIconComponents);

  RegisterComponentEditor(TcxWebStyleController, TcxWebStyleComponentEditor);
  RegisterComponentEditor(TcxWebTreeView, TcxWebTreeViewEditor);
  RegisterComponentEditor(TcxCustomWebGrid, TcxWebGridsColumnEditor);
  RegisterComponentEditor(TcxWebPopupMenu, TcxWebMenusEditor);
  RegisterComponentEditor(TcxWebMainMenu, TcxWebMenusEditor);
  RegisterComponentEditor(TcxWebImageList, TcxWebImageListEditor);
  RegisterComponentEditor(TcxCustomWebDataNavigator, TcxWebDataNavigatorButtonsEditor);
  RegisterComponentEditor(TcxCustomWebTable, TcxWebTableColumnsEditor);
  RegisterComponentEditor(TcxWebNavBar, TcxWebNavBarGroupsEditor);
  RegisterComponentEditor(TcxWebDataSource, TcxWebDataSourceEditor);

  RegisterPropertyEditor(TypeInfo(TCollection), TcxWebDataControllerFields, 'Fields', TCollectionProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxStdWebDataField, 'FieldName', TcxDataSetStdFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxWebDBDataControllerField, 'FieldName', TcxDataSetDBDataControllerFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxAbstractWebDataBinding, 'FieldName', TcxWebDataBindingFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxCustomWebDataSource, 'KeyFieldName', TcxWebDataFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxCustomWebDBLookupDataBinding, 'KeyFieldName', TcxWebLookupFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxWebLookupDataBinding, 'ListFieldName', TcxWebLookupFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxWebGridColumnDataBinding, 'KeyFieldName', TcxWebGridColumnFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxWebGridColumnDataBinding, 'ListFieldName', TcxWebGridColumnFieldsProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxURL, 'Target', TcxWebURLTargetProperty);

  RegisterPropertyEditor(TypeInfo(TcxWebTabOrder), TcxWebControl, 'TabOrder', TTabOrderProperty);
  RegisterPropertyEditor(TypeInfo(TcxWebColor), nil, '', TcxWebColorProperty);
  RegisterPropertyEditor(TypeInfo(TcxWebBorderWidth), TcxWebBorder, 'Width', TcxWebBorderWidthProperty);

  RegisterPropertyEditor(TypeInfo(TcxWebColor), TcxWebBorders, 'Color', TcxWebBordersColorProperty);
  RegisterPropertyEditor(TypeInfo(TcxWebBorderStyle), TcxWebBorders, 'Style', TcxWebBordersStyleProperty);
  RegisterPropertyEditor(TypeInfo(TcxWebBorderWidth), TcxWebBorders, 'Width', TcxWebBordersWidthProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TcxCustomEventItem, 'EventType', TcxCustomEventTypeProperty);

  RegisterPropertyEditor(TypeInfo(TcxWebTreeItem), TcxWebTreeView, 'Items', TcxWebTreeViewItemsProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TcxWebStyleItem, 'Index', TcxWebStyleIndexProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxWebFont, 'Name', TFontNameProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TcxWebImages, 'Images', TCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TcxWebMenuItem), TcxWebPopupMenu, 'Items', TcxMenuItemProperty);
  RegisterPropertyEditor(TypeInfo(TcxWebMenuItem), TcxWebMainMenu, 'Items', TcxMenuItemProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxWebImage, 'DesignPicturePath', TcxWebImageFileNameProperty);

  RegisterPropertyEditor(TypeInfo(TcxWebStyleItem), TcxWebComponent, 'StyleItem_Default', nil);
  RegisterPropertyEditor(TypeInfo(TcxWebStyleItem), TcxWebComponent, 'StyleItem_Hover', nil);
  RegisterPropertyEditor(TypeInfo(TcxWebDate), TcxWebComponent, 'SelectedDate', TDateProperty);

  RegisterPropertyEditor(TypeInfo(Integer), TcxCustomWebPageModule, 'DesignerID', TcxWebDesignerIDProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TcxCustomWebFramesetModule, 'DesignerID', TcxWebDesignerIDProperty);
  RegisterPropertyEditor(TypeInfo(TcxScriptEngine), nil, '', TcxServerScriptProperty);
end;

end.

