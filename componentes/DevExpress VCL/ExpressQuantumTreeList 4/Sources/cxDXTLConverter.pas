{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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
unit cxDXTLConverter;

{$I cxVer.inc}

interface

uses
  SysUtils, cxConverterFactory, cxTLConverter, cxTL, cxDBTL, Classes,
  cxConverterUtils, cxLookAndFeels, cxInplaceContainer, DB, cxStyles,
  Graphics, cxCustomData, cxCustomConverter, cxBlobEdit, cxPropertiesConverters,
  cxButtonEdit, cxCalc, cxCheckBox, cxDropDownEdit, cxCurrencyEdit, cxCalendar,
  cxDBLookupComboBox, cxHyperLinkEdit, cxImage, cxImageComboBox, cxMaskEdit, cxMemo,
  cxMRUEdit, cxSpinEdit, cxTextEdit, cxTimeEdit, cxVariants;

type
  TcxCustomTreeListControlAccessor = class(TcxCustomTreeListControl);
  
  { TcxDXCustomTLConverter }
  TcxDXCustomTLConverter = class(TcxCustomTLConverter)
  private
    FContentColor: Integer;
    FContentFont: TFont;
    FcxColumnCache: TStringList;
    function GetAccessor: TcxCustomTreeListControlAccessor;
    procedure GetColumns(AColumns: TList);
    function GetCxColumnByDxName(AName: string): TcxTreeListColumn;
    procedure ImportTreeList;
  protected
    procedure AssignColumn(AcxColumn: TcxTreeListColumn; AdxColumn: TObject; AIndex: Integer); virtual;
    procedure AssignTreeList; virtual;
    procedure AssignTreeListOptions; virtual;
    function ConvertColumnShowEditButtons(const AValue: string): TcxEditItemShowEditButtons;
    function ConvertFixedKind(const AValue: string): TcxTreeListBandFixedKind;
    function ConvertGridLines(const AValue: Boolean): TcxTreeListGridLines;
    function ConvertLookAndFeelKind(const AValue: string): TcxLookAndFeelKind;
    function ConvertPaintStyle(const AValue: string): TcxTreeListPaintStyle;
    function ConvertShowEditButtons(const AValue: Boolean): TcxEditingControlEditShowButtons;
    function ConvertTreeLineStyle(const AShowLines: Boolean; const AValue: string): TcxTreeListTreeLineStyle;
    function ConvertColumnSortOrder(const AValue: string): TcxDataSortOrder;
    function CreateColumn: TcxTreeListColumn; virtual;
    procedure DoImportStyles; override;
    procedure DoRealImport; override;
    procedure ImportBands;
    procedure ImportBandsWidth;
    procedure ImportColumn(AdxColumn: TObject; AcxColumn: TcxTreeListColumn); virtual;
    procedure ImportColumns;
    procedure ImportColumnsStyles;
    procedure ImportColumnsWidth;
    procedure ImportData; virtual;
    procedure ImportPreview; virtual;
    procedure ImportPropertiesBlobEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesButtonEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesCalcEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesCheckBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesCurencyEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesDateEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesExLookupComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesHyperLinkEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesImage(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesImageComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesLookupComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesMaskEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesMemo(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesMRUEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesPopupEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesSpinEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesTextEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportPropertiesTimeEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
    procedure ImportTreeListStyles;
    property Accessor: TcxCustomTreeListControlAccessor read GetAccessor;
  public
    constructor Create(ADestination: TObject); override;
    destructor Destroy; override;
  end;

  { TcxDXTLConverter }
  TcxDXTLConverter = class(TcxDXCustomTLConverter)
  private
    procedure AssignDXOptions;
    procedure AssignDXOptionsEx;
    function GetDestination: TcxTreeList;
  protected
    procedure AssignTreeList; override;
    procedure AssignTreeListOptions; override;
    function CreateColumn: TcxTreeListColumn; override;
    procedure ImportColumn(AdxColumn: TObject; AcxColumn: TcxTreeListColumn); override;
    procedure ImportData; override;
  public
    class function GetSourceClassName: string; override;
    property Destination: TcxTreeList read GetDestination;
  end;

  { TcxDXDBTLConverter }
  TcxDXDBTLConverter = class(TcxDXCustomTLConverter)
  private
    procedure AssignDXOptionsBehavior;
    procedure AssignDXOptionsCustomize;
    procedure AssignDXOptionsDB;
    procedure AssignDXOptionsView;
    function ConvertFooterKind(AValue: string): TcxSummaryKind;
    function GetDestination: TcxDBTreeList;
    procedure ImportColumnSummary(AcxColumn: TcxTreeListColumn; AdxColumn: TObject);
    function TestColumnFieldName(AFieldName: string; AIndex: Integer): Boolean;
  protected
    procedure AssignColumn(AcxColumn: TcxTreeListColumn; AdxColumn: TObject; AIndex: Integer); override;
    procedure AssignTreeListOptions; override;
    function CreateColumn: TcxTreeListColumn; override;
    procedure DoImportStyles; override;
    procedure DoRealImport; override;
    procedure ImportColumn(AdxColumn: TObject; AcxColumn: TcxTreeListColumn); override;
    procedure ImportPreview; override;
  public
    class function GetSourceClassName: string; override;
    property Destination: TcxDBTreeList read GetDestination;
  end;

implementation

uses
  Controls, cxControls;

{ TcxDXCustomTLConverter }

constructor TcxDXCustomTLConverter.Create(ADestination: TObject);
begin
  inherited Create(ADestination);
  FcxColumnCache := TStringList.Create;
  FcxColumnCache.Sorted := True;
end;

destructor TcxDXCustomTLConverter.Destroy;
begin
  FcxColumnCache.Free;
  inherited Destroy;
end;

procedure TcxDXCustomTLConverter.AssignColumn(AcxColumn: TcxTreeListColumn; AdxColumn: TObject; AIndex: Integer);
begin
  SetTLColumnUniqueName(Destination, AcxColumn);
  with AcxColumn do
  begin
    Caption.AlignHorz := ConvertAlignment(GetEnumProperty(AdxColumn, 'HeaderAlignment'));
    Caption.Text := GetStringProperty(AdxColumn, 'Caption');
//    MinWidth := GetIntegerProperty(AdxColumn, 'MinWidth');
    Options.Customizing := not GetBooleanProperty(AdxColumn, 'DisableCustomizing');
    Options.Editing := not GetBooleanProperty(AdxColumn, 'DisableEditor');
    Options.Moving := not GetBooleanProperty(AdxColumn, 'DisableDragging');
    Options.Sizing := GetBooleanProperty(AdxColumn, 'Sizing');
    Options.TabStop := GetBooleanProperty(AdxColumn, 'TabStop');
    SortOrder := ConvertColumnSortOrder(GetEnumProperty(AdxColumn, 'Sorted'));
    Position.BandIndex := GetIntegerProperty(AdxColumn, 'BandIndex');
    Position.ColIndex := GetIntegerProperty(AdxColumn, 'ColIndex');
    Position.RowIndex := GetIntegerProperty(AdxColumn, 'RowIndex');
    Tag := GetIntegerProperty(AdxColumn, 'Tag');
    Visible := GetBooleanProperty(AdxColumn, 'Visible');
//    Width := GetIntegerProperty(AdxColumn, 'Width');
  end;
end;

procedure TcxDXCustomTLConverter.AssignTreeList;
begin
  with Accessor do
  begin
    DefaultLayout := GetBooleanProperty(nil, 'DefaultLayout');
    Enabled := GetBooleanProperty(nil, 'Enabled');
    LookAndFeel.Kind := ConvertLookAndFeelKind(GetEnumProperty(nil, 'LookAndFeel'));
    ParentColor := GetBooleanProperty(nil, 'ParentColor');
    ParentFont := GetBooleanProperty(nil, 'ParentFont');
    Tag := GetIntegerProperty(nil, 'Tag');
    OptionsBehavior.ExpandOnIncSearch := GetBooleanProperty(nil, 'AutoExpandOnSearch');
    OptionsView.BandLineCount := GetIntegerProperty(nil, 'BandRowCount');
    OptionsView.FixedSeparatorWidth := GetIntegerProperty(nil, 'FixedBandLineWidth');
    OptionsSelection.HideFocusRect := GetBooleanProperty(nil, 'HideFocusRect');
    OptionsSelection.HideSelection := GetBooleanProperty(nil, 'HideSelection');
    OptionsView.PaintStyle := ConvertPaintStyle(GetEnumProperty(nil, 'PaintStyle'));
    Preview.MaxLineCount := GetIntegerProperty(nil, 'PreviewLines');
    OptionsView.ScrollBars := ConvertScrollStyle(GetEnumProperty(nil, 'ScrollBars'));
    OptionsView.GridLines := ConvertGridLines(GetBooleanProperty(nil, 'ShowGrid'));
    OptionsView.Bands := GetBooleanProperty(nil, 'ShowBands');
    OptionsView.Buttons := GetBooleanProperty(nil, 'ShowButtons');
    OptionsView.Footer := GetBooleanProperty(nil, 'ShowFooter');
    OptionsView.Headers := GetBooleanProperty(nil, 'ShowHeader');
    OptionsView.ShowRoot := GetBooleanProperty(nil, 'ShowRoot');
    OptionsView.SimpleCustomizeBox := GetBooleanProperty(nil, 'SimpleCustomizeBox');
    OptionsView.TreeLineStyle := ConvertTreeLineStyle(GetBooleanProperty(nil, 'ShowLines'),
      GetEnumProperty(nil, 'TreeLineStyle'));
    OptionsBehavior.WaitForExpandNodeTime := GetIntegerProperty(nil,  'WaitForExpandNodeTime');
    OptionsBehavior.CellHints := GetBooleanProperty(nil, 'ShowHint');
    OptionsView.CellTextMaxLineCount := GetIntegerProperty(nil, 'MaxRowLineCount');
  end;
end;

procedure TcxDXCustomTLConverter.AssignTreeListOptions;
begin
end;

function TcxDXCustomTLConverter.ConvertColumnShowEditButtons(const AValue: string): TcxEditItemShowEditButtons;
begin
  if AValue = 'sbAlways' then
    Result := eisbAlways
  else if AValue = 'sbDefault' then
    Result := eisbDefault
  else
    Result := eisbNever; 
end;

function TcxDXCustomTLConverter.ConvertFixedKind(const AValue: string): TcxTreeListBandFixedKind;
begin
  if AValue = 'bfLeft' then
    Result := tlbfLeft
  else if AValue = 'bfRight' then
    Result := tlbfRight
  else
    Result := tlbfNone;
end;

function TcxDXCustomTLConverter.ConvertGridLines(const AValue: Boolean): TcxTreeListGridLines;
begin
  if AValue then
    Result := tlglBoth
  else
    Result := tlglNone;
end;

function TcxDXCustomTLConverter.ConvertLookAndFeelKind(const AValue: string): TcxLookAndFeelKind;
begin
  if AValue = 'lfFlat' then
    Result := lfFlat
  else if AValue = 'lfUltraFlat' then
    Result := lfUltraFlat
  else
    Result := lfStandard;
end;

function TcxDXCustomTLConverter.ConvertPaintStyle(const AValue: string): TcxTreeListPaintStyle;
begin
  if AValue = 'psOutlook' then
    Result := tlpsCategorized
  else
    Result := tlpsStandard;
end;

function TcxDXCustomTLConverter.ConvertShowEditButtons(const AValue: Boolean): TcxEditingControlEditShowButtons;
begin
  if AValue then
    Result := ecsbAlways
  else
    Result := ecsbFocused; 
end;

function TcxDXCustomTLConverter.ConvertTreeLineStyle(const AShowLines: Boolean;
    const AValue: string): TcxTreeListTreeLineStyle;
begin
  if AShowLines then
  begin
    if AValue = 'tlDot' then
      Result := tllsDot
    else
      Result := tllsSolid;
  end
  else
    Result := tllsNone;
end;

function TcxDXCustomTLConverter.ConvertColumnSortOrder(const AValue: string): TcxDataSortOrder;
begin
  if AValue = 'csDown' then
    Result := soDescending
  else if AValue = 'csUp' then
    Result := soAscending
  else 
    Result := soNone;
end;

function TcxDXCustomTLConverter.CreateColumn: TcxTreeListColumn;
begin
  Result := Destination.CreateColumn;
end;

procedure TcxDXCustomTLConverter.DoImportStyles;
begin
  ImportTreeListStyles;
  ImportColumnsStyles;
end;

procedure TcxDXCustomTLConverter.DoRealImport;

  function IsBandHeaderWidth: Boolean;
  var
    AList: TStringList;
  begin
    AList := TStringList.Create;
    try
      GetSetProperty(nil, 'OptionsEx', AList);
      Result :=
        GetBooleanProperty(nil, 'DefaultLayout') or
        (AList.IndexOf('aoBandHeaderWidth') <> -1) or
        GetBooleanProperty(nil, 'ShowBands');
    finally
      AList.Free;
    end;
  end;

begin
  ImportBands;
  ImportColumns;
  ImportColumnsWidth;
  ImportPreview;
  ImportTreeList;
  if IsBandHeaderWidth and False then
    ImportBandsWidth;
  ImportData; 
end;

procedure TcxDXCustomTLConverter.ImportBands;
var
  ABands: TObject;
  AcxBand: TcxTreeListBand;
  I: Integer;
begin
  ABands := GetClassProperty(nil, 'Bands');
  if ABands <> nil then
  begin
    if ABands is TCollection then
    with TCollection(ABands) do
    begin
      for I := 0 to Count - 1 do
      begin
        AcxBand := Accessor.Bands.Add;
        AcxBand.Caption.Text := GetStringProperty(Items[I], 'Caption');
        AcxBand.Caption.AlignHorz := ConvertAlignment(GetEnumProperty(Items[I], 'Alignment'));
        AcxBand.Visible := GetBooleanProperty(Items[I], 'Visible');
        AcxBand.FixedKind := ConvertFixedKind(GetEnumProperty(Items[I], 'Fixed'));
        AcxBand.Options.Customizing := not GetBooleanProperty(Items[I], 'DisableCustomizing');
        AcxBand.Options.Moving := not GetBooleanProperty(Items[I], 'DisableDragging');
        AcxBand.Options.OnlyOwnColumns := GetBooleanProperty(Items[I], 'OnlyOwnColumns');
        AcxBand.Options.Sizing := GetBooleanProperty(Items[I], 'Sizing');
      end;
    end;
  end;
end;

procedure TcxDXCustomTLConverter.ImportBandsWidth;
var
  ABands: TCollection;
  I: Integer;
begin
  ABands := TCollection(GetClassProperty(nil, 'Bands'));
  if not (ABands is TCollection) then Exit;
  for I := 0 to ABands.Count - 1 do
  begin
    with Accessor.Bands[I] do
    begin
      MinWidth := GetIntegerProperty(ABands.Items[I], 'MinWidth');
      Width := GetIntegerProperty(ABands.Items[I], 'Width');
    end;
  end;
end;

procedure TcxDXCustomTLConverter.ImportColumn(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
begin
end;

procedure TcxDXCustomTLConverter.ImportColumns;
var
  AColumns: TList;
  AcxColumn: TcxTreeListColumn;
  I: Integer;
begin
  AColumns := TList.Create;
  try
    GetColumns(AColumns);
    for I := 0 to AColumns.Count - 1 do
    begin
      AcxColumn := CreateColumn;
      FcxColumnCache.AddObject(GetStringProperty(TObject(AColumns[I]), 'Name'), AcxColumn);
      AssignColumn(AcxColumn, TObject(AColumns[I]), I);
      ImportColumn(TObject(AColumns[I]), AcxColumn);
    end;
  finally
    AColumns.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportColumnsStyles;
var
  AColumns: TList;
  AcxColumn: TcxTreeListColumn;
  I: Integer;
  AColor: Integer;
  AFont: TFont;
  AStyle: TcxCustomStyle;
begin
  AColumns := TList.Create;
  try
    GetColumns(AColumns);
    for I := 0 to AColumns.Count - 1 do
    begin
      AcxColumn := GetCxColumnByDxName(GetStringProperty(TObject(AColumns[I]), 'Name'));
      if AcxColumn <> nil then
      begin
        AColor := GetIntegerProperty(TObject(AColumns[I]), 'Color');
        AFont := GetClassProperty(TObject(AColumns[I]), 'Font') as TFont;
        if (AColor <> FContentColor) or not CompareFonts(AFont, FContentFont) then
        begin
          AStyle := CreateStyleItem;
          (AStyle as TcxStyle).Color := AColor;
          (AStyle as TcxStyle).Font.Assign(AFont);
          (AStyle as TcxStyle).TextColor := (AStyle as TcxStyle).Font.Color;
          AcxColumn.Styles.Content := AStyle as TcxStyle;
        end;
      end;
    end;
  finally
    AColumns.Free
  end;
end;

procedure TcxDXCustomTLConverter.ImportColumnsWidth;
var
  AColumns: TList;
  AcxColumn: TcxTreeListColumn;
  I: Integer;
begin
  AColumns := TList.Create;
  try
    GetColumns(AColumns);
    for I := 0 to AColumns.Count - 1 do
    begin
      AcxColumn := GetCxColumnByDxName(GetStringProperty(TObject(AColumns[I]), 'Name'));
      if AcxColumn <> nil then
      begin
        AcxColumn.Width := GetIntegerProperty(TObject(AColumns[I]), 'Width');
        AcxColumn.MinWidth := GetIntegerProperty(TObject(AColumns[I]), 'MinWidth');
      end;
    end;
  finally
    AColumns.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportData;
begin
end;

procedure TcxDXCustomTLConverter.ImportPreview;
begin
end;

procedure TcxDXCustomTLConverter.ImportPropertiesBlobEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxBlobEditProperties;
  AConverter := TcxBlobEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesButtonEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxButtonEditProperties;
  AConverter := TcxButtonEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesCalcEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxCalcEditProperties;
  AConverter := TcxCalcEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesCheckBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxCheckBoxProperties;
  AConverter := TcxCheckBoxPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxComboBoxProperties;
  AConverter := TcxComboBoxPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesCurencyEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxCurrencyEditProperties;
  AConverter := TcxCurrencyEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesDateEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxDateEditProperties;
  AConverter := TcxDateEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesExLookupComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
begin
end;

procedure TcxDXCustomTLConverter.ImportPropertiesHyperLinkEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxHyperLinkEditProperties;
  AConverter := TcxHyperLinkEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesImage(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxImageProperties;
  AConverter := TcxImagePropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesImageComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxImageComboBoxProperties;
  AConverter := TcxImageComboBoxPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesLookupComboBox(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxLookupComboBoxProperties;
  AConverter := TcxLookupComboBoxPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesMaskEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxMaskEditProperties;
  AConverter := TcxMaskEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesMemo(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxMemoProperties;
  AConverter := TcxMemoPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesMRUEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxMRUEditProperties;
  AConverter := TcxMRUEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesPopupEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxPopupEditProperties;
  AConverter := TcxPopupEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesSpinEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxSpinEditProperties;
  AConverter := TcxSpinEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
    AcxColumn.Options.ShowEditButtons := ConvertColumnShowEditButtons(
      GetEnumProperty(AdxColumn, 'ShowButtonStyle'));
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesTextEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxTextEditProperties;
  AConverter := TcxTextEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportPropertiesTimeEdit(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
var
  AConverter: TcxCustomPropertiesConverter;
begin
  AcxColumn.PropertiesClass := TcxTimeEditProperties;
  AConverter := TcxTimeEditPropertiesConverter.Create(AcxColumn.Properties);
  try
    AConverter.ImportFrom(AdxColumn);
  finally
    AConverter.Free;
  end;
end;

procedure TcxDXCustomTLConverter.ImportTreeListStyles;
var
  AStyle: TcxCustomStyle;
  AFont: TFont;
  AColor: Integer;
  AColor1: Integer;
begin
  FContentColor := GetIntegerProperty(nil, 'Color');
  FContentFont := GetClassProperty(nil, 'Font') as TFont;
  if (FContentColor <> clWindow) or not DefaultFont(FContentFont) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := FContentColor;
    (AStyle as TcxStyle).Font.Assign(FContentFont);
    (AStyle as TcxStyle).TextColor := (AStyle as TcxStyle).Font.Color;
    Accessor.Styles.Content := AStyle as TcxStyle;
    Accessor.Styles.Background := AStyle as TcxStyle;
  end;
  AColor := GetIntegerProperty(nil, 'BandColor');
  AFont := GetClassProperty(nil, 'BandFont') as TFont;
  if (AColor <> clBtnFace) or not DefaultFont(AFont) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := AColor;
    (AStyle as TcxStyle).Font.Assign(AFont);
    (AStyle as TcxStyle).TextColor := (AStyle as TcxStyle).Font.Color;
    Accessor.Styles.BandHeader := AStyle as TcxStyle;
  end;
  AColor := GetIntegerProperty(nil, 'HeaderColor');
  AFont := GetClassProperty(nil, 'HeaderFont') as TFont;
  if (AColor <> clBtnFace) or not DefaultFont(AFont) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := AColor;
    (AStyle as TcxStyle).Font.Assign(AFont);
    (AStyle as TcxStyle).TextColor := (AStyle as TcxStyle).Font.Color;
    Accessor.Styles.ColumnHeader := AStyle as TcxStyle;
    Accessor.Styles.Indicator := AStyle as TcxStyle;
  end;
  AColor := GetIntegerProperty(nil, 'HighlightColor');
  AColor1 := GetIntegerProperty(nil, 'HighlightTextColor');
  if (AColor <> clHighlight) or (AColor1 <> clHighlightText) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := AColor;
    (AStyle as TcxStyle).TextColor := AColor1;
    Accessor.Styles.Selection := AStyle as TcxStyle;
  end;
  AColor := GetIntegerProperty(nil, 'ArrowsColor');
  if AColor <> clLime then
    Accessor.OptionsView.DropArrowColor := AColor;
  AColor := GetIntegerProperty(nil, 'FixedBandLineColor');
  if AColor <> clWindowFrame then
    Accessor.OptionsView.FixedSeparatorColor := AColor;
  AColor := GetIntegerProperty(nil, 'GridLineColor');
  if AColor <> clNone then
    Accessor.OptionsView.GridLineColor := AColor;
  AColor := GetIntegerProperty(nil, 'TreeLineColor');
  if AColor <> clGrayText then
    Accessor.OptionsView.TreeLineColor := AColor;
  AFont := GetClassProperty(nil, 'PreviewFont') as TFont;
  if not DefaultFont(AFont) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Font.Assign(AFont);
    (AStyle as TcxStyle).TextColor := (AStyle as TcxStyle).Font.Color;
    Accessor.Styles.Preview := AStyle as TcxStyle;
  end;
  AColor := GetIntegerProperty(nil, 'AutoSearchColor');
  AColor1 := GetIntegerProperty(nil, 'AutoSearchTextColor');
  if (AColor <> clNone) or (AColor1 <> clNone) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := AColor;
    (AStyle as TcxStyle).TextColor := AColor1;
    Accessor.Styles.IncSearch := AStyle as TcxStyle;
  end;
  AColor := GetIntegerProperty(nil, 'HideSelectionColor');
  AColor1 := GetIntegerProperty(nil, 'HideSelectionTextColor');
 if (AColor <> clBtnFace) or (AColor1 <> clBtnText) then
 begin
   AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := AColor;
    (AStyle as TcxStyle).TextColor := AColor1;
    Accessor.Styles.Inactive := AStyle as TcxStyle;
 end;
end;

function TcxDXCustomTLConverter.GetAccessor: TcxCustomTreeListControlAccessor;
begin
  Result := TcxCustomTreeListControlAccessor(Destination);
end;

procedure TcxDXCustomTLConverter.GetColumns(AColumns: TList);
var
  AForm: TComponent;
  I: Integer;
begin
  if Source is TComponent then
  begin
    AForm := TComponent(Source).Owner;
    for I := 0 to AForm.ComponentCount - 1 do
    begin
      if AForm.Components[I].GetParentComponent = Source then
        AColumns.Add(AForm.Components[I]);
    end;
    if AColumns.Count = 0 then
    begin
      for I := 0 to TComponent(Source).ComponentCount - 1 do
      begin
        if TComponent(Source).Components[I].GetParentComponent = Source then
          AColumns.Add(TComponent(Source).Components[I]);
      end;
    end;
  end;
end;

function TcxDXCustomTLConverter.GetCxColumnByDxName(AName: string): TcxTreeListColumn;
var
  I: Integer;
begin
  Result := nil;
  FcxColumnCache.Find(AName, I);
  if I >= 0 then
    Result := FcxColumnCache.Objects[I] as TcxTreeListColumn;
end;

procedure TcxDXCustomTLConverter.ImportTreeList;
begin
  AssignTreeList;
  AssignTreeListOptions;
end;

{ TcxDXTLConverter }

class function TcxDXTLConverter.GetSourceClassName: string;
begin
  Result := 'TdxTreeList';
end;

procedure TcxDXTLConverter.AssignTreeList;
begin
  inherited AssignTreeList;
  with Destination do
    OptionsView.Indicator := GetBooleanProperty(nil, 'ShowIndicator');
end;

procedure TcxDXTLConverter.AssignTreeListOptions;
begin
  AssignDXOptions;
  AssignDXOptionsEx;
end;

function TcxDXTLConverter.CreateColumn: TcxTreeListColumn;
begin
  Result := Destination.CreateColumn;
end;

procedure TcxDXTLConverter.ImportColumn(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
begin
  if AdxColumn.ClassName = 'TdxTreeListColumn' then
    ImportPropertiesTextEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListMaskColumn' then
    ImportPropertiesMaskEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListButtonColumn' then
    ImportPropertiesButtonEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListDateColumn' then
    ImportPropertiesDateEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListCheckColumn' then
    ImportPropertiesCheckBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListImageColumn' then
    ImportPropertiesImageComboBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListSpinColumn' then
    ImportPropertiesSpinEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListLookupColumn' then
    ImportPropertiesLookupComboBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListPickColumn' then
    ImportPropertiesComboBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListCalcColumn' then
    ImportPropertiesCalcEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListBlobColumn' then
    ImportPropertiesBlobEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListHyperLinkColumn' then
    ImportPropertiesHyperLinkEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListTimeColumn' then
    ImportPropertiesTimeEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListCurrencyColumn' then
    ImportPropertiesCurencyEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListMemoColumn' then
    ImportPropertiesMemo(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListGraphicColumn' then
    ImportPropertiesImage(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListMRUColumn' then
    ImportPropertiesMRUEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListPopupColumn' then
    ImportPropertiesPopupEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxTreeListExtLookupColumn' then
    ImportPropertiesExLookupComboBox(AdxColumn, AcxColumn);
end;

type
  TComponentAccess = class(TComponent);

  TcxConverterFiler = class(TFiler)
  private
    FHasData: Boolean;
    FReadDataProc: TStreamProc;
    FWriteDataProc: TStreamProc;
  public
    constructor CreateFor(AComponent: TObject);
    procedure CreateTreeListNodes(AStream: TStream; ADest: TcxTreeList);
    procedure DefineProperty(const Name: string; ReadData: TReaderProc;
      WriteData: TWriterProc; HasData: Boolean); override;
    procedure DefineBinaryProperty(const Name: string; AReadData, AWriteData: TStreamProc; HasData: Boolean); override;
    procedure FlushBuffer; override;
    property HasData: Boolean read FHasData;
    property ReadDataProc: TStreamProc read FReadDataProc;
    property WriteDataProc: TStreamProc read FWriteDataProc;
  end;

constructor TcxConverterFiler.CreateFor(AComponent: TObject);
begin
  TComponentAccess(AComponent).DefineProperties(Self);
end;

procedure TcxConverterFiler.CreateTreeListNodes(AStream: TStream; ADest: TcxTreeList);
var
  AReader: TcxReader;

  procedure ConvertNodesData(AParent: TcxTreeListNode; AChildCount: Integer);
  var
    S: string;
    ANode: TcxTreeListNode;
    L, AIndex, I, ACount, AStrCount: Integer;
  begin
    for AIndex := 0 to AChildCount - 1 do
    begin
      ANode := AParent.AddChild;
      I := AReader.ReadInteger;
      AStream.Seek(I - 24, soFromCurrent);
      ANode.ImageIndex := AReader.ReadInteger;
      ANode.SelectedIndex := AReader.ReadInteger;
      ANode.StateIndex := AReader.ReadInteger;
      ANode.Data := Pointer(AReader.ReadInteger);
      ACount := AReader.ReadInteger;
      AStrCount := AReader.ReadInteger;
      for I := 0 to AStrCount - 1 do
      begin
        L := AReader.ReadInteger;
        SetLength(S, L);
        if L > 0 then
          AReader.Stream.ReadBuffer(S[1], L);
        ANode.Texts[I] := S;
      end;
      ConvertNodesData(ANode, ACount);
    end;
  end;

begin
  ADest.BeginUpdate;
  try
    AReader := TcxReader.Create(AStream);
    try
      ADest.Nodes.Root.DeleteChildren;
      try
        if AReader.ReadInteger = -1 then
          ConvertNodesData(ADest.Nodes.Root, AReader.ReadInteger);
      except
        ADest.Nodes.Root.DeleteChildren;
        raise;
      end;
    finally
      AReader.Free;
    end;
  finally
    ADest.EndUpdate;
  end;
end;

procedure TcxConverterFiler.DefineProperty(const Name: string; ReadData: TReaderProc;
  WriteData: TWriterProc; HasData: Boolean);
begin
end;

procedure TcxConverterFiler.DefineBinaryProperty(const Name: string;
  AReadData, AWriteData: TStreamProc; HasData: Boolean);
begin
  if Name <> 'Data' then Exit;
  FHasData := HasData;
  FReadDataProc := AReadData;
  FWriteDataProc := AWriteData;
end;

procedure TcxConverterFiler.FlushBuffer;
begin
end;

procedure TcxDXTLConverter.ImportData;
var
  AFiler: TcxConverterFiler;
  AMemStream: TMemoryStream;
begin
  AFiler := TcxConverterFiler.CreateFor(Source);
  try
    if AFiler.HasData then
    begin
      AMemStream := TMemoryStream.Create;
      try
        begin
          AFiler.WriteDataProc(AMemStream);
          AMemStream.Position := 0;
          AFiler.CreateTreeListNodes(AMemStream, Destination);
        end;
      finally
        AMemStream.Free;
      end;
    end;
  finally
    AFiler.Free;
  end;
end;

procedure TcxDXTLConverter.AssignDXOptions;
var
  AList: TStringList;
  I: Integer;
begin
  AList := TStringList.Create;
  try
    EnablePropertyException;
    try
      GetSetProperty(nil, 'Options', AList);
      AList.Sort;
      with Destination do
      begin
        OptionsCustomizing.ColumnHorzSizing := AList.Find('aoColumnSizing', I);
        OptionsCustomizing.ColumnMoving := AList.Find('aoColumnMoving', I);
        OptionsData.Editing := AList.Find('aoEditing', I);
        OptionsBehavior.GoToNextCellOnTab := AList.Find('aoTabThrough', I);
        OptionsSelection.CellSelect := not AList.Find('aoRowSelect', I);
        OptionsSelection.MultiSelect := AList.Find('aoMultiSelect', I);
        OptionsBehavior.ImmediateEditor := AList.Find('aoImmediateEditor', I);
        Preview.Visible := AList.Find('aoPreview', I);
        OptionsView.CellEndEllipsis := AList.Find('aoDrawEndEllipsis', I);
        OptionsView.ColumnAutoWidth := AList.Find('aoAutoWidth', I);
        OptionsCustomizing.BandCustomizing := AList.Find('aoExtCustomizing', I);
        OptionsCustomizing.ColumnCustomizing := OptionsCustomizing.BandCustomizing;
        OptionsBehavior.Sorting := AList.Find('aoAutoSort', I);
      end;
    except
      on EcxUnknownProperty do;
    end;
  finally
    AList.Free;
    DisablePropertyException;
  end;
end;

procedure TcxDXTLConverter.AssignDXOptionsEx;
var
  AList: TStringList;
  I: Integer;
begin
  AList := TStringList.Create;
  try
    EnablePropertyException;
    try
      GetSetProperty(nil, 'OptionsEx', AList);
      AList.Sort;
      with Destination do
      begin
        OptionsSelection.InvertSelect := AList.Find('aoInvertSelect', I);
        OptionsCustomizing.BandHorzSizing := AList.Find('aoBandSizing', I);
        OptionsCustomizing.BandVertSizing := AList.Find('aoBandPanelSizing', I);
        OptionsCustomizing.BandMoving := AList.Find('aoBandMoving', I);
        OptionsBehavior.GoToNextCellOnEnter := AList.Find('aoEnterThrough', I);
        OptionsBehavior.DragExpand := AList.Find('aoDragExpand', I);
        OptionsBehavior.DragCollapse := AList.Find('aoDragCollapse', I);
        OptionsView.CellAutoHeight := AList.Find('aoRowAutoHeight', I);
        OptionsBehavior.ShowHourGlass := AList.Find('aoShowHourGlass', I);
        OptionsCustomizing.ColumnVertSizing := AList.Find('aoHeaderPanelSizing', I);
        OptionsBehavior.MultiSort := AList.Find('aoMultiSort', I);
        OptionsView.ShowEditButtons := ConvertShowEditButtons(AList.Find('aoShowButtonAlways', I));
        OptionsBehavior.IncSearch := AList.Find('aoAutoSearch', I);
        Preview.AutoHeight := AList.Find('aoAutoCalcPreviewLines', I);
        BufferedPaint := AList.Find('aoUseBitmap', I);
      end;
    except
      on EcxUnknownProperty do;
    end;
  finally
    AList.Free;
    DisablePropertyException;
  end;
end;

function TcxDXTLConverter.GetDestination: TcxTreeList;
begin
  Result := inherited Destination as TcxTreeList;
end;

{ TcxDXDBTLConverter }

class function TcxDXDBTLConverter.GetSourceClassName: string;
begin
  Result := 'TdxDBTreeList';
end;

procedure TcxDXDBTLConverter.AssignColumn(AcxColumn: TcxTreeListColumn; AdxColumn: TObject; AIndex: Integer);
begin
  if AcxColumn is TcxDBTreeListColumn then
  with TcxDBTreeListColumn(AcxColumn) do
    DataBinding.FieldName := GetStringProperty(AdxColumn, 'FieldName');
  inherited AssignColumn(AcxColumn, AdxColumn, AIndex);
  ImportColumnSummary(AcxColumn, AdxColumn);  
end;

procedure TcxDXDBTLConverter.AssignTreeListOptions;
begin
  AssignDXOptionsBehavior;
  AssignDXOptionsCustomize;
  AssignDXOptionsDB;
  AssignDXOptionsView;
end;

function TcxDXDBTLConverter.CreateColumn: TcxTreeListColumn;
begin
  Result := Destination.CreateColumn;
end;

procedure TcxDXDBTLConverter.DoImportStyles;
var
  AColor: Integer;
  AFont: TFont;
  AStyle: TcxCustomStyle;
begin
  inherited DoImportStyles;
  AColor := GetIntegerProperty(nil, 'HeaderColor');
  AFont := GetClassProperty(nil, 'Font') as TFont;
  if (AColor <> clBtnFace) or not DefaultFont(AFont) then
  begin
    AStyle := CreateStyleItem;
    (AStyle as TcxStyle).Color := AColor;
    (AStyle as TcxStyle).Font.Assign(AFont);
    (AStyle as TcxStyle).TextColor := (AStyle as TcxStyle).Font.Color;
    Destination.Styles.Footer := AStyle as TcxStyle;
  end;
end;

procedure TcxDXDBTLConverter.DoRealImport;
begin
  with Destination.DataController do
  begin
    DataSource := GetClassProperty(nil, 'DataSource') as TDataSource;
    KeyField := GetStringProperty(nil, 'KeyField');
    ParentField := GetStringProperty(nil, 'ParentField');
  end;
  inherited DoRealImport;
end;

procedure TcxDXDBTLConverter.ImportColumn(AdxColumn: TObject; AcxColumn: TcxTreeListColumn);
begin
  if AdxColumn.ClassName = 'TdxDBTreeListColumn' then
    ImportPropertiesTextEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListMaskColumn' then
    ImportPropertiesMaskEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListButtonColumn' then
    ImportPropertiesButtonEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListDateColumn' then
    ImportPropertiesDateEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListCheckColumn' then
    ImportPropertiesCheckBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListImageColumn' then
    ImportPropertiesImageComboBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListSpinColumn' then
    ImportPropertiesSpinEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListLookupColumn' then
    ImportPropertiesLookupComboBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListPickColumn' then
    ImportPropertiesComboBox(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListCalcColumn' then
    ImportPropertiesCalcEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListBlobColumn' then
    ImportPropertiesBlobEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListHyperLinkColumn' then
    ImportPropertiesHyperLinkEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListTimeColumn' then
    ImportPropertiesTimeEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListCurrencyColumn' then
    ImportPropertiesCurencyEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListMemoColumn' then
    ImportPropertiesMemo(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListGraphicColumn' then
    ImportPropertiesImage(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListMRUColumn' then
    ImportPropertiesMRUEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListPopupColumn' then
    ImportPropertiesPopupEdit(AdxColumn, AcxColumn)
  else if AdxColumn.ClassName = 'TdxDBTreeListExtLookupColumn' then
    ImportPropertiesExLookupComboBox(AdxColumn, AcxColumn);
end;

procedure TcxDXDBTLConverter.ImportPreview;
var
  APreviewFieldName: string;
  I: Integer;
begin
  APreviewFieldName := GetStringProperty(nil, 'PreviewFieldName');
  if APreviewFieldName <> '' then
  begin
    for I := 0 to Destination.ColumnCount do
      if TestColumnFieldName(APreviewFieldName, I) then
      begin
        Destination.Preview.Column := Destination.Columns[I];
        Break;
      end;
  end;
end;

procedure TcxDXDBTLConverter.AssignDXOptionsBehavior;
var
  AList: TStringList;
  I: Integer;
begin
  AList := TStringList.Create;
  try
    EnablePropertyException;
    try
      GetSetProperty(nil, 'OptionsBehavior', AList);
      AList.Sort;
      with Destination do
      begin
        OptionsBehavior.IncSearch := AList.Find('etoAutoSearch', I);
        OptionsBehavior.Sorting := AList.Find('etoAutoSort', I);
        OptionsBehavior.DragCollapse := AList.Find('etoDragCollapse', I);
        OptionsBehavior.DragExpand := AList.Find('etoDragExpand', I);
        OptionsData.Editing := AList.Find('etoEditing', I);
        OptionsBehavior.GoToNextCellOnEnter := AList.Find('etoEnterThrough', I);
        OptionsBehavior.ImmediateEditor := AList.Find('etoImmediateEditor', I);
        OptionsSelection.MultiSelect := AList.Find('etoMultiSelect', I);
        OptionsBehavior.ShowHourGlass := AList.Find('etoShowHourGlass', I);
        OptionsBehavior.GoToNextCellOnTab := AList.Find('etoTabThrough', I);
        OptionsBehavior.AutoDragCopy := AList.Find('etoAutoDragDropCopy', I);
      end;
    except
      on EcxUnknownProperty do;
    end;
  finally
    AList.Free;
    DisablePropertyException;
  end;
end;

procedure TcxDXDBTLConverter.AssignDXOptionsCustomize;
var
  AList: TStringList;
  I: Integer;
begin
  AList := TStringList.Create;
  try
    EnablePropertyException;
    try
      GetSetProperty(nil, 'OptionsCustomize', AList);
      AList.Sort;
      with Destination do
      begin
        OptionsCustomizing.BandMoving := AList.Find('etoBandMoving', I);
        OptionsCustomizing.BandVertSizing := AList.Find('etoBandPanelSizing', I);
        OptionsCustomizing.BandHorzSizing := AList.Find('etoBandSizing', I);
        OptionsCustomizing.ColumnMoving := AList.Find('etoColumnMoving', I);
        OptionsCustomizing.ColumnHorzSizing := AList.Find('etoColumnSizing', I);
        OptionsCustomizing.BandCustomizing := AList.Find('etoExtCustomizing', I);
        OptionsCustomizing.ColumnVertSizing := AList.Find('etoHeaderPanelSizing', I);
      end;
    except
      on EcxUnknownProperty do;
    end;
  finally
    AList.Free;
    DisablePropertyException;
  end;
end;

procedure TcxDXDBTLConverter.AssignDXOptionsDB;
var
  AList: TStringList;
  I: Integer;
begin
  AList := TStringList.Create;
  try
    EnablePropertyException;
    try
      GetSetProperty(nil, 'OptionsDB', AList);
      AList.Sort;
      with Destination do
      begin
        OptionsData.CancelOnExit := AList.Find('etoCancelOnExit', I);
        OptionsData.Deleting := AList.Find('etoCanDelete', I);
        OptionsData.Inserting := AList.Find('etoCanInsert', I);
        OptionsBehavior.ConfirmDelete := AList.Find('etoConfirmDelete', I);
      end;
    except
      on EcxUnknownProperty do;
    end;
  finally
    AList.Free;
    DisablePropertyException;
  end;
end;

procedure TcxDXDBTLConverter.AssignDXOptionsView;
var
  AList: TStringList;
  I: Integer;
begin
  AList := TStringList.Create;
  try
    EnablePropertyException;
    try
      GetSetProperty(nil, 'OptionsView', AList);
      AList.Sort;
      with Destination do
      begin
        Preview.AutoHeight := AList.Find('etoAutoCalcPreviewLines', I);
        OptionsView.ColumnAutoWidth := AList.Find('etoAutoWidth', I);
        OptionsView.CellEndEllipsis := AList.Find('etoDrawEndEllipsis', I);
        OptionsView.Indicator := AList.Find('etoIndicator', I);
        OptionsSelection.InvertSelect := AList.Find('etoInvertSelect', I);
        Preview.Visible := AList.Find('etoPreview', I);
        OptionsView.CellAutoHeight := AList.Find('etoRowAutoHeight', I);
        OptionsSelection.CellSelect := not AList.Find('etoRowSelect', I);
        OptionsView.ShowEditButtons := ConvertShowEditButtons(AList.Find('etoShowButtonAlways', I));
        BufferedPaint := AList.Find('etoUseBitmap', I);
      end;
    except
      on EcxUnknownProperty do;
    end;
  finally
    AList.Free;
    DisablePropertyException;
  end;
end;

function TcxDXDBTLConverter.ConvertFooterKind(AValue: string): TcxSummaryKind;
begin
  if AValue = 'cstAvg' then
    Result := skAverage
  else if AValue = 'cstCount' then
    Result := skCount
  else if AValue = 'cstMax' then
    Result := skMax
  else if AValue = 'cstMin' then
    Result := skMin
  else if AValue = 'cstSum' then
    Result := skSum
  else
    Result := skNone;
end;

function TcxDXDBTLConverter.GetDestination: TcxDBTreeList;
begin
  Result := inherited Destination as TcxDBTreeList;
end;

procedure TcxDXDBTLConverter.ImportColumnSummary(AcxColumn: TcxTreeListColumn; AdxColumn: TObject);
begin
  with (AcxColumn as TcxDBTreeListColumn).SummaryFooter do
  begin
    Kind := ConvertFooterKind(GetEnumProperty(AdxColumn, 'SummaryFooterType'));
    if Kind <> skNone then
      (AcxColumn as TcxDBTreeListColumn).Options.Footer := True;
    FieldName := GetStringProperty(AdxColumn, 'SummaryFooterField');
    Format := GetStringProperty(AdxColumn, 'SummaryFooterFormat');
  end;
end;

function TcxDXDBTLConverter.TestColumnFieldName(AFieldName: string; AIndex: Integer): Boolean;
begin
  Result := Destination.Columns[AIndex].DataBinding.FieldName = AFieldName;
end;

initialization
  ConverterFactory(cxTLGroupConverterName).RegisterConverter('DX TreeList Converter', TcxDXTLConverter);
  ConverterFactory(cxDBTLGroupConverterName).RegisterConverter('DX DBTreeList Converter', TcxDXDBTLConverter);

end.
