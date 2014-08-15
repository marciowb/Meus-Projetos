{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library classes                   }
{                                                                    }
{           Copyright (c) 2000-2010 Developer Express Inc.           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
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

unit cxLibraryReg;

{$I cxVer.inc}

interface

uses
  Windows, SysUtils, Forms, Classes, Controls, Menus, TypInfo, Graphics,
  DesignIntf, DesignEditors, DesignConst, DesignMenus,
  cxPropertiesStore, cxPropertiesStoreEditor,
  PicEdit, dxGDIPlusAPI, dxGDIPlusClasses,
  cxContainer, cxLookAndFeels, cxClasses,
  cxDesignWindows, cxStyleRepositoryEditor, cxImageListEditor, cxStyles,
  cxControls, cxLookAndFeelPainters, dxCoreReg;

const
  cxLibraryMajorVersion = '7';
  dxLibraryProductPage = dxCoreLibraryProductPage;
  dxLibraryProductName = 'ExpressLibrary';

type
  TdxSkinsRequiresAdditionalUnitsProc = procedure (AControlClass: TClass; AProc: TGetStrProc);

  TcxDefaultEditor = class(TDefaultEditor)
  private
    function GetBaseVerbCount: Integer;
  protected
    function GetProductMajorVersion: string; virtual; abstract;
    function GetProductMinorVersion: string; virtual;
    function GetProductName: string; virtual; abstract;
    function InternalGetVerb(AIndex: Integer): string; virtual;
    function InternalGetVerbCount: Integer; virtual;
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TcxControlPopupMenuProperty }

  TcxControlPopupMenuProperty = class(TComponentProperty)
  private
    FProc: TGetStrProc;
    procedure CheckComponent(const Value: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TcxBitmapGraphicProperty }

  TcxBitmapGraphicProperty = class(TGraphicProperty)
  private
    function GetGraphicClass: TGraphicClass;
    procedure OnShowPicEdit(Sender: TObject);
    procedure SetGraphic(AGraphic: TGraphic);
  protected
    function BuildFilter: string; virtual;
    //
    property GraphicClass: TGraphicClass read GetGraphicClass;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TcxBitmapProperty }

  TcxBitmapProperty = class(TcxBitmapGraphicProperty)
  protected
    function BuildFilter: string; override;
  end;

  { TcxFilenameProperty }

  TcxFilenameProperty = class(TStringProperty)
  protected
    function GetFilter: string; virtual;
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { TcxLocalizerFilenameProperty }

  TcxLocalizerFilenameProperty = class(TcxFilenameProperty)
  protected
    function GetFilter: string; override;
  end;

var
  FdxSkinsRequiresAdditionalUnits: TdxSkinsRequiresAdditionalUnitsProc;

procedure dxSkinsRequiresAdditionalUnits(AControlClass: TClass; AProc: TGetStrProc);
procedure HideClassProperties(AClass: TClass; APropertyNames: array of string);
procedure Register;

implementation

uses
  VCLEditors, Types, Math, Dialogs, ImgList, cxGraphics, cxPropEditors,
  cxLocalization, dxCore, ToolsApi, cxComponentCollectionEditor;

type
  TcxContainerAccess = class(TcxContainer);

  { TcxLibraryComponentEditor }

  TcxLibraryComponentEditor = class(TdxComponentEditor)
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
  end;

  { TcxLookAndFeelControllerEditor }

  TcxLookAndFeelControllerEditor = class(TcxLibraryComponentEditor)
  private
    function GetLookAndFeelController: TcxLookAndFeelController;
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  public
    procedure Edit; override;
  end;

  { TcxStyleRepositoryComponentEditor }

  TcxStyleRepositoryComponentEditor = class(TcxLibraryComponentEditor)
  private
    function GetStyleRepository: TcxStyleRepository;
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

  { TcxPropertiesStoreComponentEditor }

  TcxPropertiesStoreComponentEditor = class(TcxLibraryComponentEditor)
  private
    function GetPropertiesStore: TcxPropertiesStore;
    property PropertiesStore: TcxPropertiesStore read GetPropertiesStore;
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

  { TcxImageListComponentEditor }

  TcxImageListComponentEditor = class(TcxLibraryComponentEditor)
  private
    function GetImageList: TcxImageList;
  protected
    function IsAssignable: Boolean; override;
    procedure DoAssign(AObject: TObject); override;
    function GetAssignTypeClass: TClass; override;

    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;

    property ImageList: TcxImageList read GetImageList;
  end;

  { TcxLocalizerLocaleProperty }

  TcxLocalizerLocaleProperty = class(TStringProperty)
  private
    function GetLocalizer: TcxLocalizer;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;

    property Localizer: TcxLocalizer read GetLocalizer;
  end;

  { TcxContainerStyleProperty }

  TcxContainerStyleProperty = class(TClassProperty)
  private
    FProc: TGetPropProc;
    procedure GetPropProc(const Prop: IProperty);
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  { TcxContainerStyleAssignedValuesProperty }

  TcxContainerStyleAssignedValuesProperty = class(TSetProperty)
  protected
    procedure FillVisiblePropertiesList(AList: TStringList);
  public
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  end;

  { TcxContainerStyleAssignedValuesElementProperty }

  TcxContainerStyleAssignedValuesElementProperty = class(TSetElementProperty)
  public
    function GetName: string; override;
  end;

  { TcxLookAndFeelProperty }

  TcxLookAndFeelProperty = class(TClassProperty)
  private
    FProc: TGetPropProc;
    procedure GetPropProc(const Prop: IProperty);
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  { TcxLookAndFeelAssignedValuesProperty }

  TcxLookAndFeelAssignedValuesProperty = class(TSetProperty)
  protected
    FProc: TGetPropProc;
    procedure GetPropProc(const Prop: IProperty);
  public
    procedure GetProperties(Proc: TGetPropProc); override;
  end;

  { TcxImageCollectionComponentEditor }

  TcxImageCollectionComponentEditor = class(TcxLibraryComponentEditor)
  protected
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  end;

procedure dxSkinsRequiresAdditionalUnits(AControlClass: TClass; AProc: TGetStrProc);
begin
  if Assigned(FdxSkinsRequiresAdditionalUnits) then
    FdxSkinsRequiresAdditionalUnits(AControlClass, AProc);
end;

{ TcxLibraryComponentEditor }

function TcxLibraryComponentEditor.GetProductMajorVersion: string;
begin
  Result := cxLibraryMajorVersion;
end;

function TcxLibraryComponentEditor.GetProductName: string;
begin
  Result := dxLibraryProductName;
end;

{ TcxLookAndFeelControllerEditor }

procedure TcxLookAndFeelControllerEditor.Edit;
begin
end;

function TcxLookAndFeelControllerEditor.InternalGetVerb(AIndex: Integer): string;
begin
  if AIndex = 0 then
    Result := 'Reset';
end;

function TcxLookAndFeelControllerEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TcxLookAndFeelControllerEditor.InternalExecuteVerb(AIndex: Integer);
begin
  case AIndex of
    0:
      begin
        GetLookAndFeelController.Reset;
        Designer.Modified;
      end;
  end;
end;

function TcxLookAndFeelControllerEditor.GetLookAndFeelController: TcxLookAndFeelController;
begin
  Result := Component as TcxLookAndFeelController;
end;

{ TcxStyleRepositoryComponentEditor }

function TcxStyleRepositoryComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  if AIndex = 0 then
    Result := 'Edit...'
end;

function TcxStyleRepositoryComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TcxStyleRepositoryComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  if AIndex = 0 then
    ShowStyleRepositoryEditor(Designer, GetStyleRepository);
end;

function TcxStyleRepositoryComponentEditor.GetStyleRepository: TcxStyleRepository;
begin
  Result := Component as TcxStyleRepository;
end;

{ TcxStyleSheetComponentProperty }

type
  TcxStyleSheetComponentProperty = class(TComponentProperty)
  private
    FStrProc: TGetStrProc;
    procedure StrProc(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TcxStyleSheetComponentProperty.StrProc(const S: string);
begin
  if TcxStyles(GetComponent(0)).IsValidStyleSheet(TcxCustomStyleSheet(Designer.GetComponent(S))) then
    FStrProc(S);
end;

procedure TcxStyleSheetComponentProperty.GetValues(Proc: TGetStrProc);
begin
  FStrProc := Proc;
  Designer.GetComponentNames(GetTypeData(GetPropType), StrProc);
end;

{ TcxPropertiesStoreComponentEditor }

function TcxPropertiesStoreComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  case AIndex of
    0: Result := 'Edit...';
    1: Result := '-';
    2: Result := 'Store';
    3: Result := 'Restore';
  end;
end;

function TcxPropertiesStoreComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 4;
end;

procedure TcxPropertiesStoreComponentEditor.InternalExecuteVerb(AIndex: Integer);

  procedure DsgnStoreTo;
  var
    AActive: Boolean;
  begin
    AActive := PropertiesStore.Active;
    PropertiesStore.Active := True;
    PropertiesStore.StoreTo;
    PropertiesStore.Active := AActive;
  end;

  procedure DsgnRestoreFrom;
  var
    AActive: Boolean;
  begin
    AActive := PropertiesStore.Active;
    PropertiesStore.Active := True;
    PropertiesStore.RestoreFrom;
    PropertiesStore.Active := AActive;
  end;

begin
  case AIndex of
    0: ShowPropertiesStoreEditor(PropertiesStore, Designer.Root, Designer);
    2: DsgnStoreTo;
    3: DsgnRestoreFrom;
  end;
end;

function TcxPropertiesStoreComponentEditor.GetPropertiesStore: TcxPropertiesStore;
begin
  Result := Component as TcxPropertiesStore;
end;

{ TcxImageListComponentEditor }

procedure TcxImageListComponentEditor.InternalExecuteVerb(AIndex: Integer);

  procedure Edit;
  begin
    if cxEditImageList(ImageList, FAssignableObjects) then
      Designer.Modified;
  end;

begin
  if (AIndex = 0) then
    Edit;
end;

function TcxImageListComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  if AIndex = 0 then
    Result := 'Edit...'
end;

function TcxImageListComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

function TcxImageListComponentEditor.IsAssignable: Boolean;
begin
  Result := True;
end;

procedure TcxImageListComponentEditor.DoAssign(AObject: TObject);
var
  AImages: TCustomImageList;
begin
  AImages := AObject as TCustomImageList;

  ImageList.Assign(AImages);
  if (AImages.ClassName = 'TPngImageList') and CheckGdiPlus then
  begin
    ImageList.Clear;
    PngImageListTocxImageList(AImages, ImageList);
  end;
  Designer.Modified;
end;

function TcxImageListComponentEditor.GetAssignTypeClass: TClass;
begin
  Result := TCustomImageList;
end;

function TcxImageListComponentEditor.GetImageList: TcxImageList;
begin
  Result := Component as TcxImageList;
end;

{ TcxLocalizerLocaleProperty }

function TcxLocalizerLocaleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paReadOnly] + [paValueList];
end;

function TcxLocalizerLocaleProperty.GetValue: string;
begin
  Result := Localizer.Language;
end;

procedure TcxLocalizerLocaleProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  with Localizer do
  begin
    Proc(ANoActiveLanguage);
    for I := 0 to Languages.Count - 1 do
      Proc(Languages[I].Name);
  end;
end;

procedure TcxLocalizerLocaleProperty.SetValue(const Value: string);
begin
  with Localizer do
  begin
    Language := Value;
    SetOrdValue(Locale);
  end;
end;

function TcxLocalizerLocaleProperty.GetLocalizer: TcxLocalizer;
begin
  Result := TcxLocalizer(GetComponent(0));
end;

{ TcxContainerStyleProperty }

procedure TcxContainerStyleProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxContainerStyleProperty.GetPropProc(const Prop: IProperty);
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    if not TcxContainer(GetComponent(I)).IsStylePropertyPublished(Prop.GetName, GetName <> 'Style') then
      Exit;
  FProc(Prop);
end;

{ TcxContainerStyleAssignedValuesProperty }

procedure TcxContainerStyleAssignedValuesProperty.GetProperties(Proc: TGetPropProc);
var
  AStyleValueList: TStringList;
  I, AValue: Integer;
begin
  AStyleValueList := TStringList.Create;
  try
    FillVisiblePropertiesList(AStyleValueList);
    for I := 0 to AStyleValueList.Count - 1 do
    begin
      AValue := TcxContainerStyleValue(AStyleValueList.Objects[I]);
      Proc(TcxContainerStyleAssignedValuesElementProperty.Create(Self, AValue));
    end;
  finally
    AStyleValueList.Free;
  end;
end;

function TcxContainerStyleAssignedValuesProperty.GetValue: string;
var
  AStyleValues: TcxContainerStyleValues;
  AStyleValueList: TStringList;
  I: Integer;
begin
  Integer(AStyleValues) := GetOrdValue;
  Result := '';
  AStyleValueList := TStringList.Create;
  try
    FillVisiblePropertiesList(AStyleValueList);
    for I := 0 to AStyleValueList.Count - 1 do
      if TcxContainerStyleValue(AStyleValueList.Objects[I]) in AStyleValues then
        Result := Result + AStyleValueList[I] + ',';
    Delete(Result, Length(Result), 1);
    Result := '[' + Result + ']';
  finally
    AStyleValueList.Free;
  end;
end;

procedure TcxContainerStyleAssignedValuesProperty.FillVisiblePropertiesList(
  AList: TStringList);

  procedure FillStyleValueList(AStyle: TcxContainerStyle;
    AStyleValueList: TStringList);
  var
    APropertyCount, AStyleValueIndex, I: Integer;
    APPropList: PPropList;
    AStyleValue: TcxContainerStyleValue;
  begin
    APropertyCount := GetPropList(PTypeInfo(AStyle.ClassInfo), [tkUnknown..tkDynArray], nil);
    if APropertyCount = 0 then Exit;
    GetMem(APPropList, APropertyCount * SizeOf(Pointer));
    try
      GetPropList(PTypeInfo(AStyle.ClassInfo), [tkUnknown..tkDynArray], APPropList);
      for I := 0 to APropertyCount - 1 do
      begin
        if not AStyle.GetStyleValue(dxShortStringToString(APPropList[I].Name), AStyleValue) then
          Continue;
        if (AStyle.Container = nil) and ((AStyle.State = csNormal) or AStyle.IsExtendedStylePropertyPublished(dxShortStringToString(APPropList[I].Name))) or
          (AStyle.Container <> nil) and AStyle.Container.IsStylePropertyPublished(dxShortStringToString(APPropList[I].Name), AStyle.State <> csNormal) then
        begin
          AStyleValueIndex := AStyleValueList.IndexOf(dxShortStringToString(APPropList[I].Name));
          if AStyleValueIndex = -1 then
            AStyleValueList.AddObject(dxShortStringToString(APPropList[I].Name), TObject(1))
          else
            AStyleValueList.Objects[AStyleValueIndex] :=
              TObject(Integer(AStyleValueList.Objects[AStyleValueIndex]) + 1);
        end;
      end;
    finally
      FreeMem(APPropList);
    end;
  end;

var
  AStyleValue: TcxContainerStyleValue;
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    FillStyleValueList(TcxContainerStyle(GetComponent(I)), AList);
  AList.Sort;

  for I := AList.Count - 1 downto 0 do
    if Integer(AList.Objects[I]) <> PropCount then
      AList.Delete(I)
    else
    begin
      TcxContainerStyle(GetComponent(0)).GetStyleValue(AList[I], AStyleValue);
      AList.Objects[I] := TObject(AStyleValue);
    end;
end;

{ TcxContainerStyleAssignedValuesElementProperty }

function TcxContainerStyleAssignedValuesElementProperty.GetName: string;
begin
  TcxContainerStyle(GetComponent(0)).GetStyleValueName(Element, Result);
end;

{ TcxDefaultEditor }

function TcxDefaultEditor.GetVerb(Index: Integer): string;
begin
  if Index < InternalGetVerbCount then
    Result := InternalGetVerb(Index)
  else
  begin
    Index := Index - InternalGetVerbCount;
    case Index of
      0: Result := '-';
      1: Result := GetProductName + ' ' + Format('%s.%s', [GetProductMajorVersion, GetProductMinorVersion]);
      2: Result := dxCompanyName;
      3: Result := dxCompanyURL;
    end;
  end;
end;

function TcxDefaultEditor.GetVerbCount: Integer;
begin
  Result := GetBaseVerbCount + InternalGetVerbCount;
end;

function TcxDefaultEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := '';
end;

function TcxDefaultEditor.GetProductMinorVersion: string;
begin
  Result := IntToStr(dxBuildNumber);
end;

function TcxDefaultEditor.InternalGetVerbCount: Integer;
begin
  Result := 0;
end;

function TcxDefaultEditor.GetBaseVerbCount: Integer;
begin
  Result := 4;
end;

{ TcxControlPopupMenuProperty }

procedure TcxControlPopupMenuProperty.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(CheckComponent);
end;

procedure TcxControlPopupMenuProperty.CheckComponent(const Value: string);
var
  AComponent: TComponent;
  AIcxPopupMenu: IcxPopupMenu;
begin
  AComponent := Designer.GetComponent(Value);
  if AComponent <> nil then
  begin
    if (AComponent is TPopupMenu) or
      Supports(AComponent, IcxPopupMenu, AIcxPopupMenu) then
      FProc(Value);
  end;
end;

{ TcxLookAndFeelProperty }

procedure TcxLookAndFeelProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxLookAndFeelProperty.GetPropProc(const Prop: IProperty);
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    if SameText(Prop.GetName, 'SkinName') and
      (not ClassSupportsSkinProc(GetComponent(0)) or (GetExtendedStylePainters.Count = 0)) then Exit;
  FProc(Prop);
end;

{ TcxLookAndFeelAssignedValuesProperty }

procedure TcxLookAndFeelAssignedValuesProperty.GetProperties(Proc: TGetPropProc);
begin
  FProc := Proc;
  inherited GetProperties(GetPropProc);
end;

procedure TcxLookAndFeelAssignedValuesProperty.GetPropProc(const Prop: IProperty);
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    if SameText(Prop.GetName, 'lfvSkinName') and
      (not ClassSupportsSkinProc(TcxLookAndFeel(GetComponent(0)).Owner) or
      (GetExtendedStylePainters.Count = 0)) then Exit;
  FProc(Prop);
end;

{ TcxImageCollectionComponentEditor }

function TcxImageCollectionComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  if AIndex = 0 then
    Result := 'Edit...'
  else
    Result := '';
end;

function TcxImageCollectionComponentEditor.InternalGetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TcxImageCollectionComponentEditor.InternalExecuteVerb(AIndex: Integer);
begin
  if AIndex = 0 then
    ShowFormEditorClass(Designer, Component, (Component as TcxImageCollection).Items,
      'Items', TfrmComponentCollectionEditor);
end;

{ TcxStyleProperty }

const
  sCreateNewStyleInRepositoryBegin = '<Create a new style in ';
  sCreateNewStyleInRepositoryEnd = '>';
  sCreateNewStyleInNewRepository = '<Create a new style in the new repository>';

  StylePreviewAreaWidth = 55;
  StylePreviewAreaOffset = 3;
  StyleTextOffset = 1;
  StylePreviewOffset = StyleTextOffset;
  StylePreviewBorderSize = 1;

type
  TcxStyleProperty = class(TComponentProperty,
    ICustomPropertyDrawing, ICustomPropertyListDrawing)
  private
    FStyleRepositories: TList;
    procedure GetStyleRepositoryNameProc(const S: string);
  protected
    // ICustomPropertyDrawing
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    // ICustomPropertyListDrawing
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean);

    function GetStyleRepositories: TList;
  public
    function AutoFill: Boolean; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

procedure TcxStyleProperty.GetStyleRepositoryNameProc(const S: string);
begin
  FStyleRepositories.Add(Designer.GetComponent(S));
end;

procedure TcxStyleProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

procedure TcxStyleProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  if GetVisualValue = '' then
    DefaultPropertyDrawValue(Self, ACanvas, ARect)
  else
    ListDrawValue(GetVisualValue, ACanvas, ARect, ASelected);
end;

procedure TcxStyleProperty.ListMeasureWidth(const Value: string; ACanvas: TCanvas;
  var AWidth: Integer);
var
  AStyle: TcxStyle;
begin
  AStyle := Designer.GetComponent(Value) as TcxStyle;
  if AStyle <> nil then
    Inc(AWidth, StylePreviewAreaWidth + StylePreviewAreaOffset);
end;

procedure TcxStyleProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas;
  var AHeight: Integer);
var
  AComponent: TComponent;
  AStyle: TcxStyle;
  APrevFont: TFont;

  function GetItemHeight: Integer;
  begin
    Result := ACanvas.TextHeight('Qq') +
      2 * (StylePreviewOffset + StylePreviewBorderSize + StyleTextOffset);
  end;

begin
  AComponent := Designer.GetComponent(Value);
  if AComponent = nil then
    Inc(AHeight)
  else
    if AComponent is TcxStyle then
    begin
      AStyle := TcxStyle(AComponent);
      AHeight := GetItemHeight;
      if svFont in AStyle.AssignedValues then
      begin
        APrevFont := TFont.Create;
        APrevFont.Assign(ACanvas.Font);
        ACanvas.Font := AStyle.Font;
        AHeight := Max(AHeight, GetItemHeight);
        ACanvas.Font := APrevFont;
        APrevFont.Free;
      end;
    end;
end;

procedure TcxStyleProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
const
  PreviewText = 'Text Text Text Text Text';
var
  AStyle: TcxStyle;
  APrevBkColor, APrevTextColor: COLORREF;
  APrevFont: TFont;

  procedure SaveCanvasParams;
  begin
    APrevBkColor := GetBkColor(ACanvas.Handle);
    APrevTextColor := GetTextColor(ACanvas.Handle);
    APrevFont := TFont.Create;
    APrevFont.Assign(ACanvas.Font);
  end;

  procedure RestoreCanvasParams;
  begin
    ACanvas.Font := APrevFont;
    APrevFont.Free;
    SetBkColor(ACanvas.Handle, APrevBkColor);
    SetTextColor(ACanvas.Handle, APrevTextColor);
  end;

  function GetStyleNameRect: TRect;
  begin
    Result := ARect;
    Inc(Result.Left, StylePreviewAreaWidth + StylePreviewAreaOffset + StyleTextOffset);
    Result.Top := (Result.Top + Result.Bottom - ACanvas.TextHeight(Value)) div 2;
  end;

  (*procedure DrawStyleAssignedValuesInfo;
  const
    StyleValuesText = 'BCFT';
  var
    AInfoItemWidth, I, ATextX, ATextY: Integer;
    AStyleValue: TcxStyleValue;
  begin //!!!
    //ACanvas.Font.Style := [fsBold];
    AInfoItemWidth := 0;
    for I := 1 to Length(StyleValuesText) do
      AInfoItemWidth := Max(AInfoItemWidth, ACanvas.TextWidth(StyleValuesText[I]));

    with GetStyleNameRect do
    begin
      ATextX := Left - 40; //!!!
      ATextY := Top;
    end;

    for AStyleValue := Low(TcxStyleValue) to High(TcxStyleValue) do
    begin
      if AStyleValue in AStyle.AssignedValues then
        //ACanvas.Font.Style := [fsBold]
        ACanvas.Font.Color := APrevFont.Color
      else
        ACanvas.Font.Color := clBtnFace;
        //ACanvas.Font.Style := [];
      ACanvas.TextOut(ATextX, ATextY, StyleValuesText[1 + Ord(AStyleValue)]);
      Inc(ATextX, AInfoItemWidth);
    end;

    //ACanvas.Font.Style := [];
  end;*)

  function GetPreviewBounds: TRect;
  begin
    Result := ARect;
    Result.Right := Result.Left + StylePreviewAreaWidth;
    InflateRect(Result, -StylePreviewOffset, -StylePreviewOffset);
  end;

  function GetPreviewClientBounds: TRect;
  begin
    Result := GetPreviewBounds;
    InflateRect(Result, -StylePreviewBorderSize, -StylePreviewBorderSize);
  end;

  procedure DrawPreviewBorder;

    function GetBorderColor: TColor;
    begin
      if AStyle.AssignedValues * [svBitmap, svColor] = [] then
        if ColorToRGB(ACanvas.Brush.Color) = ColorToRGB(clBtnFace) then
          Result := clBtnShadow
        else
          Result := clBtnFace
      else
        Result := clWindowText;
    end;

  begin
    ACanvas.Brush.Color := GetBorderColor;
    ACanvas.FrameRect(GetPreviewBounds);
  end;

  procedure DrawPreviewBackground;
  var
    R, ABitmapR: TRect;
    AcxCanvas: TcxCanvas;
  begin
    R := GetPreviewClientBounds;
    if svBitmap in AStyle.AssignedValues then
    begin
      ABitmapR := R;
      if svColor in AStyle.AssignedValues then
        ABitmapR.Right := (R.Left + R.Right) div 2;
      AcxCanvas := TcxCanvas.Create(ACanvas);
      AcxCanvas.FillRect(ABitmapR, AStyle.Bitmap);
      AcxCanvas.Free;
      R.Left := ABitmapR.Right;
    end;
    if svColor in AStyle.AssignedValues then
    begin
      ACanvas.Brush.Color := AStyle.Color;
      ACanvas.FillRect(R);
    end;
  end;

  procedure DrawPreviewText;
  var
    ATextR: TRect;

    function GetTextColor: TColor;
    begin
      if svTextColor in AStyle.AssignedValues then
        Result := AStyle.TextColor
      else
        {if svColor in AStyle.AssignedValues then
          Result := ColorToRGB(AStyle.Color) xor clWhite  //!!!
        else}
          Result := APrevFont.Color;
    end;

    function GetTextTopBound: Integer;
    begin
      Result := (ATextR.Top + ATextR.Bottom - ACanvas.TextHeight(PreviewText)) div 2;
    end;

  begin
    if AStyle.AssignedValues * [svFont, svTextColor] = [] then Exit;
    if svFont in AStyle.AssignedValues then
      ACanvas.Font := AStyle.Font;
    ACanvas.Font.Color := GetTextColor;
    ATextR := GetPreviewClientBounds;
    ACanvas.Brush.Style := bsClear;
    ACanvas.TextRect(ATextR, ATextR.Left + StyleTextOffset, GetTextTopBound, PreviewText);
    ACanvas.Brush.Style := bsSolid;
  end;

begin
  AStyle := Designer.GetComponent(Value) as TcxStyle;
  if AStyle = nil then
    DefaultPropertyListDrawValue(Value, ACanvas, ARect, ASelected)
  else
  begin
    SaveCanvasParams;  // for correct focus rect drawing and height measurement
    with GetStyleNameRect do
      ACanvas.TextRect(ARect, Left, Top, Value);
    //DrawStyleAssignedValuesInfo;
    DrawPreviewBorder;
    DrawPreviewBackground;
    DrawPreviewText;
    RestoreCanvasParams;
  end;
end;
  
function TcxStyleProperty.GetStyleRepositories: TList;
begin
  Result := TList.Create;
  FStyleRepositories := Result;
  Designer.GetComponentNames(GetTypeData(TcxStyleRepository.ClassInfo), GetStyleRepositoryNameProc);
end;

function TcxStyleProperty.AutoFill: Boolean;
begin
  Result := False;
end;

procedure TcxStyleProperty.GetValues(Proc: TGetStrProc);
var
  AStyleRepositories: TList;
  I: Integer;
  S: string;
begin
  AStyleRepositories := GetStyleRepositories;
  try
    for I := 0 to AStyleRepositories.Count - 1 do
    begin
      S := Designer.GetComponentName(TComponent(AStyleRepositories[I]));
      Proc(sCreateNewStyleInRepositoryBegin + S + sCreateNewStyleInRepositoryEnd);
    end;
  finally
    AStyleRepositories.Free;
  end;
  Proc(sCreateNewStyleInNewRepository);
  inherited;
end;

procedure TcxStyleProperty.SetValue(const Value: string);
var
  AName: string;
  AStyleRepository: TcxStyleRepository;

  procedure CreateAndAssignNewStyle(AStyleRepository: TcxStyleRepository);
  var
    AStyle: TcxStyle;

    function GetStyleDesigner: IDesigner;
    begin
      Result := FindRootDesigner(AStyle) as IDesigner;
      //FindRootDesigner(AStyle).QueryInterface(IDesigner, Result);
    end;

  begin
    AStyle := AStyleRepository.CreateItemEx(TcxStyle, AStyleRepository.Owner) as TcxStyle;
    AStyle.Name := CreateUniqueName(AStyle.Owner, nil, AStyle, '', '');
    if GetStyleDesigner <> Designer then
      FindRootDesigner(AStyle).Modified;
    SetOrdValue(Integer(AStyle));
  end;

begin
  if Value = sCreateNewStyleInNewRepository then
  begin
    AStyleRepository := TcxStyleRepository.Create(Designer.Root);
    AStyleRepository.Name := Designer.UniqueName(
      Copy(TcxStyleRepository.ClassName, 2, Length(TcxStyleRepository.ClassName) - 1));
    CreateAndAssignNewStyle(AStyleRepository);
  end
  else
    if Copy(Value, 1, Length(sCreateNewStyleInRepositoryBegin)) = sCreateNewStyleInRepositoryBegin then
    begin
      AName := Copy(Value, Length(sCreateNewStyleInRepositoryBegin) + 1,
        Length(Value) - (Length(sCreateNewStyleInRepositoryBegin) + Length(sCreateNewStyleInRepositoryEnd)));
      CreateAndAssignNewStyle(Designer.GetComponent(AName) as TcxStyleRepository);
    end
    else
      inherited;
end;

{ TcxBitmapGraphicProperty }

procedure TcxBitmapGraphicProperty.Edit;
var
  APictureEditor: TPictureEditor;
  APictureEditorDlg: TWinControl;
begin
  APictureEditor := TPictureEditor.Create(nil);
  try
    APictureEditor.GraphicClass := GraphicClass;
    APictureEditor.Picture.Graphic := TGraphic(Pointer(GetOrdValue));
    if BuildFilter <> '' then
    begin
      APictureEditorDlg := FindControl(FindWindow('TPictureEditorDlg', nil));
      if APictureEditorDlg is TPictureEditorDlg then
        TPictureEditorDlg(APictureEditorDlg).OnShow := OnShowPicEdit;
    end;
    if APictureEditor.Execute then
      SetGraphic(APictureEditor.Picture.Graphic);
  finally
    APictureEditor.Free;
  end;
end;

function TcxBitmapGraphicProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TcxBitmapGraphicProperty.GetGraphicClass: TGraphicClass;
begin
  Result := TGraphicClass(GetTypeData(GetPropType)^.ClassType);
end;

function TcxBitmapGraphicProperty.GetValue: string;
var
  Graphic: TGraphic;
begin
  Graphic := TGraphic(GetOrdValue);
  if (Graphic = nil) or Graphic.Empty then
    Result := 'None'
  else
    Result := '(' + Graphic.ClassName + ')';
end;

procedure TcxBitmapGraphicProperty.SetGraphic(AGraphic: TGraphic);
var
  ABitmap: TBitmap;
begin
  if (AGraphic = nil) or (AGraphic is GraphicClass) then
    SetOrdValue(LongInt(AGraphic))
  else
    if AGraphic is TdxPNGImage then
    begin
      ABitmap := TdxPNGImage(AGraphic).GetAsBitmap;
      try
        SetOrdValue(LongInt(ABitmap));
      finally
        ABitmap.Free;
      end;
    end
    else
    begin
      ABitmap := TcxBitmap32.CreateSize(AGraphic.Width, AGraphic.Height, True);
      try
        ABitmap.Canvas.Draw(0, 0, AGraphic);
        SetOrdValue(LongInt(ABitmap));
      finally
        ABitmap.Free;
      end;
    end
end;

procedure TcxBitmapGraphicProperty.SetValue(const Value: string);
begin
  if Value = '' then SetOrdValue(0);
end;

procedure TcxBitmapGraphicProperty.OnShowPicEdit(Sender: TObject);
begin
  if Sender is TPictureEditorDlg then
    TPictureEditorDlg(Sender).OpenDialog.Filter := BuildFilter;
end;

function TcxBitmapGraphicProperty.BuildFilter: string;
begin
  Result := '';
end;

{ TcxBitmapProperty }

function TcxBitmapProperty.BuildFilter: string;
const
  sdxBitmapAllFilter = 'All (*.bmp;*.png)|*.bmp;*.png;|';
  sdxBitmapPNGFilter = 'PNG Graphics (*.png)|*.png;|';
  sdxBitmapFilter = 'Bitmaps (*.bmp)|*.bmp;|';
begin
  if Pos('.png;', LowerCase(GraphicFileMask(TGraphic))) > 0 then
    Result := sdxBitmapAllFilter + sdxBitmapFilter + sdxBitmapPNGFilter
  else
    Result := sdxBitmapFilter;
end;

{ TcxFilenameProperty }

procedure TcxFilenameProperty.Edit;
var
  ADialog: TOpenDialog;
begin
  ADialog := TOpenDialog.Create(Application);
  ADialog.Filename := GetValue;
  ADialog.Filter := GetFilter;
  ADialog.Options := ADialog.Options + [ofPathMustExist, ofFileMustExist];
  try
    if ADialog.Execute then
      SetValue(ADialog.Filename);
  finally
    ADialog.Free;
  end;
end;

function TcxFilenameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;

function TcxFilenameProperty.GetFilter: string;
begin
  Result := 'All files (*.*)|*.*';
end;

{ TcxLocalizerFilenameProperty }

function TcxLocalizerFilenameProperty.GetFilter: string;
begin
  Result := 'INI Files|*.ini|' + inherited GetFilter;
end;

procedure HideClassProperties(AClass: TClass; APropertyNames: array of string);
var
  I: Integer;
begin
  for I := Low(APropertyNames) to High(APropertyNames) do
    RegisterPropertyEditor(GetPropInfo(AClass, APropertyNames[I]).PropType^,
      AClass, APropertyNames[I], nil);
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterComponents(dxLibraryProductPage, [TcxPropertiesStore, TcxImageList, TcxImageCollection]);
  RegisterComponents(dxLibraryProductPage, [TcxLookAndFeelController, TcxStyleRepository]);
{$IFDEF DELPHI7}
  RegisterComponents(dxLibraryProductPage, [TcxLocalizer]);
{$ENDIF}
  RegisterClasses([TcxStyle, TcxImageCollectionItem, TcxImageCollectionItems]);
  RegisterNoIcon([TcxStyle]);

  RegisterComponentEditor(TcxLookAndFeelController, TcxLookAndFeelControllerEditor);
  RegisterComponentEditor(TcxStyleRepository, TcxStyleRepositoryComponentEditor);
  RegisterComponentEditor(TcxImageList, TcxImageListComponentEditor);
  RegisterComponentEditor(TcxPropertiesStore, TcxPropertiesStoreComponentEditor);
  RegisterComponentEditor(TcxImageCollection, TcxImageCollectionComponentEditor);
  RegisterNoIcon([TcxImageCollectionItem]);
{$IFDEF DELPHI7}
  RegisterComponentEditor(TcxLocalizer, TcxLibraryComponentEditor);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(TcxCustomStyleSheet), TcxStyles, 'StyleSheet', TcxStyleSheetComponentProperty);
  RegisterPropertyEditor(TypeInfo(TBitmap), nil, '', TcxBitmapGraphicProperty);
  RegisterPropertyEditor(TypeInfo(TcxStyleController), TcxStyleController, 'FakeStyleController', nil);
  RegisterPropertyEditor(TypeInfo(TcxStyleController), TcxContainer, 'FakeStyleController', nil);
  RegisterPropertyEditor(TypeInfo(TcxContainerStyle), TcxContainer, '', TcxContainerStyleProperty);
  RegisterPropertyEditor(TypeInfo(TcxContainerStyle), TcxStyleController, '', TcxStyleControllerStyleProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TcxControl, 'PopupMenu', TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(TcxStyle), nil, '', TcxStyleProperty);
  RegisterPropertyEditor(TypeInfo(TcxLookAndFeel), nil, '', TcxLookAndFeelProperty);
  RegisterPropertyEditor(TypeInfo(TdxSkinName), nil, 'SkinName', nil);
  RegisterPropertyEditor(TypeInfo(TcxContainerStyleValues), TcxContainerStyle,
    'AssignedValues', TcxContainerStyleAssignedValuesProperty);
  RegisterPropertyEditor(TypeInfo(TcxLookAndFeelValues), TcxLookAndFeel,
    'AssignedValues', TcxLookAndFeelAssignedValuesProperty);
{$IFDEF DELPHI7}
  RegisterPropertyEditor(TypeInfo(Cardinal), TcxLocalizer, 'Locale', TcxLocalizerLocaleProperty);
  RegisterPropertyEditor(TypeInfo(TFileName), TcxLocalizer, 'FileName', TcxLocalizerFilenameProperty);
{$ENDIF}
end;

initialization
  StartClassGroup(TControl);
  GroupDescendentsWith(TcxCustomPropertiesStore, TControl);
end.
