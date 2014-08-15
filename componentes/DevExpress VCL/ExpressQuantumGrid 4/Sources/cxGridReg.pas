{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridReg;

{$I cxGridVer.inc}

interface

const
  cxGridVersion = '4.54';

procedure Register;

implementation

uses
{$IFDEF DELPHI6}
  Types, DesignIntf, DesignEditors,
    VCLEditors,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  cxGridImportDialog,
  TypInfo, Classes, SysUtils, Controls, Graphics, ExtCtrls,
{$IFNDEF NONDB}
  DB, cxDBData, cxGridDBDataDefinitions, cxGridDBTableView, cxGridDBBandedTableView,
  cxGridDBCardView, cxDBExtLookupComboBox,
{$ENDIF}
  cxPropEditors, cxEditPropEditors,
  cxCustomData,
  cxEdit, cxEditRepositoryItems,
  cxGridCommon, cxGrid, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView,
  cxGridTableView,
  cxGridBandedTableView,
  cxGridCardView,
  cxControls,
  cxGridStructureNavigator, cxGridEditor,
  cxStyles, cxEditRepositoryEditor, cxGridStrs;

const
  UnitNamePrefix = '';

type
  TcxCustomGridViewAccess = class(TcxCustomGridView);
  TcxCustomGridTableItemAccess = class(TcxCustomGridTableItem);
  TcxCustomGridTableViewAccess = class(TcxCustomGridTableView);
{$IFNDEF NONDB}
  TcxGridDBTableViewAccess = class(TcxGridDBTableView);
{$ENDIF}
  TcxCustomDataSummaryItemAccess = class(TcxCustomDataSummaryItem);

{ TGridEditor }

type
  TGridEditor = class(TComponentEditor)
  private
    function GetGrid: TcxCustomGrid;
  protected
    property Grid: TcxCustomGrid read GetGrid;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function TGridEditor.GetGrid: TcxCustomGrid;
begin
  Result := TcxCustomGrid(Component);
end;

procedure TGridEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    0: ShowGridEditor(Designer, Grid);
    1: ShowGridImportDialog(Designer, Grid);
  end;
end;

function TGridEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Editor...';
    1: Result := 'Import...';
    2: Result := '-';
    3: Result := 'ExpressQuantumGrid Suite ' + cxGridVersion;
    4: Result := 'www.devexpress.com';
  end;
end;

function TGridEditor.GetVerbCount: Integer;
begin
  Result := 2 + 3;
end;

{ TGridViewRepositoryEditor }

type
  TGridViewRepositoryEditor = class(TComponentEditor)
  private
    function GetGridViewRepository: TcxGridViewRepository;
  protected
    property GridViewRepository: TcxGridViewRepository read GetGridViewRepository;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function TGridViewRepositoryEditor.GetGridViewRepository: TcxGridViewRepository;
begin
  Result := TcxGridViewRepository(Component);
end;

procedure TGridViewRepositoryEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    //0: GridViewRepository.CreateItem(TcxGridDBTableView).Name := Designer.UniqueName('cxGridDBTableView');
    0: ShowViewRepositoryEditor(Designer, GridViewRepository);
  end;
end;

function TGridViewRepositoryEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    //0: Result := 'Create TcxGridDBTableView';
    0: Result := 'Editor...';
    1: Result := '-';
    2: Result := 'ExpressQuantumGrid Suite ' + cxGridVersion;
    3: Result := 'www.devexpress.com';
  end;
end;

function TGridViewRepositoryEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

{ TcxGridRootLevelStylesEventsProperty }

type
  TcxGridRootLevelStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridRootLevelStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGrid(GetComponent(0)).RootLevelStyles;
end;

{ TcxGridTableItemPropertiesEventsProperty }

type
  TcxGridTableItemPropertiesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridTableItemPropertiesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridTableItemAccess(GetComponent(0)).Properties;
end;

{ TcxGridTableItemStylesEventsProperty }

type
  TcxGridTableItemStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridTableItemStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridTableItemAccess(GetComponent(0)).Styles;
end;

{ TcxGridDataControllerEventsProperty }

type
  TcxGridDataControllerEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridDataControllerEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridView(GetComponent(0)).DataController;
end;

{ TcxGridStylesEventsProperty }

type
  TcxGridViewStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridViewStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridViewAccess(GetComponent(0)).Styles;
end;

{ TcxGridLevelStylesEventsProperty }

type
  TcxGridLevelStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridLevelStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridLevel(GetComponent(0)).Styles;
end;

{ TcxGridBandStylesEventsProperty }

type
  TcxGridBandStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridBandStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridBand(GetComponent(0)).Styles;
end;

(*{ TcxGridOptionsProperty }

type
  TcxGridOptionsProperty = class(TComponentProperty)
  public
    function AllEqual: Boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  end;

function TcxGridOptionsProperty.AllEqual: Boolean;
begin
  Result := {inherited AllEqual;//}True;
end;

function TcxGridOptionsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := {inherited GetAttributes;//}[paMultiSelect, paSubProperties, paReadOnly, paVolatileSubProperties];
  {Result := inherited GetAttributes - [paValueList, paSortList, paRevertable] +
    [paReadOnly];}
end;

procedure TcxGridOptionsProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
  J: Integer;
  Components: IDesignerSelections;
begin
  inherited;
  {Components := TDesignerSelections.Create;
  for I := 0 to PropCount - 1 do
  begin
    J := GetOrdValueAt(I);
    if J <> 0 then
      Components.Add(TComponent(GetOrdValueAt(I)));
  end;
  if Components.Count > 0 then
    GetComponentProperties(Components, tkAny, Designer, Proc);}
end;

function TcxGridOptionsProperty.GetValue: string;
begin
  Result := '[Options]';
end;*)

{ TcxCustomGridTableItemPropertiesProperty }

type
  TcxCustomGridTableItemPropertiesProperty = class(TClassProperty)
  protected
    function HasSubProperties: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

function TcxCustomGridTableItemPropertiesProperty.HasSubProperties: Boolean;
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
  begin
    Result := TcxCustomGridTableItem(GetComponent(I)).Properties <> nil;
    if not Result then Exit;
  end;
  Result := True;
end;

function TcxCustomGridTableItemPropertiesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, paSubProperties);
  Result := Result - [paReadOnly] +
    [paValueList, paSortList, paRevertable{$IFDEF DELPHI6}, paVolatileSubProperties{$ENDIF}];
end;

function TcxCustomGridTableItemPropertiesProperty.GetValue: string;
begin
  if HasSubProperties then
    Result := GetRegisteredEditProperties.GetDescriptionByClass(TcxCustomEditProperties(GetOrdValue).ClassType)
    //Result := TcxCustomEditProperties(GetOrdValue).ClassName
  else
    Result := '';
end;

procedure TcxCustomGridTableItemPropertiesProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GetRegisteredEditProperties.Count - 1 do
    Proc(GetRegisteredEditProperties.Descriptions[I]);
end;

procedure TcxCustomGridTableItemPropertiesProperty.SetValue(const Value: string);
var
  APropertiesClass: TcxCustomEditPropertiesClass;
  I: Integer;
begin
  APropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByClassName(Value));
  if APropertiesClass = nil then
    APropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByDescription(Value));
{$IFNDEF DELPHI7}
  if GetValue <> Value then
    ObjectInspectorCollapseProperty;
{$ENDIF}
  for I := 0 to PropCount - 1 do
    TcxCustomGridTableItem(GetComponent(I)).PropertiesClass := APropertiesClass;
  Modified;
end;

{$IFNDEF NONDB}

type
  TcxDBDataSummaryItemFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

function TcxDBDataSummaryItemFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := (GetComponent(0) as TcxDBDataSummaryItem).DataController.DataSource;
end;

type
  TcxGridItemDBDataBindingAccess = class(TcxGridItemDBDataBinding);

  TcxGridItemDBDataBindingFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

function TcxGridItemDBDataBindingFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxGridItemDBDataBindingAccess(GetComponent(0) as TcxGridItemDBDataBinding).DataController.DataSource;
end;

type
  TMasterKeyFieldNamesProperty = class(TFieldNameProperty)
    function GetDataSource: TDataSource; override;
  end;

function TMasterKeyFieldNamesProperty.GetDataSource: TDataSource;
var
  AIDataController: IcxCustomGridDataController;
  AParentLevel: TcxGridLevel;
begin
  Result := nil;
  (GetComponent(0) as TcxCustomDataController).GetInterface(IcxCustomGridDataController, AIDataController);
  if AIDataController <> nil then
  begin
    AParentLevel := AIDataController.GridView.Level as TcxGridLevel;
    if AParentLevel <> nil then
      AParentLevel := AParentLevel.Parent;
    if (AParentLevel <> nil) and (AParentLevel.GridView <> nil) and
      (AParentLevel.GridView.DataController is TcxDBDataController) then
      Result := (AParentLevel.GridView.DataController as TcxDBDataController).DataSource;
  end;
end;

{$ENDIF}

{ TcxCustomGridTableItemProperty }

type
  TcxCustomGridTableItemProperty = class(TComponentProperty)
  protected
    function GetGridView: TcxCustomGridView;
    procedure GetGridViewItemNames(AGridView: TcxCustomGridView; Proc: TGetStrProc); virtual;
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; virtual; abstract;
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TcxCustomGridTableItemProperty.GetValues(Proc: TGetStrProc);
var
  AGridView: TcxCustomGridView;
begin
  AGridView := GetGridView;
  if AGridView <> nil then
    GetGridViewItemNames(AGridView, Proc);
end;

function TcxCustomGridTableItemProperty.GetGridView: TcxCustomGridView;
var
  I: Integer;
begin
  Result := InternalGetGridView(GetComponent(0));
  for I := 1 to PropCount - 1 do
    if InternalGetGridView(GetComponent(I)) <> Result then
    begin
      Result := nil;
      Break;
    end;
end;

procedure TcxCustomGridTableItemProperty.GetGridViewItemNames(AGridView: TcxCustomGridView;
  Proc: TGetStrProc);
var
  I: Integer;
begin
  if AGridView is TcxCustomGridTableView then
    with AGridView as TcxCustomGridTableView do
      for I := 0 to ItemCount - 1 do
        Proc(Designer.GetComponentName(Items[I]));
end;

{ TcxGridPreviewColumnProperty }

type
  TcxGridPreviewColumnProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

function TcxGridPreviewColumnProperty.InternalGetGridView(APersistent: TPersistent):
  TcxCustomGridView;
begin
  Result := TcxGridPreview(APersistent).GridView;
end;

{ TcxGridTableSummaryItemColumnProperty }

type
  TcxGridTableSummaryItemColumnProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

function TcxGridTableSummaryItemColumnProperty.InternalGetGridView(APersistent: TPersistent):
  TcxCustomGridView;
begin
  Result :=(TcxCustomDataSummaryItemAccess(APersistent).GetDataController as
    IcxCustomGridDataController).GridView;
end;

{$IFNDEF NONDB}

{ Ext Lookup }

type
  TcxExtLookupComboBoxPropertiesFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  TcxExtLookupComboBoxPropertiesItemColumnProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

  TcxExtLookupComboBoxPropertiesViewProperty = class(TComponentProperty)
  private
    FProc: TGetStrProc;
    procedure CheckComponent(const Value: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TcxExtLookupComboBoxPropertiesFieldNameProperty.GetDataSource: TDataSource;
var
  AProperties: TcxExtLookupComboBoxProperties;
begin
  AProperties := GetComponent(0) as TcxExtLookupComboBoxProperties;
  if AProperties.DataController <> nil then
    Result := AProperties.DataController.DataSource
  else
    Result := nil;
end;

function TcxExtLookupComboBoxPropertiesItemColumnProperty.InternalGetGridView(APersistent: TPersistent): TcxCustomGridView;
var
  AProperties: TcxExtLookupComboBoxProperties;
begin
  AProperties := APersistent as TcxExtLookupComboBoxProperties;
  Result := AProperties.View;
end;

procedure TcxExtLookupComboBoxPropertiesViewProperty.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(CheckComponent);
end;

procedure TcxExtLookupComboBoxPropertiesViewProperty.CheckComponent(const Value: string);
var
  AView: TcxCustomGridTableView;
begin
  AView := TcxCustomGridTableView(Designer.GetComponent(Value));
  if (AView <> nil) and TcxExtLookupComboBoxProperties.IsViewSupported(AView) then
    FProc(Value);
end;

{$ENDIF}

{$IFDEF DELPHI6}

type
  TcxGridSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxGridLevelSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomTableViewSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomDBTableViewSelectionEditor = class(TcxCustomTableViewSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomGridTableItemSelectionEditor = class(TSelectionEditor)
  private
    FProc: TGetStrProc;
    procedure GetGridTableItem(const S: string);
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TcxGridSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc(UnitNamePrefix + 'cxStyles');
end;

procedure TcxGridLevelSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc(UnitNamePrefix + 'cxStyles');
end;

procedure TcxCustomTableViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc(UnitNamePrefix + 'cxStyles');
  Proc('cxCustomData');
  Proc(UnitNamePrefix + 'cxGraphics');
  Proc('cxFilter');
  Proc('cxData');
  Proc('cxDataStorage');
  Proc(UnitNamePrefix + 'cxEdit');
end;

procedure TcxCustomDBTableViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('DB');
  Proc('cxDBData');
end;

procedure TcxCustomGridTableItemSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  FProc := Proc;
  Designer.GetComponentNames(GetTypeData(PTypeInfo(TcxCustomGridTableItem.ClassInfo)),
    GetGridTableItem);
end;

procedure TcxCustomGridTableItemSelectionEditor.GetGridTableItem(const S: string);
var
  AItem: TcxCustomGridTableItem;
begin
  AItem := TcxCustomGridTableItem(Designer.GetComponent(S));
  if AItem.Properties <> nil then
    FProc({UnitNamePrefix + }GetTypeData(PTypeinfo(AItem.Properties.ClassType.ClassInfo)).UnitName);
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponentEditor(TcxGrid, TGridEditor);
  RegisterComponentEditor(TcxGridViewRepository, TGridViewRepositoryEditor);

  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGrid, 'RootLevelStylesEvents',
    TcxGridRootLevelStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridTableItem, 'PropertiesEvents',
    TcxGridTableItemPropertiesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridTableItem, 'StylesEvents',
    TcxGridTableItemStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridView, 'DataControllerEvents',
    TcxGridDataControllerEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridView, 'StylesEvents',
    TcxGridViewStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridLevel, 'StylesEvents',
    TcxGridLevelStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridBand, 'StylesEvents',
    TcxGridBandStylesEventsProperty);

  RegisterPropertyEditor(TypeInfo(string), TcxCustomGridTableItem, 'PropertiesClassName', nil);
  RegisterPropertyEditor(TypeInfo(TcxCustomEditProperties), TcxCustomGridTableItem,
    'Properties', TcxCustomGridTableItemPropertiesProperty);
  RegisterPropertyEditor(TypeInfo(TAlignment), TcxGridBand, 'Alignment', nil);

  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridPreview,
    'Column', TcxGridPreviewColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridTableSummaryItem,
    'Column', TcxGridTableSummaryItemColumnProperty);
{$IFNDEF NONDB}
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridDBTableSummaryItem,
    'Column', TcxGridTableSummaryItemColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridDBBandedTableSummaryItem,
    'Column', TcxGridTableSummaryItemColumnProperty);
{$ENDIF}    
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridTableSummaryGroupItemLink,
    'Column', TcxGridTableSummaryItemColumnProperty);

{$IFNDEF NONDB}
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataController, 'DetailKeyFieldNames', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataController, 'KeyFieldNames', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataController, 'MasterKeyFieldNames', TMasterKeyFieldNamesProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataSummaryItem, 'FieldName', TcxDBDataSummaryItemFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxGridItemDBDataBinding, 'FieldName', TcxGridItemDBDataBindingFieldNameProperty);
{$ENDIF}

  RegisterNoIcon([TcxGridLevel,
    TcxGridTableView, {$IFNDEF NONDB}TcxGridDBTableView,{$ENDIF}
    TcxGridBandedTableView, {$IFNDEF NONDB}TcxGridDBBandedTableView,{$ENDIF}
    TcxGridCardView{$IFNDEF NONDB}, TcxGridDBCardView{$ENDIF}]);
  RegisterNoIcon([
    TcxGridColumn, {$IFNDEF NONDB}TcxGridDBColumn,{$ENDIF}
    TcxGridBandedColumn, {$IFNDEF NONDB}TcxGridDBBandedColumn,{$ENDIF}
    TcxGridCardViewRow{$IFNDEF NONDB}, TcxGridDBCardViewRow{$ENDIF}]);
  RegisterNoIcon([TcxGridTableViewStyleSheet, TcxGridBandedTableViewStyleSheet, TcxGridCardViewStyleSheet]);
  RegisterComponents('Dev Express', [TcxGrid, TcxGridViewRepository]);
  // Ext Lookup
{$IFNDEF NONDB}
  RegisterComponents('Express Editors 4', [TcxExtLookupComboBox]);
  RegisterComponents('Express DBEditors 4', [TcxDBExtLookupComboBox]);
  RegisterEditRepositoryItem(TcxEditRepositoryExtLookupComboBoxItem, cxSEditRepositoryExtLookupComboBoxItem);
  RegisterPropertyEditor(TypeInfo(string), TcxExtLookupComboBoxProperties, 'KeyFieldNames', TcxExtLookupComboBoxPropertiesFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxExtLookupComboBoxProperties, 'ListFieldItem', TcxExtLookupComboBoxPropertiesItemColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableView), TcxExtLookupComboBoxProperties, 'View', TcxExtLookupComboBoxPropertiesViewProperty);
  // TODO CLX
  RegisterPropertyEditor(TypeInfo(TShortCut), TcxExtLookupComboBoxProperties, 'ClearKey', TShortCutProperty);
{$ENDIF}

{$IFDEF DELPHI6}
  RegisterSelectionEditor(TcxCustomGrid, TcxGridSelectionEditor);
  RegisterSelectionEditor(TcxGridLevel, TcxGridLevelSelectionEditor);
  RegisterSelectionEditor(TcxCustomGridTableView, TcxCustomTableViewSelectionEditor);
{$IFNDEF NONDB}
  RegisterSelectionEditor(TcxGridDBTableView, TcxCustomDBTableViewSelectionEditor);
  RegisterSelectionEditor(TcxGridDBBandedTableView, TcxCustomDBTableViewSelectionEditor);
  RegisterSelectionEditor(TcxGridDBCardView, TcxCustomDBTableViewSelectionEditor);
{$ENDIF}
  RegisterSelectionEditor(TcxCustomGridTableItem, TcxCustomGridTableItemSelectionEditor);
{$ENDIF}
end;

initialization
{$IFDEF DELPHI6}
  StartClassGroup(TControl);
  GroupDescendentsWith(TcxGrid, TControl);
  GroupDescendentsWith(TcxGridViewRepository, TControl);
  GroupDescendentsWith(TcxGridLevel, TControl);
  GroupDescendentsWith(TcxCustomGridView, TControl);
  GroupDescendentsWith(TcxCustomGridTableItem, TControl);
  GroupDescendentsWith(TcxGridItemDataBinding, TControl);
{$ENDIF}
  RegisterStyleSheetClass(TcxGridTableViewStyleSheet);
  RegisterStyleSheetClass(TcxGridBandedTableViewStyleSheet);
  RegisterStyleSheetClass(TcxGridCardViewStyleSheet);

finalization
  UnregisterStyleSheetClass(TcxGridCardViewStyleSheet);
  UnregisterStyleSheetClass(TcxGridBandedTableViewStyleSheet);
  UnregisterStyleSheetClass(TcxGridTableViewStyleSheet);

end.
